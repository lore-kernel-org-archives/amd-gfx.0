Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F86C54EBE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 22:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE4110E862;
	Wed, 18 Jan 2023 22:47:23 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A683E10E85F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 22:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mtk15hFpgpSbPUDZZdRYb1wSJNCR3dSwr41R6l/130rjBhbFHBChx74yIK/GNEx4xGyEKE1wRRZyW8HcofqoYRmXdjhWckANkEzyaEG05/A7w8gh4g/jfgdaDLOundyBDBb1WURicTQIi3EKG+fm/Wkt0pywr64w8hyaj2ugBUpuKA/7grR1omUSH1KRskwO4CjeGZVQ4Z6nZY/iKE+tfLm+ax+zGLQGM/KSa+djITwc/nHx1KIJ0lbCjZ5CGxdF3mB2/rSkuo9SqFrl6ldOfxUJRgqcSc82WBIOhQtzDRMBNfSPxD3PWxPiwbe+8kVOwLcY3xvHXm8wUC5gJkD7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8u3ddZW8vr2t/ZCbWE7fDl0bynfOGf9wBD70KpZqG0=;
 b=Jse7W9OutFmmD/oxWyoCO9EF5SfTokm5tqg/XN7cWK1FdvELjoPJ8ohr+mWL94KztDZYw5rxH3KEZd/IU8fVFm3YhFlvZ28cEmQAbRo8aFPgUNXNmXqgCecRl/CAC6lZFcNGg06ZtPqctjnYPqR5fooz395BCgEibUeQyL+nYWrNg6rcResZ6e8rnjIMCqcL0YMrj4mn7zVaiOybsusZ9i16FfQTPj0Xo3vyeLzcB3Qro6xvSNkmCja/3hCTydA98CyYtFyg4JAdaCHQEmXAvDEdXIGCkkrvh3iFGhR5bSLphWqgRRp0pi59VYJy0/znY3V1rT2G+/NFynbkf4vptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8u3ddZW8vr2t/ZCbWE7fDl0bynfOGf9wBD70KpZqG0=;
 b=uu2aRWNzNgAx1d7rTcIYSOLF9DHGONSd8iQZkEmx28Emi6tOroiLzosSoeU8sTo0Kg97TYFqcnRbVUqK8bMyC6E5I14ShBmrjB+yjIjGuij8kAKjPQJxTpxvOe51wkzgUAbhopdjwEZX1pmWhj5RFKggs4pY/5pqGDZFx4APLdI=
Received: from CY5PR20CA0017.namprd20.prod.outlook.com (2603:10b6:930:3::13)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 22:47:15 +0000
Received: from CY4PEPF0000C979.namprd02.prod.outlook.com
 (2603:10b6:930:3:cafe::d4) by CY5PR20CA0017.outlook.office365.com
 (2603:10b6:930:3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 22:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C979.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Wed, 18 Jan 2023 22:47:15 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 16:47:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: decrease message about missing PSP runtime
 database to debug
Date: Wed, 18 Jan 2023 16:47:11 -0600
Message-ID: <20230118224711.6832-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230118224711.6832-1-mario.limonciello@amd.com>
References: <20230118224711.6832-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C979:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d5162a-b21a-4fc9-4f2b-08daf9a5f240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FStyIPE794Z0qjnJ7cfZXvr9q2tj5MRuXmuIAj78eHK9T803mZamSNeHUHU1QIBiEWywOny2Im9KZa3OdKNkgz6yoIKjBViygdVXcjgdAEMjAlZrZWlfG/s4kQI6jaF63HlWQHONp8SjkdPW/IlS9XmSpGGvMm2jbZ/v4/jQuksdJy4dXF7Dby4XM4is6JyyMXJuj72r94dqxNCJNwnOX5bEXtSasP77KD2zqu6X5jiIOBvBHIhCmBwN3yHT7LyfUGvzDF2NKT/gsS816JbuxoJmga5xQs8V0HsJsS8AYS7r14oBOUMQtITy43Q8EK12ADu0cduz6kzvf9M/gLNuqmmGVoPucpItQIN8d3wL4vdkaxQx4NAqPmkZEQS0z0R3mOoaLB+P/wtyKwd/V/9BSBHXFbnYSdzZZHlrcCMtLXyGLJXSHMGWk1/JoJ6od0tdXu1akdbcjV7MlmkwN2IemdYjwhQcMfo9hNLnB6WVT9Dnhqu/t9Y/8yKebdNCXVM6AG46E7gHmkDNJhC8lp6qCuoB3fxsrGcTWPHDU7Dcr0r2UuhT8H4khv/3zukL6gczQQ0jfW63dXHk+7CmtJs8VOaUNQXxewtz+npHvS/wERAsHS4AOXNcdQNblSBQpXm9GkARcxkKj5TRkd0olMP7yOzG3ibGLhvpctiR0ghqloOzOmz/0jWwIB7aToXqdTODWaIqCEiFS/L0fykNQfk4JWl0TOajjdbfbg2yAZVi/A4iWdEPJXsn8ipagpZTobkGwuHT41swKtgEoZqgn1XHNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36756003)(6916009)(356005)(86362001)(4326008)(15650500001)(70206006)(70586007)(36860700001)(8936002)(4744005)(5660300002)(2906002)(8676002)(44832011)(82740400003)(81166007)(83380400001)(6666004)(40460700003)(316002)(7696005)(426003)(82310400005)(478600001)(26005)(40480700001)(41300700001)(1076003)(2616005)(47076005)(16526019)(336012)(186003)(36900700001)(130980200001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 22:47:15.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d5162a-b21a-4fc9-4f2b-08daf9a5f240
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C979.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

Laptops with APUs from a variety of manufacturers and generations
show a warning about a missing PSP runtime database.

As it's not required for PSP to dump this database into framebuffer,
decrease messages about it missing to debug.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b59465b14940..a8391f269cd0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -336,7 +336,7 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 
 	if (db_header.cookie != PSP_RUNTIME_DB_COOKIE_ID) {
 		/* runtime db doesn't exist, exit */
-		dev_warn(adev->dev, "PSP runtime database doesn't exist\n");
+		dev_dbg(adev->dev, "PSP runtime database doesn't exist\n");
 		return false;
 	}
 
-- 
2.34.1

