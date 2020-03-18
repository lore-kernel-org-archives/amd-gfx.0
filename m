Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2436C4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D9120752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vYiAFs3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D9120752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CB76E98A;
	Wed, 18 Mar 2020 22:52:30 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690044.outbound.protection.outlook.com [40.107.69.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4816E97D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnBpHTFdQVsAMqVFEU9JmV6mBDjov4/qq3Tzx1qJrkKiSEPjHByYFelbL2YSVIGOpawFmN7JYI1EkKj5WXIMw/t650g3Ps7sZRVCiUsPvSM21kk9PMc55nBK/1UIRZ9h679lYzJX7Z7oUTyviHO4M8f/3ug8pyExN7Y0bIJOoRSjxBy0m/wNiLUsD0Qu7JAx3ItRY6hT5hWxfYbSZl8WuYtz1snog6XyAxREjoO+XLzeWdwJXnB4B2ylBa+iSuUFzkXagXpSZuTSV/nbEPS3AA37OEC8/bYhGEECPmECzMRkSmM66OEPXjEqaFz2vyH6zS23vSA7fZeKpAs8V0pUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQWPX+eqxionVpY8yxhib2u6W4eTOkBOLlS9Pc1lXrE=;
 b=F0XWufMHlHCRjZAptaRKJCyGqf+E1SluyesevOgqKoAV66slNTiRvLieDqIAF4apoJmJtWDEDbLGcoauqTT0qgFrSv2aEPhwtqXOjniGG4NSNmwSVo9Iw6MI8QptikTkU5d40q0DJt9GAMBwDQPLQTmGLNK/0gsk53txEiyqUd8jzxTJlekbYjROs7nnwRmQPAe/cj1Fh9qi8ZU5LDLftDayjeLdrE3zP9YAXPPeptr3LowZMQZCFIdZydQm29nDNxzuGZsZbE7vkf0adANz5hrNZnxp3Ay5b+0dYlXXOn0aXzcIR4f+pEx6SPZttA7brFoD0nkVyBs6NaPJc1RaYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQWPX+eqxionVpY8yxhib2u6W4eTOkBOLlS9Pc1lXrE=;
 b=vYiAFs3irtPgl+SaaNbhiTE+R5CG9YmGO4ZT7Rm7Miqs84IBR790YRnFgZYD/ZrS11wKTkGYaMvXLk+eFVN4CUlpg30tpCUn1oyOS98uLfVnyVdyuykEYkznxEDkGVGD1PFpR/EkYp+CowyNZYUlKPAPbEwe/FIdHbBCQQ+ydKQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:21 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:21 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: remove non Arcturus references from
 arcturus_ih
Date: Wed, 18 Mar 2020 17:51:13 -0500
Message-Id: <20200318225118.10756-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b64a6421-6e9d-4ef0-bd2e-08d7cb8f0443
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44157AF2F421B8DED99AEFA5FDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ml4Msr5MRhQ/15Pcj5/3T+XmgaQxuTZgLfq+uFGUmNSWLAygkYoeQb9+H0JPtOTyMTUMJ58qr9le828bsU3+jnZ2Ij9ro19RUTj8m/K0QBX20T7EVaSq1bydmsDxtvuptkOBwJ1qDaMKg8BhTJ/kphwukp7oVGM3EXlOF69cx0PF1QovjsVnsk8d9pqOgey3M6LrvQgS1mFGvc5WHQWb4aOLDIlw/c79dZTuH2GtrwsojmZ1g5T5Hs9U3P/f3yQKvC+AKLzjkCD3PESKKRiKU8Dp7AxAtWTLj7hY7i5BN2YaHM+tQgY9zxxxGLkG8ZH2rxLYf++rxcBwyT5KQUIbh03GxZj1FLRb10g+fdzBINj9YU0y/nX2GgKQ50f+ou6wwDD/1AS3fSKaNm6rrNATkIH1hbEj0ZJUWCTJ55mHjG2B3hJhonsanJJeqigPq6Y
X-MS-Exchange-AntiSpam-MessageData: Bcihjbv6bwX6SvUqAi2iiKqe1rgUm2U66dHDp0s3EnY6lthIZ6U6GP60fddaYyQHp5q3zRXg/2QWd1qDMwMWL2tXWlj44n3uhX56qq8gbYHUecE21wVfp6o440KpslIG0RpC4Jv2Jipz/uDw11w+ng==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64a6421-6e9d-4ef0-bd2e-08d7cb8f0443
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:20.9848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGKEQgZ5h9NA5xPHmDIzJWFPtpoZ6CPYgazavRDdVyKnPbMJSZBdpNwFqzr3Km13U1xgDDL7EuhupzN8m2s75Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

Renoir and Vega10 references removed. Both have their implementation
under vega10_ih

Change-Id: Id12a0228ea75dd7122c5ec264e5b38a00a79b45d
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
index 21bb5be40921..b8cd5c3c8a36 100644
--- a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
@@ -246,9 +246,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	}
 
-	if ((adev->asic_type == CHIP_ARCTURUS &&
-	     adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) ||
-	    adev->asic_type == CHIP_RENOIR) {
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 		ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN);
 		if (adev->irq.ih.use_bus_addr) {
 			ih_chicken = REG_SET_FIELD(ih_chicken, IH_CHICKEN,
@@ -686,17 +684,10 @@ static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	if (adev->cg_flags & AMD_CG_SUPPORT_IH_CG) {
 		def = data = RREG32_SOC15(OSSSYS, 0, mmIH_CLK_CTRL);
 		field_val = enable ? 0 : 1;
-		/**
-		 * Vega10 does not have IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE
-		 * and IH_BUFFER_MEM_CLK_SOFT_OVERRIDE field.
-		 */
-		if (adev->asic_type > CHIP_VEGA10) {
-			data = REG_SET_FIELD(data, IH_CLK_CTRL,
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
 				     IH_RETRY_INT_CAM_MEM_CLK_SOFT_OVERRIDE, field_val);
-			data = REG_SET_FIELD(data, IH_CLK_CTRL,
+		data = REG_SET_FIELD(data, IH_CLK_CTRL,
 				     IH_BUFFER_MEM_CLK_SOFT_OVERRIDE, field_val);
-		}
-
 		data = REG_SET_FIELD(data, IH_CLK_CTRL,
 				     DBUS_MUX_CLK_SOFT_OVERRIDE, field_val);
 		data = REG_SET_FIELD(data, IH_CLK_CTRL,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
