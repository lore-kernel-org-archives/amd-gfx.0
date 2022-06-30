Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA938CCA47B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3222411B22E;
	Thu, 30 Jun 2022 14:45:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330CC11B22E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5TODgSrhTkLq7w2aKskd7xoP9fZmJQWdpLIPAbuv/StkMr1k9Q+o+1KKWusfD/H0sdeva7CcrG24GwdSqJ6F2gVRsAp4MdfvfN/ovmDstL9W0/MJOD2qNUvIJXbONeGLCOCXrMQILgCvUzimllI0dQHpTHqRjG55BpgPjqUVrcz2KrUOuuxbVLp5tbExZMRS6hrMij2HSdA1HDGpZjykNX83p4L6KXMi62lhTjk7oEuNyw60cC1l/3QhTvAewzSTKpTf/s0I+HXDsQQdAihlA0Ag65rkg7I20G4hmj1RmviXloEgsyowpEgWLRpXvGLUbWDLUsP+08+njmB0ho4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7byo7IKAEyqCvyDqocs6S4dA3Akcs9F+m/6V/P9mmc=;
 b=dbkhTKrtZiHyiBT4oqoM5sP33tkoi94q+yCmbwnlp4jFeRrR+WL7qxjR5aHjZsGvs2xs/UdL+5VvBAcX/dNK2QtbqHGtL3z0+rbG8xPfyJjbBtv74N5bUjKoNsSstzVTh673P7zwzKpF8m5m0Ho2XEbNeq3DSRAVD+reAFE/07y642fVzXyPF0+xfPec9/YZNlKR/qiRuy/czBnthMCijhyIXhBivZFz/vXDUcY/whKIc6GJsTohWGHtkLGX7JIIOFVHC08i6hl/VQiYpqC2EeAhgt6VnbH8OImaLE5pCb4ZVSt5XAAKPw1N65QQpKU/wLG5hHvhszhCz758eu4+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7byo7IKAEyqCvyDqocs6S4dA3Akcs9F+m/6V/P9mmc=;
 b=IYxUZmhasgJVKkINaluwF1GX/nrCn6jCb5r1B9O17zzQzrWDXHJukBkzTDQKlkkXCZFt4n4B0wXRICIr5Ey18Stjs+B6JqkUsLBvoe7J7Jj7aezkl2Njkerj7UiLXdpZbIDgakeNdzqoEPq8kaducAiC4rv/fQrHG4c9eB6UAz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN6PR12MB4735.namprd12.prod.outlook.com (2603:10b6:805:e5::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 14:45:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:45:50 +0000
Message-ID: <b2d23250-c574-e0e2-6a90-a3978a83e06a@amd.com>
Date: Thu, 30 Jun 2022 10:45:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 8/11] drm/amdkfd: Bump KFD API version for SMI
 profiling event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-9-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-9-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd5a8d3-2a31-4205-4dcb-08da5aa739c7
X-MS-TrafficTypeDiagnostic: SN6PR12MB4735:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1CU6LHTOsGIm6eb11mqQzc1exUU7cVpcZWMCdUA0359yEG9ot02+7YkHLiT51PrlOvOpMBbry1sWp/zNj8r1gms2EWe0eiZk78s/R451mQ8Xtj1QI3piot00NkKmsuJzBhBcRGxU+KZNcMJo6FN4W+xwtAT2snhmdIdxsz0jU3bRS/AQHF4bpEOKuLaapZok/Y1KBJyyN22jHOKrKpZfL7BhpgkwByacXFevivgVPDY0Yiyh32P83CMe214BgnaSnTehovIVgFvLL4hShP+ZQcVVGjTodHaCCWHrgNlBxxw0uBYRJ8rHFF0C29/t4iOjHOXZdseNqaNf1YnlrpmeF3lgYoruYM8ujUG6qObRKdtiwgtTzBBp6YIL8bXUg2gaEaY2+apgZsKhu7n6EK9tYNTGmp21/87xIcXqyF4jNmZ3dXzN2Tk1PPDUPIUEeHtKxiZ/dbnM6nF+/HCrzALQcxzEd0YFgh56tMEfHBGC8zsWk7o45yKXkr/zU5saMrm3x6PcLhDRIhSMde+4rTXaLatGUg5xWER5BimnOIPF5kuHPV3kb8NNKEeYbxBolUc95tobe4cM8h8D72VYtdsk+Qqy9TVCKacePZi1w/4U4eNhgj7MPhst0sf08irhyWAQs8xtfTh3jHrijuBcdACnPOQGdngZZ/Q6L0eDEHLsuVpu3CU1Iwwp415dCN+iIDMAOQJTZbqxuiGqjuzf3ztaLj+P5nOm0U2JaxuzdizYKNj+499pHTcd9GNZqy3P47hKp49NydRoHJMisQSgPUTFktJY9fovnlkCREtwqGYdO1+7/RxmArFqLbbY3j6eQryUBzVFzBDPYmEFVLc2YW8cbwNurT/AN0DkKN1CCDEsX9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(2906002)(5660300002)(316002)(31686004)(186003)(36756003)(8936002)(31696002)(86362001)(38100700002)(6486002)(41300700001)(66476007)(44832011)(83380400001)(66946007)(4744005)(26005)(2616005)(66556008)(6506007)(478600001)(6512007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHJyRlhYcmlObENJVW9Vb3VheW1tN3RtK21wUnEzZW0xc2ZQb1A3ekE2RFVh?=
 =?utf-8?B?ODFONks1cURMejU1WlFlYlA2Szdkd29HSXVldUwwRE9MeGF1T0RBQ3l3eUg0?=
 =?utf-8?B?bDBOWWVTS1NZSXZjdW1sTlY5NzUreHA2MklZUVdmUVZkNXo3Nmo3MXQxNEpk?=
 =?utf-8?B?cDFlczNjcmxOUVNvVUNSbDB5V25Zb1FLYVRIMm12Y2JjSXYwMnpOaWlKWmg1?=
 =?utf-8?B?T1NOSHVjMFpwNldtRHlDaStyMzI0djRVcVFaZG90bkZyb2JUcTBaMHhIYlR2?=
 =?utf-8?B?NFNGRnBQVVdYWTJMWFNVcm5wVXVqdHBDNFNSNnU2YzRWMnRnbGhPc1I0aHFz?=
 =?utf-8?B?YzYzR2xlakpJQlhydzV2STUwa0EvdnFJa0tRU0xIZnhoRWhkeG94RkNXTkU2?=
 =?utf-8?B?WG9vRXFVNm1aOGx0WW1GQ1drbDgrMG9LMmtrYVJTTW83YTcrTUtLMVFOS3Ba?=
 =?utf-8?B?QzIwMDd2ZlJHaVNHbmRhWmd6TWtkVjcvVGJkSUVkOVNDdUpuYVNzZDBxTWtD?=
 =?utf-8?B?S0dyZmhHaDB1U3FWb3RPWWVzREpLTzlZanlQVW9odnR5VGtJdnBvbUJ2bzVm?=
 =?utf-8?B?NXlIaS82Slp1TEtmUlVMODdPa2Q5RHdwN3YzemtvNm8rdGRic0p5d29lZE1o?=
 =?utf-8?B?R0hrV2ovSnZiaHZRdUp2Nk1nSituY3c0ZkMzWkltbWpoaFRLUVBjVmJtdFRl?=
 =?utf-8?B?WWFyR3l4MTloT0F3UnlLOFd1VlZ4WFg4eU01L2EwcDc4WkpYTCtacWRkcExZ?=
 =?utf-8?B?Nk9uUUIwRzhiSHRTVW1jdzRtZEtvUjBEa1c0WU5sMEdMWGNGekdjcnVQekJI?=
 =?utf-8?B?S3hQRm9JRDNnWlhXWVNTYzIxaDIzMHFEdUlJa3paVVFOczAwVE1RZ0d4VWQw?=
 =?utf-8?B?cGF2ZmIzLzBCMzY0OXcrL2FuVGpBWWhTcm9VYlQ3U0pST2llUVJrc2NLNGRv?=
 =?utf-8?B?QnVEeFAxOHRoM0ptL2RjNEtSNGs4RjBzWWY3Z24vM2gyNFdwYWI4a2VRMm53?=
 =?utf-8?B?cTVQQlFjalp2c0J3OGRhT0pmdVZwQnpEM3NLdmZpRVF1OHFkL0hGSytCalg5?=
 =?utf-8?B?d0Q5bFpZaGp5ZEVJU3NMVmRIaXdZYWlIWTI3WFhydnBwUXlSaGlFTEMrYlNk?=
 =?utf-8?B?TGdPbkNyaTlDRHRpbnJvMXZBTE02REQ1OXV2eGwzWjJqOGtyNmdNZ3FJQnA5?=
 =?utf-8?B?M0dnTjUyZEpYbk1Ja3NyZzQ2b3FsaCtOc2tmV1orY1ZJczFqOTdPRmRuckZx?=
 =?utf-8?B?NGtURWxtUVpkSTl5dTVMN1pMRlhCWk1kTkxidXg4MEFEY0FtYUphaTBKRXgz?=
 =?utf-8?B?VUpDbDlPd3gydm9aMFV2N0Z3bldHaDgzRHQ5eG1wUUphVzFNZW9JSEJKSDlh?=
 =?utf-8?B?VjdCM2wzcjFiay9vRGVYS0hLOVVCUEJidHlJWExoNGpRUzBxdVZHckZRWUdO?=
 =?utf-8?B?b0lhNXk1cE9ycUhSVU1tVUFFakxoNEVyU09FTXdxVmRXQ05PdUZqRFFDNHZo?=
 =?utf-8?B?akluVU9STXM0dGRTSEhDNTY1dnZYQWZQL29uQlVmZ1JobnlPSFdRV3l0Nnh2?=
 =?utf-8?B?enVLSGRIYnY2QTNvc0Z6dWJsY3RBMVBXNEVHaWZBRkhlOUhxUm01ZFNyMWFq?=
 =?utf-8?B?MHdEbU5iMzJyZkpVY2NFZk03WE9LU0ZkZHFEMVNBc3JLamtEaWEyRW95Nzhv?=
 =?utf-8?B?WHdkUGdCNXZTRHNZVXozZkY1citkL25OWldpWituNXVjZHh3R2NBSTR3emU3?=
 =?utf-8?B?Z2c3dGlUTDNGbytGY0UxOWpqMDVtSUtGRzhBQkVlcmNIaHF2ZTlGRVk1Y1dY?=
 =?utf-8?B?Q1JiK1pqdWVlZnlQRmJWYlhrVFZZNVRPeU1MRWZJTnIyUWNtZ2FuOE9NV0F4?=
 =?utf-8?B?TlRsZVdmenloZVpTd3N5QlFPWVhDWHV3ZnpFSDVTQlNOS1YrM0Y2bnd3K3BD?=
 =?utf-8?B?QWhUaDdZN1VRYVk4TEhFNVlJaHlCL1BLd01DZHRBbjJ6VnUycERKYjRBTk9I?=
 =?utf-8?B?eFF5eHIzNWx2QUVHempOYzU3TjFsM0tqUVVJZnZCMFNkY0cvSDNWZi9LdGY5?=
 =?utf-8?B?WXhiREFydWpXZmEyQUhBR2FSc3BhNS85L1pRNG82UkE1YjdacHhhWkNJQi80?=
 =?utf-8?Q?ChPEu8UdkhMwrYwjJ2OfroD8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd5a8d3-2a31-4205-4dcb-08da5aa739c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:45:50.2841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p7tvaZbC909C2WDJe760+qyyxtNJbt/CV7/uvUatoGIefqx2ZQXWBsxHJy7hUPh/b60tTtheZgelvGZcnmIeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4735
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> Indicate SMI profiling events available.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   include/uapi/linux/kfd_ioctl.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index f239e260796b..b024e8ba865d 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -35,9 +35,10 @@
>    * - 1.7 - Checkpoint Restore (CRIU) API
>    * - 1.8 - CRIU - Support for SDMA transfers with GTT BOs
>    * - 1.9 - Add available memory ioctl
> + * - 1.10 - Add SMI profiler event log
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 9
> +#define KFD_IOCTL_MINOR_VERSION 10
>   
>   struct kfd_ioctl_get_version_args {
>   	__u32 major_version;	/* from KFD */
