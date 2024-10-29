Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F25D3A66B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A9DF10E67F;
	Tue, 29 Oct 2024 15:01:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gJBSDz7l";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39DA810E67F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 15:01:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJucnnUWATtEWBR3ZABDyMIlFmUwIwW76iNVWpGc9aQE/m/m6zhB1WLGP9mlOAgjehviu8Bj0L9FemltD96IgGtEJM6fD88sceqZwARo2p8uysSeF5Spb3wpVnKgbU2Hp6mmHlJemn/Kn5lJTPxAQzzmISX2GiqhoRoRBLqONV1EWgxUPt9FL5O2OlRQPqK7T+xwqvocdntbyAa6duQWdwMD+Vy6HlloERQlR0h3xpq/cf1exmwAdiUoBqbNsfpnHTq8n5h15U1XxDeBBrWDh7U167eVNnTrnBFYLf3Gzkk+C4HuxPCUVoQ7GAOvviJCSOAvAkf0Z7yGho1olLmNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFjDnP9m5F9sVTo4rawMdi2DIwxmQvQAiGehoMgllm8=;
 b=tfeRKuwgXTpv+BKHe0i30kVabwhl3see/r/OzALB34lI+qq5uEDsBwiqGAyyIod5iR+/3NXPsp3QoDcMPnvdGOZk1OYhqdYRiGc5FMSfFpuax36w8hMFTzlM8KOmwxstC9NQLV2YUW1r8xSlA003v3zXMYa9mLSF5d4BRKXk2vwjghI8T0AxDFtSbeVBbw0ha/e+fpeMwfmlAfNDf3NKx6W+cnRIVe4g5W2AXCMkZ9JdUOoZqgEI+abE152JoI8AFAB1qoiykApwRobedhWjzXRJoxWFxA3xm7+ehmfKckKegmgo1L0iQ+kgrhLghFfra6iAY+katx8YmIz7suSYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFjDnP9m5F9sVTo4rawMdi2DIwxmQvQAiGehoMgllm8=;
 b=gJBSDz7l2qoQwxi5ypyUiAop/UM9zxcDVal6meG6J9I9yYqd6rPze0SZ+zl85K7HDlL6jEBMhKE93dYDMA6B8ug3n9vQHpoo0jqPmOHYxLnR+CjnQKZVKPZ1SdtAJxhtuj+evdGTzrIiDvdhl0I0fhVbERHyYR+291NV4Blj5CY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) by
 PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Tue, 29 Oct 2024 15:01:43 +0000
Received: from DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::e74f:f5db:9c45:9a24]) by DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::e74f:f5db:9c45:9a24%3]) with mapi id 15.20.8093.021; Tue, 29 Oct 2024
 15:01:43 +0000
Content-Type: multipart/alternative;
 boundary="------------c0iXAuCUfX1l1aakiQS03XUm"
Message-ID: <9697eb8f-bab6-482a-ad82-0939ea9e17bc@amd.com>
Date: Tue, 29 Oct 2024 11:01:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Differentiate logging message for driver
 oversubscription
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com
References: <20241028214014.59940-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Mukul Joshi <mukjoshi@amd.com>
In-Reply-To: <20241028214014.59940-1-xiaogang.chen@amd.com>
X-ClientProxiedBy: YQZPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::27) To DM4PR12MB6445.namprd12.prod.outlook.com
 (2603:10b6:8:bd::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6445:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: d0489c77-4ce8-4530-a24e-08dcf82a9990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXlVVGgwZU1UZ2d0MWlsTDZ3MUJlMkI1bWUzbkcrSE5VOEJOTkhEY2NLc2cw?=
 =?utf-8?B?TFA5Qy9Fek45ODNRc0NPdmJBRm1XRFhOQXRaWGZ6V2VsdmlHRTEzeUFTSXdm?=
 =?utf-8?B?cVRCTkFaRkFsOW85YVNaNmpUZkNyNGF1M2x0cVc4T25XbnBmb0U1eDNvYktP?=
 =?utf-8?B?MHVDM3J5YmNSYWRHbEVuWmo5Q0UrOFY4MzJQYkNCMHVUeU5BQy8zOUhreVhM?=
 =?utf-8?B?VTdqY2JJcGhPOXM0K2U0UitlY2x5Q1FaTG15anV5b2Ira2NHMEU2QTM2ckQ5?=
 =?utf-8?B?SHUxR3FCZ1cwMU9OWmtmTmZ1NmEyRGN1UmFKQ2crTU1rTmV6NlVqUVFtWFQ5?=
 =?utf-8?B?eHN1N2RsQ3NUU1I4OGlheEN6dExqUUw0S0YweFRIS0FJMW1vaVgwemNsdjFm?=
 =?utf-8?B?bzN0Rm4rYWZkVXNNMDVJUnNaUWNPZFI4enBFWllPL3NBY01nT3E1bnJiWDFC?=
 =?utf-8?B?RUM4cFJVU1MvTDRXUkh0N1dRNzdIWkxpNDd2cHY4ZkhBNno3R3BJNkJycHRr?=
 =?utf-8?B?Z1ZKNE0yK2N0R0wzN3VZNk9NK1VaQWtUcGp5eDYrdWtBMFU1T1h3VXdOc0I4?=
 =?utf-8?B?UStVNlArVndDQTlwdlZkU1hiV3hoeU1EUkIxdnVwempwZVdKcDlRWDRrcmpT?=
 =?utf-8?B?ckUwSFJFS0x5R2FKL2R0U090Y2tlQUF5TXFEaGVnNkNLRmQvR0Z1cHhNRUhw?=
 =?utf-8?B?TDdMek8yUFk3bE9hT1ZPcnJKZWRocmdsQ21wc2NkT0E5dFJCSkRKNkFKdmZn?=
 =?utf-8?B?dVNyVG1ibnpxNHp5azJVa3BiSk83aVZycGNQNjRmUnlTa0JySXRrdFF1S3ZM?=
 =?utf-8?B?QWxtWFBjR3FDTU9nZGhKN2JtVlkveHdQdjRRVm1HTGFQb21kWUdjN1ZBSzNN?=
 =?utf-8?B?K21wOVNSN2o1cW42UTkyVkFWUCthOU1MWFVzN1JBZ1BmUHUvRG1kamtPNzBT?=
 =?utf-8?B?WE05ZzJpbzRaYnEvdGVrNHJaVzNuazkvb0lOeTk4SFp5bmJuT0RIdGZDMmgr?=
 =?utf-8?B?TjM3eHNxZWdoRjZVRSt1dG1kQlR3MTBlemVPbC9YVjIrdUtkMlhOalV0YUp1?=
 =?utf-8?B?aEFPR1JzR0o2NE1KRS9USjZGOHFhN0JGQUNJQmJPYWFheEhzMjR0cmk0bk5j?=
 =?utf-8?B?cVU3Y2xTeU9kb1FVQ0lQWWh0bThFSVdDU01FaVhrZ0JKY211YnRHZFJZcmpM?=
 =?utf-8?B?Y2kvN2JmUkJzRkkzaHN2QVI1SEN4T3A3U3RNaVdGK1dhRStLSlFBZ1FCVTBE?=
 =?utf-8?B?bU5IUzVWaWNZKzhuSXA4QlBjbHAvNzN2VHphVWhWSWtCdzFqWFZ2Z1F0M2pv?=
 =?utf-8?B?QUJnTXpiMG9mQWxmNDBpMWoxTlBEbXBhcDkzVjJ3ZzVBZ1Y0dDAvdjJONCt0?=
 =?utf-8?B?Y2kreTFEUTl2TjlqcWUvRXRsMG5qdXFNc01qOWVXQ2NXMFNYS0FRU1Npd2Rm?=
 =?utf-8?B?QnRVMHNVbDNSY2loTzFFeGdXM1hoNGVsRE9ydlhIenE1OWgwWWxQd0VzRFY5?=
 =?utf-8?B?c00rSEU4K0xWR2ZiZUVWL1BMZzE2N0w5ak1aUVdpTXltWDI2YWpub0tkTmw4?=
 =?utf-8?B?bWxaR3hPamNGMUh4OUpjaGlMNXJja2wwRTgrMlZzZ2Rvekg0Y245R2RGcExI?=
 =?utf-8?B?ZlBWdWkxS0hRc2gzWmV6T2p5L0dQNUM3bFdBaEcrMDhweXAwcVZxbUUrYm84?=
 =?utf-8?B?alV1MW5ldkVFTlkxeVJ2TWx1dG1Hdi9meWpEZWRLeVNnTW9pYnl5L3R2ZUdn?=
 =?utf-8?Q?N/P0h92MA6kzXj3DPM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVKY2Qxazc1R3UyS0RkNDdiWHlDZjMyQWtkb3k0aFU5RXdtRTBNWVFzUGxw?=
 =?utf-8?B?RUpMY2lHVE9saHplN2JMSG5uWTR6NmFLeEVEd3RrMTBrZ1AyS2RtNC9zRkxr?=
 =?utf-8?B?b01XU2FnVlRIMXpSdXRWN2VlbW9VQ3hhbFpLRnhxWTNOQW42THRjUTJ2cjJM?=
 =?utf-8?B?dHNRUFlKbkhlaDFPNXc3Qkk5S2ROdFljVy9uNlJXaGlKQ0p4MkQ1bk05U0Mv?=
 =?utf-8?B?UTgwbjUxREpuQllqd05PYnBSMWFMdmN6Mk5KV1N4b0owa0JHaHZ3NHZLR0Qy?=
 =?utf-8?B?WnluZjJPVWE4WXA5aHhPd09pREZ5UTRoYm4vS3RXeTMvSTRIOGhaWXVmK2Rj?=
 =?utf-8?B?M2dQZEU3MUhOWlJvYWd1KzZoa21mVkNnRXVNeU8wejJ1YWxkcnQxUHBycjAw?=
 =?utf-8?B?RTNkZDc3WFJqYTVpZGJYMHV4Z1pEUmg0TWw4Vlc4bkdadzYzZEZNUXVvTVpV?=
 =?utf-8?B?WVpGc0lnRFJMWW50OVpKZGV6SFZ5RjFRRCs2cHdNNEpGRVVEZ0k2V1kvRE52?=
 =?utf-8?B?bUo3QXIwbDA1YUtwWGFtUmFuL1FpbmtFSm1zWTBIajZmTFA0eVBtbE8xQVd2?=
 =?utf-8?B?NUQraEdXdi9uR1RiT0hPOVkvMTFPRlEram5XK282OHlYKzUzZEgvdHpCMW1M?=
 =?utf-8?B?eXVaeXdxRVlpeDBVZTFXZnQxKzIyYUQ0RlFPRndiS2wxdVRHc0IzUkJldkdR?=
 =?utf-8?B?SjBZL0dqYkR4MjRyVEgzZG1NcUZRZ0lXdkFwdHB3RkpMSW41Vy8wSThMaitJ?=
 =?utf-8?B?ZllsWElZTWVLclcxV3JnaCtHSVVlY3BWTy9MdTBRVDBkbUF5QXZNYkJxTHBS?=
 =?utf-8?B?NTNMRTRzby9WOFh3SjE3Rk40dWxCeEVIUzNVSVg1cFdqSHlwV1dNYTBHa3Uv?=
 =?utf-8?B?NHJNZGlYQUprSXhPZHVuTll0dzUyTUJLWWtuck4zVmZVS3VjbzM2R2xFZC9r?=
 =?utf-8?B?MGVNamdoeFhpU0krUENRZFRNSVRWS21OR3hpNjg0NzQvV01HRDhDQ1N2UG5U?=
 =?utf-8?B?blBLQTNzQkNpNjFST2E5ckNhclpyaE5EUlhKTWxCeVo3UWVIUGlnQm8yZkRt?=
 =?utf-8?B?QmJ6NDM2NU53QzBJOGRHWFViVU1sa3o3VHlaUkRubHBORVQ2SUFIcVgwQVBp?=
 =?utf-8?B?OEthVURTM20wbXp0RXNmajhMQkNWL3lXK1R6VENrckYxQjM2eGt6TWpDVXBr?=
 =?utf-8?B?SXViOU1LNm50MVhEcUYxSkZjVGxsSERPWE9KUkNzZVZUd3RnSi9XWHJlQ2Qx?=
 =?utf-8?B?c2ZVM2NybEZVRnNONXlkcGJqNEpKcytSTVRudGtFelQ0UGJ4WTVBSVdVWWVV?=
 =?utf-8?B?dXdrTUZ5TVF4VndTbUZleHNHM1NzdVlmaHlaRFhOS04rL0xUdlJIdUtmZ2lp?=
 =?utf-8?B?ZnR2VVhwRjVtZ1J2eTJxYW1MZE1YUUJ0VUhvZ0FYb0tUUklXb2daMmgwVWVI?=
 =?utf-8?B?eElaZUtEcGkwL1l1L3pIOTQyeHo0QWhyTFVXL0RXRWZwZzUyMjhoUU83Z0kr?=
 =?utf-8?B?L3pONmhQWTRjeVNuZ3ZoOFhvUkdjVHhsQ003Ui90VDhmWUg3NzM2MlBCK09l?=
 =?utf-8?B?bEZHSlZSZ3dnV3BnU0NrVVZ6YmNZcHhkNG0vNkdyR3pUb0lIaUxEK2NzbjFt?=
 =?utf-8?B?NUUyOEVZbk4wT0x6UTUxekh2Nmo1QVFscWUzcHpEcFVncGFEL1ZDbEhpUVBn?=
 =?utf-8?B?bE51NG40UkZKZzVTWmtzejdGd0R1TUpzR3EwTDZKMGJGMzBDQkJXMXZ5Wldw?=
 =?utf-8?B?Q1V1cVg0RGg0clRLWFZsQndYMXozVVQzVzlQTjk5Q0d2ajMrL0J3NXpNVGdW?=
 =?utf-8?B?V043b0hnUmxtLzJvMXdnRnEyckE4bHpDbGJBZDc0bDNydHpxbENhQzZsVmVs?=
 =?utf-8?B?aU5YSXowNXU2NkpIWWdpbnA2ejVsNWVLU3FyQ2N5OWF4cmpJYS8zMzNrZm9r?=
 =?utf-8?B?YlZoYjlIcVJGNTBKT1VLVWVUWE93ZGRmeTFiazJrS21rMmpxa3l3TWlGZ0ZD?=
 =?utf-8?B?c3NjVGEvUjJYR3FZM0J4QjQ2YmVZY3hUbUNlWm56cGkvU1NFeTBNQ1hPZHY5?=
 =?utf-8?B?WWdhVWdmVlpDR2FJQWVreklrZjVLVDVycEJnN1JqeDAxL2llckhtbmUyamts?=
 =?utf-8?Q?nsBiYPWYBiZZ4oRLNvHHDfz13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0489c77-4ce8-4530-a24e-08dcf82a9990
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:01:43.1588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: izNGqnr9Op2gWX081eKMGShXE6/fcewWnjFxY3PAYryB96OUuAy+EqxCxGT9nU7gRl/aucXnkgyvINlb6iOpqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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

--------------c0iXAuCUfX1l1aakiQS03XUm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/28/2024 5:40 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> To allow user better understand the cause triggering runlist oversubscription.
> No function change.
>
> Signed-off-by: Xiaogang Chen Xiaogang.Chen@amd.com
> ---
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
>  1 file changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 37930629edc5..e22be6da23b7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -28,6 +28,10 @@
>  #include "kfd_kernel_queue.h"
>  #include "kfd_priv.h"
>  
> +#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 << 0
> +#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 << 1
> +#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 << 2
> +
>  static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>  				unsigned int buffer_size_bytes)
>  {
> @@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
>  
>  static void pm_calc_rlib_size(struct packet_manager *pm,
>  				unsigned int *rlib_size,
> -				bool *over_subscription)
> +				int *over_subscription)
>  {
>  	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
>  	unsigned int map_queue_size;
> @@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
>  	 * hws_max_conc_proc has been done in
>  	 * kgd2kfd_device_init().
>  	 */
> -	*over_subscription = false;
> +	*over_subscription = 0;
>  
>  	if (node->max_proc_per_quantum > 1)
>  		max_proc_per_quantum = node->max_proc_per_quantum;
>  
> -	if ((process_count > max_proc_per_quantum) ||
> -	    compute_queue_count > get_cp_queues_num(pm->dqm) ||
> -	    gws_queue_count > 1) {
> -		*over_subscription = true;
> +	if (process_count > max_proc_per_quantum)
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;

I think you want to use the Bitwise OR (|) and not the Logical OR (||) here. This will always set over_subscription to 1.

Regards,

Mukul

> +	if (compute_queue_count > get_cp_queues_num(pm->dqm))
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
> +	if (gws_queue_count > 1)
> +		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
> +
> +	if (*over_subscription)
>  		dev_dbg(dev, "Over subscribed runlist\n");
> -	}
>  
>  	map_queue_size = pm->pmf->map_queues_size;
>  	/* calculate run list ib allocation size */
> @@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
>  				unsigned int **rl_buffer,
>  				uint64_t *rl_gpu_buffer,
>  				unsigned int *rl_buffer_size,
> -				bool *is_over_subscription)
> +				int *is_over_subscription)
>  {
>  	struct kfd_node *node = pm->dqm->dev;
>  	struct device *dev = node->adev->dev;
> @@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  	struct qcm_process_device *qpd;
>  	struct queue *q;
>  	struct kernel_queue *kq;
> -	bool is_over_subscription;
> +	int is_over_subscription;
>  
>  	rl_wptr = retval = processes_mapped = 0;
>  
> @@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
>  	dev_dbg(dev, "Finished map process and queues to runlist\n");
>  
>  	if (is_over_subscription) {
> -		if (!pm->is_over_subscription)
> -			dev_warn(
> +		if (!pm->is_over_subscription) {
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_PROCESS_COUNT) {
> +				dev_warn(
>  				dev,
> -				"Runlist is getting oversubscribed. Expect reduced ROCm performance.\n");
> +				"process number is more than maximum number of processes that"
> +				" HWS can schedule concurrently. Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
> +				dev_warn(
> +				dev,
> +				"compute queue number is more than assigned compute queues."
> +				" Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}
> +
> +			if (is_over_subscription & OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
> +				dev_warn(
> +				dev,
> +				"compute queue for cooperative workgroup is more than allowed."
> +				" Runlist is getting"
> +				" oversubscribed. Expect reduced ROCm performance.\n");
> +			}
> +		}
>  		retval = pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>  					*rl_gpu_addr,
>  					alloc_size_bytes / sizeof(uint32_t),
>  					true);
>  	}
> -	pm->is_over_subscription = is_over_subscription;
> +	pm->is_over_subscription = is_over_subscription ? true : false;
>  
>  	for (i = 0; i < alloc_size_bytes / sizeof(uint32_t); i++)
>  		pr_debug("0x%2X ", rl_buffer[i]);
--------------c0iXAuCUfX1l1aakiQS03XUm
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/28/2024 5:40 PM, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241028214014.59940-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

To allow user better understand the cause triggering runlist oversubscription.
No function change.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-abbreviated" href="mailto:Xiaogang.Chen@amd.com">Xiaogang.Chen@amd.com</a>
---
 .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 55 ++++++++++++++-----
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 37930629edc5..e22be6da23b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -28,6 +28,10 @@
 #include &quot;kfd_kernel_queue.h&quot;
 #include &quot;kfd_priv.h&quot;
 
+#define OVER_SUBSCRIPTION_PROCESS_COUNT 1 &lt;&lt; 0
+#define OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT 1 &lt;&lt; 1
+#define OVER_SUBSCRIPTION_GWS_QUEUE_COUNT 1 &lt;&lt; 2
+
 static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 				unsigned int buffer_size_bytes)
 {
@@ -40,7 +44,7 @@ static inline void inc_wptr(unsigned int *wptr, unsigned int increment_bytes,
 
 static void pm_calc_rlib_size(struct packet_manager *pm,
 				unsigned int *rlib_size,
-				bool *over_subscription)
+				int *over_subscription)
 {
 	unsigned int process_count, queue_count, compute_queue_count, gws_queue_count;
 	unsigned int map_queue_size;
@@ -58,17 +62,20 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 	 * hws_max_conc_proc has been done in
 	 * kgd2kfd_device_init().
 	 */
-	*over_subscription = false;
+	*over_subscription = 0;
 
 	if (node-&gt;max_proc_per_quantum &gt; 1)
 		max_proc_per_quantum = node-&gt;max_proc_per_quantum;
 
-	if ((process_count &gt; max_proc_per_quantum) ||
-	    compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm) ||
-	    gws_queue_count &gt; 1) {
-		*over_subscription = true;
+	if (process_count &gt; max_proc_per_quantum)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_PROCESS_COUNT;</pre>
    </blockquote>
    <p><font size="5">I think you want to use the Bitwise OR (|) and not
        the Logical OR (||) here. This will always set over_subscription
        to 1.</font></p>
    <p><font size="5">Regards,</font></p>
    <p><font size="5">Mukul<br>
      </font></p>
    <blockquote type="cite" cite="mid:20241028214014.59940-1-xiaogang.chen@amd.com">
      <pre wrap="" class="moz-quote-pre">+	if (compute_queue_count &gt; get_cp_queues_num(pm-&gt;dqm))
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT;
+	if (gws_queue_count &gt; 1)
+		*over_subscription = *over_subscription || OVER_SUBSCRIPTION_GWS_QUEUE_COUNT;
+
+	if (*over_subscription)
 		dev_dbg(dev, &quot;Over subscribed runlist\n&quot;);
-	}
 
 	map_queue_size = pm-&gt;pmf-&gt;map_queues_size;
 	/* calculate run list ib allocation size */
@@ -89,7 +96,7 @@ static int pm_allocate_runlist_ib(struct packet_manager *pm,
 				unsigned int **rl_buffer,
 				uint64_t *rl_gpu_buffer,
 				unsigned int *rl_buffer_size,
-				bool *is_over_subscription)
+				int *is_over_subscription)
 {
 	struct kfd_node *node = pm-&gt;dqm-&gt;dev;
 	struct device *dev = node-&gt;adev-&gt;dev;
@@ -134,7 +141,7 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	struct qcm_process_device *qpd;
 	struct queue *q;
 	struct kernel_queue *kq;
-	bool is_over_subscription;
+	int is_over_subscription;
 
 	rl_wptr = retval = processes_mapped = 0;
 
@@ -212,16 +219,38 @@ static int pm_create_runlist_ib(struct packet_manager *pm,
 	dev_dbg(dev, &quot;Finished map process and queues to runlist\n&quot;);
 
 	if (is_over_subscription) {
-		if (!pm-&gt;is_over_subscription)
-			dev_warn(
+		if (!pm-&gt;is_over_subscription) {
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_PROCESS_COUNT) {
+				dev_warn(
 				dev,
-				&quot;Runlist is getting oversubscribed. Expect reduced ROCm performance.\n&quot;);
+				&quot;process number is more than maximum number of processes that&quot;
+				&quot; HWS can schedule concurrently. Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_COMPUTE_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				&quot;compute queue number is more than assigned compute queues.&quot;
+				&quot; Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+
+			if (is_over_subscription &amp; OVER_SUBSCRIPTION_GWS_QUEUE_COUNT) {
+				dev_warn(
+				dev,
+				&quot;compute queue for cooperative workgroup is more than allowed.&quot;
+				&quot; Runlist is getting&quot;
+				&quot; oversubscribed. Expect reduced ROCm performance.\n&quot;);
+			}
+		}
 		retval = pm-&gt;pmf-&gt;runlist(pm, &amp;rl_buffer[rl_wptr],
 					*rl_gpu_addr,
 					alloc_size_bytes / sizeof(uint32_t),
 					true);
 	}
-	pm-&gt;is_over_subscription = is_over_subscription;
+	pm-&gt;is_over_subscription = is_over_subscription ? true : false;
 
 	for (i = 0; i &lt; alloc_size_bytes / sizeof(uint32_t); i++)
 		pr_debug(&quot;0x%2X &quot;, rl_buffer[i]);
</pre>
    </blockquote>
  </body>
</html>

--------------c0iXAuCUfX1l1aakiQS03XUm--
