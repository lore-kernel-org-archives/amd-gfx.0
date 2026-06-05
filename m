Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A556CD6E7B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 18:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDDC410E4C3;
	Fri,  5 Jun 2026 18:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Gj+/5Dn";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C553510E4C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 18:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6jrjEjht+W+J0ojxE/GrACfivHh7lQIHLso7SfPa0xD+HRFWKtJNRF25myu+/EjKzDk+dUkHvbhS5CR3oUq3QV983taD04qoGGkx6tvZTBhKOtflaQkv6Q3Zi4LltNI8f++Ui/u6aerQUL+lmJvjdARWQxVb9LsLVDJpb9cXvfQY+LO5xZV+6jkPHGUdRiC6HrjnaNI5zfs5zbGK8Jzuy5UiFWDqODAt4exVZMZ+ko+A2HqUo7x92NM4Xqdgxttvx9i2eD29Fz0k3rO2ywCZQpK52SZQ5n3U119dGg/iIpJ7ydzJ46zOSUseNnk5B5M7aQ7x+YnTohESxq0F9vZAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHoKiGMM4QKc9YPuxmGSXCRdE8MuusFY6ejTItSlFfA=;
 b=sdh1wQCurfH5G4TmUAR/GWv6JO7dk2N5a7BA5T442LMNwyrXUuogje31YTCdTnUxG6C+AxKn6i2aQ2+Iu1LzsT0xLl3iLScWPFyAqYe/HLvkKxMi6b2SNUl7yIM0O31cxsy8ZeD/wLuulRusCJ8XBbgGkU6dHG4n9R9atsqNYGYMGbzkgIcCRB2sDSwQQviIv/o09Cxf9QMBgTPswGFm0nPgJQ0detdsiPuuhdZd68PsNlf6iOKVeBIJlVdNDNsAF5esD79FXdlZd8cNWGoyrXPsJPJ2Rd7eju0Pd2t7rXB966ASUXslleviU9KN9VlzecrsUsno64CAYI3P7Mdteg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHoKiGMM4QKc9YPuxmGSXCRdE8MuusFY6ejTItSlFfA=;
 b=3Gj+/5Dn8sgIwgit+zL0ZDb8NmUVZ+wNmXFUSsBcY/ckTEgRI0v1xYKUuBUfLJrY5QVekz4F+d50Q4rCAIOhXrx5Yb8XAI+NDKGtlk6HC9TrhAVgQnyTGkaEHVti+lIxMzTIWY+4rLPMDzGxA9o7GDyaMTq9H6+H53gM5muF6hg=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by DM4PR12MB5745.namprd12.prod.outlook.com (2603:10b6:8:5c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Fri, 5 Jun 2026 18:20:37 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%7]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:20:36 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
Thread-Topic: [PATCH 1/3] drm/amdkfd: Move mqd_on_vram out of v9 mqd manager
Thread-Index: AQHc81zUkX4FkDbsR0mrjvI0mTxZo7YwSPWP
Date: Fri, 5 Jun 2026 18:20:35 +0000
Message-ID: <SA1PR12MB8144984C0600886E27132614EF112@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260603132740.180346-1-kent.russell@amd.com>
In-Reply-To: <20260603132740.180346-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-05T18:20:34.818Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|DM4PR12MB5745:EE_
x-ms-office365-filtering-correlation-id: b7cac8ee-c351-4507-074c-08dec32f2385
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: ah+MTmdYA2kbg1Uv6oa8ewqB7KOVHbJrkVUQZHl2SgdDEzhPU2R0IOvAWAZV9FRUUEAXeAoY3TeQubWpEmyqN3ljH1E52O/Z171ylHUQrI6Qr0mW6WiaMSPJ9X48B+RXqqpEfl1gHIyb9i18fbQbSUXM6FRuY9ZDJ8Q+Q5UcIcXrTpXN5EmNSd7oqTVZYoK1s8IUQdd+mtQfrO1NQSIqKQQa6lmNyVRJJju6ezhgqmGlpb4jthvErIycxAausO4qr2wsqzi7WdaLnWMAtfEad2UFrN5UTQ7vjJaWk2NXS67U9xmi6iTHCfVdbGvGS5/xoGmRSJo7Xl2VIwdnZMd4BM4FNrDPn853ftD26n5boUkpb2XN1fwxY2DQZCKj+bX9plakcz9fwRo+BQ5uoW3UoywsBBDmhMHNnqJhshXUm2a13ym3dLy3mCa3NUUvGTSOYiuVpXqFfCzrZl+GE78mw9OkoVKBHFYF8EiRnr5kHYT/71bWegMwFojJ2b6/7t3Xjh7+EXQ+bgwu9tavZNEx8ETaappaeez2Yo4JNfYuR2irQMK5eFKAu9KN4Xl4GEwcq3qopHNlNJRyib2R+GhEAqULCOjRHxRqwtEZZGkKnFSyi3ttYnFQMkw5gz+KxK0kO8Q7jPjgy2K2tfpFpER9NAq6az2XtRl2beUvjieVC4tzy3jqrmZPWLKP7rfWonFxuH9ZzcUCslfN2RmlKADcFgMQcytN9DXvmbPGh2BtSc5uZ3RmoetTqehME05WjZYP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oogiMNzeXbDRYP+p5mnt2gMgsULjply1qdCUdIq+4yJaoCx5TvDbOhO9smv?=
 =?us-ascii?Q?OMlXTTGLHQ9pUWeBOxvTlFeirzDu6zWo64c4TDpsN8+FxSCLvGhAdxQDBD7H?=
 =?us-ascii?Q?95y5oqx7wBgLNW3+R4PI9mD0EGqk80QHjJrELcPC3WvtvicFP3yIBGLb0da/?=
 =?us-ascii?Q?MTTKxUXuYZQA2tz6viTCp99Rgq7bdCkbAaG3go43hxEz/qrdDoh5P2kMBlKR?=
 =?us-ascii?Q?8j6dqVLJPsD/rsjC0HJvxBJroBpBwNUz4GiArVScE2WbgSiNrCK7hlKLPNEc?=
 =?us-ascii?Q?zIHTZ2GlKG2E07Q8ykbB2UnUv9PXlcIfF/okcOfuxT2aF62PjCWW2kTRQIMM?=
 =?us-ascii?Q?4qGrOg3WZIx9S2uuyJV4jwKK9O780SxL7I5lthYVbqr8JWuluds97gfuTC/h?=
 =?us-ascii?Q?aYw6X41ekzcarbYuzg6h6AZIwbf5Bgdq0tFVjuAwiZEBF3XhZNgurM0JOaCJ?=
 =?us-ascii?Q?iqWBMoEGowUbofj8mlX4xciqrf/Y/3lv/Im1rcp7yyil6exZfQMGctNR8HUN?=
 =?us-ascii?Q?2Ub/YlShVWtdo6q+1Wg9AHd6n1IPzzro/z0a/mp2tCazJotU62RClvg139V3?=
 =?us-ascii?Q?PwId76a0d5ftifAjRZMpAeppuOjjx8ycibkqYfG1gX+tEyEBUxwK0MF1w+DD?=
 =?us-ascii?Q?sk172G9/vI1KdAHJJlys3TTr+0kyfb/OZspauR10ThiNKd5zywXugdSJJi9/?=
 =?us-ascii?Q?OBThXYvL+BSc1Q3VBaDdVR/HUHZzEnfFFTn+rFicy1QEsI/02p6YAfdQ+iCb?=
 =?us-ascii?Q?Cv6Oo1I4WhEo/wtFEecUyHaCltfaR9f14v+lfep4OkkbRcuii1X5XkLQMgH1?=
 =?us-ascii?Q?bhv0e08yEy1g8a8VSqiBjZ2PhZnONeZhHsUYtBGM5aNjXD7rMbWUKPshTadP?=
 =?us-ascii?Q?83WV8AMFAlAiFLs3OeDLCI4Ztu7XW2YLdg0ljHlxPOLbKYIOTrRjCHevWNSa?=
 =?us-ascii?Q?nBbivoyfoDEo32/d4itRggl5nqbzuRWvjHyjJrbRiL+hEf+ozicYec6dVSQf?=
 =?us-ascii?Q?wW6GMUi4op6lVyErfKdGCXS/22xUF0Cyo2rnAN+I33AKz6UGNYH7+EW6jK7K?=
 =?us-ascii?Q?a9rJaevREMDg47JPp5LVZSNWqVdKl2I7uEymP2BB3CHLCl7ZAYIzgeZQJiQ8?=
 =?us-ascii?Q?twTpK5TXOLHG75CoerMPYmOG5r6QF95wT4aTSWwhFfcIIODA3FDlhEdWoNTs?=
 =?us-ascii?Q?m8CfAZVUXxOVutphL+Zjipz+Zwpr8L3Gz8la5aw8p+bgbjo9wPsFj/lbnGBe?=
 =?us-ascii?Q?Nh4JKhF32e6hZt98QPVoIOvkv4oxXAYiX2ZB6rEJlj7L13jRMfL9YCNvc2Os?=
 =?us-ascii?Q?AbygfXCuu0I8cX0nhQP+sioboUfdO5ewrNHYDAUr4Qs5rN1zj8bUQEVtzyN0?=
 =?us-ascii?Q?gGHzwQ3/J7eI+7jMYkhcfHz5G+dFCHDkyZDBi3D8uMuJSlh+RQJkw7C5xsnY?=
 =?us-ascii?Q?gV3HNh3PGNb/+/hJsr5DmlVp/ZnTmTpsNzKWHds9/Z41+RACvTogrFOIzaK1?=
 =?us-ascii?Q?JlNJ1xUAUxatFtLlpGv3gG5BvnplN3Oz2+h+cisdjIuhvPVRDmOk4jg6mGii?=
 =?us-ascii?Q?64U4Hlvxla/xaClGnXoiJ9jts0Gza2pYkg3ebQgevUnBVQQH6h6NJaCKjFEZ?=
 =?us-ascii?Q?sgtH6Z25k0QMhYkhFYSsQeGiN62IjbbGl5zZzTyzk01LPdVMZrrIJcAgKWmk?=
 =?us-ascii?Q?5Qarc0VDLXoWymC59EhRRihvSA4ccH1pRzAhP0czior/WPh2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cac8ee-c351-4507-074c-08dec32f2385
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:20:35.9244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO/PGz0gfBVnIiR6EUq9pRKn9Gtlycl7w77b29PHvjV1mppVkRFkXawM7wldwNQQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5745
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

Looks straightforward to me.
Assuming this compiles, it's

Reviewed-by: David Francis <David.Francis@amd.com>

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Kent Rus=
sell <kent.russell@amd.com>
Sent: Wednesday, June 3, 2026 9:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent
Subject: [PATCH 1/3] drm/amdkfd: Move mqd_on_vram out of v9 mqd manager

This will allow it to be used outside of gfx9

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c    | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 14 --------------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.c
index d88d0de58edd..02b52f907f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -315,3 +315,17 @@ bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *no=
de, uint32_t doorbell_id,

        return false;
 }
+
+bool mqd_on_vram(struct amdgpu_device *adev)
+{
+       if (adev->apu_prefer_gtt)
+               return false;
+
+       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+       case IP_VERSION(9, 4, 3):
+       case IP_VERSION(9, 5, 0):
+               return true;
+       default:
+               return false;
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm=
/amd/amdkfd/kfd_mqd_manager.h
index 06ca6235ff1b..140ee1fc5d81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -201,4 +201,6 @@ uint64_t kfd_mqd_stride(struct mqd_manager *mm,
                        struct queue_properties *q);
 bool kfd_check_hiq_mqd_doorbell_id(struct kfd_node *node, uint32_t doorbel=
l_id,
                                   uint32_t inst);
+bool mqd_on_vram(struct amdgpu_device *adev);
+
 #endif /* KFD_MQD_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index a04102fd2fb7..ce379ab17916 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -115,20 +115,6 @@ static void set_priority(struct v9_mqd *m, struct queu=
e_properties *q)
        m->cp_hqd_pipe_priority =3D pipe_priority_map[q->priority];
 }

-static bool mqd_on_vram(struct amdgpu_device *adev)
-{
-       if (adev->apu_prefer_gtt)
-               return false;
-
-       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
-       case IP_VERSION(9, 4, 3):
-       case IP_VERSION(9, 5, 0):
-               return true;
-       default:
-               return false;
-       }
-}
-
 static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
                struct queue_properties *q)
 {
--
2.43.0

