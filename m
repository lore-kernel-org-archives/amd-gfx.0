Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD456C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E53964DBD
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E53964DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888EC6E1F3;
	Fri, 26 Feb 2021 22:28:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30D876E1F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQYl7jYO2Cfkt/Kpf6pfzsu5zz1iCQWobPLEWstF3WasoLYUJJXN51dBQfQ4sWh4cMyLuGdjjo1MG+/zJzwcIpZ5gKmILgdXSpISYX2EcfnLNV3MIG7bxtcfBdf7TdlL/KL8MfsovigK0po71FOvIhbnv6Msedox69veoakRiKWJGRc9tX2iruhkP9bTb1LgcMAbIPEa/aCf4kV1mCH2iM0YtYZwv5XZfm+fFaxY1mmCXKfDl6b8UcP4SPIS5vO3VvAddfD+hY3uoyS9jj7PTLrVGuW6deVBK//pSQCDW4xRnUleRjYErMf1i1JxRzqNxhkoML8/4+96oxncz1qS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awbYWLdfbrYZUatg0HnugQGlKgZCq7/YNipue7EwXlI=;
 b=be1ebefGz0Ao4qZYFse8jBILTcNq4wiadokngyvm1aOuuwXYk3dSiVV8tKUFrQS5eEAT18wKcfpeR9QJCwFYJIP4jdhowCj8hkzfIkMNjJNSpTv6VG59DoQX6phGeuoUQzA2VWhwhtUJJh4wED3vWG9eq+aPtGb6d5QCfpkNXNWjlhKfh1C9XQc1zioOI8KXfS8UeuLlaelhU81Q2A9qo0Uv5yjT9bxqrL8/sMrqpw+9NtA0PaNdIE6VjhG1FggKMq6RN/qJ8WVDmc2GNclpL3itCFjQDqm0Wih1jaYV65RhK4UpDLD5ajxT5T6L/cWo6Mrj7Lj878auMijpHJwrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awbYWLdfbrYZUatg0HnugQGlKgZCq7/YNipue7EwXlI=;
 b=f73qsbVBqfKe1hvXyz2b8gf2Af5KwonzBmpnfg2V6EtK50z3O+KAU2gw+JYvuOgzLA1+VPDZw2cmdOH09G8IQj4gyQaUH0EbT6iB880tHXRtjyNe+i5nGHkLqIFcv6VoF8aNoCJq566mxxw/is5eJ/VFj9R7zDm7+ra2IYwxie8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 22:28:19 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 22:28:19 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Only check for S0ix if AMD_PMC is configured
Date: Fri, 26 Feb 2021 17:27:58 -0500
Message-Id: <20210226222758.1454716-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR06CA0025.namprd06.prod.outlook.com (2603:10b6:208:23d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Fri, 26 Feb 2021 22:28:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f820f83d-a7bc-404f-fc74-08d8daa5d17a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2562:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25622AC9FC8982516499288FF79D9@BL0PR12MB2562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCEpztNbDpaQPaDSZMF4ge6yynwFrSKyKCohDxHe0eKjN/pN4jpImZmoWjZ3agFcGDtDEfv6oEep/d2CSrfULFs7O9gL7OpaVlL2AwDXd2/gn7fKRRKYdT6gEkDKDznuk2WwFqYdw+jezSqxWgxEemj/KrkM9HEygU62bsnnDK3xKcQnSNmH6VpCRVgIsEaX1REgR6khyiZUZaDR+kZNbTQN+8Kn/SLeft73rm/txnYW/oo7xWBZkLHrJQopnDQlY4icC8bol+38HusqZNknXx1nMviTIcCrQxu8XtVRU5OIlT7effXUmN5Bbccj8HExSaLwLCmQHNZ8Nuya37xD62fpyQbxal52GyhYTNO6+ae/4HBfnxz40XLP+qu0jQ/jyO4xHPeXI0GV1ABkB8alfqZS4z/LsrFkpA8VQbq1iFTkOXnQ00PxHAUvqB8iIJd8T/ILAFXSVsAy4ukjz3CMlIrZEJ9YdSEmI+SojTPbJ7TufDrJa+eOEBbhIhNMwtSIOq6b6B/koPOpT8pAfbmaegy8NVH7qP0WGmnsMHtWy5pQalip0e4COFauVzvEDrjv8wJdCCdDPzy25hZr74OXETi43iK0YHKfWqaeGkCHvkQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(316002)(36756003)(16526019)(956004)(2616005)(86362001)(6486002)(52116002)(6666004)(1076003)(66476007)(66556008)(4744005)(4326008)(8936002)(6512007)(66946007)(83380400001)(2906002)(478600001)(69590400012)(186003)(5660300002)(6916009)(26005)(8676002)(6506007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w9XCY0RHpwCXW1xqRLtbysv5Jfezup2HxDKW7Kpo+C4i+meHAr/040XlpcKY?=
 =?us-ascii?Q?qc6Su8p2R7mFdWiF2cypCRlFf2WJf3zHOX+cRF39Njq8IzxNWbUWVmkaWeyT?=
 =?us-ascii?Q?6K6zbpOLZUBxhj5dDnxNn4QjobdA1Vadpvb+v0Wrtbyb5ZI5JGm8h2Y7GkFR?=
 =?us-ascii?Q?BXOLpT1QfTkFY0lu/kWzP7wHx0sIJWE0VXcOeG0RNrm5dQ3c05xCGtBRKxoD?=
 =?us-ascii?Q?mGH5ks4xQPgrZvLtjMWED9BYtiYSD7j/MUQ4nJoS5y3BdIwQMoVcSHmOOQ/v?=
 =?us-ascii?Q?+lhKCBBhJToDOHeuCt7Ej3f1RsJ4vyX3n7alEFnU/nG3dEXp6cwVxACe6PoN?=
 =?us-ascii?Q?8J5RDMk71VJvQTw7yVAdZ9Fbh6U6E/ROlf1qJCTOlyAdeM25c26t5//o29iH?=
 =?us-ascii?Q?oO0N+RY0Luo43u0BLQ1lBZXpsz3NiuEWYj/fWBRJFuUVFF3nj7R0DkvgtYgu?=
 =?us-ascii?Q?RCDNHZHE5fknBEbN+Oheh/Uvwa5TyF/VEz0a0657Ad/3f6WL0lVTcgv3Ic21?=
 =?us-ascii?Q?tAdLEnCC7wA48jqn2oquOji/N4G2KNtFHu3VxJpBTKMmiK/cXq/hffmCIDzp?=
 =?us-ascii?Q?XoiXnGaKVYBlnfxa4HQTblFNFOYj7WoOJzjf+9OENjLVpobjfvDz9Objo+Rx?=
 =?us-ascii?Q?Z6ZGrQ/KEPkLEsh7Il/dAOeFR/ZltezQHgRxx6819xwJeHrW11iiB6Q97qcK?=
 =?us-ascii?Q?eP9MKGPr9KmPvoakjzLevI8hUTKr7glFHT6By8JNCzgmajp9e1ShCl9qzS+L?=
 =?us-ascii?Q?oOYizsxByjCjHCiRmEj/Ujl+3f13+aW3S3p3XBSWXzdaWazakpff5bqvJYTH?=
 =?us-ascii?Q?hBS/pXGPXY7v2CXsTI6feA0Ue5kNPEIe5ULQ7zmuXIXRWPh/UDbmOCinwmSp?=
 =?us-ascii?Q?VbsMoCIKEt8BVYiyTTjrWDnmcjD7KuP7fngAFmTswkfq7H5vzz8YETWGLoeS?=
 =?us-ascii?Q?Br+g7YgG10ipwS2QJru0RVGRslV3S4irWgy4aPQuqK//ReBX2uz+5uatAFD/?=
 =?us-ascii?Q?Ns1U3MNkzoShyHaLxfF6kLPnJ8lk9/7BaOcGe124EiPv9xIXbe1F9y9miOw9?=
 =?us-ascii?Q?ZgkWN2UyCqD97CLIRqohoy6Jni3Yk2Ig0om1WUxTJdRNVmUbo6mqZI2CGuAZ?=
 =?us-ascii?Q?cdH0nsRoHNnsHVkt8qxf4xyfzEsrU0ASDoxSfgJ4gstG5+aUtjHH37gL3Y4d?=
 =?us-ascii?Q?1ESFRtNeSplVwg6DUMmVhEZUTDJoL9ZUhI3JMvw61vwkUP5WAfwjmDErD5B6?=
 =?us-ascii?Q?fvRbJyUZWrtZJocpqFNr92RVmyM0BhzqMjRhECGhgudMVUBekLc7lv4sDeIE?=
 =?us-ascii?Q?KtCOSfO2mhubdZQv9rbmmqUG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f820f83d-a7bc-404f-fc74-08d8daa5d17a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:28:19.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yW/T1n7OdfK4KYKqkR7WPipRqCVD8NzXSSJoPQRKDH7aBcAxtZ97CUepapHZaCVu9KqtBAJ21YaBIWm3h0a2VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The S0ix check only makes sense if the AMD PMC driver is
present.  We need to use the legacy S3 pathes when the
PMC driver is not present.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 8155c54392c8..36a741d63ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -903,10 +903,11 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
  */
 bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 {
+#if defined(CONFIG_AMD_PMC)
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
 		if (adev->flags & AMD_IS_APU)
 			return true;
 	}
-
+#endif
 	return false;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
