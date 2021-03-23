Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AC3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 20:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E81619B2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 20:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E81619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 746806E14B;
	Tue, 23 Mar 2021 20:44:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62BB6E14B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 20:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUA5O4eYeJpd6ygl2k2JdLuDjpLEVLU1WMCxPb6gZAuXFXlgYC7rGuDLGljwmd7Dh/DbFovYseFWkt3WsXLJroW2/4c7asnLDC6tlPWc0vrzMvcBWxIx44Yb8Z2NY2/KmNqplkLcu3zn2BnNqkGpw7HeP3hCLzm62Q4K4tdmoDhmTisam7onzPprEJuj+9QqA5Ia41weiWI7MUN8cdFJ/r4fbhYF0ivp+6XIh/ZE/lJTfs6UWtAflGpl0P9GCcq4msPVMuOT3opN02gxxUeRglFI7dtpxNqDgvG5vfdr4eJ7NmNicadhLsZ4zx0sVYknIWn5YNuOVPvMjv2vSOpALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWfS+sAjlteQAc8pSrNRiClaoICrbQvB+zrUzCVSjGg=;
 b=mpzPXq229Ud6/rhinYcIxUV6ITWygU+Obs+QZarNSQ2Y21hkxwlPQ7ubTtnokyaTSm97ix9yMMalA56Fx7GaI6Gza3KsXbEoP0i86IVDY7/4PGqkjK1p4x1Ja5Tg5T+whnnIsjFPf2Me8cr4E0dRF+4jcLrvLfGhbSWFmwsrBljCGXO+iwb++peFVWnN5MQqGAAntrli2GbpfuuojCoPBFjj9iZ6NuBbGZ8E1RcXGDca4cl62EZnjg7NlhLXdA23EgBYjQgvnjsMAUZpZF+wy2YMHdgChl4IIr9kBRN5vO9cXMhtNvn5HmxUq8zh9KOJPYF4eeEB9mAidmeicFCjOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWfS+sAjlteQAc8pSrNRiClaoICrbQvB+zrUzCVSjGg=;
 b=1u1fUIRnzkl+iem8N6E/oEC/kiX5P4WBhb3Jf5yao+yQs/20pT3jzZs9plrxzRMlDduQHM8JhCgDSwGYwSY8YwiXZQzaC8CxjhsR/pjf1eZa1R85FNAnivqBcqcy6eBi+xE0VnbPcfEg9uhtaldEELP+NI7RAsj8Ep/mpfC9Xl4=
Received: from MW4PR04CA0372.namprd04.prod.outlook.com (2603:10b6:303:81::17)
 by MWHPR12MB1568.namprd12.prod.outlook.com (2603:10b6:301:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 23 Mar
 2021 20:43:56 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::94) by MW4PR04CA0372.outlook.office365.com
 (2603:10b6:303:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Tue, 23 Mar 2021 20:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 20:43:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 15:43:54 -0500
Received: from Rohit-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 23 Mar
 2021 15:43:52 -0500
From: Rohit Khaire <rohit.khaire@amd.com>
To: <amd-gfx@lists.freedesktop.org>, HaiJun Chang <HaiJun.Chang@amd.com>,
 Davis Ming <Davis.Ming@amd.com>, Monk Liu <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Add new PF2VF flags for VF register access method
Date: Tue, 23 Mar 2021 16:44:14 -0400
Message-ID: <20210323204414.11341-1-rohit.khaire@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da9f1396-16ec-4788-9ed9-08d8ee3c60bc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR12MB156814F07FAAD44385AF734787649@MWHPR12MB1568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bibBRLDWHZPmmE8gLeEJzKFr3Ovpvnjxi01czeHYnpaDTt7qb3zGeAzaFr3hVYFsdrLsnh7xIi4n4cQc+9UeYj9G/YZkUmof4rxOV/2Ll53ms73MRuts4LgxRIcvaNPaIcZw9uY+0LfCf9SkIzPc0b0YV+tHDqWKficwTHAcL4hQ5okVtDGkeaavArN8sK643WFBRr3bs37f5P03PeSP7kfGj7YUBK5mkdjqvSk2XGDn7ZStO/E+8xP0S2eOZLEpeeqyjxdeU/7oZq7QF3uYHXOxoZFitfVJjekCvEWgIJVUBX5tMwoyFBqo7Sx3/hX0JIz7xAkVAtkB0O+64H/S6rL46j8p0JrgRDAZBCcLJuxcZJNLoen48UJoh0K59q5XY1xiwEH6jhwCqEJupfUOP3bqJJF8meFS7LAyZArADmP4F1c/HQQ3JqxsoD3fK3yOUT7rzpCwPhjZTWmvV7qRxGJrZeRM0bk2MUR+EbnFCyAGNvAVQjJ/GXdcDuG6lgPH9Z/UCls78cLa5b6gZi8PbNZfLqm2L0MtcNopmIyFzPXe+ulRQSqmvlTOhsz7LPmFhEk+PJqe2Anb24hAhDp+X9Ez688XsPJILWMdCa911uUsrjc87FsangbomkTA6p2pKnZRA23TTcrOJXOSvz6Qyk+zryV2gZuns0I3mHtOrORiD4wxFig99sPBUCSUFQv8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(70586007)(70206006)(2906002)(82740400003)(81166007)(356005)(83380400001)(86362001)(54906003)(82310400003)(110136005)(316002)(26005)(7696005)(36756003)(8676002)(16526019)(186003)(478600001)(6636002)(1076003)(5660300002)(44832011)(4326008)(426003)(2616005)(36860700001)(336012)(6666004)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 20:43:55.9798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9f1396-16ec-4788-9ed9-08d8ee3c60bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1568
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei
 Xu <Feifei.Xu@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>, Rohit Khaire <rohit.khaire@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add 3 sub flags to notify guest for indirect access of gc, mmhub and ih

Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 17 +++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 8dd624c20f89..0224f352d060 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -104,6 +104,17 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_GIM_MM_BW_MGR = 0x8,
 	/* PP ONE VF MODE in GIM */
 	AMDGIM_FEATURE_PP_ONE_VF = (1 << 4),
+	/* Indirect Reg Access enabled */
+	AMDGIM_FETURE_INDIRECT_REG_ACCESS = (1 << 5),
+};
+
+enum AMDGIM_REG_ACCESS_FLAG {
+	/* Use PSP to program IH_RB_CNTL */
+	AMDGIM_FEATURE_IH_REG_PSP_EN = (1 << 0),
+	/* Use RLC to program MMHUB regs */
+	AMDGIM_FEATURE_RLC_MMHUB_EN  = (1 << 1),
+	/* Use RLC to program GC regs */
+	AMDGIM_FEATURE_RLC_GC_EN     = (1 << 2),
 };
 
 struct amdgim_pf2vf_info_v1 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 5355827ed0ae..7fed6377d931 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -90,11 +90,22 @@ union amd_sriov_msg_feature_flags {
 		uint32_t  host_flr_vramlost  : 1;
 		uint32_t  mm_bw_management   : 1;
 		uint32_t  pp_one_vf_mode     : 1;
-		uint32_t  reserved           : 27;
+		uint32_t  reg_indirect_acc   : 1;
+		uint32_t  reserved           : 26;
 	} flags;
 	uint32_t      all;
 };
 
+union amd_sriov_reg_access_flags {
+	struct {
+		uint32_t vf_reg_access_ih    : 1;
+		uint32_t vf_reg_access_mmhub : 1;
+		uint32_t vf_reg_access_gc    : 1;
+		uint32_t reserved            : 29;
+	} flags;
+	uint32_t all;
+};
+
 union amd_sriov_msg_os_info {
 	struct {
 		uint32_t  windows            : 1;
@@ -149,8 +160,10 @@ struct amd_sriov_msg_pf2vf_info {
 	/* identification in ROCm SMI */
 	uint64_t uuid;
 	uint32_t fcn_idx;
+	/* flags to indicate which register access method VF should use */
+	union amd_sriov_reg_access_flags reg_access_flags;
 	/* reserved */
-	uint32_t reserved[256-26];
+	uint32_t reserved[256-27];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
