Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5B4D591C4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 06:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E08310E5CE;
	Tue, 19 Nov 2024 06:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z4+AZY59";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA2010E5C5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 06:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEtOjHzRnWpoFIdQgPwtsFGlJOti4eSXEATu7sXr6Pr8tF9W8yRnzn5ROHXjhlSnD9+pYmoVL5wZR7XwR6yvS4nPfFsiqCnliTJIkirkdx8VqAOk/R0Ywpi0FpWuOwfVpIeLm53ukg3oEL5wIFRfpUTfPJJJacAsOUfF2jVUsxsJcovYd1UcndDEkbwpIsXDWLPGfmxfIS7TnUQr7D+D9u8aSBdcCyU5A04OhRD/vhK6Z93l6DyiDT9yesTgQxhzesN4H3beNgskvwbXYKKtuUFPrRdMQI5AuFx2ICN7Iw5rASPjBcIr6A+Ad/fRhCfUpbOwtARpd8fAbDVOlGROfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtjOncRtT17IGO1wnMldqoPyzxzEPHFUNLfZdRsKoq0=;
 b=KBG2iSpqyGLTGVJmpF8AUwX93DIhc0BQxX7O47qIpzDgVaiLnfAq9JOoySpSywxuwUPXXFqACIPhELTgb06ogr5UDU1U6ne/sP7ZzC93I6GGYeEuAUCSBb/Xvgq5Fgo7yOXcdDBVqGEhZ/efYORLZCPO272+P65Ya8Teekso35l7GMiLL7GyF+tOSwf3igSPFYhfDK3ul9JojPueO+E8ynHgYJDHhzyEYKv1oPP77AyUGi/CaDoTrP0U6awJ/PxsHYJSgt6eBwaG9C+ZBgMhHFl610c94YHW5Q9ZqJq/9esZGsWi5za/m1UVPQI4LnlE8xdCDfp60suHY0U6Drzu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtjOncRtT17IGO1wnMldqoPyzxzEPHFUNLfZdRsKoq0=;
 b=z4+AZY59N2lUqoy/1F24IcNchHAj+xZUPEmeomYCfgB/iaNqAQ9O/wRhRCE18Y06kRH5rDDSjPN2Y1Bls0KCg7ZAD9owDjAwaNIVCae/3KX+ZGXuKmV09sA/NSZKKi+/bdPMkw6QH/fUvmzyN6ZEt0pN9fdGwSaSAVqL+rh8wkI=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 06:36:39 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::11) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 06:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 06:36:38 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Nov
 2024 00:36:35 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 12/21] drm/amdgpu: add function to find all memory pages in
 one physical row
Date: Tue, 19 Nov 2024 14:35:55 +0800
Message-ID: <20241119063604.81461-12-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119063604.81461-1-tao.zhou1@amd.com>
References: <20241119063604.81461-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d75592-99cb-4902-3c90-08dd086485c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Rg0KU5yfSL8ITYt/rItT/urZ7irS5ivZM2qtmwLXcw5zXlsjwG7qR+zTREzY?=
 =?us-ascii?Q?Xn5e7bzcCwuMg5GsSvL6NTjysU1Y12naCciL5XWZHjsf4aXjKJ8S60nurIFR?=
 =?us-ascii?Q?++0qoR39VZ9RZxjEze0+YodkI+z2eWXUaqWzWGq/HX/D+3JiOtuhdyN2AWjX?=
 =?us-ascii?Q?3geFqJq4NI1XJyJz1ZjtBQm5/+RUa/lrDCd73ucz34R/GPjcmfCoMG9N0pUX?=
 =?us-ascii?Q?qhMK01ScJLQoDLfT4dMJE0jKqY96jB9XeAE7bQb860tYf0XthnYDXLReEh01?=
 =?us-ascii?Q?+a2NUsIKCAocrJAwGO6zszYI0275PDAfQRgnx3RiSomrr9Su3P3oQe32byX3?=
 =?us-ascii?Q?+QZYVyuBAZtHBGeK1caB6GV4QzeXe9SWgGLVXk7oK6WaNPPH7fQ/6SuVyNEv?=
 =?us-ascii?Q?3ujhuz4EKnaPiDfZ7szdn6oDkb3vzmSw+KCHrmr2f390xPJhVftz+eo1TdWW?=
 =?us-ascii?Q?OuZFcQQGmNjRXH3GYNZ9xIAcHkPnmsOk4hGUnn6UDFBtaxdPePH82wNB9zuG?=
 =?us-ascii?Q?N/8DTUwjZI4rSvpHS06jUP+YhlD77KenmvWlPpLTuy5BIccIPGpSltEHpszI?=
 =?us-ascii?Q?cTCGw9oRz0YzSJCX9TTldIMjnGT7WEAhPQ4/EhWH9Hqns4Ifa01IuKTr8e68?=
 =?us-ascii?Q?9+PkvVwlyOm0W2cxfGigCY/BLKsNORy7yM0fJ0GXR7iUq2y5bzi3c8aHjOSr?=
 =?us-ascii?Q?sMHH+0XugZXD/CCSFM7Q003Vq6xlklwRgoWcBqCt0SeNZJs7K3FL6IbR7haN?=
 =?us-ascii?Q?JlwaD+s//8b7+4HgDpMzgkykY1n0scDZqBjYjHk0QgSb3rRurKxFo2nD12EX?=
 =?us-ascii?Q?E68NqS53DTjNd0LyAkOUlK3T5K2G0RulZ+yLnORq8Ce8bKEj1L5bPSCA7lpN?=
 =?us-ascii?Q?3LCRvFDrHJNloSnrUeVlT57wb4jZpfRFS/xpxjtgsh1+9Qn+acaNCB5Xpll0?=
 =?us-ascii?Q?BMfvdDpheLMFqQbw8D+faKusRPD7HMWpPTAi9GDbNFwq84bEDruCMiL+4dGW?=
 =?us-ascii?Q?Nv8DqszaqenDuICM6LakuQcxp+U6Q2nF5heSbKwL2VO4tmBP7kOwwjwynvcX?=
 =?us-ascii?Q?9u+J92kwbGxYyEo2lGARdeengj9YMResSIb9VCn2f+U2OTmw3Cv+Iyc/mg0L?=
 =?us-ascii?Q?Cr4Ui4zzrPzon2Qt+LwkL0mhMiywPfCN/tVvpJnrVXuIJc/bFfmG5qvpwKsG?=
 =?us-ascii?Q?nuMNnfnoIa7sGRPZn3ZTaMDKWfbKiKeYHJD83sCWYIhcCvtx4p846cSMbFg0?=
 =?us-ascii?Q?EaCGtADmqWcGexOE78Ubc13mpJv9I3Ndc9L/YUPeWnDpjb6yn2qfTpzftaMi?=
 =?us-ascii?Q?6opsQAD5+ju8juRkGfiZraqMIL0FOgny2j/chrjCX7ZK3p+2Xx1OvbeEd8RV?=
 =?us-ascii?Q?S04C/HPZJCtv5n3WKfoLe/CK/KB4neD+E0JzAPzKmhMhZ4/DFw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:36:38.8701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d75592-99cb-4902-3c90-08dd086485c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

And the function can be reused across amdgpu driver.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 37 +++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |  2 ++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 3199dca8f1ea..11f7299f773f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -446,11 +446,27 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
+			struct ras_err_data *err_data, uint64_t pa_addr)
+{
+	struct ta_ras_query_address_output addr_out;
+
+	/* reinit err_data */
+	err_data->err_addr_cnt = 0;
+	err_data->err_addr_len = adev->umc.retire_unit;
+
+	addr_out.pa.pa = pa_addr;
+	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr)
+		return adev->umc.ras->convert_ras_err_addr(adev, err_data, NULL,
+				&addr_out, false);
+	else
+		return -EINVAL;
+}
+
 int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len)
 {
-	uint32_t i, ret = 0, pos = 0;
-	struct ta_ras_query_address_output addr_out;
+	int i, ret;
 	struct ras_err_data err_data;
 
 	err_data.err_addr =
@@ -462,24 +478,17 @@ int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 		return 0;
 	}
 
-	addr_out.pa.pa = pa_addr;
-
-	if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
-		ret = adev->umc.ras->convert_ras_err_addr(adev, &err_data, NULL,
-				&addr_out, false);
-		if (ret)
-			goto out;
-	} else {
+	ret = amdgpu_umc_pages_in_a_row(adev, &err_data, pa_addr);
+	if (ret)
 		goto out;
-	}
 
 	for (i = 0; i < adev->umc.retire_unit; i++) {
-		if (pos >= len)
+		if (i >= len)
 			goto out;
 
-		pfns[pos++] = err_data.err_addr[pos].retired_page;
+		pfns[i] = err_data.err_addr[i].retired_page;
 	}
-	ret = pos;
+	ret = i;
 
 out:
 	kfree(err_data.err_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index f45408a6ff03..ce1e4fb385b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -139,6 +139,8 @@ int amdgpu_umc_logs_ecc_err(struct amdgpu_device *adev,
 
 void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
 			void *ras_error_status);
+int amdgpu_umc_pages_in_a_row(struct amdgpu_device *adev,
+			struct ras_err_data *err_data, uint64_t pa_addr);
 int amdgpu_umc_lookup_bad_pages_in_a_row(struct amdgpu_device *adev,
 			uint64_t pa_addr, uint64_t *pfns, int len);
 int amdgpu_umc_mca_to_addr(struct amdgpu_device *adev,
-- 
2.34.1

