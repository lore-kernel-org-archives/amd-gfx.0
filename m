Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54497C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A1E910EBE8;
	Tue,  3 May 2022 20:37:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A9B10ED6C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJpAyvbi7/EtYcGWjAgkdHNfIbMKYsRtUUrtvyMgJwRm9g5vAsa4xEPKo3IRyIEvh8ZPt/Thgi15fM1vLsyCW8XrKuzYG+o0kj6+7viTLUKk9pmPKMZCpCDQ7r7GXgeCPdrVrTR0v8GdYsywh8Wt1/fdiUCN+SDBlmcXh9Q+aGRMI9LOQs0/BnNR4ONLNceIIxu+DcI5B1LUYYENg8zwrWrJcxcSu7g07jhNCDfdxVDMMRJNCyL0PV/Agm+YpnHhZypyoU86ZDAs20nb698N5zxmaOniCWXYT62rBITiV0mk/6dyBWxkHX3ADofjyju1A+6VD9AQtzO9yOzAbgHe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WzPmRAd07B/U9rFj7iUFCbkHQCLAgKSx4DlayeX184=;
 b=WjGu0G6bo80M9MUlMTO/Up+4ku+ocFNWh4HL9zJt7O+rX3jUlf/SAc+O2GmpwnM0FR6wyGEYu3rxhGMFoG5bUG9yZUKEWqD9cFZLxM0AISmtYTaYVrzwZgmUF7ANi1cQkVVQyhEyTsZstSKWTdIqLQjdzKSPI3J2llWAKbQu2tq1ZNRTwajsFr2bGzCjB0++UYzGRj7y/AGrx946m3ppegwnE+KIfIJH7X56O26yUSBDCIYFlbXVwzBUVTzkrKGQa5vIKI3F+A01eJABG1jzY3UqYEV4WE93rChdBcUqgsXYy6RKGpxtBaYaZCe6Cbf/iAUiJTb3yQktS9xe190tlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WzPmRAd07B/U9rFj7iUFCbkHQCLAgKSx4DlayeX184=;
 b=QTXj5XKqdsjT9wAo6n/kVmghsDGCdF0eiJNPTNLKHEMZJo0WH9eQb9iCz8r1YNUxAI1cXlCCDvXSQRZpROT86I0vV0X3Q6hoI5jQxuTUTq+Tyn7LTFys2f04tO18a2pWAXOk2HeDsFH1wKpM7teddiMB8UiWiUyOnDRnMLk+fjo=
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by BN6PR1201MB0004.namprd12.prod.outlook.com (2603:10b6:404:ac::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:37:31 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::77) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:37:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:37:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/26] drm/amdgpu/swsmu: add smu 13.0.7 firmware
Date: Tue, 3 May 2022 16:36:52 -0400
Message-ID: <20220503203716.1230313-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503203716.1230313-1-alexander.deucher@amd.com>
References: <20220503203716.1230313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40066eaa-f632-4589-f7ff-08da2d44bed3
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0004:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB000455CD7BB55117D75C20FBF7C09@BN6PR1201MB0004.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WW9K8LBAqo+cV+h7VMsPxQqpBYTJJS6rhwbWTCiKMBD0WZkSbqC2InHQL4+4c4wErbGAZ53FO+6Ub/GVl4ZiFL9ThwaZLzllA6Corrqy5ocKyDaMLYp4U6T53Oy0ws77OZ0o/2oa2bWBO9iSiPE4LZ+7NcpCv0EoLE/Nx3URhlv2yER2GNTpJtHsLNcf94xe4z28JrGye4hHhFWUGCI+NBdDzeYwS6IUOXblkbBsgTr+0G/C7Xw3nCt/wGYn6eUxHQ6qfQCsCA8Q86P9QVG6CqWGyrxKlixP9/0HVqBz1w7T9E7Di0zyYdVUEu+WhGFXRn2uhGc3zyKxo4sq5qdC11Kz7YCQ3NjXADwVMyhMh/HiVrGdnpG/WdCioJ8JdW5Tk2jsFdCjePtyC1//P1ymfQ0Vxhyg2bZnmdLFt3dgqCzAWvrHoYYObsio6CDMw68A6WoWDIbiu1JtVwIm38d6FdvoDGI1b8bRNQk5/Ymu2Yo7qO8mi9GJ0hLOdubirju92p53/UUx0HjbPC98nGFvX8p/aIfTucDjqE8i+Kspo3eVDJo2YEnz5T/yYc/dwEmEM3FTBg/kcdE5XjYcpXjO6bit2bS6InkDKlEeizQdwb/Q0hh2KMcVg6foOqrGJCn4Ea+BnXoPOhaPsbpCvBW7ZoLlhqoM/80iky0RJ9wnyeyW4Vtb8mJ5b+N00JzEuEQi16FTIlbZJqUbTq+ZNk2ycg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(7696005)(82310400005)(36860700001)(4744005)(70586007)(4326008)(70206006)(8676002)(8936002)(316002)(1076003)(6916009)(54906003)(2906002)(81166007)(6666004)(356005)(26005)(2616005)(40460700003)(36756003)(16526019)(186003)(47076005)(336012)(86362001)(426003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:37:30.7060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40066eaa-f632-4589-f7ff-08da2d44bed3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0004
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chengming Gui <Jack.Gui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Declare smu 13.0.7 firmware.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4729cdcdb210..3e6f33210008 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -58,6 +58,7 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 MODULE_FIRMWARE("amdgpu/smu_13_0_0.bin");
+MODULE_FIRMWARE("amdgpu/smu_13_0_7.bin");
 
 #define SMU13_VOLTAGE_SCALE 4
 
-- 
2.35.1

