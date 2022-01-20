Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9049DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 08:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2453410E95C;
	Thu, 20 Jan 2022 08:59:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05EC110E95C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 08:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+9RuABTllX/SQJSDpRnE7Y5IZ5jeoHls1flCZy4Pp16r3GzrCljCVzRP8WxpPdlDG/Bp9crXBOPwfEYm19cS5+2Qiuik0b3cyzM1y3mUPtKl+U7B1GbTjlXz+8d2kfa9eoi6oyFupYDnpsKhKPy7gM6u52eR6V+pONv7PcTyKC5yYSNf+mLLSW/2gnzyUTAU48JKQi7ULYFW3oUhrN63W16O/t1kys92I2JPuTm/sYtotxwts51FBGhs3CfGB4r8EfgvAgcUNSPA8X49jrx8NUJdhFIkOOgVYejkjRK4Ug2QT5AHvwVVAzK0s8NumCVrpctjwrWCWISh6x4i9I6/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apdDgcGfNZooKoh3qR5QFSxW89ABrcIwaXuH6AjfnWY=;
 b=C+W0nm5X6ivbzOwSnrxcKB07uOjpEY+WXnmStM+F50sQZlALkbihK0Rd/G1YvY1eTVVowHTTpswnk1NEjMJF75Sh/27gTP9CLsYyEqJTbyTnW9dDsbk/Q24g5x3eMtM9QTsxEeTs/MZUWYzyswco4votwrKOM9/+g7luPgr4nd7shPpjpW3jpsqyOPEHAwIRyeJNPHq5NHXL3IHKJD7lxkTx+E6Qy25+3l9+da4jBNFadPNbxmea9NvdgkYi1nHXym4HD/HSry6cyNIpc0AFO52QpxUBQG0NeoZom42ahqPUJY1JJ5B5To0dgqz3B6Y1OW30ozM9rm+/mjL6ufWKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apdDgcGfNZooKoh3qR5QFSxW89ABrcIwaXuH6AjfnWY=;
 b=SFqmKV1KMCv31hyoqew1X2Zc3acK7XG84yG4Q/O1zQ6H7PgYj7cpkiW1cndsEar3PrzMCn/dkrkDcFIM/afyoK/HWoBkMvkruLlAxBuUn772hh1/T5IaNkrg9H/Nzz414RCGXTrbcQKNIvU+t4lNKNAebgQLkX6d1oOFAjReSMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 08:58:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 08:58:59 +0000
Subject: Re: [PATCH] drm/amdgpu: force using sdma to update vm page table when
 mmio is blocked
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>
References: <20220119031610.832211-1-KevinYang.Wang@amd.com>
 <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <95be3a20-ac92-9acd-9600-3caf9223c67a@amd.com>
Date: Thu, 20 Jan 2022 09:58:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------8E09A342EB89C2B534B7B752"
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0223.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79eacb5c-3689-4600-dbd5-08d9dbf318df
X-MS-TrafficTypeDiagnostic: DM6PR12MB4092:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB409204ACBDCEEF9EFCA45754835A9@DM6PR12MB4092.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:451;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZYUs9/2lwROKw43U5b7Fy8GDF9CJeloEf7qxV3Xfl/R6AbeoHUVOcxMCkIkauwny+JlrltY2pcvWElYimySTetGIE2UHTxd/51LknUXmSdOCfc3KkYnA8ljX7ZA0U8IHoVlqYGxncrBe6r7T8ffnpNilIalaQknd6RCYyOM8kifXxjQRl00KIYNHKKyL3BdCYzBHZpRYZHOMQNDC9JanhP54SDCXgtQ5C81BWhVr/NW9DRB/S3Eg6TF7U/VLhOy/hHisUT9n5t/M3hv3KGYh4g3E8NZ+w0rmNs0DZofIJsQQQ22PV+KJ84Rig7wfbdpuj8NYS8hwkuCm59+9kA5wQfEQ6V9VfFH4AhzDChVTE5Fv3dvM3K2ryO0x/zWnoLoceLIYCG46En20fVbKl+X+3shAk1I35CfIw3kF/W3tYFummYq9yRvbOGrCR/8akllzi9U6MfX9OD3KwEbkzXU5PXQybi9U/XNfJh4qM7z3lwLR0TGGMMidpZQzM6weUQcMuqRDrUZI8EMaJKRtelStmOZCHm0kFet10L1iSIkljeDV6ymE5glIHeYLeVPcSGUBobzOy4k6pVTzu6dLCeYBpfBFLr72GUOWjmeXFfUd2LsdDPB+4Gjb3TVx3J7XdIn8jX13SRFQkl06NmR2XXUGHRP9+zjGRU6lrnfZ5PYcQGg+ixb1jcpVMM50sDBJX4Dj3SeH5m8rmCdhS/4iHPz3zrgXLWsZJ3EsFcTlC+nJyG1H71/Jyak1QlFnRw+r0qOgwBZt9DhV8H+bY05ybPUZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(36756003)(31686004)(26005)(110136005)(6636002)(33964004)(6512007)(2616005)(53546011)(6486002)(5660300002)(186003)(83380400001)(2906002)(508600001)(4326008)(8676002)(8936002)(6666004)(316002)(15650500001)(66946007)(31696002)(19627405001)(54906003)(38100700002)(66476007)(86362001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFJBNFM0WDVDOXl4Qzhhb3VqdmpuSjMyaUdYNFVFUFNhTGwvbkFBZ0c1Yk8x?=
 =?utf-8?B?QkxxNVdpYlYrQTQ4aHgzSG8rOXVPN25QWkw3WEtNakl2Z0k5dkE2SEFrcExt?=
 =?utf-8?B?VGx1OVV5ZW1PN2RPMWlKUnJ4bXo3SVB2OFE5MzIrK3FKN3BsR0xraGN2a2Vr?=
 =?utf-8?B?anhGVzVIQ01wdkZ1TnpkbUQ3NUIwb3lCV3pIcU5qRzloVTFHRmlxNk1Hd1ZX?=
 =?utf-8?B?bVVwVnpsSkVQU0h4K3ZkbjhlSThHQ3F3Rlp5OGlnSFlaS0djamJKbERoTGtC?=
 =?utf-8?B?VnkySEczZmRRK2NOK1lFbDRLaVgvWC9OeklzQ2NMSEdHbFg3SXNETTU2eXJn?=
 =?utf-8?B?dkgzZ1pDUm5jY1ZEMXZDU081SUdac0dWbVMwWldQTGRZR3hZYWJNWVpTb0VI?=
 =?utf-8?B?ejh3V29UZ2E5S0dqQmZyR2F0YXR1bXUvSkE1akdPOHZKMlZpMmRkalNHa1FT?=
 =?utf-8?B?TmxNSFlkRjRaNHhYR3Bvekk3OGxadGlZT1JKcE5GVnlEWXppTFVkREtjSGhz?=
 =?utf-8?B?bmdJMTRsOERJN2VSNHNJY1czNnkxOWZscFZmNHZBT2hEWE52bEJheTEwb0tr?=
 =?utf-8?B?ZXdTSTdLQ2RJVGdpNDhDcEN3MHJXOEtvRDRhTm5hZjhLWTdnaFVySVZ0MjJ2?=
 =?utf-8?B?cDBBWXFMKzI4UVFNMzdsRkczOHdlenowSVNjZnNvRncrVmdlSTlYNlkvRFhY?=
 =?utf-8?B?Q2VvemRLakJydkNsTE56UjVQZEVVK1lsa1RsYzlhOG5oTUJyYU1hK0MwOEFT?=
 =?utf-8?B?bGpBZitoc0pGQ0tHcVVoRkYwVUIya2dmSU1hOFUwNDA5bVoxYU1LM0RuQzQ1?=
 =?utf-8?B?YnlQZXFWTjVWK2FpdExhNUpYWkVGcWlJQWU5NjkvM1h0V3VwMU5HM2VlMjd5?=
 =?utf-8?B?Zy9KUmdhT0FuMHUzY2xTNVgvVHhoay9sMG14aG9qSTRlcWhXZTNrOU9zVkNq?=
 =?utf-8?B?TTlJSEpJaVJ0RlR5MTBIOWNQb3hQWlVjdkdMR01wUGgxU3JwVkJtMXZaNHJz?=
 =?utf-8?B?cjRvWmxtTmdxMFBpeVl0WEk1RkVRNVB2cUNJTFZuczdkYitNOFdaQ2gvQ1Bk?=
 =?utf-8?B?b1QzajZpU0VFUWhIR1o3WjFjWk52Qm1PS0VNMzFVYUxMVUlQaWRabFVPZkZP?=
 =?utf-8?B?cDFCTUR1OVpWVVVoTUVBRE5vS3ZYOTFpMjZESWR4ODBpNkV0bU9YSlJsT0ZW?=
 =?utf-8?B?MFFFR0pyLzZweFcrTjhKdDV1Ym1TRGpFRk95M3NDelZNTHdoMHRLV2creTlk?=
 =?utf-8?B?cXhlSWUra0JXTHZ6MXpHS2dpVllNWkwrZUVmU1NRMjNOSXYyWHpxWXVSWkVQ?=
 =?utf-8?B?YUVzSHBpTXVML0NkMHNxWDVyVVFPbFp0Z0VJeDJmQWdLcmc2UHlFZjBKU0NX?=
 =?utf-8?B?SGg0YWgxeTBaRm8rRHVMREFzcWNjU1huMXJrUXhOWjYyUVZYa3Azd1dXNGdt?=
 =?utf-8?B?M3puSExLYkxqdmxiZ0NqdEI0VFFjTFdtY2xRaklXYXR1WVBBK2pDUHBUZ3p2?=
 =?utf-8?B?MGFTWlFnRlFGN3ZkRy91c0JMTHBEYUNJWWI4MW9ZZ1ZMdndmMzhJcEkxUXIv?=
 =?utf-8?B?c1dUWEkyaW9RSHFTZnFxL3ZyZm1rT1kzYVZjRlkvSXdLQTBZUXFRL01UaWE3?=
 =?utf-8?B?QVNjMStNNFlveUszQ0h2VS9ZclR2SVAvMFFxSlFrQWFqZEhGR3lqVkVwSm9S?=
 =?utf-8?B?b3NxVnNDaVZFYkttN1V5MVQwaUIzTXVRUCs0Qmh4VnVoeXFkTlRyeU9aK2FD?=
 =?utf-8?B?dUFlSjlJa2FQRDZOVHBHU3I4NVJlR2l1UFFhaUl2ZTk0U0ZObll4d1g4RWdL?=
 =?utf-8?B?Nkx1YUFsNUhxajlDS21CZTRNQlErMUZFQ2lYeVF5Z2Z2bTFPTzNpQktXM0tL?=
 =?utf-8?B?RkM3SjdGdHRpeFFYSlI5K1dJOHBUWDJsUU9haEd2eDQ3eTJuS2hmSVpVSDRo?=
 =?utf-8?B?RU1lTWpxVy9VUy9ZbUZLcGFGUUdVMkJMQkNsQnBhNCs4d1hWT0RBZXFPYlpD?=
 =?utf-8?B?NGRoVElGVXgycDl3UVVDbkZIRGNXMHViKzM0dVBwZUtEZy9BZDdCVzgvcGRT?=
 =?utf-8?B?TmIySVJCRXBvcUZnR0Rrdk1GQjByUXR4THFpS0U0ZkhlaThveGRNTC9SV09l?=
 =?utf-8?Q?MpRU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eacb5c-3689-4600-dbd5-08d9dbf318df
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 08:58:59.2370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngOrSDd3GxFCnK3ijOqxFC3M+PkB6Z+a38WrTqxhe4t50PUKPlv1weqiU/FxFA7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Min, Frank" <Frank.Min@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------8E09A342EB89C2B534B7B752
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Well NAK.

Even when we can't R/W HDP registers we need a way to invalidate the HDP 
or quite a bunch of functions won't work correctly.

Blocking CPU base page table updates only works around the symptoms, but 
doesn't really solve anything.

Regards,
Christian.

Am 20.01.22 um 09:46 schrieb Wang, Yang(Kevin):
>
> [AMD Official Use Only]
>
>
> ping...
>
> add @Liu, Monk <mailto:Monk.Liu@amd.com> @Koenig, Christian 
> <mailto:Christian.Koenig@amd.com> @Deucher, Alexander 
> <mailto:Alexander.Deucher@amd.com>
>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> *Sent:* Wednesday, January 19, 2022 11:16 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Min, Frank <Frank.Min@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> *Subject:* [PATCH] drm/amdgpu: force using sdma to update vm page 
> table when mmio is blocked
> when mmio protection feature is enabled in hypervisor,
> it will cause guest OS can't R/W HDP regiters,
> and using cpu to update page table is not working well.
>
> force using sdma to update page table when mmio is blocked.
>
> Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b23cb463b106..0f86f0b2e183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
> struct amdgpu_vm *vm)
>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> AMDGPU_VM_USE_CPU_FOR_GFX);
>
> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
> amdgpu_virt_mmio_blocked(adev))
> +               vm->use_cpu_for_update = false;
> +
>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                           vm->use_cpu_for_update ? "CPU" : "SDMA");
>          WARN_ONCE((vm->use_cpu_for_update &&
> @@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm)
>          /* Update VM state */
>          vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
> AMDGPU_VM_USE_CPU_FOR_COMPUTE);
> +
> +       if (vm->use_cpu_for_update && amdgpu_sriov_vf(adev) && 
> amdgpu_virt_mmio_blocked(adev))
> +               vm->use_cpu_for_update = false;
> +
>          DRM_DEBUG_DRIVER("VM update mode is %s\n",
>                           vm->use_cpu_for_update ? "CPU" : "SDMA");
>          WARN_ONCE((vm->use_cpu_for_update &&
> -- 
> 2.25.1
>


--------------8E09A342EB89C2B534B7B752
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Well NAK.<br>
    <br>
    Even when we can't R/W HDP registers we need a way to invalidate the
    HDP or quite a bunch of functions won't work correctly.<br>
    <br>
    Blocking CPU base page table updates only works around the symptoms,
    but doesn't really solve anything.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 20.01.22 um 09:46 schrieb Wang,
      Yang(Kevin):<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB54731E9FBF54A2E86A320419825A9@CO6PR12MB5473.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          ping...</div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          add <a id="OWAAM160069" class="P8b7u5KH31KY6Eljcf5yw mention
            ms-bgc-nlr ms-fcl-b" href="mailto:Monk.Liu@amd.com" moz-do-not-send="true">
            @Liu, Monk</a>&nbsp;<a id="OWAAM254265" class="P8b7u5KH31KY6Eljcf5yw mention ms-bgc-nlr ms-fcl-b" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">@Koenig, Christian</a>&nbsp;<a id="OWAAM277931" class="P8b7u5KH31KY6Eljcf5yw mention
            ms-bgc-nlr ms-fcl-b" href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">@Deucher, Alexander</a></div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          Best Regards,</div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          Kevin</div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Wang, Yang(Kevin) <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
            <b>Sent:</b> Wednesday, January 19, 2022 11:16 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Min, Frank <a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>; Chen,
            Horace <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Wang, Yang(Kevin)
            <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: force using sdma to
            update vm page table when mmio is blocked</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText">when mmio protection feature is
                enabled in hypervisor,<br>
                it will cause guest OS can't R/W HDP regiters,<br>
                and using cpu to update page table is not working well.<br>
                <br>
                force using sdma to update page table when mmio is
                blocked.<br>
                <br>
                Signed-off-by: Yang Wang <a class="moz-txt-link-rfc2396E" href="mailto:KevinYang.Wang@amd.com">&lt;KevinYang.Wang@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 7 +++++++<br>
                &nbsp;1 file changed, 7 insertions(+)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                index b23cb463b106..0f86f0b2e183 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                @@ -2959,6 +2959,9 @@ int amdgpu_vm_init(struct
                amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
                !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                AMDGPU_VM_USE_CPU_FOR_GFX);<br>
                &nbsp;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&amp;
                amdgpu_sriov_vf(adev) &amp;&amp;
                amdgpu_virt_mmio_blocked(adev))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update = false;<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM update mode is %s\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update ?
                &quot;CPU&quot; : &quot;SDMA&quot;);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_for_update &amp;&amp;<br>
                @@ -3094,6 +3097,10 @@ int amdgpu_vm_make_compute(struct
                amdgpu_device *adev, struct amdgpu_vm *vm)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Update VM state */<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update =
                !!(adev-&gt;vm_manager.vm_update_mode &amp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                AMDGPU_VM_USE_CPU_FOR_COMPUTE);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vm-&gt;use_cpu_for_update &amp;&amp;
                amdgpu_sriov_vf(adev) &amp;&amp;
                amdgpu_virt_mmio_blocked(adev))<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update = false;<br>
                +<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG_DRIVER(&quot;VM update mode is %s\n&quot;,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;use_cpu_for_update ?
                &quot;CPU&quot; : &quot;SDMA&quot;);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ONCE((vm-&gt;use_cpu_for_update &amp;&amp;<br>
                -- <br>
                2.25.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8E09A342EB89C2B534B7B752--
