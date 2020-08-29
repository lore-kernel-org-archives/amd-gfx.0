Return-Path: <SRS0=m/vD=CH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAEC433E2
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 00:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07C320838
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Aug 2020 00:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qx0D49bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07C320838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AAB6E169;
	Sat, 29 Aug 2020 00:38:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD4D6E169
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Aug 2020 00:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjoQkV39NkSLGNESa7zZeSRdvL3ur5Lcex9wbvnI+Yo5FFtE+LHptfEm4DNSbMe/59+/x0w7/eEZGljB0ZCtvFHwc7N19zSsyoqQ93HAZm8afnBwWN+1rUn0whEkL4Rdh/pmPQM4WM62bpTLktikyA/oH0QAHSd+7bc0VKgVeaokd3bKhAr0PkgqzocfKIGpnXy2m1PM+8ZfbjYDi+BbqcQplAynP9WpJJ6rmVVPOPqNJy6nQkI/HdkhJNj9B3hGTypyXFQxQPpm84lIL/4kZL3nhpHCCZ+zdqFgODZZOW2jyHYU1JDtzpx5sf5sXqkQLfILl2TYVtvoMLW7dMC7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kbcs7AUNVDsj2c32Qm8y4f6FPup/IKrzbqYhRHgF5Q=;
 b=cF/NRK0oTAI/L+ApTPwrzc7MSwBDzlWdVN4FxTfUKCMqEngAWkyCUCkF6L32p8WPWTIdrdhHxGGsHzf1DtSkzpyHDYdfI9+/ScOO+lIiHM517wkQkFr24hIn144kQwovQZWoiB0jnUZ+ic1F8JxoPcmuWiNfCEXKM3udeh488d0mCyFX89rempSYCKIk/BtWsicB4AvaIhHGtTvLHBsMOoIbkSSjFykGi8WWD5s6897855Isyr0aWXJVh0/WJEAi1g6WErrb4O7ZrgOwihEqp2nz2hw+QTqAAoi4H7sZns1kVCtccH6OCtG8m3VfaO2hJcBYp9zTCr9QbC75W+MGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kbcs7AUNVDsj2c32Qm8y4f6FPup/IKrzbqYhRHgF5Q=;
 b=qx0D49buuT7IaVbUfOfzbE/OkMMF/kd89ua+ucaFEMvkVhE40la7nYJ4O7M/BJEiVt00Unz1844TMPD+KzIMa8vTwMw3/pB6OeHj9xfF3zVz1EnX2i8HlAz0CNyFgL9l8SsKso/lmrGlFGon6w4sOBQ4LzeCDKQqAHRckkF9bXA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Sat, 29 Aug
 2020 00:38:38 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3326.021; Sat, 29 Aug 2020
 00:38:38 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] include/uapi/linux: Fix indentation in kfd_smi_event enum
Date: Fri, 28 Aug 2020 20:38:23 -0400
Message-Id: <20200829003824.11632-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17)
 To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Sat, 29 Aug 2020 00:38:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 65a04011-cf28-424d-1371-08d84bb3de55
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1652D26E607FD843EF068E0FEE530@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tF+NvNZ83x4LZ2Ivz8CW3aveXyYfJcVGn7LtBxXUGjnJl0I77pEnE9O2Q3lkRFPSV4NmBLxSfsiKlIN9VDW2yb6cMSu5gzQniq5u/IvY7X2P2+cLWBr2DHOJPnVdCtxRzsXg0DCaS/K/a6ULuiQ42hzI9ThQgq71VNtF6NnvrCyZj7BeSIl+Nu/87JdIygxSXyJzuWEHGUvjCCT12fCfNR3M2gMfChFAvG/ks2oomcO63srrajrLv4noOH8U8OeACctvLHdqLPTDFUxQlAppOnf664pKUW9BD4HLpgFa14U3DKcKhXtDCrDY2JdbgxXfycfPnd8+EXpDZJ/h1pQB1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(956004)(186003)(6486002)(8676002)(66946007)(86362001)(478600001)(66476007)(1076003)(26005)(6666004)(66556008)(6916009)(2616005)(2906002)(4326008)(83380400001)(52116002)(44832011)(36756003)(4744005)(5660300002)(316002)(8936002)(16576012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: /dtA0L0zxKofHFQ++dbS5ZAptSzCK/Sz4AU1eWNRW3pO6SzcLh9dHg+Pti4UTsNSi4phvjPW6Hg+jOipUt3GW6sOjqhZeZnPN5+xfK09kGIdxbmok5Eujl8gw1bOik8K2NlHlqtiOplQPXoZE6k4knHnew1HleFSCdW5+RJJVYbGSU3eqgcP/vA9hAzIkDxGN4WFD2DfHlmZkTj4XpMk8Pckxx6ib0YyR1h7X9qqPWe198yRyxiQ8HYFzIkDkJT14VGQMd/mJ7bGEGU02IV2/QiazZkU1YqJH0Ip3katgmZmrzqyMEbhvBQNTx29xmIhL7aafSvjD1S8vETupe9QPGHj8aYuWhyuy3sa1qqs3RP3vEJotn3rI5crFHSF1Wko14pDmzDap54JvQ2bJxkKQvDMF49gV+s7OTiNW7mBV9YapIgsVSXhBo+F7B/rd6zkurZIn19ug8g4MGPrmK2kb4cteo+ljvNEjeLH0wM4kTKLuL8beeywxOUwBqYeV8K53lBG5/X9uKR9ERXaXyyJR0h9Ikqb482TFfmVMa9+OOLmvtm+uEng8m6NCD06mxdfogQtjIaAfdjxrhHpu8BT27AfbcH0qilZFTn6oL41mZCKAgJ2sFgQrb18FNRUsa8axEdHwBwCLQcFfmB5qDn6/g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a04011-cf28-424d-1371-08d84bb3de55
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 00:38:37.8329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQxkYgZnQOIpQlm0Yb1twGDM+uY2aLDY8CjrLfoXKllO9rP8BiS8vnJuxbTdMDCGTfGXhXkSK/JmvzjVDzu4Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace spaces with Tabs to fix indentation in kfd_smi_event
enum.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 8b7368bfbd84..695b606da4b1 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -450,9 +450,9 @@ struct kfd_ioctl_import_dmabuf_args {
  * KFD SMI(System Management Interface) events
  */
 enum kfd_smi_event {
-        KFD_SMI_EVENT_NONE = 0, /* not used */
-        KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
-        KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
+	KFD_SMI_EVENT_NONE = 0, /* not used */
+	KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
+	KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
 	KFD_SMI_EVENT_GPU_PRE_RESET = 3,
 	KFD_SMI_EVENT_GPU_POST_RESET = 4,
 };
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
