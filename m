Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF6EC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 06:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87E010E095;
	Mon, 24 Apr 2023 06:00:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F0110E095
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 06:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Arq8M0BWsnqYBq11WZmCL4n5S0wZlp5ne9MmzgSybJb7QiSBVMt02EkJmWJvafG5I9OznuSwc/a45GiGwNz3DXk6onFrFTXDKkqamFdVFDhVgJiVzYFcevqR3cbDj02qy7zsNgs8yBiGhbUrK0Gj9nDjarFU6wmUH05eijFz4z1p1Tqefo5VCCTmDD84bHqCOBvjVyehg2LClHxGTEYDmbadNCAJ/f9c5ivS1U84fJ3xehFOsA4rJp0UQflOi2V3Ex8LsNe0HY54FS4PRi8F+BbWZ4S0Zeh4A5vtHwxB6FmYHGoAAeZelY84ywjFPHTr7kfz1ItDVp5/mmRsR88N3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diuAdjUAl6NQ82JQQnNo4YhVuMke3j+FeAaouk0XXyg=;
 b=hCmfbEj6SbsBD+lP3Zw5QaVP17lH3yl3rx9eAkX9VOPdnToIYb5KwQykWPii/vVK8A1/q8PAfxG9XnFk/QXi3FIxkexINpcPHJZUeqwE9b7HFpWqaD+b3s5yD9sfpcCa4Bpx1772/HJtBy5WWGDo2hPrMjNB6mJ/+PsvloZekFtw9BcrG4tpVXExz/jr6rwRELWkYB1cmFytYRphsAlhInaWGQgoOkmVbIaNhZoT+1vCrfaCIq3pw5yfI7FaYInTADh5jZERqdjCxKrQcxWK3NJ26yPlBowH7VT2o5XqWkLda/ilLv0t3otPmQLpSpHxh1zvuPoPgxn0btdFRWlCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diuAdjUAl6NQ82JQQnNo4YhVuMke3j+FeAaouk0XXyg=;
 b=fHynvxh4P9V7ZBfDrrDVhA613faCuxGtpl5xl1o1CZwlGGPObS0tf9iA76TU9FL3hS3qzOcfCRigcd8dqRYltvmGwgrdvckun5PMbNLgLz6pXICRUjuObliGK6D45x+Kcz4H+zfEvJPQ5zBCUCSwplMt8m2PkkPXLf2GrRbpC/s=
Received: from CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8)
 by CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:00:21 +0000
Received: from CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b]) by CH2PR12MB4152.namprd12.prod.outlook.com
 ([fe80::1372:f6c8:8479:a4b%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:00:21 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Li, Lyndon" <Lyndon.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amdgpu
 driver
Thread-Topic: [PATCH 2/2] drm/amdgpu: Use the default reset when loading
 amdgpu driver
Thread-Index: AQHZdlBAlBEnCJjPSkGT5zvLzyF3Ba858vhg
Date: Mon, 24 Apr 2023 06:00:20 +0000
Message-ID: <CH2PR12MB4152CAA214495226D7C2A975FE679@CH2PR12MB4152.namprd12.prod.outlook.com>
References: <20230424015805.78747-1-Lyndon.Li@amd.com>
 <20230424015805.78747-2-Lyndon.Li@amd.com>
In-Reply-To: <20230424015805.78747-2-Lyndon.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-24T06:00:13Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9a4b894d-1d76-4320-b8ae-4f58f81d70e4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-24T06:00:13Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 25f2e2c9-a49b-4a58-96e9-2b7d0d7c951d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4152:EE_|CY5PR12MB6059:EE_
x-ms-office365-filtering-correlation-id: f662b10b-8ecb-47dd-9ef5-08db44892fdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZNgZt5tr6stZ2InNQn9zLnllvH4h+awsbIqcX0PYdsVVjfwwl+e7jrCnjJT/TGFI3cI+C94nEKCvnPDmrcwEQPQh5Fhr1sIOIOdQUtAZ4yc+cQYCFvsGYOuRVPnxhnAwCAYPLNhVUjjLcZqdVX7Yd8h/lfkjtaOMWOxk7XmO/R5QydLysmXWumpu4wAtQpdjga0WRAvYGSMx6k90MbPdYF7cgQwO1x/YzxVq1/2/vvu1CraS+Wo/apHprMItLl2mr6J5w/tZMj0yzPkLHqOL3QHsFdVf82xkY8w6IKrR12TzIRK7RNdVlnItVs2aa6+7rXkB3SWrdfkuls78kEYlkpVN/yWGZZ6sq5OPvycx60y3JwuE5CL88vBVg468HyPYikVRQAszHz52WjlNm7p6XZXQW/FmgR1Driayo1zihlXD19tY1nJY+INy+BytLJIwHNrIQyWHL8eEeAA47TeGf1QafPnYxKyN+fCLEx2gj8UwnTAIGLado+brpbC5IWImr4PbBv5TSc+RISjcrY9n8UCeStFmBlJQV7Xrv/Ep8UZYov8WAKNdkleJimGdZSRkPTXVz6piOrVNSp9U8y9GdGnJOPMJf7Rb1kFhgxL9tyafh1f1vCVVw8zaARmRtr1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(2906002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(4326008)(52536014)(8676002)(8936002)(5660300002)(38070700005)(41300700001)(33656002)(86362001)(55016003)(9686003)(26005)(186003)(122000001)(71200400001)(53546011)(38100700002)(478600001)(7696005)(83380400001)(6506007)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AuwbKfkggjkNrlXRy3Fjbu9z6Ja+sniQ7ragf1mnyeED9Fz2mxZS4R+GD8Fg?=
 =?us-ascii?Q?93WIQckb7dlOihCG4DeGJpocZ+LG1TSjtU8EsO0CZtLY5rOH3WV3tZzvIRHg?=
 =?us-ascii?Q?DevZ/WXFS1W0/GCF0WAVDcv8kSvpQr666tF59Rsa2eJPfrmMvgb5u9J302/2?=
 =?us-ascii?Q?62rvpiBpCs5eCj5D5eV76z20dn+T4ydXOwrUKACKdD29Tw9g6bYDRPe1sXgk?=
 =?us-ascii?Q?tWgct62U3mS402IsHin8avcjPcTiOnGPha03ggyQsVXu+j1wniYyz87aRs6t?=
 =?us-ascii?Q?+sh5N/Ve+NbVcwpdJTeTz+DKEWf5lSnJPK98YJCy1GZlhMlaF7wu+Nax/PKF?=
 =?us-ascii?Q?SHDUJOjphn9gU/WKhh4r8REAOSZ1rBqelIA2/tTggWDBfncm+aop0WUn2JPd?=
 =?us-ascii?Q?M41EMS/cLroWCK3br3TudlDWw87uvTMs7nr/lwFd0KhS+dhWUbLKOHrt2/DX?=
 =?us-ascii?Q?lO2L4WWOqcorQr0OIZwvYVuJqOcHA6cSDDQsH8MpP/U7nlpzXZ5N7bZndTwx?=
 =?us-ascii?Q?gPfLU9PexwalvKOCeg2KFcXC7N7ds4R4dJWwFsVlmqPZVWhiZOWttIc7nvUU?=
 =?us-ascii?Q?aWSzXaVgGscAnMndztOWoHGaJXv2XKm328E0J6dlj32TRIxBsYHg//21kHXr?=
 =?us-ascii?Q?Do5NtXWCZZYGGnXaKxWE5T7uNXK0eidNy8g8cj1YZ/u0MX4CSke+MuQ1spOl?=
 =?us-ascii?Q?YGXZskpZovyBL2/gO89a7jqEXhvf8tmtKdGYomQbZJnG2jDfBMPzc+N3fn5o?=
 =?us-ascii?Q?1lvXMBfG5rIIWUCBRZKCAh1u6JqK67Ln90EWoOfDgO63HgX3iu5VcHZkM68C?=
 =?us-ascii?Q?KOC+l4fcLTOBefNHalxf0bvbgjKJ339FTtuPE2sKsz18pUZ9zDoZWgnxVCcJ?=
 =?us-ascii?Q?FxLehH2gOEUMnXasf6jwh2Krd57JATy7SxFBcgPDOOHDZp4yEpbxvyntmNt2?=
 =?us-ascii?Q?qL1kdIp9dTJRHy5GdVFh/8r1+Vq7RM0D6KBFSKwaYJDIgVfDTclulXXvLcmb?=
 =?us-ascii?Q?d1lyYLOrTgHIJuyaZolN3hajopR/4I01Uer+5teGvKOZsFMAz+TluhsakrrR?=
 =?us-ascii?Q?iTVC4niUcGeA+T2yuOx3SaHp6TfB/Ldkf3JQKtWGc2PnCuJ0KIcaws3HeEjx?=
 =?us-ascii?Q?5EDCsqtTB8pFZYg5yePEmxEfidbjiXeKs+pxuiob93MLzC6Biwg4u32ExgA/?=
 =?us-ascii?Q?F74wC8SXJ3M6r2ajeq2ii0l19e/GKSsWlQXzVCWhEFibEVbG9WBiGM9vlxaI?=
 =?us-ascii?Q?bd2nHqeXX4j4VWMpMQvwV6VtiG5wE5sr6XZHt4wPDAS3LZHLv1oVfZ5gJJe9?=
 =?us-ascii?Q?8eUBXDUSB/8ZhAGmffKP8t/ss2ygy7Mal5lW5+ls/iqtnPFvkDbTnGAY2zI/?=
 =?us-ascii?Q?aLVOBZqtCpvGSrns7ZtsgpDXG6dHeAkVZhL/1zDe2+IZVGvPd3Kb5WAZvnk4?=
 =?us-ascii?Q?mCg9u3+Qbx9T17zUIF8Mla+I/EPh1i1k4joHTQh1t7ITniWMW1rFG3ccYhkj?=
 =?us-ascii?Q?knm5OATMjkREGs/H94eGkJ3cohF42gbHXqUaxyqlH0WTIbx7GgiT8QmNRdT1?=
 =?us-ascii?Q?/OuUBJO1QTKXdp7qwCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f662b10b-8ecb-47dd-9ef5-08db44892fdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:00:20.7036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UfhkhtWqZSLC3kNIyUbyaiHMdADQeNLRbwyMj9Z1KeUyJgGb096APUxz0sKh2njP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
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
Cc: "Li, Lyndon" <Lyndon.Li@amd.com>, "Li, Yunxiang
 \(Teddy\)" <Yunxiang.Li@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I think you might be refer to : mod parameter reset_method will not affect =
the loading driver code path. If loading driver, it should use the default =
reset which might be mode1/mode2 or BACO instead of the specific mode2.

With the confusing commit msg corrected. And adding comment before the code=
 " r =3D amdgpu_asic_reset(adev);"



Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: lyndonli <Lyndon.Li@amd.com>=20
Sent: Monday, April 24, 2023 9:58 AM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>;=
 Feng, Kenneth <Kenneth.Feng@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Li, =
Yunxiang (Teddy) <Yunxiang.Li@amd.com>; Li, Lyndon <Lyndon.Li@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Use the default reset when loading amdgpu =
driver

Below call trace and errors are observed when reloading amdgpu driver with =
the module parameter reset_method=3D3.

It should do a mode1 reset when loading the driver.

[  +2.180243] [drm] psp gfx command ID_LOAD_TOC(0x20) failed and response s=
tatus is (0x0) [  +0.000011] [drm:psp_hw_start [amdgpu]] *ERROR* Failed to =
load toc [  +0.000890] [drm:psp_hw_start [amdgpu]] *ERROR* PSP tmr init fai=
led!
[  +0.020683] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear mem=
ory with ring turned off.
[  +0.000003] RIP: 0010:amdgpu_bo_release_notify+0x1ef/0x210 [amdgpu] [  +0=
.000004] Call Trace:
[  +0.000003]  <TASK>
[  +0.000008]  ttm_bo_release+0x2c4/0x330 [amdttm] [  +0.000026]  amdttm_bo=
_put+0x3c/0x70 [amdttm] [  +0.000020]  amdgpu_bo_free_kernel+0xe6/0x140 [am=
dgpu] [  +0.000728]  psp_v11_0_ring_destroy+0x34/0x60 [amdgpu] [  +0.000826=
]  psp_hw_init+0xe7/0x2f0 [amdgpu] [  +0.000813]  amdgpu_device_fw_loading+=
0x1ad/0x2d0 [amdgpu] [  +0.000731]  amdgpu_device_init.cold+0x108e/0x2002 [=
amdgpu] [  +0.001071]  ? do_pci_enable_device+0xe1/0x110 [  +0.000011]  amd=
gpu_driver_load_kms+0x1a/0x160 [amdgpu] [  +0.000729]  amdgpu_pci_probe+0x1=
79/0x3a0 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e536886f6d42..9738e3660cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3578,6 +3578,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	int r, i;
 	bool px =3D false;
 	u32 max_MBps;
+	int tmp;
=20
 	adev->shutdown =3D false;
 	adev->flags =3D flags;
@@ -3799,7 +3800,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
+			tmp =3D amdgpu_reset_method;
+			amdgpu_reset_method =3D AMD_RESET_METHOD_NONE;
 			r =3D amdgpu_asic_reset(adev);
+			amdgpu_reset_method =3D tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
--
2.34.1
