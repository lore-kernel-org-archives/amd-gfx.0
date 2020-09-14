Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F195BC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7B420EDD
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wOYNcvBd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7B420EDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF2F6E3FC;
	Mon, 14 Sep 2020 08:22:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C486E3F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3gGitZcX8ZywECeWyhpIfvdhhY4Wgc8+EhqtqtrEs/z8uV/XuswjxACsYEMf3XOxTYiX7zobpoeDed9KeB/iLNP7+eIxfpKvYyxjdN9LaJjxpSRvW7i/0ItnSmS1gDm5gaMvd3tzSUfRekPkSP6MhkcxllI1lTJRJ95gp9deu9WLQUUux2foi7gZOpuMzFVHo9tCAtsebm/9YDtBgUag54cFhi4W0E7IIXcHCGreJHdHRBG2PJofPN6V9EaANVTq84u+fdLzOx/N40OfnpOFXAzYlGvuYW7oQft19LlPz/c414UlfQgqCzCNJbmW5elojcYRl0fav7UGYXt2WVZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9sxyiZXsj2VmvBLDZs0SpAYsS3+CnEVyyuszHwENyc=;
 b=QNZ88CuALqJUyUpqekQxONuyzL8XysMbl6fbhiFHgnTiGv2Qwkb8jOc8+OejRn+olc+g9XbiiHbzr3H+53OtyyRq0qWTxnhhs+aA6vAoOE3TJzedln/R55DWe6rdHOfldsHo/cq/wzoJl1f/n6PDUcmHyEAM4yTQB0BJRi50R6bXw/2uhDA3CbIEdR8urERm3rD5CNh7aUTEqxaxeNnIeSfTj8QU1mOrGOMMh0eggAgO2syRS3vttnuuOwMseGgBlguYOPy+RGN3pM3bPY/MFpULsz6f0mbwq5HcRurzMgNq3EzfAnZ+hkNSa5JU3DG3z97hFcCKiPRqMqpsFV//2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9sxyiZXsj2VmvBLDZs0SpAYsS3+CnEVyyuszHwENyc=;
 b=wOYNcvBdhVPHRj15oZjmp2TPIR2WRm05v3WAycg2VUWNRIKZClyE3kvC6tSUT+oPyvB41Sqfo9UoK999C42qK+9cvb4U7zx77vQOEAwYP8f4DqGPAChmxVD6riXurA13hMrQhhzmuhnDPPNfdVKuccibNEjZWc0bQcce9DiDv0E=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Mon, 14 Sep 2020 08:21:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:21:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Topic: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Index: AQHWim55LC4g6ydxE0SXacA6KwibcqlnyuHw
Date: Mon, 14 Sep 2020 08:21:56 +0000
Message-ID: <DM6PR12MB26198BBFEAA5164F1CE8BAD2E4230@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200914081001.3932-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200914081001.3932-1-Jiansong.Chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8c5ddb12-d1b1-424c-9de1-7346f456aa77;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-14T08:20:14Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 389661b9-f04f-4788-2793-08d858873e68
x-ms-traffictypediagnostic: DM6PR12MB4153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41531E839535644C0D74192BE4230@DM6PR12MB4153.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZY8+7HFcqCZK/YJucKirok7gPZgz4BHaGxD9oE8pr4iSw6Z2aCynOSjAE3lKYguTQ3Sb9aTySJ2ABZwp7yqbpCIY+v6UXXDPBZ9sH3vSAEUhhJaHJBSsi5uwDlveecy8me1bCMFbsTSGQOlflkM6eK7I6OXCilfc1pBQwr3Z++u3EXMlV0sb4NIE7Z50l8eWujNjtO3H4o3AqKcFsg9VSQUrZuHnXazFE9BlncDFG4fJCA+8xg8lEgCaRLUxoh7isI3CnAAokH/2LbtGdm98iu9st23grJOwai0bCho8WY0g1UQtkUKWc1zFaS7IUjeLE/zrccAlQ32a4gBzsWmWcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(66556008)(53546011)(15650500001)(55016002)(9686003)(8676002)(7696005)(6506007)(5660300002)(26005)(2906002)(66946007)(52536014)(71200400001)(76116006)(33656002)(54906003)(66446008)(83380400001)(64756008)(4326008)(66476007)(186003)(8936002)(86362001)(316002)(478600001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dy0OAZ7fj2TSeELtclFEtyFtBNQEMJZwlV9P0nz5ZKy0K5tN2NKo0rADaWDRnqlY0eocP2y9aZLPirE05ZyRl5xkygtj8Sqp82zPJOhlSv1EbX476AMlVqG+FDIH9xVmWmYtyZiUWC/QYQWYRXQcDGj1tztCMY/zJhXBi1J92LTCYQXysGv5FkeKdVV5fHzRoY4rsfdn+L5ugspG7sUFoEl3z+J5VT/dN00XZPBodJWVFq45Ltrsy9M1/RNFntGpsV5krO/mKa/PpgCIQBzeBsfNmvXDKnzeGDp/CQclj8BOl2Hytxr3yT+Pf/odsjBjwYWe7CiV9ZuMuQOFMwxsxqqFZLwF+Dw6V5jqe1NfAQqW8RfPIRwuTcA1z5cPmH+qhUBsKdQyQjrwRUWZDRKXaYmdf5goSfIYBTBGd5m1p3pmWpI5Wuw6YgX0GN2ok7M1mr7r8sSjKxxE7tT9NixmlQxj+SlM6b74kXnynC3WyIFmFFtTSKXzj86uSpiWHAQGBHOqoa87mW17ud2x4mCaGcQgSLjvFO7/nfNhKKMNP0vaY4QECh2xh2LPU9+h29hSXGc0IAeeienXOND/82uoGqhYKnhoyHzDyqalkDNbYSs+c7v4fPY6cuVbq+0qncltxHoWhDFxAf0P5ULm8Etwsg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389661b9-f04f-4788-2793-08d858873e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 08:21:56.2148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3htnxCQyHXl544sIJRg0YyzHy18nkWbaD5E7aYgKTcpm0adihOH35GnGR2GMBQP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Better to split this into two patches: one for the dpm disablement skipping and another for gfxoff ctrl.
Either way this patch is reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com>
Sent: Monday, September 14, 2020 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid etc.

This avoids smu issue when enabling runtime pptable update for
sienna_cichlid and so on. Runtime pptable udpate is needed for test
and debug purpose.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I70b704ab4d6efd169f579c392e5dbc2737dc1fb2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..7618f9972b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1129,7 +1129,7 @@ static int smu_disable_dpms(struct smu_context *smu)
  */
 if (smu->uploading_custom_pp_table &&
     (adev->asic_type >= CHIP_NAVI10) &&
-    (adev->asic_type <= CHIP_NAVI12))
+    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
 return 0;

 /*
@@ -1214,7 +1214,9 @@ static int smu_hw_fini(void *handle)
 int smu_reset(struct smu_context *smu)
 {
 struct amdgpu_device *adev = smu->adev;
-int ret = 0;
+int ret;
+
+amdgpu_gfx_off_ctrl(smu->adev, false);

 ret = smu_hw_fini(adev);
 if (ret)
@@ -1225,8 +1227,12 @@ int smu_reset(struct smu_context *smu)
 return ret;

 ret = smu_late_init(adev);
+if (ret)
+return ret;

-return ret;
+amdgpu_gfx_off_ctrl(smu->adev, true);
+
+return 0;
 }

 static int smu_suspend(void *handle)
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
