Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EEC4167B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Dec 2023 03:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4950F10E2F3;
	Mon,  4 Dec 2023 03:17:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1266B10E2F3
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Dec 2023 03:17:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBfinh5AgJSeSot53jxwqqhliXYhFTLUtaUmCfXiPnyjeDbmVNBUxHyP84ADBz8ZhAJLhhgHF+UUnNkfxNNNR88vvbA5dXShgfKk9L2MVizVQVpO1a1ag0uZSiHTecYBbMBwEsYEo/hIeLWODnCF1t29yJtVIaGssFhfRzQm6bYXE2b5GaNsNeuIEeOoBTRf9hND2rTE8cTzEquvyk8WJpqLp+qQzdoxnhBwLHkh08LQVmMDC23MVxsnW1uhZ81arZI3QR2IlcWCnu/KI+2ghnpwUJMo4j8hpTXUFjW+MIgYi4WrdHV5RKEjsiQ/dL2Oig8EbkTvauOAl7Fz2ec9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8LcLyCuczRbmu2zfI/WhL/RYCs0Dg8kDOKnmYF2hiQ=;
 b=IE/kiSVVdaq6zqMuHx7GgPPp5dr16C+7dj2pGYuRt4VCLYIeHmQvMfjdY5X9LcVFPxq6m/IGWl39xLK+MWRDurMIcE+a0penbb/OiYnuQBthfwoYycG0Bm9KGpPVDdg1prlZ98Xy0zkT2m3TE/tZs9QUWUiLZsg8RiX+qsv8xkmEA/SiZAkJBQSLiFUGu2QBm+U59Jcmyy0mQcGOq+2o1+za6hkuVQWi3gv/5SaK/5UaDhYpgsJHaBF4tyS9obZdIk2FCSx8k6qMPw72mixGbkLwo+AWzvyyiz41Gh0Q3L1lcZ2IkTud0+Lh8ATaISJF0RCv4NBKdJvKL+VIoalvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8LcLyCuczRbmu2zfI/WhL/RYCs0Dg8kDOKnmYF2hiQ=;
 b=AeLj4kNQ0IUt0Ohe1uCItV4qh1Zkedv2NqXWAmXWND82pVYN10yv0P9O0knUAdwFdVWYlbTt217Z2niFQ+I7J3hC92UneTxdnSLbm5xkjiu0fuPkZ7QOFryZYBIN/OjoY/3PzeaDTkaRCVXd6ovQ7+HfPwgWUdhEufktUnz0ZZs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:17:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 03:17:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: optimize the printing order of error data
Thread-Topic: [PATCH 2/2] drm/amdgpu: optimize the printing order of error data
Thread-Index: AQHaJl4z4hfnMJdonUirH65VXuRYsrCYc73w
Date: Mon, 4 Dec 2023 03:17:01 +0000
Message-ID: <BN9PR12MB525741C283DC0A710586ED95FC86A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231204030121.2862186-1-kevinyang.wang@amd.com>
 <20231204030121.2862186-2-kevinyang.wang@amd.com>
In-Reply-To: <20231204030121.2862186-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=01b40dc2-bc29-419d-9a74-a7aeafafdf4c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-04T03:16:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY5PR12MB6645:EE_
x-ms-office365-filtering-correlation-id: 2f41516d-30ed-4120-e0e8-08dbf4777b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjMpgwIsGWJlMcNmQYYXgevyf4f18Id2Xrswl7NJaAHlOtLaGt5UPPjTQEVxG7qqOkUxD2qmV93yYJMSd6ZcjUq1BS1eed/rRB2zLZK7elDdIguljD6jnPZnA417qE3aVPsbPmwsiRIeYnwcTu09iJxPi32OIJmV0tFwwVT4jNfKBx+UR9kEjKyn9U2YQciinvxXGpqXK/PWJLYa65cKhJOn9q3J93IKw3HQqc027wMa5WM4sULZrwY9nCAiJDZccjsmakCvT750uPniHkxM8i6qsjhhDVSZ34yg/HZlhMKL9aY//2RcPC9ys/KGbgTsv8JENZbahFocXzGcdpxX1pol8LHQ0PIbZnfK/rabWpxOvU7dFrK15PXvaYSRgdczFza5HoGAGoN9Nzv3bX1vsneVyq08NVahoC70B9VUvPF2AhQiULdjg+EeYedcbWaujkW8icXZu9XZWSe+YCcuf+OLiFOdQFC2veaAVcVnelqZJcB2gwSCm/DHMoEReHXb6WV/ZJHVBHDOcSt9N3Zmd1WtGTStwILmlh3x7ThzoAgRiyw0KRNauVV8TagBM/ZfP9yc5mmxSgRTAKZohDDW0Fvqp5kLf1Oo3jGrz+mF9g5nqkZj66cwDTK0NyPqPxJB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(8676002)(8936002)(110136005)(316002)(478600001)(71200400001)(5660300002)(38070700009)(41300700001)(33656002)(2906002)(86362001)(52536014)(83380400001)(122000001)(38100700002)(55016003)(6506007)(9686003)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iirNawmkUb8IvWeVyx2GtednlNyhzbYqTfEAMNtH8BlVASb6jfk9KLfweuaE?=
 =?us-ascii?Q?RW5W1sgGUzyqd9ARhNii9LNOB/3OwkPUTklEsy82rZsn5ewM578kbS2bsmwY?=
 =?us-ascii?Q?AI/YpKs7fZQCtiV2GkJALYN0XMwRdtDth2KIylkrYHvDaESKdXgKw8dG+64U?=
 =?us-ascii?Q?n/fV+YDiorb6qEG6ObH4GcX+2FgyqdyyuocSncZiz9JkKZKPJSBvRRLAc6kF?=
 =?us-ascii?Q?+wdBBrs5h4YHKnH67iaZn8d+Ga9rJOiTifu+MIRpZgZhYtj6mU+tmcfKaoN/?=
 =?us-ascii?Q?0xk7kxPk8WpDRBRXxmVQ59guuJNWyBWNt54jIDX/J6oP0dWKg8805YP80Oma?=
 =?us-ascii?Q?PvalhAP3qDr0g1/MKvJtMlX3xZvoM/FO6z6g4/n3+COSDtIpcc8Sa5JTF7OF?=
 =?us-ascii?Q?u5pE3WaC77y0WIbXc66dGUB7HeZdyGfawjiST/cJirZXVdFDYIphCvcSkbBR?=
 =?us-ascii?Q?Cya7jimljer7seNycS5dEpZD6IzMSDKorQdST8dftWRnV7C4HdvoiAeKEAuW?=
 =?us-ascii?Q?FluqSJodq0G9DoGYP8gHZBOe9ZMt4HSH1eHVN7IXk8ScWuXZmbjKbmurGY0G?=
 =?us-ascii?Q?KQRY3BMGle582PgQ+HuQcb/R/gOET2ov/k1lGIzvmAt+5MG1+MV9yGjKYEH2?=
 =?us-ascii?Q?m8S7/pBvLdt04mg5NzvUXZ6CkTLyVj+4SLJTZnrQIzigDdv5ZnsngtRcquYu?=
 =?us-ascii?Q?I1Dc4mrjob6gBvsW8x9t0pfl6xWasE1dC/1NOcNA/8EG2eKgIU2Jv7YdbIGJ?=
 =?us-ascii?Q?28jHw0np12I//tJgBEgNb16C5/MwZVMqcK6HY3cKolVNWBU2h/ziJBCkTrlE?=
 =?us-ascii?Q?WIUVJd6Y1J4OmsSzak32s3aDDEeH769UM+BCXdnNDUjRqkEqQBvD2wRkn2Qe?=
 =?us-ascii?Q?jLcC3gpN8aJNncOMkvvRM2aWPj/RvM80WaVwZc+fe+v0jyQSkreXKU79nEhM?=
 =?us-ascii?Q?ao2UzzL0ogjgCKoJezpY2SG8JeYKP7pA2fbOol6nKzQDOpiDpW3QyQv9q0MO?=
 =?us-ascii?Q?aXaU/sV2ey3tkJT35+ffn+BHP9ByM+kd6gVLqzCWHidXmPBuhiT2Vm3fTyPG?=
 =?us-ascii?Q?2ctjS+5YRmgxbtn57cwFqAF4mBAFxN1eTVygKwojbvmKnUUCiKu6C5Aq3kVQ?=
 =?us-ascii?Q?CseKcSW8Tad69+nlM5FTegVN/fQFe4EgsHSe5gv8yldErxqE6IMP7R11cUrn?=
 =?us-ascii?Q?yuu1/OO9hUgGD1t296rfUK2Tcl7tvOiDx/bJWX3WFBwbKAkKFuLfMLnUqbhT?=
 =?us-ascii?Q?mxlRcpWiDP4n4Z0fb2b7rNfpk7swBvWW7w5aPLxuzwFP8zZK0WkWzcrQnWlh?=
 =?us-ascii?Q?XrGocayX9omsm/LXeDOF+/r6ny/24E+rLETm9axlAo7WuCZhwmGNj9Aw1cPs?=
 =?us-ascii?Q?PLLMwDI/nr8kjqmI3h6U9Ir4gb38Y9hffWPqZeW4sRSPC++N9ltcK3JcpaBA?=
 =?us-ascii?Q?eQPaK/SJRSmmwYnyT0F3tLIEdqOGx2RNlsru/muelb7qKfo6H1socVcfHz3U?=
 =?us-ascii?Q?03oiOxVZn/mkv7yI4Q1HZhqbFqpilxQkzXu+qDTIYoR4vHgwPCeaFFAPrw?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f41516d-30ed-4120-e0e8-08dbf4777b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 03:17:01.3639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Da1Xx7VNun/buBAlaKNsrgJujC5CP1wHdaoBJ2B2HmF5ULbgWY8R9ycGxiextY69BzixHf7dqLspG7vUG8b9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Monday, December 4, 2023 11:01
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: optimize the printing order of error data

sort error data list to optimize the printing order.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 72634d675e27..bacb59d8b701 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 #include <linux/syscalls.h>
 #include <linux/pm_runtime.h>
+#include <linux/list_sort.h>

 #include "amdgpu.h"
 #include "amdgpu_ras.h"
@@ -3674,6 +3675,21 @@ static struct ras_err_node *amdgpu_ras_error_node_ne=
w(void)
        return err_node;
 }

+static int ras_err_info_cmp(void *priv, const struct list_head *a,
+const struct list_head *b) {
+       struct ras_err_node *nodea =3D container_of(a, struct ras_err_node,=
 node);
+       struct ras_err_node *nodeb =3D container_of(b, struct ras_err_node,=
 node);
+       struct amdgpu_smuio_mcm_config_info *infoa =3D &nodea->err_info.mcm=
_info;
+       struct amdgpu_smuio_mcm_config_info *infob =3D
+&nodeb->err_info.mcm_info;
+
+       if (unlikely(infoa->socket_id !=3D infob->socket_id))
+               return infoa->socket_id - infob->socket_id;
+       else
+               return infoa->die_id - infob->die_id;
+
+       return 0;
+}
+
 static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data =
*err_data,
                                                      struct amdgpu_smuio_m=
cm_config_info *mcm_info)  { @@ -3691,6 +3707,7 @@ static struct ras_err_in=
fo *amdgpu_ras_error_get_info(struct ras_err_data *err_d

        err_data->err_list_count++;
        list_add_tail(&err_node->node, &err_data->err_node_list);
+       list_sort(NULL, &err_data->err_node_list, ras_err_info_cmp);

        return &err_node->err_info;
 }
--
2.34.1

