Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36946C433ED
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DF461186
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 13:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DF461186
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6C76E8B4;
	Mon,  3 May 2021 13:47:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FE56E8B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 May 2021 13:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIGEIl/+yhmdBuK7f4ZyLAKYNwwHQUidaU/KspGeOzHK9XpC+e8pfCHNXwJmMlJnNmRbyK7W4ZPi5EnNgOw8MmG18U/gJDJcqEinhvTSS5S7+7Vd1ShR9Xls9f3JWibpZs4gd3ORpGLzk31kpYLh5IdlIAMrie59qsi6e5wypl5WUYRgfBcF4Ez5RcTUmvxytEcnpmMikNhTzHsshy68s/a4co/PjwCH+Goq4gQOSEHhqO703nDunXnnC3fKyj5sZ09GFj2Zv+OVoS9YOB/vqyuyJHLXSsEXAlWC7Z/WTqLzdFZsnt4BENPFBGVG7m/i9oEJzou5E3a5Bxt+rrkWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CU805K/DmJDy9bx7m/rRTxBWvOp+dbS1nRqF50+T14=;
 b=JOJrvqN3dTCdWDuRA/428s6eDbGG/O3vsD9ZnCnvEjp58vKmnLqw3r4KGTEBIocHwlFGiREjF0plrUXVts6VZo2rDcp00DFjp9jPCyFL6s/JNEwnwsomvEqiolopjNRgN2ZnK0nFFv4QRk8qhdqgL6DNJNREcYn9TozqJLJrFC0UgF7jjXg8N2AsszzC7HqLOEDARDAKYa0Jfs3kFlyl6AXDxgwEy74Mwsv+YF7DzI2AOnJsSlyu4mrBqCWEQH5ww3AhrI/W/L07DXHRhrvVKCdCFie+wwmVEjOnYVNlimbLy27kcQKma6HTkirdOMUm/LO+FTkBsoO7B1msnvZqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CU805K/DmJDy9bx7m/rRTxBWvOp+dbS1nRqF50+T14=;
 b=jFmvoW3S7dlwZKNK2ggPYFF9Od06jQUN8f5FTJyhYoEYt8t4irHySJDNN8Yh0DuYbHeeg6jiLXp7soC8lB1qG7p1tjR5SYp/ypKYOiOtoq+pSUv9hiQODAYTnDkTjBOaFddma4hocSCgks+tDct9hQzJgnaiFBUi3RPHEQv3C+M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4288.namprd12.prod.outlook.com (2603:10b6:208:1d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 13:47:53 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 13:47:53 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] MAINTAINERS: Fix TTM tree
Date: Mon,  3 May 2021 09:47:35 -0400
Message-Id: <20210503134736.1467003-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL0PR02CA0126.namprd02.prod.outlook.com
 (2603:10b6:208:35::31) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL0PR02CA0126.namprd02.prod.outlook.com (2603:10b6:208:35::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 13:47:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e3fbc46-83d6-4680-711f-08d90e3a0c64
X-MS-TrafficTypeDiagnostic: MN2PR12MB4288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB428838A6BA72B906F7D25ED0F75B9@MN2PR12MB4288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbw8oPf3NQxjcGmbTW8ZM5pep3slfdwezxXYXv/d2/RRahh6Du3m51Q9I0Ic3959+YJazyBamIplWsVG/eagtKh9gaogTohwzytjBkIKEt7XTGVjsmXX5CKaQLkjjCF8WrxkclP0HgR2op8+Hk+k6+3VI3CJUg0EZcG+GVfRuG2T60hCTsLDL5vxgK59Z9Dlifji9tc4K8SGA+wV/5zqLmBda4FWCBAqa6r97G0cD7srDdOJ+35wV/LaoWsgZdbUO2W7ZOP4FRu8EgVWwyErMNBY8qLqGkVMiJ+LU0PrrkFPremRem9x7uw4HTsYBHOyZEKacFwBaTfJoQvycA3dixzCjhkIhHcDbktUt4mMeGXYypPxByyxdoiw05KYnRYYG1pN/690cHR5k658VTCdnLv8SdnNNG9VwreYg768XFJOjaVVg/HYzl35lRRMbOx3SZarbONTvTPAs0hf7ZJG2cuFKUwdgCL79fHZSZyYxjxNw068WIzM3uXjFXdXclUqhWS3m9snjzlgcFiTnzrChiQ/QXc4zx1lqtbq0XF2M7myRCaLNa2q/RoVqgmwgSuIqheYPfduW4E9ojlvqrfn0Jt+DkExU8/JkRl3a7kqnQc7pOLDkJOQukIWkFt8ZaGxCVbJSO49usBR1Tsu+4u+Y/p65OTMa+6Xnv5HWADTxiTAECpJW/wVBxQ9iqlVBnGB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(6506007)(5660300002)(4326008)(6666004)(6486002)(52116002)(38100700002)(2616005)(86362001)(956004)(478600001)(8936002)(4744005)(6916009)(186003)(38350700002)(54906003)(1076003)(8676002)(316002)(66946007)(36756003)(2906002)(66556008)(66476007)(26005)(83380400001)(16526019)(6512007)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FytBGB7aHZi8wb8v+zrc1TDGV5mS2aRIvOPK2iQch9x7E920CIkoZwX+Tzrb?=
 =?us-ascii?Q?jvHsdtQu0RWeUjJ+Yhileg+eeJ12zAsciNwKmxWXGQO2RP+HIHYSYg3hBKRF?=
 =?us-ascii?Q?52A3xjVZq9OqXKQo1+DSEFw9yXjpCiz4soPR/OLMBVIum9wsmziFG3DIi6VG?=
 =?us-ascii?Q?5HqggaBlsY5WSx3nHocin8lGLxYD0CcDZWegyJhwIwwgCGZJaFa+i+ELvgyR?=
 =?us-ascii?Q?nA5Bp1cZid8Jx0zbfX8foHwMhkbbAuBX/iMZqtuuNnekWFpmKsgpWvsYVDLZ?=
 =?us-ascii?Q?4+dWEX3sGPo5PnnQ+sthoX0SvPA0kxyr0hRc2mzZRMJWtnEaaTVoVqu9Ih7E?=
 =?us-ascii?Q?wcJ2hdadxpgSd4jIJCCNQh9eIAqdlrqq8qNAf7Srbe6DYw/BrNmHGSkmUsXn?=
 =?us-ascii?Q?/ImVf3Ha1lIaRvXb5bQaECwnXzUOKuHb+8Yv1O2rqbib8HZMJNu81KWVgeCT?=
 =?us-ascii?Q?tqTiuTP39J47Jtdq/fwxm+NO9LzMqSL+rGlyiDkkzCjME3dRlxiSSJZQhxu6?=
 =?us-ascii?Q?zPb2tNyvyI1NFUdEQndcTJXEjCiRa7HZcsgg8LXG4jDlKJjRUKIvHidztD2q?=
 =?us-ascii?Q?Fbsm1sEs8vhqEkD/i8a2Bpk5XPo6mErL09iloSKaKAIZFDYl54HNfRQR7lhz?=
 =?us-ascii?Q?RAIP/ufeqkWdWRz64UhDpEdSOhjb3pJ61Qy52383TAtTz3jD2UseuXiPI6J4?=
 =?us-ascii?Q?+b8DPi57PK3E/KHEf5bWk8QKYtxaZtwRT8K9UBuN+5AG0vpFhgp0AIccS5tj?=
 =?us-ascii?Q?/49x2Qths3pNNjDNKM/YMtGhmr7XjHQI5G4JpQZHBAPJDJCAjh6VNXwRmiDX?=
 =?us-ascii?Q?mmVsD1pX/k0Wc05Y8gm1pMHjmMXQjcHOQ6TTpuGoA+LVYrGlD+Dsvfr0yR85?=
 =?us-ascii?Q?xsGAlyDxnCS/RntlmxFLKNP4hAGEPOoU+8OIAQD5N5Kh1JwoLSN/h/FJi5cM?=
 =?us-ascii?Q?W9lns8DnUd00/Hk+czqM44hjAu7Nqcg7VFP4e+S644nGKh6e2wTsgl/3kSQ6?=
 =?us-ascii?Q?YZXd/mkJEONNv1/4DAU5HquLDBKdjn9QjCH34mqBEDitXs6qN13eWUz/Cu+W?=
 =?us-ascii?Q?iEqEmhaLe7UXMKQc2ILrpA8/H35NOf/G4l9HaakMpRLinJJYa7OT2AUO+aMb?=
 =?us-ascii?Q?YIv67zuzjLxmSavDHgxAJ2rDNoy20YIpFP6fSq4wj3NBFPSvCJUQqzE/jFjn?=
 =?us-ascii?Q?5XFBZGUcgC3Y4HeuPzxfXGii0Tu0TkDkIITm2sFwhXrqCrodV5NIT35xfEHd?=
 =?us-ascii?Q?PoLQlWBVIUqP5/076lAWN+3Sl//D0U8+FVn4TetY03kTFm3tEWB04wq8oT2h?=
 =?us-ascii?Q?5JouVFJxKa1PTAl5ENP0JTxk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3fbc46-83d6-4680-711f-08d90e3a0c64
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 13:47:53.3126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xmy63BM0bSCkdy0Wm4XbK2gu4fhlNtTCZ+FRW/Tp+6I+HRZuIgISc/jgUEjGd9PGxMTvOvYrsBPphAP9WiDgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4288
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 David Ward <david.ward@gatech.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

TTM uses drm-misc now.  Update the tree.

Cc: David Ward <david.ward@gatech.edu>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f03a198cbc52..27ee2a659867 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6134,7 +6134,7 @@ M:	Christian Koenig <christian.koenig@amd.com>
 M:	Huang Rui <ray.huang@amd.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
-T:	git git://people.freedesktop.org/~agd5f/linux
+T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/ttm/
 F:	include/drm/ttm/
 
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
