Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA60DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 14:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8EE10E32A;
	Mon, 21 Feb 2022 14:21:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC19E10E32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 14:21:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Idlx47HhRUBSvzXXBlATr9EMQav8GsAYUyTJvUnok3ytS7oLOUk3649di/+ppYixOvE4Ewwx5SX4Y0zurTVZXl5lOsYxHSw+nRuIo9T7k7/bARY1Z8TjcD5nkIH0DOi+drzfFnoeVJhsw2QJ0yJvNiZdPbykHj56P3sUd4GQvZNIqqAaRxXUlXqREObUsnfQGu9JY1kE0pqftcoJ02iWiMsFazic1/ijCSldcGUfMjzQA562+Y1U7kWi7foWxEg0ZZy8phVZBUb3LeywGzss18oeqYWYPUnvpzNWx5eAqY24e7N+Vpxk9O1hiUiHkbner694CFb480Uz2QDV8Sy3Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lYB4dINgW6gXk2HqjumrzYWdWh6p67jNnq5kLchFm4=;
 b=WCTR1A04AnhHGBqLITg0asyL6yTM4/vkwBVThRNjstiUV1M1m5bhj8Y/560e92tCChxkOx+OOycOca1MBiP8utYmTa2pDU6BDh8U6dwbXq52GTdQls1pJO80NX6HUdJ+1BtM0sUmeQWSjQYW+90/OCJmet52gtTCBDoTgcAG3ZGUdWKrOz+LdVZBYsijd3QeLrOiZWDQdIp5cFN8edUXsKjhI45/bZnRsr5fb/9ExwVH28fm/COm0NDFLtPNHUmDLEx6yz6zlF/Q87U99ysfEHGxccNS8UWIbvG0zfOLGyaS4xwKZdQgLphAN6MbPGUKl1aDXblwrYQFZoI+XIEudw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lYB4dINgW6gXk2HqjumrzYWdWh6p67jNnq5kLchFm4=;
 b=iW2d2AGU8Si8HGwwh9ZRlQKaTXdEeQ8RypXycTPz01/uDSPDSnWnFiM90BKZlYraGZVuanR4LOjnouPxGUECxAplVRSnYWD4u+sANckmoal5jGme8LgJJMEwhRAs3bs8heNXpHaWr3WhJOepH/YmkRgYsBs+IEVPYSrpPaWQoVg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CH2PR12MB4023.namprd12.prod.outlook.com (2603:10b6:610:14::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Mon, 21 Feb 2022 14:21:15 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 14:21:15 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Thread-Topic: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Thread-Index: AQHYJwvz3gcrydok+UmyB7co1y9Ol6yeDlIA
Date: Mon, 21 Feb 2022 14:21:15 +0000
Message-ID: <DM5PR12MB24698F8D08EE502546F6B390F13A9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220221101451.809067-1-yifan1.zhang@amd.com>
In-Reply-To: <20220221101451.809067-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01780ede-07b5-455a-e13a-08d9f5456b54
x-ms-traffictypediagnostic: CH2PR12MB4023:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4023AF3759AC9D8AF6B7AC99F13A9@CH2PR12MB4023.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFYN0cuzByCZ9/lG/iRYc4MeQC2cm1PMDutzO8uWQLvNArhfoRtKQ/4b8/BYfMthdRwpwQ3s/gEU7LLmF+TTAK3l9eq57rBnzFjTXePjQw0KlkE3UXCmGl47rhJ/6vw0BIvY3++Mka04PpN21oc7ObepsI20pq1kaQlRyVROYVPtIHQ3/7s/lPlLxri/d+r3hUNM2qShSzXIpAPtrKa1Kc+FzAYV9CicWNfFbi7ddZuR0w3z5sP3xmX/As6k7YsEHz1A7gf0hA0E2aa5c+hUO3BoZArHSMJ67SkwI22I6z97u+g8sKbylIal+deOYu/eofmiFu057JFOT791THzqy7eQMqOrTDsUlgHklY7xcS13EFEeAC6d/72GJG08bv+9ZOeCwJPh0AeMbsOWg02D0wR+Eb+1MUywug+WHe4BEQrWqEsR8m+qeQw4wg6VXaAt6xScXpY5UL4oE2Yyoe02FPAYUcFe3v4nPXGAW/VEGv2P9fOirAXOWjqxlI8pgZq+c2EG/6dGH6jnQ39+W+vYKduf/FkQwHqOI/bs20qvO+z5gNYogGxGX4qg1RT9xbvqs+h2OT/dgy7dYPUt6Jkel1jbuEMMSTygSCdHoX7EY0qxuzGnUS4jj83S9icCEi2OoBNhTtNoQjL3iAE8aixgCQ5flU5Ww850t5oe7i1RmZD/teYBGUnBC//NvGkf/k2HvLTmWN2E1p/ZqqaHLdPsgm53gvWfE3HJ8x+juYkl0yrVukPlUpc04b/bfHpmNkmy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(8676002)(186003)(8936002)(26005)(52536014)(66446008)(4326008)(5660300002)(76116006)(83380400001)(66476007)(64756008)(66556008)(66946007)(316002)(122000001)(86362001)(6506007)(9686003)(508600001)(55016003)(38070700005)(7696005)(33656002)(71200400001)(2906002)(38100700002)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lu2c+/uWWa3Ofmm7KyLKl9m8u6o16ip3aIDaPahkYBt6xZHDjjU7C3FPyg0w?=
 =?us-ascii?Q?9oN9PuhhGMUI+7Nkc4D/Hufqm2PZe1qYWlyrGGLK1TRXi4rl/LSmVKo/5EEe?=
 =?us-ascii?Q?19BsSnonoTPnmqctcbkTNNpzPQIhQe0MVp949XiRLSUVt8E0Bftl1twFxt6y?=
 =?us-ascii?Q?6o1yTfBebsoiaBa9bIrBg16KCUvXTQoa0PonODAhNpU2IIgr5t1lNzCTkHbV?=
 =?us-ascii?Q?KJKAOlF22480sQbiglyCLxh2aY7Bwk+hYRbreS58Tx64NxbXVyP8J8hQo+yx?=
 =?us-ascii?Q?eMxmp6uJ6e8yP1evx1m5WsYypD0kYm0JPUf25nMQ341k0oJt+oET9eOJzIa3?=
 =?us-ascii?Q?9+PB3YorvDpcqDVQ9B9YgXLGlHdcqvQ19PDUqSiwhj09LU8DLYDojJBvH7Ur?=
 =?us-ascii?Q?a94omzyDmINQVfkuodO60QvvjTHwUGTLG/BqS0tGPW8UuMRqAWddFUvsOiHR?=
 =?us-ascii?Q?Ab/Q1JRAi1B2VrUsWUH70xKn/tHXfiH/B1e/cd2jcE/mjsDDTNhm1i9bZJB9?=
 =?us-ascii?Q?DcFq2VcQOsRZzyzF2ClwS+nTsFaBtdGjfzAhLuFi7hv4C1GWhecb+bB4WqI3?=
 =?us-ascii?Q?vj6hNzBUwW/l7Pay8ra/JQ6DwYcQF3v/fb3g5QPobYrFlpx79XRimYjWulIk?=
 =?us-ascii?Q?SCl7Jf6Kb0H9s4V15PMYBs8wJqFy43mJuMu/xVrNaw/AoJrXLAOKVyBcP2TG?=
 =?us-ascii?Q?AydSLpw8bUxAxzTvv9oemlcxX+VwCRATZZ4xBkvqe6g+sTTV6RzYm7jMv8Ew?=
 =?us-ascii?Q?PVNq6FoZFPZWsxEeCL8OmO4ULCLbud8ThMJqz6R41yByWC6p+S5bpsT1jorT?=
 =?us-ascii?Q?RTgEh3UOdyHqYqqPWhjgCY7u+wWHisPc6k2OOXx7VrqBLxxs2APuhp54/1CE?=
 =?us-ascii?Q?nexz/fP8XAkBsFFknbGZzTwH4c6xqcYlDUeObduTA1Bh+rO2x7QFhHRkps8W?=
 =?us-ascii?Q?kpbWHnWS6Zq294eNAlIeBD+7M/Nv7+wM95ZcPUvuimQ6rj/isPrWbT3DMWPt?=
 =?us-ascii?Q?LIfybr6AryLdAlbutZ1/aeDeuvnWqPJpQVDq9A4Wik334l1ejdZiJN42auml?=
 =?us-ascii?Q?YuT7jaG4H8PMZp+L1Hy7DugAJadqRrUQHc3LVR8DTAtRT7Jy3XNwjQL70y+y?=
 =?us-ascii?Q?SCQc3IFf+y9Zy8r76OzCANDlU9Rzde9BDNiE1NNvOxwuuz5Eei7kexUaknci?=
 =?us-ascii?Q?ecmOb5MbbCpW+lsiL4BD5qRwGkPn2FfI5lC5ja6LMZ9slevSsxUXmEUGwLhi?=
 =?us-ascii?Q?Z4Ctl8KvTKLpIZLifvs7oWNTZZxfT4II8URo9hHKtXFrC7E7Hl2jaZcCEMSL?=
 =?us-ascii?Q?g66+ECwU2iep3kpscMV20dYdM9ff3/CY3TltvIbSPwV68L6Np5jHoqrHnNnW?=
 =?us-ascii?Q?0pWzRF+/jwoN+r1XPnuL7SiND0uRYKcp+vkTIk/aTO39eI53ULmPv7T671B9?=
 =?us-ascii?Q?qhUY2yjmNRQu7kgo8hRh9RYlCbbWikaXY64NWZBmYXGQZUDrZVwSJ8tGkzkq?=
 =?us-ascii?Q?QHQP3LOeXJ4GpczHrOuv5N/kYdJSsrJRHNZxBMrj30VoPL/7GXBvCcGmEy+B?=
 =?us-ascii?Q?ijifrsnujFLyqpDRlei1NbfXK3mNEuLmnl/6Xs3Bbjq9v4+aWPrHnrayt9JT?=
 =?us-ascii?Q?zp522hvXeT05u5on8Vdg8Hk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01780ede-07b5-455a-e13a-08d9f5456b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 14:21:15.1440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h+XukTzqLsUtnaXpk2VlovaWUirz/3u5tfHz8yYLJzOTsaaA9/vFsXZ1xZm/syQ/mwvrvv3EmPxAREsgZFXhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4023
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
Cc: "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, February 21, 2022 6:15 PM
To: amd-gfx@lists.freedesktop.org
Cc: Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wentland, Harry <Harry.Went=
land@amd.com>
Subject: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5

From: "Tianci.Yin" <tianci.yin@amd.com>

this patch adds GTT domain support for dcn 3.1.5

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 9709368b4915..88ee1224541c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -523,6 +523,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu=
_device *adev,
 			case IP_VERSION(3, 0, 1):
 			case IP_VERSION(3, 1, 2):
 			case IP_VERSION(3, 1, 3):
+			case IP_VERSION(3, 1, 5):
 				domain |=3D AMDGPU_GEM_DOMAIN_GTT;
 				break;
 			default:
--=20
2.25.1

