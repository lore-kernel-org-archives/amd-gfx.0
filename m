Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C45FC6FD1C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 02:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CA510E071;
	Thu, 23 Mar 2023 02:21:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4088910E071
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 02:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzPbTSrghW67TMYEzxzWqHWMtbq8AV72aU4zsmE/wlGsImvjzaw/BO/K73gpXKtoVvo4/v5sCRlQgpkL6jUKbOpwqO4SVDqkLVYNqiRmyXANP5WVC5mNqXD6zkXyw8e2c+5KiHo9Jr1pYSaG4nRcBmPPBz7+6e+ri9VlNJc6Ao4mS7LI/2oGX535W2KyoJN3ZsNKMDurwxRr//rB8quAX8vtm467UyKBaTsUaxUZ0TQkWp2KcaPu9UF33QVwS8uC7Yuw5lw/xDSPeHUdb3vOwoVTo4JT3gnCGvWUWSDJVruZM67ZkB5Mk/TOvYXMYiXDFV0FgWxIGWlBf9rzSMkzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4KlQavTo72DvUkmiLLGEy5OgIk1lvsi/vBHzNYRTg8=;
 b=kJOXgYOA7PSHRY6RiqUm0e8mMcYjLVnc7kxzd0aYTgt9W1Rug+Ma7AEFTc39p/ret1+Pj01XM036TfO6pn1kjXmcDtGwsXoHKx9hcDg1jdhPiAVapHpBmTUL2Vm53jDgtU59wulHPddwl8S97vIhqD6+mBGYljK/aQvPdpx0cdG+OTLQ9LSHqD1IAK7N8msmdIMPRAw3abZjhOndph8bUvJn6r/SGYuv+lLXPCQ3TF8y0ujfS+t3S7NNT5PefT8egZRiLm14LG/jnojxbEoNpYF7D+PVt5Er+Dj+bV+W+TSFpy9Ce7CNi2kyVUzCrWXjdDmKKyXaGE/TEWESAPirbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4KlQavTo72DvUkmiLLGEy5OgIk1lvsi/vBHzNYRTg8=;
 b=ShnXg1VwGgjAvuxQDUtqJaYm/RtryNgTmI66V6SOr2riIKLLjnojMOeAjegOm1nhgzYNi66oV+IC3OTvpeDl1zFPvWDUH6ADWrRfCB/rEnORajDS82fCLvk2ZWOdcWtdao2BtcCvsMyy6UAoDR5Onbd1OZ4X7TjOYJ/mLS0y/uo=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 02:21:14 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::1530:61ba:3cae:667f]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::1530:61ba:3cae:667f%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 02:21:13 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: "Yang, WenYou" <WenYou.Yang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Topic: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
 enable message
Thread-Index: AQHZXJ7+B94h/6vSLEOceHAmhi0pDa8HoZPQ
Date: Thu, 23 Mar 2023 02:21:13 +0000
Message-ID: <CYYPR12MB86553BBA21040265D522C86E9C879@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-4-WenYou.Yang@amd.com>
In-Reply-To: <20230322091607.1609145-4-WenYou.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-23T02:21:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f0678d47-4b0c-4bb3-8e58-aa854d3951d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-23T02:21:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fc5c2792-a92f-4f12-9b38-ba8461d562bc
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB9030:EE_
x-ms-office365-filtering-correlation-id: d26775f4-8779-4a09-c844-08db2b454629
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbgV1JwIRu4QHzoCp0c98/OC04NLfnWQ+CxS+9t05jVXwHlmAWLgP3mJv5HB+XGb98atTw3boHG2Sd243FHGTnvuClc6bHVcdm3sN3msIMzb+XTU1q/z+Is2D0t28J261pA05kHcDygbzvn4xEziWcaM5ljWg+BsegSmVXJFMEgjKt0sVSvpGAnoZVxYuiwWFx60hUSFlFJJzy8fICR0vrUc2yWc3EXfIq8YeHo0iRJR5otwvWFFX5Bcg9JAJTGALwx+Urd87GpKwX+wTU+uC0v847KlhIIDxGhwJYOYQzRPsoxWm2TEcKtIVrf3fHsnPYKLs+nvt0yFQSKdk7Fn5tZqIqD1x0Elgxx876lgCr5WxrdDaLghFHtI/ikJGr6je3CQwa98tmxzmVUTlWYUz9yvEMiMa414PNh0dndTsm1cabZqA1yaC3jBpjcO/ykh4YX2haj9nkkE1DmnLMdsiNmU+cTWa2u4UfgzcNGJ6kApt/TnggKMjXt++N4YB8H/LdCQF9yB76JvV5CIAFG77qiy3wb2QLbssQVdv1yPR70IQLyNRBX+OwJ6FcwARoq+e4SY68aQq0z81i1m2n67HrK7pgJcfZb9+rWu7dLXGBbf0/6VsKDpdIGqTqQDWTsfcTqSH71Eqg5hhiLYa7DJ4H638g+Hx+Vstosd3hs0U0YHpgPhsqWujSf65paHIwtmnpljBchOnvoNmPKLass1Eg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199018)(186003)(6506007)(110136005)(66476007)(66446008)(478600001)(64756008)(8936002)(15650500001)(8676002)(66946007)(6636002)(54906003)(76116006)(52536014)(41300700001)(4326008)(86362001)(33656002)(38070700005)(7696005)(316002)(5660300002)(26005)(55016003)(122000001)(9686003)(53546011)(66556008)(2906002)(38100700002)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0VjZnvRSJvCsLwUzdE8v//+52FjjbJOhY/4N+MU4qQECKRWpaPks47T3rPHt?=
 =?us-ascii?Q?qNBZ7yqeYhc4ZpjlN5EbvPmy8oNkiO6Fg+VqelD+cQzCdCVAdzJYTnH/+0nv?=
 =?us-ascii?Q?BMcZq23twOHMcUDVQWIa3yXxgGGwMIORfc/UyFngeMKriPcmDYlr/qcnTfaw?=
 =?us-ascii?Q?BlRx9DV+6G0q0J0hsPLRPxcler3YpXur/HpNQng7q80XBofeTVbUmUbbydak?=
 =?us-ascii?Q?XKC7N5KNva6qbRjvTYDqe8/E086xBvF0iGnPeYg57uyrWvjtH70gJFUVvaGJ?=
 =?us-ascii?Q?ZVsZkMf+hXHJUw0BMvvR2jMm2gE0Yv7NDTSJjml3EQUkjbw+OFi7+otgz425?=
 =?us-ascii?Q?a+CYyBvlFge7yoeTQ1Q7l7I5Ch+ZFAcYLzbhn5pPMSYowFpdBe3Rvh0ZRSlm?=
 =?us-ascii?Q?Lakw06vfpoEgnh6SuBD5F1x0XYyUZYjuhJ0aBErpEZNABaqGg5HnRt6TiLSr?=
 =?us-ascii?Q?q2dgVCmh1i/k/WF9jkcqjHhXjRaalaOBcxP8kYlYEH16WC7/w16HrhkRP0xh?=
 =?us-ascii?Q?lz50wIG4E1rgAy8EU4YP8BnFbrRFVN8kY8y/E+3djIDC6xkfo+emY/UXZh6R?=
 =?us-ascii?Q?5NmR3mY9EUFmdgHXYhPGPCtc+9nSYgQhj6+9zVwmZVM14fADBrP7Fhj7hj3m?=
 =?us-ascii?Q?blbn3G9rt8Wrb0BttLY4MR2LISg4CL51myTV0MBnbpV6ft4TVzf/eKxLGSiT?=
 =?us-ascii?Q?ua6QtMvcAqBG0EiMzhYAbtrvE3PUNdaVNNI5VrMbl2aQH76kJjPIYNhHpXmK?=
 =?us-ascii?Q?02FU8nIcHilXMLx5VBNAVy62h0RkXg4iIf5BCz/OdsQDdzXEpEwB+2aYGvg3?=
 =?us-ascii?Q?/9aSlIU7s/RbZF6DaCaaCx3uOJTDAgbvBDyn5FjveJRjXi0XlD16YEaJFGOM?=
 =?us-ascii?Q?8fWbVXS2VDY6gnVLCCvr8ZArAMKlmkPx7xWsPUgvOPVqO7PEYVHw1BjYIdNI?=
 =?us-ascii?Q?ADnVJGO37Ejkl65XXg3dlNsrMfFMKc8sPNvMmLgfAMW8jMoeTANPCa4KL4S8?=
 =?us-ascii?Q?iFZwS5/clmqFM6BF+Kt0qYJCD5myVyrkwXXy258e4CTpl58hXesZJuy5o1i/?=
 =?us-ascii?Q?z4KqbdldFnw5nUfj2nDMHiwfUWth6hpcGY5Qik83jP+eoVxhA8RuP60B17ok?=
 =?us-ascii?Q?mWFIMI3Ml1g0v0VkvZgaiUNKlF0Blj/lohEBTA5W3hPMbiZ8N1xzHKLeOWnD?=
 =?us-ascii?Q?zGYlY0ukWF9zgJi4m4/sh8xrjFGAjvFkIvOg7GKADVYswvq/2SW7TrQyq1Lf?=
 =?us-ascii?Q?iZjbPjC2C+fWWF+faOR8oAuzVmALd8CNhdBmVTu+qqt55YMjvGbtTuBPrlmR?=
 =?us-ascii?Q?BsY6Mk2+8mn8sypwgjn1VZIKXDpBt0qsazeuJfMYGlBNz215YOq5ukxVBIZ5?=
 =?us-ascii?Q?jYIfIsqGtoApLN6Dj+TVX/IT2NAOpTCk3zcz8GoUrvdiMsZck0HAsNq54g4z?=
 =?us-ascii?Q?2zZ503UzElHl8W8ORptr33BbDN5R2JEC5vY5rsKsAplQv6iBBA53lVyZnQjm?=
 =?us-ascii?Q?GXzGlp3NJuSkjiZjj125Hhe6jydWlTY5oFBylrv7LjrxXAaHAjXdrvQg7EjL?=
 =?us-ascii?Q?LYuzaiC/AKMVCEEnHtnD/IfPFU9Sh3fxm0CfoITQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26775f4-8779-4a09-c844-08db2b454629
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 02:21:13.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWOAwSQFISHrolqIQSlLtlOUA3PmL/I0TSaVVrJgFKt0cVowL4JFB2/In8bnoG8Vfb8LmdM+jAQIOiZdEHr4YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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
Cc: "Yang, WenYou" <WenYou.Yang@amd.com>, "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Wenyou Yang <WenYou.Yang@amd.com>
> Sent: Wednesday, March 22, 2023 5:16 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Liang, Richard qi
> <Richardqi.Liang@amd.com>; Li, Ying <YING.LI@amd.com>; Liu, Kun
> <Kun.Liu2@amd.com>; amd-gfx@lists.freedesktop.org; Yang, WenYou
> <WenYou.Yang@amd.com>
> Subject: [Resend PATCH v1 3/3] drm/amd/pm: vangogh: support to send SMT
> enable message
>=20
> Add the support to PPSMC_MSG_SetCClkSMTEnable(0x58) message to pmfw for
> vangogh.
>=20
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 ++-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 ++-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19
> +++++++++++++++++++
>  3 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..2b182dbc6f9c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -111,7 +111,8 @@
>  #define PPSMC_MSG_GetGfxOffStatus		       0x50
>  #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
>  #define PPSMC_MSG_LogGfxOffResidency		       0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> +#define PPSMC_Message_Count                            0x54
>=20
>  //Argument for PPSMC_MSG_GfxDeviceDriverReset  enum { diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..820812d910bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>  	__SMU_DUMMY_MAP(AllowGpo),	\
>  	__SMU_DUMMY_MAP(Mode2Reset),	\
>  	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..f0eeb42df96b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -141,6 +141,7 @@ static struct cmn2asic_msg_mapping
> vangogh_message_map[SMU_MSG_MAX_COUNT] =3D {
>  	MSG_MAP(GetGfxOffStatus,
> PPSMC_MSG_GetGfxOffStatus,						0),
>  	MSG_MAP(GetGfxOffEntryCount,
> PPSMC_MSG_GetGfxOffEntryCount,					0),
>  	MSG_MAP(LogGfxOffResidency,
> PPSMC_MSG_LogGfxOffResidency,					0),
> +	MSG_MAP(SetCClkSMTEnable,
> PPSMC_MSG_SetCClkSMTEnable,
> 	0),
>  };
>=20
>  static struct cmn2asic_mapping
> vangogh_feature_mask_map[SMU_FEATURE_COUNT] =3D { @@ -2428,6
> +2429,23 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context
> *smu, uint64_t *entr
>  	return ret;
>  }
>=20
> +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool
> +enable) {
> +	int ret =3D 0;
> +
> +	if (enable) {
> +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +
> SMU_MSG_SetCClkSMTEnable,
> +						      1, NULL);
> +	} else {
> +		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> +
> SMU_MSG_SetCClkSMTEnable,
> +						      0, NULL);
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs vangogh_ppt_funcs =3D {
>=20
>  	.check_fw_status =3D smu_v11_0_check_fw_status, @@ -2474,6 +2492,7
> @@ static const struct pptable_funcs vangogh_ppt_funcs =3D {
>  	.get_power_limit =3D vangogh_get_power_limit,
>  	.set_power_limit =3D vangogh_set_power_limit,
>  	.get_vbios_bootup_values =3D smu_v11_0_get_vbios_bootup_values,
> +	.set_cpu_smt_enable =3D vangogh_set_cpu_smt_enable,

Maybe we can rename the function with cclk dpm string?=20
For example,=20
.set_cclk_pd_limit =3D vangogh_set_cpu_smt_enable,

Perry.=20

>  };
>=20
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> --
> 2.39.2
