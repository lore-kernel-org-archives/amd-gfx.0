Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56238C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 23:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216906192F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 23:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216906192F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59926F4FE;
	Fri, 26 Mar 2021 23:14:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0879E6F4FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 23:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3LjDcDVBvulnpLkZ0kAJ5RZ/Z+Dp43AOrI9sx/6G549f8sHCOKPdZlrBwcLunOF8fskygulqx/m0jpKGPz2+6jhutSdhkX5TgBvk61yBOasETuYxOf4Aa0fVQSd7QtFOf44tRQsb8dWYsUPTGm0ToZyTl9X0ozaUmN33SqCMWo5B7ptkps1yAelPIO6DAHPLBix9w7esPEVQOkawtTj+cS+S0JAYrZZ5+L7a/Kh7sqCU5jDFqmwyhHhSJEaTuaVk9tCMz/Qs8LGjzj6OYHjsAZpdTIzM2mprNenaZtp8wKPIIoGDwVMqhbGGgcluNvOeC5dzkzKB3ZVVohFz3VOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXL2O8x3T0TEs72LILZlTZKUhQiQ3YuPn3x/Y2zCDyI=;
 b=G9cNFTR4T2P2OBVr0mIEP3zIc9fx/fcwOHUAGiUOJ/e8RQXtNmxhWw1A6XAcsMLNOPLmW6UsxHQ0G+n98bSPaUG6dL3b8ObZqyB6VWPX6NZTIHffm+W0BTNocjdd2KkdUzppy/xBINBTtvBQ3eV26/bbSX/Fi7n2x+fKiv5g9/1SXkdivmSpvs+B8BhpzbEyKUrEZPDvpAaegcHCJ9JO4t719Bn6CtUZsriOVGpOnEfdyQc47cl7adTPmpdO7/DzQDYsgXJoifpz0J/VFQeB58cApcWPPpxKwd0AKOACcEvOYbPhPPbJii6iVzV3qWFwFCORGz940A7JcpiqIcsI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXL2O8x3T0TEs72LILZlTZKUhQiQ3YuPn3x/Y2zCDyI=;
 b=OuuaYLgV6MGayv74TEy8DpDO5lR3aBXbxa9cy3pNF1C+vwfBAEAAvbxWoBG4O4YR7FbTvz2kWNiFZbPmPjoj0JeYRuGC+FX81MB3CyolczCx2dYSYBkfil0YE69SHQeHnhvZEhK+Q9okBn1cC5uFHVN32+IalC09RhB40ZP9TuA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4676.namprd12.prod.outlook.com (2603:10b6:207:19::30)
 by BL0PR12MB2404.namprd12.prod.outlook.com (2603:10b6:207:4c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Fri, 26 Mar
 2021 23:14:35 +0000
Received: from BL0PR12MB4676.namprd12.prod.outlook.com
 ([fe80::50c7:783f:720a:239c]) by BL0PR12MB4676.namprd12.prod.outlook.com
 ([fe80::50c7:783f:720a:239c%5]) with mapi id 15.20.3977.029; Fri, 26 Mar 2021
 23:14:34 +0000
From: Nikola Cornij <nikola.cornij@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix black screen with scaled modes on some
 eDP panels
Date: Fri, 26 Mar 2021 19:13:52 -0400
Message-Id: <20210326231352.17827-1-nikola.cornij@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::41) To BL0PR12MB4676.namprd12.prod.outlook.com
 (2603:10b6:207:19::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ubuntu.localdomain (165.204.55.250) by
 YTBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24 via Frontend Transport; Fri, 26 Mar 2021 23:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de07e1f4-7d1a-467a-7989-08d8f0aceaa2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB240463756A7FAF8968A5881CEE619@BL0PR12MB2404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSWsjrdn1TB+awgD8pQbrzBipN4n6mMRdEeye0QPHxqaG91/Um1fpUwQsXVSbw5bH/zsMSRifhfp9diTo4/XP9fkfJbNCY/t4ORmOxS0RMigNNNCYCRVYyMYT7irN01VSsqZw40f8OtbMh7X0RkqVzueLsVsNxloNz98BLs7IxAy0kiRNG+gQ76Qx46CdGiOaKlEUmmRFlyKtH+teK5m92+rJT3S7Mz8zSqWS/SI1OaTJi9AE+Q545y4vuuc1CHtFYBLJSwUdVgIzDQb8sUkArbgng7v+AopDeNgGk1k0P3qlOteX6DfjuBoUEilfLRB2FFOCoZpzkxsRTqvfmSzs+39FDPzAhBCY6z7/nbDY/PVQaaF30P3pJQStgMisHDx69vBqCsAyjCjSwnbhc7w06VjnNJLgmCcC+wiMPSWGQQAhfBAwWZDL4qL7VwQ1qBMR4WGq/pUm+6ZH1zC9JM+RPivHJ031QPyTzSUS9qUmddaEW2PqFlNgOiye+pPxfBy7NgAcmbu3h/rL5NsynGiX/g2Tqau2Bpc2ib16/0nu3HZxou7/ELIO6Jz7toQTcJcMOLObGDIM6MCGF707eSKIkLsHN41XYg7/pcczukvCgmsoH/A4/2ZE0+9R2bgnxkdQY4KNF5EGMY+vzl2I7MwFhuBQJXbj4zAyclhRIFHs+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4676.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(478600001)(1076003)(66476007)(66556008)(956004)(83380400001)(6512007)(66946007)(2616005)(86362001)(6666004)(4326008)(316002)(52116002)(8676002)(8936002)(6506007)(186003)(36756003)(5660300002)(6916009)(44832011)(2906002)(6486002)(26005)(16526019)(38100700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?f3GoloXG3JAupbQaU0KKLB40edqMqIHIAiAifgCftp9UsO28IqxZ4ZTiofcA?=
 =?us-ascii?Q?/B9Edzn7KWdrFEfY+n/iyHnrRz7ngrjNdPKpyu0eyNjEPd8crZVlKfXT3VhH?=
 =?us-ascii?Q?DAEfwaCAEL/J2Xdfj5kD9i42iNHWS0w/IjTLz9raOARQtbBtplx0jCIxFxRN?=
 =?us-ascii?Q?PXcFWZ2L8nx7fGofrgw80zqeA++sIR9Pzbj/uQp5E+KqwYPDu2VZQX0Wv/pG?=
 =?us-ascii?Q?R0VZCFxMTYzxTgm+n9rzd26ipjyqwD8TOanqhEAIZ1tW4P6H73zcq9ZnG5vB?=
 =?us-ascii?Q?Nfg3akTjsl9jhPczs0UQW7Nh4aZAsyrUB+ZX+zAyBgKNozyDcIbRSAdIR75e?=
 =?us-ascii?Q?/6DGtGNne0ccZnfKG1O2YX660jKayQQx4UNyl9g6abuMZmfjuPc6Xi3LF4hz?=
 =?us-ascii?Q?BMFY9aNgZiWuFzpCw/Au7YBSaxhsCawCYwyTpy191dnT6FDyAyY8dzRQqCbB?=
 =?us-ascii?Q?XYaAurDLO5aPfCzAgUqJclS3/ShPjdWQqB2e+/lr8MUnzT3fVcPwtB+YUcgC?=
 =?us-ascii?Q?tiwn06ggZoKzvvx1XvDLJyEiHt0uP1NnWDgvyJPSx4W04nabZGVaBb6A7dpu?=
 =?us-ascii?Q?sSgIGsLbkU+nW23kfw1WLFqeotNr+No84l9yxUWBVMJ3K1UH8LSntbni/Q7H?=
 =?us-ascii?Q?i4u0KPuwLie4dU5gy6rNhyrXFw6+pCs2VZeTcskZhf2uOk2XDKaBhyJIZ/OU?=
 =?us-ascii?Q?dxaNSgagBYouN6CbxOCQL6dk4xg/PPcfncM/W3oIOMPM/YrxZCp4C3ZcXE/E?=
 =?us-ascii?Q?9tR6Wck8HVbVBjtManwtj61sUNPeUwBVTLKvnF8Sw9RsURQ8Oz3zQvXGO0tl?=
 =?us-ascii?Q?BfttnqWDT88OZ/7wYCk6I6mJ5Jp7hr8tzxT660fcwl7JPugoX5v30kh70Yrh?=
 =?us-ascii?Q?yK3nGEE/Gn+ZaXkpNWYlkTY/QymqquhizsdZQLbcYK5a1ewK3dADnTk8qXED?=
 =?us-ascii?Q?S9RfI0c8eBxc2dsLtHq10vHBJHV5TxN9gmjiJ8Kkm/nnROSx38HfdgfkjDJV?=
 =?us-ascii?Q?BlaxFo2yZy8rFAxOaC8e2Zo0hGSY81QD0HfsGry0xHhIZ8cUeoaQSy+49QGu?=
 =?us-ascii?Q?lykueo954jGnpP17HMM48akXsyhsPHl95EZZurQsW1cYe00RWjIBfWqlYVVf?=
 =?us-ascii?Q?kE6OLNKn/XbJxgktZjfFI7mbtcPeg2sR+DhLI3EGvOA1NH2OXCZ+MaoPknc9?=
 =?us-ascii?Q?5LUnuddNfHraQwirjE61QMLXE2gKO+HxznqHlh9RcE7RW9QjjsAL5yJctNwh?=
 =?us-ascii?Q?mwjYBoHq9o+7q8fcLPhat6fylPDkX9XSEr616taadyXXw9xYGPjJYugwsQIn?=
 =?us-ascii?Q?ti6gomX4JT0xdh0W7UQmLslC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de07e1f4-7d1a-467a-7989-08d8f0aceaa2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 23:14:33.8730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: axXTf+gpUWZZz1GW2hy0qEFEvGNMz9doU4coTAXeWSILOOhbIbIsgUJ/FP/meCCmaOjc0nySXOKnB9GpPQT20Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2404
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
Cc: aurabindo.pillai@amd.com, nicholas.kazlauskas@amd.com,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
This was a regression introduced by commit

c1218dbe223f - 'drm/amd/display: Skip modeset for front porch change'

Due to the change how timing parameters were set, scaled modes would
cause a black screen on some eDP panels. Would probably apply to
other displays (i.e. even non-eDP) that only have scaled modes,
but such case is not that usual for external displays.

[how]
Pick up crtc frame dimensions when programming the timing unless
it's FreeSync video mode.

Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 39 ++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4c02373a707a..ad31591070c9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -130,6 +130,7 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 /* basic init/fini API */
 static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
+static bool is_freesync_video_mode(const struct drm_display_mode *mode, struct amdgpu_dm_connector *aconnector);
 
 static enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
@@ -5239,15 +5240,27 @@ static void fill_stream_properties_from_drm_display_mode(
 		timing_out->hdmi_vic = hv_frame.vic;
 	}
 
-	timing_out->h_addressable = mode_in->hdisplay;
-	timing_out->h_total = mode_in->htotal;
-	timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
-	timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
-	timing_out->v_total = mode_in->vtotal;
-	timing_out->v_addressable = mode_in->vdisplay;
-	timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
-	timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
-	timing_out->pix_clk_100hz = mode_in->clock * 10;
+	if (is_freesync_video_mode(mode_in, aconnector)) {
+		timing_out->h_addressable = mode_in->hdisplay;
+		timing_out->h_total = mode_in->htotal;
+		timing_out->h_sync_width = mode_in->hsync_end - mode_in->hsync_start;
+		timing_out->h_front_porch = mode_in->hsync_start - mode_in->hdisplay;
+		timing_out->v_total = mode_in->vtotal;
+		timing_out->v_addressable = mode_in->vdisplay;
+		timing_out->v_front_porch = mode_in->vsync_start - mode_in->vdisplay;
+		timing_out->v_sync_width = mode_in->vsync_end - mode_in->vsync_start;
+		timing_out->pix_clk_100hz = mode_in->clock * 10;
+	} else {
+		timing_out->h_addressable = mode_in->crtc_hdisplay;
+		timing_out->h_total = mode_in->crtc_htotal;
+		timing_out->h_sync_width = mode_in->crtc_hsync_end - mode_in->crtc_hsync_start;
+		timing_out->h_front_porch = mode_in->crtc_hsync_start - mode_in->crtc_hdisplay;
+		timing_out->v_total = mode_in->crtc_vtotal;
+		timing_out->v_addressable = mode_in->crtc_vdisplay;
+		timing_out->v_front_porch = mode_in->crtc_vsync_start - mode_in->crtc_vdisplay;
+		timing_out->v_sync_width = mode_in->crtc_vsync_end - mode_in->crtc_vsync_start;
+		timing_out->pix_clk_100hz = mode_in->crtc_clock * 10;
+	}
 
 	timing_out->aspect_ratio = get_aspect_ratio(mode_in);
 
@@ -5468,7 +5481,7 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 	return m_pref;
 }
 
-static bool is_freesync_video_mode(struct drm_display_mode *mode,
+static bool is_freesync_video_mode(const struct drm_display_mode *mode,
 				   struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_display_mode *high_mode;
@@ -5591,7 +5604,7 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 
 	if (recalculate_timing)
 		drm_mode_set_crtcinfo(&saved_mode, 0);
-	else
+	else if (!dm_state)
 		drm_mode_set_crtcinfo(&mode, 0);
 
        /*
@@ -7436,7 +7449,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 
 	if (!(amdgpu_freesync_vid_mode && edid))
 		return;
-	
+
 	if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
 		amdgpu_dm_connector->num_modes +=
 			add_fs_modes(amdgpu_dm_connector);
@@ -8771,7 +8784,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #endif
 		mutex_unlock(&dm->dc_lock);
 	}
-			   
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
