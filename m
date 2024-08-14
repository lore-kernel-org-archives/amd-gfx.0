Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E03C3DA4A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 14:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8A110E4B8;
	Wed, 14 Aug 2024 14:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMgpHOed";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C9610E4B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 14:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW0BVrwMQjs/sDFYuC0aHonrb1WuSTATFIzXVHuuwuTFx8/XlvU/vWKIycTVfGEM1wWOuEoIP66+hwsdhILESOeyAwibesjzUIj/sUmCKd5PUcC8a5HtYI4H4m+ZWCWMrS7zoGJo8fiy9TF8gIGh6X7o2JMB4NN/Vof2ZBHnF5maqGnJn2hwOVz4CnYe/gkwtOUu/Z5e7ZkWzC6MRsU1iwh+eYYcvW/xl0sy2YA7Ana68unEqu54p0QbdPjzL+H0mJziCz6p6LgsItFQyitvVBt+qy9w24qqE8GdjwLEYFdjooRHpS1MY4iYZBffFByo9wov1T0yqoBvGs3Bt/wBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcqj0Nvd98DBGusRIep1BYHPOhn8VaYBmyP9Yq7zPI0=;
 b=kQnp9d0ymE4WgzBg5ck8xvQGkG4rTk+w3QvzQs8mKHuVTdt5Si0auYoTkvNroEghI5fJP7pQP+6frGFN/ukjEQlAn/3x4V0CgRUYpLbOiM0xO59p4F9+3nWfEuedgxQa5UcTqb5O2vPegIuOJALYPlonT+X/bWdQZ8YuXteD4Zwbf7OYu9WiFnsEUp1+O24wu3uTJEnvy1Xf7bvnjhRGl/mn0ZkUcquJEidUZ0NW27r4+qoBkiaEm2R/aKtOhiyrxMTgy/QMsQJZ17tvbaZV9ojKyeEEVOz/s84FJNkoXP2qjHpU935j7ZlD4dztViZ9RaXbBvgxc/BNiHF7c+BArg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcqj0Nvd98DBGusRIep1BYHPOhn8VaYBmyP9Yq7zPI0=;
 b=KMgpHOed8/u1lu67Up0mS4KMYHLSGwkpGpihWtv0wXb6U82DOaRAtZKhZpjpsjHko3uUf/wvMLXg/KfwMJ37Lpfp/3B8AUi2/HxfNY7Cp5qbTT8HynzblKZKYy7QtbgvdPTqDnnNtzrQChtUVbR0FKL2w5mgTwDnFbGjx8frP0Y=
Received: from PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 14:36:56 +0000
Received: from PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4]) by PH8PR12MB7112.namprd12.prod.outlook.com
 ([fe80::527b:a523:24c6:a1d4%5]) with mapi id 15.20.7849.013; Wed, 14 Aug 2024
 14:36:56 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for
 GFX11
Thread-Topic: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
Thread-Index: AQHa7bKo98SB/NZv3kuEgT4L11MeJrIm0ffg
Date: Wed, 14 Aug 2024 14:36:56 +0000
Message-ID: <PH8PR12MB7112428270A7AB50BEAA68848C872@PH8PR12MB7112.namprd12.prod.outlook.com>
References: <20240813185713.942012-1-mukul.joshi@amd.com>
In-Reply-To: <20240813185713.942012-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=65eadb7e-e6b7-4d7d-ad6c-679c62f9e2ce;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-14T14:31:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB7112:EE_|DM4PR12MB8451:EE_
x-ms-office365-filtering-correlation-id: c85ea2d7-0831-440a-e82d-08dcbc6e8bff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?TWqSk7uA5YhBVspwm0WEJ2pygnZUKLzPTvvfBroYYFDmFHxPAOIegiK6jW2+?=
 =?us-ascii?Q?LfTSibs/PBvVQIIZCcAgP6dZ1EULlzyjlSG031nNo8yX8KLjev4YlXkTR4f6?=
 =?us-ascii?Q?SugVvadexHTzAGTZf8PjGlAZzw0NQ1PdqtCnVtMwUwsb3NJucguMFJRH30EL?=
 =?us-ascii?Q?C7ewQ8zPiIQz4GzxrwbNneRtdBl1/9H/yz7tG40ralwaCxAhaTcvMCNFbl0a?=
 =?us-ascii?Q?kU6JxVC6PaViKX2YcRUznyqRrZ6jcDfxIPVKCrBWRSiJhZa//xQJCJRw/9sF?=
 =?us-ascii?Q?vVFYpamtlVkL0L9dFgld+sZttPQx42lkxmPWMf0v4w0Ke+xwIPLNyzP6gdU2?=
 =?us-ascii?Q?J+/APRs9Yvug/1VaDB2Vd7+sRaYNpd0cg8fzFCIS8W6K/Pr5GIwBueXdtbDf?=
 =?us-ascii?Q?HHUMcO1wxbzIynOUtRY4OAFGf1jIkOOGen+nCe1lHlBqgpZK2ixqUANrOah8?=
 =?us-ascii?Q?UJncTwpom54AzyVl2C4xSnb87bdlSMzGpT6L3QFvWG7LHjck7Wqbgu8l26DF?=
 =?us-ascii?Q?RTccYzU/Jxcg5Gnm5ky/fcfi/dF6kQg33F9n6OeYWTfBtA2TV65sTGkKEp/u?=
 =?us-ascii?Q?YzqjQBxwP7BQAgOI9F0Og+abor8/+1If00i9qvRT38kO0mbU3MAxkJsXyYPD?=
 =?us-ascii?Q?2q2gtLVWYtezqTizaZ1iep66n3kFmcDkqiM8NCHOJ9sDLf+l+Fo8CZqrykwY?=
 =?us-ascii?Q?GgzSV03nrSRXhi9bUFZ7jyJOonx+L2UXV2snaD9WeAbUIvBJhX5wt4Kw+geG?=
 =?us-ascii?Q?B1Rmqu7Ij7XWtD3WZ2TL5IYq2cnwh7HPuhGXvPYWBffi95BN3tpFegpcFnx0?=
 =?us-ascii?Q?tKVoyJtivvJ/G0Cmv3R2qNpJ6dlKv8RPpV+TQzWNOpRN/5RY0SC8xqZ8/D0u?=
 =?us-ascii?Q?LLqOg/OzqeL81LgPnQESuWIEH1rLNThy7tr0qJ2hxHvl0vjUDt34kTZuCAQL?=
 =?us-ascii?Q?olYz2VZdlpoDyS9uduh4otJXw3wcPQHVY6nNW6dww1Jd+RrBMOyiAIRhjjFa?=
 =?us-ascii?Q?RGp4raLVi7rEcZ4O/fM9Ho3xJljXyz7Qins2bwn5Tl8G3l2qwtILxqHbRhoM?=
 =?us-ascii?Q?99IQgNex4yB6gYDkQSsoGBNo6DBstGEp7uXHsjLlai4I4l2SP7k/9+E+3onG?=
 =?us-ascii?Q?z33SEsIaNBSkODqLEEnMxREnWFtNuYg2JAGrs3R4zIXv7IvfKK8psX95pLwz?=
 =?us-ascii?Q?motvI9Fk5CKvjNvV2B+1btkzcMqVc65t0vVmW8NOOsslNkwKWCrtSI7DSn+8?=
 =?us-ascii?Q?krNgXrQcDwAwR9dj28LQDJuQY5D1VHrwDJja2Em3RlAJM1tVrbN5xT1ZPXER?=
 =?us-ascii?Q?JsiYPThpgIC/kLNdnIsquIYbfK+XHAVOxtTk1Lfv0xLEyOPTiry7R8zjDlJm?=
 =?us-ascii?Q?K/dw9bFHw9h1Q8bo8Eg5gQZ6PPQpPi8C+TOrHjleDsrgotAo8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEamcNoT/OQeM3nujer2+zDMzC1+xcH3JlOwpihLW9NKT6iNLidGE5nMHfpv?=
 =?us-ascii?Q?ZVngwpbygrLURsRXLFZZ/hfmXe9SZtToJRh3kbNj6MNmbl2zLngD9VKSkKnI?=
 =?us-ascii?Q?O54Si4keOzzQDPC8Ltm4WI1uQd4735xnP8brLnDHm7tuCFbecHPrqCm2VdUr?=
 =?us-ascii?Q?Lw9/IzYvdF2E9SPIODKZz5fitMQHQFEoKIoXwOyMCQP+Y65s/6hrfPj00aI4?=
 =?us-ascii?Q?Ura4EZvPRvbF7zkAhnnmdox2SoqHFvtgBFzv1i8gx25ToLSISmRXqXzGB/Qb?=
 =?us-ascii?Q?9JaSEee2Nm0xcPTAS0u4LR4kh/mQpj0fgg1vJXml8Uubo8RYIjwBMjgbfAKO?=
 =?us-ascii?Q?2DOpr10nVboyPyN3Kc30We2AIiZ3q3SNXN2KfrXK+epUvyhFaw2ACRIwo7qJ?=
 =?us-ascii?Q?hXGR+kGEvPc0tV5xYWm3hycfxSXEKGuGRZlqIZhAve4es2l6guUa2NMZheln?=
 =?us-ascii?Q?xzTPCTc5GpO15dJs5DdC+swg0eAp1w5uAwhdKyOTOczBDkf9OmXkqUk0Cul/?=
 =?us-ascii?Q?ngaHRxrmu87X+PetmNGU6CuKvXaa6HaSlLLpIuu8tetD/bBrkRNvnHX+4heS?=
 =?us-ascii?Q?Vi6/ZrQqe/oIklm24x2ag/0f3dTmNYD9Cz5rZJsJdT0I9UP4jKY5lvwugw29?=
 =?us-ascii?Q?E4S3T5IpVCMSasJMD8NuLwwHFVAuF6UZyoI6qmrChlpfg0WaJNKOm1ZOMiNW?=
 =?us-ascii?Q?jAkY58H8la7YnJCCWQrjPffJWu7bjMxeasbcc9RAFBfxma9rGlxWusfj1VzB?=
 =?us-ascii?Q?BMG8dJxJtalC72uKmQ3AX+fAeva2SvsyZNuVjpXAp1kDx8dH+ccKAKhUMQvm?=
 =?us-ascii?Q?Q3wW9aol46x5loanHPf3QI4XmkQx2tSNxAri3dhYiCY+c/ki7gSYnFDicZ/c?=
 =?us-ascii?Q?eA7WLH3jI84MGEKsjzq79+mnk5Q1g9KzsXHZJ968s7wIiD7ya1FEOZkuk7aK?=
 =?us-ascii?Q?EdJlfgXTxOul4NiC9YqIO+2pAPqMzJVSRXnXXk5WJYHW8TEVt1iYAdZMd6wJ?=
 =?us-ascii?Q?tjb2+A/aUBNvuPzt6tTYAYWSoG9ZRbJ/Y41H9wUZqF0/AQPJaWx1+X9CuqRe?=
 =?us-ascii?Q?WJLggXe07HYank7g/xb4OYFUEAK/3+Pb+rx2t57Lu5MfxBTe+OWo4D5PqSQj?=
 =?us-ascii?Q?SSVy+r9CU1DTafSr42AqBNleE/XCdUUn87gYoO17/yEN+Up2GZAKqTWo1BLo?=
 =?us-ascii?Q?z2JWq0NY5JnZ9yagM0gstzIRjFHrwK2C3yEp2QXsEGdBDYiIULxwxpUgulDT?=
 =?us-ascii?Q?4P+A7eV37+D8TwnCUbcVUGF9eRKEhA/qBE0bFoTlf19d2+U/SJ+eFawpUqmV?=
 =?us-ascii?Q?18vI2kR5yY5hJI18i0S996vwii/PaJrM5ob7+wefy5NBVLXJjvQha+n1epCJ?=
 =?us-ascii?Q?q8zSWSmU230pbjj/s5K0CcAaqoCf+2gmWkUneyjpWdQ9D/sgVQnr7AYcPxL2?=
 =?us-ascii?Q?k5kVcNciESCbXPx8HQxClCR440Z6cALsdTbBu/rdj1U1J2V46sUAv5tw2cwW?=
 =?us-ascii?Q?cB7Yzu3ribooYdqCKBWBdLeohKl/WdpWaaVSUCl62RXnd5KbiVo/Ch1nvjGm?=
 =?us-ascii?Q?+TBoylmYpKYJyPeSceI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85ea2d7-0831-440a-e82d-08dcbc6e8bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 14:36:56.0351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nDrtE9KNiHuWFBkz/GymKhzzNj5wwqGx92GH+0KBQLVEIDkyWrIGFL0dNBE2jDRbqawlB6qxjt3ih8fzliMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

Do we need some checks for FW version for backward compatibility? Apart fro=
m that a minor typo in the commit message. "Support 'f'or GFX12"

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul Jo=
shi
Sent: Tuesday, August 13, 2024 2:57 PM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs for =
GFX11

Add implementation for MES Suspend and Resume APIs to unmap/map
all queues for GFX11. Support or GFX12 will be added when the
corresponding firmware support is in place.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 ++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index c0340ee3dec0..a5c582674db9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdgpu=
_mes *mes,
 static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
                                  struct mes_suspend_gang_input *input)
 {
-       return 0;
+       union MESAPI__SUSPEND mes_suspend_gang_pkt;
+
+       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
+
+       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
+       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
+       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
+
+       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gangs=
;
+       mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_addr=
;
+       mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_ad=
dr;
+       mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence_v=
alue;
+
+       return mes_v11_0_submit_pkt_and_poll_completion(mes,
+                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pkt)=
,
+                       offsetof(union MESAPI__SUSPEND, api_status));
 }

 static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
                                 struct mes_resume_gang_input *input)
 {
-       return 0;
+       union MESAPI__RESUME mes_resume_gang_pkt;
+
+       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
+
+       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
+       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
+       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
+
+       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
+       mes_resume_gang_pkt.gang_context_addr =3D input->gang_context_addr;
+
+       return mes_v11_0_submit_pkt_and_poll_completion(mes,
+                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt),
+                       offsetof(union MESAPI__RESUME, api_status));
 }

 static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
--
2.35.1

