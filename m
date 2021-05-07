Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EE1C433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 13:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E076143F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 13:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E076143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747606E082;
	Fri,  7 May 2021 13:28:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61A086E082
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 13:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8YXr5Tjm4sPeeooE1D5K1ESbLcltHjLaVadhfR1Lrdsp9U1Q13yctjE1WUHKSqIFT8LxCSRtz39jy29/NwJIHmBpq6IIX9b+ubhEX5eU+4nON3jtAWERLQ4JE6G7h9fz0/vW1gPnd/GolY/6s+TwlmIu44S7hzC+1nhtDmzyc3qhmuehU6NlSYb/Qz+k4NHKAGz8KmSlBfAHYRKsjRXjRJC0DVXyDNSxSODSYEZAoM6Z8q/gm4SLU79PSA5rLCwhhyP/2ou6UUgHQipzCU9KaUgPIvz1xRrx0ZaCDEucQpEDTBOcAV8vTXEjkhY49mywNfkS41BxYSN/tFuOYFc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trxgwqVTZaDYQP6Ze+Hqmzn5a1TZoXUiHVDgSGrMntg=;
 b=V+AMpeMTp/onGAjd6PhGy7Sx//ve5ILl4HRhWOlxKL07sRZgulAcfQL3xGBSdfL6z6hc6R+C7o5DqnLnIL6YWTuFciG+DlzKvRAZgNe/a4XFJs/fiJrrq5coqvxzpgKFff+otQVZ87OUo9c3CLHY5ZCjYraPr8BE0nnx8t7GL2bjQr0uhY04qf1UYY2p5jwbC5WlLP+jBxLf9Q2rA1NBqZfujpFw5Z7S369Mb0PvAjKpdUC8gCsx1BjK2R/ga392HpkCJxGXUoGwG89TTRmwEpqvRG5V2NTeHK52+D/LxRbVvAtbc6NEKvyu3aRZcJKqSjFnLhxuIxmqIqh6T0l0gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trxgwqVTZaDYQP6Ze+Hqmzn5a1TZoXUiHVDgSGrMntg=;
 b=oqP3Dmn25MiJsfmIILnbkRiIEEokFZdCGuq+5D24Fv4mmfWEvbxPTdejo185s4pisSCQQvx7cBCW32PLDk1Ig77MZQXuIw9Sm/PHWgzB6Wm4yW0uUm9xz3oymLw+3Zhig3TLap5GaYCsGR3Ik8PF2UmZDkhHRvX3d2ks8upRiI4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4583.namprd12.prod.outlook.com (2603:10b6:208:26e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 13:28:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 13:28:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Song, Asher" <Asher.Song@amd.com>
Subject: Re: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Topic: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"
Thread-Index: AQHXQl31tkJYpyfnoUyRTYpFwac2HarXm0iAgABpSTA=
Date: Fri, 7 May 2021 13:28:23 +0000
Message-ID: <MN2PR12MB448860FFF944644EEA011C6CF7579@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210506095509.7815-1-guchun.chen@amd.com>,
 <DM6PR12MB42508D945ADD562AAB8BCA7EFB579@DM6PR12MB4250.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB42508D945ADD562AAB8BCA7EFB579@DM6PR12MB4250.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-07T13:28:22.913Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea2d8742-48b3-4b15-650c-08d9115bfd2b
x-ms-traffictypediagnostic: MN2PR12MB4583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4583AB1C7C72689130B3E514F7579@MN2PR12MB4583.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:94;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+BW3mBGKjZPO6p/7Hhzogz9ABllqCNT0U0CNmm73SMapGVuI0ErSgpkCGb9G5R/6JG7T7em3vUmwihUZExuVVVkopsp49iVPI3JjB0Dek/ByWuUM4ZBVqwuO35rvYqptbvOfDbyJXLlXqWMGeeziFulFf9XNi+O1dqSfMGbbmLivQVjkMOLRLqDTTJ7MjqifAdQlmBhDEvxn3vC9Yk0+PI2elbZAWvGmvVYxr/YtoHeSa/rgJSb0nvie/hkDpb/nJtsUS7o4R3lFHQZoGNdbK+PnDDrDw/z7eQx95oN/KqwRZGm1c17DTvZbVqeKEIc3Vaf8pBxixCOb8tE46w+N0pYynz2j2yhcvyFPEY5cSPTF2roWPNUQc6GFq+fHhRrLoIH9iZ98PwylLtb6oWeXL1Z2ISMUYeeu7PHDQRq48Z3M3bwhe7khxszrUgZ5dSnNi8Mu42Q4AmNLLTbMO3vouRGnpI1vUdTtYmsKrosAqX2pf9s34rSE7+oF7A2HV5lm/VYsuPIHsKT/HF3GoYTHNpa8sggMeFpf+mAU0GNYptpWKyFGWR8Lh7vPYKJz2sowDd/1EPhJM6yYDA5quWHJpmPhein699TSmmdvtqq+7PciYcQ+wE/qQF2klFkXkBhw3ajSA5w1Lgx0gx0+c2AYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(83380400001)(7696005)(2906002)(45080400002)(66946007)(186003)(9686003)(5660300002)(86362001)(316002)(6636002)(8936002)(66556008)(64756008)(66476007)(76116006)(66446008)(55016002)(966005)(6506007)(26005)(8676002)(110136005)(38100700002)(166002)(71200400001)(122000001)(478600001)(19627405001)(52536014)(33656002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ZIk2G0+zWUk3mD0qumONKqM3fdtgOJczmwqpGZXQs3i+mmsbhQ66UbNYKmsObhBE/0LiYkKj0JLWZa0Pf+EOHgZRWxlLCgVHBL80Q2zDUDJugqCF/pON2aI7y+DBB5AaZPvy3TjMYpcojmP6PNd1n+yALRn9NR3vNrX0qDn+jK04LlwoUctnLxnsE+br2zQcAxgS+VQms+3fc44EL0NvaRIHRoekf7vUwbtrd84zt0HJXeHvK+MMadH5uiEoMf4wc/ZdO/Xpj9LoL6Ya+TWl9pqyxTK9ngVrTBMeUF5++109rJRD/De4IrxyNsxpjSz4rMQMZVeefxH5Smpu8h4Ba/eR4/bpzE1hDtdNElZKlr0Wno+k5BNSM5g4xFxTqTShr7oQX51oUKMBuu1gkDLfHMmCEK4yhieqNRu6GI8P9qdR5yQgMXPf09E6m7fWBatifLQaRGXNrFYOg0E5RhfM5DZ/IEAvXrywvMgiFX9r+6BTWsusboxKjJnuJhxu1XT/Il9mgc+7KnNfGDGVs5JNLYfCIuYmdhO7FpZqMGtGB0p/8wh4dIMQ95ZmiyCkObQ5WPmJjCqGU+aIbiDoNipRhUK1VAU9ppApADRGcRGP25yCJ+v3mpcVZyjDJkT7frYDoYUj9ae5swUaDeii5akirbfB0NhoFiLXUncXDnh1mBYhfwZ1UnDRKGtcM/0fInoN7fCHyDxH6vsYj32QZVMMYz2+jUTPn9wv9C0oepabGRw=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2d8742-48b3-4b15-650c-08d9115bfd2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 13:28:23.4402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +R5LTmv/Voi6CO3Obl7iGYCSTqatLhMxjCQfrWvbKQUwDmcqLkPqao/KzkAFdP3p/eViSOZoYemYFCBknrXGfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4583
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
Content-Type: multipart/mixed; boundary="===============0382683251=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0382683251==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448860FFF944644EEA011C6CF7579MN2PR12MB4488namp_"

--_000_MN2PR12MB448860FFF944644EEA011C6CF7579MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

For libdrm tests, please open a gitlab merge request:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yu, Lang=
 <Lang.Yu@amd.com>
Sent: Friday, May 7, 2021 3:10 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>; Huang, Ray <Ray.Huang@amd.com>; Song, Asher <As=
her.Song@amd.com>
Subject: RE: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issu=
e"

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by:  Lang Yu <Lang.Yu@amd.com>

Regards=1B$B!$=1B(B
Lang

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Thursday, May 6, 2021 5:55 PM
To: amd-gfx@lists.freedesktop.org; Yu, Lang <Lang.Yu@amd.com>; Huang, Ray <=
Ray.Huang@amd.com>; Song, Asher <Asher.Song@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH libdrm] Revert "tests/amdgpu: fix bo eviction test issue"

This reverts commit a5a400c9581c3b91598623603067556b18084c5d.

bo evict test was disabled by default per below commit. So still keep it as=
 disabled.

1f6a85cc test/amdgpu: disable bo eviction test by default

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 tests/amdgpu/amdgpu_test.c |  3 +++
 tests/amdgpu/basic_tests.c | 13 ++++---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c index =
60f3a508..77bbfbcc 100644
--- a/tests/amdgpu/amdgpu_test.c
+++ b/tests/amdgpu/amdgpu_test.c
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()
                                 "gfx ring slow bad draw test (set amdgpu.l=
ockup_timeout=3D50)", CU_FALSE))
                         fprintf(stderr, "test deactivation failed - %s\n",=
 CU_get_error_msg());

+       if (amdgpu_set_test_active(BASIC_TESTS_STR, "bo eviction Test", CU_=
FALSE))
+               fprintf(stderr, "test deactivation failed - %s\n",
+CU_get_error_msg());
+
         /* This test was ran on GFX8 and GFX9 only */
         if (family_id < AMDGPU_FAMILY_VI || family_id > AMDGPU_FAMILY_RV)
                 if (amdgpu_set_test_active(BASIC_TESTS_STR, "Sync dependen=
cy Test", CU_FALSE)) diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu=
/basic_tests.c index 8e7c4916..3a4214f5 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)
                                    0, &vram_info);
         CU_ASSERT_EQUAL(r, 0);

-       r =3D amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
-                                  0, &gtt_info);
-       CU_ASSERT_EQUAL(r, 0);
-
-       if (vram_info.max_allocation > gtt_info.heap_size/3) {
-               vram_info.max_allocation =3D gtt_info.heap_size/3;
-               gtt_info.max_allocation =3D vram_info.max_allocation;
-       }
-
         r =3D amdgpu_bo_alloc_wrap(device_handle, vram_info.max_allocation=
, 4096,
                                  AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[0]);
         CU_ASSERT_EQUAL(r, 0);
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)
                                  AMDGPU_GEM_DOMAIN_VRAM, 0, &vram_max[1]);
         CU_ASSERT_EQUAL(r, 0);

+       r =3D amdgpu_query_heap_info(device_handle, AMDGPU_GEM_DOMAIN_GTT,
+                                  0, &gtt_info);
+       CU_ASSERT_EQUAL(r, 0);
+
         r =3D amdgpu_bo_alloc_wrap(device_handle, gtt_info.max_allocation,=
 4096,
                                  AMDGPU_GEM_DOMAIN_GTT, 0, &gtt_max[0]);
         CU_ASSERT_EQUAL(r, 0);
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727fc%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmYU%3D&amp;reserved=3D0

--_000_MN2PR12MB448860FFF944644EEA011C6CF7579MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
For libdrm tests, please open a gitlab merge request:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a href=3D"https://gitlab.freedesktop.org/mesa/drm/-/merge_requests" id=3D"=
LPlnk489763">https://gitlab.freedesktop.org/mesa/drm/-/merge_requests</a></=
div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Yu, Lang &lt;Lang.Yu@amd.com&=
gt;<br>
<b>Sent:</b> Friday, May 7, 2021 3:10 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;; Huang, Ray &lt;Ray.Huang@amd=
.com&gt;; Song, Asher &lt;Asher.Song@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH libdrm] Revert &quot;tests/amdgpu: fix bo evicti=
on test issue&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only - Internal Distribution Onl=
y]<br>
<br>
<br>
Reviewed-by:&nbsp; Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
<br>
Regards=1B$B!$=1B(B<br>
Lang<br>
<br>
-----Original Message-----<br>
From: Chen, Guchun &lt;Guchun.Chen@amd.com&gt; <br>
Sent: Thursday, May 6, 2021 5:55 PM<br>
To: amd-gfx@lists.freedesktop.org; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Huang,=
 Ray &lt;Ray.Huang@amd.com&gt;; Song, Asher &lt;Asher.Song@amd.com&gt;<br>
Cc: Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
Subject: [PATCH libdrm] Revert &quot;tests/amdgpu: fix bo eviction test iss=
ue&quot;<br>
<br>
This reverts commit a5a400c9581c3b91598623603067556b18084c5d.<br>
<br>
bo evict test was disabled by default per below commit. So still keep it as=
 disabled.<br>
<br>
1f6a85cc test/amdgpu: disable bo eviction test by default<br>
<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;tests/amdgpu/amdgpu_test.c |&nbsp; 3 +++<br>
&nbsp;tests/amdgpu/basic_tests.c | 13 ++++---------<br>
&nbsp;2 files changed, 7 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/tests/amdgpu/amdgpu_test.c b/tests/amdgpu/amdgpu_test.c index =
60f3a508..77bbfbcc 100644<br>
--- a/tests/amdgpu/amdgpu_test.c<br>
+++ b/tests/amdgpu/amdgpu_test.c<br>
@@ -496,6 +496,9 @@ static void amdgpu_disable_suites()<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;gfx ring slow bad draw tes=
t (set amdgpu.lockup_timeout=3D50)&quot;, CU_FALSE))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprin=
tf(stderr, &quot;test deactivation failed - %s\n&quot;, CU_get_error_msg())=
;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(BASIC_TEST=
S_STR, &quot;bo eviction Test&quot;, CU_FALSE))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fprintf(stderr, &quot;test deactivation failed - %s\n&quot;, <br=
>
+CU_get_error_msg());<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This test was ran on GF=
X8 and GFX9 only */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (family_id &lt; AMDGPU_=
FAMILY_VI || family_id &gt; AMDGPU_FAMILY_RV)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (amdgpu_set_test_active(BASIC_TESTS_STR, &quot;Syn=
c dependency Test&quot;, CU_FALSE)) diff --git a/tests/amdgpu/basic_tests.c=
 b/tests/amdgpu/basic_tests.c index 8e7c4916..3a4214f5 100644<br>
--- a/tests/amdgpu/basic_tests.c<br>
+++ b/tests/amdgpu/basic_tests.c<br>
@@ -928,15 +928,6 @@ static void amdgpu_bo_eviction_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;vram_i=
nfo);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_query_heap_info(device_h=
andle, AMDGPU_GEM_DOMAIN_GTT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;gtt_info);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_info.max_allocation &gt; gtt=
_info.heap_size/3) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vram_info.max_allocation =3D gtt_info.heap_size/3;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gtt_info.max_allocation =3D vram_info.max_allocation;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_alloc_wrap=
(device_handle, vram_info.max_allocation, 4096,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM, 0,=
 &amp;vram_max[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
@@ -944,6 +935,10 @@ static void amdgpu_bo_eviction_test(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM, 0,=
 &amp;vram_max[1]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_query_heap_info(device_h=
andle, AMDGPU_GEM_DOMAIN_GTT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0, &amp;gtt_info);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_alloc_wrap=
(device_handle, gtt_info.max_allocation, 4096,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_GTT, 0, =
&amp;gtt_max[0]);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CU_ASSERT_EQUAL(r, 0);<br>
--<br>
2.17.1<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727fc%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmYU%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7Cb3ce363db6e94aa1396308d9112727=
fc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637559682163619573%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Dd9uch8frkIAiVkdtaOHillKHngoVp8brn%2FxJuKatmY=
U%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448860FFF944644EEA011C6CF7579MN2PR12MB4488namp_--

--===============0382683251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0382683251==--
