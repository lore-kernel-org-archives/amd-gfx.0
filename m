Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306EC47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63BB961C21
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BB961C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E7A6ED14;
	Wed,  2 Jun 2021 16:49:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6849F6ED0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHcfLFGLnN2OrDjElgmLQ58Y4N5ttaEVhUOZKHWtCD/fsHqxe0r9w1Sx3xYYpWUSG/OgOCdPw6rJZhN57/I05cIyhEx9vWG1iKQ8YrEY2FSrAt8WSql7JXP1kFu7f4VdBRzlOeyvkMnUL6P6OWvR7trQ5s82301vU7jNgmyLimNGDDuUnO1KBgD0zsQ15JftEMlEubfdBlLW+DbvL+PYLXaQSRguhX/C56lCvGGkKBY5citJnkLbqPfxCAxPGAwhqooNVXg4G0LqPVH/9VHtAYcVENaB4RUs27PH2zM502k7EfuUzAU4/0NURySCvvvUFO2W8ZCywbY1bHI9FKoMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxmCf8IWORvHkSL0SP+/ht4XXpYVlkZ7hJFF8GCN7A=;
 b=d2gqFJsz7chy1KWtiV61iHTqKn2BfYb4qEYAXJD9G85DNFGJRp+wpRa32hjHaNnZBP+8o9gNvu+IW/8bWIetJMilXTXqlhPsPZBlQd6NcFlY7mVWnpTQkLUmDCGBYXEoy6yfOO+J4MgMCfGQ+dF/lFi1DqB0c4US1PQr01zqaDUFP88FxmWMJQg10lhbroeVF4KlfWptF4881dYzksJDexigowOfJtDeUvK/3b2AfphcRas+/4//+ek9IVHbUzx8oQXgqCtlNIKKUfTIsYqnuXY3iCoGSkideigX2xNWOAilIfm3EOSH4V0bip6rt7uxEJ1q7ZW1pHypgziNItU/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpxmCf8IWORvHkSL0SP+/ht4XXpYVlkZ7hJFF8GCN7A=;
 b=MOt86AmDKtQFfG5LAeptYqZtq+YFsAe8xEdLZejyhLne6wjwIOHhzNL1AGRlpb64j1cHiPgZB1YZr8BDK0+v7RlcgNzLNOIMTgcV6R8uZYgcYlppTg7SVUAyZFG+OzRIhtVx434+NdaFtx8Xa1UN+kuWx1AuWYN8zs/EaqVxzAI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/89] drm/amdgpu: add nv common ip block support for yellow
 carp
Date: Wed,  2 Jun 2021 12:47:45 -0400
Message-Id: <20210602164908.2848791-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d576689-7222-4342-edde-08d925e66522
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40630EECCA04A68B197F78A8F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pcu+AQYjmCwZUMYS0tjsM2Lbq6CxlAne8tqv4cr+MHhHvf5npZPKq18765rAUGfvej/zqSnU3N8tmRRD2vHNr4DSsQO8Apbc7BHA7SeIzpzHfC0t5QujYpD2YmGNybcLK7lF352HDiD4YeMGJb4lQ0DomXB7NhqhUSfb3hiKapLVDN4V4mIENS96yRG3ZwaGCBhD4o+p7h89S3QRfw27qLF1fpmhqDkaDfnDde2Ddsrl6C+eB7E/DboLMLbX8kb4lpXUHTXDhZTHYHH/8+u1IVdR8xafByTU3RY/BHYn7PkIoVdtMx+tXqKZnG/iTwmkjnig6NkQTOl/xEjxc/OBcTzeItBhM8Lyh2+0bNEmXHZlKUTnU6QSeXPecGzJ3YtaGOJFKN1xQlb1vjgUDseKmPyKzvvX1KPtTou4/ugKmGuDTMj7HnzkC6vkvimd6lBFVxjt2oOY+3LJnUMjZq2Uc8hJIhQPcxtHYZLmdmfO2Gs1s4nP+o63vnuqM0YKomctg+FYN5cIwaOKpXzwXClhmXCFZsqAY1IMqnX+f7GSJy62NvqrWmP4Bd4OhSTtzb6tYN8fK0E50I3GnE+0JytOUliENGSg+I3+MwrJtLBiHFRBhg/oPLGvZBzkzIDiisHmrIHB50iaq08uDkC/DH/Yt6UtwWAE5j4N1AjaCKIX3gfHU8MTJTFJMrkrpdAeOAsH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?z75kISqry3RakHCU5TTiFGr2bYTF3z21f8JEg/caD3QNBB1DQs6TDiO6Si2F?=
 =?us-ascii?Q?B7wBMvxIvA1zCvR6sdMmhEeLwqvavtUpwNXf3PsEsCZZrOusI8653kDsubJt?=
 =?us-ascii?Q?24eKTn83N/embU3fj7DUYFzzpPaISqKVUP3POPnSuUpIb8gfr59IooXvOA9P?=
 =?us-ascii?Q?QQ3l5rRH5OHPoCj+4NK0Plm/RHN7BhwGtI6jzSl72LruvPSsGU4s6vBynaH1?=
 =?us-ascii?Q?PMHAy5GjprrRuYgsH2k18fPltFI3BeV0j4BX/6fdr5rlYwOEDHB2wMIRV1lH?=
 =?us-ascii?Q?ZKZLRwksUxQMXa0x1r5nUOQ7ygH7rke25qrZgGCiMFmi4eq8+cswLWYphEpL?=
 =?us-ascii?Q?wjqEe2LBKsDUEuTwl7Snj/PVSRd7LVRUa9zYQTGRxbB+FOZ8GTY7Zve4AaGz?=
 =?us-ascii?Q?pFTHhcXarkcuGBv7wIZSpS8oDLHcJ3/jG/WfinwqPRLs7S33+ewAerfn2wvV?=
 =?us-ascii?Q?bM3YUbP6+CxzbKI5zJIh2O6CNROgEvbJMiEjnzGOdEw9BmdavtPRf/sLZhmL?=
 =?us-ascii?Q?eb4iRGgcOGrX40xXSPwLO5f/LfS/sJkLiVgh2lvP4oEd+5HD1nGCsX3dXC60?=
 =?us-ascii?Q?9Km3IYI+SxpatYjzEcHcq+XeEXoNJIFr1jkX7ymN5ZROu8zuTYFKcdqMYzmu?=
 =?us-ascii?Q?4VFaNvT9ttOH5FCdJMQzGRGhHFm0xLRK5/23rfBquP2hOKBK4QrZqNGKi73I?=
 =?us-ascii?Q?CRUusargyT4d7pKk/0Y5eLBHGFbjIL1FPqKEvY5puRnlQ06rlGbIw4D2RmsM?=
 =?us-ascii?Q?BS0HuTPAwcmENWsRreYmWrGH1B/WIPqlIvkfUmq2E+spgXVCPBx/jX7/hfgF?=
 =?us-ascii?Q?ZOjR5TWZIUko0kF599A1Hm9eCUkgf7RDNaqxlb4wwx1lFXF9EArAJ695/KaA?=
 =?us-ascii?Q?VcX0mjku7pS6Dv2pIYLZq4jZsA+8TQ5ZOihs7bX+RYFh57JUO71RVtA+x/qN?=
 =?us-ascii?Q?Gsm9vysZXZj5daexLpz2Eo7CT5VJU8wJwSEZz600CpHbB7mrZmhadl8twI4Y?=
 =?us-ascii?Q?MDYboYSdF/PJkDYY80cjf+LDIvtzTugr/9xAdYFrirJtEix+bukjBIhuveQQ?=
 =?us-ascii?Q?qcSz+rxoCQfRUn1nVa2Fib+L/CPWzC0WKG/oYAROL1DDBgkIX8b/sdcgc+4e?=
 =?us-ascii?Q?L30+0Z9eHwIfYbGK9zOx4416wYYyoGXYLea77T0O0PIr9021M9VvDVwnQLdA?=
 =?us-ascii?Q?fEFnOhBHzjrKIj4tNE1b6EgNb+GSm3U9Jy5VgjG8H+W0QlRhbwHA6xio+P6J?=
 =?us-ascii?Q?JhuORASvHV4+N9wf6BaDX8PWE47jovMpERb3Ly8WfmqEly8bvrc4sRJZ/LXC?=
 =?us-ascii?Q?RyXmpScjrL7FfzXXPY6xRXxN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d576689-7222-4342-edde-08d925e66522
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:32.0951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46e6kRZUiGPm1FMMftk7Sx73XPGGtC2ZjUwpEQSPJDj0sZdT82tMpfPBWdXDbFUCwnWOd4osCfCSz695w21D9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds common ip support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 27ba0408a2aa..91ad7536781a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -782,6 +782,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_BEIGE_GOBY:
 		beige_goby_reg_base_init(adev);
 		break;
+	case CHIP_YELLOW_CARP:
+		yellow_carp_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1309,6 +1312,11 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
+	case CHIP_YELLOW_CARP:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x01;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
