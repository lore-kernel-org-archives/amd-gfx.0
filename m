Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98944C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 07:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB866E953;
	Wed,  8 Dec 2021 07:21:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BDB6E953
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 07:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLuvhuzzsEZoZwBXOXHbveobmFJh5pXGk4JPqFk5NPAlaI6w5X7zWAQ0Xy1gekKctfxQI9pGCRuZiQlENiupF768PSVMeOklkG0jZ6xxYPYbPV1Vm6QXjmTgeFxSbSVzrXNV9ej+wOaROSe2kz8tOfaH7inuRDFuYkKkz/Jgh3fU7RzaxHa4KdIQuX47LnKODW+gZo1kRWeghkwOCFd1bmsLUXK3pvD6RzlLWDmZW0rdT+iMhwy3NM8u5F0M43cUN8sjfZ7iqvkM0dfVv/+Zinhorg4BC1GZ6q+TSI/aj/IzrPzdIlLmCjm3lvB82HGDwGkWksbe2uACg1EWcaaWoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcaL66EtMBqbqQxf1nreC875ZsVYM1DAeJB20LjlZT8=;
 b=oIVDkBSfpWs8Kfd4buOKCHrEUxRAZ1/YSyoqL8MEvoTULw5A92nu80TAajAFGMmY+9t0OgxwMzDqmG9tkx6+uAs+9eIQ6o8LgoOYwxdTqDDwtZ426edS+8yM5Ivw5nykE3HDmuhk4P0mthS9twrPPegP3dwgP17Bfiyv28Zcw8z7PTWw2biRj/Q0oRn5yvSrNwPZRWvYFSUvbdJoXzH+t8L6fC+jEMwdifRboJxn+3btSrAZ9Y98qgNVxg7V6mjNQhpaPjbRFJCqtmQOtRsQwSXvYj2OqdZGH0fJUSFLNr+cnlnzPXXofSYMgezNQ7F0PUUcGDOEYM3Uv20jFcdgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcaL66EtMBqbqQxf1nreC875ZsVYM1DAeJB20LjlZT8=;
 b=dprVcA4TADXy5MUify0MlqVSAHxZjsrb5SZSPmxwpFZHg3WCZ4sFhSNLzeizQ/ITjrYgBCs7w/e5BP3TFnlVoC/B9Go3RftOI0cRwfI6QXDZM8vCLiFuf5YqIFGHGjE7kFDBiWGiAwYQJeJ8tYH9h8pYeOB30IRi/Hz6FVzv9b4=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 07:21:42 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::d434:e9b4:307c:2819%7]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 07:21:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Topic: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is connected
 to CPU
Thread-Index: AQHX6/u0S/eOFbjuB0OeyYE4MsqhX6woJryAgAAIlKA=
Date: Wed, 8 Dec 2021 07:21:42 +0000
Message-ID: <DM6PR12MB46508B6BF369315A31BD9B08B06F9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20211208062020.6445-1-tao.zhou1@amd.com>
 <PH0PR12MB5451A2FD1BB367183E3EBA78986F9@PH0PR12MB5451.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5451A2FD1BB367183E3EBA78986F9@PH0PR12MB5451.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-08T06:46:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c138d4a8-7fbe-4039-a37f-118cf9372bb5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-08T07:21:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 1454342d-7e36-43dc-bd8a-024837e04d17
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5b9fe9f-4c1e-4699-9279-08d9ba1b6221
x-ms-traffictypediagnostic: DM6PR12MB3244:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3244455A1F51282F866B7E0EB06F9@DM6PR12MB3244.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6V97viVSBlYKTqMQWnxa68VkkZAegAuJIpiuYRXBf9V0G6OZOEbrTzlhAujrtxDpzt7hrM3uL11g3jrsv9BDVKvFQaA+Zz6zFEvVzjPPGqxYlY+AOItjf4HkTkOr+3zWpaaEjT7TVSF4nqU9VwTnJTn1ePsuBHRVg1SmIiOBItdpBQETQbop42Cphz9u3NZoVc+bYQtwaNUwiXJP0rsimPgMzqO/IzhzmjpT+QvmxEvJwy34WhIBU6o9s1pStWOs02bzcIKclk+Cs1DtuyDGkZGVDezzZgu/jRlMR4EfRTRx7ttzSJG8XxPlBoqIjnDxiHu32AJ1vv5D8A+LzzATtMd1cs3Vt0J9MwavYjx8rn891fglj6AKtY3D20IxnTvpq4mtuivCC0pLLal6ieUySXGMYcb+H0xt2pfTXdFaSz5QOPzTqLuuTT51MGRHNPix5GXv79AYVcyFn3MIqBJ6AaikCNul9/aWA3gs38LHdhbKnJSi0ZN8BcXydxTf58CQnbV+UEsX5G5xlreFS6ukJMrmnHwFChqZtYSDcPeW5WEjQtvqqtKeBr4XwO8mEzErh6Mnx+9EVPPpAw9Y0vBH0VU5KoWPDSdQgeC1gqv6xaQa2nuyocZ1UrP7BIt85i96a0bVZ9IvbVFQ8tliIdGskoz6eYLUUVsB3pLE0AUbQ8RwJaHB6/aP7zj/PX4MnWyTE9YWckQ+2nOWqumussFD2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(55016003)(38070700005)(71200400001)(8676002)(52536014)(8936002)(110136005)(26005)(9686003)(7696005)(6636002)(186003)(33656002)(6506007)(86362001)(316002)(66476007)(66446008)(66556008)(64756008)(53546011)(508600001)(2906002)(66946007)(5660300002)(38100700002)(122000001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q3h1tRi8DK9HQHdbDxkUNC1joDlz+Az0jNR6tElyRIbK1NVwQq25nAYvB0zF?=
 =?us-ascii?Q?du7ZqPDow+6myS4FkIOX/0b+Zinv90hKLWG57Z2wrjYF8/84LR8soh0LvMyl?=
 =?us-ascii?Q?yWjkn7BXrFXc4I6tOOpwLDW4VfMxPVas/UudWUZrfLYvnQolGma1lK3bWCt4?=
 =?us-ascii?Q?70pq9qrOGrhmPME8Pd6Q5Bx1iCVSeZHLcIGAplSs4wfRZHd9TODFwSdsADFq?=
 =?us-ascii?Q?k9DgopsmpD6CJYFoUxCmMet5r/j/EMhJTQXwn9SyrCUyqu+wYIbkOKf9rCcM?=
 =?us-ascii?Q?zajMyVwdH8n9v4WOOPjeq/QeHB+cJdOTVqTcuykDOs+pKa3BOyzHZlYfKNBT?=
 =?us-ascii?Q?9sMSrFRLff6WlFhOL18mUCH4gFN6jE6vPBNlJCCeT76hNZaSKsnzvesdX/qF?=
 =?us-ascii?Q?elZkrgHgQrk1aOWUPpDT1KYlUXYQW4uKiCNDLY2HFOEQ2HZUwKxMV/v1OwWY?=
 =?us-ascii?Q?z3Y1P8NDzGFxyQhlCDAKQAXGpaZVYd8dHoRnwn27tlRCWwjA5JhTztIe7SnG?=
 =?us-ascii?Q?QuhRasVlMxRK6ctUX3XYhTs9bqkTxU/ULTbzXc8n9lXdlv++Mr2Wgxw7H/9D?=
 =?us-ascii?Q?UdZYEjDGjzyxITWM2Seb82Eh1UGdt3FsK0M5D/6mmgYrgAxMiVP85uT27RgB?=
 =?us-ascii?Q?jJ+HP3qZpreux1q12UcqNzmW/Ekv/H8sqN+4D1GhHDOywLceLlbEp93aGXxJ?=
 =?us-ascii?Q?qXsTwmVYwcFs+iVdWhM4aq8ML8C50nasXhjOR9GIS2GPL9Iidq3Q811KVyxc?=
 =?us-ascii?Q?Emj/dpoCLDuKjSxYO7gLM9OJcRHGiFtFYi8iPn8luxgD3ZLO/JBZCVFQo71D?=
 =?us-ascii?Q?bhmQm0QFVoKGG/snkDAAAE/ggXdI+1IjSnMC4zS4/loqXXkg9kkXZm+775Nf?=
 =?us-ascii?Q?o6FK4a1PZIXPH12j6DfYoB9PSyIuMFPu7/eHnbQ1WY3VMclhkL9ttVazLt7h?=
 =?us-ascii?Q?YqcKO4qURlD46O+H6DOn5ldhz5hHu2RgjDIPfln+WCtVpIwTpF+b6uKfg+1X?=
 =?us-ascii?Q?NR4ORxnMhjd/JoGpjpqlb4cGJPq/+6Mx0xcoeV1OMUhNXQ+otd/KTVn4MHY8?=
 =?us-ascii?Q?7TRvN/zRNh0rWFEC6pHmCYBWiT1YoO60Q2F777oEpYRaHz9PJs39q18I+v3j?=
 =?us-ascii?Q?L9jMs+lUMNaSKN61nEjXo9s/m/mQjcPEsOMrjeiFuz8ywLJWKWCq/8+qag5w?=
 =?us-ascii?Q?QrH/bAdd3YgGs1SKBAfaKq00VJmAw/b+T6WN//mYcihAsiTU/jQGPfYbgPca?=
 =?us-ascii?Q?5/u0Yny0DxEVfJADK4TNFLnbGxeP4RwVtl58R5p4fyy/E/TQcqNu1l9Rs7OT?=
 =?us-ascii?Q?Bv9e8AAEeA4upp0o9/nlZcKQH3Wq6DiCRYd8h/LMQ5j32yOSKS9LGGT7aa7f?=
 =?us-ascii?Q?lkV8+cD7ms3892cmKAwHbAz6gqQ/4niQ0aH/Kj3Mff+/dx50pkqgPXtkCTNo?=
 =?us-ascii?Q?jrafWet0W9D0ZQXaEWDf2Q/g+hyJ8xeXgP+8ip2avZvd8f4mw4CPcrRMmsO9?=
 =?us-ascii?Q?dYfrEqIeLWNmN3vclJCFuxPXjlR0n9yx6rq7fE2bI/0lVjvEM00PEj12f9sK?=
 =?us-ascii?Q?hklM+VfFNQ4tMn0eJHs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b9fe9f-4c1e-4699-9279-08d9ba1b6221
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 07:21:42.2346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzeraRaVcknAhBUL0TjwALQ+RbiNdwCK9j2+iag1zGZOHbwbq9CddbQ2n7/WDHPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3244
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



> -----Original Message-----
> From: Ziya, Mohammad zafar <Mohammadzafar.Ziya@amd.com>
> Sent: Wednesday, December 8, 2021 2:47 PM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
> Hawking <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
> connected to CPU
>=20
> [AMD Official Use Only]
>=20
>=20
>=20
> >-----Original Message-----
> >From: Zhou1, Tao <Tao.Zhou1@amd.com>
> >Sent: Wednesday, December 8, 2021 11:50 AM
> >To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> ><Hawking.Zhang@amd.com>; Ziya, Mohammad zafar
> ><Mohammadzafar.Ziya@amd.com>
> >Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> >Subject: [PATCH] drm/amdgpu: enable RAS poison flag when GPU is
> >connected to CPU
> >
> >The RAS poison mode is enabled by default on the platform.
> >
> >Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> >---
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
> > 1 file changed, 5 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >index a95d200adff9..0003f2c64da8 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> >@@ -2372,7 +2372,11 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
> > 	}
> >
> > 	/* Init poison supported flag, the default value is false */
> >-	if (adev->df.funcs &&
> >+	if (adev->gmc.xgmi.connected_to_cpu) {
>=20
> Why not considering PCIe interface connected device by default? PCIe inte=
rface
> connected device will not see this issue?

[Tao] What do you mean by "PCIe interface connected device"?
I think the else if path can handle other platforms and the default value o=
f poison_supported is false on other systems.

>=20
> >+		/* enabled by default when GPU is connected to CPU */
> >+		con->poison_supported =3D true;
> >+	}
> >+	else if (adev->df.funcs &&
> > 	    adev->df.funcs->query_ras_poison_mode &&
> > 	    adev->umc.ras_funcs &&
> > 	    adev->umc.ras_funcs->query_ras_poison_mode) {
> >--
> >2.17.1
