Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC941D767D8
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 15:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6B610E18E;
	Thu, 31 Oct 2024 15:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0QtsNEY";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BC3810E18E
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 15:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZYxHI2fLvJtWew7u3RbFZi8lbYWG1s0UFojIROoqc8UvQIlQyz5ILlOb7UYP7ysbVzxtWbbajHBHsE21O8gWAVnrr27fN6+/8E46+gPgtYFXzbtGNcPYbmhs/4ApsD/tmbLBhVvMyvUn9Vi1kET9b6mfwuxK23fJY0fVYlgITHhfGSFAggtR94oe+z0JVGS01B59hwDHSmN/A+9jsjzPg5nxq1ExtSFzrxCdryF3G7VZqfbCcSrXbd70dHpOCPy0cpBZJ6bE9qQ3jK03wf9y0CGXU45MiFnMK7kV28YrynpXAJ0+8G0JmW9lCSHU4Z064QYKiF28JN3C7e1knuFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/qSwK+PhCSYYPzsaxeoxLVZv5FR+yYer05kZwnZoCs=;
 b=f2B4d9BegxGfzWPyJOoyetI4CoocyeXgJ8A2B0D2g3/CXzlHfCnjM3khp/fPIwupWAiIYw3WXHCOFj6DJ33ZFl/XDBlSOW/UnIuTFTrIVHZNSbN18BN3RrV9l9YsMCX1PqOnis+Ch0Kxqu/ev40KDlEva+3f1u0R1KVaMJcqrpj4uVmhKDYbs9yeMm0Rczf6cyd86LAOrXmh4ETL+doLtlXuNK4887zh84GUPellhL0XULU3s7zHxLTh5gIRatCs3LxEZcHhQdsVv9jGRlkQB0r/pZ4rx0aChXHyCPDHKsrqHCDudzkD0Sh29/26jNiUfOC9GeWmN1H8i9QJ6k6pdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/qSwK+PhCSYYPzsaxeoxLVZv5FR+yYer05kZwnZoCs=;
 b=V0QtsNEY0MD1DAIXFzJW+rFByYm4tXx39uZVqdsj/3PpD+5cCMvcmzX2BhQLCjzu6j8gR6Z4NVKugQAzOj387K3tGY0/MLqsImqiLkzjGlOJyPsdxIEcPJVov9C60jn1QDKjdC4DqF/KkwNHgdZ/Pufb/xhkurgcsVPYjvPNn84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 31 Oct
 2024 15:27:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:27:27 +0000
Message-ID: <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
Date: Thu, 31 Oct 2024 11:27:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241031104701.248234-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8d7d24-f9a8-4309-e2bc-08dcf9c08734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmZyZHRGMU1WYllxU0ZpWDlHRzhwbXpCMmgrNFlGMFNPTHp5eEF4UlI5UmZl?=
 =?utf-8?B?VjRRTDB6T2d0ZjZPUEN5L2RTaGhueTF0ZjF4TG5MTzR0M0JBSkIxOWRjTjU2?=
 =?utf-8?B?MXR4dExKR0ExdnMzcmhvSTdiY3ZVWHU3YmN2RGJObVpCeHZjWFVHbkF1NVdF?=
 =?utf-8?B?amdENDNLQjZ4dGN0aXhlVWFFUGZoWmMxSkhXOHJlLzFRdVAwdUNvVVFuby9F?=
 =?utf-8?B?QmdHaEhKUkxQSExXZHhmRjZIV2k4alZkUGVSODRNZVJvaHExWnF5eWFKREFp?=
 =?utf-8?B?UkhNeWZsVGtzc1ZudExzTk15aGVUZmFsTWFaamV1YzVFcEhYVEVrNXBUcnFv?=
 =?utf-8?B?YkpsSUU4bHVxZUJxajI2YzFVd0RMa3BEaEFXTTZ4eW5adkRjRVFXSnU4QlZU?=
 =?utf-8?B?M1JXc21hL0Z3NjBadjNQVFZub0Nya0hiVndqN2xlNnJXVGlxZGtSZUxpbUhW?=
 =?utf-8?B?aGE1TTk2Rk5udVBGOGsvY1JVSGhHdnFsSmtlYkZUanZUeHJCcHFza0V3ZVlo?=
 =?utf-8?B?ZThhMGRkcUdWZE5KcDE4c2dHUmJiWXdrMEpmSTV5K2RuWk5GVDZyMHNKSWFS?=
 =?utf-8?B?UEEyNGREQ0RocE56STJRMGRLbC9RNEFaTFgyYzZLZi9TalVpWG5TVEpMb28v?=
 =?utf-8?B?K2pmL3BlRXFkc3VwcmdhR290OFk0TTB4TnJoVjRzOUNidUFQM0s4WEJmVjJk?=
 =?utf-8?B?VHFiNlFteDdOdmlOK0V1QklEMEppa25MTmR2cGs3TEpWTWVQcUNPY3UzUmtz?=
 =?utf-8?B?TTNBcGkxOGU2aEdNSjd5eDVBdUdONUZycVVwTlVObjN4Ty8vcGROdCs0d0pI?=
 =?utf-8?B?OEhYVzJYazJzRWVPYjRJZ2traDB4MU5ncmRtaFYvWXpxOHlSUEN1djlUVlpu?=
 =?utf-8?B?SzlhNU4yUHRsUnRyS0pTTVZBT0tIWFNZZHpmczVUYWVMYVlEUFJmV0RRTzgy?=
 =?utf-8?B?T21SY0RNOHFRNFpWenF1MytMbytGYlJMb2Q0Nk1VVit3azUxQlYrTGczRkE5?=
 =?utf-8?B?c0k1RWlqYlMreXJ0dEU1bHhJbGJjcERmLzN0ZVhydkwrdXllam9HMytDUCtj?=
 =?utf-8?B?MXlCd1ZXNEtvQWxLNHpzeGpQWnh6eFJ5WkcydTB1c21XbDF0YXBiVFJrSU5D?=
 =?utf-8?B?VHpjZ1YvQ0h0Z05zZWQ4YTRqeHNmak1LeTFWWnRnNlNHOVUxSUtINDhEdDlD?=
 =?utf-8?B?WTF0RkhNUzA2d0dRb3hvWVRtNUlETDRqL3dYS01YaW5aMjhyM3hDMFAxUlow?=
 =?utf-8?B?b1lsVW01dGdRQ2JON1ExeitSRWQ5bVhlRzEvVU5tNlVTZ2hLZFA1QTZVYytG?=
 =?utf-8?B?dU44U0N0eDJTU3RER2wrdzc3NTBzcE9PUWZXTG8wZkpkVE5Nbzd2S1BPQnFM?=
 =?utf-8?B?akRpa1NsVGozTE1HalFhZ0doQUZPWkF1TkVYaGF5Y3duWmorZzVWdko5MHZH?=
 =?utf-8?B?OWI4cnFSeTFFNVdtOHdJZmkzTGNVZUhSU1ErMHkzWFBQdmpkTUpBb29kWCs2?=
 =?utf-8?B?QklhMTE1YjNsK1l6dkNNWHJpeUdnUnZYbVdyNVVJb0lMblZ2OCszbGhiakdv?=
 =?utf-8?B?Sm9rQXM1NWttVkYvNjV0MmFtNnNrZDFORkxxeTlTUW9mbUEyN20wR0h0ejlC?=
 =?utf-8?B?U3FVSmJDeUM2dmo1VzE1V1hSRG1PaUlxVDNZc3pHVzJxREx6VnQ0TUtENW44?=
 =?utf-8?B?ZFlpd0VMS0FqaXZqU3RUdmhpb0NtOVJNTnhCcXByLzZBZCs2WExEOWtKN2kw?=
 =?utf-8?Q?MVe7NBqKnCJViln8ugPaLUYyxRnQijCZ1Pmlutl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M09SSUtwOTd4MEdWYjhKSWpvcUswdkx6bFY5YzlBNUFIbmZGWndCU3VVNjdx?=
 =?utf-8?B?RS9yL3RUMDJvYm10V0NsdngyMldETE41V3ViVU1TVzU0TkFDMnFxQ2tIZFhv?=
 =?utf-8?B?TTZpNmNINW9md0dXY1JMQzJDMDhmS3puL3FPQW9EcVYxb0J2TXM0MDRYbXZq?=
 =?utf-8?B?MjRmOFA2UXpKV2l6djd1SXRJM1p3M2VXcnlMbHhTTVBWVFZBd2ZnOXJQZFFL?=
 =?utf-8?B?dmF6c0hTZ0xMdWdNUXVZTFV2Z0RibE05Wi9XeWs3N1lFNEx6K29ZNzFOZDZp?=
 =?utf-8?B?aXV0aStpdjdHb01ZQXgzN2wyd1NiWldyNmpDS0lDdEpKQVVLK3lJbzVPRzhP?=
 =?utf-8?B?bnRFYVYxU2o4elJ6b3VOSE12bVVmaFlrVlpVdUwreGUvb0FXbUJKQ0ZlZlB4?=
 =?utf-8?B?OGZ6dkwxb1kxZ2NkN09UdUd1RFJNbE4yYmNrWmJNT2VrN2piVjNVbFM1ejdF?=
 =?utf-8?B?VjgxempJSEJwaHBvRHZtd1BKdkRKYUs1YzZ0a3Rta1VqSmlmT29xeFVLZlA1?=
 =?utf-8?B?cG5uWjR4alU5cnJYdXYwczBFWmZYSXJvR1JXMGVzSkFWTXBBUGdrekRsVHVU?=
 =?utf-8?B?NE9mY3ErdVhOc2cvRkpCL1FQZkRCNVQwd2diRHVaNUV6YkJqTkFJN1UzdHJY?=
 =?utf-8?B?SU1DVUhvQnhWdDlpOElnamVPZnpjTUl5RE1vQVAvWExLdzR3WDhRRGZiSk14?=
 =?utf-8?B?YWEydVF5bEprQnB0NjIramwwT3Q0d052bW9ZMi8yZTlaNC9wS3d5NjI2TXF5?=
 =?utf-8?B?cGxZcjhHaUZweFRXSlBmN3JlVy9BZm9ZdVA1ODhwUXVBNTF2NUVYWkoybFlQ?=
 =?utf-8?B?eUJMMlRMWTAvclo0azl2TzhtbFRXWVZGVTg5SHdsMEx6U053b0NzK3pDKzdJ?=
 =?utf-8?B?S0hYMjRZWHliZFpKK3lzdHMrRS9xY3BsRjFGdFJ1d1JxdDArVnpBcVFsS0sw?=
 =?utf-8?B?UFJzdkN0WnFGbVRBaHI4YXpzdjRlVEhqZ2RCM3c1N29CM2xSNkFnM1ZSRDln?=
 =?utf-8?B?bnVnYkZnN3RCdXdyNGpibTdGSTltR0dsU3NzVW5IRlVYa1ZZMVMxcU4yS21W?=
 =?utf-8?B?Mmk2VmtNcGMwRnpkQ2tDNmpmVWI2SFltZWhKMmNhQVNyQUtYeDlaTHdza3Vt?=
 =?utf-8?B?SXpmaTBUR256b1hNMnhJSG12cUF4YzJsOGM1ODFxV0dJcmN2L0haUmJ5dGlo?=
 =?utf-8?B?NlltNmtQcWxpdWkxS05ZK0ErQlovdE5SMjFWcHViZFFQMG94Vk1Wb0NHZkJt?=
 =?utf-8?B?bzkzWnZHYW94RGNDSGQ5VklIQmdFRWNiWFhIQ0xuRERyUm9UNDdIWFR0QzNN?=
 =?utf-8?B?Ym84U1JVeXNFU05SODJFVm5xZzQwcldLUlZhVE9VM1NhTjRpK2E0MkRndWZW?=
 =?utf-8?B?RjliOU9BU255V0NvcEdva01aeGd5T3Y3UERlUzFmSkZVb0tpSFhsSEJZcDAy?=
 =?utf-8?B?VFdaRHFMV1hUZmc5ajJhZzd2bVA4Ymo5eEluM1VoYUpVbkc1VDJ0MUFPOUhx?=
 =?utf-8?B?ZUMyNlFoQ3paUmNKMm9FbVA0NnRPRFU3V05UZCtqQ0g4M3BpY0d1RE92Nm94?=
 =?utf-8?B?anAwaEVIelgxVEVZRjEvMzJHclBSN1ZQMTg0ZjFCcjRPSW4ydENoVWxtUmxX?=
 =?utf-8?B?M0ovQWN6S1grTXJpeXBwNEFMeWdsc2hjZ0FaeS9IREt0NlV5dFJ6WDVHeWhq?=
 =?utf-8?B?aENrKzZFQkg0eWw0NVIzc0RPU2VVNTFQaENxV0ZGc2pTM1pDV1E1WFgrRjdN?=
 =?utf-8?B?ZGtkL290NDM1enRBNW5ZQzhSRlg4RlBPQ3JtTXdQZnd3QTRsbmh2aEVzRUtL?=
 =?utf-8?B?YmNIcXlXOXdvVHF4V0hQeVlnVUtXK1lGalJNbEZqQlVkMENXam15Rk5hOGdk?=
 =?utf-8?B?RFJRT0Nwck54L2ZWeDVLckwrK0Fhd1lSTmNiWEFSMkovbkhQZGcwR1VrUEdu?=
 =?utf-8?B?ck5tRkZGb2RYcU9RaDA4dUE0VkxPcGJCaHg2MXRIYUxHSzhUYVVIS0l3NXdY?=
 =?utf-8?B?YnpEM09zZ2JXSnBWNStmd0d1UDQ1YVpBL2szbm43TS9MeW9JNTFyY2ExdnJi?=
 =?utf-8?B?MzhiYXhRTHY0OUhRT2tWclRVNmp4bTBBcGptVExraldoRG1GdnN2UEdDK0cx?=
 =?utf-8?Q?+mR65DP6ai67+5GrN+TG5b4gY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8d7d24-f9a8-4309-e2bc-08dcf9c08734
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:27:27.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+IvQwKWQyIzeaOvI6t555B6q/tUkdQdimeXqhCunbG0NiXpVtPqPxonbgkDyyGwbYHh6PjBvkDuEUfLwume9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008
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


On 2024-10-31 6:47, Zhu Lingshan wrote:
> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.

I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?

> And it is actually not a file in the source code tree.

If it's a file that only there on your local working tree, maybe just clean up your working tree.

> Ideally, the usr version should be updated whenever the source code is recompiled.

If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.

Regards,
  Felix

> 
> However, I have noticed a discrepancy between the two headers
> even after rebuilding the kernel.
> 
> This commit modifies kfd_priv.h to always include the header from uapi to ensure
> the latest changes are reflected. We should always include the source
> code header other than the duplication.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 26e48fdc8728..78de7ac09e8a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -32,7 +32,7 @@
>  #include <linux/atomic.h>
>  #include <linux/workqueue.h>
>  #include <linux/spinlock.h>
> -#include <linux/kfd_ioctl.h>
> +#include <uapi/linux/kfd_ioctl.h>
>  #include <linux/idr.h>
>  #include <linux/kfifo.h>
>  #include <linux/seq_file.h>
