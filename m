Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701DDC05027
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Jan 2023 02:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE4910E0B9;
	Sat, 21 Jan 2023 02:29:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BEA10E0B9
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Jan 2023 02:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emg1/fV/Ki64fNj7C9X1f9qMVKBSjEIv9m3GQuQbF1VFZMdXWgz+8myNtKDhCfT1ICeGgP5cz/aVbDRjNa1sP4zTCYj6TWXcQRBOCPdVZoKX1uBl19rl1mpR6HMgM1hKCopaVMkX9fWwX6eGfaOAK8keyEoGYPx19wR/9V+sSq5m8RBbcL4VYksdjChj8mesh6Pz8yyHcbDCKcx9qlNV+IEkHfpTqx/9nLaO/Y57JSxAMziPmO0Zi7XuHwxsehTRZwz3IgTZMYjTbBzFoL+h/6eYwOklBPDGSMY4JgBrRQTX96klEm53xFrwEybDGGvdO+zrQMiAyvnT0ZRtq6gpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHJnShAy8woAwOIb3vhTBRo72dk52OxlrAbBiPd3wdI=;
 b=ogtzi9s8MSod0q1rMasJl487nsayb1iYMRgKBJr7Zihbj9yZ15FwJI2ZgK98R673IJ2xBdgV8fhrkHrNFJNIh7sGhczP+V0k36Rr+hdd52Wk14ZvIPD/IkM/j2zaPotChjhfpl+uzNoa5YYfxc4Km9f9xQKfws/nwjSfBIzLPKM0Vr3zaTVmB7UFpEfG/TtXnt4754vFDsNwRuCjczEhyJ4RHCShspCt7bng+CRKfl3rzkVvG+VLXeRxKxfNRsoBr3fMSOf/Q8636nFSXgnq6E/s5qAJnuA1RPkzF+zvNNPL82GVwb/gIFasv6NLSXUgacIGi6zW8RY3hu8vON3vNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHJnShAy8woAwOIb3vhTBRo72dk52OxlrAbBiPd3wdI=;
 b=Q2En9XhD9TKpIsVKsgTb1SdEY5yOQ5xeYl22D+Q8HaGioaUAMmxSPLLr3sZgEXCIdAdoWG5tznq6ZiB9R+DzLDD2jbF2NBEVTee/ULHXYDyCPZNqfnb4MQ1PLjBEccoe1gaIufoENXSGiVGw1LdAokH7NApTh2GeO2Atudjs1YI=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 02:29:04 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::b91c:bc6b:9d14:ccf4]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::b91c:bc6b:9d14:ccf4%6]) with mapi id 15.20.5986.018; Sat, 21 Jan 2023
 02:29:04 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Thread-Topic: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Thread-Index: AQHZLOxnXGDzOZbr+kGUuRmrQaf/r66ngLMAgACkLtA=
Date: Sat, 21 Jan 2023 02:29:04 +0000
Message-ID: <BY5PR12MB38733DABCB0761467650F67FF6CA9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230120162858.1580755-1-tim.huang@amd.com>
 <20230120162858.1580755-2-tim.huang@amd.com>
 <MN0PR12MB61011985AFE482A39D0828CFE2C59@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61011985AFE482A39D0828CFE2C59@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7255148b-4bc8-4143-a207-365f1ace7ceb;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-20T16:35:56Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|DM6PR12MB4233:EE_
x-ms-office365-filtering-correlation-id: 2ebfc6bd-3d9a-4496-e253-08dafb5743ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYP2f+i74eYBA//ZTLkkGSPCsW9p16nW0tNqJSL/7tEdaX78RE68aXpqbZrYGlx52RQEtlF3q2P/cq8BaqQWaFcpz8vmY7Yq/TcoYDb/MgmxBjJG2uv4trzmXVwCoqxXn4almXpyVdJjrKA37vnT70nhMX69N+JsYpL2VuEW8iaUiEyab2hfNueBFce9q0qlZUskjPmGjxvPM2Mfj54yJXWrX/ZXNk13RA/8YAD42cjpGTgv2144YdW/5E2PrMATgBKkyVwfCG12y9OLobDEd4oVNgtzabJbQEQ3Fqs2DrwrDpwM72A9CF9G73u0Bz7i6muxf39i8V64KVKGVD2W8TYSlmYl6jSK9qlhR8WiCTN/3AjtfptILAlDbjHubrnWMejkihlyJEC8ApGqnRLkv4QF2i/9zAGvmwWkfZqoLlH7SfabyUSIk8vqxXfLi9r3P5CJ5hQk8jmlyrQoAJoAtYkbbOVSyvFL6Z8dGWfKvgkXtLqIc+kz6ncMIZllcFhxchiWGosFqkGdRwQkmB/sav12a9ST5kQRleZUIpyRja12GiNTZdJ3BLcqU56gFSzeAY8B8POLqrovs0bofD2oDb5rLh8IIsZ2z89ByI87WPQDSU5zVluN+rHMSwSdV1XNOAwtZ151cBHN4d0MwDTCrfig+mkRnOBBmsD8Kz4kXFLnY1DiBUr39OlFYO5QhTtO4Syj7R5QoJipoPngQYu+AA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(5660300002)(6862004)(8676002)(4326008)(66476007)(53546011)(66446008)(64756008)(316002)(66556008)(6506007)(52536014)(122000001)(41300700001)(71200400001)(6636002)(7696005)(54906003)(38070700005)(8936002)(33656002)(38100700002)(86362001)(2906002)(478600001)(83380400001)(26005)(186003)(9686003)(55016003)(76116006)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ajCX2og2O+LtgziweMzk75ZZll7xyYrbsycrvCb0TXqVZ5lWPQCDpawWC66n?=
 =?us-ascii?Q?JKwsX/JyineHx8suGaipRmmYjBzKIL2Ofree2ty/jne0R8T80byMkYDp6nWu?=
 =?us-ascii?Q?IbKesncuwEF0wQLfnDW7NJIUUyXjMJH7KFgY2/6OU7mvmDrpCRoLV9yEx/ZB?=
 =?us-ascii?Q?xha9WZHCOy6nt+JmrJWMwFw+dAPbybkcPGfpwX4/sVs/dibzsIipwm2KW0pl?=
 =?us-ascii?Q?n8sOqOQMhaxh2P/6uomQCwVgjE2cTyfFXT/tNWmQD3Ges+plM+aGObCxTXHl?=
 =?us-ascii?Q?3yqRAqB/iAv5kr9i1h780xuRqmLA/hzrV9na0nmU6qRtk8BFDoc9wHtAhIv5?=
 =?us-ascii?Q?FivKyean0xmlOtwMt/QSz5GXg74pkvzMUvKRzrZLHl21hyPIooCcxnoG7LZk?=
 =?us-ascii?Q?qAWkuwwVBv8TWpzW6eVEoBRT6iNFrZbgd4dNgI1i+UPeDLeDJ993bfMMQyBg?=
 =?us-ascii?Q?73FISfj7QFYut4U2hcxhD/xXpAGU59h5pyeOWfAxBka4RimJhX8xT7e9UFoq?=
 =?us-ascii?Q?9OR0OYy4NFdhYMkYuP/LRbcLDh6FAcRT1dTXz7b7UwrCfTgcOTA6vhRJnEqC?=
 =?us-ascii?Q?erlTmzTm4mLaRm23KwfwxbXgCIk5B+pe0TMrnRpexIRCCdZkWcDGvOy91z7S?=
 =?us-ascii?Q?w1CPM29BXSWBVyKrQoq9k5BwTbeEcxT/TnlwhHivUDOffSLDbupN29x7eHYQ?=
 =?us-ascii?Q?T6QizhGlkbUuJypFUXQUb2vOh07yYrfo84ldYmRC76MF8gW/Oi8fixwer8j1?=
 =?us-ascii?Q?JzwIJx8awsTSzDH/xnVICWYuDzoFYT6tYR4x6Yt70YZBSm2tTWCymnbkfyVe?=
 =?us-ascii?Q?8me65tIAEnwwVPdvTfSsvMBpJ//kz19TeQ2MokrJ6fosNs1QCol2OjX+3GxD?=
 =?us-ascii?Q?Y6vR17f+S1n1p9iPqiSdGgqATIZ8zwjG72OtofeU6r+/jWHla46Uo3kQGFeU?=
 =?us-ascii?Q?e0m2WUPjAis4jIgseqMXsuLLVuJkByDb0mQiJzdhsIP3sn4lA+b4EiSXsJox?=
 =?us-ascii?Q?niWl3MRGzIqQsKZ6/SVQ1IDavKruZaijjqae6rpXPdBZEL32MATiRXnZy6Tj?=
 =?us-ascii?Q?65+WEdR0rjwtj7J/bVlET4g7m4DBMLvGL7X70yIaRMb4LeljTT+bnPjEi8uX?=
 =?us-ascii?Q?Hti8PdCp5WZfwXj2vy9C284zYWsyxlpk1IXgsCIV+m/wRu+4TLQmN8WY3xUF?=
 =?us-ascii?Q?dhwpN/ttb3QVQ7DtxbSQGPwfk8G5sLkPADnjs2fLzFWTZAZMmeDFE/gfJNB7?=
 =?us-ascii?Q?WfDHLCg9KQZu7KId5JQC6GbvJyVFXxv5dFu3HU5elEvUjIRtJ31Kd1AL+oqD?=
 =?us-ascii?Q?6uGxHVflcG1yzY8HXE2DzCtpxXQQT94vTWK5iRGiuVMN/NJC9n3J5rIQUFu8?=
 =?us-ascii?Q?E/irnxcXTAjgUpFZgdxKIbSaSiqKwm5Hr+UpBvGccA7YwfZlV9Isj4OTenjy?=
 =?us-ascii?Q?lO/S1bqc42TrDKA6TBPi2QIai9phomTQf9u4qE7n4ZnWuuKctb9yjFjd7aoi?=
 =?us-ascii?Q?8UBeCCEav3FQMEgZNcy5rWcPq2eJhfap8826b2hMArecxjM11QqOLuTeLSEN?=
 =?us-ascii?Q?6aLOF5kR2ZFYHMGb13g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebfc6bd-3d9a-4496-e253-08dafb5743ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 02:29:04.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44kwjs6HOzqFIRxO+EcC/2JujA4er78cluqpBmvs5T0biKqYZG8wSAH9l1tEQp4d/LuZBWsZ3uCZ3+eLBdCVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Ma,
 Li" <Li.Ma@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi Mario,

-----Original Message-----
From: Limonciello, Mario <Mario.Limonciello@amd.com>
Sent: Saturday, January 21, 2023 12:36 AM
To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features disablement=
 for SMU 13.0.4/11

[Public]



> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, January 20, 2023 10:29
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li
> <Li.Ma@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH 2/2] drm/amd/pm: drop unneeded dpm features
> disablement for SMU 13.0.4/11
>
> PMFW will handle that properly. Driver involvement may cause some
> unexpected issues.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ec52830dde24..800eb5ad1dcb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1448,6 +1448,8 @@ static int smu_disable_dpms(struct smu_context
> *smu)
>       case IP_VERSION(13, 0, 0):
>       case IP_VERSION(13, 0, 7):
>       case IP_VERSION(13, 0, 10):
> +     case IP_VERSION(13, 0, 4):

> To keep a consistent ordering scheme, I think IP_VERSION(13, 0, 4) should=
 come after IP_VERION(13, 0, 0).

Thanks for point out that, but I will drop this patch and send a new one to=
 apply it only for gpu reset case.

w/ that fixed:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

6.1 is used for IP_VERSION(13, 0, 4), so please also include
Cc: stable@vger.kernel.org #6.1

> +     case IP_VERSION(13, 0, 11):
>               return 0;
>       default:
>               break;
> --
> 2.25.1
