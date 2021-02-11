Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB88C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A76464DA1
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A76464DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EF96EE75;
	Thu, 11 Feb 2021 21:45:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE0586EE6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXx/P1s6fH6uad3TCHsMxfHYtMq21Ehc0P9frCBlm9BZIsrcuGA5m5CZbAwS4iLGziU7vSBegsqLaTD1CsVMFUVN8t2cXHScetzOhPLENURIql3hR6JywggOLkRyOcZjJYCXt8xpGdp3R0QU/A5gJYrFAuGhVJvOktdPYM3Fu6IpHBOwGkZ3J5/1W98DLOCXuTLvC2jHVGS/peCCZmHQ40KgcRxGFKZ7DanBQcgYCLrGvy/py8V/WJgmAcGYFOHvv/NzIokSrsDZJ6N6zkLp9aD7u5XjezNxDmb0EnOnMq9Zmd9jRnLflAUVZpPvcTNZgW8p5+a5jBDTpvS0qKUb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S2vtZSvkqJFLF8rWxKx/KqPTphpI+SiYbKFU+JT2Lc=;
 b=b/GG4HuFOIF+HYvhnqeGolBSbwu3RJ/+p/Y7nnYipHwHRx7DX97x5XTIw14vV3+YawbU757gAp2XPIvXNUvlSGVwb11KC7hskOSfWm65A2aVxjdyF1kf9B1ewsKOpYQqJ1e8wyFLLVthTvDqyq/cUMtAx5oyXqxj402aznVBzoEDe1GxhTuteAESjJqMTMBGjmijHkn4do6w2C7Zt2CB1TwJ+Jmah2AbJOSejP/tKzmKjpaLlQVwJ0gBStpKdyKZys9n/u29B6vRK4xbLgK4VdpfrMbBo4GszaBXK+jj8HR5nipDUIJ4e06OxAz2h1r+jBcBHvfxBjdk1mnbM/BIJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S2vtZSvkqJFLF8rWxKx/KqPTphpI+SiYbKFU+JT2Lc=;
 b=FPozjkCjGmLxr00FmnAkD65/TORPe/wjPHeZwOu5lkzaYjghwIS3IAYxaPWcdyCYwDxBAVW61bSE9XDarbao3cxQz/Nl0K1AwJwDgloLIxjnHbC53V4Mbu8pZvJin5QvRfskWJWfUJJ3aojhMzoOhpmZM3HmC427PuLHZZWYB1I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:45:08 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:08 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amd/display: Add Freesync HDMI support to DM
Date: Thu, 11 Feb 2021 16:44:39 -0500
Message-Id: <20210211214444.8348-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3014a3bc-e6a4-41c5-4b95-08d8ced64c4c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42350F351BB2CE5B48A31C56FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +htKnfaydG4WevkB1DqG8y0gYLvSNgCBwHwiy4XKqOxcygmUpVl+y9pGX5xWah2VjllW2ppEO5pTFMFvz5lQUgIs/Ra5kF1uyO1LjoWmi/zXZG5+/59pURS7YQUX4KIKGRSw6n3NrQY1pyEzyzHRrSaapeZ/CAQ8clyJ83Jl4OYq9SVwiEbzvGSiGqXnBW1xAz7N9s4/Sho1zyjT4F7jQUukDd2+sZNJ1AjHKu58u1ZLnmJQNxRbjor1m+tudfBfMUZ/7N2i7HN+FQ+sPejbM5DqJfiPY0MmBwtjgM7SJybeu72I4QKQkARfNuaADKh+jNgnngHQCYzH26YxCSfQQPFrNWjf4LT2aP1uE9K+EzOKo/jwtKRH6Pl5XJyneHACY1xkGjvrYQAWu+XgfVY8Q55pI5zPI5AOfzK6kQzSua1NQbAnOgitAEbtCH/NilFAKU0sN+ETw64k9tZmFRrkCslcWxXIWmg1rFZYF9z2qLGkCgoHX++BH0d1Uy9tBRFIGSQpYUcKifMXFaUoPEkdijcgFQzBCzvuKa6/lEqvUZeaxCYK9aF4exGGiVCVYBt4tUBlrAEZRwu1tm8vwjPVZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YPHb/FbQd1/jY9n8yRPXKWAf5SnfDEB875xlwFcaBa4hjw+f2DLN4gJBdQGS?=
 =?us-ascii?Q?Amine25tWiBFNk+NeYNpt3dAv7IKvaJlqwTp0z3pKpi71y710evFsU6ihPsi?=
 =?us-ascii?Q?beZRle3YMb6RH0GfqcEgDGaDm+Y5/ktCf787eNFT4Y0FvUVmk47yV591K74y?=
 =?us-ascii?Q?oSdpXP2lYxu7v1AN58l8fvTYLK9osxODGH7rKhnmIa2c1potnT1xAVy89ASj?=
 =?us-ascii?Q?PWLiNWZ1eQoDkPtIFiNsBaKDCfG4DvXOxu/3clCOGYlgs6C8y6V/ghiSmWEf?=
 =?us-ascii?Q?6jifVpfV+b2GfdEnW7kNRpKjZL2oKSDSfUZsWBeH6KNk/eJp5Xidz4oobZ7/?=
 =?us-ascii?Q?rW9FYLd/Y37JCILJ6Myb0TPwiH7kiUjukl4ghfeaLKtAOeH7ntKjZ6L0azX2?=
 =?us-ascii?Q?9uiSJmzjGrYSf5Klv8vDtO9AkQvF+753zfTLC64SqUaPZ9wnfb8Y2pLaJDE5?=
 =?us-ascii?Q?fJ4XoLfs0U/MPtub9v1LTFUpEFESTma8QHiUZdJ8szIjuifiEUfYQY1C0S4z?=
 =?us-ascii?Q?sFBQK/N8ZbpCudlTsd/qF0pniLydH7BaLyighYmYt1aDO4JKg/Yi6LMupsg6?=
 =?us-ascii?Q?m9i+Qs4/pWYqoMMxVPhoLmcHSFsrYa3ZngNQ7YOVd7MGUz7Y/6uMOPYXn0cJ?=
 =?us-ascii?Q?3Mu7V2pc1iXg9qVaD2IdvUDgIm63TM4adI3O8a8mCOcJ8mC1QA+4rno9xgs2?=
 =?us-ascii?Q?RLaLMKMDMy8LKBxSf8rQsWjbHK3KAV7DeAqgA26i5fQfANBKNK28psbFRHlj?=
 =?us-ascii?Q?2nfIu/LSFccNQbYBZTS5M8s8Het1AfksK4N5KNA2AmHsCOlLdQLYThmQHmBa?=
 =?us-ascii?Q?yN+A7qcjJRakCQV5FTB2YTSVg1UscGSRbgxdX3wmWIcMHH4k8zWm0xjKlVLi?=
 =?us-ascii?Q?qvzoNwKJ0CcYnvuxIovdm3KPldFgq8fe0H97PaGHpqyQTE0oCjeKoNbzp4qo?=
 =?us-ascii?Q?H1tV/9EN0NSEj58g7t8KATWpOsHNUqNc9IYDMBhBcsN8JFxYE006z3t3i78B?=
 =?us-ascii?Q?qOkbXR5G1nuXvQAus3ZsBiEI8uqmNJ/MGpUkBkHSwTcMpeNPKH4SRKFOMUQt?=
 =?us-ascii?Q?SZiKBhW1WHeuzYc9sZPIyPSNWVR5jnuozYBHX8Q6OCOzWPTWNkrr9j4MGG83?=
 =?us-ascii?Q?RlFcbKGEreU+DtWeEw6TRAh7bYFc9ZSfjE4fNoGRMj+04xyBMiLXAEjOxufx?=
 =?us-ascii?Q?6/QS27gHzt7+69XKi/jJ04oPajAayXn3n5vFkHDgpd21f/zxJhN+t37vcruU?=
 =?us-ascii?Q?QrwFOUJQb1I7PW8/Yo3IrgclStuDF6gREPFEgFMSSyCbSwKYLcS0vQ91mRHb?=
 =?us-ascii?Q?2wIhMwJxYo3pvvnRCaazyXrQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3014a3bc-e6a4-41c5-4b95-08d8ced64c4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:07.3135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzGfZpgZOKqmtaTibjfx8k7hdj5D0PQErgJgjUJIaFuPCSwCEtEsQaTAUJpmkAyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Stylon Wang <stylon.wang@amd.com>

[Why]
Add necessary support for Freesync HDMI in Linux DM

[How]
- Support Freesync HDMI by calling DC interace
- Report Freesync capability to vrr_range debugfs from DRM
- Depends on coming DMCU/DMUB firmware to enable feature

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 175 ++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 2 files changed, 144 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 626a8cc92d65..c55ee0a24c26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -34,6 +34,7 @@
 #include "dc/inc/hw/dmcu.h"
 #include "dc/inc/hw/abm.h"
 #include "dc/dc_dmub_srv.h"
+#include "dc/dc_edid_parser.h"
 #include "amdgpu_dm_trace.h"
 
 #include "vid.h"
@@ -6995,6 +6996,12 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		 */
 		drm_mode_sort(&connector->probed_modes);
 		amdgpu_dm_get_native_mode(connector);
+
+		/* Freesync capabilities are reset by calling
+		 * drm_add_edid_modes() and need to be
+		 * restored here.
+		 */
+		amdgpu_dm_update_freesync_caps(connector, edid);
 	} else {
 		amdgpu_dm_connector->num_modes = 0;
 	}
@@ -9718,11 +9725,84 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
 
 	return capable;
 }
+
+static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
+		uint8_t *edid_ext, int len,
+		struct amdgpu_hdmi_vsdb_info *vsdb_info)
+{
+	int i;
+	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
+	struct dc *dc = adev->dm.dc;
+
+	/* send extension block to DMCU for parsing */
+	for (i = 0; i < len; i += 8) {
+		bool res;
+		int offset;
+
+		/* send 8 bytes a time */
+		if (!dc_edid_parser_send_cea(dc, i, len, &edid_ext[i], 8))
+			return false;
+
+		if (i+8 == len) {
+			/* EDID block sent completed, expect result */
+			int version, min_rate, max_rate;
+
+			res = dc_edid_parser_recv_amd_vsdb(dc, &version, &min_rate, &max_rate);
+			if (res) {
+				/* amd vsdb found */
+				vsdb_info->freesync_supported = 1;
+				vsdb_info->amd_vsdb_version = version;
+				vsdb_info->min_refresh_rate_hz = min_rate;
+				vsdb_info->max_refresh_rate_hz = max_rate;
+				return true;
+			}
+			/* not amd vsdb */
+			return false;
+		}
+
+		/* check for ack*/
+		res = dc_edid_parser_recv_cea_ack(dc, &offset);
+		if (!res)
+			return false;
+	}
+
+	return false;
+}
+
+static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
+		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
+{
+	uint8_t *edid_ext = NULL;
+	int i;
+	bool valid_vsdb_found = false;
+
+	/*----- drm_find_cea_extension() -----*/
+	/* No EDID or EDID extensions */
+	if (edid == NULL || edid->extensions == 0)
+		return false;
+
+	/* Find CEA extension */
+	for (i = 0; i < edid->extensions; i++) {
+		edid_ext = (uint8_t *)edid + EDID_LENGTH * (i + 1);
+		if (edid_ext[0] == CEA_EXT)
+			break;
+	}
+
+	if (i == edid->extensions)
+		return false;
+
+	/*----- cea_db_offsets() -----*/
+	if (edid_ext[0] != CEA_EXT)
+		return false;
+
+	valid_vsdb_found = parse_edid_cea(aconnector, edid_ext, EDID_LENGTH, vsdb_info);
+	return valid_vsdb_found;
+}
+
 void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 					struct edid *edid)
 {
 	int i;
-	bool edid_check_required;
 	struct detailed_timing *timing;
 	struct detailed_non_pixel *data;
 	struct detailed_data_monitor_range *range;
@@ -9733,6 +9813,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	bool freesync_capable = false;
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	bool hdmi_valid_vsdb_found = false;
 
 	if (!connector->state) {
 		DRM_ERROR("%s - Connector has no state", __func__);
@@ -9751,60 +9833,75 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 	dm_con_state = to_dm_connector_state(connector->state);
 
-	edid_check_required = false;
 	if (!amdgpu_dm_connector->dc_sink) {
 		DRM_ERROR("dc_sink NULL, could not add free_sync module.\n");
 		goto update;
 	}
 	if (!adev->dm.freesync_module)
 		goto update;
-	/*
-	 * if edid non zero restrict freesync only for dp and edp
-	 */
-	if (edid) {
-		if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
-			|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
+
+
+	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
+		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {
+		bool edid_check_required = false;
+
+		if (edid) {
 			edid_check_required = is_dp_capable_without_timing_msa(
 						adev->dm.dc,
 						amdgpu_dm_connector);
 		}
-	}
-	if (edid_check_required == true && (edid->version > 1 ||
-	   (edid->version == 1 && edid->revision > 1))) {
-		for (i = 0; i < 4; i++) {
 
-			timing	= &edid->detailed_timings[i];
-			data	= &timing->data.other_data;
-			range	= &data->data.range;
-			/*
-			 * Check if monitor has continuous frequency mode
-			 */
-			if (data->type != EDID_DETAIL_MONITOR_RANGE)
-				continue;
-			/*
-			 * Check for flag range limits only. If flag == 1 then
-			 * no additional timing information provided.
-			 * Default GTF, GTF Secondary curve and CVT are not
-			 * supported
-			 */
-			if (range->flags != 1)
-				continue;
+		if (edid_check_required == true && (edid->version > 1 ||
+		   (edid->version == 1 && edid->revision > 1))) {
+			for (i = 0; i < 4; i++) {
+
+				timing	= &edid->detailed_timings[i];
+				data	= &timing->data.other_data;
+				range	= &data->data.range;
+				/*
+				 * Check if monitor has continuous frequency mode
+				 */
+				if (data->type != EDID_DETAIL_MONITOR_RANGE)
+					continue;
+				/*
+				 * Check for flag range limits only. If flag == 1 then
+				 * no additional timing information provided.
+				 * Default GTF, GTF Secondary curve and CVT are not
+				 * supported
+				 */
+				if (range->flags != 1)
+					continue;
 
-			amdgpu_dm_connector->min_vfreq = range->min_vfreq;
-			amdgpu_dm_connector->max_vfreq = range->max_vfreq;
-			amdgpu_dm_connector->pixel_clock_mhz =
-				range->pixel_clock_mhz * 10;
+				amdgpu_dm_connector->min_vfreq = range->min_vfreq;
+				amdgpu_dm_connector->max_vfreq = range->max_vfreq;
+				amdgpu_dm_connector->pixel_clock_mhz =
+					range->pixel_clock_mhz * 10;
 
-			connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
-			connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
+				connector->display_info.monitor_range.min_vfreq = range->min_vfreq;
+				connector->display_info.monitor_range.max_vfreq = range->max_vfreq;
 
-			break;
-		}
+				break;
+			}
 
-		if (amdgpu_dm_connector->max_vfreq -
-		    amdgpu_dm_connector->min_vfreq > 10) {
+			if (amdgpu_dm_connector->max_vfreq -
+			    amdgpu_dm_connector->min_vfreq > 10) {
 
-			freesync_capable = true;
+				freesync_capable = true;
+			}
+		}
+	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		hdmi_valid_vsdb_found = parse_hdmi_amd_vsdb(amdgpu_dm_connector, edid, &vsdb_info);
+		if (hdmi_valid_vsdb_found && vsdb_info.freesync_supported) {
+			timing  = &edid->detailed_timings[i];
+			data    = &timing->data.other_data;
+
+			amdgpu_dm_connector->min_vfreq = vsdb_info.min_refresh_rate_hz;
+			amdgpu_dm_connector->max_vfreq = vsdb_info.max_refresh_rate_hz;
+			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
+				freesync_capable = true;
+
+			connector->display_info.monitor_range.min_vfreq = vsdb_info.min_refresh_rate_hz;
+			connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 38bc0f88b29c..5f9950fd216c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -475,6 +475,14 @@ struct dm_connector_state {
 	uint64_t pbn;
 };
 
+struct amdgpu_hdmi_vsdb_info {
+	unsigned int amd_vsdb_version;		/* VSDB version, should be used to determine which VSIF to send */
+	bool freesync_supported;		/* FreeSync Supported */
+	unsigned int min_refresh_rate_hz;	/* FreeSync Minimum Refresh Rate in Hz */
+	unsigned int max_refresh_rate_hz;	/* FreeSync Maximum Refresh Rate in Hz */
+};
+
+
 #define to_dm_connector_state(x)\
 	container_of((x), struct dm_connector_state, base)
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
