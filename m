Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC0AC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B552622838
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 01:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B552622838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627EB89BAE;
	Wed,  6 Jan 2021 01:00:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BC689BAE
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 01:00:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXWsgEyqJj9/aqCruQ+d5Q3v6WbJWlRIf9ZHsPuaUxVVSHgdQwk85P8UfWeMp3McQVe9MFcPXmV4qNaxWqPxlQ8LYz+/AujNX/7HUc+CeFBCyd1UzoVOI6BkX6vScPPi0+ObUn64uIg6fsp8FsZ6AZGdxpn+uqmll4J1FVcSvYsyehradTIHRkkhMlpXGs2duQit1tY+L6meTqOfdM1mpXSiy5tc2AbX+KxIEuneb/92vOdvUFW6N8m6N3LxgiCM9gxE1M2NxaqAPCoydThzL8RBB17GGixLjHW7v3T+IpyvpbIUo6GCeeSDjMgFLVorTe/DDsPTBPQP0r760qgt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlnI2czR8XzKG/UYUoiaFUJkQ+McyTo4Kt2MzjnKKMU=;
 b=d0ENNr85vFMBfnZ3aCihoAnCZ9xmDNoAfsOyELPkWCqYRu9HBTQBc2uBnv0UbHNJxdZiWubbfCaqj3m7lE6MHmr3RxVd9iDAWnRNq1uWFGb3NUWSNueotTY3tVJeEerNluhdcTPUME1x2EO3uJMENQn8++jtWDdZiL3EVoNuCjGdJOSIDGlSyBXNiRC90RGbvUVCA5VYUZXEojqWBSNPU/H1Vn2d6eshNJtGyHe7qIPWCgAYez61W38pZzf49BepqclhuBo4Izoei9qxMphTyVhRhfhkK5QMu+d9/DZFaDLH1GL+O/JKC9vHePXqexNhTCav9aPTzUCVNiFL8v/ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlnI2czR8XzKG/UYUoiaFUJkQ+McyTo4Kt2MzjnKKMU=;
 b=jRyi9p9v3DSP3x5wMegSacyMNUKUaqFDfh1P4suoHQesyPiB68hIfiGxshMOGV+qdEKJG1LLoKYoKHRUhbb/XRS8URga8cUCd6YrkCUT8uEXaxOGlzg8UI2tStvMz9grTnkQd423bJQssfW3Qih/L5+O62+NMfozKl6fIzFljGc=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Wed, 6 Jan
 2021 01:00:51 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 01:00:51 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Topic: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
Thread-Index: AQHW4z4FDShH9W9orkGznXEJ1V0mEaoYvdaAgAEJ10A=
Date: Wed, 6 Jan 2021 01:00:51 +0000
Message-ID: <BY5PR12MB4115B21735D09F0143C9E7878FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-2-Emily.Deng@amd.com>
 <DM6PR12MB26197F38CAFE5F594633E7B7E4D10@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26197F38CAFE5F594633E7B7E4D10@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3b0aa5a0-f583-4377-93ae-82c2435707a5;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-05T09:05:13Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.113.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2770bf6c-5a2e-4803-a7cc-08d8b1de8363
x-ms-traffictypediagnostic: BY5PR12MB3969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3969DDA54B2C9632912C88248FD00@BY5PR12MB3969.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vcknZ8GuOAZeP4dnwb8a8hFaQZFRPGUcsacBYmliIBhu55XqpFoC6S6LxpuI1LfhJOmXBkBSJqeUVbSUzQYXSDh/iFcXFk5+/ZmCr/50RIUyPprtdAHeACxR4bbf0pQpDBfLHdGo/5lfwz7OwxR6fw+7Ykw2hvQZXR+E59n8nSCh1qgJgSDXg7bZ76AyPJXOFpmZC0wTDM4mg3n/qRbC6UzYa1JF40wGJfEzBrTFaex+xqFEywiK8WGd6T1YCsCrP6yC+YMGzqxNfIio1LYw6xzJrWiS4trTx2530bfuKcZDw97pg+4LJ8M7SDn4UnaUgDo/Bfv2bA7ky/C3ThLSMN5XVT1OCiEdVrpdQNnjL164TlCp2VBnvSTr9hzpsyhJh36TKiVQqdJiGCNaJrwr/q6HDMkAT+0Lo9S33KICO69B5MtW3NzckNPjWGqtDqD03jriUjC7nUal11pj+VSaDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(52536014)(66946007)(9686003)(478600001)(26005)(71200400001)(86362001)(2906002)(45080400002)(33656002)(66476007)(66556008)(5660300002)(66446008)(186003)(64756008)(55016002)(83380400001)(76116006)(8936002)(6506007)(8676002)(7696005)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+U18EttPsS40hQVh10RTsOdPno7APbVnTRhIO0/uN5tWpSD5pob5P68R3xKE?=
 =?us-ascii?Q?wKHjK7hPUxSlW6rf+32Zo+P9vacaKN1T96Wp1bIHvcW/uE7VF9vhvxsC8BM7?=
 =?us-ascii?Q?Y118MnK8XUuJdrS69Hgkwqn9xrdFv1d8VB5kHUXiHO+2uCSQ+c31fUXEhhCN?=
 =?us-ascii?Q?15lDmX/VqyLKzppc84mGq/WxqkzULREIsg5ASJYwdL9LZVcIiCm5Rd31Evcz?=
 =?us-ascii?Q?ITYLzZQ7jfpQlYou3aVAfOwwf99FvAF6y+9iNlgyNIFkBpc1j6x3gF5A0/VF?=
 =?us-ascii?Q?u9VD8Y28BE3pa90i44ziVQ4N8NtJvldoxFxkEtMNIEcI2jY3JimNrOD04JoL?=
 =?us-ascii?Q?Eh9LA9PLvEoT1SVa0hLu1lfvY8yWmMzr3lW2Og4bW22QYaNEgopvhLyRT9xh?=
 =?us-ascii?Q?mIC0JZlrDXUx4HBn0lNSsucMd54IOgoOZ/YSMxFpNC8gkmZcQ0n0d4gj92TH?=
 =?us-ascii?Q?XnvVxvB1ODZUaZ2Rdd7ku20aZQ2fTY9Gu1LBOJvnV12q+w3xronWK6rLApEW?=
 =?us-ascii?Q?dcxWpbhfTi45D4Cp7INNHm7DOweXgtR5X2M7LZDWcPQ84P9n45zjsF5rUlO/?=
 =?us-ascii?Q?5aXrI2JnaNESRPp8BtWHV0yfZuiV2fbFLEFaemLyvJeJX9DKAlorF+Qfn3CF?=
 =?us-ascii?Q?wbkcaYMQOYmrpEshEN+WhPsINF4HsJ9gqEKTQkCCfloKrlyqxhnykIAo4uaD?=
 =?us-ascii?Q?B3236M7c2+hNDaTxEqEK/pk/uctozJrHTaSaXC0ImNaoBDqPXI7LfNpNsEZF?=
 =?us-ascii?Q?CveC2QovpurKnuKa7DFHCEQrDrhgtAd9ijNhyL2mDxZw60eInBJWAyXsW9/y?=
 =?us-ascii?Q?nAl1PZpRXI4AZw7vYP1o0cpqZlBD2gR6ZNoaY4S424x/klNzy0Uuxvs6UZ5S?=
 =?us-ascii?Q?GGaSJ0I66LmS/84dpyFJ/C1OlbvKmLltCIwXE3mRGVrfG0qLHk4OrM3bseKe?=
 =?us-ascii?Q?Y5oSOoRugCHaYddFuyYMWZcz7cN/FWjEJDUJD6WEjMM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2770bf6c-5a2e-4803-a7cc-08d8b1de8363
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 01:00:51.7689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hnSBR8zpxtH5/KBZj29PzUOPXGiGwDHsKVUkYS5U8avZ1khr5XhziKHwkJ3DQG4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
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

>-----Original Message-----
>From: Quan, Evan <Evan.Quan@amd.com>
>Sent: Tuesday, January 5, 2021 5:07 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: RE: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
>
>[AMD Official Use Only - Internal Distribution Only]
>
>What's the issue with original implementation?
> And does other clock domains(e.g uclk) need this fix also?
According to smu team, after navi10, it will use dfll mode, for sclk read from CurrClock is not correct, need to read from AverageGfxclkFrequency in SmuMetrics_t. Will add this in comment.
>
>-----Original Message-----
>From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>Emily.Deng
>Sent: Tuesday, January 5, 2021 4:37 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deng, Emily <Emily.Deng@amd.com>
>Subject: [PATCH 2/3] drm/amdgpu: Correct the read sclk for navi10
>
>Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>---
> drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>index 51e83123f72a..7ebf9588983f 100644
>--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>@@ -1673,7 +1673,7 @@ static int navi10_read_sensor(struct smu_context
>*smu,  *size = 4;  break;  case AMDGPU_PP_SENSOR_GFX_SCLK:
>-ret = navi10_get_current_clk_freq_by_table(smu, SMU_GFXCLK, (uint32_t
>*)data);
>+ret = navi10_get_smu_metrics_data(smu, METRICS_AVERAGE_GFXCLK,
>+(uint32_t *)data);
> *(uint32_t *)data *= 100;
> *size = 4;
> break;
>--
>2.25.1
>
>_______________________________________________
>amd-gfx mailing list
>amd-gfx@lists.freedesktop.org
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C8f2af901fd044c097
>8a408d8b155289f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>637454326608630462%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
>DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata
>=mzE040qzS6j1%2Fy85pZgUE1q3Pl6LLYOIe6Z7S3zsxJw%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
