Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB44C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 14:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BA610E196;
	Tue, 23 Apr 2024 14:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RffB2h1e";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD0410E196
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 14:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihWMhsUX6CoFF5Kk/merdkuRGmzZyms4bcEbBSdak8Abi4tE1kRqcXCJHLkr5tZOX/bePq8cRBmBWpHcHhLs6UKkaCP8dN2wYUhovhrDc4VqtkHQqJAnMakQc1qjLGxPNwU/t/5qzEb+EX5Gb0fxmC7WxdDunCcaAm2Mh3QdkdDExX55nPAwE6qwH05BPYry1fsuQ+SKJ1oFWJP5XRDYszzchDd5aKZvfCoaZ1nGS35QLkcs5pZ3V2WuaFDOzrh5UnwpqropRthD/jB1sPDEKLuIBZY6180FsgBPd//859lZWdr1L4tEJeXGMZPHe97/bMFx92tTgMF9fNtwLbKoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFag+CO0+Dja6mdMOY/PVKLHPYccYtuxtvZUOVELPf0=;
 b=S67krhrbgOyPKu6rWIV/+HQBaR3dol/ixINhXZ9hPauCp2aXCqmh04FE3V5QkXGrzujtVYWSQrZtA0x2S7H+Xm+F522QMRhp21jtU5Nbw9qgxkgHGn8W2rYaiI/NKr6ebM2hVExLlk098PC4AFYaQw9TQfQpErA11HjrCXGbZLcVs5JBqoLabC7neiVx8GGqKWkNi26/81RqNStYUzUqoHjudS8bOhW/J+kavyUNU2K9yjgfhaR/pPpSr7e2umMQX7kHdrZ3UAflY12HDfYRudqsJHBO3bx2zOfNJ0R4TvLwxbPvFBC82nbCzh5QpXJMsD2WXzQZs7cNex+0lL7H/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFag+CO0+Dja6mdMOY/PVKLHPYccYtuxtvZUOVELPf0=;
 b=RffB2h1el/gbprwX3q831ALWBoyLdat4zK5ey7pzLHbcu2xH9w/6kEEt12a+0gq85HbHvMSjplqmarOcTPKypAs4F8mdQIbD0n19ttpDkkVXjfBLnE2r5sAGvPWKd3gmqkHU7dev6DmqYw7fj7wiK61TqpZ/lDjpHUXrDIsv0dw=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 14:23:30 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 14:23:30 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Topic: [PATCH v2] drm/amdgpu: fix uninitialized scalar variable warning
Thread-Index: AQHalVpxpJeH45TQUEOTy2uy21iYgrF1uGEAgAAvRpA=
Date: Tue, 23 Apr 2024 14:23:30 +0000
Message-ID: <CH3PR12MB8074E73316E499688053D956F6112@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240423084358.1285658-1-tim.huang@amd.com>
 <e53548e9-6c51-4dc7-9155-201161b372c9@amd.com>
In-Reply-To: <e53548e9-6c51-4dc7-9155-201161b372c9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ffc2ce96-8f3c-41f2-aaf5-89c86dc17740;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T14:18:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|PH8PR12MB6985:EE_
x-ms-office365-filtering-correlation-id: ffc67e95-b1f0-48cb-13d7-08dc63a0f2f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?Y21CNDhwSlljN2ViejFwY3kzSWFuN1NxTTNVaFQ4a3lleFVncjFpMHE0WGNM?=
 =?utf-8?B?UVkzRytSaDVQcG5WVWdaT1ZOY01lTnhUQkxmZEMwMmNWT05rMlFCWkswLzBx?=
 =?utf-8?B?UUlpTGdzSHo4UWg2a3ZGUGcwcjQ5dWFFTVA5Q2Jndnd4VUNvaldNVWNNK2Fr?=
 =?utf-8?B?a3A2VFk5UmhnZis2LzZJV0duSzdlWGFGZFEzNjY3a3JTQW0yaUxSZmsxaEVZ?=
 =?utf-8?B?SzNUYjhJa2Y3UzF5citYTVVQRW5CeE42Um9qRnMxb3ZxVEdpNmo5QWFMWjA5?=
 =?utf-8?B?Zy9DU20zQU5ObHdQY3VFNTU2aDNUNDhIM3Zxc1ZTUlJBUlE1RU1uSDV2K05z?=
 =?utf-8?B?YzhsRjI2UnFvRlF2dTJUeC9TN2tXTUEwa3J4R2Zuck1LMFBldHZ0b1R6TzFv?=
 =?utf-8?B?bStTaHd5bWxQelIzMEE4Uy9hcStwcjdXQlNqdVAwQk9sTUlVUC9WemlQbmhn?=
 =?utf-8?B?ZzR4QzIzVXppcDc3cW9oUWkzekIyM1pqc01uRytTd1ZjM3psY2hoUEV1dGM4?=
 =?utf-8?B?OGplZXRZMGpzTFh1ZFZ1SUp6bm1rWGtPdFh4N0JtSWovZFpxcU5xMjVGY1ZK?=
 =?utf-8?B?OUkrdHVMcGhpU0lQMEZLMkMrcFFCYnVKSlovbHg3UDdUSVV1UDZRbTZRN3c0?=
 =?utf-8?B?dCtjbVNZMmZES0VIUDRaNGkzbUJtTHM0eWRDa1NWeThmdnlYcCtKUFdjNDJr?=
 =?utf-8?B?L0NNREZ5L0pvVEdOWEE5NkpNUk5qblFDV3V1bWJaTmRINlhQWTdYUkVmbkR2?=
 =?utf-8?B?dU02WFk4U2hKd3lxb2liMlFMTUJic2NyYnZzd01XTlpHdStYWDdHSmY4eDEr?=
 =?utf-8?B?amQ5ZXg2N2orRGpjSFhNcFNaNXpWR1NjTE9Jb09uK3c1cmRxekFWZU5QdTJE?=
 =?utf-8?B?dWtrUmFFb3cwTTVMbEZYMkpYM1JSN3BmZkptWFYzRDZnOU5aUHBUV0xzNWFu?=
 =?utf-8?B?UkpBVlFZOVpZL3VBYldoYmFQUHgvbHpNbjViNW9vUU9iNlUyT0liRUhpb2xO?=
 =?utf-8?B?MmdFbFdCSUlBMmw3R1F2ME5QRVdIWnpIb0xBYU8zUzV3dDRnUVNmK1IrY0M0?=
 =?utf-8?B?MVdzSnVDZGl0QnNDSFBJQ1pRSXo3Z3NxOUNLOVBnSkpodFhrMW9YM3VVTi9j?=
 =?utf-8?B?K2ZSa2p2QVVaVHY4U0ovNlBQSTB6MHpDUWxIb2tFTDc1czd0dUdaRW0vVHdp?=
 =?utf-8?B?SlpWYUFaNmRvZWxtRnhnRmFOK1IzOThYcVAwWklRK0s1alpMYURGR1ZFeTVt?=
 =?utf-8?B?VzIwZUorZURDSlBZRFZROHFwODdOQXYzTUxwYk5qaHNPUytDOHFScVpLcm1M?=
 =?utf-8?B?Wml6bWxDV1VZbllnam56UVRIUVIvRlNvenNUM1U5UTBBZmRDcmV5Z0VYUFV4?=
 =?utf-8?B?Q3JYRUNpYUR1c3RnRlN1WUNXTTZ2TDBEeTJWTGYvL2JWYVJyZnFZeEI1czJU?=
 =?utf-8?B?L1ErWXdJUnArWElhY3h0ZTE1RS80SGJWc2JvaG5iRUlhb2JQME5zMzRiQkth?=
 =?utf-8?B?WHVTTzB2ZU55WGlIMUJSaTRRSHh4WkhXeUpmK1lHOWNhNEtrVHJCNFNqWUZi?=
 =?utf-8?B?Mzhoc3RVdVFPaWJ5NHN2b2ZzZ216Qm52amNkREdHMUJlbDdQZUhxbTlLSUhs?=
 =?utf-8?B?dkllMENwa3VneTJJUkdpYm9zL2NPNHpGV21tYnc5WUd6cElPVFFwMHpaa0xT?=
 =?utf-8?B?akEveUJodDZyUWoxZFU1OFR0WGxTOEZaMVVvR2pEWi92Nkp4QnovUWM4UkNz?=
 =?utf-8?B?QVlOVjNNRGVzWWlmRHhlTC94eURuOUVlNWJkak1GRzBRV2ZQV3ExWE02WTQ1?=
 =?utf-8?B?MmRGUG5FUmhLbjJwcXh1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUtjUlI2YVlUZUpicDQ0anlvUVdGSUwrYkRMOXVTalFDdWM3dWZVV2xneGJB?=
 =?utf-8?B?MXJUZDFZQ1B3a0JSWmE0ckFNaTUwY0kyTHhzbUtidWE0elhQRnQ1cFNkN1VX?=
 =?utf-8?B?TU8wZUt1OFY0VzA4eUN0T3VTMktYZ1JtRmMraitwUjhEdFBaZlQwdXhORnho?=
 =?utf-8?B?NXI0MjZmYkkxVjRIRTh0UzdIbXh4QUx4Y21mYk1kejVRcjFLNkdDUVQzUURa?=
 =?utf-8?B?bDdjK0owV3JEd3lKZ3RFN1hublhKSFNLSkhPNnFCOGFSS2lpVlZaaHBDb1BJ?=
 =?utf-8?B?MFBDN3k1VTIvY3hXZGZ5VkFGVGw4UDBJc0l3SGw0TWErU2U3TDhFWDZMU0N6?=
 =?utf-8?B?c3dyMWorVnZVV1FLZEZ4TzUwcWxZSmRwNk1yN2NwR1J3WFlXVzF2RWlrMGRa?=
 =?utf-8?B?UmN6eWZGcmcyS3ZKbVFsYUpwazRCOTE4aGJWa2lmeHAyV2VqZitzb3J5OWpP?=
 =?utf-8?B?eUt2NWZ2aDh1Nk1uVnBySEl3K2pvdStFZTNBb3d0YzlJMWlaMDFucC96YXIv?=
 =?utf-8?B?TlBTOTZHcTd0eE0rOWl3SmMvVDlzTnF1Nk1URUNEeGM1MEd3MlZubzZZR2Jk?=
 =?utf-8?B?eXRFais2Mm1NWGJyYWhHWHNBRlVZeTZxVStNSkgvRTJWR1JSM0V6SHBLelNB?=
 =?utf-8?B?RTdPRlhxbGNoTWJzR0ZTMmg2NHRwaVZpeitDQWNkYWthbmo5cC9kNWVXeW0z?=
 =?utf-8?B?R1lHUUxVU0dZU1JIYVp4M0w3OVdRUFB2azF5UUs4M0tjZEhrYWlSbmdWV2I4?=
 =?utf-8?B?K0d5YXY3aEhLcnUxeFFFdVhVYnhDUTRDREdXTlRhS1FjVFk5RlQ3NzNFYXFI?=
 =?utf-8?B?b0x3TUlwYU83dlROdkQ1b3djejdZRXg0aDhHVEZHcllILytYT0RaNDZiODNH?=
 =?utf-8?B?WUhjd2FDdUROTG1oSTdKQXNpYUpRVTJ1OVk1enNYOUQ4akF2UERMeERadSsr?=
 =?utf-8?B?MDNsNVlDYVhTcWdWcEw3TWhNVDVUeEhuZmREemZoK1VjcmI1bzkxSVVhcnMx?=
 =?utf-8?B?ZHM3aDhLd29NWFMveWplNDY1OEhjWGpUNVBzT3c5Ym8vNlY0R0xXbFFyMGdU?=
 =?utf-8?B?Y0FkaXVwZHAwdzFINVNSTVp5cnk4V0l2S05pSHhnL1FsT3ZZcE9oYzdTSHBJ?=
 =?utf-8?B?MFdmQ3MxS2N4MWRrdmNXVnRpRUFldWZ4UXE0M0ZJVmp3VmZVdWJKb0w4YTd4?=
 =?utf-8?B?KzZwbmFCS25OMDZuRVdIajFuZTd5OUlZUHV1VVZlakg2bW9rNzVQcnRCbnBX?=
 =?utf-8?B?QzFid1pDd3dlVURxUEs5VzQrRzZRdDRFOFdiM0xqQjNjb1A0aXJXWTJKY2hr?=
 =?utf-8?B?cytzV2s4YmZYNGxlMWxhTTBrai9kcXhTQTdVRW9mQ05kZTNhN1RncGw1QVlr?=
 =?utf-8?B?ZmZWME1IUVVHMURJK0o5MEt0MFBRMUVGbFNYRVhoOXJxcHl1bWNVQ0ZhOG5J?=
 =?utf-8?B?bFRGcDdqVlRWY0gvWlV6M3dwRHFjMmNKeWUwZHZkbTRvam9MbVlUVTBCU3l2?=
 =?utf-8?B?cWR1aFZscThYeTF3OTFvb3dRNk95bnQvWFNZSkNPQThHRlZhM0kvYjRIZ1pZ?=
 =?utf-8?B?N0YyK0Q1WFpCRlAyaGNOalRXSTlrdDRiNW1XdDMvNkNSUzB4Qm5jNEdBQTRY?=
 =?utf-8?B?RS9ZTU4yOGY3YnB5OTJKMDlQNC9sUzgvRFVweHhITEVTVithUVZubEdPSlpX?=
 =?utf-8?B?MEpjcWxiWnVhU2VFUWRpVVBGSHhRSlludUxqeEpBakdoQ2JJK2pwWDB2VHVY?=
 =?utf-8?B?anNlelZKWjMrVUZOU1I4UkJJOUkvMUF3eForeTdUcm1wZ0dGQkFYMTVNZy93?=
 =?utf-8?B?c2tGNjRiZGZOUDR6YW95VzAxVW5tUVBqektFR25LY0dhWThhUWVmRm01ZWVu?=
 =?utf-8?B?RVBiQ0RBekxrSDc2NHVrUERoTGJhdWltbkFFcFZjK1ZJa2Z3RUxDd2NudEp4?=
 =?utf-8?B?eDE1VUI1aHFiQytXandybGhyQ1FrS3hvY1NIZDcrZytDNWpmZlEwS3B0QXZ3?=
 =?utf-8?B?aDBnMmtxbmQyejR5RFQ2WGc4RkhzM3FtTEhjSXl3Y1VjMWRRNXcrVFJOYStY?=
 =?utf-8?B?SDJCVVBxYlZXRTR6SXE4NUpPOE1VcEhZVjRKM2NxUE9oWVhBbHZDZ0F5V2dR?=
 =?utf-8?Q?o7mI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc67e95-b1f0-48cb-13d7-08dc63a0f2f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 14:23:30.1354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iqj+TMh+tUruG1Ss8TvZIWSze5DWYeABRKAdb9MlxiqgG4kD/FwvKdTUWGNYJnPqAwdQVXwv8yL+4905h+eqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29t
Pg0KU2VudDogVHVlc2RheSwgQXByaWwgMjMsIDIwMjQgNzozMCBQTQ0KVG86IEh1YW5nLCBUaW0g
PFRpbS5IdWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBmaXggdW5pbml0aWFsaXplZCBzY2FsYXIgdmFyaWFi
bGUgd2FybmluZw0KDQpBbSAyMy4wNC4yNCB1bSAxMDo0MyBzY2hyaWViIFRpbSBIdWFuZzoNCj4g
RnJvbTogVGltIEh1YW5nIDxUaW0uSHVhbmdAYW1kLmNvbT4NCj4NCj4gQ2xlYXIgd2FybmluZyB0
aGF0IHVzZXMgdW5pbml0aWFsaXplZCB2YWx1ZSBmd19zaXplLg0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBUaW0gSHVhbmcgPFRpbS5IdWFuZ0BhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmMgfCA1ICsrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZnguYw0KPiBpbmRleCBkOTU1NTVkYzU0ODUuLjhkNWNkYmI5OWQ4ZCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KPiBAQCAtMTA4
NCw3ICsxMDg0LDcgQEAgdm9pZCBhbWRncHVfZ2Z4X2NwX2luaXRfbWljcm9jb2RlKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LA0KPiAgICAgICBjb25zdCBzdHJ1Y3QgZ2Z4X2Zpcm13YXJlX2hl
YWRlcl92Ml8wICpjcF9oZHJfdjJfMDsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9maXJtd2FyZV9p
bmZvICppbmZvID0gTlVMTDsNCj4gICAgICAgY29uc3Qgc3RydWN0IGZpcm13YXJlICp1Y29kZV9m
dzsNCj4gLSAgICAgdW5zaWduZWQgaW50IGZ3X3NpemU7DQo+ICsgICAgIHVuc2lnbmVkIGludCBm
d19zaXplID0gMDsNCg0KPg0KPiBZb3UgZG9uJ3QgbmVlZCB0aGF0IGFueSBtb3JlIHdoZW4gdGhl
IGRlZmF1bHQgY2FzZSByZXR1cm5zLg0KDQpZZXMsIHdpbGwgbm90IHNldCB0aGlzIGRlZmF1bHQg
YW5kIHNlbmQgb3V0IG5ldyBwYXRjaC4gIFRoYW5rcy4NCg0KVGltDQoNCj4gUmVnYXJkcywNCj4g
Q2hyaXN0aWFuLg0KDQo+DQo+ICAgICAgIHN3aXRjaCAodWNvZGVfaWQpIHsNCj4gICAgICAgY2Fz
ZSBBTURHUFVfVUNPREVfSURfQ1BfUEZQOg0KPiBAQCAtMTIwNSw3ICsxMjA1LDggQEAgdm9pZCBh
bWRncHVfZ2Z4X2NwX2luaXRfbWljcm9jb2RlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0K
PiAgICAgICAgICAgICAgIGZ3X3NpemUgPSBsZTMyX3RvX2NwdShjcF9oZHJfdjJfMC0+ZGF0YV9z
aXplX2J5dGVzKTsNCj4gICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAgZGVmYXVsdDoNCj4g
LSAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwg
IkludmFsaWQgdWNvZGUgaWQgJXVcbiIsIHVjb2RlX2lkKTsNCj4gKyAgICAgICAgICAgICByZXR1
cm47DQo+ICAgICAgIH0NCj4NCj4gICAgICAgaWYgKGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9
PSBBTURHUFVfRldfTE9BRF9QU1ApIHsNCg0K
