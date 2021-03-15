Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBC3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1957264F51
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1957264F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F90D6E15E;
	Mon, 15 Mar 2021 19:24:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9355389F2D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij3puIpJtu/asqMyk9Jd9F8Ksg2VWKhbhr/6qPde3QtPgBn3O+zjO++cHj4/euEOUwphmQT0+AFJCDLLdNXGZEtqQmk5ymrjS5LOcGcldZ+zrslhtjgKRSQAPivLeD++bZVF4pDuPRotDhUOVEftL4cg/xvJTPefywv2g+3HkqAk9BKfUbzi1hfSENqtXAtNe0LBa5HbmtJBYmrx0x17s/J5ruhsGFc+WjlS5cvR2svOSLVqI0Qd8TUdK70wpaKTk5MjSEdRLk4DLbjV0XufSOkxmxGqPtN4CoaEwWBjc6Bk8foZ9hNply2+4qe9v1Pyy8sfALXpHeZBEvWhjjWgiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJB86fRuog7oHHdQ/UfoeJBV5L3RjVjZDEMOnPSBsdQ=;
 b=dFACxh7VMwmPv7I8SHsICqccs57W/2+dlPAAPQcczeLBz9hpdfxMhvUeitN6iQ7ZvntZLcnNl3o2RdwcJ6BHyvZ6xH0u1pe831HeOwUdKfx5sFv9yOf4nvIlgG6fR1KrVRuPUGXG+yMQAC9BgXADv+EpSxFBKQ9wOEifDPC6FHsqpVjOcSfg+wSsYN37VNmx/yPxk4HHl5JiJatv6N6FaQgYe4m2KH6Y16t2jwBzSInTGG0tFoI1ubPAO8uPpwkwU+ZkHIcgc8cyrq6tqtX2hf60yg6vrIDnCrBJ7g9IMXstiqTM6zg31nCv27NlrinEueoGUCZiF0bHSzPiGPl08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJB86fRuog7oHHdQ/UfoeJBV5L3RjVjZDEMOnPSBsdQ=;
 b=EjZufVxxbwUmOWQPJXJkLBm81GQTZlqDazZfLHnLt91qsPMmOQS/hicXpbIruvm8kM65O2whH8bfX3WwxkREwz5BnreF4bAbDJKEQksDUsjIkFuGLzgm2dwxMr3zOGBUUlsui53oxzglJ3N2yj2XSTu6bOuVVLtQ3kmklps3RDM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:24:26 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:24:26 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
Thread-Index: AQHXFia5I+1Uep6oqEqhvw5i41r0XaqFaZuAgAAAwuCAAAjXAIAAAaYA
Date: Mon, 15 Mar 2021 19:24:26 +0000
Message-ID: <MN2PR12MB44883D9863A8FDBB15A9927DF76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
 <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
 <MN2PR12MB44889671D32DD33422D00820F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <d05f8abd-312b-5f30-5045-e17b7e4066be@amd.com>
In-Reply-To: <d05f8abd-312b-5f30-5045-e17b7e4066be@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Oak.Zeng@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-15T19:24:22Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=08f35100-7ffd-4862-8cab-1697bdf84123;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a027b207-1898-42e3-6d09-08d8e7e7f24b
x-ms-traffictypediagnostic: BL0PR12MB4915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4915100E76F69873886E416EF76C9@BL0PR12MB4915.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1eBVINsrA3OYaqOkbKMjGsg2Fes9n7zlmIjZEPBRjhJKvcNfCXU9bKFN4yzX6lhPm1Nqt9uRmM9FIa3R/eOktb9pmRavVKSrUMnKRlCb/GEqg0lERGzIOS5Tyfv7ke9XF9pGAvXghhs3IHDq3Unpl0+GPJs1gTrANICcX2abpweewEMZDLPHBev7QUrTFn86zzHLMIBD3JFQHTlSUWXSg7iOgOvKihKTG1ROyPNVhSG2peGDIJWftLxYZA97f4eOHMn6+S5bG2Xsf1nUMK8kUNdJkComaTBtWSGC/Xk/olMgHbNOr4vbBY6QY6eh3mPtkU6cjzhLmM9QFZNou5imY892xzokUo35z6jk1KiqQ0oReU79ELwcxVbg8HGJiHw0Bky0YmFhoV4+6tIfc5dLKkLsetcOLRcitkivWNfASDQsW3tPU7dSVRraHtGRx6m40RgqAuxC2dP40mDwcGhZHNxyQNnxp1RpDdMbsE79UFPT5uRZrgyx3ce/UMNNKNWptUW6tRnsf29D4IAmiLAb91OQhPzcXT820n6j6yQfzYKp0WpS7jzcAuD61drPEzxA/lSRezFuCHUONBrhc1UqODHalblJlTERTK8CF6w6tyh1C6FqM58/N08xVwbKOFAllFrW8/OOKh/XE7nN3SCtCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(5660300002)(8676002)(76116006)(8936002)(7696005)(71200400001)(52536014)(478600001)(86362001)(66556008)(66476007)(966005)(66446008)(110136005)(83380400001)(316002)(53546011)(55016002)(186003)(45080400002)(33656002)(9686003)(6506007)(26005)(66946007)(64756008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SnVON2gwQWx6ZTBnWG45NDVGUlFjSUpjaFFrKzdROW5CYkVBVSt2alUwT0Y4?=
 =?utf-8?B?Z0duTjZ6dzlmQXU0bEhWQ0NEQzhTYzByNUlLVm5aVFN3OU1pbkN2VnZsK0RT?=
 =?utf-8?B?Zjc5Q2VxQkZLQnE1OVREaU5IZEU3a25IQVlHS0RMVFBFMDlhMEhuaVdzQ2M2?=
 =?utf-8?B?djhRU0tjelByRWp3RE5hN0h6c3g0ZENEWHBKUXBmK3lNVVhUbUxDYzhzZUty?=
 =?utf-8?B?czZxUzlnbzB4ancvSDJJbFM5VjAyNWlLZHVTaXYydWhDZ0tPbWlMS0hHYkhv?=
 =?utf-8?B?bzcwT2tsUE5SRWRDMENqUzNCSG1MejhHVi9zbVVNRVY3UzFVc0g4Rnc5Tzdk?=
 =?utf-8?B?VGwwcUR3MnpMbXBsc0NwMkxLSHQ4RFUyWXdzM1VuemRDVHFUZWFTM1lOdU5D?=
 =?utf-8?B?NVFEKzNIcTAvakljMlBrQ2hFRkhLNjh2MWlucWRYVGx0R2R0NU5Sak9hSXkr?=
 =?utf-8?B?cjYxdFJsVitRSUpVTlF5Y2k4QlAxU1N2YnpWTlFxWGlMYUlNbFZvb0tZVy9a?=
 =?utf-8?B?U05YaTMzZDZlKytDaVl5NlNVYWI4OGR4VUUwK08yZjhDR1NkZ2dQaGw2Rm54?=
 =?utf-8?B?cGFheWUwSWg5R1Y3VHNJeUtpUHNWcHpCbDZmN1BiaCtpajJaMHYvb2s5dGcw?=
 =?utf-8?B?MmU5QWVadUJqU3h5N1NtNWFBRFpRamRaSlIxSnlHa1BzOGtMNDJoYUNOR3NL?=
 =?utf-8?B?b2dmVFFhWWs2eEw4eGplWVo2WWkyZTZIbU9CaTFJaW1TUW4zUC9PZG1OZWQ5?=
 =?utf-8?B?TkJIcG9PL2wrOHowdFdIeWN0VTE0UUt5WmxhcnVpSERUQVZjeTNsYkViTGlL?=
 =?utf-8?B?NDNubE1oYmhVOEVxUk9sdi92WW1kSEtnblVydzZ2dmhkMkdXUEJ1dWszRDkv?=
 =?utf-8?B?S253RnZqM3lhOVEwdTIraFpWSEVQQ0JOUmltNUNBZmMyTWw3ZXlCWnZwalB1?=
 =?utf-8?B?cmlaZVRSZVdybXRaRVJqSGlwVDFRaDBLR0NMUFJwVW04Z3NGcFU5VVgrSXpv?=
 =?utf-8?B?ZEtyOFdIOWdFQ3NGNm1RVTZuL08ySTBhSUd3MENWaW05N2Y5amdDbHVYbDd1?=
 =?utf-8?B?NUhLNk5GMkdQcEhNSVZ0MnFFY0FMU3VxRzZNTXZDMjFiU056TEJzdVBaOFRz?=
 =?utf-8?B?UTRFSTR1NStMUXhoNTFkQ2JqSm52K2NGYitOVkdVWkNWWXMrdnlRa0VYQlNF?=
 =?utf-8?B?QnRLOFdaWWt5eFZWRmlDZ295WVYyQ0sxcWpzbHFLdzVzODVxRzhzTkRZS05u?=
 =?utf-8?B?WlJQQWtkSkdKc0JqWGdzTzAwREE3VlNJcWtIKzQ5ZjN1NUNBZTRIcGxtSFF4?=
 =?utf-8?B?NFl6Q1NDRXFGV0lTWXpMSWlYRFRGbmxqZStXdDZzaml3Yk5LMGVVZEJhNk5D?=
 =?utf-8?B?a0UrMVVVc1R5UEdMN3JORWFWcnhVN0syR0VrbDYwM0cxMTJSdWlVaDNYQWVV?=
 =?utf-8?B?NTVXT1lIbzQ4UDB4SXdpOUIrNSs5U1NnVDB0Y2lPN0UvU0xBTUdrb2tocGYr?=
 =?utf-8?B?UjZPMmwwYkdodnBuUjBWT243bGx5MWtWTUNWaWRmbUoxSHFkdUdnU2VnZ0tW?=
 =?utf-8?B?SnJVRzZmMC9VNm1XRS9ZNW41OXBiNnZFa0FIVld1bGF2VmZyeEY0SzdDQmgx?=
 =?utf-8?B?a0g2SmVEaFR6WFhxWE9Ka3A1WmNKVEs4L0dFYnZnMHoxOURUSWFxa2ZoN1F3?=
 =?utf-8?B?ZkZWSk9oNmlnN2k4eUV6Ry80NFRyK2RYUFJNYWJlbFQyYlV2aHZyWWgxbEpX?=
 =?utf-8?Q?HSINHvMQxE/mZ97HAo/PSl8MmDKg05kfDvUAlUA?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a027b207-1898-42e3-6d09-08d8e7e7f24b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 19:24:26.0281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MbDigOW06PkyocIYIJNYX2beSY7M7oNKCv2P3ihrxtdQTlHLNVUHsqKw+sGrmfxL8CicZ7KjiYBMJug44b+p0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
> From: Das, Nirmoy <Nirmoy.Das@amd.com>
> Sent: Monday, March 15, 2021 3:17 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Das, Nirmoy
> <Nirmoy.Das@amd.com>; Zeng, Oak <Oak.Zeng@amd.com>; amd-
> gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
> 
> Hi Alex,
> 
> On 3/15/21 7:46 PM, Deucher, Alexander wrote:
> > [AMD Public Use]
> >
> >> -----Original Message-----
> >> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> >> Nirmoy
> >> Sent: Monday, March 15, 2021 2:43 PM
> >> To: Zeng, Oak <Oak.Zeng@amd.com>; amd-gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on
> >> architecture s390
> >>
> >> Wouldn't this restrict amdgpu for only x86 platform?
> > This particular case will only be x86.
> 
> 
> If I understand correctly, we map all the VRAM at startup to avoid
> 
> mapping each BOs. Can't we do that for other Archs ?

You are right.  The else should be CONFIG_64BIT not CONFIG_X86.  @Zeng, Oak can you fix this up?

Alex


> 
> 
> Nirmoy
> 
> 
> >
> > Alex
> >
> >> On 3/11/21 4:29 AM, Oak Zeng wrote:
> >>> ioremap_cache is not supported on some architecture such as s390.
> >>> Put the codes into a #ifdef to fix some compile error reported by
> >>> test robot.
> >>>
> >>> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
> >>> Reported-by: Kernel test robot <lkp@intel.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> index 37751e7..1091585 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> @@ -1817,7 +1817,7 @@ int amdgpu_ttm_init(struct amdgpu_device
> >> *adev)
> >>>    	/* Change the size here instead of the init above so only lpfn
> >>> is
> >> affected */
> >>>    	amdgpu_ttm_set_buffer_funcs_status(adev, false); -#ifdef
> >>> CONFIG_64BIT
> >>> +#ifdef CONFIG_X86
> >>>    	if (adev->gmc.xgmi.connected_to_cpu)
> >>>    		adev->mman.aper_base_kaddr = ioremap_cache(adev-
> gmc.aper_base,
> >>>    				adev->gmc.visible_vram_size);
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> >> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >>
> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6fab18a743
> >>
> c84b8abbd008d8e7e21e10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> >>
> C0%7C637514305648085244%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> >>
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> >>
> p;sdata=KLYRSc45rllptRvyiOF18qA9IFt5zAGXL1zsHasgdLs%3D&amp;reserved
> >> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
