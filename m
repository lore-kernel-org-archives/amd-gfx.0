Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E3CC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 15:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944DA10E537;
	Tue,  7 Feb 2023 15:03:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680F10E537
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 15:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRAC6kiD1pXpukMHCibgda7UsjdzhbYqcuX+SXRCElzoKPbpO/sBb18fyEeMAKmt2K8ABMfvsPzlVNY/RIH5NHownv+h+zWVJ5k9hseYPB9Co88Hgt7P4tTHI0Jl12fdwVfOhdmRjtfOhwbOuZYRsA/c2bTGILSQH5A+vfo2m0wNn5xxbK3lzKYUdaR3A7Ijmk86NyabjZAv98CnGgpbBzoK8gAffi9Qenh5ngHQXv7eVnc7Pb6KyAkGwNItiwMdMa7snrMmacSsgUFWzvVCUNgmhKmhvVx3V3hhLHW1UKfYcx95rbOXnsLPuTJhdr6lgO/CkNWHPqMIO5SL0XFmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TC94mAX9dTUgrhFF5CdqWkpfhvswVNpDUIAjgrQ+Js=;
 b=PStUuZCKLHqdD5xMWVEynzpnIfBJ3qlu4POFNzck8kY27A+mB7xzfHbvxgUbqerpjq3lfuv6W1kJAA5BMqlhpVUWRkNlFioGsV8qTLzauNByruklNjPSrkXwwNq0HOJ9q34PIoxxcLhMXpjrksj1JQesegrhyv3alt8tH7dxn06M5DfG6Jk3iXZNesaE9c4h3aLjNYbMcDRwW+6dMbsGIa2MkFemcuuGSIdigwx2O8ftOipfxM8NpwhZvTGhEHUHEErp/ejOb4IgI1WWJffRYllH9L4icHoh+wu2j/rDRTqwXhpnfdSHT90iSVPcn1g1KDH0/nFTJ6Wo1Dsxx1p18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TC94mAX9dTUgrhFF5CdqWkpfhvswVNpDUIAjgrQ+Js=;
 b=nliyLzbIhTV5COLtWcDdIq/Sbh16OZBiBveS/2y3LNcagSN7jAFvUTO6PXJEZ56POQqK7wydIZLdACJrMWtKY/PMjoX2R9ikPrzVdhSGezPo6lYszpcGdns0Gcigq/BX/5KYc7ahzQVJhXZtMtAPNUdPJPvcwibGTrmsOCGK4iU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN0PR12MB5787.namprd12.prod.outlook.com (2603:10b6:208:376::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 15:02:54 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 15:02:53 +0000
Message-ID: <d9c39a2f-7ef3-a733-0ef9-3301baf7a7b7@amd.com>
Date: Tue, 7 Feb 2023 16:02:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/8] drm/amdgpu: add usermode queues
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-3-shashank.sharma@amd.com>
 <CADnq5_PrwDps_LzfyBREk5=JvGfvu11NkePydnPOGjSC6kjmag@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PrwDps_LzfyBREk5=JvGfvu11NkePydnPOGjSC6kjmag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN0PR12MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c24a59-0c99-4628-a86f-08db091c6375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vryCEivL7/CbD38kxv+3700/HtYBnWKBP18NM5HoxdrZbgfOsQ8EG0OuYEQ9fDjZwb0lbqpfwU67WkSYCTcQpzZXMxJ1nyTvyV9y5ViBm/IPF6V0vGPE7MxRaTEpRERbQKwKhORO3ZmVJ2tjNf9NaOSD98soLdBeMijlCw5iPU0GxiOrW/tZ/a1LMRob6hpfnUkpz6BuAo4eED6fAvUIyliktwzayMEStkNgKdgdQ9YAv5KaCvrblRQzjX9ADnlyVkJg7dNNNzXoADZrzLC1qGPRIh3CWuc7nb6qblHUjasHgTOPNrgvoT+L9Gar2IE8/Qa0IV+7hi08U139Hcv4nnRSwiOqkmZfZxRege3TpVcVpI4ht1Pt0YL5NtdUjyakVXNNoVrbhPvhaHUHRQ0wLLYD7f6FwatQiCNjrG+hDb2wYWTNl30ZYNQjTnwUbq0HQeRWirOewzAd/AkYx2BZVGFwe3sBVnTJUj1McukSE8fcV3BrqRuLh1QbvZBDpxlVwwZcBUAZbehdTJXLyy5OUcCX2UzImpF5fxkaBTN6jTkYYQINBYYoDurv+4XhpKAs/CIx5Q5u90Ap/eSKYWuRE3SnU6MULsgVqLfZF+Ivgqw5YGhpQSl6hJ1cQkjjgfGqtB8Q3j+FjnK16Ii+wOhsXriIEpeeaUCX/3ZZ5LeyS9IrFfg8fraXg6wCeGW+D94N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199018)(31686004)(66899018)(478600001)(186003)(26005)(6512007)(6486002)(2906002)(36756003)(316002)(38100700002)(83380400001)(66556008)(6666004)(4326008)(66946007)(44832011)(6916009)(6506007)(53546011)(2616005)(66476007)(8936002)(41300700001)(8676002)(31696002)(30864003)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5sZmdSSGVwMnZZeE5sb0VrL2lBTlhTaFcrUGYxTTEzNDJUcG8ySzhTcVkx?=
 =?utf-8?B?cnBBOVY1eCs5ZnROMTlwVXNVMFdmT3hBMldWTkYwQzN5S25IR3JjcXdCU3FY?=
 =?utf-8?B?WXYwT1VrbHNJaG01REpWM0haU2lEMDdCbW5JR1JyZGNQWTF5Z2NkdFJzTXlN?=
 =?utf-8?B?aHp3d0JCMGJTaXRMNHVEN2VQakVzL3NQY01BeCtrdWtHUHh2c29ZRndBdXNP?=
 =?utf-8?B?Y1dZd0k5dnBhMVJlalNtazR6Nm1RcG01Yys2S3YwVGhrZjFMNkp0cnZRaWZy?=
 =?utf-8?B?ODZBOFhVVXNZZnFHaWZiWEUrS1NqTU0wWUxhWWRnMVBMbWE3ZGsrVWlPYk5t?=
 =?utf-8?B?ZFZpOFVXZUJLZDI2cStEbmpQMGpzQS8zZk5ZbnBzQURONGptTWRVd0ZUOE4y?=
 =?utf-8?B?eVdYZk53bFlVdnF5cW5vRGdZNjlxbWVFb3FCTWptL0EvdEZFOWxnMzA4VnJG?=
 =?utf-8?B?bytoZ0h2VVNsNmhQdFh3cStJeG04QXZJcUFYemtUc2F4amtTNjNDOGthTHl5?=
 =?utf-8?B?ZFhWczZyRzg3MVZ0MDYrK1p4SEZzQzdZdkI4U21GaEZlUXlCYXhtQjVtc3ly?=
 =?utf-8?B?RVVYYzR0Yng1d0x6N0RBQUlsRWNPRFY4b3JuajJOMkZvUE5OR3BYVWp5U0ov?=
 =?utf-8?B?MjRlQnVGRm1TZVAxbjZ2RElSZnpnUXNmQjBQNjBweXZJaXd1aHFWUWVXdTFO?=
 =?utf-8?B?dWZmOG9CUzl1dGNuckNiYXB4S3pKNythNHBNcDkyaEJNOFpXLzBrM0o5TVIy?=
 =?utf-8?B?UGZlTVpvRFh5bTR3NkJ4V0JSZzhvek1zMzlabk8wcXpSR3VkY1dJVEFmcG5C?=
 =?utf-8?B?M2R6dW5wUzg3Rm1VNVl2YmJZMHdpZ1VqaDUzcXNkTURENDNJb2tnaUtBZ25X?=
 =?utf-8?B?NDZYeHNKYWppQlJQT0VHRHFVaFVHdjdtMmdneVFJMGk5Uklwdk15MW9WZWpy?=
 =?utf-8?B?cXhzSHBUSmRmdmlYZTZJWlBELzNjSjRzZVJsbFdxVlJneEZwSnYyMTQ3UmpE?=
 =?utf-8?B?aE1keGoyMzg2K3VuNTkyRWpHd2hzWmMrNGJValMzRitQa3BtZUZNdWhIZmJV?=
 =?utf-8?B?QndqNW9VZTJRbnp2USszVzgrdzNkR29jRitBeXI1U213NDVwMGJzSi9BSFVL?=
 =?utf-8?B?eW9SVG5tS0o0bnN3TGt0T21PS2x4UHkreitYOUs0ZU82cEdEQzlDRVNmUitv?=
 =?utf-8?B?OEIyRTQzR3hoNnQzcGlubWwrdUNIODd1c0VpZE1ocS9QR2NXNDNic1h1U01m?=
 =?utf-8?B?OFN2THhiMmU3c21aOUJldDlPYzlmMHZkclBNaVZkei8wVkd5ZnQ4ZUEyN2Ux?=
 =?utf-8?B?VzZ1NmVxUTQ0OUZ6R3VmRGVpMTdNSjc3TUwxQXZWUWVIbWl5OGtucmhDcG40?=
 =?utf-8?B?Ym5RcVZkaVJZOVo5R0d0Q3VIZEVzS3Qvc0RuUWJNODZlWkR5SWtrSTFzMTkz?=
 =?utf-8?B?eWpEcVk5WnJ4VklsRnpIbUx2OVVyWDRhN08zNTQxaFJ4L09HSy8rYXRqR1BN?=
 =?utf-8?B?OTBFb0JEVVVIWWFaSzltMGxqT0o0ZDFmT0YyNG5yK3p0TGFzenFDd0M0S0pu?=
 =?utf-8?B?bUlvRk44em5JRXBXL2NNaHFId2R4aUEvWjNCV1lmR0ZQWFVzeGJhZnBBY3BH?=
 =?utf-8?B?OGd3c0sxZWYvQmM1WXdVd1FjOFcxM3MxemdXS3R3STM3UXNSTHZDT1cyc3BH?=
 =?utf-8?B?S0E2ZFhYbUR2WmVNTWVLdkpJZXRNRVB5Y3RPaEZnYnlKeXZaRmJnMGJDaEFl?=
 =?utf-8?B?blJTcHZPbDBQV3gzRy9iVytCeS96THZwWDhZNUVpWXkra2k2S2xnZCtWMWMv?=
 =?utf-8?B?K0wrTEllcEIzRE1kVDdxbTdLcWZYWG5WMytzaWt2SWtpTnRmR3B6K1h1ZE1h?=
 =?utf-8?B?V0I4d29tMVRlTU5oWkt4U2pVc08vdDFHOFhjYnJMOGk0TmhUbWZkUGNOQ01N?=
 =?utf-8?B?R2l0UmFEZzB1aDdNaDZnaHBNM0crdVpQWnMvbUxLbnpuYWFYQjI0dVVCd3NN?=
 =?utf-8?B?VUxvQVlGWGxrMTVNVFdaQmo3cWRUZGo4Mk1GR1hDN1N4RFMvN3NzVHhuWUJG?=
 =?utf-8?B?aHF3aENMYi8xb0V6ck5IaUZ0bFdIV0dmTUQrZEZRR2w3UmVUMEcvK29Nb1p1?=
 =?utf-8?Q?7Ct93Wlkfj1cnBztizNZ0jQNm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c24a59-0c99-4628-a86f-08db091c6375
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 15:02:53.8258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCEyMivzZ5kMsdwr2cFK0x2kmYDiTQ+UG/9u3F2OpQVEi6LVzM3j5nFPnkS715VG+006mM++AVHXVXkRB1fDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5787
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
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/02/2023 15:54, Alex Deucher wrote:
> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
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
>>             Don't keep the queue structure in amdgpu_ctx
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 155 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  64 ++++++++
>>   6 files changed, 230 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 798d0e9a60b7..764801cc8203 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -210,6 +210,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>
>> +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>
>>   ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 6b74df446694..0625d6bdadf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -109,6 +109,7 @@
>>   #include "amdgpu_fdinfo.h"
>>   #include "amdgpu_mca.h"
>>   #include "amdgpu_ras.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   #define MAX_GPU_INSTANCE               16
>>
>> @@ -482,6 +483,7 @@ struct amdgpu_fpriv {
>>          struct mutex            bo_list_lock;
>>          struct idr              bo_list_handles;
>>          struct amdgpu_ctx_mgr   ctx_mgr;
>> +       struct amdgpu_userq_mgr userq_mgr;
>>   };
>>
>>   int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index b4f2d61ea0d5..229976a2d0e7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -52,6 +52,7 @@
>>   #include "amdgpu_ras.h"
>>   #include "amdgpu_xgmi.h"
>>   #include "amdgpu_reset.h"
>> +#include "amdgpu_userqueue.h"
>>
>>   /*
>>    * KMS wrapper.
>> @@ -2748,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>          DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index 7aa7e52ca784..52e61e339a88 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1187,6 +1187,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>>
>>          amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>>
>> +       r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
>> +       if (r)
>> +               DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
>> +
>>          file_priv->driver_priv = fpriv;
>>          goto out_suspend;
>>
>> @@ -1254,6 +1258,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>
>>          amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>          amdgpu_vm_fini(adev, &fpriv->vm);
>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>
>>          if (pasid)
>>                  amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..d5bc7fe81750
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,155 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +
>> +static inline int
>> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>> +{
>> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
>> +}
>> +
>> +static inline void
>> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
>> +{
>> +    idr_remove(&uq_mgr->userq_idr, queue_id);
>> +}
>> +
>> +static struct amdgpu_usermode_queue
>> +*amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
>> +{
>> +    return idr_find(&uq_mgr->userq_idr, qid);
>> +}
>> +
>> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>> +{
>> +    int r, pasid;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +
>> +    pasid = vm->pasid;
>> +    if (vm->pasid < 0) {
>> +        DRM_WARN("No PASID info found\n");
>> +        pasid = 0;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        mutex_unlock(&uq_mgr->userq_mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    queue->vm = vm;
>> +    queue->pasid = pasid;
>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->queue_size = mqd_in->queue_size;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->queue_gpu_addr = mqd_in->queue_va;
>> +    queue->flags = mqd_in->flags;
>> +    queue->use_doorbell = true;
> I think we can drop use_doorbell.  All user queues require a doorbell.

Noted,

- Shashank

>
> Alex
>
>> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
>> +    if (queue->queue_id < 0) {
>> +        DRM_ERROR("Failed to allocate a queue id\n");
>> +        r = queue->queue_id;
>> +        goto free_queue;
>> +    }
>> +
>> +    list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>> +    args->out.q_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> +    struct amdgpu_usermode_queue *queue;
>> +
>> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
>> +    if (!queue) {
>> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
>> +        return;
>> +    }
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>> +    list_del(&queue->userq_node);
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +                      struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
>> +{
>> +    mutex_init(&userq_mgr->userq_mutex);
>> +    idr_init_base(&userq_mgr->userq_idr, 1);
>> +    INIT_LIST_HEAD(&userq_mgr->userq_list);
>> +    userq_mgr->adev = adev;
>> +
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>> +{
>> +    idr_destroy(&userq_mgr->userq_idr);
>> +    mutex_destroy(&userq_mgr->userq_mutex);
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> new file mode 100644
>> index 000000000000..9557588fe34f
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -0,0 +1,64 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a
>> + * copy of this software and associated documentation files (the "Software"),
>> + * to deal in the Software without restriction, including without limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
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
>> +       struct idr userq_idr;
>> +       struct mutex userq_mutex;
>> +       struct list_head userq_list;
>> +       struct amdgpu_device *adev;
>> +};
>> +
>> +struct amdgpu_usermode_queue {
>> +       int             queue_id;
>> +       int             queue_type;
>> +       int             queue_size;
>> +       int             pasid;
>> +       int             doorbell_index;
>> +       int             use_doorbell;
>> +
>> +       uint64_t        wptr_gpu_addr;
>> +       uint64_t        rptr_gpu_addr;
>> +       uint64_t        queue_gpu_addr;
>> +       uint64_t        flags;
>> +
>> +       uint64_t        mqd_gpu_addr;
>> +       void            *mqd_cpu_ptr;
>> +
>> +       struct amdgpu_bo        *mqd_obj;
>> +       struct amdgpu_vm        *vm;
>> +       struct amdgpu_userq_mgr *userq_mgr;
>> +       struct list_head        userq_node;
>> +};
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>> +
>> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
>> +
>> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>> +
>> +#endif
>> --
>> 2.34.1
>>
