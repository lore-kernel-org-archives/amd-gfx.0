Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5279C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF1220657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1RkLxJ+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF1220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBEF56ED29;
	Fri, 15 May 2020 18:14:04 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700075.outbound.protection.outlook.com [40.107.70.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407BC6ED2A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O19YWn8/Bl2kpwLKHqEEY0V6Y2IqN+YPMMKKkV2SuNi+GS+ZpnboMiKyRgV0Dw+hjzbugl/JZLJSAV+OzSVxhodP/XwDi1aP/2WudQBDSW4yY+Qji/FxMwRPuvIHZfaGrIGeHESQvHCoavau/EvpuH8hNu8jgXD9pSWp0GG/TNSXahj8HklhXRSgh/OzE0DduxvLGji0lN1NRbHAZriHWVefD+q1vTe62CXZX8e0OE9UdJ2uF1Dwa3ZKZdCua084rkQfYyGXmzJoo+25c7tEv+BUM3kHqeU0uNpE0HGENPZiq2I1ebX/ltaMWRtxHUEDW+lRSzWgQh5L8uR+I3z0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eUW1UQENbvU4qifts1/rCArVD2jXLjsOaP8fEJjQKU=;
 b=MRXfMIhP/EZ9c690YLmdeNECxdhI0ZEy85xFqlHWpEHFz3WlT9tNTQkaRpJ+ZjkoCuOyGtAncNjndCRv6LVEzNtMg/7WF8ckrgIvteGORrjSUK0KAToe/G7CDqqV9B3NV7EtQ9tmmVElBws5b40Ciw7aPZ2H/3Cc66nC/JZfO88TbmFdrCZuG+atU7jnC4f+69XMjjgWMhaUGnuqMDKt0V9VvicuhQehZ5KsP7fr5soNeaLQPezwcx6ASBTna/SLYiLaGJ/Q84H4Vl+lACGRj7T1pR63bTd3z0p5tcAxAuQrnb2FxJWU51PoDzuf6v2m3oXuDvaK6VF/wi6eevRHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eUW1UQENbvU4qifts1/rCArVD2jXLjsOaP8fEJjQKU=;
 b=1RkLxJ+CTsyej4LGbFvhX2y0ls427vjFQL7Yvq6YMoBeB3t5JYC9mDBFKJrohedKBtFs24QxG3QqE6AAI+kOdGgiEVlf3vuLHh4DNhir2fq1tGC//k1P6J5xt0Qc+kWXyb5BsIZWQAUHbDezmI8RHUvUqEIDSSjjbeHq6C9AElw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3974.namprd12.prod.outlook.com (2603:10b6:610:2e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 18:14:02 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:14:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/27] drm/amd/display: fix dml immediate flip input
Date: Fri, 15 May 2020 14:13:11 -0400
Message-Id: <20200515181315.1237251-25-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:14:01 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 023ffaed-0cf4-49c7-9e63-08d7f8fbbed3
X-MS-TrafficTypeDiagnostic: CH2PR12MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3974D3CF8EFC5884744DEB3398BD0@CH2PR12MB3974.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JhS6jxMwVvu5Jo+11ZzAm6LC5ZFfs1GMBbAG82cdVw/u3FrA2Pj5jco4gBeoztvp+naCokjkAJty4mOobrdGywzukDdcG13/8lfOS5szaLEbudi2XHoYFaSpj8lC/ITry1cjbgmxK7y9hO7nKlVhAMYrVCKx9igZf+cl3UxE7xXhVI1TRXq+id1LYqhQtwVdUJ8FUd5p6xrWluTucBzmd9BLSRfggHWqBrmLL+j+4Cx/5sdqEzPYk0d11CqtFYOqGpN599p4yTT9+WH3CCWXcpGf6zUPFgNPnegIc+f3yslpZTIloI4PlGlFH39GDnZVdl73qKDQIb+OKA1FxlsR176g3ZKM6Inr4tB9sqfDaXtTgwxJMxrXEhQEGCGFowKEhGG5AGylCor4f9s1Ji4QBG6V1WJDPINbrGhPN9FhR+Y4MqsfcfTN4T071V9f/6lgqLsSGzvS+tRkj9AaOKqCR2ztASye6nQ0KhAogp7UUeOx4lLtRyJRnUZcI0z+8fAf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(6506007)(316002)(8676002)(8936002)(86362001)(6486002)(54906003)(6666004)(5660300002)(6916009)(478600001)(6512007)(2906002)(36756003)(66556008)(1076003)(52116002)(16526019)(186003)(2616005)(66476007)(66946007)(4326008)(14773001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: baK17KsxLoH1JcNpZp2aS/JUO3Sh/Be/CgZOr4hNccChXeC93+GFW9d4RKnIHCGFCiRKoItsgKjl5UVoXx+hW0Car63fdmYex6WIGoQYGHLVLzfOA4uyBdJKDC5kxBSRoYqniMSezt3yIKCzwXbObZOnUUHJt2h+WRBpyhod2np4L+mN6fYmfijMrnLHMCYg/vh2sAXQgEDv0RPS296PGyzMf1Rz3uT14R6HDk+FUwocrpaNZtobZliNvv8bzqEJ0BW9J/DrLD32q5PacBCE1EA0UKAwGKTFyO+TgZuYCD2p0Re34InOX13qXCEhr38GAogrQFmOzL9VYtSEC95QDDV4WEU6cTgZO4eKqrK6G90Cnu5XYtlQdb7nJBiHOJZvNDKMQwvIdJb5CuG4krZy5c2SGxfO4exJldDfIhwGcZr26NYwn5/KAqw3wHcsNMebYl+N2BS81eedLBQhu6o4ekJcvtmGyhCj7xr7iyShwbbt4qm3jD8xsyBAfyu0/8M6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ffaed-0cf4-49c7-9e63-08d7f8fbbed3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:14:02.0434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gscmXbhKLKij+tYt4TmsfSbur/C0FlunkTsVfvDcqOs4zu0LgTt7MHJ9lMtO9bzQE3Js9JsjrurfGkZrpZmJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Samson Tam <Samson.Tam@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Set the correct value to immediate flip required field.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c   | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
index 5baaefd29ba6..64f9c735f74d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
@@ -177,8 +177,8 @@ enum odm_combine_policy {
 };
 
 enum immediate_flip_requirement {
-	dm_immediate_flip_required,
 	dm_immediate_flip_not_required,
+	dm_immediate_flip_required,
 };
 
 enum unbounded_requesting_policy {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2d549736f9b8..7fc06ea1f647 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -385,6 +385,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		visited[k] = false;
 
 	mode_lib->vba.NumberOfActivePlanes = 0;
+	mode_lib->vba.ImmediateFlipSupport = false;
+	mode_lib->vba.ImmediateFlipRequirement = dm_immediate_flip_not_required;
 	for (j = 0; j < mode_lib->vba.cache_num_pipes; ++j) {
 		display_pipe_source_params_st *src = &pipes[j].pipe.src;
 		display_pipe_dest_params_st *dst = &pipes[j].pipe.dest;
@@ -635,8 +637,10 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 			}
 		}
 
-		if (pipes[k].pipe.src.immediate_flip)
+		if (pipes[k].pipe.src.immediate_flip) {
 			mode_lib->vba.ImmediateFlipSupport = true;
+			mode_lib->vba.ImmediateFlipRequirement = dm_immediate_flip_required;
+		}
 
 		mode_lib->vba.NumberOfActivePlanes++;
 	}
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
