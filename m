Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06D9C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70615206FA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xiv3DQT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70615206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 241F96E075;
	Mon, 17 Aug 2020 10:35:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A316E075
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 10:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPTYrpyodIwgi7797kt+LXrbmKx4WK/QP0yE9kvAgFMtfVEqZ1qQP3EBi+Kvy8qV1F2Lq3V0EYK7pgsCTKyL0siPgg6pwxeG32OJ1BdDAIxJALF/WU9vwcEzdPuMPkY+I+4rkhMrRsLqQh2dK9ElGr9A4lXpvTHbicAUXi8rkyxqQB1yvZ22jdPLMfHM/in3CwIsw6eURQpB1gGHkDOdtEPs7YZJCs+1J9heRyWjXlmemwQ8Vx41qEa9DwYT4QwDxCJbBN/SZ7paQ5aZBHMNEGtzQ7w6QbAWyGKP6maT7u6ccp771yQiGk6bPpZJEPR07QXkLUGaz4KcyqtErjsLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tpiytrrsYfCOC504qvZr/6SMDhiYJJPFAXuzoB95V4=;
 b=gb9UYaNRJqEnKM8nMY9vND4q9uu/luvfSsYt73hwJTPqwD6tnxhqVb43+dVDlP7+sbQCiIomku+eWMeV+9asVp7QE7Kyeihhm6LErDMKyib7QnhW0lhx72BTpMm55HtrCNxu5swD9e7jxC8x+QU9+0MCbG8aki2O2RzHWx4mSuuqGcq1uUuVeeZoHcVUFUS+I/TnKflluhbH9nPllnIYOq9N8UfBZ3kD0x9XwrZFuufxVhAOYtbdY6nAhHjRVFeRuCVCsMy0FbwpwcMvB3uKpxDFy4a/ne6eUMXa+G6m80cZLnENdsHXXXs4x7Z4ybWre0hlSbxn9R/2JKDFpvWGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tpiytrrsYfCOC504qvZr/6SMDhiYJJPFAXuzoB95V4=;
 b=Xiv3DQT/BbCtH0eYk4UvPGXBEJXGmgr3VN/hXOGxWNXSZ4Zyn4+CmEnU6Y5JHTxe2nIugOx02NUXj0KbpU6A0/TMIY2bbIsBOLdr0Nd6vYFO/RDAlXiyLClHJQTV8LsN729A9qLlK2unPmKYkBLvO8vKFPCXKKqgJuMtjm2NGtw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3440.namprd12.prod.outlook.com (2603:10b6:208:d0::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 10:35:22 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 10:35:22 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: add condition check for trace_amdgpu_cs()
Date: Mon, 17 Aug 2020 18:34:55 +0800
Message-Id: <20200817103455.11405-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0204.apcprd02.prod.outlook.com
 (2603:1096:201:20::16) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0204.apcprd02.prod.outlook.com (2603:1096:201:20::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 10:35:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85c78392-d46e-4626-ddcb-08d842993ea6
X-MS-TrafficTypeDiagnostic: MN2PR12MB3440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB34409864AFD9663137E1A958A25F0@MN2PR12MB3440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0cGUcQW6uho+gKNaBdW+sDNVhSqJJ83pxZp0qebNxNVAa+s7/j8sAI8qcQiQDcMkve/PLwb5co4MIAWRFig1cTo8o7lJsXbCEtyhyXs6EiwbjyDp3LKhRUSeBnwvh0DtdsiVcIDdgaftYUFo152HGRdO5G1tBJ/lkgB670pK8bZCBs71frboxia9UkeWDb1H3AVPsYWm3koOcwwrB9/45tOaqvtnK31A6ml7tPP1KqZRUP2hyOMZ/tB0e+l/HpUS1HOC+fovKizVe6q2E1BrNDVu6YVpWV6wIgmlpShD6bRyNtZZRwa1PzpNQJt17rOfXhG1OLhCyB3O5e2WeFD1zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(4326008)(6486002)(2906002)(83380400001)(7696005)(52116002)(478600001)(6666004)(36756003)(26005)(8676002)(5660300002)(66556008)(66476007)(66946007)(316002)(1076003)(186003)(6916009)(2616005)(956004)(8936002)(86362001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: nvm4v0IrqYsE6opIUg+FsYB0Yoxw/nhaPbPtVMbeFvLKi2170tLeJTKqxFt3Pjfx45rfuE4snU86x5jrNB/qBOZ6ksDc12+FPklu2F4ST5fJjiGqMWrdIfp8Y592exIp9ywfeI7RvDIB5HsZRf5CvvVOpEB60/XxVKvepGLd+hfaFN/8uC6UnGBDRmvLITVpB/rEwcsYuEk2VDgifRwCZFLz1hGOWoRoXT9331JSzKFZalXcFmcg8YSGonx/DhKpy8nQ2878Cr4EbXlhrufl26bWjrobLGZYJZxhQBICbQ/k2ZNqpe4tobnhPjpquBPga1sl7592R84c4yCR6dbflqS2Kw9AkMGCSRb7W7o3OJmkSId13SR3i/zIQ5sMP69na96Q3Q7Jgj773AekqCxKh/JpDAgRkxsKbICpXbxsbB4X0ll+4Pq3sIes+eQrhwbCsg2Iah9qJRqPoSD/ejln0PBtCh4VShGzaRgVoMxVL4zS1fE/EzYfHvLm6HDI+UNJ3D23+4tGP6bIVngUMgIhKzyuBmwaINqR1ANCN5Rw+PMbP1IwPeNK9Dz9Rh+fyRtkp34NqpkOer3onjmyCIy33i2NkEmG2G7qr/s/NuJVQuGySUyaubvA1fK3NkRLCRD3R2+RnjMFyVuKwB8B2uKaHg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c78392-d46e-4626-ddcb-08d842993ea6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 10:35:22.4726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UhvH/LAz3j0jKQ1H5C6kHeiuQp5XVppyb3yJhbC45+iRb4lsQK6OYU8pBSbd5gN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3440
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
Cc: Kevin Wang <kevin1.wang@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1:
add trace event enabled check to avoid nop loop when submit multi ibs
in amdgpu_cs_ioctl() function.

v2:
add a new wrapper function to trace all amdgpu cs ibs.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ffbcaf4bfb8b..1921e61a37b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1275,13 +1275,24 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	return r;
 }
 
+static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
+{
+	int i;
+
+	if (!trace_amdgpu_cs_enabled())
+		return;
+
+	for (i = 0; i < parser->job->num_ibs; i++)
+		trace_amdgpu_cs(parser, i);
+}
+
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = dev->dev_private;
 	union drm_amdgpu_cs *cs = data;
 	struct amdgpu_cs_parser parser = {};
 	bool reserved_buffers = false;
-	int i, r;
+	int r;
 
 	if (amdgpu_ras_intr_triggered())
 		return -EHWPOISON;
@@ -1319,8 +1330,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	reserved_buffers = true;
 
-	for (i = 0; i < parser.job->num_ibs; i++)
-		trace_amdgpu_cs(&parser, i);
+	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
