Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EA6C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 08:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68AB810E154;
	Mon, 24 Apr 2023 08:00:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF05B10E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 08:00:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikhLvgeXvb+uAtWNpkDOpcyOVbGmv4L5jvQ/q+7j3M/ak8fXohDvi0nKrtXQZbmSoz4Hc7PF/H5+F10Pu3OOEKrZjWpjlvk71Mx5vx2igA+Pq955lX59hl04ktoeL/f5rv0tiRfJE33oYMuM31jKS3sE5fVMvqI8jp3EIFXPHuIRZlxj9vk7q8Y+IT9seQVYJ5eo0lOQVFL8tfJcnnF++HCnVvmlJATkEXaimonMKyXQtxNR59bRE/Gj2bv9gzUFneqClKEKxGHhhm0YP7KKkM1QgmqNzIz7AoPfDQroZiGE4GUW0yhtotfPbeVUYwqtN51T4LwZx96m58gnKIxZfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI0Uv8HFUYnq/fE/8WMUagy5Pxi63rGALs9VoQO9CJg=;
 b=m+euuc+EpyiOUenN/a52aYC/64cJe0TMzmTvni5P+nS/xaVGRStL62z2ljadEHF4yjinHcyRQaLyb/0Cy8qiF4YZmic5jCTByNuN6QbSaG9UJU8DQOR5nZt5fHvbVwjHVQMx5f/JHlcQsTCJ2WU3RAQnxRMPWk2B8hEomISDQLz8qsAoqPrBR6HgtglOgSJhs/bDTtoj+x+9kCe/+rU5JXDA4//sKYs/rxGNnwdEXLtzoJbwLCs1jpLsLeNUnxx+bspUmu/+Gh6C0/ESQwXnDH3Lt56cxaAE4e0g7ebuS4GqnXNuvbpgrxNb3XNnwL6xBXBKw3sQ/BRnUnZooybXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI0Uv8HFUYnq/fE/8WMUagy5Pxi63rGALs9VoQO9CJg=;
 b=g+M9NOT/hGeSaYM14gXyW2xUaqPdmRbxDz9hYeZXLWNyKV6tSp9y26Tui7aTaUEJoIwHNnFc2uZO6IseZqHVcdwsKPzYnvmlLRBi4wtAAvg6gt9zS2lRO1bLZQpZnzPGN+8MhCSsXiJufgUJDsLf6Sj+sfwg/nWRCKNP6MR6aXw=
Received: from CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1ef::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 08:00:40 +0000
Received: from CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::2117:56c1:8eca:7153]) by CH0PR12MB5251.namprd12.prod.outlook.com
 ([fe80::2117:56c1:8eca:7153%6]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 08:00:40 +0000
From: "Li, Lyndon" <Lyndon.Li@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amdgpu
 driver
Thread-Topic: [PATCH 2/2] drm/amdgpu: Use the default reset when loading
 amdgpu driver
Thread-Index: AQHZdlBAhkBKOmc+4EOmXJVniJe3UK8593kAgAAeWRA=
Date: Mon, 24 Apr 2023 08:00:40 +0000
Message-ID: <CH0PR12MB525144486192874336A464C9E8679@CH0PR12MB5251.namprd12.prod.outlook.com>
References: <20230424015805.78747-1-Lyndon.Li@amd.com>
 <20230424015805.78747-2-Lyndon.Li@amd.com>
 <CH2PR12MB4152CAA214495226D7C2A975FE679@CH2PR12MB4152.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB4152CAA214495226D7C2A975FE679@CH2PR12MB4152.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T08:00:34Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9a4b894d-1d76-4320-b8ae-4f58f81d70e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T08:00:34Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 19fbd6c7-890a-45bf-af68-c0c4b11edb38
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5251:EE_|MW4PR12MB7029:EE_
x-ms-office365-filtering-correlation-id: ef8eb6e0-e843-4a67-75aa-08db4499ff1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXb+B0M9ceFDZo41MxXbzI55zW/Ba/QLiEp0RVNnhaeegbvfYnFqLs5iitQgp5UjzpeNCB7/E2BQpFgg+YtUEAsLQkSjqRR6h+yx8T8K6GBpVWBRvqVRqOtegR1Bp0qoqfmmNqvzJFIxqwPdpxcENFNtpMdRJlzELm3Qy9B4hEf32q0dFOkpeXL7JXmUaZVTX9umaWtugohFPod7xJsc/ne7sWRWZB3R0ugXlaU93olDKxqfSJFf5tn64SyzJeb8/hbJ62u+84tM74vgZkXRhS0V3cf/eaEeXDV87sOQ/OHHSayLG8neir2NyeSNBw0guxSmCvvNwTLh+PMFIPZwajaD3ECuaJxFkp6zxgyJYZd43+Q5vVtsEWgJYa1uV2d2S3i0uM6jN7+SVmABgR0I9bYO2x9lDgZDNepxdqVnv5WVNW98p7uF8zmWwEcc6SNmNXsU/jjl3iimdAFQqcWyl1F5S4zbZI6Y1yv96R/dUEMkXaasAk9RZ856tPJNjhTcTsnmsvBsimsq+IGJfdckg180J1dWoEBUnBVbL10+dbbZsF8vsdWruphFQ1QuwSOrKaUxNxRN23gB9dHMNtAjE9R0Fw1qk8EiqCDXg0YsNso34/SRiuM/he7+H/caGkQm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5251.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(54906003)(110136005)(38070700005)(478600001)(316002)(4326008)(76116006)(64756008)(66446008)(66476007)(66556008)(55016003)(66946007)(122000001)(41300700001)(2906002)(8936002)(8676002)(52536014)(5660300002)(38100700002)(9686003)(6506007)(26005)(53546011)(86362001)(186003)(33656002)(83380400001)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u2opQeZWTo0/9p67Fb88knYatjDHbyxqPVpvkd+2q4fuWWLD8hM/QM81iiGx?=
 =?us-ascii?Q?U6vJ8k+HC0o9lSEDdYGjKZgfXpQJBofoPF3/Xqaqt09DC62tejmdQeS53Zq4?=
 =?us-ascii?Q?tale1zlTJt6BTKd4bGfbljMmrTLtprd6bUuwdo+1g/8SkHM8lw4IZkyofdom?=
 =?us-ascii?Q?hdc5/7RuDMdvYeTGiugISXXnTR55MMA0xTBVm72fI/X1JpOnAz5eifvd7sOj?=
 =?us-ascii?Q?goQWtSYAoTDYhR8aGz4XWE6rXBV8YpZZ/uFK/tdUGlO4OOPmEMDyR4wibFBd?=
 =?us-ascii?Q?zT+bVj7Hw43PJP4hT4qeFNfWyihz3wCFL7lmeotIiCPEYV1iSj/pzqWGMbYh?=
 =?us-ascii?Q?VEuNtMVxtv7RQbHaVaMsHWLm+51EEt3X2P/SlztfDN0BHz9dPRaV/x9TkTzY?=
 =?us-ascii?Q?yx8cBGw6t3Fai+TLTDodPaGA/tUonwP/FNYOXJ13hmpuKQtiFOUoai2qtyj0?=
 =?us-ascii?Q?MKE3x7IbINrJbw0HpHEUxSbwZ/5SKJFPQnsN9qkYYA+GqQe88JGM5GLXKvZv?=
 =?us-ascii?Q?3jT4TytTOkidAmO/bqw9GGZUjRhKycIfxaqPveUitG7hP1p4lhW8GjF16ODy?=
 =?us-ascii?Q?SSWd8Kzjm6Bq284Gf92+8l8x+0NmkYlhOFGRUBW2ulAG7aNLVEbLCZbUqAci?=
 =?us-ascii?Q?YNOc456b/UaE/E+c6ySmhHCDNmIEf1/kFSKT3hIgZ9Gk9+WVVS3VpN5rGQ7Y?=
 =?us-ascii?Q?1TXfAI8J3OLXSMaSH9oZ90ymfbrio3l37HzG0QwUp5EPREhd62fAC8ptITfp?=
 =?us-ascii?Q?CEanVK/1nMbMEcmY8lkc7U8bDEHQCfydrlc4onM7eFrhzK5mL72Iw1rjmWeP?=
 =?us-ascii?Q?ec0+X9pKOfP24PWl2jkN6OlzHiuZkysrimuPi7Qap43CJ3undtpxYnzn4D2L?=
 =?us-ascii?Q?bgDG17vj+HHboyhiYqWRrhZ9TUTMC/mjR8Uz4l9K+/ci3UZn7bwvNdMc7uhM?=
 =?us-ascii?Q?oNgB/s/XcNQIaImOB13y7ndkVNFi/SEAEEWzPHaQ6/0N+NSCFT8bjrBXP2tW?=
 =?us-ascii?Q?XiWZ8UFmXxFn0R0zeS6pDb1yuAA9q9Kh6dPDeC/+bDCwH/h4x3wf5saYCQlN?=
 =?us-ascii?Q?RukHT5++wxFjySCVspEZH4JG9tSEGLvlOwaKQ+NPhQX+Wav399jcS2taZ2qk?=
 =?us-ascii?Q?lIXONZvblKbN2OImil09behgcsiLpUE5ViAlfU1/pdiKulbeLAc5JzVWA4A5?=
 =?us-ascii?Q?n0AIapEq1y8NC9AJQ8XVsc9f+scUlPWFh7B90ZaNkr1FWCg+Q1cDF6+/CRYT?=
 =?us-ascii?Q?EKTutEMArBEh1Iu9izTPgoumRGVS7mRsHZE8q3bQ82oYwwVBHSYOiBcsabrO?=
 =?us-ascii?Q?WKtrdACmvpuy8nnn6zzyAlCiPPUPzBbpJJzds369vN8kBxLORe7wf8tvZwn4?=
 =?us-ascii?Q?S8vBLP81ZnSMz9FS6g/571FV2pouN/xJrpuL2QbI7JNakrFKkPD3oDmRQwdu?=
 =?us-ascii?Q?G2gMSdTQRNDrbc1eRFd7Po38nvbUMrdN4DPOl1t3+UczEEDC2eXmgzJJZkzw?=
 =?us-ascii?Q?YnHTHmwgiQhkgDGROuojlSJRJtFQol3/+rBscuhhbQdOtXzc9kNb87Qcnv+u?=
 =?us-ascii?Q?YJaq2Q7t8NhRchbo6T0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5251.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8eb6e0-e843-4a67-75aa-08db4499ff1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 08:00:40.3399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJMjddTusTHSctFZqNmifxmroSyA1QDiTxsvwIumXtLDY4iXjLFtwbMVVY18YG7FCW1igRade32D3EgsUHb+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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
Cc: "Li, Yunxiang
 \(Teddy\)" <Yunxiang.Li@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Feifei,

Thanks for your feedback. Will add comments inside and modify commit messag=
es.
I think you are a little misunderstood.

It should do a mode1 reset when loading or reloading the driver, regardless=
 of the module parameter reset_method.=20
It will call amdgpu_device_mode1_reset in amdgpu_asic_reset if amdgpu_reset=
_method is set to AMD_RESET_METHOD_NONE.=20
Here's an example,
modprobe amdgpu
modprobe -r amdgpu
modprobe amdgpu reset_method=3D3 //The real reset method should be mode1 re=
set, since it is initialization.

Regards,
Lyndon

> -----Original Message-----
> From: Xu, Feifei <Feifei.Xu@amd.com>
> Sent: Monday, April 24, 2023 2:00 PM
> To: Li, Lyndon <Lyndon.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li,
> Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when loading
> amdgpu driver
>=20
> [AMD Official Use Only - General]
>=20
> I think you might be refer to : mod parameter reset_method will not affec=
t
> the loading driver code path. If loading driver, it should use the defaul=
t reset
> which might be mode1/mode2 or BACO instead of the specific mode2.
>=20
> With the confusing commit msg corrected. And adding comment before the
> code " r =3D amdgpu_asic_reset(adev);"
>=20
>=20
>=20
> Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
>=20
> -----Original Message-----
> From: lyndonli <Lyndon.Li@amd.com>
> Sent: Monday, April 24, 2023 9:58 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor
> <Victor.Zhao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xu,
> Feifei <Feifei.Xu@amd.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>;
> Li, Lyndon <Lyndon.Li@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Use the default reset when loading
> amdgpu driver
>=20
> Below call trace and errors are observed when reloading amdgpu driver wit=
h
> the module parameter reset_method=3D3.
>=20
> It should do a mode1 reset when loading the driver.
>=20
> [  +2.180243] [drm] psp gfx command ID_LOAD_TOC(0x20) failed and
> response status is (0x0) [  +0.000011] [drm:psp_hw_start [amdgpu]]
> *ERROR* Failed to load toc [  +0.000890] [drm:psp_hw_start [amdgpu]]
> *ERROR* PSP tmr init failed!
> [  +0.020683] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear
> memory with ring turned off.
> [  +0.000003] RIP: 0010:amdgpu_bo_release_notify+0x1ef/0x210 [amdgpu]
> [  +0.000004] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000008]  ttm_bo_release+0x2c4/0x330 [amdttm] [  +0.000026]
> amdttm_bo_put+0x3c/0x70 [amdttm] [  +0.000020]
> amdgpu_bo_free_kernel+0xe6/0x140 [amdgpu] [  +0.000728]
> psp_v11_0_ring_destroy+0x34/0x60 [amdgpu] [  +0.000826]
> psp_hw_init+0xe7/0x2f0 [amdgpu] [  +0.000813]
> amdgpu_device_fw_loading+0x1ad/0x2d0 [amdgpu] [  +0.000731]
> amdgpu_device_init.cold+0x108e/0x2002 [amdgpu] [  +0.001071]  ?
> do_pci_enable_device+0xe1/0x110 [  +0.000011]
> amdgpu_driver_load_kms+0x1a/0x160 [amdgpu] [  +0.000729]
> amdgpu_pci_probe+0x179/0x3a0 [amdgpu]
>=20
> Signed-off-by: lyndonli <Lyndon.Li@amd.com>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e536886f6d42..9738e3660cf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3578,6 +3578,7 @@ int amdgpu_device_init(struct amdgpu_device
> *adev,
>  	int r, i;
>  	bool px =3D false;
>  	u32 max_MBps;
> +	int tmp;
>=20
>  	adev->shutdown =3D false;
>  	adev->flags =3D flags;
> @@ -3799,7 +3800,10 @@ int amdgpu_device_init(struct amdgpu_device
> *adev,
>  				}
>  			}
>  		} else {
> +			tmp =3D amdgpu_reset_method;
> +			amdgpu_reset_method =3D
> AMD_RESET_METHOD_NONE;
>  			r =3D amdgpu_asic_reset(adev);
> +			amdgpu_reset_method =3D tmp;
>  			if (r) {
>  				dev_err(adev->dev, "asic reset on init
> failed\n");
>  				goto failed;
> --
> 2.34.1=
