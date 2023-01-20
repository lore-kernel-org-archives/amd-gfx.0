Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C52C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 08:09:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B382A10EA8A;
	Fri, 20 Jan 2023 08:09:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC9710EA8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 08:09:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny9FFlGq3gUGMfhH/EhnXFnnMwYLh9menB5AuxbjkTG2oxKf+7Ct8+RUKpUQpyxRuD31DmnvEXxAGc44GzqhIInooNc8dxKQtXAXukc8vPx/sJqpQ6BHkH/a76DjnQ2Zl3/SExWmi60M2lSe5Kyn67KJ9oNRTSahg17F+fhGMDDrNlm9zzqHagUjfIQ1X7wQey2s130wVPMxkvWqzd+rk5iy7uPOXWjQq1+anEV+ds/wFqn7/Eh5N53Kxv0AvwMIxWwq7Tjf5Vyh6FDn5xT7l0WeDY563I7eFr5meO6+3mE7EEJb4GmI8XwA9qpOjcQSuUyP5HciVhj7d769QKe5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynMWEVtpvMhP5uUnKfzs8FdnbGE37Fwi0PJuAirO5Eo=;
 b=KfFOanaXrjk/md5ML52VKQ92sG3qv+vehPJd5FJD4+zP6Ar/IoWcdJ2cXdiBP7XBdFolgK2jSzIOu6M7hMuu/xI9Yy1yGUQBa9LpVXueIoUu3hHzyfPgxYBPZT6x3ARTV15uG25362xlN7QSNKtP4e23Wrups5+n+LDh3amk9MwHXBB8O1FXqMSfh8Gkvi1xm3+JYO804GNtbGtGVSsmhTZzm3KFqnT5JMWti1ppM/VkRr/XBXZiybqSAeRWTfpRNx0d5RseHqB/QF17UpekrhwZzn+WaXHh242GU4lm+k5l/sPJ9w22jGRBWkuWAHw0xrNifCL/e3OeJif4sTH8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMWEVtpvMhP5uUnKfzs8FdnbGE37Fwi0PJuAirO5Eo=;
 b=TBtMslEDhNX7EbikqKKy4KSNsH7ResBO7OMzMjuDkdCgAXgTnEgBbH4jj+8JODx6Ucgr38LtfXPQrVBBU+0lAP+KyhdHSwep20BTYbFsJpFzN3hG0un1bjO3IbjMMujiQakpUpV2n0OoHq57BZoCCcsbcUzZ8qLh+Z2Ue6jxWQY=
Received: from MN2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:208:15e::16)
 by BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Fri, 20 Jan
 2023 08:09:39 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::3f) by MN2PR17CA0003.outlook.office365.com
 (2603:10b6:208:15e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27 via Frontend
 Transport; Fri, 20 Jan 2023 08:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.11 via Frontend Transport; Fri, 20 Jan 2023 08:09:38 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 02:09:37 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: declare firmware for new MES 11.0.4
Date: Fri, 20 Jan 2023 16:09:09 +0800
Message-ID: <20230120080909.948932-2-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120080909.948932-1-li.ma@amd.com>
References: <20230120080909.948932-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|BN9PR12MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: c6fb3021-524d-48f4-c505-08dafabdad58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5UvG8UoyEICflIwgigga5cChMZ4OHhNmubORaB1wLhWv77u5/ezY0POekcY4kYfZQJSeUc36xUiU9RJp7XQdZtcY897nLnakU6nYbckaLRKPOQY9TGbHGFmWFcK9x04CgdRmVFnvyElHJ5nTgHETdhxT3eQCWYYNiA2ywOsHz9k01uSerHDuNCJ6+NeY2t5xBXQwsfDb8RLP9rcE7bsRfIEB5IG6YQJTPnIw0eCOHTZZKJKB8NhFJ9rsf/fV0S34yvDIlZsUMmrnDmxUfeqQFF0QUQlOX8Ch4O8w83Xhbx2t0Hvh2fuxFiSkFtTO1tiCOmHwU31uTzqxDBprAwEC/63C9qXM3DgAAjNm4xhJNX3G0PIM3KpGkiImOqpFODFL+ngdJU3eBJMGISHfjXnuCpbBV8dvOY2/0AqQiA9126gmFdrJZaT9YBz+e39HfYXuSeYILdSLQN4z75G8Agy6iN3wruffTqZObShWRnyjuxhZVI/8KMciFO6YfHME9hnMsyb8eBs+FidqwV0xWCyBO+SQFHC7P0gKdvnj1qkz8XCOZgnu0EdvejGnF5oUgDaa51BgmGggf8zbVZce3T3n55dC1zTUj3KiA5CP2zziv0Uc9BsBn3PJoF4MMZaW9ige4bo/bEs8IYj4W6sqyNSWhPCdmvpiCYZxgl7FWB+kgOYZWKysvNyHsd15zdoZglWNVs7iusQcbaVr8MN25khjrwr8hIrJbUwveWngQSFJwyg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(4326008)(40460700003)(6666004)(478600001)(36756003)(8936002)(316002)(7696005)(5660300002)(70206006)(4744005)(40480700001)(70586007)(6916009)(8676002)(26005)(41300700001)(186003)(36860700001)(356005)(83380400001)(82310400005)(2616005)(426003)(82740400003)(2906002)(16526019)(81166007)(47076005)(54906003)(44832011)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 08:09:38.9916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fb3021-524d-48f4-c505-08dafabdad58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, Li Ma <li.ma@amd.com>,
 xiaojian.du@amd.com, tim.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support new mes ip block

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 00e64838bb8b..62cdd2113135 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -40,6 +40,8 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);
 static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
-- 
2.25.1

