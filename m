Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5626E8FDBF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EA8F10E32B;
	Wed,  4 Oct 2023 00:56:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF1910E329
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PORiMNPJxZ3tnOUq172/t3GoXc8jvVEC7IR2oWiBDJj1orRf4DWyB8QsmyMDLZPEzGX8lvKM2jxEw3MF8ewAS/efjrihLLKi7baD4QY5l4fIyHTau2+hHnM4GAfM4PcmHTIondE1SmxBEBYzbcKbcne28vy3BXj+tH2+vAJCk2rXJM64qf7Z9djksvQ2UaOje4I0uUkaCyHUlofUvRAIB1qxPZcpmrCtD4Xw15NWZM0Wg8DIYTpPvfzMTCGAMaMHXbV3aTBzkd/9+Qpasw/9ZtW2yNOrVLs+cIZ2qPqx/I+7GeaV0CijbTNi3lnbzkmREDTC+EWqmBZRAItcvSTLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moHBI33nJPgiRlKVaAyCpEC0taJY4uUidnmh/VnqgME=;
 b=DAN4obfqdHVHHMvQGYQceUVkYVp2CHLnlvefSV073v1kRZ3WC5i6jeeXlpbOwh2+Z6MQkz1xExqf+H75JO+3iKDg3DT2IZpoj9DgL8EmmV7jZFxIqHf0AIzkh+NkBDZjoZgwMly75/WeXBI3IdeDhSfcpw8NCbko3DHfXOWE92aakH5bhzlBZ/FN9KSOKkluIWopX/ww8UPlFxm7OGfYGw/roxpD/E2BYHx/dNd68Bjdh9p07Ku4DYN2c0vLU9hboH5u0vfaimBdsx8Vs9ln9EjdRqpf/PJKEs/xbkQ6PA0KIIgidkFG8rB8y6agKacPG8QH48GYfGsg6P1aTaB/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moHBI33nJPgiRlKVaAyCpEC0taJY4uUidnmh/VnqgME=;
 b=CwPIzKuPr1Q2quVzxQfdR2qj96prQI31zdSQzY3Rntkc6Jbh6MOzrBJ+3cxjGCBKlul4khfqebJ91xTS0jU3YNrz31V0rpPB7o2RovipVr6QifdYGXfKL2QC7J5Q/pOOjwo2ME1QKu+ocOqBaufR6L+Z5X9MiRENZlUO00oS/4M=
Received: from MN2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:d4::22)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 00:56:47 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::5a) by MN2PR04CA0009.outlook.office365.com
 (2603:10b6:208:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:46 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:45 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Use *REG32_RLC_XCC in gfx_v9_4_3.c (v2)
Date: Tue, 3 Oct 2023 20:56:16 -0400
Message-ID: <20231004005616.108476-6-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004005616.108476-1-victorchengchi.lu@amd.com>
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e3b0f3-b7f7-4c65-f2b2-08dbc474c8bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQyCKSh8kEj2LegAw8uuCmJ+kKPDMndeU4VTJl4wUj3WqeqprjreQB172Pk882THb8Fgj8Kyjs7+NNdQo+daLHdfi/+mGKTUrV0pxYZ1yH2PcrpjZJqLCYCndjcGmLmFtXhyMSEiCYb4pp6mfHupagzIs4l3NVM86KGNa4opxxzyIUOec1sbLrPLxV2mS1g29st9WBQZExImi/gEKQ1SExr9LTBtsK0A5Zt/C68tPZcPNJdD2JQI+8/ar1B73CYA9WU6w/N1QNgQZoFn9clz3RbiULQTiGAoVFOyskSQvdMe4gUVkhuoJdFi2T/o9oqD4z5GjfjaZ5Esm1V9KEmBwL+5qU970w//tpeC5P3uOoD3w3gFc7ddVyZB4/yMgO3plykrPcklcxrbZO/PcGCb1LGsnD7AvzUZ1KhJypUVV2Iv1QX6Aah1wu3wkBcisBYgogV6e1Q+9cto16y0ufzLs6FyYVwDvwS0xrP+hy9N5ORKRxLrQX2qdwYAnxXgGdRM2GN+0pRlUAG1lkacMe1MxgzttzjNcE+W0RTILAmhyS0zmKF8Xkw8lVEWKNXELFDytjEshAFpao+/YZxI1Dp3ci5Uj0nnAsC0O/D3PcJg9wyVtMdFzf2b/08Sa0r67Uykeg16oP6zqo0n36WRg9U0ueA/xdf2ijVnzlGwCm5xmcwOdtPStVScZZ5PYQperNpLgtKml7+5bS39dtU3I8MIGnpItwtytuu8iMaRMFzXJDgAZkCnlNsUO982VT/PqWtxkzVo4fWy2ZTdKYKXeZo6CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799009)(82310400011)(64100799003)(186009)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(2616005)(36756003)(40460700003)(81166007)(36860700001)(356005)(40480700001)(86362001)(82740400003)(1076003)(426003)(336012)(26005)(47076005)(2906002)(8936002)(83380400001)(16526019)(41300700001)(4326008)(8676002)(5660300002)(316002)(70206006)(6916009)(70586007)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:46.5730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e3b0f3-b7f7-4c65-f2b2-08dbc474c8bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx_v9_4_3_xcc_set_compute_eop_interrupt_state should use
*REG32_RLC_XCC so CP_ME1_PIPE0_INT_CNTL registers can be accessed
under SRIOV.

v2: Use RREG32_RLC_XCC

Original v1 title: "drm/amdgpu: Use *REG32_RLC in gfx_v9_4_3.c"

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e7543bc49ee5..c010e80adb99 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2739,16 +2739,16 @@ static void gfx_v9_4_3_xcc_set_compute_eop_interrupt_state(
 
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 0);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
-		mec_int_cntl = RREG32(mec_int_cntl_reg);
+		mec_int_cntl = RREG32_RLC_XCC(mec_int_cntl_reg, xcc_id);
 		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
 					     TIME_STAMP_INT_ENABLE, 1);
-		WREG32(mec_int_cntl_reg, mec_int_cntl);
+		WREG32_RLC_XCC(mec_int_cntl_reg, mec_int_cntl, xcc_id);
 		break;
 	default:
 		break;
-- 
2.34.1

