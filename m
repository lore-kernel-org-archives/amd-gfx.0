Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359D7C43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 09:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A836211AC31;
	Fri, 17 Jun 2022 09:08:02 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5C5A11AC27
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 09:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTDIowlm7X/aqpN4wmIHlv7ERs9OiWTutB0F4TxDolIvzwP3KXrXMSveQRSgKs8p8PvcV8oPLjm4Omk5WE2fQr2rzrxEseZqD25imeaTgUYg8Z9wibLtMOaHBG45dRAZ224HCQK/NnQOdFNseIhV6OLxOvExbwD3BwnzTN9gIowOO3x7SM9P2QodBHEX5bzZEXPBd9wuR0uQk/7Iin7qJhyFcZTf5WOFZEOzVaA7/DtSMHzmbiRz6EgOPzwOD/KfWUOC9mK27PK9rLi8+e+vcd/VjRn5Pda7gSY3PUoc5cc+p5urUjTKJLRCTdyuZWnjFVnjA2J/fG1hZaR4k4y2cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeo2WJXLTakf3Pk7d+ROy9lTftpBViEMdDfpFRoG534=;
 b=abuganBmZyAyZbHg7P3ep0B5uWBJVKV0JzxXXyiE7XImxW/KJB6S0nadGU/lddwlx44R5EPtENEsfiuJEdpf3v0hWulo0b6oMNx/YpPizDqDYUa6iZOpJt796XRDFokRP742KeAD+/UBF9pa0b5iNLqWcBMEGkw1HKFQgA5/H1sqkDFIPRblUSM2iumi4COOF1LIcE1BbQ5BIn/n7yeE8Z0FVTmvsOO0Q0e+1zYhHgtveOemPyxs25037HrLOAUMNRiaS+pLMJA1QxeSdJCw/FFNvAvbT2BxR6kIa+ap7QCQP3BgIWJsLJ5rTnFZBz97Ts1c1brJkHk8UMP4imJS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeo2WJXLTakf3Pk7d+ROy9lTftpBViEMdDfpFRoG534=;
 b=ywnqWMIDRFNzdCNfe8yCfNQE/bOLzJpreGrjvBE3NnCf0vqEqz8cAqsqwdlm7AOzuJYydbCnUGAIQq6Fzh18rNQ3oMRO77tPE6XPMHwfFtMRLjI8We+oRO5xaVV7ccxlcrFumV6eSIvtQCsMSyrc/F6m1cIeQNM/VxeQPUhQviE=
Received: from CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 09:07:58 +0000
Received: from CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::18c7:8d9a:32ee:3559]) by CO6PR12MB5458.namprd12.prod.outlook.com
 ([fe80::18c7:8d9a:32ee:3559%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:07:58 +0000
From: "Shi, Leslie" <Yuliang.Shi@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix 64 bit wraparound resulting in
 illegal drm mode
Thread-Topic: [PATCH] drm/amd/display: Fix 64 bit wraparound resulting in
 illegal drm mode
Thread-Index: AQHYgigQebnbu8WWKkKf/ugsO/pFsa1TTt+w
Date: Fri, 17 Jun 2022 09:07:58 +0000
Message-ID: <CO6PR12MB545818DD76C352FBEE9E39DDE0AF9@CO6PR12MB5458.namprd12.prod.outlook.com>
References: <20220617085538.610901-1-Yuliang.Shi@amd.com>
In-Reply-To: <20220617085538.610901-1-Yuliang.Shi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-17T09:07:55Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=380384c8-566d-4cf1-9fbd-037dd5818637;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-17T09:07:55Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: bba42d12-a2cb-4f25-8e7e-f198fe28fbeb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1582bb4b-3f6a-4849-8a19-08da5040df99
x-ms-traffictypediagnostic: IA1PR12MB6434:EE_
x-microsoft-antispam-prvs: <IA1PR12MB643473E98BBCF91BA7FFE4DBE0AF9@IA1PR12MB6434.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mWgkWdKjVnWX3KNt9JCgVFMs1cYowTiYuOJvqe/h/7yi+B47o4trx7xMHbhIPDNI6/zFD+jrOB5yIcwxJ5G0nP7oD471prHvu2R+wPgXkIyXS2XqX1IuTX8NGA8fWt32W6yMh4cabHeqfF6fbY8Zk50WUoCp6+mYmauH4dUbxR6bHFHUttrlVji/UysIBCTihG/nfBPkxvwCCdO05vMGxHNCIqdnrRExdZFkd2637APR6zHWCeHMJzGnBCE9YeBc1SvMbPRkrFft1A9cwWn388RoZAFRe1GH1U0fZB4anhRtf7wR9kPzfCDBQBFBtp4CdqiOG4ytBM31EeF9W3S4JNLc+9kYlK9EzDxbUo9lZ/TRHhe1664/aYakRbjDLJqA9Y4gfFTjLEbhqzLdMJMfxbIkDtE+Aqh3kieqp57vfulHcmx+st5sd+0JEFxBx5Rg4de74E0t/em7cLHd5e+pnuRwchMQNCrtc91zL4dUzPpAnMEkdfoQ+9rYWrpDFRyAUuAXHw7+CERadHGEZjrS/5lszSEoVUEPhAFpsXfHrouHrrrCT5TlYqWUaBS2NS9tGH7eOU6GZh6kvsbY8eoqt1cfppifSyy41YMkJKiW/I3j0yPcDahuE6QHeJcWQVwTYKKTvQU/BI1dYNfr98emGDwijsHUdrCZCVS6QGunAkLPQxocYIydjGs//Zh7X/QW/B/cG43x53VJxh6NFPp8XA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5458.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(110136005)(498600001)(4326008)(8676002)(122000001)(71200400001)(66556008)(55016003)(86362001)(66946007)(66476007)(66446008)(6636002)(64756008)(83380400001)(186003)(9686003)(38070700005)(7696005)(6506007)(76116006)(316002)(38100700002)(26005)(53546011)(5660300002)(8936002)(52536014)(2906002)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pGPmyn7WpCFm24fo3FACHhzepZ92Bn45EfHoYMooKKkyMRVXB0qqUgFuq69I?=
 =?us-ascii?Q?qcYYCNT+cTwvgnP37dJfh4UDvtSNw8be6p61yu7FWvFcjB2PooAmv0zJq28g?=
 =?us-ascii?Q?elwcdyla9AWUoZK3L+3Hm/ANfnqi0gajQ7/k8KDZDbHd11SdXtpG1ccaeXw9?=
 =?us-ascii?Q?b3ribwgT1LbZxzQgG0Fj/c4/XzUmirO8kaWALXjPqGXI+hcu6QpQonmfsmfl?=
 =?us-ascii?Q?5jC+RYsbvkzzo8HHb3n34AP4cYET2lnN1jpDL2DbXNKioaGYXaEKNEwf983W?=
 =?us-ascii?Q?yaUG7Thidymzq89y0/4TxE4INQmF1ahL4DI9d/J6HG9w31vkTaHM4nP/+hFw?=
 =?us-ascii?Q?E1Pcnwkx9CIfNOUqlV0zvu2drtG5m+r0NxyVp8WPxBjpKYSIYOMNSBIngXRq?=
 =?us-ascii?Q?L8aW23ybqRK+K5foywyQD+2kZU4guWEf2qYqBTj4mATBjgXcDZpTM+lEwUCl?=
 =?us-ascii?Q?YPuHhollBrV8As9DUrihhl1WbUMxALT5/D0Yg7ZLHDRwXUjH5iarRZwAOemq?=
 =?us-ascii?Q?V4LuExvqKxQi3u9iFG5nwWn0mcK4agCSOZBaqDMxvZyg1/DIXvS1N3c279w/?=
 =?us-ascii?Q?mWKFPIWGRRKOSIwc1d6DwBcsFeu5Mm0I3GiFV4FIcsAzMStKqycUoyR1/+ij?=
 =?us-ascii?Q?1Wt66776ctsxAVz6dNWQNARn29aQVr/XVTnK2KGbPy83eRvWaQyUmZC3PtMy?=
 =?us-ascii?Q?u2KhfxwhmUHUhPHvlS6nKjZt/zomqxZdrZqk22zPdawhrRamSnIL2VVzGHjX?=
 =?us-ascii?Q?9rHVAST2XvSTY7ubttqUYRq+Cr1P9go4+vB0pBMWtqMB89XksoUle7CkCrRi?=
 =?us-ascii?Q?akPGoiDBmsQFvrvQwwuj3bHQXrZcPpg893wLgrMM+hZsBts/8x9UZ6fTAFgi?=
 =?us-ascii?Q?N2X5olvGaGP6/vJfeNBc+yoL++gjB28tScbz1qCWy5tBUFSpiSctc5wdrLQU?=
 =?us-ascii?Q?haCoFhWAu69P4XXGH3EQFP0h0QUSp+LICThOuAAzpw6EQ3ry7LsYCkAdgYm1?=
 =?us-ascii?Q?ddN1CS8Mvkl5gk7PnXVWnhK+11gmrWJXcSvAGFb4Au1bidsdNLVS9RlVK+82?=
 =?us-ascii?Q?wnVLY2l3Q6xRd3oZJBSxNadF+zk/tYzi8MfmolaYTgjG5b4anC+VCfwuVYcD?=
 =?us-ascii?Q?yHOZZI5Q+iMQp/fo0RAxHe2wd0FS3lgmp6eJX3x2rN9YbXsGlG3xyJHczQ9o?=
 =?us-ascii?Q?pjBMNCl5P6/w9YCwRTV04xPxxfkVauvZTomxo7Nfm+OqiU2tevgsTgVFFXKf?=
 =?us-ascii?Q?BOJWA6ROv0jKknDOjI97NrZoWb+7Ma9cwGOWm0+7LcCPNUgRnSUUAMGfJy0r?=
 =?us-ascii?Q?zzpCIaW2Zp3LUFggdO4dcgWayqENuI9VgT5ebxF7qyWGSCfCm8PcMAPSjumH?=
 =?us-ascii?Q?StGAhcCj8EQPW7/RpwsWKZB1edkIGEWAnTjM2FHGyY5WuEnT/4zJjtKr+U8x?=
 =?us-ascii?Q?6RXPVZhQ3rifV9tF3+Apwiv+T6JFEXBRDGiWrSNpWFXAKw5LdkWpr8KQqeKf?=
 =?us-ascii?Q?T24rzBVbjx8TpDhYAMn1boJAN5RpTvvX6mm0I/E9uSFeGu5XIiW6hdsMHNQj?=
 =?us-ascii?Q?A9oZBfdetrcKa7tiYH27BE/tyut+t1eh5KTg9lHJyyJ93nQhArpFXVPKPBdk?=
 =?us-ascii?Q?HEKybnBvms1vQkzdQEj8Y2aqa+xTwS3M2seTba3pRHBXg23wYi/1uuDGLlAd?=
 =?us-ascii?Q?mtOr4OofV2jYBwxmsc9cxTaN3Nv/4INVW1t03/5jLhMEJ6c7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1582bb4b-3f6a-4849-8a19-08da5040df99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:07:58.5387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +jvPm0EzepiOBXciccMapXuc35jJELuQsB4Y5JiCLBXUFSaGm7pr9Asd1xWKFjpJWjecqtaAFVoNP0QGT0xHtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Please skip this patch, the description is incorrect. I will provide a new =
patch soon.

-----Original Message-----
From: Shi, Leslie <Yuliang.Shi@amd.com>=20
Sent: Friday, June 17, 2022 4:56 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
Subject: [PATCH] drm/amd/display: Fix 64 bit wraparound resulting in illega=
l drm mode

[Why]
For m =3D drm_display_mode{.clock =3D 533250, .htotal =3D 4000, .vtotal =3D=
 2222}, common_rates[i] =3D 60000, the result of target_vtotal is 2221. Thi=
s cause wraparound of variable target_vtotal_diff.

On RHEL7.9 kernel, the type of vsync_start is int and the value of new calc=
ulated vsync_start equals 67698. This lead to the following call
trace:

WARNING: CPU: 9 PID: 424 at drivers/gpu/drm/drm_modes.c:1642 drm_mode_conve=
rt_to_umode+0x42/0x1c0 [drm] timing values too large for mode info
CPU: 9 PID: 424 Comm: plymouthd Tainted: G           OE  ------------   3.1=
0.0-1160.el7.x86_64 #1
Hardware name: HP HP Z8 G4 Workstation/81C7, BIOS P60 v02.73 06/16/2021 Cal=
l Trace:
[<ffffffff93981340>] dump_stack+0x19/0x1b [<ffffffff9329b228>] __warn+0xd8/=
0x100 [<ffffffff9329b2af>] warn_slowpath_fmt+0x5f/0x80 [<ffffffffc041b4e2>]=
 ? __drm_mode_object_find+0x72/0x100 [drm] [<ffffffffc040b622>] drm_mode_co=
nvert_to_umode+0x42/0x1c0 [drm] [<ffffffffc041a2d6>] drm_mode_getconnector+=
0x3c6/0x560 [drm] [<ffffffffc0419f10>] ? drm_connector_property_set_ioctl+0=
x60/0x60 [drm] [<ffffffffc040392c>] drm_ioctl_kernel+0xbc/0x100 [drm] [<fff=
fffffc0403bb4>] drm_ioctl+0x244/0x450 [drm] [<ffffffffc0419f10>] ? drm_conn=
ector_property_set_ioctl+0x60/0x60 [drm] [<ffffffffc051b30e>] amdgpu_drm_io=
ctl+0x4e/0x80 [amdgpu] [<ffffffff934632e0>] do_vfs_ioctl+0x3a0/0x5b0 [<ffff=
ffff9398e678>] ? __do_page_fault+0x238/0x500 [<ffffffff93463591>] SyS_ioctl=
+0xa1/0xc0 [<ffffffff93993f92>] system_call_fastpath+0x25/0x2a

[How]
Skip the loop if target_vtotal less than m->vtotal

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2bc7db85d7e..ed7ab089b224 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8537,6 +8537,10 @@ static uint add_fs_modes(struct amdgpu_dm_connector =
*aconnector)
 		num =3D (unsigned long long)m->clock * 1000 * 1000;
 		den =3D common_rates[i] * (unsigned long long)m->htotal;
 		target_vtotal =3D div_u64(num, den);
+
+		if (target_vtotal < m->vtotal)
+			continue;
+
 		target_vtotal_diff =3D target_vtotal - m->vtotal;
=20
 		/* Check for illegal modes */
--
2.25.1
