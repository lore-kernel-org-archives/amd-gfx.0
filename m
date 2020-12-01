Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF0C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 06:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725342087D
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 06:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fDsZ7CgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725342087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 976D46E483;
	Tue,  1 Dec 2020 06:07:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DF36E483
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 06:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8i9E+Zn72GaM4Oa/EyR4lLNuu7oll9r/j9z3Fqn1Ekuw34865ipcAFlQDXxZ4bsjnbIqK9Pmj1Fy0hg65XRDiVgTmYwnOoS4DEPdW22nkA3P1l7aZPveHO5GQ/gaP8TQNmppSzE4tMFDYv8BowPPSpdci1EbH1aBbK22cc5vNx8kjs6b3kX00E8L0abxasCYTsXIenOYFqjhPMbreq8jXKA1i+aWLtrrCcP+jhg46hy59v3o3L0eqdtO0Pd+ow4LMSexk+J/mn6+IpynWiSK8hJvrQ3y9MApqH53oPyvUunQXHDlEx3BaqKczCYCqUhHZMTrwO/xtQ5iRgAJ37e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+zo4ga2zKSw37PvHoqxTsBD5ilbHns9+RIyRcybTso=;
 b=LLln/4kyFO3n1Wp6yshywpQjKORfphNOrn/77Y0rvtxFJr9owS6Sj/3CGJOehJNyjMabGf+hRV+f3VMaStl/bo75jdYvPCVDpzcFncmRzGGNViAu7M7G42OJyI1SyNXcTGVb7A6n86GzH4ft1npc3KoIcf+lMdwahhphBO99/LhWTRKRNdBbRTh66MRBHiMvhJ76bQchOWjMrcbgaCJ8g0c54A5shQu1RouKGHARWrQhEMkJoGALo2j7gGVeiYDaFcYfGhwEeQ2k8skDOybwOyyq7A5gH82FAdrZ2yqTYhbSWf19MZGu2Xjw4GWbelVCZ5Jl54uK9r0ka7evAD9EYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+zo4ga2zKSw37PvHoqxTsBD5ilbHns9+RIyRcybTso=;
 b=fDsZ7CgHm/xRXDMYqy9swbass5WtXPcGK/qT9ED17vR8LVU5iMi4hZ47zSxp3bNjADh5arPGVkgVs8i/8xMqPlpCjlQbzZ3crffSzLbwYao435yVWgVzlZC2IXLuwntNPyU5Jvk9Zj+e8Lt+EFNef7FbD+P3nxFWFjfmAnUxIWg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21)
 by SN1PR12MB2573.namprd12.prod.outlook.com (2603:10b6:802:2b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Tue, 1 Dec
 2020 06:07:22 +0000
Received: from SN1PR12MB2477.namprd12.prod.outlook.com
 ([fe80::78da:8e14:7541:fcb]) by SN1PR12MB2477.namprd12.prod.outlook.com
 ([fe80::78da:8e14:7541:fcb%3]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 06:07:22 +0000
From: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm/smu11: Fix fan set speed bug
Date: Tue,  1 Dec 2020 11:40:19 +0530
Message-Id: <20201201061019.12662-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::29) To SN1PR12MB2477.namprd12.prod.outlook.com
 (2603:10b6:802:28::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-desktop.amd.com (165.204.156.251) by
 MA1PR01CA0159.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Tue, 1 Dec 2020 06:07:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 389740db-2ecd-4588-6dc0-08d895bf5dd8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2573:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2573E5B6317E5F3F07C95BB4E4F40@SN1PR12MB2573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8wGsDIbUK7zO9ltYvMiGpFkWeUs7fnaxyALkf5OoFOACMWRysiPOF6oMRaBUIhM3ybJJFsSDIRJasJo27hkjDydyr0eHhTtHozHy99jffLLhhk+WbO5/gEycWWcpBB5CuAV06h8lnjwM57mt7dzHLu3Us8kTCOZG0u0cZmIfKYtELGGnzY/bq9iA47gEaY7ba6ZFL4jtpHCAyw15twOZXoD/whuV1rn+gKjEcvhbVCA4cANNIQdONy0kxvWKAYV43iC4X3t96V5GqAu4+R/Z97xtvCRBDTv3UYxW1gpR2YySdXJi3X51oonFFAPqgjFAdieZgUzv6OBAZ7BPywQrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2477.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(956004)(5660300002)(52116002)(7696005)(6916009)(316002)(1076003)(2616005)(186003)(36756003)(26005)(4326008)(2906002)(16526019)(4744005)(478600001)(86362001)(83380400001)(6486002)(66946007)(66476007)(8676002)(8936002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vZwGc+45gcTRmSQfFqS00MMOuz6S6IjG42t84d8Ye7vdTdW8VYC8unqJfQvT?=
 =?us-ascii?Q?iJDRkHNYAjH6S7NjrEFgodw7HEqeEw4HnmoDKsUvwsIG47AcbhFIJnjjuzNy?=
 =?us-ascii?Q?7QyywMm2qGPFnHyL8jPCwja39gXtBPhg943FSdpp1Zava5dxw/fGCnTGveAm?=
 =?us-ascii?Q?cnH+wdmQ33+hqAMFjGxsG5prYNgbe03WCov87Bil1i9/un0sw68qNkxOWf+c?=
 =?us-ascii?Q?E4JrpGkwaNTIO4LxFNHQsB2A/GdkRl8FOpTTUiiJrF3Chka72lcdp7gXFuRW?=
 =?us-ascii?Q?kVX/YYuMHS40MS7tuxMjZOLUt7XqH7uQqd19ZILqOvb8/uJMF6/qjFL6FjPQ?=
 =?us-ascii?Q?82C8+FxZFLHwn2iqkAMgrZcXEfrvgg4mKLN3PU5hqWN3FnLOXEjlrQTnSywN?=
 =?us-ascii?Q?OkafVspfRJhWbARsvoJ6hf/fL9NV1shJg8mbzFy/NZ39DcapmI4aJyEKqpRF?=
 =?us-ascii?Q?7Ybm3qjP/9kFnwg4PNSP/hnCTrx8bMqAMXaLb+a3FHswRPGG3E7pdtljUli7?=
 =?us-ascii?Q?pDuL2escNVjO8R6n1IGj+EdCC4vayBqbW8YQG+bFBsOAWjpmK3vuBvPxclan?=
 =?us-ascii?Q?iS8q4Pqmd+xZC5LNcVDfQsxuSJJphecm/5fOTpx3hgJ4psA0uS1UssfNhkLM?=
 =?us-ascii?Q?VC6JA11T1o3ntD5n9XG6SnAoyjqdDgcRmoeL9N1M4aStbENytVra9KKqztRL?=
 =?us-ascii?Q?v3i+SCFpKHiJHhVV6Qhy249yppJV8WuMphygyDB3r4/ZJbcCKx9e3GKSEzaO?=
 =?us-ascii?Q?eM5GiOG0ZZPTdG9Z41eGzdkdQFegi29X7pKu0WAcfWO7DaABrnkulx9Yibsh?=
 =?us-ascii?Q?nSM4vcXSTrLVrYb1rFuaM4rCs90g+/XNHDxw4uHQbmMhUuXWRRH0h4DeGUpI?=
 =?us-ascii?Q?U5QJfXgJebPAO408jWiP1/cBBylulIUW/Up81yZfOxBSsxhfXxcUa8kMq/sq?=
 =?us-ascii?Q?15ZVd/9KCzwGse6FWQ8wIlpX5VyMeeev7QqF7wkLcArWGAGW8p1HtG2LJ0+W?=
 =?us-ascii?Q?3ijM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389740db-2ecd-4588-6dc0-08d895bf5dd8
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2477.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 06:07:22.2050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ImxxI9cCZJdMGGs0uozKd+BkQOJK5DuaSfd3TmE0LSW+43aF40edNucZgpCVD4+zqDBNGfikWdYVOawd4uQVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2573
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
Cc: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix fan set speed calculation.

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Suggested-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 62c34a01a3e1..624065d3c079 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1187,7 +1187,12 @@ int smu_v11_0_set_fan_speed_rpm(struct smu_context *smu,
 	if (ret)
 		return ret;
 
-	crystal_clock_freq = amdgpu_asic_get_xclk(adev);
+	/*
+	 * crystal_clock_freq div by 4 is required since the fan control
+	 * module refers to 25MHz
+	 */
+
+	crystal_clock_freq = amdgpu_asic_get_xclk(adev) / 4;
 	tach_period = 60 * crystal_clock_freq * 10000 / (8 * speed);
 	WREG32_SOC15(THM, 0, mmCG_TACH_CTRL,
 		     REG_SET_FIELD(RREG32_SOC15(THM, 0, mmCG_TACH_CTRL),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
