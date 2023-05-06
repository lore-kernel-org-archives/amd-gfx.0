Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFE6C77B7F
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 09:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B188410E21A;
	Sat,  6 May 2023 09:52:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 251E810E21A
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 09:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1XRRUwLZ4k6JWjefP5fbYHqBFXDq+lHVJEQcZ+UKBEbwiYYzjSGdIRVN4tZioa+bTKBcQfLOym78Jk/REP/GMc3GZBuRpVDBDxroGL+PlGPp2mNRHkKEAUHYtv0aHBJPgIjZbnnZkh1a93u3M2bM2hLGMuFn/qB3NPXN+xm+ozlahc1QCmLm9isZ8BCquhma4YH8SQlLtCPpdrsA/vpnCn9bWpL44T9qBMUCmVbR5QW9lc7x1Ryc6mYJXIFsOV4y0u9o4gNKZKakP4Tybql8xxWNP1W4jC1jw+uknowamB5syoCeRlbQdNwh8XehhOmrpVV638FEbtKGgEckUCFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z5ba809qfJ7RI8GhCFPsRG8GIw+ca2GevRs0VM6K24=;
 b=Ty7ScoagQfORvyJZ57a5RdYmlZMft/yi99PVJkWnoxTSqr0gtQJZBHc17lzsUc4N3answFJdCEPUW6QZ+ha6gp1pn5pm23C9pTLxRsy032kshnAEwHga3lmGICDAEq/yvKeTNXocyo3o7vMcjlaLEBSgzAwzo2n9UtyCQwyQRIJWeBrwFdjp0j5aO/bWIoudasjEGOJ7dUei2clnYhouHoI9iwnpytko37pUWw5kkLTuGOGoD0Zb04x2YpAUbFniCWSpASrG6CmXEil7zvFGA96SPAxJywBEmLYZqp3bUtqLzdw2UDomf4Dcu9JjG5xd2JtnnhsoXCEIz0MB5xVTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z5ba809qfJ7RI8GhCFPsRG8GIw+ca2GevRs0VM6K24=;
 b=AsgLMd1IxFI4HEldi/lYuJC/Z5nxueQnGRq8inQKkkLA0E9L+B8uIa5ytGsb/t0fnJsDpUfMdZRzr/v/xcM4zJn+ZRUOifLXMl8k1hDF4XkXtYemHowgiELaisaqaKmNTzj5s9dIUhbcjK52DLhHOFmIReAfDpbgvQ3OgwrMRIE=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 09:52:22 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::91e5:bbae:9e9f:7663%4]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 09:52:22 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Thread-Topic: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
 enabled in suspend
Thread-Index: AQHZf/myfnpngdR6Wk6fFGIKsP4TS69NAOLA
Date: Sat, 6 May 2023 09:52:22 +0000
Message-ID: <DM5PR12MB17702BFBFA2955D80F30BEDDB0739@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20230506090336.1879435-1-guchun.chen@amd.com>
In-Reply-To: <20230506090336.1879435-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-06T09:52:07Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=365d624a-aa4d-4706-8638-eec0176683ce;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-05-06T09:52:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3bbecb4d-d002-41a8-a7d7-4fd43738658d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1770:EE_|CY5PR12MB6153:EE_
x-ms-office365-filtering-correlation-id: 43e0ebb7-0417-4dbe-b12d-08db4e1796ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dY9xpWrs+Lc96hlh7SdL0mJG5Oao1UeDsBrBoeroV46kKLqEDfETflSon31WbIhr67TMzwN6YHMB5gT051i2wJDTVzfvdJzvqhrgI/zCpdVEl82dNK+0PyzcERgloNDQ0ggz250Q1KAej/dZ/7S/EzdVqJWdYydX9b1lEBHHCcGC9dF0dfmcx4DnR8b2WI/tAG5lx7ja6pHZB1aXfk65b0S5B/AcdDReXjmRcDpQi/awFJg7L5tXHe/bEzQ7x4ZoRyZWB7TE0H6ahpIW2UGjLmSEYq/VQOt9+k62Rwf5av3V9Kas0Bvu6CIj8YRuCvqdPyGJ8FyS7kJXNXhdOyTBVL+SMyzRTd42XSiRHMc9Nyf5AqGHGK4JSUgAK6s65rODerxV8F7XJ8TRGr4/iTWLG6Sy4ABFDj/yolOCL/JBE49vJoSAM7s/QjKl0WKRsvfYd85v+gOdmeDtnM4wQopu+SsaI4vFz4/Yhb+mCFkDxKeLr9M3ciVazEYz9e8lYwJCPOj30faWhrfA68IuOZjIgHn9K0a+9owOXPikWRQl2cXJixM3UfKKUxZNuJMLPdcWToc+HcHKo9Kqu7IRX29JhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(52536014)(110136005)(5660300002)(8936002)(41300700001)(8676002)(2906002)(66556008)(66476007)(64756008)(66446008)(6636002)(15650500001)(76116006)(66946007)(478600001)(316002)(7696005)(71200400001)(966005)(83380400001)(53546011)(33656002)(6506007)(9686003)(26005)(55016003)(86362001)(38070700005)(186003)(122000001)(921005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?e1i+ZWOcBvNVPir3dVk4A9lX1YRR2Hpa/mjznGTOoD6CFUNndD7T7n7CaA1x?=
 =?us-ascii?Q?yDGYuHfKFgMnPciQepTASJ8xaL62cEmNnz4WZAdy1CUlUKO33rWNYOEOh8Fc?=
 =?us-ascii?Q?oSXIh4u1l96f+RUjsF9D0wv8bS1Qc4bHq8u2F71EaT/0KSX0hhV3ytiZ293P?=
 =?us-ascii?Q?Mr5oaPinvearCHCvE+truyFDF4ZEUsJVTZMGB+uVAfkTHBavodR2SVMGdfOA?=
 =?us-ascii?Q?hA8YS/IYCyIz9zBuyZD0PsM2hw1rmLlJPSSRXSI71XtQ1jQX6cb0q7apgVj4?=
 =?us-ascii?Q?0pSeIE0oq4X8DyC5mriPEQmD7tNbQnpt0OYkshcXV7w9o1PNwjf4y5MtkHiv?=
 =?us-ascii?Q?UqIB+eCZdG4kilA22z6VT9Pt5RibAwPUqkakZlbwAEC2Paq3LEedEkpaeYPm?=
 =?us-ascii?Q?HszK0+bODSlrpPjrFd/g5Pu4pUHbne22WkAOVgqPpn/lparqIHKoambtIIQY?=
 =?us-ascii?Q?HWuRa3rqRf4vDbnvRfAG90VerQvbac4KjDYQIlAKq9zJRc4F2QQ2vbgKUpln?=
 =?us-ascii?Q?fDdJvgnfQF47Rsxrjr/iGRJ0tepg/ePengvDNcMykxcl1ODsv27m3lwlKY9b?=
 =?us-ascii?Q?prPOacnoru56KHsNFRPRkyROCNLuw8nDj6lDCElY88OLeSip3p2tB5i/Bdng?=
 =?us-ascii?Q?sfYkSlGigyQI9jNMQBV4vHFdvH+bm2dicCzyocR8/PmHZiQEz21OmoyTeB0y?=
 =?us-ascii?Q?w7OhQRZ0772Vp/uCyyn59Iy2XXLX91evNT1qMZQGgu8tjm0Xld9cQ99FJSA5?=
 =?us-ascii?Q?hRdmUVdRBWEeSLxLjdyYlIyx02RKuSIk+3lhB8KrseyN3x85BVpRtiKicbSB?=
 =?us-ascii?Q?zvEoCbDz6dWQc7NxSfXA4m0aIoRMqp1pemTwSKso/TYKDYBemqyTP/N5SboL?=
 =?us-ascii?Q?9N/qycGCqwk2y3hE/GilmEjH9xRt5nSKWQ0gQcdC3kx4cBMFmYUlHozscE/d?=
 =?us-ascii?Q?nUm/eRBeoWZqj33S/BC54ESzsS7Yg636iQRWQZCLZyL5JmbXdpAalaAibhIV?=
 =?us-ascii?Q?cTYb794LaDJa5+cPEqUVpWAtUDlM/lzPzWpI/vcS32ZVw11gv0TsaX2NeWwp?=
 =?us-ascii?Q?+gYSAVfUzvnPy09KaiMsA2NfJzH1c19IBGhH0OYp4iU7+TnxUpv9WCNO+Mnd?=
 =?us-ascii?Q?WWbSkl0iSOzEreELxTUhNzCrGfmilFQlQpwIa6gPhuR8Cmbtrfd0IXFmLUWT?=
 =?us-ascii?Q?n7JU+61IWvaenc9W2OTppNcGZ/yFIEftxydf68wfhvmfUtoD+liHtOFQQ4tG?=
 =?us-ascii?Q?Kp5EMp5jJMaPgG5v6kKIpRHnwxIF6wDfJoJhydYmVz86SHyFzo2v+RwKpfCZ?=
 =?us-ascii?Q?JWXLrGROa8zA64m2tTHPEZPN9vj7Ei9LwZEn1TMt488SfCMBJ/Lkm68Hnu2Y?=
 =?us-ascii?Q?svI/o7t3cS71VbWgAzB7kqmWjP+6dTmYmQv9xEqIWBcT9daxT0CAggWSzG/5?=
 =?us-ascii?Q?F23zHfjmRy7dSCXKMn03jVDhm8igpZdCiJsUTDTJMVvh2wbUnEw0sZ5pGMeA?=
 =?us-ascii?Q?fbnXP9GWX8PQt/EAocobEx+ptfGLkdnW97S9rfzCpe19U1PX+8nvyiz/wJOx?=
 =?us-ascii?Q?xGvoZXWEfhnXOGg6viM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e0ebb7-0417-4dbe-b12d-08db4e1796ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2023 09:52:22.4325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8/GP8NWCeEtvW2pJ03mW/16wiixMk1nzVYP1tJYoiWV0LubVn+3sq8Dj5B5OR7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
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

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Saturday, May 6, 2023 5:04 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;
> Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Koenig,
> Christian <Christian.Koenig@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: disable sdma ecc irq only when sdma RAS is
> enabled in suspend
>=20
> sdma_v4_0_ip is shared on a few asics, but in sdma_v4_0_hw_fini, driver
> unconditionally disables ecc_irq which is only enabled on those asics ena=
bling
> sdma ecc. This will introduce a warning in suspend cycle on those chips w=
ith
> sdma ip v4.0, while without sdma ecc. So this patch correct this.
>=20
> [ 7283.166354] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu] [ 7283.167001]
> RSP: 0018:ffff9a5fc3967d08 EFLAGS: 00010246 [ 7283.167019] RAX:
> ffff98d88afd3770 RBX: 0000000000000001 RCX: 0000000000000000
> [ 7283.167023] RDX: 0000000000000000 RSI: ffff98d89da30390 RDI:
> ffff98d89da20000 [ 7283.167025] RBP: ffff98d89da20000 R08:
> 0000000000036838 R09: 0000000000000006 [ 7283.167028] R10:
> ffffd5764243c008 R11: 0000000000000000 R12: ffff98d89da30390
> [ 7283.167030] R13: ffff98d89da38978 R14: ffffffff999ae15a R15:
> ffff98d880130105 [ 7283.167032] FS:  0000000000000000(0000)
> GS:ffff98d996f00000(0000) knlGS:0000000000000000 [ 7283.167036] CS:  0010
> DS: 0000 ES: 0000 CR0: 0000000080050033 [ 7283.167039] CR2:
> 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
> [ 7283.167041] Call Trace:
> [ 7283.167046]  <TASK>
> [ 7283.167048]  sdma_v4_0_hw_fini+0x38/0xa0 [amdgpu] [ 7283.167704]
> amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu] [ 7283.168296]
> amdgpu_device_suspend+0x103/0x180 [amdgpu] [ 7283.168875]
> amdgpu_pmops_freeze+0x21/0x60 [amdgpu] [ 7283.169464]
> pci_pm_freeze+0x54/0xc0
>=20
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index b5affba22156..8b8ddf050266 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1903,9 +1903,11 @@ static int sdma_v4_0_hw_fini(void *handle)
>  		return 0;
>  	}
>=20
> -	for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -		amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> -			       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__SDMA)) {
> +		for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +			amdgpu_irq_put(adev, &adev->sdma.ecc_irq,
> +				       AMDGPU_SDMA_IRQ_INSTANCE0 + i);
> +		}
>  	}
>=20
>  	sdma_v4_0_ctx_switch_enable(adev, false);
> --
> 2.25.1
