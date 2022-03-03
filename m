Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A86CC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 03:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D07410F166;
	Thu,  3 Mar 2022 03:46:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FF3410F165
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 03:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U18ztqFJPgjNmeVYJ9cICOA7LCreP8XNFRE/owOapzeqRqAtm9pcHZtw1AJikiC4E71B0dZNO0rqlBQO3BE/yX+pZyHjVy8MYNwWTGU9mXy9ODVuWkA2GxZOw6hZTS8iYM2RymxOZWfguj3ESFwELmbYIbZvlwhBPXPOzbcISPuRxHG6eiJJ+mYfnmyYPiorVcXybhr8KsdTaUIOR/J1bQDSv+jtDewp1YRsvLW8STrrqZfmw9j8HziVah96nfoaHUnuefwnuqCoM2TJ+IN9OKudoRYpVG28awCwWUiLnzji5lQLqDifJZClHTvcsQGkLo0leVqL2lJCkClANCRO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tp9MFE1tKLKIIrea3luzHSYuSw+tPqdf/vUOlPnRiVU=;
 b=KMWRiACbkVnqh2aS6P/9PUIPh1JjpOrKAgCOrVFT3EgimDmc0qH9xRe5x4h1yuDKtI1Qc9C9u0wDTIOmqMvMSBRf72VZ4M7C6piX3mbmcA3MADRvzS3sCWuxxV4evk7Kmjm6LVv7DHf3l5yvbYkP45QFXJ7byjFOMks3bF8w1Six4azJvL0So4hXfnxBqkE75MV79E21x5DmRc3xj8/P4uubOA0FK9kl2YE9UOJhjzAVC/s3UxRjaJ5Lxr2xpQSdaPzS5M5gvVak8A9DDvHnJSxPojylkVM/i5WoOH+BkBsxGwHB2DgpLhPzpIjo2skhkdcFYjpmu/YPoJ/tDiaVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tp9MFE1tKLKIIrea3luzHSYuSw+tPqdf/vUOlPnRiVU=;
 b=txwyI8Bv8JuSO3/jC/OJdgaJ2Z1xhSgQTDC9jIgJb7FHk3jb/R82oCgj2sd/kafzwOZEB9LkHdj56diQ9bJ+3W6T6l7ESa3YGsZA4cVWHfBbWF0nECL2KltA3jTGx56FDk5+OxCLock5R3Wtk64KB2hDNTjMmefUGRdZ9NANzW0=
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 03:46:03 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::19) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 03:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 03:46:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 21:45:59 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Disable baco dummy mode
Date: Thu, 3 Mar 2022 09:15:42 +0530
Message-ID: <20220303034542.755479-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51dbc562-6935-412d-e099-08d9fcc85686
X-MS-TrafficTypeDiagnostic: SN1PR12MB2477:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB247786D0430CC930C886297897049@SN1PR12MB2477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwrkiKwJtfdCVBDLqHydOCz4FfC35/6pPH7bWSfSWIiXJ8DzBnhjb7dKwAQtXSzRziMb5msAsreoQCbf3ZOO+qu5ku5/ExNokG6soKma/E1aekRcneTGRYkGjlbRVqHlZ+mjv37733eaZgTO/SsPXZq1EPcsR3Z0XxZtBlRLuApkzBzqCG6HYbsuFuXBTuzCrq+00qD2hXqK53sq0u1j+ahZLhMs7aEMRckcjEr0cisRj/mcUrdzXPl2HpXgPMCNEk3v6t0hiF5ttWvS6ckJykzgVZ9zbUli1KU0Ljfxwf7ocMX5U12S7HITA+VTXLhEkZVEZi11pGf8q6+fM9AhGn6tjn9x+2YwwFlZI1PYvq/GnA6SiaPI/hjH+Lu+JKx7CwHQS5o7K09yF4tyhbyF2/vUlfvvBH+AZw5ifyZMJLcWEcRT672JSTKB6yYn91rSB2zLpm/VaPbZQ7mLB6UZcwPt7R7FVn502at0u2Gs2bXuy/Vi3zyatzUym9xV3Fb2443Tsds3arFoTNjrYNZ7Aas0M0C5cqGB4YAKnm/1cXXy8CkjaOL/Dhm6jtRSHeIu97kxqjoLkV5eJdPKeW9DqTKW73dPV0bcygtbaZFCNSqWKtJUIsns3PX14UbZ0hQaHI9kg7HrwytmtOQ0+LOE2mRqtgBAnT5d/+P8lUJEQRk01ft3kwDDfAt6bW0ANsPRKSn5kWAyyE4Jkm8FhmumuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(7696005)(336012)(2906002)(6666004)(1076003)(426003)(5660300002)(36756003)(26005)(16526019)(36860700001)(186003)(2616005)(44832011)(81166007)(356005)(82310400004)(47076005)(70586007)(70206006)(40460700003)(54906003)(6916009)(86362001)(8676002)(4326008)(508600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:46:02.3880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51dbc562-6935-412d-e099-08d9fcc85686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On aldebaran, BACO dummy mode may be enabled during reset. Disable
it during resume.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index b31df4db01fb..c2357e83a8c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -362,9 +362,24 @@ const struct nbio_hdp_flush_reg nbio_v7_4_hdp_flush_reg_ald = {
 
 static void nbio_v7_4_init_registers(struct amdgpu_device *adev)
 {
+	uint32_t baco_cntl;
+
 	if (amdgpu_sriov_vf(adev))
 		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
 			mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+
+	if (adev->ip_versions[NBIO_HWIP][0] == IP_VERSION(7, 4, 4) &&
+	    !amdgpu_sriov_vf(adev)) {
+		baco_cntl = RREG32_SOC15(NBIO, 0, mmBACO_CNTL);
+		if (baco_cntl &
+		    (BACO_CNTL__BACO_DUMMY_EN_MASK | BACO_CNTL__BACO_EN_MASK)) {
+			baco_cntl &= ~(BACO_CNTL__BACO_DUMMY_EN_MASK |
+				       BACO_CNTL__BACO_EN_MASK);
+			dev_dbg(adev->dev, "Unsetting baco dummy mode %x",
+				baco_cntl);
+			WREG32_SOC15(NBIO, 0, mmBACO_CNTL, baco_cntl);
+		}
+	}
 }
 
 static void nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device *adev)
-- 
2.25.1

