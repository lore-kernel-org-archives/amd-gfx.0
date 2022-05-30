Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B8AC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E7110E233;
	Mon, 30 May 2022 07:09:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC3510E221
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hby2bjuCbX90gDYftdeJjjiKuD3NTPZUHnjztIEv0Gd5r2vAiYLKpgJiV+K5qLZI+oxoZDaxgN0WuuHPQx3ngCzuVc+G2q5BSxWE811AH+7TIdl7S9RLh5rkqcCqZxxggIIDHamd/6hpuG/Ue9GGG7L+XNUkgBUBdYdf3QSEJUHYBMgPh6rWmmsVFcdF9j2ehuo/2z3pq6qg4mjYd96IDjRm/t7MWCUVdqzMUcf6NGQ8m/ZRSapBkonGscJmKNKZGePz4ty95Sf0qb5P1uStmX+cSuo7tYcp0117dK6Rz6Pts5Tpm5fUTKhS4ousn5/ioSYwchfiLu3Kkdkg5hLmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQxx4a/Z51YL6QSmn7jbTVBAGUYxB25PlwbnZNBftzw=;
 b=JR1COSiN0dBoLwaj5wKoNV/qCVBhEI9JglM+xzHngTU515aHM3zaphm1fZjWjjES1utc9d1HWJm7Y92Qdh3fWPK3Dq5HzrFcpUbUSVKGTigIsdU7Q9wgtOKgcs9+2Djhe6hblUViCM5QzJrPjwVSBmuHRPfKpYBUFfmCmCsKiNkvpVIpnZWZ5WzslYT4AmdqVPhLlwFs3zcL+luIEeQ42KA+fAc32bPvZwm43+AdaW3x05UXuKlHQ8iboAXKGBFIpX5qw37p6KMdgCEeSjQNa6I0AxA9jM+1zKJXWgUULWZck5HriFK6XhaufvA1XsrXCf3sMQgk0KOOFDXaZEYdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQxx4a/Z51YL6QSmn7jbTVBAGUYxB25PlwbnZNBftzw=;
 b=y/u4lob2bGMNEIjgvyUtu2KEiaqlhbjQFbVJGy2u0vf141OKyCL9THADm+YGbtiF39OwKxmgoPQnQcFA//lMF18v5Wpq1t8CgwYUl8Peh5C9db6bJfT+qz+JYEy0m2azex5PRsqmgIZldgfu/chvHoydpafWnDibd/xE4HNVkSo=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Mon, 30 May 2022 07:09:14 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::95af:3466:5c5f:1202%2]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:09:14 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit type
Thread-Topic: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit
 type
Thread-Index: AQHYc/PzY4oVI2VbF0Wfhs8cVbyTJq03ACgw
Date: Mon, 30 May 2022 07:09:14 +0000
Message-ID: <DM5PR12MB2469BFAD39874BFB1A974C0BF1DD9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220530070657.678863-1-evan.quan@amd.com>
In-Reply-To: <20220530070657.678863-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d503c19-cd46-4238-fb60-08da420b4df3
x-ms-traffictypediagnostic: MWHPR12MB1661:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1661EACAFB875D06BAFD2D1CF1DD9@MWHPR12MB1661.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzA5CtKfTXy+pLiDZ2MmI7sUAG+EWLUuo1q5oXE7Deikgw4jfRb8KSQMK01p0Fqirh7FXf36h1bSB/fMdkDSboOM9hlz8ti/VyUb/CHQOlaBC3FnJDTwdAQOERhIkIrgGSxIe+PKW+U1ebYS2xxIrWfufsc/PaQXe1yUEVFVWkjCQEguHlUwjmEsthXp4QNQYNxFZxUUlM/7BIzGLPWsxwnmHbsTAymywOxPCCOsAomgHQ/OYii901NEm4aF+05tT0SSP19wEUFayd2MXN+vU78kt+cLK5UtnihUb2lW4O83UuJkaV9/9gxR7tDJZAgvExRkXjaovXepOy7KUTNsjbwWPc6YD6IODxOkue603kr7meZythH6Wueubn7pt90ItVcBFQMgmXhXFxlXHRnAwcOzhUTaQT4f3Zdjek8Bx3v7eAZ3ymf/euLnJl/VLJ8KXK1CQsxCKBKTgiyllTimTl4fE8My6TQrGyt3sTVmCPQ8dKqgGRxrvCyJ6Kb+3t/VrEX7rn0dyDFljt/vXIXZ3bhrZ9vOGsgmFpu3DEkySx7UF5cLhcCf+QR/WsS4lOD5XFDjma5Fu7/sVk1x9UwSRmeWBbshmJ35BZeVM6Vji6njau9UEQ9qm3ie0tTdJg1QRuozpAMpNTi8OKxnd3AI4vCF9Xn175AlcVtv0zhw4z5P8CR3V+6nn4hUIPYxBzP6ZHgOHvlGyZzeTIto+tQokQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(316002)(26005)(53546011)(6506007)(110136005)(33656002)(8676002)(54906003)(2906002)(55016003)(508600001)(38070700005)(71200400001)(86362001)(122000001)(186003)(38100700002)(52536014)(8936002)(83380400001)(76116006)(64756008)(66446008)(4326008)(66946007)(66476007)(7696005)(66556008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1sJ1+9N+eZyZMyAhEEnwC1MQdM9EoZrGhGa8BPdrooFpdBkMm1bsJMXDUDMO?=
 =?us-ascii?Q?Vxl/+3EGd9AxpRmbZMK2o+8cSOlQfSTcAoDXFwmRNxu5LyWGi5otnG9vPZSC?=
 =?us-ascii?Q?Muk38xjtRX79bQkoJqWQKPQ8HhIfdfD3ePm0u1TsRfIRv6voEIWj+zn0vXn0?=
 =?us-ascii?Q?OkU4cZMg1wV3QLd5bGeQuW/TJkzbtB8gEhEd8t1FDfg92g5sgqp00KqkRexM?=
 =?us-ascii?Q?0mxTgvXaOED9ofnjUpcwmuOFEkQfqP6TSjbzWWKr5xWSfMhPZJXCzjF9Ejrd?=
 =?us-ascii?Q?i3DpaNaPuXYF0ONivzVGBIY+kjK0XmmUS5DsTU2F/MTL3i1YeuYFFeAOA3TN?=
 =?us-ascii?Q?DYEYNcuwXcisbd7IYco8ClSyiZxEzjwPr5K0O3B2T5+qLzPlboWnp4Wl5WBY?=
 =?us-ascii?Q?BsXBpp+X1qDxmNmS9Cd8OeBkJM/PwiPFTPlzpUXozJM78jwJqg6OFDHzoiF/?=
 =?us-ascii?Q?oMr/5b3ZLvd27+v3Q8E7n/IOr9mFgnPkFHn4mXhtAFDUKHi5Dt47qTcLqwJZ?=
 =?us-ascii?Q?2YXFZL7lS5I134EilE3PzYu47wIWKP/jYiKPGPcTpFksHC578MRy/aeMvgKM?=
 =?us-ascii?Q?0ttaqUV3V1SwqD3wXH04YHmCtGFseXCNZ22MfIp1lkXOIR6akEm+Nf7UdZsw?=
 =?us-ascii?Q?+kaXvN64k/Q3b4LqIQHaNujz8oFJiRcYafaQnotro0Z6IXJ/D5BlOyq8fFP5?=
 =?us-ascii?Q?w9klq7WB1O4Zp70Vor6PjK9a9EZLkVODH88J7slxYx69AvNaJ4g25waE6zdf?=
 =?us-ascii?Q?xmEk2J/Vpv22erSWOtYjzOlN+f9r0jeRnvR/U5z+b8+C/ve0r/G6tOcbMZn9?=
 =?us-ascii?Q?JLoP89hpJmRoqWYxH1Zj6VM33+YGFRJD8yjdIw6YMW9JcjAWMwWzeZ/xXWCz?=
 =?us-ascii?Q?BqO8FMpSEIumDmtiUlX7IEzCPkojkIjV1AgnDqSgs8Km6o5MJ8dDqyPryM3J?=
 =?us-ascii?Q?9QeUzsDKXXu5cfvRS5T67zTYt0U3IVm5GvzcdSyV7KFovV7fetFbdpb5KwlT?=
 =?us-ascii?Q?XaMhbJdS66dUdSqs33hHfl7bHmCfx03755UV8IXsGsC3yCsl4qBHl7Np0IHb?=
 =?us-ascii?Q?sG/KAl7sWRecuw9g4qQqxIEHOgPeFOfxsl5LI73xNYQjnfLOzuaSRTp/OYLF?=
 =?us-ascii?Q?KvKvd8s4E1MJzA/m7zwIARz8xpuzEWftpUxTIlBZUIK7gYVtYBd2TJ6qoHhV?=
 =?us-ascii?Q?U6j6aAYrQtafhO1XlMCra/5p+hwiht1QdqS4QHxlSRDm9ZYuM8cKVgl6f30V?=
 =?us-ascii?Q?C2MYazS/30Dv3639turM4TBoVfaRjZbB34mEBkuqhtqQopgqEtkemY4UeuL/?=
 =?us-ascii?Q?n+1Q1yHEfNFxAjeAf4sf+pDkXUQzlE9NaTK/rt6by9QTuurWnqdx3VgAed0S?=
 =?us-ascii?Q?gGpNTT6CHF9ydsT04D+kHziw8LgLGzasL6El1q5HFEABHRs+74wqqZYYBzn1?=
 =?us-ascii?Q?+pOJg/pMRPyU/WmsuNTZm2WgCaSLY4JA9mdwOnEnhPiKO2OTElbqKiCbqhoE?=
 =?us-ascii?Q?aBaEOyqYri6e8i09a8R5wBO872EaLmbf9vn3x9kQ5tti2sDkyttIGRlvHjmg?=
 =?us-ascii?Q?SITWps34kyhlUv46kGYkGBUE80yvui/ksDVajIShDes8P6E1LN/yNsRPZAbm?=
 =?us-ascii?Q?HqsOnApcm+F7ZhHwhoHjR7DDqTKGsxf1LXqhhzL33TQZOcDTNLAEdBMou+4d?=
 =?us-ascii?Q?OdhuZo0nOZpmaw+iKSgSpU9sbSY4es45khEl5giqdDbZ+nN8M4ic4qKN2mQe?=
 =?us-ascii?Q?VtZ/+RWgHA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d503c19-cd46-4238-fb60-08da420b4df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 07:09:14.5630 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj33svIbtyGkxpyRdG0vxk5g7vuGtsxcu5+LIGXj6HFkNAl8GQYXm8mEBxCAwBcOSfyA51+ABCVIHWGJV51+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Qua=
n
Sent: Monday, May 30, 2022 3:07 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; kernel test robot <lkp@intel.com>; Dan Carpenter <dan.carpenter@or=
acle.com>
Subject: [PATCH] drm/amdgpu: suppress the compile warning about 64 bit type

Suppress the compile warning below:
drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:1292
gfx_v11_0_rlc_backdoor_autoload_copy_ucode() warn: should '1 << id' be a 64=
 bit type?

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: If5f83daeb4039d87c5b47c221f9c963c941400e1
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index cb581cfc7464..9039021361a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1316,7 +1316,7 @@ static void gfx_v11_0_rlc_backdoor_autoload_copy_ucod=
e(struct amdgpu_device *ade
 		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
=20
 	if ((id !=3D SOC21_FIRMWARE_ID_RS64_PFP) && (id !=3D SOC21_FIRMWARE_ID_RS=
64_ME))
-		*(uint64_t *)fw_autoload_mask |=3D 1 << id;
+		*(uint64_t *)fw_autoload_mask |=3D 1ULL << id;
 }
=20
 static void gfx_v11_0_rlc_backdoor_autoload_copy_toc_ucode(struct amdgpu_d=
evice *adev,
--=20
2.29.0

