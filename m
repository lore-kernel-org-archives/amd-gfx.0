Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B646C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 23:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B22322E03
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 23:28:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B22322E03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467136E5B9;
	Mon, 18 Jan 2021 23:28:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A4DA6E5B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 23:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ape2q8IrFF0kwae/tPQbmkjfWB3B988Ba2uJK2Rea2kaRC8vb9aRgaA2quHgwoHGu/k4K2MZ0/FkRMkLvSEVYUyl49v0/RnF2yha/eQfpTi56x4+k2ktmV9NL46y4boFdrwLI2u50JPU/OcRRFU69PBk4chN52+ctVf1ncNYJUWa3wOf6+u9VWjO6BZWJoECYF4Vnssfaz1zUQj0jX02fEdQdTdV96huEcItmmzXD8tk+unVhOv8VyAzLyuI22idhU2PE/l+jPy2iGixXwrp28KM+cXcZ3TiUVLZmhPUnBFXHoQMjz4UGQ0hc5rvOADaGox+nmr0YkNOhrmPM8bxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBJm344Xvg9YYuFENi0jxCpGzVZzOkV2TEvVkZCOeTE=;
 b=gaWx8EK9r8pdrEFDbLnlQbAznIfYsqcV9gAsd1rwZl03kBlKxKHv5ps9L1LbNHwzODYRwgEcH3XHXCmaVP4QGQosJ+9aoBfSi4M7Omm6G75FW0khwSZkmSUYRvckpL66jlxQLZ7H9Vz4iTdn54qykp098VOPYEOHGdensNTVrmJthy1753tn7Ow1BGKh4hjsLQ1xKPtfmiqVxXtqMLn6alv8vAxMu6jB2lk3REucT9BVihncXcznm9bRFofobtaHzFUGfPBOxZic0+ImCZ1445Iy3c/i0lBDvwmWkAFA8RC6b8Ayepipks1APg0W+mG4p9lQUObcVpDAC7Nd4PP9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBJm344Xvg9YYuFENi0jxCpGzVZzOkV2TEvVkZCOeTE=;
 b=dixLG8Qr/z/iUgqU7G9PVv4hUQSoHJxK37N3OidB6j/b8PLTGT12QENluWuI8Z6pGgKJVSeBQJ+4ldrqL5egMIdgghDrQrtswH8UGkbLRzN+Q3LCjEzhoCydUYdrj2ZeuciI3Va3ls52pu3w7DIioR+FUXnMB2DHLcVSSeJ5vXU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Mon, 18 Jan
 2021 23:28:47 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 23:28:47 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
Date: Mon, 18 Jan 2021 18:28:24 -0500
Message-Id: <20210118232824.32649-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::19) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.54.211) by
 YTOPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Mon, 18 Jan 2021 23:28:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0c833be1-2099-4125-93da-08d8bc08cdbb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4815:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4815F9467CCF09CBD246E74C92A40@MN2PR12MB4815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnN2wDdVeha0qPO8jsrPXKxn6G3fw/pwSBZ2QL8LED66/fGfziNJgbeaSq7GlYE1BvVx0NNLgdchgn1z+wU/mU2Y4Yl0qCMqQ4mnA9By1lry4sJ6VrW/nV+lVKVwdEjZKvi44YYrM3gjoxstLihJtJVhvDRz/GqNs4rNGmQzzjlvauXtwblzUIs18W5xsBtTR+/y2MmjyuAiqlyF5JVt+lWeQKJimdlCmdw4jOlh86o87K4h2n/HIzvSJOGYRjoJpkf2JMcL0VcaejbGs5XKCeqnIY6wpP6jqBlZiCTnFiwqepj3AV/mpYwxLeA5StKW+EpjaOTvhqn6MJzDfXkcogQ2G5NBVGCCkP9DY4/7L3c/+YbLio+e9UzViZKmJSx5FAw98DJVKOX6mjBIRUoOjn3K5YbxPSwZJsg5ZLakjC3vneMCNVRBx9wuygAGamLJefRH6voDHSKrsXmhbWKVpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(316002)(16526019)(86362001)(26005)(186003)(52116002)(478600001)(8936002)(2906002)(6506007)(8676002)(6666004)(1076003)(36756003)(6512007)(4744005)(66556008)(83380400001)(6486002)(5660300002)(66946007)(69590400011)(66476007)(2616005)(956004)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DMgcWhH1/W50IT/BHqWqgqizHBCctNiEmcgBk5jcewKfMtyZOP2hGZyAxDq/?=
 =?us-ascii?Q?LOrJaAR9DFMtnUdCQXK8n37cic0ZsKF9dVey+1lmpxix2Sdk4tktiwFavQu6?=
 =?us-ascii?Q?bL0BqJxtgpP+dwbnQNt89xg1Y5gOvWoLCJGns3EV4KJLMsQf7Wtin4DDLG7C?=
 =?us-ascii?Q?RfDSAu22nfigtxf6gptWPDDw1SgZBvNMRZK/j4BrEJLRKabDFiLEPGyjCrGE?=
 =?us-ascii?Q?91mb15TNgoVBp0vpRpRaAs8hpmKWk4e6WbzdPuFqnTkKbEZPZ89D+RlATOjx?=
 =?us-ascii?Q?CZ4zCPZHspsEkCq25utfKS1JiGJQyLtjejVuJTyHJh0koXxEwt2xnRRzMbIH?=
 =?us-ascii?Q?LE2tyZ0VUG2KG8jTYvbQUCq5kfHhk0kjvL1Ic9CUjulCwBgsvxVPHGaKPKtN?=
 =?us-ascii?Q?Yxezo1i2qL4wXd8+cUgavRXxHTnUITRiFx7DLTYNEUqCoWG/Vm/mXOB04vSv?=
 =?us-ascii?Q?Cm6i7wbTeQNa60PKoyI+MoUWYpsyun0dmyZXmdwa5wGYHUv7MUoM6YY7vDqM?=
 =?us-ascii?Q?kcfGw3lP2HpLOf9NCzO3BDzAp7sfxmJ2bVZk9OmEassidW4bvC/5zhldQw+4?=
 =?us-ascii?Q?4asOSQG5mLPF0nHiijIj9WIx4gTBaexREkskGdcmgJ0vrSJPCMJfiDzeLppg?=
 =?us-ascii?Q?Qk8LD5Es967e147wHwT+S+Dze/eRMobT7sVk7AEbka5w/MHAQaPSGvagn4MA?=
 =?us-ascii?Q?b7x81WuVUb1lR+141MF55BCvFWg6ZOjxSQSgtEATVoi40JqTigK3nNLoQ14a?=
 =?us-ascii?Q?W1bXcPR8YVRfvr37g9/QaCvYCO3UB6aAaqAY3k3Iw1IfUS/Slh01HekW9TFX?=
 =?us-ascii?Q?Ny4iZw1odYqxUwsWGs/y3kG5XyfgerHjp5nWEu4CcOSUwpDJKPcl02JvYEUw?=
 =?us-ascii?Q?jWSZOahlPveBFn+4gkUqrH0GDluprMi+24fnTv9m/jNdTPgSL7tZgvb+Uqua?=
 =?us-ascii?Q?8x74Z218SAnNd+B+DbHGf0xFJd9br6pH2RiAAERql/MzKC/n7dyPt0FJ2TwL?=
 =?us-ascii?Q?yo/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c833be1-2099-4125-93da-08d8bc08cdbb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 23:28:47.3453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xw4wz6tF5Za90k8kDHsvC4lpBg1gmbgfO9+IgDIabFQTlh93YlVgpD+EKeAZTOiqSLmAO4BOQqUfPbpWA5xf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ROCm user mode depends on userptr support. Without it, KFD is basically
useless.

Make sure HSA_AMD selects the same options as DRM_AMDGPU_USERPTR to avoid
broken configurations where userptr gets enabled but its dependencies are
disabled.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index e8fb10c41f16..f02c938f75da 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -7,6 +7,8 @@ config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
 	imply AMD_IOMMU_V2 if X86_64
+	select HMM_MIRROR
 	select MMU_NOTIFIER
+	select DRM_AMDGPU_USERPTR
 	help
 	  Enable this if you want to use HSA features on AMD GPU devices.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
