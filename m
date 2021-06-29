Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C5C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A434461DD7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 18:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A434461DD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61DE86E8E6;
	Tue, 29 Jun 2021 18:03:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018056E8DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 18:02:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCwzU271lxFV+eDnJcsGy0p0Rj1SEjJiM/JXcMADj0z/+XOfMGIXglKozrdWPwMYhHjmTkNFyfujA3Dc36yLwzo0dlK6ir9uwc50Pbnhb2dvqFqCqMDDehvtjgDMxR59y4zOjcYHrVz+QGL+j/pLxwoZ/es1al4uNUBBhrXUqwGNr5Ng6IP5SIoiFF/Stynf7E3i2+8HNeQdGD9e2qHN0UmLbxlXQ/qe/Kko3t1JX2VjCX7+N9E0M0W2mlBJEWLBt0CxqZi/qvPtZ5ziwcb77HHNM+nlScQbMJ4Xh16O3uql8DO4Teo8onECZIjHkXgsCw3UQ1gd2BBSjQFJs5t7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDZtq/BPd/sZ6+W36IL7aCaDKKIgqETEZo0IRYi+2cI=;
 b=aEoRTGVD98LrudiyBaB/MhFzmew/SbvEIx0TkICXhJUdPKmaguMBl/6Da5F0XAdvhTc1iCF6Bvpng5k1oXOPFmnFlzCWuU0tR2uJtvWn3ATEgBdTj+cRmTvw+NdVYUVyuYadD/peJYy4ltTo0bMCQZv59O0uTG7EnXdcOC8jrcaONDQxwbzK5xSf+xjR7waQbeTqkuPGbBbD4FZ2HeZ66A1FC4WUNgA1oOHs20VV4D6sNxzNehascSZ3jDQbI3Bn8QA2siy5TfNRv2rier378dLD0EBNgFZ6kgh/2XaguCx8YBPP4seudwHx/9l0R8E77BNQykaofEgY5kuIKzi7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDZtq/BPd/sZ6+W36IL7aCaDKKIgqETEZo0IRYi+2cI=;
 b=Syba5QarOuWZu4lQ3tp8ja0FyEUhGjm82KE/rJJaHONYKQqE3mD6KR+GBcVVDDh+9T8Y2k/hrn6iPe2B5l5HzsJyB4bYVOhzmZJWQ5x7e77EXrkhNcAtgDGbKSeZfYoH/ldY4gXGTYZGCceuky/bIWgO3uRlo75ed1itk3uMfzw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 18:02:57 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::5ce6:fed4:e00f:27e4%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:02:57 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amdkfd: add invalid pages debug at vram migration
Date: Tue, 29 Jun 2021 13:02:04 -0500
Message-Id: <20210629180206.8002-9-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629180206.8002-1-alex.sierra@amd.com>
References: <20210629180206.8002-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::27) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 18:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 594c54e4-0a64-4fd3-cdcd-08d93b281fb7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB254223BB9BAE8B702996C910FD029@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EZkpeNeJurl3rk2Q9dexdBKP9cySneiquTvBfm+L3oHxmpokeAJOdVsLjKXRZz3j//8OUmRMN7V7WPapFm8Uea+XZ+vBKMfVVuedvjT9A6pi/v5vm239sUAWRT+0WOTGhq/1AjEQHdHJFCneej9AtNg+tJa6lI+C7r7LdQfF5q9txR2JzxtlL3n1NHQUUCLy3drmyEvqleDz+6oovqobEzDH5nHE/ykPY/Oc4B0p3wNwKQZ1AjNKTGzmmiYQXZt0Ma6ARfKN2ZpFz14WKdNY1spEhKTTZQcHdcSadPI2KOFJCNs75bC+qHCBbiyFnIUzoRBKZTh0RgraZ6proIzHgM9CBVQd97gexmvVntU4ikMJcbnXLGWZfeoOcvL/7NQqQURmKqMeWQphk7hgdaoTqkkW42ljWBXLQvUqbfCB3ytLDTPBJKjQIjKinogzVs6mm7u2MnmRrAkdd/apwB0fFZp4RZam6zWmewBylT7R48L547b+NlH/Vzctcinav53yD2Bx2d+22irzINjWk5fCPyZvd2kwM1MzCiJR5nFKpqD86gU8T7mJ/0gtnxpG2LF6P/t9z8HZEHmnN6gQZeFBGELvN/PXqkcgUKyvbF5thEXXsrExT2qxxpm0MCSKUnMFY3JrJXdmT+vDQRGDjfUutjbkWwjKqzuItqVw6BsTesCfBf3vdmkWCPDLS2US6ohKy5OBR0RDBeOM9Jf2Z9XoEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(38100700002)(2616005)(86362001)(52116002)(186003)(4326008)(44832011)(6666004)(6916009)(7696005)(54906003)(956004)(8936002)(16526019)(8676002)(38350700002)(1076003)(26005)(36756003)(6486002)(66556008)(66476007)(66946007)(2906002)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kxQGCjArC60XKafk2vGYPzGBtDXJLqKkveDLVvp87GSZW/E+GMYA3sPc1J3r?=
 =?us-ascii?Q?LVSsb6BmhpZncSYvFPf/A/8QLHqIiNt2N6FX9XAkQAbG3Lez9EsMd2XR7Sa8?=
 =?us-ascii?Q?guvGGmIhy2LcGMj88KPBpsUjkOygKk9G452LuMT9iKdSqSf3OOQLKN9m1PQD?=
 =?us-ascii?Q?UfpS8jCcoKSGuZJ9hoDwJrSt3UgZADUFyOndbGQbYAHeiSFIrdosJHPYFfiR?=
 =?us-ascii?Q?5N+es0fS4A2PtGRusmJlgoGzAN1S4Wka5b+q5/rb9Jo7tS2E/bMU4t1BZdwG?=
 =?us-ascii?Q?qCozVEiP61F/bi7iIysllfDxwhg/6QrMLG9VpkUOiqSo30IHbS1ir78+bTEa?=
 =?us-ascii?Q?F5PVC2+AYmmfH4xFxrKGOWJd9QcQVmpTXF1XW4iwTV7LewYnonadqwXRmt1A?=
 =?us-ascii?Q?WYtYVEO5NZAWnGbnM3xNXf/ya0OsjVXGiFt+0axtI8Qtyct67Je2tzT9TpEf?=
 =?us-ascii?Q?BIUWQEeiOE03VTMzp8ta1VvwlEgDZnvNxLDKNfQ+BUHUno7IjKUyf3LRWtSR?=
 =?us-ascii?Q?23XRP2iXmYqrmjwRnm7FSSs9JI5nJQr4vzM9QGEknR7Jv/fMF9AEmza6RMxG?=
 =?us-ascii?Q?o0f3rO9yJfPZ1W4u69mpVQL/k2ddElCvCFcJ93iaCPhI47tM22eaVVcIlVb3?=
 =?us-ascii?Q?dcThgXjSv6s+lJ7Xk2oi0Z0mm/Ly+ypTpuGW3RS/MO0UAlopiXiNN8/ZhY2k?=
 =?us-ascii?Q?3PXTTk/GeHzJ7ztrHakg/cvkBEW6o4nWDi2j4e29MgNshjC0DBirGrkPt4t+?=
 =?us-ascii?Q?AY8LwJZE1VCwVHPz2ppLjGD2dgt+NiMwkhWyA9ziyFIHbXdAgBze+JqKNgbu?=
 =?us-ascii?Q?zVIayi/IkOXy7Xx5zZ/BDHYzA+venVUIbTdQjyaazmrgkiSq0SkkWVJGEOqg?=
 =?us-ascii?Q?sc+uKH7duKfk+hEydE7tOI9D6qUzv98HomrhUraWs737IRUa2uFYKXb2/4aS?=
 =?us-ascii?Q?fX7f9HEL5//Y8hKSV5HvUuCaQxYzbQC8L4ColMjVVcw/GosBzVoG7PfLgKvV?=
 =?us-ascii?Q?Ia+8OpMLjj7Tc+8UmpIJT4da16gUk7BNnz/K8Ou1+Dw16REMtzUYviRC++eG?=
 =?us-ascii?Q?ozdpDeLtOvsuiCa1R4V59v/+cX2OWtOWcO+3NMudCCQRUNRPaf8xt0vVvgFG?=
 =?us-ascii?Q?oQbmNEt9xKBnk5iQ7r/rrisVh+4QMr9hfgOPsxUZ9UcfUk9ERgt43GI+U1LW?=
 =?us-ascii?Q?XcbVKHFHTM1h4En6uvNimdB2eprPA0piTaxHQccvE7XitRbUgvgs5vr/keoM?=
 =?us-ascii?Q?IzX5IBVF/uglL0iMcsky347bKsL4LIy3X0hUkqB2ewksAFMyIWFa+KcrsPMd?=
 =?us-ascii?Q?aewaexsOT1kMeAV+dKw7ROkZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594c54e4-0a64-4fd3-cdcd-08d93b281fb7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 18:02:56.9283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BjtyVsRHElnlKPVVADOIiESbpmFNJknmUeppukCZ6g1MmcrTTdP6e31ogBLHsu4+AvuyiU7SLVM2SF+sg/xeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
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
Cc: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is for debug purposes only.
It conditionally generates partial migrations to test mixed
CPU/GPU memory domain pages in a prange easily.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index ae360d94c06f..e9490236c7fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -401,6 +401,20 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
 		}
 	}
 
+#ifdef DEBUG_FORCE_MIXED_DOMAINS
+	for (i = 0, j = 0; i < npages; i += 4, j++) {
+		if (j & 1)
+			continue;
+		svm_migrate_put_vram_page(adev, dst[i]);
+		migrate->dst[i] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 1]);
+		migrate->dst[i + 1] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 2]);
+		migrate->dst[i + 2] = 0;
+		svm_migrate_put_vram_page(adev, dst[i + 3]);
+		migrate->dst[i + 3] = 0;
+	}
+#endif
 out:
 	return r;
 }
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
