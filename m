Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB31C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C6D60FBF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08C6D60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E2C36E99C;
	Fri, 12 Nov 2021 00:55:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE906E99C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBsrBR3WG2Lg5kGg9kndSq6IIo5M4puXqUXIyZ7BjxIRj480QScqkVlj/vvn3DZ55sibKdY2pboUAXROZ98U5Z3pTF9ZqaaS2kQeUQMbosrHgxmi9Ylbga73gqbe8WUvHGTinmt/T8zTGR0+2W53Eg7OaKAeZVgGl2SrfJlM6kn13y4DiGBJowAkq9I6K57E/LO4JPjqBAoq1O4EYHmCuDyDhkT2P1LOi/OotAg0Yo4inWhBaJf8bCY8Jd9l/gN2Yyf6P4Xi7xGKXHb/VPg7jfNHuFn9zPVvrLDII6JF9v+HGDRIOYohpDyGIRbr83SVxrrB3adK9pUuJI4iCGJ8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nA8Z0VQHUdlUn2C4Jh9A4CzEuRXW/qOa9/aGcuxfVk=;
 b=a1ttDBc2jULZ44iY0K2fmAOKCceHyMQIROwwet4XoNsnSqD60v6zIOYOUKlo/OrhVJpnBCDtmKkp3lTw19PbAI2HkYF9hOcWQfub4Ot47dc4lYysSDOgQx4boBKehtB/XJFFzWuJauDO3w2Utbh4GYKEQwQQt/k/YSvR9Kk/MPDnt34CFPIZbnyGw+UkCj6qVtrGF8tOcpgCbnD8ML0qeAtU5sRJIlwDl1AyN8hrxqv9kYuUNvl3BMefYuyUOBIH6Ulo+ovdit66bz/Eoc6YqvtF9UFvBP19uP48ly9rbzLrgabe221xcmPW2nvnB5vOB0LfsfQCd6PIt3mpAsTyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nA8Z0VQHUdlUn2C4Jh9A4CzEuRXW/qOa9/aGcuxfVk=;
 b=q67lDMlGf5RwwNO8cbhh/oO2DtGZsggaHV5DnlbBJWqYnIK5XlYI7OQ8+kv4NraUMN5Bhp9uEScAzDyNNxoszJDKcocqGziE/AM3EnY2ojJDCqyhQIe5f7o4Vj350hozIXjj6Oyt86xIKH0yf2qKl3oC7zESWhqBoP96sIMVLR4=
Received: from BN6PR16CA0047.namprd16.prod.outlook.com (2603:10b6:405:14::33)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 00:55:04 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::53) by BN6PR16CA0047.outlook.office365.com
 (2603:10b6:405:14::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:04 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:01 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:54:57 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Only flush delta from last command
 execution
Date: Fri, 12 Nov 2021 08:54:26 +0800
Message-ID: <20211112005438.5505-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8cc211f-3447-4d37-049b-08d9a5771078
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:
X-Microsoft-Antispam-PRVS: <BN8PR12MB28509C2CA3E44848D3359A1FFC959@BN8PR12MB2850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lagMkWrH5KmcmrDfqTv/RBm1jDRloLcfOFPFyyu8YDDxTzi5M44+Mr7MFMzd6Z+Pez0k3/DV88UxAfdl1zITN8/HuPs5mIBlwogKLlEcYlA86o32x1unNRdXMdJ7GalNcbDU33wqu8vvQ2P4iAW2VTCc9Oj7Pb6pu37X6ofUjAlXARKJ7x6/cAY82x+bBj5odrAOsRbxrYVjpBaCpS2f1ENg7usbKhnNlv51lo+nRSuLvv8efabqRUPkDs2yyAC2w9se267fQrj2O7RNxHbnsqbofwdWDMKM63zu0mTfOtPHn4yPq5KQJ+MhI+7rjzBGzfmSYfoa4aUBIWiepiYXyYeGLfq0jA06WEaW+p+cA9MyBLmj4TiyEf+niynjutl0TNI4U665mp52P/uIXSjjn+z1mxhcWUF2O1/P3/jkIPWAoUhOoSdFJFyxtljds35/XunLqUp3dkR2T9TN8H4SfzmYIERRUoteF7xH6amwSRJQkIkkmTPzn0DJ47T4M7IHLOYvIjQkRb8PUXaHCdcieXF5a+G6VkSAIme5xXvwnR0IjXog/o0+49UBGuD1rUVe6qELU+YogsdIiJaxTYZlyIkfSqmpw6uVtY+1aHK4WjqWkH6xfko4Oy3U4fKJeKhSKqXGLFO0rs2nviFXIDSV4eJl1BmH+DGLKkVJmu0Y+WX8yhFx/TWENz7a90GWndlwEIfvESdsJfyzTDlY31jiUTeORtJA/LKM94nxCddDklk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(7696005)(4326008)(2906002)(54906003)(82310400003)(356005)(508600001)(1076003)(81166007)(426003)(8936002)(2616005)(47076005)(316002)(86362001)(8676002)(83380400001)(70586007)(26005)(6666004)(36860700001)(186003)(336012)(36756003)(6916009)(5660300002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:04.5018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cc211f-3447-4d37-049b-08d9a5771078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
We're currently flushing commands that had been previously been
flushed or are currently being processed by the DMCUB when we don't
immediately wait for idle after command execution.

[How]
Avoiding reflushing the data by keeping track of the last wptr.

We'll treat this as the actual rptr by creating a copy of the inbox
and modifying the copy's rptr.

Reviewed-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h     | 1 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 90065a09e76a..83855b8a32e9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -411,6 +411,7 @@ struct dmub_srv {
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
 	struct dmub_rb inbox1_rb;
+	uint32_t inbox1_last_wptr;
 	/**
 	 * outbox1_rb is accessed without locks (dal & dc)
 	 * and to be used only in dmub_srv_stat_get_notification()
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 56a03328e8e6..6cc897dacd92 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -609,6 +609,8 @@ enum dmub_status dmub_srv_cmd_queue(struct dmub_srv *dmub,
 
 enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 {
+	struct dmub_rb flush_rb;
+
 	if (!dmub->hw_init)
 		return DMUB_STATUS_INVALID;
 
@@ -617,9 +619,14 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 	 * been flushed to framebuffer memory. Otherwise DMCUB might
 	 * read back stale, fully invalid or partially invalid data.
 	 */
-	dmub_rb_flush_pending(&dmub->inbox1_rb);
+	flush_rb = dmub->inbox1_rb;
+	flush_rb.rptr = dmub->inbox1_last_wptr;
+	dmub_rb_flush_pending(&flush_rb);
 
 		dmub->hw_funcs.set_inbox1_wptr(dmub, dmub->inbox1_rb.wrpt);
+
+	dmub->inbox1_last_wptr = dmub->inbox1_rb.wrpt;
+
 	return DMUB_STATUS_OK;
 }
 
-- 
2.25.1

