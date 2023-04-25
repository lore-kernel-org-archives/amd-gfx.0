Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6141DC77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 12:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7EB010E6F7;
	Tue, 25 Apr 2023 12:20:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05B610E6F9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 12:20:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0k1KkQGlIorXIKdVNM8jqAnwhPmfgElQCo7mYTqXoboTbpEixnVezU/yRL6LfXAUm/WWsToOESmPmvmnatgwweJDAI7BPXoDJLTgAlOA/1DMIT1cQGNVMvHvupl5CP/B3cn1DzETJTLOsnn92Gy8R43x5dcO2R1jHFjITdP+Xl+qygkom5IODJz0DJd09nuoJSUH9ginr95rlDw1KGTXpU3RIMXcDEbrj8H5yMdoFSDjXrn2Wkj1UQsybNueAgYBLroVpEnBk7765XavCosNJy93GWf3N40agAuBU7+aN5csuk4GteAeTopAa5dq07h0A8p13kLY2Nc3M7558uH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKtYdxSs2xf7Gzlgndrm1KTZ4uGWwgPHYzAvO/jqD8I=;
 b=GoEtW/SmQ+Gfurs9cI2FzIQEJsem4XpA4uVOtrrdwxrqtlk8DbRPxMBTnYgtdF9nVjbwxuAg5+LIvV9+kRtae4AqPuKzmjoQ2Px/mTc5e1IxF9Pf+JYtxExNx6F/8R3N6PuaDmOPTLC6gpmkw2Owq+TfX9atXWJvHp3wl9+V4730jEpR8U1mZ6xtkUbCBhPALrvyvP/a0eARKE6eNrNF7SBFNTC5l+Mj9pME5OCmTep5L6kKcDE69wid4xtokzcDDH2syOtwT33PS1BGbPgLYajvbeJOko9rJlUIbCaZSR8f37m2niQxT5IxD5Dc7Np0dSh6q18PaDavmMe5qVftGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKtYdxSs2xf7Gzlgndrm1KTZ4uGWwgPHYzAvO/jqD8I=;
 b=IZew2e+9s2Ou1PS1kpzC3KUuca722L99yfeBvb2l9mRNPqlNCYk71NZN27JKws60rUK0SSuiPzYDxrdHNAfQQJDjYgKSlDvSWcECKRIeqiww1NXgdHEnanvIQi86s0oZDB+KFnLBVu8MoCryvWgCOIDaJXtDALdi9/p17DfX51M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 12:19:31 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6340.020; Tue, 25 Apr 2023
 12:19:31 +0000
Message-ID: <198cc925-c265-78c4-ccff-fc2667834311@amd.com>
Date: Tue, 25 Apr 2023 14:19:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 02/10] drm/amdgpu: add usermode queue base code
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230424173836.1441-1-shashank.sharma@amd.com>
 <20230424173836.1441-3-shashank.sharma@amd.com>
 <ca24f91d-9de9-7434-a6e2-e764f2f9ab34@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <ca24f91d-9de9-7434-a6e2-e764f2f9ab34@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae2d22b-a152-4121-8986-08db4587526d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qw3U1mcZlPdeaHei+6GgGN3pSDfsRDH8uvULv3wzt/NZ8IUKk7BaTwt+xydUVLHQBuVuvXDy4W8WLPQ7D46r3TUy99+N9FjAZ5DuZ0La+WhaqQXcdaJT6K7f1dNwfbdzTt3BasVaoskDxlAKhMIFhga6IOFuwhO2Kpv2y754+H+i9BTL/ec7VTnEN+lGKXsThAZHcWAtkZqAoB4BJEUJqiYQkIdKK/4JXJyEDQBgMa2MZ5f1PE9EmETeZT+qSFL/+ZH7Z6gfa+Vp20cb5ZY/1SkzUjXE6VZomX2kHFORCMBWPXwYWkN+4+tkdsLlb9PIoj4tQhCYHAs8E1w0gyQx1pZg0di6pueCs7az2aQ8fwhzhxyrnHNexcXHgyZyeCuDZ4Dtuzp3QXhTaf2MrMiyLQPDzZOYSWjVCF5JmpiH6BoXVmVm171mNN2pOSstBLdEfweYaPWiFPLqemxL8QyZXwtxPRHQi4OW8ZNhjQ9GDl9B3UM89jAN8/DYXzcz3eCeVICddFEV4OCh2WJVXQNSGcHqBTozY29piJFDteVjUrJwaOEiB0p40E5wCIOgRFnU9n4LEWUlG5DcT0Mjc2MfmMdd+19TFTwkrpXz4ijT9Ws=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(53546011)(6506007)(26005)(6512007)(2616005)(36756003)(83380400001)(66574015)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66556008)(66476007)(31686004)(8676002)(8936002)(44832011)(5660300002)(6486002)(66899021)(41300700001)(2906002)(4326008)(6666004)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pPWEZuMjVFM2lXU2N2VHQ5YXo1THNWdE15RHJ6VXN1SE5yK1B5bWVKcUMv?=
 =?utf-8?B?ZVFvalpFbW4yYlUxTkd5c3FScFRSKzlja3BjR09HVnZGZlhVYUhRWDY5c016?=
 =?utf-8?B?b2oxc2ZINExzZFZvWnU4ZTVZUi9uNTdJdjBqVkVZV0pIU0hDRUJBclZ2WGlm?=
 =?utf-8?B?ZlZ2VFh3SzQvaG1RRUlod0lGMk9selhsUVJxK1o4cC9UU1JlQ1VPNUh6UDlR?=
 =?utf-8?B?bDBHMk9NaFYwNmhucXB3MmRKS0p3VFJDNUFtaFVWaTlRNmw3WWQ5SUQ0MStJ?=
 =?utf-8?B?bnk5VU9waDdmVnpTQjRibFE1RVRBdEZnL2MzeEdnalk3TmdlaWZHMHRvcFE1?=
 =?utf-8?B?a2R4dExXZjQ3WXFsL1VCWVoxNnJLZjA1OW9ETXQzLy94cnJXQysyL2RCTlVw?=
 =?utf-8?B?VGJsOGVsV1p5ejdWeXRGVlBpRzhDekNucUxNb1k4bFVzajRMUXVqQkRYb08z?=
 =?utf-8?B?UkFnd1JIQnY3TVhxcWtIQ2x2L0xRM1VVM1ArYWcvNXhFZDdQOTJSdkF1aEMx?=
 =?utf-8?B?SW9ET3lDRWtNeEJsbnkvM21IYTBCZjRCdGIzSUlpV1hkbDZNRjJQMjFyeHhP?=
 =?utf-8?B?a3gzR09lTGhoc2hENVY1ay9QTU9lT0tjWnk4MWw5SFNvNkljR1BLSmZNelpB?=
 =?utf-8?B?bGhsQ2Nnb0FFNDh4MThpWmJvTVl4L1h4NGxESnR3d085ZXZlNHJkejZSRUJr?=
 =?utf-8?B?V043OTMrUXpOejFiczJTRk5IbWF6dkdpY2ZYd1I4KzBtWnVWNDNiUHdtRE9j?=
 =?utf-8?B?WXg3RmNNREJYS0JoK2pKTjVoU2thTmNRaVlSVnQ1amhNMXptR010bVJIemth?=
 =?utf-8?B?QXdPL3d0N3VoL3Bqb1MxMng4RmtGT2ZYd0dMNExBK2s4dFpyZi9qMVdPSCtH?=
 =?utf-8?B?WkJsOExtZG40Ui85Umt0MzlhbVNhMFlzbEhBcmc4d3k1Q2dWSXp6YWhnWWFL?=
 =?utf-8?B?OUo0eDNRRlljVDN1WUk4a2NMRkEvYjJoZGVGMjFwMHNFUG9uQWxzS3piWXdi?=
 =?utf-8?B?MS9pNXVvZjNhY2l2V2x1MFZWaEdKL3pEKzZaOUwrMHc2eU45YTNhSzZSdFN3?=
 =?utf-8?B?aHAzOTNGenNGUWVqbWpxeFlQc0hvYlZENHhvZWhDeVFxSEV4NFJTR2hxYzhr?=
 =?utf-8?B?VkJic2RNL2hqb24wNkVaTGFqS1BYVlJzdlZZRFJWQmdZNzZWMWUwSDVxWXZB?=
 =?utf-8?B?dUVUM2ZzTUF5Qk5hNzkwbjVrYWRTY3AxSkxhT21Oc05CaS9kYkttajg5Vzdt?=
 =?utf-8?B?Zm55NmF3eDhjVEZob2RzS2tBbjlZSVArNFRTM2Y4RnRPNjNoYnJTL2xtQWxh?=
 =?utf-8?B?em92eEp1emwxOElja3V0TXJJa3NxYVFhdzc3Z1NIYVp2ME9HdlJIVkRoa2Vk?=
 =?utf-8?B?ZWkzbVErVVhEb1hCSUNUNzhNV01mWGU2d2tmVXVCZlB4WWRyT2hLWjZTNHc1?=
 =?utf-8?B?cEwyYWZDclJseEVqMFhVV0wrWlBCR0ZMa096M1JIMU5UTXhadGt0QWhpZlg5?=
 =?utf-8?B?dEFyNkROUU5qMWRrS0dTdTNzcmtKM1Fyc1NiazZibVcraVAxV2h0YVJLc1d2?=
 =?utf-8?B?bE5DcnBCTmMydUJQSHc1TXdES01RRThMNDNVRUdSY2xIRlJWalVRbXozSjl3?=
 =?utf-8?B?QWFzcXErMUdpbHRwNkxYaWdyRGhCTW81NEk5aU5Yajk0SFJ0aXhhQ3pFeEI2?=
 =?utf-8?B?c1FWZlFaQUhqbm83YXc4MDVHeEhMaFJCRklPUWZ3SjJTRGZWcHU0b3dxZ1Q4?=
 =?utf-8?B?bGx6RzR1a1UrTWNHU0dZMTZiVDZqYkF0YmtGelh5YVFTTVJyU2hKTFl5emZy?=
 =?utf-8?B?S3I0dDB6ODBHVXpwUHh1UlhGN1loSTNSSEJMV2ZFZzNqWXZTWVFzUDBYbHYz?=
 =?utf-8?B?T2xoYWxkMXBGczZZcVV1bEtjZnhQa2RDRElmOWtZVHJlZkNUN0NWZGtLdUI5?=
 =?utf-8?B?Sm1Bb2h1OG5YTFEzUjVkWno4cG1BMTl2akxSdyt0cFBvSHVKZVVyS1lhVmd3?=
 =?utf-8?B?QzI3QUd3c3NMcHRzWXVYek80MFdhRlVaR3dyb00yc2pGSENHa0p6U0FxM2Nr?=
 =?utf-8?B?c0V0YlppYzJBV3I0TXluWTJRTWFCYUU2YjRZNGVLd3UzVjhIREhwcDV4MitT?=
 =?utf-8?Q?Gj8C8i+ECAy1cpVCU4dKqB8al?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae2d22b-a152-4121-8986-08db4587526d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 12:19:31.2649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEecbm2P2uGfUzr/A0RODAQ0S7GZ9kFwupBGqblYNF39eXIiPfk5HpNrm1gCIXKu8lxoaL2LiKINHmcwF3zn+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, contactshashanksharma@gmail.com,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the review, Christian.

Inline,

On 25/04/2023 14:03, Christian König wrote:
>
>
> Am 24.04.23 um 19:38 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch adds skeleton code for amdgpu usermode queue. It contains:
>> - A new files with init functions of usermode queues.
>> - A queue context manager in driver private data.
>>
>> V1: Worked on design review comments from RFC patch series:
>> (https://patchwork.freedesktop.org/series/112214/)
>> - Alex: Keep a list of queues, instead of single queue per process.
>> - Christian: Use the queue manager instead of global ptrs,
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> V2:
>>   - Reformatted code, split the big patch into two
>>
>> V3:
>> - Integration with doorbell manager
>>
>> V4:
>> - Align the structure member names to the largest member's column
>>    (Luben)
>> - Added SPDX license (Luben)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 40 +++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 50 +++++++++++++++++++
>>   6 files changed, 108 insertions(+), 1 deletion(-)
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
>> index 6b74df446694..c5f9af0e74ee 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
>>       uint32_t        align;
>>   };
>>   +/* Gfx usermode queues */
>> +struct amdgpu_userq_mgr {
>> +    struct idr userq_idr;
>> +    struct mutex userq_mutex;
>> +    struct amdgpu_device *adev;
>> +    const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>> +};
>> +
>
> Please but that into amdgpu_userqueue.h as well. We want to 
> decommission amdgpu.h over time.
>
Noted,
>>   /* sub-allocation buffer */
>>   struct amdgpu_sa_bo {
>>       struct list_head        olist;
>> @@ -470,7 +478,6 @@ struct amdgpu_flip_work {
>>       bool                async;
>>   };
>>   -
>>   /*
>>    * file private structure
>>    */
>> @@ -482,6 +489,7 @@ struct amdgpu_fpriv {
>>       struct mutex        bo_list_lock;
>>       struct idr        bo_list_handles;
>>       struct amdgpu_ctx_mgr    ctx_mgr;
>> +    struct amdgpu_userq_mgr    userq_mgr;
>>   };
>>     int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv 
>> **fpriv);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b4f2d61ea0d5..2d6bcfd727c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -52,6 +52,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_userqueue.h"
>>     /*
>>    * KMS wrapper.
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 7aa7e52ca784..e1b6e658d51d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -43,6 +43,7 @@
>>   #include "amdgpu_gem.h"
>>   #include "amdgpu_display.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_userqueue.h"
>>     void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>>   {
>> @@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device 
>> *dev, struct drm_file *file_priv)
>>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>   +    r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> +    if (r)
>> +        DRM_WARN("Can't setup usermode queues, use legacy workload 
>> submission only\n");
>> +
>>       file_priv->driver_priv = fpriv;
>>       goto out_suspend;
>>   @@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct 
>> drm_device *dev,
>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>       amdgpu_vm_fini(adev, &fpriv->vm);
>> +    amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>         if (pasid)
>>           amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..effc0c7c02cf
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,40 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
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
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct 
>> amdgpu_device *adev)
>> +{
>> +    mutex_init(&userq_mgr->userq_mutex);
>> +    idr_init_base(&userq_mgr->userq_idr, 1);
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
>> index 000000000000..6fe5d8d73f37
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -0,0 +1,50 @@
>> +/* SPDX-License-Identifier: MIT */
>> +/*
>> + * Copyright 2023 Advanced Micro Devices, Inc.
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
>> +#include "amdgpu.h"
>
> Please don't include amdgpu.h here.
>
> Most structures can be forward defined, only amdgpu_mqd_prop is really 
> needed and that should be included separately.
>
> Christian.
>
Noted, let me try this out.

- Shashank

>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_usermode_queue {
>> +    int            queue_id;
>> +    int            queue_type;
>> +    uint64_t        doorbell_handle;
>> +    uint64_t        flags;
>> +    struct amdgpu_mqd_prop    userq_prop;
>> +    struct amdgpu_userq_mgr *userq_mgr;
>> +    struct amdgpu_vm    *vm;
>> +};
>> +
>> +struct amdgpu_userq_funcs {
>> +    int  (*mqd_create)(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *uq);
>> +    void (*mqd_destroy)(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *uq);
>> +};
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct 
>> amdgpu_device *adev);
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> +
>> +#endif
>
