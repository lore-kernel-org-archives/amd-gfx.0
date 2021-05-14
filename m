Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B2C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A378661029
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A378661029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA9056EE21;
	Fri, 14 May 2021 07:27:23 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2082.outbound.protection.outlook.com [40.107.95.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11666EE1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:27:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRm30rjsd4ufKNC10udHqBXkRfbzLTGEF5XkWaXiNmx4jVzBfSHrTyMBsOjGmFLaVuyDyfw21Jdurr21oabUuWesbI4rYSh2IX+RPxVpOUgOe9DL0/jZFJaTCSrUH/QquvEMuQ8DSAPFO44JtaAj4zb9u0MkTsB+jjg5aIs8DHCDAcv6IWnq0L/Z+hSTbzqW50iuAyMH108Sdn+VPg5AXWF41HWwL9rwZkUrmVoRkEWThWUmLU1TUzmjwg5JXWclXSw9x8aW+ugIap/Pw+Py/b1htYnyb39QkdH7OQ9ybgDlv2J7M6lCe27wQspWtF5M4i8QZyqYmxzownH/YTwxcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPi0+y5xu9XTk5JavSHj5M9B6F3JYEe4Fy514484KTA=;
 b=OHRCjMQXekpxZr3NT9aS4Z9RTqLL6Y3KyirWOPhJ1i3HrcVjyk9Fxk6TRjOcN/H8r+xaPUyfJmjBRk9+ACeLgbXhhMkq1CsQnQx70Srjho4Exm2ZwqUxuUGAIQzUp52m4uaJyqgk0W7mQd1XD3aWtJNcuGeTVrBAP1AueZha9bnBuh19VBfLzbISaKNW+RgY9OApQVdBq3CRzlYJIeklhflvAcmRZ4COGF641p+UDWCjJr3J+Qma1RumXnfoZm1vQ0cZOEwYjFwYpWUNm3LQebFGOjQElHuP2N57kDpLyrsEiDUur78HZLn6XwVVd8O03k4RqAAO+2VSb9wxxEjLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPi0+y5xu9XTk5JavSHj5M9B6F3JYEe4Fy514484KTA=;
 b=abp64OQtYOVXBmAOYjB5IiB///QLL5oFYNNw/ruvcAViStbJ45nrj4mvuuiAs3d7CLqKB4yN86lM5zgOONQR5Fk3XLM8yH63wuHpbKVqlYwEZNBlVBEGupmrkURdWDGnkQae+b9ci3t+P9qVog+oUGZhqucx4CEiz4meSCwrK7U=
Received: from CO2PR04CA0129.namprd04.prod.outlook.com (2603:10b6:104:7::31)
 by MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 07:27:19 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::74) by CO2PR04CA0129.outlook.office365.com
 (2603:10b6:104:7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 14 May 2021 07:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 14 May 2021 07:27:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 14 May
 2021 02:27:17 -0500
Received: from z-bu18.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Fri, 14 May 2021 02:27:16 -0500
From: Peng Ju Zhou <PengJu.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 04/16] drm/amdgpu: Indirect register access for Navi12
 sriov - GFX v10
Date: Fri, 14 May 2021 15:26:54 +0800
Message-ID: <20210514072706.4264-4-PengJu.Zhou@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514072706.4264-1-PengJu.Zhou@amd.com>
References: <20210514072706.4264-1-PengJu.Zhou@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df93ea2f-0b77-4f67-4f5b-08d916a9b531
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1536CCBC7284798EAF13F2D7F8509@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6f9ljtYwHPycmcmRB2Vd8AaWzQ/jGnRAnqziM3jH06dnIUl4Dz6HHU526utTdJ1YRkRhQ0ujVu+ra+08czZHC2WnZTx6hJmDLm64eP8dj44hW9POTsC5W5BBK/smLS1DdlsTENMLjw4wzy4s6JOUzCIBXqO405YU+Tcmz/UBABLsTLgO0xUqbLkzJL0/u/5/pHHax9SqYtLWpImdLu00bqCuP2pODO4trEn0A+uoAzSBVPo+5sf+sVEfX0QHKOF9eQC6X0lDbAuIaGhOLjH0MF/q6grLnnQ5T+Z4TXjNx7whuqajzPVMLZGY6EvsTm4mLQCF2vDGKVWeKZrsxebmWREdVpjGVLyNRcdyhQDeOGSbys/+VhmuRYeyp9hDd/1E/j355hGrFdJtsvlZqXJB6AXsHF0zEmfO+6XlvZZdDqja0HWaJV/WGn0BY31KWcyT0JJzGE70RamzpFBFAjwA1W09/2ntjwgPTv4B6AquSA6uztS42JH1HANeMt2hH1XqpCf7kB2rCGbPQP4Zk15gPROuIJzSzbaagNslL5MVsV/uBZDchaJHea8sn5R/nuX43bYr7XQ9Tp5ntm2vOW/zrGafUrE+zzGGsl4naip9/o+6cc0YFVwPuTFYOfFFCeWibUDdCtQs68xNeMZvMPEZbCx778nPNy6PAqR92KXh+FrJq6Kvr4D/KvWNhvlYCvPd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(46966006)(36840700001)(356005)(81166007)(336012)(70206006)(2906002)(70586007)(82310400003)(83380400001)(6916009)(6666004)(8936002)(86362001)(36756003)(8676002)(426003)(82740400003)(478600001)(26005)(5660300002)(186003)(316002)(47076005)(4326008)(7696005)(36860700001)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:27:19.3258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df93ea2f-0b77-4f67-4f5b-08d916a9b531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Change RLCG/SOC15 register access interface to triage
GC/MMHUB access from MMIO to RLCG.

Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 78 ++++++++++++-------------
 2 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 4fc2ce8ce8ab..7a4775ab6804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 flag);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 flag);
+	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49fd10a15707..2df977fcb238 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1427,38 +1427,36 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00800000)
 };
 
-static bool gfx_v10_is_rlcg_rw(struct amdgpu_device *adev, u32 offset, uint32_t *flag, bool write)
-{
-	/* always programed by rlcg, only for gc */
-	if (offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_CNTL) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX) ||
-	    offset == SOC15_REG_OFFSET(GC, 0, mmCP_ME_CNTL)) {
-		if (!amdgpu_sriov_reg_indirect_gc(adev))
-			*flag = GFX_RLCG_GC_WRITE_OLD;
-		else
-			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
+static bool gfx_v10_get_rlcg_flag(struct amdgpu_device *adev, u32 acc_flags, u32 hwip,
+				 int write, u32 *rlcg_flag)
+{
+	switch (hwip) {
+	case GC_HWIP:
+		if (amdgpu_sriov_reg_indirect_gc(adev)) {
+			*rlcg_flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
 
-		return true;
-	}
+			return true;
+		/* only in new version, AMDGPU_REGS_NO_KIQ and AMDGPU_REGS_RLC enabled simultaneously */
+		} else if ((acc_flags & AMDGPU_REGS_RLC) && !(acc_flags & AMDGPU_REGS_NO_KIQ)) {
+			*rlcg_flag = GFX_RLCG_GC_WRITE_OLD;
 
-	/* currently support gc read/write, mmhub write */
-	if (offset >= SOC15_REG_OFFSET(GC, 0, mmSDMA0_DEC_START) &&
-	    offset <= SOC15_REG_OFFSET(GC, 0, mmRLC_GTS_OFFSET_MSB)) {
-		if (amdgpu_sriov_reg_indirect_gc(adev))
-			*flag = write ? GFX_RLCG_GC_WRITE : GFX_RLCG_GC_READ;
-		else
-			return false;
-	} else {
-		if (amdgpu_sriov_reg_indirect_mmhub(adev))
-			*flag = GFX_RLCG_MMHUB_WRITE;
-		else
-			return false;
+			return true;
+		}
+
+		break;
+	case MMHUB_HWIP:
+		if (amdgpu_sriov_reg_indirect_mmhub(adev) &&
+		    (acc_flags & AMDGPU_REGS_RLC) && write) {
+			*rlcg_flag = GFX_RLCG_MMHUB_WRITE;
+			return true;
+		}
+
+		break;
+	default:
+		DRM_DEBUG("Not program register by RLCG\n");
 	}
 
-	return true;
+	return false;
 }
 
 static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32_t flag)
@@ -1518,36 +1516,34 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	return ret;
 }
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 flag)
+static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
 {
-	uint32_t rlcg_flag;
+	u32 rlcg_flag;
 
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 1)) {
+	if (!amdgpu_sriov_runtime(adev) &&
+	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 1, &rlcg_flag)) {
 		gfx_v10_rlcg_rw(adev, offset, value, rlcg_flag);
-
 		return;
 	}
-	if (flag & AMDGPU_REGS_NO_KIQ)
+
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		WREG32_NO_KIQ(offset, value);
 	else
 		WREG32(offset, value);
 }
 
-static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 flag)
+static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
 {
-	uint32_t rlcg_flag;
+	u32 rlcg_flag;
 
-	if (amdgpu_sriov_fullaccess(adev) &&
-	    gfx_v10_is_rlcg_rw(adev, offset, &rlcg_flag, 0))
+	if (!amdgpu_sriov_runtime(adev) &&
+	    gfx_v10_get_rlcg_flag(adev, acc_flags, hwip, 0, &rlcg_flag))
 		return gfx_v10_rlcg_rw(adev, offset, 0, rlcg_flag);
 
-	if (flag & AMDGPU_REGS_NO_KIQ)
+	if (acc_flags & AMDGPU_REGS_NO_KIQ)
 		return RREG32_NO_KIQ(offset);
 	else
 		return RREG32(offset);
-
-	return 0;
 }
 
 static const struct soc15_reg_golden golden_settings_gc_10_1_nv14[] =
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
