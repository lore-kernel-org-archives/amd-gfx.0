Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F7C3271E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jul 2024 05:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD85510E0DF;
	Mon,  8 Jul 2024 05:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kXYHjkG3";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3366510E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jul 2024 05:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ7PYDYk1axTsa5IqcH9JCUpAzRJ1WtoY/1irvRg/OXu/s2PdLhCIMHszCl/QBnLJLPvjIZBEj5+cmMtapKfjjtnQjLd5Vr6ym5xSd8TgdMTUb5nlj714pwWI27qYWak6v+LRu2/Eqa+WIG9KFdQQiS2ZxlOoRItqJrezi2gSacP8jRBxojPRrav27hcgNO3iyhJrDUHmjSL2YkpcgasqHHFYOEkEbaMBfCJgOqDSib89DuDKM2zeYjlB4RdpMGpIpzWfm6wh9xpAXCL2m7FxV7m4CMSx9SO0rBnetla8RX4nrpu+FUMXKGMrYUQIHo5ETCY8iORQ0Ax1IN3YnOdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IDA0s/3zlGoUmJcELTriPdh7hw57ZVgukAdFm6LW7c=;
 b=UNwa8DD1SL19CqRMwtF+hJKULznjDcvROHzILWL1/WkV7FrHQlP6pDMAIFk4bEy6AInzrMFzwaEVXxbrO6kz1EoCsajFEep+7+uH/jhseQhBigdvDurmD8qpB79kA57hs/KZEsR9Y387rs4DzSQXNkTyswtEr9nKBAlo2W1P8WNmcWske0ZOjWqtKqEE2eJDDpt6QGnA6Ps+lZ7oDmDtmUdpW/yuZL+JDCcpRpLafTFnC++WI1EOxu2ZqLcjkLmCFhAJikBl2RHoAN5BQcqnvftXZYI2QKtTQMgTzP6SOHlVRukr9L61sskarq+bDF0qRdBJF21lnY/DigsKQHVGiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IDA0s/3zlGoUmJcELTriPdh7hw57ZVgukAdFm6LW7c=;
 b=kXYHjkG3OPXSpkGKy5VeIisOw2N5zABc6SBLW4o7EMbOj+qP0vGf0gLeKGpmpLSq3QwDd0kQDU09LQtO81repRm2R4ruuJV2WhWI4AuxPYZAXUuMJ+bWLq5YRtWdDTF863MdG0egyeoJJaUW+NecnENTRow8aG3FlZhiryQZsrU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 05:45:27 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 05:45:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Topic: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id
 support
Thread-Index: AQHa0OZsKihIIURhe0ureocBUOMHN7HsR0WAgAAKe5A=
Date: Mon, 8 Jul 2024 05:45:27 +0000
Message-ID: <PH7PR12MB5997C31B0AA60C30E8D8E53E82DA2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240708032439.2944714-1-kevinyang.wang@amd.com>
 <20240708032439.2944714-3-kevinyang.wang@amd.com>
 <BN9PR12MB525799F3C0D3342937C3F11AFCDA2@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525799F3C0D3342937C3F11AFCDA2@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7e95d093-f3ee-4575-b231-0cc6dd436361;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-08T05:04:33Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA0PR12MB4350:EE_
x-ms-office365-filtering-correlation-id: aefdd280-86c6-4980-969c-08dc9f112b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZC9VT22m+R3J2E90fZQKGoUn9Jl10fcPdaD0QdV+AKCpoYR8T2iAYgN8DIzZ?=
 =?us-ascii?Q?t2m98LNLw/GB83hTjoIGjb21rD6jU3xl0FzNNGRH8Wt42XnyfL8Ho+11QPO6?=
 =?us-ascii?Q?EnyRNggKgMgqg6mUM1l63JB4o4JTHqFRnY8AJEOnL/hX2b+Rke0JImS/iEQq?=
 =?us-ascii?Q?fdO8zPOkSj38KfQrC7KglQHnY1KZh7nqjhrf1fFDGzQYvjHlrnhRiRm79+yE?=
 =?us-ascii?Q?f0nHdAz6jXFMoCs/v72+sKHZdgsriCurcTuYMyldIHCCOOE2vvNGD824tWwf?=
 =?us-ascii?Q?7JbiyemKP2JNUzGknOhygLmWaH22D/PYELaJfxe181YNQ+k2iHTgi+xGqcqx?=
 =?us-ascii?Q?dKvr/rNdHuyTkoo9HIxe8hM6OyAYMSkFlw3ofZGk86Q45gfkIvGvk66cEHXb?=
 =?us-ascii?Q?QsVF0ZzrvaTHFRqS1QQzIs1PlGdPY372iEZ6Wg2KG9msSKwZrVJ4DAggJGyX?=
 =?us-ascii?Q?4OmAWGmlfInok65nI3oV8bsWleuueKeuaxFSccWEkEzP8PAWmEb5k/AJOL08?=
 =?us-ascii?Q?qJ/BE0dQ4YrGRj8/qTaoBBZHGQUMSs2Nc7L4xgUOqs8LvQ42fwEA6YOClMrk?=
 =?us-ascii?Q?/CQwNBhL0ntPX6QW7d9/Kxg61IeZh4kawXLXZGRViBw5yTo8SIejcIwJQYTp?=
 =?us-ascii?Q?1RvFOOR1Mil3FptOTpguYKdNISQNE62iquHYHRcQk5tfl/kShUiRtGndN8TO?=
 =?us-ascii?Q?3tL2ivFGwk+tTCmSkYU2T7yUiq/jVlIULEfCiJcQIdFIyl1f6AVZ4keyElD9?=
 =?us-ascii?Q?eVqGDXpgvxy1kEe9utzJt6tbaMEH11ODjgt+z88ziDL8sKt0B5ToGOQyyO/z?=
 =?us-ascii?Q?pFSqA2881GmPBNH6ufakuYjsDYybnOFs9EPAxBSqhQKBGu4FOg8c9Tz7XXLo?=
 =?us-ascii?Q?v75oiAmstpVlVDlpyHY5llmocJ/s1sKQFb6X7sjzUV4YeZKrsyWWUXaLTOAd?=
 =?us-ascii?Q?0cS9HBt4jGMPtbjLHfl3AHJgRfmqza6lu5A+GoapivbMNcNBQhWzE2FD2g7g?=
 =?us-ascii?Q?2lfrlnWRoCO94QpG9CFWZDBbovw+0dWQ7dJiLnJtlO5R4vRlY0f9rESYnxuv?=
 =?us-ascii?Q?gem+Wd0/4nqp1cKHvHBDrzr4Fk6wHj/vgVtPF2qf395zsg7gKGmbb9CZ3NWy?=
 =?us-ascii?Q?jSQwj1jF4XKQmoQp3Klq6PVn9t7+pDm8VHXHP+iLuOIFqmFCtsrFCW/M2ME5?=
 =?us-ascii?Q?vmJTmIZDCATwDYYWIUyWmpx5bK5Wt1kkt/QvhHff3evs9JTvbAK4aT81JSum?=
 =?us-ascii?Q?TTowx4IJ1yyctdxU3tXZ7y1TyFAHZAhHLs0K0VbTFpISbmNAzMp9c0OBy0I8?=
 =?us-ascii?Q?JSEgMXsOwqzNwnDXV1YNvSzBq2KiisFzk+2uMA28UdB5H5sKxUE8X6oLSu0M?=
 =?us-ascii?Q?C2+7m4BTgYGoZin4Te+nCtkeW5AL9DhSXzgnGOtWqzbjHtJsKw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jdjyhqNIqGeJOnZ7082UJfvm6YEF4mAte2GdDkPZJUk77fm3jcCIqYbvqDvi?=
 =?us-ascii?Q?U1oqrLxXAQ+ZjCXqZcCQMjkF7I92X4l2qFkkvbYV/ecFHiZtJ07ZqngtF49D?=
 =?us-ascii?Q?RHjN5wLOLKz72QFmFpjAZBRrqiXZNURXCpt4+CUiCzPHJqVrTzW88Q7tE65V?=
 =?us-ascii?Q?isgyZMsxm7QP1GaEcCH5lE9pW6maGbgqG4mWhC3A/cEHLj55GPEVWInI4PXl?=
 =?us-ascii?Q?/QZgjwL8+ortZnXNxvjnVgJQhdTfv9MC6boNhQXBDCpTY11KKO9tGHbVlPJH?=
 =?us-ascii?Q?1VcPKBO/Zr3P6S+Vh6L4TRi3LfnsquPYUcucs8zw/of7r+x44QP38oZREU2F?=
 =?us-ascii?Q?zyc13k9wNPL9ldUx7X069TFy9JaiuyfE/WVoTjQC3ayhdqOA0yB7IVe6uSzC?=
 =?us-ascii?Q?Z+inQrXNvOld62oX2coHztKT/VxK4mM/f/yWnSE95ZKfWznGzJuGWRWhE0I8?=
 =?us-ascii?Q?8cBphXXMbq/jP02MA1HjBMj/dnxl7UU0CV3aYkS5chXrtlFEJLiei+vw3jrp?=
 =?us-ascii?Q?Wv3qCJyoYXvThkGRYiej64KchLbxjep5A3C4OKV3j1a5zmfocLt95z2gTmfq?=
 =?us-ascii?Q?NIAgGVIKs52AvMF7Kh+z425AqVuhe/jQQs7YoK9bNHqD5KRjjk3moHc3cX0n?=
 =?us-ascii?Q?xJAiOqCpNiobdtrTubyeo1c15f3OPO0C6N4Vb2uyOtEfU/c76LOd1inFlKm+?=
 =?us-ascii?Q?7ByS8urhCS5WyghVriEDKx5SkdRpyK4aq7yYWWHJU/HjNvlfitzHk1cGhs6Y?=
 =?us-ascii?Q?yw26a7/oppNOPJx443yaC4DZ+LuaHsPCdCmH2FGlJuqw74y3wHuj6IAigjTO?=
 =?us-ascii?Q?Zno235v/ERTbGLUEHUvm5YuVOgn2C292p4CXBwBRjBnq5iMb9Gm5dDjIw9Pg?=
 =?us-ascii?Q?D5/qv75SIRWYRKEoGDa6ePocg40blz2Kc8fRCEOLhvixP1Vy/TKPAgbzt3BG?=
 =?us-ascii?Q?ZSKRLot+15RO98CSYdUl2mkUtcmrkLYVhaUQwOJh/xw1kHeUuP184hE1+r1Y?=
 =?us-ascii?Q?sF/7fd2isb/DDLfNa+SiEbDnjTSUVW+dGDX/rsLm0bcVaNMficroQyMAakqn?=
 =?us-ascii?Q?kT1n/KM9cZ28xbO5sd5IWegUkkYzEdwbjwvlVjn/CzezSeIrvtxlyPCXnkkB?=
 =?us-ascii?Q?3Ela8jrMiX/02OJYan+kfXQp6XrpaefusW0mmAtDfXHqh7LMBodWUQMskFP2?=
 =?us-ascii?Q?0hq/9JDiePkVckzvt5X2pFEMVutrYLJtQB2wwsVrOED5zOowRcazPArgDbRZ?=
 =?us-ascii?Q?2qnxafbppmktp+Ta/KRxJlPO+YH01KjtHn1sdQj5G7AL4jmLVc/jr4xJIhdd?=
 =?us-ascii?Q?TtyFJhru6PcXC+T5mcicOKm/9ypO7jsubqUuV77LnWV9QPhaJAAxFQJQqLPt?=
 =?us-ascii?Q?3GbyoyXNqlneW2i88sDgBPmlDs7LQPi8yYG3yUKOkEufLrjQIX+fhrDQgw9l?=
 =?us-ascii?Q?HS8RnugCm17tMBdJo1af4aKtHkNCQcQMS9KpOLPxc14OXmn2jB30tZLBk3ji?=
 =?us-ascii?Q?3P9LhaolUhh632Q5Zhl2UWsBjA7t1Yn/JcuSSLnl2s+E4qz+AO2cgYqNym/p?=
 =?us-ascii?Q?DFgGFW/eAgEHRdyJ5y8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefdd280-86c6-4980-969c-08dc9f112b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 05:45:27.2477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6G+gDaKtY7IKn5AJj2tOMI577dLSx3DjjiKClCw1FUKeZ4DMWXDFl/3/64np27HB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350
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

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, July 8, 2024 1:06 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id=
 support

[AMD Official Use Only - AMD Internal Distribution Only]

amdgpu_ras_get_fatal_error_event(struct amdgpu_device
        if (amdgpu_ras_intr_triggered())
                return RAS_EVENT_TYPE_FATAL;
        else
-               return RAS_EVENT_TYPE_INVALID;
+               return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }

Keep in mind that this is temp solution to treat poison as fatal. Moving fo=
rward, we will need to check poison handling option to determine return poi=
son consumption or invalid event here.
[Kevin]:
Yes, agree, this is a temp solution and will be refine later.

Best Regards,
Kevin

The series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, July 8, 2024 11:25
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH v4 3/4] drm/amdgpu: add ras POSION_CONSUMPTION event id sup=
port

add amdgpu ras POSION_CONSUMPTION event id support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c         | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h         |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 15 ++++++++++++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c7e68c5e90cd..ca09316fbb6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2076,10 +2076,17 @@ static void amdgpu_ras_interrupt_poison_consumption=
_handler(struct ras_manager *
        struct amdgpu_ras_block_object *block_obj =3D
                amdgpu_ras_get_ras_block(adev, obj->head.block, 0);
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
+       u64 event_id;
+       int ret;

        if (!block_obj || !con)
                return;

+       ret =3D amdgpu_ras_mark_ras_event(adev, type);
+       if (ret)
+               return;
+
        /* both query_poison_status and handle_poison_consumption are optio=
nal,
         * but at least one of them should be implemented if we need poison
         * consumption handler
@@ -2104,8 +2111,10 @@ static void amdgpu_ras_interrupt_poison_consumption_=
handler(struct ras_manager *
         * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
         */
        if (poison_stat && !con->is_rma) {
-               dev_info(adev->dev, "GPU reset for %s RAS poison consumptio=
n is issued!\n",
-                               block_obj->ras_comm.name);
+               event_id =3D amdgpu_ras_acquire_event_id(adev, type);
+               RAS_EVENT_LOG(adev, event_id,
+                             "GPU reset for %s RAS poison consumption is i=
ssued!\n",
+                             block_obj->ras_comm.name);
                amdgpu_ras_reset_gpu(adev);
        }

@@ -2498,7 +2507,7 @@ static enum ras_event_type amdgpu_ras_get_fatal_error=
_event(struct amdgpu_device
        if (amdgpu_ras_intr_triggered())
                return RAS_EVENT_TYPE_FATAL;
        else
-               return RAS_EVENT_TYPE_INVALID;
+               return RAS_EVENT_TYPE_POISON_CONSUMPTION;
 }

 static void amdgpu_ras_do_recovery(struct work_struct *work) @@ -3985,6 +3=
994,7 @@ u64 amdgpu_ras_acquire_event_id(struct amdgpu_device *adev, enum r=
as_event_type
        switch (type) {
        case RAS_EVENT_TYPE_FATAL:
        case RAS_EVENT_TYPE_POISON_CREATION:
+       case RAS_EVENT_TYPE_POISON_CONSUMPTION:
                event_mgr =3D __get_ras_event_mgr(adev);
                if (!event_mgr)
                        return RAS_EVENT_INVALID_ID; diff --git a/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 69eb5fd4640f..49ec8edcbe39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -436,6 +436,7 @@ enum ras_event_type {
        RAS_EVENT_TYPE_INVALID =3D 0,
        RAS_EVENT_TYPE_FATAL,
        RAS_EVENT_TYPE_POISON_CREATION,
+       RAS_EVENT_TYPE_POISON_CONSUMPTION,
        RAS_EVENT_TYPE_COUNT,
 };

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 816800555f7f..8a10a0e42846 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -27,6 +27,7 @@
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
+#include "amdgpu_ras.h"

 /*
  * GFX9 SQ Interrupts
@@ -144,9 +145,11 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,
                                uint16_t pasid, uint16_t client_id)  {
        enum amdgpu_ras_block block =3D 0;
-       int old_poison;
        uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
+       enum ras_event_type type =3D RAS_EVENT_TYPE_POISON_CONSUMPTION;
+       u64 event_id;
+       int old_poison, ret;

        if (!p)
                return;
@@ -191,10 +194,16 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
                return;
        }

+       ret =3D amdgpu_ras_mark_ras_event(dev->adev, type);
+       if (ret)
+               return;
+
        kfd_signal_poison_consumed_event(dev, pasid);

-       dev_warn(dev->adev->dev,
-                "poison is consumed by client %d, kick off gpu reset flow\=
n", client_id);
+       event_id =3D amdgpu_ras_acquire_event_id(dev->adev, type);
+
+       RAS_EVENT_LOG(dev->adev, event_id,
+                     "poison is consumed by client %d, kick off gpu
+reset flow\n", client_id);

        amdgpu_amdkfd_ras_pasid_poison_consumption_handler(dev->adev,
                block, pasid, NULL, NULL, reset);
--
2.34.1


