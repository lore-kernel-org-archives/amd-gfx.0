Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A613BC00140
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Aug 2022 12:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174FDB440C;
	Wed, 24 Aug 2022 12:40:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA667B430C
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Aug 2022 12:40:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTyR0U0B3t10GJTWK3YI19qvnW7hR5cMro0aDg1252saY7woc1HV/vcyTuXyHAGybFmbAN7LXr4gJ0V+mK+swajPDyIFlbCwopnRvI/9gq2Lq074JW8tBk3xtULh+3WYvPr30Y/SAJ4WiCuTE+Wjk0HZUo1VvL2weLF7d/janA1H5q+BwL5T70ew1AC6EHzXPtei2IE4yef3WMVBDOWjYG4nwgIFlRLE/rro465V8LfIwNJJH/f2dONjy77s3CkTOy4XUi79TxR1mubOpfexI+EtFt+eElky8ZqnCgNaMag0tbvZUGEBkO7SOh5QdUk3SlIlqcpXSR/9dHuCueu7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtFiZWliTXdOs4QxhLj3h4bbM1YbxVN9Mb9HrLOJs2c=;
 b=hPkO2P6nMaja7TG/WbFaemtwtn1X3+RjFRlIbO8cLOoiv458ncuxXvA9n9m/E6LoCxGe0clWkRA+zwiUWEP2JRuRp8BMwFjPP1MZE8KwsURhTLZYhaEbMkvlBuV7xwFvC3ahjD/1C2AbkRsSTm9IlgAteWcwC1H2UiyvjWEJ0beiGQb/jPRxaKzmwBUb2PGAoC7l/xAYOr1NjN4Ku4BpfabG5WAUukqPB2oiHD2ewHueiikIMaOqKX00ILbDr9q/9YnB7Ac6ndyh8SnJb10YeY7IaKTA/Kq1FLrI4ca8Mp5djDopwm2GQTpn0ABUFMet0qf1pufKkQCVBm2xuK6Igw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtFiZWliTXdOs4QxhLj3h4bbM1YbxVN9Mb9HrLOJs2c=;
 b=F3I81d0+r33FT3cn4+9rPPrOJGDShjjW+vk7JT1CB8pjClZ9RbKPUIhhb7jt0dmIm5Y1r6TNBYLXt/5xupmijXB5SOjDoHXWXKQD05rANnHHJsdQl4iuQhlrPkOGG/mL3BZPgQMcFRHO5BMKhDK80i4JwYmgPow2QbcAtQegMgY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM6PR12MB5006.namprd12.prod.outlook.com (2603:10b6:5:1b8::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Wed, 24 Aug 2022 12:40:06 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::c851:4d6:e0a8:3587]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::c851:4d6:e0a8:3587%5]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 12:40:06 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Topic: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7
Thread-Index: AQHYt4R3R9k2uhrdWUSP4V669RyZ2q29/WCw
Date: Wed, 24 Aug 2022 12:40:05 +0000
Message-ID: <DS7PR12MB6005164AE7FD86070B2E545DFB739@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220824064048.2581639-1-Prike.Liang@amd.com>
In-Reply-To: <20220824064048.2581639-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=99420bb2-b49e-4600-8d74-1d73e2a752b9;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-08-24T12:38:00Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b7406d0-382e-4b0a-062b-08da85cdc5cc
x-ms-traffictypediagnostic: DM6PR12MB5006:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tetjVuyeEEGbn68c1Ndt3q3OC3rdvB2n8++Jq/WSpfMPNmnC2k/zAgMztLz6KUJNBQSrqsdG+mkn3LrFZ2ply891c3KfQylkv7OxPfmQSETKftqhBLb200FDriI5GWpTmkV0sG3UvuuWP3Ud4ME9Uikw2CPdZsYxi9uecE4tZTkRH8mZJTNqtaeLtgXOnVFLFYo8drFq+Lfa2Ac4MzqL7gSE8LczvDkvuLIzUZzYgwrDlsRJX00rRWp7IfZ/eATlQ3pM4dSwTgLH0xcnFHpiOKNmpcX+SII+plZYbBfUOIBHoOp3Uz5n0Mckm4zvvKtEWiS+MdQZoItIwR65MWLW1Ip5EWbayXx65KmsfuN0L9OnKcIJjMa4afvJII9UccorFApHAhEznAVUa3yS7YSM9w9u8ZD1YL1kwbLQhSJOv/HHJgRqv95DQSVtKSGkIP0gOoy2J+yCr9s9goNxODvYr6nAagYCAH8hthfZuuWmYYbP61o79Mq7KuhEiSwKBEym+ec5B46rr168JtP0/3lnEpPetBk9i4tOGhD/JUUmOr189Gil1217IpbWa7CmVrCdwv097Okoz79mXtJcR20DaUjXtWD6ihuZDEU2wh7xF6/P20+aXWegTSwWsNJ6D5P8ltWOqF1qKJbrAIxgWOoMTl7FyzrL6Drv3YG87ZBK15TE2S15zquGlAp3SL2rClGfoHgBNlZvzQUYhjUSO6/XOXEoCKQkSEn/w75sJSsuNLe7I/SCRbchi80POq1/B7pMatZlbTFkw/J5H7HwMGFtbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(86362001)(186003)(33656002)(9686003)(26005)(2906002)(53546011)(6506007)(38100700002)(122000001)(7696005)(83380400001)(38070700005)(55016003)(8936002)(41300700001)(5660300002)(316002)(64756008)(478600001)(54906003)(66946007)(110136005)(52536014)(66476007)(66446008)(66556008)(4326008)(71200400001)(8676002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eSQ0BfR2Ok9w0XmTVF/+4iKzbslgzlFn54KpVjLIPbiePPasevTGOlJ8KXRj?=
 =?us-ascii?Q?t1bD9YdVp4BqfowWxXuenQSBUSFFVBbHfyBi7RsjIqYBHaL9lIHouX7WZGLF?=
 =?us-ascii?Q?+a/wussuWep011NKx7XssLClQO4myDHqEOeocOfLflnLKeVxRqgTb3K9g8ZP?=
 =?us-ascii?Q?ggZCsu1ovXAICRbskhGU65l8AfPQLBn3aWxKlxtIhku/bZ2r6yYUEr1AJ6BO?=
 =?us-ascii?Q?2o7K+0xCHR9z4oAyiitrbV8cvQfeu6RDWeQpbeabI4VGJLIbA1cb9oF+lnG9?=
 =?us-ascii?Q?dZeAINQ3qTf88nnSXYrat1oNPHcT+poo3doGykw6F4iIwmDQNoMS/Xd37Pfs?=
 =?us-ascii?Q?XDHKpIaRwirdVOK+Vg0HnVaeanZXhuL8V2v6GwRZNDya7O8l+HlipusdofqS?=
 =?us-ascii?Q?rtvbzxx4jI1bhHTNDmJn3h52Q4G61LR9GS57lERYAnPcu+aFSLTfspoHArJG?=
 =?us-ascii?Q?t1qS0C8IxOZNyBwrvmbpWSeEwDoi3/QaSVtbLejEPTNBb9RSWHx1A78Tauaq?=
 =?us-ascii?Q?WAsRVt8iutFa41GU3gvDOgPoaUf/616YKjL/v39S9dXZgVw/+mNkJFChwyn1?=
 =?us-ascii?Q?J31aUjFdp0m16Po32dGI5D6o+RZdWhlQPsjerxmZmWw6FYHYy6PjvyPEAuWc?=
 =?us-ascii?Q?LjACuJ/+TCznYAFzXsFtR0Mtm0z7yIImQzUgTiXPZjSeBglzZOiNwfN5SCFs?=
 =?us-ascii?Q?KIBJh37n1EZJQHNDVhgD0m3y8bG5p9YWw3N8/PCKUosvqAkCL3WuxSIvxVpl?=
 =?us-ascii?Q?cV0Q4J5hkqp5FRnWpn+mIE0d/tZssH4DMVq0PvrePzjflqXyz7GjNv9T1my7?=
 =?us-ascii?Q?IRQfbVZCkA+6vanT5+hBTKB+dNJpQhm4fSUrIZ7uqro04GUCA9FGJlrzuGW1?=
 =?us-ascii?Q?kz+sGtRoDJa69tgyNx5Xd5ArO+oehn3Q/hQO5uGXXYIcSwqQusQxD355p7dP?=
 =?us-ascii?Q?vjNJtNIGdwfTkPC8c9nc33/mDkmeQTqOYCf/ooeURxbXGl6VrAQsE08JTVh/?=
 =?us-ascii?Q?SCAybDFuqcSAwOUrfJv4pQlm4jz58zQHll1CoqJGsgnVuZM4lPerWa3wFY8n?=
 =?us-ascii?Q?BHOukpdb0yEdxlxZvm1I21KVSrX36ajKX1nhAkmowaNk9oGUkdIK5FDZMV0K?=
 =?us-ascii?Q?w+js+/ZmJg5gsRI5wdxuj5b7nWKeemcXX2W8g5ZIxv0iqC8oHA4Un+CptX+9?=
 =?us-ascii?Q?LLVsngqGScllbHj3SJG9vwdyMS54DCNa1BKAw2qo+XBk5s5tyubdmQcl+O1y?=
 =?us-ascii?Q?63cKaXVsihDchMvEgTbkRovciCPrLNZNddqNN+l7hRqXGK1kx4xzjtkGVl/k?=
 =?us-ascii?Q?gWDctI0byfm1OclORcYfMg9mjvXdlOPgHehC4GnlCpmWYqg3N9xoV+4aKCmA?=
 =?us-ascii?Q?3UIbff26Frh8D4VHNinfYAyYNJkIt7GIl0eh0phHUE0K/umEZlJrFQmblRm6?=
 =?us-ascii?Q?WXM8co9hUla9WVSQUOqUhWHG0R3Ua7qEc0S4MHFCaY5wdWK+H7+Cz9QrhbeW?=
 =?us-ascii?Q?+jaypsQsl+UmpqXQxexUbTx8lM5fbb5M3r3bOvnYfxRw7aVWivwXGLiDZlzi?=
 =?us-ascii?Q?rAmI+yqNnXf8yHCp+FM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7406d0-382e-4b0a-062b-08da85cdc5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 12:40:05.9150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P80KanJtTKlo/Merx8Ewl2XyCvN5dz33djEqLQak3fTm8qab1xhXREI0d2AQgGqI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5006
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Add more for the review and awareness.

Regards,
--Prike

-----Original Message-----
From: Prike Liang <Prike.Liang@amd.com>
Sent: Wednesday, August 24, 2022 2:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Liang, Prike <Prike.Liang@amd=
.com>
Subject: [PATCH] drm/amdkfd: Fix isa version for the GC 10.3.7

Correct the isa version for handling KFD test.

Fixes: 7c4f4f197e0c ("drm/amdkfd: Add GC 10.3.6 and 10.3.7 KFD definitions"=
)
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index fdad1415f8bd..5ebbeac61379 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -388,7 +388,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *ade=
v, bool vf)
                                f2g =3D &gfx_v10_3_kfd2kgd;
                        break;
                case IP_VERSION(10, 3, 7):
-                       gfx_target_version =3D 100307;
+                       gfx_target_version =3D 100306;
                        if (!vf)
                                f2g =3D &gfx_v10_3_kfd2kgd;
                        break;
--
2.25.1

