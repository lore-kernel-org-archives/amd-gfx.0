Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD9C83004
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 04:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A7F2051A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 04:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hhhQk6wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A7F2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ED76E2A3;
	Tue, 28 Apr 2020 04:09:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62DF76E2A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 04:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE6/zWYO/RuyGEbeR6JcdV/WfTSDtcp7x5ss7bBV//0pm46k6bis4QgfiMn2X3GqnvD24a5DYfFwKrYLxSnC5ONxUSBDo/0sPtwhJRiRhCbh9HZ1Av2OHUpUFEg1uY37q1tTMsmwEwV2+msZi69adnq+imehJHnCVNM7Qi/T8Zz2ZGj1dw1XFAvNmwPeF1KsoUmohpNDQl94Ofw1qcqCCPo4OPuq+U74joSMLKBPOTlCMc09NFUB1WYFzd1ODhSLw/3SllqESCm81+a0AIbD9bCSDIsZA0TfEkkTFTReM6NyWXd9VkCeKeTWEca7dFW4blTmh9jL6A0b1F1s5vsIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOd/I29PLZKG/iAXJjMPLAeuxjUqI649arWSl3cRDy8=;
 b=UmRknEqTM0UkK+HAnlLRJO0DuUOpCajYUpcETvE8aMaN8i2mXtm4rJleMphBGOZ8InUbjT8tVabpdRB0L/qzd2DLVsWfGlYdxfcEIRvLHp3aC1hz7kRcm6a+12t1i+GCKWedrmsIQyPM/oKG2CUUG5kgmSHEVbqaAXAiCvuiTE9OvWljZOwY2uBSND8J6X2UZkSC0sNB10QsEig6RM25CI0JtZPCY5TYqyQ/EWOLKT97BKd7BLez7e5zFA8UsIelGzoPtZuPzrU8EGfSW2dF5i7F37Yapiyn3Y7dK5E87xk5KTzFpGBKoriz/uFL2DpruJzz71CSiFVAX3gsJmby8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOd/I29PLZKG/iAXJjMPLAeuxjUqI649arWSl3cRDy8=;
 b=hhhQk6wddjfScwBCulzfUA3srLRpMhr7VtK5GqL4o2VpKnT/4Cvjubaf966jhG5WFvYMf9HC4gNQy8LZr/r2R5JRwjsjy+GXqC2nRin/MbIBOo14+tcNyFOA++FPiZOfn0UNpmglISPjjKV9A//Fm6Nqq1CQQpGuY8gJbjPTRLM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13; Tue, 28 Apr 2020 04:08:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 04:08:58 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: put the audio codec into suspend state before
 gpu reset V2
Thread-Topic: [PATCH] drm/amdgpu: put the audio codec into suspend state
 before gpu reset V2
Thread-Index: AQHWGE+x7L6exlVURE6f9XdPAsy3xqiFJQ+AgAjM4GA=
Date: Tue, 28 Apr 2020 04:08:58 +0000
Message-ID: <DM6PR12MB26194747FAC0B96B60CF285CE4AC0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200422024221.16914-1-evan.quan@amd.com>
 <CADnq5_O8bNkDnUYYn=nAOOq+0qZUMgZgM2ZeCE4BWA2NWQ_Fdg@mail.gmail.com>
In-Reply-To: <CADnq5_O8bNkDnUYYn=nAOOq+0qZUMgZgM2ZeCE4BWA2NWQ_Fdg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d63696c-eabb-47ee-8569-00000f243285;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-28T03:58:32Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3caff968-f99d-40cc-0ae3-08d7eb29e028
x-ms-traffictypediagnostic: DM6PR12MB4433:|DM6PR12MB4433:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4433E1F09A637A6D7E734C1FE4AC0@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(15650500001)(8936002)(7696005)(33656002)(71200400001)(66476007)(5660300002)(6506007)(66446008)(45080400002)(66946007)(6916009)(64756008)(53546011)(4326008)(66556008)(52536014)(76116006)(478600001)(8676002)(81156014)(2906002)(55016002)(86362001)(9686003)(316002)(26005)(186003)(54906003)(83080400001)(966005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7Bt63+eU8FDn2z8L9s1M3p1DIQdu73YoS8HfGu5ZXFpLD9IwjxAOXMpeLkEVFjo5wgkyHrbuucGG0r/G6YLbBpR8pcFMFm4/S+MfEpNh1FpWoBX/qspT9gwjDaX+fTPa8SQVAhOsyEJSegGNqiSHEFs3F27SAF35lha9VyjqScJ0OlYEjqXZUO3O0/c0zvNtil+/TFLCf0XfN5rqtchiZDvZX+AdfRv43zmK4eRn5zhY25DdGSG8xVDGB1g8DSuyB177MtfrqxTD6/jHnWKr40H6IRHy56dSHIgVg/vV/f8eV/orXuvSEW+wG76hrPBQF2ACT6Dw81PuOUMumB7CVyTN3BV2uaqlRondPqNG8GhskNMw3jstf1T30yZZ9k8s6CQkGm5vNan2jz65gJkqCYRqJIFiA7EzH9HHJRx1fAs40k+92Mk7MVmGf3WyQH9PD1/tlqAwpxvoVxHtcLuxCe/Ww6gB+4ElFMwxddOVqDljuhO0cBBy/lHLvJkO7sRwlNAQ3+rK2OQykh6cbDhRA==
x-ms-exchange-antispam-messagedata: PZqgM3qcn449U62n3cYDAI1StUWBpJ81Lk6LufC5aVadmmI3Zb3J33IVSevrgYnwk1JwyvTIHK/vNZateRbfBPUEBmOaDj/5xMCgE4BCDH4MM3h251/C3MoidWRuiAlAbHGxITKbsQuZiKqUmkRBSl4mHCi3C9w2lluLidDwflROJ0oE8QaTJbgmmgaK0NNsR1R/xQwBwwHnwfOSMnM0+3nyR8of+ZUt7qiw0AZdXVfpsoMH36BvMDajYnhyOCtOzTZq0OfivZvp7Wx4E+8P6oMCIhHZnWeicra7nRoAZAboo0lhyET7dmZG4QvhBWYDO1Io1JnQbnlmJkKAYJi43xkncEPu2h2RXCYqoCquOykdJUizx4QWm10x3ihJ5uXovX1nGG2k21M38+0HAvxK5wAWjYa8BN/fojv35LHGD3x9G+0lcNboAgLwzdBHuBNvXUeRxR9GC/8xR3r3YtWw2TZjuqax0mDByhy5O37IXPt8QhGZK5c4RC+QVTAGmMxaW3W5L/ZDI4tQO2/8UJ+Io6OvO95gVVEyDhEqxPlygAzuKclqejaXCmBwej7wF1+0RLtnLNLFQu9uNMBCa6hiK9DkQ2ywSdQswXSJcssb50Z6pyCOwNS0gz1tvHyq5DiMia0u1Vta8pBLBHpm7V50wmt2emP9ptEBG53C8bnySvXiH1pVejRUAD5ANFjdvKuIsUEXilNLwB1J0Ylp1M9CUk24toOPT2Ksg2q73P6tUmhgrvpAXwbDRYzt7B6Q+Br7boQtpnN0/pfb3B1ot8DmTDo/ELX70xxK/9WGTWJ3caU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3caff968-f99d-40cc-0ae3-08d7eb29e028
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 04:08:58.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olGl0ZOP+M59WZEyZF21rw+m77oSIniuHKbxgo2La6p8XkMSVL2Yw9Uu12PUVZZd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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

Hi Alex,

The pm_runtime_autosuspend_expiration() return 0 due to ->use_autosuspend and autosuspend_delay are all zeros.
This seems not kernel specific. As I can see this on 5.6-drm-next kernel and ubuntu original 5.3.46 kernel.
Any insights why that happened?
And maybe a compromise is: try the pm_runtime_autosuspend_expiration() first. And if failed(report 0), use a fixed interval(3S).

Regards,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, April 22, 2020 9:35 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: put the audio codec into suspend state before gpu reset V2

On Tue, Apr 21, 2020 at 10:42 PM Evan Quan <evan.quan@amd.com> wrote:
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
> V2: limit this for BACO and mode1 reset only
>
> Change-Id: I33d85e6fcad1882eb33f9cde8916d57be8d5a87a
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 70 
> ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2d4b78d96426..70f43b1aed78 100644
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
> @@ -4146,6 +4147,59 @@ static void amdgpu_device_unlock_adev(struct amdgpu_device *adev)
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
> +       enum amd_reset_method reset_method;
> +       struct pci_dev *p = NULL;
> +       unsigned long end_jiffies;
> +
> +       /*
> +        * For now, only BACO and mode1 reset are confirmed
> +        * to suffer the audio issue without proper suspended.
> +        */
> +       reset_method = amdgpu_asic_reset_method(adev);
> +       if ((reset_method != AMD_RESET_METHOD_BACO) &&
> +            (reset_method != AMD_RESET_METHOD_MODE1))
> +               return -EINVAL;
> +
> +       p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +                       adev->pdev->bus->number, 1);
> +       if (!p)
> +               return -ENODEV;
> +
> +       /*
> +        * 3S is the audio controller default autosuspend delay setting.
> +        * 4S used here is guaranteed to cover that.
> +        */

Instead of hardcoding 3S, we should probably use
pm_runtime_autosuspend_expiration() to query how much time is left and then use that.  That way this will work even if userspace has changed the delay.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


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
> @@ -4170,6 +4224,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>         bool use_baco =
>                 (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
>                 true : false;
> +       bool audio_suspended = false;
>
>         /*
>          * Flush RAM to disk so that after reboot @@ -4227,6 +4282,19 
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
> @@ -4339,6 +4407,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
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
> an.quan%40amd.com%7Cf459a830629f4738329808d7e6c201e4%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637231593241762358&amp;sdata=0EEfJPHc%2BEF
> K9Ukvzo20h4K4lL%2F%2FcUOvH0AdYDsha08%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
