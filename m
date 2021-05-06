Return-Path: <SRS0=uqaI=KB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95FC433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2060861041
	for <amd-gfx@archiver.kernel.org>; Thu,  6 May 2021 22:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2060861041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60256ECFC;
	Thu,  6 May 2021 22:38:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A916ECFC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 May 2021 22:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rk6d2CFDLbgej+qtY3fzzjAFpXTmKd1XCoGiIgz8BKrc8ox5jSYK/v9VsKoOdxP68/KrcPEz2M2ewwR1WKhbfsL7DvLKHiThlpqavry/RWOhGGkeDIExJjGyIZqLv3877vMFu6YLzz4NOlzm2Iw4F9UqjfBeeLXK4T+vHZVifcGT8HpB2jSFezi69GpExStC70rEAyIzg6er6j4A75nsvhq5G59X1NW74RtrmuOfsu90UXvPyoz/lmCPdeljS2zHnrzLrO+pyRSSrqcOCmWVxnRbA27NP6QT9WosMAENqkcIaXZ99uZaOAUx5vdxd4ABagoqMgYE440FdCDQwGzopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=V1hI3IFx+kbN0H6+M4Qqp8SBDwGEiu0qbMwsTNVxgw+Tpgp6ioSv72+6K4+5ZDUSE/a1Gr84Fa7Gm5KzLc3TnCVO4ltKZ8GthEm+z6yL9krK+i+B+uqJXvl1Z7Gx7d6hJl3ykD8SC0/upuwB87C/vL0KVKljdM2Upss9beS7u0skGAWfb6XIHfTn6hTaTGudTj6Drp2ymiWNCkUFDldHQow47J04cbLBI8c77ugoAe/Pr/Ic/iZQbvcsLzT85ZDHSOvNAgZZg0h6SFVaDhgTMfueyt3zQZDhSrta0EzyYfsyiuuCadz14xFRHmsGFX4vxU4tM5rZmZg7B5m+nNb6Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaZhSwp4MTjncjecPRjoxGtqt0WgrZ+P3Bn2m0R8EZg=;
 b=C3Uf7Kczxzhj7u+a861gVnNHByAXLVX9/qlFiBB3Gor5DqXVu1T80a1Tv9l4AI1+q5qXeosFUk4MPw+TGCe0VkJALaCjwmaYYCsO9IKsOIyFO/kOub9lx3DpDqkqW5r5qDb+S664qI9/BV2Qc1X3If1qYHtb5BIk2V2LW/y/81E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Thu, 6 May
 2021 22:38:01 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.027; Thu, 6 May 2021
 22:38:01 +0000
From: David M Nieto <david.nieto@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: free resources on fence usage query
Date: Thu,  6 May 2021 15:37:32 -0700
Message-Id: <20210506223733.28058-2-david.nieto@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210506223733.28058-1-david.nieto@amd.com>
References: <20210506223733.28058-1-david.nieto@amd.com>
X-Originating-IP: [165.204.53.123]
X-ClientProxiedBy: SJ0PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::25) To BYAPR12MB2840.namprd12.prod.outlook.com
 (2603:10b6:a03:62::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from loud-cracker.amd.com (165.204.53.123) by
 SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Thu, 6 May 2021 22:38:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3f55a70-5fa9-48d2-de44-08d910df9ace
X-MS-TrafficTypeDiagnostic: BY5PR12MB4034:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB403472576222E785434AE514F4589@BY5PR12MB4034.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qk+64ixYLl+lSPzLIEzAzD/7PWhi89h8gXS5IQS8lTid9Gge/k561uCNzsxCeRTANdIiiEcNtN4ceWUNpSr986rJIMXG+lwJYd+/6Wj43WBGCtlp7fS8s8jpT4Uya3VCBGRHrKsEJMkizrW6J5ZbZS/2tIL88AtCHs3+Osp19HbclK1DznP9bvbK08d87GG1Mb8PoglRF2cE9iblald/yLm1HBEDIHgtexNiJSJdzWMil6Y5Uun+bQ6USS2MR2o/WFp1eL+WtGJrChBi1k+svcU+9HiC0SZ1bitaU3YUswPqAm/PgxIwsoxcfI9Z/cZLCP0jdnKfdiepj0GKSFULdX5dZU/i+MwcK2lLXFq1WQ6jlurS1XbTTM8b3toFAKpNNNKD05LUG1VzG0O9qBWX6rDi2DT4fLW1nC7VzyN8Vr5aiaL/yaUbfWx9wdXoPmDbwfw9a3CGDaEAxAgj0rddkwEv9MDMWz1b4wr1CB5w41YnqXAzeQ44cmETWPSosu/WxT3WbStSPp+yH2dJCooHEZunpumQ0Q2wxqDCaK6M/mKGsK8Fo0t+OfLFbpB0D2FVVXZeKbM4/y3TvHOoAo+IUO6k2YjafX8oWFORuJztE+qVVH5rMM5/c/OBogsoxTPOX1cXx2p8xMovPf//KujkQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38350700002)(38100700002)(6486002)(16526019)(8676002)(86362001)(478600001)(8936002)(6916009)(52116002)(7696005)(83380400001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(186003)(956004)(26005)(2616005)(1076003)(6666004)(36756003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?haAB83baiGaDzJXl+fsbhRd/kc1TTjJCBnQtVmTEaoKQ+cHsmVN281x3ZDeg?=
 =?us-ascii?Q?AHb2u1CMtUADzSUzFEyKWiGCXZfV8QToqx7p8H1rC3nHHDR2eP9PRtNf/W8a?=
 =?us-ascii?Q?Xv5ab0xb0HxxPLUeKsNrBpXW3to8W1XtrHz6RaeR53igclkl8Ag9/fsF0lBX?=
 =?us-ascii?Q?YY2YDuVXfLcmrlDLuVuAVD073JANf2oKJw1tq9pTOaLe2ZnH178kabTXoTLa?=
 =?us-ascii?Q?Ttc9muDfndT9wOhPTv+9CrZmtT8ouzTKsynDSnrvQ1sOJoKmye69QijT+9dm?=
 =?us-ascii?Q?Z/SHiwh/GvlT6KffrhRKGV5O/3mZDDkswkPS4fexrYM0ejbIRjS+0aDy+TqT?=
 =?us-ascii?Q?+3VyubC2Nck16nmQvH5+jyQzT7YpAJCY7DV3Wwh6zhzY0X39CGGqTqvYK9sZ?=
 =?us-ascii?Q?7IpXPH8EcvcgI/Pomq+uGqtuIdyU9iE12JxE2+AoydPpve7Ld9dGBSbKFQnN?=
 =?us-ascii?Q?CpAz435DKhOCK5HOW2QVuYK3bfydA9fQHtIZ9/L7gT7EWTmEm9vCRrfv+ns5?=
 =?us-ascii?Q?IXBPnl1mzmX+Vhd+epcXrqALRYBDv/ILXv/dxwm55rdaZy1it0hA4K9HpFTK?=
 =?us-ascii?Q?YYsHkTQ9PaDEgFYtW3VpT1tcVYZ0o1/VN8RWB7U1iq16hOiMEJHIBPEC9ZH4?=
 =?us-ascii?Q?00101KU748RPmKRitIMVEjGwr/y2BFM0mqXX9IalLD55WDVNUxfblCEVk5zo?=
 =?us-ascii?Q?nJCkkivbiW+SrQ9xfxDJaYPAPbTD7PDcBy/3wfPE7mohj8O6NkEF4zYD3NTC?=
 =?us-ascii?Q?ckk9lDHNUD+e6rvkSChTdA2sOQV1aVibCaQiBwryPEnQDpH5uc6vkBtueWrY?=
 =?us-ascii?Q?+HqR+J0J3pvzcPZZjTJXXmKp8jj+1mt1Kw05jgt8f7KPqA28FWlGbsjXZ4eS?=
 =?us-ascii?Q?OoOaLdHP+7U8bY9Bz5tH/FnRJYtI5BjwEU1AOjztrv4cxGVmdBnh3CN2DkE+?=
 =?us-ascii?Q?3OFxWkbytViNRXIzC14l1KrOB1P9vFV1ZV2kSZ8zAs77qjBLJqK+d/qjNTyQ?=
 =?us-ascii?Q?lggOF7aSVlzICeNVUeffU32bG7eyJoB1A097+Luec+irwQetPs271fW4U7YE?=
 =?us-ascii?Q?NtoTfTrUXGhKHiDzuu//k7idOVLVRTDEwU8x6K2RQXSeTwaDMnTHKDr3Jsuj?=
 =?us-ascii?Q?GHv6sjc6mPKbFM1/AXHXz/lQFVMTRyTXV7mbIEKamS1q3XsdAHFUoAYFsysT?=
 =?us-ascii?Q?Z3sA7xfXF7pjRlp0Y//FjD6Xy0T+0kn+GXZl0xJDJNp2kiBD3bae1WPV0t99?=
 =?us-ascii?Q?9TuK1Q9mrvWbo76ghNSMsFlvvPyZ/s3rohyEvEEekSx/3edkCJ3Z1HiXCQXo?=
 =?us-ascii?Q?2OSHOAzc2bscpwPNGTTIhj+4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f55a70-5fa9-48d2-de44-08d910df9ace
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 22:38:01.1675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLRVTrWb8WUUUv83fapGrlIYlkjN8rmmeJj7QrgLxS90FPEP1Ol+27BoQw8dv7Yb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
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
Cc: David M Nieto <david.nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Free the resources if the fence needs to be ignored
during the ratio calculation

Signed-off-by: David M Nieto <david.nieto@amd.com>
Change-Id: Ibfc55a94c53d4b3a1dba8fff4c53fd893195bb96
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 01fe60fedcbe..9036c93b4a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -669,11 +669,15 @@ void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *cen
 		if (!fence)
 			continue;
 		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled))
+		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		t1 = s_fence->scheduled.timestamp;
-		if (t1 >= now)
+		if (!ktime_before(t1, now)) {
+			dma_fence_put(fence);
 			continue;
+		}
 		if (dma_fence_is_signaled(&s_fence->finished) &&
 			s_fence->finished.timestamp < now)
 			*total += ktime_sub(s_fence->finished.timestamp, t1);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
