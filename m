Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB88ECAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 17:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657C910E878;
	Wed,  8 Oct 2025 17:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWbL3a48";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 957A810E878
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 17:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqXJ3rCx3ksG/6itw0zeel51iYJFRFrlvNvU0nbMw1blaXUWmrbIHlmsXl1dgd/l2ZR2i6ZcDA2kOknYF0yZhQth1q6jOiIIpYdMjTYnwFcgIYVt1iFCv6sS8q5VPOsrDdBBCCZcwF4G/PcmNHv5W5INJl7RxeqhwQ9i1NqzbaBto34ABrhWx8h5M3EbqAEA9FILR+yK9dfEebAWzRGFhiTAn4w5k4DKZcS3QZ6IR4aHbHCZcw3qA2pLwlAdMBhhN00p1u4uzOK0h9K/1uCj0hw2fhKa2a97H0qJ0b8C60oyUT/hyopntPFYlwbgpI+ZCQ4byah8JJOU+dpUswgLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhpHNQqNEC1zVd0dTHl1XVclDgwNqUJP9xl+uRqtGys=;
 b=JuHS9Z/dTygVnsCAvxLf7YcvlpdPO0OJyfhAd4qOuaL6DU+EishMTqGPJbjp8eZFVFeuPAS3/pumsf9javVl6bHtzi5GpQeVeeGL4QZ6lCPb4wgWHZFmWfviFDmYKKJfKwW+EHTsaupangNKYLGz9USCMjqm1pf2aE4l5TU+S1DjIoc0XN2PSmEheLWTORslP8vt30rNpmq6nyajCm9EEwODXJYBliVaJshvyiVW3mqj3Xl76WNrQrgcXtGpuNKdojglI/8eY108luP/6QEIlxL2+aVkqSw0DFgXbAbp2SGy5p0jkNaYTB4YczRq4tZ7JzVfPN2AbRNF4YyHjknrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhpHNQqNEC1zVd0dTHl1XVclDgwNqUJP9xl+uRqtGys=;
 b=LWbL3a481FoEGXXYjPylGZ7/JkLcaAd1ZzSDY6gLUVRBtWbTgw3XPoS7DlN06jT9mX62Fv5io26QyKHj/Q8AqaUcrZ7O5LeS9qOmiZSvLcF1mMRAAAIQU8CJlnYct1h1gwjoJ2l5cWKO3/riKgYb3gxUGX8DxI3Seo8mowo+i1c=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS5PPFE52C859EE.namprd12.prod.outlook.com (2603:10b6:f:fc00::666)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 17:14:54 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%7]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 17:14:54 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Topic: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check
Thread-Index: AQHcOHLJZlOPE7zC5kWL4J+uQeUrJbS4e2hQ
Date: Wed, 8 Oct 2025 17:14:53 +0000
Message-ID: <CH0PR12MB5372D9F4DABAD16DEBDBBB0AF4E1A@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20251008164408.850834-1-jonathan.kim@amd.com>
In-Reply-To: <20251008164408.850834-1-jonathan.kim@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-08T17:08:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS5PPFE52C859EE:EE_
x-ms-office365-filtering-correlation-id: da2b8a76-b91f-4093-a0d8-08de068e32c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QoFkqZztgg+vOrY8PKMh8xDvrKiQT4rjh6Er8MOugBizR/esFz4Zot9NgXQ1?=
 =?us-ascii?Q?rl4QRLFl2xHAVNNcIEeo1d1ZRXdVsZrDUa/PzCjFb9axHGJQdGmdCj8zGXcP?=
 =?us-ascii?Q?wvJzFoJSw7/75UUtVrrHb3rZe8eqacFU9DPsjaKP6h8h2Au/LyzhXB5CnOIz?=
 =?us-ascii?Q?34nDwQLp0FubJgapOEgmwLU13dqDjfrhdQCcMmyCvTrt826jNgyVN3VgMSYS?=
 =?us-ascii?Q?chJ9rGxnDqoN9sV8lfdW3R8mCxnamqO1NCChn9Z9Cn+qxV+z9JUGilKnfzK2?=
 =?us-ascii?Q?+7eYifX0jI7E6jPeQZZiw6B8N2GuZwL3JsMt6YfKzDP455xqxRy2UroLW/Ua?=
 =?us-ascii?Q?D6Kxcqokz0qYNEJpfE4UDSZF82N8CgP4jgTBXpEek661S6OmzaXB6O/AWu5i?=
 =?us-ascii?Q?4igGpSveF9DMdtudFC+0jkIla/FmSiuUsehxSCm1gi58LOxYu77uJBdCJaUX?=
 =?us-ascii?Q?SyayaOe5lJdSloCf8ITHcMfK/ogR8wmP3WAg8LWMW+cT2PiQzT+k2U09FL2W?=
 =?us-ascii?Q?NckhnrgoUKvxhHS7SW8w8RUonaoDXbk9EVPaGmubCpRl6YjyQlq4AbFMgVeS?=
 =?us-ascii?Q?l35AJCPhp5/mIh0b2czV6cVHEkhGeVXqDEq7GiVs7ZhMVIbnCoM2Y9d0HebF?=
 =?us-ascii?Q?0D6LFDKy4stfY0e5Q5q/maZlnxG8AX7qPccH3rzohD5sK+T1UQTskThQFZ5x?=
 =?us-ascii?Q?h6kIzFWZ54ZyrEBs60Z8sG93o7bsd9wbZE8xXVKCaP5xf511B4cGe74I1/f6?=
 =?us-ascii?Q?bBlyZw2zypfQqQXpkXAtKR/SHWIrICwiDIjUFkxsZBH1z/c6qnr52xCc3gt1?=
 =?us-ascii?Q?MXEH2UVZlvC5DDRa7QYFcC5tbbJUQdeRRTOp/j+5FezzWz/2H256diABhMpo?=
 =?us-ascii?Q?YydOFEyDRunvnmhkOcM3TWNa+jMkfub24D7JP0IlvMPhE7af5xciLnrL0c4D?=
 =?us-ascii?Q?AnlCrzbVhcBjK6Q0pqjmlm+L6xGFRewmeE8o83kTvkwCim5LmNc72shU81NF?=
 =?us-ascii?Q?miovOMKzZUqhCKXA22vRQYrMr0li8fgInwFVDRBWI0y2yKax2zrtlDS+oB5S?=
 =?us-ascii?Q?FAvhMXt+aKBEABrHdVPIqDsmd5BWQRINgo4PUMymLzi8vmAklkhUK6sJd+vC?=
 =?us-ascii?Q?hVY8O5d4M9B8x9oQ3A0tdKkFOh8MH18dhPWQllxg4f8sTJ9ZM3gxMJt+d9Gm?=
 =?us-ascii?Q?L8nbidKXfhr3k4ZOk8KkWxsnefVC1XPpGo/IvJWOSfgp/Trst7IzUKkrnBRU?=
 =?us-ascii?Q?YHS/JmlLhYi7NqD/kiLGz5PBnUDXTpzdyojniJ8jSrguFc5zya0ZBspA+GuR?=
 =?us-ascii?Q?jhjt0WRa5EvNA/RBXPKJ0DITjHISUVAZVYrvhIV7QkOiWaILY43HbLcYM2IA?=
 =?us-ascii?Q?ec2fcUNtfKI7R2+n1xsjHuJdSkk8Fv7uLcTjrWuON2/xU6fB3KnN6vk023Ft?=
 =?us-ascii?Q?BlIKIrXf4BUx4T2iTqDT1cT1sgxKfgY90xXiRqDRj6Dc4u0X5nLXrdvjtfHe?=
 =?us-ascii?Q?9Cz0H3UtOu6dCWC/NiYQbJp7P2IebM3to/Ir?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gjJeioRz8ODJ2H1kH2KzO70RSs/63Hl9iy4F+hl+4QDW4PleRltLgwU3ti+e?=
 =?us-ascii?Q?gGKIcJNQCOkX5ngtsRcne/QnUGeimEfMiv+XT0KH20CXRByAocfQ+V3yZEdK?=
 =?us-ascii?Q?aRuqyMtzgNjZ9T0kX2MHc1d5Tus5RBRD7AxyQqWWPo6XjkpQvqeSufVBqoDY?=
 =?us-ascii?Q?sTwmxQvYIbV7jOY1QxK4bDOu6ZnHxPEejADKtJVVcib+b6W9h0jZCPbJfq4c?=
 =?us-ascii?Q?fnn++Lxei91KCfBZ893TqnkgZl67EJ3Ofp2awCB5BydylfooEs0mH3WQju4s?=
 =?us-ascii?Q?/4cvCGLrQHmNrjMNBh1ZWcmuGEY2sGaVKpcUlcTlm+9Cr46bB6VDm/Uliixi?=
 =?us-ascii?Q?rbDI4weE1Auwz90t/9n2Xg8eKXxosq2uTpaysTmF45Fyu9orXeOclkTz75mO?=
 =?us-ascii?Q?ijTQaW7F7p3PJ6DfgYWNrk+kHiO9mmdQs62/5qTJ5nTiEJfRV3IGfsGOZdkg?=
 =?us-ascii?Q?HCVSasY4p9mg0yC7gHnSix3oYXE+XKSC5aRjjMMJPTP6s7Hq+QyWBG70Bip0?=
 =?us-ascii?Q?4OCk3Y/9SfBP1mP1nuzkAq+84A73V1dwFuwSvXX1L6DEXBFyILVSGJjnrQX+?=
 =?us-ascii?Q?GmVwhfEgRGmfQJ3X//o0aG0kt33zeLmOXQITs/hU+91/5B62QvSqM3XHWCvP?=
 =?us-ascii?Q?jcsC62Tci551IaiSIeoTi1sx5TL1R7oVLeUH+x6pCh1ddE4nTeysUCC5C77F?=
 =?us-ascii?Q?I1Po3XHG6ZELGdUJzIBDlpvBZMqAJPvUeAFJYoE09sYeEqRcFPnHjlZio27j?=
 =?us-ascii?Q?BKlAVB+2Ru0395cvWeriUW6WSmSgaSNczverIrwkqVC+8UxTHnmfKdDmqTC7?=
 =?us-ascii?Q?SID2V3oOIqJ+xHoajmYfet1F8xN55HodqqngNd4JHBa8iiOaLJ1lIAMDyhqs?=
 =?us-ascii?Q?gePOGlJX+817Zm1f6lfD/hyOkbx2U79cZvqtC1rAjgI7IZmQfY7KA11y5jVz?=
 =?us-ascii?Q?qZBvkCnuDFwntXs0OtQwfuAEK3qTTWlSjoFVrGfatTllGPsEGdcBMd4B0ner?=
 =?us-ascii?Q?cnT9SKclGGyfjj+WVNDOz9IEhnKuX8pKU+lg1B9SW6ejuWK3oh7tOov69Dp6?=
 =?us-ascii?Q?W+CLDnFP1P3X4kN0M5mCzDRZWbPIHc9ktFTs8qNaY9kkTzxs5XtnypAZCFkC?=
 =?us-ascii?Q?TGWTZNosTRAZaXnNL8BQoR0lurTY9NsCt4NhFKOxsFmtGa79C1RtpFcDUGKp?=
 =?us-ascii?Q?zFHlce5gR46puPltUK1vm6uk1tUYnG8ZGQhEtKbdhXTc0BqaX+HDPBoGJUCH?=
 =?us-ascii?Q?6nuPrwwGHTxRDkqxvqu91ndl6G5tPwUb3mifA3HzYCtiVNSZwq8yOWsIzIUh?=
 =?us-ascii?Q?A9zhduIbKEin4ii6Cw3dMylE/P1KEf+hx7iEs2BRI+V5QQ+UfyRf9cjG99wa?=
 =?us-ascii?Q?hAZOW8FYXUCj/0ogHQfnf+rbLjgc/DKjQd5RrieqF/MJySgIkEX8wgoACPCl?=
 =?us-ascii?Q?k6QC3urg5gsJRhWxPZ7/djFt6Gi8cFIctD9Sn40eVwQrfPs7I2fi3/LAq+HG?=
 =?us-ascii?Q?kQnktcBXz9mvMalWTbRzqbbnDZDfzrsg9T0chQkQfMnAwDrzKJ0DOodlvx+i?=
 =?us-ascii?Q?HT5N0m57MeFp0X0+SJk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2b8a76-b91f-4093-a0d8-08de068e32c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 17:14:53.9681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Ea7+/KR0JRU91wG/A6gKcjZ3a/pTIlphu/bKILg/OLLaK0WkFNxWSKPZsZhyfTSkJzxCTTxszrE3LVlfh6jmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFE52C859EE
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

Looks good to me .
Reviewed-by : Shaoyun.liu <Shaoyun.liu@amd.com>


-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>
Sent: Wednesday, October 8, 2025 12:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix gfx12 mes packet submission status check

The driver currently only checks that the MES packet submission fence did n=
ot timeout but does not actually check if the fence return status matches t=
he expected completion value it passed to MES prior to submission.

For example, this can result in REMOVE_QUEUE requests returning success to =
the driver when the queue actually failed to preempt.

Fix this by having the driver actually compare the completion status value =
to the expected success value.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index aff06f06aeee..58f61170cf85 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -228,8 +228,7 @@ static int mes_v12_0_submit_pkt_and_poll_completion(str=
uct amdgpu_mes *mes,
                        pipe, x_pkt->header.opcode);

        r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
-       if (r < 1 || !*status_ptr) {
-
+       if (r < 1 || *status_ptr !=3D api_status->api_completion_fence_valu=
e) {
                if (misc_op_str)
                        dev_err(adev->dev, "MES(%d) failed to respond to ms=
g=3D%s (%s)\n",
                                pipe, op_str, misc_op_str);
--
2.34.1

