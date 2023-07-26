Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FDBC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 07:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C20C10E0BE;
	Wed, 26 Jul 2023 07:29:46 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 810E910E0BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 07:29:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLmQm0fcMthk9pdFmzqsXK+jgvG9KW5IADsXvX7v5BocG+1deSVtQaseUXXqm+StmLa04VF/Jw93bC9lk9KzKwUrXuA0f6XLEQIIWbSLzmqRMrTmodTFJxlwKy+ocQE85R0C+ryFICMzrm5ropqu087F4YzzycpFx6wJhcuXV6nGuRFujenDjlGdzJeb8BgAw6obnArwuf0KOhq0hJDgSQir9SDuYtZjzZgq8anYrsC7Diq6nIN5vHP0RkE1/xdXEU0yUiJ/ERsfiudn89GNnQm/mSgnKApKh3AXWh2f7C9BjR0+ogmWVibarQYHqP8QAIVFWjF+CUMmCG84KEq8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDDF5GiSlA85ao1g8jkJp+CRrFzQDYYokVC6kTKpCe0=;
 b=IBqPEsstMpmd3vZiKspPOWpbSwlcaQ/85onXKrABn6N1CnovSnO68E7qo00YVbpoJKk3i2LjtrrW9aU73pmquOGZDV3QIahPgjNVeCcwDSj6GKuwMnUnAlYI0tMI+TQJ1oJeP3Lr1ZHbB9gZDrKv7T+pYh8bBl/XoEj+hXmmqLanK6MEZS7mTIjFQP4fZXV0Rh4Tyj0hUlsi6lhHBhuM7SdU3oB266/5fTQ21sqZPfemw+fDxmXPlIYqKF9A/e/ETtFLK84gOJiWHrY2gjmuqesFval1Kja74VyYHe8NvD7a4X7xF9CZdJFnM+pQwqnMEDm9WQP8Qw60MqUbBO41PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDDF5GiSlA85ao1g8jkJp+CRrFzQDYYokVC6kTKpCe0=;
 b=3eLFND4d5Kcky8S9wn+D8GCLITv6ACSq1xPXL37nQNk7FXr2hbswFModU6yqUK6ob7gW5U7r7wxJQEJo3aJ1tBuAatFUIQqBIqZ69YMM+9lFpN7YoLE5xt3J/LBZ2lAZjsO5GmVvU42glx5OYg5QAWqreyaepLdnhfCpzZt9CoA=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 07:29:42 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::9a) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Wed, 26 Jul 2023 07:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Wed, 26 Jul 2023 07:29:41 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 02:29:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH] drm/amdgpu: Fix non-standard format specifiers in
 'amdgpu_show_fdinfo'
Date: Wed, 26 Jul 2023 12:59:18 +0530
Message-ID: <20230726072918.2455771-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: ce18fa57-1ba1-4b2f-f401-08db8daa13d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZSnGvV5yIMU0uZCAJy+VVgP2MikAm4ZIoGJjaePqAQnDX4799Wx8EW95CbjtQFLUIO+umggsSPDk+UIAYAQ/UIU3nJi8w3n4qNDYi13J9tUsvJSDqXxxIk5pfp8S0PhKW4loiDj4uOC3HdJ6rHvqEkmI7wDj3j0a9KMMWVnL94L002NHTt2XzHxodcxzYZ/gkK0LE27DFgA4TcYPE4eg7XbyEuCvfhh2lb4985I2ou/2WPUSjsfN0g/e7s52Oel5H5Wqp4M5RmhxX2GV5bnlclQo4qy31z1aaHVa61B7v9XVQt8DfKFd/wb+lcfXZhD+k3Xn69dgy/f55lf1bx0FwsOP0TChng/mu0rns7UitLsNyqdEB5yfvNBAPPq6S4Yq6s0nZCSyI53qyYpbTbZX9u9FL15tppGXoxRELIUg+eFSEIrWLs19T0gU73nz8ZkEH3Uf04yPyxHSdLWFwfr/78EIwjA+mptqxl1eIqNJkqq+MQdpK29yAa/3DpZ/xx4F2FsfojYjM+EqrfqgiPB681o4C8twZ5QD0m7qw9mQP/yoCOQOA0NDBi0Iz+UJJ5CJRqgs8t2eE1zvXw51nsYv13L3GykidUda1QBDW+pOdwuw5XRyyYSdSRyJ/XdiSyCOWNZcF++buTCZtURu3AubNhQxCqVmxXnqoKWzyyvQ17f2qv+CgIb7qtV8xyRKvqmD6OGGn2+Kor33Cpc+NSvkR/ahs/+lmNR4HJ3v8GlxcdUqnCHmT3D0Ak+XgIKMQSDWxMLGMT6kzNe0QjqOnBdaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(86362001)(478600001)(16526019)(186003)(336012)(36756003)(2616005)(110136005)(54906003)(66574015)(426003)(83380400001)(70206006)(47076005)(36860700001)(4326008)(6636002)(70586007)(316002)(7696005)(2906002)(44832011)(8936002)(8676002)(41300700001)(5660300002)(6666004)(40460700003)(356005)(40480700001)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 07:29:41.7912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce18fa57-1ba1-4b2f-f401-08db8daa13d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

WARNING: %Lu is non-standard C, use %llu
+       seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);

WARNING: %Ld is non-standard C, use %lld
+               seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],

Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c57252f004e8..5b253e3be56b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -90,7 +90,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
 	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
 	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
-	seq_printf(m, "drm-client-id:\t%Lu\n", vm->immediate.fence_context);
+	seq_printf(m, "drm-client-id:\t%llu\n", vm->immediate.fence_context);
 	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
 	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
 	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
@@ -111,7 +111,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 		if (!usage[hw_ip])
 			continue;
 
-		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
+		seq_printf(m, "drm-engine-%s:\t%lld ns\n", amdgpu_ip_name[hw_ip],
 			   ktime_to_ns(usage[hw_ip]));
 	}
 }
-- 
2.25.1

