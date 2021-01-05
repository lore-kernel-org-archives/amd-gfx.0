Return-Path: <SRS0=s2Nc=GI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1719EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD332065D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Jan 2021 08:37:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD332065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F3DC6E0A8;
	Tue,  5 Jan 2021 08:37:41 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88816E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Jan 2021 08:37:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC0mP8GfM9NtlEmsKnSNSi+x0ccZhyt7M7uZyC46O987XK6CXfR66+kGqRqTT31sOvEX35E8BkQk9uJA9n/6r6WgNF6WOmvRnOt6lzr1Gv9rkBkqjD+hRDfADIqbqAFlHJEcvBFhEz+0cw6RVts/+gvBvWVxNIBRpxxZVPC25/zGwmy6fbE2l6jsuTFDm9H32Hqb4nuR9idrBSi1f6nda+Gek/xGDpn7dLaSvzXdxV3WYqahRwWYBCLJRpO7E9vc6hEGuufArGKkF4BbFslzzUIOolysh8rZ185bsssPOku5DWUYAcJddTMyw6fLpxWSECiNrrekj9+tpT9jNXHicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2PbtvcJ8jQbI9/AjePl0f62CdDKv77kpe7BxRGQmLs=;
 b=JYgj5esJoUW57hBoc8sjjlCiMSbkn+Z5V1QvYib94mvNu9lJehqLb8nfUSwSDiDF9JCWIVKshVrFwcz8n0XEAxIsALNC6H4KZSKpWvTlOHvaZgvHFcFWZ9ONwQBdEUpeL+clF+fhlHd1zFFmMw/0+w6I5goONh3mZjkCiPKMQR5UxInztw+TiMOcrxR3u/pLDjXC78jl9wuHrYbzh6bAlC6YAeeusn6KA/G/p0Pd3JFJEiV4aTP1Sy+jOPqDWMMn6thdEvg8iYiny4CvHTljDjXiRcjaycTGPMcXPkIlavowTmUdW++hHrhmabmKByOZPnat1ueLv32nTzQmYP1gRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2PbtvcJ8jQbI9/AjePl0f62CdDKv77kpe7BxRGQmLs=;
 b=Aj2IpW/w2JCwqa5CHAM7LsMNgT9fQKv7rDG22iX/lav4Mahl7vIPmlBQYsC6Nj+idTzfs9HKT9uWyidTm9uwFeeAsyzmVE80/p9mBzhvDqfii3+NoxC8fMx6tXPmkr9LK2wXVMhxvMcuapCxdezmBehzrapwhyby50wynmYkvPE=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by MWHPR12MB1711.namprd12.prod.outlook.com (2603:10b6:300:10a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Tue, 5 Jan
 2021 08:37:37 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::e) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend
 Transport; Tue, 5 Jan 2021 08:37:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3721.23 via Frontend Transport; Tue, 5 Jan 2021 08:37:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:34 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 5 Jan 2021
 02:37:34 -0600
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Tue, 5 Jan 2021 02:37:33 -0600
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Date: Tue, 5 Jan 2021 16:37:17 +0800
Message-ID: <20210105083717.468585-3-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105083717.468585-1-Emily.Deng@amd.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1741acc7-64de-4320-10f1-08d8b15526bf
X-MS-TrafficTypeDiagnostic: MWHPR12MB1711:
X-Microsoft-Antispam-PRVS: <MWHPR12MB171134F0937DAB577DD495198FD10@MWHPR12MB1711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AiqrmQ0/tomWf4XDICDrugif7GSyeXexDwWSEBtum2VTU0wm/J4V8qL5iOXZjZw9yST8Jaxc7sWAIJhDMm3zcKxK2j71q7f+K6ZWuvW8dInx3rSQ65n7GHwFnzSJAfEaQoP97yIi7QkPiMNpZmqwMDtHjyVg7HN9JO9tIjwZCZRcSiiRoJlmGfPv6Ee7NxQToR1Pfr/hnVM2y23GBOvafXNArsLXaQQbiXUXgCPdyJgFOWMM/Y9IW1KUkeSNgpwiSvfOGY7ugGORlT+ZiI587ws7ThmMzXp6XpzFW1VG8qez9cKGpBRyVF+LWAF+8ITcmL9JBf4tCukl5An/XzDWmlS9Wr61z+5niEnmBwWJNinQUmALDnTBDLd6XGFGrrH7AoqUW+zanmfM4SY0iOfB1IV8NC4OXxl49IU5JL1/AzapGRUONG53ge3pbXFU9kimrXxLPS1Eo28W9COBTPPRlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(46966006)(426003)(86362001)(336012)(70586007)(2616005)(6666004)(70206006)(82740400003)(47076005)(36756003)(6916009)(186003)(82310400003)(26005)(8936002)(81166007)(356005)(2906002)(5660300002)(8676002)(4326008)(316002)(1076003)(7696005)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 08:37:35.2887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1741acc7-64de-4320-10f1-08d8b15526bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1711
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
index 2b16c8faca34..c23d37b02fd7 100644
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
