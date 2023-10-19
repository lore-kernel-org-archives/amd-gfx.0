Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB2ACDB483
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 07:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F71110E498;
	Thu, 19 Oct 2023 07:18:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662010E498
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 07:18:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XImFxJiS6lhfw7HTyg5ulKoMrBrHb8z5mXtfYcKQA6jjXuWvrK4Gs4C012ToMqZSqwm90/IQR83Nuclpn4AtLSRJK6znRfgMQVOhy6uiK+MVUGSbiXsG3H9/qT7dQzBXilpA9DT6ARye6gvvE63idX4v0y3AQwjO/mBBO6pth1U15FW/VpBhkZD+aa5EokdkOjnm1p/M43LthM5fwRLvcahMOy49do+AqJX2fDwwC0xXd6nH12IJPRLjULU5Hqdcck78dECHVWgbrbtgAEODam41unAFKK+e7HBFHZ8Ms2bqjAfE3QIerlaQqJohu3nCiWJf2MXGdFmrLyit6ZPzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj2oLQ6nv2jsUMClYeQLd71RgUOPomY91KlEyiQf6k0=;
 b=BvtjltXfFgwBxaZIr5UkIRFmnPHuZaHdoTJN//v14gqR/Ta//GIhZzLrG1+Kg0JGsAqtvDPbQPBHWXT98Pfi5zq26MqPe5EnS4VX5yQ2eq/zmYPmdycYqEwc1/b/tR4B8PloibbmkMPl2UNY3J8FqGC5CmZL8QVfmfJLLnoed47kcV5WGQcMpwIVOkYWQuxJ8c7LUtG2I2lzV5+JGoiTIc+DcBTmO/0LaOXolyzCJX4cJfGFxQif9A+MJJedGPytP3fLIO6wPTTs2jDi4Pvo9KbCJF4HATqIk6RTjxKIt5DzMk4a4LM4+5qqVzT1wch9iUnkqvnr6tqruQpvMnooKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj2oLQ6nv2jsUMClYeQLd71RgUOPomY91KlEyiQf6k0=;
 b=U4mbNvmk1wH+8wFo1CDKDf+62F5b71So+nb+cCu3gvPGKIyyhYvTzzNGbAeM4B4fhBox9SGE/0F8FoYOC7SBJzCQ7X4x0rX56NUarlfgE/8z3fTw7sYpcjtGH3SZ/2hmiBrLStGo6iZX2mUoWXbpag+qWCN2EOMyuXjXhHKWvYM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 07:18:54 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 07:18:54 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: Fix delete nodes that have been
 relesed
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: Fix delete nodes that have been
 relesed
Thread-Index: AQHaAlnswE5FzW5tEEWLgYueDuMUc7BQtAQw
Date: Thu, 19 Oct 2023 07:18:53 +0000
Message-ID: <PH7PR12MB5997256493C4D82E5E0779B682D4A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231019065948.3312040-1-Stanley.Yang@amd.com>
In-Reply-To: <20231019065948.3312040-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH8PR12MB6770:EE_
x-ms-office365-filtering-correlation-id: ff0e4233-d528-48b4-c149-08dbd073a6ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hERsZ3edxtAcG3WwfxDqIkquX0fRtHAcFPxQhwfcMglMgo6jOQpuyWHVyfDL3LVKmhqqTwjdWPbQhmlpmNtt7wnVUtis+K/Xx30nnq4eKzFWHhGGqXPVZFt5Um0pSyDzIp5tJVqAqd7m8iGhfgRyAT3kYer66T+gAqZLkHMlL41yLMwHSNyvGcdXe7HPVuKaK9LbbuWOI1oazxe7GCT/SQ4D4jT61oUVef/TcAU57o7P+ZKDAO0JjkGQBfCBw3B8fe85YNZCdXh0RjIPsOeZwuBUcNuGpdNVdRWxTFrR++iZJUsg0PmtQt4Ya5mGao+/sRLwRQDHMW5NhECcLpQDD6pS6zbTmRfby5IappbFCPn+xTxfyTAJ75F1KyGwL+3DXuhZP2mv4L1sMgENso6F0YBVZ4MlcBpxJBOimhXLQDKoeDFnS3UAdmyi94kY0GMP64bX6k/6wN3xKX0REbTXAUzqRn8c0OvepOYrDVrGsFtz/htnMZrig4R9ovftjDCowStl2PR2Wl5ao7M2kmc3wdEs0bCDUJwziIXiObp2nEw/AStgGZ32bbJnlKwUmdevhHLA5DDSdoJ47qk1RHg2iuUhSMp0rsBxhkIjXOBPi1W+/lS2Y+HH/fQ/DlTgjLzP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(26005)(7696005)(6506007)(83380400001)(71200400001)(9686003)(41300700001)(53546011)(52536014)(5660300002)(2906002)(4326008)(8676002)(478600001)(316002)(8936002)(110136005)(64756008)(66946007)(66446008)(66476007)(66556008)(38070700005)(76116006)(38100700002)(86362001)(122000001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T5AEfbzurGDXo3ynOSwLN32pf1k0MBJj1JEYbUReoujY9mbY8Lnd3wIhFOjB?=
 =?us-ascii?Q?g6MAhX/KSM0PpIyiYEWKb6rpanGyQj3nlKG70ExygBGY+jFNZOedupt8n8wq?=
 =?us-ascii?Q?vyPPD+fiLcfL5sMFrjf0hRWw210zh0RKkB8fITI3yF5FCx1fWP510ckecWqi?=
 =?us-ascii?Q?Ri0UdeBehIFixa7A+ZN6N0lIMe7zc8adyTlfHis+9zH6K/lZ8roexkVvbQHS?=
 =?us-ascii?Q?hDM0gNvVMUYiOqTb4pzrDaxuYxQTWEIUcRB257s8X9wjprD2YF7du5Z9FTRP?=
 =?us-ascii?Q?ktemXNVmBOKrSbz2ZW9UKIhBIoQxlhalEfWIlEcWxnBvjrwRArustaxGXDc2?=
 =?us-ascii?Q?luaTaoR57gVZurzz1gDWXByjwmjyqG1KVGDfz2I2sQMpzdJLRVOUgKczl0O3?=
 =?us-ascii?Q?Kh0yiHdzKKR+/EdxVZ4X5h21ylNE0qE2qgOtuohCQ3zx9N5OLftw5Bcevlgu?=
 =?us-ascii?Q?oxXxy414YxaNYq43AzyhxhHOATPAIr6iIRm+efaWkD0TtDBgUqEUrGJJMo+G?=
 =?us-ascii?Q?5xgBmmisN0a0s+QK/TZGBk5IMzcKqvxogWiUbD9j6eGVjbgLNoDHS8/EcdMd?=
 =?us-ascii?Q?NgGBVmsv0XiYUU/0N0TFWvRrsV6vp+zWp625crX5rxZ+XPh3GCoZt1lRdh9p?=
 =?us-ascii?Q?AuLXxA5U1YtXEcfQYsHqxZ+2FP4n+yANwHM/UyjAFhBIpm416wyRTcGpNDvL?=
 =?us-ascii?Q?26jKeRs47r96g1HcMghtDXEAOQSgQyUZ4R3TVPJl1ipi5ot1qrNnm7Xqe8sZ?=
 =?us-ascii?Q?SqbeePOww/dIvWmZVQt9mI7c9efLQW34rpQ5+e6jbhsifX+seNdfFOofAf3f?=
 =?us-ascii?Q?z/EGqGdywE7iTtLpE+XDU5v6OfuuYs8MhisDLY/7UJBup4I77lZudoJRMmwq?=
 =?us-ascii?Q?ixRbQhEDcdLKpZivk7pZUj/HC8RyQQu42E+15YRP931m6AshUK+LfsXcFCjl?=
 =?us-ascii?Q?kLx6e/X9bRmP86F7xUi6RZVWCQjj9b2JayBtlSjHVOGfxaBUzQkGFK+/8i1V?=
 =?us-ascii?Q?eJLhuwGOh1XCsYnSjLk5a0kFQqoGy3v6NVv4CsGORzLhj9NNPlAw7V4XTcdR?=
 =?us-ascii?Q?nhukazYPgt91IFVTkkVNp93PLp6XbLbdwxAwgUCIR+aGa+0i51FEKogDnpjS?=
 =?us-ascii?Q?04StKLZL0fhoCoxZ/6sUE6fb3IGFhwPNu/BVeFtxsKM/qRs18Obce2/zJXry?=
 =?us-ascii?Q?jT/dgNrr/W674w4FOGYLfFPV3mAWwPthIYQuFXmMJqfwvlyuZzFVBsSVcyl4?=
 =?us-ascii?Q?Hzgf5OO0utKwZtV6KQmngs25mdolhLv18EITTEUOJEkXkv4vLeYFTSQzq3Dp?=
 =?us-ascii?Q?Ty7VXytqQ1YH7YUXPOTl/e0OGeQr5TT/4e5+L+PK3mSZC+WDhLcnNZjdJCVy?=
 =?us-ascii?Q?38ibB16wRjEk1MtHcI5ZTk49xefANKiFyCM5xCaYZ06vbhEZp1BTt5C4n4sC?=
 =?us-ascii?Q?MssZCpQHUqZiKqq6USoxILaL0wOUtZmeTX+dlTTAWoV0r8OCOrCJJS5QZ55q?=
 =?us-ascii?Q?CAuaKgU5OQDUXLg5hA8Oioj41Ah9zrKsiQ+Sdp6ep17w/bVKUXNveZ/Jv6w6?=
 =?us-ascii?Q?+x4EQbYf0lPqqqr2mTY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0e4233-d528-48b4-c149-08dbd073a6ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 07:18:53.9072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRLrbZYUO59OVytwiRTHPBMMUuI9j4xHOk8AoQWeACpC0nXdZwuLaZYEy9hxk+E3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: d479ef0d5fbd ("drm/amdgpu: add ras_err_info to identify RAS error so=
urce")

Please add above comment.

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Stanley.=
Yang
Sent: Thursday, October 19, 2023 3:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix delete nodes that have been rel=
esed

Fix delete nodes that it has been freed.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 8831859a2c49..867afbf84223 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3499,10 +3499,8 @@ void amdgpu_ras_error_data_fini(struct ras_err_data =
*err_data)  {
 	struct ras_err_node *err_node, *tmp;
=20
-	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, node) {
+	list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list,=20
+node)
 		amdgpu_ras_error_node_release(err_node);
-		list_del(&err_node->node);
-	}
 }
=20
 static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_er=
r_data *err_data,
--
2.25.1

