Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20148FF60F7
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A784910EA7C;
	Tue, 31 Mar 2026 09:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I+G8G0aD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5919C10EA7C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 09:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTpHxWCH6hze7vL6pBJEzMruTzZPZIna0gKhdDWNQe6zrPvQ+JzScfUH2hzNp/oeuGUURM22dMdijZhXRCaVqsh0QBfuOayfPYfAPGPEGgzY/NoWNbqSRB+K7RC/7zenxmc8k+Gu5DoktQKu5qAsZ+QJc9R5haJjD5apfQ+CeJOct4bX4+yFWPZlUXocKlNCz78LR7F/csmZaXYk9Ooui/SvXbtnqwgGMP7tricNdnQgdZ30RgnSKvcbBGE4jxTJe+HFx5srhPjufvaWzaSDlZSW6vbpnqlXvGdswVbwc3W0hpODgdx+7Xesq9e4nXZd5ZPbicUIOmL+iU0dHW4D1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO0m+Z9SNnqnxht3+BGq9KjiRBGuGgGgWW7GCTm+6YU=;
 b=VGRtp6/oQK8+Mv81WtBQSt8xDJfG3euuHtvnGO/DpaL71iDdUmBZqKUZmEIEeU/ufoL1G0CnfNWoiPsCrd02wzTCvIBUh7bbAOHyokhrsJpaj8aQ0oNCKhHZJTgXH9aOtwDhpkDzRhRAfVEi7VLLxUxw8l2TThREnGvF8VfFx4R6a2RKYaKRtmuYJHJ/T8wqyVFeWlZRx4i2m50+HZoVxSvilo+sTMmRp0Za4r2a+cQaNLz9u8H9VqR1imWFua+1LMRmTQtjA18Uk536vLN7AmY6O2MVGLzk6o2Xv9ofYXrBboFk/Sprqh465zHwuq5S8Y6TBrUws4dm2BcVhhm68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO0m+Z9SNnqnxht3+BGq9KjiRBGuGgGgWW7GCTm+6YU=;
 b=I+G8G0aDInLac0cRU1rOYQJUEB5Mj1B2Mi39umV3xLaN6+pqxR9Lpo8VNNUki005vPmjEHuWQs7YZbNHyqCqeZ1uHiDZdqnoTnAQKm26CLtrIYe6AWgMZLMuKl6FsRAo+mt2mUDLGubNSIwB1NvIRPtTQ5YYY4reJjKflzMaPZw=
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:53:54 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::fa) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.15 via Frontend Transport; Tue,
 31 Mar 2026 09:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 09:53:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:53:53 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 04:53:47 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/sdma_v6.0: enable WPTR polling for UMQ SDMA MQD
Date: Tue, 31 Mar 2026 17:53:36 +0800
Message-ID: <20260331095346.1331511-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b5fcdf-fe4c-4b38-a7b9-08de8f0b6b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: M0ycPbmo1Xd77TZ+6SPlqCDDJBE6cNArlCL0eBs//YeMIgO3/5nEub9QYxKMmJyrWM2YeqBCVWfPd655R8Q9kwXg8VdykwgTUcjpujpZ1C13Oi2YcHzR6HDmr7c8kVWB7b3vWKdJki9NKONHJMiAh+xmFXaiWUm59IGo2j7ee72A33EFwOnRuPRYEK8yc68/zN2B1ztbAThR4oRtzXBuxrX5Q5ns0/C4QfnUvB1sCSJbJeugBiCnKBJqQ0PmD804drIduRnEgHh56voMVJpcF2seiW0r+RYNyxLRQzzjmvf2oIQRxRGCkDntC42Uo3MREoQ+UcQ+qhokJa+6SGX3uM2m0ADlGgnILX8u6Z/EAd8hz1A2/4uAUonofL51IULptVQvvpVvvS/aQA4PlwoS6R3Nvkwq4sYg3rNu4psLzzPr3ekPhHSzQQIdJOZ6+7fJ3n7vg71me7M0vjtT1wl0NLaUFGYCQo1/NXUqURVWfu7hWMz63L4fVblixGgMHLXntDKHl+QQSnIl2TAHjbRVWMwzAcuR+ZyYx8VE4ForY8q5uEp4NqdLLkadiLvIzLhxhLKaJLZc0Yy2DFDE/U8YE2O1eMCJTULcUidC5AmyTf5N2qAOgARIBhN2Isuoa9JOVIWLKSMOaiL3Av6INWBqRcyslzuj1Z7a3uy+jQyrtvyGiFArEvWczpCIoA2AOE7xJCZO3BF+JHXOBaX1M9HbnAO37eUuaMLV0lyR2+Myp2KLhRQCxmSSQNzWTK0oKtREmjMtVhbLpt9vzc0LIViheQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TVkDoUqA9QnnUEzdOavYRQeY3ysRCiJ4pyl15HyQR2EjLxpU0xptwTeCd+ttq7p79eOHOQJo9V82uhNbXY1faMlDLh0mZ/Cl12J0gRaKNq8fNDAYmXTJ/tSX35+49unHp00Aph2G8or78OoU7s1jRqtiI1j2b94sCV6ZHSjETTzgzwCVqcENM/3ez/Rlwjs8KGEkV/M6wqVCOK1G97qh0Rj2l84Nx7htcp1UDkP+z9Zr0wNzTiUTHKeTW/6B4RTFLJDQ145YFxCb40v8Pxc6F8XyNntv6t31NEAJFiSJjJVBViGrQkaGyztO4YwoAbwoGNTS8O+cVnaqU+0bAI3ayuXqBovQ6C18FbYbT5KsRYOESpTR6jJ10R6KAuS5BzbmnlT9pBqX48hXm5uLV7i4CUp9oSJqNWC0MspTqQJRNP8Y6M5Kn0thG6T5iP2oRe5f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:53:54.3778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5fcdf-fe4c-4b38-a7b9-08de8f0b6b82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
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

UMQ SDMA queues can stall when only F32/MCU WPTR polling is enabled in the MQD RB control configuration.
Enable WPTR_POLL_ENABLE in sdma_v6_0 init so hardware can reliably observe WB write pointer updates
while keeping the existing doorbell path enabled.

This fixes UMQ SDMA submissions timing out on subsequent packets where wptr/rptr no longer advance.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96..622518483c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -863,6 +863,7 @@ static int sdma_v6_0_mqd_init(struct amdgpu_device *adev, void *mqd,
 		order_base_2(prop->queue_size / 4) << SDMA0_QUEUE0_RB_CNTL__RB_SIZE__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT |
 		4 << SDMA0_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT |
+		1 << SDMA0_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE__SHIFT |
 		1 << SDMA0_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT;
 
 	m->sdmax_rlcx_rb_base = lower_32_bits(prop->hqd_base_gpu_addr >> 8);
-- 
2.49.0

