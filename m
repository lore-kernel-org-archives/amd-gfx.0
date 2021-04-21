Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886E9C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6406144D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 13:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6406144D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 888576E99E;
	Wed, 21 Apr 2021 13:21:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B0A26E99E
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 13:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQhl5oxMGxPk0lxqqgdRkrPrATcROUChNWOw1SyLbcFhtBA1HemJ3jkMTcnrP/OOCYpC2bHXf8tkXOE0vmd7X1KShkbKjUQunPGNvpTQzn2GsWADRl790feUS6OFp9bMWXjlLwQePZtKYbNF4h++LI/cOdwCoktHe3SOIEQptW1NbqaaxKxh0nVw8YihJEs2CfFTXeSqrsGOSfOW6q8u6koM393ZZyhJQn/Ta6vvlYRMC7JtDg0+a5k2s32ZRwPyDwatWU6Ig4VubRNqymfZR0tHxKA6pd9bkrKlkuiyWmB/4g4Hu+TN6vznHCOiVNQ+biAbSB3bNSRLJRmeZaHzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biUu4/sIKcCiTppTXdff/WgGVHm6/zUfPI0Z6pMuv8Q=;
 b=imBmvqMhVlwxRAKntnSdFVKgoHy2zWpxkCyc2dZRCIgBe0c2HRty7xUuUhEdNSqS2inuS1tE2MNY608jzBkrOuWb820kC7xihE4FKwvFYaw5BvkRUU5TNu5QvNE6YhlAJ+J0kwkQFMXAeI/2Ml2FG50SxQ2ZxPWTojHYBFPEFB2iG16AJz1qR2JJYb/ZRKlT/Peljdg2AhlVkf7lkMr/ewAYMrA9GBPdFvDThnsq0cirgqhexX4cX30x/XYQFBWL0ZEUkjgJuAW4NMy2/5lw3dkY+YMu1vE4XgojszcILPxq+nB0M5iQoRDoA+vKcsYFCQoyJllpZx20tJxgiRaclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biUu4/sIKcCiTppTXdff/WgGVHm6/zUfPI0Z6pMuv8Q=;
 b=WGwGqv/Ki3dn5MnO+e0FodYDmwY7m9vSDBBTDApew9S/nBPk//+nOs/CJqfAgUINgGHAgZUGHObx+Q5RCN8qGnWM4mtKPOKxFnIf52aQ6qUkLdci/n29R9e44oEuUzJFdU+93tMwsRjOxVZJu1OKa9xicmLtMZheDtd/+oX8/O4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0197.namprd12.prod.outlook.com (2603:10b6:910:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 13:21:26 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 13:21:26 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: implement and use
 amdgpu_bo_create_with_shadow()
Date: Wed, 21 Apr 2021 15:20:28 +0200
Message-Id: <20210421132028.6154-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.123]
X-ClientProxiedBy: PR3P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.111.123) by
 PR3P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 13:21:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0ea62b6-f00b-4378-4ffe-08d904c85db2
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0197:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB019779DCB0AB3BE62E43975C8B479@CY4PR1201MB0197.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8Qw90dPihXN/TKmECwUhnkn2bnA0WgjDmSz0f6VlyJJtIHx+agpyC2eZjsuWHPjysSqS4sLc9Xw2agu/fT++l9AexiA0sPtAYp0yog+xer5G4f8siJO1fKBP6DOgWtn1aa50gH2Bi1tAjCsZJoz4WXAtHHT7uYMixzqSLn2xRZIWNYfc2OK7PCGP2y2bG6ujKAxgM/V/oxtzRpwXEZSK5/OGwm4rl+xQS+6UVIMseZXPHqIXCDfH1J8eaxaOM2SPb5kZBYoWWpPjKMcFUfAD2ecmzM2Wj5O+mQrE00AHGC4vWqscIoBC35wvTdWuXVvxRcNZQlpCEzvOLK6OUZBQr1V5kBT3H0j2UUkdajcskP3ICpMX3CJCNTW95NEd92jrpimVmAYapoF13DF2k4WGBFK2CBQ9SDaI5MznvTolvcoNDwpE4MOtcWf7gSZy+ZHGHY0IZ/AqWwKDpYlMSjfYSMJ0gsBW5wRLNmCEH+cTUJ9N7CmHPW+UJHFaD91M971T9M2yQX4a2mOvMwfuz6J4R428lCXEfmcd27+tzfD0ukmBI3qXNYP/z2w57MsxkGb63Tj/chYnycDLMuoa4Fwu5aNlSux0fbYf+jMYQxfBDSn7vtluGv9PZZKey8DXwQlITklfl6gVOFOVqSKV8r+xokUUG0gg/8rmqrdyW7ZJXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(39840400004)(346002)(1076003)(52116002)(6636002)(186003)(8936002)(6512007)(36756003)(5660300002)(4326008)(16526019)(8676002)(34206002)(6506007)(26005)(478600001)(6486002)(37006003)(66476007)(66556008)(66946007)(83380400001)(316002)(38350700002)(956004)(2616005)(38100700002)(86362001)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VXQdDbKImF+AvcgSu2WXv7RjZAy0ylGunSmvzngg/ORv+HxW0DBJoP2dT4zO?=
 =?us-ascii?Q?FRinOS9Cm5PJl6b6m052KdouYelz4aV52BRjLHXduNwQMeuyK091s75ym/j+?=
 =?us-ascii?Q?Zg/KTssWo9mYi7g9BEU4MeB4XCzLYzSi2XcgUcdhg3gbGvndlRlnbPyvO2hX?=
 =?us-ascii?Q?9xc851EBxBhrx36OSLriG+eynO4/JXFvZfitg+oPMx1qt3c4YkZbdr8ToJJO?=
 =?us-ascii?Q?WDHuM6Uvg2YgrJUwbVotddcu1tOJVfWuYMc2hjRe5xq9XW9KwbHzU3/mv6nn?=
 =?us-ascii?Q?fAedQeZkI2nzVQ9qtJFeAkuy5CFjMSlreFrmDqKmQ3xbEb9yY96L8CIZBTdp?=
 =?us-ascii?Q?aVPVX3DkfGAk2GSozhCJDWLRhoMTwDtSmzf6OAg85r9v3DD8GT0Zj4ozlSMv?=
 =?us-ascii?Q?NiN2IalC1d2thLpxvDygUMTaQDtvVJfTwKSnmNMjoguaccJW3m30Uk1CkNM1?=
 =?us-ascii?Q?tZc8foQlCPm+0iUnjdQwkrwvuTlSA7HEoZ1YPPAWsiqQwjgb6v3z9uiDFAD/?=
 =?us-ascii?Q?YxHQqBIHVNJHhoUGGvq6l/LAKMeDIcMpECjY2Rw0S95P7Oru64yuuiZ5EvwV?=
 =?us-ascii?Q?gkbIum8czWl13AkcjpEYtck6MtBYZ9vwh+HHO5GCAMr5WT2Fm1Wafatu9hLw?=
 =?us-ascii?Q?fEk15wud++Be9ncKmHFcj0nEKdQnRGTw1m29DkgHRcj0VWMiyd2HMMN49WMG?=
 =?us-ascii?Q?K2ga2uA7bCra36Kse78gmAuAczpGC5Bqo0qeOiGMl10Q0oyXDk/GuqXEp83N?=
 =?us-ascii?Q?2uy8GNcJ4AJESf2E6NvGr879khwLhinblEoDAkRSCyVusnZ8SvkLerDvG2Z3?=
 =?us-ascii?Q?Qz6/8TbwbnGQOTJ4olnUvVFALib/lGSmin4PHe7HOyO6DtoOCqArygHww87c?=
 =?us-ascii?Q?r6lGcJPBtPbWVRKeyBOIlSCVPEFWdhFNj6aNFvqWH85MKPdmuO0aW5jJd/+6?=
 =?us-ascii?Q?ywRuU+hK3Fyz10CWJ8QzjmG+jb/R6ooh/phpDGQEstjhbwtT06RbEvkiaF7/?=
 =?us-ascii?Q?KTNTVudaFX5yyiB12HFGPgcdBpKLCXluM1FkP8kND1c0mgLheg14qO+Ic1jF?=
 =?us-ascii?Q?yPKigzkFsjifxY/U+9WR3QfHyXtIdJZK8dohyRsItPXxVk3TJzAeimLil1DD?=
 =?us-ascii?Q?WX+2UlD3QiPYWEUAM0OWqElfWkUtwxPOAAoYG1CoTx2owR2/xC5roULdIHVA?=
 =?us-ascii?Q?Dwv2r7UWAdINFXNzccIUj8k5XthI88iwntz3mIJDU0kC4AGPNJytHT8aHZ7J?=
 =?us-ascii?Q?QnqXYf3YuRUTV/URIoAxcS1yi4+vJj95hQ0Y0HGYKrT79ienzF7qvpF/Vuim?=
 =?us-ascii?Q?9U6dfTvrr21ZzPAU3LQuZfYf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ea62b6-f00b-4378-4ffe-08d904c85db2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 13:21:26.3332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfs8YeXLgjELVCfi2JH1P6WdqMdOEuhPO082G6u6QQyPDvIkP/Yv8jfMB1G0OFsLNCRLrar3cpBw2RhcNcs01Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0197
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Shadow bo is only needed for some amdgpu_vm allcations.
amdgpu_bo_create_with_shadow() should make it clear that
a bo is for amdgpu_vm and will also remove unnecessary checks
from amdgpu_bo_create().

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 26 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |  5 ++++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..608f07377d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -661,10 +661,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
  * @bp: parameters to be used for the buffer object
  * @bo_ptr: pointer to the buffer object pointer
  *
- * Creates an &amdgpu_bo buffer object; and if requested, also creates a
- * shadow object.
- * Shadow object is used to backup the original buffer object, and is always
- * in GTT.
+ * Creates an &amdgpu_bo buffer object.
  *
  * Returns:
  * 0 for success or a negative error code on failure.
@@ -673,6 +670,27 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo_param *bp,
 		     struct amdgpu_bo **bo_ptr)
 {
+
+	return amdgpu_bo_do_create(adev, bp, bo_ptr);
+}
+
+/**
+ * amdgpu_bo_create_with_shadow - create an &amdgpu_bo buffer object
+ * @adev: amdgpu device object
+ * @bp: parameters to be used for the buffer object
+ * @bo_ptr: pointer to the buffer object pointer
+ *
+ * Creates an &amdgpu_bo buffer object with a shadow object.
+ * Shadow object is used to backup the original buffer object, and is always
+ * in GTT.
+ *
+ * Returns:
+ * 0 for success or a negative error code on failure.
+ */
+int amdgpu_bo_create_with_shadow(struct amdgpu_device *adev,
+				 struct amdgpu_bo_param *bp,
+				 struct amdgpu_bo **bo_ptr)
+{
 	u64 flags = bp->flags;
 	int r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 973c88bdf37b..6a9187ca0496 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -255,6 +255,11 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo_param *bp,
 		     struct amdgpu_bo **bo_ptr);
+
+int amdgpu_bo_create_with_shadow(struct amdgpu_device *adev,
+				 struct amdgpu_bo_param *bp,
+				 struct amdgpu_bo **bo_ptr);
+
 int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
 			      unsigned long size, int align,
 			      u32 domain, struct amdgpu_bo **bo_ptr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f95bcda8463f..2770d3b8dbde 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -920,8 +920,11 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_bo_param(adev, vm, cursor->level, immediate, &bp);
+	if (bp.flags & AMDGPU_GEM_CREATE_SHADOW)
+		r = amdgpu_bo_create_with_shadow(adev, &bp, &pt);
+	else
+		r = amdgpu_bo_create(adev, &bp, &pt);
 
-	r = amdgpu_bo_create(adev, &bp, &pt);
 	if (r)
 		return r;
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
