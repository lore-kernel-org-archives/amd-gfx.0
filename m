Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	HTTPS_HTTP_MISMATCH,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F58C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 03:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB10A6054F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 03:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB10A6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF0C6E3F4;
	Mon,  2 Aug 2021 03:55:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2EE6E3E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 03:54:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T94muP17vWUbtd4oXNxw8bX77e2XeJweHQtISedT2YgwAmKpyw9NNx+bMXUXgErWtUXtBvhR2L2wjMHiS040+BnnbfOmU+a9Cqodb3WMXb0fX0V5yQYDsGatAUeRn6BGNp31hwioLDWuhJ+ZLKtz23zd+LNZSD21Lsw+N2EUSFrE8PuZg7RJ0F16jh0LrqqrdMLpJnMRAkRZuieDq6mRD37vmNbM/qHANIpWfoC13c1mJgjF71Xf7faxKOm50T1QHuwQQYbeehzKDDcPiy3IAr1CgoH5CXdvlUHO2gX95XR+Q44hnZPCtdWGB6Miz3enZOLI1rpnHJIrRR8NtaqJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtWiKufIhGDGxE33TZ7KfLbnvH/9u7A+M4jbqV3ZeSc=;
 b=RA8KxO8LbsaeHPS00ar1uCEOAM21ZIcu3dySfoVNJFG6kuygppKgFmbfB48q80zdcRdRVvyr5L+j+ybsWbFpvw2xWeg287PMJ5tTTcLL4h81O7pSR8mMDCTeewVdjrB6oG/RR+0s0l49bN383CgSQBi0EaGA+EwWS23eJ7x7AdUTqJ1AZQxq1Fm9IthqztnR5hilZxJ4t/Piqo+nYSv4ogG2Fqzuvu4xOCInVq1G5DETEqNeb67PC4a8tpl0+5/XtV9aRtV/+fSpdNkjP3QJm1i7XlIZIiF894zpgLjEJdrqv3kEzzsX9WGTBuGdnEDC7dzeewypY3tOuHUgJSoxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtWiKufIhGDGxE33TZ7KfLbnvH/9u7A+M4jbqV3ZeSc=;
 b=CbT0mU8kPO3cCA22gnW1tY1jAd0tKLszgfw4cDLyvKN/mIV9DCISFZp7yBSQUmRplgH8YGwILBx+vOLon5mhs+gU7OaxozSemqmJsCvis0jjR//H+qIpMOf6gYLGLJdYS6HxAIrvK9s/ivOhY4rwhZl6T9wc8dyRxAvoERdTjbk=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Mon, 2 Aug 2021 03:54:55 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 03:54:55 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Mike Lothian <mike@fireburn.co.uk>, "Gao, Likun" <Likun.Gao@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: adjust fence driver enable sequence
Thread-Topic: [PATCH] drm/amdgpu: adjust fence driver enable sequence
Thread-Index: AQHXg2YpaF8krioSc0eEGIYemYH+Yqtekd2AgAELEkA=
Date: Mon, 2 Aug 2021 03:54:55 +0000
Message-ID: <DM5PR12MB2469446B24BE3AEC20C58365F1EF9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210728040741.2734771-1-likun.gao@amd.com>
 <CAHbf0-GmyiEdV_2r8EcvUjm78UTKxYi7-yURa6ZkqjpfmSj4TQ@mail.gmail.com>
In-Reply-To: <CAHbf0-GmyiEdV_2r8EcvUjm78UTKxYi7-yURa6ZkqjpfmSj4TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-02T03:54:52Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c7446543-c857-4f67-9ac1-fa2b855960c6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: fireburn.co.uk; dkim=none (message not signed)
 header.d=none;fireburn.co.uk; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c702a25-be98-46bb-72bf-08d955694a14
x-ms-traffictypediagnostic: DM6PR12MB2985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB29855BBDC9631A7BC8870492F1EF9@DM6PR12MB2985.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fwl7jj8cCLwbnnfcivnvv3Ba13ApwCbbhESaS0UgLmkKIuHGJ90CVnuRkFCjhi/LPoICVt1O7Nsw3L1EzsEQbrkS25ZkOQ2hubNkMBNlGz8t0daLiIDIbU9NS9ie5fcjTfHaZWVtOcO/TMJRk5NdaMQq58yRa6jKk3GG0+OuZDO3ofZenR9dk22skx9AOsbJ6vLeroK6RpmCcLuUac6ORAngsBHAOEFuu5giV9qLYN9aW0J/kE/CdRUrOvgnsZUiGc3E3aO8nNFUFX8Kl9AsT3ShqGqmSv9Nx51/T/fQOkEDTTFb8rrSWchpKgM/tRMRlxtuJxIJDKY5mt02yQLoQCinPf4tO77MNWfywZ16s/9DoVdteZPHvK8NFVIslFyYRn9DC4PoEtAPWhJF+mw87NiPn9RL+JDof3QID9MCFLS1JXFe+W7C7Nmy4h4DX+phxUbEyE0OSy5S5scRITIE6rKEhfVI/XGrqxYAkH325pAv+PzCVSpwFOZITUe23PA8vFHRxb8AN+9TL8cXWv7DKdXGjLmY5ub3ozFsByJ5G6cPN2Lof9hn3mRptwiEHEC86kZ//SylxEk7rIdJgxri+JACSUYb/8zALUSHxrIxfebHOrEgfR9l7u+4smKung8zBJ+s4obVbuwnVWcEWF7sQQLjlt/g5gioHVwPia0Ern1hkX0JR/+wd2lE0rKzME+HVt+dVkjvuPwobaeBSBmE7w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(38070700005)(4326008)(83380400001)(966005)(66946007)(76116006)(38100700002)(26005)(166002)(55016002)(316002)(86362001)(6636002)(66446008)(66556008)(66476007)(9686003)(33656002)(64756008)(54906003)(110136005)(52536014)(5660300002)(186003)(8676002)(8936002)(6506007)(2906002)(122000001)(53546011)(478600001)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EeWTRO6h6UrBYYNUWBUY2ritdLesAWhoZwNIKCeHNWITDW8n6X2SdFiHUQRh?=
 =?us-ascii?Q?TslQKGRhiWxD50H+VRhctQ/NcAVqkersAAHPsCw3JDAGAHYooxe+RtcpSShe?=
 =?us-ascii?Q?9VS17wSwb/UDOHlBAo26tDA3ORsMifPYXsny0NYsOljv91+7uq6nUoXSkA+A?=
 =?us-ascii?Q?X6bI5S7osJvjoGde6b34CymzpA7yZ1pW21u9S/Z+fM4i3YiQ/5bb7ETf0ynX?=
 =?us-ascii?Q?ofWN73NEFpI0tKFinyjOQsCnb9I0B2JentjHOLskztBcAhdcGSMZyzm0wFZs?=
 =?us-ascii?Q?6AFjlzvG+XzJ/A/9Xure8L8H2VaGTd8o35EIZULi9QvdgBqDtUHVwZqImPwm?=
 =?us-ascii?Q?yd6OQp8GGsgmjj2M35NZlh9uf6N72qvTa070covX8EcSHdoyxueZ0ZG+ZaEz?=
 =?us-ascii?Q?o6F3vIpR8IBiK5H6hZGwMTJzCxE4gy9njRMAl8604pa+FVQYkDoFZcBPHN29?=
 =?us-ascii?Q?NBysJryANEZ9Ys5A845II2l18mkTuy8JZVTiHuiq8lKc4b8LaViThifOc4o6?=
 =?us-ascii?Q?Oy+4Yann5/zZlmV2YrE9RSTYHRisTxHc3vxcbifo13xuby2nf0iuCH8/IZOf?=
 =?us-ascii?Q?2oW2qEeSLOMRq8EsrGNpgaDSusbwFJp4luSY4FrjzrZRfwZ7pc7glZPAFruU?=
 =?us-ascii?Q?xpGsK7F3l4iDUA35qSJ3AE4VuV9n5jIZ+pV2XIlj9BZIoEmoLBXC3dF/Yb+c?=
 =?us-ascii?Q?U0cgUrtbBo7SIxiabgHB9H7CFeIuGt+Iviu/+SosvWuu86D78R+ISeOMrfTj?=
 =?us-ascii?Q?mF2NLAcB2m6io0B2gFgmUjg0iMHVhFSL6tQNT7jQ10xaJp5jk+hSltKrq+a2?=
 =?us-ascii?Q?6lWOB1qfFni2H8xF4dMsLOf3cgm9alfbn1A7/Y6xHxwBtXEirEnHFoAyburA?=
 =?us-ascii?Q?TAkX7NRmbSSSlCjrGc78Qh1P6ygqIRkgC3G9+0qYjaY9fRQxOA3+v4lPyLcY?=
 =?us-ascii?Q?h4V0ibhUpG1T/GnLJW5JKOK5vjBqUAdHf0kG4lzrYy+ZuiDq8U23q60OZ6lR?=
 =?us-ascii?Q?+YG5jomQeT13KXuh1TuU4L8pgS3ysGhOMqJnP5rjc1hyoKIxvY/voLO3a6zn?=
 =?us-ascii?Q?b0i1Sipwxzwhy9O37C+ek89gQUzPX6w98kNWNWWIZ1KoPidpBoULfuhxSnnS?=
 =?us-ascii?Q?dClnon1f5TLf6i+OfYzxWwwIPqGbE9NSw3SXsykHDSLaFuagxq6jF+NjmrD/?=
 =?us-ascii?Q?PJhutWOpp6kmnE/AZVRslUtnAJKl/um+yQzGwoMs5ejm2/rqVdLNdRcxV1RB?=
 =?us-ascii?Q?QMVBZbc4ehcd0RTaMZt45f/K5Feu4ueO0hU9THFWaxhxe8fJfp60xgq3c4ZB?=
 =?us-ascii?Q?7J7gUFXcT6S5IW9DAz9n0EFd?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB2469446B24BE3AEC20C58365F1EF9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c702a25-be98-46bb-72bf-08d955694a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 03:54:55.1137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 643csSIYwO4KAjV85n+LTYQKjYGWq5dd6TduaT/bIuBn7t1U4+Yo3u8nXwU7bKkrrMil7CGtWE/jKaTQ2+fi7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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

--_000_DM5PR12MB2469446B24BE3AEC20C58365F1EF9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Lothian,

Thanks for your report. I have a following fix for this problem, will send =
it out soon for review.

Regards,
Guchun

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mike Lot=
hian
Sent: Sunday, August 1, 2021 7:57 PM
To: Gao, Likun <Likun.Gao@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Zhang, Hawking <Hawking.Z=
hang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: adjust fence driver enable sequence

Hi

This patch is causing me issues on my Skylake/Tonga PRIME laptop, reverting=
 sorts it

More details here: https://gitlab.freedesktop.org/drm/amd/-/issues/1668<htt=
ps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.fre=
edesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1668&data=3D04%7C01%7Cguchun.chen%4=
0amd.com%7C858e6bd7d2da4e442f0308d954e380e8%7C3dd8961fe4884e608e11a82d994e1=
83d%7C0%7C0%7C637634159140610948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD=
AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3DaDq%2F%2Fiy=
qn32JZXJ%2Fet9HGZWIen%2FeRhBBd%2FXJ4Wgv5Ds%3D&reserved=3D0>

Cheers

Mike

On Wed, 28 Jul 2021 at 05:07, Likun Gao <likun.gao@amd.com<mailto:likun.gao=
@amd.com>> wrote:
From: Likun Gao <Likun.Gao@amd.com<mailto:Likun.Gao@amd.com>>

Fence driver was enabled per ring when sw init on per IP block before.
Change to enable all the fence driver at the same time after
amdgpu_device_ip_init finished.
Rename some function related to fence to make it reasonable for read.

Signed-off-by: Likun Gao <Likun.Gao@amd.com<mailto:Likun.Gao@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 15 ++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  4 ++--
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index d3a4299b1f30..77195a4e5c59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
                goto release_ras_con;
        }

+       amdgpu_fence_driver_hw_init(adev);
+
        dev_info(adev->dev,
                "SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
                        adev->gfx.config.max_shader_engines,
@@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)
        /* evict vram memory */
        amdgpu_bo_evict_vram(adev);

-       amdgpu_fence_driver_suspend(adev);
+       amdgpu_fence_driver_hw_fini(adev);

        amdgpu_device_ip_suspend_phase2(adev);
        /* evict remaining vram memory
@@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)
                dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n"=
, r);
                return r;
        }
-       amdgpu_fence_driver_resume(adev);
+       amdgpu_fence_driver_hw_init(adev);


        r =3D amdgpu_device_ip_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c
index 72d9b92b1754..e2f606bca779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *=
ring,
        }
        amdgpu_fence_write(ring, atomic_read(&ring->fence_drv.last_seq));

-       if (irq_src)
-               amdgpu_irq_get(adev, irq_src, irq_type);
-
        ring->fence_drv.irq_src =3D irq_src;
        ring->fence_drv.irq_type =3D irq_type;
        ring->fence_drv.initialized =3D true;
@@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct amdgpu_device=
 *adev)
 }

 /**
- * amdgpu_fence_driver_suspend - suspend the fence driver
+ * amdgpu_fence_driver_hw_fini - disable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Suspend the fence driver for all possible rings (all asics).
+ * Disable the fence driver for all possible rings (all asics).
  */
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
 {
        int i, r;

@@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device=
 *adev)
 }

 /**
- * amdgpu_fence_driver_resume - resume the fence driver
+ * amdgpu_fence_driver_hw_init - enable the fence driver
  * for all possible rings.
  *
  * @adev: amdgpu device pointer
  *
- * Resume the fence driver for all possible rings (all asics).
+ * Enable the fence driver for all possible rings (all asics).
  * Not all asics have all rings, so each asic will only
  * start the fence driver on the rings it has using
  * amdgpu_fence_driver_start_ring().
  * Returns 0 for success.
  */
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev)
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
 {
        int i;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index e7d3d0dbdd96..64471018f5e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *r=
ing,
 int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
                                   struct amdgpu_irq_src *irq_src,
                                   unsigned irq_type);
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
 int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
                      unsigned flags);
 int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7Cguchun.chen%40amd.com%7C858e6bd7=
d2da4e442f0308d954e380e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63763=
4159140620942%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=3D246tWunS5hNC8N1rP1oFMFABerqup5=
j%2Ff1hMGuouLnk%3D&reserved=3D0>

--_000_DM5PR12MB2469446B24BE3AEC20C58365F1EF9DM5PR12MB2469namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader23c54b6f, li.msipheader23c54b6f, div.msipheader23c54b6f
	{mso-style-name:msipheader23c54b6f;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader23c54b6f" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Lothian,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks for your report. I have a following fix for t=
his problem, will send it out soon for review.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Guchun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Mike Lothian<br>
<b>Sent:</b> Sunday, August 1, 2021 7:57 PM<br>
<b>To:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Zhang, Hawki=
ng &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: adjust fence driver enable sequence=
<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">This patch is causing me issues on my Skylake/Tonga =
PRIME laptop, reverting sorts it<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">More details here: <a href=3D"https://nam11.safelink=
s.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%=
2Famd%2F-%2Fissues%2F1668&amp;data=3D04%7C01%7Cguchun.chen%40amd.com%7C858e=
6bd7d2da4e442f0308d954e380e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6=
37634159140610948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luM=
zIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DaDq%2F%2Fiyqn32JZXJ%2F=
et9HGZWIen%2FeRhBBd%2FXJ4Wgv5Ds%3D&amp;reserved=3D0">
https://gitlab.freedesktop.org/drm/amd/-/issues/1668</a><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Cheers<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Mike<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">On Wed, 28 Jul 2021 at 05:07, Likun Gao &lt;<a href=
=3D"mailto:likun.gao@amd.com">likun.gao@amd.com</a>&gt; wrote:<o:p></o:p></=
p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"MsoNormal">From: Likun Gao &lt;<a href=3D"mailto:Likun.Gao@amd.=
com" target=3D"_blank">Likun.Gao@amd.com</a>&gt;<br>
<br>
Fence driver was enabled per ring when sw init on per IP block before.<br>
Change to enable all the fence driver at the same time after<br>
amdgpu_device_ip_init finished.<br>
Rename some function related to fence to make it reasonable for read.<br>
<br>
Signed-off-by: Likun Gao &lt;<a href=3D"mailto:Likun.Gao@amd.com" target=3D=
"_blank">Likun.Gao@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 6 ++++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c&nbsp; | 15 ++++++---------<=
br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp; &nbsp;|&nbsp; 4 ++--<b=
r>
&nbsp;3 files changed, 12 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index d3a4299b1f30..77195a4e5c59 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -3675,6 +3675,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,<br=
>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; goto release_ras_co=
n;<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
<br>
+&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_fence_driver_hw_init(adev);<br>
+<br>
&nbsp; &nbsp; &nbsp; &nbsp; dev_info(adev-&gt;dev,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;SE %d, SH per=
 SE %d, CU per SH %d, active_cu_number %d\n&quot;,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; adev-&gt;gfx.config.max_shader_engines,<br>
@@ -3939,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* evict vram memory */<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_bo_evict_vram(adev);<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_fence_driver_suspend(adev);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_fence_driver_hw_fini(adev);<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_device_ip_suspend_phase2(adev);<br>
&nbsp; &nbsp; &nbsp; &nbsp; /* evict remaining vram memory<br>
@@ -3984,7 +3986,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; dev_err(adev-&gt;de=
v, &quot;amdgpu_device_ip_resume failed (%d).\n&quot;, r);<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return r;<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
-&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_fence_driver_resume(adev);<br>
+&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_fence_driver_hw_init(adev);<br>
<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; r =3D amdgpu_device_ip_late_init(adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_fence.c<br>
index 72d9b92b1754..e2f606bca779 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c<br>
@@ -417,9 +417,6 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *=
ring,<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_fence_write(ring, atomic_read(&amp;ring-=
&gt;fence_drv.last_seq));<br>
<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (irq_src)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;amdgpu_irq_get(adev=
, irq_src, irq_type);<br>
-<br>
&nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;fence_drv.irq_src =3D irq_src;<br>
&nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;fence_drv.irq_type =3D irq_type;<br>
&nbsp; &nbsp; &nbsp; &nbsp; ring-&gt;fence_drv.initialized =3D true;<br>
@@ -572,14 +569,14 @@ void amdgpu_fence_driver_fini_sw(struct amdgpu_device=
 *adev)<br>
&nbsp;}<br>
<br>
&nbsp;/**<br>
- * amdgpu_fence_driver_suspend - suspend the fence driver<br>
+ * amdgpu_fence_driver_hw_fini - disable the fence driver<br>
&nbsp; * for all possible rings.<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu device pointer<br>
&nbsp; *<br>
- * Suspend the fence driver for all possible rings (all asics).<br>
+ * Disable the fence driver for all possible rings (all asics).<br>
&nbsp; */<br>
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev)<br>
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; int i, r;<br>
<br>
@@ -603,18 +600,18 @@ void amdgpu_fence_driver_suspend(struct amdgpu_device=
 *adev)<br>
&nbsp;}<br>
<br>
&nbsp;/**<br>
- * amdgpu_fence_driver_resume - resume the fence driver<br>
+ * amdgpu_fence_driver_hw_init - enable the fence driver<br>
&nbsp; * for all possible rings.<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu device pointer<br>
&nbsp; *<br>
- * Resume the fence driver for all possible rings (all asics).<br>
+ * Enable the fence driver for all possible rings (all asics).<br>
&nbsp; * Not all asics have all rings, so each asic will only<br>
&nbsp; * start the fence driver on the rings it has using<br>
&nbsp; * amdgpu_fence_driver_start_ring().<br>
&nbsp; * Returns 0 for success.<br>
&nbsp; */<br>
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev)<br>
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; int i;<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index e7d3d0dbdd96..64471018f5e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -117,8 +117,8 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *r=
ing,<br>
&nbsp;int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;struct amdgpu_irq_src *ir=
q_src,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;unsigned irq_type);<br>
-void amdgpu_fence_driver_suspend(struct amdgpu_device *adev);<br>
-void amdgpu_fence_driver_resume(struct amdgpu_device *adev);<br>
+void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);<br>
+void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fe=
nce,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; unsigned flags);<br>
&nbsp;int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,<=
br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01=
%7Cguchun.chen%40amd.com%7C858e6bd7d2da4e442f0308d954e380e8%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637634159140620942%7CUnknown%7CTWFpbGZsb3d8ey=
JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp=
;sdata=3D246tWunS5hNC8N1rP1oFMFABerqup5j%2Ff1hMGuouLnk%3D&amp;reserved=3D0"=
 target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</=
a><o:p></o:p></p>
</blockquote>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB2469446B24BE3AEC20C58365F1EF9DM5PR12MB2469namp_--
