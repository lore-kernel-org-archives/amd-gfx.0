Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93707C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 07:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC64810E21C;
	Wed, 14 Dec 2022 07:12:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FF310E21C
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 07:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBUtexNTBtPgoxnnWmU9oaONKynedz3Ai2UPQX0KF/tmoo9vW+U8pYp+AQ2xo6hVrrjLoxrWNDazdOn97cJnJJahD3Kgi0VMDaZ8C6ajtHNWHPK1fSetTtOhOLWwqEaPUoO2B2HRHegLKaK6wxbHV9HxqghJvdC1ajHl8cs0OH4ibzvZaeSW741jUpjShxrhbMeCK66OU1yQRQvfDk6EjgBPg58g4e/Js7VsN9R2lVBxtb1pPfX6ddtof64Zcw30N9o0LiTqyeD8w6L3+qB2oxm5cHmPH4AVEHarroPnv9ehbw86vwqvR5wfwnPw8AkruVzID4qRMeMqT19OwZVC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxwjQwWOvc86WPxceCtKNUfD/8/wHD20hVQ5Vvtv9XI=;
 b=XrSxadHO5574n/GfqqSJyEpZX1979xAFLPvTPA/8WAxkrOIXa69EYD3Pz3ADWuGAJvn4DQ38RxhCeyWZyg0S99fOWx4Sng+9+iReIRZxMuLSb8ykAQmUApCnyVXVfss5QTlBxS9hrso66tzluCRHzfzlCY1IDuvE2bI+0h3r+VKxfvUiHKb84WJ5i88zX1N/MowYHIZk9T9kXMFLCJJ5lP1v0amZfGXew+fUi8exLG0mJQ+OINXPumJd/dT8dUONGHVRMUUnNXNOIkVy1kDgI5LG7YWJgpI7ipk0JJoiEd+BZr9Nyorh2y9M0zHAbhWFJ7mFlBeOUOUfx3VnjyVSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxwjQwWOvc86WPxceCtKNUfD/8/wHD20hVQ5Vvtv9XI=;
 b=jyFnr2b3jXj07iADPPXpSPQLUHu5sdN6MxZly+Nn1zVUivU8Fmr2ZLOrb+Tyr4OsMb/qAO4ob1OwXdGsnk0bES4zRuIx3SqcQPRgVswwuHLG/rYh+7Gd9AL0CfWPInCcJkuxrBPgRNQSGzxPduszaJw+ey/pbII6S0JDGToFAYs=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 07:12:40 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::4f83:ee28:88d3:e58f%7]) with mapi id 15.20.5924.011; Wed, 14 Dec 2022
 07:12:30 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: fix the crtc array out of bound issue.
Thread-Topic: [PATCH] drm/amd/display: fix the crtc array out of bound issue.
Thread-Index: AQHZDib1PBU9i6JGVEO4/QNTo47vr65s9s7A
Date: Wed, 14 Dec 2022 07:12:30 +0000
Message-ID: <CY5PR12MB63694EF4C3CE03DBA36D8CE8C1E09@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20221212124027.4113533-1-yifan1.zhang@amd.com>
In-Reply-To: <20221212124027.4113533-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-14T07:12:27Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3c791bb2-d465-4e1c-be4f-c731d61d13e6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-14T07:12:27Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d1c422b4-05fb-4b85-bd9c-cd47c8a1e226
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL1PR12MB5754:EE_
x-ms-office365-filtering-correlation-id: ec5933d3-f559-4e76-6e31-08dadda29082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S0BKzUCaiWHTbqWzX4TV3Q/nWQ2dsPx03A6d+WUviz2prw9DpvziQLitfr9BFLnrfenwU+okGzR6lYWbW5LhukYY0vX/MEOUA2Xx3NwvB2VR4WwYfBJCTSMkcoDuCHFHU7DGWr3K64BrOIJxf8EIMy7sB7am6P9CTIGQFhXFIXa6DJTfq/1tkGEJlTzOYsJzxuxTNTmjhGmPBSw1ndUp/AxIN0r21wjdbrDrRv/C7ub+AL2E98aEPksh7khAR8+kpkYwBMPAA1AP4KvzPpzlk8aWsGkpOLwSWyrVaXTyHc8aIc7PkD7lO68MPkHp1kkv5CSJvThWMWmXWPzYoSOhJ8BmL/m6QAHhN8OGaL+khcnTIvDEI3vTS4p1AYaPF2lPi0Q5bfsiPPe7UZQV6ljtn8ct0QKomdj3c8Lzso4iJdVe8LLD0vB1rf/wzy4E9Ihzg4oCAgwqlINBvo0LT65bEkXEjI0sKjwoculanzdkv2+zVrdRZUyV2CkWySYUJusDU7B2Kc29/WjzFPt+PK8rQRoO4l+cxu5Jda8lN1oUdBVJ92W3Frc4ArvZdJgu+zrHIbdqa6DHGBE6FXhWCBsaM3GA28Dl+hFFV0MLwcH1Tf0A5cqV22WiVg9c4fFa63B3d85U1+TxVGVbk4L2wqLE6l3Rh0PivTrBHlI0We5afcmk8lSOPoiz5CW451lpa+8cJPPOCGci8fryi2hrzVA25A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(76116006)(66446008)(66946007)(122000001)(8936002)(52536014)(66476007)(66556008)(64756008)(4326008)(41300700001)(8676002)(2906002)(316002)(6916009)(55016003)(5660300002)(54906003)(83380400001)(26005)(38100700002)(38070700005)(33656002)(71200400001)(186003)(86362001)(478600001)(53546011)(9686003)(7696005)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DDbeT1OAezBRpiz4qbJd0Dt/bU8wusRU1XPre2YJfaPCab6TJyjgWj1oSmCB?=
 =?us-ascii?Q?PTNI8s5p26DTG18Y65hqsv3+jpQrNzQcb6wQ5b5poHwmNoGj23U+52t2xeUQ?=
 =?us-ascii?Q?0lyCMIEnmqFcNdM6l4cSDqEUNJEVoZvtVFcTru1iuC3cxLYGuVIQieSRBxB9?=
 =?us-ascii?Q?2Mk9HUeUdpXlVmP3YXfTAX7y+Bgfu8twGFACBA7IoDh1rrl288BTCoLbOqcp?=
 =?us-ascii?Q?8NtcEaRhof9pubaK0E3n9sKM8e56jAwbp2UuaZ0trO38//ieI9syQCdyEADD?=
 =?us-ascii?Q?2FN0NGnnSvjRGD3JSOs2ahJg37DbmlzKO8PXvxL2VK6H5DkXrmKKT1KmSbbv?=
 =?us-ascii?Q?iA3jLMuUH56MkG34Rmx4L1xYp4ZEhb5YK94vt/jNOSgGfniSLkOp9Rm7OBlw?=
 =?us-ascii?Q?8dDIiEYAYWb69BYdWUCxPNWV1ZAAp3AJLg8q/Gq1+1T+Js9lt9A0JWViSojK?=
 =?us-ascii?Q?T3RcAlIP0vehyX09NSKBBeLEf1bRK92zuIQUdIsBdsmwlh70qM9C9oV687nH?=
 =?us-ascii?Q?2P7sw+4BwMuiVsBDScaJYlj4fawkyVYXt/9/uhRStRE8dvgJC5fKoO4khDHS?=
 =?us-ascii?Q?xEtno0COWFyUu/a6hqtINKJRib7M4M/TpZmza37AhXH4uEiDRxbE/o6v8k8j?=
 =?us-ascii?Q?7v4AToM3ZT1KSK8Uo29ZSIQwI9A7T3gD6GrLLewx2mOyWXwGnXAFrooNMHWU?=
 =?us-ascii?Q?BnVO98SCmOHlyqNPEGNR3leB6azenXpD9jEwZ69cRVAKP6cYgFagRoh+khug?=
 =?us-ascii?Q?b7KZr9r10lXG0Mwc1lvy7PSU3/gf+QKGYT/r8cqPNhSeiyggX3yn1ubksW9U?=
 =?us-ascii?Q?MPPGGrrkJx4v49wjEqSyt2ZRBL+nirqWQ0SgYmoEbVduvMAwP0Lah8oq/YY2?=
 =?us-ascii?Q?uOT2vs66yjeSbzMgwl5JduyfcppXbpX33j4d+MWC3xIjRQcWaoWLtzuaZyJG?=
 =?us-ascii?Q?jgXOEg8vOZ1LyAW71Rf4U6+JcD55NbfvsYrPd3pxjwD1iG/CY/WoLX8KkRfZ?=
 =?us-ascii?Q?roPpkQY0bCKkOnHdX54rnmUjStmXr1LUpW0sDHOzHMh/aXYA32r5fipFq8YO?=
 =?us-ascii?Q?p6LSjYnMi4M54YKkmqzzRpuCOHzTr6e8xyWCUNHFp8m+WJAe5CjRL73483XV?=
 =?us-ascii?Q?hqpDMkEaKv5k2ZlDbmbyvNLWlxdAD8OrbZlFq0EbhK2qpH/fa7Uol5Q3s1o3?=
 =?us-ascii?Q?xYxVs6Wdm09z44AiwYrAb8uhrYOD5VTZKbrq4juRkT6yxxsUZM8H9LSZVYzv?=
 =?us-ascii?Q?82wzrjXopDH9t8gGyjJEK7Ok2lUrt9PF7XrfAlyrwKkIaJHK+Eto/QmRpk/t?=
 =?us-ascii?Q?RnxDM6EO2FD+qfDde8wSrqH37L/+a8d/wjTO1DmTsJsy8V6p76NE/jX15IkS?=
 =?us-ascii?Q?7c0vfdS1SIX+rWLWsZxyXS3v2H+KVxN8xC6QBwatkti5ksvTim+Hm/5JdB/O?=
 =?us-ascii?Q?0dqyEwWhfPtrfHLmtuCCcTt+sk7uZKRD73QghybX4nEURQqF6ueAltQwN7+g?=
 =?us-ascii?Q?YDERng9DPOD8Cswft8ZaWF/zqn4naw1rLa0nTQXkoph/LIqIttxz+9A3JhWU?=
 =?us-ascii?Q?fWskVE1QJCFfUeMUXqo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5933d3-f559-4e76-6e31-08dadda29082
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 07:12:30.4629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVkaqqSHCR5TnjhKTGHL40tuXNIjBBqRVVNxVeFq4Cowfl2OODHdjzu7UU3UHlf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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
Cc: "Liu, HaoPing \(Alan\)" <HaoPing.Liu@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping

Best Regards,
Yifan

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Monday, December 12, 2022 8:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Liu, HaoPing (Alan) <HaoPing.=
Liu@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amd/display: fix the crtc array out of bound issue.

adev->dm.dc->caps.max_links could be larger than AMDGPU_MAX_CRTCS,
change the iteration upper limit to AMDGPU_MAX_CRTCS to fix the issue.

[  276.069644] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  276.069652] UBSAN: array-index-out-of-bounds in drivers/gpu/drm/amd/amdg=
pu/../display/amdgpu_dm/amdgpu_dm_crc.c:550:55
[  276.069660] index 6 is out of range for type 'amdgpu_crtc *[6]'
[  276.069665] CPU: 11 PID: 1092 Comm: modprobe Tainted: G           OE    =
 5.19.0+ #15

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 8bf33fa4abd9..af2230797be9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -217,7 +217,7 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc=
 *crtc,  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 		/* Disable secure_display if it was enabled */
 		if (!enable) {
-			for (i =3D 0; i < adev->dm.dc->caps.max_links; i++) {
+			for (i =3D 0; i < AMDGPU_MAX_CRTCS; i++) {
 				if (adev->dm.secure_display_ctxs[i].crtc =3D=3D crtc) {
 					/* stop ROI update on this crtc */
 					flush_work(&adev->dm.secure_display_ctxs[i].notify_ta_work);
@@ -543,7 +543,7 @@ amdgpu_dm_crtc_secure_display_create_contexts(struct am=
dgpu_device *adev)
 	if (!secure_display_ctxs)
 		return NULL;
=20
-	for (i =3D 0; i < adev->dm.dc->caps.max_links; i++) {
+	for (i =3D 0; i < AMDGPU_MAX_CRTCS; i++) {
 		INIT_WORK(&secure_display_ctxs[i].forward_roi_work, amdgpu_dm_forward_cr=
c_window);
 		INIT_WORK(&secure_display_ctxs[i].notify_ta_work, amdgpu_dm_crtc_notify_=
ta_to_read);
 		secure_display_ctxs[i].crtc =3D &adev->mode_info.crtcs[i]->base;
--
2.37.3
