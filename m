Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43487C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148E92075F
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 11:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XaMw8ohR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148E92075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A23CE6E8D1;
	Thu, 30 Jul 2020 11:15:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3796E8D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bExILfVyasMxznplZrgCLOdYAcRw1HdhhP8C2bZk7O+odLm5kK+RZIqxwsbHANDeqhGy5TchK3gSEfdvHgA2ul4cnvfK8M81gqeKm1W5Q6FdclfSdpkkanE5Uc3P4/ferQwmckoeGpvEB7+OsBNopYNqP762XAAFL2xG+1ygYMYGdUCeuOW5/IZuptO0Oa2/Rk0yEnLl+0s45mkHRmJ5gMU9u6VBtW3P/UdKcbbXoy6e9NMGHN/Mkn3HXKkKy24J2HqMOlB+TrzxYR2Fo993zfMVW59oeumKAyRddr6czLI+dXxC/1PuVOaa/5yBXdcyCV6G3VDcLiTpMIETs5iVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WODM8mM9fgqvJ014QyChc2qR44WbSS/IZ6qMnBwtB2k=;
 b=bCFfmm1Zfpg6gbcuWI+aMPA2opAECMCgmWvYMu0gBJrhS/cnH98D8Ju6wbxi6tF2iRYpKDiQZLUUyWlx/pqQX8pJdgoOluWGlmf4y/JTrPUkjHOzoqhZ59dF0pYjx287fRNU/cBcqJkXaEA2e5IrRs7S/rz4WZBziSSb+pqkEowk6lBD+5BetbHLHhUaM+ZXXLq0OvHIjqG8M4on9fo4TC+617pMRUKs9GicMKvbxBaqYbeSojvH+jA2mTZFsDLOQIy/lZ8eVGSh/FmovLdcGhJ+l+wSB/UAZNywIONVlQBjloHSA7QAljiOlgqO0Ic7mhLyPBVo5Sph8GuHTaLQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WODM8mM9fgqvJ014QyChc2qR44WbSS/IZ6qMnBwtB2k=;
 b=XaMw8ohR4ZXS5BDU4oVx9A22XUp5N4ARu8MPZW0c/IxGdeOH+/puYowWfvtqwQWC8SxdxAmQunBeStZHeJzLMD4vRnkcX1hqs4Jvm/u56a7OTz67IlGIGjYGJjIEJuL5axGJC0G8Bqa5tm6TYjcMqCmpOGi9XjXRkCNkGpZ7LVg=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.30; Thu, 30 Jul
 2020 11:15:03 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::f8df:794c:7431:2440%7]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 11:15:03 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
Thread-Index: AQHWZlojV20Ic+F9EEeI7myoSS20hqkf+Jzg
Date: Thu, 30 Jul 2020 11:15:02 +0000
Message-ID: <BYAPR12MB288886EDD4544103379CD409B0710@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200730101345.3424-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200730101345.3424-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=810a2c30-252a-4c6d-82bd-000002f374a2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-30T11:14:57Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84c24450-9ce3-46a4-7b1d-08d83479ce5e
x-ms-traffictypediagnostic: BY5PR12MB4145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41456598DFAD8E7162B39FF8B0710@BY5PR12MB4145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93aE3UKy8J/wPsVykfcOFpM0TGnW75gImjrD54xNoYragc/2QYuUAZoy/Z4mTwzf9SQ4XHtbwjyOOjpj73wFAkLSCpWXObbEZmUeBj2M2UyKv6lSBu3YWW0DPcODq8HR2kLG+uXSkpf5jf3ThH+yFn+4QhCWWDF5zUg3Ul4a0bWbtbqtfGxlx2cL2f/N5l4RAKtc3Myzx/1hcipJ7DED2Ef6J6ZEBtu1xn5SlL1HDOzSZaF2rnnAE8WciPXR9HiDUgrfy1u6R91oQ9cf8OQyCH+VElifKwDHfGfoVrZ+GrBlEZtETJ+HlbH8e7+qLkUeDX6IeEV2akjxakQ0SrUUYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(55016002)(478600001)(86362001)(71200400001)(53546011)(83380400001)(7696005)(4326008)(33656002)(316002)(110136005)(66946007)(2906002)(66446008)(52536014)(66556008)(5660300002)(186003)(26005)(76116006)(66476007)(6506007)(8676002)(8936002)(64756008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: PldlH6xrIWUQGrc8Nz2oBbRP0ng0b/p8T7cwWLyBraWQdPI7I1MhmBrN9K7Dfoob9kCy+g7akaxZzAzOPP1wFycc6xvi1qv1nS8b65pqWc9cQXUH/uYUa2pP+9YvqInChVf0S2zDjxlVeGgQp+/E/Ud1yTX4iDSJhdR20F8CUA+gKgruLv3hPDJn2gklhT1qPq+U1ppL8jsjInDbmVNvPdrBQg3tLGCFf2+2pRHu+82pqPLohDP3Qvv7s7d/zW6W10gJdFQGe8ZpBSKPmfla862ZdKWr8+v0BxdOwZDeZSaWCSTDWREkPBrkxiQ7pYV9zl+6J2CuaC3T0BKF8e9kAIgeb9I0WW3S7YbAjTuBZ6gT76p3g2Pdtec2w/D920UwgVVywi08H9sdBMBLVo/LdzVUxJ956xq6twiVn+6/02NkXer6t5/mMJeQfWH29VDhIEOGs4BT8xwHkikZRJhhskOpuDY9cq85KWUw0TaYU5eyNX7ygqTP+Ai7AlPR/+5j
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c24450-9ce3-46a4-7b1d-08d83479ce5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 11:15:02.9731 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRqQOz7j7BZvl0CkVTBNVFNqzAwn+GuUljii+izHRprEfoNL3FlE0c9k5PqKrQ6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Thursday, July 30, 2020 6:14 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: enable GFXOFF for navy_flounder
>
> Enable GFXOFF for navy_flounder.
>
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: Ia49c1ad70e3521447b9db101f5c0eae70b1df665
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c    | 1 +
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ca16f01956d3..fe8ccc9be682 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7529,6 +7529,7 @@ static int gfx_v10_0_set_powergating_state(void
> *handle,
>  case CHIP_NAVI14:
>  case CHIP_NAVI12:
>  case CHIP_SIENNA_CICHLID:
> +case CHIP_NAVY_FLOUNDER:
>  amdgpu_gfx_off_ctrl(adev, enable);
>  break;
>  default:
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index a9453ec01619..7d7de854a826 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1029,6 +1029,7 @@ int smu_v11_0_gfx_off_control(struct smu_context
> *smu, bool enable)
>  case CHIP_NAVI14:
>  case CHIP_NAVI12:
>  case CHIP_SIENNA_CICHLID:
> +case CHIP_NAVY_FLOUNDER:
>  if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>  return 0;
>  if (enable)
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
