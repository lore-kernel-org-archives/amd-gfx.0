Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D634B606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dUhm7Ed9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4676C10E12C;
	Mon, 23 Nov 2026 07:23:19 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D813A10E2E5
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 07:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuD+ggH4KUy42IOLQ25QHK+MjpFef0qvHiulxrHjZhL46zlGphROHNF/eJfx5MRh4OGa/4w1UVW2H/xmBXFqTPI5l4R0jeUUyg0d/NwmiYQezMZklNpnJqDVAmd/4sJOBM2250w/faFIBhmxpBq+DDJOk1eLlTXLG98IS8u5A+YwFW320rLxxsGujgW1xAgk9HAHzdVwz2XxZzn0uFX03+MiweCLzdThHRZeWTp4PDS+/ebU+UA/FDtWSBTfyQcJ7l7EypgjlJeMxXP+A2DVgcij1hUyzPXkPCfCWx4Q9QUsM23djxpMw7TaYaUhyURU1IAOEMWB9Z/T4WwzZ/Axxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3pIo1QbIQo77O/IQhiDbOgLrwNHZREZKdSO/6EjW58=;
 b=TPT2saEgFrjIz3stjA/RX6SiUa5ZP63UdlTU1Unm7Ixu/M9P/loTVqZfVg5WsdAIAarKdez4abZoxocudQmtIReS9TFu7vtSCBZ37IpSNcgUl6xtYrUoyygfBxvKCE9ukphBiyapsgWmjVLMgWwx8QXmoq9oX/ZSrtrTszAfe/PQvowORDVSdG9M87+9t+i1QYp/gMKaDysdKcWT0+2OVRsPWR4XHOfT/pCiKTvD6tCr0PTw8uDYKuhaZYMiwqOGc7ny80HMPJJkbF5uSiG6MMGikpN4TQqiY+3ANnSf7ZR5vtz6UTKUI54TatxcdM3LQikuJSJVsvZ7LE/sWd7sEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3pIo1QbIQo77O/IQhiDbOgLrwNHZREZKdSO/6EjW58=;
 b=dUhm7Ed9Q0pqtEk797fL1JF2EysSzLnnl96kqxc/IDdPyp5jNu348GXDU/Xv2wsNhnjS2s/CevUR3ghQtYXAw/uBFuaI3lJAxyvK97gNCI9ECh9L6ScoSsYYUiScdheZRbihYuFiLjWq8GgP8CaXH2aCOXvmDQx4ccslzVqDn4s=
Received: from SJ0PR13CA0212.namprd13.prod.outlook.com (2603:10b6:a03:2c1::7)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 23 Nov
 2026 07:23:09 +0000
Received: from SJ1PEPF000037A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::4f) by SJ0PR13CA0212.outlook.office365.com
 (2603:10b6:a03:2c1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 07:23:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A8.mail.protection.outlook.com (10.167.244.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 07:23:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 01:23:07 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Yifan1.Zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix deadlock between profiler_lock and
 dqm->lock
Date: Mon, 23 Nov 2026 15:22:47 +0800
Message-ID: <20261123072247.3612981-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123072247.3612981-1-perry.yuan@amd.com>
References: <20261123072247.3612981-1-perry.yuan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A8:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1cb3f8-aa4c-4402-aaca-08df4932a032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|18002099003|22082099003|261009223027099003|261026140227099003|261022105027099003|56012099006|10067099003|261021123027099003|261021121427099003|261028144727099003|11063799006|261102123227099003;
X-Microsoft-Antispam-Message-Info: cUReF7ij8Hs0N+Y9SL+KAdl8ikrRQRmeSudZ2XjAUlHsq1J37U+mxMJdLS9JobIWXSqUjCDJ9rlLf7LwbnUNn6YG/2w5IcDUSBoI03v9nUX2qsDtt8uV/+/V4V0bb+FvC3tdlPuX4ONbzrzsDDH/qxkBFeWTdOKzaHRMWuf8bVq09JWuGpHl2JYkNpcLJN9PKqYGmZUbzSSWqeTVQKjMMdbpGETqy9thDGzxVVBloFRAmgzpb27VxuLsbiJli86bHLRl4mFhnUeY3yhHLNiaqECDC3bw/u+l1QXADF6Kzp9NWzKO2JJ/yhO0y4RWM539QNLS7p5k8QH8p07Re905EnMqZGHW3EXEUakyBZILMp2sjFBqOPt0SGiUP1X2HQ57nR8YPyhM8dnUKyCaUWw0UL7e2pO1z7yqMazrltyi6NdwQW050kwV782f9ovfaBFeT7ZB3Ttdk5x4Ll6p021CnjYr/us2vo4oWNdJrqwkx79yoXD3JtP5kVu+et3R0GRz0t1BrIN0HsbGMVLUoE/KC0J3pgn7qiG62gvy3OtRIPpyT0Vi5tWkZXArEOfprrpwjtFuN/IStiBDBKsIuoXqzr6U6bXS30Y5xw3/b8bz5lh3tAnLmoF8NGoZiP8d2Ezuws1Og0RmtkRR3I4kbK1ETR0e36YybjbUOzqjGBSW30oHv/q8hIyzuLYqgxlFNN8g9XgxYjS3yOyaWYgnB88BMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(261009223027099003)(261026140227099003)(261022105027099003)(56012099006)(10067099003)(261021123027099003)(261021121427099003)(261028144727099003)(11063799006)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MsnAmXMQL0u9UmihbhlpacBlwTTw84TYknhq0HYmlG3RFqn0hTaE5dzCkckjGAFN4TNKLzouF5vW+i6IR+4NVPG6fX9VgoXUHxJ1bdaxGCA6/6CjPkjIxQzdO5Ffr/A/zaq9gTXMYRgzqdzJuLzGPyxkbZP8Ut8tCz95uI05ytcA43egDrtu5D8SvL9AbMA5uq9Gnbyc/LGb+zbVejtYrruY5UXc4r4RckD7apmr4sXZf4nIOdJVIHN4JmJJ9KawP5w3l1FmXARxfyxrFgv34Cqxd0a5Y7AaDwC9wIi+0xE5gI4u5KieK5cJKU+ZY7EQtP5INsWhiDfvvGa/DtX3mRXP8TAy4hyw7nBhGL4Fsyo5Hdu/06d7gluBLd5IoI2N3lGX2c4slZVstfbjVIOCTU/INHhHVnn3tjbmfhiXl0NCuQ+wL789fbiKDRdhi5fu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:23:09.3741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1cb3f8-aa4c-4402-aaca-08df4932a032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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

There is an AB-BA lock inversion between dqm->lock and kfd->profiler_lock
when a profiler process exits without explicitly unlocking the device while
another process concurrently creates a queue on the same GPU:

Keep kfd->profiler_lock as a leaf lock (consistent with kfd_profiler_pmc()
and profile_lock_device()): clear kfd->profiler_process under
profiler_lock, release profiler_lock, and then call set_perfcount(dqm, 0)
outside the lock.

Fixes: a789761de305 ("amd/amdkfd: Add kfd_ioctl_profiler to contain profiler kernel driver changes")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index b6981185c7ff..cb1ceae7606b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1230,12 +1230,17 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
 
 static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
 {
+	bool release = false;
+
 	mutex_lock(&pdd->dev->kfd->profiler_lock);
 	if (pdd->dev->kfd->profiler_process == p) {
-		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 		pdd->dev->kfd->profiler_process = NULL;
+		release = true;
 	}
 	mutex_unlock(&pdd->dev->kfd->profiler_lock);
+
+	if (release)
+		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
 }
 
 static void kfd_process_destroy_pdds(struct kfd_process *p)
-- 
2.34.1

