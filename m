Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B65C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 13:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F9B010E215;
	Tue,  9 May 2023 13:46:46 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE38410E215
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 13:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=algjn8tLedyY10Q2sUlxLLIkYzS4W0WMXIEqr1uDTU4BFqnKzE48kGu+Pi4aM8sWsWiheScLhsFQspvCdyHTEfLcpa63Feb0fgTo3Npa3Tne25hdXV7q2JXl9Fp8NB51Ywm3apMpqYt3WLR8nHLLKB6bCfrLv9yyOgkuBcwPIeNUdbFY1NXPGeyzOdNEBeCQ7U6IqTlYrSoSF2GZiArsS//bf/3I3Ijw4fwHkvDKsAfV/Y/+Wf+Cnh+DHdzYxcxjT7LFtPq3X9cLD1f/RzlZa/fydvj9ok7V0xS7r6+azCwPMvFv26KGGkFJMVhI8vm6z0aCIBZFnOx/LFyjmQW1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebs3wkURqtN1CGTgM90wdQLLvGNsg1iSNmSxtr169vw=;
 b=Cq9ORZIOeRvFVzlmPqHro/y9APnUKQr7fRUHuTz6wGMMwX/66dHDeufeWTk0CS9x6jcZysvby1gcY5tePicwMUbYVztccrj6tvImiL1Knt+xfpt1CAQJmaOF9FtifQikV+uya/eH/mynuF77NXdQ0gzzxNcMEjS9ZAtyMWEzul5pDnjcowUUUNSz0ikB+VATYdZZtQnoGyh5BHOaVdLrLO8oNQ8QDlyk4PdKx9nNxj+xj5Gy7o1aCextYlGDXWwHIJIxa2ywPgk56O8UQNRpg6ustJaRMy1a+69+RPnft5bX83gTJsj+EqxPG8a/kOaGsPjulJEE4UhBsqgEGXvUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebs3wkURqtN1CGTgM90wdQLLvGNsg1iSNmSxtr169vw=;
 b=DUSb1j1KWDxJCYtRkiiJy1HjMoXgQHq4EKmNFb+fVzQ+Qki6JVe+95CuqM3OsOPFNs2X95umU5dPFXmOb0jfDjJOzL4KllsiXKgR8HV4QLct/9+x/bVSGuHfZa/e6pwCPxs43EEaJgWYav2nTztdkpzEabJGFYVf33kwUsN4rVs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Tue, 9 May
 2023 13:46:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::28fa:232b:593e:5836%7]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 13:46:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Thread-Topic: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
Thread-Index: AQHZglb/QzROCqTQiU2ooToEVZmy1a9R9J5w
Date: Tue, 9 May 2023 13:46:41 +0000
Message-ID: <BL1PR12MB51446F82BA088D67B310B670F7769@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230509091616.958180-1-YuanShang.Mao@amd.com>
In-Reply-To: <20230509091616.958180-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-09T13:46:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=16114599-c533-47df-9b5c-b5c63fca4561;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-05-09T13:46:41Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 83ba657c-c749-4196-9554-c6be6251472f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA1PR12MB7409:EE_
x-ms-office365-filtering-correlation-id: a73302e5-4e30-4ee3-014c-08db5093d23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEvlamVg6VnrlpgY8P+F7WE19SMpLHdsN4uDC1uTTjUWi+WPPTrI0fmMrIuns8+l73Eh5HeDkLvt8iQVk6ZA2inMV8jduk45MTGW9yb5WnNfZMe7wBMKlcpX7Ppw5u8IeDQDZEvEh581ruBeEViymTRr1BUD0rm8FuIDy8iiXMJvVfjLQ+3aWPjpKYfEpFC+LWN4rIjozKuHpYnjKY+FTclQNoBiRJ7nXWyVKRU1o+EEq6fSq+qMDKfg9TEv7YdXLZ1wHLBcpRELQ5T7cXJ54U4iCfclRQe/pkUv5Yp26syfc0rekCB4UqSPF7RXE5IvGa8RjwGEHcTjoftm1cU5uMWbl/SfbIdtf4aiCkgL2DZW43vofEmKef9R4pCACm2Fvjun8tWioMjF0Boahi79ZW2L6TSnpjPSZ2laeU7rzpwPXkeraETVHkYc3UxWYA9EcO+m/NaS7Qi6jtE1bVs1mzHTv5nGXG9Ej3HCEpT7eJJfbhJNtuUaKcqZyjhooYY3iQt0vYl/o+HEK0NCIgg+nGMwhuhEQ83IMd1MJEccmB7s+OfoEM0urDc1KJLYFZVXGdCAu+80pwaFk6H12Emhmh94X+nYeTlwhbLmlEBX/OqJ/9V32AbKvCUv7+ctF4Wu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(53546011)(83380400001)(7696005)(55016003)(38070700005)(186003)(38100700002)(122000001)(6506007)(86362001)(26005)(9686003)(33656002)(4326008)(2906002)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(110136005)(71200400001)(52536014)(41300700001)(8936002)(8676002)(5660300002)(316002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eA92oj0MUHUFvuXo1/cWzzGWZzNpnVVRRG09XJ4+IwcgVn4XWT6BPW5kg0xO?=
 =?us-ascii?Q?BhOxOEtOxPVEmzsjUlu4IL2AfoqDww/QF0S2qIPZRLQz5V47P7GanIv+bWur?=
 =?us-ascii?Q?JmsH7Pz/g3JmWIpdcABC/ElSO9KpxfxTX2yt/iu+KcWjFWYymQnRw2Rku4oH?=
 =?us-ascii?Q?t3LzTWIU57bBbxj3QJDMJZPRp8pXJ3gAuRr+ypTjOaKnshb/DQHLM5xEGTrY?=
 =?us-ascii?Q?iw1L1aaLnU+GcCDYo8uHdFIT9T47L5rd+m/JKLndnl+GbIS9xjK+UeyEZjSX?=
 =?us-ascii?Q?VpME2dhGu8dcUB7o5Z+u+hadp5X4NNpgyYb9e8VGNJ2Ox77qRuI70S06z74w?=
 =?us-ascii?Q?XQeh+oVIUwgNC+tUZNiFAFCuGrbfhooYr2byr9jn9B4K0UwfQlg7G6tm+KqO?=
 =?us-ascii?Q?DqxlxzW6oUgw6AucqbDPdenhg4guS11GTI8AM1xnxV0CyzVoqQWlJ0SjKZeX?=
 =?us-ascii?Q?K9RE7dDaGEU5lTAGGU4NYl+ZrthDTfZvfhPH8v3+gotDrKO61t7xuH99qK4R?=
 =?us-ascii?Q?dnSmYzaSxhzoE5QXKVngjb30WAYD8lS8yxAEeXgW4wZ1Wz8dncpPW/YqP6jP?=
 =?us-ascii?Q?zet6c5hAdPDUwqlQ3tDrmldYPhqYPF5AcQgyiUgV3VJCzP7cR8XcLExL9k+w?=
 =?us-ascii?Q?jTGLEm2MV0LhwuI498N9lLZbf+VrSnFdXtTh9ohsfMTH0F9Pvr6vxVnk3TB7?=
 =?us-ascii?Q?dHIcBxXpEpALookh4ANOgcJF68b5JIlcMdBbnhXRlU15shuPw8YRmdHBgW/K?=
 =?us-ascii?Q?ImlJbfUccr37IXHxqkZbfK8byLgTHHiI+zHW9vsb97GLJTLEmOAUW1FFGQyp?=
 =?us-ascii?Q?DLkTkWUd96ioE/EoU79eZMy1oqlpuLgYhjHe/drXUXQZqXOQGe+kxXOEb60l?=
 =?us-ascii?Q?Sxo/JPQ9uOxoxWQhfOWWl/HkN7ORCSswZ01agwejewYqaTKAfJqWCshjtwpr?=
 =?us-ascii?Q?8dJ2W6rOrowJqbvr4xr0ciz8Y4ti5s08pxkN2MnJBMo1VkwyjWRSQaobV2ZP?=
 =?us-ascii?Q?Q2RhgQAEc5wtFT2WOW/n509LiYOLRN1qzm0adab2taM6ro0v/4c6AwhqRJzs?=
 =?us-ascii?Q?8zqoxo525/T+HHfyOmmcnO3g4lWTiS3OXiRdXlZm6WsGhLrmO0WXhcLFLqR6?=
 =?us-ascii?Q?pngCkHRFUO99tnm4zpPjAdQ5TnxgzOnekZ+DXWtBoxNqB3ofzyP6g6E15WQz?=
 =?us-ascii?Q?+eZpnVqJipHbR2gRMeapRdShtwVbnz/aMg153Iw0wfIEM/1ZTtW1n32fP+bQ?=
 =?us-ascii?Q?/yYPVYZu/nVoXexfISLLeRO9jlETg8u+9+tTog7s51VeOvk/OU2D/36quGn+?=
 =?us-ascii?Q?z+BLhiQjkbMZkdfs6VVl437V/0xzT5kjOa//3L5bgK62BzpY8eZ7lsFNw5Ue?=
 =?us-ascii?Q?/vRFsv+e846RqWQ+b3K81NSuhbFLn3a+AkXpOS1QjBjsvyt849nILCQ75dML?=
 =?us-ascii?Q?5YGuqhJkPzcqojfaN7ZmW3jpw0Tji5HnVqFRU599o9fQFc4K7sXIvKuMtGH9?=
 =?us-ascii?Q?TcRUJZu5XNMGdzfKW9qBLxjkQ1YFmUfQI6sVzTWoZgL0wNIzuM1feisVwHO2?=
 =?us-ascii?Q?mecCRPsJu/ZBcMfruxk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73302e5-4e30-4ee3-014c-08db5093d23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 13:46:42.0104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sJiQ6JrgasRz8uUMgAWgcZbz0eaclGUqTBeOPbZIb3sphHgZfv6dorwOqj2ok3SYco8fGu9IEmehAIFzsnAsbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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
Cc: "Yin, ZhenGuo \(Chris\)" <ZhenGuo.Yin@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>,
 "YuanShang Mao \(River\)" <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> YuanShang
> Sent: Tuesday, May 9, 2023 5:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>; Chen, Horace
> <Horace.Chen@amd.com>; YuanShang Mao (River)
> <YuanShang.Mao@amd.com>
> Subject: [PATCH] drm/amdgpu: Remove IMU ucode in vf2pf
>=20
> The IMU firmware is loaded on the host side, not the guest.
> Remove IMU in vf2pf ucode id enum.
>=20
> Signed-off-by: YuanShang <YuanShang.Mao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 1311e42ab8e9..0af871735a74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -557,7 +557,6 @@ static void
> amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
>  	POPULATE_UCODE_INFO(vf2pf_info,
> AMD_SRIOV_UCODE_ID_RLC_SRLS, adev->gfx.rlc_srls_fw_version);
>  	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_MEC,
> adev->gfx.mec_fw_version);
>  	POPULATE_UCODE_INFO(vf2pf_info,
> AMD_SRIOV_UCODE_ID_MEC2,     adev->gfx.mec2_fw_version);
> -	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_IMU,
> adev->gfx.imu_fw_version);
>  	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_SOS,
> adev->psp.sos.fw_version);
>  	POPULATE_UCODE_INFO(vf2pf_info, AMD_SRIOV_UCODE_ID_ASD,
>  			    adev->psp.asd_context.bin_desc.fw_version);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 24d42d24e6a0..104a5ad8397d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -70,7 +70,6 @@ enum amd_sriov_ucode_engine_id {
>  	AMD_SRIOV_UCODE_ID_RLC_SRLS,
>  	AMD_SRIOV_UCODE_ID_MEC,
>  	AMD_SRIOV_UCODE_ID_MEC2,
> -	AMD_SRIOV_UCODE_ID_IMU,
>  	AMD_SRIOV_UCODE_ID_SOS,
>  	AMD_SRIOV_UCODE_ID_ASD,
>  	AMD_SRIOV_UCODE_ID_TA_RAS,
> --
> 2.25.1
