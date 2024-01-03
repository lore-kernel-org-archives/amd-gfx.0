Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E42C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 11:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E8E89321;
	Wed,  3 Jan 2024 11:42:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D509489321
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 11:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4FE8Q8JuedwRlR7T4uz0PkHIpQV/TUbOAl+wOfgW6m0TBpufuUMDdZnAIOjKVQWhOoOciTe8JyAM5cnFhoOVngEKzK07+1s6N0NUVjWatnNwvy4Atn13KV0PaIDluKYBq2TH2HerbKR+bw6TWfLYVOBM3vXw84SKQ1j9nisDtKPmVd7gQZ4mgkSTfx6e5y2c+KzrbevlLBIFMU+yfIQ5tbOfXVyCxb6ZKTkego6emMPm5qIXb+WbUjwCeeRdLcMjUyBLMkS7iEb5Mmea77Z/BdK8/yIfar7HkmHeffcJzUi24qsd14unPneO6nQsarQKXyhO38gEcst5dqEoZmMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tb04OzsZke79czFEhq8hNjPZRMQDwionM4PU6Abz0qU=;
 b=AS1+9WD8jPyzsqIv/avIK875zOto/PtUQcTe3142Pw24eN/xmyzxxfEtRk83iZLJ5QF1B6VrfdZdcP+l/WGl+L8fm4K/3/UfWVur7a2dbTdEn65HsOZ+5PYx3iltQf4TEKGUCNxGQtM3Zb+bU2hrw5x1/qSlYXgptoM8FXY2XfJ8mwcy6etEM8DXZwX78XEEonpoiFO/he9NsqcnMT2ZU3wck5ETYyMn8GKB2JokEiyEidqjOx7AgeHOeGN3q+gb19Ytr9EI2DwueT8WuUmFxXU0n7N1Wbp0A3MwGUKIDp+cOJAWX46DJbCVgKGIoTKf942Ec2qbs2EupSO4PAeN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tb04OzsZke79czFEhq8hNjPZRMQDwionM4PU6Abz0qU=;
 b=pk3mS0Jty2cj6C5pG553mQtePdpZJaN+45Ga8SsrLakNtrP3axO5Lp+PXpsR9gM0Gxb0qraKHlbgJFz9aXW+khY2rxb/SkPtluOI4BVGkQnAhTSHXL2qnFUJkxo6hnfuBQI0TLzEq7o7WHugCxcc/eovE718vggcNSScxUfRr5g=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 11:42:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 11:42:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support
Thread-Topic: [PATCH 10/14] drm/amdgpu: add mmhub v1.8 ACA support
Thread-Index: AQHaPhtp8BvJ+1eN+EuS0WP3Y157KrDH9fhQ
Date: Wed, 3 Jan 2024 11:42:40 +0000
Message-ID: <BN9PR12MB5257F9EFAC4F48DCB1A79EB7FC60A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240103080220.2815115-1-kevinyang.wang@amd.com>
 <20240103080220.2815115-11-kevinyang.wang@amd.com>
In-Reply-To: <20240103080220.2815115-11-kevinyang.wang@amd.com>
Accept-Language: en-US
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4534:EE_
x-ms-office365-filtering-correlation-id: 64294167-4362-4bd7-e5d2-08dc0c5117a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MXlzbPEpakjXx2PGCEfOIH0abmZNxPOjEJLzLRxMY3Yu7VCiUyJfzMEpqF325RJZBYHLkcZ2+GhhsKCQXpnip92nqAHixazAFe4Y8uFK0sR+O+QM9E3zKvd25p3UIbkAdtww5jX90DPQ5UYuXTKfC9uWMzv0Nv+GzrnnW7D2WY/JHaJrw9W2HI6P7JFDiKQRJcV3MejUxds/2cUgUPMBueCRLGkjPYVF32eLVujsiAVrLjhi3lnVSBDp8Z2rpAAss4xrMUdkYFFIASV6cZgTk339B1hWE56+1F+tcXDuipBip29G9BkluMNLaN1L5grAoLovnWbuNbsFP2zhmnVz5LthAXEMQR7kqDFwIM60bnm+87JIefEKlA0XX0pzUcD3w+wmQ2d4UqRF3KdRiLo5kPLvgfxQ8h9ojBxlWYcfdsmdT/PtUOP2fJpYuQF33s1dcBDpCq4BH+yTjOtjGmbMi0kzgVqbOCfYBdHF7lbirQwEmkHlR8xpUWJqst5j2BMWGtxxaPuuroeOs7S78M743S66gXb3jsfaDtNm+FoPMQgtsLGKg5x2CYIsX7NjubRVSmxLKDHLc2YZ7AAWDtjLNhFxISMEweIP637hjlD0EuvyePiF40iOO5jY1KBWLbMA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(71200400001)(66574015)(122000001)(66556008)(38100700002)(83380400001)(76116006)(110136005)(66946007)(66476007)(64756008)(316002)(66446008)(54906003)(478600001)(86362001)(55016003)(33656002)(5660300002)(2906002)(52536014)(8936002)(4326008)(8676002)(38070700009)(7696005)(9686003)(53546011)(6506007)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W5/jVD8vK6hWyYjo8NR7kRJMzMB/4VYgnlWvHq1/3brU9CJ4rlAJ3kdKlqir?=
 =?us-ascii?Q?iyeSvqISkeGoAZn0LzS2d7EtbEMc5jHiQdCA2oBHBWdfSQs+v5R/2NnVgGJ3?=
 =?us-ascii?Q?IzaOL4XMhigM5Lk1e36Yt1S1Mmmt/ejFTKfzaKKb36iM+cx6EiZMvFaARCnU?=
 =?us-ascii?Q?+HbvYVEkrL57Bje55AsxaGngktmVs/sF6x2Ofl75G6JwAlZ2Rj9hncFDOcJ+?=
 =?us-ascii?Q?m/yklbJtXah28P62q1lG49ZTS+50x6bmZomcUGHYjPWx9z9qu44ysG0pO2ig?=
 =?us-ascii?Q?QsebYHU9H7LNSKH++CtZXH3X0Zptuilal1CvpZv8JbpIyUWQTd1BvViA5xpL?=
 =?us-ascii?Q?LEDhH6Q8SlolPYYx+SOHnWAm8M8n+X6bIAmApra8mf/92eGJG/MiYhRGkpAa?=
 =?us-ascii?Q?a81e7POgC1ed80lM3TmWxKwXQDhzmjrrMjGSev3Wuhcol/A8QJz2NWBno0xM?=
 =?us-ascii?Q?mTkpTNk/y+hbP0HP8alr6M7+IJJV0ZIlgVY5lSlX1ZZhPmCWWyNxJU2rye8m?=
 =?us-ascii?Q?Kat3nY2y6FbyIcqDCpkk8ukdoRtVlQ0yRXk5MVKTtzdqxYMLfdQe2ahzLJVa?=
 =?us-ascii?Q?XbhA10rNhIUxe3n5pNa5AcpJlQOd7l7hYc8ApdLstV5ohNA0KQ+8nfxv6h+S?=
 =?us-ascii?Q?5fIATdDw1jyRjGc8PYkVGys81OxLmnJ4RGRtqhWLsmGM/nFYKE9rkWdZrJL7?=
 =?us-ascii?Q?+aHsd2SpoqQ9lJXvBWrveKVoZL1uSVZrCpH8VE2MNtJRkeWVdNRjuyJ4zBdn?=
 =?us-ascii?Q?GYuKDY+mgSJ2znetiwFTOvAJYQ7gfgIf+dWUwLoLMX6z7vqsJ9Kcz/lpRpqE?=
 =?us-ascii?Q?i/tybnTphCp233uclUC9ioxwxvP5dIe/Lla/epQnuAHkc5dSNsg1veBA7ONK?=
 =?us-ascii?Q?680tBNLFloG4b9VbQZIppQT9LD9qGNunAGWhc3OG0zCzM/MUqIBbh54hF3GU?=
 =?us-ascii?Q?t6t2f3Elti8NzGXN5ciL45MqdU4231Uw5rv4vzABViqcWqjQas+a3D5G99lh?=
 =?us-ascii?Q?T93jL0VTcf6nBHqi8DQa1t/TUvUVg5tbhc8gYQNrmwjZJ1W53mRcv4IDRl80?=
 =?us-ascii?Q?JB7MOPB/RpQLMH1X3TsEAy/j7UASZMyUADtJ727doghsiD+kurFjPxfb98Jl?=
 =?us-ascii?Q?k8zuM9ZJZW9b52Yjuuiyl/oklWB824/218Zu1dE7hK8YCbbsu7U0mJBTLvj2?=
 =?us-ascii?Q?2Cu1Q6F/iMqpPh56C2+DnrY+3BVgtlZOs4Unjupj+Aoy2XL+BugjcDWoswBr?=
 =?us-ascii?Q?QRbKUNRs8Cg/ynEcOoyWhes1JNrWrMQBqYooDOu4Uz81FAGkJpspa6WJ2mbE?=
 =?us-ascii?Q?vEAnNtgiRBRrZbENeSfqsx2L3gjXi5bxWlfd8HX1oSu+bWLrluDs8iXsyvwc?=
 =?us-ascii?Q?ySHEZmaIPouVqSjZ7jbKozwZhOeNigTXEkk/TGGAjkV8c+gsI9+FrPUwgRqm?=
 =?us-ascii?Q?XAZrG1YirL9CyNJqkckDYfv0K9PH0FAv2862g0bkkpWZCxkkfFa/uxJ4dLHb?=
 =?us-ascii?Q?XCvPqK103MWKX7B3fxONOg3b+iXOba8AxStg5aLARZBqe5pp60DPZ7B9VXlx?=
 =?us-ascii?Q?2RhiCd6iZkR2O7BM27e/qHFubn0WhSAk+WZwwE/+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64294167-4362-4bd7-e5d2-08dc0c5117a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 11:42:40.8164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CtZD+cUn4OGlUM87Pk3HIin8+yvB0pjWPhBl5Pdj9UYEIbzWnNa+3+N+z3gQyGYlIYgL0nk7zxRHqTrsDesv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
+            ACA_REG__STATUS__ERRORCODEEXT(status) =3D=3D ACA_EXTERROR_CODE=
_CE)) {
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
+       .bank_ops =3D &mmhub_v1_8_aca_bank_ops,
+};
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

