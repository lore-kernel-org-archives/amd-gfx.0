Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87890C38BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56208218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u4Dmyy+j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56208218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EB5E6E9AB;
	Mon, 24 Feb 2020 22:19:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5E46E994
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 22:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9bDmQu0G0hv6UR3UM9XpqwTY/kym+ZJL1Jq2uF+3NTKXGQqa2/C2CbeNL7ZlS1Q2HgXu7DoOmbDcCPsTFgFvMqJDUUvuBidH0YGGbDkUhAQAnFzHOXyjUl/JwvgEwg+jp2q82yZvJaoamtpJZCGIdsizJXRiEPmZDTSQQgUO5vgTD1eB/UIIq2iHOlX2nDOcIEKAxqYUaPDL9zcovD4s5w9fldwKUmOWHqJvlSiS2064zerWUD4OFe4yQK21JFjEvdJReoTJeaXkiBS5mBHsEAjSIw28/iQWdsqyGcr8RYQxpeocxZb6GQUQoCfsWvBIZuLCI8fQr3aKLnfvFk9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g+7A21aLA9Vve6/ZkTOqCcKPMVIVKz7RqT2NtP31VI=;
 b=kDzpX3tQpM4V6HsiufR13K1np65ZF5nFy9XniPhdRUi5sFF92kleX4eXqV8z8ocTBLBUYqFNCPDyqrf+tGV7xCVkIgyhW3+w57gvCKF94mJPYwo+HdSME8pSqwtZvOR3FwK5t0iGvY+sjJkgd7va5txE8CIqMdiXUvRsuyyn8GPb2RRhpgPymss0uywROf6mv/pNEQAapz+w7O/LxRTzhnxXM819sHP5yNwVW0YsJYE8Q5js/Ht08VtpwD8AnFnjKuHk+z4zF+TvhowsRAwL6D0988pGghoOs3Gpb0KHGmeNSNpAXC0aEb0siU+Ur05L9pBS+M2QUv+JupO3S5gA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1g+7A21aLA9Vve6/ZkTOqCcKPMVIVKz7RqT2NtP31VI=;
 b=u4Dmyy+ju8mRqWNph/AaE0KywvcnkctyAjue+RtTJ4wSNZpWmqkBG/bipi1JH2cTWDZ5fhZ7traYSItfECpHsJwyCr+P4Py2wnjxXKXiOWpbMsx38bZtQp28lCTaZdsm0Y+Z3oxg+RofJlgFOjkvEHeZuX5C35MwDS1McAb4GkE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 22:18:58 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 22:18:58 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdkfd: Fix a memory leak in queue creation error
 handling
Date: Mon, 24 Feb 2020 17:18:40 -0500
Message-Id: <20200224221842.14110-4-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224221842.14110-1-Yong.Zhao@amd.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 22:18:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fa1ec3a-85d3-4ca4-d6d0-08d7b9778ac2
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:|CH2PR12MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB374947D9FCCA0988B65FD946F0EC0@CH2PR12MB3749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(36756003)(52116002)(2906002)(4744005)(5660300002)(86362001)(7696005)(66556008)(66476007)(66946007)(4326008)(6666004)(478600001)(8676002)(81156014)(1076003)(81166006)(26005)(6486002)(316002)(8936002)(186003)(6916009)(16526019)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2N2fM72RvfumBKOvcXqMKR54o13ug3v6S0uxLt/7aPAaT90YV1UUgIZVt5OtmJXQCsghYzuCcN11OA8VWmQO3YUEDmvzD8gQKW+UPE81HLQoXCm1DB5X8ec+WE/A87SSDSxH/INThgVWLvsVPP96UGP8SfudmN0p8pQIHGwMLz+HOZ8VmjMrbvNvPP5CS7TFMdAqb7z5tllIYTGdLGoTEhJiVOxgLY4L4QotjzwxD2OVOwa3/fCQGJFgeZ8cAIDzJ+JZPZxhhiYNcDIAEzx/lozwdyjDBzeqH6YXgBnuyY5QmXIhW4EqzGaSkb3IW8mTySF5KkIL6K6AP0jRm0158EprJm4DBIS+kpGtCQEfdXyquRpWSNcr/ZzfKMJPa0Woy0NGFKOq4Xw3CIf1dsO+1m9RpbzyiDffFnTvtdr0sMugEq5BDSAoQdw8r0nEOGfv
X-MS-Exchange-AntiSpam-MessageData: F0rGqDy9zErVUQlOFchk34X0ewOHo4iAPdcOF1v5OZwqJXC5cf+IZj1uVnMcEMgORtQO+ZNbB4JS19wLyf0E9UqgKL05KO1uysKTKE87kbk4yTpjepxfmsYJLe99JqVXIScXsIhqOcUyCCbUUQDnJg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa1ec3a-85d3-4ca4-d6d0-08d7b9778ac2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 22:18:57.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQffcSEhrUCcqclWOLig8Cbs1CFrxlbBV9rEtc64HK4add0dG5nxQP7qO56JStnA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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

When the queue creation failed, some resources were not freed. Fix it.

Change-Id: Ia24b6ad31528dceddfd4d1c58bb1d22c35d3eabf
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index b62ee2e3344a..c604a2ede3f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -329,6 +329,9 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	return retval;
 
 err_create_queue:
+	uninit_queue(q);
+	if (kq)
+		kernel_queue_uninit(kq, false);
 	kfree(pqn);
 err_allocate_pqn:
 	/* check if queues list is empty unregister process from device */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
