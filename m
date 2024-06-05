Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F241EC25B78
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 01:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553DF10E65B;
	Wed,  5 Jun 2024 01:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qU7YqCIa";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7095110E65B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 01:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goJ3I0NYFLxPogxQh6hXZGW0GnwVWw7YG1q9mB571wdILQGY3X7RphFeMxpUjTYTGRRSsNrSgVa1hEO4qnorU20Em8vWVUHtqfwbXl3JhSVGVh1H/Jfp2s8S/dilLmghspgvZPZAu9uXBiYCM6BDPcYFwzHJN5M5T2dXbj8KVQOSg0ZhTv1KvyfThmIPe6UvoIjL1JunFxI0RE712hD2+ZhwYrPhX5L9yGVMP7pMIxKKDEWrp+8EhPhbLmnPBjMf6BU6g1etJXvdKXUjtL60tRF6nKxsLScal4EHG/ga546iVlDJesxSVstRdtWnoAJduhXR6cVUw+U4VywOqUQo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT4dY9IkB0wLIE6XcOft8K0CN7cBwpt7HGFKoMg7Qq0=;
 b=aIZ8MllpjNMeEJuDQz6qfjBwn98IZGFVGXUDuFAMKB+mlBsYbkprk1Jvm16kAW7uQjfW24q25E6EgL2EvZJFJttaW7dqa/+xho7LztLtRzyUhU1NfFKc8Gku/igyA0/EMFW1hV0H0HdCptiXAWG4z+Xogkh0JJA59zL9DYCEuOwtGm9hHnoTP8a2vE1VCDg/8HrC3sA6o9kyXNdj/SeAIGFOI61DND7t/ietA/c2N2LRz4GLMLUvTZQS6R5n4ob0PlgQKcRhmkjZm8pKEna7AGjJasiGEvrB3CJ2uggXek+1BNOWEl7y7YqsFifUKLVfgHYID4sqq71rmLpMjcWJmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT4dY9IkB0wLIE6XcOft8K0CN7cBwpt7HGFKoMg7Qq0=;
 b=qU7YqCIadfOkNnEEGVkXdPf4aDep4UMnawCasbK6/87HagQIVtBsQ3rjR+lhc6wLdvhfz440XPnTpo+wE/zYzzCX+ItBBCiT5Q3PYRH25ZaQ3YdpXWsbUAWDXDdX/CY32YZl+x6g1OdGe7i0rhbCB+vGiq/Uu6rG2iz/rigMjeg=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Wed, 5 Jun
 2024 01:12:03 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 01:12:03 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Subject: RE: [PATCH v3 2/8] drm/amdgpu: fix sriov host flr handler
Thread-Topic: [PATCH v3 2/8] drm/amdgpu: fix sriov host flr handler
Thread-Index: AQHastsb4tMEKsjR5UmPBo+3POQkGLG4ZKuw
Date: Wed, 5 Jun 2024 01:12:03 +0000
Message-ID: <PH0PR12MB54171F075093F78F4A6BA4FD8FF92@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-1-Yunxiang.Li@amd.com>
 <20240530214805.40970-3-Yunxiang.Li@amd.com>
In-Reply-To: <20240530214805.40970-3-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7a451d0d-a2c9-457a-adb9-0493ab095c31;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T01:10:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|IA1PR12MB7759:EE_
x-ms-office365-filtering-correlation-id: 3c474928-f7ed-4ef2-2a7f-08dc84fc82a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?oLBvVjv9p9xRLaPmt633EroUMy1z/CbraaqUnG9hAOfRS6Ibci7HLLr6JMqF?=
 =?us-ascii?Q?mfRV/H60sAuLkjb3rt9Oexq7w34LreaFfz5zbFTTESKei9ES7TEeZBqVhd/n?=
 =?us-ascii?Q?rfG+lOD6W8zG3OuqohRPrKAfsIhGkUs0FDSacjqVk5s9CV9Td6zFj+AGxAXS?=
 =?us-ascii?Q?RyzOEqVhPRre2GI7EnXqr0skOfrhycyJURJxATqTLLvl5wzPNvtLa2+ttlP3?=
 =?us-ascii?Q?a4naAp9+3kVV9wnQ3xVz1w2MVn4NcvUKLnSKC8os+o/A8LV1ElzEAHOmbWZ+?=
 =?us-ascii?Q?M15RrYHDwJRpoAM03IeCCRr0PJoApuxLhIyxDYpXCT3fb8tfnWMz9USGCxbP?=
 =?us-ascii?Q?gPLnx94YAQBke08QwBVMDLcmBJksdE1FjduKs+Biz4F1vxwlC3dtd4rZeSTZ?=
 =?us-ascii?Q?ub7XN5Jei1p7Dm/t+qCBVMPkgjXvKTDoZ1/UdExLPSMJUjIQ3YkfPgiAZcA3?=
 =?us-ascii?Q?IMNFJT55uXcZ9PLod2pTxM3KwCljP5XIN58EvlHmbqjn+fmprtGtLWr+IEZ6?=
 =?us-ascii?Q?T6l09pR0KnTXpPdSdq2fx6ekH6dUwWIYYttcardLJt5uMJAAEUimVwgVxRC8?=
 =?us-ascii?Q?PJmu9AtkFaXO31D7pbMXDO1nZF4Yos7J83YiBO7x0xa1yLfZXwHt6hK9dZ2v?=
 =?us-ascii?Q?PHZkvPF/rqjma/CaUHuAI/7L9SQLPrnLi+SAPrrfsx7+25nGuUULBcBo5zlG?=
 =?us-ascii?Q?yz+ml7ROyBkwgnLj3d3OahuJN9e7qEA1PT7v3jD1RHIVG/AbgfWG1XB293hk?=
 =?us-ascii?Q?1VoBD+M7NfOGotbohB3smjELGMxN8RfqPv5PeKC5p+juV0vKGRz5/30KSOuB?=
 =?us-ascii?Q?Xl9n+9sei68uT+O2LdnydFyN7GzJd3JshE+swVASsc/57/QHWvZOpWh2sgV8?=
 =?us-ascii?Q?FNOlE4IBr+h2qjfUkkg+cByhPmIULI396USEcWI/2WaO2IDqn4cksGHhLfFj?=
 =?us-ascii?Q?T6pkiSBC3jcz0SwTrk+uOLGk6MDC8cJo13zjzgyIv5GIdZHWz/DF48tiWVFm?=
 =?us-ascii?Q?YJKFT/xUdqA38qkty27hNId4S2epbpAmrMZAKNdDzimVmGVqDUWPG5duQnOq?=
 =?us-ascii?Q?6XeNIgt7LYL5n1umhU7tj+/m6W2h9igmlAR3FKL4ztgMwEAgeDGAbrVH0jsO?=
 =?us-ascii?Q?JqUdDZ5mk56N/SvZMQ2GZOFflR7yQy401c+QMa7SAtBjgzgEVkQOPnIsB90r?=
 =?us-ascii?Q?Sl3SLxSmm1G1JLj1XK6xFyzBQ0eHs1dXD1JRwSFBvKvzjBpRTMU77XvOOFCi?=
 =?us-ascii?Q?brzx+LgTs2dec3elzQafYdXIzHhK7ruNcGD/3B9v+NK8Qfhib2JJetYTeCy9?=
 =?us-ascii?Q?Plx+s4VWR8YScgtD0h9ed+VchrXf9tY1nJqXlcmJJ8fc2KLUL1JoFMlO3GPB?=
 =?us-ascii?Q?I3yg69U=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nFvNcLMNLDhExX5CalEI6jM6chE1zLqB0DSzKLfpfxob16XnBJZEwV69fhsd?=
 =?us-ascii?Q?KxEUPCX2XBpzNzMM/5WA876hmnzWvCDJy4XQmp4WWg7jJHaNsLLHPdHjdeWE?=
 =?us-ascii?Q?2OFcTnv8CZLACoeD3IrgRQG74PLN7rd5LlFB1eG9ER3Z2YnEtkLHcsgcnyiR?=
 =?us-ascii?Q?fKXISlyN2NYEakwMU0pDUUxM8wRVwVC0BjqXDsunGzoT0X/s9sIV3POr704J?=
 =?us-ascii?Q?Q+U34nEG+x2zcr2cY7vUrAo9aR7fKinyO62xrBWSfeAvqyEccG/nU7SUxkMe?=
 =?us-ascii?Q?AzjWjSRnc/JoUXtOTFSrnMvmmTwUXGhxe3/n8vT3PdTkJi8GPahqABW2Jd5U?=
 =?us-ascii?Q?RR16MUuodtr2proc+umvRNAVqsjnlccwvPu4OAptett+J9ZK7fVJ8PnsLFIK?=
 =?us-ascii?Q?xsA9Dp2i9O7mW44UVGom96joUwA8kkqP2bjaE1Sv+KsfMnixvRY2DwjYZ1Ze?=
 =?us-ascii?Q?8HybDeNWod5pdKyxhXamPBOM99vHKKfR7AhP+ll3m2oGMAGJTbOd15N5i5eS?=
 =?us-ascii?Q?1aK0nX52ftZt4/hL8Juome6OJqEO8rPu5gA2qjnR4YiZjhvF2Ou8jQlKM9++?=
 =?us-ascii?Q?5UiAQIofR7sm+viZLSQaEI2vbJaXxj0for1a5oZ1ph+9jf50wdMc+cryUp3e?=
 =?us-ascii?Q?JWphmxQl1rjv4oANNdCe6VsbA9zv+1qj2K9qmC8nBmotCDXCAyB9FL4BUSsz?=
 =?us-ascii?Q?RoEI8Aor+3S6OpR74UEIPNH5PQhN2NBSUVYoG4qTLchuL/Q+x8nDeXAaLE7o?=
 =?us-ascii?Q?UEHRtTbj6wOjPY5GlxOYCRKexf/gv+TVBGXrNP4OlH5R2HQUc2hHH8w0/MLH?=
 =?us-ascii?Q?ISSS5kZYeCqHbrTo/Rjl1q9y71tZnShP4Fk0/Rxs1NiVsCAOpkgcVY50HVKB?=
 =?us-ascii?Q?M9CX0pdvvNFgwsExyqq3z6/tSrvLRfiYttmOIe2fBVo48pfOrDs63uTb9uhC?=
 =?us-ascii?Q?bdciK4NBzKc5imbvphaXkEnLidOOWetLWttDho6uPrixOP0nQVPTRbOAU5PV?=
 =?us-ascii?Q?T1+JBksyfmjBCAK/11xJ8w7p01ZP6siWWPf6X15DJUVJ+wE+ysoWu6naCgkY?=
 =?us-ascii?Q?P55ZwSsVAvHYqzu+4NeAFBk1A9aLlxzoPYeLs6f9yrVcVZoolw7EZT7Qpo2M?=
 =?us-ascii?Q?r/NU23PVfelN9wJjYcDER2u+7WYoJ4pePfzhHI9mwof7KALyFysu+D6NQWgb?=
 =?us-ascii?Q?Q04HqZrEkfRNL560/PwnF5hmCKRFu01nH3TbtIU++bd4c2JcajkotUtIGx2t?=
 =?us-ascii?Q?FXlmAlpUmhNrg1/IYZ1iHM5FLndVgH/j/dsgznqLwN05rDCoJR4DviCMgpHm?=
 =?us-ascii?Q?VPYxfJFdFTr7c/K3uVG0j2fdYjO50PhJHn2IVjRItzUt/Yez2ibhvKzhkPYu?=
 =?us-ascii?Q?VOEFNnAvXiNEyU1eM2RHNN9wY2s1IT9018lpMoSXJ/J1ckKKjFTVNEeGYNIv?=
 =?us-ascii?Q?1ijQX/g3xNswc9KbF50sIbkpIhfEROZ5Dz/o8mCfCs0jQXhpqFNH1nYuL8fX?=
 =?us-ascii?Q?zHOtvHB6WxIk4yUIzLjeyHaYt4Dpde0VaNbnaLm9JRhf9xSkSTUPPBa9xs3l?=
 =?us-ascii?Q?L+3soj6kM8Gu/4wbgJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c474928-f7ed-4ef2-2a7f-08dc84fc82a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 01:12:03.7411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzkFkspV8IM3oJu44k4uilHabOfnW2Oll8h94kzgh8VqWi+ehCVCbpFIgPKNz9H/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
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

[AMD Official Use Only - AMD Internal Distribution Only]

Review-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Sent: Friday, May 31, 2024 5:48 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>;
>Chang, HaiJun <HaiJun.Chang@amd.com>; Deng, Emily
><Emily.Deng@amd.com>
>Subject: [PATCH v3 2/8] drm/amdgpu: fix sriov host flr handler
>
>We send back the ready to reset message before we stop anything. This is
>wrong. Move it to when we are actually ready for the FLR to happen.
>
>In the current state since we take tens of seconds to stop everything, it =
is
>very likely that host would give up waiting and reset the GPU before we se=
nd
>ready, so it would be the same as before. But this gets rid of the hack wi=
th
>reset_domain locking and also let us know how slow the reset actually is o=
n
>the host. The pre-reset speed can thus be improved later.
>
>Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>---
>v3: still call amdgpu_virt_fini_data_exchange right away, it could take
>    awhile for the reset to grab it's lock and call this function in
>    pre_reset so during this time the thread will read garbage.
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 14 ++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  2 ++
> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 39 +++++++++-------------
> drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 39 +++++++++-------------
> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      |  6 ----
> 6 files changed, 50 insertions(+), 52 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index bf1a6593dc5e..eb77b4ec3cb4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5069,6 +5069,8 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       struct amdgpu_hive_info *hive =3D NULL;
>
>       if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags)) {
>+              amdgpu_virt_ready_to_reset(adev);
>+              amdgpu_virt_wait_reset(adev);
>               clear_bit(AMDGPU_HOST_FLR, &reset_context->flags);
>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>       } else {
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 3cf8416f8cb0..44450507c140 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -152,6 +152,20 @@ void amdgpu_virt_request_init_data(struct
>amdgpu_device *adev)
>               DRM_WARN("host doesn't support REQ_INIT_DATA
>handshake\n");  }
>
>+/**
>+ * amdgpu_virt_ready_to_reset() - send ready to reset to host
>+ * @adev:     amdgpu device.
>+ * Send ready to reset message to GPU hypervisor to signal we have
>+stopped GPU
>+ * activity and is ready for host FLR
>+ */
>+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev) {
>+      struct amdgpu_virt *virt =3D &adev->virt;
>+
>+      if (virt->ops && virt->ops->reset_gpu)
>+              virt->ops->ready_to_reset(adev);
>+}
>+
> /**
>  * amdgpu_virt_wait_reset() - wait for reset gpu completed
>  * @adev:     amdgpu device.
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index 642f1fd287d8..66de5380d9a1 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
>       int (*rel_full_gpu)(struct amdgpu_device *adev, bool init);
>       int (*req_init_data)(struct amdgpu_device *adev);
>       int (*reset_gpu)(struct amdgpu_device *adev);
>+      void (*ready_to_reset)(struct amdgpu_device *adev);
>       int (*wait_reset)(struct amdgpu_device *adev);
>       void (*trans_msg)(struct amdgpu_device *adev, enum idh_request
>req,
>                         u32 data1, u32 data2, u32 data3);
>@@ -345,6 +346,7 @@ int amdgpu_virt_request_full_gpu(struct
>amdgpu_device *adev, bool init);  int amdgpu_virt_release_full_gpu(struct
>amdgpu_device *adev, bool init);  int amdgpu_virt_reset_gpu(struct
>amdgpu_device *adev);  void amdgpu_virt_request_init_data(struct
>amdgpu_device *adev);
>+void amdgpu_virt_ready_to_reset(struct amdgpu_device *adev);
> int amdgpu_virt_wait_reset(struct amdgpu_device *adev);  int
>amdgpu_virt_alloc_mm_table(struct amdgpu_device *adev);  void
>amdgpu_virt_free_mm_table(struct amdgpu_device *adev); diff --git
>a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>index f4c47492e0cd..6b71ee85ee65 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>@@ -249,38 +249,30 @@ static int xgpu_ai_set_mailbox_ack_irq(struct
>amdgpu_device *adev,
>       return 0;
> }
>
>-static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>+static void xgpu_ai_ready_to_reset(struct amdgpu_device *adev)
> {
>-      struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
>flr_work);
>-      struct amdgpu_device *adev =3D container_of(virt, struct
>amdgpu_device, virt);
>-      int timeout =3D AI_MAILBOX_POLL_FLR_TIMEDOUT;
>-
>-      /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>-       * otherwise the mailbox msg will be ruined/reseted by
>-       * the VF FLR.
>-       */
>-      if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) !=3D 0)
>-              return;
>-
>-      down_write(&adev->reset_domain->sem);
>-
>-      amdgpu_virt_fini_data_exchange(adev);
>-
>       xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
>+}
>
>+static int xgpu_ai_wait_reset(struct amdgpu_device *adev) {
>+      int timeout =3D AI_MAILBOX_POLL_FLR_TIMEDOUT;
>       do {
>               if (xgpu_ai_mailbox_peek_msg(adev) =3D=3D
>IDH_FLR_NOTIFICATION_CMPL)
>-                      goto flr_done;
>-
>+                      return 0;
>               msleep(10);
>               timeout -=3D 10;
>       } while (timeout > 1);
>-
>       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL
>timeout\n");
>+      return -ETIME;
>+}
>
>-flr_done:
>-      atomic_set(&adev->reset_domain->in_gpu_reset, 0);
>-      up_write(&adev->reset_domain->sem);
>+static void xgpu_ai_mailbox_flr_work(struct work_struct *work) {
>+      struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
>flr_work);
>+      struct amdgpu_device *adev =3D container_of(virt, struct
>amdgpu_device,
>+virt);
>+
>+      amdgpu_virt_fini_data_exchange(adev);
>
>       /* Trigger recovery for world switch failure if no TDR */
>       if (amdgpu_device_should_recover_gpu(adev)
>@@ -417,7 +409,8 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
>       .req_full_gpu   =3D xgpu_ai_request_full_gpu_access,
>       .rel_full_gpu   =3D xgpu_ai_release_full_gpu_access,
>       .reset_gpu =3D xgpu_ai_request_reset,
>-      .wait_reset =3D NULL,
>+      .ready_to_reset =3D xgpu_ai_ready_to_reset,
>+      .wait_reset =3D xgpu_ai_wait_reset,
>       .trans_msg =3D xgpu_ai_mailbox_trans_msg,
>       .req_init_data  =3D xgpu_ai_request_init_data,
>       .ras_poison_handler =3D xgpu_ai_ras_poison_handler, diff --git
>a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>index 37b49a5ed2a1..22af30a15a5f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
>@@ -282,38 +282,30 @@ static int xgpu_nv_set_mailbox_ack_irq(struct
>amdgpu_device *adev,
>       return 0;
> }
>
>-static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>+static void xgpu_nv_ready_to_reset(struct amdgpu_device *adev)
> {
>-      struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
>flr_work);
>-      struct amdgpu_device *adev =3D container_of(virt, struct
>amdgpu_device, virt);
>-      int timeout =3D NV_MAILBOX_POLL_FLR_TIMEDOUT;
>-
>-      /* block amdgpu_gpu_recover till msg FLR COMPLETE received,
>-       * otherwise the mailbox msg will be ruined/reseted by
>-       * the VF FLR.
>-       */
>-      if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) !=3D 0)
>-              return;
>-
>-      down_write(&adev->reset_domain->sem);
>-
>-      amdgpu_virt_fini_data_exchange(adev);
>-
>       xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
>+}
>
>+static int xgpu_nv_wait_reset(struct amdgpu_device *adev) {
>+      int timeout =3D NV_MAILBOX_POLL_FLR_TIMEDOUT;
>       do {
>               if (xgpu_nv_mailbox_peek_msg(adev) =3D=3D
>IDH_FLR_NOTIFICATION_CMPL)
>-                      goto flr_done;
>-
>+                      return 0;
>               msleep(10);
>               timeout -=3D 10;
>       } while (timeout > 1);
>-
>       dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL
>timeout\n");
>+      return -ETIME;
>+}
>
>-flr_done:
>-      atomic_set(&adev->reset_domain->in_gpu_reset, 0);
>-      up_write(&adev->reset_domain->sem);
>+static void xgpu_nv_mailbox_flr_work(struct work_struct *work) {
>+      struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
>flr_work);
>+      struct amdgpu_device *adev =3D container_of(virt, struct
>amdgpu_device,
>+virt);
>+
>+      amdgpu_virt_fini_data_exchange(adev);
>
>       /* Trigger recovery for world switch failure if no TDR */
>       if (amdgpu_device_should_recover_gpu(adev)
>@@ -455,7 +447,8 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops =3D {
>       .rel_full_gpu   =3D xgpu_nv_release_full_gpu_access,
>       .req_init_data  =3D xgpu_nv_request_init_data,
>       .reset_gpu =3D xgpu_nv_request_reset,
>-      .wait_reset =3D NULL,
>+      .ready_to_reset =3D xgpu_nv_ready_to_reset,
>+      .wait_reset =3D xgpu_nv_wait_reset,
>       .trans_msg =3D xgpu_nv_mailbox_trans_msg,
>       .ras_poison_handler =3D xgpu_nv_ras_poison_handler,  }; diff --git
>a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>index 78cd07744ebe..e1d63bed84bf 100644
>--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
>@@ -515,12 +515,6 @@ static void xgpu_vi_mailbox_flr_work(struct
>work_struct *work)
>       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
>flr_work);
>       struct amdgpu_device *adev =3D container_of(virt, struct
>amdgpu_device, virt);
>
>-      /* wait until RCV_MSG become 3 */
>-      if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
>-              pr_err("failed to receive FLR_CMPL\n");
>-              return;
>-      }
>-
>       /* Trigger recovery due to world switch failure */
>       if (amdgpu_device_should_recover_gpu(adev)) {
>               struct amdgpu_reset_context reset_context;
>--
>2.34.1

