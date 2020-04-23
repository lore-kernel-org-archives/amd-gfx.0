Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A567C55186
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408D420781
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MFFzEuJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408D420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DD26E418;
	Thu, 23 Apr 2020 09:02:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E496E6E418
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 09:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErS+RuOOmad2BAOiP+YxXumvOZfw/OJ+B/kmKNHi3aZyehm/aUACJTmGLEIqkxNHn4MvfP4LbhFqTKTkm7SeQgKbYsjbe6LJJdDcrZ1B7b9STMVch/BTFAE2VQxoQfSVhZr3TcAHsQeCU/TloYxiTWFipEbZhEdahXVyBP1TNzL7rQwzB1/bTVwhQmk/appbTNowpvOMBvn9aE9wvaShyqh8Fmyo8Rnm6cFRDuHqDkH8OMkFmVY6XcZnqteouH7et5EnbNajFTFW0IIJA1m4Jrb5mkdBdao3aL3OZt7Fbf+yoeQnSQwN1pkmTCIfXOzElBXZXG91OggDgDHEXvpksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYE7HdgvJWqRIxywP4PX0wUBMmmi9BcyMGLGcMzFYQ8=;
 b=FmzItymvjjSAvXhrcVYAtwOyffNpXFF1UiNRbB0d8c+kNdPtpMf4oszb1rMKwpPZFKXJaafGnRiU5SyHKFcPoojKJKHK7BzDRucRhl5KbgPHUaU5R18kZo8vnwkB5kwdPWh/ekc5TfAdQcmbK6P7bpJ4aXu9XMiMnefexjTK8z+XYI87sY929FEYH8STWFqUj1oXDI+1NYq7MUYPCywcVGzrnFK1kq7KxU9yNVogEThjnF/UplhMlOEBqOkRdWu5+ITMM/gcQ9eucgXQJZrOREZQOkmA6yDacGdjhG9lw2AFG0DrUvGMaplK6tx0Xzbe6Btsv/O2PJmoRqwM5tJr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYE7HdgvJWqRIxywP4PX0wUBMmmi9BcyMGLGcMzFYQ8=;
 b=MFFzEuJ637mVtDBU5yJDwEl+gUXCBr+amyBAsXPOPlAEruFxJRxWGEfMOSLIn4qLDLQ8zx8ZTUfTjLPQ4vQyW9zlBaXxRN9i1YRH0wLDGHFkHf8seVceZHZ4yylkQno7bbhXMcwctUKMvFlhH4oPyRZaKLivfpC0PpnI5z5bCcw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Thu, 23 Apr 2020 09:02:04 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::50d1:ecd6:255c:fbcd%3]) with mapi id 15.20.2921.030; Thu, 23 Apr 2020
 09:02:04 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: stop cp resume when compute ring test failed
Date: Thu, 23 Apr 2020 17:01:50 +0800
Message-Id: <1587632511-12504-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HKAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:203:d0::11) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (58.247.170.242) by
 HKAPR04CA0001.apcprd04.prod.outlook.com (2603:1096:203:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2937.13 via Frontend Transport; Thu, 23 Apr 2020 09:02:03 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5c2391b-6b1e-4c6e-d6ba-08d7e764fdf3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:|DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35148C27F56EBF7EAF5E76C9FCD30@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:747;
X-Forefront-PRVS: 03827AF76E
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(2906002)(66476007)(66556008)(4326008)(7696005)(478600001)(52116002)(81156014)(8936002)(6916009)(8676002)(5660300002)(36756003)(86362001)(66946007)(186003)(2616005)(956004)(6486002)(26005)(316002)(16526019)(6666004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KlzY63wxcMRLTkr+CGXq4glxiieIlan6nLdloyy/SYT1w//Ye0zUlP18g+2CmO0zdvHjOdnliTNN+2WySeZ4nD/7avJnLmNGPqej0kwFibUzwosLRtufHsNMQ01BGAifgFwHsLrAi1GJeDwDdbWPFIsRk2dXPipAPpbhTMn+bqL0g+B9fdjf+t6/qxh4nu0+bUVsSYCRZORx+OQnCsJjWjQj8mKZ0y/vYtJl4H5BnVPhDhna1wu5EgGG1g7d0P97ujRBqG5GmoaN8adJawZOp+AuCQsgldnvGZqUSWPdk2ch5whLk+S6QjyGMq5LI9Ohaw7QXyQLK8gu9Du4vLE8GGYYYeqwSXkQpGguSCvfkOHoccwDFAjoFP2AQyZ4qwtERaPZSdixnfALhVCOrCkzMNSWjH/kB+qg8kP8aFu1WJHIL1SSafZWJYDtD1hofhbe
X-MS-Exchange-AntiSpam-MessageData: Buj5xYsa0oFkZM0fxN0w+7vUS/609bV0+m4CDki2ZD2JjnHArnH8G5xWv00r+xDiR/tiyrg4GSjYBeAQ7G7IAAD4RTudKiV92BMQ1o+GVDoiinxxTV0BD47dP+Xp/eN79Vm3s+uQupLyuJ7u/oJzsg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c2391b-6b1e-4c6e-d6ba-08d7e764fdf3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 09:02:04.2244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yO295v6LIRDSjt3EOAfClJ9Dzgq7tncm6F9wk/5iOU4Mt3JCcuwH93prdA0rYd1/IzLtAYKfIyGyYjntDaL+vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

driver should stop cp resume once compute
ring test failed

Change-Id: I4cd3328f38e0755d0c877484936132d204c9fe50
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index b2f10e3..fcee758 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3132,7 +3132,9 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6c56ced..8dc8e90 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4781,7 +4781,9 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 09aa5f5..20937059 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3846,7 +3846,9 @@ static int gfx_v9_0_cp_resume(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	gfx_v9_0_enable_gui_idle_interrupt(adev, true);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
