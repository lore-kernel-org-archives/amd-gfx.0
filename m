Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8354C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 07:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB4D10E14A;
	Thu,  8 Feb 2024 07:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oWU9EmyJ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2086.outbound.protection.outlook.com [40.107.95.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5411B10E0D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 07:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUjERgdUt/35v+D+t6j6ANC6fXoTVYeb9zUQCMRvjfG/zY6yQiHymj43NATJqeRnVtlD+EDpvwqrb+bc9sSAsD4Up9OUi+m/MQ5WMCJuAruw/Gf3XgOBXLMCI57S3O46vBDpq8gi7smvWOnikH1ksRDK7SbJDCxi5sMDFfkaurTnNQH9u9EhOvw4HvOZBKadhr6w5p5F48lLIc6eRovYi6DcW2IWfCJFrVuonPmt7vVCe9X96ZzHDch4RLcamxsN5enHI/9hoUTu9uez17Qg7jUVtcrAdcdcZzs2NRWdu7wKepfLniAFmTSUVpMI7ARQoshz5Y4p58t+OpiQ/oPSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQh+2G0h0hivuo3DDh1l4CAIuYlKqAorAZg6qrUJGN0=;
 b=FgWxCJEpK0M8aBM6Wkm5pfRyysqj5tnlJy6PmhiYFQndipXle2930wHqvVCdLySAD/QqY2FDGItRn2qllQTz31vMc6tBDmJEW6698bzpyoVogMXl0EZenK+NDXHvfTzsOVJm4Ae3xj9KOYYchokCi6VAi+juf6ro9ob4g1BJEi13LXb87yt38rwetRccarX8N/jIhO56TXrBkGWhBJ2BJD8zKECoDgnTGVeE+ML5oVn4MXZs5BXpBXEhBANcTJZwTlKkJxAEKXo17GyvF338CiRwWlA0tjCyPIa2OqzQwakkq505uLFe6xWgeLf6q5xbS8Y/LDaiqMFuoDMpT7FhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQh+2G0h0hivuo3DDh1l4CAIuYlKqAorAZg6qrUJGN0=;
 b=oWU9EmyJxycKt511hbjRP68TyzGAhAEa/59r1OE+WcSk7bPK4QBeBoHNkbl26xJPyK/u4ZU+GC1o5XJnjBDQQg1rNM7NwvMkH9g6bQS8ePeTuJn5J3eLX3f4DPWQ758KOGKCRZ3rMSM68zQNUjK/QSWR0FGfR1Guay1VVDUdUZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB5069.namprd12.prod.outlook.com (2603:10b6:5:388::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.10; Thu, 8 Feb 2024 07:18:06 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::3639:e4bf:a222:7dbe%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 07:18:05 +0000
Message-ID: <d8dec9d2-52eb-4897-bc82-0a33c0087411@amd.com>
Date: Thu, 8 Feb 2024 12:47:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: denote S to the deep sleep clock
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240208053419.3978393-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240208053419.3978393-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB5069:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8dd9ae-a5b5-4e98-9ab4-08dc28761802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoD5eDs+3iZ/ABHNBLcDJPyjftsUaMvr/ComqH1inA43b+/NAzO8z6Q0D9Ap5uxvCWuTxg8HvOr28cswojEY7Sc1JhIJDlks5kJ8w/YkQFxBK6rqTbPT/Kq7ZTmcnCR+3ttmOI+C+B0WPLGLXTBPZy3h0FBxDTAZJxoPA2HBsCyYTTrN40I6iVbYS4SbIzfJtpXhDcnu44msO+O5Ze8DvcFErKiNt7p/csGiuHEFMnkII+UaGhWEYNVXZ31tFa+iRl2uTgucGp48zQCsnHUZC8RZ2D8w5ZqgYnvCWyOpg5FkcxxPtBg+D2e+LZ5HqrOTmZ6IcR7+Gy3yMzGDkyD1wvnFXiNeNlllsYHG9KnrIWvBnIthR+X3QPGwVxirOEqMYjVuHTorQ3ZcWWhttYEJACk8BsipbPcD3uEDYDN+0/w87HTH/Qco/Z3X/iwIlVitC0T4v9HR5W00NwQBt8h+PUB0xsR7bzogTnuQ9oMLsyvO7vZJA45OI+hfgkDSECny/Tq9lk8+OVuSp1LbBzqY2SugYJyfumY/Ak2Oosh51R9qLQ10AxFrKvjh08bTtVBs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(316002)(41300700001)(2906002)(83380400001)(2616005)(26005)(38100700002)(86362001)(31696002)(36756003)(8936002)(8676002)(66946007)(66556008)(66476007)(6506007)(6486002)(53546011)(6512007)(478600001)(6666004)(31686004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkxRdktJQ0VtaFJEUnR1ZEdORldVdk5lS3BrVTRKYnRhQ3VOakptN0k4TGdM?=
 =?utf-8?B?NFFsVE4xbm5na0svN2JxUlczVG9NdDVIcW9WNWl0M293ajIyTFdRaVZWOXVv?=
 =?utf-8?B?Tis5eWVsZzRLVmpGaW1CT2s0eDlCZzBNTm9uNnd4N1pzemJpMERwZ1pFSHlY?=
 =?utf-8?B?RGlHRlpIWmpXanlJTndpYi9iOXNOdjVJU0E3eFFTRTYxeEU4NlNrZndVdEQz?=
 =?utf-8?B?bDNRUE5rS3B4Zm9VNnhMaktaV3poWHpiMjNsNW1YTks0TFFFWlRpbEducjYw?=
 =?utf-8?B?QXUxSGI2bm5UYk8zMnMzZ1dmMllCZjB4MUgwN2ljZGQwMjU4c2l1ZVVuTkJN?=
 =?utf-8?B?d0dSRE9NLzRoNGI5S0RTc2tJQlBPeUtXUWhVbHhyV04xUHE3WVRxdFhvSmVm?=
 =?utf-8?B?SElsdnRJSDJXREx3dml1K1lPcVgyOCtvR3g1TGZDRlZCNjc2RFlMTTErLzlS?=
 =?utf-8?B?YVpXNXVkbTZrTWZPSHVVcDlMMzA1S2NoWFMxaXRKdnFZNFZWUXNBWHhUS0tS?=
 =?utf-8?B?RVc3SzlKd1dGaTM0MmdackRMcVpmelJ4ejBSUms4cThqY1N1a1M3WDUrV1ZB?=
 =?utf-8?B?Z1U2MTlaNHFzcnNNTTRWSDMxZm1mNExtRzhia2p1L3RnYTY2WEd2SkhSZFVG?=
 =?utf-8?B?c01mL2prTTBFdkxuMHR3NkgyZExDY1pTOTVJOUF3dm5GYjFQeEVreG16R1VL?=
 =?utf-8?B?TFhXQ0EwUzNqcFNUK3pubndTbnE5aUtjeWd4bC9YelBDKzhKK2Q3N0d5T0hE?=
 =?utf-8?B?YmMvWHdsbVpIYjBpOXJQRS9CZ01jdjRGVkxRbDFXSkk2NmRadW1rSFlFeEh3?=
 =?utf-8?B?YlhmVTBNQldxdFB4ZmNpOC9qak1hZ3EvempMVUx0aGl4Tjd4cm5mQzNWenZT?=
 =?utf-8?B?OG5nb05XR05FMG41SVYvSU1vMU1Vc0RMWHRzaWRIYmphekc0MlFJTncrSzEx?=
 =?utf-8?B?ZVJXOGxaOXh2ZlZKVFRSd0x3ekNocjlHYUhZY3ZXcWNmLyt5QnI0ZzU4Rnlu?=
 =?utf-8?B?QklYMC9kS0xlc3Bubnd4cTJVRFdzRkMvRW9hRStGRFpPbXdqbmZLU2NJbWZQ?=
 =?utf-8?B?RFo4Ris3K2VldndTSmNLdE9pTnp5NmgvelkyTTJjN0Q2ckw5ajZPMmtUYWI1?=
 =?utf-8?B?VG9XWDdRd3FPVTNWTDZHdmlrVThFMWpvZGpHam1IRXNkK0FKRzViOTk4RGRj?=
 =?utf-8?B?VFRjMElocVkvd2dPVVdrVHJJQkdTaFRzazQyeERxeUFCTnQzK2FiNklpaS8z?=
 =?utf-8?B?bTQwUjBhdUUvSjlxbGczYjM1M0ZOTjlMV0VJV0pJc3k0emJDVFJRenluKzdL?=
 =?utf-8?B?SEJVQWJyL0wxVE0ySS9zL2pvanhZaFRlS1ZQZDFuWkxUcWxRNCtERTNYN2R6?=
 =?utf-8?B?NjJSREtEQk5OdUF5Ykt0ZzZUYjUrS0Y5NExtMWxQa1kyTmJ5MXZya1djSFJ3?=
 =?utf-8?B?WkQ4MHRvRmxjVTViR2taSW14SGRweGdPbkV5akdVNXFzem1YY2JoRzlwWGRp?=
 =?utf-8?B?ZS9POVZja1p2UzNHdm1udDAwdGlnQnlEVVF5ZU5CL0I0c2Y5SU5xU3BEZlA1?=
 =?utf-8?B?bW1PbCt0aHZVU3ZtTnZDcCt0czI0ZmxFdlBxalhWOFRFUGZMSWFuVGd6dkp0?=
 =?utf-8?B?cWZOOXFibFI4K3JPWGV6VHZWWUxrTWdHdUxieE5qMnBiVjBXcnBvMHo0d2Q0?=
 =?utf-8?B?aGJtR1F0VnQ0emU1WDR4d25uRWE3Mmg0UXFqTWMxZW44ZUxuL1IvaG4rQTha?=
 =?utf-8?B?K0lTdTNmcmJsZTZ6ZERDaEpsNDZNT1NndzdXSFhWakJTMHdGcG56Snd4dVJx?=
 =?utf-8?B?dEZoaDlvbFYzQkhMTE1sbjZsSDBlWDdTM0U1cG9qd3NXZXUxZXh0YXNoVitG?=
 =?utf-8?B?Y1d3RXV4Q0REV2NZS2tqL01xckV3N2pIMnZvSkRJRUh3TnV2TEo5VVhpZmFG?=
 =?utf-8?B?MmRqYzgzd2JEMjRpYnJsUlEvV2lGdlJjdlhWOWVrZUw2V2U2VjZkNkpEMTB4?=
 =?utf-8?B?S2lWSjJiT3czWSsyL3FmWW9RVUFGaUREbHJrcWIwVUNENTlvVW9WTDZJcUxP?=
 =?utf-8?B?alBzQWlsR3VVNFQ4SGI0QW5CUjVzTEpyakFNb2FSc0c2WjhrUGxISlhaWWx1?=
 =?utf-8?Q?Ut6CIQk4AgW/0TJ4DOCTMQrOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8dd9ae-a5b5-4e98-9ab4-08dc28761802
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 07:18:05.6942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /cnQJg/ONdrrfcicr448LhQHlDJaRtEvqOf87p3DzlmNjyPxvcYyNTWGk5PNbSak
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5069
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



On 2/8/2024 11:04 AM, Kenneth Feng wrote:
> denote S to the deep sleep clock for the clock output on smu v13.0.0/v13.0.7/v13.0.10
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 27 +++++++++++++------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 27 +++++++++++++------
>  2 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 2e7518f4ae1a..fd33646970a4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -109,6 +109,7 @@
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
>  
>  #define LINK_SPEED_MAX					3
> +#define SMU_13_0_0_DSCLK_THRESHOLD 100
>  
>  static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
> @@ -1269,20 +1270,30 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
>  			 *   - level 0 -> min clock freq
>  			 *   - level 1 -> max clock freq
>  			 * And the current clock frequency can be any value between them.
> -			 * So, if the current clock frequency is not at level 0 or level 1,
> -			 * we will fake it as three dpm levels:
> +			 * So, if the current clock frequency is lower than level 0,
> +			 * we will denote it to S:
> +			 *   - level S -> current actual clock freq
>  			 *   - level 0 -> min clock freq
> -			 *   - level 1 -> current actual clock freq
> -			 *   - level 2 -> max clock freq
> +			 *   - level 1 -> max clock freq
>  			 */
>  			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
> -			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +			     (single_dpm_table->dpm_levels[1].value != curr_freq) &&
> +				 (curr_freq < SMU_13_0_0_DSCLK_THRESHOLD)) {
> +				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
> +						curr_freq);
>  				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
>  						single_dpm_table->dpm_levels[0].value);
> -				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
> -						curr_freq);
> -				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
> +				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
>  						single_dpm_table->dpm_levels[1].value);
> +			} else if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
> +						(single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> +						single_dpm_table->dpm_levels[0].value,
> +						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
> +				size += sysfs_emit_at(buf, size, "1: %uMhz *\n", curr_freq);
> +				size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
> +						single_dpm_table->dpm_levels[1].value,
> +						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
>  			} else {
>  				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
>  						single_dpm_table->dpm_levels[0].value,

'S' notation is used for any clock, not just GFXCLK. The 'else' part
here also needs modification.

Thanks,
Lijo

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 0ffdb58af74e..2ecebad7a9cb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -85,6 +85,7 @@
>  #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
>  
>  #define LINK_SPEED_MAX					3
> +#define SMU_13_0_7_DSCLK_THRESHOLD 100
>  
>  static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
> @@ -1258,20 +1259,30 @@ static int smu_v13_0_7_print_clk_levels(struct smu_context *smu,
>  			 *   - level 0 -> min clock freq
>  			 *   - level 1 -> max clock freq
>  			 * And the current clock frequency can be any value between them.
> -			 * So, if the current clock frequency is not at level 0 or level 1,
> -			 * we will fake it as three dpm levels:
> +			 * So, if the current clock frequency is lower than level 0,
> +			 * we will denote it to S:
> +			 *   - level S -> current actual clock freq
>  			 *   - level 0 -> min clock freq
> -			 *   - level 1 -> current actual clock freq
> -			 *   - level 2 -> max clock freq
> +			 *   - level 1 -> max clock freq
>  			 */
>  			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
> -			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +			     (single_dpm_table->dpm_levels[1].value != curr_freq) &&
> +				 (curr_freq < SMU_13_0_7_DSCLK_THRESHOLD)) {
> +				size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
> +						curr_freq);
>  				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
>  						single_dpm_table->dpm_levels[0].value);
> -				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
> -						curr_freq);
> -				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
> +				size += sysfs_emit_at(buf, size, "1: %uMhz\n",
>  						single_dpm_table->dpm_levels[1].value);
> +			} else if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
> +						(single_dpm_table->dpm_levels[1].value != curr_freq)) {
> +				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> +						single_dpm_table->dpm_levels[0].value,
> +						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
> +				size += sysfs_emit_at(buf, size, "1: %uMhz *\n", curr_freq);
> +				size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
> +						single_dpm_table->dpm_levels[1].value,
> +						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
>  			} else {
>  				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
>  						single_dpm_table->dpm_levels[0].value,
