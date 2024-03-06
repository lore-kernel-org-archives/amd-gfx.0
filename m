Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF4BC54E41
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 17:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C6010F7D1;
	Wed,  6 Mar 2024 17:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nGJRxkhv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DFE10F7D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 17:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O529jniuC4eowmaC/x7akmKo6vUT1RVdjuqpuPa+nsRfj0oPe3ytAid8zF0dGEPwHOesDsVEJN/ravRWk+YGe10ZDGpkYkCcP1qGunE1wzEnSvkhP0lf+uTGs+PJ7geEi7SLPVlOt9Hw65EDSZYEhkJnp5N6xUdoFaai6YcjjBNPPO5Zjf967n36Z4+HmLSB10OmLSlzyu5mo82JnDyu7EDlG2Hrw+GL7qv/ywsFWNw9GZWFE1+3jNLAqBxr1NVjjOVlbQeR3jgTBHltuRmvLhJd9Q0fuGVNw+DMFgfy65mmI6glgMeZi+mP2l+vfOAOlHh6HJXafGg82rS+wdbsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r704knXyzoq2qTzDXzKnVr/wVvtY7D3Yv+Tu2AVA+aE=;
 b=oEhZIfp9kpN93zhIa1YJ7Wk9b1dopSa/KwgGy+y9PMfGNxdN64l2llPYO54B2jMD/8gZbG7ibL97kyTnrW2JfYqQms6Av6SolA/2/DHlXAMnLJn1BQlk9++F99AeemKO9LIB75gT6tDumFj51HllgscckerzYdP9iQzyp1nXYaV8GHM/5ViPncPec2n5C61TRan1IPxmX4Qx86w3wOB9N3jFv6U2ufH+PgjON4kXCFtzAsHJOUUA7VXpoSTd0jRvxwI/uq0XTNYA2PVSwjEgOzrdZ15xC9WdRYta+41twIxiCZwu/HyjHhVpRRcfmWJ12giVssxAhBedy8nRmcJ/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r704knXyzoq2qTzDXzKnVr/wVvtY7D3Yv+Tu2AVA+aE=;
 b=nGJRxkhvfoXJ83cEXijkHhQXhBXDb2Mwq5XxeCszkEmU1Bd/quWgM265fwBywy686RayKnj98blsPwqJf/POzz3jxIfBej6RTXHn7ONXr751aRivVtsssGmXZKQAcgf52whfVQmjVG/61s8PIfIUk+PefR0AZ0VX7WKyhi2TJ7M=
Received: from BYAPR07CA0078.namprd07.prod.outlook.com (2603:10b6:a03:12b::19)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 17:45:03 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::17) by BYAPR07CA0078.outlook.office365.com
 (2603:10b6:a03:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Wed, 6 Mar 2024 17:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 17:45:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 11:45:01 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Apply retry to IP discovery v2 and v4
Date: Wed, 6 Mar 2024 12:44:46 -0500
Message-ID: <20240306174446.2042884-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abf77b0-09f9-4883-2dd0-08dc3e05274a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WGXh03FF4C3C3I76MaD8jxz0rxDux874hKwH5Eyiztvo8elxwGlqKrkUqqJPYhz5/4kPg/rGg8zaFVOxtoBG5xBO1ZNGUgeHg60syoFIMv7HYSQBmwngpeaCu0glolaQByGVX9B4I0PExrXXPPjg0ZAdpSgGkRM4ZlkKBC354ZbvX38mEbyTpjspA+SaGgVNpPJ0ZeOjPCQhZVO00hlAu5wyKezh9FPLmdhUgSZPszvVjKxc6NNT8BJdr0vwKuXIc3PZBfdto9mOuvDMQDbUndquIJo0iU9yd06G5iZAvQU34SaUVK1iexqJz0rpG1EtnqcOsJhLoty4K+ofFZLlh1gYY2omvBWUY+VeyNELGJZXn9vRdnghtLHMi6knYR0bBCCOhrCid5pzjnM+X+yaEqU/J6swQO5LE09GgPpmS0VIYYwc8Gcbr8GHjW8/Jts+v87/KlZzVBPhSuh3UaNmxsBJYXwJLrB3TgMr4DwcGyzskpZ0vl5krQF1cEyXUXtwqr29V+2z7q8rtQjf9lZY/4AuHVhbGtncX88nEITqXauQhFgLHyEpi6mqKMla6zbk7X2A4HFyzswRn+AIDE3BX5TOPfI7V3KPyPGhbm9rVsdKKjrKUQ4Xp5jsFyy8Vv8sc4OLwa96VkyJl8cX+Tmvu1X/ITdWIExncNuav6dN8Rh2IlC/s3DPAAVxKRFw5ITFMuLqW58e/1HoQgLxgN5blXvbOxve9mYatuK4yd9d7dYjACMtUpKqXGg7y4d4H9M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:45:03.3449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abf77b0-09f9-4883-2dd0-08dc3e05274a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

To ensure GPU driver touch the local framebuffer until
it is initialized by integrated firmware.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 19f36acba143a..e231080609047 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -250,12 +250,16 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	return -ENOENT;
 }
 
+#define IP_DISCOVERY_V2		2
+#define IP_DISCOVERY_V4		4
+
 static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 						 uint8_t *binary)
 {
 	uint64_t vram_size;
 	u32 msg;
 	int i, ret = 0;
+	int ip_discovery_ver = 0;
 
 	/* It can take up to a second for IFWI init to complete on some dGPUs,
 	 * but generally it should be in the 60-100ms range.  Normally this starts
@@ -264,7 +268,11 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	 * wait for this to complete.  Once the C2PMSG is updated, we can
 	 * continue.
 	 */
-	if (dev_is_removable(&adev->pdev->dev)) {
+
+	ip_discovery_ver = RREG32(mmIP_DISCOVERY_VERSION);
+	if ((dev_is_removable(&adev->pdev->dev)) ||
+	    (ip_discovery_ver == IP_DISCOVERY_V2) ||
+	    (ip_discovery_ver == IP_DISCOVERY_V4)) {
 		for (i = 0; i < 1000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
-- 
2.44.0

