Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83423C4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53D12463B
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 08:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AAOYPm5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53D12463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B9036E49C;
	Wed, 28 Oct 2020 08:30:57 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700044.outbound.protection.outlook.com [40.107.70.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35806E49C
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+hTYGZ6dRTp2PyJClOn80UjLYwJIbDopRUgIIRJ2o87iiJfvUaMOtmWpLvTyH6bJU6uD7l804Y7GGZBrlHBqKaEJMTsUX5pa42MHUfS5BG0rdoG+nGBgrMwvGEjLLpnOGIg6hBPI4dqAfjmLmRcClO5zemolmvJFhQGi/gn2J5d2iHqT4JJIDcNqa/o5e1SLBpGZR3jcoHcpEzDLKaQVZdmwFGS8j+W3ll+GX9Jfi+Nze+oIY187T+2XBfbzQ6UrJWbL3XW7TZZZuKiqCNFc8EzcGiElf0+Mvq2fVMcFOXvFoXuYY7EsQGtBdlyhyVE/SoNvkU5VGFLPTx4GddyCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiTlTwkOSoTgMRYflTRy4SVV+W2FZv9Dwl9J8NL0VOk=;
 b=YHiA89BaCT11BQ3CJqyQnqo3/YPonP0DS0O0WtyZrl6bzn2oMpJrecl4ujd+2wOK8xNrYZK7unDSezFaKngJXdCCsSIAvy/XdAPdnWr+crxRZ5GmMheRsC83yIJCHWQaPPg8pU6MztbpbjWhQ2/EitL4DCq02vMTuK1ESD1Dcrdd1ltjhqIDR5njrWeEKnp7L6EZvcXXtfmZBKTKyMicTDqfuCdWKC50+5+70HDo2IYLSlns6oFdrkLuxu265uxTuEve5NQlByON1CewoIfb3HenbSzc/qrnhWgOEwTCOz2GSiV/qBzbPY0e8pOZ5UUclt4tf4LBckTHbjn2veUyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiTlTwkOSoTgMRYflTRy4SVV+W2FZv9Dwl9J8NL0VOk=;
 b=AAOYPm5hIBb+cQ8WwFrP0zo7UDPeG6WMijz0lyT+E81Akj1eTR4MWQL4GvkNR/aNxxYsRKn/d5JxmpAKg88ak2l19eDXW0wuTNDRBCBl0cg8gE7Ylzsz0CWkJZyethHIpp0jMWfpxnKhGeNnQCNH//AVVRI4ORYrly/ba90wuno=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Wed, 28 Oct 2020 08:30:52 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 08:30:52 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: perform srbm soft reset always on SDMA resume
Date: Wed, 28 Oct 2020 16:30:27 +0800
Message-Id: <20201028083031.1195496-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.4 via Frontend Transport; Wed, 28 Oct 2020 08:30:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f41f95d-070d-42c9-28f4-08d87b1bc7c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46993A223E598DDC3D0ED468E4170@DM6PR12MB4699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttCXMCDPJ/mCtEJl8I0xgQ0Q60eokmtKJZWWqfNwZ/B60q3Iz9d0cpb3AVt9Qzo05uxjq0pSy3cDCiiVKwKvS6ZT0y7FZVB2Aw4YS4mBx3cjYqQ+mFaX93dKMoAYP5XXWWjh4LUwAeWmyS/GKFF7x5ObSOXS2DFM1kd2o/Ok+CsHtUeg4G0/wcE7LftNyZwSG0LrR9qfthJ0gv2fIKSVDw92aMjEsmNrwok9QI0FZ2f5Hqzj4PnQdFGD/aSCX0bC6Cx3IyBT0Vj+a56haXTbUHSkDXUT+d0I/xhl6AmmHLJIqvUeAxnOI2ZzlvIU3l2hXpMXYn3BiotvlgGuLblqVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(1076003)(86362001)(52116002)(7696005)(26005)(66946007)(316002)(36756003)(8936002)(6666004)(8676002)(6486002)(5660300002)(66556008)(6916009)(83380400001)(186003)(2906002)(478600001)(956004)(44832011)(66476007)(4326008)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5/4ZKQbca+3fORVg1RIpY/G03tithZJCCj7qDzfso5PxpTDf4kOD98HkxBZJPcmy2lheihUWTyL7K67uIdVWSHnf/5I0CtyGXCDARuL7ag6/N2vc96bHGpv9wuenCNWvBUlunJf9zH3Ge+/SbhyQR/We/qV2c98fc55VsFVdo/fu+23CbpLDFzZ5kLu5p4hhoctVNv8+DMBdU1/pYFgL7SJKkuzI4rFehGfbFci3tMYypxZKEJctk7Cb6ihoedee9PBAwN5eOJmsMMfMjDDozhFyzU2MVhIAgVr4nZTKuH122PwsHnlKESC8sh/cqvggW5tOQiC6XgdS8cI5DBW7nOlxA2GS8WfYltI67J+ZbMJmaq/ZYHqIbmhcT4RJklI/Pvd9PFAXT6OgvHHTFkG2XHGunaV0BWnvcRMmcATf2xtVF+bOO5s63sfudt5yhj2U1gtqiOBuVuQlvGmAoMpmJxNjyFmqJ/7N9RPn59hbTugWVD1tAci5/zlQCg8kUpRoF0R5U2nF+F/36M6tisnHPu9iD4uRrf4X7EOq69zPROzkxVtBWFWqAP+DlhkfM1Lsk7lF7QLLiV61U5jNWlkvgmDjQik0CNLVT7vIUQzibqYGPliUIPygMl4URuWqp4L+w6QSlXYRd5N4DO/HGoYtvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f41f95d-070d-42c9-28f4-08d87b1bc7c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 08:30:52.0996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1KeofuEyNRuktOpYwNCHKVyTyVOEMMn0PScSxhC3I2705oPLZEflknyyzKHM6st
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
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
Cc: Alexander.Deucher@amd.com, sandy.8925@gmail.com,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This can address the random SDMA hang after pci config reset
seen on Hawaii.

Change-Id: I2d6147600636cbc90d1be7f3d9a011f050708fbd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 20f108818b2b..a3c3fe96515f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1071,22 +1071,19 @@ static int cik_sdma_soft_reset(void *handle)
 {
 	u32 srbm_soft_reset = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 tmp = RREG32(mmSRBM_STATUS2);
+	u32 tmp;
 
-	if (tmp & SRBM_STATUS2__SDMA_BUSY_MASK) {
-		/* sdma0 */
-		tmp = RREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET);
-		tmp |= SDMA0_F32_CNTL__HALT_MASK;
-		WREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET, tmp);
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
-	}
-	if (tmp & SRBM_STATUS2__SDMA1_BUSY_MASK) {
-		/* sdma1 */
-		tmp = RREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET);
-		tmp |= SDMA0_F32_CNTL__HALT_MASK;
-		WREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET, tmp);
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
-	}
+	/* sdma0 */
+	tmp = RREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET);
+	tmp |= SDMA0_F32_CNTL__HALT_MASK;
+	WREG32(mmSDMA0_F32_CNTL + SDMA0_REGISTER_OFFSET, tmp);
+	srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA_MASK;
+
+	/* sdma1 */
+	tmp = RREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET);
+	tmp |= SDMA0_F32_CNTL__HALT_MASK;
+	WREG32(mmSDMA0_F32_CNTL + SDMA1_REGISTER_OFFSET, tmp);
+	srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_SDMA1_MASK;
 
 	if (srbm_soft_reset) {
 		tmp = RREG32(mmSRBM_SOFT_RESET);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
