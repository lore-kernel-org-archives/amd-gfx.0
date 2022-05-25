Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81347C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C4F10E6B3;
	Wed, 25 May 2022 19:05:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F2310E618
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTXkxVeg4TkqN2tgvDAgkApTp0P6xQjcTM4HfUiB2Zvx1ZZO+I1A5LlL0VjVRDik4SmFCZchkPPTdgR9CLjGsJdp2zPr5pN7giz67b9GVg6wdvN+Z7WIMBD/cJGx4/FZq8/qwWtJqKCI8dHgFRlPXVkn5JPaErl9hag8/0R4pHnL028yucjNW8CqhqnwZH/YKmRtgerqN6SKpJUma3b9qymaVl34tJuF8ZapVeXB6GY8AlnYSfj/CnzV11QeHmRLqUnVEKVbzSEXN0Pw3+TEckkwf7c0PErlhS3LI56UuU65tSo7GAk9Lf2xttlwgu9hLtC22mQMLmSyojaSOBkBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pinRKnbGu2Sqy2aNcrTVqaaq0SZAcpCliKcif3tyCEM=;
 b=b9Locvabe/6onGq6VBPsx2y7MBu6pZox2WDs6pYOzdH5PS9X45e7k2Er4s8Sq1Cw0hPGHqbPc41bS0AX74u3tjvH6XmPJnKd3uZT08XJ//MagdhIDoju1/QdPUXPmP5Kzqht0obGIDZoh//yUTK+Qh5guKa3/oQwfVZLxWq8p6JQ9Lgs6JOpFxfaGWsr4qSiqaM3DHuaDS/nR0h4XOENeJaXLySUH5469UkSJ2whNJHTOaFC+Qt6mGbDpn9ZdBg3qCE+2yLNebcoiQBRlUT3UumVrQJGeKuHZ1Zg7y+bO/6tTaTmIdH3mXE+WJL73lqRpQiSKkfWnyoaVftWIDFPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pinRKnbGu2Sqy2aNcrTVqaaq0SZAcpCliKcif3tyCEM=;
 b=Uv5pcINjAER35wXvVB7UIeaMNRjFkVqIR8g4ykHCcGrRBixW/rI6Y8EsfiA55O2HJUrEVll1caIAO+cunHmLuWKhGomSFBymW0VIuDv+rOZ7UUYWbnZPMHyXxwPa4izQRCF+++NMFeKjPVkN53vtOTvWpRIXrfayEdaOC6afQxg=
Received: from BN0PR04CA0086.namprd04.prod.outlook.com (2603:10b6:408:ea::31)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 25 May
 2022 19:05:20 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::9) by BN0PR04CA0086.outlook.office365.com
 (2603:10b6:408:ea::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:19 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:18 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 7/7] drm/amdgpu: Stop any pending reset if another in
 progress.
Date: Wed, 25 May 2022 15:04:47 -0400
Message-ID: <20220525190447.239867-8-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d418558-9198-41e2-c66a-08da3e81832f
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB566730A2DF337766E0CEEF69EAD69@MW4PR12MB5667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Oyc/6RrcVCik3eo9m14ulygg5P5qkTxKhrRs0Q/v6hpTrYsHldF8Y+NAik6W80As0SxDnTZtbHG9nfJ15xsrVNM7B1dJ48/foMmwBpwmlv7J8KQYW9p0AZWWpoGWFFQ6zUroBFIs9dhWcwtTjOOU7IqSXVEUyirbPIsfsYtvdzBwBlT/kYmkQKxf+xcqvBQZ8t9U7JjxpfqkYTW8cSWLOETx/O7ynqWqQKPT1tS2st6Kdduxq2zKFSA/0tGaAkzNDVx6MaXhFf4HUFJFhY14VAfPwh6NlXuN0AMKKxkM5X7XJ0LMQ443KVbDBB2j0rSUO0lx1k7VuNyxSXOoBGbloxqSDHbrRNT/qXPEaZMKQY2DBc50d6EOtsUjEPl2Q+7K76q0WblaKeNTV6DDIfYgEsdB/CyPvLN3rPlHy2PEZ7wb0vkPt3zuRDEMwKV/CtR9p3TYE4feLiYBgki4Ap4u0FmMpTtXTQtMnkOVmiE4daGm5q0d9OraAa24cpD22/5L8gfc+aZUyqkYT9BgFtvWkGjndkZc5yz1CRZ1294YaHeuTcAHq/jfY2hiehOqbPEJqiLy5egQzsDqlaCx9TISEZKO/Ync4FKk02w6pHcZ+uJKNiRTRMp1WTEu4DQWHePEWqdb54LmCkBzY+1tBsshYdJOWTnpMOs2hm/BpoWC3IF+CwR7tDR5vSN1PkMkBgIhAlOuCID/D08aqTljrEKTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(86362001)(186003)(508600001)(8936002)(356005)(26005)(4326008)(83380400001)(47076005)(36860700001)(54906003)(8676002)(7696005)(336012)(16526019)(426003)(6916009)(40460700003)(1076003)(2616005)(82310400005)(6666004)(2906002)(44832011)(36756003)(5660300002)(81166007)(70206006)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:19.8371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d418558-9198-41e2-c66a-08da3e81832f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
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

We skip rest requests if another one is already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 424571e46cf5..e1f7ee604ea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5054,6 +5054,27 @@ static void amdgpu_device_recheck_guilty_jobs(
 	}
 }
 
+static inline void amdggpu_device_stop_pedning_resets(struct amdgpu_device* adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+#if defined(CONFIG_DEBUG_FS)
+	if (!amdgpu_sriov_vf(adev))
+		cancel_work(&adev->reset_work);
+#endif
+
+	if (adev->kfd.dev)
+		cancel_work(&adev->kfd.reset_work);
+
+	if (amdgpu_sriov_vf(adev))
+		cancel_work(&adev->virt.flr_work);
+
+	if (con && adev->ras_enabled)
+		cancel_work(&con->recovery_work);
+
+}
+
+
 /**
  * amdgpu_device_gpu_recover - reset the asic and recover scheduler
  *
@@ -5209,6 +5230,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 				  r, adev_to_drm(tmp_adev)->unique);
 			tmp_adev->asic_reset_res = r;
 		}
+
+		/*
+		 * Drop all pending non scheduler resets. Scheduler resets
+		 * were already dropped during drm_sched_stop
+		 */
+		amdggpu_device_stop_pedning_resets(tmp_adev);
 	}
 
 	tmp_vram_lost_counter = atomic_read(&((adev)->vram_lost_counter));
-- 
2.25.1

