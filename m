Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6F5CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 14:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2D5C10F22A;
	Thu, 28 May 2026 14:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GyU+paJE";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010001.outbound.protection.outlook.com
 [52.101.193.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E5110F22A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 14:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkK3ZS9iv6fi/19IdCaDTB1O3x/ut4rIxFit5S9kWLL6yoO7QVE/PpTfieYSoGnGovb2KTcnOk9CQXrSXbfprXMNkNUQIlhaSnBNubmaBzDG5k8ipNsMbku001pT67d2ZWND+rYY6oDBIE6rHe+1QqUbMLPBc+ppOgQo17zgrfM8bfY8g2E2hGcg8ZmIR5CTm2uqncpwl/hUVZRfmdRHbaU9oJbbZ4KDfwxmdnnLkbTdMOW6/Gkn0FbnxRkkNg+lBwpJZ65pTczKU2slKY8pFGe6NX1nEaQhu5FwTqGmfgwRA9LSkGvKENJy6YggOYrKuhUH3fuY/Xg8qQ79ng8ggQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ1P1wnFWFMqAdWPq+tMS1wTuNdWB1PVVJas6tjFi3g=;
 b=Uk9iGsLIdPIg2/aKiPuP6sKF+sWz9uZwcP+/dHkkGZr0+iQHPwAaGUruVPC7dwc/1Oc0oY4QAkEBw7K8d861MrhFveAkOGPsoy7Jb3R56gZry4Ol+zUxTA1QJWb/WnYshNIdU4jkuz5+v9WuRwtG5nZgm4O0qkxozRzBQHMkjTIE7DTzjgVJ08YeeSrwk2LKz0qf5F2XPt/FwlFFHxCtU3ZvaxQqLS6MZsiPCiXbkHZ659yLifzbCG37sKEtGjdNFOrzqzSOnOisxS1HtowGK3kdLppRax/Wlq4hm0fqtQDir6LHizpIBlhlbuLLhKCoc4sORDvSx3oZJHAWU9U4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ1P1wnFWFMqAdWPq+tMS1wTuNdWB1PVVJas6tjFi3g=;
 b=GyU+paJEfcRt2hki6Sa8zvLdP/YWO8748H6TCV61y3hweJdIppBpOP5fTAYNc3q1i3ypQ8yC2QKiOGaE9Vj/bb9bIhoQ3R49GYOIvx/a5shMy0vAtWDN9wKncXC0n9EYsf+KfTp8wGhwIJHFiYnU4nijJ5MDrc+lpct7UZh2Tyc=
Received: from BN9PR03CA0091.namprd03.prod.outlook.com (2603:10b6:408:fd::6)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 14:05:52 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::62) by BN9PR03CA0091.outlook.office365.com
 (2603:10b6:408:fd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 14:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 14:05:52 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 09:05:51 -0500
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alysa.Liu@amd.com>, <harish.kasiviswanathan@amd.com>, William Palacek
 <William.Palacek@amd.com>
Subject: [PATCH] drm/amdkfd: use scnprintf/vscnprintf in kfd_smi_event_add
Date: Thu, 28 May 2026 10:05:03 -0400
Message-ID: <20260528140503.2170789-1-William.Palacek@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 54414893-bc9f-4224-e988-08debcc23a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: mMvjPVMO6lqOhI2thJl5xu4uJNWGG0M9v91wNcra9Jl/MihEzlQh7FTTCskFwQppdMgbDw27cSLKlU+sDd8w362TspRvEi1kCTuRyusb+svteBrChz4YfSRos+XQyacNSEOIY8EoLIT2fDxzFfHhGCf615NuUcFe2WaO/lqb1pGJHezw+e1CAoGqzgrucI1sUySDRiIU0ogjnA2/pGV2lEexh9t5IeDH5QobZBh6QjReR/5SVgRRadc5snChMO3gwkijLfoj54Gw075eFUYWI0unYnZnrq9efybYyEajBY24jtwr9nMPUfo46N2aulqL1p0QP580xarksDGIWq339E6m7i+YyXCtph69z9FBYwTkBYK672ceXo7wrgNxkJ1V8MSDZ2F70zXkom7rVLyn+85FIVwsgOp0yHTy+RsDApL/WxmiPTyRFodnDgo5izZqHj/YTr8WUhvpTMddjWrFZfXUzjaTEmXCMZn5OesquAVw7D+zFCo37nci0iESWW8a562XF97/n5IlPfNxcIbkvhBHRRC190zsdV2TlM21a78wMq3VE8ErmTnUp/pG9KG1IklSvkT2UgFwxRfCcLOWNlbay5isei7vSY/BZqZH6Rf52JP//zEWyWNfFz59P6CC6n8ayzvmyzsH01XjxPJnWT4dgvZ2dS3dKvL209mhkrRPGvh6zcre/dQDjGdkFZB+IVTponWh6OxtMEyEKAeB6vxPeA9zwaa6S/akr0srdxA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hNj8Tg9zPjSQEqoybpTkOvgpvKfEsE39oE3hiD+z5k0uvPNGu1J9Esw4EPZK/6xuzjlrFSeMaVQMGwG2g7TlY/uGhq5MGPlHbXuwiH/2jY7rM0wxvQMvDfdwR1u/prTvJFmaFxzBrjB/OcHWBrfLbt0ccO2pdldLVgDnCJiNBpU45wGNAY/JigTo3ulR992KDU+mIPCNy4q5kYl4OftLATHfPz+VrkoONA0mZQBOYwlzDs1p4bIF0RH58Zniv5hRwa2rn1vEXeWLYhN1FzMLlXF93DzZYm+RmFHXTNOOb/c7W21h6hszeTb6uTT2lXKPOztqra79Yf58eadHyVd7kdPT39DbgWbA2T3S7jzkbU1ySm3UKhxuLc7pfKiOsT71s+f72kvDgV3mq6iDZ7/n6czGkv7BYenj7UkOnZFw8dtSHRw4zLF8uq3GgEGkdXvX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:05:52.0359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54414893-bc9f-4224-e988-08debcc23a49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B
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

snprintf() and vsnprintf() return the number of bytes that would have
been written if the buffer were large enough, not the actual bytes
written. If truncation occurs, the accumulated length can exceed the
buffer size, causing kfifo_in() to read past the fifo_in[] stack buffer.

Switch to scnprintf() and vscnprintf() which return the actual number
of bytes written, excluding the null terminator. This prevents the
potential buffer over-read when calculating the offset for subsequent
writes.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d2bc169e84b0..a1fd0463a2bc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -206,10 +206,10 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
 	if (list_empty(&dev->smi_clients))
 		return;
 
-	len = snprintf(fifo_in, sizeof(fifo_in), "%x ", event);
+	len = scnprintf(fifo_in, sizeof(fifo_in), "%x ", event);
 
 	va_start(args, fmt);
-	len += vsnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
+	len += vscnprintf(fifo_in + len, sizeof(fifo_in) - len, fmt, args);
 	va_end(args);
 
 	add_event_to_kfifo(pid, dev, event, fifo_in, len);
-- 
2.34.1

