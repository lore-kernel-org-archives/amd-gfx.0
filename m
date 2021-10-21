Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637B5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210B660FE8
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 14:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 210B660FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF1CF6EC7D;
	Thu, 21 Oct 2021 14:18:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 933B86EC7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 14:18:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN0Qr2yM1KbmlVMb4BuATPekITLm5u9qVNOLDgaNO28niOILe0469NH0RnggZuxs0byMNzBSctA4ZwiCN3/RkEXtHfwLCl92IaiRUN8Z19ICSxKdb3UcWVq+4SJZ4+mAgiQFfwQOjnFflfvqnB46DMn/bOdJOwebbMHKgMnemNrP6MeCbQSN9e2LXDyKqh35/N3u3qgmRGiS/bHV16hdg5dPLgq6BIhXD4jDTuNcetAWv065C2iwIUBDGLxn5EgfPjo+mDGVY27LM9tNnO0+eipIKEdPbHOS0/2g0Kpo88k2q83XXGemHIzocbHJMmgyEjay3g06KzBC78XyVBDgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MAFG94Y6h0Y+rqlC1Wcrvg5JRvfaxVSRV+5keMKc+k=;
 b=VzGFDR+2LBXUlYzrtyeBF7P60we71L+k9ck791sOWVXoVzLoNquCULJbmJk7DQywwqWzMGKAg8dbOxI+NX9V8JAD7IlwqBAFlFf78sqmA6GucNIvycKgFchi0HZtr+xhFt0QFB0Cr52Qd1DZj+t/pKuCBg9seEvFsZA2JOqsJCkTtfjG+ba7dVj6Ys9/OPfk7ayIiRT8BZwNqHxoFqbFYcUND1sLoM8m83CQ1zVjsPACL1hpmUOA7c76FgG3pIhD+pDx8qxUb9URJt6ZvA2y20DmhEloIVWjn2f8hjjbRFV8pyTR6i+iuIYO54eAefWdm3ZqOH2RyR3+hLYSmnV2fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MAFG94Y6h0Y+rqlC1Wcrvg5JRvfaxVSRV+5keMKc+k=;
 b=eg2N5Jf7L6+mGaM8K9xPPmwJKvz7AamLo0DFDSLmvHZgogcW+f4CYrusqV8RBN3z4Mx6frAVGTHK6XbR8/bU/UdO41wCkoltdfi6WyXXcnqbHse7in8s5tmgw9P/gKifyEa1RSPNcrjZFXJFe4ynjjcbAwnEht/YEx2WMrTZ64c=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by MN2PR12MB3389.namprd12.prod.outlook.com (2603:10b6:208:ca::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 14:18:18 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::1) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Thu, 21 Oct 2021 14:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 14:18:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 09:18:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Date: Thu, 21 Oct 2021 10:17:55 -0400
Message-ID: <20211021141756.2048254-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad0c740a-a15f-41eb-088b-08d9949da0c1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3389:
X-Microsoft-Antispam-PRVS: <MN2PR12MB33892E9CCA1E21A649A591DBF7BF9@MN2PR12MB3389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aj4lvly9G9bgjOSVFVDLK1nsCnLMcq2SYKec5abNxfW4RizSZg1KdrtDteSFL09wVZAefUrKodNeKF2XZqzwlrxeX7Bf0Mj41T0hPflYi3iEOGSUMgvU9aTCWYLmt44roZ9QeWHMfxRDihekmw5I8eOIW4ZQvigyCM7GCShO/hxtsPyziS2cp13Hilqo+FsdQ6dqlgq8ElfPnWwmdMh5B+2Y+tWPP81K54+CF/rbHQQdVDA9bIldQeEs/dgnW4ByE7/eTDtr77JI88a7ar/EMcnNOdWC6UrN57kdnq8TQD6Sb/afnlUZgUjpFre++rOgp21dgTjSfy8qNgULvYtASe7EzGcjq0L+Wx+WRSf8Mfz9qDB9MraCjCEx7aLMCVzT10UGYNphn2gnH9cSjTDUiuU/v16rRYhsfh/bxH78c+rAlTO7DVCOmd3htEcUFYgpJ7mRBywT9l3/KfumsLU13yXayKCurXgPhMHxUIHeRfeE+PuurY9Rlqk6qLnGg/gSWAYjtWJEVIEVsF1GqVkxurbRT+5tLm8pC+S7+BLCeZyVItDpSB7mNnbktkyo9x6hQ0vXR2hoTI66AAB3+8Yaba0qfr6v1zGP5rD6UNONdLlY/kWwSwAIzkcWDRZELM1IN7M4/kprgphX7qpVizxZ5zPcwxqQ/8PJqpRytMBuvqtaYAdH2Vw+fnRLqY7BOqplUBReeUXIflpJWDC6xQiEQEyLqPy6gF8AFAlBx/lcMww=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(8936002)(70206006)(316002)(70586007)(6666004)(5660300002)(36756003)(2906002)(36860700001)(4326008)(508600001)(966005)(1076003)(86362001)(7696005)(26005)(2616005)(186003)(16526019)(336012)(82310400003)(6916009)(47076005)(81166007)(356005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 14:18:17.5858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0c740a-a15f-41eb-088b-08d9949da0c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3389
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some navy flounder boards do not properly mark harvested
VCN instances.  Fix that here.

v2: use IP versions

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dfb92f229748..814e9620fac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -507,6 +507,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	/* some IP discovery tables on Navy Flounder don't have this set correctly */
+	if ((adev->ip_versions[UVD_HWIP][1] == IP_VERSION(3, 0, 1)) &&
+	    (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
+		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-- 
2.31.1

