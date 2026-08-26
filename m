Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E5BC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD15F10EE3C;
	Wed, 26 Aug 2026 23:20:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GPhFa6qk";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D74E10EE3C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3JCpiTpQW2ZuoArKeaJ2zKDq2X4ye6CdG28TxfdSjL5BaxvTwdrXY+2RULMUYgxOYh08mEGhX6y60wUfsRDJENw0DCL69xt3vavODabea0JqScTEAuB3ruSo8sZc4mDE2tUhNpER0WZpVUwkQteDh5JNsc49XoZ09jXJ3YuU4qJn3A5vPGtzIhcogHmkWF1zQeBUjzWnNLUwwKrWD+jo1K7jIhuJUMVvsPhc8t1SnT2qqM3tz8Y1ZD8L2qIr9fkDfq1nOUnQz1zsIMpZi+aU2I4TiADwcv3E04+ejuf2EvlmvSoLrs3q/6DofgOSUYTzeLzY3H0sr0qkbtrBDeusw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=af+qLnK8Vy7JJj+ih14Zs1UvavJWYNxkTa8q6rOJ45k=;
 b=gNq8aLOXF4txnSf/TxGAA6PEF92KwZbn8kZs6osUSiiJ4aBjLYVIij4aY37h04SPtCjkj/t4zIteawVvQ0zULFzrvMeUd1Dg18i4V31556BTFyoTBJQQ3xdcHFN9Myr9oMMs6Y80Rp1JBmBJk1NmMM7MxTNY479D5QnNzAKaeBVg+D6HBHoui6+YJeHCJjWqbRx/x5IfyLEYGBz0N2eHxo62b+7DGNwaT93IgyKlQZZnvH6bmhvIk9PQlVaIbv75PE8xX3WzWueaC2ldb/xEkMlOcijYIreCuLRgu2Rgupv0pJgRpLEF/lmQM7sCGOwqTI106HS8CivrNBlqcMftcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af+qLnK8Vy7JJj+ih14Zs1UvavJWYNxkTa8q6rOJ45k=;
 b=GPhFa6qkm7UqjLwmWF/JAtUZhEgOnKmeSvvvv9PJHanS3IStZsARVKvfd4JEo0IqrrgB3nbxUnr56Os2xmNv08TUFNxQwEbHDTSvnZU2NE5axJ76p65Fy2ff/J9JIkmVSOEY2OSKsQnbcYlCOwhP0D+ZWlbXgxa+bxINcMmqqXk=
Received: from SA9PR13CA0092.namprd13.prod.outlook.com (2603:10b6:806:24::7)
 by DS2PR12MB9687.namprd12.prod.outlook.com (2603:10b6:8:27b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 23:20:40 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::9e) by SA9PR13CA0092.outlook.office365.com
 (2603:10b6:806:24::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Wed, 26
 Aug 2026 23:20:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:20:39 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:20:32 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 14/59] drm/amd/display: Guard DAL port idle optimizations by
 ASIC rev
Date: Wed, 26 Aug 2026 17:04:45 -0600
Message-ID: <20260826231519.881949-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|DS2PR12MB9687:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f7301fa-832e-43f4-7f2c-08df03c8a4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: eRA+lY/JIgdEwCbcjPUENTvux3ZunIYo3LQkXcQIM4QBKwKKAUl5vC0B0Q7SJdE0y4w6LjYOfo3a9BBLRCnIwQmwzCds23hpZ6FRSXpVQ7+1pcoJugvjgRne1beuy7TkTAdEUTGxmpGW1MLX2ppOmLGLcHx6aQZ1Kd7HLqZAIe0XYGiZQPauPlnVfI4e1j2orcD9bN2fc2BvGft/WOkPQ2E4TGWZgQRaGKHEec5/qYX15//jgaQ/V8bYUiryFQX+ca55Yp7jatHXEV3DUqNmGzzLlTJfvJ6Vhsy8iCiZ0BflMV9Q1I9ShU/tDuW2f2/zVpur8HO6G9pC0MSME8Z1BJnPyL9jrHC1qB7w+0sdDyd922KKtjtE4qQsv0BNkQ0f2iMAvQp+guaJF2sqUn9k5yy11mJks18O68EHg9JMngb3m6R1yNfm6nNlEwPmoV+CUXd/y1iJ783zQTPWxXDDAPTm9tlXOKGeZS8Ng8oklILlp7Hi5pPhQ0FaMvMzd17FJPV5SkHoO84yD+aUJCOjh7w709mhtYrdcbD/C08tWkiOLRqfN57hXM2FwOMh5e2IlHYx3QMJGhRj2quCMS57HLlK0oMP2COBgXF1AeY0xwQd40IvHGQ6sraIo2DEhq+UAY0jyq+Zlh9GnNr7np70NTCWC6cnRzB2VA58MzXlekwldcWmTmPP+nUH3hn0chiXcwQDwGer2cPkJ7JXfUPK+w==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EQWkuYXtUG3P3s9j6I/le6V1psG20H1baeKa0X/wHCqqdhXeC3xq66eFL51TqljHs60+rNvYfIvbL6nNLjIR3jraNWEF+18kVVrlhHZuZdtd6131cEclpQnFb6CD31fcyFK1wXi07/NpuroTycWxuuDp3jZtd2dBE0UjWuUacPltgwkFXMM5fPg2hbbO9FBCg5pUjO70LTj3h56XtE3rYzPECo+y688enRtoK/newjYYqv+gskspB9EAUkFpB2e902woi0zSxSnwNjMzjrEfrYHZ5UqgKiGYcLX7tamIB9R8WvXOV2xX2wBvz0XCGwrFbThnOLDSSNFg7AvWgvPUwLRpnLw30eiaCse2Z0k4qn7vrYcmoTEytrdYCFePTHUWsz95URr32BBp0tvXRGa5UFt21Pr59c3HuYAlOqjlksos84YGD/7cxeSaZzzD2qB7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:20:39.9475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7301fa-832e-43f4-7f2c-08df03c8a4a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9687
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Not all ASIC revisions support the DAL port idle optimizations. Guard
the code with a check for ASIC rev.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 218856c5fe09..c6f90b90c10b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1539,6 +1539,9 @@ static void dcn60_set_idle_power_optimizations(struct clk_mgr *clk_mgr_base, boo
 	if (!clk_mgr->smu_present)
 		return;
 
+	if (!ASICREV_IS_DCN6_VARIANT_LITE3(clk_mgr_base->ctx->asic_id.hw_internal_rev))
+		return;
+
 	dcn60_smu_set_display_idle_optimization(clk_mgr, enable);
 }
 
-- 
2.43.0

