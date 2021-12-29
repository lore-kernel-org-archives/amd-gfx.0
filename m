Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3ECEC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 02:44:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B7510E2DA;
	Wed, 29 Dec 2021 02:44:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D09B10E2DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 02:44:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGaA2cwYphqNBwUFKvg1C/gJWVwcaGFKb5nIHA6wrW6tniCHPp05vlCtpAiQSI/VVqMQ2sv0s54Gaghq2OBf9i5zEd10z5dEioh3ac/zUkoCpwSlXkPJnxGkKtshRn2Urtnc05p3Ac1uu8RfPFlZlBVtLLAm9TznGX+vTbNGN/t01wa5Lp0dWrQnwVgxhhibLbTeUFpU/PXSIUdS/kUfaq7PQNkhD9nGYsw6z8wo5z7cDnfeGQl/LIDwEWuYCTxeZktCU0rMjxsarKPXpa6iFmAH6Y4yGI/7/2gbwH+FIKU8kstDV/mwVMKThyfvIuC7jHKfpJiEHBIUoBe4OMLyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01IJq4AniA+TdngKJL8T83Hkn4P0yAbOjY6pU/yutdM=;
 b=Uzk9Ad2FtP3BHuMti2PHBJvGK8n0UeZxi1K5dy6Zmko7icmJ7qjRP13RAWlTOzjrfB5lCyqzMMqyChnXo4duWG3T737ubI/pnxLT25jLOyWLZU3tYebv1GpUPej7OXXJfh7HBO7V80Z63MqyJkEua8PkN1CuFYQzqqh9dAiVYLNo9bTMKiG4CsSozmuhoDIWdKQaxVEHCim0XWzUvWk8OesKrvQWz71WkQYohDc48fPW+WmTejeIxj6qvrFNhJ2zJWiSWm4lB2e3a0VDgKJmT8vz4SDNF+CgAx6ToBItWuvbeKu3PWywrdC8oMOMvnRphTBIp3OeBcW4mrYIgur6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01IJq4AniA+TdngKJL8T83Hkn4P0yAbOjY6pU/yutdM=;
 b=p/A3xOkvz9xXUqcp8lXd3pTqVzKAVIsPg/BpwsUyYeW7Nezu3UVkBDQu0ZgopLTxQpZgCEphsEq1QLZvM9TRAwiGeuOXX7NU41PIV9AXLfulbYGcITNW1UkLEfJrkSNTw0hY94uaZuGGKUs3IE0FTYojKjNPt7HePWqr6B/lftA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Wed, 29 Dec
 2021 02:44:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%5]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 02:44:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: enable sdma ecc interrupt event can be
 handled by event_interrupt_wq_v9
Thread-Topic: [PATCH] drm/amdkfd: enable sdma ecc interrupt event can be
 handled by event_interrupt_wq_v9
Thread-Index: AQHX/F1Tv5FLRcNgDE2Nrgsl6zXR76xIwz0g
Date: Wed, 29 Dec 2021 02:44:42 +0000
Message-ID: <BN9PR12MB5257C7C97C1B225E520B536CFC449@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211229023909.17214-1-YiPeng.Chai@amd.com>
In-Reply-To: <20211229023909.17214-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=d7a867a3-de95-491b-a22a-6fb3a96375a6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-29T02:44:22Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1141408-929e-40e3-eb0d-08d9ca752ae2
x-ms-traffictypediagnostic: BN9PR12MB5353:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5353B30A65679C9C847582AAFC449@BN9PR12MB5353.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:153;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQbO7BiAEK67JAfMTkS++4dp6olo9Ma1ilhalu89qW5gWdowD7gfwVnL7OmQ3AC829rnZypF19NH1n+/Yi9RQ0uSDE7EBPCywf7q8UpsKtAw5HuFfLrKEMyYUR7GGHJG6YRMktJ13xwizseVYdVI5e0EsNDhQ1I3o4u8oFXae2xGG3jJH4ZpnWb2DusAg65HGcHnz0ncf39CYdV//qUzQ7vPlsr0vpeVOvtmPvAgZFGKvypie03lbug3zI4LhUrhOli+RckATvSV5v5xlSIcj/77WnfqpUuSMWXwm8Km8gvS33XQA4VJA0H6dr5viS+s51XSB3f4geNv8cSBpyA2u4J5/571VcZE5lvSMCKrsE9WKUE72sRmxBWE/P65zmNdJpJknv9CKiQBukr9ww0psRgSIlqUh+m1hczQs0SF1AjcW0DRL0smKDgovTg9ta7/C/QFqd+Hksc9W+Wdyg+KNc6D1lHbXJm1QMz4XUquvz1REa/fyRrHGcFaU4c/FNcAu29Z07WtI6cFKAZtr1elmfaDmN/IDrXch/rmTl0gR/JSyPVpcLzJiHZByAV9J3oWCSgIDNuwlj1+by3qchOIMOzptoAouJVxXQNr1lbZy+FOWkFLk4FNohY34fgCt3FxK+TLN1rsCB42mZgRoBn0i1wS7n2VdDK4CSTWgicdrkyMLOllGrZZoikUKAl2RvQ4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(86362001)(52536014)(186003)(110136005)(122000001)(38100700002)(26005)(8936002)(33656002)(66446008)(83380400001)(508600001)(5660300002)(7696005)(71200400001)(8676002)(53546011)(6506007)(316002)(66946007)(66476007)(66556008)(64756008)(76116006)(9686003)(2906002)(54906003)(4326008)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yZ9A07MwZVoODGtwbPdVwobjmiimGynj/lNov3F7ZYiISjpBzkLIjV62Puqb?=
 =?us-ascii?Q?citGVeFes6EsGc0RX9KmWpOi1hJAzK1+nfB3WDd9hueFQtMWLqnpE78gljkZ?=
 =?us-ascii?Q?R0T8jTmHZ4vQGvPA5YO07k19FhV6iKIikIRiYpkkdY0oEnHYONLibsUwQdoZ?=
 =?us-ascii?Q?izEVHdS4ix4hogxOzYvx9Ih4N6WX8wawhpGpL19qzYdN2cgEk8nIJSA6UWy6?=
 =?us-ascii?Q?oqIsTpxVb6iT4JsQpoB1xgrvfBmuELi24HX8YHfFDvF2VxSDBugL96mALFi3?=
 =?us-ascii?Q?+GA+wL3Uf94Qbll9g0IZUbZxwgwexzI0dEnkglZXvloGR7TrIW0TKc+vF3dc?=
 =?us-ascii?Q?0xHcsiKJdAKtOc+I1IYZX9MPQgGlBIkF+79J1O059r4KiY7/pM+RMOQV1LUW?=
 =?us-ascii?Q?KwfNyVkxJvmptCHXTwmM5Gvmu3Ti0yNwQgWY7bqcS6cgbFW8hrB60Y10m9gS?=
 =?us-ascii?Q?+AyMeN/OUL9Ev8RL1aK2QpUejYRLD4qEtreyU/pgo0WbMi2PRmwtY+TYuRgf?=
 =?us-ascii?Q?y95tamEZ4c8TJRHSP5r27eG1HMd3F0OBnEH0egnJNI0fjxR+nyxyXOWBsmUa?=
 =?us-ascii?Q?dw7xoj7z7YvM5f7qPk9C/wMGcpP/TwNXntrE0DS+1bvQJ04Nl2cZtqri+zR5?=
 =?us-ascii?Q?1C8572dUQXqzFWvbj8+oBazkTqI9BdFXQVUFN9BMXIrApvJtQ1esMKegDCK8?=
 =?us-ascii?Q?ce+2RAiH0FP7wEQMexH4Udsad+6AlurfqAancMYjLdcf+3N3Lqlpylk7Pov+?=
 =?us-ascii?Q?AC3zLi+e4xC9jdbXE+JXr9wnT1tuxGdaLg4WxDMZMwbz4CggMYp1TrgQIuCl?=
 =?us-ascii?Q?PsqY9yyU23fbooKnKRFI5bm9736pm6S7PVezfUxEQWHP/HTPhWXE2tIYpTBK?=
 =?us-ascii?Q?SYupE/M8lvDEQLfZHmXNNnOlJ3lsIdiOzNDXJI/bM2Eh/FtBwkDvOOgK3+iX?=
 =?us-ascii?Q?hV7kj9h8zT4zbV9WUu1k/1sJQvpkkXAsPJMTcTwXjZ4okgM+d4RN2NxFcF3O?=
 =?us-ascii?Q?2XBnytbZjOlKsspFsXbAJmSEYIHuRegicZZnEpBQYb1ejbrIWpWt8DexVWDd?=
 =?us-ascii?Q?RN8L/8zWUGzoCee4NPhAcI+M5rGUrM2TNUhnoaZYguGuC9OrKU6Yxnpv3x1K?=
 =?us-ascii?Q?zYTv0C4Z3Pq+2SCbMCK2r/ebNnFasO4CMROkLosuW8Gf0gv2ItePfkhrXRVe?=
 =?us-ascii?Q?PjOQH5tpg1u6zEh1nt18bzV3ANIaomPXokkRR6zm9LKayJVpcnp4i7Kv6R9w?=
 =?us-ascii?Q?KkFBEEbfYdgFIFkMoh1Iz2CBbWosSUNUy6A6ERyv/UfVzG7E26SkbF+su7No?=
 =?us-ascii?Q?3Gd26gGsWaKjpLlu/m7/iSIyAGCyybO+zNwDdL6aa/W/cyDEfe0K95kbaxr+?=
 =?us-ascii?Q?rJI/gVhWOoJXG9WzUWefofNtSWyd5RjrTHKbLrhOnRYAF0MlZq09st4ehZ/h?=
 =?us-ascii?Q?/xI6qKWkPk7zsmlY57+32FGUP5QyIYrFFWl8vueJJ2eHgNRVanwWFxserzzI?=
 =?us-ascii?Q?o5no1NNcm+YhyhI150CSmv47/kSAaTVH7xiuDtan0lPcl1Cwm7fWjuYNMwhR?=
 =?us-ascii?Q?C4H6N/FzbaK9zwsP1EGlyQWpkIDintqbBZyisLHvshSBR15TDFDLkWao5CpJ?=
 =?us-ascii?Q?+aX0Nm7MUzP0nsROW1vkTJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1141408-929e-40e3-eb0d-08d9ca752ae2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 02:44:42.7416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hl+2Oq41AAD1HIESH9l4bDhnLZFhKIlu3u5kIuWEA59yTqEdDp3asRwO4rBx6heiKHr4Lw9SOnXhQ+m4SuE16w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Wednesday, December 29, 2021 10:39
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdkfd: enable sdma ecc interrupt event can be handled=
 by event_interrupt_wq_v9

Enable sdma ecc interrupt event can be handled by event_interrupt_wq_v9.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index d15fe087ba55..1d92e1b7f8d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -220,6 +220,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
         */
        return source_id =3D=3D SOC15_INTSRC_CP_END_OF_PIPE ||
                source_id =3D=3D SOC15_INTSRC_SDMA_TRAP ||
+               source_id =3D=3D SOC15_INTSRC_SDMA_ECC ||
                source_id =3D=3D SOC15_INTSRC_SQ_INTERRUPT_MSG ||
                source_id =3D=3D SOC15_INTSRC_CP_BAD_OPCODE ||
                KFD_IRQ_IS_FENCE(client_id, source_id) ||
--
2.25.1

