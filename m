Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88DC98302
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 06:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C6E10EF15;
	Wed, 23 Sep 2026 06:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwKjmdlj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5925710EF15
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 06:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4wQBh0kr0/+Vakv3U0a65Vf7DJb8v9/4eDECnHvfokH7gZ5UHRX2ifAoU8BQ8AMu87OgZDrIFn5UdqGoD5XITIkFyhL4AfB5e5S9vDjiLiRJQk35Mb4/Qw19CjFpERuo7OKyoofBJdSYNb6ZHxw8VVokRVPPZPjZQYQek8FpgiE8KnijVpw1WZHdeehlcdRvuAhZLKjXDKZD06SK8Dm27Ou4IcJMy2jlyBnqttcjT9dxxAycD1Ot/hliFoNkvbTNWxIRs4jF2Mkxk+fQ/ieektii+zSAV1VpUYYctLQX0K5dSRqJ7QO6RYbhxRg6AI2sJInzGFzYy04YTJhyDO/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN7SgNHRd1q+q5cJxJUQd3ryNFtMeO0eu4Crm3vwtEY=;
 b=PJM75p6VYV59TvTfV/iT1BSrBvK4qDkL/nKNSNXGxadSG8SYW6bZZDSwJe/c36PPGxwbu8/7FkD4RsQy3wtwpBHndWecQtr0zr6qtC/u6/rxNhPPW+9vXitTh/IiP0mtC6ErRCWebV1Qoxa6lJl73GP4aPMtqbzQNih17G1EYiaYAZi/E8uE4ON2z25oCg71sdvvyGZ8+pZtscq6VQ/wB5ZqqAS9/P317nvBnkBUJcAFPXrU9E1CfF5vibPHRqWs/EuaB09Tl46NR//MHzBs2NADUnSV4pdSdF7orzJGX7nss/N13fG+hK3Md3V3QYbVUDuz33lvXmzlhV/HA4jM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN7SgNHRd1q+q5cJxJUQd3ryNFtMeO0eu4Crm3vwtEY=;
 b=SwKjmdljMNtPPNejbdHFSZoWAHGBUq/3ew8z12xOUCV9sJaYFfvzNU1LO3DmQM0/fCmGDTLf/dYH1rSeJ+PZriZvLelfJlu3U6lmla1Y3zU4Qj+RaDaQAMrvr5L2rV2XjyhklWWLfrk5XyIDn3uI0dgEjYGPx061tPlv0wG9viE=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by DS2PR12MB9614.namprd12.prod.outlook.com (2603:10b6:8:276::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:52:47 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 06:52:47 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover
 resume
Thread-Topic: [PATCH] drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover
 resume
Thread-Index: AQHdSpzfbph+rxQurkKYkQ/ch6TWvbbbuwbg
Date: Wed, 23 Sep 2026 06:52:47 +0000
Message-ID: <CYYPR12MB872903ABEBC44CC80793E97FB0822@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20260922141530.135273-1-cesun102@amd.com>
In-Reply-To: <20260922141530.135273-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-23T06:52:40.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|DS2PR12MB9614:EE_
x-ms-office365-filtering-correlation-id: 0fc8bf6f-3bbf-4f6c-8688-08df193f46ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|11063799006|18092099006|22082099003|18002099003|10086099003;
x-microsoft-antispam-message-info: Vx5umKoxbeIlnwMZpQ/Tgqfa2Zwhkq+k7pDg9w4VarvRaxsmrgnkgQBEz7QsvJ6JSNB0kshEss3Ou4oCbMH9BfwdisC5F30rDIS6BtZV3VOL6j1Imi9vutIqiiyrcI6H+21X4naiO/AIyfTiU0Pi2MzbsFX7Bym9OVM5TPYnYM/OAakQDIqTTXbImNVCdVmt5ewGefY+igxQktVSZaOc0vD2OU6+hx8m3518v+Ft4c2iWDe5xD7O/1jugJnsLl9xcUGCSBz9jKiNN02XH99UoLr1goGZFkIG/jH8wzAH1JW9BftDzmkxRuU/R1Xf3LGguwBTpTDMckbDaTbqtIiGZ1XY3+8apAeWf2STTU3DEixukH+0praEHmYWgJwBd9GsxWpaGZaz5cjXKakze0MMVyH70l3eLfFpJhGSNaruMjzzwqPI0Q7X3tjsEoRomdQMu4JIPsC2XxtFFkHUxyGXTvaSLgEcM4LPX+EMDBACKpNdIpaCOOv4bFZjIFHlcYzMulQ65BdskuWYx8qB9iMJvJ9Ed3TGHAGQnH78l49feNvcgqiJHxMbiDkXyfuQKJ0BL4VuESr2+Bw9/EBIw4Qss8Oll7mkhA+/jN4cywU/yrKZUdg90PJaIvMDtL6Nae6RptuJLlcYVf2S7pY1eadD26Ig4HxoR/OYbd38NtflvfVRPcQFuBm+YbQokapF2+7QZUtbkKUpsLMBh9stN+5vYOxuW8fKIdvqoY219vH8o8k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(11063799006)(18092099006)(22082099003)(18002099003)(10086099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GeMX9XfdNQ71mwPVfh8+b2omagOZi97XHYZOzWUheKeDxiD4swEnvREwxZBG?=
 =?us-ascii?Q?FNWhIq7CqeY0EmXSUkkMJuuExCDimU0+dZqxbDqAK/2Hu5Wwac+cNS5QG/To?=
 =?us-ascii?Q?V1rWdDsFU3mB6z/GGLxkRyI9N0HwRQ2VvvtAJQ9mjD77J68Sfrrgnsb8Fpyq?=
 =?us-ascii?Q?8r58tY/04xUeKH4uq3fL1yNZsV7Orpn4QZVMv+1J5Ze37LUysH5IKFuCkxmu?=
 =?us-ascii?Q?HxT7zSB9dCycDVPG0GoXEi9RAJWASopWYkrXq77Tg+jy+A08qQeATSkZ5Cul?=
 =?us-ascii?Q?aYQfnh+6tvQBvdHetd9JGQZtvf3cBH4zLzNk5ND1vjxPpvq395P4mXtx8YwJ?=
 =?us-ascii?Q?qJMEtnGOddwy5PQpf+4MpxE6Hjpq5SDZFIaW/UeSl0bo5/Vowzl6fSOMeCwR?=
 =?us-ascii?Q?ZohbV2KsdmDhPy5+oJcqutqA6H28h10hGa1YWEdawD5W6mGG6jN9aixa/yKt?=
 =?us-ascii?Q?ocSezQFpZcPhYorBds6faAyUMmqLQa9xWJz3pmk07VS/L0AEuSMMYRRHqbej?=
 =?us-ascii?Q?TIUgwAO8XsGdJpkbdPoCUnmFdZW0hn9JM6cLKe5AwTZL+WuuSmVI8ze7m+Mz?=
 =?us-ascii?Q?dJjh59AUrbEmI7/tZA08SwUrUwvjEL/dqXvQsoinksa+hPSC7lyB9l1EhRIS?=
 =?us-ascii?Q?WACxGMzAua5ntk3W24XK5rpwh9k1nsBXaR5o3dM5vhfEGlilUbq04KBoUNR8?=
 =?us-ascii?Q?Ml+LAMk+3b6YOIIvuNBe2efhCQI9ipLT/tmnkdMu41GSo9ox+9VTjwMd2t+J?=
 =?us-ascii?Q?GT0oAJHBRo8nmTpWEs9k4P86bj66lpvfe1LMSi8B+gF8MUewKhV3AwbWwNHu?=
 =?us-ascii?Q?T/SlX/bYxkMnxI59DTrOXQCFxRo0/tAGmjMOPn4SN5zee7P9GYjbw/1GxlD5?=
 =?us-ascii?Q?aXK3hGcyDkUaLtyEwr1Du2nks22veriuDfmKDdBNv4wCwz+Yd4BN5Jl+FVtK?=
 =?us-ascii?Q?AdkBs9rNL24E6GGR0lAxtsyl/L6PhyLTT/wVngGLpf+zwiIDk8hrL8QLJKo3?=
 =?us-ascii?Q?LFIZrgXvp7SN1AXuAdh6Lta1q/VvZpDEQNr2aiSLB2jkULjKVr3mnUnoTQsd?=
 =?us-ascii?Q?rku3YFWK+miJtCnfU/O/XEdHfjSHxQwl8PxbwhpIn4b5AKi0I4D9f7MCh5Aw?=
 =?us-ascii?Q?ulI3fZjbjaxvjN0KfSlXMDgWV2X5FGUsLz5ewzrLXw+ILuMRxY2gq50rkVEf?=
 =?us-ascii?Q?5qmgPIzczqB2pQK4eH6kbl40z2bjRD+w+pFyxs7GJCRxXBTIZC8rsrUrkrk0?=
 =?us-ascii?Q?y64FumITdmQC9YIKqVsMn0gIIAFSMnxA+yWSyMlUg1bh+Tq6YHwX3tYCGR3Y?=
 =?us-ascii?Q?jkR5DHVu2YHyUpfVo4IreLPr1pSb2R6TWOzIlgRraVsm/DdwoRz7mOGLcuQt?=
 =?us-ascii?Q?D1xaEXS9mtPMz+h1Ad1QXqqkmYN2ElE6wC5VCFaijl3hdkmm9cfJ1itUYTHO?=
 =?us-ascii?Q?mye8swzL+EhhxuMZRSjWzdxpHJgzJngzr8sdl+Xzb22QcjpuQTkV2gFkTC3o?=
 =?us-ascii?Q?FAnIhn0KSEB+Ew2tRYgBK38yJ2Wf5xJbIe8kMM6SdLOkMo70SQEKa2ciXbFn?=
 =?us-ascii?Q?SSrsMggXHyHFKlw98glZVRn3WJeg69wF8lTwD9a2IgAnxklRacSFsciZ7fzE?=
 =?us-ascii?Q?UiDAaMczR/8WIxnK/TuMBKfLdSVPVBON2mdwOWWFS6o+VjJv3sp6FqgPDkfs?=
 =?us-ascii?Q?NlZs210f8Xctzgi0kVKTPEXixgdPE9IHLCLaUc2/R2/G0wsY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc8bf6f-3bbf-4f6c-8688-08df193f46ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2026 06:52:47.3327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMHlQlkaefivQ6ixb5O5WjjLwgl/sx/a83lCddzuewVgRy2rxt7D7/nG0Y99vNzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9614
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

AMD General

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Sent: Tuesday, September 22, 2026 10:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> Subject: [PATCH] drm/amdgpu/ras: allow ClearMcaOnRead during GPU recover
> resume
>
> Allow RAS_MP1_MSG_ClearMcaOnRead MP1 message in Mode1 reset, to support
> device debug mode setup on GPU recovery resume.
>
> Signed-off-by: Ce Sun <cesun102@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> index 7ca2f33f2cf0..06b072737ac9 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
> @@ -92,9 +92,11 @@ static int amdgpu_ras_send_mp1_msg(struct
> ras_core_context *ras_core, u32 msg_id
>               ret =3D amdgpu_smu_ras_send_msg(adev, smu_msg,
>                               params, num_params, read_args, num_read_arg=
s);
>               up_read(&adev->reset_domain->sem);
> -     } else {
> +     } else if (msg_id =3D=3D RAS_MP1_MSG_ClearMcaOnRead)
> +             ret =3D amdgpu_smu_ras_send_msg(adev, smu_msg,
> +                             params, num_params, read_args, num_read_arg=
s);
> +     else
>               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
> -     }
>
>       return ret;
>  }
> --
> 2.34.1

