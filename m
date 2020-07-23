Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB23C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6F020709
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u/QUX3qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6F020709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FA76E193;
	Thu, 23 Jul 2020 16:10:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431726E193
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 16:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M84oIT1oB0Du82RvtC9XeU3sVprdB/fgj0oNnfgtl0BOhBaLadIz/Cfq7yrV4rXkAdr9+nK3sUfzWIKbc6BZHWK9LmsJOG78Dv8L70rJbVRYx+rr7Xb6wN19X7QWzqPToRnUaY6KRC6TQzqaKbgkPjCyNxYUS0eGHlAKj4XXXsVy1bH0T8FRqc92gGxTf7nSpIZ9O2mtrqJ54HrUtgar058SJlXOFEgZtBy3H5qf7p6WO7aJdfEuVnhDvnoZuBORxSSpVR93m+0zJ/3Y2amrzUFh4bvRI0rhmXIxCQgFj+5v3YNR6a6fz1+R4aaoJlkz842YT3qe8/fyIKacM2zn8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugzlkbUuNmZhMXOaXDVvFAi3Rm1tw0fLg54jpZZ+Pmc=;
 b=Ocw4peUntTo823FhHTr08nei08ivCzn7R2C/azzx7JmSVyHYsvdUha9WGCKNhsd44cIXkJN4wJEGuBQHotl0JPpcIV3JqFLDACMzXlS5vV04M05mQ2UvnyEJ/OoV+qQuxQDBsGUpHn3AKSY2rCSY6JTbQMkjqxNZF+GLoG8TJV3xSdB+RiJYjqoi4mtsrA0ENY57KhfsZYNQBpA2F7RPiKsImC5Hu4In6MIT2zI14ghFhHrkJuGVvGXXInLPQF01IbmhfimPUIPeNnhjFdotvoBmS2BZ+7sgQgvw8nrq5y4pu/aXlmnGxYSCcIIwYmAcje6QPCDVq+qq7Xmu25ug0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugzlkbUuNmZhMXOaXDVvFAi3Rm1tw0fLg54jpZZ+Pmc=;
 b=u/QUX3qV35LdIpTmjqV5ovHPryEF/joN7hxwzdJfzbhmv4QC30BpiezylST7wKzLvv29D0GN/HRSwZlKZ5/xitaRnTWdFvj0bntY3Q5GdsUANwEaP0eINfqOaskPmiCuzsDJxMTERsToV6UnJFUAJq4MHOAlAZDn35oGKLjPS4g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23; Thu, 23 Jul 2020 16:10:31 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::7860:3c62:4087:db16]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::7860:3c62:4087:db16%4]) with mapi id 15.20.3195.028; Thu, 23 Jul 2020
 16:10:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/vcn3.0: remove extra asic type check
Date: Thu, 23 Jul 2020 12:10:21 -0400
Message-Id: <1595520621-8216-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595520621-8216-1-git-send-email-James.Zhu@amd.com>
References: <1595520621-8216-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::9) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 16:10:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2df7b55-61bb-4a58-f442-08d82f22ec6b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27487638A7E22C1983492571E4760@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE3x5FECCPKo9XGVQTU8qqWqlSiRNoydyH4O5VtanwLBBRiGWBnGuuXkKE0pmuMf0rKE5fuOoRHFxJTCehRwyY4s3S1BeQLnoCmhSSnWtAt/Mzs7Buh/C8PyKRxAxrSu97T3P9cq3S0uYScSi6UGDcZveFLri+atR54lPtG9fixs4F8g0LvV+8XMlWFeFWAMaJHayt3irdKCupZYqSf3O41Cem7T6O9zzOq/0XNZS94jqJvwDe2SvkNyzakIdywYHNSRFM+RO2ImgQhOn6jHQux1IGcGTHnYMhRgoEhxlC9bokloxDNdoiLtuHvRewQZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(478600001)(8936002)(8676002)(36756003)(83380400001)(4326008)(86362001)(6486002)(6916009)(2906002)(52116002)(7696005)(316002)(66556008)(66476007)(66946007)(26005)(16526019)(956004)(5660300002)(2616005)(6666004)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ZScojbck46zjUm+P61Jjw9Q1h5Vpb/BIMjZ+P9gOcZLBesihUy52jc7XBkE/4vq8esaI4U2wetOqAD4cJRCrBRbUM8jJHlryrNPEB7Py0z2VJ+uiPNkXFQw8MLEZgmlwh2lTVnSSDYfNs3l4XhaZTL4H0uokjYAdlnM8229w3MAD+ONFiqbzFZqbXTiuDWc4CncjYj+C6ArRKPgZ0Eh4k0Id/X22YGPIvVOLMKVUREYTqvd3fKEcizho/TXlAMWH8PDrglx8BFl/fowGdAP+PApoz8BcCJDQlwcFDUgcBiobG9eGLxAeBNJxuun61HfUI3eus0ln+8iXoCGRBIL1R1yltq3unUZc4cCPgKeUP60kZHd81aYOBPwKoBU/5VmjU7zFJzdHUXLjwatH4W+HH0PxKZUi71Cf9F9ZGDrOrgBmo3oXfHkShadhKt7+kaGHv84j1ZrutG5Ir0vOlVJURgUMj4bzxJcplAxyQDncZCY8Y6wbMsY/EoIg3kUKlZ6H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2df7b55-61bb-4a58-f442-08d82f22ec6b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 16:10:31.6987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YmrJD1U5P5IE8/HPB/7u0MLVebTfMadkdipKRWzwLTbFFM/IkeUev9znIWIfVBA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

vcn ip block is already selected based on ASIC type during set_ip_blocks.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 910a4a3..4edd5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -88,23 +88,20 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
-			u32 harvest;
-			int i;
-
-			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
-			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-					adev->vcn.harvest_config |= 1 << i;
-			}
+		u32 harvest;
+		int i;
+
+		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
+			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+				adev->vcn.harvest_config |= 1 << i;
+		}
 
-			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-						AMDGPU_VCN_HARVEST_VCN1))
-				/* both instances are harvested, disable the block */
-				return -ENOENT;
-		} else
-			adev->vcn.num_vcn_inst = 1;
+		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+					AMDGPU_VCN_HARVEST_VCN1))
+			/* both instances are harvested, disable the block */
+			return -ENOENT;
 
 		adev->vcn.num_enc_rings = 2;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
