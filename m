Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF860C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 16:36:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ECA10E37E;
	Thu, 27 Apr 2023 16:36:08 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79FAA10E309
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 16:36:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiETMJLfOylRVAhK3Ugx2csCLXJMur1K9kQlCNxowteVyRQGio+px3MooWXczBnYuzeL4aEE9VZX+HXkjwzOApg5NcjXywTN4oPq8JzIBQRxv2h50SAxvkRpbdUPUUS8a8PDxx8oxy1fe/3haV78HJNAb9444Zvx25rkFXbb+KiPzqxnOpPefLDE+Eq4TxSXZ5Dj89stJVzJGfrcBmiMU4ar/eI7EuJi1EUMLz9mznQG+ItaP7QVqEyEm5b7rX2VXGTv2lPCpc3L5fb9iRBKiv1HLcJ6WxcyutkT2NIXY3K3aZwJUo4KNLZDDWIEXtLzrPsiAW48RZ3Fd9RSMsIr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W0m9NnAF1y3LdZODDTBx8xFZ9f6c8vB4lz3DSZILiA=;
 b=fs1A3zirNYLJCHkJhtri2CUfLrGmBAuDa+8x3g+6AHeBob/4xbwCegIEl6dKovDlaz8efo5fLQu1k6vdO3mrIm9Z6bXVu9b2V2gy51kKDcPw7Mf7MwJVN7FiQNcNUO3HpE1Rqk5UeGkWj1dlPo50fkbW477q0yf1oy84nOGz9mpMTCU+54viwlYPHY3HQhbGzvywcG+6ik7K5q6BTnAJ/GliA2vw9LxTB4JXJnx+xXUHnQjSf972JbYyQ5wkxWv/bS/5Gscr6N+od6mJX1zQtndSCVykjAIOIIQI2LBGdKNQIss8B9m1dNeP7zH8glT9DDv87mdRRCxRNMN8vKhUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W0m9NnAF1y3LdZODDTBx8xFZ9f6c8vB4lz3DSZILiA=;
 b=OAsFhblCRhKgw7fH0clnxpI/IvQ444UdGsVM3RAHBZIrIWCyc8nHTsdlHV8gOjFZOvweLmmLYFbS6LWyRpSz6P9WaTCjpRFtrIosP1jOeQ2bT/vlHSC/A7OvmV3zf39Tk3U14h1xSQJpikcKYJ6gzE+akUqqy1Vj0WpoXJHQT+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 16:36:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 16:36:01 +0000
Message-ID: <a893e01c-af20-e591-35cf-6ec708cb9cfb@amd.com>
Date: Thu, 27 Apr 2023 11:35:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/amdkfd: Optimize svm range map to GPU with XNACK on
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230424193808.10383-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230424193808.10383-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0408.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c9ded0-d8c2-4e6f-6894-08db473d7c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgvfAf+aAdlDWR9jP4bVuQehtN0sLXTXbCGKaNZHAosAs7H6FeEjPFrXAajPY8K42n3naXeoFKywN+B/9flR7RnT3UJ1BA0/cIdeSSYvPyC0qSlInAiQ5Ymv5XcVnFw7QeGyhm8Fm7Ud7peYFEX4MSM/qmRG6ZYXOMe2ZtS2U8tmUDfnxwzmXfgqldhQZvpHh/cgmEj9eKOvAIGyHC+4aTG/6+6COXwk1rObVSkBoXRj5zVZ9RVp8KBtnU6mlsHmZZ9YYYRgWYcfon+bCDXU3+/lulk58GA1Hqps2SfTaKx3e7ccDnbQYzRezQmxXZVqqWFsBlp21V0z5wZvC5P8zYW/sszSN0JrsUevOl3pHgElLPAR/YGj506dbYsEpcQd/x+C4ZOaVPbmVZPV0V7JzIG24KI3xFkyYx8CUquygbSZcFwlG+pCkWHMNeWPFJ4SsOhB0JmCqGG4UT1YqZp9UIjo2MxB2b4prnNZh2Sy9IHhLF3LJTw1CLpvkfS6TeB0Jf+ZHHQJ3wHG1N7ltWy9UFwbtqroC22opo+h5SZa2HFWgosk38fDLXriCvrIWKNAcK1RZ4QaOmW15sqbXNrWwUEVcCsXvoi8K7EZ43z2rgBJM0M2MsuyuQqGhkMKdGdJ4J4W+VkPMwsI4rC3dzcV0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(53546011)(6512007)(26005)(6506007)(2616005)(83380400001)(36756003)(186003)(38100700002)(66946007)(31696002)(86362001)(478600001)(66476007)(31686004)(8676002)(8936002)(66556008)(44832011)(6486002)(5660300002)(2906002)(41300700001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXp0NDJUQytvSVRxaFNvaTBBMVRQbmd6aU50NXJoWG8zenovbld1c3lYelZs?=
 =?utf-8?B?enZPQXNNbTdVdFZhOFp4UGtQMW50U0pYMkVGcjhuZFF1eDBFcUEzMjM3eHVi?=
 =?utf-8?B?M21XNlZVVlArcEhqQTBDOEdMbGdsdDZXVnNscGZRMnJicUxsWFl2WStPTE02?=
 =?utf-8?B?d1h4ZXNiVzA1MGxibnA5am9rMlRJMWlrZG1DanVmRmRHcUNyUzR4b09VSGFE?=
 =?utf-8?B?eTAzZnpERjVnVS9GaE5YT1VUeWpaSTh2WGdvTm1Td1hSVjZKQ1hQY2RHQm1M?=
 =?utf-8?B?VTBocDMvMFVWb05Jb3g5TVA4VmVtZS9WemVUektZZmYweFA2RmJ0eDcyRjF1?=
 =?utf-8?B?S3FSTWRYVUx4cmUvcVlvSmxrbGQzRnZaSGZuL09VMDZFNGhES1dvSTNqMHo5?=
 =?utf-8?B?RTlha08vUXRSbzhObTFFWEJtQktrdURLbEs1dmFPK0VQQzZORVZCMHV0c3NO?=
 =?utf-8?B?L2Z3c2pWVklNQ1J6bXd4UTFaSkRvZWJBZ1RvNHAzS1RmaHlzTjdLSnZyYzQ0?=
 =?utf-8?B?a0VzV2lnSkZId3ZQbm5uZEJsSURFSVYxeGorVFBhRkJ1Ti9LWll3TjhoNUMw?=
 =?utf-8?B?ZE9oYnBzV1NuQ2VlT2hqK2FVWTZWSGpNdGZ1WlFRRjRTZXhkVmV5MjJqUVho?=
 =?utf-8?B?T2ltWmtzMlRQNDIwdnV6cG1YdklPd2ZkaTlmSkxpSDVsQlYzSHZ5SVZQNU1K?=
 =?utf-8?B?L3ZiWnF2K0VwQkt4dnVBTnNEUU5ISERxWG5rMnFCRDJ0S095a2lFUW5EdzFO?=
 =?utf-8?B?cENFZ0s5akR4ekpabXRvZ0E0SUtJcE1aQ3ordlhBVDdid25hTWM3QjdmK3ZD?=
 =?utf-8?B?MnRxakNJbEN5RS9MRklnU3FnV09LRm1oTnlMRVhHNkhiQkt4RUtUcDZFUktq?=
 =?utf-8?B?SEN3UzQvODVScmo1a3M1Uk5iSXoxQmM2cElEeVZMUXZSMVJmdTM5M04xaHVI?=
 =?utf-8?B?anBqY0hjdEIyRTByblFjcjF2VnZKN0dGVXVhZkhMcGFMdUtjYnBtSXB3ZlVG?=
 =?utf-8?B?TGFkbmhHMHNXM3AwR0JkRm5iUG1Td2FSMEVjYmdHUnpNUzVGb1pTaDhIbmN6?=
 =?utf-8?B?ZHNrS1ZUTjdqWk5YMGRvMy92UXU1YTl2SFB1aDVrbUZWV0tqVnpCcGMyMkhH?=
 =?utf-8?B?UzBGVmpEV01GK0xYckZRTUx1dE1tV2pWMjNEblVGd05lYnIwb1QrNkNSWVdy?=
 =?utf-8?B?MllabEQzODRMR1lyb1FjMVF4cTZVSThlQkVQWEdCL3RrajZ3a1lQN3l0dXdV?=
 =?utf-8?B?ZVRQSkdyQXBUNmQvK0FaNklCdjR5Q1lOZ1h5UUpWMm02TytRamNUeFdnQ2xh?=
 =?utf-8?B?ZlFENUFZU3JtY21zbVZsR3NQSDFnWjloMFlpUDVVdy9sUWtaVWJwUlliQ3hl?=
 =?utf-8?B?MEY1QmM3Y2MyWjhsK1N0UWJZTUg0MGNQdXk3YUxlaDI0Y1F4UTNCSHNLbk0r?=
 =?utf-8?B?Ukx2emxSQlpTR0dHTFlaTG5LdXl4QndVYnpyeE9PclRMZ1prb0I3VGc4L1Zm?=
 =?utf-8?B?dmVXV1kwWXJaQk90OVJ2RzRpZldtN1RnOTBWR3F3dFdnNUZHNEVnQnE2L1Zt?=
 =?utf-8?B?elNWVElyT2FOTkptUFREaHZGTVI0RWFEU2s3WGtIc3paVUt4eU1ldVdvbUpr?=
 =?utf-8?B?d2k1MUZTSEp2Y3N3TkF5K0FQbnNYQlhGWmxHQ3Jod3pXWUZpQUN5dUVRM1Vz?=
 =?utf-8?B?eXBjT1N4UVBPTkV2Mkp5Ulp1dVNRbmc5UHp1KzVRK2hkQS9vMmQ0OGpFdnhS?=
 =?utf-8?B?SHFodTl6V0NxdzVvME0vZ2dSZzlmcjZFSjBmTHkyNGpQQzRXbTJOTjB2TDNE?=
 =?utf-8?B?Z2JmUm9XZE1NQnRkTE1iZVc3VlhOb0V6d3h5ckJicHJMVG04ZGdhRmFCQjhG?=
 =?utf-8?B?eHhBTUNQYlY2YXZWeUlkYnJrZUtiUDZ6dEJNNVZSTGY5Ym9PRndRMFhvb2RZ?=
 =?utf-8?B?R1J4SEM4T1hvZEdpTHpiWjdscEh1dkQrZHkwS3ZxbWJRTzVMNnJvWkFHd2V2?=
 =?utf-8?B?S2h0SUpXLzdTbjh6VVl0N2lxdGdOSkpPRktEcGRjclgrVU5HdGN1Q1NBY2U4?=
 =?utf-8?B?NUdZaUtiOTRxV25pS2ZEdXFsMi9ML2RvQmJKdVVCQ3Vib2R3aUhOZDc1VmpD?=
 =?utf-8?Q?fJqrOd6TJwXFq2+5bdYxj0tm7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c9ded0-d8c2-4e6f-6894-08db473d7c98
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 16:36:01.3902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8JBVCV8WKV2bS12PL9KKJvk+ynJtLzg4nhPEme+sYJsBCrOGvFrzqEcTR0tbcD6Q1oEYfUPXaJU/DAVk8et2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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


On 2023-04-24 14:38, Philip Yang wrote:
> With XNACK on if svm_range_set_attr set the range access or
> access_in_place attribute, we don't call svm_range_validate_and_map to
> update GPU mapping. This avoids prefaulting the range pages on system
> memory if the range is not prefetch to VRAM and not mapped to GPUs.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 129ef44f41e9..af7594b1b4c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -734,7 +734,9 @@ svm_range_apply_attrs(struct kfd_process *p, struct svm_range *prange,
>   		case KFD_IOCTL_SVM_ATTR_ACCESS:
>   		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
>   		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
> -			*update_mapping = true;
> +			if (!p->xnack_enabled)
> +				*update_mapping = true;
> +

For NO_ACCESS we need to update the mapping to ensure that the PTEs are 
invalidated. For ACCESS or ACCESS_IN_PLACE we can leave it for a page fault.

Regards,
   Felix


>   			gpuidx = kfd_process_gpuidx_from_gpuid(p,
>   							       attrs[i].value);
>   			if (attrs[i].type == KFD_IOCTL_SVM_ATTR_NO_ACCESS) {
