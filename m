Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27045D3B7E5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 02:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F0A112706;
	Mon, 29 Dec 2025 02:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uyOQ4vmt";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6B510FA99
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 02:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIBs53qv7hK37WmQ/f5hctlrOj/OomZgyygs0tcUuRy8SGGpqDbzzCLjoOakXCE+pfrYF8PG0H/Os8FJEMNbodxe6PzdhihGQGILuo+pNCxqrSW+h2IklZe5Lr82xhsa+goA8iy5Z7QqF9/v2lon54dUl6wFWTVoQ4N2Nrw9A2+CORm8C8LsGOvS7mq0pNHuKoBGTKXJeunUhECBZ4c5PtPN3tMSt/ENWL+OmXjqzyvCmWedhcGVawWNWHIzr8pUi0fG3rFuhhV4b4t98w73Nu3QmByrXOzDgbsirDTlBJ6RuLD374alY5S7hKEpFVcLREwIvS1bn5DunDfL2uH+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaaESJnc9Rl6RujmC9xcPzdbeb6oM0JHcislEPo4UfY=;
 b=GFGLx+vDciLVGO5rJ/A5sNSjwu8vH0xAFIA+HzXHTdKnPumHyzdo+ccij59s9LuPoLmv1mFtk9FHOyc+fuwbg3uyjXaojSM78eG2k/liMoV664eJDzBycILqP8rUh6aY8Gs3ei71voKhEf3VJpXuClfASZgZubtPjYAOnJWIDO8yH2Wf8GNKoawuWEh5usyJay74x6CSEPQqSZ8rsiiaM09sl1MX5Sz5VfU5+k+KsTjxere7/VreevmAcA4CL7mbiOjdnu0u9534O7f1dGMYRuuApMRPWTw8hzRJoRy9gcco0VTl7pdf303nLg1R1oX5Lga27T5VotpGAA00DtlxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaaESJnc9Rl6RujmC9xcPzdbeb6oM0JHcislEPo4UfY=;
 b=uyOQ4vmt1r4KjjKyavylzmQeI9xgkcccGMuHlJztS7ppg4qxC4lFgCk8yN/qNXLY6l7RSyzxGbkxnjzw3StGueO31wpQi2wI45yNeokAmy5DLsUKG5mXGDl8lCvhHqPkTlPE47rHFrUr7SwaUC8z9iUxzfTY7f/Ff4xPa8YBIdg=
Received: from BL0PR02CA0030.namprd02.prod.outlook.com (2603:10b6:207:3c::43)
 by DS0PR12MB8527.namprd12.prod.outlook.com (2603:10b6:8:161::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 02:29:21 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::38) by BL0PR02CA0030.outlook.office365.com
 (2603:10b6:207:3c::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 02:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 02:29:20 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 28 Dec
 2025 20:29:19 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Jean Philippe EIMER <phil@jpmr.org>
Subject: [PATCH] drm/amdgpu: Skip TLB flush for devices predating the SI series
Date: Mon, 29 Dec 2025 10:29:09 +0800
Message-ID: <20251229022909.777645-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS0PR12MB8527:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c9309f-0788-4771-cbfe-08de468212d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqaOzaq0Fbn94Lu9dpDLYqub0isZk8vdyXmSTGKwZSkhbq2C3DjLrMGOF6KD?=
 =?us-ascii?Q?xdj5UcVmWLzYJy5mH6lE+IHuEWBx7JXTWD53jLxgB6tRhGklPXs4W0XCy6BM?=
 =?us-ascii?Q?+sQBWhJLJG1bCtahA8Sv4xT7RTzM6uuIh6t7glvWONPsiIxnS/2r+hkDXDkX?=
 =?us-ascii?Q?Syf+mYqKmqJaXAlA8XnzuANBlbhS9oCp/YZqnvTUqArKQ6zpctCUmZxj4CUB?=
 =?us-ascii?Q?2+md023n/+ByuT+uU+HKB069XL59b15n5uZY+1cL66oKDjvDaPdQm3JbhxyB?=
 =?us-ascii?Q?SwrdqS1j+LLkaNuhs7UdxFPbe+9YTOwos122kPyO0k4Ut9zV5PA7DTDtE/2Z?=
 =?us-ascii?Q?os2ZvIpYe2eOFmwcS9TOjLsAQ/XiDHmF3Z/NDAyki+5Deo0YKX6mXHandQRb?=
 =?us-ascii?Q?g3J2Ks9NVZouYfSh9x4PQlXKYYRPCANnpjtfRzpBr9q/nag3+utxdswmthIs?=
 =?us-ascii?Q?L0yK8B7sNRUGM/BdAW898d2umATNNPNZnvsYXqREVqx3M0ZOlW9CQztgKe0W?=
 =?us-ascii?Q?mGa4nZc1uakYwEnuIHJTXjoll2yIpqKqlONgjmNgZav8Ed7xePt6CQ7UtdNB?=
 =?us-ascii?Q?mhadjkXvmQ6ZeRzr1H+YvjFEDxa7Odb9MIc5Kg+Hxc2B9jvViJfZ2GKPwhtD?=
 =?us-ascii?Q?WQq5rRpQ4f3Ci9TeLt/i3LdjQ+j+szU0zSHZ1bkv0SsKML8RTrEgJRbqKegI?=
 =?us-ascii?Q?fzMTZBN7zGcnO8k2PKgbomvQTbPlSvDMwRF6hUI9n6I8MrBdc8/jZcym3dr6?=
 =?us-ascii?Q?uxSgTV80tS3aNmDAycuIccLGsMlG7N+P6DQGPweQLfo93HEkhtFm644x+VRb?=
 =?us-ascii?Q?xw7rrUo+JLxShhCsFpa7GmEyPw6td8boiWWc1gLUTwb5RYHWmxNPWdfkYFRe?=
 =?us-ascii?Q?GzJdgXPyizFRBNTCEYCCryIqDQcPBoeNxLgBGX2oQG59q6NnAj84YiIl/E6f?=
 =?us-ascii?Q?WXlI2j3DvKZgz9TVrl1JLCRem+BoyThjThQmuFqvkDS5twerZ9R04rXF6WWF?=
 =?us-ascii?Q?FAi8qYuMXubneZS5mbUXJLHfncMsju7hF+9DiKXlctSjFGls3KOoKho3oBhp?=
 =?us-ascii?Q?87Eu8ryL9GsUb7nVL52GnX+P2gX5XwPKrBorq091FIix2CMWDc8tWOtzPhTx?=
 =?us-ascii?Q?Wbl6d2W4MvxvdpRbjcLJXd/c5k12VmApoxWlK23OaZOEScUTy6zy01S2T4BD?=
 =?us-ascii?Q?TtaXdRmmXL/qcryrDwldA/VUhOFLNHMpbanItanYCC2oVBBcRtrrAKASgVxE?=
 =?us-ascii?Q?GNyJ9rNDn0jRHln+8qwCEB/hhITTzk8IQ6k/bZYw5M+FDB84XF7AS72k3oJG?=
 =?us-ascii?Q?tQEOEcHjlRfufAFnySSVwnoQrIJC0Rbu+hpcjT8YBd7aFJ5crbdn5FMoac5i?=
 =?us-ascii?Q?HQveS8FB4dxmscEROUwCon9QqtpD0B8zoDYRcqXmfZDNoQ9cKbBos/SO0pin?=
 =?us-ascii?Q?cqGtY+xMWh81dEq49aXGMJssN0xiIhKD/UTIdlog6E/WGlFyweBYZjhkt49f?=
 =?us-ascii?Q?cyV6dIIXYnMyYEib+f2MgZA9XU2HqvCb3SBhptXNPzVGQ5OVnNtA8Cb8NeY8?=
 =?us-ascii?Q?qugdcLIWaRK/7GXichU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 02:29:20.8610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c9309f-0788-4771-cbfe-08de468212d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8527
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

SI does not support PASID or KIQ/MES, so there is no valid TLB
fence entity available to perform the TLB flush. Without a fallback
return, this will result in a NULL pointer issue due to the invalid
TLB flush device entity

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reported-by: Jean Philippe EIMER <phil@jpmr.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index cd4acc6adc9e..965ae02232e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -772,6 +772,12 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	int r, cnt = 0;
 	uint32_t seq;
 
+	/* SI does not support PASID or KIQ/MES, and there is no valid
+	 * TLB fence entity available to perform the TLB flush.
+	 */
+	if(!adev)
+		return 0;
+
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
 	 * this while one is ongoing.
-- 
2.34.1

