Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D6ECDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 07:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD8D10E58A;
	Fri, 20 Oct 2023 07:05:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EEBA10E58A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 07:05:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxL5PHpaB07gpQJzqH2O3s8v4EcjzCTTntadK0IA/J2s1L3Es56wUsGFak+o21PF9d2cU8YAPaVmI3MOJWTNI1AuztFOLOOOiE6gxu1u6HxeNtc0SeQS4ZPws1ctzLzfYMHCpmIzGStlycVaBpDDR3iQn03WfxROWwFkvcs6kOWFkRunzmaP2upPPwMw+Tqi2sZd4gnwA8aEpTgQA7y2rBBARDEAisyYN8g8BDWBn18vQjv447gKeTusyCj6Qov3gs54QHQPwMYs9uwtpzTk8vgPvU/vLEqcmri++aFm4n4NfiQ0LTIeg+/c6WRHXoJ2be7rEBS7RdueXOmRL8YWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzRydWwS22XmQ0Gb5WZqxzJD+cQ5DJigZsX2jfirLg0=;
 b=BH4n8eolpvGP8FZ626Z3HXJkjUElxE9zaExcjgKljnaoz5F0GYf1Ro/6gC6yQBLXHxTsXWuWfC/Sj/HRpO65ujPeHoP1LrFVIZeeVIpIyZRLtDh5xDc52r5pyNC+FZYJa5C5Q3KQan6ebco/zNEkkolVvhNSwstTKdGen3gfsPxaQsVZdajy4IGNNBp+mmGhHtGK/VqHoC6W7hkKScqm5n+8+fF8MALa3foA76YfXYbJrDWYhvimxKHelooT2EYLA/DkIgbOjHQq5gR9xCSsj4t6yb0uFAq8dVQ6gbRxqcADFM1EygpbZYRfDTfnAvhWA1eAfsJ6A32T99n26GxdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzRydWwS22XmQ0Gb5WZqxzJD+cQ5DJigZsX2jfirLg0=;
 b=O8qppvSw8iFfrVqRh6HsCpbXu9jfv37eYFAv9I2xcoxN0rX1jxRzTkC0Oc4xeH1CscJg8KGHoCzCnZx1UJiXw+vCBccYiWtnQyxba5Y7+uzp9xgT0xU7/awrJ1Nb7TAqAeUwwnQx9A9InlTq60KQCT4FDGj1rneurvP7DZ/qXno=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 07:05:23 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::9b99:8d90:81b8:b091%7]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 07:05:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: refine ras error kernel log print
Thread-Topic: [PATCH 2/2] drm/amdgpu: refine ras error kernel log print
Thread-Index: AQHaAyMsQGfw1xCdwEmcNe20A/rEqLBSQTHw
Date: Fri, 20 Oct 2023 07:05:23 +0000
Message-ID: <BN9PR12MB52570A7E6C9CB31FDBFC210FFCDBA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231020070026.1380994-1-kevinyang.wang@amd.com>
 <20231020070026.1380994-2-kevinyang.wang@amd.com>
In-Reply-To: <20231020070026.1380994-2-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=139011fe-655e-4e1e-8c7b-9af218efcf5a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-20T07:04:57Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH0PR12MB5465:EE_
x-ms-office365-filtering-correlation-id: 61bdda4b-8846-458a-b7dc-08dbd13aee06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAEhT6Tyf9uWYDzdLdHzDCcRH7TreTmzMzc1HOOVSoyMcCnl77IEm82PwUQSyiScJGqMnAfQ7leNQP9H5+EaVcQ+52l+Vo399hxaR2/1BfOrouT2FgLE0imjgMcm9HSwSlzisDp48lbG/x9HoRm7aVLDw1x+wP0jCJ6/6oDED82XDxZmO3+YqfXJ/x74YyoWPXeXh7NUCw6fHbleM1wp0w1IbwAzI/IOsr0QxxPB3yURVoJuoTXTavGCYQdYPdCf0NVU4umv15pKW5nbEYhpMX0qgsEb/BtVk/Qb6a2VCKPyc06mr1DYxA2ahukgZjqxNAWxRUsLCvtcX6I0fDSar/Grgh6sgwx/Z5+oZ3vjYDrpIvMrvMNdk2WrqxUETPY9At+/VAawfNlxwU8wKn5XrOl/rPB5nwRK50gs+LJSjopXOYHVMgACPAMw3NTl9j+SIpm2VMFWip0C13bLHLZgPf3wt9WkviN6nJ6IDqeW07UgFc+BqfTEgmAgvpxxXshj1N/iTi72s5cNGaMHkh69I8fKiWt2WJrd/TgMmXW75aABZ1yt7BTy5xgp5g6jkL8RD90G4Q4gcE+ICYhNMAoYKurAc1UEGyt2DX4IZ3vHTPkwd06u2jUWLP0Rlril4fAB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38070700009)(2906002)(86362001)(55016003)(5660300002)(54906003)(76116006)(66946007)(66446008)(110136005)(66476007)(66556008)(64756008)(316002)(71200400001)(8936002)(478600001)(33656002)(4326008)(41300700001)(8676002)(83380400001)(52536014)(53546011)(6506007)(38100700002)(122000001)(9686003)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hH6CZMoO2utlSIN7rFEhNbXzlIbb/hsUqrY05wmBIVJLng6x02TpgAvX1KRJ?=
 =?us-ascii?Q?3rNAFGn3VL0mAlrqFJtSY/zPMYWRQMB7xwzl23DW62fctXqWtXcXF3TMAKft?=
 =?us-ascii?Q?rsIuCIdHBfQz2fhF7AEi8Bt9mjTWPJ2kw3K5yGUcQ9+FOGJANn9jewdOmfu7?=
 =?us-ascii?Q?2/3mthRpwsOrap1obaq7l1URxiilApmhFs99tfA6W6xNDXrbqg07cFCYCJEa?=
 =?us-ascii?Q?0RpnAQm9aXNY3fgM6uT3+o8ugWW+HA3DxTs+27+yukebZuOzKKZDs0WpFKeU?=
 =?us-ascii?Q?0k22OEjOZS4pp6cjus67q2WQ89iYuDAtC38471W/a2fzqx7dlMgsjFAqsRmB?=
 =?us-ascii?Q?pnfmJS2nR8TyMOQJ3unniibJChnBTIUq1W6ZgEDQnZ0tyqxbBd6iMfS58WN5?=
 =?us-ascii?Q?4SJdCWrV4TGURayy+K/J2jf+y3iKlUOL257+lsYqN+A/4YGquE+tiaYfdKan?=
 =?us-ascii?Q?HV29AVueALNaeNWHmMH5pRIXvoHsmDOfUFd3JS9jikJ7FcDV0QJCXjXxcCO8?=
 =?us-ascii?Q?z7BrwtARqA5/0LPf77b1vVho8+spvYsf7sUybUc5P3rGdf+UYGDz7WRNpw7D?=
 =?us-ascii?Q?4sOsq9l38ZtPAdCTtw+AhtoF3ZnltHymNdICsEJMP+Pqf6niWBXiDi1qf+z9?=
 =?us-ascii?Q?82dENkm9cZYpzhIR6rLwMpTF7z4V+nKfJh9pZ4qjF5ziDh/CBT+7dZysgdoe?=
 =?us-ascii?Q?AljAo/Vpqj2gYHqt+YL2YWB0AcSzqyWo00R9ah9Jy0EdrOzy5GOImXCTZSmD?=
 =?us-ascii?Q?CKa+oQdP8DUBQRWok7twTmXX2dSCP5uZsYwVrNql3D1ApL2KNZzaE8yXinl5?=
 =?us-ascii?Q?ZHxs8enq1afVlavZBll3bJkNUPc9GoCxSp/F6R1hR0u+gOSVvIsHsxVreerC?=
 =?us-ascii?Q?yWvCQzu3dDDxpAw5xSqZ2P9j0WVWmpmBs4CqxoOtlzPaxitFSV/yreWkZkwd?=
 =?us-ascii?Q?fwm0iTdp1R9xx0osnKqzy/0spEn+/rZhfR+ZyMpa1M+x/jVOOxlKd5q1hbis?=
 =?us-ascii?Q?Z/alJcFJ05yk1OncEayEfgYL0r+vM3iNy7Hvi8aiM5HwhJ2bgXG0I+FWAYfi?=
 =?us-ascii?Q?aFRedqT1xuvcAFBoGvopsdSN0dCEns6n0KV5UHTvgkpY3p7TEHG3hn4h/nfY?=
 =?us-ascii?Q?pHeftNHGb9V9Qf485koqOV8G9il+BC8SCRpbfZtjRCHi91GdNtYQXHm2k+h5?=
 =?us-ascii?Q?dUc+6PzSBcWokMwR8WUnL2xA9zQDiI0Q9GXoiqbP9mNQkVMWVuZeCAAAIDO9?=
 =?us-ascii?Q?+YSeKqrKjT0rMipI1vCICeE57WZD1+IqyADmG8T3NBaB5vSSbSief1W3CDZi?=
 =?us-ascii?Q?M+x6/5dgXInyY8yOtKLEHai98WGuNnH9BqN3PYB/gxEIE7+XfJMNy1trarAv?=
 =?us-ascii?Q?UQ/3dSvT+GRu6VOeeyEj2dQrW/OOjrhQ1AVC7OgCX35/tsRKkLAM0T/J+XAO?=
 =?us-ascii?Q?XFXA/h5WnzVW2dLvdQoMjh0nwGzLGWlaeW1KWwPo5k6i/+4gecWvlr/jCTIn?=
 =?us-ascii?Q?xkoapn8nWDow1RCsWscFIw/4y1gjdc9BP1cnW887EEuUL3vAqJAv26MzGtcW?=
 =?us-ascii?Q?oauNTINKvm9pg1mvhvVQrc3p3kwgl4UI6j2IexVo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bdda4b-8846-458a-b7dc-08dbd13aee06
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2023 07:05:23.4692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h/Rt4JM7zeiToE9GcA7NmL1deZzxEkvGmcdW/c7a1CUtzchusj/t2RgUEUIk2EMwobE9+USuhb3Gsg+bNdOt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, October 20, 2023 15:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: refine ras error kernel log print

refine ras error kernel log to avoid user-ridden ambiguity.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 116 +++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |   5 +-
 2 files changed, 82 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d5bcfcf4ced2..0cb60f71c14d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -635,8 +635,11 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *de=
v,

 static inline void put_obj(struct ras_manager *obj)  {
-       if (obj && (--obj->use =3D=3D 0))
+       if (obj && (--obj->use =3D=3D 0)) {
                list_del(&obj->node);
+               amdgpu_ras_error_data_fini(&obj->err_data);
+       }
+
        if (obj && (obj->use < 0))
                DRM_ERROR("RAS ERROR: Unbalance obj(%s) use\n", get_ras_blo=
ck_str(&obj->head));  } @@ -666,6 +669,9 @@ static struct ras_manager *amdg=
pu_ras_create_obj(struct amdgpu_device *adev,
        if (alive_obj(obj))
                return NULL;

+       if(amdgpu_ras_error_data_init(&obj->err_data))
+               return NULL;
+
        obj->head =3D *head;
        obj->adev =3D adev;
        list_add(&obj->node, &con->head);
@@ -1023,44 +1029,68 @@ static void amdgpu_ras_get_ecc_info(struct amdgpu_d=
evice *adev, struct ras_err_d  }

 static void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
-                                             struct ras_query_if *query_if=
,
+                                             struct ras_manager *ras_mgr,
                                              struct ras_err_data *err_data=
,
+                                             const char *blk_name,
                                              bool is_ue)
 {
-       struct ras_manager *ras_mgr =3D amdgpu_ras_find_obj(adev, &query_if=
->head);
-       const char *blk_name =3D get_ras_block_str(&query_if->head);
        struct amdgpu_smuio_mcm_config_info *mcm_info;
        struct ras_err_node *err_node;
        struct ras_err_info *err_info;

-       if (is_ue)
-               dev_info(adev->dev, "%ld uncorrectable hardware errors dete=
cted in %s block\n",
-                        ras_mgr->err_data.ue_count, blk_name);
-       else
-               dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in %s block\n",
-                        ras_mgr->err_data.ce_count, blk_name);
+       if (is_ue) {
+               for_each_ras_error(err_node, err_data) {
+                       err_info =3D &err_node->err_info;
+                       mcm_info =3D &err_info->mcm_info;
+                       if (err_info->ue_count) {
+                               dev_info(adev->dev, "socket: %d, die: %d, "
+                                        "%lld new uncorrectable hardware e=
rrors detected in %s block\n",
+                                        mcm_info->socket_id,
+                                        mcm_info->die_id,
+                                        err_info->ue_count,
+                                        blk_name);
+                       }
+               }

-       for_each_ras_error(err_node, err_data) {
-               err_info =3D &err_node->err_info;
-               mcm_info =3D &err_info->mcm_info;
-               if (is_ue && err_info->ue_count) {
-                       dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld uncorrectable hardware errors detect=
ed in %s block\n",
-                                mcm_info->socket_id,
-                                mcm_info->die_id,
-                                err_info->ue_count,
-                                blk_name);
-               } else if (!is_ue && err_info->ce_count) {
-                       dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld correctable hardware errors detected=
 in %s block\n",
-                                mcm_info->socket_id,
-                                mcm_info->die_id,
-                                err_info->ce_count,
-                                blk_name);
+               for_each_ras_error(err_node, &ras_mgr->err_data) {
+                       err_info =3D &err_node->err_info;
+                       mcm_info =3D &err_info->mcm_info;
+                       dev_info(adev->dev, "socket: %d, die: %d, "
+                                "%lld uncorrectable hardware errors detect=
ed in total in %s block\n",
+                                mcm_info->socket_id, mcm_info->die_id, err=
_info->ue_count, blk_name);
+               }
+
+       } else {
+               for_each_ras_error(err_node, err_data) {
+                       err_info =3D &err_node->err_info;
+                       mcm_info =3D &err_info->mcm_info;
+                       if (err_info->ce_count) {
+                               dev_info(adev->dev, "socket: %d, die: %d, "
+                                        "%lld new correctable hardware err=
ors detected in %s block, "
+                                        "no user action is needed\n",
+                                        mcm_info->socket_id,
+                                        mcm_info->die_id,
+                                        err_info->ce_count,
+                                        blk_name);
+                       }
+               }
+
+               for_each_ras_error(err_node, &ras_mgr->err_data) {
+                       err_info =3D &err_node->err_info;
+                       mcm_info =3D &err_info->mcm_info;
+                       dev_info(adev->dev, "socket: %d, die: %d, "
+                                "%lld correctable hardware errors detected=
 in total in %s block, "
+                                "no user action is needed\n",
+                                mcm_info->socket_id, mcm_info->die_id, err=
_info->ce_count,
+blk_name);
                }
        }
 }

+static inline bool err_data_has_source_info(struct ras_err_data *data)
+{
+       return !list_empty(&data->err_node_list);
+}
+
 static void amdgpu_ras_error_generate_report(struct amdgpu_device *adev,
                                             struct ras_query_if *query_if,
                                             struct ras_err_data *err_data)=
 @@ -1069,9 +1099,8 @@ static void amdgpu_ras_error_generate_report(struct =
amdgpu_device *adev,
        const char *blk_name =3D get_ras_block_str(&query_if->head);

        if (err_data->ce_count) {
-               if (!list_empty(&err_data->err_node_list)) {
-                       amdgpu_ras_error_print_error_data(adev, query_if,
-                                                         err_data, false);
+               if (err_data_has_source_info(err_data)) {
+                       amdgpu_ras_error_print_error_data(adev, ras_mgr, er=
r_data, blk_name,
+false);
                } else if (!adev->aid_mask &&
                           adev->smuio.funcs &&
                           adev->smuio.funcs->get_socket_id && @@ -1094,9 +=
1123,8 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_device=
 *adev,
        }

        if (err_data->ue_count) {
-               if (!list_empty(&err_data->err_node_list)) {
-                       amdgpu_ras_error_print_error_data(adev, query_if,
-                                                         err_data, true);
+               if (err_data_has_source_info(err_data)) {
+                       amdgpu_ras_error_print_error_data(adev, ras_mgr, er=
r_data, blk_name,
+true);
                } else if (!adev->aid_mask &&
                           adev->smuio.funcs &&
                           adev->smuio.funcs->get_socket_id && @@ -1118,6 +=
1146,25 @@ static void amdgpu_ras_error_generate_report(struct amdgpu_devic=
e *adev,

 }

+static void amdgpu_rasmgr_error_data_statistic_update(struct
+ras_manager *obj, struct ras_err_data *err_data) {
+       struct ras_err_node *err_node;
+       struct ras_err_info *err_info;
+
+       if (err_data_has_source_info(err_data)) {
+               for_each_ras_error(err_node, err_data) {
+                       err_info =3D &err_node->err_info;
+
+                       amdgpu_ras_error_statistic_ce_count(&obj->err_data,=
 &err_info->mcm_info, err_info->ce_count);
+                       amdgpu_ras_error_statistic_ue_count(&obj->err_data,=
 &err_info->mcm_info, err_info->ue_count);
+               }
+       } else {
+               /* for legacy asic path which doesn't has error source info=
 */
+               obj->err_data.ue_count +=3D err_data->ue_count;
+               obj->err_data.ce_count +=3D err_data->ce_count;
+       }
+}
+
 /* query/inject/cure begin */
 int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
                                  struct ras_query_if *info)
@@ -1156,8 +1203,7 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
                        }
        }

-       obj->err_data.ue_count +=3D err_data.ue_count;
-       obj->err_data.ce_count +=3D err_data.ce_count;
+       amdgpu_rasmgr_error_data_statistic_update(obj, &err_data);

        info->ue_count =3D obj->err_data.ue_count;
        info->ce_count =3D obj->err_data.ce_count; diff --git a/drivers/gpu=
/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 3f9ac0ab67e6..55bcd93d5bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -513,10 +513,7 @@ struct ras_manager {
        /* IH data */
        struct ras_ih_data ih_data;

-       struct {
-               unsigned long ue_count;
-               unsigned long ce_count;
-       } err_data;
+       struct ras_err_data err_data;
 };

 struct ras_badpage {
--
2.34.1

