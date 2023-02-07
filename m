Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C884C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CCA10E1C4;
	Tue,  7 Feb 2023 07:40:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7905710E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7JGkQrT5Q0FHujBm83rfnWlf0RG657DlOOzTZl25J93n84iqeRwIK4hM/WQRckdEjfGoCc3j2mTvnvmO6NhdAviJVseTFR4AlcOEwv4OArZis9q0WHf0YInooAVk8xXQymC5NZ5Njow7OK3uSnfEImXo1XQ+j8L5Vw76+FRAglBqHo6GigKK6NKE4oTPxEBvIIVRotjflLv/WbCB7b543QpU60Gs6HrXH10pPzZXz2hHn0fzT+EZ5NZMpNXcTcHJhLKsAWCulSXz8tFKOMWUNm5OoVtJqLr4PIF8CXMTBEGwdOetlrY2YurycDWKORHVhOyoCmJloxhX8OvTbuisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSb8j760w8Cva/Mu5OYgZhhioB/9ZU2leQwP2AFDqWo=;
 b=EBqsaX79JZwrm+DYB6bhX8mLRzqgliFvtCDZv5rK+X1OWKteTpjYaszTeAIa8awLd6If8955jBY80haOg8gwOC5msK9Mr9Zh8nZ+FO1SsxhC/PKfeheVkr2Gwk/yHhmMqUysoyOTtDdbvtqNWoeISeCPx4bl6ELafqhtyQ1IDBMU9JqO9OH4xF2FxgYjfClY49pM2jACRKssBh47cmyYGGzdELc1ADOU7PrXX8igZUWPJNDKpmbXL4nWebOK0cO3A+1Bw7kMxryUlWxB+vKJTlaBt8dE7OXbqffzvnk3Oq9rNKpYj7ob9R9G5ZYdiZEA9u8/+5cwwiDvq1704Ainjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSb8j760w8Cva/Mu5OYgZhhioB/9ZU2leQwP2AFDqWo=;
 b=exAynXqrvcvqQuJggPaSDd0uTYXGbH3QTjKzOpOwe8x6vGNseYUrj+7QcAO78hhU3iQWXCu07Is/FMWjuIwqEhVQ/7a5ZH8JAcajwtQBaQ1FM613uadXOUctuf5UUtkCDYkpcneCRJPlVJCtqkHfoufsLUZIJqmxRih/KtOu7GA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 07:40:42 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:40:40 +0000
Message-ID: <f15c488f-3450-6f49-5540-6ce5b25ff699@amd.com>
Date: Tue, 7 Feb 2023 08:40:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/8] drm/amdgpu: add usermode queues
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-3-shashank.sharma@amd.com>
 <ecb47e10-43db-af4e-ae3b-c0321dcd8e2a@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <ecb47e10-43db-af4e-ae3b-c0321dcd8e2a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BN9PR12MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2db9d8-716f-43a7-1127-08db08de9c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jYmI9wRzIe28Josjt2kG4N3EGz1QrQDxMlPOR2A0IcJxCqhMBdXAyeODyKn2XxdnxIpbT5DlSa8orxlvPxnWqsKJNR/Vzo9oXjGxjRh/7/OEAGNoFuCmtlXS4ipTiQj8kZBmt+P9Q8BSpc6B3KaS1JW+mPdvtVqG95CxdGUMX//vzhxlQ54W1Mlri68Gv89ZDqlNxUgxfp0jP6gt5P0LKmIvdl12Zfs4Osnzv002LEe53H363u0eqZfFIiO7evWrrTVe2eTqcgxPyiniwF/Qx0pfTj3xyteOo/5pUzgZb3yup5zxhGRTbCcQeZw37sZyFfgW8ot92rk3VPvjcqPZStrqlOZGWyMIog42Dc5pX4WQD95/aDnSSnyDmcR+wzOZf9YRFaPTbrdL1CMcwiBQG4MGiAX9ZwoDQTUk0gxdx8KXgThA3Hv3T/AFXuXMRPnHYRmXZXdzP61QcNCh92APFatz0fhXkXTZW74iLSsibN9ELbK29DZo4a6dMqCRaoYQFO+FePJjPuQaFUy2GFnG6roITsR75K67EZ0vQ2O3uRnVN0xSFasBfrrWcu0DKxCZ3eMdoXncRSUlFmV1RroSyKML/arD7X/xFyBJuPoLxwK44neVnKqnpB8fW+Rp0QcA7z6A21NHoq1SlgZ4qEuhbr1eQTkgAWuGiHDe0SJdNsDgzMc7aM4sRf0S92p1nEnK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199018)(6666004)(186003)(6506007)(31686004)(26005)(53546011)(6512007)(38100700002)(2616005)(66574015)(83380400001)(66899018)(6486002)(478600001)(4326008)(8676002)(316002)(66476007)(66556008)(86362001)(41300700001)(8936002)(30864003)(5660300002)(44832011)(36756003)(31696002)(2906002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3dUd2xMSFl1Qm05T1ZqT04wQnVmdWxTUFJ2OXAzVGdrdHE5L2pybFROREwy?=
 =?utf-8?B?YnBvTW8ybmV3ZzdFeENQbXhnTmprR01uSVI3dzZkWldTeGJKaWFJSTE3K2Ny?=
 =?utf-8?B?dDc1d0tPeDJRNkdjOEkzWXBabWdOdDBIWm1OQVB5Q0VDT2kvSk9jWTYxQno2?=
 =?utf-8?B?OFlZYXoxSEhuTWxRSXc1cFJqUFVnektDbmw1VExNbFNDUkxOY3ljOW1UMG9v?=
 =?utf-8?B?aDRTNlZvWW15cHU4YXNrMGVhT1labEVXQ2hlV3FSdG40WUhzdGRPNXZDTFlG?=
 =?utf-8?B?UnFOYk43ZHNsL0t3clNqZzY0Rzh1cGdwM1lhTG5Ib1hKeEVIRTZrNURYbTVU?=
 =?utf-8?B?c1pjM1I3M2s0dlpzWVpVRXMxQ3dWWWNkK2EzTVZIbmo5VGhvcjVDYnNHV3Bj?=
 =?utf-8?B?L1BweG5TZTJHdmZUSFdpK3pMU0pSdGZyTFhZdFR4WHJqMGZrVTQwOHZGRVh2?=
 =?utf-8?B?em5DNUpCeUoyYkJhczhZalUreFBHRkU0UVMxc21MNG5Rczc3YTdLYkxqT1Zk?=
 =?utf-8?B?T3ZIVnNqWHp0dlZOV2tLazVieUtDQ1BBUmxyM04yVDJ2cFNlTng3aDVZcnpo?=
 =?utf-8?B?STJaMkY5T3E4WmRPRHBkOXlRSzhBS2hTbFdlcm8wa2RjVmdTZG1xMldmNDZt?=
 =?utf-8?B?ZFVCbm1xZmhOdnUycFBjSVVrT2ZINVFPSzlQd0lyRHFFM01XWVlrb0tXTFR5?=
 =?utf-8?B?L0pjVkZKNXJJY01TMCtHUW5SV2NPbTluNEpGeWYwSHJHVlRhZ3pOMnhyZGRi?=
 =?utf-8?B?VDFwT3ZVVUJHT3pmb3ZvbHdhMjNDMGkrM0I1RkJnM1FFSWtEaVNpQVdCNmxL?=
 =?utf-8?B?YTdsMjRIb2o1b2N6ajcvUW1EM3c0RDdKMjhWKzhQWU01eTNQMmJBWSt4YUFJ?=
 =?utf-8?B?U1g4bExWWTRzQjVKS0U2RUloMS9NTTBIbC9JaEE4M2dOdisrQmtINHFBVE1Z?=
 =?utf-8?B?UnRqNEZXcWVkSmtKMVdDNmFQN0FQa0ZMd0hIclZYNzdvU0VYaUtCSzN2REx6?=
 =?utf-8?B?UnYwdHN6UXVzUU82QTRGNmdENHRhRnNUYmhmTDJqdzZUNzRyeTdGeERwL0Np?=
 =?utf-8?B?eTRKV1pCMUxETERxQUtIc3BDUlZKOHpxV0lmWjRreG4rZTVadnlLMU85RDhI?=
 =?utf-8?B?U0ZDUG1DbndlaXRLNER0UHR4SGd5ZTd4Y0hZcTZjVGhsWEVvQy9HSWRZMWNG?=
 =?utf-8?B?WVJWd1dWTlpTd1N1ams2Wi9kNS9OUkgvWHBpenJWYlNWOE9FcDlIcnFyS0Q3?=
 =?utf-8?B?aGRrOTFMMElzbHg5alg2QjNSc0VKTXB5b0VPTExvNjIrZnFYUVhYNjFodkwz?=
 =?utf-8?B?OU5EYzlFQ1RJczlGbmRxL2hOS3ZTZ3dZcHYyS3orUTNuT09EZlgzNngrNEp3?=
 =?utf-8?B?QS96Sjk1QU9KM1pHaUZ4T0JsOWNrZUx0OVdRVlZvR1NETG5reDg0NVpUdkUr?=
 =?utf-8?B?MEYwdFlmd3ZzVHNTaTRmeUdrRGZseWdxbE5kTUpieVNQYzZRZEJzbDZnaTdj?=
 =?utf-8?B?YmJSRWtZcHRzYVljQ0JBTmp4aU5rNytoMnBsaklpbWhtTDBmSHVkbXJ0V05m?=
 =?utf-8?B?eUNBUmxzSkNHVk1qSWdwMDFMQWNvK1pCUm40M29mNll3ekthUGYvWC9HbS96?=
 =?utf-8?B?SnlRRWFOeEJ2Z1MwS2R1Y0pHYVBOUGpjeks1Q25RUnhackZSYyt4Snd4TXpZ?=
 =?utf-8?B?SWZnYVdkN3NXa0ZlN0R5amMrS2ZjODlrUWx0WEZLL0lnMHRZM1B3T3ZuNTV6?=
 =?utf-8?B?VDhpTTJvbGJpQ2lxSEdmODZvdmtsQkFiM1RmRW5JV05CYXQyYW42NTZyMVdM?=
 =?utf-8?B?a1QrVVdwR1F3djFFdmlNVWpEbERTWm15Vm1oSllmSWdwczNoZnM5ekNvZ0h2?=
 =?utf-8?B?U2JodHE3RTMxd0R2SUZQd2crcDI4Q084OE1TU0pzNlNGc1VrZEZxdnlUVDla?=
 =?utf-8?B?bWREUXk4QTlUUkJBNHMrM1RoeURqek5iTy9XQjc1MHRkVTY0SUVZWjJ2VWNv?=
 =?utf-8?B?cnQ1UFRMbU1HN0kvSFM4czdSYUJPdjN3c3BETWpPSVNOeG15UzUvWGUvMlBF?=
 =?utf-8?B?U0VzR2pTaDNEOXhEakY4clU3a3plUjhzdHhWU0dYdm1oSXZaRXlHNjNSWTZm?=
 =?utf-8?Q?ufu5xsFjuV+rH2Wuc5tVDL+tA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2db9d8-716f-43a7-1127-08db08de9c95
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:40:40.8645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvO97jodrLKr+eyrbxICUULXGh8KrxjrTGSlVcmpUSF+OvDPpZdd9M9dNc0Sq03QNqrCmgiU0NsQY95HL54zYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 08:08, Christian König wrote:
> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds skeleton code for usermode queue creation. It
>> typically contains:
>> - A new structure to keep all the user queue data in one place.
>> - An IOCTL function to create/free a usermode queue.
>> - A function to generate unique index for the queue.
>> - A queue context manager in driver private data.
>>
>> V1: Worked on design review comments from RFC patch series:
>> (https://patchwork.freedesktop.org/series/112214/)
>>
>> - Alex: Keep a list of queues, instead of single queue per process.
>> - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 155 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  64 ++++++++
>>   6 files changed, 230 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 798d0e9a60b7..764801cc8203 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -210,6 +210,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>   +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>     ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 6b74df446694..0625d6bdadf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -109,6 +109,7 @@
>>   #include "amdgpu_fdinfo.h"
>>   #include "amdgpu_mca.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_userqueue.h"
>>     #define MAX_GPU_INSTANCE        16
>>   @@ -482,6 +483,7 @@ struct amdgpu_fpriv {
>>       struct mutex        bo_list_lock;
>>       struct idr        bo_list_handles;
>>       struct amdgpu_ctx_mgr    ctx_mgr;
>> +    struct amdgpu_userq_mgr    userq_mgr;
>>   };
>>     int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv 
>> **fpriv);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b4f2d61ea0d5..229976a2d0e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -52,6 +52,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_userqueue.h"
>>     /*
>>    * KMS wrapper.
>> @@ -2748,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] 
>> = {
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, 
>> DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>     static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 7aa7e52ca784..52e61e339a88 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1187,6 +1187,10 @@ int amdgpu_driver_open_kms(struct drm_device 
>> *dev, struct drm_file *file_priv)
>>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>   +    r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> +    if (r)
>> +        DRM_WARN("Can't setup usermode queues, only legacy workload 
>> submission will work\n");
>> +
>>       file_priv->driver_priv = fpriv;
>>       goto out_suspend;
>>   @@ -1254,6 +1258,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>       amdgpu_vm_fini(adev, &fpriv->vm);
>> +    amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>         if (pasid)
>>           amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..d5bc7fe81750
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +
>> +static inline int
>> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, 
>> GFP_KERNEL);
>> +}
>> +
>> +static inline void
>> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int 
>> queue_id)
>> +{
>> +    idr_remove(&uq_mgr->userq_idr, queue_id);
>> +}
>> +
>> +static struct amdgpu_usermode_queue
>> +*amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>
> Please put the * on the previous line, it took me a moment to realize 
> that you not return the queue by value here.
>
Noted,
>> +{
>> +    return idr_find(&uq_mgr->userq_idr, qid);
>> +}
>> +
>> +static int amdgpu_userqueue_create(struct drm_file *filp, union 
>> drm_amdgpu_userq *args)
>> +{
>> +    int r, pasid;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>
> We usually put variables like i and r last. The PCI maintainers even 
> require that you sort the variables in reverse xmas tree.
>
Noted,
>> +
>> +    pasid = vm->pasid;
>> +    if (vm->pasid < 0) {
>> +        DRM_WARN("No PASID info found\n");
>> +        pasid = 0;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        mutex_unlock(&uq_mgr->userq_mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    queue->vm = vm;
>> +    queue->pasid = pasid;
>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->queue_size = mqd_in->queue_size;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->queue_gpu_addr = mqd_in->queue_va;
>> +    queue->flags = mqd_in->flags;
>> +    queue->use_doorbell = true;
>> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
>> +    if (queue->queue_id < 0) {
>> +        DRM_ERROR("Failed to allocate a queue id\n");
>> +        r = queue->queue_id;
>> +        goto free_queue;
>> +    }
>> +
>> +    list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>> +    args->out.q_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int 
>> queue_id)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct amdgpu_usermode_queue *queue;
>> +
>> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
>> +    if (!queue) {
>> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    list_del(&queue->userq_node);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +               struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>> args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct 
>> amdgpu_device *adev)
>> +{
>> +    mutex_init(&userq_mgr->userq_mutex);
>> +    idr_init_base(&userq_mgr->userq_idr, 1);
>> +    INIT_LIST_HEAD(&userq_mgr->userq_list);
>
> Why do you need an extra list when you already have the idr?
>
> Apart from those nit picks looks good to me.
>
The idea was to put all the userq base ptrs in a list, but you are 
right, with IDR we will never need it. I will remove it.

- Shashank

> Christian.
>
>> +    userq_mgr->adev = adev;
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>> +{
>> +    idr_destroy(&userq_mgr->userq_idr);
>> +    mutex_destroy(&userq_mgr->userq_mutex);
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> new file mode 100644
>> index 000000000000..9557588fe34f
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERQUEUE_H_
>> +#define AMDGPU_USERQUEUE_H_
>> +
>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_userq_mgr {
>> +    struct idr userq_idr;
>> +    struct mutex userq_mutex;
>> +    struct list_head userq_list;
>> +    struct amdgpu_device *adev;
>> +};
>> +
>> +struct amdgpu_usermode_queue {
>> +    int        queue_id;
>> +    int        queue_type;
>> +    int        queue_size;
>> +    int        pasid;
>> +    int        doorbell_index;
>> +    int         use_doorbell;
>> +
>> +    uint64_t    wptr_gpu_addr;
>> +    uint64_t    rptr_gpu_addr;
>> +    uint64_t    queue_gpu_addr;
>> +    uint64_t    flags;
>> +
>> +    uint64_t    mqd_gpu_addr;
>> +    void         *mqd_cpu_ptr;
>> +
>> +    struct amdgpu_bo    *mqd_obj;
>> +    struct amdgpu_vm        *vm;
>> +    struct amdgpu_userq_mgr *userq_mgr;
>> +    struct list_head     userq_node;
>> +};
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct 
>> drm_file *filp);
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct 
>> amdgpu_device *adev);
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> +
>> +#endif
>
