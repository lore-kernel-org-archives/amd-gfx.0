Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B33C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 08:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF90510EF13;
	Fri, 26 Apr 2024 08:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u1vlz5++";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32F210EF13
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 08:42:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFgnjzhDQlktGtXQpZFBQ9QhO5bXHA0pj3Zl0bmWCEySdSosBmpU4a6rHeKkh9X37lpaB6UnUkm6i+QVO+qTuMFVpb8CJGfUkbFzddoaLsLuftglrtxZ6DVXS/4CP/cppeKxmKUqsUl0/UAxq3cqAWMI2tBJZsmAmU6+Umyf1et3UvZ23uPn2A+Na8gmiFt/AHOs9lYX6Airl8H6uttoZgZ2ZHG4+JS6KjquHzf8shXiAbmCcVDc/RxyqquJ6X+IDG12/V/vPUaKCleRWAq3l2uHJynXgtkarzyHQakPl5QZZNpqlThMpui1VgOBgITuppoC4K5gTSwIUo3+hThjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyEG5e06lxNUaRjwULdkWNauNFrRirNdXv2iTtDM4No=;
 b=WY+9ucq4Yy7nmeMkFnhjnSpbKDKFFsiTx+77xmnC2PnTsrR9PEDhSIV6xmR6xkRfX8RincC31iNtPiEigakpOZyVfMXcB9QltIByJuUV/oXwtCTtAzVcaIUDtfee/JznJvLRM+NFHfIxpc5G3yajxRBIqThHlQa2pPLb4ly5n3XA5JY+D2EqCDmYwFGBqmZPBvgntCdXZmlhfvWoRulNqzZ4efWK6fr6IYGMSH/F0UULMG9pIzvLEHh1hn2ZoHTQslJVOqq0OZqizpDeP82qH7HnIpwduk9Foo4CyPM94HsG6pdxUh2QSh8R/0FsoV/6gx4DVfwkgKSrFR+eDDSQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyEG5e06lxNUaRjwULdkWNauNFrRirNdXv2iTtDM4No=;
 b=u1vlz5++eGXnwps8HMOHSINZS82NSFnYzBPWCAZe44acQoS+AvewJfKOqTF63tYC0duhK3vzzpd8jEeiUdVlEQCWCDuPPvssS7m0UlDulUsiuILC/vxu1va9UaJtstpilHg9FPXMakKye+2MEF8Kki55ZXvNML1+YYUaqITtLyo=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by BL1PR12MB5971.namprd12.prod.outlook.com (2603:10b6:208:39a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 08:42:14 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 08:42:14 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Thread-Topic: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
Thread-Index: AQHal44Y4yM++kV5fkSWg7MhanfFpbF6O21g
Date: Fri, 26 Apr 2024 08:42:13 +0000
Message-ID: <PH0PR12MB54174BB456485AF0340981E78F162@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <20240426035742.90560-3-Yunxiang.Li@amd.com>
In-Reply-To: <20240426035742.90560-3-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=881077ee-c0cd-449e-ac58-211eed5d4cc7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T08:39:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|BL1PR12MB5971:EE_
x-ms-office365-filtering-correlation-id: e164fe94-536d-4a85-f345-08dc65ccc57f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?4eA1zNRztkc6M7lconIs9aGCsjfuqMPMqFFBxEZuW1rP77bgVS2VTz5whi3A?=
 =?us-ascii?Q?Bti9el3J4qyEY7PL+cuYO/qtyhwMSwCDH/qXWzfivyU+KSM+O3/1RbtiRlkA?=
 =?us-ascii?Q?I1jkCBDBL3vHinVhMuDmL8I3OCG/0OxT51OMk9eth4jVaVFrTlJGxAw1er6v?=
 =?us-ascii?Q?Ep9jNJGmDGERLN1ZvW3exZnDexoFhD6l19KpoPzcESk6+XkeWpWyD6La5kxR?=
 =?us-ascii?Q?X9Btr0wNZxzqWzPobxHtRZmt8+ECl6PgNMxmPAmQ4wwrgxFzXkcdWTnvLyhm?=
 =?us-ascii?Q?ejXLpj1pUPh27X3DGti4e9FZGsOe23+q67xt72ntVCCVKtQEAwkSa7kq7sOH?=
 =?us-ascii?Q?+QKPAgbxLp16+cWWpeUha4QhEMjf6X0mFz0pZmgPFK0GDw7VNFCI+P/VNj4v?=
 =?us-ascii?Q?xTXCYZKAigDo7PrKZMZy8ZBxrqVJj9GtG8T6heOv3ilrVn6ICMRcw99wf9YC?=
 =?us-ascii?Q?mG4WVvY0rjemK5yp3rUHJdxr43YycTZr/dM/CKNaxuG5blm2KK+lha1bV/aX?=
 =?us-ascii?Q?S7xizbuIXLqOgHbK/6oD70KhMVZQZfrTNsii69I5t72Gn3p2QT4OQF3S4iO9?=
 =?us-ascii?Q?bHOam/Qbw5ssUtUS54LUqNmQMoLaJO1KIjmTPJx9iGNoROAdm7XErQkYkGU6?=
 =?us-ascii?Q?RkNFaiSMmcx3F6f/nsFu7YSJB1SZ05+RGlsXUR7mxVdQ1d/9uammsD9KuJSF?=
 =?us-ascii?Q?IYRkcM9yRfAHt1oGSe8s8Gr96XFIvHgx6+B+rCP8E7IchZJmOHWYYfFkGlGS?=
 =?us-ascii?Q?ibN1y1nftxxWdgo0cg5jSojxTOMNwrF2qI9G/qi6VWJXrBxaPfkbEhari0R0?=
 =?us-ascii?Q?jQemP4XvhXextdrARZKNj4H/r/OT3QxXjjgjcSMpzcRX/N+ABevPAzUz+Fy1?=
 =?us-ascii?Q?j5b5doN4YLlVxi7Vq+rCF46i28UU6s+RjkvAIWZjLodFbMVEkv1Xiy0I+Gfa?=
 =?us-ascii?Q?oqnqxofVEveMG4u56reghZtLWuFfGctOyqgcfAX5lhv8yy7KlEa1eGTK68Ka?=
 =?us-ascii?Q?FWPlRoFVJs7kRsiaVRoGDPuHXw2/m/uX32YYf3Ix3u7cV3SPcROPdpD6lVHI?=
 =?us-ascii?Q?m+AjXDGvGwf9YuR6xqq4/Y5LbZhoeW9ssIyzTa+j5Z9QHEFWZbVLsHJu0YCe?=
 =?us-ascii?Q?EmgujUwWf1REHg4c9j4aBG/IES2pD25P3w3VTWON5xu05egdAc/1+QZD/gjl?=
 =?us-ascii?Q?cNqvaAkHmF6GbMzUNw/rxQG6hNtrSXxlVqVM+DzpVz+plgOxadW6ZvuiFJ1U?=
 =?us-ascii?Q?Zy/9XfFxqvXkK0KXsxEZJf5XPR0GG/EjXjkgeLhdriTtbyVXs5HHjZgu9qto?=
 =?us-ascii?Q?igQCYxLwGl7dE+v4/VR7v7o2lfZ6SvBkrCOepXu54XfcwA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zOB3uE/Wb957icbY2U3B8gOru6kIAoJlQr2wUUtYGR4js0atdQtXMizL0J1P?=
 =?us-ascii?Q?QbD6o8BNreW9guyp6sYEZ1kmLqOTtLdurTmVusSpdYLGFsfHVw6WAOVggOCb?=
 =?us-ascii?Q?TAo/IHFoWyNRoYdHmBXcxlEZxSfAlwlDButsc1x5DbXXIBJJNTLh1nQ2cgAa?=
 =?us-ascii?Q?g1ST/aaBILa7gQ5bXjVM+NLSAU3nafMD4opEl2b/xBX41TXIWbOkmALYvBYK?=
 =?us-ascii?Q?tc7UyGS3vCpF1yhiaw/Y7+HxdMZIesWc0a61vghZW+QgBSM6T+DnJr7a22an?=
 =?us-ascii?Q?XOnKWMbKzgwUyhpW45Lnpj5jALawuzRMrelg3MWAsudgQEg+rgKTYlBM2pAn?=
 =?us-ascii?Q?ipI8ZTJrcdHM5qjG+OS1MUtbRT6pdGbtKNDelEyDY6gIrSch4oEgw7dWVtME?=
 =?us-ascii?Q?bB5QF/t15jS67T6y32L+A7oIFPRev0Lyxjq/sG9E8v1HeVevceywjaxLq6fm?=
 =?us-ascii?Q?B2BUrxNiXYvFWSIXaBtS8sOl0KbwyN1kPqcGBmw7qDUYIIL4mofVPG+o4dBQ?=
 =?us-ascii?Q?LVJ0YFFJz2JyeBloCAumdu2mLzxf6KiVpvc1wxLO0S2g9IvZ3AC0Wi9hGvVe?=
 =?us-ascii?Q?FmPIDCx0LHGJoZdoOOQl3QPjJOXNC/GezZUlcxPa5jKhYZnig/PQojmNR7JF?=
 =?us-ascii?Q?qIoegXk46XULbASOh0am8xwT4oIS4fNlQBOZt3jSueFhwxkrmd/WQ04Jgspg?=
 =?us-ascii?Q?Gi872uQeFE1mAihXvgaKEDyfHF8HJxFZ5KCgKQH2IIVLGKhJbthmu/4AO0iZ?=
 =?us-ascii?Q?3A6hbLcxW5SuW01DtljKCc8fewje1+gqfppPzAdLfiwh2rV5mNBiCD1FBFMv?=
 =?us-ascii?Q?OLY3PGGTGHzPj3+SryaBNWGTy7o8RLNsGN8qApXQfxGG6lIUO6XaV2XozYFl?=
 =?us-ascii?Q?+5GqPi2aAuwLFMO3FbZl+aovBd6zMhCHGr2Py9ce6AZdhe2DFUoZ8RW/DgH7?=
 =?us-ascii?Q?78VaHQNrMT95ldmIvScwdz9GwYD93PoVqzVqjjm/hREFmI/GHz5/7MJMc5Um?=
 =?us-ascii?Q?wwXXI3cO6awl6lGu5hKXGGdc3uRzWGa49/LKnGAXD3lREXQ+mwKwvFYcmwoC?=
 =?us-ascii?Q?JMwPFTtNL9GKW+zGm0oKvJA0T2qkApcO9TsNrobyWAiDi4kcqEVUwmaZe8cH?=
 =?us-ascii?Q?fgRfSD7OBnenp8DEFyrdusD3aFSuhvEfzxyVVLxHgFku9TvbHYPAawUnLGB3?=
 =?us-ascii?Q?vVesf2AUOj9qCROseRv//3BFA1Gva8KWzeRu8fHEljaklJ4MXgx6ba7g1ZKS?=
 =?us-ascii?Q?uJ02FOV41UC7UflyeTuB/UusC4XZC1soXogfS9YZ+0yWR8wu6QCojxvEyQHw?=
 =?us-ascii?Q?1NIesW/oqGlNbiWQSv5Csg8G+lQDY1YfpxAjgvPda2P9hal4VzAKxMu2p+EH?=
 =?us-ascii?Q?LVfidc4XIQrsyrICrliRqMQOsatUdIKkLHtsBgj4kcztQ8i/yoTYZVaJzpc4?=
 =?us-ascii?Q?e7lOrPqxxTedxipJ2RVuWx08nnpmq1ILaUqehidTZ/l23w1P369G7i4UtTsR?=
 =?us-ascii?Q?lUQD8iFq9PS8YKXLRy3OoDLPqpUeexckA4Sj2jvdIZDARttsKvLopAz+1SRL?=
 =?us-ascii?Q?vh5wuvSPX+s67k5oSHU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e164fe94-536d-4a85-f345-08dc65ccc57f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 08:42:14.0506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoKcTlf1Gh9lHNQLmFT4co/fJv1gSR4x2FCNypO74KgsZ5ChsDdc7U9emb4wX1F+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5971
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

[AMD Official Use Only - General]

>-----Original Message-----
>From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Sent: Friday, April 26, 2024 11:58 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling,
>Felix <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li,
>Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Subject: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
>
>The retry loop for SRIOV reset have refcount and memory leak issue.
>Depending on which function call fails it can potentially call
>amdgpu_amdkfd_pre/post_reset different number of times and causes
>kfd_locked count to be wrong. This will block all future attempts at openi=
ng
>/dev/kfd. The retry loop also leakes resources by calling
>amdgpu_virt_init_data_exchange multiple times without calling the
>corresponding fini function.
>
>Align with the bare-metal reset path which doesn't have these issues.
>This means taking the amdgpu_amdkfd_pre/post_reset functions out of the
>reset loop and calling amdgpu_device_pre_asic_reset each retry which
>properly free the resources from previous try by calling
>amdgpu_virt_fini_data_exchange.
>
>Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ++++++++++------------
> 1 file changed, 22 insertions(+), 28 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 1fd9637daafc..3c4755f3c116 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5063,19 +5063,14 @@ static int amdgpu_device_recover_vram(struct
>amdgpu_device *adev)  static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>                                    struct amdgpu_reset_context
>*reset_context)  {
>-      int r;
>+      int r =3D 0;
>       struct amdgpu_hive_info *hive =3D NULL;
>-      int retry_limit =3D 0;
>-
>-retry:
>-      amdgpu_amdkfd_pre_reset(adev);
>
>       if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
>               r =3D amdgpu_virt_request_full_gpu(adev, true);
>       else
>               r =3D amdgpu_virt_reset_gpu(adev);
>-      if (r)
>-              return r;
Why remove this?

Emily Deng
Best Wishes


>+
>       amdgpu_ras_set_fed(adev, false);
>       amdgpu_irq_gpu_reset_resume_helper(adev);
>
>@@ -5085,7 +5080,7 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       /* Resume IP prior to SMC */
>       r =3D amdgpu_device_ip_reinit_early_sriov(adev);
>       if (r)
>-              goto error;
>+              return r;
Need to call amdgpu_virt_release_full_gpu(adev, true) before retry, and the=
 same as below.

Emily Deng
Best Wishes

>       amdgpu_virt_init_data_exchange(adev);
>
>@@ -5096,38 +5091,35 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       /* now we are okay to resume SMC/CP/SDMA */
>       r =3D amdgpu_device_ip_reinit_late_sriov(adev);
>       if (r)
>-              goto error;
>+              return r;
>
>       hive =3D amdgpu_get_xgmi_hive(adev);
>       /* Update PSP FW topology after reset */
>       if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>               r =3D amdgpu_xgmi_update_topology(hive, adev);
>-
>       if (hive)
>               amdgpu_put_xgmi_hive(hive);
>+      if (r)
>+              return r;
>
>-      if (!r) {
>-              r =3D amdgpu_ib_ring_tests(adev);
>-
>-              amdgpu_amdkfd_post_reset(adev);
>-      }
>+      r =3D amdgpu_ib_ring_tests(adev);
>+      if (r)
>+              return r;
>
>-error:
>-      if (!r && adev->virt.gim_feature &
>AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
>+      if (adev->virt.gim_feature &
>AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
>               amdgpu_inc_vram_lost(adev);
>               r =3D amdgpu_device_recover_vram(adev);
>       }
>-      amdgpu_virt_release_full_gpu(adev, true);
>+      if (r)
>+              return r;
>
>-      if (AMDGPU_RETRY_SRIOV_RESET(r)) {
>-              if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
>-                      retry_limit++;
>-                      goto retry;
>-              } else
>-                      DRM_ERROR("GPU reset retry is beyond the retry
>limit\n");
>-      }
>+      /* need to be called during full access so we can't do it later lik=
e
>+       * bare-metal does.
>+       */
>+      amdgpu_amdkfd_post_reset(adev);
>+      amdgpu_virt_release_full_gpu(adev, true);
>
>-      return r;
>+      return 0;
> }
>
> /**
>@@ -5686,6 +5678,7 @@ int amdgpu_device_gpu_recover(struct
>amdgpu_device *adev,
>       int i, r =3D 0;
>       bool need_emergency_restart =3D false;
>       bool audio_suspended =3D false;
>+      int retry_limit =3D AMDGPU_MAX_RETRY_LIMIT;
>
>       /*
>        * Special case: RAS triggered and full reset isn't supported @@ -
>5767,8 +5760,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>*adev,
>
>               cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>
>-              if (!amdgpu_sriov_vf(tmp_adev))
>-                      amdgpu_amdkfd_pre_reset(tmp_adev);
>+              amdgpu_amdkfd_pre_reset(tmp_adev);
>
>               /*
>                * Mark these ASICs to be reseted as untracked first @@ -
>5827,6 +5819,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
>*adev,
>       /* Host driver will handle XGMI hive reset for SRIOV */
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D amdgpu_device_reset_sriov(adev, reset_context);
>+              if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0)
>+                      goto retry;
>               if (r)
>                       adev->asic_reset_res =3D r;
>
>--
>2.34.1

