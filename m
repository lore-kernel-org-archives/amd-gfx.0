Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F51C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 10:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505A410E023;
	Thu,  2 Nov 2023 10:03:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F59D10E023
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 10:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn8TR9KRmg0rq65+8/aDEb8lybgagkLXzxOU01o+SmMWDUVQ7XzQnsXRQaMtplsgn/BPFK9oqrfcGAfmvDpaMkLvVdgHom0YztWlAJHLjXM7qQcVB//NqHgxcXeYh/d6diVJoTn02LpFf53il+rD1ifKZcTXtI5jYwpIBuVeHijsD+yGqKGqvSv5w8EhvPnLe/y/7EPfMoOTW4jlRdHswICJqy6g+Md3wxfU1eNRYzXW0TnAUh6/k4NBO5DKcm4ujOi/dKKSE04yGjXLTtSeK2Jc1HXBVD0qpp0okdmvmZDed6zR/1DOOwStr/+wBQCOmmyHYmSb7K3AFnpxaDQctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj2RDH+x+8zym9B3evVMxwTpZ1bm3J6WFKcniXOoZ/U=;
 b=JIRGERoExWiQz0tMKiX1QhcNY/MLh4xOLmLYy0X2fxq6b97StQCFmG4Ns/1fOevMzfYpy3q3+UNEErvK/5eRw4D+rSyMcLhkRBBqzWUnWNnTkfwSG2SbQXIIkmcnvqvL7+LWlT2SrtjmmESvQ8soOfeRpWeYO1/nIgbhN5r3mfNx6k043oaVHkSvfzLXpk0XqUWPe42Ucmcgx/1SIbpixmFjXSt2afr/80zibQj7rACsJwqnTMJFcM6P+dYAO4pidaXtXIDGp0P+oHDT2dYDH8sZznkuiU0zLZJ7cia+9Pd5kdwxaWotT2Y8TM2Ty+MOejdLUIg0tyCjKvIzeJGUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj2RDH+x+8zym9B3evVMxwTpZ1bm3J6WFKcniXOoZ/U=;
 b=oqoLm5Ao2w3n1+Sxsoj5ZLFHLQgG1wZDDFqvYMX1DI01aCEu6PLZt1sjP+FQvE13SFr1tiUJn6r8aniOJdjUehhCtIw9Gwpha8w+hE2zBRZG3P85uh09zJyeYnk8W7alIfCOP3Ry5qGBl4qg4BsKoRSiTFFUl9CM87fq+gmUB1c=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 10:03:26 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 10:03:25 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: fix GRBM read timeout when do mes_self_test
Thread-Topic: [PATCH v2] drm/amdgpu: fix GRBM read timeout when do
 mes_self_test
Thread-Index: AQHaDKEYfNPCNXNHmEa4YcZV7KaFybBmzjkQ
Date: Thu, 2 Nov 2023 10:03:25 +0000
Message-ID: <CY5PR12MB636947DBAD9DDF3095BA44E5C1A6A@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231101085317.609080-1-Tim.Huang@amd.com>
In-Reply-To: <20231101085317.609080-1-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=13280d52-b3b0-4228-a14e-7a57d3a4b130;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-02T10:02:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB9126:EE_
x-ms-office365-filtering-correlation-id: 41439aed-b550-4dd0-7a58-08dbdb8af49c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEjHCtcJ4cOQHNahcndGaAzmjJhgHmGEO4rXV0apOS0IHm/7GdNWBOGBOdfGWWSXROm4HU+bRFi073B/kFtkx3XRcaPAAzfkEcBVQ/TzNcHXwQvpoSzFbWvPql6E+XbVANveb2k/ntPeDHcn28l+ZbofzUSLZ+huIrTI7gN8J58n6oIBxVGDA7/U1DPMEGpJ2n7aeBE5fEmR7FYUlmzGzFEZ0+wsINKdvwNN8lekN+M8BePQZp5H+V1hjXRdgkfAigk/rMX2cFEKaYxNEOQzLlnlz7l4OyBZ8ZzbbXApILOWq+KyA3MtmxSLv9zDr0EOQRv3zQuHBFxo3VBT44qpciODrIuKcEoVAu8GIGGhV8uyu/tKbGIyOpZ06QAHxwAaJgDQwyc6WpzJIQMRntPmWosgYcGqwYTpGjXv7zLUeJBD25dgiCaU943kX2ulhxMpeRvcyE/Jy4LA3+o87nAsfzMdLsNSCjXgXUAb0jUiz9rmYxvHzy9os+62iUasl6rjFBZBL5HMC17e9HXLL4VxHtS5jHhjmGWHFcs9M6YobYQEO85oruVsQ7PZRGBzlr168cBJ4H0AJRrBZDWiRPlMFydcsu2A8rd1GZCY690F5PV+KK0AwpvcpJ0AOntEKiiZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(71200400001)(55016003)(2906002)(478600001)(26005)(38070700009)(86362001)(38100700002)(33656002)(83380400001)(9686003)(7696005)(6506007)(53546011)(8676002)(122000001)(5660300002)(52536014)(66946007)(66556008)(64756008)(54906003)(66476007)(66446008)(316002)(76116006)(110136005)(41300700001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GCa2nWTcyNh6LQyDrIkYqCmElh1lUD3sD9JyGzU9DEpg+F5ShWuVUXtChRZU?=
 =?us-ascii?Q?5W+ylpBdPo3dfketXaFl4cgi4YisxUvldHfIiMAZwylvzNa42xfpzYCJo+uR?=
 =?us-ascii?Q?W9dWX+jhzYNF5p7rePZ8PgZ70JuIP5OL6Rbvm/bB5yvPiSwKSCJlI07KKob4?=
 =?us-ascii?Q?gvSCtnrUz8H8mzZPIMIr0BZ463jdMVtoY4nZRcE3w19U4XpvYvABcKqHYqo7?=
 =?us-ascii?Q?PlwFmrvUufapQAVDlv8BP6uZ2KG3cXYmvR6TiQS6odSejjqz6yNJLnOOGRga?=
 =?us-ascii?Q?dUWcGYPBCnS8xi8xyvna49uE9bRliWJDPmP0MgJHvupU627dzPx5zsSMq25S?=
 =?us-ascii?Q?0yrhJ0FknzBdmXKkKVaxMqr5lmId8udK8oGNufg9RWVp6fu8c4W7KwoC/Q33?=
 =?us-ascii?Q?YfPaWFdgqQ3TIEMllAE3TWLqU/wG0aiM1vhqtOvo1tCzHVbyfWGe/Gh+Bn+g?=
 =?us-ascii?Q?LFXZ4tVB96QOuqQs+l/HbdXNgq7dvQNR2HYbHefiNrEVY3aITbQoeVNnjKOk?=
 =?us-ascii?Q?Vjkd3BBlZcMXrQQuMIBcAbOcKx+6fH5o5EtokLfVDACILYqBGJQtcL4s/3yU?=
 =?us-ascii?Q?bGSZ5ugZ5dfncqFAPADettMh75MdouoEZByYbUB8dN7quSCG3Lid6rb+7IBP?=
 =?us-ascii?Q?emBMu/oSnZK7P6PCrTansCpyKM/5Dzeoktb76gjLmTOA7RM8tNlpzyXgyRbD?=
 =?us-ascii?Q?/UVYd3JZdc+HyK3b8ZdFFyhb0DTA1aySgoGyUfJ5ViyHtnSRLNnKDKnQCVlO?=
 =?us-ascii?Q?o/WLLc+SjtaOrZr7Spyr4AoJoKqwQoFTRkxlKIU0CVklZiitUE9R5Uvu92F4?=
 =?us-ascii?Q?vL+xjcqYOQKgzj3ijTs5gMf1ay87k/l6sxfe/bIjVNFwM+c8g29NWUxupvG5?=
 =?us-ascii?Q?HbL9dYLoJDsvw0zOm7ZPkT86sW6rdaRuWJCnLTL1XFWYsOzJIxrE0MIObiyS?=
 =?us-ascii?Q?re5U+b27LxecJlje3tq/yeUULaGWOL4YRdDyA6StOHiq/suKlJGDSoS9qCWu?=
 =?us-ascii?Q?l33k4GHLeif8aH7VKPtcSn/JQSWhYAZuhlptrkjZ0pqFn20Bfo1ueWV151kQ?=
 =?us-ascii?Q?j9Fy3/hHKFUFTEzpTAelCb1m6ibwTDHQMX7ugbhJMd5K2Cpq8LZl44vT6ceC?=
 =?us-ascii?Q?IX3eKG0fbnkEw/oZ1eshzffs++30iWb7ebL5vBIeti3x0Wr8IClUGv3cdN/P?=
 =?us-ascii?Q?BzJ4BOetarZ1AftBJHLVApcNuxEpeBNN22M7rs+tdc2HhsG44VsRad349Kx6?=
 =?us-ascii?Q?fLYKQDIXP1eQ4bxceFJazMQbumBbz2ngOUPBCwbHIHcFUAzyFTAnbWKwZ4b7?=
 =?us-ascii?Q?fNBZaa8ZCGGhaw2qxXYJb/7EDuA3F2jhyK0PG1b8vMuvPLk4CRN7+80YH5OW?=
 =?us-ascii?Q?hnCiRkWIHKmoRO4dgKC4mxPvfds2tmqsAtUcIbD2AM6kNcqBNsdU+Qh4f5fF?=
 =?us-ascii?Q?UWDcUrurj9lIE9c6jRhdIgcx9k/SQbaTQiWgzbDoXlv/8kNtb32PXcbHvrHD?=
 =?us-ascii?Q?Saxz+OWIVjlW7c8Irvz8fptPtzrAPvVBRiddanwl+FgeUgsm1iOwMz/CRW1v?=
 =?us-ascii?Q?7BZJzzpYCQvIDWv23wI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41439aed-b550-4dd0-7a58-08dbdb8af49c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 10:03:25.8710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0uSKkfxLuUNjFWNSU+jKbnV02IPV8y4BkH5IEMmkgnnNmitULxK9uyL4OzXayo8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is :

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Wednesday, November 1, 2023 4:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Huang, Tim <Tim.Huang@amd.com=
>
Subject: [PATCH v2] drm/amdgpu: fix GRBM read timeout when do mes_self_test

Use a proper MEID to make sure the CP_HQD_* and CP_GFX_HQD_* registers can =
be touched when initialize the compute and gfx mqd in mes_self_test.
Otherwise, we expect no response from CP and an GRBM eventual timeout.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 70fe3b39c004..45280fb0e00c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -556,8 +556,20 @@ static void amdgpu_mes_queue_init_mqd(struct amdgpu_de=
vice *adev,
        mqd_prop.hqd_queue_priority =3D p->hqd_queue_priority;
        mqd_prop.hqd_active =3D false;

+       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
+           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
+               mutex_lock(&adev->srbm_mutex);
+               amdgpu_gfx_select_me_pipe_q(adev, p->ring->me, p->ring->pip=
e, 0, 0, 0);
+       }
+
        mqd_mgr->init_mqd(adev, q->mqd_cpu_ptr, &mqd_prop);

+       if (p->queue_type =3D=3D AMDGPU_RING_TYPE_GFX ||
+           p->queue_type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
+               amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0, 0);
+               mutex_unlock(&adev->srbm_mutex);
+       }
+
        amdgpu_bo_unreserve(q->mqd_obj);
 }

@@ -993,9 +1005,13 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, i=
nt gang_id,
        switch (queue_type) {
        case AMDGPU_RING_TYPE_GFX:
                ring->funcs =3D adev->gfx.gfx_ring[0].funcs;
+               ring->me =3D adev->gfx.gfx_ring[0].me;
+               ring->pipe =3D adev->gfx.gfx_ring[0].pipe;
                break;
        case AMDGPU_RING_TYPE_COMPUTE:
                ring->funcs =3D adev->gfx.compute_ring[0].funcs;
+               ring->me =3D adev->gfx.compute_ring[0].me;
+               ring->pipe =3D adev->gfx.compute_ring[0].pipe;
                break;
        case AMDGPU_RING_TYPE_SDMA:
                ring->funcs =3D adev->sdma.instance[0].ring.funcs;
--
2.39.2

