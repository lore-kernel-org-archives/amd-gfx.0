Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D90C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 20:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED5710EE06;
	Fri, 10 Feb 2023 20:52:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1241510EE06
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 20:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgM54Bf7g2/Lx49hPiitR05Gu4TmhbDV/aEaEjvx3m9TKFi8cDwF9LzfHOBLkaJ8vLf6ai6NnLAdlzZjNVoYipJwTaUM0f1BG/thCYtwBU1je6J1HumGkZ5m/DLOd/YCH2cGq8W/zvPg1UMmo3hBbkkKd9X359c/JuZEw7kHwa1AgdblzXANvAjVhlf9+esSn2sXKIQgTgtMWQQjxq+qyEvKya64JSAefPYWEDWfGQ+7OkG4xrQkFMr7gfezl3RHyGfMzWVkuM/kZA6+w7TkJiz913O9eUANeAXF/YFsA4V8lzhmwy2HTEp48HyQlOF7FG5bpFP+ccY0TuF5hzz/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO2g7tFxKmK8rLO7q/DS8A5w2JWDNAZjTOA4cRKOMCo=;
 b=n3BU0CPtiZQIs6bs6vtrnpk9GwqoE7vmiBHEOmgeXA17EDf2cmg4nYbjpvM6l6Tq5VD8i3TtoQ7q1d649d0nHzqnF77XhwjPDn02cMg8g56M2/CTWGEYtZt007jk15MxIThDLFsYY/ll9A3LlkvutrOqYOAxEj3oPdT6fqqbcX7q7bwyBAqzE1REe2APheC8gonHq8muRdeT2fauL2w5Eqz2kFp3Cb+/EoD0qNqG/IqS0U7a/QfzW19ypz6ILIwCw3uYppmr+Cv0d1XY7karUmtCXoX94bir5uWq+mwqQJRmVeFj4l7qtjHMZ1h55shLbf7NevgiHlKnB6KICDy/Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO2g7tFxKmK8rLO7q/DS8A5w2JWDNAZjTOA4cRKOMCo=;
 b=CnTt15/Nlhxrk/fC69c8TdMnLL03Tb5M1TsllG0paLD1p0gCXxazYtXBz1IKKh4AwqCHTu4DC//U0S1mN9NjDscIDepr/6LcfJPws65HqQkOvvXRrse7KiIP/+4D2V3AmjeodCbOgKNt3FjhH61XEC6QKQdmxFc4qZ4RKghpAB4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Fri, 10 Feb
 2023 20:52:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6086.017; Fri, 10 Feb 2023
 20:52:10 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Topic: [PATCH] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Index: AQHZPZDm1jxfAhQ++EqGaQRsr3s8Ya7Ip7AA
Date: Fri, 10 Feb 2023 20:52:10 +0000
Message-ID: <MN0PR12MB61014260AD82A2E180D7663AE2DE9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230210204716.12849-1-mario.limonciello@amd.com>
In-Reply-To: <20230210204716.12849-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-10T20:52:08Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9f24a7c3-7065-43cd-8d1a-dbe140d54eb6;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-10T20:52:08Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b61bfe65-6d42-4236-9a69-4fe69e11eb26
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB8727:EE_
x-ms-office365-filtering-correlation-id: 1d0693cf-909a-467b-b72a-08db0ba8adc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nHxlANlAMH5suX8gtqXDifrNPDt1SLhhYSfpTFSporwGRLgJjR4Wqw6drGivfTJSgN+FqYYYs19tYZp5DOFRWCdNv2P3NyYWtbBkFq5a+MPoBxpgI6JQJRUCUfylifg/N4CXxoQz/q8DG1ooJqY/L3tQ9JlTy3vKWVdHGxZHFtM3pag8F8ozbmW6W3cY2uIQUbVVUlDziVYO7qDek7cZqUzojJfS8VmmNC7lwSbwEdO31QgDZL6Q5W1h0sWZhi4O6hDAGYW68Sf2tJE8fwd7QY9KNE0Snjm8rFk7ZzXZnaBySxPwoVL1rruj5tt4TlYxdWZGx4BA0A5L/9ET77JVCAwXY7ORfj8IbIY8az1ZzflC6Wot9UO4NK8O3cz7glm15vJOM8MNPkSZfs0n+MeEd7MUm8lgYYJpljyY8vkv04L8T2Qx827eM2tJWuMeRVcDs0FckULQeDxu8TCbJppQTT84rKmbMRQU/fJgnp70+8UTZVm89F9lV+GArC9DOh8W7dqr5bgaZK98d+fuQM5li/MDgFKnvdNaUtKcet+6O8tieCoaQoSMnvEB1m8pGTEfL+zMwaOP1QMcAjjyN4QkOz3gF/txXVkbVAk9zxXHNYAskGPr6bEmswIsQbx9LmmI0vblr4t7NKuFSBe7OLYgX1LFLbcmqwQaU2I9CvYPBiyPzhpnLsglB+V+Duu0KrJpvmY+B621izmdI2gc/6vjPVZl9CV0XR0Q0P1ceAcwBa8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(2906002)(38100700002)(86362001)(122000001)(26005)(71200400001)(33656002)(186003)(7696005)(6506007)(53546011)(9686003)(55016003)(38070700005)(66556008)(66476007)(64756008)(76116006)(66446008)(8676002)(66946007)(83380400001)(41300700001)(4326008)(478600001)(6916009)(316002)(52536014)(8936002)(5660300002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/QID7K0IXavrFpZJqb0aKaKKeL33hd79EBBpxzgiz626wvKfttNQnbMBKxoG?=
 =?us-ascii?Q?hJaqnDsfFRLnreSUci/11BWuJFpEM7jh2Rb9ksSSQbeHH7e1MeZHkVFVQ80p?=
 =?us-ascii?Q?3/YyWQSj8cCDysN0KP1YzmKeb/hSsnPOOZjHp+em1UjV4ndHhHpwDSpfoif8?=
 =?us-ascii?Q?DgNxPhrewQQ0AteOra+zGBAD1YIQ+fTYSWYl2V6k5KH3ZQWRKzLf4bMF0OP/?=
 =?us-ascii?Q?6McCR4E9WTe01hU2mylxtYIkojHKyR8YBeo4tsmW8G46dwJ5FXAFA3lcnh75?=
 =?us-ascii?Q?JM/dk93Jhl3iGUZLIQ9a9FiusnTOhgabFlq2b0cKfO6viQgUtIIyN+DYeVMT?=
 =?us-ascii?Q?R/MafIYIF7O1unUOmwyjA4saV4wpOfK4fi3V2bYO7wspsUx8yUOrdeOrR99K?=
 =?us-ascii?Q?g1otZMd+80oBn1Uba9mW9d9wSyXg/gVV4he9GnAll9RadJRtaWi3eLETQLLq?=
 =?us-ascii?Q?hr5QcVVHcUPyGwR6xSq0gAFu0IWVjaZX1rUtCYnfnELDrEES67bG8/LtcOR8?=
 =?us-ascii?Q?KJA7BD5/MLxov80qcsX2kipv85OWbtIvqsEMWRQj7iu26yTj7DQ4+C2MsMXI?=
 =?us-ascii?Q?dTKwx2bpd3T/SwKpZE4CeKkKLU4FWWPM0Kv/bx2urjEXfsUp/twjJdPFbb/h?=
 =?us-ascii?Q?9GZ4wn7ionRmC390iki7nYcNxTVaG9NiLSA1ancm2EYyHbaWWkgpavzzCiLp?=
 =?us-ascii?Q?fxbQpwnJF+xty+dgvn70b1djhNwfwPBHeP+pdtIjmRd+79kWeQjK7n9z/Mns?=
 =?us-ascii?Q?9UhYGRfd+YZTfyOZBcKwXHqxF9ZGQBD3bmcpQMfkOHkeQHeORmiIQBSpBhIB?=
 =?us-ascii?Q?tN4p+0ZHTVEo/nViQinrB+AAb9uCX/KGQLn8vvMhxuQBSswtPjRrmlxAWpJw?=
 =?us-ascii?Q?TJePflgk+W6j+ompZfK+c7yxCnaGMVEiXELd1aH7lmk9WWh1oE2TcXctjWLO?=
 =?us-ascii?Q?xI5SBL8udzZnXggujKjVLoz6SgNVXY19+ZzzWMfSMCnPRsZobESoni2k+7eE?=
 =?us-ascii?Q?IiLsWaY8G756vRrKvzTDqV2TV2kfcnB8rxH9U8ZKNAPH/ih6V/xQ7TDpdOmN?=
 =?us-ascii?Q?WA7xPnNyvUJWBEvQG9zv2UR0YV0AWMCn+9UeAUOUU3RE7VuZlpORR2zAABtA?=
 =?us-ascii?Q?8/m8V+lvWUQd/im9oCQCJq7lSAIFbPYFbDLMVKV/8QaSxR7+/GvvuzAga/sv?=
 =?us-ascii?Q?wxvAXpzD+CVQR2SJaYk4WYKcRhxNA87yVWrlqOcHOIDkgMWtvJvQcRc8rPYb?=
 =?us-ascii?Q?1XzXVSN4WKrMmyamo4bVHe0GaeK22Ksr+2JgLacZMjVjHxkvA36/WVAs5JBM?=
 =?us-ascii?Q?FLEOxLNF282ifj4Icbs6klCvjppknpr+SObi6q+Us4eueVrqxtKNS6FDd4Ng?=
 =?us-ascii?Q?l/fT9Ni2fH2pSkn2zCnEk6FdS9BSuNVHZYeirMiFUktxnTUqaGm3DsNNGzIg?=
 =?us-ascii?Q?b56LuAJufqjm4fmV9pQY32CCVwGoKobCBzPCpTp0gdkxpLbIZBYa3+qdUp/U?=
 =?us-ascii?Q?9q/ld3RVaJVQm7scMm7fT1vW8sVzKVFzP07QeJIEqiYsZ9FrgVCz2VBa5qBE?=
 =?us-ascii?Q?D5NgL0fwyZvapI/ib6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0693cf-909a-467b-b72a-08db0ba8adc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 20:52:10.0662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7FGKIaAN1jWHwVD7fmLqGxFquXJRDoju8BhQ1a+diNU0v7th18cQJ+fkp2b5xS/OMePPUyaJ0IPlGh88mH0OGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, February 10, 2023 14:47
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amd: Don't allow s0ix on APUs older than Raven
>=20
> APUs before Raven didn't support s0ix.  As we just relieved some
> of the safety checks for s0ix to improve power consumption on
> APUs that support it but that are missing BIOS support a new
> blind spot was introduced that a user could "try" to run s0ix.
>=20
> Plug this hole so that if users try to run s0ix on anything older
> than Raven it will just skip suspend of the GPU.
>=20
> Fixes: cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 5 ++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index fa7375b97fd47..25e902077caf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1073,6 +1073,9 @@ bool amdgpu_acpi_is_s0ix_active(struct
> amdgpu_device *adev)
>  	    (pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE))
>  		return false;
>=20
> +	if (adev->asic_type < CHIP_RAVEN)
> +		return false;
> +
>  	/*
>  	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is
> generally
>  	 * risky to do any special firmware-related preparations for entering
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6c2fe50b528e0..98f8d9873cd84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2414,7 +2414,7 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>=20
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix =3D true;
> -	else
> +	else if (amdgpu_acpi_is_s3_active(adev))
>  		adev->in_s3 =3D true;

Relooking at this, I wonder if it actually needs this too:


 	if (!adev->in_s0ix && !adev->in_s3)
 		return 0;


>  	return amdgpu_device_suspend(drm_dev, true);
>  }
> @@ -2436,6 +2436,9 @@ static int amdgpu_pmops_resume(struct device
> *dev)
>  	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>  	int r;
>=20
> +	if (!adev->in_s0ix && !adev->in_s3)
> +		return 0;
> +
>  	/* Avoids registers access if device is physically gone */
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access =3D true;
> --
> 2.25.1
