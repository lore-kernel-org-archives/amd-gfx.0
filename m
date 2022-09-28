Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AB0C04A95
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 07:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2B110E30F;
	Wed, 28 Sep 2022 07:56:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F6710E301
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 07:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6yVwbefI98vmsleWQ5dmIbZCe0bO2kgh3a7WKR1jsGzNy4DtXge52yuzxm8TpPyvTUQGA5AWN0UjgOcKXXUy5eqWp5ahzwQMwGcu9/2pooeyU/eG7vgGQNW9QPGNPXunsCu0n2lDQmjXvzHjF73E71RSNlWMq8RPOD+sfIIxShhzC92NBE26mmiPzZce0MoqfH4o2T1tGbr+TXHVakzufDAnRMyEH1BO/SyV0n1CIPEzTDNJO7bp58GkMf//ldVKEfum3xg4Uavn25L94O9oVDbHKckpRPTx7B0LTV2JlBhcUKkcPDQYXVTijlJ6r2VtReQMlz8iC3Mp9jyP382Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j4X+mJ41QtIVpEqJTmOX0yLgd33QMJstqyW18yOdmA=;
 b=dVRK24Ur4++XQ+BPoB8piq5j6Nvzb9bVYJKqAPu5YZhWRYFeKyYLzy5GHJznYJXlv5YiviZLy/KHyuDGJJSPK/QnW8lk/5mhuumVfORSe0kbvkwkFb2+vgfsj4tLQ+SZF+w7+HOJnYlTPErPnOGhbn2iIdF/gAx6uYlKJ+pM+8lZgojHzuUBKsZ5FP5jFf1iHga6a8dR3T4jgXJ8j82FiaM4xWMhDDHxtMqgs6MWJaPpahMmlQrP8uxohv/zD1UuLC2K5Esuoe8VYl8IwOy25h51qgSCv8Iu4Ogqs52jeAo7T5YZ6hP5Cs5MxK2E3O78SkJAwUokfs8ndYWQAlD/xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j4X+mJ41QtIVpEqJTmOX0yLgd33QMJstqyW18yOdmA=;
 b=tt2ZWSbZWF4MYED+3JAUv9kriU0b5q5csy2odpbBAJBeL1fM22g/bi5mZj6fnmorLjq2PLl5X9KyhjzIl7hGBtfSQxu6N+0oz/H9pQLJuEy1r6rIyzOO4L20xUxnRgtFhJM1UBPzAmL3nhY+bcS437g+yr4QjJ6mWLSOGLFKgdY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6663.namprd12.prod.outlook.com (2603:10b6:8:bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.25; Wed, 28 Sep 2022 07:56:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%6]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 07:56:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: add page retirement handling for CPU RAS
Thread-Topic: [PATCH 4/4] drm/amdgpu: add page retirement handling for CPU RAS
Thread-Index: AQHYzy3fiV/eQ7qJ4Ua8g/GNww8+9q30gSJQ
Date: Wed, 28 Sep 2022 07:56:20 +0000
Message-ID: <BN9PR12MB5257261A8FDD1B25C76E3BAFFC549@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220923092112.14141-1-tao.zhou1@amd.com>
 <20220923092112.14141-4-tao.zhou1@amd.com>
In-Reply-To: <20220923092112.14141-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-28T07:56:16Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=29b411e3-a923-435e-8f3a-da782d0cfe39;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6663:EE_
x-ms-office365-filtering-correlation-id: 4b88553e-52f8-48fb-a4ce-08daa126eea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Nb3JaPAm5B5Y7rX1KEowdHA2iGon42cxZ/RHBrq9fYdXQZ16XmxDZCgh2+8veblYv+Ij0N25VuUHbN4LK0wfT1RvkJM2anVhxnvJkcDpaSqoZKYhjUjY43/jpXWrKCIOhfb0bUmiwz4613dp/02R3VcplTowAQ5JuddKDMfRvSqerP0zJuhySCMOq/khOBR905AV6k+GCewn9vSMjkM5z/fxl7kN7MVcNeGvOEQgRSYQR7K2VBnE4rsnb/lROiw3dOJcnhSShgeXBZgiMB3Nh88A2+24RKoyGwE6HLlwh3TUwol/C7xRACaxwb+121rKiDKuUiUUD1qj/QRSsb4y2KuIejzzKGwnnPu53W6Qq6lPWaWPQ4P7WohZlVFZfsr2uyTI2XKxCOTLLH0YXnZEiOOq6jfOX5BdpK04tc8VhNg3akW4XmoAm3l5tUQnfvxIIUfJdomQV4CriCDF030m2OuJIhHqXYZ1XCDOfrNskkmBps9Q47VnfoocJe7mqWlksiATrsck5mwc+jmKDFTolctopobwWehzaBcMdfWpsY/6o9Ges4cccsiyoUB1hM4nk0NrmtE7mpzm1WrePG1jbjZdD+P/hxLz/VZfbRMPx36/G0EZfgPQSrVMP4GiPubqiRi8/j7jtcVXmRKQvA1bQg7F04K73R1j4yba+YAec6WzCZ58H2WOB23t/AZxeL+GTW/hSOTOEfoO6Zcvg/gsrWBr4Eibpd4bcqLJbc5aA3S8KUMSWNRNNwkd+FM6ZjCNkjO/2lUnwsgXK6LXnmnLg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(316002)(71200400001)(478600001)(110136005)(66946007)(64756008)(66556008)(76116006)(66476007)(8676002)(66446008)(9686003)(26005)(52536014)(8936002)(6506007)(7696005)(53546011)(2906002)(186003)(41300700001)(33656002)(6636002)(38100700002)(5660300002)(122000001)(86362001)(83380400001)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j010Tz+oyoFKlAtYutxDbRPAzw2ce5HKeF6OJSOH3LGSGv8IcDFfyz91twSB?=
 =?us-ascii?Q?kBRKNjv82ttwFpOmCKrbc8Zy0AA6S5J1P6SU/smOJNLUsH1sbQDP+ZWqvCnn?=
 =?us-ascii?Q?c3WSGTTiSLw+AKwLCJttry489+JHqmOowrnvVlNxZ8A+4BtNQt+8HCGOGgTk?=
 =?us-ascii?Q?nngIKtvaUw+Ux03jVMlJa7EHpEZVDYMii1aRRJq8eIkGWSC7RSX/aiMIFy8Z?=
 =?us-ascii?Q?QgfS6Id/UxlU8ld6mH+yKvWF3nfR+ydzhQ7/lIi8kij9P2C//lg0CvWb1Cw+?=
 =?us-ascii?Q?Je1bNxZkUuMiqZk6OUPqh+SF/BeF7PE55rjxaztrrurySabn1vxZVCff8ALz?=
 =?us-ascii?Q?xcOspw9L46hcX7OaSYxamYoF/IoSZ7exlXb/1yElG4LdwZO7ribKqUGq0OUQ?=
 =?us-ascii?Q?Fua57VadecXuhqZX2dWLF5wEiqZIl+FnJ+nux4AuHP+CK2lILHLB0S643m5c?=
 =?us-ascii?Q?5QyrcL7YRCLuSynFHrWbcDAWGrfNKq28SC4m8gbfdjstQKcVB2kxJ2Nw2XaB?=
 =?us-ascii?Q?EU3UOglEDA6tmxULI6dOhq/sx+G06fOkChiamVwENHU6O99cim7C1iE7z4ni?=
 =?us-ascii?Q?+DCGxG1GKsXkh2y+l6rrDYEEG4oZAYyo/zb1r4AKtXUH8DR+VGq7eO8MXTeX?=
 =?us-ascii?Q?2iC6ToIuCOmyUTEIJlgM7X5FL+n6CZ3MY299aeyblQ7GGjgc41jxrKzhHfMh?=
 =?us-ascii?Q?h84YcrnvFOp8XOYdYdBuZTZ0bBN84c6UCeua4/JIzikiGU7CgWK7HMZBkrWV?=
 =?us-ascii?Q?WxzU7zaFGXoLCvnqMEdZrTXkv/6J7pfrHHJ4jBIJQu07/uC8YFZYYPvLbSMb?=
 =?us-ascii?Q?yZBbTloO/ruhdjyTjjw80lgitXA0eY50GD4XMCkRtPkAsinTh/h/y4I2WoM0?=
 =?us-ascii?Q?rnglFqjfhm++AYwOKmcbl2XpZDVoeuFBBvF458C3OfG/Djdnt7ilWPkd4X8v?=
 =?us-ascii?Q?I2t6kW4K3E359btYFrHkKserHZbAnZLoXFYm6IOUEem3UhVhB/VGv6+9H0s+?=
 =?us-ascii?Q?Js8gn2CN1qQDg6Vu+qmJJwA1/F7RFmEx4j8zM+v0I3x5ov1ApdvFOlt4qOW2?=
 =?us-ascii?Q?mVKD+5oeAiwyKm3Vxp8UJjQzqqoME/oFlkJ883Sc7j58wFeW/vHxYF5MJqcR?=
 =?us-ascii?Q?xXqql4MsVt+Ei/9VPCAb7inDWfwcmkOjks70kmr7OmprBWfvkgsM94Pmrxgv?=
 =?us-ascii?Q?1pP8jYeVxAPR3VBQ+KEMnK+8wpLrY6mJbVtG1Lsh0DNZnXw+puUH3Qa7LUhv?=
 =?us-ascii?Q?vhhR4MrP+ZGY+ynYG6lg6pE2jRbCd4GdVf6ufdIJaM0DS230+p0PUDqhTftO?=
 =?us-ascii?Q?zyJ7pZ8khbzilKLo9yhUxwmASuGZBA2CsZM4QZLszhQ8hxbt6d1K0d4D65WR?=
 =?us-ascii?Q?ZhEJPQd3V4F/ZOe8YF1/duVuvWciXWqcTKudMlUROOjMXyKsNDNmfSFk969W?=
 =?us-ascii?Q?Vm91YJeNeNgc8cWOMZbTll0a9aSPfRkGl5i64eFkg8OUdMakQKSnt/c6Gjxh?=
 =?us-ascii?Q?aFk0zg/TKHHpOFl7k43BhK1+Iq1dHxE1nUPF4L1zHsvwKT77qysy7TRlxY2P?=
 =?us-ascii?Q?vhao84gYj09rPUJ0WVSulXMKBKabTv03rhaum0sa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b88553e-52f8-48fb-a4ce-08daa126eea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 07:56:21.0474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0iy2uSo3eRsTd5x1mh4KEJMV71G/jEyOyJmy3DMIyo9xcqPC8NtPVmNQFL4e0kkIyVKmVW/5XaL/BIXW/JC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6663
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

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, September 23, 2022 17:21
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add page retirement handling for CPU RAS

Do RAS page retirement in poison consumption handler unconditional.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index c7b1a2dfde13..9e98f3866edc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -756,11 +756,7 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(stru=
ct amdgpu_device *adev, bo  {
 	struct ras_err_data err_data =3D {0, 0, 0, NULL};
=20
-	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
-	if (!adev->gmc.xgmi.connected_to_cpu)
-		amdgpu_umc_poison_handler(adev, &err_data, reset);
-	else if (reset)
-		amdgpu_amdkfd_gpu_reset(adev);
+	amdgpu_umc_poison_handler(adev, &err_data, reset);
 }
=20
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *ade=
v)
--
2.35.1
