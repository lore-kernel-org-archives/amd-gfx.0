Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28752C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F218D60527
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F218D60527
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919DA6EAA1;
	Tue, 21 Sep 2021 18:08:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8630C6EA8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFUk9TUCm8kwJKtaaMQ/p4dmFL2qPsMI+8wI28KcNQifv1CjcJv3L61Bakxrg39Lq2qdeCW3vwoGs17/Ie6pdV8Q7TJnS8RBMvG3kQoDPAWr6PUVk9wswdTSUw9VxGyeetpDspssyIrzw44doNIFwUkhKC9iXDVSAS2B264VDWganXJjYK0obnoAo9Hxp6qM2jAsHU+36l5Mauu8j54U6GmkIVPT+XEQrkzkCwuaFP+aYOQywwFQoVHzb4guitWGFHaPCKQSrsHUw9ybcYN9c++M3R3/YSpSUIN6cAYrNaZynz4fsddMoTWkeRNosogDojy7y6dKXPaqEQmFno4pKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=nrZCi/YAcSL1OohDOkyDaDVaWyo9Jp7JDOMe7A6Cwjk=;
 b=Xxuq438Tc/qdOm3gNuI8xp97tET2JpiQLpGV0/K1R/T8Clpmc1+LrRBZ1RLZB/7BiJYB5hB9BZo6meZb8zGWozDWFE2Ts9oMaSqFVgw1P8kmfAt0Mljx754O9WF40QWw5NSi/wqAmQYhzssn8LUpf/bv/4nF3E/6AU2f/At12SX84rjNiXWMAavOTGdzhRrMpnc5fGnJ08KxKnAP15WaJX6DmZU1LYUAL1L4jQkYW46j5U20ZgohOXota9DjpcwBiF48vctLbec4Qk49TjwZV8B847F3raMouuyijF+3+zUfV53u11ZBqoFstsdTCFqn+42mBNr6O2Io+bFQu/ddEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrZCi/YAcSL1OohDOkyDaDVaWyo9Jp7JDOMe7A6Cwjk=;
 b=oVT+847eYu1ambRfnHeovVeCxPEaqXSSIBzc+55AT9vXomkNnVQh2zK8SChng8ck4c9YuIQSTT5r/9gpQUjMOedJbo7wMkPp7fwBb8s4PeXCqzfZ2GZFKB/vHWhhA0wvH8qm/9QSjhVjz8hp51xQ0IE5gLjFh390krDqB3HqSWI=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 DM4PR12MB5344.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:01 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::b6) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 43/66] drm/amdgpu/psp_v13.0: convert to IP version checking
Date: Tue, 21 Sep 2021 14:07:02 -0400
Message-ID: <20210921180725.1985552-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a491b09d-6be6-4361-861a-08d97d2abfe2
X-MS-TrafficTypeDiagnostic: DM4PR12MB5344:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5344431FC700502D9000C52EF7A19@DM4PR12MB5344.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GY+QzCxy4LpkdbOB80Fbi2XMRkjMizQs1CWoauadngLqiAINumETdT8mqNWSUz0xh9fIDRbmOdgKO3Sc/2k33D5Qppgoj1U3tdanAsb5uqyW6ZlatdIjUlbXicAcHrR96CvysgBZYCgRwKuUxtfzA65Ih/vJ2Az5vPVYQRiGHH3r3w2wthok9kIOScqUkTGvPyQcH59Yyubz2eYbzwhs4cTxXfinVkOcSuoz46DYmmzYplBLihuqxB5ax9+1IbPM5iCCifR8jfUPiKRz99UDNf3AYUkhlrZrILi/rxVVLpta/uiPJ9DOEJ+XXbKO/BadGkwIjktkH4eED83nH7WTOopTr14Lrz0qAC5lI+ni4saLUK6e3r8JOo7SRpwkRVO3pjuOx0geU9rIRN4IQb6vLdcq2dvKJrzslme3lPyuOSJH8GKNdr0KK3tFd80Xybves7a5nSiZY7N+s2BgIeB9keb36+M4VeHGx8Rp99w72JNNqYuCzVPUOcwsbEJ+l9ChOT/bZxjVh0gPXSTXcGoR1A3YJzUGzvDlTa7r3/v0KA6BXvLo3p4C7vg85tgAVsYDT4GNSiVhfoNY19+Dn/WyUnJeaZkcuA7N+DfKOWZBpZMDHnIUUvtvRT6cUUyT/LJ6mkUT1h7r7gzLc+5/XliXglRcKh3ubhJu4ysNy5+ndyg2pCnSJEr3MH+HwC1ms4xMxjJmlSbxp7AuO+Tc7vZc8tNBPPXa9GIF36klCq6BWaI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(8676002)(86362001)(81166007)(1076003)(6916009)(6666004)(316002)(426003)(8936002)(26005)(2906002)(356005)(5660300002)(36860700001)(7696005)(336012)(2616005)(4326008)(70586007)(70206006)(16526019)(36756003)(186003)(47076005)(83380400001)(82310400003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:01.0168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a491b09d-6be6-4361-861a-08d97d2abfe2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5344
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 47a500f64db2..64b52c5ea981 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -47,18 +47,19 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	const char *chip_name;
 	int err = 0;
 
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		chip_name = "aldebaran";
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		chip_name = "yellow_carp";
 		break;
 	default:
 		BUG();
 	}
-	switch (adev->asic_type) {
-	case CHIP_ALDEBARAN:
+	switch (adev->ip_versions[MP0_HWIP]) {
+	case IP_VERSION(13, 0, 2):
 		err = psp_init_sos_microcode(psp, chip_name);
 		if (err)
 			return err;
@@ -66,7 +67,8 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 		if (err)
 			return err;
 		break;
-	case CHIP_YELLOW_CARP:
+	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 3):
 		err = psp_init_asd_microcode(psp, chip_name);
 		if (err)
 			return err;
-- 
2.31.1

