Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC53AC47422
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 05:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5984210E0E9;
	Wed, 24 Jan 2024 05:59:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6793F10E0E9
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 05:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsISG/oNW6EwMEviCHojQqcf8e3cyj8E+D0I5/35CE78G0uSocrfZULmXXfO3iIqHF9N7wwAtSRjMQ/piPIyCJA/KWyLr0wYVPi7WTbu2rFkii4rzf/I6/sVYJViS4gzA4ECxnZPpmzR+uzQZxG9VKQC0/lTfiT0JklZ6jUxTYd5k7WOyRAxeIo/kJ3PiuZEStXHXmFOewLoIZECEqCJh4F3zq9YeHyMEz8GhYAJXhEi9JLWRsz+BdTpXVqK4yQJ/Cbpo80eKxmT8xlJeWtaF8Al2yvZKx6EicVrIJa0NzIVkd6CAZN0M8Sd01HOGP0mwH9/UbmEulTE9lRZBDGyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDWuV76w0+0YQXysY6SuC5AccVS0mVFZn5XyKfguJJk=;
 b=IXqLxMufam2OLYtKB7pcO7ODmeHYYv5xJl7FPLjPIz9X4O46csjKHA5+EDKvMvQ31gJQM+g9EyVf4oXTdgDbXtp4zy3UBJ41wQUthqjUygPyT1OG5+X4qe5SGACRzv4AYJTo3mzPy4g2pT1COGMvmZ5pc3ZI9Jv8+Fm2/DnuxK6gsgvHAxRYpTKapbms/kx1f8pxW7OqVq+zWy1IDXkkYs0a32QM1vsG4FEuwIe89imE7DgGVNO4uT+7YTFojLljpKU0zuunOmCn5obPGhDDVAL8QuFaNJ1BaasyDHRbgqwrmy7qA6OSEnxJcqQR6azvonNaKK6p5bz9RWbjBlickQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDWuV76w0+0YQXysY6SuC5AccVS0mVFZn5XyKfguJJk=;
 b=K+DbDmhlVHUIHWmdxyv9aZlUz6rheFfQ3xRizeSOH/jdEJ8pj+Owbqf9Pq6H2ZIx9DEMh2NIvF5tHn827cIdp15bXha3v4vaXtyRmttVWYKwiAvTk5SRNUAk4tWhwDJtLVYlW6V8ZjNtlyrSVW5/UnmKaPxQHpxu1P87B7lsy1U=
Received: from BLAPR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:36e::16)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 05:59:28 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::2f) by BLAPR05CA0009.outlook.office365.com
 (2603:10b6:208:36e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Wed, 24 Jan 2024 05:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 05:59:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 23:59:26 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add aca sysfs remove support
Date: Wed, 24 Jan 2024 13:59:14 +0800
Message-ID: <20240124055915.3886458-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1f6efe-12b5-4d93-4059-08dc1ca19fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSAey/O1u+LLCsTdec/swIj2QK/C/S3g/berTzwr5EmhttvsJV0DL6JdxeEr3rvBk3cfP7fJqNQJlKFFjPvdDe3W99lrztdMQ5m3kOdesRweQlplkQZXiXMkivTaCFWs+x7uFIF6PgYXkPrQnJq6+6/Ih08PwZir4AWOSR4PVptdE05WX8KUYyekBt8XDjhIqKfn0GK5QW4Va08NuXwCPItepV0FSAi0PbPkUbtl1hqlMEeopaMXHJM45n8tMzjmUhHU60L7vNCJhvUUPv4rnvJVp8b8LZ3YraeIdB33749K49fingiwVnPTx8+ZieROt0skfSEn6+Py/mD0JQaOpMAES5MgIiQbOIcNacSaCsSolpbt2Hdw7VCWvKnoA0Y8QfMqfqq3BxVbfX7UicXAoJBCnfKtyuMAIKkDIa8fN+kHTQsjLY2mxen7D2RfIXfhf8NGJZ2JIIyqPHieRELdd6EvHHCmGv9AejMOq7vUPEvqRWG4VznnpxaGiuJL15ZOYmIzoxHtXry+7OvQeBuc53YLhlA/4bQQ0W8XAVW2m5g1AoKXCkZfspoLJbB0lXmQ0LSAByahuTRXUHLoTKwUy3LYfPVZ5R/ZZo1waLWH0wDeVk/aFmg+Wy2wFc9FOCIoNtbhm7Ed2bsKRIfvqMchhNIEHvFYFfcx3wVrkSUCF1BPbL0b8m2YUuhVOzQpqr/PhryqJaynUKPe8zGPSq9SGvi5BG8sSJktmVJREzFEkkyDJeyRsMc7cjYOQ4IfI2dNXt3zBpJQb4TyzeDKhYamDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(40470700004)(46966006)(7696005)(26005)(16526019)(426003)(336012)(8676002)(4326008)(2616005)(8936002)(83380400001)(54906003)(70206006)(70586007)(86362001)(478600001)(6916009)(316002)(1076003)(41300700001)(6666004)(82740400003)(47076005)(40460700003)(36860700001)(40480700001)(5660300002)(356005)(2906002)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 05:59:27.6885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1f6efe-12b5-4d93-4059-08dc1ca19fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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
Cc: tao.zhou1@amd.com, Yang Wang <kevinyang.wang@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add aca sysfs remove support.

Fixes: d06f6ed6bcc6 ("drm/amdgpu: add aca sysfs support")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 0b0196384627..52a0ea2f0ebf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -619,7 +619,7 @@ int amdgpu_aca_add_handle(struct amdgpu_device *adev, struct aca_handle *handle,
 	return add_aca_sysfs(adev, handle);
 }
 
-static void remove_aca(struct aca_handle *handle)
+static void remove_aca_handle(struct aca_handle *handle)
 {
 	struct aca_handle_manager *mgr = handle->mgr;
 
@@ -628,12 +628,24 @@ static void remove_aca(struct aca_handle *handle)
 	mgr->nr_handles--;
 }
 
+static void remove_aca_sysfs(struct aca_handle *handle)
+{
+	struct amdgpu_device *adev = handle->adev;
+	struct device_attribute *aca_attr = &handle->aca_attr;
+
+	if (adev->dev->kobj.sd)
+		sysfs_remove_file_from_group(&adev->dev->kobj,
+					     &aca_attr->attr,
+					     "ras");
+}
+
 void amdgpu_aca_remove_handle(struct aca_handle *handle)
 {
 	if (!handle || list_empty(&handle->node))
 		return;
 
-	remove_aca(handle);
+	remove_aca_sysfs(handle);
+	remove_aca_handle(handle);
 }
 
 static int aca_manager_init(struct aca_handle_manager *mgr)
@@ -649,7 +661,7 @@ static void aca_manager_fini(struct aca_handle_manager *mgr)
 	struct aca_handle *handle, *tmp;
 
 	list_for_each_entry_safe(handle, tmp, &mgr->list, node)
-		remove_aca(handle);
+		amdgpu_aca_remove_handle(handle);
 }
 
 bool amdgpu_aca_is_enabled(struct amdgpu_device *adev)
-- 
2.34.1

