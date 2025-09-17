Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926EDCAC5A0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12B8010E88F;
	Wed, 17 Sep 2025 14:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="H6ef2BQo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5FD10E888
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cCNRHuT/6Zbdjo7ZLYmryTB8Ec7b3k1AiEQLTYoZa80=; b=H6ef2BQolQiBXbvkol7MwdNDeG
 mI1HC3d9AqHInL78FXGSNQKdOCDcKnGtdLEA1s98uelxPbM0VzEnMs8+9DecbPCNUDPyNGhIoMvCk
 5KL8LXa6T8Y7llinWwmw2VocbMiofI5sdMg/xuOWRkKBsjepuya/1I8dzCpKQ4XnITjLRqSeBHFqY
 iE6vh/OMYnOEl7LWG3F3TBtB5a6UwZjlgM8R8dSswduPZXWR78AZMDkZ6SKtgcx9jXtmiyLxAiawf
 DaIKkDg0AvNXfeNxUFwXOJlGm7UYh/WSxF9LwkZtY/F4DPqI+cXuooYqBm2pacWryJhUUEs6o30zO
 XvZimRxw==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uytYi-00Ckfg-La; Wed, 17 Sep 2025 16:55:00 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 6/6] drm/amd/pm: Use common helper for parsing sysfs writes
Date: Wed, 17 Sep 2025 15:54:49 +0100
Message-ID: <20250917145450.3000-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
References: <20250917145450.3000-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the previously added common helper for parsing sysfs writes into
arrays of longs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 236 ++++++++++-------------------
 1 file changed, 83 insertions(+), 153 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4503220c09aa..9154c75fd95a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -751,16 +751,14 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	int ret;
-	uint32_t parameter_size = 0;
-	long parameter[64];
-	char buf_cpy[128];
-	char *tmp_str;
-	char *sub_str;
-	const char delimiter[3] = {' ', '\n', '\0'};
+	unsigned int num_args;
+	char copy[128];
+	long args[64];
 	uint32_t type;
+	char *tmp;
+	int ret;
 
-	if (count > 127 || count == 0)
+	if (count >= sizeof(copy) || count == 0)
 		return -EINVAL;
 
 	if (*buf == 's')
@@ -780,60 +778,47 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	else
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count);
-	buf_cpy[count] = 0;
-
-	tmp_str = buf_cpy;
+	memcpy(copy, buf, count);
+	copy[count] = 0;
 
+	/* Skip command characters. */
+	tmp = &copy[1];
 	if ((type == PP_OD_EDIT_VDDC_CURVE) ||
 	     (type == PP_OD_EDIT_VDDGFX_OFFSET))
-		tmp_str++;
-	while (isspace(*++tmp_str));
+		tmp++;
 
-	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
-		if (strlen(sub_str) == 0)
-			continue;
-		ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
-		if (ret)
-			return -EINVAL;
-		parameter_size++;
-
-		if (!tmp_str)
-			break;
-
-		while (isspace(*tmp_str))
-			tmp_str++;
-	}
+	ret = amdgpu_parse_buffer_l(tmp, 0, " \n", args, ARRAY_SIZE(args));
+	if (ret < 0)
+		return ret;
+	num_args = ret;
 
 	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
-	if (amdgpu_dpm_set_fine_grain_clk_vol(adev,
-					      type,
-					      parameter,
-					      parameter_size))
-		goto err_out;
+	if (amdgpu_dpm_set_fine_grain_clk_vol(adev, type, args, num_args)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
-	if (amdgpu_dpm_odn_edit_dpm_table(adev, type,
-					  parameter, parameter_size))
-		goto err_out;
+	if (amdgpu_dpm_odn_edit_dpm_table(adev, type, args, num_args)) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (type == PP_OD_COMMIT_DPM_TABLE) {
 		if (amdgpu_dpm_dispatch_task(adev,
 					     AMD_PP_TASK_READJUST_POWER_STATE,
-					     NULL))
-			goto err_out;
+					     NULL)) {
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
+out:
 	amdgpu_pm_put_access(adev);
 
-	return count;
-
-err_out:
-	amdgpu_pm_put_access(adev);
-
-	return -EINVAL;
+	return ret ?: count;
 }
 
 static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
@@ -1367,17 +1352,14 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	int ret;
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	uint32_t parameter_size = 0;
-	long parameter[64];
-	char *sub_str, buf_cpy[128];
-	char *tmp_str;
-	uint32_t i = 0;
-	char tmp[2];
+	unsigned int num_args;
 	long int profile_mode;
-	const char delimiter[3] = {' ', '\n', '\0'};
+	char copy[128];
+	long args[64];
+	char tmp[2];
+	int ret;
 
 	tmp[0] = *(buf);
 	tmp[1] = '\0';
@@ -1386,39 +1368,29 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		return -EINVAL;
 
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (count < 2 || count > 127)
+		if (count < 2 || count >= sizeof(copy))
 			return -EINVAL;
-		while (isspace(*++buf))
-			i++;
-		memcpy(buf_cpy, buf, count-i);
-		tmp_str = buf_cpy;
-		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
-			if (strlen(sub_str) == 0)
-				continue;
-			ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
-			if (ret)
-				return -EINVAL;
-			parameter_size++;
-			if (!tmp_str)
-				break;
-			while (isspace(*tmp_str))
-				tmp_str++;
-		}
+
+		memcpy(copy, &buf[1], count - 1);
+
+		ret = amdgpu_parse_buffer_l(copy, 0, " \n",
+					    args, ARRAY_SIZE(args));
+		if (ret < 0)
+			return ret;
+
+		num_args = ret;
 	}
-	parameter[parameter_size] = profile_mode;
+	args[num_args] = profile_mode;
 
 	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
 		return ret;
 
-	ret = amdgpu_dpm_set_power_profile_mode(adev, parameter, parameter_size);
+	ret = amdgpu_dpm_set_power_profile_mode(adev, args, num_args);
 
 	amdgpu_pm_put_access(adev);
 
-	if (!ret)
-		return count;
-
-	return -EINVAL;
+	return ret ?: count;
 }
 
 static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
@@ -2277,32 +2249,18 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct amdgpu_pm_policy_attr *policy_attr;
-	int ret, num_params = 0;
-	char delimiter[] = " \n\t";
-	char tmp_buf[128];
-	char *tmp, *param;
+	char copy[128];
 	long val;
+	int ret;
 
-	count = min(count, sizeof(tmp_buf));
-	memcpy(tmp_buf, buf, count);
-	tmp_buf[count - 1] = '\0';
-	tmp = tmp_buf;
+	count = min(count, sizeof(copy));
+	memcpy(copy, buf, count);
+	copy[count - 1] = '\0';
 
-	tmp = skip_spaces(tmp);
-	while ((param = strsep(&tmp, delimiter))) {
-		if (!strlen(param)) {
-			tmp = skip_spaces(tmp);
-			continue;
-		}
-		ret = kstrtol(param, 0, &val);
-		if (ret)
-			return -EINVAL;
-		num_params++;
-		if (num_params > 1)
-			return -EINVAL;
-	}
-
-	if (num_params != 1)
+	ret = amdgpu_parse_buffer_l(copy, 0, " \t\n", &val, 1);
+	if (ret < 0)
+		return ret;
+	else if (ret != 1)
 		return -EINVAL;
 
 	policy_attr =
@@ -2316,10 +2274,7 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 
 	amdgpu_pm_put_access(adev);
 
-	if (ret)
-		return ret;
-
-	return count;
+	return ret ?: count;
 }
 
 #define AMDGPU_PM_POLICY_ATTR(_name, _id)                                  \
@@ -3728,58 +3683,43 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	return size;
 }
 
-static int parse_input_od_command_lines(const char *buf,
-					size_t count,
+static int parse_input_od_command_lines(const char *buf, size_t count,
 					u32 *type,
-					long *params,
-					uint32_t *num_of_params)
+					long *args, unsigned int *num_args)
 {
-	const char delimiter[3] = {' ', '\n', '\0'};
-	uint32_t parameter_size = 0;
-	char buf_cpy[128] = {0};
-	char *tmp_str, *sub_str;
+	const unsigned int max_args = *num_args;
+	char copy[128], *p = copy;
 	int ret;
 
-	if (count > sizeof(buf_cpy) - 1)
+	if (count > sizeof(copy) - 1)
 		return -EINVAL;
 
-	memcpy(buf_cpy, buf, count);
-	tmp_str = buf_cpy;
+	*num_args = 0;
+
+	memcpy(copy, buf, count);
 
 	/* skip heading spaces */
-	while (isspace(*tmp_str))
-		tmp_str++;
+	while (isspace(*p))
+		p++;
 
-	switch (*tmp_str) {
+	switch (*p) {
 	case 'c':
 		*type = PP_OD_COMMIT_DPM_TABLE;
 		return 0;
 	case 'r':
-		params[parameter_size] = *type;
-		*num_of_params = 1;
+		args[0] = *type;
+		*num_args = 1;
 		*type = PP_OD_RESTORE_DEFAULT_TABLE;
 		return 0;
 	default:
 		break;
 	}
 
-	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
-		if (strlen(sub_str) == 0)
-			continue;
+	ret = amdgpu_parse_buffer_l(p, 0, " \n", args, max_args);
+	if (ret < 0)
+		return ret;
 
-		ret = kstrtol(sub_str, 0, &params[parameter_size]);
-		if (ret)
-			return -EINVAL;
-		parameter_size++;
-
-		if (!tmp_str)
-			break;
-
-		while (isspace(*tmp_str))
-			tmp_str++;
-	}
-
-	*num_of_params = parameter_size;
+	*num_args = ret;
 
 	return 0;
 }
@@ -3790,15 +3730,12 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 				     const char *in_buf,
 				     size_t count)
 {
-	uint32_t parameter_size = 0;
-	long parameter[64];
+	long args[64];
+	unsigned int max_args = ARRAY_SIZE(args);
 	int ret;
 
-	ret = parse_input_od_command_lines(in_buf,
-					   count,
-					   &cmd_type,
-					   parameter,
-					   &parameter_size);
+	ret = parse_input_od_command_lines(in_buf, count, &cmd_type, args,
+					   &max_args);
 	if (ret)
 		return ret;
 
@@ -3806,29 +3743,22 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	if (ret < 0)
 		return ret;
 
-	ret = amdgpu_dpm_odn_edit_dpm_table(adev,
-					    cmd_type,
-					    parameter,
-					    parameter_size);
+	ret = amdgpu_dpm_odn_edit_dpm_table(adev, cmd_type, args, max_args);
 	if (ret)
-		goto err_out;
+		goto out;
 
 	if (cmd_type == PP_OD_COMMIT_DPM_TABLE) {
 		ret = amdgpu_dpm_dispatch_task(adev,
 					       AMD_PP_TASK_READJUST_POWER_STATE,
 					       NULL);
 		if (ret)
-			goto err_out;
+			goto out;
 	}
 
+out:
 	amdgpu_pm_put_access(adev);
 
-	return count;
-
-err_out:
-	amdgpu_pm_put_access(adev);
-
-	return ret;
+	return ret ?: count;
 }
 
 /**
-- 
2.48.0

