Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80BC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2549F2145D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 09:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m2s/IlcZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2549F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F36C6E455;
	Fri, 13 Nov 2020 09:28:13 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F396E455
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 09:28:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivl//DYG7nFhmE6fAa7Vp4PgVp5341uFaEJ6fYSYUlQHwJaZ411iQOnievXGQGIIvC5B4nBw7yy24ne0lm2eXYAW5zThQQANaffDLtllPasvNfFPm9N4ockvTCnTKJnIs8Uckz8gstr+Fj4xPMg8O91ybZn5B2vNfPegFVypXJpkU+uRLHr4IZ+wVijGFh+3OJLzNwEmPfeyEGyJKzeVk6MgVTRk+N2Uunn4OJSwILqi1fKGnJJC38KHrxRnF9tjv+nuiw9GdlSLIr6b9b7k5yEyAEFSPKL07X1qUvVajEFcX24tXLd/wPX/vlFkpgajVmclhqdazFiKVV/EhpU2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnOJfF3M7HYwXpZefuU6tDH1l0K+lPeGyXAuv+uoqlA=;
 b=YkohoUGh4Q4h2gS1DIaKn8Lp+JA7NiZVvqdb91kvpe2JJnthRmkLmMJuHOuOMyFFAzpvfebzZ1n8XLd1o87vsc4ulOfnfT4Bjz7Eeev2Vmsvn4cbSt1eD7JbR1muv5dDbVWE2fnQm1F1qfDFuiW8zcnFmKO/EkfycvEGq4r035m60UQeXjuAn30uKpFLO778k5AcEd+BE3fH/WA78nYwHKwNypxNjsSPtwLM+/eELtcGFLXgP5fqY9XpsOsinWMPxkhpp0XU83WozV/8V9hMI9+AA0B7oiOcIamflLs/1EzTngt6iPrFzRTA/xIjczv9sSzZlwk7voFQPYDfMPzsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnOJfF3M7HYwXpZefuU6tDH1l0K+lPeGyXAuv+uoqlA=;
 b=m2s/IlcZZ4QFjC7kg3rc87TFj6V4xxiLeB6u3hbIX78JZLNxy9EbgoG+E/+q3oTTEQhw+o6NYiZgAcXUlqxbkkesgWhpfFZETrzgRSTKzQDDnJKDUbWyi8s5aEzjXKN8/vI0zOwkRgCkeAfYkx2o1sqI1k+RbFgohVsJ1COe6TI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.23; Fri, 13 Nov 2020 09:28:09 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3541.022; Fri, 13 Nov 2020
 09:28:09 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: declare smuio callback function as static
Date: Fri, 13 Nov 2020 17:27:50 +0800
Message-Id: <20201113092750.26602-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK0PR01CA0064.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 13 Nov 2020 09:28:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b50af2d-144c-47fb-e6e3-08d887b66ef1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB498768D3930D7A60BD5A3475FCE60@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYH6M2nE7gRV814a4r4VL2Z9CQfqvkb7eJvFvTEiKfrZO4b5rE1Fc8lUk/2ZDn8jxNPh1eiV+087hFYDyMrCYurkN0wtQpThMnPdY0A14cp4fboan8eRIOGtlp6aXw8WXVzy1RJSN+Y5hYRpIOCO8UNkNG1KxM/aAGMUSRpYStFLsmHI4W9vR/M2QUZZool6Z3zW1dYN4FcJllW06GZqOSdrfsP8WdU7JdLyd/LApy+NrmMfGN8ZcJOb2l7qE4o7eaYZiaFUJFy86T4+lLCYLcapLDGvQMq3Yj7SMhFG73HJQcj2vzFODNVdXCTGn2CBLev5/+F1w5nhoPxek3+2pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(4326008)(16526019)(52116002)(6486002)(26005)(956004)(1076003)(6666004)(66476007)(316002)(2616005)(6916009)(86362001)(8676002)(66556008)(478600001)(7696005)(5660300002)(186003)(36756003)(83380400001)(8936002)(66946007)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JB728YQxEr+kWb0bOxc8360n/XXNp50BpzmF/tXtP3EwXypG+NEgu55rl5felZE/GF0fp9jU5i3nhYnFGSgpKE9uLEDVLr0ajc0ZCn4igLTr8jh+90l9oFgdEbtXHStPemKB6tNW6+zi0xvMHhI4FplpmjmdL3pJTLEB/9Aood2E76zbYI3fbE9zLzUWy1CRu6GRnBgjGWsz1FHnXkkUEsyMXBMddF/xlWF8W3Ty/kgjYCjHP+YTaDzhrP1fIowiULmTb8gLHYTPrv8s9SI0FOzab4z3dMNFw8hJU0AO/MvFHgPf5BcYJy5GgvvEATxB8FAeJ9agR3SSuMQL2c0N0yluJ837I7dK4MDfiqysg7XuXiLQoLV10RfgW6Sycpw0f89fSsQQBp9KQpwL5jsoTC4wIDkX6qY0+WlBDHzlwbgBeavIpWnLbeomK6j+ZP4MxPFaI1b7/J5XeiAGVwDLv6Ir4U9qLNfLpW5T4plqKZH/OdQtC46lNwP+Mb4JiI2XAeihzDV/bTbmRy0A6KzXKsgSz97ucJB3clGfbcrneoJZkUu9scHrPlVkpI+PA2Is4OM/aQfgR8JAfAUcxQijprkPy0Ft6PfFy84+/YeWL7kY1YT7uPmut0KXTVjaoFrHcwlISkzYXgo84DZ6i8phbs8FiyAdR/PA7Ss2L2Z/DopkRFQgp9UmO7Ar3lcXiSXBOufE8DSYzMAFJu8dh9UhF9aw7TB2NkT0dgXPO8Xd7ig7PW9tE5bbzAqBL0e3DbtcwfKqdO96TbCJH2s+OuploHhCQ5xu9ZDeye9V38ammryQsRjzoP8iMAppFXsMBhFyvKgDuM6Mt6GAhUvG6uhb92/SIa9iKdnmKnPcDXqB51c2shu6BG4+26iBsLm00F1nynBa2m0lfjBP9d3FbGqqHw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b50af2d-144c-47fb-e6e3-08d887b66ef1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 09:28:09.0110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pi/lf/uYHnyY+a9LB/yxDFjH2m+SLTe6vNLd0tgJWZGR+IJFbcuJFtNBlMu1QnbMAnWML5bFJa0dWiwdqhUZ4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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

fix -Wmissing-protoypes warning

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
index 137b410..e9c474c 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v11_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v11_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
 }
 
-void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v11_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
 }
 
-void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v11_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
 {
 	u32 data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
index c9c3e30..8417890 100644
--- a/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/smuio_v9_0.c
@@ -35,7 +35,7 @@ static u32 smuio_v9_0_get_rom_data_offset(struct amdgpu_device *adev)
 	return SOC15_REG_OFFSET(SMUIO, 0, mmROM_DATA);
 }
 
-void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
+static void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 {
 	u32 def, data;
 
@@ -56,7 +56,7 @@ void smuio_v9_0_update_rom_clock_gating(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(SMUIO, 0, mmCGTT_ROM_CLK_CTRL0, data);
 }
 
-void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
+static void smuio_v9_0_get_clock_gating_state(struct amdgpu_device *adev, u32 *flags)
 {
 	u32 data;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
