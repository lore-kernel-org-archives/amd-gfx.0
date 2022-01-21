Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC32C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 10:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBFA10E794;
	Fri, 21 Jan 2022 10:20:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B8210E794
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 10:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtkjBow11NsDC310PKPwe1FrH6B6gelfyIZxx+rclJAh6D5+K5C9CXtNnZgCxF/5v3u5wewOXoeNiZQ0g7SNmMunlNXrjpxtNIlyVRvt/mxKIo6vSV6qvrrPaytaMPTGjJFKVMSz4zumUnSnm/pCgMoHu92lDrpbgwZLncXFTlEJkJmeqZ6xTuJpK6xALtyKyPrDiSIiOSfg2Y8j6o9UJoXvuCy3M9nC8RMWNwmd6k9xotmyo4STwsrTZ3Lj5FvwQm46oAbjShZnZMV+OTJVnkMvTPs704S6OVa4mN8VirBzrHHWuhkZx3zDJuVlj6u9IEGZH7G+sHjCRrSDivQFNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdNivvSQIwMpcZAYkQih+8QcHK0HyYpVvKNjB0KWWAE=;
 b=BoeV5p4ycqrYpYoi2GLXbrpN4iZlSz2zWU+3AT0gbQl0RfRaKFJ8X6K9xhvY1O2jFnH9cqfqfIghfYg20UyRzItbymg97p4bXNMykliN8rF/g0OEaCDeAi0MaqM0KU0OpjR3OBvAHDphaKxCPbhzv2GNj0jVlYydUT0HpXN2nyM1IlldYMbSLwnoT3MB0qZDHh7KNpznN336b5ytO0g84mpE1w2fmOE9ky9jyB2AQcgvct+0QZGq7IQrMBKa0et6AzQVQj7Jxfi8F1v35XGi6LguREwaza8NSGzzBV+aWfr7yh9AlBf6drIrHhTxXpFiPEwJ6eYkfAzVE3NilRd2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdNivvSQIwMpcZAYkQih+8QcHK0HyYpVvKNjB0KWWAE=;
 b=cpURKQlPgh1iwmCTyoK6DtdYIecZ3XgzaoT6AuBP+HRs/Pwh7cglEAG+x9OiFOyIdiFYA8XZ4rgsBVSxgaIRaU1lK37Zc4zkL62EoAf6Xa/sLIsJAj9n7M1V+OrfdmklRhvnJpbP4cdD9mhthEaRpo6TOzqG6xlf0ZeBCA7EtK0=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Fri, 21 Jan
 2022 10:20:08 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9cb7:c0e7:1329:e857]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::9cb7:c0e7:1329:e857%2]) with mapi id 15.20.4888.014; Fri, 21 Jan 2022
 10:20:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v4] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYDOZzZz13/YAAtkiTKgaq6TcHo6xsVm6AgADk3xA=
Date: Fri, 21 Jan 2022 10:20:08 +0000
Message-ID: <BYAPR12MB323862243A6C32EF7511ECBBFB5B9@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20220119034120.28807-1-mario.limonciello@amd.com>
 <BL1PR12MB5157B51FADD5148BC295792CE25A9@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5157B51FADD5148BC295792CE25A9@BL1PR12MB5157.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-20T19:58:34Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=97d9e7da-77bb-44ac-a394-83cf2076ec21;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3b7244-387e-4763-a54e-08d9dcc79996
x-ms-traffictypediagnostic: MN2PR12MB4077:EE_
x-microsoft-antispam-prvs: <MN2PR12MB40772017E849BC37283876F8FB5B9@MN2PR12MB4077.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBeUdTyiY3Qi4mm49b6plw0aDhUP+FI8g/I8tH1YTz/jX7xStQPSFb6BevfgOLT5UDxkgsnpBhiid0m4WwH6J0F2txsK820ZyzfpRauKc10gsJdaH8iZMX3gSrCHonvkhUaDPU+bgIeYV1u1PTzOfLZYbDTuUd1unTtaYTjqYvzzMjGjPg6Cyi8gjHxPvU+pVZxw/hNOD16o+WmAwweotRgPy9+HDbNnUBUHhhMfHj6Qc7alzAzWsHELk4h91qMkoRmSsGNLYdhDvkP1MBcVrKLDSqkL0ndhMk+besYxR+IwsPyaudGV3iIrIFtoDyePMpIwRNaXk6OdH0Xf6zWIjcZdWn8YV4hao1a/iTJ2/4mm04+Y7bddD3WYmwWFwytR0uDZbch0kDbLzlaiFOCpzJZ1CyrPFUtLiwlQA2BA9PmlSGBFARyD40ZUQn0YktAsk5mDMaHZSnwXx6KAYC5mdKT51GqtAKq205gR2maoXjhfGuTlDTljlV6prt7OYifnjWVek3YZsLhOmhaz3IBr4E6s6Drn+axXB2q9xUXCy4mF4bNmY/g5X7rzirZx+pa8n2ouJeKUFO2Sm+12eJKIdeMIvcJkbSmRj8y2rqawVUG6FU3FFN6hfly8Ko18Bgx82ajJygQdT33wAyIc1q0UMppvQegjL0zTT3Gdf/M3Ped5iOKRCYIb7OintYN7JhBSIURtwSb6FpViqgldvXrQM9iuBiwzi+JtA0o6eJs0o0E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(26005)(966005)(6636002)(508600001)(6506007)(86362001)(83380400001)(52536014)(66946007)(66556008)(8676002)(64756008)(33656002)(66476007)(71200400001)(53546011)(8936002)(76116006)(38070700005)(66446008)(4326008)(5660300002)(316002)(7696005)(9686003)(110136005)(38100700002)(55016003)(122000001)(2906002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?beMZSxJiEqjydnDOmMFPbTwcl0QC6wxDKj7HZabL0jM/slV2YH2hSjmEONEn?=
 =?us-ascii?Q?vHyNqv6bXeySRNjDsDD0a9Rj30yJUc4EeZ5HptlDpgAig9KlSU3qGZkM70WX?=
 =?us-ascii?Q?ecQvSJPvtoIuUSzU0ykyUtAHUu4DTWPsy5MaYARDWHFlyYt9BgvsjF/Actps?=
 =?us-ascii?Q?awhT/N3NIjUDrdbqPUOilLwX/eysyPkuM3keQKy5Szot53BDRCAlugmoKLDZ?=
 =?us-ascii?Q?N8OpmZKD0M8gK32UmLdGp8ZaQRhHWorVjs6YLEB+WQGqq+9CbAfRKaAL3yJp?=
 =?us-ascii?Q?E5E1n/4S5hIiRwRRPdYeLNmteprMYJgEmmLL3+kaqEenWi4CUgFkn/JPDxiq?=
 =?us-ascii?Q?JsSZDyH9qgAj5qk1TcF/ypDu+ex2dzt1QHznJArX6R7vx3L2v2suAd0Doa3k?=
 =?us-ascii?Q?Fnd6lj5p1+kFI7PacKhpVMqokvGXAmSRy/RZrc/5At7ArWmKnVu1+mVzw/e7?=
 =?us-ascii?Q?q8g9nK59nYI9MrVaKLMRFv/Y3U+4oCWLiS87R/hThm0/5zaEA362uJX7ReSz?=
 =?us-ascii?Q?C5Ga9PgbfjPSn9/fGYPibgndZA/LiuHwTxNczoZhqgHPOv37jIiFYjkAFAyu?=
 =?us-ascii?Q?HPjyiJS0Yu6Ywt96hKZsoxuLiyDpVRd84W7CH88XjH79Ec2DleiGinojmmrP?=
 =?us-ascii?Q?GqVm2UJyr6LDU+NkwlLQQhYtcS+DdS5ww9okE6IRXVYSv1Fd/M0t5RFhTi9O?=
 =?us-ascii?Q?WKPqT17mnwNWW2rD7kmJBWhj9IIXkP1kaCPYYWa5oU2YYREyxBYpKfVVy0FR?=
 =?us-ascii?Q?zXVksw0xUM545CtY7Ifdr2pK2Scfczgkd7GxpUFbXGuDaZc6fQxrWxO36ah6?=
 =?us-ascii?Q?Dp05ZNy1poH0b9L60SERuh7y8JgRoHX6+ANIL2mJWyQR9Beh98y1dUpg+UYw?=
 =?us-ascii?Q?ixm38rRh/PNNFiJCX54yxT1VjB8HHTdtjsnEMhiV2mKKQyIhj1QhmdA7zf48?=
 =?us-ascii?Q?lK8eTbhORdKbZ/zVQSt/MuWK+pMIzUQjApA9rVTUV02J5QyMfnkUN0rNqOcz?=
 =?us-ascii?Q?u2JnBQyW7NLr1pybZcjzGDAUkSDFIoRhViiOZs+08td6AlZz1TQfhLJBdi+p?=
 =?us-ascii?Q?hmiHUHHK7nv84KM2Jal5QI9wvH8RyniyY3t8FGlj723KU1mX2UxhPaqiZY8z?=
 =?us-ascii?Q?kQ15AFhwbe2IJ3n7h7fV3KQre4R/PfwCW+ZU/Zj1lp8/3Ud1LVn8k//JDG6y?=
 =?us-ascii?Q?9Shfe7/aEsa/np62vxY2l1YeVQo3sslR48c/YH3yXfUcioshSp8aiUk8j9DA?=
 =?us-ascii?Q?nDivoFad9XC7WoLqhNSqNvXQm7erdKtFI33bMnpn2VM3bYc3pr9oF2b2qP3W?=
 =?us-ascii?Q?3vogD6YwmRx/1QO2kxs0Y7jizfhfzn426idEdY4/zD3RcojAR8UdYuCBjZu0?=
 =?us-ascii?Q?NUHd2n1Y6cQVA+cEsf+SQ+cjnm00uN4oD/d+iIRSSGgFWtvBhlLtk9Eubge1?=
 =?us-ascii?Q?3V8F3P4SjBifwNNjA3seiGmG+8/ez0FUb2p74Nlvr19aKg9vTvXjQoq0dVQT?=
 =?us-ascii?Q?8JXiVF6e71UY9Vjif3dI9rxl+ZURHtHOzM4kfAlzdETTzic7x2ohF5N9AA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3b7244-387e-4763-a54e-08d9dcc79996
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 10:20:08.2087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/48xpq5fiATNS7p90UYTLqoITZYeFxDAZasdkbVWfbO6HEfSZJmIiDI4o/C4ZJf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The S2idle suspend/resume process seems also depends on the CONFIG_SUSPEND.=
 Moreover, why this check function still return true even when BIOS/AMDPMC =
not configured correctly? You know we still looking into some S0ix abort is=
sue and system will run into such problem when mark those misconfigured cas=
e also as s0ix.  =20

Thanks,
Prike
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, January 21, 2022 3:59 AM
> To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Lian=
g,
> Prike <Prike.Liang@amd.com>
> Cc: Bjoren Dasse <bjoern.daase@gmail.com>
> Subject: RE: [PATCH v4] drm/amd: Warn users about potential s0ix problems
>=20
> [Public]
>=20
> Add back on Lijo and Prike, my mistake they got dropped from CC.
>=20
> > -----Original Message-----
> > From: Limonciello, Mario <Mario.Limonciello@amd.com>
> > Sent: Tuesday, January 18, 2022 21:41
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjoren Dasse
> > <bjoern.daase@gmail.com>
> > Subject: [PATCH v4] drm/amd: Warn users about potential s0ix problems
> >
> > On some OEM setups users can configure the BIOS for S3 or S2idle.
> > When configured to S3 users can still choose 's2idle' in the kernel by
> > using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> ("drm/amdgpu:
> > always reset the asic in suspend (v2)"), the GPU would crash.  Now
> > when configured this way, the system should resume but will use more
> power.
> >
> > As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> > potential power consumption issues during their first attempt at
> > suspending.
> >
> > Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> > Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v3->v4:
> >  * Add back in CONFIG_SUSPEND check
> > v2->v3:
> >  * Better direct users how to recover in the bad cases
> > v1->v2:
> >  * Only show messages in s2idle cases
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 21 +++++++++++++++-----
> -
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 4811b0faafd9..2531da6cbec3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1040,11 +1040,20 @@ void amdgpu_acpi_detect(void)
> >   */
> >  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)  { -#if
> > IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> > -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> > -		if (adev->flags & AMD_IS_APU)
> > -			return pm_suspend_target_state =3D=3D
> > PM_SUSPEND_TO_IDLE;
> > -	}
> > -#endif
> > +#if IS_ENABLED(CONFIG_SUSPEND)
> > +	if (!(adev->flags & AMD_IS_APU) ||
> > +	    pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> > +		return false;
> > +#else
> >  	return false;
> > +#endif
> > +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > +		dev_warn_once(adev->dev,
> > +			      "Power consumption will be higher as BIOS has
> not
> > been configured for suspend-to-idle.\n"
> > +			      "To use suspend-to-idle change the sleep mode in
> > BIOS setup.\n");
> > +#if !IS_ENABLED(CONFIG_AMD_PMC)
> > +	dev_warn_once(adev->dev,
> > +		      "Power consumption will be higher as the kernel has not
> > been compiled with CONFIG_AMD_PMC.\n");
> > +#endif
> > +	return true;
> >  }
> > --
> > 2.25.1
