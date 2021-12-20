Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C93AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 02:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7143810E135;
	Mon, 20 Dec 2021 02:09:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D441610E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 02:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUuWUeq6pH21AbMaIt22azhExuVDDwPUhragsvWkil5E7VktFP9vVLkto2I576D8YqiXN5MoOwdBtPfVePt0EjOPgoPNRg1MqTHz6teiVLxkYMa4TbQebQ9DMz1SrqKv3tQyHYtN946MbyWgOi8FUR0Kbd17kSJNhYcEMw2c7Gmwg3w+9cZ0WD5uUmwENbhocJGAgx/UiFVCqhKic/imjEIXXcCkXaqpE6ctdAsUAYRwsCBxrfA/tIwK7EEHDPl4LjlDFaqhM8BcER0XEJNzQ7o/d5hrSl52tdlJ/4xvlASHLSRU/p2Mpqjkeo2k89DtBnU1gTRZT4CbY6COTV0rCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDF6yOBkKytGcTsyHNiHhqtV8VcH62Yh2FUQqAJdzjY=;
 b=Qp+UN9pFIiGRZysx+Z7kdAf4fQEZ9K29DqV5GGzmMLCBdVD5pVFJotTuSQTg3yOGkIwhuFkHCDWd4LQTwLlmQxbAkBZRVS/kCXMlFePdnCzkE3XX9jh8AEk1S06Q23BDCRkQwiIQiWglwiMUF/JQ2bCaBvkxm91fpOAyjDy7qPCfkvW/2H9pEG5AtRXnZR/Be/WMdoEovP2B8lk35qxJ5xkHGLCi5VeDe87NuJRzzpxFQnFL2q1RnDI7NjnYLA/kOeMQo5delFBhoM80pQf0C/LZdZSUH9tzzFeGXw4XFbDFxea6HdBOUFhFqVOS/Z+EvcHg7KgHH8zRo6FfVutngg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDF6yOBkKytGcTsyHNiHhqtV8VcH62Yh2FUQqAJdzjY=;
 b=0FaL4ZGjepafpuqVndKUmyhum0eHsPXnrs0v2hlRh5N//dYAnwGgYShd210Qt5m/bFXGw13Bw7U1/WMw/JtdaHmN863gOvdTFPrr5Q8N/UM+BKin+y8dmRUchj4MQ5RmtrMuhiQjyGqwGzinvUYlM2g1ybGokNT5vNmVe4TLTw8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Mon, 20 Dec 2021 02:09:30 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::a894:300e:5c16:5639%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 02:09:30 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Saye, Sashank" <Sashank.Saye@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Topic: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran passthrough
 for sbr handling
Thread-Index: AQHX83fa+HeHfYXCQEy1th+/Xs5Veqw6pIHQ
Date: Mon, 20 Dec 2021 02:09:30 +0000
Message-ID: <DM6PR12MB2619C48B1AF5300A1859DB8EE47B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211217185616.207927-1-sashank.saye@amd.com>
In-Reply-To: <20211217185616.207927-1-sashank.saye@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-20T02:09:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ce834e11-9109-43b3-a1c4-e44d960f47e2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 850eb09b-c412-47ef-855d-08d9c35dc1f5
x-ms-traffictypediagnostic: DM6PR12MB4220:EE_
x-microsoft-antispam-prvs: <DM6PR12MB42207AC65522E25D56740AB4E47B9@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZFYuaGNk4tbnXNSmFnMhp8JogdaeFj4Ikc70v72n9Bf+Xm8x2vE9z9jZ18JmyJa8bqWU+eElZZcIkjmHEYYbkOVCtUQFHjSK5TNj+iSolDmSm6nXEPHmr1rjjiOpjee00f/vsCRK/LiAr3FtXUWFUAaWdsw53W/MphJZuT+tWITQ2eKDDX+XFNPe3GyTIcTb33oroOuzpJdBUeLZ79dVy1LZE8/yB/za2U6RDXrEd00cRER32bwLuCiQB97qlFL7LIZtOG9bDN1DdoOctim+EeeLJifuPeUPDYVnz2fVjTaNhETzXcHRIk2Jb0P3di0c81PAHt072gp6a367gqfbygFszFkjAfqI7HPxY6AZ79cKLBO2TKxNQYDCbPq8jM2zS8PqpAZffmJc6vubvwCX/0tLJepd2zl0UjS9RysHRTYQmRtd3BGD8yOaNwTUa85RgQhZuOSRwLY726n2qRwk1k2alePuaJ/U4zXo47znqpMPyWFUbLuEqHxPPgrcTpqDiN+EpKzi5z9QTS+tsUT0z9fEgdZpUg+PmDLzOx6GlmA+QhxstJT5fZ/R6vcpml3/DxZp9NNE00caQVQh/u+Tvs9tn+S0uknqhMMfoy1YrLIQyvcLe73mqSGdT+L0Z891gaLmaor86DY+111ZcjmymoQMonQG3oxdVAq0HhFSIAFpmc807MTozdKqtx3hGASlr7aBmALjQPDK3wvx2rXhg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(7696005)(6506007)(26005)(83380400001)(508600001)(53546011)(122000001)(2906002)(9686003)(4326008)(186003)(86362001)(66446008)(8676002)(55016003)(66476007)(66556008)(66946007)(64756008)(15650500001)(5660300002)(33656002)(316002)(71200400001)(38070700005)(110136005)(8936002)(76116006)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?js8jAWHccRIICY6PttJrqzAZnvXIqgp5dhAmek2t0Igzb6yeVy4aMRoM4W4K?=
 =?us-ascii?Q?D7jBf+daq1L4sjkvD048OzuwZ3FStbAas6UIrtKh9dMDmE3eTxOYAd7CXe4l?=
 =?us-ascii?Q?V6mcdn2bWLOGfFAtwdMGxZZbbCWxp6kx6peeW5KK1VzjLPIhmKhZI2H36VAN?=
 =?us-ascii?Q?ucU1UR6lAprkDs2uoa3eFYyiNHH/CHIjfNqxlU7a+7gnjZptLIUMxhQqtiU8?=
 =?us-ascii?Q?NhHrT507yd29+onqBRCwa/MCbIlHFuHyfegO0s8k9dh4nmVa6yL7QgffgA9f?=
 =?us-ascii?Q?l3noszvHmfsSST2VmvYDic96U61VZI2H5n/q0RKn1WPzwqJ/EdwlLL3Q1IO2?=
 =?us-ascii?Q?0z3gZSKfVoXY7tXTHpvMPjY9h2xbF0gdlKEPbZjcGBUEO6Ia4FZBpa7K1mpi?=
 =?us-ascii?Q?cYHfYMrwq4jBIYkUXJUal5pGlobvz66b6L191vjkFTs3XoufYcDRnZncxYIA?=
 =?us-ascii?Q?arfA90PxMjOWy6sUAhR7RQ0gXRIEujwi2v/8YQjnL+rrujrXrVoG6ZezO8CZ?=
 =?us-ascii?Q?OioSCyWYpLi/Tq62fEEF1QWpeQRGRs2t5jgMmrYXVmsKyrw3ij3NgAXTApJz?=
 =?us-ascii?Q?EMyto8iflWVXHVh5siVHXuUiiy414elNQUVI2LBy5Mm61paLVmgBXPvaEZgz?=
 =?us-ascii?Q?tyUALUFNUX5fSeYFzYIyyRaUCalCRqJUlXkw6qZPFFyjDLH+g3YrXkZUnpDX?=
 =?us-ascii?Q?LQYUFmutQ0bjXMCLFH50ayk5sCWcX/QQrs89y1iv2rdf9LkPPZ5b7h+aWl+y?=
 =?us-ascii?Q?WtqgEswkmu+2ctcOnheIm/ygjFrdSaYp4zJ0HCsFVG7vlIJtc9w/sUH7iQmC?=
 =?us-ascii?Q?gVzEplhmPUFKajXzOZpnmBFEsbU0yakmkMGmiu4bcwvpx9XTQf2URq4nijzX?=
 =?us-ascii?Q?Mvflvv5ggJ0H7LAbn5BnSFqk2qHEB5Q3RAAlL9kD1/1pR5uqZYUoeBb9cWEN?=
 =?us-ascii?Q?D22R+bEAlMfSyxgFX88fjO148sTdFGXRz89OgtbTbWnkyXSGQ9tQiY85DdR6?=
 =?us-ascii?Q?htahmsxUKZYmemKBOSg2h7orJ9rVzV4srbSNWfvQpHHDOK7PhSkhiD2gV8yw?=
 =?us-ascii?Q?hAlGy50afyOZfE5w8thxmDIvz8NjA1/o75Nm2m/lxhBU7pAk+7NqUbAj5EN0?=
 =?us-ascii?Q?0se1NXCLudOT9xpwG2kn/55fLUEwGON3bZEOCDaRLTTEu2enH4v+21J5XgYk?=
 =?us-ascii?Q?akvS7NIvHkKIruhgjKofjwLxz1kNuKUnYTWx06OrYrxxMNmrQPNR1jFycHxY?=
 =?us-ascii?Q?7vVDjzw/YGIdgp5Fm7WOeT4dLXPC1chcBAeu5asGaiz7COC+v9dAjN96bquL?=
 =?us-ascii?Q?oPc0sEGujtckBu2V1IDCsP8qM6HhR8hMKetiDVsCZPhtWfsjB0N5VZuk36LJ?=
 =?us-ascii?Q?HKR9mw6MD4Zyph/JNoYt4W8aVimR5qeTrALpkZS+wBX2oQY8GndkGrrtf1yQ?=
 =?us-ascii?Q?1eEPqSQu/+EDDpIlvdGr6ncX7RnodL5GVU10hhlBIk6e4dvJvk11g8EEEjrq?=
 =?us-ascii?Q?Hd61zuVHGeQSJvQx25nZU2ZiuGfDRXa144WXpakvNvntjq7ChX4nkMxIg6Cp?=
 =?us-ascii?Q?VM7wvy58sHXugQVhXrM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850eb09b-c412-47ef-855d-08d9c35dc1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 02:09:30.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRgvoZLsGG00xTn9KzTpk9lAbyB99b5vU+xon2Gtu9RS2GVzSLesk6OnI6Nc5vX1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
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
Cc: "Saye, Sashank" <Sashank.Saye@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> sashank saye
> Sent: Saturday, December 18, 2021 2:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Saye, Sashank <Sashank.Saye@amd.com>
> Subject: [PATCH] drm/amdgpu: Send Message to SMU on aldebaran
> passthrough for sbr handling
>=20
> For Aldebaran chip passthrough case we need to intimate SMU
> about special handling for SBR.On older chips we send
> LightSBR to SMU, enabling the same for Aldebaran. Slight
> difference, compared to previous chips, is on Aldebaran, SMU
> would do a heavy reset on SBR. Hence, the word Heavy
> instead of Light SBR is used for SMU to differentiate.
>=20
> Signed-off-by: sashank saye <sashank.saye@amd.com>
> Change-Id: I79420e7352bb670d6f9696df97d7546f131b18fc
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  9 ++++-----
>  drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |  4 +++-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |  6 +++---
>  drivers/gpu/drm/amd/pm/inc/smu_types.h             |  3 ++-
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  6 +++---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10
> ++++++++++
>  9 files changed, 28 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f31caec669e7..e4c93d373224 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2618,11 +2618,10 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>  	if (r)
>  		DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);
>=20
> -	/* For XGMI + passthrough configuration on arcturus, enable light
> SBR */
> -	if (adev->asic_type =3D=3D CHIP_ARCTURUS &&
> -	    amdgpu_passthrough(adev) &&
> -	    adev->gmc.xgmi.num_physical_nodes > 1)
> -		smu_set_light_sbr(&adev->smu, true);
> +	/* For passthrough configuration on arcturus and aldebaran, enable
> special handling SBR */
> +	if (amdgpu_passthrough(adev) && ((adev->asic_type =3D=3D
> CHIP_ARCTURUS && adev->gmc.xgmi.num_physical_nodes > 1)||
> +			       adev->asic_type =3D=3D CHIP_ALDEBARAN ))
> +		smu_handle_passthrough_sbr(&adev->smu, true);
>=20
>  	if (adev->gmc.xgmi.num_physical_nodes > 1) {
>  		mutex_lock(&mgpu_info.mutex);
> diff --git a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> index 35fa0d8e92dd..ab66a4b9e438 100644
> --- a/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
> @@ -102,7 +102,9 @@
>=20
>  #define PPSMC_MSG_GfxDriverResetRecovery	0x42
>  #define PPSMC_MSG_BoardPowerCalibration 	0x43
> -#define PPSMC_Message_Count			0x44
> +#define PPSMC_MSG_HeavySBR                      0x45
> +#define PPSMC_Message_Count			0x46
> +
>=20
>  //PPSMC Reset Types
>  #define PPSMC_RESET_TYPE_WARM_RESET              0x00
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 2b9b9a7ba97a..ba7565bc8104 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1257,9 +1257,9 @@ struct pptable_funcs {
>  	int (*set_fine_grain_gfx_freq_parameters)(struct smu_context
> *smu);
>=20
>  	/**
> -	 * @set_light_sbr:  Set light sbr mode for the SMU.
> +	 * @smu_handle_passthrough_sbr:  Send message to SMU about
> special handling for SBR.
>  	 */
> -	int (*set_light_sbr)(struct smu_context *smu, bool enable);
> +	int (*smu_handle_passthrough_sbr)(struct smu_context *smu, bool
> enable);
>=20
>  	/**
>  	 * @wait_for_event:  Wait for events from SMU.
> @@ -1415,7 +1415,7 @@ int smu_allow_xgmi_power_down(struct
> smu_context *smu, bool en);
>=20
>  int smu_get_status_gfxoff(struct amdgpu_device *adev, uint32_t *value);
>=20
> -int smu_set_light_sbr(struct smu_context *smu, bool enable);
> +int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable);
>=20
>  int smu_wait_for_event(struct amdgpu_device *adev, enum
> smu_event_type event,
>  		       uint64_t event_arg);
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index 18b862a90fbe..ff8a0bcbd290 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -229,7 +229,8 @@
>  	__SMU_DUMMY_MAP(BoardPowerCalibration),   \
>  	__SMU_DUMMY_MAP(RequestGfxclk),           \
>  	__SMU_DUMMY_MAP(ForceGfxVid),             \
> -	__SMU_DUMMY_MAP(UnforceGfxVid),
> +	__SMU_DUMMY_MAP(UnforceGfxVid),           \
> +	__SMU_DUMMY_MAP(HeavySBR),
>=20
>  #undef __SMU_DUMMY_MAP
>  #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index 2d422e6a9feb..acb3be292096 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -312,7 +312,7 @@ int smu_v11_0_deep_sleep_control(struct
> smu_context *smu,
>=20
>  void smu_v11_0_interrupt_work(struct smu_context *smu);
>=20
> -int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable);
> +int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
> enable);
>=20
>  int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index af98fa140d83..76f95e8ada4c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -3058,13 +3058,13 @@ static int smu_gfx_state_change_set(void
> *handle,
>  	return ret;
>  }
>=20
> -int smu_set_light_sbr(struct smu_context *smu, bool enable)
> +int smu_handle_passthrough_sbr(struct smu_context *smu, bool enable)
>  {
>  	int ret =3D 0;
>=20
>  	mutex_lock(&smu->mutex);
> -	if (smu->ppt_funcs->set_light_sbr)
> -		ret =3D smu->ppt_funcs->set_light_sbr(smu, enable);
> +	if (smu->ppt_funcs->smu_handle_passthrough_sbr)
> +		ret =3D smu->ppt_funcs->smu_handle_passthrough_sbr(smu,
> enable);
>  	mutex_unlock(&smu->mutex);
>=20
>  	return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 58bc387fb279..505d2fb94fd9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2472,7 +2472,7 @@ static const struct pptable_funcs
> arcturus_ppt_funcs =3D {
>  	.deep_sleep_control =3D smu_v11_0_deep_sleep_control,
>  	.get_fan_parameters =3D arcturus_get_fan_parameters,
>  	.interrupt_work =3D smu_v11_0_interrupt_work,
> -	.set_light_sbr =3D smu_v11_0_set_light_sbr,
> +	.smu_handle_passthrough_sbr =3D
> smu_v11_0_handle_passthrough_sbr,
>  	.set_mp1_state =3D smu_cmn_set_mp1_state,
>  };
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 28b7c0562b99..4e9e2cf39859 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1724,7 +1724,7 @@ int smu_v11_0_mode1_reset(struct smu_context
> *smu)
>  	return ret;
>  }
>=20
> -int smu_v11_0_set_light_sbr(struct smu_context *smu, bool enable)
> +int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool
> enable)
>  {
>  	int ret =3D 0;
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 7433a051e795..0e60d63ba94f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -141,6 +141,7 @@ static const struct cmn2asic_msg_mapping
> aldebaran_message_map[SMU_MSG_MAX_COUNT
>  	MSG_MAP(SetUclkDpmMode,
> PPSMC_MSG_SetUclkDpmMode,			0),
>  	MSG_MAP(GfxDriverResetRecovery,
> PPSMC_MSG_GfxDriverResetRecovery,		0),
>  	MSG_MAP(BoardPowerCalibration,
> PPSMC_MSG_BoardPowerCalibration,		0),
> +	MSG_MAP(HeavySBR,                            PPSMC_MSG_HeavySBR,
> 0),
>  };
>=20
>  static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT]
> =3D {
> @@ -1912,6 +1913,14 @@ static int aldebaran_mode2_reset(struct
> smu_context *smu)
>  	return ret;
>  }
>=20
> +static int aldebaran_smu_handle_passthrough_sbr(struct smu_context
> *smu, bool enable)
> +{
> +	int ret =3D 0;
> +	ret =3D  smu_cmn_send_smc_msg_with_param(smu,
> SMU_MSG_HeavySBR, enable ? 1 : 0, NULL);
[Quan, Evan] It seems the " PPSMC_MSG_HeavySBR" message is only visible on =
latest pmfw.
To make it compatible with old pmfws, can you add some version check(like b=
elow) before issuing that message?

If  (smu_version >=3D 0x00442F00) /* 68.47 ? */
        ret =3D  smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_HeavySBR, ena=
ble ? 1 : 0, NULL);

P.S. I just saw this change already landed on drm-next. So, maybe you can m=
ake a new patch for that.

BR
Evan
> +
> +	return ret;
> +}
> +
>  static bool aldebaran_is_mode1_reset_supported(struct smu_context *smu)
>  {
>  #if 0
> @@ -2021,6 +2030,7 @@ static const struct pptable_funcs
> aldebaran_ppt_funcs =3D {
>  	.get_gpu_metrics =3D aldebaran_get_gpu_metrics,
>  	.mode1_reset_is_support =3D aldebaran_is_mode1_reset_supported,
>  	.mode2_reset_is_support =3D aldebaran_is_mode2_reset_supported,
> +	.smu_handle_passthrough_sbr =3D
> aldebaran_smu_handle_passthrough_sbr,
>  	.mode1_reset =3D aldebaran_mode1_reset,
>  	.set_mp1_state =3D aldebaran_set_mp1_state,
>  	.mode2_reset =3D aldebaran_mode2_reset,
> --
> 2.25.1
