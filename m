Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D358C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 07:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25BB10EE6C;
	Fri, 21 Jun 2024 07:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DwKvmgxl";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7CEF10EE6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 07:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka7Z8kndeWkeEtC/nMyng+z8b5K1KIMMf1FSZ15sOwRCeALvbqnx/zZ8yPvH/y2UA38raR+mRRp4OxdYWg0JLmFghDlaDALW4gbs42iWr33R5ddOLN1DW0JnWyR13IP0I9tU0047xZ/cjJvye78mAYBrr7XzBrGSIY6iHUdg0/xjJZxj3nIz5rByr6L9wOtoYICbEC/WfTwmKTaiprjQgLCDdfII/zUwRqSEczT3xspoeA6fU/WLxbxxNpCae2eaNjBIF0uiA1c2PugQdZIGuv1vo66sKcCyn4kYhpbD7hRd0KyeGI1G4myH6bIn2b+ZCpuG++0L7FOg+/5cK5n/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9VSSfCGB5enJVJM8WDasIrPiBy2kgrZBqKKIb3HeHg=;
 b=HHDWvzO6argjQR17/gGeSBHYDe8WSmN9+0RVfM9V0ajoYgNkdO011R4vUHyebMgOn/2H7gu0lnxts9NrHMj8MEzmiWd5bzCxrYv+GXHlSVq7bHMHV8YwnTDZub0186Cg0A7a1J0IBUrixpJvzwBtH2r0yWy2ySWgNDfFXPiQpb7lctj8wJzCsW3EfTH/bnx/txFKpBWTSH5lZ4crCD2Q1c54Fy3fbkKXU9uIwan8brZLdEjVMM31XLBjili9bhpM53h3QYtwoWmDI8JNFfpd72/8rgRlXa/zFzsgMDqfPxpGYOCCtDydjLD3Td3S9c1gmoE8fKuqqbNV3r9xtcVjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9VSSfCGB5enJVJM8WDasIrPiBy2kgrZBqKKIb3HeHg=;
 b=DwKvmgxlH3ixyrw3ThPKCVQXmbPhJBaKeMDBN2XpNOY2t0AkKxnkdBJKASfjWtTn0sOy5Zo5fqYaaHWhd40B14bzPzHYR9tPmMdnw3CM+zx7GfUWHbM539yqGTWm+C1IwGzxAi530fHwJP/VizI9KQQKC+swoPFlROVvL8K0Kng=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 07:57:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 07:57:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: RE: [bug report] drm/amdgpu: add init support for GFX11 (v2)
Thread-Topic: [bug report] drm/amdgpu: add init support for GFX11 (v2)
Thread-Index: AQHavoDgqPrn7R7TdUqrdKnu91X54bHR5Biw
Date: Fri, 21 Jun 2024 07:57:15 +0000
Message-ID: <BN9PR12MB5257A040D6E4F6F2D917BBABFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <de2c1169-4787-4686-96eb-f5d7c1323494@moroto.mountain>
In-Reply-To: <de2c1169-4787-4686-96eb-f5d7c1323494@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3ac414d1-3848-4696-b01a-5d47127eb55c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T07:56:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ0PR12MB7033:EE_
x-ms-office365-filtering-correlation-id: c7b88857-d68e-4c2e-8835-08dc91c7c489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?9j0aefIHNFXVJJVXQwvw6vvqjvjg+TC0WWGky319sFpZjuPKahTlCRYdvDwT?=
 =?us-ascii?Q?Fy0hxMpABCvHk93d8GkkCa+m4HyytMUF+TtBh3LNocGJRx2EMJe2fvShaVD+?=
 =?us-ascii?Q?9Uvl27m0bxlMtsD8axuzIH5E7KxhuQfK9YxRYNEvQpRIdcGp5m4XFNznz5/K?=
 =?us-ascii?Q?YgXXwUIKZgRwrEugLWqMfImgZt4E+pKmZOtOt9xBseE0985+cTWgetLWZG8T?=
 =?us-ascii?Q?jaHMOFRQUOCyDaEjfJGwK3hVq88kw7qK/wKJziD5II4uoAbzHU7q0uy3WBdL?=
 =?us-ascii?Q?rSvVO3smgfs1v8QV7ShX+zCeY6S8mnENvOBfj/3lXCpUow7NgNlBgakOjliz?=
 =?us-ascii?Q?JlDUbqPzXT3ZMnsEk80todgeypaJPy5cSpmeG0qIIkW7PmKk856E6FC8+NjN?=
 =?us-ascii?Q?BCDnN1tZqMo+/6StNWh3l5onMjKHD/OHLuuZHNO/7TZSunztHDqCz5F5ocrM?=
 =?us-ascii?Q?HgW9yEJY8N1M6g+XzRNZHGAoQb9VxtcXwmoJC82ZAmsALDA0tTrlLjDxNUek?=
 =?us-ascii?Q?kOGKx6fwKpG/UAFs3HfDRQs7wdad3m3e7Yy/L1Hl/GCMdmPH2BM81S50XvK/?=
 =?us-ascii?Q?w1DDyoOfjtBLEviHgulcq4nvyKlm0EpZTBxB2WoZOEM4K36e1ml+akivqnv1?=
 =?us-ascii?Q?1L9f1eQUYPjuN5q9F3N/KuFwbNXtixkIPDYRsk4UTtJCLgwlO4p1I9zIaeAq?=
 =?us-ascii?Q?gy1pmnS2mLZaERrI+ewWiNBWGIkfl2amMrT0ZPsn6rEq1+3KqlONnt3S0Kte?=
 =?us-ascii?Q?cIHRsosvSCTkLSzctOcoUzQhwUqdWmiafPgZpUz4UGC3dciGVRWkZROoEhSK?=
 =?us-ascii?Q?wmnfwugLKEc7lpEg+ciy9vEs8kCoHZjP2qNUKY4wwNKWHkWdYb1yIuUKJzQu?=
 =?us-ascii?Q?wfIV4GxjQ9POu5UOpyD02iTHmBer+UZ9IQ2KmVac21arf2lhE07KKkRO8YoD?=
 =?us-ascii?Q?f4gsi/iExU/65oGETsULPgUCVxr+sN/vVN/DGRDTakEUduD6i0ioo/274LhY?=
 =?us-ascii?Q?3620A5dzpETZXb/4LY45UWOVtxbXxFC0Fy/fUdKcjd0+ZOnhgCetrlgZdR6S?=
 =?us-ascii?Q?vCoizulemXrl6dh5oerCUKCVQn9V3yswHAevhIRnxyD9c4eVuzJtZN8UDiWG?=
 =?us-ascii?Q?7jQF3vXat2gk9Q+FDKOVMx9oHQ/E2ZdSswH4boo9KOJtPo+yzkBfqKJR/JpV?=
 =?us-ascii?Q?MsNLIAolEbFlQWTLtl3h1Rril7gTsRNyym/jOdX6DlXCurL1c8MWJP5WvBm1?=
 =?us-ascii?Q?5akOAmYIyTBG1nPe7YY2sNUFXrHmRHUT1IYy1/xbx0u6F12oEK2b07lGXaZE?=
 =?us-ascii?Q?yQ8J+ADDDlV434VNrPq3MJ0CphOg+PUnm/KGvR1+9AkqKn3IQmmqbXAJ9SDQ?=
 =?us-ascii?Q?W0Sb8lc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(366013)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnZJLIRyA15jCVhg/mFJASfOyiVEb7ZdikBeHU1DXMZPEedAriQq2Uop2AeA?=
 =?us-ascii?Q?rLqteqWDraYreDJs39lCQ3lk5bk7ddDAcXlCjQJoSXsuw8R3RHD0/CnnqZ5Q?=
 =?us-ascii?Q?oVw9ubgN64QL6u5JbLN2sopl1Jx0rYgQAFBTrkjoclT16MDeUiAWhTFo/EPc?=
 =?us-ascii?Q?5Rkksxcq+/re/+NdYRs1+XXyitbENJS44k7pgLkUbpY9cy4VaEh6DavlUfJ7?=
 =?us-ascii?Q?zvasEtYK34h++mH3TS3oByWfBsi6bRoNlmS1j8lhT7XDWO1EMVNRpKCxv1KI?=
 =?us-ascii?Q?9Tsja6o+lFdRzARoZt6biKxWWe3ny6KkCaUwXGUH2z83LEL/lx1s8L2XFyU3?=
 =?us-ascii?Q?A4L7ojQtd2vfi8CbgNZGOYO0CkcyTkzBS9nKAzreXCpZw0OWVkqyOXvkYD1R?=
 =?us-ascii?Q?gwUKoOerFcDFjiica52qKDCt96iV9ZUTs+/ppRHAXJaowZcKxFv2KQ2LPo8L?=
 =?us-ascii?Q?JTsYzxUS4gVbcbH+zQm5sVtey4L3u5sTPOfshf1fHzAj1EyvjmHMZd++Frf5?=
 =?us-ascii?Q?dmxdc2wovVy4Y+19A6CTAkHSFNztuDG5ZQYB5qpkTB63q05l1sht4zzMZSm4?=
 =?us-ascii?Q?fvphuH3I5BjkL+lMQP/TrVoPHs4gwi9Vy/ysHRC9FzhBkIPz8KZiUYtEXJWW?=
 =?us-ascii?Q?omUDdknrdgxSXpyfK4ONd6tn5gWXzO04u7KlCu4Z/3LqrKc1EZvijU6z8qIN?=
 =?us-ascii?Q?wyx+cEtkHptfqGqOuxFBzMEAqfoB4uho2dtGmZ0LwrG7exG9+kWRSWQUljtZ?=
 =?us-ascii?Q?03O3DrHIlN/tfZuymsJe3KkFMqJpbPoUkWh5X/m2BDvWjgT4nvM4YyVwbE2c?=
 =?us-ascii?Q?tSO++riBqrbS7OExpjivAu3IG6L9D3GIEILgM/l3m2LmvE5IlT/u1WIBSkL7?=
 =?us-ascii?Q?m4CoOREzcf1fzOyysWR1lkCTVk8Zoj5ISwUfl+5NtlPzg5fkAFb1cOWS7eyT?=
 =?us-ascii?Q?1L9zGHspwZDGby1rn1IitokijIVTRZsF/b4lqXw0/qGo5ZGAgbz1nFm3VBSK?=
 =?us-ascii?Q?T9mNL2c7cftsEZvDF92nYmVsRkrju3zM5a6iZppPTm3VKx+z+bz6rLN4cjcV?=
 =?us-ascii?Q?sPzXiGzFG97oi5ho1lJZ+tyDlGGQ9Oy3x2ZvJ/merYseDZJEi39e9zKqG4F/?=
 =?us-ascii?Q?raR2OgClfU93YZ1TjzeILQtn5g+tTL8JNTiLX6T6xdwyeiZmxGk9kGb3co3b?=
 =?us-ascii?Q?IHLzkFRv93AYb1xQzZI+WQ2cu80qWyh09t/E2BPOLpGs5YEXGZ+6XnHI1Bkl?=
 =?us-ascii?Q?svXAtE+yLN35Iw1MwggBtbsjjX7WIzhZfBdFHfhucfi8LNbngXO2NBFVhtdE?=
 =?us-ascii?Q?Lr09TTzIuLCPsRJozaaVJX6f7rIR2yyJ7OMqIaQTYWxjOdD8ROFK49Zkr2Lw?=
 =?us-ascii?Q?zqB/fuLjhUXR7gomVLSmR62YorWa7VfdXGpeWTx5ecWPDUA6uXl/TE+ZjYmF?=
 =?us-ascii?Q?nmUZf3wkmz2fWzUxEVbEu48wLBPe2u+qt0cEkoBOdVok68/S7XSE+vxLN2PG?=
 =?us-ascii?Q?/I8uS2j/Tb7J2Ha2Wswnr4PyZRj3GoDF5wKIXCTMueu0Dby950hx81eED6km?=
 =?us-ascii?Q?oJ+msNOGbJ3XIm3pboO5pivAxNxnQe3gvtQgo6uF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b88857-d68e-4c2e-8835-08dc91c7c489
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 07:57:16.1176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gNcshHrzt1LjiG5/JNdWZOd6wXCR45UuGNoynKK/qeNJxEsBGoP9vUMe/TSUiHlatLAh7OOBCrrY8KOOAxC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

The fix is sent out for code review.

Regards,
Hawking

-----Original Message-----
From: Dan Carpenter <dan.carpenter@linaro.org>
Sent: Saturday, June 15, 2024 01:33
To: Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMU=
GAM@amd.com>
Subject: [bug report] drm/amdgpu: add init support for GFX11 (v2)

Hello Hawking Zhang,

Commit 3d879e81f0f9 ("drm/amdgpu: add init support for GFX11 (v2)") from Ap=
r 13, 2022 (linux-next), leads to the following Smatch static checker warni=
ng:

        drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4503 gfx_v11_0_hw_init()
        error: we previously assumed 'adev->gfx.imu.funcs' could be null (s=
ee line 4497)

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
    4491 static int gfx_v11_0_hw_init(void *handle)
    4492 {
    4493         int r;
    4494         struct amdgpu_device *adev =3D (struct amdgpu_device *)han=
dle;
    4495
    4496         if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_RLC_BAC=
KDOOR_AUTO) {
    4497                 if (adev->gfx.imu.funcs) {
                             ^^^^^^^^^^^^^^^^^^^ Check for NULL

    4498                         /* RLC autoload sequence 1: Program rlc ra=
m */
    4499                         if (adev->gfx.imu.funcs->program_rlc_ram)
    4500                                 adev->gfx.imu.funcs->program_rlc_r=
am(adev);
    4501                 }
    4502                 /* rlc autoload firmware */
--> 4503                 r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev)=
;
                                                                    ^^^^ Un=
checked dereference inside the function.  (Probably just delete the NULL ch=
eck?)

    4504                 if (r)
    4505                         return r;
    4506         } else {

regards,
dan carpenter
