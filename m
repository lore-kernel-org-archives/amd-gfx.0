Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5649BC46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 20:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCE9810E15A;
	Tue,  2 Jan 2024 20:57:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6692610E15A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 20:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkDLux7hspocZT8lST2ZJ3FmYCGMI3DsZ+0ClWnR4IeQG87Gzcj9PX2EjbUJdO9Ohuq72Mt4HRhykCl4kd1jvojMG0eWmsoQbOdFWNOZpfGLlrOav+Q6LGkAFAlxXd8PG/fkKtdScBgsbpyP2IRyjCwqFWvgUK92xNZjm5m9zElioK0Iyrk4LbR2LEVTZ1UTkFgdEBS38YHpV1/JYVZw/GW3Sl6GaGYzdZniTmQNh6Yah4pSFRkQke3pOj2MfD4NGRNhHsjQazzdMar/NTSk0f7Dq2z6+6qFpbsWT7Z/lJ6EueVKjPW+HOBVRgBYzkO1hMAjgYhoONETDNgh4z+tGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgyaoBqyXMEjpwzYLefvggB3qR3kdVpQlqn7GihLUY0=;
 b=fhuRaUJ/2+jeKyWSXWxyZggmjFuY8vsVvT0PcSfJfXNZ7NzP1qPAhxvKMmHoh03nkm0liSXcIQCNSRtYdSDsVzlaRrFAAjT9rEYplEeo685GJElnn6K3lJZb+ZWnMqXCR3zjUYt7Vy/6XbnC0LZGSpKecilkjuUYpNxj3NOs+mj5FWgTgHXGvTRE3HuOitldkzQL/jzIX0UQ0tksW5XE+TiJT+8qrJ3+He+xEAloSBPM1srERtC9Kud45dXbaQve6k5ShBdBnZX9S+9U6Nxzf+O6R0dhtQHkbOHag4aG/8gJ+MQ2MpqGZAyrOF034y8TTUODkz7SjUhzHXKFdtrafg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgyaoBqyXMEjpwzYLefvggB3qR3kdVpQlqn7GihLUY0=;
 b=1QmimOfPBmZXyd0dIFRJAGTGO90wyjjK4/VeXtBVg9+SDSBGRc0JQxu70pOMHD55/nDipyc0KWyHp8HZ22AaQrmM8vNbqP9iWJHNEF8KvlOWoewkDzk4WS9gAYITr6qLHm7kBeLlUHsJGcTcrH2oqAPPdDqEFuZBQ0n+u4gnid0=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by DM4PR12MB5183.namprd12.prod.outlook.com (2603:10b6:5:396::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 20:57:19 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::9d) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 20:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.1 via Frontend Transport; Tue, 2 Jan 2024 20:57:19 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 14:57:17 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make a correction on comment
Date: Tue, 2 Jan 2024 15:56:53 -0500
Message-ID: <20240102205653.909619-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DM4PR12MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: deb16d2c-dd3e-4d8f-f8dd-08dc0bd568f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4/A+XvZfw0+U0RNJ9fNr0QucZFyrZvr7sDRg4bV9KtrMyP0QLJUCtaUUpZp+oBHqgxIuKGa1KZNDMFIyzD8lPNB6O4Z0g9ouOE9UuWk1FV85dge99gu5Q4bDslrs86Eoo5Wq9G3YHu81lgO8ePa7VAyUzK9gZrEURiaTHPAtRFOMmgnUsUO/iphvLliGxkkd93MNcOLbZ/jl4TDtOwcTeU45A1FNJvhKowzaNUi1JZAI+x2SXPjlf6zdVBHEzVGjV2ytXIF/9ZWvls4OTPz4tQ5kMqBJUK0sOY7A/vmYoJFXdNFLwwo5NFjy4lG8ubknCLyjWSPKmprvHwBtRAlPYmlj89QNitCNXPUrWhoj53K/Fl9d5R6qHmUXR0iBoRLXGbbK2YIHGSg26HvsktuNUxDlZ1qtRK0PZpU0q+VmnUqipClMa0qrQvZXrWc19rHbnkYNxi5Lgr2hWce+lulJnPqQvjFC8TNXKIHjEbJP6I2LqkXJugCBIL04OaXCif4R0ZPQ4W1PjxDgYZg+pT+pTIdou40QZi0EmIaAN+zfz8HBtl5oxlYfuaI1e3LUmwZ0jTqJ6koQiAkHNXS1TbZN/sFlR2wEPCTfbtTr7pfpB9f03yzTQkbGX+4guIaGqReUgFmHL5hVp8OOOMoXIdtwhd2chtVHjoPR3gw/Xe8TKhZU/wK8wW+vuOa4g8TH4PVKmeghxykvLeV3+L8Fc2dj4CxpDWNL21gK5Yh7Ol8m9dA8gHSa1FcZ0gocD3ZjmWyLQVK60pMeZn6KnFeyGrZRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(356005)(81166007)(82740400003)(36756003)(40480700001)(40460700003)(86362001)(336012)(2616005)(16526019)(426003)(1076003)(26005)(7696005)(6666004)(4326008)(47076005)(478600001)(316002)(8936002)(8676002)(83380400001)(70586007)(36860700001)(6916009)(70206006)(41300700001)(5660300002)(4744005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 20:57:19.4923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb16d2c-dd3e-4d8f-f8dd-08dc0bd568f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5183
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Current AMDGPU_VM_RESERVED_VRAM is updated to 8M.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b6cd565562ad..b788067b9158 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -116,7 +116,7 @@ struct amdgpu_mem_stats;
 #define AMDGPU_VM_FAULT_STOP_FIRST	1
 #define AMDGPU_VM_FAULT_STOP_ALWAYS	2
 
-/* Reserve 4MB VRAM for page tables */
+/* Reserve 8MB VRAM for page tables */
 #define AMDGPU_VM_RESERVED_VRAM		(8ULL << 20)
 
 /*
-- 
2.25.1

