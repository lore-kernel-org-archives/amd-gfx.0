Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7535C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 05:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B06610E5E6;
	Mon, 31 Aug 2026 05:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgwZmUPu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011000.outbound.protection.outlook.com [52.101.62.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C09610E5DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 05:25:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPh5HGB9px2QYhI8Go0sxmdCmNSI4etKa7Bh+butI8ctV7Yzy4dJe/YDcLsFsG3+scMPFcMkw/3yC9b0tZHVas/AWxfrHsaFSPoFm59RP38Fvyxo8b1zJDx2g6qAKOj6GPC8S6drhKsuCJgJ9Ke08Zm+abCpJHwPHwo+JLPXAdY9KWqAi+NzrUKxXrgYZjDLT3gVqGYjOuadVcYunIlop+u4kHcYOQ24Nm7zVGjrtj5uGI6svbwCDgMr9Plr0kkTgIF+YkKp1pVegNHdvm46YAKQr96jn7CZi8MmYPBfsp1HpLEGhqSst5JBl4e+NdoTNoeF0AUzmBcl0Wwq9zhdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNSql9Bv945WcKJI5OiUuMqhQwm3p8ugYJqK4gGU+LY=;
 b=ki24tQBh+4SsbwnDFMGAcQRdIQrPbLLH43D9SN3bid0cTBaocsS+UFppYn/LEaEuueiqf2CxBG/IP8bxYBHFA7qmPAcybkQOFrC7L4+Df22w2EJqdH9VChnZvWafCqD+T/UaoLm2LB2bhVQGS0xr+1vB5z01QWN/68cUxNGcpPuzq3Nya6WLUAYKiOsC//J74bhB/sTTKhmBMbW+QLQYT+8V2QZI3aqrPcB6/PNE1Zoxd6PJKKOPBdvYYijDt2W99BYIf7bdDiX63v3rGJQR/QGAkUAtyYjbEPgxiAbl6PsY95PLykb0oL1ZvoT8RTsfi5IdOy1swZ4HN6lZHCdAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNSql9Bv945WcKJI5OiUuMqhQwm3p8ugYJqK4gGU+LY=;
 b=lgwZmUPu5IeU6eHJOa9q+7wjLAcet3i3WC4cluZwWWfED+cyozgWVhIH+ugWxZlj9wqYc0J+PVhTH6kzRDcU8UYz/7EIzySYTcjxnpa29LIab2pI41EFNRy7Rt0q34Pus01UPRVu/SVlIhc0IINEDM7sK+sBAo4igKpKfN0+Uec=
Received: from BN9PR03CA0779.namprd03.prod.outlook.com (2603:10b6:408:13a::34)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:25:26 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::3) by BN9PR03CA0779.outlook.office365.com
 (2603:10b6:408:13a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 05:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 05:25:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 00:25:26 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 00:25:24 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 07/10] drm/amdgpu/sdma7_1: honor mqd_prop modify flag in
 init_mqd
Date: Mon, 31 Aug 2026 13:24:19 +0800
Message-ID: <20260831052513.1518180-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7faa79ef-e815-4cce-f106-08df0720435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: e3y/b2RArve/CP/WPIfz+MQlk7jUE5QN0BnahUCyOo+m5UPA+H99ZxhiQpInKI6Z7lYHHcumRyuqxVdOPUf85sK3hUMfLbi8HW90TgUO/QhamcBqfRKLvG6jU9oA2QRU7vhuWZovpqcW2ehgKG1Ed2MgAHb249M96Ao8MsseojzyQGIDIMNfc6BJZf1Wkq1hKKuKG5V9Id5LTCWq56VztF4pFtu9laqvC7oJE+sGcVNXSyhjwqK4dV28gt1M2t3D6JJhwbvj7BBOj9TwdYOgOs41S/aA2ccyjP9w+6Q4xHx/e3XO8LDmeShYdUHslBpviPIVvdwH0ue+X86okb0myWZ20piHANPDHITj03Lt2Dpo7nP7gmlucEvS9RrBo+DHE43bBn/MgtLVSb51XcFbAbS7ZZ9HiOMn2JtEGU5SOzOTu9M/hdoL6940WqpAs+AjbDPA4yfs1dCi63E8bkoM0iuxXyX7J5Srb1fUWRLZNN+Rdzhm/gVvR1sAvvXO4yX9xGPj6+k6WrUMQHcQ4U09C3nv7vCJc4I2ZkCz4iPvvUk0hvG4IUXJ/rFHjbcX+A6Ux8ZuIs3zD/mIYdL/Um1WYSlIB1QaoDaOKiKlexxSW4TA9Cbrf3gfQ5ICppkrLzjsrnxlO9xpDBSote2oKBSYq58RqcJbrP9/PNcpREtMVPoKi4znR6t2DGBXSZWSr72MQ5LaoBk0ufTX7B68/y8QSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: URALSHyPGbrdtybgsyaTFNBwUcklETOeSM6qWT9Ccxvd1h+8cQrBiDXFj7gi+UcBNqvvb+OKXoh6S1fL45HXgXazMrBtG6CSFiHAGxlbvQ8ySdnB/Wn/ajseB2t/MumJJwLLMQdK6No0LwqU7+H73ikHZ2yJDhztqX7EALiwsI/CKs+DvmOWhaCA5faMS+eLE0+DFj+aznZc2Mz+kVcmkUmuot4XJy7O+4fPh8PQKz/riqiPz8xlwW501pi/lOnGQPva9aThSr8c0NzZj14TAqTY0nByBeN/x80lUaGz/7wEr1Y0az/2G321W5wd8q56LcWjwXM4ALvjimG1T7lD8lJnxYx65oxWJ4jcy6FCjnAFc1BCuudpBDx3NORk+nYt2zdaWbMhfd+uId4W2kRssd5/dhUEd/NqMjc9EVGwU+ZR8a+mnb9t03/OQmUpBFoo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 05:25:26.0180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faa79ef-e815-4cce-f106-08df0720435f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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

On a queue MODIFY (prop->modify) sdma7_1 init_mqd keeps the context-saved
rptr and uses prop->user_wptr as the wptr, so a re-enabled queue resumes
at the first un-consumed packet. It also forces IB_ENABLE back on, since
ib_cntl reads back IB_ENABLE=0 on a stopped queue.

v3: consume the mqd_prop modify flag inside init_mqd instead of adding a
    separate sdma7_1 update_mqd callback, per review.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index e9a3bcfd7775..5a66aa8bfa0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -886,6 +886,15 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_csa_addr_lo = lower_32_bits(prop->csa_addr);
 	m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
 
+	if (prop->modify) {
+		/* MODIFY: keep the context-saved rptr, use the live user wptr */
+		m->sdmax_rlcx_rb_wptr = lower_32_bits(prop->user_wptr);
+		m->sdmax_rlcx_rb_wptr_hi = upper_32_bits(prop->user_wptr);
+
+		/* ib_cntl read back IB_ENABLE=0 on the stopped queue; force it on */
+		m->sdmax_rlcx_ib_cntl |= SDMA0_SDMA_QUEUE0_IB_CNTL__IB_ENABLE_MASK;
+	}
+
 	return 0;
 }
 
-- 
2.49.0

