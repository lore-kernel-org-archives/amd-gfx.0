Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7B7F34C58
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 14:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C1810E4A5;
	Mon, 13 Apr 2026 14:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kpm48rJk";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010019.outbound.protection.outlook.com
 [40.93.198.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA76610E4A4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 14:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXC/j1jgn6yrsqCJgGvMvn/sKcG3gxYgKg9gor+9vjGmvtCTQGMqWWbsUcgY35Y/BapgyHdn9wMxHsgKSCfJNV3BiQ4mOIrs10+lfoqQbi+QvophRscpDuJMIkrc645fJtHsq0mVskCAhyt1Qo+i8HOeU3v++jmLcSFJxzbioXpnucV+iZn558hxqw5iInIcqR/J+Q+S7xgcLM5ZPLrsGNSVkCq/exEG1RZ0OedS4w2No58kmT5vmFBov5M+bpmqfzjto7SetiLV1kencIPUN9x6plIsEX8Dwta5qiiEALKCqO87wCGbHT3Spl4O23Dgs1T/Pvvd5C8NTx2FdrwwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QutlR8lcbbTrJpvLlvv/TKaHSQSyqTR4RGB3PyVVqgw=;
 b=Mee9XlyTAXzWk39nGt+mPckMrMLoFpKrKTJs5MINpAIhQQXgjHF9pJRs6/y48yzpbpCyqBP+LEfUgrTRRCMiVqbvRIZpguKmpk3XDh0r6Cc7ZvTzQlzWtU1SIYJyNx35Way9yE5eaoZJZQPAdZIdexbyDzZlJsutFt1jOvOOkH+5wMHH/EonrUfn1gmkvAp9VcIYBRm3mA8Gez3sJBQvxL9nK2ItsinWBWZ9JQt/1E0KuqP37FOpQrZefDkU8SfugccNzRb8lABBowOGdHWAQLTc7QlNV7+tdrQCeFGUFWEoKe/JUFw/fizMsYfijT1T++yUPzw1QCZUJJKpkmJ4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QutlR8lcbbTrJpvLlvv/TKaHSQSyqTR4RGB3PyVVqgw=;
 b=Kpm48rJkMUPQzo9GZaJD/w03lsweZ50yPyaQfxovuKe0Mh5RP9P43W8ElFK/np5r8Q0dUM1Nfd5TBO8RtO7EPWMtivcYpyISKBDO6i/3EN2d8zKu04hRCrK2sqMK6IXRD+vFmUQ7mwDBsQ+ONvWuHmDU9yH1fUIp44PmaTEnGx0=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by PH7PR12MB7377.namprd12.prod.outlook.com (2603:10b6:510:20c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 13 Apr
 2026 14:21:07 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::80) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Mon,
 13 Apr 2026 14:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 14:21:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 09:21:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Apr
 2026 07:21:06 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 13 Apr 2026 09:21:05 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Leo Liu <leo.liu@amd.com>, Benjamin Cheng
 <benjamin.cheng@amd.com>, SDL <sdl@nppct.ru>
Subject: [PATCH 2/2] drm/amdgpu/vcn4: Avoid overflow on msg bound check
Date: Mon, 13 Apr 2026 10:20:37 -0400
Message-ID: <20260413142037.1039073-2-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413142037.1039073-1-benjamin.cheng@amd.com>
References: <20260413142037.1039073-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB7377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0001053d-514e-4036-3dd2-08de9967e705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2QXaNW+bxFO2s2thBd3Re0TeFpMj8k3WPjP2mDLr+0f17YBiHjQCGpvV5nTEHwJSXxJahaD4L8XbV9A3GNJURvmQS7Ly2ZPzM6r3WhFpsDQMYpFDoO5Kr/qMBZirSGZ0QWe+OgVp96Y0MdBgwObqkcBnGodeeQ12Tvd3mKQh0EnZ1R3T+7j91toohJSjCxyW065dNN5VO53L2STdxES4h3fBKXpPuTukCCIYOfJ2SaOL12A/HEaLBxfeDRWG/VD2nf1duGxf3NcnYk8IkaU6XGH/WTXkYJuWcZ2Q/z4aJAStv82w7MxJbXTGIj1yhH8ymJQxRb7oyimp8Pwy90Ng+56zFm4umWqFd2Cd4VtS8ukzF5WxPNj3PYpMxx7QUd2LL+aGb592pt0y5bB3HnKKIIyjz8bqtwwaAse/ypK/gR2ViiNqh0B/nCJS62bJzxrllAdBAMgcrHNL/QKfMB4nF6L7uKqWsnD2ieNn75u6/HPMZU8qWm0SBHNZ5M+BAepi0/Ezr01QqHkO5G4yqDAH30K9G1xaOAP+INJHC1iOzcM7NL1MD3YboQ6lINupN+aemRMtovM2ZmNRuPzvgIk4B04zdh7Tp30J0dykM5HnDK/8GejZeMZLnQhX0NBhUlwdTn502zQ1AnBSm9BL5WfJuQD0uZyXeLTLH5V4XB6NKNUcUs9koJ1IJ7rWiOAwxlb8KB2bB/UlzD+Gg6yEgmFtMD1nvPjr7JaRpbv0UL614Q1aTJPImRhTRyGtvKg5iWjHUdUI7wPDoFvTFIaYB3VW2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bbHVUlsqwfXq958Lca0HcsXrfSoRg5f3l9fyrd2eAp4HSBmAIV0BbdAkKiBs8mw9xm6Zg/G5BAwqFr+7hirOcM8gt/2yfcQJ51TnU1qk5LwR5+AMOCFn+iwyeS5MKPeRmhmmjIsegUhjW5buRd9h7YjOvVAXRCDVPhx+aFOgYgDS2qMrNjaUa4JAmQfoCX5FD8g9KekTmIrJqTL/SnWxeSL7zbYgjUpHPLA3Co3Gme8GCtf9QFIbWw6kyLp+97nBktSj6E0vNXLX+MczpObCDVW2r056h8rmtQHQAd92wmLFPUDsXPXWT/5u0jFRPoo7YrvgiG/ljnhl6NCh+Fx0GEZUZnvtxEGlWGjOOuzPC/f/290ojM5BtgYmYRAwDSXIsT1O7EB28l6bZV9mytln/CXUnwwDOqg0xCzn+au7asNRZVTdxTfA/hf0bLieJmlz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 14:21:06.8974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0001053d-514e-4036-3dd2-08de9967e705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7377
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

As pointed out by SDL, the previous condition may be vulnerable to
overflow.

Fixes: f405753b0751 ("drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg")
Cc: SDL <sdl@nppct.ru>
Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..63d37b475c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1889,6 +1889,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1896,7 +1897,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (size < 4 || offset + size > end - addr) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
 			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
-- 
2.53.0

