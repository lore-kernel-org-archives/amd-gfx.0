Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42275C07E96
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:52:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E1B61362
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 07:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E1B61362
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC7D6E580;
	Thu, 15 Jul 2021 07:52:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35AFA6E580
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 07:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji6OiUopG4HczUL5avTHWPnFpMGAJV/NDcs3pjZiW/79kRR/6g5Qno5GIVHIKACYONIgcACvYB9SHk6kT1Go0nfc7y8MZ/ZekWL9/pVQh67t/mBJeUhPXEc3pR/8A8w2Jl7jbc2TtmyHPHwb34Y9ST/i0K/F5M0a7m2Qwl9REkpUXiGYMWmgFLTX5BmtC/owrzaSbvXfZ0SsrqcM0WahkS/CqIwhWUhIp6WrhgAIiG1rVwQyI2DT7q+iEb5SckFkyhFVbjMeFQAs8BH33Zlu8BrXhM+Gc1lKAS5fiCoZqtWhT75fZ3QEvrWZ2vPpOWCcWnzKHFpaT7SKmLghZ5bZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZLTQi0HtyoNzj+NhGVEZYkN7yRn/cuPh+vh6SHSUs=;
 b=DWdzKAeXDkN2gpn8ECyVkPeyDvkillkvqa/ppUDvSrCyjOekt86rD6VW+ndS/CSrigsq/JAiBCs7NzmCeiDYw/jhYZlxAvrs4e1ogillYxHj7D7AWI9Py5OkJsNrmw+LnSGUgvBYfVQPiKFSpI2Ko6EoZvYLqYSJhOXxMwlMpctJuIgOH47VNp0FAmFfRNnt24UkeDdp8+vKQmEK0anrhrSUSklH4RsK01/Ng9Oq/0laeNkugxv8rBw2bsgw0qBl5TJAfI+kXsmQlD/QtFz3mpCcB1X/0xUlrcR2LhR5FFzO8t40/2wol3g4dV1I8TM3Z07IwWHehLxLDU16YvE04Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZLTQi0HtyoNzj+NhGVEZYkN7yRn/cuPh+vh6SHSUs=;
 b=phU4Pl414WQI2hmshlAz/EiV2H9NZcxthlUJ7Yth8RfJAvxzXKdo6uwprf6rhuY5mJ4PK/FGSHZTJeXnvQAfYEODRdsCDfXAnhICZVFbSZkRNvvVHGf9gtHOyK1JduRQbxPa+n4AwK8UiguOe7SuYcXTtXzM6aPzaUmBp2skbzM=
Received: from BN9PR12MB5244.namprd12.prod.outlook.com (2603:10b6:408:101::17)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 07:52:11 +0000
Received: from BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::e018:c017:876c:8c24]) by BN9PR12MB5244.namprd12.prod.outlook.com
 ([fe80::e018:c017:876c:8c24%9]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 07:52:11 +0000
From: "Gui, Jack" <Jack.Gui@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Chen, Jiansong (Simon)"
 <Jiansong.Chen@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: update DRIVE_IF_VERSION for beige_goby
Thread-Topic: [PATCH] drm/amd/pm: update DRIVE_IF_VERSION for beige_goby
Thread-Index: AQHXeU4hgbao6RqFeEC7pO5sfeGr/atDqd2g
Date: Thu, 15 Jul 2021 07:52:11 +0000
Message-ID: <BN9PR12MB5244678B9B806DCBC9C40B2F8B129@BN9PR12MB5244.namprd12.prod.outlook.com>
References: <20210715075033.1715-1-tao.zhou1@amd.com>
In-Reply-To: <20210715075033.1715-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-15T07:52:07Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ab0441a4-41ca-4e0a-b9ff-bfa8809bd1e1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfa7d35e-d524-4369-1816-08d947657415
x-ms-traffictypediagnostic: BN9PR12MB5130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51304216C6E199784B17041D8B129@BN9PR12MB5130.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p520jNNSIYXoTN9VEh7BW2obb7Eo32HH+e5lAGzEyHyargCMJO37SPmgVuvxNSh+hC9A0znQ25Rca9RY6sPrQVSHt8gOvb/s4BjbGWYe7Sm2rAjfmOxgeOHIhyN0UJGjdFOyKmoRcXHZ0+LNeTNdyCrLbsI1gwQTw+shuVVC/A9NuVRT9IDHXCzRqItLYLVk/4G+yHmqCk0+jerKLtzngm692VWoK7GiI7UZrrWFpGfTxD0SPRYlne6Kx2AghZZtXz5sacFOix6YWKP6QTGs7AoWNIQPFD3MsioYKOb80n0AB5FKuyYiHKFLQX/Ussfn3Gs/leR2S0J488peOrMMwB5U85G7qjbrO/5+5ChVXCMtTZ/m00kz4lekzW1fqEvzsN/6WDaaqubKqdqwso+AYnCQSlMsFJRDV+1AxorycpFVB6+4gT9Jz9/Z6Ml1YL2gvMf7Y7T0QcbsdjIh76+xSmbyDcnlOVHywbXXIQdBVDmSZ3OXkLSyeVzeX7eAbuy8yavbQJo/hgUeHmcudHutLk8fwNjlIfLQSl+xNg3IId2uCpDGqPuDgFwGMRuU+q0MEPouxwwPKlcpPDbHJtsiZejepgNZwWkbxL1sw4/CdFBEANaZQyYspP3N+U8KlWFdpKEk/FRNkXRjWdPTQBPlsXgsxpRAdxABsmafzI5WNVZOP9HBQzVq8dpFiZUVvK7Fu9Z5Dox8XYjOl9tfpFicZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5244.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(33656002)(122000001)(6506007)(86362001)(53546011)(110136005)(8676002)(316002)(478600001)(15650500001)(186003)(5660300002)(2906002)(26005)(71200400001)(52536014)(66946007)(38100700002)(6636002)(66476007)(83380400001)(9686003)(7696005)(8936002)(76116006)(66446008)(64756008)(66556008)(55016002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PJusddhkV4gkIWlQYEKFohu8PGDfg6ffcnSEQDqcfKGq1+efDD6PGhANTt7?=
 =?us-ascii?Q?A3CFOfKF6+92GtGKrx5Ogbq4QbKpia1vAWRD6lbEnSiEdWPc63jgk/VXN8Oq?=
 =?us-ascii?Q?Er38Pe2hdVjyecY7y3iIH3YID+7o/JJJejMQWBfaZ/KEBljYWtL9b9n14lGY?=
 =?us-ascii?Q?NL/amVvqSwvQcXXSosEpMRfp5MK0pXpf7Ca4E8PVigW7FA79sUxnk4WCnoIj?=
 =?us-ascii?Q?25VgrLjCVjykfNbMZ40M+yipo7A9b+nHpSBLYtiAEU9WtcQmK1ZsD1iXTcIB?=
 =?us-ascii?Q?2q9P5gZDZmPvCjufMS0pj0HBwZNSVW5jcNLfpgy/u0RlYENMumfR0o8XnlYy?=
 =?us-ascii?Q?vI4vZNIejDLpl2HvdKYZZlT25/bWdRwoedPb8/y4fmnVUxqAs6yvCYD1cRBW?=
 =?us-ascii?Q?uEeHYrSuNI3AMGKhxgQO7ZyK5w2IumkwR6hFn2DFjRo03/uV/k5Cp9uLIz30?=
 =?us-ascii?Q?Fd5p1b6AHEeGDdJN764fGaoE6e4qRq9se+CFx/VGss4i1IbVQGRWTwlLXyP5?=
 =?us-ascii?Q?JkjhKZWi7Xou7kDoJz3GT+L5qwUGjfEuLNaYpNoZ8AJybIK9mSAUqPHWd3sp?=
 =?us-ascii?Q?4jwaHMbHjPgMWggcX77Oy6U7dV+0o5JXPYyWzn5L+ibUfWQu2ka3byCvniOS?=
 =?us-ascii?Q?8oc/ST/bGH2KMKALxdkPHeFvxz03XzeXEewYnzSKZEcXwuN4c1h1OkK553xE?=
 =?us-ascii?Q?PprTE+HJpZ/jQ+3YFThsEMER2rx665KMXe8THnyeaIczNj9HdFgN+cby/lWE?=
 =?us-ascii?Q?aybUEny+tzQF3H89rxyesE8rSDBRWNs/3TUHoa7Mna2Rnzqou7I7/u6b2IzH?=
 =?us-ascii?Q?R9U89qD5B04t8XbPCRjd/He0qiSHga6ZWc/ssAIsR32XLk/1GngyR3MX84vq?=
 =?us-ascii?Q?IiQqmVgpBGstm1KVJwK+xTBKBNiuFHG1x2X7230jttpXt2PEOaKGibWBxbF3?=
 =?us-ascii?Q?7YQCg3MG2pazOwMK+t2bOTCt5uvkrr4o6HCZODjaVSktNIDX87+jSu9jNcOu?=
 =?us-ascii?Q?X2U0TWGdtVh3BDcfpcW7BxqG+HLW1qhIRh6Enz9bvUMCyVKZbObwc+kMJd8p?=
 =?us-ascii?Q?XJjtpaDMbOdPcCDLXdUysfXyirJi4fgz6vPiJX4gvLvGzdPrl5A6/m4ZfT3b?=
 =?us-ascii?Q?K23h9/SARPWUYQh05bCwjgR+RE3PFNCezwJ6qy/rXVuzIbvgm/6AMIDm7IEj?=
 =?us-ascii?Q?6AvHgGo7jZSKT8/zCSpLAHs4q6GZCkqy1ydPROkb8I2Fs2tzNJG3g5POeu+t?=
 =?us-ascii?Q?N01aMIObmIrnOcuwuNTt3HZphgGnyF6zxdwMhTGLpaGuqzR9Mnz2w3v/GTvB?=
 =?us-ascii?Q?8MDwIYOYKtj6c5pTbJxZVl6A?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa7d35e-d524-4369-1816-08d947657415
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2021 07:52:11.3697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNul/86lyC/NLzczzZo2XCz46cJYfLA/ziWWMDcWDAeQY2rg5AtdHyFM2xnw6Hg+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Jack Gui <Jack.Gui@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Thursday, July 15, 2021 3:51 PM
To: amd-gfx@lists.freedesktop.org; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amd/pm: update DRIVE_IF_VERSION for beige_goby

Update the version to 0xD for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index b89e7dca8906..385b2ea5379c 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -34,7 +34,7 @@
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0xE  #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x03  #define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0xF -#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0x9
+#define SMU11_DRIVER_IF_VERSION_Beige_Goby 0xD
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
