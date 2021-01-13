Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56DFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:03:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FCD923134
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FCD923134
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BF489BAC;
	Wed, 13 Jan 2021 05:03:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14DE989BAC
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 05:03:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6jkK29AyvxdHTKdTtCetbcCaK1RnXpuSnxE4pjpqN/NKcyCQrzlBmf0zL/vCWrgNm6pxyYwWPny1wglPQU3TQNYRoCiFQa8k1dBS87PUjDcw7Fonk21f/MDeUJg5O76gUqWDg+zN1LeuDDA+e1humk0+kRRqAuY7S3aKsaWTcdiuFvF5lnuTjOjuwmh6/jayc8LffcToPLPsOwTEqX+07RMF3sXLJCfLJQFhHqRe7UxG/91z1/gg1UXVA67lxJ6+RDD33u/abfktOBQMHshx0vmFxanUeK8g+PX6RgWbwz+FOXUEziQO6OZtnj776itFyuYW/iA2RxIIZIh1fPJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3Xnm4zsSOh2BAbywSp/eoSQZrFC8Rk3v+0e2jIU3Y=;
 b=GDrUmiwBnDEr7D07AXLYdHEgawX/2VqFv6BdHhlbDoOGLlr79M32y0nH/QlxZKJnEc0nJhyyvHY+TyU37O3329T+1BDCDpi6u0ZEqRjqDr0a3ECdU+tbb0mbPA6dIXRVpyePx8OeYYIlTkv7bRCR09iU9uezfkvQ3V6se8K4NGLi/9SD3m1FQlyTTEi/khRLNTx+IMvj2bhrqnm6pRoZhx3CspyIu5fCMQJnNJ5e9oQ63Q84up5R9LjxLvLmBPoQ6vOCqB68s18CD2IGH4ZZxciXePOrumPOUB9LXv0ofRJQ42ZsveHN+U9/JMpGCqREHqOqavxJ5+xEnIbT8qxNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3Xnm4zsSOh2BAbywSp/eoSQZrFC8Rk3v+0e2jIU3Y=;
 b=a2HEPFWqn3JpwQAAsTd8LcuqRFz8Py5ky80OqHdPPl+GxLA6BVmFi7YdYrz4dwkVyKAJBxxexwOrnIc8qKZ3+Rgy6A0U7cJyPo5TNcjOVSbb+4/SE5L72A8tToAXukFJVmju0175rX3iaz5U0MyeDpZzgpLK206q0XPtjlMhuao=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1124.namprd12.prod.outlook.com (2603:10b6:404:19::10)
 by BN6PR12MB1313.namprd12.prod.outlook.com (2603:10b6:404:18::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 05:03:27 +0000
Received: from BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e]) by BN6PR12MB1124.namprd12.prod.outlook.com
 ([fe80::7cc1:989:4a2a:ab1e%10]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:03:27 +0000
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: add the workload map for vangogh
Date: Wed, 13 Jan 2021 13:02:30 +0800
Message-Id: <20210113050230.12252-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To BN6PR12MB1124.namprd12.prod.outlook.com
 (2603:10b6:404:19::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-MyrtleD.amd.com (58.247.170.245) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 05:03:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8356f4c-45c2-4580-55d8-08d8b7809032
X-MS-TrafficTypeDiagnostic: BN6PR12MB1313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB13133BBE57FF275F56BDEF71F1A90@BN6PR12MB1313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2dIGYTDCLDaAwpg/NEr/LlCPHhtm0PVRFlIu2g1CK020faYP6EZtTo2j54B+wpAT46O5Rh95SS/W5MXyY61LrST6jNXrj9L1UlstFzZZOANLxpd+Sj0xZ9T42bSPtP8oMxf5EOuEsfdEryoxFm3p0rkl1UzRVdXMZtoBEdIL5FAcyw47DWolSfdbccY/M8jb+mIerQVUWTxlMmod3bsbpGImFPXabnqNvYZEQAIyFKF5davsqgQNQJzOXPwOQnMV0jMzbY7o31Xfyehb8Gcypt0lQ+sGBAiei2GFjufCyPLNtsoHSjvUoJPIqsBSe641r0uU1atAMzDQjNQnlXfp2fKUD0c2J/DzCcktEC6NxbxrgD42omVEl9lsmBjWMaL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(186003)(52116002)(26005)(16526019)(316002)(7696005)(956004)(83380400001)(478600001)(2906002)(6916009)(1076003)(36756003)(66556008)(2616005)(66476007)(6666004)(4326008)(5660300002)(86362001)(4744005)(6486002)(54906003)(8936002)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1baPV9NZp9kkGHVmLtia8K1BpC43+FpHz5t3vSkWkIrIijiCSOLPcEU6rrUr?=
 =?us-ascii?Q?v28df0ZpKxkTIlJbOSgL5nTgV3sumB7n4ZDOdXPCYV1IOVS0QGpHX6nppTY5?=
 =?us-ascii?Q?jW8u+w1pLpY3LI12Qj4AJpO0attmYOLDUwd7BPYd8HXo5x8I8SoUeDZ5OFDS?=
 =?us-ascii?Q?xLaSvAn8rNDBCgf/90JzNooxN1hXp8f4eiKamrsM8TDlbqp9okPoG4nd5EFn?=
 =?us-ascii?Q?h2Ce8VgIcXOhOKerLVP0tJDLINuW8LOy/Q8ozT8GEDcQRNEkoyrDnHATsyvh?=
 =?us-ascii?Q?i/nK9fbip6FyKwhtYs19zi+ZQskdlXDRWEiu+U8oXmAW9rDaOpOWZAIC3g6b?=
 =?us-ascii?Q?xjqUWyULHdtfl9Ja/rRxT+bZz8/7jSp90hE78nD0mpYgNbiR1Y516RVHHddO?=
 =?us-ascii?Q?cZQ94/qbMIidQjKT6cFQCIfckwiLwIECwykei/ZEBxAyNLLKrNO17vFYEKvv?=
 =?us-ascii?Q?nEiP5Ayo6iqhdarPTrFgMNyoVHpB38sfv+dHn4TUv1iu5t9SxdOX1yIHiacF?=
 =?us-ascii?Q?uPl2Gi6YRAksBYQaXzCIl0l4XMe/+upFIr9CbVc0ringKO9X20q6q2KMCR9N?=
 =?us-ascii?Q?nOLWNx8K03i9kAibseukTdvh/wzqQXG8iPhQesWiVrw91X4YMap8BBOrh5tG?=
 =?us-ascii?Q?xC+wSExxzh8812huUIiIX3CeJt+3GeZrw6ffwaqGiJOzDJ6TEa5SaF6ujwIC?=
 =?us-ascii?Q?Pj+u7Sw/x/W8BpKRasbAaL7QLrhGSLjoRWXvIu5JVWDJLIUKJrtcbi41GZ4T?=
 =?us-ascii?Q?vIgtNlRLtUtGHvSECmrAqXv3IpEqeSmcIrjAopJ8dEynSFjoxurSTB82Uv9Y?=
 =?us-ascii?Q?gSCzoB0/g8oJnQ7f0ZmK1q/nTFg1yqk01P/IGCkfSbWA4I4AXQHE3C7RdIfB?=
 =?us-ascii?Q?OcoCCS6PvZbz8CrnPiLqajhxizwFVFbEGlgOb36UsiGwT6MqxaPokiOcRfH8?=
 =?us-ascii?Q?w4XpsLwhyqauCsl/5dX39708UM7TL/MT23bOGq0ZwxV9VSnXqeK4S3dgx/CW?=
 =?us-ascii?Q?bjwV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 05:03:27.4600 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: a8356f4c-45c2-4580-55d8-08d8b7809032
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dnZXWxKxXeulInJA0FUUsu2uiZQ/z6Q7PjNm9wUbyDaAu08/ybmPPQzkelVXzIZ1TjE8498Nx3fYE87K3BG5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1313
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
Cc: kevin1.wang@amd.com, ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>,
 evan.quan@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <xiaojian.du@amd.com>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add the workload map for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 8737562f990f..7f78a9378f07 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1653,5 +1653,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
 	smu->message_map = vangogh_message_map;
 	smu->feature_map = vangogh_feature_mask_map;
 	smu->table_map = vangogh_table_map;
+	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
