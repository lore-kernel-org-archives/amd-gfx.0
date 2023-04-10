Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D87C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 19:58:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6A410E31C;
	Mon, 10 Apr 2023 19:58:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17AB610E311
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 19:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVWeF4MIFOsE68eEwVzNAPHnQY9xcB68VDLs9AH6l2Y2xXaasQ1W/J68hksBgmbxQkUUmrTjZ2T6AhScaKh++N38gNb8pPdO8fqBKNV+XO8VJL5oOYHSd/4xhxnzfTJUXoLrj7Q+kpwI6uujK3H4kxe2IHa0s4dIFDZZWbe47H/EACQjPSdLu/K43eN4MkC3ZmTjioZrDINnKfZSEukeNDafojNQA2I1AgvaWphgi8lQhcjygegeA48/qjEL5/w+0AxU3EbZWZ0p9KrpbMUFeI/E9vaN5XNJVmqqazA4Rj4efp6pIKL5uc2qMLFVwv7Enllfn5Ln875mgFrH00IGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7MW9xLNH7ATMfFaZ5P7oOvf7GtxYo/mw3pEYmOEWIA=;
 b=iuB/TQYmeq4RZQhgOmNTgg3EBNr0u0cWfXQ66e1W5JPa8yOKKWGSUH1+bnML5dwFsQp0L7soeGjKnW117J80XSAYuN133YVBRX8dTOrSTy3IrkHJKq5ogwNOu8l58u4zmpT4TzZQo0aVb79DrGLYPLbIa3wgXimX2vre/vTbTIW0fXmyT37PqIiSBp/9ur7ls38BZ7sCIMko4L8ZSPtOn3OR1Ps2xWgHVOoHxpQIpH41IDmQuKglEAFExJhtrIAjvwkmirphWMIkXXflCkrJhbhqrgc7MfsoMQwzBt0hszFHpsfeyNcuHAdz1ZErqfC98cEgtdYM6M+bt42nrZ/lbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7MW9xLNH7ATMfFaZ5P7oOvf7GtxYo/mw3pEYmOEWIA=;
 b=ymTR1SAcM3Jp+RKY0bQO7P2ynLj3HGLZ9MPwTgMOzmiKZaBWTEALndQ+FIS83tuQQhLdsDDnww3D3XmkeygBFV7MOY63cjeYW6HKiMABN1FHM8V3tXwnWhjyrDEX75EI/+Vdj6BWI6on5eAWnUch7Y2O8KPWh9iyi51kLeh0OIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 19:58:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%5]) with mapi id 15.20.6277.034; Mon, 10 Apr 2023
 19:58:06 +0000
Message-ID: <c48e62e2-fc71-c81b-8523-6fa9b99f1b14@amd.com>
Date: Mon, 10 Apr 2023 15:58:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: Change WARN to pr_debug when same userptr BOs
 got invalidated by mmu.
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230410143605.334232-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230410143605.334232-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::20)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: b260993e-8f3e-4b04-fd7a-08db39fde6a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jWwM7I4ap8vftAayeYDED2Sisl/nO74FkhiTX8pPXBMJIStMZp6mJYubS6ZQXfHAh9C68iC+93yESOaUDKBOLLf+6e9AFcLErikklUr8+81AoffOXx3TV5fPlmmsyTQbfz07i791yKDv9v/IwWA8ZPpLdth28UwZxsv1r6lT4qeHySqGizOPF1qtwPmxeoT++zpLYIHx3GQaP40BY1smTKHKAeJ2ilYiEo0OmF7yDbZUD3rBA0Er08Tjgf1W0VJNMIBUqzkLPl6riryCWRDHeKBrhSeCTLuBiudDFvXf0VoTKdgwdkjKSd6MWmzlZQemgEWLcLziBgUvlu9inDAXxE6QHSXsA237wfKD0IV1nqLW94puwqUH4kyucylRwzKEiBbj0u75K3tRGoI4wSUTw4c5DHuMIk/KKW5mawFwmnjt1CHNpSr5B7YO0qPfPHFkCEEY4qiX64g1CfbYpzMwPj+GPgHgwdgA++xPuw+HbDB6+Wc10jYDH5QffmFnnw7Tj3WQSmms6cN0eQ9kc3oW0VveT8muJNFFyPaP23rps+ZxsXxb3HIUaVtx913N/+jsZ6j4MWBbLiS9wlU05CMKjsvqM7v/+Q+HiGxTg9EfINZcEktpW7ZHueHfmHIQWuNZukf3gI4Ft3Krii99tDrBnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(31686004)(36916002)(478600001)(86362001)(31696002)(83380400001)(36756003)(38100700002)(2616005)(6486002)(2906002)(6512007)(316002)(53546011)(186003)(26005)(44832011)(6506007)(66476007)(8676002)(41300700001)(66556008)(8936002)(5660300002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mitmdi9aMGNSMWREN2Y1emw5Sk00ZjI2VlpZckRFMUg2VlNSWWxBRkIxNHVW?=
 =?utf-8?B?WW93STRmUS9iczRDcHlxMnZiK3BHWGVLbUcwRzBSNHhNUHpyVU96bkJkcHg1?=
 =?utf-8?B?MU9qWENyZmNnUVJ1V1pGSXhxR20xRjBkWGJOeXgraHVRSFB1Qi9wYTJyREgv?=
 =?utf-8?B?RDYvY2dWOUpoSE04cWxHVlFMY0lHY1BqZUdxYWM1Q01YTkN5SUl2YVpvVWRN?=
 =?utf-8?B?emZ6Wkt3aTVheFJiQmVENkZLZTQwTW1yRGpwQlg4RW1jQm16WFh2cWR0YmRI?=
 =?utf-8?B?OFJnRTMvUHNGanYveEJvZEdmdUg2cEYrZkxrRHo5L2tQMGFFK3ZFTlJGd2pG?=
 =?utf-8?B?TzhSblhMZzdYSHJpMEJnNWZzYnF4eVhFd2xJOUpmNkFIcVN2a3ovYWdGK1Ba?=
 =?utf-8?B?MWZFZGtaYWlQL1oxcnpQWjFBL09ibW43Nk5pUVZlTGJ4eHA0aWdDSEVlc2JC?=
 =?utf-8?B?cUJqc1l0QytuU1NtSXJ6b2NYdklUOHI4V1FrNDBNWUIyTmgyVW82c29wK3Zn?=
 =?utf-8?B?YldRZnpsMnVEVmp6T1JzMHJFMmRRaGJabGFkYlYrN0ZjckUyN2htdVJ5SXYx?=
 =?utf-8?B?enFTUjg1eHFjWmRUMHM4a083am5hRFp6eTJhQ2c3WFhuMG41R3ZVK0t6WkVE?=
 =?utf-8?B?c0JjMXM5TTc2M3VHVzNyc3p0bWFnNEQ3WFdEdkpkKzY5WlZMZ3NZNEEwYm5M?=
 =?utf-8?B?dWJwNWx5UXJrZndMRVI3Y1JBbW1RaGNxYVIweFc4UVBXS3lKL25ma3A5cjlp?=
 =?utf-8?B?Z1luSTNmSkxmbXF4QnpDcUpiSTJqdWdOVGhUck4yTkVqQWl1VkgrQll5WTY2?=
 =?utf-8?B?aEZsV3lQdHBnZFE1Q1B2Q3k5d2YrcW1xRkg4bHhCVitGV2t5akRwelhYd2Nx?=
 =?utf-8?B?WTRsVUhpek1NR1hrRmpBMXQwMllsR0lkNXR1Y0ptbHh3V2t4NDZiOVl3em0x?=
 =?utf-8?B?R0t3T3R5K2JpWkV0d0laRWdmQVBxY1BGeW1oQ1Zab3NuQWg4Wms2NlpaUlBz?=
 =?utf-8?B?TE0yY2RTbWFkLzA2TEVkM2RoVjllN09uVHphTEZZYzVYT2ZGT3dnN3VHT1RR?=
 =?utf-8?B?OTZnWUN4SjFZWFF4b3R3WmYvU3BTdjk2VGRLdGFObFd2R0JSSHN6QnNWdno2?=
 =?utf-8?B?cng3ajEyVkVRU2dPak9iR3lTSm5GRjY2OEJTQnpLZGtwYVZMZnJIQ1ZTVEZB?=
 =?utf-8?B?OGg4dEx3T2VvNTBtWEV1RFBjNEFZdXBNOEIxODVPd1JpMUI2QVB5di83eVV6?=
 =?utf-8?B?QWZpc1B5MzZCUUZ1VEFmT0RXd1AxMk1scWhDV0FHMUpvbHAyUTJJajNzTEh0?=
 =?utf-8?B?RGJIU1k0ZGVlUE5ReHRWQmNWbXRBcVNVbitYRGpJWkM5bVVhQnNLWWVDa1h0?=
 =?utf-8?B?WXBTclVhemVqdmZtL3E3anhkWjFGYXhjam5paWZQQUJqbWxwOXVvSTNZWnVD?=
 =?utf-8?B?TUxxUnVXQlg0cGJIM3gzY3JsSWZTRE82VElhWi90YVZhTzJvNEErT3hlKzBE?=
 =?utf-8?B?cjd4ai84YWYxREZza21XK0E2MG9KQU5WcUlBL1pERXVEWDBkRWxkMndTVkVG?=
 =?utf-8?B?QURQcEN5dURlVEdZTWplR1VNQURjS2daWTh1b3ZYNXRkeFdYOFluTWkxNmkw?=
 =?utf-8?B?NmdZUkhrb2RLQUN1Rkw1cXMrb29zbSs5TFZ6bm1jSHBmZDNla0E1Nk1FT2lp?=
 =?utf-8?B?QmwvT3RtYzhTVkFEZkRFbTI1U2xtSHR3Qy9aZVQxQ3dZczRubldYZU1MYVkz?=
 =?utf-8?B?anQ4SEs2UDljNENmVHk0QytBOEhpL1VaVnI0SFgyTmJubGpWYWRsMkJMSmkw?=
 =?utf-8?B?ZnRUNFV5Tmh0RmE2VjJ2NVh6N240L1ZnWVF2OGMxTDYvd2NFSDhGenpYa3Y1?=
 =?utf-8?B?RnFxaGt4V2F4NGt5UkRXMklqeXpxZk9MRGpKTGtDZWJkcm9XUU1GNDBXTTV4?=
 =?utf-8?B?NEVEZTVXNUtBQVVHek9OZzZweE44MlJyMXgyMDZjNkdsRW1LTU04OUNUZDRi?=
 =?utf-8?B?S0MzNG54LzBRMmY5T3JoUFkyNnZXR1BlQk9WcWgwTHphNERDdG1ERHgwVzho?=
 =?utf-8?B?bFVnTWVJUHVZMEVCaFZXNUl5ODJMU2NLYU9CRk8xNGZCei9ialRlNDhoTElR?=
 =?utf-8?Q?CIIG3beYmFi7N+2Gih40zvDcx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b260993e-8f3e-4b04-fd7a-08db39fde6a7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 19:58:06.4166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g17m8XPqlib35xFflnsvERInF/MZGQt4eaEWHkPlHdsidzC9xZ3Vl6RVtgggUNdnMhPlTFd8iZb9ULDpneL+AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

On 2023-04-10 10:36, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> During KFD restore evicted userptr BOs mmu invalidate callback may invalidate
> same userptr BOs that have been just restored. When KFD restore process detects
> it KFD will reschedule another validation process. It is not an error. Change
> WARN to pr_debug, not put the BOs at userptr_valid_list, let next scheduled
> delayed work validate them again.

The problem is not, that a concurrent MMU notifier invalidated the 
pages. The problem is, that the sequence number and the mem->inval flag 
disagree on this. In theory, both the sequence number and the mem->inval 
flag are updated by amdgpu_amdkfd_evict_userptr in the same critical 
section.

When we validate the BO, we set mem->valid to true. If mem->valid gets 
set back to false later, the sequence number should also be updated so 
that amdgpu_ttm_tt_get_user_pages_done should return false. So 
mem->valid and the sequence number should agree on whether the memory is 
valid. However, these WARNs indicate that there is a mismatch. If that 
happens, it means something went wrong. Some of the code's assumptions 
are being violated and this justifies a WARN.

I think you mentioned that you only see the warnings with the DKMS 
driver. I suspect this is happening on some old get_user_pages code 
path, not the current hmm_range_fault-based one. I would recommend 
looking into this problem on the DKMS branch and addressing the problem 
there. This should not be fixed but removing legitimate WARNs on the 
upstream branch.

Regards,
   Felix


>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 7b1f5933ebaa..d0c224703278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -2581,11 +2581,18 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>   
>   		mem->range = NULL;
>   		if (!valid) {
> -			WARN(!mem->invalid, "Invalid BO not marked invalid");
> +			if (!mem->invalid)
> +				pr_debug("Invalid BO not marked invalid\n");
> +
> +			ret = -EAGAIN;
> +			continue;
> +		}
> +
> +		if (mem->invalid) {
> +			pr_debug("Valid BO is marked invalid\n");
>   			ret = -EAGAIN;
>   			continue;
>   		}
> -		WARN(mem->invalid, "Valid BO is marked invalid");
>   
>   		list_move_tail(&mem->validate_list.head,
>   			       &process_info->userptr_valid_list);
> @@ -2648,7 +2655,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>   		goto unlock_notifier_out;
>   
>   	if (confirm_valid_user_pages_locked(process_info)) {
> -		WARN(1, "User pages unexpectedly invalid");
> +		pr_debug("User pages unexpectedly invalid, reschedule another attempt\n");
>   		goto unlock_notifier_out;
>   	}
>   
