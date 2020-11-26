Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD331C56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 08:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A40820B80
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z/AUxgdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40820B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600186E842;
	Thu, 26 Nov 2020 08:38:08 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC0E6E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 08:38:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEKcJTPtQiUpMwveNqPbFud53UEWn/wmfOpSXEbekOjGWdhS5lU3OGIvigXG5GtVwghnaPzGPR0G6dO9So54eTernhO2Vv+FbkiR9akDqNU5Lsuv2iPNTeEI5KNdHLdsD4yEV+Fmn9neVHENHVI6x15O+fBpHOG5+svnDCSMQJfjksQx6jiaiJhyTP3nIlRox5Yy0soV6Y88b5pXdTH2RyCRdRWKiLe/ydxV/fn4jPzRFRWP+XAqe2bu7BRFu47lHlELzlnpfQ86yUXJbcfTAUM3orEwxKFrOpfWBNuoO1YEVriimVu4gaunfkg76umIOTnFp21hnOjlbo+QVyGyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz/Xt7Mc6M3prGrqbBGnz6oGv5eT5yMA3H5tqHX4DHA=;
 b=dZtOs+9Kiq7YT1MUR7LoMYpDkJbU2cEliRUw8RM5MJcjtK9R0JnmjFuw2iyPTIQD45J5Ur9CxSEViOTjet0YQvqZ6jbjSigcZOfuIMYZyoRj982BWIS+LV0ZKnnjZoG4b2W9NOY2tVfyOVRt5ghKX1j7qNcmfBljPTyU4E0D9uaZymBNl/WFg472zMw8l1maX75ofIU2W5BbHwMTWaIngWaBcr/ujH7B8CfSf9zFasekHfvrISW8laMXUnqaA3MTfB7TyPv5+GIKJWpYdipgfq0ilmxN56JT56Qmr3IhW0nASDlcyWcDUMvyU7vCzTKFB845+1hmMQ08kh3qhnWfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oz/Xt7Mc6M3prGrqbBGnz6oGv5eT5yMA3H5tqHX4DHA=;
 b=Z/AUxgdovW7rW4tUOJpWPLojJncAI1J5HTXmmhQOURHirZlObtpW3QnxRZXGWt2wl+0HNiCXSSlmAm2uJh5TsBoannQb5XVn28wLdqEZGU8EIi+bIh9Yztuk4aNDznJVCkSGuYW0T0qVb3GZkJ4SYnZ0d8E47TdYd9QVUdUb3vA=
Received: from BN6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:405:2::17)
 by BL0PR12MB2338.namprd12.prod.outlook.com (2603:10b6:207:4c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 26 Nov
 2020 08:38:05 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::fd) by BN6PR11CA0007.outlook.office365.com
 (2603:10b6:405:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Thu, 26 Nov 2020 08:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Thu, 26 Nov 2020 08:38:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 02:38:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 26 Nov
 2020 02:38:01 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 02:38:00 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jiange.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: skip power profile switch in sriov
Date: Thu, 26 Nov 2020 16:37:56 +0800
Message-ID: <20201126083756.3864267-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbf57b06-2006-4e4c-d878-08d891e69836
X-MS-TrafficTypeDiagnostic: BL0PR12MB2338:
X-Microsoft-Antispam-PRVS: <BL0PR12MB233899D27174EDA29925D12AB7F90@BL0PR12MB2338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiGPN9nsTQLkCe9IwJBFqnPw3R20LEmFTy6zp5dTxVsy1dQYccI1bQdVgRbi6nVbBMFFWVolVXYv9SmdiAtkX2BonecKMS+9Wo1tI9IRfGsrYfZFPZSWGQyNnl4zPn4bVA1HszhhTpEgKCiBvY18oP17zf+5LQfBbV19mfLZdfx46HpGy4zi89EQL5cOQ7MOPORGlqego0IcZxeSfbPQujz4PKZTJu3sA3bZ+GxqDDad8sOFbxD8vXA0+AL3IkzRiVWfAC0azRq6OAGviEMvQhXuNvGSDaTPQY86nfN2GpvYiIDxdElsuPbbC0INFVmerLJORDQnzXmQlmb98z49yK/ToGRvmbYwvhVipEYVdMQx+oRmMjdqkW0Y8d7mfS9B1KGZX9GOTu/9ps9OyU9XgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(82310400003)(4326008)(5660300002)(186003)(70206006)(2906002)(1076003)(86362001)(70586007)(81166007)(6636002)(4744005)(36756003)(356005)(8676002)(2616005)(336012)(6666004)(7696005)(110136005)(8936002)(82740400003)(26005)(478600001)(426003)(47076004)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2020 08:38:05.4712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf57b06-2006-4e4c-d878-08d891e69836
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2338
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

power profile switch in vcn need to send SetWorkLoad msg to
smu, which is not supported in sriov.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 17a45baff638..8fb12afe3c96 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1168,6 +1168,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 {
 	int ret = 0;
 
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
 	if (is_support_sw_smu(adev))
 		ret = smu_switch_power_profile(&adev->smu, type, en);
 	else if (adev->powerplay.pp_funcs &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
