Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828C5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 07:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DC510E55E;
	Thu, 17 Nov 2022 07:33:39 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD14D10E55E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 07:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0xbOKO0+L5TIbind4YRqkK8ZBdNaokhfqq3h9hPbs7ObyYlNLgpOzP7z+GMe8unl2ZUKBDc0W/0hSpOfIqL9p3eGi4T3h4vL/8MJCs8ed/6r+QrZib8OrC/Yju8OYXNtp9Aw2TioG83IJ1Cb8B6Yf28Tm0t3LZZ3rwZW3ltx0J4Df1pby9sC9xMSY1SAoeGxHgugEuT0+7nEVp+28Wwgxe6d/756572QZXQnUEo8MKGCJS1QALn+Bkypl1ZTi0dU5ZI97R7TJPVxkr3NOaOWXAd+jA2BBjzDRcyfdRY4jS0d8pzFjZVg3KaAWuvYf38MdCiM/HchPsJ9QA0SlZowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOlo5CMEgz80CJpBSO9Ri/7iFG7Xq/e9Mguobl/Mwmc=;
 b=m72aHyGqo7eWaz9jo04e7g5hWJ9CXXpeHwFnG6YdR1Bibe29LOZGi03p3MfObHClMEWz0aEi/03Y0Zlqurksi9y2X2IIl2lugBIv+x5v/euXbBT/cOpP+LRCXuatBaCmc7yeC4XXFeOm6/LIPjg7FoO+jSVy5abeSZ0IHF2p06TAKn5+TfdShgp0v6bYnLWBXwnq2sMODdc3mXyqcHf6zweH8GjwF7s1ohBy6KpFPBDZ7oXrNR8NK3vu9aQbqicxyjKXcr7OdhEDpIyNMD5sqJhfusGioDRoD5zRlIj8p4kLU6BxqqNHmadQro0wXjBjSYPrIiaM24Zb9xpstKl/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOlo5CMEgz80CJpBSO9Ri/7iFG7Xq/e9Mguobl/Mwmc=;
 b=Al8tUGGrYC8s/kVS3oZYiFh0u/R7PopjvWWtJ5hXvpcDYFup6tY0MNlryPIpIlGbEns5wuazU1SOp/ijKqQHSoVLbpQDfLt2APvmusKUsRywpDSO+sG6FhxoZ1zBVwfcf0qZTynhKLG6t9i2H3W9Ongm5zKvupZPnBIib92ytXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Thu, 17 Nov 2022 07:33:33 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%5]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 07:33:30 +0000
Message-ID: <90dae711-8786-fc6d-9834-59e201b22620@amd.com>
Date: Thu, 17 Nov 2022 15:33:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From: "Ma, Jun" <majun@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Release the topology_lock in error case
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221116080415.593223-1-Jun.Ma2@amd.com>
 <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
Content-Language: en-US
In-Reply-To: <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|BL1PR12MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca7b9e1-c2e5-43f6-ee36-08dac86e065d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v21wzBSG+o5hcC7l5qluNFHSxHyXjX9PikqTdySsgkoc7ZZ/i422feyi0OhtxNP7ZgOnVzX5rJxtqAEIgeQdr5QI6WlJPfRclI1v1r0U1X2q0sDnEz29S8SCV8RPWmHvsaThOLGDbxCJ3IrSS2Gr4b1zQNKOc+njtzxEnquC/HZtdzmZggIXDWkaCfr06NTe+WmdOTsej0OzhwpXq+Cpty9AUrILYG2+Wjth9Wy9yzJUfZa2BD00FC5I/37uwAof5BZRnWntH78Tx5E+RDF4qhGL8PMyG1kk77e+d11KJfumhRC+DMJ+6wINTDQs9iF0q2BCzzLdh0fF2kqvFlIFnaBy2H4I4qAwEvMZM+iNHv3apVgAOUd/YN3A1s3gwYykCGurILX6elk8dp0Nb6PIac73SbGWYfgR7poJjEi/aqVV93VyHNjYelBqa89PjvRGKVyrXiV4PcNnhOOnp99zQm1CnNKunX2RsTajoMv68Rt20f80vlM3P+Vn7gPGhcWrGkeEzN6L7D/2UYK+ulI8sWgWMJ0VY1ErOq5ZUzv3iNgkZhhwGtJZtpZ/p+nuJrYJRSEGYcam/ubAqqgHerr2XhG2lC/LMYQ6bc2hBzFJn+lPC0SWVkMPJcLHsHT9lrqP26ORrpc8KaFsfN2IAAd3qkUTENyBy67Q4jtkebXwRdCOn5FZZ71UHiCfVWPoafMB63ZdTNHR29NqFu833bk0+EAlPHHIeEY+Mb+xWIjT+M8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(36756003)(31686004)(31696002)(6506007)(83380400001)(4001150100001)(5660300002)(2906002)(2616005)(53546011)(38100700002)(26005)(6512007)(186003)(66946007)(66556008)(6666004)(110136005)(66476007)(8936002)(8676002)(478600001)(4326008)(6486002)(316002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d21uQWtCcTN0ZkJ3RG4vZ2hVeG9zYkJMbTNqSW1zckk4emt5TjZRb2tTcWlj?=
 =?utf-8?B?a0NXT2R6NzJtZmkzK0RSUzg2YlBNL05na2pvQStMSmVEVW53UEdranpZUngw?=
 =?utf-8?B?d2drT1NPdDI3ZjQyVUpTVDVrNnZ1ZnBtOWhSTVFFejdvUkVUNWtxa2ZaZ0Uw?=
 =?utf-8?B?aStNKzZwYnZOZk5qVWUzTkpsUEsza1M1dEFWbXA0RGxiZ0hYVzlkYzB2elpZ?=
 =?utf-8?B?cXpsSW4vbHlWY053djRGcEpmakVhbTluVUVmaC93eHVPNE0wc3p5ZGJiNU5l?=
 =?utf-8?B?d0dVeSttdGp5eUtiQjQrcHBCL1ErbjhKazdDY2k4MkgvcjM4dzFWZ3o5Ty8z?=
 =?utf-8?B?NHNUaUM3MzNwdk9pb1NxSWJGRk9rV3BjQ2FZSlFhYlVHaTZnQnMvSlhNd25P?=
 =?utf-8?B?b0gzSkMwdEtDeUs1R3V2TlhzOWkvNGdrWnl1dHhES3JOME9iOU9nQnZxUFpz?=
 =?utf-8?B?eC9rQ1F6YnkwSWltZFBBN1cxcll6M2toTmtXME4zT0wxMVljSXFhcHdCN1lJ?=
 =?utf-8?B?ZjhlQk1wTTN6SXN3NlUvNlIzbm11aVcvdlRrNVlsSmlIdTR4YStqVFdWb0hQ?=
 =?utf-8?B?VmFrWFVGalRJanpnYVRQbXZBLzQ5d1R0RnZVMmxvRTBQV1RYYk9JL0lqLzkr?=
 =?utf-8?B?OHovVjFiY2dpYjVTRUp4dW1jdjJKWGo0eTcydWtxVlVqRVV2U1ZIeWxTeEo2?=
 =?utf-8?B?VnZFWFJWMHoyZ1BISHhrbDVURkM5aG1YNzVmcFh5Ri9xTzlUMm9YU0J2ZUY2?=
 =?utf-8?B?bmZiZ0szd08xVFFIQW1jeEhqTXRXdlEzZDJCTWlma2U4a0JoWGNlQWtBSm5r?=
 =?utf-8?B?QnUrV1laNFpvMXhvVWNGWkZvaStrZDVpdEFKNHFaQ2o5Q3FwYW56SkFzcEtk?=
 =?utf-8?B?NFF1NjVnb3M3Y09VN1BKOW5sQnlYckxJUThsNEorbEtxVHJUejJVWDUzU0ZF?=
 =?utf-8?B?WlJLSUVpUE5Tc0YzeU5XSk1Rb0JLYWRXL21sTFRNNWhSdnp0SXhQUEFrQVNP?=
 =?utf-8?B?RVVnMGVKbDZEUFVoSzdDclZqTFZ1TG9vNUEvYS9na1V0U0Y0VTNBWTkrVndY?=
 =?utf-8?B?R3UxMHlTVjhHbDRHOHV0enNYeC9xOFh0cDRKbmd4b0orSEVlaDFhMXBNWENM?=
 =?utf-8?B?VWlidkFyRnRlQTFZWTh4YStDQU4wZnlsYUFaU2g5ZW5pN1Y3cUhIVUhIQlQ2?=
 =?utf-8?B?bUlVTkk5bDBuQ1VEOFpDRXlXMFdkQkdIVDZXMGVyeFFVcmFzR1g1V0k2czF2?=
 =?utf-8?B?d2h0Q0lwZ3BTSW1lazBWOC9SZTc1c1BmajFYTEcwUDA1d0paa3F3ckY3TU1E?=
 =?utf-8?B?WjkwTUt6RllJZC9ob2g5NGYweHNVV1U2OTkyaFRkcWdzb2F3UDRFVHdtdzA3?=
 =?utf-8?B?K2dQYU04Z0lwRkVRcW5zb1J1MWNycFN4bnJnRExyZDlYTmRxWlg1ZFh5OFdS?=
 =?utf-8?B?VXlXSzdab1pVZ1Z3cVYvZkVqYTB4SE9RcEc5Tm5QelQrRk5rY2xVZ3ZWOHRP?=
 =?utf-8?B?d0dMeTFFczcyc1ZRNmNwVS8wK3lESEJoYlJXTUNINDhEeS9qZFpvcjdvemdu?=
 =?utf-8?B?RFVSOFIxRkV3L0REaWhISDZUVmQ4QjlzQ3pPMGVVWll4MDIyQmI2dzZROGF3?=
 =?utf-8?B?MEhpK2o1Wm1VSStoZWZQK2ZPVGk2b0k3b2xwTFFIY3lVNzVHS05QMWxjd1d0?=
 =?utf-8?B?dmFvSHdJbUh5R0NzWjREVm9sU0RWbUdGV2M1bitqTVVvNEozc3VqOW5qT3Bu?=
 =?utf-8?B?clZDZmhmcmplcXBZbjhEMDQ4UWJNTjVNdDBORXFuVGg0dGVJM3dhODlrejhk?=
 =?utf-8?B?RllrQ2lxMDI2VmNCZW1MQUszeHJCZ2M5TTZ4YzRSQ1RhSzhlTlVEUGo4b0lD?=
 =?utf-8?B?MXplaVlZYVJ2UTJtcXZpT25KU0ZNOVNuQlpGSHlUV2tvQmp2MzZyTVY2bndt?=
 =?utf-8?B?Rks1enpUSzRmVGZORTF3eExRMk9FaERqdzBvajdaUTB6cGxDTWw5YmEvTkxW?=
 =?utf-8?B?U29Cano5Zld6L0FwRTFnOEx3Y3FKOGxPdXBQSEdlanpnWEViWWcvekM1R1BB?=
 =?utf-8?B?ZXRNa3pkVDlpSElJNFJZOG45V3pHdklZaDVHdVhqYk1Cb1gzR1VsWHdMeU1Q?=
 =?utf-8?Q?ZnRSjij2xHmYGh9MYS2qtyqX5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca7b9e1-c2e5-43f6-ee36-08dac86e065d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 07:33:30.6216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4ybAlYD3m6q9+Ak+pNq1C1fv/vHfaU/+Hzr/n8TnODmI8pQdwhYLDRlhPUZEyHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>, error27@gmail.com,
 guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

I just tested your patch. It works fine on my test set with the following little fix.

Regards,
Ma Jun

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 7ea3ec1e9e75..7d6fbfbfeb79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1954,9 +1954,11 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
                pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
                       gpu_id);
                topology_crat_proximity_domain--;
-               return res;
+               goto err;
        }
 
+       INIT_LIST_HEAD(&temp_topology_device_list);
+
        res = kfd_parse_crat_table(crat_image,
                                   &temp_topology_device_list,
                                   proximity_domain);
@@ -1964,15 +1966,17 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
                pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
                       gpu_id);
                topology_crat_proximity_domain--;
-               return res;
+               goto err;
        }
 
        kfd_topology_update_device_list(&temp_topology_device_list,
                                        &topology_device_list);
 
        *dev = kfd_assign_gpu(gpu);
-       if (WARN_ON(!*dev))
-               return -ENODEV;
+       if (WARN_ON(!*dev)) {
+               res = -ENODEV;
+               goto err;
+       }
 
        /* Fill the cache affinity information here for the GPUs
         * using VCRAT
@@ -1989,6 +1993,8 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
                pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
                       gpu_id, res);
 
+err:
+       kfd_destroy_crat_image(crat_image);
        return res;
 }
 
@@ -2001,8 +2007,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
        int i;
        const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
 
-       INIT_LIST_HEAD(&temp_topology_device_list);
-
        gpu_id = kfd_generate_gpu_id(gpu);
        pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
 
@@ -2018,7 +2022,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
                res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
        up_write(&topology_lock);
        if (res)
-               goto err;
+               return res;
 
        dev->gpu_id = gpu_id;
        gpu->id = gpu_id;
@@ -2141,8 +2145,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
        if (!res)
                kfd_notify_gpu_change(gpu_id, 1);
-err:
-       kfd_destroy_crat_image(crat_image);
+
        return res;
 }



On 11/17/2022 4:49 AM, Felix Kuehling wrote:
> Am 2022-11-16 um 03:04 schrieb Ma Jun:
>> Release the topology_lock in error case
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
> Dan, did you change your email address, is this one correct?
> 
> Ma Jun, thanks for looking into this. Some of this problem predates your 
> patch that was flagged by Dan. I would prefer a more consistent and 
> robust handling of these error cases. I think everything inside the 
> topology lock could be moved into another function to simplify the error 
> handling. I'm attaching a completely untested patch to illustrate the idea.
> 
> Regards,
>    Felix
> 
> 
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index ef9c6fdfb88d..5ea737337658 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -1841,6 +1841,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>>   			       gpu_id);
>>   			topology_crat_proximity_domain--;
>> +			up_write(&topology_lock);
>>   			return res;
>>   		}
>>   
>> @@ -1851,6 +1852,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>>   			       gpu_id);
>>   			topology_crat_proximity_domain--;
>> +			up_write(&topology_lock);
>>   			goto err;
>>   		}
>>   
>> @@ -1860,6 +1862,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>   		dev = kfd_assign_gpu(gpu);
>>   		if (WARN_ON(!dev)) {
>>   			res = -ENODEV;
>> +			up_write(&topology_lock);
>>   			goto err;
>>   		}
>>   
