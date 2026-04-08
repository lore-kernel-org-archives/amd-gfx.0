Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778501073C98
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 11:21:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C3F810E611;
	Wed,  8 Apr 2026 11:21:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pIT3QfRg";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED8A10E611
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 11:21:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCroasaWh6m2gmp9erNfbycyTINtwOmUtr2aClL+dNaYvt1jpzwZecKQ+WG5hBc6v0i5oZrZLHqroHftU9K8RKOyU21OM8TaviItnNxPZWPPfrYBpqHFM4N2BoI4ril5KVFmXeHdSDFlEUFOiqvqw6H1DqwwTjb2Dv+GDCoyQJCUjK00xlOhtho94+3ZpR0wHBvxufjJ8Mevj6M1F1bkjItoQXDNQLpaPVLXoww7TnZivAOqfTpa9Z8wfoM6LoNJM7D4Ye/1eoM88p/ENGJrt29IZu/yOBEwK1D54bK/bAaJhzMK+0iqPTp2UTcsFdyMRPpoVg9MTCtyU9mE0CEugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iG7YMSHzi1nsXAT24XUSmDEobwnyYRS3l5OOQZKdJDM=;
 b=JIdJSx3jTx8U0hpcq3YMz14j0BATQXSO4ndWLvXH6PvHgNEVAu0h9/VBhxGAOhYbVpy1T2ywNwbvmsd+ElMAhcTSvfUenDVlvk4AUbDa3slWubRSv4EvelVoSs9qcW/99m7Ura7X4RN030cidSYqt1yXa8J2l3MnDUM3/v5luINbpvkoiHc+n+Z8RzSAmerZ5aXq0CW9NP+taYnIYfylL1G58ilIQhBVvFwxhTjlds/tTByZRdFClnHrB+3ssviissgI0CLPsDe35Eud5Nwx+zN7WSt6xEKK3Pp4x4/hU1p87s29ul08Af1ZTZshu2ZY95MVlGR/Hs5GU5jl/4nrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iG7YMSHzi1nsXAT24XUSmDEobwnyYRS3l5OOQZKdJDM=;
 b=pIT3QfRgcNibjJXulHqcGkQC8WD1QZ0CZTd+LksJiACOO9GIOKuifMnbwhHjk6dmUPngJUxj4GBTPaL+tijBVSns6eiPq9Yw1xPcRSFrZO1rxuKb6ZgC+/J7lMOJuwoISBemq75fk9zuWRyFveDn1cxcztAINmjDU2Yz0NdJJqI=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.16; Wed, 8 Apr 2026 11:21:28 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 11:21:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Topic: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check
Thread-Index: AQHcxz4zumhideOJzUempzuEjhLrobXVBHUA
Date: Wed, 8 Apr 2026 11:21:27 +0000
Message-ID: <DM6PR12MB297293A460D5D4D174BBB7E7825BA@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260408095739.59807-1-YuanShang.Mao@amd.com>
In-Reply-To: <20260408095739.59807-1-YuanShang.Mao@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-08T11:18:48.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|SN7PR12MB8028:EE_
x-ms-office365-filtering-correlation-id: 2aa5deac-33c6-4bd3-d80f-08de9560fa31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: ePnWPXXF1cqKAIuHPTlTMFgrg52fguoTVpD5IMHp5/eCOK06AEqJyui5OSh2GNJtTSQGDzwL1NaONLegdCfeZ6yggxzxagZby8kYr9q/vZX21xkQGMGRGUTL1zPc56rEXxGcvgF4fHMuh1URf35PypklHbP19tpM3EeXLm2iZb6e/b/couLGxlb0KvTaQZ0ncWLdoWP5MNVswN29Vnh5zAnhRN5r6xWG0TxWVo6GRsaEvMUb2N7T6ZIxfLblGjnAw23M7ulkgEJFJxLpCjGhtfOKIF+qTAPAWTF8j0Ue8sKM5z5jdWuZHpbDUqPqKkyXdVNOGGfUMXe4ez6LCIoCFis03Ux8i/RERTbhZAcUZuNh0fI4xNL1uPrHuH4061PjHoPMpHIBULqbOI4CjdtRHnLSqOa9IIKOmsTlcB6pliJK+F9l0OlapSH5xW0oBqTum/Orf+HSRNYk4jerTsQAUK2vYa86/OVGo67XMfL1MpmvcR23nxaTRTVrVVGQq9x8fxYQe0SjgLztTH5SLPuZ+TrLANHXAnnucqrFIQWPbRRUu6g7O63pSADa96qLR4hmYfwhPUU5co9Bxm2PoT8jS+RvnYqfTOMpCUTACl85brb5v8wz1Bzu6BhrjINEU8EwkYUgy29hxLY91pInmcqZKl6Zf6kUS7pmKWzkXyDpkOCT0jx324FA0s0wfePtj8QRg4Wps0lJRiXDdNjlvXAzykhaFCylgbSRMomyCJMeN1wzNYUCVC6rp+SFFlt5qSjYciyQyyeAeUudHjg5e06kgxwLZYIVgzKAtVpICtu5KRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNXrnEKwfB1tnTcApdcfuA7cH12Mr9Uo0XifZK7OaNz9BHK62PM/rJ2uceJS?=
 =?us-ascii?Q?R0np6DWjXzCs/uuVhECeLXbRt5hxL7co+iHHOOMEaqvWD7WFHKsl3PIi8yCA?=
 =?us-ascii?Q?J6QWKOYupYRdIKduDW4/wecvNx9nhgCnn8Eui4PuHKPsFTq8j0qOUQlg+y6f?=
 =?us-ascii?Q?i17682A//WnRfZVFy6uE2ESzMwSSKWJGCzzMyDFBIFvE5VkJ7rkeuwHLt/8q?=
 =?us-ascii?Q?ys0dZYhyGrSOaiNfDhBYBi0DN8PepfuNC98vo7wIeL8p89MOHJmOhrocIc4Q?=
 =?us-ascii?Q?ECgW4+7k288+9RnaZ9aqcBe6ShsafWk3u4ypSYIrOpl44/3+Ep2gMAgFdm7q?=
 =?us-ascii?Q?P2KLrRzYD5dDyG+Ii8ZMabZ9ZyyLtTE52NTrituR2vpCOl8a+kMCPesNfqzN?=
 =?us-ascii?Q?ndDSjD1JWihS32JcL1E4jottHINn7c7AEGQqB8FFOEqqOgLiUe/asfz59Khh?=
 =?us-ascii?Q?rpF+nHY06l3TfNM91m7RMnqpJAzunPJ+6uwnc7QEWWnDizoa4AJ7GWoXmpTc?=
 =?us-ascii?Q?8fU0BpP3JP9mEMqpj/7dvyQfPyN/8rF6oUngzdaM8oqIqF/jdWn+o3YQ2+uX?=
 =?us-ascii?Q?nbLI3KKsRkYX2lGx6L8EHF6qjIabVjPii8RHYLx9UgljLY1D7PLpYLmn2T8k?=
 =?us-ascii?Q?xYW/iiJBU+c8HAw2Lqigk/tAdmwlKhPn+mO0VI+gZ4WiXGO3zxwJZoS60PC0?=
 =?us-ascii?Q?+dSNWpsdOyLsRiVEfO0aLT49BAY061uKN//gNbNW5QjQ4MKwEoMXyic3D+W9?=
 =?us-ascii?Q?QKoTzb7Vfekt6649kkuWH80qGG0Jo8VqcYECq39GiZ75er3X/0HKPVeE9xt5?=
 =?us-ascii?Q?KdorTVb0yUzGLgBdBMQsOn/iPfO3ovPbfyVYeC3c7/N2wBrDCyE4MN/ThEsA?=
 =?us-ascii?Q?SLaUORvV+lxTpVIUZIjm+ls73LNX8T+MRsP2kXMyaUd8MHrmkQsjECVodLVj?=
 =?us-ascii?Q?O1unnbjMWxlJeh7BvECXly8df2W7YQJl74gIREgE6D5Ba8pYCTrM/xYcVycB?=
 =?us-ascii?Q?UarhPhQm9oy2idpHif3hKFPHODKWe0845er8AyAXXUrc8JLKNHZPJUhHEKxr?=
 =?us-ascii?Q?VniA2GEVXJFhT6xfhZil4nITeD15ufVRv+rqZp/kbmH1bf4nCjQMVtdpP0+3?=
 =?us-ascii?Q?7ZFiEmiy6SgwfbsMob8OEPOHq9j9k4dhwSRmzWW2YQF1YzVTg/uSUq1F3/Ts?=
 =?us-ascii?Q?BKhDGortEISaVIuwKAUM1AA3eml0zVa0JG8oT354b+lLYAf7R/B29zYRUDJe?=
 =?us-ascii?Q?NG/hTEeUNmBwwaTYw2Zm9Ae/xS2TUqDK2i7C+ZRgvIuSBzZbrbp5j3LVgm79?=
 =?us-ascii?Q?QnWWLEkGKiEFCT0zfsC6OctTtsMGS+Rny+73dFOgMUOKi6gYQL+HBVY4H1cR?=
 =?us-ascii?Q?F/dTE8RHLF2VP3mQHBeiOd97Cp+oUh+b7QZQ5lVSCEAJmkvDQW5yD3fHUVMi?=
 =?us-ascii?Q?2kv4y5qPy7/mJVj8HDzTfgzwftv07dwOcNWx+ny0trpQpZc0Z/KzXLxHW2PM?=
 =?us-ascii?Q?W5d+tTwZYFMF/XofxwaIaMtbDntfdXHGDXIbswujeodIiZyCrGCTkOaj+II0?=
 =?us-ascii?Q?Yjwu+juLXXLKUTDyIS57RZzyS9P5KA5Eah79e0dfCU0DYkPMrynjnEeEm07v?=
 =?us-ascii?Q?hwCMKa350ARk/bywvzpuTFcfIlxe3ALMxag7j/Fj3ARm7OR2+BfbZzxp1xU7?=
 =?us-ascii?Q?nFMREQkDkpmZIFhkR9Pddu8fo5A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa5deac-33c6-4bd3-d80f-08de9560fa31
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 11:21:27.9880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vup+Qn4m0TK9r6+LEesuLEEeGk7o2LAwHNkePCy4XCFXQ7JZpJRW1qIg+LZmEb4j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
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

I'm a bit confused about your patch.

The original intent was to disallow write operations when in one-VF mode.

After your change, the condition becomes if (is_vf && !is_one_vf) , does th=
is mean multi-VF mode?

In multi-VF mode, we should not create any power-related nodes, as the SMU =
IP block will not be enabled on the guest VF side.

BTW, what issue are you having?

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g
Sent: Wednesday, April 8, 2026 5:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>
Subject: [PATCH] drm/amd/pm: Fix inverted VF one-VF mode permission check

The condition was checking if VF is in one-VF mode to disable writes, but s=
hould check if VF is NOT in one-VF mode. Add the missing negation.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 938361ecae05..17fea9a2aa28 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2057,7 +2057,7 @@ static int pp_dpm_clk_default_attr_update(struct amdg=
pu_device *adev, struct amd
        }

        /* setting should not be allowed from VF if not in one VF mode */
-       if (amdgpu_sriov_vf(adev) && amdgpu_sriov_is_pp_one_vf(adev)) {
+       if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
                dev_attr->attr.mode &=3D ~S_IWUGO;
                dev_attr->store =3D NULL;
        }
--
2.25.1

