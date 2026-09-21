Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF89C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 07:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22E310E307;
	Mon, 21 Sep 2026 07:53:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CR7XhPSI";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012040.outbound.protection.outlook.com
 [40.93.195.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D3310E307
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 07:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVuqvX//5n5Sjlq4fxpyMAmhoSsFaUs+k2wLxSZ6UeFCR39wDvHtkfE8dIci5I5JD8Vt9LWaDwofqwRj96pdlxu6AT/i1P5xbo2GOp3tPmqFg9Ti+WAQqRwuPXpwfXp+FZED3KPnRuLXCSdVCs3AEBVcdgaCMDXsNjKxUce7C+dWMzZk24Fmf+Rz9uPNmIWU/tgBGBAq5B4SSj+6bFIUXA1G0LloTh/o/i2981VHIjbXxGro7d8Z9tAWp0i3FA+CtQuQjiP6S98+tYWHazWj/YEst2aYOCFdyYzRbauYNcGrVJe5yUjWD/Jdaw5yuhKgWxMFtykjyRrBOUGqqbTn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYHCtnhHty1tO0OKMbqRr0Ezn26Yw8D9TIITOawRyHI=;
 b=AHwaQYNeZ4cfp56MO1iud/xjAyU5u41OYCINUPDc5nUi+kG8PoYfs8W9ninPDM2Ld+NTnc+wKSQrVig3qxDOXDUbH8Nh6T+pf5NIQLiSBw5B60THJs7gewrDtKn7CuG9U3zmKjmo0GKOGP/v0aJm32nRWorUAs73nmf8XjFrltVQ3Eo6DDWIRAc/BbOB0vMkZ+ZjN3IoWa3d4RYnrcR2uZlE8p6UQz9Spa4LBiXyK56aI0YF+Oq00h3NJ6Iz2K41Bdb2a0KUpBI6tbkyLeodvdOVJ7i/2cOgZKlrX9TyAiHPPPlXklAj1LG93Lu5sx/FcCtAPtchbT3qUaRVurE3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYHCtnhHty1tO0OKMbqRr0Ezn26Yw8D9TIITOawRyHI=;
 b=CR7XhPSIwJJpCcXxTVjpTmryLx9Wt069s7ulm4kSK5BnCHbxkdqCOhAy2nSP55YtD7JpozQKqZjkHvJS/jgOkjNVs2NCk2pjjwUN3nL6TQCwkLWeMCNsDnYmPxUoCxYx2lwMu0IStX7WMXpw/rc46cFs99DwfufShne11F28tfA=
Received: from SJ0PR13CA0195.namprd13.prod.outlook.com (2603:10b6:a03:2c3::20)
 by CH3PR12MB873938.namprd12.prod.outlook.com (2603:10b6:610:366::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:53:37 +0000
Received: from BY1PEPF00026956.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::74) by SJ0PR13CA0195.outlook.office365.com
 (2603:10b6:a03:2c3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Mon,
 21 Sep 2026 07:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026956.mail.protection.outlook.com (10.167.244.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 07:53:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 02:53:35 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 02:53:33 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Lijo.Lazar@amd.com>, <Prike.Liang@amd.com>, <mnovales@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 04/21] drm/amdgpu/gfx: export amdgpu_gfx_mqd_reset_restore
Date: Mon, 21 Sep 2026 15:51:11 +0800
Message-ID: <20260921075326.2409021-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026956:EE_|CH3PR12MB873938:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d82067-66a7-49c6-6be2-08df17b57153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|6133799003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: bG12tsDj7pwEnV1W5WI9CMELV7nuaxscDri8HZP4zKnqYgmv1apk8zrbsXvCvE3Q4Fv6Kl3rJo/VDSyW9j5nF1xKs6H5Mvc0zNl6l01fhKU1rG8wmO7PGCggq8ta/f5XMa8Z09K7gWmXv5TcNZccEKzkg8yJYbjhP3iONKwU/G7B1QlK1rNy8n36uLKqy8cD1/v6VI6qPSkfuFJrt/ySp+3JkKICH+LM9YXCR/knMTRiIBAJTvxMRfxHUO2FmcIl1xfCDsqcE6rmk9I3v/EuKV+2RqZsxFXMOWhxOypP80gCNHMklHiODkPKbXeL4VNltMpfoWNt6haCjOx2PNB/ChOsNwJxPRJ5Iwmc1KlKjRGhCyEe1XnJdmdiXCwtARv5+My5iERKN8gBrz9H/QvIurPdJ39HfdEg7n0sZWpdNrfvvwVDxFUUZ3Q2mV7ZT5RgIVUwr0i/HdZp3HKZLCaGxF4cVpHio88ctd+v2wKKHh5vg77vMNGoDdwLsZK3ZdY2uPnr4mXjwdwAQN6zXHTsZY75BRaoZ484m4R9j4zOjThKoNcXPn4H9MrIGVtRxNtfWr8S2gLO+bB3GTDIaw06/54lL7ph83RTwdKYiookkT+h607v6KV+K9CNAEyu1kbhtEoyxPAYJhgOwzgS/Bku+XtDT0GD47lTv/zFLdSpbWjWzklRdpNENoHfODy5zEkarutS0iPUdzGgc5XRYzqHgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jOJ5i1nvJT9SDmrV4Ro8jdmqcthns/uZZBx1sW6j838nfbP19J31aOPC0UUbF2zw5zsDEIaTprC4ndEA4HoqLpIF/U/p60iWGn+X4njCvr5d2LKCS2nBW2LgHqiazlJ00jTq5PJQ3XNRerP9Sf11CCWAF3z/jJ3xDRc1CQ+affwxc/ACW0eYH6oCSwp/DGSCfL2rc7yR4lBmp+vcb9CXoBsf/OkwFcdjfrIrBxiGUGYoN8p31barPQIW8YClKULnnGJHZTkLjdm62xnXVMpHyCGGzjuK8lrTO+bijLKZDvwlIBQPWRmIdCut5agpWcEuvMRM6UtScbXITNODV2+/wyBDzfkRSl4hDDbFnW9lak4gKu+dqsb8AHPN5DmNxVh62c1ps7+zz4CB7xb42s5qjePxi9hmzQiE14tc+KuXxH6ssZKIecWfAjlXvtbzhYqd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:53:36.6433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d82067-66a7-49c6-6be2-08df17b57153
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF00026956.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB873938
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

Expose amdgpu_gfx_mqd_reset_restore() so MES11/12 pipe reset can rebuild
collateral kernel rings.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7a132e6d7e42..b91bb5166ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -379,7 +379,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring)
+void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	int mqd_idx, mqd_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index a158b7f71b2f..c948fd2130a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -699,6 +699,7 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 			       unsigned int vmid,
 			       struct amdgpu_fence *timedout_fence,
 			       bool use_mmio);
+void amdgpu_gfx_mqd_reset_restore(struct amdgpu_ring *ring);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
-- 
2.49.0

