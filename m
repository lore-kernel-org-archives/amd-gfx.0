Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC65C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 16:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BBE10E49D;
	Fri, 22 Apr 2022 16:47:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 275D910E49D
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 16:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfzdGL7S68JWJEYoUrkgtUC4XK4jowuYn61ws9QzaGWbOn+oq5rcZaIdrHPOXLaCyfkUS4oo7+ySx4yQ3QSyhc2Z7FZMyI+34o9/1eO0CAPEX34wWm81Y7E5SZgGMHovNuGNaZ9dGiH+FEVmJI2UVzSbaIxJznVFC69xUnseyqRs/KG6zza08NHn2LDsyHpNmidqFB2bdim6DU6TcnSmJIa9OzwV7PsZquNXxlPgVIC48A+QAJDr/C7Welp65vEZd70qU7KmAqlXidAQlLrUZXffyi+8FMAx84vM7p9wwQ5ThzuX49HehJDL3wSaYqNmgVDhCHcJVQQloDcfaDhpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig23vSsq5vy9eZob/5qaonFqlmMdIZ0BCIWN/BlNCNg=;
 b=nfhfS8RGRfGGl6BKggjGw/yjq6To6oTWI9VPeLWGK+MfO2+HZ2o8e8S1lWRTCb3ZfKmeQwA+qd4Q853odhQY/r+UeVRJyEPqEhPOqaAQmApoIsdujmc8+uw+Ul4S5N6p2WDQNsjiLvLZLWHMJGWsjHOpIZECGgndnXOH7k3TZ5aq7oo/qkqhtn9Mjg1uL0Gmoxvi7r5//MLLyfhVqnCi7eYSX7c7RT9PPKkXARWLOb04NHqVFNkwBgVW8Yv6eSJmL4hn4TVH8hR1inETes+4JXVQ3ykvFlBGGSs20ooJsx5EmHafzjPmP6Lf4B4CuUFGQ7dScPCqm74IDBZsvXvvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig23vSsq5vy9eZob/5qaonFqlmMdIZ0BCIWN/BlNCNg=;
 b=oJ1ujALcfQ9UOVGkW6WdhTWJsZPWLP3Bjhp6bTKpC3KFsBer2QE3XJmYpNKXHTrfSLkt1eWkkSFP2n2H+s856576j2jUNrDme1yXJSiP253eQM+w5ka+T+Yygvit0UKlFw6xlFjuXGygl/vMPcKv/Ho3Z6r9uzCW9fcjeysHiWU=
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:47:12 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8a) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 16:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 16:47:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Apr
 2022 11:47:09 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 22 Apr 2022 11:47:05 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Remove ddc write and read size checking
Date: Sat, 23 Apr 2022 00:44:53 +0800
Message-ID: <20220422164457.1755751-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
References: <20220422164457.1755751-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b572667d-945f-4c58-5089-08da247fbf44
X-MS-TrafficTypeDiagnostic: CY5PR12MB6300:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6300D9325D3BF9A3D0EB961FE6F79@CY5PR12MB6300.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5iI6z21IdM6g/hUITZHFSL/jeXG5QDlM0NLF+nUMhNBtM4IcA8tvK1L5emNLdJvoxB4t8viTJrU4MUM8RKHhwZeDwlw7AN/iI7+t1f4plQ/FqFv9OODJi72WtY9yiqsA8RN1w4bSuBpuyEMHdDXj/7USCIVsoi+EA2fGBa/AB4tQJUpVtInscML2MyGrGXuAIB7f+NVtFc1rBlGqxvYTTNowqOhPYosZ9xSqp0z6pb5njsHhyVFHmZZxipw2eKepPZLVFpaUbXdgPj3qfUCVzphhkWXOiyAb2csgOKcRcDRojSq/OEq3ILDoXKdnIp1lneyyb8FgqOR1hTA4xHcSrZkou6YYsGuqTvnM+QTTg0AYcWFVLwvNq33uq6R0EFkWmxLNjswHkqd6U0Mu8c1FiFAlBBDldcw0uFIlJJt3u4hATccEZDYFlS44ivckYpGmh8CK+ZGhhHyxP5lGVdAFrynUlAqtInq5JFCugs5H7Ct/pD+RWFVKDpvNPWJXRHfQUl9GXd3jV4s1+u/eh5ZD3UqcNyYl8vNPcyfzgUl5nYxQLlblxtAwm+HKDgRLmv0NTc/uljsSeY0ompXsd6RuzYVG1SjhVoLdfOIUt1vLqQ4P199kPAA/+ojhBEPOcHvZIYrshL4S9pvZrXen4zJa4HZpGGVZZ7irw20beZe/LT8S0XzntFXpVuDySzLGpZMZaXkMHg1wXzJe3LccqBpDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(83380400001)(54906003)(4326008)(70586007)(40460700003)(36860700001)(81166007)(8936002)(7696005)(186003)(82310400005)(86362001)(6666004)(5660300002)(2906002)(70206006)(36756003)(6916009)(8676002)(2616005)(1076003)(316002)(26005)(426003)(356005)(336012)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:47:11.2843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b572667d-945f-4c58-5089-08da247fbf44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
Customer found I2C over AUX using ADL_Display_DDCBlockAccess_Get
will fail when sending more than 256 bytes of data;

[How]
Remove the write and read size checking to allow sending data more
than 256 bytes;

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 1d4863763df9..2b09310965bc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -543,15 +543,9 @@ bool dal_ddc_service_query_ddc_data(
 
 	uint32_t payloads_num = write_payloads + read_payloads;
 
-
-	if (write_size > EDID_SEGMENT_SIZE || read_size > EDID_SEGMENT_SIZE)
-		return false;
-
 	if (!payloads_num)
 		return false;
 
-	/*TODO: len of payload data for i2c and aux is uint8!!!!,
-	 *  but we want to read 256 over i2c!!!!*/
 	if (dal_ddc_service_is_in_aux_transaction_mode(ddc)) {
 		struct aux_payload payload;
 
-- 
2.25.1

