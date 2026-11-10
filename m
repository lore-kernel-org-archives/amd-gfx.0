Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4B606E456
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1Q/0A2wM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42ECF10F6B2;
	Tue, 10 Nov 2026 13:05:19 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012025.outbound.protection.outlook.com
 [40.93.195.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8AE610F6B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clpOAl0Tl7nivSdMNhefTJq4pEXEXF9X7ZVdkHSpYyOlYT4Nj24PO9K9Bu8L0Tt7JyCv+jVBdxeulcrfK5FntPFl02QttbI5qM4b4yJ7hDsbfFYil0CH1Ynje8JBB3b4jVcRCeSf+REI2nMvsdX9x9hdgtIzvweq/4vzVVgprc1LOoRLMlgRdTbxlUXkM5CNIomFUUrks4f7kwT8ApuXc8gfCDlkp4nmfImB6FC+zOkLcvVekzzKLuYdSuqXK1x25VTN7caq7ORAUcv5AdrVNMObjW8T5OnJx5Ry1vXVx5T6DGJblEXf/+EVf0lm6air6Nowx07GXv4SrbTzfg83tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4787XtnyavA5r3jtyhuetj6NMWTTgMkmDnhrRZXPIA=;
 b=gnUUjhMsgYy4NIRsZwWFHT31NwFt4MSrItZlFbF4B2Qst0cpPW4uWP4thfgYx4loxMrFW+mdGr63SL/exg5T1LxxNApcGtHv2Ew1p6T7P33wbKlVAdDiqndYZZDZJb2myQTOYfFyl6zDLhedJwbYW6lkjO/SLm6IkWEA/W3FAI5skS+OdlMnTBJ9NfbttTuvmUr0t4rC2xOmCbQU9jeepR+S3R5F85GCD4t+haUyTSQ6V9Dew3xlj283oox52uYv8W2X/jZ2GVI0jnawc69Fozv7hHfQYS5GtUsMrZ1wxjVzpbDtsK1Q6XXRAfRPa6ZB608lLLHsQ8aVS8M7AWGYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4787XtnyavA5r3jtyhuetj6NMWTTgMkmDnhrRZXPIA=;
 b=1Q/0A2wMcKd6p1MXXX2zt7eviGDP72ins5T2IiDBxSllnxNfFjl4BIDMQ5JzQTyWKASeYWlaE+nB6xtTZn1kO/Yg7RSGoiG3Q7GqeDPBvnvfxYSq0H3e0yOJeFX37uoXbPfVRfVjKnzT1vHkWBEbsFOkXAYZEgAMgxnlieTvNxY=
Received: from DM6PR02CA0166.namprd02.prod.outlook.com (2603:10b6:5:332::33)
 by PH7PR12MB6561.namprd12.prod.outlook.com (2603:10b6:510:213::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:05:05 +0000
Received: from CY6PEPF0000004A.namprd03.prod.outlook.com
 (2603:10b6:5:332:cafe::68) by DM6PR02CA0166.outlook.office365.com
 (2603:10b6:5:332::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 13:05:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004A.mail.protection.outlook.com (10.167.247.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 13:05:04 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 07:05:02 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Michael.Chen@amd.com>, <Shaoyun.Liu@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 5/6] drm/amdgpu/mes: keep the RS64 context slot bitmaps across
 MES re-init
Date: Tue, 10 Nov 2026 21:04:39 +0800
Message-ID: <20261110130440.474374-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110130440.474374-1-Prike.Liang@amd.com>
References: <20261110130440.474374-1-Prike.Liang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004A:EE_|PH7PR12MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ed8b19-6941-41b1-3791-08df3f2b3cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261102123227099003|261021121427099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ugTdFVqSiLiEgCwFzWm8rSIlT/t9b0X96n2jS/QnxhIYu4+25w6C21px1zADegArdqn4EfyPv0oSNDgZycE6CLDdexq8KsWGlAPersMWqEzNTjni+UTPCDyrT/IwOOYtXy40D6lRwMWfXG2yUKPn923ghn1UOyaqnq6/wokrgRBy482UeTtG1xcwn0W4yQcTYCBYua+ntY7WJhS+AiqTJH0Wh4ey25ZSLxYH8i6sfFFXQV9d1lXBkKx6bXUOoQdhgW5sF7m8OU1TdpaAOlSyAKOzZmA0WQ4iDluUGSFe29CVuNSUlGJiZeuToSDN0T6foDsEG1Uo2f6bLSAOV772pHQhYoXl5GRywb6dRmaQbgaHOWEJPb/feHVQxcaGtv+/SWIz3gYGLp8E5rs4bqBk/lQmAql7MgUJkJpAjIsTBxjvLSQ8f+KIAifa+HJ9U/fr81Ei7A3EudVN5yKQWfSKb5vGFJBMC/XrQMNyRr5Rlb2RCZMlzZe4v/MCUQzu3JLPuW19JTIN7uBbrxBsb296vTI0ncUY0zuNAZSLHM5MQenQG7/93RHEM8RIE/WYe2egao5DqPcgCF9W9WBidEGQlfDVr3oh0yWOINF39s6VFdlN+LSOAsRE85rCgbnzC5+qIAp01K1GcL571rAJ6UyJR2Pm5fmx/1unqkHsORgSDTLOIGDBbv8D0CRT4ccNQQ+HooCWGsT/arKYyY5P784m0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uyoy9HumD18Xh1ki4Oy847016doYowl+zWxpl2K3afF+kQCi8GfF+mo2SeRemkzDCs7WuLLkRjwWcUkigPcwoHwFpLcoZh38x5lUo8eVaoBumr3+iH4XSseUI81eKGiIHe6hEWnafg9iH5YrxB8j8rbkXRbmy6QG4uZT8qjOx901ira78QORi9jdP2uemYOQ4ib1DIZZkYQsMfVxFxaUeT45gJHT+57BlmumX8mUG/td9dUCjofMOHMOWPurv3O9dI/P2t+rUTphJh2niXN4vnuwVFmYayx9b4pJkK8m3Ygxc4Rm6EBpm/sr2+kp961lU/Pr5YmMZdRLNHaSxw+jYTMykcc3MJlX5TnVNW67EBeFOP1p2lfcfMcKRoqXiox6QVkx3htuiLqZtWXR5dn9NqZkL3f4smDaxkJw5eoIGxMqzy6MqZqqYv7e600PYFlP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:05:04.8249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ed8b19-6941-41b1-3791-08df3f2b3cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6561
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

mes_v11_0_hw_init() queries the MES context array sizes on every
hardware init, including after a GPU reset or a resume, and
amdgpu_mes_rs64mem_setup_bitmaps() then allocates new, empty process
and gang context slot bitmaps. The old bitmaps leak, and with them the
record of which slots live processes and queues still hold, so the next
allocation can hand out a slot that is in use, and two processes or
queues end up sharing a MES context.

Keep the existing bitmaps when MES is re-initialized. The array sizes
come from the firmware and don't change.

Fixes: 4ae2e536c643 ("drm/amdgpu/mes11: get MES process/gang contex size")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 99b803f95c56..b917e6d0cff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1076,6 +1076,10 @@ int amdgpu_mes_rs64mem_setup_bitmaps(struct amdgpu_mes *mes)
 	if (!mes->use_rs64mem || !mes->ctx_array_size_cpu_ptr)
 		return 0;
 
+	/* Keep the slots live processes and queues hold across MES re-init. */
+	if (mes->proc_ctx_bitmap && mes->gang_ctx_bitmap)
+		return 0;
+
 	/*
 	 * MES FW wrote the sizes to the GPU buffer:
 	 *   ctx_array_size_cpu_ptr[0] = proc_ctx_array_size (N)
-- 
2.34.1

