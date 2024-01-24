Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB16C46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 03:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A256F10F3F8;
	Wed, 24 Jan 2024 03:46:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E6510F3F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 03:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9XyFJexEJj9jxj2i0J804+BdQfiAEIc3BKcQCLEnNxn4LKyRKb5ENpL0FrSvhIKud2bu/baWZkUKb6oLI1A4JfhHj+zmVmtVTZ08eYmB6gQflUKrPpJmJSobGiw7Gz5GLTAc9XcGBo3s5xCyLmr97N7k8bvg4i7i/f/zJBNRUl2DTx+avwuRXBlKw6+3BzbxRia05vMdtgaYt3z45On5i1twGfnMP8wy294mG2bsWovqczXGzLSRrwaK9sT0G9RmxiOZilVCkmD3+sGcxtzoa8s8BOoxpREn+0IqB46uAnmHlhCN4UtP3HSnCy7kBLGl1yvfO2XhvjkCt6Yz4ti+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmMbFk4NpAsfGjgMoEzJ/uOqs1ikSKAfSWCRGxybmfw=;
 b=h1wFqSoZE7LVZQ0PFqWYBBW64cy6Axpq0aieX3puK2UB8dDQcBWFt8iz1VDMLR6b0foWNAh7o48RObOoefsLBI+ZrkS1ufPnrdUoh7ii9oe8Bj3JJsnJC8AJQSR0tWmmOokZGXqTcmT88nGETRY/guqPnEmgo15YoCbmJa537ndW8rPOYwpI5rhoya/zlXDmCc7zoV03MydUIfLxniKepP/cRIHFzDwzL0nwe1qWiumKnS3GhwPYJtzqJrUC5slT4bZn0P+ORbv6syzG/0vPW5QyedVWLmvhEApmEQ1SvbT8spdnbqcGRlrjySduHbirMbcRD6E84JcwwAJY5p5vuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmMbFk4NpAsfGjgMoEzJ/uOqs1ikSKAfSWCRGxybmfw=;
 b=blehlOibEvRVcEnUh09Uuk9oT0itZRACKlMz+vKszEjkiil0sP685S1+gUG7NjrXjwcQKxXFXKFaI22QJkzym34ue6RfTobaeU8IATP/R81Xj9u4x8bnotN4yW13sXjjH9wLnAjFDBXIuzWt8WQ5uBiukoseuz1HmiEKj34/Qvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 03:45:59 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 03:45:59 +0000
Message-ID: <f7d91fc5-50f7-4b91-aa56-2a490da34b9d@amd.com>
Date: Wed, 24 Jan 2024 09:15:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix driver uninstallation problem
To: YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240124033900.2410167-1-YiPeng.Chai@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240124033900.2410167-1-YiPeng.Chai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::19) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe227bf-cca6-4018-ba12-08dc1c8efa3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdoB1dpLUIQEVx++fFTdlT2PuQoTHI3khLkT1ptvF4fkVAwLR9LC0pm+XJXV9cmLsLZ3RKbC+rX05X2GlR1488kEywDnMnpJY6CCiVb+lNly5sg1Wze7CI91XbOtqa/iIhRiT9o8Po3bxccE8FDhIRHyffHGgddwKnFnN8dyidYbJRAM1ncVxDJwVtwZzI0XM5M9CZ15ZNbvLL+FQ7PqljfSH7V6c/iE2MfL1VO0r2dDhp3CtC71I9L71NsAbozEzg/rQ3AL8Pu/Z+E7VF2tErqfjyIeDFbVqLqAsqx2QnVl4UtuZh0gTBVdS7UvRJ8EnlaojRWn/nIMlBhKVJtJQ8R8akKww6JMfQ9cOByr14mPh8yERSMNW+4LwRgqplcGRqzz2qsIDW7i+NHej/fm34biml40Gy0ObwU5kgqDvOxCA8kYq9Eatbwe9M5gBLQlTYnkZaIGTRchFL5sNPjXl4vMrTghI5cuYNDJR7uKrQ4wNYBN0QrCf8YvrCpmwuNTItqaLsY+etaAf4m8OcyEV8KX86gaGOLaxGtwGsLhYFIKcVl5/d42WuytxbuFsQMj6t94XcV3N/h3t7FC7U7MC9hDnncZ8WagqQ8f2bAsmdrkfQFDmzvC5pls8nYUR+F71Pom/vAelJ3Cf0KGKn9L2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(66556008)(316002)(66946007)(31686004)(66476007)(6486002)(53546011)(6512007)(6666004)(6506007)(8676002)(5660300002)(8936002)(26005)(83380400001)(2616005)(4326008)(2906002)(38100700002)(31696002)(478600001)(41300700001)(36756003)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG1tSXNkZ3FmVEgydkVkQm8wSzZSU2JWY2liYnMzaU5ZWmRlaGM2UE9kNGpk?=
 =?utf-8?B?ZjVZZC8wanlhcXY3Y2tRNGt2WXp2aWNub1dqZ0ZvSjk5akQ2MDZPaitiak0w?=
 =?utf-8?B?c0lUcUNaeDNiZ3ZQVXg1aDdWc2IvcmFEWlJtY2tpanZsNmxqWmJOM0tvRlZE?=
 =?utf-8?B?UGw1WjEwMXRnOWtzVlArb01Bc2RWVm16QjNQQWZxRFR0OWIyRkZnMVBQKzQ3?=
 =?utf-8?B?WlhiaEtsTDBEaXZwRUJOdG1aemNsN1FydStpUGVxdUNaamU0R0FhUTVxdU0r?=
 =?utf-8?B?U2N1clhvdzNXdkh4WEEwVTAyS2hkT0JDc3pCR2RVSnl5V1ZZSVBVa2NMcFk4?=
 =?utf-8?B?TFpTcUJib0ZUckNqWVpaeDVQNXJ4WklVR0lSYXQwOWZuaU5iYVhYZE9EclI2?=
 =?utf-8?B?Y2RtaThWWXdqZlBHUHdtcEtTcC9ndExEdWZOOVNkMVB4a2YrTDhMWEVLQTkx?=
 =?utf-8?B?OEk4cXNFNUpCdDYvU3pvTVpUTXhwc21BR0J2NlhWL0JkdmVyLzlYeDl2UkZk?=
 =?utf-8?B?TU94NjZUdEJjM3NnQ01BMEpOZ1ZLSVFsV0ZzY3ROcHhmR3QyNVJub2dXVXY0?=
 =?utf-8?B?YzFQeS9wZUtnMkFkZXNaMWNOa252b3BnVVRCMGl5cUhWeHluc3pYYnBJOS9I?=
 =?utf-8?B?K3M0d2JxVldrRDhzUGFLdWJYQlJrR1hCeEFnL0tWSWpLdWxCcDVuYk90UVZs?=
 =?utf-8?B?dDRsQkZISEZKUjBpUk9OMTJ5ZjZ0WmYxTWN2TEFNNXhxcUNjelFXenp0L3RR?=
 =?utf-8?B?dnNLL2MxUUdLaGcreTN1Q1FVUWp1cy83UGsyWlZtZFV0WkpST3JpNEJBZThr?=
 =?utf-8?B?NCtqSTJlRUxKTGFRSmI0OUpSc0RBbDdYangzb2NsOFk3Vjl4QWhJZi9NQ2dF?=
 =?utf-8?B?Wjk4MGNkQ0RqMzZmM0d0YkR1VHd2cHlJRUs0c1pzc1RqSDVhU1F5M1pMdTRa?=
 =?utf-8?B?UTh2Z29IMWhFUS9iR0pPbHZyeFNSRU8yL0Q1Vkl2YVg2Z0RpQ00vZzFHcWpC?=
 =?utf-8?B?ckhGcUdqTVVlKy9DTFZ0dFY5bFFkQWM0Z2M3bWNWenBWNHFTWUFjL0xiMUY4?=
 =?utf-8?B?TU5HWFdVQk82dG41ckNvOFY1ODVORlpybTJzTktoTEd0bnpJR2Y5ZkV0MVdy?=
 =?utf-8?B?YmFFbUt0WFAvNjU0NWE0WTdsNjZrZGtIRUd1MjI2UTgwR0trNE10UTArL01i?=
 =?utf-8?B?USs5Vit3VmVBZWVmQUZxUXdyLzBVUVdOT3poR2Uyb1pXaGtNZDM0dExsZW1F?=
 =?utf-8?B?RVVCbG5xY3ZqVFBjYm5Hbm5YSEdMQVVxSlN6bHZJaWRpdTMvbmpJWGRhNGxt?=
 =?utf-8?B?d3VZVG4xc2JNUWxpVkJVaFdVOXRvSWpvcXIwNnVMMjdOb0U1YkZPK2w2YTh3?=
 =?utf-8?B?b3dRanZVOVl4T3kyQ0ZqckVQRkZKMFc0bEduK1doODdkbEhVQnV6dkJIODdI?=
 =?utf-8?B?ZDNkWXRoNXZubDMwREF2c2hVTEo4UzJjall0cVQ3dFhsSEpwQmd2ZXZzT0dD?=
 =?utf-8?B?T0dhL2lMQm9uckdpZThWc1MwRXZYYXVlaXVzR1ZSS2VwNzBKeG1rdUhuQnI4?=
 =?utf-8?B?aXFpaTlBaURJcWoyZzdHRHRDNmloM0Fna3cyTUJLVUxFWThpZ2VKNlUzNFFS?=
 =?utf-8?B?RU45YmJodWQvS0kzSHVyUXB3Y20wSENzSEtwTnBjTTRGN0EwZ0lUVmY4c1F0?=
 =?utf-8?B?cTNGOXdIamRYK0VNNlRTSXBWRnI5aHNaWUgvSHQwVjVuNnJlQ1J4S3BaL0Vx?=
 =?utf-8?B?aFk2RlJUNG9hWjRWdmcvcFRhemVGRXBHdkVNOXdWcXZERFYxMlozMjJSVUMr?=
 =?utf-8?B?OHB2ZnFyR3BMZ29NYjhPaTJVcDJzWmFWQUJJZzlpbTZBYXFNa2lBUTNRbk1L?=
 =?utf-8?B?MmJjdkhBL3RJT2FacGhacjZpcXFmWFlRMWJ5cWJtMXdrMDJMbG9FdDlSVzFp?=
 =?utf-8?B?L3ErMTFnV0ZqQjVKbkY3Ny83aGRONGhXMUgrSEpYTWh3d2FBT2RqSklXZkpz?=
 =?utf-8?B?b1RkbFp0blFjZnNSWU5HWXZBa2hNOVp4S1ZOT3ZwNU1raGZEZGd6NDlGK0tu?=
 =?utf-8?B?elpuWG0vUjgvMkJNM0V6Q0JqTWtYWmhtZ2psa0RjTkp2cjRFVVZsQms5NG54?=
 =?utf-8?Q?IH+tp2ngOt/zWWsAHkg1uT3on?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe227bf-cca6-4018-ba12-08dc1c8efa3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 03:45:59.2741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyM6S6YXE6dX/a+dA4qVC0dVVkY/80V/v9wN+IpHX1q9hxLTGSkgOMUgSySdVGQN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
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
Cc: mukul.joshi@amd.com, KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 Stanley.Yang@amd.com, yipechai@amd.com, Candice.Li@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mukul posted a patch for this already.

	"drm/amdgpu: Fix module unload hang with RAS enabled"

Thanks,
Lijo

On 1/24/2024 9:09 AM, YiPeng Chai wrote:
> The following is the error message:
> [  484.495995] task:rmmod           state:D stack:    0 pid: 2195 ppid:  2194 flags:0x00004002
> [  484.496000] Call Trace:
> [  484.496002]  <TASK>
> [  484.496007]  __schedule+0xaf8/0x1870
> [  484.496015]  ? update_load_avg+0x74/0x7b0
> [  484.496021]  schedule+0x58/0xc0
> [  484.496022]  schedule_timeout+0x276/0x480
> [  484.496024]  ? ttwu_do_activate+0x9f/0x570
> [  484.496028]  wait_for_completion+0x8b/0x130
> [  484.496030]  kthread_stop+0x71/0x1a0
> [  484.496037]  amdgpu_ras_pre_fini+0x5b/0xe0 [amdgpu]
> [  484.496202]  amdgpu_device_fini_hw+0x165/0x4fc [amdgpu]
> [  484.496406]  ? blocking_notifier_chain_unregister+0x56/0xb0
> [  484.496409]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
> [  484.496522]  amdgpu_pci_remove+0x3b/0x70 [amdgpu]
> [  484.496627]  pci_device_remove+0x39/0xa0
> [  484.496631]  device_remove+0x46/0x70
> [  484.496634]  device_release_driver_internal+0xcd/0x140
> [  484.496636]  driver_detach+0x4a/0x90
> [  484.496638]  bus_remove_driver+0x6c/0xf0
> [  484.496641]  driver_unregister+0x31/0x70
> [  484.496643]  pci_unregister_driver+0x40/0x90
> [  484.496647]  amdgpu_exit+0x15/0x22b [amdgpu]
> [  484.496849]  __x64_sys_delete_module+0x14a/0x260
> [  484.496853]  ? syscall_exit_to_user_mode+0x26/0x40
> [  484.496856]  ? __x64_sys_close+0x12/0x40
> [  484.496860]  do_syscall_64+0x5c/0x80
> [  484.496861]  ? __x64_sys_read+0x1a/0x20
> [  484.496863]  ? do_syscall_64+0x69/0x80
> [  484.496864]  ? syscall_exit_to_user_mode+0x26/0x40
> [  484.496866]  ? do_syscall_64+0x69/0x80
> [  484.496866]  ? exc_page_fault+0x87/0x170
> [  484.496868]  ? asm_exc_page_fault+0x8/0x30
> [  484.496871]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 8c1cb3ec2762..768a98f4bd22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2674,7 +2674,11 @@ static int amdgpu_ras_page_retirement_thread(void *param)
>  	while (!kthread_should_stop()) {
>  
>  		wait_event_interruptible(con->page_retirement_wq,
> -				atomic_read(&con->page_retirement_req_cnt));
> +				atomic_read(&con->page_retirement_req_cnt) ||
> +				kthread_should_stop());
> +
> +		if (kthread_should_stop())
> +			break;
>  
>  		dev_info(adev->dev, "Start processing page retirement. request:%d\n",
>  			atomic_read(&con->page_retirement_req_cnt));
