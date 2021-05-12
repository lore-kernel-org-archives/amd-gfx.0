Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3216C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8489A61059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8489A61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9FB6E054;
	Wed, 12 May 2021 17:34:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51F36E054
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHI4LaO+D9P4dyaCprcXoNOCMEYL0y1XOFPv0dqDZW3ElyY1ZMp8IJEIvR1RjFdMfzQhjMwNIW61tc8SL1sfqWp41JIW3MKOyrJZT0S3kYda187XThK34RtM41fdIHowsgaOnFz2aRV7tnhyZUr2fPDp3xi4T79tYiD21Ez7GIjpZyk94xmdJ+UGYJnr3z4evS2SaV1G35GQX1ix+NOkjoXFzQYJKTHCwrgY8zbZ2M39IdP+upP8ogbVIf0elh7AGYMfPaXvu5Me/9Ndq8+POVP9Mi2Rp7K4x65nDBj95k7nbn7zkLLaOBL/fgaUKWR9pw6CFzNVTOiFsJPAarjx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNcydMHndactJfrF+tTCOzfHFoOodmOF2qYwPV2I12c=;
 b=GLtINVFQzV1p0Z35u2I1/bC5b0E73V+/qZ1X6XVJrUX+l6uf/PN/QJ8dTewWQyOe/+P315devDMJ92vpQ7baM+zeU17gTo4VlOMQ8JzYYhSusDhxVoniMbfqBEB7BZIW35ipf222/wDBeYWJ65Odz+Ig4LNrM0yTcbvCs8welW5u7vgocEC5MSBMWVU0aesarr7mCfXnjXHve2ht0SngQifVB3zUNCG0IW3A6mtBTxrXycfZC9kEGj0NELUK4QFcfoldqizc3/qcGT+pcCvO+FoZrRtOvU1Y6BWPeJ79uKqBCffsg31VVN8URddQ9DT4abAG21MnniTsQed0Mfdt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNcydMHndactJfrF+tTCOzfHFoOodmOF2qYwPV2I12c=;
 b=AERSM6tXe+X4R0AaGAFrXUvGZ/DekrIQQ9tMX81nIMtnZEfU11HOTVbmYuctK/bFBBP27N1TZJm9TuOyTCVgoXsW/RdUY/eTCDYuoYM4UfRiQUK8z66ciYuldNgBFKdKaZfOte1I1ameOt8dxyldH0JymH7uN1Skv+n6DiJ+tGY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SN1PR12MB2415.namprd12.prod.outlook.com (2603:10b6:802:26::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Wed, 12 May
 2021 17:34:48 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 17:34:48 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdkfd: add invalid pages debug at vram migration
Date: Wed, 12 May 2021 12:34:29 -0500
Message-Id: <20210512173429.957-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512173429.957-1-alex.sierra@amd.com>
References: <20210512173429.957-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SA9PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:806:22::31) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.20 via Frontend Transport; Wed, 12 May 2021 17:34:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6475c1e1-d7e0-4206-41bf-08d9156c3d62
X-MS-TrafficTypeDiagnostic: SN1PR12MB2415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2415631CE39A9FF06BB848A9FD529@SN1PR12MB2415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NQwgOFVJyI0u3SPqpxhA80IwABQyI6ldpHemIsnUI7hlaaACcK4bsglxUX3KuCDonVlsGz5XWZmiaLcyrH0m4qwl3ys+vPGDCGnsFAsKNZ0XawUJRg552Oy7DWJmY+DySacc01F0DKP4wUXzHQ1YnrfNluLbQmmgrUFuDJhGmgHbYdigGAA0djfIbh7Tm+s30M15IMpBGMgdfACoCAAEDKAmSDqFgb9iAc9qL43MbvXwKw44ZZRIPx5e3eEbiLKNapHXzLol4T47hABsOrhGi2e3Q9Qmp2Iv0T32px7iJFPhTC9U6FaR0PsfGa7FBIfGVcZe79ZOS7uNT+EMtrMcIrOS8BeRLbUWSSHAOG6T8CNNrZU5tI5rCmMnT7rhoKtlxfe3IYGaBb7/HmDU8Ux/lqtpmkL7x02BllcbpTSxBYswHT7k7Y17n614VeCar9/omt8qJCDgfDSkSmaSgFTc2EG4bXHQfxD85ixxMqOCWmnII8DmdiosHusZL3GL8odk0j7LI+XEmDOHNyRnHOqiVwpnVrU3zWCrtELkCSVSelJpDrnjUEE94S/2qVdrHO+ggyDF2RRWH5XCLGXm1U9HC4I2brTvdqhNOJwlQCawoJqcqCpD5KGBeCnZskOrsbskPKOSaIATt+hM2zqM1M53w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(1076003)(16526019)(26005)(8936002)(4326008)(38100700002)(186003)(6486002)(8676002)(2906002)(66556008)(66476007)(478600001)(66946007)(86362001)(52116002)(44832011)(36756003)(38350700002)(5660300002)(956004)(7696005)(6916009)(6666004)(2616005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ycXCtyFgqtPE+AyEztTILJJ/dx7EWhF3rY+Rr0+PO0VidvKzxp2U1BblBdRT?=
 =?us-ascii?Q?r5yiFHlqwyKvWL3/PQWjlu5/0svkjL78ru+ZE7hzJOuKw4dKDcXoAeWszKDg?=
 =?us-ascii?Q?g+jlWp17cGjp4tTkQc+GcbrDml+i77Q5Ie9epc/LcIQm7vDQjmbsV78MU6yN?=
 =?us-ascii?Q?cEr8aPbidmTQpJeXp6UjOk0w1b2cv2WKsJc1AeDiim0hDvj7XbsbGK6eG8MS?=
 =?us-ascii?Q?D0qxsBiDinI+/aCwK1VEriZBZzP4RC5zurEunoBoJdKJ+tCs2XLvp64A0raZ?=
 =?us-ascii?Q?CK8O3KFkOu3v8LgB1NIR6XcPg2aTsd2SP4WPcBolrAoV0pkuGhshRNI0tOtJ?=
 =?us-ascii?Q?8FvpA9rXc+Lrk8wTpbWNbPL2UGXxSecs409Eykkr+SIyc3Cr3n8emN8rGYL3?=
 =?us-ascii?Q?SkxLVW6odghLLhMBObyqWcVQuutOswmPQ+oeVfvqF6gIlC4QGFz8IBH9pDjF?=
 =?us-ascii?Q?TczuHB5/Oz6OvqvHT+TJBMdryzICVXu7Qj74xSCxS7tIA2itoO1fbZw9My/9?=
 =?us-ascii?Q?9Z887vkcBUWzZfmtSIYfJ0yssxlcWtFMwKTsmFKh+UPzJfwg3r3pilPaV57X?=
 =?us-ascii?Q?11dkBbTWsYtEj3sFQAzR/M8HNKzzcitOGicq/pNzZmkEsdKT2900xWenMFnp?=
 =?us-ascii?Q?FdT0S4ThP6TVrlXixzm+IRlS8Jm63Y+1OKhMSRIWAO+wQ0WdSnqboBRFXI4P?=
 =?us-ascii?Q?9/J8f3QSyBJALZ7VctmKg70odRRyD2f8KwcPPi0D6ZUKLozD9pFeT6ZmMwFJ?=
 =?us-ascii?Q?QlVkOKhop3QEBZ0LmM3oOAkTYvgyKRW19U1JkSFV/+cLivO0cljCLHY03yhx?=
 =?us-ascii?Q?9+x/MMPAtj8wf5aJ9qOhlqwNTtirkEvp9RbOfPVNgoacf+u/P4xGokYMJtMI?=
 =?us-ascii?Q?XWz+LF9fAVXptnyEIJ1/bQt3CvG8OAIx8kmMVhxTwOFc0nsEDFKuNnevhEcY?=
 =?us-ascii?Q?BWaoFpweYySdgoY5aN0YNq8uzUuaP/dKx7ZUPd1OLMh+vhHJTYcXkOS70BZv?=
 =?us-ascii?Q?YQsAqa7HMCFJcu+mrV4fsVBW6hHWRT4kN1QjqbY/4c/wGUklEyEAjznC0NQS?=
 =?us-ascii?Q?7+icY00JYpKfBgt1qAtXqc9irgtbNk+CWXe6L8z9l53DeFWEXZ/tJfIn1Fcg?=
 =?us-ascii?Q?Lq3wdiCU+8wGfZIyknRhDhMA6D+81R3bEOjJ6I8EdFI+I3bi7AL6qRr62U00?=
 =?us-ascii?Q?UGDM33/kA7uAP46TryPxFsMSaAiSIPZvGBs0lR0Q8MDZcJUURz4k54d4wiRU?=
 =?us-ascii?Q?kdIBMvede1MVrbw4/CVs0vG/WcbaWO++43jfSpkAH1eCnMVoaTvoSakTTYrE?=
 =?us-ascii?Q?pR7g4pP8CqADuoYWYCAWXCqw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6475c1e1-d7e0-4206-41bf-08d9156c3d62
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:34:48.2356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MP2IxrrT6IyskN4TAiqDQb87dHl5v+tp3uhZZBFimV1XYM5KV+EPEqihdcPjCdFHZUHaUp1KhazMZ9eTmd855A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is for debug purposes only.
It conditionally generates partial migrations to test mixed
CPU/GPU memory domain pages in a prange easily.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index e1cc844b2f4e..4c6e340393fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -403,6 +403,20 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
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
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
