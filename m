Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2527EC531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 18:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94DEB10E4BF;
	Mon, 27 Jul 2026 18:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eMVPkMXU";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4991510E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 18:32:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa99dgeJfgzx1fv2not/+fLBGFpr0cIxIcR/mIKtJQ1XeREnmBCDBv4DXelIHvA0tUmW2smK22SFQPOpiFy6X9ponbYG52WfFkk7UeElyFHqNeuyyEbjRiMtRHk+cLMQIYL6T8lF1MdgrDidn9ebMEhwMfjId1bLWXsK5OaGtidZhWatXQ7lw9VZ6RuIAlL+/NboVhVW/p8NE/0hVh1jEWl6c2fuCOLMA9f7OwRRnGoEyb5VewcxbDEcI7+ee4YM38V0RpJNuvnbGfPpesYNMYTtLOxNxCys/n680GV5yWaVF1hgTAg31zJlymTMsrR2bOxSgAZ4qcl0g06nHbuQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwLDEMm8g5Kqz+YoELa0fXGDqL4/M9QkTNGMRixpV0I=;
 b=iYwiPp8PbxM1opl3+bxGtjXSuySx2m5NdJ2KTS8R7BvtYC9weInlv9Rbj2iRJ7DbQYNi8KhgfSrKjFqkHmLSZoFbsha1It5gzoDqIbUULGHix1Hx2UcjVOsUKdVCXGdCaPEpUom1rCsPPp/RdYQPgBog4j6Wfm2i42n6Rvi7L8ohcahlbwdiTMJB45TyxFwCA6b+keyEfG+VU7NbWXO4IXVXEbIqHCzmsxRrsBUqKnGHRXg+bbd5rO3SqKFMAObmaS5L1g6mKHSMnnETO8qq7eGxg6dmyhH9a/j3C/HsfMUPUDqyv4WbKC1d8Rw7VWal3aD+Iqth8WgAfcyukUEVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwLDEMm8g5Kqz+YoELa0fXGDqL4/M9QkTNGMRixpV0I=;
 b=eMVPkMXUe+11F6R9Cd0K5OajwlpCrq8xPN9fzUoo/bwjNj4i40zOOTUWixwhttSPJi7vz2g4d2pN5GNjP5+nMAYrpzwVHIg0KWka0h1X+WDKYYgSQA4k4iOlXESbpZX/KfvvVrgLjHEnB4s0jE6fRNLf41d2hP8Y2nYvrKkB++A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 18:32:22 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 18:32:22 +0000
Content-Type: multipart/alternative;
 boundary="------------0qMSi3Htu0fgRc5b4O4Kvzcg"
Message-ID: <30fd1fdb-0a90-4fdf-8d58-967a3da89594@amd.com>
Date: Mon, 27 Jul 2026 14:32:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: Drain retry faults before SVM range
 no-access unmap
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Amir.Shetaia@amd.com, Kent.Russell@amd.com
References: <20260616211652.1962285-1-Philip.Yang@amd.com>
 <20260616211652.1962285-3-Philip.Yang@amd.com>
 <ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com>
X-ClientProxiedBy: YT4PR01CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::25) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 960ea9e6-9a19-434f-8aff-08deec0d65e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: fCnLJJFd4OKOBx1h1eRDO91lD+jyOXpAH07R1+Jpc/i+E7x6H36OQ5aIRHsg2uxFQdHOhnQIRVPimYDFpOQo0QMzaCfKTyrSRTqWrgTP0X1HC5Ymg3gq/dCVB5Pd9DJRSYxioSlCx1BoGdBB9+j1bgE8/ER/APwdqeJRCrwprSpRJWMIPtrkdadl5KyLwkFbvuc0WZeV+PMh/EALux0wmim4BM19nDdGc5bx/OPBvibRLR2tavbMZCDySNbdFIZ+u/yrHkgriF9gu2k/ZjgATK6pIA3CIHBy/QMdb46D8mTR6xvwZbDanheg6Y71QDE64w4KpAAuzQkMx8RsLPhXXoz45nwPz9Xrmgf+pkaTFBjanUrIEEh8WKmoOEVG6nKCss7WBSFCIXy8NRhfE6yhpO/48xBRWDIded6JYuaTT2QVgvTg3y+Xx7AH4mrz5OA8tqX7kVxr1fbu63fNj+fUT8OufKYlpFMRlQw3g4ueKoVmC9bxJHd7H9vviP8QBtUBA4ty6OceDQ9Z76pPV39MR6oCodr1bafFUM6Zzq+1E9lOhByxkmVtUelWy6FssQkb/eH66Nk4SW77wSv4gT3aW38Jl830Bn7RqdW7ak1TYCX5VMGZIX/2/JQ54Nyx98Rq0dtYpdAMKtq8KiJxxBe8HhlmzvEkzEFG97OmPj+hijE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEMwYzZPTFdzbFdSamZFaWZTOWZudEIzTFZUV1NGQUFreE5HNStLZkVzSDRP?=
 =?utf-8?B?dEcxNEZFRTJRSDNLVWU4S3VmV0wxQ3FHOE1YbHBESU12MEtqWmZqVGF4MHho?=
 =?utf-8?B?SllnR3VsdkhmeDJ5UFp1K0JQaHpoN0NjTlJuTkE0QXE1Mlc5MXRmS3BYNEtC?=
 =?utf-8?B?QUhTbkNBd3Z2WkNDSGJ6YWRybVkxcWhMMjlDRDdNaElLZjU5WmJjMklNRTNJ?=
 =?utf-8?B?YXAvc1NhbFZtUTZJQm0xR0xmWWZHMTluU2ZiOTc0VHIxNVNmcDBkZHpIRHcv?=
 =?utf-8?B?amxqU0l3THNOOE5WOGJrRktYLzZsZ2ZZa21yb0h4WmpkMHcxNjFqc25zQnFq?=
 =?utf-8?B?SHN5dzVaK21sS0VxZ0dqTTkxdlBIN25ZOXJPeWcwNzdRaE00UjZDcDdCc3Yr?=
 =?utf-8?B?dDN1R2ZPRUZIYVdxSFFwY0ttUkhmNE5vMlFGaFFlb2VVbDRhRlJDOEQ3ZmU5?=
 =?utf-8?B?R3luRHl1ZTVFNkpKSEQ5cWQvZkN4ZUxvVjRGL0FVWGhLT3gwanJ5U1dLU2wy?=
 =?utf-8?B?NFA5MFp1Q2pWQVpORjFVMnV0YlVzRTk3MXlzdmJWZWtNc3hSR3dMRDJnY2xv?=
 =?utf-8?B?Z3pYdnRWbURDUzQvLzBQRkZWdlpwR0UxRXJjWDNhKzlDSXVWTkFFclJ6bWRz?=
 =?utf-8?B?Rm9zc29UR2l5aDU0TllmUytCWERYN0ZCM3JycGpjSVdSWUdwSHBNKzdxVjBw?=
 =?utf-8?B?bDN4dEttZ3ZQdHhSQ3IyMzYzOThVaFJoTnp4Q2pHSm5ZbjNOWnE0VndUcVZj?=
 =?utf-8?B?eGkzVEtEaDVpNkRWQjBmWXdvbGtiTlZkS3RoL0hTZ1llYjNHTEdDMXBwcHFw?=
 =?utf-8?B?NTgzVktxclVMNXFhNlpmUzMxMXJtR1pwVmNlMmkwclBmV2duMWhQWWk5dlNN?=
 =?utf-8?B?ZjdwZWdMWmNTc1dLUTllQS9HTkhhNHVKQklFS0NsN2p2MHBpdE5UYnVqSktP?=
 =?utf-8?B?aWJzWDdybENxbjY3Uk1zell6UUdyM2phbXJZUHVic2VBOEs5bXkyOGNmbnBX?=
 =?utf-8?B?RkFEd0lxOTI3MkZ6b0R5b3VJaFIyZmNacnBHVy84U3VsMGNBSjdrMElwVHRv?=
 =?utf-8?B?SXk1VXlQNlFjY0VqUy9HQ3B2MXhMdlRLb3VDaGxPYkhGQUtWR3NnSUtHdUJv?=
 =?utf-8?B?eVRiOVVUb3loOXBoN3pFLy9PTTNNTkhvUUcweHJjWGptTklPZEhRN2pTcEVG?=
 =?utf-8?B?NldYNHpGVjJBbUlISVI0S21tVytVRjljYnlteFRLM3JReWhaQlA0OStVWUp0?=
 =?utf-8?B?alhya3JmSHEvTnlLa3RYbEkvRjBKY1FHU1BRUmtURFJpeUE5WHRkZnc4eTJH?=
 =?utf-8?B?LzBRQWdhUWFXR3V5QnFKeEFPaUYyendwRG5FK0xoQnQydDAwb1RtL0lQK2tR?=
 =?utf-8?B?UE9GeEtIODM1dkI3Z3hFbG8xR283WjZKVFU1anRnY1o4aTcyQTgwY3l5Z0Jk?=
 =?utf-8?B?MnpHNWh0V3I0NnBkUWNBSm83ZmlMM2NyQ2xFSUl6ajAxTk1QTFltS0VOM0p6?=
 =?utf-8?B?UUxMaURQZHp4VE1aRGlHS1ZXWWZHak13SlI4SjdQZmZRSmx5bUN4dGdrVkE1?=
 =?utf-8?B?TTJZNmM2VXg2KzBqWnRNTWhvYmRETEp0Rkd6eFVseVZjN1plVnZHNGc0TXVo?=
 =?utf-8?B?Yy8wTEl2L09yK091b3g3OWJGN3VXY3hOQ0J3d2N6ZS9GTkFtSTZ3NFJQckgr?=
 =?utf-8?B?b3lLZ0ZGNVBVSXdXVEdhNmxsc2dSOFJ0N1NINnFTcGx6YUt2b3MzeDBCVkJu?=
 =?utf-8?B?eGRpM04xNWZDSlpxOVoyc2txOW5URkpCMlFXdys4eWV4aHEwd2NUYnhTdGdp?=
 =?utf-8?B?VFhvbFNEcWpyVzhaelY0Z1VvT0t5OEZMZjk3U2JEaW5EQk90VlJ3Q3Y5cWpo?=
 =?utf-8?B?K0lOMWNGSjNNOEZDUFRCTFh0V0V1Z3d3OHBnNWxmanRMNUpUaEhCekFyTlFk?=
 =?utf-8?B?alFJaHVTTXN4M0hFdVhCeDBvcnJ1eWlPSXEvQzMyZmpXUU5LcXZHcG1CSGFY?=
 =?utf-8?B?SzN4RjhONFp0U0JzTEExR1NXTzQvc2YwWGNIZW9sbkMwUGdIWTNva0E2Sy94?=
 =?utf-8?B?ejdWWHNoRXJ3MHNuTEZ6TzIyTWFOWDBNK09RN09Ha2NTRHppby9sM2t2REdq?=
 =?utf-8?B?RzQ5MzBVa3ZzNENNYzl4OGh2NlZobGFBSW16aHNhYTRNNXd1QnQ1Q1cydVVD?=
 =?utf-8?B?cTM2eFZTcVIrbUlXVGtkUmpROC9RaURDUnFpbXRBUWJ5NnBmRXBkRkNNVXhI?=
 =?utf-8?B?K1NCYlU5Um9Pbml1dmR1Nnl4NzQyUzNjMCtUaC9IYzRDZEFuRmFMUW5KTnJx?=
 =?utf-8?Q?jRfHULCukDXGm3ML5s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960ea9e6-9a19-434f-8aff-08deec0d65e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 18:32:22.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzyaQV9iwav9r9+7rra+pvuYAT2pChYvthIBXW7q/ejVdyxJTvVDqawxoAGHOtTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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

--------------0qMSi3Htu0fgRc5b4O4Kvzcg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-06-17 13:04, Kuehling, Felix wrote:
>
> On 2026-06-16 17:16, Philip Yang wrote:
>> When svm_range_needs_unmap() unmaps a range, retry faults queued in the
>> soft IH ring before set_attr no-access was called must be dropped, since
>> those faults arrived before the app chose to revoke GPU access and 
>> should
>> not re-map the range.
>>
>> Extract and add helper svm_range_update_checkpoint_timestamp() from
>> svm_range_unmap_from_cpu() so both callers share the same logic.
>>
>> Change checkpoint_ts in svm_range_list from uint64_t to atomic64_t so
>> svm_range_restore_pages() can read it safely from the page fault handler
>> without holding the svms lock.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Acked-by: Kent Russell <kent.russell@amd.com>
>
> Looks good in general. Two small suggestions inline.
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 85 +++++++++++++++------------
>>   2 files changed, 50 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index f00c522fba74..d3dcc3b8d546 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -893,7 +893,7 @@ struct svm_range_list {
>>       DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
>>       struct task_struct        *faulting_task;
>>       /* check point ts decides if page fault recovery need be 
>> dropped */
>> -    uint64_t            checkpoint_ts[MAX_GPU_INSTANCE];
>> +    atomic64_t            checkpoint_ts[MAX_GPU_INSTANCE];
>>         /* Default granularity to use in buffer migration
>>        * and restoration of backing memory while handling
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index e039b6f2942f..acaa364244d0 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
>>       return 0;
>>   }
>>   +static void svm_range_update_checkpoint_timestamp(struct 
>> kfd_process *p)
>> +{
>> +    struct svm_range_list *svms;
>> +    int i;
>> +
>> +    svms = &p->svms;
>> +
>> +    /* calculate time stamps that are used to decide which page 
>> faults need be
>> +     * dropped or handled before unmap pages from gpu vm
>> +     */
>> +    for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>> +        struct kfd_process_device *pdd;
>> +        struct amdgpu_device *adev;
>> +        struct amdgpu_ih_ring *ih;
>> +        uint32_t checkpoint_wptr;
>> +
>> +        pdd = p->pdds[i];
>> +        if (!pdd)
>> +            continue;
>> +
>> +        adev = pdd->dev->adev;
>> +
>> +        /* Check and drain ih1 ring if cam not available */
>> +        if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
>> +            ih = &adev->irq.ih1;
>> +            checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +            if (ih->rptr != checkpoint_wptr) {
>> +                atomic64_set(&svms->checkpoint_ts[i],
>> +                    amdgpu_ih_decode_iv_ts(adev, ih, 
>> checkpoint_wptr, -1));
>> +                continue;
>> +            }
>> +        }
>> +
>> +        /* check if dev->irq.ih_soft is not empty */
>> +        ih = &adev->irq.ih_soft;
>> +        checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> +        if (ih->rptr != checkpoint_wptr)
>> +            atomic64_set(&svms->checkpoint_ts[i],
>> +                     amdgpu_ih_decode_iv_ts(adev, ih, 
>> checkpoint_wptr, -1));
>> +    }
>> +}
>> +
>>   static void
>>   svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>>                 uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
>> @@ -784,6 +826,8 @@ svm_range_apply_attrs(struct kfd_process *p, 
>> struct svm_range *prange,
>>               gpuidx = kfd_process_gpuidx_from_gpuid(p,
>>                                      attrs[i].value);
>>               if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
>> +                svm_range_update_checkpoint_timestamp(p);
>> +
>
> I think we should only do this if we're actually unmapping something. 
> So maybe move this into svm_range_needs_unmap.
yes, then this patch only extract and add helper function 
svm_range_update_checkpoint_timestamp, move this patch as the first patch.
>
>
>> bitmap_clear(prange->bitmap_access, gpuidx, 1);
>>                   bitmap_clear(prange->bitmap_aip, gpuidx, 1);
>>                   bitmap_set(prange->bitmap_needs_unmap, gpuidx, 1);
>
> And maybe make "bitmap_needs_unmap" conditional on whether it's 
> currently mapped. (in the previous patch).
add check if (test_bit(gpuidx, prange->bitmap_mapped)) condition in the 
previous patch.

Will send v2 patch series.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>> @@ -2560,7 +2604,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>> struct svm_range *prange,
>>       struct kfd_process *p;
>>       unsigned long s, l;
>>       bool unmap_parent;
>> -    uint32_t i;
>>         if (atomic_read(&prange->queue_refcount)) {
>>           int r;
>> @@ -2580,38 +2623,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, 
>> struct svm_range *prange,
>>       pr_debug("svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n", 
>> svms,
>>            prange, prange->start, prange->last, start, last);
>>   -    /* calculate time stamps that are used to decide which page 
>> faults need be
>> -     * dropped or handled before unmap pages from gpu vm
>> -     */
>> -    for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
>> -        struct kfd_process_device *pdd;
>> -        struct amdgpu_device *adev;
>> -        struct amdgpu_ih_ring *ih;
>> -        uint32_t checkpoint_wptr;
>> -
>> -        pdd = p->pdds[i];
>> -        if (!pdd)
>> -            continue;
>> -
>> -        adev = pdd->dev->adev;
>> -
>> -        /* Check and drain ih1 ring if cam not available */
>> -        if (!adev->irq.retry_cam_enabled && adev->irq.ih1.ring_size) {
>> -            ih = &adev->irq.ih1;
>> -            checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> -            if (ih->rptr != checkpoint_wptr) {
>> -                svms->checkpoint_ts[i] =
>> -                    amdgpu_ih_decode_iv_ts(adev, ih, 
>> checkpoint_wptr, -1);
>> -                continue;
>> -            }
>> -        }
>> -
>> -        /* check if dev->irq.ih_soft is not empty */
>> -        ih = &adev->irq.ih_soft;
>> -        checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
>> -        if (ih->rptr != checkpoint_wptr)
>> -            svms->checkpoint_ts[i] = amdgpu_ih_decode_iv_ts(adev, 
>> ih, checkpoint_wptr, -1);
>> -    }
>> +    svm_range_update_checkpoint_timestamp(p);
>>         unmap_parent = start <= prange->start && last >= prange->last;
>>   @@ -3121,8 +3133,9 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       mutex_lock(&svms->lock);
>>         /* check if this page fault time stamp is before 
>> svms->checkpoint_ts */
>> -    if (svms->checkpoint_ts[gpuidx] != 0) {
>> -        if (amdgpu_ih_ts_after_or_equal(ts, 
>> svms->checkpoint_ts[gpuidx])) {
>> +    if (atomic64_read(&svms->checkpoint_ts[gpuidx]) != 0) {
>> +        if (amdgpu_ih_ts_after_or_equal(ts,
>> + atomic64_read(&svms->checkpoint_ts[gpuidx]))) {
>>               pr_debug("draining retry fault, drop fault 0x%llx\n", 
>> addr);
>>               if (write_locked)
>>                   mmap_write_downgrade(mm);
>> @@ -3132,7 +3145,7 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>               /* ts is after svms->checkpoint_ts now, reset 
>> svms->checkpoint_ts
>>                * to zero to avoid following ts wrap around give wrong 
>> comparing
>>                */
>> -            svms->checkpoint_ts[gpuidx] = 0;
>> +            atomic64_set(&svms->checkpoint_ts[gpuidx], 0);
>>           }
>>       }

--------------0qMSi3Htu0fgRc5b4O4Kvzcg
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-06-17 13:04, Kuehling, Felix
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com">
      <br>
      On 2026-06-16 17:16, Philip Yang wrote:
      <br>
      <blockquote type="cite">When svm_range_needs_unmap() unmaps a
        range, retry faults queued in the
        <br>
        soft IH ring before set_attr no-access was called must be
        dropped, since
        <br>
        those faults arrived before the app chose to revoke GPU access
        and should
        <br>
        not re-map the range.
        <br>
        <br>
        Extract and add helper svm_range_update_checkpoint_timestamp()
        from
        <br>
        svm_range_unmap_from_cpu() so both callers share the same logic.
        <br>
        <br>
        Change checkpoint_ts in svm_range_list from uint64_t to
        atomic64_t so
        <br>
        svm_range_restore_pages() can read it safely from the page fault
        handler
        <br>
        without holding the svms lock.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        Acked-by: Kent Russell <a class="moz-txt-link-rfc2396E" href="mailto:kent.russell@amd.com">&lt;kent.russell@amd.com&gt;</a>
        <br>
      </blockquote>
      <br>
      Looks good in general. Two small suggestions inline.
      <br>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h |&nbsp; 2 +-
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c&nbsp; | 85
        +++++++++++++++------------
        <br>
        &nbsp; 2 files changed, 50 insertions(+), 37 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index f00c522fba74..d3dcc3b8d546 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -893,7 +893,7 @@ struct svm_range_list {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *faulting_task;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check point ts decides if page fault recovery need be
        dropped */
        <br>
        -&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts[MAX_GPU_INSTANCE];
        <br>
        +&nbsp;&nbsp;&nbsp; atomic64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_ts[MAX_GPU_INSTANCE];
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Default granularity to use in buffer migration
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and restoration of backing memory while handling
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index e039b6f2942f..acaa364244d0 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -759,6 +759,48 @@ svm_range_check_attr(struct kfd_process *p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static void svm_range_update_checkpoint_timestamp(struct
        kfd_process *p)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct svm_range_list *svms;
        <br>
        +&nbsp;&nbsp;&nbsp; int i;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; svms = &amp;p-&gt;svms;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* calculate time stamps that are used to decide which page
        faults need be
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; * dropped or handled before unmap pages from gpu vm
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp; for_each_set_bit(i, svms-&gt;bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = p-&gt;pdds[i];
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = pdd-&gt;dev-&gt;adev;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check and drain ih1 ring if cam not available */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;irq.retry_cam_enabled &amp;&amp;
        adev-&gt;irq.ih1.ring_size) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih = &amp;adev-&gt;irq.ih1;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr != checkpoint_wptr) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_set(&amp;svms-&gt;checkpoint_ts[i],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_decode_iv_ts(adev, ih,
        checkpoint_wptr, -1));
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if dev-&gt;irq.ih_soft is not empty */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih = &amp;adev-&gt;irq.ih_soft;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr != checkpoint_wptr)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_set(&amp;svms-&gt;checkpoint_ts[i],
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_decode_iv_ts(adev, ih,
        checkpoint_wptr, -1));
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; static void
        <br>
        &nbsp; svm_range_apply_attrs(struct kfd_process *p, struct svm_range
        *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t nattr, struct kfd_ioctl_svm_attribute
        *attrs,
        <br>
        @@ -784,6 +826,8 @@ svm_range_apply_attrs(struct kfd_process *p,
        struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpuidx = kfd_process_gpuidx_from_gpuid(p,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attrs[i].value);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS)
        {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_update_checkpoint_timestamp(p);
        <br>
        +
        <br>
      </blockquote>
      <br>
      I think we should only do this if we're actually unmapping
      something. So maybe move this into svm_range_needs_unmap.&nbsp;<br>
    </blockquote>
    yes, then this patch only extract and add helper function
    svm_range_update_checkpoint_timestamp, move this patch as the first
    patch.
    <blockquote type="cite" cite="mid:ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com"><br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        bitmap_clear(prange-&gt;bitmap_access, gpuidx, 1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_clear(prange-&gt;bitmap_aip, gpuidx,
        1);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_set(prange-&gt;bitmap_needs_unmap,
        gpuidx, 1);
        <br>
      </blockquote>
      <br>
      And maybe make &quot;bitmap_needs_unmap&quot; conditional on whether it's
      currently mapped. (in the previous patch).&nbsp;<br>
    </blockquote>
    add check if (test_bit(gpuidx, prange-&gt;bitmap_mapped)) condition
    in the previous patch.<br>
    <br>
    Will send v2 patch series.<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:ff4f2a99-17c0-4538-bdb2-512e7f51f62c@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">@@ -2560,7 +2604,6 @@
        svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range
        *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long s, l;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unmap_parent;
        <br>
        -&nbsp;&nbsp;&nbsp; uint32_t i;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;prange-&gt;queue_refcount)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;
        <br>
        @@ -2580,38 +2623,7 @@ svm_range_unmap_from_cpu(struct mm_struct
        *mm, struct svm_range *prange,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx
        0x%lx]\n&quot;, svms,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prange, prange-&gt;start, prange-&gt;last, start,
        last);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; /* calculate time stamps that are used to decide which
        page faults need be
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; * dropped or handled before unmap pages from gpu vm
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp; for_each_set_bit(i, svms-&gt;bitmap_supported,
        p-&gt;n_pdds) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ih_ring *ih;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checkpoint_wptr;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pdd = p-&gt;pdds[i];
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!pdd)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev = pdd-&gt;dev-&gt;adev;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check and drain ih1 ring if cam not available */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;irq.retry_cam_enabled &amp;&amp;
        adev-&gt;irq.ih1.ring_size) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih = &amp;adev-&gt;irq.ih1;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr != checkpoint_wptr) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;checkpoint_ts[i] =
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ih_decode_iv_ts(adev, ih,
        checkpoint_wptr, -1);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if dev-&gt;irq.ih_soft is not empty */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih = &amp;adev-&gt;irq.ih_soft;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih-&gt;rptr != checkpoint_wptr)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;checkpoint_ts[i] =
        amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
        <br>
        -&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; svm_range_update_checkpoint_timestamp(p);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unmap_parent = start &lt;= prange-&gt;start &amp;&amp;
        last &gt;= prange-&gt;last;
        <br>
        &nbsp; @@ -3121,8 +3133,9 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;svms-&gt;lock);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* check if this page fault time stamp is before
        svms-&gt;checkpoint_ts */
        <br>
        -&nbsp;&nbsp;&nbsp; if (svms-&gt;checkpoint_ts[gpuidx] != 0) {
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,&nbsp;
        svms-&gt;checkpoint_ts[gpuidx])) {
        <br>
        +&nbsp;&nbsp;&nbsp; if (atomic64_read(&amp;svms-&gt;checkpoint_ts[gpuidx]) !=
        0) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ih_ts_after_or_equal(ts,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        atomic64_read(&amp;svms-&gt;checkpoint_ts[gpuidx]))) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;draining retry fault, drop fault
        0x%llx\n&quot;, addr);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (write_locked)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mmap_write_downgrade(mm);
        <br>
        @@ -3132,7 +3145,7 @@ svm_range_restore_pages(struct
        amdgpu_device *adev, unsigned int pasid,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ts is after svms-&gt;checkpoint_ts now, reset
        svms-&gt;checkpoint_ts
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * to zero to avoid following ts wrap around give
        wrong comparing
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svms-&gt;checkpoint_ts[gpuidx] = 0;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic64_set(&amp;svms-&gt;checkpoint_ts[gpuidx],
        0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------0qMSi3Htu0fgRc5b4O4Kvzcg--
