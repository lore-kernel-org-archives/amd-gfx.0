Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E400CCDB474
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Oct 2023 14:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6CD10E1F8;
	Mon, 23 Oct 2023 14:26:21 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F6B10E1DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Oct 2023 14:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSGV3scaP/bl5ytiaROVm+LrE6XGpPYwpq43YFbVX2VF/gHOVt0FD78LZSKVTdf7PlQGFNv6VlrkDgufEOoffnsBhZLyVj/mEu/lgOsdIwM2Si0CvPaMrVWRwF3iKkdjD2azBpMaqEOGG/8jM8zSqRoRdgcxVnteMGOIkJ86qKyVXvHPvSgRzZrwhS2Mp7SZQkjSSoUpDVWVy6+nOUIr420jm0qCBf28xrABplRJpS4Dd8ISnMwZ7y0Uq23eW171v+b7k5mxeY0NKEeY1BtJBYR9TI7U/mywx/M3vwkaBjhY2Q75ZSU4PYy3RvvNifTZNpFmbnckJzj/lKlOdbhkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNBZnwJqYD0EgoSY2kRszW6ofrZHrr9Oml62yGHYHfg=;
 b=eYmfU/ZcoENqINI8gz5Hfr62/fSiMSCOvaVh4fmFXdAWakbgwCXTKfcuB802BWG1cW+q+b1ebe4eSbyb9IuDjBZXhbGvyj7h3ARM0FbO/B7KGEx+LZ0xZLrwfzM1ZXznP+6KUBs+lSBMW6L2ZcKpG0XeFRyKVRuFIR5KZ7VNQp4ZxPUtj9KKITpbCfjIOAp7i1Zf3Mnp/OXxslqeQ9gY8vADm2UdEvJDIDjg1ZldTaPjld/bNexl5c99e99oOjsjvsC3ChNymTnMPtn1vNfAxr5RcOeQCxCGH5Sub7vV+T8PkJ7PiPCwZxwy0G7Dz3WcXQaNPbxcj7GoAchUBfgxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNBZnwJqYD0EgoSY2kRszW6ofrZHrr9Oml62yGHYHfg=;
 b=d6GkC5zrQx5Kp1emHM/kiuWe44gpdnTeXhLMAGJ3DneBZzjdudi4M+mHXhDbGUKmMz+tYMn/PYsGr7omOiHWYWr2CM1n1p5v4anhMtrtEeZyw5oP1xCvZPm0hR3oW6nSBLONYhVtvZGxTY1YXaioGgBe9S7XrrD59gk2uJbPMUs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 14:26:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 14:26:09 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
Thread-Topic: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
Thread-Index: AQHaBbdkSt8gL7QWBEmDtccGWnu5qrBXbQiAgAABEEA=
Date: Mon, 23 Oct 2023 14:26:09 +0000
Message-ID: <MN0PR12MB6101B7321A2413A69C7305E4E2D8A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20231023134514.144863-1-mario.limonciello@amd.com>
 <BL1PR12MB5144924B8B61F0EF0891C344F7D8A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144924B8B61F0EF0891C344F7D8A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=444c7aa3-b335-4eaa-8924-b44bad3e3880;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-23T14:15:53Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|BY5PR12MB4177:EE_
x-ms-office365-filtering-correlation-id: f2c6c777-f013-447b-b783-08dbd3d4008e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KCwAcVPQyYjOA/EbQqiW5zuiCCyW8x+jFslWDysZmeGiZ+4hSV4yC7hDT2CPHlyJ8AsyxbmnJpwYiVdfgCCkrxpKPYLBTKyKx006v/JNEm3et7YBMDKhi2ANLfvTDjpjpoYKWml7+cUy6eAP7+OXp3VBaSXDQ8pEETL1C+u27D/NiG0b5GbiiunApnBXABnXDpaWUtmuGzfJ7BoFeqi54n9e/fEHhukAp3xbMne5RqJPL1uswpBr8fLF2kQSNhJekDikB+c0FfJvM0ySR/+EF9QKIfzg539ZGQ+byGGGg8MOa+Dx8RawKeMNrGJK1ioMdu5cQAI+nuFJEhYbe2hgf/r1GCIi2VYQaXkpohZ+QT1SaSnVuqQNSRr1p2M7pgL+4uphtK2hmfJfDc8Fv+TLgEJokHIp/pJPeB0JnhU8Gk1Luzl37Q0F/80cYSsNrsuJgA+aQK2Oeawp08tVVNiGcxG0WCm1TEZOiGAvL1CzKClLUeXlagx9qPvvP6l3rKnjYt96SpSihwrwMd9Ebw0GLClJJvGXOWl57LH8XW1Vh2Jqin0FOLbM7GHN1wB19cf7SIpS+6WKTT3UOU8vzI16a/JW1WcFj3thp8t0RNtFzS4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38070700009)(2906002)(9686003)(7696005)(6506007)(53546011)(55016003)(38100700002)(122000001)(86362001)(33656002)(26005)(41300700001)(478600001)(71200400001)(966005)(83380400001)(8936002)(8676002)(52536014)(4326008)(5660300002)(316002)(76116006)(66476007)(110136005)(64756008)(66556008)(66946007)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kghppwy3C6E3ZZbkSTTuU2hQ4ottANajBZXAxw2ybU5cjkLkn6qxL/eNCE85?=
 =?us-ascii?Q?Mbh0Y2x3yxrPV2EG4Itr4S7ykXnOGot1Te2654MiSt3FdGAzuKpXCo1mdoIe?=
 =?us-ascii?Q?ojHvwHd+milEr0PCh8EEjBYOPyDwquQHYp/K4kOOqYbUp5nr/FgTY2yeKjoX?=
 =?us-ascii?Q?GeMrvHF4QUAkzYbldA4Tnu+9nTfGaYkD+yYVzj2OxxuMyq0yc8gyWueS5Lh7?=
 =?us-ascii?Q?kllWksoYrJ8GFgc1mk+YbeLF3dePe+WETtAgopGG6V5sJw655bQJa9Ae65tU?=
 =?us-ascii?Q?HN6kbsposv95oE0erpgFtaaexFWpckj5KogdVc7fNynvYs7PKz1bA9KPoUIA?=
 =?us-ascii?Q?M92ayc6CBkBsTTuXYLSBI3QEwQZiC+9cLe1+bzLaJjXGHWHjCDxyvAY1qBL+?=
 =?us-ascii?Q?yAxDpu0rXP6y5oqeffSGDXqH/cVAxoug6sVbbrhbej5iijvJOn00JjkdmN4Y?=
 =?us-ascii?Q?s8OWjJR8S5+SnsvObHF+duHnk9eMnLsOweo3qG4mU8DYy13pP3t3RjvxDN/o?=
 =?us-ascii?Q?FJ6xojepqtX/poXASWa6+R64RpXI/XwoEZSjDkZUX4aOkhXKpPjvV1YjC8KZ?=
 =?us-ascii?Q?jyilmvdEKRoIKHQm93lQ+XTyZAtmsmvj04+k7wazWSi8r2K8FZfTJQSCXPTl?=
 =?us-ascii?Q?U/hEv5fuu/t0e7xPBlH9XcCbZx69kLnARKZJGuyWMxoqyqrB5fjXP0wnXB7c?=
 =?us-ascii?Q?1yue6t5AUEN2sj5fIXDdwmfxttbF4IsDTzs74sM17jqRFVhxkI8reC6cNIch?=
 =?us-ascii?Q?SYD/D2rgaj+2DrmwIj05CoRtJl5fBNuUM4/6TSqVNQwGQQTiDeKZR7iNhxn9?=
 =?us-ascii?Q?+zhR695w32hfTM/sEpeKQbMum8DHmm4ab04OeXRDwDnedIBVltIv5QtSrayn?=
 =?us-ascii?Q?0JJS6w4jrKeRbmE3nbMCdUq4vBQsPeu+1mjogZB0hwHNhb04rJiFP8srvuxQ?=
 =?us-ascii?Q?pPK6QJ1UzXQSvsoCt4XXYYN5PBo5cH1WMlbqClvrEIr0LiRSWs5ZOqgIPe8e?=
 =?us-ascii?Q?VnvNnOndLVyfv1B3pOusPgWcqqfx9sniCrsorLeoXXJd2U4N9CMqIzuyhAlp?=
 =?us-ascii?Q?sutosxtukMAtrRSb6UCvO4FUb3CGVNE4rBcpDpYeTbcG//2K4ML5p0vViiXk?=
 =?us-ascii?Q?ecUgY1khcQWLyy/lHdhVAqoZWwiDYNzA115+lBO5ILM2GqU9FFhv0OwS2y9u?=
 =?us-ascii?Q?KGt6G0HLtxSIFPrNUaVr0sB1IJnBhVHwCapH6aVMpp83jNrjA1//uzu/GUI8?=
 =?us-ascii?Q?abyybDygjx1AO1cWUcqKp0nbREf9HYy4MEVrbeOC82eQ+o9eRksv/t3jRotu?=
 =?us-ascii?Q?1aF9HmUSfHh6wXvQzKQvxSKLX+AoyYINwNU79iNeyqkF6M6th4uU762PKQH/?=
 =?us-ascii?Q?XeiRuFYQih3c6cNUo+9JlY7hSPfpqjF1WppKB21IQVrAuSVCCzg8UMFq7Kut?=
 =?us-ascii?Q?BcZQzqLhUYkrW38fiPmlW0INuGt3HOyXjaETl25DUJ7TI1PJi4vbwxY8e9nv?=
 =?us-ascii?Q?ENyQjjsMICw74cz2p9cBjxSPJpXYuarue9JwYyc6xTIpkpYFiI/xb9PfiLEp?=
 =?us-ascii?Q?Zx5SNx3g9MdZmFPmYAE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c6c777-f013-447b-b783-08dbd3d4008e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 14:26:09.8564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qC8xDmkBS5hqDzz7lum1xqLomenoOvOQ+2H6Y0O7n+5mClq5u2A26eqWNINfRQiW4LVaMMD4MIoskmf7CcI1Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
Cc: "paolo.gentili@canonical.com" <paolo.gentili@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Monday, October 23, 2023 09:22
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> paolo.gentili@canonical.com
> Subject: RE: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Mario
> > Limonciello
> > Sent: Monday, October 23, 2023 9:45 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>;
> > paolo.gentili@canonical.com
> > Subject: [PATCH] drm/amd: Disable ASPM for VI w/ all Intel systems
> >
> > Originally we were quirking ASPM disabled specifically for VI when used=
 with
> > Alder Lake, but it appears to have problems with Rocket Lake as well.
> >
> > Like we've done in the case of dpm for newer platforms, disable ASPM fo=
r all
> > Intel systems.
> >
> > Cc: stable@vger.kernel.org # 5.15+
> > Fixes: 0064b0ce85bb ("drm/amd/pm: enable ASPM by default")
> > Reported-and-tested-by: Paolo Gentili <paolo.gentili@canonical.com>
> > Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2036742
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> As a follow on, we probably want to apply this to all of the program_aspm=
()
> functions for each asic family.
>

Yeah; I had that thought too but wanted to have a narrow patch for fixes an=
d stable first.
I will merge and send a follow up for that.

> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/vi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c index 6a8494f98d3e..fe8ba9e9837b
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -1124,7 +1124,7 @@ static void vi_program_aspm(struct
> > amdgpu_device *adev)
> >       bool bL1SS =3D false;
> >       bool bClkReqSupport =3D true;
> >
> > -     if (!amdgpu_device_should_use_aspm(adev) ||
> > !amdgpu_device_aspm_support_quirk())
> > +     if (!amdgpu_device_should_use_aspm(adev) ||
> > +!amdgpu_device_pcie_dynamic_switching_supported())
> >               return;
> >
> >       if (adev->flags & AMD_IS_APU ||
> > --
> > 2.34.1
>

