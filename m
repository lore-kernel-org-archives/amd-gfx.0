Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9528C48BE0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA77B611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA77B611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777146ED9F;
	Thu, 10 Jun 2021 16:29:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2085.outbound.protection.outlook.com [40.107.100.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190A16ED98
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 16:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvjjSR1w6Cg02/4F5LtRc7E6Ejt23y0Xa59bM17+2nWSBtdf4vrgOA2GJ6htlcNTfuftjPlEvr0zC++n5RiKs5pQWQg/aUpNaVr0/Gh1vZk45lNuXmBajuXncrkELPxQL4g0JTgZExLcjExNnURyUiFGPhfql0C9WCCvvfiPXQFf9yk7JZn0qDnDJY7CcreosdCkknSJjgkHWlaJygM6CYLSEtFgG7Fw+Ei/Ih3uQaOUrs2hNhiB60WkpXSoedfUmv+zVMrn0UGvh8AG0h9blFbx3Vsswz9xQ3EdqwUPY4Am8z27WhxYMPiE/g4gx/Wazg/ujfqtSH0zuu77c/ELBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGIaF2yH2p3Ssae6pq9bd/pqBapg33F1IwjP0cEHN0Y=;
 b=OR0PII8dpStcFQ79FsBwJqtkXfj3t/ecN9U9YnUKi/McPXzr4QIEKtSpcMOeW0lg0pr0ajCdgS1GxL6CVGU+WYliZLMTEz9K787ZSIBdAd9kuo3z9Iw/xnmKWp2oFiBvA8zXSVrra00k8kuS8udEoaDthekKdaHcMRo/1Dvm2EQG9asMMwA2PCKHIzsgvj+WfE4iESyxRd6qowpMEwXSC9qnXsIAG65dvGOhH5hMmZYrm0OhvT+WvXNnTiOOA2wae7EObLB8sPp9reFE97Lzv8roWd2w8ajrd5VuV7Mv0ac/qiGBrZ+NMPhAJ24wbijWy61BvWgQ42OSGTn4CpBoiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGIaF2yH2p3Ssae6pq9bd/pqBapg33F1IwjP0cEHN0Y=;
 b=bq9HJ7ZCQyoHj/WTeX7jtxbZcku02BAoewGjqMR6BzP2kgAiDqXJv19FY57EP2wBt6eAbOxcHVXq97/mqOAEe7mWKpz9ErYFZcfYUOp+ujIpagc9nMXKTSqhFrep7KlX20+/lQaATFMnlRgbctClvuEfcSfdDI8bLmKV/U6fHYI=
Received: from MWHPR22CA0009.namprd22.prod.outlook.com (2603:10b6:300:ef::19)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Thu, 10 Jun
 2021 16:29:38 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::d) by MWHPR22CA0009.outlook.office365.com
 (2603:10b6:300:ef::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 16:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 16:29:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 11:29:36 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 10 Jun
 2021 09:29:36 -0700
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 10 Jun 2021 11:29:35 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/24] drm/amd/display: Rename constant
Date: Thu, 10 Jun 2021 12:28:32 -0400
Message-ID: <20210610162838.287723-19-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610162838.287723-1-Anson.Jacob@amd.com>
References: <20210610162838.287723-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a756b1-64f9-4287-96a1-08d92c2cf08b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51428EDEA72ED1083EEF5498EB359@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jMGEGVqiVI/vPj9408PwG4LGjHL6hYfBpSs7ILkdAyqnoa7fdqRotH2fFSCq7EXgXcgs9PqXY4/BBUQkAWCMsSW7Z/RXXnf2vsCAB37X0J3s9ZBZrZGOjXTu7kMwPMVZpeDFB+Pk7/K7N5OYJqiGaBtpSXUExoKoyWDU6bF1kY1KZK/eath2QwTdmRPguHLiYo4mIcrUOqIPWlULfY7YFuH/ouc4jJDB8Zd7FHN5XwLYQ6PQEuZsTYO51BnNmyv0g/E5pWb+pXqjG349ZDzTLzO3oDoscWtNU4/XenEJ+g9mBpzhJ/S8/eDdbF+9lMz/gAx/5aID/Bw1HO1CpV/d9CuvDnuLckKMt7s6ZoaGH36TCshdZJBkX+K7DChrlJrMToGrYoEJe1z/vfLtrOttdaeIZSv48uvoLRYPjfTDj8iwaGMMsVJO3XuG4mlt/8jupgV2RXN2m/8+WVfV3OD4013Bl5aGCC/mXxRZB3Subw515zxP8DMwYbcHOsWjXtpOQLlHP3NfJicbF9IFbQ+84PQfI56wCV6f0W6RRKRIbA7T/Sc8RFTWk8PjrUzWfoRDcdHUvkEXDo+Y8/HLMX07uTTglUqnlZTYoaPeCaTaLtY+Wb4sV7dLZw288pCxVb97zQuranfhZH8FEljU3EIEDXn7gqYjz2KXgoJzCsbMqR+AOwsI8tdF34Z5bUickPCa
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39850400004)(36840700001)(46966006)(1076003)(8676002)(82310400003)(36756003)(36860700001)(478600001)(82740400003)(4326008)(7696005)(336012)(316002)(70206006)(2906002)(8936002)(83380400001)(356005)(186003)(2616005)(5660300002)(81166007)(426003)(26005)(6666004)(47076005)(86362001)(54906003)(70586007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 16:29:37.3860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a756b1-64f9-4287-96a1-08d92c2cf08b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
7 is the minimum number of retries TX must attempt on an AUX DEFER, not
the maximum.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 83d97dfe328f..9d5e09b188c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -615,7 +615,7 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
 }
 
 #define AUX_MAX_RETRIES 7
-#define AUX_MAX_DEFER_RETRIES 7
+#define AUX_MIN_DEFER_RETRIES 7
 #define AUX_MAX_I2C_DEFER_RETRIES 7
 #define AUX_MAX_INVALID_REPLY_RETRIES 2
 #define AUX_MAX_TIMEOUT_RETRIES 3
@@ -664,7 +664,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 				retry_on_defer = true;
 				fallthrough;
 			case AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK:
-				if (++aux_defer_retries >= AUX_MAX_DEFER_RETRIES) {
+				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES) {
 					goto fail;
 				} else {
 					if ((*payload->reply == AUX_TRANSACTION_REPLY_AUX_DEFER) ||
@@ -701,7 +701,7 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 			// Check whether a DEFER had occurred before the timeout.
 			// If so, treat timeout as a DEFER.
 			if (retry_on_defer) {
-				if (++aux_defer_retries >= AUX_MAX_DEFER_RETRIES)
+				if (++aux_defer_retries >= AUX_MIN_DEFER_RETRIES)
 					goto fail;
 				else if (payload->defer_delay > 0)
 					msleep(payload->defer_delay);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
