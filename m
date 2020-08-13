Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DE8C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 20:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AF220791
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 20:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EypjM+8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AF220791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891AD6E24B;
	Thu, 13 Aug 2020 20:18:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38506E24B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 20:18:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDuHb4wBteJngk4ZwrL4/Kg12ayiac6v8YEcXQVV3+7aV+sPf6QeDVzUGAzyo14twPhEwCziG05uT18Suag6rT3zLtvuPbun06K+HoNyVSLN3QnUHA0bY22jjqbggQaHLiG/GizeIK/O1aXLW13/ajUiP8OfKaTXG6f7CbObnirjroFFuEipIpfou/jVXqRJHIpe820WdVfVmAS2YtarnALg7yv3s36aqGOIOacZKy8lLfE2uf1huZSE1oJYBLQk7o0wvvE7+A6q5ARL99gIRyM/6vXMcoB/aEujPxMyXuO9hayjvm8lhIQWyjUJUqk3sgURUqwMRhVslsL/mHhrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8fHS+zFoMjTuw3VSOJkBNoabEtdVu3xjaZsHmBUFsk=;
 b=n+XAxNfwMRiw9cuqpcDVkewKjEk9mGKmh2kJNMsbxxg/qJzOoqBcpfs+p4iYGcl/m2MlnWlZRDPPouAFF+ns0398YcVXVSOiyM3V3OkFwJGgaGyrxP/lt81pVI/9w+qOld1rybyTycSXsQF3nz97Kk5oljZ9VL5GsWMnEWm00GoSS9rwkYHfn8o/Z2VjXW9U0BW/JFCZUANXfOreYlYlu/mH73V/bA3Wroy+snYth1ZK0NzHN9woK+n+DK9KSL3pDRl8cSLZXQeCs/+kPY2QyQRqOo74lWdZZMYFzNeOKiL2BJg3ji/5xAiQDUfgSruisBb+JGD8DPY1OXLhBSGVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8fHS+zFoMjTuw3VSOJkBNoabEtdVu3xjaZsHmBUFsk=;
 b=EypjM+8wcmxlYAffL8GNq6sBt4tBTsy3h3JwGscEvDyHBOWveQUT4bXPXLyC5VJDbfwjsqz0t80i4zh1SH8+45ayXRkTmYiG6MCAf5viqtLwmP2ySjCdRoV9SAvUV+c7JZt1EcsTnQY88s8vXjnKE4or6j8MFqpTFbmPZeCzsXs=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Thu, 13 Aug
 2020 20:18:08 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 20:18:08 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn3.0: only SIENNA_CICHLID need specify
 instance for dec/enc
Thread-Topic: [PATCH] drm/amdgpu/vcn3.0: only SIENNA_CICHLID need specify
 instance for dec/enc
Thread-Index: AQHWcawU6UDRDuTUrEy4Xu+a8PANaKk2ejNA
Date: Thu, 13 Aug 2020 20:18:08 +0000
Message-ID: <DM5PR12MB1787C7F9472F125EDBC65131E5430@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <1597348667-17504-1-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1597348667-17504-1-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [173.33.106.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0fd92e8-64b0-4bcf-93f9-08d83fc5fe90
x-ms-traffictypediagnostic: DM6PR12MB3657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3657C4EF38BBC5011BEE8655E5430@DM6PR12MB3657.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JkzeI9jEGKlkGrWa71nbrC6g7dwtL8xtKVwr7CP8zTwDs7PrN8x41HvTGyg8tq5sphsRhcl1FPcYQRQDzEfzqE6jGvkzP0ZSqGNMOtQbkY0VLbG7CHFQ22b5bH97w5TxmrIwNOGRMnapqe6o3/i+nAQdBVgXBPC6ImdoXlxFWeulNuI6JDgBC5rCO26JfBiBzWpgFBNSbAyQo8iuipx/uDJbjJZ+/l/Ik5MSe7kvhodwR4/UFh8FFwh4oI480Xqf+VRmmU+lGK/ZXWkdikILsIXk+QTLIzg9qZ9dMr3VS0eLRF98uae04oD/lhqw9ABTeVo6X8x2Ic+nqL6inHZdYa4w81cMF5y8qP9h+LA1+4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(66946007)(6506007)(186003)(83380400001)(66446008)(26005)(53546011)(5660300002)(76116006)(33656002)(110136005)(316002)(52536014)(71200400001)(64756008)(55016002)(9686003)(478600001)(4326008)(66476007)(7696005)(2906002)(8936002)(66556008)(8676002)(86362001)(966005)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4imL/gYO6ip0KFDjezabtZ6M8cqkywJ19EoQKRbU4smc1q6AH1+dyc+Y+uNQvp5beF/GnwQoJVn0TUBXm7nSwf2qBPJDCd3HLFUjtDfwj7aq1iXBvLd4LhBYQBV//uAFd0q19GGM6kBjP6e0QcMIYSzLyRjWMyogJbvPOGCqeTj2BvBaJTKbqwMrV5REs72HXREALpm7lewZzU8XNOKn+hdB6fLNvcuG21hoJeQINRRaDAGb0Zh8XgUbvWwy5w0Ik4YSwg+4DzMdemeZv1BGlxijB2Bzhl8BdHkSfOIFOc5aUrUxgKxktBaziShqoLGbKb0EEw46oe9PQJwQ55ByjEs7IZPq4PreemfwWeAwgecaq1NdRhxM6YBZG9ERDyPJu0W8KhacmeCPMEtkLOcKWAo4shA9pdWtbMs718ScyKCn+fFsQHyugA/KvhQ2KFH4x3nvH/ISC5FxVTvT4YQWEe2Fgwe1E/w5AeZcED9wMYIHL6roq51mRd+XZu0BOxd9ChBQIH2lFbPwpWPR0TMFaC2Iks03N1QFjR/MwNttuJ3hbbW1Yb0rZnHyfeMvPpVuWPoTUKvZU8nPxuzaZX/L/5CHQFOP0YFlBaQQfslX4GSdKL0J/TYWF9e7hXlrNFTOX03u1st4yJy3Odir5HyBDQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fd92e8-64b0-4bcf-93f9-08d83fc5fe90
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 20:18:08.3510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/JjJzHrWuTvFMCFNswzd5pqwubVJcYA4OvthduRlznhmzFbBsXc2JtgzYll7m8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3657
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: August 13, 2020 3:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH] drm/amdgpu/vcn3.0: only SIENNA_CICHLID need specify instance for dec/enc

Only SIENNA_CICHLID(VCN3) has 2 unsymmetrical instances, there're less codecs on instance 1, we use 0 for decode and 1 for encode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 63e5547..589d6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -198,7 +198,7 @@ static int vcn_v3_0_sw_init(void *handle)
 		} else {
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i;
 		}
-		if (i != 0)
+		if (adev->asic_type == CHIP_SIENNA_CICHLID && i != 0)
 			ring->no_scheduler = true;
 		sprintf(ring->name, "vcn_dec_%d", i);
 		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0, @@ -222,7 +222,7 @@ static int vcn_v3_0_sw_init(void *handle)
 			} else {
 				ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
 			}
-			if (i != 1)
+			if (adev->asic_type == CHIP_SIENNA_CICHLID && i != 1)
 				ring->no_scheduler = true;
 			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
 			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7Cba99a8b0ca6a413a28ba08d83fc334a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329454944119883&amp;sdata=9PYAw4o1vqzZB7ieicw51McVNXhQtlc52lMG3wCPeoc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
