Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22277C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 17:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8161D10E57B;
	Wed, 26 Oct 2022 17:39:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A931810E57B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 17:39:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdRmtJRdLHT6NJSEJ5toXemKnh7Bz9qZE0YCOYB1axdYNMlbuzrtVAiBTURZhcn4ROl0yYhBeJcvpglYZQkuaD29iRnfix+huYTMvMBG7Qs8fQYrhzKXbceOlWSNsVI6PietUbIqeLPDhZizIwPVmkq29lTltijydSNU/aYZOYxvMbZwROefWsY352/M6MzyUiMyFD9BDHgxdL9WkV7biziwvxeAA2OdOV8i4dzD+pX/F10DEkkksZJe/RTGS4Zx3TMxQZvlnQ2PNPa3N8pLG1berQrkPgyDNvR9FmQKWOEJ0x5F6DSKmQXaYr1yrgpLJJ/DX+fEEGb8c7renJX3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyAcYXaDnoPGg2PbCv9QrG9n/9wDkX08B9oPt3hv6G8=;
 b=PsBTY+bfZrDByQow76wfJ0jM04a0bOw3F5CyBy6PunJbq/bwMLRlT39eQGq26nm4Rf/+dmVBo3KXIF+40bDifJZDAahXIBRDdY4tnKxlKrDMqMZ8SNM8Txc9AClQL/R4WiSzKnPi/xkL2Rfwhxx9jDVVkt3Gq0tGc8tho2+/F5M2eBovSszziWNGk57IbWhLyyUZGmS91IwHJ8dIJKd5J6Vj5Oxqc3q/m/6dIBxDI+HAZEGzJmRIrG3YAPScROs+AkGYqKtVbazxwv2ioQ935xye7EyFa73XLKkEaDxkRD+eodNOyEkTc3MkXn7QSPEaBtCpgG1UR0zr6oODM/yYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyAcYXaDnoPGg2PbCv9QrG9n/9wDkX08B9oPt3hv6G8=;
 b=axBtcIOtQy1cT2dMCVPYy/iUPAyYWPTVH0E09fu8ciQ7g6u+9E0p2Jgtxr3flV259ctjorrk9eTrNxSJiycSNGnqtU3qi5/Y40LBKiYZSAsUuYEMzq48/EyESNfuYpAK7+ibDtis3TkXaYvyXkgyyYL421qjGl2K14istndnglI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Wed, 26 Oct
 2022 17:39:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5746.026; Wed, 26 Oct 2022
 17:39:25 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] ACPI: x86: s2idle: Revmoe unused variable hid
Thread-Topic: [PATCH] ACPI: x86: s2idle: Revmoe unused variable hid
Thread-Index: AQHY6WFNEWpB32H/I0u3JusYvVXmmq4g8HSQ
Date: Wed, 26 Oct 2022 17:39:25 +0000
Message-ID: <MN0PR12MB61010E69CE7165E284374DD3E2309@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221026173340.3777280-1-alex.hung@amd.com>
In-Reply-To: <20221026173340.3777280-1-alex.hung@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-26T17:37:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b860146b-e888-4980-9711-09d6de83e48a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-26T17:39:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1395a706-7b9e-4056-b042-b53ddb1014c0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB7295:EE_
x-ms-office365-filtering-correlation-id: 126c96ed-6976-4e3c-6df0-08dab7790679
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 454CwO4ZwimGsIeRtanh5wFP1bInRpSC569+8fndl065QQghVCXSsZ0uEJIwi0PKJYbGe2MP4BFfIv0XXEtywXah/jsVXuHaQ4x2LPt7jCk8HNrXPAT8O1zjsMZvSGFp0RSvJuNHoi+cGRmLmTeenpcV+lvWomH3Xk6bDEwq4cz/QTWfdkQkYacpLZXEkm5t72W0EY11mjbPtdOqMESsL6SixdjYYurglOj4PQs57Y1wq4uWSXGtaHswfcRr1mYQNIwDuXkWLGGG9Sc4p7Me9BBNfUfzILsWPze8mDib5zy+aq/LGowrEYZFwFEqAuFYzocbRrMb7qOkUK7xX39JM7mnTqQ8p/s3Poww3eOZZMee5k3uyeTXCy1HGZ+eMWHRS40C2ZNlClez0+O8HxX42e1rX+3iqG8ofBxz7zvbhZ431RuJRVSbX5UoPY0dliqmiC/O1I2flLoVBaBncdoGKFi/tfccSeKZda7d8LprYYmFuoiBwTT/v2Kk/T8dho4H928OpO8Y00tLS5ZFy5aO64EzrWfyI2Gu9b9TX+9xN5jJynZ1JwWGUqmTEAs8iWyb7JY2sGdtn2ImzU5MRVKHjBRXKSSf46ub/n9PM2bMn2cMCHnFpxyP2DmowMSveEbk8drxMZPV2bxFkFXcHak5ySR8FxY4ZwMWqn/qTdGFFcYLx9IW4WcA/Sd6GaxoqaeeOOcRQ8mv9kC7NJwScemiqZI1zd9uA91F4vM79oPFwf07swyrLQT0Kzu9Xxv+hV7q08L0phinfcB25Kp76oafcKiWjHUY5flBBdrnI9bg3naAnZVIsEnTvLGd5B1yK4wc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(6506007)(316002)(110136005)(71200400001)(66446008)(5660300002)(66476007)(45080400002)(41300700001)(8676002)(4326008)(2906002)(66946007)(26005)(6636002)(64756008)(52536014)(8936002)(33656002)(76116006)(7696005)(86362001)(9686003)(66556008)(122000001)(83380400001)(38070700005)(478600001)(186003)(38100700002)(55016003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vaCDe0v52hEMMBszz92MeKNm3kG+Nl4uEhNdehs9CZZOMvz7hf56DEzTKKbV?=
 =?us-ascii?Q?xcsr/mAR3ckg30vqNZSa7xzUoZAZRNsSiScBDH0IPE63IzkLyWSiJJq/ry6H?=
 =?us-ascii?Q?mcu4FEIfkov3QiaSkMFZtkiWtJewuD7Ai7qeIujVGkjW80OL5UzRV0Wm3DPl?=
 =?us-ascii?Q?D+xzkR6fZJhfCeT5XBxvB6JXGTy0AjwNTXcymnrDfMbeP1TRZo1fscIRLcEi?=
 =?us-ascii?Q?mxiUX7t5d4wvhnlPLc0yJITzkzAxJnw7Llvqrlj+Aqd7eNsarv9DStPJgMae?=
 =?us-ascii?Q?2zi4fqG3qiwuGSLsp3dnYJSW/PHsbir8sVjYUGJ1OICZ2jd1OBKnxAyJALpS?=
 =?us-ascii?Q?MBWaQX9e+GLnATjYGct6hTZ7a8UB6zLYfKc0z/w+hJoE9pG3DZ0nEH+y0LK1?=
 =?us-ascii?Q?EOrNXU/ySM5sbRBVRF5X79gYIUBxQUan3iN05P+YdFVqdnSlKIRCXrTvUq6b?=
 =?us-ascii?Q?Lobr/4Q3VMzRqDHCVwByWSvKUbAVJLjRK9Dfeo1a1bJJQkSmBQNPa0cZKcwg?=
 =?us-ascii?Q?1dfB6z8Mv37ndD1fgf+t6ME/f6XvdCFwA0hx58q15B/kaz5PH2QTh48+cqng?=
 =?us-ascii?Q?TIq/FT3oiohTHBYLTRRGC9+1986nuPTXiVqyJsZ7OZqb4V/Gwep5JXwAO/yf?=
 =?us-ascii?Q?rr7hE9ZyhBcwOP9nwR8ShGplKj6og5r8yIyd9nIPJ3xpfr60YYoqQ5W319Ol?=
 =?us-ascii?Q?t41ApXo6XcEkQDH4rjJDZDVtQbQ/vMgAKcXJlLmCMuEel6Qb+KRpjdVUe7aZ?=
 =?us-ascii?Q?Y4FfZM5XbTSPnM2VnvJPl3zOlxwCMh1F5qcvCdx08GnTJkAFVhbmpXrCklva?=
 =?us-ascii?Q?bRLBEHyPL4yOSNPUE7p0yXHpUnN13nWeSd6vSv+3Sj3COs+hZT0ocRqneA5z?=
 =?us-ascii?Q?fr+q+rArR58jCs9oWoNokUFB+ejdVqbOx+Lt9CCtCBoP3MZTgjSzKuctBcEk?=
 =?us-ascii?Q?kHRp5lzJDPK/0joca3m73vdD6G6/wco4UC1fwRE8ednj2Sjq3VsYlsbMqPMJ?=
 =?us-ascii?Q?NiguRSOX4KO/FIOGJsYEdwAg8pZ3oePi19dWI+WEAKXmldf2OkPrA5RCzUuG?=
 =?us-ascii?Q?dhAH8fKuqTkeInAcWBPnfMoKGrnzyd+GmBLu84m7M7laZichpCHIcMz98+9k?=
 =?us-ascii?Q?Vr5rvNetfWIwwnBmXC2qcGPUUeiMopL4AA5/Y2bs51QNyEfT+jf/z2TfUesR?=
 =?us-ascii?Q?5LUHhIimhChEeblFBJWpHR6AnR5dMEi1WQMvoNKfq1bVwb2AV/Dsso1AcNPX?=
 =?us-ascii?Q?eAnJHjaj01RGd8RlRI0/f1dDrcwQWXLemOO74Ozf1vwko/HPjQMT58SOE7yD?=
 =?us-ascii?Q?sL6Yop2dXL1v2nBD8pcaEob739Ff1LteznkIQwBn6ygWrt+J7fgeyXdY/T92?=
 =?us-ascii?Q?QT4MjfakxdctT/d5Ot1Cz9DnppzIpGDFdXssLa4ApbX+mPiQhJn3YNhuWGoe?=
 =?us-ascii?Q?1YKRgtroMfXZyp/EY+VSKIhL0ioHQsdQNRaNiLKT8xaAO6iOR5tY/djhHVe6?=
 =?us-ascii?Q?QQIArZO3I9DcdBmuLcTsrwSl8ggT16Xeu5atIs3c1Ubm/YOCMf47veEDW2Hs?=
 =?us-ascii?Q?8lK9q+d00kMDRXA9les=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126c96ed-6976-4e3c-6df0-08dab7790679
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 17:39:25.3268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGPjUBJV6FQUMndeiDaTZtSkRdi9UYYjfSIqkOoOvVO4wp/ORET2GcvzgBzOhdVzSo+efeEOCjt7G6NRErbOpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Hung, Alex <Alex.Hung@amd.com>
> Sent: Wednesday, October 26, 2022 12:34
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Hung, Alex
> <Alex.Hung@amd.com>
> Subject: [PATCH] ACPI: x86: s2idle: Revmoe unused variable hid
                                                                    ^=20
Typo here

> This unused variable can cause build failures with allmodconfig, and
> therefore it should be removed.
>=20
> Note: this does not applied to mainline (included in 100a57379380) but
> to amd-staging-drm-next only.
>=20
> Fixes: 6648f8587530 ("ACPI: x86: s2idle: Move _HID handling for AMD
> systems into structures")
> Signed-off-by: Alex Hung <alex.hung@amd.com>

For the purpose of amd-staging-drm-next, should we perhaps revert the
commit and sync back to cherry-picks that landed from upstream?

The reason for these commits to be backported in the first place was for
s2idle testing on amd-staging-drm-next, they're dependencies for some
of the newer programs.

> ---
>  drivers/acpi/x86/s2idle.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index bfe611dc08cc..3d0cf0ace4a9 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -475,7 +475,6 @@ static int lps0_device_attach(struct acpi_device
> *adev,
>=20
> ACPI_LPS0_DSM_UUID_MICROSOFT, 0,
>=20
> &lps0_dsm_guid_microsoft);
>  	if (acpi_s2idle_vendor_amd()) {
> -		const char *hid =3D acpi_device_hid(adev);
>  		static const struct acpi_device_id *dev_id;
>  		const struct amd_lps0_hid_device_data *data;
>=20
> --
> 2.38.1
