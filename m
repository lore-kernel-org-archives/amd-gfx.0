Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0DCC63777
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4D1222BA
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 07:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e9MD7EI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4D1222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D816E878;
	Fri, 20 Nov 2020 07:59:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75BB489A6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 07:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI41w0SDBYjwq5kxbpPb3Z4Btw/GKVnE+qUu81i5LCNicueelVTOQIxhmObLZmK0UkP9/7cNgi7rWmvvuHarYsk56rr9Nbxe15m/l+PyHPEA+nvce4XyXBj+0kXGm206UAHtiBcjdSBvySEPFpMiwF2e+XWUZxAXcDNb1HUHd/OVOLemNUt/cZ8xrMpKbb6RyXWihEcoBL2jWXUK8gq+im6jVk4plRmQekOSpz3GKnRByCl1o62rgR/RbsGHxqneHoeVB4d+I2Z7A1YDIP+ef9wm6qajxNBN6rn36DrI/Y1jTCNg1F9+GKVnBsRayLyqEOGQNmqy0WeCfTdKnohnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p48TNBvjCnbtMiZyr90l3WTwGLUV342MNHGK1pSH5kY=;
 b=LtS5iMwvb5cHuRmc3hS4c7wUdd5u5aom3e53f9vM+6QTQqNV7oigCyyLO9X9hjBvWAbyy7LHG5vHtlvND/Lghll8eztEZkiY8wiSpGQbwMxPALMWFs8+LVgwwWXVtQceSq1R6XWsQ0MbdfUoRwwVAnvU9Xsj7F7zVPp9yOGsMs5Rdx1KvuytX1dSnymxqB/qFZyoJi/OhAwvmGjspQ0/Ea4ILeybXxqSWIgX+/QKflHvGmZ7A+bSZTCwWE1Pxle7mQ/1zyv+NFkO5kNb3O01zLS52+DSyZnUC0byM8OEYF1VFY2MjDyxkx18OeMuB6GV1BLB32zqHuWS2BmNbEptcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p48TNBvjCnbtMiZyr90l3WTwGLUV342MNHGK1pSH5kY=;
 b=e9MD7EI34nir0ASUdFzJUXmydk9eiCwiZ+JfInZAy4lAPC0erOIPiE+vV9z+Gf5o10OJeQa4sDKuqTzbcNSPLF9y3oLlOKhhts5Q7YEVheR6CCazis3CkrF/JUZZZhDCoxF8vJ2mWj4s4yc7LrGpgfehS8A0AK9pmno4WOKhkWU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1374.namprd12.prod.outlook.com (2603:10b6:300:12::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 20 Nov
 2020 07:59:49 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3589.022; Fri, 20 Nov
 2020 07:59:49 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: fix the crash after runtime pm resume
Date: Fri, 20 Nov 2020 15:59:27 +0800
Message-Id: <20201120075928.104191-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 07:59:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8b2aaf2-cff9-4e8a-5cf9-08d88d2a40cc
X-MS-TrafficTypeDiagnostic: MWHPR12MB1374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1374313026BF0656748ECA8EEFFF0@MWHPR12MB1374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 34nCol2E7kGApCOKjb3/dE46QiCLkJ6UfVEJDtmcJ4+mUNkVLua+D67AFy+YU/UsZkydGE3SlHIxNrBMeUifsgYhUG3zl3wSFPswZv7KtXQIrA3IWxJuCW56i3zQgiOAc0WzOjgTCSwLvZ4qwequAJcBnbPKOfR+gWFAwsztaVpMwrdWVA4Z2Dmobb/QLj5JrWjL9jxHaBSdx7/bMoerxMELwOW1RgfTCpNw+Pb6zlPIQJnbskQCDekG+7YPeiJK0iYhm7MZoHxftKGHze7n2IdlBEuid1B/d4B2vMzb0JObI+q9p6ewbZMYU/SSXSIf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6666004)(36756003)(1076003)(6486002)(4326008)(956004)(66946007)(2616005)(478600001)(26005)(8936002)(54906003)(316002)(2906002)(86362001)(16526019)(52116002)(8676002)(7696005)(6916009)(83380400001)(186003)(66476007)(66556008)(5660300002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: XxIbRBext+t4/+CXURI+Mtd7OfZrmVlwk7SdhOkovlp64nya0SawX6tKuxjsq9673nLZapOMYXYI5MWpP9jge6Ka4MZSodUsTVQ7FdrHKTUP5nyOSOWnu5oTOwIn5AuCMwZNR0fUuUr+bCokOn/n3dTGZbOy3puxqTolfDDIE3JO3vnEfMYp7tZehNc+ldVWzfCSQJ0I8eUi0hddhit7rG8xNIf4VTrfPfLAkH1ZBvBQoCjwnXTIyNUczg2rVQWfYF5HL0ZcqiTtdzrPxBoXMxqNps2OunTF1uVIrirdIxT7To+jpkZbvX9ZFIdYIJY+9Xqj0iu5Ep8PrajMtLgL5T4DtHbL7krqMj1Xc330EZC8galAHGZ9Uu6DrPDIkmxUTOKAoY1HtGmm2wAitBMser/av/DxPSHMGWdhjqa6PjQ05JFuUuCNYUeQoqMCS64wkqWUYsO54SXBu9xtnW9piFmJVNqNp/OubvSeoqjJwdO6MPfB0vHxKkNnOuTPr+HABkgTkX7E0WLaNQl1uecwv4MLzVVLRMe9tv0ZhxpdvzWjRazU0hchckd5c0b3RL/ezcH3ZyHSWEj5xaAyNuWWXiolwl80pzzqUcsB4vImyzZRgW/GNuBBmQQRr2aYDpuIxskrMBrL7JTyFDj5uTX7dhUHUfdNnoIKdd/302HV55J1rOmeIkwGFws+n6f9XrbXgNpmw7Rtv359i/PHu+G7YhJ/OpNA6jPxuTEPLsermBFHu+uoclXqaeIUIKtlbeacjF+4oBDohhMMC/IPT6I3FbDn8lBVZIpLiW2BofTd82H4y0C9Kg79UBwewimIUweQN9/ZKFH2aRMJwBEb8BBr62asRAAXH6Nmsvd0ZUTdnCSBNllOytzOoM4WYxjuSLzTreub2HNSATZKaoXbPIAkqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b2aaf2-cff9-4e8a-5cf9-08d88d2a40cc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 07:59:49.5869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgP+AdbqwHj3Z0t9zGjfGW+hY7qr+7rg9ldP/WNcDpeu0xdt+lxKZW95w/WPbJEe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1374
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
Cc: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Some features are still disabled after runtime pm resume. This can take
the hardware back.
Unlike other projects, this doesn't need pptable retransfer.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: If7c4148380ddb8a08aed06a8ba9afae98075947d
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8e3e7a5bbffe..17a36a962e31 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -918,11 +918,15 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t pcie_gen = 0, pcie_width = 0;
-	int ret;
+	int ret = 0;
 
 	if (adev->in_suspend && smu_is_dpm_running(smu)) {
 		dev_info(adev->dev, "dpm has been enabled\n");
-		return 0;
+		/* this is needed specifically */
+		if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
+		    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
+			ret = smu_system_features_control(smu, true);
+		return ret;
 	}
 
 	ret = smu_init_display_count(smu, 0);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
