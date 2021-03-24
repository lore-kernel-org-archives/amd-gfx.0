Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84506C433C1
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C69E619B8
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 05:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C69E619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4396E978;
	Wed, 24 Mar 2021 05:11:56 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700054.outbound.protection.outlook.com [40.107.70.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0946E978
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 05:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzf8i+Q3hmLz2XiyLyVMAZ2//hgejORIMFnJ8gQIb9hFsxO3luBKEpmgEpmGdsmXznQo4KNi8CIVlWM7gPP0t6SS+ZwWbxYywWvOUTLo+7cMhUfuGN6lpjigPt3KEnXe3LhcChygPzRLbZSp02Ou27OjMlJyYBgw796pDbiTNoclIF2erGSe/dxxAWJMhg2YD5v+HWB9cI2NnzrU8W5EoZdWmtviNLqH0EXaG6DVfPZIfbchmfePvgFFjnrqhsDWl5/QYLOvVrx1sw0UPoPWQ/2cpZJcnlNgmGXzbJGbfgKJRkImHb9KA6QY0omU16mcqMH6vqCPa1VxuN6xU4BY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/bwqLG9vPGD/uMvQulV/grO5RKCWBHkRwkFebDC5Vc=;
 b=mnXc30pu9YKG5GtOvQphJE6NrOkOwvknsS9VKAar/Zq/CcQE29ITFa9myV1jYKw1OE7EJHUW6ftouwqIXToWFUgXYMpEzzI9Ag797PoVjYzaSYn3rn1W4rbpnl5nUMFGItJCadMGHuQG8ezDElOJ5097rKM+KGMpVcX4oNVRg1k5hgWOd+DGn5SiaOSq+9BpKWAYwyGdCPMjpnAH69CxmRiRWTWTtRWAlBmZ93gfNtgDZsdX/vPUBQWS2iAJK1UXDarc0C6Xu/V5zJZgWXTZ+qDDOMV1q0prGsTA/pB2k3P3onUG5NP2UfSn7tCsxq0N5BJsICt1Q9MQO/ShRny5LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/bwqLG9vPGD/uMvQulV/grO5RKCWBHkRwkFebDC5Vc=;
 b=bCndu/t3g+Y2Q+k278NfQHLLXdb1Un1BEcUo5BSs5tA30EJ3vbzZkc2aAd0aP84sKML5msRe4s0uLDah9W3XdfFCeFDxRvk1iSbt4L2K0qMTPvGd687RTGymesJrSuHj7ESyhUQ/Wg2DLr+JZXi0RY38vVrKIFkuGkuu2xpiCAM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3866.namprd12.prod.outlook.com (2603:10b6:5:1c6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Wed, 24 Mar
 2021 05:11:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::60b7:6bfc:44a0:269d%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 05:11:53 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix check for RAS support
Date: Wed, 24 Mar 2021 01:11:36 -0400
Message-Id: <20210324051136.28653-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e3b4b243-7c28-4e80-e51f-08d8ee835675
X-MS-TrafficTypeDiagnostic: DM6PR12MB3866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3866AF00700CC65597CE363799639@DM6PR12MB3866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eycWct9CjUTaSsU7kShhGsgSG28f7TCT/VATQZ3mT+fc71zAOO/i4qhkmQ2REu6lTp/BvtzwlqLMbOutQbb81B6+DCQti9RDhJoSoH976yxp6Sl22suOq2xCnclsAojK2ouZkQ5jtl2TrJsgNBI1W7xWf6JiiJ0t8i7DhZWIk9hzHjBjmNL1i3at3zNsZxEAbmOP2PfTq4E1/K7wwVa41igXurdbG8ULvdnCa9bG0o4ILkpWPwBectXKMUFT0vOmm0joBUSv67QCuGbMoqOXjzgIB/yGC3rD4JOJGzKC36GQfUHiaZy2xyUHS5EDeMsObD2L3Rq7J2CMctlnDQmWfCi3GJemTrlHiTNr1pqGS/N4ppX1/8ThOwyCwWGJd74Hr1sOTq6MhpIa/kIT4GguzrdrDEzLTsVboBdJ/KEnCiK3uG15hJrzdIuHUBkngJt4BmKCj0Ez6VcE2aYPSv+Ii9CqftrcsSqEkGo8IY2GIykyYIVmJKqoxh0weqtE4XT49GUad0iSMk4fikQFwjbyBIq0i+LmEFrRXWuvQvPijEcIeR/Eue7irkYqTNx5BR2GBzLzU4RyGHANxl0qNQkXP9yc3wuBhN8/DEq2uCzBth0q1N5++soD9dSuSqi9vCYrSydN2WoVPwD/3xp1zWT4PM6623JXF0U40osQP0b+h1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(8676002)(4326008)(2906002)(66946007)(8936002)(478600001)(66556008)(66476007)(6666004)(2616005)(44832011)(316002)(956004)(5660300002)(6486002)(86362001)(36756003)(54906003)(26005)(16526019)(186003)(1076003)(83380400001)(38100700001)(6916009)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?XIWsfnNDm9T2gMV1hUM2HJGHOK+NQRihHiruwyquOqCQtgi0wZN6qzMFvETK?=
 =?us-ascii?Q?zGGRtfumurBcHC+c8rADviCgxjfe8fdj2+SzTLRTQ6N5/ByB871TZd4rhtIu?=
 =?us-ascii?Q?yNYdeGhsHFqdUtIS2i68rYMU2mm4ySdwcDf/tVONfR9vOwVu8rrCnZ0VXgII?=
 =?us-ascii?Q?ITg3t0G55aPDnG7nzL0CbUanIVqh2tbw/T8RRwnDUVcQr6ObnNAZTr2V96Zw?=
 =?us-ascii?Q?TV9qD4KoZ5Dmfcu7QK4sptFdCJVc/Wqq7c8fAN4UaPjUnvd0Wfgd7oJPdch0?=
 =?us-ascii?Q?r54g5D+WBJUvBomyxBXII5XNTXsL5SKwhmBvkYC5P5PIN33o7EuiaaVtx8Gx?=
 =?us-ascii?Q?yudq6jKXjl/brV1uVfheOfEpoTSaWExAGG9M971GOLamgIFTr4fdEu6qTxE7?=
 =?us-ascii?Q?qeFho04KR4JhKzBTWCFn2RIjZs8hmAE9C5REYaXfnHqYV/ulJIrj/yCFQzJH?=
 =?us-ascii?Q?FaNA5Uc07K5DAGKp4dqMmrtOEPRJchVH7Je1owXx26iGxyafYK9x76XyuzDk?=
 =?us-ascii?Q?6XvEKjyepDJ/O1RSfCg7pMTYrekA666M7xTDlzCW1I2FgcFFphg6c8MUhXyS?=
 =?us-ascii?Q?lMoeGsbXPjJDJO0FMPoU1GWuEXewv5lqKFYwC9hFHRaHSlOpUCwKsqHlTSKP?=
 =?us-ascii?Q?6TDXcnJJTZe+stnsRUznVW7tRQ0DYzx1xFYA0Me+pdHcynDtoT/xow4iAOsf?=
 =?us-ascii?Q?7I3k/e1yRrk24Rev9Pod9Oi4ah2SslLVuH1QwwyxsS/Kegl+hcRimSfo+V7M?=
 =?us-ascii?Q?EXfcOapQ1s9i//qhT1maBn5nLE7605TC68tnchq/Z7FXj4XQolKGL5bS7C+U?=
 =?us-ascii?Q?SD3kNrCYykrmw6nvzKuShe50S5aUAjSLG7ThXvZUPS1LlAaLDZTB/N/vFY/r?=
 =?us-ascii?Q?Uh8Ds7idxZ//vB+Ls510QtJwGbVA5gtHiGvHjgJVWm2fb82NDFCBZaUaJJUU?=
 =?us-ascii?Q?kh5sJvWaY82TBTZytk7sZAiNf/Oi82o6+w5crZLkqZ0K0N80AcH1qk/XvVGs?=
 =?us-ascii?Q?6pO/+/JdhjUYYredzFq1OcFMMbjLsGNrM9iTGLxzvN87+SVrj/PoZbmpLKAW?=
 =?us-ascii?Q?bqwplDkm0KKNTRMXeOwAbgDQb9E7FOJHTTL7JsN2Wm2NRjraMp7aTlDY2CtY?=
 =?us-ascii?Q?laD9IJkFVOHZtJPEYXEKIoyUC1L2S/I45/Ec2DOdV8I3a5SgfgN9egobI2JC?=
 =?us-ascii?Q?T6EDaPcCrRgYK0M9akXIo5jyt5lrEX967j8iRvb/6EF8GAForG/53NkDfi5o?=
 =?us-ascii?Q?iwCUFQerjHYLHBNvF7XcmDejI/iDSYDNd2BCCyT7B6t2rCIFg4Ia+dYqxyXR?=
 =?us-ascii?Q?vUstkObG7bERjKnf4ZvdVZ9C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b4b243-7c28-4e80-e51f-08d8ee835675
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:11:53.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SR1LZnSGOA1Y7Tc39VWoqW6PrSC7cc/u/GO9BOODqBxx04Umv/r7uCl0cj5ojUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3866
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Stanley Yang <Stanley.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use positive logic to check for RAS
support. Rename the function to actually indicate
what it is testing for. Essentially, make the
function a predicate with the correct name.

Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 0e16683876aa..17652972fd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1933,15 +1933,12 @@ int amdgpu_ras_request_reset_on_boot(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int amdgpu_ras_check_asic_type(struct amdgpu_device *adev)
+static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 {
-	if (adev->asic_type != CHIP_VEGA10 &&
-		adev->asic_type != CHIP_VEGA20 &&
-		adev->asic_type != CHIP_ARCTURUS &&
-		adev->asic_type != CHIP_SIENNA_CICHLID)
-		return 1;
-	else
-		return 0;
+	return adev->asic_type == CHIP_VEGA10 ||
+		adev->asic_type == CHIP_VEGA20 ||
+		adev->asic_type == CHIP_ARCTURUS ||
+		adev->asic_type == CHIP_SIENNA_CICHLID;
 }
 
 /*
@@ -1960,7 +1957,7 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	*supported = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
-		amdgpu_ras_check_asic_type(adev))
+	    !amdgpu_ras_asic_supported(adev))
 		return;
 
 	if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
