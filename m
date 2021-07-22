Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EB0C63793
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 07:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D9560FF4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 07:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D9560FF4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 593616E8F3;
	Thu, 22 Jul 2021 07:13:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87C66E8F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 07:13:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7hyr6GvZw15H8vkCrpl0wO2mmkpyi8OjFNT8Xmznev/pzK3pmaLjsl8yR/e4LDm0ip00Pp8GZq52JEqdvWVOLq63b4GzXYJN5GWkhwCEUmM7xcHkELbD0kaFdb0g4qBrFiiFJD1tnpcE5vUuSEBoSL/uZsF9yl9z4IpIDLRMN4h1zSH59Hmrfz6/JuKlSsCvqU94FcK+haYzcBMP+HmsoF4rZAfOb68PpY4Gyz19BWpCkacyFyGzacnoGHow1CbfSSS13C6ed1coXdmSWD1N0WY6FvxU54rMObCil7GvVV4qMW1p8Gwo5Qm5V3C9a58MLJatK42677mdrh7xKgZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEIVWsESwAP+ee38PTuBdJMo9R18jXhnjqn8HIS97ms=;
 b=MPYkOm0U35iMgBwEPH9tPR4fxShqScXkWhaMxL7YLDuAO/nb1qMz/IHsUx8S0nW5rI5vdDPavOrw5JHImyx1mDwC0NPGMeM/fXxAc+umzGe1dVFS3KQTopZiHKjHGT2zRFgtXPb7wvICjlEJmJgsqUv7kYTCJBDe1DKmS7Rt3sTcDvNnEKiIF1npsTEpOk/hF65xLBafToPsirNtc/t0d0ydNsN7shRZPXWWtv3IRxQOhWRhpmhREr4VvJZYGXsIqU6F9DYHcxprIi+D9VanyLHvAz5OgFfWhVtM7O3ad8yXa7iS5+NpWi0qD4N0jrefbb7FSQoLgKmWVRlBlURU0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEIVWsESwAP+ee38PTuBdJMo9R18jXhnjqn8HIS97ms=;
 b=cxtQFjEsUTlFhGZ+yUpoHBMr1mCiiJkX6/sTro3a8YG22cuN8zi/plQOFKHNGg+Adb6UHKA/znMC4CoEt2moyIhtBDRn3n4+NLEcqKWn9k8tWxfs/0CWFcOkNGE4cD37v69AJss321N2RvKJ/DHqve9f6miQqjAWkFT3g1shD6Y=
Received: from BN1PR10CA0021.namprd10.prod.outlook.com (2603:10b6:408:e0::26)
 by DM5PR12MB2552.namprd12.prod.outlook.com (2603:10b6:4:b5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Thu, 22 Jul
 2021 07:13:53 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::75) by BN1PR10CA0021.outlook.office365.com
 (2603:10b6:408:e0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Thu, 22 Jul 2021 07:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 07:13:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 22 Jul
 2021 02:13:52 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Thu, 22 Jul 2021 02:13:51 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Change the imprecise output
Date: Thu, 22 Jul 2021 15:13:45 +0800
Message-ID: <20210722071345.752-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df40818d-076e-497b-d24f-08d94ce04304
X-MS-TrafficTypeDiagnostic: DM5PR12MB2552:
X-Microsoft-Antispam-PRVS: <DM5PR12MB25525474A5290C2A7FBD7745FFE49@DM5PR12MB2552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUOOOhZeUxF23zdZXpUC+8LzNJKxwlWB+cimwfd36DkdjAkYXWOREhJm3X1IiicZz++OIDvCr5y2AUSHXOtSkEIPj7DJ80J/0IyV8NGZKHI4YtCHq3a1RHP2oZ9gCGpK8eRWj4zncKRVXavWM0aqZlXM2bPIy84Y2yWZRjkiVugYivj3aymNBPfpb60IohTKPc6i9kzCI0NOY41dingoooKC1EXZhi1WlCdTBzXlfKaHppwZ6qu6qF401aiAl3+bRx+VHqjEM173tC2SCqldPf7GEncVav0V0Unr1C8iAP/hfWyB/bofg1gdQSnckVBafq7w8qkVVuDAmsO+0gNVfg4nhDel1ONOtz94Qg7G2LV93VJlynaMVWb8zYvVh+jX7S+PNWNn/bF3htHPb58zHXvsNK472TdiRMIHAqYgUTLbtdjxsZZ85p95I7sbQbpwAqzzYP2585PqIsm5qewmmsIR6Ay/pPiwRNNSmMf70xIYxuEenAMufh8gvUroffoFDTKOqkvqSVlHgOqcMJNv3jRyDUMrTcWv4ZqchBEso8G17PzmO2mobymt0uqHGUimN/hdjECbcaSQNlZT1IKX6nG5H5Voz7Y4LEP1WsE4QXk5vMBN3WOMbvvES60Gu8H17J9oZeXCWPkLMqOgu4xEZ1Pas/UxNU+IwlTgARg9SFoCiuNXrgE7K5VfziDfeDn+d9xDoasxRD6Nhb8vktB0eym9Q0LPpN4uOGlbxZqWDVU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(6666004)(478600001)(4326008)(6916009)(36860700001)(86362001)(70206006)(5660300002)(47076005)(186003)(82310400003)(8676002)(8936002)(1076003)(336012)(82740400003)(70586007)(83380400001)(26005)(356005)(36756003)(426003)(81166007)(2616005)(316002)(2906002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 07:13:52.9860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df40818d-076e-497b-d24f-08d94ce04304
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2552
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The fail reason is that the vfgate is disabled

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9f3d82dfb79c..f94ef15b3166 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -56,7 +56,7 @@
 #define GFX10_NUM_GFX_RINGS_Sienna_Cichlid	1
 #define GFX10_MEC_HPD_SIZE	2048
 
-#define RLCG_INTERFACE_NOT_ENABLED	0x4000000
+#define RLCG_VFGATE_DISABLED	0x4000000
 #define RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define RLCG_NOT_IN_RANGE	0x1000000
 
@@ -1571,8 +1571,8 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 
 		if (i >= retries) {
 			if (RLCG_ERROR_REPORT_ENABLED(adev)) {
-				if (tmp & RLCG_INTERFACE_NOT_ENABLED)
-					pr_err("The interface is not enabled, program reg:0x%05x failed!\n", offset);
+				if (tmp & RLCG_VFGATE_DISABLED)
+					pr_err("The vfgate is disabled, program reg:0x%05x failed!\n", offset);
 				else if (tmp & RLCG_WRONG_OPERATION_TYPE)
 					pr_err("Wrong operation type, program reg:0x%05x failed!\n", offset);
 				else if (tmp & RLCG_NOT_IN_RANGE)
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
