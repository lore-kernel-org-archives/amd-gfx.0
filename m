Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109BFC25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 09:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E1010E065;
	Wed, 15 May 2024 09:53:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rdy8xZxe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFB310E065
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 09:53:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gte2kTzc5XjEYoMgq7L2UiHyMSWXsGa8cvgcRpU6GCAqySI+6jZJZBNRgzadlul6CAL72t6geRKh7QVT8E/nLL4NWfB9AQnwu6z0Uuwz3h9bTBl0+Oi7rd2KPP8F7IwBTEogASORPSjrQO5RxIj7UJ2QfY0JhY6Hf6eB2AgbcH/dAOq2eWpkjnIJwZqO3jHKwGweXwLMnsdoRUBd53HizCB0o2M0NIhsrikfPWNL1RE2h8DKYcs5v0+zlEMvFbZ7zzqER5Fxhz14au63Oz00BhnSHKVmYmvzD/WdNUichSKmF/sfhv86AzBk9d1GWUJc+9UUNeqwIfD3Z+yCPh9Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPSswnsQlH1KFonVM4gfYsueIDe7kfl6SkEKHC5lCig=;
 b=hRIekTynilkivkZlGHUUnuVCP0Na4uUE4st//twI4GzJNuKki18UACWxiDU/P1BnSi5uAdo7Ml51HvJfwT4HWpWarqadV6m6aaWrXz68+yYXdg7JpANcsEGV73ohBnc8TsuMfFYT7yHfjYugwimzKg/96oFmAaI+svCjkhmugx4ckDIT7u4lpcpkiZEiVvoWwRz3WZ93uLXg+rUNoqs+2B+kb9Cvutijs0jxEqhUkmfpEn5rlRlTHUzgLBjFImTMZiVRM2UZveKuwuAjSkrn+jozAG5izdEiJJYNDg9wXBCa2UE+17/bbxyOkMw0VQAheGN07CEIJ8NjDl8La+UISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPSswnsQlH1KFonVM4gfYsueIDe7kfl6SkEKHC5lCig=;
 b=rdy8xZxeK/1BVDQ5be0bi/dA5g9OUI4GqQGJ6gxqsX43aOhYN0Mfly91h6gvWU4REgJKaLfz0yrtrawIBUUjnCeDjh6qGWXX0xAcsa1KAOsIjzHuIvgm50eP3AO+u//C3v3JUBQGObIgRzWvECp5dBAUVWZjE2lPnuWOaF1tpQs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 09:53:41 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 09:53:40 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: disable gpo temporarily
Thread-Topic: [PATCH] drm/amd/pm: disable gpo temporarily
Thread-Index: AQHapq09Rl4gfISSdk2QJ0nZuvSt9LGYDbgQ
Date: Wed, 15 May 2024 09:53:40 +0000
Message-ID: <DM4PR12MB5181173ED2778C6F179E81A6EFEC2@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240515094945.3445876-1-likun.gao@amd.com>
In-Reply-To: <20240515094945.3445876-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d5d5a1a9-3531-4ec8-88a4-488530344b12;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T09:52:02Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|PH7PR12MB9102:EE_
x-ms-office365-filtering-correlation-id: 1966815c-66b7-4002-e17b-08dc74c4e67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?GSpFjh346iOAs+M/pUKDOKBf/ErwuqJ+W8z1coKbsbnkycKlSyEUG6BFQ2qK?=
 =?us-ascii?Q?spf7IjRMm6rtfjypr4Ya7IIbSqcV1qnMIJvUjUnx5wWefjpIO5yQIBJ0l7PV?=
 =?us-ascii?Q?+K/vmpK5wH9DvKZQR9Kx+mJDj0Fm+neeHQ2LI+qTbTU1SAVOR+eu5xTXPhzf?=
 =?us-ascii?Q?T9I6BTKSP4RSFZ2A8I28Y6XKT8XzMtiNJbyRyIKt5cOog7SW8MkH1pTpQnTA?=
 =?us-ascii?Q?LJA4mfCoIk1jnkcqC0j9L6ACqdJHCyPr76bdiRuG5l0p0pFq3zXUj3hDLHrk?=
 =?us-ascii?Q?bHXNPQeWwYI/L6bGm1dEs5bf1SXtE19G2Cgn8en79IaVA46WMcp+p5gFvhAc?=
 =?us-ascii?Q?7sLsAvu5vYtpyumkb0rqXSiAeBeBhkLM5wlKHXzy+vYA6I3eXYio7JEo5PmU?=
 =?us-ascii?Q?gbUZdWH5NG3m0FnCc23Kdn6HEINinarggmXqGaKpKjR43e8WpG7FvLxVlvLu?=
 =?us-ascii?Q?XmC24GjT/BECuM+BUVuznHEPS+kLdVht8MLk79TKPzwQN7ou3nbpVtg6DXzm?=
 =?us-ascii?Q?bolw+07opd2hdO5XDGrejBMYn+Dc41JO3h1NYIkJOw9IxW3uEESqVbnRNHq5?=
 =?us-ascii?Q?+T7+iJizsarL5Ztb04CXqWbc34438JyuUN6gxnlrqZpebgG5oAWgFIdQzmGO?=
 =?us-ascii?Q?QLa+BpYL8MXgzm74G1rGWISrfA1kCinlufZ+iSx86I9ObcBmB+IqE5b/BOMB?=
 =?us-ascii?Q?1c5J8QESoMdLkx3vl1KkMQ7okALli4urCanpORkY/uIBWuBPcewgRk+VPYYx?=
 =?us-ascii?Q?fkN8smSYh5LrtBfMtDzEto4MXUQ2aK+mGElXkgFGJ0tIDFFaJZZCFcNUBMA4?=
 =?us-ascii?Q?plPczpYclN8aoKqok9vC6Rxtkag41VsB61+XEUsSwoJBVVYV/pWBStGb4sD4?=
 =?us-ascii?Q?RsEippMreUoOHMTNMs3uj5PSPh3AEA3zH+Pk/jos6qzswVS6wkoQbR9y0n4l?=
 =?us-ascii?Q?M8bphXKfGSpBaf5FD7Xcv6ElOf9ajNQ3dUsKEnx10sjhKHVyJ0FIxI/FNQVl?=
 =?us-ascii?Q?EDuq59bhDjzP9bcX920KEVx1YEMNYKevyZjHsuTRJLwCHfgduy1DtmLPrsKb?=
 =?us-ascii?Q?WSZ6+5ccnYtUzncTLq6Ql/OP2oedDiuju0pi/RQyX3K+WhefEbAujOXiBycg?=
 =?us-ascii?Q?Omjlr5GETNtY/U6McbIfIOcVdTrGC3ROhtIYW2g96Uscmou97c+M0qPrPy1G?=
 =?us-ascii?Q?DggYjqCBA+96zMwubwkO7LDO+NRWyFYY56p9h8WpwjqdJZwv4sIsnMmF/uex?=
 =?us-ascii?Q?1XJOYIMrGPcNtyyv6FNEu/l98Dq5owREzSxX0aENTlUpqTdF530qmv8LL7ob?=
 =?us-ascii?Q?+ZKz1NXU3yzn3UjgCn5vjYrSV8mXKpWarM03eAMp9gs6rQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fuq+YLeerCiGa0ABO27BZ4g1JuELrsgK9uZ2/yr7p62I7Ods27Cc6k5Q5EHr?=
 =?us-ascii?Q?ELlUYBuiXimWSl5odZCa0AHmD7Qwk4qfE/z+xZ5ZSgB+EuUABM+Lmyz86NR0?=
 =?us-ascii?Q?DmaMIk2VVg11Vr/aWaVs6OZgYecwTs5h4nENeRsv6UF2EryFvHc36uZEVxMi?=
 =?us-ascii?Q?GXjdPHUtwOXrLG5+QveWDPvIKqC4YsqJVgam8s22pLUagEVkP2zOiZlBjUDm?=
 =?us-ascii?Q?KzLXWMwrdfk27Ph5mcFUcTM19X+GM3ln8grT/QPXaUGmClYesydvOv6ZGgTq?=
 =?us-ascii?Q?5CqASyi+aogPDDRPre0BA1teZDX1EOF0sEMHu2qjY/Y5kvU+6l/mmQVnskdO?=
 =?us-ascii?Q?nhNFROZuRcFkKWK/5Y1Heog3BooLYcvOEZEGk7cK2hNHi0nr4m/QgOVVevFF?=
 =?us-ascii?Q?zcTRmyjJsKaLsvSLt4wNFbWQk9mAWjKhyxgddzJ57fT73V9DvCp6aZtzSvCA?=
 =?us-ascii?Q?81SK395sTlJzEwUArINfVlrroevaiZ/U/m5bwsJMTOZQzmDu3+5kgXuAe3r0?=
 =?us-ascii?Q?GzT4ihcGoMDB+BYy3xlQ5LHHlpJ9nGYFmiUkHTDgP7QVcbDnxQwD8qQiZV+v?=
 =?us-ascii?Q?CYoMoxkfi1vbi7KSCAuZ94hxuAqgeeu9fXP5oE+kIIaubI1e8/FA8bqm6wBh?=
 =?us-ascii?Q?3XVL4HSWQjbhkBrDN6dOcVcZ2HUhnKL4phIJFN0zHOOUzK0GQMGuXdQPQJPK?=
 =?us-ascii?Q?+GqVhYAP16GfNurRz9RswV8Rnt45PpcYHPQtKRFG0nv9214dmFinnu6ocjgk?=
 =?us-ascii?Q?ufqAZA13mhmmlQUhq66LCqTm8DrEFbcAlxz6FppnvnvFVgEbuGNAhUxTh1nf?=
 =?us-ascii?Q?wXhp2Sjam2zEDp/zayUiwAw1GQHU4id4M1DU3Zj0xVgQaE47SynPmprkr57l?=
 =?us-ascii?Q?bU0uFbUkmpLRLiQYIhpPfOZe76+t+kMr2Zw8OH11c+VzRkCB2Y82jVC3n2Yd?=
 =?us-ascii?Q?9XQoWkFnlRG38xWOaPuA1a4EW2bbLEH76MQvtKHDySgkLhNr7wDEtqoJXFCc?=
 =?us-ascii?Q?1QSIyvotRkCefxkMFwvr3S55CTgbz7G0M16oc7Zgy+4pmXHJp1y2NMI2PIcH?=
 =?us-ascii?Q?CDXBIzwZkr3GZqaCEmAa6EUWR27eKYEvrabp/gF1l2q6dqB3pt6NTJMQWwXa?=
 =?us-ascii?Q?ixdPfuNxTKVHnOdh+QL5dJfrxfjOlAJusvZcbyDMbUtp3KlXsEp6ixbs1BYp?=
 =?us-ascii?Q?mIFkm3Aa/jOsgeISfHugs+uaq7UtzDjUsF/5fiwOVcJ78GpE3P9P9GaA5NTW?=
 =?us-ascii?Q?+S97DMPXAftG8MUsQfnp6tyqdT1RoNxyA8n17ww4AdN/sT5WxAIIF8Xy15FS?=
 =?us-ascii?Q?nDEiL3hNk6ipRIlXeNPTIGVOvhAXoShlhkR8a3F+M8Tw2cXiAZkKceQeeCvj?=
 =?us-ascii?Q?CtyWu8GjmQnKCpHWi71QjaN6UTLZDeppQpd3RsFDV2J3WXzliaIsZGn2JmL6?=
 =?us-ascii?Q?drH5luqc/0S6Aq6aW4L65dvbu3zcdWsF9lGUzGEjoKlzRmhdOiWv/KHqZ7+u?=
 =?us-ascii?Q?26/tFX+8hFTLsjd0l3DgS3fAOBzmkpTQiVXUUXrjBYtP9up9JGy3YGqr7iVK?=
 =?us-ascii?Q?/MRju3ApL1RpfCL4Gwk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1966815c-66b7-4002-e17b-08dc74c4e67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 09:53:40.8626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 815Yu3fwF80a4S3y7KowpWsmICPchP6BygPTrDkupohbjMFaOgISqMvFmGjZUd/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

From: Kenneth Feng <kenneth.feng@amd.com>

disable gpo temprarily since it is not ready in fw

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Jack Gui <Jack.Gui@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0e27cde82193..b594b748de47 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1867,7 +1867,9 @@ static const struct pptable_funcs smu_v14_0_2_ppt_fun=
cs =3D {
        .set_df_cstate =3D smu_v14_0_2_set_df_cstate,
        .send_hbm_bad_pages_num =3D smu_v14_0_2_smu_send_bad_mem_page_num,
        .send_hbm_bad_channel_flag =3D smu_v14_0_2_send_bad_mem_channel_fla=
g,
+#if 0
        .gpo_control =3D smu_v14_0_gpo_control,
+#endif
        .get_ecc_info =3D smu_v14_0_2_get_ecc_info,  };

--
2.34.1

