Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0FCC74A5B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 17:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B1C10E0E6;
	Thu, 23 Mar 2023 17:41:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C693D10E0E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 17:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsVPAAmnAwMZx0Qc0HiOHIqqoW+OmG0KKWD20akf6Kabpl7i4FDeqEmTnSAjJZsJcuLchXz5cWQNKP6U+qhmJ/V1YcNdJBXpnP/Cve3KAFltGhpYv2XRkSgYencMe0gQNh56EqCdhm3aKTUa67p9Aix4gTIDEdV6uPe+LmF2sLSi+ToTfiz8s/xHhSlFJoiFKwf5M4G2M/LD5kX+XMnJdl2AdS8bzp2zhfMs0cybukLThGoRlFrA2cd38rq04xPm8yCIs8ylHM1T3YfC/c9GDshuXKlHiNC3dmT1pSNf931s1Fw2iZkFvEaUQRHVgNJWYfzlH5D+1BwqUjEnRUSWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGxngh5didm3Fri8TzIo1eOvH4/+HZ7IV8yye0rESD4=;
 b=RbMmh66+jEMLAqFrq9P0bufQb/RNhXjb2o9q24nKPFYFRsOpK+2qLbByv66nmiFczt4wjIm8Deael08RlCN5xHQ9hjnBNRhYZlCr2+e44ab7l1rRGifIc14LTu2uVWd7iThc1el9iZNcBnAQFIJW1PYtrY36RdBkB6dijuv2n0WKwWuHrI7vL1RlTyz+cMLcFN56qxGjw73tjTH6yYRfuA/kWRmgles7PJExdWVVQT9pyoqc6Yerof6yq9XU0gzG4MP2nLWVRc9AhUQLAgOd1N4feGZbCqAjU7u5Fx0Fo8/1jOyX4pn3lYRw7NFQLeKXDARznVMr+sCY8z9ybjfs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGxngh5didm3Fri8TzIo1eOvH4/+HZ7IV8yye0rESD4=;
 b=pX7zqCMbWkHc5+Olr5N+Fx3RPyf2T3s7l5Wqnt1U51JC0XBvdWeHLhAq8ZpdTvyMNOCDKAu6dSB2yG2zu9Q85/FT5h8csoUBCSOHemfy1roRkRoRreqYH+zfXq0O7EaI18xSiyZYwW6+ySxaTXFyEdqf21qMhJsrWCtmOS1ELDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV2PR12MB5845.namprd12.prod.outlook.com (2603:10b6:408:176::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 17:41:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 17:41:33 +0000
Message-ID: <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
Date: Thu, 23 Mar 2023 12:41:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Content-Language: en-US
To: Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230322054808.1555230-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:610:b3::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV2PR12MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: fb62a018-ee05-48ae-e013-08db2bc5d7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OAu/8+vK8nMLJMWIG+w8J83pdskiHfTjzYad2d0U0cS0dX1ibPgYofY6bu9IQBa9rw9qlZgv1uj53uHj+Y5ECoipidHNmzueKpUw1idjsuz18ulUGsk2oApcQk6M3bsS8MWmG/Q88Q6Uv6SHA13lGv0yhvwFKZ48OJU8fOzNGKdC5XXRg84/usRoTC6IXiQ+sdj7ZVDPkA4FeFYWJ+tV1tfNBVjYUbyfBZIpFiex0rpg/285IS0f8m/4OAlt4MldAfEvrOBrdmu2BS20+1zno8Nqw+SuC3kLvx9CuXZALtEsrJfxj6Yc0lX71AAgHNJk4zShJm+IJ84jSjp+zmBOA/iuHZ/KvJ2/Z4Wr/D8kZ2+Ey4hHA0ENCwSVc9zCg6FDwU3FX5aG7MYVhm2k4MmgaI8EXSdHTveSdmUKEDnFo26j45u6mhkBBsAQ+jyboQ8iFRtY1ATvDs+A89cFuXLH43FB0Q9fMjwmaZcgpXXXv5UVReawGsxVigPGiZdi6lWg7NwUTyVhm+G6rFoNMiGEZJurAj8OsH2fTUUbzsq8Lkxok2uU2RBGHl1EM8+nqVkfiUWau0Mq1EF+4c+0Be1Y7xZAleit+uMkbzkmLiLH2Xa+uBbfx5MenmOxNgRKvFDuAPQ8AGVX4BMvlhpPqupNCmXrTc40C1m+OzwXPULZJxpcL5RZosVXQUwAlRlcXooJ6ZzCn95iJ4SR7Ibe+2Ty5/qoCeoPAA8eeEz3+ODfprg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(6486002)(36756003)(6512007)(6506007)(53546011)(26005)(83380400001)(5660300002)(8936002)(2906002)(2616005)(38100700002)(15650500001)(31686004)(316002)(478600001)(6636002)(86362001)(31696002)(41300700001)(66556008)(66476007)(8676002)(66946007)(186003)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RS9sQWwrVlV6Ym1nQlczbDIrQVk3TUtXVXhaUlA2VTVWU2d2UjdyK2NiUHNS?=
 =?utf-8?B?TWJhTXlMZkN3OXR2aVRvNEx0YXlRQS8wcFR1cXg2bmpodzNDT0NKVXdlY2I4?=
 =?utf-8?B?b0V1N0pnU2lKUUNWSUw1K1JUc1BydkVQeEFwWTZnbFRoUjB4dTdoQ01FV2hC?=
 =?utf-8?B?cUhrVDg1bENJbzFma0pZdWV1TjRXQ1VHcGl3WXV6MkNXY0dzUHVyVTZzQVVp?=
 =?utf-8?B?VnlrSjExckJ5bHNkcDRITmJOWlZ3djVGMWNHME5YM1dhQkpTYnNxOVlMZG1I?=
 =?utf-8?B?blVRS0YxdkpEN25jK2kvOVdSdW9QVWF2OHdRL2tYelBLUEtHZ2Urd0J3Y3Jq?=
 =?utf-8?B?bHF2d0swMXcvNHB2eUxDUUMrZ2lESjJQNlJIU3NIQ2FFLzVvalRsK3oyVVRE?=
 =?utf-8?B?YW5QUjNocDdyc0c3T2VTRFZIZ2FvaEFVYUNKOWVFVEZtM1h0WVRqdUp3a1gw?=
 =?utf-8?B?S2VSU1ZWbnk2bVQ0OFBoRUsrV3JJUE43TE94MnV3SndFVksxSGdhNUlvS2Vz?=
 =?utf-8?B?eUxUTEdJYjJlSk5xMmU5ZzlxM1l5TmU5L2lTNXFyNHhidFV1YlpTTE1pNTZy?=
 =?utf-8?B?R3FIZmhseGF5bGZKSTYzUyt1OG1sdjlaSEJ1Mk80bkF0YTFQV2h6cVJFcHdx?=
 =?utf-8?B?STNNQk8wNzhBK25wR2xON2szVEJyV1V5bVZtTlhhTlF0ZEJTN2dXMEdDdXpP?=
 =?utf-8?B?ZFpMemVwYUJJWS9TOWlpYVFjNGR1aHFDMk43TUJKVzQwWFE4TnpEN25GY1l3?=
 =?utf-8?B?QkdPUm9meWZGdXJMZzVzaEVhK1lHVVVxSlhmcHFveDRQWlA3WkU4QnFtWWEr?=
 =?utf-8?B?bVVVSG96YlIyL0pjSmVsZWVUMVhHMDUzQ0JsTmJja2RZcGdweVRnZldmblZT?=
 =?utf-8?B?U0hMWGM5QUdWdW9tZjZiM3hNcnJna2Q5SVlZa3R0RkYvUVJyZnNiOTZ5SC8x?=
 =?utf-8?B?R2pKcmVGQ3ROMWtYdlNhS2NpZUZiUXFhOUI4NGRMNHpLV2pyRElUZDN1YTEy?=
 =?utf-8?B?N0IvcCtqcktUcVJnbDY1RXU0NGZuekU4Z3M0aHdqV2lBWEI3K1AyRVVpWEdK?=
 =?utf-8?B?YW1UNXM0aGJZZGs0STN0TFo5QndaYndrV09QWHJPM0F3KytNOEtZVjFyRUkr?=
 =?utf-8?B?Q2x4RURFc3RkRlBpUW4xMlYxRG8yU1BtM2Q4UDQ5WlcvSTZzd21uZ2NNd3JQ?=
 =?utf-8?B?YmcycmlnOWJXZlVXemkxZTlrR1g0ckw5QkVRQzZITzlJUlNoR1Iwb2dGeVZZ?=
 =?utf-8?B?bGR4WlZLNkpZcGQyQ05qSURsV3l5aFdNMjgvWjE1Y3ZHUFZMQm1ha2VTQXhy?=
 =?utf-8?B?a2xNR1lGbzB6S2NtLzg0Vkt3cGNOR0gzWVdsNkNYVzBFdEZnWms4U2QzVWlI?=
 =?utf-8?B?cS91VThGNEorY2duRkdzaXZhYzJzeWJBV0ppM3lWOHVQUGgwbUI2QTZLM1h6?=
 =?utf-8?B?bWI0bklBMXlpWkxXZjA5K01zeVk3OFRPSGtUZDJ3eXkxSjAwcERRYTQ5eHdN?=
 =?utf-8?B?K2VMeUlVZkFySG5uZlpKSjE4by96TVNLZ0ZFRHpRQnJBU0tPaS9KaFZ1eGw0?=
 =?utf-8?B?OUVHMWIwWktxNXdndTZ4eFNQQllPdmMweExqcUJDTnBpSFZFRkszSklXS2l5?=
 =?utf-8?B?UVhWVGw2U3RYdGdlVXB4QWY1L24waVoybnQrQWNWRytHcHVwVlptQ1Z2QXdz?=
 =?utf-8?B?NFpDRDJ0RStNY3JUeHJEVDNhV1h1VDYxdUhsRDdidmpnWEJQV3RMNG9Kd2Fp?=
 =?utf-8?B?WmhHNytmM2ZUd09HWFpjNDRNR3NrZk5uSHRRVE1zK0tyTnlSK2dYS3g4VG9U?=
 =?utf-8?B?Q25WSXdnVVZZNmYwODFoYStxSTJTdFVORkZZNS9yNEtxV0I0N3owZmlvd2o0?=
 =?utf-8?B?ZVp6TytvYVM1YWJ3Y0hWTDdFNERLZ1o3cVlCQzVCb1VlZHlnMkMvTk5mTmpi?=
 =?utf-8?B?TDdia1IvdnhLOVlzQUYyRUpLbm9GWlBicGRQUWlQdEwvd29IVS85WkZvd3Qr?=
 =?utf-8?B?NURjL2VZNzBUclZBT3Q1OWJTdStyM1lzdDhhSWltS2pJT054Rm41WUIrb052?=
 =?utf-8?B?cHN6SEZUZVAzV0RZZm42ZStPNHVKNmlFRGNVNk53aUFBQUNhWVorN2hhMWR6?=
 =?utf-8?Q?FRweKhEV8B5gn2iJKuO4LaWhT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb62a018-ee05-48ae-e013-08db2bc5d7c3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 17:41:33.3109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2CsGMBKsyCiNTBTENaMnE+aK70aUciZkMIYC6wcP1GCVc/Lu784/asd1pmFTfJ9bEvw273Vrr2G9QZpLhfl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5845
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
Cc: ying.li@amd.com, kunliu13@amd.com, richardqi.liang@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/22/2023 00:48, Wenyou Yang wrote:
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

This initialization is pointless, it's clobbered in the next line.

> +
> +	ret = (action == SMT_ENABLED) ?
> +				smu_set_cpu_smt_enable(smu, true) :
> +				smu_set_cpu_smt_enable(smu, false);

How about this instead, it should be more readable:

	ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);

> +	if (ret)
> +		ret = NOTIFY_BAD;
> +
> +	return ret;

How about instead:

	dev_dbg(adev->dev, "failed to %sable SMT: %d\n", action == SMT_ENABLED 
? "en" : "dis", ret);

	return ret ? NOTIFY_BAD : NOTIFY_OK;

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

