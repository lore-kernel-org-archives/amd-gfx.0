Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D891DC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 18:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96C6561265
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 18:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96C6561265
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D4F689B4D;
	Tue, 24 Aug 2021 18:23:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A89989B4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 18:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jyk9Fq7qgerbBXDPvc2wtIYURJZcy+6XGKCA7xUp5a6ADZjMhJrLekVxddyqZMTigBJAMLuur/PAyFrWTxhNEKacrhbJDnsoUIazOLte2ZVUkkHHm7LlyH1pv2oGQmWBLJAFZO35OUAkzRuUPfYQ6BoOOPJfbAdt6xKaO/1smrUZbCZF7DtnZy8VzwQ+ythKezfSFcqAqVs1dh3pg4BlJ5gtrGPDOZKU9k4/sCvawVS+lH4tFIv1/+s3JgKoFqmMNjVbgsQaGtkFrZkJjEjcvQ3kfeV/tkJm6LfdYp+skDVgi7qe+BCLtBJ7VDjGCaykLY1Yltl1zssF4eKNcvfPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+R4ITR77PU6hAKlsJzguYzrzxtgC0Ap7F8gatDbYs=;
 b=TecAMTw2GzNj3+WffA14qEaHeY4KF45MBeyAOOQXj99yONywyCT1/mDJqdKvkJB9Ke0MFWl9cdhFc8kW8dk9HURv5I/rWbr7c6nxQaKUfbWwgZS4htf1v41Q8/YdSwtdxvD8ELiP4z8WnjxUxxYQPxVX3Qc1ZVxtemFf5BbnOmDgnX6hc8SJJgvS0i+7mMFObWZ2MyKN1FlVJZNgerc0mrivyoQL2pwc0kqvwRGroBuZxeG1PbcWrSJe+tKkODqubRzLjB2utBsWgJcJfQLMniTOHwKYBvepLPn3QaIaNNxLO53Aauzta0QhGB80YPmmUV8OY3U6d/F80xvDbPqCnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7+R4ITR77PU6hAKlsJzguYzrzxtgC0Ap7F8gatDbYs=;
 b=SgCY+VSf7ZbzFAP9rj8LJbr7ssER+oxR4KuKPc3WmZblLI+vTS5+NeJ9d93U7MsTGGPX7JCZ+3dpgHtpoWm2TDnr9OEVk0TCR/O/n9POKFMeklk7UwftCTAvnXGtCavY5b7ISHxpsUx/C1QlFUaix9auhn7tnD0oLEnRqnUk47E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 16:51:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5dfc:ea54:4a18:89f5%4]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 16:51:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/8] drm/amdgpu/display: drop unused variable.
Date: Tue, 24 Aug 2021 12:51:01 -0400
Message-Id: <20210824165105.1913700-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210824165105.1913700-1-alexander.deucher@amd.com>
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Tue, 24 Aug 2021 16:51:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75376fa0-a306-4d04-10db-08d9671f6771
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317D40C938D7D1626E23088F7C59@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6T3uY+TZGTHqnXXUuGNDeuDgyPTf2vii9UnT42b6Jh4/2KrAsXvKeKHChTXhnAnIozjGuc1FNqrRoCVVSI669IcEowaAVqU9AW/Vpny7KCMymn/hEvjn3XJWpUFstbQ2sZ65Pz0IEF/m7/zSbaEWVWKSdWkkf0rtYfy5v+I8enT8Dt2GveoVftCTwkHyc7rISJKHHnyQNLa0JHTjpiY62dOwvxq3YMih/lj4SwbxuDNaUbP/260R3QsO31qj5QpZ1YoJl4+gN8s58hEISQPXr/ljMffc3nD23bdrHofp+u3c6NVY1SzuD/JRqfMOAuBwuhPib4+StGCJRrrzdkruTUivxMowjAh+Fhf5zHEbu8WWGarIiUaEvCYmkSn4t8h0UQwDriYYwe/P3SSHsdu2NbRQWcP1KjwRnyg82+xzYf9vIThANLGm6AVtIP6rJAj3CZukPcorzPJRU3ukH1tIS79rdmbkW0KExZ86Li4FpcXOneMbIJoYFHuuTjdJMXBQOx6oXTSPvB7MAPMPyzWr8d6QKrPBTGSqMbsnnVRudRQ2cxnejXCZC8IRjmj4ARW47fctYnJP8TVaq5+ry7eISeJXMEiq1vjyGS2NguX4CMVs2dvPprdT3I1u/70AN73vINiXVfnZp6BnHD7ASrGag9X4DpL5bQO2rCtIOdnrP25S28VNmqIpYvDwOmd6xAs6IVeBDcQ0h2W/SsYRN11ztw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(8676002)(316002)(86362001)(52116002)(7696005)(2906002)(1076003)(36756003)(6916009)(26005)(66946007)(66556008)(66476007)(8936002)(83380400001)(956004)(38350700002)(4744005)(6486002)(5660300002)(186003)(38100700002)(4326008)(478600001)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/dFYglI2KEhKoA3suPBg4/irL2Ya9lUOJbob78ipi1Q485Zmz2kr6raPJ5Gt?=
 =?us-ascii?Q?ECrQx2fsOGEM8Lx1nIooMnef9jd782DzYEpfRBMWznihP6LHQXniU2BO442v?=
 =?us-ascii?Q?QHKozQBPdjJSUSs+AbzQwXBaHC/yYowXYepwgyDhJGJTZlGP5rfd903p67PL?=
 =?us-ascii?Q?jpN+lCGw9RhSk0+kwN93cGPDF8QFVWCPx6Qt0iotJuXS08OcMif7HK97dUK6?=
 =?us-ascii?Q?Fwc2QdjBotxjSfnmFoqFv58TnzMDLlBMObz9oEviM2sn1zjv49lbLWvz8Ely?=
 =?us-ascii?Q?hxaNPme1qk+ZChvTIhXmBcr7XjmvZ63Wm0N3ttr0wv2v248NJlhc/jlyVmew?=
 =?us-ascii?Q?jxwLyDQUT1x8rf2Bia5ziaWRp3QQ0opRTKDttyb2xUVqpCrwqdXHh9AhGBKU?=
 =?us-ascii?Q?g15IhC4J/4qHGjpA1nfSv3knC2UZhy+vjyqiK0rHQhsrLwOJSbZvQjj4OPjR?=
 =?us-ascii?Q?Ffjdv5ftBlvYUI114ffdSl8eOXLsoO/NStiQSSqbMUGDsrYqPJMQf7Fbtu3q?=
 =?us-ascii?Q?w6SpjNi9HfdFCXJszVBxgnwBbX0EcqzXJq5Ikhi7qk51qWPGOfoUEankUywq?=
 =?us-ascii?Q?a/E/TprOSVcUDF7rXyjHThUWCtnqN0iu/7wATJ5M641aXriQzLiDol2HMLeK?=
 =?us-ascii?Q?PvmvdbgGXgHfOkTMxFrppJGw/gvR+ZKLv30fN80lU8G9hVk29CI948hHhCAP?=
 =?us-ascii?Q?QHZgQKTkRV4gJc4JIe/1WH9VEAqzNfjD4L9IXEPlfvhZcAsVTgwvqiiSAVSf?=
 =?us-ascii?Q?0nUux/gWFKBEQAKGYlpYyYzyHo/le+XpiniRdkVdDHTJuGVhg/iuFLJ7wH3F?=
 =?us-ascii?Q?EVqlxnaCP2+at1sM79FGmM+9CwdF7TprjR9k1i3+lO11baNGXnJmBy6zfTx5?=
 =?us-ascii?Q?R3QQkgoi52/eY8Ui0DY5eq3wv37fLqIqsZ3TbL8D+X0ixcFEpQ6PP1u2Thao?=
 =?us-ascii?Q?dkheRJjc6D5UbOW6ulygWzWK3klPHuGvkZwI8GHIA47/JA2W2NzaCOmWAmrQ?=
 =?us-ascii?Q?a6OcUnL93CMN+IIloV3J7nCN+4LirNSwPTGJyooqvp9OdWvZGhowU2kSpNYo?=
 =?us-ascii?Q?9YD6N2vWlOTFYoeRkn8sNt7fuS9+WwK+I6GlsRPNU73QJ+YkTLJYe0q9JimS?=
 =?us-ascii?Q?n/mz3wVbh3o9G4485icGPds9LiUGiBlM1mjg5oZTVGycHHWRyS+7N4Os6ifN?=
 =?us-ascii?Q?Do/rG9CSpEeXWWlMNuN3ZfFBE6EkdXiVNeG7VA4K9KduuAGyaA44hj7ORO5L?=
 =?us-ascii?Q?NAxBp5ZHOGJ6xm/rAvoXi4lkQ4GfS8+M6Rfvox7kSxi7FtisbX8lpg5bAw8e?=
 =?us-ascii?Q?VDCa+gEakT0c1LmUzU+cnWIU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75376fa0-a306-4d04-10db-08d9671f6771
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:51:22.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLBgAbiaGBoJHPIe+PVX4kRYu81e722KP1lx3aQoIZQ0EP7rlJH7JbVD+9H1WNEbm4P6GpRFWVQxKYbIySyEjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial.

Fixes: 808a662bb3a8 ("drm/amd/display: Add DP 2.0 SST DC Support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index bdc7d7ebee12..f58d3956f3e2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -186,9 +186,6 @@ static bool create_links(
 	int i;
 	int connectors_num;
 	struct dc_bios *bios = dc->ctx->dc_bios;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
-	int dp_hpo_link_count = 0;
-#endif
 
 	dc->link_count = 0;
 
-- 
2.31.1

