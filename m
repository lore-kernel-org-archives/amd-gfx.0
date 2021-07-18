Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BCCC636CD
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB3461182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB3461182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF6189E0C;
	Sun, 18 Jul 2021 14:06:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9EA789DE3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odYxfEzeaQPAj5SrxF3XDV/qAQ8GQNKzMLYXxtpLvM8fea9jOwHMp83C2SsDrV6zCaYKUBhfb2fMwzwpWecIbRZChHACUmA5NNRkcJUiFwnsCwrRRJrnS8xvzU/y66eUwTx+8Fmoy0NVY3+CWVrjgf8EOY+HolDealRscn3qMnk0AFrxFjHiKtyHctF1KdtWwmdVYu86sqzco8Sl9MniEiuQXXLkM8tpTZQnbd9qSMHuSPe7OLCKMFXrvRpha1Da4P8oC2rcJuo98aQLPSk1whZFAZwDHizAuMpuTGEVurPQb8ikAjzyhGPINeufv9I2Ey0Q41kSMN+BDPAaL5DexA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBLSSf+73+nyCWmQHE3geHHTmikJOHyLRVH2bfnHoJQ=;
 b=lE44srvgaMCNA5M5DdfLE6ESiBfOsVavpkzXYozAhsXxaoCi/DRodc+ajFybUfp3VAvRnxuB8Q1adYMtYNdy47KG/J3H9nNJ5onzcFXP8a+qndpp5sMfFnaGaXHThpN+G5mbujZVCRGKB5gMkSf4XIpwm2MPn7xOAtfLI8/l05PvwDB1+aoljMTbxkaa6XIG9llTQJjS4RZyDALyS6NF74ixIuelx+CG1uWa6VZnUOU1nUnj/3vTy7jluf5Z9PG/TY7k+DsH8GmWz3Wg4WX1544hYsH5u2iEIP28QX5lRwFfmkG+ir0uac9JJNCpeUZWWr6jHQ0koFTjz7+W2uwuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBLSSf+73+nyCWmQHE3geHHTmikJOHyLRVH2bfnHoJQ=;
 b=zaVLQg8UqFrh3F8vQUyLpIIVKHd5RSY4JXqTuA9LhlAf/ZJd9c/EHyTiVIURiX8jboWDZub9hljqVua1Pj/6cdkwWiaoGF2EtiVKWX3gJQLfGIx9q+XXNlapbvlWi0G68gVDNP6elx6Vw1H4dTN3YM/AYg/BnD0+OPTGb46QTI4=
Received: from MW3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:303:2b::24)
 by BY5PR12MB5512.namprd12.prod.outlook.com (2603:10b6:a03:1df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:28 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::fd) by MW3PR05CA0019.outlook.office365.com
 (2603:10b6:303:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:27 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:25 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/32] drm/amd/display: log additional register state for debug
Date: Sun, 18 Jul 2021 10:05:43 -0400
Message-ID: <20210718140610.1584616-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c3166ea-d33b-4d7f-fb2a-08d949f53c85
X-MS-TrafficTypeDiagnostic: BY5PR12MB5512:
X-Microsoft-Antispam-PRVS: <BY5PR12MB5512EBBFD2023E31F9D4E32F98E09@BY5PR12MB5512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:16;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epe9Ccf7TWncWYJSC2gg/vzpshVD0mRlXqruXEyvTNOGoHa5uK7q/dX4hG1Jgq+7lPM/d+Fv/On++vM2biEKcEUUK3Xticg9e+wXGnaTr1axyoWUr3c/642PAZJ2VG80ETauN6wXHLbN2bs0a/oErA5GHSntU6vWrqin9emn3eFE/xCnbSb3ULzq80IIwPP8hQmoj8NbjWt881ClHG34ktLvcYvybyrriSPYMDitwqhTMjrapfnjYlvgpPqBz/iuO8NDvYLSlOJoq7xxbPLuYWjUIVirQW8vFU9uHl2ZQk14OZAYw/uQfDpwTvAsItL3hBIEjFjU96aUYNvjXGbkcY2qjFkHp1nLigCnro+cdnF3Akoe0N3Y3ZItUv0tc8em62VhQQUcoqYeyInD5MdYrcH81PocHwBCycEJpf4VLqyWVltw2cPFkohXkiIg2HGRxHXm+dMRG9fadwsU8C38A3ypUcGqytKDKYTYSvMknlrTp8Fq4GZqBHXu2zsk0FVnOIp51Oc6d4/YdjUqW483fn6Fps7KP3h52EEPwDeyKJz3XXR2HMV8aEzQXvAo/dLdFVHOEwO7Ge+ubhFNv3bHqMKmdW2FoGY+cRn3xgrKsPjXiYmjM/HTYpXaQ8ugzocovMRCSa2uNWScQn9vNeeKUb7zdYG05LEEj+rlVK4WYX+YrPFM6u8nKmHTrfp0h9PT0ingjJSo3Ll9RANGKjB6NXq6wbHS10g6CYO6/FtQFkU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(36840700001)(46966006)(86362001)(82310400003)(81166007)(36860700001)(478600001)(356005)(82740400003)(6916009)(1076003)(70586007)(47076005)(186003)(8676002)(16526019)(26005)(70206006)(2906002)(36756003)(30864003)(5660300002)(2616005)(6666004)(4326008)(336012)(83380400001)(316002)(54906003)(8936002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:27.9145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3166ea-d33b-4d7f-fb2a-08d949f53c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5512
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Extend existing state collection functions to add some additional
registers useful for debug, and add state collection function for DC
hubbub

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   | 18 +++++++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 29 ++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 +++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  6 ++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   | 21 ++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   | 33 ++++++++++++-------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 17 ++++++++++
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   | 14 +++++++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   | 14 +++++++-
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |  1 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |  3 +-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   | 14 +++++++-
 .../amd/display/dc/dml/display_mode_structs.h |  2 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 11 +++++++
 18 files changed, 175 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index 8d7e92d5d3e4..32fb22daf4a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -121,6 +121,10 @@ struct dcn_hubbub_registers {
 	uint32_t DCN_VM_AGP_BASE;
 	uint32_t DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB;
 	uint32_t DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB;
+	uint32_t DCN_VM_FAULT_ADDR_MSB;
+	uint32_t DCN_VM_FAULT_ADDR_LSB;
+	uint32_t DCN_VM_FAULT_CNTL;
+	uint32_t DCN_VM_FAULT_STATUS;
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_NOM_A;
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_NOM_B;
 	uint32_t DCHUBBUB_ARB_FRAC_URG_BW_NOM_C;
@@ -233,7 +237,19 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C;\
 		type DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D;\
 		type DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB;\
-		type DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB
+		type DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB;\
+		type DCN_VM_FAULT_ADDR_MSB;\
+		type DCN_VM_FAULT_ADDR_LSB;\
+		type DCN_VM_ERROR_STATUS_CLEAR;\
+		type DCN_VM_ERROR_STATUS_MODE;\
+		type DCN_VM_ERROR_INTERRUPT_ENABLE;\
+		type DCN_VM_RANGE_FAULT_DISABLE;\
+		type DCN_VM_PRQ_FAULT_DISABLE;\
+		type DCN_VM_ERROR_STATUS;\
+		type DCN_VM_ERROR_VMID;\
+		type DCN_VM_ERROR_TABLE_LEVEL;\
+		type DCN_VM_ERROR_PIPE;\
+		type DCN_VM_ERROR_INTERRUPT_STATUS
 
 #define HUBBUB_STUTTER_REG_FIELD_LIST(type) \
 		type DCHUBBUB_ARB_ALLOW_SR_ENTER_WATERMARK_A;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index 04303fe9c659..ea185c877323 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -871,6 +871,8 @@ void hubp1_read_state_common(struct hubp *hubp)
 	struct _vcs_dpi_display_dlg_regs_st *dlg_attr = &s->dlg_attr;
 	struct _vcs_dpi_display_ttu_regs_st *ttu_attr = &s->ttu_attr;
 	struct _vcs_dpi_display_rq_regs_st *rq_regs = &s->rq_regs;
+	uint32_t aperture_low_msb, aperture_low_lsb;
+	uint32_t aperture_high_msb, aperture_high_lsb;
 
 	/* Requester */
 	REG_GET(HUBPRET_CONTROL,
@@ -881,6 +883,22 @@ void hubp1_read_state_common(struct hubp *hubp)
 			MRQ_EXPANSION_MODE, &rq_regs->mrq_expansion_mode,
 			CRQ_EXPANSION_MODE, &rq_regs->crq_expansion_mode);
 
+	REG_GET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR_MSB,
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR_MSB, &aperture_low_msb);
+
+	REG_GET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR_LSB,
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR_LSB, &aperture_low_lsb);
+
+	REG_GET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR_MSB,
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR_MSB, &aperture_high_msb);
+
+	REG_GET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR_LSB,
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR_LSB, &aperture_high_lsb);
+
+	// On DCN1, aperture is broken down into MSB and LSB; only keep bits [47:18] to match later DCN format
+	rq_regs->aperture_low_addr = (aperture_low_msb << 26) | (aperture_low_lsb >> 6);
+	rq_regs->aperture_high_addr = (aperture_high_msb << 26) | (aperture_high_lsb >> 6);
+
 	/* DLG - Per hubp */
 	REG_GET_2(BLANK_OFFSET_0,
 		REFCYC_H_BLANK_END, &dlg_attr->refcyc_h_blank_end,
@@ -1037,6 +1055,17 @@ void hubp1_read_state_common(struct hubp *hubp)
 			QoS_LEVEL_LOW_WM, &s->qos_level_low_wm,
 			QoS_LEVEL_HIGH_WM, &s->qos_level_high_wm);
 
+	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS,
+			PRIMARY_SURFACE_ADDRESS, &s->primary_surface_addr_lo);
+
+	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH,
+			PRIMARY_SURFACE_ADDRESS, &s->primary_surface_addr_hi);
+
+	REG_GET(DCSURF_PRIMARY_META_SURFACE_ADDRESS,
+			PRIMARY_META_SURFACE_ADDRESS, &s->primary_meta_addr_lo);
+
+	REG_GET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH,
+			PRIMARY_META_SURFACE_ADDRESS, &s->primary_meta_addr_hi);
 }
 
 void hubp1_read_state(struct hubp *hubp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index e2f2f6995935..9cb8c383d673 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -682,6 +682,10 @@ struct dcn_hubp_state {
 	uint32_t min_ttu_vblank;
 	uint32_t qos_level_low_wm;
 	uint32_t qos_level_high_wm;
+	uint32_t primary_surface_addr_lo;
+	uint32_t primary_surface_addr_hi;
+	uint32_t primary_meta_addr_lo;
+	uint32_t primary_meta_addr_hi;
 };
 
 struct dcn10_hubp {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 3696faf12d86..37848f4577b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1388,6 +1388,12 @@ void optc1_read_otg_state(struct optc *optc1,
 
 	REG_GET(OPTC_INPUT_GLOBAL_CONTROL,
 			OPTC_UNDERFLOW_OCCURRED_STATUS, &s->underflow_occurred_status);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT2_CONTROL,
+			OTG_VERTICAL_INTERRUPT2_INT_ENABLE, &s->vertical_interrupt2_en);
+
+	REG_GET(OTG_VERTICAL_INTERRUPT2_POSITION,
+			OTG_VERTICAL_INTERRUPT2_LINE_START, &s->vertical_interrupt2_line);
 }
 
 bool optc1_get_otg_active_size(struct timing_generator *optc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
index 29d6fbe0093a..c50c29984d51 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h
@@ -578,6 +578,8 @@ struct dcn_otg_state {
 	uint32_t underflow_occurred_status;
 	uint32_t otg_enabled;
 	uint32_t blank_enabled;
+	uint32_t vertical_interrupt2_en;
+	uint32_t vertical_interrupt2_line;
 };
 
 void optc1_read_otg_state(struct optc *optc1,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 91a9305d42e8..aacb1fb5c73e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -605,6 +605,26 @@ static bool hubbub2_program_watermarks(
 	return wm_pending;
 }
 
+void hubbub2_read_state(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_state)
+{
+	struct dcn20_hubbub *hubbub1 = TO_DCN20_HUBBUB(hubbub);
+
+	if (REG(DCN_VM_FAULT_ADDR_MSB))
+		hubbub_state->vm_fault_addr_msb = REG_READ(DCN_VM_FAULT_ADDR_MSB);
+
+	if (REG(DCN_VM_FAULT_ADDR_LSB))
+		hubbub_state->vm_fault_addr_msb = REG_READ(DCN_VM_FAULT_ADDR_LSB);
+
+	if (REG(DCN_VM_FAULT_CNTL))
+		REG_GET(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, &hubbub_state->vm_error_mode);
+
+	if (REG(DCN_VM_FAULT_STATUS)) {
+		 REG_GET(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, &hubbub_state->vm_error_status);
+		 REG_GET(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, &hubbub_state->vm_error_vmid);
+		 REG_GET(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, &hubbub_state->vm_error_pipe);
+	}
+}
+
 static const struct hubbub_funcs hubbub2_funcs = {
 	.update_dchub = hubbub2_update_dchub,
 	.init_dchub_sys_ctx = hubbub2_init_dchub_sys_ctx,
@@ -617,6 +637,7 @@ static const struct hubbub_funcs hubbub2_funcs = {
 	.program_watermarks = hubbub2_program_watermarks,
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
+	.hubbub_read_state = hubbub2_read_state,
 };
 
 void hubbub2_construct(struct dcn20_hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
index 10af257d90ef..2f6146bf1d32 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
@@ -29,16 +29,6 @@
 #include "dcn10/dcn10_hubbub.h"
 #include "dcn20_vmid.h"
 
-#define HUBBUB_REG_LIST_DCN20_COMMON()\
-	HUBBUB_REG_LIST_DCN_COMMON(), \
-	SR(DCHUBBUB_CRC_CTRL), \
-	SR(DCN_VM_FB_LOCATION_BASE),\
-	SR(DCN_VM_FB_LOCATION_TOP),\
-	SR(DCN_VM_FB_OFFSET),\
-	SR(DCN_VM_AGP_BOT),\
-	SR(DCN_VM_AGP_TOP),\
-	SR(DCN_VM_AGP_BASE)
-
 #define TO_DCN20_HUBBUB(hubbub)\
 	container_of(hubbub, struct dcn20_hubbub, base)
 
@@ -50,7 +40,11 @@
 	SR(DCN_VM_FB_OFFSET),\
 	SR(DCN_VM_AGP_BOT),\
 	SR(DCN_VM_AGP_TOP),\
-	SR(DCN_VM_AGP_BASE)
+	SR(DCN_VM_AGP_BASE),\
+	SR(DCN_VM_FAULT_ADDR_MSB), \
+	SR(DCN_VM_FAULT_ADDR_LSB), \
+	SR(DCN_VM_FAULT_CNTL), \
+	SR(DCN_VM_FAULT_STATUS)
 
 #define HUBBUB_REG_LIST_DCN20(id)\
 	HUBBUB_REG_LIST_DCN20_COMMON(), \
@@ -71,7 +65,19 @@
 	HUBBUB_SF(DCN_VM_AGP_TOP, AGP_TOP, mask_sh), \
 	HUBBUB_SF(DCN_VM_AGP_BASE, AGP_BASE, mask_sh), \
 	HUBBUB_SF(DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB, DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_MSB, mask_sh), \
-	HUBBUB_SF(DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB, DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB, mask_sh)
+	HUBBUB_SF(DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB, DCN_VM_PROTECTION_FAULT_DEFAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_MSB, DCN_VM_FAULT_ADDR_MSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_LSB, DCN_VM_FAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_CLEAR, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_INTERRUPT_ENABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_RANGE_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_PRQ_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
 struct dcn20_hubbub {
 	struct hubbub base;
@@ -131,4 +137,7 @@ void hubbub2_get_dchub_ref_freq(struct hubbub *hubbub,
 void hubbub2_wm_read_state(struct hubbub *hubbub,
 		struct dcn_hubbub_wm *wm);
 
+void hubbub2_read_state(struct hubbub *hubbub,
+		struct dcn_hubbub_state *hubbub_state);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 7e54058715aa..5adf42a7cc27 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1080,6 +1080,12 @@ void hubp2_read_state_common(struct hubp *hubp)
 			MRQ_EXPANSION_MODE, &rq_regs->mrq_expansion_mode,
 			CRQ_EXPANSION_MODE, &rq_regs->crq_expansion_mode);
 
+	REG_GET(DCN_VM_SYSTEM_APERTURE_HIGH_ADDR,
+			MC_VM_SYSTEM_APERTURE_HIGH_ADDR, &rq_regs->aperture_high_addr);
+
+	REG_GET(DCN_VM_SYSTEM_APERTURE_LOW_ADDR,
+			MC_VM_SYSTEM_APERTURE_LOW_ADDR, &rq_regs->aperture_low_addr);
+
 	/* DLG - Per hubp */
 	REG_GET_2(BLANK_OFFSET_0,
 		REFCYC_H_BLANK_END, &dlg_attr->refcyc_h_blank_end,
@@ -1236,6 +1242,17 @@ void hubp2_read_state_common(struct hubp *hubp)
 			QoS_LEVEL_LOW_WM, &s->qos_level_low_wm,
 			QoS_LEVEL_HIGH_WM, &s->qos_level_high_wm);
 
+	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS,
+			PRIMARY_SURFACE_ADDRESS, &s->primary_surface_addr_lo);
+
+	REG_GET(DCSURF_PRIMARY_SURFACE_ADDRESS_HIGH,
+			PRIMARY_SURFACE_ADDRESS, &s->primary_surface_addr_hi);
+
+	REG_GET(DCSURF_PRIMARY_META_SURFACE_ADDRESS,
+			PRIMARY_META_SURFACE_ADDRESS, &s->primary_meta_addr_lo);
+
+	REG_GET(DCSURF_PRIMARY_META_SURFACE_ADDRESS_HIGH,
+			PRIMARY_META_SURFACE_ADDRESS, &s->primary_meta_addr_hi);
 }
 
 void hubp2_read_state(struct hubp *hubp)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index 42fbb5e6d505..36044cb8ec83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -701,6 +701,7 @@ static const struct hubbub_funcs hubbub21_funcs = {
 	.program_watermarks = hubbub21_program_watermarks,
 	.allow_self_refresh_control = hubbub1_allow_self_refresh_control,
 	.apply_DEDCN21_147_wa = hubbub21_apply_DEDCN21_147_wa,
+	.hubbub_read_state = hubbub2_read_state,
 };
 
 void hubbub21_construct(struct dcn20_hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
index ef3ef28509ed..d8eb2bb7282c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
@@ -108,7 +108,19 @@
 	HUBBUB_SF(DCN_VM_FB_OFFSET, FB_OFFSET, mask_sh), \
 	HUBBUB_SF(DCN_VM_AGP_BOT, AGP_BOT, mask_sh), \
 	HUBBUB_SF(DCN_VM_AGP_TOP, AGP_TOP, mask_sh), \
-	HUBBUB_SF(DCN_VM_AGP_BASE, AGP_BASE, mask_sh)
+	HUBBUB_SF(DCN_VM_AGP_BASE, AGP_BASE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_MSB, DCN_VM_FAULT_ADDR_MSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_LSB, DCN_VM_FAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_CLEAR, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_INTERRUPT_ENABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_RANGE_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_PRQ_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
 void dcn21_dchvm_init(struct hubbub *hubbub);
 int hubbub21_init_dchub(struct hubbub *hubbub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index b0c9180b808f..3de1bcf9b3d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -833,7 +833,7 @@ static struct hubp_funcs dcn21_hubp_funcs = {
 	.dmdata_set_attributes = hubp2_dmdata_set_attributes,
 	.dmdata_load = hubp2_dmdata_load,
 	.dmdata_status_done = hubp2_dmdata_status_done,
-	.hubp_read_state = hubp1_read_state,
+	.hubp_read_state = hubp2_read_state,
 	.hubp_clear_underflow = hubp1_clear_underflow,
 	.hubp_set_flip_control_surface_gsl = hubp2_set_flip_control_surface_gsl,
 	.hubp_init = hubp21_init,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
index c0980da6dc49..f4414de96acc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -451,6 +451,7 @@ static const struct hubbub_funcs hubbub30_funcs = {
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
 	.init_watermarks = hubbub3_init_watermarks,
+	.hubbub_read_state = hubbub2_read_state,
 };
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
index c0bd0fb09455..7b597908b937 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
@@ -87,7 +87,19 @@
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_A, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_B, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_C, mask_sh), \
-	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, mask_sh)
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, DCHUBBUB_ARB_VM_ROW_ALLOW_DRAM_CLK_CHANGE_WATERMARK_D, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_MSB, DCN_VM_FAULT_ADDR_MSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_LSB, DCN_VM_FAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_CLEAR, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_INTERRUPT_ENABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_RANGE_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_PRQ_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
 void hubbub3_construct(struct dcn20_hubbub *hubbub3,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
index a0b96b3c083f..1e3bd2e9cdcc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
@@ -62,6 +62,7 @@ static const struct hubbub_funcs hubbub301_funcs = {
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.force_wm_propagate_to_pipes = hubbub3_force_wm_propagate_to_pipes,
 	.force_pstate_change_control = hubbub3_force_pstate_change_control,
+	.hubbub_read_state = hubbub2_read_state,
 };
 
 void hubbub301_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index bb9648488900..b5a7fa67958b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -934,7 +934,8 @@ static const struct hubbub_funcs hubbub31_funcs = {
 	.is_allow_self_refresh_enabled = hubbub1_is_allow_self_refresh_enabled,
 	.program_det_size = dcn31_program_det_size,
 	.program_compbuf_size = dcn31_program_compbuf_size,
-	.init_crb = dcn31_init_crb
+	.init_crb = dcn31_init_crb,
+	.hubbub_read_state = hubbub2_read_state,
 };
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub31,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
index 8ec98cbcbd47..298858d8259b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
@@ -107,7 +107,19 @@
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_A, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_B, mask_sh), \
 	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_C, mask_sh), \
-	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh)
+	HUBBUB_SF(DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, DCHUBBUB_ARB_ALLOW_SR_EXIT_WATERMARK_Z8_D, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_MSB, DCN_VM_FAULT_ADDR_MSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_ADDR_LSB, DCN_VM_FAULT_ADDR_LSB, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_CLEAR, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_STATUS_MODE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_ERROR_INTERRUPT_ENABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_RANGE_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_CNTL, DCN_VM_PRQ_FAULT_DISABLE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_STATUS, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_VMID, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_TABLE_LEVEL, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_PIPE, mask_sh), \
+	HUBBUB_SF(DCN_VM_FAULT_STATUS, DCN_VM_ERROR_INTERRUPT_STATUS, mask_sh)
 
 
 void hubbub31_construct(struct dcn20_hubbub *hubbub3,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 64daa0507393..d46a2733024c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -536,6 +536,8 @@ struct _vcs_dpi_display_rq_regs_st {
 	unsigned int mrq_expansion_mode;
 	unsigned int crq_expansion_mode;
 	unsigned int plane1_base_address;
+	unsigned int aperture_low_addr;   // bits [47:18]
+	unsigned int aperture_high_addr;  // bits [47:18]
 };
 
 struct _vcs_dpi_display_dlg_sys_params_st {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 0638b337f143..713f5558f5e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -102,6 +102,15 @@ struct hubbub_addr_config {
 	} default_addrs;
 };
 
+struct dcn_hubbub_state {
+	uint32_t vm_fault_addr_msb;
+	uint32_t vm_fault_addr_lsb;
+	uint32_t vm_error_status;
+	uint32_t vm_error_vmid;
+	uint32_t vm_error_pipe;
+	uint32_t vm_error_mode;
+};
+
 struct hubbub_funcs {
 	void (*update_dchub)(
 			struct hubbub *hubbub,
@@ -149,6 +158,8 @@ struct hubbub_funcs {
 
 	void (*force_wm_propagate_to_pipes)(struct hubbub *hubbub);
 
+	void (*hubbub_read_state)(struct hubbub *hubbub, struct dcn_hubbub_state *hubbub_state);
+
 	void (*force_pstate_change_control)(struct hubbub *hubbub, bool force, bool allow);
 
 	void (*init_watermarks)(struct hubbub *hubbub);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
