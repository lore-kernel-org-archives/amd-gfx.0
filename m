Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66439C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 18:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB4210E02C;
	Tue, 18 Feb 2025 18:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d8Ffi4VK";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA3910E02C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 18:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2UXvsZdPoJsYqFAqJyavXCSR/BSeEH940bRQ78m8XsRi2Wyp6CpcHi3EpMINFg48HMPA0CbFy+gJwwnQBe0wXhNljwHEsv+o1t8CYMfkMUZLLb8QXhZXRmmJSW3K0d5MRTn7rxRpISX0O7Qaey7Pra60Rdzz4BbeMjy0fvYUASUyKFkmO8KqMwS7xtLisxLjGOtjMD7yaMKB7eLXpxv4bPWgmdjsiLQPIxHPk3NOUtcKGPRzTUt2R4v3arDbvV+0vO8XXWMgqzjipYnPZJW4ZQpwxL2i4YB1joXDkjEltaywAx634J2pt+u6y+W4g9mwfhjkCF6p0LLnS9naa+Svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQsuHdDuQxprQqpJoG+e9RkcoEHvbxEzsg1N9jHRE2w=;
 b=gv5qMsHauJO2FgqXwjxWrTygwtclq1LHEgB1yY9EOpdYfRDOUsF0mynkBUjNXuP6VzzRZvxXhP3g9bkDVSs4MnEgftUT93kefX4ez6bfShBjdaSf+7bxvO9WgsWpRqnC59Ds9Bd8JcQmDQcyOLZ0dFP3h4+Frkn8i5klXOFYxxsJOm4xSQ3maxR7jtaxDCwQwIZHRNRenLUiMS6RokReODJ2V+1y89t5W7OK2EUtINqSwf/AxWk0CXjtF3lNTym9KlmSkmP/XKXFtF3KFC2wVnBFNKUI8n1al3UoDskoGC4IuULRBK4Rcft5O7bwAITwvlihXZsO7yfNUKJLDUNKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQsuHdDuQxprQqpJoG+e9RkcoEHvbxEzsg1N9jHRE2w=;
 b=d8Ffi4VKG9WlvrwIpaR+eUVGA34wPIbVMTRUR/EjCybfgbWkeQkQYrDg7N2sY1o9s8aKILHiqqcWRw6GATeX8b4terzHYOthJhORxCtKj0skXSXK0n7vEic1khn2QVjPKgZWKRAsuaHKArakZvsksupnIvT/23Ljxme4/fypA60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 18:37:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 18:37:33 +0000
Message-ID: <0eb7a523-2016-4c41-88ef-c7068d246e94@amd.com>
Date: Tue, 18 Feb 2025 13:37:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix error handling for missing PASID in
 'kfd_process_device_init_vm'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250217063722.705772-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250217063722.705772-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b7e834-0498-49d7-1161-08dd504b4f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTRoNVo2U1psY0dQcWl4UEJFT0NPa2RyRG5RVmR4YTNYekt0M3AzbndXKys2?=
 =?utf-8?B?ZlJoS1lCSW9jL0c4akRkQ3Q3RExrLzBmdlFlb1V2SmN3Qm04TWhPSDNZMTNQ?=
 =?utf-8?B?cWduRG9tRWd0Vm9Ha2VBRzROQ2ZRMnF6UWNFS1ovYUFpdnlJV1pXbDZsdHBh?=
 =?utf-8?B?ZjRTMGNLdmhucVZvSDFzWTRSMmJTTDYzNmQvSGE2Q3JhaGEzZU10RURua0pu?=
 =?utf-8?B?RE1sRmtzRHNHNmIvY1RJbVdRWnc1Q0JVOFJGUFBYYk56WGZwVlRvdEwrQ2lz?=
 =?utf-8?B?TTZSRHJybHVCblN3ODc3Tk5qZHQ0WTlrdkxpakhkcWNDTklqWk8wenliVTd0?=
 =?utf-8?B?eHFjdUNibGJoSkJ5N2U1T1cwYXkzT1I2RzA4K2o4SWZtN1ZWM2ZHZUU0WGxR?=
 =?utf-8?B?eWpBbFJDbzF5ZjFnRGRqaFdNandid1dhVUlISUljdUpHOWorNmwzN2RqT09M?=
 =?utf-8?B?dmNHd3kzOXJTWG1lY051YWlqZjVPMzRCOFdMMm1XQTdRZ1QwV3UyZ2NZKzJ2?=
 =?utf-8?B?RlpCVUlPbEsranhUd3ZLVjJhVkRwOFpWMXVSTjlsU0N2cXp3a0VqeWxWeXlr?=
 =?utf-8?B?aXRsUUxlVUw0R0lHZVphcDRaZEJhK0ZvS3VvRGFsajRlL1UvMXQxL29tN0xz?=
 =?utf-8?B?NEhNYzlPL0ZOM3hiRkpxUVM4azkyYS9IdXkrMENLVXpGWmZqUmRoaVZqT3Bk?=
 =?utf-8?B?TnFzUmpqVHNqSWF4RFdlL0RmanlxNWxwaEZoM08vaCs3cjRmeDErVFBVd0ZJ?=
 =?utf-8?B?RzBtNWRVZWFYRHBpb1lOTTREakRoOXJFZHduYXoxK1RuSW91bXdWZHROcms4?=
 =?utf-8?B?WDlYR1IyNEpXSXVZWW5IRWg2SjBxRzBMdnJGTjFlRUkrV3l3ajRFa05oenNE?=
 =?utf-8?B?TDdoSitSTWVFNlBTRnNXbnFhclROOUsvdWRISjVoSmUvdmZ0RVZWZmZiSHJ6?=
 =?utf-8?B?N1pqYy9QTTYwRHE1am9XNFcyZy96NVhWdFZNZDVHQzR4M3FFUVRBMjVIb0Na?=
 =?utf-8?B?azgyN0RGVUx2MVROK0U2S0RSS0NhNGxYWXpXZStEWkw0TWRHUFRrRWtuRlBX?=
 =?utf-8?B?TVFZL2ZxK203SFZDL05EbmpkQVRPdjAxNi8xN2FiUlMrckVaQnVhTFhPSjJP?=
 =?utf-8?B?ZGY4RFg2MXNMSFhoalYwT2paSGhTYXJhUTdtblBtWGlpTDArbFJINHZnWUQ3?=
 =?utf-8?B?OGx3T284TDcxVUlpWk5rYVExMU5Hak9sc2RiMnJ1RW5pMG9kbVpYa0RFSWhq?=
 =?utf-8?B?KzN3bDQ0dkJMNGthTktPSTN6OUZLQ0xvbXM3bXhmMXFoczhkTmg0amVCR1dr?=
 =?utf-8?B?L05kMmsrcUtnOHcvWUdFM2FyblhrUGtWd1o0eEt0ZlVRZk0vcWlQQm9wWTQx?=
 =?utf-8?B?OEVDdHpKK2JhNVdockVyRHJYUVlHMjgzV3R6VmVHbnNaTHBkUENDZDVtWkpZ?=
 =?utf-8?B?K1dnQjJOdVRBUGxkTzFNR1pqK2hrbEhRMXV5YVZnczkwcysycVBVdWtpSy9p?=
 =?utf-8?B?VWVBZSswYlpxK1BxVzRGZm96dDhKTHNUcmVNUmMvOGNIc0YrVTNyMmY1SlRv?=
 =?utf-8?B?WXhNS2J6S1FIdWNwV3pYeEE0VjFOcHFsNFdRZWNjU2ZFTzNEOWVjQ2lGMW5m?=
 =?utf-8?B?ZHMyZWZsSXpzSGIyQjBkYkVHY3I1UWx0VS9OajVWc3RoYjhGdzVXdmxQZ0lz?=
 =?utf-8?B?czB1K0JMcE1GUFRJaXBzaXpmN2R3cGQvdGU4bjc5c2pmV2NLMDl5aDFDcUdU?=
 =?utf-8?B?elRuZkUvaHc5TmgxaEtDQXpPeUMrUnQveWdXK0E5M2lhcmpoOE9hUG90Yjlp?=
 =?utf-8?B?cm1KWlRvMkUxVHNRVlpMZzB3TmcxaFE3bjNrMkdwWUp0aVhldDNZWldxYW93?=
 =?utf-8?Q?chc3iDUqloOlp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJnYUtUb01CM0txT2dicEVOcm1Pa2VtSTBzMDFlS1F5R1BoZ3FSL0tkL3l1?=
 =?utf-8?B?Ui8vYWY0WU5qdkNHYXlPOWI4QVAxUnBjNHpkVlRJNDZZZjltRHRWNkdtdVpF?=
 =?utf-8?B?NFdOUTRLMFphc3ZlK0NpRTFYZ0IvMGRwZzZJUUo0WlF0akl2UVpJVTJTUWtB?=
 =?utf-8?B?VGkvV0M0amhSa0NNNjFLZldwRFY5VWZDZFZWbTlCdFVHRjU1ZUFmOXo2U043?=
 =?utf-8?B?MHlMV1NLY251dlNBVjNRdGRBOUZ2Znh2N1lISDlldm5jT3c0VzkxMW0vU2JY?=
 =?utf-8?B?V080MFVNOFh4eFhuNVJxQWNra052UlhhSzc5ZzRRbjdQZGx3dzQzTHVGRXhh?=
 =?utf-8?B?QkdqS1FQTi9JTlNpOWN5dnp0cHN6OUF1MUJHdzdaT002Y0haa0N2R3N6a2lX?=
 =?utf-8?B?emtXemtJekMySlRhTGg3WkYzdFljR3RLZjQyUTV5T3VCbUZqSTFCaFhZOEd6?=
 =?utf-8?B?eXgrYmYrWkFqQ0ljclBtMVJWOXNxUUprSDRwdjd4dFMxWlVqRWpaTHQrUHc0?=
 =?utf-8?B?YkRYdm4yQ2xJbGhTSHFUbHdLdjJrS2F5N2sxWFR4WEhaUFhIeXJtYjhmeFBa?=
 =?utf-8?B?U1pKRHNSTzgxazV5azRIWjNmRXYwR29ld29JMmNjWEhFaUhDajRQZWU5SURq?=
 =?utf-8?B?eGd0ZEx3R0cwdTZiRXpMTmlxeUE5aTJ6Tkp4NUx5MnVVY3VPN2xqd1Y0OTRk?=
 =?utf-8?B?VklRaXFCcGJXZEZXK2FPeUdObDMrQjVNUXdwenlPazFaM3E2ZmRwaFkrQWYx?=
 =?utf-8?B?dTNtU1UvYm1aRkFkV0I3SzgvdU9hMlJXZVRxaE5JQ1c4ZnNYajFaMkF0bFdO?=
 =?utf-8?B?TWp0ekluUmpubEJ4ZnIxZklsdkpENlUzTyt6d2FIcGw0ZlFhclY5dDFPdmlj?=
 =?utf-8?B?MHprbjVnbWtyRW1EVkFudVRhQTNLL0U5QXdxNFhLRzZSODJsczZLLzN6dnRO?=
 =?utf-8?B?Z1BySG5iM243cVYzbVFrdjRQY3UzcmxwSW0zWHIxSW5kSlJ5Q2RJREZtMzZ2?=
 =?utf-8?B?MGJ1WVFqNkRJQUVFYTNFT1JSZkRNLzR3MVpMZkQ0VU0yWGpIK2xsRGxoSmdT?=
 =?utf-8?B?TVlldWZrUUpuT050aHNnVzB1WkdnOWluOEZuZXVBeGFvWktrK1VCZXJ5Njd5?=
 =?utf-8?B?aHFkRnZJdUszVjFNNnpYRFJiMnJERHpZUkd4Mi9Pb0ZNcjgrTDJDbFpEZGxK?=
 =?utf-8?B?TVJiVjQzYXJGWUs0NXhUS3pvckptMUpVVTZGb2x1WnFhNUl2cTR4TFEvRko2?=
 =?utf-8?B?RWlhRDlsU0EyUXdseVpLZ0tLLzROY3pGM2Q2TkNoZGxxQmZ6L3hnQmVLa0hr?=
 =?utf-8?B?NTd1bUNMSnZlUFpGZkd1a2Z1Z1Q1K0FCeDFyNVFVWERuZnJLL2JNd1BYb05L?=
 =?utf-8?B?SVQwRGViUVdBUitNbFlVeVVaMjliWDc5K0tSVW1KRjZmdC8zdmF2VCtpNnFS?=
 =?utf-8?B?ckZxNmpnQXY4c3ZVYlVtWVAxbThtS2ZwanJseDlvV3Ezd0F1VFllK3RyemlR?=
 =?utf-8?B?ejlkQTViMFdMZUljbzlMTUZvbC96Q2o2YzBUb1dsZDBETEFRSktHZkRvL2dF?=
 =?utf-8?B?KzFjZzcvdndSNXNWcHZHOFUrRGRYTEd3MmdLU0l0aXNGckxuQVludlFrQlo3?=
 =?utf-8?B?WTk4VDg3RndVR3EyaHlYazNVSUZCUE8wZGVLYTlWUG0wUkJBd0RIY0lCRG1h?=
 =?utf-8?B?RmlpOW9zN2orUFYvazBkYXhwcWpVVDVSZHB2bVNTSTUxd0Z5R09NR011MkZM?=
 =?utf-8?B?c2RJb2ttOFJCKzZYK1Z5ZVU4NElkVmEwd2NleUU5aHptb0ZubTdTRDZEOHM5?=
 =?utf-8?B?aUxKa1RuRGJGSTlCUnBFbERuYmpEWGU5VzkxZUhhYzdjS3ZPZXJQZ1dwK0Mr?=
 =?utf-8?B?NHNmT2lsRzc5c3hoMmpmL1RhRkVUWVFzTU5paUN3bE9SQ1RUTVZheUJVS2xq?=
 =?utf-8?B?SmNQNkF6aXpxL0tFQzZ2RFpmaDBzTWE1Z0x1eEJKU3ZqSmczMVZqaVlvN29s?=
 =?utf-8?B?VXRWV0h3MEFXbkVWS2h3QjNGZVY3WWdjSTArQ3k5eFRyYnJDdnNXWkNxOUpr?=
 =?utf-8?B?OU0yUGwybUJCOEgwWnB1T1dISk1hU0xNaGJ5b0hWU0lDUFNKQ1BlcVFNRXRB?=
 =?utf-8?Q?CuAREAKFPYC7Up0wv1iPKrVTL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b7e834-0498-49d7-1161-08dd504b4f14
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 18:37:33.7598 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47bp6wRPAgzWGbw7E8dwQins19xCcEP4bnJ3C8wNW3OwK6Bh+8ivh50+6M0GeLlC4CIFkbWqzL7rSX6LOt80+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057
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



On 2025-02-17 01:37, Srinivasan Shanmugam wrote:
> In the kfd_process_device_init_vm function, a valid error code is now
> returned when the associated Process Address Space ID (PASID) is not
> present.
> 
> If the address space virtual memory (avm) does not have an associated
> PASID, the function sets the ret variable to -EINVAL before proceeding
> to the error handling section. This ensures that the calling function,
> such as kfd_ioctl_acquire_vm, can appropriately handle the error,
> thereby preventing any issues during virtual memory initialization.
> 
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1694 kfd_process_device_init_vm()
> warn: missing error code 'ret'
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c
>      1647 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>      1648                                struct file *drm_file)
>      1649 {
>      ...
>      1690
>      1691         if (unlikely(!avm->pasid)) {
>      1692                 dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
>      1693                                  avm);
> --> 1694                 goto err_get_pasid;
> 
> ret = -EINVAL?
> 
>      1695         }
> 
> Fixes: 77b5e447427c ("drm/amdkfd: Have kfd driver use same PASID values from graphic driver")
> Reported by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index f45e33f79d36..1067afdb456e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1691,6 +1691,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
>   	if (unlikely(!avm->pasid)) {
>   		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
>   				 avm);
> +		ret = -EINVAL;
>   		goto err_get_pasid;
>   	}
>   

