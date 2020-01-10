Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BD5C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 19:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB24B20848
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 19:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BjKNDwaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB24B20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7950C6EA91;
	Fri, 10 Jan 2020 19:24:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477096EA91
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 19:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkEc4XRDIJUh11OBWeXVSe+HmJLo149rO/MRUNrds1bq0DNNL9SQRitUjh1T5B9Y1MBbsfI0n4dnzRjR22/badP92+i+j+8kYH6+tZcCCDgyAfqJKfi8876zBQYDjCz2nDHTzcOzM3otZWvA9CUWtT+/q1ESodhOI5I8hRvLseDBb0yZoZbKt4Ux2LwlBks8uV9US5Sgq+I/4C3OwrvJ6jCkhK4CeB8As3O/J4p0WZSocHWTdshkoLNg0riAW7wLl8yoVy1mUnOKlZOP8CxLysyHgxk49GYCI6D/eEW81mt/4vCUqW+NP1f3gLxxDRiY8AI9t1/cAvcpOlbldFTWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/GAOJecOFLs0EgOVDou10unxVLqHovMm9bUBe3llZ4=;
 b=lGrB0/cdzjOCdiEHxWgd1hFQB7y+0LSXgH40CXHs+OeWfKdY4L/KLPNtS6F5qRrFa366zgJnhBL4ZtHXYkz25AHp+yZ5Q2X+tOxigh5tIs8+NV5j1ulrI6mAdaloYoG4kaMHEslBR2SdEaJX3/Z//PDNNwtENHBE6We1cDdFIK8RuiBzMMbv8pw3gM4okwUWHazcQ4Cz4cJmyNcYaq7w6I6vAGbe9vbmExuywzxb33JwgT64fhVI9mNqF7KVOJul6rLXPmYLgAbpfDdYrwT2ZG/uSMFqlcd4bvtWjfGb4ckyg1f8znib/QLDsI4SWQo3BvXaK4H2E5ibWe+ZHd4iWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/GAOJecOFLs0EgOVDou10unxVLqHovMm9bUBe3llZ4=;
 b=BjKNDwaWXvlA27KsCxwLRDV8od0iWdDsfEWDxOe7IA3PVnesS2uLhHAwdS16VFSvD2YMx71JO+Sx6pVE3zMbYSiI/nCpUFiQ03qK2BIl+289S3sDcGhYw3PFcsw8wf2PKGu9wqIxXYVXFpxGupdb8z/lyGmMipB6QU1SV7373Fc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com (10.174.106.18) by
 DM5PR1201MB0106.namprd12.prod.outlook.com (10.174.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 19:24:40 +0000
Received: from DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877]) by DM5PR1201MB0137.namprd12.prod.outlook.com
 ([fe80::b54c:16d9:d613:6877%9]) with mapi id 15.20.2602.018; Fri, 10 Jan 2020
 19:24:40 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add a message when SW scheduler is used
Date: Fri, 10 Jan 2020 14:24:29 -0500
Message-Id: <20200110192429.5146-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::24) To DM5PR1201MB0137.namprd12.prod.outlook.com
 (2603:10b6:4:54::18)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Fri, 10 Jan 2020 19:24:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed43460b-0ec3-4510-5af3-08d79602bd21
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:|DM5PR1201MB0106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01067FB302BA785BB6320C70F0380@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:404;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(4326008)(26005)(66476007)(1076003)(66946007)(81166006)(4744005)(66556008)(81156014)(86362001)(6916009)(36756003)(5660300002)(8676002)(316002)(8936002)(7696005)(2616005)(186003)(6666004)(16526019)(15650500001)(956004)(6486002)(478600001)(52116002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0106;
 H:DM5PR1201MB0137.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImQ9G0D9VF1nh0Q5MjC1iGn2MCusOUvyqxhNqApeYk6aS14lrGjxMZj8pqb/O6JgjO/hRpjabq1cuP1mEs3jLMXPa7swp7U4LXc9KZ0bIdEtMTPvO8STTbzikOn5ThlpdrfVhgkCjevFbYw/nYSCnAPK0hoDKwrli4oo1mTaZfyRijegeVexHaSyIdJKftOwRvGUQnUHKwT/P2SZbAonhetMaao1bAcBxZR74kBlbE52mX+tRvg+I0fs1Nb7yA50p5ad4XbM7O/Ty6qON4Oa/ycjivTK9Ycl1IE5g70ol3XSbpm7JWjzvQ1NAStPZyv39eW6zHM6vu5WMI+5kZRRcusnlotZfSLzN4WpXFuTjhnCgphu7uwzSqBtSCu3Z37wrrE7XvjLD+pO5qlz1SrGPecSz49sIKOayjHdWgzqzzhVIVZMWqMAAK4HRwyZwYXz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43460b-0ec3-4510-5af3-08d79602bd21
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 19:24:40.8563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hah34gzBoIkFM/FUf05EQ3xltw7azpBVisVRTU6CazjzWOudwyNQElSiL5U6IvrR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW scheduler is previously called non HW scheduler, or non HWS. This
message is useful when triaging issues from dmesg.

Change-Id: I625518c88c043df5f60409d1ca520e7fc032251f
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d7eb6ac37f62..2870553a2ce0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -934,6 +934,7 @@ static void uninitialize(struct device_queue_manager *dqm)
 
 static int start_nocpsch(struct device_queue_manager *dqm)
 {
+	pr_info("SW scheduler is used");
 	init_interrupts(dqm);
 	
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
