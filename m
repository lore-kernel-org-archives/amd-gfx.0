Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EFAC33C99
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 03:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61DB2075A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 03:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Fqr4MqMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61DB2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD58898D9;
	Wed,  8 Jan 2020 03:05:17 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690088.outbound.protection.outlook.com [40.107.69.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F34898D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 03:05:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV8YDbmw2BBRuI/TbWU74L3rt2yk17+v9K9VUDpnmDyjCQyKMgQ8U95y4WvdZp7zrAEHQLTo2xxjRJtHxZjilmfSBVD8pGUPtQDnOPnPuQxPENppHNhBjqMDvnMXdk2B11AmuirZW1C+rKERaW1OSZcApkr+RSt54VZdw0H+HAxJRGWHnyy5RHDWf3jRrn0l1MDPQ0F5R5vkgCEv3MTRz/AK3C2Lws/U+JqQc+uiQW9oNpUT7prfmB9tSZNxbVXKIE/NPL1FEcF+sq9h5y67ncjiKxIROfRaF/Ydh3TKQc6g90JVbTbbHYLNwXfzgTZ+sjnKDxV9adl3YMXyyyynbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVtB1Y7JRvSbcuojjXy7yQVIO9UyAI2wa4/lhGFKl6A=;
 b=e3/4Em2lAo41xfRQfIKVGD8LkMXbJCdjY4xnNCDBiQF4+EzJcfoQwcCIGFuoBaPWtVmg44mEN6vtqIXBRoHw9VIpqssSjEm+OTa9v857gUPoodVaK+DgtMLI6c0AUr/xIMFdavn5ISYuj3yPkBrMz8TBim8yITGuJ5657IW78SFGijFZUYFzH6ITmprjhYQHAxrGLwJN+iF4MdAAtCecC4dh2P0hpNUxxhlvg3vO80laghYPxiqdeTg7K6E7Y8AuhF8YVnC/EeT8rPpfJSJPSwFZE9vAcGjYXB/BY40ORU3bcW8tCaRdJ4mE5M+5gb7ymGsuDHOLzTL1nw5Rn4wUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVtB1Y7JRvSbcuojjXy7yQVIO9UyAI2wa4/lhGFKl6A=;
 b=Fqr4MqMCZHnfz4/HbRfUcIbQdWTlZcqleBRnYVWl+8MnAecjdU0PPgw3WO9JZxSaup5AQj+RWAP6DjqsfwpwtDqa3J8LcSPSWqamggTwdocgQnPZXTfb4w3HFxbfsmiSjtoMbLKz9OfU9o1JRySTFG4qk86qKhInLLBZHH1bcIo=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB3895.namprd12.prod.outlook.com (52.132.245.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.13; Wed, 8 Jan 2020 03:05:14 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::4874:d6a2:6327:aa2b]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::4874:d6a2:6327:aa2b%4]) with mapi id 15.20.2602.015; Wed, 8 Jan 2020
 03:05:14 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Topic: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
Thread-Index: AQHVxZ9cVDlCDYMJ70KAj5QKMJfCHKfgEPeAgAAEcmA=
Date: Wed, 8 Jan 2020 03:05:13 +0000
Message-ID: <CH2PR12MB391278FB16F067821B998F95F73E0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
 <20200107211320.1820393-2-alexander.deucher@amd.com>
 <MN2PR12MB38381D98F744CDEFA02BCEC4F03E0@MN2PR12MB3838.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB38381D98F744CDEFA02BCEC4F03E0@MN2PR12MB3838.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=41952cfb-a966-45ce-846f-000061bdb87f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-08T02:48:12Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-01-08T03:05:11Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b6c32641-bde2-4053-a1a2-0000dd11f574
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74c9254d-3ea1-4c99-3121-08d793e794e4
x-ms-traffictypediagnostic: CH2PR12MB3895:|CH2PR12MB3895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38954B11EB4BC44F1035C645F73E0@CH2PR12MB3895.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(13464003)(966005)(478600001)(52536014)(45080400002)(9686003)(86362001)(5660300002)(71200400001)(53546011)(6506007)(7696005)(66446008)(26005)(316002)(33656002)(76116006)(110136005)(81156014)(66556008)(2906002)(66946007)(186003)(55016002)(64756008)(8676002)(8936002)(66476007)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3895;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDBDOdWatWa1FnSK75PY3Q8gWcl/KDm6gOngyL8AdhMP+6dgPWnJhDtX+lU1HB4gnOz+p3LYwCmFT8hB8cewTKHVm/FwswlY8PMoO5TG73++tAhU44NzGKOKSvwnYAHG7YakZ/gFROPWk7vniNJ2JAeigTuGutOW6x7i4AzGYKrsqZCRZYUrSC7kzXzbSDgICYvlFNcdoH4g6wSu5K30O4qjMXxnOO9ThK5Mu6OF+J06xeLcmrEFH5hHbls6sCVC5Jk8gLdfGNtBMf4mDRqkxO1YJ1pMQAhh2G2ZnUsUUCnAL66hbll0A4xTVEoDMF7rV2oFl0daV2bGI1YnhFuswN33yeKI93Pj96Tu3p1X8zmGICAqcZ2wbE3KokYWehdzFPYa7fvGUvy5OdeSf3NLX0KB4aWygcW6zxDitHjX5f6OgJM6/npsHXrGvjescIWn0o0Qs+dJ+ATJpVEmvOuDC7XLvSUMTtC+7m1E2hd04bh+PN6FSxk2JPatNXyMGuZealeVmBOH3n0SalXSubr4VG9j1A90kSUt/J+1d5aRguD8jomhg0gUJMspAmLoh8gIDhPZ9udsmRphSG8TYoCbipgHt8S8x1/TVL5KtFP/UjaWKBo6vFKzN2f5wIsq1vu9vC+UwgXjI2eeNoKeUARnnw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c9254d-3ea1-4c99-3121-08d793e794e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 03:05:13.9336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym5u0V9lmcOjNLxsL/tXuY8GXhQuXaE8r1hN58s6J5p7VRSXoECwWHALYRwlLOA6AQT3Sw3Cp7s1mIEbJ9ydHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3895
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

[AMD Official Use Only - Internal Distribution Only]

> -----Original Message-----
> From: Liu, Aaron <Aaron.Liu@amd.com>
> Sent: Tuesday, January 7, 2020 9:48 PM
> To: Alex Deucher <alexdeucher@gmail.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> 
> Reviewed & Tested-by: Aaron Liu <aaron.liu@amd.com>
> 

Did you test with limited vram?  E.g, set the carve out to 32 or 64 MB so the driver actually uses gart for display?

Thanks,

Alex

> BR,
> Aaron Liu
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Alex Deucher
> > Sent: Wednesday, January 8, 2020 5:13 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 2/2] drm/amdgpu: enable S/G display for renoir
> >
> > Everything is in place so go ahead and enable this for renoir.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >
> > I don't have a renoir board handy.  Can someone test this?
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c       | 1 +
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > index 6d520a3eec40..318605ca9bc3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> > @@ -519,6 +519,7 @@ uint32_t
> amdgpu_display_supported_domains(struct
> > amdgpu_device *adev,
> >  		switch (adev->asic_type) {
> >  		case CHIP_CARRIZO:
> >  		case CHIP_STONEY:
> > +		case CHIP_RENOIR:
> >  			domain |= AMDGPU_GEM_DOMAIN_GTT;
> >  			break;
> >  		case CHIP_RAVEN:
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 05118c8860f9..3be7ab0ce9e3 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -909,6 +909,7 @@ static int amdgpu_dm_init(struct amdgpu_device
> > *adev)
> >  	switch (adev->asic_type) {
> >  	case CHIP_CARRIZO:
> >  	case CHIP_STONEY:
> > +	case CHIP_RENOIR:
> >  		init_data.flags.gpu_vm_support = true;
> >  		break;
> >  	case CHIP_RAVEN:
> > --
> > 2.24.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> > s.f
> > reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=02%7C01%7Caaron.liu%40amd.com%7Cd9cdd08e60a942e97c
> > 6a08d793b67ea1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> >
> 37140284454500549&amp;sdata=TGuS5qqX8siW1sxWUZtQggnk4P2RPjxUiLk
> > dvS1Fcog%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
