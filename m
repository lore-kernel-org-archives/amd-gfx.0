Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8905CCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320E210E993;
	Tue, 16 Jun 2026 09:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Zc5JLtD";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD51A10E7A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgUQU16H8lbzMjxJlOikywRqx7vrKAr0nGbJIz8H6PLF7Gx70tfNUvwfgkeWJdm2iXYwIb6X+HsGJa12shTWruAZKtR0bodPklUL1Qn+ErWmvj+B2ZJIDooNYo+iPZR7ug7Yv5qGhr/yv8klh31Dkh/5U6EmcFgrATTJ77mvlyuPtiCdNbzzIo67BXeMaUNkPzoBBcwBd9lYfJThzJS0qnokGsfJ8KIxeUfwnKY6/tJIWCgcqB+ge2ME4xym3MZbokrL0ns53yYa8ChQF60ExGbhcCwBmIlsPuORKk9efN/BY2cTSC/COrqvZ8WEqN3eelDNZPkZ/xFvRNpiSJclsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnN1Ur4ztYkJxo8zVXGqWVzq6g1OsOmnx2rOoXj3fm0=;
 b=WZrtqR/38U7/g0nJUotlkmq9x1ldq8hYww58eexQca2DPaTF6o5mvt7nsNRE4YP012i4vur0g8kLW2x4AnovXYyN/BnCMbdE2SRiPbZwzjbPUuYPzzar+Bg+1a6kVk+xevIT3uwo0LpS1YHx2agkeURNVvQ8eaEI1F2SJmqkGS4gtPQxRvbADHuKIJCCBZWDQs0WCNxBYdP2EMRaHnqUsKkm957IOJXYoaDKnUT/iHNcduyXrYHtsB/DLPNXCzMuOjI+X+oPl36xIa5IEx/7exSxP/ftxF6JKFjPlt/B5DBo7QNRZ9hsGCAE+dkaeZ8L8148Sw4GZHt3HljnPb2JNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RnN1Ur4ztYkJxo8zVXGqWVzq6g1OsOmnx2rOoXj3fm0=;
 b=4Zc5JLtDbXR3JLiSEmL04ZwHV4gmjFkdxptpC/CSMMZ88EnpFO0UGG+PuxZDs8Y7q2kPY4HOXOwijBbawrqNAPP3WjIe8pVJseU+WUxW8I3ZFhjuFFH4v1QX2AcPjsbe8dpnexSuWs3UJiSmp9LGZUWovJfceqTx87OCb/mH6Do=
Received: from CH0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:610:e4::25)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:35:51 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::21) by CH0PR03CA0200.outlook.office365.com
 (2603:10b6:610:e4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:35:50 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 16 Jun 2026 04:35:49 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH] drm/amdgpu: add buf length check
Date: Tue, 16 Jun 2026 17:35:08 +0800
Message-ID: <20260616093508.37315-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 553e7fef-3c8c-47c5-063a-08decb8aa771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|56012099006|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: jVunJ8Q++vnc3C/CekqwCsXNVw6h5ZVR8JTdgXw/WNAU+mzzYKaHQC8IHnm7bSbFkjOS2ZJxQHhXOnnx+H4EcyluWrG7iYFIpFzN0BS283pZj8jK0ryQ/znn2LIvAWwwCh5BDLkPQxc6ilhJ4Y0n/RqqGYCAyYmiztXuDcpSYoab8JiHvnGFdeg8U7Y+eL3xF1KxKZi3JfLC+64XbRKud/BDqKaiE6n5zmqdG4M8E4TggAYTNowBvcarTd85fJza72ytm9almLZC85YrahMSmVKEHHAzijQCBuoiK/uv03SnTK0aDJsHSozlooDY4blfgl1YsQnB5tQjjMllpqwFgaoqxEwe9NhCQXP4fT7vWDYrj3sjOtG5ZPJ+nTQwbERN+gNdGZGgcWHr+fcEimdphsjTCpxTf7SWJiOaIWyuvSnGuBfXVs+eVbE1zwok2RlPpX/kAAf6xJxhg7Z+Bpc8k/GIT51ur6Ln1mO4JJxSg/6RJg7McYtyiYWHAhOeE6p8qI67xJt+LV4E4vYhkKEb0cIvoKbYIGjqosAffvSl8urjXeEU/uTLIwvS39LaA+wxR+KJsN53VdjEUl1o0jb+JADRNKHYCkRKaiZjaECG/ZBQVQL2qXdO7IpPmd2gfoj81DWjyBCkx5K9OPNF0on2qcRMbJMhFpd2XqwBOcsUIZ/mjvQ2FODIKn1P4lGLiDopKm9oi9/YaCWmWDY9xIPR5c65miZxulTvTENVcuVjUnQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(5023799004)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zGxpzE4xDXFdL5Szt3GecBmlj2iPjo2bHJ4VizXFyByHHayJSDtPgDXzwdjnEYcQInOXhguWgqpunJ0T6YZKK/i+rjgFOsCUlXey/vrH8gALohTNFvP1sLrK4B4ANAOAUR6/yjvL/+w31iP39BrM5F4kGh/e2Bt88vNDaM39IpKbN5w/FWk9+TKxfvqq2z2X/LLKSG8UcziBW0ufyKb4hhuMsMPwlPtOoW3NVvWlK1BP4pryqjQ1QcopVql0yS84ziWDkZ7j8a+O4BQ/5int8/e7EjrlEI2ioiwUGN30S+PORJqjRYr4q8DwbZQU2DBhmNiTt4JzXcefCR2qnbzhMlIMlM6k2foylluHtOTSBnJmtqx4boIPvBmT5QdFPcmu/E8uhC0IYdKJNmYYtpWSGNGEL5I+RLz7F0ju1zx/CCAM9iq1UR5H+wtywgyGtB8T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:35:50.8006 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e7fef-3c8c-47c5-063a-08decb8aa771
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

add buf length check before using it to access data

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 0d3c18f04ac3..8ae72c862d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -166,7 +166,8 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 	if (ret)
 		return -EFAULT;
 
-	if (ta_bin_len > PSP_1_MEG)
+	if (ta_bin_len < sizeof(struct common_firmware_header) ||
+	    ta_bin_len > PSP_1_MEG)
 		return -EINVAL;
 
 	copy_pos += sizeof(uint32_t);
@@ -321,6 +322,8 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 	ret = copy_from_user((void *)&shared_buf_len, &buf[copy_pos], sizeof(uint32_t));
 	if (ret)
 		return -EFAULT;
+	if (!shared_buf_len || shared_buf_len > PSP_1_MEG)
+		return -EINVAL;
 	copy_pos += sizeof(uint32_t);
 
 	shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
-- 
2.34.1

