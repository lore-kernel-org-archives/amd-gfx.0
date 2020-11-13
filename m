Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8EC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 08:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 573BC20B80
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 08:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AXWLTSUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573BC20B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E9DF6E027;
	Fri, 13 Nov 2020 08:37:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57216E027
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 08:37:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV0EOPrjcm64GmIOCyaNLjTfEGJsz5xgAycycswZ1pkI9TgOb0jTDixmwMS/7aJtq7Jvy3nivqjPv58Ub6HtRm/7T74mp3Iu0dTg8LlmgTS/JAnVt/EHwCPyma+oHv+Ua0+2FiEoERbAmJwoMpbMjW/iHliIIvSDiulSY1BdYjOwiE9GHNI2dJi8JOH7/DRiBWboAPB3UQfMct31iIoK5Yk+IUt1rJoAyz05BHAuOAWhG4Ai9ahw0DUFnkc9oir0Hxqj2C259rChefULvuQgrov7ssd3bvvWNumzsSHY1qZfJzPXIKuQ50/E9qyW6jswQ5ueYksJBgV/fJ/mGya6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39S5CV7LZA1LsxyVWhdSY6qkjOMeAOMegjR2T4pjWw0=;
 b=k1RneR3+di0AxCm5dXpTgtVd2+Pv72HL2Gw0st526xQ1pCGrDLxccYe7pFpAexE3bJQ5c5nmjZmxDAVEQsT+Xj6w0tTQQYxqiFAuyhADOulrfWCzmvq7MLmX2YwTqOtc0DtNKPRqQ4p6V8ukgaKU1gtkc0jNtu7dlo+8FvQ1eHjKDt0sD8tt65lOnK1H7d3ucAxLF219/XrbhSuTsLnVkRwl9qObQfigYz5HiaVBNkISAk2tCI//DIiFkQj5CKNHBpsVYHHmbHGER3bfrhz6Vw7Y6paLcCzWkzb77suOsgQxuZp+0N2Hktl49aBA1Y1PyOJ4F80u/azgyA4liJvcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39S5CV7LZA1LsxyVWhdSY6qkjOMeAOMegjR2T4pjWw0=;
 b=AXWLTSUstLeBkMj4sFAZrIJFMCWNjRBzGh0qaoVkgbByCAvwPV/5WpsAjJ6SyM5UoaKtEK2uh/CMpKC8YRIW5azuOTkEqp6OzW+/XxeX7ucKyhGB+gRUPAZ1zj3YH3S4285RyHPxbw8bfFg/+lcfnb7qY9nxq/G3EMOkCaqkWxU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1440.namprd12.prod.outlook.com (2603:10b6:300:13::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 08:37:45 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 08:37:45 +0000
Date: Fri, 13 Nov 2020 16:37:40 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>
Subject: Re: [PATCH 4/4] drm/amd/pm: add gfx_state_change_set() for rn gfx
 power switch
Message-ID: <20201113083740.GA1121780@hr-amd>
References: <1605250397-15043-1-git-send-email-Prike.Liang@amd.com>
 <1605250397-15043-4-git-send-email-Prike.Liang@amd.com>
Content-Disposition: inline
In-Reply-To: <1605250397-15043-4-git-send-email-Prike.Liang@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0151.apcprd02.prod.outlook.com (2603:1096:201:1f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 08:37:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 980bc34e-ce78-41c0-2ef5-08d887af6494
X-MS-TrafficTypeDiagnostic: MWHPR12MB1440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14404BB1B5A5B5FD94693563ECE60@MWHPR12MB1440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDi6sHHG7fLeWRhmeTcQkp+xc2RK/j0rAS+kBtUpZLMnLnjZGSBr1nnh19muV9EVX8WUuJmSTPnFY6VepkYtu7FvHt9J3ToChYf+YxLUs2AC8tGFMLr3e6GmHFvPPm/9tizxUYxq9f7FCnrRhQ33vOtHjkiQ+XV7Ob4rq02YYmLPDm9jAbDX1/DUGESNOCgJMkjJ93OPlZteVkRoel8qub63mIrLP/9SxlPtLrXIcx96TergwXxNaeYN/3ifpcag25q2zVCkMuaCQIgD5QKaRLq5GuA8aTCtuvtSBSU1bAUqLYTVDKyGt1YxnfXkTDlwygOK2gv9ddgILOVjNJoIeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(9686003)(5660300002)(6862004)(54906003)(186003)(16526019)(6496006)(86362001)(478600001)(83380400001)(316002)(26005)(33716001)(55016002)(4326008)(66476007)(6636002)(8676002)(2906002)(956004)(66946007)(1076003)(66556008)(52116002)(8936002)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: TrsognEf2P8BzjCgBj8CBH8fDhSMMqFqNQ5vTPMWaSRN4F9LpWQJFfOEJdNp7dOgoGEbYYUbxIe05cT+rSDWWXSBb0xs2ps/IuFBG5COdumTWyW0Uk2BQDwzsd/5Vm+CVfzVaJR690HS3CYgHbvJO1i4KaEPRmIFADzHp0XHbTs0+xkYufsraaJ8pcqgW/LysY29j+w5pQs2b8lmgNjT415gUEA6XSu8oao3NyD2VmEC0dLXlNFOC8gQGWgACZ2017zGHmJhHXWAfEGkq6Cx0v41pcA62gRU+jejeWURBYnDluygKnW3I9WztJNCTg3i9FwDvuqlRTvt0xCNvuOsfyZGwJPh/0vMEHOv+pxyNxYFytAKZe5quu2N7Zd96wWsqBUv2xmrNTdG2NLfIlbuFgqQdG59EjhVqFtsctfT2mDJUNM3a/ZsDI5D3Nl1z0u65z5aSpsLWs3ULcb/j14d2hAebm4pNC3Ho01C0gKoTUMyqLRk9774859OsmBta5wzR1HEeiKVfKAwP1DnYevi6IEeIL1vFzYJY3U6mrymKjYvUAbXkvtdKF6nH4w3KqQNpUXL9TZZceWQG7tdDDdpTLx8jrQVUGMMaHVVcqKxpsp0e317lwNYg+Ki4H7ilQ2PuuKAjEuOz+IiM/jEthKPl3MagVhxsWRn37s81FloFZ7opIPdleMa6v5KwPY49EJwbIGTWi05pzGySdu93OEBf0VUac4BOnjdccmyWNTNRmZLastrQ0uF3tYDlZ17+pJS1Ipobv5k8HzT5voXmAkkjb5BeCHOXRko4HLuW2bvgex+Qxis++1o4HCW8oFtSQunx0JnRBjl7gxDScQN0wCJB0mO4EMOUKJwKKtM2z+Kl1xCntdw/ZbsB6SSn6xysscJHZeiYWjkkn6VZIKUWOeToQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980bc34e-ce78-41c0-2ef5-08d887af6494
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 08:37:45.2393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ru2MAA3mNxdab7CqTozRZ2FpuDDvyCyhNJhb+FWoKzeHSKUEvkno9kakTbyS992YSzSo9iR96zaBTZbTe18Csg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1440
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Nov 13, 2020 at 02:53:17PM +0800, Liang, Prike wrote:
> The gfx_state_change_set() funtion can support set GFX power
> change status to D0/D3.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 18 +++++++++---------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h         |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c       | 12 ++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  7 +++++++
>  4 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 380dd3a..cd2c676 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -828,14 +828,14 @@ int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>  
>  void amdgpu_gfx_state_change_set(struct amdgpu_device *adev, enum gfx_change_state state)
>  {
> -
> -	mutex_lock(&adev->pm.mutex);
> -
> -	if (adev->powerplay.pp_funcs &&
> -	    adev->powerplay.pp_funcs->gfx_state_change_set)
> +	if (is_support_sw_smu(adev)) {
> +		smu_gfx_state_change_set(&adev->smu, state);
> +	} else {
> +		mutex_lock(&adev->pm.mutex);
> +		if (adev->powerplay.pp_funcs &&
> +		    adev->powerplay.pp_funcs->gfx_state_change_set)
>  			((adev)->powerplay.pp_funcs->gfx_state_change_set(
> -					(adev)->powerplay.pp_handle, state));
> -
> -	mutex_unlock(&adev->pm.mutex);
> -
> +				(adev)->powerplay.pp_handle, state));
> +		mutex_unlock(&adev->pm.mutex);
> +	}
>  }
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 9724d6f..ae8ff7b 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -576,6 +576,7 @@ struct pptable_funcs {
>  	int (*post_init)(struct smu_context *smu);
>  	void (*interrupt_work)(struct smu_context *smu);
>  	int (*gpo_control)(struct smu_context *smu, bool enablement);
> +	int (*gfx_state_change_set)(struct smu_context *smu, uint32_t state);
>  };
>  
>  typedef enum {
> @@ -764,6 +765,7 @@ int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
>  ssize_t smu_sys_get_gpu_metrics(struct smu_context *smu, void **table);
>  
>  int smu_enable_mgpu_fan_boost(struct smu_context *smu);
> +int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state);
>  
>  #endif
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 3999079..7b698c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2529,3 +2529,15 @@ int smu_enable_mgpu_fan_boost(struct smu_context *smu)
>  
>  	return ret;
>  }
> +
> +int smu_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&smu->mutex);
> +	if (smu->ppt_funcs->gfx_state_change_set)
> +		ret = smu->ppt_funcs->gfx_state_change_set(smu, state);
> +	mutex_unlock(&smu->mutex);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 66c1026..46c44f0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1136,6 +1136,12 @@ static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
>  	return sizeof(struct gpu_metrics_v2_0);
>  }
>  
> +static int renoir_gfx_state_change_set(struct smu_context *smu, uint32_t state)
> +{
> +
> +	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GpuChangeState, state, NULL);
> +}
> +
>  static const struct pptable_funcs renoir_ppt_funcs = {
>  	.set_power_state = NULL,
>  	.print_clk_levels = renoir_print_clk_levels,
> @@ -1171,6 +1177,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
>  	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>  	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>  	.get_gpu_metrics = renoir_get_gpu_metrics,
> +	.gfx_state_change_set = renoir_gfx_state_change_set,
>  };
>  
>  void renoir_set_ppt_funcs(struct smu_context *smu)
> -- 
> 2.7.4
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
