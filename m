Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D2CCA9ED1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 04:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80ED210E3B7;
	Mon, 12 Oct 2026 04:13:52 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012045.outbound.protection.outlook.com [52.101.53.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC5510E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 04:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3WOhdDsOhNXbg7ymeA/vkXyKg/2Ag2R5MLoiMQyBpLV8NIc6w3c8sbTGfnT90WB4ZrJaFkh2GIk6E55qF0pESq2iV7c8KT1racKLHpSTx4AFP6AmyQGFiQ6SKOWH/0qPGocz6fv2rhhK2NrVXh5nWdeN0QyA3OIqR43eRb2fFNaWVls404wBIzpRT9VrvUeCYVbzeNyYPhnVXNGM/G5NogxEA73aJ65Eija25HM5iKPqjVcp2jd87eOiOhQEylAJQ8XQ/4mVY5XdYpW6skGlydZ5VdkmikjtG8n5PHf6lTTJWUTjKg2Rne6nIxXhIU79EUTjCM8+sfmGSIa+2hGNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA0Yah3UFcIM1Z+t/AZat7UT0mqxyEIyGjljaYBVixY=;
 b=OmuQu8yfUQSnduiPQ5Kay5GAvk2DJOXbfH2hlgaz7DhIla3FfWqdj74/3SVLEw5F5zcuoElr1I8l/1W7MyEXrEZVNF22pdmH9t8GYo9P181MJtAPxBEFnwlMsGQwr/E0CLZL2Ld/EOBkqUPEFGpqD7j6TEDP8GtWETyROAxA1HC52pBQJSxOr4czmXA43LihjKDWe9nciv+hfhM9hu8ONVNrKPC1pxhWiN/kc6lZoL81xZa5qm4WfZ8rjUIMB66D0hTNR8J2eaAPUmfNKoAPzPwpuZYk7t1Y3Lw97Gkuq7d53oRVkyuSIwiBRRqb7uGHf/cpEQZQhazllLdHl2xwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA0Yah3UFcIM1Z+t/AZat7UT0mqxyEIyGjljaYBVixY=;
 b=LiF+oosfqk7CF/r9CJg7UEuKWQmokrbIm0OfcYkHUJOuqJn+lZAN3M+/GHDejFPbeszMiLJJ+PzluoxQpgMgDKNxq75TCu0Ylcybde7Pq0TEdXZHtYsKgdjC6U4C/5u79DeYu9+jjEidtWIMUGeQvxnLgAgWH2QezHfL7KCVWJQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 12 Oct
 2026 04:13:41 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Mon, 12 Oct 2026
 04:13:41 +0000
Message-ID: <59a7f0bb-2b5a-4997-a330-180a97fe865b@amd.com>
Date: Mon, 12 Oct 2026 09:43:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amd/ras: Use MP1 feature status to select
 fw-managed EEPROM
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
References: <56d3bbcf940024032faf81b5bf0732e9a45db483.1791769175.git.cesun102@amd.com>
 <BN7PPFFF39339DD2D9ED47D5524EBE2B0E0FC9F2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN7PPFFF39339DD2D9ED47D5524EBE2B0E0FC9F2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0235.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b1::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7c4250-b994-4cdb-8169-08df281732df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003|10067099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: JXWgLMO/kbC6I6mS2ZpkOCivEk5hE3B4CVrKrDNtq2TaDl0ZoEsOtEfNFTTk7sVjJhAaO429jNEip9Q9aAu2n+5mB2capW6CUeeDgsQoHJs3Z0vNOjjMnJUjAIEk0o1U1RwrOjZVzhSw6t5/V5VdzYgGIidUl76nx5+i2ZlDnNgcerXAPVJJ7tRDCZtVxSHDqbKrSneIUXUN/MtkvTf0+gQexwtg99pQe2sESdmhwY0jwvDcZBoXJU/EqSFmL8SkLWsWzIwzDUY4W8ljPHSsbW9W3JVgpvrZa1x6mxyBEs3oW0Qji/UHXCNMeictUpOHpje7WWwQEPQph07HDZblurGBp/3p15eq9xx02APK1GpEU8RO7IOJJajM+ta6bu2dW92Qnw1dDos1R9YfKWWQL78u259ly163W4ILHQcbE2UpoXd0W7XyzzaYvyvp8IjWn8pjE8x6SGViKJZFIkTWvQO8w7Ow6unPzsXOmeBGW3Y7rUTp/FDBFhVIzt2CgCjf/y0J9bXUZ28/+4Z9wEsoFE0bVwd5wqPxuNRv5z2yRBJDq1vZDP76xA60jArX4hAX71VwFo+e/5L/GzQ8Xo6e3y5Jl27i3qYxjuXYCwCi4xoqbJGkgG1x4a/tBBGClr0D1bangKjID4IMSxC8Pbc8Yia5xGjgxHPy8yOkaSZwghM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K21hZUVDSFk1WGRCRkxNWFNCSW1qWnBEd3pTbjFialcvSEdHUDRzbG5ROU1k?=
 =?utf-8?B?YzJJY1ltcHl1TmNsN1VNZTlvZUx4UXllaUs0ZStoRDh1N0dLYzhnK1E2VTA2?=
 =?utf-8?B?K1ZkTjZJa0I1S1ExRFFMcndWZFRzMjFqTkNONms1dTNMT2t2RmRmZ2JuQnVS?=
 =?utf-8?B?Y0dUa01RSWpQVlQzaXl6NVVKREM1UHpUWXh2ZThaRjA2MWZKMTQ2em5oMThM?=
 =?utf-8?B?anl2MkQrWU1DTWx4UlA1NUd4OVJFRVp3aWRZOWNIUSsveG9ORjlKUm5UaGxj?=
 =?utf-8?B?VVNjVFIwR2FwNEhkMjBmTWZobVhMWjlkUGJOR3hRcUpXSk5UYXJmelVkVnJl?=
 =?utf-8?B?TlliT0xZQ2UySXMvTFE0VS9Sc3BBa2xYYVcyUEJXVWlsMG5Ld1BUTjhISXp3?=
 =?utf-8?B?SEVJOU5UMEhKNDN2SHVBaDVJaTkxc3k5VmFnNzVkWjZub1dXcGlHbzJ4a2xP?=
 =?utf-8?B?TVM5bUR3UXlZdis5ZzRyY2pzM09ZVkVnWTRuVVd0WmRmVEF4c08yd0I4ZHl2?=
 =?utf-8?B?WFpBaW9neFh5SjRaOG81UE5Yek1hS0JlaU92QnNIc0lCcVpIMzNBVHNUZGhD?=
 =?utf-8?B?bUhwL05DcTdSWGcwSEtvR0d5cTg3ZkdwM2s1dkk1SHpGUGR2Um16VFF3RFlT?=
 =?utf-8?B?RysyS2g1V3czQm5rYWxwandaUVg3UHVtTHRaUFplK2dJbjU3V3RxUEZCOHdM?=
 =?utf-8?B?aWlEaUxjcTVLVHlsVW9tWjNaRTdqZHRobFh5OG14c3hZY3h4Ukw1NU50Wi9K?=
 =?utf-8?B?VlFudTJGZTVkY2QyTHArUVQ2dXZqOTl4U3MrZ290Wk8weDluak5GYTQ1cVB1?=
 =?utf-8?B?cUhTa0xKUEY5UjM2RHcrZ0dweUtJVEdDZUNRS3Q5Zms5SE9PYnY4aDJWYmxY?=
 =?utf-8?B?bjNKMUY0WXg5dDNST0NIVmZCaHRSb0VNZHJ1aEdWVTNuVFJud2Y0YWFVN2RO?=
 =?utf-8?B?YmMveURGQTFJNGI3c0U2RnY2Tnhpb0NyK1RuTWluS1hmN1JNOFVveGFpdHdK?=
 =?utf-8?B?T1pWZXNYYUVmTWlxRThMQmVpTWllcGJaaFc4UndEWXk5N2tQeXdCSG8xbjJQ?=
 =?utf-8?B?ajJxR1JKajBRaEwrcUtVNnBVU21KRXllWWtKRjBFNGhQVXJjc1lYaUhTMnhP?=
 =?utf-8?B?Wk0wZFJqY0ZPSGN0enp2ZVk4U0FWdHZ2SFd1SitTMmJSK0Jocm1iNy9PV1FH?=
 =?utf-8?B?N0UrWnk3SVluUk9XejhTMmpEenRHSnY1L0trbUlDeGFLTWJhSDFEU1JQcU80?=
 =?utf-8?B?cEpQUFhGMTl4bm1SSUYzYTNvNTBTVGRSZmlremZpRFQxbGRKVGxxUXVaY2tW?=
 =?utf-8?B?a3FHYTh0emNqbTIyOTM3WWtHY2x6L2ljb1JTbjVKN0pTcWZrU2hSU096QVIx?=
 =?utf-8?B?UW1BOXVQWmFLaFJXalJ3NS9SMUg0WDhIbkNYRy9TaGpJUERrSEZpWXlrRkFu?=
 =?utf-8?B?alBhYUt1OVI0Qnl4OVVPT3FZd21oem9oMHlibERHRVdMenBxQ3Y0aDYwcXRo?=
 =?utf-8?B?NlEvUWlXZzhQa0pOZXQzVG9tcnpibGZVMml0U2NvVTRTRTBrR3BFd045a1lp?=
 =?utf-8?B?RWw5Sk0yZU4rR2ZVTm1DTVZwY1d6Rnp0Z01HYkZlRGt1Q2FhSFhwUEhYOWhZ?=
 =?utf-8?B?N1d3cHhHMk5yRktkM2JjTTZHZm9OM0VFUzRkbzhIcVpRNW15WUhNVGxEQXhs?=
 =?utf-8?B?Z3ZMbVNnRnBIUCtmYmp6YzlsbnNyVkx1VGRjNUROUG9nVHZYNWUyRmE5TnBh?=
 =?utf-8?B?RVBXN1M1ci9CaGduSWk2WFlqS3pZVHFvcVR1cGxJWnFpQ3hyekFWNXNsS3dl?=
 =?utf-8?B?aS9QdGx2OS9NVlVNSEd0em5nanI1cytrRjJXVWtMMEdWbkFFWjVLaDUxdG5L?=
 =?utf-8?B?NjlqbzcxZ1lrRVlGZ1hTTTdCVTdCRzFWOHFWd3BiZ25LcCtJYnpqcEt4UytK?=
 =?utf-8?B?bGpUaUN3dDZZZGI4UWlCaE43eFZsY2p6NjFNQ0ROSHhsR2w5Z2dLcUNjZnBq?=
 =?utf-8?B?dkdGOUNzNU1neExzdmY3d2UyNlk3T09xeTRyMHpROG1Ma3Q1MjhmQTNlQ3No?=
 =?utf-8?B?NEcyM2t4NVNLZzltNGNRUXRpcDEyVHRhcm9PZE05cmFITER4eTZ3dDN3TDlh?=
 =?utf-8?B?T3dvT3R0U0tPTkdIM05KZk1oTHhtS1FUc1owL2pSK2VySFBtRjZuL0RJN0g1?=
 =?utf-8?B?Vk5ZTmxBMWVweXAxN0VKcGl6dW11TExYczhMN2MyZkhuTWZqY1BvUGZsM2hL?=
 =?utf-8?B?Wm9NVFF0cnFrM1VoQ2VzYWlkTExGVjdZazIzcnViaXp5KzlHeTNLYnh6ck1F?=
 =?utf-8?Q?ggoJA1iGyAYbqx2ZWA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7c4250-b994-4cdb-8169-08df281732df
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 04:13:41.6496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Cywu9c/h545/mqptvdurl5i4K14WdvcjWxQa49yQyohURHCff4mekolY620JjBD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6566
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



On 12-Oct-26 7:30 AM, Zhang, Hawking wrote:
> AMD General
> 
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> 
> Regards,
> Hawking
> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Monday, October 12, 2026 9:40 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH v3] drm/amd/ras: Use MP1 feature status to select fw-managed EEPROM
> 
> Read the feature status of RAS_CORE_FW_FEATURE_BIT_RAS_EEPROM
> to determine whether to use firmware-managed EEPROM.
> 
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>   drivers/gpu/drm/amd/ras/core/ras.h            |  2 +-
>   drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 23 ++++++++++++++-----
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
> index 73e3960c7c8e..1b724aa23594 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras.h
> +++ b/drivers/gpu/drm/amd/ras/core/ras.h
> @@ -60,7 +60,7 @@ enum ras_gpu_health_status {  };
> 
>   enum ras_core_fw_feature_flags {
> -       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = BIT_ULL(0),
> +       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM = 0,
>   };
> 
>   enum ras_block_id {
> diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> index fe0e35357af1..e1b70dd7b819 100644
> --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> @@ -26,6 +26,7 @@
>   #include "ras.h"
>   #include "eeprom.h"
>   #include "eeprom_fw.h"
> +#include "ras_mp1.h"
> 
>   static bool __ras_eeprom_disabled(struct ras_core_context *ras_core)  { @@ -36,25 +37,35 @@ static const struct ras_eeprom_ops *ras_eeprom_mgr_get_ip_func(
>                                  struct ras_core_context *ras_core, uint32_t ip_version)  {
>          struct ras_eeprom_mgr *mgr = &ras_core->eeprom_mgr;
> +       int ret = 0;
> +       u32 status = 0;
> +
> +       ret = ras_mp1_check_feature_status(ras_core, RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM, &status);

Feature status check cannot be done at this stage. Anything which is 
dependent on a FW feature can only be checked after hw init phase after 
features are enabled.

Thanks,
Lijo

> +       if (ret)
> +               RAS_DEV_ERR(ras_core->dev, "Check RAS EEPROM feature failed, ret=%d",
> +ret);
> 
>          switch (ip_version) {
>          case IP_VERSION(13, 0, 6):
> -       case IP_VERSION(13, 0, 14):
>          case IP_VERSION(13, 0, 12):
> +       case IP_VERSION(13, 0, 14):
>          case IP_VERSION(13, 0, 15):
>                  mgr->eeprom_early_init_service_supported = false;
> -               return &ras_drv_eeprom_ops;
> +               break;
>          case IP_VERSION(15, 0, 8):
>                  mgr->eeprom_early_init_service_supported = true;
> -               mgr->fw_record_enabled = true;
> -               return &ras_fw_eeprom_ops;
> +               break;
>          default:
>                  RAS_DEV_ERR(ras_core->dev,
>                          "EEPROM(MP1) ip version(0x%x) is not supported!\n", ip_version);
> -               break;
> +               return NULL;
>          }
> 
> -       return NULL;
> +       if (status) {
> +               mgr->fw_record_enabled = true;
> +               return &ras_fw_eeprom_ops;
> +       } else {
> +               return &ras_drv_eeprom_ops;
> +       }
>   }
> 
>   int ras_eeprom_mgr_sw_init(struct ras_core_context *ras_core)
> --
> 2.34.1

