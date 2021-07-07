Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582FC07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F30561CBE
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F30561CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFE686E84E;
	Wed,  7 Jul 2021 08:50:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57846E84E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 08:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrkwErKkAeuTJfOqtiU1ccx7xE0paNXlvQIgeDmlPno305Oc0DuvBoxfVaMkCJRRbczjXXplG4uJv4TSKUJCu5eRE1b6zP0mifWYJKTcbA2PcZDyxbmqlSWsHB2LZFnSkTEiGrSh/ktzXh6uSJQt3SpaBhFsW+4JGZMG6Afop9QT587foXVK93yP4mqVPU5Ft9j46M1CqQ808on72owDRwAtPAk68WCv5te4pdl6FnYu+zfRHZ3KXMt9R3gB7039T2YKdTTZB0+eHVXP3iCAClWO+9h/OVjbDSaHcztn3daGROVG2yufcTMbVKeTx3N6Lkfh2M98JfuBptoMK0Pc1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2j9iWpDVDH/PBjaNMGQEOpcnd27r7yOroDQvXWbuD4=;
 b=kzssVj6vKOE58mMskwsU2ApNnqt/O8HA9OYg0HBQPI4C75PrA9zkuuqEdZ3O5ee+6yG4uRHpqlXk7no7SZpcKJg6FPD48SUuzAuj/LWgeME55z8ZHbUzCqM5Ce4xYIjtcqQXDcYPkqfztD/3jwBNoNxdIt37MjdbtAau2z7FIGLdj7QkZIER0wixCRK35iTObvNeDyT8LW8LsGmVe+u15fVdLUZKygi0Y8q1maCcpmaBwK/KRummsX0rF+Ku0YK4JYtbWz0ztU3LX4qD8sPN9dpiMTi4JCqDg+wQGKj+7kXAaOztmwNlywrI7GBnsz9P1Eo4DhXFhnzgc3HBeLMg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2j9iWpDVDH/PBjaNMGQEOpcnd27r7yOroDQvXWbuD4=;
 b=S4I1W7bZAWltnaQzLo1EnjsokhjRWdqfzV6/AC0g9Ftml3H3jRdXACkXwCjvISJzxX2IrdOw5Aq0NHeENlJ6kGIVff8UVm1od7gQu9eMCGOQZdRBEIcKDz9O8lizu0NxPObVtChQB6vW5KlXNRMkzSYiozR/urHjP6SFVHWUeEw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 08:50:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%9]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 08:50:07 +0000
Subject: Re: [PATCH 1/7] drm/amd/pm: correct the fan speed RPM setting
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210707015647.139127-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <32e14101-3aa2-78ac-e188-75179cdbe5e6@amd.com>
Date: Wed, 7 Jul 2021 14:19:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210707015647.139127-1-evan.quan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SG3P274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 08:50:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d701b48-509d-4a19-27cb-08d941243867
X-MS-TrafficTypeDiagnostic: CH0PR12MB5316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB53166FBCC0CB261CA659C667971A9@CH0PR12MB5316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZTbbMcG/AvwaHuWdAshA+bqZuafDfKaQt73Fhpcfsuw/IOJRCcu8lIiZOKkpvFkf6M2RpMkMrSJ3HSXxCckVG1q7zfgnNpltL4rWu+Sy/HQBilbU9vsA5ebgj/Y3cV4bgLeiy9xVlG+WI23arj0yb7RF2gOJJH4haVpp9iIn2kwm5gGrEemomq2x9ZtAElyUj0labWJYwGT34R7iQGNTSsdCMi/W73Cq66kOseDjHHWJXXFwW4ooO2XDSegJ6Hl1AZTw3dSDmdSyXPxwmFttD+ulpKNrd8o1/f++7P0a2GDCwMAJtViEwKHqRjPlv5s9rtbRpZN6hRiDJn84cBLPq2Lt2AvF/qPOQOhBZcCbZ8Dk/kco3x/sghS/tylGkcOlCjifWVPeFJeSQip4fiTgkCFH49NQ3mQNEw/Wzs4asJgMfUoLEYZOYSGuPVokvsV+dvjZF06zhWkrhhG1CHDDMG2KBvror+HH5AQBVAxMQm/O8DSrpG3Rvq5SpKJo+fjm0zclwGQ+Uw6gQ/hejZAIrg2wsOWPqhaIdQOzIKAYwtUIqAC5Pmxt7Z5aKXdhvaJC30FBEZiOZ6RZNUvN1eaUl/Tl/aDbHS8wPH+5ax6lOmLdzVdmyKXO3il4SHPjn6Xv2nGLSEosRiZidXF4knNIScXqyM5/k9eQ4wuMbGIm3cHV3PdZVrB8gSfNLPzfk0IkNCSbGfSTXVaVDcmeiw0yZMKets1HHTf8Jhc0SOVL5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(66476007)(36756003)(6666004)(53546011)(83380400001)(2906002)(66946007)(8936002)(8676002)(956004)(31686004)(6486002)(316002)(2616005)(26005)(16576012)(186003)(86362001)(4326008)(31696002)(5660300002)(66556008)(478600001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWZDV3Z6WXRiWEROamMxMCtscDh3WmpFVmdUU0FlL09UOUc3MzhLZ0dva2Zi?=
 =?utf-8?B?OXBJcEN5UWpUdEZtczdQSlZOZmI2dTZwSDF4Z090T1FLaXFtK1ZLYWR1cnU5?=
 =?utf-8?B?RHFHUlYyajNuZ04rRGNFaDA2ekcySjJNK3ZlMUNidXZSU1ZyM1BVN0tJUUxo?=
 =?utf-8?B?dWs0OW5aQ3VOdXpaaENrSy8zZU5tRThDN3hhbWNDT0lSVGtCTCtzOWN6anJI?=
 =?utf-8?B?UnhXWDNZU2Z4NU9xcDlRZXR3bGllOVg5U1JjajVrZm5Sckt3NjI1bWtEbjh2?=
 =?utf-8?B?SklVUElsdHlpdnpoKzdWLzg2L0RxQk1laXdFOXVKOUZxenpVVjdCUUI0cG9R?=
 =?utf-8?B?U0RjelhGbExrR2VyU2dEWHQzSGtQZjhMS3hJREMyNHdtaHZZaHJpdmxTam9q?=
 =?utf-8?B?ZGtPd1pDZGlGNlhKamF3eDk2OXRxbHV5SGpicVkwY0dKRmhmMGFiQTVPMThY?=
 =?utf-8?B?cElDNlpOWWRubXNiMzN2dTV1TjU1L2h1YTJjc0ppZlFkYTlKbzAvYUt0eTF6?=
 =?utf-8?B?Umw4ZjJiRW1KL3BoLzZYMXJQbStuN2liM1Z0dzZqSTc5bGcxWGt3TFBBd3lB?=
 =?utf-8?B?SXkycjJ0TVNlWkFQcFlpbU1IUjA4bHBiVEZUMVpJb2FEdmYvVUIxVGxBc2tk?=
 =?utf-8?B?OXJRdkMxcmx1cXNDcVRZeWpQZndZNWs0UlkwbE1xY042VS9uWG5CMEU4Y2JE?=
 =?utf-8?B?T21iQVFMS1FpN3dobWl0WWVUVitKTDBnVk1lakdhMHA1WktEWmFyWE5RWlFm?=
 =?utf-8?B?endJa285Q1dLNFBZUUhWYkszaUJkdTk5VmRnNVpjSnJVaWZjcis0allkWUcz?=
 =?utf-8?B?cXEwMkxTdG5qOFc3clVPT2FKa3h0QXAwM3hDS2JSVXFwelhESHRrWEhJSmNV?=
 =?utf-8?B?YUtnSVNhemdFU0sxUlc2YitnSGtValJXQ1I5MWI3cERQM3pFRWg0VnV4WnZC?=
 =?utf-8?B?OGlQWkR6WHFxRlY4K295Y0NrYnNMQmZQTDI5b2xQTUpsYTk0N1B1RTI0b3Z3?=
 =?utf-8?B?US9uNVJtaGN0dm8rQlFObG1yV1hOUkVHYjFWSFdKTUdEMlFxZmN3ZnNZbVE5?=
 =?utf-8?B?aVZyQVU1UHRNQUtuWG9idGhicGFnVFBtZzdnMGdiSWU0bERPK1lBeVVDSkk5?=
 =?utf-8?B?OE1BelltQ1ZVb2RRbHpUcEt4NklhUzFwbTRIZjJHcUxxekNHclFPMkhtMGhI?=
 =?utf-8?B?dzdvMlY4ZmthQXVDKzlIdTg5SHFqSUNPQ0pHU0VlQ0l2NFYzN0tycWxjQjdN?=
 =?utf-8?B?VDN6Mmg4TmtVbHdFRXVTTEdTQjNmOHNPU1JLQUwyT0swdUYxZ3dnQWtnRUR6?=
 =?utf-8?B?VW1PbE41NERYT1ova2ZrcjVpS3hxQVQzb1VNQnhqK0J5enNBSmRTRkpoa2tm?=
 =?utf-8?B?elFVUW1VS0xGTDhYaUdRdzJEczIyVHAvWVkxNG1wL25WNmZXV20xVXlvMlN5?=
 =?utf-8?B?ZmVkOWlpYkRLd3VUOTN1OG41MFpvaG5tem9HNHQvUG9OZTlEREtJbldDZThn?=
 =?utf-8?B?c3FHUDVqQ1JuSWJySVo0dHVuWlc2eUd0OEMzaUIvQk41ZjBtcnRRZkFLM3Ro?=
 =?utf-8?B?V3lZakJNUTFsTWJ2UFd6UjMrRUR2VUNkcG52UVNsU2piN2VXcGwycHduMjh6?=
 =?utf-8?B?eldBR3YzU1dqOEx6VGNTWEVRVDR1ZUxvVEZ0VXZPM0ZDK1FmYlJhMUhCZWFm?=
 =?utf-8?B?QTloa0xyeWNyK2M1S0lUNElVTWlQK2diOThzMHBCQlR1QzNCZEtxZHN3RFM4?=
 =?utf-8?Q?sTnt6fw241pceugT1ToJ803JnzP5WAxTvsdvonL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d701b48-509d-4a19-27cb-08d941243867
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:50:07.2868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaPFkseDowHnRNMzltKQh6q/8H4hSh52a4Lh68Dk41E7JcmuRxopYYb+79pcWotk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: Alexander.Deucher@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/7/2021 7:26 AM, Evan Quan wrote:
> The relationship "PWM = RPM / smu->fan_max_rpm" between fan speed
> PWM and RPM is not true for SMU11 ASICs. So, we need a new way to
> perform the fan speed RPM setting.
> 
> Change-Id: I1afe8102f02ead9a8a07c7105f689ac60a85b0d8
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +++
>   drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |  3 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 ++---
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  1 +
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  1 +
>   .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 36 +++++++++++++++++++
>   7 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 3e89852e4820..6301e4cb3c2a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1039,6 +1039,11 @@ struct pptable_funcs {
>   	 */
>   	int (*set_fan_speed_percent)(struct smu_context *smu, uint32_t speed);
>   
> +	/**
> +	 * @set_fan_speed_rpm: Set a static fan speed in rpm.
> +	 */
> +	int (*set_fan_speed_rpm)(struct smu_context *smu, uint32_t speed);
> +
>   	/**
>   	 * @set_xgmi_pstate: Set inter-chip global memory interconnect pstate.
>   	 * &pstate: Pstate to set. D0 if Nonzero, D3 otherwise.
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index b89e7dca8906..134a33e3de91 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -223,6 +223,9 @@ smu_v11_0_set_fan_control_mode(struct smu_context *smu,
>   int smu_v11_0_set_fan_speed_percent(struct smu_context *smu,
>   				    uint32_t speed);
>   
> +int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t speed);
> +
>   int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>   				     uint32_t pstate);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ebe672142808..576e9ea68fd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2174,11 +2174,12 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->set_fan_speed_percent) {
> -		percent = speed * 100 / smu->fan_max_rpm;
> -		ret = smu->ppt_funcs->set_fan_speed_percent(smu, percent);
> -		if (!ret && !(smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE))
> +	if (smu->ppt_funcs->set_fan_speed_rpm) {
> +		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
> +		if (!ret && smu->user_dpm_profile.flags & SMU_DPM_USER_PROFILE_RESTORE) {
> +			percent = speed * 100 / smu->fan_max_rpm;
>   			smu->user_dpm_profile.fan_speed_percent = percent;
> +		}
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 6b3e0ea10163..047adf6dd444 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2314,6 +2314,7 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
>   	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
>   	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
>   	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 59ea59acfb00..d8a011483dcf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3248,6 +3248,7 @@ static const struct pptable_funcs navi10_ppt_funcs = {
>   	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
>   	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
>   	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 83d8e53ca1f8..dad120294c19 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3886,6 +3886,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.get_fan_control_mode = smu_v11_0_get_fan_control_mode,
>   	.set_fan_control_mode = smu_v11_0_set_fan_control_mode,
>   	.set_fan_speed_percent = smu_v11_0_set_fan_speed_percent,
> +	.set_fan_speed_rpm = smu_v11_0_set_fan_speed_rpm,
>   	.set_xgmi_pstate = smu_v11_0_set_xgmi_pstate,
>   	.gfx_off_control = smu_v11_0_gfx_off_control,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 388c5cb5c647..fefc8e93fdc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1213,6 +1213,42 @@ smu_v11_0_set_fan_speed_percent(struct smu_context *smu, uint32_t speed)
>   	return smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC);
>   }
>   
> +int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
> +				uint32_t speed)
> +{
> +	struct amdgpu_device *adev = smu->adev;
> +	uint32_t tach_period, crystal_clock_freq;
> +	int ret;
> +
> +	ret = smu_v11_0_auto_fan_control(smu, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * crystal_clock_freq div by 4 is required since the fan control
> +	 * module refers to 25MHz
> +	 */
> +	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
> +

Just hardcode this as 25MHz, no need to relate it to ASIC clk.

Thanks,
Lijo

> +	/*
> +	 * To prevent from possible overheat, some ASICs may have requirement
> +	 * for minimum fan speed:
> +	 * - For some NV10 SKU, the fan speed cannot be set lower than
> +	 *   700 RPM.
> +	 * - For some Sienna Cichlid SKU, the fan speed cannot be set
> +	 *   lower than 500 RPM.
> +	 */
> +	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
> +	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
> +		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
> +				   CG_TACH_CTRL, TARGET_PERIOD,
> +				   tach_period));
> +
> +	ret = smu_v11_0_set_fan_static_mode(smu, FDO_PWM_MODE_STATIC_RPM);
> +
> +	return ret;
> +}
> +
>   int
>   smu_v11_0_set_fan_control_mode(struct smu_context *smu,
>   			       uint32_t mode)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
