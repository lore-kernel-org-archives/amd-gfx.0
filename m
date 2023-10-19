Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD282CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D4A10E4D7;
	Thu, 19 Oct 2023 13:22:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 682C610E4D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grwtr1g722jLYsr+GJEQQjpDQOjKe43391WlrbHAX1LbEabmg1+lF4SLtRIDSC0er9e5bZ9Vb+EL8Ap9X7Hd74xY0+x2SSawLc5KVnflrObbay5H5kbfRHG6rV8RzuLSfiGghKSQr9xe+XlYpNwT/D62nHEZkDoiM6vfuA8tjsfOoWAsc+TjSVgTBqcTuoIWUtyPFrg3sT0rgUA/xNh/CS6QvaixpinS3x9G/uby6+GXM/nAu9fL6YACN0eH7p/2zBTrPTGpEsHQCo5N3RpKgq5gftVpaKKLkimV6YjoOxuw/RqrRnGnI877I5v6MNSUCelCR7A+pWE9ZuGJbLRXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P72mqwzMtM9TobXnnpU3WOWcvu2zdp8qCI8PLsoirA=;
 b=Se5LPjghBaw0pMQBWtPMHcSNcIotR5GGuOUSeJFJNH5xQ2GBjAabJdJoQx+AWbseOUhLbz0UAfkmCa55xlkU8VGgXFc4EXkpP++4vL7cXc93b6hGh55dog0ilWjQuDMgTW4JqxNfQ55BG5x7pInHN6M7K4IGG0v1PUI2sInVGnF4NTRAK1kVl/aCdn7k6/f+0V6vUqBVVoYDmDMvnLJC9/I2sEE269bDZLPomJdVFF4WpndmbkQLd3iyOYl+1lLGSoBzIaidmUM05rsjbjyNmsU/a0BAbrLYudiMW5V276P+bC+hKrI+Bpqf6leqH/ajRZeAEXJk2ueb1MBGUq9uTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P72mqwzMtM9TobXnnpU3WOWcvu2zdp8qCI8PLsoirA=;
 b=MFIwIgUZ/i/3Bw42lH6FNwNA54zS31Sk73nPxtfiw7m0tX/SUO9LbCNhzM0LYp89+Ni91zllf0o4ErToT0iNCQL7Xm22ruDWec/qwVS50RvEHjW0MyE224YnKnbeXT/Mk5WWF+2YnzHKoPjO7ajZoTxyYQNTGRb0s47mHwWFpBo=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:22:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 13:22:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine ras error kernel log print
Thread-Topic: [PATCH] drm/amdgpu: refine ras error kernel log print
Thread-Index: AQHaAosByG12hvv8tUqJZh7MD9CrvrBRGVeQ
Date: Thu, 19 Oct 2023 13:22:32 +0000
Message-ID: <BN9PR12MB5257DB46D4FF10958E222347FCD4A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231019125115.1110473-1-kevinyang.wang@amd.com>
In-Reply-To: <20231019125115.1110473-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d7a0f2e1-c766-48e5-abc3-fb5f88d82d55;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T13:21:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB6977:EE_
x-ms-office365-filtering-correlation-id: f3b01272-b669-496a-d5a2-08dbd0a67377
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 48+2ghnANE4nAQIgakSktVHYKACgVHW4wmpmDxvDyxH9uCLtE0IZXwPNfLUdU2DE0NhTjFIbzohoTQieroQ3jbMeSYXAga6OCmmDFRCscbG2WvzjT/oEERVpkNKz9dm/l92nBhoTLG7BX2C1SQlWq/kZ6Pz7W/IZ++KraLYSMXj4iatJIjo2U426lxV18fpF+rwMG5hURTQhOl7IPHlbTME92guGIOBi1mdiG1kFbUJP+4aN0qnny/xwXOrL1XNFAzEJP0+mR17BiDMPqxu+pbUM1ZHn+WVTdfHJ3kGx15rzhoF/wzDqNswECt/+JuS93al/DFhOoqq4teX2RtSUO71gvpWIcCeh+eqb0AbdLKuX+jNYO9SuYM6IsT/jXtoGEE0fmyzoDRNEhGJH3ZevJYuMNXDnt67GuBrIdbHoeOIzNiZsMejyK7oR8pk5zO9KfpSJGH3v13NCAk/ZAWDG9lL2fSaXDzg4Q/H7T+XDsdQWBWjNKbVy5C3KXUyQPBWfgfxehD3DMtBLpywmZiJRrpr48msnOM0u3TcAVECJyt/80nWs68WyLjYL8b6LbvJVbikITlWXXMrZJNpNMaYt0RjLErnWCpxc/6Zx7T97YFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(71200400001)(7696005)(6506007)(53546011)(83380400001)(26005)(9686003)(55016003)(38070700005)(86362001)(2906002)(33656002)(4326008)(41300700001)(5660300002)(8936002)(52536014)(8676002)(110136005)(316002)(66946007)(66556008)(76116006)(64756008)(54906003)(66446008)(66476007)(122000001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GNYvJ3U7ukQgrjTcQPgMu8m4fTdCCn39VW5njxOG68EVREIwtpo59L8LXVAJ?=
 =?us-ascii?Q?TWEHqSs3rUZtOm/TkG9Pyti3Y0CY2N46+3y107Boo1lzuO5+22toR3ZftFXO?=
 =?us-ascii?Q?Jhea2HyGMls19kEoHYYyKPIGnfhulG5+TxyuZb8a0q1R/FK7nnzXFnvf8W3h?=
 =?us-ascii?Q?EF5mqKt4FwEUZgNjHpMakrjHRLd0WOTq1R88hdgqiY76IhDKVoFJeiFvarwH?=
 =?us-ascii?Q?zS1nFnlwuiWbcTmLzeVaroKKnf+LXqA7Iuv89D010UQO2ktlWpRoAkNUUpmw?=
 =?us-ascii?Q?unz7qHgQXHl3mfKdokO7xILwET7Tuu0mfPrsjWYl/7MmNxvSpSVcMO0IZcG9?=
 =?us-ascii?Q?4ZbuQxqc2QO7QScAvvpu3d3Jmf/hZY+8q2DkRpNz3t6rabXYpKh92UZThWIX?=
 =?us-ascii?Q?EFYlgBoO9GDWXkPTXWb6gR9MPQMwbpWxPdWXsMg8Rf4zsYr2aXmxbEMDLVB8?=
 =?us-ascii?Q?EP23KAbRFyembdokt+jHwVzLfXOxE2oXpufBmPhwJeVYOPF+6c3GxA7n17d2?=
 =?us-ascii?Q?yPxtZJ2l9D1FykA4xfGH0z5vXejRWJTaKAgUQacfXywyooDjM4EIPtPkSMR/?=
 =?us-ascii?Q?gbbpih8HyDu+RU+k/pdixPU3LboonJPiCMccRiQbFTO/DA/0yzVXTDoq790f?=
 =?us-ascii?Q?DVOHIdFCRFS3hYn3o+PmG052k5zPJVmeJzVvyi2k6AP2n8RaWNP3MGmv+QU4?=
 =?us-ascii?Q?Uv1gmLBc7UpPao6qLXHJ3sCqj31Poiv4/+bMbpCbxzoHmjAIJ8vLQqITEb7+?=
 =?us-ascii?Q?0snZFFTgx80K0raVrZ1hBjq/5BKHncze6r/GT6obamSKA0BRWlmTszmNPnpI?=
 =?us-ascii?Q?6i5hZMGC/MVfuPkUj/OketwmcSh3XKPlI3O/k9YOwJvYD/v+/841ndK5Iceo?=
 =?us-ascii?Q?InmNCSv2C3Ja3p4tQLfE6QmQBjCtbhNgGtnTPMIcA3WyW/T3e9mkh6QqOigS?=
 =?us-ascii?Q?dwoxd2HOOBlspYXlPqhZ61QDUkpel3+N5XkQCX/zygOnodSaZp4GnKaGxl1u?=
 =?us-ascii?Q?6h3MeQlN8uFqEkTAbOi5zTbT6gBTeyqSs7SuSaKwVuX2W6EEtHzeu9Bdw4CB?=
 =?us-ascii?Q?NcgDcwLd3/ymnPSP4CthAbJg0eugwuESQU7mba2zT2AXI2alfRLU9yN0KnR8?=
 =?us-ascii?Q?PVdxccQdpGjHy+CiwzEurN3MLyISbJtOWiLXSfxd3p6SA56MocI91UaG7b9v?=
 =?us-ascii?Q?py5Y/2YjhiXez9QN3SSWtOoCEzPrR+0GQCAYCTg69dj2ucbLt2808V0PVtPc?=
 =?us-ascii?Q?AvHaCwxL/g44U81zJDRccXRdwnrral70G8YuOQBrQJuyDwiBLlqXa89KaZ9A?=
 =?us-ascii?Q?IPJIzkgLnij9qPjkFJhCcZBUsuCAHsWXyAe+8662gebCkvggEcOwRRKCAiFt?=
 =?us-ascii?Q?jfF5yrCfS1c3UyRzUp7Hj1zqvGKcN7jRg01uhNPx6xXZJUOrpYhTJeGkFoF7?=
 =?us-ascii?Q?Y0poNodZfFoc6ApUwybpVnwRpFobBgW9Ix/EEx95qh1+QTS13Kj+zXtgvVDA?=
 =?us-ascii?Q?FtD3bi7UrOtyy4+kEpDydmIK2swEEJ+gaM5glMciDBLXHXMbyou+MImv0nVA?=
 =?us-ascii?Q?3I8cO/42JgdHQWOARhm6q2FOP8p5iTtLdodgMqVW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b01272-b669-496a-d5a2-08dbd0a67377
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 13:22:32.2969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+n+BlzUIv3jANjVIr0JqmrDU0pO/yfA37Fc/Tw8Lc377dZMyFx+16XwjIj2AXR3d+dmEd3vLnVpcZ7r745fmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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

As discussed, please add socket id and die id in the output message.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, October 19, 2023 20:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH] drm/amdgpu: refine ras error kernel log print

refine ras error kernel log to avoid user-ridden ambiguity.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5b831ba0ebb3..cebc19d810e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1034,10 +1034,11 @@ static void amdgpu_ras_error_print_error_data(struc=
t amdgpu_device *adev,
        struct ras_err_info *err_info;

        if (is_ue)
-               dev_info(adev->dev, "%ld uncorrectable hardware errors dete=
cted in %s block\n",
+               dev_info(adev->dev, "%ld uncorrectable hardware errors dete=
cted in
+total in %s block\n",
                         ras_mgr->err_data.ue_count, blk_name);
        else
-               dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in %s block\n",
+               dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in total in %s block, "
+                        "no user action is needed.\n",
                         ras_mgr->err_data.ce_count, blk_name);

        for_each_ras_error(err_node, err_data) { @@ -1045,14 +1046,15 @@ st=
atic void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
                mcm_info =3D &err_info->mcm_info;
                if (is_ue && err_info->ue_count) {
                        dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld uncorrectable hardware errors detect=
ed in %s block\n",
+                                "new %lld uncorrectable hardware errors de=
tected in %s block\n",
                                 mcm_info->socket_id,
                                 mcm_info->die_id,
                                 err_info->ue_count,
                                 blk_name);
                } else if (!is_ue && err_info->ce_count) {
                        dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld correctable hardware errors detected=
 in %s block\n",
+                                "new %lld correctable hardware errors dete=
cted in %s block, "
+                                "no user action is needed.\n",
                                 mcm_info->socket_id,
                                 mcm_info->die_id,
                                 err_info->ce_count,
--
2.34.1

