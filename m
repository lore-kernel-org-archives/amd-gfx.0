Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F9BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 01:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 331DF10E122;
	Thu, 10 Feb 2022 01:35:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B3510E122
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 01:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLOMIe4EJfe2l84Hh/5asTcCmPwdRMXNHgX1E7pgsLxeIPWcW6wGkrMzwM3VsUtzI4Gm66HCeX7mozn/9At80JtzUpg0NSWq0ejgypSCcJu9LBZFac7pEShxtKNZzmDCZwXxZVDBKfgFOcIxQGnSRqwktHqVxWkt+m/qK9X5qTdDL+VEZl+WDgMN9RksUyMG9Xkq8OH1zDeVAkZSYbH9AbC9n8RIke6GFzJyC44lBiIhv4+NpZqx1IwCcvb24A2+dHJVwoMhTEt+GX79/HK3kYvg1MK9q7yXdWX/ELpxLQszvbagrC+YhOgGRXVW632WkDVzdtdrN7bWL110LyYsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXyPupcgG1lDSiyCNqNVzCgGQX1PuoDGRV8EtsA29XA=;
 b=Cdrnkl3H5R95eFsF0EI4kSQLhd09o7nQhPRJrtubnKNNf0/CTKB5XrQeSxdC/TgucpGo+nk2mesJ32fmL1ozmI4vnMH3PiLw/MdjjhCyOMfRbeGUYm8S9oiXgWwZHc92+gj9i1CfMqRgS6gnnT5bIBk9sHnYMTl+WNtxobE81lkWegywvSUxqOn8VIQ5D3jd8ZN9tj7BneQqJLLmJaht7gyd7hYhDfbnDbcjvqDMB90SjKOLX0MXhjYfglvEyn09xiRQoabGZAozn29hpjOMjTNycYoLAlVl+CCI8PiX17YmcoAd4l1FE+jxtikWaT8WGaCeh5qTBiERUNIfhCEwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXyPupcgG1lDSiyCNqNVzCgGQX1PuoDGRV8EtsA29XA=;
 b=Zk8JN/zCvSf7Gu/dr1eshKEYWF5pUDGTmWr+Mohs/p5XaCuryZ2ibbpBQuzioMS3fX5R0p0vO5Y3E/vWWv44CdYLSsW0M3FYxTZq2qoXNCJe9zg+IZvwmCsYGR9IlnxHW9lPnetm+BrHF97c2iuQY9FGhZP2B2QZCEGPeuW6Mjg=
Received: from DM8PR12MB5462.namprd12.prod.outlook.com (2603:10b6:8:24::11) by
 MN2PR12MB3808.namprd12.prod.outlook.com (2603:10b6:208:165::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 01:35:34 +0000
Received: from DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::3584:bf40:7ed6:af87]) by DM8PR12MB5462.namprd12.prod.outlook.com
 ([fe80::3584:bf40:7ed6:af87%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 01:35:34 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode
Thread-Topic: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode
Thread-Index: AQHYHcGlbZFSPXkwXEGfuufRbGtUhayMAWog
Date: Thu, 10 Feb 2022 01:35:34 +0000
Message-ID: <DM8PR12MB546281A98E8BD96C8089F334E92F9@DM8PR12MB5462.namprd12.prod.outlook.com>
References: <20220209143022.1437127-1-KevinYang.Wang@amd.com>
In-Reply-To: <20220209143022.1437127-1-KevinYang.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f92c7436-6362-4664-b4d8-722e6dc12a36;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-10T01:35:19Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee7c9f6e-35da-48d8-47db-08d9ec35a23d
x-ms-traffictypediagnostic: MN2PR12MB3808:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3808781E3D1906275E5AE509E92F9@MN2PR12MB3808.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NBBZAWNeK43kPdXfEtwwB24mPZBlWvZBFTfUamtvuKo9OQ2iOPdOZJix8jPbR8T7HoQ8ErSzxReaR9R5nX5F3Bxsof1DV7rM7xBZ42iz8TLYcniM3mCCi//7cdOieSHo2a+WNNrTxGKworO+nHSwhuP2FHVTnSpwG4vjZTK/deNjOiezAZFTfFqzLtQmJSQjftdZehCdA16iHvEjBjEjdflsLp/CDD90jqnyP+kMoTH74Tb3IpxF4NGRvVgTJQmcEbaHJhcMbr7SxJy6p53Rk8qK9UYfnrnc3fbfmLx7oLUUXAJ8PwzHbEGCnlnOpzT+uC18IMZonGtWPX5qXg2baSsW5+oAYPWm3TjMbc+SMN47BjSa8D8eVg1ggtE6he8Fx5NS/yRY4rbnN0XDGyLF3MNlmnhr1xFDMjExyPdQAzyBPLvUauHOtC7pGW9gK1HFUw7txp1JZfbqw7Gt2L2X91+/j1IN7xwfPF/cU+Vpe3d0OCMv+ew+0B5D5+Y3pnWdkSOAgOjILaoenTWwA+W0Jri06BGt7d3oTJIFuWvXGpHA9osgLaSnKS/NexygnynIHewPFnhbyT/QfvC//f+QGaBj3B+C5MCoRuui6ALPJYPsh9wRDfOh8m/E85qaUACTP83CM0mOiy/OZTQiBPQKOkqTT6Fnap3v99mXikslpG6osWqCM6tlptoTNrqsabzsz9wVHQyXfS+1EU8YJ/C1EYh4YqUfNqcGrTQVXynIj7Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5462.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(38070700005)(52536014)(8936002)(5660300002)(8676002)(4326008)(66476007)(64756008)(66446008)(66556008)(508600001)(76116006)(9686003)(83380400001)(53546011)(71200400001)(38100700002)(2906002)(55016003)(26005)(186003)(33656002)(86362001)(110136005)(122000001)(316002)(7696005)(6506007)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BP3w9Nxb1lqQuwFF5vc3G32r34lNCWiQhif+jHfjntt/04ythw20DyEBsjbN?=
 =?us-ascii?Q?3TL8iNkp0BLAXBeF2WFw/b0BdGjlnaXZ0NF4zkcqNPEJHEVr/Ewy6sDBo+p0?=
 =?us-ascii?Q?D/g4ifmy2OBAHachM8UTyvCtBKHX0nOt2BZIiCIq7fE1kMBsyqy9CTEs1+ol?=
 =?us-ascii?Q?BKSF1LmygVhcBbcmSpVKgE1gdun1M/gtgViRX5uVdgilT7OxncLmk2Gv56Y+?=
 =?us-ascii?Q?TutZarpp+OsvZc7s9XSrNmppOcePfgsgZ9q1duZiHn7NHQ0deWoPJSI5tq99?=
 =?us-ascii?Q?HtHC7fNL01GIKq8vqCn8jReXGvKS/YgrkNSQI4uAmwlszuf4g2SePjJr4t0x?=
 =?us-ascii?Q?B9K1OEeWGJWujQzu/rAJr5WrzMt5FQJ7RlB0iUUN9UF6VWwB4qxFAsLZmvww?=
 =?us-ascii?Q?h05QlFE0q39Lf0lICslTMeruEx+XworTqtCZzEUa1D3UnoKp2QRABI9NgGqF?=
 =?us-ascii?Q?hPxGwO9sO8Rlca4j+GrOyhPBwlWZupKm4sksDXF0ejvbHyVHemKMiYFjMyhl?=
 =?us-ascii?Q?BIMqk0S+6JHVvYRXWj5knqTE9zQh26S93Wg1QArQ5CD2A8Sj9YJCQ5yshG1t?=
 =?us-ascii?Q?l+bX4D8YptGX127asWFpd9QBDAL5q87eEEjYM8AXCa4U6xc4RYfrHjueAMGV?=
 =?us-ascii?Q?RxmZaEDXHagEJ/lFOnw0u9X2DUM1ApSUkJi7EoZuuVBOTpxhRsUAWOkabU81?=
 =?us-ascii?Q?wHn+4oZAxxZ4IBJaAy7yUCPNxM5CD7vitgcDZddsfruHsFvwu/eKaUQrzNRR?=
 =?us-ascii?Q?JQ24taM5hJHYVLrJNJhd547nou5OE24MBvLrP72bQcxyoKagcHt0iGBO+mVK?=
 =?us-ascii?Q?y+L6YO7zhymkgAYcs6K/Se1xHmXGL0JZvNdQsAA7SQSTRtldEIvDU0KCkx4U?=
 =?us-ascii?Q?PQ34FToouhg43CzXxvy0gqLZBZI9Xae7GpmWZAKuUPNmVt7wzwvtgYFID+en?=
 =?us-ascii?Q?FazeDLG6ZjoHrXNVSNKLhaBn2ODZ3sZgci6dt82OaLXhu9R//s3OJimbwzJV?=
 =?us-ascii?Q?KLW/cDMYb4n0CStP1Iar6sKCxcEjdezPs0f3YNbjcvPNXIDkC3WtCG1SHST3?=
 =?us-ascii?Q?432BctOD/F1lU2jlzdPoxXDHkUvrtza35jCgNaQd4XLj6hguxMCgAl7su8AH?=
 =?us-ascii?Q?Dzn3CU+Fv492jfafnggEpc490KWHarLrf6RRwNZIOY+GZ0s8obGQqYstT4ku?=
 =?us-ascii?Q?uluzAbdX9SSaZ9d3mY3Xv4jUiOvixv3LjXApLSgKGJeHtnUk6+rx8V3r9Dw7?=
 =?us-ascii?Q?hUWIF4O4N3NkHDBe1WTj2bliJNI1G0+N5g0EhpsmyIhnQCvsKbVqWSTpfz4C?=
 =?us-ascii?Q?vQQpQk64qNca8vEpZPgk+q+3Xf37YIprytxVHxcCfL+1s64MB3WYctY+EGw7?=
 =?us-ascii?Q?CdCAMGpnJVnzc1MekUgcNtvtq91Cax9VOyd3aXF/xnE6YaZhvu7TK7PcHTyM?=
 =?us-ascii?Q?XrDywVGViXs9LWx//GvmD/qhRCGY5RkR7e2l7hs3hq0//5jwxPs+s+Sr56vK?=
 =?us-ascii?Q?3NpFbd0QhWCpPiy4661olUZ46hzax1i92Hb42x44eW6TrcUzH905iaHNPVZV?=
 =?us-ascii?Q?+PjRGl3Vs7dMuXKKhfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7c9f6e-35da-48d8-47db-08d9ec35a23d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 01:35:34.7576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zyqmh9Ivl4afjViOGlKsS9iO2o1HJ+j02S8UufaDVVeFVsUJ1Fv9X5XGWJdFyt1c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3808
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Kevin,
This patch looks good to me

Reviewed by: Frank Min <Frank.Min@amd.com>

Best Regards,
Frank

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, February 9, 2022 10:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Min, Frank <Frank.Min@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: fix gmc init fail in sriov mode

"adev->gfx.rlc.rlcg_reg_access_supported =3D true;"
the above varible were set too late during driver initialization.
it will cause the driver to fail to write/read register successfully during=
 GMC hw init in sriov mode.

move gfx_xxx_init_rlcg_reg_access_ctrl() function to gfx early init stage t=
o avoid this issue.

Fixes: 51263163eb3 ("drm/amdgpu: add helper for rlcg indirect reg access")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 +++-  drivers/gpu/drm/amd/amdgp=
u/gfx_v9_0.c  | 6 +++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v10_0.c
index f54e106e2b86..3d8c5fea572e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4343,7 +4343,6 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *a=
dev)
        if (adev->gfx.rlc.funcs->update_spm_vmid)
                adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);

-       gfx_v10_0_init_rlcg_reg_access_ctrl(adev);

        return 0;
 }
@@ -7682,6 +7681,9 @@ static int gfx_v10_0_early_init(void *handle)
        gfx_v10_0_set_gds_init(adev);
        gfx_v10_0_set_rlc_funcs(adev);

+       /* init rlcg reg access ctrl */
+       gfx_v10_0_init_rlcg_reg_access_ctrl(adev);
+
        return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index ca7b886c6ce6..744253be5142 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1934,9 +1934,6 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *ad=
ev)
        if (adev->gfx.rlc.funcs->update_spm_vmid)
                adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);

-       /* init rlcg reg access ctrl */
-       gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
-
        return 0;
 }

@@ -4755,6 +4752,9 @@ static int gfx_v9_0_early_init(void *handle)
        gfx_v9_0_set_gds_init(adev);
        gfx_v9_0_set_rlc_funcs(adev);

+       /* init rlcg reg access ctrl */
+       gfx_v9_0_init_rlcg_reg_access_ctrl(adev);
+
        return 0;
 }

--
2.25.1

