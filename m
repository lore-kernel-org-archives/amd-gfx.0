Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA757C2BA12
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5867A10E6E2;
	Tue, 11 Jun 2024 16:53:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxT0wohq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5729010E6C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8YAoFmhugMkzU7riwEDSGc3LRZ8GGntb2SewljDSTShpqHV2F8A0XDXEwRpdZrSwSKUAlA6S8fIon5lCYA6iPPXV+r/oqdwei+Aa5EtQs8ZIe40/snJ3STLWK9nxMJg1o5dqBod9AZ4x5j/Jsazd1j7uOuwZ5ecbD9tv28YpgMQZq1K8LaOOebSSogcheiYMSE1Z+o1wY3PpYYEzyvPBmYwwmYWNB+f71oVMKl7M+k2WMbJ8Ln94XyK0A1+Pwhlo0+hBIa5B6NsGtlQbNXRiwlPH0nLx80h8fzZE6wM3escUMKSUWK39dXA0q5brGCscOQFCDXGlmP08orfGHIVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQfeK1bO4h/sfxt3C6GJPnmRe9QN7YT7NZcHKtEzV/0=;
 b=SaqUf82IXPwNrUyzLP+0NDn9l2hn7X1E5RthKbvkV2AOXoT6eEVJ1dKUzHcOKPZ7DM4zssqdeOJQLMcdd0qcgFcU307NnzIMluQauF4Q01PeTf5EQl1ZqmKX/ahkFbJ/LcqfaLjoWM6M6Id0jcHJJThzj0is7nJMj5cxPgPJGhakWcCR7KP7sfIaUMe1I5+P9yQk8azptZKL5wQFAt9EHS9CL+inDWZISFpZnWjJwrHCffkOcqPsxml+81MQvFAFf7w8kzRg4Bskn7iclQBdewj0NWsD1NL0CrBQKugpGeMG/+7F5qRrpPUz5N1fRQ4Xv2AyJgiX5uJvXzsJxA55yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQfeK1bO4h/sfxt3C6GJPnmRe9QN7YT7NZcHKtEzV/0=;
 b=zxT0wohqHXNORg5HBXBzFVv0WNqHKgm5c+2I2tlnAhNwv3RPk6TYZbSdxxB0mwmlUqDXKbSHCqGig60jqDWhgiOZ1xjFmnL7EMKaQeKFYTExkacMfMhHDFx1UT+XduQAzlg/DwIO12oJ0EEZ9tUsHM7vNnXfY9gICwCQ1EUiHi8=
Received: from BN8PR07CA0015.namprd07.prod.outlook.com (2603:10b6:408:ac::28)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:23 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::a0) by BN8PR07CA0015.outlook.office365.com
 (2603:10b6:408:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:23 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:21 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Ivan Lipski <ivlipski@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH 05/36] drm/amd/display: Remove redundant condition with
 DEADCODE
Date: Tue, 11 Jun 2024 12:51:08 -0400
Message-ID: <20240611165204.195093-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: e61d6487-4593-47fb-fc4b-08dc8a36de08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P4PsT2+lt4z0qlmvQoHhON+YS8MzyS69TansAPMD1WC7Tg9Gf12NzA5EqnOk?=
 =?us-ascii?Q?RuMzsCH1jgNS0rJSe2tGVeX/WasgkNhWFz1JZnTS2dgdupdNL5Kv8lPBRTB5?=
 =?us-ascii?Q?EB0FYNXOmJw8Cqaq1D727yj+FOFDRTX6HaePlvk1dJeenqC89kgPbzgr5GpD?=
 =?us-ascii?Q?JYSbr7ngU5HdB4+/C3Tjli0B+8JOgbIlYesGStZnjq9qJAg/47exEV2fpo4/?=
 =?us-ascii?Q?EEMLLR9Csiu5ynqUufO98mL1sxovm+YcFCNDgrDmrx8beeBhUTC1U8onlNEf?=
 =?us-ascii?Q?mK2WUkKKV2UiXAXn7QrndIhghxtoqKtW+mt/I0GsCwDmqhy6ef59RJx1weL/?=
 =?us-ascii?Q?Y6IeCicpQxWxRo0oHbJngFbljKP5Jr1/nbZq90IuE3oE9tX3qYI7SKzHP9iY?=
 =?us-ascii?Q?KUhkX/sVlaXkp/UegBKwJMRIF/OJTky1rrGOZPzou1Q2lbgThFuDjN30t3VE?=
 =?us-ascii?Q?mRBFqglr9G1mNHqYkQmF16GpVaSo/1PrtQSJwpqtXPe5vts4sZb4+77UO+2k?=
 =?us-ascii?Q?IRRgndPpFz/fPIyU4fyrlut46q+qGBQHkge9iqGXl7Fo/e03AVvix/xnT2k3?=
 =?us-ascii?Q?iYKMI9kApRryarbxoNWMK8biSMvq8qf+LAuZn6DeR8aRW2YQLJgNRIRUMbgN?=
 =?us-ascii?Q?EfToJfjH2EBIKkmTogiGdjBaGpbO67KSE9CVdP1gVfaNacmzoQmtZSS4alTQ?=
 =?us-ascii?Q?y+YMhqbkssFaZMMGHIkCIdXDM9m4Oq+8R0gvYCdsl7bldXFYHjLnxW6bAoAN?=
 =?us-ascii?Q?xTGSthwHyeHTqaxA38FluKZ8VHY5OEUpwU/lwTsx9fd5FgiHSLpoBQsSnuSV?=
 =?us-ascii?Q?xDN3WZTu3N7APmWKzEHlU7TfQFOyzpfPMfQoEp8dqJteGoQ9YoRxNbaTPCCf?=
 =?us-ascii?Q?B7ZgAG6Ib373kp2am3nOWR5LcHUxZqwnAt46o+wEqx6S79zjFLWnTCYDbA0F?=
 =?us-ascii?Q?RNHuGJ4ZanthT5VAcHz6dEOLe3+eoKb8Bg33rKV6u+uNYDUlpQr2O48Q+RkO?=
 =?us-ascii?Q?m7fMUFq2YUDdm/F2hfEUZZXWn0tBZ9fAqYsHgaaEbs5Bsha8HkF6fu0DJU+l?=
 =?us-ascii?Q?FqXyojTDJj57PwCXQ4b3Rf7x3dVCQnPjMQQC+gJF3CeEZ4alnBQI3fqP1v4K?=
 =?us-ascii?Q?Z6fLMcpegHo9VHmtSIepnkWKqw0x+jvW6pFVlRilMo0A+M5Dkp/kA2jD/9ia?=
 =?us-ascii?Q?J7Aj9UTVs+0cWxaHmBsG3fvDoajXbAVOMJK29ig/phHKHSq42S00H+CHJHDr?=
 =?us-ascii?Q?VqwlWF7O2yWqqvmKIhcZcQ+eHUz0elC6bf8wziBll58OfmdOkXkyyL3Pim6p?=
 =?us-ascii?Q?bwVeKEJ65QRddFK+e3aEuu684Y5HCLm4v+EVy8+YpzlMcM1VUins8RjqmkIn?=
 =?us-ascii?Q?PKP3fFy9JKofv6ez7I38QpbHxx7B87SX6PaT8pB5OmKWRbqyfQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:23.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61d6487-4593-47fb-fc4b-08dc8a36de08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Coverity analysis flagged this condition as DEADCODE since the
variable 'req128_c' is always false, thus the condition is never
true.

[HOW]
Remove the condition.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c  | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 618f4b682ab1..708e1632170d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -297,9 +297,6 @@ static void handle_det_buf_split(
 
 		if (swath_height_c > 0)
 			log2_swath_height_c = dml_log2(swath_height_c);
-
-		if (req128_c && log2_swath_height_c > 0)
-			log2_swath_height_c -= 1;
 	}
 
 	rq_param->dlg.rq_l.swath_height = 1 << log2_swath_height_l;
-- 
2.45.1

