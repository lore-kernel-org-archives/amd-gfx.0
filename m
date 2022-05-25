Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76CBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 05:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 656A9112BB2;
	Wed, 25 May 2022 05:59:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75CDB112BB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 05:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtSyI/YDb2XTVHtENEa1cZRx0Tq/D9Es1j2to0/BjCKWRZXPai/tqeymTX4rpjJH1E+8yMW8XvFxlqFz76+Uln2Kw/bDqN7MUx7cTkZvF/jq74S1SHPk5IDQ2Y1ojkEAOWqnZKUTy9STKg9oXztsz0wQBFHGT6/1hNy03gtk4dUx6Fb4sbtsznjlVV0rwMpIgdGxHitABtZUi49ZjaqfUSRgdFBel8z4wQxrZuoblNPupJZtgV2fXXpaYcpo9WcSBm+B/jFhw/GMI2ssQSJ6T1AhZQ1RbydOeRMmNIrQoPgRvB1LcCW+K3jEaW+4Q1x2/3lbLRNpM8rt3LrZ5ezn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx3zlskTpFILPjNwyZPHqnYePxqUpfsPZE/2PkKAeQU=;
 b=UqOyBiDL5/bUHTQM+yVFX0HjRXoW3Dnsc9sLaw1pogr70ZIVkS/MfyeJymTgG8reRul42NcCFf+c5n4Xqjy9SRxOTsywJV2iPmZOer0d5hCuixgE7E6uS/czB+5E47CdWFuPkiVdxSw9ztY5mCgktP8fjQYXF8+dcXErj+fuWr6zftp851wj79ia9syX4H4FeuhHFAzZ3pZnocFrLaVbQWDQ8Q+m5tsbFSeSYY3wlyQHj6t2Y7b13XzFf6FesTxqkt+XJAmjg78dxfec7Z/bg+8NxvD6t+WJ4Kw53E3nBCTWgqMw4epYRapRulBbfpHzIq3Z0Mg46emzb1qFE2BNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx3zlskTpFILPjNwyZPHqnYePxqUpfsPZE/2PkKAeQU=;
 b=4JkooXvAELDd1cpACviQAcMs7/rOQQEAoYGKsX9PMyDj8kOz2Qwuv8LihlYqa5pL82CnUcOW63rGjq0Fga3peSzo1hRMphuG/VmZ5xu8jrZbh/ZanwB//BbCr0mNhlU9sUyAJNdbLfR0+QNbm3wHeW7xTYfwKNu432KVHYrpB7Y=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3593.namprd12.prod.outlook.com (2603:10b6:5:11c::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 25 May 2022 05:59:41 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::f9e4:75ff:738d:8050%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 05:59:41 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: convert
 sienna_cichlid_get_default_config_table_settings() to IP version
Thread-Topic: [PATCH] drm/amdgpu: convert
 sienna_cichlid_get_default_config_table_settings() to IP version
Thread-Index: AQHYb9yH7Vp5eNWD7Uup1Tg4CKvkQ60vGX0A
Date: Wed, 25 May 2022 05:59:41 +0000
Message-ID: <DM5PR12MB24692C64C24495A145734138F1D69@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-6-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-6-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39a3f264-0989-4c94-f564-08da3e13c26d
x-ms-traffictypediagnostic: DM6PR12MB3593:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3593C544976E3C93F3509C8CF1D69@DM6PR12MB3593.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOnKT4i/AlnKv8LvhMHleI5cFpFZOjy0TiitO6TfEFt/1PvEIqpJoiAqGAJ6qFxZ8BJwLpxvQO4bvcCkHfbOuEmu3xGsFVkzNVDeg0o43ZpG2lE2rBbXsxC533wxgMORNWYOUtoKGW+FVpf0a1NzfeAZyZDW0C8lxf4vl/5xCyXVE5KFtSncwZJpHaloj9WWb6upvtKuyOKl8q14eJDDspFcaKtK5ZPnigSfNzg4A6Y2xrtpBCcGSq/2CII+A4lpNBLb5wsCxzUWPNVrwGDSqtz2voKf6aHm1V9JtOHDNBJecU1+rsRZ/WW9lAGcmEno8Q11mEwVYbOL5RmDBW4piefKYQ2ACqgRMRroKV431+DpxcaViNYCKSIyI3CNYSdwUmmdu+87P5S9BTuxOpdnaDcVN5odCS9pqiW4O5xhlW02T8aZCBhwLe3VuCrNAdkM008a6N3U+dacrR+/Ql0BG7Zlp8plYFsEiUQnBXS4QLvyL6N7v7USdZwffoAxZMe4A2jtr9HBpW8BimfW5Vk/ES6s2WtiEp0DsAvu/YTE4qvChQ71DPLmjCwoDfcdemUL0rmzs/O2HrY3xFwtjmGFC2hPySW9GKjurqVeJqjad7EIGiTzwityWxXbOWz2y5EuERxE1BOtbR7fqhHcp9TCbkR2RNu9EXEzlAnPDBF3zvlcN9rifFn5TBZKaqOOFA3D4I6USBZUh7Hv+9+yj+4rLw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(55016003)(8676002)(64756008)(66556008)(52536014)(8936002)(76116006)(316002)(4326008)(66476007)(66946007)(71200400001)(33656002)(110136005)(5660300002)(508600001)(6506007)(2906002)(7696005)(38100700002)(9686003)(122000001)(86362001)(186003)(53546011)(83380400001)(38070700005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7hd7IUHQYNQGiCCmsQ4H1O4OixTLNS5L4w4Zf4x4YEqgicm7YhtlCY3QRvxS?=
 =?us-ascii?Q?TVJn06nnMtpU/m9Z06cJnjNJBPKlFqFWSV+Wkv/j+wYG8Yr8YbDor3ey8d29?=
 =?us-ascii?Q?WgmnfkuHHP3gQWKhJhuYjeZIpahWXO7lx5mT2cOXzOZ3N9KIJdbhEzqs+PQs?=
 =?us-ascii?Q?IqCbDVOiX3ebhGA2X75VGHrBBYU1L6zibjJk8Z2bQz3rfGKa+JL841uUvxOd?=
 =?us-ascii?Q?UGUHmM4WPFtnCbKbtd3wdveEJJ4SUC5fFgDaAs8qdVVCUMSfh/SDTw+mqlB4?=
 =?us-ascii?Q?Jd2J417RhF9uo9k4WNg9WCrjfjYPosOmiJP3wzYPUHvH1SlOmPUH3c5s8y2w?=
 =?us-ascii?Q?t8HpZdIgvgWntZ6nqwh/+/IxOW+W3zCsg3YlgtWfWpbnMuuvUYFMoxOJJlsc?=
 =?us-ascii?Q?mO9fyK4fYC2oed1E+614pK92PuWi5aAcJrz0zUFEqhLzIfpk3Z031U2iHrqJ?=
 =?us-ascii?Q?5B0q7hE04/vjrbVdXV7chE/ga1fTpXlEzzht1ZOQ2vXLO1az3J7iaJ6zlF65?=
 =?us-ascii?Q?lGx2c0rLze/sgoBT2fwrmjbDFzY6MAo1GI+eHHfwC20U+z81l8SXZT+iciko?=
 =?us-ascii?Q?FLSP3SfuNAyBPliihjjg8Yrixaz+YFYqLNl+GVl6jakwbDgsq4naguaFZMP/?=
 =?us-ascii?Q?9qzRDD9lF0i7L7cSQHeYhvBDb32/gxQzhlOJKpZffy6LWjjp0VtMk8WDcset?=
 =?us-ascii?Q?wYn40lP8cGs6y7oe+v+9FvN80853r+9QxMCWtwmtjlTVrir4t1PNT3E0+Nwe?=
 =?us-ascii?Q?yCPT5WbdL0zqe6pJvkb/4aPXgtEEVGXzIMhf9+YlJD65qLO+ksxY8AEA6G6I?=
 =?us-ascii?Q?SKxbFIYs0sV0hQTYcoWBHxHLNTShfbvaZjga5U9s0c9BKpUKep7/wBnS3nI6?=
 =?us-ascii?Q?QAJUErvr8WAOUNVcDhFoiIF7vUpP3MJvWJBydAaVqhsxVpsZTESw94RdsYLS?=
 =?us-ascii?Q?KZwfJX1MoEo6SQfKaVGp8hXwPeZCKTj6NbWL5rfpVdUcl+SCG1nGqwvehaBQ?=
 =?us-ascii?Q?6B2plGq0GqMcgtUH3mQgvkKJNI2bfGEfuNsR2E0pjnHk6BG9tBSy2qkn04W1?=
 =?us-ascii?Q?XwCdlCK/LEl+rlsrjUujAfLDnKXPtynsS3hkKATLB1ItiTyAbRxqZpSuMXIK?=
 =?us-ascii?Q?Ci7nFJBjYaiatNztuVBOd9+MRFKgsSPJkF58/JlIATLRa60INAng7DLUe/L7?=
 =?us-ascii?Q?4mrrKYmXsgb5OeJHdvAJEMZDh+J5WNgozefV/jV0zROTtzKf3oG7vo9Gpq+o?=
 =?us-ascii?Q?0rVsYSFCNhNwnx7MO9p1ZRe42kB/MUYq2X51vLyp6mYKg1lYns4Pm2td7ShN?=
 =?us-ascii?Q?ETgVNDRv+/ONRo4zayYlCtRCTYl5N2Ma8GKtWYDD3Xpd0BN86PvKk1Mi6dw3?=
 =?us-ascii?Q?qJl8QRnznuSJYMoaLdnGmAdd+05SXOGp6vmqie8L4kp+HWqqUy8T+TFIK1QF?=
 =?us-ascii?Q?aWpagwNtLbff23mxjmXqRFYnKNoKdRAdn7mZvVMRHGm4CNNYDJ2kGD+nwo3o?=
 =?us-ascii?Q?udx8xxfhvSFhGGSgTZ7YXYusoBfk/mEtTvJHPYdR54Kn2ZLOSR/ARYQUr9Fe?=
 =?us-ascii?Q?ikd5Fq7f+fpTG2asHhb3QKzQRt7ohKc3OXo60Ern8srfSdKXvGw8A1GMe3IR?=
 =?us-ascii?Q?eRFKGmXNEWxYIP0RynXg0qXXx0SG0eeX2zPtEYYcPsJcclWSfObv8dXGBgD2?=
 =?us-ascii?Q?scol/IdX2Ir+dMj+tS+yX0NVvqAzecIoxZezeIzDJON7hY8xVFVPvwU3iruj?=
 =?us-ascii?Q?C7Ztx/d85A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a3f264-0989-4c94-f564-08da3e13c26d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 05:59:41.3320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iI55qmCRsML/uQrQeMx4ZNDl6Y4aqyiJhmdlcLGmh9buy9ehpTNKu8t6U6hxC2/qtYJNiiY4cTVi8P2AdEq0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3593
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

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, May 25, 2022 10:09 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: convert sienna_cichlid_get_default_config_tabl=
e_settings() to IP version

Use IP version rather than asic type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 871435cca3c1..1c5ce9c5cba9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4192,7 +4192,7 @@ static int sienna_cichlid_get_default_config_table_se=
ttings(struct smu_context *
 	table->gfx_activity_average_tau =3D 10;
 	table->mem_activity_average_tau =3D 10;
 	table->socket_power_average_tau =3D 100;
-	if (adev->asic_type !=3D CHIP_SIENNA_CICHLID)
+	if (adev->ip_versions[MP1_HWIP][0] !=3D IP_VERSION(11, 0, 7))
 		table->apu_socket_power_average_tau =3D 100;
=20
 	return 0;
--=20
2.35.3

