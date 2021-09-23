Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3747DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 04:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D9360F23
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 04:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D9D9360F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CED6E0D1;
	Thu, 23 Sep 2021 04:30:03 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB2AB6E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 04:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKzBkOFReCHSJoMx09ZACYY61RKvZgf20q+WfHAQNpsC01dxt9UKGHTO6Vp9g7+OGDUnlxyukCct+wXoUazC4kBYhRcHFSqjbJg7sP4pMYW7flLsRtA9b0Mxg9g609hD+q35uH00gARv+cUvqillZOBPBRtItawtLOpGChxB5QQf01S6+TYoBAUcxcrh/uPieUJmr6mYznzGg3VdbjvSGq/RTcbO8DCZZFzRhDRizKNKWCDKHTih1iaNDOQGx01bIQwiYGqrGbEAYgEelXWnT8dlbaQnDzVBzxoRpnpsivMEC5Eh/4ub0/gBhFUI6usvfbq/7BUYa882SgHirzNtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=7X0Cxd92tswoBPyAtfWjRfghdgIbp6LDAnPDHSiwntY=;
 b=kYlLe7Z6Tbd0Y5dcwwMFVemjhVH4pSvemGtCxNbDxE/bD9cn+2WA/d3/R3HRXna38NdVhLQGy5n8FUhM5cFr9tsUUWI3YBH1GFDHnoQKsukxNEh9gCE1SgzdQaFXf7isipyM2STi3csaQxzF3I9svrErYDx6ir6/jQdPZJRFkE+N2AGGB2USfO072HFc4oIS3DcSHzFHnoo/qySbWfqwO4OUCMegveux7asT1K2kssr3GbrOLziSvmZX/AYzWqsPHPR2kN+qcgQT8zWNf6phY4+a4JjdyLEghQbiW/mZlIhZsxeG8tM6AL65+Xdg2goXKqEdZZXLhZIXrzvu1whCxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7X0Cxd92tswoBPyAtfWjRfghdgIbp6LDAnPDHSiwntY=;
 b=rHSXjIP0B02O7DfzT86vnw4HJOZ3alOqadRcz8j9J/JNp85fEeT6NNQBPnDLOci38J/CUtsRkp7whLy7RZ89WRMWiL4+rPBOZPMMHy9XEQltDcb3SvJdpbpwI4oFzzICa7iNvlisbW09XV0VXlq+Dg8i/OTYvK3F4WB9sgB7PzQ=
Received: from BN9PR03CA0497.namprd03.prod.outlook.com (2603:10b6:408:130::22)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 23 Sep
 2021 04:29:58 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::83) by BN9PR03CA0497.outlook.office365.com
 (2603:10b6:408:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 04:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 04:29:57 +0000
Received: from lijo-u1804-kvm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 22 Sep
 2021 23:29:55 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>,
 <Kevin1.Wang@amd.com>, <Kenneth.Feng@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: Update intermediate power state for SI
Date: Thu, 23 Sep 2021 12:29:37 +0800
Message-ID: <20210923042937.16385-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf61c801-f3bf-4e70-2964-08d97e4accdf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2825D227C71D4DB74F39385497A39@DM6PR12MB2825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JoDd80tmmnduYGKLvrYGaq7iHESvllNpsh35mH9RoufHnVzG1lwsdNH7yIl84XSPUyK1FJz9zK9aoqZS61vw2EYP77uN5XDZZArZ9HKtnqmtAbeLRRL4jzouhx8zpXWkrvjpFNZ6yeub36LgnzXBlyT3x2jJ8kksXILgLsvVw+M/9krswN3TNj0qbhpJq25RhlF6IZZURZ6h9k2T4FVens89PUxg39YXnhste3DWKkoiFX2v7ciimK9K4ASdjP6zOfzPzUbkqU4BaHTsevgg8QD4k86bClNrFLxKQ+SVo7TUFBhCDCqXjeHrP1be7QKcxhD+HDdvPtGRp0hfGjvKP6pWUISH1LNVVa+YA6Jppv5xllCuSptdqpH95sI6CWq6XXzL/13VOc9jRJXCF4VUyF16mj+0A4PHWaJLyptLBPdwzZIQXMb2o4gbbftOMu4LjNYdvfnII6U8Msorcj5lO20RZkWBicJrdxzcHqB9+jhxTtXMgWmC5LTHdZb2mWWzacaHCDqaJL1Pd1AeH9rW4eKiZoIlQ0umOxDEuRfxYjgldO3IOSrVQa+o805V3Y0VYTzHIksvBsRY7OZDLZRexjS4R9rGMdpsrpM8n2QlBWmnr9UFN/LU0tanHz+s5+/T9v4T2THHfiF7C5UDAwhSCYOz1HNZeSFgwA6iAbfsv1/tUvx3DUqU8U9iOSEwZxligkE91xYGLzh+9s99smbmq8daWS3kY2/tsDZ1Pa6Vn+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(26005)(4744005)(16526019)(5660300002)(2616005)(426003)(81166007)(186003)(86362001)(356005)(36860700001)(82310400003)(15650500001)(6916009)(1076003)(6666004)(47076005)(336012)(44832011)(70586007)(70206006)(2906002)(54906003)(316002)(8676002)(8936002)(36756003)(83380400001)(7696005)(508600001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 04:29:57.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf61c801-f3bf-4e70-2964-08d97e4accdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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

Update the current state as boot state during dpm initialization.
During the subsequent initialization, set_power_state gets called to
transition to the final power state. set_power_state refers to values
from the current state and without current state populated, it could
result in NULL pointer dereference.

Bug:https://gitlab.freedesktop.org/drm/amd/-/issues/1698

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index bdbbeb959c68..81f82aa05ec2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6867,6 +6867,8 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	si_enable_auto_throttle_source(adev, AMDGPU_DPM_AUTO_THROTTLE_SRC_THERMAL, true);
 	si_thermal_start_thermal_controller(adev);
 
+	ni_update_current_ps(adev, boot_ps);
+
 	return 0;
 }
 
-- 
2.17.1

