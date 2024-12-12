Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F4E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 02:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B3A210E1FF;
	Thu, 12 Dec 2024 02:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ix7Dm3g2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628F110E1FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 02:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBtbndzRgSEyXO+guKLbv9r5T0GSnZek73M4V7fGGwK13eOlpo86nkY6oFkc+W1pETy+FDoXQBhvk2CVbLJ05pjlerxbNSlv86QbqRuUxqhfhE1g2LznkXaHbQza0PYSQ0MFrSOls2Hqv7z2ZSXMHJLnvcVFB0KBwavYUEHm8qervSeHySurR3JAZq3PlLtuU7GDz2aqXpidv5uhKVJ5w5VO3XS1LN/Yo8HUmNHU0+2kbDgsnh/006flrNxC6uocphoX4g15Kk1BhQDrmAgMuor2FSkJrZDebr+ufpXtBc/kFg/ullru5c9J5K7dmGlUlU67wybfnk5pOR6+XCb+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXd/QHxvu6h6v6xUj6hiRcOXyZIik+PDx/03nyV0Zhc=;
 b=ZQlydM3e/WHcRSINjiySe8PeK8SENz7KDV6w1+Ew0lK3aJAXHxYnzxRuS0RrerH2DD3hq/UdqF9FDZb4WVOU5fsGmnnpb0Y2Gt1XcdsucJdOhCSZpUAjp0h8FtLp3WbHo2Mm6ukRca6zAPQRazgpS+FL7/p8QVH47xoltz9m0nEvHEOb8QMGuw4VOhYc5/ZJPJWU9lvW/s6iReLFN21PMecrbQGV370lfRXwWYXIFEmEWF2cQtgII/e3zcl1MTe4sJmsr24cEKXyLbOHxCvFd6tTL+Clffejwgc4mlYLrJEgkCzQIVtHnCxUUBaxjlP2bEXQCOdi3dzMMB0tEIaFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXd/QHxvu6h6v6xUj6hiRcOXyZIik+PDx/03nyV0Zhc=;
 b=ix7Dm3g2eYRznPZ1LxpAsk1ZOjhy042Z7eAK8ytIZFr4bwFg4fBtlqWAo9fqX/HYRVf643jUsIBlGSvVC6vx/ES2iUB3/g9Zg0QcMHkkHthKNXDKz58LQSs84ty8IIZ9yJPhUYs0RY8ksF/P5iU3+PPNeDnzif1kPRsUmZXaBCY=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 12 Dec
 2024 02:13:15 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::314f:877c:8b6f:52d6%3]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 02:13:15 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Martin, Andrew" <Andrew.Martin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Tudor, Alexandru"
 <Alexandru.Tudor@amd.com>, "Martin, Andrew" <Andrew.Martin@amd.com>, "Martin, 
 Andrew" <Andrew.Martin@amd.com>
Subject: RE: [PATCH 2/2] drm/amdkfd: Failed to check various return code
Thread-Topic: [PATCH 2/2] drm/amdkfd: Failed to check various return code
Thread-Index: AQHbSzAPK+PWfs5D9Ey24CP0sfmspLLh4Bcw
Date: Thu, 12 Dec 2024 02:13:15 +0000
Message-ID: <CY8PR12MB70991C35B8BDD733B997DF7E8C3F2@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20241210181847.2952314-1-Andrew.Martin@amd.com>
 <20241210181847.2952314-2-Andrew.Martin@amd.com>
In-Reply-To: <20241210181847.2952314-2-Andrew.Martin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a5587777-5a77-4817-8bdc-718153f18788;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-12T02:12:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|DS0PR12MB8785:EE_
x-ms-office365-filtering-correlation-id: 16483ffd-6e24-423d-f878-08dd1a5289b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?b98xJEF7sCDn0TTfPTxnZGvxAKx6ksgPVnfHy0f61TIDjn67Wqi9tR9AYGQ2?=
 =?us-ascii?Q?vyPBvs+97zZUndq1jZqNakPpn5/KYG3UDk60mRQYtDz/kr7w9ENA3WVV92b7?=
 =?us-ascii?Q?OlslFl+pjYCTkHac6x+Wk2T1OhrnSlPOyRCgEDsrxGWhT7z8c//IKZTLlMLa?=
 =?us-ascii?Q?VrKIGKiMkxa8c66BYP3UdTDrhMFXFkKhjJAVh/pIyRmv/QZtdHSvjPgaiwjQ?=
 =?us-ascii?Q?hgOG7zZYQvUr9YAAAvKCg6+vUfOavRjatVlpFqQGy8o0H6RlmJQbE+w+l5u2?=
 =?us-ascii?Q?nEurEVAJEG8G7EWoAcEWMxHC8Veeu9j7m8Fg1JBGMPPyLM3zuTy9dbMlcz89?=
 =?us-ascii?Q?e2DkuEewI6fWyazAfw7cuH9yT5EZE/TXBKMvJE8itgcmypecYPPDDN5CBriF?=
 =?us-ascii?Q?i9RTjokjRmcdgHfskOgnu70mB+morv3LCmsAW8ukCZMe0cRwrBRlIDpES068?=
 =?us-ascii?Q?Nwruvn60kv8PuXa0Gl7v1TDgpJ4hxPSc2C9H3LJWWjF04LpGND/JTaOAhC28?=
 =?us-ascii?Q?RWGAfl1Abhp2Lym8+3l3lWTwx2C4Cvlcrj8EkKsFnfBnh3h5LG7DKNlGviDo?=
 =?us-ascii?Q?bl++regidYEhsGxMcHJK0MK0fIjpz1zPFcQQ1Y6mPyM+nXUTj9MnhkWcCk8T?=
 =?us-ascii?Q?nUe0zqdx0Y206hZHXUnj4X8B1uOc+f+pn8GTmoYvxZoGUOD8MRPFwmDVdVyc?=
 =?us-ascii?Q?OXPNfkCJk4t6Aw2ABirocD5v/TYfspG74k/auCqvnGdv5bllFtjV+4wSI2P7?=
 =?us-ascii?Q?A7ch+rlhNOsxwVwg9eA7ntiLT9NkUNrpvtifYo7KwAe95ecm5d/CTwZ6qSWM?=
 =?us-ascii?Q?5gysfGFXVZQvtrufk/JPj2CBJpurCpy+SQwu8R7q7PAu9x4t/DMeZqmmQuw4?=
 =?us-ascii?Q?hLz8X5i1HxwmTn70U3oKyhCsjeBnb+f4O92CyJHppzZOTwPrvAWU3Dkurfdy?=
 =?us-ascii?Q?A0ZeGktJDs/JtF3Mwkwa0owJcvpWrw1fdElYpmiRdg8iAlVefBMf0k6KaBb7?=
 =?us-ascii?Q?6F9ZCbdvY3hsSSu2DBmZF4d9ZZfCMxTbDzDHGFuakjtyyYTuMhTyRXu9yd62?=
 =?us-ascii?Q?z/UicSz0nSLOArA4g75kfpv0j+UNwW2aYr96W5vh8v6NE5qtCsHhtyENoWUO?=
 =?us-ascii?Q?RNYHo84pqb0gav6vnWE5v7EglG7QLaZAAQZfyfolfPiHrdq79YvNfDi4+jSe?=
 =?us-ascii?Q?+Wp8pzWxuZ2BjaRM/681r61BOi+6vgkxzyri3py5uBzUepATAd6bSemY5QOT?=
 =?us-ascii?Q?EMcuNlCZLYyrr0t4QACEFx0i2u9cTrUcEftw+urNmqcjM0jevhiZrhxBsrsB?=
 =?us-ascii?Q?mtdW+DBh5aHG54RSJ/CqC2xSmhkUnh4BUAesHetxtq8tG0ZdMlOI7jctJbot?=
 =?us-ascii?Q?bClrsc4MBBG8MRBCy8NMBEDQg7YA1VEgTY4uRde/JS2js62yOA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t79TKNyk5kO6Vir/xe8Syci/hbWNQFwpbi1OAG56FNKWfpTlLdPOYMLvEhl9?=
 =?us-ascii?Q?Y0OcfXmfLrtdM+y2+AizgU4Zlr1sRfgls9UvDDPvZHOMeblVrGQ/NOcmcR2h?=
 =?us-ascii?Q?wEqn0bZ4x8ZAL3wrRbRmSzE91NIWdzQesEC7snx/3TF8xy3VyCiAmnjfIbXO?=
 =?us-ascii?Q?MJUjVp4P2IK6/cP6Fe8olsz1G7s1RLeWVJyuSCgA1Z84xmm421Nkbgk+VQoi?=
 =?us-ascii?Q?e1BojpQdBf9vKZrASVDb5FBwjpldhc9VwMUOP6mKsOScA9e16mvjXD/OafIw?=
 =?us-ascii?Q?GhR2HzahkQjmmMUcOSdaXZPCBWrRRdVO4tAy68HC72UqFcFXglHTnxfeNF++?=
 =?us-ascii?Q?qWN8nwtd0N7A61iFjk19neZTArgfXJ9BiAp6uG2g6aNd7boraA61JYdZu7Sm?=
 =?us-ascii?Q?e3QGj8YM1tEl8E1e0BMivTfsDh9HpXlWHOP0MMsDaSXjJ2Re3oUheVtTCQGS?=
 =?us-ascii?Q?/DovLq3oJIyuWfil2pv2WfKc/kXhRTDB+FYhYYeQdqf7QACb5l4F2mRbuefh?=
 =?us-ascii?Q?gpzk5mRStFLOXJZs3mTQwmNN0tR6Z0dZ4uzG6MMOUbSLSNIBaLtMNQxuzkNM?=
 =?us-ascii?Q?ejBBDGamZ6BsTiDoBxG2jR0P+UQUS6tPs4Tsv3hbHneHxFgLShJbzzS4JjZ1?=
 =?us-ascii?Q?OUGNRxUXFl8oqxQSYK8qClTWZ/YbiC3O7Nrqw14qMcb4ZuGti9Wu3bTqh8Jh?=
 =?us-ascii?Q?g3snHINILHTOq7rz+enRzHkvIGqHlYCzOCSm9niT3as8OG0EvBuMt2FY1l/I?=
 =?us-ascii?Q?M0gdJFNARAcKN8FU8T7RL7GPtOntHqspE7ezUsyRoX/5D1BpIf3IDDqRqy1g?=
 =?us-ascii?Q?VoDJREzbHUsOdXpv31xux8C//ve5jah4fy4vE3zmCgd2BVOtvcyIE9mnVuPn?=
 =?us-ascii?Q?9HTxN2WV3TgFz4LO7d8Gjrw2TE+X8E/hXA9+H1Q3hvwxeU3tptypDAH/NbIQ?=
 =?us-ascii?Q?IoLwwHhD9Ko/nhZOYFL01B7TWm+uADBG7B6ko9sAQ8vyhCIjlUBugjN7r8Ex?=
 =?us-ascii?Q?Our+I9R6IxDe5P6Dtq6Vb7nkeFYB/13uZC65TL3s/K+Yp5uts9KlVbSkn/DP?=
 =?us-ascii?Q?230m7i0YiQNnUYvIl+OdbYCaD96g8RJ23odEtl2Qg6wV+uetSZRo2fPV3n7I?=
 =?us-ascii?Q?YRtwdj94R03H8zKI+Sj+st1zjxs9pn65OctTt9xsNt5BgM3/hSpe+pyNjFOH?=
 =?us-ascii?Q?/lNzPXr9M9Dmh5MybnhsAJaeWS7Keo3dn/Nsv+sEPgbNTR/t+n+i1Lpljdjo?=
 =?us-ascii?Q?K40fUv2FhSxNUOt7owZDtyD7JkHSV1Llmb45xGM67/llEsrKi3R5A20XaS24?=
 =?us-ascii?Q?W5x0CI1QkxqQGV/K0v/RRko2itW3EqurI9Rz2lIQj+bi+RFp7qSEQ1E8hVia?=
 =?us-ascii?Q?MgReoDpu+/Eb4Jx2nMuCspAILhhbv1gtyp5JNkZpJD5NVL0gRzD8CPH8KOLz?=
 =?us-ascii?Q?R3JfT1F9uCQThHn7LaPDa3u0RDqKYQd3k3+DNAH+2+UeQGsrN31jTZOQNUyk?=
 =?us-ascii?Q?Hjw74icy4Vq5dEV7RKt4HxNs2wfBpe/bPUTpylxvIpRrIo9qRafS+UyUf1Wf?=
 =?us-ascii?Q?9RE6ODeBM5qN6MCH7dA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16483ffd-6e24-423d-f878-08dd1a5289b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 02:13:15.6073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3gR54fsXVa9Z8OtF4FMXXEB7Wrzkk985HWmisp5bPYQ2Rmq5z6mIEsfPsgta7S922lZcMnfQPi2rm2xIHuu2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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

[Public]

The comment needs to be fixed. This patch is checking if the variable is no=
t null. With that fixed.

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Andrew M=
artin
Sent: Tuesday, December 10, 2024 1:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Tudor, Alexandru <Alexandru.T=
udor@amd.com>; Martin, Andrew <Andrew.Martin@amd.com>; Martin, Andrew <Andr=
ew.Martin@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: Failed to check various return code

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 16b5daaa272f..1405e8affd48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2388,6 +2388,9 @@ static int wait_on_destroy_queue(struct device_queue_=
manager *dqm,
                                                                q->process)=
;
        int ret =3D 0;

+       if (WARN_ON(!pdd))
+               return ret;
+
        if (pdd->qpd.is_debug)
                return ret;

--
2.43.0

