Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01B7C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19D5D10E4C2;
	Wed, 23 Nov 2022 01:44:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEAE10E4C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alge/k3f/p5BF3hs/F5E/zoXAqX1FSFTewcALzsjWtvXE+xuOY1JduB+wxWwOjStGf4TCoVgo0Y9wdOGZBAe9AMYUKXOtAHPl156dXXo+/A20UF9oyPVnq7WyX4rdc+fS7Vaai9pftEJ/zLRfarSnsN98GsLbdI1Gc4wV8oOFzfx+7hnrHML3jtOehvUNAYXaFrYS91gz7SKa2CMnZ1MTB/pHAQZ8xUt3pIQbFSZFRDC1AqFC70NPorFrQ0/guIxiM1ZHK41Ww7Dk5FBi7nQDMrclGrWD11UfBMiiR12JMuGRf/7fJ2c9uw4pQJNnuWl3AVEYSpJMcIUjeda1A1aEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjUM9c2m32XNdj2pzlRMrhoUiazcXq9TkCdJXBU265k=;
 b=bYiXBcwHU484FzXCk3bkO/5ZJzIJJ0EoqdRgt27uf2frfC5yCZ/kcNL3CfEs57vcfJjtw98rGHslthKJ7GQHIGNcGQfRT5jFM/DIdK8arGj3EU/vLPNImZd95B61HaUxOLGAvCYKzNEtxD+C94fdmrh1o3E9Gj/tO57abkaY+sHdHiv3Pym0W5xJd/Vkzf+UYxbsiba7tkxV8pjyzYRRPYI6tIMK4togPQsCsRXjQgmvT5Oc8Fx9d+mzvXlKk8ZK+dcoiqtTYPZLApvAKp29QcQFMcjVgX9OuGt3KMP2m4Iezh1WSoqn0DsfTXK0uBRF/XE3E2t9/LH8W2JXD3KjTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjUM9c2m32XNdj2pzlRMrhoUiazcXq9TkCdJXBU265k=;
 b=CHxJzb8L7DyHIDlcCtDQ31PH/x8CrVLaGlHNvYlJEjLsXo673qa6z/ebnVltHZ7PFg97uov4AMzwnVAwQvrhttZuDAMSdw1I1ExIW75klQM3p1INZ0zNYr+rR4S/ybbcvlRDMlfP/gor0jEAviEO7imW5NM91Y08lYusv0anFZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Wed, 23 Nov
 2022 01:44:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:26 +0000
Message-ID: <526b19e9-6f4e-a7d2-9099-f547eb42147b@amd.com>
Date: Tue, 22 Nov 2022 18:05:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 01/29] drm/amdkfd: add debug and runtime enable interface
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
Content-Language: en-US
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0041.namprd02.prod.outlook.com
 (2603:10b6:a03:54::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f45d8c1-4c85-4ece-535d-08daccf440dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lter0P+FEaL4S5vKM7Ibw5mDSAa5T2yMmJQMpa+SSzVTeGRHnbn2faHdNXIUi+mTTM88ssNWhXIX7AMxRMi+6ZXiKR3/Yfjyrp8hUhN1yLu7tuQnQjTP06S+knbE0ofVqVMhENvqfm9tCUFU/Ad4+t0zmT2C8j/iLEwn6B0GvJKMmmTltFtZUvdzNZX+S7MDxuz7do7lPnAi14Aph/qDuF2zRRXoCpBalMfL8dQTXhHeHZ9NEBwblf/YwV77rXw+whReMKMtLCoJEVDmfBCAF6MQfr/q6HNb9JIV7qYDqxaMBH2yfhI9ArJO5gd2Di8pQBOfQ8MSZl02es+I9RO+m8EVfDO5iYsVk66A+z1lLB66o9Fk5W8Tehkk83PuHbBPcUqVjY3lNn4o6cEO1/rkbH0cx4PWDS4zo3XZuZfqFtN6zUsai0cq/NuaaGhtIEsSOmJFCpg6JkSpxZX/QhMXAGtwqvadlny8gDhEzvNkuWgjI+8hTTj5EjNkiF41apoAWJRslV+fG/2xYbXGTeIcmLyA0BemNu0ImZ1Un1Tp7j1QkVSEpWMG6XyRoIyLSWo0yG4hwqPqvlrTh2lg6yIGHxCkc7fiHGEbcnlxcjoQvcDrpefaWoftj6e3nIze6dhFP5tfFUZQqvHXUf8RPhr3CMJbp9mDYDUyFkZK0NIQvW45dYaQuzzj3zCOLTQoYpQBrJKyL2woKXA0i1m9JttAZbWu8sTArP+0SPdF9J6tcfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(6486002)(31686004)(53546011)(86362001)(31696002)(478600001)(6506007)(38100700002)(6666004)(186003)(8936002)(26005)(316002)(36756003)(2616005)(30864003)(41300700001)(8676002)(44832011)(6512007)(66476007)(5660300002)(4001150100001)(83380400001)(66556008)(66946007)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEdubVB0TEJqRFRjd3ppK2lYZEhBaUE3VWlURDUvR1JFK0FmNXE4eHd4UzNq?=
 =?utf-8?B?UXFHaUcvWEVHN1FNL1hpcUNHSFZyNDY3akFWODE5SlhMY1BZV1U0M01KZi82?=
 =?utf-8?B?WWw3SDcyaXY2YmF3UHZkRUhaQlMwcHdRVXFVLzgzbnR1SDh5eUgyOHNWVWpY?=
 =?utf-8?B?cnhseTE5WGRJSFl3WUFzZERBdFdhdnR2NTM1QnFzSmpWNk54WG1vQXlPLzlD?=
 =?utf-8?B?Rko3VHd5VE9weEtKYUNHUVJzdUlwOWp1YTFOd1hZaXhJMG1hUVp6MFpnQ1Ju?=
 =?utf-8?B?bytKcmpiQmI4S3c4N2loRWxrSlFhNytKRkRRYmxFZHNNeXQwVmpzRm5qWEto?=
 =?utf-8?B?THZZb1A2SHRxOXo5YWptZFc3dktDQWtGbVdjT2FOK3lCMWN5dUVTblJ5ZXpj?=
 =?utf-8?B?WFQ2azh2cU14RHNLNVJtUFV2ZkprcFQ0U2lxWmVYMW1POG01cVh5ZWNSVEVE?=
 =?utf-8?B?L1ZSR0NxVDRoOWRkYjVJWHhaZWZJV1FOY0c3RnN0dnVSQ2NDcDJZUjBpTUxZ?=
 =?utf-8?B?MjQxTFM1R2FSOVlPOW1mUW5RVXFVSVB4NCtxak1rRXM2RnZ1bTl1bTBxcXNm?=
 =?utf-8?B?NHV5RHJydXVtRFcyUTB3djlYOEdmOHpXU3VRL3A5TmRtem04dkFnVXpsYkkr?=
 =?utf-8?B?N1ZJREdJTCtGNVNFdVl6aWR2ZHFxOUxEanppdXJWOEoxYTRWM21GOUlKYTFN?=
 =?utf-8?B?YXZiRm4zUFpVMzhyVjdySWRTOHY1QVZKZGdFWGVwL1RUVnB0OFo2dlBlLytm?=
 =?utf-8?B?K1oySWhHNHQvOS9iTkxsS1ErYjZtSUh2NXNKOTRjMVpVendROW9Ud1RxS0l2?=
 =?utf-8?B?OEpENzBhV0k4TVM0aEI0U1BibEN0WG9TdWNzNmpwVzFLakErakNLdGVmdXNj?=
 =?utf-8?B?QVh5ZnBLREk1azhBRk9VS0Y2RDRtdHlUNDlOWnV5WnpCcDN2TzZpRVFmbk0z?=
 =?utf-8?B?UU05eCt3TDBBdkV2cmtibzV1blNBdllnVXJrallaTmNKTGpydFlxMGNianpV?=
 =?utf-8?B?dGlrb3hDdnhCd2tIQjcreUQ1WWtVdEI2dE9YYk93M2xUekVQSGx6aU5QanVY?=
 =?utf-8?B?N3c3bmxHQ01rWHRNbFAxTFAzRW5SdHUxelgwZWkwd2pWYzJ0eThaQXRja2lI?=
 =?utf-8?B?YWNIcU5qVElVVVkzMm0rM21JVklOS0pwcDMrSTJuczRscE1CcmJYRG1YVTI3?=
 =?utf-8?B?TnR5ZmRuV003VDBsS2ZZZjBwanlpNHRFWU9uNExaTHcrK2c4RjMxNEtWWUE4?=
 =?utf-8?B?WlprZ2NnMmkxM3Q1OWgrMjNOcHhGeGljSjNSWnJ6TEhEMmNxK05iUmhlSTAx?=
 =?utf-8?B?VDdpTlFwNURGdGhFZFNENjhyZjJ3dklHelZVdHdHejZkaXB1UXFhbWMxRjZl?=
 =?utf-8?B?WUNFcktTenZ3bnJmeU9CK0Q0K3hvL2sxSVBaQnlzR1hQYWhkTGVPZUt4WUha?=
 =?utf-8?B?NnVVSDhZUTB1YTNCVVcrcW84VXdpNWFWS3dCSzR5N05jQ2Njd3d5b1plVlNm?=
 =?utf-8?B?UWdEUlh1RjRnSUpXMDN2c0dONkJmaEJudzhaWER6TVhXU3NYVkxOTW9rcHlI?=
 =?utf-8?B?T1RYUVh1RzVOT1lPSnkvelduSlhXV1hUTEkyRUtkUEpZNXRjWmtMb0dudTYz?=
 =?utf-8?B?dlhkdXVlc05xc0p2czJFcEhkbUVwWmtVcFc5b2VSUjhZd1lKaDZ3S0ZPZG0w?=
 =?utf-8?B?M2E2QUNBeGkySkVlcmhvcWtuZzFoa1BjYUExSWxKYVR2OXpjWkowNDRRWTlw?=
 =?utf-8?B?TUdzTktJM1FURzMrKzY2SXBzbzlLRVpDcmkyMkVUWGkxcVNPQkhwOVFkYy9U?=
 =?utf-8?B?Rm9WUjY0cVQxNjdHcFBoRHNnOVc2bWU3aktNU2VpZXNkd21GbFRXSDVYNzJ5?=
 =?utf-8?B?L1UyVEI2NkovcWhaSEVQeDZyQW90bVJhUGlmK2EvNE1qaXZkNytmOVEya3l6?=
 =?utf-8?B?eDF1R25KTVJ1bHpFT2hsSHRDNXUvU2hvZXFvOGNaT0ZFSjBicmh3SFZSTmR1?=
 =?utf-8?B?TC8vYmpSZjVVYWZQM21QbForV2JvK0RYSzdaVmJtNjk3QjMrVUljQTZOTXlI?=
 =?utf-8?B?ZGZqQ2Z5dDlwMnRYKy9EK2E0bC94TEtqLzJjVGV4cWlubktJMENIL1pZeFNW?=
 =?utf-8?Q?D+pSnESi+IFLV6GfQXeHx7nKB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f45d8c1-4c85-4ece-535d-08daccf440dd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:26.0554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSy7X2BtNyBAyNfjs+mB7cKWl4SmXn7Vw7N2a15jeyPIWUAzqrSTYnPbnucbqGBN7PImHufHRzCfJ1Siy02bYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-10-31 12:23, Jonathan Kim wrote:
> Introduce the GPU debug operations interface.
>
> For ROCm-GDB to extend the GNU Debugger's ability to inspect the AMD GPU
> instruction set, provide the necessary interface to allow the debugger
> to HW debug-mode set and query exceptions per HSA queue, process or
> device.
>
> The runtime_enable interface coordinates exception handling with the
> HSA runtime.
>
> Usage is available in the kern docs at uapi/linux/kfd_ioctl.h.
>
> v2: add more documentation on semantics and error returns.
> expand kfd_dbg_device_info_entry with new fields.
> update device_snapshot sematics to match queue snapshot semantics

This looks really good. I have 3 more nit-picks inline. Other than that, 
this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Do we have a debugger branch that uses the API yet? We should make this 
public in order to complete this upstream code review.


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 48 ++
> include/uapi/linux/kfd_ioctl.h | 655 ++++++++++++++++++++++-
> 2 files changed, 702 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5feaba6a77de..11a960c83fb2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2644,6 +2644,48 @@ static int kfd_ioctl_criu(struct file *filep, 
> struct kfd_process *p, void *data)
> return ret;
> }
> +static int kfd_ioctl_runtime_enable(struct file *filep, struct 
> kfd_process *p, void *data)
> +{
> + return 0;
> +}
> +
> +static int kfd_ioctl_set_debug_trap(struct file *filep, struct 
> kfd_process *p, void *data)
> +{
> + struct kfd_ioctl_dbg_trap_args *args = data;
> + int r = 0;
> +
> + if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
> + pr_err("Debugging does not support sched_policy %i", sched_policy);
> + return -EINVAL;
> + }
> +
> + switch (args->op) {
> + case KFD_IOC_DBG_TRAP_ENABLE:
> + case KFD_IOC_DBG_TRAP_DISABLE:
> + case KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT:
> + case KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED:
> + case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE:
> + case KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE:
> + case KFD_IOC_DBG_TRAP_SUSPEND_QUEUES:
> + case KFD_IOC_DBG_TRAP_RESUME_QUEUES:
> + case KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH:
> + case KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH:
> + case KFD_IOC_DBG_TRAP_SET_FLAGS:
> + case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
> + case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
> + case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
> + case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
> + pr_warn("Debugging not supported yet\n");
> + r = -EACCES;
> + break;
> + default:
> + pr_err("Invalid option: %i\n", args->op);
> + r = -EINVAL;
> + }
> +
> + return r;
> +}
> +
> #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
> [_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
> .cmd_drv = 0, .name = #ioctl}
> @@ -2753,6 +2795,12 @@ static const struct amdkfd_ioctl_desc 
> amdkfd_ioctls[] = {
> AMDKFD_IOCTL_DEF(AMDKFD_IOC_AVAILABLE_MEMORY,
> kfd_ioctl_get_available_memory, 0),
> +
> + AMDKFD_IOCTL_DEF(AMDKFD_IOC_RUNTIME_ENABLE,
> + kfd_ioctl_runtime_enable, 0),
> +
> + AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
> + kfd_ioctl_set_debug_trap, 0),
> };
> #define AMDKFD_CORE_IOCTL_COUNT ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/include/uapi/linux/kfd_ioctl.h 
> b/include/uapi/linux/kfd_ioctl.h
> index 42b60198b6c5..bedf1b823f57 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -109,6 +109,28 @@ struct kfd_ioctl_get_available_memory_args {
> __u32 pad;
> };
> +struct kfd_dbg_device_info_entry {
> + __u64 exception_status;
> + __u64 lds_base;
> + __u64 lds_limit;
> + __u64 scratch_base;
> + __u64 scratch_limit;
> + __u64 gpuvm_base;
> + __u64 gpuvm_limit;
> + __u32 gpu_id;
> + __u32 location_id;
> + __u32 vendor_id;
> + __u32 device_id;
> + __u32 fw_version;
> + __u32 gfx_target_version;
> + __u32 simd_count;
> + __u32 max_waves_per_simd;
> + __u32 array_count;
> + __u32 simd_arrays_per_engine;
> + __u32 capability;
> + __u32 debug_prop;
> +};
> +
> /* For kfd_ioctl_set_memory_policy_args.default_policy and 
> alternate_policy */
> #define KFD_IOC_CACHE_POLICY_COHERENT 0
> #define KFD_IOC_CACHE_POLICY_NONCOHERENT 1
> @@ -766,6 +788,631 @@ struct kfd_ioctl_set_xnack_mode_args {
> __s32 xnack_enabled;
> };
> +/* Wave launch override modes */
> +enum kfd_dbg_trap_override_mode {
> + KFD_DBG_TRAP_OVERRIDE_OR = 0,
> + KFD_DBG_TRAP_OVERRIDE_REPLACE = 1
> +};
> +
> +/* Wave launch overrides */
> +enum kfd_dbg_trap_mask {
> + KFD_DBG_TRAP_MASK_FP_INVALID = 1,
> + KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL = 2,
> + KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO = 4,
> + KFD_DBG_TRAP_MASK_FP_OVERFLOW = 8,
> + KFD_DBG_TRAP_MASK_FP_UNDERFLOW = 16,
> + KFD_DBG_TRAP_MASK_FP_INEXACT = 32,
> + KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO = 64,
> + KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH = 128,
> + KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION = 256
> +};
> +
> +/* Wave launch modes */
> +enum kfd_dbg_trap_wave_launch_mode {
> + KFD_DBG_TRAP_WAVE_LAUNCH_MODE_NORMAL = 0,
> + KFD_DBG_TRAP_WAVE_LAUNCH_MODE_HALT = 1,
> + KFD_DBG_TRAP_WAVE_LAUNCH_MODE_KILL = 2,
> + KFD_DBG_TRAP_WAVE_LAUNCH_MODE_DEBUG = 3,
> + KFD_DBG_TRAP_WAVE_LAUNCH_MODE_STALL = 4
> +};
> +
> +/* Address watch modes */
> +enum kfd_dbg_trap_address_watch_mode {
> + KFD_DBG_TRAP_ADDRESS_WATCH_MODE_READ = 0,
> + KFD_DBG_TRAP_ADDRESS_WATCH_MODE_NONREAD = 1,
> + KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ATOMIC = 2,
> + KFD_DBG_TRAP_ADDRESS_WATCH_MODE_ALL = 3
> +};
> +
> +/* Additional wave settings */
> +enum kfd_dbg_trap_flags {
> + KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP = 1,
> + KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP = 2
> +};
> +
> +/* Trap exceptions */
> +enum kfd_dbg_trap_exception_code {
> + EC_NONE = 0,
> + /* per queue */
> + EC_QUEUE_WAVE_ABORT = 1,
> + EC_QUEUE_WAVE_TRAP = 2,
> + EC_QUEUE_WAVE_MATH_ERROR = 3,
> + EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION = 4,
> + EC_QUEUE_WAVE_MEMORY_VIOLATION = 5,
> + EC_QUEUE_WAVE_APERTURE_VIOLATION = 6,
> + EC_QUEUE_PACKET_DISPATCH_DIM_INVALID = 16,
> + EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID = 17,
> + EC_QUEUE_PACKET_DISPATCH_CODE_INVALID = 18,
> + EC_QUEUE_PACKET_RESERVED = 19,
> + EC_QUEUE_PACKET_UNSUPPORTED = 20,
> + EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID = 21,
> + EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID = 22,
> + EC_QUEUE_PACKET_VENDOR_UNSUPPORTED = 23,
> + EC_QUEUE_PREEMPTION_ERROR = 30,
> + EC_QUEUE_NEW = 31,
> + /* per device */
> + EC_DEVICE_QUEUE_DELETE = 32,
> + EC_DEVICE_MEMORY_VIOLATION = 33,
> + EC_DEVICE_RAS_ERROR = 34,
> + EC_DEVICE_FATAL_HALT = 35,
> + EC_DEVICE_NEW = 36,
> + /* per process */
> + EC_PROCESS_RUNTIME = 48,
> + EC_PROCESS_DEVICE_REMOVE = 49,
> + EC_MAX
> +};
> +
> +/* Mask generated by ecode in kfd_dbg_trap_exception_code */
> +#define KFD_EC_MASK(ecode) (1ULL << (ecode - 1))
> +
> +/* Masks for exception code type checks below */
> +#define KFD_EC_MASK_QUEUE (KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) | \
> + KFD_EC_MASK(EC_QUEUE_WAVE_TRAP) | \
> + KFD_EC_MASK(EC_QUEUE_WAVE_MATH_ERROR) | \
> + KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION) | \
> + KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION) | \
> + KFD_EC_MASK(EC_QUEUE_WAVE_APERTURE_VIOLATION) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_DIM_INVALID) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_GROUP_SEGMENT_SIZE_INVALID) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_CODE_INVALID) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_UNSUPPORTED) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) | \
> + KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED) | \
> + KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR) | \
> + KFD_EC_MASK(EC_QUEUE_NEW))
> +#define KFD_EC_MASK_DEVICE (KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) | \
> + KFD_EC_MASK(EC_DEVICE_RAS_ERROR) | \
> + KFD_EC_MASK(EC_DEVICE_FATAL_HALT) | \
> + KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION) | \
> + KFD_EC_MASK(EC_DEVICE_NEW))
> +#define KFD_EC_MASK_PROCESS (KFD_EC_MASK(EC_PROCESS_RUNTIME) | \
> + KFD_EC_MASK(EC_PROCESS_DEVICE_REMOVE))
> +
> +/* Checks for exception code types for KFD search */
> +#define KFD_DBG_EC_TYPE_IS_QUEUE(ecode) \
> + (!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_QUEUE))
> +#define KFD_DBG_EC_TYPE_IS_DEVICE(ecode) \
> + (!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_DEVICE))
> +#define KFD_DBG_EC_TYPE_IS_PROCESS(ecode) \
> + (!!(KFD_EC_MASK(ecode) & KFD_EC_MASK_PROCESS))
> +
> +
> +/* Runtime enable states */
> +enum kfd_dbg_runtime_state {
> + DEBUG_RUNTIME_STATE_DISABLED = 0,
> + DEBUG_RUNTIME_STATE_ENABLED = 1,
> + DEBUG_RUNTIME_STATE_ENABLED_BUSY = 2,
> + DEBUG_RUNTIME_STATE_ENABLED_ERROR = 3
> +};
> +
> +/* Runtime enable status */
> +struct kfd_runtime_info {
> + __u64 r_debug;
> + __u32 runtime_state;
> + __u32 ttmp_setup;
> +};
> +
> +/* Enable modes for runtime enable */
> +#define KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK 1
> +#define KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK 2
> +
> +/**
> + * kfd_ioctl_runtime_enable_args - Arguments for runtime enable
> + *
> + * Coordinates debug exception signalling and debug device enablement 
> with runtime.
> + *
> + * @r_debug - pointer to user struct for sharing information between 
> ROCr and the debuggger
> + * @mode_mask - mask to set mode
> + * KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK - enable runtime for 
> debugging, otherwise disable
> + * KFD_RUNTIME_ENABLE_MODE_TTMP_SAVE_MASK - enable trap temporary 
> setup (ignore on disable)
> + *
> + * Return - 0 on SUCCESS.
> + * - EBUSY if runtime enable call already pending.
> + * - EEXIST if user queues already active prior to call.
> + * If process is debug enabled, runtime enable will enable debug 
> devices and
> + * wait for debugger process to send runtime exception EC_PROCESS_RUNTIME
> + * to unblock - see kfd_ioctl_dbg_trap_args.
> + *
> + */
> +struct kfd_ioctl_runtime_enable_args {
> + __u64 r_debug;
> + __u32 mode_mask;
> +};
> +
> +/* Queue information */
> +struct kfd_queue_snapshot_entry {
> + __u64 exception_status;
> + __u64 ring_base_address;
> + __u64 write_pointer_address;
> + __u64 read_pointer_address;
> + __u64 ctx_save_restore_address;
> + __u32 queue_id;
> + __u32 gpu_id;
> + __u32 ring_size;
> + __u32 queue_type;
> + __u32 ctx_save_restore_area_size;
> + __u32 reserved;
> +};
> +
> +/* Queue status return for suspend/resume */
> +#define KFD_DBG_QUEUE_ERROR_BIT 30
> +#define KFD_DBG_QUEUE_INVALID_BIT 31
> +#define KFD_DBG_QUEUE_ERROR_MASK (1 << KFD_DBG_QUEUE_ERROR_BIT)
> +#define KFD_DBG_QUEUE_INVALID_MASK (1 << KFD_DBG_QUEUE_INVALID_BIT)
> +
> +/* Context save area header information */
> +struct kfd_context_save_area_header {
> + __u32 control_stack_offset;
> + __u32 control_stack_size;
> + __u32 wave_state_offset;
> + __u32 wave_state_size;
> + __u32 debug_offset;
> + __u32 debug_size;
> + __u64 err_payload_addr;
> + __u32 err_event_id;
> + __u32 reserved1;
> +};
> +
> +/*
> + * Debug operations
> + *
> + * For specifics on usage and return values, see documentation per 
> operation
> + * below. Otherwise, generic error returns apply:
> + * - ESRCH if the process to debug does not exist.
> + *
> + * - EINVAL (with KFD_IOC_DBG_TRAP_ENABLE exempt) if operation
> + * KFD_IOC_DBG_TRAP_ENABLE has not succeeded prior.
> + * Also returns this error if GPU hardware scheduling is not supported.
> + *
> + * - EPERM (with KFD_IOC_DBG_TRAP_DISABLE exempt) if target process 
> is not
> + * PTRACE_ATTACHED. KFD_IOC_DBG_TRAP_DISABLE is exempt to allow
> + * clean up of debug mode as long as process is debug enabled.
> + *
> + * - EACCES if any DBG_HW_OP (debug hardware operation) is requested when
> + * AMDKFD_IOC_RUNTIME_ENABLE has not succeeded prior.
> + *
> + * - ENODEV if any GPU does not support debugging on a DBG_HW_OP call.
> + *
> + * - Other errors may be returned when a DBG_HW_OP occurs while the GPU
> + * is in a fatal state.
> + *
> + */
> +enum kfd_dbg_trap_operations {
> + KFD_IOC_DBG_TRAP_ENABLE = 0,
> + KFD_IOC_DBG_TRAP_DISABLE = 1,
> + KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT = 2,
> + KFD_IOC_DBG_TRAP_SET_EXCEPTIONS_ENABLED = 3,
> + KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE = 4, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE = 5, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_SUSPEND_QUEUES = 6, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_RESUME_QUEUES = 7, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH = 8, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH = 9, /* DBG_HW_OP */
> + KFD_IOC_DBG_TRAP_SET_FLAGS = 10,
> + KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT = 11,
> + KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO = 12,
> + KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT = 13,
> + KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT = 14
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_enable_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_ENABLE.
> + *
> + * Enables debug session for target process. Call @op 
> KFD_IOC_DBG_TRAP_DISABLE in
> + * kfd_ioctl_dbg_trap_args to disable debug session.
> + *
> + * @exception_mask (IN) - exceptions to raise to the debugger
> + * @rinfo_ptr (IN) - pointer to runtime info buffer (see 
> kfd_runtime_info)
> + * @rinfo_size (IN/OUT) - size of runtime info buffer in bytes
> + * @dbg_fd (IN) - fd the KFD will nofify the debugger with of raised
> + * exceptions set in exception_mask.
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * Copies KFD saved kfd_runtime_info to @rinfo_ptr on enable.
> + * Size of kfd_runtime saved by the KFD returned to @rinfo_size.
> + * - EBADF if KFD cannot get a reference to dbg_fd.
> + * - EFAULT if KFD cannot copy runtime info to rinfo_ptr.
> + * - EINVAL if target process is already debug enabled.
> + *
> + */
> +struct kfd_ioctl_dbg_trap_enable_args {
> + __u64 exception_mask;
> + __u64 rinfo_ptr;
> + __u32 rinfo_size;
> + __u32 dbg_fd;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_send_runtime_event_args
> + *
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SEND_RUNTIME_EVENT.
> + * Raises exceptions to runtime.
> + *
> + * @exception_mask (IN) - exceptions to raise to runtime
> + * @gpu_id (IN) - target device id
> + * @queue_id (IN) - target queue id
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * - ENODEV if gpu_id not found.
> + * If exception_mask contains EC_PROCESS_RUNTIME, unblocks pending
> + * AMDKFD_IOC_RUNTIME_ENABLE call - see kfd_ioctl_runtime_enable_args.
> + * All other exceptions are raised to runtime through err_payload_addr.
> + * See kfd_context_save_area_header.
> + */
> +struct kfd_ioctl_dbg_trap_send_runtime_event_args {
> + __u64 exception_mask;
> + __u32 gpu_id;
> + __u32 queue_id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_exceptions_enabled_args
> + *
> + * Arguments for KFD_IOC_SET_EXCEPTIONS_ENABLED
> + * Set new exceptions to be raised to the debugger.
> + *
> + * @exception_mask (IN) - new exceptions to raise the debugger
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + */
> +struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args {
> + __u64 exception_mask;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_wave_launch_override_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_OVERRIDE
> + * Enable HW exceptions to raise trap.
> + *
> + * @override_mode (IN) - see kfd_dbg_trap_override_mode
> + * @enable_mask (IN/OUT) - reference kfd_dbg_trap_mask.
> + * IN is the override modes requested to be enabled.
> + * OUT is referenced in Return below.
> + * @support_request_mask (IN/OUT) - reference kfd_dbg_trap_mask.
> + * IN is the override modes requested for support check.
> + * OUT is referenced in Return below.
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * Previous enablement is returned in @enable_mask.
> + * Actual override support is returned in @support_request_mask.
> + * - EINVAL if override mode is not supported.
> + * - EACCES if trap support requested is not actually supported.
> + * i.e. enable_mask (IN) is not a subset of support_request_mask (OUT).
> + * Otherwise it is considered a generic error (see 
> kfd_dbg_trap_operations).
> + */
> +struct kfd_ioctl_dbg_trap_set_wave_launch_override_args {
> + __u32 override_mode;
> + __u32 enable_mask;
> + __u32 support_request_mask;
> + __u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_wave_launch_mode_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SET_WAVE_LAUNCH_MODE
> + * Set wave launch mode.
> + *
> + * @mode (IN) - see kfd_dbg_trap_wave_launch_mode
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + */
> +struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args {
> + __u32 launch_mode;
> + __u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_suspend_queues_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SUSPEND_QUEUES
> + * Suspend queues.
> + *
> + * @exception_mask (IN) - raised exceptions to clear
> + * @queue_array_ptr (IN) - pointer to array of queue ids (u32 per 
> queue id)
> + * to suspend
> + * @num_queues (IN) - number of queues to suspend in @queue_array_ptr
> + * @grace_period (IN) - wave time allowance before preemption
> + * per 1K GPU clock cycle unit
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - Number of queues suspended on SUCCESS.
> + * KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK masked
> + * for each queue id in @queue_array_ptr array reports unsuccessful
> + * suspend reason.
> + * KFD_DBG_QUEUE_ERROR_MASK = HW failure.
> + * KFD_DBG_QUEUE_INVALID_MASK = queue does not exist, is new or
> + * is being destroyed.
> + * Destruction of a suspended queue is blocked until the queue is
> + * resumed. This allows the debugger to access queue information and
> + * the its context save area without running into a race condition on
> + * queue destruction.
> + * Automatically copies per queue context save area header information
> + * into the save area base
> + * (see kfd_queue_snapshot_entry and kfd_context_save_area_header).

The last two paragraphs would make more sens as a description above the 
Return statement.


> + */
> +struct kfd_ioctl_dbg_trap_suspend_queues_args {
> + __u64 exception_mask;
> + __u64 queue_array_ptr;
> + __u32 num_queues;
> + __u32 grace_period;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_resume_queues_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_RESUME_QUEUES
> + * Resume queues.
> + *
> + * @queue_array_ptr (IN) - pointer to array of queue ids (u32 per 
> queue id)
> + * to resume
> + * @num_queues (IN) - number of queues to resume in @queue_array_ptr
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - Number of queues resumed on SUCCESS.
> + * KFD_DBG_QUEUE_ERROR_MASK and KFD_DBG_QUEUE_INVALID_MASK mask
> + * for each queue id in @queue_array_ptr array reports unsuccessful
> + * resume reason.
> + * KFD_DBG_QUEUE_ERROR_MASK = HW failure.
> + * KFD_DBG_QUEUE_INVALID_MASK = queue does not exist.
> + */
> +struct kfd_ioctl_dbg_trap_resume_queues_args {
> + __u64 queue_array_ptr;
> + __u32 num_queues;
> + __u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_node_address_watch_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SET_NODE_ADDRESS_WATCH
> + * Sets address watch for device.
> + *
> + * @address (IN) - watch address to set
> + * @mode (IN) - see kfd_dbg_trap_address_watch_mode
> + * @mask (IN) - watch address mask
> + * @gpu_id (IN) - target gpu to set watch point
> + * @id (OUT) - watch id allocated
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * Allocated watch ID returned to @id.
> + * - ENODEV if gpu_id not found.
> + * - ENOMEM if watch IDs can be allocated
> + */
> +struct kfd_ioctl_dbg_trap_set_node_address_watch_args {
> + __u64 address;
> + __u32 mode;
> + __u32 mask;
> + __u32 gpu_id;
> + __u32 id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_clear_node_address_watch_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_CLEAR_NODE_ADDRESS_WATCH
> + * Clear address watch for device.
> + *
> + * @gpu_id (IN) - target device to clear watch point
> + * @id (IN) - allocated watch id to clear
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * - ENODEV if gpu_id not found.
> + * - EINVAL if watch ID has not been allocated.
> + */
> +struct kfd_ioctl_dbg_trap_clear_node_address_watch_args {
> + __u32 gpu_id;
> + __u32 id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_set_flags_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_SET_FLAGS
> + * Sets flags for wave behaviour.
> + *
> + * @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * - EACCESS if any debug device does not allow flag options.
> + */
> +struct kfd_ioctl_dbg_trap_set_flags_args {
> + __u32 flags;
> + __u32 pad;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_query_debug_event_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT
> + *
> + * Find one or more raised exceptions. This function can return multiple
> + * exceptions from a single queue or a single device with one call. 
> To find
> + * all raised exceptions, this function must be called repeatedly 
> until it
> + * returns -EAGAIN. Returned exceptions can optionally be cleared by
> + * setting the corresponding bit in the @exception_mask input parameter.
> + * However, clearing an exception prevents retrieving further information
> + * about it with KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO.
> + *
> + * @exception_mask (IN/OUT) - exception to clear (IN) and raised (OUT)
> + * @gpu_id (OUT) - gpu id of exceptions raised
> + * @queue_id (OUT) - queue id of exceptions raised
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on raised exception found
> + * Raised exceptions found are returned in @exception mask
> + * with reported source id returned in @gpu_id or @queue_id.
> + * - EAGAIN if no raised exception has been found
> + */
> +struct kfd_ioctl_dbg_trap_query_debug_event_args {
> + __u64 exception_mask;
> + __u32 gpu_id;
> + __u32 queue_id;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_query_exception_info_args
> + *
> + * Arguments KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO
> + * Get additional info on raised exception.
> + *
> + * @info_ptr (IN) - pointer to exception info buffer to copy to
> + * @info_size (IN/OUT) - exception info buffer size (bytes)
> + * @source_id (IN) - target gpu or queue id
> + * @exception_code (IN) - target exception
> + * @clear_exception (IN) - clear raised @exception_code exception
> + * (0 = false, 1 = true)
> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * If @exception_code is EC_DEVICE_MEMORY_VIOLATION, copy @info_size(OUT)
> + * bytes of memory exception data to @info_ptr.
> + * If @exception_code is EC_PROCESS_RUNTIME, copy saved
> + * kfd_runtime_info to @info_ptr.
> + * Actual required @info_ptr size (bytes) is returned in @info_size.
> + */
> +struct kfd_ioctl_dbg_trap_query_exception_info_args {
> + __u64 info_ptr;
> + __u32 info_size;
> + __u32 source_id;
> + __u32 exception_code;
> + __u32 clear_exception;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_get_queue_snapshot_args
> + *
> + * Arguments KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT
> + * Get queue information.
> + *
> + * @exception_mask (IN) - exceptions raised to clear
> + * @snapshot_buf_ptr (IN) - queue snapshot entry buffer (see 
> kfd_queue_snapshot_entry)
> + * @num_queues (IN/OUT) - number of queue snapshot entries
> + * The debugger specifies the size of the array allocated in @num_queues.
> + * KFD returns the number of queues that actually existed. If this is
> + * larger than the size specified by the debugger, KFD will not overflow
> + * the array allocated by the debugger.
> + *
> + * @entry_size (IN/OUT) - size per entry in bytes
> + * The debugger specifies sizeof(struct kfd_queue_snapshot_entry) in
> + * @entry_size. KFD returns the number of bytes actually populated per
> + * entry. The debugger should use the KFD_IOCTL_MINOR_VERSION to 
> determine,
> + * which fields in struct kfd_queue_snapshot_entry are valid. This allows
> + * growing the ABI in a backwards compatible manner.

It's worth mentioning that the @entry_size(in) is also used as stride if 
it is larger than the actual kfd_queue_snapshot_entry.


> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * Copies @num_queues(IN) queue snapshot entries of size @entry_size(IN)
> + * into @snapshot_buf_ptr if @num_queues(IN) > 0.
> + * Otherwise return @num_queues(OUT) queue snapshot entries that exist.
> + */
> +struct kfd_ioctl_dbg_trap_queue_snapshot_args {
> + __u64 exception_mask;
> + __u64 snapshot_buf_ptr;
> + __u32 num_queues;
> + __u32 entry_size;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_get_device_snapshot_args
> + *
> + * Arguments for KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT
> + * Get device information.
> + *
> + * @exception_mask (IN) - exceptions raised to clear
> + * @snapshot_buf_ptr (IN) - pointer to snapshot buffer (see 
> kfd_dbg_device_info_entry)
> + * @num_devices (IN/OUT) - number of debug devices to snapshot
> + * The debugger specifies the size of the array allocated in 
> @num_devices.
> + * KFD returns the number of devices that actually existed. If this is
> + * larger than the size specified by the debugger, KFD will not overflow
> + * the array allocated by the debugger.
> + *
> + * @entry_size (IN/OUT) - size per entry in bytes
> + * The debugger specifies sizeof(struct kfd_dbg_device_info_entry) in
> + * @entry_size. KFD returns the number of bytes actually populated. The
> + * debugger should use KFD_IOCTL_MINOR_VERSION to determine, which fields
> + * in struct kfd_dbg_device_info_entry are valid. This allows growing the
> + * ABI in a backwards compatible manner.

It's worth mentioning that the @entry_size(in) is also used as stride if 
it is larger than the actual kfd_queue_snapshot_entry.

Regards,
   Felix


> + *
> + * Generic errors apply (see kfd_dbg_trap_operations).
> + * Return - 0 on SUCCESS.
> + * Copies @num_devices(IN) device snapshot entries of size 
> @entry_size(IN)
> + * into @snapshot_buf_ptr if @num_devices(IN) > 0.
> + * Otherwise return @num_devices(OUT) queue snapshot entries that exist.
> + */
> +struct kfd_ioctl_dbg_trap_device_snapshot_args {
> + __u64 exception_mask;
> + __u64 snapshot_buf_ptr;
> + __u32 num_devices;
> + __u32 entry_size;
> +};
> +
> +/**
> + * kfd_ioctl_dbg_trap_args
> + *
> + * Arguments to debug target process.
> + *
> + * @pid - target process to debug
> + * @op - debug operation (see kfd_dbg_trap_operations)
> + *
> + * @op determines which union struct args to use.
> + * Refer to kern docs for each kfd_ioctl_dbg_trap_*_args struct.
> + */
> +struct kfd_ioctl_dbg_trap_args {
> + __u32 pid;
> + __u32 op;
> +
> + union {
> + struct kfd_ioctl_dbg_trap_enable_args enable;
> + struct kfd_ioctl_dbg_trap_send_runtime_event_args send_runtime_event;
> + struct kfd_ioctl_dbg_trap_set_exceptions_enabled_args 
> set_exceptions_enabled;
> + struct kfd_ioctl_dbg_trap_set_wave_launch_override_args launch_override;
> + struct kfd_ioctl_dbg_trap_set_wave_launch_mode_args launch_mode;
> + struct kfd_ioctl_dbg_trap_suspend_queues_args suspend_queues;
> + struct kfd_ioctl_dbg_trap_resume_queues_args resume_queues;
> + struct kfd_ioctl_dbg_trap_set_node_address_watch_args 
> set_node_address_watch;
> + struct kfd_ioctl_dbg_trap_clear_node_address_watch_args 
> clear_node_address_watch;
> + struct kfd_ioctl_dbg_trap_set_flags_args set_flags;
> + struct kfd_ioctl_dbg_trap_query_debug_event_args query_debug_event;
> + struct kfd_ioctl_dbg_trap_query_exception_info_args 
> query_exception_info;
> + struct kfd_ioctl_dbg_trap_queue_snapshot_args queue_snapshot;
> + struct kfd_ioctl_dbg_trap_device_snapshot_args device_snapshot;
> + };
> +};
> +
> #define AMDKFD_IOCTL_BASE 'K'
> #define AMDKFD_IO(nr) _IO(AMDKFD_IOCTL_BASE, nr)
> #define AMDKFD_IOR(nr, type) _IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -877,7 +1524,13 @@ struct kfd_ioctl_set_xnack_mode_args {
> #define AMDKFD_IOC_AVAILABLE_MEMORY \
> AMDKFD_IOWR(0x23, struct kfd_ioctl_get_available_memory_args)
> +#define AMDKFD_IOC_RUNTIME_ENABLE \
> + AMDKFD_IOWR(0x24, struct kfd_ioctl_runtime_enable_args)
> +
> +#define AMDKFD_IOC_DBG_TRAP \
> + AMDKFD_IOWR(0x25, struct kfd_ioctl_dbg_trap_args)
> +
> #define AMDKFD_COMMAND_START 0x01
> -#define AMDKFD_COMMAND_END 0x24
> +#define AMDKFD_COMMAND_END 0x26
> #endif
