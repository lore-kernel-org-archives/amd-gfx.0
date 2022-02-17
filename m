Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD411C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 05:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7351710E373;
	Thu, 17 Feb 2022 05:44:57 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE7710E843
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 05:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbSIZHUuLtENb7Qk7BHkRvRaCrqCdgQ6JqJnYODhvZ6jwvSvUo9H/ru1U7QXLMR+mOghYrpgi8mA+cgDT2c5dWpnSjUxm+M5pMTuj6xA1AJ+Awk51qOj9pchmbB6DupPaQLpwd7vb4GnxpwVdzsWmVcrbea0Na4ui9g1x8AlnG0h6e57nn0inGED00WIpHUODU5T/ROO7usGx+wmiuPISGxyK8LAtnOTRK+ubRZ+CdIPzo9OR1d50ZZlw9ayx3ZUOCu3nHvORuKMLkJKph45nT8DXyQk31lsRKoiYJRNSDz5sLeajYxVyKQuzV7F28nBy5UAD3SPE6N0nJqP+9XnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDBu4sW7gH5IkQ47hfIk6NU3XdLOB2uOIo/oVD5jTkk=;
 b=XSzpMYbnENXRdwU6R+b+hJCTpvBZ2PyHsuUSfRXvwMBWX5/zXeUUTEnKfGvi277iKALPY2rJfXgGnoRie1q5LPhhfgFqSZWpJZpa3cbsiqMPXhgMcr1+WPnZvGlWpInyjbf7jkAqHaqZkTtgHkqMjUO+3+b0hwSV6vvr8CYLerqe+29XYFWzBnxggmkysBzR6uINbg6T2DLl7IZpbC0QDPJVWl20vEmmPFLerGMAuQkQbFmDdHT+W6k/PBrGgp3/YP7Xu9P3v8H+frGEX1fZ0+Y866A13YtHwP5U82vdDb2yOF5fDdKXhU2etDP28rSqUu9+vDuvkErN5xQqOeuE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDBu4sW7gH5IkQ47hfIk6NU3XdLOB2uOIo/oVD5jTkk=;
 b=AtffeTHJG6e4yHbITJOlTmPOFnQPd787hPIs3BtPceOSA/hFHhaLglclHaLgu1T8dPk+mJq5W4tZKlZQHaP6Mb5c+ERx7QBt3+TDAyn92GDuh+mtAkWejKSLpIc8pcU7HWmkL9q2upmCfMV1j8ZIY2H17omiup6VEtwbYQ4xNV8=
Received: from DM6PR02CA0160.namprd02.prod.outlook.com (2603:10b6:5:332::27)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Thu, 17 Feb
 2022 05:44:55 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::7) by DM6PR02CA0160.outlook.office365.com
 (2603:10b6:5:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 05:44:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 05:44:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 23:44:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd: Use amdgpu_device_should_use_aspm on navi umd
 pstate switching
Date: Wed, 16 Feb 2022 23:45:04 -0600
Message-ID: <20220217054504.10535-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217054504.10535-1-mario.limonciello@amd.com>
References: <20220217054504.10535-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb758e30-285c-48d2-1ef8-08d9f1d8a00e
X-MS-TrafficTypeDiagnostic: MN0PR12MB6003:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB6003AAA86205519A094D05EBE2369@MN0PR12MB6003.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNnnrDwOTtqmJXLRx5v2FqXt8h6y0qppks9QIzcfUWzphBXYx6tt6UTOecFEEn6xfVxr2z2AVgBksvqPWSPEN3SNcS7x1QlybpisV2OVV0Myo3Q/eF1w9U4N+Ed4C6Le0V9PN0p34zPgjUmO+5RoCBdO3WceEV4mVNX+4sHPSzn5dHMllwSJtHeWDl8bzMw5MAxOQnXr1zp8vhTbyvqtNy6azKhFd5rLnGoslug8g9+Dc4LYLBhDikkxTLoNOJol34GKz6mKlOZFxyeRGXoWI3FKH9DRRrAclrMn/AUqvZCxytP+6bGOqnptCFiR6ZAAfLGBkKh+ClMco9OJ2FoDhtZA5ZxSmM8affd/w3ADI0rp+oi8hzlZMZzlgSXgHSbUTRThVuQoc830lR8Qa6SMlBo09YR7Nyge2QQIa0WQOo1CmNTijv3cvaCebCvX1ZsvWTUYAhF2Oa7grj/kTbKT92nNl0GmbB3togCS2hOPXxhRWdS8cWnGI9JtgNwDoII0t0oa7Z838W9jpNyMcb1Ulk3razoFlBigQ/RmDv+0GxrezA+AsLqfG/8Syg28p28SjWZPubjYu/5+GKXvZcGs9G3XpUWOwvCM5nSr2Zynuc7B6aituDm/3Xy+9Oj2q7IGgZgc9P8pSNcwNxwuaCxD2yvThJyhFH6241NqfCTjSMGoORq4D41s0uZBh98cZC3aZfwik588Ltl3j79WHqkPbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(508600001)(81166007)(36860700001)(1076003)(2616005)(336012)(6666004)(186003)(47076005)(7696005)(16526019)(40460700003)(83380400001)(5660300002)(4744005)(6916009)(86362001)(8676002)(70206006)(4326008)(70586007)(356005)(36756003)(316002)(2906002)(44832011)(426003)(82310400004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 05:44:54.9052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb758e30-285c-48d2-1ef8-08d9f1d8a00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The `program_aspm` callback is already guarded for aspm, but the
`enable_aspm` callback doesn't follow the module parameter.

Update it to use the helper `amdgpu_device_should_use_aspm`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index ebed9c84db04..b246a37f4f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -635,7 +635,8 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
 
 	if (!(adev->flags & AMD_IS_APU) &&
-	    (adev->nbio.funcs->enable_aspm))
+	    (adev->nbio.funcs->enable_aspm) &&
+	     amdgpu_device_should_use_aspm(adev))
 		adev->nbio.funcs->enable_aspm(adev, !enter);
 
 	return 0;
-- 
2.25.1

