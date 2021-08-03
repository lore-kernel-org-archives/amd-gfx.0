Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D04C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718A160F70
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 08:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 718A160F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C0E6E487;
	Tue,  3 Aug 2021 08:42:54 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9647B6E487
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 08:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu62PmIPDJXJJKjEENULmLtNWdV0j8oOwoPr0FoxBxnzMGJLMEAJMn0uk6eY5gV1XUsQGOHKZUXKTJtozdN+Qz+aGPkIcTn7C+JjWxkyCmkB+5eJ9ltZJPRLcCeF+Jfwwy+4SrMl08PE8h2RjTdBKSHribkw4Vt1ntYK9aCpVRblUAy+tRWtccXOj4gBjJQMqj8jy7OVE/823/Phxlm8cWYZJ82K/yHHFwB5veIaT39fZH8JBBsRTPbQHR0B/UQQK5xbxgHnBd5hJ0LVquqR/bh1vHdd8Vc/LNzKo1uYnNKyY8XBQQrMtY+1hPuzodYnowKW/2ZgRwII7htz0qyjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhlwLYDi4fiqG6euEHrWUaMefVHC43y8s+PaxeVsAU=;
 b=C8QJMaGaD98nshlCSHaLGsauWdVrIz6EFBu7V5DaHUl3yYbWdvfFkTyoNnU1PLbwd06ko2GjLKLCWQw+OPCBMUNlMRvcBlgNEeQYfFVVBq+mZOoi+QiIUcGE42kzT5Y5z/rPAobQPQbnB+qiG/FSwCwz7fAT6YlW7eAuHQ5A8U6DZ97o40bAmQZoOXphjJWz7tave2ZcneEoXKj7lqynAnIlyAK2n9AernG3E/l0Ec0HKfS4db8s7xxxLUA21DQ9Kams3tzbNz2DmsEpStJI5BX1yR/xDgwcwI8TldC5LFDOJwr3xWzZijMWIX9+gJ91icYJhY3gw3kGMCo8UpTolQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhlwLYDi4fiqG6euEHrWUaMefVHC43y8s+PaxeVsAU=;
 b=Hwoj38ktpGVdxCVzz/sEIg2pVyETpyLHuG6i84U6VwS4RmR+ToIM5TnMoOS9asASie1lOU+Jss68AlPQ0wHy/ysVshZC8MmA0zd4r3RRhPJGnSXzTpToY06yRgyUAjYJ9hqEdd5UwC/VKZJPEZA0DmOCNRJ2xv8N3LoWVO3KDlQ=
Received: from DM6PR07CA0097.namprd07.prod.outlook.com (2603:10b6:5:337::30)
 by CH2PR12MB3655.namprd12.prod.outlook.com (2603:10b6:610:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Tue, 3 Aug
 2021 08:42:50 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::e9) by DM6PR07CA0097.outlook.office365.com
 (2603:10b6:5:337::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Tue, 3 Aug 2021 08:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 08:42:50 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 3 Aug
 2021 03:42:46 -0500
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Shirish S <shirish.s@amd.com>
Subject: [PATCH] drm/amdgpu/display: fix DMUB firmware version info
Date: Tue, 3 Aug 2021 14:12:28 +0530
Message-ID: <20210803084228.57992-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5447a24a-7a97-492e-7935-08d9565aad45
X-MS-TrafficTypeDiagnostic: CH2PR12MB3655:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3655916C74941BE40DF744F3F2F09@CH2PR12MB3655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk3YeDv01xypEqsHLTcxbI5pj8V1f0wuN06ZmPvHVgtlwXj1njwd8k2f/158hyFkumV9j93T9zhyR32oY3+NnwzWPa9u/VjC9c7ty8TQ9qTTCHqiTJ6p+1KrRvN7323PEXapmulEBpySYPacTZtTca3pGQJYuBM4vHoHK6Oy5L8bNEdh+6nRIgMKTF/CjBRAVABKMxhXa08rRnrThzgBttYzPKJmowS3/lt2jnZZn3tGRvS9YwD/MXXtpyDjM3OrPpH57TkkjBCh+9t7HmkwJ3+17kE//qj+iUPDzbCjYqk7AfNZVtZ7m3bmR1SIWsktf8K3DFJFylbwk9y++ziCaaGvr8dVjDeZtDONiN6SoD4yNTXpVUY4qYrqOCxf8cRanEAyvEx6aIbHQkzIilOWIEF9JQaRIGe+FgRAav4TH4uf/AN3BdwW9BJdet288PKVt47WbWYCg4xRL2qJRsC98DelSI4l7QMiDBLJZZdaPd/3XX/rkL5pkiYirXbSjdlNeCBrGHTTGSmQO6PwZ6jR0Z8phhlqT2lsG4zLr94dNYRraWIxNQ1rvk+Sg+h4gItlkTGyambiTqQTZBhXsoLV+EpSJ7YyDIrZV+WKd3ypk0KT7zRsQtKLspy+xq+iT5Uw3kJGtZHA59SKFylD79T/jERrEj3dc/aIFm0owTtNAJqyywX1J6mSgho4+qJ1bLm4FhpremqWXfMJiu/kPmqFLoCBiiLeEtyU+dHgRrcSphY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(46966006)(26005)(70206006)(1076003)(8676002)(8936002)(36756003)(70586007)(186003)(36860700001)(2616005)(5660300002)(426003)(82310400003)(2906002)(81166007)(336012)(16526019)(82740400003)(6666004)(110136005)(316002)(7696005)(54906003)(478600001)(356005)(4326008)(6636002)(83380400001)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 08:42:50.2933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5447a24a-7a97-492e-7935-08d9565aad45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3655
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

DMUB firmware info is printed before it gets initialized.
Correct this order to ensure true value is conveyed.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e09b6d26a51..396a2dca2fe0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1548,6 +1548,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	}
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
+	adev->dm.dmcub_fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =
@@ -1561,7 +1562,6 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 			 adev->dm.dmcub_fw_version);
 	}
 
-	adev->dm.dmcub_fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	adev->dm.dmub_srv = kzalloc(sizeof(*adev->dm.dmub_srv), GFP_KERNEL);
 	dmub_srv = adev->dm.dmub_srv;
-- 
2.17.1

