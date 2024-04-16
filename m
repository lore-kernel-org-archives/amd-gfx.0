Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDCDC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 05:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A255A112A52;
	Tue, 16 Apr 2024 05:51:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Z0zR3Nm";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5BB112A52
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 05:51:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4ib6CaQTAM+/6MAePPmG05noabhZMh1600T1e/Kllffbl4mJz67b3BDZzgWOE0whw3lHos6AXpocLQTfZUveJTMe/1gIOjGRnMzSHBl9BZeCLOQT89WTT7AGuBO5Ps2hWFn4x6ziHZq34a2dwmTV0WoTJcrxtbBq2GNdtdRGOjqsCXBGHMX0CBSAuo3OZZBtAqCoATPfYiq7qG3RcVpXXmyVIUf52qrCAGqrqnc+EAAV+3mnPEdtzrtGCJyJgs4I64F5j0wH64mBLqiZDK4VeLzhoPBvtHYGvkectuDpDqZhdmzTJUSKJTRB+OkVK5qClgHwboIUoPkz/EeXpZKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I2ntNdnocunSwdSn6P8X+ouVZDx7BniUim4WWx+kATo=;
 b=gFeoR6F5wdcBq3ANwhLWrbgLoQJXpWPPLkm8+XiHTkVonKQLcQ+TSDLSYeKosZYO8CQa8PM9PSpEBH9qjNqmkQdgAwrxSdsrIn9X+qHQOSa2uJIXQB8qR9j1Kw+oCIIuiKmJE5a0CVsa6yzPMLhTmHWnsPMw/leczbrw7GPFxyMrwxLIdpZMH7a3dBkvG0QEDaeSpx4nVvM/OAjGqCLCFDObTyuXczXJPmk9gnGuctIqBwql2oTErjgpV9T3GREa1lP4ayHq90+paRrLADnAfeCqMUX79IKGiPztd2fszHWHLaY78xXhhy8b72hCAUPTQXn0ZKpRR6vTi7aTlKTDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2ntNdnocunSwdSn6P8X+ouVZDx7BniUim4WWx+kATo=;
 b=5Z0zR3NmyE+fbxCX0XWKJL7VCKZBCZbqp9BCsttmnYrqFnak75SQKdTbqyDh6mYNv3P/1JMiE4VvfgSGrbAraIVXsOheLqSxsWWFCTbAnDNaRbzSqNtmDgzNChSXxN+XC1ITeDStOTsw25Cfq+NLzDOEaDgryLsKcbgU5JPznS4=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 16 Apr
 2024 05:51:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 05:51:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison handling
Thread-Topic: [PATCH] drm/amdgpu: Use driver mode reset for data poison
 handling
Thread-Index: AQHaj7dXeP9QIrH4lkKEG2/wQCKKTLFqWMSAgAAMG4A=
Date: Tue, 16 Apr 2024 05:51:53 +0000
Message-ID: <BN9PR12MB5257F0C884FC787CD5C9F70BFC082@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240416043402.987-1-Hawking.Zhang@amd.com>
 <PH7PR12MB8796D4AAD895AF7D58906AF9B0082@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796D4AAD895AF7D58906AF9B0082@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1fc3c7a1-ade4-4191-a943-4eec1ef3d016;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-16T05:08:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB8106:EE_
x-ms-office365-filtering-correlation-id: c9c8fb5e-4662-43bf-b886-08dc5dd95126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 93j+zRxC9J75sKKTwyYN9CM5u874cA5iIN1jO2PTBabse3x8eKcJfsUwRrenTmxsIxfMbYXZ/RotXxlaA7VwI2dWZQR7Wv0prjLzQEA9RTVu4Xr3OzSBLbV6Lq8hURQQxNqvdKJgegIzCiTLNlMdy/UFNDQU6Nejlrmb7VGc1fwVArGYj7/0gOU9CEJEguqKoEwrHWi/KhV3Au9llai9b3TvCMBPg8va4FG/ol86KJABe4qaKQs6p8nGzGxkTZkcXCkSJL+LAuweJ+eAskrXog7qHyNKi3YXi36RbBVZ7wJR1tPMOytB7GQ7JSKobpPzzzANL6Fog4geDPGz95k2vpTjBkOLHD4zH09L7kg6tCpQtU1d22xpaiMPpM2kV4lJ9AlsXmZyZSjPQo82dyyuzF6bAWQ+J4xi0z0epnGQX5D7U54A9xQEPA1vjdD1u4GBW2fLEiiZ41Xr0oLBNQ1LCG7qwHXCs1P0jJ9a+c336DzQbRO7ZWCM4dcvpo1i48eixGoIhkgexxWHujSyU8Hdaf3dMUz20LgDWeTf5+5EfsyQwmJ4ldGpRU17bRok3URuHzT5Cw/8M0Hvcr6smsqjm6lXpOvx1G5KEJUFSFhQUzDDeHiX+7PjA6nGJVTA2aUfnDXUZSHddt58BbRE+MH/slqtVJCzUrxWQw7TInyMSIhDjLOPQkWRr5EqM8Fhxe/k3DpcK4lPxkvmLJ5tid2VDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MdHTRnTOsyjOBgVqqYkwFIOpREWmNveMK/MC+AnaXitaLSEdMW/Cclt9+pha?=
 =?us-ascii?Q?hg96CQEmwNjRfxBnAANTfcX8ZON1TQdjiLql+fOze+OoZTFwQBIMv4387YN4?=
 =?us-ascii?Q?jD4tadebNiomH7TrMSIvllci+zXpyLxytd1IIgPg6Oyj7SbeCebc21Li+JgO?=
 =?us-ascii?Q?gP4GwdN3uUcrbedcZgYPO3rPwtSnZ7UzmfjeW7PbBsQwWIVQiHDRXjDXJmfD?=
 =?us-ascii?Q?hzmUsIp3u+gBoVWBqxFAZErF2UTw3GEjPOcAH+PfbxME+QPuvXV4cgN8RoVg?=
 =?us-ascii?Q?0z2ZImGd985/X9dOPYyA30JcIwtOZoFii5beA1mSLrvEYvSnh9rJOaJ5DcLn?=
 =?us-ascii?Q?0Lp4a13JmIK+mCBLz6g9cqgN/xsBtQnaLhwn/GxI+HCHkx8R2m+xlWTnSL5L?=
 =?us-ascii?Q?ryc9APIQkWnyeg17DBMl+hXkgCuekRwptN4WyuQZJi45IbdPWSOaI6Fet5t7?=
 =?us-ascii?Q?aWZaljZQv28MrnSri0GyM0kq3169SLRptPxTQPzojMlmb0psEZRE/NFxuCp/?=
 =?us-ascii?Q?wR7r4+cCxpZ4hqEvgiO4a0y+hKYkbR6k53KLPTbPrr1/SZBCDbX/2Va+SUhd?=
 =?us-ascii?Q?jfLwkJ8SJlGCWrcdoBlcoT7f/amh3mAS8vEa63bp1WxVkvPF8+eDUx9IVyQs?=
 =?us-ascii?Q?09eO/Djvp93KO/hFMWrKGnpoUXwco4tYrmbFS4Zrow8ros7rCqNs70K+OL7u?=
 =?us-ascii?Q?v1sNYgUDH5hGFYyxLP3zGzwKNJFfoyChGTlKYqOfY9Q6IbpL5AkSiLA2mgue?=
 =?us-ascii?Q?0vxOOYj6+ZTKa4ZrdNVxRpR1kgl3nQG9RNXXhRok3F7TCOP/r0ibe4Tu5hqK?=
 =?us-ascii?Q?08DQh/s7LydhOYfhRrWSGMfc1jqUVKW1NXTbJkH3387VFLw00nxhkGh9Q/Ou?=
 =?us-ascii?Q?ggsfRgaM7jyANZe8T3wIlPdw/Yk+vSqf7nRQg7tXQmThUqAWzYEgl5f2EZJi?=
 =?us-ascii?Q?DDumB2R+PCAcjlqHxO5XofkhH3cCBdELN4UedojpmWVcPxUOtYjCm44xWurJ?=
 =?us-ascii?Q?7ioOp94TmBhwdN/sy3pKh23+8gzB/H5bwhvLRS9YlmirnSy7dm8RKlTCtqI1?=
 =?us-ascii?Q?pOjlzZSIj7sKSHz67lEQz1qhEnwBV7I1loaX+FwINtlG7tcKmHnNLX68yzec?=
 =?us-ascii?Q?cGqOH95Gb38p2W5pxAnXb0w5LS6TeUEXeLe5BTtuSdw6wnEJNwh/1A+ZuNMc?=
 =?us-ascii?Q?VxhTSXD18Ql2mWnEm7ubWY5e8bmlOsJeivniYGWjAeRzabyj5V6wJkwVQOIH?=
 =?us-ascii?Q?j2hBtv0h/vJndUm+WZ1hKen4w9XrzUyexD0JowD2V+sm5mb0+8z4Bklx3Pys?=
 =?us-ascii?Q?8uXHuFw9Y+q/RDIZJF7js9OBgMaME3ui7UNcRKRH68YYD+wdkWjV2plvBHCO?=
 =?us-ascii?Q?n/ogyBg14a17l0p3vjGL0m7CzkoI2zd4QRAa7kIqULd0tiW6n7qWMg78q+O2?=
 =?us-ascii?Q?g2sMzvVguXDllvgdd0TT5jTYfyLLyck343yrik4sOVXQhZNg20qJutlrrZqC?=
 =?us-ascii?Q?4cuPWdOcF4yu5RPfbGx/on4071x6VY8cfXdsRneVtPe1FuhsK4ABkLo0UL2Y?=
 =?us-ascii?Q?nBbPS+DtDgG4e9NLv3og1fGU8kgw5LdRSuPt36uz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c8fb5e-4662-43bf-b886-08dc5dd95126
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:51:53.0225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhfVmDIhpbzwI/YDwvgBzfzYwGey+c76pbhHIxWEe0E2GsRZZfDayjodBkYBhcFQy/Fn4t5t0QltyARSJ+EBgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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

Please ignore this one, will send out a new one

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, April 16, 2024 01:08
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Use driver mode reset for data poison hand=
ling

[AMD Official Use Only - General]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, April 16, 2024 12:34 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison
> handling
>
> mode-2 reset is the only reliable method that can get GC/SDMA back
> when poison is consumed. mmhub requires
> mode-1 reset.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index c368c70df3f4a..b6caf6eda8a0c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -163,17 +163,13 @@ static void
> event_interrupt_poison_consumption_v9(struct kfd_node *dev,
>       case SOC15_IH_CLIENTID_SE2SH:
>       case SOC15_IH_CLIENTID_SE3SH:
>       case SOC15_IH_CLIENTID_UTCL2:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__GFX;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
>               break;
>       case SOC15_IH_CLIENTID_VMC:
>       case SOC15_IH_CLIENTID_VMC1:
> -             ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>               block =3D AMDGPU_RAS_BLOCK__MMHUB;
> -             if (ret)
> -                     reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
> +             reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
>               break;
>       case SOC15_IH_CLIENTID_SDMA0:
>       case SOC15_IH_CLIENTID_SDMA1:
> --
> 2.17.1


