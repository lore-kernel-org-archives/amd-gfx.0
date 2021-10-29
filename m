Return-Path: <SRS0=vl2N=PR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9765CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B1361130
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Oct 2021 02:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46B1361130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A0B6E9AC;
	Fri, 29 Oct 2021 02:22:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC3E6E9AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Oct 2021 02:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaqswsaZynqTWZZaFr8CGhs5YwmvVZezTBvKxJpIEw/mwL2F3lWKYiqdiA8DIx8YDdcpNIBrZekd6Pw9i/ZNnQFuvyNKJNBhvjwBJPzWTs4ltNgI6FQH9J9VP+IK3gHiKHhZ/sUtHP/dHLcoNzw9l68FGVwLHWqxjdXrVOVo5B7rBXQ84D68XkUF+BeP5RHnc4vwqHJTFiO4AwNLf9Z6KeoySBWzd9KF88Uw19elIIqcAUtlUFdvuth3pdJnhW2bkGMVPSQNsMb+DKupowHWUvOv2VHM4pOkArCziAIOZyAxo+kzKF1z/n/3kMkFt6R0Q1NW0HJEkfxAzA0pZOZw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+fwBrNoqgzurM9wz6ezb5Dhfa0e8rxjdjNOa7UaTVM=;
 b=N/7X0jaROewQT/j731ZYMjecK/xy7EI1GfMneYOK0Iv9D1ndHiJqPSURRsHo0Q2V4u1XnUsppEivGo86AxEj/MubAmU9zQ8jEhVF40MVYrxd07KG9j5pg07GzukFHDDb6zzk/28TSlun7uXswljrbuS9FVa8VJhgLEmN49K0pDM8cK2kQGmP8JR022LAr7DVOAM+NCmlNwwRS6XMknT/s24jmMYKGbtJcvAGfIkPw3DJrAwagtbzu707dwVdeHqyF+CFKyIvn28lkasNy9wRIyktPXbFiTPsG1Q8hRcOYxjnjV7UnxGEofMYHIX4qjYagWOyo2lCh3WnNhLaSvz6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+fwBrNoqgzurM9wz6ezb5Dhfa0e8rxjdjNOa7UaTVM=;
 b=Av7kGJv/N/5ukGJ07zhtdHqsg96feUqY9IXUucJuZalNDZTZ7udgfjyukF47YLPAvxlobghyiFFkHK005YjUU+VG7RCeHtcn8Fdmdbj9UfgAt3WO6Gy4eTFFD5+6hnQqgS48QeNriGDggp3GGvAfIM7O8L27TYc/lsKUqfCI2BY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 02:22:35 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::214d:f77:ca81:51b0%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 02:22:35 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "Limonciello, Mario"
 <Mario.Limonciello@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for APUs
Thread-Topic: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support for
 APUs
Thread-Index: AQHXzBQM5GCAsoUQ7UutHQzVR+PUiKvpOfJwgAAEJXA=
Date: Fri, 29 Oct 2021 02:22:35 +0000
Message-ID: <BL1PR12MB52376D8031E794CE5A509AFEF0879@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20211028155336.2990-1-mario.limonciello@amd.com>
 <BL1PR12MB5237861C3D8EF870C5A84156F0879@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5237861C3D8EF870C5A84156F0879@BL1PR12MB5237.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-29T02:22:31Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=085fef46-2c2e-4786-85df-2269528d17c6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0026be9-87f8-4119-f4c3-08d99a82f88f
x-ms-traffictypediagnostic: BL1PR12MB5302:
x-microsoft-antispam-prvs: <BL1PR12MB5302743B230DB27810375397F0879@BL1PR12MB5302.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v0fY/uHNm+O9S1BmK+4XzxC8s4HjsN9vwHKaFgN2/PmF52km1l1jxlrAqYuVGOUGHVpWVEoZfZ1wc0OufU5DCiKF/DAUAg43fgixP46gQMl5QVRfkqMjyLafMnct1axZQ0AmWlG9nhIR3nfqADsVBmPWTSNhMLPfEzeB3VoTAb5d+zcBHPxLp5uJWDRDNbZvxw0My8H1iXGvUxAe5IsDC3CcTJVK+9BfnTdm+cPkRiHAiggX6/Ae2LPpdtBX33sUix6d9/nBwR/ERt89I7IVYPZomb4nmPAMxV5A8/tC25E9JZrqMdam+wIRjsm8kRKbDkRI5sfjlBBdgSyFS4jMmNwQv4GUhLtFoIKrXduaCmkZFLgUSbHEsmS8YKvWOq6zOtUL3QmXFtOx3DAOjHv4d8Fwevz+1SRXuo4/LcAAPl8L15hgdAPLmqNvKnb675g4LmOccH8yAV3mSCj9RqK+5bRMWrC/LUb9uEC4olDMo2Uis0PCBbrY5cT5CoWS7Aov6yx9KUBttm5KgDKYSZhUHaZh2C28C6T8kPnEmp+S3VqOCG/RXEQ7xIJ9161ZEaXzs0Jg5NIecfSpIIrD6KN4SLAyYLV9QQOeGR5gD4rfzGnU9X8lNOp38lkAoSX4UCm/StaGLx3Sf0sYAlZeFYHClkrfjDMgTSOXdniuib8fORMh70xEhcKJ+YLUA8qOTKpO1pKW0kDhwlwcs2Sy1wdARg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(55016002)(508600001)(66946007)(76116006)(6506007)(122000001)(26005)(110136005)(4326008)(7696005)(38070700005)(2940100002)(9686003)(52536014)(33656002)(66446008)(8936002)(86362001)(83380400001)(2906002)(19627235002)(30864003)(71200400001)(38100700002)(8676002)(316002)(5660300002)(66556008)(66476007)(64756008)(186003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uODIuAwJKueWh5pQmny1n6gWnWJCZhJzuXpHyJDjVGN30chrH6iB3YK85Rio?=
 =?us-ascii?Q?l8kolIQYCNNoodwkqMkvuDqY0YK58rmADBelyItCz3h6X0CGEmmsgi+eAiHO?=
 =?us-ascii?Q?K2UrTFCS9QLAm2fX5HJ4naRp/JKdiIO7oYMKWBiF59Tw2FPL/cpAZLISDk6q?=
 =?us-ascii?Q?vxFQMOuRRdP6znO67NkpsePFUFcEXqVqF8TH9zK8Aa2bsvwi4dqpsWhmcDlq?=
 =?us-ascii?Q?dwXRm2NjLIQY51OAmRWjh2anhKZ3fwGPH4x9bf32pTVHHyXuzhreYZvb7f7m?=
 =?us-ascii?Q?jWGQhtgwbbsjtJ/wJmrdoSIt9zhZ0eCGUsAXs/RMVGrh81VCYhlZBUlD28kE?=
 =?us-ascii?Q?6wZuf3WfQtat5dAV6Ld5VeuzN4+O03lSpJVnTqZZb8Sk/CEz3r+Cs0jB1XZK?=
 =?us-ascii?Q?nbSKzodk2+OfJIj+eny77VGdsqH3D8J3peWrYuGW0DoLPqRPJmsjQGQLikSU?=
 =?us-ascii?Q?i1+8YawgydoeRuKyMiUo+1whlhZEFy0TovwkF5N2C9MpaVyJ0vejFxQf8YSH?=
 =?us-ascii?Q?/gbx2ljuO5Htj1dTLcIrewJXB68iO+xsUbFQDdwSyqOY6dAcOnksp51kZf2F?=
 =?us-ascii?Q?vtPK6AQpzA6BUgkeEdAyz1IQkFAGXiY4BP2H1Zf1PsK5La4jtqxQOQhv2hB2?=
 =?us-ascii?Q?cm4nom+P62dbUelXvqElnaFgxip69TmSYs/PG60em/AfSc8tyPEctCrimz+d?=
 =?us-ascii?Q?xWzJ6J6PHClWl1XhEZvjinO/KZ1QRoSxrkilWNvthw7uScsPgDymML9ZaamA?=
 =?us-ascii?Q?5Cny7T51Y6PELCqPjR1bw4qtwiiNf1SiEO0hycOVaAH5UdgcBnjFgsBs4IRr?=
 =?us-ascii?Q?k9uJitr5NXlg4pcQBeGCv/vYcs2R96MoFiMC7Krd/aYQN9ghePa+tgDAI+QW?=
 =?us-ascii?Q?oMKZRhaYrAXumK5eg5MLLIxI6qEZ5nvPy8V+OnVEpCK1xLIgo4GChh6Xy8Q0?=
 =?us-ascii?Q?d0lWI0PeCfxrgY5PZwMMR2z7TrM+ZlQoXK/R0mIrWelvQZMKhNs3KJUevtL9?=
 =?us-ascii?Q?bsus36Boyb+9z6Qv7IZzLtt56BBXPH7+kopEBTqrQwDXjFdEXTNWDUpW6Jvy?=
 =?us-ascii?Q?DW4nUEoTfO0+K3eaA1cyfp1rcAYv//DV5Y+Ikw89RSB7c5hyUUafSQ+VzwKd?=
 =?us-ascii?Q?xuucS1mLaTab2bZaHugu5/PtPccrUboXvIrrTUvBxR/F+/dZnlg0cqvqY8Ay?=
 =?us-ascii?Q?bkcQRFeQVVRnvR1JOIl9l/A+xS+X19sGqa9GvIZuOW2MLVslp4oY9MwYL22s?=
 =?us-ascii?Q?rhnWZdeXSmvjsquZTtlSLsK9Squ0GiNTykJP3vN3MPe7ngmHnnVLQVAPR/1k?=
 =?us-ascii?Q?PRt3A4/50G36d77Am0JusLlYrgTqgv0w4tUQU5UpIEbuvPodfcbDyt2Q0vWt?=
 =?us-ascii?Q?odpXwwhEQ4TH4HJQpeKtfhUaCtSLdDksyyAzgozi7flKK8zvmyNIkN/xyZNH?=
 =?us-ascii?Q?dX7a2TZRGCIR7jEg9Tri1W7fr4o+AqQO+bU71MARkyahPYzmWYZ1xm9hjXoq?=
 =?us-ascii?Q?b5+WEh4z7P9jjy2YrHJarIKPYjKTT6+0FhA7ThLRqz5Vk/mRb4un4D4XI4aS?=
 =?us-ascii?Q?DKWLFx+oZy6Kc6gLphc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0026be9-87f8-4119-f4c3-08d99a82f88f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 02:22:35.4184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WmMdTWwgIDQ/i8QSwdOZm8To3XBnf0DpuwokA9crXP0X40ubFGGE8GIafhEjttLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
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

[AMD Official Use Only]

Sorry, Mario.=20
Please don't upstream.
We need to discuss whether to drop pp_power_profile_mode support for RN/VGH=
.

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu,
> Aaron
> Sent: Friday, October 29, 2021 10:03 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode
> support for APUs
>=20
> [AMD Official Use Only]
>=20
> Reviewed-by: Aaron Liu <aaron.liu@amd.com>
>=20
> --
> Best Regards
> Aaron Liu
>=20
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Mario Limonciello
> > Sent: Thursday, October 28, 2021 11:54 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Subject: [PATCH] drm/amdgpu/pm: drop pp_power_profile_mode support
> for
> > APUs
> >
> > Although this has been plumbed for Renoir, Green Sardine, Van Gogh,
> > and Yellow Carp the functionality in the SMU doesn't do anything for
> these APUs.
> > Drop the associated code with them.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h    |  4 +-
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 86 ------------------
> >  .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 87 -------------------
> >  .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 87
> > -------------------
> >  4 files changed, 2 insertions(+), 262 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > index 1d3447991d0c..23d24173bc5d 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_1_ppsmc.h
> > @@ -51,7 +51,7 @@
> >  #define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN=
;
> > VCN is power gated by default
> >  #define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless
> > display
> >  #define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin =
for
> > GFXCLK, argument is frequency in MHz
> > -#define PPSMC_MSG_ActiveProcessNotify           0x0A ///< Set active w=
ork
> > load type
> > +#define PPSMC_MSG_SPARE0                        0x0A ///< Spare
> >  #define PPSMC_MSG_ForcePowerDownGfx             0x0B ///< Force power
> > down GFX, i.e. enter GFXOFF
> >  #define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare
> > PMFW for GFX driver unload
> >  #define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32
> > bits of DRAM address for Driver table transfer @@ -63,7 +63,7 @@
> >  #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min
> > for SOC CLK
> >  #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min=
 for
> > FCLK
> >  #define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min=
 for
> > VCN clocks (VCLK and DCLK)
> > -#define PPSMC_MSG_SPARE0                        0x16 ///< Spared
> > +#define PPSMC_MSG_SPARE1                        0x16 ///< Spare
> >  #define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX cloc=
k
> > frequency
> >  #define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK
> > frequency
> >  #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW =
of
> > allowing GFXOFF entry
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 421f38e8dada..2451d990d577 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -72,7 +72,6 @@ static struct cmn2asic_msg_mapping
> > vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
> >  	MSG_MAP(RlcPowerNotify,                 PPSMC_MSG_RlcPowerNotify,
> > 		0),
> >  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> > 		0),
> >  	MSG_MAP(SetSoftMinGfxclk,               PPSMC_MSG_SetSoftMinGfxclk,
> > 		0),
> > -	MSG_MAP(ActiveProcessNotify,
> > PPSMC_MSG_ActiveProcessNotify,		0),
> >  	MSG_MAP(SetHardMinIspiclkByFreq,
> > PPSMC_MSG_SetHardMinIspiclkByFreq,	0),
> >  	MSG_MAP(SetHardMinIspxclkByFreq,
> > PPSMC_MSG_SetHardMinIspxclkByFreq,	0),
> >  	MSG_MAP(SetDriverDramAddrHigh,
> > PPSMC_MSG_SetDriverDramAddrHigh,	0),
> > @@ -182,14 +181,6 @@ static struct cmn2asic_mapping
> > vangogh_table_map[SMU_TABLE_COUNT] =3D {
> >  	TAB_MAP_VALID(DPMCLOCKS),
> >  };
> >
> > -static struct cmn2asic_mapping
> > vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> > 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> > 	WORKLOAD_PPLIB_VIDEO_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> > 	WORKLOAD_PPLIB_VR_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> > 	WORKLOAD_PPLIB_COMPUTE_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> > -
> >  static const uint8_t vangogh_throttler_map[] =3D {
> >  	[THROTTLER_STATUS_BIT_SPL]	=3D (SMU_THROTTLER_SPL_BIT),
> >  	[THROTTLER_STATUS_BIT_FPPT]	=3D (SMU_THROTTLER_FPPT_BIT),
> > @@ -1010,80 +1001,6 @@ static int
> vangogh_get_dpm_ultimate_freq(struct
> > smu_context *smu,
> >  	return ret;
> >  }
> >
> > -static int vangogh_get_power_profile_mode(struct smu_context *smu,
> > -					   char *buf)
> > -{
> > -	static const char *profile_name[] =3D {
> > -					"BOOTUP_DEFAULT",
> > -					"3D_FULL_SCREEN",
> > -					"POWER_SAVING",
> > -					"VIDEO",
> > -					"VR",
> > -					"COMPUTE",
> > -					"CUSTOM"};
> > -	uint32_t i, size =3D 0;
> > -	int16_t workload_type =3D 0;
> > -
> > -	if (!buf)
> > -		return -EINVAL;
> > -
> > -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -		/*
> > -		 * Conv PP_SMC_POWER_PROFILE* to
> > WORKLOAD_PPLIB_*_BIT
> > -		 * Not all profile modes are supported on vangogh.
> > -		 */
> > -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -							       i);
> > -
> > -		if (workload_type < 0)
> > -			continue;
> > -
> > -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> > "*" : " ");
> > -	}
> > -
> > -	return size;
> > -}
> > -
> > -static int vangogh_set_power_profile_mode(struct smu_context *smu,
> > long *input, uint32_t size) -{
> > -	int workload_type, ret;
> > -	uint32_t profile_mode =3D input[size];
> > -
> > -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> > profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -			profile_mode =3D=3D
> > PP_SMC_POWER_PROFILE_POWERSAVING)
> > -		return 0;
> > -
> > -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -						       profile_mode);
> > -	if (workload_type < 0) {
> > -		dev_dbg(smu->adev->dev, "Unsupported power profile
> > mode %d on VANGOGH\n",
> > -					profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > SMU_MSG_ActiveProcessNotify,
> > -				    1 << workload_type,
> > -				    NULL);
> > -	if (ret) {
> > -		dev_err_once(smu->adev->dev, "Fail to set workload
> > type %d\n",
> > -					workload_type);
> > -		return ret;
> > -	}
> > -
> > -	smu->power_profile_mode =3D profile_mode;
> > -
> > -	return 0;
> > -}
> > -
> >  static int vangogh_set_soft_freq_limited_range(struct smu_context *smu=
,
> >  					  enum smu_clk_type clk_type,
> >  					  uint32_t min,
> > @@ -2190,8 +2107,6 @@ static const struct pptable_funcs
> > vangogh_ppt_funcs =3D {
> >  	.set_fine_grain_gfx_freq_parameters =3D
> > vangogh_set_fine_grain_gfx_freq_parameters,
> >  	.system_features_control =3D vangogh_system_features_control,
> >  	.feature_is_enabled =3D smu_cmn_feature_is_enabled,
> > -	.set_power_profile_mode =3D vangogh_set_power_profile_mode,
> > -	.get_power_profile_mode =3D vangogh_get_power_profile_mode,
> >  	.get_dpm_clock_table =3D vangogh_get_dpm_clock_table,
> >  	.force_clk_levels =3D vangogh_force_clk_levels,
> >  	.set_performance_level =3D vangogh_set_performance_level, @@ -
> > 2210,6 +2125,5 @@ void vangogh_set_ppt_funcs(struct smu_context
> *smu)
> >  	smu->message_map =3D vangogh_message_map;
> >  	smu->feature_map =3D vangogh_feature_mask_map;
> >  	smu->table_map =3D vangogh_table_map;
> > -	smu->workload_map =3D vangogh_workload_map;
> >  	smu->is_apu =3D true;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > index 145f13b8c977..21da7989f1ba 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> > @@ -58,7 +58,6 @@ static struct cmn2asic_msg_mapping
> > renoir_message_map[SMU_MSG_MAX_COUNT] =3D {
> >  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> > 1),
> >  	MSG_MAP(SetAllowFclkSwitch,
> > PPSMC_MSG_SetAllowFclkSwitch,           1),
> >  	MSG_MAP(SetMinVideoGfxclkFreq,
> > PPSMC_MSG_SetMinVideoGfxclkFreq,        1),
> > -	MSG_MAP(ActiveProcessNotify,
> > PPSMC_MSG_ActiveProcessNotify,          1),
> >  	MSG_MAP(SetCustomPolicy,                PPSMC_MSG_SetCustomPolicy,
> > 1),
> >  	MSG_MAP(SetVideoFps,                    PPSMC_MSG_SetVideoFps,
> > 1),
> >  	MSG_MAP(NumOfDisplays,                  PPSMC_MSG_SetDisplayCount,
> > 1),
> > @@ -120,14 +119,6 @@ static struct cmn2asic_mapping
> > renoir_table_map[SMU_TABLE_COUNT] =3D {
> >  	TAB_MAP_VALID(SMU_METRICS),
> >  };
> >
> > -static struct cmn2asic_mapping
> > renoir_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> > 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> > 	WORKLOAD_PPLIB_VIDEO_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> > 	WORKLOAD_PPLIB_VR_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> > 	WORKLOAD_PPLIB_COMPUTE_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> > -
> >  static const uint8_t renoir_throttler_map[] =3D {
> >  	[THROTTLER_STATUS_BIT_SPL]		=3D
> > (SMU_THROTTLER_SPL_BIT),
> >  	[THROTTLER_STATUS_BIT_FPPT]		=3D
> > (SMU_THROTTLER_FPPT_BIT),
> > @@ -854,46 +845,6 @@ static int renoir_force_clk_levels(struct
> > smu_context *smu,
> >  	return ret;
> >  }
> >
> > -static int renoir_set_power_profile_mode(struct smu_context *smu,
> > long *input, uint32_t size) -{
> > -	int workload_type, ret;
> > -	uint32_t profile_mode =3D input[size];
> > -
> > -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> > profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -			profile_mode =3D=3D
> > PP_SMC_POWER_PROFILE_POWERSAVING)
> > -		return 0;
> > -
> > -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -						       profile_mode);
> > -	if (workload_type < 0) {
> > -		/*
> > -		 * TODO: If some case need switch to powersave/default
> > power mode
> > -		 * then can consider enter
> > WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
> > -		 */
> > -		dev_dbg(smu->adev->dev, "Unsupported power profile
> > mode %d on RENOIR\n", profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > SMU_MSG_ActiveProcessNotify,
> > -				    1 << workload_type,
> > -				    NULL);
> > -	if (ret) {
> > -		dev_err_once(smu->adev->dev, "Fail to set workload
> > type %d\n", workload_type);
> > -		return ret;
> > -	}
> > -
> > -	smu->power_profile_mode =3D profile_mode;
> > -
> > -	return 0;
> > -}
> > -
> >  static int renoir_set_peak_clock_by_device(struct smu_context *smu)  {
> >  	int ret =3D 0;
> > @@ -1092,41 +1043,6 @@ static int renoir_set_watermarks_table(
> >  	return 0;
> >  }
> >
> > -static int renoir_get_power_profile_mode(struct smu_context *smu,
> > -					   char *buf)
> > -{
> > -	static const char *profile_name[] =3D {
> > -					"BOOTUP_DEFAULT",
> > -					"3D_FULL_SCREEN",
> > -					"POWER_SAVING",
> > -					"VIDEO",
> > -					"VR",
> > -					"COMPUTE",
> > -					"CUSTOM"};
> > -	uint32_t i, size =3D 0;
> > -	int16_t workload_type =3D 0;
> > -
> > -	if (!buf)
> > -		return -EINVAL;
> > -
> > -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -		/*
> > -		 * Conv PP_SMC_POWER_PROFILE* to
> > WORKLOAD_PPLIB_*_BIT
> > -		 * Not all profile modes are supported on arcturus.
> > -		 */
> > -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -							       i);
> > -		if (workload_type < 0)
> > -			continue;
> > -
> > -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> > "*" : " ");
> > -	}
> > -
> > -	return size;
> > -}
> > -
> >  static int renoir_get_smu_metrics_data(struct smu_context *smu,
> >  				       MetricsMember_t member,
> >  				       uint32_t *value)
> > @@ -1389,11 +1305,9 @@ static const struct pptable_funcs
> > renoir_ppt_funcs =3D {
> >  	.dpm_set_vcn_enable =3D renoir_dpm_set_vcn_enable,
> >  	.dpm_set_jpeg_enable =3D renoir_dpm_set_jpeg_enable,
> >  	.force_clk_levels =3D renoir_force_clk_levels,
> > -	.set_power_profile_mode =3D renoir_set_power_profile_mode,
> >  	.set_performance_level =3D renoir_set_performance_level,
> >  	.get_dpm_clock_table =3D renoir_get_dpm_clock_table,
> >  	.set_watermarks_table =3D renoir_set_watermarks_table,
> > -	.get_power_profile_mode =3D renoir_get_power_profile_mode,
> >  	.read_sensor =3D renoir_read_sensor,
> >  	.check_fw_status =3D smu_v12_0_check_fw_status,
> >  	.check_fw_version =3D smu_v12_0_check_fw_version, @@ -1429,7
> > +1343,6 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
> >  	smu->message_map =3D renoir_message_map;
> >  	smu->clock_map =3D renoir_clk_map;
> >  	smu->table_map =3D renoir_table_map;
> > -	smu->workload_map =3D renoir_workload_map;
> >  	smu->smc_driver_if_version =3D SMU12_DRIVER_IF_VERSION;
> >  	smu->is_apu =3D true;
> >  }
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > index a403657151ba..8215bbf5ed7c 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> > @@ -64,7 +64,6 @@ static struct cmn2asic_msg_mapping
> > yellow_carp_message_map[SMU_MSG_MAX_COUNT] =3D
> >  	MSG_MAP(PowerDownVcn,                   PPSMC_MSG_PowerDownVcn,
> > 			1),
> >  	MSG_MAP(PowerUpVcn,                     PPSMC_MSG_PowerUpVcn,
> > 		1),
> >  	MSG_MAP(SetHardMinVcn,                  PPSMC_MSG_SetHardMinVcn,
> > 		1),
> > -	MSG_MAP(ActiveProcessNotify,
> > PPSMC_MSG_ActiveProcessNotify,		1),
> >  	MSG_MAP(PrepareMp1ForUnload,
> > PPSMC_MSG_PrepareMp1ForUnload,      1),
> >  	MSG_MAP(SetDriverDramAddrHigh,
> > PPSMC_MSG_SetDriverDramAddrHigh,	1),
> >  	MSG_MAP(SetDriverDramAddrLow,
> > PPSMC_MSG_SetDriverDramAddrLow,		1),
> > @@ -135,14 +134,6 @@ static struct cmn2asic_mapping
> > yellow_carp_table_map[SMU_TABLE_COUNT] =3D {
> >  	TAB_MAP_VALID(CUSTOM_DPM),
> >  	TAB_MAP_VALID(DPMCLOCKS),
> >  };
> > -
> > -static struct cmn2asic_mapping
> > yellow_carp_workload_map[PP_SMC_POWER_PROFILE_COUNT] =3D {
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,
> > 	WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,
> > 	WORKLOAD_PPLIB_VIDEO_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,
> > 	WORKLOAD_PPLIB_VR_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,
> > 	WORKLOAD_PPLIB_COMPUTE_BIT),
> > -	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> > -};
> >
> >  static int yellow_carp_init_smc_tables(struct smu_context *smu)  { @@
> > -
> > 543,81 +534,6 @@ static int yellow_carp_set_watermarks_table(struct
> > smu_context *smu,
> >  	return 0;
> >  }
> >
> > -static int yellow_carp_get_power_profile_mode(struct smu_context *smu,
> > -						char *buf)
> > -{
> > -	static const char *profile_name[] =3D {
> > -					"BOOTUP_DEFAULT",
> > -					"3D_FULL_SCREEN",
> > -					"POWER_SAVING",
> > -					"VIDEO",
> > -					"VR",
> > -					"COMPUTE",
> > -					"CUSTOM"};
> > -	uint32_t i, size =3D 0;
> > -	int16_t workload_type =3D 0;
> > -
> > -	if (!buf)
> > -		return -EINVAL;
> > -
> > -	for (i =3D 0; i <=3D PP_SMC_POWER_PROFILE_CUSTOM; i++) {
> > -		/*
> > -		 * Conv PP_SMC_POWER_PROFILE* to
> > WORKLOAD_PPLIB_*_BIT.
> > -		 * Not all profile modes are supported on yellow carp.
> > -		 */
> > -		workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -							       i);
> > -
> > -		if (workload_type < 0)
> > -			continue;
> > -
> > -		size +=3D sysfs_emit_at(buf, size, "%2d %14s%s\n",
> > -			i, profile_name[i], (i =3D=3D smu->power_profile_mode) ?
> > "*" : " ");
> > -	}
> > -
> > -	return size;
> > -}
> > -
> > -static int yellow_carp_set_power_profile_mode(struct smu_context *smu,
> > -						long *input, uint32_t size)
> > -{
> > -	int workload_type, ret;
> > -	uint32_t profile_mode =3D input[size];
> > -
> > -	if (profile_mode > PP_SMC_POWER_PROFILE_CUSTOM) {
> > -		dev_err(smu->adev->dev, "Invalid power profile mode %d\n",
> > profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	if (profile_mode =3D=3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT ||
> > -			profile_mode =3D=3D
> > PP_SMC_POWER_PROFILE_POWERSAVING)
> > -		return 0;
> > -
> > -	/* conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT */
> > -	workload_type =3D smu_cmn_to_asic_specific_index(smu,
> > -
> > CMN2ASIC_MAPPING_WORKLOAD,
> > -						       profile_mode);
> > -	if (workload_type < 0) {
> > -		dev_dbg(smu->adev->dev, "Unsupported power profile
> > mode %d on YELLOWCARP\n",
> > -					profile_mode);
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret =3D smu_cmn_send_smc_msg_with_param(smu,
> > SMU_MSG_ActiveProcessNotify,
> > -				    1 << workload_type,
> > -				    NULL);
> > -	if (ret) {
> > -		dev_err_once(smu->adev->dev, "Fail to set workload
> > type %d\n",
> > -					workload_type);
> > -		return ret;
> > -	}
> > -
> > -	smu->power_profile_mode =3D profile_mode;
> > -
> > -	return 0;
> > -}
> > -
> >  static ssize_t yellow_carp_get_gpu_metrics(struct smu_context *smu,
> >  						void **table)
> >  {
> > @@ -1238,8 +1154,6 @@ static const struct pptable_funcs
> > yellow_carp_ppt_funcs =3D {
> >  	.read_sensor =3D yellow_carp_read_sensor,
> >  	.is_dpm_running =3D yellow_carp_is_dpm_running,
> >  	.set_watermarks_table =3D yellow_carp_set_watermarks_table,
> > -	.get_power_profile_mode =3D yellow_carp_get_power_profile_mode,
> > -	.set_power_profile_mode =3D yellow_carp_set_power_profile_mode,
> >  	.get_gpu_metrics =3D yellow_carp_get_gpu_metrics,
> >  	.get_enabled_mask =3D smu_cmn_get_enabled_32_bits_mask,
> >  	.get_pp_feature_mask =3D smu_cmn_get_pp_feature_mask, @@ -
> > 1261,6 +1175,5 @@ void yellow_carp_set_ppt_funcs(struct smu_context
> > *smu)
> >  	smu->message_map =3D yellow_carp_message_map;
> >  	smu->feature_map =3D yellow_carp_feature_mask_map;
> >  	smu->table_map =3D yellow_carp_table_map;
> > -	smu->workload_map =3D yellow_carp_workload_map;
> >  	smu->is_apu =3D true;
> >  }
> > --
> > 2.25.1
