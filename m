Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0027CC3ABB2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 08:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9636010E229;
	Fri, 30 May 2025 08:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pF9oX3Un";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BC810E800
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 08:41:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOZeyVoKbFG9ceda3h2RnNJMDZc5pzZnKn9qZqoXiliA1nW+JJpPFFcw3u+GfHZCPOFP8UpvGIRvMS+su1aErmGjMXZgpwb6oYoISNPRGR9PvttVAORKPUGiUkC9yhKr+OtK/pf0oi2wuFjqAN7qzAIAioZOLz1rSOKMgT8DHHjV0EN+Tz1AvAvBGNIarx1TEHjoQWNvcmQzGztyw/zVtHvFMhY3dmmr/r1Mes+DkcWozS5x2gQaTuopw+dlmjSr53vKuqjnSLMrOjk33ViPlL84sF0ADinSOBoQH1tBlka/XuUXJUFsimYgEeF5RbzNljbRxG07uQ5VGTRfYm9myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfOyo7sS++0PaIF8rbqhpFPRJ+7up56bpDSqP1w0/5w=;
 b=sZpjaWw2nJ7EXxz42rW4kCv1MhvCFuPR7/NOkXBrI6m9EZH+pGEw8PKo87NjLBLS8fSNkeBYSpgHR+Rjim9MYf1WGizTkOZRMCUMTrfNVweg/d7uiRK0wq3km5Ba/XovU4ZPy2PtSuM6VYwMtLsWy9p2nC5ZMT/48prXze5tpuGaT3Q81luh6MmtErsFOXHrcWQJePuYOE7XrLANfZsXCBN1V+dXiDAXInY1tIAFxBpHUa9Ab8b3PdlvOqZZcvMl4NbvBAgHA4vInp/9X6fZCTyG31DPawS+jrOOY/joFN/Rs6JGvoOZl24vrMCvwx8HuNrUhKVwjrknz9TRbSTlvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfOyo7sS++0PaIF8rbqhpFPRJ+7up56bpDSqP1w0/5w=;
 b=pF9oX3UnCwYA8Dn73qhEY+eKxncqtli7tx8yg+yyn/aBZqBO4iy/oYc9FV9l1ufM6i2N7v5p5ckMw4SFLWIdWVKHApGMHgLpsCWLmAvEw+VJqZL0YDiBGlh5Bf2HUVGj5ShLjRvdl/HQZuGM2/Bs2mCMztpNpBdmjvpb6iuUPHA=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 08:41:54 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%4]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 08:41:54 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
Thread-Topic: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
Thread-Index: AQHb0Jq0ETvq0G4drkiOJNfHEN5xSLPqrfoAgAAsn4A=
Date: Fri, 30 May 2025 08:41:54 +0000
Message-ID: <SJ1PR12MB6075710D0C4D36FC5ED5EDE6FA61A@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20250529130738.2352725-1-li.ma@amd.com>
 <4163aed9-f8bc-4bb9-9e5c-53a0e9891006@amd.com>
In-Reply-To: <4163aed9-f8bc-4bb9-9e5c-53a0e9891006@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8e5ba2e0-006b-451f-b6ac-e0c47b8250f0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-30T08:36:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 50a6a5ba-5d1a-4d12-ab11-08dd9f55d481
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UnBrdm1GWTc3ZVF5WWFTTzhKSFJmZmtKaWRSUFIyU3FiRUEzV2cwL0ZSNms5?=
 =?utf-8?B?aWZXeUNRdDh2dzdXaWtXU3orVVhiTEhPMnRKaUZ3WFI2Q1ZaRjVLdTdZMEYy?=
 =?utf-8?B?ZEVrb0t6b21lOG1oVVdmaWlpNk4zN1dVZVdEUVVndXBMbmZTcG9mNy9ZM2tP?=
 =?utf-8?B?aGIxRDltK1gwTmN1cVF2d1RnbG9mZUJqQmU2Z1hSb05sdlBCd1lSOW1LSEN4?=
 =?utf-8?B?WTkyM0ZZbUFSemZERVZVUFcwbVQrejQxdHdGZmUrODY0c1ltbkx4R3J5RDgx?=
 =?utf-8?B?K2VZK0IwV3JuMGpvdHV3bVdwOVpBSUhHaU5ZMTFGMWthMzY1dm5aK3IwU1FT?=
 =?utf-8?B?bUViaFhpaHpjNUlqMEUyK1h1UXA5WFJqRURORE5Oa2duMnJoYWVKRFNtNDEw?=
 =?utf-8?B?b0tVLzM2UnVCbGNrWlAzeVF2Ums1amNMeExGZVluNnIzeFUvRlRWd3BoQzFX?=
 =?utf-8?B?cGtHWTRjT051WUdHQlBKeGg1a2pLbi9WRVVZenlMK0VaOEVyVHpXWlpwa1BQ?=
 =?utf-8?B?eURtV1loTXlCem5VWDZRT2tLek1sZ2dRdUgzVFFWYXhOQ3dhb2tnemwvdmcy?=
 =?utf-8?B?VlhMV1hkeEtlYnlJcjV6eFc0eVJQVG5zRE41eXA3aXdKV1kyUDYwVlRoQytB?=
 =?utf-8?B?d1haSVZIUndpL1VFazJFV0xUWUlWS016aXM5QUxEWFVKUWI5QUpGcmlybkRm?=
 =?utf-8?B?eDhvbWE2YWVCazA5VS83TlhFN2ZYTWtaM3NHUkJhakF0VVVIbnVqMTRFY3NU?=
 =?utf-8?B?YnkremJYdXRZTXZ6UWpyUFlCcEVTbDhoY3VMSDFhM0lTU09WcnpTTlBTRU9h?=
 =?utf-8?B?c2FOZWRBQ1lkTW82M0t0M1dTdjk1eVJRTDI5YVk3WXRlTUc4RHlmbERVVkFH?=
 =?utf-8?B?cHJNVkhmaUUyOEhGazh1L3Faa0VYYzlpUEFJZUhQWGpkb0t1TDdoaVY5YjBZ?=
 =?utf-8?B?UXVkYVkvUjZCUjZVVG5xdytGU0FCb1NVY1IwL1Q0YTl2Y25pb0w1RGgrN3hz?=
 =?utf-8?B?RzNnc3RXR3dYS0JwZmt1dXAyZkd0WGpNSTVrQmRJT3hybS94UC91dlFsWXpN?=
 =?utf-8?B?SzVaa0tIOExDUnJIKy9PVW5yVm0yazh6bUcwS2JaNUo1MENwVVA3cWZoK2NI?=
 =?utf-8?B?VFVqbi9wbmQxT0pkOHV1enRpTXhIbGpnNWV4UkhMWlRKMGd5YWovL0kyVXlV?=
 =?utf-8?B?dERWUVFKNkYxYUkzckgyZnV3MmVzdmpRNkx2V01wRDB4ZVlQN3NCaHlyNlVo?=
 =?utf-8?B?RzRTMUxyMW43aThiUFZhdjFmVVZ1NjVJYkZrVzJObkNPTFg3VzJvTjZqalpG?=
 =?utf-8?B?OENNRFYwcXFsd3VvaWY2MlIrQWdlTlRZcmlNNGVHWnpEaW9mTVdyS3YvYkJL?=
 =?utf-8?B?STJPNEpNcVQvZVQwSDMxcGZrTUpiZDc1TzJtK1FodjhDZzVmN0YwcnBpbjc5?=
 =?utf-8?B?RGlaNXlxM2pPdkE5NWtYME04aVRhVUM4TEREa0dtK1dFZEZSY2xuaDg2Rnpl?=
 =?utf-8?B?V0YzSXRYQkNZR2swOTQ0NGcydDRpblRqbThDOVV5dGNKTVhGUHZ4Z2UxVDJl?=
 =?utf-8?B?RFlHNjJXVHJzYjdvSTh6cjE2ZjhsY2NiNytHWlRPYThZV3J1N05oNW5vQkJ6?=
 =?utf-8?B?VlZieitNcmFkdjB6NDdWTU0zeStQN3ptT3VhWkt6M0pOZWFPZXRtMG5JenJS?=
 =?utf-8?B?ZFJwdkM1aHl5YTRCMUV5NitFdUlkNmVJUkpFaXJpNStndHA4VlFzb0ZpU2JK?=
 =?utf-8?B?c0x5VC9sTGcyMmQwZGxHSFFOUVYzUmk4QWt3eXlrRkFoZk5aaitKYUlZSDQ2?=
 =?utf-8?B?blR6ejIxN3dTWFNreGFGamFOR1ZHVHFuaWlYa3F3cHJtZzIyRmxHaUtDUjBI?=
 =?utf-8?B?SHdRZGE1NzFGZEJnbDR4R3FrUExzTU1tZ0VBc3l4QXNGc2wyL2I1WE9qTjlY?=
 =?utf-8?B?b1dwU3pNdXlNWlF6a0ZBMjloTnA3Tk5qbUU3eE9XWHdDNzM4TEcra2R0Vjlv?=
 =?utf-8?B?c1Z5UWdQSmtRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGMyc0hHN2RTblFJZU9xRnJCYS82NWZDdUZQb1p6dDlzM3hMZFVoWlR2REpR?=
 =?utf-8?B?NHpOcW1GRFRFNWJKdHhySzZBU3hIaXk2SzFmd3VzcURXd01yY29lbFRJMG9a?=
 =?utf-8?B?WWlqQUJMV0lKaVhOMjEzVjQrQlVrVnVON0t1bWVWQUFQSjFwUXh5OGtXQ0lp?=
 =?utf-8?B?ZDJJSW1aK3FIWEp3bHdOd0hJQ09XTWRyeGNkM2htZDhwTDJsbExNRnQ5a1Ex?=
 =?utf-8?B?WlZINFhLLzMwSnEwNjUzVjV3YmEwRTU0eFV4QkxHR2Z6S0xLanpVK3p4TzJS?=
 =?utf-8?B?Rm1mZ3BvZkV6ajFObXVtUURmaEZIRWtpaGZTVThIUzU1WjVJbnVRZG9jVmFS?=
 =?utf-8?B?MVJqdVFkam41UmpKcmRSSmFyS0R6bFZYTHlwN2hSYjJBQXlQWDQ4RDA2V0lm?=
 =?utf-8?B?WVo4RlgrL2FYV1hjNTV5SDEzbEIremlXZHBSZDF2Nk9WcEVyandXRHJKUEdO?=
 =?utf-8?B?dEZnblA1NFJPR05wSmRuWThrc0JyREM1aEhWREhsY3g4aGg5UXVlZTFPQ0N3?=
 =?utf-8?B?bDdZdGc1YlNyN3RqRmV0by9TNVRUamh5TzJvTWREYkU5UUNjSkEzRVBtT29B?=
 =?utf-8?B?d1doanF4ZS9kdkJyaHZMT2szR1lmUm5jMGdCOUpLQnlTeWRmLy9NWnlyOFJD?=
 =?utf-8?B?MUJnazVhaWNNS0g1Z0ltSkMyMWF4eGRVODV3bTNZRTYwdHBMbTFGL09UOGw0?=
 =?utf-8?B?SWx2QjZXc0pNZjVrb2lFK3lxblZndWx4NmpRUEMrbkdKdXo3VWlJQ3I4NlpY?=
 =?utf-8?B?ZGQvSzhLdnR5dVA2dkVFVzhJK0syblZjbWFacVduTXFDNUZvU01OdU41d0Zs?=
 =?utf-8?B?TzdyRE1manl3aVNjdFBENklXMmlnMkpudEI4VWhzK0dOeld5WFQvbW02RVVC?=
 =?utf-8?B?MGNQTzJjaGE2bGhhSGdJOVlMdUlKdTFOV1NBUGwrdk9kSGsrYVU4d0p4dmZX?=
 =?utf-8?B?WjEvemRWNE4vZkxiY3I1NStvRlh6LzdKZG5YaXc2WVV6b2h1dVQxTGx3S3NB?=
 =?utf-8?B?cndXT05HdFAwb0FIMmVlN3hRYlplWWFIK3ZjbDJXU1ptUXIwUnRlREJTd1ox?=
 =?utf-8?B?aXF3MnR3VUlPNlFtcWNPaWIyVGJyY1hoUVhOU01HQWFBWnVBVStxTkhSbGRI?=
 =?utf-8?B?TFNvMWwrRGVjQzhUSS9HMFFsTllkUkQzWWpDNnRYNkZlZk52bG9qbXBiYlZ5?=
 =?utf-8?B?WVJydGlOYmdJeE9KaDRGV2VGR3hOeXd4bkJQNW80ZC96OGt6MmFMRWs5dEZs?=
 =?utf-8?B?RGFBbm1DOCtraCtQS3J1SFpOVVVaM1RPbjdKQW9Ta3M2ZEI2bUdoTHM4OXhn?=
 =?utf-8?B?bU8vTkRNejJ5M1RyRXBRYzkzSElITEVaZ1NyZ1JtajdFaHlwUCtxZkFHbXk2?=
 =?utf-8?B?aUw5cDBRT0lNNXMvRUh2MGZMTXQzOGZZbzBNZnI3T1NtRnBMekduakVSWWRG?=
 =?utf-8?B?c2o0cXRsOHE1MGVJa3Qyckh6b2tKOERnSWRWbjdVS0h5b3pzZ3hERjFPZGhx?=
 =?utf-8?B?NHNzNU9uUUhrNmZUSEJNeitoOEx5ODhiYUZzV3RZTGxUbGZPY2YyZGRMdk9n?=
 =?utf-8?B?QlFhb3R1UnE0dmtjWHA3eHdNMzM4cWYzUi9WcGVaN3VQWjYrSW9jdDMvNDVy?=
 =?utf-8?B?NlJJa1pHVUV5cnI4cmJjSm9FOCthUTVMZlI2KzRVWjRselFLZlFVVFlGWnFl?=
 =?utf-8?B?amtKczFmNTRIMk9sQ3U5bWp6Si9waUtyLzdCWVRMWEZ4V1B3VWRIbFRLVWht?=
 =?utf-8?B?QksyMUlpQlg5WHh4TWxJakdFMnhrWTMzQ3dhZDBnMGQxU1VmeENnSnh3S2cy?=
 =?utf-8?B?ck5XUG5nSmJPYnRpd0xqb3c1Tm5LK2wxK2dndHcvSGxuWjMwc1Zpd0tmU2dD?=
 =?utf-8?B?OFFDWXJlTFUwdGtrMEE1Nm5FT0xROFNJYmpuMUtyRndmMjM4c3BTSUVnTnVR?=
 =?utf-8?B?UDBiZ2VxQmNHRmZJdEZWdGIwQStyRG1BSzIxdmVVaFZFbG9zUkJ6Q3M5cXpr?=
 =?utf-8?B?NXlvU0ZQc3VUTkhocWFuR2RUL2dNTVdxM1lXcDRseDBwT1N5VGZGdjNSNzdD?=
 =?utf-8?B?dFl1aUpDciszOGJBSzJWUGZoMnErc2xkRWdCSGR0aTBCYmhXakd4OEdScVFS?=
 =?utf-8?Q?lajU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a6a5ba-5d1a-4d12-ab11-08dd9f55d481
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 08:41:54.2441 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JlQh+93dUpm74AXe2JsFSJ75QPhHVs6aArGp9vOrWL27WmWrJJLnW+qpGA10i7lZQ3yiv3sqp5VVdOQ3vKdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgQXJ1biwNCg0KVGhpcyBwYXRjaCBpcyBub3QgZm9yIHRoZSBpc3N1ZSB3ZSBkaXNjdXNz
ZWQgaW4gdGhlIG90aGVyIG1haWwuDQpUaGVyZSBpcyBhIHJpc2sgb2YgJ25leHQnIGZlbmNlIGxl
YWsgd2hlbiBhbWRncHVfdHRtX2ZpbGxfbWVtIGZhaWxlZC4NCg0KQmVzdCByZWdhcmRzLA0KTGkN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW5lZXIgU2VsdmFtLCBB
cnVucHJhdmluIDxBcnVucHJhdmluLlBhbmVlclNlbHZhbUBhbWQuY29tPg0KPiBTZW50OiBGcmlk
YXksIE1heSAzMCwgMjAyNSAxOjU3IFBNDQo+IFRvOiBNYSwgTGkgPExpLk1hQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlh
bi5Lb2VuaWdAYW1kLmNvbT47IFl1YW4sIFBlcnJ5IDxQZXJyeS5ZdWFuQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEZpeCBwb3RlbnRpYWwgZG1hX2ZlbmNlIGxl
YWsgaW4NCj4gYW1kZ3B1X3R0bV9jbGVhcl9idWZmZXINCj4NCj4gSGkgTWEsDQo+DQo+IE9uIDUv
MjkvMjAyNSA2OjM3IFBNLCBMaSBNYSB3cm90ZToNCj4gPiBUaGUgb3JpZ2luYWwgY29kZSBkaWQg
bm90IHByb3Blcmx5IHJlbGVhc2UgdGhlIGRtYV9mZW5jZSBgbmV4dGAgaW4gY2FzZQ0KPiA+IGFt
ZGdwdV90dG1fZmlsbF9tZW0gZmFpbGVkIGR1cmluZyBidWZmZXIgY2xlYXJpbmcuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMaSBNYSA8bGkubWFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDUgKysrKy0NCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gPiBpbmRleCA5YzVkZjM1
ZjA1YjcuLmI3Mjg0ZjBhNWFjMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMNCj4gPiBAQCAtMjI5Niw2ICsyMjk2LDcgQEAgaW50IGFtZGdwdV90dG1f
Y2xlYXJfYnVmZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLA0KPiA+ICAgICBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+dGJvLmJkZXYpOw0KPiA+ICAgICBz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5tbWFuLmJ1ZmZlcl9mdW5jc19yaW5nOw0K
PiA+ICAgICBzdHJ1Y3QgYW1kZ3B1X3Jlc19jdXJzb3IgY3Vyc29yOw0KPiA+ICsgICBzdHJ1Y3Qg
ZG1hX2ZlbmNlICpuZXh0ID0gTlVMTDsNCj4gPiAgICAgdTY0IGFkZHI7DQo+ID4gICAgIGludCBy
ID0gMDsNCj4gPg0KPiA+IEBAIC0yMzExLDcgKzIzMTIsNiBAQCBpbnQgYW1kZ3B1X3R0bV9jbGVh
cl9idWZmZXIoc3RydWN0IGFtZGdwdV9ibyAqYm8sDQo+ID4NCj4gPiAgICAgbXV0ZXhfbG9jaygm
YWRldi0+bW1hbi5ndHRfd2luZG93X2xvY2spOw0KPiA+ICAgICB3aGlsZSAoY3Vyc29yLnJlbWFp
bmluZykgew0KPiA+IC0gICAgICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKm5leHQgPSBOVUxMOw0K
PiA+ICAgICAgICAgICAgIHU2NCBzaXplOw0KPiA+DQo+ID4gICAgICAgICAgICAgaWYgKGFtZGdw
dV9yZXNfY2xlYXJlZCgmY3Vyc29yKSkgew0KPiA+IEBAIC0yMzM0LDEwICsyMzM0LDEzIEBAIGlu
dCBhbWRncHVfdHRtX2NsZWFyX2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1X2JvICpibywNCj4gPg0KPiA+
ICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoKmZlbmNlKTsNCj4gPiAgICAgICAgICAgICAqZmVu
Y2UgPSBuZXh0Ow0KPiA+ICsgICAgICAgICAgIG5leHQgPSBOVUxMOw0KPiA+DQo+ID4gICAgICAg
ICAgICAgYW1kZ3B1X3Jlc19uZXh0KCZjdXJzb3IsIHNpemUpOw0KPiA+ICAgICB9DQo+ID4gICBl
cnI6DQo+ID4gKyAgIGlmIChuZXh0KQ0KPiA+ICsgICAgICAgICAgIGRtYV9mZW5jZV9wdXQobmV4
dCk7DQo+IFNpbmNlIHlvdSBhcmUgb2JzZXJ2aW5nIHVzZS1hZnRlci1mcmVlIHdhcm5pbmcgZm9y
IHRoZSBjb21wdXRlIGRpc3BhdGNoDQo+IHRlc3QgaW4gYW1kZ3B1X3Rlc3Qgd2l0aCB0aGlzIHBh
dGNoLA0KPiBjYW4gd2UgdHJ5IHRoZSBiZWxvdyBjb2RlIGluIGFtZGdwdV9ib19jcmVhdGUoKSBm
dW5jdGlvbiwNCj4NCj4gciA9IGFtZGdwdV90dG1fY2xlYXJfYnVmZmVyKGJvLCBiby0+dGJvLmJh
c2UucmVzdiwgJmZlbmNlKTsNCj4gICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkocikpIHsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChmZW5jZSkNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGZhaWxfdW5yZXNlcnZlOw0KPiAgICAgICAgICAgICAgICAgIH0N
Cj4gUmVnYXJkcywNCj4gQXJ1bi4NCj4gPiAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5tbWFuLmd0
dF93aW5kb3dfbG9jayk7DQo+ID4NCj4gPiAgICAgcmV0dXJuIHI7DQoNCg==
