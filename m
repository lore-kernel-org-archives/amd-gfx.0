Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A965FC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C43310EA9D;
	Fri, 28 Mar 2025 18:26:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ek2GpOxP";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F67B10EA9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waPoh64aLqSc3FFbnI9VyE+G9NfAsXvbN4S99qYdZ3IYeMmmTX9ECALjLDp6eP+fprIlsRMv0W60FmlK4Qjp9PFASFA+XkHdj7Dc4EZWdb8BsgbuFtWkW42ZY8YYkIsYSw/t3PUANlYOLsd2NR/3wA4oaSZnzQ4aswz3fyWR7f5Love7fcroXOpw4I6XwGRQO1h1EfVfh1vxot0EKVqwIvo/KTDpBbQPPP0+IQ78ECiLpLnEdsJBvkXpWRTx+LBQCP9K4+BGAAQVkxa4GTxcNXq5MQudmCSDYQLel0gK70xWSUrjlM8Q127GqR6M0pyVFCHbGxdoV5fj8z4YRtvG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq7XMbN6cp1mkyn/r18Oba23Krii5/Wkjwi/ayOK5QU=;
 b=SlJNFk5oaSdYVwFd44DROybYhtXZRaQoPQNI/0ClVZd2/7Aj9CyxICpGv9r3xDImU/Ma3EV1ma1+13298PPSDihCn6TKhZ0RJKMbsitJEiDWcK2ODD6Wx+X/UUVvrMQqFXuhFxGzHBZVC5oV4poIwKclOGlhSp9xdHmmAvtc1A50wi7bDOmoS+ciFmZE5cRP8k7Blrsb1XnteCDvgVdX9jbKTGS3mpRIi7vyVOofzabpfIyJ4yNqDDGZd50963/sctyuMRFYhk+UcGXPA8VtHvSZcBZpgL/1RbybOPX8wp+5jlCgXniKLGta8dggRB6xFH3W9uPOUmkX1d9J7hXhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq7XMbN6cp1mkyn/r18Oba23Krii5/Wkjwi/ayOK5QU=;
 b=ek2GpOxPmr7omvp0OZtBf/UXeVafNjWkUGO099v6v0h6QkYtFFrE4cjXmpfl1GWWSSkCVpuxeZoFOxsmRe+PgNF5jXJT3EgaBDwp02vtFBprMahc6kkA2imE7vUzImgsdJnfr/j5IxImDfltqjMu7uJdA3pAx9Ul7n89Te/u6ok=
Received: from PH8PR20CA0008.namprd20.prod.outlook.com (2603:10b6:510:23c::18)
 by DS0PR12MB6653.namprd12.prod.outlook.com (2603:10b6:8:cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:26:50 +0000
Received: from SN1PEPF0002BA51.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::63) by PH8PR20CA0008.outlook.office365.com
 (2603:10b6:510:23c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.46 via Frontend Transport; Fri,
 28 Mar 2025 18:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA51.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:26:49 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:26:48 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: enable FW workaround for VCN 4_0_5
Date: Fri, 28 Mar 2025 14:26:33 -0400
Message-ID: <20250328182633.19705-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA51:EE_|DS0PR12MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6b4c5a-85d5-4d1d-f5fa-08dd6e261ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?US3XA/WbVjOSjjG9odT3mYipG0TQoULmaM+9j5DnlEf/vBs91fLTiAa3F++X?=
 =?us-ascii?Q?iYkT+BeLjeiZM9Ry9p6sbuaMJghCa1WEad85YnxsjgbIQlTuQGvJoUEenGPq?=
 =?us-ascii?Q?cC5BgNO8B4X6DPP5nte8RjlioVEKlfLf6xjZVUCt7IQ/8az+QS0Qx5yp05OW?=
 =?us-ascii?Q?lIrDjbj0qVtgUO7w2vEtvOuTtFIKRaimbHgGJxwcYogdL5txWugyp5OpftB2?=
 =?us-ascii?Q?GdY9mqNUcxDLX60VoGLQ6qs/S0NX9ta8ksGzIMyFCihD3PMeRgzMQCaxqNa/?=
 =?us-ascii?Q?jW6zib46cnrGysgqKykIEr+n4sZo0YlbpRwURRCOZnoipCHAMncyHuDE1tsU?=
 =?us-ascii?Q?lhAD90BWIFaZ6Jw5bdJscQVUNgIy9ZKjZSF36tJo6lej4PzUGuSuYJ+Ym8rh?=
 =?us-ascii?Q?ZXYHvaiUhikOEqfOqpnEXC9gM3w/uCapl0Jl8yoQ0h6H+G7u82HidXzBULIR?=
 =?us-ascii?Q?a4HYhvq4wRGNECNVgQy1EShiADzJHL5kgPQXuJUWbhM1fH+4wumfS7Aol2RY?=
 =?us-ascii?Q?KXRZU9FVm5hKOWfwm6tyDy3mzHTmMXkA1YwnL83simB/iZBmOaQWGeYe64DS?=
 =?us-ascii?Q?FjozO4zNXy8Zjh83Dxl6QJks//WwjSzwDLiT7kZivnrNBPni+ANA7EpKo2R/?=
 =?us-ascii?Q?UjFNPQSTr+TtjsYfw7QSHWX6ZeB4xGD7sX6r+7k0NsANyNjgjmF6AUfeVO5k?=
 =?us-ascii?Q?vzv6sKoQxZvtifl9fCkcB/d//YNaaycL9QdwmhcwVAlbxn7K1U0DsclAbIs9?=
 =?us-ascii?Q?Rzk/IKw+akSwdniKgobA1MChe/oIjggfyKbD2KElXyQ+jDbPWn+0H0HyNfU9?=
 =?us-ascii?Q?7fOwdbS8xSgADsaVZ/GV4mERqcBMiGm0Iyf5BFsFqln6yg+m88TsKA5x57my?=
 =?us-ascii?Q?5CTX5eD8B6tsond8aLTDzVNhTn+t6m8CmWkVb0ilNAdYjGfpQlrJpxu4Z9gs?=
 =?us-ascii?Q?pMjxEw1rJ1Wh2eIOD7KlAHc/mU2OstrlB+ykZcn1ZwQQ/qZth21Pn80E8pd2?=
 =?us-ascii?Q?hx+HX7TtM4R/cBswTkkJ3/IRoN7MxGpQt2F648fpAutzntzT03MOkJAkLA6l?=
 =?us-ascii?Q?29kM7FZewjaQ3sW4YqD2Y2XbX7oNyAC1Fiw31i16XtIqi9VE/tYV6G8n/ta1?=
 =?us-ascii?Q?e1GM0DJDRthH6bOccuVblnUkOs5pjDx0j8h8qaUUSMyqtTLNZAqbPLshva0e?=
 =?us-ascii?Q?IfLjGpF/QZ28cjGy0Gha8+zl60upDC8zvHLyfQPyIJAlB9eCMlLZc8pDfYzN?=
 =?us-ascii?Q?rNzyrSxKFZ3K+nHJiex44M89Eh9Ie2ITkVvKFLcbl2m1iAVkYGq6V4vfSGi/?=
 =?us-ascii?Q?UyxHyhDUuoFJ883hlkhqv/Ra3Bj4GcaQxp2aBi9cFn2OpYf7DHRw88j60UqV?=
 =?us-ascii?Q?naoV7/5qj0gox4K43ymAgsnPSTsG51grshEKV7riSPT/E+IsIxXKOZ9UNDXB?=
 =?us-ascii?Q?AkwKoTCXTD51pZECiF9DwzDu6eaSkxiD5MjjTfULOVMVJr6cFzJNLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:26:49.2494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b4c5a-85d5-4d1d-f5fa-08dd6e261ac2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA51.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6653
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Enabling VCN FW workaround for drm key injection through shared
memory for vcn 4_0_5

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ba603b2246e2..a8cfc63713ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -207,6 +207,10 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (amdgpu_sriov_vf(adev))
 			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
 
+		fw_shared->present_flag_0 |= AMDGPU_FW_SHARED_FLAG_0_DRM_KEY_INJECT;
+		fw_shared->drm_key_wa.method =
+			AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
+
 		if (amdgpu_vcnfw_log)
 			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
 
-- 
2.34.1

