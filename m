Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D57EC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F14864FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 09:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F14864FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27CC56E9D8;
	Wed, 10 Mar 2021 09:05:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFDDF6E9D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 09:05:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgUjH/kdSaiUuRAjoZ16mKZ+gazG/cWi0719vg9mSQjWnorUubVZqZGxQaTctMquWgfDyioEFbEqeaXCTb8jGuYM/FKR868JNGX3hOT7vCRHsbn9/Pm0CUWAbm4zU81SVIX5QY1iYYahaIwq4KpGT3IgYVhfZL5LfKH2g5pPUyivv9cVIl2U7qusv64XfwDmX0fvbFDoxI6Bx2G2Q4oZatDWVRXeGqXbDdl7oQWY5EQ6YGnLWRrFaba9gKV7dWm56Edlud2ftlQKjdNv4FTtoIdzA2gUc73sPGOiM/K0wdV+k7vUR30sOH/QR3hIeJwT1vtTVJKJKItBFSsN8ynovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM1K9mS50ce8Vz/CsvDFBv/+LqLOU49ifIfQIv3jyiI=;
 b=da9X+sEEop0aplLNCj8ceooaphCy/oIonv9VQOYlhPUNWIFIP2ViipZ/YS7ebt4pl77NXWENftC+tDTP57M9ANVTKyaC0C8Hj4yjQMs6awVV7hhnnG+CsnLO8rxCRFAe0ixlHyKvVTcPFKJF3Up5JIo1CKHT6K4fOmkIQp98TBKC2Sx/UIMu/oq8tynwRa5nNCDDJqIKqpSD+vxPVwwVIdyYHlNkI04V6bapTIkq4bJInXQJskLnqUocuilg9EuubrWnwmABAPHQZPbDzypcEFJa2W2wdrPRAuMkIKEGL/UfWnAAee2j5WWZe+ASIZE0WRIxyTstYTrQvtOPEXx2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM1K9mS50ce8Vz/CsvDFBv/+LqLOU49ifIfQIv3jyiI=;
 b=K1B4tgKExa3WmPuIQj9305t0IhxpSLCSpaCWQ/zFspfaZllKMfRT2aakAHdlf79nRop7v6OyJHEW49oKR74E520BoD99U+vvGyT/i8Cj9Y5nSOMLJBj/KSCnM3LMzEPPjsKt21uGcolSd9vlZwjXuB6+vwVqhKknvs5eLX3iP4o=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3179.namprd12.prod.outlook.com (2603:10b6:5:183::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Wed, 10 Mar 2021 09:05:53 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 09:05:52 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 7/7] drm/amdgpu: clean up non-DC suspend/resume handling
Thread-Topic: [PATCH 7/7] drm/amdgpu: clean up non-DC suspend/resume handling
Thread-Index: AQHXFJosf3+ElabRGkixQqPXY3qc6Kp878Xg
Date: Wed, 10 Mar 2021 09:05:52 +0000
Message-ID: <DM6PR12MB2619BA4F4B055F7E48CAFC28E4919@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-7-alexander.deucher@amd.com>
In-Reply-To: <20210309041012.23367-7-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T09:05:50Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=8f72fd64-862a-4aab-9119-66f792183c53;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e75aba48-3510-4430-2759-08d8e3a3b4ff
x-ms-traffictypediagnostic: DM6PR12MB3179:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3179C2752A88C350702BCBC6E4919@DM6PR12MB3179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/yVoXAumgh/q1twtERaygz4i4n3eJi9Axo+iO5HnwiTZ64WBoWbEidDQDyj5QbEJjKywEmxcKCh0tHzPLqhoGnx7l28RyfC+B2Uk3rp73VYNwNI5LCrFflN1zlXkTketXn7+2EBD/XEv1B3Q4qw+1O0qH6/G61wgSNkzHFTIYTnyn5TXtcVfG9cboqaBdYBa3FR5byhO/SJh5fwEnApARzcHF42aD52tadK2NIfBA+nxtrAs7O05pXrXM7GfJ61dnoV/qIdwX+2fb/peMzKLDAtcJ/pw3SaDV5iLyuGvCRZerNmxdoZ8KS290btL9Goy0KIeGYCAWcc1oCJq44zgwbgH1b+Htch2xi+0jdb1hzsVXQiY4Kn7E1qeCT3RWUCIzDMJIt+MI2NZrfwJdDWtflkKwR6ctl6hxaQXTmSxOo7JY6/NSjEm6TjIRKG9FKaHSbNfOfk6S+gYZBwNlkrGVUItu3l53DcfRsyh/GlKC8QzKQgo+lZltbRc6O9O26iB0wS2J12tbsCY0e4nwDvpnft7u47Xw2JSoXg3eLinz+rmgnYmc7uB5FViDysJpsl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(110136005)(71200400001)(478600001)(966005)(186003)(8936002)(15650500001)(66946007)(76116006)(52536014)(33656002)(53546011)(5660300002)(6506007)(2906002)(7696005)(66446008)(4326008)(66476007)(86362001)(66556008)(64756008)(316002)(26005)(9686003)(45080400002)(83380400001)(8676002)(55016002)(30864003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ld2uf77ieaR56FticI7PxCScRa61pLUZdlzgJECp/CPa1pJpSLnsYPi0k6Uh?=
 =?us-ascii?Q?lnmvS6FJSQflJSdBbCDfn3SErxHkLwLOMAMFD7In3sJ/CYNfwFdPZi49JKw+?=
 =?us-ascii?Q?gaB+Uj3J4kBFcfbdhWBBelN8ewW/hBqK+qSAbnndTOVTz+ix1J7eX4q+ilFa?=
 =?us-ascii?Q?XpOe7X/MEKIi0lGO1kpLmmzF3bM9h9xKdrUmoX5iJ/wfW5QK3bjQR/YnpgJO?=
 =?us-ascii?Q?qxxEFcHmAM3Zd0/UAyRqxOYu/fCKSd6dBsrCormT8bJB/Ja4R7B/m7TQ/cw0?=
 =?us-ascii?Q?drmRaVTo8ZsL+sbU7EIu/iBnogtJWAFDi9hD9HBcGkllY76v20QfOhb5Maq0?=
 =?us-ascii?Q?xTcRLRKQ4BMW1r0Tw1kKXYKzhtG2LVWRnpFprXqzpnNaiYsxzRCU1Vgxx1kK?=
 =?us-ascii?Q?1+AIkUg/u0OoUxsI7XaUQBb9/TRdsQnrO7Pjiuvej0zzcyESAgdRDIAJKu/S?=
 =?us-ascii?Q?pnTpyTIXN/ve6A2N0MlCtQMmzmYxcMyzqjP2VLRiY+tgJc/fnyNY5r9v85uw?=
 =?us-ascii?Q?UeH1gJk1a/JZxgTaUldnyd5QpvLiwSiW0ljNRJ2x1CE8Q2+8cQjx/xz4YtF+?=
 =?us-ascii?Q?hH+CPaZQPVjL1XKWP4opuZ1+0T+xhx2ZRwpZaAmhDTvkScTdmVGNqk/JGG9b?=
 =?us-ascii?Q?IS1pKQjxp+DSBILmbw5MGKyd2diLI7yBVq/2+Q5i3LV0eAKIb/VVQNm3AFCv?=
 =?us-ascii?Q?N8mIQAcCHfIHarSqoO1Q1E4OzODaN3qyrsDdAkj6QbBnhp4XNGdwU16J0E/s?=
 =?us-ascii?Q?nxOeKuIZPini+xPFozYPYW58ul9EzopUgfqxy7DefOuTh5CKTqC1XZlxLqsY?=
 =?us-ascii?Q?hQ53E9qz6Q0MROk/8J15yp/YKKxrMLZWcWfK96e4scQ0vbDA6F6KH7RY+WPz?=
 =?us-ascii?Q?INc7v60DtEda0aI0kMQQwxswWzs+PR6VNCR2ySk9tX4rFvi8tqe6X++TSkCA?=
 =?us-ascii?Q?eeb6B5aAFlxGA1VOpRswAamBYiKe8932v+B6JvCZKxoF25V97nOdCN+zFEqg?=
 =?us-ascii?Q?CJaq90bQots8pu5enn/Rg6pDHSSzKrY2TSQeT2a61EXUqLUslFnXBrcOWOMC?=
 =?us-ascii?Q?DYPRrgumzPZwxUZzJKPOP+EhVgzRHLBz0ZG0cfnm6kQ3tCk1mXZ5qFi78phv?=
 =?us-ascii?Q?NVFG6EY3X/gLR8eVqz6Hsj8AsbxDg/97DHS+GSqG0zEnkIel4zbX9e8h/aVV?=
 =?us-ascii?Q?rjxC+IQxrMBxQvvtCJVQEryxJPXg+eWWs9RXXBo4Rz/WDdSOO321RydLk03c?=
 =?us-ascii?Q?8Byl5Rb4j3a362iGZocpkfDmtVH+7Z2lOB8jTEBMzDCb6mlRX9xmI2rS7sNd?=
 =?us-ascii?Q?YX3c1s6teIEd5yY2jdVtW71c?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75aba48-3510-4430-2759-08d8e3a3b4ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 09:05:52.7390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ccmJXO1VdidB1065LTaLUsLuvipZg7iHVJS9iDCKv5qKkNxUvaXHLBUcaPCMeCyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3179
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Patch5,6,7 are reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, March 9, 2021 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: clean up non-DC suspend/resume handling

Move the non-DC specific code into the DCE IP blocks similar to how we handle DC.  This cleans up the common suspend and resume pathes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 82 +------------------  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 88 +++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  3 +
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
@@ -3674,9 +3674,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)  {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_crtc *crtc;
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	int r;
 	bool s0ix_suspend = amdgpu_acpi_is_s0ix_supported(adev) &&
 		(adev->pmops_state == AMDGPU_PMOPS_SUSPEND); @@ -3692,45 +3689,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
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
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon)  {
-	struct drm_connector *connector;
-	struct drm_connector_list_iter iter;
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_crtc *crtc;
 	int r = 0;
 	bool s0ix_resume = amdgpu_acpi_is_s0ix_supported(adev) &&
 		(adev->pmops_state == AMDGPU_PMOPS_RESUME); @@ -3803,24 +3758,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
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
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev) {
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
+int amdgpu_display_resume_helper(struct amdgpu_device *adev) {
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
@@ -47,4 +47,7 @@ amdgpu_display_user_framebuffer_create(struct drm_device *dev,  const struct drm_format_info *
 amdgpu_lookup_format_info(u32 format, uint64_t modifier);
 
+int amdgpu_display_suspend_helper(struct amdgpu_device *adev); int 
+amdgpu_display_resume_helper(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 7944781e1086..19abb740a169 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -2897,6 +2897,11 @@ static int dce_v10_0_hw_fini(void *handle)  static int dce_v10_0_suspend(void *handle)  {
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
 
 static bool dce_v10_0_is_idle(void *handle) diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index 1b6ff0470011..320ec35bfd37 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -3027,6 +3027,11 @@ static int dce_v11_0_hw_fini(void *handle)  static int dce_v11_0_suspend(void *handle)  {
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
 
 static bool dce_v11_0_is_idle(void *handle) diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 83a88385b762..13322000ebd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2770,7 +2770,11 @@ static int dce_v6_0_hw_fini(void *handle)  static int dce_v6_0_suspend(void *handle)  {
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
 
 static bool dce_v6_0_is_idle(void *handle) diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 224b30214427..04ebf02e5b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -2796,6 +2796,11 @@ static int dce_v8_0_hw_fini(void *handle)  static int dce_v8_0_suspend(void *handle)  {
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
 
 static bool dce_v8_0_is_idle(void *handle) diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
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
 
 static int dce_virtual_suspend(void *handle)  {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_display_suspend_helper(adev);
+	if (r)
+		return r;
 	return dce_virtual_hw_fini(handle);
 }
 
 static int dce_virtual_resume(void *handle)  {
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
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cde024782e56349cb659608d8e2b14d42%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598435530070%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=blFMxp1nrTITbzjXo9yDFs2LsavBg7aFpgvrZu3FYtE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
