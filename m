Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F57FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 02:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C3210F4E9;
	Thu, 20 Jan 2022 02:20:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3856A10F4E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 02:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRqNQjbMW0V2HV98yPJsevep1XEnqvXBJ/5oIZjlVKrXCYmpYvckNLrK+WA5ozpH/x6v9XDuEWVh1Bjss+JcjNbxnd8iE+UhT4Iw6pkJuSkcahVqN/FzhUEwlPHTyvcrawqOA3lOuexHDgNlrAtg5o25Wn67+Jj8MHWTzsLYnW19Ht4YyjZsHmOjvQRBZJnPv1tjKXzbbV69/Fis8gO3tFJ5nAyKIzcKUvWPpMMBOMhqpm7X/6m8QI+1FzjLWUDE/DRwPYYeBo/uVENVWFMx/oaxoR/cNTySDnMhEwcAfLtKFi7DPoh7TZvzdqHsD+fT3VHFVxkk/YidethyCP86fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6O6FkNKRZCaA4SLnhuBRJqm6l2OqTUQChFk2MGed6k=;
 b=gX8PoQCGCdE//X3iVqgBEouDTOP7cklJUoSU9xtJL0z/ZDPnq1UKoAeaVrWAw+fosh8OndOn+iguxPJhfbkP1dGmM+OsKNJpToNWOCifTRnqRZJtWfDvM0DR78zlvuqsXEFgU4OiWcKkgHmXSEMAMRZiGlxPvYLEb42vVO22QxN4twPFxHqnIISEqMNDaMVXc5Um+QZncemgAswqEIinMNVhq3ydIzJuent7iwYMjGotNUdU8/XunpeJwNVczXx8GgOz/mNkM+aFdCR/OJ6V1wrlTHfpg5Ph8LcGxrPxv0l/AqAUoxX1x9tZ96ShxMTddiTckaE8EaA8CFgz66MQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6O6FkNKRZCaA4SLnhuBRJqm6l2OqTUQChFk2MGed6k=;
 b=zCHLZA1Uf316g+hcFkjSK9WWJPAF4dYatzPlS5erMSi9qPPiYe4Cw/tggkZhGHRm4JrS511heo9L85mTKTYW8yR4y5dH+yI3+6Dq2sVp3a36hEaKrHi4/qX2uGe3C51tB0iWe0P8bJXDtL2l2gxuY+wb27XaDiqV72dlvvbyMdA=
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by DM5PR12MB1209.namprd12.prod.outlook.com (2603:10b6:3:6f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 02:20:21 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::e9b5:34b7:3680:6f15]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::e9b5:34b7:3680:6f15%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 02:20:21 +0000
From: "Liu, Charlene" <Charlene.Liu@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Topic: [PATCH] drm/amd/display: Correct MPC split policy for DCN301
Thread-Index: AdgNgiSfZQ68VWNLSvOdzBGmHSFrhQAIerJw
Date: Thu, 20 Jan 2022 02:20:20 +0000
Message-ID: <CH2PR12MB42628AA1F6C364A06A0530A4995A9@CH2PR12MB4262.namprd12.prod.outlook.com>
References: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB52141E8C6959D2BE69FAB8479E599@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-20T02:20:19Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=3936dae4-e1c4-4711-a446-ac8ced9f44cd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-20T02:20:16Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0a3311a3-8edf-4cf9-98e8-88eafaaa6f4e
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a760601d-6b3f-4a20-cdc5-08d9dbbb68be
x-ms-traffictypediagnostic: DM5PR12MB1209:EE_
x-microsoft-antispam-prvs: <DM5PR12MB12095582D34FD712096A845B995A9@DM5PR12MB1209.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLaW2cEFaWMY7K+w3j+TxFcgOpJ1d/4h1lGt+ML18AkoQgK49u1fppIexZjdLAAqTm3RATQWhiffiLeIDBYE5KSBbNTzuC2kpAdG7GT3v5C15Aqk6d/5pbv4+BISR4PjTcXFazi5X2n+clv7ICqcVRXnP320k/YDzY7A3jzUCWzwrqKzqfC45XN6iy9rw+kqeBs0lv/cDzQy5CDt0hNeCdHcoXyyyP0uteKFIa/gWPf4R5OfQhxJK7OtM2hJ1WVZR2BEEJKTqlK4Y5mzuxdZOwBCDa1pQYSvWchO2u7HT+gRIBABJtCKvQF2C7Wwxb79Yw+AjwY06Uv4BKkQVUki60vwQw454eK2//eQGviJhm3qww4Tff0J7tMERNxn3YrTSIfLEnQB2r4E1djrvcA25b3QpNN+DvQuEjKZE/N3R4a20vHRkP2vGrU6R5qWbuPOCh2Eii1pzFXJcNAEVBIKSGDi1nw5qaoF553XcP0XtgyLHEF8fOAqi9VsD/x19UKPtrQs4SsgA7FvDruiHL7JCXUGOXJV+1v0DSsn/11uWa7qgXsigMbHdcXXZ/x9O5p2pVrmEho2kUUMJLeU5yhDwmnUxngf9KVPozWD4BTOllEVqbl8754McofbNONARGapjNrCWNS0IXe8HY+EjF3vDtkVrGeMMkrOUMKTF8+8gZrbjRFe3qJ3I+nnPSqWcwLGkF40KjnTmxmANoylIHeKyg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4262.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(122000001)(8676002)(26005)(38100700002)(52536014)(55016003)(86362001)(64756008)(66446008)(66556008)(7696005)(66946007)(53546011)(33656002)(5660300002)(9686003)(71200400001)(508600001)(110136005)(186003)(316002)(4326008)(6506007)(66476007)(8936002)(38070700005)(83380400001)(2906002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SokTT7eWBQrgxWKcCAcF4IneiYf6pwiswHTbFp//sLp7kep8z9aaKFu/I0Io?=
 =?us-ascii?Q?dbuqqr923wmtn+YcrKNzuqvpyuyUUA7FlSPJTFqa/Zg2ZqclwxSGqM75+hKO?=
 =?us-ascii?Q?ED8U0ES02ITtyIrh279GmkzmSYXEMDot0Kf/N1vyIiGYNUI90DlsFu73IQIf?=
 =?us-ascii?Q?Pv/2eNC86QgM1gYMd0LYAoK68bVZfvkHPI8P/gUO797XF2yvmFzigqxKPx3i?=
 =?us-ascii?Q?FVhOTtiva1KI7Ishgt6uVAx0b7/CMntCufMQCK+BmFGwbS8a0Fq/Omcdl1Ro?=
 =?us-ascii?Q?EW0URWp0VKcnqsQRQCE3tgIcjywS2soCPKexF6T4V+AaVvsPzRg0iGx6PId8?=
 =?us-ascii?Q?nhIKBddcMermsV/4qcJp02XCUgB0uWvZF0/mXtoW3Me5Xa9n21Cd7hPuMFsO?=
 =?us-ascii?Q?9POKXpE7CQS5Ur44icZVrQ3hWyjLRXDYBbraxRe0T56BZsowu6fpAH9LNHN0?=
 =?us-ascii?Q?zCIxS9+myPCmm1adFYYad58UgHvfh0vtkk3KH0rVk7Q2yDF4rj6Ww4fEdpVQ?=
 =?us-ascii?Q?JQr2IB24yltxt73j6HzkO1YD6Vos2du0axds0qLxancukVDknDVMnsnngZIk?=
 =?us-ascii?Q?8Atff8sFlM2QV1WUFEvs5bztQFXa7yybNRrUXYFR+UDrCTi+cvtBYzvVv8ZB?=
 =?us-ascii?Q?JK5I3JtkpR2F/cr1l7y7CqZRSv49YEHVstQs0KLLCbruYAjEe9fTFMfMk0Jo?=
 =?us-ascii?Q?y76oOZH4tPjUsl/+8txCa2vQ10vL8bwfqYK0JLPIU5AeKycFGVuy/TTIf4MM?=
 =?us-ascii?Q?l8ssUZG5m/BnfsPEeCAmGdpqOF3iU0aS/JsZXGqyWTSocbj9FMjVXTsZtMuA?=
 =?us-ascii?Q?iKy0AJXDaRjXNaaV60Ruv7QNqsjqN/7vU76cSvBNdfMuUrTuqmmyptq2DThl?=
 =?us-ascii?Q?6No3EYZJjW4Gih2o4kFnc00TlQBhBxWtdDFn++kSwDHuugWc32vrJPiRIkF1?=
 =?us-ascii?Q?Qp9ZCZeMYp5/isXGQLt1EnsQOFS1xxXOKPNvWv02tw74zVkoSXVBWGQoACKv?=
 =?us-ascii?Q?5nJUUK7cyQqPmmhb7umyjz32bB95H837GtcfUgsJu5vChQYL1mBWZs1FcAlV?=
 =?us-ascii?Q?8u5Rh2bKKaERPKgYuz/9WpygPJsZtaso9eYqM9N+Y7zOxuFRSizi5Hf5sA9o?=
 =?us-ascii?Q?AoAV/HM2fDkxoMdmU064YQWUDNoTZaWk4RSaZGRON4bErpvloJpSFaUncsOk?=
 =?us-ascii?Q?5dUlCXC4nus/gf6IP5sEyXfD4FvpQ1PnmLnlnZVU4jln0+5VnbaeV28YvbQM?=
 =?us-ascii?Q?V0YNTxFDZKwlnwQmKUeii/Jr6vQXwLCyTQW+bDEb9ECLLNx9phHAgFDqj/wk?=
 =?us-ascii?Q?QgxEkQdcqjHx68fSMSzJNpcEx9IaZCDca3ufxnf0DZvLb9OLREjVSRwQJzNE?=
 =?us-ascii?Q?i/zncX2LFLN4BnzfporbMtB5qe9106wGXJStniLx//lFl8L4EfIs2geBDH1j?=
 =?us-ascii?Q?3t286XcvO+Tvze7o91F8B1NYUs2fropAYPwO1x31ucELtUj7BRQUzTE4JEK3?=
 =?us-ascii?Q?34EoWvPGvp2az/T4ohnYx/Tp5qA6jgt8kA+wX/x0zyEoXvGbCyZMgLYfILce?=
 =?us-ascii?Q?b5VEAzkC1zowsykbv8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a760601d-6b3f-4a20-cdc5-08d9dbbb68be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 02:20:21.0932 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifkY4WTHyEpCugBUfeDLC0jtjB9qaa2ibrlCPsGU1ov3rQ03/mMVlI1q4bPF/yYd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1209
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
Cc: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>,
 Pierre-Loup Griffais <pgriffais@valvesoftware.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Cornij, Nikola" <Nikola.Cornij@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



-----Original Message-----
From: Liu, Zhan <Zhan.Liu@amd.com>=20
Sent: Wednesday, January 19, 2022 5:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Charlene <Charlene.Liu@amd.com>; Cornij, Nikola <Nikola.Cornij@amd=
.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Pierre-Loup Griffais=
 <pgriffais@valvesoftware.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH] drm/amd/display: Correct MPC split policy for DCN301

[AMD Official Use Only]

[Why]
DCN301 has seamless boot enabled. With MPC split enabled at the same time, =
system will hang.

[How]
Revert MPC split policy back to "MPC_SPLIT_AVOID". Since we have ODM combin=
e enabled on DCN301, pipe split is not necessary here.

Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index c1c6e602b06c..b4001233867c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv=
 =3D {
        .disable_clock_gate =3D true,
        .disable_pplib_clock_request =3D true,
        .disable_pplib_wm_range =3D true,
-       .pipe_split_policy =3D MPC_SPLIT_DYNAMIC,
+       .pipe_split_policy =3D MPC_SPLIT_AVOID,
        .force_single_disp_pipe_split =3D false,
        .disable_dcc =3D DCC_ENABLE,
        .vsr_support =3D true,
--
2.25.1
