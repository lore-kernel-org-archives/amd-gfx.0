Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4DBD5A6E2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2024 05:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 636B610E11A;
	Tue, 26 Nov 2024 05:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yI8PK3W";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F2B10E11A
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2024 05:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiX9MipDFJM48qCIDQk4HW4pchlOX7G9jmF+yYB6Zlvhz03tpsrhJgISNs5fRC06vLO/APBqQ2ByfVE32VPfnpLh+P8h3g4/AfAAcfzkwFYvZX+fOQvZ2VZtZv7sMUX/8zeR7zxXnfZX56AjjUvdAQ2D31FKASctef1al9IaMilv0Hn2pPR1bTKBko2+vA4tU+Sa7tx6D5K5zVJgk1lG2q2RdEhmmrBYBQD1uzIIxveCuqxFcwIUHRezmNOvCiepx+P/je1D1xesnIJit8N08K1KRaEOBjEfwwhdpxI1yYCzYvm5d84SeWvTxqK17kGLmZHszzcXLmo5Bvln8MRAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL3hY1XZpqn5Vc7qRa2/HydGLyGiwY/HzJXKLLiVOOc=;
 b=ET8Tkv1GLviyJ2jMucFbd7Et7mstUcnwnDGrx4SrD1XqvBnzVtD1EzQemSaT0eesU4GneEm0X/BEBs3t9MAt3KFJb2hQwYYZxP0o0jjWFGArzqb5TPh+frtxCNs1q7k/sUK0B51kl5s9/3+0L6/FepTx/Fqt17UANoct5pt/8N5k5h2U4AVi9ayJd9T841oUxlRRbgxoxxNvnQJP+5eKvcbcOX9/y5Np9He1kT15g/weiw7lO845rN5rIdSCu2gHsQkBhTeFnLyvOZft9iKbU46LeYCQjoXHUouVtH7fTVC8wWV6+KKz9uJkj9eviGR+yGuH+kdMR//ipxP9M83kTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL3hY1XZpqn5Vc7qRa2/HydGLyGiwY/HzJXKLLiVOOc=;
 b=2yI8PK3W13/6FIEGPvGFDhyibzvK6cm1/bfQBVovYKqyiB9g6g1VE1BQi+3is6SfJtaeZ42F8d06t8195RusaYtwI0rhB9TCySNdt/KdL78Lm78egoobaEpLjC6Vqt7I8Vt6ycCguAoUTQXlsF36kU1q9D3lZuRLZq/RlO4LCn8=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 05:53:16 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 05:53:16 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Belanger, David"
 <David.Belanger@amd.com>
Subject: RE: [PATCH 5/5] drm/amdgpu/hdp7.0: do a posting read when flushing HDP
Thread-Topic: [PATCH 5/5] drm/amdgpu/hdp7.0: do a posting read when flushing
 HDP
Thread-Index: AQHbPPt0t4P4PgYypkunW0bHTc2/RbLJFJEA
Date: Tue, 26 Nov 2024 05:53:16 +0000
Message-ID: <SN7PR12MB6932BE08A7D0FAE860E4D8C1E92F2@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20241122162657.1056489-1-alexander.deucher@amd.com>
 <20241122162657.1056489-5-alexander.deucher@amd.com>
In-Reply-To: <20241122162657.1056489-5-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e5c6d5a5-fd4e-4a46-b8ba-c0f55b8f360d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-26T05:51:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|CH2PR12MB4167:EE_
x-ms-office365-filtering-correlation-id: da6c916f-ad66-41ae-65fb-08dd0dde9f2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Gzy9mN/QO5j6msDlPHMguZxQof051KCRayVwCK95dVgeo7MkoW7R7pEtxTwG?=
 =?us-ascii?Q?f6FtXoCRZzw8XidfauOryx7G0+TEHPxtVT8qwgNO/mtlzUPdzTtIsRGbCjr1?=
 =?us-ascii?Q?6voTIsZnPE1iVMTwZU3MfYVHySvIagfFYDlB36pcJVbc0ILmjL7h3IBbhlBL?=
 =?us-ascii?Q?HQHKsOTpBmy5IlN+cqbxFyGJLb8+/q1Mnr1Iv+o5zFitGyGsq4unCycZhb66?=
 =?us-ascii?Q?9wctCZKV6zbnuPOfsoldKqUVhytd8X/hepxq0Yc9SWJAufpoO+d16Lyzy3OF?=
 =?us-ascii?Q?QRgGSEtqYGfvbJVHpiPENljL08y/pxIkeX8NlVEaEXxjoNcWu0c0W5HA9xYr?=
 =?us-ascii?Q?almr4F9T4ZRpmJbGyLvHC4dUXjm5/MIov8m23RgTCHOYb8KpcitMjwAS6Wd3?=
 =?us-ascii?Q?HHTtBqf4hIubUzOCTlgMXxBc1mZHuwsaZuI8/IxO860hObKc3Wx5MhAWXkan?=
 =?us-ascii?Q?8k4qVQ7OHjekx5vdEmcQzijuuYd7NkooolLPdN5/UThO8G3q9faCZeOyfDjL?=
 =?us-ascii?Q?JWaTIhfMpFBPJWklzhe2SMiBH1nh4WbnrfPXF5EaUPwkgFtsczydHrJTuMsG?=
 =?us-ascii?Q?OH30A5kBxVYMeId6mg3ey6e7d2Od/HVSvTSPnyPBe/+hditOQ3yVK9w7b1el?=
 =?us-ascii?Q?Y54dAtcA0UFsR39cSdLZObP48J2Y+nNSLIowJh0zh2JbaNuJTUeuLRUzZWBm?=
 =?us-ascii?Q?T2p/jXjQbXDWKo3/bQ5Uz+96s1sYwi82Bre6ZshuBOU+ZJds0ZmrUMyy5chp?=
 =?us-ascii?Q?QMxaWexvFFl48hMp6brHlifGrWG1hmz+ApC3PiHwe4u/T1IgD3n51ZpWneVN?=
 =?us-ascii?Q?nUNzYquHgoJD/qryO0AUOkwDpFTzKkOFmY1b6sAoHSTBU+8zGty4pwLylKzH?=
 =?us-ascii?Q?fnM7dZPnLhttYpcRCpXdQR9qxB7U6/xSpEanVQ4c9MsFoZPzdSA6TYwbP6bs?=
 =?us-ascii?Q?qQxJTMi3/HX3bN4CPpgWGjsIhDhVwcJe1CX9w8b6UhFUsWskD1TqYdt3m1PX?=
 =?us-ascii?Q?OgMHcXwb51sm3Jvom5csUmwWZPDD35DeOHEo8UZsb9dRe31OWYihBkwhDesP?=
 =?us-ascii?Q?+CnLaYgyoI/yem9LtIHSlzlQ4SrwkYwv4I+O9wI0UqzLLhCGFu9LMFX8PaNw?=
 =?us-ascii?Q?Nrb+vBRY66GjHJ2Vl8jR74khXSyTaUKMasekerNQ7oornYRzqWuZSHZOV0Yj?=
 =?us-ascii?Q?r1MkxGk0/8n/Y42A5q+ptPUQ8hGzGTR2u8Rc93EjoMULO/5COh01yeFRQCTA?=
 =?us-ascii?Q?Vew/x9bDa+2iBbQpdkp2z3YnY1aopsc/PlhQ5BCuoNYRgRMImX4Xq9aYW4Ht?=
 =?us-ascii?Q?+0BZbEccpvvQLrydGvQ9DNVcVAz2ErX6PRvToSep1MbeoLW/hfCN5kBhNSqS?=
 =?us-ascii?Q?r9p/E9N+whoZHqqndzUyv6CAKnL8GlEUBAooJ3QqS5OkQ/wQrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dhPIVVCWSOM5KrPSDXMG3bwqPAYdYlf4sLJOrwSKsp+sKMd0XZ66tl6ldKl/?=
 =?us-ascii?Q?igXI/cxlFktEj7jv/pZnZyZGGDi46aiGhlppYI0Q/vuz1LJ+YVcJZIneA1VV?=
 =?us-ascii?Q?dJTA0ucF2bakRmzhjS+C5KfHU5HVZruifD7wC+3BmpIgtVf5BDvnMMPtLxZL?=
 =?us-ascii?Q?rUi1IvaqU1ldw/z8/KqVJnNa+Vrddk5udSG2Yj70XVyH5NFywuPmtuSOxbyn?=
 =?us-ascii?Q?l04YNZMAs76pSwIEaq38ddnLL5p1hhQBQG2VCb3kv/b7L0ok+Po/NAsxrwMk?=
 =?us-ascii?Q?LX8lVfmdbY3iwlopCUZl34wcPkFs0Qg6DoIi6qAKlUpbwIwPcFQ8UiPtcuwk?=
 =?us-ascii?Q?rMkuA0VzTL5YTDQXHI5xwDI6cYErR+TQ5haiYR0FUTq9Y7QSPel56ywO5kWO?=
 =?us-ascii?Q?bikEq69IsZyzAU9ykM2hUvKxs8hKI/iHLNznWkqNYwaPkNv9CJVznNtH67we?=
 =?us-ascii?Q?K+5KMmafHkT4RLxKwfWBIvp1WN/3AJjbfHGwBWJR9FChWCPny18AsnqDUh23?=
 =?us-ascii?Q?Uf+C37m5EcQbvz7UrTSM9fhs2FDvtajZLfpN0ppcVMi8Sao06yPUuxDj1AlU?=
 =?us-ascii?Q?HUhLZHloy2YOPatZudg98EiKmIahEwE6hLZjW8KbfQcM+/E84E1R2T49BYL/?=
 =?us-ascii?Q?UNffYEggq/Jf1995zM7RzHxWXxu8mM0MC+UI37ENZvOb3Xw6nFg9xy16Re2+?=
 =?us-ascii?Q?4k6O+8p09PakyuS/6OZ11ZJtS18o/xs3wEwvf5ptR8biXGkpX/yRSg5OSIa1?=
 =?us-ascii?Q?1zypcAGcbhHNBj/q4IcFQrkwKusD9jO4GpOCpqxeXzUTqP0dGSBOfUbiImh5?=
 =?us-ascii?Q?Tagva57ViKFmInGFe222oHvGzocwLjjRFvjlOT6LRznDDaSnXdweSwTo/k/8?=
 =?us-ascii?Q?F7KPQ289uKOVvSIOF+4V7vP+zVACIH09crBWMi94I57Q0y46C6xSXKyJJcVy?=
 =?us-ascii?Q?GKklpxz1qNQrphwA5PvqjSkdHNIhwyW+8MdEdKYIxK0Ek37xZHPr2V1RdSp7?=
 =?us-ascii?Q?11bGuDaCZ076prMUzJZ4mWwudrjl+aY/i3fMkImFlgEqDNKIr17djhlySVm+?=
 =?us-ascii?Q?z/bxmx7K3L+2tQdlZh518pelHug1xhlCLA2MU9fqDgcVMgUlQBeKP0GnR4zC?=
 =?us-ascii?Q?iNjEBmJP8F2X8Cvz6yLJ1hOUo2gYrO967zVlEQnvhbzkf86ntr2IUTqmEjOM?=
 =?us-ascii?Q?rWWeSzaZAjij7yazp7rjPpltXeO6E+seUF4tO30vyC1LZR48sxFktDSxcsfd?=
 =?us-ascii?Q?tLf5eNrEANvevfkwdMd/SG/ZvRBLkdCzT5nTMLWcL38FBOwty5dbFD5tzW58?=
 =?us-ascii?Q?1yArmvRpySdNSi9lYZds0YwohLp/QSe8IgAxF0KZ0Kj9wdC+mQR0aS9kusZN?=
 =?us-ascii?Q?1JTu844bALbQG8CBMP7GRIflCCWWC6izqgpSLXAk7paenjDeOA6PSPS8dD8X?=
 =?us-ascii?Q?Vih0Uqo1bSXWqbxj3+Zhnrzf3MHl+dV+Wdmee21SNFdP9Z92U8oSZeFGE58B?=
 =?us-ascii?Q?Gyv1B6hpbwjMO63r1LwKesO20sWjVr2qWHMVSbV++FBNX4o0CPvGqeBxj63L?=
 =?us-ascii?Q?h7nluFNeJLJxjLDftCw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da6c916f-ad66-41ae-65fb-08dd0dde9f2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 05:53:16.0911 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PTh+TiBr0nklOlHRf6GsKyKzvGj2Z8pRmIC47fGd90Grj1ihRlN8MJ45GRmvgyL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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

Hi Alex,
These serial patches look good to me.

Reviewed-By: Frank.Min@amd.com

Best Regards,
Frank

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, November 23, 2024 12:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Belanger, David <David.=
Belanger@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/hdp7.0: do a posting read when flushing HDP

Need to read back to make sure the write goes through.

Cc: David Belanger <david.belanger@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/hdp_v7_0.c
index 1c99bb09e2a1..63820329f67e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -31,10 +31,12 @@
 static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
                                struct amdgpu_ring *ring)
 {
-       if (!ring || !ring->funcs->emit_wreg)
+       if (!ring || !ring->funcs->emit_wreg) {
                WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_M=
EM_FLUSH_CNTL) >> 2, 0);
-       else
+               RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_M=
EM_FLUSH_CNTL) >> 2);
+       } else {
                amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset +=
 KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+       }
 }

 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
--
2.47.0

