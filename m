Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14148C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D637260F46
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D637260F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882106EC76;
	Thu, 21 Oct 2021 13:57:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399416EC76
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaOAqHyn1cZ6OD/DEsCYoVRoIYJKP4cGmxKMKWqUdG4ty8tVhXsYQoxQz2wP5BLiPA7bAPGQDAySI5ipQTEpJluBPVDKRHvEz3PnKBgw55HOBhPJYglG1Srgy1eoak09i3P+6kq1NvqFtN90qyuFsGJiah49neFNYvDPL1tvsH7HUG+w2+pYLQHCTYZkLlZAGZJ2BOG/53+YzUhigMzf3DxRj4U8mJeGuFlAPdTePA63yD3pdO7HQ0qg629Mk1MWaV8nYvXJKEHP3BkKYqUsL9dF5d8ALNARcLBE4rqfSBufQcYiWRgTSUUg+Zpe6aukylIUX4ruotqcMjT2uYMX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRAxTSjb1RekV9atcMWDFqTKz5WQlSNfOmC1KD0lWnk=;
 b=FjcX2UcQmFRhagYTVWa8Le41oir/sPM8HPNakTmdTIqf1Mv+sUOg32N9IdEcaJiMxRGT/X8kBRBxD0AriV+QGcVIqF+5IvJ2vnilf0spSuddsIyDwN6EBPm+trHwWki8UguuU0fDZtwYwzv4BIpxOq/YAqGxQyyUh2XqT7KK+ZFdwAxWBvXuaGbgRCVC8Lt5MNydTHMSAx/UAGVlIWtlZ25AIxM5wlSwkLE31Ec2OEwIhRoSwh3LNtOZnG86cr4Q+DlYM9QyoaZ6ndOYvoFsXB82K8aB5d+/l56WDGq2VIXL9ETL6E3f1ZUIZ37dm8VOFXEK0pBDXvevPWWBPT8tSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRAxTSjb1RekV9atcMWDFqTKz5WQlSNfOmC1KD0lWnk=;
 b=0f55ZFkwXFs7RNVk37HsrXS39wTl9QkXjOvlw1cQ6ZU/d2Z09BYl/Q4Mrpt9OmtWAw+ODoTSYuJQGMFSoL2dNUNUIDpdJIAZVII5X2dhha0ikVjDQVc+SX60jywOPdOmRnMMJuwmZOTx33txpjsctXOH++9M17r5GIypCa40Nhs=
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 21 Oct
 2021 13:57:45 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::19) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Thu, 21 Oct 2021 13:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 13:57:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 08:57:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Date: Thu, 21 Oct 2021 09:57:31 -0400
Message-ID: <20211021135732.2033128-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbd81281-a8fc-4aaa-015f-08d9949ac222
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212C8909B8396A019A5F2E6F7BF9@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lxmpbWlw71zce0QDXU/zjy0J/8DgVFSU0GkRH3qMA9evIwK0C62glmqGzmAQ4AGynv+nbfXujaGNu96qB6wxv3dpwkXM7aWJ2xA1pKyWCYx4Ss5tzh81AnRoP4/1eBGpP4kUyAL28AS4gdErg1uTcFwzOS2GdgqkVtrfgRBEVa8SU9PP76DGEbAP8E+WOrYWqFlhmc09cMllowUeuKZiBK7qjBsdjZoWTzcvuexG5aE2QE/qnJAdGnkSYlMwr8vdeQjSgM47Pm3JU/uu/yt8Wi/SOLKQep+eGwEexPFZXtRk9vgvRZJzV32KVSjrOk849/493uZ5mi6BiwJVmYrtnLKR1hrd5NixuOjVm3qjX/yY7mb6iFSjrNIeNzhAPCELoy6veh5Qx2DO/HEckDS7f99uYUGl0tAiVsMNU6qKGaAL5fnPQqaKHY/VEdZM9yn+Ba8pQVUJqXSjfr9SShXm2qwuDzKbi++IE8Ug94EM8tSYKSEYljkPBTF3fuDb0WjAUw9LbzEgBXk+QudO/GGbXw53b+SkKClV8Utn1SJQzfriwEVS6NMUgHNz7J9JO7qnZQL7ItkcilZy6QO+0hkrDLvKBCpn/cWutIxfU0YT3ilxZ5jyzW2fGlwNssEwVl+7601Xq0t3tav1IgTu9x4ZjasEjdE2ixWqd3dHXMOGoPu5HncdLu2cEsHBxiNGVUXxJMt06jp3679+1gQc7/PAqZKWCwFjvQsUjqxjwFk+s0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(4326008)(6666004)(7696005)(6916009)(16526019)(81166007)(70206006)(966005)(356005)(70586007)(316002)(508600001)(2616005)(1076003)(426003)(336012)(5660300002)(26005)(36860700001)(2906002)(8936002)(82310400003)(36756003)(8676002)(186003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:57:45.0889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd81281-a8fc-4aaa-015f-08d9949ac222
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
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

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index dfb92f229748..c2852ec1ade2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -507,6 +507,9 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 			break;
 		}
 	}
+	/* some IP discovery tables on NF don't have this set correctly */
+	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
+		adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count == adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_JPEG_MASK;
-- 
2.31.1

