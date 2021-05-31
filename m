Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7D2C47080
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 11:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D72E610C8
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 11:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D72E610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8DF6E8EC;
	Mon, 31 May 2021 11:31:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5416E8EB;
 Mon, 31 May 2021 11:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGjI9QD85X/AQvXckHs2pZSJ/ZJlEtVTpeOh+tzI+wmabib/BArncltWu3AOy1K5D18/rF97k96h6tNMxPfdi7yV0lpBLdT0XkNK8cTHrC5CIXArJlMot5s0/VnoOqQBe4zgwIjnJbZ8DLkqgPhVb1hGmVqC075c9p+bXMiCf+eU78K6mexvMz40LN+kvNJPyGxQ9pcoFn9+URgtSc6HKWLFf4kA8n2vAyTOm1juWXoZnbFOTkOVwc2yzaFPzR9HCdHlj8X3eBgvJ5+m7Vpoe9SmbBK8VEEHDncpCqQQyMZtduf2yg7I1x14oB94I1YuLH/anRijjaAPWgPPjWQ48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhALg3SPnZNpvJIP95gojvcH/U2VThY0vcb7ZtdHXo4=;
 b=KenFQv/7M2OgcDq+tK+fH43M5EFjaccjGlB2jqZOYuMuop6GNfyET/4Sk3HtNq3yuo2cgrSKa5BZM0jnL30Rp2Y/uCvFE4YZy6q3sFcwD5U8mSQjn72LnePvEmNUTGS5wnsgWgTlG96d3NfdFc7SdzKW8MY9DlDX4gD2UA/7BAsSEwdHfTuTc00Su137hm2tg84clVFu4a+wgY6tvQG1W1Btgr1iJ/Tq9o2GaP2RPT7YPltqEz+kRQ1nXw3j+6/yplzhDQrvajjR6EWb2sOlpT05AoUE+LHxk2lpGhRdLihPED3sEN9/21WGY8nOiU0gIg31aLhnGszxqifTVld+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhALg3SPnZNpvJIP95gojvcH/U2VThY0vcb7ZtdHXo4=;
 b=gZJn9jc+2Em4dNoPK98B6/H04QtC1oFYNOkrZFZmcFToxeHaKqf1yTd4dmMJuAPU5gW/yjSj1Hne2RLFokVHMNZWtUoGBWk7w7+D4u26BqLBSEPD7V71HQDSAZ00FG//gm0iGxpLM5e21mk2PuwlV+JZ4ssRT1ar49ty1ipwALg=
Received: from DM5PR15CA0038.namprd15.prod.outlook.com (2603:10b6:4:4b::24) by
 SJ0PR12MB5487.namprd12.prod.outlook.com (2603:10b6:a03:301::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 11:31:12 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::2a) by DM5PR15CA0038.outlook.office365.com
 (2603:10b6:4:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 11:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 11:31:12 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 31 May
 2021 06:31:09 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/ttm: check with temporary GTT memory in BO
 validation
Date: Mon, 31 May 2021 19:30:54 +0800
Message-ID: <20210531113054.2477-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a47686cb-8a1f-4ae8-33a6-08d924279845
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5487:
X-Microsoft-Antispam-PRVS: <SJ0PR12MB548782EFE16C9B3A8B550096FB3F9@SJ0PR12MB5487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9BTGWN81CubfOEjqTJMIMqQP+5bZjFOKO10hU+DR276v/YO+lU0QgrXKFERQse+Bve3DGtBksqVa/ywCeIH4S4G7Df958eXitndh4i20KPcmP5PWGxYg1TtZV7HXXWtIm9i4HG9NtKMYj8KOYmz0FmpB2SK2IYtEtO9P1F3IBKHR/ZCCc0HkXOcHNIBWF5/9Uzg3HlCUNFIL9wqbTEXsAuK4pcsQyjidytCmgFZ4eCnO0Ur++EjIY+TwOutgnZO16lfexkGpOiLhk73NSMfl5EWQAvQt/S0dblwnqW6csqO5lkIJ+b3dMqcjFxjwpy/eSGPHoMTtRShgx7cLaBrWI32MXoNFqlRdbglZW3kJqBgPGML/GWkoyqBpXoHSzaTOjfq0mt/lL6Nbr+jzuqhncMBIBAvT//ckE4e8dNSs9XkRnxfoZzvOSQiBPh/L6Lb8whd1F/QNPbQNJNYHltGTHkhfl75g6taeKxqcZa+XbZ408qKn0UORuCWNpmFt+l+XS/tV/VINly9XWeFHKxiCShkP0923Skdivk/oV6JbwTq/Jyng3nXWG6/1MsO2hqOKZyfQI6K2oQTGj8pysig6bR0t5mQ5lsMQ3svgP2T7+VFG9uRmovIwpP2zV7Y9/VxDF0Pi2MGlMf6JyC4ZE7s3yGBqKIr7X2oMb3jnKlpKfR5XNrXU1cMD8sn3ZstL9kgb
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(316002)(336012)(6666004)(426003)(2616005)(86362001)(186003)(36756003)(7696005)(110136005)(8936002)(4326008)(26005)(8676002)(47076005)(36860700001)(54906003)(1076003)(82310400003)(356005)(2906002)(81166007)(478600001)(16526019)(82740400003)(4744005)(70586007)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 11:31:12.5602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a47686cb-8a1f-4ae8-33a6-08d924279845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5487
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
Cc: Marek Olsak <Marek.Olsak@amd.com>, Christian
 Koenig <Christian.Koenig@amd.com>, Huang
 Rui <ray.huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Lang Yu <Lang.Yu@amd.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6?= <thomas_os@shipmail.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a BO's backing store is temporary GTT memory, we should
move it in BO validation.

v2: move the check outside of for loop

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index c32a37d0a460..1802fc77cfcb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -938,6 +938,9 @@ static bool ttm_bo_places_compat(const struct ttm_place *places,
 {
 	unsigned i;
 
+	if (mem->placement & TTM_PL_FLAG_TEMPORARY)
+		return false;
+
 	for (i = 0; i < num_placement; i++) {
 		const struct ttm_place *heap = &places[i];
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
