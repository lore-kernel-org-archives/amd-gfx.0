Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0712C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AA96518A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 04:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AA96518A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91276E44E;
	Tue,  9 Mar 2021 04:10:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6A1B6E44E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 04:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBzKhRFkxobVS67SxYQbs9esct/qbWSvkxYBJofoIomSjQPMT2ls6uYb86c9Oq1fuJAz9YZ1cqSlJ4Y/KHJq0PhSeh/nFoTyo1XWnvEBao95l+VXgGHvl7x3hVJCZ8Tge2DGHcUWCRR0jQIV8haP9BO74Z6CNe2ec1YzNn9act1X/9L3YPNxNMgB32THKkbvwY9d86y7vehNZpYuBlkn2C2TKsAM/LngTfVjy6otkibCobPPIvC5e1K/gR83DS8r4YtUb9aITDrKfXAx25FBeJQokNw9L11VdNjvXaeh3Rog3mYsUzi3N6k6WbFiGS7TV9zTgaR/W6MZAhp3o4i+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOUTEG1JbHogKgFcXopjDm1Qvf7+H0nUlAU+fVrxjWs=;
 b=BHBCa/lETulfmWbwPwX7ssdkMrPKSZ/YY8H7WLIIawuiJ9mSMZYKmNR9kbmhTRhMuNos86eabM/am0TXBD53wBkvXXJDVhesFpr8qQNBYCBq781nUnYdw452vRRhtI0RfSwS6O+O7fHug8Woj9li+3Q/RzI0nmBvOGRXd3tn3Xzx4zcIoFXrwmAu3VhrONzoxwcgx4D3Osx6mMqedIGmkv2D+U4DZJLGaM4r0CqxIgfltzIMtOD5sFIzVWybO1DuTEXN4zUCNnyxzeg5IG2EuAFMgoME02XyLRZuHOW1AWJ9NTcY+jNWThCzxqlRjYhlvgHJHWDusv9r06bqb3wLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOUTEG1JbHogKgFcXopjDm1Qvf7+H0nUlAU+fVrxjWs=;
 b=JMUN1CtybxzdpW+zrhFSQo+oRKyFfurmXdpZ/KKn8B9ayx1iVbUiOI2au92C74vLmOHbu6Bt/WNNnKUSOSGsy6jzp7ev2pNf6WxiGdyCw8elTJoFRutf82nRI7+FTedOzkHdI6GD4n6tjgkhZUV81uLbzH90oxlIDRwM8X2eOFA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Tue, 9 Mar
 2021 04:10:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 04:10:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: clean up non-DC suspend/resume handling
Date: Mon,  8 Mar 2021 23:10:12 -0500
Message-Id: <20210309041012.23367-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309041012.23367-1-alexander.deucher@amd.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Tue, 9 Mar 2021 04:10:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79ad0b1f-ea14-420f-1064-08d8e2b14a05
X-MS-TrafficTypeDiagnostic: MN2PR12MB4486:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4486E00CD44968C3A9B99C1BF7929@MN2PR12MB4486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WoIt/bJ3h43nFnUZMaF3K2kGG7Gy/sV5369WSnX8SYkb4GmU/p2IUwgx2Ddkm2e5V4Ycmz4Wy7cASWqr7gY1BTi/0Xk2lVPh+W4Tm3TWYc6LZE9JjRac9HSCRTWt6JuMjb3emZiKxItHcl9RcoxeH38HA63XpW7kuWKx/Wp4ZGUGqMYrs4BfLlLT4fYGMj2bTU3/2B81f1YC22TynQKFkKgxAfM69iTjcjLD8ojJHZWPJkiU8tyHPDxIuCQV2TLpjvWcKBK88UqvcPIqldP4cUNmOafZ0cctTdXUHv/MdiCXaTfmo052fcoFUu8rDcc9dNVC2C1Pxx6Vx3qw8euUJzeUgqM9kR0KhUpl2ciki1nWsOUH2PokEfp/kE8LyQjyHMCt32EH2Ux+3Stuen9cQaA8daRP+r0bO/7KY3/i/sENixudWA2BWCXpI7wmmE9CS0uz3Yz6LuTq1VvJYCV9chdratjTHjQUupWZNmoOkBoHVb0sSQymPsKX6Kw04B9A63pEwzlxk3TY7lX0VL2LXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(478600001)(316002)(66476007)(5660300002)(16526019)(6916009)(8936002)(26005)(83380400001)(2616005)(15650500001)(8676002)(186003)(36756003)(66556008)(66946007)(956004)(86362001)(2906002)(4326008)(6486002)(1076003)(6666004)(30864003)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FX+wG6uQYkLG3/p6SgkBo8UmbvchF/2yRPubWW0RSz9i6b5i/AagQ2ZANu0e?=
 =?us-ascii?Q?IFVU4Y3k8Dkcidy+imbG4WLyaGeME0deeIulLIK7MjIEpviSy9YS2Z7fQhXf?=
 =?us-ascii?Q?NBjA+gsvah8eA3EPiYyWIf+8fAZeSzIIG1l7kUsOIbA1sjfLhTH42eBTQzMo?=
 =?us-ascii?Q?8FFwlu2CVS+BSmUtWOhF1rDfjF+DIuBwcwNFviw4nIOZMdJheMPu0x6Z+9dV?=
 =?us-ascii?Q?jMuWFnerfZDnmJn38MPVLhWqH9ombNKiLWGjhT8Q/yDgc6CZJlRaIw13qWKh?=
 =?us-ascii?Q?uhY+E6kr7CWPT/NFXuMJpobExIcZ3xaj4dSMvFLkidW45oo1f6X74t9P6w2T?=
 =?us-ascii?Q?js+rbEi1t9W9O6lNu5ypwVSxjKCnonPvbSW3KBvl6PP4PCFiv4lcSdZMlN45?=
 =?us-ascii?Q?L6h+sTXiUtWoN62XyP6HtapIDY+idkHwKEIwwXPAGsZDUdQVQ2FGMLYH07os?=
 =?us-ascii?Q?fXZZjlT1Yi2RmQOCY42XJbEcVjTpWajTxj6u8D3670mLASkggJlIDdcsWkdW?=
 =?us-ascii?Q?DdUXW/hDKE2+mk0+JpVCW6+ARtzG9ziXNxkBdYd+oqJ4j7CblrgBXXo34RS2?=
 =?us-ascii?Q?qU0RARfx2VeqfuC0wIxTS7d6QT1iBEeifqd4bQS6cjkjExjj4jPdGYIceCRe?=
 =?us-ascii?Q?D5Jdb4jtZ9lv2b1JmhtasLpknAzGbCuDICsIs/152WylKKWZATffxEQqi+OS?=
 =?us-ascii?Q?B6RFpobAAVKTfdUdyxETtxE60KFcTA3ba0zViZ9/idBrwPOmnBxaOB5qux+8?=
 =?us-ascii?Q?DSNtf2/FStPv8Yd+IFkzcp9d+x/o5DiV0d5tze4gF2dB/c+sawRBkah6LT3S?=
 =?us-ascii?Q?5TkWOPR3zI5moDl+sxuE4bX71qhxj4lmobjjwpQSH6I00UWH/0vcu+q0f8EY?=
 =?us-ascii?Q?jLmw7a3CwSB6c8iczLF1I6dd1H7xXDmCQo00fEtPW9t480RX0ZUHljN3AcHr?=
 =?us-ascii?Q?OomsdWFAZPS3bSLXqxuj25AHAKEpSYDLzvtFEtOY63cilkpb5Wc6xxGvp133?=
 =?us-ascii?Q?55sXgE/uwMb1zZI2R/EcDIhjBzcy/WfVRn8NaQ8a+tNV8DXvlCtPp2VEs9MO?=
 =?us-ascii?Q?s1qq8A/ilru666z9tzEpWJvRcpe1hScqJ2Z4l8aA9ZI8GUUQ1GltVvkQ+tvw?=
 =?us-ascii?Q?EvmyGG5fdzYf4KLTfIC2r8BHkkS5BxEGawyMCaUYRuxlOkwoG6zn2sNum8qg?=
 =?us-ascii?Q?O6povWNRXQFHgrLhPlkV1ADkitneheFk8M2CgVFhk1MRpgADRazHeeLgyd7Y?=
 =?us-ascii?Q?7XRZxlmWiHSNgkBBqjbIDhHhG2xdB9hcjOkMvrvETrmW28E2wcvBFdyIpDRF?=
 =?us-ascii?Q?L6SF+PuitQO6PqnO4QsNRLem?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ad0b1f-ea14-420f-1064-08d8e2b14a05
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 04:10:35.4518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loB9q2jIerSaobcoHj14hPVbALBndiWvZfafIfzpIR/E3EItJL9fpZ1Bu6ICL3tnP97Qtwytr1HZWk7erZDISg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the non-DC specific code into the DCE IP blocks similar
to how we handle DC.  This cleans up the common suspend
and resume pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 82 +------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 88 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  3 +
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  9 ++-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c    | 15 +++-
 8 files changed, 137 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b6e483259f1..c4ccf7a313f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3674,9 +3674,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_crtc *crtc;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	int r;
 	bool s0ix_suspend = amdgpu_acpi_is_s0ix_supported(adev) &&
 		(adev->pmops_state == AMDGPU_PMOPS_SUSPEND);
@@ -3692,45 +3689,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
-	if (!amdgpu_device_has_dc_support(adev)) {
-		/* turn off display hw */
-		drm_modeset_lock_all(dev);
-		drm_connector_list_iter_begin(dev, &iter);
-		drm_for_each_connector_iter(connector, &iter)
-			drm_helper_connector_dpms(connector,
-						  DRM_MODE_DPMS_OFF);
-		drm_connector_list_iter_end(&iter);
-		drm_modeset_unlock_all(dev);
-			/* unpin the front buffers and cursors */
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-			struct drm_framebuffer *fb = crtc->primary->fb;
-			struct amdgpu_bo *robj;
-
-			if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
-				struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
-				r = amdgpu_bo_reserve(aobj, true);
-				if (r == 0) {
-					amdgpu_bo_unpin(aobj);
-					amdgpu_bo_unreserve(aobj);
-				}
-			}
-
-			if (fb == NULL || fb->obj[0] == NULL) {
-				continue;
-			}
-			robj = gem_to_amdgpu_bo(fb->obj[0]);
-			/* don't unpin kernel fb objects */
-			if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
-				r = amdgpu_bo_reserve(robj, true);
-				if (r == 0) {
-					amdgpu_bo_unpin(robj);
-					amdgpu_bo_unreserve(robj);
-				}
-			}
-		}
-	}
-
 	amdgpu_ras_suspend(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
@@ -3767,10 +3725,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
  */
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 {
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_crtc *crtc;
 	int r = 0;
 	bool s0ix_resume = amdgpu_acpi_is_s0ix_supported(adev) &&
 		(adev->pmops_state == AMDGPU_PMOPS_RESUME);
@@ -3803,24 +3758,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	queue_delayed_work(system_wq, &adev->delayed_init_work,
 			   msecs_to_jiffies(AMDGPU_RESUME_MS));
 
-	if (!amdgpu_device_has_dc_support(adev)) {
-		/* pin cursors */
-		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
-			struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-
-			if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
-				struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
-				r = amdgpu_bo_reserve(aobj, true);
-				if (r == 0) {
-					r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
-					if (r != 0)
-						dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
-					amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
-					amdgpu_bo_unreserve(aobj);
-				}
-			}
-		}
-	}
 	r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 	if (r)
 		return r;
@@ -3828,25 +3765,8 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
-	/* blat the mode back in */
-	if (fbcon) {
-		if (!amdgpu_device_has_dc_support(adev)) {
-			/* pre DCE11 */
-			drm_helper_resume_force_mode(dev);
-
-			/* turn on display hw */
-			drm_modeset_lock_all(dev);
-
-			drm_connector_list_iter_begin(dev, &iter);
-			drm_for_each_connector_iter(connector, &iter)
-				drm_helper_connector_dpms(connector,
-							  DRM_MODE_DPMS_ON);
-			drm_connector_list_iter_end(&iter);
-
-			drm_modeset_unlock_all(dev);
-		}
+	if (fbcon)
 		amdgpu_fbdev_set_suspend(adev, 0);
-	}
 
 	drm_kms_helper_poll_enable(dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 48cb33e5b382..c3797bf3c583 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1310,3 +1310,91 @@ bool amdgpu_crtc_get_scanout_position(struct drm_crtc *crtc,
 	return amdgpu_display_get_crtc_scanoutpos(dev, pipe, 0, vpos, hpos,
 						  stime, etime, mode);
 }
+
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_crtc *crtc;
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	int r;
+
+	/* turn off display hw */
+	drm_modeset_lock_all(dev);
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_helper_connector_dpms(connector,
+					  DRM_MODE_DPMS_OFF);
+	drm_connector_list_iter_end(&iter);
+	drm_modeset_unlock_all(dev);
+	/* unpin the front buffers and cursors */
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+		struct drm_framebuffer *fb = crtc->primary->fb;
+		struct amdgpu_bo *robj;
+
+		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
+			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+			r = amdgpu_bo_reserve(aobj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(aobj);
+				amdgpu_bo_unreserve(aobj);
+			}
+		}
+
+		if (fb == NULL || fb->obj[0] == NULL) {
+			continue;
+		}
+		robj = gem_to_amdgpu_bo(fb->obj[0]);
+		/* don't unpin kernel fb objects */
+		if (!amdgpu_fbdev_robj_is_fb(adev, robj)) {
+			r = amdgpu_bo_reserve(robj, true);
+			if (r == 0) {
+				amdgpu_bo_unpin(robj);
+				amdgpu_bo_unreserve(robj);
+			}
+		}
+	}
+	return r;
+}
+
+int amdgpu_display_resume_helper(struct amdgpu_device *adev)
+{
+	struct drm_device *dev = adev_to_drm(adev);
+	struct drm_connector *connector;
+	struct drm_connector_list_iter iter;
+	struct drm_crtc *crtc;
+	int r;
+
+	/* pin cursors */
+	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
+		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+		if (amdgpu_crtc->cursor_bo && !adev->enable_virtual_display) {
+			struct amdgpu_bo *aobj = gem_to_amdgpu_bo(amdgpu_crtc->cursor_bo);
+			r = amdgpu_bo_reserve(aobj, true);
+			if (r == 0) {
+				r = amdgpu_bo_pin(aobj, AMDGPU_GEM_DOMAIN_VRAM);
+				if (r != 0)
+					dev_err(adev->dev, "Failed to pin cursor BO (%d)\n", r);
+				amdgpu_crtc->cursor_addr = amdgpu_bo_gpu_offset(aobj);
+				amdgpu_bo_unreserve(aobj);
+			}
+		}
+	}
+
+	drm_helper_resume_force_mode(dev);
+
+	/* turn on display hw */
+	drm_modeset_lock_all(dev);
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_helper_connector_dpms(connector,
+					  DRM_MODE_DPMS_ON);
+	drm_connector_list_iter_end(&iter);
+
+	drm_modeset_unlock_all(dev);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index dc7b7d116549..7b6d83e2b13c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -47,4 +47,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,
 const struct drm_format_info *
 amdgpu_lookup_format_info(u32 format, uint64_t modifier);
 
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev);
+int amdgpu_display_resume_helper(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 7944781e1086..19abb740a169 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2897,6 +2897,11 @@ static int dce_v10_0_hw_fini(void *handle)
 static int dce_v10_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -2921,8 +2926,10 @@ static int dce_v10_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v10_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 1b6ff0470011..320ec35bfd37 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3027,6 +3027,11 @@ static int dce_v11_0_hw_fini(void *handle)
 static int dce_v11_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -3051,8 +3056,10 @@ static int dce_v11_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v11_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 83a88385b762..13322000ebd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2770,7 +2770,11 @@ static int dce_v6_0_hw_fini(void *handle)
 static int dce_v6_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
 
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
 
@@ -2794,8 +2798,10 @@ static int dce_v6_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v6_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 224b30214427..04ebf02e5b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2796,6 +2796,11 @@ static int dce_v8_0_hw_fini(void *handle)
 static int dce_v8_0_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 
 	adev->mode_info.bl_level =
 		amdgpu_atombios_encoder_get_backlight_level_from_reg(adev);
@@ -2820,8 +2825,10 @@ static int dce_v8_0_resume(void *handle)
 		amdgpu_display_backlight_set_level(adev, adev->mode_info.bl_encoder,
 						    bl_level);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_v8_0_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
index 9810af712cc0..5c11144da051 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
@@ -39,6 +39,7 @@
 #include "dce_v11_0.h"
 #include "dce_virtual.h"
 #include "ivsrcid/ivsrcid_vislands30.h"
+#include "amdgpu_display.h"
 
 #define DCE_VIRTUAL_VBLANK_PERIOD 16666666
 
@@ -491,12 +492,24 @@ static int dce_virtual_hw_fini(void *handle)
 
 static int dce_virtual_suspend(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 	return dce_virtual_hw_fini(handle);
 }
 
 static int dce_virtual_resume(void *handle)
 {
-	return dce_virtual_hw_init(handle);
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = dce_virtual_hw_init(handle);
+	if (r)
+		return r;
+	return amdgpu_display_resume_helper(adev);
 }
 
 static bool dce_virtual_is_idle(void *handle)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
