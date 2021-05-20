Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7905EC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1422460FF1
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1422460FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909B46E420;
	Thu, 20 May 2021 08:32:19 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187BB6E420
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 08:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6yW8NT7jvmvBGZ5BpNxFFEHpMnp33f1sEHUSGiAJg8jaEzXXsiI+fqRR1ou3Cy5NueMKUKh9AovvAKP2wsU7VBuDjfg/ARt/TPwFyFWfx4PpLzmKh14TNa+jidQNgd62iEXxJLidWMiqgD149N6TowAQfOsbq070mqDhbcn0KCNr2W39INbDilRT+kjIazcUC0HGrmBflUXza1MtO6WCQPbJv45YOkCKhU9cHHJSQT9qnr43yS71PR5nuuV+E1ENEW1T4QZI1AKMKfxm8wa4fxEJfpRlwDsBQmg2Vl4PSSPLMNYNe77NSjJVBJDXC1jwc4VezNG81oeb7G4asFQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/MbutCWqNXM2uJuzOnwRy/bHDkBKNvraDMEmr5vGUk=;
 b=ULnbs4M5FW3lVrJH4jk+vl5Bu5ZB3vG+prGCdW3uJqam3ExjTLTsn3zYWoStdnjf/kW7sUpsSPV+iQ2/ZOKAv/gmqnDq6YOWzB1FMgaumNeqghp6RlJykZNs81K8RMxUwHZBdC7yghsewgm3GZ2mLUQwr1/GD/asNseD79MoSIs0IMI7tiHjkaYfEX/t5DmE/1DYbrCc06c9MrlnE5fuihm69V1tPcTruPLcGu1+lzDcZkfemCXXdS044TqLPl4PYsn/afbzO2wY5QQQ++dj/8B8JomRzeNcF6U15h6y57fIwn4BZBhIRDx9ZtTyjEomMpOZK3aTVVxdMQYyrKuZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a/MbutCWqNXM2uJuzOnwRy/bHDkBKNvraDMEmr5vGUk=;
 b=CiZMYKNS5T0dGxCw5zIkZ5Tl15wphMc1AJBl+/QENzLVLsrsfn1ly44si/Efz17p/p/F1+epURzdKf3hztVBCRagLEnEjleEZLMg9TCcOp0Qc9+3F9M/wfzq65N5rqvbm76NWn0E77KArzzHU2zaZy0H8jGRU016LuTr9veyuog=
Received: from BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 by BY5PR12MB3650.namprd12.prod.outlook.com (2603:10b6:a03:1a3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 08:32:13 +0000
Received: from BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e]) by BY5PR12MB4885.namprd12.prod.outlook.com
 ([fe80::19f5:ee37:5c06:900e%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 08:32:13 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Update PPTable struct for beige_goby
Thread-Topic: [PATCH] drm/amd/pm: Update PPTable struct for beige_goby
Thread-Index: AQHXTU1voBYLZYsRPkiS7zZwQASIwKrsCpsA
Date: Thu, 20 May 2021 08:32:13 +0000
Message-ID: <BY5PR12MB488599903340155602F04B25EA2A9@BY5PR12MB4885.namprd12.prod.outlook.com>
References: <20210520075435.7197-1-Jack.Gui@amd.com>
In-Reply-To: <20210520075435.7197-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9ea62b90-75bf-4a39-963c-2cd493a2f9ad;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-20T08:32:01Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc15e29b-d022-42c3-f7bd-08d91b69c4ab
x-ms-traffictypediagnostic: BY5PR12MB3650:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3650BDB16425D19346B8C1D9EA2A9@BY5PR12MB3650.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 85MO5fU8FKVnbN00XkdcCYRfOLF6lB8JObD5J3slgecrEKTnZ1+RUX7JkAB7mwrwPBZXF6bdD0r464ZVZydD74cWFXlmfesMhF5WFeUdyGQV38HtSH01bIoKuE5oJE9DhS9q7FaGf2gG/ZSWZGji8B8rLRnZds8COKWI0LRq7P7OQZVkzeB9EeoCQ6PA394KeCo6vkcTJsyi4Vhl90f8muTT50JuVMCQ6sRAo9QNezGDXc8u0ba4ZUWVyazxnkdh795O/8nMTGCc2sSLE1KGzjMIUmV4QIh2KxGmfPFcOg6fIDGg0VUdGXG20Bl8YeCYPKR0Ya6k+/RbtL6UZjCurrEZ2uLPB2cH9AkXUGe8pKJlCgPGnBaK4jv/ulMInRFVwUPXjcsButfgwf/Gdaq5l68j3SkNw2uX0i59ECf6RRdPx/voqRNliYrL/L8TysCGlzLj4nV67i3bvVnK4T3ddCWVko4sSf8t1ANLwHcQRawgYIjiYyXtmgWMa1dv1BqAw6Bi8Xm0hAs3LDttK0jOzT+iMp1PAJcJmZz+p1OQOv8q9tiCk8NhGCObdxjx63Ve67Q+EcAjEiWcixyFSUxdYvv+8HG8pHSHL3YKMJS8QhJUF41Brgr/9E1kIBlETbQpP3ToJwAU+jSgDb7Vo4tfsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4885.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(122000001)(8936002)(83380400001)(6506007)(52536014)(53546011)(2906002)(9686003)(55016002)(7696005)(33656002)(5660300002)(8676002)(478600001)(71200400001)(66446008)(15650500001)(186003)(316002)(4326008)(110136005)(76116006)(54906003)(86362001)(66556008)(38100700002)(66476007)(26005)(66946007)(64756008)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rV/v3REkbJzVd/x/4XnW/+vgwNfknw8DE075496qCi2JtY3I5BaJuGYEhOuf?=
 =?us-ascii?Q?PXP41OpD328dobuf1pYnenZsQME3vv50PXF5KnYHLC77PXAq99SCVaVgl6y3?=
 =?us-ascii?Q?pi36OV9zbybTBC59olUd/wIkBVSn5WXaJ2GtP7MNnK1MebJW03X1gbjGGhb/?=
 =?us-ascii?Q?+/Jx6/fXbZnDs//TdNNk82a2VbLeJbvgqDoEBkmDblbFumHdbSYVtoQ7yHbs?=
 =?us-ascii?Q?EJcr9dRhPzAMENC/d2xMFdyCKJPJheowgCy80QeIpPc1iq136V9NkH5QABM6?=
 =?us-ascii?Q?HbK/hfLI0W/tMfXKwpsTuoeVg/rjrNIerzrpGREKyIlSjW5d9vak7ewAzlIN?=
 =?us-ascii?Q?DISpEjp3AIVDHbqSXi2oQZzOtooMjj2updC2ZQiZkRbls8QQVcAYr/cCY+AW?=
 =?us-ascii?Q?GQR9lxYnfQuAducD5zSLaEFp0coP5knK59ps4imGS2FYFGPC8Cc2HXfrtlTs?=
 =?us-ascii?Q?HXOsIQ/EZLbyhNq7NMzUgSUcIV9W6iyNihUiuXKAUijqIaTKPGUj4lDYM/qa?=
 =?us-ascii?Q?UqIClunqp1BQyO6g8ys/XUKtwoJ/NkyZCT+E/D2NRbRR0j4CW3JJWBjJhYuO?=
 =?us-ascii?Q?Rr4WMFhog/08Jz5SpQgYr8QVl61HClj+2G3NfT+MWxNsSoUE9AqQ7gm+OlJr?=
 =?us-ascii?Q?jEwx+UFFNpTOwGiY6MEqQUKB4+yAJckZzkEUYKR/lyI7Cz1N0dxfkBrdUt4T?=
 =?us-ascii?Q?7579MjIVYDgyv5UEJwxtk5GENAacSi0CFYXLbyxbj+9ykRPEuau2g55xwwNO?=
 =?us-ascii?Q?AzYAXXQ7t7iKFTAABchjGFJ25jCaUPC27KDglML4XyC/sxnX1OFeuPvkPaWA?=
 =?us-ascii?Q?1VUIVy8GuNTAGnGVhZAdG1Tdd6RpYMyxslJHAerNAZleyYelrvt0+Sm14roY?=
 =?us-ascii?Q?T0JCmmeTIaO0FNH9ln84a+WxXbU4zz5BYUwLPpsSpTPvT1rNhcmzfRJuah/T?=
 =?us-ascii?Q?HeTEkSXyGKAfmbRcB4C4Rt5lrdO5YZPsMEh9HTPTgOQI3zV00hbnh3jKxG2U?=
 =?us-ascii?Q?S69NVQI7EJkxHWa00We7jxTE+RCCj9VgLquFTPfnszk1LBTzFzntGdYywxr5?=
 =?us-ascii?Q?JHYaH/Sd44Ve17WSzV81auvrf+iSWQUJzahCzTGxnCEGo+xPwQFfcj5gpGJx?=
 =?us-ascii?Q?Vz6yiteDADkaXN4+KhmI2OMtKFJ65sb8Dr4f3/vQ4RZCFlwjlWP388xA6ewS?=
 =?us-ascii?Q?DY5XTKhWZ8dWWJxS42A2WYHaJ3ToZD4KUWG0BmgQj/JKfwVl0rRLndTkY0jr?=
 =?us-ascii?Q?rngQAFptjiKub6U5U4V39sNWuNUrjiH4ZcAbJ0mTQr0wfEKpIEpTxkUeIlIn?=
 =?us-ascii?Q?4JUSAfHt2KA2ORdEUHvYVIv5?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4885.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc15e29b-d022-42c3-f7bd-08d91b69c4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 08:32:13.3262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+xsUKs3GtG/0gpqPhFiUcg0FrUO/vsmScCcvgz2L6NHuuYTlxiGl21VQdHLldWtN3bdXFSTNOXR0s25jeGa9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3650
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Chengming Gui <Jack.Gui@amd.com>
Sent: Thursday, May 20, 2021 3:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Gui, Jack <Jack.Gui@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Update PPTable struct for beige_goby

Update PPTable structure since SMC#73.9/IFWI-XXX.013

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Change-Id: I7f6a2dd85b367eb4ecbcfcd5141b1960a395ec24
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index 7a6d049e65e3..a1079256d318 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -1176,7 +1176,7 @@ typedef struct {
   uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
   uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages

-  uint32_t         SkuReserved[16];
+  uint32_t         SkuReserved[55];



--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
