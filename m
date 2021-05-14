Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AE2C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDF461184
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 04:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDF461184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B466E21C;
	Fri, 14 May 2021 04:51:16 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4599F6E21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 04:51:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbXT3nqUgLMGKSGVESCU4vnbzFOeTT3AePzrHUOR9Lu0nOlWUeh+xOcAFWpQGYyI2JNsIGxxLhdpr+f389lWvKfsMo2kcVF2OgHL01RfV3VdEvnRM+ItCAxEo4Q9Aqr8gtL3HE+BscUECtVSiOD4iFMbcHbw3by9TN2xRdPVjz299FSv0iSqBU+BSeXhw/lJhj5bm8o3yFZXQst/dcGDoS57HHOhrsvqX4a84IKiAOlPmDgNaoPBSOZVkIcC9uV/wW8eJmOUKxnTckZXRj1i0D12638tnIJUy2tS8lFDGs/D+M7PXOdBkXNVvCHN8VRk/3irYVEckx9l50ALH9FhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ygPLE3bEJDTIKiu7R/6TPFFVisODTxqtOLYiAvEjMA=;
 b=OSv6gZB8OFtajUM71fJ75WT0ufHVqjqjIHNK3LUQPi9kkDRHsZBjP+eo81uEbDk405TSzitLy8iEBp59OslFAllM9yjK9iIuAtqh1iK7+JuQayeHzNnqtt5R6jrp7K39TO9MzuGcE3yXn64fJERv4STUIzP8rkrKrVy3y1xUJu3DIsv0XWnoWpQ3eDhhX6BtmCy77Sukf5KRRLRE4XXQJCTqT+udw0kfUqSi+lO1VPlhz7SwAikaNxFLn7aLIcWyMLZXLfgxxHDuRJPsEcrUbRdwzpkmUc3Cm8h9lu2Opnp/aZLj0Zw93sPnwF2SN3Tagcjf3ow/RPZic3+c5tS07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ygPLE3bEJDTIKiu7R/6TPFFVisODTxqtOLYiAvEjMA=;
 b=mmGkC1Fic3ld0K0R3fpl0AylBuwRaBBZo7x0GjivDPheXGmCj4SFSZk1MJQljgra4e24I9KPCSb63vm3h1dTof+FsLVALsSV6EZ6OiD9JW+rMhYJTBmfEFrUfngj54lvvXOay/TQnpnV4pvidUYCN1Tuj20QAbP4hSodxJ8O+Ak=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1226.namprd12.prod.outlook.com (2603:10b6:3:75::7) by
 DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Fri, 14 May 2021 04:51:13 +0000
Received: from DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23]) by DM5PR12MB1226.namprd12.prod.outlook.com
 ([fe80::16d:e05a:d9f2:8c23%9]) with mapi id 15.20.4108.035; Fri, 14 May 2021
 04:51:13 +0000
From: Stylon Wang <stylon.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/20] drm/amd/display: Refactor suspend/resume of Secure
 display
Date: Fri, 14 May 2021 12:49:56 +0800
Message-Id: <20210514045003.3069681-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514045003.3069681-1-stylon.wang@amd.com>
References: <20210514045003.3069681-1-stylon.wang@amd.com>
X-Originating-IP: [165.204.134.251]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To DM5PR12MB1226.namprd12.prod.outlook.com
 (2603:10b6:3:75::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from stylon-rog.amd.com (165.204.134.251) by
 HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Fri, 14 May 2021 04:51:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49f067a0-fa9c-4030-cd01-08d91693e69f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3129B556AC4204518B2E2FBBFF509@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KhQtE1wwdIzn294IoCjrwKQo8WNaO+2pZ+KkMWITLjRDZ2uE1Y8KGHPLcYf9tXqBFEsTsq2az9RAYTgSAcQGLBaEO5XIC4noYSBv7u+8ZtoSZ1eWXlLhhy/eqoXAq0tJ4MouYN/oneIbDYn3Evu1MRf8md8q82AYYhICJ1z8c6N/QOSNvjulsMLGexJRMiEubJZt84GgHGmEeKkGOyhqRNL3r/PqA8isIAXZLrWqHOHAbE9se6R4HboF4XsIuph8BGcFJbBcDKVAO92j5Miv3uofPyIPhbodYyij+AmmyjOya9Mwd+g397+lhaR0/1iXlGcu9Uw/zbT7fEVk5+GMFb4hfTdoOjNk5+3bulm1VbiYsSYbPpYnFXUfYou9YbUv8MT4C41ZcBhkg2UgEtEuMUaF0w0xaFM6VOadJP/O8LouzYAb5daKMcCBh/cx4ublticTTvou0DZvhPkORsLP9pgY/ObgD6Q1CUczx5MSGU6jww4NgNRVh9cA1QcNbVe3z+dxA3dmzRl4U1l8vd7h5Pev1KZK71uRrXQkteR7bgCCwJ8aERwUjyGnFtNm/JYaGtXLNJ8huKirgHzzNN3x3SP9UQ32oiYka9Tf9wtR6Amxft9o5vxlQyDF2wPpcG06QGTKM0mo7ySNl/pStsibLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(498600001)(83380400001)(26005)(956004)(86362001)(54906003)(7696005)(4326008)(38350700002)(2616005)(6916009)(1076003)(15650500001)(44832011)(38100700002)(186003)(66556008)(66476007)(66946007)(16526019)(6486002)(6666004)(8936002)(52116002)(5660300002)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BhQ+LbksfUAR0Yk38pBEMtiMEgSmSm9d1Hz3Lvos2nX2d7edk55BoSfnADOQ?=
 =?us-ascii?Q?uFRRsESYSbEcJCX/osPxSnH5ef7hDFvi1ecm5DeTchcDbhtxkST56Gs8tvB8?=
 =?us-ascii?Q?be4bvgEBk5v2EiDBCwNikz3y1frdIFetY1GaGAuS1cGDLwBDxaNi0xiUGWQv?=
 =?us-ascii?Q?l4MPqAE9XpS4qlfA6d0qRLguy5WuXVpMt7eB2GuZUHZLhMQE0DOYz0Iow5vg?=
 =?us-ascii?Q?AHDzajFNovOHZ3X2eP8zGgibBEW19DsLeZMTB2khncudPqP5JVpgzakzm4Cq?=
 =?us-ascii?Q?lb1pRApineKBp0eC6DgqWzhETzvB+O/A8Ov39o5Jaxep3/2vBVeF6sLYYOER?=
 =?us-ascii?Q?0vlVjZ7Q0qqjUdKC2R8ejgSxarSEXv8iaP0Yhpqy9lhBMVyZmWsCFquPS92y?=
 =?us-ascii?Q?iduZapHs14QQSPAIhmm6FdNN7DCCCKAOupN+hkJG/b5RnnlCr3oFMsxBqcg2?=
 =?us-ascii?Q?neAFy8tZiTpA6CJfJ8kOO5urHLSynvr/uc+ve0ZhfUcWA0JLuRG3t51Dh+jh?=
 =?us-ascii?Q?oDQP3q+TWutrBE+OArO1TgfX92IUZVBVMr+rFs8cpaUcpCHahDAEgHr6LmpR?=
 =?us-ascii?Q?0Izb/MLyG2euv46JSJecysMjPDRpQHDDmGbpX0Yon+ecqKWKDPhUxEGSKOAX?=
 =?us-ascii?Q?EP0l9DzcaQO6FGEmtfUe4/YcUBNfkozCUyGZ8KgvrrWtELv3wUFlDr29CJda?=
 =?us-ascii?Q?wwKq8tJ+bTkFibgvM72Te7onsPHlvIi9akIkuQknbGznPvAcsQffAk5tukGg?=
 =?us-ascii?Q?ocaXbo7hJZfPsVFoUQot7tJf8zsg08K4HaafmFFLGl3SlILVUPlDfrP6y782?=
 =?us-ascii?Q?tgZx0IjjSOcKpaDwu6dFrI/sNpsFHrkE3C2K5jY1+eqrH9K2lqHkUXgR/uY8?=
 =?us-ascii?Q?qqGO2LCJNzyCGSqINYlUqr1ZcQQyVlyRgqlPmMXZg8Y1Xzq963/iN2CqdZE2?=
 =?us-ascii?Q?xPJhdfc111il1AfVduFWQllBAAtNotoW+Ch/qelD+0ABi/1jI2RwRgMdfqjb?=
 =?us-ascii?Q?E7WrmVvBOMzRPDqwTWLD5gzfZcgHZVjT8HRpTiMPdG6xd/zZ6zbi87wDTGMB?=
 =?us-ascii?Q?MPxqYkluTmP4fsyep7PfCOqEQJz2rqcjdDbdLNSBj1ztXAUc2JC8qqpvJ/we?=
 =?us-ascii?Q?CW5onv8Bqg2gfUwXpqNe0a1kKS3NpzrXLqSydqlz6e0IhUV7lMgVX73IE3aM?=
 =?us-ascii?Q?4mPDPJb9bBZW/yunFjFG4e8gnwYssKmjY0QUDB5zBfKYLPLah4iDwb9vhBNN?=
 =?us-ascii?Q?AHmtKvjfYbVEhspWdaTHEgt8XVjoLwz358iYc5ulLaFnJgmZRya3sv5taUis?=
 =?us-ascii?Q?u4VHVsVvcFUBgXY2T2ZFeQqXQyIP6ZZGJy5fX2oaD37png=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f067a0-fa9c-4030-cd01-08d91693e69f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 04:51:13.7100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtU8u2CdE8nssxPwgALPUF6se7xIvBBMvzBL6HP7eiSO4PPzsyZAQIDyJKlfk2mzY/t6cGHZk34V48DxAKiscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Once set ROI and do suspend/resume, current flow will not enable
OTG_CRC_CTL again due to we'll defer crc configuration when stream
is enabled.

[How]
Remove current suspend/resume function and have logic implemented into
amdgpu_dm_atomic_commit_tail()

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 ++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 61 -------------------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  4 --
 3 files changed, 15 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ccd67003b120..0495d1ad6222 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1988,9 +1988,6 @@ static int dm_suspend(void *handle)
 		return ret;
 	}
 
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-	amdgpu_dm_crtc_secure_display_suspend(adev);
-#endif
 	WARN_ON(adev->dm.cached_state);
 	adev->dm.cached_state = drm_atomic_helper_suspend(adev_to_drm(adev));
 
@@ -2315,10 +2312,6 @@ static int dm_resume(void *handle)
 
 	dm->cached_state = NULL;
 
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-	amdgpu_dm_crtc_secure_display_resume(adev);
-#endif
-
 	amdgpu_dm_irq_resume_late(adev);
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
@@ -9090,6 +9083,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #ifdef CONFIG_DEBUG_FS
 		bool configure_crc = false;
 		enum amdgpu_dm_pipe_crc_source cur_crc_src;
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+		struct crc_rd_work *crc_rd_wrk = dm->crc_rd_wrk;
+#endif
+		spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+		cur_crc_src = acrtc->dm_irq_params.crc_src;
+		spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 #endif
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
@@ -9106,15 +9105,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			 * settings for the stream.
 			 */
 			dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
-			spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
-			cur_crc_src = acrtc->dm_irq_params.crc_src;
-			spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
 
 			if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
 				configure_crc = true;
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
-				if (amdgpu_dm_crc_window_is_activated(crtc))
-					configure_crc = false;
+				if (amdgpu_dm_crc_window_is_activated(crtc)) {
+					spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
+					acrtc->dm_irq_params.crc_window.update_win = true;
+					acrtc->dm_irq_params.crc_window.skip_frame_cnt = 2;
+					spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
+					crc_rd_wrk->crtc = crtc;
+					spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
+					spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
+				}
 #endif
 			}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 5cd788b20c21..7f36b2bbbeae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -525,67 +525,6 @@ void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc)
 	spin_unlock_irqrestore(&drm_dev->event_lock, flags1);
 }
 
-void amdgpu_dm_crtc_secure_display_resume(struct amdgpu_device *adev)
-{
-	struct drm_crtc *crtc;
-	enum amdgpu_dm_pipe_crc_source cur_crc_src;
-	struct crc_rd_work *crc_rd_wrk = adev->dm.crc_rd_wrk;
-	struct crc_window_parm cur_crc_window;
-	struct amdgpu_crtc *acrtc = NULL;
-
-	drm_for_each_crtc(crtc, &adev->ddev) {
-		acrtc = to_amdgpu_crtc(crtc);
-
-		spin_lock_irq(&adev_to_drm(adev)->event_lock);
-		cur_crc_src = acrtc->dm_irq_params.crc_src;
-		cur_crc_window = acrtc->dm_irq_params.crc_window;
-		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
-
-		if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
-			amdgpu_dm_crtc_set_crc_source(crtc,
-				pipe_crc_sources[cur_crc_src]);
-			spin_lock_irq(&adev_to_drm(adev)->event_lock);
-			acrtc->dm_irq_params.crc_window = cur_crc_window;
-			if (acrtc->dm_irq_params.crc_window.activated) {
-				acrtc->dm_irq_params.crc_window.update_win = true;
-				acrtc->dm_irq_params.crc_window.skip_frame_cnt = 1;
-				spin_lock_irq(&crc_rd_wrk->crc_rd_work_lock);
-				crc_rd_wrk->crtc = crtc;
-				spin_unlock_irq(&crc_rd_wrk->crc_rd_work_lock);
-			}
-			spin_unlock_irq(&adev_to_drm(adev)->event_lock);
-		}
-	}
-}
-
-void amdgpu_dm_crtc_secure_display_suspend(struct amdgpu_device *adev)
-{
-	struct drm_crtc *crtc;
-	struct crc_window_parm cur_crc_window;
-	enum amdgpu_dm_pipe_crc_source cur_crc_src;
-	struct amdgpu_crtc *acrtc = NULL;
-
-	drm_for_each_crtc(crtc, &adev->ddev) {
-		acrtc = to_amdgpu_crtc(crtc);
-
-		spin_lock_irq(&adev_to_drm(adev)->event_lock);
-		cur_crc_src = acrtc->dm_irq_params.crc_src;
-		cur_crc_window = acrtc->dm_irq_params.crc_window;
-		cur_crc_window.update_win = false;
-		spin_unlock_irq(&adev_to_drm(adev)->event_lock);
-
-		if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
-			amdgpu_dm_crtc_set_crc_source(crtc, NULL);
-			spin_lock_irq(&adev_to_drm(adev)->event_lock);
-			/* For resume to set back crc source*/
-			acrtc->dm_irq_params.crc_src = cur_crc_src;
-			acrtc->dm_irq_params.crc_window = cur_crc_window;
-			spin_unlock_irq(&adev_to_drm(adev)->event_lock);
-		}
-	}
-
-}
-
 struct crc_rd_work *amdgpu_dm_crtc_secure_display_create_work(void)
 {
 	struct crc_rd_work *crc_rd_wrk = NULL;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 737e701fb0f0..f07850db60a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -91,14 +91,10 @@ void amdgpu_dm_crtc_handle_crc_irq(struct drm_crtc *crtc);
 bool amdgpu_dm_crc_window_is_activated(struct drm_crtc *crtc);
 void amdgpu_dm_crtc_handle_crc_window_irq(struct drm_crtc *crtc);
 struct crc_rd_work *amdgpu_dm_crtc_secure_display_create_work(void);
-void amdgpu_dm_crtc_secure_display_resume(struct amdgpu_device *adev);
-void amdgpu_dm_crtc_secure_display_suspend(struct amdgpu_device *adev);
 #else
 #define amdgpu_dm_crc_window_is_activated(x)
 #define amdgpu_dm_crtc_handle_crc_window_irq(x)
 #define amdgpu_dm_crtc_secure_display_create_work()
-#define amdgpu_dm_crtc_secure_display_resume(x)
-#define amdgpu_dm_crtc_secure_display_suspend(x)
 #endif
 
 #endif /* AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
