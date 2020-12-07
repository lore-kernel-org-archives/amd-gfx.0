Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF766C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 10:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF202310B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 10:06:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF202310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1999189D66;
	Mon,  7 Dec 2020 10:06:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2093089D66
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 10:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/PMt7l7h4Mp8X/5vV/jzbe+4EHh78lsYpjhXTvP3XS0saNnkjaeZsdzeZJcm77uuREPXHrGOz86SifVIh7w76kKzEvmc6KMVMAp6W6QWPcSMq02bwrknHwJzlBYVZYWxaapOwboliARxscLf3oUTrdO2EyrPE+7BK9tKgcXXR+SzzlgfFml7upaz4NEzGHTDoO/KkEvm2y4bF0WagyQ8gBSLP1k4Hw2tsnGTtVl2AvvOxDW7QsUy8jm3XhBhBR/qKX8VDuieqIBkKknFcvA1NMn7N0/QsycmdJsJ1FknSfqfX3F2K8g3MQrAKZxu1vgiaZF3BbzVGzcSohlTNMkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnzjKhVLqd4hJhcRnZ8z0J1JmpeHgpAziNikymBwu7U=;
 b=KchVPpRYqApZPmyexalQ0CiZx3C1qpR5xJOQpO+PUIxXaiva+27GKH/7iq3qTa7sdgSlUJCKW3QAap1T9LRGicSehC0sy0UAKnceCZZ6NKQI86mhUpanrVkyWlVRB6eUdna89RWlWneVerX3j7w2uHoPCsOAqgN/Rf0OIrKSPJ+LqqT7E0epqsj9ySUSQtgDRUmDW9WJCLUIuLw+RazKZUu+8Spvooo0ycELv0aH/k3h85fJIxkalS7XogfriXDSiWc0N+vqFqn3lxQ8ElV6riCw3L3h8TnP99zp4QKNFa1sIiXwh1KRRd5G1vv9pG5c0QELE3IEwAv2Lvgm+yFELQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnzjKhVLqd4hJhcRnZ8z0J1JmpeHgpAziNikymBwu7U=;
 b=xTE8iCyXm3gpinBaOosKyDEYB0H1HkZQ41enuTClT5PouSMVI6i6V7NNIOnPQJ6vOMd4Bs9o6ZR0imygBkSzovi9G+8Emy9JnqTchbRt2jtfLCpN57gLPMdfIRAX/kKjYsReAaSB7hWaQjb626WHfGdPJ5X0lH0Tfccvgl0Hzfc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3222.namprd12.prod.outlook.com (2603:10b6:a03:12c::23)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 10:06:45 +0000
Received: from BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::9c89:cf2f:2184:1b16]) by BYAPR12MB3222.namprd12.prod.outlook.com
 ([fe80::9c89:cf2f:2184:1b16%5]) with mapi id 15.20.3632.021; Mon, 7 Dec 2020
 10:06:45 +0000
From: jianzh@amd.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/SRIOV: Extend VF reset request wait period
Date: Mon,  7 Dec 2020 18:06:23 +0800
Message-Id: <20201207100623.1353365-1-jianzh@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To BYAPR12MB3222.namprd12.prod.outlook.com
 (2603:10b6:a03:12c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jg.amd.com (180.167.199.189) by
 HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 10:06:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2891f77-9f72-4133-e05e-08d89a97cdbd
X-MS-TrafficTypeDiagnostic: BY5PR12MB4949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4949CA03DB2EA61A9694FDB1E1CE0@BY5PR12MB4949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jriPtRtf2XTo0Hrm/GUnTp4djiAoFKGisk2AQvLf7bkbE6+ACpRPhH00/XT0Qt83weUHND77rv6NH2HBm8/dAo2ThFFQ6rfOeL/0yVxck6Rg5CRQwrx3v2qI8G7NtRix+OcnqRBEHN6MgQvP5FeZfCIy9CVLPNhSO2zVWK2veTaF90XegyBVMCZ1Vxt/fTYTSJ6e2CikS+e9uHtGcw0ENdi+ZbcQcwXBWdRjCdcRyCZH143C3G6i2pRTe69FHdoaysoO5lcgl55ZEgzUgZJcybZ4Skqb6QOom3WeWxiQDsiGstJCHZOP6/i6Qc71OhOU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3222.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(8676002)(8936002)(2906002)(16526019)(478600001)(6916009)(186003)(5660300002)(7696005)(66476007)(316002)(36756003)(26005)(4326008)(2616005)(9686003)(6666004)(66946007)(52116002)(66556008)(6486002)(956004)(1076003)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Lb3FqrazTBgGeURFtq6+K+bKOMH/R0HWy6nGKLPNqyT5047Qbbibmb3yj/LE?=
 =?us-ascii?Q?B/7q2EjY3N2fZbrExQkCHT3FXsq9tIObw2zCnjUPMpggs35cYZo4voscOlcO?=
 =?us-ascii?Q?ryfApnycqKCmfhDcoPTLC81+lraPCUchgfN7WdI/zOMOV9PClzfHpv6YwGoT?=
 =?us-ascii?Q?5R/cT6mPRRdQ6P+P+/h6kUv7dPYloVrRM4a7ogJTlrP+yPz7Vx/r97kRgPL5?=
 =?us-ascii?Q?OR3DXhHWfSQXUY2jpWvnRHj/vuXVGK4Gpeq4mst/reFiu/3s8t6/J8y1Zz6Z?=
 =?us-ascii?Q?OwLsKD5xtz6XUfkpeLsdDZuDCluqgtw41tmovpS1Vg0a3YY1zDV+v5TUh3zi?=
 =?us-ascii?Q?pjckDrgZy6CajMHLaiE6OC/KulDPJbhOsz146beWhVDKM/wIG2aZaLX0W33I?=
 =?us-ascii?Q?6mqUKSaOliC09oxXhirEogCRcaH6aDyNzgSFoOK5OmLSZgseTQs7mPwKO7BT?=
 =?us-ascii?Q?XXAWPJseYe2ZkkKK7TOiBlrxoZY5D3PJIYk9VOaA8RKn9ZLsxZ3+p2ipzsmB?=
 =?us-ascii?Q?4i/7UAhBTNot3itvRPstLHATgjUesnCDq7oSZrrkR3BPnIfyclD8F208kYis?=
 =?us-ascii?Q?ogGrPrmb4KdsHfdtF1r/dweuj2O6GRymbojuVXysZyonws1lEE7iONBLAio5?=
 =?us-ascii?Q?xod4UXX5M5R5WQCxj3SlZdT7jIvHxJsr9o3nxZ5PGjlpTTx9KbNJmQ9DRVcx?=
 =?us-ascii?Q?7ZRAQtU+1ekSvBtv61TSjTYmQkIr5ud7QWvuhmLYhoriX0fIaQ1CWdBvvfpb?=
 =?us-ascii?Q?3ubtAaAwvwrfhcqCCl859VRS2UG/qj7GGFZq7JboW8uqZtz0B8JDDDEAuKQ/?=
 =?us-ascii?Q?LcfQHIepZl4wTS0jUrA/bw0K2kskVVkQIZOKJu/QmEp5l/fedD//4g3Nv/h9?=
 =?us-ascii?Q?ICHdowkT1wVF7pbzmuzUceIU8gn03JVnV9MG3k4rFD1sNvrsmnlAKasDxHI1?=
 =?us-ascii?Q?XxLcQdB+qzfa6QlMGsY3ngCuKeL4CkBzyU3DGu5186lpcf5lcl/MZEOhxDfX?=
 =?us-ascii?Q?ZLcx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:06:45.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f2891f77-9f72-4133-e05e-08d89a97cdbd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQmmb3bjttyCrPSLaE3ttfqDAEsgoHTzm0pXaNsZnGrdP07qt3bKAgFI3Ll+TgQv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
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
Cc: Andy.Zhang@amd.com, Horace.Chen@amd.com, Jiange Zhao <Jiange.Zhao@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiange Zhao <Jiange.Zhao@amd.com>

In Virtualization case, when one VF is sending too many
FLR requests, hypervisor would stop responding to this
VF's request for a long period of time. This is called
event guard. During this period of cooling time, guest
driver should wait instead of doing other things. After
this period of time, guest driver would resume reset
process and return to normal.

Currently, guest driver would wait 12 seconds and return fail
if it doesn't get response from host.

Solution: extend this waiting time in guest driver and poll
response periodically. Poll happens every 6 seconds and it will
last for 60 seconds.

v2: change the max repetition times from number to macro.

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 11 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h |  1 +
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index f5ce9a9f4cf5..7767ccca526b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -187,7 +187,16 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_ai_request_reset(struct amdgpu_device *adev)
 {
-	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < AI_MAILBOX_POLL_MSG_REP_MAX) {
+		ret = xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_ai_request_full_gpu_access(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 83b453f5d717..50572635d0f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -25,8 +25,9 @@
 #define __MXGPU_AI_H__
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
-#define AI_MAILBOX_POLL_MSG_TIMEDOUT	12000
+#define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define AI_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define AI_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 666ed99cc14b..dd5c1e6ce009 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -200,7 +200,16 @@ static int xgpu_nv_send_access_requests(struct amdgpu_device *adev,
 
 static int xgpu_nv_request_reset(struct amdgpu_device *adev)
 {
-	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+	int ret, i = 0;
+
+	while (i < NV_MAILBOX_POLL_MSG_REP_MAX) {
+		ret = xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_RESET_ACCESS);
+		if (!ret)
+			break;
+		i++;
+	}
+
+	return ret;
 }
 
 static int xgpu_nv_request_full_gpu_access(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
index 52605e14a1a5..9f5808616174 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.h
@@ -27,6 +27,7 @@
 #define NV_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define NV_MAILBOX_POLL_MSG_TIMEDOUT	6000
 #define NV_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define NV_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
 	IDH_REQ_GPU_INIT_ACCESS = 1,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
