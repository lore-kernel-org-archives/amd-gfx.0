Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E24C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 10:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C46D10E408;
	Thu,  4 Jan 2024 10:40:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7EEA10E408
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 10:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkiaqK9NHeyI/Pje1TOUO5seZ6b8GfZn1QEmnf53VuB2c5CxXG8ltvrrWTOFY4VXcVyNDS354yvADu+mo2K/PlB0mLf2rVGmU925WEx3cPAXVqxWnVCsaZXWkryxQ/wI0M+c7fp4P6k1xnX+fWsb3CQ4AY2qUXxWIeUC5ALpT7QS/ZwB2jq56aWwvoPsTFf1Q8/OCgk7E65EJPJCFdN/lEBQ0h/Fj2JELTHLPR9rizWq5fG84/xoQOC+io/n/jRko9KX8sFJ57uTM/N6Y8OOVjVpN+knosbZSJH2uK0kF6+1/S0fTZrY25OvYlietC1Xw7qrYXBJ4y2Rh9SVRiy6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqM1OFTzVZQUf7fb+0qdkR6BeB4W9bGaohboWcJx960=;
 b=SHNoV1dx8StMlDRCL8DEnjiLJgl82TFoZtrVf1LvoqgbYE4JX7pxS4GnBfowwuPrJD6Dfgan7j2EHNNuX1a8a+Yv5tyhIXJl0hJdgHWnjbU1kNHFFLUaGTrOZBJQ6neHlRtMI+MkpyEO4MbXuqcvUifL/Ay5ABWAAn2FIrMazdUngZ0ouVZG9Q3iiccGu7RC/GqaJ6+KP8aGlv0P08opBxQzOL3airPfNwsRRx/I8t2MAV62W2N37PsA2iMsewwWhEyqcaCmIIk2GNUWJ2efHbRz6f2+lNrMSNyopb6NxvC55tJUTBURLXRTkPfUmFpVtWjJP5BWpH73yIQHQnG6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqM1OFTzVZQUf7fb+0qdkR6BeB4W9bGaohboWcJx960=;
 b=CSAfIKrsJ+M8rNmNZfCF04y7P2bqY5YxuVWMoiGrzxe5/XPJi4TpBo55dUCkE5lq278C9/F3Hd5PU570iwNGnNjQi03VFOudIjSKHJQHYdMTwEQt8mfqqGFis+elLGAfY+11Roui0yfx2oOj5pRD9tAQwPOs4/w9hSyTSrApq70=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 10:40:42 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 10:40:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Topic: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface
Thread-Index: AQHaPhtm5AMWhrYRZUWX6LIOLkMU07DH/JWAgAF7/yA=
Date: Thu, 4 Jan 2024 10:40:41 +0000
Message-ID: <PH7PR12MB599758FCFB0F2A0B49431C1B8267A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-6-kevinyang.wang@amd.com>
 <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E7AB112DEF6062FF7769FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=fdcc984b-5deb-45cf-8a74-8368334f15fc;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:56:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4072:EE_
x-ms-office365-filtering-correlation-id: 164e9539-1435-4c0b-b4c8-08dc0d11996a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7kSiF70SVVTto3JY59z/Cok6FuZfCYXV0YjCxsP/QW50H7nk69Febsxlaw1k2p16mB53VphMB384sVlqh/F/nNPHzVvVx8g0klyXIeffoAyCLr5FcwcWSSwJtGGAnrgK/FFFjiy1kLKqpWKPNigTsgnNzie7uheL1blaAq/eCh/6WdR/1bkc/bQaqs7iPREJl+Ups7QlZIseetA8MgUJv2nv14edkBjcc4a8lxptgVeBMYFU0KBwk2WAL6DhJe/v1TiKOaRLgUfQSfHP1kAvMzcUQqrQFqpwcwuAAAVqbY5w2J8VQzvNkVkafuBKy4O7oZ8LpPiMhZl7cFQL6uuSKhumkJ1z/t7JhiWUZ08wAsS5C+TfavszbLRjE/hbolP92RuIcA/bavvEOqd0aXAbrsQ12sLzj792zsVW8/RXka27T8yvhHgmjgVKjvy+WLSLhI6FR4nGX3KVGFy9WcYcHjsA6Xk1Q5znNfZYD8WvM9PstD97S1QY35qq8Sz5A3GJ+iTQ4zN3+kxOVwOrB+8QEOBQa84x7BAJxAn7tx4bUVaD9t0a3CBDvybe8Q/ylTykavNFix5bwdRp+BoieFnBIUwsbestDZd/pCAbJrpc5wBqIwL1KQG2qkaDCglZ3ss
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(9686003)(6506007)(53546011)(55016003)(86362001)(7696005)(478600001)(71200400001)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(316002)(110136005)(54906003)(33656002)(83380400001)(122000001)(26005)(38100700002)(5660300002)(8676002)(52536014)(4326008)(8936002)(38070700009)(2906002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4MO5eWdRQp8uwbd5WlP0ggztPKopvbvzYAzIDMwzYTtar6C/FqLzdNiaFO8Z?=
 =?us-ascii?Q?puMxjhUo4C4lYr0iN4BAY/Lu7Opp4ZKd0u+kUnuicLBAe4Fq6mvc3SH0r97P?=
 =?us-ascii?Q?VmisUCbIwxIK8Lqqwd3TNKkTDw8U6IUN0BG4uqasZCUlQp6NZ+if+5jv2FpE?=
 =?us-ascii?Q?sMeCBS4pQJGo7Es1yZ+P/ojij4+2QV0dmQCKDc/Q18UhJAqAjjbuAy3w65ck?=
 =?us-ascii?Q?JsTZPlHUEOz/qwKuRctD0yaTOmkHCBf4WM7KK+XpBMRq70IAL64jGjYrTM0a?=
 =?us-ascii?Q?BOWwAeWWUkY5UsEqH5i+7ig5Tohz/jDLhrGwrwYE8fwvc5peGhRfcP3oTzvo?=
 =?us-ascii?Q?bXHL1v0RN72Y7BjZxBSWudV2E1oh2lI7vZCCOoby2Z+O84xQuf4pC0yFdpjc?=
 =?us-ascii?Q?lwR3/cwwqJSQQE0sgzQDF7iPRctiMbsB16EBQtop7yTgJZCw55hfAl0DDjg6?=
 =?us-ascii?Q?bVP8qKyCTyy5PcQiaT7oL4CAHTGFbUcihoradMctnmZ5sQc1tWEIThSFdgML?=
 =?us-ascii?Q?Bb2Q3/4vyYnjAdKWYT2eq6INBQplarP6p3Era5whdySaIESNJ7hVR7F33kgG?=
 =?us-ascii?Q?juoqwLkFSDjwXh3OLrsN554P1KX/QtIUQptXkAHox4svMRvbrzIp7un1zOTP?=
 =?us-ascii?Q?uaf6wgIzWhzAJ1Iz3Jep+LXojZXj8s8Rx5lYxBfQBlcow0cM3mEXLyuOTRBE?=
 =?us-ascii?Q?/EmpnX+w6kJ0W9lg77J34IR5t6tUOEoFChD3jf7Lqu1bIpIru/JeDYMxr8sY?=
 =?us-ascii?Q?oirR4083HbjvvZZxEtY8xeYwWyA9Ga048fEXmJaWS5EftTTvqautE5+i4058?=
 =?us-ascii?Q?70qO832YWk67OellB2zVp1YwPb4rAkKiSLaq/V8Ox9NpHd6QtSMcu3fhEXm1?=
 =?us-ascii?Q?/W6wftJw2JJiZ1kOnlLwlxoPoLgNG/CiZjjECXTDsEeiD0J7GCH2mynUty6G?=
 =?us-ascii?Q?E++Eyud434/DdJmPFN7l/hsgDpsPeqVxMhKxMm+aqzUkKDfMvIgzqhP0z5Yy?=
 =?us-ascii?Q?l2wKHdcylVd9k36Wk9OxQEyaDW+UyMq1XGGV/H0hKRAUXSp+OMgqm8WEu49U?=
 =?us-ascii?Q?2ExexPBDno7cfF6mjmkf8AE4GKVPvw7RY60T9pK5uVN2T0gdj50LhR+2ymsZ?=
 =?us-ascii?Q?foQgS1FeXjTP9tQOxJXtdCukAWzlnHGWrkx3Pl+u/k4XTgcl40F18neGjuX3?=
 =?us-ascii?Q?iLfD8CwZ4637qK6Lo30G/EOJEoXz7NnKgrj0zc/T+uYOrvEIafDr0rEBjpov?=
 =?us-ascii?Q?FvkilTTrBFMA36wlb5Cnuh+yNpBc/bUBbyz6oNMPT84OvyVp9Ulvh96dYt5O?=
 =?us-ascii?Q?ZCGEx9+FdGR5EcdHvQtGxK4Nf+4wQgVuM+sN7OBprScydlVIoJB6OEWGpijA?=
 =?us-ascii?Q?8qtPzpi4IQLx3azATWkWpRu6JHdmsBF4Y2vlRTPnY2CrxpW0ru2zWrPZmOod?=
 =?us-ascii?Q?P/S51c5vvtCN8Mzm/zbMcOUQY2ZKxtbI8ZKHAPo3QUJiOi58S4q/pU7eCf0q?=
 =?us-ascii?Q?7s3iXWf/HJhZzXEmpjU0pLtpm7HdYALAr12uETaH8xVrf2a7iPucz5lb+V6K?=
 =?us-ascii?Q?l4B7ODm2kdxhKwstx7g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164e9539-1435-4c0b-b4c8-08dc0d11996a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 10:40:41.9056 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SuoxQKp3GKBwQdck+S6aX4ExDb+aDkWRw2P9y/7Ycbr3QoHUauKL2TqNjHf7QUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

thanks, will update it in next version.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 8:00 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface

[AMD Official Use Only - General]

I assume we are leveraging error_query_mode to differentiate aca path from =
legacy ras path, right?

But given in-band error reporting is just the start of transition from lega=
cy ras to aca, do we need a flag in amdgpu_aca to indicate whether aca is s=
upported or not? Accordingly, we can initialize the flag in amdgpu_ras_chec=
k_supported. it should help us to differentiate aca from legacy ras when im=
plementing other features, thoughts?

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 05/14] drm/amdgpu: add amdgpu ras aca query interface

use new ACA error query interface to instead of legacy MCA query.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 88 ++++++++++++++++++++-----  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 12 +++-
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 038bd1b17cef..bbae41f86e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1168,6 +1168,53 @@ static void amdgpu_rasmgr_error_data_statistic_updat=
e(struct ras_manager *obj, s
        }
 }

+static struct ras_manager *get_ras_manager(struct amdgpu_device *adev,
+enum amdgpu_ras_block blk) {
+       struct ras_common_if head;
+
+       memset(&head, 0, sizeof(head));
+       head.block =3D blk;
+
+       return amdgpu_ras_find_obj(adev, &head); }
+
+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block =
blk,
+                       const struct aca_info *aca_info, void *data) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       return amdgpu_aca_add_handle(adev, &obj->aca_handle,
+ras_block_str(blk), aca_info, data); }
+
+int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
+amdgpu_ras_block blk) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       amdgpu_aca_remove_handle(&obj->aca_handle);
+
+       return 0;
+}
+
+static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum =
amdgpu_ras_block blk,
+                                        enum aca_error_type type, struct r=
as_err_data *err_data) {
+       struct ras_manager *obj;
+
+       obj =3D get_ras_manager(adev, blk);
+       if (!obj)
+               return -EINVAL;
+
+       return amdgpu_aca_get_error_data(adev, &obj->aca_handle, type,
+err_data); }
+
 static int amdgpu_ras_query_error_status_helper(struct amdgpu_device *adev=
,
                                                struct ras_query_if *info,
                                                struct ras_err_data *err_da=
ta, @@ -1175,6 +1222,7 @@ static int amdgpu_ras_query_error_status_helper(s=
truct amdgpu_device *adev,  {
        enum amdgpu_ras_block blk =3D info ? info->head.block : AMDGPU_RAS_=
BLOCK_COUNT;
        struct amdgpu_ras_block_object *block_obj =3D NULL;
+       int ret;

        if (blk =3D=3D AMDGPU_RAS_BLOCK_COUNT)
                return -EINVAL;
@@ -1204,9 +1252,13 @@ static int amdgpu_ras_query_error_status_helper(stru=
ct amdgpu_device *adev,
                        }
                }
        } else {
-               /* FIXME: add code to check return value later */
-               amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TY=
PE_UE, err_data);
-               amdgpu_mca_smu_log_ras_error(adev, blk, AMDGPU_MCA_ERROR_TY=
PE_CE, err_data);
+               ret =3D amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_=
TYPE_UE, err_data);
+               if (ret)
+                       return ret;
+
+               ret =3D amdgpu_aca_log_ras_error_data(adev, blk, ACA_ERROR_=
TYPE_CE, err_data);
+               if (ret)
+                       return ret;
        }

        return 0;
@@ -1254,7 +1306,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,  {
        struct amdgpu_ras_block_object *block_obj =3D amdgpu_ras_get_ras_bl=
ock(adev, block, 0);
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;
        struct amdgpu_hive_info *hive;
        int hive_ras_recovery =3D 0;

@@ -1265,7 +1317,7 @@ int amdgpu_ras_reset_error_count(struct amdgpu_device=
 *adev,
        }

        if (!amdgpu_ras_is_supported(adev, block) ||
-           !amdgpu_ras_get_mca_debug_mode(adev))
+           !amdgpu_ras_get_aca_debug_mode(adev))
                return -EOPNOTSUPP;

        hive =3D amdgpu_get_xgmi_hive(adev); @@ -1277,7 +1329,7 @@ int amdg=
pu_ras_reset_error_count(struct amdgpu_device *adev,
        /* skip ras error reset in gpu reset */
        if ((amdgpu_in_reset(adev) || atomic_read(&ras->in_recovery) ||
            hive_ras_recovery) &&
-           mca_funcs && mca_funcs->mca_set_debug_mode)
+           smu_funcs && smu_funcs->set_debug_mode)
                return -EOPNOTSUPP;

        if (block_obj->hw_ops->reset_ras_error_count)
@@ -1773,7 +1825,7 @@ void amdgpu_ras_debugfs_create_all(struct amdgpu_devi=
ce *adev)
                }
        }

-       amdgpu_mca_smu_debugfs_init(adev, dir);
+       amdgpu_aca_smu_debugfs_init(adev, dir);
 }

 /* debugfs end */
@@ -3138,8 +3190,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev))
                return 0;

-       /* enable MCA debug on APU device */
-       amdgpu_ras_set_mca_debug_mode(adev, !!(adev->flags & AMD_IS_APU));
+       /* enable ACA debug on APU device */
+       amdgpu_ras_set_aca_debug_mode(adev, !!(adev->flags &
+ AMD_IS_APU));

        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                if (!node->ras_obj) {
@@ -3422,7 +3474,7 @@ int amdgpu_ras_set_mca_debug_mode(struct amdgpu_devic=
e *adev, bool enable)
        if (con) {
                ret =3D amdgpu_mca_smu_set_debug_mode(adev, enable);
                if (!ret)
-                       con->is_mca_debug_mode =3D enable;
+                       con->is_aca_debug_mode =3D enable;
        }

        return ret;
@@ -3436,22 +3488,22 @@ int amdgpu_ras_set_aca_debug_mode(struct amdgpu_dev=
ice *adev, bool enable)
        if (con) {
                ret =3D amdgpu_aca_smu_set_debug_mode(adev, enable);
                if (!ret)
-                       con->is_mca_debug_mode =3D enable;
+                       con->is_aca_debug_mode =3D enable;
        }

        return ret;
 }

-bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev)
+bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device *adev)
 {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;

        if (!con)
                return false;

-       if (mca_funcs && mca_funcs->mca_set_debug_mode)
-               return con->is_mca_debug_mode;
+       if (smu_funcs && smu_funcs->set_debug_mode)
+               return con->is_aca_debug_mode;
        else
                return true;
 }
@@ -3460,16 +3512,16 @@ bool amdgpu_ras_get_error_query_mode(struct amdgpu_=
device *adev,
                                     unsigned int *error_query_mode)  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
-       const struct amdgpu_mca_smu_funcs *mca_funcs =3D adev->mca.mca_func=
s;
+       const struct aca_smu_funcs *smu_funcs =3D adev->aca.smu_funcs;

        if (!con) {
                *error_query_mode =3D AMDGPU_RAS_INVALID_ERROR_QUERY;
                return false;
        }

-       if (mca_funcs && mca_funcs->mca_set_debug_mode)
+       if (smu_funcs && smu_funcs->set_debug_mode)
                *error_query_mode =3D
-                       (con->is_mca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_=
QUERY : AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
+                       (con->is_aca_debug_mode) ? AMDGPU_RAS_DIRECT_ERROR_=
QUERY :
+AMDGPU_RAS_FIRMWARE_ERROR_QUERY;
        else
                *error_query_mode =3D AMDGPU_RAS_DIRECT_ERROR_QUERY;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 408e21c3cc88..2afac9aa381a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -442,7 +442,7 @@ struct amdgpu_ras {
        /* Indicates smu whether need update bad channel info */
        bool update_channel_flag;
        /* Record status of smu mca debug mode */
-       bool is_mca_debug_mode;
+       bool is_aca_debug_mode;

        /* Record special requirements of gpu reset caller */
        uint32_t  gpu_reset_flags;
@@ -530,6 +530,8 @@ struct ras_manager {
        struct ras_ih_data ih_data;

        struct ras_err_data err_data;
+
+       struct aca_handle aca_handle;
 };

 struct ras_badpage {
@@ -781,9 +783,9 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu=
_device *adev);

 int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras *=
ras_con);

-int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool enable)=
;  int amdgpu_ras_set_mca_debug_mode(struct amdgpu_device *adev, bool enabl=
e); -bool amdgpu_ras_get_mca_debug_mode(struct amdgpu_device *adev);
+int amdgpu_ras_set_aca_debug_mode(struct amdgpu_device *adev, bool
+enable); bool amdgpu_ras_get_aca_debug_mode(struct amdgpu_device
+*adev);
 bool amdgpu_ras_get_error_query_mode(struct amdgpu_device *adev,
                                     unsigned int *mode);

@@ -821,4 +823,8 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_=
data *err_data,
                struct amdgpu_smuio_mcm_config_info *mcm_info,
                struct ras_err_addr *err_addr, u64 count);

+int amdgpu_ras_bind_aca(struct amdgpu_device *adev, enum amdgpu_ras_block =
blk,
+                              const struct aca_info *aca_info, void
+*data); int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, enum
+amdgpu_ras_block blk);
+
 #endif
--
2.34.1


