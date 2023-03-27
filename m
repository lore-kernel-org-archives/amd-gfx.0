Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335DDC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 12:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B2AD10E590;
	Mon, 27 Mar 2023 12:33:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0A010E590
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 12:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1CChL5KoRaU0f48YEvbg/SPFqs7HtWwVcFOWKYAFw3a1xB4CZL6f4OAysil9EajhqCU0ELG1odJdFqcyzKjjQ1pddl8a3KeqAOj87BIb4IzU9dfiE86kvQ7AyLlfzYc5L0Bik3FrJRpTx4Zb3LYV9/fXTSmTdpdDRYU2Oc0jveKr57EgxfvLoP0Q63R1SjgABljRf4oCz8FAGwYRIe2565+Uw7ioAd8uBytBpixinnEv5fuIJjBP6xUtmJaCbrsXiRWxE+9jav4cIMFUSNspW3fAQIx2A+CiPiOJS957mH/JaBL0Xs2aWWPxOnrs5N0ECJUYIJRAHbzA0gxpuBptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/Gqwzw6y20utHSofjHivZ0yW0hvtH/wdSwMVzc/omk=;
 b=fWs0r3BbqqIghJj5jKbBsJ5ZhIZN01OW+WJzKKTXA4fuMOiHd9r/zgYSu40XNkQ+T3Rhy2AN9jnvUtggwZcJQVQMVzOa4yOkWyQrDeVfdodligtYp90FdlLQVTDCLI1z/gOb0igg/tal5Uj+kHYwMfBYwboN/O22CvmDJIcs18hDCgw4wxNkz1Nzx2oOXIbumC1KPIfO0feoBW0HPMX/K/ESIGcU7U2IT4EWp6vqazgSHyliwuMmK+9irTF/5HYAVjn7A9IpYqH9ChIUpJUakzcf2DcVO1ZleKm/koSb4dAPKIZh02mZTBwD6S3kcvZ7kNpbmu9YSrpZTZKpregsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/Gqwzw6y20utHSofjHivZ0yW0hvtH/wdSwMVzc/omk=;
 b=c2ekTN/klWDOjI5FcFIE5JXzhkjm5yHiuHR5XjrgSMpAVns6RNkvZaok61WlJ6uCkPvZM5BM14AiPzCNDjkOTTTMazIpKHnEErBDavF1ltYs0lcQGuh0pOo1lnqhzh1Ih8px7f/+4xtMQmLLomn8roInn/XHiN6iYgd+iI6eU40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Mon, 27 Mar 2023 12:33:52 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 12:33:51 +0000
Message-ID: <841ff665-0cf1-50f5-a470-59085972a0e3@amd.com>
Date: Mon, 27 Mar 2023 18:03:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 2/3] drm/amd/pm: send the SMT enable message to pmfw
Content-Language: en-US
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com,
 mario.limonciello@amd.com
References: <20230327072437.580766-1-WenYou.Yang@amd.com>
 <20230327072437.580766-3-WenYou.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230327072437.580766-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 061dfed1-0e94-45c9-c814-08db2ebf8535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25VXXwhaLpWQSbkGMTqz1o/kEShWIzrYIgAcyLtzL4ExP3vbLu7U7BMryBVxz/G1frvgBUDCpzd6TPprwoz9vx1EOfLWJbpW8QdbT9vitbJRIDhaUVlwAUz/5ruRJW01+W249EGQaKcciETtf7+dvjP5z4gCroH+3iC7jQNxpwl7C3Y4Xb2CDsPNqg9EL1Il5ODqNdsqjN4bNAW8HQlwHtUVAtaBlUybch82Vhcmn+wwGErjdvwu6RZazK/CMZvkyjDEGjhXfR+yCEpmH61d7Gz2TYvCesOO+2D1H0CsWvvvNxZCtzjfebWwu+wNv8mTdYIm1RYzslhW828EULvCU6u+l1emApQNa78lfI3wiDkdCMYk3eSwbL0Jx4IXai+K2WtL0vp4E3A0mdO8ft4MWjHRWKb/fmOZ8O4KIS24o0XE134bl4leksnwDQBD4i/ddHPsR2n32X2N66+K9/z6vrTrxqYh4XGrQtUkUDizxHYB7dodROhkH9YykRNxmZZSZidITRJulODQQ8d0newWpOLVjU+fJFYWXOYR23Uk2T1m7KPdq7MhZ6uKtId/8DJzDpoUzM/L5AQLkfz9YvadPyjjmKLmZ3dtFCd4HbAdOJl/i8x8KUXBzKn7HyrKSNxly/EMGLBd1N1iJm9QIzwEMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(66476007)(66946007)(8676002)(66556008)(6636002)(4326008)(316002)(8936002)(5660300002)(41300700001)(38100700002)(6512007)(186003)(53546011)(6506007)(2616005)(6486002)(26005)(83380400001)(6666004)(478600001)(15650500001)(86362001)(31696002)(2906002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXIvYW1TOHo0Z0lPZUk4Rit6aEdkRVowNkRYTnV1MkpPYWN5amhSOVlwOHpx?=
 =?utf-8?B?dE8zekJZdTRLZVJqQnlHOENCTVlDL09JQlJ3bWpzUXBlUlE4VnZ1ZEpXZHRU?=
 =?utf-8?B?ck94M0N6WFpxNUVvWi9rOVZ1d1NTU0d4SjgxUUZPTGlZTWcyWFJ5SzdOVS9h?=
 =?utf-8?B?ekVHekZCU25WTklSVFZBaENId08vK016c3cxZ1dsSzJOUHVqSXNvSmMyeHo4?=
 =?utf-8?B?aWZZRldIMHRJU0htOGN2TGxUdWZnR21qdlVZb29zaUpQSmVIVERJNzhjUS96?=
 =?utf-8?B?VERFQkFZUW1Rdm5oajV1c2RZU1d4ZGxSUVUrdTAxTENJYVF5bE9pczBGQ2px?=
 =?utf-8?B?N05zWTdyTlIyTmhuUDlVSklKRXZvdEZIM2FiQmhvMFpaQWxWaFdZaDdvWmNk?=
 =?utf-8?B?Nml3U3FKaWUxMDJ3bFh5ZWlnZ0dDR1dVcytLR3dIaXVUOWdFKy92Ylk1dVRO?=
 =?utf-8?B?YTQ1eUE4OU5Ib0xzWkZtRzM0V091Zzk5UHZxbHoydWdJY3BPazJXRTR6ckE2?=
 =?utf-8?B?RDV4UXA2dGdCVGVWdGdGMDZuT3RpMFZ1S2F0blhuR2RSeGMzTUdVZ0dEaG15?=
 =?utf-8?B?RVE2WjZvU21DMlorY2F5M2dSUXBxSmpqZ0ZlZTJXZHl5N0xVbzNuMGdjdG45?=
 =?utf-8?B?M2lXbzN3Q0lrelVDUXJpVzFLMUNXSU5kc0QrekJRais1SkhRYjRGYVZMcUZh?=
 =?utf-8?B?cFJNNXJ0REpGNlE3VlJkbTNSd09HV0hZSXFIMURUVlEvYVBTQUx3N1pFYUlp?=
 =?utf-8?B?aGxqMU9xY3lZNzJRUlZrdDd6RUpUNmI4YThSSjRZODlMTDh5UnlYOVpCRXFo?=
 =?utf-8?B?RUZ6UmI4RUxRTG9Hd0NMYlNIYTVldDRnc1hWMXRDTVRKU1BqR2IzN1BqcUxk?=
 =?utf-8?B?OCtvb1N5cVdMUkhxSjlYUFEzdUt6d1oyTDRTc0lITkhLYUpieFA1ZGVSV3Qv?=
 =?utf-8?B?MlJJRmNPaTV4MGNJSFpuZFdtUmE4VzZmc2xSUWQ3MGVJMEx4MVUxb0Z4UDFs?=
 =?utf-8?B?NTVrN1VPb3ZnUzkyUEVudEVmSzVIWVNVVng0cW0zN2o3SjFWVVRaWDl0eFc5?=
 =?utf-8?B?UjJHa3gzemNNVk4vWG1JZTBSTTNlNkNVOWEvNStUMFZSWkJ0UGxDVlllM0xw?=
 =?utf-8?B?Z1dNTERacjIzdDdad2g1QXEvdmF3ZDBLdGxDYkJsZm50RnMrRGpuL1Mzc3dK?=
 =?utf-8?B?QUl4dy9HMXV2U1hVRXduRFU0OVBIRHFySU0vK2RJU1h2SWNkTGg0dFdvNlgz?=
 =?utf-8?B?M0dzZ1l2aGJWc3lJQStIR29CUnU3YTR3dzJiVG4wNkM3ZGV5RVpKV0p2RGtH?=
 =?utf-8?B?N3NWYmJmYUVjaEVTcUFqQS9XQ2lXNkZjUk5BeXhPUlI1VkltWWMxbTJEMVZN?=
 =?utf-8?B?K0ZURG42QmJZdzJOZ0VocDJtRXE0REJsclhxYWNJeXArM3hFN1NpTVdiSXVZ?=
 =?utf-8?B?VWJsb0czbFBDVE5WV2R6UGQzcStUdGJsYjF5VTc1MEdvNHJoZUtWUzF4L0Mx?=
 =?utf-8?B?WHY0QlJaMko4Q3k1cHdpWkQxL0RhbXl2NHMwNEJlSEV3aWtpamVVb3FFVTdV?=
 =?utf-8?B?VE1GejM3b2FtOHp0V1ErSEU0OEc1OGlYMUs2QjNOQ3FFM0hySHIwRHdUVDFE?=
 =?utf-8?B?elRyTWRYZjVlVmx0UkpkWjA2TS91aituQm1LcmxSVldRR2Q0eURXdFFPVmFT?=
 =?utf-8?B?UmUvaFE2ZHNHQURWdWRyaW9HM2xRRzhHQk9HSWh3RjFkblhnVGlpK040d0FV?=
 =?utf-8?B?UlM3Qmo1WnZJblNEN3psUFJjU0NzN0RWbm1yaUhYQnZxVVdlQmU0T3RLZFJW?=
 =?utf-8?B?TkcxL0hZdC9TYlp0WU1YRW9TYXJidGpBaFBURDk2dUJzOTZqajBPZ3dYa2Rk?=
 =?utf-8?B?QWROdG9rcVpZaU1qOUpEM2VsWjVnQ2FuNFEvOG9La0kwZXlMaWRpVDVpbkRN?=
 =?utf-8?B?ZHJPbUcvTDhzZ2FzS3lnQk9PMkxNNGJUYXc2UjZxbHJMWkZlMi9hMkR0QnVR?=
 =?utf-8?B?Tk5sR1hSVzFNbHZRUjgzZDRQalZRNytpRStRL252aUgzL3JDcjlxWSsreHlR?=
 =?utf-8?B?c1hqQXJ3VElzZTMwZnU5Q0xyOHVid1FHbldvRXNoZWxteUlXZ0Yrb0VzY05V?=
 =?utf-8?Q?M17ceylZRts4zwwj4zHB/BVRZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061dfed1-0e94-45c9-c814-08db2ebf8535
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 12:33:51.6738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yZ0jB2fmpQpP7lCsovKqErAn94To/3YLwTUhKTeR7j9ICMWk7SI25ZEjBSGEVzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Cc: kunliu13@amd.com, ying.li@amd.com, amd-gfx@lists.freedesktop.org,
 gpiccoli@igalia.com, weiyuan2@amd.com, richardqi.liang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/27/2023 12:54 PM, Wenyou Yang wrote:
> When the CPU SMT status is changed in the fly, sent the SMT enable
> message to pmfw to notify it that the SMT status changed.
> 
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 39 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..eb4c49f38292 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -22,6 +22,7 @@
>   
>   #define SWSMU_CODE_LAYER_L1
>   
> +#include <linux/cpu.h>
>   #include <linux/firmware.h>
>   #include <linux/pci.h>
>   
> @@ -54,6 +55,8 @@
>   #undef pr_info
>   #undef pr_debug
>   
> +extern struct raw_notifier_head smt_notifier_head;
> +
>   static const struct amd_pm_funcs swsmu_pm_funcs;
>   static int smu_force_smuclk_levels(struct smu_context *smu,
>   				   enum smu_clk_type clk_type,
> @@ -69,6 +72,9 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
>   
> +static int smt_notifier_callback(struct notifier_block *nb,
> +				 unsigned long action, void *data);
> +
>   static int smu_sys_get_pp_feature_mask(void *handle,
>   				       char *buf)
>   {
> @@ -647,6 +653,8 @@ static int smu_early_init(void *handle)
>   	adev->powerplay.pp_handle = smu;
>   	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>   
> +	smu->nb.notifier_call = smt_notifier_callback;
> +
>   	r = smu_set_funcs(adev);
>   	if (r)
>   		return r;
> @@ -1105,6 +1113,8 @@ static int smu_sw_init(void *handle)
>   	if (!smu->ppt_funcs->get_fan_control_mode)
>   		smu->adev->pm.no_fan = true;
>   
> +	raw_notifier_chain_register(&smt_notifier_head, &smu->nb);
> +

As mentioned before, it's not a blind registration for any ASIC. This 
should only be done by the ASICs which are interested in the 
notification and not here. So this should be somewhere inside 
vangogh_set_ppt_funcs or part of a software init callback like 
vangogh_init_smc_tables.

Thanks,
Lijo

>   	return 0;
>   }
>   
> @@ -1122,6 +1132,9 @@ static int smu_sw_fini(void *handle)
>   
>   	smu_fini_microcode(smu);
>   
> +	if (smu->nb.notifier_call != NULL)
> +		raw_notifier_chain_unregister(&smt_notifier_head, &smu->nb);
> +
>   	return 0;
>   }
>   
> @@ -3241,3 +3254,29 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
>   
>   	return ret;
>   }
> +
> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret = -EINVAL;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> +		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> +
> +	return ret;
> +}
> +
> +static int smt_notifier_callback(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context, nb);
> +	int ret;
> +
> +	smu = container_of(nb, struct smu_context, nb);
> +
> +	ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
> +
> +	dev_dbg(smu->adev->dev, "failed to set cclk_pd_limit for SMT %sabled: %d\n",
> +		action == SMT_ENABLED ?	"en" : "dis", ret);
> +
> +	return ret ? NOTIFY_BAD : NOTIFY_OK;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 09469c750a96..4d51ac5ec8ba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -566,6 +566,8 @@ struct smu_context
>   
>   	struct firmware pptable_firmware;
>   
> +	struct notifier_block nb;
> +
>   	u32 param_reg;
>   	u32 msg_reg;
>   	u32 resp_reg;
> @@ -1354,6 +1356,11 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @set_cpu_smt_enable: Set the CPU SMT status.
> +	 */
> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
>   };
>   
>   typedef enum {
