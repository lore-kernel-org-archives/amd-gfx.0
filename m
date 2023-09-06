Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7413CEB8FB6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D263D10E00D;
	Wed,  6 Sep 2023 10:15:38 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AD410E00D
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kka9iAMiUhcNfHRG18QWxXn+H+RE843VGtnWa3NyuO3eECah3TjPcfELKDaWVKsG2m+fijSPg1ttARCV4Gnl4IGw8Zu2XrZtX+fTvYVOgD0sEP6mZErx6HRd80jHnP5EfsV66hMNG1DGBMU3o4QjATUfaTyzks24aPOC4ZhnlTBknCP/pzQSyjEtUuSz8sOjvB5pewMOI7dhrZbYHa066iD3dXE4clvRwMNM7szjvwfVQETZNxD57EtyJcztbOnpL0vvLNL+2BjEYar2rSOodU9mZNQ5mmQuv+bEfXUCv657IsJwJunPVKyrJnn/84OIItGl4wqnxIIjSobmz/HOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB5qa0pD6FQM+KPqdkyBRA/qeq7Veec+zD+USZXw6y8=;
 b=DPAthimLsa3km4lrsGiAzkIyIeE3rRjgeoaLjHWkEY/425Up1JKd+0BSCTnMGby7zI61VssZKJ0lR6nCPLR9NHCMbApbWKjmfIDn4HLn/IC6XZ4uSgeCSgf02/KcInZQoNM2nGIdEMJt1IKSmd5Q5zfuBtevP7KcsilZnRF/9bm9w9CDDL5u+gJ+qWAxgWpy9WdKDl61DHcOG3l+zIIH1vy83lJgejb5eQWGeKcObk68fr6jQOutOr2+aROxQ2CqC8sZscIxGBJHkzhOfUWoJERr6zmShEtTbK/QEa/MtjxFb/MYVAMwg0TgI4iQ9sVyh9fd1R4zFpziM6FvWs1rDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB5qa0pD6FQM+KPqdkyBRA/qeq7Veec+zD+USZXw6y8=;
 b=pWj5KqYcyrUJwZsg3sKT2+WaWRo2Oeba1iAMKeZSj1Iz4iXZvnn99y0tQXFZXf9EIH2EqtKPwHi3nD5I8MU7XtP1JdmESRMz7UPvGT66qOvAmOedl5eIhMJnSifzTVB80mDv4m/b/jciOXUPefTSzvE5fVtVhmPf7AzliguVXgk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:15:32 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5906:d279:3bd3:1100%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 10:15:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Correct se_num and reg_inst for gfx v9_4_3
 ras counters
Thread-Topic: [PATCH] drm/amdgpu: Correct se_num and reg_inst for gfx v9_4_3
 ras counters
Thread-Index: AQHZ4KrEa6WdY4Je002RDkFzen9vpLANlLxA
Date: Wed, 6 Sep 2023 10:15:32 +0000
Message-ID: <PH7PR12MB87964F07B5777097DD715B99B0EFA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20230906101204.2177-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230906101204.2177-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6dd7082d-7f6a-4e51-bcf1-adf53f69b2f9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-06T10:15:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MN2PR12MB4304:EE_
x-ms-office365-filtering-correlation-id: 2c9ee201-d9ca-488d-3ad9-08dbaec23441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zi0iZcShpF78K9LAfLs85ZCStQpuN4HLl/rJDBchwsGw3tf7dAf+/9aVU3hZZvxUd3XHMCPSL9WonvYdOByO30lbb0t8ZOZAReDVoVU7T0cZLTHb0W9QG1yOuZm16yE2Ic26AwPe7298iiXFsqLzCPd5phkSVnHkb/TkMKo0YzoZw2Hr6QPumuwIGFFlpExrTdmml9UX3S6kYX2nmb3tsu7dNaMZciBK93AgTm2crGgeAnGmcoH+sIhpRGw0mnZZ5HKDS4J6Atwv8IWp70L262QAce/NA1PLOB68bmNzWy12wrXYIbYsomZmKM2NHrm0CONsCFnM3NIuR3dajif6gt9dwKoi7reJ7haIMy4V7YYKi/egQ/pxKDQEDiQmfVbkdsr/enE39o373zsbX2vip5/diOZcR3sWVSsl0ffbRByBhXQb2tOGlE7JXLoNK4VdoWvYPJPEVUbnWQgPZJxtmsz3t/a6h1RHjDn3LlF0EYMxiayX7xG37hEQXw3oXSc8eH22qO16bVhNtj063J8Et68Dqpgb1TNsJsSfhUIcSIZBccrPF0MPlQaeS8eDKHhmTe8xZmV5BjVpLP2b+qNaLv+oU+z1gaUhBvkoa3kpz2YrG3kq8WDjNc4j2Lsqy6z0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(136003)(39860400002)(1800799009)(186009)(451199024)(66476007)(6636002)(64756008)(316002)(66446008)(122000001)(33656002)(71200400001)(86362001)(110136005)(76116006)(66946007)(66556008)(2906002)(52536014)(41300700001)(8676002)(4326008)(8936002)(5660300002)(55016003)(38100700002)(38070700005)(478600001)(53546011)(9686003)(26005)(6506007)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I8A1DimisGzawNPJg/THQ/JgB4BjFlkDItm5JnQfTo9h2Gpk9bVuKiIjIQTz?=
 =?us-ascii?Q?i58NBG0Y0FFZ6xB8B3abf8vIoS2xpoAUOGMmgycosCUTO7+hbFkZWkTa/tlS?=
 =?us-ascii?Q?Rny/wwhYihTE8QWDCrAChhV4fGa7BpbfgiTxU7ivkxBrwQZITakDwFYSOdOn?=
 =?us-ascii?Q?NJ75Xu6RrjyJGWnR2hxhLHKLfbgw7pLWRFd4A2adt/5qUOzWCXzvU2w6K+kn?=
 =?us-ascii?Q?+j6u4OynuI4wKIjCmnaSm3yQkNSeMHenwbZ+JFrIqrn+ybhnntBQpRsxGLMs?=
 =?us-ascii?Q?9Gcv/OZB27K1lgXSO6GXxfAiRPkT4TUtRFJK1OIVfPZJkMTjW6d2J1iCTp2X?=
 =?us-ascii?Q?lx8eevnTo6xVx8BnZWK0WSFD1PjBW6Rjnxndil3oZnHz4celMH1gIfFefu0q?=
 =?us-ascii?Q?gLvrmG4SafTSB3jkvFwE3vX9Giho8k+duRk/Mwx8OwDE4+tpwsLAmnT36rQl?=
 =?us-ascii?Q?qT30+xY9bors1WQdg8WbeRqwF2yCRjw7snEDYA6vUHylH9Bo8d5DTGoqMWgQ?=
 =?us-ascii?Q?7fLiM1deEkcBYm8QC3UBw9L9DjD5TTlcj8rwxh36ao39iv0h4Q5YyQnc669/?=
 =?us-ascii?Q?RVZPaAhs4eQWLZ7k8WioZMQ1MHRmHmPDrWHFf5MyF/jVSaugXVakFBqkiea9?=
 =?us-ascii?Q?/wTjSHhmN9JwVehThWEvGm6A46XANVmL8Oclw29ZFFEzhmQSCMpl/E9lqF8z?=
 =?us-ascii?Q?eFGsHGBpj8+X0mwSu/Cj3PNcXBarH/o6ryMkwyAWN+W8BCL4SWVzB+0PMIeh?=
 =?us-ascii?Q?dfU1jqR0opMBXIi6TNOYE8f7x5tGblUkO92G44qkdLVsFyX1kFBxCqnXafwr?=
 =?us-ascii?Q?ecnXMGKehBUNf+6Y6uccgABBhSRbkd8PmXS4v+ytK7Ubo8RduyFZTmtCVDL9?=
 =?us-ascii?Q?xAOOvMgKBxusE9gX36UkSMaLVyDuXpIyRAuZtRLYUq2lUbL7mPLc9tjLldnx?=
 =?us-ascii?Q?Qsay8TbhvT+IU3Xy/hMab5x/+YyEm0RjsKhts7fetcvrPGuk1EWb3mqKuNz9?=
 =?us-ascii?Q?l2GYHcAAkmS/o6dDzzxf74joBVl1x4Cwhs1s50PDTEtUOwhTpDKk/Y9EGz2a?=
 =?us-ascii?Q?6R8JpyVUq6MKwxe8qAhlDXETnZPjwJOccoBD7FKPJ99Q5hcPt64E0bsUcEpA?=
 =?us-ascii?Q?bBVvFg2wUiaFQxxe5IU33+EWSUiLtah0z63dgg3qsD9xN1/edJ9AEceFAvEj?=
 =?us-ascii?Q?g4YB1y9s6CjwOx4ONJ46as6KldrZ2NVA5m7P8KwS61kqtIlknTRGuEvryKAK?=
 =?us-ascii?Q?mphiYcaHmgH6C8yEWinu6NtmjRlJAJkWvOKodBYPAyiCHsyOFuiM1IcZllVG?=
 =?us-ascii?Q?/umFb+CZOPMK5vfX9Zo01uwB3Ka483lyBxaTV4Pst4Z/D8un1pqCbSCvUByp?=
 =?us-ascii?Q?C0oV/gex7GkiQd6T0L6Mnlw1LpBNr4xDTJg1c2waehhIofViHPeV2o64b1Tp?=
 =?us-ascii?Q?vvebM5QNEaOVWNzbYYT34DQyuWtVXWrABL3Hud0PyoA3xvuGUFi9GeLD9cly?=
 =?us-ascii?Q?+oda+Iem9ml2vhLMfNP6I2GaVjvoUlSOSNJ6Mg08ltHGAwd5kG5GkXJegMQO?=
 =?us-ascii?Q?iF/2VA4CRsd0vCJUxxM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9ee201-d9ca-488d-3ad9-08dbaec23441
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 10:15:32.6389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oIUQSOI13WLowsKLtwX4Z4AAxaLAURrLe13zkkYkCaQUyNh0FUiooLB6NCTkwjtO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawkin=
g
> Zhang
> Sent: Wednesday, September 6, 2023 6:12 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Correct se_num and reg_inst for gfx v9_4_3 r=
as
> counters
>
> gfx_v9_4_3_ue|ce_reg_list is an array per gfx core instance correct the s=
ettings of
> se_num and reg_inst for some of gfx ras counters so all the available reg=
ister
> instances can be polled for ras status.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 40 ++++++++++++-------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 0a26a00074a6..a60d1a8405d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3653,19 +3653,19 @@ static const struct amdgpu_gfx_ras_reg_entry
> gfx_v9_4_3_ce_reg_list[] =3D {
>           AMDGPU_GFX_GC_CANE_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSPI_CE_ERR_STATUS_LO,
> regSPI_CE_ERR_STATUS_HI),
>           1, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SPI"},
> -         AMDGPU_GFX_SPI_MEM, 8},
> +         AMDGPU_GFX_SPI_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP0_CE_ERR_STATUS_LO,
> regSP0_CE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SP0"},
> -         AMDGPU_GFX_SP_MEM, 1},
> +         AMDGPU_GFX_SP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP1_CE_ERR_STATUS_LO,
> regSP1_CE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SP1"},
> -         AMDGPU_GFX_SP_MEM, 1},
> +         AMDGPU_GFX_SP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQ_CE_ERR_STATUS_LO,
> regSQ_CE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SQ"},
> -         AMDGPU_GFX_SQ_MEM, 8},
> +         AMDGPU_GFX_SQ_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQC_CE_EDC_LO,
> regSQC_CE_EDC_HI),
>           5, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SQC"},
> -         AMDGPU_GFX_SQC_MEM, 8},
> +         AMDGPU_GFX_SQC_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCX_CE_ERR_STATUS_LO,
> regTCX_CE_ERR_STATUS_HI),
>           2, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCX"},
>           AMDGPU_GFX_TCX_MEM, 1},
> @@ -3674,22 +3674,22 @@ static const struct amdgpu_gfx_ras_reg_entry
> gfx_v9_4_3_ce_reg_list[] =3D {
>           AMDGPU_GFX_TCC_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTA_CE_EDC_LO,
> regTA_CE_EDC_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TA"},
> -         AMDGPU_GFX_TA_MEM, 8},
> +         AMDGPU_GFX_TA_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCI_CE_EDC_LO_REG,
> regTCI_CE_EDC_HI_REG),
> -         31, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
> +         27, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID),
> +"TCI"},
>           AMDGPU_GFX_TCI_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCP_CE_EDC_LO_REG,
> regTCP_CE_EDC_HI_REG),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCP"},
> -         AMDGPU_GFX_TCP_MEM, 8},
> +         AMDGPU_GFX_TCP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTD_CE_EDC_LO,
> regTD_CE_EDC_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TD"},
> -         AMDGPU_GFX_TD_MEM, 8},
> +         AMDGPU_GFX_TD_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regGCEA_CE_ERR_STATUS_LO,
> regGCEA_CE_ERR_STATUS_HI),
>           16, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "GCEA"},
>           AMDGPU_GFX_GCEA_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regLDS_CE_ERR_STATUS_LO,
> regLDS_CE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "LDS"},
> -         AMDGPU_GFX_LDS_MEM, 1},
> +         AMDGPU_GFX_LDS_MEM, 4},
>  };
>
>  static const struct amdgpu_gfx_ras_reg_entry gfx_v9_4_3_ue_reg_list[] =
=3D { @@
> -3713,19 +3713,19 @@ static const struct amdgpu_gfx_ras_reg_entry
> gfx_v9_4_3_ue_reg_list[] =3D {
>           AMDGPU_GFX_GC_CANE_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSPI_UE_ERR_STATUS_LO,
> regSPI_UE_ERR_STATUS_HI),
>           1, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SPI"},
> -         AMDGPU_GFX_SPI_MEM, 8},
> +         AMDGPU_GFX_SPI_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP0_UE_ERR_STATUS_LO,
> regSP0_UE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SP0"},
> -         AMDGPU_GFX_SP_MEM, 1},
> +         AMDGPU_GFX_SP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSP1_UE_ERR_STATUS_LO,
> regSP1_UE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SP1"},
> -         AMDGPU_GFX_SP_MEM, 1},
> +         AMDGPU_GFX_SP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQ_UE_ERR_STATUS_LO,
> regSQ_UE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SQ"},
> -         AMDGPU_GFX_SQ_MEM, 8},
> +         AMDGPU_GFX_SQ_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regSQC_UE_EDC_LO,
> regSQC_UE_EDC_HI),
>           5, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "SQC"},
> -         AMDGPU_GFX_SQC_MEM, 8},
> +         AMDGPU_GFX_SQC_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCX_UE_ERR_STATUS_LO,
> regTCX_UE_ERR_STATUS_HI),
>           2, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCX"},
>           AMDGPU_GFX_TCX_MEM, 1},
> @@ -3734,16 +3734,16 @@ static const struct amdgpu_gfx_ras_reg_entry
> gfx_v9_4_3_ue_reg_list[] =3D {
>           AMDGPU_GFX_TCC_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTA_UE_EDC_LO,
> regTA_UE_EDC_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TA"},
> -         AMDGPU_GFX_TA_MEM, 8},
> +         AMDGPU_GFX_TA_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCI_UE_EDC_LO_REG,
> regTCI_UE_EDC_HI_REG),
> -         31, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCI"},
> +         27, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID),
> +"TCI"},
>           AMDGPU_GFX_TCI_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCP_UE_EDC_LO_REG,
> regTCP_UE_EDC_HI_REG),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCP"},
> -         AMDGPU_GFX_TCP_MEM, 8},
> +         AMDGPU_GFX_TCP_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTD_UE_EDC_LO,
> regTD_UE_EDC_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TD"},
> -         AMDGPU_GFX_TD_MEM, 8},
> +         AMDGPU_GFX_TD_MEM, 4},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regTCA_UE_ERR_STATUS_LO,
> regTCA_UE_ERR_STATUS_HI),
>           2, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "TCA"},
>           AMDGPU_GFX_TCA_MEM, 1},
> @@ -3752,7 +3752,7 @@ static const struct amdgpu_gfx_ras_reg_entry
> gfx_v9_4_3_ue_reg_list[] =3D {
>           AMDGPU_GFX_GCEA_MEM, 1},
>       {{AMDGPU_RAS_REG_ENTRY(GC, 0, regLDS_UE_ERR_STATUS_LO,
> regLDS_UE_ERR_STATUS_HI),
>           10, (AMDGPU_RAS_ERR_INFO_VALID |
> AMDGPU_RAS_ERR_STATUS_VALID), "LDS"},
> -         AMDGPU_GFX_LDS_MEM, 1},
> +         AMDGPU_GFX_LDS_MEM, 4},
>  };
>
>  static const struct soc15_reg_entry gfx_v9_4_3_ea_err_status_regs =3D {
> --
> 2.17.1

