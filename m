Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDFFC7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 08:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C380910E23C;
	Thu, 23 Mar 2023 08:29:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A7910E23C
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 08:29:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjRYp329mkZKKzLwAGImsMo1CJZfrMA7IpasqfOXuP8V8CF41EVKBAjoc5VjY7RTjMfaRdUo741oXQCNjsoj5wSyoQdDrLkpNvF4a3TIzrvc8hquRFXWRJDKJid2Q+O4E+yIRg9dC88lT0Lz7bihM49Cw+o8VWroxbYZt9LSIDqmQG3oqxjUz+yPbYbXKhwm18406IWyO8HFCKhCzY+eg59/cW30DOBtCXvgPBJbPAcsixis2IB2kKXX6cN5MASHrqBSxT66e9mQLLKDC5Yrjnxj3BqinQ7zX+EuT8YIUdxHhmHegLMRj2NcIgctyknX23cUTeoeZTrkE/Rwk+VDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnGGJmnwW+F9lYKOj1gOmN1eqCV1LM+QMBusoCuJrmg=;
 b=iEq/O9ewXmabidP8B2/NBcqTohkPg0ZBThbeIN3VfXYpUHfwHzIs9Dqnza3iTg2HzpvDNdxdlsdGeWi/lXMjhnLYrIPh/qWgO6JO+ijv3kQAPiBAQZSdaBGgwIDWL0WjpoEtIsGbbuK+QVdhYFkoGHD9JQPk9sK+VWGXNtPCJYHe/JAkmLdVUVjVX3h5GqgDLbHfU1IV4MGBQUvpFuUSiLHWLFE2quxaisSize6fEeXVMKHG7NzMhYvqfPd6jZL9Agbiiq+h/lSWRV9lz+NPJtNHO+2YgcdyU8krDd5oMSVvdIx1zYgw6H/EXdKPq6QV2m+q/AZlewcdh9fXyNvXkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnGGJmnwW+F9lYKOj1gOmN1eqCV1LM+QMBusoCuJrmg=;
 b=QY2/ZM5BvzsNbyyAfaYFznoeemaExYCOlvFIKVGxG9w83PHYyLrRTCcAw2boKqBPmz/u3x0Db21HbX/ZdZ2fo7R6vUVZWmNCgsiVKrveYxnJfj9DxjGY6wtwArKdlS+AHXr7le4qvYQVd3OLaKKmXPNbXhoTNjlKw1UrdHud4wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 08:29:19 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 08:29:18 +0000
Message-ID: <94cea821-dc35-4324-6b65-6ed82a55b442@amd.com>
Date: Thu, 23 Mar 2023 13:59:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Content-Language: en-US
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-3-WenYou.Yang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230322091607.1609145-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 00879797-ea2e-4420-fe95-08db2b78b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mrhmtfu+3nuJwALxYWaSytyZ7ujoVeSVeTQNjpq/2BqQAaYA+hBYGiNJRlo2/avIoQWsOiw/0ERzWn86U7bSfGA5w6UqtMd9crOvz8OzELR847K4kGmn3xJ/gP6d/b1y5qL590JsxEcDdfkbXpAO1Z39RKMvGjcKmpJqQ0Lnsd7wutFKQLLclOBUsoQdbCnEDmPk4Vo9l8c6II7B0pz3/2Y6IPHmOek9OGRtT7xVUxCsgluHaYtxylj3Ru280MINn6YM0u/c+4+7FLR1MSBHbMZuCYgFJ1kj9VGTGG30Nyiv4mFoXiuQ98+DPH3wXLmho80S/XqwMYy+Phf356UuGGnCU6YXX/eET+2+S4Q4FB5J33yDFeCMUygXZV5WBSRAHYfV0fAB/krwvSrO/bq/13PjBAq/SNqgXMIm8ybCetNGKje7967nhhrhQoCOi2VjZjac+jyzRalWHyh6+aQ4ULAakSM0SrBZUOxB0eN/7PNHF0JHH7WVac1zhfTwMqg6a4NKHKPVu0dgUsRNZ1jeBfe0UK9O/wJbGq2pwuY1EmwvqFLtfmKidZyLwoFWK/qYCo4y3LN/wEOaLo2qveSPhLoeNbZRcMeN/nzZeAZIuxLKSwIaSA2hXgQ4NY2LhwPcZzFPPwucZjLk+Xw388kNj8bfRYot2t+XLJ9fPdyp4ZtLFburfGgvtpC+Hw372Vr7ugeCiEI8YQe0hHyJ0LZw6P+6sL6g5eoEXma3f7ZA4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(2616005)(478600001)(6506007)(83380400001)(6486002)(15650500001)(6666004)(316002)(6636002)(66946007)(8676002)(66476007)(53546011)(186003)(6512007)(66556008)(26005)(31686004)(4326008)(5660300002)(8936002)(2906002)(41300700001)(31696002)(38100700002)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzQ4OEV3UmJ4TWIvdVZIc09MY2dTZnRoUTJNRFJaY2VuNW5HMng3N1IzSG5p?=
 =?utf-8?B?aHljSGNGOTJKNnhiL2FkT25ZUjcyR2VweWx2YURhOVJnQmJUamFsdVIrMlVx?=
 =?utf-8?B?WFZOWlFtQmJRMW5pZW5hNFdZdGpSSXpzTVFHQTk1MXRyaW9Jam0vcDBDM283?=
 =?utf-8?B?TUJ4SGdFdEJqbExxK3QwM0E3ajN6ZFAvdUxOcHJMbVFFMkV5Y0pDeE1XNmJo?=
 =?utf-8?B?WlA4VE1Oay9JSURGQnV0dEd1dEJPK1dlT2k2cDl5eExxOVcxSTNBTUIzbi81?=
 =?utf-8?B?bjdHU21NTGFyaTNLZ00xT2NyNTNtZTVUaTFQbEVkZW1NWXA0TnV2azBIbzBt?=
 =?utf-8?B?RjdsZ0hxbG00ZDRTY1kxY2VzT1VpZDZoeWpnNCtvRGM1bURvUXlQVkt1RDM0?=
 =?utf-8?B?UFlnLzZucGI4WTJIcmJTYnFuVWgza2JTcjZDd1owMkQvUjFlN0J0aE14K21R?=
 =?utf-8?B?U2FFLzhIY3RWOGpGem54a1RTejd3WG1iOU5zczdpd1I0UnpjNkt4WjNvd0Z0?=
 =?utf-8?B?RTl2Ukxocnk1aFY0UjdnU004WmFiVUFYcUVqcjZRQkpkaUVnaW4rUDJyL3Q4?=
 =?utf-8?B?MFBESlVNd1BwTm85ZFR5YmRJQ2hnV3hjODBMN1ZFVklKWFJNbnpCOGh1TDB2?=
 =?utf-8?B?MmtjY1hJQ2c4dVNwNEFhWTlxZGpycVV2ZDRKaUtiQlNDeEVEcFltTFU3UjF2?=
 =?utf-8?B?VEp4VFJSUEdkS3VzeUkydi9haUZtL1pQZlBrbE1SVFdHMXhKdUVjdFl1TG45?=
 =?utf-8?B?TTQwRmQ1Wkc3UUNmTzJ2OUlGYndXczNWVndWQTNtbloyMjlGTEFqL2FJeFgv?=
 =?utf-8?B?ZWUyQnFqK1ZPS25ic3NLWjJ4dHJaSVA0SVN6aW83ZEVlMThhUW1MVHRVVGFX?=
 =?utf-8?B?T1prWlltVzMxTUFnQVptaVltVmVFQXVGWEk5NWozWUxyOWhaS0p2cVJZTVY2?=
 =?utf-8?B?bC9zMnk5MTEyM0FYd3JJTm1WRzdYRm16WHFBVFNPdWh1S1dNVEF4OW0weFJ3?=
 =?utf-8?B?c2tURE95Q01VRzM2bG5hb0lxaXhubk1iNXRSQ1FKZUc0NUVrc1BvMG9HbDBj?=
 =?utf-8?B?dmNnbWJ3L0FVRHBMekl2SVNEbEtKNGlyTDNDbG1XOHJKK3NPSTNrS2o1Vk9u?=
 =?utf-8?B?VVp2S0ovQ2lXR1ZoelcvQUttWFViamhVUXJJZ2plS3lMSVNVQ2dBVXk4TjNS?=
 =?utf-8?B?WlhXaE1MWkdPckp1VWR6RWtSQ0xwTEVuUUtObGIyUXlLNkVaOUtMUjJia3ll?=
 =?utf-8?B?V0Y0YVYxWHhBVmZ2cnl5eUYyWTc0SFlHbE5reDAzSnp2Ym5CU3NvL2RRSzNw?=
 =?utf-8?B?dUorSXFuVTdJVFJ5Nm55ZktxTTRQckVrL1BURHJnbkhUSCtra3BySlNTVGtn?=
 =?utf-8?B?L2EyaGw4Vk00aElRT00rS2FZVVVNRUptblExTUtFMTFFdDhCUEhvcGJuWHR2?=
 =?utf-8?B?cDJZR0xRc3Nva0JMWmhGZ05wZ1EvU2cvOWlzNmYwOE5URDZRd2lXb202NGFE?=
 =?utf-8?B?QmdBcmRSbmx0cGxQcWVTeWlVMnVxdnpKMmFJMzdYRWNGNElTMHJCRjh6SGdC?=
 =?utf-8?B?QnovWk1yZ0M5TDY2c21SdHNZZUlZcVFqODF5aThkc252RDBFWUZJRUJwZUJZ?=
 =?utf-8?B?V0JMMnFycEhMRG1lOGdvTldZSFR4dzVUT2VkeUFwdE1RMUJpb2RueVdRcEZQ?=
 =?utf-8?B?S1cwYWFwWEI2T1o2VnpuT2wyN2RBdmRWYWZHbHJlTnl4MTJGUDZpeDZUVUsv?=
 =?utf-8?B?MnluWUJINVg3TFpzNC9sKzRmcGh6S1I2OHcyRW96Zkpja3RIejdaODJtcmNL?=
 =?utf-8?B?Sm9SRjJXR3V2TlUzUFVPRDl4UjUvSktkZCtwV0tBcytyQm1TbHAwMXd2bVg5?=
 =?utf-8?B?RjVLQlVzSkVsZlZGQTlQYXZzVWl6cktoNjhBdnY5OERiR2lUR1gzRmZsWnJN?=
 =?utf-8?B?aTZzUEptWmw4OXphNEZjOXJieG16ZXdMYWdtbHg5T3FkVEJVaWZCY3hxaWNz?=
 =?utf-8?B?U1FKa0dTZDRZQkRYRjVqOTQ2blI1ZWJmUWpKRFJ5VU1PcDNLQ2NjbkxCa0Fx?=
 =?utf-8?B?N0tCVVQ3TE03UUkyeWtXYWYxL3Z6NWFueGs2Zy85Qyt5WVVMYTdkc3FLTlgw?=
 =?utf-8?Q?MylHEMVsZYPWTPGd6j6Ymqxuy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00879797-ea2e-4420-fe95-08db2b78b1c2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 08:29:18.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0bZs6+L7RcS8rX8LPFkxsWNmg6flFT/5eiOQH8/X4G4Dn8e6vPMX7CF7cy5hxOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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
Cc: kunliu13@amd.com, ying.li@amd.com, weiyuan2@amd.com,
 richardqi.liang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/22/2023 2:46 PM, Wenyou Yang wrote:
> When the CPU SMT status change in the fly, sent the SMT-enable
> message to pmfw to notify it that the SMT status changed.
> 
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
>   2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..5cd85a9d149d 100644
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
> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
>   
> +static int smt_notifier_callback(struct notifier_block *nb, unsigned long action, void *data);
> +
> +extern struct raw_notifier_head smt_notifier_head;
> +
> +static struct notifier_block smt_notifier = {
> +	.notifier_call = smt_notifier_callback,
> +};
> +
>   static int smu_sys_get_pp_feature_mask(void *handle,
>   				       char *buf)
>   {
> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static struct smu_context *current_smu;
> +
>   static int smu_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -645,6 +656,7 @@ static int smu_early_init(void *handle)
>   	mutex_init(&smu->message_lock);
>   
>   	adev->powerplay.pp_handle = smu;
> +	current_smu = smu;
>   	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>   
>   	r = smu_set_funcs(adev);
> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
>   	if (!smu->ppt_funcs->get_fan_control_mode)
>   		smu->adev->pm.no_fan = true;
>   
> +	raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
> +

It is not required for every dGPU smu to register for and process this 
notification regardless of the system they are in. It is only applicable 
for vangogh and hence this and below should be moved to some ppt funcs 
used in sw_init/sw_fini of amdgpu_smu for vangogh alone.

Thanks,
Lijo

>   	return 0;
>   }
>   
> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
>   
>   	smu_fini_microcode(smu);
>   
> +	raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
> +
>   	return 0;
>   }
>   
> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct smu_context *smu, uint32_t size)
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
> +	struct smu_context *smu = current_smu;
> +	int ret = NOTIFY_OK;
> +
> +	ret = (action == SMT_ENABLED) ?
> +				smu_set_cpu_smt_enable(smu, true) :
> +				smu_set_cpu_smt_enable(smu, false);
> +	if (ret)
> +		ret = NOTIFY_BAD;
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 09469c750a96..7c6594bba796 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @set_cpu_smt_enable: Set the CPU SMT status
> +	 */
> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
>   };
>   
>   typedef enum {
