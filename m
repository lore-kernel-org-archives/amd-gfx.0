Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071E4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 09:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F91610E52C;
	Fri, 25 Feb 2022 09:09:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A01E10E579
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 09:09:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoR2IO4uTSBIots+81fjMDI4H3sV/MAdec9w6h0t74PSrjs2QXasPVaU++PT1RB65uFRAa0ikAIbJv5it7Sgx2EjrCw8MHxfLCy5KhoPxdqyhJXhpEi+QNPAwctTm84WXdaKU+q8U6RkX9J3bzcPhib8d7m3anzrlzSxX0ATTCZ9MKuzS12DIsb69p57xYKhslA9ieHkXkeT/T/2Qe6th38+Jh4FNjwPkIc56IEwqoJ7nmX64LkBKk9j8UMU4ErEpa58b9zGNZviFB+u8ZxAeN6pE4AXEHJmXm39F99CpS2hClMOPrcZlfon5237dQicjN/BCANQzd1lLRwvhU8XvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX3sp22miejX7uYWskJomqlm+6ZJ7R/URGQbXx9kiko=;
 b=dOuRNhDmEbdWjAy+nZR3Ilk5IPo8Qjd7JimUA7HEi8/zdcPIPk3wa49cPDe+iWN0dfxM8Q7hWYX3//If/qEEolDKu7E7avqtWeXmy04JaybXpihDNaEte0eN9Sn4DuhJKIm5V25t4sV/K4v6AjJkREUq9VeJF0TeybPgHHohC7OIji1yEQeTHv+r+QlVYtGuTea5QtOc3LAaZiiqLpIoUuNHZiF/2QPUT6Ud8bkjoDpZQooPYbITOYHFp1pPu+1TWfMGyAt3b7yhlvIiDPAQYrCNHRvbsIuW7Wo/ArWFfOKXu/ubY0/b72FvIbDtFDGZMhjenRjBe0oKHUccriOGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX3sp22miejX7uYWskJomqlm+6ZJ7R/URGQbXx9kiko=;
 b=fdbthx37fsw3mUmZ7Tjd+fZj80udCoJUjOtkplw3XRGHRRP/B+c1R8y1WjoA/O4B0Yg4XTQRthHfn8U9Dt5hKPpES3VF4S0TsktwKwFWHJJv2SDMdG8J5SITJHkbLbc1YCt9KmDxf3u9PbkcLOhaMpWEKKWIIqh5dlFbRdR+q80=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 09:09:00 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::6cdc:ce39:9104:b1a1%5]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 09:09:00 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5
Thread-Topic: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5
Thread-Index: AQHYKiSyNpLFs2xDsEWVP4UOlT8oJayj+keA
Date: Fri, 25 Feb 2022 09:09:00 +0000
Message-ID: <DM5PR12MB2504C989097828847C2BDA69EC3E9@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220225084939.2096051-1-yifan1.zhang@amd.com>
In-Reply-To: <20220225084939.2096051-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T09:08:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=399fedaf-d48b-458c-baf9-0aeab764e213;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T09:08:58Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 54d20932-ace3-4ac4-ace8-ad91b7ad41e1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfe4f7f0-62ea-42b7-80be-08d9f83e764c
x-ms-traffictypediagnostic: BN9PR12MB5291:EE_
x-microsoft-antispam-prvs: <BN9PR12MB52919B01965AA0C1AAEE141FEC3E9@BN9PR12MB5291.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YmmTIPZijR630X9wNFXy04eEYn+onj5vvv4PLTz5RUrnm6TCPKvin3wh8lzepaIKW7VmrOYuUBrs5G61n/H/hbbaje5RW4sQ/CUTTvcPjs9igRRIFQtv9Ok0G9feid0b2M4x/My2NiAXlENn8YcTOhwugM+ymUewkjTHCVB/GZy6W/STCe+REOoT5YPbERmKcZpn+gXSat0zP9PH3HApD2foi8D+6oeTq8pgMOAdJAx1OOdn7Gkd69H0yy5NH0x/zALB9RWevMCjHbMPkDIBgTEF+kWrWiaO5/wwZEo9FN0UQBYDIxI2jIlDWLf4pga3IEnRrehpmaKe8jIH2BxI0UwDmQMOtgIYM70mqn+f4odaAK0hSlG8wMLQ+AiylmQU0fQEgBA0Yb5LHWl5oAZrIBy/A2QjEwuSa1iOEPN5D+JzIaMh0d4Knp5QQx+yDI7P8NrL0z6ar/aU6jwNqL89J1GRauEpSP6rSUALPe+9WLJRZuJ8PkZQ7iy8FWFQdWnrTUSMSka+qCj4riZWknJ9DObQKq1BuIM54GY97hLRz1M73fY64uwqutgoj7hdCAAegYYO8Dw0NbyOhvAjuIObDC+YWPGgZ9JB/1uyIODzbo/c8d7C3k6tMpUyvXFIBgdbYZF+zyqWQIvAgFJ+wY/6b5wCbrWQt8eAW5UYEswWpHeGmbEmRh3QTOsfGWvTawaYmFbJLmBbyhswCH0kluHNw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(4326008)(83380400001)(38070700005)(55016003)(33656002)(8676002)(110136005)(6506007)(86362001)(7696005)(508600001)(53546011)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(186003)(316002)(9686003)(26005)(122000001)(2906002)(38100700002)(5660300002)(8936002)(52536014)(4744005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oelpjL/6jioZwEId8S2iy5gaFuHzHEAfgy2kLQ+vu1LuTX8DoWMBNT0hZRmW?=
 =?us-ascii?Q?aJqWPOI1Mbm87yShkexFJTmuU54YRZuRrBGsInp3vD8umZg6DZJg6Nkqv9bO?=
 =?us-ascii?Q?PyuXcTdZp7dU7DVvbS5HkDrq6EJeHXNpl83SgLorgUW3r3a16K6lanlOYaXe?=
 =?us-ascii?Q?7FmgJAd9h3x2S9UrJUDm0XMk5fGnU4vS7Gj7yn4p66Mn+ieNmr/0DawvrXRD?=
 =?us-ascii?Q?yrsPQtD9wzBRl9XvzMERMVqvvmAkCkWOsGp4nNzidIVn9NhdZfJI4VrjEZj8?=
 =?us-ascii?Q?O8wxMDORpX36gstpqlhNUlDJnTPtqI94X/ILnsp409xxgfMY6oZ3K5LofdFx?=
 =?us-ascii?Q?hwTYMIqMclskdhnMT0ROjxKlyQMPGci/WyhNHma09PXKjoHkA+fFnfymp3Qe?=
 =?us-ascii?Q?Ih21zlLygMw+3TCSs75UkXwo38I19baybBaXrU7pBMHNd0s+iV7kTSB169bU?=
 =?us-ascii?Q?6CLfDQpCoUOjbqea0qPu6orbNQSXkfk9D2KHBucxxVO8X48x2JrZcDrQsjPY?=
 =?us-ascii?Q?PbXuW9mcGMlcnWlQs5sFxqx8rh3MqAVaTTdlKHOB/++STBOCyRpNlZeplrrx?=
 =?us-ascii?Q?0QceHKU8jKz3tDBVgEzUJFbJjO37BM5oUCigp7MRy8F7OItX9AIdNXqjFYxo?=
 =?us-ascii?Q?HWcbPdPYs38bQcFFnrmZUg78ocexoiyf80fCeTxodQF6lhZdUdBiT+KH4jxM?=
 =?us-ascii?Q?4WQA4cJAJkDF+ZkhAUh8r7LQmiEQyJ1j2hqzMrkQybgS/PeJamrOmRojVoUI?=
 =?us-ascii?Q?j5F7xT2d8dXQpsVp80JtUfGBQDnSeJ2bNGUVCoDQqBjT7NxNDBxAN1Y5Rozs?=
 =?us-ascii?Q?ac6pMj9jNwib4B+r8YEbiucQphl/ti2kJ7ovVqgUjb4Z4RfdmusLiXCtHOWx?=
 =?us-ascii?Q?NxRkSQkr/8z5HHVlZH0kbNTIVxz4Yvsx87/mTn5GoNFKWLKxmH+KjUqo+VDQ?=
 =?us-ascii?Q?/LWAA7E77jMCYFfmDQ94pVkQDgMUWPTf3pSKZIsaiArV88QtluJdcPU18c3z?=
 =?us-ascii?Q?H3dWM/1nMAiUe0fJCNihV3wNs54sLHUARyu0+REJL2M63u78pGIdRjf6Ee5D?=
 =?us-ascii?Q?wI+E68nHK+OL2ZhA5DEKb/FWrNB0uGTx21UqfTjxq7X67Un/wY3YXZOuozpE?=
 =?us-ascii?Q?p+zEEL5+n3SkYJnykvmU6mgd7FBcf4pe6ttElfSMkLxA5nb36uV18vdX4ZQi?=
 =?us-ascii?Q?PI4mpA4/+j1QtXW2Bb1Bwmhx9mTcqbeSuCjoB0ViPlnLxYTaoS9kAk+KChIt?=
 =?us-ascii?Q?DulIwdddiFziwkLg1NtMO/yDrW+DPDZSZy0JS0hEdNYrUcQhOlJHwgXi3SgU?=
 =?us-ascii?Q?1C1dUzgOxmOPTrkmMnoOVY2tobibxsvx6xKCPL8lMVWQ3vpXyEDHjt3fEf/7?=
 =?us-ascii?Q?75xPKSgoTgwvBdvDF/I8kP5BhumKfzkPsErYOQeMF2kYG65yySU/p95WaXrs?=
 =?us-ascii?Q?xdcgatMENMW8hOyqUpFs7ar4XUF+EkPi6XSqMVAoLe3L+WSWesDfAVARC+ZP?=
 =?us-ascii?Q?SyiHXk3vzWPctDuSeLssJRLdwppL2eNVwjpLZqhVwfrNU4Ung1I75oaC9Xpg?=
 =?us-ascii?Q?aHRVOmC+/LfzZzR6uTCcO5WDp2raWvImUYD5aUTIn04WA1r8bkxtiwMXMRYY?=
 =?us-ascii?Q?zqXn2sBv17S/vtPF9UQWrzc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe4f7f0-62ea-42b7-80be-08d9f83e764c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 09:09:00.4615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1gxeh6OPdNRvFMnNsatDHiHZAi6s9hbtDAvtHtLPK5vyzW/7mNYHz6mhr42LXI1z/WPHMHsqY6cG9IKWJNHLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5291
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Friday, February 25, 2022 4:50 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add gfxoff support for smu 13.0.5

this patch adds gfxoff support for smu 13.0.5

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index 261a3749c089..4e557f4f7c4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 5):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
--=20
2.25.1
