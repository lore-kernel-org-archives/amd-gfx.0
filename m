Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B412EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 09:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3EAA10E08E;
	Thu, 29 Jun 2023 09:06:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8570110E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 09:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjlGRc7tKmSuDaFSnkFZ56kiDNOmH1uN+3hDLx2M0U79Wz673fHCIYVnSBG+MqbsuA0DQf+rt57fA20KVzc66MlOZEF9K9NQXl/thN/skDDjOHozlGZyHXG5MeelQqLEVUcKfhHJpJrMNGdX3B/DMoJI4UJ2qV1hb++g3ICxqcZxFQ/G+NrP9694w/W50UStpSDzgQwjzu3oZ4+AQSm0LMidML0MjtaoX9dnSnTBM3LVYcnyCGdAkxs1ILy2zd5ERSpR74RPScAH05vHhnYV5QYzJoGDOsyvmDYt1RfRo95MQcI8Db6aauOIhSkLTQIoXKfWUWzdbDRvwJUxZhA/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuq4zP0UDxWdFjgT+Te60OqvdyPJpl1hrVzyX4jf6+Q=;
 b=amFD+H8taOIKDp9OvJi7xGA8jj5R3S8KwRl8SfOoO4CbOGf6+e91ypB+LQUCyavFrepDUHIwqw3+z4EcL99DCKC187e7qH1IeiQ5FkETCSyGTO3d1eiuT66RhgbJ/beVAjwEEM+MeE59bOAIhXOMIKCJ29jbyc0VhsON56fk7933vGCHeAStpq4rO97mpB/tF65rSSeNCRGvgbWFVLPjdWa5BIROWLSSQ00QyjeKO+CUbCUcqbxwkBiecW6cLuSDpZRqRkdi9ANtbru2uJD7a5ag8qmHPcriRuY/bCSXt1LVTxH8MUh0LaTSip+eMQfi0qlcqFfTxgJByWz8WeA61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuq4zP0UDxWdFjgT+Te60OqvdyPJpl1hrVzyX4jf6+Q=;
 b=drt5UwIfj5GlFzQ8Ae2PZ6ci78pnn6a45UNNHHGWp3y6FdghUgH+/t8cgW/d4HmNVjdYqWFuPtscCeTWMoEVFzKghEDWiKgAWxzvP+Nkr9lL9GpI3PJigl1RbX8uRnbndydYzRReKEJc/hyrIAPi6EWIr6JyYnpFbBCA/+dbYRw=
Received: from MW4P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::8)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 09:06:49 +0000
Received: from CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::c8) by MW4P222CA0003.outlook.office365.com
 (2603:10b6:303:114::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Thu, 29 Jun 2023 09:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT110.mail.protection.outlook.com (10.13.175.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Thu, 29 Jun 2023 09:06:49 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 04:06:46 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the mmio remap failure issue
Date: Thu, 29 Jun 2023 17:06:28 +0800
Message-ID: <20230629090628.3684956-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT110:EE_|SA0PR12MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8d517b-43ce-417b-9c05-08db78802c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrH1pNV8iYznM77qjANIQCU63+NWg5SeT+TzIeqkpUXkLo2q1o4lqOweHgRvHGDi+AbctOwJ6KeDTtOHiJWc3DOM3Ro+4D5cijfKySkTnsjjMET2lnzfEqTcqXkFi2siqvYUOtTuCMfzILK6unuKdrj2sox/OMFXm7PX0aNXwnPE53yOCBcwjclN+bqxEHuz6SnhDVtGiTmYMvz/Xf4uIU5Y0HNl1vKXIEOKtkS7urqJ1oOKKyl8J7o2tIs5CkSKb2QLYHKeAnbVtNGXymofrgvNmCObrFC0wMU3wuIm91z0MsdochhJNqLAZy1Rv7lui6DJPAvH3ARKQ74L8+3916BY8N0B2c9NCKUhmm2iBCrj+medf6LiRpNkwPH7Sli9xLdlUawJIk60ozprtBhWQUFZp2y4yO7zorxa2aPKj5wnFEAam0YSg4BWC/oO7o9O78Nh6Qfzxrfd9pYwwTXlI4aO5nU+20vczFF/cgcGO9KgX02HiLoOVWHtDmz9zDAYk6G65iCtj0F4Wh+zk2xFZNrDsqS4GvzB0bJknFQ+n1cKwvqDW7GTYv/XK8DJftpPbDqMhmCVFeDD5llvNFhLotbVoGhFDX/axmKziiJv9euvVAr37rvgzqrUf9kpp82sah06l+6YFYNgmtq+M3bAVokRfP4sifEVFxtYYfA9MPfbOdjgmwccv+wC04MdyT8el8ZR4y5n4CqSywGlbgxF5RlItXdSjyD4MdU+iRscKbgRy0vBxbIUNICv4cT+2jztabcAIK0ED/QKCvj4yf2A9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(1076003)(70586007)(316002)(478600001)(36756003)(4326008)(70206006)(6636002)(8676002)(8936002)(86362001)(4744005)(2906002)(26005)(110136005)(54906003)(36860700001)(40460700003)(40480700001)(41300700001)(82310400005)(6666004)(7696005)(356005)(16526019)(186003)(82740400003)(336012)(426003)(47076005)(83380400001)(2616005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 09:06:49.1247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8d517b-43ce-417b-9c05-08db78802c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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
Cc: Ma Jun <Jun.Ma2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Initialize the rmmio_remap to fix the mmio remap issue when start the
kfdtest. The error message is as follows.
"Failed to map remapped mmio page on gpu_mem 0"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 6a8494f98d3e..979f5223877f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1458,8 +1458,14 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 
 static int vi_common_early_init(void *handle)
 {
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	}
+
 	if (adev->flags & AMD_IS_APU) {
 		adev->smc_rreg = &cz_smc_rreg;
 		adev->smc_wreg = &cz_smc_wreg;
-- 
2.34.1

