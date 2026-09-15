Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAE2C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 12:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D59D10E5FD;
	Tue, 15 Sep 2026 12:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NKn8DO45";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1DD210F4B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYcD1ntEwSAFsuaHYJ8SPtbTUbBw/vWQXNL+1BVy7L3Qs3RALuNpcpORgp7/rumsLoKK67eCqCc86OgjTxR9QvcMBqGw4T48f+VyjJkaxDHUnxZm7+zAOIuMA9GXjVDGgpr7T6f87KMjlkfnhPtMYNZU+nWbEQgUvw5ohlMSIAnqwcbxDF1gyzNznSf/2MG5nBu944PMK2hrBbG8iYoABoubB8vYOy3U2v1j+4b416tIxPEWr7n1uU0gnGLh+O003h1WkyIwt156bvlKLXBH/nGU2FZW8Cr9aEWFaM7aJ2oakbKvv7uCfaJO1TJfJ/3ZsGg6onCpOLgb53I/T3n8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVXZX9ybakQM81JVT7HWEqu7uQF4bCkISIcySJqM690=;
 b=t60WCwSAJuNuuAuoJLOCVu9fPamkRBAxp4TpV5SdrDjSUCVfTc4THAIpTRKEbqWMVFzrEL1d6+sSQeohxzumsV7Mgc6+5VlRVTJ7RjMlbVd5h1Q+99OuJ1p5BUDeLUk6XfmkxNmhb6VMjp+mMTip1UbN9dWDYdlsocqDBe78aWf/HW7pFQTuPY/jviJauRyOP2juP2yDJVYvJ6dahfj4Kp812HOISrjL7hMTbMMedESRc4LX7oBBH6arkuAV4FSNhXd4Ce/YpjkbPRl5UK0BfssAesFS+8E25n42taxUZcp/3OpN0+wVDbJ2MOYOqRkAo927ZuvsdlnyCqR4CNqCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVXZX9ybakQM81JVT7HWEqu7uQF4bCkISIcySJqM690=;
 b=NKn8DO45PSAe2qDCnuEeDcbuZwnbIEI8SPKfU0dcsUF6zk+do3xhNM26CXfOL3QwcmrY7Ol83wwWrY8T5ldHaBbQpw02n3npe64Z2XDNSWQYOk1D9ItbjfDVVHL1bwDr4TFYTc/VOXfJTIOwsRXjFew63bXboVJO6GTk9nJ8fiY=
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 12:41:21 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::d) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 12:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 12:41:19 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 07:41:18 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>, "Horatio
 Zhang" <hongkun.zhang@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/gfx_v12_1: Remove redundant CP resume programming
Date: Tue, 15 Sep 2026 20:41:05 +0800
Message-ID: <20260915124105.14623-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 7595453d-660e-486b-0d65-08df1326a467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7X1f/njxPyv172E88lKgHkio0VVVocFnWxb7h6ElrxgjbbA5J+ltWTICltsBLqGNpno4GhKjGvMUUZSjTeOAlt/6I8hB8K8O3EsZgYcP44yslJOorX5v2UOdLRCZRIT/pqBwrg8s8LGuQtEUQ7kHuU7EiSErYRL6ksTyFg3j5anTu2SYrxEq3OeJU3w+l6e/ngV2ocFNcKkCgz5Yh/gBlVs4dg/OdwVQ/e5Yiii1iPgzxJCHQGZpX2IOvlQtJYHfiYL6jIRXt52o8VpK4Hp1E1+LjkG3dExWXopja79TM3ZQL57OdrkohARVWmubMvEUuYvNlDFG0PpdpFkpDtdJnYgXzV/wAdkvGV4ln4WX0w61iCZmCBTNLgZCkBcS/X3g3h4chxJVazw2KO5XX/sdUbhQMemm8Wh4FKYfgS+s5cV+hiwN0rmHLMmDYBtBGF03t5WTj6gwEibLBv5zH15anCeqgB7ogWWDiaSjRVcOXwDTXPndHHwdXq+T7nmgHZyakYjSMJjJzI4eAFbRi1sReGfPtE/swQM6pusBKk7MwxJXxjrxLTHCKnPvtusq8uDKG0ZZxHnvTijZwmrnvfNEwTJPGUyEmkGDXayAaPMy0MbE9ocLCwVwYcGAXAHXjkED0K6YltpMYEjmSznfgN7xb+Wl/JGg931sdka+CzAeVWZGaq9p4Zpa5au2eUNKXqII8HjRC8rLUsX6aYYuOY5rMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j6sypKydyatxfkB1+makKsC3T6KaAs5DKN4/5cSzyDkhfFVJiLF65qulclrUgpD16xtwfCtZgsKVF7Tfesvt2djPJPdQ1/RU6vKyEdlxfvRpSCtybqtTKl5nzX3Omc5IepOZY1biYLvgTU9oes9usx6Z6WWaDT/l1DF9LCgKkq+dcPvWkXeliWqdgj2+/oS5mo2XZPzuY8OQO/HX/XEf4GJZ6HhTcPuEqzf3xh8QR94W4d1/9GJgigbW3TC0R3HuoDL95WOEt0EJ2fR3G691eVqEHT3ftD0ieKceC3Jps2WFkiA2YugQ+yGcoX82R0yH8/Pz1gQqZ7etIZVafDZn4HSaCQaeGWVXbUTUbmWdnS7OE8eWvU7x2SWElt1HLnVJvIVCSBcjGfJsrAkY6qisdrmKLSnrIgPRgUMOGrha8P//RzFaZqtEVIzpwcrjiYVZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:41:19.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7595453d-660e-486b-0d65-08df1326a467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

This programming is unnecessary and can be removed.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index d7effa43c0fa..a2f73a71f11f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2377,9 +2377,6 @@ static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = NULL;
 	int r = 0, i;
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
-
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 
-- 
2.17.1

