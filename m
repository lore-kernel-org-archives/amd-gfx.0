Return-Path: <SRS0=g3tc=CE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9681C433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B862078A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IxUQ8sC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B862078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E116E115;
	Wed, 26 Aug 2020 15:31:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD626E115
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2020 15:31:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npj/blxOesLGe5d2sNmri8L8H52gGy4TZJMpSDeu7lzr/tmvAlmrMU5o2WfNMF29Arrrdv61XT15Mt3wgvkpBxPayZi6haff8T5lb8zfr+4XF4dImCeL0is089Nt7P0wO+089efEl3dgQ8iUM/EB5v9PeDqLRytaP/Lrm1gnpE33DA9OnlGdRLJoIPc6podC4aQMXixkHTK/aOuo2qqR6gYgthIH7SkxLngQ1fHecWOpeO68Z5WJ1abKvNlpnsjBKNhgubiiNFS9h+54AQEIgf8a1WLhONU3SqgCInQp8VQ26LGR2kw97d5kd1SYzHodDBYZJicpkF2+4Uz7AgkJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDNdzy6GQ9PxJeaRuqn6hdZv4cWtTVMplkdoV2gt7rk=;
 b=HHuZ4HPz3Q2jGYwmOrJTWMEoTDsat9tVcty5KZsOdifMxIysnmMIWIv+mJtLh8FZq8vGvnVejtGt5FUzPVDiZt8wys6Xc1G9co2GiUmcIdnQSGy/EFXxJ29tLyKaLFF2kXW6U+VUBj9qnn4rNQDh0ZtRM10Hsj0qUgs+Zr2q19LdJMxxgGt1Hq+2/XgUWrTkLg/jcjnfUlzqgbVoET/tZ32wlBfWRe7tsRqDidHNs2b7D/It60nCevVbGUsJSDlIVM3iedG32Fx9S8G6IO8yxZg/b1PwLhTh8WZ+8732O2PAERXtur44fpPqZV8p03Etp5TF8xKmJyDkxUEFKvlh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDNdzy6GQ9PxJeaRuqn6hdZv4cWtTVMplkdoV2gt7rk=;
 b=IxUQ8sC8FsrsS5Sawva9/EB6OuhOS4NJndpFWkNDr6xdj5n3K1ywvlVR2A0aXZPxji5g4ZIBw7Dc1OkrUlda2voN/sr/R/cJ0ywUkkpqb9eHrf4QCZf2YYj6lsUk7wMJZ+Hhirh4UHmIwTIR0ooaM/j2VpNCdeKqfFi6pile1As=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 15:31:23 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 15:31:23 +0000
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: Alex Deucher <alexdeucher@gmail.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <52f3e0d5-285b-5d1e-2f34-63e49a681c67@amd.com>
Date: Wed, 26 Aug 2020 11:31:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:404:f7::19) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR11CA0057.namprd11.prod.outlook.com (2603:10b6:404:f7::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 15:31:22 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:7cba:e05f:9981:25cd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9956bc0c-c2f1-4c40-f8f1-08d849d516d4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB244075F055C94E5ECDA65979EA540@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+lTWxAVgwYh+WBQJTYQv+R2UdGF5h4VdjKXpISzoyvYBtWeTm2lNDH0WZ2kpl7EeaCqWnlbXHz3BIz5eASOZsqSN6VT354WDyyZANsknSMNafOR7yVCh71veD2ZqAxodRX7WDLseXHuAU36ua9T8Tn7GZaoz/Xrv/4NBL9ze44Wz9y2UagI3WhXBPAbQLeR4e3/NyzbWI+p9O2Avl1dqI0laz/7jgQfW1BsSS4AySMG5cBsENWZNdGVmZXkzL2aMqQUTYMi93zSNptILvXSjOO0sV+hZx10Mr6peFIWd5jbUzSP1UZiY8KeRr4PBkXH0+DQYJHyu3mX/0Z8lfwiHFF42xZBzjjz/f+ArQKavKkezRV5TLPC5bekqWbvfWCpRODN5RlDFkxGVVU9124MgDs1XjzekdGHvnpZE9fhsbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(2616005)(54906003)(16576012)(6916009)(6486002)(8936002)(83380400001)(8676002)(956004)(2906002)(6666004)(31696002)(86362001)(53546011)(45080400002)(186003)(31686004)(4326008)(478600001)(5660300002)(316002)(66556008)(66476007)(66946007)(52116002)(966005)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bIwKTaGLwrCjSr0hPvtPVMc7EcZfKq2p2XLMeFCdMfXzLJJzp9SRxhpujxyPB8HVzlLuQg4eA6oS8M7tCnZepo1LeGAC6svCnGsilNTUnksAKvr/2AB37wNQkedn1mEwELuP/2CrtwKt9Zmv56PbBu+eZFi0arCJTaJZVOUsiMdKsXDRFsfpBnrpDazKUVqXxMpWBoR2qk5MsWTSWPyIcneuF8YIXullEI6UZ8QjjtKSWcnPYZj497K8zpQqzEFmUQ9P8C/RZor/EMY91vtv+YUXI0oRHfdWPKR64sfTi/U1itdsCgxh58qcp4l/R55V3g65SpYfhWbWRR47h10v0VwjSltGHwbY6J4bHLbPYYAKjfr4oOqr63Mi0G2JZD0mRVnznQR44mRHlcDEWWVx81s5+DKLJQm00NNHjenk8/P2JXjpcBvlpBTtbEOBxrH68abiRydrVni4dybUFMeKuEyZzkStkysCVZOJy9Xu/kf9rN1YnHyxs7eNB+JVtXCmTGYKAWaQ2+d8VZjvgKwCDwahAzucNfnw/ice6tO7lcD8kaF9e82b3/d41eLvM3/T3PYJB+2JtSNeyRNetCkiEGvHUL/SuQ6CEo7fokJF1q+R+4B0CIMzd6mIA+fMCgMregqEFDkedlV2dUHupYN5mWdIbtKW36vZqx3BF9RDu9IWIBg8McBz1ZLkNM0Mk0n5ZYeO8qeAegMGZD1+U8/lPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9956bc0c-c2f1-4c40-f8f1-08d849d516d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 15:31:23.5471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFaeRngb00pUGX6bduPSUdKz8UPLu8pOKQ51hxCLbP26TKBkQ/oTwm0zUhYwiS233xwe/6prIzxrAOT7R4mz7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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


On 8/26/20 11:20 AM, Alex Deucher wrote:
> On Wed, Aug 26, 2020 at 10:46 AM Andrey Grodzovsky
> <andrey.grodzovsky@amd.com> wrote:
>> DPC recovery after prev. DPC recovery or after prev. MODE1 reset fails
>> unles you save the cashe the saved PCI confspace to load it after
>> each new reset.
>> Also use same cached state for other use case of restoring PCI confspace
>> such as GPU mode1 or VGA switheroo.
>>
> We don't want to keep the saved state around in the pci core
> otherwise, the pci core will assume we are managing the saved state
> for suspend and resume.


Are you talking about all the references to pci_dev->state_saved in pci-driver.c ?

Andrey


> I think we want logic like this:
>
> At driver load time:
> pci_save_state(pdev);
> adev->pci_state = pci_store_saved_state(pdev);
> pci_restore_state(adev->pdev);
>
> then in the case of dpc, do:
> pci_load_saved_state(pdev, adev->pci_state);
>
> For all the other cases, just leave the code as is.
>
> Alex
>
>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/nv.c            |  4 +-
>>   drivers/gpu/drm/amd/amdgpu/soc15.c         |  4 +-
>>   5 files changed, 66 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 3489622..42ee208 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -992,7 +992,9 @@ struct amdgpu_device {
>>          atomic_t                        throttling_logging_enabled;
>>          struct ratelimit_state          throttling_logging_rs;
>>          uint32_t                        ras_features;
>> +
> Unrelated whitespace changes.
>
>>          bool                            in_dpc;
>> +       struct pci_saved_state          *pci_state;
>>   };
>>
>>   static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
>> @@ -1272,6 +1274,10 @@ pci_ers_result_t amdgpu_pci_mmio_enabled(struct pci_dev *pdev);
>>   pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev);
>>   void amdgpu_pci_resume(struct pci_dev *pdev);
>>
>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev);
>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev);
>> +
>> +
>>
>>   #include "amdgpu_object.h"
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index d9e3994..2c088df 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -1283,7 +1283,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>
>>                  pci_set_power_state(dev->pdev, PCI_D0);
>> -               pci_restore_state(dev->pdev);
>> +               amdgpu_device_load_pci_state(dev->pdev);
>>                  r = pci_enable_device(dev->pdev);
>>                  if (r)
>>                          DRM_WARN("pci_enable_device failed (%d)\n", r);
>> @@ -1296,7 +1296,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
>>                  drm_kms_helper_poll_disable(dev);
>>                  dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>>                  amdgpu_device_suspend(dev, true);
>> -               pci_save_state(dev->pdev);
>> +               amdgpu_device_cache_pci_state(dev->pdev);
>>                  /* Shut down the device */
>>                  pci_disable_device(dev->pdev);
>>                  pci_set_power_state(dev->pdev, PCI_D3cold);
>> @@ -3401,8 +3401,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>          if (r)
>>                  dev_err(adev->dev, "amdgpu_pmu_init failed\n");
>>
>> -       if (pci_save_state(pdev))
>> -               DRM_ERROR("Failed to save PCI state!!\n");
>> +       /* Have stored pci confspace at hand for restore in sudden PCI error */
>> +       if (!amdgpu_device_cache_pci_state(adev->pdev))
>> +               DRM_WARN("Failed to cache PCI state!");
>>
>>          return 0;
>>
>> @@ -3430,6 +3431,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>>          flush_delayed_work(&adev->delayed_init_work);
>>          adev->shutdown = true;
>>
>> +       kfree(adev->pci_state);
>> +
>>          /* make sure IB test finished before entering exclusive mode
>>           * to avoid preemption on IB test
>>           * */
>> @@ -4855,7 +4858,7 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>          /* wait for asic to come out of reset */
>>          msleep(500);
>>
>> -       pci_restore_state(pdev);
>> +       amdgpu_device_load_pci_state(pdev);
>>
>>          /* confirm  ASIC came out of reset */
>>          for (i = 0; i < adev->usec_timeout; i++) {
>> @@ -4934,8 +4937,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>>
>>   out:
>>
>> -       if (!r)
>> +       if (!r) {
>> +               amdgpu_device_cache_pci_state(adev->pdev);
>>                  DRM_INFO("PCIe error recovery succeeded\n");
>> +       }
>>          else {
>>                  DRM_ERROR("PCIe error recovery failed, err:%d", r);
>>                  amdgpu_device_unlock_adev(adev);
>> @@ -4974,3 +4979,46 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>>
>>          amdgpu_device_unlock_adev(adev);
>>   }
>> +
>> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>> +       int r;
>> +
>> +       r = pci_save_state(pdev);
>> +       if (!r) {
>> +               kfree(adev->pci_state);
>> +
>> +               adev->pci_state = pci_store_saved_state(pdev);
>> +
>> +               if (!adev->pci_state) {
>> +                       DRM_ERROR("Failed to store PCI saved state");
>> +                       return false;
>> +               }
>> +       } else {
>> +               DRM_WARN("Failed to save PCI state, err:%d\n", r);
>> +               return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
>> +{
>> +       struct drm_device *dev = pci_get_drvdata(pdev);
>> +       struct amdgpu_device *adev = drm_to_adev(dev);
>> +       int r;
>> +
>> +       if (!adev->pci_state)
>> +               return false;
>> +
>> +       r = pci_load_saved_state(pdev, adev->pci_state);
>> +
>> +       if (!r) {
>> +               pci_restore_state(pdev);
>> +       } else {
>> +               DRM_WARN("Failed to load PCI state, err:%d\n", r);
>> +               return false;
>> +       }
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 4bbcc70..7a6482a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1320,7 +1320,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>                  if (amdgpu_is_atpx_hybrid()) {
>>                          pci_ignore_hotplug(pdev);
>>                  } else {
>> -                       pci_save_state(pdev);
>> +                       amdgpu_device_cache_pci_state(pdev);
>>                          pci_disable_device(pdev);
>>                          pci_ignore_hotplug(pdev);
>>                          pci_set_power_state(pdev, PCI_D3cold);
>> @@ -1353,7 +1353,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>                          pci_set_master(pdev);
>>                  } else {
>>                          pci_set_power_state(pdev, PCI_D0);
>> -                       pci_restore_state(pdev);
>> +                       amdgpu_device_load_pci_state(pdev);
>>                          ret = pci_enable_device(pdev);
>>                          if (ret)
>>                                  return ret;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
>> index 4d14023..0ec6603 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -311,7 +311,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>>          /* disable BM */
>>          pci_clear_master(adev->pdev);
>>
>> -       pci_save_state(adev->pdev);
>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>
>>          if (amdgpu_dpm_is_mode1_reset_supported(adev)) {
>>                  dev_info(adev->dev, "GPU smu mode1 reset\n");
>> @@ -323,7 +323,7 @@ static int nv_asic_mode1_reset(struct amdgpu_device *adev)
>>
>>          if (ret)
>>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
>> -       pci_restore_state(adev->pdev);
>> +       amdgpu_device_load_pci_state(adev->pdev);
>>
>>          /* wait for asic to come out of reset */
>>          for (i = 0; i < adev->usec_timeout; i++) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index 2f93c47..ddd55e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -484,13 +484,13 @@ static int soc15_asic_mode1_reset(struct amdgpu_device *adev)
>>          /* disable BM */
>>          pci_clear_master(adev->pdev);
>>
>> -       pci_save_state(adev->pdev);
>> +       amdgpu_device_cache_pci_state(adev->pdev);
>>
>>          ret = psp_gpu_reset(adev);
>>          if (ret)
>>                  dev_err(adev->dev, "GPU mode1 reset failed\n");
>>
>> -       pci_restore_state(adev->pdev);
>> +       amdgpu_device_load_pci_state(adev->pdev);
>>
>>          /* wait for asic to come out of reset */
>>          for (i = 0; i < adev->usec_timeout; i++) {
>> --
>> 2.7.4
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C5faaaf11d6024193cb2508d849d38fae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637340520282366646&amp;sdata=ziPLmwT95XAnKftzplY2QBHq%2BL1961d0SdaMPAlVMcE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
