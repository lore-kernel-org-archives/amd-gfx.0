Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCDEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 21:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6771110E7EF;
	Tue, 12 Apr 2022 21:31:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0AEF10E7EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 21:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8JpnQjJ082cFH+wjUxd+DhgOR/ph0Zpjpha4Pf47Y5/KNXAfEZfJ+NcobNY9fU36dUnVyCdrRhchtym94BTR6tAYxJ+kF8IKTrwyXRQoY3HvqLHfZBegIj7VQmXZ44UMeh5XdNPYQzR3U4Pw1uhL3H2iAsGy3RId01cqgP6VsZiHf2gQbXk40ZH4ocq9afeyyBOIvJcPTmjg2Z88PFzLY9o5+IWbp5uRa10LCgz/yMaCHgmv6Z8lhzKSzARQkL5XUBBPHMakPOtwQ2UfaTlYp2wsBNFqNRReqmINHxwEmdMqUFwVHoxOsumfQATgiwXG0gAhT3DQVnMqySGh0f9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEQ102DwXDMLHKnG82evR6FPw3Al7l8JxssZjtESmik=;
 b=Q6jVDFwBfX04spYdTirupcb3wWOGFwIAT/th4zQ8Fgk42qc1vGIW7Sq/rguesgI9BgeujkM0pYwQu1nS+eiwiLWrJcI2oLU0G0M6WRG6XIqbp6wWbCnS2B0wkWDX+gPhXI/qdi/vjknzVzal9WKd7pJ1D5oWvDC3lAn6mWe8eSuZjulhKhmjc6PbclMD92f70eTv7OpZX2Kvy7CG69pxG+VG+EUNPgfDeuCp3sSbexM9LWV/7hltPAWPjodfwpjQEf0bmbNhgXXrOScZLAwe2bhTXhTwbXDhTU8qyehjIMmPCOY2/jA/6CSJQXHz0KYq+7pwksra5eTSY8hx3wGm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEQ102DwXDMLHKnG82evR6FPw3Al7l8JxssZjtESmik=;
 b=dIb+E6Y64I99523Y/su7MRymBdbxH4Wm0SiUBbPJ8Wxdho29aG2B9nK9cOk/pGiP5oEJzAc6z9Kgx+amwUXU4rNaJY5WdBnS+Bvy10GDdvj5yQau3vz/4f80L6pYb/UbUawsxor07BgocjtEMi3EQe5LtCyUtkg0TTeO7/V5gfk=
Received: from DS7PR03CA0130.namprd03.prod.outlook.com (2603:10b6:5:3b4::15)
 by DM5PR1201MB0091.namprd12.prod.outlook.com (2603:10b6:4:57::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 21:31:38 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::81) by DS7PR03CA0130.outlook.office365.com
 (2603:10b6:5:3b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Tue, 12 Apr 2022 21:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Tue, 12 Apr 2022 21:31:37 +0000
Received: from AWS-Host-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 16:31:36 -0500
From: Bokun Zhang <Bokun.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/amdgpu: Update PF2VF header
Date: Tue, 12 Apr 2022 17:31:36 -0400
Message-ID: <20220412213136.131628-1-Bokun.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa87e56c-8b8d-41ca-d173-08da1ccbd33a
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0091:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00913DD27CD2990ACB9E3B54F4ED9@DM5PR1201MB0091.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQBC0+Fs2egEm3FICTCDZoYYwGWRQveO1Hz5w7jZcFpbcSix/24pxTCn9zh3xtWDqHNiC+OA/2iTDYPq9vYBG2U0MTqoNYJULxkgrpTlLhMfzdSe5/IpWHzzyEQVBV3+kHzdti8Bjh9A3iXCVnN90F3OG8YfOq9cD0zj4kQHqty8Bk9V788gjssx97Wd19JVNOijaGGLzQPZw201pf9NitohAtlUHQ16t4D8MPXeqnUmWvm+g4ZWlOLxOoDxiaSLNoo3a8HkEgyT9d/knW8gJ8pDva97ETq3KB2a1FrR07gpm6SMKVXwpJ968XAW5WX/iufbVut2J5R0/e31gPQa9Ak2742vXBaZYKn6Hlz7Sp5JtgbBgnbRBer/bWBRou8zHZjsece93xK/fVZKBn0Yspx6wmTwpEN+jX1ucP3ztCQWovYPBMpO3Dg9FxNf9iNkJdyd6awHxuztglYiU3Qh9my9OyrIUpLJrkwiYwGg8c4wyKcehAnYPJsbdljyJNrHSjYBq/Xt78CdXTilv30FJvMyfXMwFX4Jdzx9sxqGMGoxt1AiqLVDcpzcOHgjIOnzoEs7V6dgh3JFOS4k0I8+wVTpTgNtNSCM7kEN6Mw6e54rSfHYFBZqFKg4p8dJe6DOaP2PHArR1gSH1keszbMt+tJLDfLc8a51WYSpsOcD4QuDC0MeZ/5f34p1/xsOp1gYZKSSL0naLCF0lk4gpDDD7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(82310400005)(2906002)(40460700003)(5660300002)(8936002)(1076003)(47076005)(336012)(7696005)(426003)(6916009)(36756003)(15650500001)(4326008)(8676002)(70206006)(70586007)(83380400001)(2616005)(508600001)(186003)(316002)(16526019)(356005)(81166007)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 21:31:37.3038 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa87e56c-8b8d-41ca-d173-08da1ccbd33a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0091
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
Cc: Bokun Zhang <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- In the latest version of the header, there is a variable name change.
  This should not cause any backward compatibility since the variable is
  at the same offset in the struct.

Signed-off-by: Bokun Zhang <Bokun.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2e0a81831e0..14c5ccf81e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3725,7 +3725,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* enable PCIE atomic ops */
 	if (amdgpu_sriov_vf(adev))
 		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
-			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
+			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
 			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
 	else
 		adev->have_atomics_support =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 65433cbb00c5..43dc9026ef7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -155,6 +155,7 @@ struct amd_sriov_msg_pf2vf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE (48)
 struct amd_sriov_msg_pf2vf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_pf2vf_info_header header;
@@ -204,9 +205,9 @@ struct amd_sriov_msg_pf2vf_info {
 	/* UUID info */
 	struct amd_sriov_msg_uuid_info uuid_info;
 	/* PCIE atomic ops support flag */
-	uint32_t pcie_atomic_ops_enabled_flags;
+	uint32_t pcie_atomic_ops_support_flags;
 	/* reserved */
-	uint32_t reserved[256 - 48];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_PF2VF_INFO_FILLED_SIZE];
 };
 
 struct amd_sriov_msg_vf2pf_info_header {
@@ -218,6 +219,7 @@ struct amd_sriov_msg_vf2pf_info_header {
 	uint32_t reserved[2];
 };
 
+#define AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE (70)
 struct amd_sriov_msg_vf2pf_info {
 	/* header contains size and version */
 	struct amd_sriov_msg_vf2pf_info_header header;
@@ -264,7 +266,7 @@ struct amd_sriov_msg_vf2pf_info {
 	uint64_t dummy_page_addr;
 
 	/* reserved */
-	uint32_t reserved[256 - 70];
+	uint32_t reserved[256 - AMD_SRIOV_MSG_VF2PF_INFO_FILLED_SIZE];
 };
 
 /* mailbox message send from guest to host  */
-- 
2.25.1

