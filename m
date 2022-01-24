Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8A8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 09:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF0710E8A2;
	Mon, 24 Jan 2022 09:20:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3668110E860
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 09:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cycKH/JfF0qG9ZKSRZuieiICtYDI0LfGcw/I9+4Vbzuqndl0OKx5RKgSahDKHRH8qPO+RiypYvW1Q5OwbP0hNpisciYSfPaK5YxqaPl7zVHRYSC216UmC+QqHulTHUHJSLdkxDyXeJQh7rrjJBOVgTDyTkeyJTBNCrtKV7GskodXz4rdMDQhCHqodfren5RKX484Fe7vtbcJIFn2bfUIVk5lUiC5fDBZwmVFaVXYPzZb3RJ/bK7KotBgQ/T4MVbjcCxlyCBzvEMky1LWVmHeHzM4eXI6C+D/EN8qnJaKQTpNKYO14f4ktN+rLapMILmpJL+YtQi0llh4rj/dptpSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tw8s9E1dGOUwBkrTl1dDi7QtOEIXXGLBsDWfluP38s=;
 b=TvZomZ1x5lfg+PO3276FAnltlxqmGtPpWrDQfIjKqa2lu2F3tGFwNvhXc39J/oY3sg5mHQ06E84LmqsBo+C86NwGiMH1IFjZs/RaR27NgJZLIG2pYCb/yMgWUIJoxCX8m5T0A05wZ/CNTtfbGmtZ5g5FJfY41D+qAWc0OW4+HYMLDVvu97bJ/rN7lxk6BaVeul0CVytBtDq6nZsGmpD2110zPcGBi+DICxHx7hQUsmGjZxigkMjlfv3cxOeEcJOT/QEo81UcRJq16S2x/gNKhx10gXAxR7wr0G5P9JcetYP53Ao6AYR5vMvMyFpnQu+pYUIW/lBhyaZ1Wc70GDvz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tw8s9E1dGOUwBkrTl1dDi7QtOEIXXGLBsDWfluP38s=;
 b=3KC/WtCRmNS16N+fH8+crvKFx2vfxeyaW2cG+RR2sSu7v9byxkg5ru1VXkkn2fsZmFoPwyASVzB8RD4txhM6GOSUL5sLN2+9eIu7t1SIpPu3UmRKq7tMxFXtFEuNxEXe1oduBGcvY2/UtlYcOHNw6xatof/8WpWaxc2o1xN4rq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN7PR12MB2660.namprd12.prod.outlook.com (2603:10b6:408:29::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Mon, 24 Jan
 2022 09:20:43 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:20:43 +0000
Message-ID: <88871a71-8fae-3fd2-17d4-d583d800070e@amd.com>
Date: Mon, 24 Jan 2022 14:50:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124091215.335613-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220124091215.335613-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::16) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50ec3b98-9ac2-406b-6bbb-08d9df1acb6c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2660:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB26608A6E0690DEF0BA787DBF975E9@BN7PR12MB2660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFah3urnypTxhRiKEdlTMfB2QDmPU4Arl+mGmwbeYbXICo8NLUfs2R/GnoUfIRaQF4ckXx6n2H33RDTutQnASCE/8D38XqiXWPK19xqZmiWHOhYwc2HsMz2SnPeCwIe/8i0IpLf1bGlZG73CxC4qX6I4/8izLN8BNKoZXQb6JANOwUoC9NTelMqubk6ICxqw7O7QikT3yv122qGnfiglUU9nPipM5U+hUAGzxGmuY9TYJJsMX24yX6cicg0tia2z/ah6XVujy4aZukhqKIUuj8XGWONEqAMeO9jDnbI7nvbjNjg2sph/AZPMJjYcuTnuZn+75KXNn9Tkss5U6vOWnaPS0xqYpnugHuQQazmVDgQsA4zFu6mqkdAC1+wTg+U9CTbfFT+qyXYxxTTf2BDK/j4ML7IwjXBHf5jgyjnaxSYyam4ecFMmyUAKSJNB8Cz+K0AoxNeZk/UgrGPzLjrQM0ZfhqaKEOBulqjBQPqfoJ8ukUOFIZi8pe2mWFoYrGvoLDLW6jkn21qXdknd87TVbrwcfaq/YKWViRWZ32WKXnfk3VXWLckmgpmfuCrFKnLb1HwAquhWFv1yxI2fIl2GmhaMH0Gqd7rm0SNTcE3nZrAHOzi7SSCQfSBpKG8RBa/x/O1s7Z0P5/NQ3Og78aJ2TJa2Cc3dY5sOh5IBJ1vC57nwZJznVNeOgqKhn0CcooDshDudxcakNi7KPAO6I0xCBXbyF5JYqNjNJJ0VdRFK4zDcCh8Wq4g+LNoephl1A3n9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(6506007)(6666004)(36756003)(4326008)(53546011)(8676002)(6486002)(186003)(38100700002)(66556008)(6512007)(316002)(66476007)(8936002)(2906002)(31686004)(26005)(86362001)(508600001)(5660300002)(31696002)(54906003)(2616005)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzB0ZmgySStiR3VUclIzS0QzN3h0OERpWVpmN1JWdDZkS1EzKytIelNxUkxo?=
 =?utf-8?B?WGFYSFJLbysrdWsrSUhsL3k3Y2JmWUN5bEhXTVladmRhNGZDUFdsdGZPQWt5?=
 =?utf-8?B?TFlidkw2Vi9xU1dkVHFuRUVDYWk3OU04R09DVXQrRGRkbUxFYzhubG1udnBi?=
 =?utf-8?B?U0hVNXFPNHpzR2lpNjdQYU9Qc3FRR1lzSVVzVDkySGdESWJuNmhDc0MzWVVn?=
 =?utf-8?B?MTNwYVg5YUFjdHJTS2ZnU1kyZE1XbjB5ZGhhOE1hUUNoKytLY2RndVFTVGY1?=
 =?utf-8?B?WVdJNjFrdDdvV3krVnh4SFNFWFVGeGpTOTYvVmJHdngwOEVvTHF5NXgxWEYv?=
 =?utf-8?B?M1hhQ1E3TVpXcC9nQS9Hb3gwREpHNEJGeS9FSUlyQVB2c085RFg5d1hPOG5R?=
 =?utf-8?B?WjdRK1ZPMG9wMjdDdjNCWjRlMHhtZGZYNlBGcms0enZZVWNYYk5yK1RzTFpN?=
 =?utf-8?B?czNXTXQxUE1CKzJiTlRTRFNUL1Y2VkpQTEZoVjArQ25FOTV0UmRUV3Q1d25k?=
 =?utf-8?B?Vkhac0FOdlJhdTd1TFNlRFQvNnZMYzRjQkFWTk5XZzZ3Y3BYQ2hzRzU2dEhW?=
 =?utf-8?B?Umd5TDdtdmk1d1lGQ1RuRXNDcU9TQ01LMGJIelhnT25KRmM1bU83cEJFTmhv?=
 =?utf-8?B?V3lyUmlUQ0R2dVJpb2dYYVlLSkM1T3E4bG5VSGYzeGFaVTBuWU9IdExjaHor?=
 =?utf-8?B?Y0xMRjRWVGRvMm42NzM2TGlGM25nbkR6aElHenBTd3ZRMEVqdnBxK20yejZP?=
 =?utf-8?B?cUtUOVExTUs2NWVTbnRNbDA5MVFFbzYwV1IwbUNjdytHVGY4Wm1oQ3h6S2NJ?=
 =?utf-8?B?UytjOFdQbmFBQ3hjeS92TDNDU0JIbGpKUUE3d2x0dTBiTEpwczhOdVVWM2NY?=
 =?utf-8?B?Z3U0cjh1NURjSmx0VjMrZFgxZTErQWdKSHh1enF1QXhwK1R0alBrd3RIdzZj?=
 =?utf-8?B?ZXRJL3d0RWQzVW1VRTZUUGc5UEJ3LzdnR3pTelBGZi9RQkYycUhVMGVreU5L?=
 =?utf-8?B?Vm1lNDBpMU1jK3dQeEVVQXhFQ1BxYmgzaC82QXBDbjhPb09IYXJZNjVxZTJx?=
 =?utf-8?B?UWE4QmMzdG9UakN1Y3o5a3NMQUE1azNCSmpIckQ4Ky9HTlpobGs0RVJINHNB?=
 =?utf-8?B?YUcrTEhRMkY2cFp1ZTluWEVQU1lXazc3TGg0aStwNHdFSW9VNmFIOHRpRzJ1?=
 =?utf-8?B?L2VtQ1NDbnhmVmJDTytQbFl6Tkt1WkR1M05CQkY4cGVKWUVEQUk3cjdQaVFZ?=
 =?utf-8?B?SDl6NnVzTFhLc2NXYzd5Uk11OW5TR2V1Ulh3dlRrWU4zZm1ES0hCQlUzRndm?=
 =?utf-8?B?U3hjeWgyK1lqa1UzdDlUSW1vdFRNMXFsQjZFLzFBWVZHdmRINW8yNVZrZ3Q5?=
 =?utf-8?B?OVRlWEhKcmt1ajNMcEZyM2FHcmdaa3V4UEE5R0ZwTjdsL0RwSmVLbEVLZkV3?=
 =?utf-8?B?M1ZiSEd2MnNpN294dEdUMXJuYzJnbmQzY1p1MmMwVStTWDlXTFVMYjNIUW1U?=
 =?utf-8?B?WnhiZWNRRk84T1N1VjJTRXlIVm1YbUtDM29mci96Vjc3K1d4cWJXYkVUcVVW?=
 =?utf-8?B?eU1CeHdwdXdlUlJTTFRJNENiQkRRWW5JM0tSd0J1YWwyREV0WTJmZW5BRkM4?=
 =?utf-8?B?SExsa1QxRHhFSGFwY2lSVVorOCthVHJGZWxyaEpmeG1rVUxIcVNQRlhLYWNR?=
 =?utf-8?B?dmtxK1Rkc2N0WCtvdEcvcElUazI3SXFwVCt3Q29HL09RaWNpcWFJODc3UFRH?=
 =?utf-8?B?c3BRWjhpaDRHYUk5VGxDVVVJbzhiNGhzTXNuM1VrU3dXSGlKdE5PZ3JXNjRa?=
 =?utf-8?B?c0lqWTVCakg0NmV5NGVTWGtDajJRMS9Nb28reFpDbTBQRldLelRKdEtRRnJ2?=
 =?utf-8?B?WnNzTk1KU05UVDNEaU90Q29tVHlncDJhcUtUYXpYc3ZjOURpR1o0Zm1GNkRT?=
 =?utf-8?B?WjI1c3Zkdi9LbVpVQU5tdENtRW5ubXE4MllRZ2hNUU5ycWVFVVdzWm5OM2Vs?=
 =?utf-8?B?MVhWNmFGQ2ViNFVCRG53VjZMTjlYYWFDcG1LNk1WZ3BGclpmS09XRUJESGtP?=
 =?utf-8?B?QUttZ2F3aE5ZVG85eUtQRStKNG16dkV1bjdVbFdaSERYN3F1dzFqNm0zTncr?=
 =?utf-8?Q?ui6o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ec3b98-9ac2-406b-6bbb-08d9df1acb6c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:20:43.1534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1aOUGwFWGtwr+hrnrDpYRegL8AkdhBt+pz4LXFVHFdZofiWuwxUqQIe7PkJIdGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2660
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 2:42 PM, Lang Yu wrote:
> Some clients(e.g., kfd) query sclk/mclk through this function.
> Because cyan skillfish don't support dpm. For sclk, set min/max
> to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX(to maintain the
> existing logic).For others, set both min and max to current value.
> 
> Before this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           0Mhz
> 
> After this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           2000Mhz
> 
> v2:
>   - Maintain the existing min/max sclk logic.(Lijo)
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 35 +++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2238ee19c222..1b58fea47181 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -552,6 +552,40 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						uint32_t *min,
> +						uint32_t *max)
> +{
> +	int ret = 0;
> +
> +	if (min) {
> +		switch (clk_type) {
> +		case SMU_GFXCLK:
> +		case SMU_SCLK:
> +			*min = CYAN_SKILLFISH_SCLK_MIN;
> +			break;
> +		default:
> +			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, min);
> +			break;
> +		}
> +	}
> +
> +	if (max) {
> +		switch (clk_type) {
> +		case SMU_GFXCLK:
> +		case SMU_SCLK:
> +			*max = CYAN_SKILLFISH_SCLK_MAX;
> +			break;
> +		default:
> +			ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, max);
> +			break;

It's better to use temporary variables rather than fetching metrics 
table twice when min/max are both non-null.

Thanks,
Lijo

> +		}
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -565,6 +599,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   	.is_dpm_running = cyan_skillfish_is_dpm_running,
>   	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>   	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
>   	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>   	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> 
