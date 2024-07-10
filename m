Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02456C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:37:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A387B10E89F;
	Wed, 10 Jul 2024 19:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KYS3qrIK";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EEA10E89F
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyyFm5pU+I7F4IWYntXoypyQquUweD9BsN2ur00V153Orcphh5J4yDManB5RR8ezGOMS8ab0t+QmAVzYK134TkLSsxU6+TBSZNjgMZwyuNnHydFLM4P9FN33HNbBIqI0rS6xyQHxTa/WtZL1KRZGUl7dPbnWHIMheyOnF06E3cqGm9SWbaP1S8MraAK1i7cUDnaXX14x9PU4cQ0jPqyWM3KzpsNmrkfS5z8GEsMiNBmBmo5exUEFOxxxKtlWeQyTUfEgPoY7mLw9Dl1DOaWy7fwz4vINntE1CoApssQI+KmWYF2BngvopYZLjwIisZMYq2C95/46b0/Twx7bbnc/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h5RR0r3qUfUsUAE9jOGWgQ0gD7ThBQOU4luRr7dAJQ=;
 b=Ux/ju73qYmN110NYPHmpFuyv4RXcxp4QT5co6s5QtXGWkuivWtLmFIlhlO1KDT9Z7/z3DQx9KLAgFk7GLZ80C0bUNMDddAZnXsoNEeTEjxs7reANX2m4k48OSiINUfkMlY39/a4ppl4m7fI2MmS7i3duVdILU+sGUZdPb2b6CAPSpI7C3DsbNQJfuDS+2J/+FKO96KnHId96470jJuRnYujVmtR3Zc7N+5czcFokqdviBKsdZvfu0SiC/Mkhj0oUwZxF1d8Fzli+g/R2IPPwGzq4sKOnuygcHnKarYDGzATuOHkNTUAo8sonm6XjTxHYN+PyX3XWC4cFDDxbn3qLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h5RR0r3qUfUsUAE9jOGWgQ0gD7ThBQOU4luRr7dAJQ=;
 b=KYS3qrIKBdbG15i21f5BGsAmIS6fWgvdYfV2UcPIbhlrqjby4W9ZTOVH4may0liyHOYIR+BKA1K3SpFeUIzhesRFO8BHVMz9ZKLPDDnkij11rpUvy+H/DIqDNAA1fpF0fOUK4yQrFbOULcicQgzf0RsZD9O5jsEXJZKQnN6710o=
Received: from MW4PR04CA0320.namprd04.prod.outlook.com (2603:10b6:303:82::25)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:37:40 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::58) by MW4PR04CA0320.outlook.office365.com
 (2603:10b6:303:82::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 19:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:37:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:37:38 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:37:32 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/50] drm/amd/display: Revert "Check HDCP returned status"
Date: Wed, 10 Jul 2024 15:36:24 -0400
Message-ID: <20240710193707.43754-8-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c24b03-02fc-41c9-7641-08dca117c2c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jYCi+syE5ehuRVyyBVa6ugU0P53BxvI80n62TyVBilRsPvsTQSZWjZlGeqGq?=
 =?us-ascii?Q?vmz4IqG1r5RkMNi6NAUL5PXVOa1uIXdi4sJynAdXVbfOYxanHrqpP8WHBcdm?=
 =?us-ascii?Q?qP5qh0BAix7dy37iaWVhstxpIdtVvbINOUery8X9EYBLsa6CZA/UN2m4hc0s?=
 =?us-ascii?Q?uQhm1RrM5w8cWsmTfFuRj0Qg8kdteRXPi17VYnPSByGRIwhFj/4rQ7kAq9O2?=
 =?us-ascii?Q?6B+EmP1TgatS9+ZnvodUiVNC3gfeLZ9/1alckU2doCL/owoIqFOlSRqlLJ/x?=
 =?us-ascii?Q?x1MB2veLW5uzPdAfZ95cRzL53GwTAFb1RzFBu2PWUjyjP5Yyj+c5AYgEWcRw?=
 =?us-ascii?Q?PCGKApGv6hgW63+Oyu4dGYb+bVjFRtDNlUHxs8qWM++dIGF+ri3pW6GW/IOw?=
 =?us-ascii?Q?/88MvOSJbuOJUL/MaqfxBcZGpbasDfZN19Ku6ku64F1RZxxtowCtjVqadcTB?=
 =?us-ascii?Q?3MWZgI7C/1VKUD+VJry6hHX2ulnkBruAXc1icnBlnXl8mYbNYxnsCAfBU988?=
 =?us-ascii?Q?wWXEy5yzWIv92a1GYzB3H3zYzzhqrm75uh6kwtYy3EY/dJmYdA5wA+WBew3d?=
 =?us-ascii?Q?WdEzVromoHeIlYKPLsRK+wurORKCUpBE/xOXw6ZI0MTV5u7NP9iJEtvMFdmx?=
 =?us-ascii?Q?eYdBp1rkTjgAkMHKDYAu//+t5UirrCcOqb7Otv8704Ain8jAKnCfe5JNWtSk?=
 =?us-ascii?Q?8t5avuTeV570Az8uKyus8iUoKjzDH5BbfzmIIOyZnBTlwSKEApo2uZqWVQ+I?=
 =?us-ascii?Q?hK3PsDoTcWbVEHPrHTW1YyH/fzftHSTpHbFbdFlPLegcIQHXK6zFBFJiy3GY?=
 =?us-ascii?Q?Q4kHcPg4yhc6CdRCwAGBm08YAE4yB7JKlFBLypuE/2UPbauklqQwNtxUwq69?=
 =?us-ascii?Q?6Iu8JErDSJOsV5rpqFj8ZYA5QU+uetqG65sdwnR6B/wCWa5cgufTxPihHMdC?=
 =?us-ascii?Q?qjvsfDkWwMrwNhwfw7+NmScdvuz0Ll9Ks97mG48xwoOj/1mpIV7F93CEeAk0?=
 =?us-ascii?Q?Q2DKHlOX9OKcSn4WO2eEND9U5kqK5KuAKPoPXDpkIcSQ8n1Aelpti+P8Jjdy?=
 =?us-ascii?Q?1rBC/dQltsclEsY/wVojeGA+iphimOpVfCHDYfUiF5jTpORudQdkbbmBCvFN?=
 =?us-ascii?Q?2VMV8lWhQlEc33dMneSKVt3xC8JIUhqMNiuotETnxFN5TFXLswm4rrVi0xM6?=
 =?us-ascii?Q?Y/I9qt49iZTTGhhHV7rIEkubfDcoXU5v2mp8RC9YB8QCX57o+Qp/1gAmGd+U?=
 =?us-ascii?Q?jd3b6oggcMA57F4b4EHwgq4JZVqcWS3kiuOXKL0fmySSzfK2SLOaJ8DVsiOI?=
 =?us-ascii?Q?q9RBOWVkF8vN4tNcM7Np1m0aspDJPEm9BHmte8SC3kEe/iavUdw5K6vcGd4H?=
 =?us-ascii?Q?mTOVyiNnFwGsK8c2EyR8K1U/RP4eKS7ASIW8vDL/lr08G+HIpiEqCQ4sDIpG?=
 =?us-ascii?Q?GZlp2tSQ/BoHhGhdGRN94piEg/UUCiNL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:37:40.0799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c24b03-02fc-41c9-7641-08dca117c2c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

From: Alex Hung <alex.hung@amd.com>

This reverts commit d788be646098e6f4fc26763a213bd4fb94a04e13 due to a
power consumption regression.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/modules/hdcp/hdcp1_execution.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 1e495e884484..8bc377560787 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -432,18 +432,18 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 		goto out;
 	}
 
-	if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+	mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
 			&input->bstatus_read, &status,
-			hdcp, "bstatus_read"))
-		goto out;
-	if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
+			hdcp, "bstatus_read");
+
+	mod_hdcp_execute_and_set(check_link_integrity_dp,
 			&input->link_integrity_check, &status,
-			hdcp, "link_integrity_check"))
-		goto out;
-	if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+			hdcp, "link_integrity_check");
+
+	mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 			&input->reauth_request_check, &status,
-			hdcp, "reauth_request_check"))
-		goto out;
+			hdcp, "reauth_request_check");
+
 out:
 	return status;
 }
-- 
2.34.1

