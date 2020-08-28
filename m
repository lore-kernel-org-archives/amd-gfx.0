Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C842C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484E2208CA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 14:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GhWQaRwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484E2208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3BF6E4C1;
	Fri, 28 Aug 2020 14:21:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035D66E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 14:21:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7CjG8Q0J//XVAUzCmltYAtGw7IowZY/8COme0pvl6Wpjzr9jRbpbv3pg5VdjCQdpngigTVRXbEF3NlhviRBy7ZIZkIQf4OoLSVwv/qKWKQFC4qKRzvpPygy2JkbSdPXsaeZLz5jr0fhKAj+wAhHYKrIkXI4UEmWhCjp82M3jlh9nEWpdpkh+jBn4okHf2wqB6w9mp6IXJ9ftvFY8TrgJBA0N8vOsTNO3lij6IAw0bfXorEUyOA0B9hJPteaXq2pp+aHbDhAlU9zndEHMvSvoNelSEJrwCZPq7yxIn7b6f4kqRik+Rv6acCBsCxdsBOZbXpPHRpZAK4Rzm8vJupxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHUSVWlmz4Fh5VKzjlNCjSxUd4TBRyQcifjIAWu6pDM=;
 b=lVlfLE6n8tjALKLTWUe+AT6Eq6zaz2Lb3SBox5aRDtLGuzgxolzcvU9VPOVdb9JUEmR4naqAxfX+Zy6QUvq7D1V9cAY0+VSLjPRHVV3avV+65TCrcODYYJr6ERr5eEFWM/Fz0gHMXkXYBf2nTkKm2IYUP8OfTZuikxKbvd829ZAgGD0kjwPXNL3k+d2EvHESxzLarDXsN2leqVja8Q4deZ2Zu/w92XsttMZPLPN43xfTSS1XUMeTqgvs0yCnKhQlhNawjbbSJ86loy8zw9yVceJfxFIdrFESnxKPUyu7Vsimd2MQ7K9TStRpZjQwOV6M0U5CrDpzjPD/9RieIDWWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHUSVWlmz4Fh5VKzjlNCjSxUd4TBRyQcifjIAWu6pDM=;
 b=GhWQaRwd34LnaYHhFtXQSFj3fa1XIOeF1NFUMe6oEH4B9jGm9PUx8I5QnlG89l0R2nKh3HF7JMIu/eAIz61Mi/loFvePONC9Oel+09EvxKPAHj521d28RIuZ4UD3srMyGBeQ1GAd8ZZ2Ebi889gHNWzGj1Z3bQiXcrUqpimZUwY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.21; Fri, 28 Aug 2020 14:21:11 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 14:21:11 +0000
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: Alex Deucher <alexdeucher@gmail.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
 <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
 <CADnq5_MJEsSp1UKXDf-1saNTKV_i3E6vtnMCgGesAz=Resk78Q@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <45fdf263-69f7-1c9e-770b-8adaf8574c26@amd.com>
Date: Fri, 28 Aug 2020 10:21:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_MJEsSp1UKXDf-1saNTKV_i3E6vtnMCgGesAz=Resk78Q@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::31) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YTXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Fri, 28 Aug 2020 14:21:10 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:a840:fdae:31dc:3ab6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cfc1d7a1-cda0-4f71-d9d6-08d84b5d9ce5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24399118F35CA523C71BF07CEA520@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sue9zEYrs/H8yBXJrUfVJQ2c7Mkk/nSQjKlBY3V9paEuIXLsbUCUrYrlfBvpzB+m/qI+iSZdt1JzQAI0dO2HkpkjUMSKAYLa9/c5m9hy/Jw2EUFETXXc86hcyO2Rk1UaUqufkLDhQiXggBUMVYCX3QSZl9X/6GTBcryi/ymfb+L0ffmbZiUKFycr3Ia1C6HGhnVWZDOwbqGQX36NHcxJdkI2LSUDmsjAVR++BB8hy7MlIRHKMMo5bI/y33vlsUz9Bveqb/MSR+4zsSDXASeYYrlKUPoekcR5rGhufmkN2zRSbHBa3XkL43l+nExcJVVe1DZrrZoa+3ffkLqCR0fUJZk/lqwEN+0SwYnWRlWbwTUacWBS4ttyd4iRqxal5Xf3v85MoEqtkzQ3aD68sFHYEE3f2LMoG2x4oF9fL5zGQ+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(6916009)(4326008)(8676002)(30864003)(54906003)(956004)(45080400002)(16576012)(2616005)(316002)(966005)(478600001)(5660300002)(8936002)(2906002)(52116002)(66476007)(86362001)(66556008)(36756003)(31686004)(31696002)(53546011)(6486002)(186003)(83380400001)(66946007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sRtwA6jCW5J4H8bigJgjdxSNnNGE/+p75bKSpE7cIDQ5Cfbc5yyotZl2izwfcPFtwUmLTbxFEqQGdjGpU3JNy8I+U4tH36PWQaMRNzSOTRd+7ds3rL4lhcZ7JbjjEo7aAy3JKO6KyYIhZhhK6g1HjUmeLLmTnL2DjTpf/+RPNZS2yJBztmNOJl+n9ATIo044YR+WIiDicXMTT8X123DHmVLh/19L1fkUK3PBNrWw2pjlXlyk5PhA456q/jKqYxE6vN/maSrIsZrb49+etgTicv85lqfBmlCZZZnj+JMZxVJVRLYG7HUD8l/TtxOtfr09hUgFoZatt0FOe+/anpJ6El+AUsJsiG0vK2SlUeAB/8a8iPE0+vgDahKIUsD+QjYm3hipWTL2m2b28BWXjEo605zDj/aocKeMl3B+hmgS6ehw8fg/Gk9oIBe63r8zUgFKD0hGFg3Ku/4dkoVgTEKKQkAXHl+vyxCtvGuN3mC2hRjAvBStifGI7JtRSIXAtIErer8nbLvvovIfKb6TIIa4g+PAAw8CXtGiedHgyqF2p7dxnu+t2U8IOacdq2mpCXiIuG/Sjaet7JkEjoOwV60fDt/FK5Cb4PNZgoJ+EfCSFgJphkO6uU/OtU4Y5ovAq9UrwKfA5HgTmCc0Jz62+kGuSJZR7gVDDoaW4L2U2ow2hnTjVCiPHxkLG3ouG4/0g9IvEQysAteqJEtkF1cl1/GeEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc1d7a1-cda0-4f71-d9d6-08d84b5d9ce5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 14:21:11.1595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74PBz0d/JjQ3HnDbs2HLrsWmio3bc1VuakXkh4VR31Fwa8lGELKEc3lmw7AGUVQWpKlqi3XhJdoXSG+Vyhp2Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 8/28/20 10:13 AM, Alex Deucher wrote:
> On Thu, Aug 27, 2020 at 10:54 AM Andrey Grodzovsky
> <Andrey.Grodzovsky@amd.com> wrote:
>>
>> On 8/26/20 11:20 AM, Alex Deucher wrote:
>>> On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
>>> <andrey.grodzovsky@amd.com> wrote:
>>>> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
>>>> unles you save the cashe the saved PCI confspace to load it after
>>>> each new reset.
>>>> Also use same cached state for other use case of restoring PCI confspace
>>>> such as GPU mode1 or VGA switheroo.
>>>>
>>> We don't want to keep the saved state around in the pci core
>>> otherwise, the pci core will assume we are managing the saved state
>>> for suspend and resume.  I think we want logic like this:
>>>
>>> At driver load time:
>>> pci_save_state(pdev);
>>> adev->pci_state = pci_store_saved_state(pdev);
>>> pci_restore_state(adev->pdev);
>>>
>>> then in the case of dpc, do:
>>> pci_load_saved_state(pdev, adev->pci_state);
>>>
>>> For all the other cases, just leave the code as is.
>>
>> Actually, as we already discussed - caching the PCI confspace only once on boot
>> and not doing it again after each subsequent
>> controlled or spontaneous reset runs the risk of loading back outdated confspace
>> settings. I am not sure if and when but, is it indeed
>> possible we make changes to PCI confspace registers during runtime and so the
>> cached state from boot might be outdated
>> to load back ?
> As Christain noted we may change config space at load time if we
> resize the BAR.  So we should probably save config space at the end of
> the driver load init sequence.  This saved state is just a backup in
> case something kills pci config space without saving it.  I think it's
> fine to update the cached copy whenever we call pci_save_state(), but
> what we don't want to do is call pci_save_state() at init time without
> calling pci_restore_state().  pci_save_state() caches a copy of the
> save state in the pdev structure.  The pci core uses the presence of
> this cached state to make decisions about whether the driver or the
> core should handle a bunch of stuff at suspend/resume.  If the cached
> state is present, it assumes the driver will be handling all of the
> pci related state management for power management.  I'd rather keep
> that in the core.  I think the patch is good, but this part needs to
> be reworked:


In this case I believe the patch should stay as is with the only change at
adding pci_restore_state(pdev) in amdgpu_device_cache_pci_state after the call
to pci_store_saved_state - right ?

Andrey


>
> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          if (r)
>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> -       if (pci_save_state(pdev))
> -               DRM_ERROR("Failed to save PCI state!!\n");
> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> +               DRM_WARN("Failed to cache PCI state!");
>
> Something like this:
>
> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          if (r)
>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>
> -       if (pci_save_state(pdev))
> -               DRM_ERROR("Failed to save PCI state!!\n");
> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
> +               DRM_WARN("Failed to cache PCI state!");
> +       if (!amdgpu_device_load_pci_state(adev->pdev))
> +               DRM_WARN("Failed to restore PCI state!");
>
> This way we have a cached copy in the driver but not in the pci core.
>
>
> Alex
>
>
>> Andrey
>>
>>
>>> Alex
>>>
>>>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++++++++++++++++++---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>>>>    drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>>>>    drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>>>>    5 files changed, 66 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index 3489622..42ee208 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -992,7 +992,9 @@ struct amdgpu_device {
>>>>           atomic_t                        throttling_logging_enabled;
>>>>           struct ratelimit_state          throttling_logging_rs;
>>>>           uint32_t                        ras_features;
>>>> +
>>> Unrelated whitespace changes.
>>>
>>>>           bool                            in_dpc;
>>>> +       struct pci_saved_state          *pci_state;
>>>>    };
>>>>
>>>>    static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>>>> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>>>>    pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>>>>    void amdgpu_pci_resume(struct pci_dev *pdev);
>>>>
>>>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
>>>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
>>>> +
>>>> +
>>>>
>>>>    #include "amdgpu_object.h"
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index d9e3994..2c088df 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>>>>                   dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>>>
>>>>                   pci_set_power_state(dev->pdev, PCI_D0);
>>>> -               pci_restore_state(dev->pdev);
>>>> +               amdgpu_device_load_pci_state(dev->pdev);
>>>>                   r = pci_enable_device(dev->pdev);
>>>>                   if (r)
>>>>                           DRM_WARN("pci_enable_device failed (%d)\n", r);
>>>> @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>>>>                   drm_kms_helper_poll_disable(dev);
>>>>                   dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>>>                   amdgpu_device_suspend(dev, true);
>>>> -               pci_save_state(dev->pdev);
>>>> +               amdgpu_device_cache_pci_state(dev->pdev);
>>>>                   /* Shut down the device */
>>>>                   pci_disable_device(dev->pdev);
>>>>                   pci_set_power_state(dev->pdev, PCI_D3cold);
>>>> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>           if (r)
>>>>                   dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>>>>
>>>> -       if (pci_save_state(pdev))
>>>> -               DRM_ERROR("Failed to save PCI state!!\n");
>>>> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
>>>> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
>>>> +               DRM_WARN("Failed to cache PCI state!");
>>>>
>>>>           return 0;
>>>>
>>>> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>>>>           flush_delayed_work(&adev->delayed_init_work);
>>>>           adev->shutdown = true;
>>>>
>>>> +       kfree(adev->pci_state);
>>>> +
>>>>           /* make sure IB test finished before entering exclusive mode
>>>>            * to avoid preemption on IB test
>>>>            * */
>>>> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>           /* wait for asic to come out of reset */
>>>>           msleep(500);
>>>>
>>>> -       pci_restore_state(pdev);
>>>> +       amdgpu_device_load_pci_state(pdev);
>>>>
>>>>           /* confirm  ASIC came out of reset */
>>>>           for (i = 0; i < adev->usec_timeout; i++) {
>>>> @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>>>
>>>>    out:
>>>>
>>>> -       if (!r)
>>>> +       if (!r) {
>>>> +               amdgpu_device_cache_pci_state(adev->pdev);
>>>>                   DRM_INFO("PCIe error recovery succeeded\n");
>>>> +       }
>>>>           else {
>>>>                   DRM_ERROR("PCIe error recovery failed, err:%d", r);
>>>>                   amdgpu_device_unlock_adev(adev);
>>>> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>>>>
>>>>           amdgpu_device_unlock_adev(adev);
>>>>    }
>>>> +
>>>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>>>> +{
>>>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +       int r;
>>>> +
>>>> +       r = pci_save_state(pdev);
>>>> +       if (!r) {
>>>> +               kfree(adev->pci_state);
>>>> +
>>>> +               adev->pci_state = pci_store_saved_state(pdev);
>>>> +
>>>> +               if (!adev->pci_state) {
>>>> +                       DRM_ERROR("Failed to store PCI saved state");
>>>> +                       return false;
>>>> +               }
>>>> +       } else {
>>>> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
>>>> +               return false;
>>>> +       }
>>>> +
>>>> +       return true;
>>>> +}
>>>> +
>>>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
>>>> +{
>>>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>>>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>>>> +       int r;
>>>> +
>>>> +       if (!adev->pci_state)
>>>> +               return false;
>>>> +
>>>> +       r = pci_load_saved_state(pdev, adev->pci_state);
>>>> +
>>>> +       if (!r) {
>>>> +               pci_restore_state(pdev);
>>>> +       } else {
>>>> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
>>>> +               return false;
>>>> +       }
>>>> +}
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 4bbcc70..7a6482a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>>>                   if (amdgpu_is_atpx_hybrid()) {
>>>>                           pci_ignore_hotplug(pdev);
>>>>                   } else {
>>>> -                       pci_save_state(pdev);
>>>> +                       amdgpu_device_cache_pci_state(pdev);
>>>>                           pci_disable_device(pdev);
>>>>                           pci_ignore_hotplug(pdev);
>>>>                           pci_set_power_state(pdev, PCI_D3cold);
>>>> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>>>                           pci_set_master(pdev);
>>>>                   } else {
>>>>                           pci_set_power_state(pdev, PCI_D0);
>>>> -                       pci_restore_state(pdev);
>>>> +                       amdgpu_device_load_pci_state(pdev);
>>>>                           ret = pci_enable_device(pdev);
>>>>                           if (ret)
>>>>                                   return ret;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> index 4d14023..0ec6603 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>>>> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>>>>           /* disable BM */
>>>>           pci_clear_master(adev->pdev);
>>>>
>>>> -       pci_save_state(adev->pdev);
>>>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>>>
>>>>           if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>>>>                   dev_info(adev->dev, "GPU smu mode1 reset\n");
>>>> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>>>>
>>>>           if (ret)
>>>>                   dev_err(adev->dev, "GPU mode1 reset failed\n");
>>>> -       pci_restore_state(adev->pdev);
>>>> +       amdgpu_device_load_pci_state(adev->pdev);
>>>>
>>>>           /* wait for asic to come out of reset */
>>>>           for (i = 0; i < adev->usec_timeout; i++) {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> index 2f93c47..ddd55e3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
>>>>           /* disable BM */
>>>>           pci_clear_master(adev->pdev);
>>>>
>>>> -       pci_save_state(adev->pdev);
>>>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>>>
>>>>           ret = psp_gpu_reset(adev);
>>>>           if (ret)
>>>>                   dev_err(adev->dev, "GPU mode1 reset failed\n");
>>>>
>>>> -       pci_restore_state(adev->pdev);
>>>> +       amdgpu_device_load_pci_state(adev->pdev);
>>>>
>>>>           /* wait for asic to come out of reset */
>>>>           for (i = 0; i < adev->usec_timeout; i++) {
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CAndrey.Grodzovsky%40amd.com%7C3d5f35b27c9c4055150908d84b5c81cb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637342207973407357&amp;sdata=qA1xTpuY1JtOTPf7m1WhpH%2BFqVv8GA5CDMu%2BJa3Ds4o%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
