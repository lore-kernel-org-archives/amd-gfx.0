Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF99D2B931
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 14:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E8A510E5BE;
	Tue,  5 Nov 2024 14:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZriIhNi";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE2EC10E5BF
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 14:30:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXUzmJ0XjFSW8m010mRcnFyMzVGrfk5AGcYd5iguKgdhpC8qlCWZfS+ReiWiW3dMzVByNl48vRmw+tPKsPCWpkgMexVyPdM6HVDHCuk4LQ2UbhH0hsD0hkCbFOJnc22ZuEXraO1AdaXhSrcshIy0nZYFXUzzUcRgO4tf0hE3Q8RWDDJjwQlC0UeJD5qJf16PluQG6MSvhHDa8zMDpz5sZB+M4wbajSRTMxok9Lg8sVK7IIzre18X3EjPwtz/dXnxYV8fFKXuh10oI1apA+OEEblsGHUakDGWZEhnYu8i+rTIqcdYCTPbJYEU+TFbLk4QzrymzN1+vyDtkddsAtdXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSWAX6W/bmk1GcbcP5rZdejuCwPfYaDydKC8VQWRWHE=;
 b=fOKg1LhnBJIZv3Ym14z9FiP5a+CXucBw+T/RhjrnOVoul5Jzr9Vvsoro6V3FStSPLk/8AWfAhsi/hJF6eUhXA0dH9M50cWJ+VPWEjtFnNcgAw26pI4ux5Zs67PsnQlCWYDjFM0QdvX2qDTqWLwSbGPQkB0/DOR/ITf00AZtZXm7PgawvszwX+I/6IY1mvxNa3Bn4NtUpTVboiSDlbHK2KYAQ1a5LxvqArg9ni4v6vrQuIU/ESTpPp7vqWxVcQNGScJnAxT4aY6mzVv9vr3ZiuT0PYCd16vep244kKYvVagiphZ0vIb8wSViyHmzYZpg98Ag4QSojyO29o6ZFwhqdLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSWAX6W/bmk1GcbcP5rZdejuCwPfYaDydKC8VQWRWHE=;
 b=YZriIhNiKd7ifav+3wqZY4HADYXzw3JvgTlMo8UXCUmiiy7J3CtskcCKVJf7y8sKl1ZsJ+76WcC+JqWo6rCg5Y/rBhYYQbWCA8sKaZ3vjHMBZwfR+F9nYRp117gK+zom4xagdbYmvZ4Eto1PBirRdT+Jv9XpxcQaTF3qD91D3ck=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 14:30:51 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::6e) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30 via Frontend
 Transport; Tue, 5 Nov 2024 14:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 14:30:50 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 08:30:49 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <zhigang.luo@amd.com>,
 <tao.zhou1@amd.com>, <hawking.zhang@amd.com>
CC: Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add msg handlers for SRIOV RAS Telemetry
Date: Tue, 5 Nov 2024 09:30:05 -0500
Message-ID: <20241105143007.274828-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105143007.274828-1-victor.skvortsov@amd.com>
References: <20241105143007.274828-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2f5500-53ba-4526-8eb5-08dcfda6725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BpHJ4SauLnvGOKb7nrb29zMI240xfhoW1+9X0v2ThCMNtqNcx+SB6VIFff6Y?=
 =?us-ascii?Q?NLbjzjSM616I02gB+q+HJTG/Et94CRAux021b7GdWVUkoFOIJDgfjlfd3azt?=
 =?us-ascii?Q?ak2AAP7LMBpG37qjYYI8W/Ep7NgGXMoeMap7aqcVBN0JumOcWDZrSj401Igl?=
 =?us-ascii?Q?hZa4cUgWkZNQMukDt26wnrwmjXaEJkwCx66YfbZ8a1Mox6pGm3fAi/AimseD?=
 =?us-ascii?Q?ptYYzwSamvc4TH939JECtaEREepHqyPl5z7gp2YnOSclbRgV6r39BR7QNvTj?=
 =?us-ascii?Q?poACSV4W1PAqMv20yO/opyzaY1SvsXD5hO63bt5HYlTp3EUQp6lnrwJ3NWQy?=
 =?us-ascii?Q?qJS9wj/UUWiPFJWdHzI4bULH0rl6LaOzKwK1EQz/B8g+MPT8dBkkLk2kWzYJ?=
 =?us-ascii?Q?iTKz7ePmGD+fkkIpziq7Y7p71fQ0lFuOrvsTygp0VONtdAfbkkVHgpnw2gJ1?=
 =?us-ascii?Q?+ezH3yna+U7JKQFCg4iksDVVAAnFw3Yexh5ssS1Xkuu/D3dShMREr0pJzNgY?=
 =?us-ascii?Q?GkLPJnQe2QnamYMXUlFhB44qjoBXClXT/RAJ+UdsruPNID2TEyYTypqgJ71z?=
 =?us-ascii?Q?YwUPtxmosqwSSNTOTFY3IW088eeiGeo7m86/3YJ6+jbJyWQzbLxYah8N92gg?=
 =?us-ascii?Q?G8R+gZw6PjBmlqg7IKyXSafk+e1E0RixIege14VLSGW8xU/KohukiL9Cur5M?=
 =?us-ascii?Q?gNOLI/+L9yoRQ/BfUCojEusJTHf5t7X7dgwPBQvfR6sjyabOUT8AH4vwQrtW?=
 =?us-ascii?Q?F5Me7NTEsAoDqjMmr/DnSlBYkoTx8Eeg/Z4NmR+EFgYbq07Vc/Bm4RGrMq5b?=
 =?us-ascii?Q?QKQHSXYPxsLWQWBNgqsoDYb7tOr9Lwg/4C6AD16QXFDHu8NgUMC6NfaF9/bC?=
 =?us-ascii?Q?tiXGlEKI+syVejYu2uBnC5Orfq+NPKh9PZyP4PZZwsPmj3jg3AYxK2EwUo2j?=
 =?us-ascii?Q?0E5lwT6lxhpjctLj65WHGpT1tq/0VA1d9u/QtUSNIGpvBm5aJU/CkqD0HSso?=
 =?us-ascii?Q?myZOc4zy5CElIlY84gSsX4gDtfI1Czbnq/kKie9plWCPoaR1Q8D0MSZJicCD?=
 =?us-ascii?Q?Rz4FN57rMUWy0StT+NomV72nS0wQXMexJs02tYa81iXuzQTt7eN4n5MmNi7l?=
 =?us-ascii?Q?FiJEAZ1DAowBfiGjDkQPwTMrdbGuacuPEIqmAx4Nrxl814y1/yRmjJkBetf8?=
 =?us-ascii?Q?HFxUlKjLMWqLFZdtqnJQcSJq3X3afyRP7/aOujdxPR59By+BqUcQ+gScnyC3?=
 =?us-ascii?Q?3NZn2pYjh9TzB0N8aame1b5gWlvm8oI9iA7Ek+4nOz8+xRL/7MfSQ66LBnVm?=
 =?us-ascii?Q?/snALRU+4j0qOk7LSx3BN6DPzMSbVkLa0mgp+GSAsziVycen0J2RZdio3OxH?=
 =?us-ascii?Q?H+oalEh39ue8KHnL/9unBPJ7k32eeeL13dtG42pZevNaduJEwg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 14:30:50.3337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2f5500-53ba-4526-8eb5-08dcfda6725d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h    |  2 ++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index b650a2032c42..f6eee57338df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -95,6 +95,7 @@ struct amdgpu_virt_ops {
 	void (*ras_poison_handler)(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block);
 	bool (*rcvd_ras_intr)(struct amdgpu_device *adev);
+	int (*req_ras_err_count)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index f47bd7ada4d7..843dcd112b01 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -61,15 +61,18 @@ static enum idh_event xgpu_nv_mailbox_peek_msg(struct amdgpu_device *adev)
 static int xgpu_nv_mailbox_rcv_msg(struct amdgpu_device *adev,
 				   enum idh_event event)
 {
+	int r = 0;
 	u32 reg;
 
 	reg = RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW0);
-	if (reg != event)
+	if (reg == IDH_FAIL)
+		r = -EINVAL;
+	else if (reg != event)
 		return -ENOENT;
 
 	xgpu_nv_mailbox_send_ack(adev);
 
-	return 0;
+	return r;
 }
 
 static uint8_t xgpu_nv_peek_ack(struct amdgpu_device *adev)
@@ -178,6 +181,9 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
 		if (data1 != 0)
 			event = IDH_RAS_POISON_READY;
 		break;
+	case MB_REQ_RAS_ERROR_COUNT:
+		event = IDH_RAS_ERROR_COUNT_READY;
+		break;
 	default:
 		break;
 	}
@@ -456,6 +462,11 @@ static bool xgpu_nv_rcvd_ras_intr(struct amdgpu_device *adev)
 	return (msg == IDH_RAS_ERROR_DETECTED || msg == 0xFFFFFFFF);
 }
 
+static int xgpu_nv_req_ras_err_count(struct amdgpu_device *adev)
+{
+	return xgpu_nv_send_access_requests(adev, MB_REQ_RAS_ERROR_COUNT);
+}
+
 const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.req_full_gpu	= xgpu_nv_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_nv_release_full_gpu_access,
@@ -466,4 +477,5 @@ const struct amdgpu_virt_ops xgpu_nv_virt_ops = {
 	.trans_msg = xgpu_nv_mailbox_trans_msg,
 	.ras_poison_handler = xgpu_nv_ras_poison_handler,
 	.rcvd_ras_intr = xgpu_nv_rcvd_ras_intr,
+	.req_ras_err_count = xgpu_nv_req_ras_err_count,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 74e213e1e937..33d56e5f12ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -56,6 +56,8 @@ enum idh_event {
 	IDH_RAS_POISON_READY,
 	IDH_PF_SOFT_FLR_NOTIFICATION,
 	IDH_RAS_ERROR_DETECTED,
+	IDH_RAS_ERROR_COUNT_READY = 11,
+
 	IDH_TEXT_MESSAGE = 255,
 };
 
-- 
2.34.1

