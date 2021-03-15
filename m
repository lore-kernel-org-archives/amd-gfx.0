Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73488C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:46:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E9C64EFD
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 18:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9C64EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D5189B01;
	Mon, 15 Mar 2021 18:46:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E0989B01
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 18:46:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6wrCFeDk8PQoMpD9FAtGljn0F5C/6/KS3o2lsapKvt+vgf4yX/x+bIBibEMNZEr3YlvHl43JnqYywfBnigqHDkUGa7hGnFqQfKQ4WQljl3SSHGXYh0uPfQDWPcg1nxP0dY5WkcNc5E6Jfv7Cr7pT448L/0rU9f3hWonAeMvdXJQJ5/s6bhvK2O5p++WRcoE1RO8Fhq3rGba+/Y7bVmo3DJhkeQroBhFxV8GJmnZON+NJOBWlcAPOdOJeahAtgTmmelWrx2ygNClW2sXdNZ6O87JRlGJSphae3cf2FdG70oszmlx9rXzuhZXwQOtlpIDAV0D4A+4WuvvmuNt5cNITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5aHwe/hdhBgu0JOpDPaUAejrEwa0IdwGDv4gEQPlWI=;
 b=AjzYLx0ZEhO27HnHvVTc4MBj8oKYi4kPdO2eaSHZaGskMoEC7bLNc1kszxcDbkdc5Yh0eHCs9wS348TgLu970Vn+y9GdDWYVo15z4J0PqdOYM1edHbTkTE2ZJ3ilkqmhIYSsri9AO6jUHH2q9w2XOqvWZxv4Do08zJRO9hmLRS21R9RkfVlWQxGjlNwy6yJFV3QrkrM8UgRQ7wewp1zpznhRL1tHYZjx0vL5thtDqUFAUhuH2A2Z1mIqesjDPBXO9kpaVDp4Fs2lqUBI2ocWvrif76EE+ZMzCMxTbdj4j+zx4AP/+VuG2AFJ5udEzNWxidruURPM99K20okR8YBDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5aHwe/hdhBgu0JOpDPaUAejrEwa0IdwGDv4gEQPlWI=;
 b=Z/Qq4z8xiCh5o/FRAKiKAtfy0bix8y3VqhWgC7VAUrQInr5nxGaAbgM0ZMPFMGILL6VWjPcFJXk3AE19Ye2Hyq6vA8RqRiVJIWr5W6TVZjOG4Emlf0IrPSovHFQBTrlHC5kQsFBylu8ebPnMo11WDuqnN10QO0Qs0/i14O8aqT0=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:46:06 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:46:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Index: AQHXFia5I+1Uep6oqEqhvw5i41r0XaqFaZuAgAAAwuA=
Date: Mon, 15 Mar 2021 18:46:06 +0000
Message-ID: <MN2PR12MB44889671D32DD33422D00820F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
 <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
In-Reply-To: <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T18:46:03Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=710e6055-4886-44a0-a111-bf6d847744d7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fdd7585-76db-4159-2939-08d8e7e29781
x-ms-traffictypediagnostic: MN2PR12MB4503:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB45036109A7ABCBD3020E9942F76C9@MN2PR12MB4503.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Mym8Z2W4zcQRY2SuewJmy0yhXX0njnKRiVSyLPG0C2r0mQg67VtK5RmiSfwL1FPWQj6QtUGnugPatJLYbkstIcAJNCBN8qCBX4kzQ7SBHT7HydebDQWoNy7kFcQByNRJoMkIDPJGQbv8FJzllTZD7zfBBGahTgyuyN6dIk/MRRevHRH67ZOz6QwjUilNj5ncMTHQkGolLGr8BbaYmIZZcOPtdSgXoFbP9iznjmMjAtOQ9J2jF1aV5+8nnB1Rzn79plPoRGH/VX2L9D2stwjH43OLlCQERGIxj3x6j1jXO+qc6TvGNiasDFUow49yIDukmWSTnGd1/t3wmruy0gecBejK6+uzbNg8p1cOIKKv9h5vt6RV4FFrdZyYQVvc+tZ2VOzlu8WjGzY9hajayPTSb8VelT5J65sNgvZmWK4F0sUdlvbyyVAJqpM7xCLFZZkvmkRPaF4TUET9Ge6cdrWE35x6amZmRItR9uDzm1Vymar1VKh8PnJYLPMkGFPhf5mBk82lf9mnt4vaUhF1C14yJ2gttd7txcRVOQy9JgHGgQKyJ+2ANHRpgm1/j470FCHJ4o8z3rwld96+083ICC7JLHnoboqYsfkjZB/YkuDZJVY98GvBbnwExgoe9FqG6KeXSTJGjQasZeuPb26wJcvfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(52536014)(2906002)(5660300002)(110136005)(478600001)(33656002)(9686003)(316002)(71200400001)(66946007)(26005)(966005)(83380400001)(76116006)(66476007)(64756008)(66446008)(45080400002)(8936002)(186003)(7696005)(53546011)(6506007)(55016002)(66556008)(86362001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ucppy7Rlezk83rbmZS5X/0HBalb0mgu8wfHQhcpG7hXxcJsNOAB2IXKXzHaK?=
 =?us-ascii?Q?RHQ8wy4qxaqn/TA9Etnbtz9cKQxrmBW5+JEibYt+AeGRqmhh/b8kracAz8cg?=
 =?us-ascii?Q?X9hbkkMWog0THDn+5EpylYlK/jpbhX4YoQEfF6GYDgYtGgu9bbdI14dg1McC?=
 =?us-ascii?Q?MQN7uH/pNAFDBPIF+8Tt3FcsiKweAcN9JX516s1keWVLS/jg0GDbCVzbZYTy?=
 =?us-ascii?Q?kV/bZySLXnXk02JZykEgPbvEDEsleTTz6sSBbsZAH/rwWY5YL3rvThEbLXrA?=
 =?us-ascii?Q?CSHoXpySKXSuhHlRBIQs2D572d5jwhq3ELfuV/xCW9nruuCZ1sobxhBSdDgg?=
 =?us-ascii?Q?1XPci6bE8QDpP0bm4ju4DZXnJLRW2T6asIFv2bI1YlItaOtSPL04WfZNz5p9?=
 =?us-ascii?Q?x3KLt6baRVftwEcdUmpZBvXGFX+260RAa8jNAOqQfdbPBpDpXJ2E369LswgN?=
 =?us-ascii?Q?vHna4mPFz2aUBRqZVk5Iy9jvnmwp8zF1sq8zyF+572jWFe4yhe+0JsswQO1Y?=
 =?us-ascii?Q?8dN2dTYobl56X+iAOj5TFI7NKdzbg/pWJ15R9YvLIYgfblvPV5NA75CYZlEj?=
 =?us-ascii?Q?mtkHtwaq1LsVcq3Ztt4k90pAYA6ADGPGxWnM+w5utXMN/P1AJ/SPmZzfFZ1z?=
 =?us-ascii?Q?74T1Rc/ZkD5wAr9aJfk7Lv/gpe1wo4v2VBzXZC/ZPJRd87p9PMMqoA6fhDjs?=
 =?us-ascii?Q?lNORa8cxZSbenN5V5SGqYghw1eRxweGEw6mM+5UnQco4yGNlYGE4lDsyTneY?=
 =?us-ascii?Q?xPJCH+S7bXnFLrblKgGDx5/jSWvpWDmn+Hvy6Ss7ApuK6cX54TvpnUFa2XVS?=
 =?us-ascii?Q?yq5yDPgEXu++Tu8QNwPPZtRgV7lbpSbuauYUwIlrwZF91uUvVplLZpC3ibI8?=
 =?us-ascii?Q?Ey2+Qm/Q3+5wPSKyDOLWf8qA7yULbjxS9g+UaUOA2Vx8qc2W9u5DxFZU5o4F?=
 =?us-ascii?Q?UiqGhxNhtwXPSraQcdhTwlL5wob8T/SEezfaSpV7xXK4xnuHBvwCVV/LBpZS?=
 =?us-ascii?Q?kHi/Cno5UBmkAMV5Vj9MgDKEFOsfjPzeKqYEmjzKuW5Roo4jtO53uG4IXNt2?=
 =?us-ascii?Q?Jc3gMz6ESDQa92CHQbquCT8/d36Qz88mD9KtSPl1mI7UJNJPY+9vWZs6vx26?=
 =?us-ascii?Q?5wjUEeLzHAMj7zLwe2S/8yRCnFTxBhBy8yoI+42ZJt3BiFFK5hIUZXjFCRJI?=
 =?us-ascii?Q?Kmx/GgBZ9w5N+T7CzQ3nMfDYVin7Cz96Enc4n9YqqvOtfjlJiT0L20gFUqaK?=
 =?us-ascii?Q?STcfCPlEyb4JLyTHFRV1uw9wveV/ba9PhS2qS9d7kxxcFtxNiOfp6wCql7Rf?=
 =?us-ascii?Q?6VCkrwpUJcu3bbS2bRLhf2vy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdd7585-76db-4159-2939-08d8e7e29781
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:46:06.1821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDIWorLoo1hTbSlAKcHx+PmJM4F0rU1O6gbPzKKpJPcXcSh/nc62PJ6tf560dLAB3J9yX2Q7R+rHAqvn67W1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Nirmoy
> Sent: Monday, March 15, 2021 2:43 PM
> To: Zeng, Oak <Oak.Zeng@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
> 
> Wouldn't this restrict amdgpu for only x86 platform?

This particular case will only be x86.

Alex

> 
> On 3/11/21 4:29 AM, Oak Zeng wrote:
> > ioremap_cache is not supported on some architecture such as s390. Put
> > the codes into a #ifdef to fix some compile error reported by test
> > robot.
> >
> > Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> > Reported-by: Kernel test robot <lkp@intel.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 37751e7..1091585 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1817,7 +1817,7 @@ int amdgpu_ttm_init(struct amdgpu_device
> *adev)
> >
> >   	/* Change the size here instead of the init above so only lpfn is
> affected */
> >   	amdgpu_ttm_set_buffer_funcs_status(adev, false); -#ifdef
> > CONFIG_64BIT
> > +#ifdef CONFIG_X86
> >   	if (adev->gmc.xgmi.connected_to_cpu)
> >   		adev->mman.aper_base_kaddr = ioremap_cache(adev-
> >gmc.aper_base,
> >   				adev->gmc.visible_vram_size);
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6fab18a743
> c84b8abbd008d8e7e21e10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637514305648085244%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=KLYRSc45rllptRvyiOF18qA9IFt5zAGXL1zsHasgdLs%3D&amp;reserved
> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
