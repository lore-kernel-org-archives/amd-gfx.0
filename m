Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2A4C7EE25
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 17:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97E610E532;
	Wed,  7 Jun 2023 17:34:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB6D410E532
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 17:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M97ZRJNewrP71gi663N6/4e2bAteBwm6+FBg6cDCjqG9KkWz/T7+Cj7XNxCHufKAuof3jZgwdZlPpNBw8jGchzxBavw1WtQqLFXPZeqjiI8FWXtZhTArXWR8ImDChAAMid4T2iKQ3U1Et1uvTKFbh3MjGZ3NMCXP3iljuNWGZvFwyyXsp11i7CwJT2Ah8EUBcJ3O5/kW7i8+Dea4h0KRQv0m7bVTxgMkrdZuzPH5pLT4VaQjsKyXh7MXuNE+6eDu1E5p16LieRvFvGztg9ajTjgjOHLyIYIIoxAzTUM0DcSnt1/WvtanU9fCt+pmm16/3Jx89oMSqpD6AsKIxkbWQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cEREPP+wWhJDLspUTPMtms5aASjDxrn17qPYsnqJpQ=;
 b=B3Ked0dsSwzqcBcR+Q1hsvT1wQUrIgh26D4NJGW3UF2lnkzDgYv466OLj3bAk6hE6k/aoR7gGjRspjj6wHIjd8mp//GfMFs7Bmkh/ONlZ1hGRcUGsDlcrTEmaKP0HuzsWqw7oCiFBatV7ghD7Pzv3pEJYz/VUWSrKpp6HGbx6zpY6XmawVC78FPhvYrKTZ4rqDSmhRrObcpYR7gqv2JS7YIq9pVUdKY1ifKcfPlpx0iBd+4VEUcwqmK0aXMNHNlrLiZqDJ9JanuzHjfoNVOehOl77s4XTqCTOnDS8gUuU4q5w2gdB/n3WDMYuSpDmN3QulYNtLCiYggQGOk5RybQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cEREPP+wWhJDLspUTPMtms5aASjDxrn17qPYsnqJpQ=;
 b=fOAfZtMZH99txzYM9y9XJA7gp2lV70yKZkXDOOvijh5rjGCO9t71+GV9/nqlpgyOQM5d7Ezy3ZLcL91N0l27KQFF96sMN56ny4ucaq3aNJCMCJpOEM0WJtC/JcS2AoAnQUHFSrmNwzjm1joXhM7L0ZVQNIqExiFlb4yuAJKHq2Y=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 17:34:17 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 17:34:17 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: optimize gfx off enable toggle for debugging
Thread-Topic: [PATCH] drm/amdkfd: optimize gfx off enable toggle for debugging
Thread-Index: AQHZmWX91iNzXn38fEyDxLwoy8UC1q9/ma+g
Date: Wed, 7 Jun 2023 17:34:17 +0000
Message-ID: <CY8PR12MB7435460F52AC91FF912A964E8553A@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230607173211.1824941-1-jonathan.kim@amd.com>
In-Reply-To: <20230607173211.1824941-1-jonathan.kim@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3fb36729-2f4c-4351-84da-dd65d011075e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-07T17:34:13Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4902:EE_
x-ms-office365-filtering-correlation-id: c837b3f2-16c5-47ec-7343-08db677d6ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cqTT3wSn+zjuZBAaidxhY6zE39JDnttM6o324NdUUjnoKwqPaJTG7dTiYtdTvfIzKYrBSqwe2Od4e8VqFZVk22NaiEUj2urPBlwj14bX0rjTEbGS0ZFP7F3LjNl8WeidtRGOC+5+/kwxPy2/Y9PEo9pQXJHAm38z6PMMrCcgLMzWjqmWYHMAtKx0vSb7VX/qjdL8KPa8gxtvGQFMMaVTLJXpBl5ewHw0g4+NnZeJvHvCCYjLrcEZP1ZaUnFj2IFAgS97+XJadknJXDd3nRqfPODD7rl/OhriI4KQuz1ZnQEYqpWNlnqbAZRNUIgqVMSiNsX+cGOsozK6pvvRCdcEzIJzln/zSBd7rVw0KDhhUBJ1MdrZ44gsnubSRqpe2n2ZFvsFrtKHWkoLSt0Vu1bMjoB9fPBbGPfFhsMuYjVnzAlQfP2lF22sZPACKObQlWTsm5nMoT4Jk+sThc/NI5XWC02KIGE3RFm8YqShy9u2caQL0iAGwfEVzwy31Os9vFLOZEEGO5s5R1cX6PhpA8HLDlSSja8wrtLLSsGlzNIpo6uWJxWolyNwgtL1qE/8Apo3YH2yosBsBLWX8xTk0HMP+sUCQGliMvCO3pS7nz3ah5zMTgAtoy+G2aYKamPfvBQ3s5QJvasIBKTOyeogjIP6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(86362001)(52536014)(122000001)(83380400001)(54906003)(64756008)(66476007)(6916009)(38100700002)(66946007)(4326008)(66556008)(76116006)(66446008)(71200400001)(7696005)(478600001)(2906002)(186003)(38070700005)(5660300002)(30864003)(8936002)(41300700001)(8676002)(33656002)(316002)(55016003)(53546011)(9686003)(6506007)(579004)(309714004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8yAGIOfc3QSf/0sYpyGiVWEOOlVz2AUr21g+t/x0vqxIwdH2gk5z04qE8zds?=
 =?us-ascii?Q?0P+19XQfzMuHmrQ0x4umBcZ804TZkpC414x7R0EMPm2v44WZQGWwPELDjE2i?=
 =?us-ascii?Q?OqUJVLUz4ZpKnNHbzItw8W+6OHeppyMACzWFDoFrUFipIr7iYRQDYEFkLTE7?=
 =?us-ascii?Q?5TDtMLdCLso5xDd/npYTYG1Ikdt3+01GMBQgaZYiCZrnkL1J/HVyn5PYcLUJ?=
 =?us-ascii?Q?LVmtuvd/BoK7Nn/A/vxxyhQ/YNzkaNMOJJh5gqCIhsOS9JRRbgghiMDDyg0f?=
 =?us-ascii?Q?P6eSpkLVNyJgXbBnHZdfvRWwa2i8pRHX3VB5kjRReidbeVnI+ykJq49612Rs?=
 =?us-ascii?Q?lYLRK4gBvnUPF/BDQpy4r6EMrM6ibSVH9paqErg6Qrm1fR/WXF+sOHPky6Kc?=
 =?us-ascii?Q?ufIOOw4WC/CizUQN2HP3CFANaZ3/65N3RCQPIqmQfQ8BLJQZPvTPpfn9u1T7?=
 =?us-ascii?Q?BbXBJ50Uipzzlv4JCzriGQPJLElNGiNRV1A2bGi8hwgtMo3URq7VaeErhJo1?=
 =?us-ascii?Q?CtztxnoTj1gCtMCiyXZosWKQJKEY1UnD9hm8EtEQwUTVq2JZNoikSapdUs63?=
 =?us-ascii?Q?5PpyO6tyFLH0MayVO4PtdvST9C8Q6CGIhXU6VEr8ZSJmHP6EWqFAbUj0FsBv?=
 =?us-ascii?Q?/PGw9W7g6mG9eBSBPGcJdpE5cq5J9swpFTXYvMFevKTYWk8nStZqpDy42zOs?=
 =?us-ascii?Q?JNBv/IDM5OjLkTCk4LUQFYkmGBBSg9bBJEJTPja+nN05UvGgtLkYOflyzXwX?=
 =?us-ascii?Q?CCd1yydcvHAtUqJ7r71VgK2xNIC1Jdd2kQjb+rZmLEApqaJdqgzaP50Km1ou?=
 =?us-ascii?Q?2NXc08vmMNwOmkJoqhx+LZPup8SkcImh57MToIUxcBVkp0tkO9fknOM1v/ue?=
 =?us-ascii?Q?HHX+vTkivEd+KxWS19ujreFkOAdTOa8BLO9Kgp0Ydvssd8hKTQ/1SQYqdeBA?=
 =?us-ascii?Q?rUHAkEgB5tPwAaafWhdpJJVgQvw9SOUBoWRWatV0TMcpczKMiSvai5WW9x+K?=
 =?us-ascii?Q?pb6k5LmJ82vElF4umjzPWa/cumXH0fpqDsmxiLyVJy7uNvu2+5YJ9Wn7h7T4?=
 =?us-ascii?Q?biA+3gFNEERKNmHAXyOzm+GWdOfTL1rWUBtwmZwUYSQ70L+3vSyqRgJ8r15G?=
 =?us-ascii?Q?9KjJHgKmOhMMw3ilnvwfMsZfLGlzWCrfiYsQRHIYdlbkTixtH3vPZFUK7xqw?=
 =?us-ascii?Q?opnQ0evrbyh5j9o92gtBl7P0QDsSMOPqPbC2s8IGGCoxz8Dtao4M5gtTyUC0?=
 =?us-ascii?Q?j7wY4YG07fQt/spZceI7yvmvVhS2WBJz7H0Be6XcKokHlRuP+YjJTjcN3zNE?=
 =?us-ascii?Q?4he5v/z2q7DgVxZ/VzVdpZt8Q/82LCEiIYpmZdnkDn1DrYDxcc2dDCdJRELL?=
 =?us-ascii?Q?Na1c+f+YLOmQS/2ALhPQmu55pz5UKcL+f1it9fWGO+GbG6JjIfZ5dc5MP/vG?=
 =?us-ascii?Q?BkzXj+YL9hWP4uVlbjX/PWRrl1wvxvnRbLZVuNrcBJ6j1ogQl6ZikRZuE6oo?=
 =?us-ascii?Q?+gN+j2yj16r7FdM/hq7xMwJUxADbatsbwLITjCfA/6OSHb15cTHpt6tF8mgz?=
 =?us-ascii?Q?GYpsMRazt4tluYl1swtZGiiSa3F8R9LBEPVDrPtx9mwcoi4W4+XhAHStGmfP?=
 =?us-ascii?Q?7jh46NRWQGAul0TNUgnkqFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c837b3f2-16c5-47ec-7343-08db677d6ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 17:34:17.7550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30/rgWbFFHyRBZqZ1Q3E7g7YdMi8bQpgGumldTspiWkxhVQguXYvzLXGtfRYBkh5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4902
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
Cc: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

+ Felix (typo on email)

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Wednesday, June 7, 2023 1:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Felix.Kueling@amd.com; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: optimize gfx off enable toggle for debugging
>
> Legacy debug devices limited to pinning a single debug VMID for debugging
> are the only devices that require disabling GFX OFF while accessing
> debug registers.  Debug devices that support multi-process debugging
> rely on the hardware scheduler to update debug registers and do not run
> into GFX OFF access issues.
>
> Remove KFD GFX OFF enable toggle clutter by moving these calls into the
> KGD debug calls themselves.
>
> v2: toggle gfx off around address watch hi/lo settings as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  4 +++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  7 ++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 33
> ++++++++++++++++++-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  4 +++
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 24 ++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++----------
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 21 +-----------
>  7 files changed, 77 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 60f9e027fb66..1f0e6ec56618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -150,6 +150,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>                       VALID,
>                       1);
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H)
> +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_high);
> @@ -158,6 +160,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_low);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return watch_address_cntl;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 625db444df1c..a4e28d547173 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -350,6 +350,8 @@ static uint32_t
> kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
>                               bool restore_dbg_registers,
>                               uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -362,6 +364,8 @@ static uint32_t
> kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -375,6 +379,7 @@ static uint32_t
> kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
>                                       bool keep_trap_enabled,
>                                       uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
>
>       mutex_lock(&adev->grbm_idx_mutex);
>
> @@ -388,6 +393,8 @@ static uint32_t
> kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>  const struct kfd2kgd_calls arcturus_kfd2kgd =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..415928139861 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -754,12 +754,13 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct
> amdgpu_device *adev,
>                               bool restore_dbg_registers,
>                               uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
>
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
>
> -     /* assume gfx off is disabled for the debug session if rlc restore =
not
> supported. */
> +     /* keep gfx off disabled for the debug session if rlc restore not
> supported. */
>       if (restore_dbg_registers) {
>               uint32_t data =3D 0;
>
> @@ -784,6 +785,8 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -791,6 +794,8 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct
> amdgpu_device *adev,
>                                       bool keep_trap_enabled,
>                                       uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> @@ -801,6 +806,16 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
> +     /*
> +      * Remove the extra gfx off disable reference from debug restore ca=
ll
> +      * for asics that do not support rlc restore for debug registers.
> +      */
> +     if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 10) ||
> +         adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 1, 1))
> +             amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -832,6 +847,8 @@ uint32_t
> kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>  {
>       uint32_t data, wave_cntl_prev;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       wave_cntl_prev =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmSPI_GDBG_WAVE_CNTL));
> @@ -853,6 +870,8 @@ uint32_t
> kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -863,6 +882,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct
> amdgpu_device *adev,
>       uint32_t data =3D 0;
>       bool is_mode_set =3D !!wave_launch_mode;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> @@ -877,6 +898,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -916,6 +939,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                       VALID,
>                       0);
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
> @@ -938,6 +963,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -948,10 +975,14 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>
>       watch_address_cntl =3D 0;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..bb6ad733b3d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -768,6 +768,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>                       VALID,
>                       1);
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H)
> +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_high);
> @@ -776,6 +778,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_low);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return watch_address_cntl;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..e30d1f9f5564 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -704,6 +704,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct
> amdgpu_device *adev,
>                               bool restore_dbg_registers,
>                               uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -714,6 +716,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -727,6 +731,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct
> amdgpu_device *adev,
>                                       bool keep_trap_enabled,
>                                       uint32_t vmid)
>  {
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -737,6 +743,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -768,6 +776,8 @@ uint32_t
> kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>  {
>       uint32_t data, wave_cntl_prev;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       wave_cntl_prev =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmSPI_GDBG_WAVE_CNTL));
> @@ -789,6 +799,8 @@ uint32_t
> kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -799,6 +811,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct
> amdgpu_device *adev,
>       uint32_t data =3D 0;
>       bool is_mode_set =3D !!wave_launch_mode;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       mutex_lock(&adev->grbm_idx_mutex);
>
>       kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -813,6 +827,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct
> amdgpu_device *adev,
>
>       mutex_unlock(&adev->grbm_idx_mutex);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -852,6 +868,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                       VALID,
>                       0);
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
> @@ -874,6 +892,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> @@ -884,10 +904,14 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>
>       watch_address_cntl =3D 0;
>
> +     amdgpu_gfx_off_ctrl(adev, false);
> +
>       WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>                       (watch_id * TCP_WATCH_STRIDE)),
>                       watch_address_cntl);
>
> +     amdgpu_gfx_off_ctrl(adev, true);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf1db0ab3471..f597e1c8ebee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2766,7 +2766,6 @@ static int runtime_enable(struct kfd_process *p,
> uint64_t r_debug,
>                       struct kfd_process_device *pdd =3D p->pdds[i];
>
>                       if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
> -                             amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>                               pdd->dev->kfd2kgd->enable_debug_trap(
>                                               pdd->dev->adev,
>                                               true,
> @@ -2823,33 +2822,22 @@ static int runtime_disable(struct kfd_process *p)
>                       return ret;
>       }
>
> -     if (was_enabled && p->runtime_info.ttmp_setup) {
> -             for (i =3D 0; i < p->n_pdds; i++) {
> -                     struct kfd_process_device *pdd =3D p->pdds[i];
> -
> -                     if (!kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -                             amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> -             }
> -     }
> -
>       p->runtime_info.ttmp_setup =3D false;
>
>       /* disable ttmp setup */
>       for (i =3D 0; i < p->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D p->pdds[i];
>
> -             if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> -                     pdd->spi_dbg_override =3D
> -                                     pdd->dev->kfd2kgd-
> >disable_debug_trap(
> -                                     pdd->dev->adev,
> -                                     false,
> -                                     pdd->dev->vm_info.last_vmid_kfd);
> +             pdd->spi_dbg_override =3D
> +                             pdd->dev->kfd2kgd->disable_debug_trap(
> +                             pdd->dev->adev,
> +                             false,
> +                             pdd->dev->vm_info.last_vmid_kfd);
>
>                       if (!pdd->dev->kfd->shared_resources.enable_mes)
>                               debug_refresh_runlist(pdd->dev->dqm);
>                       else
>                               kfd_dbg_set_mes_debug_mode(pdd);
> -             }
>       }
>
>       return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index e7bc07068eed..5b381018407a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -441,11 +441,9 @@ int kfd_dbg_trap_clear_dev_address_watch(struct
> kfd_process_device *pdd,
>                       return r;
>       }
>
> -     amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>       pdd->watch_points[watch_id] =3D pdd->dev->kfd2kgd-
> >clear_address_watch(
>                                                       pdd->dev->adev,
>                                                       watch_id);
> -     amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
>               r =3D debug_map_and_unlock(pdd->dev->dqm);
> @@ -476,7 +474,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>               }
>       }
>
> -     amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>       pdd->watch_points[*watch_id] =3D pdd->dev->kfd2kgd-
> >set_address_watch(
>                               pdd->dev->adev,
>                               watch_address,
> @@ -484,7 +481,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                               *watch_id,
>                               watch_mode,
>                               pdd->dev->vm_info.last_vmid_kfd);
> -     amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
>               r =3D debug_map_and_unlock(pdd->dev->dqm);
> @@ -599,15 +595,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process
> *target, bool unwind, int unwind
>
>               kfd_process_set_trap_debug_flag(&pdd->qpd, false);
>
> -             /* GFX off is already disabled by debug activate if not RLC
> restore supported. */
> -             if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -                     amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               pdd->spi_dbg_override =3D
>                               pdd->dev->kfd2kgd->disable_debug_trap(
>                               pdd->dev->adev,
>                               target->runtime_info.ttmp_setup,
>                               pdd->dev->vm_info.last_vmid_kfd);
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>               if (!kfd_dbg_is_per_vmid_supported(pdd->dev) &&
>                               release_debug_trap_vmid(pdd->dev->dqm,
> &pdd->qpd))
> @@ -699,14 +691,10 @@ int kfd_dbg_trap_activate(struct kfd_process
> *target)
>                       }
>               }
>
> -             /* Disable GFX OFF to prevent garbage read/writes to debug
> registers.
> +             /*
>                * If RLC restore of debug registers is not supported and
> runtime enable
>                * hasn't done so already on ttmp setup request, restore th=
e
> trap config registers.
> -              *
> -              * If RLC restore of debug registers is not supported, keep=
 gfx
> off disabled for
> -              * the debug session.
>                */
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               if (!(kfd_dbg_is_rlc_restore_supported(pdd->dev) ||
>                                               target-
> >runtime_info.ttmp_setup))
>                       pdd->dev->kfd2kgd->enable_debug_trap(pdd->dev-
> >adev, true,
> @@ -717,9 +705,6 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>                                       false,
>                                       pdd->dev->vm_info.last_vmid_kfd);
>
> -             if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -                     amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> -
>               /*
>                * Setting the debug flag in the trap handler requires that=
 the
> TMA has been
>                * allocated, which occurs during CWSR initialization.
> @@ -851,7 +836,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct
> kfd_process *target,
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               pdd->spi_dbg_override =3D pdd->dev->kfd2kgd-
> >set_wave_launch_trap_override(
>                               pdd->dev->adev,
>                               pdd->dev->vm_info.last_vmid_kfd,
> @@ -860,7 +844,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct
> kfd_process *target,
>                               trap_mask_request,
>                               trap_mask_prev,
>                               pdd->spi_dbg_override);
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>               if (!pdd->dev->kfd->shared_resources.enable_mes)
>                       r =3D debug_refresh_runlist(pdd->dev->dqm);
> @@ -887,12 +870,10 @@ int kfd_dbg_trap_set_wave_launch_mode(struct
> kfd_process *target,
>       for (i =3D 0; i < target->n_pdds; i++) {
>               struct kfd_process_device *pdd =3D target->pdds[i];
>
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>               pdd->spi_dbg_launch_mode =3D pdd->dev->kfd2kgd-
> >set_wave_launch_mode(
>                               pdd->dev->adev,
>                               wave_launch_mode,
>                               pdd->dev->vm_info.last_vmid_kfd);
> -             amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>               if (!pdd->dev->kfd->shared_resources.enable_mes)
>                       r =3D debug_refresh_runlist(pdd->dev->dqm);
> --
> 2.25.1

