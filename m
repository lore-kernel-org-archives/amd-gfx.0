Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D970FCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 18:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7005810E565;
	Tue, 29 Sep 2026 18:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EDaAI4VJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011012.outbound.protection.outlook.com
 [40.93.194.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9A610E565
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 18:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqeAj1+78DuTixAl8qfiZq5MaVEisBZkJ5LNG0upgx8TYWG1e/vvjktPW4+7DbMuAVsTKSj8LHcYs4kW7dL2mhpMS8rzpAMmOHrzy4DMW3l3yHmDzfIkMInJhigxk7shOXAwR/ysEMyxj3Z5Gp483ne88SAq1JOeiYhSMm0utINZ96qjdY/q46Pa/S2IsJF3wVhgKhxE0XVmESCDwfzKXXATyyT+JjijT6Ivq7eKIbnxmiUnbWIv/c/NdyE0A4x81giqGKSBU+WA/MFz3i0aUSVgUWT9ypOHUearAPSk0Ii+UxNcgwZIxHAl5WngNIGJYqCoNZrwhzrhJBcspR9U0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rx3ntdUteVVTZ6JqUZS3lx4UMZVHr0tx6d0IzwXovAE=;
 b=TV09VZYSuUzwaC2BEMBgMEUJOhpiguS5Ws5rdqIz2i2vuGQwA0a1O5UO4/wrtH5PjAYnXdaV6GewQpfh5u/koWcMiE+OpsFNQ50G7r2g2/u/lqbQXbuN4SdrKzf6J2iSZfqbkVDGkcMnP0W2bb4jGtCL1fqESL65V57MHRGQPINmDaTdaLSARwrU00TT8DbaDXR/yXVGgADn0u6nv7wiVMcE1+OpoAuDv29jceIQoFPPSCzFhTSpmlj+9PjEruTIh/3rokwmAKkL2EcHMekaAwmzDYrj2E3Av09/J/j42qEMGWNdIoQZigbJr85ygaUBJHJsBEuDqpbQZYMqg12Fsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rx3ntdUteVVTZ6JqUZS3lx4UMZVHr0tx6d0IzwXovAE=;
 b=EDaAI4VJ0ZFUBaHL0/tnyqjHGFd6hbWdzuDkX57B3ZTlcXi87Ih/0O//f+NjBXaLHbayDxHFBzv2ZiQsD+Y3lQEGWGaCTsRGybNs1ePBCN8CPYQQ3XCuTY0bSa03ekeZcAuZDkwwBfwGj+rrMoifL8/8/UFn83uWSxDlfPKhmrE=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 18:59:25 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 18:59:25 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nkdmR42IxKkkCaoz9kGWx+t7blQ/QAgAAIdwCAAJ0ulQ==
Date: Tue, 29 Sep 2026 18:59:25 +0000
Message-ID: <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-29T18:59:25.324Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SJ1PR12MB6241:EE_
x-ms-office365-filtering-correlation-id: f45b21d1-6b8b-41f3-002f-08df1e5bc81b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|38070700021|11063799006|4143699003|10067099003|56012099006|8096899003;
x-microsoft-antispam-message-info: 25xFE/kTBF1ExXnOb/b6gpgZWf9hqPdHRm8dBrCtJlauKD0GQq6ezd5e1A3oh5JZOJsuMwBFsQqtAjnr0zf8HkkNLXDFBoZrD7FEKINI6AkZL7Hxhpx15FXBJ0fWsVU7vKmEdan1uPStqqMqlpUPwk2AYeWIMehEjmAa2Q0DhbfmzhjJGEbMJ1dOX+xxyrlgp91+FjZM15uwnTFQ8s+QcDZY1YzVribdW3uxdifFRkkIg6UjyaDqWtGJZYxy2i3hzAthPzebfuLruENY74yv3Ti1IQBFlGkv+n7bgZdJavO0wA5yORsUr0m53s87XqzaDl8waAf14r6xPKfwOsoaEx4jZZqLhxJKCVnZRlyrWJ18IZWTOfzfChVs7eWIKA07Ktk1UZr6iYaZTBR/wfIJPfjDcprGW6p5r7VGcHtheGj5lHsgaWpGw5bPSVVYW7a6luxE+vFVhTL0mgATJ74I10Q604trTk8JLmzwZnc1xvGRXVBhMCsSsWJDMlEHLU6mVRAExjFedxAaF43SnoKYh/tg8bCerlZhS4K0tgQPa4vLSgcgzQGMq1dHiIliKddXRWfgIcIOGcvqllGKHcfVTv0lWDWuad8ZYV1qOEkWKNumc+QuUe28sRFO3DIeQXAJ/W299ltFFGRTDI+0HJduNSf/aEVKIppEAMQPtlhcSUuECn6VIlxaccbx93euJd07korAhOKHd9tAvQw1T+/4LKnbQncfyPE1wrz9dzxPWJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(10067099003)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?29x1HUgwkqUDjq08gcIWT6ptiboqNalbb0FCwkLhxrHkUQ0g3abLkPae?=
 =?Windows-1252?Q?p9IwPMpJrSxPbAvK8LReHEuJIhpQ3HaDxNcNxPwfsAzstW7smwrCcB9T?=
 =?Windows-1252?Q?TKmwxlL37o3bG5cc0wfAaqHZMfOU/iwYwmiVvWJLen27uXi1ZEiZXhkW?=
 =?Windows-1252?Q?49HrMbsir7UiH1R/Q5O3rmeN3ZQPSPJR4vD/HGHv1qGgQD0jK717snqv?=
 =?Windows-1252?Q?m1HRVzY5ORZ2UWAPTxncr02qLj98KsIMs9l1wB3eMHuOc2mnCW7Dt5PR?=
 =?Windows-1252?Q?s9NYegkE2h0E5gMkR1TcQB68SgP41lEv3rnTKXSlnRm2q1uzIGm8cV2l?=
 =?Windows-1252?Q?2L7u3Nh7U23iyfcZDzGW8sOmnDS0bdTVXYgaXY9+1oGF87Li/6GYThbn?=
 =?Windows-1252?Q?pjnr3GqJ8FdssIyoHNtWrORIIkps7LFWM0geRT8V7VKbSAatGa40beMb?=
 =?Windows-1252?Q?UpKdRHcuFWMYoe6tLMfTciQ1ixqZxWW2urNasSSHmnXzOB8Z+6Wklb7p?=
 =?Windows-1252?Q?C0naq/cxoV8pzzmWm47+nJwPr1wH1BbTEIohlZOtuC3Fp5gxjBUAL3Zv?=
 =?Windows-1252?Q?W9lLgHNPquElseoljuWh0JillgWfaZPQOuwbRUFh7a3PEtteKktVAy6k?=
 =?Windows-1252?Q?2zp9dm7AfV8z9LxkxTWoUI0gq/hvmnk6i/RzSEXrFfXFINrJCvoqtljO?=
 =?Windows-1252?Q?GZPjzT/QGTzPkETomm37BOfZxhIUaiY7SnO58RnG0uKWiAWr3ejPv9/r?=
 =?Windows-1252?Q?asC2Hx+eKBgc5f40fCBrfs4Uvu4NfZqPIIKFb9tOQ37q9GmGO6QQnO5o?=
 =?Windows-1252?Q?UpXb2IuJR3toSXsleU2y0QMWgWfdYGUA2qgZHHYCpN8WcFCaKNEZ0QfH?=
 =?Windows-1252?Q?siofNTT8nMpjbT7rSEQR7CzuDYEjieOKrkmTh2BaidHkyO8p6Dp2TTv5?=
 =?Windows-1252?Q?ga2Op1O4Dthtok8q4GNXI1LwquWe7wAeZVOGYcVXzLcDMD2vvjymwPBb?=
 =?Windows-1252?Q?u3LfIrvX4XKSqkjhc0+he12qnLnL4hefEjDaMSS6Q0032M3bFkJWh1Wh?=
 =?Windows-1252?Q?JTG8NSO6vqNj7+icG2bRubrcc4IdmYCZIS3JIuxQ8SRrdLPDHCzIdnMO?=
 =?Windows-1252?Q?YafICASTef2k8gYV0/rTODYpgn3w8vwU0ldGzOvF/icfRsdtTZr01LaT?=
 =?Windows-1252?Q?9VkbhwMhTG0j41mxhVQcP3ORtxAAV8ewHhI1v6t4G2Yozesjufgxqj5c?=
 =?Windows-1252?Q?Wj+cIaI0mw3pLqj9imMwGAGdsheXOlyGu/HDkUfV+MwK7oHCAV4CkkQN?=
 =?Windows-1252?Q?2hC1VIbYkvaB1HAT9w3dWH4IO970wXTIEtIWd8hfpfWcPy+NBUvi3CWg?=
 =?Windows-1252?Q?5xIyGuEZyNQBH6C6MKYqGCWktT4fYoqqD/6OSUsmlpN3DcQYdO9RKKP9?=
 =?Windows-1252?Q?A62K06M2zYU2PskUDYBYmNrujz29iGNtMAlT7gvFBLZlVcKRgXhXmlCI?=
 =?Windows-1252?Q?Lq/hqKhZ+oW+5FT8sYni5e2a2578ZT+nGAsFGuSEX4DAkOpWz1Oi8ZJj?=
 =?Windows-1252?Q?6vuz1OVmyTbYeTOlDrzXLpgg2dP4MO8ToJD3inVjoa4wEkbvrfK6fipM?=
 =?Windows-1252?Q?oKQvO5a/wos7xMkYL/fXxYan/AeIUA83vtBl+xyZfZhQ9xReCYmTvVG6?=
 =?Windows-1252?Q?RQMTCFrTb4qZotxg1voUxTSD8dGfWQ7+ZE8YJJU5oR+u3URv04KzvaAJ?=
 =?Windows-1252?Q?NETKdvlTd4a1B58QBXqAdeQipZ/HwjYMK62D6ljsa6Kz8QpWoTl6IeyX?=
 =?Windows-1252?Q?64cHYRKoK6voFDIQTqEQHcjRIv78b6Nv0jlRNTUWCoDn2tN1?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5146D08AFE80E7E6EE34B614F78C2BN9PR12MB5146namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b21d1-6b8b-41f3-002f-08df1e5bc81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 18:59:25.7861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edc2J8wxpHduN/lRuCBksBzeo+6jAhptuACG2Ba5DDidAoZduu+QjaAP2069oTtHjF4xHN4DYrm4i0E8n9/Lgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
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

--_000_BN9PR12MB5146D08AFE80E7E6EE34B614F78C2BN9PR12MB5146namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Public

I think this should be asic agnostic.  Any asic doing mode1 reset should do=
 this?

Alex

________________________________
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Tuesday, September 29, 2026 5:36 AM
To: Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop=
.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Perry <Perry.Yuan=
@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

Public

Hi Christian,

The no_hw_access flag was first set in commit 0de604d0357d0d22cbf03af1077d1=
74b641707b6. This was intended to fix the Mode 1 reset hang, but it proved =
insufficient.
I think the flag was set in the SMU code so that it would apply only to SMU=
13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.
I=92m not sure whether we can drop the no_hw_access flag after disabling PC=
I_COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need anothe=
r round of stress testing to confirm that the flag is no longer needed. Sho=
uld we remove no_hw_access in a separate patch?

Best Regards,
Yifan

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Tuesday, September 29, 2026 5:06 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yuan, Perry <Perry.Yuan=
@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

On 9/29/26 04:25, Yifan Zhang wrote:
> block GPU PCI bar access during mode1 reset on gfx12, to resolve the
> random mode1 reset hang issue.

Interesting idea, that is much simpler than trying to mess with CPU page ta=
bles in the GPU reset path.

The only downside I can see is that we now drop VRAM and doorbell writes, b=
ut I think that won't matter since VRAM is lost by a mode1 reset anyway.

MMIO writes are dropped as well which means that we can also drop the no_hw=
_access flag.

And BTW the SMU code should absolutely *NOT* touch that no_hw_access flag i=
n any way. Who added that there?

Regards,
Christian.

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
> ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 072d9c4e202d..25b9085ead71 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct
> smu_context *smu,
>
>  static int smu_v14_0_2_mode1_reset(struct smu_context *smu)  {
> +     struct amdgpu_device *adev =3D smu->adev;
> +     u16 saved_cmd, cmd;
>       int ret =3D 0;
>
>       ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
> -     if (!ret) {
> -             if (amdgpu_emu_mode =3D=3D 1) {
> -                     msleep(50000);
> -             } else {
> -                     /* disable mmio access while doing mode 1 reset*/
> -                     smu->adev->no_hw_access =3D true;
> -                     /* ensure no_hw_access is globally visible before a=
ny MMIO */
> -                     smp_mb();
> -                     msleep(1000);
> -             }
> +     if (ret)
> +             return ret;
> +
> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
> +     cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
> +
> +     if (amdgpu_emu_mode =3D=3D 1) {
> +             msleep(50000);
> +     } else {
> +             /* disable mmio access while doing mode 1 reset*/
> +             smu->adev->no_hw_access =3D true;
> +             /* ensure no_hw_access is globally visible before any MMIO =
*/
> +             smp_mb();
> +             msleep(1000);
>       }
>
> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
> +
>       return ret;
>  }
>


--_000_BN9PR12MB5146D08AFE80E7E6EE34B614F78C2BN9PR12MB5146namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
Public</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I think this should be asic agnostic.&nbsp; Any asic doing mode1 reset shou=
ld do this?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Yifan &lt;Yifa=
n1.Zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, September 29, 2026 5:36 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; amd-gfx@list=
s.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Yuan, Perr=
y &lt;Perry.Yuan@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode=
1 reset on gfx12</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">Public<br>
<br>
Hi Christian,<br>
<br>
The no_hw_access flag was first set in commit 0de604d0357d0d22cbf03af1077d1=
74b641707b6. This was intended to fix the Mode 1 reset hang, but it proved =
insufficient.<br>
I think the flag was set in the SMU code so that it would apply only to SMU=
13/14 ASICs, without affecting the Mode 1 reset process on other ASICs.<br>
I=92m not sure whether we can drop the no_hw_access flag after disabling PC=
I_COMMAND_MEMORY. The PCI hang occurs intermittently, so we may need anothe=
r round of stress testing to confirm that the flag is no longer needed. Sho=
uld we remove no_hw_access in a separate
 patch?<br>
<br>
Best Regards,<br>
Yifan<br>
<br>
-----Original Message-----<br>
From: Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
Sent: Tuesday, September 29, 2026 5:06 PM<br>
To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Yuan, Perry &lt;P=
erry.Yuan@amd.com&gt;<br>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12<br>
<br>
On 9/29/26 04:25, Yifan Zhang wrote:<br>
&gt; block GPU PCI bar access during mode1 reset on gfx12, to resolve the<b=
r>
&gt; random mode1 reset hang issue.<br>
<br>
Interesting idea, that is much simpler than trying to mess with CPU page ta=
bles in the GPU reset path.<br>
<br>
The only downside I can see is that we now drop VRAM and doorbell writes, b=
ut I think that won't matter since VRAM is lost by a mode1 reset anyway.<br=
>
<br>
MMIO writes are dropped as well which means that we can also drop the no_hw=
_access flag.<br>
<br>
And BTW the SMU code should absolutely *NOT* touch that no_hw_access flag i=
n any way. Who added that there?<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c&nbsp; | 29<br>
&gt; ++++++++++++-------<br>
&gt;&nbsp; 1 file changed, 19 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; index 072d9c4e202d..25b9085ead71 100644<br>
&gt; --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c<br>
&gt; @@ -2078,21 +2078,30 @@ static int smu_v14_0_2_set_df_cstate(struct<br=
>
&gt; smu_context *smu,<br>
&gt;<br>
&gt;&nbsp; static int smu_v14_0_2_mode1_reset(struct smu_context *smu)&nbsp=
; {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; u16 saved_cmd, cmd;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_cmn_send_debug_smc_msg=
(smu, DEBUGSMC_MSG_Mode1Reset);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (!ret) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(50000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable mmio access =
while doing mode 1 reset*/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu-&gt;adev-&gt;no_hw_=
access =3D true;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ensure no_hw_access =
is globally visible before any MMIO */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smp_mb();<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1000);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_read_config_word(adev-&gt;pdev, PCI_COMM=
AND, &amp;saved_cmd);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D saved_cmd &amp; ~PCI_COMMAND_MEMORY;=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-&gt;pdev, PCI_COM=
MAND, cmd);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_emu_mode =3D=3D 1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(50000);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* disable mmio access while doing mode 1 reset*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smu-&gt;adev-&gt;no_hw_access =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* ensure no_hw_access is globally visible before any MMIO */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; smp_mb();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; msleep(1000);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; pci_write_config_word(adev-&gt;pdev, PCI_COM=
MAND, saved_cmd);<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5146D08AFE80E7E6EE34B614F78C2BN9PR12MB5146namp_--
