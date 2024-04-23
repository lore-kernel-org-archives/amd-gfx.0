Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59096C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:27:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA0810EEBB;
	Tue, 23 Apr 2024 06:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpUkMacq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE3C10EEBB
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay99c70yFBf5MiYDiv3s+4zF4jJv8MHReUCLP3iOJ3U62BubUAFCd1IZHzWulu7rvFIIhndPK/z/xOotGRwc1D43o5DxdgFOBGUbJDxJdvSiiXGmzTrD6WS9Rc8//nAMQ6FghTniLQpDK89f8eIMFqaXgAIsEnQjOXVhm26AbK2UIcwCKa1j0W4OlGZfcCCZY3Dj6//NJlI9QiOO9eUQuzJ3u48I7fzxTy8cWTVeNZTELKwDdWdN+KU4NDRUIuseSIOw1NaMPDgFowKXQOAnRwgGfQ3olYSE8v+JnPwDyeVmlZQxoiPRClXo62Epsj/zLtumymMgJyU8iWUBhtiG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjf165W+T2SU5XVFM+U52xN1xClg57oULmeqSiasnao=;
 b=TvSZXDNRXy7PBXVqnBH9TtDWGYo7KeOR6+n+5hdqwBnJXHVNCXH3ZznNCXPt15AdwVEvAVeyw/1vIsM7gcN0ow1Sxfuy1cJKcHEi1E5WydCJESfyMwz2Q6FtF3Pq84yOQzrsatBdinMXYgiJRPN/CGdUQLBTVBQsHwu+Focbpd6bVv0A7TbtcSPlf1P9j/sst/QwSHo9wu2qgEgzWUcGf0E6v9Yp1mWcr71qx9i0QRwEhme3ey04BNAT35PiLFi/LcigPAktLvYHuEGasJqLMP5FQDWSBrhVcgNVW9L7IQNdIPVusPfNu5sfetgAQgR3kChPFtmz9Ybj29KtiNSwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjf165W+T2SU5XVFM+U52xN1xClg57oULmeqSiasnao=;
 b=OpUkMacq85X8hPej6LGWyFz86qIIok8biPd2oHp0IT00i3SeH83uNwAeMck2BpYlDMWSkrO0y0dE0jr/zGH7QvlggsliKlZ74tRRj+fbv9dxlyBwT7EwfzvawEDZfMrkVp3PuKAZenXwCCcBQlzjThgtxA2Tvkzkxp6ohlpXSrY=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:27:38 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:27:38 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Index: AQHalT/LvmVaEXSx2EW9HqyWe4gD0bF1XdiAgAAAhuA=
Date: Tue, 23 Apr 2024 06:27:38 +0000
Message-ID: <CO6PR12MB5394A20AAB771D483B54783494112@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240423053334.884670-1-bob.zhou@amd.com>
 <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
In-Reply-To: <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=12240a29-402c-4463-9d42-d42fa08451a2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-23T06:06:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|PH7PR12MB7307:EE_
x-ms-office365-filtering-correlation-id: 70e637e6-93c5-4a70-7ca8-08dc635e78d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?R0RaRzZVUHJWcXZ2RHF0aDVpaUo0UUI3czVjTUF0Umc5RERlVExpdTlsQ0tD?=
 =?utf-8?B?SDhRMkZmc1o0SFRIZEh0UDBFaXpXRXFtT0c3b1A1d21ZbXFqOUtrYUN3eU12?=
 =?utf-8?B?WCtpSWpMZHdZU05ocHpzMXhKZ3pORG9vTFdmRSsxRUk3SDN4RkZDWERNZUZH?=
 =?utf-8?B?eDZVOGNBV1RqMEVqQ21ua2s4RTRBM0FXYmRZYlpibk51a3FCQkhXcmMwSjl1?=
 =?utf-8?B?Nk9ZOFR3bnY5VkxXYkFidGdMamozbFNPSTNaOGhiRDJVb0hJZHloOEJsbVRZ?=
 =?utf-8?B?MmFvdWZ1K1lBYmNuN2s1SjA1cE5hcEZCYzNWRWpLSnQwL1lhcFVkaysxN0dE?=
 =?utf-8?B?U2NFb05EMDhZUXFieFF4N0pKdDFXZkNmS21qWGt0OGYzRnIxbjZXaEZCSHp0?=
 =?utf-8?B?cVJOT1YraUpwU0ZtM2JhM3EwZkZjNzZQU1MvVXBidi95VzROMzgxM0xKRXpa?=
 =?utf-8?B?ekpBOXVkNjdDWS93SXkrMkFYT1h5bEFqQmdsbkhTMmExb1N0dDY1ZkFxdDFS?=
 =?utf-8?B?OUVzM2t6ZXRDNXljY1VpVkh0QTRWM3ZyM2N5RUVaazZlblhYd1RWdXBBbDZN?=
 =?utf-8?B?N2NxOU9NUVdmbnl3alFGVTFONlcyRkJ4R0QwSGtzbXZIR2pSZ2VyZHA5MWZF?=
 =?utf-8?B?N2x5US90aWw2M0d5SnlrTXBleFE5dEZuLzZnQm55S2JJcER2Q1piVm5PTitG?=
 =?utf-8?B?cWQveXR3QVdjd2p3cXMydDV4SjUwalVMZU0zMEs5bDRmS0RZdVN1UGduZkZq?=
 =?utf-8?B?ZUM1TkF0U3BwU2xDYzQ2cytFaC9nd0pkVXMwNlNkZlNoZFpRT2M3L1JZVzc1?=
 =?utf-8?B?TGRsbVo5RFd0NlY3M3Q5c0pmRnFzamQxV0ZhcjZYYWNENDV3TzVTUHJLa2dr?=
 =?utf-8?B?MWNCWWNtakRnVG81NVMwVWxHRDB4TWk3S0oxTjNnSzUrTXR4VHBmN0JoRWxJ?=
 =?utf-8?B?STVoTXVkRkt4WUNuKzNkSzZoeW5FM25rSDdOaWM0Ni80ZnZOdWJxZ0g2Wk9O?=
 =?utf-8?B?N0c2ak41cENMbkliK3BhU2VsUEQ5bEtVT0xnMjQ2S0RSM2JndklTMWw4NUhu?=
 =?utf-8?B?WE9ac1NUaHlBbkZnUkExdXZVQndzRDRPdCtOVVNDUDVZcXpndWREdFBrcXZ1?=
 =?utf-8?B?dnlEZ3FtNVB0TlRBQkFFWEhBZHZqR2FvR2xucnVyZDU0TkF0ZkRXMnBGcC84?=
 =?utf-8?B?MEZNUjFvZ2tvbWphdG5aOXhhQkFxUFE5UmtLMnFBTnY5YVlmS04vUkdjcmJa?=
 =?utf-8?B?NHI0Vmx1M1RNak5PWmxaQnZQVXplWjBwa1RNaEJqMFlyRHN4VVZTNFM5MCsr?=
 =?utf-8?B?RUJpcTYvWGxNcFc5QTZ4UmF5VDBhcGdHand5dlNGaFR4cGxnT3pRZTI2TGZn?=
 =?utf-8?B?TmFvbm0zUmpPSlhvNlVJV0N1TEpXSm8wT0ZwVERObStHRU8wMDdFbW96dHhy?=
 =?utf-8?B?SG9wVWMzWjRld0piUXJ3Rm55UEpMMW9CanExOWZFNGkzbzN6YkJ6Qk5IUlph?=
 =?utf-8?B?aUlBbi9INXhYQTg1Yk9DVUlsdVdrdUV5ME42Q01vbDZ0RTgwTDl4ZGREelQy?=
 =?utf-8?B?NHlUVmxmVS9MSHRER1ZDSXNPNnNlSEtGQTM1MFhaY1o3QWRIcGZpbk9YT2U5?=
 =?utf-8?B?RVN5Zk5GbGEwN3lPdnNWMGpNQml2Z2lrVEZVd2R0YmI0RlRtWVNkRE1BcmpH?=
 =?utf-8?B?emhMOVYxUjl5cW9PVkFKcGZJK254SDJWWndSdjZZRkJXYWJzUG04M1FwS1JM?=
 =?utf-8?B?MGtRemZqM1pSQXdHSVhBVVhUazFuQjI1RFJIcWluUXlLT2ZyZHVtWVRYQ0R5?=
 =?utf-8?B?ZloxSE5Sbm9lclg4ZXBTdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDM3clBnRjh0ckh1ZnVNVEZMaC9nTnZBeDhha3RlSHhEZUpseVpoRWNWa0R3?=
 =?utf-8?B?dHNXUjEzd2pXUXZDcjZvWlkyZ0NJT0VvWWtES2U2dmRlU1MvdUlPRTFEa0R2?=
 =?utf-8?B?V3VBa3hmRTIrM3hrMWR6RGNXNnpkNmJFcmd1ZHgxcm1pZWNhVC9wM0FWU0Fn?=
 =?utf-8?B?UVZldWFCaDl6VUlNME9LNUJKajY0YlByeEhEWDdhdmh2SmVqNlFveEh5cWxD?=
 =?utf-8?B?SmRxS2lmOCtPdFNHSmViUGVOT0s4NjZhMmtlTTRQcFJlMW9VTzhIN1B3dTFP?=
 =?utf-8?B?d3lUWFBUeVZ3emM2WU9VS1Z2aDAxYXozK0xZWjRMa1VYVCtteXh6UlZPdWxI?=
 =?utf-8?B?Rm1tVXhYNnFnRlE3RDMvWitqVXkyYkk1eStEV2dRRjZVZTlmRFFGYmUzZHVH?=
 =?utf-8?B?eEg5T3RpNGFYaG9jRWd2bmNGclJVQTcvaC9oOFZmbXZtdkU0UHUrVVpNV1VY?=
 =?utf-8?B?eS80aUNaOTBnQkV5OFNLV21zSVh1K25zVVBvSENXMTR2YldIdUF1MXF2czRh?=
 =?utf-8?B?cWZqNGJ1V0NZZzZnNTZVb3dibGRYTGgra0ZYSTM2WGJZMVN5RkVWU3kzbWVs?=
 =?utf-8?B?NzRYZ3VOQkJnQjAzbU1pMVZGbjVMdnBNalBDZFZWZnVwb1lkM0NWVHVabm5C?=
 =?utf-8?B?amdiODJoRkxlM2xzNzJZRGJXRmFYb2NLRGl0ZGdUNXo1akM3OTdmMXdoc2FX?=
 =?utf-8?B?L2FGSkd3ZjQraDNCR0ZsWXRVZmUwUnBpVjJLZGlFZ2tOSnFCVTFWT3dNR2p6?=
 =?utf-8?B?ckJTZmtMK3NGaWRrWkFKSU96dkEzdkRLVFFDMHV5NFQ2VFZBNVpFcHRMRlp2?=
 =?utf-8?B?RVRJZklnRE8yRXBlR0dZWXpMak95dnk1dmlKeVFmS2c5SFNiOGlLQTlIYUF3?=
 =?utf-8?B?eGNHUjRFSVNkS1FRZlN3cEJBVEN2UkhkdHVnWFVOYWZ4RHZoZitTUzRJM2FC?=
 =?utf-8?B?UXNlSHZYMnpRcXlzbDFhcXNVS2J1cURYUVhjRGJFOVRuTDdyRzI0eUdMSHZ1?=
 =?utf-8?B?L3hVSTVFUzZ1NFh0Z3hUU3RXZmRCU0QwaG4xMjk3aEh1eEV3UTd1dURxVWw2?=
 =?utf-8?B?T3ByNGhoa3hySHVQVkJhaktBcFlTa2Rjd2NCcVpsc0UxSVhWS0NxUFprczV4?=
 =?utf-8?B?dEtKbVVPY0Q3T1dhZldFTHBnRjBRMGZ4UWdrTTU4RkxkS01OZTVqNVNVT2hU?=
 =?utf-8?B?MmhHTGgvOGw5TUZTMkE4ZnFsRnZkcFU1SnBsSlh3c3QxdUJhK2p6Y1ZFQlBO?=
 =?utf-8?B?YXAxejRQOCt1RHZSSTV4TXF4bkxXd3grR0dTZGY4dkY0UmFwSlFWais3c2VS?=
 =?utf-8?B?d0RLK1ZHOTg1TDcwc2VScGJQMnZmVEhhdUoyVkJNNmtTMGxDVDkyME9ITGJI?=
 =?utf-8?B?SEozdjBtUVZMV0VZeWRycFdiOTNUUEdXMHhmbkpWaHU1KzhFREpReXZKM2xF?=
 =?utf-8?B?ZEpUUW9kSWpjRVVVbldaeThHeXZOK2s3c2s3Z0MzdU5Wd2hTMGFWQ2paSXRB?=
 =?utf-8?B?MkhOME9WV041N2Uyb0p1SVN4SzlUZ29RWHNkT0luaE9LSGp3TUExazFkcnIw?=
 =?utf-8?B?QjYwNGJZOW5DcWZnamV6T2sxL3VrcUFaYnphWTJwRmtYR09iT0Ywam1mUDg2?=
 =?utf-8?B?bmJST0FKRUQxRUE4cEM3bENLOWZLdEQrSDlENDRFRzlFbElOcXRUMWZLaGcw?=
 =?utf-8?B?VWp4TEZwOUVOMnBlWVpqdW8yWXRWOXc3MDBwNitjS2QzbVNXL1diLzZoWXFk?=
 =?utf-8?B?VXBHOHBuUVBNN0dnNmY4QlJtQkxlRGpOcnNuNjJNS2NrYkd0M21FL2Z2SHpS?=
 =?utf-8?B?OHpRQXAwTDNVTzFtS1dGLzBlYy9xVnNDbVRnTkZsZUlRQzdsdFJ5dlZiMjN0?=
 =?utf-8?B?ZE5LRE9EcnplNnNiNXpoN1dsWVljb1VpRG9mMENvOXVrTHB5NjdCZ2ErcHVx?=
 =?utf-8?B?dlNSR25iSVVvOXRxdG5OMlVZKzNtc0dCeFpuNTlkUjRsbGVTZ3VBc3hvQU9a?=
 =?utf-8?B?WWdXbFpJOGovODRHRUlvcFcxN0tGdmlqRXFNS2NpWW12a042WEhwY1FsQk5s?=
 =?utf-8?B?am5CNFM0eGhuTTkvUzVHZHdlVmRlVUlDRGd6cHZGSkxWZ0s2WUtDTmVZMURU?=
 =?utf-8?Q?IIyY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e637e6-93c5-4a70-7ca8-08dc635e78d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 06:27:38.4639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8U6/GL04Dv5Z9VXbat3k0YZDPETVI5EBoa9mk2wpJ+74O1Is/3AWrsw0LsHEPFQYtoa9ECZpxXdhOazrmGK8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3IgeW91ciBjb21t
ZW50cy4NCg0KSSBzaG91bGQgY2xhcmlmeSB0aGUgaXNzdWUuIEFzIHlvdSBzZWUgdGhlIGFtZGdw
dV9pMmNfZ2V0X2J5dGUgY29kZToNCiAgICAgICAgICAgICAgICBpZiAoaTJjX3RyYW5zZmVyKCZp
MmNfYnVzLT5hZGFwdGVyLCBtc2dzLCAyKSA9PSAyKSB7DQogICAgICAgICAgICAgICAgICAgICAg
ICAqdmFsID0gaW5fYnVmWzBdOw0KICAgICAgICAgICAgICAgICAgICAgICAgRFJNX0RFQlVHKCJ2
YWwgPSAweCUwMnhcbiIsICp2YWwpOw0KICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAg
ICAgICAgICAgICAgICAgICBEUk1fREVCVUcoImkyYyAweCUwMnggMHglMDJ4IHJlYWQgZmFpbGVk
XG4iLCAgYWRkciwgKnZhbCk7DQogICAgICAgICAgICAgICAgfQ0KSWYgdGhlIHJlYWQgZmFpbHVy
ZSBieSBhbWRncHVfaTJjX2dldF9ieXRlKCksIHRoZSB2YWx1ZSB3aWxsIG5vdCBiZSBtb2RpZmll
ZC4NClRoZW4gdGhlIGFtZGdwdV9pMmNfcHV0X2J5dGUoKSBzdWNjZXNzZnVsbHkgd3JpdHRlbiB0
aGUgcmFuZG9tIHZhbHVlIGFuZCBpdCB3aWxsIGNhdXNlIHVuZXhwZWN0ZWQgaXNzdWUuDQoNClJl
Z2FyZHMsDQpCb2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtvZW5pZywg
Q2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiAyMDI05bm0NOaciDIz
5pelIDE0OjA1DQpUbzogWmhvdSwgQm9iIDxCb2IuWmhvdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIDIvMl0gZHJtL2FtZGdwdTogZml4IHVuaW5pdGlhbGl6ZWQgdmFy
aWFibGUgd2FybmluZw0KDQpBbSAyMy4wNC4yNCB1bSAwNzozMyBzY2hyaWViIEJvYiBaaG91Og0K
PiBCZWNhdXNlIHRoZSB2YWwgaXNuJ3QgaW5pdGlhbGl6ZWQsIGEgcmFuZG9tIHZhcmlhYmxlIGlz
IHNldCBieSBhbWRncHVfaTJjX3B1dF9ieXRlLg0KPiBTbyBmaXggdGhlIHVuaW5pdGlhbGl6ZWQg
aXNzdWUuDQoNCldlbGwgdGhhdCBpc24ndCBjb3JyZWN0LiBTZWUgdGhlIGNvZGUgaGVyZToNCg0K
ICAgICAgICAgYW1kZ3B1X2kyY19nZXRfYnl0ZShhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXJfYnVz
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXIu
aTJjX2FkZHIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MywgJnZhbCk7DQogICAg
ICAgICB2YWwgJj0gfmFtZGdwdV9jb25uZWN0b3ItPnJvdXRlci5jZF9tdXhfY29udHJvbF9waW47
DQogICAgICAgICBhbWRncHVfaTJjX3B1dF9ieXRlKGFtZGdwdV9jb25uZWN0b3ItPnJvdXRlcl9i
dXMsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9jb25uZWN0b3ItPnJvdXRl
ci5pMmNfYWRkciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgzLCB2YWwpOw0KDQpU
aGUgdmFsdWUgaXMgZmlyc3QgcmVhZCBieSBhbWRncHVfaTJjX2dldF9ieXRlKCksIHRoZW4gbW9k
aWZpZWQgYW5kIHRoZW4gd3JpdHRlbiBhZ2FpbiBieSBhbWRncHVfaTJjX3B1dF9ieXRlKCkuDQoN
CldhcyB0aGlzIGFuIGF1dG9tYXRlZCB3YXJuaW5nPw0KDQpFaXRoZXIgd2F5IHRoZSBwYXRjaCBp
cyBjbGVhcmx5IHJlamVjdGVkLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFNpZ25l
ZC1vZmYtYnk6IEJvYiBaaG91IDxib2IuemhvdUBhbWQuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaTJjLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaTJjLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaTJjLmMNCj4gaW5kZXggODI2MDhkZjQzMzk2Li5kNGQyZGM3OTJi
NjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pMmMu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaTJjLmMNCj4gQEAg
LTM2OCw3ICszNjgsNyBAQCBhbWRncHVfaTJjX3JvdXRlcl9zZWxlY3RfZGRjX3BvcnQoY29uc3Qg
c3RydWN0IGFtZGdwdV9jb25uZWN0b3IgKmFtZGdwdV9jb25uZWN0bw0KPiAgIHZvaWQNCj4gICBh
bWRncHVfaTJjX3JvdXRlcl9zZWxlY3RfY2RfcG9ydChjb25zdCBzdHJ1Y3QgYW1kZ3B1X2Nvbm5l
Y3RvciAqYW1kZ3B1X2Nvbm5lY3RvcikNCj4gICB7DQo+IC0gICAgIHU4IHZhbDsNCj4gKyAgICAg
dTggdmFsID0gMDsNCj4NCj4gICAgICAgaWYgKCFhbWRncHVfY29ubmVjdG9yLT5yb3V0ZXIuY2Rf
dmFsaWQpDQo+ICAgICAgICAgICAgICAgcmV0dXJuOw0KDQo=
