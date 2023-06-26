Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FEAEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 17:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25F2A10E121;
	Mon, 26 Jun 2023 17:52:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB05710E121
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 17:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mornx0AhNYMqHxlgEZlCk+nmhaqiGCLrSvf+V3Jr9aYH1w1gzZWKNim75XtQ3bNFFglkDG/CRkc4jFyqc64N/BiRiWgL5f+Jm8H1QxL7IMWceDUFhEbdcgaWiFUQY3ImQM6F2Nf7rWzW5B+Y/pCo1t3eJcFVjifrQz0hxYVn4kb+DFj2skC15WZmwBMgCCDonr7jMn7iTAFGsRAPz4i7P4QwEoU9AGQMw5RjbDZBxjlAtczjK54AviYZCsYWqgLS5cmRCusHfQ8PJbHHKMGa936n/BjmSnTWhpOfxI1N12IAPTk7wypOX1UxMD/7MAjv1bJv6DthA9vOpCbKiYV4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ9RV9c7M9WrIIq1uz5Oct99i7cHxJi5ij0bRV5mZSA=;
 b=NdDnEtf7qRCP2ihUJ9MIRA+8dkjSasIXonwCiqUdtwczEJRGTc7GrBtdE4xH2gL60T5WAp+H+8MRGpdZp5a1z0gsnLIH9YXl7JSawuTQUTkNUo9rjeupoLgtx6JolEAux6UG3RGfGrHM5u0zO0J8c1/7h1JpeZgKDo64baF0jka4tP3IHa6rZyqjFRjelnscseqNLKBzieAr6zBVJOB8L7TsoGU71VtXmwcL0/FxzMyG4Z5wHDLGsqOIiVfEDUVPZbQukBsYJ0eO3GHtGPB/MDZPx9wCxxYImv8zzlgs7cKlmBOxc0+SQeZEAv7lVvCewyKNBLGnk3V06GLfx3UY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ9RV9c7M9WrIIq1uz5Oct99i7cHxJi5ij0bRV5mZSA=;
 b=xIkhtNQiP2fM0qRSGaDPf7Xj1fCQy3Fbx/BKmkZ5YPzijc77JrO+jBN663IjgMnSX7RiRCRCG0tQs3EhBMwWoIoGMX6qTpjGI75WSvyCdc9C7H+vnMpXGTuncYh+/mtLpgT8lm7a0MoGIgO87dwrMc3/4ddcKDL/ntPnr3lmmaI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 17:52:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 17:52:09 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Wentland, Harry" <Harry.Wentland@amd.com>
Subject: RE: [PATCH] Revert "drm/amd/display: edp do not add non-edid timings"
Thread-Topic: [PATCH] Revert "drm/amd/display: edp do not add non-edid timings"
Thread-Index: AQHZqFVj7fsDCxqQZkC6/uubOCxG1a+dWqjAgAACTvA=
Date: Mon, 26 Jun 2023 17:52:09 +0000
Message-ID: <MN0PR12MB6101560D327F5317533B336DE226A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230626174058.1344311-1-hersenxs.wu@amd.com>
 <MN0PR12MB6101F112F3F93AC872833E98E226A@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101F112F3F93AC872833E98E226A@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4bcefbe4-2f0f-4e0e-9c6c-64871739cba7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-26T17:44:50Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW6PR12MB8998:EE_
x-ms-office365-filtering-correlation-id: c6f087a5-2b75-404a-93f1-08db766e1010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6bAPNGDQFBgUXTKpMORtKVUdKEWzfWzvu6bNY0NfCXnsGJJBlUgG8JfxcoLHloJAXhGcqkmtyd2LNHys/z8pc60W0t+YYIRuuqJ69uvmFjeoSrPaXiRQVPbXqlm77wuTsjRATtdlkybQw0L+ANpVHRqScUeP6Np2HJCupOiCDXFGJDiMMUmIHixOs79wQwJPeiWNZzXlF/A9DSzSfHSGCBnzZWSZ90eQeaM+A95ZZUHdanVuWmbhk53oKajMITrLSIM4PNAXXQfLYrCyj7GzauXt3oxENMawJDGJejfIGs6aM5fhNvgnI3E3gpP66hqUySdLb9eIcG0+fq+dnSep4DJYyCWIaapM+MSG0P1VsDHZ1ZD+7dbuofJ8Cn4CHYr41m5OTqLQMFk5dxkwNwhFlxHSyGJhhasTRd/lZvyl7IG3l8tED5MJjuQoWnbhSeLiJSFZ+X6LVXzgpLaKhnkWL4j+R9gcE1HRmkZZcMv3vc2xMaZlyVp7cPDXQqM+6JZr7cCURzzMTESC/GqaUwbJTWq8qpDveghJBV91svFj16yGy7IVzus9hl2TbrTrKd0Uv4oUlWfaImH1+DkY3GqnYSf7VY/43ySSkMfCiI/P9g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(451199021)(2906002)(7696005)(53546011)(38100700002)(83380400001)(122000001)(6506007)(26005)(186003)(9686003)(2940100002)(71200400001)(55016003)(966005)(86362001)(41300700001)(110136005)(38070700005)(478600001)(64756008)(6636002)(66556008)(66446008)(33656002)(66946007)(66476007)(4326008)(316002)(76116006)(8936002)(8676002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NIofv0qckRavKxOPpsIEKnigR5yQZCf38BOLalkNjS22TOlo5FBzjEfF9f2W?=
 =?us-ascii?Q?gjAustKBJn/Iy/mz5TI6PMsc9YATVTC/bs5nZD2Rw7PjtaffS4bMaDz6WmRS?=
 =?us-ascii?Q?KPifvGmQkLIyMH1EevcsmZTcaTG8drXJZXl5S11CZzUhdSBpk3w3qeqdN7YY?=
 =?us-ascii?Q?AYiYgTOz2MkKDtZVccqCXQc0/QOVWfs4RPGywn3cTWzrZbVGT+gL/0/WOlam?=
 =?us-ascii?Q?edRgtQfh0pKHIyMRlzyj+RmjsLVUacJKFkHfMuukpzMqTE3zp3vci5m6guQY?=
 =?us-ascii?Q?YrdhS4H87oyUDYTIRPxVQW2GhuYPVaIlr6tNGEDpfqkZJoCvNdgQOmV+SE+Y?=
 =?us-ascii?Q?N3us6LBARmOghft58tk+CsuLLJ+HycynbJIed1MYKp7CDnG5GKvC1jUtXFUy?=
 =?us-ascii?Q?oxUD95JWk8c1zbfzC3ccpSi6OeeXXRTjQ4NXEOBCXV2pfGQdlOcSNtXGh2Jh?=
 =?us-ascii?Q?8dC3pCoNhyp0dDxeu2aVKYEq8bh14Eu/JcloIz6Iwhc1YaNcI3uMUOYF90Gg?=
 =?us-ascii?Q?+6a8Pv1iiFLfl0SL04nXJEqnQEofEnUNLfSk8TE6rdBitK3NMScyB9xD44Jl?=
 =?us-ascii?Q?pyvmCRLrcLHDly/VqDAcX25W7eLSoRzGHrf9pbJFreN8zE/0znDVeDic3jMc?=
 =?us-ascii?Q?huJ0VntY7UO/X5SQ+fiVqTZYX4ng9VARaqWub2H8n69RWqLrdjzzdp1U9+S8?=
 =?us-ascii?Q?a5uEmxgc+lHIWoCDz/dauz/7jYAUcQDCxRLum7aSs/ILwP7bJmZdzvjyuDxJ?=
 =?us-ascii?Q?v6BCHCUZPfU0P2RHNx/2+h8so/9pIk18TxJEQ5x9LAVpJt6U8t0pW+BisEg0?=
 =?us-ascii?Q?A/K23zigQhZJMmnfUZhujNShmOPrnFtjiSlyQW+zf1TUZchTPoxWqYtjBr4Y?=
 =?us-ascii?Q?wedW6cEUTqGAR0xWe7rwOgz1egpw7yHjUd1EiU0CpgGniNM0soUFOYWfhcv/?=
 =?us-ascii?Q?nWntFmvUPjzntZC2LQOi1lsafN/R+tDYWxu1u4XrGDCtzfAX1gX+ry5KYHlH?=
 =?us-ascii?Q?BKEB1gvd82mvteUGmQOUTyEY670thERqcd4bkzF9oWp7DWQ3E54rPe21z1L+?=
 =?us-ascii?Q?uh00AZ1WD5zQNtuIKtWbT/TzZ+EUG1G5cGESRcmLt3zZwea4Qv1Q2Gh9v/us?=
 =?us-ascii?Q?9atSyUg8k24l2drEYQ8O62a7kTi+kVs0WNZxXiYGLBsNjxDAWCu3Jt0U7Oa3?=
 =?us-ascii?Q?156YdzIikRWEkygrY3wvrXbFznCH6bCDQqH09y8bbwcggv2CdE95PlmpHGqj?=
 =?us-ascii?Q?yvsL4vF/7qAJGAb2y46kiVzSB4M4xHjXwjBHzS+rrIcY5Nj+WzNDgwxXWoJH?=
 =?us-ascii?Q?stL5h6pYDT48fvRs0RMMKUugHZh0mtDzvjax3T4WfzYUYletSkEqyzXY+Iug?=
 =?us-ascii?Q?nauyKnANs47L2/fUy48lzZel3xLhR7dJFa7/PkaVt7cSbpViCpcVYReJHMVh?=
 =?us-ascii?Q?ZGqphl8zTHH2y5B2gHdidFWCTYILUwKhb1q+PbL1R5jy5eOTtXKCJe8vrWzU?=
 =?us-ascii?Q?08i7YTK2/HlE1Flvln+1aYKNx+PwmDQ/VMyvqDDC2RlfppaNEndedwGpl4ri?=
 =?us-ascii?Q?SiEp4LqKLf1d4dT9BoY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f087a5-2b75-404a-93f1-08db766e1010
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 17:52:09.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XjWRajhFCBNayCtECAlz5MFbC0Q1qVIEqWtDnIsmw4wKbc+hZn+vZvG4SfHJiI7CWa60QvZqq5BDj1wK/Gww4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Limonciello, Mario
> Sent: Monday, June 26, 2023 12:45 PM
> To: Hersen Wu <hersenxs.wu@amd.com>; amd-gfx@lists.freedesktop.org;
> Wentland, Harry <Harry.Wentland@amd.com>
> Cc: Wu, Hersen <hersenxs.wu@amd.com>
> Subject: RE: [PATCH] Revert "drm/amd/display: edp do not add non-edid
> timings"
>
> > This change causes regression when eDP and external display in mirror
> > mode. When external display supports low resolution than eDP, use eDP
> > timing to driver external display may cause corruption on external
> > display.
> >
> > This reverts commit aa9704d5127f06c9ffedb0480d2788b87fecedfb.

One more thing - although this is the correct hash for ASDN, this merged
into Linus' tree as e749dd10e5f292061ad63d2b030194bf7d7d452c.

As this has to go back to stable trees properly, I think the hash should
reflect what's in Linus' tree instead of what's in ASDN.

> >
> > Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
>
> The original commit CC to stable, we need this to go to stable too.
>
> Here's some tags to pick up when merging.
>
> Cc: stable@vger.kernel.org
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2655
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a46b8b47b756..073bf00c6fdc 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -7258,13 +7258,7 @@ static int
> > amdgpu_dm_connector_get_modes(struct drm_connector *connector)
> >                             drm_add_modes_noedid(connector, 1920,
> > 1080);
> >     } else {
> >             amdgpu_dm_connector_ddc_get_modes(connector, edid);
> > -           /* most eDP supports only timings from its edid,
> > -            * usually only detailed timings are available
> > -            * from eDP edid. timings which are not from edid
> > -            * may damage eDP
> > -            */
> > -           if (connector->connector_type !=3D
> > DRM_MODE_CONNECTOR_eDP)
> > -
> >     amdgpu_dm_connector_add_common_modes(encoder, connector);
> > +           amdgpu_dm_connector_add_common_modes(encoder,
> > connector);
> >             amdgpu_dm_connector_add_freesync_modes(connector,
> > edid);
> >     }
> >     amdgpu_dm_fbc_init(connector);
> > --
> > 2.25.1

