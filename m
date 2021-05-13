Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC83DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848B961352
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 14:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848B961352
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B266E0D4;
	Thu, 13 May 2021 14:11:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2058.outbound.protection.outlook.com [40.107.102.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17356E0D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 14:11:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnqdbek6iIkOYGX5BP2USQQhDXUduZvmPBme8AK6hJ5efj+d4t96bL3BA6ij0+4Co+BjQkCjSpITc6+TNCOjLxAeRFPWDHMMmIJ9af7/fvKLoOfMAfko7FmGOd1vqG8Tr2NDM4Y3FSPsnZ1WgO98N7zzamazuDd9+ahk24q972sbPnstOei28vJ+u9ulHEWkHsZMImpjMkiHyGW4StnTDwwg+88WePv/CjzljVQPVNKm5QYNMzvQEIMbbujTN+rzEv3miY5opZzhl9lFYwEZowxSGStY/8GifQc2FbjZ1fChasyJpNHeGSJ4YhcxNfk2JZGUuE8TkW+659adLChPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGGLgOxvihE4ZuY/Y/bKaNkU/wz53AlNdLq+7hc7itY=;
 b=fEwQUqfMwavJgU7+2AyamVr7IrkqRS0/CuNf72xklAj1Db8iE65W0oSYZr1QoxCnslOmO7Q7QXoqyvjyx+fuA0Cw8YH2hAS1YGPmjZ0q39Iirq5uVtrqDhfIcwtegJAhvqRczXDJgerQp6UT3Ur2ixJLLZY2CgpGtl1cHpgKjablPGuFaTx7vmDybpB2LPrGtT5gwlg/gpsOAHE5UH70+zGwLb4IpjYVgZMtyqOBQOUOpEKmCer4Gump+ZBo0O7+UAqhTPuXq5Yv/BpJNnvEdSAUfpqByxdyfMlE3maQWbcCc4/YP+qcop2OA6aIY9Wa8voxqzqFu6/KP0WtQtX+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGGLgOxvihE4ZuY/Y/bKaNkU/wz53AlNdLq+7hc7itY=;
 b=0+f2fz70b4PgKa0ilomNwexzQBSUs58s5TYzFXaJ9/4Ylk3fZb0o4LFT3pO44WD9m0/Z3L0l2sUsS8rvnehJkPoucc+duQJXtGNvTstWz4yMyGB+9h63AfjFnr6YywVf145Q+XKE64CopcQQ/o4DDgXd2u1/lX0CaaRxMHb9XbI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 14:11:36 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 14:11:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid
Thread-Topic: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid
Thread-Index: AQHXR+Nlq2kNVzVyWEaj3ojbaa7MzKrhc6dY
Date: Thu, 13 May 2021 14:11:36 +0000
Message-ID: <MN2PR12MB448825CC5EC52F626AEE1938F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210513103308.601043-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210513103308.601043-1-YuBiao.Wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T14:11:35.930Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fcfbea5-1331-42b5-ae37-08d916190538
x-ms-traffictypediagnostic: BL0PR12MB4964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB49648B66BDDE4F01DC53C2A3F7519@BL0PR12MB4964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BahOWzcFVRWr4NnaCTeFyB8p4pYQeCRljLhq3wFl+bddP2AX+JHFciSDEd2ksQpb6ITY5NejmMsLv8rG4l+V7WcRWYIUaHvgPL6zpTESf6Mo5B9tQroxs0vDvLK2vzSjgKkV2ef3YeWSl1Zh0qzqDwkqFiPI+k6kxkajVrLASIFyuDbkAfESNBa1TacEWd4JFwM5rLVteAIiyv3jQXdzqr9939kkOLEXKtw7hWf7PZmWHEWbbH78PleEQmaSzgE2hzNtajGfnR4FyVwFmvVzo3Ft0JcrIqGN7fBtsViZg+t5pzE0KI8p2KmhivhJZSE7stwLI9juO7PLu861eonWUpI5LtoTWWNW+/rP9+Afa+I1zvAhwLLoKOomM108O1YtMCdIexumS03C0mCh7ytc2rW8MRm2cGHk2vQtq2/9p9YRmmHpI4+yq+8FndmXWVg+UFI00dqalzjuFVCzqh/eMqX3yeSh0X/ZRWxv7YpgMEk9BXX3OIRxJSewTa6AqUlwspe1V76Dch3DOiNqEiLSY3wsPMogd+OtMk2TJkB1wVMq8kbzb9TiLlkNFB5vkZGVq5mJFM2WHFK8vknK/CNALaDMujIKGlMH13zkAc+iCRA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(86362001)(122000001)(4326008)(19627405001)(5660300002)(83380400001)(2906002)(66446008)(33656002)(316002)(71200400001)(64756008)(55016002)(66946007)(52536014)(7696005)(110136005)(186003)(8936002)(54906003)(8676002)(6506007)(53546011)(478600001)(9686003)(26005)(66476007)(38100700002)(66556008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vrS33L3QBIrUW+SPuCjjWA2jlPyCUPvhtsD1hZL0O0SVZriBm8mTD75AnP6n?=
 =?us-ascii?Q?QcyjUjrdJurT5vw+EFEncr9ZQq22THND8YrvP39DQoPx4KcyjZR/a4r6JFbV?=
 =?us-ascii?Q?QZ/2SBwbnlQjMC6HORjIdhEx04xSlSKzqGmyPrkv+hsg4YktaHAtQzDCawXl?=
 =?us-ascii?Q?UPhtpc4KWSyAje3TYcvhuvwWEUB9xl+rzDteLhyQ9dagq55HenXj9KbECamC?=
 =?us-ascii?Q?uxTKE663X6eF5+yJol89Vz+viq/MAYSII3gJ6xChWFi+9rflkPHtAUETwOYp?=
 =?us-ascii?Q?J05VmC94OHDq84ihRtWihTYctqnlHWxpu9cVc8CsbBOvLfgsQHQgIIkTei/0?=
 =?us-ascii?Q?6zeahb2je6DNTPEFukkxYPYPwRPf9x1WWy/87OvgZ5m7GhDi7opqshdYJlaD?=
 =?us-ascii?Q?cXXqL/qAUkKbo1ldzvKosNwq7uT02KWRgMjl2J2+MDYElhEYIfWCDbV46RNS?=
 =?us-ascii?Q?ELPPzPWUbJAH0IDv6P0fMaZq7eyqIFr8DeFayVHgzKjfrnvsrAJbPTS43XVl?=
 =?us-ascii?Q?k5se0DXkOgF/aeVIpQ4aUVSSAKfOM0RPUzSxhSQj2cZyAfto9vZ183Gt0B4K?=
 =?us-ascii?Q?58jZHv73Sd2nbvxF7lERrzwb2XxYDGSOXkj4I0ybTXu9/KqHtLwQBNRnfzSt?=
 =?us-ascii?Q?CN83HEnp/tVCEPWP+l+hKf//dDdU9oofNYWMpuCS2MfHgUkHb+/Yfz1zJvVx?=
 =?us-ascii?Q?GpDd/WNtvkW/r04/hxNMnEZzdL++99Lo223CDMaRmXM+90WJlrh40Jr0+cFq?=
 =?us-ascii?Q?a578Kwq4NEoCiGNdWFFqnUNIfj8aCgkQQe615Et4y3HrLMqzt5v2ZhdBB/xB?=
 =?us-ascii?Q?VC21CDCbQfA4bKS1wi1soW7b1LHMzcSoOOWxsclB3XgJqahTqqQhFlwsZulV?=
 =?us-ascii?Q?d6Z6IMz4xc6P2JuAidMcqlZF59Wz1x9mTkrxgf1p+21a6F/cTZPQhREhlztQ?=
 =?us-ascii?Q?iGlsb+Uo6W7YvjgLKeRqg6pq8R9jicjT1Ll9cExf9P48yUElZBewN3ZOcFDe?=
 =?us-ascii?Q?1T/cZ4eUaRyQFk+mc+YlSNPLgWurtVZD/heYHJRODvDdaeb2AR71wugqnjBG?=
 =?us-ascii?Q?ocdCHMTNSefXWT1C5G8vQLLL02dyEpRo5xj6Utv/JIFlu2Px4F14lFp1TpUa?=
 =?us-ascii?Q?QGIUWxPTME6XG5/JNfD2a1n2iA10iMN9C7qBdYdI9CF76jg3TP3RZJgM6pud?=
 =?us-ascii?Q?VqjY9YPfLLe5lyHMulEKLiRbjzIeZODVmFQOvGO6G0QPPgUEMUCdCu2IfVDP?=
 =?us-ascii?Q?vcE2rohMy7pTETm67OBEgGMjdxYUZKLRmfptDEvxi1ozq3vhOowMt3h0NpVV?=
 =?us-ascii?Q?DC8KY9Zt05JUzCPVfAQm8t09?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcfbea5-1331-42b5-ae37-08d916190538
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 14:11:36.6304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f55sPEp5GShbya5WMZTPW2sId+jet4+NVpkite/S0Jb+HBZxbQssYJqKHi+RJyfZ8rz+sDVhZcKS0baY73OgLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, 
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============2016819618=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2016819618==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448825CC5EC52F626AEE1938F7519MN2PR12MB4488namp_"

--_000_MN2PR12MB448825CC5EC52F626AEE1938F7519MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: YuBiao Wang <YuBiao.Wang@amd.com>
Sent: Thursday, May 13, 2021 6:33 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@am=
d.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <A=
lexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <=
Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu=
@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Xiaojie Yuan <xiaojie.y=
uan@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_cichlid

[Why]
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.

[How]
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/nv.c        | 12 +++++++++---
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c
index f4e4040bbd25..5ee923ccdeb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,
         /* enable_intr field is only valid in ring0 */
         if (ih =3D=3D &adev->irq.ih)
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enabl=
e ? 1 : 0));
-       WREG32(ih_regs->ih_rb_cntl, tmp);
+
+       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
+                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+                       return -ETIMEDOUT;
+               }
+       } else {
+               WREG32(ih_regs->ih_rb_cntl, tmp);
+       }

         if (enable) {
                 ih->enabled =3D true;
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABL=
E, 0);
                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABL=
E, 1);
         }
-       WREG32(ih_regs->ih_rb_cntl, tmp);
+
+       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) =
{
+                       DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
+                       return -ETIMEDOUT;
+               }
+       } else {
+               WREG32(ih_regs->ih_rb_cntl, tmp);
+       }

         if (ih =3D=3D &adev->irq.ih) {
                 /* set the ih ring 0 writeback address whether it's enable=
d or not */
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c
index 75d1f9b939b2..2ec5d4e1f363 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -764,9 +764,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
         case CHIP_SIENNA_CICHLID:
                 amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
                 amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
-               amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
-               if (likely(adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_P=
SP))
-                       amdgpu_device_ip_block_add(adev, &psp_v11_0_ip_bloc=
k);
+               if (!amdgpu_sriov_vf(adev)) {
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
+                       if (likely(adev->firmware.load_type =3D=3D AMDGPU_F=
W_LOAD_PSP))
+                               amdgpu_device_ip_block_add(adev, &psp_v11_0=
_ip_block);
+               } else {
+                       if (likely(adev->firmware.load_type =3D=3D AMDGPU_F=
W_LOAD_PSP))
+                               amdgpu_device_ip_block_add(adev, &psp_v11_0=
_ip_block);
+                       amdgpu_device_ip_block_add(adev, &navi10_ih_ip_bloc=
k);
+               }
                 if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP &&
                     is_support_sw_smu(adev))
                         amdgpu_device_ip_block_add(adev, &smu_v11_0_ip_blo=
ck);
--
2.25.1


--_000_MN2PR12MB448825CC5EC52F626AEE1938F7519MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> YuBiao Wang &lt;YuBia=
o.Wang@amd.com&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 6:33 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Quan, Evan=
 &lt;Evan.Quan@amd.com&gt;; Chen, Horace &lt;Horace.Chen@amd.com&gt;; Tuiko=
v, Luben &lt;Luben.Tuikov@amd.com&gt;; Koenig, Christian &lt;Christian.Koen=
ig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;;
 Xiao, Jack &lt;Jack.Xiao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd=
.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Xu, Feifei &lt;Feifei.Xu@amd.=
com&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; Xiaojie Yuan &lt;xi=
aojie.yuan@amd.com&gt;; Wang, YuBiao &lt;YuBiao.Wang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: psp program IH_RB_CTRL on sienna_ci=
chlid</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
IH_RB_CNTL is blocked by PSP so we need to ask psp to help config it.<br>
<br>
[How]<br>
Move psp ip block before ih, and use psp to program IH_RB_CNTL under sriov.=
<br>
<br>
Signed-off-by: YuBiao Wang &lt;YuBiao.Wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 20 ++++++++++++++++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nv.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; | 12 +++++++++---<br>
&nbsp;2 files changed, 27 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/navi10_ih.c<br>
index f4e4040bbd25..5ee923ccdeb3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c<br>
@@ -151,7 +151,15 @@ static int navi10_ih_toggle_ring_interrupts(struct amd=
gpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable_intr field is on=
ly valid in ring0 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (=
enable ? 1 : 0));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
amdgpu_sriov_reg_indirect_ih(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
PSP program IH_RB_CNTL failed!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ih-&gt;enabled =3D true;<br>
@@ -261,7 +269,15 @@ static int navi10_ih_enable_ring(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_=
ENABLE, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_=
ENABLE, 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<=
br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&amp; =
amdgpu_sriov_reg_indirect_ih(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, ih_regs-&gt;psp_reg_id, t=
mp)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
PSP program IH_RB_CNTL failed!\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOU=
T;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32(ih_regs-&gt;ih_rb_cntl, tmp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&g=
t;irq.ih) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* set the ih ring 0 writeback address whether it's e=
nabled or not */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/n=
v.c<br>
index 75d1f9b939b2..2ec5d4e1f363 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nv.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c<br>
@@ -764,9 +764,15 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_SIENNA_CICHLID:<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;nv_common_ip_bl=
ock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;gmc_v10_0_ip_bl=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;navi10_ih_ip_block);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (likely(adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP=
))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;psp_v11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(adev-=
&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v=
11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(adev-=
&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_block_add(adev, &amp;psp_v=
11_0_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip=
_block_add(adev, &amp;navi10_ih_ip_block);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =3D=3D AMDGPU_FW_LOAD=
_PSP &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is_support_sw_smu(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_device_ip_block_add(adev, &amp;smu_v11_0_ip_block);<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448825CC5EC52F626AEE1938F7519MN2PR12MB4488namp_--

--===============2016819618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2016819618==--
