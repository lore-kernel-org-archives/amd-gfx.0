Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B07C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 08:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92DD310E5AE;
	Wed, 24 May 2023 08:47:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140DC10E5A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 08:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KitOgjbxlVFsBYIAlJkxcjVt4c4sX45Dp29pazEDgUzrbps8kGzEb2uunWGJfbMOKJw58MP29q7c/D6Y8H8K6hB6w5R8JFjIv3O2KtfnM63ujLfNwn7IOzt9tlxrvXxlzla2NcubCexP/jXdQ3BnXNQ2/wbef3Ek5Zxy4crtgGIXzU5UTMhDBjekv6m2Q07CJfkQEjGQb3NAYVgGxvRuEZo/PT8ixXZ+T80bP03xBmTnLbDEJdSRjHEDDyuopdebwe7Lg2xT6cwNglQIrvpv/bET5KNeGrtXXxmPtXjwvFIz+rsE4n4m6R0KoFQB4oVztNSk8FAqwZvJimMGTWi6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5xkczj36wANxN7/wZMn+4WQfdiyx+KVrYCQP56kVt0=;
 b=RaJzA38trw3Hzq2L9cPhRZlz4stCxB3eX/dsSWtl5TMwMEXF0TrPpirZcPsQTtTD531T7WNBBUzCgZ1Rih6c2rcTldrLYZ0BqyBv0OeI6H4wp79dd1fRDdtsctlJeJg9ZVbDGVYQaU4vEKkz8z360ZbK6UeYrVKRjs04Wwyx99+p7ZDEz2PEeImIC2sTGxe4KcEHA78HDFcqwEeJXMVOGQ7J5j6lx4ItLNCao/Cr0AnMHR8wiCNVx6t3I3q6vk2AAykNq1cqf2fzDlDrX17XH5g05+YFP9m8evaelv7xFHClcax1kiimIEv7f0S0ajqryQrDIiQPC4ah8/BPvllEgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5xkczj36wANxN7/wZMn+4WQfdiyx+KVrYCQP56kVt0=;
 b=5mbzXCqJUCepUDN8AR+MBTxZmddV37xR0phIckhWf9J01GqC9NKp8Qvrg3EGu/53MSJMHgGEr36Te2sNuLSyUfb1ZlYY58rkkbN2gG/vFi1QskyQj0Z099KtHkkGe8+z1embGxWNb1oQqrIdBvWmiG0m0Jchfgq4Y3ra5IlQQUQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 08:47:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%6]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 08:47:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 4/6] drm/amdgpu: Use single copy per SDMA instance type
 (v2)
Thread-Topic: [PATCH v2 4/6] drm/amdgpu: Use single copy per SDMA instance
 type (v2)
Thread-Index: AQHZiYNXSqtv/LG+nEyv+TwdRHFL569pJbWw
Date: Wed, 24 May 2023 08:47:48 +0000
Message-ID: <BN9PR12MB52577296276AFE262511495DFC419@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
 <20230518122059.28815-5-shiwu.zhang@amd.com>
In-Reply-To: <20230518122059.28815-5-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T08:47:45Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=aa15cc88-906c-4c18-9301-53e3c8b83814;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|LV2PR12MB5750:EE_
x-ms-office365-filtering-correlation-id: 0b7f8474-b1d4-4d29-3133-08db5c338cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNiXlM5j0Gotfwi/WHdu9qiE/2lJGs8N8rn/772ZPef6PUtE3DvE2KSIWkjXYegwn/6ts/XGlSfHZzE80+62ZfQcCTUIvsUad1wWiwLU2HY3+Rix49gIz3sUmfFoez/CiZ0e/h29KiMmwxhDXEK7tau92xOE4THGvr0FzHKjXKY3VlPvAcZUltOwfrH/qYPIxw3OemgMgQ2nQLmbfGEXGo8+R+SrM5cyHMfGjYdNNTDVMagwVJkwRMyyEK7N2QuY9uqE8SG/gPQrp1T7jDJUrmpSDwxcLmOVF7DTyVQiyKw8SV1lSs1QT8hxTDVk+/QoumNnX4rVVsa5VHc2DW5rTfoNHX4c6fF0GGHdOJs+sYT1B7ud6FxKUUDNuxsLkxqn80G6jKGi69IPPvMlpZlwgqceIMzViCeFp+gHE7z51RSBIaZJT3keGQxWnkDEC2h/XCMEVGqoHn8dpZaFvRaqDQdGzAexRxrWPnyQG/iJ524zBQYEcmlC8BYZJ3uPrUt4dAlkPbPR2fh7q+7jy4WItU1BwmBAq3WLjffWCGtjJGjABUCgh8rR+qaTsQEAIBNZBdm5YGZ8xAqn8AgaZ1fVEdVmWStiPnqeCMmgW4nUXKJKNBf89W/s20C6FmyGCOBp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(451199021)(66476007)(66556008)(66446008)(66946007)(64756008)(76116006)(7696005)(110136005)(41300700001)(71200400001)(316002)(5660300002)(8936002)(52536014)(8676002)(478600001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(33656002)(9686003)(6506007)(186003)(53546011)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FjDveioRMlurKgxH+v2AgYcWkFr4w+w2kh0Bviyoy2ibpPWu/tG5PneJ//6S?=
 =?us-ascii?Q?0k0RErplx9ia4EGmwajWflBDeKqkCqClhDFdMSXmRd9+bfZWC+2yyaSJyVsO?=
 =?us-ascii?Q?kQHp5v/G2whCsG779rE9vPkxn3tC84qyEBrtsrgsQ99V2K/HyeYV7L8tpA3P?=
 =?us-ascii?Q?PRH/0DGPXBQaZFGPhn9Mxtt7iwTpUO5JLu1HvieBxJ0fOHd75n9Qi5Saluc7?=
 =?us-ascii?Q?FuK20NtdwX3iuxAT/pqhg7aQF0+ilsform9rcBcspZoYhFjoynj729tEez0F?=
 =?us-ascii?Q?VfU6Go3EbMssmkpLJBiLC3t1kqU3mBoETNfVBXggRKtTutmrNEokMMM14RIC?=
 =?us-ascii?Q?oqHLxX+KmbT6+2w0pp3bDZV1AAQVFZYXvLF0rahRQvELy09Cr8THvunubKry?=
 =?us-ascii?Q?pKHzAUctR3io8HIkVZev1OK3lX3eiYxAE3+JSiwPIduBIa9jh+QJFCMEFFEq?=
 =?us-ascii?Q?WF/QlcdKXO2RtciwkWRjol606oV8nELktZyEb83Ejbyr4Nwhnw7Vdf4zlkrp?=
 =?us-ascii?Q?ucmxFCKazKr6tTShzOLp3iIfgkvocHr7WuBiYZ7rMjJGrqboIVoSFjznvEuk?=
 =?us-ascii?Q?s6sXPOaK0t1ULoMCC2tcI1dzZRrfTGiOpFcbplz8/hJyVU1Jp9ckn5Pl1Ax8?=
 =?us-ascii?Q?t3Yb79kgllqeeYgkI7nWanyxqi8p5e3MEga+WRXPBqvcB6EYVCM8mHJtOYJc?=
 =?us-ascii?Q?qefRKzuNo5SmxiJ5J1Z7vNPhqn0M7Up8kM9+jIO/EStn7tPbtRMvu3K8fDVb?=
 =?us-ascii?Q?EWndUTnV9S6rpYWjo5ovjhtgbADBn74bcLN1epZGaCiLedlOvkZJ+QGKjSO4?=
 =?us-ascii?Q?SCw58E80DZlPbIkAFfXlkIErPNCdg3PKjUV7CKHQPiwd2P8nUvG+6OXdYN85?=
 =?us-ascii?Q?JUAqTIMGRuD3Zx5kZ6BG2zsBidb0vjHWk2sSHKLot1qRYcak9r3UfbtXMnhJ?=
 =?us-ascii?Q?9FxvZIlKyhjzF5sRKu8tFtHRSBZiHLgHKBjfrFGOGLkg5qXzVdaPIp9oYDS5?=
 =?us-ascii?Q?vxXLJSYj7LaB7sdadEsU2vyLoV4UbsKGUWNBQZueSJ4NjCbSwllUOGB21rcY?=
 =?us-ascii?Q?x8HDHWYrg+kYhCUi0/7thlJC/QlJhS8I7LL9bOs/dzIFSl1vWQaE7ILbCj6v?=
 =?us-ascii?Q?/nuSoa9fwwdzgmT439Q7+PzJ94r7OWSnDLVvPUVsaszZZTJ2dGvOp7mTOCMU?=
 =?us-ascii?Q?7FEs2yF+xbM88kkzFXUs9wXMMnKfec2hO+GVW1XZ4It2fMVTnrHjqkjOR3k9?=
 =?us-ascii?Q?FgnzzeqvqfRcFamGsrzfFSGm3LpDfVnxh2Af/LZe6Qbcr5Knczn/g0LpO0ZZ?=
 =?us-ascii?Q?+j8ycMPj+QSBF7xT0rmuOEarEEb8pu0wP/2W9ujqZydgg0KlAj+lnANscVc4?=
 =?us-ascii?Q?jMBSti/w2RJC+f736kCybIajSW+ZcV6l8XABdn/SjW5yQzfk+/L6PoQ3YzLs?=
 =?us-ascii?Q?vDVonc3I/nzls8IxB6B5Fd8kx7NOZhTyayKzEkRSz7z21qZowi9mXIa7d2lW?=
 =?us-ascii?Q?MaSWy8ZkfvO05+Prh3Ts4yFRHx0bahzFZGMsnoak0HKp5C+e+aHNTvTOHA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7f8474-b1d4-4d29-3133-08db5c338cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 08:47:48.0963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1w3h1Q0fpVjVyQW5ZKuUp6+NSE8Nrffh/rJjD9ZRgBJhiaaNpVF3xKc38z3CfAvzqrQetNFptNkX6em+pQGAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Shiwu Zh=
ang
Sent: Thursday, May 18, 2023 20:21
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 4/6] drm/amdgpu: Use single copy per SDMA instance type =
(v2)

From: Lijo Lazar <lijo.lazar@amd.com>

v1: Only single copy per instance type is required for PSP. All instance ty=
pes use the same firmware copy. (Lijo)

v2: Apply the change into amdgpu_sdma_init_microcode() due to rebase. (Morr=
is)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sdma.c
index 231ca06bc9c7..1797b45d0b55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -252,6 +252,13 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *a=
dev,
 				if (!duplicate && (instance !=3D i))
 					continue;
 				else {
+					/* Use a single copy per SDMA firmware type. PSP uses the same instan=
ce for all
+					 * groups of SDMAs */
+					if (adev->ip_versions[SDMA0_HWIP][0] =3D=3D IP_VERSION(4, 4, 2) &&
+					    adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP &&
+					    adev->sdma.num_inst_per_aid =3D=3D i) {
+						break;
+					}
 					info =3D &adev->firmware.ucode[AMDGPU_UCODE_ID_SDMA0 + i];
 					info->ucode_id =3D AMDGPU_UCODE_ID_SDMA0 + i;
 					info->fw =3D adev->sdma.instance[i].fw;
--
2.17.1
