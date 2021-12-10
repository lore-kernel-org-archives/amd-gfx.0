Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD46AC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 12:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CDE10E3F9;
	Fri, 10 Dec 2021 12:00:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9051D10E40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 12:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCb1Sq/6ZDgAKmPT6ftrT2YY1+15EHxErw3Li2e9aC9D7k0WsyIhIiGn8gSeRcVqK1lU4ntua99zZxt2ac+i8uCWfQH2dMOywU90yfsOyzjWjjZ9Yh0eiD99D1Q/tb7YNO7fNM98MFCd2x39kS6q3JZu700Aiud7BgeM4BKuSsHa3mT6v+pXhjoiCurmVSeXluwffJYRkeP5qxKC+ewH9O4m/sXGCynq/RScR3nXX9Ky7tTGvhQSv1vwy5q7hM6FNy+50MYmNNpwiKb4YsoEShGJ7//zHzMzLOKt/EHG+zXci+EjpRswlNevfWaKq3lNF/qdyJVeh52iG8Gz0yRiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dg3CKt6Qz1Rh3hGBGvG/NCnIoztUu0TNZh5zqR15RpE=;
 b=Cky1dE/8YyBniT8Rb2rr+K8n6G3RONgRav9YR6YLBFwV0Ez+nsOlps7ZXcOCt2IgWUABu6BKfXOC8AuccMmOjJ8EEkVJGbpYPkOruVWF6Av9xz7Y4oQ7B6RMcOBJDeesgkMhRx428+RJeG43oOy6eKIqYteuWo7C5W88RfjeM2Nos0DpUAjIbrbI0zl/N32nbqa5jXdKFczNbG40tZvsla1CIZnhSC21RuERHLFkqqHcyzag6tOZscrlMxPTwzPZCjc3cYrn7qaxf1/nycGdiRzcXpX4R0GUNAfOC7oAPHd7f1eo3SJky0BfMU2ErLvTm+Fe+HsNy1XUOxj+AeDm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg3CKt6Qz1Rh3hGBGvG/NCnIoztUu0TNZh5zqR15RpE=;
 b=V/Nb7D39eLUZbFNts7zQj1gxUEoMleSVtyeOGvcgT+BprDXz18JbzUS/tWtR7MCfZbmSu7TaPOpoAmlrEK+VXJNAxRin9BESBMDqVnkbhBK+KfSns6Ubcyn+NOr3De/t1yaBNQfafZ/cMEw0UGTotiFy2+nhGgz40p88xaX8qug=
Received: from DM5PR10CA0006.namprd10.prod.outlook.com (2603:10b6:4:2::16) by
 BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.22; Fri, 10 Dec 2021 12:00:31 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::f9) by DM5PR10CA0006.outlook.office365.com
 (2603:10b6:4:2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Fri, 10 Dec 2021 12:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 12:00:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 06:00:29 -0600
Received: from haijun-target2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Dec 2021 06:00:23 -0600
From: Marina Nikolic <Marina.Nikolic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Modify sysfs pp_dpm_sclk to have only read
 premission in ONEVF mode
Date: Fri, 10 Dec 2021 20:00:20 +0800
Message-ID: <20211210120020.39737-1-Marina.Nikolic@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19381e43-9c31-49e8-ca90-08d9bbd4a9be
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB271025AECFFC6F6126692CD68E719@BYAPR12MB2710.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocwuyzgmH0TjBEGMc36qqAiLqszw+iaj18MVnPRJxQYqono1aY27O0jgrJapnr1wYRJ3sKMsWXm1gRRMhSM2T8NRM6A87g45FkG1+EwL3RynZGdbvzHekDT6qXIhdS3+k0WUSMTa/khJsHbeP25AJHiiDJrNy7wGeVB5BwDzast/uS/AyMHPtjVXHHxN3FUABOf+ICQ/2QsO5vn93dp1rQbFaRFWM8vXl3ogPfiR0hvaOOvHENCKFb5y+h16Npaj1AesI+GMx84EwsNyUKxl/zmydQ7pEGjEamBX4iKuAxxYMqJH47VeZGf16uQpP7K9zyCTRLoiBOZVj0e4ypOlROOkrXV0HCHVl3ab8n9v+ea8Cy6lNwMqUstTIJB9vD2wUSmxcWouwGatzBT8xr8RSIeBz/ZX4R46EmtFvTcYQnqOeTIqsXFP/Skv/Tzj1UTA0NSz/tLIDIvVnqzyXpWy/w4yeG5+4ASbUv+3h5kdvGX0XyjmOm7u0XpV/Fb+1A/zRl73yBGvyCKg4i5trvnBQCckjHSZB8YK74TqsKfP8SU9gomscUA7pfZu2gBwHYEC/aqfYHcsb+13AAJKFQCG7LtzkEQzEij7+eYH9Zaf7qtj7WsU8+tEWkDsNvaYIDBrIGa/dvfLhu+1d9CatTIdH87pEY76U4w8wUaNIzcMdANiyr14LDGHciAcr1j5uGkUisoEe/MgYlTXUgWut4MZH01mZR5k977/xfnlvhVIwzAVmHWf0eGaZfWTVNGRWe6XqnPqx46mlTp5IomiJlGzIeOpiMsfVBgwZm2AZD2JAi4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(36860700001)(2906002)(1076003)(6916009)(26005)(81166007)(4326008)(36756003)(356005)(83380400001)(40460700001)(508600001)(316002)(70586007)(47076005)(82310400004)(8676002)(70206006)(54906003)(86362001)(426003)(336012)(2616005)(186003)(5660300002)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 12:00:30.4168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19381e43-9c31-49e8-ca90-08d9bbd4a9be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2710
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
Cc: Marina Nikolic <marina.nikolic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

== Description ==
Due to security reasons setting through sysfs
should only be allowed in passthrough mode.
Options that are not mapped as SMU messages
do not have any mechanizm to distinguish between
passthorugh, onevf and mutivf usecase.
A unified approach is needed.

== Changes ==
This patch introduces a new mechanizm to distinguish
ONEVF and PASSTHROUGH use case on sysfs level
and prohibit setting (writting to sysfs).
It also applies the new mechanizm on pp_dpm_sclk sysfs file.

== Test ==
Writing to pp_dpm_sclk sysfs file in passthrough mode will succeed.
Writing to pp_dpm_sclk sysfs file in ONEVF mode will yield error:
"calling process does not have sufficient permission to execute a command".
Sysfs pp_dpm_sclk will not be created in MULTIVF mode.

Signed-off-by: Marina Nikolic <marina.nikolic@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 082539c70fd4..a78dd0799492 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2021,7 +2021,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RRW(pp_dpm_sclk,				ATTR_FLAG_BASIC, ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_socclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_fclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index a920515e2274..1a30d9c48d13 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -79,6 +79,10 @@ struct amdgpu_device_attr_entry {
 			     amdgpu_get_##_name, NULL,			\
 			     _flags, ##__VA_ARGS__)
 
+#define AMDGPU_DEVICE_ATTR_RRW(_name, _flags_full, _flags_restricted, ...) 	\
+        AMDGPU_DEVICE_ATTR_RW(_name, _flags_full, ##__VA_ARGS__),		\
+        AMDGPU_DEVICE_ATTR_RO(_name, _flags_restricted, ##__VA_ARGS__)
+
 int amdgpu_pm_sysfs_init(struct amdgpu_device *adev);
 int amdgpu_pm_virt_sysfs_init(struct amdgpu_device *adev);
 void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev);
-- 
2.20.1

