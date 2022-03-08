Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A66EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0035E10E39A;
	Tue,  8 Mar 2022 16:26:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980B410E380
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEuRQdz0ppYwFmghNb3BHvQT10QCimdRyUNShp5e9sOGf6rydeY+SGcZx9L3Elv7T0j+2DqAdY2V8NJSVKReMKjM4Ax9FmODzQ5Ndq7ymfgLECNN3ffF8YzkwvYg6ki1O7j0EWiEqhQgszC81P8Y6HsN8TjmRJOweMShyIqSmP974u+n/K78RZnLwDaxEo7YnLnQcXoXOQOzL4zPg+QFfeVwm6cf+zywfMjDkHiIXlB58nBXtsfSPJjBTssnXaLktTwX2Ttx80qDfH/3EueAnCs+3fCSGOG/CprN8fIKd69e5Jg5tPCVc9uMbDQGA1CEtxFFSuFo4f8g48VTg6EAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7sb60zuAb/qwlQTz72NhMqGeQf2Y2WTyTmLWSMqeD4=;
 b=VnmgUYiWDhT4uwVOXWcBgpiCrW4P31XBJvVYLkn72RzxUMW8v+KtCciIdLnsl7HRWjwxmucyP1bnwTEnjxPehypYT/Mc2K/FBXYHkbg83NruBjkOuFDslApoqYIt0sLZw/N7H/DJ5jMhzzYJoQZvMly4TmKvj2wDz/wGeI8WFCIZoZ3su490MVtKPOKvmJin6+afn7Zc3lmu5gOmtMEBP36ff142Fn9/1e2EWIDQJID8e82RubmEYvYTkFuT5xxNF1Vehajirlgz8qFq9F89PkkKiKarDwda+uFPVVvgXEjPzLrtSQq41y9Th0xySnrRBdFO1PPSW5wNkOZ54U052Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7sb60zuAb/qwlQTz72NhMqGeQf2Y2WTyTmLWSMqeD4=;
 b=zwwOB/dXTnZ4tnYaIVy3wIsFxCTa33wrVSL5Ga1jWn5GZKP1ucwZtos6pnpzY8u1ZfbDIkcWHlZk9sPPSutB9HQ1wRIchPwS75SxQ7UdMfsQamp338ue1RGpVWDtwA+/qHIPsLzNeupKIOpTDcVMzXxxm4N3EOtmUZTmFwWayBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:26:45 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:26:44 +0000
Message-ID: <9de42884-d1e2-309a-e669-5132539fbd22@amd.com>
Date: Tue, 8 Mar 2022 11:26:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add work function for GPU reset event
Content-Language: en-US
To: Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <20220307162631.2496286-2-contactshashanksharma@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220307162631.2496286-2-contactshashanksharma@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::26) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c87ecee-93b2-420a-7a68-08da01206f84
X-MS-TrafficTypeDiagnostic: MW5PR12MB5652:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB56520E5CF76ADC0438728479EA099@MW5PR12MB5652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRszTJ21sEHD4+o5Z6vcboEolJz0wvP7Uz5+XLiWBZkY8qGOlJJ7InPrxsfP0HeBwYDXIaDCD48stei2wvlohmvl1trqkinVDUeO866NR90ARjDHAuQa1GSFsd025RkTlQDf8I2kanceJM3VnTxV9U3Bsjj+FJI7Xp1BXUWTurVv2PXVGJJSHfwi1KThYPUlpG/OFuL/DVnRwLIvPHDFx3+XqORVdcdalTFX6Ty/TKc4GH+FfMKIWKlUG3axcUEi/yDQKQWLqZtzHGXgGMZUUl0lEzzCdaj95aY+QaOI04nwPyAX8Z/Y4U6LPR7srv2UinatHaoFD7PHZavlOtKYjQlGtTcPfsDvsb+BJYKFDrEY8hoxonAv8mPB5i9y1Ez2FnymIMe68WMAmw225halXa2iCiG+FLGem0Y6s9e78Cw4Y9T6YSXs25T9ZCi3d1NRq1lO3HxjwdYa+r/LnhnbsN2PhkjbeCRV2CTfaZGc3iSW30IGThoITNQj6euwr1ZNPS0D4Ta/LaIgpXWf77h89uT/PE+S2ELABRf4mSK5QjwOeGMniKSQJuvZq07q6paiicyDk1+hcfrG7J+B+lKf0kuLhEm2KvZf9kBouwgejEJGtLWIs/nh0hu+Dohv05h2K1qIeX+0sooQjfPt7v4hQC6l/0Mgsd4h7cn54ko9uZI7/R5v/8znY7nLR4eUKeUMQIHAZ9yGaQg3jgujIXDuzFX028EyMFv3TtASkU4SleQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(44832011)(38100700002)(508600001)(54906003)(53546011)(31696002)(5660300002)(2616005)(6512007)(36756003)(316002)(31686004)(6506007)(6486002)(66476007)(186003)(4326008)(86362001)(66556008)(66946007)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhFRVMwdHdhalRCR3JEdkI4V3RXVjQwc3pEdEE5Q2o0SCtMV296aUJxSnE1?=
 =?utf-8?B?ZFJoWERxMjlTM2JCZzVQdmk4M0RTZUV5MnMxTW1zK1hJVi8wNVpDcVUwSmlF?=
 =?utf-8?B?QUgvNU03Rm9iWUhYK0lBaU9wK256eUsya0lWRnlLYWVsWXphY3hRMlRYNW8w?=
 =?utf-8?B?bkxrRHBySWJiaUhBYXRJQTRtUGFXQ0VnN1Y1WkFSck4zdkxBaDF3dWJKcXlJ?=
 =?utf-8?B?cFljdENMYmMxNG41WGJkVnRJUmtHdEFDTGlMMy9HUC9oWGgwN3RUbTNEdXgw?=
 =?utf-8?B?OWZPYzBoYzRSVXZWRUdYQ1Rla3I5UzZ4UkNlNVlUaTEvWENCeVpjSk00dits?=
 =?utf-8?B?ZGczNlBTM0l4azRKcUVuZnNocEhrdm5NZnNCMTdmdkwzOUIxVnlGcXhDeWt4?=
 =?utf-8?B?OThXMERLelZYb1l0VUV1RXowL043dlZwaEJDcXdweXRnUGFVZlRNVHRhQjR0?=
 =?utf-8?B?VUJ4Qi9wRkROU01ZS0dkVHlQc1ZOdzlJZEdKN2NmZnZ0bW9KUDVCSEVyNUZw?=
 =?utf-8?B?RUF6S3lPeDZ5djJ6VmRuU2JmbndhUWtFZmNDQkRKenA5REFGMXNMZFRSNCts?=
 =?utf-8?B?WFkzbWlVZnVIenZDWkw1NzJXQzE5M3RDc0JZNTlPS3Y0MjBNb3J3dTZPaEJ4?=
 =?utf-8?B?YzFDYzlFK3NZNmZ5L0ZydW5zMHJUR2MvVHFiRW9vdFBxaW85SEhGdDRQaTNx?=
 =?utf-8?B?eXdxbEc4Q2cvS2lrMENVaHBjVzRGOXBPdk1JdkRpdzVURTAyTUl2MG9teW1J?=
 =?utf-8?B?QlN6cnhIcUVSbkZmTWpUNFJuaU9CZGFRWmwwOVQ2MEVzMjhSaG41Q0lxcEZ1?=
 =?utf-8?B?RFhYSncydXZuenA1ZkdvY0hkYnhXa3ViNU1DaTRrZmpjSk5BSnVEQzh2N20z?=
 =?utf-8?B?VVZwWGNDWkRaaThVcEdMemxaNXdzU05tRzhLd0MzRzh4NGNFZDY3V1FTdStT?=
 =?utf-8?B?bDBuQ2Q2Nm9xR3BDQlVBaWNnaU5mQW5ONzZ1bTBuMTlIVHY0OU4rSWlhb2hZ?=
 =?utf-8?B?VC8wM1I4dDlvYUhNTzQ1UTlsdFBOVDlOb2ZXeVYvZCt1VS90dXY5NEZINmo3?=
 =?utf-8?B?dHUxNUtCRzVIMzE2TGV2RUJNZVg1Sjk5RlZ4ejI4RkQvMldjaTY0a0gzK0ll?=
 =?utf-8?B?SmF2NjNKVzNFT3Z5em53MUVURlhUakdPakZ3Y2Q0dXMyMVJyc2NHVkJ2MG1t?=
 =?utf-8?B?cE94RGtDMFF4Smt3TkNSOWwxUW1RQkhLWDlkMzV1Qnp4V3FCclF2Y2szcUVt?=
 =?utf-8?B?M0xUbWU3QmVUd1IzUTRvZXNleGlubk5sWkx0TGNpOUJpTlZ5YjFCL0NpWE1r?=
 =?utf-8?B?UWJ2enBIYkVuaTFac3dzWHNiRjladHFORDJCeDBOUVkvQkhQRkNkeFpKU0xU?=
 =?utf-8?B?L29HZ3MzcTIxLy9kNTN5U3gwa3c1WG9CVlozVkw2Tk5naUpCVklVYWtMamlF?=
 =?utf-8?B?WlN6TDRvczVnYXhibGY3KzhmYXQyYnVERDA4ZDdxa20zdDdKekpBRWcreVVT?=
 =?utf-8?B?UE83U1R3czRKWG1ObUxvaSthR3NpQVNqblN3RE4xN2xoMXFqellqMzBEeTN6?=
 =?utf-8?B?T1p1cmRyMER3cWpKemNIeXVCQVR1ZDNoa0JVaE1GOWtDWFJQSDM3SjQ1bHI5?=
 =?utf-8?B?S1BlZmVRSDdJZXRrVWpGRVF4TzRLVkNDQm5sVTdNbVVlUmg1Z1pCb2Z6dWwx?=
 =?utf-8?B?VGVoVWplMitUUFlyYTBaWU9DbG5FWGdvZllFdURPSVh4U2k3ZlNKODRnRDgw?=
 =?utf-8?B?WkR3cyt1dmVKQ0FPK0VVUGs0RkMxTnRTUUFEcDZGK3B3RlBTSnRkTExST3li?=
 =?utf-8?B?d0JHOU1jRzFxSzB2MmczR2Z0dmxGbFhnU1N1TFNLemhMWFg2MzhEUVJzOGkv?=
 =?utf-8?B?VzlhcDlvSHhIc2FRelphRmh1b2M0S0pMY2lTdmFZVzVCT2E0TEJnSzJlMGhD?=
 =?utf-8?B?WUpMUWw1bUFzMHpsZXFNWlBURXhCQmQxYXpkMWhYTlhIY1d5L1NqY3Bjb0d2?=
 =?utf-8?B?ZHdpWEdSc21yQ1hHemlsT3gveDJGZ2wySzJ2aExsbjV5VnRET0JoNmdoRU5I?=
 =?utf-8?B?VUZqMHZuK05TanFWYjdJRDg0ZHV3R1NBb1VNR1JoRnQvT1U1aVpTclg5Y1pr?=
 =?utf-8?B?WFdrUGNyOVFaNlRZdkplZS9Oa2srS09QcXhDNndpNGhvRW1WN1dsNmZpdWRx?=
 =?utf-8?B?eGFxR2VSUEV1c1huYUxsYmM0ZXhBVGZRWU8rd1BhZ29EazNaRVRYeVhNYSs5?=
 =?utf-8?Q?zwzTSarkEGGFCHuFecRr6F4/6Fnh1OzGiLd+TufuPU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c87ecee-93b2-420a-7a68-08da01206f84
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:26:44.9286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdeZqnyRNVgKp6sslGZdbr68ykKILof41Jw2Qxc47/GMu+/pm8y+dhU9OW1dDdy4MGwBxOYDZzlUk1H/rpWRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
Cc: Alexander Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-07 11:26, Shashank Sharma wrote:
> From: Shashank Sharma <shashank.sharma@amd.com>
>
> This patch adds a work function, which will get scheduled
> in event of a GPU reset, and will send a uevent to user with
> some reset context infomration, like a PID and some flags.


Where is the actual scheduling of the work function ? Shouldn't
there be a patch for that too ?

Andrey


>
> The userspace can do some recovery and post-processing work
> based on this event.
>
> V2:
> - Changed the name of the work to gpu_reset_event_work
>    (Christian)
> - Added a structure to accommodate some additional information
>    (like a PID and some flags)
>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d8b854fcbffa..7df219fe363f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -813,6 +813,11 @@ struct amd_powerplay {
>   #define AMDGPU_RESET_MAGIC_NUM 64
>   #define AMDGPU_MAX_DF_PERFMONS 4
>   #define AMDGPU_PRODUCT_NAME_LEN 64
> +struct amdgpu_reset_event_ctx {
> +	uint64_t pid;
> +	uint32_t flags;
> +};
> +
>   struct amdgpu_device {
>   	struct device			*dev;
>   	struct pci_dev			*pdev;
> @@ -1063,6 +1068,7 @@ struct amdgpu_device {
>   
>   	int asic_reset_res;
>   	struct work_struct		xgmi_reset_work;
> +	struct work_struct		gpu_reset_event_work;
>   	struct list_head		reset_list;
>   
>   	long				gfx_timeout;
> @@ -1097,6 +1103,7 @@ struct amdgpu_device {
>   	pci_channel_state_t		pci_channel_state;
>   
>   	struct amdgpu_reset_control     *reset_cntl;
> +	struct amdgpu_reset_event_ctx   reset_event_ctx;
>   	uint32_t                        ip_versions[MAX_HWIP][HWIP_MAX_INSTANCE];
>   
>   	bool				ram_is_direct_mapped;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ed077de426d9..c43d099da06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -73,6 +73,7 @@
>   #include <linux/pm_runtime.h>
>   
>   #include <drm/drm_drv.h>
> +#include <drm/drm_sysfs.h>
>   
>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -3277,6 +3278,23 @@ bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
>   	return amdgpu_device_asic_has_dc_support(adev->asic_type);
>   }
>   
> +static void amdgpu_device_reset_event_func(struct work_struct *__work)
> +{
> +	struct amdgpu_device *adev = container_of(__work, struct amdgpu_device,
> +						  gpu_reset_event_work);
> +	struct amdgpu_reset_event_ctx *event_ctx = &adev->reset_event_ctx;
> +
> +	/*
> +	 * A GPU reset has happened, indicate the userspace and pass the
> +	 * following information:
> +	 *	- pid of the process involved,
> +	 *	- if the VRAM is valid or not,
> +	 *	- indicate that userspace may want to collect the ftrace event
> +	 * data from the trace event.
> +	 */
> +	drm_sysfs_reset_event(&adev->ddev, event_ctx->pid, event_ctx->flags);
> +}
> +
>   static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>   {
>   	struct amdgpu_device *adev =
> @@ -3525,6 +3543,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   			  amdgpu_device_delay_enable_gfx_off);
>   
>   	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +	INIT_WORK(&adev->gpu_reset_event_work, amdgpu_device_reset_event_func);
>   
>   	adev->gfx.gfx_off_req_count = 1;
>   	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
