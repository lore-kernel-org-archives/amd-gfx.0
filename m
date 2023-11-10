Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00107C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 06:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6326110E69D;
	Fri, 10 Nov 2023 06:37:48 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0EA10E69D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 06:37:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mO7Xo19T9gM85dd+9IBTNjTAVn7nCzNRiCOKxqtg0FOpb1dNRHNAurx6clcR4eSrO0CCxo8UOh0qoJrx1bTkxgz23gv2VbxbdNz/GVGXzb89tgidIbVlr53RfUrz56L8qSNnrzEzIR/WCPmfPdRhJMN0b23wPhwzv7XfY1dV77HY/p4t+NFR3It10Y4z72KNiykYWwvMlksvQnoHSk72ruQNgpkJP+YNwnWWmKOhcDgTKMNBeRp4sASGCJqAhMKYUBCIr8zx8K7vqjkMMgpL5Ty62F8bUT7IUkA3Ez9DNH/DAWJvHS8PuDA/K6jWusXat3uw0ZJHiyFlSQw2yO0FlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Cd9xuvhFQRWdUiskj+BiixSdoYXBKFVFHI4dTB7J3Q=;
 b=WbZRUwK4SXhjzAHLt4WAoJmdvw/P/SVJCG1Oqv6yvYXQyAeXURKJFqL0+czAZzHWSSYAPdpvydIlOv/1xcAqoE9eQ0bDjcc7QY7tRb+VSqfvlSgMKKdG2jKcUINl0hxXXz4lmokf3WT1X1LJWglbfJPejbzIySKcL7cHf8+yrbSOskbIu5mSnEOQRuIdDqw9HnNthT2l6fhomJoNIQLj1nReuIN0Lva7FxaVTfVkYc68JMr8ssQlja6JgBh/9q6M7zM2C+0q3Qc20dFOynCImG3ueX/CTisfxFAR+7DXoH7tkllvlnr3nN5c3joxEsh5NY73WyXc8feeaSOeQJ0OCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Cd9xuvhFQRWdUiskj+BiixSdoYXBKFVFHI4dTB7J3Q=;
 b=rZyCCjXtMHiIe1+X+BsbvIImWsEPTwJF89Bg02INj7FPFfNm4kHpWBNxnVsCKhIV4zqQyes3UmDNIBa14YfVYb5vTX/4mpcOm5MES7uYQEpqymRWIu84+xQF6019T+LymydKpvi+lJF11SVR1iSCWZEP/Yet9TrXgO+v2QxQUew=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 06:37:42 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::ca1f:8b18:846d:234e%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 06:37:42 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amdgpu: fall back to INPUT power for AVG power
 via INFO IOCTL
Thread-Topic: [PATCH 2/3] drm/amdgpu: fall back to INPUT power for AVG power
 via INFO IOCTL
Thread-Index: AQHaE1oaWmFfxP3t4k6Ht8qE9Y0m4rBzGeVQ
Date: Fri, 10 Nov 2023 06:37:42 +0000
Message-ID: <PH7PR12MB59974FD0D496B1356EC87AC182AEA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231109221400.936847-1-alexander.deucher@amd.com>
 <20231109221400.936847-2-alexander.deucher@amd.com>
In-Reply-To: <20231109221400.936847-2-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=17b86504-2f52-4fea-afc5-93140310efa0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T06:36:56Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN0PR12MB6271:EE_
x-ms-office365-filtering-correlation-id: a5084aeb-5384-4570-a2c7-08dbe1b78a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8TUBLgz7kGYpStp21UsbTSqvRBDh/oG09EhBq4fT3J9q3D5oetPrXYgLwBHtZWP9eeOKG6l/KmtbYxViLjE6yXDA9nG10nM13MvkwCankN1cjGBvGIYTqxfxDKHZmcaVnh5ZOYi3lJbBOvjGaGfBxLZ1jNSahBGtdJhtvfrg2N6CkG14OgBDKdoiXLVAqlQfNIfekRQmr1LFiOZLmD+uNiX2Kr0RiRCZ7wiFOj9ZlJXMSlkcEWWxyzb7bhPygvsJs0ljusI7TManQ2egj5UlNV5UMk/lMn6kEIfUk5RyREECSwOodclibpmiwfOpoqeg4Rkl1duc00xXtilraDfb0fdyjbVjsbZwI6xB0DZrh6Tc68Dw0SZwUZMXKBAxIW74A6w9zZUfDft2exzkpCxH97fRfZyNl3qmlq8Scx9bcuFrLtiTMsI8DgjhhQPnncb6/rTEiLrY2W3tHyzG9fz25ihQnMn/S8/R53tX7najVr4M1gAjXZ0z4eW2qIZMVsFK0k992gF8S4gxk9DAR9s9W0L/2NwJzhWxnZxZj25LvPzJujVb8XzQjHQqAKfPRyJGKsaFCpHCigwMggz13L0AQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(122000001)(41300700001)(5660300002)(38100700002)(86362001)(38070700009)(33656002)(2906002)(53546011)(83380400001)(8936002)(8676002)(4326008)(6506007)(7696005)(55016003)(966005)(9686003)(66446008)(66556008)(66946007)(66476007)(316002)(110136005)(478600001)(26005)(76116006)(64756008)(71200400001)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gu13/Yyo54kCYnhH18RMSYE6KbWyVEgeZ9b4muIoKL0/KmOIyg3NPPh9JX3R?=
 =?us-ascii?Q?KBeMv7jLN49B5T2e7QhhQC5r4wIsuCY8I6uMHtvRKske91Phk+nherAqSRem?=
 =?us-ascii?Q?DBI9dfMNN2z9iJE9/AixJ6otcHmRXtyD971RMiSCqh8kwgKvxtAeRi7B0b/O?=
 =?us-ascii?Q?FnJ7qtkTgNZR+Gu7WMrH5xnLJoN/K3JmsYE6stSXWDCGLf9kC+FaJgInV3y7?=
 =?us-ascii?Q?YFTXiySBe6uca9E6rU0vPcWrqyLFeqSTCjs01f7ePjbI5dxRLzwIBDgoAZ7y?=
 =?us-ascii?Q?dJ9LSHfWTJGCxHtoHA+bUl83+frZ1jZ1zURjYDyNKPHC3gHDZnqQHZhkaDQL?=
 =?us-ascii?Q?uUOq+Yrq09Yat9DIbJQJ8Bgz4D3UXF+QPodJCtu4G0lmTrcU9zOFn4js9anx?=
 =?us-ascii?Q?5H6zKRAA3Ewejo2tMsAWIRD1e6oYbimbdIcUe4YmLqd0rApCcIneiv9twIZB?=
 =?us-ascii?Q?cHomQel2BXw7Ts4wd5OaubdUXOUQGg6Tje2GiSryPVHU51OdXqg1yrUuWtNn?=
 =?us-ascii?Q?MZ2N+hq8FkPkKtcazrAm4FJsPcFG8BNPYQLJxSES+ltRhnps9HkBqYJtxCJa?=
 =?us-ascii?Q?Ig5Ya++V7PqjPZ4bct2szPKIATc0gDmlotldEfl9pdjyUSg5BB09KFIRNMBX?=
 =?us-ascii?Q?DNx4ee9QVBb7JldVnUBhrW0Rz0Xz3CIx2CqTFmBOFdGHqlfEYabAYZoPjZVm?=
 =?us-ascii?Q?Ki6E7+luSKI8r2SQFbiRmdvEd1k84uxkfEJUOcWY92Wx7pR7ILvvB4ELQ0vE?=
 =?us-ascii?Q?ENtJj4FQiudrNkhZlq9gBMW6a9Fw7KSiVWJ8c2fAOmQF8mnho/HqwEi571mm?=
 =?us-ascii?Q?HGYwX0qipkP3F3EbE0a7SpBHEnTScwizjdlVu6QWKS8I2PUqDpZRx+eTq7vV?=
 =?us-ascii?Q?f8dqdbLfTlCvArDGHaNLlzWjgwSuA2iMbpnIIIqPrYjYKRCBp70hsyZYTXVi?=
 =?us-ascii?Q?ruuZsIpkwSj73d2tuAN0R+dFNcN6xezhVExcQVoe+T6AIaHDXrfflRpHS+7W?=
 =?us-ascii?Q?mFzUVBBJpJTXdyfDfT0U8+CE0dW3FX5anmI/l7hX2O1lgTPQcGgbutjVmBm0?=
 =?us-ascii?Q?XCWjfTRyp4xdZr7VpFluZ26Uc+jgw7+MmU8NCfTb+OuZ3E2T/qZpqeMEYoH8?=
 =?us-ascii?Q?uSnk71JczPI3VULhdRQkzignPhG2wZTuwnsMnIWTukZ5WOJZk3sWebSiA53F?=
 =?us-ascii?Q?0D1hZMRA1Q+4j+lXaftnGevsQ739u9gGOp8LJJ27lCISZq61rLlz6kM8U3Po?=
 =?us-ascii?Q?nfjJkFov6n3Du/eNXp+c+XOAXRxgMsS3mtms0OxwQPuariIAFCcVm/6wDFt2?=
 =?us-ascii?Q?a9mb4ajq/WRzXhYPuLeGS1NNg3JTIeua8nO06uQAKe1ck5oK7U3xL7y/rkQa?=
 =?us-ascii?Q?q9TOOEh+WKJ4NtJyZMYr9ibQrCxatTh0h3alkvNd/ajcSA/56UfUkG9kxTml?=
 =?us-ascii?Q?jh8J54Ib7gV4pYoIovcnLnMWqXASE5ff4N7sNae/sljY4xuawbNmMXL+FTc5?=
 =?us-ascii?Q?RqTPPrO5XZHxTIIB4JgDZH+/eJGVmecz7n+oylzyJP65rOAMZYeWZdX0faQX?=
 =?us-ascii?Q?7Us0hh7PxCGO+97f9gw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5084aeb-5384-4570-a2c7-08dbe1b78a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 06:37:42.0632 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SQa1gtES2FN7hhFX9nCHSQgKsv3MXxvwSvlJ0JNSv0jvgwIA2LrnR5V1/XzRsYU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, November 10, 2023 6:14 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fall back to INPUT power for AVG power via=
 INFO IOCTL

For backwards compatibility with userspace.

Fixes: 47f1724db4fe ("drm/amd: Introduce `AMDGPU_PP_SENSOR_GPU_INPUT_POWER`=
")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2897
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index b5ebafd4a3ad..bf4f48fe438d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1105,7 +1105,12 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *=
data, struct drm_file *filp)
                        if (amdgpu_dpm_read_sensor(adev,
                                                   AMDGPU_PP_SENSOR_GPU_AVG=
_POWER,
                                                   (void *)&ui32, &ui32_siz=
e)) {
-                               return -EINVAL;
+                               /* fall back to input power for backwards c=
ompat */
+                               if (amdgpu_dpm_read_sensor(adev,
+                                                          AMDGPU_PP_SENSOR=
_GPU_INPUT_POWER,
+                                                          (void *)&ui32, &=
ui32_size)) {
+                                       return -EINVAL;
+                               }
                        }
                        ui32 >>=3D 8;
                        break;
--
2.41.0

