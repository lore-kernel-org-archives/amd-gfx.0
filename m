Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78DACDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 16:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA4710E238;
	Mon, 16 Oct 2023 16:54:10 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 632C110E233
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 16:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeBc2+kksjK5jVvoT7+AFT0og1mDOXCvQJWFL7aCsMU6RCYxcPaMtXp59RSyA5wc6kuZfZNOAD43tYyXzaZPecGr0TH48KQOfcFROdoNmVYulYzjKECDmEDf/jjWVg/hyyzDbzwB6dBYDtpX/+GTb8raIbg9xdTAcnJz/D0+XcPiVawpceq/xmwr3mhpB6zUgzjcz3xpbqtZSBfoSnNWWdaBc7vpSPKTZodoSPbF8FBEUZJ5vJEwrXyDy8LJDJagsHWBBALmrtAX5ckapBVXWeiQTa5EgPopRSHo/lSBW7oRyePvtnE2YjCfGPVSstTtBLDJf4mCdqPhLS/hE+lABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHPODpQqoJYwb1OjwTFQBcU0xX88pl4cVfkL3TV/y6I=;
 b=Tch0KPAfbpUW7/SnS7b5PZ5u2aIOyJFe0nASSN5Sd7s22N9AMO7J8j5y0tv5UTVPzDei6QP9VJtkzNBnoIb1J5l9iTJ9pP2H/1LY3PmxUM/dm1xxQj+tTzgQ+pzQFQQT5/wo2CtQNoLcmwapbZ0wgRC7s7IWs1l5Fj65y8yPkL3GFAHTEvxiDuPD9gxmZt6fkX1scniORIY9A+l63L3uxdyrF+a8wii1VW638VBERBhBY0pn5H9tQHRjfOk1rA8ruJK9/Br7ILP4rqoFnAahol2HgK0gMsONIZTMx2gfe5EAFpMa64EwwobbRxeYO6pI076bKeJmPJJTCEqk9Esz6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHPODpQqoJYwb1OjwTFQBcU0xX88pl4cVfkL3TV/y6I=;
 b=0eViiP1Ql/fWekY6wS5U39BpfynmteYNgtjnt2OthEC7EINr1/SBpKof56Rbl+Vo0XP9I4igVPpbIkHuuUdW4fGvqzgj50e/kNAvMtdb31kAlky39Y1fnMNcVQYxCw+U9MfEk5l+TJwXsblKDaae4EmEmG+P2ucwAH64mcvRWb8=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 16:54:04 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::b) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 16:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 16:54:04 +0000
Received: from test-Virtual-Machine.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 16 Oct 2023 11:54:03 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P2
Date: Mon, 16 Oct 2023 12:53:37 -0400
Message-ID: <20231016165336.2804-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH0PR12MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 383fea5d-9eb8-41c1-7a14-08dbce688131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKKmI7sgYlDfi8bzWShYKKIxf5oXCkn5Ld70xCD/v5Gj+uL5V+11OzVNL5osBuYuhFriq/ift9QW8rMtdYSJkI4W2jmG1KHiMLBKljkLg4zvbN8+ugwUBar/DZb28hOM4ST+e7JbgXhpYEevnXCnxo4FYgmFb3XzPDo4+jUWAW09t0wfmKq5OunWkk+dxeP38SG1jW9PUWfOGBx2GCpaM9qyuOjAC+sP70KZUtop5oPh7lxeqCj4Xw8/Ar69Hxf2c+PViq9MtvShNqm53dSbspIBJNe8wZHp52qyt10+GyU3dOpvo1aaD108ASQY2vnRFawXstJQdUxz4MoHHAT5l89MFagBTlKCwJ9K4pKp9ad1E+T52U7ynhoilRgg5LwBlMNz0lcIVX6tjO2IcdzXfdJhshWyFRu6ibWnuKU62idEtKcu78wJdnlsO5DmEqFQVkCulAEqYQHj82+DwhdpGWcOYubyfmoSvaBxXVWwPMbobQjLptAHppmdGYOqoRlxaiSsk2Hj/aHxH46BUNhJ/YzlPDHNp18t/Zmj8t9Vd1pTbWYUsleC1ob+RbBsQB22wAI/UWEnjcf1wm8ODZpZc/GCwP/sMLPjTaghsB0mb0y+kaDGctQCOzSJLcgh83sF2rNsZkeS/PvTq41fXEd0QK1mJG0Tp8QlxVV/i6NmnkeRcbSB3HmrU9p6E3eEY88G9FSLNcZGQSx2IVA9nvRL3bio03O0H5R2WEpJsqzcwgopmS0hWqBVRy++IOlgKB91PXxE3ftBu+iDC+2oQ9+GaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(40470700004)(46966006)(36840700001)(40460700003)(86362001)(36756003)(40480700001)(8936002)(44832011)(4326008)(41300700001)(5660300002)(8676002)(47076005)(83380400001)(70206006)(70586007)(316002)(2906002)(6916009)(1076003)(36860700001)(7696005)(6666004)(478600001)(16526019)(2616005)(26005)(426003)(336012)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 16:54:04.1074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 383fea5d-9eb8-41c1-7a14-08dbce688131
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8800
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
Cc: Bokun Zhang <bokun.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add function to check if RB decouple is enabled under SRIOV

Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fabb83e9d9ae..858ef21ae515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -126,6 +126,8 @@ enum AMDGIM_FEATURE_FLAG {
 	AMDGIM_FEATURE_INDIRECT_REG_ACCESS = (1 << 5),
 	/* AV1 Support MODE*/
 	AMDGIM_FEATURE_AV1_SUPPORT = (1 << 6),
+	/* VCN RB decouple */
+	AMDGIM_FEATURE_VCN_RB_DECOUPLE = (1 << 7),
 };
 
 enum AMDGIM_REG_ACCESS_FLAG {
@@ -326,6 +328,8 @@ static inline bool is_virtual_machine(void)
 	((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))
 #define amdgpu_sriov_is_av1_support(adev) \
 	((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
+#define amdgpu_sriov_is_vcn_rb_decouple(adev) \
+	((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
-- 
2.34.1

