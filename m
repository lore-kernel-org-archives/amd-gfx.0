Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB730C433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 03:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E8510E231;
	Thu,  3 Nov 2022 03:39:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD0810E231
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 03:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WC3molO/35g5UueJfUxvFi1bIX1DI/M3zczEfTZYfCJw2GJECrKjSEsO4spSiOXeTKcwCQQcmyrH5Y2RBTtXh+USE//aOB1thHl5bz2iit3AMqlb3QGA1ZiGMwwJIj5OpdzXoug1pEFZ8sposg4+QWf/sXHWwXWckRX9R5IrjPa72+W+4U27ief98Ntd+/4i29B27IbOz3LHEzHnQu3FNx+QBwaRS6vGVlBblZmDFj9bjVAHvOOZAq24fQWBKVdiet78NkRWhT7+9FdyFq1aH/NGRRJNXAAILvXuBT1ByKYWaXA6cIjFPzXbJuUAndiCbXHIT5Vxf8j44VQKHqwGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcDQu5HH4VtpW9gFOnRR41iWERV6mMO1AueDK+DMUwo=;
 b=YJfTTZZupD1l/Afy/VATB4vKTE2JKF4FDTbHAQvL+UGkh6gztTROpCr8+zOUla7WoHXX7qCfiKzmtg/cq90T46Fulxvk59AQnGE6FhbgnhqU1LqdWnFkWvaa97RqudFhXb+sB6XCqapK2XY2HSUW7o16SaK9HN2VVcH5yve/lFQjdU2X6v79leo2fvEZZwbPJE6EoxVRdaq1QGItnGfyIYqe+AK+njjA8lmBlYsfy7/jpmS9JzV2S4Me0mwB0mrQ8TkNwEXRw/3rxIXRt+Jop0pJ0DGrb1hWrZM5ayeuzAepYgok0oz1ZkA9ic8CzVKHZN1wKHqDDm14opJhJx3a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcDQu5HH4VtpW9gFOnRR41iWERV6mMO1AueDK+DMUwo=;
 b=YldvfrX7X0zo5X3unjRYsuZMBgGp+NtfCjWJmuPk7aXeKw+ppk+XGKtED7KOHtlLVvzZFySSXejqchz3M+QydlrT2iKDVsdC4I9nmJ9C4zccEoNrZrWYn6tH8krBqbrNX2t4y4azy3O807iUpCcIEhuByg+hFkoUN+By4Ywq/ZI=
Received: from DM6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:5:14c::28)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Thu, 3 Nov
 2022 03:39:23 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::67) by DM6PR11CA0051.outlook.office365.com
 (2603:10b6:5:14c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.21 via Frontend
 Transport; Thu, 3 Nov 2022 03:39:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Thu, 3 Nov 2022 03:39:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 22:39:19 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Wed, 2 Nov 2022 22:39:18 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: temporary workaround to skip ras error for
 gc_v11_0_3
Date: Thu, 3 Nov 2022 11:39:15 +0800
Message-ID: <20221103033915.1403759-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: cce1a781-ddee-48fb-138a-08dabd4cffe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/y90BJOSnN42xqXoYaZOC+se4h6wnU/GaXMOdk24Qx1MTXWUFzMlUMgD9lNDg+iLURZgAbyhuV2bli98nG/MAWlLRQvZr5mXn14hBiyum+7V/dbG7wmF8SuLi0kFn2kxDUFcjVNy/6Lg5ugEj0Sq9Vnt5kIZpXy/okaWj5qdzPB9UsYNRM3tI3r2yfliQH4yDglsQ0gA/+AH5QyCZrR1FLfgFjws3UVct2WcAh8f3gFEjdky2cEpfajxDuxzZl/5k8u8coyXH+dWM1aP9TMP8X5Z6hHVP1yAWLP/9Y2owTw88eV5+5mcrdw05Sad0GmfYUFNDxPPB4w5orb3ZnP1qEH9sAdH2/zT/K2F7wygm66/wEsXLkOB4ePffgSLXaBMS4g7Dx9EFlmdz/V0+g3lGa74jd4BvCPlPdgxQU6AGri3/wdmO5FSvw0VP4QLFz82bLCNbkwG2yuFTDSChaKsouOI28uqGGrYs0vnDuDCYWdgpf/vo+OnYBJNnBYhrVNS/n3YkcYIVEQXVqOjVDdutvEtM0C3iMs9DYfUvbxT7KUqUxvqUk6b8hZdS8DQ2J/5q57U8cweiygzShxxSCdwZnCSRqmDcSrWH0YT+ANNCyEg9AWb9PHOJvQof7jAcg34bXvKLZxziNP3xECQ3rA2bcxZX8eDNqC3tOvAbIKbhlNcfSSQxfgzp+us8wnv/pPf/hcLKYxMl0/htbm7csebt0sUurovjIOg/dS4FxhxVa7jKturi0KOd6hJrSpZTiCDav8htgXvQ5ndP5gMwuySQMYWiZx5GY0yv8Xu8SK7G6SZuSj0qYP+x2NA2aGSJMr
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(4326008)(8676002)(6666004)(8936002)(4744005)(316002)(2906002)(186003)(336012)(70586007)(5660300002)(426003)(41300700001)(47076005)(478600001)(7696005)(6916009)(26005)(44832011)(2616005)(40480700001)(70206006)(40460700003)(82310400005)(1076003)(83380400001)(86362001)(82740400003)(36860700001)(36756003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 03:39:23.4022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce1a781-ddee-48fb-138a-08dabd4cffe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

temporary workaround to skip ras error for gc_v11_0_3 until IFWI release later

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 84a76c36d9a7..dac236a6b3b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4688,10 +4688,10 @@ static int gfx_v11_0_ras_late_init(void *handle)
 
 	ret = amdgpu_ras_feature_enable(adev, gfx_common_if, true);
 	if (ret)
-		dev_err(adev->dev, "Failed to enable gfx11 ras feature\n");
+		dev_warn(adev->dev, "Failed to enable gfx11 ras feature\n");
 
 	kfree(gfx_common_if);
-	return ret;
+	return 0;
 }
 
 static int gfx_v11_0_late_init(void *handle)
-- 
2.25.1

