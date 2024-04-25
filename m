Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A56C4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 08:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF0D10FD0C;
	Thu, 25 Apr 2024 08:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xmzf979";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A045B10FD0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 08:30:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjGvzOA33eVlent4hmPOnelfLsFkfcLFCxsLVI3LIXfz13u3VeU9EE8egYS8vPuMJvc1715FIAHMSzaoW+3M1SRszaSoReV7id/ogj9i2jccmL1Gtihr7g+FSqm6k9FkGN/AqWhSTrNT6cp9hiY4QKjse2ubgtcgYHNfnjQBIK2551rf8OCHj6PNPdll3gIv43vHwEj399HMnG0KrC0/qRlQAIhPRLFfPI3Afs9d8bACGPbW9UHDMSBslkoihLoiZ9fCOqHLQeWoce+G2HSCUe6KnetgbjfsrkBwEybFUFKIopsg2EC84IVUMAExujVCEMxQCFrZX55lqpqlwcbCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEkFPY3qPi1q2H5yPRK7G58cYqNFQk9o4cobm0e+cRc=;
 b=TjVrGUn6frmgFg079KR4eMfRgIW0jYfKKqFOKj6XIKrJpJh5KdrX0J5k10l4ok687kkCVf+tNsW19EltwPzSY5JloSDRZa+c2ushN0AoS6OTcQlUlyee9IehJ84bT5G5KxXDTcs6dDnCaAqj+Z0TuXJsXx2LZOkTYeUGgmwlIYCE8fqaXQ40ZlkV7dx44CjolHaJIV8XhFkNXqCc0v7tD2m9P15j9hPjpbIkAXuHlsMb8h9WPs5a01YKQt1LU+RoJjewSPwg5EnJGL9sS1mOf+cE222qjwjUErxpcF62pKq5UB8Omco4YLB2uoVcTltLFUhBTPFSzpUC30l1Tdua4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEkFPY3qPi1q2H5yPRK7G58cYqNFQk9o4cobm0e+cRc=;
 b=1xmzf979w1AtQxVf2LEZPVfLM/aksKzq+8mvIp31CqF+mtZqO6moaH3WL9LnudliB7/0E9QbAmg0SReCq0zG4CVT8R0iWNIYSDKp1z6M7J7zAYq7Az7tdbmfPci60nylv1MZoqj2YZEDW+cGG+tSXIg/YxpxAcF10uK1stDQx1s=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB5868.namprd12.prod.outlook.com (2603:10b6:8:67::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:30:45 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 08:30:44 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times during
 ras ISR
Thread-Topic: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times
 during ras ISR
Thread-Index: AQHalVgDZODd5+9W0E2EOKd5ButWl7F4qqCQ
Date: Thu, 25 Apr 2024 08:30:44 +0000
Message-ID: <PH7PR12MB8796EEF4F9900F1A89B85275B0172@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240423082640.3273762-1-kevinyang.wang@amd.com>
 <20240423082640.3273762-4-kevinyang.wang@amd.com>
In-Reply-To: <20240423082640.3273762-4-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df544d6a-82bb-4fc4-a6a9-c286ca8696dc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T08:29:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB5868:EE_
x-ms-office365-filtering-correlation-id: a59c7420-7409-49d3-630c-08dc65020044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?qdgDVSZwdBmZSONZih3XeVT2Q74VTo3b3WL7hwfZxdA1GHUHUa4GyXa2+9lV?=
 =?us-ascii?Q?ABaEyfuddHmz3nq6m5wIXpwdXOFBXgAeiZDwABodHzq3OeKpiVH10PfQ9WQE?=
 =?us-ascii?Q?m5Na4pZwgw4KJCA3gL8c4UUJaV51/pnFVRxtJk8kijKRWe4J476sJAQLnwRQ?=
 =?us-ascii?Q?9u6siawlFkKrrnVqWJbXAUaZRNN3i4gUVOXJYfMh+M3e22Lyxl72kOspF6/c?=
 =?us-ascii?Q?wP2Ou2sCwQljmNnbtvkEvOLoU0nF5JeKVuxElYh+PzfyuBqJf0gRAcfWBNn5?=
 =?us-ascii?Q?wLmxtTcW8bqRjlgvIw7ppUaSZjr0pwRwzAJ285I1qBZbPmPFwKb1n/FtRAgZ?=
 =?us-ascii?Q?kvyBn9M/li+y0Ou5yfzXehrdfLDiO5SqnxJsl5bbG/PRGgZC+mbXX8KzRujG?=
 =?us-ascii?Q?TujArpZG+/cAd3mocap+tSwqKABVjYyxggS4Cn3bZ6bbtimw0lLmJDLyT9Hs?=
 =?us-ascii?Q?VxVfzEGtmroFGCso1tGLf016j3Yej1yL2LHcZuBNYhOppxbasqvLv5iClShS?=
 =?us-ascii?Q?zRlbcDElrnYUmuOXDX12yuGfA9fSI0F9FfvMsT7D3DYkRsMsqwomec8ozbza?=
 =?us-ascii?Q?RYE7zVA8KK3DOvX8MMAxPdeN1kY8VEwi/LWhWPco+1TZmEMT/x5xZrlFkznj?=
 =?us-ascii?Q?lpFMvmrJvNAbMHCN8OdFN4PVnk3q+DJFFuCWbzkSnJ/W0YMAOswEVVDwotNR?=
 =?us-ascii?Q?fZ5o5Pp2oGuEL6RF2j+EYxVmqZU4cTpMIAJVUR2vHcW+SrApS70ZE+dtXbI7?=
 =?us-ascii?Q?Gk8YWJAq3Uq3JCiSn93+JmeMFgT1d5T42tmVnVA75SrnpZCDm8MgrgcvDgve?=
 =?us-ascii?Q?0qi6xyp8KP3oBlKXcTTCgJNUEiTYsTH0RQvs8cXUK8wjvOb1A+Av62h5ryJL?=
 =?us-ascii?Q?JbEerle1/krSx+Q+9pAicgn2Wfglu9Y/i2gYl13Y5SbutkP2ShmOOoiVlWLW?=
 =?us-ascii?Q?PKIh3yLB08OdiIyHBjjtIT8GoY5vhEfFLqXfGzglLjRx20hGuF+cbLxtG5EM?=
 =?us-ascii?Q?ZpjzHYmw8Torp9gg0dr2KcB9U8Qm7PuSaykuinxa0sMVa6F3k1XzrpINOIUT?=
 =?us-ascii?Q?P55T/0ZdapqbA5wZEDZ72Tuix/X7FA9Fg98BUhT6ozvbBYnQygbOWFwOkQWs?=
 =?us-ascii?Q?kVO6iFlmsLkEH+2RFSu3xmnn7xBe6Ep7qdsvrXMMx8+PSTxWxMctzVRKSGg7?=
 =?us-ascii?Q?gm/bI/K3O0/FSEOE/VBam5ZZ5QFKkgWMLATNBvUAhvf4JX9wIx/VCDu1DCEV?=
 =?us-ascii?Q?5T+pmXBfyjOBOMTpicxJQD74Lpc0sZ5FqYb4tvS2DkBCQLYUOyTOHzC+E1VZ?=
 =?us-ascii?Q?/KFq3GrzQ0bNBt7L6iUfQGpkAfVMxxCSTw76HyK90sSaBg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+rfGAdbxeJXpBApZbcYJ3agbayj+R4SFB+b89lZIQmjFdDJJSZIHE/fpjwST?=
 =?us-ascii?Q?9ol5DJxeZSuMmqouHNattmHdONP95GqK9qRds95ggQNXHemk6vfKGDSaGvM4?=
 =?us-ascii?Q?KYDno0u8tlgeCwDhvubTvWDW087Ow3LOsNAjTkpzaiFAIG60jyS8UpPVKDa3?=
 =?us-ascii?Q?tqu/xBeZaDloLoksy2Y+fwBvOwO+jSsX05OtmuketpFaFtD3hIAgsWlIWhZL?=
 =?us-ascii?Q?lVDc73Cq6u7OWNGLlMtIWzpIo4U/KopC/7W1aq7f2uwsk9N1I1OtfHarFUx1?=
 =?us-ascii?Q?7/X2tQKutpqUdRZIRGkgdlOZNcsoXP+h6P4Q05dP/s5eYBfTZxuS22T3ctcm?=
 =?us-ascii?Q?Oh0IYi8IykoCHlkwbrgIdSwGthQ5WdtzvnPFzWilpVnkt/r98DOhRtSLCZSZ?=
 =?us-ascii?Q?YMgCQ0PWaN3s7a10sd70KxOO8FBoddGBLWlIuo1phZHtyK9q6L68q29SQHju?=
 =?us-ascii?Q?iPGwCSt9LidfEHy7vhb+HC5TXgMYiuKnVvOunxOwaMlWUVmQimSrMgnNtEE0?=
 =?us-ascii?Q?gjhENTFCwa2gGAPzI0WfrQZv+10EK6HcvaxyO1QSnfkfZouoX5dOcZXPVHHW?=
 =?us-ascii?Q?QWJBf/afqKjg8UeMK86HMKN/14gd+YkX9Wgl9E2dIYZpb3trxxwkndpHivmd?=
 =?us-ascii?Q?ij3R/myVS+G32/0NCgW9MIqr20MuYxq3LE0FF6wqEq9iDolfIo0cHcOW+4Dz?=
 =?us-ascii?Q?/DA3dcaIh6jkg0oX+QGX3NogLXJ4KVR4ClGxl9v9+ZskhfsbpVEvWcs7291Q?=
 =?us-ascii?Q?GeGc9bd8R1J05J21ySSTjcWn+zVx1f/WBzfjE2OE/CaYqGTt2xiOvnfnXuCv?=
 =?us-ascii?Q?H9RtoUUKj++3j10ovsqkWghnBoqIX7X2bW5pEqjXoNwzj9YScXuJZgq7IqB+?=
 =?us-ascii?Q?NsKsSuqJo7SCr0AN8uCt6vdr0FiWCEbXcPmorMi9DlwusWi5jRxzGjEG1xoP?=
 =?us-ascii?Q?Z3ZKDgQWlhWs/tDx2+vSJHAecwvxWTeBhMCdUB/6gRLz0OQUcB0+FeuT8l9S?=
 =?us-ascii?Q?kDObzjkN+S+AEPYhgEFPjb3iahAUiZbqAd3dkGi/JfYvasLAR159eo+VTnPY?=
 =?us-ascii?Q?m+Ej6zhMJUhCsHr1USwW6jglvqbavK7LbyaH9N4v4JioiEYnaiQImWMzcJLW?=
 =?us-ascii?Q?m2ggt+tX/f7GKkDXs+8G40leBItp5bt56+VTSjLIIuMxLHPmMo4aWkT7TrhS?=
 =?us-ascii?Q?BLONhntuVd1RPWxKwN0/gpe/cj0pbXwBIPuA/sLljRkTp4lfakyuACF3PhPV?=
 =?us-ascii?Q?rGMHp11ws6gA3Xm0deOl/Uf4Nx6eED2nozzHWNfTCSg+ZyI9mDbcQTC4YYDB?=
 =?us-ascii?Q?WhcRmPcrEGSU0c8bGc9JH1xs59ZTyO8xTFHtCuB3sdaEaJxxGVTSxOAAeC13?=
 =?us-ascii?Q?JAewA0PDsLxp+vWa2pONeKhTYYZycTNHeLKIEvDohfpsHnzFDEYwA0ZTK++b?=
 =?us-ascii?Q?axAcGaOPk4325PWleddPk6r2FIQrIFt+6EJQRs5ZP2s/9QPURN80KVPUsRMr?=
 =?us-ascii?Q?u+15f121gU+V+z8eOD7Ho0KpgWUjNxXcCrEZ61HGN5e7N2v5DNJRnvKnBygT?=
 =?us-ascii?Q?nAmvCIfUYqHthEbivuA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59c7420-7409-49d3-630c-08dc65020044
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:30:44.8194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3awTMK2cCviu7HaSW4wv9ZTPhOJveGdOYRKSr64z/liJbvmK/YZVZ1xy0hRsyUj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5868
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

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, April 23, 2024 4:27 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 4/4] drm/amdgpu: avoid dump mca bank log muti times durin=
g
> ras ISR
>
> because the ue valid mca count will only be cleared after gpu reset, so o=
nly dump
> mca log on the first time to get mca bank after receive RAS interrupt.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c | 28
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h |
> 1 +
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 264f56fd4f66..b581523fa8d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -229,6 +229,8 @@ int amdgpu_mca_init(struct amdgpu_device *adev)
>       struct mca_bank_cache *mca_cache;
>       int i;
>
> +     atomic_set(&mca->ue_update_flag, 0);
> +
>       for (i =3D 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
>               mca_cache =3D &mca->mca_caches[i];
>               mutex_init(&mca_cache->lock);
> @@ -244,6 +246,8 @@ void amdgpu_mca_fini(struct amdgpu_device *adev)
>       struct mca_bank_cache *mca_cache;
>       int i;
>
> +     atomic_set(&mca->ue_update_flag, 0);
> +
>       for (i =3D 0; i < ARRAY_SIZE(mca->mca_caches); i++) {
>               mca_cache =3D &mca->mca_caches[i];
>               amdgpu_mca_bank_set_release(&mca_cache->mca_set);
> @@ -325,6 +329,27 @@ static int amdgpu_mca_smu_get_mca_entry(struct
> amdgpu_device *adev, enum amdgpu_
>       return mca_funcs->mca_get_mca_entry(adev, type, idx, entry);  }
>
> +static bool amdgpu_mca_bank_should_update(struct amdgpu_device *adev,
> +enum amdgpu_mca_error_type type) {
> +     struct amdgpu_mca *mca =3D &adev->mca;
> +     bool ret =3D true;
> +
> +     /*
> +      * Because the UE Valid MCA count will only be cleared after reset,
> +      * in order to avoid repeated counting of the error count,
> +      * the aca bank is only updated once during the gpu recovery stage.
> +      */
> +     if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE) {
> +             if (amdgpu_ras_intr_triggered())
> +                     ret =3D atomic_cmpxchg(&mca->ue_update_flag, 0, 1) =
=3D=3D
> 0;
> +             else
> +                     atomic_set(&mca->ue_update_flag, 0);
> +     }
> +
> +     return ret;
> +}
> +
> +

[Tao] redundant line, with this fixed, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>  static int amdgpu_mca_smu_get_mca_set(struct amdgpu_device *adev, enum
> amdgpu_mca_error_type type, struct mca_bank_set *mca_set,
>                                     struct ras_query_context *qctx)  { @@=
 -
> 335,6 +360,9 @@ static int amdgpu_mca_smu_get_mca_set(struct
> amdgpu_device *adev, enum amdgpu_mc
>       if (!mca_set)
>               return -EINVAL;
>
> +     if (!amdgpu_mca_bank_should_update(adev, type))
> +             return 0;
> +
>       ret =3D amdgpu_mca_smu_get_valid_mca_count(adev, type, &count);
>       if (ret)
>               return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> index 9b97cfa28e05..e80323ff90c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.h
> @@ -93,6 +93,7 @@ struct amdgpu_mca {
>       struct amdgpu_mca_ras mpio;
>       const struct amdgpu_mca_smu_funcs *mca_funcs;
>       struct mca_bank_cache mca_caches[AMDGPU_MCA_ERROR_TYPE_DE];
> +     atomic_t ue_update_flag;
>  };
>
>  enum mca_reg_idx {
> --
> 2.34.1

