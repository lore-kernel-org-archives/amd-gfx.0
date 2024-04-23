Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72882C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 08:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD8A1131F8;
	Tue, 23 Apr 2024 08:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cLcAKZY5";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11BF1131F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 08:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuI5WeNBC1Y5LagLZrg5yziC1+NBU9x8CJFy6CnABwnYyWbbLmp2ravi4cMYtYyYQnDAF4agxjILLSYCUIt+ssb3kV2APXN3CQcfpn7cSM/qI3RpMqNQbJ0HV7sTxLgcyn0LPcjTDmpWS+XLGoURh6o299xYsGrsrRuHH6l78wIJigT77ck6I+uL+K/MdLZ/MoikSCKkQPKhxD80QISvxk1udAKNsA2nxxMDuqfyYvntfX5qkFqLbVKb3KzHpvXJWFSk7rjoc+ieGtKYpPQgACxTNf2CcrccL9cM37hAPy198hFUqwUIsRNtTAd+bVG0R69ey0ABgKnhKqFNODz4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mrHVBbgE7qLitF4/pCM/0RJgYqcWG4r1XoG1iy0fRs=;
 b=Rbz+dql40rxw5tcZWWsdenuMwO0V9eNQx9TEGNxyZHbTnHCyp7ml3rn0rWS6ml4uB3UXSBNFgt3//fC+z65h8g5Y8BW4QpQVkJpeefRaGeE87jIyIi1/o1LsaN4kGQcVgByW9Zxl3p/F42HRwCj1qpdOiMw6s4K6UNgyJoZbZIouFV6swH6CZay2+kS3nSXUhZCsm6a22oQvQAHDxT6RWwSASuByAILnpiRbX94GQc3H7+UmqqUI6+KpYxiYacsy7NPU6trEB6SO7DSbJafGsu9uh9+VjO27tpZhcx5mMgztPdyOrTNnPKbSd1budDBdzF5fQ4WUmmGbxH22/JlMqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mrHVBbgE7qLitF4/pCM/0RJgYqcWG4r1XoG1iy0fRs=;
 b=cLcAKZY5o8yEVv2sxXgJeUrphW9F9PaiA1VVB6LR6hJou2Gf5fxbFpERleRh6ZIVyUJu9teFPI9fNU2NEWCreJfaICRKCoCdKyZeAF22w1B/dPT5KrESoPdwgvXaAgNbni5tujsE7RFk6blkyrQKsg51uDXA/EbX/yjMSNRRPM8=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 08:36:12 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 08:36:12 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Index: AQHalT/LvmVaEXSx2EW9HqyWe4gD0bF1XdiAgAAAhuCAABpXAIAADDxg
Date: Tue, 23 Apr 2024 08:36:12 +0000
Message-ID: <CO6PR12MB5394E76387FF73F8D90B879894112@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240423053334.884670-1-bob.zhou@amd.com>
 <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
 <CO6PR12MB5394A20AAB771D483B54783494112@CO6PR12MB5394.namprd12.prod.outlook.com>
 <ed766f80-357d-4b24-9071-042332641f60@amd.com>
In-Reply-To: <ed766f80-357d-4b24-9071-042332641f60@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=52824fed-bb39-472f-a216-37baccea8a1e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T08:24:54Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|SJ1PR12MB6267:EE_
x-ms-office365-filtering-correlation-id: bef7f3d5-d4c0-4e8c-c534-08dc63706edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?bzhWZ0VGNVFLbEhwNnhWU3JEYVRWbFEzb1M5TzdMeTVuTTUxTTRXTisyK1du?=
 =?utf-8?B?UmloMlJqUUhvSEF0UXAweXArbmszK0xBM3YySWZjdW5IeGJ6SVgxT2ZXMmtL?=
 =?utf-8?B?c3Z3dGJVWnd6b21aQUJpYW9KVXBzaTFSOVgyNDM4RGhYMVJrNEpLS1oxVmxC?=
 =?utf-8?B?bWxiS3pDeWxOcHh3UXprRXd5eGtUcWsya1RZaVpBUkNDZDFSaFVBdThHc2Y2?=
 =?utf-8?B?amtxWFJRTktFQnY4a1BLcUtGNlJkWjAzUzZNaTY1NW8xNXBnWG9XRm1zeHd4?=
 =?utf-8?B?ckVuTDV4S2twTUVDNHdwV3lHaXRXZ01vNC9PQzZoMDJNSHMzMDhxd0NrVGx5?=
 =?utf-8?B?am1SQXVFUWZaanJpdHB6ZUgrRlFWc2VyQUd5Tnh4KzFoSFNkcUdORGZoUXVU?=
 =?utf-8?B?RnhNUTYrcEwyemtQNEc0SmdJeStOTDNqbmIxMnVuM3pseEQzZitFU2Q0dUhS?=
 =?utf-8?B?UVVlc2pQSnBZcDV1N3BQYnZaZGhWc3ZnMjJWenl0STdQUXNiZy9ockRLaXVk?=
 =?utf-8?B?R29acUdGVk02ZDJEWGRHQnc3NUtJV1JzWHNFVVJzdFdsc0FKR3ZSUW55bkJo?=
 =?utf-8?B?cmJ5UUlpZU5DSmZVaTVtREU4S042OGNhR0YxQ1ZKdFl1cWNpSjVjRmNUNmFC?=
 =?utf-8?B?cEQrbjhMdzBJYUdheE1EWGE4bzA5djl4NHZiaTBIZ0R1eWxxcXZXQVhNWm02?=
 =?utf-8?B?SXhCNjBONmQ0a3lVUmxrZHBVSEdsaGViRm5yVHF0MTZHekdWY2gxRlFkU2dD?=
 =?utf-8?B?L3J6d0o4MWJRRTIxdjdkbGtBZUhab3VkcVZxM3hqRG9UQjdreUVPMUhFL25s?=
 =?utf-8?B?OVRjbktqMGlJZjVYY0s5akJORUJ5L3pFT004WTdRSldQRURyQmMyRklobVRj?=
 =?utf-8?B?bWlCYmprZkp2eUZQMHlrMmpCTUx2Tm1hMzV1d1BBVng5M3Q5bjI3THNLL3hr?=
 =?utf-8?B?dUhSNHQ5SFBINjI2aktTZmJXRTRxLzU0MjhUcGpwd3YzQTlWMUFXN2Zmbi9E?=
 =?utf-8?B?TXJHV3R6R0hnc0JBRGVmMEc0T1ZpU2o4Q2JGNUVTdUdZTzBxRG9QMkJNTTEv?=
 =?utf-8?B?TzE2UGFyaEdnMTF3MEx4eGFRWUdMTXFCSWtDUXJacFZmVjUrcEhZeXVrQVVi?=
 =?utf-8?B?MVlublB4Zlp5ZGlPRWF6SnlQdjJWVURDcENiMG5yOFZWVW5vV0h6cXlsRGw2?=
 =?utf-8?B?OWp0QVk4TFQ0VnZCYTM3SWg1MmdjUFVtblVJcnFKeDRadmNxSis3bWZpRXBJ?=
 =?utf-8?B?L0hYY2p2MUFmMU5TbnhlWDVyMjd1Y0RtazJYemQ4OFN5M2FhVXZOQTZGOGxp?=
 =?utf-8?B?b3B3VFNOblpiN0FnNFRCYVBzNWRmNGtzSGg3WGo1dVVzcDNleUNxVC9HbVBt?=
 =?utf-8?B?QitBVWNOWnVwSnArWkNhZGdvZlRQb01Eb3V0QnpxWFdvOXUzQ0FwL1VJUWo2?=
 =?utf-8?B?ek5mOEdFVlIxL3lBNGprMXdlaEcwVk5RWWZhcHo0TnhQcElQeVNRbGYzcmhW?=
 =?utf-8?B?Zks3OGFraE1Ia1Vxck9uaGJWdGhRWEhiSS95dWtlY2UyRjlHOWRtU3VEZ040?=
 =?utf-8?B?U2FYUHJ6SXRVTy9zdzlrRTBSUXFidmFhZ0gyUE82U2wvRnh6RVV1TGRjN2NW?=
 =?utf-8?B?aFBhb3BERWhteHR5TXp6eEpNTU02SjdSQWxjU3Y2WmZEZWZodWdhbWIwNEZq?=
 =?utf-8?B?alE5V1ZTcDBaV1Z4N1FTMklsTGEzWmZ5bUF1OXUzWVBFK0pNQm1uREFlRlNw?=
 =?utf-8?B?N2tzazU1ODF1cU1QSzFiUlMrbGNMOWlaN1ZzSUpibnFQMjJGNmpjeXBQcEdj?=
 =?utf-8?B?a2Z6TG54UjZmWWplRFBqZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUJUZDUrTGVqeVBqRy9GRzB1cFBrekkyempTWGpGOUU4WHFiU3hHNWlydlJS?=
 =?utf-8?B?bjNZTjh3WElBNGs0TmExUVBOc2hNYlNmcVJMWEJ4Z3FqU2RhemFDcmIvY3A1?=
 =?utf-8?B?WGJuVzRIdDJMaFpjY00yejF3M2ZiemVHYXJLSUJnVkNSdmp3cmc1L0k3MnpL?=
 =?utf-8?B?SWRtWEc0UVRPSHVEOHBGYlY3dHJ2Wmp4L3pQb2N3cUw2d0VUb04vbVhMWGd6?=
 =?utf-8?B?TGcvRk9sRlNmZExVeVR1MzV4Z1psaitCdk9uRHdFZldnTkloZmhxdkx4ZE8r?=
 =?utf-8?B?YUpXekhicnNSNUk1ZjNyZHRoQmtOS2ZvaXNqMUFQNk9wc0RPeW0vZTN2b2ts?=
 =?utf-8?B?cGJDOVdvaWpXdStSNWtacGZ2dFkyL25ReUowSklaaVI2T0s1THNqK3dRSlFF?=
 =?utf-8?B?Y3h1VzZSK3JYWldBWFlCVXRGMFlQVDdYNEdFU09CMCtWSW5JcXo5d014YkdJ?=
 =?utf-8?B?OGd5dWczbGo4Q0Vtd2t5SFpJZmkrUU45cmV0bWs1WElVWlJ6TGE2bWhtcWx4?=
 =?utf-8?B?VXlyQ0tCZ1FmeGdLb1FwM1BuQW9KclQvb1dWUGp2dlpGUElWdE9iYUJsVU9n?=
 =?utf-8?B?UnpIRXltUnZuckhqTDM2WVNnaE9aTGxBNEk1WnBIbGQ1MFUwekNYUGhCcUhj?=
 =?utf-8?B?NzliU2lvMnBva21ueXRwVU1aWFQ0T3V2aDhoLzh2bjNYTGVYMXVEOHhiMmNX?=
 =?utf-8?B?UWxFV1NGUkwxcWVVcW1FeWhvVVlidjA1Q1pYb1JNa3MvbUU2US8vaGs3NXRQ?=
 =?utf-8?B?VUptOHh6NkhtWDd3R1BSTnZnMXpVcklnT2duTHNLVCtDbi9TdkFacEZRKzJJ?=
 =?utf-8?B?TE53QnZ0cDB3UkFNQTVPVHBoM2dnN0tuRjZpWVIvRGQ4S0hTcW5aQ0lsWDJX?=
 =?utf-8?B?UVgzWC85MkFwU0JMN084czErb1NoSnd0RGhsRm1zL1ljdDdLTDl0a2Y5MHNC?=
 =?utf-8?B?RDdydUlqUytjcWN0NjJ6SEZ4cmczK2Z0TkMzZm5PQjFibmU0OXNrbG1ETXlB?=
 =?utf-8?B?NHhTZ0VRUDZVSlhyY3dnWmd3UFJoQktoSnM4SHNlSElVYjZvVjRJK0kwWklh?=
 =?utf-8?B?bjRSVytnUzBaMVhXWVNza0JBcUVwNjlxR2FYWWlqVEtzYTQ5Y2RWd2xWQ3ZO?=
 =?utf-8?B?OTlmN1RlS1h4UHQ5NXhxa1VqK0IxRmU1a2FmNitOYzBtZ3hYWGhGOWFEN0lD?=
 =?utf-8?B?ZzNCQUxlTlVkUk9vamx0enF2dVJ6dmxQa3d1RlFCREtLUTdFNmZmcWdwZ2Fv?=
 =?utf-8?B?MTMxM2R6Zk9UZFhBNzFJcXN3QUNNekZsRkxld0ZkdWg1bDFzTU82djU3SE1n?=
 =?utf-8?B?VUsySElHRTlyNXRCWG5CSWpnWFRoMlhtNllnejMrbHVncC9hd1RJSWFEQTdu?=
 =?utf-8?B?Y0UxYk5SZlZYWVFNRnZjMzdxT2RTOXBYZS9UN1hqdWlYcnhCdk5TRWJzd29N?=
 =?utf-8?B?ekhjOG1EUXZ4Y3BQL0FYdVM3WEFpa0FYWEFRTnB4TFJ4Y3VrSXN3T0J6S2k0?=
 =?utf-8?B?elFnc1JmaWliNTR1NXF1dmhZM2ZnR1lKVm53bVI0WVNIOWo3QlJtT2F1NXpo?=
 =?utf-8?B?a2UrOUs5VmphVmhaT2hLdlRxTzk0TDAxanpQQ1NXbjA5Um5LWUIydERERXFj?=
 =?utf-8?B?enl0aVVVN1R6cmNzV3JpRU9BNHdTbGc0Qi9kTUhsVnZjQ0xCcjE2bFdndmxD?=
 =?utf-8?B?TytibVZlUEwyUkM0Sm9tSHhzVkwweTNoRTBZY3NSdnRwWlZlUVdDUExmMFFw?=
 =?utf-8?B?VGVKaXNhZ21oQXVzNXVTRHpmeG5xRkFmQWsxc1d6aWt6cks5Q0p6RHF1ejZK?=
 =?utf-8?B?TVRENWlyWm1PcEdWQk1qMkE5dmtQM0RHZVVBSXBncmdDRitXWU01bU51KzFr?=
 =?utf-8?B?OEhEUUFXcjdhVld6VG1ncDJrYmlOeWpsRGpUdmpxRXErS1lLcm1pRnlkalFU?=
 =?utf-8?B?OTcyNjg4c09qVitHVmtNa1hOYnVTZE5mUWJJbU9QdEc5YmlxL1gyVVJ3eHJX?=
 =?utf-8?B?OEpsdFQ5OXB1OGVSdTNmS3VFZGlEeFFnYW5LNzNVV05vOGRMRWhwZjlsZmFG?=
 =?utf-8?B?NG5Leld1SkphR3RIdTBEend1K1lWUHdvbk41czFFMjNncGFaclViTmFhem9T?=
 =?utf-8?Q?KoaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef7f3d5-d4c0-4e8c-c534-08dc63706edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 08:36:12.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqfhbDjTHFcSOWSNnD66TPGL4Ld4ToWUHJrb6wwDtwkyGf8i3n/nY5d0Lz0CZPEy6KUR/peQk+8Uq3zEhthhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbg0KDQpBZ3Jl
ZSB3aXRoIHlvdSwgcmV0dXJuaW5nIGFuIGVycm9yIGlzIHN1cmVseSBhIGJldHRlciBtb2RpZmlj
YXRpb24uDQpJIHdpbGwgc2VuZCB2MiBwYXRjaCB0byBmaXggdGhpcy4NCg0KUmVnYXJkcywNCkJv
Yg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4g
PENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IDIwMjTlubQ05pyIMjPml6UgMTU6NDEN
ClRvOiBaaG91LCBCb2IgPEJvYi5aaG91QGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NClN1YmplY3Q6IFJl
OiBbUEFUQ0ggMi8yXSBkcm0vYW1kZ3B1OiBmaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJu
aW5nDQoNCkluIHRoaXMgY2FzZSB3ZSBzaG91bGQgbW9kaWZ5IGFtZGdwdV9pMmNfZ2V0X2J5dGUo
KSB0byByZXR1cm4gYW4gZXJyb3IgYW5kIHByZXZlbnQgd3JpdGluZyB0aGUgdmFsdWUgYmFjay4N
Cg0KU2VlIHplcm8gaXMgYXMgcmFuZG9tIGFzIGFueSBvdGhlciB2YWx1ZSBhbmQgaW5pdGlhbGl6
aW5nIHRoZSB2YXJpYWJsZSBoZXJlIGRvZXNuJ3QgcmVhbGx5IGhlbHAsIGl0IGp1c3QgbWFrZXMg
eW91ciB3YXJuaW5nIGRpc2FwcGVhci4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMjMu
MDQuMjQgdW0gMDg6Mjcgc2NocmllYiBaaG91LCBCb2I6DQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBHZW5lcmFsXQ0KPg0KPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuDQo+DQo+IEkgc2hv
dWxkIGNsYXJpZnkgdGhlIGlzc3VlLiBBcyB5b3Ugc2VlIHRoZSBhbWRncHVfaTJjX2dldF9ieXRl
IGNvZGU6DQo+ICAgICAgICAgICAgICAgICAgaWYgKGkyY190cmFuc2ZlcigmaTJjX2J1cy0+YWRh
cHRlciwgbXNncywgMikgPT0gMikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgKnZhbCA9
IGluX2J1ZlswXTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIERSTV9ERUJVRygidmFsID0g
MHglMDJ4XG4iLCAqdmFsKTsNCj4gICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHKCJpMmMgMHglMDJ4IDB4JTAyeCByZWFkIGZhaWxl
ZFxuIiwgIGFkZHIsICp2YWwpOw0KPiAgICAgICAgICAgICAgICAgIH0NCj4gSWYgdGhlIHJlYWQg
ZmFpbHVyZSBieSBhbWRncHVfaTJjX2dldF9ieXRlKCksIHRoZSB2YWx1ZSB3aWxsIG5vdCBiZSBt
b2RpZmllZC4NCj4gVGhlbiB0aGUgYW1kZ3B1X2kyY19wdXRfYnl0ZSgpIHN1Y2Nlc3NmdWxseSB3
cml0dGVuIHRoZSByYW5kb20gdmFsdWUgYW5kIGl0IHdpbGwgY2F1c2UgdW5leHBlY3RlZCBpc3N1
ZS4NCj4NCj4gUmVnYXJkcywNCj4gQm9iDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
IFNlbnQ6IDIwMjTlubQ05pyIMjPml6UgMTQ6MDUNCj4gVG86IFpob3UsIEJvYiA8Qm9iLlpob3VA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJt
L2FtZGdwdTogZml4IHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUNCj4gd2FybmluZw0KPg0KPiBBbSAy
My4wNC4yNCB1bSAwNzozMyBzY2hyaWViIEJvYiBaaG91Og0KPj4gQmVjYXVzZSB0aGUgdmFsIGlz
bid0IGluaXRpYWxpemVkLCBhIHJhbmRvbSB2YXJpYWJsZSBpcyBzZXQgYnkgYW1kZ3B1X2kyY19w
dXRfYnl0ZS4NCj4+IFNvIGZpeCB0aGUgdW5pbml0aWFsaXplZCBpc3N1ZS4NCj4gV2VsbCB0aGF0
IGlzbid0IGNvcnJlY3QuIFNlZSB0aGUgY29kZSBoZXJlOg0KPg0KPiAgICAgICAgICAgYW1kZ3B1
X2kyY19nZXRfYnl0ZShhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXJfYnVzLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXIuaTJjX2FkZHIsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MywgJnZhbCk7DQo+ICAgICAgICAgICB2
YWwgJj0gfmFtZGdwdV9jb25uZWN0b3ItPnJvdXRlci5jZF9tdXhfY29udHJvbF9waW47DQo+ICAg
ICAgICAgICBhbWRncHVfaTJjX3B1dF9ieXRlKGFtZGdwdV9jb25uZWN0b3ItPnJvdXRlcl9idXMs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3ItPnJvdXRl
ci5pMmNfYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgzLCB2YWwpOw0K
Pg0KPiBUaGUgdmFsdWUgaXMgZmlyc3QgcmVhZCBieSBhbWRncHVfaTJjX2dldF9ieXRlKCksIHRo
ZW4gbW9kaWZpZWQgYW5kIHRoZW4gd3JpdHRlbiBhZ2FpbiBieSBhbWRncHVfaTJjX3B1dF9ieXRl
KCkuDQo+DQo+IFdhcyB0aGlzIGFuIGF1dG9tYXRlZCB3YXJuaW5nPw0KPg0KPiBFaXRoZXIgd2F5
IHRoZSBwYXRjaCBpcyBjbGVhcmx5IHJlamVjdGVkLg0KPg0KPiBSZWdhcmRzLA0KPiBDaHJpc3Rp
YW4uDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCb2IgWmhvdSA8Ym9iLnpob3VAYW1kLmNvbT4NCj4+
IC0tLQ0KPj4gICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2kyYy5jIHwgMiAr
LQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pMmMu
Yw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaTJjLmMNCj4+IGluZGV4
IDgyNjA4ZGY0MzM5Ni4uZDRkMmRjNzkyYjYwIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2kyYy5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfaTJjLmMNCj4+IEBAIC0zNjgsNyArMzY4LDcgQEAgYW1kZ3B1X2kyY19y
b3V0ZXJfc2VsZWN0X2RkY19wb3J0KGNvbnN0IHN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRn
cHVfY29ubmVjdG8NCj4+ICAgIHZvaWQNCj4+ICAgIGFtZGdwdV9pMmNfcm91dGVyX3NlbGVjdF9j
ZF9wb3J0KGNvbnN0IHN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRncHVfY29ubmVjdG9yKQ0K
Pj4gICAgew0KPj4gLSAgICAgdTggdmFsOw0KPj4gKyAgICAgdTggdmFsID0gMDsNCj4+DQo+PiAg
ICAgICAgaWYgKCFhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXIuY2RfdmFsaWQpDQo+PiAgICAgICAg
ICAgICAgICByZXR1cm47DQoNCg==
