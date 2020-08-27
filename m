Return-Path: <SRS0=3ay0=CF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE90C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0157E22B47
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2020 06:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mB1tg3Yg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0157E22B47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B330E6E22C;
	Thu, 27 Aug 2020 06:47:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A066E22C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2020 06:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoetMSUynu9Cj/7RSQjsjFpU+GhsmAjkPAzrzkRsI+wKyOAaEJdOsBsOKf44jQQK6MXWimBDHeBoGO3radIY5MIj7Gz6H2Ntdj8TOv0+S4CKuXzW2Q300it02zEGDZnYB4T+GLREE69fDqh/SFT3rd2YUsQ9o7EAOpXWMHYkpBx1kQJyLAACfLGau5+iL7HmuWCVDI+FZZQOBDn+xyDdRa8rF3uGh6cZYqRiFHhVeYsMs/dAvUsDlcX+nyqoRGMfXsJYu9YlDTPvaqKpJy5xmCy3MRIAFl/NjhUrUyIWMvd3QUTajf78phyXL3ePciAk4QVOi9yIJKzhwoh2EBYm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRAkmS5mYt18NeRthq9di3lGsvS9MdHR/0W5V/u9knM=;
 b=fCK4wlqriIjXvBHMpjcOuOKdsSqkgoqRvm4JfdRJDShf18x/bUKhxhQ5DSofoukfGtvNzqa0myY3mdB/1M7IjdNoMgdmpdato3rMukyJX/HzkgZsKUzEnsxsDObQFvx4E2dpPZHaQFPLJzgcCYIe6eMbOXBBqYFAF8cFOeDyPjH10+nxITdxj7F62yvmevJgxxmvMXXNRZbIScShW6Sr8GrGP5Rr+WDrQixSG4tbpckFyrTFGZD3/Ol/jAgriTLGqFuq4vd8Fn+06RJDN3Qq2FyhKli7oe7bl7foMj+oCvyhjfScumxecPQg+BMOHVjnGKDk3DpJ3iJAlJJmn6eOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRAkmS5mYt18NeRthq9di3lGsvS9MdHR/0W5V/u9knM=;
 b=mB1tg3YgSyKddzn3ma5NLY4KXEeC2Os9pFcIpFNQQnvUomy863FAVlZGg0zo641Y0sjo+r5tnqOFLHAe/496ov2O4OGUU3Hxxvvqxz0Ng09mHBFNqtAK10YvemudgN6eh5anPoZZLIBXJfRSwg4uZ4cc5A3CV1jhNmvvEfiEey4=
Received: from MWHPR13CA0036.namprd13.prod.outlook.com (2603:10b6:300:95::22)
 by CH2PR12MB4197.namprd12.prod.outlook.com (2603:10b6:610:ab::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 06:47:27 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::3f) by MWHPR13CA0036.outlook.office365.com
 (2603:10b6:300:95::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Thu, 27 Aug 2020 06:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 06:47:25 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 27 Aug
 2020 01:47:24 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 27 Aug 2020 01:47:22 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable MP0 DPM for sienna_cichlid
Date: Thu, 27 Aug 2020 14:47:13 +0800
Message-ID: <20200827064713.4227-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 461302b8-7c7d-4ad4-bf7e-08d84a550ed6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4197:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41971577DADF5B0F8EEAB2BDEA550@CH2PR12MB4197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns76zt29Y5q9NAjim5+MlAisEkqdxJXfzwFLziQM6eqFZrJsLWS/4ZyAouWoqcDsywxVBRkGVCd9nU8SJjmgSjgeuBlkZB8edELqAcKVURx1hIYRPDHqkHiZxzcm2AfyVgPwW1m/GaxaM8Ejrho293mo5vO0x69910dIbRCNEDvdo6zDTNO4kFCp57D6L5tvxpAMMfBkn69f8BD30IYjbtWmO2XJsefpHd0YInxW0Nnfv5dNZYqgcyA2O3Q250WCILMepUkyGLvQvNhCM1YbCOZdpqSTQ9WC5+oQStqoyNrYuSxym9wWDSxOWxXDqU6Uy/kSzDDeu+0W54KidqCY74TGhJ7R9Fl1IhLquR+vrJVIZiIiDhk1NL9aDhI4v3q+NLePGqzpqHivthcdgegv/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(82740400003)(1076003)(70586007)(83380400001)(54906003)(70206006)(316002)(2906002)(36756003)(5660300002)(6916009)(81166007)(478600001)(82310400002)(356005)(86362001)(47076004)(6666004)(8936002)(186003)(336012)(7696005)(4326008)(426003)(2616005)(26005)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 06:47:25.2946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461302b8-7c7d-4ad4-bf7e-08d84a550ed6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4197
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
Cc: tao.zhou1@amd.com, kenneth.feng@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable MP0 clock DPM for sienna_cichlid.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: Iee6a05a634c200f9bbb895b963365bb001a451bc
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b48ac591db8b..b67931fd64b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -68,7 +68,8 @@
 	FEATURE_MASK(FEATURE_DPM_LINK_BIT)       | \
 	FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)     | \
 	FEATURE_MASK(FEATURE_DPM_FCLK_BIT)	 | \
-	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT))
+	FEATURE_MASK(FEATURE_DPM_DCEFCLK_BIT)	 | \
+	FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT))
 
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
@@ -230,6 +231,7 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_PREFETCHER_BIT)
 				| FEATURE_MASK(FEATURE_DPM_FCLK_BIT)
+				| FEATURE_MASK(FEATURE_DPM_MP0CLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_SOCCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_DCEFCLK_BIT)
 				| FEATURE_MASK(FEATURE_DS_FCLK_BIT)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
