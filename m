Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FA5CCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 06:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD25810E15D;
	Fri, 24 Oct 2025 06:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEcMTfN0";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6417B10E15D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 06:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOVjXMjWGSK6dUbEeKh1o5bb2sXI8IaemHGDMMcTtacxLU+CG+JMLPyJ9ifBlsTpVZpY2ie9iQHhljc/DPPn3Ayi9TQSZkPV0iUW1ZSxkHE6YA3YofWY2oj1BF6bP2Vzv7p9JwygrwfvoYXUqL8j9wI4PLHRa1qT19qwqTud0G4Wso9cfEIrtiBmy8spA4VI3GzqV9KGYRgdxCMMv2h2TEbSrwsqUkHvCfboOJ4p+ibLJsShxl1VjCsqlkrLPX1XyOjqRuym1xyrlEr1dP4HDL2hn4WWblhKVwIDide9pXoeb4DZdcWbHgVvTUG4P4tiIEjBPcPUlQvhdtHP6nfg/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uXSanW08TiK1FwAwIbVnm8/feMfhnGphW2N1HN6KR0=;
 b=WjjgqjP+XBtBGTYMU5pYU0bxeUpbvnUFyS55RG1qiUaIEGEbi5MD0URmCXR1O+oQcX91aDSrYaNC4ib6B3w64AtKGVa8PW4aSpjsHQxHEb5+qqhPWTrQG+3W24qDAl5GYSkavPq2fD+XOH67A+LG3uYUphgrs5Jdw1TcY4wR6Nrp9bg8wX782FB3XxzoccnZ2dYawRR5XAn6pDxXGk0YwMLKKrcsXnwpEor+5il6KrDVHVnEEEYkUW78GKif95bykf8P794H3EtSi9TBQIYvvkklhH3QesHxop9mORSIw8d7kpgrolpY5JUB8put+N67yK85oZmq7WhFuZ179WhAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uXSanW08TiK1FwAwIbVnm8/feMfhnGphW2N1HN6KR0=;
 b=MEcMTfN0mVlNWfc+f3dcWN7Z/UdTVicqGqu4KKuWanAk4GkdOIeynVRAHtkaOoC7FMIHLGtP5IDmL9N6FqT7nkFcpdM/LuV86sFUIoxwtS8CTFFaYx5RhC+qOhEB3e8O3HI8e5o+31eK5eFMGL5OzcCND1EZjWlt182NJINJx5g=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Fri, 24 Oct
 2025 06:14:23 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:14:23 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Chen, Xiaogang"
 <Xiaogang.Chen@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Thread-Topic: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Thread-Index: AQHcQ1+/G0JD4RpnQEK8GIUuJOKDRrTPzZiAgAB4FwCAAF2kkIAAFn4AgAAYm5A=
Date: Fri, 24 Oct 2025 06:14:23 +0000
Message-ID: <IA0PR12MB8208E2BBBA8D41F85A86BDA990F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
 <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
In-Reply-To: <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-24T06:08:24.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|CH0PR12MB8485:EE_
x-ms-office365-filtering-correlation-id: 10e4b498-c82b-4725-d142-08de12c49394
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?K1FIbUdpaStHSy9DYW9ZMEUyN1JRdmFoVjRFUmp0QVRZcjBHVUtoSEZEME14?=
 =?utf-8?B?TWRTT09SMis4dXQxem91dk9XV3Y1a3o4bUJrWklwV2lZUkNoN2VVRDh1VCsr?=
 =?utf-8?B?b1NSZ2tKaStrZzJSZkQyZEVWaWRZTG5ibGpQUVFuYUVkSHRERWNrSEVrRGtZ?=
 =?utf-8?B?YkZFajY5M2ovKy90aVd2V1g1M1VGMzlqbXp1QXA2Tm5Xd3g3d04rb0FzVE96?=
 =?utf-8?B?c0V6NzMzQTBSWXQzbFY0cHlDZHUrZy9DY3lSWjE0ZmNWSnpjK245TWlrWDJj?=
 =?utf-8?B?OTU5Qmtpd2haYUhJbnhQZGk0VDJlanJ1dGpVUzdxTy9UQW04Z1FBZTVBZkU0?=
 =?utf-8?B?M1dobjNjd2NweWY5ZEZOUy9Vc29ZbTJPM0FhSzFnUmREL3diVlhZSjJ2T3pr?=
 =?utf-8?B?L1lMSkIxeFpJQlhMM3J2RnRFbURMbGZ5eENCd3hzanZ6aStUV25nWi9LOGNl?=
 =?utf-8?B?SEIrMUlIY2ZnTlUzaDhjWi9TUFNSZnBoZHlIOTNzK3o2bFoyaDcreW5rNU5N?=
 =?utf-8?B?b1dYaWJXYWhBMldocll4UHRBbHpHcmxiUTdWQktENTJXR3ZKVmhVVlptelFV?=
 =?utf-8?B?NTZWc2VFcFNTUUNZMW9DT1F5TVBWeW1YbXpYQUlkZHNMWFA5NllwSXE1STJx?=
 =?utf-8?B?VU8vUWVPOW52dDV4NVh2eDZibzRRWFpIL0g3ckw0b2ZkOC9QWTFQU1VUQU1x?=
 =?utf-8?B?NVNHNGsyL2FiUis0NEFmcXRDMVB2N0RCTmxIdXdXUmcyZnZ2amF6T1pNRDBh?=
 =?utf-8?B?UlBRa1kyN09LYzlqVm5NTkU2SXpReTFTcFg0MkJzYnRRNjFqampjYzhQN2E3?=
 =?utf-8?B?Y3ZtckVVRnZHQlBQYjNzeVVnaXJwU0U5bWZ4dEVmTnNnMS9EeTFQWmhLTjRO?=
 =?utf-8?B?Vmd1VjJnUVdDM1ludEJSaG5wbHZuYlMvL3c4N3RuaTltd2FpR01TdVNWbm8v?=
 =?utf-8?B?RjQ4ZHVwWW1HeDhBcUhJaVF6SVdGbmdPV0tmMkhvR0RmME1Xbmszbk9IL1lD?=
 =?utf-8?B?ak5PM3hrUnRnQTgrYjFLVmhYaE1lNmJtN3lMRmpnZUFXYW51QzFtNzdaREJa?=
 =?utf-8?B?NmNDcE1ranpNcHZidGt0Zm9zTWEyNzRUTzg5SDlsWE9YazV0dGlvVG01emFm?=
 =?utf-8?B?Z2pibldwMGl3Ky9hQnFrem9CMmNhV0ZGQkd0VEdmby9ucWQrMDNKb1I4TGx1?=
 =?utf-8?B?QmxTVm1wWjZDaGVKcWp0cWRMaklHUUw1cVV1S2drcWljQU1ZT05CY0JKb3E2?=
 =?utf-8?B?QWZUbVVTVHRGYmtvb2JkSVhFR1B0d1JzSWtEd3Y1VkZmWitNWU9SSjloTWdR?=
 =?utf-8?B?R2xLQjlkZWZNdEdWdW9LVUNkVEpjRnhRQWprRFhCczJBRnE5OXN1ZnJ1eTcx?=
 =?utf-8?B?S3pJOGtHckNxNFF6MGJaWXdOSDUzbFgxSHBlNHNydzQ0QWttQVFOdFM2MjY1?=
 =?utf-8?B?QVR2N0xHb0ZlLy9HT3l5OStNM0kvaHhCY0E0bGpUMnM5aEJHbWw3NUFXVG05?=
 =?utf-8?B?b1hRNVM0RDlrRWNqbVZLemdVZytXOFFPVHo3M0plZTN3b2Fob0d2Zk5IcWcy?=
 =?utf-8?B?Zk5WWDlsVU12WVJBRllUVDRSZkVSOUZNN1YrMVVhZGpnemQ4Z0dBVldUWnRj?=
 =?utf-8?B?aVFJTTVrVkFvVGY3aU5xc0RIQlAraWNPS2c0LzlHRGNkcXk0YTlYNVNtQzJB?=
 =?utf-8?B?QlA1STlZaVBRWmUrcnpRSGhlQUJQamY3U05OU0xkUHJKalczTHNkd3pPbEZk?=
 =?utf-8?B?VWs3cUpsNE9BeTR5Mmd2NHlLQnl6NVo3Sm92LzlsWXpFY2NPWDZjTXRVM091?=
 =?utf-8?B?UE5sakdGbldocFdhbHBMblVKODcvV2tQZ3laTjZHOVQ1RXgrQW1PeGx6Lzht?=
 =?utf-8?B?MDRUTDBCUUtmSmpGR0JkbDZrVm11M1p4SXdVclAxYlhqSzhveVA1a3dPN1Fr?=
 =?utf-8?B?VmJGcExzOFpBWUN3UUgwN0hvT2dyWTZVUFpGRGV2eVdYOHBsNlpoSlBNbHN6?=
 =?utf-8?B?aW91dUhKSTJrYUJZcS9vejBzY2FwVVBrZHR4U2hsY2l3Y0pDbjY3SDVGZXkw?=
 =?utf-8?Q?AUpoX0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTdOaUN4cEtZd09wNHNHS2Q3MUZSc3ZxZ2lSakU5alREN2J4ZEcvS0NDeVNI?=
 =?utf-8?B?Wmd6OE1aajJoN21pWER0bnFGU0s2eUpFQnNXVmlIU0ozZzFkYjU4bGdLSlBw?=
 =?utf-8?B?NitrYmE0NitJS2NUUkdoeFdwNk1JMXJzNytWbHhwc1FhMzRrOUMyc0dPSDBh?=
 =?utf-8?B?YkJvNFdWMExJUUdOS0RNK2dLU0NHL1V1aXczOTEzTHlzQ1FVbC81K2p2cnlK?=
 =?utf-8?B?RzZDcDNTanJYQ0hxbjNUUTc3UGpCa3dCS0l6Uk0xZnpZNWxBS0pVdlFxVFpT?=
 =?utf-8?B?YVpWVGsybUtTd2hrZXR0QlQ5TVZLWjVsNlhuVXlvWVlxN0tyY1Y3TVFVK3ph?=
 =?utf-8?B?akdxRXYyTXd1VmpxalhaQm15a1BRRG1Jb3BuT0V0MDNTN0x2R1NoUG9OakZT?=
 =?utf-8?B?T0pvamtTQngwZ1lvbmZvaVU1bGYvOWRJb3JiblJzZUNVbUpZTkhOcmQxNE51?=
 =?utf-8?B?TElYZkN1UTRmZEE0T0pQRU9ORlBGVGRnYjVVa1UzREVFQnVXZVg4cEdqWmsy?=
 =?utf-8?B?YUlmc1FRWFJPRmRrZ1EzQWVDRFcyWTdNallNaFgvOGluazF5c0FjYVhna0R4?=
 =?utf-8?B?V0lzKzUxY0pUR1ZIRFkxeXRDODVEejQrSGxPNi9CUk0ybkYvU2h2YWFBajNM?=
 =?utf-8?B?cUk2R0pTWXRWSVRuZkZrTFNCdVlsNzhzSkpzU0Jwb0JYUjlUblZGMkgzMTQ1?=
 =?utf-8?B?RUwzUGxxMG0wZlRpaXBuMy9SazZvVEc4L0FwTTBRYm5KdFpjQTRCQ2hoeVZ0?=
 =?utf-8?B?M0FHbWZreDZPT2VEYVVIb1ZRYnhrUEFma29ySFVOT243amtxRVE4R3JhVnhp?=
 =?utf-8?B?MzhVSUxmUjkxNHR0djk0b3FjSXZIREF4STk0b0l0YktSaFV6cXFOUjNoSGtG?=
 =?utf-8?B?eEFhNTJNZjgxWUptVHJ2S0NDYWdTWmducjhtTElKQ0RTaEszdSt4cXBLelQ2?=
 =?utf-8?B?UVM2THIzNUk4WXkzK2FMU3UzRGhjUlZVbFZZWXdYSk9aSWFHZWVFLzM4M1BN?=
 =?utf-8?B?RjNkU2tEYldKWCtRMTZWOHRyejYzd2JwQnhrSERibStBWVhpMk9Vck1heFc2?=
 =?utf-8?B?RnlISHg2TWpVR3dVYWV1bnVDTnVrMEFHZE9ZcDBJUTJaWjFEWFEwcEtHeTJj?=
 =?utf-8?B?NnNKSkgwQlFjenVETUZ1Zi9mcE81Szk3VEdhUFMzZHdaL3VpZnJjamZUWlBz?=
 =?utf-8?B?dXdHQUFpU2NFZWFwNzJyeW9qUXdWQmVHSzFjYlRNSE9QditSbTJwbEpBU1JM?=
 =?utf-8?B?SjhPYXBqQlFBcFpPSXdvaEdiOVZqYzEvRGF4MnF4Vm01cWladmpaVmowcTRm?=
 =?utf-8?B?L0ZGRXdWMHdESW11dXNGbXRsSDExanFPZlBRTzMvemp1TE5LR3hnbVBoaUw5?=
 =?utf-8?B?alpkZWVwYWV6ZG1iajJNclhyLzE3dU9xQWtZd2x5RWJnVjViRUE2RXJRckZU?=
 =?utf-8?B?c3oxTkE2ckE4eWRKT2ZYcGV0eTN4OTF5Q1dQTU8zM01xUmltMHh0SzVvSWlU?=
 =?utf-8?B?TkwrVUN0KzVZQ1VFUTQ5RUdJOXdSZ2h6QXBUdGhJdGVZL2hrZ1FiSVQrSlVF?=
 =?utf-8?B?VVNlSy91ZzBseVFEdHJhOThKSGFKZUJDckJFc0Rua0Fpa2tTSWsvZUR4ME9s?=
 =?utf-8?B?MVdRRjBXYVA1Z2RJeDFjc3ZSQ2FDRWFLeDJDRUdmWjRHVjU1bWJaU0V3Y1J4?=
 =?utf-8?B?WkFrVEZoeDVOR1VML2JOai9Yd3dwYVRHNGthcmVVc2ZTcDlwRk1GS2RRUzZU?=
 =?utf-8?B?TEJUMVhHejQ3cWdpakE4dUhqYVNidHBCNTJDcWpiRGR2NHZUUlNDblBEM2x5?=
 =?utf-8?B?cXUvMnB4dDJRZyt6M2dDaXdUVENXL09QaHRoUmNKaWJZYVhvbWJsbkdMdXUy?=
 =?utf-8?B?TVU3dlpXdkFwRThPVGtJcFhtNnNHa0dFZE1VRUZJMHZIRm94Z2FXV3NsYVFB?=
 =?utf-8?B?S0lIRHU2TUFnNzJoek5OZjhqdC8yN1ZUNHZyMmhPVWVhYmpkTVFrSjZqYTF0?=
 =?utf-8?B?WDRVV2RSaEEvczVnRjlPZmdYYWR1VGtrUHlqS29pektHS3k4aG5JTm4vbExv?=
 =?utf-8?B?S1VxVGY2RDZidit0SkNmZm45UmsvbXlWeVlJWTg0d2ZMOW9FcXV6MXFLZnE4?=
 =?utf-8?Q?dRag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e4b498-c82b-4725-d142-08de12c49394
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:14:23.1911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EShWhRDuGyJ69Jd+oevnF0DxsitTopU3JiyTCd+DBnU6i+6vswB65wOoCDIEloL2DOs8FlFVGDuXiMK0GXhuMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLaGF0cmks
IFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDI0
LCAyMDI1IDEwOjEwIEFNDQo+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNSSU5JVkFTQU4u
U0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBDaGVuLCBYaWFvZ2FuZyA8WGlhb2dhbmcuQ2hlbkBhbWQu
Y29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IERl
dWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5nQGFt
ZC5jb20+OyBLaGF0cmksDQo+IFN1bmlsIDxTdW5pbC5LaGF0cmlAYW1kLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2M10gZHJtL2FtZGtmZDogRml4IHVzZS1hZnRlci1mcmVlIG9mIEhNTSBy
YW5nZSBpbg0KPiBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcCgpDQo+DQo+DQo+IE9uIDI0LTEw
LTIwMjUgMDk6MjAgYW0sIFNIQU5NVUdBTSwgU1JJTklWQVNBTiB3cm90ZToNCj4gPiBbUHVibGlj
XQ0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IENoZW4s
IFhpYW9nYW5nIDxYaWFvZ2FuZy5DaGVuQGFtZC5jb20+DQo+ID4+IFNlbnQ6IEZyaWRheSwgT2N0
b2JlciAyNCwgMjAyNSAzOjE1IEFNDQo+ID4+IFRvOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+Ow0KPiBLb2VuaWcsDQo+ID4+IENocmlzdGlhbiA8
Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4+IDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IFlhbmcsIFBoaWxpcA0KPiA+PiA8UGhpbGlwLllhbmdAYW1kLmNvbT47IEtoYXRyaSwg
U3VuaWwgPFN1bmlsLktoYXRyaUBhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
XSBkcm0vYW1ka2ZkOiBGaXggdXNlLWFmdGVyLWZyZWUgb2YgSE1NIHJhbmdlDQo+ID4+IGluDQo+
ID4+IHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKCkNCj4gPj4NCj4gPj4NCj4gPj4gT24gMTAv
MjMvMjAyNSA5OjM0IEFNLCBTcmluaXZhc2FuIFNoYW5tdWdhbSB3cm90ZToNCj4gPj4+IFRoZSBm
dW5jdGlvbiBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcCgpIHdhcyBmcmVlaW5nIGByYW5nZWAg
d2hlbg0KPiA+Pj4gYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoKSBmYWlsZWQuIEJ1dCBsYXRl
ciwgdGhlIGNvZGUgc3RpbGwgdXNlZA0KPiA+Pj4gdGhlIHNhbWUgYHJhbmdlYCBwb2ludGVyIGFu
ZCBmcmVlZCBpdCBhZ2Fpbi4gVGhpcyBjb3VsZCBjYXVzZSBhDQo+ID4+PiB1c2UtYWZ0ZXItZnJl
ZSBhbmQgZG91YmxlLWZyZWUgaXNzdWUuDQo+ID4+Pg0KPiA+Pj4gVGhlIGZpeCBzZXRzIGByYW5n
ZSA9IE5VTExgIHJpZ2h0IGFmdGVyIGl0IGlzIGZyZWVkIGFuZCBjaGVja3MgZm9yDQo+ID4+PiBg
cmFuZ2VgIGJlZm9yZSB1c2luZyBvciBmcmVlaW5nIGl0IGFnYWluLg0KPiA+Pj4NCj4gPj4+IHYy
OiBSZW1vdmVkIGR1cGxpY2F0ZSAhciBjaGVjayBpbiB0aGUgY29uZGl0aW9uIGZvciBjbGFyaXR5
Lg0KPiA+Pj4NCj4gPj4+IHYzOiBJbiBhbWRncHVfaG1tX3JhbmdlX2dldF9wYWdlcygpLCB3aGVu
IGhtbV9yYW5nZV9mYXVsdCgpIGZhaWxzLA0KPiA+Pj4gd2UNCj4gPj4+IGt2ZnJlZShwZm5zKSBi
dXQgbGVhdmUgdGhlIHBvaW50ZXIgaW4gaG1tX3JhbmdlLT5obW1fcGZucyBzdGlsbA0KPiA+Pj4g
cG9pbnRpbmcgdG8gZnJlZWQgbWVtb3J5LiBUaGUgY2FsbGVyIChvcg0KPiA+Pj4gYW1kZ3B1X2ht
bV9yYW5nZV9mcmVlKHJhbmdlKSkgbWF5IHRyeSB0byBmcmVlDQo+ID4+PiByYW5nZS0+aG1tX3Jh
bmdlLmhtbV9wZm5zIGFnYWluLCBjYXVzaW5nIGEgZG91YmxlIGZyZWUsIFNldHRpbmcNCj4gPj4+
IGhtbV9yYW5nZS0+aG1tX3BmbnMgPSBOVUxMIGltbWVkaWF0ZWx5IGFmdGVyDQo+ID4+PiBrdmZy
ZWUocGZucykgcHJldmVudHMgYm90aCBkb3VibGUgZnJlZS4gKFBoaWxpcCkNCj4gPj4gd2hhdCB5
b3UgZml4IGlzIG5vdCAidXNlLWFmdGVyLWZyZWUiLCBpdCBpcyBwcmV2ZW50aW5nIGRvdWJsZSBm
cmVlLCByaWdodD8NCj4gPj4+IEluIHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKCksIFdoZW4g
ciA9PSAwLCBpdCBtZWFucyBzdWNjZXNzIOKGkg0KPiA+Pj4gcmFuZ2UgaXMgbm90IE5VTEwuICBX
aGVuIHIgIT0gMCwgaXQgbWVhbnMgZmFpbHVyZSDihpIgYWxyZWFkeSBtYWRlIHJhbmdlID0NCj4g
TlVMTC4NCj4gPj4+IFNvIGNoZWNraW5nIGJvdGggKCFyICYmIHJhbmdlKSBpcyB1bm5lY2Vzc2Fy
eSBiZWNhdXNlIHRoZSBtb21lbnQgcg0KPiA+Pj4gPT0gMCwgd2UgYXV0b21hdGljYWxseSBrbm93
IHJhbmdlIGV4aXN0cyBhbmQgaXMgc2FmZSB0byB1c2UuDQo+ID4+PiAoUGhpbGlwKQ0KPiA+Pj4N
Cj4gPj4+IEZpeGVzOiBjNWUzNTdjOTI0ZTUgKCJkcm0vYW1kZ3B1OiB1cGRhdGUgdGhlIGZ1bmN0
aW9ucyB0byB1c2UgYW1kZ3B1DQo+ID4+PiB2ZXJzaW9uIG9mIGhtbSIpIFJlcG9ydGVkIGJ5OiBE
YW4gQ2FycGVudGVyDQo+ID4+PiA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiA+Pj4gQ2M6
IFBoaWxpcCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiA+Pj4gQ2M6IFN1bmlsIEtoYXRy
aSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQo+ID4+PiBDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiA+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hhbm11
Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaG1tLmMgfCAxICsNCj4gPj4+ICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYyAgICB8IDYgKysrKy0tDQo+ID4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPj4+
DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ht
bS5jDQo+ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9obW0uYw0KPiA+
Pj4gaW5kZXggZDZmOTAzYTJkNTczLi45MGQyNmQ4MjBiYWMgMTAwNjQ0DQo+ID4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaG1tLmMNCj4gPj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9obW0uYw0KPiA+Pj4gQEAgLTIyMSw2ICsyMjEs
NyBAQCBpbnQgYW1kZ3B1X2htbV9yYW5nZV9nZXRfcGFnZXMoc3RydWN0DQo+ID4+PiBtbXVfaW50
ZXJ2YWxfbm90aWZpZXIgKm5vdGlmaWVyLA0KPiA+Pj4NCj4gPj4+ICAgIG91dF9mcmVlX3BmbnM6
DQo+ID4+PiAgICAgIGt2ZnJlZShwZm5zKTsNCj4gPj4+ICsgICBobW1fcmFuZ2UtPmhtbV9wZm5z
ID0gTlVMTDsNCj4gaG1tX3JhbmdlLT5obW1fcGZucyBpc250IHNldCB0aWxsIGEgZ290byBvdXRf
ZnJlZV9wZm5zIGlzIGNhbGxlZCwgaGVuY2Ugbm90DQo+IG5lZWRlZC4NCg0KV2h5Pw0KDQpwZm5z
ID0ga3ZtYWxsb2NfYXJyYXkobnBhZ2VzLCBzaXplb2YoKnBmbnMpLCBHRlBfS0VSTkVMKTsNCmht
bV9yYW5nZS0+aG1tX3BmbnMgPSBwZm5zOw0KDQpmb3IgZXhhbXBsZSwgaG1tX3JhbmdlX2ZhdWx0
KCkgZmFpbHMpLCB0aGUgY29kZSBnb2VzIHRvIHRoZSBlcnJvciBwYXRoOg0KDQpvdXRfZnJlZV9w
Zm5zOg0KICAgIGt2ZnJlZShwZm5zKTsgICAvLyBmcmVlIHRoZSBidWZmZXINCg0KQnV0IGFmdGVy
IGZyZWVpbmcsIHRoZSBwb2ludGVyIGhtbV9yYW5nZS0+aG1tX3BmbnMgaXMgc3RpbGwgcG9pbnRp
bmcgdG8gdGhlIHNhbWUgKG5vdyBmcmVlZCkgbWVtb3J5Lg0KSXTigJlzIGEg4oCcZGFuZ2xpbmcg
cG9pbnRlcuKAnSDigJQgaXQgcG9pbnRzIHRvIG1lbW9yeSB0aGF0IG5vIGxvbmdlciBiZWxvbmdz
IHRvIHVzLg0KDQpCZXN0LA0KU3JpbmkNCg0KPiA+Pj4gICAgb3V0X2ZyZWVfcmFuZ2U6DQo+ID4+
PiAgICAgIGlmIChyID09IC1FQlVTWSkNCj4gPj4+ICAgICAgICAgICAgICByID0gLUVBR0FJTjsN
Cj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfc3ZtLmMN
Cj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+ID4+PiBpbmRl
eCBmMDQxNjQzMzA4Y2EuLjEwM2FjYjkyNWMyYiAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9zdm0uYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3N2bS5jDQo+ID4+PiBAQCAtMTc0NCw2ICsxNzQ0LDcgQEAgc3RhdGlj
IGludCBzdm1fcmFuZ2VfdmFsaWRhdGVfYW5kX21hcChzdHJ1Y3QNCj4gPj4gbW1fc3RydWN0ICpt
bSwNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgIFdSSVRFX09OQ0UocC0+c3Ztcy5mYXVsdGlu
Z190YXNrLCBOVUxMKTsNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgIGlmIChyKSB7DQo+ID4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9obW1fcmFuZ2VfZnJlZShyYW5n
ZSk7DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2UgPSBOVUxMOw0KPiBS
YW5nZSBpcyBhIGxvY2FsIHBvaW50ZXIgYW5kIGlmIGl0IGhhcyBiZWVuIGZyZWVkIGl0IHNob3Vs
ZCBub3QgYmUgdXNlZCBhZ2FpbiBpbiBzYW1lDQo+IGZ1bmN0aW9uLiBUaGUgZXJyb3IgY29uZGl0
aW9uIHNob3VsZCBoYW5kbGUgdGhhdC4NCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcHJfZGVidWcoImZhaWxlZCAlZCB0byBnZXQgc3ZtIHJhbmdlIHBhZ2VzXG4iLCByKTsNCj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPj4+ICAgICAgICAgICAgICB9IGVsc2Ugew0K
PiA+Pj4gQEAgLTE3NjEsNyArMTc2Miw3IEBAIHN0YXRpYyBpbnQgc3ZtX3JhbmdlX3ZhbGlkYXRl
X2FuZF9tYXAoc3RydWN0DQo+ID4+IG1tX3N0cnVjdCAqbW0sDQo+ID4+PiAgICAgICAgICAgICAg
c3ZtX3JhbmdlX2xvY2socHJhbmdlKTsNCj4gPj4+DQo+ID4+PiAgICAgICAgICAgICAgLyogRnJl
ZSBiYWNraW5nIG1lbW9yeSBvZiBobW1fcmFuZ2UgaWYgaXQgd2FzIGluaXRpYWxpemVkDQo+ID4+
PiAtICAgICAgICAgICAgKiBPdmVycnJpZGUgcmV0dXJuIHZhbHVlIHRvIFRSWSBBR0FJTiBvbmx5
IGlmIHByaW9yIHJldHVybnMNCj4gPj4+ICsgICAgICAgICAgICAqIE92ZXJyaWRlIHJldHVybiB2
YWx1ZSB0byBUUlkgQUdBSU4gb25seSBpZiBwcmlvcg0KPiA+Pj4gKyByZXR1cm5zDQo+ID4+PiAg
ICAgICAgICAgICAgICogd2VyZSBzdWNjZXNzZnVsDQo+ID4+PiAgICAgICAgICAgICAgICovDQo+
ID4+PiAgICAgICAgICAgICAgaWYgKHJhbmdlICYmICFhbWRncHVfaG1tX3JhbmdlX3ZhbGlkKHJh
bmdlKSAmJiAhcikgeyBAQA0KPiA+Pj4gLTE3NjksNw0KPiA+Pj4gKzE3NzAsOCBAQCBzdGF0aWMg
aW50IHN2bV9yYW5nZV92YWxpZGF0ZV9hbmRfbWFwKHN0cnVjdCBtbV9zdHJ1Y3QNCj4gPj4+ICsq
bW0sDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICByID0gLUVBR0FJTjsNCj4gPj4+ICAgICAg
ICAgICAgICB9DQo+ID4+PiAgICAgICAgICAgICAgLyogRnJlZSB0aGUgaG1tIHJhbmdlICovDQo+
ID4+PiAtICAgICAgICAgICBhbWRncHVfaG1tX3JhbmdlX2ZyZWUocmFuZ2UpOw0KPg0KPiBJIGd1
ZXNzIHdlIGFyZSBzZXR0aW5nIHVwIHRoZSBlcnJvciBhbmQgdGhhdCBzaG91bGQgYmUgdGhlIGNy
aXRlcmlvbiB0byBjYWxsIHRoaXMNCj4gZnVuY3Rpb24uIElmIHRoZXJlIGlzIGFscmVhZHkgYW4g
ZXJyb3IgY29uZGl0aW9uIGJlZm9yZSB3ZSBzaG91bGQgbm90IGJlIGNhbGxpbmcgdGhpcw0KPiBh
Z2Fpbi4NCj4NCj4gcmVnYXJkcw0KPiBTdW5pbCBraGF0cmkNCj4NCj4gPj4+ICsgICAgICAgICAg
IGlmIChyYW5nZSkNCj4gPj4gQ2FuIGp1c3QgY2hlY2sgaWYoIXIpIGhlcmUgYW5kIHJlbW92ZSAi
cmFuZ2U9TlVMTCIgYWJvdmU/IGlmIHIgaXMgbm90DQo+ID4+IDAgcmFuZ2UgaGFzIGJlZW4gZnJl
ZWQsIGlmIHIgaXMgMCBmcmVlIHJhbmdlIGhlcmUuDQo+ID4NCj4gPiBCdXQgdGhlcmUgYXJlIGxh
dGVyIHNwb3RzIHdoZXJlIHIgYmVjb21lcyBub24temVybyBhZnRlciBnZXRfcGFnZXMoKSBzdWNj
ZWVkZWQNCj4gYW5kIHJhbmdlIGlzIHZhbGlkOg0KPiA+IHN2bV9yYW5nZV9kbWFfbWFwKC4uLikg
Y2FuIGZhaWwg4oaSIHNldHMgciAhPSAwLg0KPiA+ICFhbWRncHVfaG1tX3JhbmdlX3ZhbGlkKHJh
bmdlKSDihpIgeW91IHNldCByID0gLUVBR0FJTi4NCj4gPiAhbGlzdF9lbXB0eSgmcHJhbmdlLT5j
aGlsZF9saXN0KSDihpIgeW91IHNldCByID0gLUVBR0FJTi4NCj4gPiBJbiBhbGwgdGhyZWUgY2Fz
ZXMsIHlvdXIgbmV3IHRhaWwgbG9naWMgaWYgKCFyKSBhbWRncHVfaG1tX3JhbmdlX2ZyZWUocmFu
Z2UpOw0KPiBza2lwcyBmcmVlaW5nIGJlY2F1c2UgciAhPSAwIG5vdy4gU2luY2UgeW91IGFsc28g
cmVtb3ZlZCByYW5nZSA9IE5VTEw7IGFmdGVyIHRoZQ0KPiBlYXJseSBmcmVlLCBub3RoaW5nIGVs
c2UgZnJlZXMgaXQg4oaSIG1lbW9yeSBsZWFrLg0KPiA+DQo+ID4gUmVnYXJkcywNCj4gPiBTcmlu
aQ0KPiA+DQo+ID4+IFJlZ2FyZHMNCj4gPj4NCj4gPj4gWGlhb2dhbmcNCj4gPj4NCj4gPj4+ICsg
ICAgICAgICAgICAgICAgICAgYW1kZ3B1X2htbV9yYW5nZV9mcmVlKHJhbmdlKTsNCj4gPj4+DQo+
ID4+Pg0KPiA+Pj4gICAgICAgICAgICAgIGlmICghciAmJiAhbGlzdF9lbXB0eSgmcHJhbmdlLT5j
aGlsZF9saXN0KSkgew0K
