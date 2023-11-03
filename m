Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5E2C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B206A10E9C6;
	Fri,  3 Nov 2023 13:12:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836E410E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRHHP+JJ1Cecxn0oRDr+USXlc5VAPwHcn5+j0LyuURVpFOALo9Ue4io9PuWKKkauxuVAZywHZX6S2aVxGJmThK/o2eDomeI5X3VN4whqExJ/hwTieFhx/+jX7rc+oComLCoU6xxWsOxESRhN+y5ZmRu4x13ew5BYNq9NahQTrrBNwOPlgIPqG9hoMJm9Q4b2vw0hph3mG0f/2M9itz8VxPQXQz0sJTW/pc8otMx0J9UYHzR5UsDZnezq42eoHyklnIMXhKy4w3rpoVW82ZkLbWvLbjzKgYbiUcrPFCns5JAfydrO+gEiPk28xA7/kh8XVtYpEzErT8W9VCM7LmAimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=GknZFzB6jVlD1on4sI30DDCHKfSRmTk5JV1PNPWe1bkPG+tB9UFzz6U/OH/0gkZW7/aFnpyt66/g/gAcbLwPXx/J7oJGU/l2nTCyaY55otZHdSXFwFPJtWwDXoh2IQZsuOpIRShbhEXkdVqaVWxBclhYYHSb10gAjy/PaVYt+DzUYmZ/sJ0uF5n/dX8yQv8p76q5Bf6DW/L/F90qTka8we7Bt5S4nvQb0vTKsmltC67pHsP/V/LPRn/Pe0Xl5bCv5PV2VINxKp+yVr943uWzAmSGsF9WGYY+V56trfSYl14R4gI+v+/oyfjro03I+LeLGf6RnbV+ymqy/Nq+x6AwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvDw49j8UE4zlSf8AOXneaWRU2ZQu0Q9vqc08/BZJE=;
 b=GHOrM6hQtYIKf2izTovImxWnfvbmjEeR4bPccBv2TiEZwjs/Wi2juanIyLH2YkTR9vFb7B3HX2jxE/pjhSMu7T7VC/y8kK31qfXQc6+5hhJGmf1dRI660HiKbUs57AJf8tAKwts9pOMxghuqr2/JG00cEjim1uJwPFUtlb5LKqg=
Received: from DS7PR03CA0117.namprd03.prod.outlook.com (2603:10b6:5:3b7::32)
 by SN7PR12MB7180.namprd12.prod.outlook.com (2603:10b6:806:2a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Fri, 3 Nov
 2023 13:12:04 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::be) by DS7PR03CA0117.outlook.office365.com
 (2603:10b6:5:3b7::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:03 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:01 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/24] drm/amdkfd: add interface to trigger pc sampling trap
Date: Fri, 3 Nov 2023 09:11:24 -0400
Message-ID: <20231103131139.766920-10-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SN7PR12MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 9158143e-d74b-440f-f4a9-08dbdc6e7947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09zCA/wANFTpNl47hZ8C9rYKoJwxFu37+D/TDm60i/9jiAD8GhjSVxIBFyAXBxQLVMR7+6i5J90LiZkeGEjsOAxrJNLjrshO8tn0rHwaDU7HgOPbV6fS7gag3050n6MMcEytwUkocADPlzHN6JnerWI3VwDBThXpzUfQXJPZOohRuHWbendJ3b5G9pU2GitBvoIZ321fUl0Qm7bNFh8XS5yUeDhBz4mcfFsR5yGcGX7+7YSftKCYpxcPWvF+CBG7m9rfQzlO6GUNKcNVdphaGv9Qp0LYwigfIZP0jOI7eJbowk7vt+P3MbwCF5VfULKglCg8z8PgyxZ7V89tYB2mEGC+aD6gdRUmgBeH2WVvkddKkf6Eeo5Lj/5/uYBrc8CusJRp1Wyx5iohqmIwpEL/UcTidmZ3+mUCUHU94zROOGgvwx30vHZcjq73BMWFsnavK/UckP+Ot0zpyZz5bJsErbjJ57fjg/bfBMBcqjxH/wQ+01gtDFHbKMN5k6ZML8T8y1Z4CxzzJqWw2kebkrbQG3REnNqcc+wfQnx8orUGB5PBgGT0i0avXnEnBx4ql4WWViv2Cn4bmfBvNKwfsiKQGOG1a29O1fe0jVNPskY6fA3CxntTSZAdFxd0/ux2m9at6o/BRFr76PYqe0qNHNd4uPd/+71Mas2W+s/FWF4djJPVPnTuMN4eWyqD3VJX2DIBqB+6HIyq0ToLZmH6xibA6DLgFUf4+2V082XTKbN8ICJGAN8LpZo52IYf/FQQsLPUSVTuH2MpPjz61TAws5CnIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(2906002)(16526019)(40460700003)(1076003)(26005)(47076005)(36860700001)(2616005)(478600001)(336012)(6666004)(426003)(7696005)(41300700001)(6916009)(54906003)(70206006)(5660300002)(70586007)(316002)(8936002)(4326008)(8676002)(36756003)(82740400003)(81166007)(86362001)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:03.8891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9158143e-d74b-440f-f4a9-08dbdc6e7947
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7180
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add interface to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 6d094cf3587d..05b0255aca37 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -33,6 +33,7 @@
 #include <linux/dma-fence.h>
 #include "amdgpu_irq.h"
 #include "amdgpu_gfx.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 struct pci_dev;
 struct amdgpu_device;
@@ -318,6 +319,11 @@ struct kfd2kgd_calls {
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

