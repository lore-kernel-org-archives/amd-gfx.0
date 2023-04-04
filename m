Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03389C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 13:42:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 755F910E333;
	Tue,  4 Apr 2023 13:42:50 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1909810E333
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 13:42:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ar5P6oqLkeprShhxglgjB4oL28oWB7wSjlbpufRSyQ01g25XqRoqq3gqos/9JLR/2YkWy69CkVZuRdJ+gUR5BKiffnXsTk8HZUxahUcbShuFYYJf7J5FTxvfhONtbUeV9dEe9BpyaP82Ef3D7eQAnd9PiBtD+PWkq31u3XwQ2STCOkHPJCzNenbaDk0PvsSUP4037oX1Ldf+a1MWPTN8CJmwos5ZMbKahiWbekZVIKmEZ+sLXVOYEKOaZ6sT6f4j5rc6ks9BYJerpEYqoCCccDw4BxqWCM1V0tyYlf/vJGgdUM1Yxoc/OabLuSK7VVUBZliK127hneUyYbC5FWJldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EIJVM+7iILw/0mldKOcNT+Grt9ul2dqTcYdgc9DHyhM=;
 b=a4RKD0sxUhsPQPSjHPA8/S0kapa5AmGkD6MrM2/REWWufoJuoQeZvpgOYtvDH9wSBl7x8Z/BVcjiLlZ2sF8yirEgUPEmU/rUNkj1P4DzweDQ7RXtoBs/gsQ3zcKk/c/JV22oW8TDXqYjBvG4icL6DZ4q0DofU8Ode4lPhm3lyLAPu+2AW5OS9V1ZcvJrxhH8ZR4mvdZKhSb78xhMTvug0DZ+p7IvrmWDL+R/hEbueBOLlTdj/YI31k+fS3a50P3vB8FyvGrLQLGoSvaPNDwvgQrA8P10inTYL8ohDZ8ybY0djHwGTpBep+myJvHLpbj1C8uE4Ti67ANPGxnhBxdpMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIJVM+7iILw/0mldKOcNT+Grt9ul2dqTcYdgc9DHyhM=;
 b=RDVwrwWWB6X9YF8u61BYWa/TK3/ZXIN83JBnki1sN7+ISlR3LQ+KW/3q0WWSwXJGjQADA53V7jpKBD/mx0ex23+JXelHt2qGviFXhPf/9XBO3z5HBXjKrAa7tGLvFo8+7qZXG5J2C23gnIg6QbHQAJjbyJ7dcWk4+UOgFghjoXM=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Tue, 4 Apr 2023 13:42:45 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7e79:1de2:ff31:c84d]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::7e79:1de2:ff31:c84d%10]) with mapi id 15.20.6254.034; Tue, 4 Apr 2023
 13:42:45 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Topic: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
 CP_HQD_HQ_STATUS0[29]
Thread-Index: AQHZZmbDMgCQFoG2gkmfKNBRkxRed68bKFWA
Date: Tue, 4 Apr 2023 13:42:45 +0000
Message-ID: <DM5PR12MB13084ED911E1EC100F8FC09B85939@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20230403195839.80419-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-04T13:42:44Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=026a012f-27c0-4c82-a800-014acc888986;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|CY8PR12MB7171:EE_
x-ms-office365-filtering-correlation-id: 8655bce3-4cdf-4273-fe63-08db351278f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dRz3JJbCvV3oXfNgxeoInNtAeqPGP6TXagW1Nuti4RpZvrFnCf5c8SBztnnVXeTYfZTFtDJOTZ75swkOofR3f9yqlLVshsKSqyPPStCRTzkPcE2GrpJDUYFDQrF2Zc1TU8iV2M3Wv5QCdZSmoX70qPVlfcmsaIiP5F//xPYtSmx0I7ixV8zkx2j+FGYtB3709toGgmZxBkEVNMmk3psuL5aMfqL1TWonm4VCwKKUqbKs9Mip7QC86VpZDsJbjJWc04lqR+k6m9BTGzyjDSC4VP9dk2JgHUbCMValHroHPhbiHFr9+YZx3X6WLgPC97a0mezWTUC2+1BI0fdMnd5/xm5r8m5GNbWEESRa4CM8Z462mpjujtdB9oj6T8lSQJ4tQH1qzJXy2ll9VwUQnCqVsIVoyP7psScvVyag2VDUkZsPosCO95D6yHUHZwHF4bIhgbpbMjZY6wqbc+XcS+Kz09hzI4uB3hWX+BMNc5up5e3hgBNtNKAcRIpQrQIv0d+5SaNMCpSNUmjwPlNsdLAsPh4E5ppXqVA05K/ZHdQvaf1ia8OQcSRi/14lc1fm2Iwwv1VowGteIuzin499xoKmU+A8/2f6AZGkf0HJOJmZrR100rLIe7a2ung8sWhALnf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(9686003)(26005)(6506007)(53546011)(186003)(66476007)(33656002)(478600001)(316002)(110136005)(71200400001)(5660300002)(7696005)(8936002)(2906002)(38070700005)(66946007)(52536014)(4326008)(66556008)(76116006)(86362001)(8676002)(38100700002)(66446008)(64756008)(122000001)(41300700001)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4XDRhGaqngC4uBQxk61gTWMSK6Mg/9CXW4+cTgBCo4KeXWaT1bhxS5ixxdUc?=
 =?us-ascii?Q?fGOS+Es7CaURRykOaVJSXCeKkfGepBDg5kqlKz9LEoMyKuLNF4vBoDToLaAE?=
 =?us-ascii?Q?h9uVgLAU8F7G58rBYBEt37PgtMV5Ew4mZyLf4Z/NFT9zJU+gkI58lEpHsF+y?=
 =?us-ascii?Q?j7Qxp7YSa+m3sNX0wW7m0gfnNR7PaZ/Jj/OmJCajMyimfoiNpY6G8aWeb+4j?=
 =?us-ascii?Q?5IjgcdVxKBnu1Lek7VKk6fEUoTaDcSMyYoJz5hNfZy4F9nTWFRiRVpYyG/0d?=
 =?us-ascii?Q?0tq0Z7C5zmD018+7yryzY74GEV3fnsltEg7XhThJorLIzepOWDZur1Z7PQ5G?=
 =?us-ascii?Q?AQxXd/OeSgGYF0AjRrZwGm+F04WW7TvDv8lpJcKlTSGoprgPo83+3JO+uLPx?=
 =?us-ascii?Q?I73BeCgw9a1U2yXvJ6gnM/NdZwWCKusueivfJefBH3h99KjM9zPkk47y+zdP?=
 =?us-ascii?Q?3ncvKJs8qTa9pgIzicJp5ilNy5vqhRHu24s+8IJzuzR2L7bSz91GMk+/Bx8N?=
 =?us-ascii?Q?RXwnwgPncfTqOL8YWT0Hiks6zgkN4HQ4Lg00vkVBrel0uOyqrXBN9sBmfKU8?=
 =?us-ascii?Q?HVg++meZBZlG1dM8ZsY9y0+3PKPNvm50hpN5IEMFhLxmkqbzSvkCzmhE0wlx?=
 =?us-ascii?Q?hOqD3dc71VZDKPWUhKSZR4p3Q2raV+NH4lCux3uiG3FNQZ5dA4RAxb21O30U?=
 =?us-ascii?Q?hCuwl1SNU2iYy+ALeMfLWQ51JUS3gvOmODDCMgsxYqEOao+91tWOyNlElX1A?=
 =?us-ascii?Q?r4PGImtETAHR1t/1jksgvFDHXO+64VLAIRtgIMGJKUrr4mqbp/mnrw5j5rZw?=
 =?us-ascii?Q?KxsBEgRphMOxwRuWx7lqO5xHYp/jBwv8mF+aVLChFZP1C5VHgOt4QNcOWthe?=
 =?us-ascii?Q?E6sYIxqAK2xYnpDJ1mwAmh8PciddZbzhUc9OQWVSsZdWPhQlHH92ijVY/3nw?=
 =?us-ascii?Q?EIhvwcXhOmq/Rg8v9QKNbX/PKqMUVjixw6ovaipLGoRHcMQm3j5zCP6c/TkG?=
 =?us-ascii?Q?W5sAajd5sFTknkLNA/qHMgMWgLJn+EiEYigpofIGC30eui7JgD4Ap62rZk+7?=
 =?us-ascii?Q?lMWvtPLDJxi6JJV30Zt7XeJptqytH8ktSx4NNs/gbYul7AtRgUZgJ+utlvUS?=
 =?us-ascii?Q?Ukj/coKbZhoeI6iy9FtT/+hdpbogXUe/cnXv6s4rb0/Ym/cq+xAZtgW/h7cn?=
 =?us-ascii?Q?XxxpTyrpAAORUNrYQnntR/w/G+YV7wP9ICGYfXi79nLOoeIL9R3BZUk8kgkh?=
 =?us-ascii?Q?/DKmXBLHofANj2/Y+6KDKCKDG89cUE4zn8oPkyyrd5O9/vAUTKju39eN1/Cd?=
 =?us-ascii?Q?mpJssL1GdD5jrQ3VpGo+SZvUwPjiKKW8s7XEbC9oppHsH3VqGiq1IF2nAwEf?=
 =?us-ascii?Q?irpyVLw/3wRxTgc3x1stlFSR4oIgMnFdCJQaKEhTyxSRhgvLJSTsvSnhK79f?=
 =?us-ascii?Q?zGihUh6erv1saHfCN7nrY/DrFRb+81uO6PKI/h3Y53Jm3jWLs0tLY7ytHLZ8?=
 =?us-ascii?Q?FDb6CXWozTwMRUspMUqZKWRcIm0vGGE40cEV1uPu3t1/TbB+VrFqRmRQwT5m?=
 =?us-ascii?Q?DnjwDCU5T+4nH8ZN2XA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8655bce3-4cdf-4273-fe63-08db351278f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2023 13:42:45.7732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Yf/LmXsbHTuPqoIOPAV/u10OTbsN6v+Ukum75HE7D1YBZGH6d2JKPenyui+f0wEkh/YUSbVq4pFtxLtCkrOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
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
Cc: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Comments inline

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Sreekant Somasekharan
> Sent: Monday, April 3, 2023 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
> Subject: [PATCH] drm/amdkfd: On GFX11 check PCIe atomics support and set
> CP_HQD_HQ_STATUS0[29]
>=20
> On GFX11, CP_HQD_HQ_STATUS0[29] bit will be used by CPFW to acknowledge
> whether PCIe atomics are supported. The default value of this bit is set
> to 0. Driver will check whether PCIe atomics are supported and set the
> bit to 1 if supported. This will force CPFW to use real atomic ops.
> If the bit is not set, CPFW will default to read/modify/write using the
> firmware itself.
>=20
> This is applicable only to RS64 based GFX11 with MEC FW greater than or
> equal to 509. If MEC FW is less than 509, PCIe atomics needs to be
> supported, else it will skip the device.
>=20
> This commit also involves moving amdgpu_amdkfd_device_probe() function
> call after per-IP early_init loop in amdgpu_device_ip_early_init()
> function so as to check for RS64 enabled device.
>=20
> Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 11 +++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c |  9 +++++++++
>  3 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7116119ed038..b3a754ca0923 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2150,7 +2150,6 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>  		adev->has_pr3 =3D parent ? pci_pr3_present(parent) : false;
>  	}
>=20
> -	amdgpu_amdkfd_device_probe(adev);
>=20
>  	adev->pm.pp_feature =3D amdgpu_pp_feature_mask;
>  	if (amdgpu_sriov_vf(adev) || sched_policy =3D=3D
> KFD_SCHED_POLICY_NO_HWS)
> @@ -2206,6 +2205,7 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
>  	if (!total)
>  		return -ENODEV;
>=20
> +	amdgpu_amdkfd_device_probe(adev);
>  	adev->cg_flags &=3D amdgpu_cg_mask;
>  	adev->pg_flags &=3D amdgpu_pg_mask;
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 521dfa88aad8..64a295a35d37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -204,6 +204,17 @@ static void kfd_device_info_init(struct kfd_dev *kfd=
,
>  			/* Navi1x+ */
>  			if (gc_version >=3D IP_VERSION(10, 1, 1))
>  				kfd->device_info.needs_pci_atomics =3D true;
> +		} else if (gc_version < IP_VERSION(12, 0, 0)) {


What if we get a GFX9 with MEC v509? Wouldn't that trigger this too? Wonder=
ing if this should be
if (gc_version>=3DIP_VERSION(11,0,0) && gc_version < IP_VERSION(12,0,0))
thus ensuring it's only GFX11. Or maybe there is some better check than tha=
t. Either way, checking that it's < GFX11 might false-positive on GFX10- to=
o, so we should probably be explicit in our GFX check that it's only GFX11.

 Kent

> +			/* On GFX11 running on RS64, MEC FW version must be
> greater than
> +			 * or equal to version 509 to support acknowledging
> whether
> +			 * PCIe atomics are supported. Before MEC version 509,
> PCIe
> +			 * atomics are required. After that, the FW's use of
> atomics
> +			 * is controlled by CP_HQD_HQ_STATUS0[29].
> +			 * This will fail on GFX11 when PCIe atomics are not
> supported
> +			 * and MEC FW version < 509 for RS64 based CPFW.
> +			 */
> +			kfd->device_info.needs_pci_atomics =3D true;
> +			kfd->device_info.no_atomic_fw_version =3D kfd->adev-
> >gfx.rs64_enable ? 509 : 0;
>  		}
>  	} else {
>  		kfd->device_info.doorbell_size =3D 4;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 4a9af800b1f1..c5ea594abbf6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -143,6 +143,15 @@ static void init_mqd(struct mqd_manager *mm, void
> **mqd,
>  			1 << CP_HQD_QUANTUM__QUANTUM_SCALE__SHIFT
> |
>  			1 <<
> CP_HQD_QUANTUM__QUANTUM_DURATION__SHIFT;
>=20
> +	/*
> +	 * If PCIe atomics are supported, set CP_HQD_HQ_STATUS0[29] =3D=3D 1
> +	 * to force CPFW to use atomics. This is supported only on MEC FW
> +	 * version >=3D 509 and on RS64 based CPFW only. On previous versions,
> +	 * platforms running on GFX11 must support atomics else will skip the
> device.
> +	 */
> +	if (amdgpu_amdkfd_have_atomics_support((mm->dev->adev)))
> +		m->cp_hqd_hq_status0 |=3D 1 << 29;
> +
>  	if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
>  		m->cp_hqd_aql_control =3D
>  			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> --
> 2.25.1
