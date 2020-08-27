Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838CCC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F5322B4E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MZFXg8H8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F5322B4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D97606E44F;
	Thu, 27 Aug 2020 14:54:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4F706E44F
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 14:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4g5BuQ9+yh+Yh3OUbLF9OhnV0bK7cOYxkMNebJlfry137LpXSs6UAVAs2YSMoxX0I91NBdlx8BD30Vj/acxwHH08yEFLeB8lS689OdBh57Uh5gPG8BYI10UEkLcYY549W1CH/RlG0P0JIhTHPu+VFKhczkhwfeZ+UpD+LZNXPlmLr1Za1wABdfhr7GpQ4Af+XjAAWQNlff0/tf+XPaANOl/NrMN+GENzpdlsEeOhBQOp2RvksQjS+cSuD4k2AkOp2QCmTz7CSHXoj0v4px6f0GbYw6OepGoQQt0+WG9Cf/p+mokS64HfX4nA29/HEa/Pf/mNV4HC82XP9pKl3lPOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHA58JwFh4RJAHCHqjClJH22m1diQCLPPXsbMZj3p3Y=;
 b=Hy+tpJzla/r9PrCE6o7FR+aU2eTaIZHVJ3S8TpEdYRBVtOjvKYtnehM2xSbg9d2C8/hxtGU3VEI61kA8TCJubS03QIIBszB6XbysotmoUmF4Yn1jtbbnB2JSWfZ+7r33K717MltWrhX9ljeEmyMKqVs9EFbjVXjRaKTdCFHKWOlICGUHNGN0Rdt11bTj6f017EV0v3IwVAtLnNZFzDzarf9HehrLBS9+jKhKU5CI34ysX6yWFOvmvBZEMRP54hr+9Vrv0Yvme8rWNpoP2T9XUi0lnm2qv3eZLauwDmLJma2dyWgvHeRPTSxdVoR+KW0Gye6f9Y6t9FfkxnwDL/lKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHA58JwFh4RJAHCHqjClJH22m1diQCLPPXsbMZj3p3Y=;
 b=MZFXg8H8Bk2TsRSLmq7aSGjyOqsgVM+ZgGfwLr4M1oLaSAFURrLL2qL5xz/40PePRIaOnzqbofzb0GhilGxD3j2fv46yLh2i+YFnQXl9t4/7mZsOUITsQOTRkzSScjacugp6WhYDdMVprqR7+rqOcy9YcyqS84V6BvBf6/mHmGQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 27 Aug 2020 14:54:41 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 14:54:41 +0000
Subject: Re: [PATCH 5/7] drm/amdgpu: Fix consecutive DPC recoveries failure.
To: Alex Deucher <alexdeucher@gmail.com>
References: <1598453182-6946-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598453182-6946-6-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <0c2ada8e-5dde-0165-c8b3-cf6d6d3fba46@amd.com>
Date: Thu, 27 Aug 2020 10:54:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <CADnq5_NtAaNd3_XYrs4K8uLFF49Xv-46801Cy3Y0fNuLG_YPoA@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:404:23::27) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 BN6PR03CA0017.namprd03.prod.outlook.com (2603:10b6:404:23::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 14:54:40 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:9563:9d38:d6a:e389]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f40bdc0d-d33e-47df-883a-08d84a9920aa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658AB540D89FD223E99EC28EA550@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b114nZOmfNHYkx1v5Bc3f7DbL+tuiRJfIy2+lnBZ1Grauw2ihwd7G1lZNBTe5SAvrCrOCQQfsvIb7rvDEcPDtCX04lAWfDrmu0AzTlzRGITlKeKGn/wZLh6eeW4JqBew7wgXpApmVvgz3QBBlyz1rfX6MGHm3HF/pPyq/CbUv9blPkoGfWDoQ0AG/b3maSnZjrj6d7gQJcDQRa7bJ3hx5+igp8PL4PTM4+gxMnnC6fgafALK0U9naaw5zvYb+Ou1g3frzFzz/jnS2EYmNhuTgGhVgCdJsou0a8B3zuAuwx+7zsgGw6pSFhbCK0hliDbwiNaZlLQbd5q91Zt065TxdsasaF5QtuHY4GWdKvodjLMViug49ogi2l7rico4fEbK31uuHZXnDOXeg1fBlz102kwppDGnGUMhe0p3uUURJWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(16576012)(956004)(31696002)(316002)(52116002)(36756003)(4326008)(478600001)(6486002)(8676002)(31686004)(2906002)(6666004)(45080400002)(54906003)(86362001)(66556008)(2616005)(66476007)(66946007)(6916009)(83380400001)(8936002)(5660300002)(966005)(53546011)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gEB4FD6LBlM1Eao3Snn6S3xj5TX/iHnZvu+9o9xTX3AhCls7WEpCL6JXTxYQ/m0YgcG2Gb2cRVmBTMN8B3wx27ftTevb9bX0eYkDqMYcVV8w98ivYyIQ4fm4UhcpqIlCsZH0W78luU8qtB6T1Ppp2/uq8ZwM73skPJT8OhVLsNRBokq6sKWhIgXBitNnztPDZbBmJlGlGzatO3oBf02uxBKcKkcAPC4L8iroaWAIYF39XDWWhhU3MU6VREcLRDEvlsOEhFoODTc3rD3kdPZXOCn5jIYZjreTiah1F/jEATjavwmEDigBnwy7JvCS/BNjLE03yv2vvmcDCz/uzivleIbPikaLS9MyiVM/ADiqF2LVb07cTkWPey6AzfyOSjfFZYqV4j6vizIWecSKP+JLd4Jgen16cGcwdg/G7uEpcoV7+Dd3QjpVbVUyvWqzr8PA+sqoIrnEiN3BP/SjivDYlv/CsbVDNBYZRM8iWVxXOhhDI8owke2EBVsO3HqwSQchXloEfgRJO0se7yvQDU4sglYokbFt1sLn0i2a4ZVTFyJk0VcMnXqDQ550rKS67kf6DkTzmSl0qOtcNQf6ULZAa1ZHw2XjAdpcelddEaWoQcnuV9bToJtZOkWa82cH3aMQawQzZ14ljdLapMyXcZqCkkVn+QzFPEWqZP3H3UFR6CmYw/Y6WJlVDqT1W06y69y8u5AqWttVPqIQs+JvIy7bmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40bdc0d-d33e-47df-883a-08d84a9920aa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 14:54:41.2857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZmmThr1fRWusNrq6BuESXn1FeYbsqKd6LmI224lKmlS6ohsINbmWM82BeFjeXivxjgQiAbGqsyAxNQruJmtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
> for suspend and resume.  I think we want logic like this:
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


Actually, as we already discussed - caching the PCI confspace only once on boot 
and not doing it again after each subsequent
controlled or spontaneous reset runs the risk of loading back outdated confspace 
settings. I am not sure if and when but, is it indeed
possible we make changes to PCI confspace registers during runtime and so the 
cached state from boot might be outdated
to load back ?

Andrey


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
