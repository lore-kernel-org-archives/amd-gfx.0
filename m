Return-Path: <SRS0=hs5v=5E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D10BC4332D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 01:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B9120767
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2020 01:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X9Obac8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B9120767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21A486E954;
	Thu, 19 Mar 2020 01:35:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF9F6E898
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2020 01:34:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbqpN9IcBY/B18jP6lHkG+xTmlIQ3qoy9CGZBf26PiwehkklbAEgJv4Rk5/5T41c6xmB91dEq0Q5E7H1fLf51XRjouk8Gg0IGP/QdXo9sIFTnER6oWujCgQ2q/JqxAWLARNYdGPxVoHQPKQG0524/9HXvwKgW8EfuPg91/Jflrgs8vhxSTl7wDj/6wrNe0D5CI9Jj2JCNluWdLyiorWUBIFtVfpMjekeqmibDTvqHolJEIPNR93YRBMwyma74ZPfCPkoY/HRCwU5qzexpsC19ribN8CvUXQbVEl24uUjT7AaFKWCy38vexjr9dBWkFTEOKkcA1AarAzXPz3wuav5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhQXnfv0+YmkXFnG727L8qW+XKFR0lWvwQ6X6qT3lfo=;
 b=JPITKSoDwvQzqzcr7JcbdtoXuHNcIYFGLdisZbFpc0hA8qLADuB0WZFhqxIV5O6A2CrwAM0buucfuf7LpnaFh98kQjxTYN4MB7L5k7qVRrMGLwda8U5hM6a7FF9sT+pA+monrFC2oXhfOwOyoaU96QjKT8A/60d9ADOR6ptHOwjkHVCaCIU6+aLK38L35GBG+4FZ5RzvxROxZMw14SsCIzxJKzg1HlvF16NzzOItJ1inBLik+RGx2iUmzYCfTQiDliNtHeUVB6rc62DLSN0+KujzCP75Mh8q2f5mWyeUV8dRYjMTD0o7c/ZVTcv9YVx4Gn5qZ9EtB9d9NtP8bLUQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhQXnfv0+YmkXFnG727L8qW+XKFR0lWvwQ6X6qT3lfo=;
 b=X9Obac8zi6K8rLlsnZ20UmYbAQ/SDFBX1nC+eiRyrpoHR86oJUc7ha1ZQG5u68vhOZynEW9UT6IBLHvxjGTWU0IwpvH5/F0K6YAA2t4y0u/5K62PGj7ycuctxtyEOUKrq3X/x8uWEjOd44D6EFhaTVwXXBN6Zz+IBjGuG2fDvS8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 19 Mar
 2020 01:34:55 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5868:c9cf:2687:6e03%2]) with mapi id 15.20.2814.021; Thu, 19 Mar 2020
 01:34:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Sierra Guiza, Alejandro
 (Alex)" <Alex.Sierra@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/8] drm/amdgpu: create new files for arcturus ih
Thread-Topic: [PATCH 2/8] drm/amdgpu: create new files for arcturus ih
Thread-Index: AQHV/XgJbUlcFmJplk+xg/lQOsiVHKhPAG8AgAAhE6o=
Date: Thu, 19 Mar 2020 01:34:55 +0000
Message-ID: <MN2PR12MB4488DACAE0B3A4A3FC822A87F7F40@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
 <20200318225118.10756-2-alex.sierra@amd.com>,
 <79ebdfb4-1d10-dc9d-e35e-ceb9369b66c4@amd.com>
In-Reply-To: <79ebdfb4-1d10-dc9d-e35e-ceb9369b66c4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-03-19T01:34:55.066Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.40.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b4c6afc-1435-4e02-9e5c-08d7cba5baac
x-ms-traffictypediagnostic: MN2PR12MB4237:|MN2PR12MB4237:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB423710DC4422F75D9650E758F7F40@MN2PR12MB4237.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(199004)(8676002)(55016002)(2906002)(76116006)(45080400002)(9686003)(478600001)(30864003)(19627405001)(52536014)(71200400001)(33656002)(186003)(5660300002)(86362001)(26005)(8936002)(81166006)(81156014)(66946007)(966005)(66446008)(66556008)(64756008)(66476007)(110136005)(53546011)(6506007)(7696005)(316002)(21314003)(579004)(559001)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4237;
 H:MN2PR12MB4488.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sTr5/R1GTXD4f2KaOYRY764Je6pUNkSoraMp48pBl/9xuz9BYVdYolVoRFfXbXNJKP/Ptid6HK+limDsdmMwez99a6y+Am/6/U39Sqqk4/4RkjAOdDzhNGB1IbdJU4bQQMueBUrhxWZzJO/KAs+nndnk5/OGeW5dh0OTO8ZX4VC2xiGzHs2VKy4yi2dRgcVkqoCfMtQeLshXn2UTtb4ENNxeEW0VtOtv6uDAxQk3k/bnsPoxXgNRT2ybkttL+NOtiOWO5OCnFBqEwAdUoSNkj3PEvCJcp+AfGf45zWFZt4YH5jBy12F6cK9HY818W419Ov6j+aw7tcdOdWZNx+OGiddD3Y4q3KDWkJGdjdp/vUnSaj2lny+Lqg/xApjT7nfNQCWhEHxcjh2TYQ3dKKCUsUKbHOwCfm1IHkN4CmCIHhPSsnmFX5/FnHcIZk3e4qi6xxi6RdZoB862uSSzXgeotpGUVbRjP05HtbyLhfpN2JBn+3JNFWSRg5xf9JAsAGzMoZdKQ2xa5uPCemslMzn/ex9dB9qcQtLT/iPJYKT9em9nCoyt7ht7vu/MYn9fsz0i
x-ms-exchange-antispam-messagedata: nawNMhRn300H2GUDgLuSxC+jnnLPK2EvUmCCSK8RpvOXgiwucKnvUrbIbMJRjLpZb3Kt2OYnK6XgPYfMAAMaW9PC0ZVo7GTrmYbDDN4eLNwDrXcUs377T2w9UwMLKF6D+DunrxiVZV3/+8EexFAdXA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4c6afc-1435-4e02-9e5c-08d7cba5baac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 01:34:55.7136 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IyKhbB/0shm8D/z9QQW4mS36+PUN9v73mC4+AKlPZCYBzWU39PJoCvD3nXTaURDd+g6Ix/he4Q6lR0bMYan3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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
Content-Type: multipart/mixed; boundary="===============1159011276=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1159011276==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488DACAE0B3A4A3FC822A87F7F40MN2PR12MB4488namp_"

--_000_MN2PR12MB4488DACAE0B3A4A3FC822A87F7F40MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

if we have been using vega10_ih all along for arcturus, presumably the regi=
ster map is close enough.  I'd suggest either adding whatever new stuff you=
 need to vega10_ih.c or navi10_ih.c.  No need to add a completely new one f=
or a small change like this.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <felix.kuehling@amd.com>
Sent: Wednesday, March 18, 2020 7:33 PM
To: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>; amd-gfx@lists.fre=
edesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/8] drm/amdgpu: create new files for arcturus ih

How much overlap is there between arcturus_ih and nave10_ih? Given that
they both use the same register map, could they share the same driver
code with only minor differences?

If they're almost the same, maybe you could rename navi10_ih.[ch] to
osssys_v5_0.[ch] and use it for both navi10 and arcturus.

Regards,
   Felix

On 2020-03-18 18:51, Alex Sierra wrote:
> [Why]
> Arcturus uses osssys v4.2. This shares the same register map as
> osssys v5.0.
>
> [How]
> Copy vega10_ih into new arcturus_ih source and header files.
> Replace osssys include file with v5.0.0 on arcturus_ih.c source.
>
> Change-Id: I5215f32f477adb6a30acef6e8add9f8e5bb041ef
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 766 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/arcturus_ih.h |  30 +
>   2 files changed, 796 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/drm/a=
md/amdgpu/arcturus_ih.c
> new file mode 100644
> index 000000000000..21bb5be40921
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
> @@ -0,0 +1,766 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_ih.h"
> +#include "soc15.h"
> +
> +#include "oss/osssys_5_0_0_offset.h"
> +#include "oss/osssys_5_0_0_sh_mask.h"
> +
> +#include "soc15_common.h"
> +#include "arcturus_ih.h"
> +
> +#define MAX_REARM_RETRY 10
> +
> +static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
> +
> +/**
> + * vega10_ih_enable_interrupts - Enable the interrupt ring buffer
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Enable the interrupt ring buffer (VEGA10).
> + */
> +static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
> +{
> +     u32 ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
> +
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1=
);
> +     if (amdgpu_sriov_vf(adev)) {
> +             if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_c=
ntl)) {
> +                     DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                     return;
> +             }
> +     } else {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> +     }
> +     adev->irq.ih.enabled =3D true;
> +
> +     if (adev->irq.ih1.ring_size) {
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> +                                        RB_ENABLE, 1);
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING1,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING1 failed!=
\n");
> +                             return;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_c=
ntl);
> +             }
> +             adev->irq.ih1.enabled =3D true;
> +     }
> +
> +     if (adev->irq.ih2.ring_size) {
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> +                                        RB_ENABLE, 1);
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING2,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING2 failed!=
\n");
> +                             return;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_c=
ntl);
> +             }
> +             adev->irq.ih2.enabled =3D true;
> +     }
> +}
> +
> +/**
> + * vega10_ih_disable_interrupts - Disable the interrupt ring buffer
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Disable the interrupt ring buffer (VEGA10).
> + */
> +static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
> +{
> +     u32 ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
> +
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0=
);
> +     if (amdgpu_sriov_vf(adev)) {
> +             if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_c=
ntl)) {
> +                     DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                     return;
> +             }
> +     } else {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> +     }
> +
> +     /* set rptr, wptr to 0 */
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
> +     adev->irq.ih.enabled =3D false;
> +     adev->irq.ih.rptr =3D 0;
> +
> +     if (adev->irq.ih1.ring_size) {
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
> +                                        RB_ENABLE, 0);
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING1,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING1 failed!=
\n");
> +                             return;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_c=
ntl);
> +             }
> +             /* set rptr, wptr to 0 */
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
> +             adev->irq.ih1.enabled =3D false;
> +             adev->irq.ih1.rptr =3D 0;
> +     }
> +
> +     if (adev->irq.ih2.ring_size) {
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
> +                                        RB_ENABLE, 0);
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING2,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING2 failed!=
\n");
> +                             return;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_c=
ntl);
> +             }
> +
> +             /* set rptr, wptr to 0 */
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
> +             adev->irq.ih2.enabled =3D false;
> +             adev->irq.ih2.rptr =3D 0;
> +     }
> +}
> +
> +static uint32_t vega10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih=
_rb_cntl)
> +{
> +     int rb_bufsz =3D order_base_2(ih->ring_size / 4);
> +
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                MC_SPACE, ih->use_bus_addr ? 1 : 4);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_OVERFLOW_CLEAR, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_OVERFLOW_ENABLE, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_SIZE, rb_bu=
fsz);
> +     /* Ring Buffer write pointer writeback. If enabled, IH_RB_WPTR regi=
ster
> +      * value is written to memory
> +      */
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                WPTR_WRITEBACK_ENABLE, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_SNOOP, 1);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_RO, 0);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, MC_VMID, 0);
> +
> +     return ih_rb_cntl;
> +}
> +
> +static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
> +{
> +     u32 ih_doorbell_rtpr =3D 0;
> +
> +     if (ih->use_doorbell) {
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR, OFFSET,
> +                                              ih->doorbell_index);
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR,
> +                                              ENABLE, 1);
> +     } else {
> +             ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,
> +                                              IH_DOORBELL_RPTR,
> +                                              ENABLE, 0);
> +     }
> +     return ih_doorbell_rtpr;
> +}
> +
> +/**
> + * vega10_ih_irq_init - init and enable the interrupt ring
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Allocate a ring buffer for the interrupt controller,
> + * enable the RLC, disable interrupts, enable the IH
> + * ring buffer and enable it (VI).
> + * Called at device load and reume.
> + * Returns 0 for success, errors for failure.
> + */
> +static int vega10_ih_irq_init(struct amdgpu_device *adev)
> +{
> +     struct amdgpu_ih_ring *ih;
> +     u32 ih_rb_cntl, ih_chicken;
> +     int ret =3D 0;
> +     u32 tmp;
> +
> +     /* disable irqs */
> +     vega10_ih_disable_interrupts(adev);
> +
> +     adev->nbio.funcs->ih_control(adev);
> +
> +     ih =3D &adev->irq.ih;
> +     /* Ring Buffer base. [39:8] of 40-bit address of the beginning of t=
he ring buffer*/
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE, ih->gpu_addr >> 8);
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xf=
f);
> +
> +     ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
> +     ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_rb_cntl);
> +     ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
> +                                !!adev->irq.msi_enabled);
> +     if (amdgpu_sriov_vf(adev)) {
> +             if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_c=
ntl)) {
> +                     DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
> +                     return -ETIMEDOUT;
> +             }
> +     } else {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
> +     }
> +
> +     if ((adev->asic_type =3D=3D CHIP_ARCTURUS &&
> +          adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) ||
> +         adev->asic_type =3D=3D CHIP_RENOIR) {
> +             ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
> +             if (adev->irq.ih.use_bus_addr) {
> +                     ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICKEN=
,
> +                                                MC_SPACE_GPA_ENABLE, 1);
> +             } else {
> +                     ih_chicken =3D REG_SET_FIELD(ih_chicken, IH_CHICKEN=
,
> +                                                MC_SPACE_FBPA_ENABLE, 1)=
;
> +             }
> +             WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);
> +     }
> +
> +     /* set the writeback address whether it's enabled or not */
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
> +                  lower_32_bits(ih->wptr_addr));
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI,
> +                  upper_32_bits(ih->wptr_addr) & 0xFFFF);
> +
> +     /* set rptr, wptr to 0 */
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
> +     WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
> +
> +     WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR,
> +                  vega10_ih_doorbell_rptr(ih));
> +
> +     ih =3D &adev->irq.ih1;
> +     if (ih->ring_size) {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING1, ih->gpu_addr >>=
 8);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING1,
> +                          (ih->gpu_addr >> 40) & 0xff);
> +
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
> +             ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_rb_cntl);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                        WPTR_OVERFLOW_ENABLE, 0);
> +             ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
> +                                        RB_FULL_DRAIN_ENABLE, 1);
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING1,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING1 failed!=
\n");
> +                             return -ETIMEDOUT;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_c=
ntl);
> +             }
> +
> +             /* set rptr, wptr to 0 */
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
> +
> +             WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,
> +                          vega10_ih_doorbell_rptr(ih));
> +     }
> +
> +     ih =3D &adev->irq.ih2;
> +     if (ih->ring_size) {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING2, ih->gpu_addr >>=
 8);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING2,
> +                          (ih->gpu_addr >> 40) & 0xff);
> +
> +             ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
> +             ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_rb_cntl);
> +
> +             if (amdgpu_sriov_vf(adev)) {
> +                     if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_=
RING2,
> +                                             ih_rb_cntl)) {
> +                             DRM_ERROR("program IH_RB_CNTL_RING2 failed!=
\n");
> +                             return -ETIMEDOUT;
> +                     }
> +             } else {
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_c=
ntl);
> +             }
> +
> +             /* set rptr, wptr to 0 */
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
> +
> +             WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,
> +                          vega10_ih_doorbell_rptr(ih));
> +     }
> +
> +     tmp =3D RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
> +     tmp =3D REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
> +                         CLIENT18_IS_STORM_CLIENT, 1);
> +     WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
> +
> +     tmp =3D RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
> +     tmp =3D REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1)=
;
> +     WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
> +
> +     pci_set_master(adev->pdev);
> +
> +     /* enable interrupts */
> +     vega10_ih_enable_interrupts(adev);
> +
> +     return ret;
> +}
> +
> +/**
> + * vega10_ih_irq_disable - disable interrupts
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Disable interrupts on the hw (VEGA10).
> + */
> +static void vega10_ih_irq_disable(struct amdgpu_device *adev)
> +{
> +     vega10_ih_disable_interrupts(adev);
> +
> +     /* Wait and acknowledge irq */
> +     mdelay(1);
> +}
> +
> +/**
> + * vega10_ih_get_wptr - get the IH ring buffer wptr
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Get the IH ring buffer wptr from either the register
> + * or the writeback memory buffer (VEGA10).  Also check for
> + * ring buffer overflow and deal with it.
> + * Returns the value of the wptr.
> + */
> +static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
> +                           struct amdgpu_ih_ring *ih)
> +{
> +     u32 wptr, reg, tmp;
> +
> +     wptr =3D le32_to_cpu(*ih->wptr_cpu);
> +
> +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +             goto out;
> +
> +     /* Double check that the overflow wasn't already cleared. */
> +
> +     if (ih =3D=3D &adev->irq.ih)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
> +     else if (ih =3D=3D &adev->irq.ih1)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);
> +     else if (ih =3D=3D &adev->irq.ih2)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);
> +     else
> +             BUG();
> +
> +     wptr =3D RREG32_NO_KIQ(reg);
> +     if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
> +             goto out;
> +
> +     wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
> +
> +     /* When a ring buffer overflow happen start parsing interrupt
> +      * from the last not overwritten vector (wptr + 32). Hopefully
> +      * this should allow us to catchup.
> +      */
> +     tmp =3D (wptr + 32) & ih->ptr_mask;
> +     dev_warn(adev->dev, "IH ring buffer overflow "
> +              "(0x%08X, 0x%08X, 0x%08X)\n",
> +              wptr, ih->rptr, tmp);
> +     ih->rptr =3D tmp;
> +
> +     if (ih =3D=3D &adev->irq.ih)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
> +     else if (ih =3D=3D &adev->irq.ih1)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);
> +     else if (ih =3D=3D &adev->irq.ih2)
> +             reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);
> +     else
> +             BUG();
> +
> +     tmp =3D RREG32_NO_KIQ(reg);
> +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> +     WREG32_NO_KIQ(reg, tmp);
> +
> +out:
> +     return (wptr & ih->ptr_mask);
> +}
> +
> +/**
> + * vega10_ih_decode_iv - decode an interrupt vector
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Decodes the interrupt vector at the current rptr
> + * position and also advance the position.
> + */
> +static void vega10_ih_decode_iv(struct amdgpu_device *adev,
> +                             struct amdgpu_ih_ring *ih,
> +                             struct amdgpu_iv_entry *entry)
> +{
> +     /* wptr/rptr are in bytes! */
> +     u32 ring_index =3D ih->rptr >> 2;
> +     uint32_t dw[8];
> +
> +     dw[0] =3D le32_to_cpu(ih->ring[ring_index + 0]);
> +     dw[1] =3D le32_to_cpu(ih->ring[ring_index + 1]);
> +     dw[2] =3D le32_to_cpu(ih->ring[ring_index + 2]);
> +     dw[3] =3D le32_to_cpu(ih->ring[ring_index + 3]);
> +     dw[4] =3D le32_to_cpu(ih->ring[ring_index + 4]);
> +     dw[5] =3D le32_to_cpu(ih->ring[ring_index + 5]);
> +     dw[6] =3D le32_to_cpu(ih->ring[ring_index + 6]);
> +     dw[7] =3D le32_to_cpu(ih->ring[ring_index + 7]);
> +
> +     entry->client_id =3D dw[0] & 0xff;
> +     entry->src_id =3D (dw[0] >> 8) & 0xff;
> +     entry->ring_id =3D (dw[0] >> 16) & 0xff;
> +     entry->vmid =3D (dw[0] >> 24) & 0xf;
> +     entry->vmid_src =3D (dw[0] >> 31);
> +     entry->timestamp =3D dw[1] | ((u64)(dw[2] & 0xffff) << 32);
> +     entry->timestamp_src =3D dw[2] >> 31;
> +     entry->pasid =3D dw[3] & 0xffff;
> +     entry->pasid_src =3D dw[3] >> 31;
> +     entry->src_data[0] =3D dw[4];
> +     entry->src_data[1] =3D dw[5];
> +     entry->src_data[2] =3D dw[6];
> +     entry->src_data[3] =3D dw[7];
> +
> +     /* wptr/rptr are in bytes! */
> +     ih->rptr +=3D 32;
> +}
> +
> +/**
> + * vega10_ih_irq_rearm - rearm IRQ if lost
> + *
> + * @adev: amdgpu_device pointer
> + *
> + */
> +static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
> +                            struct amdgpu_ih_ring *ih)
> +{
> +     uint32_t reg_rptr =3D 0;
> +     uint32_t v =3D 0;
> +     uint32_t i =3D 0;
> +
> +     if (ih =3D=3D &adev->irq.ih)
> +             reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
> +     else if (ih =3D=3D &adev->irq.ih1)
> +             reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1=
);
> +     else if (ih =3D=3D &adev->irq.ih2)
> +             reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2=
);
> +     else
> +             return;
> +
> +     /* Rearm IRQ / re-wwrite doorbell if doorbell write is lost */
> +     for (i =3D 0; i < MAX_REARM_RETRY; i++) {
> +             v =3D RREG32_NO_KIQ(reg_rptr);
> +             if ((v < ih->ring_size) && (v !=3D ih->rptr))
> +                     WDOORBELL32(ih->doorbell_index, ih->rptr);
> +             else
> +                     break;
> +     }
> +}
> +
> +/**
> + * vega10_ih_set_rptr - set the IH ring buffer rptr
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Set the IH ring buffer rptr.
> + */
> +static void vega10_ih_set_rptr(struct amdgpu_device *adev,
> +                            struct amdgpu_ih_ring *ih)
> +{
> +     if (ih->use_doorbell) {
> +             /* XXX check if swapping is necessary on BE */
> +             *ih->rptr_cpu =3D ih->rptr;
> +             WDOORBELL32(ih->doorbell_index, ih->rptr);
> +
> +             if (amdgpu_sriov_vf(adev))
> +                     vega10_ih_irq_rearm(adev, ih);
> +     } else if (ih =3D=3D &adev->irq.ih) {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
> +     } else if (ih =3D=3D &adev->irq.ih1) {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, ih->rptr);
> +     } else if (ih =3D=3D &adev->irq.ih2) {
> +             WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, ih->rptr);
> +     }
> +}
> +
> +/**
> + * vega10_ih_self_irq - dispatch work for ring 1 and 2
> + *
> + * @adev: amdgpu_device pointer
> + * @source: irq source
> + * @entry: IV with WPTR update
> + *
> + * Update the WPTR from the IV and schedule work to handle the entries.
> + */
> +static int vega10_ih_self_irq(struct amdgpu_device *adev,
> +                           struct amdgpu_irq_src *source,
> +                           struct amdgpu_iv_entry *entry)
> +{
> +     uint32_t wptr =3D cpu_to_le32(entry->src_data[0]);
> +
> +     switch (entry->ring_id) {
> +     case 1:
> +             *adev->irq.ih1.wptr_cpu =3D wptr;
> +             schedule_work(&adev->irq.ih1_work);
> +             break;
> +     case 2:
> +             *adev->irq.ih2.wptr_cpu =3D wptr;
> +             schedule_work(&adev->irq.ih2_work);
> +             break;
> +     default:
> +             break;
> +     }
> +     return 0;
> +}
> +
> +static const struct amdgpu_irq_src_funcs vega10_ih_self_irq_funcs =3D {
> +     .process =3D vega10_ih_self_irq,
> +};
> +
> +static void vega10_ih_set_self_irq_funcs(struct amdgpu_device *adev)
> +{
> +     adev->irq.self_irq.num_types =3D 0;
> +     adev->irq.self_irq.funcs =3D &vega10_ih_self_irq_funcs;
> +}
> +
> +static int vega10_ih_early_init(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     vega10_ih_set_interrupt_funcs(adev);
> +     vega10_ih_set_self_irq_funcs(adev);
> +     return 0;
> +}
> +
> +static int vega10_ih_sw_init(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     int r;
> +
> +     r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
> +                           &adev->irq.self_irq);
> +     if (r)
> +             return r;
> +
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
> +     if (r)
> +             return r;
> +
> +     adev->irq.ih.use_doorbell =3D true;
> +     adev->irq.ih.doorbell_index =3D adev->doorbell_index.ih << 1;
> +
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
> +     if (r)
> +             return r;
> +
> +     adev->irq.ih1.use_doorbell =3D true;
> +     adev->irq.ih1.doorbell_index =3D (adev->doorbell_index.ih + 1) << 1=
;
> +
> +     r =3D amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
> +     if (r)
> +             return r;
> +
> +     adev->irq.ih2.use_doorbell =3D true;
> +     adev->irq.ih2.doorbell_index =3D (adev->doorbell_index.ih + 2) << 1=
;
> +
> +     r =3D amdgpu_irq_init(adev);
> +
> +     return r;
> +}
> +
> +static int vega10_ih_sw_fini(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     amdgpu_irq_fini(adev);
> +     amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
> +     amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
> +     amdgpu_ih_ring_fini(adev, &adev->irq.ih);
> +
> +     return 0;
> +}
> +
> +static int vega10_ih_hw_init(void *handle)
> +{
> +     int r;
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     r =3D vega10_ih_irq_init(adev);
> +     if (r)
> +             return r;
> +
> +     return 0;
> +}
> +
> +static int vega10_ih_hw_fini(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     vega10_ih_irq_disable(adev);
> +
> +     return 0;
> +}
> +
> +static int vega10_ih_suspend(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     return vega10_ih_hw_fini(adev);
> +}
> +
> +static int vega10_ih_resume(void *handle)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     return vega10_ih_hw_init(adev);
> +}
> +
> +static bool vega10_ih_is_idle(void *handle)
> +{
> +     /* todo */
> +     return true;
> +}
> +
> +static int vega10_ih_wait_for_idle(void *handle)
> +{
> +     /* todo */
> +     return -ETIMEDOUT;
> +}
> +
> +static int vega10_ih_soft_reset(void *handle)
> +{
> +     /* todo */
> +
> +     return 0;
> +}
> +
> +static void vega10_ih_update_clockgating_state(struct amdgpu_device *ade=
v,
> +                                            bool enable)
> +{
> +     uint32_t data, def, field_val;
> +
> +     if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
> +             def =3D data =3D RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);
> +             field_val =3D enable ? 0 : 1;
> +             /**
> +              * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERR=
IDE
> +              * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.
> +              */
> +             if (adev->asic_type > CHIP_VEGA10) {
> +                     data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE=
, field_val);
> +                     data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  IH_BUFFER_MEM_CLK_SOFT_OVERRIDE, field=
_val);
> +             }
> +
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  DBUS_MUX_CLK_SOFT_OVERRIDE, field_val)=
;
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  OSSSYS_SHARE_CLK_SOFT_OVERRIDE, field_=
val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  LIMIT_SMN_CLK_SOFT_OVERRIDE, field_val=
);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  DYN_CLK_SOFT_OVERRIDE, field_val);
> +             data =3D REG_SET_FIELD(data, IH_CLK_CTRL,
> +                                  REG_CLK_SOFT_OVERRIDE, field_val);
> +             if (def !=3D data)
> +                     WREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL, data);
> +     }
> +}
> +
> +static int vega10_ih_set_clockgating_state(void *handle,
> +                                       enum amd_clockgating_state state)
> +{
> +     struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +
> +     vega10_ih_update_clockgating_state(adev,
> +                             state =3D=3D AMD_CG_STATE_GATE);
> +     return 0;
> +
> +}
> +
> +static int vega10_ih_set_powergating_state(void *handle,
> +                                       enum amd_powergating_state state)
> +{
> +     return 0;
> +}
> +
> +const struct amd_ip_funcs vega10_ih_ip_funcs =3D {
> +     .name =3D "vega10_ih",
> +     .early_init =3D vega10_ih_early_init,
> +     .late_init =3D NULL,
> +     .sw_init =3D vega10_ih_sw_init,
> +     .sw_fini =3D vega10_ih_sw_fini,
> +     .hw_init =3D vega10_ih_hw_init,
> +     .hw_fini =3D vega10_ih_hw_fini,
> +     .suspend =3D vega10_ih_suspend,
> +     .resume =3D vega10_ih_resume,
> +     .is_idle =3D vega10_ih_is_idle,
> +     .wait_for_idle =3D vega10_ih_wait_for_idle,
> +     .soft_reset =3D vega10_ih_soft_reset,
> +     .set_clockgating_state =3D vega10_ih_set_clockgating_state,
> +     .set_powergating_state =3D vega10_ih_set_powergating_state,
> +};
> +
> +static const struct amdgpu_ih_funcs vega10_ih_funcs =3D {
> +     .get_wptr =3D vega10_ih_get_wptr,
> +     .decode_iv =3D vega10_ih_decode_iv,
> +     .set_rptr =3D vega10_ih_set_rptr
> +};
> +
> +static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev)
> +{
> +     adev->irq.ih_funcs =3D &vega10_ih_funcs;
> +}
> +
> +const struct amdgpu_ip_block_version vega10_ih_ip_block =3D {
> +     .type =3D AMD_IP_BLOCK_TYPE_IH,
> +     .major =3D 4,
> +     .minor =3D 0,
> +     .rev =3D 0,
> +     .funcs =3D &vega10_ih_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h b/drivers/gpu/drm/a=
md/amdgpu/arcturus_ih.h
> new file mode 100644
> index 000000000000..54daf8cf6ff3
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __VEGA10_IH_H__
> +#define __VEGA10_IH_H__
> +
> +extern const struct amd_ip_funcs vega10_ih_ip_funcs;
> +extern const struct amdgpu_ip_block_version vega10_ih_ip_block;
> +
> +#endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ca1fe681c257644a9727c08d7cb94d5f5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637201712448085102&amp;sdata=3DM8SSL1wFhDgmkyFd36k=
MHmuPzAqp%2BU0QHwttrz0rOzo%3D&amp;reserved=3D0

--_000_MN2PR12MB4488DACAE0B3A4A3FC822A87F7F40MN2PR12MB4488namp_
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
if we have been using vega10_ih all along for arcturus, presumably the regi=
ster map is close enough.&nbsp; I'd suggest either adding whatever new stuf=
f you need to vega10_ih.c or navi10_ih.c.&nbsp; No need to add a completely=
 new one for a small change like this.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;felix.kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Wednesday, March 18, 2020 7:33 PM<br>
<b>To:</b> Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;; amd-=
gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/8] drm/amdgpu: create new files for arcturus i=
h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">How much overlap is there between arcturus_ih and =
nave10_ih? Given that
<br>
they both use the same register map, could they share the same driver <br>
code with only minor differences?<br>
<br>
If they're almost the same, maybe you could rename navi10_ih.[ch] to <br>
osssys_v5_0.[ch] and use it for both navi10 and arcturus.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2020-03-18 18:51, Alex Sierra wrote:<br>
&gt; [Why]<br>
&gt; Arcturus uses osssys v4.2. This shares the same register map as<br>
&gt; osssys v5.0.<br>
&gt;<br>
&gt; [How]<br>
&gt; Copy vega10_ih into new arcturus_ih source and header files.<br>
&gt; Replace osssys include file with v5.0.0 on arcturus_ih.c source.<br>
&gt;<br>
&gt; Change-Id: I5215f32f477adb6a30acef6e8add9f8e5bb041ef<br>
&gt; Signed-off-by: Alex Sierra &lt;alex.sierra@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 766 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/arcturus_ih.h |&nbsp; 30 &#43;<=
br>
&gt;&nbsp;&nbsp; 2 files changed, 796 insertions(&#43;)<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.=
c<br>
&gt;&nbsp;&nbsp; create mode 100644 drivers/gpu/drm/amd/amdgpu/arcturus_ih.=
h<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/dr=
m/amd/amdgpu/arcturus_ih.c<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..21bb5be40921<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c<br>
&gt; @@ -0,0 &#43;1,766 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#include &lt;linux/pci.h&gt;<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt; &#43;#include &quot;amdgpu_ih.h&quot;<br>
&gt; &#43;#include &quot;soc15.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;oss/osssys_5_0_0_offset.h&quot;<br>
&gt; &#43;#include &quot;oss/osssys_5_0_0_sh_mask.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;soc15_common.h&quot;<br>
&gt; &#43;#include &quot;arcturus_ih.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#define MAX_REARM_RETRY 10<br>
&gt; &#43;<br>
&gt; &#43;static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *a=
dev);<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_enable_interrupts - Enable the interrupt ring buffer=
<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Enable the interrupt ring buffer (VEGA10).<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_enable_interrupts(struct amdgpu_device *ade=
v)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_rb_cntl =3D RREG32_SOC15(OSSSYS, =
0, mmIH_RB_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, RB_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, ENABLE_INTR, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL, ih_rb_cn=
tl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP=
 program IH_RB_CNTL failed!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.enabled =3D true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih1.ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING1 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih1.enabled =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih2.ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RB_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING2 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih2.enabled =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_disable_interrupts - Disable the interrupt ring buff=
er<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Disable the interrupt ring buffer (VEGA10).<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_disable_interrupts(struct amdgpu_device *ad=
ev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_rb_cntl =3D RREG32_SOC15(OSSSYS, =
0, mmIH_RB_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, RB_ENABLE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, ENABLE_INTR, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL, ih_rb_cn=
tl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP=
 program IH_RB_CNTL failed!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.enabled =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.rptr =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih1.ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RB_ENABLE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING1 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih1.enabled =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih1.rptr =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;irq.ih2.ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RB_ENABLE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING2 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih2.enabled =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;irq.ih2.rptr =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static uint32_t vega10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint=
32_t ih_rb_cntl)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int rb_bufsz =3D order_base_2(ih-&gt;rin=
g_size / 4);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_SPACE, ih-&gt;use_bus_add=
r ? 1 : 4);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WPTR_OVERFLOW_CLEAR, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WPTR_OVERFLOW_ENABLE, 1);<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, RB_SIZE, rb_bufsz);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Ring Buffer write pointer writeback. =
If enabled, IH_RB_WPTR register<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * value is written to memory<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WPTR_WRITEBACK_ENABLE, 1);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, MC_SNOOP, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, MC_RO, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, MC_VMID, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ih_rb_cntl;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih=
)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_doorbell_rtpr =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;use_doorbell) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_DOORBELL_RPTR, O=
FFSET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;doorbell_ind=
ex);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_DOORBELL_RPTR,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_doorbell_rtpr =3D REG_SET_FIELD(ih_doorbell_rtpr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_DOORBELL_RPTR,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENABLE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ih_doorbell_rtpr;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_irq_init - init and enable the interrupt ring<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Allocate a ring buffer for the interrupt controller,<br>
&gt; &#43; * enable the RLC, disable interrupts, enable the IH<br>
&gt; &#43; * ring buffer and enable it (VI).<br>
&gt; &#43; * Called at device load and reume.<br>
&gt; &#43; * Returns 0 for success, errors for failure.<br>
&gt; &#43; */<br>
&gt; &#43;static int vega10_ih_irq_init(struct amdgpu_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ih_rb_cntl, ih_chicken;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* disable irqs */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_disable_interrupts(adev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;ih_control(adev)=
;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih =3D &amp;adev-&gt;irq.ih;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Ring Buffer base. [39:8] of 40-bit ad=
dress of the beginning of the ring buffer*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE, ih=
-&gt;gpu_addr &gt;&gt; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI,=
 (ih-&gt;gpu_addr &gt;&gt; 40) &amp; 0xff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, m=
mIH_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_=
rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl,=
 IH_RB_CNTL, RPTR_REARM,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!adev-&gt;irq.msi_enabled);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (psp_reg_program(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL, ih_rb_cn=
tl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;PSP=
 program IH_RB_CNTL failed!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_ARCT=
URUS &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;f=
irmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;asic_ty=
pe =3D=3D CHIP_RENOIR) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_chicken =3D RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;irq.ih.use_bus_addr) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_chicken =3D REG_=
SET_FIELD(ih_chicken, IH_CHICKEN,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_SPAC=
E_GPA_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_chicken =3D REG_=
SET_FIELD(ih_chicken, IH_CHICKEN,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MC_SPAC=
E_FBPA_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN, ih_chicken);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* set the writeback address whether it'=
s enabled or not */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADD=
R_LO,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ih-&gt;wptr_addr));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADD=
R_HI,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; upper_32_bits(ih-&gt;wptr_addr) &amp;=
 0xFFFF);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0)=
;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RP=
TR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_doorbell_rptr(ih));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih =3D &amp;adev-&gt;irq.ih1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING1, ih-&gt;gpu_addr &gt;&gt=
; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (ih-&gt;gpu_addr &gt;&gt; 40) &amp; 0xff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; WPTR_OVERFLOW_ENABLE, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; RB_FULL_DRAIN_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING1 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega10_ih_doorbell_rptr(ih));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih =3D &amp;adev-&gt;irq.ih2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;ring_size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING2, ih-&gt;gpu_addr &gt;&gt=
; 8);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (ih-&gt;gpu_addr &gt;&gt; 40) &amp; 0xff);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ih_rb_cntl =3D vega10_ih_rb_cntl(ih, ih_rb_cntl);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp_reg_program=
(&amp;adev-&gt;psp, PSP_REG_IH_RB_CNTL_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih_rb_cntl)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;program IH_RB_CNTL_RING2 faile=
d!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* set rptr, wptr to 0 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega10_ih_doorbell_rptr(ih));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(OSSSYS, 0, mmIH_STO=
RM_CLIENT_LIST_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_STORM_CLIE=
NT_LIST_CNTL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; CLIENT18_IS_STORM_CLIENT, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIEN=
T_LIST_CNTL, tmp);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SOC15(OSSSYS, 0, mmIH_INT=
_FLOOD_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_INT_FLOOD_=
CNTL, FLOOD_CNTL_ENABLE, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_C=
NTL, tmp);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pci_set_master(adev-&gt;pdev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* enable interrupts */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_enable_interrupts(adev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_irq_disable - disable interrupts<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Disable interrupts on the hw (VEGA10).<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_irq_disable(struct amdgpu_device *adev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_disable_interrupts(adev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait and acknowledge irq */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_get_wptr - get the IH ring buffer wptr<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Get the IH ring buffer wptr from either the register<br>
&gt; &#43; * or the writeback memory buffer (VEGA10).&nbsp; Also check for<=
br>
&gt; &#43; * ring buffer overflow and deal with it.<br>
&gt; &#43; * Returns the value of the wptr.<br>
&gt; &#43; */<br>
&gt; &#43;static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 wptr, reg, tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D le32_to_cpu(*ih-&gt;wptr_cpu);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_=
OVERFLOW))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto out;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Double check that the overflow wasn't=
 already cleared. */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.ih)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih1=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih2=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; BUG();<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D RREG32_NO_KIQ(reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_=
OVERFLOW))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; goto out;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR,=
 RB_OVERFLOW, 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* When a ring buffer overflow happen st=
art parsing interrupt<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from the last not overwritten ve=
ctor (wptr &#43; 32). Hopefully<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this should allow us to catchup.=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (wptr &#43; 32) &amp; ih-&gt;ptr=
_mask;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;IH ring buf=
fer overflow &quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &quot;(0x%08X, 0x%08X, 0x%08X)\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; wptr, ih-&gt;rptr, tmp);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr =3D tmp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.ih)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih1=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih2=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; BUG();<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_NO_KIQ(reg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, W=
PTR_OVERFLOW_CLEAR, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(reg, tmp);<br>
&gt; &#43;<br>
&gt; &#43;out:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return (wptr &amp; ih-&gt;ptr_mask);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_decode_iv - decode an interrupt vector<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Decodes the interrupt vector at the current rptr<br>
&gt; &#43; * position and also advance the position.<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_decode_iv(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* wptr/rptr are in bytes! */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 ring_index =3D ih-&gt;rptr &gt;&gt; =
2;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t dw[8];<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[0] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 0]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[1] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 1]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[2] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 2]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[3] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 3]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[4] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 4]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[5] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 5]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[6] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 6]);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; dw[7] =3D le32_to_cpu(ih-&gt;ring[ring_i=
ndex &#43; 7]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;client_id =3D dw[0] &amp; 0xff=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_id =3D (dw[0] &gt;&gt; 8) =
&amp; 0xff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;ring_id =3D (dw[0] &gt;&gt; 16=
) &amp; 0xff;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid =3D (dw[0] &gt;&gt; 24) &=
amp; 0xf;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;vmid_src =3D (dw[0] &gt;&gt; 3=
1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;timestamp =3D dw[1] | ((u64)(d=
w[2] &amp; 0xffff) &lt;&lt; 32);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;timestamp_src =3D dw[2] &gt;&g=
t; 31;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;pasid =3D dw[3] &amp; 0xffff;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;pasid_src =3D dw[3] &gt;&gt; 3=
1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_data[0] =3D dw[4];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_data[1] =3D dw[5];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_data[2] =3D dw[6];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;src_data[3] =3D dw[7];<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* wptr/rptr are in bytes! */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr &#43;=3D 32;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_irq_rearm - rearm IRQ if lost<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_irq_rearm(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reg_rptr =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t v =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.ih)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih1=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih2=
)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; reg_rptr =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Rearm IRQ / re-wwrite doorbell if doo=
rbell write is lost */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_REARM_RETRY; i&=
#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; v =3D RREG32_NO_KIQ(reg_rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if ((v &lt; ih-&gt;ring_size) &amp;&amp; (v !=3D ih-&gt;rptr))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WDOORBELL32(ih-&gt;=
doorbell_index, ih-&gt;rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_set_rptr - set the IH ring buffer rptr<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; *<br>
&gt; &#43; * Set the IH ring buffer rptr.<br>
&gt; &#43; */<br>
&gt; &#43;static void vega10_ih_set_rptr(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;use_doorbell) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* XXX check if swapping is necessary on BE */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *ih-&gt;rptr_cpu =3D ih-&gt;rptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WDOORBELL32(ih-&gt;doorbell_index, ih-&gt;rptr);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_irq_rearm=
(adev, ih);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;adev-&gt;irq.i=
h) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih-&gt;rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;adev-&gt;irq.i=
h1) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, ih-&gt;rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ih =3D=3D &amp;adev-&gt;irq.i=
h2) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, ih-&gt;rptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;/**<br>
&gt; &#43; * vega10_ih_self_irq - dispatch work for ring 1 and 2<br>
&gt; &#43; *<br>
&gt; &#43; * @adev: amdgpu_device pointer<br>
&gt; &#43; * @source: irq source<br>
&gt; &#43; * @entry: IV with WPTR update<br>
&gt; &#43; *<br>
&gt; &#43; * Update the WPTR from the IV and schedule work to handle the en=
tries.<br>
&gt; &#43; */<br>
&gt; &#43;static int vega10_ih_self_irq(struct amdgpu_device *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_irq_src *source,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wptr =3D cpu_to_le32(entry-&gt;=
src_data[0]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (entry-&gt;ring_id) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *adev-&gt;irq.ih1.wptr_cpu =3D wptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; schedule_work(&amp;adev-&gt;irq.ih1_work);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; *adev-&gt;irq.ih2.wptr_cpu =3D wptr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; schedule_work(&amp;adev-&gt;irq.ih2_work);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct amdgpu_irq_src_funcs vega10_ih_self_irq_funcs=
 =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .process =3D vega10_ih_self_irq,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static void vega10_ih_set_self_irq_funcs(struct amdgpu_device *ad=
ev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.self_irq.num_types =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.self_irq.funcs =3D &amp;veg=
a10_ih_self_irq_funcs;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_early_init(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_set_interrupt_funcs(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_set_self_irq_funcs(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_sw_init(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_add_id(adev, SOC15_IH_C=
LIENTID_IH, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; &amp;adev-&gt;irq.self_irq);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ih_ring_init(adev, &amp;ade=
v-&gt;irq.ih, 256 * 1024, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.use_doorbell =3D true;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih.doorbell_index =3D adev-=
&gt;doorbell_index.ih &lt;&lt; 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ih_ring_init(adev, &amp;ade=
v-&gt;irq.ih1, PAGE_SIZE, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih1.use_doorbell =3D true;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih1.doorbell_index =3D (ade=
v-&gt;doorbell_index.ih &#43; 1) &lt;&lt; 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ih_ring_init(adev, &amp;ade=
v-&gt;irq.ih2, PAGE_SIZE, true);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih2.use_doorbell =3D true;<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih2.doorbell_index =3D (ade=
v-&gt;doorbell_index.ih &#43; 2) &lt;&lt; 1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_irq_init(adev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_sw_fini(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_irq_fini(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &amp;adev-&gt;=
irq.ih2);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &amp;adev-&gt;=
irq.ih1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_ring_fini(adev, &amp;adev-&gt;=
irq.ih);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_hw_init(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vega10_ih_irq_init(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_hw_fini(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_irq_disable(adev);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_suspend(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return vega10_ih_hw_fini(adev);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_resume(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return vega10_ih_hw_init(adev);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static bool vega10_ih_is_idle(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_wait_for_idle(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_soft_reset(void *handle)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void vega10_ih_update_clockgating_state(struct amdgpu_devi=
ce *adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t data, def, field_val;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;cg_flags &amp; AMD_CG_SUPPO=
RT_IH_CG) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; def =3D data =3D RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; field_val =3D enable ? 0 : 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /**<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;asic_type &gt; CHIP_VEGA10) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FI=
ELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_RETRY_INT_CAM=
_MEM_CLK_SOFT_OVERRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data =3D REG_SET_FI=
ELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IH_BUFFER_MEM_CL=
K_SOFT_OVERRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DBUS_MUX_CLK_SOF=
T_OVERRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OSSSYS_SHARE_CLK=
_SOFT_OVERRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LIMIT_SMN_CLK_SO=
FT_OVERRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DYN_CLK_SOFT_OVE=
RRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; data =3D REG_SET_FIELD(data, IH_CLK_CTRL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_CLK_SOFT_OVE=
RRIDE, field_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (def !=3D data)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(OSSSYS=
, 0, mmIH_CLK_CTRL, data);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_set_clockgating_state(void *handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum amd_clockgating_state state)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struct a=
mdgpu_device *)handle;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vega10_ih_update_clockgating_state(adev,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int vega10_ih_set_powergating_state(void *handle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum amd_powergating_state state)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;const struct amd_ip_funcs vega10_ih_ip_funcs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D &quot;vega10_ih&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .early_init =3D vega10_ih_early_init,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .late_init =3D NULL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .sw_init =3D vega10_ih_sw_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .sw_fini =3D vega10_ih_sw_fini,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .hw_init =3D vega10_ih_hw_init,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .hw_fini =3D vega10_ih_hw_fini,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .suspend =3D vega10_ih_suspend,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D vega10_ih_resume,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .is_idle =3D vega10_ih_is_idle,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .wait_for_idle =3D vega10_ih_wait_for_id=
le,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .soft_reset =3D vega10_ih_soft_reset,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .set_clockgating_state =3D vega10_ih_set=
_clockgating_state,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .set_powergating_state =3D vega10_ih_set=
_powergating_state,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const struct amdgpu_ih_funcs vega10_ih_funcs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr =3D vega10_ih_get_wptr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .decode_iv =3D vega10_ih_decode_iv,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .set_rptr =3D vega10_ih_set_rptr<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *a=
dev)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;irq.ih_funcs =3D &amp;vega10_ih=
_funcs;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;const struct amdgpu_ip_block_version vega10_ih_ip_block =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D AMD_IP_BLOCK_TYPE_IH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .major =3D 4,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .minor =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .rev =3D 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .funcs =3D &amp;vega10_ih_ip_funcs,<br>
&gt; &#43;};<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h b/drivers/gpu/dr=
m/amd/amdgpu/arcturus_ih.h<br>
&gt; new file mode 100644<br>
&gt; index 000000000000..54daf8cf6ff3<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h<br>
&gt; @@ -0,0 &#43;1,30 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2020 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef __VEGA10_IH_H__<br>
&gt; &#43;#define __VEGA10_IH_H__<br>
&gt; &#43;<br>
&gt; &#43;extern const struct amd_ip_funcs vega10_ih_ip_funcs;<br>
&gt; &#43;extern const struct amdgpu_ip_block_version vega10_ih_ip_block;<b=
r>
&gt; &#43;<br>
&gt; &#43;#endif<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7Ca1fe681c257644a9727c08d7cb94d5f5%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637201712448085102&amp;amp;sdata=3D=
M8SSL1wFhDgmkyFd36kMHmuPzAqp%2BU0QHwttrz0rOzo%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7Ca1fe681c257644a9727c08d7cb94d5f5%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637201712448085102&amp;amp;sdata=3DM8SSL1wFhDgmkyF=
d36kMHmuPzAqp%2BU0QHwttrz0rOzo%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488DACAE0B3A4A3FC822A87F7F40MN2PR12MB4488namp_--

--===============1159011276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1159011276==--
