Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD92C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jan 2022 15:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709D289CA8;
	Mon,  3 Jan 2022 15:24:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51DD89CA8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jan 2022 15:24:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPi9pkA0A8i0HTZ+fin3NUHo9JfTIqgIafK+//xr//4AO8k9ExohrU9fbZ5w8i0KQ1Tm6yeI33Qp950tozQtoCr/doLSaoZMllOcclhteI9gj8fqeCRMj6011Tv7KUQotUjP1b4zR06q1uIuKzlncBNSCH07vP/ZM87+FRWW0OPOLz//in3XaxifToP1TBgjlV0WmhKBs3s3Lte0KDNV1Nqeb9+iU9RcRdmgMAw+bOoXmcCm6YukXuHPMAovNUQNxZDofRPvWDuV7RYGcJQTH8cAXS9BT5T+BKHV6lBFxffliEQ+FlFx2gNXsGXUmP5JQgO08rcZJk2ZJBsO/hiAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/wfrTEPs8kvBvgs4p9omfmdAoT1QZxi3k32cTYRYTI=;
 b=B1tiBdgw7h73tbkmci/DYj808ZL5b3nLogS28OS3YdXtnAcP8Visd0640b47b55UutFifNlEBzChWlW92MnmCG61EWDNkGCqFLGrZnvRAvDrsl2MR2Y1F+5aL5fi/o8baoZ1erX+UYfemF3eLqNNQ5bf+XKQx3v1nukkt9ueA9Qpc20QwC4DAQU0Uqqqg8+uJTl2VcER5aIZq/j2xgQz7P224sNAv6MYQtOjGWVb4vjqbbxrmAuauiCSuJa61756HwASC4w9nZbdhZWt++WPx8K8DoUKj93hAZ1aWZfDSrU49AjtHFdMGmETjSFHIq6Mar1kHdKFTbbn9ps6XbLimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/wfrTEPs8kvBvgs4p9omfmdAoT1QZxi3k32cTYRYTI=;
 b=DpH2jeq4Esr0WPiCylzCIigJGUQj9oX9jbgo+MTZdkC0fRWhLjapC87q5Zyp75/t5AaVlMyjjaXkSZclj9Z5Db9eLnGAhSQ7y78OofWVb5bZZNW90isl7T7ZOmlBGyjxL2D4ZfHrT0lOALN8x7+OTtJeJEhoZn6S0fJgAKmYd+s=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 15:24:03 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f4) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Mon, 3 Jan 2022 15:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4844.14 via Frontend Transport; Mon, 3 Jan 2022 15:24:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 3 Jan
 2022 09:24:02 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: explicitly check for s0ix when evicting
 resources
Date: Mon, 3 Jan 2022 09:23:10 -0600
Message-ID: <20220103152311.1453-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 046f48d3-c357-4b78-b7b3-08d9cecd133e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3067:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3067BBE8E5A866BC03889D41E2499@DM6PR12MB3067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PmicwxUCoSJ/0yRk3XIMrAiJNFnNbOGPcWQVVEnhLlYUIC24gw41I2P4lxODCvWzUXUUD6wrmScG+tmAH0uj/OkC5Pmt4hvnelZLhwVpud4wqQKZbi6M8AJJOqQLGWyXhVrAC0OdepyEHeE3RAl5I9YU4jdqtfsxCTZC3JXPEdtaJJmI2mEKRjpiG70RxZSW2BrdF06UbXy/zGk1Usx7vnC27lYrEoEsp5vlao4nPT++ZV+AKjxADC3CXGroZSgYGmu7etuYTUSWCCNWbTzGCQUnTyMMOTtW6vTo2QFp1APG17urDAvR+SKY6tpUpNkp48uW18W4juSXR2pXrOEzMnP8LkLrPzAwbn2AJ9PPN3rLRwhBrvB/6LyqL1NnUe6lCrWZl9qVj629fPYivX22+gFGFUyD9/GgEdHxFIL4LRfOZipy9WhQpToAczM9GrEAEu2/Sc5gvGyNOcQOJ8dCFT2F++rjEgw1ywjfXAdn6iAlVe+F14/IzraXbCy80tvss/oEdWdhFACH8SQeSCcWgoAYb04Rnou/Vh4oiAfrrM/SOgx52fmZSq5wAfnN3y2KHEZyJAAngFk6vQ1W2c1RbLEOTok22gnue46FjIeTjf0FS+GT/cyT0fVqkyxXBYL4XS7dcXjqf61cM+/K5gExLz2LhufLuilbBX7BJ9/QxqJnE7zK/4awoHTPzh/qCG8Wk0oVZpwYMyNeVGtt4XsnoFBi4R9JeaBl5zooquy5ZLshZHneJFDasoxoAoJVuqiAMDIlndJ3ISq79pX+GCHXiw0d88g2hGQrRoBEequ+9bEcqqF1nHDuCD9K9a4L44sVGT6liqjSl0+9KQmjDd1RVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(86362001)(36860700001)(40460700001)(82310400004)(83380400001)(356005)(44832011)(2616005)(36756003)(4326008)(47076005)(81166007)(508600001)(336012)(6916009)(426003)(5660300002)(16526019)(186003)(70206006)(70586007)(8676002)(8936002)(4744005)(316002)(26005)(2906002)(7696005)(1076003)(6666004)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 15:24:03.4412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046f48d3-c357-4b78-b7b3-08d9cecd133e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3067
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

This codepath should be running in both s0ix and s3, but only does
currently because s3 and s0ix are both set in the s0ix case.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ce93a304292c..412f377f80b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3956,8 +3956,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
  */
 static void amdgpu_device_evict_resources(struct amdgpu_device *adev)
 {
-	/* No need to evict vram on APUs for suspend to ram */
-	if (adev->in_s3 && (adev->flags & AMD_IS_APU))
+	/* No need to evict vram on APUs for suspend to ram or s2idle */
+	if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_APU))
 		return;
 
 	if (amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM))
-- 
2.25.1

