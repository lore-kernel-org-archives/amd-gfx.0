Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE1DC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A432067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cc+fWKh7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A432067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 964606EC2C;
	Fri, 21 Aug 2020 22:58:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415D96EC26
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaGXp+TdR9hnKxeIwT7DqqgIEhtaSAkmyv82O+jtlbrWjo/VyCakEH1a1Bmz6bpgxYABtWrKP2zGzETMh88D1Kgm3Vs/GI28up0CouSEJ+d4vQJx9/9gWCQ5oOxHisF7LP+G+2m8rNXdn8auBCvQST0fDfD3GKUdiM8+ldP+tkUddIOhDyXLZy4I8lhea3BpfUiGLkVERyJDqL/+tbL7BJidtUFuZrESFQRsfLViA/6Jc6ZtDCjk/yimzyNpuza7nJtshl6fImLbp6TzQKlu6yXlOVCRuxSXymTLYB9XR2uZP5xcbwx5WtAcFIaZ8WP9leGN4A4E5H058vN7ePfqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7I4+olVGEl6PewjBuVIt1fWQ6pgECir+8Kan6DHvjs=;
 b=INJ5vfJmC2ene0kENbt2wTgBXHrPZk1y+vINgbX2NRhvWJHX7VqIHDPNr7ERkJe2HXgySYd0gInrfr5VkBs8zgvkibQeBxlv8SD4djGlab0AD6Ql1bv7LaMAbYhP+NHrIahVbeqaGGm3QqY5XoFio9yz+Se3ySFPRNXWFCsylySv6AZ/NtGtPBtmvnu3FvJF7rqbOUx7WpfrqjyvrOXwcoQorIu4TubIHg73bTCuInW7wJKDb2qDYkwx3AouVcx+VUfz55+hGB4t0YEEBVt+K5LDdkt1Nu3Iifgn9aAWSGBhu7O5gogJ1Dvk6d0gU+qth9fMvdb9jSb4PV/cWYcI2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7I4+olVGEl6PewjBuVIt1fWQ6pgECir+8Kan6DHvjs=;
 b=Cc+fWKh7xmxckmp94/daXlJdyuxcn1mEgeaD0ibHlEtcs2FhsdIe5ZZleJk0UUDUG6unjaeI7b4d9ZsgTv9vWEzOCV8XI4wAAHZ0uXuspYTZ37jXxQXn6VuWco15LXLXrCL3xctY02wxWf7PNCzaGN+N45CVQj4vl8a/jkLsyQA=
Received: from DM5PR07CA0048.namprd07.prod.outlook.com (2603:10b6:3:16::34) by
 DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 22:58:46 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::87) by DM5PR07CA0048.outlook.office365.com
 (2603:10b6:3:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:46 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:45 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:58:40 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amd/display: Keep current gain when ABM disable
 immediately
Date: Fri, 21 Aug 2020 18:57:09 -0400
Message-ID: <20200821225709.136571-10-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8d9293d-721f-4941-ca65-08d84625c2bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4138B5E8F97EEF2F7A7D7ABBE55B0@DM6PR12MB4138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km8yS15xxAfwXNJF5efw3JZqpdHms0INrbCDQ4pcM2sgSEFcZ+arqfi8fiaYePw4VwzXy8zlOvH2kavj14zUpNnpz1MmPVZbD48YlGvxZjLByVvYc9R0nCViYYGq6oxYTQN2pANta6+WbD7WmbfDuYL6rfhAvreUgH1HfEj9c6QCNB43AqpvoO53KFmA4bBsvGT7WutRGXYGK80E9d26EmLmV6JNjyWEY6H0m6Jc/TwTqXjUZKI6soYUffTRFVfWDE2gwLMpEUxez4K/zvgMVVJ626ImHXTXJ1g1HEPB65w/FxCcmHScvEYLALjVm0LKYOZeo61uvPS70aocmzCGdnROlMrycypb0KHuStpmU8Wc7j15DwaY9qg76s1r+A5VB92Z4KcwqHPauZaGsrhe1IcTutlEEimyqWvK/QRHa0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966005)(82310400002)(44832011)(316002)(336012)(26005)(186003)(70586007)(426003)(70206006)(82740400003)(36756003)(47076004)(4326008)(86362001)(478600001)(5660300002)(83380400001)(4744005)(6916009)(1076003)(2906002)(6666004)(356005)(2616005)(8676002)(54906003)(8936002)(81166007)(14773001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:46.7037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d9293d-721f-4941-ca65-08d84625c2bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
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
Cc: Josip Pavic <Josip.Pavic@amd.com>, Eryk
 Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Brandon Syu <Brandon.Syu@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brandon Syu <Brandon.Syu@amd.com>

[Why]
When system enters s3/s0i3, backlight PWM would set user level.

[How]
ABM disable function add keep current gain to avoid it.

Signed-off-by: Brandon Syu <Brandon.Syu@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 37743073772b..c246af7c584b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -233,7 +233,7 @@ struct dc_stream_state {
 	union stream_update_flags update_flags;
 };
 
-#define ABM_LEVEL_IMMEDIATE_DISABLE 0xFFFFFFFF
+#define ABM_LEVEL_IMMEDIATE_DISABLE 255
 
 struct dc_stream_update {
 	struct dc_stream_state *stream;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
