Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C3EC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 05:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8279B10E4AB;
	Wed, 29 Mar 2023 05:31:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBDD10E4AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 05:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0cSTXFMgLwGr5xEr3/p3PgDiUwGJe6nT+jmDxYWypj4pLS6qWgbk9M7V9GsfzdKABLObLBe4FGn+Sy1Kt15nszMZIZgPkI80GTCLJ4hos+h8GTsqfIMqV7jH+Mfa4kxaX/n/tzB4yIamomKTIUPhVOi9mbhFBcgxUdiPNkLoZ7Hb4fLuxW67ksXbe7mwxiBPYClRlKp4JiU0QSlLCB0ObnYkkwcsPNeXGIe8dpnBm3bAKoqnDfQeLv/upyk2slOHrwvTZqmHxyVBeEwV9cq8BatBmtpyWlg3qU6IlEPZzF2qOx1vMwgFdY2MJAVi6a4DNZAZ5qurUfyugAqBEMWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2M2kr0iW/DuXF4l75+3fNW8vg+CPQct1ghljzE16Nc=;
 b=S9YbSgrVjsHwc5fIpnbqbVpH0SmU38z67e+EHCmjjAiqi6hzMDK3zSt0qVNkQtTMrdIX+oCG7veznSRzlMv6+y1F0zJmObeliTsOktZTdBI8V66XVcpw21PhhUYP2SsZKioCO8iGYLyZqc1WbZJQSmd6tEu5DDj0YnyokxejBIkk4PdzTfihMasniaxqamyzTs1VnaF9ekUHD1JV4hrMmMYBORhgkn8r0DsFUW1TyFngomkXvReJ+diC67Yz3wt0GMyiRiK5ByqYTXJ4ldOEY2JChOHGeKaBcGvgQzRqj/OyYCpHWl4fT2SPRPVrnjvQ5IXXh26Q7q53HE1KOxhoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2M2kr0iW/DuXF4l75+3fNW8vg+CPQct1ghljzE16Nc=;
 b=yqd1O1IT1llYN8k85nSXRvMMHsduqwgcsMPAiChlRCvpZ70QF8awh+HjYI9x3oZapmyPQI31QFr7xXAmR3MJL3yYSsMBVtN0KSH9BnDj8Qtkl6rgTTDMB0cR8mxHYiRyGI9rB0vlB4X8SNJFVgNUtVK1zVsWoNCVRqJFEAo70A0=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.41; Wed, 29 Mar 2023 05:31:26 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::21d5:1136:9380:46b7]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::21d5:1136:9380:46b7%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 05:31:25 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: Dan Carpenter <error27@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check
Thread-Topic: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check
Thread-Index: AQHZYf81oIRQslS8mkK3pzc1XoYbD68RO0Yg
Date: Wed, 29 Mar 2023 05:31:25 +0000
Message-ID: <BN9PR12MB52573A6551DD2E6464AA9AD5FC899@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <580414df-4adf-49cf-9930-743f7c539d46@kili.mountain>
In-Reply-To: <580414df-4adf-49cf-9930-743f7c539d46@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-29T05:31:21Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d4264d0-0be9-43dd-9dec-e2b7de4dbca4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8069:EE_
x-ms-office365-filtering-correlation-id: aad08b3c-801c-41a2-5eb0-08db3016d6d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dsOgUo5rneT6fIZobytM9YKMRrsgBdJ4LGtw7vG2TBNoexZY//imGvtIUk5hgBFis3BtKL2SbUNlKiwdL7PNI7AyZ92bqwdxTF075dSt2qyzVWebJ6XStvcSIwq9pP5VIR5frmxyfPxeM6bclbRsYl+eF/fv8RXQjPZqwVLsq1y5JbHyWXOzj2hXiuPslfVj8IeP257RRcQyV5J2zxfdVA9U1l6PuBhzmrNl+SpVj1iP40+jVO8H8iCakXN6cRVZeRMBVAaPN593Ry5dIP/ftVBAnwBLrXL+Vbem3NLsA4Hg3Lrg9aNWB8b7NRqhNxoFydQOA3deendcMi2ki/iRg2f66C+hIP+vL51wFe65JJtPttjwySRd9ipO7NgDpV/nCy6Yy311SiK+ujpW6h5HPLfWrRruonmgGwSNifl75j5cTHlODfuQBTief8qPF6OuilSD0gP+pMc545Ol0snbfrHphshYmn5pQaMj7mx9TW8h3Yvh1EUO+JTezkGB2KH5vhnNiZxz+mGu4oF9teK/zIm+2GDrYgKXblDPISmNC38siL6JhD8NcytCv1W49Re86VxBI2Fv2eB+GfjwlrpsMcICYbSnScnIq7a2hf2ylampoSb+1rvCvphBTsc7QTwudDs4kdVzWzmplwaRuZTcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(26005)(2906002)(6916009)(71200400001)(83380400001)(86362001)(4326008)(38100700002)(186003)(8676002)(38070700005)(66556008)(64756008)(5660300002)(55016003)(41300700001)(66446008)(6506007)(66476007)(8936002)(66946007)(52536014)(122000001)(76116006)(53546011)(316002)(33656002)(7696005)(54906003)(478600001)(9686003)(101420200003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXQhgxb8zEFsTMa5G8UAJFvB5SLyrw1OnLuIUCDp2+iLrsPwZV7g7kdnkiEs?=
 =?us-ascii?Q?oeGIIt0qS3ZOwZlPPS5z14SWDLA9PX5v7uUdccwTnm0Rtc9OF+7Tl9gw076N?=
 =?us-ascii?Q?qop91F0TyPEJX4twcUwIGvLvHXEbHOi030RdPI3q3FrrmnamXrje3al0Cj6g?=
 =?us-ascii?Q?Jz/8ptRzofp4ThwAel7N06QooSU6lDYjhK+rl27pAdOEJsNn9s5Q/xLxZq81?=
 =?us-ascii?Q?h5JEYPSFpCH5Myv3vWVULk7Bqr5IdUWcVVjshQofzSENPcfKWbbinxICuXLT?=
 =?us-ascii?Q?e6Lc/xS4lg/heSNjxjJZoPNDPXDNSQpiYrYqDmj1HPnv2Yj/las8qcNkp+ul?=
 =?us-ascii?Q?2rn6JdGrkfI4BNAGc5I8a2rX/PMbTKSjAzU0a184EfnBqTGC+iD8RFEFbMPh?=
 =?us-ascii?Q?N+T2AEwgmN/1bJ+50k0tusOwThFqv6qRnz31vEiN4M9Ostkcxgbc/4oEJHfJ?=
 =?us-ascii?Q?NFkzftIuOZG7/OKEn63TfSm13G2SWMaMmsPf3grhmzlwX5ilV6o+sSQrgv8T?=
 =?us-ascii?Q?xWPRlfxppJ9uK/sfGhl3CWjcogd8otXup783JTZvyYd8EpyKk7fbWh8k2/7o?=
 =?us-ascii?Q?nTXyH699Y1EQisQ5MEpfgHeZDkL1/T0pUxPbtjNZXF+OkUU3rxXbIX5xUlpd?=
 =?us-ascii?Q?b3hFOtMRA/dug4NYc0vBsTDURGvOu6jzaaR/oh/insIrXbozIWA44Mg8s4cp?=
 =?us-ascii?Q?Nqo6W0ZfP7KeHCjyLQaFwvEKh9Kvdt+VwSHMJ4YWfCJhmI8c5V4kfUQ9QwZt?=
 =?us-ascii?Q?hziP5G0dgzqkXPSjKwhlOCbpi8/KCK4mzWQ7lZ+DJGLgRkQ4sIR5QLPy8lxA?=
 =?us-ascii?Q?eCHqHhHVydJ8XcGFJZ5SKjTIYlhmyvws8L9G+EMscdHWKJRXob/jH1DXqJY/?=
 =?us-ascii?Q?L+dvhVUtXPK9sCqou2qNTv+L48/Ld6b7g/aF3eJJeU0DPdCnT9zD5FdKEgQT?=
 =?us-ascii?Q?O2N0uSGn44uOhixv7SFaQfj2VLaxFjC406UJW6+iOSywiAHiQO/+lEx6b8Nw?=
 =?us-ascii?Q?2nvZDFjyG9EYFByEjahcd8Z4wpLeYQEv+ocT4VB2Hoj2ysol+JbBxBawhbBs?=
 =?us-ascii?Q?NQ9HbclvuST/+sQSefOCqZ80su354RTR10BbhQ88nnL0o+9QwxQ29TIfbQqu?=
 =?us-ascii?Q?MSax05M/EwPUEy1Pc+GEtjk0OaRxz2TET1yY/YwsbyvM7N3KoF+SHkSQWA4h?=
 =?us-ascii?Q?JB+E17GSfzhsPmutxRON63BJphhDzeMpDKCn0DSXYyX7ZbHxWs6E3x3Z2tlG?=
 =?us-ascii?Q?/qK4VlBi8RBXFKPyfIONa1BcfT9HPTjnG9Q12UKKpB23DUJPhhj2Y3z/D6TW?=
 =?us-ascii?Q?oeXbNAOBgOo8rzll5btTOs9p2sRcELdwq1fMenxHIzmkxRpeH0QBEV9tnDPI?=
 =?us-ascii?Q?NqDBNN0w6i66C9BwxHDlo/Z9+wDgfWRY0t/2vPhWZQPNA5YSAjq0Ki2zb/SI?=
 =?us-ascii?Q?geoYhP9N4Ny/puG73Ne6RE4Cu/gK4SgNkE5+xUu10zMkqMvDOBD9UjsH2bvl?=
 =?us-ascii?Q?VtsredAmkWlBY3mfVP3mwplsg6+UgAnTCOmAcMydVqKZlp2EA3plkMnrhXQz?=
 =?us-ascii?Q?Q+cwBTA0Qg0gbXrm54M/J1mk11wL2QexfztvS5m1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad08b3c-801c-41a2-5eb0-08db3016d6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 05:31:25.4503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeQ5CgqZYbLaODNwkP1CKwF+zzujeOJhYksVsCi3vcetAcj23/fluoM5LB4aaMAu6SvF/PE96XAv8TBaEHe4Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chai,
 Thomas" <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dan Carpenter <error27@gmail.com>=20
Sent: Wednesday, March 29, 2023 13:28
To: Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@a=
md.com>; David Airlie <airlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>;=
 Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Ya=
ng, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Zha=
o, Victor <Victor.Zhao@amd.com>; Li, Candice <Candice.Li@amd.com>; amd-gfx@=
lists.freedesktop.org; kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix AMDGPU_RAS_BLOCK__DF check

There is a mixup where AMDGPU_RAS_BLOCK__DF is used as a mask instead of a =
shifter.  It means that this condition will be true for AMDGPU_RAS_BLOCK__M=
MHUB instead of for AMDGPU_RAS_BLOCK__DF.

Fixes: b6f512168478 ("drm/amdgpu: Add fatal error handling in nbio v4_3")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
From static analysis.  Not tested at all.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index fac45f98145d..4069bce9479f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2564,7 +2564,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			adev->nbio.ras =3D &nbio_v7_4_ras;
 		break;
 	case IP_VERSION(4, 3, 0):
-		if (adev->ras_hw_enabled & AMDGPU_RAS_BLOCK__DF)
+		if (adev->ras_hw_enabled & (1 << AMDGPU_RAS_BLOCK__DF))
 			/* unlike other generation of nbio ras,
 			 * nbio v4_3 only support fatal error interrupt
 			 * to inform software that DF is freezed due to
--
2.39.1
