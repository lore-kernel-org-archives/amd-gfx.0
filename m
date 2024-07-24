Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF48C3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 18:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2F510E796;
	Wed, 24 Jul 2024 18:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbe6lcSN";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C4610E796
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 18:46:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORlzrfxxzbJ4lxKdRcvKZmz8GlSvhcrGWS/cE2ZLwNhAc/DGmkvRgdfqgliO4j23IuNtDQabEn2ITfUZs13itn3a4thlRUWxtu+cFSxKIbyyYNN74MlcdpI1I8uN1J7RG9BU3GLtjXFSJ1ulFVGPO2nqa9vi13MuBPHuLhx1yRVZ8JV/+yT6bgYU1Ysgb+QzEmRs+6Ki0S580HwR29DdS8xnW0YroQW+sjZITi7+RUAXkJAzDm3w8+u6ydXWMEyMiAH9x9TfgxBP0RmD+s0Wzgl05WyVLB+oCdewzmMayC/v9o+Hpc+YhSzuLAUiswWbPX2iwRJntL3dlUPZYDp2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SfxbSf7WRNRVUu43MXxU90oVWzK6y+msg+VD9Vt5l0=;
 b=epal9K+Qm0M3FFzivNjb0mezXUa2VvM5T38CAgAmuO0a9gwaxYw6C0ySRt8V+xfNTtwWpSR0FnmH+nZ2QJC4HH4djJYmyKlTzvy96s1elHyxQgUIRmcJGTi+pbIzz/bZ0QplYl3/Yx9CtRyP0e7ol5Grjp0prEax4Aa5lz+jjcrnSxDxhV34ZMDY9hs+occY097YyaNYj5Lg96Nj4KcBGryBIZYF4d0Q0+aHqayRXnZNbJe7JgEat/ENbQv9dbX2qyxRFERKVw6Ql0O0mVzzcsE4uRudyUAZ5OlQp4IFb0/cw3UF/opk3bfv3eqrCLXeiFIa342v016KKtxUunIY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SfxbSf7WRNRVUu43MXxU90oVWzK6y+msg+VD9Vt5l0=;
 b=pbe6lcSNkykUnzqqNFWdHINbc8jy2XNDA/DsGGDgDYxRnU0LKtaZZDFy529xRa6B5g6KZRw/bIb5nIdpyXtsUnCFMOyPIg9Y7xSp2f+QYcw7Dmj9cuIRyLacS8UjnqUdc9Os+0uCBe6jzDmyZotKtEpqH12zOm7VZVlIw0vT1+4=
Received: from DM6PR18CA0034.namprd18.prod.outlook.com (2603:10b6:5:15b::47)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 18:46:51 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:15b:cafe::6e) by DM6PR18CA0034.outlook.office365.com
 (2603:10b6:5:15b::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Wed, 24 Jul 2024 18:46:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 18:46:51 +0000
Received: from mchen-linux-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Jul
 2024 13:46:48 -0500
From: Michael Chen <michael.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <michael.chen@amd.com>
Subject: [PATCH] drm/amdgpu: increase mes log buffer size for gfx12
Date: Wed, 24 Jul 2024 14:46:16 -0400
Message-ID: <20240724184616.196690-1-michael.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: aafbd422-7512-44bc-59fb-08dcac10fb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lXBUtpvKXr1D1V1MQykux+eLXQBTCu/YcMV0w8miH3oNlqJOHaRuHLka9dCF?=
 =?us-ascii?Q?CZetk/qeUnPzkvpaCa+5Fdhnel3ZKw5bDqWvjoDdOPH/Bz+hrx+BwXZMZJwz?=
 =?us-ascii?Q?VAsUXuXcMFHCgMF4JK9lTbVSLFRCyD82noQKEkBTquFdRixEjbL6jAUU7Paq?=
 =?us-ascii?Q?J9UcGRkEBAgf5dYHgTQZHULWhCgN0ZnWlWrlJlQ74zPL10q/DIMyItbKyMau?=
 =?us-ascii?Q?qPNm1iN1BAu9fDik9EtXEpTOVWZJvG6guvj0sYsH8sNMQeRdSc8wd4EQsfri?=
 =?us-ascii?Q?j335fIOO7k3M6+hOZwtqUh0gBlm4JTryC+zF/whtjlUhFv1rsP+RgCtMJ4+J?=
 =?us-ascii?Q?g1M1WBaYhIzKWt3tCFVTU5a//N5SVIHLGdOcg0246WZZQLmvZYUn3LZKgYT3?=
 =?us-ascii?Q?iV33rWWXRKV+qFsQlwr0cTtrj20C/soIIuPd41ELtpsbvKB9syIkrU/7BZAg?=
 =?us-ascii?Q?Ycids6DemhaakTaX/ToQs2MyFSxeoAEMZIEVqArcYS0oewHhXbDUDAModxN5?=
 =?us-ascii?Q?drjrduSWdmmslTjoMzPXVL5/vW4s2bdzz24B+xRhS/WBBZsyY1jPgPufuMyV?=
 =?us-ascii?Q?ErIesySasw2Faz8dhex87hHdwE47esxYmHCuNo3OoKohZzR1UKplo2u+tIJ9?=
 =?us-ascii?Q?Vg8HpTWBWcPLtcL1RX+dsY65fwimujdf35tiy2WKn35soZCgXoX5nA+IEm0T?=
 =?us-ascii?Q?j0G6R4Iq+b1YU/P8GO2tMX8uJi5CukHEZQraBwHuDB/XDzuoVwVfj0BJcPlB?=
 =?us-ascii?Q?qlI315sYUwA5skDfmmZqV/ywaTUR5F1jjV4ZCvdehpjBOAG3Ye6btyY+q3VV?=
 =?us-ascii?Q?I7Qt0HvXZptGe5OThnLf83wPC1M8m6zhM+zSESW8b6wU+9iLe1USKX4hbdOe?=
 =?us-ascii?Q?LD4TvoEmRtzik0JelWRzmoUwyRUGdoQwFoUl3UzTEGozOZ/u8ke/T6K19KTB?=
 =?us-ascii?Q?yGykTCiAwMQkkaPrrcVm4bzdYgd52Lnf+29Wep91bAoAbC97H+KYjIlao+9N?=
 =?us-ascii?Q?Hj/5aA6diApPz2JKm56Lo3F2i1oy1mpgBp6f0DAqQ39ciSeKP+xHbrwliQwz?=
 =?us-ascii?Q?3XPpnCALxPLx3G5tZ2jUP/SqbgIhPDsRqSoBQY+qCsAW6ZKBmYLzqyb4Xehi?=
 =?us-ascii?Q?b+VsVv9b5gBLkuDs6MdZVrylLGHFxqTCDilolUOX2wBsFEiE8o4AIAZ7Ufqe?=
 =?us-ascii?Q?4Z0kD4pfw9bWufjnQt9MmUqeTLEArULxYdMpsLaCK+8CXTF3oq1orzELxrK5?=
 =?us-ascii?Q?zNDIrEN8wYZviHTNTnSxsfti6ARU0uLID12HnxcflbE4hSFs5TSs+u4nRWB7?=
 =?us-ascii?Q?Pcn6RddLeNeadgBUXhDDZQZwnY9NaQkqOFHLkwqmdmw+Eu8O5TkBCdlpf8Xc?=
 =?us-ascii?Q?8oCK41JRW/KVf1VBHwgvGrP1Guf64iBt4evs/kU0h0zzrNdW0wnF+z2ZsBLL?=
 =?us-ascii?Q?ARsBPdK7GY4kiGMwYrsD31SoB0pic2jG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:46:51.0018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aafbd422-7512-44bc-59fb-08dcac10fb0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748
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

MES firmware requires larger log buffer for gfx12. Allocate
proper buffer respectively for gfx11 and gfx12.

Signed-off-by: Michael Chen <michael.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 2 ++
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        | 8 ++++++--
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 +++
 drivers/gpu/drm/amd/include/mes_v12_api_def.h | 3 +++
 6 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index e499d6ba306b..dac88d2dd70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 	if (!amdgpu_mes_log_enable)
 		return 0;
 
-	r = amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE, PAGE_SIZE,
+	r = amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->mes.event_log_gpu_obj,
 				    &adev->mes.event_log_gpu_addr,
@@ -113,7 +113,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	memset(adev->mes.event_log_cpu_addr, 0, PAGE_SIZE);
+	memset(adev->mes.event_log_cpu_addr, 0, adev->mes.event_log_size);
 
 	return  0;
 
@@ -1573,7 +1573,7 @@ static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *unused)
 	uint32_t *mem = (uint32_t *)(adev->mes.event_log_cpu_addr);
 
 	seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
-		     mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
+		     mem, adev->mes.event_log_size, false);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e11051271f71..2d659c612f03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -52,7 +52,6 @@ enum amdgpu_mes_priority_level {
 
 #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
 #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
-#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size for MES */
 
 struct amdgpu_mes_funcs;
 
@@ -135,8 +134,9 @@ struct amdgpu_mes {
 	unsigned long			*doorbell_bitmap;
 
 	/* MES event log buffer */
-	struct amdgpu_bo		*event_log_gpu_obj;
-	uint64_t                        event_log_gpu_addr;
+	uint32_t			event_log_size;
+	struct amdgpu_bo	*event_log_gpu_obj;
+	uint64_t			event_log_gpu_addr;
 	void				*event_log_cpu_addr;
 
 	/* ip specific functions */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 68c74adf79f1..1a5ad5be33bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1173,6 +1173,8 @@ static int mes_v11_0_sw_init(void *handle)
 	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
 
+	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE;
+
 	r = amdgpu_mes_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 48e01206bcc4..249e5a66205c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -561,8 +561,10 @@ static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
 
-	mes_set_hw_res_pkt.enable_mes_event_int_logging = 0;
-	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
+	if (amdgpu_mes_log_enable) {
+		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
+	}
 
 	return mes_v12_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
@@ -1247,6 +1249,8 @@ static int mes_v12_0_sw_init(void *handle)
 	adev->mes.kiq_hw_init = &mes_v12_0_kiq_hw_init;
 	adev->mes.kiq_hw_fini = &mes_v12_0_kiq_hw_fini;
 
+	adev->mes.event_log_size = AMDGPU_MES_LOG_BUFFER_SIZE;
+
 	r = amdgpu_mes_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
index b72d5d362251..21ceafce1f9b 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -28,6 +28,9 @@
 
 #define MES_API_VERSION 1
 
+/* Maximum log buffer size for MES. Needs to be updated if MES expands MES_EVT_INTR_HIST_LOG */
+#define  AMDGPU_MES_LOG_BUFFER_SIZE  0x4000
+
 /* Driver submits one API(cmd) as a single Frame and this command size is same
  * for all API to ease the debugging and parsing of ring buffer.
  */
diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
index ffd67c6ed9b3..4cf2c9f30b3d 100644
--- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
@@ -28,6 +28,9 @@
 
 #define MES_API_VERSION 0x14
 
+/* Maximum log buffer size for MES. Needs to be updated if MES expands MES_EVT_INTR_HIST_LOG_12 */
+#define  AMDGPU_MES_LOG_BUFFER_SIZE  0xC000
+
 /* Driver submits one API(cmd) as a single Frame and this command size is same for all API
  * to ease the debugging and parsing of ring buffer.
  */
-- 
2.34.1

