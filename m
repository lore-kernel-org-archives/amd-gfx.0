Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD1BC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6652010E10A;
	Wed, 30 Nov 2022 00:50:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF25510E10A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:50:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwoGgC3Ab8BYYkwpNvAb1VWrnPX/bM1zHYkLA/AvqGUKaBi8OWbHOPP14RbDPNtgQKy+Jab7Q45whMkwmzr2sY0AUCs8VcTVjnD4H08BHwcXc+wmDVHuYMdPqTm/UQVMneeOHX6PT0pZPZSpUaW/WOVaJvzftmrIv6b20sbye+RUhKb/y/BSPlnC1Lff8b6eRJMeUyCdNxtqGu521DmPmBzoLOQojhM+uuifVjxTD/WC2qTXCKm8XkMnYwOcyAs6dGP0cqmqes5/uxWf8Db935pm+mgtbrDbJTcHuDPr27L4MkiYPYyXXAOhUmuggmFMkk87BcPNO7xwJUCn7eDrog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3K8DxG6jdBlLnr7XJnzX/qFP0DrM6E/JmuJO/zsHF0Y=;
 b=mSEQOw0XFw/jiScQpb6+ieLE5EZQUoVZ/GE90Y5g7entlK3Mly7dReMoSHyU9QquEugsT5jC29RReGbzhfVMcxkBcuSYXVA+GuzFo+ngJnoztr+2HVCSdTF8QnlPVWlu599glUjvAeZ5mlkSog4zjrd6OZAatnF1LFPEVwbNw+4SEPcDEqdFTXUL1CtucAJm+Kkf2w+iKtNwFqr9eNsDX51uPAl2G3ed+cTWJjq6kaFH17UPwgp972gbfa05ZnA1v1rG+vi3HvShhXAGYZ/dtzQh6AGdPXuUOmfqid370FDJPjKBQGuw/bBYxLjxz/MOESGwO4fcze/9IpUuYHx46Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3K8DxG6jdBlLnr7XJnzX/qFP0DrM6E/JmuJO/zsHF0Y=;
 b=CjY8E65LcG8QjG53AXxrI1+eWMVElv76w4CtIp8/w2Yaa4ncOjbRE3JxekRU4a1Va9PU0XOSCRbV7STA/pMZ2C2FVRYOmdaRYZVCPbm3ssP6jZMxWX9tLZGJINMSun3hXF2nrynvykbFVR4S11gHg+CieSSUzhmM/I14ilFDX84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:50:26 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:50:26 +0000
Message-ID: <8fcdbd68-94dc-a25f-6d22-474434d297b5@amd.com>
Date: Tue, 29 Nov 2022 19:50:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 26/29] drm/amdkfd: add debug query exception info operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-26-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-26-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:610:4c::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cf9431-4a11-4f05-be21-08dad26cdea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rf/H2KGb0OsO2iuZlEbbD0iTeEgR+ycNb0Bsh5MJfd+6mgIUkeOXtGNZ+aWE6dXIlLuhLVIvqG2TAk+mVXA4WzWkuP/prs3rUbMEhlrHzNdMtB+TSjLkXskkfZOs1bJN2P/7DMgXWykGNmlLf0stCjJJbk842gI7FGCMs0qfaw+GRy9lO2O0LcNM330abChQO3IE/7cwjtGHLv0DIaL2mZDO3FcSpbnVfzq5s1LcjYiPijNVvqDNfFLANas5Trj7nkAnnbzBaTCPksrT3an473s3sqLzRe+hsDiaWC1AwCWMSFdwEYx3Q716r0i7f4m8a1jKDo42QcyjGs2HBulbI7czj/Tm3CxW4kuG6edL4x9ZCiatBhJzWVrRp8Hh3cxb5lQnZJiVnD0dUTRwqS8Ab0AqCXd9MsXJhoOFlnMpWB647GrKARaT0dO9KzQutZPFnJAWSJzL6tFx5Sm7HQBu+A46WY5kyIW6+CG9JDJ02wV96XUJ5SvxNPs8DfgxTse9qgJ5hob9CEtFLg/wyvtHz9MiXhLQIAKC1/DXo6RoHjx4ezskWzh33AJMr+sCQEWemcBoQ9NTWbgGR9BF0r6GstwH41ue0jKLiyRMmPlD7TAvdWHtDiRW/PjaAcD3JZF1PKThtRkx1ivVpeW6T5mRoWznmzEQjJ4VOHspXQpT+0tS17D/gwwzayg4OL9jsFKUu9I4rB6sngEmPJPasCjqfQOaF7BbFWn26WWl6RCGifU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(6486002)(31696002)(478600001)(36916002)(6506007)(31686004)(44832011)(6512007)(8676002)(36756003)(53546011)(2616005)(186003)(8936002)(26005)(316002)(5660300002)(83380400001)(2906002)(4001150100001)(86362001)(41300700001)(66476007)(66946007)(66556008)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBLejFGdVZxRzdhU0ZhdEpyYnlxdVJIS2JhQUhOaGQwTzNLZW0zQm5OOUkw?=
 =?utf-8?B?TndoY3BwdlJsTmRiNG10VDdoTkZtMzBJalhiVldRY1F2VS9VeHVkcm1oWUR0?=
 =?utf-8?B?KzdmZExlTlZ6VklkYk5lWGV1dG5rMmI2QjhNV1ZlM1hMRm1TV2VXbzdLZnpB?=
 =?utf-8?B?SFM4aVdDTzhuVjlMMlVVWCtlSnpQOWJ6YWlwTWdTUDRVem1GcnU0a2xnMHEw?=
 =?utf-8?B?aXhEWktlN2lxYzFBUEFROWtzWnIrOFBxamcraHNadHpLNytwRm53TmNValFO?=
 =?utf-8?B?UlMwQlhDRjQ0UDc1SzRqRkp1VUpObjJvUTIyNXBNVGtyZXhNSDQ1WnlZeFlR?=
 =?utf-8?B?dGkxNW45THdwbGxpcW01QmM2R1hOd0pKcWgzMVZMNzNhWHVkWTdoUGJ6cmhq?=
 =?utf-8?B?eHBsUTBkQWNmb0pCNjUvRTZ4WFVuUVd6TWh2MUF2eE5ncjFPK3hQRmlZQmE5?=
 =?utf-8?B?WXlleFdObnJhQUgxYzdYUmFCV2RXc3pDWlowNnkvUitOU0g1eXYxb2tSamty?=
 =?utf-8?B?VzJoWXRSNi9EM01iV254aHZLaVhwYWhZOXdSSlVIWnh5ZmpGU1NDcXVPZFl6?=
 =?utf-8?B?ZUE3bGRNTENWU0VSVlRUNXlPcitUVm91RUVsQlpQMjVUWUFjY1NOMnRNU1Rl?=
 =?utf-8?B?b2xtb09KTVNTeHFnRTBKV2srdk52aVF2V3RDSm41Vm1VWFBOUDVzZFhxZXJV?=
 =?utf-8?B?MEVNeUF1b0pkcEllTTl2UitjbU9kMlE2NjZNKzhsT0ltN2NDV3VUUWVHeUNy?=
 =?utf-8?B?UzhrRFZlOU1LaW9yd2ZhRVo2eENxS1JvUVVseTJGQlpBem1xTFh0U1M2REFO?=
 =?utf-8?B?am1heU5qQzNpUWR6KzN2OGY4dm1EWnR0eGhaVTAvVTVIb2VNN1VXcFlwcE9v?=
 =?utf-8?B?U1VLS0lqR2JDVmpJN0RwMkNKNnV6QzRSbXhNN0J5aHlESUx6cG16bGVwWkR6?=
 =?utf-8?B?aGQwaHczUUxTcTlWR2liUWppVTJHbngreFcrTWI1SU8ydVJRSlRmRWR2ZFhH?=
 =?utf-8?B?cUJGcmpaUlIzcnRuYWxMMGR4QmkvdThTeWtYUys0WXBuWHQyQmgwVjF3ckZW?=
 =?utf-8?B?TFZqU3pWWkVnNERiOVk1eWVwNERSRlhvcDVvRHRzVVd3UG1lQXhGVTRpYTBN?=
 =?utf-8?B?UmR5MWxua044N0hFT3NwTVYzdTJVZ1F3RnYwZVBMYU5nTUxBQk12NFFTVnU4?=
 =?utf-8?B?SjlzbUpqWXhmQ1R2T2FkTWI4ZXRwRTJxU2ZNYTEzYWx2R3orTmxrOXAvZVg3?=
 =?utf-8?B?WjU4V2prWlQwVkthamc4ZUhsR0JvMWF1Uy84WTBiRHRNbXNiME95VlFnYS9M?=
 =?utf-8?B?ZHUwWVdwZ3gzenRtZDhQcXRpb3NXdHhTNHlkdnFGeXd2UksvSkRNUE5vUDNh?=
 =?utf-8?B?cFhEYUJCQWFtM0xTNDdxckxpdHZwancwRVRNMXlDV1VvOEpOL0hrRk5KbmFB?=
 =?utf-8?B?aFFUb05EU2xkYkJ4cnAyVXdLUFlVNlZEaXMwM1RPck85aGJaM3lIcldRY3NP?=
 =?utf-8?B?TlRDT0thL1poZ2dBRGdvb1JTNktkQm44bEllaGJ2elNldWtmOGtQWnFpWktB?=
 =?utf-8?B?aW9qbnJ6ODFxMWtYMytpYW5HMGx6U1ZCQ0JGa2xZd3V6ZHUzTG9rUWp6U0Nu?=
 =?utf-8?B?NXBzU3R3L2VDZVNOVUM2YVlyLzhpMDFUS29VWFNmVkFnQlJZTUpWNlh3SGRr?=
 =?utf-8?B?TDJhdVVHdUZjWUR2SmpLeFVsamh4Z1VsMGRaeUFVNjZRb0s2NCtrK3J4eFBk?=
 =?utf-8?B?N09FdFZzRndSZWVKWTY2cHpjRDVmNC8rUldadGdhWE1qQ2QwVVgvdzg4SkZO?=
 =?utf-8?B?Rm42Mm5UOVRLZ3czd2R2SUZPbEtHZ00ybXFVQ2Y1UmZCZ1ZHeGZCSnRibmhD?=
 =?utf-8?B?TWJjTjlYUExtdWd6aGtqb3pEZnQ3S0JoOVJtWnZqSXZqbURTOUQ0SHFOQW14?=
 =?utf-8?B?UEZ1U0VxMjN4QkN5QkhiWmZXbEhuVnVLQUpGVnNQak9SSmhKNVFWQ0FlVHJW?=
 =?utf-8?B?NVZKUFg5N3VyU2tPWGpFTWJxMDQvSm5paUN0b2RRNzl6TXBTQVpIYmgyTnE0?=
 =?utf-8?B?aGpLNGJuL2VnYjlKWkNpKys3QWFFRDE2a0IvbG9WdEdNN3dxKzdZRGM3M2U4?=
 =?utf-8?Q?7F1dhb5v7KU1BEoNqvh9Ys4WH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cf9431-4a11-4f05-be21-08dad26cdea3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:50:26.1638 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBfJ7RMSV4hsX6OKAjYJukdWdlNRasxqe5uWYG/dGh4SXvawVBNRmBYe4vFZ0594+gicfg0r7LSc7EKP2Llu/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615
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
> Allow the debugger to query additional info based on an exception code.
> For device exceptions, it's currently only memory violation information.
> For process exceptions, it's currently only runtime information.
> Queue exception only report the queue exception status.
>
> The debugger has the option of clearing the target exception on query.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 120 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |   6 ++
>   3 files changed, 133 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b918213a0087..2c8f107237ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2953,6 +2953,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				&args->query_debug_event.exception_mask);
>   		break;
>   	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
> +		r = kfd_dbg_trap_query_exception_info(target,
> +				args->query_exception_info.source_id,
> +				args->query_exception_info.exception_code,
> +				args->query_exception_info.clear_exception,
> +				(void __user *)args->query_exception_info.info_ptr,
> +				&args->query_exception_info.info_size);
> +		break;
>   	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
>   	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
>   		pr_warn("Debug op %i not supported yet\n", args->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 6985a53b83e9..a05fe32eac0e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -768,6 +768,126 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
>   	return r;
>   }
>   
> +int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
> +		uint32_t source_id,
> +		uint32_t exception_code,
> +		bool clear_exception,
> +		void __user *info,
> +		uint32_t *info_size)
> +{
> +	bool found = false;
> +	int r = 0;
> +	uint32_t copy_size, actual_info_size = 0;
> +	uint64_t *exception_status_ptr = NULL;
> +
> +	if (!target)
> +		return -EINVAL;
> +
> +	if (!info || !info_size)
> +		return -EINVAL;
> +
> +	mutex_lock(&target->event_mutex);
> +
> +	if (KFD_DBG_EC_TYPE_IS_QUEUE(exception_code)) {
> +		/* Per queue exceptions */
> +		struct queue *queue = NULL;
> +		int i;
> +		
> +		for (i = 0; i < target->n_pdds; i++) {
> +			struct kfd_process_device *pdd = target->pdds[i];
> +			struct qcm_process_device *qpd = &pdd->qpd;
> +
> +			list_for_each_entry(queue, &qpd->queues_list, list) {
> +				if (!found && queue->properties.queue_id == source_id) {
> +					found = true;
> +					break;
> +				}
> +			}
> +			if (found)
> +				break;
> +		}
> +
> +		if (!found) {
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!(queue->properties.exception_status & KFD_EC_MASK(exception_code))) {
> +			r = -ENODATA;
> +			goto out;
> +		}
> +		exception_status_ptr = &queue->properties.exception_status;
> +	} else if (KFD_DBG_EC_TYPE_IS_DEVICE(exception_code)) {
> +		/* Per device exceptions */
> +		struct kfd_process_device *pdd = NULL;
> +		int i;
> +
> +		for (i = 0; i < target->n_pdds; i++) {
> +			pdd = target->pdds[i];
> +			if (pdd->dev->id == source_id) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!(pdd->exception_status & KFD_EC_MASK(exception_code))) {
> +			r = -ENODATA;
> +			goto out;
> +		}
> +
> +		if (exception_code == EC_DEVICE_MEMORY_VIOLATION) {
> +			copy_size = min((size_t)(*info_size), pdd->vm_fault_exc_data_size);
> +
> +			if (copy_to_user(info, pdd->vm_fault_exc_data, copy_size)) {
> +				r = -EFAULT;
> +				goto out;
> +			}
> +			actual_info_size = pdd->vm_fault_exc_data_size;
> +			if (clear_exception) {
> +				kfree(pdd->vm_fault_exc_data);
> +				pdd->vm_fault_exc_data = NULL;
> +				pdd->vm_fault_exc_data_size = 0;
> +			}
> +		}
> +		exception_status_ptr = &pdd->exception_status;
> +	} else if (KFD_DBG_EC_TYPE_IS_PROCESS(exception_code)) {
> +		/* Per process exceptions */
> +		if (!(target->exception_status & KFD_EC_MASK(exception_code))) {
> +			r = -ENODATA;
> +			goto out;
> +		}
> +
> +		if (exception_code == EC_PROCESS_RUNTIME) {
> +			copy_size = min((size_t)(*info_size), sizeof(target->runtime_info));
> +
> +			if (copy_to_user(info, (void *)&target->runtime_info, copy_size)) {
> +				r = -EFAULT;
> +				goto out;
> +			}
> +
> +			actual_info_size = sizeof(target->runtime_info);
> +		}
> +
> +		exception_status_ptr = &target->exception_status;
> +	} else {
> +		pr_debug("Bad exception type [%i]\n", exception_code);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +	*info_size = actual_info_size;
> +	if (clear_exception)
> +		*exception_status_ptr &= ~KFD_EC_MASK(exception_code);
> +out:
> +	mutex_unlock(&target->event_mutex);
> +	return r;
> +}
> +
>   void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
>   					uint64_t exception_set_mask)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index c64ffd3efc46..58a5f14d1258 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -63,6 +63,12 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
>   					uint32_t *watch_id,
>   					uint32_t watch_mode);
>   int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
> +int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
> +		uint32_t source_id,
> +		uint32_t exception_code,
> +		bool clear_exception,
> +		void __user *info,
> +		uint32_t *info_size);
>   int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
>   					unsigned int dev_id,
>   					unsigned int queue_id,
