Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE88C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 03:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBE810E9EB;
	Tue, 14 Dec 2021 03:32:44 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB94F10E9EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 03:32:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHezelanwVvzn+g9719VFeNqDTpUk0oEMLVxADbCUXBSzkNvGOyqwbwYN7jqqk90c1lrvS2BzmFrwRXLgnV8+VzEnm8eLy6SDl1Dx3XuuPuNhE10Ubmtj8GuB3VPQ0uK1u0rD1H/z0VDIiNGCfKpqssJGzhrih2DYcf3C8Q36yjma88Q9ZRH2R9ck26xVJzS1RYyTs7YyrT+iwsWTlLEd1AATGhbNPa/gFdDXH6zPYgtb18UP9cd1nNRR3rKA0nln39xe1X06EQVDO7yeCx7tj/0oUtmw29uIoJkBKuj8Q2JUXlTcPyUuixCEWh9nEhd4Qn6I3eSSOywwJdobgGY7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRe5XDOpGR0p1wmaFF70tak/zyOtAOkf00+bMiQ5VzU=;
 b=EEhBP9eg3tBitbBZ9fyYD+Dc+qYfBb6kgcko0yItatg3G/IOQZVkoUZc5Iwyxn6yE3HpPBduUtGKse5p0D7pi5gb2PiO2LuIGn6JSVjQniTXBl5OImhQiicWgIiKLQAs7Vf3KW5Ji7Iady1NNpLwtmnFE4KznGZUkc1Bn+B884feJD+nx4xn8cnz88YnJlJ3W7qami1NctGN7YAAR1SKfiJ/AfrkAzBZdg013QFqvdtlFvWZLi6svCGbfffSFt5gTqyfYS3tXknP1dk0KXYkwwg5ZpxmeORTDpOaZY3FX1gd8aHlE5/QsEkapu/jpM0lDBuirwUdFvL3yx41yJ/RUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRe5XDOpGR0p1wmaFF70tak/zyOtAOkf00+bMiQ5VzU=;
 b=YXAWN/sn/JWagd2iS67Fo9a3hB3xyZnLFY1aLLSH7PmgmNrExXrygKQXZrvYTdUspdAHbS6y+Ma0n/rXQny8tdB4ngJCEvZ4j1HLHVidMLtyx8Wru6KVRXMV5k/zElt/g9jhmdcneyQEXf1xoeJ0Tb1OyqSlngrP/L6OdCJaPj0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3769.namprd12.prod.outlook.com (2603:10b6:5:14a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Tue, 14 Dec 2021 03:32:38 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4778.017; Tue, 14 Dec 2021
 03:32:37 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Topic: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64
 characters
Thread-Index: AQHX8Fhu4+L3vF7n3UifTAmdz3kPcKwxVN8Q
Date: Tue, 14 Dec 2021 03:32:37 +0000
Message-ID: <DM5PR12MB2469C2C6C65FCB39C7C10D97F1759@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211213193402.96278-1-kent.russell@amd.com>
In-Reply-To: <20211213193402.96278-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-14T03:29:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5713d6e2-2398-45aa-9ecc-5dbbe47aa19a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-14T03:32:34Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: e501e753-c279-43d6-a7a7-af88bd2c6815
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fd2310a-7163-4278-5cbe-08d9beb26056
x-ms-traffictypediagnostic: DM6PR12MB3769:EE_
x-microsoft-antispam-prvs: <DM6PR12MB37697B16B7A085C32412F484F1759@DM6PR12MB3769.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/qTvuR0P0cWTGwoKpzeC12DckSeX3jeoOEEcaNl5qm+yYoM2QSGj+2FRP1/dBbByB/x+F+l1KZ6RfLsqv6HMd8jLDDOnnn7n51wSSJymI7hM+BjDrBlFmWslqRBAlFJ1GSmLIYxgVXwWYMfO3xB2ToN08rKjLyG4kGIKhFsVG5XOQM626s44lyY7lKd9dSu0Xr5XNmalomMtBYIx+FJHvjUTyIrCIZMKDrZrwxNjfjSJdC17UbVVU6BU0WvOnhYCa46rLYp5tV3M+QNE5XcYh9dzhprablP/WfcX1GbYthLyHS8jded03i9TEGxjnQZ/eUXLso8dWBTTlIy/mD82dQ9Jlz0BNJyJgxC7uXU1A+//b+l+7z9ypYGDmJ+3D29tAyErZffModyBneCIU9Z4fZZbPFQ5ZbhlFGzYb9s1Y8/J5skryBHlUSVheGH3qUG7mJ5D2LnHcmT8Oj0DhqASv+mEQzprbAKew0F8Ab4befs41i9ZCr6rGsoP2SGEY6GW7sORvcsynt3wWltCUkdQq6JJjt9727WgISQd0Og3rOugj6xzzZvyLKZhXhGbbbwAMl9/LaqV7gg8es2ky5yuEcAIYd5pBvV0FIClKmvvGp2NDeboa0DSlzuaCSYkTPdspobHSIy249QCmxk9ZX0LwAAyP0pVKu04J3ETQMb8nmqm2MGPD83DoqtFR8T5rGJyABVrKgDos5HUbwiqDEowA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38070700005)(110136005)(316002)(4326008)(8936002)(71200400001)(508600001)(8676002)(186003)(7696005)(5660300002)(55016003)(76116006)(26005)(53546011)(6506007)(66556008)(64756008)(66476007)(66446008)(33656002)(86362001)(66946007)(122000001)(38100700002)(9686003)(83380400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TKKMcvp6z8aa6YAtRINYJ1cXWH2FOAtAIlLkgBRDtDvEdiEkzsQ0dVf5XyGS?=
 =?us-ascii?Q?jELUWWM3Hxl1w7U3aY/78mNPI7JBEK7oLrxjkJ2yi1fUGv2zz7zIOyIsbCCa?=
 =?us-ascii?Q?j58aUpnly7AyWcCikWuN2HyILyB0RQWMMFW6xqwV8dswwdeTsraLIfEr6rpg?=
 =?us-ascii?Q?HWX6C40v/7dhQ7ZpNKokbDvl+IOFTMYUX7PLPPfJv76KEupftQnWeRfp0UDX?=
 =?us-ascii?Q?XNby0pf1i9BCLN9gr3oxT6MJFsjyOxEue5EpQfTVoWwMjav39Zxb86foC+kf?=
 =?us-ascii?Q?FT91CzWQnQtSdEUQbBCOZGbz0FGoHJdvp/9kEh1VLJQmBZQG6AEVzHnXvb4s?=
 =?us-ascii?Q?h7lZiSB7TnS521fO/xhgKIZ9hVc4LFShbcD+LmRo1Z/LhUwfnfKAhjtH9jjy?=
 =?us-ascii?Q?inCjBKw9Ob1KdjlOPkBuKinQYEaLinVXTRjWTeKmPHiob0z1ESodd7J3zVZG?=
 =?us-ascii?Q?p8bRBAwi6RBvH8zBYy9NYwvd6u1Qw25m//amY0tvepWtOU3+liPdAJHf15ww?=
 =?us-ascii?Q?+4BXeodoaJi7fGPbVbWMrADG3OB24RQzi3ZnDdcirghGPZjTnkQgLgSJiVE7?=
 =?us-ascii?Q?W0Do38tHve7pATZlHp7KemHFEQLGgX78YEis//OfJcyuhcxqHVPS+/T4UsKd?=
 =?us-ascii?Q?b2ypWwEqFPHNfMx/1abP1ROI2PfA1Z40WkuTHVJGri+YT32lI+c1Vc0g6yDE?=
 =?us-ascii?Q?pyYYSM6JTgaiTo1YL9geu4NBcUSMdXBYJdtLKP+4JZspa4Gzy55eLHeGus0n?=
 =?us-ascii?Q?CfKGzFQA18ParbXX55BaH1qpWdGzK9UGg+6qdtvLji/kZXFjQiV3U/l7XnOG?=
 =?us-ascii?Q?IFpWfj//a5SknGs0KjCgqt18pI8fMmpWDZfcZmef/FlbpTKUcfB3CnR7eBlk?=
 =?us-ascii?Q?ZjwT5ITwjgBcM5Y4jEuJR5NnFhcoARw5Nr9PmyqJm4l4GO5NSg57PohGivQ0?=
 =?us-ascii?Q?TTVNXqjGayi6iK7QkX5mwagQizBCQf52ky1OvsLGXVI1svY+V5xym68BAAhO?=
 =?us-ascii?Q?nE/6uygxG+yw0IzscJ5te0pNRw2Fi0afqHpldW3/YZwX2fISyvKmB8qO4Ilw?=
 =?us-ascii?Q?88mpbiFr/dToVEE0ZmsBslN/p6x/qKBUBcS57ffPnbW+Y4a30K+Go3btrGVk?=
 =?us-ascii?Q?YBDX9tmUj6RD9gex3vGKfQI3XoFaoyZGfsHU6qWxLN4wLCAKSX7+Li4ZUxJ9?=
 =?us-ascii?Q?P3Igpgc6mccGbDbo4/dAoXZwmYmuhc3zjRUkTq3YQvvIbVuJhsxyClIiwQhH?=
 =?us-ascii?Q?1Gvyw4hC48EONiyqE7vfKCy4OH+oIY+eYw9WpqAGgMGFq4yfu99Rc0rpIU8o?=
 =?us-ascii?Q?kDEI7i92La+44XDVnfdtFtjYVWhh5ePExHfzb4CULGDF9WYHhbybaisuxcYr?=
 =?us-ascii?Q?9BykY/uNkgf13393Dt9TPowvqpdnuHW1MVIZmEEHIZF4ruAeU+Vfwxeg4Csy?=
 =?us-ascii?Q?qu/ep/coBYV0YekBlvr/nt6WAiiEtR+ZQP2880J3677USNSLFp4USJ2e4HdU?=
 =?us-ascii?Q?tx75tezUViQsH7SbZW33hC6dEVlhja/GtLFnmwvC/CflnRmJOTY51wNNeM/O?=
 =?us-ascii?Q?2ikREI85oU0dHgVVglMr6qkGo2XSRA/50qphzDv3AyD54M/S5k2U1zi655hu?=
 =?us-ascii?Q?ktp1c10JnY1elWPyzvNWeZE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd2310a-7163-4278-5cbe-08d9beb26056
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:32:37.7802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCQ38NF+N57GU4i0hYMO4BLPbja9Q/p7qOVVnaZ4dG4TksuVuY9+RuIE8JwA6sZrwEAQTfwz7C4QanXOasPT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3769
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

How about set a define like PRODUCT_NAME_LEN to be 64, and use it in FRU co=
de? In this case, if it needs to bump string length of product name later o=
n, it will be simple.

#define PRODUCT_NAME_LEN 64

unsigned char buff[PRODUCT_NAME_LEN + 2];

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent Rus=
sell
Sent: Tuesday, December 14, 2021 3:34 AM
To: amd-gfx@lists.freedesktop.org
Cc: Russell, Kent <Kent.Russell@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Increase potential product_name to 64 char=
acters

Having seen at least 1 42-character product_name, bump the number up to 64.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index e701dedce344..1afb3066f6dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1083,7 +1083,7 @@ struct amdgpu_device {
=20
 	/* Chip product information */
 	char				product_number[16];
-	char				product_name[32];
+	char				product_name[64];
 	char				serial[20];
=20
 	atomic_t			throttling_logging_enabled;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_fru_eeprom.c
index 7709caeb233d..b3b951fe0861 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -88,7 +88,7 @@ static int amdgpu_fru_read_eeprom(struct amdgpu_device *a=
dev, uint32_t addrptr,
=20
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev)  {
-	unsigned char buff[34];
+	unsigned char buff[66];
 	u32 addrptr;
 	int size, len;
=20
@@ -131,11 +131,11 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
 	}
=20
 	len =3D size;
-	/* Product name should only be 32 characters. Any more,
-	 * and something could be wrong. Cap it at 32 to be safe
+	/* Product name should logically be < 64 characters. Any more,
+	 * and something could be wrong. Cap it at 64 to be safe
 	 */
 	if (len >=3D sizeof(adev->product_name)) {
-		DRM_WARN("FRU Product Number is larger than 32 characters. This is likel=
y a mistake");
+		DRM_WARN("FRU Product Name is larger than 64 characters. This is=20
+likely a mistake");
 		len =3D sizeof(adev->product_name) - 1;
 	}
 	/* Start at 2 due to buff using fields 0 and 1 for the address */
--
2.25.1
