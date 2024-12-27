Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88318E7718B
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 19:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11CE110E27E;
	Fri, 27 Dec 2024 19:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6n4r+0U";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C3110E27E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 19:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaKeM5Sh6MOvgMz4HYGEjGJ+q32TfPwerhzEwwYSbiDv3uyvLKCZwcrY2XqUDblVUaK+cVZVlroSqwYTclbImUvQb3/mYaXtCvTdkjnw6SvHbbry8Xc3vzvdQBcvXCvMrbWgcdQ+KN4lx4uMvdAosmQ8vJWnxfl+Lt7/5yq/n+0iV2DmIl+HMQtGy2YuLgGNH04c68AoR6wDh6wB8cr/nZCCRHTfUZsgKFyRIdySLeSHqGe3RTmaXQZu3s5/eVmNYyarzmnAcW2w7NDt+zVG9f3N84c5oeq1vDnqsidwlpHbvKaKOLcrA6F/Et0DQ8Z4lVsKOaGL0K/BK8wlpZWyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVFd7DWOkmzsNZl/LfS7tEYq+uYJ/YSw8xh3hJpx1Cg=;
 b=sGRqtrepxC21sB9Y4Fkkl3176LAxIwszFebL1C6UlXgKKXNcECKSkfHuX9F5zQUy/TWjfYuZSjayRjhsrG0/GvlmoV3qVLWl+UJ8hl0Zj3KJOQL9BSleMuIshRawwFZvO9H7UaM/eAT8n1mvqdme5rju0UVIyZMoRRGUF1C00gIi540a6Zm4/8/OCDZ6RHx5jy53a9bcCvBdcyEWrXpevvdnBcoXOqKtW6J4UKxL4aa+wjsZiDGfAahpBd3roN8zvu5C33trqh8g4BdXJgSuqEahEtwMgb4RHwydb1/Gd1Zfb0hfII/cZfaVCfAOoA8ICIlfNAnUHvT1p4I4P/vDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVFd7DWOkmzsNZl/LfS7tEYq+uYJ/YSw8xh3hJpx1Cg=;
 b=x6n4r+0UkatgE1kJPvMBneIJgyMYTWB366boX7/Q3ND+i4ZRQKmsTLY4eL5CTloyh7KKW0WnoTY1ThM4BQ0Z5cLL+VJxcMhDNUhrhTy3NbcSvoG6Z3CwKd4p+nxP37H3hMBHMWXVzCWG183NrtTuaunWoO9SgZSnAqunVqjTlPU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 19:29:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 19:29:53 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Feng, Yuan" <Yuan.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Yuan" <Yuan.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Thread-Topic: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF
Thread-Index: AQHbWIcAnhshrduPM0OjX9s1/ajxs7L6ekVw
Date: Fri, 27 Dec 2024 19:29:53 +0000
Message-ID: <BN9PR12MB5257D4C6C8CE71B3EDBFF35AFC0E2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241227174410.5405-1-yfeng1@amd.com>
In-Reply-To: <20241227174410.5405-1-yfeng1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c0eb087a-aac0-4a12-8a62-267445198387;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-27T19:29:35Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA1PR12MB7149:EE_
x-ms-office365-filtering-correlation-id: 80c9448d-f36b-4f77-8526-08dd26acd6ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?q64em4kbWS6ruBzyo1bq50E0Xyz3KTTQOXL0GCSJNkNQddWyveJvIirkU08I?=
 =?us-ascii?Q?ZxKHP5FATgKMOIj+MCIsWUZiittKEo80ApDtRaMKj0a0NRV4sq0WFjxmhwts?=
 =?us-ascii?Q?TrnFDq1ES3K0v2d34eZiX5PjUKQRIy56LI0Ac8DG0+SMhCed2mpQPTqNUTKz?=
 =?us-ascii?Q?vvRh5c2kHEUNAg7NDhSmrzxXEG+QEweSXHW5Ujht5WYZGe8VNXykRN6qp1wh?=
 =?us-ascii?Q?UI0mJqgvbCuakHJhObHdceBtzvUOI5W/pstr3g/grLOUXxHSSoGt64K6ylK2?=
 =?us-ascii?Q?KoMcGoH2Z6aFhgQaz+ZAIRlzp8+lzV6RGws3mk1G0gvIl4SEp9U/KI9G/9mq?=
 =?us-ascii?Q?C5v2wP8ek97YOAmPzJdTk/7b5BwZStrxBPYbkDiVaAx+hfXYcdOZMacrfUg4?=
 =?us-ascii?Q?ObMvTKAd9z/QF8wjjmaI2lYnw79LByADp6au2bkJRb/CavaS/nsfxnJPuOwC?=
 =?us-ascii?Q?q3WA50P0gRGh5Yv2iKhc5gYsDkt+hJqu3i7lAcwxMofp1vxVC7utYsZOCEDa?=
 =?us-ascii?Q?xa4zqPtHQIp52MUWld+KGTY6U0ETZww09kCxk2Q35MBH3sIYlPoIqoKdqXXq?=
 =?us-ascii?Q?ikYFmJhLZko5Bi44LS1JVzj1+uPQQJ/24LWjZ8rLhgrCV8ldh87Ejw+4mQV0?=
 =?us-ascii?Q?H6iri07jaV0ZhElkMHw7tA3SnPVP2ZZ9Q6N1BFFDnfrQhZQpmTsZ0Sfk5hlO?=
 =?us-ascii?Q?RJV2ybzW+FYKIni3YFORUxsDhurzT/9mNCS/2len6IXMYtWjE7hjdPrnOp1S?=
 =?us-ascii?Q?yNJ8f/pqLQkFqcmVzHYkgiXZfYmPqNvAy/77ouRNJL9Tm/o/xGWzZ0HK3srs?=
 =?us-ascii?Q?v79GLvUh5mUuAF/j+f/azPDG/UddmyoMXXwc3Jw+K/bmhGto/HNxBbwWevJh?=
 =?us-ascii?Q?Qi3thi6slaLMqmDxs2EeLs4QoHe33oqawwntei8A+E6c+DeIML1q9EUkqKlB?=
 =?us-ascii?Q?wWt7giWGhCSHk+4DKrektG3icHSYoBQ4rkEFsE8MfYtx4Sw/RTS236QiSw+S?=
 =?us-ascii?Q?CScemRQvgmH6FcmP7uzarYVcgJPfdevPj90jwWr29PnPH8aYkkxdVZSTt0V1?=
 =?us-ascii?Q?AmyTTDN3N/m9xv2ZkTeWxoRE26YPyYiejL02NpBIF/JvHCOJghSZYggN5T6u?=
 =?us-ascii?Q?7ZCPT2BqZFvScdAzc7y3qD+ng3br7y9V03ZU41fWM3SiCs1ysOfTiE7eTrOk?=
 =?us-ascii?Q?1iSrCJ1EaI/Qo9pTSPFgUcJuZ541y93e7RAbpoXRNztGA4qJ51ZMYSwJSQR5?=
 =?us-ascii?Q?G+pePxLLuBqcH0RM4Xrva6o1DyjYztmc0uSbL1w0y/m+aOh7iJM9KgeT4OUy?=
 =?us-ascii?Q?HVsDrPmygjiFztI8znrq11BNgMKQHnxg7bF3hp1U2663OjicQqbY2DI+X3cm?=
 =?us-ascii?Q?jdRRP9m9ADw3uCCffQ33H2YQ0H/oULnkmTAEWmqF8ydW1YhuKZ+Sl1Vx5l8V?=
 =?us-ascii?Q?rBveoxf/TT/IUfMBqR5DgvZrXd/YJkwF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N4IrwKNHT6/VZg926sn+XzP/neYYJyKAHieeJ8hOOvZ5vsaAO3x9dNG6YidV?=
 =?us-ascii?Q?A690ouoBESK9Cmo62WXaGPEr9gLd+KLBmy51EMsiuuniAeyzCBDSCjLSJZ+H?=
 =?us-ascii?Q?FXfbGw4iaeYi+9Ba9AeaKU8W1CQE7ct8iUs5Rf9U8pnKQRI+8n+NUGhHKg2c?=
 =?us-ascii?Q?hTng/3jLrvRUTPrg0LR/YA4lrhD5i4gGejaU+QyXWscFb4kUckIc1Zgn8qmV?=
 =?us-ascii?Q?9X3FljtCLv60zN2pWcCT/WGE9zJO6HIOsLiWfX6CbcejB/dFl5Yg2wsPuJaL?=
 =?us-ascii?Q?IVSjRao7Zg1alyQCmXsFTD/sK8u9R0GUKpkTSgpxMywTLX8CuKNdRXaNmyCX?=
 =?us-ascii?Q?yDN743qX4afzLneqDed56DnX9jY+E065JQzLczHA4tJYcq6uoUwetI+GBbZo?=
 =?us-ascii?Q?9WSBf0kaqIUH+koUn4NZwSpiuVMuCEf+NXF+qW50FJGc9Vf2cuSqfYa2x8Sg?=
 =?us-ascii?Q?1fZtiBvBqYm/5Fb0q6ASM52O9coSRm0JsQTgDABE/vXUicYCGfnm07drWbCa?=
 =?us-ascii?Q?OpAe67aDkXpw+XulMJnlTcL3MfRTX8qK4NPOxIP4WjuYIpfw6zWuN/lfsvXj?=
 =?us-ascii?Q?w4kTTi5JIMHkwd0Mpn1UlJ00eHOhlPa6fU2Hfc0cuzn0sB7P4YmRZ8bo/o46?=
 =?us-ascii?Q?Z1oG+4uDt/8/qpBlEEib3kL2ARynXeetL6/6GAA0vQc1RVo+mbKnfDq4MpKu?=
 =?us-ascii?Q?Ea2S19QOK3n7d2LB3tlOWqVrUJiXxIWkv75QHvLag80rZ0w3pIJPysCq3ZIe?=
 =?us-ascii?Q?CZGpD4POlkCbEsZj9CmIQxBevU8sOCjgx2ZRYnkJt+5oSc4ZPVfpZABO3syL?=
 =?us-ascii?Q?CkjG2/UjeJegPj1g/+Yxazr2VUpOKk5iub8k5YbvgeVcC1t5oMf4KsQtc33k?=
 =?us-ascii?Q?QHZ2Dy7dajqDRu5H2ZF+LYr/Nz2cvIFhsWMwKpsLrYV20qZdeHloz8MQlN/s?=
 =?us-ascii?Q?M6vq98xRDMumVSvRQagPOVkf3Wblzpxc1K/POSRdH6dI/gV3sxKmoBGp9iVF?=
 =?us-ascii?Q?epou2aRfPFxEaQw7Y/u88NpesQPSXwq37oc05LDosy/MEAQVYccImiDFFsmd?=
 =?us-ascii?Q?J9QODpY8VDlspSkwfrKe9RFrQTXPSbd/ANJiaE7UYFZj76sF6PvLYAlt17EI?=
 =?us-ascii?Q?JmGuaSYAht6Cvdab5jIagsS2wysPJgJmVhBuHSfKoYJDnNBpez2mTt9i07Z0?=
 =?us-ascii?Q?amJ6SXf16LGFIt73Y2ajelj2Ghy/3fd0kAFPDivdZVXG/HaSq0x0y/nGesVE?=
 =?us-ascii?Q?/LVmfCAMFWHGEchji7HS4A1D7JSWsLWUesiv6u2BQsL9Gqcbts4xCvHDc9Pa?=
 =?us-ascii?Q?1jz0Zl341k3g53Au0MfH0jnRJFoSutBs1EYSQEdXrur0aDey5hgbCZrv83GN?=
 =?us-ascii?Q?i/pzYF/c/4pbNq7mmw7ufZ19Q8IbuRqhSWIkxfVx7rIBGawZy+Klqi5Nf0FA?=
 =?us-ascii?Q?1QKeuigicaBIv+SzJ9WENLOPTKEpiGc7qp5IscjDAiKK/6ZxbhVqothHDS5p?=
 =?us-ascii?Q?hcXiOU5gtJl4Zs46GWFTqQHMqld8pIsk5mYeXb6pKnsVHjsiFW2ph9Sj3Oqf?=
 =?us-ascii?Q?1HjnPx5PJB2u8HAS+Yk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c9448d-f36b-4f77-8526-08dd26acd6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2024 19:29:53.4060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AMCfLbJeW+Pzm6YzAlzOC30FJsK9hgVhTxiNBa739b9SQbVDmqw8g4M5X6mOJMJKcB1IYURXA5chE8S+ykheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yuan Fen=
g
Sent: Friday, December 27, 2024 12:44
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Yuan <Yuan.Feng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix for MEC SJT FW Load Fail on VF

From: yfeng1 <yfeng1@amd.com>

Users might switch to ROCM build does not include MEC SJT FW and driver nee=
ds to consider this case.w

Signed-off-by: yfeng1 <yfeng1@amd.com>
Change-Id: I6803818450bcfcc9d912c80ad351824be7a9694c
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index a5bdcaf7a081..2ba185875baa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -579,11 +579,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struc=
t amdgpu_device *adev,  {
        int err;

-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev)) {
                err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
                                           AMDGPU_UCODE_REQUIRED,
                                           "amdgpu/%s_sjt_mec.bin", chip_na=
me);
-       else
+
+               if (err)
+                       err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_f=
w,
+                                                       AMDGPU_UCODE_REQUIR=
ED,
+                                                       "amdgpu/%s_mec.bin"=
, chip_name);
+       } else
                err =3D amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
                                           AMDGPU_UCODE_REQUIRED,
                                           "amdgpu/%s_mec.bin", chip_name);
--
2.34.1

