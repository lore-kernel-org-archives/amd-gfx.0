Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E77AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 19:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063F1113731;
	Tue, 17 May 2022 19:21:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20B111372C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 19:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QC367wFHz4JiLGVmlE8GnpmZlLa0EXL1CAiKo0mwhuuv9xWDFsSHugEXrmoqw+DCabCd2EoBTbf+ltu/KnFnD9T5OCINXkINlU/LLcYZx6KB254EAvwBVxm+4Yv08r1nUNYEJarIzk37FlVOlwBiqY60Qnd1aA4dxKtD+wd97FtV9CDjXSJyNWp6WTWaSlNJLTo25EMYB87Veu5jnQ2Uw+Zeupbk7Mg9mBH5PZpMUUy6rUtAW+y8cpvLuCwLrMAH/9A5CpN+HRi7/L/DlNcOP820U8xLfwAZkv52x6BHQQbOAnk25lABRd3yHZrvCh2zUA6o1EIYbpBaR9WNDkkXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCnWmc/whs5oLbCoaciFaq+JXFE0KBzdQCYQKFYYA7A=;
 b=GDnnE/N+ZMII72/rQTHTRrdes1OvQ+j9PbPyrQDxl5lk5h8/O/v1ONKIogYAy9PC8qC4/cpy3BXTVEy+SzTxSumIBavERbSgKlK+xY70fTlN9Wx1nCHDsZE3pskNe1GicOrx/nx99zNQ9GWqNqr8h4OwYkfjzFU07/nC36SuJAQVcWFcIzdtEqkFuVcEnOYM7H19kq0Iu/dQIklXwwZyZzVd2tiL2AGCmpF9nBkqce5E8GTYfv6eJLxn0OFE44PKT2fgXDc4bfD1pcLFKXn/s+ZoadRtv2QFhF4khGcXoCqTzVpzS56lYpYkRjUrGr0iPoNs0MGO69QRypc3Hcm3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCnWmc/whs5oLbCoaciFaq+JXFE0KBzdQCYQKFYYA7A=;
 b=vhdgAGdQoTiZswWlMjWltKftvNy8vxmtwMrZMwOuqFgGWjoq35rIfaDZyOtpVaQ7IgKmrpciRN9aOd9KGg/P6/JVAUVdaRQrppdCdNYhbNIevScRbRMQQhtiDDg/PawoaU0KY0lfXiHkYn+Za4OisuvpfviQddmAGs9sXplQmEo=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 19:21:28 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::73) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 19:21:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 17 May 2022 19:21:28 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 17 May 2022 14:21:27 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/7] drm/admgpu: Serialize RAS recovery work directly into
 reset domain queue.
Date: Tue, 17 May 2022 15:20:58 -0400
Message-ID: <20220517192102.238176-4-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a6fc8e-2ad9-4de2-144b-08da383a714d
X-MS-TrafficTypeDiagnostic: CY5PR12MB6624:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6624B8772C00CFC696D83149EACE9@CY5PR12MB6624.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2XNkqKFopTRg8u5o9jA9o+qpgeJM4Z9eVi5dhXvXZhw2xsqa924da9XTnMXfXaxLIOi9k90n0Qtu4k7RtVWl0RgGQ36hnE5W/T+JM8gx5//G06mtPJsunMx3FfftBBvwKoagPPhb7EseMM+Vksw86egqH0GUWEp+4VD149vGrbk0W3EfHtI8gfjPCfKOgOVybHMTpQAffd6/fLJzIebEJwnR1nG6K3xPq1F0jR16hjsnY+eLJzYNwAk9E6kAjmrSXy0MZTrACJCmYmOwuObt6bVcVu+JVbWHjwMRF2JL0YocEiMfWfowhtLD3sHJOE/lPSovcnHcWjZ53pkUS3XoYZeUQQT1vImWOGBIlVq6OzzTyDxt0yJlPz8YqDJoAIUlCAP6pZDiZVVE11NtJJ7CNPhecHLm9jLUENwB/MNJYZq5rz+JvpaWViMzdvNrXn9KKc4f7xOGQ4i2DX9H8WeCeTrQrBML/Inx1CgRZ8af/qEJwif/48Q4pnVmWrYEZTDIDYwV4ZrMib68RJY26Z4VSAxOe53uZMKqAq6ws8RtAYJZ3f1MzB+zXIpTQBXaw+3A6IqLfxcLKUDBWMCrxnP1DiAsB+B9mjV457MnbYsnizyksTi/SPvdXjlCt9fqRb5jD5MoShKEPsSG6/UcJBvc9tvBZGbzqQCZo06txz5PcL89lxaqKMU233+hNfba5LFNPkXe+3RvdtU2hJNz/xAJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8676002)(70206006)(2616005)(4326008)(6916009)(26005)(44832011)(86362001)(7696005)(81166007)(508600001)(8936002)(40460700003)(70586007)(5660300002)(83380400001)(186003)(36756003)(16526019)(426003)(336012)(47076005)(54906003)(82310400005)(36860700001)(356005)(2906002)(6666004)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 19:21:28.4607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a6fc8e-2ad9-4de2-144b-08da383a714d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Save the extra usless work schedule. Also swith to delayed work.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 12 +++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a653cf3b3d13..7e8c7bcc7303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,6 +35,8 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "atom.h"
+#include "amdgpu_reset.h"
+
 #ifdef CONFIG_X86_MCE_AMD
 #include <asm/mce.h>
 
@@ -1889,7 +1891,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 static void amdgpu_ras_do_recovery(struct work_struct *work)
 {
 	struct amdgpu_ras *ras =
-		container_of(work, struct amdgpu_ras, recovery_work);
+		container_of(work, struct amdgpu_ras, recovery_work.work);
 	struct amdgpu_device *remote_adev = NULL;
 	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
@@ -1916,7 +1918,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	}
 
 	if (amdgpu_device_should_recover_gpu(ras->adev))
-		amdgpu_device_gpu_recover(ras->adev, NULL);
+		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
 }
 
@@ -2148,7 +2150,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	}
 
 	mutex_init(&con->recovery_lock);
-	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
+	INIT_DELAYED_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
@@ -2217,7 +2219,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_device *adev)
 	if (!data)
 		return 0;
 
-	cancel_work_sync(&con->recovery_work);
+	cancel_delayed_work_sync(&con->recovery_work);
 
 	mutex_lock(&con->recovery_lock);
 	con->eh_data = NULL;
@@ -2910,7 +2912,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		schedule_work(&ras->recovery_work);
+		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index b9a6fac2b8b2..f7e21c2abc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -347,7 +347,7 @@ struct amdgpu_ras {
 	struct ras_manager *objs;
 
 	/* gpu recovery */
-	struct work_struct recovery_work;
+	struct delayed_work recovery_work;
 	atomic_t in_recovery;
 	struct amdgpu_device *adev;
 	/* error handler data */
-- 
2.25.1

