Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9021DC2BA19
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ACD7206D5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 02:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XqpFLWIS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACD7206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 037FE6E4A5;
	Wed, 22 Apr 2020 02:48:05 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2CA6E4A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 02:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkfpXiFx/okgK7qjYtTIZIKixMV6z7kCSDhjGc0UGg5Q5rvGLvqIAox4WhIsfzW4CSnOuRNxGFmxCMpd46mnVS5TLFgi7WHA6b0qJp/HSKIi72+CYO2UF7JU1L04eqx3ec5Xbrw3EmwQWkOWDtsKIzST0nCoX71JCFzqnbSqfQmYsVPDjeGMmzlVqHpEvljwvWbcfPLhx489x59R2j1MTfwmGIz1Ce7Bz389CM0PMxHCBbg/zvkhC6Jg+dpyXkqxCZYEYp1ofuryB7QPUoJEP38A2LVen1uXRLMlEL5Cw8pBabADK/+XQ4lG4rqCHhf0XCveH1Z/P4WzKLYFrF09EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6m0HaywQWrQo80gt+AS6Oa2uuytheeOyypNUPEicBU=;
 b=HMa9b5Njati0WD/jClR7WqAiuDfSDUljeusgv0WABsOFkFqIKz9QkGlWETiYmGI+MKsA6hjg0QVKaAG3klIE5ddd9gL5A8BvtC+JI/xChWz+DTF1dvT1tDEtbQd4q5RuAVJ8flUbFoM0OURAJBlHMgx0I3R/McIYHv01P6CR4eWLDF2IA70oeQeNNnqXb/hQt/dIwrr/qSKUGabRLhn9lrt3o0u4WMmDAzN5H/qQjDOabkZx32wlpRXtfKivYugZcyM3r1EQVakaU5zQJvfUGitYfWPDqFkl2m8AFwZC6Px0AT3d3PTsgPsp8d9XJYN74Jg2mklwZgBwIEc/P+/gmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6m0HaywQWrQo80gt+AS6Oa2uuytheeOyypNUPEicBU=;
 b=XqpFLWISdHnSkAe/GugwwSOGRTWlkg+SjfQeD/JErHD1rwZ4sZ9ts2t20Wbv2TaMrpYTE58QXfgt6yvvIGIZg5z5tzV/VbgNgDhvn0yEwkWxsBc0FZ3u+qJ6Xbh/5jes+Ajt5bT1XQUNzvwDBviUNwaM5Lc4uOJmLHqHZsfae/g=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2777.namprd12.prod.outlook.com (2603:10b6:5:51::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Wed, 22 Apr 2020 02:48:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.027; Wed, 22 Apr 2020
 02:48:02 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: put the audio codec into suspend state before
 gpu reset
Thread-Topic: [PATCH] drm/amdgpu: put the audio codec into suspend state
 before gpu reset
Thread-Index: AQHWF9R3m7qV+BseUkatHOsHiBnY46iEBESAgABreRA=
Date: Wed, 22 Apr 2020 02:48:01 +0000
Message-ID: <DM6PR12MB26190C2038F71E799C2966C2E4D20@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200421120018.11399-1-evan.quan@amd.com>
 <CADnq5_M_VLGcqySs07JecqmfK6dz5UGkb+iNs53iRgiYH01bsA@mail.gmail.com>
In-Reply-To: <CADnq5_M_VLGcqySs07JecqmfK6dz5UGkb+iNs53iRgiYH01bsA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fdf7ebfe-de84-49e2-beae-0000c4b087d1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-22T02:42:45Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2208bfd2-99e7-4826-73dd-08d7e667932a
x-ms-traffictypediagnostic: DM6PR12MB2777:|DM6PR12MB2777:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2777F03812BFFD2FC6478C1DE4D20@DM6PR12MB2777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(54906003)(33656002)(478600001)(45080400002)(4326008)(52536014)(966005)(81156014)(15650500001)(83080400001)(316002)(2906002)(8936002)(6916009)(55016002)(8676002)(9686003)(86362001)(186003)(7696005)(6506007)(66946007)(66476007)(66446008)(64756008)(71200400001)(5660300002)(76116006)(26005)(53546011)(66556008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qEC2NM3tC/W8GqKS1nyRRhQUfiXF/mqskPnbYJgmYUP28XrLN4KpWf+tvNspSz7JcCIsz2HNRe5wRozBh1r+YQUZuFyvQUGRPNKKM7Xg+4oVgk3WuP4HUahIBeylddGcq6W4yjcNBWpRFCNKhvGbjp/e2s7fWRr37smsFusj/AHu8uYhak6eXItqseYzoX7IGqex+8mY/J++B97FgiuJlsz0+FBAmx2IktgqrBSUqUtD4X2GNDcWFOeVLvWI8r5kPTF/UNfdqJl+fRPRejgL4ehqWzIv1NaSL2Bz1uDrsZ0Do2cwrW798cq8EaUSkvvMmhUiM2l324twV7oKMLO8k9JipEk0bWwleXmg3lcLX0FMdbMG2wd7KZ1DaModfmY7G6oqb99g1FsfNzgFpn6QG5zJMloQcUDoXZCYsQPfh8x9WTPKfP/NYjPYPkKLNJQrghkz2ZeYvs/t+iEH1Q/klxDGGePcjsDlAL4vQ4G6gEuyN4rRv3HXoU17v3TxGvypwQFzM3+++lbhY9ZjvO/9YA==
x-ms-exchange-antispam-messagedata: E+2m4b1vdiBkxbhHVufJDytNc8VUlaCjqw3QmJ1jZJw6qlyNUujbGS6g6VUhod0MttgG+uPa29LmUPDB+RT66+ak3vNmsdSaG9lXYSE47nwocO/Wh5VNStVAQeFDNQ6auUp+CtJamdZpbJpieFoMcQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2208bfd2-99e7-4826-73dd-08d7e667932a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 02:48:01.9788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Spfd54pZs5WFprxEnbdzMc0Smct9cd0fTupDkVgBiP/unH+YJ/izSPqi+lOBGr9K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mode1 reset is also affected as I confirmed on navi10 unfortunately.
That is why the original design(switch to mode1 reset on audio suspended failure) over our previous discussions was not taken.
Anyway, I sent out a V2 patch to limit this for baco and mode1 reset only.

Regards,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, April 22, 2020 4:18 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu reset

On Tue, Apr 21, 2020 at 8:00 AM Evan Quan <evan.quan@amd.com> wrote:
>
> At default, the autosuspend delay of audio controller is 3S. If the 
> gpu reset is triggered within 3S(after audio controller idle), the 
> audio controller may be unable into suspended state. Then the sudden 
> gpu reset will cause some audio errors. The change here is targeted to 
> resolve this.
>
> However if the audio controller is in use when the gpu reset 
> triggered, this change may be still not enough to put the audio 
> controller into suspend state. Under this case, the gpu reset will 
> still proceed but there will be a warning message printed("failed to 
> suspend display audio").
>
> Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 
> ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d4b78d96426..983e294d0300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -69,6 +69,7 @@
>
>  #include <linux/suspend.h>
>  #include <drm/task_barrier.h>
> +#include <linux/pm_runtime.h>
>
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -4146,6 +4147,49 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
>         mutex_unlock(&adev->lock_reset);  }
>
> +static void amdgpu_device_resume_display_audio(struct amdgpu_device 
> +*adev) {
> +       struct pci_dev *p = NULL;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (p) {
> +               pm_runtime_enable(&(p->dev));
> +               pm_runtime_resume(&(p->dev));
> +       }
> +}
> +
> +static int amdgpu_device_suspend_display_audio(struct amdgpu_device 
> +*adev) {
> +       struct pci_dev *p = NULL;
> +       unsigned long end_jiffies;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (!p)
> +               return -ENODEV;
> +

With mode1 reset affect this or just BACO?  If it's just BACO, we should check the reset method here and return an error if not using BACO.

Alex


> +       /*
> +        * 3S is the audio controller default autosuspend delay setting.
> +        * 4S used here is guaranteed to cover that.
> +        */
> +       end_jiffies = msecs_to_jiffies(4000) + jiffies;
> +       while (!pm_runtime_status_suspended(&(p->dev))) {
> +               if (!pm_runtime_suspend(&(p->dev)))
> +                       break;
> +
> +               if (time_after(jiffies, end_jiffies)) {
> +                       dev_warn(adev->dev, "failed to suspend display audio\n");
> +                       /* TODO: abort the succeeding gpu reset? */
> +                       return -ETIMEDOUT;
> +               }
> +       }
> +
> +       pm_runtime_disable(&(p->dev));
> +
> +       return 0;
> +}
> +
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> @@ -4170,6 +4214,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>         bool use_baco =
>                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
>                 true : false;
> +       bool audio_suspended = false;
>
>         /*
>          * Flush RAM to disk so that after reboot @@ -4227,6 +4272,19 
> @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                         return 0;
>                 }
>
> +               /*
> +                * Try to put the audio codec into suspend state
> +                * before gpu reset started.
> +                *
> +                * Due to the power domain of the graphics device
> +                * is shared with AZ power domain. Without this,
> +                * we may change the audio hardware from behind
> +                * the audio driver's back. That will trigger
> +                * some audio codec errors.
> +                */
> +               if (!amdgpu_device_suspend_display_audio(tmp_adev))
> +                       audio_suspended = true;
> +
>                 amdgpu_ras_set_error_query_ready(tmp_adev, false);
>
>                 
> cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
> @@ -4339,6 +4397,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 /*unlock kfd: SRIOV would do it separately */
>                 if (!(in_ras_intr && !use_baco) && !amdgpu_sriov_vf(tmp_adev))
>                         amdgpu_amdkfd_post_reset(tmp_adev);
> +               if (audio_suspended)
> +                       amdgpu_device_resume_display_audio(tmp_adev);
>                 amdgpu_device_unlock_adev(tmp_adev);
>         }
>
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C80f38047896c44b7762308d7e63120f2%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637230971017390822&amp;sdata=K9FOP93vhfOmw
> ZnXIo%2FMiKEWPlvtnV5csCwiZZYmF5M%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
