Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E304FC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 02:59:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF1810E10F;
	Thu, 18 Jan 2024 02:59:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B6C10E10F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 02:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiRpog0LdBX/mNGtEER0EB/DFoA1L0FJmvhesXslHpaSRwtCM6zPtThW5ZOu3wZSSuYd4KW+jySKupnvXOYY9kuclshu1lSzaN1wHBrbjOYwpxmubu+rTvFltudoY+Dy1/BMTTxh7c8aqarQjIVCXBvt2AG0lUmY/kV48KBscxHjv8dQ0eIK1XVqjLP49okgu+0oadcqFGLo2wNqi+klFGYKVRQfgrno2gTUOacbub69DOZWbfH6QAPgq8AtQgPC1oCLtZpRBkDPh1s2MSNhA3WoEiLv8D66ivlKoNKe9Wr9yKZC/gVHVp5PlqjoH7AVDboowkK+6YvvzMHfrXIC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM71Ev7lWI0VNojVSMRUkqf8Aad03KE6+svwtLTquYo=;
 b=MjOD1Pt/Lba9fV2ErlGf7gK55ARRGuUso0qmyeUGuBaxMiBeDA2cDd2RulreF5adi3wHDZ8DqK1rC5NLwPL3LsFAccTfeK2WDXat6asz+bTiY8NRaTFnOvWrcsYr5Kjq47iAl6EXYsr4hn7Q5iLpU/OiCvw5kDpQPO4bbiReJhTw7F8ZaJBh/LJkXMV+hYBkblwBH+T3GX6WWwlEngGGhNxdqKY5BqEXU3G3DJ4t2ZhMldlDjaRLcHXsYyrj4SWQeliPV2h+9XTcEJqH7BSu4qRgCmNcqDheQLUSssv8yOTsni1DsZHzlq4ViHU02WuxXtuFf7Har5cjPxHOOQSQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM71Ev7lWI0VNojVSMRUkqf8Aad03KE6+svwtLTquYo=;
 b=AkFtvXwDssBJDN+d5U8XpvOXcRVdF0x0HeyWe8IAyGNuKMk7WIrlOgL28qbUhgDOyDwwys9V/TLiN6ROHlCJhJrNRmiMZ7YD/wwkp63afUkRJ+Pw6WWRB8BrDARtEoFD0LKFCIku8rvrHgVmDLZ5VNwS+m9/tKksfUiqUtlYdEU=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 02:59:33 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%5]) with mapi id 15.20.7181.029; Thu, 18 Jan 2024
 02:59:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSFT4B4AVJVDV5ka0IVdSj1uT4bDe41sA
Date: Thu, 18 Jan 2024 02:59:33 +0000
Message-ID: <PH7PR12MB599715DC30B7DE699D68E44582712@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b0ff5739-8a74-45ce-b1a6-9c0c9bc35047;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T02:57:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN2PR12MB4549:EE_
x-ms-office365-filtering-correlation-id: 25f1365f-0f6b-46a7-2d80-08dc17d17f6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nkz8+Fjk6BAYPJ8+TjK/2q/y3VO9hWEdOLpXjKPD362cYLcGFC89umXRv2aB8ghNWB879mUQVznX2+EXtRlj28imFVSFzi4gz0wJsqflNvp2dxGmZsOPgbJYQbTZhGkWM6ApLhcPD5V+UVz5wZfJniImdta1fBXpi5sJUg/FyrXX82IQ3U0tq8HSwI7TA5qEC6fGkYi+E1qnlQOxj7JU7nUvOSg69/TpR3mOFUIbCX8l+QGsFAg5b+bBa94sKLAj0W9vn7CUMr2rmosXFw1NY9UkFBgofaHv0qG611KGIYcvWMrZkKLCRrks6SFZXDNQ59hYDZ8NsAieQCiPD1jgtEt1xUBIAZtX2hBLXwA5fFI6VRdklYc/HOVH3geC11XcEVJYaDe19tMzXuzCNs0d24759A5F66uEVeKO0QPBF7Grf0UH0f0J77G/w2a42k5RIdTpgpuNRd1wB7BHWyRIaV9etzzg186MGc5e0csJqRKkA3LLBCexh+F2x2AkokP8rm+PiajGmZv3YWuj2DJwRQnE0BRvd0nCVaALXo9uUiuZIFo7tgEzRlxtkBVNcGUHH1l2yC++2f9HPr/JAOTPt4Y6boFXZtWtKYfUhhwKK7Ovul5vxYgKlU487rvhgSNR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(122000001)(478600001)(55016003)(38070700009)(41300700001)(38100700002)(26005)(52536014)(4326008)(8676002)(8936002)(86362001)(66446008)(53546011)(66556008)(33656002)(76116006)(66946007)(66476007)(64756008)(6506007)(110136005)(71200400001)(316002)(54906003)(9686003)(7696005)(5660300002)(2906002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7jRDOE6Jv16aJ4xsbGLUwhL3qzRReOPlvj4TyFctY09X/SbRDW8Ez+41idW4?=
 =?us-ascii?Q?5VbQh/qYkj3i/8nFJov6IfysWZfBXpf0d96aSTZeEoSqLdFVOif9bVjkBCwy?=
 =?us-ascii?Q?ra7Rth+6jGVnUL063ffDOjr8/0JtvzIFknBrmMk1cz35C3ON64N0s1k6zWQ1?=
 =?us-ascii?Q?vpFt4kppE76n55umjhLVZPAimYM7DdanTDwqptr6Y6chs7w+P6VF6YXAnJc3?=
 =?us-ascii?Q?IY4GuWqGRmelZgagjHigResRH+214qjZtKxAarslS1iCkWJBSAKFk5YjzCoK?=
 =?us-ascii?Q?B+yWjXQVIEYxY8m/1jRYRMCGUiRFt97n0hTrt3Rfrsi+w5Jngj7kRBsqQHJx?=
 =?us-ascii?Q?hfHsxwMPMaDCuMjd/l7Bkb2w0ZqctZDp7d5TcVjxI35RdeLqouHchIp3xIP8?=
 =?us-ascii?Q?hPxhgAD3D6h2A8CHeWwCV5mi/DYhgjlPvwKBMOS9AFG629D/8wY3y27/zBr0?=
 =?us-ascii?Q?7bFr55BmeuVbZdG/Q/x+80ve/vGWr0ckTkcIdpUcKwFTJw/EuTbUVT2Qgy/+?=
 =?us-ascii?Q?/nglnrvT+lEw3XiSPK5wNoZ0eraVlrH1z9Q7rrl8IrHj77rF1RV6fwgoWemS?=
 =?us-ascii?Q?3EDZaL8LFFq2BgwQ9s/3+OpyM+6K4OuvUjS1Iw5Lde18DXCcL4a5JP1OD1Hc?=
 =?us-ascii?Q?YzlX9SgCMEzWLKWTZnaWKEMU3UYTGSUe1rZV6n0kKx6/bCa8ANJPYgf+zZCB?=
 =?us-ascii?Q?KxJKPCHOJSsqsJaH4B8SwFqBS6VDwFGh49l9K3cL+mhK9XQ05NoKcyvKJw3L?=
 =?us-ascii?Q?+Qo19wlovuKdNQDoq564kkeqJpe2NcJA3NEoUyfMGSS2g2zesD590OlzyfqZ?=
 =?us-ascii?Q?my/vGz4teIzw6MEFL6xyxFzilsf+DvkuIfxUDW4b7HxryhLmO4U3sPst6rR7?=
 =?us-ascii?Q?eJcPQb6MhNp+qjKehYIGTzFMoL70gMopLAmuZJnJzQbO6TkZ74wS8urWc/Ug?=
 =?us-ascii?Q?6dflRD8V9OL3dxmP1R8z0g03Pa7jinOlwE8EPnrK8okA3y/AVONS6eTkHTpY?=
 =?us-ascii?Q?plFUvczTXWtIu0EN1VDTrLbs4EigDM+NHjbzteq7tXZcDjlYDW5LSuP5vZQY?=
 =?us-ascii?Q?85KIvxCSwYGMkkPS79MiryzN6/zbDsvZW30YYdYLBsJkfdwLPugn0la6ijld?=
 =?us-ascii?Q?wl5ZG62BeW0Vk+1DR41QN19L4+Jg5KEVTSVZe0UzM3tet8hBGjWRP5DRTAv7?=
 =?us-ascii?Q?kia1N5zd4sl5BLY8NjPkqiehXv8oh700Puu7jphewvV8PodO4AeV1XWIKeiR?=
 =?us-ascii?Q?E5B8Cc+ygQceucJd1PXtPq5p2/Q6klsUHRqbXpRHhfWJXBpXx02lwt7UpgNu?=
 =?us-ascii?Q?94nHhSyxc67XUfR42DyxxrXNcoDpiG6tBItIkgIAZVTI3MokP1hAlmxTyN85?=
 =?us-ascii?Q?PYrjlZhfPnBn1doXgLmmu8beGEkd7CPruEf4AW+9QnDZ1tSokz3ZKOF3PeQF?=
 =?us-ascii?Q?mGlVf/bJbs8Ois0ZXOSxhNujB1vc0EVIBuUHZFgpuoxjff8ymSqO+Wo6Y6FG?=
 =?us-ascii?Q?ZZ2yddbU7zRQpusMEegTp8htgs/7jqSZ5kLt2b247VD/N267mUQFmuuBY/V1?=
 =?us-ascii?Q?54q8fjPGjcAmJ3W0D9U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f1365f-0f6b-46a7-2d80-08dc17d17f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 02:59:33.2563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXbczND+4f5wQaOo4D1w8licHI9zbgNZ67dLCPoGo3BaIokQYU+F7DW5pFMaixbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4549
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
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, January 16, 2024 4:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)  {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1)); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                return; /* Presumably process exited. */
+       }

        user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
        if (unlikely(user_gpu_id =3D=3D -EINVAL)) { @@ -1334,6 +1336,8 @@ v=
oid kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
                }
        }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */ diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct s=
mu_context *smu, enum amdgpu_

        ret =3D smu_cmn_send_smc_msg(smu, msg, count);
        if (ret) {
+               dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA coun=
t, ret:%d\n",
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                               "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_Q=
ueryValidMcaCount",
+                       msg,
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : =
"UE",
+                       ret);
                *count =3D 0;
                return ret;
        }

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);


[Kevin]:
Please make following function public then use this helper function to get =
msg name string.
- smu_get_message_name()

Best Regards,
Kevin
+
        return 0;
 }

--
2.34.1

