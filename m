Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7664CC369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 13:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0677F10E041;
	Fri, 18 Apr 2025 13:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d1Yz5H8j";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FF6A10E041
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 13:36:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hil6KS9//xY63THt+wd/nt7XlsohW1IN8OUIzH9u00gUlXyPQXvR0QZseQ/faJK4xezMaihXBw5QGvPdfxIeMe3grjnzV3Xq3Af3b+fvjQj9xC+kNkgv6QVQWAdRQr4IB3AG4XgZIgjGD12PdQeibJMK00CVkE8hOLCEP/cvE75lKpYkxt8zZaiEDiGgLleI+KKwdgTvwGz0bOXeOXhQtCaUyBRpq3MeqelFyKsppcKgjhClfHvSzt0ohijXRf1SAH0saPNo1al4B1hG7GW4j991n6+PkhCqiqSi2ExgABv6606Ewx7pE6CZASnF1yFC1bNIEK1nKV+LRXG4hRuNZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4a4AxB7mNoiuQdqe7bDkJqZadIq1JeUUMU4Wnjn+gE=;
 b=Mz30gBjTJM+hwinnnsJ0nOs7IJZx2NNY1K/H6l8jPaV9FaFCZ0AbMnuSq5PuYE4IAe4chA+RuyoKNRxdQWe3i7CjIZklujb0Ryhy0fW3Ccdde1UXtV00HUpK/KPxNU63jjXtBut5wZlzlpDPevOJ+X8kNntfs2Vj39iXN3eegu1KvsXnj5nUJNIMl7U3tVmsKoy3m4ZKTEy50kUjBvsdDNXk0dDFtpHER0IT2xuft69O0UQUvHF1XnPjgtRQK8xzcpyUEmQGErl7w1b6P952ewTuBUAuptFIPQ+KnZB0JttXvqFZLrXulixPf4BII66kCMJ1ctUkuaNGOX0iA8rhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4a4AxB7mNoiuQdqe7bDkJqZadIq1JeUUMU4Wnjn+gE=;
 b=d1Yz5H8jISwU7VNnwyRUmCdgXuFICwlY3qnWCrKowfeyYyV501gF4xEHj5UNDu13CpquLPLeVoBzi3EbbPF04ZWIKfWYTionKFumjiD0V0boeG64bDCJ0NlLUyYfSjLO2gaNeKCaZ6VgWbyw+F5JyemnqKVGQBfCckcevIWRXGc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 13:36:38 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 13:36:38 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/7] drm/amdgpu/userq: unmap queues amdgpu_userq_mgr_fini()
Thread-Topic: [PATCH 4/7] drm/amdgpu/userq: unmap queues
 amdgpu_userq_mgr_fini()
Thread-Index: AQHbrx3fbGL1jq5sHkSj8xSpuDyL0rOpb4TQ
Date: Fri, 18 Apr 2025 13:36:38 +0000
Message-ID: <DS7PR12MB6005EAD1E1B76BC320AD2D52FBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-4-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3989e5b1-9781-45cb-b126-b3ec4990381a;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T13:36:32Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV2PR12MB5800:EE_
x-ms-office365-filtering-correlation-id: 97bd0e2d-2b34-402f-f66b-08dd7e7e0bc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eQfOUAYD/s2toeuEpxR00G96C60EjpYizs/pwcUrFgVl1L0GPK2CotjtFKaB?=
 =?us-ascii?Q?saQljny84ZTqQ/28vy2Ami3gEqJMTGN9eDMaIBsfpFiT2QCKx/caLv7Mkj5J?=
 =?us-ascii?Q?SgjqpxWUbk9qNAQwlvkPfjee9+gB+gqR6zxzP4xOrhT98ySroQpyY3//ymo5?=
 =?us-ascii?Q?Zd9q5+BcCXEWx/yCqf8vj3XxY92h0/9OhpKwLr9a6po+7zGqOYYKCDkZ9HDR?=
 =?us-ascii?Q?0vC4HbBBglS2ZD5rRe8FQqe+kXqT5OCBXXaXb2zL+e0nFp40OD+ZTPE1qIK9?=
 =?us-ascii?Q?Gyc4NhHcslE7AKyhsLvXg4zz5HR4rspFzq2aaSZ0wrdhF0cPKqmn+bHR+lr7?=
 =?us-ascii?Q?tK/XDTXvpV28bCbqBSXCvdEA6BKAAO4GjcdJ0sapEH7UBqTSCo8kdzA8aNR5?=
 =?us-ascii?Q?y12o4iKT9ShuKwdm3fU9Cc8OpSS+66WMtdQIiXFMo13eiR4piFO/su2yKvC4?=
 =?us-ascii?Q?aMhzAXx5UZkupZhT86ulNfzab5eexsTkI50ObPVJebgxIxgKxgX3WDNqbqiV?=
 =?us-ascii?Q?x50mLjV1fByzNWH391EI1c8UwQKDJ+Gx9/PlPAJga5yQ2qJV0z9cq9TPOxWs?=
 =?us-ascii?Q?Xsp9U8T3gdOYI7S1Vn+cGqxRlbIKjJVfQi65d8ImYG0sC0wOWjEJk/5BSLGS?=
 =?us-ascii?Q?A15pEfdjoxnBMhowJT9WcLTe6GW8EPEe2ssYp3Cdj7VvkSCB8YnwMvQ1jVzf?=
 =?us-ascii?Q?khbtWf7utdVSaDMW4K0PzOlB316PHxgvfsAVpqehscQKxYmqDp6rYGFkhbqG?=
 =?us-ascii?Q?9SB8fCTer299co9aIx9tCARmZfB9tre3gbvkyqO051EIYkZx0r16ip5hlOuK?=
 =?us-ascii?Q?IFkR62GWZSPSLKT0ucJzfQ5cqW3kDZ0l7BYqbdA7oi80GOwUXCZvj3GSOqKs?=
 =?us-ascii?Q?rcyaAcn4x6zKoZQOvz8i8xYsuoYg42C2+usgq5b+O/tZBb6Vm9P/Vbn2a1d7?=
 =?us-ascii?Q?GG+lR6lBR2qgmtI9RrkIi90Sjl1q4UehzQPrWAJ2mN1zi2Mljahyhj0HMXZD?=
 =?us-ascii?Q?AJiAsaRW17Hx8Tbx3RDj1B5CbFpEs/M/gBGt8i0aAf6beZV88uBv56oUCp0K?=
 =?us-ascii?Q?M0f84drtQ9OnX/H6wDi7id0KwmRX9viOHekphrg//W1BwYePVrd2GtjJ3KML?=
 =?us-ascii?Q?tz/sNO6OBbpbpVi+NvsRqRlx0iuaGQ9YmhY1oEltDsERhC2J08eLKfTgMkI5?=
 =?us-ascii?Q?VLGyAQzPT88DbSKM6op/BNFMgiZbZ9o+1EOYT5HAQkP/2OOwlbAaILfOZM3f?=
 =?us-ascii?Q?YCoDccnP00c7WyKHYDlXfn1SuNdn/BVF+kv4X4NmZCmseMx2riQ/BL4QZb2e?=
 =?us-ascii?Q?THGuUF8djmeRbHPudcYwFW4kAQWi2A9b2M3ZXAgBmZFfsBfAA+B6hMLCDP68?=
 =?us-ascii?Q?Q7r+e3XpAmEgHfp/FAT4iDXpJr9oWEi5SanVAonwfRNT6Kqx+zfNO/XVKOyj?=
 =?us-ascii?Q?zlfU3vO3qEwZOT527qKRSS4qchnqEOScZRLAqo2FzYPBbwxmBk959CEl1ctU?=
 =?us-ascii?Q?ueY/fXlLhEXgLKY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9PwrH6aOXCal91KDDvhxBvzd0kc5z9qUOwWrX+ZiksVLtYSmEn8r8bG1riqe?=
 =?us-ascii?Q?w5dNNaxLZM+cKXfEFUmzi77LvA8N0JMzdUjzd2Lzv81CxQljGthu9CyKZyFC?=
 =?us-ascii?Q?SY5FOf9iRdFqYqGvnRT65MKndArTXelQ+ivpZzFD71L4G0muZG9iU3KfdNCQ?=
 =?us-ascii?Q?5vJqmW6QCghS7XubCpU3M4VlL3zMtXvgk5PjWldLpPkrye5pyJR2om4io5vy?=
 =?us-ascii?Q?Cr7aGNkCD0GdwHTvtlZGEPs5eitPUDnZc3ldyxpKZ8huR7+uiSCeB4bcto/q?=
 =?us-ascii?Q?Npy0cz9U1eJXuaLfG79VGzuklSxMdWfwedYPBAYYHXeyW+51DQkCd7IVbGMQ?=
 =?us-ascii?Q?N16kmfQy+AQmW8yLhumh2Z+Th3WOKn8nu2xvQX5MgVrmT8kwf9HG/CgeCutJ?=
 =?us-ascii?Q?aCw5L5oWYKZXCaP/zfgjC71dYlmELXlZpOPHSR25IZtDmRSribwU42xSWb6x?=
 =?us-ascii?Q?737DghrRyRfBGmE9gTdM3ZMXvC6HBZSvPAlZHYBFUQHKUFJJXWVH6G8nICTB?=
 =?us-ascii?Q?W44BhDWq1aGvGPVp+U0lVE4oI3Sc7zY1dbZninvPGekHi6gvFg2OjECQRrt9?=
 =?us-ascii?Q?30EcGoAo2eeddEGuQ2AulowWLm+X99buZHri/hra7jSVvPHMTyhfduHrP5tp?=
 =?us-ascii?Q?d7ijwWgYJGq88OEgCrbJp7WUy2AVAXnoc67phMv0wvZdpDtfm4xAfni6ZLYY?=
 =?us-ascii?Q?g6goXV3bMxN0+bCi2oSuqJXnuYjgfATaDTk34TtjDomk3YGVpqiodya8IZcH?=
 =?us-ascii?Q?siqFGg8tUN9NQLB18JuFhYAka9QkVu38DQdaq5UG14NjDWHD+gk9thyIFCHU?=
 =?us-ascii?Q?EKLOGpwM+dDS4GJBrSqO72vbKB4pTB63+Xa0/rUyfGJ5CqkKFPAN2FpTwPp8?=
 =?us-ascii?Q?CG2voXr2mwfthO4jK/S3kkzq0PwSHy5eyH4UHAxJSjBqg381fbX3hn4IVtoF?=
 =?us-ascii?Q?a4+ppHlExzwW6Rf7HEzL4kcTGjaRTDEl9jx6gk+oeM4OHHnNH9Uf52Cr/385?=
 =?us-ascii?Q?/INlEbrTgO0Ma+Kd3aj0eRRz2wzQznUJiHoxGRpReXOojgZUeENXYqk0VJsZ?=
 =?us-ascii?Q?4QfFDpjBZvW1QFXNVwkyZeLU/3/XMQAn6ag84uTqBBXuTyuY0YojhAtIyIaU?=
 =?us-ascii?Q?zFgst2xhgHADRF5aa9YybpqfLjELkI04vQVuboymrO9mccyyddZrl0U0vZV0?=
 =?us-ascii?Q?nxnJqIeHQdLpMUdZTRQ1+LFXHzwDU2J2lIbjTuQaqOXre991alqYY3FcNB/b?=
 =?us-ascii?Q?+5nq/wDx1TMHeZ+INyqCzqLxA8ijf7N8kmezyQvMeTo27KhaxSlEGuvZsjPj?=
 =?us-ascii?Q?CxSakgi0EfGMKkir8g2fiKMthTkRk6822y/62Ne2rg9Kky4VrVxlxmWFnTHo?=
 =?us-ascii?Q?ScUEGy8QFz4sT+47YsBKRohMoDmb3xipvV6cgkB3GjsEOKVoc95BK/uaDORa?=
 =?us-ascii?Q?V86snqlKUjb3gcSJ+hYK0/MONRtILDfm824Q6Ncne+DsVc5/GjOy9xoWuII0?=
 =?us-ascii?Q?KJOTnnZXtdIur+++R2hMmYwQrG7yhWpIB+ERSrlkE8LAZXQIWYD0G1Tihzs0?=
 =?us-ascii?Q?kTbTLuxCoLU9vQZ4F3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bd0e2d-2b34-402f-f66b-08dd7e7e0bc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 13:36:38.4400 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ei8zmQmZjd3R3Cr8/6Yst6HmgnRrRfjFWxjK+c3ZPZ3sMOjLtUO96rXzL503ecFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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

Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 4/7] drm/amdgpu/userq: unmap queues
> amdgpu_userq_mgr_fini()
>
> This was missed when the map and unmap were split out of the mqd create a=
nd
> destroy functions.
>
> Fixes: 5b1163621548 ("drm/amdgpu/userq: rework front end call sequence")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 8e703dc9dfbbc..763532de5588d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -778,8 +778,10 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr
> *userq_mgr)
>       cancel_delayed_work(&userq_mgr->resume_work);
>
>       mutex_lock(&userq_mgr->userq_mutex);
> -     idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id)
> +     idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
> +             amdgpu_userqueue_unmap_helper(userq_mgr, queue);
>               amdgpu_userqueue_cleanup(userq_mgr, queue, queue_id);
> +     }
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               if (uqm =3D=3D userq_mgr) {
> --
> 2.49.0

