Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD33C7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 08:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D2210E087;
	Mon, 24 Apr 2023 08:24:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D218810E087
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 08:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7mZkowuikbfFmOEXTjfHizPzxa/bLDDx+NSi2+N4+j1L1ybKYsDeluqYWE5LSt+6KkN1crZp81loY/nc1oqeXWAktOjuVoYmV5a0Zi5nL2dZZpsQ6g9EadNzs+4bSAUIJf5JVFnZrYT/w2qbbWKRP+1PeBnje0HKzY7np/NYBf6ewVQl+j9xX+wMm/kU+kkN4jzyABd1r5ENtsINvPn0dcvZHYoxi2UTZJYcqJ8jwDgfK+p7FiEAHRIMODXTOy2/xOpqI1e2y8keZk3LR7ju8Ff4ReNxK33s/gMxwaRmynKs/jExOwfp9ui26he4oYjfdjzHm3hBbegCduopkcIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVk9XtJISdLVjapdkh3lUc+Wa9Wi/dfZ8F37XSB7+n4=;
 b=SSadCEVv3K7JVDWFxBu6F8qRbYZ9SaJoK7nj0IMLAFxPughPuuFs9ghEWNvyexIWja7z/wJ8pIPZeCYn5BiJo30zQ3KPtOeoP7ZTcsv7279acie8cVsFRiQJzcNMFXLJlDXHtXsrI2lUT1eQFo2kM/qhr6x1BTpXUaJthPKvG8D7NtJ1z3/RmVx4hbRRwucQ84w9qainfqWMwTcdV28sADxCtsfolKyZaMwA+yZ3ldwhRLHnY4qEJ9PLztFitV+sIRAHDRavfcP9EGKclNu3dfTwPDhB/CCAOCvIKvIZFwTRImT7InHQAx5+SI3SwovO2wZeHwMqvc1JFOf0p0fSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVk9XtJISdLVjapdkh3lUc+Wa9Wi/dfZ8F37XSB7+n4=;
 b=DNKf4wwtPDJhqUhwBNGi1/xA5gwQIaGwgRPzoP4YHCVasK6tvYPKd8EBkRPmnOr44EpJUKrkYuCOsgRRNw3dMl1peGAiZYPQmao6+fBIdfMZ7zFLRalOO72f1S3EAuG8tfr8oTNKbKlY0DXp5b5ckcUSnTcgi/qSODXsIrkUddY=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 08:24:15 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 08:24:15 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amdgpu
 driver
Thread-Topic: [PATCH 2/2] drm/amdgpu: Use the default reset when loading
 amdgpu driver
Thread-Index: AQHZdlBAlBEnCJjPSkGT5zvLzyF3Ba858vhggAAmIACAAASjkA==
Date: Mon, 24 Apr 2023 08:24:14 +0000
Message-ID: <CH2PR12MB4152596E00180B1658B4869BFE679@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230424015805.78747-1-Lyndon.Li@amd.com>
 <20230424015805.78747-2-Lyndon.Li@amd.com>
 <CH2PR12MB4152CAA214495226D7C2A975FE679@CH2PR12MB4152.namprd12.prod.outlook.com>
 <CH0PR12MB525144486192874336A464C9E8679@CH0PR12MB5251.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB525144486192874336A464C9E8679@CH0PR12MB5251.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T08:24:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9a4b894d-1d76-4320-b8ae-4f58f81d70e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T08:24:10Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fd626876-4441-4956-8749-9dbcb0ff318b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|IA0PR12MB7721:EE_
x-ms-office365-filtering-correlation-id: bc503a27-c9f0-43de-d818-08db449d4a40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZFFvQ2vWRKWgmpJ9DHWKDlkzbsskYp7ak5OkWAQ4lr8KOYp83ifHDJght+deW3h4ltEwX8KAoIiGDj9gk+B3qeMiPZNHEiHXHOnq11mAtgS0BbGnpvoI6PlzBoj7uuXyMAaK2Ev2PWOQJW0Sy2A+34u4d5fKDCjNG7vedZdX4BorybC8fDcOvlxBB8+Gr6VBqv8egeYYKIAl9PzIs5AWorE0Kh65+n/e1iQ1p2YeSx607fNfkND9PYB2lRgKd5ruT4G31UMXKnkTHHNRh85DVOK6S9aBGUYpkYtp9gCzbR55a8bKPdIVaI7wU532eThB5tSizE3272XpfKv2WKZYcNdY3GwMyRDafKUIFLB1odC4FJHlpNve5ILkOOAUpSEdwohR528GnKsRuUX+ji70geYZgdJRMWT/YTdXvgBHbZQgI2EeWYmvrWt2J0POEhj77WBlrEQbC+JJgtNgI9D9f6tXHToivQGUEazCRa0w9G8+/tDVuWf9Nf1KpInnp4wdnrTCLV6IDfwkrtxw3hVIQuEF1+lCmWt4f2OCoaLV79+MQyBEMC/CT+fv13U7JqMyM0n6duot4qpHNb7l4CzrOD4YUaZeRKNKhJ5okFkljvwN7/Iv1/SCM4XXhop/lSF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(9686003)(53546011)(6506007)(26005)(38070700005)(55016003)(83380400001)(186003)(38100700002)(122000001)(66946007)(478600001)(76116006)(86362001)(64756008)(66556008)(66476007)(66446008)(8936002)(8676002)(54906003)(110136005)(52536014)(5660300002)(71200400001)(7696005)(41300700001)(2906002)(4326008)(33656002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JINBC9/1vo4u3blfFresn6+4ET9Sf4YWNeE0VNBSw6CW7ARWlZYOqFJnFtBp?=
 =?us-ascii?Q?KEZXwPTRQPsbFDLo62ftyBpzKvvIha9bFb3JlW34Sz3F5ZzabhYZ8Jf14gqW?=
 =?us-ascii?Q?rNgrytBUqJo5pGaBpNUj68a0oe/U/YI+eXX+HMLIxgEMDTWUCI0jwLrSBlBH?=
 =?us-ascii?Q?aVP2eH948+40zAim4IwduaanJ2wZu5f24urSibVZwPG9AIisTqptdSeDkc1u?=
 =?us-ascii?Q?ppMKCq8M0jKToVxvecFIDllo62eyPb2m54xSpoJrRFyTFBIB5QQmXZERF4FX?=
 =?us-ascii?Q?TNvuueyulOJZmPCevvreA0GNZBVK/ZBeRr5EEqO4PMHTm8uXpbW6+wOvAiQX?=
 =?us-ascii?Q?OQKLWLxLU6Mfx8+jMRIdQC7RFMbzhrllOVboQbzF4bhnFD4Tv8x2deV/O50w?=
 =?us-ascii?Q?uX0J7DAhYY2RFCE6kI5Y2K1Q5KSYiZxhP1g3thQJRNQR/Z389j4Y+SW9RV2t?=
 =?us-ascii?Q?rNJLnjWNPqN1QpvDjVXzjPIW5PG8EIW9eXT0f1QSTN0h75AiqH1aC6HKwXRE?=
 =?us-ascii?Q?xkV4eMAgw7wRJu9PqE8KpYgf5HyUX77bzWOcNEYQaTei+O7gNKgJu5Zag7wb?=
 =?us-ascii?Q?MOytyl7ns0PmlesgtdQSfkQMMqcB9XS8cLNL/6tSu/qiM17ujXi/HusJs9yw?=
 =?us-ascii?Q?FJ7zornN3xEaL8xkOUdDeqT89cZHJr2Do3K9tz/5IbSp9BzIDP/dJ4F56Ztl?=
 =?us-ascii?Q?nvCDT/HW0ukN9IunmaQj0M2M+Tn3ENE3jDZiSheMTjYa+6KZfXBrbyZa4BNw?=
 =?us-ascii?Q?ZauzkdkCJ7RO89ZC2S1zrrBuZWjVr5DGd6hcaV8Hgt7vYqgNhJCuFj0LWA3J?=
 =?us-ascii?Q?dMbd0y4OmnxALKmEDesGurkT/CZO4mt5hntL+p0lUxpnA3cC2Q4J3OAOxrJ7?=
 =?us-ascii?Q?wm5a+hVml+PqVY9DwuXIBX/DihQDKwyFPKdCZINYjlRLhHCFJVmXM7VvNF50?=
 =?us-ascii?Q?G9lnvMkTJzX3iDLdP6remYAvBRg7UD/aomKSDF7YQrGnmM/twJBoXt8oPg7c?=
 =?us-ascii?Q?ZMn+FzesY7uojq3JebS5Sp24MlIXSTHSpfbh9gE5msQEYuotQDwX1o8pCDzU?=
 =?us-ascii?Q?o3yWAoAfbX2SB40DpznOS0+mZQXvUFRvSVSrbKyGKzrujjcbbYlQg8OG82hd?=
 =?us-ascii?Q?r2Zo0G8fn2Fa2verwp+JavMIOktXo+3uSGKBjI3AUmR9Z2b8YsvFqo9j0fPD?=
 =?us-ascii?Q?KVcU5aPvBmmOQgSwCvbgfZ8mMsdiob2Qf0G0u6MKwNaUDYo+diEuDXz5xAKT?=
 =?us-ascii?Q?SMhCk6RJojUfgVHjOWuNHaQYLQiDM7UVs1jFcXAXe5lBcBoUfKHProrfykBT?=
 =?us-ascii?Q?BeA7EAV2GW7FCuj+OMirbp7U1JSHF1snIMF/KFuL5jvQZ/AP6wrpEA0i7L53?=
 =?us-ascii?Q?1d4ce+Xst/yd4DQlPvz5dMIluLEtYl5nz5Yp/Aedyob4A5ApaDwa6xq73u4X?=
 =?us-ascii?Q?++FZ2NFfDMZYmlkDTzmjPVVbhCSZil15CsznxT34gb9MuCBsF6puxCxWiFLf?=
 =?us-ascii?Q?Wx9tpRtNTEoGkLNmop/87CyGoTPRJ/xFP4aHVeCJ3K/lWJ71h63wHfUaM+xo?=
 =?us-ascii?Q?S/Y47PU+cTyhThmdNqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc503a27-c9f0-43de-d818-08db449d4a40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 08:24:14.8960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ej/bV0bDQ3JAGOqEikXGG99dQoKW0dyOEAuAcUnzbnYPSAR1ugmM9ZF29YHfwHbL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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

Most asic using mode1 as default, some not. Could check here: soc21_asic_re=
set_method()/nv_asic_reset_method()
Patch is using default reset method.=20

Thanks,
Feifei

-----Original Message-----
From: Li, Lyndon <Lyndon.Li@amd.com>=20
Sent: Monday, April 24, 2023 4:01 PM
To: Xu, Feifei <Feifei.Xu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>; Li, Yunxiang (Teddy) <Yunxiang.Li@am=
d.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amd=
gpu driver

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
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor=20
> <Victor.Zhao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li,=20
> Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when=20
> loading amdgpu driver
>=20
> [AMD Official Use Only - General]
>=20
> I think you might be refer to : mod parameter reset_method will not=20
> affect the loading driver code path. If loading driver, it should use=20
> the default reset which might be mode1/mode2 or BACO instead of the speci=
fic mode2.
>=20
> With the confusing commit msg corrected. And adding comment before the=20
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
> Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor=20
> <Victor.Zhao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Xu,=20
> Feifei <Feifei.Xu@amd.com>; Li, Yunxiang (Teddy)=20
> <Yunxiang.Li@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Use the default reset when loading=20
> amdgpu driver
>=20
> Below call trace and errors are observed when reloading amdgpu driver=20
> with the module parameter reset_method=3D3.
>=20
> It should do a mode1 reset when loading the driver.
>=20
> [  +2.180243] [drm] psp gfx command ID_LOAD_TOC(0x20) failed and=20
> response status is (0x0) [  +0.000011] [drm:psp_hw_start [amdgpu]]
> *ERROR* Failed to load toc [  +0.000890] [drm:psp_hw_start [amdgpu]]
> *ERROR* PSP tmr init failed!
> [  +0.020683] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to=20
> clear memory with ring turned off.
> [  +0.000003] RIP: 0010:amdgpu_bo_release_notify+0x1ef/0x210 [amdgpu]=20
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
> @@ -3578,6 +3578,7 @@ int amdgpu_device_init(struct amdgpu_device=20
> *adev,
>  	int r, i;
>  	bool px =3D false;
>  	u32 max_MBps;
> +	int tmp;
>=20
>  	adev->shutdown =3D false;
>  	adev->flags =3D flags;
> @@ -3799,7 +3800,10 @@ int amdgpu_device_init(struct amdgpu_device=20
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
>  				dev_err(adev->dev, "asic reset on init failed\n");
>  				goto failed;
> --
> 2.34.1
