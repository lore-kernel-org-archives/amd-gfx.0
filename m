Return-Path: <SRS0=/kPV=7S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFC3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59580206A2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2020 11:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="raxdODXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59580206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 327716E0B8;
	Fri,  5 Jun 2020 11:35:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760070.outbound.protection.outlook.com [40.107.76.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FB2A6E0B8
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2020 11:35:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQXwhXiNWpdRjQ9iDetXhz51ItpTsywFGGS/zyF5Zx0YdnvkF8uU5uMOvSYisuNCU0DuekqbCJn4FoUcyF6TDr8EnabH8m49zk81huKGKBH6Y4kZsfST4HdDUE5uKOmcugVd+fEbx5n9PrphqL8kSl2FRlUsm1CSIYtAmv2GIwFUIujUA75l0Io8v5G7F/regOHRNZ5hyp0o6Ph4UoxEnthfaPKbJWQH0T88hYe4yQEXK4JF6ihIrWUnvJQ3SX9cQHMqZv8jfVdblfaFnI8pY4n5BsSDAEbTtm/JCfFIPbRsLurVR/Dfed5cYLBAyRqqod/jByCmkp38SqTXRcKvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0VRAzcs7FwFA/yLhI6J5uB/v9X8755OzSUu6Td5XGA=;
 b=g8n4VPdraC0o7zEkkjYOWYIaSh/7gadZtBHd59tkTHDpIFkkFSTCCgmLQ66RZjviPdlpPWSegbprr4dm43F64XbevfzB0AMbUqYnnbGQJSacfTnqdrKK4mkvd8eN99hAoMG23KC6dMiltR5O8MoiQ24QlFx70w7YS66mHZYAFgbgqB+S9a4EmDP+ZYLt/xKWCVxhtuZnGVqN27WuoVp8aGBXrTc9WSSxE0UCk3QHCC4w4ZGj8yuiW/cOAg0sMH8pBuclB6alGdhgSZiJHLIp/AeOaWpVUNMUpu/SDYaqk537jOo1q+RT3E/vSZdDyp2Kjhk33lEqJtYIBhVLPM+YjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0VRAzcs7FwFA/yLhI6J5uB/v9X8755OzSUu6Td5XGA=;
 b=raxdODXJFMO4ekHc0BBu92vqcwi2jdKcH4YsEN/LTnR9kJCvvCYQbb0sCNNG/OimdYSKAHgYFNHpVTsfJipUb7MUqVyNrs4gO3HRya1sApX1XMg3lvxde9MojMyI3eonrCjiz4dfl9F8WnAenkgM7yq4x83vyWNDKbGlVkcnR80=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB3700.namprd12.prod.outlook.com (2603:10b6:a03:1a5::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Fri, 5 Jun
 2020 11:35:04 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::2c8e:6202:8066:9e8%7]) with mapi id 15.20.3066.019; Fri, 5 Jun 2020
 11:35:04 +0000
From: "Prike.Liang" <Prike.Liang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the nullptr issue as for PWR IP not existing
 in discovery table
Date: Fri,  5 Jun 2020 19:34:57 +0800
Message-Id: <1591356897-26869-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0086.apcprd04.prod.outlook.com
 (2603:1096:202:15::30) To BY5PR12MB4307.namprd12.prod.outlook.com
 (2603:10b6:a03:20c::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from prike.amd.com (58.247.170.242) by
 HK2PR04CA0086.apcprd04.prod.outlook.com (2603:1096:202:15::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 11:35:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98c4ca80-163a-4f55-4c1d-08d809447d81
X-MS-TrafficTypeDiagnostic: BY5PR12MB3700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB37000200A3C1477E32594F54FB860@BY5PR12MB3700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3rtbAGR3ZqRSDLHs+PVJgHcUWPGJTavt2LzhsNrzQwUdPAheZR6zZEAc8EuvDB/CffFOOgxE0ymtgoIOY9vs2PEriXRqYvLw3r1KjhLweJfxPFBXxwdrNPPOBiZ5B8X/rugSa3dYwfrZAIcWx0IB8B/ttscl3zQgODGxo7jnCRzgJ8+GM7OJNUeGyis1cNRjGNB9S0sCfNXnOX5LUJTYTQiiNCREUgbGg6NU1yHuRIeDZZm+//DEtjL6hI6qIR6P5XqSjAz3M59uLDf15D+DaNaBJt+KRzydcyvNoCl0idvaZt3ZUZ7HbZ3l0SWxFBDQ2d4bTwefsOc/nqWKSejtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(6486002)(36756003)(316002)(86362001)(8936002)(2906002)(2616005)(956004)(8676002)(5660300002)(26005)(52116002)(7696005)(4326008)(66556008)(6666004)(66946007)(6916009)(478600001)(83380400001)(66476007)(16526019)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ICffYGGsKTrfe+QvtL0GOYaLeje8UMLP/aZET5ziBTNmsmG2lWYr4xBtanS6NNkZ1R3QBi/wWtf9JJUsmIGo+UrkSPTuvBXgYKmHi5R2nN5O+JPq5gPWGRqOMixEW30EfN41Sc4IiiMmsVKaDXgGgZy12Dllu188JGq9v+lqV6mHBsUbJkZqdSwRdZ6/N8A2MVBEoBONqKdKCnjT9CaB1J8Emq/1oxuEYEh90XI4i/nHwI7eR82Mqgh8TFE/JbT3n+HyyphsprR/ahezhRc4vllGEk5afGTMl2ORkn9LC0FaXLRWuPeoRjgtybl/xlWvABgwofQ9k+Q6lxHJlf0POKVTYANyk0bCjjx5j4MVtmuWkXo4xVqQBRJUGdWlgY34sLr3tpaGkK7h2wiRR7+rjkYcql0BRWPJFvAwSuwQFlMVb4VLHe8Z4HHWzGr0c/meEAxNuHADXv6y5lAoU/AUrE+8S0aagIjC5+3160V29gfYGOdhdq+9KDbVV1LKpCyp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c4ca80-163a-4f55-4c1d-08d809447d81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 11:35:04.4561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKGZWD9xJEYvV8hJB/1CXIMv+CGhkXUJ+QYrqrbh2eCh7EaAktEtuS+jAp7bQ7sA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3700
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
Cc: Alexander.Deucher@amd.com, "Prike.Liang" <Prike.Liang@amd.com>,
 ray.huang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix e467ab869f57 drm/amdgpu: use IP discovery table for renoir.

This nullptr issue should be specific on the Renoir series during try access the PWR_MISC_CNTL_STATUS
when PWR IP not been detected by discovery table. Moreover the PWR IP not existing in Renoir series is
expected therefore just avoid access PWR register in Renoir series.

Signed-off-by: Prike.Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 22943773..6b94587 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2856,8 +2856,8 @@ static void gfx_v9_0_init_gfx_power_gating(struct amdgpu_device *adev)
 		/* program GRBM_REG_SAVE_GFX_IDLE_THRESHOLD to 0x55f0 */
 		data |= (0x55f0 << RLC_AUTO_PG_CTRL__GRBM_REG_SAVE_GFX_IDLE_THRESHOLD__SHIFT);
 		WREG32(SOC15_REG_OFFSET(GC, 0, mmRLC_AUTO_PG_CTRL), data);
-
-		pwr_10_0_gfxip_control_over_cgpg(adev, true);
+		if (adev->asic_type != CHIP_RENOIR)
+			pwr_10_0_gfxip_control_over_cgpg(adev, true);
 	}
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
