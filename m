Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0184BC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 07:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A084610F915;
	Sun, 28 Apr 2024 07:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1KDW/azO";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C69C10F915
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 07:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxeLAnEhZCnPdQYyef+LROzhKZJ6eRUKjIiIsUDiqkg78gBQSIWEc7qkq0Gt3J1fdnxyPA2XYy+PazESr9FuKUCgEtx6wxDXfNURthA254lEJ70WYGYIQg5iKQ2wZZn+ah2nzuaW7lhSnpBZt5IBuz95aijz3moF2b5B87hbkIYxhBGFBLd4Ncfj+7oAiu7DYmXo9/LS9INZJiWDcXCDRdZMg5ndWFrvi2xkkLTHXNBjUqjshbPyZSVuw/jKXUkhkb7opKP/oYukyqQKn7wH5TW4uNo+TLhaoTpoSo5qY320NqXyuG1z73g2FOl3f807Z6XWlDA0xTiS2rJZAPLIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHSLvsq41gQV+OiJQrn90IKS5eAAyVWcQvQ4zxPzq7U=;
 b=V9fE2arhxfRL2KD/JpYEyZNLcPtdElVrCPh17pcng+Jq5WlrfPMNzgwJZ72NI9ByCCCHHiJrp4IS/Nz+4J6ZYW0oPpnOuOI9+zvksuR9WizpRkqAYS+OsQnSWTNpTfPKmidQhCZ2oL3D9mjXZKgctackFix740dz1P6B6IT5HEtvSeBX6nuA6GP69zXGETWmWorCjIqGLDBQ3IbH5kllzYbzMQDcm1Kgvmv2ersLhUIsSv8Tr81ouSwTAx4zjv5vRAbGnHq/bVTqJtqRRgng0Jfcpf4REZC5mGhy6r7BkAwqFCR6Z6iBh7FkvwRJnrjvpLXdon647rmg/02ltU4+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHSLvsq41gQV+OiJQrn90IKS5eAAyVWcQvQ4zxPzq7U=;
 b=1KDW/azOanshLNiA4E51wZ1+Mmjx2HNk/EQny8Y20q1AnVz+f/9HzOgCIpLCUOpfW1oV30SuQWZ8DqHJEGqJCnupCJp2t8hFiRPNFlit+W4jjZ+trvIrdqrd3tFVMumBEjAmwSm6rKlEI4k1SBUZGF8w9CFxz3rinQN8KAcI27M=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 07:17:24 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::de07:ec43:e847:2f50%4]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 07:17:24 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
Thread-Topic: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
Thread-Index: AQHal44Yfl7GfM7LdEu0uUuNCsfxi7F9SRfg
Date: Sun, 28 Apr 2024 07:17:24 +0000
Message-ID: <PH0PR12MB5417EE8ADD5D5CC2F3C5FA0D8F142@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <20240426035742.90560-4-Yunxiang.Li@amd.com>
In-Reply-To: <20240426035742.90560-4-Yunxiang.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dfdba7ec-1c6a-4472-9d35-56977f2646fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T07:17:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5417:EE_|PH8PR12MB6841:EE_
x-ms-office365-filtering-correlation-id: 19987c17-deaf-4ca6-1322-08dc67534099
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Jvu18cI/ZouyHEuwlU8lg7zOjzPNRu86Z3880FqbFsp3DVCzOftALthN5gax?=
 =?us-ascii?Q?bG1YRmjPyFSPDcIcdh+edL1yjC0qw5c5FJRXrfAWd3DG/OLIL6eBYk2d4jjD?=
 =?us-ascii?Q?aWxxfLxFSGNb2+37Oi7aAUA80lnVT5jBM6ip2r0KmJfMecyqLghrOqcjzIFP?=
 =?us-ascii?Q?zfpNmLkARNTVR12JhDMrrUYi8YCZotL2m7YL8+wABN3CjDzCOUsv45kzO//3?=
 =?us-ascii?Q?DI97iBOabjlhtgyVU/xL8hrrAoSAvpQMXhUPrq1/ilUpfhHxHmIaQ+/kXXXX?=
 =?us-ascii?Q?tJyjikkUpE6Blkme4B0c+LSXHRlyOCkW9mMuXxo8qNqNbHZwkU+8leHiD0XC?=
 =?us-ascii?Q?Ev+Lc9k79CrJqqHtbVNQH1udcZFF/PhO6HJNxRvalxRPyzsDbt4lh3XDxQRr?=
 =?us-ascii?Q?uPZnMZA80vqQo7FS0tLmpjJAAY7Zb0YhYaVchP7YZ0MSNvP5bd/IkwJwDugX?=
 =?us-ascii?Q?Mkg5OZ/LDvW73z9Css8emdsoZ7W0JjMWGPJPzdPu+0wp7/mFMi93XpGPUpav?=
 =?us-ascii?Q?Oeppy9q7R1SeNUE21cIOkNJANKTTqlwS9/vDprydhtz/2pYCECz1VdFr5V0b?=
 =?us-ascii?Q?XlC12zn6IAUJAdASe/pzjuYJSHic6D9XYZVW2SGuyNdT/T5gTVLipmUDQbUR?=
 =?us-ascii?Q?bz0eBTG72rd5/X+08M8MNQ5ZXGBgDg4eadbjrhHVWIX1lrOvspVSI9j5BlTJ?=
 =?us-ascii?Q?XjQdgXuvG8THLiPdPLxGZQarvjnIYEUEokW3Uz6x2/RkdkfndEOY8SR8q+p4?=
 =?us-ascii?Q?43cFbDNEYMZIwiufcWMUpAaRhd8lG1stQ29T5cZrJXxoak283kp1Ibm5SgYR?=
 =?us-ascii?Q?FhV8KCemKhMwbdNgI7vTabBGcjsYYXuZn2aD3IqEOKIQ8NkSP2xhWdphjrnt?=
 =?us-ascii?Q?3jw5wU7oRISQIPaHscm1IKvnx1EEfkzkd+eRVyk8fDb24bHsw1GKnOp0xMUM?=
 =?us-ascii?Q?zKvMZJ/LB0F1a8Xdo1Em0c9aujN/l6aJ24k0Eluo5QN8dJNcjCI3K+ns4Fjc?=
 =?us-ascii?Q?rSgVNew/DBKHTkmqLarMaLY088+oIM1673JSPlB/dTCFqVLQKt7Oym/wRIVt?=
 =?us-ascii?Q?DvBp0Kn8z1kO31mAFVyBQR0DOYemqIINnoTU69IYbllHQ1SuCQyNQsXLZD4r?=
 =?us-ascii?Q?fQJ25vQo/qHX8ssK4CDpOG5mzUUI/vq9u9nkGyHzB6BbGXHO//o9W4SYg8dJ?=
 =?us-ascii?Q?VJXRKFBUsOTpncAArr+R8vUNdaeKdbP/C+I8DIgU6h3Bx4ySfrlwAn/o4IuM?=
 =?us-ascii?Q?PaQQiYkokgRukLhLNKcVDAogklvgUNBCMks6roEG/PehY2pHkqLnNMb6vB8s?=
 =?us-ascii?Q?B8M8PdHGQBLTJ6wOysjWYcDzoYJTN1HT9+/2fCGsyA4wcA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vS21X+vyFskXldA6BiP73VRaJwNB3lUa6Citi87YoL4Xe0vlxsWu0msxGSH4?=
 =?us-ascii?Q?kcpPv15tdJYNWlWPdU9EQmIDwMMOhNuoa/zWKMnk04++4uYbeUvVbtMMQhoJ?=
 =?us-ascii?Q?n2RcYMJG+AgDNvAJ4mIRJTN1T0mfXXhlP7ZwhZdSqO/cZl+fQk0gTsInracG?=
 =?us-ascii?Q?gUQ1uwq0G9RkoK0ks9oWD9LOfMB90IxyhKMhWIQWYqCzTd+4QAB2FOM98LMj?=
 =?us-ascii?Q?RaQx7EZEn/BeL08uQx+RRb2ps1XgUmuo6AvY4lLTxwDFKk++xf063Ykuo04k?=
 =?us-ascii?Q?y6Wmt3lsqlbHk7w0EOUCeT0EgYTr84KfqHkB9E2wYJV0gbQIleEhzZOA6PwX?=
 =?us-ascii?Q?yFF+io75BQoJF8Oai51BUXesUqvWginUWzrDu3q4aJhF+1tmP1QkZy28QZ+y?=
 =?us-ascii?Q?T6JhJ/7vh1X9czg75R4aaR25fYx/1ZdTvHw63ib4+EkvLxsJSziyyMLsQ/fo?=
 =?us-ascii?Q?lv5QmhTjDoE/0Iql037up2LEOiy5cbA/hp1wJ+K6Q/pJfN451OR5q7TxPWdf?=
 =?us-ascii?Q?dl4FjpB9d40r9ZGOvCcQ3TcWo77AYRpLH4TQ3HwjvzL+O6tsODHbEmExF4tu?=
 =?us-ascii?Q?rmYQqN8k7i7yZDtlU/AvYRiaM2EmVOEAr3m3/yfx7fisg+9EroIskrNMTqiM?=
 =?us-ascii?Q?Xd6KsDdQvv5hI/zZlh7XcGB24OJSYpcXdeYIqMiR4UUxQqwF/1TEjaqsT+t9?=
 =?us-ascii?Q?HoDBJKrclAJOHz6T76VguyCSvxQpZQ6SRA3QL31AW+SHRSEiwe91jfpfsBIJ?=
 =?us-ascii?Q?kkECW3Cal5f+stDurVS9u50SEZp3+I2fPahL8VOMdXfDPjC4i4temyWH+rQS?=
 =?us-ascii?Q?PEQ0cgXGafWYAOXhduKvsDPA2VpZkEPVASO/gXRfxqPW1Clp9T/TBs7u3CqO?=
 =?us-ascii?Q?tlUw8jjCKJN//3Q7sy0F7h8cRYXAbB0sEQ+31cl6F5OAJzUdLnSvOaYxanyL?=
 =?us-ascii?Q?TxuO6r8QMblsas91q26yjly2QIl1LKugggoZtmcmiCHIl/e7l8fJ+uRVkR+a?=
 =?us-ascii?Q?KE8a+soJXHgIe/8PsM/sWU7gdIEPMqJfbA6mG+ScyaA9w9+iwJEOeTiSilot?=
 =?us-ascii?Q?u1qC7D8MxghZROkWlbIijbHcwc5rWgddyA18AAUEVrZQbuC7BKuCS9oUBbu/?=
 =?us-ascii?Q?UaHytD6LjS+Ys/wasL5StcTqxQnt492hJpUkJF75deeSy1VXQjXzPJsLGrT6?=
 =?us-ascii?Q?FpAUkczrzPSLReLFt7ieVmf2Yikv0VSWNVikT5z/2+8ZWsquwg5p/nnEstn9?=
 =?us-ascii?Q?3pqtUJcAsCe4k9CzsQsbCCA4L1pSDFMJdGfWH9h9XlHCFOsbfMcz+KBx2S4s?=
 =?us-ascii?Q?U1RfFmc8IoWzC4O4s3SG/kvf5BGcUJHatlbY0372sSrchGfpzyFB0CmeNqnq?=
 =?us-ascii?Q?9NMwVNwWdTVIH0+ouaWotCFzvddKGb4l6CrlEFxxHcWbO2/W/g5ZZtE7f0RQ?=
 =?us-ascii?Q?pe8WKJ0q+OfRp7562MCsEButLmcw3yGb8PG/ay9k8YCsXgWRkGcnIoEcjQzX?=
 =?us-ascii?Q?Czjv3wBGwa7QJs71FCGb/cZCqlwBHm7jgtiHMDuS6lNQNfV50/yfTVJVMsL5?=
 =?us-ascii?Q?otuGsxjN6UD+grcAr9A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19987c17-deaf-4ca6-1322-08dc67534099
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 07:17:24.3288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTqFttJyYgd5QSKC94mecmc4Kb+RaNrGM0Yz2xE2OFViV1b2OwE5SGGydWjs1Huu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

Emily Deng
Best Wishes



>-----Original Message-----
>From: Li, Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Sent: Friday, April 26, 2024 11:58 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Kuehling,
>Felix <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>; Li,
>Yunxiang (Teddy) <Yunxiang.Li@amd.com>
>Subject: [PATCH 4/4] drm/amdgpu: Move ras resume into SRIOV function
>
>This is part of the reset, move it into the reset function.
>
>Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++-------
> 1 file changed, 5 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>index 3c4755f3c116..8f2c1f71ed9a 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>@@ -5119,6 +5119,11 @@ static int amdgpu_device_reset_sriov(struct
>amdgpu_device *adev,
>       amdgpu_amdkfd_post_reset(adev);
>       amdgpu_virt_release_full_gpu(adev, true);
>
>+      /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need resume
>ras during reset */
>+      if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2) =
||
>+          amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) =
||
>+          amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(11, 0, 3)=
)
>+              amdgpu_ras_resume(adev);
>       return 0;
> }
>
>@@ -5823,13 +5828,6 @@ int amdgpu_device_gpu_recover(struct
>amdgpu_device *adev,
>                       goto retry;
>               if (r)
>                       adev->asic_reset_res =3D r;
>-
>-              /* Aldebaran and gfx_11_0_3 support ras in SRIOV, so need
>resume ras during reset */
>-              if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D
>-                          IP_VERSION(9, 4, 2) ||
>-                  amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9=
, 4,
>3) ||
>-                  amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(1=
1,
>0, 3))
>-                      amdgpu_ras_resume(adev);
>       } else {
>               r =3D amdgpu_do_asic_reset(device_list_handle,
>reset_context);
>               if (r && r =3D=3D -EAGAIN)
>--
>2.34.1

