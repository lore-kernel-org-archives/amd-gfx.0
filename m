Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325F6C04AA5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 20:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B49C7D8B;
	Wed, 24 Aug 2022 20:33:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA39210F069
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 14:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrdB+soHLKrIv/0D7ryGYDvqiOm1es2ATGz3cxIJyjLmBJ9+vHUkdzOXoGohUMK0GbkoD555iK2b5Bw9NDI0/aPVCNS36scN+PQuy4cbdYUUU3H3aa7zy1C/gn7wpbC109NhvyFqp0rYvM+JKyl99Dltw2cZzRAEhy22JI6L3TMGCWLA4m/H8g+m72KPFiTOXH+fNAW4keAQ52NjACG2dwdKVg4WV4f553o58TPdtyDoXO9jvJ4vu9kDjoQfmMberwplSHLGxzMWmFdecyFM+wkkxS8CnKYFvAXL7pl9S/AzaNt/oi0oFyLMkPwEH9nPOqXygDnxTe+GP2RLu/yAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MbIBBnzozdwP98XSqBiRKwuL+gGlCSmH+iM1UUuC1s=;
 b=HB4OLCM0EzqjeZu4WH9VufD75UOzvvaUfBbmzDNDyHV6kSzOK7yAxXXo/tUN9i7A8e3xCrnwIquOERdy5a7l6cD5ocuibadfVaka8MvbWjk2A3/JWqmHlSjb4AnlOXXAnDlfR/4K6Ewl9+xZ+VLSZVrFMTK4YNfTnM2TzegbucKyrQW/ypoQ8YXB8VXAJ7QlhBCHx8P5pedV4T9QV62x3Hopxwi8CnBXisXxP3jp8cIsdE6CcTiUJQLmmvz1mS1cEjMIRoNsvXagnH9ra78xyueYLe35OVkAnjAcsztEfo0zKw+ey5+FlPWdtXRHXb8F8S7l/CK3qbitCiHK2VvCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MbIBBnzozdwP98XSqBiRKwuL+gGlCSmH+iM1UUuC1s=;
 b=KKk6pYXQEoo7P4JHTQjiSCk+s614WboXjbbBw5CwF+dgCK6kH2zrKJ/RYGICGBQ7lSDXIiJZqKw7x6i/MUh8izY9YbwetmWdB8crJ36+jZ91wT/VFSn0eO/D2Kk0c1iuYaaSecsXLuX4nq1lcO7+ok0YPp8iBNXhduS8SaNg4d4=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Tue, 23 Aug 2022 14:11:58 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::bd02:538:9e12:8a9a]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::bd02:538:9e12:8a9a%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 14:11:57 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update mes_v11_api_def.h
Thread-Topic: [PATCH] drm/amdgpu: Update mes_v11_api_def.h
Thread-Index: AQHYsj+TQ11g63lmB02A4Phcn2o0LK28j/zw
Date: Tue, 23 Aug 2022 14:11:57 +0000
Message-ID: <DM5PR12MB132324DD1B3E1BFD3D40E4C38C709@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220817134428.3674667-1-Graham.Sider@amd.com>
In-Reply-To: <20220817134428.3674667-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-23T14:11:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d08d6283-c2e1-40f8-b53a-8318ae1227ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ea96486-8755-41da-1ac7-08da851170be
x-ms-traffictypediagnostic: DM6PR12MB3913:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSjioTLxdIC1h5W7JMvkg2gU2XcU+zcFxCCweEAqJwT3YEskeXmGioXuL6DzNkzKgREXiDo4ZwH0qjnBEFNy3fz4EWcMofFqDiU1IARLzcWG2JPAbqcmQE8n78UzgrncIr49Cmu4o1RXWjHsKBhcsOoW7dUoFgHlVo/3UmjVpXKJQIX1aUQBagYmA0ASfWkF5YLv4AUMFTU7sqF7cSczrr4z9NAAjK1kVH3ylsNN+Q78eAYGniNCgS46lkcEiWY/9iTf+we9yrv0bVeX5Krk+m5ws5deK1MARKLKWvsVt9h9/wvY8VNljtA03naI5EEHNLs+BEVBFRVObYqzGTm1CZ3rDziTuRToiYPmFtJsliETTaGssmgufvDZKke7Tgy/DxI9TlmlbI7KT1ka+I4WPe6lwSESJhONuqW/LoOJM8SQ/HZ0q48T8gTMVWrW47dQ2gW/HEgwhj5GQFQ1w9mZVtBziQ49NXo+c3KomUcU0WfQR00Z54gaPJV2EIZ/1KR0uBge88sgs+cuStIy2AJ7bFbLnuI7I9Rjk6rPCLiAJct3ICa494ARgoxTA8hYm0AQxxUghK3ITmGyfM1n3jVHADAiyC8pfndXvNsmk5YgvUs4rOhQZop2e3JHKCIQ5zTJZ5sZpny/EIxn/9MCFODlB4z+/zSn7NQpH1XCCEqNTgIOzEYMshS4sU2SFSN73l4uq1LwT3ufz1X6sb92NQ70mT1OQ+XnueAVhsZu/gDMhQhz6xPkDfAKDf14XyDQeXXg/RSxXU9U64Kx90Li3vdFVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(53546011)(7696005)(6506007)(41300700001)(55016003)(2906002)(15650500001)(26005)(86362001)(478600001)(33656002)(9686003)(110136005)(71200400001)(316002)(54906003)(122000001)(186003)(38100700002)(38070700005)(5660300002)(8936002)(52536014)(76116006)(4326008)(66476007)(66946007)(8676002)(64756008)(66446008)(66556008)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81MBcpryE4YgebX4jDiaACD/rC+k3Tu4Y3l4oNveCojQlAQKfPQu4qI1LbM9?=
 =?us-ascii?Q?87TRkIHOOxqgmRj9BhdfzbLZYbZBxvYGDZ+qeOJS1KdibejfpLP1eDoQGIBy?=
 =?us-ascii?Q?mNy2LLlND1hoexyja4dvOtrVY9eE2ydJ2I1PGuiHkK9O9o/F9jCwOrEQc5Fu?=
 =?us-ascii?Q?DQgv5uNX9+V9LwaW3WW6m9JflRGOPgyNY1XnK8S9XJJY55/Lw8DYf+995TjE?=
 =?us-ascii?Q?GvDwe5+2anV2mq3AujZtaMZpMAoa9qluzIdzQ+9LyvrmMWZMpm30cJcVp7cg?=
 =?us-ascii?Q?UQG2PTZATzlOfyodQ8JwfKHosQMFMs27GqmITaaF+HUU6x52tJm23K+ZY8Ub?=
 =?us-ascii?Q?8HEx7Q7lUmhiP+Sbmin9SG4RKUOA14spv1hpZts51ZvmkeUheDAyarXqsJVe?=
 =?us-ascii?Q?iyD3oSQP3WdmNvFbP7hhUv2vMclBiqLT+EwhC//Er5o+/cCp1WIQ1wezFdnj?=
 =?us-ascii?Q?hlpEK63auJPBcYT2iSl//n7HN75qrFmJLXnxSrb926BRonUVGq82QKn8oKhG?=
 =?us-ascii?Q?XuO1YF9L26A4WWUxFTchma/bDhpzgi/lO5GCAlqdmq8Y28auWt8K8/XXow/o?=
 =?us-ascii?Q?ZaNEmZBdcNMFa9O+j5X4gh/xj6mLLBndHAnmmcqxS6tcxHWRAfi9cCfjSDx0?=
 =?us-ascii?Q?qdN4Gkf2vKPZd2oCdmK3IjhBlCpklaeh+pyo3BheX61M0XxnI4Esob1EWsqX?=
 =?us-ascii?Q?tAeazHa0bxbt2KN1xCK8mtSe7wHESDv2HgF1mwaoYmct89BoTjXjl5S6QQEA?=
 =?us-ascii?Q?5tpXGtj1VFtLnz5/UeZ+Ho1WjggUQxaxENWGdo+eTU8+u3NpVLQ+aLwVN/o1?=
 =?us-ascii?Q?hFhVlt5jT7udTAow1N2J+3BRuPXzrVoHD5c7G52AUw4qnjgY1JZrWYQvqzP1?=
 =?us-ascii?Q?dKg25JhyGQkAZWh0TabtGjvs7eLi+OqcpBc3Wv7PaLTqLHw5aH0oen36rxdl?=
 =?us-ascii?Q?TE7HOMh1lKGmsxI8n1vZlsXcWurgfViZldDH9g8T+ejgoF57N8J6OexqwTAL?=
 =?us-ascii?Q?zvx7WS0WSbjsNYD5zwHH6aSYGX3/i3plGnyOWVucl/qQ+jI2GJFluMkMY0ui?=
 =?us-ascii?Q?0uHAJ39X6aOJm+18MNKoP3tP7IYL/spacG6ZlKKPQI7hvuPCe8jv2mmTHGBS?=
 =?us-ascii?Q?4YPZZ7IRXiv4ZVeNVzAANMYuD1/pCqmPwo7lH6GD/fwQT+yi++kGIyPIwOEY?=
 =?us-ascii?Q?bRxNDVZx5z9XZYh+wcvIw4onrqng93Q4DuWJObyiQenLAGOeFOc0rPwxddZI?=
 =?us-ascii?Q?1fZxxXHf+EvuE+/JxWyYVA3S/TtMnw1HT6AjsmVY/5cIz2gHPpkwzKX6dTqI?=
 =?us-ascii?Q?+BHZUImG83wgBbACP77nn1YkybYXGDvCZO4fL/g4lqGRAoQ/FUTuuy8a6LJc?=
 =?us-ascii?Q?kRWLdLOyuxZj86iM9WWe6TKhD4dWvMHKeEroUD5BRSl9GdBcRr0EB+fWp1Hb?=
 =?us-ascii?Q?zO2ekZ0VWo1fTKn86I0LiTXEPC1J3QJOXskPxuf3Np1Dqoy+WYi+MbHV87uw?=
 =?us-ascii?Q?qrid627jicrSCygOVih7g0c3rGbNyuC69Pt/nutQVxZFwlfhhRI3iVUXzR92?=
 =?us-ascii?Q?/oKd4dLtgDf8gloGzyA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea96486-8755-41da-1ac7-08da851170be
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 14:11:57.8635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B7FyLW3mj3JNvuiu6LEgLv6kqsdyQoOLZryyx7NPv0h6HJWdsEQhI4ULEZCSL7NDvU0PbLTWTW+sHiwFQa2KEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham S=
ider
Sent: Wednesday, August 17, 2022 9:44 AM
To: amd-gfx@lists.freedesktop.org
Cc: Xiao, Jack <Jack.Xiao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com=
>; Sider, Graham <Graham.Sider@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.=
com>
Subject: [PATCH] drm/amdgpu: Update mes_v11_api_def.h

New GFX11 MES FW adds the trap_en bit. For now hardcode to 1 (traps enabled=
).

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        | 1 +
 drivers/gpu/drm/amd/include/mes_v11_api_def.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 120ea294abef..cc3fdbbcd314 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -183,6 +183,7 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *me=
s,
 	mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
 	mes_add_queue_pkt.tma_addr =3D input->tma_addr;
 	mes_add_queue_pkt.is_kfd_process =3D input->is_kfd_process;
+	mes_add_queue_pkt.trap_en =3D 1;
=20
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt), diff --git a/drivers/gpu=
/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_ap=
i_def.h
index 80dab1146439..50bfa513cb35 100644
--- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
+++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
@@ -268,7 +268,8 @@ union MESAPI__ADD_QUEUE {
 			uint32_t is_tmz_queue		: 1;
 			uint32_t map_kiq_utility_queue  : 1;
 			uint32_t is_kfd_process		: 1;
-			uint32_t reserved		: 22;
+			uint32_t trap_en		: 1;
+			uint32_t reserved		: 21;
 		};
 		struct MES_API_STATUS		api_status;
 		uint64_t                        tma_addr;
--
2.25.1
