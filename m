Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79159C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1471064E11
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 09:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1471064E11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1646EA1F;
	Wed,  3 Feb 2021 09:43:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3966EA1F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 09:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T60tdTLlSTaiWLkPFetJhGDmp4Qiq3ltsWwNHJJF/K9VmbOWrHTGMHyGO91F/bZtqEPV9HE0EZcsk53qQWTgtBs4/oP6j0QwDg5Hy117M++YAbq9RlhIc4r9hnqt6PbGjO4f3m07IK8n2lMvoe/UUOq4FZS0+9AOQJnzVEUrE/cA+nEReQxsk7/x0DsXgXeeRbfZnPMmiN9hJRIWb0a3dRcTxLkvx/iocy3w/D7/RQSgBwKY0MFNvMd/PpQY4wO0ETsDgY089kvidoXsVo0war0HCzUp41544zEjY7TyxE19/CFBgvENlDcPX8nbc4NvmagW5r/Qh620ImV/Ku4wSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGmiC1CA3EBR92EYqSH2qaKezwGUTF578M9uQAd0/iM=;
 b=gUWAHuA8qaD2KO3QYqB6uQL2DS2LRzaUePR1/J22VSKwgvUsnzYi2iXkLxdzQK3vQu09gLGlR1kDrHoMdIBQ/odjoT+KLY/cIAfT5ZGdu3pMazy89JBNHI2auj+nokrxHoU0GXDEZfhVKmwafVSHttWgiI6Q1PBuu9euRTUh9EbALL1MWKgn50JS38LB+Fwj1dhsPilRnMmyAXnST+RY5QW9N8sof7GEyedCv0cuXg3vG+5FQpubI9LCKbF6cY00Tf8UooQJUXF9PFOaxERIK9BflOb2fy61DOomXv5ZTDjC+EUpHxCgW3uJqchxb0vJizKYW3Gw/bl/byY4v96X8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGmiC1CA3EBR92EYqSH2qaKezwGUTF578M9uQAd0/iM=;
 b=Q6aGnbyl/S161BrEkFRY/PimOm/B2iUi7NHxPErgf2GmRUhBo6RTCreiOMsdUhTdUPSB132oUjbKjsHJmFgTmueyF0x8NFGHdl1JYF+rIBONVWYg0zuL9fnjIE5VHrkiJJvPg8CSeXzriOScZaBAw9Awwxr/Jy04jWjE9gwbNMQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2911.namprd12.prod.outlook.com (2603:10b6:208:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Wed, 3 Feb
 2021 09:43:25 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3805.028; Wed, 3 Feb 2021
 09:43:25 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: optimize list operation in amdgpu_xgmi
Date: Wed,  3 Feb 2021 17:42:59 +0800
Message-Id: <20210203094259.21899-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MZ01-CE0.amd.com (58.247.170.245) by
 HK2PR06CA0019.apcprd06.prod.outlook.com (2603:1096:202:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 09:43:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89ec0508-74ed-499e-fb80-08d8c8282689
X-MS-TrafficTypeDiagnostic: MN2PR12MB2911:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB29114A327ED20CD15F949DC4A2B49@MN2PR12MB2911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M7+acSxuwitwmcNhBleoO1HsCwthza1bZMtl/bsHnGKjGDiYk5HnibQ/CW1u61fAKKN/wR2QFb0agbx81NtpPMLCt1XaXYfhmMyRg62bFPPZftlonzUwpocIJrwu2qX1DBHZ12A5n6D3jDtkyIkgSTKN8dgXIq/r8jlxokP4cAaNRfnWS2Pu67du2H1PcBiUngztarXIFHWkiABc1BS4yXrt1go5IidGGKYZjJVmIdKE/4BC5ke73hV/q4+jdUt6HQUTAm3n/OEquuxQHQuO9p7lsNCCbSlxvDZIear0Z3h4IOiDQGfL6EDLWWfm1LrDC5dXdU5yXOQorrk0oFv3OQvLT4bgGICQPnLzB9ebJmYGfgeDkRcJqzkG2rYu+BaotjVw2dB17dD09J1NAxNpd3fi+2TEG3eDevcGxjQDCGPKnqYrsTszUpjzfsSNi2qBKB1ZoZbq5jFNgcp022ZQfyp2d8eM2F4OsoiHi4qaSI4tcgq84SiwheO9MZkkonW9qXW0js3MCO6PCcMJLMimg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(66946007)(52116002)(8676002)(83380400001)(26005)(956004)(7696005)(316002)(66556008)(5660300002)(1076003)(478600001)(2616005)(36756003)(16526019)(186003)(4326008)(2906002)(8936002)(86362001)(6666004)(66476007)(6486002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VGdcJXkINzdahsSJMmiLZ9hZ8CTJWskIwosP1OyKxMQfM9WkBxQ/cIJbOJdC?=
 =?us-ascii?Q?OYKLGOS5YBQc+Hdndzmb5ZlhqBliAirvnLnR339bEl6saeizWcJb6C9XfW1n?=
 =?us-ascii?Q?voY+dM2RiFO4K6xbWqP7oxq5rgG0Pwc/LL6WZOA2GZrvgU3yEivIC8V16rpb?=
 =?us-ascii?Q?+h03cYa8bAmYrrQNqATPIqYW653HNdwN332RFINxKmuVnvTxXyztKOj+PVC3?=
 =?us-ascii?Q?n/j4RnZZFjaL8HkBTzOGMPgsbNvhsNDpSgkfuqNcweQ3bqlMBsGMaBc5e0ws?=
 =?us-ascii?Q?nUKCtwRmpYu5EY2mmnRL0zMe8Q1qmBI/+/oSO1TaNFLQjGtFEb95L3qQIlxD?=
 =?us-ascii?Q?IJbNCFb6SYHfz4LgdlHqULjpq1E2oZmX2Gq08E6v2nJrLn94//mgnKPZe7sW?=
 =?us-ascii?Q?wqtPvhHkqt1empshVwWUFxQzo4xzMaWNki4A+oVrfGLhdxBAy2ROoCIyLdSP?=
 =?us-ascii?Q?PhYD+b53DrZnPq7DwDnMv63DcZglPXF+FFji8wnzYyS/uUE+qU9E4nftWF42?=
 =?us-ascii?Q?XQqrSUAOhU7Kxwh1JCkTIgg3TmmI6pgo8ReEjK+13dmvKywqMd5rQiImRgTK?=
 =?us-ascii?Q?fegH7UJNCeNRk8BLWvxp++kdZc3biIq5/prmqqsSPo8VORGjzdiniIAQ6diz?=
 =?us-ascii?Q?HuRy0UL2wEOsmUga+2d98LUMz/ZfZ+ivEMi7Aci/WzOI/sLyZsOVsAu0z97U?=
 =?us-ascii?Q?F1IVRCUcIJSXKNZPoQjAzVtYZqpRhcQISBlmjycP+0kmH1bJq1heRY5tzy9o?=
 =?us-ascii?Q?9iCpoAkBJE+I6qVJCpGRmjUvGU1E5sbfeXk093Q03MgUfZcljMHxRGkU0VJU?=
 =?us-ascii?Q?+9yP/ZwPPxlGiyf61YIPrVLaoyBPCgBXc7oNX6yIg9HQAJKhWYg/l3cT65Va?=
 =?us-ascii?Q?RRBBHsLfjD460mgsVTLS4iZ3i/hqjrLx5KELGcXHlNJYn6jJhvq8WZ+ZJRAg?=
 =?us-ascii?Q?UiPslSGP/EukoSz3ytVua1pt373RiSi2BPunzih4lfMg5xguwbXldmL6G9rN?=
 =?us-ascii?Q?N4T6F5BGDfKs74qwSY7r2GfqfJzre1Y9tEqvFScWrtctG/t16Mqmnp2SzU/8?=
 =?us-ascii?Q?P9BntrTx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec0508-74ed-499e-fb80-08d8c8282689
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 09:43:24.7856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2KfFNlh3HgsxORlw/qztmGX2KMA/iYrxDG37afgYGIJXYZRXjvZ7PDy/mTNntou
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2911
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
Cc: Kevin Wang <kevin1.wang@amd.com>, dennis.li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

simplify the list opertion.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 541ef6be390f..659b385b27b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -324,7 +324,7 @@ static void amdgpu_xgmi_sysfs_rem_dev_info(struct amdgpu_device *adev,
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 {
-	struct amdgpu_hive_info *hive = NULL, *tmp = NULL;
+	struct amdgpu_hive_info *hive = NULL;
 	int ret;
 
 	if (!adev->gmc.xgmi.hive_id)
@@ -337,11 +337,9 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 
 	mutex_lock(&xgmi_mutex);
 
-	if (!list_empty(&xgmi_hive_list)) {
-		list_for_each_entry_safe(hive, tmp, &xgmi_hive_list, node)  {
-			if (hive->hive_id == adev->gmc.xgmi.hive_id)
-				goto pro_end;
-		}
+	list_for_each_entry(hive, &xgmi_hive_list, node)  {
+		if (hive->hive_id == adev->gmc.xgmi.hive_id)
+			goto pro_end;
 	}
 
 	hive = kzalloc(sizeof(*hive), GFP_KERNEL);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
