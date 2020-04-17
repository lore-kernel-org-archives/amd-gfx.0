Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B2BC38A29
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6089121974
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PYsohm9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6089121974
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1259E6EACB;
	Fri, 17 Apr 2020 20:45:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEFAA6EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 20:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM79MxHs7clfcBMWhRhdVNI7sbeG6kalE+JiUwehROXwrVxC5YPu9dcsg4oaU3+eJ3MNZZJVYXUHd47YsIp6s73oph58sj8GRqwCIm68OLKBELb+a9ZIzhmR4G0zTbRSeNfYXAtfynn8tPW52SJSkN02Sq/p2/fg1zo75eZTD/a3q7CNogDrNG9nFBqgwACPK2WT4ZiE+sx3FVGImJIg8GENg4NvOy2muwg6FlUtcc1q23IDiEt1bL36UW8x8kgLA23nGWv6+B1dDGfpvCmN7+rNoSqtFhnPb6hi8YW2onTYN9BkrtVsROEurP3eE9EmiQ9UL7g8xVj5LpZepMAJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q09NJva2zjM05Ax2B1CmErxuey2mt7Rk5SKXPQjnDUY=;
 b=UTGC5T0SVPQ3KjL8mCc6xZEWoP/DgGiVG+haOkVHg1NRYLDSTuDYhmn4SxO0N6qEp4pOqkMej7KcWaPKvu3LIO42c5CzlbevbQfgtgInvf23dL2vv08pWp1QDYwhB9HQu+Z/tJTK4+Ndmr13SInhYRaoFrSylIJlOiqs0jRPS9P8JcZX2h3QPYHRVwT6sCcyPvkEJuwHgLtoaO2V7aQqMGS23R8dfWUGa3g01vYbjfL4wwfR3ihHM0F7MBZgZP3WcvgWAhzOJAHH8V1rUc7mKznc7zgaTEcDsk84z3kkVont6d273QD6DnUsTgASQVWYGGdB9M7LDTxiVwIhJfu7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q09NJva2zjM05Ax2B1CmErxuey2mt7Rk5SKXPQjnDUY=;
 b=PYsohm9MtwQeSjSZPv3C6aWtV+guopBKqHHvYyAvjDgWiecnijudQofVmXqwy1LGfp2O0XIv2NqYTkCoKE+C4s4AagCuujywlaVmZ5BNJZWRRkj+XloTl4z6MxsI3N11Ey/XxHpubCm7sRSkNdazaL4ftq0xPGeegHHY0sT+KTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB3594.namprd12.prod.outlook.com (2603:10b6:5:11f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 20:45:01 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 20:45:00 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: Adjust three dmesg printings during
 initialization
Date: Fri, 17 Apr 2020 16:44:44 -0400
Message-Id: <20200417204446.13999-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB4482.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 20:45:00 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0edeb632-bbab-4286-1d53-08d7e31032ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB3594:|DM6PR12MB3594:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3594CEF9F7688265E107783CF0D90@DM6PR12MB3594.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(186003)(4326008)(2616005)(26005)(956004)(36756003)(316002)(52116002)(6666004)(478600001)(7696005)(16526019)(66946007)(6486002)(66476007)(8936002)(66556008)(1076003)(8676002)(6916009)(81156014)(86362001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KANz0HREBIjNU65Ps1HPT3aEhDYBaN3bhcUzYQlvqStf16GvNg64YRIvcsUXyLZVzGy8F2hsxDwaT9kvlGi1cYBHgwFasTS51Kg+kusPSql3ttWKDfQhUnWQNwtPdGxX13FYygTGdG1RcvLMeanwlmQGLNmwaaPLPSJAGeTWDEnKI9fJwhYKFkn+5tuNrTqN7WVI7D9E6hE2QBSBzRBHV4akOpMoDPp1HCRfNKirX4X/K+SU8gmPAHcokdeQixVLN4kAPBddpYh/Hj+t8m3FXaURoEjyI01f+vco/+f/2xxtENXNq9KU7DVE3xrvnaMqIa0dqyOBl+d5dVoJnW89yCqK+xo3l4qLWG6bJO0tR2jfc7Uda3bG0UgSwlS79JWHq2Zf0TkXO13SipzPA7EYB4FbvLzS+j0t/76L/wKjllZQiWN9ZC7wGaO1r1EsaEX8
X-MS-Exchange-AntiSpam-MessageData: j3+z0hqpYDzeZIPn7cyYjRvF5reK+so1YN6EsQbbPa0mJWJnWBcpeBRSG3NmTg5HUZaUc2HqTRNfOLPbSLxzlBtHqszDtyTmgj1B5D10CJba3q8YcOWGd6VzrTBbRhpUA+bUFRnkB+bd6NUZuJFnKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edeb632-bbab-4286-1d53-08d7e31032ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 20:45:00.6975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJp5s9BytSE3LZYRLMjWtIQB9HU1NkGC6lFyDJJjNtthFFHFiAkFGMwVbsgeswS9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Delete two printings which are not very useful, and change one from
pr_info() to pr_debug().

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index de9f68d5c312..1009a3b8dcc2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -502,7 +502,7 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	num_nodes = crat_table->num_domains;
 	image_len = crat_table->length;
 
-	pr_info("Parsing CRAT table with %d nodes\n", num_nodes);
+	pr_debug("Parsing CRAT table with %d nodes\n", num_nodes);
 
 	for (node_id = 0; node_id < num_nodes; node_id++) {
 		top_dev = kfd_create_topology_device(device_list);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5db42814dd51..46dcf74ee2e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -787,7 +787,6 @@ static int kfd_topology_update_sysfs(void)
 {
 	int ret;
 
-	pr_info("Creating topology SYSFS entries\n");
 	if (!sys_props.kobj_topology) {
 		sys_props.kobj_topology =
 				kfd_alloc_struct(sys_props.kobj_topology);
@@ -1048,7 +1047,6 @@ int kfd_topology_init(void)
 		sys_props.generation_count++;
 		kfd_update_system_properties();
 		kfd_debug_print_topology();
-		pr_info("Finished initializing topology\n");
 	} else
 		pr_err("Failed to update topology in sysfs ret=%d\n", ret);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
