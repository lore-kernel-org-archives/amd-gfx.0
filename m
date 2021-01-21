Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F9AC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 553F023719
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 553F023719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1A36E095;
	Thu, 21 Jan 2021 02:58:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 687A86E095
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 02:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBLJoPfOZv6NxNRkDSchiesV20+wgrWj+SE/TrWHUdxmE/n/kkQj168Hd9rkS5gOXuP9ckksWtx4e2gGH1iI1OH9EnLTEiNvwY/3YB9XFOZNyAZXW6RB8BDT/jZK6tt5m78N5NaU6fEzuw4IWOh8jIwtt65aOr/bNl5DJrbnOGVHCAKN4Yzt3VprP12EFMKulhlh5WrHrH/V2wMarB+UUPFhU8DyFwbY8yM8v5W5i8JfoJEeIDjAvv01s4HRRnwl/h2PEhtLOk60T11RNbAFNKsosYlB5FZlzhLP4ZBsvlbrt90UB6s3ogJnHXKzw5zABLXYanlQ8lCIJl8SlCS2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ27z2/ENXkOMHgwcLqLN7pHKOXZ+HwWFB1BucaxU2U=;
 b=hLaJ0GHzAl7UUR/iF+bkEV/J5zb5aYORfvBJMb7KbBRBAF2PySpHPIstxXssf3C2Yx5tMhaC9yzd84cT2IU6V8IVPkEFGafwmZUvJkd9IUsPcJB4XIKHgvWTCGVMvnwcK1ydoaVq6cTUKLt/TldFUIqf7yncMgKSBP0RnaZ2PUdAN2AFIQ7vV5jjw2BJ+cwkuw9GHyC1mjHXhIu6d2xPxYwJ8E6m9Q1JynUhCDkmIGPJp+DydFvzMVeTw54BpQVkj6GVbb2+0VT4ddcrsP7WRwLmH59lGupU6NKvNsYlC2FThE+oFgZ1u4ueDEPwQqTIXEZFJ59fgmmWObFmHQtb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ27z2/ENXkOMHgwcLqLN7pHKOXZ+HwWFB1BucaxU2U=;
 b=cbiRtsB3DnnhHNWvK1ZzScZoOdA/uDJ02/T3kqEbpLK1Y3pjnywdtL/Ian0C566Yql0ReOotzGJn8WNevhVnpVIrRgFm9bye4Mf2d7xrH/TFR5QMuySe0V3m3xfdgsjuul804BnKvz3Pt2LLgTRCYNMR5Y4tb+7YYKwxipevvVk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Thu, 21 Jan 2021 02:58:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 02:58:28 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: print the timeout of smc message
Thread-Topic: [PATCH] drm/amd/pm: print the timeout of smc message
Thread-Index: AQHW7yWwOpMCSjBGYU69wF2LWSxWDqoxZCjw
Date: Thu, 21 Jan 2021 02:58:28 +0000
Message-ID: <DM6PR12MB2619A1D96B6E0096B4E55D12E4A10@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210120121319.662069-1-ray.huang@amd.com>
In-Reply-To: <20210120121319.662069-1-ray.huang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=7284b0b1-21ba-4f37-a465-04c856776b7b;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-21T02:57:59Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7877d97-bbea-4230-4af5-08d8bdb86dcd
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB494106477262EDF61015D57BE4A10@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFyWwixh0stIhmFGwZC2Cr68EupY/eWCvyO4fkt/2SfkzxJ/reRYTLxk60zhSOezKoB70zqqU+JjNp7fuT7IH/5+O+AOJ5FyBiEnkd4fFVKMfLmN86HFXjcZ0bAcw/3SrMrO1nZjcmfLStPvB3l4VNzbkgyjsfqEZ0DjvYGhGPRKvbvygXnStumKdOZwqZO/xALAc/BjBPeRp+0J1UT69CAZ+X5VdcaxbiFJyqmgZlNk9IwR7ye6sY666VionMUyV8EoX04OrGT1ILhEbKK+uJRc+M12Yw07TU0J31y/c2v5vAruk9uDQtOSfYg0xR0P/RqyrYW0fYKDXB5dL2/88HchBT1KkU847iQtSmJGZwZOp8g2Q+/2dsC73EN3EAf/l0MK5XNgXalUwjJRm9Eq3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(186003)(6506007)(71200400001)(8676002)(33656002)(55016002)(83380400001)(5660300002)(478600001)(7696005)(86362001)(2906002)(66946007)(76116006)(26005)(8936002)(4326008)(9686003)(15650500001)(316002)(110136005)(64756008)(66476007)(52536014)(66556008)(53546011)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SRniXqU/9FzFa8NWBRoo/BWp7bisiPxCSJgjWoBPleOao8dAZlz+f/ksoP4D?=
 =?us-ascii?Q?mXNIzokjmrGLi5juFIRluMRl8ifrMxttMP458hmq89XO8B/U4U6Y7Kw3DcPR?=
 =?us-ascii?Q?WexVWRPfQxbgyLSrBZqjhG2nwz7uL0jSIa0952t8a/tTRhfnYwT8RfRR1MgH?=
 =?us-ascii?Q?HArao9UHAPEZovQiuUoSLERTjrKykDshOgPxdorYZP6G9WP7Dk4k7rV4rY4G?=
 =?us-ascii?Q?altyJ0RfXNtdOxF27IJIPsQBMZjO2fCCniC1TSYIOaTfvWzkoZJe8wQX2lFb?=
 =?us-ascii?Q?hm0cXpPZR/76h9Ei4CZZ3qjGk62C6vQM0nQhC9gwdYD6YBtdCycp2MbvmnUj?=
 =?us-ascii?Q?TIfhDzcXb+BqL314fY35iOwE51Is6voLZnwzH0S8sq0O3FON7c0uiKA7SkCl?=
 =?us-ascii?Q?20G15QdOEOmh1VTIHW3WEqKJhHdtMrGkDZrHxWiR1M3I4e2rxpBWJoIB/csg?=
 =?us-ascii?Q?l3ykzjzVmLx9o0VUSQxHjV9oFlGSSs+deOt/uv/ZSubPpf88ICxJxTKo6uW9?=
 =?us-ascii?Q?4mAV9wGoDzGWh+6pyG5KEceH1v+Xz8gH1PH9wbpbF6Ja0s3cpKNufpX4sYQg?=
 =?us-ascii?Q?gE+2SsfSLJRuNSR6rk0iXROPH9rp7v/KyC4/aYOtfTO+PGWQxkVpFoOdVUpV?=
 =?us-ascii?Q?5nQT12baXvYp5+vl4Tszo1WcKfQWHYMLnBQF9n9zR+ksQySvVeKOeRPhAGHR?=
 =?us-ascii?Q?m5jli9Malh7RU5WwqBvynrwKZadDaKXFpqQxALupJsO9ZhS0IyXxqhnBAXb1?=
 =?us-ascii?Q?+EqpdjJmJj+OGGz1Vr8twrT1d+mBQHl6+opOyft5NFB+1iO3ubYPvxmhwoZb?=
 =?us-ascii?Q?2AFDTndl9YJCUajwS5yR8mTal08yKR3LFUf1PA0hA452d2iqPLcKmM+4be8s?=
 =?us-ascii?Q?dju21vKmOCco3hYDmFoJR64QLwPWHOhX1o8joRtGsAaZuse1RT+TAwwt7RTm?=
 =?us-ascii?Q?eTjkGDYm8e1oniACJoOkKlP9NlRFLQvH5xtQULLZD58=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7877d97-bbea-4230-4af5-08d8bdb86dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 02:58:28.5798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +T19gNXoe/FhExILGB1DSWhDfpE0+g59H3FfDrfwIWlA5e3n2XucwZlV60SdL0L1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Huang, Ray <Ray.Huang@amd.com>
Sent: Wednesday, January 20, 2021 8:13 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amd/pm: print the timeout of smc message

This patch is to help firmware designer to know the smc message timeout
status.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index e4eff6d9f092..ffd373e63f0d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -142,10 +142,15 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,

 ret = smu_cmn_wait_for_response(smu);
 if (ret != 0x1) {
-dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
-smu_get_message_name(smu, msg), index, param, ret);
-if (ret != -ETIME)
+if (ret == -ETIME) {
+dev_err(adev->dev, "message: %10s (%d) \tparam: 0x%08x is timeout (no response)\n",
+smu_get_message_name(smu, msg), index, param);
+} else {
+dev_err(adev->dev, "failed send message: %10s (%d) \tparam: 0x%08x response %#x\n",
+smu_get_message_name(smu, msg), index, param,
+ret);
 ret = -EIO;
+}
 goto out;
 }

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
