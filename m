Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D4C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7BE613BE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 21:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7BE613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1227B6EB92;
	Tue,  4 May 2021 21:48:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295AB6EB95
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 21:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxbcssaTeueUtXsxlkzPvpMi0raDhp/vSVjSW8+v1m8goQ/uGs1ZlW3kVs4m76T1ysbv89IBOlHlXiMQDGCF2cela9NVoCTJlZaL0A+LsNOoPSAi17zTG3cQPQJ+CM0XR/tJoC0dZ1veS8Wmni7X6DZ2oOfsREc6FumXyo1toPi14LBISPvftXMLt96kpsSjuRg+pFkxY3vbvAEglnUMsO8YU8mTH2+rDBNtbk+Edy8ybG/wW3OIneGBMjQv7uFk5/t8koSO201K00YaGZCdum/g81T3xShltx950KMTIJ4rpJGF3DG6A/HuTx5oswBOc7F17YsgvpISGFar2Kme0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkUQXx6NFymqhFPYsJqqyzqIv++GakQwhgeQjF3XUck=;
 b=Rhm9j4ROwDlEq9l5q1UQQLJb7AhlqhvbmZG4ZvO9Q5CaU2rvyjhke145ksYsLgoPzi1kMysEeV7I1CE5pxYiEg7MRKD9Pq0qzIzoObdr0HyaBc3NU2uXFtPG5XjjzZbH2eR/QaKQJfB8LsEyIGSq+Rw2b/u+puZYsltXFd0JFBavKoCB5kcLaSKrXR/sEnnVFwH77BX9DeA4H8Ag1rIK8ZEi1AEP2DSURAgRsSA25vseWHnROxJhROLMiw6om+q9xiI7ttmzXhvLSkoQt1F67pbd+iGUGxcMJK4yc7QHF3dCaBluyIGpQEvcL86pSffZG9ikTuht0+G8iintOctc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkUQXx6NFymqhFPYsJqqyzqIv++GakQwhgeQjF3XUck=;
 b=L4NtNTpcIKPuYOn4jrwAP5cwL7USZN9p7Xdywt9UoEfsYaCxM2Fq2Y4lGJC8lsldVeK/3rZREGWZ84xhUNtipMqthq4jm4ycmtHveRbcHZr/4PYYkZau8XnblOETB3cYV8VKa4KJ3botoNOTwabEsZ3GzHxYX89WUPOO9uMj1do=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1867.namprd12.prod.outlook.com (2603:10b6:3:10d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 4 May
 2021 21:48:21 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4108.024; Tue, 4 May 2021
 21:48:21 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Move up ras_hw_supported
Date: Tue,  4 May 2021 17:47:54 -0400
Message-Id: <20210504214756.3816-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210504214756.3816-1-luben.tuikov@amd.com>
References: <20210504214756.3816-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.38 via Frontend Transport; Tue, 4 May 2021 21:48:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de53f844-3e6f-404e-ef3a-08d90f4655fd
X-MS-TrafficTypeDiagnostic: DM5PR12MB1867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1867F37C1B483AFCA2140C67995A9@DM5PR12MB1867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X06+30l7xLj/UZ7bXD3TcJfgB0VQeU7f6w8aGFWLZ8dZatpYUL3hKEAAQEXAmlFX6vRNQbTEFHx4zWEz4/iGcJPxZZHlux7F5PcrzaZMR/4YAV6F35R45xsP914qQb0wJ0AfFD8rbEbyBLPtLPM3B25r8z9q15BagDr1Ums1dar4KJmW7cGNxLacM53hq8r32mmWYlcfzTUBI2aDRPLpIwqDmjI8LJQvjclwdE7nH0pimeFjoYbwdW4Eh5iI14Mar0o0O5Y2mvdby9ATKfQpMhGCxrYQNqXVQ3YphpHFb018hrDwrXZbZgHI5z5XRq6BNRMIAAQ/sDCBEZkL+CbDpm5pb3hveuFbSNWKOQxqlmopm+FlYSfSi7Ywnb+eu8KFoNMlSnAW6/0O5XIQRzsKIS7LzDL565P69hZeQ/27pZrUMVP44koHfwLxhSOPSfZHocRSynI7LYKiG1jsHLUvx5lWQrwMFL8mrgiygGPt8jOCRSP4B96Ri9/3qvfMM0ZB05MO8IgTmtezUUec4vqPO2VCR6fCJuP0raAVNao0GoE8XNGs6f6flZXdkmL6kCETbSyO+JvPCByUvr+fG517YKrZBCcuXb7/8gPCHfCLGMqY0y7hlLlhBZjWSGIJ7kaHEZw/5jNilIDpCE+eXHW/iX1kKVdbHl+BB1+K8BrbIXqjpYxWmE+0kHt2KGL51ygb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(26005)(5660300002)(86362001)(54906003)(316002)(2906002)(16526019)(478600001)(6666004)(38100700002)(44832011)(36756003)(6916009)(1076003)(8676002)(2616005)(4326008)(6512007)(186003)(66476007)(66556008)(83380400001)(66946007)(52116002)(956004)(6506007)(55236004)(8936002)(6486002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KCA+hlW6yCDAydrqZrE36WN26RowlNFrgBVVjZSbcmTq8fgzIvIw9i26mT/5?=
 =?us-ascii?Q?ip4lLFW17COO6xAdmJEWQNlydtpI9pxBlfhjKrW4OxMjZFvjDiHurseE7XA8?=
 =?us-ascii?Q?IOZr9CMLnH6wN/Tqjj+iUZdd0EtjyUbQISNP6ALCXkAJjv1TmSvDnOkFUsaT?=
 =?us-ascii?Q?aQNwEcDwZPyz8wYaZjJBJwu/yx9mZjS3CEsjmtzDWD0qpP3MV/TNqFharUHY?=
 =?us-ascii?Q?K8RgfgO4PgwAurNaZpfQpKAddvK6rR0SFmddhi1YSJqyfZ72iZmBHg0LH9hQ?=
 =?us-ascii?Q?/oUA0FUq7XBN93aDdyWG/2r5P2u//t2IeDdqM77xE9G7UGW8ORac3njd9c+o?=
 =?us-ascii?Q?pQ3Ee+1T07huT//CCXlmohcE6tLEm0VvwJegyQL5ZH413mKLJRvLa8mLyow/?=
 =?us-ascii?Q?pgwbYh1pq9uRUCywTs3LbI8axLgWC+rTKuB9xK2DfnkiQG4DF9GdmALcBt4o?=
 =?us-ascii?Q?Zhi4JSkD4jStKeUYsE1fNT29190Nk4qvKTzR0mY8iKlJcRYeq7THi8I9RDwI?=
 =?us-ascii?Q?3/E04IIFJQiyz37V6RgAeWe0bW+CiDJSyylJ9U6MtLcJCwkB6F/Liia79i6w?=
 =?us-ascii?Q?JS2+wh5VF9/0aNYHtwBTavhjr+CGqtNXvaKAdTWskamJ/3/+EjdmZ/MioTIq?=
 =?us-ascii?Q?NEtaoq5g+e/CrxVSoSOLBxGIZwZawMGbE1DZH+koUJWoReLZ3CvKkuQSVj78?=
 =?us-ascii?Q?NiYuqvC6SN+kRPK8fXu00YFyfPgV6P8naLxCjiyABalRaDlF44qdi//AHSq3?=
 =?us-ascii?Q?jj+eBm4rq1bhbwGfqBkCsdCBXEs9R/G+CdZF1huFg07RgUPmq03WSwdskCb7?=
 =?us-ascii?Q?qr6+u1R9dtZhmlP3QmJcuNb5x5v743Z4fdDpZcdrHL/dDKlIx6ycHnekUUoL?=
 =?us-ascii?Q?tvCE+RFoQ2PPkztfrKGEQmFfGMRSizthik01irHZnoQvrao0R+B9xJ1G0hLz?=
 =?us-ascii?Q?gdRvBm78hSjexDlB8uAU/n5jn6m+t1qwT+QR+N4CwNtzxzV/QuwklaSNg7bm?=
 =?us-ascii?Q?UcK1YRPMCWHzAT8igXT25oYBZyWYBUY5wmAIAPbFBJqSuUdcB9Msdi8tDZpM?=
 =?us-ascii?Q?WWRbdWG1izKrA/abQt3GaOrONHRqugBHbXtyvcMqTUbgzKNS2EbX3LM7ks1U?=
 =?us-ascii?Q?CoTS3CGiujXEDr1EjxqhCTTUvwcOURGkbpcNzfEGaBayleS12kC6N6LWNQ5i?=
 =?us-ascii?Q?9DlOjZVbmwZUoMRkOGbdEKQ+/JcKzN6fFzwoHCa/T3kufl7n5Ej7FIerSq5B?=
 =?us-ascii?Q?UXHGXhJxj+HwkaSDrvZGk617G9vZCYnBcU6syNhtPRF8iZ9WEm+K9W87b1hu?=
 =?us-ascii?Q?nJOt5b/W4VqvteJfsL8NyYJJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de53f844-3e6f-404e-ef3a-08d90f4655fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 21:48:21.5907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toQJt/IJvh36VDWZ50CcU11sdx3ACvdBbkTOfUJQ6LJNNnoMoG8U2Lb88kk6t3sL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1867
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
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move ras_hw_supported into struct amdgpu_dev.
The dependency is:
struct amdgpu_ras <== struct amdgpu_dev <== ASIC,
read as "struct amdgpu_ras depends on struct
amdgpu_dev, which depends on the hardware."

This can be loosely understood as, "if RAS is
supported, which is property of the ASIC (struct
amdgpu_dev), then we can access struct
amdgpu_ras."

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  1 -
 3 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 125b25a5ce5b..3aaf2a12949f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1076,7 +1076,8 @@ struct amdgpu_device {
 
 	atomic_t			throttling_logging_enabled;
 	struct ratelimit_state		throttling_logging_rs;
-	uint32_t			ras_features;
+	uint32_t                        ras_hw_supported;
+	uint32_t                        ras_features;
 
 	bool                            in_pci_err_recovery;
 	struct pci_saved_state          *pci_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a484ac6a8399..7a4916e30945 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -611,11 +611,9 @@ static void amdgpu_ras_parse_status_code(struct amdgpu_device *adev,
 
 /* feature ctl begin */
 static int amdgpu_ras_is_feature_allowed(struct amdgpu_device *adev,
-		struct ras_common_if *head)
+					 struct ras_common_if *head)
 {
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-	return con->hw_supported & BIT(head->block);
+	return adev->ras_hw_supported & BIT(head->block);
 }
 
 static int amdgpu_ras_is_feature_enabled(struct amdgpu_device *adev,
@@ -2069,8 +2067,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
  * force enable gfx ras, ignore vbios gfx ras flag
  * due to GC EDC can not write
  */
-static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
-		uint32_t *hw_supported)
+static void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
 {
 	struct atom_context *ctx = adev->mode_info.atom_context;
 
@@ -2078,8 +2075,8 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
 		return;
 
 	if (strnstr(ctx->vbios_version, "D16406",
-				sizeof(ctx->vbios_version)))
-			*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX);
+		    sizeof(ctx->vbios_version)))
+		adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX);
 }
 
 /*
@@ -2091,11 +2088,9 @@ static void amdgpu_ras_get_quirks(struct amdgpu_device *adev,
  * we have to initialize ras as normal. but need check if operation is
  * allowed or not in each function.
  */
-static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
-		uint32_t *hw_supported, uint32_t *supported)
+static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
-	*hw_supported = 0;
-	*supported = 0;
+	adev->ras_hw_supported = adev->ras_features = 0;
 
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
@@ -2104,34 +2099,34 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
 			dev_info(adev->dev, "MEM ECC is active.\n");
-			*hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
-					1 << AMDGPU_RAS_BLOCK__DF);
+			adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__UMC |
+						   1 << AMDGPU_RAS_BLOCK__DF);
 		} else {
 			dev_info(adev->dev, "MEM ECC is not presented.\n");
 		}
 
 		if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
 			dev_info(adev->dev, "SRAM ECC is active.\n");
-			*hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
-					1 << AMDGPU_RAS_BLOCK__DF);
+			adev->ras_hw_supported |= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+						    1 << AMDGPU_RAS_BLOCK__DF);
 		} else {
 			dev_info(adev->dev, "SRAM ECC is not presented.\n");
 		}
 	} else {
 		/* driver only manages a few IP blocks RAS feature
 		 * when GPU is connected cpu through XGMI */
-		*hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
-				1 << AMDGPU_RAS_BLOCK__SDMA |
-				1 << AMDGPU_RAS_BLOCK__MMHUB);
+		adev->ras_hw_supported |= (1 << AMDGPU_RAS_BLOCK__GFX |
+					   1 << AMDGPU_RAS_BLOCK__SDMA |
+					   1 << AMDGPU_RAS_BLOCK__MMHUB);
 	}
 
-	amdgpu_ras_get_quirks(adev, hw_supported);
+	amdgpu_ras_get_quirks(adev);
 
 	/* hw_supported needs to be aligned with RAS block mask. */
-	*hw_supported &= AMDGPU_RAS_BLOCK_MASK;
+	adev->ras_hw_supported &= AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ? 0 :
-		*hw_supported & amdgpu_ras_mask;
+	adev->ras_features = amdgpu_ras_enable == 0 ? 0 :
+		adev->ras_hw_supported && amdgpu_ras_mask;
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
@@ -2152,9 +2147,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	amdgpu_ras_set_context(adev, con);
 
-	amdgpu_ras_check_supported(adev, &con->hw_supported,
-				   &adev->ras_features);
-	if (!con->hw_supported || (adev->asic_type == CHIP_VEGA10)) {
+	amdgpu_ras_check_supported(adev);
+
+	if (!adev->ras_hw_supported || adev->asic_type == CHIP_VEGA10) {
 		/* set gfx block ras context feature for VEGA20 Gaming
 		 * send ras disable cmd to ras ta during ras late init.
 		 */
@@ -2208,8 +2203,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	}
 
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
-			"hardware ability[%x] ras_mask[%x]\n",
-			con->hw_supported, adev->ras_features);
+		 "hardware ability[%x] ras_mask[%x]\n",
+		 adev->ras_hw_supported, adev->ras_features);
+
 	return 0;
 release_con:
 	amdgpu_ras_set_context(adev, NULL);
@@ -2415,10 +2411,8 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)
 {
-	uint32_t hw_supported, supported;
-
-	amdgpu_ras_check_supported(adev, &hw_supported, &supported);
-	if (!hw_supported)
+	amdgpu_ras_check_supported(adev);
+	if (!adev->ras_hw_supported)
 		return;
 
 	if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) == 0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3e830dc1a33d..f60d1cfafa3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -313,7 +313,6 @@ struct ras_common_if {
 struct amdgpu_ras {
 	/* ras infrastructure */
 	/* for ras itself. */
-	uint32_t hw_supported;
 	uint32_t features;
 	struct list_head head;
 	/* sysfs */
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
