Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD37C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Dec 2021 07:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43F310E3C8;
	Wed, 29 Dec 2021 07:55:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463E610E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Dec 2021 07:55:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8OHb4kPm/SXtzgOxefseXiKQUPPjelQqy0acOZrHLm26NnTUktuH6RM8NvReyEiSXeW9/Hfv1xvf2yX+bpSrhZgKPeX3ut93DZkfl7p8lPkB3zwGGsZBHJz69og3Jt0uc38g2D8/vjMPzNtjW9ahELRBcIuZH+9IFJSGnZgSJbdQ7Z4Vsh370L14gAPfW+e01fy0IxXmddgTyB5RzmeLwCowoEir9RvWNcQwx8IXgLa0Rt+Knp2zpqOdfnuTpJut2SVq6PrhLUTOGm34m+AKM0rGmyDJL/y9RDvmXnKP36u9g05BPL5bTx/iYRUKmEbp0n8YTb/msKKxU7WEMA7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WG6mBC5kSrfeLluB5alZWj6V3Nt40FoIfveJVfqvYfg=;
 b=OY0yMHG8V4gR8jVkLBdXPKW64xLJTGsBbXLuYNPmfoAkK9jdwKfhpuOGfcrEI2T93nj4mPqAMD2ulgIkZafz2DpDDylrQ3s3FKOD6VwB4P97MkVf4MQ+jNEbSe71ubBBI7Ku3in7dAGtJK2GydC33Gp/YAL4vmohO3s3ENBnjGMF6xcj9MVEE1iExkDFbN4r+XVI4aal4F2PRHz0iurJGInNQQ9fkL5/d9xyag9RsRSxOFJxvoIAP/kpVBs+be36edkJgsQp7iK05DC7Bor+PJfQJbwea/zpVD1FKZQ0v/JnRwGA35XOhd7ED9z1ordM1T9R6i9J9EZK0P7nVH1isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WG6mBC5kSrfeLluB5alZWj6V3Nt40FoIfveJVfqvYfg=;
 b=4O2zcVgWr4v0ZSBHPAWGOcE4v8zG3ja8QNouBJPnYYhaF2D4I9iFGRKkEPwwFTuWXSY+N+WAxS3am6q0mw1v2c77gQtAqiLtL7KVPjK+BdCoyFM9VtXzAvhOTE1Zjp3bJQbBXCDVju3LtoEcIL/rnh0TEEwnD3vgduquP4UNs1o=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.22; Wed, 29 Dec
 2021 07:55:09 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f124:4f19:716f:e18%5]) with mapi id 15.20.4823.023; Wed, 29 Dec 2021
 07:55:08 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, 
 John" <John.Clements@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code
Thread-Topic: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code
Thread-Index: AQHX/H37eYsNJnzWO0yc2Ad8/caPOaxJGUWQ
Date: Wed, 29 Dec 2021 07:55:08 +0000
Message-ID: <BN9PR12MB5257CB71A765B613DEF6F728FC449@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
 <20211229063211.43840-12-YiPeng.Chai@amd.com>
In-Reply-To: <20211229063211.43840-12-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Tao.Zhou1@amd.com,John.Clements@amd.com,Stanley.Yang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e546ec42-e9a1-4d75-94a4-68de4fa4df92;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-29T07:53:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d2a82c-da38-4753-421b-08d9caa088e0
x-ms-traffictypediagnostic: BN9PR12MB5065:EE_
x-microsoft-antispam-prvs: <BN9PR12MB506519F95CC30833E4AE01FFFC449@BN9PR12MB5065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:334;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VrS2LWboX6tNg1EgDAFaoXDJmi4khFnv3s0m1NKKlJwxU7fE5agBdl+vPk/FR846duxzf81gC3KN6VseUlZmU06Epph/ScRLG/rQlE2PrEkVMgRw9L3N1Ztk3zqnwSkr9nUnvLxU0zw2IQ0tX6boDltcULHVyTyqrEM0CHbv+d+1kMFtsYQO2smf++a0npdL7X4tBV+ZB4yq/FtVKd38BbxietshLyNm1wuiJMkspgbDyhisDjEOo2eu0UsfmZKAgTbrg+grMh+A+5aMwn/f+OH/Av/0VkTLUQ56VEtihCyQ1LifRxZInPMHnVnNjRxi3BuNu9eBZvZirrjr4B6f3F2ZefVTc20c8RoDWUwKZMTFHJKhcynBF+KFvQhOWUUyLcP7N8h+KlJjClrdzSC9QQRFqT8Wbrr5ShZAqZQS+dMt0WdV/CwOEsVN3M8Rk8AHKLa7LEX+1O1OM05pbuiyUVufF8x8veOvhE9/qgJaPAK08cXGGRfgt+tW/5/bqoPghW+NQAT7Bv3o3GW1C6v02jXDzm41PCCLUZvi0kT86S2F5HgRMa3BC6btHia6nLKPkBP1GkYZCROVWj4BncO1QS9Kp6RZSwOTkjSrJxd9nul/F+qkZQPQUdpp0wty/A/prN+v3dA5UcU15ijVORWu+WLjHkB2nwANzCRFf+SFbM+JUETYKAynvlEQ1ZViVL2jg6Fqu0At8eWPF6ZZituA0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(53546011)(7696005)(86362001)(4326008)(8676002)(508600001)(38070700005)(186003)(38100700002)(2906002)(26005)(122000001)(9686003)(6636002)(110136005)(71200400001)(55016003)(5660300002)(66556008)(66476007)(33656002)(66446008)(76116006)(64756008)(66946007)(8936002)(54906003)(52536014)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Uy2obMNnxVUMnKDZOD16oSTuDJIwuL4xzcvFLJuDEJDxlFlFN5uGe8CAD8F?=
 =?us-ascii?Q?3Z9KWJ/7rcig4v9A+ql1AhHWhOBpedZWjGvLpd2UM9WTRuUU7v5Yb9benZ77?=
 =?us-ascii?Q?pVD1fe/V6syhUozy3waqPNqD+tzJMWwtoXAvWv1JOI0mGY0CAdcPLQUpwHip?=
 =?us-ascii?Q?k4fNWCS4l/XCM+JI7H2KmagWRrRfISbBR+Y1Jf6hFOdFAQU35iHuJjmDUdrj?=
 =?us-ascii?Q?DzMGr17KxZTa95Y291FJkQT8nX2PQRUufmnR8K7tOF3DBsbEdYZxnpZu3pRp?=
 =?us-ascii?Q?Ax0SGCbBNYUT0Km62LPSt4DJwS4zMaqHco2Sa/Y3voY5Y+GeOfw1w/jnWWhd?=
 =?us-ascii?Q?3L1ZY99N8ZqRgPurLgL1L2luQ1CShYU39CDgR3heYoS4hdiDOF2ohLmSRM9Y?=
 =?us-ascii?Q?mzK+3EZRPIGhWhr206zvc3WvPdGXj+MFeUsEENT7DtNCtCYanTcp+5eftqho?=
 =?us-ascii?Q?CM/UbnaY7JjPsReyPTOlglEzN5YHkhHSz4Ygb1tIyPJmPOAa6sbcHyGFsoCQ?=
 =?us-ascii?Q?aJhyYxcr8dut0Aj/c55yqDJgT8cG2vJR+3dBIRsf655bnOq7mKNIP62Se9qe?=
 =?us-ascii?Q?kHFLJFvcjEr/zVBgE5XLEXedRWs+rj839VYrsxzMNdvWaf12BZ5X7G/5gDhB?=
 =?us-ascii?Q?9ihF4qpalNNk9zewXWg3UU/7cGOHoEJpZbl2d904UNHt/u+tSgFo+JTwWXrK?=
 =?us-ascii?Q?h/hktyJEY7sa/EkaawUyfBw8Cgs5JWygAoVwbgKQ01ijekdqpS3P8doWhkRb?=
 =?us-ascii?Q?xIi5fDmKzQxB6liHFoMDuUJdp6yVGw225sVEY/9utbN+Hqc5PS54ALUE0WJy?=
 =?us-ascii?Q?csXJK8FUdnHeFxoJDQFVNchEqcVO7MIHJlG/6SctnUnHF5TRpA6XBAtRw+6u?=
 =?us-ascii?Q?XqYr2BzYs/Ps4q5R89mDx0meewIS9+gSxqYEHdU1qi6z4XPWByHXkkIsA59B?=
 =?us-ascii?Q?EgvTI+MRSInGEaMvqbY9TkRSp4AdIqi0UDSdPGjgfqDDsyke5/Yl7zJB1h9m?=
 =?us-ascii?Q?4QiJTWoeSYKokiPQtnkk/nNyXvVGNifx+PjvivtWY7pJjGv0ZfeT4gEVNwGh?=
 =?us-ascii?Q?2OclL5a58/f7OhjMRgR0W6bsT0yKanDlPgXtQyGVZWTrrVFXfTwd9IXlg6o7?=
 =?us-ascii?Q?1dACBwQSNcpdyd0kYrBlBMTeHhx4A+cjcCncH66rASQrdG4enVASoOSB+sEw?=
 =?us-ascii?Q?8BEICJnS2aBfN6C8FjjxjUWFVzzHUaR2C54IKs+ly5xOE4j3r6Pi7b763ssa?=
 =?us-ascii?Q?X6k40O91/zPfQHTU4MOAHGsFSOMm5FXsB9F+sC8X7CVIzUBLjZWe3QH4zI4O?=
 =?us-ascii?Q?0mmgC3hiRJV1tmTcr/F2KEIPpyUeLzGeEHmRVkM0pBbeBNhFDftrPYDkIYa9?=
 =?us-ascii?Q?MEfJLeOBtISJKxy7H8Tr/fy/gclgYNpB63tabQuqadsDDEjHPBXzt4rDs4Yk?=
 =?us-ascii?Q?5QJsksdEVd/HaOcnwgtqxIpbyY+toZ3HnZMnk4xKNRANO4S+ro0QV3+VthVz?=
 =?us-ascii?Q?HPJJkVFGZO/2TIuAp9E7H6WG2tCXOu8GpqLR3p50HfqbDuoUC9vUUHFafEqm?=
 =?us-ascii?Q?4TWbyuog73SNrXwv9b3BVe+JgKoMQePoYYa6mgHtNNe6QvEDHQr/M6BeQHXp?=
 =?us-ascii?Q?WFRk/66JUDaDf/WwquR86oY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d2a82c-da38-4753-421b-08d9caa088e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2021 07:55:08.8206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +p5b77RtjHspGbFHp+xPiNtMVThnOntgMLrRZgoZTy/q46J3zl1wx+/FPjDX3EZOJBG1hjr9DW83D2NiX65kIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thank you Thomas. V3 looks good to me. @Zhou1, Tao/@Clements, John/@Yang, S=
tanley please also take a look and raise concern if any.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Wednesday, December 29, 2021 14:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code

Removed redundant ras code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 82 ++++++-------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 21765e05b003..17de79be6d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -910,51 +910,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
                return -EINVAL;

        block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+       if (!block_obj || !block_obj->hw_ops)   {
+               dev_info(adev->dev, "%s doesn't config ras function \n",
+                       get_ras_block_str(&info->head));
+               return -EINVAL;
+       }

-       switch (info->head.block) {
-       case AMDGPU_RAS_BLOCK__UMC:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                               get_ras_block_str(&info->head));
-                       return -EINVAL;
-               }
+       if (block_obj->hw_ops->query_ras_error_count)
+               block_obj->hw_ops->query_ras_error_count(adev, &err_data);

-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
-               /* umc query_ras_error_address is also responsible for clea=
ring
-                * error status
-                */
-               if (block_obj->hw_ops->query_ras_error_address)
-                       block_obj->hw_ops->query_ras_error_address(adev, &e=
rr_data);
-               break;
-       case AMDGPU_RAS_BLOCK__SDMA:
-       case AMDGPU_RAS_BLOCK__GFX:
-       case AMDGPU_RAS_BLOCK__MMHUB:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                                               get_ras_block_str(&info->he=
ad));
-                       return -EINVAL;
-               }
-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
+       if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+               block_obj->hw_ops->query_ras_error_address(adev, &err_data)=
;

+       if ((info->head.block =3D=3D AMDGPU_RAS_BLOCK__SDMA) ||
+           (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
+           (info->head.block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
                if (block_obj->hw_ops->query_ras_error_status)
                        block_obj->hw_ops->query_ras_error_status(adev);
-               break;
-       case AMDGPU_RAS_BLOCK__PCIE_BIF:
-       case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-       case AMDGPU_RAS_BLOCK__HDP:
-       case AMDGPU_RAS_BLOCK__MCA:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                               get_ras_block_str(&info->head));
-                       return -EINVAL;
-               }
-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
-               break;
-       default:
-               break;
        }

        obj->err_data.ue_count +=3D err_data.ue_count; @@ -1016,32 +988,18 =
@@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
        if (!amdgpu_ras_is_supported(adev, block))
                return -EINVAL;

-       switch (block) {
-       case AMDGPU_RAS_BLOCK__GFX:
-       case AMDGPU_RAS_BLOCK__MMHUB:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n", ras_block_str(block));
-                       return -EINVAL;
-               }
+       if (!block_obj || !block_obj->hw_ops)   {
+               dev_info(adev->dev, "%s doesn't config ras function \n", ra=
s_block_str(block));
+               return -EINVAL;
+       }

-               if (block_obj->hw_ops->reset_ras_error_count)
-                       block_obj->hw_ops->reset_ras_error_count(adev);
+       if (block_obj->hw_ops->reset_ras_error_count)
+               block_obj->hw_ops->reset_ras_error_count(adev);

+       if ((block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
+           (block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
                if (block_obj->hw_ops->reset_ras_error_status)
                        block_obj->hw_ops->reset_ras_error_status(adev);
-               break;
-       case AMDGPU_RAS_BLOCK__SDMA:
-       case AMDGPU_RAS_BLOCK__HDP:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n", ras_block_str(block));
-                       return -EINVAL;
-               }
-
-               if (block_obj->hw_ops->reset_ras_error_count)
-                       block_obj->hw_ops->reset_ras_error_count(adev);
-               break;
-       default:
-               break;
        }

        return 0;
--
2.25.1

