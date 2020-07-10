Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C125A20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1AXpZh+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C125A20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8690E6EB69;
	Fri, 10 Jul 2020 04:48:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 959B56EB67
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYcLBCfGZ9OQNvSIAMCNL8qM29IivqQV9tqrUC142jr/yYol9dIDtNJ5eSSX7o7g0BuUElujpKvTsuT5aomBgJzhNHJIc6b/lsUGYJYzcRt8wqN/NkhJYFDc+E1yAImdTF064NzYYy73FhmhdsnbdirQSviDZ1538eXhOSCCiQQMWgWcsgvV9g/FqqsgNXKWDd2vQcrAo1PZS1pI75Atf+Qz+CMq3ecZ4Zi4+44JBpWETyloA4dA9oMAkklhlIxXl9nDAfeEsbaa8a55zkm+mGs/MCcFQB/y84aJknwE+4p1EOXx2Y6nnsa9D0eOSQYY43HPjvyUJV/eedyzpRaLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EyH8nmhvgG95q/cEgUQyXPjXCvlqfN3uU6GnofzxUo=;
 b=nlHfouk42VlwNecwjZoR+8Y16m/sSTlWfqwdaGeXC5a5u0FyO9FGDyKyHYZACgceDdkb71A4NTHp32cZ82mcYOtB53wyv9RghskXEdrGIDZITagvTvnKfSV62BS6FJJjQ/GWWDVCVpzqMq1yh+9N/BMyVfMuijaQEva3hlt3WC+m+4ukXNZiFq8Pib195Qq8XIcyNe/r2ttqGW+ngJSrgoO3PUZ4ck/swMfVe6RGchw5JgryCdPSQn1FkvGZhNUcOc6TnDgnIY1EcdrYxrOWkQJ3TVMjqjSvdsaFIm+tmSomm3eQgcQCtPVAyJnJoJerX5GU93dLOOKpr4ITjmLYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EyH8nmhvgG95q/cEgUQyXPjXCvlqfN3uU6GnofzxUo=;
 b=1AXpZh+wmE/a0Pgq6lWbxkbr0QoEZVL6FLOuaNaCWHmPlxqMXI7Nh9kICO7wotke0M7t54DmhMgmCzHz30giuzt9qfGvgumBjbRYdi94duCGCUhZU6QrHa12axc+xFRf6VKzeIdSUt5uZBJjcRc01m2jf8oOMOY7RpOMfu/p04s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:19 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:19 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/16] drm/amd/powerplay: add new UMD pstate data structure
Date: Fri, 10 Jul 2020 12:47:36 +0800
Message-Id: <20200710044746.23538-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:17 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aed67bf2-5bb9-4f47-d97d-08d8248c773b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360EAF5E756F4A3D0AB04C8E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtv5TVPuUsJbTjrnYbiajwEjOtPvAINe8/aXZ55PFrYIP4WkQHTP4NXDD7azMs1a40j/m83eYQ55CkMa60CibBye2gHmheZIWsENqkz5s1UR0KuU9G6zaxCh8Z5eM9a0aU3sIUgZ6gMKlEVlPJ0qD5cdqIO+HWFIWjMkTEn/hYJN1qJWnPW7zwt1k25pYnTxFAicuEAk/o4XcmWgbnDJ7wFU6Amvg6bph31YljMvhSSWi63i89jdl0y/zEqOM8YF1NmLKxk/mpU9N58NVkY/bo32ZMLrlKG/+Pw89aUYgcZKNbGptyk9ac/IOBlNG8S8b0YIerK+Pkbvx2ccQ6gY1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7YJDxzvjNtzfGFz5wzPvT6sNZ+CtpIfplzVF5mZ3g6Btqai2mlIdW0V6orhb+5j1e6adreCc1sUWzpxE1uF1m/2iVMBTXG/YO6OI3cSKazaSzm39QzAlWQPi+xHZcYG4fN6D3cZTDzMSeAl2rCI/ES5CegsCq1HRUYAROmoZ0i6KQRYCN3NtydnWaHi0DvTCHPQF11ntbG6xp6NC7jUQOsF9oJBIJYu6k0lLEAGcAH/Dd3QjrH1TUPeAqhU4xVuPq/T4wgFM4i/yV2mc6Xv31Yk094HncLgWjjLSfuXXIAGYs3thnwj8cAHBqJ+Gr6PUjeF5uGBKl1/ZxIEQ954+BPRrM9mdIskXSrgclN6EIOjaLOUnOrseeyRY+SmvUHOFCZAQKAUtQdOKbcbc/7bOIg6krRew/4Wp8UybU2nmHrKGc6xWFTR9LvvH/Tb9n9beVHBLtFM1iJiFK60eINbZYWUdySWDvA3/Aqyayl1MasGlEHx2u3K6exWtLtI+cusb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed67bf2-5bb9-4f47-d97d-08d8248c773b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:19.1795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89/E45JsnB9GWfWd8o8dn0928VDEHuZLsOHKpYOeOG1kCdmhs0UUg+x4b49C75J6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is used to cache the clock frequencies for all UMD pstates.
So that we do not need to calculate from scratch on every UMD
pstate switch.

Change-Id: I3f2ef5ee2e6e433518f726988bbe5970848b99c8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 66912884f093..91c8b69da026 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -352,6 +352,20 @@ struct smu_baco_context
 	bool platform_support;
 };
 
+struct pstates_clk_freq {
+	uint32_t			min;
+	uint32_t			standard;
+	uint32_t			peak;
+};
+
+struct smu_umd_pstate_table {
+	struct pstates_clk_freq		gfxclk_pstate;
+	struct pstates_clk_freq		socclk_pstate;
+	struct pstates_clk_freq		uclk_pstate;
+	struct pstates_clk_freq		vclk_pstate;
+	struct pstates_clk_freq		dclk_pstate;
+};
+
 #define WORKLOAD_POLICY_MAX 7
 struct smu_context
 {
@@ -376,6 +390,7 @@ struct smu_context
 	struct dentry                   *debugfs_sclk;
 #endif
 
+	struct smu_umd_pstate_table	pstate_table;
 	uint32_t pstate_sclk;
 	uint32_t pstate_mclk;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
