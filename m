Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD57C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 23:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656D310E19A;
	Tue, 31 May 2022 23:56:57 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C1D10E3C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 23:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnUuPz75kLoqyc2JEd1YJVIR+E71qy6StROimyayl7Gm1/8LaiU5FxNa+gYCTGehaIVVmR+98iWD+8YHI4AvtkgrwwHZ5k/j8oWDfks2mznNOUK6sv9yJH2xRKm3IUu6iHSiq54PQ6esCKbl/KRB82rPcxrxxbanthhmsy9L3/gTzPqiYDLgJeOKti8CivipgXBIvuMHVI9h4b3RqiWz6mfO661yLUdHV6GwEF+L5EElQHpuwy1TrhRUMUizft4zC32ipm4nOJUnJIGDzzzR8rAj3iyUVjPfYSsqph98+t2M7dEuZZMP7B501jHaf9jMJZJoodTq9vJtXb4ZYcHVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdG30wiEHNPHtPPy5a3INsU5PF4O866x/C5BO/JIJ6w=;
 b=W4CAuyRAzT5r4Q1xQW+MSwv4ORiDtigupRPByOGC2SVoCvUGAKlXPx8gr6AjmceukTU87FmZNgtmcoIQttrXMWVEGH8EEU925olq1z1vyfZtq1dtBV4un+2pexgIs5u7zqr+NSkw00DJYPj0xtP4S/Q+GnKloPiLdmLSuiVISEWYhBdirszv0X8OeoW6/tuV+vQli2Fnr7zYMx/A0gPbiz+mGxSALYR2HUhBnlpVij0GPEhDCSAlramXAFYUQVO5sLEcy8fb1Dc46b7L0SXHsiTMHCV/oR4zKRZqkFA11VCE6qm+RloT/B3GIYxkd9Rafx/MqW6r2n8AV+IU+pOEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdG30wiEHNPHtPPy5a3INsU5PF4O866x/C5BO/JIJ6w=;
 b=X/2wcZa4/gfrtDdAkgGUcXx37VAXDllIs/d/Gt4I+krEJVXz4+YK55vf/3zvl1iCZ4vlgQw+pJ0FDJJqqI36VC15g+YJXoebbgXd/cI4SxFE3gTBUBs4TpEEnWmH2yETtnmZzOW24uLbz58ESQg/vQOs4/FF8+D/2ei5Optch5Q=
Received: from BN1PR13CA0015.namprd13.prod.outlook.com (2603:10b6:408:e2::20)
 by CY4PR12MB1416.namprd12.prod.outlook.com (2603:10b6:903:44::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 31 May
 2022 23:56:51 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::e1) by BN1PR13CA0015.outlook.office365.com
 (2603:10b6:408:e2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12 via Frontend
 Transport; Tue, 31 May 2022 23:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:56:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 18:56:50 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD definitions
Date: Tue, 31 May 2022 18:56:41 -0500
Message-ID: <20220531235641.13607-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e274ecbe-2ff8-429e-971f-08da43613b4f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1416:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14160405F9FB686416E466E1E2DC9@CY4PR12MB1416.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0+fw2R3DzOPZeSRSrvk9rCrjOAaaKX8A4Ivq73pvlY5CHMm6K+SPsXMFm61iqFNi2sKsB2GXH+snwCEjklI8oXPoNLF1wDN8hDGq/wdMK6SRz5DEMj8NgMb+xKWLxld+i0u8UaULt/n/y0RoLP1OVaEVnUsY725CckAuAgq45Cv3vIOd+S/bxmw7p79/gqgwBPg67ZHh7J6yNA22Q9ejlaC9zSkY2cmEtbmwrS+oAT+PVGt2Glyr5ZSyJXrCg7wR3Xb4UflX/A+kF5P5jDMVYFVT8rKySo5RocbFWIwBp9k74QIXNBaWkV3u8P3m74ktv+Uqb3969mive69ZYVjwidgCTUGQCogdloqEvYYg0I1U4p4cRZeDlMppHROxK3xXY/PqewDOoxV6oW3ZGZ/NLz2CzVa1uftyAPkew6t+MCT+NcijNZN+0xhf/d7sXA4b5TQmI3tcMTO2gvkRmBiXGua1drfq9PxVojwPQsxVSfE3aeOSCpRYDMzPItJUwHQQ1KfW3604n6bCd+/h2xEKbAUYNjn5gPG69hKZ8xAVIztCDv1MQ2qMo8J+AI2hCKhyuz0qs9QDfMBxQy/k9pUdq7ENGAvynX8tVvSrYfloBHhCsSuRPSVCSZYvrBL7CCHwbhtCZwkQB2ioTDHgrt4qr5PCgkj3ex4O+MBWV2VY9sJM8xUstwVWaFyYzp1CRY6luAkpuLLe2urPoNgyoPgyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(1076003)(2616005)(2906002)(54906003)(36756003)(316002)(26005)(40460700003)(82310400005)(36860700001)(81166007)(186003)(5660300002)(7696005)(70206006)(16526019)(86362001)(70586007)(4326008)(8676002)(356005)(83380400001)(6666004)(47076005)(426003)(336012)(8936002)(508600001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:56:51.1682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e274ecbe-2ff8-429e-971f-08da43613b4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1416
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Chang <david.chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Loading amdgpu on GC 10.3.7 shows an ERR level message:
`kfd kfd: amdgpu: GC IP 0a0307 not supported in kfd`

Add these targets to match yellow carp structures.

Reported-by: David Chang <david.chang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Jesse(Jie) Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 5e9adbc71bbd..cbfb32b3d235 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1516,6 +1516,8 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
 			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
 			break;
 		case IP_VERSION(10, 3, 3):
+		case IP_VERSION(10, 3, 6): /* TODO: Double check these on production silicon */
+		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
 			pcache_info = yellow_carp_cache_info;
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 8667e3df2d0b..f8635e768513 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -73,6 +73,8 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 	case IP_VERSION(4, 1, 2):/* RENOIR */
 	case IP_VERSION(5, 2, 1):/* VANGOGH */
 	case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
+	case IP_VERSION(5, 2, 6):/* GC 10.3.6 */
+	case IP_VERSION(5, 2, 7):/* GC 10.3.7 */
 	case IP_VERSION(6, 0, 1):
 		kfd->device_info.num_sdma_queues_per_engine = 2;
 		break;
@@ -127,6 +129,8 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
+	case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
+	case IP_VERSION(10, 3, 7): /* GC 10.3.7 */
 	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
 	case IP_VERSION(10, 1, 4):
 	case IP_VERSION(10, 1, 10): /* NAVI10 */
@@ -368,6 +372,16 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			if (!vf)
 				f2g = &gfx_v10_3_kfd2kgd;
 			break;
+		case IP_VERSION(10, 3, 6):
+			gfx_target_version = 100306;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
+			break;
+		case IP_VERSION(10, 3, 7):
+			gfx_target_version = 100307;
+			if (!vf)
+				f2g = &gfx_v10_3_kfd2kgd;
+			break;
 		case IP_VERSION(11, 0, 0):
 			gfx_target_version = 110000;
 			f2g = &gfx_v11_kfd2kgd;
-- 
2.25.1

