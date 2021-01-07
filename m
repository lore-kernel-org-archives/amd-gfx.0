Return-Path: <SRS0=Ke3f=GK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C2C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 03:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B6522D01
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jan 2021 03:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B6522D01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCFB6E3DA;
	Thu,  7 Jan 2021 03:29:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9975A6E3DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jan 2021 03:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/2YaS8GU9Y50iWPOWVmRnehUMk92JGRNqpdKUJGmnffZjBQCPucahgqckLxReIKsOOyGhsj/hTPNtNYQuDYUliW8XP0lOegUQwVIJQSCIG0WpGv6UPp9ul96pKBQC6/l7afX5S6c8oLWw+BvL2otI92TLQjTsOVwoftw/VkDEVzVdGfqsdP1CxY3R+qOaYHxoX1FySvU4Poqg85JEGGU5GK5Til+HQwLiGgJvWCg1uuBLSupRXOXxd1+x2JdsOMIDRil1nYNyhjHdXNvoNGi+OvRyVJY1zd5OwUeGWPhwUyBBlFxw+2cEyImVQjwF4B83RcmfSFAvyCnyEQbVMX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLrHISo6xAgCYBE8GDY1dceOULXiYCNFjUI4yAfnIBk=;
 b=nTA4x9938SZk8zbq3etUcIIlPBHcNv8Z+46slYOa+MX275yuIr03uh7dbfWKTa5gN6Tt5X4EAfvbgzmeWjYeTEmwT+6BJGu/hD5a8tOT0FUvV4KfSHzRNgA8O1pRhp2212DHdavnJvn7hnOktrhVDr6jXMG4APUE1mkUJXG8R+zuzfztaJkWTb7/1pyAVFk5UB0tHJXSptjngMECvPjOpKO0D0OEXMLKUkPB50AmZL1kAhz7Yx2Epqpymq24mjaPuhKxrAavtht7a1mB0T8/2cXEUvQIIaRJEYW3/qnw/l+35fy6EZn1RdNaLtNWxUlkZYuGMA1elEIYhyqGDV8WtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLrHISo6xAgCYBE8GDY1dceOULXiYCNFjUI4yAfnIBk=;
 b=ZAqOgLCAKpIIUGbe5n2a3yHTNvrO8bdrnoZWCYpl6vOKDEEdW67wZtuf3pVQxLAMUZPsdisCdG4XvEi2jfy1hw7Qmnaflnr8BA0yAeSZRTWBbX8K/F/lSWDsaOuyT56SKTvzKOh/xYh2X+oI+zr68xfGVN459Mp0dKpkHTaNZb8=
Received: from DM3PR12CA0085.namprd12.prod.outlook.com (2603:10b6:0:57::29) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20; Thu, 7 Jan 2021 03:29:33 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::82) by DM3PR12CA0085.outlook.office365.com
 (2603:10b6:0:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Thu, 7 Jan 2021 03:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 03:29:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 21:29:30 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 6 Jan 2021
 21:29:30 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 6 Jan 2021 21:29:29 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Date: Thu, 7 Jan 2021 11:29:27 +0800
Message-ID: <20210107032927.660772-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6649e6b5-ebc7-4e0d-10ee-08d8b2bc7258
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382768114CA9B387694F3648FAF0@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEE5uzmxJ4+bimIAjAJo+taEwd15nJRSwyt3rPussh/A5+hS4iow7THEykrqZH/+sadFG/4AI/fO/67wZtPB3Csq8Hb+rBwcSLtcaJCAcVwcfQs/L+kniyKk3PVnFsFZtRwlXmXPD29FjJ99gLHqIT/lXAv7Y2GRAkXz2ZcJM77SlleBhxi1KOWW3Slo6fIoc71tHw/xtaxV8Jsqm2gDApXr3fX9nsl9EvkWzgJKfE+9oXBLLKd3wZzpXGXlmuyQB52Wf4y6FF5KO7bJcrOdTsKex8b5Wi8p+X/edmBdmXsVycWf3VXH+OMrm7oRw3Q86z2OCumwtBJGtvKo2vF2AumPPnaOMADgZeImTR1qX+At2torp3ZJfGubNKV1HFkiEQJQV0blk/jaTlHIhkNwFQd7ZOUXDK+9Yl0gAntwjGwJRZMEN24ww2MBAHy+i6F1fpLaI4ob2RgTZA3ih3G2EN+alqBAmqpouVbBhk+nKbicglQLCni4HIojwGBi5v6u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(8936002)(5660300002)(70586007)(336012)(4326008)(82740400003)(36756003)(1076003)(7696005)(26005)(316002)(70206006)(47076005)(2906002)(186003)(34020700004)(2616005)(82310400003)(86362001)(426003)(83380400001)(8676002)(478600001)(6916009)(81166007)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 03:29:31.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6649e6b5-ebc7-4e0d-10ee-08d8b2bc7258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
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

From: "Emily.Deng" <Emily.Deng@amd.com>

Limit the resolution not bigger than 16384, which means
dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.

v2:
  Refine the code

Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 2b16c8faca34..fd2b3a6dfd60 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector *connector)
 static int dce_virtual_get_modes(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = dev->dev_private;
 	struct drm_display_mode *mode = NULL;
 	unsigned i;
 	static const struct mode_size {
@@ -350,8 +351,10 @@ static int dce_virtual_get_modes(struct drm_connector *connector)
 	};
 
 	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
-		mode = drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false, false, false);
-		drm_mode_probed_add(connector, mode);
+		if (adev->mode_info.num_crtc * common_modes[i].w <= 16384) {
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
