Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7996C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5D810F73A;
	Thu, 24 Sep 2026 18:46:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f2EZhM1A";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9411110F73E
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pq1uXXJH/jQ09zVJO0cjO953xiIsPhmx0N4IqTVpJgG/fUX/4eqWO8GK8XeTPzU0SGDAufSmLAqRCxtTCbu8hIt2qmKxcf6Ka5hTs4b+Zw5q3rKouNk2Fmm8b9rv4tQPjk6ZwqnKtuwCoAE1IsHHf+QorSPR+lxhqkozanY5AZxsJNQi5unYQD5sOMREKWgKi88kL3kz3Dms9MQebwaD5JMccjWmyd/ploYWlNItIA9Dm0PvcXrmekYv3v0/RUOFluFF7Wwrw3LF1L6c6INO2HrGkCIxDxQK9h8c8Ba2pBzCpVz+G8OIOFkRmSxLl+DiWinU6j9MPTPUB0wJ3CFDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dHRDdhDaTI6Zub9uUNeS+PCPLMR+MiOo9nJAORr7ec=;
 b=BvYPfx8ImXP2xVFWvZKhvTOABD31lde0P9ivxfb5VyRuCVBwPjYL7pZQUcgowxuGEBAoxPHNKCtLdPyurcFJxghgxhIP3WN3RD7jLI/1IT1VAzExJgBkEccaXz+bBb+PXHWytHy0TKuxooIxMhWXBtWtdX1dzIDqw2SN6cgIC6+j84Gm3Hj51aiupRBDUMBJispIq/a34Ax0K3YC7AoQZ1DBZuu4hrv9Lwj/cMerVfSGUkzhmEDWejMGQBFo19OcLZj7chfdLeiULJOnNJiuX0MqX2E0Ay0CCIprwYXXDkRCQGJv8pamvL9AvgURFKPdXV1lPttiVadTzE0/MGH70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dHRDdhDaTI6Zub9uUNeS+PCPLMR+MiOo9nJAORr7ec=;
 b=f2EZhM1AMyT7osTm7q8iQ7QbhNPqUUtUN+MDcdpZhdVtGicT9l4z9BUY53Ic6fSsifkVLh6uaROASzQf6d/bgklB1/8glTArd49+QNYbddYJRIR7HaJZGajQbn1Hi5Sr2krUpkRFiU3kkTMsMAhkhzn6Obhzjjana/17H0doQQY=
Received: from PH8P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::27)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:43 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:510:346:cafe::85) by PH8P221CA0034.outlook.office365.com
 (2603:10b6:510:346::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:41 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:23 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 30/34] drm/amd/display: Enable dcn42 pstate pmo
Date: Thu, 24 Sep 2026 14:45:43 -0400
Message-ID: <20260924184824.596894-31-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: d65f9e26-7f6c-4484-3b6f-08df1a6c2c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XKIPcDX6Am5wpaTBsa4j7nKks8US1kkRQ2G/eIsxaAfo5/DIjcQsk5AS7f+lu06vsluHz9o9kgj6gc6PTK8hxZqoVL1jwsOiaisJf064Jn0Zf37eT8MXa9gHF3UgH1XVaNnJxDL3Izch55RJRW/gCZuBgdvkzreHR/L6obfTdWunBnafh30JLj7+UpuMy54okKbizmAxzN1gmCDyrX2dcG+YpWCf/xUUh22n6Y/T+ZqlJkAPfMOE5ENfAY44wcCH8E/DBDsghHJ0JfYaLEpR5YMDEhJwreEblJU/mM25pfnGYxElMJwSc8np+S/dRiqtLsVBrExrWcGsvtOdLc6NDeJuoUhZMTCdOY1l0sq80oralUyX49PV3FO/b8yP1KLhC7EPYOgNvedgOunTB7Ky5A4NH4CcTtOBI6TSU4+LIqMbF4JhZ2X+caQD3vKPSsxnGOdQasGxwTsnFIYO3rSTHdEVxnls3xdekeXjczplqGPTB9J05hG3/4xxqEPssSfJD6bdjgs1uYbWZari9p91QT7BMUcmDpd+D0Yov4+lg42T43zyF/4SaGdu3DyOky18wiGUeSRwo3d0oQoK+F4VDvQcA0xHYG1Z7lVqQOjjc/XPOX9dyqq0KdaF08DlmjJ2Scl3tCijCYOkG0kOlfM3XaT8argEaq6jaKrg5oQgm9CUIcjcCEWQPxMYmqXlpRSZs4dNF7CV1S3/T/jGoka6yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YMEsrl17rZofKE4d2AmAS3Q22bRA1faG8Al55R/FZjXbsOWeDqHObriMzRdRIMiE2TViHP86uvcL5SDj3NqA9LPmSJuDIBIfstnJMS2dHqaZWnonJQ5PgtWFM9aCULp1oqv764ws1BZfBZNZq8Tr9h1nEqw2UirctCsjfavgSlmOEkSbWOrPIkkpMMEgr+EuCKfLMU+gTBTmUB8kQ4KUt0vMCwv1UDr6/g9OTPvbkqde4A/oHuVANLV3rZneWUv/1PckHdx3cQlFbRsOFflRUO0JhCfhLBXt4CUthGLGzo+JzmNMkV6Vf1KRlM86MJrqu9Gl+FoPPp4kDFMcC9Xd8dyLcSs6XLHG7i10yfSLDSNX7HCbGGPVO00nWpkUYZ2IqJ5D7CUg5cl2qOOqoyK7WtkHoHgQHyiNZti9TezPEjQhI+Bxjinc224Ax7TEy/44
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:41.4928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f9e26-7f6c-4484-3b6f-08df1a6c2c8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

From: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>

Set a flag to enable pstate pmo, we want to always allow pstate
support on dcn42

Partial application: DCN42B resource constructor only.
References: commit 67728572cb57
("drm/amd/display: Enable dcn42 pstate pmo")
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index b31f8cbd5f4c..cff4607f3658 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -2437,6 +2437,8 @@ static bool dcn42b_resource_construct(
 	/* SPL */
 	dc->caps.scl_caps.sharpener_support = true;
 
+	dc->dml2_options.pmo.force_mandatory_uclk_pstate_support = true;
+
 	return true;
 
 create_fail:
-- 
2.53.0

