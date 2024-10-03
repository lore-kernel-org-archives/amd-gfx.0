Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FE3CF34B9
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 19:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A90510E22E;
	Thu,  3 Oct 2024 19:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ofp79nXh";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AAD10E0EE
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 19:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lk8v0lefTwTkGSon7Ug+0gxXEgmwG+brtiMjaGmDOY87Wyzqu2NSY9JLTxG+U2vaskSb9lsTIv4FBVCLSn10PVCPIubJsg5DsUY64eCvUQSADegQ7i6I/bN6XgAhHjVvGAzIwtZPqdLhwerxXM9l2RkBNofgtFEexBusOQygqx3rHg29ZmJX+14dgkLlLmbPuSSJB9n7XRBbmBFFlNePQrQp4GnyQVrbcPPYnD0bl7Qn02+P7BBam8zh0BoHq/nyY8bstP57TDRZnmSOGyHCCRkz6IQ7TheKCJm66EPsEwXpIB+mFzqL6ZxsyB6Ief7dqTnu43PCl0uVCpUSw9uWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7U8NwngxhkTNPj6pyEEba3HMiokseRMhiiORfSmphs=;
 b=ibCI7Kn3rHGebGQsW9uJBOzUfG1AgULggUGn22Tk3dwZLu96eJXy/6ZnRpubETgBDDXlHTRPuJGGCDvXehaxQrio4CKgyMALX6EksHVUyK+74zP1ql4CDqaNb4TtEE9hPjlJrpkdZvcnQNq7CB07M6hWJzr31ZRePTeLhNfBPIaWphes2NQFe39Jkdov9VGyY548QBOKMUVBS3hFneaGxX9RQQRCN2lQ+VVr7TlzIYlwnzcJiYgoBsPMq/0+kSjSa33ci0ArnIleDfl7VOKBOdUSJ0MfVQoAfo4oPyGbTd7ARBf55upMUh9mSjb/qTIFNbMiG+/YJCeOh78xZAL4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7U8NwngxhkTNPj6pyEEba3HMiokseRMhiiORfSmphs=;
 b=Ofp79nXhw75iOkpjaMkacy4y91lb+E3Z/gMZtJ6E+MFWBA93UPmOuF+H5wnHR+DUasqT/nO0PC+kmoRrAjB0uhQh7/OSMMECrFv1Nx4iEK2+pyxmQuceytpiuLNkuF+yBafCebrc0frD8NUzNvnITOKfiylcx6+scBSIkyJQ8ig=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.15; Thu, 3 Oct 2024 19:40:04 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.8005.026; Thu, 3 Oct 2024
 19:40:04 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Six, Lancelot" <Lancelot.Six@amd.com>, "Belanger, David"
 <David.Belanger@amd.com>, "Somasekharan, Sreekant"
 <Sreekant.Somasekharan@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Move gfx12 trap handler to separate file
Thread-Topic: [PATCH] drm/amdkfd: Move gfx12 trap handler to separate file
Thread-Index: AQHbFcrkeA77Nt1zI0e784LC/4k/arJ1a0cw
Date: Thu, 3 Oct 2024 19:40:04 +0000
Message-ID: <CY8PR12MB743549A37E6AF72FF7192DC485712@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20241003193127.723149-1-jay.cornwall@amd.com>
In-Reply-To: <20241003193127.723149-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=71c5318f-9a2f-4bdb-8b4e-21c354a0ca3e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-03T19:36:30Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DM4PR12MB5769:EE_
x-ms-office365-filtering-correlation-id: 06669523-851c-4c25-f9b3-08dce3e32dad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+r/bU+3ZG9nF/5Zy6KG8LsFNwqsJVv/YE/AOHxyCU6x4Pti1z8entawo0tML?=
 =?us-ascii?Q?0BkDoxskCMjiaDsMGdDFVj8YetzJXj9zjMzUjzXLnf7cUZx7nlLRbCxmFoZI?=
 =?us-ascii?Q?8kp7x4Dp0c4gYGdA1NL4qWnhWhMqt2J1bf9M6lwBg0H4iuYw2H9Pdp9B4R8E?=
 =?us-ascii?Q?vHWdCsBe7MAUngLXt0cyVk7+c7B9QxCV6meO8mxc6/JIPyVUCZ7568G/2OG+?=
 =?us-ascii?Q?X6TkWFfv1Nfr20aZ47y3D6uMcYOJ/Ug9LP6XL9Rpdz1elUEU2IrbPdpgalDS?=
 =?us-ascii?Q?vItCFs+f+d3ufAOyvKrnr+QOqFtbZCC3myBtY1sLo/iF1CPkUPzVyh5jnAil?=
 =?us-ascii?Q?a3J3lYH77WjBkgYzoSZ+YqSY3Bvx2bjnZCb32cpvmKTiJbOIYAgEMMxyiL9V?=
 =?us-ascii?Q?nVgIPCmYg8ZSrLwY204P54aWiMY97zgFKtNOmpmwMjZJEbFq6Fqk4vkobZBu?=
 =?us-ascii?Q?2W6l9WqtKISRXvP9Z2zFNtLcp7Bcc1pz0HIFXW6+vEmZsneEy2QbvZ7gT+Ej?=
 =?us-ascii?Q?WzhEcXRkxstkT3n6x8oY/YYQoq+xM8jmpoRr725B4F8q90s+C76dcdlQ7cJu?=
 =?us-ascii?Q?E22vLIpkJlwB9Uqj8uXMeixoz2QQ73eeF/cYGT/yD2qI4bZFAkx9erG8/hru?=
 =?us-ascii?Q?IVGbOz/7Ck6+VpRy7HiY2laFndudPPwDVFKFdNy62VPutqCXXcyuozvzs05q?=
 =?us-ascii?Q?tRUO48SQMcNVseezFOJKmnsmqvrNnKbsij/JjlbfC9oQAHSpNo1D2TdI9h1k?=
 =?us-ascii?Q?SDs5dRgqIPMI/H8v0bf6iMjqd9h87wIsRWzz1zTDh2qgXqnGQFXCoDNPopwU?=
 =?us-ascii?Q?E4HNsfalYHut4z6jsTyQfQp/tIL5q8ymCWWTL1apTKXmTAEHLsStk/Q7vHiQ?=
 =?us-ascii?Q?tF6/dX1FSSrnRPDbUNgLFDPGvgbv10IBe7v5Xa6XSEKUceR29AhEfT4eDQ1w?=
 =?us-ascii?Q?FR9RDfSTcHarjmT87iiiHyqdV6ri86WwQBUDw6UFWdoeJRm96WqoQuWvWUkD?=
 =?us-ascii?Q?eNGMxjeRb2gqCCwWbsnbvyhvpmLTMbF5QMpprq7F6Pc8C1FA+xHoD9lDU7LR?=
 =?us-ascii?Q?SrIp6kn42b5BVTGKplzSgL6C8LNK7t+AYDCrijy0ryYYcZYNuGPBQizth8SB?=
 =?us-ascii?Q?qOjSIbsQ+PoCkNTol1M/RzZy/u5L+PePqLEHZ8K3KQgeRE3itjna73UdjNpn?=
 =?us-ascii?Q?XLIaH8uoVWrn6hGrlzsHqC08n9Bp+U1v9Txox0KPjGYa5scNNM8AsM3zKr29?=
 =?us-ascii?Q?98m60LuMYJufSbxweYyEQx+jed2ouaTEkbyzsctbRaWcv2cxPDuPmXh7dOy1?=
 =?us-ascii?Q?AKih9r+HsmFsoEO2Ht/C02Y/KFyYWCzjG6ot/oYo1ldsaw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4iWhKGSRWubYKc1Pxw105Lx2QKuFkwB89H6P8JBXIqAV/zv5hatMVylquPFw?=
 =?us-ascii?Q?d70h0vyJAII8EP8ovxx5dHSMFT4ZXynw/g907w/sur+IJTlePiamneO19MNk?=
 =?us-ascii?Q?DBBurTSSyvMzwc6vqk+rwnfByouINeY2uZsO8myugG/MwrUKJNh/IsTzamr+?=
 =?us-ascii?Q?ynySC/6pBgGk/9wfA/A0j0RHtY8MpeztRxM6hZuBjzjM8jz4b9tJ0LFdeBRx?=
 =?us-ascii?Q?/wIphet92PFQXKWvtOe2sNEUEzfTVF3mL9sm5sTRYdP8lmgtp63+e5HpQwBA?=
 =?us-ascii?Q?/7g1PSwU6uSaM7IpXId7p1u1W2bCQyxsdhbBJgs8cRUSsv4cMEwqGo79oApq?=
 =?us-ascii?Q?2Y4Yntah9fcm7OXwbuIaHQ+rVH/UtYSPAGNtK51HgZUY4mlT+XqPY2MForPL?=
 =?us-ascii?Q?V1cm9acAHoUb2h8htPgLqOfCVAvycD562hnvuWe58F5GxejsBGVKgIvS96sM?=
 =?us-ascii?Q?rbJbkqB7/n8wk3zzZVEN47KZj0W8KjzBJQUVS3AAPAgMMpJDvkyRAXk16tZX?=
 =?us-ascii?Q?HKiwM0osmCmLluJMYjgh2xarb+o+oM0AC/cxznzGexYgDz2K3RbLz7W8R4ul?=
 =?us-ascii?Q?FAODMJQhHdLvJTa5hSHrJERbJTgLyBCfq3g7PllT4poCm+cNdxXSKXu35svx?=
 =?us-ascii?Q?Bz9VFY5CwNuXNddxCH9Orfgq0nBtdokodp0E6F9F09ld5jCDlchowLmEkw5l?=
 =?us-ascii?Q?846U+7+p5JcSSa08eNrIzp+COyOuichaeCCdML+llUfm4QlaOirM5vWg7AXH?=
 =?us-ascii?Q?wks/52ACEnK5CM6LIhh9PHqFea6Gnz5u2+zCp1m5SERdDtQL2UPsUZ8uORRw?=
 =?us-ascii?Q?XXjPh+BBcOlTwWTiEhkZAcY7Cwzuzw31RWav4FR691YtZKKi02+wLcZIRzrG?=
 =?us-ascii?Q?74EfyuVv45ST9aQlgxXXkFF/pc1qL/JjZVNl6J62/pCTO1+xVRBYx4Q3gHbH?=
 =?us-ascii?Q?8E5O+rQViRR0aA1mzFpJiQhj6SFdzkHNWGQTCzBv/hP5/U6jf4L72xPhAtiq?=
 =?us-ascii?Q?I94Gx6u6rKYgnLJMArazJw92MRh5AIWBfbmaIPN3KFR/iXirVYLB88BZSbO2?=
 =?us-ascii?Q?ld3SM2Z6SrprGaEnjTq+85EMuuUmkKxZ1fzJkvCz3+B3qdG/l8FShzzgO5uw?=
 =?us-ascii?Q?Gzih6E1c8twoIohziXOgjKWbfVHftfor3m6O0fq9ShoanpP7vbvhw9wI1Nni?=
 =?us-ascii?Q?Vh1raK23GozmpZltI2kimjtKy5WBLkqsvmMz6qnudmIwXcAFglr66/AbY0MM?=
 =?us-ascii?Q?BAXs+VXPP5MWo3jNVCtgoyWmXnD78rC0ZgsqnorUBY52WzKBAXQsSj9ok6Gw?=
 =?us-ascii?Q?bAH66hFdp5TQz7h8Kh1wfcbPrkfjcPxZqJo5qhuPIHXNT3j+So/gcMViU2bv?=
 =?us-ascii?Q?C46sqX663APkJ1fy04A831icDy0A1XAYylZ8Hr+qBY4Awq0of2P9hR15oalX?=
 =?us-ascii?Q?Z5lL5VhV0jbPnfTd9oc2Bw997UMw3LA6oyQlgHrOuraP0b0fKevevKedGpnS?=
 =?us-ascii?Q?BFY3tBlFq3TaR5H7PwYg1SUmhL6t8tRK7qwKhs6GLWOHTN0T/fH5Rhjdd0Qd?=
 =?us-ascii?Q?vJg75R7x7kUK/PMGJ9M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06669523-851c-4c25-f9b3-08dce3e32dad
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 19:40:04.2887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gH4TPqvF2ZMKgB96LmfAiTJXlPoJr79jiWxr2DB3E7Y28En9tJe83Xl/2RRRxujD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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

[Public]

+ David/Sreekant for KFD impact

Acked-by: Jonathan Kim <jonathan.kim@amd.com>

> -----Original Message-----
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: Thursday, October 3, 2024 3:31 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Six, Lancelot
> <Lancelot.Six@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: [PATCH] drm/amdkfd: Move gfx12 trap handler to separate file
>
> gfx12 derivatives will have substantially different trap handler
> implementations from gfx10/gfx11. Add a separate source file for
> gfx12+ and remove unneeded conditional code.
>
> No functional change.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Jonathan Kim <jonathan.kim@amd.com>
> ---
>  .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  202 +--
>  .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    | 1128 +++++++++++++++++
>  2 files changed, 1129 insertions(+), 201 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.as=
m
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index 44772eec9ef4..96fbb16ceb21 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -34,41 +34,24 @@
>   *   cpp -DASIC_FAMILY=3DCHIP_PLUM_BONITO cwsr_trap_handler_gfx10.asm -P=
 -
> o gfx11.sp3
>   *   sp3 gfx11.sp3 -hex gfx11.hex
>   *
> - * gfx12:
> - *   cpp -DASIC_FAMILY=3DCHIP_GFX12 cwsr_trap_handler_gfx10.asm -P -o
> gfx12.sp3
> - *   sp3 gfx12.sp3 -hex gfx12.hex
>   */
>
>  #define CHIP_NAVI10 26
>  #define CHIP_SIENNA_CICHLID 30
>  #define CHIP_PLUM_BONITO 36
> -#define CHIP_GFX12 37
>
>  #define NO_SQC_STORE (ASIC_FAMILY >=3D CHIP_SIENNA_CICHLID)
>  #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)
>  #define HAVE_SENDMSG_RTN (ASIC_FAMILY >=3D CHIP_PLUM_BONITO)
>  #define HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
> -#define SW_SA_TRAP (ASIC_FAMILY >=3D CHIP_PLUM_BONITO &&
> ASIC_FAMILY < CHIP_GFX12)
> +#define SW_SA_TRAP (ASIC_FAMILY =3D=3D CHIP_PLUM_BONITO)
>  #define SAVE_AFTER_XNACK_ERROR (HAVE_XNACK && !NO_SQC_STORE) //
> workaround for TCP store failure after XNACK error when ALLOW_REPLAY=3D0,=
 for
> debugger
>  #define SINGLE_STEP_MISSED_WORKAROUND 1      //workaround for lost
> MODE.DEBUG_EN exception when SAVECTX raised
>
> -#if ASIC_FAMILY < CHIP_GFX12
>  #define S_COHERENCE glc:1
>  #define V_COHERENCE slc:1 glc:1
>  #define S_WAITCNT_0 s_waitcnt 0
> -#else
> -#define S_COHERENCE scope:SCOPE_SYS
> -#define V_COHERENCE scope:SCOPE_SYS
> -#define S_WAITCNT_0 s_wait_idle
> -
> -#define HW_REG_SHADER_FLAT_SCRATCH_LO
> HW_REG_WAVE_SCRATCH_BASE_LO
> -#define HW_REG_SHADER_FLAT_SCRATCH_HI
> HW_REG_WAVE_SCRATCH_BASE_HI
> -#define HW_REG_GPR_ALLOC HW_REG_WAVE_GPR_ALLOC
> -#define HW_REG_LDS_ALLOC HW_REG_WAVE_LDS_ALLOC
> -#define HW_REG_MODE HW_REG_WAVE_MODE
> -#endif
>
> -#if ASIC_FAMILY < CHIP_GFX12
>  var SQ_WAVE_STATUS_SPI_PRIO_MASK             =3D 0x00000006
>  var SQ_WAVE_STATUS_HALT_MASK                 =3D 0x2000
>  var SQ_WAVE_STATUS_ECC_ERR_MASK                      =3D 0x20000
> @@ -81,21 +64,6 @@ var S_STATUS_ALWAYS_CLEAR_MASK                     =3D
> SQ_WAVE_STATUS_SPI_PRIO_MASK|SQ_WAVE_STATUS_E
>  var S_STATUS_HALT_MASK                               =3D
> SQ_WAVE_STATUS_HALT_MASK
>  var S_SAVE_PC_HI_TRAP_ID_MASK                        =3D 0x00FF0000
>  var S_SAVE_PC_HI_HT_MASK                     =3D 0x01000000
> -#else
> -var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK =3D 0x4
> -var SQ_WAVE_STATE_PRIV_SCC_SHIFT             =3D 9
> -var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK         =3D 0xC00
> -var SQ_WAVE_STATE_PRIV_HALT_MASK             =3D 0x4000
> -var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK               =3D 0x8000
> -var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT              =3D 15
> -var SQ_WAVE_STATUS_WAVE64_SHIFT                      =3D 29
> -var SQ_WAVE_STATUS_WAVE64_SIZE                       =3D 1
> -var SQ_WAVE_LDS_ALLOC_GRANULARITY            =3D 9
> -var S_STATUS_HWREG                           =3D
> HW_REG_WAVE_STATE_PRIV
> -var S_STATUS_ALWAYS_CLEAR_MASK                       =3D
> SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_E
> RR_MASK
> -var S_STATUS_HALT_MASK                               =3D
> SQ_WAVE_STATE_PRIV_HALT_MASK
> -var S_SAVE_PC_HI_TRAP_ID_MASK                        =3D 0xF0000000
> -#endif
>
>  var SQ_WAVE_STATUS_NO_VGPRS_SHIFT            =3D 24
>  var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT         =3D 12
> @@ -110,7 +78,6 @@ var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT              =3D
> 8
>  var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT                =3D 12
>  #endif
>
> -#if ASIC_FAMILY < CHIP_GFX12
>  var SQ_WAVE_TRAPSTS_SAVECTX_MASK             =3D 0x400
>  var SQ_WAVE_TRAPSTS_EXCP_MASK                        =3D 0x1FF
>  var SQ_WAVE_TRAPSTS_SAVECTX_SHIFT            =3D 10
> @@ -161,39 +128,6 @@ var S_TRAPSTS_RESTORE_PART_3_SIZE                =3D
> 32 - S_TRAPSTS_RESTORE_PART_3_SHIFT
>  var S_TRAPSTS_HWREG                          =3D HW_REG_TRAPSTS
>  var S_TRAPSTS_SAVE_CONTEXT_MASK                      =3D
> SQ_WAVE_TRAPSTS_SAVECTX_MASK
>  var S_TRAPSTS_SAVE_CONTEXT_SHIFT             =3D
> SQ_WAVE_TRAPSTS_SAVECTX_SHIFT
> -#else
> -var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK   =3D 0xF
> -var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK     =3D 0x10
> -var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT        =3D 5
> -var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK =3D 0x20
> -var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK =3D 0x40
> -var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT        =3D 6
> -var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK    =3D 0x80
> -var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT   =3D 7
> -var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK   =3D 0x100
> -var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT  =3D 8
> -var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK     =3D 0x200
> -var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK      =3D 0x800
> -var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK                =3D 0x80
> -var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK   =3D 0x200
> -
> -var S_TRAPSTS_HWREG                          =3D
> HW_REG_WAVE_EXCP_FLAG_PRIV
> -var S_TRAPSTS_SAVE_CONTEXT_MASK                      =3D
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> -var S_TRAPSTS_SAVE_CONTEXT_SHIFT             =3D
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
> -var S_TRAPSTS_NON_MASKABLE_EXCP_MASK         =3D
> SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK          |\
> -
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK      |\
> -
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK         |\
> -
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK        |\
> -
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK          |\
> -
> SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
> -var S_TRAPSTS_RESTORE_PART_1_SIZE            =3D
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
> -var S_TRAPSTS_RESTORE_PART_2_SHIFT           =3D
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -var S_TRAPSTS_RESTORE_PART_2_SIZE            =3D
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT -
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -var S_TRAPSTS_RESTORE_PART_3_SHIFT           =3D
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
> -var S_TRAPSTS_RESTORE_PART_3_SIZE            =3D 32 -
> S_TRAPSTS_RESTORE_PART_3_SHIFT
> -var BARRIER_STATE_SIGNAL_OFFSET                      =3D 16
> -var BARRIER_STATE_VALID_OFFSET                       =3D 0
> -#endif
>
>  // bits [31:24] unused by SPI debug data
>  var TTMP11_SAVE_REPLAY_W64H_SHIFT            =3D 31
> @@ -305,11 +239,7 @@ L_TRAP_NO_BARRIER:
>
>  L_HALTED:
>       // Host trap may occur while wave is halted.
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_and_b32       ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
> -#else
> -     s_and_b32       ttmp2, s_save_trapsts,
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
> -#endif
>       s_cbranch_scc1  L_FETCH_2ND_TRAP
>
>  L_CHECK_SAVE:
> @@ -336,7 +266,6 @@ L_NOT_HALTED:
>       // Check for maskable exceptions in trapsts.excp and trapsts.excp_h=
i.
>       // Maskable exceptions only cause the wave to enter the trap handle=
r if
>       // their respective bit in mode.excp_en is set.
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_and_b32       ttmp2, s_save_trapsts,
> SQ_WAVE_TRAPSTS_EXCP_MASK|SQ_WAVE_TRAPSTS_EXCP_HI_MASK
>       s_cbranch_scc0  L_CHECK_TRAP_ID
>
> @@ -349,17 +278,6 @@ L_NOT_ADDR_WATCH:
>       s_lshl_b32      ttmp2, ttmp2, SQ_WAVE_MODE_EXCP_EN_SHIFT
>       s_and_b32       ttmp2, ttmp2, ttmp3
>       s_cbranch_scc1  L_FETCH_2ND_TRAP
> -#else
> -     s_getreg_b32    ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> -     s_and_b32       ttmp3, s_save_trapsts,
> SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
> -     s_cbranch_scc0  L_NOT_ADDR_WATCH
> -     s_or_b32        ttmp2, ttmp2,
> SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
> -
> -L_NOT_ADDR_WATCH:
> -     s_getreg_b32    ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
> -     s_and_b32       ttmp2, ttmp3, ttmp2
> -     s_cbranch_scc1  L_FETCH_2ND_TRAP
> -#endif
>
>  L_CHECK_TRAP_ID:
>       // Check trap_id !=3D 0
> @@ -369,13 +287,8 @@ L_CHECK_TRAP_ID:
>  #if SINGLE_STEP_MISSED_WORKAROUND
>       // Prioritize single step exception over context save.
>       // Second-level trap will halt wave and RFE, re-entering for SAVECT=
X.
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_getreg_b32    ttmp2, hwreg(HW_REG_MODE)
>       s_and_b32       ttmp2, ttmp2, SQ_WAVE_MODE_DEBUG_EN_MASK
> -#else
> -     // WAVE_TRAP_CTRL is already in ttmp3.
> -     s_and_b32       ttmp3, ttmp3,
> SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
> -#endif
>       s_cbranch_scc1  L_FETCH_2ND_TRAP
>  #endif
>
> @@ -425,12 +338,7 @@ L_NO_NEXT_TRAP:
>       s_cbranch_scc1  L_TRAP_CASE
>
>       // Host trap will not cause trap re-entry.
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_and_b32       ttmp2, s_save_pc_hi, S_SAVE_PC_HI_HT_MASK
> -#else
> -     s_getreg_b32    ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> -     s_and_b32       ttmp2, ttmp2,
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
> -#endif
>       s_cbranch_scc1  L_EXIT_TRAP
>       s_or_b32        s_save_status, s_save_status, S_STATUS_HALT_MASK
>
> @@ -457,16 +365,7 @@ L_EXIT_TRAP:
>       s_and_b64       exec, exec, exec                                   =
     // Restore
> STATUS.EXECZ, not writable by s_setreg_b32
>       s_and_b64       vcc, vcc, vcc                                      =
     // Restore
> STATUS.VCCZ, not writable by s_setreg_b32
>
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_setreg_b32    hwreg(S_STATUS_HWREG), s_save_status
> -#else
> -     // STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
> -     // Only restore fields which the trap handler changes.
> -     s_lshr_b32      s_save_status, s_save_status,
> SQ_WAVE_STATE_PRIV_SCC_SHIFT
> -     s_setreg_b32    hwreg(S_STATUS_HWREG,
> SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
> -             SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT -
> SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_status
> -#endif
> -
>       s_rfe_b64       [ttmp0, ttmp1]
>
>  L_SAVE:
> @@ -478,14 +377,6 @@ L_SAVE:
>       s_endpgm
>  L_HAVE_VGPRS:
>  #endif
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> -     s_bitcmp1_b32   s_save_tmp,
> SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> -     s_cbranch_scc0  L_HAVE_VGPRS
> -     s_endpgm
> -L_HAVE_VGPRS:
> -#endif
> -
>       s_and_b32       s_save_pc_hi, s_save_pc_hi, 0x0000ffff
>       //pc[47:32]
>       s_mov_b32       s_save_tmp, 0
>       s_setreg_b32    hwreg(S_TRAPSTS_HWREG,
> S_TRAPSTS_SAVE_CONTEXT_SHIFT, 1), s_save_tmp  //clear saveCtx bit
> @@ -671,19 +562,6 @@ L_SAVE_HWREG:
>       s_mov_b32       m0, 0x0
>       //Next lane of v2 to write to
>  #endif
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     // Ensure no further changes to barrier or LDS state.
> -     // STATE_PRIV.BARRIER_COMPLETE may change up to this point.
> -     s_barrier_signal        -2
> -     s_barrier_wait  -2
> -
> -     // Re-read final state of BARRIER_COMPLETE field for save.
> -     s_getreg_b32    s_save_tmp, hwreg(S_STATUS_HWREG)
> -     s_and_b32       s_save_tmp, s_save_tmp,
> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> -     s_andn2_b32     s_save_status, s_save_status,
> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> -     s_or_b32        s_save_status, s_save_status, s_save_tmp
> -#endif
> -
>       write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
>       write_hwreg_to_mem(s_save_pc_lo, s_save_buf_rsrc0, s_save_mem_offse=
t)
>       s_andn2_b32     s_save_tmp, s_save_pc_hi,
> S_SAVE_PC_HI_FIRST_WAVE_MASK
> @@ -707,21 +585,6 @@ L_SAVE_HWREG:
>       s_getreg_b32    s_save_m0,
> hwreg(HW_REG_SHADER_FLAT_SCRATCH_HI)
>       write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> -     write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
> -
> -     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
> -     write_hwreg_to_mem(s_save_m0, s_save_buf_rsrc0, s_save_mem_offset)
> -
> -     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> -     write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
> -
> -     s_get_barrier_state s_save_tmp, -1
> -     s_wait_kmcnt (0)
> -     write_hwreg_to_mem(s_save_tmp, s_save_buf_rsrc0, s_save_mem_offset)
> -#endif
> -
>  #if NO_SQC_STORE
>       // Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
>       s_mov_b32       exec_lo, 0xFFFF
> @@ -814,9 +677,7 @@ L_SAVE_LDS_NORMAL:
>       s_and_b32       s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF
>       //lds_size is zero?
>       s_cbranch_scc0  L_SAVE_LDS_DONE
>       //no lds used? jump to L_SAVE_DONE
>
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_barrier                                                          =
     //LDS is
> used? wait for other waves in the same TG
> -#endif
>       s_and_b32       s_save_tmp, s_save_pc_hi,
> S_SAVE_PC_HI_FIRST_WAVE_MASK
>       s_cbranch_scc0  L_SAVE_LDS_DONE
>
> @@ -1081,11 +942,6 @@ L_RESTORE:
>       s_mov_b32       s_restore_buf_rsrc2, 0
>       //NUM_RECORDS initial value =3D 0 (in bytes)
>       s_mov_b32       s_restore_buf_rsrc3,
> S_RESTORE_BUF_RSRC_WORD3_MISC
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     // Save s_restore_spi_init_hi for later use.
> -     s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
> -#endif
> -
>       //determine it is wave32 or wave64
>       get_wave_size2(s_restore_size)
>
> @@ -1320,9 +1176,7 @@ L_RESTORE_SGPR:
>       // s_barrier with MODE.DEBUG_EN=3D1, STATUS.PRIV=3D1 incorrectly as=
serts
> debug exception.
>       // Clear DEBUG_EN before and restore MODE after the barrier.
>       s_setreg_imm32_b32      hwreg(HW_REG_MODE), 0
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_barrier                                                          =
     //barrier
> to ensure the readiness of LDS before access attemps from any other wave =
in the
> same TG
> -#endif
>
>       /* restore HW registers */
>  L_RESTORE_HWREG:
> @@ -1334,11 +1188,6 @@ L_RESTORE_HWREG:
>
>       s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     // Restore s_restore_spi_init_hi before the saved value gets clobbe=
red.
> -     s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
> -#endif
> -
>       read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0,
> s_restore_mem_offset)
>       read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0,
> s_restore_mem_offset)
>       read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> @@ -1358,44 +1207,6 @@ L_RESTORE_HWREG:
>
>       s_setreg_b32    hwreg(HW_REG_SHADER_FLAT_SCRATCH_HI),
> s_restore_flat_scratch
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> -     S_WAITCNT_0
> -     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_USER),
> s_restore_tmp
> -
> -     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> -     S_WAITCNT_0
> -     s_setreg_b32    hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
> -
> -     // Only the first wave needs to restore the workgroup barrier.
> -     s_and_b32       s_restore_tmp, s_restore_spi_init_hi,
> S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
> -     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> -
> -     // Skip over WAVE_STATUS, since there is no state to restore from i=
t
> -     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 4
> -
> -     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> -     S_WAITCNT_0
> -
> -     s_bitcmp1_b32   s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> -     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> -
> -     // extract the saved signal count from s_restore_tmp
> -     s_lshr_b32      s_restore_tmp, s_restore_tmp,
> BARRIER_STATE_SIGNAL_OFFSET
> -
> -     // We need to call s_barrier_signal repeatedly to restore the signa=
l
> -     // count of the work group barrier.  The member count is already
> -     // initialized with the number of waves in the work group.
> -L_BARRIER_RESTORE_LOOP:
> -     s_and_b32       s_restore_tmp, s_restore_tmp, s_restore_tmp
> -     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> -     s_barrier_signal        -1
> -     s_add_i32       s_restore_tmp, s_restore_tmp, -1
> -     s_branch        L_BARRIER_RESTORE_LOOP
> -
> -L_SKIP_BARRIER_RESTORE:
> -#endif
> -
>       s_mov_b32       m0, s_restore_m0
>       s_mov_b32       exec_lo, s_restore_exec_lo
>       s_mov_b32       exec_hi, s_restore_exec_hi
> @@ -1453,13 +1264,6 @@ L_RETURN_WITHOUT_PRIV:
>
>       s_setreg_b32    hwreg(S_STATUS_HWREG), s_restore_status
>       // SCC is included, which is changed by previous salu
>
> -#if ASIC_FAMILY >=3D CHIP_GFX12
> -     // Make barrier and LDS state visible to all waves in the group.
> -     // STATE_PRIV.BARRIER_COMPLETE may change after this point.
> -     s_barrier_signal        -2
> -     s_barrier_wait  -2
> -#endif
> -
>       s_rfe_b64       s_restore_pc_lo
>       //Return to the main shader program and resume execution
>
>  L_END_PGM:
> @@ -1598,11 +1402,7 @@ function get_hwreg_size_bytes
>  end
>
>  function get_wave_size2(s_reg)
> -#if ASIC_FAMILY < CHIP_GFX12
>       s_getreg_b32    s_reg,
> hwreg(HW_REG_IB_STS2,SQ_WAVE_IB_STS2_WAVE64_SHIFT,SQ_WAVE_IB_S
> TS2_WAVE64_SIZE)
> -#else
> -     s_getreg_b32    s_reg,
> hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE
> _STATUS_WAVE64_SIZE)
> -#endif
>       s_lshl_b32      s_reg, s_reg, S_WAVE_SIZE
>  end
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> new file mode 100644
> index 000000000000..6630519892fc
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -0,0 +1,1128 @@
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
> KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/* To compile this assembly code:
> + *
> + * gfx12:
> + *   cpp -DASIC_FAMILY=3DCHIP_GFX12 cwsr_trap_handler_gfx12.asm -P -o
> gfx12.sp3
> + *   sp3 gfx12.sp3 -hex gfx12.hex
> + */
> +
> +#define CHIP_GFX12 37
> +
> +#define SINGLE_STEP_MISSED_WORKAROUND 1      //workaround for lost
> MODE.DEBUG_EN exception when SAVECTX raised
> +
> +var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK =3D 0x4
> +var SQ_WAVE_STATE_PRIV_SCC_SHIFT             =3D 9
> +var SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK         =3D 0xC00
> +var SQ_WAVE_STATE_PRIV_HALT_MASK             =3D 0x4000
> +var SQ_WAVE_STATE_PRIV_POISON_ERR_MASK               =3D 0x8000
> +var SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT              =3D 15
> +var SQ_WAVE_STATUS_WAVE64_SHIFT                      =3D 29
> +var SQ_WAVE_STATUS_WAVE64_SIZE                       =3D 1
> +var SQ_WAVE_STATUS_NO_VGPRS_SHIFT            =3D 24
> +var SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK     =3D
> SQ_WAVE_STATE_PRIV_SYS_PRIO_MASK|SQ_WAVE_STATE_PRIV_POISON_E
> RR_MASK
> +var S_SAVE_PC_HI_TRAP_ID_MASK                        =3D 0xF0000000
> +
> +var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT         =3D 12
> +var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE          =3D 9
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE         =3D 8
> +var SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHIFT                =3D 12
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SHIFT =3D 24
> +var SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE  =3D 4
> +var SQ_WAVE_LDS_ALLOC_GRANULARITY            =3D 9
> +
> +var SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK   =3D 0xF
> +var SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK     =3D 0x10
> +var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT        =3D 5
> +var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK =3D 0x20
> +var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK =3D 0x40
> +var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT        =3D 6
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK    =3D 0x80
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT   =3D 7
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK   =3D 0x100
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT  =3D 8
> +var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK     =3D 0x200
> +var SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK      =3D 0x800
> +var SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK                =3D 0x80
> +var SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK   =3D 0x200
> +
> +var SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK=3D
> SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK          |\
> +
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK      |\
> +
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK         |\
> +
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK        |\
> +
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK          |\
> +
> SQ_WAVE_EXCP_FLAG_PRIV_TRAP_AFTER_INST_MASK
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE       =3D
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT      =3D
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE       =3D
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT -
> SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT      =3D
> SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT
> +var SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE       =3D 32 -
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT
> +var BARRIER_STATE_SIGNAL_OFFSET                      =3D 16
> +var BARRIER_STATE_VALID_OFFSET                       =3D 0
> +
> +var TTMP11_DEBUG_TRAP_ENABLED_SHIFT          =3D 23
> +var TTMP11_DEBUG_TRAP_ENABLED_MASK           =3D 0x800000
> +
> +// SQ_SEL_X/Y/Z/W, BUF_NUM_FORMAT_FLOAT, (0 for MUBUF stride[17:14]
> +// when ADD_TID_ENABLE and BUF_DATA_FORMAT_32 for MTBUF),
> ADD_TID_ENABLE
> +var S_SAVE_BUF_RSRC_WORD1_STRIDE             =3D 0x00040000
> +var S_SAVE_BUF_RSRC_WORD3_MISC                       =3D 0x10807FAC
> +var S_SAVE_SPI_INIT_FIRST_WAVE_MASK          =3D 0x04000000
> +var S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT         =3D 26
> +
> +var S_SAVE_PC_HI_FIRST_WAVE_MASK             =3D 0x80000000
> +var S_SAVE_PC_HI_FIRST_WAVE_SHIFT            =3D 31
> +
> +var s_sgpr_save_num                          =3D 108
> +
> +var s_save_spi_init_lo                               =3D exec_lo
> +var s_save_spi_init_hi                               =3D exec_hi
> +var s_save_pc_lo                             =3D ttmp0
> +var s_save_pc_hi                             =3D ttmp1
> +var s_save_exec_lo                           =3D ttmp2
> +var s_save_exec_hi                           =3D ttmp3
> +var s_save_state_priv                                =3D ttmp12
> +var s_save_excp_flag_priv                    =3D ttmp15
> +var s_save_xnack_mask                                =3D s_save_excp_fla=
g_priv
> +var s_wave_size                                      =3D ttmp7
> +var s_save_buf_rsrc0                         =3D ttmp8
> +var s_save_buf_rsrc1                         =3D ttmp9
> +var s_save_buf_rsrc2                         =3D ttmp10
> +var s_save_buf_rsrc3                         =3D ttmp11
> +var s_save_mem_offset                                =3D ttmp4
> +var s_save_alloc_size                                =3D s_save_excp_fla=
g_priv
> +var s_save_tmp                                       =3D ttmp14
> +var s_save_m0                                        =3D ttmp5
> +var s_save_ttmps_lo                          =3D s_save_tmp
> +var s_save_ttmps_hi                          =3D s_save_excp_flag_priv
> +
> +var S_RESTORE_BUF_RSRC_WORD1_STRIDE          =3D
> S_SAVE_BUF_RSRC_WORD1_STRIDE
> +var S_RESTORE_BUF_RSRC_WORD3_MISC            =3D
> S_SAVE_BUF_RSRC_WORD3_MISC
> +
> +var S_RESTORE_SPI_INIT_FIRST_WAVE_MASK               =3D 0x04000000
> +var S_RESTORE_SPI_INIT_FIRST_WAVE_SHIFT              =3D 26
> +var S_WAVE_SIZE                                      =3D 25
> +
> +var s_restore_spi_init_lo                    =3D exec_lo
> +var s_restore_spi_init_hi                    =3D exec_hi
> +var s_restore_mem_offset                     =3D ttmp12
> +var s_restore_alloc_size                     =3D ttmp3
> +var s_restore_tmp                            =3D ttmp2
> +var s_restore_mem_offset_save                        =3D s_restore_tmp
> +var s_restore_m0                             =3D s_restore_alloc_size
> +var s_restore_mode                           =3D ttmp7
> +var s_restore_flat_scratch                   =3D s_restore_tmp
> +var s_restore_pc_lo                          =3D ttmp0
> +var s_restore_pc_hi                          =3D ttmp1
> +var s_restore_exec_lo                                =3D ttmp4
> +var s_restore_exec_hi                                =3D ttmp5
> +var s_restore_state_priv                     =3D ttmp14
> +var s_restore_excp_flag_priv                 =3D ttmp15
> +var s_restore_xnack_mask                     =3D ttmp13
> +var s_restore_buf_rsrc0                              =3D ttmp8
> +var s_restore_buf_rsrc1                              =3D ttmp9
> +var s_restore_buf_rsrc2                              =3D ttmp10
> +var s_restore_buf_rsrc3                              =3D ttmp11
> +var s_restore_size                           =3D ttmp6
> +var s_restore_ttmps_lo                               =3D s_restore_tmp
> +var s_restore_ttmps_hi                               =3D s_restore_alloc=
_size
> +var s_restore_spi_init_hi_save                       =3D s_restore_exec_=
hi
> +
> +shader main
> +     asic(DEFAULT)
> +     type(CS)
> +     wave_size(32)
> +
> +     s_branch        L_SKIP_RESTORE
>       //NOT restore. might be a regular trap or save
> +
> +L_JUMP_TO_RESTORE:
> +     s_branch        L_RESTORE
> +
> +L_SKIP_RESTORE:
> +     s_getreg_b32    s_save_state_priv, hwreg(HW_REG_WAVE_STATE_PRIV)
>       //save STATUS since we will change SCC
> +
> +     // Clear SPI_PRIO: do not save with elevated priority.
> +     // Clear ECC_ERR: prevents SQC store and triggers FATAL_HALT if set=
reg'd.
> +     s_andn2_b32     s_save_state_priv, s_save_state_priv,
> SQ_WAVE_STATE_PRIV_ALWAYS_CLEAR_MASK
> +
> +     s_getreg_b32    s_save_excp_flag_priv,
> hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +
> +     s_and_b32       ttmp2, s_save_state_priv,
> SQ_WAVE_STATE_PRIV_HALT_MASK
> +     s_cbranch_scc0  L_NOT_HALTED
> +
> +L_HALTED:
> +     // Host trap may occur while wave is halted.
> +     s_and_b32       ttmp2, s_save_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
> +     s_cbranch_scc1  L_FETCH_2ND_TRAP
> +
> +L_CHECK_SAVE:
> +     s_and_b32       ttmp2, s_save_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +     s_cbranch_scc1  L_SAVE
> +
> +     // Wave is halted but neither host trap nor SAVECTX is raised.
> +     // Caused by instruction fetch memory violation.
> +     // Spin wait until context saved to prevent interrupt storm.
> +     s_sleep         0x10
> +     s_getreg_b32    s_save_excp_flag_priv,
> hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +     s_branch        L_CHECK_SAVE
> +
> +L_NOT_HALTED:
> +     // Let second-level handle non-SAVECTX exception or trap.
> +     // Any concurrent SAVECTX will be handled upon re-entry once halted=
.
> +
> +     // Check non-maskable exceptions. memory_violation, illegal_instruc=
tion
> +     // and xnack_error exceptions always cause the wave to enter the tr=
ap
> +     // handler.
> +     s_and_b32       ttmp2, s_save_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_NON_MASKABLE_EXCP_MASK
> +     s_cbranch_scc1  L_FETCH_2ND_TRAP
> +
> +     // Check for maskable exceptions in trapsts.excp and trapsts.excp_h=
i.
> +     // Maskable exceptions only cause the wave to enter the trap handle=
r if
> +     // their respective bit in mode.excp_en is set.
> +     s_getreg_b32    ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> +     s_and_b32       ttmp3, s_save_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_ADDR_WATCH_MASK
> +     s_cbranch_scc0  L_NOT_ADDR_WATCH
> +     s_or_b32        ttmp2, ttmp2,
> SQ_WAVE_TRAP_CTRL_ADDR_WATCH_MASK
> +
> +L_NOT_ADDR_WATCH:
> +     s_getreg_b32    ttmp3, hwreg(HW_REG_WAVE_TRAP_CTRL)
> +     s_and_b32       ttmp2, ttmp3, ttmp2
> +     s_cbranch_scc1  L_FETCH_2ND_TRAP
> +
> +L_CHECK_TRAP_ID:
> +     // Check trap_id !=3D 0
> +     s_and_b32       ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
> +     s_cbranch_scc1  L_FETCH_2ND_TRAP
> +
> +#if SINGLE_STEP_MISSED_WORKAROUND
> +     // Prioritize single step exception over context save.
> +     // Second-level trap will halt wave and RFE, re-entering for SAVECT=
X.
> +     // WAVE_TRAP_CTRL is already in ttmp3.
> +     s_and_b32       ttmp3, ttmp3,
> SQ_WAVE_TRAP_CTRL_TRAP_AFTER_INST_MASK
> +     s_cbranch_scc1  L_FETCH_2ND_TRAP
> +#endif
> +
> +     s_and_b32       ttmp2, s_save_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK
> +     s_cbranch_scc1  L_SAVE
> +
> +L_FETCH_2ND_TRAP:
> +     // Read second-level TBA/TMA from first-level TMA and jump if avail=
able.
> +     // ttmp[2:5] and ttmp12 can be used (others hold SPI-initialized de=
bug data)
> +     // ttmp12 holds SQ_WAVE_STATUS
> +     s_sendmsg_rtn_b64       [ttmp14, ttmp15], sendmsg(MSG_RTN_GET_TMA)
> +     s_wait_idle
> +     s_lshl_b64      [ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
> +
> +     s_bitcmp1_b32   ttmp15, 0xF
> +     s_cbranch_scc0  L_NO_SIGN_EXTEND_TMA
> +     s_or_b32        ttmp15, ttmp15, 0xFFFF0000
> +L_NO_SIGN_EXTEND_TMA:
> +
> +     s_load_dword    ttmp2, [ttmp14, ttmp15], 0x10 scope:SCOPE_SYS      =
     //
> debug trap enabled flag
> +     s_wait_idle
> +     s_lshl_b32      ttmp2, ttmp2, TTMP11_DEBUG_TRAP_ENABLED_SHIFT
> +     s_andn2_b32     ttmp11, ttmp11, TTMP11_DEBUG_TRAP_ENABLED_MASK
> +     s_or_b32        ttmp11, ttmp11, ttmp2
> +
> +     s_load_dwordx2  [ttmp2, ttmp3], [ttmp14, ttmp15], 0x0
> scope:SCOPE_SYS       // second-level TBA
> +     s_wait_idle
> +     s_load_dwordx2  [ttmp14, ttmp15], [ttmp14, ttmp15], 0x8
> scope:SCOPE_SYS       // second-level TMA
> +     s_wait_idle
> +
> +     s_and_b64       [ttmp2, ttmp3], [ttmp2, ttmp3], [ttmp2, ttmp3]
> +     s_cbranch_scc0  L_NO_NEXT_TRAP
>       // second-level trap handler not been set
> +     s_setpc_b64     [ttmp2, ttmp3]                                     =
     // jump to
> second-level trap handler
> +
> +L_NO_NEXT_TRAP:
> +     // If not caused by trap then halt wave to prevent re-entry.
> +     s_and_b32       ttmp2, s_save_pc_hi, S_SAVE_PC_HI_TRAP_ID_MASK
> +     s_cbranch_scc1  L_TRAP_CASE
> +
> +     // Host trap will not cause trap re-entry.
> +     s_getreg_b32    ttmp2, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +     s_and_b32       ttmp2, ttmp2,
> SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK
> +     s_cbranch_scc1  L_EXIT_TRAP
> +     s_or_b32        s_save_state_priv, s_save_state_priv,
> SQ_WAVE_STATE_PRIV_HALT_MASK
> +
> +     // If the PC points to S_ENDPGM then context save will fail if STAT=
US.HALT
> is set.
> +     // Rewind the PC to prevent this from occurring.
> +     s_sub_u32       ttmp0, ttmp0, 0x8
> +     s_subb_u32      ttmp1, ttmp1, 0x0
> +
> +     s_branch        L_EXIT_TRAP
> +
> +L_TRAP_CASE:
> +     // Advance past trap instruction to prevent re-entry.
> +     s_add_u32       ttmp0, ttmp0, 0x4
> +     s_addc_u32      ttmp1, ttmp1, 0x0
> +
> +L_EXIT_TRAP:
> +     s_and_b32       ttmp1, ttmp1, 0xFFFF
> +
> +     // Restore SQ_WAVE_STATUS.
> +     s_and_b64       exec, exec, exec                                   =
     // Restore
> STATUS.EXECZ, not writable by s_setreg_b32
> +     s_and_b64       vcc, vcc, vcc                                      =
     // Restore
> STATUS.VCCZ, not writable by s_setreg_b32
> +
> +     // STATE_PRIV.BARRIER_COMPLETE may have changed since we read it.
> +     // Only restore fields which the trap handler changes.
> +     s_lshr_b32      s_save_state_priv, s_save_state_priv,
> SQ_WAVE_STATE_PRIV_SCC_SHIFT
> +     s_setreg_b32    hwreg(HW_REG_WAVE_STATE_PRIV,
> SQ_WAVE_STATE_PRIV_SCC_SHIFT, \
> +             SQ_WAVE_STATE_PRIV_POISON_ERR_SHIFT -
> SQ_WAVE_STATE_PRIV_SCC_SHIFT + 1), s_save_state_priv
> +
> +     s_rfe_b64       [ttmp0, ttmp1]
> +
> +L_SAVE:
> +     // If VGPRs have been deallocated then terminate the wavefront.
> +     // It has no remaining program to run and cannot save without VGPRs=
.
> +     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> +     s_bitcmp1_b32   s_save_tmp,
> SQ_WAVE_STATUS_NO_VGPRS_SHIFT
> +     s_cbranch_scc0  L_HAVE_VGPRS
> +     s_endpgm
> +L_HAVE_VGPRS:
> +
> +     s_and_b32       s_save_pc_hi, s_save_pc_hi, 0x0000ffff
>       //pc[47:32]
> +     s_mov_b32       s_save_tmp, 0
> +     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV,
> SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_SHIFT, 1), s_save_tmp
>       //clear saveCtx bit
> +
> +     /* inform SPI the readiness and wait for SPI's go signal */
> +     s_mov_b32       s_save_exec_lo, exec_lo
>       //save EXEC and use EXEC for the go signal from SPI
> +     s_mov_b32       s_save_exec_hi, exec_hi
> +     s_mov_b64       exec, 0x0                                          =
     //clear
> EXEC to get ready to receive
> +
> +     s_sendmsg_rtn_b64       [exec_lo, exec_hi],
> sendmsg(MSG_RTN_SAVE_WAVE)
> +     s_wait_idle
> +
> +     // Save first_wave flag so we can clear high bits of save address.
> +     s_and_b32       s_save_tmp, s_save_spi_init_hi,
> S_SAVE_SPI_INIT_FIRST_WAVE_MASK
> +     s_lshl_b32      s_save_tmp, s_save_tmp,
> (S_SAVE_PC_HI_FIRST_WAVE_SHIFT -
> S_SAVE_SPI_INIT_FIRST_WAVE_SHIFT)
> +     s_or_b32        s_save_pc_hi, s_save_pc_hi, s_save_tmp
> +
> +     // Trap temporaries must be saved via VGPR but all VGPRs are in use=
.
> +     // There is no ttmp space to hold the resource constant for VGPR sa=
ve.
> +     // Save v0 by itself since it requires only two SGPRs.
> +     s_mov_b32       s_save_ttmps_lo, exec_lo
> +     s_and_b32       s_save_ttmps_hi, exec_hi, 0xFFFF
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +     global_store_dword_addtid       v0, [s_save_ttmps_lo, s_save_ttmps_=
hi]
> scope:SCOPE_SYS
> +     v_mov_b32       v0, 0x0
> +     s_mov_b32       exec_lo, s_save_ttmps_lo
> +     s_mov_b32       exec_hi, s_save_ttmps_hi
> +
> +     // Save trap temporaries 4-11, 13 initialized by SPI debug dispatch=
 logic
> +     // ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
> +     get_wave_size2(s_save_ttmps_hi)
> +     get_vgpr_size_bytes(s_save_ttmps_lo, s_save_ttmps_hi)
> +     get_svgpr_size_bytes(s_save_ttmps_hi)
> +     s_add_u32       s_save_ttmps_lo, s_save_ttmps_lo, s_save_ttmps_hi
> +     s_and_b32       s_save_ttmps_hi, s_save_spi_init_hi, 0xFFFF
> +     s_add_u32       s_save_ttmps_lo, s_save_ttmps_lo, get_sgpr_size_byt=
es()
> +     s_add_u32       s_save_ttmps_lo, s_save_ttmps_lo, s_save_spi_init_l=
o
> +     s_addc_u32      s_save_ttmps_hi, s_save_ttmps_hi, 0x0
> +
> +     v_writelane_b32 v0, ttmp4, 0x4
> +     v_writelane_b32 v0, ttmp5, 0x5
> +     v_writelane_b32 v0, ttmp6, 0x6
> +     v_writelane_b32 v0, ttmp7, 0x7
> +     v_writelane_b32 v0, ttmp8, 0x8
> +     v_writelane_b32 v0, ttmp9, 0x9
> +     v_writelane_b32 v0, ttmp10, 0xA
> +     v_writelane_b32 v0, ttmp11, 0xB
> +     v_writelane_b32 v0, ttmp13, 0xD
> +     v_writelane_b32 v0, exec_lo, 0xE
> +     v_writelane_b32 v0, exec_hi, 0xF
> +
> +     s_mov_b32       exec_lo, 0x3FFF
> +     s_mov_b32       exec_hi, 0x0
> +     global_store_dword_addtid       v0, [s_save_ttmps_lo, s_save_ttmps_=
hi]
> offset:0x40 scope:SCOPE_SYS
> +     v_readlane_b32  ttmp14, v0, 0xE
> +     v_readlane_b32  ttmp15, v0, 0xF
> +     s_mov_b32       exec_lo, ttmp14
> +     s_mov_b32       exec_hi, ttmp15
> +
> +     /* setup Resource Contants */
> +     s_mov_b32       s_save_buf_rsrc0, s_save_spi_init_lo
>       //base_addr_lo
> +     s_and_b32       s_save_buf_rsrc1, s_save_spi_init_hi, 0x0000FFFF
>       //base_addr_hi
> +     s_or_b32        s_save_buf_rsrc1, s_save_buf_rsrc1,
> S_SAVE_BUF_RSRC_WORD1_STRIDE
> +     s_mov_b32       s_save_buf_rsrc2, 0
>       //NUM_RECORDS initial value =3D 0 (in bytes) although not neccessar=
ily inited
> +     s_mov_b32       s_save_buf_rsrc3, S_SAVE_BUF_RSRC_WORD3_MISC
> +
> +     s_mov_b32       s_save_m0, m0
> +
> +     /* global mem offset */
> +     s_mov_b32       s_save_mem_offset, 0x0
> +     get_wave_size2(s_wave_size)
> +
> +     /* save first 4 VGPRs, needed for SGPR save */
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
>       //need every thread from now on
> +     s_lshr_b32      m0, s_wave_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_ENABLE_SAVE_4VGPR_EXEC_HI
> +     s_mov_b32       exec_hi, 0x00000000
> +     s_branch        L_SAVE_4VGPR_WAVE32
> +L_ENABLE_SAVE_4VGPR_EXEC_HI:
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +     s_branch        L_SAVE_4VGPR_WAVE64
> +L_SAVE_4VGPR_WAVE32:
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR Allocated in 4-GPR granularity
> +
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128*2
> +     buffer_store_dword      v3, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128*3
> +     s_branch        L_SAVE_HWREG
> +
> +L_SAVE_4VGPR_WAVE64:
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR Allocated in 4-GPR granularity
> +
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256*2
> +     buffer_store_dword      v3, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256*3
> +
> +     /* save HW registers */
> +
> +L_SAVE_HWREG:
> +     // HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
> +     get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
> +     get_svgpr_size_bytes(s_save_tmp)
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, s_save_tmp
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset,
> get_sgpr_size_bytes()
> +
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     v_mov_b32       v0, 0x0
>       //Offset[31:0] from buffer resource
> +     v_mov_b32       v1, 0x0
>       //Offset[63:32] from buffer resource
> +     v_mov_b32       v2, 0x0                                            =
     //Set of
> SGPRs for TCP store
> +     s_mov_b32       m0, 0x0
>       //Next lane of v2 to write to
> +
> +     // Ensure no further changes to barrier or LDS state.
> +     // STATE_PRIV.BARRIER_COMPLETE may change up to this point.
> +     s_barrier_signal        -2
> +     s_barrier_wait  -2
> +
> +     // Re-read final state of BARRIER_COMPLETE field for save.
> +     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATE_PRIV)
> +     s_and_b32       s_save_tmp, s_save_tmp,
> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> +     s_andn2_b32     s_save_state_priv, s_save_state_priv,
> SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
> +     s_or_b32        s_save_state_priv, s_save_state_priv, s_save_tmp
> +
> +     write_hwreg_to_v2(s_save_m0)
> +     write_hwreg_to_v2(s_save_pc_lo)
> +     s_andn2_b32     s_save_tmp, s_save_pc_hi,
> S_SAVE_PC_HI_FIRST_WAVE_MASK
> +     write_hwreg_to_v2(s_save_tmp)
> +     write_hwreg_to_v2(s_save_exec_lo)
> +     write_hwreg_to_v2(s_save_exec_hi)
> +     write_hwreg_to_v2(s_save_state_priv)
> +
> +     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> +     write_hwreg_to_v2(s_save_tmp)
> +
> +     write_hwreg_to_v2(s_save_xnack_mask)
> +
> +     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_MODE)
> +     write_hwreg_to_v2(s_save_m0)
> +
> +     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
> +     write_hwreg_to_v2(s_save_m0)
> +
> +     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
> +     write_hwreg_to_v2(s_save_m0)
> +
> +     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
> +     write_hwreg_to_v2(s_save_m0)
> +
> +     s_getreg_b32    s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
> +     write_hwreg_to_v2(s_save_m0)
> +
> +     s_getreg_b32    s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
> +     write_hwreg_to_v2(s_save_tmp)
> +
> +     s_get_barrier_state s_save_tmp, -1
> +     s_wait_kmcnt (0)
> +     write_hwreg_to_v2(s_save_tmp)
> +
> +     // Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
> +     s_mov_b32       exec_lo, 0xFFFF
> +     s_mov_b32       exec_hi, 0x0
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +
> +     // Write SGPRs with 32 VGPR lanes. This works in wave32 and wave64
> mode.
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
> +
> +     /* save SGPRs */
> +     // Save SGPR before LDS save, then the s0 to s4 can be used during =
LDS
> save...
> +
> +     // SGPR SR memory offset : size(VGPR)+size(SVGPR)
> +     get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
> +     get_svgpr_size_bytes(s_save_tmp)
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, s_save_tmp
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     s_mov_b32       ttmp13, 0x0                                        =
     //next
> VGPR lane to copy SGPR into
> +
> +     s_mov_b32       m0, 0x0
>       //SGPR initial index value =3D0
> +     s_nop           0x0
>       //Manually inserted wait states
> +L_SAVE_SGPR_LOOP:
> +     // SGPR is allocated in 16 SGPR granularity
> +     s_movrels_b64   s0, s0
>       //s0 =3D s[0+m0], s1 =3D s[1+m0]
> +     s_movrels_b64   s2, s2
>       //s2 =3D s[2+m0], s3 =3D s[3+m0]
> +     s_movrels_b64   s4, s4
>       //s4 =3D s[4+m0], s5 =3D s[5+m0]
> +     s_movrels_b64   s6, s6
>       //s6 =3D s[6+m0], s7 =3D s[7+m0]
> +     s_movrels_b64   s8, s8
>       //s8 =3D s[8+m0], s9 =3D s[9+m0]
> +     s_movrels_b64   s10, s10
>       //s10 =3D s[10+m0], s11 =3D s[11+m0]
> +     s_movrels_b64   s12, s12
>       //s12 =3D s[12+m0], s13 =3D s[13+m0]
> +     s_movrels_b64   s14, s14
>       //s14 =3D s[14+m0], s15 =3D s[15+m0]
> +
> +     write_16sgpr_to_v2(s0)
> +
> +     s_cmp_eq_u32    ttmp13, 0x20
>       //have 32 VGPR lanes filled?
> +     s_cbranch_scc0  L_SAVE_SGPR_SKIP_TCP_STORE
> +
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, 0x80
> +     s_mov_b32       ttmp13, 0x0
> +     v_mov_b32       v2, 0x0
> +L_SAVE_SGPR_SKIP_TCP_STORE:
> +
> +     s_add_u32       m0, m0, 16                                         =
     //next
> sgpr index
> +     s_cmp_lt_u32    m0, 96                                             =
     //scc =3D
> (m0 < first 96 SGPR) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_SGPR_LOOP
>       //first 96 SGPR save is complete?
> +
> +     //save the rest 12 SGPR
> +     s_movrels_b64   s0, s0
>       //s0 =3D s[0+m0], s1 =3D s[1+m0]
> +     s_movrels_b64   s2, s2
>       //s2 =3D s[2+m0], s3 =3D s[3+m0]
> +     s_movrels_b64   s4, s4
>       //s4 =3D s[4+m0], s5 =3D s[5+m0]
> +     s_movrels_b64   s6, s6
>       //s6 =3D s[6+m0], s7 =3D s[7+m0]
> +     s_movrels_b64   s8, s8
>       //s8 =3D s[8+m0], s9 =3D s[9+m0]
> +     s_movrels_b64   s10, s10
>       //s10 =3D s[10+m0], s11 =3D s[11+m0]
> +     write_12sgpr_to_v2(s0)
> +
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +
> +     /* save LDS */
> +
> +L_SAVE_LDS:
> +     // Change EXEC to all threads...
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
>       //need every thread from now on
> +     s_lshr_b32      m0, s_wave_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_ENABLE_SAVE_LDS_EXEC_HI
> +     s_mov_b32       exec_hi, 0x00000000
> +     s_branch        L_SAVE_LDS_NORMAL
> +L_ENABLE_SAVE_LDS_EXEC_HI:
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +L_SAVE_LDS_NORMAL:
> +     s_getreg_b32    s_save_alloc_size,
> hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,
> SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
> +     s_and_b32       s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF
>       //lds_size is zero?
> +     s_cbranch_scc0  L_SAVE_LDS_DONE
>       //no lds used? jump to L_SAVE_DONE
> +
> +     s_and_b32       s_save_tmp, s_save_pc_hi,
> S_SAVE_PC_HI_FIRST_WAVE_MASK
> +     s_cbranch_scc0  L_SAVE_LDS_DONE
> +
> +     // first wave do LDS save;
> +
> +     s_lshl_b32      s_save_alloc_size, s_save_alloc_size,
> SQ_WAVE_LDS_ALLOC_GRANULARITY
> +     s_mov_b32       s_save_buf_rsrc2, s_save_alloc_size
>       //NUM_RECORDS in bytes
> +
> +     // LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
> +     //
> +     get_vgpr_size_bytes(s_save_mem_offset, s_wave_size)
> +     get_svgpr_size_bytes(s_save_tmp)
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, s_save_tmp
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset,
> get_sgpr_size_bytes()
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset,
> get_hwreg_size_bytes()
> +
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     //load 0~63*4(byte address) to vgpr v0
> +     v_mbcnt_lo_u32_b32      v0, -1, 0
> +     v_mbcnt_hi_u32_b32      v0, -1, v0
> +     v_mul_u32_u24   v0, 4, v0
> +
> +     s_lshr_b32      m0, s_wave_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_mov_b32       m0, 0x0
> +     s_cbranch_scc1  L_SAVE_LDS_W64
> +
> +L_SAVE_LDS_W32:
> +     s_mov_b32       s3, 128
> +     s_nop           0
> +     s_nop           0
> +     s_nop           0
> +L_SAVE_LDS_LOOP_W32:
> +     ds_read_b32     v1, v0
> +     s_wait_idle
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +
> +     s_add_u32       m0, m0, s3                                         =
     //every
> buffer_store_lds does 128 bytes
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, s3
> +     v_add_nc_u32    v0, v0, 128                                        =
     //mem
> offset increased by 128 bytes
> +     s_cmp_lt_u32    m0, s_save_alloc_size
>       //scc=3D(m0 < s_save_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_LDS_LOOP_W32
>       //LDS save is complete?
> +
> +     s_branch        L_SAVE_LDS_DONE
> +
> +L_SAVE_LDS_W64:
> +     s_mov_b32       s3, 256
> +     s_nop           0
> +     s_nop           0
> +     s_nop           0
> +L_SAVE_LDS_LOOP_W64:
> +     ds_read_b32     v1, v0
> +     s_wait_idle
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +
> +     s_add_u32       m0, m0, s3                                         =
     //every
> buffer_store_lds does 256 bytes
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, s3
> +     v_add_nc_u32    v0, v0, 256                                        =
     //mem
> offset increased by 256 bytes
> +     s_cmp_lt_u32    m0, s_save_alloc_size
>       //scc=3D(m0 < s_save_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_LDS_LOOP_W64
>       //LDS save is complete?
> +
> +L_SAVE_LDS_DONE:
> +     /* save VGPRs  - set the Rest VGPRs */
> +L_SAVE_VGPR:
> +     // VGPR SR memory offset: 0
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
>       //need every thread from now on
> +     s_lshr_b32      m0, s_wave_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_ENABLE_SAVE_VGPR_EXEC_HI
> +     s_mov_b32       s_save_mem_offset, (0+128*4)                       =
     //
> for the rest VGPRs
> +     s_mov_b32       exec_hi, 0x00000000
> +     s_branch        L_SAVE_VGPR_NORMAL
> +L_ENABLE_SAVE_VGPR_EXEC_HI:
> +     s_mov_b32       s_save_mem_offset, (0+256*4)                       =
     //
> for the rest VGPRs
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +L_SAVE_VGPR_NORMAL:
> +     s_getreg_b32    s_save_alloc_size,
> hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHI
> FT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
> +     s_add_u32       s_save_alloc_size, s_save_alloc_size, 1
> +     s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 2
>       //Number of VGPRs =3D (vgpr_size + 1) * 4    (non-zero value)
> +     //determine it is wave32 or wave64
> +     s_lshr_b32      m0, s_wave_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_SAVE_VGPR_WAVE64
> +
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR Allocated in 4-GPR granularity
> +
> +     // VGPR store using dw burst
> +     s_mov_b32       m0, 0x4
>       //VGPR initial index value =3D4
> +     s_cmp_lt_u32    m0, s_save_alloc_size
> +     s_cbranch_scc0  L_SAVE_VGPR_END
> +
> +L_SAVE_VGPR_W32_LOOP:
> +     v_movrels_b32   v0, v0
>       //v0 =3D v[0+m0]
> +     v_movrels_b32   v1, v1
>       //v1 =3D v[1+m0]
> +     v_movrels_b32   v2, v2
>       //v2 =3D v[2+m0]
> +     v_movrels_b32   v3, v3
>       //v3 =3D v[3+m0]
> +
> +     buffer_store_dword      v0, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128*2
> +     buffer_store_dword      v3, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:128*3
> +
> +     s_add_u32       m0, m0, 4                                          =
     //next
> vgpr index
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, 128*4
>       //every buffer_store_dword does 128 bytes
> +     s_cmp_lt_u32    m0, s_save_alloc_size
>       //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_VGPR_W32_LOOP
>       //VGPR save is complete?
> +
> +     s_branch        L_SAVE_VGPR_END
> +
> +L_SAVE_VGPR_WAVE64:
> +     s_mov_b32       s_save_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR store using dw burst
> +     s_mov_b32       m0, 0x4
>       //VGPR initial index value =3D4
> +     s_cmp_lt_u32    m0, s_save_alloc_size
> +     s_cbranch_scc0  L_SAVE_SHARED_VGPR
> +
> +L_SAVE_VGPR_W64_LOOP:
> +     v_movrels_b32   v0, v0
>       //v0 =3D v[0+m0]
> +     v_movrels_b32   v1, v1
>       //v1 =3D v[1+m0]
> +     v_movrels_b32   v2, v2
>       //v2 =3D v[2+m0]
> +     v_movrels_b32   v3, v3
>       //v3 =3D v[3+m0]
> +
> +     buffer_store_dword      v0, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +     buffer_store_dword      v1, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256
> +     buffer_store_dword      v2, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256*2
> +     buffer_store_dword      v3, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS offset:256*3
> +
> +     s_add_u32       m0, m0, 4                                          =
     //next
> vgpr index
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, 256*4
>       //every buffer_store_dword does 256 bytes
> +     s_cmp_lt_u32    m0, s_save_alloc_size
>       //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_VGPR_W64_LOOP
>       //VGPR save is complete?
> +
> +L_SAVE_SHARED_VGPR:
> +     //Below part will be the save shared vgpr part (new for gfx10)
> +     s_getreg_b32    s_save_alloc_size,
> hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_
> SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
> +     s_and_b32       s_save_alloc_size, s_save_alloc_size, 0xFFFFFFFF
>       //shared_vgpr_size is zero?
> +     s_cbranch_scc0  L_SAVE_VGPR_END
>       //no shared_vgpr used? jump to L_SAVE_LDS
> +     s_lshl_b32      s_save_alloc_size, s_save_alloc_size, 3
>       //Number of SHARED_VGPRs =3D shared_vgpr_size * 8    (non-zero valu=
e)
> +     //m0 now has the value of normal vgpr count, just add the m0 with
> shared_vgpr count to get the total count.
> +     //save shared_vgpr will start from the index of m0
> +     s_add_u32       s_save_alloc_size, s_save_alloc_size, m0
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
> +     s_mov_b32       exec_hi, 0x00000000
> +
> +L_SAVE_SHARED_VGPR_WAVE64_LOOP:
> +     v_movrels_b32   v0, v0
>       //v0 =3D v[0+m0]
> +     buffer_store_dword      v0, v0, s_save_buf_rsrc0, s_save_mem_offset
> scope:SCOPE_SYS
> +     s_add_u32       m0, m0, 1                                          =
     //next
> vgpr index
> +     s_add_u32       s_save_mem_offset, s_save_mem_offset, 128
> +     s_cmp_lt_u32    m0, s_save_alloc_size
>       //scc =3D (m0 < s_save_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_SAVE_SHARED_VGPR_WAVE64_LOOP
>               //SHARED_VGPR save is complete?
> +
> +L_SAVE_VGPR_END:
> +     s_branch        L_END_PGM
> +
> +L_RESTORE:
> +     /* Setup Resource Contants */
> +     s_mov_b32       s_restore_buf_rsrc0, s_restore_spi_init_lo
>       //base_addr_lo
> +     s_and_b32       s_restore_buf_rsrc1, s_restore_spi_init_hi, 0x0000F=
FFF
>       //base_addr_hi
> +     s_or_b32        s_restore_buf_rsrc1, s_restore_buf_rsrc1,
> S_RESTORE_BUF_RSRC_WORD1_STRIDE
> +     s_mov_b32       s_restore_buf_rsrc2, 0
>       //NUM_RECORDS initial value =3D 0 (in bytes)
> +     s_mov_b32       s_restore_buf_rsrc3,
> S_RESTORE_BUF_RSRC_WORD3_MISC
> +
> +     // Save s_restore_spi_init_hi for later use.
> +     s_mov_b32 s_restore_spi_init_hi_save, s_restore_spi_init_hi
> +
> +     //determine it is wave32 or wave64
> +     get_wave_size2(s_restore_size)
> +
> +     s_and_b32       s_restore_tmp, s_restore_spi_init_hi,
> S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
> +     s_cbranch_scc0  L_RESTORE_VGPR
> +
> +     /* restore LDS */
> +L_RESTORE_LDS:
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
>       //need every thread from now on
> +     s_lshr_b32      m0, s_restore_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_ENABLE_RESTORE_LDS_EXEC_HI
> +     s_mov_b32       exec_hi, 0x00000000
> +     s_branch        L_RESTORE_LDS_NORMAL
> +L_ENABLE_RESTORE_LDS_EXEC_HI:
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +L_RESTORE_LDS_NORMAL:
> +     s_getreg_b32    s_restore_alloc_size,
> hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT,
> SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE)
> +     s_and_b32       s_restore_alloc_size, s_restore_alloc_size, 0xFFFFF=
FFF
>       //lds_size is zero?
> +     s_cbranch_scc0  L_RESTORE_VGPR
>       //no lds used? jump to L_RESTORE_VGPR
> +     s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size,
> SQ_WAVE_LDS_ALLOC_GRANULARITY
> +     s_mov_b32       s_restore_buf_rsrc2, s_restore_alloc_size
>       //NUM_RECORDS in bytes
> +
> +     // LDS at offset: size(VGPR)+size(SVGPR)+SIZE(SGPR)+SIZE(HWREG)
> +     //
> +     get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
> +     get_svgpr_size_bytes(s_restore_tmp)
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, s_resto=
re_tmp
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset,
> get_sgpr_size_bytes()
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset,
> get_hwreg_size_bytes()
> +
> +     s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     s_lshr_b32      m0, s_restore_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_mov_b32       m0, 0x0
> +     s_cbranch_scc1  L_RESTORE_LDS_LOOP_W64
> +
> +L_RESTORE_LDS_LOOP_W32:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> +     s_wait_idle
> +     ds_store_addtid_b32     v0
> +     s_add_u32       m0, m0, 128                                        =
     // 128
> DW
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 128
>       //mem offset increased by 128DW
> +     s_cmp_lt_u32    m0, s_restore_alloc_size
>       //scc=3D(m0 < s_restore_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_RESTORE_LDS_LOOP_W32
>               //LDS restore is complete?
> +     s_branch        L_RESTORE_VGPR
> +
> +L_RESTORE_LDS_LOOP_W64:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> +     s_wait_idle
> +     ds_store_addtid_b32     v0
> +     s_add_u32       m0, m0, 256                                        =
     // 256
> DW
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256
>       //mem offset increased by 256DW
> +     s_cmp_lt_u32    m0, s_restore_alloc_size
>       //scc=3D(m0 < s_restore_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_RESTORE_LDS_LOOP_W64
>               //LDS restore is complete?
> +
> +     /* restore VGPRs */
> +L_RESTORE_VGPR:
> +     // VGPR SR memory offset : 0
> +     s_mov_b32       s_restore_mem_offset, 0x0
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
>       //need every thread from now on
> +     s_lshr_b32      m0, s_restore_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_ENABLE_RESTORE_VGPR_EXEC_HI
> +     s_mov_b32       exec_hi, 0x00000000
> +     s_branch        L_RESTORE_VGPR_NORMAL
> +L_ENABLE_RESTORE_VGPR_EXEC_HI:
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
> +L_RESTORE_VGPR_NORMAL:
> +     s_getreg_b32    s_restore_alloc_size,
> hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHI
> FT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
> +     s_add_u32       s_restore_alloc_size, s_restore_alloc_size, 1
> +     s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 2      =
     //Number
> of VGPRs =3D (vgpr_size + 1) * 4    (non-zero value)
> +     //determine it is wave32 or wave64
> +     s_lshr_b32      m0, s_restore_size, S_WAVE_SIZE
> +     s_and_b32       m0, m0, 1
> +     s_cmp_eq_u32    m0, 1
> +     s_cbranch_scc1  L_RESTORE_VGPR_WAVE64
> +
> +     s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR load using dw burst
> +     s_mov_b32       s_restore_mem_offset_save, s_restore_mem_offset    =
     //
> restore start with v1, v0 will be the last
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 128*4
> +     s_mov_b32       m0, 4                                              =
     //VGPR
> initial index value =3D 4
> +     s_cmp_lt_u32    m0, s_restore_alloc_size
> +     s_cbranch_scc0  L_RESTORE_SGPR
> +
> +L_RESTORE_VGPR_WAVE32_LOOP:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS
> +     buffer_load_dword       v1, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:128
> +     buffer_load_dword       v2, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:128*2
> +     buffer_load_dword       v3, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:128*3
> +     s_wait_idle
> +     v_movreld_b32   v0, v0
>       //v[0+m0] =3D v0
> +     v_movreld_b32   v1, v1
> +     v_movreld_b32   v2, v2
> +     v_movreld_b32   v3, v3
> +     s_add_u32       m0, m0, 4                                          =
     //next
> vgpr index
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 128*4
>       //every buffer_load_dword does 128 bytes
> +     s_cmp_lt_u32    m0, s_restore_alloc_size                           =
     //scc =3D
> (m0 < s_restore_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_RESTORE_VGPR_WAVE32_LOOP
>               //VGPR restore (except v0) is complete?
> +
> +     /* VGPR restore on v0 */
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS
> +     buffer_load_dword       v1, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:128
> +     buffer_load_dword       v2, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:128*2
> +     buffer_load_dword       v3, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:128*3
> +     s_wait_idle
> +
> +     s_branch        L_RESTORE_SGPR
> +
> +L_RESTORE_VGPR_WAVE64:
> +     s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // VGPR load using dw burst
> +     s_mov_b32       s_restore_mem_offset_save, s_restore_mem_offset    =
     //
> restore start with v4, v0 will be the last
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*4
> +     s_mov_b32       m0, 4                                              =
     //VGPR
> initial index value =3D 4
> +     s_cmp_lt_u32    m0, s_restore_alloc_size
> +     s_cbranch_scc0  L_RESTORE_SHARED_VGPR
> +
> +L_RESTORE_VGPR_WAVE64_LOOP:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS
> +     buffer_load_dword       v1, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:256
> +     buffer_load_dword       v2, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:256*2
> +     buffer_load_dword       v3, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS offset:256*3
> +     s_wait_idle
> +     v_movreld_b32   v0, v0
>       //v[0+m0] =3D v0
> +     v_movreld_b32   v1, v1
> +     v_movreld_b32   v2, v2
> +     v_movreld_b32   v3, v3
> +     s_add_u32       m0, m0, 4                                          =
     //next
> vgpr index
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 256*4
>       //every buffer_load_dword does 256 bytes
> +     s_cmp_lt_u32    m0, s_restore_alloc_size                           =
     //scc =3D
> (m0 < s_restore_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_RESTORE_VGPR_WAVE64_LOOP
>               //VGPR restore (except v0) is complete?
> +
> +L_RESTORE_SHARED_VGPR:
> +     //Below part will be the restore shared vgpr part (new for gfx10)
> +     s_getreg_b32    s_restore_alloc_size,
> hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_
> SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
>       //shared_vgpr_size
> +     s_and_b32       s_restore_alloc_size, s_restore_alloc_size, 0xFFFFF=
FFF
>       //shared_vgpr_size is zero?
> +     s_cbranch_scc0  L_RESTORE_V0
>       //no shared_vgpr used?
> +     s_lshl_b32      s_restore_alloc_size, s_restore_alloc_size, 3      =
     //Number
> of SHARED_VGPRs =3D shared_vgpr_size * 8    (non-zero value)
> +     //m0 now has the value of normal vgpr count, just add the m0 with
> shared_vgpr count to get the total count.
> +     //restore shared_vgpr will start from the index of m0
> +     s_add_u32       s_restore_alloc_size, s_restore_alloc_size, m0
> +     s_mov_b32       exec_lo, 0xFFFFFFFF
> +     s_mov_b32       exec_hi, 0x00000000
> +L_RESTORE_SHARED_VGPR_WAVE64_LOOP:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0, s_restore_mem_=
offset
> scope:SCOPE_SYS
> +     s_wait_idle
> +     v_movreld_b32   v0, v0
>       //v[0+m0] =3D v0
> +     s_add_u32       m0, m0, 1                                          =
     //next
> vgpr index
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 128
> +     s_cmp_lt_u32    m0, s_restore_alloc_size                           =
     //scc =3D
> (m0 < s_restore_alloc_size) ? 1 : 0
> +     s_cbranch_scc1  L_RESTORE_SHARED_VGPR_WAVE64_LOOP
>               //VGPR restore (except v0) is complete?
> +
> +     s_mov_b32       exec_hi, 0xFFFFFFFF
>       //restore back exec_hi before restoring V0!!
> +
> +     /* VGPR restore on v0 */
> +L_RESTORE_V0:
> +     buffer_load_dword       v0, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS
> +     buffer_load_dword       v1, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:256
> +     buffer_load_dword       v2, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:256*2
> +     buffer_load_dword       v3, v0, s_restore_buf_rsrc0,
> s_restore_mem_offset_save scope:SCOPE_SYS offset:256*3
> +     s_wait_idle
> +
> +     /* restore SGPRs */
> +     //will be 2+8+16*6
> +     // SGPR SR memory offset : size(VGPR)+size(SVGPR)
> +L_RESTORE_SGPR:
> +     get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
> +     get_svgpr_size_bytes(s_restore_tmp)
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, s_resto=
re_tmp
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset,
> get_sgpr_size_bytes()
> +     s_sub_u32       s_restore_mem_offset, s_restore_mem_offset, 20*4
>       //s108~s127 is not saved
> +
> +     s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     s_mov_b32       m0, s_sgpr_save_num
> +
> +     read_4sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_sub_u32       m0, m0, 4                                          =
     // Restore
> from S[0] to S[104]
> +     s_nop           0                                                  =
     // hazard
> SALU M0=3D> S_MOVREL
> +
> +     s_movreld_b64   s0, s0
>       //s[0+m0] =3D s0
> +     s_movreld_b64   s2, s2
> +
> +     read_8sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_sub_u32       m0, m0, 8                                          =
     // Restore
> from S[0] to S[96]
> +     s_nop           0                                                  =
     // hazard
> SALU M0=3D> S_MOVREL
> +
> +     s_movreld_b64   s0, s0
>       //s[0+m0] =3D s0
> +     s_movreld_b64   s2, s2
> +     s_movreld_b64   s4, s4
> +     s_movreld_b64   s6, s6
> +
> + L_RESTORE_SGPR_LOOP:
> +     read_16sgpr_from_mem(s0, s_restore_buf_rsrc0, s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_sub_u32       m0, m0, 16                                         =
     // Restore
> from S[n] to S[0]
> +     s_nop           0                                                  =
     // hazard
> SALU M0=3D> S_MOVREL
> +
> +     s_movreld_b64   s0, s0
>       //s[0+m0] =3D s0
> +     s_movreld_b64   s2, s2
> +     s_movreld_b64   s4, s4
> +     s_movreld_b64   s6, s6
> +     s_movreld_b64   s8, s8
> +     s_movreld_b64   s10, s10
> +     s_movreld_b64   s12, s12
> +     s_movreld_b64   s14, s14
> +
> +     s_cmp_eq_u32    m0, 0
>       //scc =3D (m0 < s_sgpr_save_num) ? 1 : 0
> +     s_cbranch_scc0  L_RESTORE_SGPR_LOOP
> +
> +     // s_barrier with MODE.DEBUG_EN=3D1, STATUS.PRIV=3D1 incorrectly as=
serts
> debug exception.
> +     // Clear DEBUG_EN before and restore MODE after the barrier.
> +     s_setreg_imm32_b32      hwreg(HW_REG_WAVE_MODE), 0
> +
> +     /* restore HW registers */
> +L_RESTORE_HWREG:
> +     // HWREG SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)
> +     get_vgpr_size_bytes(s_restore_mem_offset, s_restore_size)
> +     get_svgpr_size_bytes(s_restore_tmp)
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, s_resto=
re_tmp
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset,
> get_sgpr_size_bytes()
> +
> +     s_mov_b32       s_restore_buf_rsrc2, 0x1000000
>       //NUM_RECORDS in bytes
> +
> +     // Restore s_restore_spi_init_hi before the saved value gets clobbe=
red.
> +     s_mov_b32 s_restore_spi_init_hi, s_restore_spi_init_hi_save
> +
> +     read_hwreg_from_mem(s_restore_m0, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_pc_lo, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_pc_hi, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_exec_lo, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_exec_hi, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_state_priv, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_excp_flag_priv, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_xnack_mask, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_mode, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_setreg_b32    hwreg(HW_REG_WAVE_SCRATCH_BASE_LO),
> s_restore_flat_scratch
> +
> +     read_hwreg_from_mem(s_restore_flat_scratch, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_setreg_b32    hwreg(HW_REG_WAVE_SCRATCH_BASE_HI),
> s_restore_flat_scratch
> +
> +     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     s_wait_idle
> +     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_USER),
> s_restore_tmp
> +
> +     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     s_wait_idle
> +     s_setreg_b32    hwreg(HW_REG_WAVE_TRAP_CTRL), s_restore_tmp
> +
> +     // Only the first wave needs to restore the workgroup barrier.
> +     s_and_b32       s_restore_tmp, s_restore_spi_init_hi,
> S_RESTORE_SPI_INIT_FIRST_WAVE_MASK
> +     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> +
> +     // Skip over WAVE_STATUS, since there is no state to restore from i=
t
> +     s_add_u32       s_restore_mem_offset, s_restore_mem_offset, 4
> +
> +     read_hwreg_from_mem(s_restore_tmp, s_restore_buf_rsrc0,
> s_restore_mem_offset)
> +     s_wait_idle
> +
> +     s_bitcmp1_b32   s_restore_tmp, BARRIER_STATE_VALID_OFFSET
> +     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> +
> +     // extract the saved signal count from s_restore_tmp
> +     s_lshr_b32      s_restore_tmp, s_restore_tmp,
> BARRIER_STATE_SIGNAL_OFFSET
> +
> +     // We need to call s_barrier_signal repeatedly to restore the signa=
l
> +     // count of the work group barrier.  The member count is already
> +     // initialized with the number of waves in the work group.
> +L_BARRIER_RESTORE_LOOP:
> +     s_and_b32       s_restore_tmp, s_restore_tmp, s_restore_tmp
> +     s_cbranch_scc0  L_SKIP_BARRIER_RESTORE
> +     s_barrier_signal        -1
> +     s_add_i32       s_restore_tmp, s_restore_tmp, -1
> +     s_branch        L_BARRIER_RESTORE_LOOP
> +
> +L_SKIP_BARRIER_RESTORE:
> +
> +     s_mov_b32       m0, s_restore_m0
> +     s_mov_b32       exec_lo, s_restore_exec_lo
> +     s_mov_b32       exec_hi, s_restore_exec_hi
> +
> +     // {TRAPSTS/EXCP_FLAG_PRIV}.SAVE_CONTEXT and HOST_TRAP may
> have changed.
> +     // Only restore the other fields to avoid clobbering them.
> +     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV, 0,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_1_SIZE),
> s_restore_excp_flag_priv
> +     s_lshr_b32      s_restore_excp_flag_priv, s_restore_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
> +     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SIZE),
> s_restore_excp_flag_priv
> +     s_lshr_b32      s_restore_excp_flag_priv, s_restore_excp_flag_priv,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT -
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_2_SHIFT
> +     s_setreg_b32    hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SHIFT,
> SQ_WAVE_EXCP_FLAG_PRIV_RESTORE_PART_3_SIZE),
> s_restore_excp_flag_priv
> +
> +     s_setreg_b32    hwreg(HW_REG_WAVE_MODE), s_restore_mode
> +
> +     // Restore trap temporaries 4-11, 13 initialized by SPI debug dispa=
tch logic
> +     // ttmp SR memory offset : size(VGPR)+size(SVGPR)+size(SGPR)+0x40
> +     get_vgpr_size_bytes(s_restore_ttmps_lo, s_restore_size)
> +     get_svgpr_size_bytes(s_restore_ttmps_hi)
> +     s_add_u32       s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_t=
tmps_hi
> +     s_add_u32       s_restore_ttmps_lo, s_restore_ttmps_lo,
> get_sgpr_size_bytes()
> +     s_add_u32       s_restore_ttmps_lo, s_restore_ttmps_lo, s_restore_b=
uf_rsrc0
> +     s_addc_u32      s_restore_ttmps_hi, s_restore_buf_rsrc1, 0x0
> +     s_and_b32       s_restore_ttmps_hi, s_restore_ttmps_hi, 0xFFFF
> +     s_load_dwordx4  [ttmp4, ttmp5, ttmp6, ttmp7], [s_restore_ttmps_lo,
> s_restore_ttmps_hi], 0x50 scope:SCOPE_SYS
> +     s_load_dwordx4  [ttmp8, ttmp9, ttmp10, ttmp11], [s_restore_ttmps_lo=
,
> s_restore_ttmps_hi], 0x60 scope:SCOPE_SYS
> +     s_load_dword    ttmp13, [s_restore_ttmps_lo, s_restore_ttmps_hi], 0=
x74
> scope:SCOPE_SYS
> +     s_wait_idle
> +
> +     s_and_b32       s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff
>       //pc[47:32] //Do it here in order not to affect STATUS
> +     s_and_b64       exec, exec, exec                                   =
     // Restore
> STATUS.EXECZ, not writable by s_setreg_b32
> +     s_and_b64       vcc, vcc, vcc                                      =
     // Restore
> STATUS.VCCZ, not writable by s_setreg_b32
> +
> +     s_setreg_b32    hwreg(HW_REG_WAVE_STATE_PRIV), s_restore_state_priv
>       // SCC is included, which is changed by previous salu
> +
> +     // Make barrier and LDS state visible to all waves in the group.
> +     // STATE_PRIV.BARRIER_COMPLETE may change after this point.
> +     s_barrier_signal        -2
> +     s_barrier_wait  -2
> +
> +     s_rfe_b64       s_restore_pc_lo
>       //Return to the main shader program and resume execution
> +
> +L_END_PGM:
> +     s_endpgm_saved
> +end
> +
> +function write_hwreg_to_v2(s)
> +     // Copy into VGPR for later TCP store.
> +     v_writelane_b32 v2, s, m0
> +     s_add_u32       m0, m0, 0x1
> +end
> +
> +
> +function write_16sgpr_to_v2(s)
> +     // Copy into VGPR for later TCP store.
> +     for var sgpr_idx =3D 0; sgpr_idx < 16; sgpr_idx ++
> +             v_writelane_b32 v2, s[sgpr_idx], ttmp13
> +             s_add_u32       ttmp13, ttmp13, 0x1
> +     end
> +end
> +
> +function write_12sgpr_to_v2(s)
> +     // Copy into VGPR for later TCP store.
> +     for var sgpr_idx =3D 0; sgpr_idx < 12; sgpr_idx ++
> +             v_writelane_b32 v2, s[sgpr_idx], ttmp13
> +             s_add_u32       ttmp13, ttmp13, 0x1
> +     end
> +end
> +
> +function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
> +     s_buffer_load_dword     s, s_rsrc, s_mem_offset scope:SCOPE_SYS
> +     s_add_u32       s_mem_offset, s_mem_offset, 4
> +end
> +
> +function read_16sgpr_from_mem(s, s_rsrc, s_mem_offset)
> +     s_sub_u32       s_mem_offset, s_mem_offset, 4*16
> +     s_buffer_load_dwordx16  s, s_rsrc, s_mem_offset scope:SCOPE_SYS
> +end
> +
> +function read_8sgpr_from_mem(s, s_rsrc, s_mem_offset)
> +     s_sub_u32       s_mem_offset, s_mem_offset, 4*8
> +     s_buffer_load_dwordx8   s, s_rsrc, s_mem_offset scope:SCOPE_SYS
> +end
> +
> +function read_4sgpr_from_mem(s, s_rsrc, s_mem_offset)
> +     s_sub_u32       s_mem_offset, s_mem_offset, 4*4
> +     s_buffer_load_dwordx4   s, s_rsrc, s_mem_offset scope:SCOPE_SYS
> +end
> +
> +function get_vgpr_size_bytes(s_vgpr_size_byte, s_size)
> +     s_getreg_b32    s_vgpr_size_byte,
> hwreg(HW_REG_WAVE_GPR_ALLOC,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SHI
> FT,SQ_WAVE_GPR_ALLOC_VGPR_SIZE_SIZE)
> +     s_add_u32       s_vgpr_size_byte, s_vgpr_size_byte, 1
> +     s_bitcmp1_b32   s_size, S_WAVE_SIZE
> +     s_cbranch_scc1  L_ENABLE_SHIFT_W64
> +     s_lshl_b32      s_vgpr_size_byte, s_vgpr_size_byte, (2+7)          =
     //Number
> of VGPRs =3D (vgpr_size + 1) * 4 * 32 * 4   (non-zero value)
> +     s_branch        L_SHIFT_DONE
> +L_ENABLE_SHIFT_W64:
> +     s_lshl_b32      s_vgpr_size_byte, s_vgpr_size_byte, (2+8)          =
     //Number
> of VGPRs =3D (vgpr_size + 1) * 4 * 64 * 4   (non-zero value)
> +L_SHIFT_DONE:
> +end
> +
> +function get_svgpr_size_bytes(s_svgpr_size_byte)
> +     s_getreg_b32    s_svgpr_size_byte,
> hwreg(HW_REG_WAVE_LDS_ALLOC,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_
> SIZE_SHIFT,SQ_WAVE_LDS_ALLOC_VGPR_SHARED_SIZE_SIZE)
> +     s_lshl_b32      s_svgpr_size_byte, s_svgpr_size_byte, (3+7)
> +end
> +
> +function get_sgpr_size_bytes
> +     return 512
> +end
> +
> +function get_hwreg_size_bytes
> +     return 128
> +end
> +
> +function get_wave_size2(s_reg)
> +     s_getreg_b32    s_reg,
> hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE
> _STATUS_WAVE64_SIZE)
> +     s_lshl_b32      s_reg, s_reg, S_WAVE_SIZE
> +end
> --
> 2.34.1

