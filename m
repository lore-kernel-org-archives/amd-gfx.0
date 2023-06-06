Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6526C77B7A
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:17:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A2D10E317;
	Tue,  6 Jun 2023 09:17:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA6410E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLKGZJxH8aKW8cfYUNf7EgB4d9Xf8U0c+aFBTDOhqp7xHGonKFG5GPVjH46ukf78Kr/zk33s/pWM61UHwG8hXtYdjcGoGnhL/emrCA2J1Akm2AkNTsbdab7NSFTNtYAvMbaQApJ1z7NNxdBoFK/a2E1SWFY0Bh3Cmpf2FgMLLSboIITiy3zB7si+Z7N5vZDmEGji5JHVOdO3SJfn2YZoHkZ268eiCQ8GFhBvEiguAJniq9vXrqa4WDidMkOMa2jrwOXPIcRrUtukfa4lJDgJT/SwgjqctbPLoolbipEjLbl1Eg2fH6nN3UZAKHI+80vgQZuEDtsBolwLu/pGW++Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uREOWXSG6JLuDg1kgQK3kSMWWDOYwEKw57ofw0yf/P4=;
 b=V7roD+ajs+BfWtunWd+9KcwRVmbfskh9dCMDAKp+kVv2tYe/pvITdr2tz/rMYmFBKDd4MqDTr8hQ9W8GJIzkACnipE1FPrcDzPXPZOOCAOvtFT7bqOZoutQz3kYRgr2yUT8RZhVNbD5iNV4mcjcR0JrOOZc+yoDEEK3znONy6+1xR8Z1XzxnHY5X87HaBpu1vqpvXkbFz5AlOm5FsTortM1RHcROiMBOpr/MDRgmUzX72/8g49MzpanD0sk3DtaOiIjE38DtGCbpCui1p6eT+DCCRmS5SWCC/0HNCg6vmLoxwn2ZmIekNln7k0q/CI/xbvVo21NciQJumgIOWNbK4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uREOWXSG6JLuDg1kgQK3kSMWWDOYwEKw57ofw0yf/P4=;
 b=afaPKNoTTnRr9NRAijLDheUCxFMEMwIDdKBUPGVXFWm+FxUAI8CXWyiS3y+crqlpsgnS56RTkmeul4rT0qjAIB7OmaQ3hZMjXc7zP7RgNhWQEfWjf8d0vgpaIvUgs9xsS1o/edFyrAvdEynU6EdRR157KPulifq31tetaFhPZYE=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:17:50 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::42) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 09:17:49 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:44 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 01/17] Use the correct register prefix on Navi3 for top
Date: Tue, 6 Jun 2023 11:17:09 +0200
Message-ID: <20230606091725.20080-2-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: e75eb134-0b14-46c1-4442-08db666ee5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR2jbQoQ+VMi+1oFO0ZBnp7Imr/Bs6eyO/c4NkxyV4rJiHEH6u98lrvdSRuj91HNps827lP0AiFA7SOtjkg5AxA+Vx3T2NhPZmqcIhp5QY0zy2BRKE9OJhgBV7GWUVoc3tRyG0At997Q5awul8p6KTaYGV9eQxTP8tOetUtcU3/n/2HQYFc8toUpknhQn9pvBwJSiYXY8BIgPkL8CVeOohsyAuaXmiS/9Hi7Tb1whbRFo59mQAVCDtnCljxK17D0wvO9UKYB4Y3JBLw+bAsH+BK3xlr0cO7+Q4UsHp9Rlw4vauNGAioEJRmiRLITYgP1irBAcN9OSTBuEn4jp4IJ+XQmH7LjMr7yTKHt41QtAZYHeVsWXYl30nRnQgJroaIhpylLJ1dzFu0JC15w7lXRY32NzhbswKHRNz+UTZ1nXLqbBCtuMQeNtMcX8NT9bvvd7cfoH1P+Bvgr65HMPPff8qV4DmfmmM5R6alY3xVHGh+AUioi1qIBELjuJ+7w74NarZWlyMW/XOKYE/SSVTDlWjniuIobSmILtoOKbfoABlWL5uVkYXV6SttO19u1vnbb1ZQoiieM0evd4vIF4iiqjhzNNC2JA8XNNreXACNC4+JZY02Iw0TbIaeeJvP6bDvMI0/VeQZ3XMv5s2beaw0Wi0sztXkJY6Uk9jTXt6Dvycrc81vRUG3IoZ8nkyI/LwjGRds2lCNnMT8S/F65UJvlh0phho8kCzG85vxukzJsJ1/nM9gLbjUczjDlKhbi8pw+OpIM4Vz5vn/7BLpoovFw31mD34afxVQPkktAP9qRtj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(47076005)(66574015)(426003)(30864003)(336012)(2906002)(2616005)(36756003)(86362001)(82310400005)(356005)(81166007)(82740400003)(36860700001)(40480700001)(41300700001)(316002)(6666004)(5660300002)(8676002)(8936002)(478600001)(7696005)(110136005)(70586007)(70206006)(4326008)(6636002)(26005)(1076003)(16526019)(186003)(36900700001)(433614003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:49.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75eb134-0b14-46c1-4442-08db666ee5ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/app/top.c | 89 +++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/src/app/top.c b/src/app/top.c
index f99b7b5..40ed0ac 100644
--- a/src/app/top.c
+++ b/src/app/top.c
@@ -903,30 +903,31 @@ void load_options(void)
 		}
 	} else {
 		// add some defaults to not be so boring
 		top_options.vi.grbm = 1;
 		top_options.vi.vgt = 1;
 		top_options.vi.ta = 1;
 	}
 }
 
 static struct {
-		char *name, *tag;
+		char name[32];
+		char *tag;
 		uint64_t counts[32];
 		int *opt, is_sensor;
 		uint32_t addr, mask[32], cmp[32];
 		uint64_t addr_mask;
 		struct umr_bitfield *bits;
 } stat_counters[64];
 
-#define ENTRY(_j, _name, _bits, _opt, _tag) do { int _i = (_j); stat_counters[_i].name = _name; stat_counters[_i].bits = _bits; stat_counters[_i].opt = _opt; stat_counters[_i].tag = _tag; } while (0)
-#define ENTRY_SENSOR(_j, _name, _bits, _opt, _tag) do { int _i = (_j); stat_counters[_i].name = _name; stat_counters[_i].bits = _bits; stat_counters[_i].opt = _opt; stat_counters[_i].tag = _tag; stat_counters[_i].is_sensor = 1; } while (0)
+#define ENTRY(_j, _prefix, _name, _bits, _opt, _tag) do { int _i = (_j); snprintf(stat_counters[_i].name, sizeof(stat_counters[_i].name), "%s%s", _prefix, _name); stat_counters[_i].bits = _bits; stat_counters[_i].opt = _opt; stat_counters[_i].tag = _tag; } while (0)
+#define ENTRY_SENSOR(_j, _name, _bits, _opt, _tag) do { int _i = (_j); strcpy(stat_counters[_i].name, _name); stat_counters[_i].bits = _bits; stat_counters[_i].opt = _opt; stat_counters[_i].tag = _tag; stat_counters[_i].is_sensor = 1; } while (0)
 
 static void vi_handle_keys(int i)
 {
 	switch(i) {
 	case 't':  top_options.vi.ta ^= 1; break;
 	case 'g':  top_options.vi.vgt ^= 1; break;
 	case 'G':  top_options.vi.gfxpwr ^= 1; break;
 	case 'u':  top_options.vi.uvd ^= 1; break;
 	case 'c':  top_options.vi.vce ^= 1; break;
 	case 's':  top_options.vi.grbm ^= 1; break;
@@ -963,44 +964,59 @@ static int sriov_supported_vf(struct umr_asic *asic)
 
 			return (sriov_ctrl & PCI_SRIOV_CTRL_VFE) ? sriov_num_vf : 0;
 		}
 		pci_offset = PCI_EXT_CAP_NEXT(pci_cfg_data);
 	}
 	return retval;
 }
 
 static void top_build_vi_program(struct umr_asic *asic)
 {
+	const char *gfx_prefix;
+	const char *vcn_prefix;
 	int i, j, k;
 	char *regname;
 
+	gfx_prefix = "mm";
+	struct umr_ip_block* gfx = umr_find_ip_block(asic, "gfx", asic->options.vm_partition);
+	if (gfx && gfx->discoverable.maj >= 11)
+		gfx_prefix = "reg";
+
+	vcn_prefix = "mm";
+	struct umr_ip_block* vcn = umr_find_ip_block(asic, "vcn", asic->options.vm_partition);
+	if (vcn && ((vcn->discoverable.maj == 2 && vcn->discoverable.min >= 6) || vcn->discoverable.maj >= 4))
+		vcn_prefix = "reg";
+
 	stat_counters[0].bits = &stat_grbm_bits[0];
 	stat_counters[0].opt = &top_options.vi.grbm;
 	stat_counters[0].tag = "GRBM";
 
-	stat_counters[1].opt = &top_options.vi.grbm;
-	stat_counters[1].tag = stat_counters[0].tag;
-	stat_counters[1].name = "mmGRBM_STATUS2";
-	stat_counters[1].bits = &stat_grbm2_bits[0];
+	// which SE to read ...
+	if (options.use_bank == 1)
+		snprintf(stat_counters[0].name, sizeof(stat_counters[0].name), gfx_prefix, "GRBM_STATUS_SE%d", options.bank.grbm.se);
+	else
+		snprintf(stat_counters[0].name, sizeof(stat_counters[0].name), gfx_prefix, "GRBM_STATUS");
+
+	i = 1;
 
-	i = 2;
+	ENTRY(i++, gfx_prefix, "GRBM_STATUS2", &stat_grbm2_bits[0], &top_options.vi.grbm, "GRBM");
 
 	top_options.sriov.active_vf = -1;
 	top_options.sriov.num_vf = sriov_supported_vf(asic);
 	if (top_options.sriov.num_vf != 0) {
 		stat_counters[i].is_sensor = 3;
-		ENTRY(i++, "mmRLC_GPU_IOV_ACTIVE_FCN_ID", &stat_rlc_iov_bits[0],
+		ENTRY(i++, gfx_prefix, "RLC_GPU_IOV_ACTIVE_FCN_ID", &stat_rlc_iov_bits[0],
 			&top_options.vi.grbm, "GPU_IOV");
 	}
 
 	if (asic->config.gfx.family > 110)
-		ENTRY(i++, "mmRLC_GPM_STAT", &stat_rlc_gpm_bits[0], &top_options.vi.gfxpwr, "GFX PWR");
+		ENTRY(i++, gfx_prefix, "RLC_GPM_STAT", &stat_rlc_gpm_bits[0], &top_options.vi.gfxpwr, "GFX PWR");
 
 	// sensors
 	if (asic->family >= FAMILY_NV) {
 		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_nv_sensor_bits[0], &top_options.vi.sensors, "Sensors");
 	} else if (asic->config.gfx.family == 141 || asic->config.gfx.family == 142) {
 		// Arctic Island Family/Raven
 		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_ai_sensor_bits[0], &top_options.vi.sensors, "Sensors");
 	} else if (asic->config.gfx.family == 135) {
 		// Carrizo/Stoney family
 		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_carrizo_sensor_bits[0], &top_options.vi.sensors, "Sensors");
@@ -1013,80 +1029,71 @@ static void top_build_vi_program(struct umr_asic *asic)
 	} else if (asic->config.gfx.family == 120) {
 		// CIK
 		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_cik_sensor_bits[0], &top_options.vi.sensors, "Sensors");
 	} else if (asic->config.gfx.family == 110) {
 		// SI
 		ENTRY_SENSOR(i++, "GFX_SCLK", &stat_si_sensor_bits[0], &top_options.vi.sensors, "Sensors");
 	}
 	sensor_bits = stat_counters[i-1].bits;
 
 	// More GFX bits
-	ENTRY(i++, "mmTA_STATUS", &stat_ta_bits[0], &top_options.vi.ta, "TA");
+	ENTRY(i++, gfx_prefix, "TA_STATUS", &stat_ta_bits[0], &top_options.vi.ta, "TA");
 
 	// VGT bits only valid for gfx7..9
 	if (asic->family < FAMILY_NV)
-		ENTRY(i++, "mmVGT_CNTL_STATUS", &stat_vgt_bits[0], &top_options.vi.vgt, "VGT");
+		ENTRY(i++, gfx_prefix, "VGT_CNTL_STATUS", &stat_vgt_bits[0], &top_options.vi.vgt, "VGT");
 
 	// UVD registers
 		if (asic->family < FAMILY_AI)
-			ENTRY(i++, "mmSRBM_STATUS", &stat_srbm_status_uvd_bits[0], &top_options.vi.uvd, "UVD");
+			ENTRY(i++, gfx_prefix, "SRBM_STATUS", &stat_srbm_status_uvd_bits[0], &top_options.vi.uvd, "UVD");
 		k = i;
-		ENTRY(i++, "mmUVD_CGC_STATUS", &stat_uvdclk_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_CGC_STATUS", &stat_uvdclk_bits[0], &top_options.vi.uvd, "UVD");
 		// set PG flag for all UVD registers
 		for (; k < i; k++) {
 			stat_counters[k].addr_mask = REG_USE_PG_LOCK;  // UVD requires PG lock
 		}
 
 		k = j = i;
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE1", &stat_uvd_pgfsm1_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE2", &stat_uvd_pgfsm2_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE3", &stat_uvd_pgfsm3_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE4", &stat_uvd_pgfsm4_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE5", &stat_uvd_pgfsm5_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE6", &stat_uvd_pgfsm6_bits[0], &top_options.vi.uvd, "UVD");
-		ENTRY(i++, "mmUVD_PGFSM_READ_TILE7", &stat_uvd_pgfsm7_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE1", &stat_uvd_pgfsm1_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE2", &stat_uvd_pgfsm2_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE3", &stat_uvd_pgfsm3_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE4", &stat_uvd_pgfsm4_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE5", &stat_uvd_pgfsm5_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE6", &stat_uvd_pgfsm6_bits[0], &top_options.vi.uvd, "UVD");
+		ENTRY(i++, vcn_prefix, "UVD_PGFSM_READ_TILE7", &stat_uvd_pgfsm7_bits[0], &top_options.vi.uvd, "UVD");
 
 		// set compare/mask for UVD TILE registers
 		for (; j < i; j++) {
 			stat_counters[j].cmp[0] = 0;
 			stat_counters[j].mask[0] = 3;
 			stat_counters[j].addr_mask = REG_USE_PG_LOCK;  // require PG lock
 		}
 
 	// VCE registers
 		if (asic->family < FAMILY_AI)
-			ENTRY(i++, "mmSRBM_STATUS2", &stat_srbm_status2_vce_bits[0], &top_options.vi.vce, "VCE");
+			ENTRY(i++, gfx_prefix, "SRBM_STATUS2", &stat_srbm_status2_vce_bits[0], &top_options.vi.vce, "VCE");
 		k = i;
 
 		// set PG flag for all VCE registers
 		for (; k < i; k++) {
 			stat_counters[k].addr_mask = REG_USE_PG_LOCK;  // VCE requires PG lock
 		}
 
 	// memory hub
 		k = i;
 		if (asic->family < FAMILY_AI)
-			ENTRY(i++, "mmMC_HUB_MISC_STATUS", &stat_mc_hub_bits[0], &top_options.vi.memory_hub, "MC HUB");
+			ENTRY(i++, gfx_prefix, "MC_HUB_MISC_STATUS", &stat_mc_hub_bits[0], &top_options.vi.memory_hub, "MC HUB");
 
 	// SDMA
 		k = i;
 		if (asic->family < FAMILY_AI)
-			ENTRY(i++, "mmSRBM_STATUS2", &stat_sdma_bits[0], &top_options.vi.sdma, "SDMA");
-
-	// which SE to read ...
-	regname = calloc(1, 64);
-	if (options.use_bank == 1)
-		snprintf(regname, 63, "mmGRBM_STATUS_SE%d", options.bank.grbm.se);
-	else
-		snprintf(regname, 63, "mmGRBM_STATUS");
-
-	stat_counters[0].name = regname;
+			ENTRY(i++, gfx_prefix, "SRBM_STATUS2", &stat_sdma_bits[0], &top_options.vi.sdma, "SDMA");
 
 	top_options.handle_key = vi_handle_keys;
 	top_options.helptext =
 		"(u)vd v(c)e (G)FX_PWR (s)GRBM (t)a v(g)t (m)emory_hub \n"
 		"s(d)ma se(n)sors\n";
 
 }
 
 static void toggle_logger(void)
 {
@@ -1094,21 +1101,21 @@ static void toggle_logger(void)
 	top_options.logger ^= 1;
 
 	if (top_options.logger) {
 		char *p, name[512];
 		if (!(p = getenv("UMR_LOGGER")))
 			p = getenv("HOME");
 		sprintf(name, "%s/umr.log", p);
 		logfile = fopen(name, "a");
 
 		fprintf(logfile, "Time (seconds),");
-		for (i = 0; stat_counters[i].name; i++)
+		for (i = 0; stat_counters[i].name[0]; i++)
 			if (top_options.all || *stat_counters[i].opt)
 				for (j = 0; stat_counters[i].bits[j].regname != 0; j++)
 					fprintf(logfile, "%s.%s,", stat_counters[i].tag, stat_counters[i].bits[j].regname);
 		fprintf(logfile, "\n");
 	} else {
 		if (logfile)
 			fclose(logfile);
 		logfile = NULL;
 	}
 }
@@ -1163,25 +1170,25 @@ void umr_top(struct umr_asic *asic)
 	if (getenv("HOSTNAME")) strcpy(hostname, getenv("HOSTNAME"));
 
 	// init stats
 	memset(&stat_counters, 0, sizeof stat_counters);
 	load_options();
 
 	// select an architecture ...
 	top_build_vi_program(asic);
 
 	// add DRM info
-	for (i = 0; stat_counters[i].name; i++);
-	ENTRY(i, "DRM", &stat_drm_bits[0], &top_options.drm, "DRM");
+	for (i = 0; stat_counters[i].name[0]; i++);
+	ENTRY(i, "", "DRM", &stat_drm_bits[0], &top_options.drm, "DRM");
 	stat_counters[i].is_sensor = 2;
 
-	for (i = 0; stat_counters[i].name; i++) {
+	for (i = 0; stat_counters[i].name[0]; i++) {
 		if (stat_counters[i].is_sensor == 0)
 			grab_bits(stat_counters[i].name, asic, stat_counters[i].bits, &stat_counters[i].addr);
 		else if (stat_counters[i].is_sensor == 3)
 			grab_addr(stat_counters[i].name, asic, stat_counters[i].bits, &stat_counters[i].addr);
 	}
 
 	sensor_thread_quit = 0;
 
 	// start thread to grab sensor data
 	if (pthread_create(&sensor_thread, NULL, gpu_sensor_thread, asic)) {
@@ -1205,27 +1212,27 @@ void umr_top(struct umr_asic *asic)
 	// setup loop
 	if (top_options.high_precision)
 		rep = 1000;
 	else
 		rep = 100;
 	req.tv_sec = 0;
 	req.tv_nsec = 1000000000/rep; // 10ms
 
 	ts = 0;
 	while (!top_options.quit) {
-		for (i = 0; stat_counters[i].name; i++)
+		for (i = 0; stat_counters[i].name[0]; i++)
 			memset(stat_counters[i].counts, 0, sizeof(stat_counters[i].counts[0])*32);
 
 		for (i = 0; i < (int)rep / (top_options.high_frequency ? 10 : 1); i++) {
 			if (!top_options.sriov.num_vf || top_options.sriov.active_vf < 0 ||
 				top_options.sriov.active_vf == get_active_vf(asic, stat_counters[2].addr)) {
-				for (j = 0; stat_counters[j].name; j++) {
+				for (j = 0; stat_counters[j].name[0]; j++) {
 					if (top_options.all || *stat_counters[j].opt) {
 						if (stat_counters[j].is_sensor == 0)
 							parse_bits(asic, stat_counters[j].addr, stat_counters[j].bits, stat_counters[j].counts, stat_counters[j].mask, stat_counters[j].cmp, stat_counters[j].addr_mask);
 						else if (i == 0 && stat_counters[j].is_sensor == 1) // only parse sensors on first go-around per display
 							parse_sensors(asic, stat_counters[j].addr, stat_counters[j].bits, stat_counters[j].counts, stat_counters[j].mask, stat_counters[j].cmp, stat_counters[j].addr_mask);
 						else if (i == 0 && stat_counters[j].is_sensor == 2) // only parse drm on first go-around per display
 							parse_drm(asic, stat_counters[j].addr, stat_counters[j].bits, stat_counters[j].counts, stat_counters[j].mask, stat_counters[j].cmp, stat_counters[j].addr_mask);
 						else if (stat_counters[j].is_sensor == 3)
 							parse_iov(asic, stat_counters[j].addr, stat_counters[j].bits, stat_counters[j].counts, stat_counters[j].mask, stat_counters[j].cmp, stat_counters[j].addr_mask);
 					}
@@ -1286,34 +1293,34 @@ void umr_top(struct umr_asic *asic)
 		tt = time(NULL);
 		printw("(%s[%s]) %s%s -- %s",
 			hostname, asic->asicname,
 			top_options.logger ? "(logger enabled) " : "",
 			top_options.high_frequency ?
 				(top_options.high_precision ? "(sample @ 1ms, report @ 100ms)" : "(sample @ 10ms, report @ 100ms)") :
 				(top_options.high_precision ? "(sample @ 1ms, report @ 1000ms)" : "(sample @ 10ms, report @ 1000ms)"),
 			ctime(&tt));
 
 		// figure out padding
-		for (i = maxstrlen = 0; stat_counters[i].name; i++)
+		for (i = maxstrlen = 0; stat_counters[i].name[0]; i++)
 			if (top_options.all || *stat_counters[i].opt)
 				for (j = 0; stat_counters[i].bits[j].regname; j++)
 					if (stat_counters[i].bits[j].start != 255 && (k = strlen(stat_counters[i].bits[j].regname)) > maxstrlen)
 						maxstrlen = k;
 		snprintf(namefmt, sizeof(namefmt)-1, "%%%ds => ", maxstrlen + 1);
 
 		print_j = 0;
 		if (logfile != NULL) {
 			struct timespec tp;
 			clock_gettime(CLOCK_MONOTONIC, &tp);
 			fprintf(logfile, "%f,", ((double)tp.tv_sec * 1000000000.0 + tp.tv_nsec) / 1000000000.0);
 		}
-		for (i = 0; stat_counters[i].name; i++) {
+		for (i = 0; stat_counters[i].name[0]; i++) {
 			if (top_options.all || *stat_counters[i].opt) {
 				if (logfile != NULL) {
 					for (j = 0; stat_counters[i].bits[j].regname != 0; j++) {
 						if (stat_counters[i].bits[j].start != 255)
 							fprintf(logfile, "%llu,", (unsigned long long)stat_counters[i].counts[j]);
 					}
 				}
 				if (!i || strcmp(stat_counters[i-1].tag, stat_counters[i].tag)) {
 					if (print_j & (top_options.wide ? 3 : 1))
 						printw("\n");
-- 
2.40.0

