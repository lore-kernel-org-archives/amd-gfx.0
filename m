Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF48C636D4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 02:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AF810E073;
	Tue, 14 Feb 2023 02:25:41 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5B2710E073
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 02:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvrhx7JTdle6EjGxuQmo/2Rdlh8PDbUzho1BZoX6uBT/QRdGgfeHdJddpBc+7DmG159SmxityF2jkROC2NUIwP+w8uc5XP9brebD8p7Ub0VUcdA97+rU7vzXmwrCvc/zQhPVed1SFeW5evzW+4JGxzBim7BugdFxdb5hp55rITqr2jnB1OWcjwdFLWdCDxHAUbqjr2e6/sjh4vjhB28lcNwKgZnfQuP6x7m/JlrC8LtaJJqXbogQI8e2qx4VqonIpY/pRTCOMTwp2NUzvNdhkZVJnCk29qprfW5Mq0sMwe7anissOXmHBKMtUF5/5YHHiFSBwJd4YGkxtZs0Kc9JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe77X8Vmb5og5JZ/exXn2r2SO4r7YFnjiLOyI5dAR2M=;
 b=k+zTwRXbIKAmnDSi5e4b1jANlums2fyAu6tiq8G7VXYhBSIQ5uEr8FahBQUunYG4o28RUBQrQoApnzuDAYtlwQvoudUYA0T0T7Rl2RTUb2twYYCoEMCF724ZGPttgXZP7rM6ep3arqzNuegEx+IDSPSEPLyInQigKywmPVAO5Fr7XKRVj5TUoDkidbelwldBo2piukf/zXvrTGAek+/PfkK7C3o5CPHRDxShRtreOHf1WYs8/4syq/5yiwzAwOOlg2JQpupyQo5HVsMRT4zlrpg4vowk8zHDGYCPkrAYcHxiqUf/KtG/w1dOUuUAJ906J9FSHLm4o7HA5L2XuzWJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe77X8Vmb5og5JZ/exXn2r2SO4r7YFnjiLOyI5dAR2M=;
 b=ZvVBI/fZ2VHnTzWMtazSj6Gu6SF5FuYP90OhiLINgBuv3y9c5IYKKw5hvICmueHJuXY/hCWlmP4tEEe82f7QXAZXEJkseKrZ/nQkjiNFofp05sW0M8N3//OT4JQKPNBYXlVx+wQFIHJZ8ed+idp5Q33yVUfSfUYld3aDyIBFG3Q=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 02:25:33 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::8617:d09d:24bc:a683%3]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 02:25:32 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix warining during suspend
Thread-Topic: [PATCH] drm/amd/amdgpu: fix warining during suspend
Thread-Index: AQHZP5olzsKw1o1WDkOX+qUikZ6vX67Nt/Og
Date: Tue, 14 Feb 2023 02:25:32 +0000
Message-ID: <CH2PR12MB4152711019B3929F9BAB393BFEA29@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230213105224.55662-1-Jack.Xiao@amd.com>
In-Reply-To: <20230213105224.55662-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: 8ab106af-d696-4736-3dce-08db0e32bf8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORmy9EzCbZDAzL5+s9cf9u9xVASn99j+BKDKElqS4hWLv2GHMTUIXNnASEDrj3LVGTssmagr9cO6U8E/C24r7TPdds4rj87Pl6e/GbQrKTBC8IHqdIxaOq+/sJvmNOVAScOE0TFdj9r3rbrnmEfreb1J2KzdHd6BYSD4OPMRJD/HGSfCH0bvR41rin00P3x8VQIdG6oJEu+bKvRGxTjZ7Ubo4BlAJu94RDWBgBRIj1JP/3ILPiXJRtOd5lVJAJzgLE+G2XzyUtgYYG+ykbSyey+H9cPdqtBRwxnsqtjb5/6SyYc5ZqWYxmJMATDNvDAkC/ydEQMyFc9qeL99zRD/SxEZI8wS/lYnCXUo0DBGK/CHm/Sr2BMGO3nGA/FBV9jsgvWE7gQqFCrBDpulfSetIIKeg39AAVYNYjvM8aht2R2I1MXHjHW9ReWD9pNLGOnJLi+3J3WvuHj1SUWqs7U4hdUTduf2dFmzFMYr35Vam5PVqTO6sHynAhMo5aPH3ptZNrQv6/7KA4YMzTEgWfvoKXgxwl8QcxcP5o3Df6w83FtBXh3yxXcb8Ae+4RWaUKOALAq2aHBELmQx9peuTBzpm17S1UXjTFpnXxpTzjzeRwvkqUQ17pWD2XB1/fq9M+FBzOoAjzWm8VYUJZ0Mhsb/OM9FGyWPdCrtG912ZJ/Wrphrz0CfdfpNd2zrxNZzNtBm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199018)(478600001)(71200400001)(41300700001)(7696005)(966005)(33656002)(83380400001)(5660300002)(54906003)(110136005)(316002)(66946007)(66556008)(66476007)(76116006)(8676002)(64756008)(86362001)(66446008)(4326008)(2906002)(26005)(186003)(53546011)(9686003)(6506007)(55016003)(52536014)(38070700005)(8936002)(122000001)(38100700002)(15650500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2SvTbIP1NiVr/75subMhRX12vku6oR6CGlKKp8Cg1szyP2exf74jdnVRxsbr?=
 =?us-ascii?Q?raC59uonTupnY/cLRPkLqdm4/r31pud9YeOFBBTazHUDhN9q4oiRzcT9VEqV?=
 =?us-ascii?Q?5KR/45bTHBFA5dnXAtPYBPzf7uWJIRKw1yZ/J8FgCVYVdGEpEaZXonfPL5T0?=
 =?us-ascii?Q?O297QTAJEvQ/QfZUYevdv0kMdlxHiOz+BZTl7DpIpw2GzGwUr7lgz0QIpKAW?=
 =?us-ascii?Q?vqiWt+Tdw6nBW0vDQtQLztgQqQK3EUW1U+Qy3r7qP8e7rPN9ojNJ97JApWq8?=
 =?us-ascii?Q?WZA0LHptgVDJi8DkPFvEd9ESZcCbsV4Kv/3TUbezxcu6nxx7hJwuomONJqis?=
 =?us-ascii?Q?YUbY9mwtpx5iL1us4XbY6jjC/qUuiso3pq5KWml1EiNE+bmpY5FcGy8C3CxI?=
 =?us-ascii?Q?YgoW5qDN2XTSGYQbeWnqK2nL7tRhrbsH5gqSwjf4O/beJrBNdByA3LVuC/wC?=
 =?us-ascii?Q?kTcXQ3Y06tDWoy6ALNS/NwrupBfqOG9C0TNVyGz7I7Z0ieNfD/VojZXdj28m?=
 =?us-ascii?Q?fLChewXHKhJ8m2t4Z295gbrsQ50n8jXvSIQgJqTMOdS65D/yyIRS93+rX3kC?=
 =?us-ascii?Q?DynEQIeYQQtwklCJ9N5sNmirR7m41nma1fHjyEeUuOGVo/r3ECGtie/f2PwP?=
 =?us-ascii?Q?dy90CC28h5c8XiwhDjo7RTtA6ou1Pr0qI5xqbBnSjbc27+U2onBgxyRIoGXm?=
 =?us-ascii?Q?I86Zxu3fh57gHS10ccfnr6gafbZaafqx0xfZkVPqHFZnjS7Fd/TKF05q+3V7?=
 =?us-ascii?Q?nFfPILFC/OvNpCTL77LW/0nwRE9i9KY19Jjjk8CiTFIrryc2XuKDMYqm+paX?=
 =?us-ascii?Q?z7n2A0F4PP2HgIquhXhwu1XIT6xDiyXn7ST0+mw1rFf+hW/JRLCjCMoA2Nv3?=
 =?us-ascii?Q?i0FKiLi/tfoS3kjVLHIB3f+fg7ATepmjluO67RhutSqRQcQMAWPj2DE8fVOg?=
 =?us-ascii?Q?QnYHCrJFyiDXQvJbnXLpVuAfMI9bzW8wxyaROIczWMSKdmHASHnjxH5OFwf+?=
 =?us-ascii?Q?WNNixQP3Lk3v2Hs5qC9lI+JGeJpH2roQH+0xYpHkQ6DuEtVr+F6ycRF+3E+I?=
 =?us-ascii?Q?X5qVDv6PJ85ZCXbhOwQe0OUJs/Is1vcd9klJdfUzXD6ekC3Lri22TxXu+xZr?=
 =?us-ascii?Q?OIjHkjhLI/JLaqFpVe0jl8JkNxGJ+6HKjY8iP6g8VCk5jm9QQo3J5gYAU+yA?=
 =?us-ascii?Q?mfM/gTH6rWcHWDCoraIUs0JLn2qgAa30OhC91j90tQUQbUZQKRRcLv0aQEKT?=
 =?us-ascii?Q?gTYTGLZLAZ5J32bbgMBA5vmzEgth8e5cX6xuz38iSH/fJfg4cpPNkourfOtb?=
 =?us-ascii?Q?GGruXsOMeLg6PnrWAqDz0Tj8q7x7TW9319S5moes8Wiunzkbb7+qzivPXevb?=
 =?us-ascii?Q?3yeF6cSiqhs8qROZK3/acjWNFizKyopmL0mWFE9RF5ddo7UgDX9L/ShF0Gq/?=
 =?us-ascii?Q?3XYfm/9yYHBNvFWcaIRVW/tuyP3SIuJMxZYzTcDY//wy4D3t8rKzZH7JZFsh?=
 =?us-ascii?Q?RSb8wE4e1FfwGnhTVk6dZ8ZvIAX8I7C+Pyy2ZIOC/j7sCvqIrRuUwh2EwIp/?=
 =?us-ascii?Q?TIhoTowcQdcYsye1qns=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab106af-d696-4736-3dce-08db0e32bf8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 02:25:32.7356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NflpgZlR/47r/JfgUxv6SCrFGk4y+6da/Ru4xKC9k7ZvVpl6RX9yIx95G/HVgQug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "jfalempe@redhat.com" <jfalempe@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jack Xia=
o
Sent: Monday, February 13, 2023 6:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; jfalempe@redhat.com
Subject: [PATCH] drm/amd/amdgpu: fix warining during suspend

Freeing memory was warned during suspend.
Move the self test out of suspend.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2151825
Cc: jfalempe@redhat.com
Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index a10b627c8357..3842e7e62eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4270,6 +4270,9 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)
 	}
 	adev->in_suspend =3D false;
=20
+	if (adev->enable_mes)
+		amdgpu_mes_self_test(adev);
+
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DEV_D0))
 		DRM_WARN("smart shift update failed\n");
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 62cdd2113135..5826eac270d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1284,7 +1284,7 @@ static int mes_v11_0_late_init(void *handle)
 	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
=20
 	/* it's only intended for use in mes_self_test case, not for s0ix and res=
et */
-	if (!amdgpu_in_reset(adev) && !adev->in_s0ix &&
+	if (!amdgpu_in_reset(adev) && !adev->in_s0ix && !adev->in_suspend &&
 	    (adev->ip_versions[GC_HWIP][0] !=3D IP_VERSION(11, 0, 3)))
 		amdgpu_mes_self_test(adev);
=20
--=20
2.37.3

