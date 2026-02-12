Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D40DEEA845
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 19:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D46F410E12C;
	Thu, 12 Feb 2026 19:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lMmt7arx";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19AEE10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Feb 2026 19:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu7DLDEv0KMzZjvBjTrpulIsNXM841odLE7/jFCHHAkPZpLB7+1M5FatM1MySfJ34VSpjT14OK6XewiepLvF0h73GihUiaGWG4wQ9fC5E6Q8LWTdyuG7UJTQJIdeizCsbbyri+5W4I2TYd9T/AyuwKe1hrIoYEJqXrMSIdnRn33Q53Uhz9gGcPI6UihoCMZi7OEd6+wjUK5mHn7T0iVFeKT/yaf67ObiWpf7bpXWQf70xHqUHYFnw9X8R6dbtoTq/Y+gEsscJ96o15qYLXxymN3q8l2XkrHDj/Wt7vczcFKIcf02/TpYlr9Zhb5D4F8dWSyZ3mtRpfJJrwlzTRGwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQGhZtezPPjJZ3mtVnVkJHTSeBI7R7dJgA0HMnXkCXM=;
 b=PuYvMrBJOs3MyAZVgIlCArpGcNZwoWOzY0tHTtzo97/0IrzSuoMLnrLNBKz3aXjoJCCxs96KikprS/hvvWcwKNv32t/92lCuPV0ZISmEy+FHgb0zNig3Rs34OMlZFG4ajGz6y70y08ln/dkRcEycKugi4mZi25ese1ri1P2qeBNle7056Nc7sm8RSxcSwZWgypuRBYyTrg87LW0yP3XrVlGpIOhFqDg1ZFFyXPZ911grNSl+FgZXFvR545CQXaQEBdQqcgKFajuxAd1hQzdolEHNsliG1YrFbVK4BSv99Q5LbzlqoLXymQj36mgACOInUXZmkUL9RYZXxpxQwrYjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQGhZtezPPjJZ3mtVnVkJHTSeBI7R7dJgA0HMnXkCXM=;
 b=lMmt7arx7ZC3J1HqG+l7Za1Upf/2LeDi6Svv5fV+Ra60lZsoTUpzSuZ7MZlhoACQH5gk8tPkzA2GaGYnSEB3EI6kUgG/HauJliS0uzC8CKOOgurXLmODW4uOnkKd54d65ijnHl3Zd+tODDZRL3nXL13BGPsDjHuKC34km+59ZAY=
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 19:22:16 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 19:22:16 +0000
From: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Liu, Alysa"
 <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Topic: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire
Thread-Index: AQHclrylqwMk3gP20UqfDRlmvaWGk7V/bhGAgAAKJVA=
Date: Thu, 12 Feb 2026 19:22:16 +0000
Message-ID: <DM6PR12MB440105A544332F3281D7013EE360A@DM6PR12MB4401.namprd12.prod.outlook.com>
References: <20260205162846.106865-1-Alysa.Liu@amd.com>
 <SJ2PR12MB8650F18EDC866027298677818C60A@SJ2PR12MB8650.namprd12.prod.outlook.com>
In-Reply-To: <SJ2PR12MB8650F18EDC866027298677818C60A@SJ2PR12MB8650.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-12T18:31:15.7920000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4401:EE_|DM6PR12MB4314:EE_
x-ms-office365-filtering-correlation-id: 49d665d3-77ec-4879-a57c-08de6a6c0886
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?7EafRNCEdx1o8QF6xjTAXRW8m0DtsW/0AFHE2qLmxe7N3LmHNSTH1BbiJxMm?=
 =?us-ascii?Q?MJ7gO7kMC20ZPKuaZsHbNhH1NSTzkUKOvbY7j53G0g+xzHby00HhIFNZGhVZ?=
 =?us-ascii?Q?ZVBpurMX83DVXwvCnzUQnhgdgZynGxMz80Ag5/E9T7u3egaYPwaG+RSG6aty?=
 =?us-ascii?Q?6Dd0Em+Yevaklmi/tBkb2TwAJvzOfaHkEuGzAwfQoluXh7oPq7FE7L9pOwzL?=
 =?us-ascii?Q?vWMqso5Vqt3RwQSg+7uPSh9orpclnjHL5n3Vr9f3XwCkGlMPFuK72GxC5xyi?=
 =?us-ascii?Q?eaBUbI42fOXyDmpXczsXqdydnvmNTcAGXUuZdioWUBc4qsOemtyAo7X4xSyS?=
 =?us-ascii?Q?v2Fg2+JcgZIDJq+6qj+M0ttKecvyFlVUCzUYBWvChhiNu5ajgav3Mju8FmvO?=
 =?us-ascii?Q?JJK9djxu0ewXBiWirR3sD23La001rCMUarfAddeLA9TWp0sigjNxnNREIOL4?=
 =?us-ascii?Q?zn2C/zjAQ7RA0DNZYQBMcd0Y42t7GdUk5adJ+rGeAjbAOIvOqeDjrN9eQnoM?=
 =?us-ascii?Q?ktaXefg+uLKSd+oTFpOZrOvsDkfsHofX3otN6AuYMRNrMo5pqJAC+qzR6sFK?=
 =?us-ascii?Q?7D7zoX9PT5xCa2RQjSw9Y9vO2AQwMYS16WKzEf7FT3J3d/DredwtmGW+pD4o?=
 =?us-ascii?Q?Jbn0GVluNCybCgrlaWAwpcb1yFAoW0HMqY+19kC8dJZrvmRd5dwbc8xPdLJz?=
 =?us-ascii?Q?Cp2aIQwCAHTNxcbbKzHcnkNvdPl0AMiXADAYLsyHXdKETPA5rqLpOzVKok3+?=
 =?us-ascii?Q?PxKoot182hIFKjV+yEos8Pl0MpYy7yA92IFPBI7d7RdNKtRKmy2iE+gYjKBs?=
 =?us-ascii?Q?JvXbScVsQeg5RVUSNV1i48XTq6r6vW0ZeSk+hWI855kWhuW4nY4Z5Qu0vOeV?=
 =?us-ascii?Q?i7WBOIZvJVothaRW1ydzpdVaUAz6suoeTiiQOgUwXj4smfxZLNFxS1Aeq7vM?=
 =?us-ascii?Q?t/SMSsfyvWZr3+C1TpQo3jJUWG9ZLO1GPcKE9/3F4FWnfITdnui0vMCgVQs5?=
 =?us-ascii?Q?LrTv0s7lKZSSbYEzPsYfROlkjXcFp4IhKrk79wir7AQlj1lTUVVE11cxueAi?=
 =?us-ascii?Q?Zk6QEwWKkNt1MUBl+aCAq+uCcMezj173ikNgh4qngshRwieDNGY2nV9wccHh?=
 =?us-ascii?Q?7OBYy5tZVifoHW8RS8Cu+7JNqoh+eCfg63iuY53RwKeaUSRuePXvN9+dM0X6?=
 =?us-ascii?Q?MJBv3eZOJoCnjc3X4wtNXAw/B7eqk/u/4WKK+KRNeeaIqIE6OKpqo5lRPY+e?=
 =?us-ascii?Q?tROkyIpvGWfXffqiLNgTA+eouRcb24cf9lhAnkFmCRORS07Xnk0DpfOh6Y0O?=
 =?us-ascii?Q?bCBp8nNLQX9LdfZ0wX9C8gGjXj5IT3MpZ6v+jOJZLk49X65v1f60T7XCzWhJ?=
 =?us-ascii?Q?sDCJmJCSN28XWBTiOV114+/6DM9SlnvdNGlMKd0ragX8Dx2zhB0XaDsQFq9Q?=
 =?us-ascii?Q?lRUxaNE2W3R78cz6TymvZVndPxldYi3ktNbENLsPZhqC7OYWk6zbjamKO9k9?=
 =?us-ascii?Q?wW3lE6CZelJ9McxC0X+zboIKm19a89aOGanwWFRX9loOuQyNB2qbl+ynzte9?=
 =?us-ascii?Q?V7fkP51Gp9WpMi2oIvjUlQJnoVDxEiW2FRCYPfCmU9ZaPx6koX1AWFgVn7jV?=
 =?us-ascii?Q?y6Lt+wECp+uaJLWSQ1ExHB0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Hav5xVBXFb2BxZooRaCzM1fWV009jKLR9nm04JiAHGy71m3vR2foyiamcoGt?=
 =?us-ascii?Q?QaEEReRks+60tu9pos8o+aZBh363d9iaFksr9gZMP6IvXiSk01dgolAOsp3K?=
 =?us-ascii?Q?ub9QoBYhZhpWuIfUrvIaori3MBsj5IWklMG05fzNNo7E3hwOKbf52xeOsmog?=
 =?us-ascii?Q?HdG4d8ymK1UO6dVX3IG52kiTJ07+kNOx/4j4X43IP/rK+5pkqKSBp55xYAiZ?=
 =?us-ascii?Q?3ALYIgwuenFqt1Z290tejEC831cb3tQrIvIB1D5hU8slUbsyK3yzyP9Hffur?=
 =?us-ascii?Q?rJXGeyO4Js0xzxtuBziLdZxxMIzA3JpLUffr5KzWztfTG7o4dTrYI6ZJbOAP?=
 =?us-ascii?Q?1u5iYSKkMWzNlm3aY5cJ9vlSvhZMKIeSbQqS46hUN1bYbzxqxGTyBB4xrL5h?=
 =?us-ascii?Q?yqRAppztmuC6nAdlqKqy1oWie8O1NIa5HAvt+9ZuAgDzPkvuMnupmKqFxxkw?=
 =?us-ascii?Q?IZOyj9OUd4IgGI7NTpr0q0R8T2nUDw5ki5bRdafOtJu6/2H54OwEgDpIjw1R?=
 =?us-ascii?Q?6ua3IFooSz4aGotRYsdmk3iNqGb8wHP72GMFqlhn2ZSyjHCBpPkxMbXdPhm+?=
 =?us-ascii?Q?IcpRT7b/4qxsuhef6h9rAJ1tVGpvCL/upho+/si7Kcipn+n5XCqGPfKU9GBT?=
 =?us-ascii?Q?Z9AWteaITMCapxgZYpNeHTh8ms7+jt+ChGt61veBBdqeWdhQ5BANDTGUY4Qr?=
 =?us-ascii?Q?pEjrIkAsfSEFk4vq76QBQiQw6+ebMdqJnUCaCLOWQjFZnyNVnKYO8/SMgTxy?=
 =?us-ascii?Q?RlRDSiF6ckP70qp/yh2ld3NpFy5narSNZH8niyEzVoMPxPY73KIE9OLVnJOE?=
 =?us-ascii?Q?NCQzUbd19H1e4lNjTvhzzqYQDcDgLZj3Bx3yLZYpZQCAWiC+AiWW8clxgU2l?=
 =?us-ascii?Q?/9XrL9NkPpeL+KmmI9GPDgCz4aVqazHyJo3hAtnrSjWxyWyugSY0pk2vafZL?=
 =?us-ascii?Q?/Vas9GUzqdeGeMvz2EJNofPP5JSQkm9zmbCooYAlmO6BSIy+oOc/qasZnoUQ?=
 =?us-ascii?Q?p7H1ISlZk3NgFmBrOFyDQb9ImuN6jB04CIXh2g1pMsALLL1ZrNbueYvQeWqC?=
 =?us-ascii?Q?DV3MRJjzhYqSWQpPXNCCnDJN+6A/Ru/z8wvFElMi1uLhkF5hCD1ABAcUeRUR?=
 =?us-ascii?Q?AqB4eO8Dgs3ZtUuD585cEvFlRoIJA+x8bdDkcWFtFj4a+50lfQW1SyNP1P2a?=
 =?us-ascii?Q?0drsiBOOVEBESurypWi16+OWxrpg0aWw3DjpCuW2WMOFq5v4UJcF/P0a1EtY?=
 =?us-ascii?Q?dasnXEE/E3YtjkfYfmootKZFZ9+jNqd696XZJtWSEnWWAlCUnzK2Udf9h1D5?=
 =?us-ascii?Q?e4nYmv2GWyOR/Q0gaARQKTu8fxOXnZ0H9p/EoNz2ltvzrGCuhEeqFeuDtsbB?=
 =?us-ascii?Q?42r5RCC+MwUx0FG5b0B2PtJj3omNJA4ZA13kg8+mWO8j0sOXDl5HYS0zA57J?=
 =?us-ascii?Q?sC4ciuvI8+fWm3TJOo5HrNHP9M38B5dxk7DDbjk6uRXJMe0HncrkHM+Hgziq?=
 =?us-ascii?Q?dR0GohJjWCdE0Xe8fzOKen4mFefvnFgslVB9R2VDt+xoeY2JGLahKUbEDBg6?=
 =?us-ascii?Q?gq7dv4/ZRet9YB3jwv8csBOAeaRH/izrjGWvvlxodpWHNYDF4DUylfAcstra?=
 =?us-ascii?Q?8BBEsrN4ekSog2p0tnhrrPXvfdhgioB2vGoqqDCiYHVpl2iZtWqOITSPr1fp?=
 =?us-ascii?Q?ipk0AJvOWBf6Fh0Wy+OPVyjfWvU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB440105A544332F3281D7013EE360ADM6PR12MB4401namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d665d3-77ec-4879-a57c-08de6a6c0886
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 19:22:16.4771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dREf464+UC8H4Rdq/CZAWc5a7XQeejXoSeztaAoivChyuoB/8/HTP3bF09wp9gHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

--_000_DM6PR12MB440105A544332F3281D7013EE360ADM6PR12MB4401namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Let parent/child process share same vm will cause multiple issues. There is=
 no use case or need for that. It should be prevented at uses space, not wo=
rk around at this specific place in driver.

Regards
Xiaogang

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kasivisw=
anathan, Harish
Sent: Thursday, February 12, 2026 12:31 PM
To: Liu, Alysa <Alysa.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com<mailto:=
Harish.Kasiviswanathan@amd.com>>
________________________________
From: Liu, Alysa <Alysa.Liu@amd.com<mailto:Alysa.Liu@amd.com>>
Sent: Thursday, February 5, 2026 11:28 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com<mailto:H=
arish.Kasiviswanathan@amd.com>>; Liu, Alysa <Alysa.Liu@amd.com<mailto:Alysa=
.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire

Replace non-atomic vm->process_info assignment with cmpxchg()
to prevent race when parent/child processes sharing a drm_file
both try to acquire the same VM after fork().

Signed-off-by: Alysa.Liu@amd.com<mailto:Alysa.Liu@amd.com> <Alysa.Liu@amd.c=
om<mailto:Alysa.Liu@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 00ea69baa126..f7b2358a0303 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,
                 *process_info =3D info;
         }

-       vm->process_info =3D *process_info;
+       if (cmpxchg(&vm->process_info, NULL, *process_info) !=3D NULL) {
+               ret =3D -EINVAL;
+               goto already_acquired;
+       }

         /* Validate page directory and attach eviction fence */
         ret =3D amdgpu_bo_reserve(vm->root.bo, true);
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
         amdgpu_bo_unreserve(vm->root.bo);
 reserve_pd_fail:
         vm->process_info =3D NULL;
+already_acquired:
         if (info) {
                 dma_fence_put(&info->eviction_fence->base);
                 *process_info =3D NULL;
--
2.34.1

--_000_DM6PR12MB440105A544332F3281D7013EE360ADM6PR12MB4401namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Let parent/child process share same vm will cause mul=
tiple issues. There is no use case or need for that. It should be prevented=
 at uses space, not work around at this specific
 place in driver.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Regards<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Xiaogang<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx &lt;amd-gfx-bounces@li=
sts.freedesktop.org&gt;
<b>On Behalf Of </b>Kasiviswanathan, Harish<br>
<b>Sent:</b> Thursday, February 12, 2026 12:31 PM<br>
<b>To:</b> Liu, Alysa &lt;Alysa.Liu@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix use-after-free race in VM acqui=
re<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"margin-left:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:blue">[AMD Official Use Only - AMD Internal Di=
stribution Only]<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;color:black">Reviewe=
d-by: Harish Kasiviswanathan &lt;<a href=3D"mailto:Harish.Kasiviswanathan@a=
md.com">Harish.Kasiviswanathan@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Liu, A=
lysa &lt;<a href=3D"mailto:Alysa.Liu@amd.com">Alysa.Liu@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, February 5, 2026 11:28 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Kasiviswanathan, Harish &lt;<a href=
=3D"mailto:Harish.Kasiviswanathan@amd.com">Harish.Kasiviswanathan@amd.com</=
a>&gt;; Liu, Alysa &lt;<a href=3D"mailto:Alysa.Liu@amd.com">Alysa.Liu@amd.c=
om</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix use-after-free race in VM acquire</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Replace non-atomic vm-&gt;process_info assignment with cmpxchg(=
)<br>
to prevent race when parent/child processes sharing a drm_file<br>
both try to acquire the same VM after fork().<br>
<br>
Signed-off-by: <a href=3D"mailto:Alysa.Liu@amd.com">Alysa.Liu@amd.com</a> &=
lt;<a href=3D"mailto:Alysa.Liu@amd.com">Alysa.Liu@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 +++++-<br>
&nbsp;1 file changed, 5 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index 00ea69baa126..f7b2358a0303 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -1432,7 +1432,10 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *process_info =3D info;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;process_info =3D *process_info=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cmpxchg(&amp;vm-&gt;process_info,=
 NULL, *process_info) !=3D NULL) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto already_acquired;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Validate page directory=
 and attach eviction fence */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(=
vm-&gt;root.bo, true);<br>
@@ -1472,6 +1475,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt=
;root.bo);<br>
&nbsp;reserve_pd_fail:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm-&gt;process_info =3D NU=
LL;<br>
+already_acquired:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (info) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dma_fence_put(&amp;info-&gt;eviction_fence-&gt;base);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *process_info =3D NULL;<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB440105A544332F3281D7013EE360ADM6PR12MB4401namp_--
