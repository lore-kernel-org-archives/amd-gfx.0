Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E89CD4F54
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 01:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD88D10E1B9;
	Thu, 21 May 2026 01:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nb5a7Zda";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013042.outbound.protection.outlook.com
 [40.93.196.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E037810E1B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 01:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV1xNOCL3/gS/DF2JbialssvRTWyI+aYtxt/VEb5EJ25j+SJMXFLJFw0cjh3wbp343LnQ3I1uOd02cAobymJ18sBzRX1xLCVw0X9td1E8QwC1H2Lr3Fc+UJg494uwX9BRhRylvBv3qFFiCH/RIDtiFEFfZb+SdB3KdP8GPruL9mbxFJK2UU+RYBqN5ouBu+4PdKNQu9UyJ530+RjFPNdTsRWhZSw6ymQgELEbe3fFkmD6rYZE0lVRn94wqcTfrbQvlts5nhqO0nPG39uCe9poINGsl5sbpnxEgESqI4DsdOvcQpuVRgnNpeWs2K8HdDyiIsjHKsrL0Rq05Uq2WIv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czQy2/jA+btHUl+LHVgGMNQoDh88FoHMdq3X6JQAvsY=;
 b=faEV/pPj+SQmI8DfgxKCITUNOs71Vp4hWeweEs5QnksR9tOeUKLvpnOYUKZqEANCwFtU8iU6UL5QO3RqF3qUQ2DTB3AQ0aDa0rBXSY7mYRbmUkOeDf96C2/BS2YBDDT1auddGPjJOocTAwHNMevL4VfQojda1STRP1EN9t1kCrbBJv0QNO4uVv7t6nDeEHKz6YNyy0kUFzrZAMwZmmgftgelW3vNdU11GwXBqeZYuOzHMBqaJm8VQmuwQXce/8B48AtKMkubDRFbG81YCuIPnihec/1s4LZeacLM0JfB40P8Ti2um+nuM5t8dLGHA8jylVoomU/yMv21o9+dwhZJ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czQy2/jA+btHUl+LHVgGMNQoDh88FoHMdq3X6JQAvsY=;
 b=Nb5a7ZdaeFh9p45fnZa9n6eqGxc3d0/0KiCqJvQPefw5PN79PqDab/CdwhOaSqMb5TZEeW9JP5xT/4JlGyiQFMPR1koKaUZmfuJtD7T53/ty+ZbGNAcbHV+pyizwJN4TLyXN65fvsYZdCq5jy2klzL8GfJZ3GUzX9nV4eVPdC+I=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 01:00:39 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 01:00:39 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Cheng, Benjamin" <Benjamin.Cheng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wu, David" <David.Wu3@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Cheng,
 Benjamin" <Benjamin.Cheng@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vce: Add overflow checks for size
Thread-Topic: [PATCH] drm/amdgpu/vce: Add overflow checks for size
Thread-Index: AQHc6LFxtSt9EiUTZ0Wiw0EUF8Q0vbYXqQuQ
Date: Thu, 21 May 2026 01:00:38 +0000
Message-ID: <SJ1PR12MB6194EE2F1EE299E4F56B2F27950E2@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260520233543.2118183-1-benjamin.cheng@amd.com>
In-Reply-To: <20260520233543.2118183-1-benjamin.cheng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-21T01:00:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|SA1PR12MB7037:EE_
x-ms-office365-filtering-correlation-id: c10c28db-3a99-4246-ca9f-08deb6d45fd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021|11063799006;
x-microsoft-antispam-message-info: FuwQ8NT1Urb+2J9XbybZEjSByRSpjnRT1QY7LcdDebCEAzh8BHxVmNYQGjnfeE/SUnKchpJeRH4DCb+0PQyyVF4jMJfI8NJxqJ6eL7xAINQpA9YeGmEE+B9uuo309lblOho3osBRxRMkDaU8HPx1/a96q4php4TszLy+eX3KO2IDlbjh7Nn74boL9GaMEvVGZyVDVDshvlPEqZjl9BkshyPcS3VzMvZqlnr62IlfyXDPB38lMMEoxp0v9k8+SQXJ+2p2dqH4sCGj+07E0qneDi9gl6eNPaRfxM8scNLvzSDz9FCt9fUnQIbxgFvFQXxQ/bNWe7fi2bPIT0G4rCP/L5ZxagrFm5Zo3XpSjdKpo3HekCqXlNv22GQTPLcSa65X5CIxI/HU8XRKqbUOzT3xiBmmieZky9KVOmYZQQE/EE8yC0S93pNSLWKCb+oQcJDCpMHE5GJRwqCT2ABsIKAXW4Pv2P+6ZlH9+W8NUgzmYLEyE+LlBfI79pvhcMEOaxQ7cAMuS142QeUlOJOnyXXQ6qed6uBDYxrqzUIFwx31Im8bKrW0ab3fShION1n7RXz9EZE+pPZ76E2UdtfPQibk18l2H0V2O1xAU2Y6YpEgr7XG2fa9EvgQSOKRSKbTQM+3kkBCpMWe/OP77ftLxke/KOwVzWVfBb82T9aATBzxQPlOOF24j0VnuKmVFxUi+5dU7KTU6Z0OG23+Au4f2wwC6NQk6uF27AxQOqat/OEXPLGBF/S8DCvsSyfEYRXWXO3w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ShACqCrnjGevvMFI6+8d6y5V2U8fNYt3b4gSDOdueL/F9biKL84FbfJGwbIU?=
 =?us-ascii?Q?2+cccWEp4C0pzhyMxriJEa4GkKvlBdLZ5p8BqrHGaFj9/IXryYJVo8InHiXI?=
 =?us-ascii?Q?juOOht2OwMQXi0BMkmIrGUEJ3XItx4XMlmU78J77m+NF5HMQWn1eEs5Vlruh?=
 =?us-ascii?Q?EoB2vLY7UhkQCJusCph4Ol4phEV2dqSy12G4tFplyUISUQdRpJb2iFvLPe5s?=
 =?us-ascii?Q?Re5gJlk5VsqhIaZuqBPVQniO/syBSxSMJ2CGRmNcHRXRnRDmJcei46YhM7bt?=
 =?us-ascii?Q?Wyxgy9k9tP6hyyg2ATb+gyW+xduCAzOTdQs0EQG/UiKprKYW5Ymgjxpl+Tnr?=
 =?us-ascii?Q?65ajlo2y/vt+xc7oPEl8snWF9X2KjbtrLZEbW4ctPt5elqg3N5QDgH12v9qB?=
 =?us-ascii?Q?P+wiI7A6W4Y8B6RHWf8cSa+VmsByKBfvEkr7/W+9k9vnj3EoPM5MSMStU7Qf?=
 =?us-ascii?Q?xl5jrCSe9R4kOJjmXcw+HLPhoPNkHds/TdNAgGfSKxFf57ZOzo9sFKQtj3Gd?=
 =?us-ascii?Q?ZHvwQZmK0EhW6vbpZcWCJ+gWcC6S/WtdP6fF7i/2eI+TgvsTiwMbKNgkjSIU?=
 =?us-ascii?Q?fFFt+xcGhKtiZ1RNqqi6n4hSL2R9F17p4JVz2t6WCTUllnpYGQwD7E/Fyewm?=
 =?us-ascii?Q?qH6Yr4Ymg+u6VGJyhdVSaBmc7C/xLTHgCvNhwTz4Kmxae97DZLLTWrlZm8l0?=
 =?us-ascii?Q?evGq6Rfmmy+gsJj1kTzTJQL54OnNjsuHfUNslXZdVIZyyakFE69cy3Kxxx79?=
 =?us-ascii?Q?fv9yCxLE5GxHlYL204fMMjVqG0wWdSonFaqEdKexSSiqAgeewrOv+vOki5YO?=
 =?us-ascii?Q?EU/fV/wxE7tzu4fqDopS5E26CQKmWRLY1ynlswVjq3g71lS8fCpUvr+O/NIs?=
 =?us-ascii?Q?p7vdPKBE72pwGKPT85Bt1d9GtgkXjO4j/0pvHK749Rxq34Yr2aLDIhilYtXB?=
 =?us-ascii?Q?7KxHQNQs4pl1X+IDInwk09n/7QQ64+AKJFDFzPYiCDmHQ49ueKHPMdtN5bie?=
 =?us-ascii?Q?pMc85WSPJyi0QHEeMpJcg9ZWyHcF03XRgJUI9FSJT7jYBr7ThvZygU6SkzBf?=
 =?us-ascii?Q?h/8/bUExzKfV0phBavAUpvx4sbyimEoQWM1d/RNeU8c9OICEeHmanLW3EsS3?=
 =?us-ascii?Q?Q1ky1w5fDXLdFLCmU2IeYh3E3BNr8rNdu6VoFBd4v/zHdrxSeofy5CQn8CrL?=
 =?us-ascii?Q?2IOqRxmVEbLTGuQMJR2m3n+sxnd3yL3vuprvV7TEz/hSvU9UG1xT0UYqp/rs?=
 =?us-ascii?Q?NudsVKzhMQYUA7voR+d2Q5Ro+snw+xSssGQpLK2diPvWSq962qS0ACnMUKTe?=
 =?us-ascii?Q?dislPUCuMxzdNPyIyNLbkzNA88fCJcaep3blPol56HQoiua5WhLjEBVPQ/E9?=
 =?us-ascii?Q?LW+rFqsZ97ZOJGrVMN3Y5bsx303KYm+VRGZQme3+jZ6c3cfyLY5dIkHbafaU?=
 =?us-ascii?Q?eWmEiVZGgYrOKkaJtoGWXwUNTKbUYpCHODhSaio550rrbI5chRcKvmT0xH6Y?=
 =?us-ascii?Q?O8SE0RCzzNHUoSSPBKe0+dm6T1pKRNl0LQSpZNk+SP+KudQFUUOLyEVyiJxa?=
 =?us-ascii?Q?HNlHZPHuaWzr73qNJLVQvZLV+aIxstZNvhvIMl6Kx0ifti2hfvM2EEbmMvNT?=
 =?us-ascii?Q?p892bF8/7QPmu0sLfTvY/AOtWuaO+R95gQUCI1Sdy+c8VsNR//nIIgCx6tml?=
 =?us-ascii?Q?bdcYVretiMU6Fb35VIcJ3VqdGxth+nYKOrFWqoMdZGKaLb3g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10c28db-3a99-4246-ca9f-08deb6d45fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 01:00:38.9701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cXhmXuUwyQ0TwjzM4eu5292qiiGRvnHCBiDkWMXnejignpTuPukuYsIWg37e09Db
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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

AMD General

Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>

Thanks,
Ruijing

-----Original Message-----
From: Benjamin Cheng <benjamin.cheng@amd.com>
Sent: Wednesday, May 20, 2026 7:36 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wu, David <David.Wu3@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>; Li=
u, Leo <Leo.Liu@amd.com>; Cheng, Benjamin <Benjamin.Cheng@amd.com>
Subject: [PATCH] drm/amdgpu/vce: Add overflow checks for size

Although VCE has HW limits much smaller than this and should fail without c=
ausing damage, prevent the overflow just in case.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c
index efdebd9c0a1f..d73be4d7eff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -877,9 +877,15 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *=
p,
                                goto out;
                        }

-                       *size =3D amdgpu_ib_get_value(ib, idx + 8) *
-                               amdgpu_ib_get_value(ib, idx + 10) *
-                               8 * 3 / 2;
+                       if (check_mul_overflow(amdgpu_ib_get_value(ib, idx =
+ 8),
+                                              amdgpu_ib_get_value(ib, idx =
+ 10),
+                                              &tmp) ||
+                           check_mul_overflow(tmp, 8 * 3 / 2, size)) {
+                               DRM_ERROR("enc size overflow!\n");
+                               r =3D -EINVAL;
+                               goto out;
+                       }
+
                        break;

                case 0x04000001: /* config extension */
--
2.54.0

