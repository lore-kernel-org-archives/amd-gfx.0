Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698FC83002
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CD220784
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 06:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SrHmSmoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CD220784
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AFBF6E110;
	Thu, 30 Apr 2020 06:43:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBA56E110
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 06:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k47PuUZIXKLd7B9PkG8T8EiPtrVL+as9N7tjSY5mSLRj9jztNXQi7hhW1TSdEiSm4piZXkXvUxRIsFOVtDcgKJQWYfoHEqiZsCnF68FSmG8Txx85oii+c1SZGL8ykqjq5Vwuzt4eMM7phOubthLeZ0BaOe4w86GwdfDehmM0winUk3EXPOda+2o7JY+HR2aW9GikY0ZCXg0yZj7fNTgEUL79RXiZJikJS4AuSpII1ts9Vb2FjV8QJUOODqWzEKuG4DG2d7R9FdyygGdc4PaIgkuWn77wRH3D5eKRMCWJQQ2s6NF6SwCpVa9T3vhpj1+N71kO7PQQ0PXKNMVlZqRhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JtgIQiNGAD3lMjzqa70OlfyqTQRDFVnUw5IFlsVibM=;
 b=UzFqlmy3gguxW82pqh1l28mqo3ikRfVlI1ZTcAR/tEg6g7YIfhjzOPhXQZj6Qk8jGqiKW9mWZZ2lPkgxgGe+rqnVRK65X1mPy/+0POQ41ov+GovZAMB19HCzjBRC/n449hP7nqQ7NM7QNxU2v75PGIkkN7rIPHJCZ26lWiQHsGMjg4uPv/E7SM+1gr5yOAYveJoUlNrBQCwEzvO9LYShpu3Bu0Qw4NnKaRjhBVhhw3zOZdZJWeQNVMZaReIJW9T5K/vC43I+T3PpGIuZJzwSD0B2au2f2ogIUHeFAhRQ3mN+nFz0OvAAALXsZSkCj71V8RvJSDr1zOjKhoRaqNec+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JtgIQiNGAD3lMjzqa70OlfyqTQRDFVnUw5IFlsVibM=;
 b=SrHmSmoB8IRoIQjWvsY2OGJFSs8HeuRGjSZbNHC3ENEVhUp7ibyLbGlwXuVanwoLIB2BB3axRzxCSHMhy6Cn1HH6fDE6y3V+2l6WAWqQaONdoj8DvsFWduSufZcDKFg9yfKy/SI/D/JZeW53HOUqEwEb//pNPsPnFMAOrrKikMQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Thu, 30 Apr 2020 06:43:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2937.023; Thu, 30 Apr 2020
 06:43:53 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: disable MGCG/MGLS also on gfx CG ungate
Date: Thu, 30 Apr 2020 14:43:29 +0800
Message-Id: <20200430064331.23502-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR0302CA0015.apcprd03.prod.outlook.com
 (2603:1096:202::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0015.apcprd03.prod.outlook.com (2603:1096:202::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.14 via Frontend Transport; Thu, 30 Apr 2020 06:43:52 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e1be876-e08c-4141-9ac7-08d7ecd1d918
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:|DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114A85F91D71C7FC3A573FDE4AA0@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MaWsETvw7PM3P3/LG+8BYYn4bQi+mVGE/7wVRBeIY9exh6tXHRPBCZByAYZJdTJpmBLzRuzcOhu6UKXBO6BQHeX5Dbe8/2c8m0yBJ9tRIYzumKIJIt08SEomY2Vltb3R0TxriUSy+J+Zbfo7oqCIrg3o+1BszmXHnTWkVKOSm/bkJ2Dzf/P0YPHkLeWF9ovPighEekHh+G81BqCtghHY5p1z1A4FHvNTXZFH79N5mcM52jf7l/f4BR5hNs4ecRI48kDjO6nmzxHm4ESMRV7tzPJk7dgifcna7448AERn1Au6805FILGCyIBO/b0lR7YeC9QNKlbBKV8GX58Aeh+G/xSXj/lNbMzU3KmKq5uO0FttqKXPvg6lxqx8JSkFLbia0ElSYXes+Ym249+pcH56rVypYYjPB97mpBCLjpXAp1cKdrSxPIqdiftNKwqUeowl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(16526019)(6486002)(186003)(8676002)(8936002)(5660300002)(7696005)(52116002)(26005)(4744005)(6666004)(316002)(86362001)(36756003)(1076003)(2906002)(2616005)(956004)(4326008)(44832011)(6916009)(478600001)(66556008)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: A5u8HGyqawgk1OBiJstfgsJFn8YsoVCB/A44skr/rXeZtJ0VzVIR0lIuuDqsBtW9EaSInKSrOioLIuDkcxb2p0jvBrssYb8Bo3NVqZRY6D+ZXPKj0lKQP0wG37Feugmq/n0vwOKCDnmJZlttJfrVptAw/EWMrOqMaXO/MluJ+U2HXcLlZT1xDtyfukqA4ImVQXqK02n+6MVW3s5tC+bTrHkZ2iqUP8UFSQDcpnfJI4nJlS6r0oNR8hYmGSXOcYtXQIs0hGIRBdIq8p1KE4p9OkS9ooeU6qJlgjcVTWw1yozsNvP/UStxeZgjQa2c2XPqx8tqxxzKnqC7vmxAeOvFYSNXDzYYR7rjNTsTZuxajhwb42Y54oEpTdrrs9gCQIPOQqSVFvJhDlkt4rrAtzC7m6QfvJ0ZaJSjV9gBTlfJMM+o2sgP4E/DScsNP18gJlg1H8H7FjWflhOxPOrpX4grpBgisnbwsac/1b6eOb/zHsmcEnoG7rIzMn3qOkr1HocHGyatUN8tjhCCOnGCPiNKG2K7462WDZh3rC4AUe4MzRMBaVrqqElr97wngZ3Z54A3Fcytlj0GJbrSiZxWCvoheNMMiWMaT5CG/TmAWoEvQM9A6QTvjbiPHJcW1GS3AKvIUsmHba2dU9erY8VTIVpEii8rIH5uAKBeXvZkyWnCyidjTXmmjvFh9LCAkFx6Bh4fNqKJjMRoLp7b1a6v9okVpiavwAyq5CInonnSj2R8YiEsRV9LjqcRkH5dvcnIO62S5xwhWc8Wm5ecMaGyegtkaYWo2u6OxEixZKozXvXC81I=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1be876-e08c-4141-9ac7-08d7ecd1d918
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 06:43:53.4770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFjIgSbhyI4YlO2eWqV0O8mOAvVZcShA+7agwqg4h8w9ThZYXUQlwC+ROeKJqBSZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, MGCG/MGLS will be left enabled.

Change-Id: I620c5a58b814ae4a0f6005bbc467d7cc2b6d0d66
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f059c1c546ec..5519f31b2c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7027,7 +7027,7 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		/* ===  CGCG /CGLS for GFX 3D Only === */
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  MGCG + MGLS === */
-		/* gfx_v10_0_update_medium_grain_clock_gating(adev, enable); */
+		gfx_v10_0_update_medium_grain_clock_gating(adev, enable);
 	}
 
 	if (adev->cg_flags &
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
