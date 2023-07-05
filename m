Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B3FEB64D9
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 02:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94C810E044;
	Wed,  5 Jul 2023 02:25:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 862FE10E044
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jul 2023 02:25:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODBZd4AMMGUs5rvz7tmrEIyaepuuTZobxl2ZCKPe5VhcDNUwMTWILFUe63ZE1VcklrgmtWFYRWOQeKWFjcT/JAvgh8J6xhhf2s3mIKIPADKJajSv8eulWGw8JOakqprqGPA2qwq3ghAeqzJfpqoEvuGnzEUah0MzFo/eVkA59cjjXzLy1YjIUq/XLDbKhlK16QyvPcqgsO5xKvGNSCzNWDqdFJbftxCwBxKdtA1HrxK979lF+m3fq4a3y4QFwN3E5mRInalAQPGGpL7nYr4DkAQNVeTaqpIZU5pQ6scuUlGmIv7l/laJCzpUm4c1bQp9G+fGGZrJwcMbG3i0YuqTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipuJBrZ2pfuVQOcN+bSpg2liVRg4qt7JaizTw052Ysc=;
 b=jurtXZck/INFZvFGohOythsSXw1/O3eH5UDXvdNLGealMUqdj65FGuHkC/+9sd4XINxMruHp6jSYJL0KWQyfUwi3vJRrHAO9tjYmr3JsX/gqlq+mGm5Mmr5ryTwUiAhQ7+CVUteWes+eRecwCTTMw12dx6+YIkwv16MkilgUshVjx1O0b0Yu38afVJH6sixsu6WDKQPwRmMSmDaeFmrFW7Ch/i1TxSGc3Cd/wzdQDKuV8S7KECAvTnrVAhvINnHPNcQI/urUDf6MZT+9Ig/Wjd69kadvwNeliho+e6tUVpSMpaTxlfoHuiCzaRv5sbXWZvd7cigxfx1GzT3k3Ay53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipuJBrZ2pfuVQOcN+bSpg2liVRg4qt7JaizTw052Ysc=;
 b=PsZ5Z+C4JUVvyVAllJICTVEr+cgbDH03cqH+qz0vRyDlwCNKi/ujxiSCHzY7QR50Tn3bv9sP8N572d+pJyjL0hmRFh6qyNl6TWFGhMARriu+aOG61cfjQ6x9dauElqXniCJ2GPEA7kDT0nombe7oQE8DiLw+LTy2XfgQy0NmdZI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 02:25:31 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a5c5:c77c:582b:1cb7]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::a5c5:c77c:582b:1cb7%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 02:25:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Thread-Topic: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3
 chip
Thread-Index: AQHZq0UUwEPWxCEjZ02nMF35Jg5aFq+qeVTw
Date: Wed, 5 Jul 2023 02:25:29 +0000
Message-ID: <PH7PR12MB5997E56F35376475F7EA0502822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230630112135.3347421-1-kevinyang.wang@amd.com>
In-Reply-To: <20230630112135.3347421-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=202dcf06-c755-4b06-8eb7-e996c81b24cc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-05T02:25:15Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL1PR12MB5176:EE_
x-ms-office365-filtering-correlation-id: fc989c18-d15d-44fa-62c5-08db7cff19f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyP8d5DTJUQSQFiuD6UnxGI1HjvIMFsMUCMQM1fNJwKyyJUMck5Z0LUcn36lLa09G11tJ5jzDKcGVMCSVt1MKJOEj6qe+Ovzj+pstqM/kNz6OePv2/E1uUZBTgePqfWdvtZ17eObBIGojSeC0dGUT0dcM4oYipLaWvD2jJH3v429ZJcMo7sUpJPXLmjyOJppxaTIar1NYdzFsaK1Fg+rLw6agPK4IFhdxFr0D6r4ZQ3tPpXSDu2p4wtWODEQm8pSbEfqSkEuvwiwf9qJftd5N3Fzqgrzywjy7S5FqzYxQ7btaqEEse1jsv5I2tZdPntzRwCOdPkrXPKOKzHgXjh7vwme9XzCoBy3RKVawIIwNvRQQnQ3spZboFYxU4gPwzLNoj7dgSQLtZuKpWn9EzzMjaIxdgjmxTGe8hxsVJYU/mU28+1U4c4aeeHQetk1E9fSx6q4ZdjGeett3EDfREFlsHMgdlfjw0EblZ0hWQSQy/yn8K7wUGqOsrff4BqcjH+sEmMpZ1XEhDXCLH4diqDSIMGu9T4Gfm49GBZXKOI6Su2YSHxOENFLpG6wP9CBHV+PBZQVCncS2okxontCGi0sJyHDIdfys3esM8PE1iQf4sw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199021)(66476007)(6916009)(66556008)(76116006)(66446008)(64756008)(66946007)(122000001)(38100700002)(186003)(38070700005)(86362001)(6506007)(9686003)(53546011)(83380400001)(478600001)(33656002)(7696005)(55016003)(41300700001)(52536014)(8936002)(8676002)(5660300002)(2906002)(71200400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sUvDnrAxy4eQL4/WVnVXZ90GyQVTGcwcjKrMIBrPfZsgmZq1PMKl0OlumlUz?=
 =?us-ascii?Q?m81h64e9zFf+eLwd4Xew7SoNoSxhGAdUVB/Jyb4+KPoCFhV12mJ2JwAswpse?=
 =?us-ascii?Q?RxJ3cv6wWK/LkiiFb0+PBmU/OcgtGpF9UIj/K4v/qMU/y5j3TlKINa2slRtU?=
 =?us-ascii?Q?csSMAwvCXx8KLP/M3devjPWDK2XfDbaHaVaz+zIJp8n8r0je1H3sTUfkz3aA?=
 =?us-ascii?Q?5VdolrMjQLuO+WRAcNHU0vUVDSaWkFQcABPg4PCH3mWOD3FaxPsfZxINzZTq?=
 =?us-ascii?Q?Pz5LwpsnImlBNHRwRjAaKss1a2QhN7mZ9ZEV4UUcPOF/3HScY/bGDY/TcdX0?=
 =?us-ascii?Q?LlmWPMpy8b05/rh5a/fV0ya7YpwvT5gXy1SJGk0zr0Au1c2PCKL5r2y/zINF?=
 =?us-ascii?Q?9Zd7S8IKaFykuFUa0ENGA8Azdknk9BJGfff7jiOy5j7Al81l9dPbSdlJGR+/?=
 =?us-ascii?Q?7PTkNOXBjLXdA2w4Mgcg/15pkXo4mJ0u74EI+ssFch+QssX8nL2Pmf2UW+/u?=
 =?us-ascii?Q?QCscjPS3akJPU3axNv1WppVXk+P9nBpTr49BkJOtbOuFrJrhJEImWT3pdryB?=
 =?us-ascii?Q?Nmx0i9hobP1E4O78ylTF8GKqIFCe8H+18rTidV+c+LzLW9xjWn/kH3Lk4F14?=
 =?us-ascii?Q?S3hEyXHVkncNQeWd5mW76i0dFZhvOewfrJHsY2LgZpfGjvhF50hPuBezsXfX?=
 =?us-ascii?Q?saZIq6xS06ER4QBtthLeeKOD7tfKAu8bQqadE7WRALPX+hHvhQ+1gT3Odcj9?=
 =?us-ascii?Q?zszzpkk946crxAXpgCDQ++ICoJiHXMuubAlsjT6pcuKRPlisONcSUq11vFI5?=
 =?us-ascii?Q?Nnu+RQ/u9bdwG1EmZ5zAl3A8HfAqQtqapCS29hFzT1zYmlVH7wd5+H+o/AZE?=
 =?us-ascii?Q?Bk5Km6D2pEVChpFEIbHIreq/3sWTVffVj2n2u/elmxS6cnEkDWd5+CGhl7w6?=
 =?us-ascii?Q?+WZtV5GeZo7gk9E4/Kcq2IoDHlITPe26YNWOvmBarzzdxR6+uMWtinoPZ6ct?=
 =?us-ascii?Q?yX0hMpUR0dXlzNbrxCWUkyhmcWW5UGQg4ewiTICuclW24CocFdeMms8uQZBl?=
 =?us-ascii?Q?Z29d1MojpIg0iGToHi3n3RPAqpQd9cLfqqLP1CIhs6SfZHHusQP4n7LremI0?=
 =?us-ascii?Q?rnTQZP6yKTzjr4AwaCbalTzgqBeGQCtvIpjnktV8ez2qhrp1TME3sUN3v1jq?=
 =?us-ascii?Q?7r5FpkeUG5oHgoJU6T6hGx36P3RTArCp97H6tcwsFkMynxm+IknDveubaei6?=
 =?us-ascii?Q?2N+pHGzOUlh7lIt5erJpKhYxNSekSYAyfoeof4B5RvuvLVd2nYCFypshF+lb?=
 =?us-ascii?Q?JeSq+5PytrJNNpkxCCGWQ3Ky9Up+9YvmsRUi6Xowor1jwtlSWl7FZsUFbMJs?=
 =?us-ascii?Q?vUw4bac9mewpeRl5JdOp6alwiznVozBFSKdCe1yziNvDci8gulhREyKLaN1O?=
 =?us-ascii?Q?BLYiEk0IRy+lagHL0yR/cADVrftOGXJcY8AMm8rPGL8LF/RqyBNDClD66c1C?=
 =?us-ascii?Q?3z5mKBYJ0SXuBi5p13OVCFy+KYDgefesKAtdECgaXWG9YMQNal0rlQBrXA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc989c18-d15d-44fa-62c5-08db7cff19f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 02:25:29.6765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDJaJ7/thQiAmdTeCdUUQCXhoPg2FFxv2il4uArNLCCNwfYmn9Qkfyei6GGCGIyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
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

Ping...

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, June 30, 2023 7:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: disbale dcefclk device sysnode on GFX v9.4.3 c=
hip

the dceflck sysnode is not aviable on GFX v9.4.3 chip.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 9ef88a0b1b57..5bf401533103 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2050,7 +2050,8 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
        } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
                if (gc_ver < IP_VERSION(9, 0, 0) ||
                    gc_ver =3D=3D IP_VERSION(9, 4, 1) ||
-                   gc_ver =3D=3D IP_VERSION(9, 4, 2))
+                   gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
+                   gc_ver =3D=3D IP_VERSION(9, 4, 3))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
                if (mp1_ver < IP_VERSION(10, 0, 0))
--
2.34.1

