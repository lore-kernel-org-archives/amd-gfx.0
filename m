Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF42C47098
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD9561C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD9561C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3D46ED8E;
	Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F7036ED91
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdJA1FzxzViVM956HmIDyngJUGnAxJm6gyNK8VSCei/1FoKDGSub+GUu3IDcH5eswV8Zwu/NpQZV67qll6CXciDH4vHL9eTCaRrjLueEUWpR/KO0m76/TquFuBJvp2vngTpuT0hXZZRaiBbWsxA1f7b2EWCpRH6hJLVrh2jBmbCAbPkpiK8+/4o+RhvM41uxwbPfgMSRb4nTdvOu+YjXai3ckxTZZRcUOKwOLYdMH/c67c21uhlblqpAlExLSV3nyokKcmDcZ1Wmnkf+79Uiy54Tvoaab03jOwfej3+Z1/VMuS6mUiC3ZYm0UkNp+p2cxwIq8Su7MzSopiBRiMeOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI4gsp4ME4YlNDYdMmp3pfCCehtcXz28R2pX7mCm7wo=;
 b=JfnR1yTHOyZ64g+ynqasseX6fIGQNGpKja6Q0hchC2p4u+WG/qOMFACjFlVa5HcYwXB+A3fEj1OzjxOcHhVXBcqWJ59haoD3b/2il2l0jBA5wsOfE+O7yEjGwcn0sr7dwjmbWsx8ph2cyZEuHksv2UCVaHxBjiajkvZC2FM7vWfR4MG1aOnHO8VvOR8+t8e7zzuNMuEPuvaz1LXN8qjAEjisYexf5wc3uQklNkC1AZRn3zAEnM42LCi1kRmCR8c8pMP6/Z2Wo9MUMnLD8DSXESE2yl+gBSxljeL1IJZuDyzv7IEZTv7/1mUpsTRC/qBl0cvHaR0NJbxLYJhmfmWHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI4gsp4ME4YlNDYdMmp3pfCCehtcXz28R2pX7mCm7wo=;
 b=2SAX+S0Zu2CQoFXTGwC6OpOX4Cy47S5UtZc0e2nED8/mLEB/KOKElcPGWmJUzrHZfQ+6yV0VlGyW6JDeVbdQGApIWGqV4LkZ9jwcdac2sqTJQzxRHN7g480PByNdXZOz0csQG3G43uVEgxr7Uu7cJ9rDIbYAlXboFucZJlP3yGo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:49:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:46 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/89] drm/amdgpu: add psp_v13 support for yellow carp
Date: Wed,  2 Jun 2021 12:48:05 -0400
Message-Id: <20210602164908.2848791-26-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 831fe356-b6d1-4c65-9ffe-08d925e66d6e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40636478EDF9A4B719DA2344F73D9@MN2PR12MB4063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RtJZ5Q5WTmtZokZ+eAyTlYQz8+s/n7DzXyNGkXW/ba2AOfsJWWDBYPSGg33qGzNL++1K39u0Qmy0kMgGhdz6QU4Q6IkN6db+/2WjEgcIBK7Lj8WhTuvnwlgupsQeO4HUjpj+3BajVwAPi+C+UtOQrzAGOjnQOiDEZP2tVaJQb6xaFjFRUJimvLlDrzNApbiFpX4aPXozELwiS79kbGNw81VRlmWokF5g0cxBmA+XYvvDSPKBsPFCCh+lTm5D0aUSjtgOhMhfVAmFXGGk5slLdB81m1zBArvKWXrYPBceV99W0/RUDm1a8oVPf/y8Ln2VIwa72rcaKMqesVL9+lXHK/lt69YaMKWM6CBYia9B/tAvvJthlsxYDJBt1+Q0QXLdqdvniOHAQHYU3wC4eDPyKphOoW26+R0n7H9X9xUMhr1KirleI/LRW7vwebwYeSwbEbmeqvoebxQHBgZmuXSitXDP/CmZi0RkBa9LVXxI4m6oHVniX8sq3InhYb9t8/fuapkQADL+NcbqjGaBBcLdhUwcW0UNAy3SUgvJiIVpgMyuNEslPW+G9kOCSl7uXV2L2uEwXEYDevuFSAPzl5bV1XFhzlwjde3CtaiFA16E7yqMcpPQ6SwWeJVbTbGXkNyE2+yfxPdWxqcu53UdJke+5yo54SW1RcMiUJ27oQwfucsVRuRdnSWaubC4tmLxZzsN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39850400004)(54906003)(16526019)(186003)(316002)(4326008)(52116002)(38350700002)(66476007)(86362001)(478600001)(38100700002)(2616005)(956004)(36756003)(6506007)(6916009)(2906002)(8936002)(6486002)(6512007)(1076003)(66556008)(6666004)(5660300002)(8676002)(83380400001)(66946007)(26005)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wfFuv5WIsBJfO4FlUXb9GuPmd2DxnvA9ZM51WNK4/GwjpWBS6ghIW+M8q5oB?=
 =?us-ascii?Q?p0HCI7h/IBD0PAAdSr4ipGW3vlwjoMZ6db+FgKhlth0y+rQRoHOeScHBmJJr?=
 =?us-ascii?Q?hD9KYQ/Uh3hM6/eNxg5iykTktdN4RSWVY/+dVfHQpsZdnt1MiOwXK6VwcQtN?=
 =?us-ascii?Q?xyskAyxX5CukGPAG6vWlRLkefKFt/bFNVWu6/AgFUsrebCfChRIdU+k85jGc?=
 =?us-ascii?Q?KOI+wD58VmCTPmAlPEk/W0sGvBkmAHxx6sE/DksMuIhzxyngKVEqkwCuv28+?=
 =?us-ascii?Q?8K5jOL37GSL9WAYlgZ6h7B5gCp9PSnb/bV9kcadeKOrZ6Rlr740rK8Ppz2Fv?=
 =?us-ascii?Q?vdHLW22Fl6jAwGbVvGpyWB2qmMccFqEDHtW4szcpt7QbJ/kykoJIMHbobpGl?=
 =?us-ascii?Q?QrBShywKL7nYrlQkQDs1jPnp94fb98yO16seMh39K54CLUJ5k2uF8LChk2pS?=
 =?us-ascii?Q?fCereMB0cDGvGHi7IRuEY+BEIvdWEJkCjC1P8aqkIErx6KK6JY4ecFG7F9IA?=
 =?us-ascii?Q?ze2oylsdZle/I5/m5jhMz2BbjtiDj05oDHshxUnk1zK5uteH2DG1H+8CScWK?=
 =?us-ascii?Q?byiCFq9POV9PEVUZXlryRMZIjL4d4rBMSl4E7Bf5RHCNBhH92hpN+HPwF1u1?=
 =?us-ascii?Q?nKaSlAvycK5ZFqdGOMjqiq0cY7kvaKLLT2hnUqf2LvBSSAz7GIDX9cevibtG?=
 =?us-ascii?Q?+aHbUtAgT6wWrSetKSQa8Rgz0QWInUgAew7dAmMc2R10nHX8MaO9zdKu4GNQ?=
 =?us-ascii?Q?pcZjY8gVEa4Vpz9uAXgS+c7t5BWdUmr59+TQ9rcaq0+69ulmubWJ+U+CANCJ?=
 =?us-ascii?Q?n7TOjcCEQt5pBbWTAleuArIUjYOLoC/lex1+AQlhDy0QD19bPRew+AqFbTI3?=
 =?us-ascii?Q?iCEDqG3Qz42oXmsLSBB1/KMFGkDoEpIczifqxN5nUsrmf28C4l1hwgz002fW?=
 =?us-ascii?Q?tBqkTPF0zxzyBVRl/QTlTWvf2eXRlTGUsXMTZUk8L9/Pgja+xeZSEYHrPb4i?=
 =?us-ascii?Q?Wf+B5kHWQ+Upvwt8kE+Q292Snu52HyX02mdQGRBm4c8lPL9+zasKugucfqHH?=
 =?us-ascii?Q?Z70WyW6KjEwhHM3QqmDoh9PcDHpsj0ArPh7L/Aa7VjlY9w4HyY/E35ifoMzm?=
 =?us-ascii?Q?rtynQwoDDjpLzeA0jRRnt6daDCFB/cwMekArWbuVsFM1lCnuzc2z1ILiFyT3?=
 =?us-ascii?Q?buyXYfBRs9nBnloxqYZQSBhQq4nOEysKOM8Fjcw51xV28CLeUorW8cCjNqmr?=
 =?us-ascii?Q?3eGd+7i8Og2t9GF8L5hdGt5CF6mKLfcaAFhaO/WeHP60abMX7xR1S8xYLwtu?=
 =?us-ascii?Q?yO2dwZcojWhjNfxooalOv2v4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831fe356-b6d1-4c65-9ffe-08d925e66d6e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:46.0558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wgg8PeJtTWAkz361RH5Dfhl+rk1ZxwGn8QsRJXasWbkvyaBnHeYw0A6J6PzOtqTadJox1veG1U91MmJaTBSDyA==
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

This patch adds psp_v13 support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 33 ++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index fcdce46445d6..2b4916ab684e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -31,6 +31,8 @@
 
 MODULE_FIRMWARE("amdgpu/aldebaran_sos.bin");
 MODULE_FIRMWARE("amdgpu/aldebaran_ta.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_asd.bin");
+MODULE_FIRMWARE("amdgpu/yellow_carp_toc.bin");
 
 static int psp_v13_0_init_microcode(struct psp_context *psp)
 {
@@ -42,17 +44,34 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case CHIP_ALDEBARAN:
 		chip_name = "aldebaran";
 		break;
+	case CHIP_YELLOW_CARP:
+		chip_name = "yellow_carp";
+		break;
+	default:
+		BUG();
+	}
+	switch (adev->asic_type) {
+	case CHIP_ALDEBARAN:
+		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(&adev->psp, chip_name);
+		if (err)
+			return err;
+		break;
+	case CHIP_YELLOW_CARP:
+		err = psp_init_asd_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_toc_microcode(psp, chip_name);
+		if (err)
+			return err;
+		break;
 	default:
 		BUG();
 	}
 
-	err = psp_init_sos_microcode(psp, chip_name);
-	if (err)
-		return err;
-
-	err = psp_init_ta_microcode(&adev->psp, chip_name);
-
-	return err;
+	return 0;
 }
 
 static bool psp_v13_0_is_sos_alive(struct psp_context *psp)
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
