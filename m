Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2C6C9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEC310EC93;
	Tue, 29 Sep 2026 03:49:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3mQcMNQx";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011019.outbound.protection.outlook.com
 [40.93.194.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F6210EC93
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM7c4xvW6xnUFahi6N5aX6S+T0aOGGt198RQfJwEATMK3qTIGWosD5RWV0LaT9zfNU5dV7rLAvJGS38hoeOx7h97qwrZdHdjHl1YIu1qqdUxPaH9quLj1CdyAts0px63Ny+JsybPE0LzRNTUo/2OP0VJA1MVN4amxW/be3E3kg4M04sWP7NMdWcNRRsFpnViqeV3BdJRTAmC/aRbGxXO/GVYAcbwTCDP5atvORtu4wFpUAZ1a/zJY3ONSJu1znpJIIpR2AT0cni+umUdi2XnUrI1zWGYy91olK4y09M2ipeLcwtzLaWX/el8z63YHkpapy8m3XdFC286/EBVaeNMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEyX7/3C5vC99KnDrlST0p9xydHi+62oLNc+Egoj9Qc=;
 b=Iv2FJ18JxNtDamtAXW5auZibSJOrR+c4HWwspFf7PgGG4IPrtQcCCjUfMmLi2V4f0ANoDYkm4aAsxScuOv03LrXRbdLik9+kf2zUBsFnk3jOqEzBSkZw7PDYBXiKEf0z+O1gJermzvF7teHXAfKUeyWXizQXg8EAVljc3M/VOQP4Un0F3AE2cznaaYUGOssO0O0xJ3hP42g/v111fKpMPw1V8j/Io7yqI+J3nXKM6r9vXVr0Q1yh59DvpFSznd1aJK6hBXAGcTlecogPUHhUfIC5HwzWiNvddvuFCC0aMl+ydRLOR/GYlV+BkMg3PpblZ8fARv9W1kiDLZWBjnH2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEyX7/3C5vC99KnDrlST0p9xydHi+62oLNc+Egoj9Qc=;
 b=3mQcMNQxktgzdm7vrcB6nyJxTF1LZW7JgeccuzE7jk/gEFFALFUUDzm0RCJzStljEK/5EreGmKGOrLgpDzUfN4Xbk7VPqpO94Q/bw7RtqGCIAHUC3Kv2DIAWv53wiopzR7HsC74vnw6/rYodyu8XGl9iFt5qr4wU8ZgarZwbJ+s=
Received: from BN9PR03CA0074.namprd03.prod.outlook.com (2603:10b6:408:fc::19)
 by IA1PR12MB9467.namprd12.prod.outlook.com (2603:10b6:208:594::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 03:47:13 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::a3) by BN9PR03CA0074.outlook.office365.com
 (2603:10b6:408:fc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 29 Sep 2026 03:47:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:12 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:47:03 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 04/14] drm/amdgpu: skip VMHUB fault handling while the
 device is inaccessible
Date: Tue, 29 Sep 2026 11:46:40 +0800
Message-ID: <20260929034650.2393125-4-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929034650.2393125-1-Prike.Liang@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: 56cc5dd8-2a53-4181-436e-08df1ddc58cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7q8c+vWNAL4wmrupcjgqR4oinYdmMaHVxhS/9NSogqvgE6bGDaDmmlJ/lZK4F03Di4ryCulPamyPfJke1SH8XnyuBAOVq/1fb3X3CUVVGyY/ytlgv/68/Q/QNmu11TU2rH2OFMu3jLlE674P/5k4r/G4/XEIkTDpxQeRhvSHTlro054fMWr6LPPM7vGuBx//hd4RvxIqLUd5xGYNRtEoEIY5hnrjL9lIJyVsJZsU6avkAHkFwj4qJKG8pBub8wVec5/2jYGEX/6WN8j7wdyBK0eF9l77DubRnyHHsAraFMYvTubWVms71o3JthML1tlC7xCERQIctvzduJqd58vvgNo7mJTsp7Zt/F0jWv0x5GZDdpUaB3/78WjhsfkVXZq9HSXAlnXmxFhmtfmq+dxiKrjYZlyzzJvS7e4Ww4pHoH/dP5XZQPEzHbL+2fDHTP7Qfx7Qb74BI/KwAudIQoxsC3ykFpJO1prt9DYteqxAp5YnLHCCWAQULyTNZuUlbyTzj6mLlK60vxcQFN5DtRun7GfK2wH5Pa2Zhf0bpLNSu7IqNDhbv3rtQOGOnGUgWArn9KpcAQMVoT2detWdRAJQFP46fe6ZAweJaMP2MhSMAXtKCjoHl6/x7GQgX/PxZHVCnLlF3UFpIs+RTrFWIfirofaXX1bvE9ycEki0Bp2Y9Ml9K9d3hZnZyThuarnafQYZK2Hw7gM633ndetJM1GIX6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p+6zLemPHYl9kH9va7SCeof6gI7EkmXSbWJ7H2Hx0pG1m/oT44nmlCQz8RZrDTfjgbAKrJKnlaDQuXI5y7ztkCkEc7KOTKybt7mzXjPo7nCYZYEdDdVhtNht/qm3ottPWkVFyxF4CvCFdub//WpvRz1+GgFh9CvSEgzsXiXYnAL0T58/h3daLNWUPy7noJrXERshgWXmbzFn92jlpiHLcMMi7zpC8878TMkeYAZ4D41+PTemUmBR++d5PP/KIKQ+bm4XfA48efE2Kp/yRVLOVJBW5GInQ/Qaj4hqeufAh2q789T5+r6SITM7EofQDyTbzCEhI42dJoTlDAwZ6K74CQAZutXDgCNYQbAZfl9Al2YgFR2tG+Cldcz2+yEmy813F0TwrOskUccu0lW2p7zVG5cEOOzBysNTGFT1VOh6iJV0LZr8Y5U+JRE6wKRIeM9P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:12.9361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cc5dd8-2a53-4181-436e-08df1ddc58cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9467
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

Skip GFX11 retry-fault processing and VMHUB status MMIO when reset is
in progress or hardware access has been disabled. Retain a rate-limited
diagnostic containing the fault address and client.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 3cdc7893587a..07b7ad753fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -115,6 +115,13 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	addr = (u64)entry->src_data[0] << 12;
 	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
 
+	if (amdgpu_in_reset(adev) || adev->no_hw_access) {
+		dev_err_ratelimited(adev->dev,
+				    "[inaccessible device] page fault address 0x%016llx from client %d\n",
+				    addr, entry->client_id);
+		return 0;
+	}
+
 	if (retry_fault) {
 		cam_index = entry->src_data[2] & 0x3ff;
 
-- 
2.34.1

