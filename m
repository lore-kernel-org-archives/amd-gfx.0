Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC50FEB8FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 05:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 114E510E1DA;
	Wed,  6 Sep 2023 05:24:25 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A0010E1D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 05:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkqYxtBEyTsIY+eJWGlJsVmOYyje2Pwn7DwJSgoGLRxH5rp/Cm5XtvnNIYaTSL54nqDN1MlDp4ZUwu7uOt4epoNo932MKkEe8t+J360Gv66I53G9jM5E8cUvwf819ADR36sHajy+WGzz259sXhA7lbiVNjVshXbcTFSvOCyH1Ie8Z5RFmatRn8KXI9HNa+Hi1Xhk0/qsMr3LtZTyY1OW3mItldpOpAtFKhEmNbTS+SDKyOF/lALrol4+m9dGKFEiwz8Nb8l+bG8xifykaTSs8eyNJJbx61S3VXOVNyQbOSVl/1BoNa7vRqJcG6z+SWSlO5ixK4qcfFOkdQz9ZjvEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbxgVulgIA3PGYrk0ALNxVPzGcIGyqM2BOvJfK44Eec=;
 b=Dw28/vV4eWwYd3QI47LiFf3cgx5/eZUrMkTAk9G3qoQbyZ01cOJQiGxr/bWZsMwNGpijrWHio/C8blAOkFVjEPsbtbGG+4400Fv0VoJd3RfNm77LNFhJ3IWB9zZuWpBJ5BMpRQT9oV7maLnT+vvI2+v/SiA1KwCg8xD8KM+xRyRFTIg8hYoMO/m2NRxYRerczVLm3uSwmMtOErRg0UFx2uLLlSvWHVeaKKdXCzxRlrqsEWz//6aPyyL5cPQI5M4r9FXFg8mwDwRkZtsJNhjyQYgDNw6iqyKFOJK+wrx5FyazzXGOIkDh6l/qxD5M/fWTB+f0Beqv28kVQ+Auhn2ewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbxgVulgIA3PGYrk0ALNxVPzGcIGyqM2BOvJfK44Eec=;
 b=pQ3pjSX0hyqvGoc4eQ5SCZKchjuSudIcbrGIH1ZI00OklQnnyuYWWlhFe3ZPjvXmGcRVDg6tkHYre4YJ/NvkJlJeUkHX/vu5vpQIgkcUdgpOCmE94XulAhDcTl3/4Ajl+3dpFVuDsvwU9eJ4xtccrWN/aUkXoiMf5fEfHQr8qvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BN9PR12MB5097.namprd12.prod.outlook.com (2603:10b6:408:136::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 05:24:19 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 05:24:19 +0000
Message-ID: <7773bb9f-b3cf-ea7e-9a10-9f1a4caba92e@amd.com>
Date: Wed, 6 Sep 2023 13:24:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amd: Fix the flag setting code for interrupt request
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Ma Jun <Jun.Ma2@amd.com>
References: <20230904060501.2942018-1-Jun.Ma2@amd.com>
 <CADnq5_PbrtHJ436e2kuiu0MrHv_xxiy3DfHqNHqaygej2qaiBQ@mail.gmail.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <CADnq5_PbrtHJ436e2kuiu0MrHv_xxiy3DfHqNHqaygej2qaiBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|BN9PR12MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 389206a6-daab-4bb8-bf99-08dbae998528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gypkl9UUiS+H9RvF6e1K45ka4dIQWichKON9RjLQiCc2iL2xHo6N0zSSvIPBR3w/GtxLdqsor6dcVuHDilQkyeHbxYvDeVx+b9vS/ksW5fC/kdyXKQnC0LGwOFM5efTf9qxGNz2tdJAKpyiOOVqQVaO100KPnCBek0Qit3owAPWwZidO/sGxCvOT93IolprhINpdXv1uergFlDldVgjUoDa14ut8yXa64oXo5CBl4u3I5dObNJX6cmxSPEFLRgCY/bbUXwzRKAilNmUVpR3HFNeBuImtkXRBf/TFpnoccpiMYqeGRFDTH9fvkz3YB5JSe7yz1tVaPvNXTRjV1PErHactrMOvmO64FppwnFHX9+yaGb7WDgt8NwbpGpsX3xBobL0o7G4OgBW8CzLS4MMx2M2QtxewTYE0V60JB+OFfxT91zMqccWtiQW4CHTJbwSYKQbg5RiKeo8SNh0SK1QhokJotJmsEUaHkDu4P3lcrWRJu1QsCKzaq0fHX2dqbclQ7X01olYYCs88+R1781e/EV6v06Z8ugSfW524ISEXpEd53hmkwRBRFxJfJ98aSBoFLzdS5m+J7NpDEdMu2wvwfhvwm1efem2IwWWHws28MxCTZA4tjh/mpZ+KVmYvgCJOlgT3jbgXOqk/L0k74NbCww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199024)(186009)(1800799009)(41300700001)(5660300002)(31696002)(6666004)(478600001)(2906002)(110136005)(8936002)(8676002)(4326008)(66476007)(66556008)(6636002)(66946007)(316002)(31686004)(26005)(53546011)(6506007)(6486002)(2616005)(38100700002)(6512007)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGJtWDllV2ZuQVd0bEJLMVQxNktGN0FHNmtQN041WWdIeXlseHRjVG1EUG9k?=
 =?utf-8?B?dm1qblJ0RnlRclNYWmRBc3hENE9US0l4OU16ajRHNzRwRXU2eGlSbHMxa3Np?=
 =?utf-8?B?cTVtcmpMRWhoQlZPWE15TUx4QW1YSCs4MW5xQ1RoYjJDK21ZNVJFMFdqZkJz?=
 =?utf-8?B?YmROQm4zazlXMkUvZFo4dExSL0Z5Qm1VcjRQRzFJdGE5MWRZbXZpc3d1eHQv?=
 =?utf-8?B?VjgrVnRHSDJoZ2M3K2E0djJLRVAwT1Y1N0UxcEVQc0VYcHg5VkpUSU5LSWsv?=
 =?utf-8?B?OTN5ZElMeFhIcEpGUnZqOWJyMnRjODR4VHVnSURyeEY5Rloxb2tIbko5bXFG?=
 =?utf-8?B?OURiRE10b2ZSMkNNR3p1Y0JRWjZiL0lZRmk2QUNsS0g5MHVwbXdVWk54OVpX?=
 =?utf-8?B?Zjg4MXVpNzYzMjNMN3BPYmFlaVJRL1V3a1Z0cHc1Qnl0Y0NUaCsrL0JGeDN6?=
 =?utf-8?B?cFdUVmdTNElTQkpIV3RPaUpveFMvNzdQRDJHRGdlL1ZCWjJ1S0JhYWtEZCtJ?=
 =?utf-8?B?OXJhT1pXaXY2ajg4THRoU0F2aStDVHpxK01NcEdXQnYweUlITnRsbGppcXN4?=
 =?utf-8?B?c1c2K2QzK3hRTHpheVdCYWpLYlgyb1lvMzFYNnBSZW0xN0VVeFFvcFBaZ3VZ?=
 =?utf-8?B?TG1uU0JYR3kyZkcySVBXWDExVitGNlE3MktPcHhLc3BqajBxajZJd05OQWpl?=
 =?utf-8?B?eDhOakZXS3FQdWNEZnVtaDgvcWx4YlMvNnRlMTgvbWx3Q01FUTlYZ3B0ZnE2?=
 =?utf-8?B?b3BLWEV0YktJc1FCb3FBNWhNSER3MGpoenltaVJsZHZMaFpRRzdwdHQxZisw?=
 =?utf-8?B?bUduRmh0Wlp5U09HRWk5YUlSaDhvMVBEUWEza3RNSXhIV1lLWnVqTWlvNGdE?=
 =?utf-8?B?cWJEdWxzLzNGRG52SFM5a0tiQjFqRXhkNjdkMnFOdEZlQ1F3MmlESlRRQ1FX?=
 =?utf-8?B?RXNXZzNLS3ZjVWJlSlBoUENwVVVvNUxnTWpVaUhBdXNsU0dISG9NY3RkSjc0?=
 =?utf-8?B?S3NKb2pPMGJHK2JrTHhpVW5YVi9JQXNNK3YxSW42UWtENXFrRE9wT2Q2aTkz?=
 =?utf-8?B?Qy9kYkZaS3htZkxKSTRQVHpJdm5abDVoT1RsaTZYRi90dmNlaSthOCswSmgx?=
 =?utf-8?B?OE15a1d0NElaVkxmTlJBa3NQbXczelV1MTZ6ZmtrYUFhMVc1Zit5VGRQZGR1?=
 =?utf-8?B?ZXYyM1ROMURZOTZzY3doNCsydTN6YzFBZ3NObmJ0eHU0VW4vZTd3RVNJZmww?=
 =?utf-8?B?dVZmbGoyMGNKaGordEE0REp4Ry90a3VIZnJteVlNU0MxeEZCc1FBdHdHK256?=
 =?utf-8?B?bmNIZW1QeVJrb0puUVZmZXVyYmxQcmc0ZzNST3A2NWF3bWZmTXZyUDY3V1pi?=
 =?utf-8?B?N0poRm1CUFRPTlV0dWtuVlBKM3ZIdkovZjF5bU92TVFRSWFTQlBRM29kdnRX?=
 =?utf-8?B?TERFZng3cFdZN2xmVzFSSTdrTHF2bjdUdG4zRGhQKzdZc3Y5azcxclM2VStY?=
 =?utf-8?B?RkM3RG1XUjFnWFNoUVlPSVFHVy9iRXVCSXBzaGZkODZ3UUlpT0lqRzdCV1c5?=
 =?utf-8?B?VWJZcGNJbUwvZ3FzSFFXNmhEempuNHgrQXY1cS9kUjdmVUM3VlRFd1E5d0hW?=
 =?utf-8?B?K1E3M2hVZVJENzg4TERSMXlBQWhNdzBoWG5GajI5TmpGb1NGK3BYSCsySU94?=
 =?utf-8?B?dkF6NzlzNE8raEFQOWdiTUlOMUI3Rk04RHRCNXpWc09sNGNhOUFMMk1EWFhx?=
 =?utf-8?B?aVlIVUF0TGIwUU1kVnk5VGlHMEFDdzRwRnJHN1BWd1VSb3ZTN1ZhVFhmaWV5?=
 =?utf-8?B?RGl2M3ZiOHdwMmFQWnpsYStiVys1eEpaNWJFaVZMRm12UVRlUmI1ZWtYN2hT?=
 =?utf-8?B?bVpraDFKeXdwQURxY1IrV1NUQjJpZVM2N3dOMlZTc2dsUC85TFhnQUhSOUhs?=
 =?utf-8?B?Z2MxZU5kMnJsSWloL3FIQkkySTIvR0w0YktWUjJmWmhKT0NHNjVLTFJhOTlZ?=
 =?utf-8?B?VThqWVA4V1JJZEdpOWJzTzdncXd0WHFPS3JUbE1YMnh6K0c1WXZlWVI2cU1S?=
 =?utf-8?B?S1BIUGxiYUVKWlZUTWZmdmZKRW1UcUxDMm41UCt3YmZjVVdISEtlVStZTnlx?=
 =?utf-8?Q?BAMjl19bQFvYKqXoBE7uArFlE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389206a6-daab-4bb8-bf99-08dbae998528
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 05:24:19.1809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlEC3fd5ctAG29JTVcGEkZJ7jBKABsEom3lyNgJSMReghD4fMr3DTEvPbnAccuRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5097
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
Cc: Alexander.Deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/5/2023 10:46 PM, Alex Deucher wrote:
> On Mon, Sep 4, 2023 at 2:30 AM Ma Jun <Jun.Ma2@amd.com> wrote:
>>
>> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
>> handles these flags.
>> [2] Free the msi vectors in case of error.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 43 ++++++++++++++-----------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index fa6d0adcec20..17043a1e37a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -271,28 +271,28 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
>>  int amdgpu_irq_init(struct amdgpu_device *adev)
>>  {
>>         int r = 0;
>> -       unsigned int irq;
>> +       unsigned int irq, flags;
>>
>>         spin_lock_init(&adev->irq.lock);
>>
>>         /* Enable MSI if not disabled by module parameter */
>>         adev->irq.msi_enabled = false;
>>
>> +       if (amdgpu_msi_ok(adev))
>> +               flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>> +       else
>> +               flags = PCI_IRQ_LEGACY;
> 
> I think this logic could be something like:
> 
> if (!amdgpu_msi_ok(adev))
>               flags = PCI_IRQ_LEGACY;
> else
>               flags = PCI_IRQ_ALL_TYPES
> 
> Other than that, looks fine to me.

Thanks, will update later.

Regards,
Ma Jun
> 
> Alex
> 
> 
>> +
>> +       /* we only need one vector */
>> +       r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> +       if (r < 0) {
>> +               dev_err(adev->dev, "Failed to alloc msi vectors\n");
>> +               return r;
>> +       }
>> +
>>         if (amdgpu_msi_ok(adev)) {
>> -               int nvec = pci_msix_vec_count(adev->pdev);
>> -               unsigned int flags;
>> -
>> -               if (nvec <= 0)
>> -                       flags = PCI_IRQ_MSI;
>> -               else
>> -                       flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>> -
>> -               /* we only need one vector */
>> -               nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> -               if (nvec > 0) {
>> -                       adev->irq.msi_enabled = true;
>> -                       dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>> -               }
>> +               adev->irq.msi_enabled = true;
>> +               dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>>         }
>>
>>         INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
>> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>>         /* Use vector 0 for MSI-X. */
>>         r = pci_irq_vector(adev->pdev, 0);
>>         if (r < 0)
>> -               return r;
>> +               goto free_vectors;
>>         irq = r;
>>
>>         /* PCI devices require shared interrupts. */
>>         r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
>>                         adev_to_drm(adev));
>>         if (r)
>> -               return r;
>> +               goto free_vectors;
>> +
>>         adev->irq.installed = true;
>>         adev->irq.irq = irq;
>>         adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
>>
>>         DRM_DEBUG("amdgpu: irq initialized.\n");
>>         return 0;
>> -}
>>
>> +free_vectors:
>> +       if (adev->irq.msi_enabled)
>> +               pci_free_irq_vectors(adev->pdev);
>> +
>> +       adev->irq.msi_enabled = false;
>> +       return r;
>> +}
>>
>>  void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>>  {
>> --
>> 2.34.1
>>
