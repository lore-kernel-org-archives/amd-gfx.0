Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE0BC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 08:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2536B10E158;
	Thu, 18 Jan 2024 08:18:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9932110E158
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 08:18:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdLN7xdtnZRQ2aE9QDSSNiVKx6txkgodTIADS88XbXZmo+YPwKVBT9FUlIlpOmMqLkohuJzfEgJKF3G3P8hyKe7VsjFactB3spgPnGPNGad+auN90zR9YEapOppNLDEbwp216TE08Bfa3EIq1gjhvY0yjOlsOrgQP0c5rLea1uF9R8bdAeMIU6wbfuuvhL8PDIkxg5LfqWnur1p8WT8FJAbtqoeLHAJGGbQwUtt+2uTwEtNQFQpZ3iA4Hsi6ghUGN8JqI2dZ0WvXezKgMo8mXRFsAVFRQExESat/XbIWEulZxWY3tIFNSmqH4HkqVk/FsEYKiHvdpvZbOHcvQdg5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOydJyoDnDcB3+W4MgEqi/rhuSPfC9w/qKpL6o8nu70=;
 b=F16NoDRSYm1OP41I3Z7OCEiLzViLnjz2KYLGBrcmNRcbD9kFlEuoKYXCAo00xU96Q1XwkIzKB1VXcl1pctD7mUQQbdxR5nOUqpZdzugJyYfjvEt7VsdHVH+syl9nAYcy/7anvS7Ljc+KW3zTKFAlerYgP/K5mID5YrkMHi6cqoE5QJ/YhrCJQTmqzjLFD4UbCyv+SH5fAf0Bh3uo2PfvvWmLz3CZ02xqMQ1PgGpS9BTGLoBNG/GgxcNBqI60+l2EDIrjkpgePixujxtBVVLLTrWSjpWNlmtD9gvkxD/PHKZivyPjvGrL17uIaov9hKu2T4V/7Mf1KajkcmJPHpW4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOydJyoDnDcB3+W4MgEqi/rhuSPfC9w/qKpL6o8nu70=;
 b=oql+s44X6vUhjI2zqw8OB/5CNswrD8nKMzNtiIrz9jC0oHL7VEcQ0p9QcbjP3jp5q3gSyaM9tNlgaa73HTbuKEh8pjdFAq5sfJl5wpWewnoSyOsnPj5DbTNaW3MJZSKin1Ed03hdwrAQbbNoJY+xhyT4M9SEZEjndm010Ch5dfk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Thu, 18 Jan
 2024 08:18:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::353:e785:731:7b81%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 08:18:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 5/5] drm/amdgpu:Support retiring multiple MCA error
 address pages
Thread-Topic: [PATCH V2 5/5] drm/amdgpu:Support retiring multiple MCA error
 address pages
Thread-Index: AQHaSdm696aFotGRokeGJIgWmxlMCbDfOaIw
Date: Thu, 18 Jan 2024 08:18:36 +0000
Message-ID: <BN9PR12MB5257C9DF708DB1AB479A386FFC712@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240118064257.1951585-1-YiPeng.Chai@amd.com>
 <20240118064257.1951585-5-YiPeng.Chai@amd.com>
In-Reply-To: <20240118064257.1951585-5-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=adde09a4-e631-4e57-ba0f-61ed9566f7fe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T08:16:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5762:EE_
x-ms-office365-filtering-correlation-id: 2ee3c81d-021c-49a1-4382-08dc17fe1192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ff4PHjNXoaV+btTu4UugGhGu5E/89r0Fz4XEd0O2p7Ift+mNsdUi4Zt8oaZvkW+bEjSfylnr90RuSeE/w5AravITKgIVnOuL3fpQLuCnjRBwoTS967wNVKLozWWwQKNjLFoe3AAU4aQRN4dW9hQKoHp5AoPYnO/Ml26t3O+sQ7aln2No06Hk3agr05+xP2q1n5L1kgXbxSL6o9OUp7CHDX3S4Y8VBTYcXbRvBwAcEce+WP/bMN3FUwdSPrP0Aynl2NKD9xP02IcudxtDVSlLKoUHaBryEWLHAPtmFiC+tWIUXnXMREvpaM2YYTjvV81tEA8Q+ynmPshr9JHBKhLAEw8ZS7sN+wFGOOfukNiHDXKyMupaRGYZ8eQFEYmQKxg9OveZw8USyQIfsI64COBCpauGdTTugkEu9xuFano4hyk+XDjk7H2LHwpPJwuFilzNgP+nHmyOOflEN58aaI/G6itRWIzW0Qhck3dMpJiWQiDQXQjBLX+B5xm3He6kNJCM+LRXLNNJ4sN8Z7Jj7mXduh/l83a3mvLzM/peXFIbyk+nquw35OSx9aigHm4mx94zJ9fC3CqxUf+D4vWiHGEEMFnL1L8QEiwPvqd9UPXtmy0NgdYo3J20ARpETnkHgdVP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(55016003)(71200400001)(6506007)(26005)(9686003)(53546011)(7696005)(38100700002)(33656002)(38070700009)(86362001)(4326008)(2906002)(83380400001)(5660300002)(122000001)(8936002)(66556008)(8676002)(41300700001)(76116006)(66946007)(66446008)(52536014)(66476007)(110136005)(316002)(54906003)(64756008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xNaWVfQ7dTR35AlFBRyPTpS1s2TBHt60yPPBZs7fD6oajgqj8Swp7f8bSh2v?=
 =?us-ascii?Q?wFJ+3EUhtflQ5Hhfwb7UYLWh2t+LIcM8GGNDKgsHSHlag06384lswKarNiOn?=
 =?us-ascii?Q?+9yzeP8YSb+I35qUoilR0Y7kqQiEM4CYs1ASF7ntGzVXl0jKzHGavTXh0CsR?=
 =?us-ascii?Q?uF2ZIbOIfUjpTYFQjz6qNwfk+KAvBwbiUJlBf0VChz7l/7kPI5hqe8U3HU50?=
 =?us-ascii?Q?LC/i9HuLv59NXCMS8qmiC5WdaqhmO62N1W6pqjpSG09WvD7gSjZOJ4LkRHEw?=
 =?us-ascii?Q?G+lmLsnDl2JFkxwW2Lk/l1FHHh/mdKEjKTRQk1cXbLdZ+sNyXFLHXK5KBULZ?=
 =?us-ascii?Q?P6HUEND77TCOtl3ff5kRVJfNJK7/U6AD137AlcXWlOs+yzEm349t3eyduvj5?=
 =?us-ascii?Q?ri1fMz58yMVuoLMZzhVc9hZrx1SKUBB96QrL6rki/WLr5bYtHolQxQjylHHi?=
 =?us-ascii?Q?T/5WzN+IjK5JT4XixndIP5wvnA4dDs2IV41NOeI+pcXflHGUwPIelrs4BlTe?=
 =?us-ascii?Q?YgjRCANVkU7eQp3kiI2qY/TIYxZ5RWnF11dCIJIrZ1ZV0pq0jI1wJDubxMoT?=
 =?us-ascii?Q?g9dr5YYv1zHlUFWQaVPcSaKi9eMregUdzUE/JVk7Dd7LMmUrBlo4Jy3NXrPH?=
 =?us-ascii?Q?u0PtDItvtujZPCFo3CaBJSIkkJqgrTSlhCQGa6QJU8G07aA6q3V5Tr4EoDkU?=
 =?us-ascii?Q?77jMXXtrt1vIujor31R9H9S2opI8mI6fd85QB3Dzlx3MtV6wKp38Wsg+v67d?=
 =?us-ascii?Q?gJltdAsKyGA7k35oTia4sRSm7PZPs8stWPG2eWL7+u2LmXHGPh1NCICaKyaa?=
 =?us-ascii?Q?6X2QWZv/w/PhmG/OXw2ysAANwKgwQcLWcyWrLUJDs64fKMj8prXj+0rGJimH?=
 =?us-ascii?Q?a51FfKDB7DMx+hqrMExGt1Qr1gieZY3U9Ena/3LEn4GStJ45uvC86KTkDkUf?=
 =?us-ascii?Q?DKpoSBzuZRiNhQmt6du7Fji30KJy2r7vIh2glmL7X77CYh7FUMLrQUZ565ku?=
 =?us-ascii?Q?IzbpobqVIXv2tvLn02/d4W1mMBzhc/rtoS916wJxNHoLzWT0uD0dMNCO8aW/?=
 =?us-ascii?Q?RPFWWMyF/FtGvWZzfVrpzmqUB23HGznubb6oWEQS9GmxteGMtuBSilqlR0yG?=
 =?us-ascii?Q?PCF3skesHiFYeiO29gz9Gw/FiBJmQXDs1eUNn3OYixr/oYRHa/136L7fT+TO?=
 =?us-ascii?Q?KIjfKo5GzxPfsggnqHhkZhwkLRAnc00lAIaHWcd6YRQ43naVWolb75T3DN4L?=
 =?us-ascii?Q?bCnefkX6zuu9sqysEjpN96FgkIdbSgVThZVR/V4wvON9hx0rbD3aSrRD+hzw?=
 =?us-ascii?Q?vmOBQv780X2VA4LXqXkw5Z4pWasCRpRFgWvTxYOOKW5/WJij2ut/xK5vgYyA?=
 =?us-ascii?Q?IQONzoycMlpJWwFNSw8OBowyTV430BA0OLMfH+zwRSViV3pg/MAoah7GopGK?=
 =?us-ascii?Q?V+I/foUwsOogDQqowlnVh/S6tU98pPBml1PbLPTYaiiQT2jhkqzeUNy88l+1?=
 =?us-ascii?Q?QRjYw8wYou7OqWqlo8RxNB5Ynn/J7nJuZJV5d+G2dENYTvdPe4V+0MU7unGu?=
 =?us-ascii?Q?SVjCyDsodZuNsM9PmO6AA+gNfDo/mci3pEqPFwJr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee3c81d-021c-49a1-4382-08dc17fe1192
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 08:18:36.3388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AI9wfQOxfmWuUsZGqRjKnVzTsPwpxgxmPQabfiAkwia+vJhKWqzEnv5jWCZmLXhtPZbVCkuASe5gKZ1zOKn7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5762
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, January 18, 2024 14:43
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V2 5/5] drm/amdgpu:Support retiring multiple MCA error addr=
ess pages

Support retiring multiple MCA error address pages in one in-band query for =
umc v12_0.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 43 +++++++++++++---  drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras.h |  8 ++-  drivers/gpu/drm/amd/amdgpu/umc_v12_0=
.c  | 66 +++++++++++++------------
 3 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 61a02dbac087..879e1e59ac76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3909,8 +3909,7 @@ static int ras_err_info_cmp(void *priv, struct list_h=
ead *a, struct list_head *b  }

 static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data =
*err_data,
-                               struct amdgpu_smuio_mcm_config_info *mcm_in=
fo,
-                               struct ras_err_addr *err_addr)
+                               struct amdgpu_smuio_mcm_config_info *mcm_in=
fo)
 {
        struct ras_err_node *err_node;

@@ -3922,10 +3921,9 @@ static struct ras_err_info *amdgpu_ras_error_get_inf=
o(struct ras_err_data *err_d
        if (!err_node)
                return NULL;

-       memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
+       INIT_LIST_HEAD(&err_node->err_info.err_addr_list);

-       if (err_addr)
-               memcpy(&err_node->err_info.err_addr, err_addr, sizeof(*err_=
addr));
+       memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));

        err_data->err_list_count++;
        list_add_tail(&err_node->node, &err_data->err_node_list); @@ -3934,=
6 +3932,29 @@ static struct ras_err_info *amdgpu_ras_error_get_info(struct =
ras_err_data *err_d
        return &err_node->err_info;
 }

+void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info, struct
+ras_err_addr *err_addr) {
+       struct ras_err_addr *mca_err_addr;
+
+       mca_err_addr =3D kzalloc(sizeof(*mca_err_addr), GFP_KERNEL);
+       if (!mca_err_addr)
+               return;
+
+       INIT_LIST_HEAD(&mca_err_addr->node);
+
+       mca_err_addr->err_status =3D err_addr->err_status;
+       mca_err_addr->err_ipid =3D err_addr->err_ipid;
+       mca_err_addr->err_addr =3D err_addr->err_addr;
+
+       list_add_tail(&mca_err_addr->node, &err_info->err_addr_list); }
+
+void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info, struct
+ras_err_addr *mca_err_addr) {
+       list_del(&mca_err_addr->node);
+       kfree(mca_err_addr);
+}
+
 int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
                struct amdgpu_smuio_mcm_config_info *mcm_info,
                struct ras_err_addr *err_addr, u64 count) @@ -3946,10 +3967=
,13 @@ int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_dat=
a,
        if (!count)
                return 0;

-       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info, err_addr=
);
+       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info);
        if (!err_info)
                return -EINVAL;

+       if (err_addr && err_addr->err_status)
+               amdgpu_ras_add_mca_err_addr(err_info, err_addr);
+
        err_info->ue_count +=3D count;
        err_data->ue_count +=3D count;

@@ -3968,7 +3992,7 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_er=
r_data *err_data,
        if (!count)
                return 0;

-       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info, err_addr=
);
+       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info);
        if (!err_info)
                return -EINVAL;

@@ -3990,10 +4014,13 @@ int amdgpu_ras_error_statistic_de_count(struct ras_=
err_data *err_data,
        if (!count)
                return 0;

-       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info, err_addr=
);
+       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info);
        if (!err_info)
                return -EINVAL;

+       if (err_addr && err_addr->err_status)
+               amdgpu_ras_add_mca_err_addr(err_info, err_addr);
+
        err_info->de_count +=3D count;
        err_data->de_count +=3D count;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 9c3df9985fad..a25aea6ae230 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -474,6 +474,7 @@ struct ras_fs_data {  };

 struct ras_err_addr {
+       struct list_head node;
        uint64_t err_status;
        uint64_t err_ipid;
        uint64_t err_addr;
@@ -484,7 +485,7 @@ struct ras_err_info {
        u64 ce_count;
        u64 ue_count;
        u64 de_count;
-       struct ras_err_addr err_addr;
+       struct list_head err_addr_list;
 };

 struct ras_err_node {
@@ -856,4 +857,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device *adev, e=
num amdgpu_ras_block blk)  ssize_t amdgpu_ras_aca_sysfs_read(struct device =
*dev, struct device_attribute *attr,
                                  struct aca_handle *handle, char *buf, voi=
d *data);

+void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
+                       struct ras_err_addr *err_addr);
+
+void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
+               struct ras_err_addr *mca_err_addr);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 1e8e97d72f1e..f9dc1855ac4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -385,42 +385,46 @@ static void umc_v12_0_ecc_info_query_ras_error_addres=
s(struct amdgpu_device *ade  {
        struct ras_err_node *err_node;
        uint64_t mc_umc_status;
+       struct ras_err_info *err_info;
+       struct ras_err_addr *mca_err_addr, *tmp;
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;

        for_each_ras_error(err_node, err_data) {
-               mc_umc_status =3D err_node->err_info.err_addr.err_status;
-               if (!mc_umc_status)
+               err_info =3D &err_node->err_info;
+               if (list_empty(&err_info->err_addr_list))
                        continue;

-               if (umc_v12_0_is_uncorrectable_error(adev, mc_umc_status) |=
|
-                   umc_v12_0_is_deferred_error(adev, mc_umc_status)) {
-                       uint64_t mca_addr, err_addr, mca_ipid;
-                       uint32_t InstanceIdLo;
-                       struct amdgpu_smuio_mcm_config_info *mcm_info;
-
-                       mcm_info =3D &err_node->err_info.mcm_info;
-                       mca_addr =3D err_node->err_info.err_addr.err_addr;
-                       mca_ipid =3D err_node->err_info.err_addr.err_ipid;
-
-                       err_addr =3D  REG_GET_FIELD(mca_addr, MCA_UMC_UMC0_=
MCUMC_ADDRT0, ErrorAddr);
-                       InstanceIdLo =3D REG_GET_FIELD(mca_ipid, MCMP1_IPID=
T0, InstanceIdLo);
-
-                       dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%d, inst:=
%d, ch:%d, err_addr:0x%llx\n",
-                               mca_ipid,
-                               mcm_info->die_id,
-                               MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-                               MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-                               err_addr);
-
-                       umc_v12_0_convert_error_address(adev,
-                               err_data, err_addr,
-                               MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
-                               MCA_IPID_LO_2_UMC_INST(InstanceIdLo),
-                               mcm_info->die_id);
-
-                       /* Clear umc error address content */
-                       memset(&err_node->err_info.err_addr,
-                               0, sizeof(err_node->err_info.err_addr));
+               list_for_each_entry_safe(mca_err_addr, tmp, &err_info->err_=
addr_list, node) {
+                       mc_umc_status =3D mca_err_addr->err_status;
+                       if (mc_umc_status &&
+                               (umc_v12_0_is_uncorrectable_error(adev, mc_=
umc_status) ||
+                                umc_v12_0_is_deferred_error(adev, mc_umc_s=
tatus))) {
+                               uint64_t mca_addr, err_addr, mca_ipid;
+                               uint32_t InstanceIdLo;
+
+                               mca_addr =3D mca_err_addr->err_addr;
+                               mca_ipid =3D mca_err_addr->err_ipid;
+
+                               err_addr =3D REG_GET_FIELD(mca_addr,
+                                                       MCA_UMC_UMC0_MCUMC_=
ADDRT0, ErrorAddr);
+                               InstanceIdLo =3D REG_GET_FIELD(mca_ipid, MC=
MP1_IPIDT0, InstanceIdLo);
+
+                               dev_info(adev->dev, "UMC:IPID:0x%llx, aid:%=
d, inst:%d, ch:%d, err_addr:0x%llx\n",
+                                       mca_ipid,
+                                       err_info->mcm_info.die_id,
+                                       MCA_IPID_LO_2_UMC_INST(InstanceIdLo=
),
+                                       MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+                                       err_addr);
+
+                               umc_v12_0_convert_error_address(adev,
+                                       err_data, err_addr,
+                                       MCA_IPID_LO_2_UMC_CH(InstanceIdLo),
+                                       MCA_IPID_LO_2_UMC_INST(InstanceIdLo=
),
+                                       err_info->mcm_info.die_id);
+                       }
+
+                       /* Delete error address node from list and free mem=
ory */
+                       amdgpu_ras_del_mca_err_addr(err_info, mca_err_addr)=
;
                }
        }
 }
--
2.34.1

