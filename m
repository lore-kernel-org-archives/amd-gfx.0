Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4BAC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 11:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B14E112051;
	Mon,  4 Mar 2024 11:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fa1IR9wg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF96C112053
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 11:50:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7uhE/cclIbj1XwKNgupKTCgvqfEdi0kG7sF1aR7QaANt68lmp9W42Qxv6VN3z1I8XZhWwtX1LuYkkPfMbPKfTrv1xuV0bxKjwHgfvbNI1pzUHyKtWOYR3ItqoFB6CLLRblmnHsc9UYLxxE7UsPHGM74G5NkqQVLDyeUh7SJ9ezRtuADQ6kMCDwlZpj4gpmLY21IzLcvcS8ut4qZ/R+mQhyiFCGfVntlfz5QpQqzU3EtkIQsIrTXSMZDk9zEZ9qi2uQL4Rkl0C9xZZqGIY+sL8unBJh/2t13nSerBzWwzsFsG/++04WR3tI2OkFpf4xu8dAMgH7/m6hOMTiYmZyzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSlylYY6WZkuSIIPDLvPYBMGYhRvz/t5Vl2Gn88o2Po=;
 b=mWAmbKmeoN6d6TXA81FgHwBqltRcQYZGJnR4ChBSEv8+D5MfLnzvP1qgFFIhf0A5VRBq/bVJcu7I4OFYCZvkZ0THT1X3QreRjrfgnWdCIlVePqDyKCN8KhPe7hLKvBkRC/wqPhjoHO4mXVJI/D+y5Ws03DpxlFXIkG0BGg/B0LrTMQep942NBDB3jpSZGN9OpVpEuoxfweXBhaahdt1anGBd9o7uj2atjxIzFy/PhBm0ILGqbfVmbbFZ8vY2bP4JV6Mqfvzdcxq2oZ4L/5xmi3WtDs8K/9Av4MgZGI1akT+oOUXBpsuA/+B5r7K33OaMCbpDE9dmbQUm6yh9AYvR2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSlylYY6WZkuSIIPDLvPYBMGYhRvz/t5Vl2Gn88o2Po=;
 b=Fa1IR9wgFi08aHlb4HsmwGitYSfEFRD6oJHqMT7Z6wiAre+dT/VZlQ/ldenO7Y4QemUvjkcvNEcTF0VJAurlfKDMl1KJcrIgTG+Gh3DTYxUFnBZ+djylHKwMnZvCRaTfSv5KW9AYx9LlIHkkTpPFOI+KQjw9XhD+MXOQIunC6J4=
Received: from CYXPR02CA0077.namprd02.prod.outlook.com (2603:10b6:930:ce::25)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 11:50:05 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::33) by CYXPR02CA0077.outlook.office365.com
 (2603:10b6:930:ce::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 11:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 11:50:04 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 4 Mar
 2024 05:50:02 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yang Wang <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: disable pp_dpm_dcefclk node for gfx 11.0.3 sriov
Date: Mon, 4 Mar 2024 19:49:50 +0800
Message-ID: <20240304114950.1210057-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b94e39-acc5-4006-daad-08dc3c413b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/P/XhJneACM93TRYVpw8ECwZbt2NmWmzrEK42tv0glPgMzvDz+cMyC1vTp/AJefM27O9pdu8PixkJxHOS+qJdDvE9bXOnZTib2Srn0wpzaBzBLG5iPgPBGdqQQ6zhL8QPjk8AoO3YyUn18YfnENBVCplyXreVbS6EiDhRWRZJuLvTK1ectAHTYSUSlFMb+Y2OdSr5hxvYJZTlLFLbSngeKJNG/hHsTn/q1X3+Mm53PX536HzAMqE5Z3ZRWZ0bj+D+N44/br8dQPJfB+CaGvsT8xNFOmEt6aZYnqv/CfdENwmZfyfXt4NHnw4V3gzFyrjqQCozPDqWf95L56OnCJR+X4owoj8wPZ/VZC5aO7enZxp0dxfvMDkxDQeXgXYGY09oDJoL4PW6uBuh79WCOcb3JcCT3+oBvDy3CYbnOoNJ8fhxBNuzhQcAPqY0ciJUpXalhWY93JtiKKC1EQ7jiUD7UT6IYMeLFoRgOg4e5czMc5zr4HakrCSApf3vlKjjwHcQ1Nj1b6zouk3Vo/2csct7ORP0aJculMglTtjmQW9m2Qcfy4MTd9BEo88CEFgatoyzoFmGYYaoZ3Dg7uE6NWCtmmYsOGFHOpm5jcEAENJTM+3goIIZOhCLEY7rrnybl1L09L73+tqaCgcujB891tpEjdlWgIwBi9c8vD+tn0KeZGxOxOJ6IGtcXmr7UJJMzdBSCD3cfTidg9Zg2yctWnovRYrupUNoh/gHntnxuaSZyDP/BI877DuzEJL/rdWnYj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 11:50:04.3214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b94e39-acc5-4006-daad-08dc3c413b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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

the dce dpm is not available on gfx 11.0.3 sriov device.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 47 +++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 40df1db63ccd..f09b9d49297e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2059,6 +2059,38 @@ static int pp_od_clk_voltage_attr_update(struct amdgpu_device *adev, struct amdg
 	return 0;
 }
 
+static int pp_dpm_dcefclk_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
+				      uint32_t mask, enum amdgpu_device_attr_states *states)
+{
+	struct device_attribute *dev_attr = &attr->dev_attr;
+	uint32_t gc_ver;
+
+	*states = ATTR_STATE_SUPPORTED;
+
+	if (!(attr->flags & mask)) {
+		*states = ATTR_STATE_UNSUPPORTED;
+		return 0;
+	}
+
+	gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
+	/* dcefclk node is not available on gfx 11.0.3 sriov */
+	if ((gc_ver == IP_VERSION(11, 0, 3) && amdgpu_sriov_is_pp_one_vf(adev)) ||
+	    gc_ver < IP_VERSION(9, 0, 0) ||
+	    !amdgpu_device_has_display_hardware(adev))
+		*states = ATTR_STATE_UNSUPPORTED;
+
+	/* SMU MP1 does not support dcefclk level setting,
+	 * setting should not be allowed from VF if not in one VF mode.
+	 */
+	if (gc_ver >= IP_VERSION(10, 0, 0) ||
+	    (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))) {
+		dev_attr->attr.mode &= ~S_IWUGO;
+		dev_attr->store = NULL;
+	}
+
+	return 0;
+}
+
 /* Following items will be read out to indicate current plpd policy:
  *  - -1: none
  *  - 0: disallow
@@ -2138,7 +2170,8 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_vclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dclk1,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_dpm_dcefclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
+			      .attr_update = pp_dpm_dcefclk_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_pcie,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_sclk_od,				ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_mclk_od,				ATTR_FLAG_BASIC),
@@ -2182,10 +2215,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
 		if (gc_ver < IP_VERSION(9, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
-	} else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		if (gc_ver < IP_VERSION(9, 0, 0) ||
-		    !amdgpu_device_has_display_hardware(adev))
-			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
 		if (mp1_ver < IP_VERSION(10, 0, 0))
 			*states = ATTR_STATE_UNSUPPORTED;
@@ -2303,14 +2332,6 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		break;
 	}
 
-	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-		/* SMU MP1 does not support dcefclk level setting */
-		if (gc_ver >= IP_VERSION(10, 0, 0)) {
-			dev_attr->attr.mode &= ~S_IWUGO;
-			dev_attr->store = NULL;
-		}
-	}
-
 	/* setting should not be allowed from VF if not in one VF mode */
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
 		dev_attr->attr.mode &= ~S_IWUGO;
-- 
2.34.1

