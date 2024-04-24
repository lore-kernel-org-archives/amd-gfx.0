Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072F6C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 07:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE8B10FDCE;
	Wed, 24 Apr 2024 07:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JlAIN6oE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91F310EBB6
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 07:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIwBr/Jkzmot9xwgdxoEPX+Be2HRaCrNxqw5HyscTSnNnmoY/M2SDUf0d0JM7mZVLo14u/une3/PsGLYwz+p2yE/B7ePVnXw3xj1/CWhApL6qr8Hg0ZflT1cLX9k2+xzjy4XYDwKv0INNzvNwhaCGucTRVyroHjL5HUoD+i92NFQFp8U5zeSC7O7oYKVUxcrVBhNMwz7evl/kzLoi0oMTLuhKco4gd0xtcQ4rgISwJwH2z4KqIWEsp6JGJev0djJ9jSSp3hLXDmoc7DC4jwZnSsHPfWo5QTYacWZKCcL27nqkG3uVFevHCwKEVLbo/U3s4wUB3M/JIaNnAlGZx5fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QEJ9CYitz4bAY6EhcPw9j5ciWTrZM3d+9onFfiF8r4=;
 b=DmMU0UmLDl7va274kyELboW2ps508co4n3RhSvOsD77q1MHK+CGwCW30J4eFZN6fk2Z2UAD72ISonSNnUnkNSC0xvpSQt3uwxgFcx3FlO3V4M/GdEFNqw/rATQzTyymnKaykgFdMs19oye2VtJk8h6QIo0gtcLwOWSz7jBOjE0/VFAeHhTX1iy0MeKHstClIL0vEjyQ99+CMmzIQ0KEfxsWSaY49gaLrZyD7cHdz8JdqTodfj/El6OmB5aEaubwbQHq0Hx7fnLEfPH+UqJM/AMeAJyY+vpkI57osWkyPiVY/o3P3bL3XmLNnVGtqbDmga/flBdfsHGoacTq2mTzUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QEJ9CYitz4bAY6EhcPw9j5ciWTrZM3d+9onFfiF8r4=;
 b=JlAIN6oEIX3OtRHWSsy8DVIt8OnSTvmlQxteJAECZWCCvQ7p57WQx9UHD21+8vhBMAccoyNeCOl7rXCJLme0nnShDNF8rMOjlbRb+Iw5EZ1Dq83gUW90btNH+cF+VQoAM/5YnCH6QmWz73YTr8CvJxwQZ/AwIDVek3FhJSWMg/U=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 07:58:25 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::14f1:22b2:ffd6:4911]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::14f1:22b2:ffd6:4911%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 07:58:25 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add error handle to avoid out-of-bounds
Thread-Topic: [PATCH] drm/amdgpu: add error handle to avoid out-of-bounds
Thread-Index: AQHalV6+LlNDuR9pWUuhYVKLEhX1WLF3Dyow
Date: Wed, 24 Apr 2024 07:58:25 +0000
Message-ID: <PH0PR12MB540448B4E3AF895641FD897CF6102@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <20240423091503.12691-1-bob.zhou@amd.com>
In-Reply-To: <20240423091503.12691-1-bob.zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=14865066-da3e-44e2-9c4b-78e99d09af7b;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-24T07:56:45Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5404:EE_|CY8PR12MB7657:EE_
x-ms-office365-filtering-correlation-id: 305ac1ad-857c-4075-18f7-08dc643451d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?GkJwHDiebJTHJpo5SrLgbGobZPiIsmUEkMCWvicNBpnYQTdKz7l0mNTVPm0T?=
 =?us-ascii?Q?NRiE1r/QjJsyiRfMKr6I1Coouhg3jPHCovHLQzfsETeB5JZQm8IE25dEcyPB?=
 =?us-ascii?Q?AIXA9R5xYSmYKluRYj3+JQUPgPnNSEH44g936zEY/VFYVIf7HFYGLqnvDPj+?=
 =?us-ascii?Q?L++u8VPesi7Prii7ag1zhbWKhPCyBOJnk4go1zmtbTKQUWA5zkkkS9hLNIoX?=
 =?us-ascii?Q?7Cu9EIjw9/Y16DaPTOgbUp5E0wE8fVmE98YLadgYn9g6Q6B+UlHWQ6MQR/g1?=
 =?us-ascii?Q?BUOPHJiOjUB9y3tpw6v/86y43vZFNq2pmjNzd++vRcXdPoCTUn1ro4JvaQTu?=
 =?us-ascii?Q?UIYXpFBj1ZIeYQlXMEzsyu/gXHc9ZQImz24D+X43rZk6INMcwdIayvQjcJ6M?=
 =?us-ascii?Q?XCAMk6dikERkU38BW+XU38i+SZ+tj53UkQQI4D7QDeU3bbbt+v2mSTJnrWdI?=
 =?us-ascii?Q?wFFuxRrcR+OcJLFBnVJ6mYMCgW4MwI+h1/nHGsksuo1V0LWiVbufpI+OP8TU?=
 =?us-ascii?Q?uIiVj1HJBrAbUYztEW5+07lh901ruYQ1PWGBX8L1Rg6Z8G3z2gf/R8P7rc8L?=
 =?us-ascii?Q?2ukJ6zcOzHvAXvyg35CbxNaGOzKeREIV7l2RUGno/TMhZktPLFb8vzcg1PmK?=
 =?us-ascii?Q?FGoG5nKPlqMHm2XUDfVowpHcX5K73mVLazu2iSrDaavhaKXmtXFAtbIf/9qA?=
 =?us-ascii?Q?FkfrhX2zg68FiopSjf+aTJo1EXW9BWwPzPHcsq9U8IeuKzw/MjDQGmTqKX+N?=
 =?us-ascii?Q?+wmfCpD8raRXN7SKDq3XZvTZZFe89r3nspvieRBvNGhrwUyqg5ABnNZwdiyj?=
 =?us-ascii?Q?R8078AFsRH6YMMVrys9zAFQEmYHod4NMtZSKKPqF75XoJrCEHoeu7Vqw5L4X?=
 =?us-ascii?Q?tIOfdNJzWF/ErrrnibH6JZ1+kPyZmlPoUFM8Px5LhT7RgdvMmA+SzBX1JULU?=
 =?us-ascii?Q?cR2WXjTs5sdzPlu/jelOLxzixOoVtxRAsOSS2DsCw8DsNK1ywA+oLjhjdMEz?=
 =?us-ascii?Q?5nUoNgNs3y3doANvrR8Ls6xe08B/31jMXD92xxqkHSHQwkwNMvpB2LS63Olt?=
 =?us-ascii?Q?xcCuBb2cX9w7G4NVTBO8kxw64yZTAmATsJLLBJavCXk6ZrL1yp1tZDPvtcJU?=
 =?us-ascii?Q?djSr2lBAicz76uLRLbcGDMPjh33ZNsdu2V1gCB8OQvZhPV9sWERemxcUSbVa?=
 =?us-ascii?Q?bTyFc/bfBf2I4u6gL3ByiMc88ddmQoh818sQD/FiokHNWqfsHGm4cEnLCYY/?=
 =?us-ascii?Q?/ilFF1gsoH6W8GxwBEjJrMXFP/tYMZq95XuvFdbRope/R76FovVz45YSO4rm?=
 =?us-ascii?Q?KSm30wHsKcKVKwaT4nC0sInqoMhKpIcKDmSS+9csdVCwlg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?39o5OphyFtYmk03+gRl/GP8qadzv3fMwT7cQRxNNGFu29XWnioArm+TJdG8g?=
 =?us-ascii?Q?zzUTwYCGWlwHkFlyxL/leOGlT4BOSisOs4mUDiqkd/GBmliuCZJRxvin140c?=
 =?us-ascii?Q?tHlep+1c5iKNMRNIKnQSPw/WvUJpAyMy1AbkaOOA2YIQQfTEvHY1bVM23B3A?=
 =?us-ascii?Q?V1W5ORqYRTmFPGCYKF1+nLN1V4G47DUJHPnB9rHUKmUeWHlI4oYbp+LJ2jqN?=
 =?us-ascii?Q?eXh0UHDNov5rtIjziP2LubYms8yNKdH8o2jeCl1PKzRJOVAOZBel6cj3LsT0?=
 =?us-ascii?Q?7rQ5l287tY0ZlKSvz4775lzfmLUVqaWZZURHNWDCfLHqYjXUGP9zsttN1llO?=
 =?us-ascii?Q?MiGl1khQQUCY2hyRTSykEc0r/++Q03r/USFu3p+DE9SexcEG4mJTe8/NOCdD?=
 =?us-ascii?Q?DdoGfLnOb1FI/VinWDQR5xh/RvJjlw1nb8SxaN9tR8i/XWhc1yu1IEiDEFEW?=
 =?us-ascii?Q?fRrrkPZxOHV3/5otAGGJVKzJp0uXM4rrjoypgRe97REHqEpKJToFub1hthgc?=
 =?us-ascii?Q?tXE1fa6CXGpwyHSk/TG0nZ+LL6H3XHwsoLzQrX/tNBTCa7ROsMs1yNALWv5H?=
 =?us-ascii?Q?5HuEhp8mBgZ0AECEysiueDQV3DUCH/AOsXZ01RrsyLlW+fBvtaQ45AU7Tre7?=
 =?us-ascii?Q?sdGXWFsnzpyJE6Wvgs3dkmnC5koSdBXLcHjUMI4CyBlnMo9zkct5ZO5yY09x?=
 =?us-ascii?Q?czWMDW9MPMe03ZvqtKR/55UpG2IXBp1Zmw3M2GQ0f/ddy7bMUGjGt6KFvqIG?=
 =?us-ascii?Q?DhXKifU9BdLQtAOexUe0mdVQZkYKjoPtosTgP+NyOVm4F4Vtxpdz0470csV3?=
 =?us-ascii?Q?FVX/4MiHhig4YZn8WSaqNd8Gxv9EyRRXYNL/+5EGycvbmLjz2VkiTiLUzl+M?=
 =?us-ascii?Q?jzoVaJf+HhDtfBamq7q3F2vQZmTFI/fEiVIF0NQE0dTKfFuxOfKy8LZjPM/p?=
 =?us-ascii?Q?rWFmMQa8CAd/J/wreNYnXM6kj5ShmaoqqTQvtoj+0EtPgSRwOWX8CFKxURe/?=
 =?us-ascii?Q?TVc0MEZ6ZhD5nSN6LCYzOId9TXbYU8b5d2iIOG8IcJSWUi9JPJ29jw65ZrXD?=
 =?us-ascii?Q?lY8mIu33S0N2uyydR8IH62nBoXOfWxUyN8Ml8TFiiMLPZFmVZN6+Msaxd/LO?=
 =?us-ascii?Q?MBvwPcmjTmvRApAkRyRgrWES75hDoPkCqYhRSLMQ9x+vXnLW9yW0P8sYVem2?=
 =?us-ascii?Q?6Pozwp0SdUBe1KyEX610YVDl/Hw8vumAmBFX0Hfwgg+ATuUSrJtmtBGLoUhi?=
 =?us-ascii?Q?jCUQvfornEre5mvhkSU1PVOqa3IAfnwzNz+z3rJ5cS37+rDJNoK39CWbvjcN?=
 =?us-ascii?Q?2YQDVC6k4y/KWTjBQNWuD89Ga3H2tc9QTW3gDoHjrkgHbjQ466/ocE8zc14A?=
 =?us-ascii?Q?GuCjShvzkR+FNHNmI8ZU9DojLm0VR/RoLS3REqFLietYsBN06JAd9QrzuaPz?=
 =?us-ascii?Q?+yEBIiwAVAklztCFhVM+ulQ2VGn1kUu58+dMh8I3olEDkl4UoIKyRODye95n?=
 =?us-ascii?Q?lzobdqqz3t4Oz6TjahM7esQEu/Cf8hslie7vPGpyhKMM5gyN4SpX8ip4RD0e?=
 =?us-ascii?Q?y/ghtV1T/L7PIH/Ym8A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ac1ad-857c-4075-18f7-08dc643451d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 07:58:25.3680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TtZp/04U/Mm5LeaRHdWltubwgAfh4UTSsHB4jeHnW4sIzDNK6q4ZmcHjvLJzFF9X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7657
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

Reviewed-by: Le Ma <le.ma@amd.com>

Thanks for catching. Please populate the fix to sdma_v4_4_2 as well if nece=
ssary.

> -----Original Message-----
> From: Bob Zhou <bob.zhou@amd.com>
> Sent: Tuesday, April 23, 2024 5:15 PM
> To: amd-gfx@lists.freedesktop.org; Ma, Le <Le.Ma@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, Bob <Bob.Zhou@amd.com>
> Subject: [PATCH] drm/amdgpu: add error handle to avoid out-of-bounds
>
> if the sdma_v4_0_irq_id_to_seq return -EINVAL, the process should be stop=
 to
> avoid out-of-bounds read, so directly return -EINVAL.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index e2e3856938ed..101038395c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2021,6 +2021,9 @@ static int sdma_v4_0_process_trap_irq(struct
> amdgpu_device *adev,
>
>       DRM_DEBUG("IH: SDMA trap\n");
>       instance =3D sdma_v4_0_irq_id_to_seq(entry->client_id);
> +     if (instance < 0)
> +             return instance;
> +
>       switch (entry->ring_id) {
>       case 0:
>               amdgpu_fence_process(&adev->sdma.instance[instance].ring);
> --
> 2.34.1

