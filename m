Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA3DCA0EF5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 08:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5069810E128;
	Tue, 19 Aug 2025 08:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mN79uJMM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798DE10E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 08:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny/xfLf588SKM1k6OqbO7wmy0qe6SaBd1FLmT/f60o62nxxteB2V2+yRKb8kxv66MmCx76QuaNRYDZENdPFIiaK8LipK3k4vPck3nTc/8VyxSkGOnNe7794FGSx47Z7jx1mD35TjWhQHqQNX65x4JSAJRGQW5bHK6cvEzBDiSQuRyrgT81aqGoRNIDq/Oj2ytNJJsMU6ZQ/TxJuir6kcRTDXo+aGaZmbGG8Ph07YxBjWhAdo66NdkEoU/G8UwE3bzlDxC09CFwDfx9AB7hbzCp0DZa+4HkwKlZ+ScQMuJv5lu0YaQBbt88XTWVNeXdgoTMdgePDejFm/NBxYbxbBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X1yjzQHSuDdkhHtOHX8BIlr+GYHpvRxWmwjo5Qr2YU=;
 b=q28kh7klTB0dXIcBS8UdWNDaRwN4kvWDceW4YFCBE4+3WdQTueglKAkxm7nGQmS6N9ZnEk4gYCvLwaicSqTy5nrA7RHdX8CwX4aIsV9lFaKFYNCT4wCTknR+66ydz1hwiQjnWsK4UdXirQR4CN1kVbY9VS6DZDoK9DAatN0+7oYKWPK2hEXS/IboBAgz3PJlAvChBIwU8EcZRXUIcR9hvTC3DmfY2ZPQg0+GhKPt5mq9gA4SVltQyRJM/FGyU8RcZ/7IGfAvKPRbyYM4sa/7HsnejIpTKxsB8j4GJSU2dYsvze/a4JDJqCREij+cxZxg2zbA2uWEhfQDFuYGAoJb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X1yjzQHSuDdkhHtOHX8BIlr+GYHpvRxWmwjo5Qr2YU=;
 b=mN79uJMME4ZamcatSBrgxi14kPVPWy8oxQGV7FAnYyK/0OrTxyL+GbmJ5R3EDa/JWVcIhk/qOuchduSb0VhLDjojDlyBZcGdHWNMt9IbYTjoHxL1O2udZ/kxfe9+e/BA8iwo5MlF9oN21jFrhVC+PnRXeclUf2uOmwRDCHHmHwA=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:41:05 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::d31e:be5f:10e8:2944%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:41:05 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Allocate psp fw private buffer in vram
Thread-Topic: [PATCH] drm/amdgpu: Allocate psp fw private buffer in vram
Thread-Index: AQHcEOOtfHih2hBUdkCNIp29yeM/L7RpqCOQ
Date: Tue, 19 Aug 2025 08:41:05 +0000
Message-ID: <PH0PR12MB540417594B403C4A7F35139AF630A@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20250819083118.26717-1-Hawking.Zhang@amd.com>
In-Reply-To: <20250819083118.26717-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-19T08:40:47.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|CY8PR12MB7585:EE_
x-ms-office365-filtering-correlation-id: 674fe11b-3f83-457e-a38e-08dddefc22fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Y+h3VU3HK/10k5foOKLD3V8xKgCBNh1Dsl0QD5Xa75L3a93MLveyRHXOHlGo?=
 =?us-ascii?Q?pgHeVSLdwgqIoXpcGUHmD5KwYhCO1wjVx3xvisVKH/tzFVAN2JVnhe9c15j5?=
 =?us-ascii?Q?gnbzy6merlYKJ6sV6WSAB23SzX9EljGnSOGkiQOhsjRuJGTyH4LCGnZKg9GG?=
 =?us-ascii?Q?X7ueOKrYQcwDqrzwT/fskLT86cZkvIVTxB0gm340fCHSEYhnoF/WfSYL6doQ?=
 =?us-ascii?Q?8cEm6JqIolUGt4iq6ZFN8K+o13I2SdDYuHbmbXPBCQLaLQo2yvu2/jcqrbrp?=
 =?us-ascii?Q?CzQxtxskkftK5BswtYMLu6aDY8lr7zmsx4rbywoljSi4pzk6hdpo6YDpu2tL?=
 =?us-ascii?Q?tiOH6DxmWTm60oXYnZsWUVEOMsBeKUtXzMM1tDUvWe+Qu2RBK/pXlWFKS+qJ?=
 =?us-ascii?Q?ZjoeGl9Ti8I4zxsVSMzuDeWKRjfeK7KTS6f8OTGAW41yoFTtwR9/ZWLRSvqu?=
 =?us-ascii?Q?UbXNmr8cfdw8Mi+aMbj5hLm1ZWfwT9FjH9DUFeyiC1gtUAAvQEuWPcA2l7GN?=
 =?us-ascii?Q?v3t7KVs3Zqi/GEVip+Q8kk1Enlcfghf59EhlFCVhD8/w+YCER0L23L0C0Pyl?=
 =?us-ascii?Q?6KMf/9FLceUFYqJPpulcu8gC5HYRT1mqgfoyiUU7v1I4G60sUu8ZuQkphCq6?=
 =?us-ascii?Q?rPnJqCf+VuMMKhXUCoLT/lnjuqTnZSgeubv1XLI3U2MnTl7AbuhS0VTLE7Xc?=
 =?us-ascii?Q?r30IwPKw0uyCxOxwCKkeP2IznX8MuwsWsEfxyHp+HdwEUjpXM9apz9qDU9gd?=
 =?us-ascii?Q?/GGgrXre7xmL/NEEEHdl7X/DBtlNtsUNjel10AYTvJiTDX3NtZaTmUSbyEBs?=
 =?us-ascii?Q?NoybZzf+MPbTO+ZAHLGcOyPr6w+uU9zj3IljpVzRnAg+e7MgMjn+aO2LEYjt?=
 =?us-ascii?Q?EvS8xZp0aqlLqHr/m1r3rRlZAh7PtJIxF9Vfx8oy9FFRYkueDEOjh0WHEnhn?=
 =?us-ascii?Q?Ao31qt3WfDmTxxUN9mQG2ld7438pKvWfcbKfGjiEshtMut1lUdFvCChMumbU?=
 =?us-ascii?Q?Qml26pALiEp1n1PKw5Mz5W/i3jL/S+5+YFZoHZMIjnVMdnUAojuP6zBhOGfo?=
 =?us-ascii?Q?8icl8Sd/ib+UBqH/5EPDItQMPDThAgxKw/9iGyriIqSVuSq9ucSGqgVMbqNm?=
 =?us-ascii?Q?BUdEGvI4gDnDY0al4LOg6kJ2YULI6kPhTOH7pbyRkluo41/iZUx1kLGhz9Rp?=
 =?us-ascii?Q?qYWHiXbCNklHx5xLNpW/9i8o979muMiz93V7mqWWxhLbnjQ6CNrLtW9bBmv5?=
 =?us-ascii?Q?4gO12qzWysp4fG6gT5E/vDLAQXNqa0kwDctT6XFQJrxtf11BaGVq6gU5kj4+?=
 =?us-ascii?Q?NzOIhFVx5+27qPFLdsXCDSsjzTufwawf4/vjXd6oN2eG4UJ3pCmwMUvheeGg?=
 =?us-ascii?Q?ZuHsRSpwj1sLBMh5BbiNEe96a79YnWcxmg5NENbDuWZSI2MTPUp2/IPYm4yz?=
 =?us-ascii?Q?LXL8fFA51XeJB0pKzwSdVorrAs0ZIkFDbNN7prW3rFFaxjwsEe2VRg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ED/feN0dkZVp0rBun1t0pbWaSh8JvX3DuqSv4l0yG3gn8+AEqSmxrEnJpxJ9?=
 =?us-ascii?Q?YyRmuB9xUUNwrIhrVXqTzYgAnI7NolOtEvGrDMMSq+zPn2Yek8wi9dVFVcQo?=
 =?us-ascii?Q?QY2DomVLem/yyqsB6rO134gYUKUINXjfi41Y05tZ1+RLKuLSEh+AqzoR65zH?=
 =?us-ascii?Q?U77HpcwEc/MqE1Rh/aib8F50AGJKkGNSfI0xE9GdttaentodTCYLSQV3ZySf?=
 =?us-ascii?Q?GKzUgM6Iy0ynnfv5AB+IFGHpzBdGvBbSHyohgoge7+dmxlNlKIbV3BHOwb6R?=
 =?us-ascii?Q?jIjzuCMDqy8VH9mw/Vjc8P5TaB2PIIebnyRbP7MRus8Ub07wcrFi0ajQuS0I?=
 =?us-ascii?Q?5m1SmcMqk09q72sEOj95jKN2ZUOEqLyX14ImTQRTUXf0xHc8W9QAxDXK6tKz?=
 =?us-ascii?Q?FUbKwCAhA6MRrgL4WloWQuFvepnWXGGEmpls1QV1NcgE0PPb/JVd//YIG1OP?=
 =?us-ascii?Q?ZwZqxjo/OXydDD+aji4Oh0Eo0/wIAul3R5/IyaPvSTwFhmMmOi4Ckbyq1usU?=
 =?us-ascii?Q?pPGx2Eok2HPU65emlgzqRSjbWC/H02dqbQm35o9vCh/HLFgIYf1/dtL2O1qX?=
 =?us-ascii?Q?l0hYCRPNKOrcRrvU1pMH5vhZFGyZbgilm3AI5Ttpv5GCSK7UMS+2bigczNhe?=
 =?us-ascii?Q?lrlnm9m4nZ7HhnExzwposgbzsMLnAwuVsgAVks5LelTVKhMleUmhe7UX0z8T?=
 =?us-ascii?Q?oeDgifD+travTgstxnKk4SFn7DU3VixhLPli0iORMvF+JlYt5x4wxaKzgegx?=
 =?us-ascii?Q?bJ3qZKHbVWKHJNovpvmwqdipmA4DmMjOiBhrEcFQ6y9ivvAwuND/VRcFGDEM?=
 =?us-ascii?Q?kWcs7nA4zm+nqUujrAU0HZol1QYpbRWcGz3k9QvRSifElb5h7l9aEdROTlRc?=
 =?us-ascii?Q?xr4Ib4zd2lpaUvomBL3dhMtKBUTXmmGefM8UegeICSji32S+4SwOeUkiZtkB?=
 =?us-ascii?Q?+ldjc5FSVrs2VRGPOmPlkEj5IVAxK+U5hrkiIfoS+xuycahhtUjUwaLoGiwo?=
 =?us-ascii?Q?NhDVUujkt/xmRYReW1y/O7FgmBspb8XN/WLjElMDdSZoyEswinzZuzEwbmK+?=
 =?us-ascii?Q?awPApI7+a9M0cRZA/rQZuI577IEIW308RnQeDmcy5E04h6Q7a0EH8hRH+12K?=
 =?us-ascii?Q?7Ch9lqaGpDIBNILRGehMi1vGn82pEe8RjYSg4cZvrAC93wr0WngNqzr3+qLC?=
 =?us-ascii?Q?RYW0gFYeqjzGI1iWiTv2/fgq9kIfei/3ESqNoOTYaeQkvqoRi9WPfA+PfT7w?=
 =?us-ascii?Q?ZQiydB11YLH4K4X2x70oU6H9vAnC4Qgh6GYNZXycsFDxaxq41YZNlgiY0e8m?=
 =?us-ascii?Q?s765skdc3i+9BPaM2VY/dAJkco26mTOwwA8Lh7kSYi/kjL9iUiuJUhrlk7IP?=
 =?us-ascii?Q?/ZNy0HHMYgdgIDdjsO8pECDBNsu/bD+TbI7kImtDXPloOUEtCEmSt6MzvlmN?=
 =?us-ascii?Q?GmejUwECaGn15YSvAI8h/MF/Epf3NEqZP6nV4UcgX7aKK/akiZAiSsh4nXvz?=
 =?us-ascii?Q?cl9RJ011a7Gd3gElYO8662R3MxJMvbZ1EObbUlWPmKzR+8JUtrAU7cqNddsh?=
 =?us-ascii?Q?nI2Qn87HK9fBTxkBSU8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674fe11b-3f83-457e-a38e-08dddefc22fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:41:05.6263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yAVoJU7lk9qHTY2Z30hEmjmy451WGciJgoH72WNiVbarLIiIMVGVl2xzHjq6FQVd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Le Ma <le.ma@amd.com>

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, August 19, 2025 4:31 PM
> To: amd-gfx@lists.freedesktop.org; Ma, Le <Le.Ma@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Allocate psp fw private buffer in vram
>
> It's not necessarily to allocate psp firmware private buffer in different=
 memory domain
> in sriov and bare metal environment
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 04dedf38eb0d..d53700c87a5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -506,8 +506,7 @@ static int psp_sw_init(struct amdgpu_ip_block *ip_blo=
ck)
>       }
>
>       ret =3D amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
> -                                   (amdgpu_sriov_vf(adev) || adev-
> >debug_use_vram_fw_buf) ?
> -                                   AMDGPU_GEM_DOMAIN_VRAM :
> AMDGPU_GEM_DOMAIN_GTT,
> +                                   AMDGPU_GEM_DOMAIN_VRAM,
>                                     &psp->fw_pri_bo,
>                                     &psp->fw_pri_mc_addr,
>                                     &psp->fw_pri_buf);
> --
> 2.17.1

