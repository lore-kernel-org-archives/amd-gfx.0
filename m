Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C740C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 18:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B0910E1ED;
	Mon, 25 Apr 2022 18:57:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED92310E1ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 18:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+IChFDP1jO0Ti9VW8y1OY0NyqX2ZQliEkF0gd3ryJjD1tc6dtCR782ITXTVIMutYS4yX7UZlXfo3GIrQ2ddyjLyitSduo0T+1CDood7MymCit+XvHgIn89xiThkFxCMSqV0WeK1uNVBk0KTdHBsOCED0O6xHNi0W4/1QYrEe3ibsw0Z2QMcPCLJD7pZRvyM7BOFLmsTk0bn2Iu8I65BlewTMI359yIPASMyJRbmJRuvr2aPLy+YGY7JAJonZ3PNRHqawlXWE+uH7bemfJUNJvrwViOueJI7brktd8sKuPvoJ7/moWkjRRY7a+pIZN7qtrNmY0R9pNMPz0TU9EGdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUOw29HiPSHv434VnKonUT7sx8qqQ/CodPqWrqPlWnE=;
 b=TPieVuS94nvCxq7FhFLw8nRASij0VO8npvYfteUiCd13sb6U94Ak1wro7MIkSipjHeeo1PDInJ4USoNioFvQaIt8yrMKd7cW/7UbjEsPk58ck+1N8TR5wEcGVZCrFh1kS0gX3pv9NCWUx9Q/buastWN4qsQBecctBdvKqcvBShvNGVbRA//FFgLBJOspLEqSUh7LB6W3Q0UOlViB2zYZD2i6Et7dL0fmus1Axp9fEaAU5Id+I9Rzq/89lk/qf+Sfv3CY830DAnr9nwqu67KgbsGh9lkiYiqM+2SAU6vlrn5Q6vYXpBTvl2TraY8d3y+H18a0qDYqE7UXucoG4tKVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUOw29HiPSHv434VnKonUT7sx8qqQ/CodPqWrqPlWnE=;
 b=C9f2hb4T/eVroy3fcIbsVuqDzgqMmcrvK7J/lpfd8xAK9zp/tOKzUtxHJ4AYQx2jMsCrJCzLHF0erSR7NCbGNfzSE7KguAouyBWp74/oojtH92gOtz2N7z0l/9zAgwYzWa9/g+hkvef8qEGRiSpvG5peS4f3qy/XC1nu1FcWthQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB3734.namprd12.prod.outlook.com (2603:10b6:610:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 18:57:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3c53:b805:4206:6620%9]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 18:57:01 +0000
Message-ID: <d2508cda-0b14-99a1-00eb-056f3d4dd718@amd.com>
Date: Mon, 25 Apr 2022 14:56:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu/display: Make dcn31_set_low_power_state static
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220425161135.1025420-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220425161135.1025420-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::46) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc0a2f1-61c2-4160-8e04-08da26ed6161
X-MS-TrafficTypeDiagnostic: CH2PR12MB3734:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37347FCC437580098FF055CD8CF89@CH2PR12MB3734.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O/ef4hwoOuTZQsuUhJc2nQmYPmXlKIGfLy25ZzzPTm8JYYhld6d/YLX9yaNJTSHZy50y4qvEK1imr0JanByvjUhtRixHrQqxgQHswGxOW/W0hmvGcc3t/mVYyXCQiUIpf/inhdxAMfpncSFFV7q6dxUrU4AsSWGIQMBNlBW1OJze+JVRGwdiT/q7lKb/Hv4a0D9Ov2ZfJCiO3VVpkoQ0vzXgKHSSmxUbbbzqACF5U0SQDl7kVx7Cgut4JpS4WYZda6ZRut1m3ACGeNpegs8g9p9r2wzl3bhHD674nDl1hp91Tsq3FJ+d8ldXt1iCkkTO0dXR6IxK6kRhl3m0g525AoTVrTGSjMdwwu7Hs7URN9D4L94S7TlquKflarQuSZwz312EgQzgdrX9ftWL7sCe42BgIjuDhGYpH/f/b+dWjdDsWl1NsMtPboM14hFP9Xy9cVeBtmn4YRQUlw4DxR4HRk6vZQx4sIe1vIj9g0Wz910NYtK83tu9OAhgIWE2zL/QVGFwzhn1K1ZQb2I89j4kPkq0VFYl9LobRX5IWbJ/7JV8HiHSGR1EhuG4uJqsgHl/T8+7lFgpJRPZ3MkhuhjVldWvLIb39uXZk4EKRnH7YmCzxx3VFFlyfhzZ/zq6WO4+549jqZKX4mh8xkMoWEAo5J48q6MeaYSGPSf6VvOgkmSo0RcRAtdHOTplgVVTaB1bbjO0gPazrnc10jf/XI41FVm5ivBFvE44CElGQY8TQG7OI7u2P0v9N6z9wasiMUJm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(508600001)(6506007)(53546011)(83380400001)(6666004)(2906002)(38100700002)(31696002)(36756003)(316002)(66946007)(66556008)(86362001)(31686004)(186003)(4326008)(66476007)(8676002)(2616005)(8936002)(5660300002)(6512007)(26005)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRKRERLR2YzUTlJUGVqek9DaWw2ME8zNC9qQjZ0MDdxcTdtWkhrMEN3cy9Y?=
 =?utf-8?B?Si9KbmhiMDhHcFZsNjNBWkR0eDFFNkdsbWFFT3UrN3ZlaCtsazlrUlJYSmpR?=
 =?utf-8?B?aHdQcVdLZ3cvQ09QKzN5TDRwUGtHYmtEajZaeXBES2hvNG8zcFRZZVQ4Tmhn?=
 =?utf-8?B?dlNrT2ViMG96Uzdhdm04djBBeXdLMVpMVkM3RTdWRlhNSmFmTER2KzNBZURF?=
 =?utf-8?B?QlRjYnRSaUVKTnQ2S25XWTA0SndscWJidUJ6WDNUVWMxK3dtaGxhL3hkZUFV?=
 =?utf-8?B?WWNvL2Z4MUdUaEtQS0pRdFZsbjNIN3UxUmo5Z0drRGFQcWJPU0V6c1Mvb3d6?=
 =?utf-8?B?b0R1QmtoU1QxSkZGc0Rjdm1UUXVlZ0F4L3FqRHR6YUVObnNPWU9yNENsem1n?=
 =?utf-8?B?enhMbGhLZE9xVjRxd2RZVkRYSmx4MGhWYTNpTWxoSHIrOGwvT0lwQmwxa2tB?=
 =?utf-8?B?MjdhTjA4d2wyZXhwODlnNjlzSWdUK0lkREhYc1NndkE1SHlab3J5OHd6Zlp5?=
 =?utf-8?B?TW9qWGtiNUt0ZHhuZTlzb2tMQjNBNkt4akZ5a2NzZmhBMTZwNGNIVURxdUtw?=
 =?utf-8?B?RDRHMXlCRzQzRDNVbGYxUmNEempvOGNmRWRBK0Rxb2NLZHROZVJpOWNmT1ho?=
 =?utf-8?B?QzV6QVQ4eHhvWlFkVWhnNVNiMGxiRWI3N09panhnNi81Tzd6b3Q0MHNYZjMz?=
 =?utf-8?B?M3VqWUdON05sZFlJWFJWQmtTNVBYeW5vRXFHQThKTmYrR3U1QStCN1BEck0z?=
 =?utf-8?B?Sk1xOWt3RUF0LytrVy84anNzQ1pMdGRQYWtvUFpxU0Zoa25vckR0ZWFIYWZL?=
 =?utf-8?B?eDhIRWNpSW15TkZkejdSd2ZsYVFHbStlZVFWek1SK2twT0ZXa1NVODdwUGhL?=
 =?utf-8?B?NHRMenlQZURKN2JpSHkrNU4zT2laUzVNR20zbEJTZnFSYmVNbEJmdm54WEdO?=
 =?utf-8?B?bWZnMllFbEQxRXNSOThqWGdsTzN0WVdaQTdKdXZONmpGZTNMdTFWOVo3WXRR?=
 =?utf-8?B?aTJUZ1ltQ0pTY3hqQjdQMGpjak44bGpsRjY5VFVzOVpwUmwza2RSTnpLc0JI?=
 =?utf-8?B?R2dqd3Rvak1NRUFsVHZtbFEwRW1SYVdrVEJsL0V1WXIrcXhhcFhWdjFDYUZS?=
 =?utf-8?B?NkkrR0hROHVHTjdzYTQ5RWh6NWZrMUZpa2NVZDQ1MU8rVEN0NG54RVRkU3FC?=
 =?utf-8?B?T3g5SkpOYkV6TTJNNWw2Vm1jMzk5d3BWVTJ2N2IvZEMyenNjV0luK3lweXlx?=
 =?utf-8?B?WWxaTEdqdjZwdDlCQnAxajJCTGNFdzE3dTB2OWpITXovQ1ZBdHFvYnVhV2l6?=
 =?utf-8?B?MVkwZU1LMUdkamlRNDk0dmgzczhLN1puaHI0VWlmdHQxdFJuRC9FRmZnbXgy?=
 =?utf-8?B?eVBOTGU1dFJTM1VZZldhK1BTMHd3RVpLdnZRRmxnYU8xakxLRmNJTTBaM0NZ?=
 =?utf-8?B?V3dmWmFzZ2UrWUZSRk9YYkFyY2swR1hFOE54d1dYSWt2dTJZMVlaTEp0WmdG?=
 =?utf-8?B?bXJOandXeE8yZ244WEdHVmcwVUlidEhiNFIvL216aVFJU2phSThSREZXbjQy?=
 =?utf-8?B?WWFUTzRDRE4yV2pHbU91cVdyWXo5TzJzMHo4ZlM0T2tUdXRFblNua29Bek55?=
 =?utf-8?B?RGo2WGtRNmFjV2xzY1g4eUhjTGYxMk9nVjlCaTY5MS9HMlU2L1VhN1VSYlRk?=
 =?utf-8?B?eHBzRXhoeWlKN1JOMTZrR3FycTRZcUg3WjJXQ09mZFJUcVcwUFFhZ3FoOGRH?=
 =?utf-8?B?U3FzTnNBTHpSbFYxcVAyVzVGbVNEdmJJNU1wYnZEejB0TWZVN1NrUnZnMGhQ?=
 =?utf-8?B?ZjF5OTdmV2M3d2d3YTZFUmhUcCtnc1FOVXIzUWpHbk9FbFBtL3JlNHpsZVJn?=
 =?utf-8?B?NG16b0crM3ZDbis0ZEdsY1Z2eitKT2RYVmdoa0V4M3lHMlR3MkkrZ29HNnNB?=
 =?utf-8?B?eHkvZDhBWGlwVE1uZ0NjcjAxUGhlS212MzRicHRoZVN3eTlSSUtPUk9aWFRE?=
 =?utf-8?B?emZSa0RaRVp5ZEJ5d1lHUHo0cUduUE1WOFMyaXkvREtDWU5vWCs4Uk1QMXJJ?=
 =?utf-8?B?UFMyY1JQRkMxY1N0WGNlZzJBRGlNZTJIaDJDMzAwbEFoQUtJaG5wMVIraGxi?=
 =?utf-8?B?VEZqWmFkeW9jcUpJTGpPcUpObytCTU5LU0kzRjQyOGRtaDd0dEQzMXhVVVQv?=
 =?utf-8?B?dnpFeHljd0VPM2FYaWZicnE4aDM5eDZibis0c1U5OXdodlEzQ0xZQXBQNzRO?=
 =?utf-8?B?V0I1RGtJMDFLTW1PRjNZMmtMNFd0NVdwcEd5bEgxZW1vRVpCSU1kdWYzNm1u?=
 =?utf-8?B?NTlqaDNvcmdtWDQzVEVBTmlTaWdmNzhkdTJiVmtydXkwTE53NEdhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc0a2f1-61c2-4160-8e04-08da26ed6161
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 18:57:01.1265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2hEK8lYux7LZ4P4PWEdhpWV7bg/GhGwaOfkOlBd7okvRv1p8uV13qmBaLxv5MYRYlWX3SJ8RSsWXWcbLHN7MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3734
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-04-25 12:11, Alex Deucher wrote:
> It's not used outside of dcn31_clk_mgr.c.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> index 969b40250434..ceb34376decb 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
> @@ -615,7 +615,7 @@ static void dcn31_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
>   	}
>   }
>   
> -void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
> +static void dcn31_set_low_power_state(struct clk_mgr *clk_mgr_base)
>   {
>   	int display_count;
>   	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
