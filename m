Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B499C3271E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jul 2024 16:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCFF10EC1C;
	Fri,  5 Jul 2024 16:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUtGj9Gq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B90B10EC1C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jul 2024 16:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh+1UEnB2SLc+mCuxHbcY43gBBK9lGvFvjbEdbcVOF6XcnjJ82Ns7lfxDPNhmsghz8roVDixhzw1IdrvJ7qOXBSE5vvEe5XyJ6EkghHnFqfKmheqhcbSJHCbZlf2IMZsDMiJlzVwqW0/C0zy1JoNPITfEzyHvhswwsTbgtNSEwNWXkIGMPM33wQnIH8d4ubFivfXPwxPbocqjE2qYidXxzsGsFfBC+YHSMiXrGVie+7NkmMFrbET7Y1vJ+L4v21Kpv/oLg3fTlMOkCQTetJ10AER94K3yl0ydoMyvvGrE8TPkv8+oQuLmeLXJrE/PBqGRuO6uOiyA4E0ZsTUU3/qQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcEifJPwKyYqsbSNZQE7SRPQI0yf/sMPGz/NsDxPfN8=;
 b=bmTBp6DbP/Xfdep0nKHsZUGwzARQDbIJvLpfLXK8kCcaS0ar3JcjQyOcNJshozIYVhA+YJvDpt7jtoHokmcqrWGVj4rkX+LkOLgExktZabrw7KlUaS1Sntj9ahhgDUHYVcZC0HXar6ShCIMuYwTmq+lniULXl91QNcGjQsjg/4/b2DnlkyWC3yKc31blqu+nFjbrYAVWVGV4NZq015bvx8kwqJA7eT4Jvj5hPZa7W11sNf0PuQPD5IV5+bSyzpX/Utqdmb0OfVDkyY3fXBaVAvBcQ/L84M0bsJcKg5ESbWta6r+t/eohbtiyK5TK0tMFZ2TaTFyo0yqftw1m+H+L9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcEifJPwKyYqsbSNZQE7SRPQI0yf/sMPGz/NsDxPfN8=;
 b=XUtGj9GqfN976A08UBSLupL7V6TzlDwAXLeeRvP0DrNun9uwc1TJWpi2SdxrdJOeX72AyEvHfrmrit8D/VG0xS9K3TyHLVEawvXpX3k2DbkboU51mxocwacTULodcy7n8hhhsmN2jQwp/13ARSS5JXPC3FayvHcAnCgQIKa1VIY=
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 16:20:48 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::eb6c:c1fc:66f2:1ca%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 16:20:48 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
Thread-Topic: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling
 at svm_range_set_attr ioctl
Thread-Index: AQHax9oa/0ihKJfEKEutmxXkmprZt7HoXTbA
Date: Fri, 5 Jul 2024 16:20:48 +0000
Message-ID: <DM6PR12MB2602ECA96925121844971F13E3DF2@DM6PR12MB2602.namprd12.prod.outlook.com>
References: <20240626150633.157464-1-xiaogang.chen@amd.com>
In-Reply-To: <20240626150633.157464-1-xiaogang.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ec9f2ecb-2285-4599-991c-c836622570f1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-05T16:14:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2602:EE_|MW4PR12MB7384:EE_
x-ms-office365-filtering-correlation-id: 2577ed40-4a4e-4528-d4b0-08dc9d0e6e0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EesRkBFz6iCcH+0Sm+eBcE0dL+DkIZyUEdp3lpP9NF9m3j9XDKs0aG4ted7X?=
 =?us-ascii?Q?XSfpa3l/24gNTXrZFSJillVLxvDPXFe5f4BjIiyJeFTsNDOzJ0NutOOaed7L?=
 =?us-ascii?Q?3Velxxwo6IL3lsr+hqjIq2eYPLFMi7DP5/R3NU7eManTmlptsUYl60G9biGK?=
 =?us-ascii?Q?MFFnQU1sc8muf72xTPtWGC2rLJmqQQ208kMMV2ap0EAgHi5IVYUiwXgsLVRH?=
 =?us-ascii?Q?twA4t1fp7B39kADEUm9kieG83/gG+xk3PLzQYjWV4vu+q70eOq5359RD79Ym?=
 =?us-ascii?Q?XibYJ1n5/l5HY9R5e2MzbWDOUP7osrBbqFoLILAh/81r++B1ucyeKFhwr6+L?=
 =?us-ascii?Q?CsxUo8xhJIArg9C0sM43oQalDemxUE3FDHwRnFzYME3zHaS/lMalMSEqrvih?=
 =?us-ascii?Q?DIQnj5Orn2EZXRr1yV4QJdOLNjGN7ppvJTIG3IPHepxpTYRH17Bsgh4WIVYD?=
 =?us-ascii?Q?zJSL3zqFPHwNNGQ4QXP7d2QP3tIuaxX9RyVagakffIsjbSYXVDCC6UbCayNV?=
 =?us-ascii?Q?Qxlc6WLrztQqdZuxbUlb7Zmq8GW99HqWdjkEhXqgWD563MblUNu4vAgeDgMY?=
 =?us-ascii?Q?/oliyKAn2DVCMLW1VOBkITX4k9T44uSUE9fkiXjLysMbBRl3JJBmu3nbwtxF?=
 =?us-ascii?Q?C9gfnNx45rVxfPGUW0cfUKQlriL/7uAIOHsoqWtB7dVyz2RW/vrOAZnCrKPx?=
 =?us-ascii?Q?r5QEVtLuvoRPZRuc8ROyvbw1YJome5XPptREOc+luJmY1E92Vhc9vzxjFLKK?=
 =?us-ascii?Q?mJZsXk0h6VCO9R/q++xdZodDHnRgv8MgGH2IiRM4CIfAUB9vgbASdLXAmdH2?=
 =?us-ascii?Q?VuVhB7Lm0xok+6Iaqo8W3iPCIb8AKh7pRTKXht6y2HR718yUS1+ZSDGnyLol?=
 =?us-ascii?Q?RUTdKpeheRuLYaLI02YcybsqtPz6FJEiTmv6K4O1MIgwmNQ5KSlg5iBAanwz?=
 =?us-ascii?Q?HmofRheoxeR5w9QWQ0IaXj2OZwe9/6pBRUpZ3uDWbBbgV5HF0eTn+3arVpZI?=
 =?us-ascii?Q?54o8DmA/eCqS1g6UrCAqn2WUmgs0rrq85dejMRHGC9IFumz8SEdvK3CZdxt7?=
 =?us-ascii?Q?IFGXXkZ5QakAyChZyINJOUS/gQLVcgk0s0NK5pkrDAIUw0hHrKfBojWpL4Cb?=
 =?us-ascii?Q?4mQW5KYXyFP2+kmIoidfcUX2z3CLrk0s+Awe0CIY3rPPa5BaaCd7clZhALMB?=
 =?us-ascii?Q?NCdvH10rdhT1jNHvg08O7+pUYMf98Mtp4OSrdjK0Id0OTrYkzJ/F11tyzNYY?=
 =?us-ascii?Q?oY41fg/YPpLbT4bhcFLvKBxE2TRlORIhOEtUHjOHRQOa/e5sTd2dF8ApWFSw?=
 =?us-ascii?Q?ipYSFheWfezLgSG8v/053Z60XcUVdEOaZAbqeErcdxRKQpfhimcBJ/A6S8yA?=
 =?us-ascii?Q?0PiIq86AYo06ni1MPhfAP8o6iF54AQAtV9Uk0xzH6pSyaVCgHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8W2OSgADOew84gNzk0fuwS642y3h3Rlb6de400T+5GxqRH74TMqBWCR2+T1J?=
 =?us-ascii?Q?NG46LQBEnOq7MDokErPI3njg50VEr2AgfaCVMe7pKBe9/7V/jPEYM1V/wSG4?=
 =?us-ascii?Q?NM4hdgDLPhQ3TTh7H8M+GYxH1cJ47DgfoxEb+atOhtUNnC44ijhlgCe1eGUX?=
 =?us-ascii?Q?BCX2bOxdh1+o341VWZTcPS6jMSxFCA+BhCdPoZYq5DVaQy14rzNB4kU5oF7f?=
 =?us-ascii?Q?D0RXkoYzbRUsTUDKya03skaH6SnA6nLtRs27CaOH5Ty4947+GZ40okVda2mc?=
 =?us-ascii?Q?C0GG/XETDLLUFqd4o6eeEAxHBgngiUf6WuHc1kFyDhXM3lUBQRk8WumQNzl/?=
 =?us-ascii?Q?zMrxUEyQywa/9+UbKESodtN7zy5PyX1QcB9A+QZXPoDZ5rVypOXxqtHLgXGB?=
 =?us-ascii?Q?tItVtFSH74d80VDmAZKjTXHHWQKalOWk3vEBZ4UzLzmqDR4wTUXngi4Ilh86?=
 =?us-ascii?Q?xNJ8SAiDhUPq3B8mmFJcUh7qNdZ9VaS4cCb7wNYa1dGb/Dc9+HGTqN64n6a5?=
 =?us-ascii?Q?fIZsl2dNlaw0nNcbsv9fe1IaAaBYA6GjGWtrlEve/2YMTBkSdFordspjBT7t?=
 =?us-ascii?Q?jOZCH159uRvlfxn6ZYk5LvCDFC19kzGWjpn9wQbTZjhjr0+/bLEKN7o3Zw/x?=
 =?us-ascii?Q?0Z23io0Yi4dwZXsQBVTqMIG/86367eM4lq38cPgzZFbd1Uf2MGTUsyAGGUcQ?=
 =?us-ascii?Q?V7nTqmYePU7LRSi72y+8JQPSvjkjiW5aBoPcEuQQNkJNhvYR+tYPA3pYdJAW?=
 =?us-ascii?Q?0xI1b6190kcYS7w5u4vLpD1v5QY05zrCl4Ag/NyJ9Oo1+IxS0Ec7l/E14eUE?=
 =?us-ascii?Q?JG6qhnZ3a3Z9uoAX0ZA8AWHXiNua9dQ/sLiWO7mOWdFfcWQr7mJvxAc6+c+n?=
 =?us-ascii?Q?X0EEW93xEFbr+FTrHAjgpFspn/L2MhoRYTFrc2BaZyGYh413KISt0HCd/Fsz?=
 =?us-ascii?Q?6GbRxRXS9zW2sInX4Eoh7/sOkg2Z7KNmYbR2UyaZvFgGqht003+T2HA22EyV?=
 =?us-ascii?Q?djQOFnRglYLDVLqid8YLeNy8FhIbr2QhX6bz+R05z8kOAZwnTukje24jWy1d?=
 =?us-ascii?Q?I/mOfQw5kePNMBvfRr6uPF5ydfQWAregsy5qDVYocFJ3wLTfw1YNK5Pn53CX?=
 =?us-ascii?Q?DBEJ3iaKKAedPlYNtxPAsCnZQv6hYr8Ud/XYOXYhJt10FC/J8Ffyq/idvmzq?=
 =?us-ascii?Q?/dAq6m+nOs3YQiLmwTnUdupMvWKTSfHnU0hHslhB4PbW0l9Ubst9fICISRG3?=
 =?us-ascii?Q?s/pi8czz0uuDveXRcLmKZVNWrsIELVIae48eqkM3LsFklP2MSIDpnqCaxaFs?=
 =?us-ascii?Q?Hwe65HqsIk8yU/h7uf4jpJ/kuLvskt/6+OIoeZBhQrrjDN4O9l7GlVXzD3R5?=
 =?us-ascii?Q?9Y6waRQsiH02W5mUQyU7mDxymBJw2xBNzgW45V3mtKJHUH3heO5hvUdM3zx8?=
 =?us-ascii?Q?awuGOrubksWlVc+6hnGzc9U7VtTJ+kxQjbPWXJywFNLyhBadeE6+WV6izLZc?=
 =?us-ascii?Q?NJmHECE2nSaIJx7kAK4qNnt2FNOFKCKjwbIqbiSgR+ybNzm+m4FTG1vadPiX?=
 =?us-ascii?Q?PfWQvqQfw/+czgsOa0s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2577ed40-4a4e-4528-d4b0-08dc9d0e6e0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 16:20:48.0948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZ/ulD3zV3gX/aTb2oLco9yeWzGvFIYUjiEz/3NVvy0nlkX4242cwJn60YMQyApo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
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

ping

-----Original Message-----
From: Xiaogang.Chen <xiaogang.chen@amd.com>
Sent: Wednesday, June 26, 2024 10:07 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd=
.com>; Chen, Xiaogang <Xiaogang.Chen@amd.com>; Chen, Xiaogang <Xiaogang.Che=
n@amd.com>
Subject: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at =
svm_range_set_attr ioctl

From: Xiaogang Chen <xiaogang.chen@amd.com>

When user adds new vm range that has overlapping with existing svm pranges =
current kfd creats a cloned pragne and split it, then replaces original pra=
nge by it. That destroy original prange locks and the cloned prange locks d=
o not inherit original prange lock contexts. This may cause issue if code s=
till need use these locks. In general we should keep using original prange,=
 update its internal data that got changed during split, then free the clon=
ed prange.

This patch change vm range overlaping handling that does not remove existin=
g pranges, instead updates it for split and keeps its locks alive.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 112 ++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 407636a68814..a66b8c96ee14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1967,7 +1967,8 @@ svm_range_evict(struct svm_range *prange, struct mm_s=
truct *mm,
        return r;
 }

-static struct svm_range *svm_range_clone(struct svm_range *old)
+/* create a prange that has same range/size/addr etc info as old */
+static struct svm_range *svm_range_duplicate(struct svm_range *old)
 {
        struct svm_range *new;

@@ -1999,6 +2000,25 @@ static struct svm_range *svm_range_clone(struct svm_=
range *old)
        return new;
 }

+/* copy range/size/addr info from src to dst prange */ static void
+svm_range_copy(struct svm_range *dst, struct svm_range *src) {
+       dst->npages =3D src->npages;
+       dst->start =3D src->start;
+       dst->last =3D src->last;
+
+       dst->vram_pages =3D src->vram_pages;
+       dst->offset =3D src->offset;
+
+       for (int i =3D 0; i < MAX_GPU_INSTANCE; i++) {
+               if (!src->dma_addr[i])
+                       continue;
+
+                memcpy(dst->dma_addr[i], src->dma_addr[i],
+                               src->npages * sizeof(*src->dma_addr[i]));
+       }
+}
+
 void svm_range_set_max_pages(struct amdgpu_device *adev)  {
        uint64_t max_pages;
@@ -2057,20 +2077,19 @@ svm_range_split_new(struct svm_range_list *svms, ui=
nt64_t start, uint64_t last,
  * @attrs: array of attributes
  * @update_list: output, the ranges need validate and update GPU mapping
  * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
  * @remap_list: output, remap unaligned svm ranges
  *
  * Check if the virtual address range has overlap with any existing ranges=
,
  * split partly overlapping ranges and add new ranges in the gaps. All cha=
nges
  * should be applied to the range_list and interval tree transactionally. =
If
  * any range split or allocation fails, the entire update fails. Therefore=
 any
- * existing overlapping svm_ranges are cloned and the original svm_ranges =
left
+ * existing overlapping svm_ranges are duplicated and the original
+ svm_ranges left
  * unchanged.
  *
- * If the transaction succeeds, the caller can update and insert clones an=
d
- * new ranges, then free the originals.
+ * If the transaction succeeds, the caller can update and insert split
+ ranges and
+ * new ranges.
  *
- * Otherwise the caller can free the clones and new ranges, while the old
+ * Otherwise the caller can free the duplicated and new ranges, while
+ the old
  * svm_ranges remain unchanged.
  *
  * Context: Process context, caller must hold svms->lock @@ -2082,7 +2101,=
7 @@ static int  svm_range_add(struct kfd_process *p, uint64_t start, uint6=
4_t size,
              uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
              struct list_head *update_list, struct list_head *insert_list,
-             struct list_head *remove_list, struct list_head *remap_list)
+             struct list_head *remap_list)
 {
        unsigned long last =3D start + size - 1UL;
        struct svm_range_list *svms =3D &p->svms; @@ -2090,13 +2109,14 @@ s=
vm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
        struct svm_range *prange;
        struct svm_range *tmp;
        struct list_head new_list;
+       struct list_head modify_list;
        int r =3D 0;

        pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);

        INIT_LIST_HEAD(update_list);
        INIT_LIST_HEAD(insert_list);
-       INIT_LIST_HEAD(remove_list);
+       INIT_LIST_HEAD(&modify_list);
        INIT_LIST_HEAD(&new_list);
        INIT_LIST_HEAD(remap_list);

@@ -2117,35 +2137,41 @@ svm_range_add(struct kfd_process *p, uint64_t start=
, uint64_t size,
                        /* nothing to do */
                } else if (node->start < start || node->last > last) {
                        /* node intersects the update range and its attribu=
tes
-                        * will change. Clone and split it, apply updates o=
nly
+                        * will change. duplicate and split it, apply updat=
es only
                         * to the overlapping part
                         */
-                       struct svm_range *old =3D prange;
+                       /* prange_dup is a temperal prange that holds size =
and addr info
+                        * updates of pragne after split
+                        */
+                       struct svm_range *prange_dup;

-                       prange =3D svm_range_clone(old);
-                       if (!prange) {
+                       prange_dup =3D svm_range_duplicate(prange);
+                       if (!prange_dup) {
                                r =3D -ENOMEM;
                                goto out;
                        }

-                       list_add(&old->update_list, remove_list);
-                       list_add(&prange->list, insert_list);
-                       list_add(&prange->update_list, update_list);
-
+                       /* split prange_dup */
                        if (node->start < start) {
                                pr_debug("change old range start\n");
-                               r =3D svm_range_split_head(prange, start,
+                               r =3D svm_range_split_head(prange_dup, star=
t,
                                                         insert_list, remap=
_list);
                                if (r)
                                        goto out;
                        }
                        if (node->last > last) {
                                pr_debug("change old range last\n");
-                               r =3D svm_range_split_tail(prange, last,
+                               r =3D svm_range_split_tail(prange_dup, last=
,
                                                         insert_list, remap=
_list);
                                if (r)
                                        goto out;
                        }
+
+                       /* split success, insert_list has new head/tail pra=
nges */
+                       /* move prange from svm list to modify list */
+                       list_move_tail(&prange->list, &modify_list);
+                       /* put prange_dup at pragne->update_list */
+                       list_add(&prange_dup->list, &prange->update_list);
                } else {
                        /* The node is contained within start..last,
                         * just update it
@@ -2178,8 +2204,38 @@ svm_range_add(struct kfd_process *p, uint64_t start,=
 uint64_t size,
                        svm_range_free(prange, false);
                list_for_each_entry_safe(prange, tmp, &new_list, list)
                        svm_range_free(prange, true);
+
+               list_for_each_entry_safe(prange, tmp, &modify_list, list) {
+                       struct svm_range *prange_dup;
+
+                       /* free pragne_dup that is associated with prange o=
n modify_list */
+                       prange_dup =3D list_first_entry(&prange->update_lis=
t, struct svm_range, list);
+                       if (prange_dup)
+                               svm_range_free(prange_dup, false);
+
+                       INIT_LIST_HEAD(&prange->update_list);
+                       /* put prange back to svm list */
+                       list_move_tail(&prange->list, &svms->list);
+               }
        } else {
                list_splice(&new_list, insert_list);
+
+               list_for_each_entry_safe(prange, tmp, &modify_list, list) {
+                       struct svm_range *prange_dup;
+
+                       prange_dup =3D list_first_entry(&prange->update_lis=
t, struct svm_range, list);
+                       if (prange_dup) {
+                               /* update prange from prange_dup */
+                               svm_range_copy(prange, prange_dup);
+                               /* release temporal pragne_dup */
+                               svm_range_free(prange_dup, false);
+                       }
+                       INIT_LIST_HEAD(&prange->update_list);
+
+                       /* move prange from modify_list to insert_list and =
update_list*/
+                       list_move_tail(&prange->list, insert_list);
+                       list_add(&prange->update_list, update_list);
+               }
        }

        return r;
@@ -3533,7 +3589,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_s=
truct *mm,
        struct amdkfd_process_info *process_info =3D p->kgd_process_info;
        struct list_head update_list;
        struct list_head insert_list;
-       struct list_head remove_list;
        struct list_head remap_list;
        struct svm_range_list *svms;
        struct svm_range *prange;
@@ -3566,7 +3621,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_s=
truct *mm,

        /* Add new range and split existing ranges as needed */
        r =3D svm_range_add(p, start, size, nattr, attrs, &update_list,
-                         &insert_list, &remove_list, &remap_list);
+                         &insert_list, &remap_list);
        if (r) {
                mutex_unlock(&svms->lock);
                mmap_write_unlock(mm);
@@ -3574,21 +3629,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm=
_struct *mm,
        }
        /* Apply changes as a transaction */
        list_for_each_entry_safe(prange, next, &insert_list, list) {
-               svm_range_add_to_svms(prange);
-               svm_range_add_notifier_locked(mm, prange);
+               /* prange can be new or existing range, put it at svms->lis=
t */
+               list_move_tail(&prange->list, &prange->svms->list);
+               /* update prange at interval trees: svms->objects and
+                * mm interval notifier tree
+                */
+               svm_range_update_notifier_and_interval_tree(mm, prange);
+
        }
        list_for_each_entry(prange, &update_list, update_list) {
                svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapp=
ing);
                /* TODO: unmap ranges from GPU that lost access */
        }
-       list_for_each_entry_safe(prange, next, &remove_list, update_list) {
-               pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
-                        prange->svms, prange, prange->start,
-                        prange->last);
-               svm_range_unlink(prange);
-               svm_range_remove_notifier(prange);
-               svm_range_free(prange, false);
-       }

        mmap_write_downgrade(mm);
        /* Trigger migrations and revalidate and map to GPUs as needed. If
--
2.25.1

