Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CCCC55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D053E10F3F3;
	Fri, 31 Jul 2026 21:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rzhfgv1d";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FB010F3F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h90y/LkKpSyh7c/K91yuQSG8lY+n+V9eKxCogCTyCEMCA3UJs06XQiBR7LAh/euD/QfvIJmFy9v+IlN52OCjwXCH74hFp/k0rnpdit7YBFSBKPrqqD7ky4ktQKgGlSHMDmeiWGtM52sJihk/r+yKcYDaCEmuhlY4qH9v2rmnhXWJuW/mZhdtrtCOu8lO6I15zZutsmEORqgIC5aJOgfhH5RTO/69qZ0/kz1Ck+PTqUj2WiTQbd3vbMz2ElDag2UD6mr9g4PKS3O9d0ZZ8fHKX3LvQ0cuCvwLQ6Ev1jIp4L9CIeKy5+iSJIBiPhdLH/QSmoOa2p2Zj46dENMJyWQoOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fx7Mi/imHVpI7lMie0UkozaeXw7ribUd9NsoRnyjpyY=;
 b=wsZkJEwmSCnFBHB6Fnkw65xvGWEVVhOSBe1DA4JNmUppzSLeOdejsor10EdrVPgGGQ7OU9cNdLojZ5HQfFo9Pod32fUJeDz+u8viJCr61HzpIqAAA1AOaA/NWntZX0QeJ8REkiI4x0kUvEYqvL8JkC3xI9d4bvD2bKkmHM46zPbGsQxOwI0xETaLXJOd5qd79insNSv2lrtxI20aQdhIpBTYyCFhErZumdJSgN/QVLtbwzegu5dnxuJ79YbOa0a7BkKN+0a1lKmfB8OW6P7jUmaeH+eZO+nAMbpnwImqkRmo57F7fo2zJ/1r+fkZfR2gz46RjnIEWl1LOaRCEWjFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fx7Mi/imHVpI7lMie0UkozaeXw7ribUd9NsoRnyjpyY=;
 b=Rzhfgv1dLDDhtPUfMt5iQtCqCN/5c5wbe3BNdqQh1jnt2f1IQE6xnb3chZ1JRiM9wU1KIntRcR00DkALgrfWyJ95DAPZskcTMkAduHogb3vtHSZtxewx2wW0B2kj0VoktvLhaVAg4SJnZxAclaAurPzzFbOrexYBX+drYnf66QM=
Received: from BLAPR03CA0176.namprd03.prod.outlook.com (2603:10b6:208:32f::26)
 by MW4PR12MB7000.namprd12.prod.outlook.com (2603:10b6:303:208::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:40 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::80) by BLAPR03CA0176.outlook.office365.com
 (2603:10b6:208:32f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:39 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:38 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Harry VanZyllDeJong <hvanzyll@amd.com>, Anthony Koo
 <anthony.koo@amd.com>
Subject: [PATCH 10/41] drm/amd/display: Update VRR info packet to support
 12-bit refresh rates
Date: Fri, 31 Jul 2026 17:12:31 -0400
Message-ID: <20260731211302.3040343-11-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|MW4PR12MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 224516dc-7a2c-4132-b6f0-08deef48df47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|3023799007|11063799006|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: BUj4MP3P6HlKszxZKx0Ho3sch80OkLMhJ65HjOhV2IrOcLVTmflNlpbkPZp4b6i1LQ4q5+F7T1MDM2LTiUOufOyehaMEh6bJsx1B0whAsxnmsq2p7VeL/8FkhgAg8uqkSB7bgUdbfmJHLedtwV3gKGXQ4N2iUkbLA2tkXDBYa4anfu2tbSNl1cyhyFZtbnKAw6b9jdmdgp58kTHnfBR+kRKu0kuG9rfMFyS7PpY6e+7REWPspDeuKM+qKUCtkQbEysVN81Y9mTl5uRfUOs6VFV5jYlLBBh3g9HYazgxwzQAfEFcO7jjPhNQlmNUFyRKvrDGm5V7jqVXkvZoqS4xvi0lpQIOZB7Me7I38R2Ll+x6seWED7Pa2JNX8+wO4omjFmIR22i3wif+NlpC40VqlSLlD63U83946Z2maJJhfuJUk4f08CYWQ67OeHi62z/uuA7AxTcbUUGvXxlLDNKrPrrtbLnn4IG5rrxKKBdicgUQaoKTfhOr8l8iP7IXUTyQpTM5Iim0H35KTHgfYjapaSYkC5Mdxidu5vIANOfS+3ObC+d8401Epr+TR79a9cpV96TCKgBymmZo+LOYLsD6bkQPGGFV0z67knv4jIjDK8mPP9UXjo06SY55HBRoxufQlywqAPG8KqSKngSx+vMAv0G9w1EgYKhMusoJk85apv2io8erS43ChXQ2OY5kPsIv9E8IItChanucctfCaqM3QvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(3023799007)(11063799006)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LQndK616rnnvnWNeVHUvTXsDaQpgimI//R8U55Fr1Dj6NDStHtEx2ZoZxm1Ab1m394L3dQZ4QzIpx5zOFeiRFZCfjfytt5Gc0aDFwpeHoiEoJ89fu2jMY1pkDI6yGGIq/WT3Ehco97mwWnMlQpKwDr6Z2QNX72SIcEB3ucK3Uxu0jF8fZWRCKkwn6oKzvkxtjjQvyrbvKiKGAkRNG23PxUnSPiAtvABdYtjRYfa6MfTMiXwGtqXlGN35irta1uA8XZraXUIAUjKb2fFdl3z7G4w12+D27Rg9kBGhIwqElQE/cJHnXPwBTe6bpvgW86hITggKnuIryN0ERIipB73sgjCgpC9a2in65XR0IrrwbmZ7TOfzYOTzWZTFrFSYSYYQsJdMPGPBww7qA2y5MJfpREkqTQdFzP8oaFIccSLRaDMACWLCbJHvY+Azn+9ZssyI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:39.5456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224516dc-7a2c-4132-b6f0-08deef48df47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry VanZyllDeJong <hvanzyll@amd.com>

[Why]
VRR info packet previously only supported up to 10-bit refresh rate values
limiting the range of FreeSync minimum and maximum refresh rates that
could be encoded.

[How]
Expanded the bit masking in PB11/PB12 from 2 to 4 bits to capture bits
11:8 of the minimum and maximum FreeSync refresh rates, enabling the VRR
info packet to encode 12-bit refresh rate values.

Reviewed-by: Anthony Koo <anthony.koo@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index f3b41087678b..4bd060e30799 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -684,11 +684,11 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 	/* PB8 = FreeSync Maximum refresh rate (Hz) */
 	infopacket->sb[8] = max_refresh & 0xFF;
 
-	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 9:8 */
-	infopacket->sb[11] = (min_programmed >> 8) & 0x03;
+	/* PB11 : MSB FreeSync Minimum refresh rate [Hz] - bits 11:8 */
+	infopacket->sb[11] = (min_programmed >> 8) & 0x0F;
 
-	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 9:8 */
-	infopacket->sb[12] = (max_refresh >> 8) & 0x03;
+	/* PB12 : MSB FreeSync Maximum refresh rate [Hz] - bits 11:8 */
+	infopacket->sb[12] = (max_refresh >> 8) & 0x0F;
 
 	/* PB16 : Reserved bits 7:1, FixedRate bit 0 */
 	infopacket->sb[16] = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? 1 : 0;
-- 
2.34.1

