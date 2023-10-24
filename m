Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26431C00A8F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706E710E3CC;
	Tue, 24 Oct 2023 14:49:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8FE10E3CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt3mVdHE5cf8pN4E3nlVxliV+h2N9OsSB0HcAkd+Gj7i01bS4IqMXPp3KWLQLEoQpbNmZnhvFyw2uh5b2pSVRmp8fe1uhKZo7Oym+yRS11zKGxkStgnYXhyGEiMx+i+V9Q57A7jQTrLAB/I1mqV7lHsqAQrjaHtLIzAFpdJyf3i/bElzluwFk/WCrFkoBbJhwbR70L6pjWb6Y6O4a9MYO7Zl5CIoAzfOqs+YIJGewGBLssTmgSwdXgL33aMwZSx6uB1p523H45RZFejQ5qNLlp4HBsX8Dk/rFt2rPdE86tF1V6ZJ/orAnm5cqQRCxYrESIUTBJfSPeeuC760w4TKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C+QnVg7mNt12AMPqsliBhkGXu1/C6bkMpS+6jHiwhc=;
 b=SI1fFO26NcJMm6fnHCV6JVxGAfTTJfLXEtAS37PcHxjsZUJ7sSQXyTrIwwMz7pMpk/UrBMuzpoQkEbZ2Cm1UM17Pf1Q/rBbl45IP56LJv4HlPlwe0mmoTUs9TtdexFHSmir3a6eNfUgT+Ix6vUgVEPDqTLuDz4VTTFe+y0fvLHBcxD38iAusVjfRFG43WUr8WbiIvZ3Ns/rz6rKFhi6BlmlR/YXP6Z1OxmUF1KyDNvgUM5iB4mbdglHEmMP0Nc89o8z7m826cX2I5VTX4BtS25gv6GzS0fZiK3TwZmCXSgFVxVez7aoqncx+Q/2N8e6aJ71vJoKL0TKYlTRuwoudBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C+QnVg7mNt12AMPqsliBhkGXu1/C6bkMpS+6jHiwhc=;
 b=HpcdyORYhldOnFmmnq0jFKRlqlkC/2iQtMS33PawO48Zqd9TxeLSxu4AR6P6x0yQBl7ndGlCW7oSh67OWQjjydyXqohH2mlEBH0oUkCrHU976jZ49awCm1dnSFYDZCYyBwLNHpvm/VogGrzbXqkiz7ZolgvpvpuojhU93TeeHE8=
Received: from SA9PR13CA0175.namprd13.prod.outlook.com (2603:10b6:806:28::30)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 14:49:44 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::3a) by SA9PR13CA0175.outlook.office365.com
 (2603:10b6:806:28::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16 via Frontend
 Transport; Tue, 24 Oct 2023 14:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Tue, 24 Oct 2023 14:49:44 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 24 Oct 2023 09:49:41 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <yifan1.zhang@amd.com>, <kenneth.feng@amd.com>, <Mario.Limonciello@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: ungate power gating when system suspend
Date: Tue, 24 Oct 2023 22:49:32 +0800
Message-ID: <3ad257465bb9fe2542970ae0f3ab06dd29f1f1b2.1698158958.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: c415baf5-2a00-446e-6645-08dbd4a07604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyY1/HNk4xNqibP7TsYM+7I9pSvCejPKhKzdqPcaR7R4ipb5L+AEBCYMSGsS2P7SpQb5KrLksB3n7rLGs4EuDYQbUkH3o6ushFHbFQKoUyJAmx8CUEaqfd7ZFlW/F0SAIJkyL+lae1mdL2mCUga6zM9iR75jyYJl7NxBlD/7XBNv5BpEkIJI9Y5Q/+tjsQTy0J9UrX+TFEk+1etlAsBww6Oo1XmYYXRWOr7qSEfPAI7mazQnS5BTpvhy3MgcOOWtc0P9i1+4GktqPjoc1jZc/722U1qVUyqdKdno/wPpVe6uQS3f1lUkYxYsHsYqQpbqph8ld4wRH18j9EwL9/rp9VSNDnUSDOUTNJ3fV7EPkJRlwT+ZQKkFIsR8f3698AroM4RdaMY7jC/C8mfFFYYIaTGC1GxAGJL9+K33sb/n4iQO3zJBoaT8WrqaSNBGmLJsPTdA1mLzjbLYPc6Xaf0YDvrKWMG1/eyABnQVRce/YzGs+zM2T/Y3UHQK4xJIz/di1cK3pCd6G1wmMG70RFN2aBIMJ8txU/xzEMXVKZvYwiClC5d01x4ktg8ldpxIH4MA0++Ub9g8xxzxjqMpvX+iJK89pjOxlpVRoztV9PRSidXVZ1gdUbCEl70hFs+mQsdiVi5YulTw8XijfZG6EL2/7sgTS0BSoEofPurL9F3hCnuu8/MTbVelmNDT4nBf0kAfMZsYsnOQAksHrC1ApX76BC9iN3OW7pTmjx9nJIXL1N3GwmsSvGq4+xo1BAaay5WVOqc5EAeCnVTkWl9UZvPFdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(36840700001)(46966006)(40470700004)(2906002)(8676002)(8936002)(4326008)(44832011)(83380400001)(81166007)(356005)(82740400003)(15650500001)(41300700001)(5660300002)(47076005)(6666004)(86362001)(40480700001)(6636002)(316002)(110136005)(336012)(426003)(26005)(478600001)(7696005)(2616005)(16526019)(36756003)(70586007)(70206006)(40460700003)(54906003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 14:49:44.2287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c415baf5-2a00-446e-6645-08dbd4a07604
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why] During suspend, if GFX DPM is enabled and GFXOFF feature is
enabled the system may get hung. So, it is suggested to disable
GFXOFF feature during suspend and enable it after resume.

[How] Update the code to disable GFXOFF feature during suspend and enable
it after resume.

[  311.396526] amdgpu 0000:03:00.0: amdgpu: SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
[  311.396530] amdgpu 0000:03:00.0: amdgpu: Fail to disable dpm features!
[  311.396531] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <smu> failed -62

Acked-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Kun Liu <kun.liu2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d9ccacd06fba..6399bc71c56d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3498,6 +3498,8 @@ static void gfx_v10_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
 static void gfx_v10_0_update_spm_vmid_internal(struct amdgpu_device *adev,
 					       unsigned int vmid);
 
+static int gfx_v10_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state);
 static void gfx10_kiq_set_resources(struct amdgpu_ring *kiq_ring, uint64_t queue_mask)
 {
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
@@ -7172,6 +7174,13 @@ static int gfx_v10_0_hw_fini(void *handle)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
+	/* WA added for Vangogh asic fixing the SMU suspend failure
+	 * It needs to set power gating again during gfxoff control
+	 * otherwise the gfxoff disallowing will be failed to set.
+	 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(10, 3, 1))
+		gfx_v10_0_set_powergating_state(handle, AMD_PG_STATE_UNGATE);
+
 	if (!adev->no_hw_access) {
 		if (amdgpu_async_gfx_ring) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
-- 
2.34.1

