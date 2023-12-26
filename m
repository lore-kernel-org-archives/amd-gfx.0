Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5541CC46CD4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Dec 2023 10:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C4410E08D;
	Tue, 26 Dec 2023 10:04:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C75410E08D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Dec 2023 10:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW4mqXxX0HYq1wY5faPMWQdEUx0+SlPZxlVnlnetLAcgmhYJcjeE0jea9WJPGDSNziTiuxfxMFcUEgmNBOq4Ry6/I/hOHVQchf1UnviyHTkkYWl7ueMYx34V6djpjVbbKaxSM2nduQ8VlmBAbSMloEYhYq2wPj0RH1H0cDRQthodHT8+QSxu75RgsfI/tPwbXRXvYW5EQsDy3WZd6A704qNhEzp2gy1Q0MlnUlcm/TH8uHBa/54nQijxV8+A5RpktwbHTNYan5YsSyw2x1N3naTkqxQqIR6TMg92XoML//195w5sQc4+dgX9aYH80YPpRp/Ospzcw1C8k4WDhdF/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydu3Wn6Xv3L4AiVLbRHWOPlwO3ruyQhQZPndZiYHqWw=;
 b=dpjMXOl5xYa2XMsDcKzLMG2DpeqO0VgcAKl5z+GyIJs+ZyHh3LjWOt7FVf9+4rDJzhU8SEZmNH19asrtC9xbm+vkqrsCI5xI0alEKdQulE18pWuzFhMQwe2dkJ873DwJ6l/esxQZthMrM09Ru5dnkp6qcYonejW4bhWVmzMvGrGtp/iwnRdmKiWsbD/OOxbnOvY++WuCfQ2MuZ5wcAM8K97jleTN14revFQsvjfLAUU7gc4yLiuQoYblho+AhkFS/yVysC4++2/T582+WFEfbcqB755rL1Bzd5wp8YPTwNEjyUDW64CWfBST2oKQxwyX5riMjxXH3vZ71fuFOnYv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydu3Wn6Xv3L4AiVLbRHWOPlwO3ruyQhQZPndZiYHqWw=;
 b=mgMHErOmWVxry5yLmbY0JjIAGpgxqRsjCSdZokgYJGLthk/5pvcaIZ4CXoR1iP87KnJf5A1RQvgK7gRr3fjrfs3q1CDCKYDSYV0Ud/k2QG1CBmF7tQ/psmBsdP+pR9Kl9puAD4z1mRCkQKT6F7aEXgyTtniJeLVa8R7FrIGnwfk=
Received: from SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) by PH8PR12MB6698.namprd12.prod.outlook.com
 (2603:10b6:510:1cd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 10:04:47 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::c0) by SN4PR0501CA0126.outlook.office365.com
 (2603:10b6:803:42::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18 via Frontend
 Transport; Tue, 26 Dec 2023 10:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7135.14 via Frontend Transport; Tue, 26 Dec 2023 10:04:47 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 26 Dec 2023 04:04:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Date: Tue, 26 Dec 2023 15:34:25 +0530
Message-ID: <20231226100425.3129745-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
References: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH8PR12MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d40ac6c-5524-4c74-310f-08dc05fa175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6Ot6XvRRZ0w/7AKgDEhlZi9fHG+RCbl8sIMGJpxlr0geW4FEM9CScvb4bWa9D6B6fT7oZVTYSh4Dx0kemIvjCmLU3ikhINUP/Pk1zdhF+bNsLivfXJ4zK0QORa6Edb+xCMT8HTu0K0a+aVohH0wsnT34INUtB5GHTSBosj5PNeiBjvZ0yi3tLxF9tPkOJvX0YrgFccPQh1UKjxRkB1fgL+jOPNgLsu3vsGBWrcxJdBmEaB1PIm0IOKSwOfWVkExn2Gq2JA/nB6ePHT/Q3IIoSjDnWqMDKf5M4TTILA3OBRSe7y+93+dU+ZiRSmg1pHNdiS9QkGqaicrmg4ZDSnuV8RRZe+AabgXW//WY7SzgFwa9Lp8AASDyMzC2ruVCeUKkGuEp0G+gGEPcisQLDQo2zFN6Hk05hbY35bub70dlehf1LxVdBf9Kb+8FYuzgg2E85ijaLHlm5TzB31gDuJgzS25wfkZwkTGxnBJXiIV94j6PJXySguHbKAr0NUfTWtzvFb8XnlvQPVHo0BjcZwRzKAfDTbB0DXVf8TeC+0Ga33Vw9gavj2uTfR+jFgwS2Aw/pwbvAx/MLMfHumfiEZ5Ru7PzYkMfK7EWYurnIlgIyrjc2xge7PeH/D87jpeCVSBtYyKYAA340Gpk2k6S2Y73YdGdBlTnckT7lrG25nSOmeWPcNXyyVYOA0cW9nlWs4796f4Uvb4TNl0/ZQZa1QJmL9vzHGNpMSNu1nuLMNGE/zVLIHGeqZl5AfwnHDOwlTyPCwgtfo1fNZ1qJZJVd5fxg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(6666004)(6636002)(7696005)(70586007)(70206006)(86362001)(16526019)(1076003)(81166007)(356005)(82740400003)(26005)(83380400001)(2616005)(47076005)(41300700001)(2906002)(5660300002)(8936002)(426003)(8676002)(336012)(478600001)(44832011)(36860700001)(316002)(54906003)(4326008)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 10:04:47.1220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d40ac6c-5524-4c74-310f-08dc05fa175f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6698
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
Cc: Tao Zhou <tao.zhou1@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return 0, if blk is >= AMDGPU_RAS_BLOCK_COUNT

Fixes the below:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1183 amdgpu_ras_query_error_status_helper() error: we previously assumed 'info' could be null (see line 1176)

Cc: Tao Zhou <tao.zhou1@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bad62141f708..327415a15b05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1176,6 +1176,9 @@ static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev,
 	enum amdgpu_ras_block blk = info ? info->head.block : AMDGPU_RAS_BLOCK_COUNT;
 	struct amdgpu_ras_block_object *block_obj = NULL;
 
+	if (blk >= AMDGPU_RAS_BLOCK_COUNT)
+		return 0;
+
 	if (error_query_mode == AMDGPU_RAS_INVALID_ERROR_QUERY)
 		return -EINVAL;
 
-- 
2.34.1

