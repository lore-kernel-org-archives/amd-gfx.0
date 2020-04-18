Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEB7C38A2F
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 12:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 654B621D6C
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 12:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YtLd2Fpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 654B621D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 005806E0D1;
	Sat, 18 Apr 2020 12:28:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6874E6E0D1
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2020 12:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtzER2Co5tQmaQaB6UzhajoL/DSyACJmbkXjBPRAyX+qWsei5VKg7gVmK/mZaYfkHRVRDagzwb+I6CVe7HZ6wAPH1WW/ixqoYCqw/qwIpxV3WlrL8jdIxHxdb1MpvTzNbw2fyGZqGBToFPsoS5z9dmJwZ9iiTwsbESifrdmC2cIlESjlNM8ZsbY41/j9HqSQQpcPGTDOJgG7M/e/iGtAiVjZo9xDBu1e9fYRaROf5lSsAMKkwvz9Xo4HXmJ7Hmw7QWPS2w+VY9hbrs3xYEPIh9WS3VrNDCIbQOuFQXseze5ES1UIcBW/4oJpFxXCSuGpxflCa58gYASEeBJuMzNaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKQJLAC/D8jAZLffSZUyf+6ie2WwqOPaNlrXe7lnBMg=;
 b=GgEBw6nYbMhyY+TAIjPhUv3AOvEOj14L2C1uGit3t9w9pR5LMxU7ymv4Xg0wzE7N6DFiOveVayMuWQzyCRFO4pDCzDx3b51lVthu/OaWJHCncybKrF43pHZabVj6zgrFd0myTDOgANOpkykrQQfLGOvaDNFXRjIPTVvdXBZWHHERgg8bKE9r2q5IilaXUkxm34Lm3NM/Oepm+hBWm+whJJe53Y5qXORs1wAlaX4zdjjlWsyz5M6HxzDungZ34OYvh9YeHCU8MCcJ/mId4JDYBrZXWRv1IUWbFw4jJ5+y7x8DpVkXoIE3ow4J+asaeWNOdU92CIiCN6KPhpg+OyrRQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKQJLAC/D8jAZLffSZUyf+6ie2WwqOPaNlrXe7lnBMg=;
 b=YtLd2FptxuIpF8jNB8Fjb4F5R5Ph8AHwptu57ft2V033obarfeCldTJbM49WxxtkebwioE5zgUZvgM0sln4pY/SWTqRGnBKMKycmgyC2gjtuMI1XcskN+4nMej0yQ7ZIsrW0y8jK50SjjKFGmukXviHnZmCJ7FkwJWiWGOjbaUM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Amber.Lin@amd.com; 
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM6PR12MB3340.namprd12.prod.outlook.com (2603:10b6:5:3d::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25; Sat, 18 Apr 2020 12:28:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d91c:2026:e88c:812d]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d91c:2026:e88c:812d%6]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 12:28:21 +0000
From: Amber Lin <Amber.Lin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v7 2/2] include/uapi/linux: Update KFD ioctl version
Date: Sat, 18 Apr 2020 08:28:09 -0400
Message-Id: <1587212889-18763-2-git-send-email-Amber.Lin@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587212889-18763-1-git-send-email-Amber.Lin@amd.com>
References: <1587212889-18763-1-git-send-email-Amber.Lin@amd.com>
X-ClientProxiedBy: YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::31) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alin.amd.com (165.204.55.251) by
 YT1PR01CA0122.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2921.25 via Frontend Transport; Sat, 18 Apr 2020 12:28:21 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e424b515-15bf-437f-e6db-08d7e393fb57
X-MS-TrafficTypeDiagnostic: DM6PR12MB3340:|DM6PR12MB3340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3340203F42DB37A42D43C93DE1D60@DM6PR12MB3340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 0377802854
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(26005)(6486002)(2906002)(66476007)(316002)(8676002)(66556008)(81156014)(5660300002)(8936002)(4326008)(66946007)(6916009)(478600001)(16526019)(956004)(6666004)(36756003)(186003)(2616005)(86362001)(52116002)(4744005)(7696005);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8L5oQPW40OKSX88LiZHbIpZ4Xwm8KakiA1zKn3CmjQXzPIGBsdvC3C6+cOdWnkUT/H+NRYcSGs7+paAdhcPXrfRf9341vWEmMPabTX0a7YVF7jOpkLaE72QmxVZHohtPBSWY7qhdMk+mbq3/Re23l6JsdSWU8RiENevnGA9pyPdIa5i+qTXYvvvRrmP+twFCkLDbX4byhTYim03Zw/vSDUeLfIOBQPHvl2X9H1NpOQ7Uyw6Pdj9yHZcEugTdrta6Kwg32l81UE/IrriHyNC9j8X9dpb95h0TkR3MjjNdOxPJ8m85Yy4WIk8ubnp7LSOxZ6FRPIUKBXLV0wdm5AJ9EvQXE79jLt8nEgMeHkJFvCSve7+HAKlTUTL7b7FXCRpRJq+hJL5a0bvOUJXMMc7iaW9+yzJNUEl8omKuNNOgNIwAp3MVtFwsT49zikzbrqV
X-MS-Exchange-AntiSpam-MessageData: eSoUcGeknWsH09GR45eY0hYqqYZnP94xZv64iToAOGMYWtFp9p4dTk9/C84KW1tbHvH+3nTdmRkDk+bCKxnTBed19uZ5QNi1Aw5RrECbr8tFOCHJ5ZjhgQkSqsWNdLfAfLl+1PYQjzYwhE9ZAn4uVA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e424b515-15bf-437f-e6db-08d7e393fb57
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2020 12:28:21.5142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REi8YCbBZ/piMpCgEr7yD/ESI6xYxO2iFOw+hfQnXcCJw/Uk5qt4a9Og48/n1jUO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3340
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
Cc: Amber Lin <Amber.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bump KFD ioctl after adding SMI events support

Signed-off-by: Amber Lin <Amber.Lin@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index ad33c18..46adbcc 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -26,8 +26,12 @@
 #include <drm/drm.h>
 #include <linux/ioctl.h>
 
+/*
+ * - 1.1 - initial version
+ * - 1.3 - Add SMI events support
+ */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 1
+#define KFD_IOCTL_MINOR_VERSION 3
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
