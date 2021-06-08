Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CAEC4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D58361375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D58361375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9E76EC52;
	Tue,  8 Jun 2021 21:40:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB3D6E595
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBLj/e+ww9yVg4AtU3QJCbIfcKhhp07PlH/hn8067PTfsBX1EUR7OTjQ5cQ3+FQ3JyWkUnYPj4XQK7PxoDDb3B/WJTGEQoFygD/2EvlC+F6dNriGIMw7cE2abHD3szYJ/O7I+HBvaNiO4hpWVM4gK4LYTyGo3E2LqY1Wrz19W7x+UCkM6fyEjl57LuqpGKd4CQo2YmlMe12ZPd4ti8dHWPqYE+KQtVhqhqLsCLW5awlOfs9e6RTXrSQOvlwWyW8EaQqf9DEVL+uw21k4FANYDqjI3LfM+O9Vagkbws3lUgLy65ZcL4lAOQaNeSOWKjQqrHSEsxk/NV/tjwwyBy+4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4e5EcMGNeZVfd8QtJ5eKWk0Hn8uf9XyzHzMk5s7rzA=;
 b=PjEBby8nGyQYdUd67lS+CUiC8iq/ImAb/UZ8uXoBid3CjkrbwphSYtUkKNzM0BJ1Hg0eq4TqZ7bmPRK+0wuqvolQwh5/vmFBgxingxwPNjtX9a7lKEueck3vUPLOgqVAboqQ7od3B4vHQnZ3YEitbbhdmZIhsgx1Dt0f1qM5FubuyMHaS/LgDyO4zP3/RbBgcMBSnaq7NuvSW1yKpxfnfI6xEw0g+fL77QOctjhLhG8+jW0ZQuFlmfmjVMboNihREzuGsHcUREsPA4Bfu4ErrptaVScDfazmE6xbUQkhFaZlithI8AzSEV6o8SLKScMHI9WUksMusBb0gKnma9HiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4e5EcMGNeZVfd8QtJ5eKWk0Hn8uf9XyzHzMk5s7rzA=;
 b=Ex2bVXr2rdg/8qe45Ew2ticVzI5L4NeczcU7ewtmwndyW5a49I+QtvElLQTRofqbgvjzZXejoLeEfjnPrqt9occera7lnR8IyzyoxKMK5se6ZvNeSJhEe3RauRIdbRDSy15baJc/hb4zU6PBua/Hq0DRnLD1n1UkSLp7IWXnSnQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:35 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amdgpu: Rename misspelled function
Date: Tue,  8 Jun 2021 17:39:40 -0400
Message-Id: <20210608213954.5517-27-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92bc250-5b57-40a7-842a-08d92ac60c98
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435B957A26166DD34D0783699379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vt9+ajj3PZpdVUkyHUW1s9qG+x0e8d/Sg/gd0ebgQo4pd+fq8jJzJXAZPHGS7PMaCiv6Of8OJPKLtOUqNkJ9tMM/Xc0M578VOVblm/qeKMZ7joGH+UgClpC4tzA2DRo2nRDOpp3d37gqBlttoOdnmxAgO+lEw0hJwTbc9JSEJcWVe6iU7v7r/5YGzp6tfXeIj+nGMvnBxdn5Wl1HBBgExzTfNaa+JqGRXH69DV+hwzuHvNPcXrnphuidSG5i1EMzQmijiVZY5fYipGNT3W4dQOHk5Dt1rXAmCppBB7YYS6GJRKXhCnlGq2PLIStqUefOBx9fflMRMsQGYtMIzQxdIqxkvY9mVbEYHB5iDT8NjWnl9ymKBMJqavlJI7F16pn6A4ohuRHQl169Sz7UVsZkCnDMdE+wPwpQHeKvrcTQ0ONT+7vrflDOdqXKHca8ZMwwdBMuTIEDtBGaOsOotMU+r/xjzSmE2vPhh5ovtGDtTuTb1le9PnjDys4RJy8t2N1d7+idyA9gTO+J/VJc6MnijRN2f6XA/jXrL/L0/CSUPVhaOgsBrBDi9QgibJpWJVNGvcIZ5UHupreED3zoX1It+s5Cul3ibo2U8pMYXDYX91KrK5kCg/HxE503yOWcY8D7hvn4jPmFGvBZ/ol12kHcfs94hGpAJMglg+u6ujk7SGtgqlB05o7sD5/xReToqwmG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(6666004)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXF9FxgOsJQU6ffxSY5GOt0lxaoo183elUT9dXu/vB5FH2PYxDy1aQFj7C8y?=
 =?us-ascii?Q?9UipuA2sVi4K3hft+yLQA18TCVDiyxs3T+Jl56Js+nuId2DcpbqDJUYpzrrh?=
 =?us-ascii?Q?PC0JBJwIc6GIKdNLmynhpy1xVumPaA8ZDs5b7ruaTIlQW71jTBdV4s+Kd/nz?=
 =?us-ascii?Q?Ou7kitTf0QVBSwaRDnjIlv11WdV0NcbLSBb525oDsEY3c9ZbOfqLVVNXdnox?=
 =?us-ascii?Q?6t0EnQKcr+6IyCH0vHbrjp+VcDaMRZFS4Y9gVfqPEZh7aXSCu83gxvHaugXO?=
 =?us-ascii?Q?A/LDIC5k64Nhk1rPA4KQmotGWevzKFry9joNotP1PsPgvIvtdnSVmU1uPxsb?=
 =?us-ascii?Q?0HcFHPdiJG9fOw9LxLECo0LMDyA4e54VzxAaRhQn5u0umQXURj3DmH7rx2d2?=
 =?us-ascii?Q?iX/nHFSs5SbGUqFk3lg8NYk4lbFrSX3Az5atV/WeQXVtEHb9ITb23ERYUhih?=
 =?us-ascii?Q?o9oQDIT3RVss/sG613MyNu1dMaTpXQ3Cu9LtE1XVcE2QkWMPFGjWFxouACmE?=
 =?us-ascii?Q?LtX6CgXtI2CADI8tde+0qwlRQ/TeYNtposbfkzRMA72gqJm4yy8WKFbVd8db?=
 =?us-ascii?Q?rWv/xSHnkukhEomhN2WC+tO6XRDLUCyW4gswrtK68bexHhtjPim33wLf56S5?=
 =?us-ascii?Q?2DuxZcXJzcZarSskrSHc+9+9FSJ0wWnILws9Iaj79b4bZzljI6Fqu+qaUurQ?=
 =?us-ascii?Q?iMq+XVbX9nEUHVSbvo70p0FE7BwNIDsdqMJAjsajPqVzMg/UY00yhbgH/2XF?=
 =?us-ascii?Q?zFDff/iIJpi0IPrGeyi4np+hWYcOMCFONmwK+SDKdphYnI281a28xl7T5WxL?=
 =?us-ascii?Q?jrpV3CquygOoVCORgpYX/SHo3ylW5i7N6PhEiogFsQ3BZl/fYhCnhd4kBlnv?=
 =?us-ascii?Q?q4HwgbMo+w2Hd0wPzvX/U2vCEAr6Jf3o5y+J1X9Er1g+5L5cQdPbWP8N9pSW?=
 =?us-ascii?Q?pdFYIHkq+8q+I2Z1sC92JFZr4Fr+8PP54w5mOTBx87Ul/ADZwGRLt7lynXBW?=
 =?us-ascii?Q?kS6b/gu27081sYJrfBSBRplW7ctkW8x98oVyjZ/rM061KRkahlEzTiGKJJJ/?=
 =?us-ascii?Q?FAoGEL4qE1ySxwvDB2X84WM6cz6JD+TKzas+sgW2NWnbBrL+iDKGcQdJUtgR?=
 =?us-ascii?Q?pGIldsedkyOKy00IrxNKBTRXPhUVasOpM9BbCLbJyqNWf4hGjp14UFbIhOE/?=
 =?us-ascii?Q?jtPySIugEA28dUSBIQZjv9UHy6s/xhJxOAITBNcaC7nRxAhcFUSXIj2gF+ET?=
 =?us-ascii?Q?bZGpG/lN4HvZGYfd/f9Q1GqDU7gTrLU5IixPrgYYBmTK0IY1L8PZL8Acip4G?=
 =?us-ascii?Q?Q+j20Kv4++VLyY9HXteyJCQc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92bc250-5b57-40a7-842a-08d92ac60c98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:35.4068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyPvznqHDdMsWeFgrN0nzizRRGeEZe7slyEX+VNt5wfBuhTMTi1Lgiw7Y9kZdN5R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of fixing the spelling in
  amdgpu_ras_eeprom_process_recods(),
rename it to,
  amdgpu_ras_eeprom_xfer(),
to look similar to other I2C and protocol
transfer (read/write) functions.

Also to keep the column span to within reason by
using a shorter name.

Change the "num" function parameter from "int" to
"const u32" since it is the number of items
(records) to xfer, i.e. their count, which cannot
be a negative number.

Also swap the order of parameters, keeping the
pointer to records and their number next to each
other, while the direction now becomes the last
parameter.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c        | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  7 +++----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ec936cde272602..beaa1fee7f71f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1817,10 +1817,10 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev)
 	save_count = data->count - control->num_recs;
 	/* only new entries are saved */
 	if (save_count > 0) {
-		if (amdgpu_ras_eeprom_process_recods(control,
-							&data->bps[control->num_recs],
-							true,
-							save_count)) {
+		if (amdgpu_ras_eeprom_xfer(control,
+					   &data->bps[control->num_recs],
+					   save_count,
+					   true)) {
 			dev_err(adev->dev, "Failed to save EEPROM table data!");
 			return -EIO;
 		}
@@ -1850,8 +1850,7 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	if (!bps)
 		return -ENOMEM;
 
-	if (amdgpu_ras_eeprom_process_recods(control, bps, false,
-		control->num_recs)) {
+	if (amdgpu_ras_eeprom_xfer(control, bps, control->num_recs, false)) {
 		dev_err(adev->dev, "Failed to load EEPROM table records!");
 		ret = -EIO;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index d3678706bb736d..9e3fbc44b4bc4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -432,9 +432,9 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev)
 	return false;
 }
 
-int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-				     struct eeprom_table_record *records,
-				     bool write, int num)
+int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records,
+			   const u32 num, bool write)
 {
 	int i, ret = 0;
 	unsigned char *buffs, *buff;
@@ -574,13 +574,13 @@ void amdgpu_ras_eeprom_test(struct amdgpu_ras_eeprom_control *control)
 		recs[i].retired_page = i;
 	}
 
-	if (!amdgpu_ras_eeprom_process_recods(control, recs, true, 1)) {
+	if (!amdgpu_ras_eeprom_xfer(control, recs, 1, true)) {
 
 		memset(recs, 0, sizeof(*recs) * 1);
 
 		control->next_addr = RAS_RECORD_START;
 
-		if (!amdgpu_ras_eeprom_process_recods(control, recs, false, 1)) {
+		if (!amdgpu_ras_eeprom_xfer(control, recs, 1, false)) {
 			for (i = 0; i < 1; i++)
 				DRM_INFO("rec.address :0x%llx, rec.retired_page :%llu",
 					 recs[i].address, recs[i].retired_page);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
index 4c4c3d840a35c5..6a1bd527bce57a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -82,10 +82,9 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
 
 bool amdgpu_ras_eeprom_check_err_threshold(struct amdgpu_device *adev);
 
-int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
-					    struct eeprom_table_record *records,
-					    bool write,
-					    int num);
+int amdgpu_ras_eeprom_xfer(struct amdgpu_ras_eeprom_control *control,
+			   struct eeprom_table_record *records,
+			   const u32 num, bool write);
 
 inline uint32_t amdgpu_ras_eeprom_get_record_max_length(void);
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
