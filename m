Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A40CCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 06:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF12110E525;
	Tue,  4 Nov 2025 06:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fe4t74Y9";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7027F10E524
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 06:58:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgZB5geWg1oZD5AzyM+r0h0R20Ra8RCNSMRlyKZEhBiHU7TOIvEmLUhfm5sYL7oLEP85hdSffSlQ+/4QPz5+tNDONSQRCuxW+9EiU74v7EBYLJEnfg8wRIPT/eGX0FOIigmRs+6lfFwf8tRaufxBndlBoBegTrk7VY2mj9GmBk0XD+989qB3I2Hsb64qy93/DIajAIFVfctKdTpEVAwU5JJBYUMWqr+OT5MMROG6dNsuxgAlMb7FadQWdjl7qKcIRt+RxACPY9Db3s8Dh9PRpiLcZ0NzzvxMi1n4XCieBnfXOt25cuf83iuFBMwV1dS/y76xlUC/LaTBev2rVUePWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SX+3IB7HmSrXkeDKthPmnWeufiPas2EdoivZAhmS1NQ=;
 b=yowVKzn5OPuJ0jo3EcXmAvlAEHJKSsisHho7QcvuD6xqlqpNP6D7nYG+a5oUnOFaEZyqWwaibLO5eR5jz+kqTfPEfy/O6yzH3XQteYzFy55ZVM+16tdjMZ5ZHkKLOl709ZHJS/+SZkFBJVqdhx+NYLbAwxHiS0knuvt8Mw7zVlkmQcyFcW/3XwVxzcPA+Llv/c7uyIeChti+AaxGQ1+SIjzxr8Kq+A6jaHcM7GIlpgbdPWZU7PoF5GG8eZl36zhUoumlgwx8OpxWFAKnvDpcG1/dQuElhtP8gM/eWj/LsDdLIRYxxGAxYRHTmFLL0u+ZtO7vSItHZCQzOpJix+lu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SX+3IB7HmSrXkeDKthPmnWeufiPas2EdoivZAhmS1NQ=;
 b=Fe4t74Y9Al/hocO/WwZXThxQ6b8XsAmAr/BQeyZKBqpbwNRQ7R6QL1tVd8xn9hzGQdaCkTGNXf+oIes4b02ti2/gdhQiXu2iNGRjKtON7ETSzujNzoV9r1dnjO4SAJnt5WGsF8BUrZ5GLSIk+BwcwQ/6aO1w8bWIx4/yTpSHAVw=
Received: from BL1PR13CA0374.namprd13.prod.outlook.com (2603:10b6:208:2c0::19)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:58:20 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7) by BL1PR13CA0374.outlook.office365.com
 (2603:10b6:208:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 06:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:58:19 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 22:58:17 -0800
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH 04/10] drm/amdgpu: add function to check if pmfw eeprom is
 supported
Date: Tue, 4 Nov 2025 14:57:39 +0800
Message-ID: <20251104065745.1737050-4-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104065745.1737050-1-ganglxie@amd.com>
References: <20251104065745.1737050-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: 0915c25b-d54c-4252-1520-08de1b6f89bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vCT7lHT1/j9mpg51d10e3XjREIxPtEMrHkMS1DYmiPF+FMopp50d13Q2fX5C?=
 =?us-ascii?Q?O+vycgQax7ksmkTrKZzzIad4sIMokk2yavM7aVwUip837ArRyozFgc85v8L0?=
 =?us-ascii?Q?lIUAPfJ9J77EAGEipzh3WHeyY/kRVMo/6ybp58zfDCzxp/SP7BsldZeJ4+sN?=
 =?us-ascii?Q?BNp7Tl+wBm9FR6qFiPmD6Fwy+RZc6DZtTxqBr50YE1SvJhawgH4JU4FoJvWg?=
 =?us-ascii?Q?OlvhZkZeomD9Oswr8Bswb/VHtYSGyGCuUme+wY5Q4saQpwJ3LG+W5fnVhXRt?=
 =?us-ascii?Q?nCQxh9CVpY3idwvOmUd0SryYK8ZlVOBddTR/pLFE1V0r0K380fZXDiRCRH8Y?=
 =?us-ascii?Q?qXjTvLks8VgmQiVYSuINBrvOw2sIUagCkquQin2wSJvD5ugToELB1hlvPkzX?=
 =?us-ascii?Q?FyGXlnAfIkPqB/m91c888WH25T7NbrDOYbyAsdUedGQOP0RhcznSCzB+6Z6y?=
 =?us-ascii?Q?VS2mZ23gDBVkqud/hOhbIF658ow+QBLtKJY1TyzEX2oFxPgYvUEEYBQUoN6w?=
 =?us-ascii?Q?Cx6cs19bBK5kBUXnuyEPfm66gKYgUKWSEzxiOOAFbU4Rqru5JgQcl3ayONsp?=
 =?us-ascii?Q?+FZJx2dwg3ikIVXrOmxU2yMJhX5oB4A1gS8eWUHa1UAjR3wbFQwXs0j6BaCZ?=
 =?us-ascii?Q?LPFKzWEmNLiUyy0Y6YAq6H8WAmThHiD7HoNyqp/PxvVEPNTBQ9kRWLTHrWf3?=
 =?us-ascii?Q?H5NCm6YzFrzBr00EsERyNzsQxq3Lfzn0g5IAKlNOrjviu3RJleOTWCiNDEyp?=
 =?us-ascii?Q?5Cz4mWMEGYWodGkp0JRK5uO4efTSRcVfTnqJZygpWle/RpMn8lLT26bay7E8?=
 =?us-ascii?Q?/A+zmOderq0xUlHbGWGpYn53LQzEiwp4bKPoRFyAey+vBTVrrFOIR7YeVbPU?=
 =?us-ascii?Q?7QdOvQPoC2Ihwvk8pXg6WG3/f7CRVJi2uGG9j1rLHrgAGNfwMncfkHWKuO6x?=
 =?us-ascii?Q?oqbMr73BVagCttLXyjHS7ScZpGXmIKqwQubik42sR62Qyopz+mtHglLI9rxX?=
 =?us-ascii?Q?KXnne0yVWCMr1PbGhpoyYRFrsTdA03biTYAuemImIhK9aH/tBd17dMsIszj9?=
 =?us-ascii?Q?Nj+S6h1T2I+89BSNQFiP45r3Ah71OK1dFFKkR1QaziN4LBbzJ/X0ifY9l/YE?=
 =?us-ascii?Q?1iJP88Oan82n4h7kPVbTtg/OXV9b/lsnKSyRCLxk6GStHYvQSoZMgYnTq3yW?=
 =?us-ascii?Q?Q+zJ2Pyhj+shiwOflmlOP2K+LH/UOmiVmpkecq6Yv8/2YDXvWpEo8nyAKPrx?=
 =?us-ascii?Q?c5GXfbkWERGch49tZjkFa1nWRvRd/jAfX7tSOdWgTrnKxNB9jm3K0mttxurC?=
 =?us-ascii?Q?kqwJAeHJTPPPHsZ9lhtcn9V9LjPzLuX2WfomRKMuCcwKMGsjsCLVEC5JLkaO?=
 =?us-ascii?Q?xxmafxQUuU5wX46QKp/zc6NOK65D1xkvj6HmtYdXxirL1c8bC7qHU6w8XDH0?=
 =?us-ascii?Q?tEehOyW40nNFVVY1w1xeFTcmuOYwKC1/sBHhHUT50NslB4Sk51BqofedB6lT?=
 =?us-ascii?Q?HfoTj1jtp3sSCVzufie8HTeBiJz4W4z4OOUgzEku9AD5pbxBZici5jr9T2Ui?=
 =?us-ascii?Q?G51DhbezG3uEJ/Yf5UQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:58:19.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0915c25b-d54c-4252-1520-08de1b6f89bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE
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

add function to check if pmfw is supported, skip eeprom
check and recover when pmfw eeprom is supported

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 46 ++++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 +
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5377cde0c55d..402b6b002a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3767,6 +3767,8 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
 		return 0;
 
 	control = &con->eeprom_control;
+	con->ras_smu_drv = amdgpu_dpm_get_ras_smu_driver(adev);
+
 	ret = amdgpu_ras_eeprom_init(control);
 	control->is_eeprom_valid = !ret;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 011fa4748084..89d0def82797 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1546,7 +1546,8 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 	struct amdgpu_ras_eeprom_control *control;
 	int res;
 
-	if (!__is_ras_eeprom_supported(adev) || !ras)
+	if (!__is_ras_eeprom_supported(adev) || !ras ||
+	    amdgpu_ras_smu_eeprom_supported(adev))
 		return;
 	control = &ras->eeprom_control;
 	if (!control->is_eeprom_valid)
@@ -1566,4 +1567,45 @@ void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
 		control->is_eeprom_valid = false;
 	}
 	return;
-}
\ No newline at end of file
+}
+
+static const struct ras_smu_drv *amdgpu_ras_get_smu_ras_drv(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+
+	if (!ras)
+		return NULL;
+
+	return ras->ras_smu_drv;
+}
+
+static uint64_t amdgpu_ras_smu_get_feature_flags(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *ras_smu_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!ras_smu_drv)
+		goto out;
+
+	if (ras_smu_drv->ras_smu_feature_flags)
+		ras_smu_drv->ras_smu_feature_flags(adev, &flags);
+
+out:
+	return flags;
+}
+
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev)
+{
+	const struct ras_smu_drv *smu_ras_drv = amdgpu_ras_get_smu_ras_drv(adev);
+	uint64_t flags = 0ULL;
+
+	if (!__is_ras_eeprom_supported(adev) || !smu_ras_drv)
+		return false;
+
+	if (!smu_ras_drv->smu_eeprom_funcs)
+		return false;
+
+	flags = amdgpu_ras_smu_get_feature_flags(adev);
+
+	return !!(flags & RAS_SMU_FEATURE_BIT__RAS_EEPROM);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index ebfca4cb5688..feff46b22b6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -163,6 +163,8 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
 
 void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
 
+bool amdgpu_ras_smu_eeprom_supported(struct amdgpu_device *adev);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
 
-- 
2.34.1

