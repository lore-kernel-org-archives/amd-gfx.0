Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77A0C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 21:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 781B310E079;
	Wed, 24 May 2023 21:19:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A005C10E079
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 21:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQomkvO8BcAr/l956P+vhXU56aaNtYARiksh7bytefbBbbtl7pZinZAEbjwXAawVI3Dt0YHXbJcOl0+3cRvs+g/rVmfW5hDdH50BeawRcZTtvCMOab0QUydry7vR/HpyzsDKa4feoaPkfwR9oYSmyAlSdgw+XXNNWAmrboy7tIsbtpswX6yrTn7rjZtDY6DiOdXk5/6zf6UGlInl972DN4JOnuVmLQr1y1GZvQMzYb6F/Wayao7uBvs++BeTHmqn5vhePES1AAb6BHAqpW268TNt3y1wCYeihQcn65+/auN2hEgnD6PvTBomz0eGrR9qv/whdtEHnUkTT/iLxdVSCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0wb3vqu3S2T9SeOhWGJjdt995MOwcLjhZKKEwsaBqk=;
 b=cZEUdeKv5t4QsIuNCV3fP/Vlc9DDpsXypBq4MUNDcV0B2EZ06meA6ZMEC6eG4okxwz0kwWuBZ5px1YnSjoe7ReLUYB3cPoaK+6R2RWmHulE5UrOqPTUoiK87CFUuO6j/ojWTvz+YaXLqcLS08jcrMbNaY7whqVN0uhap1xGCupAuJrws6JQoH7dAvvatJb2iznDecm+cjVjiPC8ybRRVCB6ry7ZYDhpOAlH6b7pbkQA9droF3jQCF9RdsFWx5h/8H2gKpm6SToWrYwfom2ARQBht6+iZv8C0XFQMMwBy73ghCmCJk0reMjvvB2wyCX9U7dO50FU/W7o9ZS5YJeerEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0wb3vqu3S2T9SeOhWGJjdt995MOwcLjhZKKEwsaBqk=;
 b=fG7N1huC2v1QnK78C57B7rwq7ADgmPqb86wsrCK2fABof0DyiAGCB5vUrUu19odk1C52+AapMHtDgICHtKmsF5JJ7q+U/EDNo6Iv0qPRAKUc+hj1e3KbI+yrGXZIxgBM3q3fmAXI9+dGP2gqAEVKfZc5KykUsP2fsKV6mZfuGdk=
Received: from DM6PR12MB5518.namprd12.prod.outlook.com (2603:10b6:5:1b9::21)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 21:19:52 +0000
Received: from DM6PR12MB5518.namprd12.prod.outlook.com
 ([fe80::a5d:b360:b6e5:c3b8]) by DM6PR12MB5518.namprd12.prod.outlook.com
 ([fe80::a5d:b360:b6e5:c3b8%4]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 21:19:52 +0000
From: "Li, Ying" <YING.LI@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/jpeg: add init value for num_jpeg_rings
Thread-Topic: [PATCH] drm/jpeg: add init value for num_jpeg_rings
Thread-Index: AQHZjn9B/r61jOJJCE+AZJhABeYUHq9p7bYg
Date: Wed, 24 May 2023 21:19:52 +0000
Message-ID: <DM6PR12MB55189AE865B09F04F50C3086EF419@DM6PR12MB5518.namprd12.prod.outlook.com>
References: <20230524203504.3568374-1-James.Zhu@amd.com>
In-Reply-To: <20230524203504.3568374-1-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=53e4ae42-8903-4224-9754-2890ef62f794;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T21:18:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5518:EE_|MN2PR12MB4062:EE_
x-ms-office365-filtering-correlation-id: b921b99f-85b6-4703-3d48-08db5c9c9d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8BJBMG1ricGFwro4xMyJ7M6NXDcGZ3KdXwKxXRxoul1YEJ5Xf94BAqIo1ox2l7xkA3d3hPLFsSRZ7TghnpgRFR3Q6EuVEikF07dSK1dpnPcorYYZ4Q0UZ/p+yFfqui4iF4epUU2pfGpvTKPMRQHA2DIggEkIUy9QiIPWVHPTCbGD5/EuCXWIy097lt/5oH3rqxI7b4BZVLo4U4w/msYwNJLu2L9N/GU5If0c1sigDem2A/P1useCw2mX8eMj/Ho8IOV/+MpWLaPbWDioh8NPcX4iEnip0tktiOyJNpS5UL3fAt2QJqYIhZha2bjOOlYGJnUP1Vt39X4YLffsPSQbzwotzZsEPVq5HtEEbC71d7UF7bVwjq48GyAdgCo135G10IwyKmSkth0ZpfSuD3HhClI9xjR5yZbk88B7X7o4ohYxBRGf99JZ7RAdqY8JXCEE91cR5aoy+KpKWGAxEYy442G3JCn6OabRk4xNdArvntKScWT9CJQVT+GqPJCxs29WBgfQlWk6xIZaIvuWCty8hhVIJZdTqvHMtWgp+iYGLh6vmM+c1bbh9YtC0SlTZc8wFEHYrg7qkQVSFRywZDMt01iDhbGA2rjBsh1ZOAJ19+2xpyks/OSthIgtBCDb3reF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(451199021)(8936002)(8676002)(52536014)(5660300002)(83380400001)(186003)(53546011)(9686003)(6506007)(86362001)(26005)(122000001)(38100700002)(76116006)(66476007)(316002)(71200400001)(55016003)(7696005)(478600001)(66946007)(41300700001)(66556008)(4326008)(66446008)(54906003)(64756008)(110136005)(33656002)(38070700005)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JQ+/c1+NCjlL3v8YyeCAWvHc0eQaPwbWZPDWz1kA2N4j8zMtJm41t939aPu3?=
 =?us-ascii?Q?mlzr1yvwXNYO4QO//Lc0mXL2cxgDlheXXKnP5weQAWqKuidrlq/h2unSgMF0?=
 =?us-ascii?Q?pG0UJnFixewcjeYxEfsuNfXLA9O6OjYRbz51w0bJzyoitxeDFFBE7Pxe9wUf?=
 =?us-ascii?Q?/PqgxYNUfBlC/1jbwbIb6+dbRK1Zk4N6LcwDSlj/zM0rOVVJyhUSk2YVJ6GM?=
 =?us-ascii?Q?t5Ojvrrspf/IQW4Ednoa4e3aA4mH3EP9rTeU+4fOxqF9abgWejmZa25QYyB6?=
 =?us-ascii?Q?CWm994uFkBA3K+xT3okL8nMkR3srqsoJroSkC8womqWbbMVqgucq6NLmzxkm?=
 =?us-ascii?Q?Ts4Pe2F8tS+ph64mP3R5zobEXQcd9HTlDstmMqwpXroD1Dczh88S2dj3QnxL?=
 =?us-ascii?Q?3SYZuV82CmUXYj1RjAz9Du3rY09jSQ6momHVuVw88BFhx4uZUL5ivgZQ3jvv?=
 =?us-ascii?Q?Qyy6k15ySo9dGZ3OLSIM5/1n9JicsUF0/7O//DbVvtld7YRuQGW7D+EAwMMM?=
 =?us-ascii?Q?ZQV0PjTrGxygkScU+9Rxa2A2XOnf0qIyAQC+rAw6Ye0yP6DxS7EEU654e9IB?=
 =?us-ascii?Q?30uPwR7JiE1B8RKXcFTt3mlxjnI96yWoCvt1zt9VRUOV24eMRFdiY57WWUIY?=
 =?us-ascii?Q?RC41uPrMEHoNQW6SQ5rR+tZnfgC1BuLLee7vUNkuoIbYRjNnfFVyKg3CVFDE?=
 =?us-ascii?Q?52pbKDkI2juVdCgqbZL2iRXTRvwMh+Jlm9pT7gq5G/ITB24LIApuoMCBCdXG?=
 =?us-ascii?Q?6k5NBHEZFYdGw3PyAy6ko+7x9FEhkKy65W3YV+O1fkT03TWV6WarB6UHGikZ?=
 =?us-ascii?Q?AFbpvdYgR3tJ/05Qea/shiREBvNb+LP1/OHRgfO+NA0NF/rEwEcR6bPTdB72?=
 =?us-ascii?Q?tPHqur2tcTcNTIvL4ZvI21bl6BhvnIPXYs5X+JpkoLRVw+DksaTJfos+kUn4?=
 =?us-ascii?Q?DvVjsbtJQinNbt8Z3daBDSq/6E7ZQfbZhllEJ4qZChBAi9AZ3UD7uc9T+g7J?=
 =?us-ascii?Q?kKy8KEzBwUn66DrTpgmjmzhumAaQzbUy6qBeo5OpVYdMu/8hFvkbBf63iwte?=
 =?us-ascii?Q?VYHaoyqXA6ZPvnjcXIse2Ss3NxNqkXevIfEOj+w61IcEVTrZo0aYQSebfMhQ?=
 =?us-ascii?Q?dvLJrCikPfbcymST6+Pnwjx90CqfwyN1fqE2HLEm+v6rSAQS3tMlTMeOxBze?=
 =?us-ascii?Q?ch06QkRSFW+HfHTQCyCTPLBJ++jdL8gijbb82cGs0vFI2ffBAde6Jh3fV/gr?=
 =?us-ascii?Q?gc2ZHC+fOPVPBklPYpYh2gDk70YsXok9UtbnyxTReEA3At+G4ht2uvWpV0F5?=
 =?us-ascii?Q?xviaw6PI46VXolW2cspkbMTmj44dgB9xeVdQtRmviiwpkMHKiDv9my2bxxSu?=
 =?us-ascii?Q?7dBGiMgVO7IWzoTfYXVI3fBqcsceME8rcwLqhbbc4+fYbsxh1bEKhq6tQpsg?=
 =?us-ascii?Q?q++T2QNo9y4Sg+bfqhdKfhzR7/TJBZGjgqyE/AY+nkHmMjKeycKhUXMXwoDm?=
 =?us-ascii?Q?gLiR4AGLWIk9AtHPci/KxrLX0XPLY/MCukLhS0yNlWyALBBk9o8sLSt/41oA?=
 =?us-ascii?Q?75iPNDZF0dgYZbUgc4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5518.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b921b99f-85b6-4703-3d48-08db5c9c9d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 21:19:52.2762 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTldGMHPweckBBbku8xt2R82kkQYIuekakbK9HZP0WV6qSF8+u19Re2NALguuyVHXZN/wFHkPWuHHwsEjc8ADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062
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
Cc: "Deng, Bonnie" <Bonnie.Deng@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Wu, Jason" <Jason.Wu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Tested-by: Ying Li <Ying.Li@amd.com> for the patch

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Wednesday, May 24, 2023 4:35 PM
To: amd-gfx@lists.freedesktop.org; Li, Ying <YING.LI@amd.com>
Cc: Wu, Jason <Jason.Wu2@amd.com>; Deng, Bonnie <Bonnie.Deng@amd.com>; Lian=
g, Richard qi <Richardqi.Liang@amd.com>
Subject: [PATCH] drm/jpeg: add init value for num_jpeg_rings

Need init new num_jpeg_rings to 1 on jpeg.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/j=
peg_v2_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 1 +  drivers/gpu=
/drm/amd/amdgpu/jpeg_v3_0.c | 1 +  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c |=
 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v1_0.c
index 1c5b60604a19..77595e9622da 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -460,6 +460,7 @@ int jpeg_v1_0_early_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v1_0_set_dec_ring_funcs(adev);
        jpeg_v1_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_0.c
index 3aeeceae34a5..c25d4a07350b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -49,6 +49,7 @@ static int jpeg_v2_0_early_init(void *handle)
        struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v2_0_set_dec_ring_funcs(adev);
        jpeg_v2_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v2_5.c
index f533ede484d4..aadb74de52bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -60,6 +60,7 @@ static int jpeg_v2_5_early_init(void *handle)
        u32 harvest;
        int i;

+       adev->jpeg.num_jpeg_rings =3D 1;
        adev->jpeg.num_jpeg_inst =3D JPEG25_MAX_HW_INSTANCES_ARCTURUS;
        for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
                harvest =3D RREG32_SOC15(JPEG, i, mmCC_UVD_HARVESTING); dif=
f --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdg=
pu/jpeg_v3_0.c
index cb5494effc0f..79791379fc2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -64,6 +64,7 @@ static int jpeg_v3_0_early_init(void *handle)
        }

        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v3_0_set_dec_ring_funcs(adev);
        jpeg_v3_0_set_irq_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/jpeg_v4_0.c
index 86383fbf9358..a707d407fbd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -58,6 +58,7 @@ static int jpeg_v4_0_early_init(void *handle)


        adev->jpeg.num_jpeg_inst =3D 1;
+       adev->jpeg.num_jpeg_rings =3D 1;

        jpeg_v4_0_set_dec_ring_funcs(adev);
        jpeg_v4_0_set_irq_funcs(adev);
--
2.34.1

