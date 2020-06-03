Return-Path: <SRS0=8ysN=7Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB67C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 09:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD70820679
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2020 09:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wURIiIzu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD70820679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F16B89A35;
	Wed,  3 Jun 2020 09:49:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A78689A35
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2020 09:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Er0AE9iOSJuCkaDaonmfF8LJfNcDj9uUcGsLsW/jPHazpzXObJYmdi0LSmQXzCkRYH/I59WEQv573pkO7EX9RBcGlzoqaoOwte2wr7Cy88V7oEeZ6VJxWc7ftuF70Dy6vHnd/JNlCHN8xpZKgMdQdcl/4zl4WOUUaEMHLGdQJrT8xqD9+xJerDiWj6hJqUjavnhie/fUpcxe8RbQipqUcna1beDCRkf23FOQhWyFBzca2hX9rBumBR+j/xomBTgLhLalhpvR9LpKtINzFDCmUdIqbF8ziTEoE2goWeNGtH0Jt+HIa4dQosYmHN9ASY0sYNhiv7ZxURXl1PEKKhlnbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnAieB3wbzltYgdsuRGVJWZ2+iAgK7vIDi0xnPIH4Gc=;
 b=Oqj15zOhTUaanwVeJCB/1hg5504xHy7RXHcVSI5iFlKaehSF9DROVfu5/6a3ERzJZpXq1AtCghG0FNKre6FIqQPpiKJV0PLiXi/q7Os3wolaT0ia6rlFCc/n+dqmgzKClgjLMmIBndRXZBTG2WPDRoBStPWSsJ2NTB9Zoaf+1tYs4IbhO+Oq2MlRUZJPI31D7yRrlaBeY6SzNnLkqTjXytz+amlVL7aoA+/IX4pSWoUtWJ272M/wZbOtLgKaM23ul/oATOEZm3LUbd4M0NdEVoGrZwmDBfu1QgHnsVy+uTNO16rCeKGIj3abCyvtk1+CzIMy7Qn1Ynrk7iOl7ibriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnAieB3wbzltYgdsuRGVJWZ2+iAgK7vIDi0xnPIH4Gc=;
 b=wURIiIzu1vC8KV3pjVAvdgx6trZGlOf1WF85jhsYK58O6M8IMHG5P7pCHVgxRiThyA5TtGukPCL6Q6nQJOxiKbDSX/HqpIebHc/5lLDYePALXdGp66UVjRsj6rLAfGNbQqJG8AkFmSHbxAnROnaHeCAXsIDBe6xPpT3/6kLCt2Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3424.namprd12.prod.outlook.com (2603:10b6:208:cc::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 09:49:50 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 09:49:50 +0000
Subject: Re: [PATCH] drm/amd/powerplay: use work queue to perform throttling
 logging
To: amd-gfx@lists.freedesktop.org
References: <20200603050327.16680-1-evan.quan@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <422ba5b8-8072-e4b7-96d2-3777df797b64@amd.com>
Date: Wed, 3 Jun 2020 11:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200603050327.16680-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0093.eurprd07.prod.outlook.com
 (2603:10a6:207:6::27) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f23:9100:e6ba:e215:4eda:84d0)
 by AM3PR07CA0093.eurprd07.prod.outlook.com (2603:10a6:207:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend
 Transport; Wed, 3 Jun 2020 09:49:49 +0000
X-Originating-IP: [2003:c5:8f23:9100:e6ba:e215:4eda:84d0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 769dcfab-6a9b-4ef8-f749-08d807a3751e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3424:
X-Microsoft-Antispam-PRVS: <MN2PR12MB342466FF8D01408BCC131FB68B880@MN2PR12MB3424.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqBurbm4pTXk4diwGwIyc75l5DnzIHbKu2ecRFJhXClxHrRMl6U1neqHxUY+1BvdbnO+1XG36zTQtULE0TebC4DWFKjEwzaQioND6zrJpAUq5FSd6z29Ig9rUh5Pi9iUejgyn9KBOsIbAV+/ULqzD4dTFsJWeTvJQY+PeMR2eXPLIc0NS8cIOevp60bqi8s16NU2qCXD66DndhDj1vG+ZWAazZAUjPJbeIn4hcnmOao+Vlc/+mU6GpNsK0vrcAHvPig10Y5LHk7M3DlLvBrtxMXNSxYh9mJSCRAHh39Kp3rPwAdnm9KYrTmBf41WjxOG3lVCPIlQpkL60d9T34ximXl5LcacKN3Tb0r3O9BjiAOifcfvuLdhLctAVNuGBGB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(6486002)(66946007)(478600001)(83380400001)(66556008)(186003)(6512007)(66476007)(36756003)(2906002)(16526019)(2616005)(6916009)(31696002)(5660300002)(31686004)(316002)(6506007)(8676002)(52116002)(6666004)(53546011)(8936002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y56aRZdYhIHAVftMJD3TKGZtqo72bCDbFXpPj+WgAItvowgVzQ2ltVsklCM/JN+cmoVe9/eyjbN9IOX9dVxyIWEeyrhF1MGlAZ9hunoP/8PsC+3C8jjhju69LbEWkftRaCC4Ey0OYK3GTWU3De1PfW5cVQ3NKy456c+0I6KpWrgfNfxoNVL+N94/8xoMSJjk7Fj2PZxxGZdaVDXigvzNA1q55737FcGr1yiA+0hGCok8SXtxaquvxQzci6tmWheB08N0UHfeG68GNzT0DKI4B1MHVRLBuGPIeCtdKGjPB8XCMR2I236VmZrxdz0u+FBhRTzD9xJs6rcxr7+ciMEiNLIKWDDv2JyMrx7aOwaaPOwsdAQJgl9ywqWsPpoas9dvi5SjDFcBRBwrYPRRTcPsDr+jMNO83kjpA8oen1/v6yqc0uOm7zRGPeAbGDhd8ZIRDZB2Awjd0nZ7trrCeqBmPJfHrufDnhvr/es0jqpGX3L/28vcYtgpIfSljPUARdyPu2yHvBHXAvHcsh88sZZhLS2jU4QfgDl4+vOgPMo9l5E=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769dcfab-6a9b-4ef8-f749-08d807a3751e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 09:49:50.0561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /382+a4//QSn395KPtatfie5NgPhneCjxyhnAxfmBm0pU6C1BBSNxfxGIS9Yso5orhlTi69mA6iN+pSVTDYP2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3424
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

LGTM

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/3/20 7:03 AM, Evan Quan wrote:
> As IO operations(access to SMU internals) and possible sleep are
> involved in throttling logging. Workqueue can handle them well.
> Otherwise we may hit "scheduling while atomic" error.
>
> Change-Id: I454d593e965e54b13fdf04c112abb0a022204278
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 10 ++++++++++
>   drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h |  2 ++
>   drivers/gpu/drm/amd/powerplay/smu_v11_0.c      |  2 +-
>   3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 342fd75b0806..e25a3b1ce7ac 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1053,6 +1053,14 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
>   	return 0;
>   }
>   
> +static void smu_throttling_logging_work_fn(struct work_struct *work)
> +{
> +	struct smu_context *smu = container_of(work, struct smu_context,
> +					       throttling_logging_work);
> +
> +	smu_log_thermal_throttling(smu);
> +}
> +
>   static int smu_sw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -1074,6 +1082,7 @@ static int smu_sw_init(void *handle)
>   	spin_lock_init(&smu->metrics_lock);
>   	spin_lock_init(&smu->message_lock);
>   
> +	INIT_WORK(&smu->throttling_logging_work, smu_throttling_logging_work_fn);
>   	smu->watermarks_bitmap = 0;
>   	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>   	smu->default_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> @@ -1295,6 +1304,7 @@ static int smu_internal_hw_cleanup(struct smu_context *smu)
>   
>   	smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
>   
> +	cancel_work_sync(&smu->throttling_logging_work);
>   	ret = smu_disable_thermal_alert(smu);
>   	if (ret) {
>   		pr_warn("Fail to stop thermal control!\n");
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 6f44ffb6eb51..b970b4d663b0 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -411,6 +411,8 @@ struct smu_context
>   
>   	bool uploading_custom_pp_table;
>   	bool dc_controlled_by_gpio;
> +
> +	struct work_struct throttling_logging_work;
>   };
>   
>   struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index adde9eb7b283..69b1160d8ba2 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1597,7 +1597,7 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>   					return 0;
>   
>   				if (__ratelimit(&adev->throttling_logging_rs))
> -					smu_log_thermal_throttling(smu);
> +					schedule_work(&smu->throttling_logging_work);
>   
>   				break;
>   			}
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
