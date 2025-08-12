Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94C2C87FCB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 11:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73A5010E3D4;
	Tue, 12 Aug 2025 11:10:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VPwTYsdA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D6D410E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 11:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5J9jukboIyfKqwNrBqvQeFZT7JESA0n6KxFdfiGQw8QxMxDkSxnUViOZQwXvseln3EjGCpPfJf8ucn9c0GbUpXOEV0etsTIilkuuSu8y8aLBo7fY3KoOpq3i1yVduneLLqfOfdDZMuZkAOM96o0yOd1AjPDAGNdgFGxe9nKsKKY3C6p8gU0Y02GId1A+TL4S1Yb9apWaUfZ82znTuVuN7/XPf7R+A/IT5w0jUmDgWLV7YGhmaQp6MsuY43HqLBfKKAlULnpOADSYvMwJoQKLouKl+oOOLqQcBM1Zdduj0fx9EMZd/IpeZpYPfwEARyORF6C99POz94SvD3RGrvAmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwNlBl91de2EYPhILmXJpTvVRC/lm2ltxMGKlcHm8/0=;
 b=jCWqOzjmI9GDbxZi70YsHb8sAikYL6n+2CdvIXofwwhsHlXRv4GU1MV89/qGHUr7BDV5BaSMObugBn7Rfza/QcnKbmE5ab3NSjzMLk7ucSacIIzRML6TS/vCrH7l1d6lP6iRsoHg50XHcSZBKIE8rq37HQH+ekdnyVan4sn3pj+w8RfZT2foXNn/weCiOufWG3+Jm9wp3nxmaQ2z6QTIvTsqXyNYY0SJF83GBsT3287PcA7oabaPHQRFCM8sbyXjt7HIoEET7gonN9rezOOlWjhnytTWG66x8IKYcuF6NKDUAQ406arvkSh2J6rbFLry/DvJ8Y7WE/+N1z4VfFZT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwNlBl91de2EYPhILmXJpTvVRC/lm2ltxMGKlcHm8/0=;
 b=VPwTYsdA7MqhcZo5Bhhq+Yd/itkuASoGROr2AJK6sFZXTX1KYhlVxesNwfeDzHkULQ2DMdAuaUoOGlpMAaZcimXhWsGosjfWGyARgQR4koayMWr0bX5HtKzoP6kc8aXbnOPgWMb6sKY6euWYZHyMUJoj9u8xzI/HnxpVh5aJ1nE=
Received: from SN7PR12MB6958.namprd12.prod.outlook.com (2603:10b6:806:262::15)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 11:10:15 +0000
Received: from SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d]) by SN7PR12MB6958.namprd12.prod.outlook.com
 ([fe80::3f01:2354:6863:4e4d%5]) with mapi id 15.20.8989.015; Tue, 12 Aug 2025
 11:10:15 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Topic: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info
Thread-Index: AQHcC1up52NvYtfNJEW1zyVYhOkuebResPiAgAAlPuU=
Date: Tue, 12 Aug 2025 11:10:15 +0000
Message-ID: <SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BA@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20250812073453.257913-1-cesun102@amd.com>
 <CH2PR12MB42157554010D0EF4E81D4FA7FC2BA@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42157554010D0EF4E81D4FA7FC2BA@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-12T11:10:14.5870000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6958:EE_|CH3PR12MB7642:EE_
x-ms-office365-filtering-correlation-id: 59e2393c-47ac-42aa-008e-08ddd990d073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?U3fN2KYac1MkAfJtm9dWz9mz6HHu1ken+1iXxFOjUux7/k3gaEX1NcBVfqXn?=
 =?us-ascii?Q?mIyB+TlRel3y+K50mz3yjlmJv7LXU0hE1GgVsJl/uRKE802V2qwvPn6gOPKY?=
 =?us-ascii?Q?3EZb43PSmZY1Hcnzyo+75+XX2osn0NrvB0En1Yv+tEBMSz/e7Wd2EGk3c5lY?=
 =?us-ascii?Q?S7VXo3Tv3LF898/NHxbla+Xq99WeeXRiS/M+YccTDF/RkVhskm+yWGiATlaq?=
 =?us-ascii?Q?Jn4rR1cJKjfvaQa3kQEe8nqNwT91bnRo8y9QZ/zillBK67f2Xzuo35kG2CBU?=
 =?us-ascii?Q?h+eTkj0IHEGi4pIBN4UlneSjIbj3VbwMW5CG5Pb04PWvTtlsl0G4MVHplujZ?=
 =?us-ascii?Q?eibO2x1hubfr8aSAGq/ng1A9eiaecIUNCy8GZurEjaGF6Be+TmtuGDEajcCK?=
 =?us-ascii?Q?5DFHiK9mE455ZY1YKuMPRMeIAldSbdtQZRswwLGX3d0EbM9Mx20LNbJRAX3U?=
 =?us-ascii?Q?MrvvX2r/7WYoT09c6O6J5oDvELLRHyV6lAV50aI34qg5p2P/t1AEzMYsxXuz?=
 =?us-ascii?Q?VNOE7k09Tz3Dioyuek/XORXdbjS+rzJqCV3GCF2j3gEctMd3UK8M0vb3rEsv?=
 =?us-ascii?Q?Ngh9cvqC5dGl0LWB6PEjma6uOfmMyXLcfUw1i6csETxg1tv/3IRUeUPmamSW?=
 =?us-ascii?Q?gkI5nqwmE5eBFfysjaqa87MXYca501EXQZFxSA2i6xy+AQNWTHk0XQdiZ+3u?=
 =?us-ascii?Q?5eruT23LGWwseSOoQwrfa2Ex0jvfhUFoLdRd9GW0sDz89tTM8o01RrFOC6lm?=
 =?us-ascii?Q?G52NdA8B+K/FjBZsZhFPEhuEOo3r+9VkF64Z6qDkul9NQp4wkTAJN+yDy5Ft?=
 =?us-ascii?Q?KfmHIrsks0Q5Toe/3x+AZL0CGBg6b4ZB6ZcUKNXYkbbVkE7Wv4ZdWtkamfBO?=
 =?us-ascii?Q?B2t6VeYOtSRrFG5Hq4qsFVQa3TspJWawotymPBqpT3IPhYWoDAoLgl8mQT0h?=
 =?us-ascii?Q?F5Eh61bNmUiDmCcBrH8fGNQjlfSIc3LDYTCH5+JjMskzSc1Ra/P2705Y+V6p?=
 =?us-ascii?Q?DpN346p5fUIsvh7w/2RXNzYqDBCC67k2X+CJSL79m+Od1dHHhWfzJBCRBZKZ?=
 =?us-ascii?Q?0m7pW8TZLES4hH4++nz++dioHmZ+jLEzIN6mPSUW/BE/+o6+qAyqT3vsshec?=
 =?us-ascii?Q?jBoYIKFBBoEVdCUf6R8c9jleJRC5FNmkKqWYL83u88xy+l0OpPsdHnbHgqpw?=
 =?us-ascii?Q?Pi29pCxFHMqEi6fuG2lN7EV8+pcQ/06wa8uSsIJ9CfK7RX+HeMG8tCTrGXpf?=
 =?us-ascii?Q?R+H4jTPcXWLWbu0aoW4eV1VPQ+vdzIIPGZBoWFXNPHS6oI5gmY+/nQf/s41I?=
 =?us-ascii?Q?5jUJfiGCQ4Lt7W01jICrD6kvieo/cDAOwqipHdiSZ4cSD0U6YHIwze8tojHN?=
 =?us-ascii?Q?B6Im2veeLakAdQrvHEuPazfLe8xNybR+gllkl2i3uasA2JPAs/PeT/hdF+k7?=
 =?us-ascii?Q?h+BRUBy8mo0rSXY8COhMVsiGv7r9YhL/NBiBus5DgLZm8039FeCNv3fyd0m+?=
 =?us-ascii?Q?A3a61+dmsl6QOc8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BZfPqamb0Zt3yiIW/go14xheb1L16hRs2KkLfwQsbR0fSJXtYjOWNwYfG8Uc?=
 =?us-ascii?Q?oPEE9h0RFqYOf42+lZkREe7t3xRHEhiFpAKLp67e5KI6CLRQ9zC32Bedb8sp?=
 =?us-ascii?Q?RbrXPJTEzGFw6ECnwgFskt5QMAvdU3stsdrcXJ+nBNr7wfEN0XKBDtMD17Jk?=
 =?us-ascii?Q?awtyVNJODQ3CeDZKDOmDGlLGbwJyD+JAKUMlNUuo4a28CM6I4D7PHTcnHJqk?=
 =?us-ascii?Q?IDXzPUdBxe1+ILfuKFrPJnIvww0kux4FloWbB4BDtJEAUZSduoqXFMhfTasU?=
 =?us-ascii?Q?gl9mpeJpfpg060qUa+YvDWksnH8ix3Fs8BeyvxYUm2V8Q5e2jTv7TjXrs5bn?=
 =?us-ascii?Q?/wsXzselMcEDWibwgNRb3L9T9BqnUuS2Lm/3xkOnqWM6SptAXe3CavcHTQXC?=
 =?us-ascii?Q?RJVyZbFjdvM5/vRU+UwESFdnT5GK6mOrsTFnek81yMVFvhA+XOLhFHXQa9/W?=
 =?us-ascii?Q?OvBVCVvNihxH2zNoDbIGB+EHCOtvY7zlLcGrdeSawqBS4xK1BoYyA8gJ+cbZ?=
 =?us-ascii?Q?oGXl7fEApzTG/AfiTOnjapNc5VBuOMcVfvg3/z5o3C7KQbPc+a3Z5E/kbo0M?=
 =?us-ascii?Q?imZ/ODGqCALlpaJayjunq8jLwFnRO3dWP0R1gAi1F0dsr/RZEjgeJeTGrap6?=
 =?us-ascii?Q?GCsloZNW57cKeba9swk0OhCL1DWF5pF0FzN5QAdevHAPw3MUZ5d2ioNKCklh?=
 =?us-ascii?Q?qqdiRVquGSGqDOyAAhJbOF1dCoTgpkIXNorSrMUWkQ1cHqyvYv8P4BG93dW9?=
 =?us-ascii?Q?KpxAEWJtTZDFotcHyK505HNHHkHNb2FY/+srb9jsHe2s3Ib2fOR4R4vLxOeh?=
 =?us-ascii?Q?D3I4ndCeNHOx2E6QjpSpS+3ouDeisy+ejcKgoVFhAy1r2ty/sExzuyODYRqy?=
 =?us-ascii?Q?T2AZLKK/uf7q8RC7CXJK5Ops3UQrqa/H5/wxOV/wDbWCW82MnqokcERh6PN3?=
 =?us-ascii?Q?8Jmj7HcxVnDb7qkAHTq2C3Q8Vr9wT4YTI9qBDwAEC8LSfMtn0Vu/Uwsv8v0T?=
 =?us-ascii?Q?DEIjPAR7IX003DwGPiHvGkfW++OKkeOuTHbE6mtYHH4eMJRiCppS0BlxYJ0q?=
 =?us-ascii?Q?4mdmEbhmcGBvFPfYp/pMXDyzv+g86njaoMQyh0hvL0Yhnez1GJLOvHhxpLMa?=
 =?us-ascii?Q?kLxpA027o5tthErtTWbRJF64GZP72Rag9CSCBFtvIQxghqCnCnanRrZdBDPq?=
 =?us-ascii?Q?UZkfEZ9boiAIO+S0C440Pl01Sl7IF/BLD+mq2PQ2kbQHcd52czDGMX3OQ7Zd?=
 =?us-ascii?Q?oEdsbADxjLsxoxQrctG76dauOO1Hx86MsTamGQv5z6XV2WClHOCqYiR0+ahV?=
 =?us-ascii?Q?CnDoibWivcK03fNp6KGelJwW+IQIpOie5yBlMoWiBTLzccqD49HkSwkMULT3?=
 =?us-ascii?Q?2MMMzM5Amg/pzEp6NBxu+071qDNYG3E9VCxnPXfRbNuQ/RMmim73iqMVLG0h?=
 =?us-ascii?Q?sKjxtfPLP6vpyzPHspfXngSuyHmXDZScSIKPsjUg7WpLzYB9Fa/CtyWBDoEN?=
 =?us-ascii?Q?0dXQGo1Cl/7CzeUtsjJIwJRCEKMEhzu0OGb63YNvwPxQAorgF4wBhZgwhITd?=
 =?us-ascii?Q?sYYKzCLrC/BjXOfLeXc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e2393c-47ac-42aa-008e-08ddd990d073
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 11:10:15.1678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lg/BkM3cTzoOmp15wxCMyY7xQAa5HlsuGB0s1rLhPaq5sOkQaEd/KDjpfjUGgr0hrtkv1lAAJzc/S7pD5pvWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

--_000_SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, August 12, 2025 3:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con, @=
@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);

[Thomas] Does bank_count  only use for umc deferred error or include umc ce=
 de and other ras block bank error?
[Ce,Sun]Hi Thomas,thank you for your review.
Yes, here include umc ce de and other ras block bank error. If there are ma=
ny bank errors stuck earlier, we will read out all the ones stuck earlier w=
ith bank count=3D12.
                  The amdgpu_ras_poison_creation_handler function is used t=
o handle UMC deferred error. not include umc ce and other ras block bank er=
ror.
[Ce,Sun] As mentioned earlier, if a lot of umc ce is stuck and not handled =
earlier, it will be reported through amdgpu_ras_poison_creation_handler. I =
think how to handle or parse it is done by aca parser. we aim is still to r=
ead out all the bank reg info.If the include umc ce and other ras block ban=
k error gets stuck ahead.I think it should be a normal behavior to parse ou=
t all the umc ce and other ras block bank errors that were not reported ear=
lier through the creation/consumption interrupt

+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {

________________________________
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, August 12, 2025 4:33 PM
To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org <amd-=
gfx@lists.freedesktop.org>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, August 12, 2025 3:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@am=
d.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.c=
om>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info

By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++------------------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 --  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  7 ----
 3 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index f00a9e0c9c47..ad8ad08f0f33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  50  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        mutex_init(&ecc_log->lock);

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_queried_count =3D 0;
-       ecc_log->prev_de_queried_count =3D 0;
 }

 static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *con, @=
@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(struct=
 amdgpu_device *adev,
                                uint32_t poison_creation_count)
 {
        int ret =3D 0;
-       struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D 0;
+       uint32_t timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       uint64_t de_queried_count;
-       uint32_t new_detect_count, total_detect_count;
-       uint32_t need_query_count =3D poison_creation_count;
        enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CREATION;
+       uint64_t prev_de_queried_count =3D 0;
+       uint64_t bank_count =3D 0;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

-       ecc_log =3D &ras->umc_ecc_log;
-       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status_with_event(adev, &inf=
o, type);
                if (ret)
                        return ret;

-               de_queried_count =3D ecc_log->de_queried_count;
-               if (de_queried_count > ecc_log->prev_de_queried_count) {
-                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
-                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
-                       timeout =3D 0;
+               bank_count =3D amdgpu_aca_get_bank_count(adev);

[Thomas] Does bank_count  only use for umc deferred error or include umc ce=
 de and other ras block bank error?
                  The amdgpu_ras_poison_creation_handler function is used t=
o handle UMC deferred error. not include umc ce and other ras block bank er=
ror.

+               if (bank_count) {
+                       prev_de_queried_count =3D bank_count;
+                       amdgpu_aca_clear_bank_count(adev);
+                       timeout =3D MAX_UMC_POISON_POLLING_TIME_ASYNC;
                } else {
-                       new_detect_count =3D 0;
-               }
-
-               if (new_detect_count) {
-                       total_detect_count +=3D new_detect_count;
-               } else {
-                       if (!timeout && need_query_count)
-                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
-
-                       if (timeout) {
-                               if (!--timeout)
-                                       break;
-                               msleep(1);
-                       }
+                       --timeout;
+                       msleep(1);
                }
-       } while (total_detect_count < need_query_count);
+       } while (timeout);

-       if (total_detect_count)
+       if (prev_de_queried_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);

        if (amdgpu_ras_is_rma(adev) && atomic_cmpxchg(&ras->rma_in_recovery=
, 0, 1) =3D=3D 0) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index ff63020f9c6c..132b45a362c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -492,8 +492,6 @@ struct ras_ecc_err {  struct ras_ecc_log_info {
        struct mutex lock;
        struct radix_tree_root de_page_tree;
-       uint64_t        de_queried_count;
-       uint64_t        prev_de_queried_count;
 };

 struct ras_critical_region {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index e590cbdd8de9..8dbffe4d22d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,

        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
-               if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_queried_count++;
-               else
-                       dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);
-
                kfree(ecc_err);
                return ret;
        }

-       con->umc_ecc_log.de_queried_count++;
-
        memset(page_pfn, 0, sizeof(page_pfn));
        count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
                                pa_addr,
--
2.34.1


--_000_SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BASJ0PR12MB6967namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Sent: Tuesday, August 12, 2025 3:35 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; S=
un, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info<br>
<br>
By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++-----------------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 2 --&nbsp; drivers/=
gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; |&nbsp; 7 ----<br>
&nbsp;3 files changed, 13 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index f00a9e0c9c47..ad8ad08f0f33 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)<br>
&nbsp;/* typical ECC bad page rate is 1 bad page per 100MB VRAM */<br>
&nbsp;#define RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)<br>
<br>
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 300&nbsp; //ms<br>
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 50&nbsp; //ms<br>
<br>
&nbsp;#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100&nbsp; //ms<br>
<br>
@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;ecc_log-&gt;lock=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_RADIX_TREE(&amp;ecc_log-&gt=
;de_page_tree, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)=
 @@ -3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_l=
og_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ecc_log-&gt;lo=
ck);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;ecc_log-&gt;l=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *c=
on, @@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(s=
truct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t poison_creation_count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D MAX_UMC_POISON_P=
OLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgp=
u_ras_get_context(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_dete=
ct_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t need_query_count =3D poison_=
creation_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_event_type type =3D RAS=
_EVENT_TYPE_POISON_CREATION;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t prev_de_queried_count =3D 0;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bank_count =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.head.block =3D AMDGPU_RAS_B=
LOCK__UMC;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log =3D &amp;ras-&gt;umc_ecc_log;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D amdgpu_ras_query_error_status_with_event(adev, &amp=
;info, type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; de_queried_count =3D ecc_log-&gt;de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (de_queried_count &gt; ecc_log-&gt;prev_de_queried_count) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D de_queried_count - ecc_log-&gt;prev_de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev=
_de_queried_count =3D de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank_count =3D amdgpu_aca_get_bank_count(adev);<br>
<br>
[Thomas] Does bank_count&nbsp; only use for umc deferred error or include u=
mc ce de and other ras block bank error?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"background-color: rgb(255, 255, 0);">[Ce,Sun]Hi Thomas,thank=
 you for your review.</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"background-color: rgb(255, 255, 0);">Yes, here include umc c=
e de and other ras block bank error. If there are many bank errors stuck ea=
rlier, we will read out all the ones stuck earlier with bank count=3D12.</s=
pan></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; The amdgpu_ras_poison_creation_handler function=
 is used to handle UMC deferred error. not include umc ce and other ras blo=
ck bank error.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<span style=3D"background-color: rgb(255, 255, 0);">[Ce,Sun] As mentioned e=
arlier, if a lot of umc ce is stuck and not handled earlier, it will be rep=
orted through amdgpu_ras_poison_creation_handler. I think how to handle or =
parse it is done by aca parser. we
 aim is still to read out all the bank reg info.If the include umc ce and o=
ther ras block bank error gets stuck ahead.I think it should be a normal be=
havior to parse out all the umc ce and other ras block bank errors that wer=
e not reported earlier through the
 creation/consumption interrupt</span></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (bank_count) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_de_queried_=
count =3D bank_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_clear=
_bank_count(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_=
UMC_POISON_POLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (new_detect_count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_cou=
nt +=3D new_detect_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout &am=
p;&amp; need_query_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!--timeout)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (total_detect_count &lt; need=
_query_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_detect_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prev_de_queried_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; schedule_delayed_work(&amp;ras-&gt;page_retirement_dwork, 0=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_rma(adev) &amp=
;&amp; atomic_cmpxchg(&amp;ras-&gt;rma_in_recovery, 0, 1) =3D=3D 0) diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h<br>
index ff63020f9c6c..132b45a362c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -492,8 +492,6 @@ struct ras_ecc_err {&nbsp; struct ras_ecc_log_info {</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chai, Thomas &lt;YiPe=
ng.Chai@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 12, 2025 4:33 PM<br>
<b>To:</b> Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;; amd-gfx@lists.freedesk=
top.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.=
Yang@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(=
Kevin) &lt;KevinYang.Wang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank re=
g info</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[AMD Official Use Onl=
y - AMD Internal Distribution Only]<br>
<br>
-----Original Message-----<br>
From: Sun, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Sent: Tuesday, August 12, 2025 3:35 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@am=
d.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Yang(Kevin) =
&lt;KevinYang.Wang@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; S=
un, Ce(Overlord) &lt;Ce.Sun@amd.com&gt;<br>
Subject: [PATCH 3/3] drm/amdgpu: Correct the loss of aca bank reg info<br>
<br>
By polling, poll ACA bank count to ensure that valid ACA bank reg info can =
be obtained<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 46 +++++++-----------------=
-&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 2 --&nbsp; drivers/=
gpu/drm/amd/amdgpu/umc_v12_0.c&nbsp; |&nbsp; 7 ----<br>
&nbsp;3 files changed, 13 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index f00a9e0c9c47..ad8ad08f0f33 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -122,7 +122,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)<br>
&nbsp;/* typical ECC bad page rate is 1 bad page per 100MB VRAM */<br>
&nbsp;#define RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024ULL)<br>
<br>
-#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 300&nbsp; //ms<br>
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 50&nbsp; //ms<br>
<br>
&nbsp;#define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100&nbsp; //ms<br>
<br>
@@ -3317,8 +3317,6 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;ecc_log-&gt;lock=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_RADIX_TREE(&amp;ecc_log-&gt=
;de_page_tree, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log)=
 @@ -3337,8 +3335,6 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_l=
og_info *ecc_log)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;ecc_log-&gt;lo=
ck);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;ecc_log-&gt;l=
ock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;de_queried_count =3D 0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev_de_queried_count =3D=
 0;<br>
&nbsp;}<br>
<br>
&nbsp;static bool amdgpu_ras_schedule_retirement_dwork(struct amdgpu_ras *c=
on, @@ -3386,49 +3382,33 @@ static int amdgpu_ras_poison_creation_handler(s=
truct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t poison_creation_count)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_ecc_log_info *ecc_log;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_query_if info;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout =3D MAX_UMC_POISON_P=
OLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgp=
u_ras_get_context(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t new_detect_count, total_dete=
ct_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t need_query_count =3D poison_=
creation_count;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ras_event_type type =3D RAS=
_EVENT_TYPE_POISON_CREATION;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t prev_de_queried_count =3D 0;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t bank_count =3D 0;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info=
));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.head.block =3D AMDGPU_RAS_B=
LOCK__UMC;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log =3D &amp;ras-&gt;umc_ecc_log;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_count =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; ret =3D amdgpu_ras_query_error_status_with_event(adev, &amp=
;info, type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; de_queried_count =3D ecc_log-&gt;de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (de_queried_count &gt; ecc_log-&gt;prev_de_queried_count) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D de_queried_count - ecc_log-&gt;prev_de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_log-&gt;prev=
_de_queried_count =3D de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bank_count =3D amdgpu_aca_get_bank_count(adev);<br>
<br>
[Thomas] Does bank_count&nbsp; only use for umc deferred error or include u=
mc ce de and other ras block bank error?<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; The amdgpu_ras_poison_creation_handler function=
 is used to handle UMC deferred error. not include umc ce and other ras blo=
ck bank error.<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (bank_count) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; prev_de_queried_=
count =3D bank_count;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_aca_clear=
_bank_count(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_=
UMC_POISON_POLLING_TIME_ASYNC;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_detect_count=
 =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (new_detect_count) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total_detect_cou=
nt +=3D new_detect_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout &am=
p;&amp; need_query_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!--timeout)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --timeout;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (total_detect_count &lt; need=
_query_count);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (timeout);<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (total_detect_count)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (prev_de_queried_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; schedule_delayed_work(&amp;ras-&gt;page_retirement_dwork, 0=
);<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_rma(adev) &amp=
;&amp; atomic_cmpxchg(&amp;ras-&gt;rma_in_recovery, 0, 1) =3D=3D 0) diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_ras.h<br>
index ff63020f9c6c..132b45a362c2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -492,8 +492,6 @@ struct ras_ecc_err {&nbsp; struct ras_ecc_log_info {<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct radix_tree_root de_page_t=
ree;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; de_queried_count;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; prev_de_queried_count;<br>
&nbsp;};<br>
<br>
&nbsp;struct ras_critical_region {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c<br>
index e590cbdd8de9..8dbffe4d22d1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c<br>
@@ -581,17 +581,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_=
device *adev,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_umc_logs_ecc_err(=
adev, &amp;con-&gt;umc_ecc_log.de_page_tree, ecc_err);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret =3D=3D -EEXIST)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_=
log.de_queried_count++;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt=
;dev, &quot;Fail to log ecc error! ret:%d\n&quot;, ret);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(ecc_err);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;umc_ecc_log.de_queried_count+=
+;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(page_pfn, 0, sizeof(page_=
pfn));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count =3D amdgpu_umc_lookup_bad_=
pages_in_a_row(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pa_addr,<br>
--<br>
2.34.1<br>
<br>
</span></font></div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB69673CDFDAA28E6DEA6712D29D2BASJ0PR12MB6967namp_--
