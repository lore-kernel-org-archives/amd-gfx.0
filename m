Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119A1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE95564DDF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 11:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE95564DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B81D89DFC;
	Mon, 15 Mar 2021 11:23:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7544189DFC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 11:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuUJxmiI5XjSW6DkqqukKWWhqf+yWoQXkXtsRYW1acWBjMRX4RYFxYUrqBqSFA2Q+TDUyOMttkrdQm8/a7gJl2JRo38H9Xj/QJF9q1Ffrg+BDLuZ6xzqv/1yc0M6c1CFlvAwhd1QwKp++jGbUCeFLg0Bsm9YPaaDh/MVN1zvps4NoTMbaFLaX6Woatd/FUGeyo4ZQIqUIfFFccayOJa1i0DV74k3fWCVVTKrC17RfwFzSYIC3R+YKypx20FvnrXTGbsUr61BBb2nXqdvxpAWgMq4xS+0QtOI6Xg6JNFRsO5sQVNSmaTT/9hwPYk6o1uKW9Ld9PtdiGqayxw6tmbETg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPn2lhGYKAQ8m604iFsl2cwF3oyxgZPmg6BnpB8WfX0=;
 b=SpUiDmTW9zx84mWR4KwWubENk0IeZmxD8G9SAZZvv0wUy2fHhQcWm1fEi1jikaBLM9C6G4elgVMdwASg0RC/xNVcaqlwyS8phJ6PWVruXZThqVisQOZlC73UflaMkKxXNpzCCdjjv5qzeafRQYt/kPVF1q74qDKU8PhVMTvHpxDUrNGxYdaY4s9Hygbhbs4BCgeT6T7MN0QwxHHix/p8tVwK/oV04QVpX4/d4Te0Ri+mgJj6AIQju2wuo0cJ58PiNIXBroLpU/aIVDv43alL9SRxlLCBKiUWXa/5wkC0Wm1IkaftkaH03Y/IGcqRqHj7O1MOzcAJhNyfD+xZ7bd+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPn2lhGYKAQ8m604iFsl2cwF3oyxgZPmg6BnpB8WfX0=;
 b=wecU/+bvEnQTnlGoAO/eqURm6z2EN/6JdbdDa1F2h7c2/VJejN7JtCumQUW2Xj0y72TIYyNTlHtkmcBSqKx0nw8jNM1c+Invy03ULfkkH6EYK6NQo44IwFVVS3CZjtRBJ9pikzAJGy5tQaJdsQp1nL0pZzQOKCMXiYdUHECEbLI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) by
 DM6PR12MB3740.namprd12.prod.outlook.com (2603:10b6:5:1c3::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 11:23:16 +0000
Received: from DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7]) by DM6PR12MB2604.namprd12.prod.outlook.com
 ([fe80::1c30:5644:fcfa:a1a7%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 11:23:16 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/23] drm/amd/display: Fix no previous prototype warning
Date: Mon, 15 Mar 2021 09:40:01 +0800
Message-Id: <20210315014010.16238-15-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210315014010.16238-1-solomon.chiu@amd.com>
References: <20210315014010.16238-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To DM6PR12MB2604.namprd12.prod.outlook.com
 (2603:10b6:5:4d::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.2 via Frontend Transport; Mon, 15 Mar 2021 11:23:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c36d1ec8-a533-4348-2532-08d8e7a4ba9b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB37402DEBCD979C143218A8BA976C9@DM6PR12MB3740.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:23;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2/BGGmkcuFfgSu4J1KyUT0rtkqGg11wYTXKWbgZILPpOHNXMWbPaH7xco5RJ2r4MlSQg8FWCwGur/CrEKzsL8bP6rT2bQMYMMtX3rmuivlcMbMP9o7AjOd0W81Rn9Yt5X0wVClaMj4QejjoWbqAQOUk8mdynVFXsdfItZm0ViuOYL+A63F/5Q5uugrnmQFy77HG7QRxyLujgBpyEtHeDfFXddULkQv5G7F9vfHcXYhvGNuRBl3Qm6IVc8DuQg0tI2KmVuLHICOkyAP8blVeUOC3PM24MwAEzp4NomwLsmMBviB3PQFEHLfDtdRkVhT+Rmo1y7HJPgSxuUxTyf/lkhp+aZZr/YV111IHw0PvSSSaaRen8hfDwHWOl6qPTBct5i/Q18arMhDxlASDa+/L6n5Y9yx3Q/G4ON9Jx9FFrOzKFlFth+qFM+DAYVEZPlSqVTo/CD5kkIgGNZEV40VpQg6Rf/C0dp75MqNqh5f33srFVUSGFgU/68hLqK2nWpYvZhptyCnKluF5MggBWbWqcvNJBqjV061CeL1c3XAfF/kPRCEVz2iIo036P/+ZTu18
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2604.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(186003)(6486002)(6512007)(36756003)(6506007)(86362001)(4326008)(66946007)(16526019)(6666004)(66476007)(66556008)(6916009)(26005)(8676002)(478600001)(956004)(5660300002)(54906003)(2906002)(316002)(83380400001)(44832011)(52116002)(1076003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QyQg7iRK/REdBsTFprtrQK0K55h+ZjVrE40IVpg4bqFlAHXOcxqIc45tKnlW?=
 =?us-ascii?Q?wiqH9sPmh680C2dmNUm087K4LYSzFuUvycN1IR3KdecZW/nlQ6PkiniMNEow?=
 =?us-ascii?Q?yoC9UwemzSKO+/Qbbt2KqVfCqaaxEhfwnR8f3Tg6YQsU0eF4kmCIwiu3iNV3?=
 =?us-ascii?Q?17sOC7FyaVML7Av0FUzSEZlJdMK+q3gwYMOovgWmSAqg1djbk4SzRqhdSwil?=
 =?us-ascii?Q?NiRV1SZxn6L6kM4lEULSxJDdDKgFuyz5REbTcwrc+Ns9NnJu8KyY2+2ta2b5?=
 =?us-ascii?Q?/ziXTA/FCb/hc0iQqRGlU3p+/4ylbPEQaIikjtnJteLOc40r3Aj5hOKtH10N?=
 =?us-ascii?Q?d6qdHMRqK35HDMagS3b/0HnqP8IHWksAp6Qz/gYa4vF5VyyMnHPEPJF7E/et?=
 =?us-ascii?Q?jQXbhxjnVQeZqozNRf6WYioIcXYYbmhW4+AyCbZGj8b81xbTIiiavFU90Fq7?=
 =?us-ascii?Q?izBBYaogeHqAxVnwt1MKOQvxpwQSKw/4wHA7GALJ9n7srMn9j8rY+UoXVjix?=
 =?us-ascii?Q?PxJPGJWS9tK5mokWOqGoo9byoY90pVt8iLj3pAvDuRHYwwZjD5OGOzhTcRVn?=
 =?us-ascii?Q?Bo3w3GEZr5Y2zz66HbwREq8cbhN8EOCfTVrX3kVwV6IeRZGW4kcWAZY4+1aD?=
 =?us-ascii?Q?vThZZyvXa8+wiJs5YqUapWVjFucNv6TyFk1ZP6jYeLQTPWfRqmta3B1Xedvw?=
 =?us-ascii?Q?akJdZspw+7wcStJ41J/zyI+gkQOvkFV+cq/YgHMPrueeF3k60srJjfxXEI1G?=
 =?us-ascii?Q?iMHIXw2aBv3TI4At69WzIw8/H5HR6PhulQhCNIutrA+CcuR5l8oYbIVhinFz?=
 =?us-ascii?Q?YPFAelNFj51+EMRHGQkkkufOD055FTKQNWJNWuv3usgZnxoHXadh9exqiIwF?=
 =?us-ascii?Q?CGTY24d9K9xbiU/b8iIWl/10D+te0V/Px3ZoG3UZOzWpnix9Kqd+TlY6Idko?=
 =?us-ascii?Q?NA9YiPTjrkvRqYypTnWBRHWuatwd9QE+cR6AbH5olimSufvHcrF7y702XROT?=
 =?us-ascii?Q?8Cnokz2OD5+08CAun6VAQMHbmGR0X77Xf3kxOcctTI/BOYZqgqkP9QF97+/n?=
 =?us-ascii?Q?9aBJOhUbXpguMxx+wMFnnijHfziSyHiGVpUOAUeSCrUa0Flbr401pQOzIMIK?=
 =?us-ascii?Q?iC7hVHOEEwqZrFAuIAYSpUps1IYs2My6GZy6T3mi2YDey+tIwBkyQES0pP60?=
 =?us-ascii?Q?bHD2d34kkOlylr9BdoNsDB0O8KeZ9eZL6UY12Ay1MEv8aBu50PZOjdiFV6xd?=
 =?us-ascii?Q?eG9Xd8YnZv93g5cfE3prlWz5/LJWENLWMSA/CStu7+7/GG8FcfxFIk1twNG+?=
 =?us-ascii?Q?nUTnO1htX3zyt6k8Gx6yhRQqVthrA04PZH+cUSy9n+zT3A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36d1ec8-a533-4348-2532-08d8e7a4ba9b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 11:23:16.7805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5sQNE3wXjlBIMLCVWv6XtOVoMVHN25a13WpQXSRON5ZrEaPD8p12wslnSmYrUWk4KIOzYFOtFTiNtSM/vb7Ytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3740
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
Cc: kernel test robot <lkp@intel.com>, Eryk.Brol@amd.com,
 Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Received compiling warning:

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5574:5:
warning: no previous prototype for 'amdgpu_dm_crtc_late_register'
[-Wmissing-prototypes]
    5574 | int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In
function 'dm_update_mst_vcpi_slots_for_dsc':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:6405:46:
warning: variable 'old_con_state' set but not used
[-Wunused-but-set-variable]
    6405 |  struct drm_connector_state *new_con_state, *old_con_state;
         |                                              ^~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In
function 'amdgpu_dm_commit_cursors':
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8006:44:
warning: variable 'new_plane_state' set but not used
[-Wunused-but-set-variable]
    8006 |  struct drm_plane_state *old_plane_state, *new_plane_state;
         |                                            ^~~~~~~~~~~~~~~

vim +/amdgpu_dm_crtc_late_register +5574
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

  5572
  5573  #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
> 5574  int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
  5575  {
  5576          crtc_debugfs_init(crtc);
  5577
  5578          return 0;
  5579  }
  5580  #endif
  5581

[How]
Fix it with declaration as "static"

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df060c354eb8..3db69f5bd6e9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5562,7 +5562,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 }
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
+static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
 {
 	crtc_debugfs_init(crtc);
 
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
