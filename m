Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C9EC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 06:14:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B656113D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 06:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 03B656113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584BF6E833;
	Mon, 27 Sep 2021 06:14:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24ED86E833
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 06:13:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myi0rd6pBNScm/YKg/QTVzp2LtNwRCEZAZdouhlibb6/ynG1pyt7z3m+lzQgLYAxoNe0dk6o4mLaejXKEqZBHd0ZzNpkMXIQmPA+pUgX0AioLHKFwgEyvkKL8Cww2hM0ba1vRLsv8G7vmeAGBQhCP6B4cM5H0io6FDCnBx32RAqRmZt9r1iOl+Oufvry4Tsq3sSR9cx1jB8S5qd0DfxDe+4fOIXPr/xTcTsxNEJdX1m8Jmsl7wr1dz32wr2sxJ0icMQLEg41FKizVoLmB8V5ICzSu1YKWXuFNYRSRyNHPY7O1kXny0X8BQOO6cJetORnbHRMJbgxOOjXXnRcgSoeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kbfUdRsDdBuzoO99363Y+CEc9JBFg8wHWzbufBQ15p0=;
 b=aaQT7vQxJt/MJYdwimsiUMWOicrHHSvXAe2U2tetcsbHqQai8tpYHVngC6v3XrW67qN+0ZGDC1bKdE7gMxnMs8dPtMLjkwLRfSPFqLJm1KMXfSVGq9qu3Bom1MILlyURdIkotxeAtLB/Mu6uLhY+MZBSYoKvTMbxktiSWZHjXTIRTizWCpQUxofDjcpcgd0vwX9dV6KrM5c4CVlYSc8mzBQCHQyDxeTP2zYgYNXMyJg3jK6bMuUXmDsd1Ma0ZObK/Bl47RUg4YhI5K5S3zboxhKb4k3d0Wi/PJxS6+Krd4b5rqF5r1xYD5geDhZ9hWjxTU+Jyi6MrXCcvbsTSNd18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbfUdRsDdBuzoO99363Y+CEc9JBFg8wHWzbufBQ15p0=;
 b=Ok691py4attlQh8XQLzdPF2JRQv0y/w8ZZO/qaieZ77+P3J8q9jfOoCckl4HUpPqpg8WjZexgpG+wo1vONDLcL8Ue+hft2KgsXa74+18Anru7awwqZQZIGFQ6ipbXIeMe9kPAplDwOaSbJYSj7/reJM/zkys/VCOcgSddGi4QxI=
Received: from PH0PR12MB5404.namprd12.prod.outlook.com (2603:10b6:510:d7::14)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 06:13:57 +0000
Received: from PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::b0cb:b276:609d:7332]) by PH0PR12MB5404.namprd12.prod.outlook.com
 ([fe80::b0cb:b276:609d:7332%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 06:13:57 +0000
From: "Ma, Le" <Le.Ma@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Morris" <Shiwu.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: correct initial cp_hqd_quantum for gfx9
Thread-Topic: [PATCH] drm/amdgpu: correct initial cp_hqd_quantum for gfx9
Thread-Index: AQHXsuLNcjUvaumX5UGqhR2yQ3G2mau3Z9XA
Date: Mon, 27 Sep 2021 06:13:56 +0000
Message-ID: <PH0PR12MB5404685AE7D801B84023043CF6A79@PH0PR12MB5404.namprd12.prod.outlook.com>
References: <1632666512-4007-1-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1632666512-4007-1-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fefbbe56-0275-4f13-b443-95e460e3729d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-27T06:13:34Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e6ac584-e5a9-4ba3-f176-08d9817dfd59
x-ms-traffictypediagnostic: PH0PR12MB5418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB5418FE75576811A689C0840DF6A79@PH0PR12MB5418.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWakPy1Runl55G+tGdXRS1rUK21jr5QP/OAz4t7TZeKiQKshUQ03nconaRPohdRbgbnI2q8qzlRoq7v24c7/9dAoXR/GAeUkp9nlR1hCpKnI9N7lpZo1+69NZlnuhkuufyRgjMh4tKOlekUTfDyBNie3JoFxvepOIDHT0CfXgVsz9rS2pVQxulmFnQRrvJBDvlSVXnOm70ND3NYKQWmbQ5gTQ7u+nJLtkpZsWL8WaCwomA7tOwh7MsUhPYXcn5/HVoRvALtoCehrV0TNyDWtd0zxSlYJUxGxtRLr70H33x+jSp7sgQD4zjR/QSlWmcltT2rHeVmJFgRvcTHLAJpYE0dLxALwd6NW0Rtr6RhQfhyNu5dQkzJPmwWEz0AM5XYCdftHG2Y7l9Vaqjpx1OJGR+IBUBFMXiRa7W15u1kvbs6Zp+44h1Kiwxm8JxmnEhdopTwGkL6cPxkAg1iTakp8vDQtJPYyoCEyNRj66Ft4bc7viPzMeSSbkGxzvqgFXFo3QNz1M4EMCq8TzGEiofkqGjNS9JSk3+qSftNcvTBvSoHkXqkr552y60XL9f7PDPyoXAk8detrc+ZwqygY4JkZ0VwSgcyYCx96OlrAoDdW0v4bo6IMpknqcSlNPLDUvlWuJ12ZNYSZKerOf6WMmZEojywXcAxaFmbJR++tkrW7j3X+gzQOi4Pfunw9EWpXXuE2ogruBvZz1gRAyGCUiWHfTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5404.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(6636002)(5660300002)(110136005)(38070700005)(8676002)(122000001)(53546011)(9686003)(66446008)(64756008)(2906002)(76116006)(26005)(66946007)(66476007)(33656002)(66556008)(186003)(7696005)(86362001)(52536014)(8936002)(508600001)(71200400001)(55016002)(6506007)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z0HWs/sgJ5u8xUKHdCq3XgYEnDKw8swl1S1m/xbNm9Gwo25thJXnG9LGb4em?=
 =?us-ascii?Q?Me64glRnCs5c4aCYd3IEO9/qKom2AsYHHA3snzINKwAsYqFXw2dWBxjUV3Za?=
 =?us-ascii?Q?cmbcYa3FG+YY/GhMYIxYNRO1StwlkWluv5HoBDMrrGrj/rSK0BscVhGlzLox?=
 =?us-ascii?Q?LpINsqq8QajNtwpBTyzTVBJ5l9aVEgrzTX3s4k28EViw9JLaGZCtHVOfP+8i?=
 =?us-ascii?Q?RIR+ZUhDxJHGPPo8Ve/gqsfgRQLBEuFFppog1zZgfBpak9A1YijciwdEW2oZ?=
 =?us-ascii?Q?XWIOsvHqQaO/LT3ZjV/Q9JIK1hYZsFLYjXML/SUa9/nU7LLk+FxqRJ0AVMNb?=
 =?us-ascii?Q?4ptyyO+X+bzoMgD1PDwzPiYlfeyb0voBvpo7VhX9ZhiKtays4bYImm0AoLmd?=
 =?us-ascii?Q?Ms1WDpwz1jiRoV7m6qHIH1x3ZgF89eRwszyUj/P/IRmpmEQAnq2JtibmBXja?=
 =?us-ascii?Q?4esUznl3h3t+Gm5EFKHxv8KRgDJA9uAdS7tnoLoV8S5ETfNk38EOvE7xjchK?=
 =?us-ascii?Q?HK+YlRcODfxmwjm6uGd/brqk19clAg7YhOn0Eub8UGd3cGFNAcVBHKvMuClF?=
 =?us-ascii?Q?+M6ksgJkKswL9HhTZZlOb8KC+2CfjgQZfTLUSnNRwD2ntOrkEHkupxkp4+ek?=
 =?us-ascii?Q?1ULS0aCn68D08CfKlBzlaAO3YVxzbl2dOmp0LXlK1AZ40hqP1Dr0hM5E+R5T?=
 =?us-ascii?Q?ZnBBumXPAhIiIGlsFZR4G17fC7ew4GOLm6cAs6mihcybDwvAkGoyx8cnjmXi?=
 =?us-ascii?Q?pJsi430dDI6uAmJoL3I0pr7ZWxKFYkARjThICVkIblxGgQVVlX36n7waJUK2?=
 =?us-ascii?Q?NWzCJNarTbd1FC53g1UQ4s/pvY5nsLehUL4FXaBlm+o2Wu6tyT1jAVISnqhe?=
 =?us-ascii?Q?Ot9YpJFoY4u8PieX1pVS0kWhLGBNmXwMb+o7W7H57FyAAvHKGGkXghQyoiVH?=
 =?us-ascii?Q?qJfS2kMze++3jp/YKoVI33VygmBz9vl8t/3I4Q01Lvcg1TEAgphx/S4jvEnO?=
 =?us-ascii?Q?GMlbLSWYeMEsHacfHh6A4Z5uV+im5VGx4K6Q8HG62LfP2BqnJA3nycV5Eeue?=
 =?us-ascii?Q?4knJhPCZZjkaVvfVrjLOnA+/tP1mA7dH8QSTFUgBppR06rGzkBcm2MgYmUSK?=
 =?us-ascii?Q?juM/HXqH50VFApdWDA+JLqQJowXcmXWIV5pe6X88xzN1X2Fd06jdnjyQIBCm?=
 =?us-ascii?Q?MhkeM9mVb+DGHy111hejFZi7SgyeH+euTBLL9BxCvAr3UDU03OIil2i8gOOe?=
 =?us-ascii?Q?1T4+++YHNVheDIkbdvJGWxSpw7sT9rF2ljg8g7xOpSvQlNZ3WHYyFnWfwkX1?=
 =?us-ascii?Q?IwoEZpKPtdIs5cgUtkHWYYYH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6ac584-e5a9-4ba3-f176-08d9817dfd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 06:13:56.9627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXOrWItuuaBUAQBoEbGxBWwToTx3BwHLpX/vrgzcqODcx7+MoLEDUQbcE2L2sEVb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
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

[AMD Official Use Only]

Reviewed-by: Le Ma <Le.Ma@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Sunday, September 26, 2021 10:29 PM
To: amd-gfx@lists.freedesktop.org; Ma, Le <Le.Ma@amd.com>; Deucher, Alexand=
er <Alexander.Deucher@amd.com>; Zhang, Morris <Shiwu.Zhang@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: correct initial cp_hqd_quantum for gfx9

didn't read the value of mmCP_HQD_QUANTUM from correct register offset

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 603c259..025184a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3599,7 +3599,7 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring=
)

        /* set static priority for a queue/ring */
        gfx_v9_0_mqd_set_priority(ring, mqd);
-       mqd->cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM);
+       mqd->cp_hqd_quantum =3D RREG32_SOC15(GC, 0, mmCP_HQD_QUANTUM);

        /* map_queues packet doesn't need activate the queue,
         * so only kiq need set this field.
--
2.7.4

