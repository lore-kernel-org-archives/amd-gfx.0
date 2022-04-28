Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3552FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 22:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E11E410E21F;
	Thu, 28 Apr 2022 22:12:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7229610E085
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 22:12:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaFR5maWyy6p3xGPD1yFuNvu0Mi9mWION+D3ovlU/UZpG0FzFktcmLtOgbfZjaEWErTKUE9ekQLq/ukEkCivk5aZW0W2bK1slyoWbLmQxDJaIP26wWDJn0fu6lQz+Yl/umA6hKc+L1KxQVi7hvM1JtQP3yHN8kP4Tp/+jQWjJfZa/oky0mHTSZ+JRORDbaAupLihEIalKOBxNjRNq/25h5JwCx+7snxHq4j8sOzD9SN/vnVpYxoDkwM4kYtyWDdS+1Ktu03VBoLGGBSzjD4k4O3E32ZZo0g1GAGDDS0rqXOa6QZsVQ6texTEJzcwEph10oK+nQB1eyE5Vq1i0Qw/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcDklm+AH2qg9tcJPaBkRxHnq31QbC1aKkvg+m9m7fM=;
 b=io7cORId9Q1C6qpTEDAw+p8PQWcyhTwxxsyV8khCY88PrEHMaI9KKhhRmwo314WBrurslD+52QHPelM3jbqw73ffITLsbkQR2HnxC4Dadz9vGdKc1w6Cibpu6QD2bK1F4IVKbpGi4Z+7MmtBYe4VMFYZ4VlRmc2oBIBg9WiHJPLv57pAdsvJU3VTmMkygXW64U4UXURPMZ6NiyUb2G3+8wUxZd3z72X/0daNf2NezrGRoC2TTvG7HekRpo2H5mIfWjcDT99qBormWS3uswf+RMuezVfxXG3hqjiJEhLyXmjTaI9hHQ56vWq1eb1X8LEGZEc+ZZumnOHtVlSGGpbCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcDklm+AH2qg9tcJPaBkRxHnq31QbC1aKkvg+m9m7fM=;
 b=hP5odfF/LIJSB7fxwoR2sihzy2B71H7+uprq9BAqfwIMhWy9Ka4gCqU6LqVWxHjFzLV+KWlcm2sBgqiPDqO79nz9WQao/JAV7vI6magdBPgvn1P9D6Ag+5TS5EkJE5+4/dZmztO+6e0djBlAPftINIZQNRFz00rGG7GC9Ym6yyE=
Received: from DS7PR03CA0269.namprd03.prod.outlook.com (2603:10b6:5:3b3::34)
 by BN6PR1201MB0227.namprd12.prod.outlook.com (2603:10b6:405:4e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 22:12:44 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::dc) by DS7PR03CA0269.outlook.office365.com
 (2603:10b6:5:3b3::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 28 Apr 2022 22:12:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 22:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 17:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdgpu/psp: fix memory leak in terminate functions
Date: Thu, 28 Apr 2022 18:12:29 -0400
Message-ID: <20220428221231.1030104-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221231.1030104-1-alexander.deucher@amd.com>
References: <20220428221231.1030104-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c190b46a-a813-45c4-f932-08da29643862
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0227:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0227DB6C49E3ED3F05E73F80F7FD9@BN6PR1201MB0227.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K72eV8OwB9TXcpnePwqRU+rt4DEjebkeC9wDgEN+dGVhHiMdAyQ1ELG0j+wY3pjpFJOHlye75gab3VM/cjYtALD63GEOFWYR+Kv0N9XIheUN7vVnaN7MOASqpmv3k8AClLR+cnhKvjrDIM0tDvKwxARLgp/kDzRHKnocXkn/CwssyUQnXzEl9W6lQs+MPXLfMvjAHHAoNWrNuM4yXpFis2SO7bp1GpoO6w6xlc8W4yYOPvUfN0cptFcOVflLG8kSbGSvFjbChzMveH4uS3L5x/XBJFlb3jpPWJNyz+muuVLKLBkT/YZD7iPWxHkQzuwrW4SbBWKkpJqKb37Cd5wCwNhznk+CVrtk1mKOS7VQ5/RbCmfoNMDICE6Ul+xtcTLzKjKAnY7sn/fnm2UavH1mxvieKxqGfe7MfqbubTblUQx9sXE6nFTVR27J1EsWCrubA+2/exqsbiUPzTFhRtfNOdhJZvbKmPtuUfKeLCOqZLwdJNxMkLB0FJQBC9vx9im9K7a2FBMNPbGuWJw0UGjIsd3ac+KuGJjUD+o7Ooi/aogcBScA4HpbjIq5mwvVUKe0TWV6w450+cwTK3QetXOYWd7SpB8eFYCJ4Bhi2BmUVoRxOd73kGINaLR/simMy7KzXov6H1C8wnUTfSduDFucOMxnTZ1c6t1sencfnUexyhGQVbtoyR8fRdw68qcKSQ3sZcKHgODQQVKegZFsbHSQXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(8936002)(426003)(508600001)(83380400001)(81166007)(356005)(186003)(336012)(82310400005)(70586007)(4326008)(8676002)(47076005)(2616005)(86362001)(6916009)(1076003)(70206006)(26005)(2906002)(316002)(36860700001)(16526019)(7696005)(6666004)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 22:12:44.4887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c190b46a-a813-45c4-f932-08da29643862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0227
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure we free the memory even if the unload fails.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 34 ++++++++++---------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9dc83641c71..1ef2aba2ac3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -752,14 +752,12 @@ static int psp_tmr_terminate(struct psp_context *psp)
 	void **pptr;
 
 	ret = psp_tmr_unload(psp);
-	if (ret)
-		return ret;
 
 	/* free TMR memory buffer */
 	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
 	amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
 
-	return 0;
+	return ret;
 }
 
 int psp_get_fw_attestation_records_addr(struct psp_context *psp,
@@ -1101,15 +1099,13 @@ int psp_xgmi_terminate(struct psp_context *psp)
 		return 0;
 
 	ret = psp_ta_unload(psp, &psp->xgmi_context.context);
-	if (ret)
-		return ret;
 
 	psp->xgmi_context.context.initialized = false;
 
 	/* free xgmi shared memory */
 	psp_ta_free_shared_buf(&psp->xgmi_context.context.mem_context);
 
-	return 0;
+	return ret;
 }
 
 int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta)
@@ -1466,15 +1462,13 @@ int psp_ras_terminate(struct psp_context *psp)
 		return 0;
 
 	ret = psp_ta_unload(psp, &psp->ras_context.context);
-	if (ret)
-		return ret;
 
 	psp->ras_context.context.initialized = false;
 
 	/* free ras shared memory */
 	psp_ta_free_shared_buf(&psp->ras_context.context.mem_context);
 
-	return 0;
+	return ret;
 }
 
 static int psp_ras_initialize(struct psp_context *psp)
@@ -1657,15 +1651,15 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 		return 0;
 
 	if (!psp->hdcp_context.context.initialized) {
-		if (psp->hdcp_context.context.mem_context.shared_buf)
+		if (psp->hdcp_context.context.mem_context.shared_buf) {
+			ret = 0;
 			goto out;
-		else
+		} else {
 			return 0;
+		}
 	}
 
 	ret = psp_ta_unload(psp, &psp->hdcp_context.context);
-	if (ret)
-		return ret;
 
 	psp->hdcp_context.context.initialized = false;
 
@@ -1673,7 +1667,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	/* free hdcp shared memory */
 	psp_ta_free_shared_buf(&psp->hdcp_context.context.mem_context);
 
-	return 0;
+	return ret;
 }
 // HDCP end
 
@@ -1734,15 +1728,15 @@ static int psp_dtm_terminate(struct psp_context *psp)
 		return 0;
 
 	if (!psp->dtm_context.context.initialized) {
-		if (psp->dtm_context.context.mem_context.shared_buf)
+		if (psp->dtm_context.context.mem_context.shared_buf) {
+			ret = 0;
 			goto out;
-		else
+		} else {
 			return 0;
+		}
 	}
 
 	ret = psp_ta_unload(psp, &psp->dtm_context.context);
-	if (ret)
-		return ret;
 
 	psp->dtm_context.context.initialized = false;
 
@@ -1750,7 +1744,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	/* free dtm shared memory */
 	psp_ta_free_shared_buf(&psp->dtm_context.context.mem_context);
 
-	return 0;
+	return ret;
 }
 // DTM end
 
@@ -1922,8 +1916,6 @@ static int psp_securedisplay_terminate(struct psp_context *psp)
 		return 0;
 
 	ret = psp_ta_unload(psp, &psp->securedisplay_context.context);
-	if (ret)
-		return ret;
 
 	psp->securedisplay_context.context.initialized = false;
 
-- 
2.35.1

