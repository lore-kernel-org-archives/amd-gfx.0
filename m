Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658A4C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39947207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OuzNC3Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39947207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5646E190;
	Fri,  3 Jul 2020 08:33:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2A46E190
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpR+XQEIZDeR/k40HpWvlLdw19IcsSH7RpK7pJK/i7ov+WbiZIpQKzjMaqbjuHdbmoEHlKE/F9PWJRHJ+QBD3zBBAPfb6V2Csby79eoQXnbr3r8tWi7ExezmUYeEafg5LIBrpTUz1oEi37AOxGvR9ERpeEfhrV4jRH0U4rqXwU99pu785HBxZUYicW/r5doH/SJc/pj3R4fZFWbAlQeXeQ8GANUgUdfgO/xNTXS05xoG0DI2FVv6eqnP93dncEyU3ZjJpU8Jb31Fy+YrZYT/M9uns9J0RPcwltSTqDhQH5/y79yLgGYkV/Ipz4Ji6hptL/VnyPw3BI2zQGtWAPR9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXDyLpd9kR7uW9mWRCUD2hC7y4FQkbjU7OWO3xg5ZUs=;
 b=IufwRvy93KH0Soc/AmYNjmG25HCOO/NTIjZ6+uyjwHiZJUyaq1ENsOg6jPxTEvhk9QwQFlWjw3YHyujJgM5i6vSfMBveQFSDxvHNtelvRhPomUHW1sYDW0MCgBcTleIAwd+ZcTHvEc7eOlTHiMARg3SlIDcybmpTaqXar+xqA/g2Nwmp5Tb37eEHXFx9X/Sa8qk5KCaM8KPrXcnAAPFotYFSLDbykqPEUnjK2l35is2MSprT9Yc1/tWCa8hiUwnpKVts68AbqnOqDftscEOegAt56+k4GjJBPVZAyjM+ybAkGTFLNwzLOdNlTHIg4rH0zHzoA9rhc+csmwTPlRB3Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXDyLpd9kR7uW9mWRCUD2hC7y4FQkbjU7OWO3xg5ZUs=;
 b=OuzNC3Piu1rjDfRc0vis2Hs7sqY5QL19P8BsuwKU1vNDliDHRzIQKEKCfZg0aQliNOd9RbivQBPzm4KmZxPDXS7yzFyG6FVEDXpiR0UPE+jYC/Pn+ydLBsfPETJfzxUMlaGVBhZFqH1oHpuA6PanBiviTJ6PAWhfEy1DtESCLfQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:45 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/14] drm/amd/powerplay: add new UMD pstate data structure
Date: Fri,  3 Jul 2020 16:32:54 +0800
Message-Id: <20200703083303.478-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:43 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb2f7a77-1327-43d2-d9e7-08d81f2bcc7e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3962D1EBE9596B336C7F0674E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XgBjNIKAcZTpR+Wls1Fv5hgFX/WK2DnDl6KY/l+NJzxwscGlEvEu6gq1pnZWo3CAKuTokXPvsfzuBssJ0xl1tB/K78XiN0V15i/6yEQZOVVI+KFAzFGS3pJ4t4Du1EigA/nyl3zlXhBq4FwkbPayTOB5GOzoTfBJRFpNUe7AMlEaK2aPMdt7wRPKoOQXc2KFj86IUIiHQ0R7FcgwPWdxivQN4oLjxICh72ZyXeHbo87w0EslHnVOZ8TgYVVsPdonH401+wLd2buqlEN2GzhKt2297RrAbdJYIOyvrVhi76gpkGN40RmUEhUT2cTsLNEBMJ0P4Qi8VK/1IJgbZzJNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BhmCV+zTsZpOs4qAl+MCsBGYeZS7EwlXZ8zFitxdPgzIfwXh3YKDbH/hhN7YaU0Zh46DeUUP2z8TUxK4JYHK+FQ6xCxqjynn/B8/8V5GfUypVUfio0lLWWm6W7/SuQ8JezpRVVWcTym9RS2ZI1kTTfgsfMKHnuvmYflv/20Xn87hlPEHmrRn4Lj/PSM0QE0g7CRZ53QWWf+9bc/pO+v5+Sthk2NygkYbvzVb+Vd8dXi6pFyaQ3JKRDyaYbgqh+U3sF9PDW49EIMPxtUHiHCtTykXxiuEH5MBRUNRC8F3YqtEigm+0WYBKAbsc3wY7y041lxvQtEIKl1ZOgrpyFsABSijtsufZbuZJZtZFTvEYORazbucyoYhlwljcBxPDo89iUhL1xNMtGGfgcPAx6HtpLOc/DSkBobV0ZTLc4eNH8e8GvqIe+EGUTP2eZBehvQDyc7t2Jjlpz+s0EUOMDg8+gn6p6jO5VaEAKFy/84NHyVeA0VdNl/cT2hwOvgT9bSn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2f7a77-1327-43d2-d9e7-08d81f2bcc7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:45.3522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vhnyx9ROJBXexbkB+upBV9Q3i7AUjNldYWfHZf4Yxa8zlvjx+eL8PM3/JZ3K4NZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
