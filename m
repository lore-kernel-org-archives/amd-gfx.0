Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32ACC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47116221E2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47116221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D800189C53;
	Wed,  6 Jan 2021 01:05:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E4889C1C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 01:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxp1iD+59SPJyVAAlGJs9DIJVnEwa4qrpdelznKZ1PPWjN5MqTiVFPLPUdK5ZBxQ7Ln8asdY0hiazlXhDsZO6h45Mchm5mi+VIAoVj9+kgOHxkFsA195w+wQbVoXXJiy9mI+ZICy7vzFxlc/H+XTqEuQ5hOpo47s74GwgYYDjWACHI0CjsEXgL8BsCKTNO0DWbg07KFr9OQLoZ8TGOXmHzMisazwUP582vv2i/RJEOYHpwitTZHC9UmEqTQ1dcEMzPAJZ0vEWTmvs+RNeYOBQZnnInt61giUfyp2rrudFzJg4JcsCg9m5SPxjI6OAb1LAc+lnv9ZH+NfeB6AKVofvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B54r5k0alTcxjByHSMckrPzcEKuEY2OtJJwy8wf/WI=;
 b=QgKoM/ES9nmlSlmy1+PLwJun1Pe3fZ4Hs6K/pIBYnTkHe964ydPgcC0LlicePZAMcleSne8Up1yfRsqhEqZnUurbxkDrC3kmOLNZvCBqLewYvdJcksCyvqG+6HT7S3zMMKu/9tnhEaPwt2Pl3aZlHCcXpNVkxnSmV1B+3Wt18r812mOKCv8gBu00mz3AQPcZinTXIQebS70h6Cr1d3L47AEa2UmdkdFXtOrCM/zdaXz+brcLctihmi+Whxspr/ROPsbHX6W6cA6fqMhpqFF9tmJ+oYTylpDhj/1XpDcZi19TfnJDHkSh+oswoHGoEUnaLV6InxQB9I8s6gnlyVGeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/B54r5k0alTcxjByHSMckrPzcEKuEY2OtJJwy8wf/WI=;
 b=es3780vwVl1isD3p/JuY/41MzkPw0fAjufs99FXJg2z/CeCffsHhZ2uW6UqkZjJUgWe2gG/NFcMVjythOARbOoQ0ir5u1aqv2Dsc5fV1wcGCqOf84cU7zwqOtS7qrOhuIMY2rS+bbwCkQutqxy/Xrlw/btPlO6MCIvsNVvekIZs=
Received: from DM5PR15CA0070.namprd15.prod.outlook.com (2603:10b6:3:ae::32) by
 DM6PR12MB3321.namprd12.prod.outlook.com (2603:10b6:5:3c::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20; Wed, 6 Jan 2021 01:05:28 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ae:cafe::cd) by DM5PR15CA0070.outlook.office365.com
 (2603:10b6:3:ae::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Wed, 6 Jan 2021 01:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Wed, 6 Jan 2021 01:05:26 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 19:05:25 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 19:05:25 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Date: Wed, 6 Jan 2021 09:05:15 +0800
Message-ID: <20210106010515.486545-3-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106010515.486545-1-Emily.Deng@amd.com>
References: <20210106010515.486545-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d47d372b-49c0-4070-d7be-08d8b1df2730
X-MS-TrafficTypeDiagnostic: DM6PR12MB3321:
X-Microsoft-Antispam-PRVS: <DM6PR12MB332161FB8FB734E3EC0237248FD00@DM6PR12MB3321.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yGYhFbsDXuF82AgxBI4fUx23W7POOmZa61soz61XPjMEDcEEdiH+eK6DKuCuel1lbT6PbAVrggveMoNe6NFZqQMxddgOmrI08x+9//tfCDewCwz0DOjfPQu8E2zLG0vH8EbzQEKEiZPrszi9vezrIUnPO2qNnp5xy0Hyu62iJJgYsa6HTxWjFz6GnFAOZcvOg1cvxFgPg+RUx3+MSyZ2vL/gxnNb9LKA0+dmxwIsLKuJrhfijMMJXBpNqRa3Urpigo73J9pXFWRaORM646nnOzU4jhJpmENdky4eWPcPFh+xgwkFQz7x20djthjootYUNkFwqTuSUdoeEDg4eK9NrEQ1OIIDrj4RFXZpAG+T4Nyx8X0HPoNxSj6zpuKCIkXQEc8pPorI39XkImG1S4uKTJKMsRuNlXmhll4Yh5QygAVHuArJmKSmu/DhUPae2xHtSGShOnsBK75GCXTJXb9eEdun6DAZbnei7id8eN7f6deQlILFYeRagL26epxl5jv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(336012)(426003)(6916009)(186003)(82310400003)(70586007)(1076003)(70206006)(2616005)(5660300002)(478600001)(47076005)(7696005)(81166007)(356005)(82740400003)(36756003)(83380400001)(4326008)(86362001)(6666004)(8936002)(316002)(8676002)(2906002)(26005)(34070700002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 01:05:26.5371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d47d372b-49c0-4070-d7be-08d8b1df2730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3321
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
Cc: "Emily.Deng" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Limit the resolution not bigger than 16384, which means
dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 9810af712cc0..6fc864cfef61 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -289,6 +289,7 @@ dce_virtual_encoder(struct drm_connector *connector)
 static int dce_virtual_get_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct drm_display_mode *mode = NULL;
 	unsigned i;
 	static const struct mode_size {
@@ -320,8 +321,10 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
-		drm_mode_probed_add(connector, mode);
+		if (adev->mode_info.num_crtc <= 4 ||  common_modes[i].w <= 2560) {
+			mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
+			drm_mode_probed_add(connector, mode);
+		}
 	}
 
 	return 0;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
