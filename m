Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3007BC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA155112CA8;
	Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fOUCZaIb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09C710FD8A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2pxsAl9slQD/5SgYwBmSRgeK1xw2gvs6buCEA/GkAfqtABpN6aGNPu6x+ylRhsoJjFMRK+cRJU8y+n4cF7uk3I8j3zsqoiEcV6hgY+raaKJGMw5JBLlxqAkxK3lkhK4xuX1uNvQW89QlAufYROz53FbNGWe0snX+6hkHn1MoR+bbWnui07vWijKkv4tcNcvQs6AwNX237gnYsVgRji3LYhYLX82w34WCAebI4E0ObjML7gP6gnCsxssN9/qi87Vv+2nERbuFZ4MLa81b/ipr5/THal4zPo6jLSxYcYuCY3nmCKG1jVIR1xwLJU2y3fCLfOy9PoA5yCQJG/mfcRaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFZgAtQoj08HoR852pQJ3O6qrKUACC2er9JCgntpI/c=;
 b=Gxg3TMbkkDxaqwUPIatfMh3sPk1GcaW7yowu2bgBA1S5hbM8J2/8lqpuYGvxLimNFzJ4atwtp8biCbozUBgffPGgo/J1VfpmvZQr14tTBJXXsDl1fjn5Y3mFKyK1C/tfBapp+N3Mh9TykvpXeJiJyf9cLf5CI6uks6ocxlPGeH5VDy4Cb4msHd0Z0gOC6f+CSP7cOGdeCI2F91c5AbgLGOQvlweLZsSmjeDVqdhC0UVGuDJs7DU5oivU2zUGT5sWLACNpGuMVbW+gNTWZQ3EdVtyfBDco/mZ6T1FVDFThfeC9IvF8S2ipTLMOfnCgoS8migCEG5RA7IRCcTVSh6t9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFZgAtQoj08HoR852pQJ3O6qrKUACC2er9JCgntpI/c=;
 b=fOUCZaIbltIQHeAkXc6r+PMNPwwUyjYQQ6gpiIudwKiRGlxUWRT7hbZtnUmjWiZYowfSQPyTH72tRKpRRqiiPyB9rsXGipcr0Rexe2qL+KSiJGa/WqVoZQI0BGomod9MO/oSAhR5pkLV5T+p0dL+hqzFGfBf5xp3CFvhk5hmtsk=
Received: from SJ0PR03CA0238.namprd03.prod.outlook.com (2603:10b6:a03:39f::33)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 15:59:41 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5d) by SJ0PR03CA0238.outlook.office365.com
 (2603:10b6:a03:39f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:39 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:35 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 09/24] drm/amdkfd: add interface to trigger pc sampling trap
Date: Tue, 6 Feb 2024 10:59:05 -0500
Message-ID: <20240206155920.3171418-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 71af554b-3203-4862-2787-08dc272c9ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsqsNAcVG0lIMcfmaKR8bwrXy2bj0QsDTAUluXt+KfHrgeGwRLfBiY2ibd8erLTiTWyH7ICFG6SIsODaP+Kh1oP/e1ooC4mRwPup1dOBF+w26+pQNr0ewkez/RD+reV0Senl5jvCyDzPn8bSx6GMrDdL438sJwh7/3jgpaopGvQwIY+I7Xsyz4uVHlP6m5+kTy7v/UfLefx8A1qD6gaN4v3Mw5Qp9s2XYtFXlgqeaLVPD/bvweGJG1+mN0WdQFO8gu7hjVRPBfxVvEQYvV+NyGBWjaER0ActW6k3mVy34yyMdVDxhMy5avYyx5Q6PbJ+mE0Vg803aTVTVceu+faZTreFtlTdS/ZotcvmxF+gi0XVW/48jvqjyOqhE6zxwfALIhgyrUx5yaI2cyhZgxwsY32Yl6uyRRMq1XW5zGnHxEGq76SxA5z9DJpYA7naCUpKEFSmbNi4FceCXQFbVxPA5ZijFD5YhVbYS4cXWCl7b+7mZXyqYWUBOSdziWddIjl+vjwuD9ibtDMK2uUk0TnDNuf49gKfRIwKXVd+N/MSt1LO+mmOHx7rILZhk3GoNAq+wQBjgzK0vqBSs5hEXNioq0I2MLwYdLCSYlclVGH7bSo/5UtQthjUj0usgukg6aJ0jMnIIWGQqb98cpnC+7a7Jmuq6Mu0JEfofXPeV3YnNdzLR6z87DWJNzhpDt98TpecX9yZroOTGzct5klelZawLWLoEdKIyFhQnX/s3ojA9qgIfu6VMiXVEtuvb/fTnekb+H3ts4lRtd/7VjH+80Uxvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(46966006)(40470700004)(36840700001)(1076003)(336012)(2616005)(16526019)(426003)(40460700003)(40480700001)(26005)(41300700001)(36756003)(70586007)(36860700001)(478600001)(47076005)(70206006)(6916009)(54906003)(316002)(356005)(6666004)(7696005)(82740400003)(81166007)(5660300002)(8936002)(8676002)(4326008)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:39.4730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71af554b-3203-4862-2787-08dc272c9ffd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6d094cf3587d..12f9021d563e 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -31,6 +31,8 @@
 #include <linux/types.h>
 #include <linux/bitmap.h>
 #include <linux/dma-fence.h>
+#include <uapi/linux/kfd_ioctl.h>
+
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
 
@@ -318,6 +320,11 @@ struct kfd2kgd_calls {
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
 			uint32_t vmid, uint64_t tba_addr, uint64_t tma_addr,
 			uint32_t inst);
+	uint32_t (*trigger_pc_sample_trap)(struct amdgpu_device *adev,
+					uint32_t vmid,
+					uint32_t *target_simd,
+					uint32_t *target_wave_slot,
+					enum kfd_ioctl_pc_sample_method method);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.25.1

