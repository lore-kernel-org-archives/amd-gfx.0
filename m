Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A7ECCD195
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 02:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E128610E24A;
	Mon, 20 Oct 2025 02:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pd1vrrfL";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DDB10E249
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 02:39:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZm7FA4bi0HlVVhjoDP/zf9iiYU+ORzNmrYbK5mCfd1E5qEynZSAdsarQTOEN+DJsjTQKUEeFQOk08YwiGSe5JD1mzzYP6Ds87SE1tuTkJdq3iK7rvWYFDEVRrMfGqUZDd6bvF1rGb+K6iZilil8sW6LteLxPd8wuZ2ZTx7aP4GUwr5ETrPvM4XxrXtiA5ROBxWd7eCJmJRysIvc0cOihNMpD8wyVHImrfYvcAc9QP3102pIdvZq3tvIlxFcNb0j0fSkHacpTFqIy92bEGNMPa0PJ/wNXuVZ7F5Kt8MtHs6Dm6Z/1iE7gOL9j8AJloHzHu9ceA/igqimu4bCpdrysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJvjDpthP0sj5EMCENAv82K+QoMmP1Xmlalnq0+AfhM=;
 b=bID87dHE13pu1SZBhwYmebNHlUSqbWlyJq/AfT3pYxdAledQpJYNAH4fP2xwdFEJJUj09fYuIo64G9uM9B5Nr9tw/EAKVCoZCJeOgqPHCd+ezorUNa+Z8S806g34rwXmLBUzC18CDJKVt7lyQeE1ZIyaZKZYZad7A1rBIcTka36EnUbviaeyDGucdL/MRIvKneQmlqnxlibrbIKd1I0vgoTTKvxxNnm9p7jaxZ4dg/lTSnX3dG+lFYtmvC3hVj83hdB6owZM5PCpmWJfo5KC9UWZkpqm9IpveE9AzV+4Ui8PToLR1bxaBELBH/sCEljzLoDW2ZJ4wDlk+348EQrDBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJvjDpthP0sj5EMCENAv82K+QoMmP1Xmlalnq0+AfhM=;
 b=Pd1vrrfLRwY9XPocgFMYEiu7uaje4l0TAU9GusqM9lpP4iPhSEBDKvfXCU3HNbv92m1TO5mPdh+/Qwer93uZvHdzQCACo2jeUSk1+tY+bJf9a2gtu9PEpGyZVy5N/TKLtZUT3GPxPV3AFfSPwDFGglcrwTL986EqYX6rQy3tqOc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 02:39:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 02:39:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: get rev_id from strap register or
 IP-discovery table
Thread-Topic: [PATCH] drm/amdgpu: get rev_id from strap register or
 IP-discovery table
Thread-Index: AQHcQWkNQSLNPX4SX0GxX9ayz9Zbk7TKUrug
Date: Mon, 20 Oct 2025 02:39:56 +0000
Message-ID: <BN9PR12MB52577C9B5CF732BE5972DCACFCF5A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20251020022650.2969365-1-perry.yuan@amd.com>
In-Reply-To: <20251020022650.2969365-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-20T02:39:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN6PR12MB8516:EE_
x-ms-office365-filtering-correlation-id: 2350827c-0ed9-4285-655a-08de0f81f4a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?9KfhbgVJDh3MjliAPT2g+WgCgNs9vF8y1cBEbWyCdyAGDEkb77UDaajsg+JP?=
 =?us-ascii?Q?MZBbLUKkgRqOJ5c5Y7GCIFMu2Nb5vRIWiHYPXJqi582bpdDOJQf2fXhgYLfu?=
 =?us-ascii?Q?hc5+psDuMdJ4zfwQyB8j0G6XnC7vUv+y+Q4PiZNqVPSTHGTPiIu/wms2ciWF?=
 =?us-ascii?Q?Dj6FItt2NIPLcIBiH5h4qZWmFcrD4jxdVODx/JboXwaoVlBhyFrj6iXfoMNh?=
 =?us-ascii?Q?k+e0XhR7IsPDJWiQy6CPcm6WMVy3anKXn7zf+QbCDac0JFIvB+6amnDM/Tgw?=
 =?us-ascii?Q?dLEpM7CL+L3XBYxREk0MTJPVes87p2IA7Iu75OS3Q9P800szemTX6/ZQifBA?=
 =?us-ascii?Q?Npf+cUOOcBRBg+fj6PF/IrRdOzWF3fati2pzjHdWTwCbs/C/4d52FXkDVXpA?=
 =?us-ascii?Q?dNIelJ9A517e0Lig9AtzOf7HIHbd3yf4x/LNd4u5bDwwdTj8jG1eiV5PJOcY?=
 =?us-ascii?Q?zcxcJx5x4S+wpCRyn3BclyBLqPNmu36G1gPA28buDx1ioKpFNW7tGIOmYd+/?=
 =?us-ascii?Q?9KdWezs76aSScze4519+QVbzEWsQyPYf8nh/M1p3vTM2GC7mcWPSdDtVQa7Q?=
 =?us-ascii?Q?k1yhzkVTcqmwp0oJcnovXpj4rUGAme0IXuxmlftCG4Qhcq7F7og8fP7x93jC?=
 =?us-ascii?Q?g5Gxam+ws4HE7QOdsUa1T4q0v5uHY7osjtcHKiEIavgoYy3TwTpn7Zp6QYkj?=
 =?us-ascii?Q?qCTjfVGrQrHRQjr7SCEvqM4/s0A3SH+F6EYxDOFAuiHV607SPRc9AMF68pTL?=
 =?us-ascii?Q?nP0Nw1wo9+XsxGYip3GRp8wABNsczsDoGCRthtInxo5isd76LMa+dcP5PiB5?=
 =?us-ascii?Q?DGmAXcG6Ez9MLZT4o7JGUgzPugph7AuFZKPV54wQQX7vKNIYFUz/vEJWcyC4?=
 =?us-ascii?Q?l1zaq0wuJ2UzUM+aYf4d9HjYhCZgfay1lrFGSFn8FFi1qi0KCl29QS8PcaY9?=
 =?us-ascii?Q?Lae812ZsifCtGCM3AkWxiE00PIZjx12JQPaxVaBmOIOxPlhA2VB5uS7kbJHN?=
 =?us-ascii?Q?2CDBajVkMUSZR5HSQxk1ghII9e8YUGOWF0Mps0jlv0NNZjkmXATtG7bkBDgA?=
 =?us-ascii?Q?neXfel5UA+DvIiT3DwjhwgQbWNbCJ/y06c/oY6HynHKyk02SzlPDOLuVdb7d?=
 =?us-ascii?Q?Ye/M7KZ1l6Lhld47cYkPCHzY/IYEcMR/tkULYOCc3NKoZU5tFgKSJBdSsBW1?=
 =?us-ascii?Q?L3alS4hdRxLJD73NG3Q97wSaMJ09dS4jNuQ7mNrVMOvY69z6Vs9k0gGEnIWm?=
 =?us-ascii?Q?I0UwNTbKVHRZ1uQi+cm4KV26OKOkLpzOqPgeYhFQ3dtvdCHGNBjv9gDB382B?=
 =?us-ascii?Q?5xYmo62bKU3yN2pj4NUVqNo1og9eCgSUrSAHCPKFCLCpukrt3bByLXkhy4Ft?=
 =?us-ascii?Q?op4TK58z9qN9mcE54Vs8Ccbouzgm0arjsm0gXO+61NUiP6mPCs4uwyDfaS92?=
 =?us-ascii?Q?mWZY0kAYNoBt43chvT85+lSCvVp2bev5pkAdy7bodxsEXRbt6TWWZJBNbej+?=
 =?us-ascii?Q?FPd4HVuV/lxeSQFEr0VVPMPKZaMjNBvnbtmY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WCsH4ezg5JQX8p2mvOj45E0ns31JGCuwkb52djfG9ZyTTrIm2NT63Ob7OysP?=
 =?us-ascii?Q?yHP5PqDslWfjvu3ziBB33eDdtpX5WgSl7nMMg/vqEqpILw3iOF/StHwJ3atc?=
 =?us-ascii?Q?WdhIOTiTcM/E0w+My/f2E4NgoWzoYJftsVJrFuWWDeI6vYmf1IOZJUrK81gr?=
 =?us-ascii?Q?FdUopad9VidgNeF0ipmU5xFFX4q432SyxuqMvVTpZDnR2KvZcwo6kaZkmiUI?=
 =?us-ascii?Q?9kvYHGCRTtFXu5gZ4y/hYJ1EJcN8Vsep9kSS0kbI3vhPl3jZyw4odgZ1X8id?=
 =?us-ascii?Q?q9Efb5oTXBE1Otanl2gdwe2aQSOwwaZhPBMULIuu88oBrErlQ1bw/DXMpTbi?=
 =?us-ascii?Q?mg68De8kAif1TXhh7sH8QMA65n7agENblDLEWciohsd8tPNl8Cu50KtWdVgp?=
 =?us-ascii?Q?EcKKrZvmSSbB2wTZ07UAiZwualIwKbeGceUY+B2ks2gX8rWbIuKkVYqpTin5?=
 =?us-ascii?Q?nWp3AubDGAvQG5xxqBPvKQ8Mg6pVqgrP26ACbi0Jma6jf6lV6Qz+i0DHOrb6?=
 =?us-ascii?Q?xHCbWjXi4KBcXn0u3zxM9ntwmeLjSIqkR0wLiphSFkw4Zi6RQ3BPr+Rq16mT?=
 =?us-ascii?Q?9gV0JsH3Ut1gkW5h0q5H3dlGAh9ZkyrraQwx3HWrB2MaLaDA6JQhShzkI1gM?=
 =?us-ascii?Q?XnD9kSOhL5hSxQ0a2JNvSFer3b4l3PZphXH90gSnHtpcYjhLrBPFIcIdzJzB?=
 =?us-ascii?Q?RKVqNrZiJcYYYJUKAScbn/2EpcaRM/c7T5mIPzSqM9SRTE/H6qXZ+f1nwZAN?=
 =?us-ascii?Q?S9kpgE3qetJXfXZGvrNaN7/vvSoCX39XRn+O41mXVuFoUBYBk5bUoESY+mG0?=
 =?us-ascii?Q?QLKk75g3Z8Zf4OJDqbeG3Fh8P5F3e+0C52BVKvzG7v+ln6Z7shbGPQepcIHe?=
 =?us-ascii?Q?CbL9rvp+j2tDj7p2dGcAfrpsaLGr8NhXXuqMIOIel6mz1Gjo7kFrNKZYa+ls?=
 =?us-ascii?Q?T3u5ncvpjL2c1s9bQgxSvTATtU3heRGWCngrPLSu+nsvmjJQTGVjRVkksw2I?=
 =?us-ascii?Q?PmGekz+WzvsefuxgQU/rw9J4jQQK2mUnAMrdI25Lapm7FIWUoMuTl7Ua4fxw?=
 =?us-ascii?Q?fkYInThI4Wjz9Lr6thNtMEUjvhAsl3AA9bnvUqS/8RVN/rUQ+120kfROdw4G?=
 =?us-ascii?Q?2BQq1amdkyB2grurKAC9kcbyf33OCX4bEZi6Tv4sLhFosNVvuI3e7mJqIvrS?=
 =?us-ascii?Q?JEO/LGFWcQ04wB8EEOv9zS/4Ur14ydf6M7GREfAR0chpbQPcokbjpQImI5e/?=
 =?us-ascii?Q?hrKM71gdbT0RjjFFIjbTWtupB6tQJfVqXNLDGVc8sjsiOHFkvgveq3TdxKty?=
 =?us-ascii?Q?WAWeZeBlBr0hi2rhHo9KaK68+aFYSXM4wO6cyloGaTRsVRV+krOogT5CKy19?=
 =?us-ascii?Q?5AGjxtFsbqn4yPizOTM07WPeOS/7HeUfJEHAeX2q+QeiydgFX+AcqBUemZf4?=
 =?us-ascii?Q?NUHFxZNaXYrcwz/b7qYHy6oYAWnQYnOAfuS/wkSNkNmRLkocahtPxg2sqcZJ?=
 =?us-ascii?Q?5IDGIG/lP3Yl9Zf3UM96Gtj7av7Mg8dRB4QplDZy1o3GQftTdd8I4/4J7bRb?=
 =?us-ascii?Q?B4Xaw8G0cLhutiXodOQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2350827c-0ed9-4285-655a-08de0f81f4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 02:39:56.2627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1C4/Ztfpg4Z4tggN5GPtoxV4NmJFxWuPPUZqKp50/rVOltFAt9afWaFDOm3zFESZytMIJ+rnCfJmSMHSyvofA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, October 20, 2025 10:27
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com=
>
Subject: [PATCH] drm/amdgpu: get rev_id from strap register or IP-discovery=
 table

Query the sub-revision field in the IP Discovery table for the VFs to obtai=
n their revision ID.
Meanwhile, read the revision ID from the strap register for the PF.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  4 ++++  drivers/gpu/drm/amd/amdg=
pu/nbio_v7_9.c | 24 +++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index 2041737a5fbe..72897cf1ac81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1841,6 +1841,10 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_=
device *adev)
        if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0))
                adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;

+       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4) =
&&
+               adev->rev_id =3D=3D 0x3)
+               adev->gmc.vram_type =3D AMDGPU_VRAM_TYPE_HBM3E;
+
        if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
                vram_info =3D RREG32(regBIF_BIOS_SCRATCH_4);
                adev->gmc.vram_vendor =3D vram_info & 0xF; diff --git a/dri=
vers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.=
c
index 1c22bc11c1f8..bdfd2917e3ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -41,19 +41,21 @@ static void nbio_v7_9_remap_hdp_registers(struct amdgpu=
_device *adev)

 static u32 nbio_v7_9_get_rev_id(struct amdgpu_device *adev)  {
-       u32 tmp;
-
-       tmp =3D IP_VERSION_SUBREV(amdgpu_ip_version_full(adev, NBIO_HWIP, 0=
));
-       /* If it is VF or subrevision holds a non-zero value, that should b=
e used */
-       if (tmp || amdgpu_sriov_vf(adev))
-               return tmp;
+       u32 rev_id;

-       /* If discovery subrev is not updated, use register version */
-       tmp =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
-       tmp =3D REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0,
-                           STRAP_ATI_REV_ID_DEV0_F0);
+       /*
+        * fetch the sub-revision field from the IP-discovery table
+        * (returns zero if the table entry is not populated).
+        */
+       if (amdgpu_sriov_vf(adev)) {
+               rev_id =3D IP_VERSION_SUBREV(amdgpu_ip_version_full(adev, N=
BIO_HWIP, 0));
+       } else {
+               rev_id =3D RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF=
0_STRAP0);
+               rev_id =3D REG_GET_FIELD(rev_id, RCC_STRAP0_RCC_DEV0_EPF0_S=
TRAP0,
+                               STRAP_ATI_REV_ID_DEV0_F0);
+       }

-       return tmp;
+       return rev_id;
 }

 static void nbio_v7_9_mc_access_enable(struct amdgpu_device *adev, bool en=
able)
--
2.34.1

