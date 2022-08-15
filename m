Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD43C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 08:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9399B8FA0F;
	Mon, 15 Aug 2022 08:46:40 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B40AE8DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 08:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMmX59T9QzziClLA6g+Vq3NXsA/h0S3lKPxsa0OFrYZAMiD4OvadwkdPvKheoc/7aFGf0f+slhZyE4QIa12o5SCjDzR7CJ3rjUAqCFaN5afX+/U5nAqn9j6CPJNSlR9p92gMcx/66u0hQhRAY7RTZ3v6JA71s0Dj0lPDXcTnRFS22F87KNwtd8F9sR2UlQXcw+x2AwZdtrWj0CPV9TgD0Q90H/901VMuJbxlyQWNlbUj75YWdkyAfFEA/goLccvI/fam9PPh8rJyFA6hrZoZMkWRN+GlHAJFojwhLzbRHYKlkCNeWsvXKsEz0zBNdrtvUM6qzKHcG0EW0o2cxjgjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd/blX0Qu/gEdiQ6sTXUcBrg7Sd54Uln5LBG/LlU7XM=;
 b=apsq3Pw/CGER/x8WGIJw++7UauYSpfEJ3LEkIY32KUPDOqHsPythbkvtLZHClCa2/nVGpjJ+U40YYjDRZs+qs7h7FHaetMqe8Iq63vQkt6rIcEbii8hZAI0scB1X6BgDXqXbIyr+S9TfAG9ov8wk9hbd5g6wcBZ7+1Vu8pSDq0DhMi0FbbyFFAGZtzYTW0as2SeECoVzi/IM7zWMbN7zUljtC5lpEIcp5CDcNZUzZ5+FbrXOoUA4BEZTDvycJqw3HeLdN7K6mAz5DmH9YiAbBh79UzEI+JXLBuIvYOXcZ0bHiyuzG0y64Vbn5cbmepsbu/RhNdbgyeRnsvVG6miBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd/blX0Qu/gEdiQ6sTXUcBrg7Sd54Uln5LBG/LlU7XM=;
 b=m57WEx/pfB8soY8djQ111mg6cqizE9DFuBAYGQx7DH4oR6QHD/4+OwsfK6EarVmSftMz7YwM5x0M6cpFBfIJwp5lenZIrzZyfHgu6JPcNZ85d59/NxGWzhFpwaNiDfpLPLB0CmWLfg92dR3FArCOy5F3Vwu/hTQZtcfdZuOOjUE=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 08:45:51 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::2956:2de2:e437:ee5f]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::2956:2de2:e437:ee5f%3]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 08:45:51 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Xiao, Shane" <shane.xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add secure display TA load for Renoir
Thread-Topic: [PATCH] drm/amdgpu: Add secure display TA load for Renoir
Thread-Index: AQHYsILa+CL38lndOUeDTmRtKbcX5a2vpb5w
Date: Mon, 15 Aug 2022 08:45:51 +0000
Message-ID: <BL1PR12MB523716B907C1EC94B7CA834DF0689@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220815083952.1303363-1-shane.xiao@amd.com>
In-Reply-To: <20220815083952.1303363-1-shane.xiao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-15T08:45:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4ecae737-ab3e-4f7e-be4b-178a1094aa05;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-08-15T08:45:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 13353783-3f5d-41fd-8b6d-54bc1b0b0a87
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ac17c72-4fde-4230-36a1-08da7e9a8ec3
x-ms-traffictypediagnostic: BYAPR12MB2869:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bdhkBq+MUuuS7ytR5nEyauMOiPTEDSfRtgV5pIEgV85r0mF+cT1h8eKQCQXtHoEfGL3xR9vDjgH1g0oNGlOGLVZZFssS0+8r/LoZxhSvkqi7ET4VTgJP6A5nthEv7gbeiYM1jIVLuNF0kcXxk1Y33F5jyVLKMYgdiUPCbfKud58lRNYgn8bYmUHCQ+2hZx1RVWcjFF9B9y7tSm30TPwi3guZJB139aQBE3Rkf2fyWSPG5D/XlR8yc2/3BfigcDmZaGv4vPDIL9HdV1dL5d7mhjdSjj+6+eiMkS8DTcyM3yxHdYobcZ0JubG259FcfaynDL72TYyhKRVmjy758n+MZNUSkqJ8Y2oKfqCmsqwUo29MiRIsH1V8Zl/wcgakgTnaZavXPOvDMZU2E4bqIOSysEyvWaOL16ABoP7flDAh4vhh00fdBRUsRRY3Zfp0VMDA7b6Ye4u46hooqi1P3Pr29UPyBpmKFtP90xEjA09d0w71GTR9a7nwngpJOKgdP1gGFLS57aIYA7s571y3Qq3zfKU+9Jo79QBbJ7Scq5iqGLh6sMCV/fUER/bgevphuD5SJmRMJaSGOrphzPmql5cabw8uxWSOdOr7qWpCuRbaIxWJ4h7rrggnTetwRDxZqZLpz0jD5XLn438U9wE/Xd+e3lY7qbdifnND9i46LNSUOgc0Rb6SJi8zjYJG20hof/f3xFiEYJKRP37FXt2hAOXi9piu3UxJm+lMOZzDP4nijrsHRaEcL56RH4Sc1GhJ5JTS/uTHb95W/WcFjUI2VNudGD2FOk+i5MGHrznOhXGkJ4jKEioUsqJ7UP898JrxVsD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(52536014)(4326008)(38100700002)(122000001)(38070700005)(5660300002)(64756008)(66946007)(76116006)(66556008)(66446008)(8676002)(186003)(53546011)(478600001)(71200400001)(66476007)(41300700001)(26005)(7696005)(316002)(9686003)(6506007)(83380400001)(110136005)(8936002)(86362001)(55016003)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LXz1Usiljy7GPiyiriScqz2hBE6jjVr5B++3X1feQfxrgK15I65YiaIPNMCm?=
 =?us-ascii?Q?+7i66+bC5xleo0dPwrVTszCBobqAsA/ZOjEoYQIdTfaecyTkZ3YL+84MISZm?=
 =?us-ascii?Q?1VoVPYsrMfaIfGlzUaTq7WRdoG3qbIc+EKSxpInzExa85a4lRxEkOZSunqsp?=
 =?us-ascii?Q?zso7m6ii0dq29DV3CFIhmRxwZpRRvKIeMZZxiD5ToPEmPo4Uo2iEWYa8VgH1?=
 =?us-ascii?Q?bno6yFkNTRDVE1FfG65bu5J94NJ0iiuOXP14K3BXiLfBIp1++1PmfWmXMp6W?=
 =?us-ascii?Q?LvfO93+UvfA+mxmEzmq//lutfvcLqJGWEqsRZMK1YEEmRUdlIrDlHdUJfXMu?=
 =?us-ascii?Q?OUjtlGAqd202BCxX88myCF+EMhPb3HPpIVwJMtZz+wV4Mo/z3w9yTk37azQo?=
 =?us-ascii?Q?iGM+y58REdHlpbRZSWOfUnzLaHSB8zxvwf3g0QLdOhq1/cc5mihoKt3tQ0HE?=
 =?us-ascii?Q?D5PBiSlIJwFvLG5+2c1Q0qZJokPOLEiHxqMKIO5CoxprYDZUNCFNez4sxpIE?=
 =?us-ascii?Q?34aOtfM4xR8QPHZTUAJGT4mIwpAwrTz3d/Ln2/jNOps7YOnlEWGF9wKkTygw?=
 =?us-ascii?Q?TqW9HDT4Tsh6sd+YiDLlyfzAkNw+leKuohGEb0cW7P0wgU1ihtQttqCQm1QT?=
 =?us-ascii?Q?XqFG+JV4uZVTgAsiwtruUflOIbO68BqB1iCW/UcrU0Uug3f2KO000QD3ynYi?=
 =?us-ascii?Q?Z3m0dAZn2KNU5KVNBEEvYAXaYZZFbFdISknmA2OA1x99mCKmxDVCMuO2uEcH?=
 =?us-ascii?Q?elAAR25syJJi4spMO0cPTKKieOnVgQU45uNP9g69/VBEuZJB4j7McxqU/iyg?=
 =?us-ascii?Q?7gp+yYL59YQ/Xq4mrkxOIbrN1wBDq83H4byDzG4DRyh1qbpuTTnKIuBusn3l?=
 =?us-ascii?Q?b1UlK+VLPoGv5FpQvp5vtbBGei2g3/bEooEQP4DhL0g+SCqsWT9v8av67tXK?=
 =?us-ascii?Q?TCL9PfzHD0nrBL5FMz2fBpiMqnmmOodQ0LANOW0M0ydf/7UZj3srExP3Hr8E?=
 =?us-ascii?Q?OWw89SliuuFNJGnRZLwzj0K4AuNg2JUx/oL1VE20xywlibai6c4ZMDg3uXbk?=
 =?us-ascii?Q?ey3VV7MazAg1bqx0KUKsIG92l94R4eDkFdLlGSbEIysLAJDg01f531692m2b?=
 =?us-ascii?Q?g3yInwprjn2LpzAh8kogi1lUF0wq1L/rjwapVzlcK13gvrSNpd/VPzwJodCd?=
 =?us-ascii?Q?yfpe3cVseO926yQaSPdnSXGlSGd7XkXptUKgLENnbIvQQbnK3+xNZrejG5Wz?=
 =?us-ascii?Q?R0rDBDprRj5i1OmYZ2n3baAvWGEZPG4p3aEg/twbfy78F+zJUqWugMht04+3?=
 =?us-ascii?Q?/rMWyLGkN8Ss7qELk1PjSpddpNglO0nkDTf5qYFDEYIHsDQZUW67ZMVItDTO?=
 =?us-ascii?Q?88obdOkRG8c14i5oDCSYKu8+Qp+LLkIY5lXngBMl5leCUk0IjrCP6xVYwqh8?=
 =?us-ascii?Q?V+j73woWmXpqWZEFO4bxA4DaoW8EHk952ppGTAzJ3ldvK+NgnE+lP1jX9dek?=
 =?us-ascii?Q?jvaLDkW4bA/lAJ+PTkmNm21jYSZ9HHEFaGrSV/HRER+I1e9M6pzmXocqOO7E?=
 =?us-ascii?Q?IpkJ/wH68SvRBPYhtWI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ac17c72-4fde-4230-36a1-08da7e9a8ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 08:45:51.1412 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r70Z6qpfrxrFM8/7Gdq8ThmRneQGPr7HjRHwGMM7YlswvIWS0AMnFoTkpU9aCfmC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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
Cc: "Xiao, Shane" <shane.xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Shane Xiao
> Sent: Monday, August 15, 2022 4:40 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Xiao, Shane <shane.xiao@amd.com>
> Subject: [PATCH] drm/amdgpu: Add secure display TA load for Renoir
>=20
> Add secure display TA load for Renoir
>=20
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index a2588200ea58..0b2ac418e4ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -101,6 +101,16 @@ static int psp_v12_0_init_microcode(struct
> psp_context *psp)
>  		adev->psp.dtm_context.context.bin_desc.start_addr =3D
>  			(uint8_t *)adev-
> >psp.hdcp_context.context.bin_desc.start_addr +
>  			le32_to_cpu(ta_hdr->dtm.offset_bytes);
> +
> +		if (adev->apu_flags & AMD_APU_IS_RENOIR) {
> +			adev-
> >psp.securedisplay_context.context.bin_desc.fw_version =3D
> +				le32_to_cpu(ta_hdr-
> >securedisplay.fw_version);
> +			adev-
> >psp.securedisplay_context.context.bin_desc.size_bytes =3D
> +				le32_to_cpu(ta_hdr-
> >securedisplay.size_bytes);
> +			adev-
> >psp.securedisplay_context.context.bin_desc.start_addr =3D
> +				(uint8_t *)adev-
> >psp.hdcp_context.context.bin_desc.start_addr +
> +				le32_to_cpu(ta_hdr-
> >securedisplay.offset_bytes);
> +		}
>  	}
>=20
>  	return 0;
> --
> 2.25.1
