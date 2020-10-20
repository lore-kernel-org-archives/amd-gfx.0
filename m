Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8173DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 08:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D3620936
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 08:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qwh5jFpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D3620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7096EC31;
	Tue, 20 Oct 2020 08:57:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BBA6EC31
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 08:57:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C++fXb8+ZpkB33AolKmDkwiSw1bzipPOripkCJv5y5Y04IahT5A+0nGfTXF1NxGIyB4kRPePTDlb5QhxqONKJBRpnHvp7sxyobuUJajzI/Yu5DuWVQFP9I475uJg/gZyikzXyX9gxe4mfkEaOaSBnwYqLDOJmifzKOqsAfroMBMWCfYMzjjM5YAy/dsJoZjMcbnaz+wicDTtFdWqm4MMza9q6SB0jr5vDt0ASWy5lGk2Lyg21jSC2YcYABnM54mK4eg7JSTnJtLdTapLXP02dkUQDHyPqwC+4xWCWrNl+KON0y4CrlmBFhjhdWYfst5Pb+ysfDzU/wSZzBUBqNKu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztl7cBXQMbAe1As8W61uULlpz+pDB5Piv6fJJdWv7vk=;
 b=DtijeOpBcH4v/BhID9xQjrvrMCwWIKil626a8LXLHYremiJIe2skZJj7O2ooZecS9ftBKIMBB7ikfzZKRWjiHLWtYO1B6uIybTUQlGF+0CuxkqrWwy/OShYHF0UiBu+kAgDlc8RTdQr+feRmvJXDyEtI+sSJqGUqUpIH1jIZyuZibBzuQaoav6MOy9KVGqY36Rxeas5jBbjlk/omDEu/Vpdbt0ZPvDgg99hiO/UGX8XimwWPiekixKAbtIAutfKfnSz+0ENa7UBiVS+ufupJyJhnA0lngcOCv5MOTGggsKPgyHGCquobPFAQxlR1aNax0ww5yx/cwedeLPFdcSzxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztl7cBXQMbAe1As8W61uULlpz+pDB5Piv6fJJdWv7vk=;
 b=Qwh5jFpCMSBN4jaUsRZd/N8h2gk7CW9UeLGJVxWDIpfXjTSXM0Op7mxzWp7ttZVoRslL/D0q4oIOWqrqroiF7+KgVnnPP0dQF/dqyMPMLSN+daos+vGCee2Wc3Tc21eB9DFgwTPQ5BlBhhqWYxFzWOa6MRvk0rvkY+xkCOH96r8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW2PR12MB2460.namprd12.prod.outlook.com (2603:10b6:907:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 20 Oct
 2020 08:57:16 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 08:57:16 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix pcie information for sienna cichlid
Date: Tue, 20 Oct 2020 16:56:58 +0800
Message-Id: <20201020085658.654678-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0031.apcprd03.prod.outlook.com
 (2603:1096:203:c9::18) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR03CA0031.apcprd03.prod.outlook.com (2603:1096:203:c9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Tue, 20 Oct 2020 08:57:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 494f5815-df3e-4275-5773-08d874d6247d
X-MS-TrafficTypeDiagnostic: MW2PR12MB2460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2460754205A2CF62C236A16DEF1F0@MW2PR12MB2460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NYdPak9L8+CE01ao/REcRgZ5A8l8+EhOuBh8qRKaVGJOSkAJOnmVUDCVDckbxUWBW764t6phoMOlCfbuch4BJR5PhHgPSNa/YqwizsbamrHczzisqDmnfLiLm6LfWGWVHOenzsJ6Rn+dyPfNJZG5jF/yp8sb9GficaIXQJguHhqIg8t60AocvRpFQzmLgpP2/ncnPgZ6awGOsNC+26UVf5AMEVU9NdoiknXxyj1mzWqYTO590QJlvEyjPADUUG7omlwAQw0lXpJpnPGY8Mt9Gm2GDlxCG/9PWvunIun+CwuzfUlAU80h/VSkaiU1AoM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(186003)(6486002)(16526019)(44832011)(316002)(2906002)(478600001)(83380400001)(86362001)(36756003)(26005)(6666004)(1076003)(4326008)(52116002)(7696005)(66946007)(54906003)(2616005)(66476007)(66556008)(5660300002)(8676002)(6916009)(956004)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: dAcUk+wn9d/RlXYwaNLcEUGIrxuxXpSfRpODgFIyz3RHsbjVWJacAmdmJAWjiZnB7Uf6URTO9jQJ7j8rFbgppCQUV7TshyHSpZ5elTS4EjFQDeFRYVbVkXrKgeMaMHL9f1Cx/jGhxv4tp3Qc81+Dxz5J9t7duZdWP83QNOuKdLur1eOoYhhnYrwlV+DgIEsLzwZ40LDTWo4Q6y7tYGOihwvY8R3YsWuINeWMoBxpB6NTvOhq+NuMmOVl1pbJXBUK6CFqbPGvROV3OzDVQsyX2AfkA6bwZdpIBHHIeHrFV5Nm3efcdD9QFJFhftLsH1RDcR6GVoSPH4WDOZGV3GHbXg/MpAfEBFXEqa/ZVS3NhZQloRs3bwHzZ7fyGK2FWlOO/X6TqJRugypV+zWKtD1VuqXT+xy4VlU5zAxNPRCSV+70sC4SBeAa3U18hPi/Bk03LzAI/8/NYrw6UbKPazZ/SqHjnW0INsvlfzAyVTd8QvVHzSxrFCWOgY0pGRlq+6evl/uMtcsXclEr4mxUxDIyXxKORYkdFEyFeTjBgne+GdOxiMTbF3GD4a5mluD3wHinqXK7DSd4SlOaTtyRlla4RMHJZ2f69JT9njuiNgGWqSbiPrysikVaMzW9iJQ17zae0urVsHNw9mu9zTJbLcv0ow==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494f5815-df3e-4275-5773-08d874d6247d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 08:57:16.1920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SWK4QVRa/0zwkghl+EY3j20cuf36VxX0Gar/FCbNPltonqDzt8Xcb4Yqae4UjF6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2460
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Fix the function used for sienna cichlid to get correct PCIE information
by pp_dpm_pcie.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I81e529be6e96f083eb7aa244c16700422bde5fec
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c8e8790e0871..e00c38b1bd41 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -964,8 +964,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 		}
 		break;
 	case SMU_PCIE:
-		gen_speed = smu_v11_0_get_current_pcie_link_speed(smu);
-		lane_width = smu_v11_0_get_current_pcie_link_width(smu);
+		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
+		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
