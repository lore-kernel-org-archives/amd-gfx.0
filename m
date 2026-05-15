Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8008BCD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 13:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C48910E128;
	Fri, 15 May 2026 13:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TS5MAin0";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A626D10E114
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 13:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvivfs3eSO0/0u5fU9GOhEiib5O9YnEJmQrsJAKdUAvWRqz+csfeWa03coY6txYUakoDeaT2ECCCO0sCu6z3Dz0PGcHDz+4kluapvQSKG79uVp+DvdUDMctnVc2vnaETW0/LjWTEVzgnjNMuhg+oLOyFcmuV4D/rAcW7ZuKCo2PHkFW0yo7QeCiLjEuRYIX4hk3W5n4L3/FvWVUOlkEigjy27k64kSGXOuVmY7jCGy8vjAi6c6Xi5L5OGMLJyA4UdRBh56JZqE4z74dlSyZQbiHyegmUm5fc5YrY3OhuX/K7mU0vZJosnq9LK5xGYm7mvqqw0e4V6nutyTiIHlUR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBF4iy1vvOLRpJM+zas3T9TdvCECklgx9ZHBFEiEukg=;
 b=RQCnemVgx60bl6xRkngJxMph8VpePTV1ljp950F0DtvuSSvW6TgjpYHwoE3yS46/7lidBWs885WH/mI4nq4034w/78AwrR3oWDiYyA/j/uOu/bKmf2OJ5oblD1CSJFDcS6pvu4sHzwZQX08QiFuQrDvdPo1NZvbGMzblGC1xz9Hg4MCxnkdxB1rmL2X7QUxH9Oq3oZIQWnM0w5JYleSUdbwu7SnmpdvuJyaMnDLW8Y8Edh4/GTLUvZD0h0j4OIPjcf15Uh3Gt8MBGbM3Ih+5HrCL93KXIm1kmNTlsJagrn5birhCD0SN8oHSnLj/YeIIuQGV2V/XR0b4a2zVS/QZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBF4iy1vvOLRpJM+zas3T9TdvCECklgx9ZHBFEiEukg=;
 b=TS5MAin0ofL/mSIgf3ZbzHTZ6GY/XZ+nRoE7Ui8KZG3Kk47WHcx7kOtf1TyLWxP5U+gIBBcT1t1trWKceIKf9IzBOHYkGNp6wV4LD6H5Yova0G1GNO/hRSIw4JPTUbL+1uPjdhOtbuEQS/VXO+6OkVvjWx3UniyihZ/pTERcfTc=
Received: from CH3PR12MB8481.namprd12.prod.outlook.com (2603:10b6:610:157::21)
 by DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Fri, 15 May
 2026 13:12:40 +0000
Received: from CH3PR12MB8481.namprd12.prod.outlook.com
 ([fe80::62f6:fea6:9c81:a20e]) by CH3PR12MB8481.namprd12.prod.outlook.com
 ([fe80::62f6:fea6:9c81:a20e%5]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 13:12:40 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Muthyala, Jeevana" <Jeevana.Muthyala2@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Muthyala, Jeevana" <Jeevana.Muthyala2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified
 ring
Thread-Topic: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on unified
 ring
Thread-Index: AQHc45XkJW8f8+cDBk+pc6r24D9forYPEL9w
Date: Fri, 15 May 2026 13:12:39 +0000
Message-ID: <CH3PR12MB8481B5EC67A275E61F33886EE5042@CH3PR12MB8481.namprd12.prod.outlook.com>
References: <20260514113558.1160387-1-jmuthyal@amd.com>
In-Reply-To: <20260514113558.1160387-1-jmuthyal@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-15T13:08:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8481:EE_|DS0PR12MB8072:EE_
x-ms-office365-filtering-correlation-id: 5388b6e4-cc9d-41bb-5367-08deb283a466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|366016|38070700021|56012099003|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info: o/i+v3NU1ytp7UCBI3IX4QeQO0EYLAji5e0KuFiyGmRwvswgB2i8OyS00f9dIUhmbd+5iQbGNioRWwRKPu/ZCsqNFRow1s1oM7jMg1VdNNdSNiWslwdJFzTUCiUxdZKxhw99yi/J9Um26D44yt1r6jtznZeAdCLJ5fIzaKgsqYuAhCfbwcnu9Qpf7fWDu+OKk2BJ32/BMWZc5YEOY751Qj4R+WfcE665SrMBAuEQBaC+/I9AcZkB+nvHaMitwwDhYYAoQ+OVjucV0N5rxVVSpMhjbYAZBFAALnZ1oj6rMIldSRtyyOx7nK2Y/s/PvNiwB9y6PE+GIQXATQ2rs0d6/R5SOW1kFu5G0k5Mfyrzk6zOFngN1/aAMJ8xHLDKB/D4/9wwR+S7FOm7ZKgfsawH2j2DKEQOJDcQmLNUNre4KkmH81gGDjWh4ee6BD98LLoIINauGU2KDh83NdrAgGA5hNBie0o/Me/BVoQxQIOiT/08WAJtsDFcb2yyhXZ18yS9SYZiNr1kfHRq+EYBxLI/gihDn94d0Tm+PX2rfb8S8GdLZibkWVqtnL0e2rv4CY3DEtgVmUXEBJihJ9EKb30NaOG2lMz2Fk2EaOPaGitgU9ZjYDBTkJDI+5yMBr1SVarBWP8hKrgA0qoaduVAPAA30AwyU3gLTDj1o6CPwfdXbjoEDOd9fTA2fy4o+klJOm9hx1CFpXgEYrvQ3eUzz/3GjGMFUt7YZzBFNuzXiSxsjwXQLKhb8jsosxaPTD+uRY54
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vdahIZx5eRa7jVfoRMnALG7TSNDBAY218oaZ7V9efUo/UBrcdMUpqGjxVPzj?=
 =?us-ascii?Q?CWgCbZujGXv4KSuBItMeGZDMrtiXXe3XIfbjI8Ju21t8wd1O/DL6ej/hLrPq?=
 =?us-ascii?Q?ThWsI9HUkpSzIMYTGfqUkehSNDyw3Loq2QFRswAcFx4l8O2EXbCjqFofYS4S?=
 =?us-ascii?Q?kvCy0bTL69C0R2l9lPDujDCcipNj8B4GDdW4AH9f2KEMLLGvjFIu3fv0BSv0?=
 =?us-ascii?Q?oAiUMHiseR6CnhjWUwb1mz7zSaDUTVI676sBSUgYd6LXehsbnZB2Rq/EJ6l+?=
 =?us-ascii?Q?UucUqdJCRto4MujCfK2Ja+T0T/uwRMjFO2E5WW7lVbylKI/7Qyx2pQjdxXTu?=
 =?us-ascii?Q?DbFCPRGXsIwK6mM+6HQ8j2dUV2mnQSRrQNQURHtwgMilFeFgJNqtXNk8fCcz?=
 =?us-ascii?Q?ATyTBXhXJSWH1/smf5vHLxD4iOffp8ruxZ964FiVPnuKwZFzlLOkrmqGSQ0f?=
 =?us-ascii?Q?D0rWePjMCoiVZVgO85qlLHTmwpVW7ktCYRCscyXhyB2yrBVsF42SgGsT2W0G?=
 =?us-ascii?Q?Ng2UA5uM03xKUwYHfXQZmSor5y/ejvY3p+cjkyPmU7Xt+RD2sN1BpO7gs4+R?=
 =?us-ascii?Q?0ZUAMoxOHME63Ansv2X+BDUYZYSe/YASlkGqyu9AjtOLm7KjSxqIKn3jDYrt?=
 =?us-ascii?Q?obHyTdi9QbAFYt2oqYHgrq7vHJcpMUnIzg2mkmk00UiL+kUlJtyQ3ELXoSbD?=
 =?us-ascii?Q?45OObrKf7jNV/J7I+vFXaDc4LAteovnlykKH9yxEdCYRB/nBQlBhKVuIq3Fi?=
 =?us-ascii?Q?TYpDl2bpTOI1T3y1Fn9apFoh4OiSrFgtfC/vf8AwX45m0KcHk7Mx7rmpanN3?=
 =?us-ascii?Q?SnRQ+70ZCIvQco+bEI5VzkPlEjaSWAwhZVT0lN4Vv2Os2lmVbe7Phq7bU9Px?=
 =?us-ascii?Q?Db/FTtMMCdKi4smeV5jj0jbyz2CYB7TVR3ZFFabF7iVGd/0cwiQp1xc/9EWM?=
 =?us-ascii?Q?DRfTo2apwdrDQ+a0Mee++kSGCrWvMwm3j7pAYnKY7PF2oTo0x0EQpVn32CUH?=
 =?us-ascii?Q?v2RuMIpqKs/LrnagrOtrwPF1u1wBUhsWS40YZNpa2jUIDqUG1aO+hMYyt7oq?=
 =?us-ascii?Q?ofxeOBY+4/oB/1U3nyv66q2/qisybupV4fQ7HZFhEQtaXFLgwVdibWEq6FLB?=
 =?us-ascii?Q?nf0jtapA3MhXtooBUVVZhfeH/w5gL/gM/vGeIE/AXrEZWqstTpLMoH6oI9EF?=
 =?us-ascii?Q?P+cRUtktUmo2ZPufIyBpgCNiJuZFIFD56SxHXTEswfFwt6GLzbs6xKfPLLFQ?=
 =?us-ascii?Q?vT9RuSpVvKsF+VJrhMerM33vCeTvVh20o4YSC9VWQ/dAop5WKhrazaADJL8X?=
 =?us-ascii?Q?GRamGxbHBn9Ze/EdUT7bO1rTEkqPBhEGP7VWu+1oyZX8PUWyBnHR9H+Y+1si?=
 =?us-ascii?Q?AIytlQ1Z1mBlgBNaQitimSsi9HvmGL6mgeyCWg+gSnJT8iErnUcpOp4MCWkz?=
 =?us-ascii?Q?E3t2RzQTr89AkUofF7qg9gBl6TpO3/Mq4IJyNUfMeK2TH8OQOezral/nWEjk?=
 =?us-ascii?Q?cZcpDJ1dVx+Q9g6or9H5z1dNUqFt5OS13uJXCZSG1sGt5MH462nWZP2R/LEf?=
 =?us-ascii?Q?UiaeXsqEgd66btUt8+QB9WPnKokDNPDHx8oCGVSM731Wzvh+lcAKucH8a/VM?=
 =?us-ascii?Q?99ARXU/E5KSANpZ4/NXsdn8gyLaSl29MrgePqa46cmKiwv6QJ/2Ca0kxveZD?=
 =?us-ascii?Q?Xy5nUj2T057U/T0SbxxBuez6nLNg65eod/C+KoPbQXDstLTC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5388b6e4-cc9d-41bb-5367-08deb283a466
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2026 13:12:40.1280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spdY/pxCp6opS7LNdMGLBmYt3KfUx16vIqpFbsjmHBVHvfU3jW74Yv0IGkCiciaI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jeevana Muthyala
> Sent: May 14, 2026 7:36 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Muthyala, Jeevana <Jeevana.Muthyala2@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn5.0.0: enable secure submission on
> unified ring
>
> [Some people who received this message don't often get email from
> jmuthyal@amd.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> From: Jeevana Muthyala <Jeevana.Muthyala2@amd.com>
>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index d5f49fa33bee..f875dbcd4f6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1207,6 +1207,7 @@ static const struct amdgpu_ring_funcs
> vcn_v5_0_0_unified_ring_vm_funcs =3D {
>         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>         .align_mask =3D 0x3f,
>         .nop =3D VCN_ENC_CMD_NO_OP,
> +       .secure_submission_supported =3D true,

I think it's probably better if we can set it up with the specific HW versi=
on instead of overall. E.g. vcn_v4_0.c:: vcn_v4_0_set_unified_ring_funcs().

Regards,
Leo

>         .no_user_fence =3D true,
>         .get_rptr =3D vcn_v5_0_0_unified_ring_get_rptr,
>         .get_wptr =3D vcn_v5_0_0_unified_ring_get_wptr,
> --
> 2.43.0

