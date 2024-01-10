Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DCAC47073
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jan 2024 22:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F7210E68A;
	Wed, 10 Jan 2024 22:35:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E32210E639
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jan 2024 22:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEjelhqTBXw5Hp3Bcsgh1WUvkTZe8ujxm63+7n23wnm4pj5/HSdNQ46c4Fa7+o5Qa21r5dHFO0bCFC+znkDltL9KVgA3zfSaRVVpj8uI+e2KbdnbKDucLxDaCh87CnW8ZL0fMfcqPUuEY4naJwQqbPVmRGHenC5sXnwR/lycuwqTEckDbukFK2ppIa8ZXQbJGujMtVUxdmayyvuZldtw7rlEvKDSYM5vMDBIxoA2Yc+zvqPI3Jlv8eXbYsXJSff2hjSgf6KbAznRBShtZLlayOAjOyt3p57xIMelirHcCO2jYaYJHjaBEfb0vaoXnlWQU7oaGqpfrQxKRtiumN/TEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R55/Z5WA1IEFtMqCt1wh+x042SoOcomuIFdMHs09xg8=;
 b=OvLJBsr47vRnajKiO1eEiNYB6wLgcTBToHf7ncpfCH0b5dCPYXAQ0NpOHF2ShcP0pr+LIjwi4qu1dqZxrXs7Ju0M0whJIlJ/GzaVDGwhGiP+snVxakMtKsiOnxcqvY4idtHGLkhF6V0y/09l2wEy/dJaek2m13OeHC1wzwx1WQ+t7KO92vF0prCBvVHnnHKlgwPzwSjYIqvSQy270zkxepZ637xoiZ2u96YuICwlkspDW3u+9QKLMnmiATbPCOvWDxVhBRoPX9CJ97adNf8tRgPD9dQEdSF6dL6Ux0gbk54w/NpvQCCwgZJSlqAEdRFQ0/IiunA4QtlBBDCpz1S7qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R55/Z5WA1IEFtMqCt1wh+x042SoOcomuIFdMHs09xg8=;
 b=4TQvmjIHj/bvOjNRyezurjLy/AD3ubxrCkz6Faao3HpmGI06lP62on4ExaUyEljtQzwjNl4g5hqAK5XvwkRxmDEag3Xhcum8DLxztAOSJoo2ppeXDBixMvmJYXGJ9DzUgNoZceCxxAUULRt1xIurcBh/knt+0emMgcVa8VKoHmc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8257.namprd12.prod.outlook.com (2603:10b6:610:121::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 10 Jan
 2024 22:35:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 22:35:22 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: revert "Adjust removal control flow for smu
 v13_0_2"
Thread-Topic: [PATCH] drm/amdgpu: revert "Adjust removal control flow for smu
 v13_0_2"
Thread-Index: AQHaQ9HDNXBHHnsvV0C+YQQtE+C/c7DTotuT
Date: Wed, 10 Jan 2024 22:35:22 +0000
Message-ID: <BL1PR12MB51448FF3ED7334D8D809AE0BF7692@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240110143149.2446-1-christian.koenig@amd.com>
In-Reply-To: <20240110143149.2446-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-10T22:35:21.850Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8257:EE_
x-ms-office365-filtering-correlation-id: b0f42a0e-a5d7-4176-6f5a-08dc122c6e87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b8M9aob4RsqA9sthmWaWrsAMRronLNAnpvuSSSnR0QUEXMF4CWV2rwDfWHYyR/qmWHkWy953AvkKsJInahNa1C86IFeASLV/nTNhVp5zboWQkEEZwnTbQbbgY3Vv6Yr/zJMiEE3ZZ3w3eQqJguBVYUYGSuOc8yCIjgIwuk5EyHQBUdkFMoEHW/DpnKbGclgTXRrvkr01lJIMR9Pk4XTsX/ln7eOx39uf+JnyZja+dvqQ5MKP2HRFYYyp0IT24JP/tyiDc8V1+TeSIIDz2ueyEyxtJM5rKxq8m43NP1FAY8SDuYfTCJ9YoSJPslEoeSJspVTvuN6F445cJwP+t+fwfxYI2VEeWOhHgljkjs9g59mMCkg/MnSylVLs6thBBdLt8rj00oGTxrvCkWCGS8NL2QnxYvfvwvzCO6ZMccjyAZQD131Kf6Vr/5zZ2b8u7megnmslCUroOwmkc60oPTYNTsNE2ljsRxrysZvLhsaoa5aNgxpxRbknw4Jr2CN+4GSKeSI0oBFntAAHEQsss5+quM90nR8rVn46i0bhg688bEQ0IBOTDA8ihsRZCb7NvsGBJ7osGSQ1uYJeC+BlF2fkS5mjFg5n3CwoH8JxNjqt1w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(122000001)(38100700002)(38070700009)(33656002)(86362001)(41300700001)(66574015)(8936002)(52536014)(8676002)(316002)(71200400001)(66476007)(66556008)(66946007)(64756008)(66446008)(76116006)(19627405001)(110136005)(26005)(6506007)(7696005)(9686003)(53546011)(478600001)(2906002)(5660300002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3FgWXE31gVm8XnIR7sdEE2gBNQ5U/SXAnPXEHmi9S6VpH9NYP2KQB9Y7OS?=
 =?iso-8859-1?Q?Ka/3IpqtPn+wIHcPWROTv3ijcyvNdoW7kSlp4hwhaCKu0l7vuaDOrCGwNO?=
 =?iso-8859-1?Q?fGALqch1wkdK5paDKDizjO+Vx+w1njFTHzI3ax/l8viHw9RiOO7gWXPeC4?=
 =?iso-8859-1?Q?AS8NYqEbSAyRUwORnaEj5+owbCKxI9Rgv/X7OlGkhrI+0gzaEisQKGXe+y?=
 =?iso-8859-1?Q?0dpEddxQ9NExF4R2kwWg+5HQtEnNuO81lP9fGlEpiT00oBQ/raF5Vjomth?=
 =?iso-8859-1?Q?IwwYWqWmIjczzKMgy1ISVNu5SqssaY0Ih6YCK9352qlEhNLBNJ4bd7nUYI?=
 =?iso-8859-1?Q?u9pbrpcdRpYhzHONpJTTCNSulFQFSzaDq2Fh/YVGDUYKmjAK8T/Dae+0Xw?=
 =?iso-8859-1?Q?xJ6Kryriv60qRXDsndZ6K/M+Jy/nD2pSmoj2yemxvVWGqmrRxd0Sn/4y3+?=
 =?iso-8859-1?Q?MYL1zDIKUbWvIhfZlyWg+NXhBjfJLq0SZiVbpTNJbVnWSC7NzLuOCiwthH?=
 =?iso-8859-1?Q?D1z9T6B69zAv/LZZpvSE1EOQnEwXCIf7WuCH7y1+mpktfuSmIoWKUT5WyG?=
 =?iso-8859-1?Q?8za0blyBjJsWTtwz58NrifyoDU3yhj29EU2BtqlBQQQvd7X5Our6mLJHi+?=
 =?iso-8859-1?Q?uvHvQhmo78gvMudgehIAMwZcF9kGiLUhVoJcNX5W7FbyVDDECeAsZ5S0Vd?=
 =?iso-8859-1?Q?dKziW9/zq3utszjgolXxiWG23zK7dRnOH0lwIn24RwTKojBcxgCbC18+uC?=
 =?iso-8859-1?Q?VbEv8en9HD16P63TJN+4BYyCbB2b9LQBTdWiCvw8iPal6rMzvLhg5jl6V2?=
 =?iso-8859-1?Q?P34X9jxCtdqRellDV3pZPccIOT7gVl8gbLttNTO2UulHuAOn9HDwwTFKTT?=
 =?iso-8859-1?Q?odtltRHySwFC1Z68G2D1aaz7QimD/BlpKk5tAXu+aw0cjqxPKF2KlyCsuS?=
 =?iso-8859-1?Q?RVWKbXndfX9FeJdnzD1ZOlSB7NLpRybL0y2oV60i7mO2ZVchbdf37oulTx?=
 =?iso-8859-1?Q?WGx2xqFFoEndLtmebAtonnvRStGj7xi6YrT4JVzrfyJkcJk3Rj8XgLVGUD?=
 =?iso-8859-1?Q?nGyDqN/8MnOcmdHX9GbjaK/cnKw4/B7YCzDlGI0dBfn7GkdJtCNg9ij5Ei?=
 =?iso-8859-1?Q?b1LRm6jhM2atRDm9Gxj2iB6PszSdpmQtBiZWG08KtcOY01+f3r/TlHmGLj?=
 =?iso-8859-1?Q?PXM5FJhVUYurR6HSDnCGzroDLY+53cQ+P25xSnTFFtwF3NVlo42ktDbxRa?=
 =?iso-8859-1?Q?7t+1eSGdOUe1/damU9/hMSQOoPrOrRHg25er26d5Uj2FepA88R774T/Uqz?=
 =?iso-8859-1?Q?1qS/zhtRNaEnDOPC7/Vds4Ke80uxMXof6H1P1dXcOPQTk1zGg5g3q0xwvQ?=
 =?iso-8859-1?Q?4JcSfX3d+JGdLEnQpsRfcyrUAkyNbPHGWsH04qVQEnH3ChMyQGaKqfcLBp?=
 =?iso-8859-1?Q?9uPpIrYQDJXIUi561GvZrfZN7ZZny5z20asXKA027WQvat3nYiNeQPQEe9?=
 =?iso-8859-1?Q?DgAZfCg2i9KZpcN/ebKDmQnO41xdT1FB8qzSwD3+WyqEIkuSNv6+xrmdaK?=
 =?iso-8859-1?Q?fg5lB5yTd77uUala5gyfo5cHunR71ImIniuuHexdAfIfFnsE00ekh/RzF+?=
 =?iso-8859-1?Q?v3nSJlFdz13Co=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51448FF3ED7334D8D809AE0BF7692BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f42a0e-a5d7-4176-6f5a-08dc122c6e87
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 22:35:22.1545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hF15zynejmqgT8pnQud6P83DasoDwfgXRJ6v7x2txI0N5QHRw/peRqyb6PYFrMm2rroMXmPEClLpnRgwKwLnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8257
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

--_000_BL1PR12MB51448FF3ED7334D8D809AE0BF7692BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Wednesday, January 10, 2024 9:31 AM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; D=
eucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.or=
g <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: revert "Adjust removal control flow for smu v1=
3_0_2"

Calling amdgpu_device_ip_resume_phase1() during shutdown leaves the
HW in an active state and is an unbalanced use of the IP callbacks.

Using the IP callbacks like this can lead to memory leaks, double
free and imbalanced reference counters.

Leaving the HW in an active state can lead to DMA accesses to memory now
freed by the driver.

Both is a complete no-go for driver unload so completely revert the
workaround for now.

This reverts commit f5c7e7797060255dbc8160734ccc5ad6183c5e04.

Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 32 ----------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   |  1 -
 4 files changed, 1 insertion(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a39c9fea55c4..313316009039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5232,7 +5232,6 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
         struct amdgpu_device *tmp_adev =3D NULL;
         bool need_full_reset, skip_hw_reset, vram_lost =3D false;
         int r =3D 0;
-       bool gpu_reset_for_dev_remove =3D 0;

         /* Try reset handler method first */
         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
@@ -5252,10 +5251,6 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                 test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
         skip_hw_reset =3D test_bit(AMDGPU_SKIP_HW_RESET, &reset_context->f=
lags);

-       gpu_reset_for_dev_remove =3D
-               test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_context->fl=
ags) &&
-                       test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->fl=
ags);
-
         /*
          * ASIC reset has to be done on all XGMI hive nodes ASAP
          * to allow proper links negotiation in FW (within 1 sec)
@@ -5298,18 +5293,6 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,
                 amdgpu_ras_intr_cleared();
         }

-       /* Since the mode1 reset affects base ip blocks, the
-        * phase1 ip blocks need to be resumed. Otherwise there
-        * will be a BIOS signature error and the psp bootloader
-        * can't load kdb on the next amdgpu install.
-        */
-       if (gpu_reset_for_dev_remove) {
-               list_for_each_entry(tmp_adev, device_list_handle, reset_lis=
t)
-                       amdgpu_device_ip_resume_phase1(tmp_adev);
-
-               goto end;
-       }
-
         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
                 if (need_full_reset) {
                         /* post card */
@@ -5543,11 +5526,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,
         int i, r =3D 0;
         bool need_emergency_restart =3D false;
         bool audio_suspended =3D false;
-       bool gpu_reset_for_dev_remove =3D false;
-
-       gpu_reset_for_dev_remove =3D
-                       test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_con=
text->flags) &&
-                               test_bit(AMDGPU_NEED_FULL_RESET, &reset_con=
text->flags);

         /*
          * Special case: RAS triggered and full reset isn't supported
@@ -5585,7 +5563,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
         if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes >=
 1)) {
                 list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi=
.head) {
                         list_add_tail(&tmp_adev->reset_list, &device_list)=
;
-                       if (gpu_reset_for_dev_remove && adev->shutdown)
+                       if (adev->shutdown)
                                 tmp_adev->shutdown =3D true;
                 }
                 if (!list_is_first(&adev->reset_list, &device_list))
@@ -5670,10 +5648,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,

 retry:  /* Rest of adevs pre asic reset from XGMI hive. */
         list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-               if (gpu_reset_for_dev_remove) {
-                       /* Workaroud for ASICs need to disable SMC first */
-                       amdgpu_device_smu_fini_early(tmp_adev);
-               }
                 r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_context=
);
                 /*TODO Should we stop ?*/
                 if (r) {
@@ -5705,9 +5679,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                 r =3D amdgpu_do_asic_reset(device_list_handle, reset_conte=
xt);
                 if (r && r =3D=3D -EAGAIN)
                         goto retry;
-
-               if (!r && gpu_reset_for_dev_remove)
-                       goto recover_end;
         }

 skip_hw_reset:
@@ -5763,7 +5734,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,
                 amdgpu_ras_set_error_query_ready(tmp_adev, true);
         }

-recover_end:
         tmp_adev =3D list_first_entry(device_list_handle, struct amdgpu_de=
vice,
                                             reset_list);
         amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 852cec98ff26..b7de48effe7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2336,38 +2336,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
                 pm_runtime_forbid(dev->dev);
         }

-       if (amdgpu_ip_version(adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13, 0, 2=
) &&
-           !amdgpu_sriov_vf(adev)) {
-               bool need_to_reset_gpu =3D false;
-
-               if (adev->gmc.xgmi.num_physical_nodes > 1) {
-                       struct amdgpu_hive_info *hive;
-
-                       hive =3D amdgpu_get_xgmi_hive(adev);
-                       if (hive->device_remove_count =3D=3D 0)
-                               need_to_reset_gpu =3D true;
-                       hive->device_remove_count++;
-                       amdgpu_put_xgmi_hive(hive);
-               } else {
-                       need_to_reset_gpu =3D true;
-               }
-
-               /* Workaround for ASICs need to reset SMU.
-                * Called only when the first device is removed.
-                */
-               if (need_to_reset_gpu) {
-                       struct amdgpu_reset_context reset_context;
-
-                       adev->shutdown =3D true;
-                       memset(&reset_context, 0, sizeof(reset_context));
-                       reset_context.method =3D AMD_RESET_METHOD_NONE;
-                       reset_context.reset_req_dev =3D adev;
-                       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flag=
s);
-                       set_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &reset_cont=
ext.flags);
-                       amdgpu_device_gpu_recover(adev, NULL, &reset_contex=
t);
-               }
-       }
-
         amdgpu_driver_unload_kms(dev);

         /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h
index b0335a1c5e90..19899f6b9b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -32,7 +32,6 @@ enum AMDGPU_RESET_FLAGS {

         AMDGPU_NEED_FULL_RESET =3D 0,
         AMDGPU_SKIP_HW_RESET =3D 1,
-       AMDGPU_RESET_FOR_DEVICE_REMOVE =3D 2,
 };

 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index 6cab882e8061..1592c63b3099 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -43,7 +43,6 @@ struct amdgpu_hive_info {
         } pstate;

         struct amdgpu_reset_domain *reset_domain;
-       uint32_t device_remove_count;
         atomic_t ras_recovery;
 };

--
2.34.1


--_000_BL1PR12MB51448FF3ED7334D8D809AE0BF7692BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Wednesday, January 10, 2024 9:31 AM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Chai, Thomas &lt;YiPeng.=
Chai@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; amd=
-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: revert &quot;Adjust removal control flo=
w for smu v13_0_2&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Calling amdgpu_device_ip_resume_phase1() during sh=
utdown leaves the<br>
HW in an active state and is an unbalanced use of the IP callbacks.<br>
<br>
Using the IP callbacks like this can lead to memory leaks, double<br>
free and imbalanced reference counters.<br>
<br>
Leaving the HW in an active state can lead to DMA accesses to memory now<br=
>
freed by the driver.<br>
<br>
Both is a complete no-go for driver unload so completely revert the<br>
workaround for now.<br>
<br>
This reverts commit f5c7e7797060255dbc8160734ccc5ad6183c5e04.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 +--------------------=
-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; | 32 ------=
----------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h&nbsp; |&nbsp; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h&nbsp;&nbsp; |&nbsp; 1 -<br>
&nbsp;4 files changed, 1 insertion(+), 65 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index a39c9fea55c4..313316009039 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -5232,7 +5232,6 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *tmp_=
adev =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_full_reset, skip=
_hw_reset, vram_lost =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gpu_reset_for_dev_remove =3D 0;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Try reset handler metho=
d first */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_en=
try(device_list_handle, struct amdgpu_device,<br>
@@ -5252,10 +5251,6 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET, &amp;reset_context-&=
gt;flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_hw_reset =3D test_bit=
(AMDGPU_SKIP_HW_RESET, &amp;reset_context-&gt;flags);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_for_dev_remove =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, &amp;reset_context-&gt;=
flags) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_=
NEED_FULL_RESET, &amp;reset_context-&gt;flags);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ASIC reset has to =
be done on all XGMI hive nodes ASAP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to allow proper li=
nks negotiation in FW (within 1 sec)<br>
@@ -5298,18 +5293,6 @@ int amdgpu_do_asic_reset(struct list_head *device_li=
st_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_intr_cleared();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Since the mode1 reset affects base=
 ip blocks, the<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * phase1 ip blocks need to be r=
esumed. Otherwise there<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * will be a BIOS signature erro=
r and the psp bootloader<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can't load kdb on the next am=
dgpu install.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_reset_for_dev_remove) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; list_for_each_entry(tmp_adev, device_list_handle, reset_list)<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_resume_phase1(tmp_adev);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto end;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list_handle, reset_list) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (need_full_reset) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* po=
st card */<br>
@@ -5543,11 +5526,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restar=
t =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D f=
alse;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gpu_reset_for_dev_remove =3D fal=
se;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_reset_for_dev_remove =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_=
RESET_FOR_DEVICE_REMOVE, &amp;reset_context-&gt;flags) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; test_bit(AMDGPU_NEED_FULL_RESET, &amp;reset=
_context-&gt;flags);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS =
triggered and full reset isn't supported<br>
@@ -5585,7 +5563,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)=
 &amp;&amp; (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev, &amp;hive-&gt;device_li=
st, gmc.xgmi.head) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_=
add_tail(&amp;tmp_adev-&gt;reset_list, &amp;device_list);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gpu_reset_fo=
r_dev_remove &amp;&amp; adev-&gt;shutdown)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;shu=
tdown)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev-&gt;shutdown =3D true;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!list_is_first(&amp;adev-&gt;reset_list, &amp;dev=
ice_list))<br>
@@ -5670,10 +5648,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *=
adev,<br>
&nbsp;<br>
&nbsp;retry:&nbsp; /* Rest of adevs pre asic reset from XGMI hive. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_ad=
ev, device_list_handle, reset_list) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (gpu_reset_for_dev_remove) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Workaroud for=
 ASICs need to disable SMC first */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_sm=
u_fini_early(tmp_adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_pre_asic_reset(tmp_adev, reset_co=
ntext);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*TODO Should we stop ?*/<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r) {<br>
@@ -5705,9 +5679,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_do_asic_reset(device_list_handle, reset_=
context);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
retry;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!r &amp;&amp; gpu_reset_for_dev_remove)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto recover_end=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;skip_hw_reset:<br>
@@ -5763,7 +5734,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ras_set_error_query_ready(tmp_adev, true);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-recover_end:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_adev =3D list_first_en=
try(device_list_handle, struct amdgpu_device,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_list);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_unlock_reset=
_domain(tmp_adev-&gt;reset_domain);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 852cec98ff26..b7de48effe7f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -2336,38 +2336,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pm_runtime_forbid(dev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, MP1_HWIP,=
 0) =3D=3D IP_VERSION(13, 0, 2) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdgpu_sriov=
_vf(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool need_to_reset_gpu =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_hi=
ve_info *hive;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive =3D amdgpu_=
get_xgmi_hive(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hive-&gt;dev=
ice_remove_count =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_to_reset_gpu =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hive-&gt;device_=
remove_count++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_put_xgmi_=
hive(hive);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; need_to_reset_gp=
u =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Workaround for ASICs need to reset SMU.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * Called only when the first device is removed.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (need_to_reset_gpu) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_re=
set_context reset_context;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;shutdow=
n =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;rese=
t_context, 0, sizeof(reset_context));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.me=
thod =3D AMD_RESET_METHOD_NONE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_context.re=
set_req_dev =3D adev;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_N=
EED_FULL_RESET, &amp;reset_context.flags);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(AMDGPU_R=
ESET_FOR_DEVICE_REMOVE, &amp;reset_context.flags);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gp=
u_recover(adev, NULL, &amp;reset_context);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_driver_unload_kms(d=
ev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.h<br>
index b0335a1c5e90..19899f6b9b2b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h<br>
@@ -32,7 +32,6 @@ enum AMDGPU_RESET_FLAGS {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_NEED_FULL_RESET =3D=
 0,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SKIP_HW_RESET =3D 1=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_RESET_FOR_DEVICE_REMOVE =3D 2,=
<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_reset_context {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h<br>
index 6cab882e8061..1592c63b3099 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h<br>
@@ -43,7 +43,6 @@ struct amdgpu_hive_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } pstate;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain=
 *reset_domain;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t device_remove_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_recovery;<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51448FF3ED7334D8D809AE0BF7692BL1PR12MB5144namp_--
