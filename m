Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00C7CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9503E10FBE6;
	Fri, 29 May 2026 09:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlYt4yau";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3939710FBE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:38:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dATgYfaUCVtxCF8VcrzoKBES1Ze2oiBJy8fXIpykyIw7n/7kaeRn1PQJyudWcsDv45EhJ3VesQ+uagEJLAvRVSfkiU2bEh8MQYozeMcJePOO/raw3KJT4wxG+jq+/RdlaR5PTzcXFTzs8lhg4RGu1tVcjK8LzJ1DbgKeS9YvNhysg+C+Mk6dIf2d47uHf/rERZ1pmSgkE4xk0yFQK+PeF+GcjY0B1jnHuNeDB9+hbtOPPuyu1WLIiJP65skAbihiJOSkMefw0LgVQa0Orz63inZtG0bgTqgUYG40r2jRt7zViJ381jKPLWHomLhlfv5CJGxvRyuihba+BNjOzYIkng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGWkUAjTMmuQCqb4m8terTiS8FFt4ELP/B8zEZaDxqU=;
 b=xD2aQQIZvVcRuLCJLbr/tCOEt1tq/4UaIXZsWptl8WdbCybvHA2ghkPWay4cKDR1/1qeDkHyz+Hr0AmkowvD79W15tr4L8gnG4Kbmavdc7T0A0Kfay9FCZosQkzf15hfAtzegnwBiP83bORCVJGhC5WGOoEeLtIVW2kA+VG73bPi7jsZS/+tazzGiO2ZqW/oNiDn+QL6ec8pvf4/NpqeAsm/m+2H9mgshH3gm86xgSnydZaltNq0YXvgSbtAQe9MckwwnzyM/lty3Md4NyNk6+FWGjMpIJabTIplOi91dL6EQQVPHg6wd2r44LHAPYFpioPHpVX1lD5YrlFXTlM5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGWkUAjTMmuQCqb4m8terTiS8FFt4ELP/B8zEZaDxqU=;
 b=mlYt4yau5UkujZiyxcjY0wLIA1CuUxAiTRS90mtsRMdvf+wbLt0exz63YGNHfEKi0VecXmt9I5lx0+cnLcbS2UxDJd/sj7zTjTv9dLqndP+kmQgiGiNWvkYpjewRc5lahb5Z4qqhmYT9uSnSTfBeZKElsYX2RfPTbvX8ro/x9JI=
Received: from DS1P221CA0013.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:451::10) by
 CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 09:38:42 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:451:cafe::6b) by DS1P221CA0013.outlook.office365.com
 (2603:10b6:8:451::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:38:42 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:38:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Add helper for parameter parsing
Date: Fri, 29 May 2026 15:08:20 +0530
Message-ID: <20260529093820.1134317-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260529093820.1134317-1-lijo.lazar@amd.com>
References: <20260529093820.1134317-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: de6ce93d-a340-4329-a157-08debd661243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|3023799007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bOVMpyMVxmrvZy7s7xzK3la2yiugLswJARQa/MEjv0iKllpciqu+GwZmdsQWOxx4R1V7K6iHZ5qCiNAwefnizoNv6+pS5i0R6PALkOB2P1UaO+/u+J8z2cau3UHDZadN8GrBL8fgm/A51c7x0aXdUsfxI9l77gDubZ1V81Xnup0zUEmtNrglB1+YmNZrsDGjEoZqWmhIbpzqSDC8F+X1cKAhjkQHGp37G6GFmycvsnqHusHQVtKdJZ0ytnL5jbBht5eD4C9/umcFyOEBvh5jmbPTV2uTpTKJwezhfc+YX0F1gjPE0cZWR1S1vY2Qwh5jK53/q1GIezDpH56d9m78W9b66cy3XBmd0e2CHLtianCDh8UXRPhUWQThdP0KcQedPmZlHKEzN7l9uhK0iNtkOxXjCB0v6ARm6K/UPLMxuvsUhi7NvGCACSRbcJhRPylwQP5BBHjKxJVtf/gIQbvTy+GcDwndXVIUHS1tdYax7dSWGiZWZr+1M71CROhWYJqu65k9fcmDaNFwulIE+ZKmbfvDo7KqF+T6xPFt4T4pZrqQ21yMdSq0X7xNko8GPtYGHv1ug/Pm4e4GHqs4a2EtlJL+TYer511bOfJBMtV0ecN6inQU2DG09HjJZo4iWcXaYPr2HcnXLZR060q6fNAtHIJwnOhQiYcq/RrRwCe8Hwv/bdE7oFAl5TVUL87UPc9j/40YTcnV0aZxVpWEGTP4vJzHj8R6TqU0JYeAhFe0pv4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UHBln4LjOoIX/SwKuejdqaQdu8mJlaq9uzZiusI40fWghtso17qWwRL+UYQcV16s78j5yN1UDlAXak5c/kJTdXCo+0q1ZFnZhwnOdM0AJ5ATj7WNmP0CBjqxORLrFZiWNgjhhRRv5EHPe67XD+o2hlrQlsvXYwFE7DyX4Yar1ync7AA7xdg6wWa4kBqxddmMFGo3EsTxPygsE32I5vMEhqO1RDOXfIfMyQe9zZ6ka5mZtrNF0wiXZ7CIqcG2spNCyojdBskkJ6Jo0/NYWOxrr6KYqfo97pquMGUZJBtt3mFWmGoJ9e3rKSU+bP2GKnL/Yo5pmtE9dq14rjQTPcgq56RNt3ZWh6EGeXjIJj3V2gl5gHLu6DXya30c7/LQx9eV0saBtmTyUKdDIv90bS1kS3pYIWZ4+hJujZvnkgrH6Ze5EtmOVSwf86JUJjTrv789
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:38:42.3378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6ce93d-a340-4329-a157-08debd661243
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
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

Add a helper function to extract long values passed in a string. The
string may have values of multiple parameters separated by space char.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 116 ++++++++++++-----------------
 1 file changed, 48 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ebe0b320ca4f..040839dc6368 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -98,6 +98,37 @@ const char * const amdgpu_pp_profile_name[] = {
 	"UNCAPPED",
 };
 
+static int amdgpu_pm_parse_long_params(char *str, long *params,
+				       uint32_t max_params,
+				       uint32_t *num_params)
+{
+	const char delimiter[] = { ' ', '\n', '\0' };
+	uint32_t count = 0;
+	char *sub_str;
+	int ret;
+
+	if (!params || !num_params)
+		return -EINVAL;
+
+	while ((sub_str = strsep(&str, delimiter)) != NULL) {
+		if (strlen(sub_str) == 0)
+			continue;
+		if (count >= max_params)
+			return -EINVAL;
+		ret = kstrtol(sub_str, 0, &params[count]);
+		if (ret)
+			return -EINVAL;
+		count++;
+		if (!str)
+			break;
+		while (isspace(*str))
+			str++;
+	}
+	*num_params = count;
+
+	return 0;
+}
+
 /**
  * amdgpu_pm_dev_state_check - Check if device can be accessed.
  * @adev: Target device.
@@ -759,8 +790,6 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 	long parameter[64];
 	char buf_cpy[128];
 	char *tmp_str;
-	char *sub_str;
-	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t type;
 
 	if (count > 127 || count == 0)
@@ -795,22 +824,10 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		tmp_str++;
 	while (isspace(*++tmp_str));
 
-	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
-		if (strlen(sub_str) == 0)
-			continue;
-		if (parameter_size >= ARRAY_SIZE(parameter))
-			return -EINVAL;
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
+	ret = amdgpu_pm_parse_long_params(
+		tmp_str, parameter, ARRAY_SIZE(parameter), &parameter_size);
+	if (ret)
+		return ret;
 
 	ret = amdgpu_pm_get_access(adev);
 	if (ret < 0)
@@ -1373,11 +1390,9 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	uint32_t parameter_size = 0;
 	long parameter[64];
-	char *sub_str, buf_cpy[128];
-	char *tmp_str;
+	char buf_cpy[128];
 	char tmp[2];
 	long int profile_mode = 0;
-	const char delimiter[3] = {' ', '\n', '\0'};
 
 	tmp[0] = *(buf++);
 	tmp[1] = '\0';
@@ -1391,19 +1406,11 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 		while (isspace(*buf))
 			buf++;
 		strscpy(buf_cpy, buf, sizeof(buf_cpy));
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
+		ret = amdgpu_pm_parse_long_params(buf_cpy, parameter,
+						  ARRAY_SIZE(parameter) - 1,
+						  &parameter_size);
+		if (ret)
+			return ret;
 	}
 	parameter[parameter_size] = profile_mode;
 
@@ -3928,18 +3935,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 	return size;
 }
 
-static int parse_input_od_command_lines(const char *buf,
-					size_t count,
-					u32 *type,
-					long *params,
-					size_t params_max,
+static int parse_input_od_command_lines(const char *buf, size_t count,
+					u32 *type, long *params,
+					uint32_t max_params,
 					uint32_t *num_of_params)
 {
-	const char delimiter[3] = {' ', '\n', '\0'};
 	uint32_t parameter_size = 0;
 	char buf_cpy[128] = {0};
-	char *tmp_str, *sub_str;
-	int ret;
+	char *tmp_str;
 
 	if (count > sizeof(buf_cpy) - 1)
 		return -EINVAL;
@@ -3964,28 +3967,8 @@ static int parse_input_od_command_lines(const char *buf,
 		break;
 	}
 
-	while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
-		if (strlen(sub_str) == 0)
-			continue;
-
-		if (parameter_size >= params_max)
-			return -EINVAL;
-
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
-
-	return 0;
+	return amdgpu_pm_parse_long_params(tmp_str, params, max_params,
+					   num_of_params);
 }
 
 static int
@@ -3998,10 +3981,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
 	long parameter[64];
 	int ret;
 
-	ret = parse_input_od_command_lines(in_buf,
-					   count,
-					   &cmd_type,
-					   parameter,
+	ret = parse_input_od_command_lines(in_buf, count, &cmd_type, parameter,
 					   ARRAY_SIZE(parameter),
 					   &parameter_size);
 	if (ret)
-- 
2.49.0

