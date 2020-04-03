Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF8BC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE2C20757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z80a5KlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2C20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730336EB68;
	Fri,  3 Apr 2020 10:56:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 946AE6EB68
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPt27STOzxq+36blwmYIJ/YrQHAiwZH8yCpcoRhAoL0bYjEcJvyWzZgfhsSSnY6PRxmbOIPBDOdoIMXf5f7XPp42UTwmt9JuLaD1MoEeMI2/sNIBGMxqptC6Qf0oYaS1KWfdqwiL55w23owehqyYNB+jUVzPzkvo7xlFcMf07WRRf3Wq8teE0fTHg5R3iSbkRCx57tVBE3lYcuu4v+Hrqr9JAtuvsuogpHNYTab0p63tR4g+zdX8uBn7qo97r8lCg7KRGMV4hrukDl4I5nhYcBG+ehmYO1rqXQ+MiH3dTxG+nSfS6Lz0ivQCxpE7AqYWB2Pw57HhIsyO5rv7RNUHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfm0oCAO5qmJmgSqOuURU8lUbs3oa3KfZrrGh9cPkNY=;
 b=REIbmWbXHhmtEVrNrokFAXMesni88Oei0w0EKSap4S2uXgFLfgafgWjU6RjJi4DJGKvHQg4kavxfYiGlNGPwdc/IL5eqyTDZyFmDf+oyBF73G9ZZpULPDqNVo7O0iU1iaDT+od/XvYN+wL1n7Qh8nZhPQzPKv5TJL6GY9YEfnSe5tW3h4ExLSRAIrs4+dAtMvf06FHZIcmPaAEkqE8EAle1FzSDGmDnTRmI0p1Q5GtojQ8qyqJfasQ2jYbO9rphYnAOA4KlOf1j6ss8d1H3l0cEvRfk2QdGxZI1G/Bmk4zAv6DprGGdBr7ryvwMV85SEvNAwKN/G70cNSBABN+gjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfm0oCAO5qmJmgSqOuURU8lUbs3oa3KfZrrGh9cPkNY=;
 b=z80a5KlGsndg/X2HHbRuQPo8oVaOva+ZP8om0xASyJBAbTtMOmcLaJpZJ2as1Z8bWiT7sd3dXQidHqRg5MVcWSPqzp/YGPX1H45hfSxtJHSnhWhlIhHdzUshU+9JvM3bgAf5ECUcG9iLwCPGwrnLtx8uVRLX5JXXbbHjVRViV18=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:55:58 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:55:58 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: retire indirect mmio reg support from cgs
Date: Fri,  3 Apr 2020 18:55:27 +0800
Message-Id: <1585911330-27664-4-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:55:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fac60ed-e616-466a-2593-08d7d7bd96e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38332419FC4D2F0FFB18DB90FCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(36756003)(7696005)(66556008)(66946007)(5660300002)(81156014)(66476007)(52116002)(8676002)(81166006)(186003)(4326008)(2616005)(956004)(26005)(16526019)(86362001)(6666004)(478600001)(6916009)(6486002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRRn10vk4oLJ5ycr5L6Yl/7kYoiQbCdKOX7NEj/F0WrUr4+6kk06Y0uM5/pdXtt4SdebSQto63bSDbI+BfbvwZYYGRIytWAS5ktSK5NH78z7ydZjj0gwjOX1HY4FPhyP698bWhaQCx24+3L425Mbn5GQ3Zdb6SskVRgBdYTEl/wMml1JjuruaYTciP+7J5v4ZAR4UUrnlFYaGL0QyApwzehwlLBfZOj3KxarjhaSpWVoi4WdrT+Yb5If6dcjqWynWAkRQ6zqc4i+QOZqq80qEePh0i0Rd4wv6oHLIwqwGC2qgAq223cF7rMCwIsj0KgmeS6MkpDGHrwU2k96dSPmRW/mPA335FRIwWxrZ/8gYkig36PKGDDIFTUBTQG8RKNczHG9IezruMjHaThW7vj9YJp7fx+86m9C7PcGdFGP0uaNLyCGQbymnKUG4jmbuciv
X-MS-Exchange-AntiSpam-MessageData: /Gq1AMOlwydk9RugQgECbND1iFtTR7n02BHPhC+FGNSfarBc/PCvrXk7SRjT2m3YcDfYFcx9dKpAoDb1X9VOgaptHhRcxNDHSYX7p5xmhRsoRG8zI+8LbCzs8yVXETjBVI+bg3yNOlv1UYGmJMtXmg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fac60ed-e616-466a-2593-08d7d7bd96e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:55:57.8698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AdE7A+TlyGsEwjtVzSI6wIrwx/XQopxgnjl9Snd8c7bvyC8CtXJ6i5S2455LAgHFeng+GygQDUMWIN1/4m77A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

not needed anymore

Change-Id: I26b4b742acda4387ca25b86db83b8c9376ed4f3b
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c  | 8 ++++----
 drivers/gpu/drm/amd/include/cgs_common.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 031b094..78ac6db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -60,8 +60,6 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 {
 	CGS_FUNC_ADEV;
 	switch (space) {
-	case CGS_IND_REG__MMIO:
-		return RREG32_IDX(index);
 	case CGS_IND_REG__PCIE:
 		return RREG32_PCIE(index);
 	case CGS_IND_REG__SMC:
@@ -77,6 +75,8 @@ static uint32_t amdgpu_cgs_read_ind_register(struct cgs_device *cgs_device,
 	case CGS_IND_REG__AUDIO_ENDPT:
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return 0;
+	default:
+		BUG();
 	}
 	WARN(1, "Invalid indirect register space");
 	return 0;
@@ -88,8 +88,6 @@ static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 {
 	CGS_FUNC_ADEV;
 	switch (space) {
-	case CGS_IND_REG__MMIO:
-		return WREG32_IDX(index, value);
 	case CGS_IND_REG__PCIE:
 		return WREG32_PCIE(index, value);
 	case CGS_IND_REG__SMC:
@@ -105,6 +103,8 @@ static void amdgpu_cgs_write_ind_register(struct cgs_device *cgs_device,
 	case CGS_IND_REG__AUDIO_ENDPT:
 		DRM_ERROR("audio endpt register access not implemented.\n");
 		return;
+	default:
+		BUG();
 	}
 	WARN(1, "Invalid indirect register space");
 }
diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
index a69deb3..60a6536 100644
--- a/drivers/gpu/drm/amd/include/cgs_common.h
+++ b/drivers/gpu/drm/amd/include/cgs_common.h
@@ -32,7 +32,6 @@ struct cgs_device;
  * enum cgs_ind_reg - Indirect register spaces
  */
 enum cgs_ind_reg {
-	CGS_IND_REG__MMIO,
 	CGS_IND_REG__PCIE,
 	CGS_IND_REG__SMC,
 	CGS_IND_REG__UVD_CTX,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
