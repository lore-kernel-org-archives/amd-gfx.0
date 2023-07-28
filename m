Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9353C001E0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B44110E02C;
	Fri, 28 Jul 2023 16:36:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4CE10E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu/CyB53CTgEOXc+5NzfbnjYnuXtpxLkewC3f1xZFKtZpulONpcoChCVxofO20SnQ0hqfpnPSg9nrCtdF6ZWmJ3RCsckurG6Mew4pMvvVwTKLo0MyKttz8LzfjO9JSXdVgGjDsNbr5Xn5Ixw9TuUPU0p3K78tKKle29aV05MihPX0bop43ciPGQtJb9WsE+GWww9IO2ZoB1HHtgdkGlSFNbb3qIDioKhfcsZF+npwBoP34IE36QEROZwBIIQhmKM7alIGOGCSX/irXUlYyq2Hw+YXVjSnroZ22xBTdf/jyInRiQ4JrnR4Kww6iBiIks4GQrXGHpRtr1L/bZEgsQyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW9E39IaFpQvJ6kGPK0oX838lBA8oaWghnG14mkygmM=;
 b=G2a+scaOmZV9PCUOZLbNLptp+s8u5h0IxSar7U7MWnmRxwRn97RXLRqBkUCGX/PWzEiqTTLXouM5ytuF49WYcUcN30lt8TLDLEidXsUIOjVMX1g6s7sFQ+hqkuFKd21s0S2VfWxZvo98GVq1GSR0+iBLzOV7/ydmTb+OBeO4sY8IHr0k4kKnxwPft3gU3RqR5EVx7BGzjIIKNxrQsbFmxL1FHsWT6VFHg5xc/8IWbAmRgQmLf3qfGhbC+0mHaJWM/zVbkwvHlNGguzj21oz+2f9QDwvMc45zzCuDq3cm843mf/W9f2qPfBxIr1Q1lyJ+bZxowoz8unIe1wQ8JEag/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW9E39IaFpQvJ6kGPK0oX838lBA8oaWghnG14mkygmM=;
 b=5PKBqgcf4nz+hUaDVT+yzaRpXBb1pgv/08iy8Xv9RqP+CpyFUqjXutMiirii0Tjbogm90V21tWqk3mXskzNQohLoGqcnm43T/GzIco434o9HfdLMSl1Rp0Im639b1l+xA3c4iui6PaZHjwWcY4erJ5Qyna18Ykz62o8pr9eXi/M=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34; Fri, 28 Jul
 2023 16:36:52 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::2ced:6c4f:9dc7:4a3f]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::2ced:6c4f:9dc7:4a3f%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:36:52 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Messinger, Ori" <Ori.Messinger@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with
 Sysfs
Thread-Topic: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with
 Sysfs
Thread-Index: AQHZwWzVUHdWVN0OrEy1HfgNsaQcV6/PYIHQ
Date: Fri, 28 Jul 2023 16:36:52 +0000
Message-ID: <BL1PR12MB5898D3FEA72AC8FB5A897B288506A@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20230728160029.863681-1-Ori.Messinger@amd.com>
In-Reply-To: <20230728160029.863681-1-Ori.Messinger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=32456cc9-43f6-4416-901b-4ab4126cfc2e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-28T16:36:37Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|SN7PR12MB7297:EE_
x-ms-office365-filtering-correlation-id: 8ad1ee22-354e-4ca8-4e35-08db8f88d94c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZGeYmWZAHB2pqIag6Nyp61IroeWpECopUIFhvWa9Zw2/mv/oG/llrD+K2gaQEL1ilvBc6qEZQn2ml3p+FOUtM6pr1fYZ49H6qvR76o0a5ttc7+WK/4UWyHkLXamEkeZw5VGBPVsL2nd/ykGvBAvPSOIO8jxVS28LqIk4nCkyqPUvVi4kJkt+Iop9252MPGo6l+egIpDa8n6gDvI7xl3EJGnQcrXZktM+8kE2rht250Zr+V463bRFX2MfGnzY8TEVzP++j9V9o0fYK1JukTyCCnO20OCw5im2GZv1PZsu+FwzqMpYbvXn0q0EesszUDQpSvXKfgqJl8FQ254O3nMHIcXai2+TZV4C+uNGm5hWRm8/FXdSTXgnG7YRtx6CD8TW9dX4r0CuXUpm/f68ra58togBiVYBKpDQN7a3Gv63gw3RERwj+/LB2Jo8lMR2MRvrEMWNv1zcT85iLCL8QHjrHm5NqT1tYftFN+OUQLAcS9JaFzoBrRsaqo9VPy9F8uXFu1VojU2P1k161rxTUu6E+IfQmgbPv4djeGtWBWxgTSdmq00HgiBccLjyWpHXuO/2GsA+su8OI/lzvfUBgrX3wEqe1ZvF0BASEjx1fZa03qDf2dVKRSWAw9wmvHUdcDT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(8936002)(8676002)(26005)(110136005)(41300700001)(9686003)(4326008)(316002)(5660300002)(186003)(52536014)(6506007)(53546011)(71200400001)(7696005)(66556008)(66446008)(66476007)(478600001)(66946007)(76116006)(64756008)(33656002)(86362001)(38070700005)(83380400001)(2906002)(38100700002)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2dkdQLsZQIB1mpq1fezsRb24NLj2nzlnhB67jSgl0CxkGIl78BPF1lgAGxst?=
 =?us-ascii?Q?um5zMM5yy65sXsiZyDN3tDbEJEH8NUAvh0YTrnCyeHuAHGNs3b9Z8NMYNHID?=
 =?us-ascii?Q?oYBhkiyVpQsKlu+CZTeO6gvecrVd9SkmR3IlDXlE3D0n58ryz4oMEGzZmyQa?=
 =?us-ascii?Q?8YOcobvmVU2FfDXjta0SWuIi4hkFg4o8uGj9sBXB7FEdKwsti8qcVSNvahLZ?=
 =?us-ascii?Q?xINrK1FZYPxjDHC/iHlX3UisHQtFE6OUpc0DwDX11IJSQEcltiVRjYvX8GWT?=
 =?us-ascii?Q?x3/KjV/8iRs6mIaUWkzz5nAxqWlnLZKOQgmBpcIAl+OvsOm2h7B1k9vpc3NQ?=
 =?us-ascii?Q?SG4620pFBpRLd7IUZ2UzfMRaOctqdqe+3qkOkrJ8Q3OyUjUPMy4ka4EwjTJq?=
 =?us-ascii?Q?BRTEGga7zoUm1PrseKgeDwlLB+aYRzOXqIb7ltOVXCt6H158Bigx82HuW0Nl?=
 =?us-ascii?Q?GTN5ljSsZObm8Px+5w55tl+kbqEow4NVyqguzqd+u+nXZv7pzdZZDTzp9v5d?=
 =?us-ascii?Q?gxL1dT/0wOZKcRP62YrDZmM76OiYKAmgGjDa410hPwHL67tTEMlRsqkzn8Ih?=
 =?us-ascii?Q?tajq5VK6Lb9kwDfNPWEYvyPsl738xfvQTN8Fnf3kmr2Wa3s5aEh1OwY0p+4p?=
 =?us-ascii?Q?1J4tYXb9PSF+2fEGlOyFih0SlR3kKjjjpIuOMtL23LbPVPpvBzBRfIcelBvu?=
 =?us-ascii?Q?hjF5GQ5EoJQVP5QaXxyHldZZMqoGEPljYMCRNaSSwjQKRyWzfZBGXvmyJTdY?=
 =?us-ascii?Q?j1PvJ3ku0wrtuBTSZESkCbLB1RHogE8h4ubsrNGf7puLOOuitlrFPHYv7mpH?=
 =?us-ascii?Q?BDYz027NpA/Ftc0Mi4isVnaD6wjeSE6dniAylzVQlP+myt+UzAF+bZ8Ac+da?=
 =?us-ascii?Q?x8IEbFZvg1FD2a7287wM96XCkzRZS80uhyTKAsQrcK3AVBBMI5dzNCWv0/og?=
 =?us-ascii?Q?kK8Br/qufWoNBo6mYU3Em/UTOHHYTjXqXDWqrnPVcEIZViatED5q6TPVSuBA?=
 =?us-ascii?Q?kLxAucxHmg3N8K2yI+MeBpM/vsjmnIyqpbSveP2baHYVkKIOdXwjUfeVnlHg?=
 =?us-ascii?Q?I4pKslRpso8vksJh94xRAAZFRCcfRcM990x7Q6RGLYx1IPLUfYxliRIfU2HR?=
 =?us-ascii?Q?XaZwuknWvqJilLm4W66kqgrEbwxUi9POdr8IH50iUATNHypwqeJazBWXbQh4?=
 =?us-ascii?Q?vv7AZkMIKDlfCc2oMVSYRFTd9DAmGJfEWTX/mbeWm8rrcPFLRykpf1tPylgg?=
 =?us-ascii?Q?57fO3bb0M98m/YRDfCxwPESwnJNs0DXh/WcZd8cKUzWxy924idvdkQAguU1q?=
 =?us-ascii?Q?mF1+C8ve8L3SqmCgPltrHaMl0gdt9LCXi2DzBhOrgZdejLhfSXU/lpZTyCC2?=
 =?us-ascii?Q?egre7AvxhoCzARbrXS4Y/ZrjikcvzZOrCbQfuNlBtIatNVe9hiqFk1xASx8D?=
 =?us-ascii?Q?VbtzJf92opu+tvgAQxKWvaGVqt2Ay0xAiLUT0ycG+wg14fNzzfpRotyNzxXw?=
 =?us-ascii?Q?jnzf4CZK2+lJVjc426N+TBEAVEFduFY/BllvpjCbVIbouYcpOaWo4yF9UrN+?=
 =?us-ascii?Q?iGw2OmKVr5XsKAuz92Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad1ee22-354e-4ca8-4e35-08db8f88d94c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 16:36:52.6704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kJHQ9pS9t6nGo+0fRLszzTTEy5fAV0+q8iobXCqvbE4+NDjjw16Z91CKcYEisepCVjkoDaEBYqmE+DI9n/UFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297
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
Cc: "Messinger, Ori" <Ori.Messinger@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ori
> Messinger
> Sent: Friday, July 28, 2023 12:00 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Messinger, Ori <Ori.Messinger@amd.com>
> Subject: [PATCH] drm/amdgpu: Report Missing MES Firmware Versions with Sy=
sfs
>
> Added missing MES firmware versions to the 'fw_version' sysfs directory,
> they should now exist as a files named "mes_fw_version" and
> "mes_kiq_fw_version"
> found at:
>
> /sys/class/drm/cardX/device/fw_version/mes_fw_version
> /sys/class/drm/cardX/device/fw_version/mes_kiq_fw_version
> Where X is the card number, and the version is displayed in hexadecimal.
>
> Signed-off-by: Ori Messinger <ori.messinger@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 16807ff96dc9..6a15a84ecfcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -703,6 +703,8 @@ FW_VERSION_ATTR(sdma_fw_version, 0444,
> sdma.instance[0].fw_version);
>  FW_VERSION_ATTR(sdma2_fw_version, 0444, sdma.instance[1].fw_version);
>  FW_VERSION_ATTR(vcn_fw_version, 0444, vcn.fw_version);
>  FW_VERSION_ATTR(dmcu_fw_version, 0444, dm.dmcu_fw_version);
> +FW_VERSION_ATTR(mes_fw_version, 0444, mes.sched_version &
> AMDGPU_MES_VERSION_MASK);
> +FW_VERSION_ATTR(mes_kiq_fw_version, 0444, mes.kiq_version &
> AMDGPU_MES_VERSION_MASK);
>
>  static struct attribute *fw_attrs[] =3D {
>       &dev_attr_vce_fw_version.attr, &dev_attr_uvd_fw_version.attr,
> @@ -711,11 +713,12 @@ static struct attribute *fw_attrs[] =3D {
>       &dev_attr_rlc_fw_version.attr, &dev_attr_rlc_srlc_fw_version.attr,
>       &dev_attr_rlc_srlg_fw_version.attr, &dev_attr_rlc_srls_fw_version.a=
ttr,
>       &dev_attr_mec_fw_version.attr, &dev_attr_mec2_fw_version.attr,
> -     &dev_attr_sos_fw_version.attr, &dev_attr_asd_fw_version.attr,
> -     &dev_attr_ta_ras_fw_version.attr, &dev_attr_ta_xgmi_fw_version.attr=
,
> -     &dev_attr_smc_fw_version.attr, &dev_attr_sdma_fw_version.attr,
> -     &dev_attr_sdma2_fw_version.attr, &dev_attr_vcn_fw_version.attr,
> -     &dev_attr_dmcu_fw_version.attr, &dev_attr_imu_fw_version.attr,

Why did the order change here?

 Kent

> +     &dev_attr_imu_fw_version.attr, &dev_attr_sos_fw_version.attr,
> +     &dev_attr_asd_fw_version.attr, &dev_attr_ta_ras_fw_version.attr,
> +     &dev_attr_ta_xgmi_fw_version.attr, &dev_attr_smc_fw_version.attr,
> +     &dev_attr_sdma_fw_version.attr, &dev_attr_sdma2_fw_version.attr,
> +     &dev_attr_vcn_fw_version.attr, &dev_attr_dmcu_fw_version.attr,
> +     &dev_attr_mes_fw_version.attr, &dev_attr_mes_kiq_fw_version.attr,
>       NULL
>  };
>
> --
> 2.25.1

