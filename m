Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AA9C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 06:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157A710FFD0;
	Fri, 12 Aug 2022 06:33:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1BD14A689
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 06:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKOLDxRg8w1CHrTyayDCP0Homndjl3LLMYJq/9YNrVrB4tvS4E9lB+a9TQq3+3dnLM5oGc0/G1dk5WWQ/ZKK1J55NCot54WRgswUtONUdUi7XCe9nUAAMgGcV5WmvX1BdvnGGxuDBa1UbBh3e1XBYDOuMqVgOQ6k3Q75TAoeoUnJTQUJpl64IKTMaHk6JWVzROJNALKUN4TZAsoNzOEYTiPd8HjFEGJRymWzp2pv78a8bcCeh81tbY6icz2IleWHTWzS0AUQfLLp1IUvRWi9qkdvJNJjy/Qe0R+68q87ZVvrZZgqw3g6CtUqpquBu+v51LOWN8oQPrvO620INftFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLFt5XisEsdRN6L+KkCbdb9SkcL/QzuZLgTYYuftU7o=;
 b=G9EC/kwF5RmPPuDeJ7Z8yV0egZHbV7EZP+POswSTYUNHF8bwFK/LghXTA+Ny+QtBcp0jOSg1HiVadBTTKNNHxHXNDJPHNPBfj+NADS5+R+i2xQ/p6xfdJhVGm32i+Tj4Aik/1qkMPMPKqhPnDSsyKeCq5v5LzQohZholoDx9EVHMsHK1EfyylTMmlWYUUfHXM0lcBPszWVTr6MESRwBhShZvekpddpfPv33ZJJKgKs3WLI722YSQ6+YQ+xdsRve3J2KZ7Q7bLz2aZXN0XeA7RaMBKmR4zKWznersq1VXJ4haDeLauQCgwkcbOo0FPmtudyETJ6Q6qX1QsiMOHHnj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLFt5XisEsdRN6L+KkCbdb9SkcL/QzuZLgTYYuftU7o=;
 b=t2R1fDsdYShTdOULelf6Tq0YO9+tiUx16TOX7LpdbHl+EJmG0vgF7pj8MhXqHbJldBhhJ8SgdgW6G3OKfyKtP6LjnmoEO2GX6i4Rwdv48E6vZQxU0sH+Rgjg6F1RMB/Lzqa4pghL2CrZ7YgzGwrtTMw5oS+RZY6C8UHUrKwPjms=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 06:33:27 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5504.020; Fri, 12 Aug 2022
 06:33:27 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Thread-Topic: [PATCH v2] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Thread-Index: AQHYrYFZO1zNgf2lf0+vRbuVZhb2V62qwLGw
Date: Fri, 12 Aug 2022 06:33:26 +0000
Message-ID: <BY5PR12MB3873E44875B73B99B62C5F64F6679@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220811124537.3958516-1-yifan1.zhang@amd.com>
In-Reply-To: <20220811124537.3958516-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1c7a9e9-a087-4d48-902f-859ec2ac3b29;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-12T05:39:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f26c8bb-d191-4e54-6bca-08da7c2c905a
x-ms-traffictypediagnostic: SJ1PR12MB6027:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGSIN/3S2tBsh7SRznpfeN8M4RdZdMGpOh6OlbZameGoPzMRKPbg75OW4x3wTOf9Twa/oeN2A7DaZNDAmrTwOuOP3PGrwyYyoX+GjPvXEPqi4DWmCkXFo8AX4ZZ8gbJQuGC0Pqw2ogJKxaZiignyZg0M5n90pmbkbfi1LKZDcX6FD185hc6mhGwHgRz8N27JZp1PHEfp5wOMwoL7Pr7kE5Gt5dNMjjgesPpgSvgVtKfszTL87xltsNBLMdmY/ei0lmf9m8prChVTKzFPro5CCEe1r0HfaDT+GKAZK/AaTz3CmQ3x33LjvuFGly4zkJGeRxWoIeCAwtP6ZPDFrINiXT1wP/uentaGDYgG31tfRv+3y0pkhBhkQwmEqUXofzjS4mw1ZUvS5vcKQzLbyW7no2sQ6GycqzSfR0u2gRqZYTds9YpBpp9wZlxGaQ+h4T/uDz6cjv7mxq7lL56RBcZI8YYistLtlHdEhsw8NRd6i4aCUVLi38thiigoN89Y5ojURgRCB6SSD8O3+EV8JvjCbgoI2ti/lNfRql/JcNdRtTYxXG0em8dLErzaFKkLFDhnEqOWjHrtJaztkfW0JayYJi4zGXAK1zIBq5Pgb7qaGWf2EFtBwWS0Qm+DFF4Nn/XRIUwJY2Dv18i30tdkq1rAXOTVyqWs86VLpG7Ja0pXKXz0YwjCw9iX8SL3dqDp2wlQGo3L/k5E+WeJ7Msiukw7cOdBRRivvL971Y4wJF2YD8tVSILAPkZZRXTpPFor388VD8svDtNnB3926lPXInlSwH/MIMFFaPb+gJKkJaEmdjA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(38100700002)(316002)(86362001)(64756008)(66556008)(66476007)(122000001)(66446008)(66946007)(4326008)(8676002)(8936002)(55016003)(5660300002)(38070700005)(76116006)(52536014)(83380400001)(6506007)(478600001)(53546011)(7696005)(26005)(41300700001)(186003)(9686003)(54906003)(110136005)(71200400001)(33656002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?00EYGQl/+HV6SOGeFQ0wY+q3JqRfLYDMvGQYndbG1X5KrGlLluW/UCWZ8Bpt?=
 =?us-ascii?Q?NzXO3GLaTsfLg4c+Baz6qcU3cTFyTuT0pH6qf2IxWHVCY+2apeo2Lkw0poeR?=
 =?us-ascii?Q?lQ8K4iNWF2yJW5fpGWYJLSeA6hUMKEePbY7qY4xY8vTuchRRlSQ7umUEe6Nb?=
 =?us-ascii?Q?bQtTDsSvsiY/qp3oqGiSltvCcflbKGDpsNZgZFFz1MRPRAXc4LL0m8zrByRl?=
 =?us-ascii?Q?6dsvJXIbRRLyso/yE2UmCIENdUHs6tfIeC5wdea5dtcQXKznTiux6i5J26jn?=
 =?us-ascii?Q?ajUNoUHQz2aXFMU6bxEBcoYEmzpQFC45m0hO/ORLFFtdyFsQIuANnHwns7gs?=
 =?us-ascii?Q?o44TyU/uDuz+tSE6LERygR9YkhRYP0PRmbv4FdKrUMo84Cv28Aq0UQQm7rCE?=
 =?us-ascii?Q?EG+BdQQIU5h2vXhIp6wydLENYZVDWIH4WOBR1YOH8POw6aDoEBEFRSGNcEiS?=
 =?us-ascii?Q?TscfMy9L9EKbdXRgXvZBzzA1iC0pzryK/K7zdejS+NroEYSsK1DOGRWGNxHS?=
 =?us-ascii?Q?jhnJNN8GUsOCM4rh2oYklm3FYi43r13Q/mG7kdXIVnAVlGULndhR3yQwg6O+?=
 =?us-ascii?Q?O8p4tvan5ItDWGmkejW/k5NxHLDDnzcGTq91irIY5WnwBXVHDWs1GHVHvBls?=
 =?us-ascii?Q?2uMvKAgFEEVj4fHFtWGwxKCEXE/daV58Q4AfomKvebkZa8qWLeRhPGLIaXfY?=
 =?us-ascii?Q?gUJuUCBZn0maEEzRl/NB53WQ65BjKASl29wEvNrXXuYX77TN8g8NopqefbhH?=
 =?us-ascii?Q?gp5g3sdSXUB6cuNsw7Rx8ySMciGKwa/e3RguuM1wpyGkM2e3zcGIJz6wMEiE?=
 =?us-ascii?Q?cCNKl8eAkLvcjACJBKelIG+ryY3OUilIC8khgrRLojPS9bgPs+ma32RtcdQP?=
 =?us-ascii?Q?hCMEcn+IRHE3hIEP/qtiGY8IpX8nKFik3KE18Sm6MitHt8MG93h5uKomEN3e?=
 =?us-ascii?Q?D0m3zp0W/A4fH6bgjEs2px/8Ax8FakkB38jxhtCz8noLws8/ptGfIJv5jaQz?=
 =?us-ascii?Q?L3340fdzFh3A1AciCyEE0nfpr1i/1zFm7M8W3LzuWZGreocURCSuMr3T5oqV?=
 =?us-ascii?Q?zWPfAAp362lALotIaaauOgDOa+BmtE3RbV5OLZKgU2w4ERY7OrDubSd5mOU0?=
 =?us-ascii?Q?OtYeHbjQCIH4uxlo0k7M2w5yWSUPt+p+4TjTDIkAUlvQYqXLWSGxwtJxinxc?=
 =?us-ascii?Q?g9lBWBMHrK9gDkmNNU/YWyjB2EmOWWIkpK0/JuVlwekJhICmJhHft0w6x6ij?=
 =?us-ascii?Q?+Vmj8WSR7rHI/0B0lkZgI82n4QRAGtHsD3GNe79Xv36ldGGxbT9q1c4zMg0P?=
 =?us-ascii?Q?OGrYXgWAWQAax3blgHy6Ru2Yy/idRju5TfzWQE/aC6y8d4VPaIy10oxUkxbp?=
 =?us-ascii?Q?zRl1eVmUYyyx/rAT+B33DHtF6CQNQx1caQkNYOizqQOQzEIND0hYjv+UMdnc?=
 =?us-ascii?Q?1tB64wooZTQonA6D4rM3lkAEiQAxI4yvTf2MjMEtX+5JIR8egZMzlgwgqK56?=
 =?us-ascii?Q?Jmy56P3LSHojI4bso2F5Ku8ZKZubREYrVheXcKYuUq2CKvAaaQ5rMgpinQZ9?=
 =?us-ascii?Q?P44SOcE/1PpJ5G2gOM6NxJf2mvQuACDYfYCAcRzG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f26c8bb-d191-4e54-6bca-08da7c2c905a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 06:33:26.8284 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2s4yYrSBwcdnvTaB+EZ07ZvClxlgx/JdTIm3wZGyzXmmAW++Q3FcjLTNx/5HjfRw7pkukKwUoyBafrbpTm16WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Joshi,
 Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Thursday, August 11, 2022 8:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Jos=
hi@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan <Yifan1=
.Zhang@amd.com>
Subject: [PATCH v2] drm/amdkfd: reserve 2 queues for sdma 6.0.1

There is only one engine in sdma 6.0.1, the total number of reserved queues=
 should be 2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index f5853835f03a..357298e69495 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -102,13 +102,18 @@ static void kfd_device_info_set_sdma_info(struct kfd_=
dev *kfd)

        switch (sdma_version) {
        case IP_VERSION(6, 0, 0):
-       case IP_VERSION(6, 0, 1):
        case IP_VERSION(6, 0, 2):
                /* Reserve 1 for paging and 1 for gfx */
                kfd->device_info.num_reserved_sdma_queues_per_engine =3D 2;
                /* BIT(0)=3Dengine-0 queue-0; BIT(1)=3Dengine-1 queue-0; BI=
T(2)=3Dengine-0 queue-1; ... */
                kfd->device_info.reserved_sdma_queues_bitmap =3D 0xFULL;
                break;
+       case IP_VERSION(6, 0, 1):
+               /* Reserve 1 for paging and 1 for gfx */
+               kfd->device_info.num_reserved_sdma_queues_per_engine =3D 2;
+               /* BIT(0)=3Dengine-0 queue-0; BIT(1)=3Dengine-0 queue-1; ..=
. */
+               kfd->device_info.reserved_sdma_queues_bitmap =3D 0x3ULL;
+               break;
        default:
                break;
        }
--
2.37.1

