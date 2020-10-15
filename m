Return-Path: <SRS0=r20P=DW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39460C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C28322226
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2020 02:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CyfAeSx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C28322226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804336EC13;
	Thu, 15 Oct 2020 02:58:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F99A6EC13
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2020 02:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjFUjUtxmZQ06saKYqKdnu4BieZStvA8ejSoEEBM2oT3GmEiz6QqeulR7t5lka0ovPKoeqe4osK6Mx5lLeC628nTVOQi9e86kSfXDZJKw4IwN5dmA6ZgvYKHwtRuulWbFU+4zBTjvzrzSDwMjJSNqUToX22gYzhctxrcUoALLWJoxFsJH5bxii5U6DwkjB+pa6N6OHpYnzIVKA7LMTgphUzToFyPH+HkHfD7txCP1pYHKZVHZE6N3RB4Cg0rM5pRo6o2na4EAVyOrU5OsdWd9yiZ1ITVNUMZejo+CAlogQDgTvK3NKahTGFhTmj9dSaDihAblUylQG/8ZYRpYQIrew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVZMhLGYwIE7//4FDeL1z+2CZ0vE8iJPOgY1lgO8CfQ=;
 b=kFWlJRilR/bG9vRIDH0lkKzGNf2xDI+Uqk3XRoUbkG2VDPqv4yF/+zgI877uAiYq4pOv19Q5ZCeoOTml2FrbxVBOgr3XEueWPKp7JrnY/3t+/TLjqW1LzLXj2WWTs6QDUiw44n62evMMhivBTxfAJkJYeewn1arp6WuJBNCGDRJ+fWoZ8ycIeifRRdkeq6YtEKfEUW5/96gG2xny6llI2+cyefMsbLFSVK0E9Jqe7ZgTfLT3+dXGaAov4+8gcuOnt4vcHpu3/THLykU0hv46eEDvjBSFIGnPiNJ4B5ZAVSzcuIxEY0SEeq79bIdXYmFyaiUulXZjNWgRqNon3Wg7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVZMhLGYwIE7//4FDeL1z+2CZ0vE8iJPOgY1lgO8CfQ=;
 b=CyfAeSx78qYxKpAlxDL3N8yz72Nw1XqmsmSBgQoUSKBEcDlZWyAOuCA8WHufe6+P+98BrwDHFlU0rskSItBYcz8wKgfYCow+SADYQZF/5FaD7IztseWksWccISa5GTVbOezTCcE7P0mswcrZ+VeVmwacSoh97AwdR9VQBt+SLSo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MWHPR12MB1518.namprd12.prod.outlook.com (2603:10b6:301:11::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Thu, 15 Oct
 2020 02:58:04 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 02:58:03 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update golden setting for sienna_cichlid
Date: Thu, 15 Oct 2020 10:57:45 +0800
Message-Id: <20201015025745.139041-1-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (58.247.170.242) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Thu, 15 Oct 2020 02:58:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 067be702-4066-4bfd-c92d-08d870b62237
X-MS-TrafficTypeDiagnostic: MWHPR12MB1518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB151846AA09F4664DA6ACBBF0EF020@MWHPR12MB1518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCZv9+9Fxr22qz1uzsbS6etRoR1NJn8xb5m/aDMG1Rpi1ixdFUtIHxFsxJYtYpHm1U9zrjlA3BCvytMQxJ0rARYK6IGliEIEas6Ke5mXdYdJRwLZOtXPrJagyLHpzi1IooSbVQCZ+oUZ5x9OoxlZmkbOGkBY11WixL3I6tt7+BLHwIIK45pcxpK2VPaYq+v4fgt//D21olIp/IM8yft9OwrcKzKgR/iWnP+zRBrjUeGe/lGoRrYjD4nS6WF05cWLmFqfO0jtiMSepmOuplC+yKJAIR35BZiv7gn8sdxQCilbvBgtO741YKGfXWAP92KQzXrRLleSWavQ/g4FgT4TTtGitRo7Hl8pTQe0y5fO1q2YppVJIqy+6Wb2U2YQc7pQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(186003)(36756003)(54906003)(478600001)(26005)(15650500001)(4326008)(316002)(8936002)(8676002)(2906002)(5660300002)(6666004)(1076003)(66476007)(66556008)(66946007)(44832011)(34490700002)(16526019)(86362001)(52116002)(6486002)(6916009)(83380400001)(7696005)(956004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: gY6m17ktKHO8sUD0u/rfAx1n3QdlWPJs+p7XutFQXbMMnE/DDBvfhxQNWHqMX0QP60U0wf/G7m0AMY70nqTF/cylujVl3/YLTEVvRQ7+O9K5/ATKhWxfyGuG7M/OC/VXBgBx307ihvs2flGfkfDXJiIM2G069JiWIOpfED8qCp8Pn/CyrD1XdJ1ubHABY15STzddc65zBai9xfeXXX9MJCw9pSF4VPaDWbQe0lyH3oI+/RyVeIozYdqD1/gI2Pd18T/Ct0syeHN9SYTWrqQdW76Zm/izdNt6LhZoHe8rS/FP0sxiPKKC6QFBUI2jStyxJHXKlsTpTdtpvzowiW6oiwgEc+zRrcc4nGvd6Xxq62jqgCtwMif/r09Exc7ya6OiAAT0vBBLyCyRe1gojXX54rSIlhUH0qmMl1FvqAvs5iubA6gha6yWbSLYu0QHVOtxh/wrJtHMCySUvH0fsNEYuguh6TAYUVIJD5EpOAAmlkUPL5c9guN+OgZXcK+hQaHYosGgTRZGyHnF16v04J+JUGxRnGUnjn4+4f0xeVeDsOIczRxohrZTde7OV1iIKK9Noz7W6JfG+rX/nj391qNmVaYQosjA7z8OsjJnnpkwX2+ZMxJacJtXeVW5WGYI/2wBA6dp8tVTlrVVcdjgLXPt8Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067be702-4066-4bfd-c92d-08d870b62237
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 02:58:03.7513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8N1cKXpE/EiSevxVOvPR+DuvkdNnk3wpwKdFV0z9KG4xig+JVO8jADQ+InlYHi8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1518
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update golden setting for sienna_cichlid.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I9a1ad84c22748fc100a3327487c6287e237df490
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index c4e9db3be39a..69e995155594 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3138,6 +3138,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK, 0xffffffff, 0xffffffcf),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CM_CTRL1, 0xff8fff0f, 0x580f1008),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_CTRL3, 0xf7ffffff, 0x10f80988),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmLDS_CONFIG,  0x00000020, 0x00000020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_CL_ENHANCE, 0xf17fffff, 0x01200007),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_TIMEOUT_COUNTER, 0xffffffff, 0x00000800),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000820),
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
