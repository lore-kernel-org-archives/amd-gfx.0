Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FE9C3DA6C
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 18:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36ABA10E555;
	Thu, 17 Aug 2023 18:11:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F3310E54D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 18:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaxJIMp0Mxl39/zrOSRGx5HBwOxfpEb6/ok6x2tBqIT7+UtNYRd2Wzkto/YEniA0zPec4fTqOW+PB3SLjpwsfMGPuryGo2w3zwXaNaWuzEI0V7gcexml5AAqsePgptq0RUXVZBNd/mgldFeHQ1dGVuNOFayGIKoPR75ABpHt/nZX8suyNytTu2A8JoiSDr67hMdo74L1yCqC8BHHfV6pmZW8vTfWVisGe588WfQQZYkUz5FD797MV8PJpZBbcghNG59mJf91DHX9xWOzQG9fkNKBNWs9DlTWiyuNPvfxaOAHZ6/1JxY3yccO40vtkHaSVqkyNkvZI9IFygbcdeW0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6fiRqYYUJkYbMlRxKst6TI0zPxLtMiRgmE54tgwsCk=;
 b=iRnK4Zf0gxWmJklqfJQUuGh2+CTfMtMZBPk+Znsg/up8bzAfj3YvssCgbxND5PhfDGM/ZCFVQn20H56mC5wcRk6KBqdZiTPxG6fsXMPeC5vOR2gBr+4bDtj9caCJ8IerjUqHPo88gbHHv4zOtw+n+w54zntNoQd9Enmckmz59wKtIIa2aIbOsk5UZJFC/jJ8Jg7XrHez/6jGIr4wKA6uqQidMfhzrWc45LZAhjMCk7feHQPPjMckHe4fyYeekXpMUNkeslTW/KYuw+0Hlx7LdSMoc5iQPbVEnLvYoLJ7RW5c23qV3nnExzp1I2n5PM5saGA3Elpo/Evrw4hxZZMnKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6fiRqYYUJkYbMlRxKst6TI0zPxLtMiRgmE54tgwsCk=;
 b=kIO6vjXsTEAMVMHCct0m1gerEuGr2V6DBVrMT+Xnfcx18s2dWZSklGU5UxjF2C/RWnaTmS64ZRi1cJOnhBbCnmNoVdsSFQPkijLUWqE4ZAJRof+dUxVarditZUN0adzJ1dLVRUFO60nFEq33RD2DOu5To5yXNb50pnp/wcuRw3Y=
Received: from SN1PR12CA0085.namprd12.prod.outlook.com (2603:10b6:802:21::20)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 18:11:44 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::cc) by SN1PR12CA0085.outlook.office365.com
 (2603:10b6:802:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 17 Aug 2023 18:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 18:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 13:11:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amdgpu: add mes firmware support for gc_11_5_0
Date: Thu, 17 Aug 2023 14:11:19 -0400
Message-ID: <20230817181122.1543473-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817181122.1543473-1-alexander.deucher@amd.com>
References: <20230817181122.1543473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c913f94-ddc1-4b93-513f-08db9f4d69ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2QzI8bwVYKY60nbR3Fs/vulCnOPj+q9bMiqEA9pYPHmWroIXN0VS6QMMsCol5wypy2ppD9ZELddtCyEt8od5ITe6w20ReR9w5KGZia5ni56YBPPhfhMMWL0EOkMuJhL/9S1y+qfxx7nWm6xekrtCwO+3JI1tr6X/o5Qvqeorj1koGED/0og786ndIU9w9FBYABq5c2hHmG+cMHUD6hSXkuzPux+221Y1oaOJ+4amh9BJU8Vp2b84RrpOSfvMx0vqLTZktTO7y73GE2WKhf5it/gd4ZESihRMR21cov68Mxy4/djW0KIwnPaag5mIG55oHkwbmLmchYobnRBLpCDnPpCiIz0gUz+3P9/AxIM1SymqlLb39YouY9Zbh7Hnf8oQtoU3+BX88oSOSdkBL7j1kwXDl+4D+6M6oqswISqfQPMLEq0+BBScDec5SFg/2u0g2iCQQ3k8ILvkEmh2XGO4VN8trYlVoYxs8KesQutQudUfB7Z0TUzNn4QxBUdGrYr2nrAYtEnXpHbXoAPNjGfSTFewy42jJGSv5mWZtWSc8T6RTuPCruEzxvY99aaoOVGn7FHuAMbrRHxcjf7dXS2TtHqRJZ350D4eapLG8pG+FYQModHBmBfL3+UiipB8uFnwXhkEGgopv9G+9N8VoNbvuKPs0P0wLewQ7WH6V05ak60hH/czRJTXYOIXUUGyY/7RUb09C918ypAaifNji/jvgyOpHw1blUNkf7e0HbsSoXL45BDYU/HBWeZi5072qYShLU61o7vXgIZExDOaZRAqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(2906002)(40460700003)(4744005)(26005)(86362001)(336012)(40480700001)(478600001)(426003)(36756003)(7696005)(6666004)(2616005)(1076003)(16526019)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(316002)(54906003)(70586007)(70206006)(81166007)(6916009)(4326008)(8676002)(8936002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:11:44.2070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c913f94-ddc1-4b93-513f-08db9f4d69ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add scheduler and kiq firmware support for gc_11_5_0.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 6827d547042e..3fa5bc3ddf92 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -47,6 +47,9 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes_2.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_5_0_mes1.bin");
+
 
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
-- 
2.41.0

