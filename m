Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC1C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B8964E25
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8964E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255C06E4F4;
	Mon,  1 Feb 2021 09:10:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5390E6E4F4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 09:10:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGXMZOQw+24qcNVLTz+BKe5qltu/a2x9mS29OALZgQMGZER16TDxMn6ioBUBNEef+Vc8dkDlKc5dTw7uHwQtkpcDivmouqGniWoOfmk0kB9Cf3IkbKBSE8oS1svfGw6/GCJtJgY+QZXqqWc/CBH9YkIwfKx9vcrVBiCGTwU5ZfCCOnSJhvWK3HuQZNym8T1tjnq6aX94zNzuXpqyxg+WnVhSykg9H6m49kf3Uiy/fuyx6qT6Jbmk5UkwXlVJ67ZOBmQqa5zbKfPhJY2ZvFlhR41ru0xgHJ1w7v1bihJAYa2MUNxB0bQXCLSbcRSBxs14r1erjZ6v0HLkW26r22h/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GCNOc9E3EvUKREZV6Vxboj0qDGRWiaJaJV9LIW5cU=;
 b=Tt1+XvKB4Gp/FbefYCv8tpRsUNtjFHYd6bjxorJRTZyipaQyDkqgHaZsVKeSVXsH7ItR/yYpszXznJZEcibr0+rXRIxczjm8GLLl//ZnRqA7dHyTZmgYhdH+YKYExyHfy8RUcxj2GIPM2deFIWYxZJtG1l3Boq+JXNrh8EP1ECcmM7dkUWs2XNtR6bYCK6U8tpwa1ul5dR7M6OO8qEkGGuSaXhI5eIcZgF3xpDpjnvHjH/+ayW0c5cnjyT0fpig94WUKo6NTrUAglmBXb/IN9zGALF8oi0rZjdNFAXbfAVHHAJ7Ay9vEMbtfbcUvZstjWN7sMwu4WKiegufqMhJmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1GCNOc9E3EvUKREZV6Vxboj0qDGRWiaJaJV9LIW5cU=;
 b=2CZzt0tqsjlJQ/C38TGfcBPrxAKL0KTZmuuSFXuO96F7fDMNpBhZxpVvi/+g2h+bggCiwMXFzZicGRdmTRFZn5nTaYuty4vXaQ5lYFkm+74eWpSO4XM75X4hIF/uKvUdeQA/C2CphiZjLGol4MaGsr1PBELj8fU6sOs4IDEPreY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2359.namprd12.prod.outlook.com (2603:10b6:4:b4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Mon, 1 Feb 2021 09:10:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3805.024; Mon, 1 Feb 2021
 09:10:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove some useless code for vangogh
Thread-Topic: [PATCH] drm/amd/pm: remove some useless code for vangogh
Thread-Index: AQHW+Ha3D0HJwLG4qkiN3plB2s+PUqpDAyOg
Date: Mon, 1 Feb 2021 09:10:49 +0000
Message-ID: <DM6PR12MB2619285C76EF037F50AFB80CE4B69@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210201084558.21708-1-Xiaojian.Du@amd.com>
In-Reply-To: <20210201084558.21708-1-Xiaojian.Du@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=0a05d915-c07e-46af-976f-31d9eec9a4e4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-01T09:10:06Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c2481c9-bace-4c57-c4a1-08d8c69144e8
x-ms-traffictypediagnostic: DM5PR12MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2359AC82C3F3C1AA483AC280E4B69@DM5PR12MB2359.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sxMVjVcyJ7cHnv/1aQi54eKzLrECevT125E4zEZe6G1m4DC/2Fl7IhNXkcQanORD2tNVfzWS1Jg6x4BgTjJ4IwbUgF43bXDQPy5yatPT7QWPn+IPjpqZWHdumCbC1yEDatS6PQt9O121PI+3l0mE1+4Q1VI8xo2sEDOzzjzlb6/lCQl5lmRboWVnmeT/PdKGitptX+7Z5mdSzaiVnTmSeJfpQHEwd/t9a3OQL3QCPxzcOeRSK+S3fmXu6ZxwV84QmXRkzlWRZw24m/SuGYyMJ3hDixZjlhmoAfIKVVOGSJQw2UYJZIvLtXCJ3Z981KnaEvk/XQhM3rds/IlZ3gtOkqlJZm2YIGNqk8SErkIzZtYFxWBQDHfC8I8FBLl9Ls3eA0H05bThEcvb6k4U/VeTzyKsQ6l1ESmsMX6fMu66mos9412853f2S29svypFVDGY3puMMa3K+x7mCBgtHkrZsGlUatjAdvl+PY98yE98Ia4bmAnAWdxVMjeS+Bgp/u811LZrOv0jJ6G9k88mhQE9Rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(86362001)(2906002)(52536014)(5660300002)(8936002)(66476007)(66556008)(26005)(66446008)(64756008)(186003)(33656002)(66946007)(4326008)(6506007)(53546011)(76116006)(110136005)(7696005)(478600001)(83380400001)(55016002)(71200400001)(316002)(54906003)(9686003)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Ffqp9IfysHCubGOrxLQ8N4x0lL6/XM8FKKYchut4O9NZdJWjFNo0MMLw+l0P?=
 =?us-ascii?Q?AFW949AMb4cdgo70+T5V62ivL5asecIC54OevY2i4C9sDF+ycIPOze4w+l/T?=
 =?us-ascii?Q?8MGqXtDhnVebaksNZhAnkxNnlLj6SI1o1t//PBTgtJWvUGbuMTJt1YQ3CadN?=
 =?us-ascii?Q?KijuEmfkPY/KK/bLxTqsEOWtEvFKWN0SK+3/CV58CKKQLMDM3SvzkOLzkzav?=
 =?us-ascii?Q?U9wG8VJPYFZewH1u/jt0N2p8mAy9iD2qMvdpRnSXrgR5mj3rnOeeSKBfwG3C?=
 =?us-ascii?Q?G7ammrT7exOniF+fI8HMGxC0puXeyYHBzVlTEqEsc5aznAeFeEEypRbvrdqA?=
 =?us-ascii?Q?JU5aRlwBEmJOyobRFR6wCHX+AF97fco7DqATExGOQrSRMYENYJdx4B0MP8Ra?=
 =?us-ascii?Q?LNijTQZ1h+kpX2AU+xjr5EBiaWz8957viWjBgrVHb5o6uXbcCnObI+xStiho?=
 =?us-ascii?Q?/e6mh5zRGAsBjLhbdozdMb/aaxO3l9WZQe6FVWOWJI62FiVgcm9KDCK3FWJo?=
 =?us-ascii?Q?X+6m1C82sgqzDWLn9cxH1mr8XINnf4T56q/U++ypUwjtf1ri87ijoWfiwhkf?=
 =?us-ascii?Q?Hc1RoTUhELW+hRy3wOZ1pq6JBOuHDxy/pXVjIeklyJigwrfk8z0kZehtJj2L?=
 =?us-ascii?Q?mWasA4ohU0iyH3wI1t4WtKz3iNjsotwgBcmrHpZ/Tv1LJLsIkv1WS2L8+966?=
 =?us-ascii?Q?WsD5E/je7Mdtk/qFhKzwTUfvpwUgpNgjSwmqwlh9blWKvhrcFlQ5kgZDgogD?=
 =?us-ascii?Q?7Nhydh/ZJ786ycBRZ2opDkz27Sx61Og2Izyf/5hBU0Cf7Q4QIauA1I1dBY6R?=
 =?us-ascii?Q?uuYn5ZRY5sJ/PrPTmdNv2Y+Z+hegvPtuVIX+HUo6Nyd4SZ1I043pms7R8sZA?=
 =?us-ascii?Q?B7nDJJSZFBuMpZ9YM8PPqkeMTqx+lLIHBTI4zudVJo0UMCz5/z6/aqD+sjyi?=
 =?us-ascii?Q?DXNS1VxbnaFFA9d2pNqUrvBZauXW/o+CaNijfMRdim7ZwmBygybFCZMNOz9W?=
 =?us-ascii?Q?piWegpDhQOfkpBXVX7Vu3BUS6xxsyjogEuZki9behOdkrFl4aURkRsKm/pxI?=
 =?us-ascii?Q?A71lcU8L?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2481c9-bace-4c57-c4a1-08d8c69144e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 09:10:50.0029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIy5Yd6FfsJUXbN09zfAjILBzNkCO0K7NhnZHXTHzHN+KZZAZZv6suh1BT37NTfk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Du, Xiaojian <Xiaojian.Du@amd.com>
Sent: Monday, February 1, 2021 4:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
Subject: [PATCH] drm/amd/pm: remove some useless code for vangogh

This patch is to remove some useless code for vangogh.
In the earlier code, vangogh can't finish all the sequence of
smu late init. But now vangogh has one stable work state,so
remove the useless code.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f958b02f9317..30e2a0ac3279 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -612,9 +612,6 @@ static int smu_late_init(void *handle)
 return ret;
 }

-if (adev->asic_type == CHIP_VANGOGH)
-return 0;
-
 ret = smu_set_default_od_settings(smu);
 if (ret) {
 dev_err(adev->dev, "Failed to setup default OD settings!\n");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
