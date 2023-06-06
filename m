Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41527C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C176410E320;
	Tue,  6 Jun 2023 09:18:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9593510E308
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Olwpbf8DjIP06FCb3JKERVVFdT7E0pU/NJXFYei9xpLyOifERnfC468RZi1XH1W0RhchvB/6Uffz7DrSsqyAyQrLfj1VR92oMJNm0cN8Jj6/jW2pBQ51HnIbkgNcgWlppGNSvz+be7AfOH6MYIBzw3t9FwA1EoIP3hyP5cUOeWFmJlEbXqNprg3iKlVbRiJ3m2J4gYNjp9VPnjHAKUSMIjgRWCWeKuAg4MuR+P9VIkFqYoL/NF+QrVU3UBed1dCB6cE1hvOCjwpXFC86ExfhJw87oG9N4M2+Fd9jul1L8q1ycuMa9c79RpAbUdpdIm2Oq02sIduGOmbeFya61IrYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Y+TE4hbxCNuh77BfQ8Qfl1EdhnT+JVJ1yErYsRL5M=;
 b=XLh9vlg+IGiMFfLwxzVTVISS+WUYHvTbAnMTnmrSHNqMAWpQM5dBZt1vMoDwX7EWjCKM6hTs0mTP5NVq0EaiA/5PFjJjiz5bq2wKsOAzbwE3kNtt0DOU6fqWo/PtpMd2PSCdcKb6bH62BD0aaZgpob53r6evXZRfP/F1oKRHfQIKEovpe6v925zG7Mr3gF2CrWKqTlMu26+g7EYElN1RWUAXDpji8ohX0N5YeU3bt/DXPOlveMdBtBRp6v6HBb1Pdcbgpjj+Oc7JcCSQxoUhwErcNDM0kUSC0WTNVDwxEKVDmn5ZnUfKlQlKIfDLuBvJGCWUcJCiFNwdchaTSI093A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Y+TE4hbxCNuh77BfQ8Qfl1EdhnT+JVJ1yErYsRL5M=;
 b=n/oL98ytUN6EiAzwWOqsheJfaibg/2VGWfGvMu32Y2STYudW1kgfiM7SCpH3Me+cww3MpTlQY+o8dS/31L47E6MK38zZ9g1kz6qOw6w/JmBhfRt4aDaMk3eJsgMOVDGewrHI/DVDeMUCQAKRFMfGIMDLS6Q7F0zjQHkXBgIqrYw=
Received: from MW4PR03CA0186.namprd03.prod.outlook.com (2603:10b6:303:b8::11)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:18:00 +0000
Received: from CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::8) by MW4PR03CA0186.outlook.office365.com
 (2603:10b6:303:b8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 09:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT087.mail.protection.outlook.com (10.13.174.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.34 via Frontend Transport; Tue, 6 Jun 2023 09:17:59 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:58 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 15/17] Add umr_sq_cmd_singlestep
Date: Tue, 6 Jun 2023 11:17:23 +0200
Message-ID: <20230606091725.20080-16-nicolai.haehnle@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT087:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: ba987082-dad1-4d01-2a7d-08db666eec4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BicF5xJjXUru9Fc+itVbvRGdoPDQlCpozH8SAo2YMTkdeEAUmrutbzL2UzKEW57iAJxpyuejt9SBOQgWlwkoxVmzUGZi7qmtdPwnt1vks9SKB3/Jtdeb5RM8n/DFyrrrBqh6zGXuVgVoPaHoLY3a40eTw/BRLTSK2+bovdR7bQXe7lk/e5SGF+hn7lg7UvnuzsNZnOrZUJGvZ0gzKbX4B0CAQkddp72N5n5ggiOyc3cHE95zjGEmC8sRWqcb7+gYCueCh40qtZsS/GM+Sk/WNEv3iJ6lo1qJHlYms1f3hj+j5Tgi5IsqmTPWYS9I4ddP4HhVgCWcPb6LyvEV/Dp6T8htiGYv2V0eBsW0q9V3NNJMamXQobsyS2HUe5Uv8EBbwlAnISD5TULEvi9LPVRF87Pry1UsmfKn/bajZEPJtMNzpMj8j23oj+qotLqJ6xPQbArZq5QRiWg0pWNUw5oJpxSd+1itzlctSv1/9aji/DnAvmc7O85/Up8FwGWWD/nKzUtUUUxYb/E1RaJhEPKObbDoGXIsk/IdQEZj4XZcXUIzN0jwahuzHsd9QzcdnkZaa3PVwRLxy5zaorK4e6mZKSrD2+wlPt2ZmFvRdDMoL9dv7rqxX90j6UV3c294xqO8rRmUxbpcHUg447AFpxX5FljisLxA1aR46/PUsxVNlOiPkx8YL1HvL6Sr4eiPjT0Tu0FNqqap3+vHzs1qWGIT3jdRf8HjFYUirrOEqChKXtE8Zy+qHiSZphixzD35FnupMRPNEUHV4yIVz6LKDzlOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(66574015)(426003)(47076005)(2906002)(336012)(83380400001)(2616005)(82310400005)(86362001)(36756003)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(110136005)(478600001)(70206006)(70586007)(4326008)(66899021)(6636002)(1076003)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:59.8632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba987082-dad1-4d01-2a7d-08db666eec4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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

Allow single-stepping a wave that is selected by HW ID.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/sq_cmd_halt_waves.c | 75 ++++++++++++++++++++++++++++++++-----
 src/umr.h                   |  1 +
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/src/lib/sq_cmd_halt_waves.c b/src/lib/sq_cmd_halt_waves.c
index 841b1d3..9a0ae69 100644
--- a/src/lib/sq_cmd_halt_waves.c
+++ b/src/lib/sq_cmd_halt_waves.c
@@ -17,45 +17,51 @@
  * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
  * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  * Authors: Tom St Denis <tom.stdenis@amd.com>
  *
  */
 #include "umr.h"
 
+static struct umr_reg *find_sq_cmd(struct umr_asic *asic)
+{
+	// SQ_CMD is not present on SI
+	if (asic->family == FAMILY_SI)
+		return 0;
+
+	struct umr_reg *reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
+						  asic->family >= FAMILY_GFX11 ? "regSQ_CMD" : "mmSQ_CMD");
+	if (!reg)
+		asic->err_msg("[BUG]: Cannot find SQ_CMD register in umr_sq_cmd_halt_waves()\n");
+	return reg;
+}
+
 /**
  * umr_sq_cmd_halt_waves - Attempt to halt or resume waves
  *
  * @mode:	Use UMR_SQ_CMD_HALT to halt waves and
  * 			UMR_SQ_CMD_RESUME to resume waves.
  */
 int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mode)
 {
 	struct umr_reg *reg;
 	uint32_t value;
 	uint64_t addr;
 	struct {
 		uint32_t se, sh, instance, use_grbm;
 	} grbm;
 
-	// SQ_CMD is not present on SI
-	if (asic->family == FAMILY_SI)
-		return 0;
-
-	reg = umr_find_reg_data_by_ip_by_instance(asic, "gfx", asic->options.vm_partition,
-						  asic->family >= FAMILY_GFX11 ? "regSQ_CMD" : "mmSQ_CMD");
-	if (!reg) {
-		asic->err_msg("[BUG]: Cannot find SQ_CMD register in umr_sq_cmd_halt_waves()\n");
+	reg = find_sq_cmd(asic);
+	if (!reg)
 		return -1;
-	}
 
 	// compose value
 	if (asic->family == FAMILY_CIK) {
 		value = umr_bitslice_compose_value(asic, reg, "CMD", mode == UMR_SQ_CMD_HALT ? 1 : 2); // SETHALT
 	} else {
 		value = umr_bitslice_compose_value(asic, reg, "CMD", 1); // SETHALT
 		value |= umr_bitslice_compose_value(asic, reg, "DATA", mode == UMR_SQ_CMD_HALT ? 1 : 0);
 	}
 	value |= umr_bitslice_compose_value(asic, reg, "MODE", 1); // BROADCAST
 
@@ -76,10 +82,61 @@ int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mod
 	asic->reg_funcs.write_reg(asic, addr, value, reg->type);
 
 	/* restore whatever the user had picked */
 	asic->options.use_bank           = grbm.use_grbm;
 	asic->options.bank.grbm.se       = grbm.se;
 	asic->options.bank.grbm.sh       = grbm.sh;
 	asic->options.bank.grbm.instance = grbm.instance;
 
 	return 0;
 }
+
+/**
+ * umr_sq_cmd_singlestep - Attempt to single-step a single wave
+ *
+ * The wave is assumed to be halted.
+ */
+int umr_sq_cmd_singlestep(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t wgp, uint32_t simd, uint32_t wave)
+{
+	struct umr_reg *reg;
+	uint32_t value;
+	uint64_t addr;
+	struct {
+		uint32_t se, sh, instance, use_grbm;
+	} grbm;
+
+	if (asic->family < FAMILY_NV)
+		return -1; // Only supported on gfx10+
+
+	reg = find_sq_cmd(asic);
+	if (!reg)
+		return -1;
+
+	// compose value
+	value = umr_bitslice_compose_value(asic, reg, "CMD", 8); // SINGLE_STEP
+	value |= umr_bitslice_compose_value(asic, reg, "MODE", 0); // single wave
+	value |= umr_bitslice_compose_value(asic, reg, "WAVE_ID", wave);
+
+	/* copy grbm options to restore later */
+	grbm.use_grbm = asic->options.use_bank;
+	grbm.se       = asic->options.bank.grbm.se;
+	grbm.sh       = asic->options.bank.grbm.sh;
+	grbm.instance = asic->options.bank.grbm.instance;
+
+	/* set GRBM banking options */
+	asic->options.use_bank           = 1;
+	asic->options.bank.grbm.se       = se;
+	asic->options.bank.grbm.sh       = sh;
+	asic->options.bank.grbm.instance = (wgp << 2) | simd;
+
+	// compose address
+	addr = reg->addr * 4;
+	asic->reg_funcs.write_reg(asic, addr, value, reg->type);
+
+	/* restore whatever the user had picked */
+	asic->options.use_bank           = grbm.use_grbm;
+	asic->options.bank.grbm.se       = grbm.se;
+	asic->options.bank.grbm.sh       = grbm.sh;
+	asic->options.bank.grbm.instance = grbm.instance;
+
+	return 0;
+}
diff --git a/src/umr.h b/src/umr.h
index 616b9cc..8981986 100644
--- a/src/umr.h
+++ b/src/umr.h
@@ -1466,20 +1466,21 @@ uint64_t umr_bitslice_compose_value_by_name_by_ip_by_instance(struct umr_asic *a
 
 // bank switching
 uint64_t umr_apply_bank_selection_address(struct umr_asic *asic);
 
 // select a GRBM_GFX_IDX
 int umr_grbm_select_index(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t instance);
 int umr_srbm_select_index(struct umr_asic *asic, uint32_t me, uint32_t pipe, uint32_t queue, uint32_t vmid);
 
 // halt/resume SQ waves
 int umr_sq_cmd_halt_waves(struct umr_asic *asic, enum umr_sq_cmd_halt_resume mode);
+int umr_sq_cmd_singlestep(struct umr_asic *asic, uint32_t se, uint32_t sh, uint32_t wgp, uint32_t simd, uint32_t wave);
 
 /* IB/ring decoding/dumping/etc */
 enum umr_ring_type {
 	UMR_RING_PM4,
 	UMR_RING_PM4_LITE,
 	UMR_RING_SDMA,
 	UMR_RING_MES,
 
 	UMR_RING_GUESS,
 	UMR_RING_UNK=0xFF, // if unknown
-- 
2.40.0

