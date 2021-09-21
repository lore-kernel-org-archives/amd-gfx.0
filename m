Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC66C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD9F61168
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3AD9F61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C956EA85;
	Tue, 21 Sep 2021 18:08:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD806EA77
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOjSyCZE/Kt0xCEX0OfDl50ISdiFS69JJW9EvWybuyUAzHEIJW17w66R6UfUHdbyLcbZJhXteyN/h1leLfpqvqOZ9KwrsQRL4CYJgSHbnNFz8ipurr4dSOqUE5c/SXWL58hX/5DyWboS6ZRqPAoLdVE7iwFbZf/fLQ3TqacOVZAmKNg0h2JVlbJm5/qGCS8E3E2DCNjbr13Jg43VSvZJ9J+Mo0ZwBIWmp1XeY3FM6DsdBWv/vEPCAD5HdRQc8Ey/kRpCch60K/mIQiqTRs+V50cRXwUAqfd/9+lg6lEFDTYktERDLdqMGQCSJfYIP8lVQJwPmcQVZWmupqJFsJlotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=YMJ0BNJSGXM6VWrhuytLrmlQPAroL3Au9IKWnBvDip8=;
 b=hfTOBN2lEra9MAZ8prnu11pFGc3I0CXjB6hkYg7L4hUdGKWW8iK16ZS9xwS2VkID3aHOxR/M2P7mvVdijbpiIaG+86on68eNmeL/wip8gxK15Jm4hymdCRwkpIvr96grXZYN7RaEex6TTsXNOrcPsvDF5D57pveRQiAh/ijRyd43GXgQtoxn/rWseSegst5JrIP7TBCV6ZD2mFn9ZaluMJY2cB5i9k1t65lNyomjDMuYijpldU9pTq3FAl8nw4cXpE4WMP8HVrl7jFqx207wgs/nxVqHHP+FercuTm5d7pa6cuUlc9d9NwlaccN47jjZ46Bq9WnZrQVUrCHMgaoKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMJ0BNJSGXM6VWrhuytLrmlQPAroL3Au9IKWnBvDip8=;
 b=J5y/p1BVwg4E6FNhNi0aU40YAVTppLv9+QtDbwLTJKJY6MsIkhMX0PHLTaHcsgNIr56k4qe5LKNWzeomDYdSeixwhWX2KrFaZ9KwOSx4tTiQIWXkxwrC0UILaH7N2HOCmrOpaITy5Pu8/UgnaQVoF+yMT1uVHTETAwmCkE/A4FA=
Received: from DM5PR11CA0017.namprd11.prod.outlook.com (2603:10b6:3:115::27)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 18:07:51 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::78) by DM5PR11CA0017.outlook.office365.com
 (2603:10b6:3:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Tue, 21 Sep 2021 18:07:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 18:07:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:07:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 18/66] drm/amdgpu/mmhub2.1: convert to IP version checking
Date: Tue, 21 Sep 2021 14:06:37 -0400
Message-ID: <20210921180725.1985552-19-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b09bab0-03b6-4c67-ec1e-08d97d2ab9d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3038075290E57E0D22A9E389F7A19@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghuVjSsIpxjas3wOS6lcdkHD1EffnF9BOctkVHtO9VsI7RlJKhjVh1KcbtSa+yuDdSUc+xWT9XRF7u2d4XKkFMDeHp+tHEAdTyh+cODF49T4/5/CPdotxhQDJHmqL7MiltdfttArJx36zdw4o+QHGCFhZ/WQhXO9znc9DO6OccCHUR93Y+bEHzy16VOWr6UMTMPTtRHnb6UI7RBHPkoL4fcn+LNWJMq1+vbMB05HmSoJw/vyBhGrMD/ZvWDV7kN+IqbUxfyOOPUxXFhZDDk4V+ZyuYSrR8xL+OjPiiU+pdhFc5v7i+5d3t32ML13geAPOG6CGvSliOAD7Y0Bux8ocLR3/JKXLK32owjK830t0wKOFAsKX2WGGGgArLywEZLagnA0/9b1xm+vfm8bqIFa9OV6FHUnkm+Lj9LBCa25uZfRp1uNPEEtI+xD+Fh6V6mlTSgfLCW0HdQLN9yY0v8HEBk45YQ5m6B9Rkc1+XN3S+jAwtNU0b/TRwNoAIZ+AJeIexi993MH4GPosAuxHztCmWMczYCB59737OVQ1DpN3dmaUWvZe+9uKfbGEF51VTbpgqz097a8lmuk8ezWOUrwqchsQEPCzFc+sWgFmMa1DT2kSw0vINkUt5Yc2wWHM7/8sO2Qf19OsR/OHEyIaMthPCFzYQt4J8f0YlGqNRPAsTTcyV4i7wAxiC+ewgaqwHPogbJjoRgw3PSxRfxp7pCGdiIlOVFcCgoUht7E9Uyomlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(36756003)(316002)(86362001)(47076005)(6916009)(186003)(82310400003)(4744005)(16526019)(8936002)(8676002)(1076003)(2616005)(26005)(508600001)(70586007)(36860700001)(81166007)(5660300002)(2906002)(7696005)(356005)(336012)(83380400001)(70206006)(426003)(4326008)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:07:50.8820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b09bab0-03b6-4c67-ec1e-08d97d2ab9d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 88e457a150e0..4cf5d0595bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -90,9 +90,9 @@ mmhub_v2_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	dev_err(adev->dev,
 		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 		status);
-	switch (adev->asic_type) {
-	case CHIP_VANGOGH:
-	case CHIP_YELLOW_CARP:
+	switch (adev->ip_versions[MMHUB_HWIP]) {
+	case IP_VERSION(2, 3, 0):
+	case IP_VERSION(2, 4, 0):
 		mmhub_cid = mmhub_client_ids_vangogh[cid][rw];
 		break;
 	default:
-- 
2.31.1

