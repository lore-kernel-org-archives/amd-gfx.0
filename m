Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E71C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEC660EDF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DEC660EDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E1B6E405;
	Tue, 26 Oct 2021 11:19:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBDC96E405
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 11:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5G+HhqoOeiF/Fpjfu87hjaGsgrrS31WEBLYxSVeOPBvaAlsb3YAqGPiXZm4/9/gmMme8g5K18n0R1S4Uxqc06K/kGII7+DUITaM1kBXB2UFsqlvhGCXUj9wst2HfaKwhkDGLrlEjyuHPogVW0BjxAJt3svS2WGcNSZKV9htqHJI4NHfUjeNX0YjiDfxoDz0ajMw3lBU6EjDh8EgcjqgCcr5lLThwcA+9qcqLuFiM9c8zrnVJ1PbBX+7KMexEtPA3/386V7Tq2E8sJJuLtqGan4jWchezdzkA2mDXsSJAWP6dhEc4Ai4L8CuDJExMQ638vmoXGmRy53z3BNLx1yeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elROnJswcni3y+CdGU5bG/SdlepjCMdjlBgRWJKZFg4=;
 b=BqY8P06cij9PBvtfajreH4n8ma0wupMeamhJ1lxgqfkGxkeCADMGdYjZcr8p1bxhJZaFqDI5kC5pWQKxN7qvobdeYhUKWzV6Le1cTd12Q9v2ppzu+Vjn04hWywsBDZicrnHAd/yCQxJij8B3/+a5ch4/nRkelhNONaMVxDCJ29JggLswuPACj2PpzPnIvWLsEdv92CTzqouRlFGZ+pkBhC6yEJ18FJ+gDlovBjINnLu9JbD5KTM8RxhbgB1F08nn/Z7qbS5lXKt33xlE8w87bBZzOKEbhxIN39f04VV8dPrBj9ENekH/ifeOLodjgLIw2HRa2FvA8yLAShnqQp6kdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elROnJswcni3y+CdGU5bG/SdlepjCMdjlBgRWJKZFg4=;
 b=A6wKQlkOeD5BNY48+9VPy7z36/8r5lwoPDqAeUdfdhYOIqt4qityxLJKzqdY2ank2/GP8Vmxyd+2ilhsZPcx1ifNXwuvQ/9evdF9MUDQj+ceJxwbFbI4ils6CpoAi8nhC3IPxaHBVKpHA62jp7yPwb9tCCcnb74m43YwPiJTNAY=
Received: from DS7PR03CA0282.namprd03.prod.outlook.com (2603:10b6:5:3ad::17)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 11:19:34 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::98) by DS7PR03CA0282.outlook.office365.com
 (2603:10b6:5:3ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Tue, 26 Oct 2021 11:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 11:19:33 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 06:19:32 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset (v3)
Date: Tue, 26 Oct 2021 19:19:23 +0800
Message-ID: <20211026111923.22147-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2ae6c88-a55f-4f59-02cd-08d998727cdf
X-MS-TrafficTypeDiagnostic: BY5PR12MB4129:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4129318DAC7117F7D6C87455B0849@BY5PR12MB4129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1FyXcoO6ecAngX5TqeKfpsCcqHmIi6sat7m6lTWhhTb1uKS+U8H5oiuIWWMWul/lTOZ3Ob4p/29bkG8t6LuyuZVCVx3yXA+1IpFvK0u8GQrifcm9Ges/UdWIdr6KDMK8RUhgmNQbv5sxnAa7cUh8FmvCdbkyjaDY0DW0pxkynUAMeddnjIm92wiJiE3wtt9lmhZAO7j1LAanyULMOXsjodIQGl6Kcf6vgg2O9bZlW54oxFY1LYJ4Hs91SAcvAtBiklro3YN+ymojrWFfCWec3bHwIvdmjso5OMqPdJqvwCAFkaUT5YrHXaDSBImNQcnoUYMGkv5fXfpD2xjldBIC0moZwGmyW6ILuClAnf0cf7WswVDdUwMr11QvhhWqvzqMYE/yT7b3NnvrXzVnbwCZcuhAey0oelVl6seoHTfYxbSnphpzcEnG8ChFVGjd0alscyIHf8QpgqBbO9Ocht6v99zsa7dHByKKMvufJmpNrHRqOpMtLQ61KjpgfTBNQWDTTaRmp4GkDTBEBALBNSKogX/dkQftLLBI7TIx36wRSlj4IaAnGCyKLki/0WvnLh1fqNX5VkgQH+r+D/MyzYWQtbYP8+tq7Cnxa6ITojMKd9nanKJYnrBlOZxESig/nzLi0zBmiFFi9RQKtD8RFP0yafhzF9KI4ZMBDEN4s4yJGYoXyWelK5ewhBTSweTV5kRwg4lCNGlB2XZQGls+WNkDV8pqGZsoFeH+S28TqqONZc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(81166007)(356005)(2616005)(7696005)(83380400001)(5660300002)(36756003)(2906002)(16526019)(316002)(26005)(82310400003)(8676002)(426003)(47076005)(186003)(336012)(4326008)(6636002)(1076003)(36860700001)(70206006)(8936002)(70586007)(86362001)(508600001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 11:19:33.7520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ae6c88-a55f-4f59-02cd-08d998727cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove GPRs init for ALDEBARAN in gpu reset temporarily, will add the init once the
algorithm is stable.

v2: Only remove GPRs init in gpu reset.
v3: Suspend needs it, only skip it in gpu reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 24852a24cc58..c4f37a161875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,9 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
 
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] == 0x3f7f)
+	/* Workaround for ALDEBARAN, skip GPRs init in GPU reset.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	if (amdgpu_in_reset(adev))
 		return 0;
 
 	gfx_v9_4_2_do_sgprs_init(adev);
-- 
2.17.1

