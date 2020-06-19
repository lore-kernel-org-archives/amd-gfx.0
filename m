Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D96C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9AD208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="loissMj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9AD208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C1CE6EB2B;
	Fri, 19 Jun 2020 20:13:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1BC894A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:13:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JB/rBasUwUJzVoKga7Btz9ghaAd1bKmNx843jLIhtRCZpSCOig7UCM/yW5a/FBmj1n6p2PrGxwl6CYDURoqJWKhnOYgN+VOrOJtiY/GP6hbYpOf2gjMBCsPFVyuwUNEZoghFVrPMdpAngAJQLhGbZAQGRSb7fGw4vixQn4PpuOgJV+RNC/j/Z09rHosbgLQvQWqQt4bqQHaZDF7jNIRN8LMGneBeOdnHYaSAGOI23KqctW13/t3bkC5NaRoAPuwdz3Pml1Mn+qqC7rfmAuGzc/FndvVSGgQKiuKF8co6tSe6KM9ptzWo1n8PhBVpab1Zd4DuKhtZXIm5CPfi93LCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz/ME6OZMbvj6JzgzBamNDMKlL3I+0xog7xCEpEf7A4=;
 b=OMTqIvrU3jaTVgvd3WFUfTZE26+ED4j/+LHAMFbtUdCZ0QdKS7zI6rhyqVmvmsXUXgxHRjV6ZlfD36+f4FhluaOJcL+noZHfxY2I1FCNrbPdwwg8peqL5S2Ald76FqXKlfIl8L4uXLULGhNf9qmhrvip46lIvR5M/U09Rek9jg2RJZvND5QRdcyyDMwdyGj5RJGN//gM4755XLgBi0cguMHMQRnXNxzGCnXkxG8/arA2VDWwc4qy3rfWTcKoT55EVpMy0lspuYI2tafD49FAR6DqrJuiE4Ohrz3vZa2x7zGzPdQ4M6H53sO+To5BQJzUOiHYuSBlJ0RG+jiAG7E0lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz/ME6OZMbvj6JzgzBamNDMKlL3I+0xog7xCEpEf7A4=;
 b=loissMj9WjwImMwI0GKmqO1pjqnkHg0QeyN7V0FtKMJbVl5FEl5Tcawevn/CAxNv5iLByn/wtp8ZcQXIA88Hogqle3O4VNUGqfXuuRNNOqPctym2/Rmr9Cu6UsGwD/XwdZY59GMrZ/jTOXiLzH7XKuJdOT7PSpd7h7RKTdF4R3k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:13:01 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:13:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/30] drm/amd/display: Fill in dmub_srv fw_version from
 firmware metadata
Date: Fri, 19 Jun 2020 16:12:12 -0400
Message-Id: <20200619201222.2916504-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:13:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: caa243e2-f670-4f55-b670-08d8148d2a94
X-MS-TrafficTypeDiagnostic: CH2PR12MB4087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB408789BB9B94A36B44191E7C98980@CH2PR12MB4087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUenxALuLLMDl9JhWeFVU7Y7ZIORIZknkB2vw3WpmchmSgCpuceLbhapLUCGGpoopniMZQF5gMUeSuq6BziqqZ0aZG1u6TYMOrQqlTG5kMDR7vO7RGBnbFPnJFrH8D2B9o43Fu+gAwW91/usw5Lg7Vr95e4dOvUQ37Z2BqEuTJjOTEWx3nUFIMQUZLx7KQg7dK2L4G0sYTGz2YJtlRKzvrg0KyJt5fKKHuaXVu6XQnMS3mWYnfPxivgr+sR+idalmKQhCxQzOAIW0ESRf+LVE+8P1DzckQtM7sGdgeLp1xtvPNBeAdQj/Nrb0kFnGzBQ+BoSpuGpBrJxfP7gI2g0CA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4326008)(36756003)(6486002)(83380400001)(86362001)(5660300002)(8676002)(2906002)(6666004)(2616005)(6916009)(8936002)(1076003)(6506007)(66946007)(52116002)(478600001)(186003)(316002)(6512007)(54906003)(66556008)(16526019)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jSrD+h2/2ZeQBhFC7RmiamJCn9IqwUl4LGSNxTMHj2Lm56jjf9K3jCSed1lQtC11HNp3iSyYMdflMODuHaQA60kLV7aE7svqLgAjZ7gvCp16vHVMjBoyybeq/04TcGAKjmonRoDZWAIYKiCIhbL8qyJz7Fo8bnf/V5UGc3Q8P9wdy+M8ejjGkmw7+165UDa1ZESfPceYN6lo1oBUovCe3KNNhEQgsz9i5+jirzfsIDWJ6ZytrCeLd8OuyRRMxyVMj/KpYRb3JE6m+pSxaKUSDuQJw8crkAAiZYYEeQbk2hdriJvDUD6SSRWVH+eBI4A125EsMZ2tJhXODs1SAkvQMXdP6xKMuKhkuGhoHn0yZmfHXR3xA+o57PphZNH86ybQ/d2qNfqzY7m+0mXpNEuO6398Xy+w8I2vn1oHwYiWzPE6oVg+UhwvKwGb35P458/+/T25rVKtK0ZLSAlqPWVHX9U46hJBitg1FnaBrAOMERM3li5qTFvjHw9u10cEA5UKpLojKI3UjVOVcLxRYSNOEQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa243e2-f670-4f55-b670-08d8148d2a94
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:13:01.2155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxY5p9hMEpxcVbrzx0KNl17RQPJnnwo1KpC8gGH/z59F1uJaVszTNqQhGX2mTcFwgtomtwEgsvagXCMJSsHtlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DMCUB firmware version is now available from firmware metadata block.

We should be passing this into dmub_srv so we can know when to apply
firmware version specific functionality like using CW4 only instead
of the REGION4.

[How]
We don't have the helpers for DM to actually extract out firmware
metadata block themselves.

We could add that and add helpers in DM to grab this, but not every
creation sequence has firmware instruction before dmub_srv_create.

Easiest way to handle this is to fill this in automatically per DM in
the place we do have it - when calculating the region parameters. But
only fill it in if DM already hasn't in case we need to override with
a specific version.

We aren't do anything firmware version specific in dmub_srv_create
today that does require fw_version, so while it's a little unituitive
to do it when calculating region parameters it works for now.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9c924994a2c3..aa41dfa23020 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -281,6 +281,16 @@ dmub_srv_calc_region_info(struct dmub_srv *dmub,
 	if (fw_info) {
 		fw_state_size = fw_info->fw_region_size;
 		trace_buffer_size = fw_info->trace_buffer_size;
+
+		/**
+		 * If DM didn't fill in a version, then fill it in based on
+		 * the firmware meta now that we have it.
+		 *
+		 * TODO: Make it easier for driver to extract this out to
+		 * pass during creation.
+		 */
+		if (dmub->fw_version == 0)
+			dmub->fw_version = fw_info->fw_version;
 	}
 
 	trace_buff->base = dmub_align(mail->top, 256);
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
