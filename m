Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0811AC98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 14:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A3610E728;
	Tue, 22 Sep 2026 14:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJ8SfNqs";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010003.outbound.protection.outlook.com
 [52.101.193.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A884E10E728
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 14:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBDiQ1I7eup0WrI0lhPnb74iW3HEdq/BRr2INpfahxJ3TebmOWYhBKWkrJi2H4fKxYCP67mb+PN6+sR+klnxFEWXaRecGJpGa8aFNsRKMa0NKlBc6ep7/A8R7cfUQEIXlkPgIuekIEkfd7ullLXdtrP0gH/2uKupfJ8sm9S8XdjXJtAf5z5fL5SYVCSe8Yuz7XDTNRWKPOwaQUJrk9/5DQ5RbpbsvzJ6G7m7iXyek2gUnyqMXMBVNdXe7VKyPtByg2ijCcz/zta9Py2BI89pntmeO47mEYbAVLkeDg8mzrYv1KWaytdaR2oZgF4rZtPFkzOPtr3ph/tJa/JSCCgOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E3Mm5KkoRYcJXv1HjscuqRhR77RdxNZsGxKMjlY0E0=;
 b=xzHDySV9QhS5LG59V3Ia8V+elsXqdIDqM/6sIDhEm2Eawy44qfpWUY742Yql9veaAKLzYFPC9FpXgps9T3AWejw+DupTwEHhkgvxok0Cz7NaiGvVgAihxQopj9alswnccY0/UpebM0BbfzOMzbGGjhAira0bRTEuK7FVddFV1dicHc1FF4Uir4rYPhcuhZAWRhJpg9rEEK7T5xMZlMTjhVkRMCYGGZJJ4RLc260BM084EDVk9lXbhNUx2fqyZ22O4y7qXeIsZ34tCOaYAafITUJnrkUH5i+BZLD9eVXKJHcIGZUr0tsWBxo6oH2C/nSuZzhXydLqT0v1NMR4dTmX2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E3Mm5KkoRYcJXv1HjscuqRhR77RdxNZsGxKMjlY0E0=;
 b=jJ8SfNqs/67SAyy/m7zfPSaYcmDdkN1J8mV+Xeom+vCqOrEhn5sFmta1N4ZhdKdkVbYAn8fj6m5q6g6+U09MO38JFI3Snakfk5OdbhvxHR9IT2qw06D5px96zy6VTcgYaGkvLhyZZrIOxv3uUBAv7PTM0aRsVYLLAyTdmDXjuI8=
Received: from PH8PR02CA0001.namprd02.prod.outlook.com (2603:10b6:510:2d0::19)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 14:15:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:2d0:cafe::1b) by PH8PR02CA0001.outlook.office365.com
 (2603:10b6:510:2d0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 14:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 14:15:43 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 09:15:41 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover resume
Date: Tue, 22 Sep 2026 22:15:30 +0800
Message-ID: <20260922141530.135273-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8afe83-0341-4175-61be-08df18b3fd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|18092099006|10086099003;
X-Microsoft-Antispam-Message-Info: tnQ7VopgAYvgQ3wbPI0Brn44atMQhf4HhqHTeTCaNcJbF/jahRFb7jxy4woEq6fdGnLZ5XpFzc6yJxqyU0soknfKW2sILNUJkDscXbnbHdknlhDHvBN7cuyek1Kd9xCFuXTyKgKUP/8sNpjiuJMttBEa/RHHHpnNaKdBNB8rgDx4BGM2unduSvr8rgKZJju/sDFHA82aHd6rTnGG3FdoFUzsWT4L+AX94uThHoF79YthYoyKxegO6Z9asRRXjmGJWFjgMIP7qM4TJq+JBDw5YMUzH6Cv6QQecGzK45xX273tztKH8Jy7C+usYHNtrenJ1ZR8HyHH4OaKAOkKahcOjsTZAgRZKmeZtlcbEicw3FwZiEVmJ8tHrVVYX2P7lGTH3g3NkqoKqKTz++sQbxA1gwjqWnuNxwo/0X+nZJU8Op1ExRTKij689LZG7JAzvEOKLUqM+lr68U8kvqU98QRXZByoy5LUx8ilL2UB3wYmWhEM5dX/VhUmWbM3pjFO7hetgfSUonIIqnaXcsF5wTXI5eHkI0OxjRbNaU/fQR9Id9i8etJUW9pvu1N/k5pfYuTUKaIntj7/Sne6M4AF/QV5QZeVSQiM6Stg1WyAgMjUs818V/uO3gRKdvR0u2ue9hOgGas21KwUKunmo4BnwdNqB8OUmFPWxiO6KKyeDLU7u7V5c61FnAKxbvwAbuwlMS5AgJu4RjmvrraETU/T6UZNig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(18092099006)(10086099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JLI4/GLDl1AnkXKsnPl1iecYevphBEykOemVV76Pf0MXSgc1cJUpGD+5Ya2n2XRRX5ZTxZgWAEOH5E8quxPUluPb7d5RaUoC+JZw1xWjmKh65eTech770cbV5Wc7LoTw1C544RDgGliCCy6LA6iQFW2WSy3L1DIzdR7MxADy4Hbeuv51r/3BgsIcUU3XX0F6mSq2ITHopzXsGS7uA2sEs6rl9rk2ms7/jJvr33v9o7+nHK2GR57kwIuoF2Qb1yJY15FZ4fnJ9uEKoKePXaauqZ02K/NPshdvite6mhGo6XYBCijEhSpaHf+iCSKCFmNeTHJmD2GdOGOPZMShuzXL4A1c3q64PHSBunoDWj1V3hcue7v6y1WK5hqS1EJIZuc5kdjU3HnOddhKyri6sDNC3AwC3fvDCbcdpa/XA80RT7WOYYFpq4SoQFynzHDegbvt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 14:15:43.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8afe83-0341-4175-61be-08df18b3fd69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

Allow RAS_MP1_MSG_ClearMcaOnRead MP1 message in Mode1 reset, to support
device debug mode setup on GPU recovery resume.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index 7ca2f33f2cf0..06b072737ac9 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -92,9 +92,11 @@ static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core, u32 msg_id
 		ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
 				params, num_params, read_args, num_read_args);
 		up_read(&adev->reset_domain->sem);
-	} else {
+	} else if (msg_id == RAS_MP1_MSG_ClearMcaOnRead)
+		ret = amdgpu_smu_ras_send_msg(adev, smu_msg,
+				params, num_params, read_args, num_read_args);
+	else
 		ret = -RAS_CORE_GPU_IN_MODE1_RESET;
-	}
 
 	return ret;
 }
-- 
2.34.1

