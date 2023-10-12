Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F239CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD20410E122;
	Thu, 12 Oct 2023 13:18:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6871010E122
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSplkBWbKbkSN/u/JzfmUNilI/vXtd0yK+YHxEXtRp+zx/tDL7F1XPjE6fPdZ4251viUqcW5m0esj4Nmbw5Uni/nP6Kc3UyXaWiX/OSR9PbQjSbN1KbTvTZq0Dkt1t+N/bMgYFzRPkSaoT2BAYVQEfkjdeD9k//eVayvs4+uHuCQ/VOKXK6wIqLI+lA3T7V+KCXdjvnJawKNSvYPnnzt13suEzULlNdEVZVSW4cdRYq/eR24HA2zQVN7zn0uHSdvqfQFPwohvWFOhcFnol+2VM75kmIggIPh7gg6obcN1kA0FAwtjypdWxLbkkMHs6TCf6IIxUooG/l3RenTYUTneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8j51+pkD8KEwSoV4rJ5fVmZDEW/npeBoZzkZq1b+XE=;
 b=L8gzqLQWyUsdf1Z8N7cp+coBgeWavos+b8XS0qS7/6yJ2hTXL/f+rbJOBKh+Z2z+F/NHO0K4ehnk4k3RFNIsaP1HZBJjQMJ4ma3p8Oe0HVXqFp2bN3h6xxKxEphTdeAO7ieCzMClCtrD1hhss3XN103cSYYEdnNPgQfkqoVv55kjKM5VUmmOSvN98UxChZwxSH6B1A8NJgREpf79cPubRrEPEkVISSPaDb3H0nlPTfFsv7j5rCGZY+9qSRS/xnNnzIP9PgFTc7IK9KcXMPToayRGuZkKtDyD6txHp7tQoayNFMSdyy0ItvGaUm7rFrzqlh9oHmxjL7q6GW6DvGkHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8j51+pkD8KEwSoV4rJ5fVmZDEW/npeBoZzkZq1b+XE=;
 b=xEr+r2SdR4fFafzrnLDw/Q6meQhYWUP366s5p47vbmGBxlfLT/DwxKaHjEnyjaSjDiCRBmoVNOKPBIt7H8PZaAybW6Vn9RFiSO6v0hBerj+xY3+L+gR8JdaOCd9mOBSnt87VVWPZTv9+X6NdoOs3MEu6ptQCsm0nzq8uGQ0KE0Y=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:18:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 13:18:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/6] drm/amdgpu: add ras_err_info to identify RAS error
 source
Thread-Topic: [PATCH 2/6] drm/amdgpu: add ras_err_info to identify RAS error
 source
Thread-Index: AQHZ/Q4NzJpAwOCtW0aATUuqs4CuZ7BGIlQw
Date: Thu, 12 Oct 2023 13:18:37 +0000
Message-ID: <BN9PR12MB5257E91ACFCB81EAA6AD98FEFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231012131406.61101-1-kevinyang.wang@amd.com>
 <20231012131406.61101-2-kevinyang.wang@amd.com>
In-Reply-To: <20231012131406.61101-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5177453a-292a-4e21-b7e6-3da5a123ade9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-12T13:15:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN0PR12MB5812:EE_
x-ms-office365-filtering-correlation-id: 2475b06f-2ce3-4679-713d-08dbcb25bed2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6xbQfz60JpxFgooRe0iJm+lbYULShto0TY+tIOn2nG37ax82AVXCN1kIYxeAIF/99XHWLLPRzrWVh6nJ9U5v6J3+Y+gnlO7KdriOYcnfM4NqOucWo/DSiAvbjjXd9B7PW0Mc03dtj8IlK4Rp3E5mWVabX5FfpD2Zss4LKVVk3KRHpB/KOgSfNA2tM4uGeqLhJaIJqG3sIpqcVR7ePZJhzWdAa/Bn4Vvr+Ku1XLqZ9njR2pPHqO7xvvyZMXtDcOay4WIT1tN2qsb8gubS9zB5c9R4aRq6CJpWcsTUgsjfyxffUUDL1y4LCNA47cYNyzZFoxTbTi/+yo+w+9o/7G1B5miw+N9hyPUKC/SUNvFofnQhh6dPqQO5ucXjMPsM8i+SQQf32faccMa3sNxFqm5hHwlUpztpWvu9J05HpYvW9/iunvBoZC17l6we0TIuFgpNg3zdHVV4oNLNooMGSfzHfyTfiW+cmyNVf5uobZAMhnQ1S/OLtPrT2IMJp8kgr4M6/T3JfJ4maHgZRWNeQrlwbJnyeafF3bNE84wcp8sosFXirdoUFCcflI+EgLyLiyglNbBZDfhRFU9OGA65td+bZTulNxdAu0DanrtjEl3Zi/Pn7hINXks5qjAKB29FIuNk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(53546011)(9686003)(55016003)(122000001)(33656002)(86362001)(38070700005)(38100700002)(2906002)(30864003)(83380400001)(71200400001)(7696005)(6506007)(478600001)(8936002)(8676002)(4326008)(52536014)(316002)(41300700001)(110136005)(66556008)(66446008)(66946007)(76116006)(64756008)(54906003)(66476007)(5660300002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RHOVgwyhVSJchvty3oiuvGB6qYJgaNgE0brZIKJOXBnzGkSvOGL26wzQ2ZlK?=
 =?us-ascii?Q?FV5icLFyNGdfMhBW5EhixEhZsroETj7HxSCaHjsr37OfGMaO7moQZ5aLm0Cj?=
 =?us-ascii?Q?l3YUaw+1mLGbIGe0UC0SxG0ww5Md/DvZ24dEE9jEmGxDQKM7cFecLZKyzOVP?=
 =?us-ascii?Q?g36FP95sOsCgZ6AQkBPI/Ad13duHx1W7iRknZcSuRTPLAstQq/W2pTmKv/Wy?=
 =?us-ascii?Q?bX+7juGPp76VB+UNxx4VHPgo/hfoD3EBqsBpKa4Udr5KVgfV8IMIwyebDHE6?=
 =?us-ascii?Q?1WFuj8R0b3ajdp890RMpThp58yHo6KnNunzIcYGmGZiuwSZgfE+eDj2GjbKH?=
 =?us-ascii?Q?GT8aOkgV3LWddTkrjQ4To5jTpLa19KOZpSENCpsyg/NRn0YMkvPsJR1mFvsA?=
 =?us-ascii?Q?hUmpfe+1U2tlAyF+8w0gG9YceB5wasWej2ap8iVz5Ns3XAd5YXu+iU6EmUFj?=
 =?us-ascii?Q?f+iHs2aYnNHVcQUOZu2/yuWtFTiNgZQWlsjd3KhvqhCCO2t3qsvOGngL6uUe?=
 =?us-ascii?Q?BG0VKxd4A3cwQED4WBzmJIcSFgPBcqFze87XAjPXskPL2d68nNH1spI89S60?=
 =?us-ascii?Q?dYItoqIYwhbd46gkDHwMC9OZeXg/FDPhLj1dMpgpuAd2inJBEbTPp0lrP/8c?=
 =?us-ascii?Q?zu0aUi2tBa7bfev4M7VayboTjFyt5tIOxI5M7gXVLlccp7/CJ5NV1H0q92pJ?=
 =?us-ascii?Q?HkrPaMHsFr2WqTFIaak8vUCqPRiGoV9TxAhfIA7XWyU9vHHwH8UMHa/V0I+H?=
 =?us-ascii?Q?qkCgUMAucWSpPKO4bpIkcP+52nIE8MqwIiB9y0kdBdnSb/9CdwlcWCXbWIKP?=
 =?us-ascii?Q?TBE/jH81YyKXlRsy3SKJHqB0RNA9ckDNHyRTykyUT4UknpIEg0kDbNdb1EwF?=
 =?us-ascii?Q?s1AvGHhydV4ApIyuIqgbjwLM1UBzmyUEYlpQZb85jz8JS9/8zh0/2DB6ID3N?=
 =?us-ascii?Q?U9jC48uzsO6qibGMaww1Ad2ZbvW+gY+zR1FpME166undasFq8dFQ1fmL4KUg?=
 =?us-ascii?Q?BH41Qk7YLFCyZo8kLLbYewvqwRRsq+1moNGaL8Q7uGxAdgMiZxUnjsuf6dDH?=
 =?us-ascii?Q?xzUbJh0fbm6mCrWgN0rfrpup6Vf+AuyK1B9Yz1U4UBzRWbjahYTZRu0BkKb/?=
 =?us-ascii?Q?6K4yzCeyJFPRl5LW0Ctjq4sT8FXIzclJogGp1wnvTZFoNgQ5YqO6m85XWV8B?=
 =?us-ascii?Q?dpnGcDJaRVkooVv4uj2otv8au8h9BSbfA1t4bVKp2Dyh9zJ4U+e9sZhlZes6?=
 =?us-ascii?Q?oyf1FPb+8xHB3wHBv/JEa0OAHH3ktxgLYC9mvjMAMqrEQXyhQEDUGab9/ha4?=
 =?us-ascii?Q?125MAazceQO54qui7OfzI/y79pIMz3YYDzjWO9TnjI6wJ9csvkevk6xzCtcC?=
 =?us-ascii?Q?JOC2+OXadUEHrXS7dSzrq+5zA2AN8RqkoIEvn+1OHAxq4iBdXVa08WyVRmQU?=
 =?us-ascii?Q?ZEf3KkvrqQOCWcMSt/M1pgzyv+18azqb1HzoDxZU7ar5CBL35yQO1XPYecul?=
 =?us-ascii?Q?mC3UZAWvbG8qm24fI/iULyuQgu+yZaJgsm+UtXSyDd+RKYebfW1eF+fskA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2475b06f-2ce3-4679-713d-08dbcb25bed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 13:18:37.8288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQUSn5WgOLAGsxeBxZ4vq8GIBetbP9xb5K/yhm4ddgOrh3/ZQZ7AGiMMNDlTsRiYgZKOBqnSa6z/XylZzdzq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+               dev_info(adev->dev, "Total %ld uncorrectable hardware error=
s detected in %s block\n",
+                        ras_mgr->err_data.ue_count, blk_name);

Please remove "Total" from the kernel message. With that addressed, the ser=
ies is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, October 12, 2023 21:14
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.c=
om>
Subject: [PATCH 2/6] drm/amdgpu: add ras_err_info to identify RAS error sou=
rce

introduced "ras_err_info" to better identify a RAS ERROR source.

NOTE:
For legacy chips, keep the original RAS error print format.

v1:
RAS errors may come from different dies during a RAS error query, therefore=
, need a new data structure to identify the source of RAS ERROR.

v2:
- use new data structure 'amdgpu_smuio_mcm_config_info' instead of
  ras_err_id (in v1 patch)
- refine ras error dump function name
- refine ras error dump log format

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c   | 289 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h   |  28 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h |   5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c   |  27 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c    |   7 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c    |   7 +-
 6 files changed, 310 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5fb57419ef77..2522d29806dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -152,8 +152,9 @@ static bool amdgpu_ras_get_error_query_ready(struct amd=
gpu_device *adev)

 static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t=
 address)  {
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct ras_err_data err_data;
        struct eeprom_table_record err_rec;
+       int ret;

        if ((address >=3D adev->gmc.mc_vram_size) ||
            (address >=3D RAS_UMC_INJECT_ADDR_LIMIT)) { @@ -170,6 +171,10 @=
@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_=
t addre
                return 0;
        }

+       ret =3D amdgpu_ras_error_data_init(&err_data);
+       if (ret)
+               return ret;
+
        memset(&err_rec, 0x0, sizeof(struct eeprom_table_record));
        err_data.err_addr =3D &err_rec;
        amdgpu_umc_fill_error_record(&err_data, address, address, 0, 0); @@=
 -180,6 +185,8 @@ static int amdgpu_reserve_page_direct(struct amdgpu_devic=
e *adev, uint64_t addre
                amdgpu_ras_save_bad_pages(adev, NULL);
        }

+       amdgpu_ras_error_data_fini(&err_data);
+
        dev_warn(adev->dev, "WARNING: THIS IS ONLY FOR TEST PURPOSES AND WI=
LL CORRUPT RAS EEPROM\n");
        dev_warn(adev->dev, "Clear EEPROM:\n");
        dev_warn(adev->dev, "    echo 1 > /sys/kernel/debug/dri/0/ras/ras_e=
eprom_reset\n");
@@ -1015,17 +1022,113 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_=
device *adev, struct ras_err_d
        }
 }

+static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev, =
struct ras_query_if *query_if,
+                                             struct ras_err_data *err_data=
, bool is_ue) {
+       struct ras_manager *ras_mgr =3D amdgpu_ras_find_obj(adev, &query_if=
->head);
+       const char *blk_name =3D get_ras_block_str(&query_if->head);
+       struct amdgpu_smuio_mcm_config_info *mcm_info;
+       struct ras_err_node *err_node;
+       struct ras_err_info *err_info;
+
+       if (is_ue)
+               dev_info(adev->dev, "Total %ld uncorrectable hardware error=
s detected in %s block\n",
+                        ras_mgr->err_data.ue_count, blk_name);
+       else
+               dev_info(adev->dev, "Total %ld correctable hardware errors =
detected in %s block\n",
+                        ras_mgr->err_data.ue_count, blk_name);
+
+       for_each_ras_error(err_node, err_data) {
+               err_info =3D &err_node->err_info;
+               mcm_info =3D &err_info->mcm_info;
+               if (is_ue && err_info->ue_count) {
+                       dev_info(adev->dev, "socket: %d, die: %d, "
+                                "%lld uncorrectable hardware errors detect=
ed in %s block\n",
+                                mcm_info->socket_id,
+                                mcm_info->die_id,
+                                err_info->ue_count,
+                                blk_name);
+               } else if (!is_ue && err_info->ce_count) {
+                       dev_info(adev->dev, "socket: %d, die: %d, "
+                                "%lld correctable hardware errors detected=
 in %s block\n",
+                                mcm_info->socket_id,
+                                mcm_info->die_id,
+                                err_info->ue_count,
+                                blk_name);
+               }
+       }
+}
+
+static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev, s=
truct ras_query_if *query_if,
+                                            struct ras_err_data *err_data)=
 {
+       struct ras_manager *ras_mgr =3D amdgpu_ras_find_obj(adev, &query_if=
->head);
+       const char *blk_name =3D get_ras_block_str(&query_if->head);
+
+       if (err_data->ce_count) {
+               if (!list_empty(&err_data->err_node_list)) {
+                       amdgpu_ras_error_print_error_data(adev, query_if, e=
rr_data, false);
+               } else if (!adev->aid_mask &&
+                          adev->smuio.funcs &&
+                          adev->smuio.funcs->get_socket_id &&
+                          adev->smuio.funcs->get_die_id) {
+                       dev_info(adev->dev, "socket: %d, die: %d "
+                                "%ld correctable hardware errors "
+                                "detected in %s block, no user "
+                                "action is needed.\n",
+                                adev->smuio.funcs->get_socket_id(adev),
+                                adev->smuio.funcs->get_die_id(adev),
+                                ras_mgr->err_data.ce_count,
+                                blk_name);
+               } else {
+                       dev_info(adev->dev, "%ld correctable hardware error=
s "
+                                "detected in %s block, no user "
+                                "action is needed.\n",
+                                ras_mgr->err_data.ce_count,
+                                blk_name);
+               }
+       }
+
+       if (err_data->ue_count) {
+               if (!list_empty(&err_data->err_node_list)) {
+                       amdgpu_ras_error_print_error_data(adev, query_if, e=
rr_data, true);
+               } else if (!adev->aid_mask &&
+                          adev->smuio.funcs &&
+                          adev->smuio.funcs->get_socket_id &&
+                          adev->smuio.funcs->get_die_id) {
+                       dev_info(adev->dev, "socket: %d, die: %d "
+                                "%ld uncorrectable hardware errors "
+                                "detected in %s block\n",
+                                adev->smuio.funcs->get_socket_id(adev),
+                                adev->smuio.funcs->get_die_id(adev),
+                                ras_mgr->err_data.ue_count,
+                                blk_name);
+               } else {
+                       dev_info(adev->dev, "%ld uncorrectable hardware err=
ors "
+                                "detected in %s block\n",
+                                ras_mgr->err_data.ue_count,
+                                blk_name);
+               }
+       }
+
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
                                  struct ras_query_if *info)
 {
        struct amdgpu_ras_block_object *block_obj =3D NULL;
        struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct ras_err_data err_data;
+       int ret;

        if (!obj)
                return -EINVAL;

+       ret =3D amdgpu_ras_error_data_init(&err_data);
+       if (ret)
+               return ret;
+
        if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC) {
                amdgpu_ras_get_ecc_info(adev, &err_data);
        } else {
@@ -1033,7 +1136,8 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
                if (!block_obj || !block_obj->hw_ops)   {
                        dev_dbg_once(adev->dev, "%s doesn't config RAS func=
tion\n",
                                     get_ras_block_str(&info->head));
-                       return -EINVAL;
+                       ret =3D -EINVAL;
+                       goto out_fini_err_data;
                }

                if (block_obj->hw_ops->query_ras_error_count)
@@ -1053,48 +1157,12 @@ int amdgpu_ras_query_error_status(struct amdgpu_dev=
ice *adev,
        info->ue_count =3D obj->err_data.ue_count;
        info->ce_count =3D obj->err_data.ce_count;

-       if (err_data.ce_count) {
-               if (!adev->aid_mask &&
-                   adev->smuio.funcs &&
-                   adev->smuio.funcs->get_socket_id &&
-                   adev->smuio.funcs->get_die_id) {
-                       dev_info(adev->dev, "socket: %d, die: %d "
-                                       "%ld correctable hardware errors "
-                                       "detected in %s block, no user "
-                                       "action is needed.\n",
-                                       adev->smuio.funcs->get_socket_id(ad=
ev),
-                                       adev->smuio.funcs->get_die_id(adev)=
,
-                                       obj->err_data.ce_count,
-                                       get_ras_block_str(&info->head));
-               } else {
-                       dev_info(adev->dev, "%ld correctable hardware error=
s "
-                                       "detected in %s block, no user "
-                                       "action is needed.\n",
-                                       obj->err_data.ce_count,
-                                       get_ras_block_str(&info->head));
-               }
-       }
-       if (err_data.ue_count) {
-               if (!adev->aid_mask &&
-                   adev->smuio.funcs &&
-                   adev->smuio.funcs->get_socket_id &&
-                   adev->smuio.funcs->get_die_id) {
-                       dev_info(adev->dev, "socket: %d, die: %d "
-                                       "%ld uncorrectable hardware errors =
"
-                                       "detected in %s block\n",
-                                       adev->smuio.funcs->get_socket_id(ad=
ev),
-                                       adev->smuio.funcs->get_die_id(adev)=
,
-                                       obj->err_data.ue_count,
-                                       get_ras_block_str(&info->head));
-               } else {
-                       dev_info(adev->dev, "%ld uncorrectable hardware err=
ors "
-                                       "detected in %s block\n",
-                                       obj->err_data.ue_count,
-                                       get_ras_block_str(&info->head));
-               }
-       }
+       amdgpu_ras_error_generate_report(adev, info, &err_data);

-       return 0;
+out_fini_err_data:
+       amdgpu_ras_error_data_fini(&err_data);
+
+       return ret;
 }

 int amdgpu_ras_reset_error_status(struct amdgpu_device *adev, @@ -1744,12 =
+1812,16 @@ static void amdgpu_ras_interrupt_umc_handler(struct ras_manager=
 *obj,
                                struct amdgpu_iv_entry *entry)
 {
        struct ras_ih_data *data =3D &obj->ih_data;
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct ras_err_data err_data;
        int ret;

        if (!data->cb)
                return;

+       ret =3D amdgpu_ras_error_data_init(&err_data);
+       if (ret)
+               return;
+
        /* Let IP handle its data, maybe we need get the output
         * from the callback to update the error type/count, etc
         */
@@ -1766,6 +1838,8 @@ static void amdgpu_ras_interrupt_umc_handler(struct r=
as_manager *obj,
                obj->err_data.ue_count +=3D err_data.ue_count;
                obj->err_data.ce_count +=3D err_data.ce_count;
        }
+
+       amdgpu_ras_error_data_fini(&err_data);
 }

 static void amdgpu_ras_interrupt_handler(struct ras_manager *obj) @@ -3383=
,3 +3457,128 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdgpu_de=
vice *adev,
                WREG32(err_status_hi_offset, 0);
        }
 }
+
+int amdgpu_ras_error_data_init(struct ras_err_data *err_data) {
+       memset(err_data, 0, sizeof(*err_data));
+
+       INIT_LIST_HEAD(&err_data->err_node_list);
+
+       return 0;
+}
+
+static void amdgpu_ras_error_node_release(struct ras_err_node
+*err_node) {
+       if (!err_node)
+               return;
+
+       list_del(&err_node->node);
+       kvfree(err_node);
+}
+
+void amdgpu_ras_error_data_fini(struct ras_err_data *err_data) {
+       struct ras_err_node *err_node, *tmp;
+
+       list_for_each_entry_safe(err_node, tmp, &err_data->err_node_list, n=
ode) {
+               amdgpu_ras_error_node_release(err_node);
+               list_del(&err_node->node);
+       }
+}
+
+static struct ras_err_node *amdgpu_ras_error_find_node_by_id(struct ras_er=
r_data *err_data,
+                                                            struct amdgpu_=
smuio_mcm_config_info *mcm_info) {
+       struct ras_err_node *err_node;
+       struct amdgpu_smuio_mcm_config_info *ref_id;
+
+       if (!err_data || !mcm_info)
+               return NULL;
+
+       for_each_ras_error(err_node, err_data) {
+               ref_id =3D &err_node->err_info.mcm_info;
+               if ((mcm_info->socket_id >=3D 0 && mcm_info->socket_id !=3D=
 ref_id->socket_id) ||
+                   (mcm_info->die_id >=3D 0 && mcm_info->die_id !=3D ref_i=
d->die_id))
+                       continue;
+
+               return err_node;
+       }
+
+       return NULL;
+}
+
+static struct ras_err_node *amdgpu_ras_error_node_new(void) {
+       struct ras_err_node *err_node;
+
+       err_node =3D kvzalloc(sizeof(*err_node), GFP_KERNEL);
+       if (!err_node)
+               return NULL;
+
+       INIT_LIST_HEAD(&err_node->node);
+
+       return err_node;
+}
+
+static struct ras_err_info *amdgpu_ras_error_get_info(struct ras_err_data =
*err_data,
+                                                     struct amdgpu_smuio_m=
cm_config_info *mcm_info) {
+       struct ras_err_node *err_node;
+
+       err_node =3D amdgpu_ras_error_find_node_by_id(err_data, mcm_info);
+       if (err_node)
+               return &err_node->err_info;
+
+       err_node =3D amdgpu_ras_error_node_new();
+       if (!err_node)
+               return NULL;
+
+       memcpy(&err_node->err_info.mcm_info, mcm_info, sizeof(*mcm_info));
+
+       err_data->err_list_count++;
+       list_add_tail(&err_node->node, &err_data->err_node_list);
+
+       return &err_node->err_info;
+}
+
+int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info, uint64_t count) {
+       struct ras_err_info *err_info;
+
+       if (!err_data || !mcm_info)
+               return -EINVAL;
+
+       if (!count)
+               return 0;
+
+       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info);
+       if (!err_info)
+               return -EINVAL;
+
+       err_info->ue_count +=3D count;
+       err_data->ue_count +=3D count;
+
+       return 0;
+}
+
+int amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info, uint64_t count) {
+       struct ras_err_info *err_info;
+
+       if (!err_data || !mcm_info)
+               return -EINVAL;
+
+       if (!count)
+               return 0;
+
+       err_info =3D amdgpu_ras_error_get_info(err_data, mcm_info);
+       if (!err_info)
+               return -EINVAL;
+
+       err_info->ce_count +=3D count;
+       err_data->ce_count +=3D count;
+
+       return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 46b0dcf846dc..d6a37d5b9809 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -28,6 +28,7 @@
 #include <linux/list.h>
 #include "ta_ras_if.h"
 #include "amdgpu_ras_eeprom.h"
+#include "amdgpu_smuio.h"

 struct amdgpu_iv_entry;

@@ -443,13 +444,30 @@ struct ras_fs_data {
        char debugfs_name[32];
 };

+
+struct ras_err_info {
+       struct amdgpu_smuio_mcm_config_info mcm_info;
+       uint64_t ce_count;
+       uint64_t ue_count;
+};
+
+struct ras_err_node {
+       struct list_head node;
+       struct ras_err_info err_info;
+};
+
 struct ras_err_data {
        unsigned long ue_count;
        unsigned long ce_count;
        unsigned long err_addr_cnt;
        struct eeprom_table_record *err_addr;
+       uint32_t err_list_count;
+       struct list_head err_node_list;
 };

+#define for_each_ras_error(err_node, err_data) \
+       list_for_each_entry(err_node, &(err_data)->err_node_list, node)
+
 struct ras_err_handler_data {
        /* point to bad page records array */
        struct eeprom_table_record *bps;
@@ -773,4 +791,14 @@ void amdgpu_ras_inst_reset_ras_error_count(struct amdg=
pu_device *adev,
                                           const struct amdgpu_ras_err_stat=
us_reg_entry *reg_list,
                                           uint32_t reg_list_size,
                                           uint32_t instance);
+
+int amdgpu_ras_error_data_init(struct ras_err_data *err_data); void
+amdgpu_ras_error_data_fini(struct ras_err_data *err_data); int
+amdgpu_ras_error_statistic_ce_count(struct ras_err_data *err_data,
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info, uint64_t count);
+int amdgpu_ras_error_statistic_ue_count(struct ras_err_data *err_data,
+                                       struct amdgpu_smuio_mcm_config_info=
 *mcm_info, uint64_t count);
+
 #endif
+
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_smuio.h
index 5910d50ac74d..ff4435181055 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h
@@ -30,6 +30,11 @@ enum amdgpu_pkg_type {
        AMDGPU_PKG_TYPE_UNKNOWN,
 };

+struct amdgpu_smuio_mcm_config_info {
+       int socket_id;
+       int die_id;
+};
+
 struct amdgpu_smuio_funcs {
        u32 (*get_rom_index_offset)(struct amdgpu_device *adev);
        u32 (*get_rom_data_offset)(struct amdgpu_device *adev); diff --git =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_umc.c
index 24fcc9a2e422..f74347cc087a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -45,8 +45,12 @@ static int amdgpu_umc_convert_error_address(struct amdgp=
u_device *adev,  int amdgpu_umc_page_retirement_mca(struct amdgpu_device *a=
dev,
                        uint64_t err_addr, uint32_t ch_inst, uint32_t umc_i=
nst)  {
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
-       int ret =3D AMDGPU_RAS_FAIL;
+       struct ras_err_data err_data;
+       int ret;
+
+       ret =3D amdgpu_ras_error_data_init(&err_data);
+       if (ret)
+               return ret;

        err_data.err_addr =3D
                kcalloc(adev->umc.max_ras_err_cnt_per_query,
@@ -54,7 +58,8 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *=
adev,
        if (!err_data.err_addr) {
                dev_warn(adev->dev,
                        "Failed to alloc memory for umc error record in MCA=
 notifier!\n");
-               return AMDGPU_RAS_FAIL;
+               ret =3D AMDGPU_RAS_FAIL;
+               goto out_fini_err_data;
        }

        /*
@@ -63,7 +68,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *=
adev,
        ret =3D amdgpu_umc_convert_error_address(adev, &err_data, err_addr,
                                        ch_inst, umc_inst);
        if (ret)
-               goto out;
+               goto out_free_err_addr;

        if (amdgpu_bad_page_threshold !=3D 0) {
                amdgpu_ras_add_bad_pages(adev, err_data.err_addr, @@ -71,8 =
+76,12 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
                amdgpu_ras_save_bad_pages(adev, NULL);
        }

-out:
+out_free_err_addr:
        kfree(err_data.err_addr);
+
+out_fini_err_data:
+       amdgpu_ras_error_data_fini(&err_data);
+
        return ret;
 }

@@ -182,18 +191,24 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *a=
dev, bool reset)
        }

        if (!amdgpu_sriov_vf(adev)) {
-               struct ras_err_data err_data =3D {0, 0, 0, NULL};
+               struct ras_err_data err_data;
                struct ras_common_if head =3D {
                        .block =3D AMDGPU_RAS_BLOCK__UMC,
                };
                struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head=
);

+               ret =3D amdgpu_ras_error_data_init(&err_data);
+               if (ret)
+                       return ret;
+
                ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL=
, reset);

                if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
                        obj->err_data.ue_count +=3D err_data.ue_count;
                        obj->err_data.ce_count +=3D err_data.ce_count;
                }
+
+               amdgpu_ras_error_data_fini(&err_data);
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
                        adev->virt.ops->ras_poison_handler(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 7d6d7734dbec..6d24c84924cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -365,9 +365,12 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bi=
fring(struct amdgpu_device  {
        uint32_t bif_doorbell_intr_cntl;
        struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, adev->nbio.ra=
s_if);
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct ras_err_data err_data;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

+       if (amdgpu_ras_error_data_init(&err_data))
+               return;
+
        if (adev->asic_type =3D=3D CHIP_ALDEBARAN)
                bif_doorbell_intr_cntl =3D RREG32_SOC15(NBIO, 0, mmBIF_DOOR=
BELL_INT_CNTL_ALDE);
        else
@@ -418,6 +421,8 @@ static void nbio_v7_4_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device
                 */
                amdgpu_ras_reset_gpu(adev);
        }
+
+       amdgpu_ras_error_data_fini(&err_data);
 }

 static void nbio_v7_4_handle_ras_err_event_athub_intr_no_bifring(struct am=
dgpu_device *adev) diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/dr=
ivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cc034a740605..eccb006e78aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -560,9 +560,12 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bi=
fring(struct amdgpu_device  {
        uint32_t bif_doorbell_intr_cntl;
        struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, adev->nbio.ra=
s_if);
-       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct ras_err_data err_data;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

+       if (amdgpu_ras_error_data_init(&err_data))
+               return;
+
        bif_doorbell_intr_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOO=
RBELL_INT_CNTL);

        if (REG_GET_FIELD(bif_doorbell_intr_cntl,
@@ -607,6 +610,8 @@ static void nbio_v7_9_handle_ras_controller_intr_no_bif=
ring(struct amdgpu_device
                 */
                amdgpu_ras_reset_gpu(adev);
        }
+
+       amdgpu_ras_error_data_fini(&err_data);
 }

 static void nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring(struct am=
dgpu_device *adev)
--
2.34.1

