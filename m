Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56419C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E983F10F42A;
	Tue,  3 May 2022 20:47:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4829110F428
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZnFUHvzwynK3JcFdcl0HbjYO5sx0HGe8Ab8i7/xnnbaFXGVxStHUfDbfMQVEYoFNZMl0moVf1bF0xElB9WGoDIr8fbaS42d2zi3SdkPcC4zXnpzB9PmnCYl9t5kSGhTOv9yUT7lqeLNvjreWXHKGQeUx9/JAUO39Im+yfAT1mxyx/xOncNSGFAXIBCwWBvfmVodrCjgofSHWPY4wJcY2K0LR3HY9FcOK3zvx1Gevn8gGpzz4su4nxVevDtIzXu4wtYPUV047rbE672ZAIP8fKiUD30v+ep2BLeG9lwH7xXoh7sE//BFu0cA+NjMOKb86jjlnI0Q/VSBebe7lvVnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUG5Y3oYHnptKbbI6FDMOC6ZVSxIlvKokgR8novy+qM=;
 b=mjwqkzrlxc984g07kgQXPiQjcT2n43yi8mxrMQ0mczhLkcCDw9jUXPzcml+5XljdqhwEZ0+S17WoqvLxoXUgBydHxeQTKI+jS7oCF1sS4X7vxIBGU2xgLBtX2ZsNLX8Ej4diEvnM0HZuvlyJNwHV9wx4WFOlqDyYE9u6+QvByC7b6yL58sQn3PWxjIC2vXZVImEjmwPvtEKOEhKo7y6eXwCSchbsSBhKLNM2+ak1S8LP8E5ubtIVmnIfwLiSpjNT577e9ko9SoaAxwGMZjBd93GUH4k8AgAePHtqx4KrlV4UCRqHWZ8DaJ7PlS8XXE/VrgFQyYR1UmNpvxk+vQkMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUG5Y3oYHnptKbbI6FDMOC6ZVSxIlvKokgR8novy+qM=;
 b=kGotvB2EkuALzoxP1tIGQHvtiCPBdMqyqo89xQkdbX35Ed/bODye9KQj3FkpzRTLS04w14mij8hqn9P0Cx20/BZqkGHwuMaCxVietWSf/X1vVTaKULDPWh5/ILnQYfZuc/wVKu+whGmzS13+pKjxke2PZKMXTz9FgcG+Uh5odG8=
Received: from DS7PR03CA0145.namprd03.prod.outlook.com (2603:10b6:5:3b4::30)
 by DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:47:01 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::5a) by DS7PR03CA0145.outlook.office365.com
 (2603:10b6:5:3b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 20:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:47:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:46:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add HDP 5.2.1 support
Date: Tue, 3 May 2022 16:46:42 -0400
Message-ID: <20220503204645.1266993-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29df331c-28d2-42b9-3dbc-08da2d4612f8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32254762A33FA617D38FBB30F7C09@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QbjD1Wl4dFn/O9k+x7a/1TDDhcA7WzqIkvouR/XXAdb2T9YUNoSu2xr38p/+Wa8/ls+eJ82FECeyuI/fLN8PK/lIoba7lgpzx0wGdjfgXX2waYhykfQ//RaGJ4YJwmovr4f5eQZkDk017UXWwUQpJenncm8/1eu9oPOp+zETGS+suVmgiGiwW7SrTudk4fRhWYm/l/s0FyPu9Vt+v6Shk9DUV8Ml1FFePSOSwVJ6lgof8/5gqY8yA1nUWTfpNI3MD43+lQatJ3zmgrApm4aAtQt7zZh9ZUnnsho8Jg4vklMD5KmA4ORVa5jYxjDRXFf0sF/v2J5IdHNo/fk9ien9osf7CN1ClQtOaxt1Qx6R3BgNDGQ5NiAIwNzBF084IvX8CVj0un0TB4USrW2T7HFP3kAscvOFvvzEHsfClJJ1m36jKX8tFeRCem4XVqwmGJz2ScTny2zOM2MC5HQkWwJXcMdhmD60QHVVJSHmgQWHMQRt2SrJFhSrvYjwOKvulVL+A4/av5RosDg0CQDa2JxrCO8A3c9e1DjXBADciB27KSl97L+es0+DCFhpjL18ODXgckwk9JPo3mB87/URVoh21pMRPvhqFM40ChTvCseMcNHQQ0J/U0MZX68WskZ0NIm+v65KnP2jAUbnSqS/O3gFxwQj5pvdGEyzSmlto0yJNLAxwPQnXfWRh8A5gpvAq6F6hJk8gAX8fmL0iELvgPSEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4744005)(81166007)(82310400005)(316002)(8936002)(5660300002)(2616005)(426003)(47076005)(26005)(508600001)(1076003)(70586007)(336012)(83380400001)(36756003)(70206006)(4326008)(8676002)(40460700003)(6666004)(186003)(86362001)(356005)(2906002)(16526019)(7696005)(36860700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:47:01.4472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29df331c-28d2-42b9-3dbc-08da2d4612f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds support for Host Data Port (HDP) version 5.2.1.  HDP
is the block that provides CPU access to framebuffer via the PCI
BAR.

Huang Rui (1):
  drm/amdgpu: add hdp v5_2_1 ip headers

Xiaojian Du (2):
  drm/amdgpu: add the files of HDP v5.2 block
  drm/amdgpu/discovery: add HDP v5.2.1 into the IP discovery list

 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c         |  45 ++
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h         |  31 +
 .../include/asic_reg/hdp/hdp_5_2_1_offset.h   | 217 ++++++
 .../include/asic_reg/hdp/hdp_5_2_1_sh_mask.h  | 684 ++++++++++++++++++
 6 files changed, 982 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_5_2_1_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/hdp/hdp_5_2_1_sh_mask.h

-- 
2.35.1

