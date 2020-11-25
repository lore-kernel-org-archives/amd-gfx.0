Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD582C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 03:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C0820782
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 03:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mw1a4Zfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C0820782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799BA6E81E;
	Wed, 25 Nov 2020 03:17:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8D16E804;
 Wed, 25 Nov 2020 03:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOOOoWZuGwVgs4kTgsUu5P2q7w9aqxirPuIUj47p3rFHywhlHmkE1als+apX1iniSVrTHgoCxBRwClKg15MGpH5sMzOItVlL43l8fNbtD0s4pVzIH4AO6mBVEEJiAcHO9JXZG+13WfW7KPlOmK/K4VqL+7fHM5bcXUELxGzZd3kyOKCFROgEawK0WYTRqmND2r5WikatNAqyikBtbdVZqWvwpDzO/sgdei0MuRzgdb0KJHTgXR3P/acsonv2WeLTaBZ75MWrP1c/DxB2B2ODDJYpB/kE7VmfSxNyobqEJLxhLjJBUoqVbGdArjYXPEML0HIh3LBox8Cpcaa40dkl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irDAko7tiw2V76O5X4hq1K7zJmz191u0PyZWj3aSNUo=;
 b=MAO4UI4ceImN+1VdAqIGqZK3PrWQGY4CsrNFGtOHyYvUQu795ntfuiYRqjyYGGw+mPuTsP/G2vgj42AH8CAXW/ZGMxHRiPfQdEf/6cFeVyLaOF1e68kip1CYeGcit2fVbJzBWYFz8ecneYugwmlvGHcJk1MbHndsFeuOQBTfGaUAJMyHLzt7JnofS2mFbUnfD1Qsthsdef4jlhdXp+qohIKaHEpUaId1PnLHm5b+TZJXP72VHv8cYgd7fiYwPgOC0upDFnO+TPCmK1GNOqFWuHpnb+wDveXi7HMWiy5DdCXrJQqSkcHZa8FRtcO5NOIAq2y7eByduGQaDW6JoDWLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irDAko7tiw2V76O5X4hq1K7zJmz191u0PyZWj3aSNUo=;
 b=Mw1a4Zfvoh0cxPFAKIKNOVM06P0ZDYzaGPqzmG291DOC6OS7ozz4Cw4+5DMN0JKgnSmLPSo3UJU44WkCg6u13ka7XOmKK6ZLyoaV7kxu/cvhfF01w5cnPAkZ0A7BIXo9a/MgE0EaRnJcFQ5aMaw31fJfD9hwUH5KM+l9BM0qRGw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Wed, 25 Nov
 2020 03:17:25 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::d055:19dc:5b0f:ed56%6]) with mapi id 15.20.3589.031; Wed, 25 Nov 2020
 03:17:25 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 Alexander Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: Don't hardcode thread name length
Date: Tue, 24 Nov 2020 22:17:07 -0500
Message-Id: <20201125031708.6433-6-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.29.2.154.g7f7ebe054a
In-Reply-To: <20201125031708.6433-1-luben.tuikov@amd.com>
References: <769e72ee-b2d0-d75f-cc83-a85be08e231b@amd.com>
 <20201125031708.6433-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: CH2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:610:59::36) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.55.250) by
 CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 03:17:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29f24684-d1af-4a20-8c58-08d890f0a1a3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2507:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2507E33955396D286ABA7FD399FA0@DM5PR1201MB2507.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TA/7WeSXPtz+pqVEujgbL2Aidw0KIuHLZnYaf6A3jan47QpGZxFx7B6DuV3MBXrWTSsv3kwL/h38woEEOdJANQZ8qnb325DG2g16sEdeZ83T8Qf7A1AxAjbYJx1MybnyBqgs4/IAQZgq1LiMe3Tl0ZEbkIzhyEuHWfOP1P/roDrE+IPrJOon7aRI1Pj4+O4wALn41zJcQzGK3Swdm9m0ISZ45cFOkJ49d8b+cCPNC54tiiRI9pz3TSBzc5RrEvF42VLSLu85kYpNJB1zuBX0FMeiftdgRrTZnR31KMBbhNPA/gOxBDiiKUrBQWo/n20Xkte21WRre+t/OSPRH8X8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(7696005)(6486002)(54906003)(478600001)(26005)(52116002)(8936002)(83380400001)(8676002)(86362001)(2616005)(6636002)(5660300002)(956004)(1076003)(4326008)(2906002)(44832011)(186003)(66946007)(110136005)(316002)(36756003)(66476007)(16526019)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ffZ48DDh5uYz4RjyJmXv7GwN/mugrIzzubPXK5w6DYVgH5+MPMYa6Y3tYHlsp6O6GR1p9ymqrH9WL1hcD+Lxs5zw8cB0zXfJmg5wSC9JU7/lU/C7ouXYDHIgeNTRrVbjJtsD6mU1YljecQ3l1+XBIG8R8KDxtbeF+vph9yAC0/pvSj6V80oXkFQSyjI2n7JGVrpmPFZ3PkwofsP+caWu5RxfEKrCV2ClQ5lVYQxLAvbKk1ecXVdn/W/MAyFK9NNI6NtB4wzsibFt+5vdPgAWkv3rUeTbWY0pmEwzNQ2qgFYq0Jc29AQXuKj7HGTRtO0+WVM6VYRY3iLkjWWOYUfJBHtsld9toqn2EUtvtxAchwvrNfs+rHFEayJF4wuhPypkG7TS4ffIcJf4PqDlE1wauaWZTq1G3sYxrEZXOkt0YqPXXgDE3uM1ipTTNwneRhgDrpN9uW40yHo8ILotqErDC+O4r/lIucneoaSo3IuJ1XB9uoVrmz7sNl7zn350Ktz9kUi5Z85zK9Hb4nL5WgtTIGyFie727NVNk2M1ElTChvW9nJXDaOycnlaLH9PoXCD0luhUgKtMAgkSRsyhKnYCUfBbSzPM5Bx9J7cP9OxO+kyl1p45qZuGgA6qLJxKRJkIytpIRzKY0poQUCdVy/z2DJlIL0EeV7mKjFVFjvPM08DM1wAume4ci+QxIbT+Izgf3xpJFly9mqqKXPtZjTSdSycwUZvydADxXYEq2+Hl/MBVFdB2I5TI5QZHJATh/DYTVpn+WvxpOp2JY3PQGeZ3Jf+uqgmNks5Guvj/8CcHy9gu/REnMkeqVTBDNgtONALQI5EXxWQzPXVytNSZnXxf3xvWZqdC3Cc9M4hkG8dFE+sKoxyNChk+vvaS7q9/xqGcCyvekbWo+F4tc9jJgQvTSg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f24684-d1af-4a20-8c58-08d890f0a1a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2020 03:17:25.3404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyK/P3uSIDUI8dBx27cLc25Fn1z20HnE8ywVhC+FVUAcdS417DRlu3fS05B/8YdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: Emily Deng <Emily.Deng@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 steven.price@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce a macro DRM_THREAD_NAME_LEN
and use that to define ring name size,
instead of hardcoding it to 16.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 include/drm/gpu_scheduler.h              | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7112137689db..bbd46c6dec65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -230,7 +230,7 @@ struct amdgpu_ring {
 	unsigned		wptr_offs;
 	unsigned		fence_offs;
 	uint64_t		current_ctx;
-	char			name[16];
+	char			name[DRM_THREAD_NAME_LEN];
 	u32                     trail_seq;
 	unsigned		trail_fence_offs;
 	u64			trail_fence_gpu_addr;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 61f7121e1c19..3a5686c3b5e9 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -30,6 +30,8 @@
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
+#define DRM_THREAD_NAME_LEN     TASK_COMM_LEN
+
 struct drm_gpu_scheduler;
 struct drm_sched_rq;
 
-- 
2.29.2.154.g7f7ebe054a

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
