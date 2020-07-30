Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06393C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD47B206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YpooDOfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47B206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95A386E955;
	Thu, 30 Jul 2020 19:12:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1916E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmCI0cClKJJN+YN6ozzVtShBCma3EIHNA0VoUG7k7Y5PBg/fZXWsbzM6jpvXv0gpqh7Vzr++956yEBAvL1IzRuecQQwxzwrCTnW95Se98rt5NoFIdcEg5Sl373o3Y88FamYd2MW96Ef/qONsOMOwaMRDdyXskszbaxtZVx0DBm+cwra3mMe8e/Rz0SG1I4epj/VNbOSvW+CMgp5EFTM1pgiRaFCbnMAmoyUmQ2Lpm+x/Fs/UTzE7kh2nhm3GHcFTkU4yL2HWcEFfhJji3YBP9rivlJzyLuKylU8IedGMXqW4t0wzak7KhW14/zCwC5sxEHF1PP5o91CK43Gyc+Lt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZixWhTz4zv/Hc4SjaJuu7znBBHWXKOjUkU7mSmuQyXk=;
 b=G/8SOrXbcOO4xbhCjfhNuet1y7ma24pHFQk7PVNAG0kKQwlGrbqcUQfZDwGOV/mdc9VP7wrRO/DFq/9rPBH4BNsb/WL9VBIBpDEMLDGoreW9CmrqhH0M3Gel/R7D1o3AiRhdHoTMp/GHnlX0bBgOdix7yljBTjRF8cLzK94TwBAgZTZo9M7uYjKVW1lzYJEl7Bx2TdAcPBWa4JdfHeqRrwdU5VT061h+FhTr300lObTQVx+p2rTaa8TxyW9MslUOmeBUKwS3x99t5+Ujil19fS0PUn4NZjmhpXyBcF9vkl4aJEgi267Ew9jmrJlNSJpe4B7L6X/xNtRz6yxdpBTBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZixWhTz4zv/Hc4SjaJuu7znBBHWXKOjUkU7mSmuQyXk=;
 b=YpooDOfhmllGm77HgNixEVBd6X4GYe5S4vfTRNFZCjUsGDHaMDnPW2hIPpeIpWaiiGwwTIXpH2NKQHmtTG5P0AGqtnLU04TGkXc+dh4bVJBdb40ugSNiE2HhiI/nYLwerz5PLGzuJ2vTMjbFB1qrPm4EAE6Kk02c0PJWjAQYq7w=
Received: from DM3PR12CA0056.namprd12.prod.outlook.com (2603:10b6:0:56::24) by
 SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Thu, 30 Jul 2020 19:12:01 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::c8) by DM3PR12CA0056.outlook.office365.com
 (2603:10b6:0:56::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 19:12:01 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:59 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:11:59 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:11:58 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Update virtual stream encoder
Date: Thu, 30 Jul 2020 15:11:32 -0400
Message-ID: <20200730191146.33112-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb4b397-34be-4cce-8c3c-08d834bc7021
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25747EA72F7F88C22699D7028B710@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYdDilNODcUfZ7b6J/mvbGrK73GgyXpT1V7a1ZcsUW7xINk/nBOOe5PPBmjd06An6n0KEgf/OBRbAUaYy02dm0vKu8zvwILXGOg+vT765zJM3ReminJ7IKzxlG5rvMpXIUbHdNSR0le0CbMcqhFQKGjcbxZ8JOeHSn96IJ22gJ04rZ97pqb1AYtYObIZOEabkM5mkYV0+4X4uTjas5RNeYY6uU0ev7OjJFhhkrKjwOQq63jpMjyc5Zvmba5NZbZn60EDbW4HACQRKnWZ1M/LbvDUJDV7geu43iLmFSVXHdS+mYgvvZIaNwNxR6H0le6uauUaxVpkUeeE6jr0VTr/mX+T9rknOW632+hdV5TkOxMjsJvd4X/W6mIBq6VR6N0Yw2wPVT3zOS3QK43oKhknnA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966005)(1076003)(6916009)(478600001)(36756003)(2906002)(54906003)(6666004)(70206006)(316002)(5660300002)(2616005)(47076004)(44832011)(82310400002)(4326008)(82740400003)(426003)(86362001)(356005)(186003)(7696005)(70586007)(26005)(8676002)(336012)(8936002)(81166007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:01.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb4b397-34be-4cce-8c3c-08d834bc7021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/virtual/virtual_stream_encoder.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index b8040da94b9d..944c0327763c 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -87,6 +87,17 @@ static void virtual_enc_dp_set_odm_combine(
 	bool odm_combine)
 {}
 
+static void virtual_dig_connect_to_otg(
+		struct stream_encoder *enc,
+		int tg_inst)
+{}
+
+static void virtual_setup_stereo_sync(
+			struct stream_encoder *enc,
+			int tg_inst,
+			bool enable)
+{}
+
 static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 	.dp_set_odm_combine =
 		virtual_enc_dp_set_odm_combine,
@@ -114,6 +125,8 @@ static const struct stream_encoder_funcs virtual_str_enc_funcs = {
 	.audio_mute_control = virtual_audio_mute_control,
 	.set_avmute = virtual_stream_encoder_set_avmute,
 	.hdmi_reset_stream_attribute = virtual_stream_encoder_reset_hdmi_stream_attribute,
+	.dig_connect_to_otg = virtual_dig_connect_to_otg,
+	.setup_stereo_sync = virtual_setup_stereo_sync,
 };
 
 bool virtual_stream_encoder_construct(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
