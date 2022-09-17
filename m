Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBD1ECAAD3
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Sep 2022 08:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2EAE10E2D2;
	Sat, 17 Sep 2022 08:22:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF4788DA9
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Sep 2022 08:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL4XK0ZDsec4SrZqRhG53WljPMZWmGPPtWwCmAzwASoatndEZmRxgPv+FmzvFvzaSjOueFBki5dr/ybTVRkSSSYfO3T9LciD283UAVzV3F/NDYuHnm4g1n/ebwqeFh9q0J/HvjRYoA6WOrkpdknXCVM/ywBhg9B2XdapCfghLaBM6VVLBGkduUFjLePyrNz2g5aX9v7rpl/MotEzW9Y3eq5Q32tyMo0zjS4kmAEhv5HresnbPUrA4fztPm2i8SXzDvrnW47KQbYVTddlL39QRzgUd7rasoA+RNMWoxCr0NCeoUQQ2rgcQTAAjlxojLOc5EpwG4VzUy3u+5gFJc3Kdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km9vOUuDiZch72GjLOHQuREHyTWUR3suPrOpqSq5MBs=;
 b=Dn7kLyVArin+6L2/S7cBeKeXb3mxJqC5WawICIFoH/Mnp6ylkLvJl7bfgPWZx8LQ/sRnd+G3wpGrrg5w4yaFGI21jv9cUOIIwAL82pPjld9LOb0PvPNLZHOKCP0jxFmh2XBXHvXprI+9lCHP4X1WWMWQ30oZKyfpuo0XIXY3Wu82QiH6Wz5pY58woHIGkAXmyRY/3J0xvaPnPGsSpmjgJJiYIrClrC312EapM0QvlzMb9I7DLQT65T0UVS3ZsnS4D/RI7jJfsTWAG5Xw1MLSuThfOHqSpmz69jtpw6tQTMEcJqmKwO7wsturcHphX5LpOwVBf4TrZDsx6oCoIkXiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km9vOUuDiZch72GjLOHQuREHyTWUR3suPrOpqSq5MBs=;
 b=S5Fhh7JFp4P48QqXQj41JtOobHwprS/xUbeCPQ+FBcKXiOqwyWbTcZrkSUuB6mmxpBbImtuPZpcVur6vq8B7GWhbL1MFmT8poKkjt0KJnNYhqfLsEvv2W6IrZKOPoCsZgSjSshIL9ohLIbWq19ybC2GxT4A5KJTh3Ado80c9XDQ=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Sat, 17 Sep
 2022 08:22:27 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::cba5:b50c:1946:e2a2]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::cba5:b50c:1946:e2a2%6]) with mapi id 15.20.5632.018; Sat, 17 Sep 2022
 08:22:25 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs
Thread-Topic: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs
Thread-Index: AQHYyYZp57a9aN5dX0Wc6Eio9fqzr63jSffw
Date: Sat, 17 Sep 2022 08:22:25 +0000
Message-ID: <BY5PR12MB38734688AF44F7057E1E4651F64B9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220916043859.109621-1-yifan1.zhang@amd.com>
In-Reply-To: <20220916043859.109621-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=14d3458c-60c4-41ff-8ea3-90e3cdd0ddbe;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-17T08:21:38Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|BY5PR12MB4871:EE_
x-ms-office365-filtering-correlation-id: 2186d339-02e0-4dab-03c1-08da9885c052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTAJ4WzrP6zFtW/hPr6LwEZzh3uAfz0h/0W+J8MSG3fetYKf/LRCk2kUqtmfSPISI0tC4NAF1NidRyBSBf8X0caD9+/kHL7b8kk1a3cmihgDv5roAS6Q/hndgzDNs+AkhrdT0c0hC5T9z1iwr2DIdeP7WjAvX6OuHMfsgVFJ9BwMChUDEe2FjSicvplRmy6Gigs+azSiypBK6YxPOA0JbIbWxhw5eiHs1r1T7pU+qylAfPG3r6IxuNj6JORiMh1m400j8AtFPb6bk8zsfrQAVAetsOgFeorUMHZhcaMqPN9CEtHaWXJc+ZuHKxSN7wau1V/ZIBF+LS9ZwVt834fUPeOuD2ytgbeGRQQLWOxv7813XFHMphwTgxv7gyiWeXQZmCi9AWyOMzPTtgiGw90xIg/wl4CCoiXi21BeidPePVeEPGqunGBh1FSpNBOeu7/Rs1+jrOIij9hL/Ma9nlD96JTTzgeQbLkMPMfmCOhKEAu8NlfrjJmMu5yYdpNvz5nz+C0KkBpbUtKPq4QQIDjHasbjyNSQeg5Vk+FxOf/aJ+SvgZ+XrUHB7tIk7ADjqQdBOmT601vcF0Dusx6KKAGkYjBJcwXTuqUJra7cGZOxrDGK9n0HkpqYiGfs59fli5jBVR4cnxHaSq3RbEFqkSKIBKjKZnyFZqzYRhV5EFyiVq3H577MRcKr9o9fagcRE7j5DbAdoaJXV2gK+xkzXJKSz0d8uyS4wAA6reUABZeIhg3+/0QDARd91xVM1rj6THbjStr07RYepfwm4qVoI6+dzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(38100700002)(66446008)(54906003)(33656002)(5660300002)(55016003)(64756008)(66476007)(122000001)(71200400001)(6506007)(66556008)(76116006)(110136005)(52536014)(53546011)(4326008)(83380400001)(41300700001)(8676002)(478600001)(186003)(86362001)(316002)(38070700005)(7696005)(8936002)(9686003)(66946007)(2906002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?++d3tsaJO1gkB7s+dH3qGEdJHGBSrlBo6u4h205T7Qc+IB6YSJcj8aeS1KQe?=
 =?us-ascii?Q?aRKwd/TdzMqHvUhRLgZ5ZNrXIJHF+LMqQKNFS2WKbdTS08dOul/DwplimH7N?=
 =?us-ascii?Q?LMmuJIU+dGs0lwHP1oiAw3xafmHnWLrUUkEDoPqCeU11OxGIxhGvXkAzpFdi?=
 =?us-ascii?Q?CIh2zoeiMv0uo0QhvTpV47qFu5eq+Nh98cF2OElGU6wr+kSxZ229UJQ7+cpD?=
 =?us-ascii?Q?jPz2/myykVKKz8qLe0OCZgCVUDGU9psrPcK6FrMDrmnFHUIr8LrqV5rwasNH?=
 =?us-ascii?Q?dTon0rHrDlbpuBHt1vxtBRprW7FB5Na+Jd5sPmQRsfpYkA/dEdgneUHH6Xxv?=
 =?us-ascii?Q?7YSrRupxj6Ihvg0MTuBdBukjFlKAO4kKMTB3aYbwarwLmqz/uRsPHMVKDuFK?=
 =?us-ascii?Q?lyTB6C+7RXHbXdHpaywtbMwIWzuv7+GOfhPUmT4Np5ZKjLswR6DaFW6gNW7S?=
 =?us-ascii?Q?by2k3aAaBwf5n5K/Jucuj1mPFbOK+0L3ESCftin0atn9b9in4rXszRnrmxzW?=
 =?us-ascii?Q?hnTpcC/vbirQYVIj3pNanKlRs8/j06daJ268z2fstgJa+X0fMASqIQzgKsLm?=
 =?us-ascii?Q?CKKi2XzxDgOmQGSh2h04RBRocUVq0CJebB2uySS+EVP173q4cCHokWzc7YHd?=
 =?us-ascii?Q?fVxYn9OTzEpim0MrETDTLjf5hsjzeCfOorcdkCt+dmyez+oBdr1VNiRPPp+K?=
 =?us-ascii?Q?9PaLTjmcVYqAvCl87n05zyij952VzKhd7iYkKjnNtqwwcZNg1iROCV0w1shK?=
 =?us-ascii?Q?PH6ZjSFHi1BsP8F+ynXKH9XtRpVq4Kv2LGQ5drYTIJeVhkWONsuxB82tzgVE?=
 =?us-ascii?Q?eCUCqwxVcmthsvT1oLG9q9wyQ45Z/OyJk15OT1VB6G9D4ZbwG/IuQzvAJrEe?=
 =?us-ascii?Q?yn6Y6nopryAZjUmIIJSWhASsPT6clua1qhgFVHvCsP8sOZc4uLO/agxj/tbQ?=
 =?us-ascii?Q?EDwGBve74hK2HBqcS5ZXfwTAIn7JmBux+sjm0zmo25ph38DV5xNjtyBQUjHv?=
 =?us-ascii?Q?sR78jZ8LZL/QT2DzqW86U+nnTxXJOTcH60ZvaWZxtvqtE+DuqRtkjqn0KDTK?=
 =?us-ascii?Q?q8xFqO/mzd/qXwUJHTcxd1JVsvreWkrY5yHT8ZDFHvNngrmRA9ZkVfDf8aOa?=
 =?us-ascii?Q?3Ja8dOdyTpjFazk+tgqGjR+kSNkzUsjlUl4HEAst11Tb3ZVvdek12NxiYjhJ?=
 =?us-ascii?Q?tUQMJR37MWUpGg4L+trrWb+aHppjV2bVrKq3OSB8oeNQ7GBZ92blh6zp7V6l?=
 =?us-ascii?Q?XiIs8ZIo0ZsKiK0G+C6gVVIaoU03EFv/41q+l7UfwWs5VhhsGTzZ4msQsxvC?=
 =?us-ascii?Q?/6FXq8LRDZQeipHFGp6PuJ91XqJRk/XJ8kKOB2N/ciDjc4Sp8g6sHT9grxgD?=
 =?us-ascii?Q?TOthJ94XJAQ9LhLhSIW+uUaoYzPQL0+uvtJrkZ3qN3cRYPSybfObNMyDF9mi?=
 =?us-ascii?Q?+dRyskgcrJN9LV9KIMfvz8jBhaWCED4dmr5VDqe8u2v0m09CEeojJG+G+w30?=
 =?us-ascii?Q?a1Dtu9Zvs9TZSPQ0fH1/FeGf2BYEk36i2iTI9ueNlaOtY0NjfYRv4F+BWec9?=
 =?us-ascii?Q?/BM89MlZiZhEgaJIG6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2186d339-02e0-4dab-03c1-08da9885c052
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2022 08:22:25.0862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d90KwlIblBcwVsgyu9BRUpTqFDdgEezGuo8okaSp3Y2awrESDJw96O10VIC0I1twK6y5g4khBlljmnPgx/GMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Friday, September 16, 2022 12:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs

This patch addes MES and MES-KIQ version in debugfs.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 1369c25448dc..bb0ed358909f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -328,6 +328,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info=
_firmware *fw_info,
                fw_info->ver =3D adev->psp.cap_fw_version;
                fw_info->feature =3D adev->psp.cap_feature_version;
                break;
+       case AMDGPU_INFO_FW_MES_KIQ:
+               fw_info->ver =3D adev->mes.ucode_fw_version[0];
+               fw_info->feature =3D 0;
+               break;
+       case AMDGPU_INFO_FW_MES:
+               fw_info->ver =3D adev->mes.ucode_fw_version[1];
+               fw_info->feature =3D 0;
+               break;
        default:
                return -EINVAL;
        }
@@ -1581,6 +1589,22 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)
                                fw_info.feature, fw_info.ver);
        }

+       /* MES_KIQ */
+       query_fw.fw_type =3D AMDGPU_INFO_FW_MES_KIQ;
+       ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+       if (ret)
+               return ret;
+       seq_printf(m, "MES_KIQ feature version: %u, firmware version: 0x%08=
x\n",
+                  fw_info.feature, fw_info.ver);
+
+       /* MES */
+       query_fw.fw_type =3D AMDGPU_INFO_FW_MES;
+       ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
+       if (ret)
+               return ret;
+       seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\n"=
,
+                  fw_info.feature, fw_info.ver);
+
        seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);

        return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index c2c9c674a223..12fdf62730b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -755,6 +755,10 @@ struct drm_amdgpu_cs_chunk_data {
        #define AMDGPU_INFO_FW_TOC              0x15
        /* Subquery id: Query CAP firmware version */
        #define AMDGPU_INFO_FW_CAP              0x16
+       /* Subquery id: Query MES_KIQ firmware version */
+       #define AMDGPU_INFO_FW_MES_KIQ          0x17
+       /* Subquery id: Query MES firmware version */
+       #define AMDGPU_INFO_FW_MES              0x18

 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED            0x0f
--
2.37.3

