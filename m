Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102C9C07E9B
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2101610F7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 13:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2101610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5E589CF1;
	Mon, 19 Jul 2021 13:57:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9176889CF1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 13:57:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShLz0bI7TFFN7s3g3CPjUWMuEOcd0Ce5F0702yPhcNjLITW2FXh2zxRYzmDZPHl6VSzeM/HvpWEaT5EbGzdEyXiyu8VDQee7S9U1R2RnxAspT+lZprhGkzYzdzbjY9Xbd7U6PQT15uSsn7oIIWS+EQSyNFylnUBVGDfI7qew3ehu8pB7OYjHvGgJWwiBu5+KDcrQD20DXZPGS3U1wjiBzEKbpF/NMHejqtfRgSiT6Za57+5vIn28bp2DuSTd8PG3zd4dSbsTbyyOMUa0gY/aN6eyqnnaA2HcFbm8kYasKm8VHnTgTFyiuUPI7jV7E23bPNh/LszCeFkmqhz22fx7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBMB0L7rDH9STbrFs5SIG2pZl/7xteMaKDiIXqhaFns=;
 b=innfSP8KyNh7BZ8g+p69PgN10xvSi/NpAL3MFDPd+pBbPHM40cRyWZ/xboJ+SkRGfvL8k0E6Xzz1gZQTVAC7DfqyvD5v706iJjaK3JG6sFpyww/7xYHUa/z250q/vo/IvGZueSLm0MLHyIhtgu8SYbnHfmCv2BzFxVRYITJL72AYc5twAhN6fELz1OnDkriqSt/EYHJmRA3P0uGCwgzVfQ92x0RLS/dPPKytDHI27+IqUco9kkzg/8xkZxqbwC8mUqLiWQWS/VyUjhyhHasDm/Zf2eydWMTiVx9Oled9OzUM5MM2cgvxl05Llp5kkWRPG8tSbmC+raH5oK9iGh2bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBMB0L7rDH9STbrFs5SIG2pZl/7xteMaKDiIXqhaFns=;
 b=raIAqew9jowvY13VElNJtZA4Am5LYz3/T2/EYvvs9cQmBbMr09en79ecqn4JYUER+eVG5anBxJkj9maKhf2hOnCADL0aKvQZRVZynMMsEYHBEUPAuCCki0XBBbhRDKBumPcBsA6Y+7Ltun+ZIrvs1hkXUXM4QwVH1g7J+zeHfVI=
Received: from BN6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:405:70::22)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 13:57:28 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::77) by BN6PR12CA0036.outlook.office365.com
 (2603:10b6:405:70::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 13:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 13:57:28 +0000
Received: from X570-RTG.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 19 Jul
 2021 08:57:25 -0500
From: <veerabadhran.gopalakrishnan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu - Corrected the video codecs array name for
 yellow carp
Date: Mon, 19 Jul 2021 19:26:34 +0530
Message-ID: <20210719135634.119561-1-veerabadhran.gopalakrishnan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e1ea04e-61f2-4d4f-1255-08d94abd257f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4465:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44658B18D897AAD1E7545DE0FAE19@DM6PR12MB4465.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iElPZDkrJvPe2Z+Yh7H7QD0jK3HNjr+Ke0UjbM+pezq3+68ZwwN0Okk0NFZfJ/tViAiHe3YSLVHedFx+NEYjJmAYWcX6OanaxDcG2NUTWV+QCeQUlTnDwO6Wq2xokwv7CfWBPwG+Nt94fpc9C0aDwJzSkMKB0yqHoZnvom8M5YuuaVK6L7DXJRiQzM+0RtHViLCPMyFJfPM42TAna8eus/3f5dke1h53r9VB4IGBLXaokaZvoxrP4xxIN6ArrfeN/HEX1yE98AhevUzsRc3ahmFeno/zywQ8kySwcTRZkcSmv+lMoQn8OK3jt/TJChP+cvqwZ83mKO2NBHEUIcwExfu4gsluFGPxyoF3B3OnYU7qJSUjrPcTKIbVUBTBgyw4BHh1LJA+tsDkYk4JboNoaCt9keF0kr477uVvfgbi5pJKBjdm6B2D+uCoOmgcBvNJh4FAyeagtkHHJ/zlSLuwxl4/CYURxLd/lKQyAIbufMtEMeZQXN/RvxyLpwfTq2BMFK0k10CWOrVMi4qzgXCY7gzaGVBQeRFymNvrw8pax+Y6dL1javp9PPs9Qm1NV9di6/LtRRX/7qv/YBKiabDP4Ob0XD//MPX+NiYrDojuKLrfDe2u2H8v15WaNY5ZScLkTYADyykdr9pohKXIG+M5t7VJCi85wMv+SKDGYyAge8Y/8k/NaSqVU8o4DaZ+HN3hgQJUw2kBWJfmhSWxRH9Y24ye1fhfP1FCe/YqxmsPxt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(7696005)(186003)(16526019)(86362001)(426003)(8676002)(5660300002)(6916009)(26005)(70586007)(336012)(70206006)(82740400003)(356005)(47076005)(81166007)(8936002)(4326008)(36860700001)(2906002)(4744005)(316002)(82310400003)(1076003)(2876002)(54906003)(83380400001)(6666004)(36756003)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 13:57:28.7465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1ea04e-61f2-4d4f-1255-08d94abd257f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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
Cc: guchun.chen@amd.com,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>,
 Boyuan.Zhang@amd.com, james.zhu@amd.com, leo.liu@amd.com, srinath.rao@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>

Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index cf73a6923..751c7b8b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -173,8 +173,8 @@ static const struct amdgpu_video_codec_info yc_video_codecs_decode_array[] = {
 };
 
 static const struct amdgpu_video_codecs yc_video_codecs_decode = {
-	.codec_count = ARRAY_SIZE(bg_video_codecs_decode_array),
-	.codec_array = bg_video_codecs_decode_array,
+	.codec_count = ARRAY_SIZE(yc_video_codecs_decode_array),
+	.codec_array = yc_video_codecs_decode_array,
 };
 
 static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
