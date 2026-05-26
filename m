Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F22CD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3262210E4DB;
	Tue, 26 May 2026 07:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b6imkYiV";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4445210E4F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:15:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHXg1ecuZvsbY+aXaSJA4tE3L+c2PTNc3sWpUEfGNlBuy69PFOkVVH088RsgAKE7ZIxCJqUVst3Oi7KW+0de/t5tUBdmbtEk8LmG5VttrxcYgCkALJ3Nb77uWyylN5JyTH2fje2r1xUTCLaubxCRSwgJANsFGlrWZt3TdqX9Ac/z933rFhR1yRBpofX7sfLvOjpzI0tg4rnfjQoidfxQ+LEDKrvZijg5fcXVrw3wf2k58U4kSPD463O1ZID63SafOOu2hMhEptmwAn6AlxQDqEFFN2ZV4yENDuvCvHNFVJ3ClFT7j2nOyqov1hE6nvobZE3sH1r6aRuEJKr+QLo1Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8hut455VHThxYWhLwJg6k3tqQuxlGnrVdw9U3HROxg=;
 b=F9FGpHYMT43HT/WpPdoh+WQ6HA+H6Pe/Ccmhh2FbEEcf2MCToPcKA1fnAX/JKj8vfLSJZ/otxnx+wjtJAY/o3O8A6nWr8Lct7OhVtmvO7Tj6WsCrVZb3vo21aSqxgPF6GEU7npTeLPau2PZ/ILtpeyS0T+m4OBUvH16qwqlbmI9GVBzBbRAWOSnNoc7pzfXlZkvPYhlAbSZCiJNl9c4KNQe3Ty+5UOkzShN6V9f/L6BZiCCCcBLE4BNYy9c20e0HZ2cl0GINFp4xkOgJ8aMXkXJvGO1yY2Ke2sUUFr/IyAi9jr3ecbCsH5fwWfTwlyyuEsgz2udbiAilQQeFmUd38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8hut455VHThxYWhLwJg6k3tqQuxlGnrVdw9U3HROxg=;
 b=b6imkYiVBxXJ9sj2qTQ8veWL8M/6W0+dhKfDD9M8V7Ji9nOhMZ1TtWDJUYOoH/CIqFsSbbsoQAIRqmjjxGW5C4u781OQjUlhOqTDRX4KrSzis4vmAyiv42KisWjduUVu7aFuiYucuxNnGIafFD9UBuN0eZiYsKuvyoo0AxytAco=
Received: from CY5PR20CA0011.namprd20.prod.outlook.com (2603:10b6:930:3::6) by
 CY8PR12MB7730.namprd12.prod.outlook.com (2603:10b6:930:85::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 07:15:46 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::3e) by CY5PR20CA0011.outlook.office365.com
 (2603:10b6:930:3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Tue, 26
 May 2026 07:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:15:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 26 May
 2026 02:15:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 May
 2026 02:15:37 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:15:28 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/41] drm/amd/display: Add DC_VALIDATE_MODE_AND_PROGRAMMING
 condition check for force odm2:1
Date: Tue, 26 May 2026 15:01:32 +0800
Message-ID: <20260526071413.2181251-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CY8PR12MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 776f0acd-ee67-4127-20e9-08debaf69b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|18002099003|56012099003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: 4wGAnQi2nU1nRYtEOtwE32FGZ7D0uZSDcawFx7qAsZM83OogdgzsLJi3+62nc3uvk1xLvmx1PCPeNtadMTxNvpy+4K1mb88vdoG21uOT7uUMfd63WRHIv6dBPWkOFJBFFFPZ/Q5dv+L7Sv/bzqBwx2Z1sQbiUUW6taps0qvOHR+Xlwmp+Bt0yiyORVbLKu8VSzvOVdVSFMO4QwOZfxBcvavHEC85ipmjqQ0ss6SsggqFGPf+ITaIlOaaZUKw+WksAGRRXgm3j9qV3HW9vFtXNZC/iPqNiM/5uOkHnvoLg9LGgjddM7Zmrp6jtH26+iPV4n/+mrBBuuzmBrnM26u+ik0ZBNYEm5WcXe4a7cYqSGvaKF7Kk0fFPJNktwuB34ljyruU6bXrTTx01Mt112ffCzC2Wo6rVYMxiwoRUWBFufCLsV+UWuV2wDv2tQFsrdyOZytRMPdR0gFdPz00GULln4JYQUayv92BRH0NXkeWSmlOMHPs5SjNg2v16/4mI3ueEFYXhNHT5i/NrKby/UHc8dnU++XRnQV4UxLXe0/DNTZ/7gA/Dvh1oi2HJMxUJaJNsTPFmegSupujhjFSxsJz7a2ST+94aHbURwFioX55VJZUSl5Jh4qfJatz6qaL2UCpd5HA7eWbGXaoCQL8cLZJWXBzJPiVU2WcBVVPr5tkHQDVudyw5BXkt+v0C+0n3bE3CR2A2Ryz6XEi1jXNmrW6W4XATLNe3UE7VmkRtSX6rtU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(18002099003)(56012099003)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U1lcj/au7KUgbnbzvwRXO30GczptObRkqj8a9VqZndezFhNgiDhvRJsLChwv1BoUL1TMOiM7z5LB6FHuAP28JF6sQLf8iwGT5e1Iz1jru832mAlqwW7YKUzldPZUo1TehpNEPgA5aKj/EwAQW8APGw6iumbz+o9TOp89Q473RjCnfONwwwcxGWvLdwHBYtiAvhNdUXeDyY+cY26mDeTkhxtnLZx40luj2bBKBb9ZS1+KrgWPM1y6DZyd89H8pLT7XOiA9K0vdvgL3fTl992gTYpQIlKZGwXRdoiJASpKy2FYyWAL1rPgXPT3cMkJsE215gqdhA23DIR3w76OeVrDVOxfh6rMbV5Sx1Dxt0N8YDcKlJRJGZiBU8OBVL+U3ffQvimjiEVAUJFNWiPl3rFQHJPsfv8+D+p6RE1hv7CB2ZUIRKjHWFaF0yhpfPVM52zy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:15:46.3357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776f0acd-ee67-4127-20e9-08debaf69b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7730
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

From: Charlene Liu <Charlene.Liu@amd.com>

[Why & How]
Need to limit force ODM 2:1 to DC_VALIDATE_MODE_AND_PROGRAMMING only,
i.e. not block isCofunc check for topology mapping allowed.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c  | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index efe025ca4ed3..b9f998ea2d0f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1725,8 +1725,10 @@ enum dc_status dcn42_validate_bandwidth(struct dc *dc,
 	bool out = false;
 
 	DC_FP_START();
-
-	dcn42_decide_odm_override(dc, context);
+	if (validate_mode == DC_VALIDATE_MODE_AND_PROGRAMMING) {
+		/*only do this when programing HW*/
+		dcn42_decide_odm_override(dc, context);
+	}
 
 	out = dml2_validate(dc, context, context->bw_ctx.dml2,
 						validate_mode);
-- 
2.43.0

