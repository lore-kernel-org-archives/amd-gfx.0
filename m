Return-Path: <SRS0=trOe=7I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1B5C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 18:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E199206F1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2020 18:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mXLS3HRh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E199206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BCE8905A;
	Tue, 26 May 2020 18:37:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F8C8951B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2020 18:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frW7Z0ig6c+mTf1Rj3/AHboEFxHr4hrHQrO1RGY+ovz1Si4VAUaO2rf3eVbhInGkznJ8D1x/HQYZkTigpf4WYfXultZngbo84qdzipkZmnE3krtoGPMqgSUIba9iAvbNa+OBzqfszxiqasHlTQxrmqWb5nTH4thzOO6SCC4gq5uLhA7Ax5XA3GDFms0ZMlWOZGQV1JNZ8EN/2HlPfd+vUDk0kmutNhXT7RJqjmHzovjLmmqyxugNNjShw1x3G/2iI0qQdLSYbwDiEcsNaA1g/UBbYjuw/dUW+8eZBTiv6qNRM2hpItuIZ1Wc6YXL4Tw80vRZP5cmbEVp+JGSl5ekTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXnoSYiqfjtBwGz8b238q6NSu2+Xq/qalNml2Cx3O8g=;
 b=cw2v9qKExEYd5Xjvyjz/OBFjNUyplNHa0Psyn6ofS8ju6PDmHfR+5Ha7QkRo6Nraj6FDQOFQISry6Y7CNMXL9OJgYlO6p8nPV8d+xTW2XGoGbTZYzJRgQ+Vv3rEEZnY1LP4ONkXJfTab+lq8BI4HWI7g8NzbBAQU8CdOI3Rn4jOEP3M4JRf6v3c+NOXECRq/d0ApEpm9MgK7EwcVdmAZ6cVmZVBm55nP0fKZ4ndUut1Ikwv+7iQhRsniaQnB/OC6+nz3CNdSWBC5TJe0nc9XYUcIfArhd9a7Zj5f4eqH//k8CQBXOiZTcw8a/SnZBQwCzhRxLmRdh/JKcNzaHqOmCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXnoSYiqfjtBwGz8b238q6NSu2+Xq/qalNml2Cx3O8g=;
 b=mXLS3HRhmeehzxHSWzHyZDsmwAjh6UxAGKntfJ3+byuMWpQzZnB5SPKHiAGkbjc4pNBVwwB9RrBUs5xfdvB/mgaX7Qu+T0zK6GQms+X39FfEIJjkKmqdc/IiMyPyXrIrpuOWIAM7R4BqysjbOvdxFGaPdaDSBIhbtDcxFRvqDrs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3085.namprd12.prod.outlook.com (2603:10b6:208:c5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 18:37:51 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3045.016; Tue, 26 May 2020
 18:37:51 +0000
Subject: Re: [PATCH] drm/amdgpu/pm: return an error during GPU reset or suspend
To: amd-gfx@lists.freedesktop.org
References: <20200526175637.853730-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f717b9bd-284f-8f85-62ec-491e6d7073ea@amd.com>
Date: Tue, 26 May 2020 20:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200526175637.853730-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0109.eurprd05.prod.outlook.com
 (2603:10a6:207:2::11) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (2003:c5:8f3a:ed00:c6c4:febd:9c19:b346) by
 AM3PR05CA0109.eurprd05.prod.outlook.com (2603:10a6:207:2::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27 via Frontend Transport; Tue, 26 May 2020 18:37:50 +0000
X-Originating-IP: [2003:c5:8f3a:ed00:c6c4:febd:9c19:b346]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9d9b6a59-e232-405a-78ac-08d801a3e52b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3085:
X-Microsoft-Antispam-PRVS: <MN2PR12MB30851EBD9F4321677523536D8BB00@MN2PR12MB3085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFgAFfDYXn98RV6XB6x0nagMTdIgs4ygOrfw1roqzbSKLltdW0sWZZ9Fx+u73I06bW/6wlYAH++FE8TLX73ZX+7Vbf8LMFD+qXgrJSE7Pd5pCgSV3KVLsQnL+5Ru5oa2B+dlNlOf81tes2z6T40s8t9phQVeNiH51fS6KpJlVSwDr6VVSzVl9bbQ4mjok+wEJRHBtZVdhlAJrQRMh3W9SataEPpyk39X8kze9Pe80q/6gXEhg6HXVJyinsMlKj+52B+K3pViDuhRTSuMfwm5dLNHv/cFKC0+2REDiC5oaHKM76aAIHf1kZBK7SYNrItm0M5HbFg8YHN5swGAnZgnPuMWFaSpp+sYyfrIdmpm4H6Tjo5rseQ9cpinOpQzojYx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(30864003)(6666004)(31686004)(36756003)(6486002)(6916009)(6512007)(316002)(31696002)(5660300002)(15650500001)(478600001)(2906002)(66556008)(66476007)(66946007)(8936002)(2616005)(8676002)(53546011)(52116002)(16526019)(186003)(6506007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PwCets/pn/0ly4vhbfTtiphqCQDiU4hSJ3ZE4vxgji7tIqJpsC/rSI6gzWFg/9qT7q2Er1UhBM0vHir+5Y9YhvMRvFg56I06BiJ+/7xaukyXkNTu0Cq3Ea1Tq0GlkMgLKFZHHLn6PZyorPJKJPDNfANcqmcxa47btjn8WCFNgrotWicN0EGYf7yuiqT/tTghMJOl5k0xIbbZHD6tSVIAkdqej08x0Nm0KGRbKamhzXYVKekPobROX2GIbg9B3UsG6+fcM5tyzkyxnTXofgwAMbwCmV0A6ai6EhyODYqbBehPjl3FxNyVMMDL1tdcxTaBdkKZr3kn7q2qZlbnKpNldS66qPojnNL95WX5wjh56uNN+j2mwZqRLxcaA5IcEsdDBrDYIcSjr28EMX3Dx2l0vEVMdRdocMq6IVplrz9y12CPtqL9lI2GnB6dWLg88wpGNhC+VSXuAhjKQu7CKCYf1h0UbXSOoh//lnx43S89Nbb8FWujwvPM8Bg1d13kqoAKPjGx9f7SHs/E843UbT0vBv7nEbvMPjZPuAy3UGIKXMM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9b6a59-e232-405a-78ac-08d801a3e52b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 18:37:51.0342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT0cGyYqZqtq8DD9/Wxt/JVoXCtGzBnPRWCchOrZTlzbyhufCPn1u7mkQuX8ni+bKLuAAtw07TKS1IOyfMpKQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3085
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

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 5/26/20 7:56 PM, Alex Deucher wrote:
> Return an error for sysfs and debugfs power interfaces during
> gpu reset and suspend.  Prevents access to the hw while it may
> be in an unusable state.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 171 +++++++++++++++++++++++++
>   1 file changed, 171 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 702a3a03c707..255e21d46921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -163,6 +163,9 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   	enum amd_pm_state_type pm;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -196,6 +199,9 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   	enum amd_pm_state_type  state;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (strncmp("battery", buf, strlen("battery")) == 0)
>   		state = POWER_STATE_TYPE_BATTERY;
>   	else if (strncmp("balanced", buf, strlen("balanced")) == 0)
> @@ -297,6 +303,9 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>   	enum amd_dpm_forced_level level = 0xff;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -334,6 +343,9 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   	enum amd_dpm_forced_level current_level = 0xff;
>   	int ret = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (strncmp("low", buf, strlen("low")) == 0) {
>   		level = AMD_DPM_FORCED_LEVEL_LOW;
>   	} else if (strncmp("high", buf, strlen("high")) == 0) {
> @@ -433,6 +445,9 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>   	struct pp_states_info data;
>   	int i, buf_len, ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -472,6 +487,9 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   	enum amd_pm_state_type pm = 0;
>   	int i = 0, ret = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -508,6 +526,9 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = ddev->dev_private;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (adev->pp_force_state_enabled)
>   		return amdgpu_get_pp_cur_state(dev, attr, buf);
>   	else
> @@ -525,6 +546,9 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   	unsigned long idx;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (strlen(buf) == 1)
>   		adev->pp_force_state_enabled = false;
>   	else if (is_support_sw_smu(adev))
> @@ -580,6 +604,9 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>   	char *table = NULL;
>   	int size, ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -619,6 +646,9 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>   	struct amdgpu_device *adev = ddev->dev_private;
>   	int ret = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -721,6 +751,9 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   	const char delimiter[3] = {' ', '\n', '\0'};
>   	uint32_t type;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (count > 127)
>   		return -EINVAL;
>   
> @@ -810,6 +843,9 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -859,6 +895,9 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>   	uint64_t featuremask;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = kstrtou64(buf, 0, &featuremask);
>   	if (ret)
>   		return -EINVAL;
> @@ -899,6 +938,9 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -955,6 +997,9 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1018,6 +1063,9 @@ static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1049,6 +1097,9 @@ static ssize_t amdgpu_get_pp_dpm_mclk(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1076,6 +1127,9 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct device *dev,
>   	uint32_t mask = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1107,6 +1161,9 @@ static ssize_t amdgpu_get_pp_dpm_socclk(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1134,6 +1191,9 @@ static ssize_t amdgpu_set_pp_dpm_socclk(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1167,6 +1227,9 @@ static ssize_t amdgpu_get_pp_dpm_fclk(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1194,6 +1257,9 @@ static ssize_t amdgpu_set_pp_dpm_fclk(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1227,6 +1293,9 @@ static ssize_t amdgpu_get_pp_dpm_dcefclk(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1254,6 +1323,9 @@ static ssize_t amdgpu_set_pp_dpm_dcefclk(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1287,6 +1359,9 @@ static ssize_t amdgpu_get_pp_dpm_pcie(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1314,6 +1389,9 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct device *dev,
>   	int ret;
>   	uint32_t mask = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = amdgpu_read_mask(buf, count, &mask);
>   	if (ret)
>   		return ret;
> @@ -1347,6 +1425,9 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>   	uint32_t value = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1372,6 +1453,9 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   	int ret;
>   	long int value;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
> @@ -1410,6 +1494,9 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>   	uint32_t value = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1435,6 +1522,9 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   	int ret;
>   	long int value;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = kstrtol(buf, 0, &value);
>   
>   	if (ret)
> @@ -1493,6 +1583,9 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>   	ssize_t size;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -1528,6 +1621,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   	long int profile_mode = 0;
>   	const char delimiter[3] = {' ', '\n', '\0'};
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	tmp[0] = *(buf);
>   	tmp[1] = '\0';
>   	ret = kstrtol(tmp, 0, &profile_mode);
> @@ -1587,6 +1683,9 @@ static ssize_t amdgpu_get_gpu_busy_percent(struct device *dev,
>   	struct amdgpu_device *adev = ddev->dev_private;
>   	int r, value, size = sizeof(value);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -1620,6 +1719,9 @@ static ssize_t amdgpu_get_mem_busy_percent(struct device *dev,
>   	struct amdgpu_device *adev = ddev->dev_private;
>   	int r, value, size = sizeof(value);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -1658,6 +1760,9 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>   	uint64_t count0 = 0, count1 = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (adev->flags & AMD_IS_APU)
>   		return -ENODATA;
>   
> @@ -1694,6 +1799,9 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>   	struct drm_device *ddev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = ddev->dev_private;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (adev->unique_id)
>   		return snprintf(buf, PAGE_SIZE, "%016llx\n", adev->unique_id);
>   
> @@ -1876,6 +1984,9 @@ static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
>   	int channel = to_sensor_dev_attr(attr)->index;
>   	int r, temp = 0, size = sizeof(temp);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (channel >= PP_TEMP_MAX)
>   		return -EINVAL;
>   
> @@ -2007,6 +2118,9 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>   	u32 pwm_mode = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(adev->ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -2038,6 +2152,9 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>   	int err, ret;
>   	int value;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = kstrtoint(buf, 10, &value);
>   	if (err)
>   		return err;
> @@ -2087,6 +2204,9 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>   	u32 value;
>   	u32 pwm_mode;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = pm_runtime_get_sync(adev->ddev->dev);
>   	if (err < 0)
>   		return err;
> @@ -2136,6 +2256,9 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>   	int err;
>   	u32 speed = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = pm_runtime_get_sync(adev->ddev->dev);
>   	if (err < 0)
>   		return err;
> @@ -2166,6 +2289,9 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>   	int err;
>   	u32 speed = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = pm_runtime_get_sync(adev->ddev->dev);
>   	if (err < 0)
>   		return err;
> @@ -2195,6 +2321,9 @@ static ssize_t amdgpu_hwmon_get_fan1_min(struct device *dev,
>   	u32 size = sizeof(min_rpm);
>   	int r;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2220,6 +2349,9 @@ static ssize_t amdgpu_hwmon_get_fan1_max(struct device *dev,
>   	u32 size = sizeof(max_rpm);
>   	int r;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2244,6 +2376,9 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>   	int err;
>   	u32 rpm = 0;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = pm_runtime_get_sync(adev->ddev->dev);
>   	if (err < 0)
>   		return err;
> @@ -2273,6 +2408,9 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>   	u32 value;
>   	u32 pwm_mode;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = pm_runtime_get_sync(adev->ddev->dev);
>   	if (err < 0)
>   		return err;
> @@ -2319,6 +2457,9 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>   	u32 pwm_mode = 0;
>   	int ret;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	ret = pm_runtime_get_sync(adev->ddev->dev);
>   	if (ret < 0)
>   		return ret;
> @@ -2351,6 +2492,9 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>   	int value;
>   	u32 pwm_mode;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	err = kstrtoint(buf, 10, &value);
>   	if (err)
>   		return err;
> @@ -2391,6 +2535,9 @@ static ssize_t amdgpu_hwmon_show_vddgfx(struct device *dev,
>   	u32 vddgfx;
>   	int r, size = sizeof(vddgfx);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2423,6 +2570,9 @@ static ssize_t amdgpu_hwmon_show_vddnb(struct device *dev,
>   	u32 vddnb;
>   	int r, size = sizeof(vddnb);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	/* only APUs have vddnb */
>   	if  (!(adev->flags & AMD_IS_APU))
>   		return -EINVAL;
> @@ -2460,6 +2610,9 @@ static ssize_t amdgpu_hwmon_show_power_avg(struct device *dev,
>   	int r, size = sizeof(u32);
>   	unsigned uw;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2496,6 +2649,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>   	ssize_t size;
>   	int r;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2525,6 +2681,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>   	ssize_t size;
>   	int r;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2555,6 +2714,9 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>   	int err;
>   	u32 value;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		return -EINVAL;
>   
> @@ -2593,6 +2755,9 @@ static ssize_t amdgpu_hwmon_show_sclk(struct device *dev,
>   	uint32_t sclk;
>   	int r, size = sizeof(sclk);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -2625,6 +2790,9 @@ static ssize_t amdgpu_hwmon_show_mclk(struct device *dev,
>   	uint32_t mclk;
>   	int r, size = sizeof(mclk);
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(adev->ddev->dev);
>   	if (r < 0)
>   		return r;
> @@ -3484,6 +3652,9 @@ static int amdgpu_debugfs_pm_info(struct seq_file *m, void *data)
>   	u32 flags = 0;
>   	int r;
>   
> +	if (adev->in_gpu_reset || adev->in_suspend)
> +		return -EPERM;
> +
>   	r = pm_runtime_get_sync(dev->dev);
>   	if (r < 0)
>   		return r;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
