Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F64C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 08:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2749D112892;
	Wed, 12 Jan 2022 08:36:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF0C112883
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 08:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ/pWzT1YDQ3VaJRqjnTtY40LOQNadxnTpA6+yEfZEtytNFcN95NkWJUINoRaPJCgZgaIkzlOGol1YFbvNaALjhft3MNfmkPskka7mOqWkOlTFpKQhWC2XCIsjntR/Xr7Z1TScHNYeqkkbQRQ4DknNVK7PQGMX1MX1HlP9QjnXxSHQzauGUEN1jvACT5dAMXceCdFHH6RD6uqtCcXupwztGOi9FGUMrwk1VeXTA/rHoEYS4+AlrpMFrIHyLyapg52VvKbbf3lgzRR6ikOv9rM5rwteEEtrC/SSuWAqNu0OuXfnouljUiWJqDnzrff+lwuaISrUpdKsAfqLWjs/0u8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqIyre7DxiwlTqp2Yzs1QSXnmF5Gwu2/YdFjppw6EvM=;
 b=dhB5bUsRXGwzQ9HduN5A5GVjRqZ30GzcQQrIUhHB2kM/VQCbzFlRFwLpgtZdUGncStajoQNHzNi87SyRQr91zI5l6NMiwgzlct8yT6miW+KN3MNeGcAFbiUPxLRZ6DLKE2K4jOxiyh1D4AeuNrAgycHS5wq7eR8o11chsXFcnEUoQY8LL3U6uZ1cRcMWemAK9QfXaYoY8zP8w8r7bAVDKFPt+0N84VydFReKiRjB0wesLEXYFl1O8fJsIczP9uTe7g85/mgBH+px+6I2zrcoXKUN9RYgg3I+k9Fs1Ps4G27Qw5ReO4UevJ2AZWeUQwqYTvAE5CE1CFsuInDsbswrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqIyre7DxiwlTqp2Yzs1QSXnmF5Gwu2/YdFjppw6EvM=;
 b=i4iSwaUoRy+269tGjHBatbVeVw06CViUtQWT1X13jDzx9++mHWriPWPc/syvRyB+Nwgw7065N+EhyZoE7yVZ3mVBvZjCFFIoneZz51MWMwwEWBFSGMSlGGNpLUkn/iAH+IdwUW8UmRncDzb05xjIWEIpRGhhlN0s8g3V6Xlz8u8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 08:36:45 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4867.012; Wed, 12 Jan
 2022 08:36:45 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_list
 if it already exists in ras_list
Thread-Topic: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into
 ras_list if it already exists in ras_list
Thread-Index: AQHYB4jQuSMps9qsfkKbyTK4pyb46qxfDa/g
Date: Wed, 12 Jan 2022 08:36:45 +0000
Message-ID: <DM5PR12MB177086BF0F422DFE80C636A7B0529@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220112074802.2867813-1-YiPeng.Chai@amd.com>
 <20220112074802.2867813-2-YiPeng.Chai@amd.com>
In-Reply-To: <20220112074802.2867813-2-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-12T08:36:43Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=abef01a3-48df-4b61-b3e9-38070ba244cb;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-12T08:36:43Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 460da3ca-23f8-42f0-831d-d8c7d9d9c2c2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dc277b3-535d-453f-d30e-08d9d5a6aae3
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_
x-microsoft-antispam-prvs: <DM6PR12MB26199E7E12CC5B6FF8F7D12BB0529@DM6PR12MB2619.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gXhv7/oSOQc1Mz4JbLMizJHbeYBGjZOV3K5FhiWypQTncehfDnKAXO5incTIO2Qwt1RIpQloBQyhv+47Cvb2+fedAcihPuMFdNo3RoMvKUhgEWjKPfALFHXuuCsVIytNYaqAuw244gA7Zvxnppsjpj7vkaKfl8ARhAc0aaQEMj63TFoQpBfYyejNDlKdgI270HEz/h6BW0Kfc1iT29LcjpZ11Qs/zP1GgjqPWVut5SreXr1XCboPH+oCEMN5IVODuOOkPMn9E3FT2bhkQBuc6Enn+8a5QWG7KHBvdDb5RhErjnKHL12sgkpshjmAilo0FWUtfi2JM+WqcpwYYj0fkKN/AOefz1jqxpgzor+LauxvD8Orb2RVqXnlidboHxv6zm3JAeLOvAPQBLRUUzvPsBG1CYecLsSVrsHAsV9xqejm9jTtfNU1RIU6YJ+IJwBbPqDTU2x/ZRnaNRubwB1vyMnJy6/8t7UBjlTAsh1dglw/M3Q0ReENCRlADCFyX3NENlvt0a+ukz93+9imZm26hIgxwtrFwkgApP2S+/4UzeTnTFocAlB222JJTxXIdTa/2JfzDiAk5WdCPiutEqTiWnBl8h5sM2O4MtKXFlD/3B+6FZVNsllqk3ugUc7atSjEPB+4PrZbegbWAF9/YWjVgPWY7bgbK1oUjXXAp3z4TW1dcTuwBIDph4j2Z0IXW2aej9tExt4VxjyqBaIF44gyjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(122000001)(316002)(38070700005)(38100700002)(83380400001)(76116006)(4326008)(186003)(8936002)(508600001)(5660300002)(71200400001)(2906002)(86362001)(64756008)(66946007)(33656002)(6506007)(66556008)(66476007)(53546011)(66446008)(110136005)(54906003)(7696005)(52536014)(26005)(9686003)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qoZyrn+GGma6a0XhrXEydVlUMFXcDLwCZDIKvDNy95E62ZGO2t4VNMpD+cp2?=
 =?us-ascii?Q?5UecE6M0Jl09iGLA7soEqza728gMAOXAx1geEILVNKtr/XeWEYRkJWLt6Yr7?=
 =?us-ascii?Q?O4p3//wanx3ecCx+pq9mayzZdhmxVhtfmfPzt0ykxMOn67AVrjelYIVU3GOp?=
 =?us-ascii?Q?x25zh5Zh0EwCxzGgvHXBqLAWVLctnNm9a6khfkEyGkGUYakuLqEn3M21mJ1S?=
 =?us-ascii?Q?5RhFZDNg1SDylu7KrMadOEHcxTkd3dIlWyu+Q4cF2b+X2+Zq7v82yODTtOHU?=
 =?us-ascii?Q?eXsiL5yNos6Z8OvvtDtDFxXkNO3TrGvuEIlqRj0cq+Kfjqg7CimfZ0iZS2Z4?=
 =?us-ascii?Q?9sFv652rTO+uRiPOPANeSAMaf9mEQAJ0Cfk64K2yYcwJ0OPvmbT69bZuucHS?=
 =?us-ascii?Q?e8jw7+zH6jEAuQ/ZRq64In6cJrsawIMiL9G6xDf7VAOK/skjKEf9ZfNBAIxA?=
 =?us-ascii?Q?hbNhVzEAISTf2nIArOSmzruHt84NopYNSmKifYXIAPYM/bA71xzJ+ko+8qDe?=
 =?us-ascii?Q?8JQIR7GlitpejgOyVjXTkUEcbGy8SOEBd+X4LFL6yvqW/ZGr3Xjn1peDzQM7?=
 =?us-ascii?Q?YfkNeG9NENgXvsm/DKx8Iczkrygyg5ksFco77Mn4xQQEMSLHyAgxtkY86gbr?=
 =?us-ascii?Q?SKxzWpfDTSmDLO2sNz4igjCNGUArLJMbWvIrLi6yHjM1EXu0x23pWIKeevBV?=
 =?us-ascii?Q?uH5WdySbrUMTR/ar+LXyuyJvkpmDlgDNTeUzw8eDkKX6v0AEaBNNLR5ETu2C?=
 =?us-ascii?Q?mvw9FASmmJY/2bh/mAtwqlXSovKbPo1/d2RisH2XspZUIQJG/kMJ6oOvFNMH?=
 =?us-ascii?Q?CqMGKsChlfkgTs9jWBnn6V0Yn98iZ5IPHyBa52bGbKMHBA8gaAHlpmsr+Pvt?=
 =?us-ascii?Q?dpGJPaJH1bVgobmIMDwjZOjhaj7Mhl+/PgHC3v6EzJadf4eNemf7VCr64yqO?=
 =?us-ascii?Q?GHP0SUU5aDElWiyuSuCdSJptaTcQUgGfz7zM2o60GyFVs3i4FDnkUuEZnsD5?=
 =?us-ascii?Q?jMen6d2mNdTTuo3yYtk82ymxN1KTutwf/gbupYaMjfjbdyca9pAUGeP+0osJ?=
 =?us-ascii?Q?v8K9C/FqAUxvCWUYYJ/sBt/FodbEFnVe7Lw/3SJX54J9PfPP/uT/eeEMtP5u?=
 =?us-ascii?Q?Q4MSSDPY81AhCh5jBBIosHAdR+dgLFrA0itcm4NTASzyFYkYtaEI8aaVvOpO?=
 =?us-ascii?Q?9+/bp3IG/onkDpiWS2muEfW+w8O0G2GjFUanyIdX+4k5JqHATPETeM9QBaf1?=
 =?us-ascii?Q?87Cpjks+X+V1Mr+QYPpPWOBaJpxNvznbNV+rcKMEURcR8v6ko+WxZXucb4K2?=
 =?us-ascii?Q?6jaa6xZIeI/dWXrmpeulUzqhPALkCcP7dGBDTjGDKNjf1kweQ3VsnKRnIqYk?=
 =?us-ascii?Q?1/UVKg4Gdb2sQRRzfSwTKJv3+AMgBj8JwrDCjCiHr6i4G+m3u/HoS0AESzNF?=
 =?us-ascii?Q?53U7pOql7XorNEiqf469XbP8F8mjKUB4Mz0BEpmwF2rrfyGeNjLb5eJnzCwV?=
 =?us-ascii?Q?ofdAOLx+9rLW42XTQ+EWd+quvbxnk+PzFpjJMnwvJw+3b3n7J/isiJAEQs1A?=
 =?us-ascii?Q?eMwP+rDwAQ+j9PdG/Tc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc277b3-535d-453f-d30e-08d9d5a6aae3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 08:36:45.6887 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tV/gTSU6Yuq4mtOhPS0yZV4CfHvAb2H25GVzRbzpjwCcvYHXF+MCpQMwvG1GlhQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2619
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Wednesday, January 12, 2022 3:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: No longer insert ras blocks into ras_lis=
t if it
> already exists in ras_list
>=20
> No longer insert ras blocks into ras_list if it already exists in ras_lis=
t.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 62be0b4909b3..e6d3bb4b56e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2754,9 +2754,17 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)  int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
>  		struct amdgpu_ras_block_object* ras_block_obj)  {
> +	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !amdgpu_ras_asic_supported(adev) || !ras_block_obj)
>  		return -EINVAL;
>=20
> +	/* If the ras object had been in ras_list, doesn't add it to ras_list a=
gain */
[Tao] How about "If the ras object is in ras_list, don't add it again"

> +	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> +		if (obj =3D=3D ras_block_obj) {
> +			return 0;
> +		}
> +	}

[Tao] The patch is OK for me currently, but I think the root cause is we in=
itialize adev->gmc.xgmi.ras in gmc_ras_late_init, the initialization should=
 be called only in modprobe stage and we can create a general gmc_early_ini=
t for it.

> +
>  	INIT_LIST_HEAD(&ras_block_obj->node);
>  	list_add_tail(&ras_block_obj->node, &adev->ras_list);
>=20
> --
> 2.25.1
