Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB5CEB64DA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 05:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805C810E3FB;
	Wed, 19 Jul 2023 05:29:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25ECB10E3F5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 05:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDFJeOystp4RKCBGyNUWS/jpUOCdUse3zGAQA7uwaL/kJirqo+cMjse61/UP6NqHPj0Z7dm2JJGqFclMWLcle9INEiujyta5Ifoo+hVDWZXVFjADvM3782UKzj9c9asf34VQoYKUOPbOqWtWtRCtEa9+r+tw9D7nwgGvVeXLZyPSENeLLQbcbt3ek/4sqHau7l/HDHs38bNtlhkCzgTi24ZKkm2aIdgmEsbl3Nut8Vo0tx5tMmfEAW2QMbsc6C7q/hYO1FURA0ao6DzwcQrgLQNAd9Zdh/OpE5NDoJg0i7+yDQyOPidisibr8FliK/ZaRPA3JTJO5u2n2vBWwpt9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgujti8iEwzLoYBAvUDDJdx/ei1FLq7XGzLFnbqI1TU=;
 b=N3jdQz6xR+GkriIo7orD8AkB8/OhpCGkCuZy1ScjdEtWO9Mm2whgHO+K75Pn6uSc3Zkg5t4XLIyKeud29sg0Lcft63Gi9WDLo04kxtG93d2wLaZdwsOPCFctzGhonwko+Puj660OHRZ6wkWnYb57DpK+zFhwEOtkYR3wE+mF+J3FRrKy92YeXOx2VNzF6tZZd5BH6LtFSKiRz/cCXb2T+zMmFuuyOpyLAyvfmJrUhJfTFlYDL9MIi4hK6gNTXTX1DqJkDrv14tV+TTbq0mLrncXBSKyGMSxP+QQbPwQnkE96g2X9TkwGN5g/NdwfBMXZbzRtKZ0/z5kWGuGVFf5qiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgujti8iEwzLoYBAvUDDJdx/ei1FLq7XGzLFnbqI1TU=;
 b=vucpGuXnz7uOU/mkZ0ejp1k309+H+XeJpqDv9VvslZ2hf90qPuxpscuLlGE6Pf+J+cNRCvVGl5tNYc6BsPFOxyfB8GoOwIIpgfV6zYnBMmExSoBiVt5lWi3ueJbC0aNkfGk0hoe2yCDURrKrTyQnHe3E9OYO476IbFX84kBakQA=
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 05:29:44 +0000
Received: from DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::97) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 05:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT076.mail.protection.outlook.com (10.13.173.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 05:29:44 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 00:29:29 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] =?UTF-8?q?drm/amdgpu:=20Fix=20unused=20variable=20?=
 =?UTF-8?q?=E2=80=98idx=E2=80=99=20in=20=E2=80=98amdgpu=5Fatom=5Fparse?=
 =?UTF-8?q?=E2=80=99?=
Date: Wed, 19 Jul 2023 10:59:16 +0530
Message-ID: <20230719052916.833034-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT076:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fa25567-ba6c-4bb2-f9c5-08db881928f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tFyc9wINvWrO+p5O45OWYN9z8GYHkVnPs/QH5V6EYHvZVZI9hjkOkztwzosAKuLb4jKXQ0I4TeR+3xCSRh/NZisJPSHv7z3HClBlJ9n+/91RCucCbv3xjuMsATkriDTnVTeb9yKVpH45tMZVaP3SCY0ZgjnL53mwsA+xlpJg6RD3Zo0auUtiy6LNBiF+V0k07WU60UDPj3QhDr4hA/h1tuggYCOKRCCuZ1PmZdwdqR1DLNgo/WUz5LFf6SEfwhyolfTAbnnup/NbXZUBDtreSKrdYax8m0mW5VxGmVs6zvbnXcuD1gEuHKmKl+p/gO2qsMAoX97deA9ZHbqfAu2awr7NQKgeQ8KXM2AVk2SLTDAHftOHrEBUgl/NcyUQ4RfFWsJyFbJXSHSD5vSumWCNTte4k5nvJ8n5KDcup5N1RKUrPMzF5pjMBp96//rQXCz/+BXQA7v36FoyTah+tRh1YDkX/bF7RDGUq37v+z2bQondTO+dGXae1Ff2ztFAk85WK34P/D19TewVDQZN1N5woXMJXzQplOy4Vi+N1o72V3lA+AffzyVmOoAB9oqmIknJs4dRgV5LCwnp/qGMZkIKVQJq3OO0Dkhn88FtIsdHlfBye7YK6YEIpYMDSqlCBbHQewAu6cPIlEXNP/In7e1fLW+vH/U7ir9a+0P/GPMGmmU39NZloqsAbvv+xYj9h11DQQBjP1P4xF9APP08uYEvv/3jUmRilvcVUW3uiXa0w74klX9Jy9Cxq99WbKcPCpdIiOmE5Zg0pUegszuk94T6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(7696005)(54906003)(6666004)(478600001)(110136005)(82740400003)(2616005)(36860700001)(83380400001)(426003)(47076005)(40460700003)(86362001)(66574015)(40480700001)(4744005)(70586007)(2906002)(44832011)(356005)(1076003)(186003)(16526019)(26005)(4326008)(81166007)(336012)(70206006)(41300700001)(6636002)(316002)(5660300002)(36756003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 05:29:44.4782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa25567-ba6c-4bb2-f9c5-08db881928f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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

drivers/gpu/drm/amd/amdgpu/atom.c: In function ‘amdgpu_atom_parse’:
drivers/gpu/drm/amd/amdgpu/atom.c:1468:6: warning: unused variable ‘idx’ [-Wunused-variable]
 1468 |  u16 idx;
      |      ^~~

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index edbb862c1025..9f63ddb89b75 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1465,7 +1465,6 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	struct _ATOM_ROM_HEADER *atom_rom_header;
 	struct _ATOM_MASTER_DATA_TABLE *master_table;
 	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
-	u16 idx;
 
 	if (!ctx)
 		return NULL;
-- 
2.25.1

