Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236EC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0647410E223;
	Wed, 14 Feb 2024 18:47:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M4MEfnpr";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7A810E0C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:47:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjuJndYx3P0q9zZt7m0HXkB5/k6VICTix+s8sxMC+irquitsT31CFQvtLxOTICttmnRpgHGG/oyREkQTt7AjnZt4rvQXoGw7JNrOPYCqWVjgXz5PNU3UernRP49RhgORFTUyAEjEamxDnVc6ML6RPfDDEJjk/qK16eqvCU1vhpD+12eNSuAQcFshOX4SpPYsqvLMl2Cj0GQStXQbUI1kZd2un3hGvPGLwnk9guT3mDieG5+07G+Tv+mOuJzjJltmPbkeOFaHDeVFez0jeZ4WwoSkJS7Omyhd5OFcIkVO2r0f9zfw4CzH0BqabNphWLA4DFxYk/fUNEMUnZ632GObSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5rfNAdCvzgh+oZstKrDgQwiFXP5Vb1ALYrHntDVZTY=;
 b=NAz71sg+dgK1pn+9kcWU9FGlWz7k+l8oJcwanzx/XR4RGEWwMcHb59QK3KwbMK7mKYAFq2vfL0JmZGaRLNdzEU5hXlfz8bbpkOpLK5e2UJSpKrYmC/eksTrF4aJ1YbCNDekCHI/D4xiGNUxvQOqvt6Oo0bbo45OZZdXwaPaIQMVf5FG5sqs2Rvl0KMb0YvzDghFCIYlxArl2sOwv0VU9Fw4iBQjPSug/A0XsTmPULPefdJXeENVmtLwDNUIt0uI/8BaVaH0mPuLTFy0CwS4OsYMv9R0Xhd2Ts9j1ypBG8KKh8mIpR8RtaH+gzd+s2bCb7L0PLpXQIHAuJV9VQF2yIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5rfNAdCvzgh+oZstKrDgQwiFXP5Vb1ALYrHntDVZTY=;
 b=M4MEfnprgyVYK2Qrj+AL4N+N34FiPiTnOALT0E7yxcpjHpqY8nCOedKbAyxm+EynKuC7NuKdCiFwGAObdww1D409WQDe0ZA2s6dQfxU/Cw00sfQYigdl66lDq/b9vQVlqhWFHWlhQRxOR8uXGp5gJsABKwJt9rsCOuBI4bdfS7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Wed, 14 Feb 2024 18:47:04 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::3301:dfb9:528a:1fa5%7]) with mapi id 15.20.7316.012; Wed, 14 Feb 2024
 18:47:04 +0000
Message-ID: <1608e6b9-9ac2-4f32-a37b-bd487cedfad9@amd.com>
Date: Wed, 14 Feb 2024 13:47:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/amd/display: Add SMU timeout check and retry
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com,
 roman.li@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
 <20240214184006.1356137-5-Rodrigo.Siqueira@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240214184006.1356137-5-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM8PR12MB5461:EE_
X-MS-Office365-Filtering-Correlation-Id: 941e04e2-df4c-48da-ea83-08dc2d8d566a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD7NE3e/l+bYUxgq1t9VsjwrjOtJXtDc6p/uJMKW5Nhtmlw7cOjkM1PTz73MKYIHeYLHxR3yfyB3s0p6u73M4BTkDilD220+qO/jokGZpNGz7VaJj35luOZarUNw5iR+NIs/luuR5yc/9GJ/5G3dT5ByNmiz1gGrDuFJb/SL1urLoyvxsUOD6wiju1mRsseLgDWJE5Uk+oc2SPhA4MdRvxdgJlqGrPOftDl5Jwha1xF3HZ7MWQo2gEmBnfMObpVgvbudhc866lUOQ0yiqzsHMxGjkjydP3R+KLju1nB0lse0edEeglhGLDDmlKUAnntlvCdsqsdUR9KsWzu41YdkaV4LtkSAiwWrshaFS46MHB+7u7sXZ23SKRektLNPY33edS1IevcUzoBJ5Rt6KdJRQrcDd42myKqzCSkCO7gkTy0Jqf98VfSgfgmktDM7bMTBF28fu+EdU1slGbv0Az8ic59I3NYtegE0M4Pu4EpGZqrtm52Sx6FlcRmgBrfCC0AMtkAggWmeqtLlxy3xsz/GAbLUHHB5yuxl7sNrlh7oWehnIqbDYuEyq0znxotkWK1H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(8936002)(4326008)(66556008)(66946007)(66476007)(2906002)(83380400001)(26005)(38100700002)(36756003)(86362001)(31696002)(316002)(6666004)(5660300002)(2616005)(41300700001)(53546011)(478600001)(6512007)(6506007)(6486002)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRwaVp1dlY5RW9qc0FXMWtOaWl0bmlJajdvOXY0YU9YSXZsNFI4ZURKb3VR?=
 =?utf-8?B?aXhPZllDV2tBZVRuNkJjRDRzSVl4bFhpcXV0L2o5bW5xbmxUMFVMNGhIZ01N?=
 =?utf-8?B?WnZsRmFxOG9abEJOVmlmcVF3WlVlb2lKVnFaNkNsU1oyYnFCNlg5NHVlOVor?=
 =?utf-8?B?ditENVR0enhJeUw2TTZ1TmRKbUxmYWxldjNuQTE0Nmx1cDN5b3VLaXU2dFNy?=
 =?utf-8?B?WUpvYlJ6MkdpRXBHWWlURnJNYlVkZzV2R0QzYitSb2JsWkg2UFZUbVRNWnFJ?=
 =?utf-8?B?dzJ1dkp0clZNaGNZeHFHSzM4RWxOLzFhdWphSWdCYnI2QlZJS2crblhWd1Az?=
 =?utf-8?B?MFFKWG00WUVTV2tWc0NhdG9CWkR2MUcyVC9pdHJmbjVyZS95VlFBUXBqMUN5?=
 =?utf-8?B?ZE9LQ2UxdlpLLzdSb09oTVd3SXdnQ2grVWZmSU9VcDNaRGg3NzRHZ0s4V1pp?=
 =?utf-8?B?eTFBeW4yS0lIL3RvQzZTdGoyVE4yN29WZm9TRERFU1d5YVFLY1M3aGNWdUtM?=
 =?utf-8?B?WTZVa3dzaFBoTDN3eDk0SmhVNUNkaDJuKzA1MW96bG9GVzgxTnkzV3JVYUJQ?=
 =?utf-8?B?WURCcXVmVUdidVV3SktEbFBXVFhnTlRUdHpHQU1TYk04Y1hRY1Fjb0FOT0cv?=
 =?utf-8?B?MU5mRktxakhoU1dZU3BCeFBlTWc0eXhMejZTeDhCSWRaaVNiV2V3Ny90dkRm?=
 =?utf-8?B?RDRzN0M2SzExR3A4cDFoMG1qR3MvTEQwNUpCOGNMVUd3NDFIU2xkY3FvZkdm?=
 =?utf-8?B?bStZd0lDckxpTTlnMWc2L1ZYcWJJWm9iL2FZTG85Q1luUUNkMG1wU29teTFj?=
 =?utf-8?B?U0xyUGNDL1FTdWNEVHZ6RGZzbTdKcVFLblNYUWZrNWNmaUJkam9uQUVnYXJB?=
 =?utf-8?B?M0pvQjV0bzJna0MyWjNXb0R2M2xsRTB2NmdGQmRyMXVRNXlqTUloSHhVbnpQ?=
 =?utf-8?B?YVJKdGxsY2Z1WjBBdUV4VnRJbVJOU1pIVzlWWW8zTTkxQms2ckUwSURORTQr?=
 =?utf-8?B?MnAvZjg5UjB5d3h3djFrRHpjOGFqRGRjREZadS80YXQ0ZlZaNWxzMTV1dzdJ?=
 =?utf-8?B?NEJzdkYzc0FzQjBFTmVjSUFreWpQTFRGRmJCV3B3RUJqYlNEUTdRVTR0Rjd1?=
 =?utf-8?B?MTQ1Sk9qZlVodnpMaEg4T1NrdXNGZEhwdkR5SW5QRVFUQTQzNmhXS2lBRDJj?=
 =?utf-8?B?ZWxjVWY0L1huYWtmWHdIQlJVeWN3SlNZNHlKbWgvS2hrZERIdUFNL29vbm1P?=
 =?utf-8?B?MlVVL2RMcEpyRTkrWEhKV0FRdEY3VE81cmczV0JCanlUWkZpc1hadk5NcnUz?=
 =?utf-8?B?NEpOKzJTUkIrcHpDMGdIVy92NGRSMm03aGYvVytGWStiQlp4d0Z0OExhL0pZ?=
 =?utf-8?B?d2FuR29sSVFlam5wYmxrSDlLSTJtOFBQMEtaQm5kSEMvWWZGYmw3aGtRWjhM?=
 =?utf-8?B?SDVKTlN0OWplUlQxZlh0QXVsakNyRGh1VnZ3cWFybWx4T3VtQWZaNDE0dUpr?=
 =?utf-8?B?Wmc4Q0RVUXJQTko2TDdCdGZZVDdBYzNidzJYODFsTS9Fd2FLZWQvK3V6TXQy?=
 =?utf-8?B?M2lKRVV3cFNQNm9kb0k0dyt1emdLVm5OSlRFRDljcEs4cnIrcVFrRllERis1?=
 =?utf-8?B?c1F1anZDZVYveGZma1RzekVIbTJUcDJFalJzZHhrbjcvSnNpT3dTUXJ4S1Vi?=
 =?utf-8?B?RmxBQnpMK0ZGRk5lYkduZGU0eTdJTzJEbkhmbDdhSjZMWHlkVElHWXpCTUpQ?=
 =?utf-8?B?eFBDeCs3dkEzN3JjdGZvSmhVSHQ5VndPZEJZTDRXeXZnMklLTUczU056b0tU?=
 =?utf-8?B?TW9IWFhSK3gzaXZYYnI3bjVCNzl0NVk5T1RxeW5vdGUzdlRsbHZOOTBnTDFK?=
 =?utf-8?B?Vy9UajhvUjF5c0VpNHlycnZrOUF5MGtxcDdTcldDbXBySzhQeDhtV2dTUHk5?=
 =?utf-8?B?S3k1dnZDMmpZdmcwdzRadzQxZWUyY2oycnFrMHRDRVpFQkFZRGdycGhnS1gr?=
 =?utf-8?B?a3VPQXRhOGFXc2tBamZ1MHVaK1FTeWxOT3V5aWRnOWZJMkNZTmJiQWx6ZC9I?=
 =?utf-8?B?OHArbVI2ZTR5Y1VheVVoY0trMENJWS9HRm1GU2M4OU8xOU4vNjBDRmp5ejcx?=
 =?utf-8?Q?aS110D0fcirH/U/rxITY521MS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941e04e2-df4c-48da-ea83-08dc2d8d566a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:47:04.5389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0VeU1LNcNYmDM+pKGvS4+ivzO6Us6mKQzE9jqj7j80Q+q97f4XNZHlWJ9d55LmsS9gUMPTc6W9RNxLVTBwQ2iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5461
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

On 2/14/24 13:38, Rodrigo Siqueira wrote:
> Instead of only asserting in the case of the SMU wait time is not what
> we expect, add the SMU timeout check and try again.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   .../display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   | 11 ++++++++---
>   .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c    |  6 +++++-
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> index d72acbb049b1..23b390245b5d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c
> @@ -26,6 +26,10 @@
>   #include "core_types.h"
>   #include "clk_mgr_internal.h"
>   #include "reg_helper.h"
> +#include "dm_helpers.h"
> +
> +#include "rn_clk_mgr_vbios_smu.h"
> +
>   #include <linux/delay.h>
>   
>   #include "renoir_ip_offset.h"
> @@ -33,8 +37,6 @@
>   #include "mp/mp_12_0_0_offset.h"
>   #include "mp/mp_12_0_0_sh_mask.h"
>   
> -#include "rn_clk_mgr_vbios_smu.h"
> -
>   #define REG(reg_name) \
>   	(MP0_BASE.instance[0].segment[mm ## reg_name ## _BASE_IDX] + mm ## reg_name)
>   
> @@ -120,7 +122,10 @@ static int rn_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
>   
>   	result = rn_smu_wait_for_response(clk_mgr, 10, 200000);
>   
> -	ASSERT(result == VBIOSSMC_Result_OK || result == VBIOSSMC_Result_UnknownCmd);
> +	if (IS_SMU_TIMEOUT(result)) {
> +		ASSERT(0);
> +		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
> +	}
>   
>   	/* Actual dispclk set is returned in the parameter register */
>   	return REG_READ(MP1_SMN_C2PMSG_83);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
> index 19e5b3be9275..b4fb17b7a096 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
> @@ -29,6 +29,7 @@
>   #include <linux/delay.h>
>   
>   #include "dcn301_smu.h"
> +#include "dm_helpers.h"
>   
>   #include "vangogh_ip_offset.h"
>   
> @@ -120,7 +121,10 @@ static int dcn301_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
>   
>   	result = dcn301_smu_wait_for_response(clk_mgr, 10, 200000);
>   
> -	ASSERT(result == VBIOSSMC_Result_OK);
> +	if (IS_SMU_TIMEOUT(result)) {
> +		ASSERT(0);
> +		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
> +	}
>   
>   	/* Actual dispclk set is returned in the parameter register */
>   	return REG_READ(MP1_SMN_C2PMSG_83);
-- 
Hamza

