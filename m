Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F0EC3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 02:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4A410E2FB;
	Thu,  4 Jan 2024 02:44:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::622])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF7D10E2FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 02:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsginfYW3aJI9PYeJ/LWrU0h0ANr/BCp7qYR2oPb8Q5nE2Xa1tgFLBTaIl1RdAqy7MSK61MWd8JiF9c7yHq3Gsaq/p5U6MiCi53IsGf1+geQha4NX74aEXEcUOzZsPSkbR5Thm4CISDOkhqTwEjSuKDkpqxoUh6YVPD+ikOx0OtRwuS4jwJV6VoXz9eftwHOAXm6nlVrWfRAWNtcgBbq2DPIkYc+l8VzfG0T9JQYO3gXjE2p44iQC3BeP49SqXfkScmxZoiLuQZy8SQraESUBo+8Dd3PaHepIjabDUwYGHlUrEFR68xtU3ybIsNAc181lgw+npgxRKoQAqdG1jT++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2B0Elxcrvz3qgRaNC11sk+kX/jyhNWaZxvvPmS7dKM=;
 b=nmCqUhneKdAQQP57IbGL0F5H+rPLePI4/WgdEkzkWTJfRpvJwA6ob/s4xeJha47UArBzvsnu9tHVyjHGtTbYwg6kOMxrTJ3niC4CTWCq8nibqWNjG3q+BK/bKiNw+q49zlZqedr1aNxmdbTz8bUwImXB2egyzzkj3GEZ0H05y+PmfudAMSWcTtN7PMBWJgcMJQ3wGJB/IYrJu7Zc/D9gKpCrJh97U3bsBCd/gthODfAmQidfaj1F/+gkbzbWKkzv8Zrw2kaaEAE3v4l2suDkWvmTpy4SEUHCA7aQldMRpL5/HtvwzmN93J6Rykh+gMu9Y7gzbDIxmqyEVBvKtIRQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2B0Elxcrvz3qgRaNC11sk+kX/jyhNWaZxvvPmS7dKM=;
 b=1KZDgwXpMjIpD7vvQd6V0LSaT6HVcZcNHNIRZ7ihnDby0rnfokn9bJBCz1xAlan+yX+wbr1F7L316Ywtifs/kKl5MPuc730sZiq4Hwl/gM9S0+/bbhKgmjnTsLyQpqyBIiNYKKYc9gipWDeRDRYYfI6GvJl4cagoFTxdtmA+VcY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH3PR12MB8307.namprd12.prod.outlook.com (2603:10b6:610:12f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 02:44:39 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::61a8:83e4:c057:7790%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 02:44:39 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support
Thread-Topic: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support
Thread-Index: AQHaPhto8c35GPRHeU2duCj+rjoAxbDH97IAgAD7/DA=
Date: Thu, 4 Jan 2024 02:44:39 +0000
Message-ID: <PH7PR12MB5997EE03838C561EB1D0B73D8267A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-11-kevinyang.wang@amd.com>
 <BN9PR12MB5257F9EFAC4F48DCB1A79EB7FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257F9EFAC4F48DCB1A79EB7FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=df7503ce-cde2-4e77-a772-2b8495732928;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T11:36:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH3PR12MB8307:EE_
x-ms-office365-filtering-correlation-id: 1c288a7c-f06a-48e1-efd5-08dc0ccf1910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r/Cv39vfeYirJTav236DHVG8yzXqrFRDauwpGoNfN4p83VIT5I1fBNDL78FSXvGNlNLHQysWA6Bzp/C6YuB4tgose4wBU19SiXvSFDH+vxK+KsPOWRoU1Fw90fSeJC7ziGOOnzA/uaFzaHjsUkyMJuTEORdm7STg5wOzdMt+81LiENn/3k3RHedkKNJdcdCfFSUjps7ZPMpM5Gku+nZ2HlMGHlvIEC3h5sPIcIdaoIpP9E+1ziGzui1nnwt1AnxJLG2mEnv6Uq7t0Mcu8IGJ6/CLa2XWOcyb6FV5OSGKDUBrtlyuCSj2lGc2ESaBkU99Zxw0Ebj05PkFwOTIzTrDEpYhj26QIjTu4NPPqgmmeytGI7sLThHaoQh9nh6OSHopDQTEH/oOVTmM6857py9wFUouyFQEBuusuxtcf/tZd3pSyZnmQ5bIsA8plurZH7fgJewX6gc/pgbEpNALy4AdHuAv8aNccSv3T5eAr/8V2xUSOIbnkjYWF42kk7SRfZLm26jhOuKJNpawqYjmLd9wABl7y78U2ls7mOV6sJXGNkmKOYTCUPPMv2jhPCjrJFaVW5AJ+IOGMlLa9UYUWzzekhuPIBK3YuRgd5FmpV90VR0BT53SjcwKepBim6vHH+zA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(55016003)(7696005)(9686003)(6506007)(53546011)(26005)(71200400001)(66574015)(38100700002)(38070700009)(86362001)(33656002)(41300700001)(83380400001)(8936002)(4326008)(52536014)(110136005)(2906002)(5660300002)(8676002)(66476007)(66946007)(64756008)(316002)(66556008)(478600001)(76116006)(54906003)(66446008)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VldTM9koFEsf1MWfrRsIujMDLabuY5m8v4s5+mqUaZ1SKHvhtTEIaGfKFwwD?=
 =?us-ascii?Q?qUWTIeHeIHC2f8rPFEzapDEkc7a37Gd2xICUKYfj+oOQW8Qe2+tcE6PMg4az?=
 =?us-ascii?Q?nQCPrbWtmuZUQ6MKfRT/0umBy//8thp5/uNuckSnQ3lIOvrDddzn/MJmDrm7?=
 =?us-ascii?Q?Ei7g26qLNd/BKsSnw+Ccs0y1fzH5xRTlPevBVM5I9W5j5i6vNXusCaEx+gde?=
 =?us-ascii?Q?akC2Vv9XPJUC4+1oymb0GfIwKLLhIhp03FiFHUrHHtpKw/65QzMZrDUX2A0F?=
 =?us-ascii?Q?09gzJ+2wMmARoEQZAIqDB7+b7Mgapp6nuhU2sqamU381pPDhk0fHwPd/TZwo?=
 =?us-ascii?Q?ympQzgO0pzgOWm5hvcSaxtPLc41phm7MUo6DGkTxfF130dbDDnPigxHwm3I9?=
 =?us-ascii?Q?KiB8QcCV2cXI8PmbK/87xeY7FBqYoYeCCN6WpZeARzSWWaI8zvpKIW+5V6vo?=
 =?us-ascii?Q?nwJ7+8kVgiTCVx6oNyUGLdgvdhf5j7clGex0W+ou9xVsf3yy75tzKir+dG4h?=
 =?us-ascii?Q?R6kF0GGOXwxkCILir21y4XTuDvMSSKyOYEB9oNEqwQfsEKo4g7GzXdhSkbA/?=
 =?us-ascii?Q?SdpdoZIIfAH6WaK/FAsZxvoV19ApkrWkbpJcLSynUpgKnXSTtp8n+yASlS5c?=
 =?us-ascii?Q?3kDYJk5O9h7YtikvlG6IOOTB7HxFmJuixTbc8H+EJFGwppIvx/Rp0y4LOuDo?=
 =?us-ascii?Q?zrGt+fMG+twrGGPruiBaxGzKvWMgQbu08v5QXh8YUZVQUxRq2ofSeTwM+AIC?=
 =?us-ascii?Q?WmP9i9vvI8yzx6Z8mGCtcYBaKu2LKfaZ514MKm4wwBV2VdpgIVzQnphmF3di?=
 =?us-ascii?Q?0gNNx3+wBdIPDdfcHQHqSoAukcCRoQ/PvyxwAJDeWganCtNH7lXTIrr1R75X?=
 =?us-ascii?Q?w+KCO+Bl4CQLxbSJM8Irca+ow9pw1ANIRYIrWxmu6PtTsCSKKbiSR7a1xeYN?=
 =?us-ascii?Q?E5qMR7kS29VLgKg832wSA70OdDfn3+j3KzTGt/apTBa5mfVfbae2AiK3Df3O?=
 =?us-ascii?Q?Ky5sj5rZ+Hek+TA/jyCqnk2/S+z+kZANlTi7bPXQsxNWY246FA0jzx8WSqZo?=
 =?us-ascii?Q?MtVizHFP+YbiZbDSj9WgPiqcerV+lXrDAF2i8cVaORe79KgJ6M775Oj6hTin?=
 =?us-ascii?Q?n+R7c8lEE1zVu0zVDrh1vOYufRmtVaGdbiDHDrCExdmTEgUp1PPpCwd4lAJ1?=
 =?us-ascii?Q?IfJ4Tp5O+we4zlCbkvNngY4TaclgPuJlCXWxsDQtCmT8gatMx+nMR/AIPdbd?=
 =?us-ascii?Q?rQ/v8YquJS1F2B2hNHSc+E5AI2cg9yHwWUwQu/sLqT7P56f59OflZWlacbXM?=
 =?us-ascii?Q?YQxVNS6qRtkHnA4Nu83v95Xn8Qq7COJafPZanTbgLjwCdCpyrnkhlyKYL2uo?=
 =?us-ascii?Q?GmiimAtQcDx8T6N0ZFLzCDrvREteE5rW2o2raYg9Jv5AYlNoeVdiwxg9j+BY?=
 =?us-ascii?Q?p5aSvyhvLd+8kCyJLdwCGzidZYjpeWsqBf+I4lNlD+1wLb7UGsi80bb1Bf5s?=
 =?us-ascii?Q?TTjb2OJ8lPzJr/651KOgbX6hjXmlGtWBE4AmSD//TGTyULGhZLJ1TgC7jokP?=
 =?us-ascii?Q?pk2PwwkzEVEjBLwXU4Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c288a7c-f06a-48e1-efd5-08dc0ccf1910
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 02:44:39.7552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDpxSqljSmRLjNOISxt0TCpFsgX6WWhu9GVbXEU8wMIkLWNPnOj6xA3q0DvLHBHE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8307
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

Thanks, will update it in next version.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 7:43 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support

[AMD Official Use Only - General]

+       if (instlo !=3D 0x03b30400)

Just nitpick. Let's still use macro to define magic number 0x36430400, 0x38=
430400, etc., although the same magic number has different representation d=
epending on the IP blocks.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, January 3, 2024 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support

add mmhub v1.8 ACA driver support

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 87 +++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_8.c
index fb53aacdcba2..a0a4a2f3227f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -705,8 +705,95 @@ static const struct amdgpu_ras_block_hw_ops mmhub_v1_8=
_ras_hw_ops =3D {
        .reset_ras_error_count =3D mmhub_v1_8_reset_ras_error_count,  };

+static int mmhub_v1_8_aca_bank_generate_report(struct aca_handle *handle,
+                                              struct aca_bank *bank, enum =
aca_error_type type,
+                                              struct aca_bank_report *repo=
rt, void *data) {
+       u64 status, misc0;
+       int ret;
+
+       status =3D bank->regs[ACA_REG_IDX_STATUS];
+       if ((type =3D=3D ACA_ERROR_TYPE_UE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D ACA_EXTERROR_CODE=
_FAULT) ||
+           (type =3D=3D ACA_ERROR_TYPE_CE &&
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D
+ ACA_EXTERROR_CODE_CE)) {
+
+               ret =3D aca_bank_info_decode(bank, &report->info);
+               if (ret)
+                       return ret;
+
+               misc0 =3D bank->regs[ACA_REG_IDX_MISC0];
+               report->count =3D ACA_REG__MISC0__ERRCNT(misc0);
+               report->type =3D type;
+       }
+
+       return 0;
+}
+
+/* reference to smu driver if header file */ static int
+mmhub_v1_8_err_codes[] =3D {
+       0, 1, 2, 3, 4, /* CODE_DAGB0 - 4 */
+       5, 6, 7, 8, 9, /* CODE_EA0 - 4 */
+       10, /* CODE_UTCL2_ROUTER */
+       11, /* CODE_VML2 */
+       12, /* CODE_VML2_WALKER */
+       13, /* CODE_MMCANE */
+};
+
+static bool mmhub_v1_8_aca_bank_is_valid(struct aca_handle *handle, struct=
 aca_bank *bank,
+                                        enum aca_error_type type, void *da=
ta) {
+       u32 instlo;
+
+       instlo =3D ACA_REG__IPID__INSTANCEIDLO(bank->regs[ACA_REG_IDX_IPID]=
);
+       instlo &=3D GENMASK(31, 1);
+
+       if (instlo !=3D 0x03b30400)
+               return false;
+
+       if (aca_bank_check_error_codes(handle->adev, bank,
+                                      mmhub_v1_8_err_codes,
+                                      ARRAY_SIZE(mmhub_v1_8_err_codes)))
+               return false;
+
+       return true;
+}
+
+static const struct aca_bank_ops mmhub_v1_8_aca_bank_ops =3D {
+       .aca_bank_generate_report =3D mmhub_v1_8_aca_bank_generate_report,
+       .aca_bank_is_valid =3D mmhub_v1_8_aca_bank_is_valid, };
+
+static const struct aca_info mmhub_v1_8_aca_info =3D {
+       .hwip =3D ACA_HWIP_TYPE_SMU,
+       .mask =3D ACA_ERROR_UE_MASK,
+       .bank_ops =3D &mmhub_v1_8_aca_bank_ops, };
+
+static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct
+ras_common_if *ras_block) {
+       int r;
+
+       r =3D amdgpu_ras_block_late_init(adev, ras_block);
+       if (r)
+               return r;
+
+       r =3D amdgpu_ras_bind_aca(adev, AMDGPU_RAS_BLOCK__MMHUB,
+                               &mmhub_v1_8_aca_info, NULL);
+       if (r)
+               goto late_fini;
+
+       return 0;
+
+late_fini:
+       amdgpu_ras_block_late_fini(adev, ras_block);
+
+       return r;
+}
+
 struct amdgpu_mmhub_ras mmhub_v1_8_ras =3D {
        .ras_block =3D {
                .hw_ops =3D &mmhub_v1_8_ras_hw_ops,
+               .ras_late_init =3D mmhub_v1_8_ras_late_init,
        },
 };
--
2.34.1


