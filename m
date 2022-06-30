Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC605CCA473
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127C012A845;
	Thu, 30 Jun 2022 19:14:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F71010F8C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/6DGfMRHSq83MXIf+Gz01pAo/JfSu+8RTlXm+pscfYkBZc/nDblL4tBqQLbyvSsKat1ke9/4lMrNwcU4B/Uk3lR1bFb2qWwKgC3+dAt6JMm3j9uxI269L2wtLd8Y/Iolt3O0T521mgONWAabQ+usllGd+clO/prR/ehfskGDCPKcSM8i/zwc8OXUvfs+GFNhcdDXvNqvYSnxuTmQFkOy4b2mdsV3/VFGl86dsN6knh4wmKStXmBkhecLGHCj9DIxSUbP1hS6xoKJh6hfRm4S5UhdCymaE8MwiZbAcqExg8rgEa9JBLjBtNZUscNlzRTpX0hbw0qbA36t8LU3BZftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDv1VFHthe+j62gIFdh9y60/JvkxpSW54M0wnlmS2XE=;
 b=Un5sGJUao6z0SucvBbJ04VDvDV/gPDKAQB/28Yzcrag1wlT9hg/goeQpboa5jC81wWkD99gl4ByBHJIissJFoIkmROgxiRBDvqVhnUvoInKNFMPKtYnIxIIo4ursAFqHc6nPlSjj5JAqP8LmkjAHYhp+6YFJWhXzw57M3c9wS3r5GomSqMftffIaSpynA4ESqmLgvHpJgWs5A46atqQqZmtToD4IaYihwbvca+TPEYo1VLsYxKLsD/wmB4simxnkVYRIk8V0WA0TmiE4siOFEiDojb2M5ay5JDxQySMZQJvWU1fpxF5RPjXamseWAsGmNgggYmFrWI25Xp7MzrvioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDv1VFHthe+j62gIFdh9y60/JvkxpSW54M0wnlmS2XE=;
 b=gP9V4DmGDrFuuhr5hSgNlR2Ybm/649x54kAhElUH8rSo24h/dRRRcTLvBjKGVEPLo6aotJEVQvY+A+qAAKea9mXd23exLZO8mxe2TNN6Vdo3VdTyVEmBtFTwZXzTILkgrNblVNfoFSLI3mbLN4NIuKqDW8gz3ZRai9LFHVfm6Q8=
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by BN8PR12MB3122.namprd12.prod.outlook.com (2603:10b6:408:44::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:12 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::6e) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:12 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:09 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/40] drm/amd/display: Guard against ddc_pin being NULL for
 AUX
Date: Thu, 30 Jun 2022 15:13:04 -0400
Message-ID: <20220630191322.909650-23-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36563b0c-6d13-49b0-6d62-08da5accb7b1
X-MS-TrafficTypeDiagnostic: BN8PR12MB3122:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW8CJcOuCibFobxObKWxk9OmGjPZ0Wc532p+k9FcRCsbB2BlLEPQ4HPM8f1URs3hvP3O3ez+eg+blRpubp42PZz9s/TLoGAtPbi9hrCAhQ3/X9Z//NPv9JnhehADO/KNi6WNqTnCxU7IGPAby8pupxhKDV+pmFqgo9TY6XvzHBkPS+zUaoy+zGj3aHEcJwWHYEz8iVges9phdbDLv9FM2QTMmyjbDBxcSBuCjjvgIb44s2H6SygA9mxYx+WN9HvJyXGaMnenkoVbNKXv+iMfb00HWXpzDe9hFJEWWj/InasD/v+bVOIH61kuLJPHKV26heu0vNqiErUqG1x2swmm1lEDYgAJ6Lvll56NLoH4K3rFyVSosQofeD9FvSj9Lmzw72pCJkW6NxeNLfG0UX3sTl2CLaTfzWIAjVY7rsfO9G2372Ims3U36wec+tMFjQ0ZVbnm+tpqf1M4d8qyk1NP9PB6Fk3TZ8P4r9M7h4J7Nw/TEwX6TqNEdrzX4/DSLg3NEEEvXT8vcYgujhUHGY0YT7dNuRkXPZFA3MTq5CAYa++eFuQQD+V2xlJCyte55AsG/7wkIxUBlr3WGO/j3BVXdBr/VY4clDt34s8eYsITkNetpoW2N6MaUMHa8mFKyAn7/Z5nT8dP822b3KKPQ/pfgPLFmVY6zxyR6iklr9pmu3Y9yX4i4uSDvXE862zO2zpL1dqtYfHL1/pp4kGdIBy+j86ZS7cberQ6bzj/c8NtXfDvy9mV/95kAwZzP1Hqfgyb1CjVqVNn0Cynt+IOF0/zDC8QlaWOJ+bEqBLnWHMcYyI7bDnYigDpy91/YdmTWK6T0vyXnLdT+45HNGQ68AnvFkt9juFbrBxx6yGiJKTKbkM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(40470700004)(86362001)(36860700001)(7696005)(26005)(2906002)(41300700001)(6666004)(82310400005)(5660300002)(8936002)(40460700003)(478600001)(47076005)(4326008)(186003)(426003)(1076003)(16526019)(356005)(36756003)(6916009)(2616005)(336012)(70586007)(70206006)(54906003)(83380400001)(81166007)(8676002)(316002)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:12.7408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36563b0c-6d13-49b0-6d62-08da5accb7b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3122
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <Michael.Strauss@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
In the case where we don't support DMUB aux but we have DPIA links
in the configuration we might try to message AUX using the legacy
path - where DDC pin is NULL. This causes a NULL pointer dereference.

[How]
Guard against NULL DDC pin, return a failure for aux engine acquire.

Reviewed-by: Michael Strauss <Michael.Strauss@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 9e39cd7b203e..49d3145ae8fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -572,6 +572,11 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
 
 	memset(&aux_req, 0, sizeof(aux_req));
 
+	if (ddc_pin == NULL) {
+		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
+		return -1;
+	}
+
 	aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
 	if (!acquire(aux_engine, ddc_pin)) {
 		*operation_result = AUX_RET_ERROR_ENGINE_ACQUIRE;
-- 
2.25.1

