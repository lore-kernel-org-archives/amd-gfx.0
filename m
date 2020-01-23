Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962C1C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C13021D7D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 19:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eCHjcGtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C13021D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DFC6FE43;
	Thu, 23 Jan 2020 19:45:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9706FE46
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 19:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lp8sCpmbVRHFT8XyP7pYblHj0LXDDIvxGIhY12wgKj34cA+vajiNKy0u1/xTDwmFKJFeJHX4HjVtxHZJfDqWoQEviJNTWiFIBKYmGuxE6cyuRD1yjQyNNgOpk5uvRnGnhvAEOTnzUHuJaIR9XZI4oVrFkdUoDwcT8wHW5BTbUD0/VDQC56ik4mUsAonumpRCS2qASzEiz9+oYyEWeJ6XpE4KJVein/NNwXc0Gc1jaQdJHqztR2ZMeyeenTkDm+/SwYmOiMV5Jnto1vKpKNBXllgt6RVNnisxsr9O2kM+f1oa6sFfVeScWYAlVqmFCgfg2XjiKxApflcvJ5r0SvhMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMen8z1BGVfyhLmCcujidyCijF7AFSyQAa0OsgCAjIY=;
 b=B0gX3EaRnQIxoOEd1VTnVIF69KCm7AsY7DwxXNtj65g4/8M/BVIC63+ns64wyQl7FI77RpLSlxTlGOLiFYSkor5gzAbP39tRBLYZphgG4k8LfXgrruz5yZ32vO2rBLJmrKOPY5XPQu46BqlJuBQd6QJq89wFCuPZOOtwoOYQA5Xj7/qzoziAYqIC35WURjRU2D++OOqTl1I72kUH0eI6W0ejpoVWfOIN1QLq5dyhJOUeJI6v2Qf/D0vGzrNmMxS/+REKbhTgDHGCGV8GmCuuIiVp0/X/s9TRfbgW+C6RfEgH4l4G9UBCSY0X68SwYyx6OWEBRbO82uRNZXG6x64ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMen8z1BGVfyhLmCcujidyCijF7AFSyQAa0OsgCAjIY=;
 b=eCHjcGtn9sS8ZeFkZE9niMYpNzgHLaH6UH04cxwUHKxGfh3aVVrXZ1K/rFJ4ZyHH344PPirjqCxDEto11KjgXp+Mlyp6uRJ1hp8ErU5TTjMIiwQajP7HxCY0d4M3fnpe2DftG3M+onWpnrUGgYZGvak6176PhjWC1dN/U1OvET8=
Received: from BN6PR1201CA0005.namprd12.prod.outlook.com
 (2603:10b6:405:4c::15) by DM5PR12MB1593.namprd12.prod.outlook.com
 (2603:10b6:4:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 23 Jan
 2020 19:45:35 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::202) by BN6PR1201CA0005.outlook.office365.com
 (2603:10b6:405:4c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Thu, 23 Jan 2020 19:45:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 23 Jan 2020 19:45:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Jan
 2020 13:45:33 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Jan
 2020 13:45:33 -0600
Received: from hwentlanhp.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Jan 2020 13:45:33 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] Revert "drm/amd/display: Don't skip link training for
 empty dongle"
Date: Thu, 23 Jan 2020 14:45:26 -0500
Message-ID: <20200123194526.17967-2-harry.wentland@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200123194526.17967-1-harry.wentland@amd.com>
References: <20200123194526.17967-1-harry.wentland@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(428003)(189003)(199004)(1076003)(186003)(44832011)(316002)(8676002)(336012)(2616005)(426003)(36756003)(356004)(6916009)(6666004)(7696005)(478600001)(2906002)(26005)(54906003)(8936002)(4326008)(81156014)(81166006)(86362001)(70586007)(5660300002)(70206006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1593; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a87a9f-211a-4e99-21cb-08d7a03cd038
X-MS-TrafficTypeDiagnostic: DM5PR12MB1593:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15935E18C600B69E851B1E9A8C0F0@DM5PR12MB1593.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 029174C036
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2rO/BnQmuTQFiHHLhvBDcXeRMRkZUXneJohhjBvzS447XjZlO+Ze9nefXl6kvZsZCC3BbA+ED1Cxd4rI813WPj5R4KVFs2dAc6zKvbV42wKrglmRo3SNL3556jvH4cPAlO58TgLkb2qYVzK2aCPAiW223TrEA9cvIIhDj0PCtKn+i9QKbk0iNuFNex7WmY1/vPHUrOM6q7+l7F1l2zOGy0Zpl2WsOecI3ZUM6IMmckO1VQ7J70T49QJ1op8bY8RMLkkpzLyiU2Q0MF/y55OmcaxEoQPgJvpzPn10tCSMGpe3RGoUulLma5THW3yvPGmG5tbCMAEu6AkXDV2QzHQoQU8kUFqpl5C65kTUJdkBKq8cYiC9BnvvoqcKtt8X3qZpePu6sS3B31lFQNtprJ6OnYS3DVjAz4BBPd93CodX+MpjlIjAmx/7Gh/M+AHS5Smp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2020 19:45:34.6432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a87a9f-211a-4e99-21cb-08d7a03cd038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1593
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 Louis Li <Ching-shih.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 80adaebd2d411b7d6872a097634848a71eb13d20.

[WHY]
This change was working around a regression that occured in this
patch:
0301ccbaf67d drm/amd/display: DP Compliance 400.1.1 failure

With the fix to run verify_link_cap when the SINK_COUNT of
dongles becomes non-zero this change is no longer needed.

Cc: Louis Li <Ching-shih.Li@amd.com>
Cc: Wenjing Liu <Wenjing.Liu@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Eric Yang <Eric.Yang2@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index cc2e05003595..a09119c10d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -851,18 +851,12 @@ static bool dc_link_detect_helper(struct dc_link *link,
 				if (memcmp(&link->dpcd_caps, &prev_dpcd_caps, sizeof(struct dpcd_caps)))
 					same_dpcd = false;
 			}
-			/* Active dongle plug in without display or downstream unplug*/
+			/* Active dongle downstream unplug*/
 			if (link->type == dc_connection_active_dongle &&
 				link->dpcd_caps.sink_count.bits.SINK_COUNT == 0) {
-				if (prev_sink != NULL) {
+				if (prev_sink != NULL)
 					/* Downstream unplug */
 					dc_sink_release(prev_sink);
-				} else {
-					/* Empty dongle plug in */
-					dp_verify_link_cap_with_retries(link,
-							&link->reported_link_cap,
-							LINK_TRAINING_MAX_VERIFY_RETRY);
-				}
 				return true;
 			}
 
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
