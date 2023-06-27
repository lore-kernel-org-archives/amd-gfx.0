Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937D7EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 04:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEBD10E27C;
	Tue, 27 Jun 2023 04:39:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5993310E27C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 04:39:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFUIrhfN2Ey3fzdDEQ/pyGsvMWf/Zk7R2lSzgkf5hnjEfAMNy7+jSJ9RsNobW/R07vkAarpvTjsmR8rr1k2Z92/gasjfnuDFxMJe3ZMS2nRJMU8NysGS814twKla39QKx6QbLNc9qw4BuujlI8uFk1a8A5vEiRONdOvJn1CgM9G20YAVJGYyZc/TvlbIGiLiUlB2mhse3TchSwpOIEIotgqsGdT7febHBPcxxm4bpy53a8SenZFfWvks3sMcercZbjqPMdhmHYDDxybg60mSTNSIHW8oelWM8yQKPKDMufzS0VqxTZs/wEiBBQP9zEiG0FqwxkvDRdi1nL8ovJrMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nyXMmJNfggKaX7vaQlDpd/8XPcFyKT6D9mdnPujRk0=;
 b=nhiatYY25t5fsKIafoqhQ29EcLJMByBBVli5Fo0oS28gr9Jx9p6SyJ22Jj+/9WZh3fYWstF1imX+fYUmKqxrh36brOlQuHcSzsc1Jk85RQWKYn+vi64mVUgEezQvFueP3ndJBOQrpFM3+5rdIdAAK0eKEXW3DW2xmt0EliYjJBchzaT0wnw9pkYbvTiDydBo1PwLbHr4WDb8KnP5Eo/eNkMfbeSFNCiGMrLqOrx5RwhzR7mlRUo9sAkum50yCn09WkGb55HIHFRZsjt1iBfoV2n4HHEbZbE5kH6Cv75dcwMIsLsOw7zaA4Agc7mceGMi1PXUDQxROCQQPzTRz1Ghaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nyXMmJNfggKaX7vaQlDpd/8XPcFyKT6D9mdnPujRk0=;
 b=ATmhbpnP/alneDREpG2d61cDjR4w18XUcpqS3KYhYFOHx5JlN+WxIzAf4GqYSqUbnu6ZySGXlb1KoesQ7iOL28fCYN3hBjumw8jQ0TgYSsjtIJCRAD73wxxgq2P/99DROgednQxpPFgzELEqzLxjlF5Yok1O1sTPD6YuYeBaqaI=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 04:39:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8f81:b929:d2f9:4ef0%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 04:39:13 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs
Thread-Topic: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs
Thread-Index: AQHZpEMKkW5yvcAYeEuMtW0D8KApha+eGhfQ
Date: Tue, 27 Jun 2023 04:39:13 +0000
Message-ID: <BYAPR12MB4614E4E053F51FFC8D5F2C7A9727A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230621131914.2116641-1-lijo.lazar@amd.com>
In-Reply-To: <20230621131914.2116641-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0bc71f14-eb86-409c-9834-6a1eba6ca5f3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-27T04:39:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|PH8PR12MB7112:EE_
x-ms-office365-filtering-correlation-id: 0da2f92f-be4f-41cc-8e59-08db76c87554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8B88jT8GJQSyF49oHE22KZlxoX8S494LGZEHPt9VvmO1y12D4MjsiVHmPtXdWVCJDrraiCC+DfImIxtIG+pgb6tAX3e6gFH0ZAPpfolvGaTSXS/5kzomYPDi0QwP+bgy4hWgrAlYmtKunsJV14HUG2IYVVIBZC83QgIgy+wSWZgLjrVkI+lIfr4oB/w8R4xPxJ1VRWDpdZfnm/qV4OlgaYWpaaeOC0lKaNNm+aJJfhTIA0YXnjG2wWTu1sAPskpcSwvF+Eu7hPwOHePwr/wYP9SctDmRSqd0dHk9xekGMoPKBj7NJ39FIBlT4v7TKPk6NU/SghUPd2vAbQXY0DuSXKTcLAFS0kB2LH+lWmpCg7w0HKIbaZLk2hOskRy1VFnQF5/szI26N4t4a9Ilyp684BaezBTV2fS3Wot3FiXVP7WzDr5vVWLdvCuMFGBCc8Ib0zIxySZ9iYsRPuf4MQxXuC7M/ZDvFKUGbiFkZcfrz3znqvqoJdN8sdJqisqKoJPuQ4F9LhsvjT8Oa0nS/qaFwJJVPXkDw6WEmjObnT4mcABqldG0+Sa2AMM15K1KfIKkK+tCsUU16+e8hQkkSXUtyD0cY5qaBZgA7Xt3v4qupfw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199021)(83380400001)(7696005)(110136005)(478600001)(54906003)(53546011)(9686003)(33656002)(66556008)(66946007)(2906002)(26005)(186003)(6506007)(66476007)(64756008)(71200400001)(66446008)(316002)(52536014)(41300700001)(76116006)(38100700002)(5660300002)(8676002)(8936002)(122000001)(4326008)(55016003)(86362001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dxSpvRf+QEqy1gH9H4xIIsDAD1aNwhzq19kk4nKQqsA/yszoTMB3JqNfg0TJ?=
 =?us-ascii?Q?KwPgsGXt+OnUUqGyL9yfS0za6RmpfXDOrq2yJCFCE/sSVDCVbhtDkyYdgl32?=
 =?us-ascii?Q?rPkxYuagr3vIabL6qlJfEL2AP3/VJud41l/DvdzB6SYenxjvH48Rhc+ePuIY?=
 =?us-ascii?Q?ylVD4KWKub9oQamRSEnuVNDXIVCVh2iQi3qOnutCQWC7jeC1ACO/y4ZI6+b6?=
 =?us-ascii?Q?WlE5kk04+w5dpG1ATT+aw7B+6e/3EF3+zPZwudhJIH3UPFuC0R++jgTvLjS0?=
 =?us-ascii?Q?6PlQRnLk0ME1JUAVIj00KRp2/QUzyJHSsr2/bbeWGaTk0mp0rxm/V2le8F8f?=
 =?us-ascii?Q?T8WK7HtSgJScV27pmihulWadXCC+tZoagyAlaSrpibadKF6e2AofBUjv77Gj?=
 =?us-ascii?Q?x/hqB+Qcwm096ngrKhpS4reK+kuLPYix4673ipWCeqiQmOWRAZkh9C6P4dN7?=
 =?us-ascii?Q?4qkXEDYC1ul63BK97P5ezf0O5BW9r0u3Moo4IsDXxNesfGzSE+DIJsK37pUu?=
 =?us-ascii?Q?KCjBec8PyiHufbNyf3ISroPwbKD1ih2Yp9qtG3xchubbwlShElkzn8SbnhVL?=
 =?us-ascii?Q?NrgHU7v6x1kxYwjLWzP4rxlGfWCjGVA4EYO/v9acDEHj/ExSVnr57bGrkbsV?=
 =?us-ascii?Q?vSgLuNohWeagnP0SbzI83pvZQqyCXpbxPqa2DXk5cu5/3RPEvPEGGezvXOS+?=
 =?us-ascii?Q?jxbNPJGKwjgRqFBLbkECqXZJv9v3n8hm6bN7K+UQKVm/wKtXeivhbp/FXvi2?=
 =?us-ascii?Q?I4bizvLpan8pwJI1zxymTphAFFu+AaXeDgKuGLKO+51ILD8i9ShTDDKmC6vn?=
 =?us-ascii?Q?TjEJvai2DAhfW0J8WJM2KPCJJMXJ4taeFa9cNqoNnZ4wDkEo791t0D23/2Ht?=
 =?us-ascii?Q?hmEkFkf0GDKHhSMUiDRsEocdcxIvCGTM4AAmF87ETSRtEEPuEvQXSbdJI2Ig?=
 =?us-ascii?Q?o4eVeXj3sjw8Ce99UL+NViLDd/9CS61q4cFosd2gucyPzY60IXuoFZjUd+fA?=
 =?us-ascii?Q?GEuljcbIHkonLNNvn5KsPBKFhjNZJhNDmnKunSHdvWhK5uU08IPmrhX+6bT2?=
 =?us-ascii?Q?DyPV/j1r1gYsOsu4+F3rv6n6QEjU4WB1zrIEF25Q0U1POcNVKSW6MEOe3l31?=
 =?us-ascii?Q?QA+cqejhoqkbNgp4b00vwmmO4enezvR/VlFwDpuewvV2HQ4nRIRtEjzsj/WC?=
 =?us-ascii?Q?ug4gHFtqY/RR7I0MywdpeuMiiG6iZlI/pwjdFHOmxrUT3vn4fGxCSUda6V2c?=
 =?us-ascii?Q?+3F1VKERb1UVYrvuhv6DEnPKnXazCAiMvIPkWAwFhLdIT4wETWDmGbqY6wOL?=
 =?us-ascii?Q?VZnlRxe5ustLqOAegEpNAga/kplBjzFU4Lc5MHzRmzVZ+SW4lqRefasW0FMT?=
 =?us-ascii?Q?iG6mg1jIqCWqWgrL1IGftVJ6m/Qe0iXevtvvpozWmJwJ2keO4iXgKnUfPme9?=
 =?us-ascii?Q?C96OEtBUHRntOoMuzCjBTznAQhb7KNqQ15DIYXhXHc+5cL/wI3k3twRDvBlu?=
 =?us-ascii?Q?pYX82HQRDsi37xkJIVONLN9KxXo82BkfydPZMVVsZhyvNkGUT9cnhuMLSb2l?=
 =?us-ascii?Q?dlAlmthlzrL+0LwKweo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da2f92f-be4f-41cc-8e59-08db76c87554
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 04:39:13.6537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LUyrC6oAiJTEbDf2G0E822/aL1KPOFhAvc6KJzUc1wesWa2Vxncbb9jrjFofTWW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Kamal,
 Asad" <Asad.Kamal@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

<ping>

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Wednesday, June 21, 2023 6:49 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Kamal, Asad <Asa=
d.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs

Expose unique id of GFX v9.4.3 ASICs as device attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 386ccf11e657..9ec51f50fc52 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2072,6 +2072,7 @@ static int default_attr_update(struct amdgpu_device *=
adev, struct amdgpu_device_
                case IP_VERSION(9, 4, 0):
                case IP_VERSION(9, 4, 1):
                case IP_VERSION(9, 4, 2):
+               case IP_VERSION(9, 4, 3):
                case IP_VERSION(10, 3, 0):
                case IP_VERSION(11, 0, 0):
                case IP_VERSION(11, 0, 1):
--
2.25.1

