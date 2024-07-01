Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFF1C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 13:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D0D10E40F;
	Mon,  1 Jul 2024 13:14:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJowjakn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 989D810E40F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 13:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGOy/MenozGpjGSzoVlwGt6c6AQ9IJtDw9PizVlfhBP2H+z3J6oNBk/xi5h/3NHaUEv4l0UlhCaGz8aH/TTaM5+X32/JH03S1hYYQUI6kGr48UPcj3QKNJhZ4OvQNQ/oITvrEkaTcmpK7xF4R3o3hFnskI/P4VQvIMcUt5CGCo+XHdG/JzGDrE9YjVLGVqDVY4xB/4L2nVafA6XgPwu0sfPqRD3nVagsiR8l00mX0qp2ogvitpHkZM5wMGMBVUhUE1ebz6W9p9/VdgaJ2rVRLek/xDME8LZxqLOr1AeXLgydYqlDuJG+cD7qUl+izHWVCz++/nN01rJ6geHbOR7YFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2zX507v1/gS4axn+WKUhT0+PXYx0D7nL9M3lF1Pqcg=;
 b=R5Icw/Suy4OrxJioG0QaMs84AbDst8FNHpg+auInT+hTfTaPVgJR1hcZD9ZWfw2vYux4/kApGwj+k3Du1vOjiJ7aAZeJ33cE85n2ogGzomorK2eI4u9RJPAD/6E/N4bEqz0L5yTSHoQ42VcI6ETFszu+e7p+SUztfJwPpzGq6ICYq+Z7bx7fmRPjzIWHVI4vNK93NWMjrwWpnBheYQF4u/D4g36pvTxbIfJjtur47CggsYPxGRBSQCvD9zBcb469ohF24w4Y+zdWNnsCIOUkrvXNO+6BNfGj4b6kIn+AtAog91w25ktc6BiutTWzj/PZ4PFZ1+dvYXgjhIu6vyYmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2zX507v1/gS4axn+WKUhT0+PXYx0D7nL9M3lF1Pqcg=;
 b=GJowjaknb4d5DoS/My548F1Yw0y8orIdBJmwP6r9yZC7xkAflxi2OuhPKg8P9XuvF396nZx0LiOTE/6Qza+8fTwoFPs2TubRoxP152c/0WH4wA/ilG9qpFh6RjkZOMPKsOuvOVPtEkmfeUnIlJLFCrerAzUdLMWJDNwHO1iva24=
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 13:14:03 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::3715:9750:b92c:7bee%7]) with mapi id 15.20.7719.028; Mon, 1 Jul 2024
 13:14:03 +0000
From: "Ma, Li" <Li.Ma@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Topic: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels for
 SMU v14.0.0 and v14.0.1
Thread-Index: AQHay6Ovra2j9AotSUW4mST8jLiaJLHhvWgAgAAWa4A=
Date: Mon, 1 Jul 2024 13:14:03 +0000
Message-ID: <SJ1PR12MB6075255F6AE1FC133B1F2E12FAD32@SJ1PR12MB6075.namprd12.prod.outlook.com>
References: <20240701104354.507531-1-li.ma@amd.com>
 <CH3PR12MB8074E005B23BD9557179384FF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB8074E005B23BD9557179384FF6D32@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=69874521-6139-458f-8dea-2e810a4966da;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T11:28:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6075:EE_|MW3PR12MB4378:EE_
x-ms-office365-filtering-correlation-id: 4bca4558-a8e6-416d-3ce3-08dc99cfadee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?oGrk9PD3/L5wgDDAoqJefk7fTe1j6Wxzx5gKtIuNh4VHFsdgaa/0RRHqiz46?=
 =?us-ascii?Q?PmORXKzcEHmXGiRgyR1vzlqm6U/O7G8GaJ964bcUdnzkK6x8ytCfuC3dG1SW?=
 =?us-ascii?Q?gPGShIt1UybkTiaiSUPNtQF3ZTTOuLecZG3/ma14DHzusa+BH0tkl/by2o/X?=
 =?us-ascii?Q?qsYADpBM/Ej69oEzBGcOB7emtFpxe1l7YKVi1Hu1hAqJspX2VDL0+EDmSYF5?=
 =?us-ascii?Q?SvhiZdmjnMqPXcFTP4Oo2ESQCQuKEEAqYwnSCiSrz8EF59qCC90X9Amu656S?=
 =?us-ascii?Q?RGslTTUsf1JZCg7/RFCWqx+UlQgL4H8dVzQj6LIKgBk+xjgpS0H8Kd+TIAUc?=
 =?us-ascii?Q?2FKH3wt0rpuazrtK3sNO6kNgcLF2QAwp3Mm/LIXnFhjLMJBRDgNNitFZE87h?=
 =?us-ascii?Q?+rP9woW+xvojfm5dVi1yA9XYc9g8hcNlTcP/b2NWJI7rUggdNSIYU5MsjckQ?=
 =?us-ascii?Q?/uVHQEaxsQ//3T4UazAZo+AE74IPIqsjJht5uTARR2UahRqRZRDhACGQDMfU?=
 =?us-ascii?Q?HnOcIYSk10tHhnPkBwMTYkuoOmrOG8LwYpc6kTpqd1DNgA2STqcdTsmzhVdt?=
 =?us-ascii?Q?Yy1eWJm90fqgYyaUsakw0ka4CYV4Goc/b2rzKGSxSSXLhlgpj4iXEWCSoJ8i?=
 =?us-ascii?Q?ANnVnj5Q6Daed8keKvKrHnECs6ZG1+gZgz85/ADlI1tYGfbjGAJrpGEmdR2T?=
 =?us-ascii?Q?k/b6wtQGDkoHiKJBjV55woUWRLZ9cTT6gD3C44FRD724bn3aXwYv1ir3noh3?=
 =?us-ascii?Q?al5a71fu3PDKWYjRJhjJhepGCx9k9dglo9alYbHrAfas2TVX6nBGk67GbxUx?=
 =?us-ascii?Q?h4uPc/2PxbNl4iSF8zy5NmxjTpWuhwassM+tjlwxzbDUu89q/uEPBIdbR1Zq?=
 =?us-ascii?Q?JQn89TkELqk+bXkhDZvoWK00P4m6egArXok0glJqgCjyePcs1qyke3RrCdPE?=
 =?us-ascii?Q?t4JnfvmqrUBC5+Jnlv+2/kHvkIcg8h/fH6Yx5vsrSJ5/heLf07BV5TDk9X3Z?=
 =?us-ascii?Q?zijmPQaoVsaJK9R9exsajHidDBVXyzckyyemUJ/2gRQPVCeSIjkviwkbdEPK?=
 =?us-ascii?Q?lSoxqq3wOOL5RNj6WxnhUY6INAiENyQBIqkjpFf85xNZHan1EGjeO0peysy1?=
 =?us-ascii?Q?YCE84d4WhehTwkS+j4KEaVuMbFjzNVj3K3e0/YVAQ8wgAUr8+eA/ZaaRnVfh?=
 =?us-ascii?Q?C6C1YOe5Rqw2PkD7TYSznOHyKJsaqzjUINzp7g4fQK4hhDordH1kEi6cAoUI?=
 =?us-ascii?Q?r8RnqSPeKLt+Xo37dadceusAo5Hj7tyWqUNiAxsheOspNR9BT8gvunS8HpNp?=
 =?us-ascii?Q?FaztSCVETqA/zcsz+GdcFteaumlmUQmWQctxQUkO0011e+qWKnH4HK2m4ws3?=
 =?us-ascii?Q?Ifys8NXqOrceiILFSjU8Uo1O6zGLnOMUnmsPnf7339xaA5WkpA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k5s7drGg8xCkdqG39V5Rjwjc24PPDJ1/ZULY57H02oZZQLRdYvI4hFgoTvcX?=
 =?us-ascii?Q?Uta/Y4P2g4dC1PLKwAuQHhh4SImiFhtgXdvPACbLHFJKXc5geCKMYNDiJJ+e?=
 =?us-ascii?Q?eSInThnz5LR2rktNb34yFMHXXRGe5H3kE4x3ihNXRFDUwCOrc0eb+oDQtq2f?=
 =?us-ascii?Q?SuhDsfenM3UnogKOMNjh0c6ZknW/jwuOV6uJQbk4jG8WTZTzD42F9t/IATCW?=
 =?us-ascii?Q?SzuEPnWj+FGmumiZRPGfOnWYQZaoGIsn7dRzJ36M9F6+S1m9fJE4ET6ZZKkv?=
 =?us-ascii?Q?uAQOvgZ05xhvkZgOXjZ3j7ek5Cm2orZbDkh4q7TN6ysBdtJVJbxTvg7ENLln?=
 =?us-ascii?Q?3aq/6SPnqw2aLzmkuWp/MfU5osYx+s0cHM08zQepDNJ6i9QjpuASQAGEfWRx?=
 =?us-ascii?Q?WykXeDHxz1Eo9qWStD9G0KavHCbJOqz7Bw3mX72oHaDK5vKf4rWh6/WmkQcS?=
 =?us-ascii?Q?uqAmrFImZNROxD+JThatR9UMXuUgN2xNCYqZZoNzrKKzk+FPe3oqYdEnhC1B?=
 =?us-ascii?Q?MAjMu7pd/6KYEbsUl6ZB0cX22Qx3EVzyI4dydRRa0aOmBMN6KRdIelDaq7lw?=
 =?us-ascii?Q?V5TT0MBaCci5KwkirQrdqjs4ki9g/AQi4sLeVxmkZpetVDJKBiidp4aZTBA8?=
 =?us-ascii?Q?mvJV11HBR4A71IWRSTkc2Zdg90H39i9Ad5HuM5IihYVXTuzK1Cja3gcGHgi/?=
 =?us-ascii?Q?dzYGEB+xK0IrUJZ4dbGEIyE9hOPMg/HQhiM5ZGbVS4dFFPqvdqKDJdXkwTZ7?=
 =?us-ascii?Q?UKt8zGWqT5Zum+I4xaR95M9KG7d5aQUlmI8y8Kx00VqZavalirII+eGzN6DF?=
 =?us-ascii?Q?F/mgfQ6v8PkAxh1WsN6VsS1u46i3PdBD1czquLHJp02Bpal42cRyHRRCsIzc?=
 =?us-ascii?Q?A9tMgblD6lwCPt7wtxcpbAuBToFygOSZLfxx/DMnt20WPvlvTt3WEV6zUfG5?=
 =?us-ascii?Q?7QUnRnbkmOvCWDr+PrfFBSU7M9KvlP5HZ3B5J4r71iMs3KKqmALm69d3y/i3?=
 =?us-ascii?Q?D/ssuJG1GZe0lzLS6IOlJxBk+4gyA3Lov9crOLm3q5YWc1xHpBjiPjPn+ywP?=
 =?us-ascii?Q?MUB0uudoiB3EWx4t1uADtlZRGdMC5kScqOHFgRQJ9NS5Rm6e1G/bmN/TAxUd?=
 =?us-ascii?Q?IzUOSGcuDmUWRtdCxZpqPjhpSch/0s4qnF/nIH+wXZVxWPh+5UBr1X+4KJ9I?=
 =?us-ascii?Q?6c5Mz6IqqxNkf6u4Z5gJWVRnndNWUvoEJZI+cpH3b+5hbKQWDoJ7YEMYikOJ?=
 =?us-ascii?Q?i/Nh/8OPwweyGZf7rzzmajUBO2qc0TMSFRcz8qxrkFvXEwquGGFttHl6Pb3U?=
 =?us-ascii?Q?tf3FtYxAPkAko1EyBzJZ487T/IunxayXOHwnbQiqEPTUTpcnOvio3HE2K/u1?=
 =?us-ascii?Q?poeYuN/mhsr1YdHlq6H6nc//uyebI7dRLkqrVtzJL5Ivpop/IjmyCEr/n5BX?=
 =?us-ascii?Q?w/U93gLNCV6ltyynC5TtN8+xpThjZZOqM40bz+S1/miwfz7Phm2I528T5ZSl?=
 =?us-ascii?Q?FxYSiWhlVhGOFHep/F5VmYVl+HwAODSZp3DyielWeY9jrkmrxJKIAcflFv4E?=
 =?us-ascii?Q?jIZFnkbZaZbF0dAPkxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bca4558-a8e6-416d-3ce3-08dc99cfadee
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 13:14:03.4751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+ZYzFOGoX0T++ScX9x8SVK41b7m/Boq53pRcMEdngGnUO3WCUljscZek/Gj3UmgrbGe3JLmvfZToOAdz30ivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
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

Hi Tim,

> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Monday, July 1, 2024 7:32 PM
> To: Ma, Li <Li.Ma@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>
> Subject: RE: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels
> for SMU v14.0.0 and v14.0.1
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Li,
>
> > -----Original Message-----
> > From: Ma, Li <Li.Ma@amd.com>
> > Sent: Monday, July 1, 2024 6:44 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> > <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Ma, Li
> > <Li.Ma@amd.com>
> > Subject: [PATCH v2] drm/amd/swsmu: enable more Pstates profile levels f=
or
> > SMU v14.0.0 and v14.0.1
> >
> > This patch enables following UMD stable Pstates profile levels for
> > power_dpm_force_performance_level interface.
> >
> > - profile_peak
> > - profile_min_mclk
> > - profile_min_sclk
> > - profile_standard
> >
> > Signed-off-by: Li Ma <li.ma@amd.com>
> > ---
> >  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 138
> > +++++++++++++++++-
> >  1 file changed, 131 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > index 3a9d58c036ea..72fca481dec1 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> > @@ -65,6 +65,10 @@
> >
> >  #define SMU_MALL_PG_CONFIG_DEFAULT
> > SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
> >
> > +#define SMU_14_0_0_UMD_PSTATE_GFXCLK                 700
> > +#define SMU_14_0_0_UMD_PSTATE_SOCCLK                 678
> > +#define SMU_14_0_0_UMD_PSTATE_FCLK                   1800
> > +
> >  #define FEATURE_MASK(feature) (1ULL << feature)  #define
> > SMC_DPM_FEATURE ( \
> >       FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \ @@ -818,9 +822,11 @@
> > static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       break;
> >               case SMU_MCLK:
> >               case SMU_UCLK:
> > -             case SMU_FCLK:
> >                       max_dpm_level =3D 0;
> >                       break;
> > +             case SMU_FCLK:
> > +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     break;
> >               case SMU_SOCCLK:
> >                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabl=
ed - 1;
> >                       break;
> > @@ -855,7 +861,7 @@ static int
> > smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       min_dpm_level =3D clk_table->NumMemPstatesEnabled=
 - 1;
> >                       break;
> >               case SMU_FCLK:
> > -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     min_dpm_level =3D 0;
> >                       break;
> >               case SMU_SOCCLK:
> >                       min_dpm_level =3D 0;
> > @@ -936,9 +942,11 @@ static int
> > smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       break;
> >               case SMU_MCLK:
> >               case SMU_UCLK:
> > -             case SMU_FCLK:
> >                       max_dpm_level =3D 0;
> >                       break;
> > +             case SMU_FCLK:
> > +                     max_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     break;
> >               case SMU_SOCCLK:
> >                       max_dpm_level =3D clk_table->NumSocClkLevelsEnabl=
ed - 1;
> >                       break;
> > @@ -969,7 +977,7 @@ static int
> > smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
> >                       min_dpm_level =3D clk_table->NumMemPstatesEnabled=
 - 1;
> >                       break;
> >               case SMU_FCLK:
> > -                     min_dpm_level =3D clk_table->NumFclkLevelsEnabled=
 - 1;
> > +                     min_dpm_level =3D 0;
> >                       break;
> >               case SMU_SOCCLK:
> >                       min_dpm_level =3D 0;
> > @@ -1268,13 +1276,67 @@ static int smu_v14_0_0_force_clk_levels(struct
> > smu_context *smu,
> >       return ret;
> >  }
> >
> > -static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
> > +static int smu_v14_0_common_get_dpm_profile_freq(struct smu_context
> > *smu,
> > +                                     enum amd_dpm_forced_level level,
> > +                                     enum smu_clk_type clk_type,
> > +                                     uint32_t *min_clk,
> > +                                     uint32_t *max_clk)
> > +{
> > +     uint32_t clk_limit =3D 0;
> > +     int ret =3D 0;
> > +
> > +     switch (clk_type) {
> > +     case SMU_GFXCLK:
> > +     case SMU_SCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SCLK,
> > NULL, &clk_limit);
> > +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SC=
LK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_SCLK,
> > &clk_limit, NULL);
> > +             break;
> > +     case SMU_SOCCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> > SMU_SOCCLK, NULL, &clk_limit);
> > +             break;
> > +     case SMU_FCLK:
> > +             clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> > +             if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_FCLK,
> > NULL, &clk_limit);
> > +             else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MC=
LK)
> > +                     smu_v14_0_common_get_dpm_ultimate_freq(smu,
> SMU_FCLK,
> > &clk_limit, NULL);
> > +             break;
> > +     case SMU_VCLK:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_VCLK1:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_DCLK:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > NULL, &clk_limit);
> > +             break;
> > +     case SMU_DCLK1:
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > NULL, &clk_limit);
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> > +     *min_clk =3D *max_clk =3D clk_limit;
> > +     return ret;
> > +}
> > +
> > +static int smu_v14_0_common_set_performance_level(struct smu_context
> > +*smu,
> >                                            enum amd_dpm_forced_level le=
vel)  {
> >       struct amdgpu_device *adev =3D smu->adev;
> >       uint32_t sclk_min =3D 0, sclk_max =3D 0;
> >       uint32_t fclk_min =3D 0, fclk_max =3D 0;
> >       uint32_t socclk_min =3D 0, socclk_max =3D 0;
> > +     uint32_t vclk_min =3D 0, vclk_max =3D 0;
> > +     uint32_t dclk_min =3D 0, dclk_max =3D 0;
> > +     uint32_t vclk1_min =3D 0, vclk1_max =3D 0;
> > +     uint32_t dclk1_min =3D 0, dclk1_max =3D 0;
> >       int ret =3D 0;
> >
> >       switch (level) {
> > @@ -1282,28 +1344,54 @@ static int
> > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > NULL, &sclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > NULL, &fclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > NULL, &socclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > NULL, &vclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > NULL, &dclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > NULL, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > NULL,
> > +&dclk1_max);
> >               sclk_min =3D sclk_max;
> >               fclk_min =3D fclk_max;
> >               socclk_min =3D socclk_max;
> > +             vclk_min =3D vclk_max;
> > +             dclk_min =3D dclk_max;
> > +             vclk1_min =3D vclk1_max;
> > +             dclk1_min =3D dclk1_max;
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_LOW:
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > &sclk_min, NULL);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > &fclk_min, NULL);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > &socclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > &vclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > &dclk_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > &vclk1_min, NULL);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > &dclk1_min,
> > +NULL);
> >               sclk_max =3D sclk_min;
> >               fclk_max =3D fclk_min;
> >               socclk_max =3D socclk_min;
> > +             vclk_max =3D vclk_min;
> > +             dclk_max =3D dclk_min;
> > +             vclk1_max =3D vclk1_min;
> > +             dclk1_max =3D dclk1_min;
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_AUTO:
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK,
> > &sclk_min, &sclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK,
> > &fclk_min, &fclk_max);
> >               smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK,
> > &socclk_min, &socclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK,
> > &vclk_min, &vclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK,
> > &dclk_min, &dclk_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_VCLK1,
> > &vclk1_min, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_DCLK1,
> > &dclk1_min,
> > +&dclk1_max);
> >               break;
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > -             /* Temporarily do nothing since the optimal clocks haven'=
t been
> > provided yet */
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_SCLK,
> > &sclk_min, &sclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_FCLK,
> > &fclk_min, &fclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_SOCCLK, &socclk_min, &socclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_VCLK,
> > &vclk_min, &vclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_DCLK,
> > &dclk_min, &dclk_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> SMU_VCLK1,
> > &vclk1_min, &vclk1_max);
> > +             smu_v14_0_common_get_dpm_profile_freq(smu, level,
> > SMU_DCLK1,
> > +&dclk1_min, &dclk1_max);
>
> We should not need to set the VCLK1 and DCLK1 for SMU v14.0.0.
>
> Tim

Li: Sorry, the change in V1 is missing here.
There is a "else if" condition in smu_v14_0_common_get_dpm_ultimate_freq:
+       if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(14,=
 0, 1))
                smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
+       else if (clk_type !=3D SMU_VCLK1 && clk_type !=3D SMU_DCLK1)
+               smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
 This will avoid to set VCLK1 and DCLK1 for SMU v14.0.0 and v14.0.4
Or using smu version as condition is more reasonable?

Thanks,
Li

> >               break;
> >       case AMD_DPM_FORCED_LEVEL_MANUAL:
> >       case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> > @@ -1343,6 +1431,42 @@ static int
> > smu_v14_0_0_set_performance_level(struct smu_context *smu,
> >                       return ret;
> >       }
> >
> > +     if (vclk_min && vclk_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_VCLK,
> > +                                                           vclk_min,
> > +                                                           vclk_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (vclk1_min && vclk1_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_VCLK1,
> > +                                                           vclk1_min,
> > +                                                           vclk1_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (dclk_min && dclk_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_DCLK,
> > +                                                           dclk_min,
> > +                                                           dclk_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     if (dclk1_min && dclk1_max) {
> > +             ret =3D smu_v14_0_0_set_soft_freq_limited_range(smu,
> > +                                                           SMU_DCLK1,
> > +                                                           dclk1_min,
> > +                                                           dclk1_max);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       return ret;
> >  }
> >
> > @@ -1520,7 +1644,7 @@ static const struct pptable_funcs
> > smu_v14_0_0_ppt_funcs =3D {
> >       .od_edit_dpm_table =3D smu_v14_0_od_edit_dpm_table,
> >       .print_clk_levels =3D smu_v14_0_0_print_clk_levels,
> >       .force_clk_levels =3D smu_v14_0_0_force_clk_levels,
> > -     .set_performance_level =3D smu_v14_0_0_set_performance_level,
> > +     .set_performance_level =3D
> smu_v14_0_common_set_performance_level,
> >       .set_fine_grain_gfx_freq_parameters =3D
> > smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
> >       .set_gfx_power_up_by_imu =3D smu_v14_0_set_gfx_power_up_by_imu,
> >       .dpm_set_vpe_enable =3D smu_v14_0_0_set_vpe_enable,
> > --
> > 2.25.1
>

