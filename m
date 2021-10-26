Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C0CC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6CA60C4B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 11:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0F6CA60C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCD989C97;
	Tue, 26 Oct 2021 11:22:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D066989F6E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 11:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1Ba3H2IGOfibA+P5DVjQjdiHu8fpjyDT91PQ5mJSjv3aFAbAbNo4rawYA3FS15RS1xU0ZwlT2VysYCw1XBzdfCHWMpQZVi+l/nGV8i0ayrqkTYSMHk+CDXYZsW6r+PCjJy7ih3DNBQpPS6eWF6pJ0P3ZFsIV+m5z1JkrEs+2AJ915nfMH4pQo5Zy7eCGRDW6gtNv37Ms+shYFB2MRNiHuz6AsfkHo79tQVIs/y6mDvb0oyEVfUsvoj+y4w9wUZ+nRAMuTC7ILaIhj/Pyjip5xBla1p4EVz5VpTk2+2nX4tDXPWvyKDuMMQ5U2UqvYBbd4Tza7pXHvAUaiRgXTs74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w92sYrGXDyA7oeCccrVVrZfNcv31cDVAEcwF/St6yaA=;
 b=oVAa05L25ixwR1F/b99NVqNTurv/U9brqfw5qJOvKiwoAwvGDdSQ9U75MjFHfwujhIqiGvikV8hBlNuUOHvvDw7K+NR4Gj5O14E3Bm9dmazjJatbmpn5U/oCghls9bsEpnbicWWYR9S18p3Ui+v5lxwTy4uGu+QZnLrwXOZbGjLs5hQvaB1RQB0ILFPgSEcPgnw6LbarI2UTjtuiQtXjqpKNgm/XlSEQX6zrHRvk8Lv/EpxZr1ZcTrNCj+8tNsOLP75eje+Ff6ZguEbB0iS0CfmxiD8f+FwwYhcq7RSuZ7vd0yN/sU9oigdZmfN2JuqVJMBMjrjfyqKbNog0iRQvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w92sYrGXDyA7oeCccrVVrZfNcv31cDVAEcwF/St6yaA=;
 b=mjM/wDtDOITuzZykjBnA8LeiT60e6l3TyFYPb0PLxvRIhsrS1h3KUGDbKHgx9S7CWrw1rr2fIaAOaTYCd19Q+r3lnpY/jXTjfRVm5795xqvwVXoYoJ6bFMnbfavb1Lyv1n4iHOeneSLpwwet2vk8YcN7RB9242YY+d8y05kzTHU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5273.namprd12.prod.outlook.com (2603:10b6:408:11e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 26 Oct
 2021 11:22:29 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 11:22:29 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset
 (v3)
Thread-Topic: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset
 (v3)
Thread-Index: AQHXyltdfg+dF9oUVkWgnuGu15aPsqvlIrgA
Date: Tue, 26 Oct 2021 11:22:29 +0000
Message-ID: <BN9PR12MB5257CBA7555477AFDD2EFD19FC849@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211026111923.22147-1-tao.zhou1@amd.com>
In-Reply-To: <20211026111923.22147-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-26T11:22:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0d92807d-8f12-4435-9ae9-18cbe51702c2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70bb4d18-c303-4000-db28-08d99872e5a8
x-ms-traffictypediagnostic: BN9PR12MB5273:
x-microsoft-antispam-prvs: <BN9PR12MB5273819921CCD5A9BBCA2A3EFC849@BN9PR12MB5273.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQOkqiM6TWelbLoAj2+uzRATAjrB+xd/zuJklE3vK00F2iGW9ISl1fqzldKEvfssE5qlHm3tSeKodZkVM2RP9Ai/0hzy9dMJuMNXcsepskt0RoqYLXliGHDNHFCEmcZQa2oiLGK48k0TxTToqnw9inEt0x0QQVIRewAYrNHGhktC37kOXoGjGP4oB33d1vJP+aNlNw83Bcd1gTxKCN05I9P+c1sjNTp8leLbm6DoxB/4R2gV9y3blkbr6IztKr9sRDJ/XFd7WunHGIBBm1T8GC/iGlwvuUNWp2F2ocggk1mVckkrVPhaL+SmmpfPn9MexU4TKhgnnZcEsCuVDs05OuCGN1R5ZpfJs3Jymda4kiZvAHw/R5k2WDZKo+OeOPogNhQgTiKCu3mhQywoNuro+vT9NMMjllgGNv3x9tcDcoDNujz1JsmbVECbrvC1eXC1mJdr887+nEk19QUusvr/g77659xA2ikPrON8iaF58nFRTtuUGgcVZaRh8bkKrb+7BYg2jlyABaeoVi1WQDsxpoO3KauLNX5F+Jt+AzvHvbW9UEYFmdPC9Vw0ddj/vnLzyi7PY+d261u3oab2KAusyW8krZxCe6S9f64Z0ilPwuf1kym/tV/PILz5Bva0mdjKoYUtBmY4fi3zZtOx2RiAoAPW3X4BgOMiN4KUYjmVp8OQjf50QBIZGb0eO+N7/ou/sCRx1zydw1oOO3kxZa5wRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(186003)(316002)(33656002)(26005)(7696005)(53546011)(8936002)(6506007)(55016002)(110136005)(8676002)(71200400001)(83380400001)(52536014)(122000001)(38100700002)(508600001)(86362001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(5660300002)(2906002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4LJuOu7/awmPLq3EyIHXtwlfwhBwEYhCPyyhl7pm5tB+N5+cc3W16kiwHK37?=
 =?us-ascii?Q?Wlchhj/Ntfyz3IT8FM6S5FGg4MhsY2BOWOEuPnEkPSYDgOFKRjf3MEnpy9AL?=
 =?us-ascii?Q?/qeWs2L8dja+CIZtTgyb4aoLoL02Dl25WvR7Jrrm7Ckwjbh8Wf+dnSjR9vpA?=
 =?us-ascii?Q?B8PgKV5G25MLBRsDRKhbGofxuRWhFjEdSxY2bgnlEPvWlnt/R9AEWcArqTnN?=
 =?us-ascii?Q?+1uX/uZNZVgvpW72qPiSdgCfynEGOD2g61a3UZ2vlsCczGG05Veq+dc9oL3K?=
 =?us-ascii?Q?YDCESMS2PGG4wariaRLYiN0KaZCbi9muj/1mwDwWHko44+W5prNYsI8m3Zmz?=
 =?us-ascii?Q?kfI7hjNOUvQLRDbQHThywP2vr/vdaCuuiJlkIhXTe6/I7bovNJsYAe9eCEoo?=
 =?us-ascii?Q?pmGGGSDFsHwAYxfD3Sf68mH5MVU8B70BYmJ2bu48pRy3t6O/JrjVJqfseqVy?=
 =?us-ascii?Q?XQxKdoZYg5pbgSdGONpcMoeiVvJAuwqiQhxFpjaElINY+HDxn90hJnAjnych?=
 =?us-ascii?Q?wTcXuqwejIsLJfqbTQgM8LthzCk0NURb4R7PeAyhr4Izfs+qBbsGu2Ughhrm?=
 =?us-ascii?Q?skTi9ouabSRcnOPTIBwlWhjnOSMP++7RG7ZT2SHtDrMgrqnoaTRKD22fcpWD?=
 =?us-ascii?Q?/SeS6wuBneWycYU6sfokxug2ZFPZ+7l8NZ757O+LtSbY3Kyn3Fps1Pjt37/+?=
 =?us-ascii?Q?I21TkvxqWxaaFVr8fExLzyOaZNvullVbc1240ThtafjVs+MxyU27J7nheygD?=
 =?us-ascii?Q?fj0oC2XIfH8zCfFlYybRd73cGEld91dFPl6y62A5VKacgwoFbccVHbG0kSye?=
 =?us-ascii?Q?A0+8TLwG/Vyeg1T5PILoJQaJ9IvoBdXiIhLpI+O3W7gL7W3BV46YrqRPutWj?=
 =?us-ascii?Q?hAB9O2yCHR7m+DJRq2LN+bzDmaitmaiuytBnt7ht0rgBiH5IFRFG8IeDgTyZ?=
 =?us-ascii?Q?c6ZoTiVAsxPEqM8q9/44C7JiTSzY6x4IOFmB16hK5SoBpjSxEhj60oUhdQ0i?=
 =?us-ascii?Q?vPuzY0o25sqdRKlbA5o/LS6E4UaThHvS64IZPxuH1JBLdANXVzVma0jZPGrQ?=
 =?us-ascii?Q?V0h6fuuUB/uzmpFtHSyYtWuMNbdikPVoetDdq7fvQm7rLQLNk1nZjHrUPz4A?=
 =?us-ascii?Q?Erk0MKtpUF5O+U9K1QDnkmXWVev8806hb/bjO2dHXDwa47h8J9iCmfRj6CQD?=
 =?us-ascii?Q?A4geiylXTY727UT0t8mC7t8EJrdI3MCc/HOHInlzG1YcueQM37jLDVv24mPa?=
 =?us-ascii?Q?LHDDF00hPWPXedliipSWMQg09Erhn7EvcUTWKL6U6i1aKf6534S025GJG3/m?=
 =?us-ascii?Q?vt40UHlDZBYVFvbS6mpVEdUjF72TYlj3PUx0BptTGkOp5cFwHX6RjERh88ZY?=
 =?us-ascii?Q?WCMXnCUcLvgMJWLEkz5z2V8v7KbLUj3o37BC+YJPkDCLycO0NnCxRGkMzmmR?=
 =?us-ascii?Q?u7mJUwRNSajJOvj7mtvwGTvnqFj9AB1DaCnSueYEu5fXP7hJbgpc63tmdh3w?=
 =?us-ascii?Q?B2nOLJK+vIQURwSiQ+sv7XdvzPcuvtasK/vYR86mBthfWsXSjFUnRu2qjUxi?=
 =?us-ascii?Q?qa344AKo5fsw6Cq1c/ez+yBzfYtunBtxUVR9U1Ez1+gS5SHNn99p7BHYaPJH?=
 =?us-ascii?Q?2GtSiTC5fC4Rp35ughka+BQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bb4d18-c303-4000-db28-08d99872e5a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 11:22:29.5462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ooTjPFmK2QtoAqtpYr0BdXwEH64tziUIFlfb700QlKW6ypbSZx94HHV1js/DcylOreZi3VgoLGhQlJPzUTdzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5273
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, October 26, 2021 19:19
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN in gpu reset (v=
3)

Remove GPRs init for ALDEBARAN in gpu reset temporarily, will add the init =
once the algorithm is stable.

v2: Only remove GPRs init in gpu reset.
v3: Suspend needs it, only skip it in gpu reset.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 24852a24cc58..c4f37a161875 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,9 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_dev=
ice *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
=20
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] =3D=3D 0x3f7f)
+	/* Workaround for ALDEBARAN, skip GPRs init in GPU reset.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	if (amdgpu_in_reset(adev))
 		return 0;
=20
 	gfx_v9_4_2_do_sgprs_init(adev);
--
2.17.1
