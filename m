Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736B7C88CB4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 11:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C363010E371;
	Tue, 13 Jun 2023 11:03:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4890210E36D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 11:03:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et917kGlmyuaKgOxpEhS8G2/Bryeylw76QSbK0HsN549yiCRcx4wC2IW2woq6yu5DAxWz0PvpakeXdAz299rOJrLy9DKePZkWAyqeyasQ842YoYjK8JXOK1+cQfyTV9z/MMYSQsc3iSkLEXT7Cv94la8L/5+11mmQ6dHkOROTLRBCS6Xu4rd8HFwiurGzzkTMZpA77ASudWvHPM3Nz78W2YkSlnTYriP5MFto/pnfuFJtQtai7a5qJHwdElU+ySvhv2RWZo3v2vXVPXD7Bu5V+rhQ3AkxGm7+3SXVP7GyFIF7uMW9Y9CEUlCkaqysx1hx2/gw7Q+uaym3P4X+FnuxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2hBc7O6PvQ2Ih/qrrsdi0+qsumiSDSV0xLZKmArOGc=;
 b=LXP6x7ZDIAhl8egh6BS+6ZeDkgXOsy2c8KQWCruGuW9SeKm3/InJosQ0eSXvOaJWrdW1ORRYFYOTWtKGofhNFRChlgCo+uAHkBaLdwbgLHPL+VT1XPT0hH1TUopHAn46INkU3wnfR9xUJgq+RMytibM4DuFkSXmOamDSk6YOy9gHgZ/PWuiCGURkPLbNYYIcLwv4c49hQKs1SRV/VAzN00GRPd7N2w+N0y1q4Bou7Dz1NL5x0VyqTBCkaUtGsow7+8G65M211kEwlsLDEil6I1T/tpvJlh23Bd7Hm7QXR7v8VldM7MPMv2UwW1JCwontQxEN+RDTCAnAPK05BSsdhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2hBc7O6PvQ2Ih/qrrsdi0+qsumiSDSV0xLZKmArOGc=;
 b=cESZSncdZHWLv+ym7AnFCODg76OTOtIZ/WG++wysge20R9FpW4azfBMR9kOFe2mn6Lf8vEcetvWzql6M1tTp8czssfqzLDKNc2E+3KIW9hzQ29o9ZDb19Q8fTd6+YLmNAZiaHCSOyUAjIHAopM/gGMV/wzPJYkCEL2R/CpXjfI0=
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 11:03:15 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::d1) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 11:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 11:03:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 06:03:12 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu: Use PSP FW API for partition switch
Date: Tue, 13 Jun 2023 16:32:55 +0530
Message-ID: <20230613110256.1562271-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613110256.1562271-1-lijo.lazar@amd.com>
References: <20230613110256.1562271-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|DM4PR12MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: f87cc159-5b67-4415-3ec4-08db6bfdc95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrYge3/7rCTbRVfS5L4YojeeI/kcX9tgb/eAZ4sO/Pi5FOiBzC0yfRQftUI3nOp6AUDeFz3EcMI1zrNNwyN+DDgk/tNkGxZE2yOey+xSNh+l+AbP9g9wFBMJQXIlqSnwHYyKRRqK2P2qH+yjYFr5DpIbN7LBoUoMyrrPtldttyXSD8hYopuPsoEWYYY2tT8YLVbipaZ7+FeZutouW6AX6SfUyvWiL77z8Jy5hiOp3Sc73+7GZ1AxsZ6+gqQL+CKfj+lVm4Jdh2qgIGWmZnZ8RdTPe24tjiPAIC0M+NqdMLsbJKFeAXzaYpD6org9IVO8Ti+C3JKSWKaNygQxm5DEo8TEDX2qB0afBvO+7/Qbndh3aUL6da+Xlmm7OWfqjQKwiNB3lCdfjB2FMecpj6T5lcREfkg2RMQAov2WuZnFCwGverpe3Lr3ZZT2hJgDKLiiTI110ZkX3pwYQpdKRtMd4bD7fr53rXIScJjAAFcH8+50tMcNdxt4ATAWdCnWwphoGonaebbuZZTx40UPQmsrvxrmJDQXLJ1pJD7JF1Gx/ria3bkNYgS2BgDBO9EIbHhFR0umCxhFx0DO4/hYlEzP7LzDk1IxZCzSXkb0Yd+e/QkcdqWnmuszAYTWJPX7BtYNXo4eamT1mzTt3ODCM4jdTtMmSxxxt3UxvoniaveESIw8MeWV/WKyHWOz2SNV23FVvJu1dlGrPEb/e/rK+7ZsKY/TwCPAc37GyV9saTFcVxjx/VborsBtO8KseLUnUXSNStR7bxi392qEstVOAN46HA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(40460700003)(7696005)(6666004)(36756003)(426003)(83380400001)(336012)(82310400005)(2616005)(86362001)(26005)(1076003)(81166007)(356005)(82740400003)(40480700001)(47076005)(16526019)(186003)(54906003)(41300700001)(44832011)(316002)(8676002)(2906002)(6916009)(8936002)(4326008)(5660300002)(70206006)(70586007)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 11:03:15.0789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87cc159-5b67-4415-3ec4-08db6bfdc95e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5038
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use PSP firmware interface for switching compute partitions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
	Changed the return value to int

 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        | 18 ++++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a595bb958215..16471b81a1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -518,9 +518,6 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
 						       num_xcc_per_xcp);
 
-	if (adev->nbio.funcs->set_compute_partition_mode)
-		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
-
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
 	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f5b8d3f388ff..c1ee54d4c3d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,22 +623,16 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
 {
-	int i, num_xcc;
-	u32 tmp = 0;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	int ret;
 
-	for (i = 0; i < num_xcc; i++) {
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-				    num_xccs_per_xcp);
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-				    i % num_xccs_per_xcp);
-		WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL, tmp);
-	}
+	ret = psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mask) /
+							num_xccs_per_xcp);
+	if (ret)
+		return ret;
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
-	return 0;
+	return ret;
 }
 
 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-- 
2.25.1

