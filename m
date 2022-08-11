Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F711C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 13:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02CEB8E7FF;
	Thu, 11 Aug 2022 13:42:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D83B8E7FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 13:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMm45Bf2TJk9hHaKqDtbmx4jQmm0YWv5qFnTAt0bvWy4uTv20wkeKeNtv4r26UBGmcf+FbEKgzUgfZs+Pd8oijmRlAeMfv8rX8McuOgr0pZtcxBcInsW7bjnt7BSpktHt84B7VAqwLdWbuveprU+KttvIuMqosTkSPrhNPfBip0lB2cIeZWEt0kKw6IK8fzfv8lNiYFov5yC1eP5aDRhwje/qr0x1yqyAeiynmF5hNceVadh35pqj8J0nH3ZZvesWT0Qet0Mrrw/floyByKeQ/F43F9QXJvMrUMNWI24w5oJ+y9HOu7QxwKCF4MLvLWsogr+3FEz71krFSibB2rtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vB32WItSg5sHCIT7MdcpH1DEv41DVAw5dj+/kSjfR0=;
 b=Hx1y2vP7hv+bMfhCr4fuc1iSDXcqQqjvgij+PJmFgaZMqJcF1odKSOs0ktRvb6pN/Elh5XLIgltDElonQsE40kOd8ayK5vkLRFP1QBPV8t55UVQQc9nQBVuTgcjc5gfzFpP69NLHaT1Ik5xp2IZ81qGz7AhDGvl8Bnyav9YTejegs0Vx6YjmG4dwpLgx4hOa0Py1IbwUrq69HwXvNCfaintAAjUYMT4KFqmjseoiWOmcz4eJ3EFMJiMEyqmgloccyqVyhn8FuVFNxlOBtRv2PjqCtJ2Z4ydHZdqI/jUT8h7cdZinPufkUjYUZ99leuVCDJi1S0VzlB9u4jQ6OrUXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vB32WItSg5sHCIT7MdcpH1DEv41DVAw5dj+/kSjfR0=;
 b=yOiX8Ta4Zj/hr1OyVO9KVjIPLxFjlzgsghkKDQas77gTLo53OKHhCUZNbMDXgJxzVkkxt2Q+1u3S6nBDVRf7QfPVZwHds0W1sifvdcgQlUDZ+PduAPhw6B4m4cJzPwE3Yr/XMkHGpxc3TKGWzBeoEwnTKyXbGNv7wFhbw+IXUO0=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 13:42:38 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::aa) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18 via Frontend
 Transport; Thu, 11 Aug 2022 13:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 13:42:37 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 08:42:36 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix reset domain xgmi hive info reference leak
Date: Thu, 11 Aug 2022 09:42:17 -0400
Message-ID: <20220811134217.138701-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 260918ce-ef17-48ee-e3e9-08da7b9f5adf
X-MS-TrafficTypeDiagnostic: CY4PR12MB1703:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWeBmfHFt8TZncYxuTbn5XjkyUuSfZkfl51YpntQ+JX4NFWJqcBdXCSFu35IoRJk4SZz7R0KLG13Y0VMWigx4hW34I6TraDF0D3fmu+f3fwIGIMkdrCJCJ39Ml2O8yn3VgQM0IbI9174BLnuVxvAD+ROcHPSwqzUCVYfvNhDZ9EM4HjdJiFR7WiBnuHhaC4MeOea8VnPD68zhfEuoduGjFL5rGK0XSTiH3MAkF+RBSN917ZMiTgjwXy0oup47D7rj9iJIgVBFo2G4FSIfhBkaIzW9NrHFw+PP4Y/GgS9sM017OrUYXTqsH33/I/bZl9pwyQTUa9AJ1sW2TA99NPJsZunlkC4pI/DCTzykVGTQrpXl0Hw+sHUezzT12qwa9Q2UaZbrPzfCZYyp/hLCjZVBdfzkbBpDDEWZoktfvbG6tsbsLPsDog0oJYhFnZgMY8iZuYeiRP/IjVxLrmBsMlk7q4iaoezJhsCmuF9ib8zi4CLyvQcn4w9WT3dmZSbU3m4F+JT3AzHqUOjjcrsccxoq4qSe7DUY79wy7H/4LrRk3MgK7Ux/AXkbkqkMSFaNF2LwMjQQaUxc3BpWnpL8AfApXqXxkXQOVxSySvlw6SJ4RzKzjpbgH2IEAqCG3a6k+iyEh/Bq0HBmmCKRCdmjMOZE4SfgWg5l4GQAKL4eDJwAfhSe+f2X0Zf+5bcK7KhrGYS3hpha58GcQPlEd0Kv9qUCG0WDO2SCZS15rf862eM+n4w3dqKJcWZya97gaiw0ewO+tzvcgBtWm8zDE6j2aLmCiniiEzAU7U8Umr9RaDK4UPE2uLntdSmJvCEITGbx3JZ5hPxYcb0sax9ietvhKRO9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(4326008)(26005)(83380400001)(186003)(6916009)(36756003)(2616005)(336012)(1076003)(41300700001)(47076005)(8676002)(426003)(86362001)(316002)(16526019)(6666004)(40460700003)(2906002)(36860700001)(7696005)(44832011)(70206006)(4744005)(5660300002)(70586007)(40480700001)(478600001)(356005)(82740400003)(81166007)(82310400005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 13:42:37.8173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 260918ce-ef17-48ee-e3e9-08da7b9f5adf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
Cc: Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When an xgmi node is added to the hive, it takes another hive
reference for its reset domain.

This extra reference was not dropped on device removal from the
hive so drop it.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 1b108d03e785..560bf1c98f08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -731,6 +731,9 @@ int amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 	mutex_unlock(&hive->hive_lock);
 
 	amdgpu_put_xgmi_hive(hive);
+	/* device is removed from the hive so remove its reset domain reference */
+	if (adev->reset_domain && adev->reset_domain == hive->reset_domain)
+		amdgpu_put_xgmi_hive(hive);
 	adev->hive = NULL;
 
 	if (atomic_dec_return(&hive->number_devices) == 0) {
-- 
2.25.1

