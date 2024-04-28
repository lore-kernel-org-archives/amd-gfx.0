Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAAAC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 06:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A0910EBA8;
	Sun, 28 Apr 2024 06:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6JintfU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EC8B10EBA8
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 06:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCoDm/tllEeZMCNn0Q9ApMN9eSpH3cw6AqiHFmmUeX7M4VOE+wngirzXWTU6eA0kGT8QL/ItJwO0dDJCN1KX4NMthCBRAnYTWaiG2xQPcoQswQaAPH8bDFKShCp6NroCc+j545XE5pMNHSLQVrzL1chV1S6XW3ZpY8ebV0dMku5vScsNTbHlHBqtQ+MIyJfRaEBIeXkfZbuuvS4/FKEIv7hn0qCYGMwHNV66fsX0abC+UKcTEYSFz/wNucKkl0A6O4JU7LNUBqeV+1JehrK+4/SFFvtUCQDapSn/bQQMXdoxaBk+rrnjo1ZtQP8hDaJ0WSkM6N6rErrUpUyhwmKNjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO/IcwDBLPYb6eqPL7BKa9ZkCGkdDNFgSXOHOgdrGPM=;
 b=nuBZwcPM7oli8NpkNncK1c9eHK9O9jiFQLWzB6693SI0sTyTpe9tH/NFKH6H32iavazR21VKbXUtw9KQlXT8dzqf33CckZ5PYPDKEJDluYJVks+bM/9tb0+YXvryvcB/DULBQ/k4CgB8tfl4aqdqX1Y+dNIgBhdwn0AJwtAv4gftDojQQtxJx0nyMv8MFPZtaYwMpKP7ei0xzENh88fawkHFMnTKjx+akodvtsGmWnfHBaurK9PPGsCl3TsaeiD4VhzqfNgM61UPV5hux4eNaLJl9dbrbhBv0S7QJ0FfCnZrLuB4aK5xetBnEP2Yb889S0lIyU5RWWIcA5RoexQj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO/IcwDBLPYb6eqPL7BKa9ZkCGkdDNFgSXOHOgdrGPM=;
 b=x6JintfUx0uOi90H5TiXs9lkK/YJfhveCVId9CJ53TD1BOyeO2ptQuJrpBVn0aP1ZvARoB3JeHQL2v9nmSi6ZEmmUhLlsbut4camhHc9FFkxF4uHXqzKDR2ZOt/biDozO/PzF5f8+t/Hm9HPf5gbpM2U4/0tJDLv4SqvD/mn4hQ=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Sun, 28 Apr
 2024 06:48:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 06:48:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable
 waring
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable
 waring
Thread-Index: AQHal797/igz57IJNkyTMQLXQ295n7F9P6/w
Date: Sun, 28 Apr 2024 06:48:11 +0000
Message-ID: <PH7PR12MB59973A9978BBAA399DA748D082142@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240426095218.1075237-1-jesse.zhang@amd.com>
In-Reply-To: <20240426095218.1075237-1-jesse.zhang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=20bdf5a0-d7d7-4f91-9fe0-1750973734fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-28T06:45:00Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB9456:EE_
x-ms-office365-filtering-correlation-id: 6ad36667-e786-4667-2df4-08dc674f2b9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?PU+RS/9wqgxFrbJnlJ/4q7EUFlHf7gODUIPEgCz8DEIQwbzJm8ubBo4OkbbE?=
 =?us-ascii?Q?CJUzjC8VTZI1DR7HrKzJmSfeS5snwHvQBHyFCq6goZMls7hFESDaYXe7cJL7?=
 =?us-ascii?Q?eByYN8TgmW78Xx6qjoJ9EvnQAOf1+PuZ5ejvohCTaH5Gv/L01jnUTWCIAgHR?=
 =?us-ascii?Q?xhbH25NfPNFDXrWJKJcl4tbdrqZa+I3zAoW7zIRllJqI5zmDVYIeEGXC4r4t?=
 =?us-ascii?Q?ZmGHYJTZu8IFzVwdIPXG+tyw4IqLmhPW3BJpdLkUTswSFyzSwTbMkn3C8Uk+?=
 =?us-ascii?Q?jDB10VeEPnVkUdbnQq7Ihb5IhKU+N3g4BoJKLkQfG8vxmOwdmxLuSBFay8bU?=
 =?us-ascii?Q?xZPmVImna+z8FBVkZEIZlzNWXGgvc1Nmg+ctpb/F3akJMfRIhv901xTp2CkO?=
 =?us-ascii?Q?FZPscxM0uWdR+l+eiqcQVU8C02a/57wFLeIV5pzdkC8pEQhtBZi/T0zZ+9QI?=
 =?us-ascii?Q?xdC1Uf4bHBXmCv0ob8HM/v//W4f+ydryzZKPVlj+naVMMlSfbo7RUYdI8JLw?=
 =?us-ascii?Q?37AzpznVvZB98C4SaoF0McIk1GBxBHssxUN4VwnULSL+Rs2f4VATnxmvTDJf?=
 =?us-ascii?Q?UIJsgqgj1lU5e+nlxBbps0T0sJxyHc6UxSZ6X3WJjL9wYG/wzs0amo9pTB2u?=
 =?us-ascii?Q?GkgsLLZlY1eQMAcs+nSlJlbHZfanObTjdrPQNbTJCRvuDEGmHdObSyAmwByO?=
 =?us-ascii?Q?HNEpopCw9tXpxeweEjuY+YA8ccPxu1LHG8PA72gNScHGdUyq3jkpBb3ZyUbZ?=
 =?us-ascii?Q?tG1lQ3GAOa4UA3K2vG2hRRKjnRKVhfbIeje82Fne/tmgVTeZvHw8/Pg7le/k?=
 =?us-ascii?Q?AkFF8WY00Fxz4LHVcMHVQKy+BdZUI/1uXmGCo9G5v64/vY8xZhCHz9pMh8Wd?=
 =?us-ascii?Q?IiZ7uboAKtMpI7F2SZ74yPWiK+naO5FNuYkXE0OImq4o5/aQbiH3TVTrfctf?=
 =?us-ascii?Q?cnuVJWZzvVtipiXFOQnwVyv80OX/aOepQyrm3DxcVvs0zh73t9b2i7Ub1zZb?=
 =?us-ascii?Q?LQLhg07+y3tUg2G0PcNEg/K5+pXrQGrj9wmanFoGwctvCT696bkHXLw6DGtF?=
 =?us-ascii?Q?EqaKYoV/XexZjdSfnKRfHA2lP/BQrVU64M4amGNXA7/YZJtnfAXTuH8ttrTg?=
 =?us-ascii?Q?geHw3Wo7feBJI2EEXpWtkH/yRhEuM+FiFLys0UCa/nZFKOUszbHOyfynKRRL?=
 =?us-ascii?Q?S065uy4RltKtS0Tb4P3rXmHgBYwgvVBKDSuHLL7/Z+78Ly9a05R0WKWagamE?=
 =?us-ascii?Q?Do93ZVj2pzrKGqtCi/b54g4YZL3JbawFyNhpHu61L1cLO4CcjYenqPIG0PI0?=
 =?us-ascii?Q?WwkeutheUmbXZfb+Kxs5To1z60fLxZf8fosIsKpqZ3NTjg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OVfo24Va0h5GE67FJy5uPCJ9io+w91aJhNYYAOW9oOySkvG/Yo5s20w0koa8?=
 =?us-ascii?Q?H8wneJ5xLoidNHQX1aSHJlNc1rawX8Yf6FOycpOjuDDy8WkH6EvzltIEgFoX?=
 =?us-ascii?Q?ous+fAbR025Z5qoGSzmAG8OITjbCn7BhKNEOy0xzr2Cev3HOv1UkhBYosjNV?=
 =?us-ascii?Q?hBSDpThVRqVEhuXDPCmdYcFX1kSk4gtrJmlwH4ht6L0HAC1eVnVbLGAU9y1R?=
 =?us-ascii?Q?Sqk9A42TATVA+WsrJ0wgn8PFxvc/A8R3/AB/RdMWZI2MYHTdA4OYwGOM7EFc?=
 =?us-ascii?Q?FQqMG3nXY/camivNE6efp1niaVss8zjHlBcOGSuWUGVL+8mbQkUtAAekwub+?=
 =?us-ascii?Q?IMI8mX4IHkf1bjRf/AHPP5OHgGfszQaICQpQFq1zozWbjy3z6m30+hWEO833?=
 =?us-ascii?Q?it3WG/HsLy7LQpuXufrEj3Wj81r/9WZIxasHBxqRlFhulhpunj4T3XwGsABe?=
 =?us-ascii?Q?cuTGXOEyuusGrrbzDZGACUN56G97yQHxjZI2eX/Z/xeOCQxaWZO1KRmqgM8U?=
 =?us-ascii?Q?XCDtQQQx8AGG+Rbnry27BImmMuJHoavFUsqtziDNw9JN74ZQq4WRu9jWAwM4?=
 =?us-ascii?Q?QHCQ8kcQsFGN0S/zyH0loLr6Zf2hCD6xyTm5aOaAOga6+QVi1rUU3DRJNsMT?=
 =?us-ascii?Q?Fqh7lCicUIea0k3rRzQMbuyh10i5gxe6ObLNR37eXicw5fk2fToSQkF5QUow?=
 =?us-ascii?Q?BglNnM+XbUiw9AqtiYIAJnjHhSEUohzWxUeA79nu0aQsHSf7YdOp5A5hnmGm?=
 =?us-ascii?Q?FI0Sy2kl08cvloNY7sSlE4DpjtUXHeg7i7jHhimje4Gwz7YXFadHc5V7WDOe?=
 =?us-ascii?Q?DQ8YCLWvWOOf/TTZwrPA4ZLzHjF0Gigoa8pegFfD2BZPBcid/pQh0KVRzpiY?=
 =?us-ascii?Q?mVXUnnTIHf1zj/VftxbAVWZhSu7yigsG+qvvNm6iG2b5U2Gzr55zGCKw/CBY?=
 =?us-ascii?Q?oWVNbCrZk8kR/FtHLt9qQqgtNul9ASK2dWXRYt3mvy9IEDfrojSj9vWUlQbA?=
 =?us-ascii?Q?U1u/nMSV6gP2b9/iUGsoYTo+PtA0DlsdClbLMa0JP/tpRX9iUVdUVW6IVNI2?=
 =?us-ascii?Q?WgU3nJuIyC0HCLif9eiXMXzlMnAHcSoVQ0wnW8nye+HutaCExtC7B+GIGSWd?=
 =?us-ascii?Q?FE/I0q1dkjMbLBzsrhoNayvwqJpXjosO1o62HCl1yyHnEsF4RVJDz1GE30OB?=
 =?us-ascii?Q?IIvnH+kt+xqt1o1fy2wxzNoarXn7/Dz7349O0EWrkNyjdhO1aKm0J8yaMXDw?=
 =?us-ascii?Q?uqCqTD74nV/ds1dwSXgD3ILKm40MQsPtesjMAMHitb7kXNgjsBKOIoN8ss2/?=
 =?us-ascii?Q?i0ze9NbyxMhU2FNJq39oVINeuxTnrzVTHC+/ch6lbTyaM0gtIsa0Ab7aSqEh?=
 =?us-ascii?Q?APOy9+mIyr0WmYk6mAzB7IOdkl9ewe9tE465ZBQCF9TN0uP8zns3YVv8ko+W?=
 =?us-ascii?Q?D37jIiviYPTisLuKOBo8F2+8lfKvuzFg7EkAhSM6lSjdphqH4vw1YMRvtnJ+?=
 =?us-ascii?Q?N6we9fYiOdmonBR5pk8tn4TvrcBW6ww+ETWK7rpIRVMjI6x2n/R/PxYkSz+o?=
 =?us-ascii?Q?+FJQQHQtecgRJXX6JDk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad36667-e786-4667-2df4-08dc674f2b9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 06:48:11.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q22D/1Xnelmj9w+Zi0UepwIzjQBxcF0tkX2oL+LEufBKB0NbS+KTRRsOKlyI0zTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse Zh=
ang
Sent: Friday, April 26, 2024 5:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix the uninitialized scalar variable wari=
ng

Initialize variable size before calling
hwmgr->hwmgr_func->iread_sensor, such as smu7_read_sensor.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu=
/drm/amd/pm/powerplay/amd_powerplay.c
index 5fb21a0508cd..ec2b6d0674ed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -102,6 +102,7 @@ static void pp_swctf_delayed_work_handler(struct work_s=
truct *work)
        uint32_t gpu_temperature, size;
        int ret;

+       size =3D sizeof(gpu_temperature);

[Kevin]:
You can directly initialize during the declaration phase to avoid reassignm=
ent.

With fixed, the patch is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
        /*
         * If the hotspot/edge temperature is confirmed as below SW CTF set=
ting point
         * after the delay enforced, nothing will be done.
--
2.25.1

