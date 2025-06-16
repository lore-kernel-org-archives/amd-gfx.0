Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09492C71136
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 10:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7C310E326;
	Mon, 16 Jun 2025 10:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jNKTQuGO";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA1110E326
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 10:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucIKFp0PxZeNzoJ126Cqw51bvdvvsrdylIoxvkzor+WlTnV1qNHSIEZoFe8BduiysL7eQXMBBwcfZJ7OX0q0O3RLZz85lvQ2iumkJZL1JmcVqjwpmnQIExY9cbJ6MrcMLtY5fG00EcoNI6gXwXHFum5Awl96fAiSuG24Rw+/dd5rdN43aGtcfHj6kyiCV7nPqxYE++zTNQ+ikD42rJM2vqUJ1WaR326BB8EHtBQ2HTKdncWi5Fx2Yj+NgaKwqDQy6o7KPaniJYhkZ6QumXTq57hXRgaAlqwz3Vo7XYhqd4j33PKlFTynQgkYEZ0ps5WJ5Bv9i6QhREJvGl2BGfjh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYzoLFgyZHGN54zQRpfrdepjHkXdYaoG5/qQZ4TKhAY=;
 b=miLFOogIYRxjRku+wcf0YKUxClLmMUffLPphYQQgzEI0fBWQInltrxMoGgjEXLpkp+dVvhK5JVWjr3WdraDIWTncBjeKJao/iLSUOIPH96UtrUiFe93I2dBCRw4UkTO5/fT56OkvmFOmSktJUThu8/L15t36AggQ/SNWJHf1z6Jwig+S6X46REiz4er/WugrI98/4xyTI/U0pRIxmGfvWnf6s14YAc1Wn6hyIZv9rg20EjwPldPKMxIGc0IG7WcffHP2dWirt/P8iEpSm+s5OJBrxZ9DnQorSXqAwkQr/hRLN8NgDlTZXMHd+L5ckl+d2ERDNJJYAjR4YIw+duSwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYzoLFgyZHGN54zQRpfrdepjHkXdYaoG5/qQZ4TKhAY=;
 b=jNKTQuGO1A5xtLoTO9YVsRML7LY1VW36tDQlLcpqcWdDmJz1ALoUM8HB+CX2lQXPjJdQK1wltu9nTQVTmEhC+xVz0R0kuZsnppsOEwc4P/eHb5xJR2NpW4CeMJmJRbtcww9rnW/WGmuaS9CoxHD6uEc9oyWu38UzuHsD56Mc+Lw=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 10:40:50 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%4]) with mapi id 15.20.8835.026; Mon, 16 Jun 2025
 10:40:50 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/4] drm/amdgpu: Deprecate xgmi_link_speed enum
Thread-Topic: [PATCH 1/4] drm/amdgpu: Deprecate xgmi_link_speed enum
Thread-Index: AQHb3ot76GT4GDVQN02dE823voS8NLQFmIyg
Date: Mon, 16 Jun 2025 10:40:50 +0000
Message-ID: <DS7PR12MB6071B1B87445E8E81862F2648E70A@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20250616065400.868818-1-lijo.lazar@amd.com>
In-Reply-To: <20250616065400.868818-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-16T10:38:38.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|CY8PR12MB7708:EE_
x-ms-office365-filtering-correlation-id: 4dd07761-4403-4ba9-545c-08ddacc2432d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3WxHBWCxedO191e9Q8gf7nrUlYU+ODd3YTLjYaYlWHX6CA6bWViAx6GhAC7g?=
 =?us-ascii?Q?+9y67MXpWSbiddXpF6SZfdp0OO5c8ZchDdlOtCKkrJMeEZWheU2RUeBZHDKV?=
 =?us-ascii?Q?kCAz1hKQSzalnDsQP6Xty/bq5gYHJTEmU5qm9IO9uvZAyzJfgLQhMs+TeBgj?=
 =?us-ascii?Q?8fn/cGA5CRHEigaRsa5bebUXOTcA5VzUBJZaxU1WSe+YHI49lVs19f2/O38Q?=
 =?us-ascii?Q?Cz4FpzM0oNveyfooJC6EQ17gWbavxv8hPHe7TFDkEKcOXEUPJx/5sQTqh/XQ?=
 =?us-ascii?Q?TtvllAItcPaREsZ9WPLq6lPFUA7DdJ7SrNDf/VPCJdp2LHhCORvvAR7mz6pv?=
 =?us-ascii?Q?xY+7r/GspKtrPM44npLtfUdzDrYFV6650oSOjVFYkJ3evgRTXglRKGy3PWMo?=
 =?us-ascii?Q?Au4MAXs3gHi8D6cD/7j7/x7oEQQvqqVcsEC25ecgpxNHFuzYu685n8cAAHAV?=
 =?us-ascii?Q?WDts0G8GE+VYdE8W9/b28gDQHJmEf9facmklYUAWMnrkHLanpZqaEqxzAg2v?=
 =?us-ascii?Q?5lT0RSsVAhYumDXvAHuSA4a5VQhRO2X1DwKlAIsHVIgTAzIgFR233msSuwVA?=
 =?us-ascii?Q?2+ZTzC0VNsvu+/WJHjzq7ZarIwrIHta+dFebcom/YHAVSgcOgcfGACcgVeCL?=
 =?us-ascii?Q?QsUowKHtgX5LlBSS7hlfjNg9eo3lkwthnXVR4m2kAonuoZzipUS8147EUW9x?=
 =?us-ascii?Q?owipUesFBDe63LHxZHiQ577vlFhIyY2FrL3Kz6ialiXYsFihzArnWz3GPfNc?=
 =?us-ascii?Q?DwfzvA6K8aPhZOGWReC9zbwR2nXEo7s97FWjuh7X8F4oRgeCIIuVC1t1Em1V?=
 =?us-ascii?Q?dUE5h5VBLLOK+f4eZbgF+zKxQBpDSF7OwEWJ+UkgDFDkPYzZ2v55/7ROdwkj?=
 =?us-ascii?Q?eU0WoxWdvQmIJ7g3NmaK0QOYZGCeLDriZyG5DxgiwbXCIHFXTFO3mgCd2SyK?=
 =?us-ascii?Q?MeyI9FLEKy/Ixf417+ejmF54kJ6JusHI3bdCKnsfbMymVDlTx6qhHVkGM8kZ?=
 =?us-ascii?Q?H9s7WJIEF/oN8YZKHxHw4HEYc6Zdi+VNsgMN/LVu+XkLCRu7jGGr+qgZzhfD?=
 =?us-ascii?Q?qfwS5P04LbsYyjgePHvbj34KYVz8caqnU+WiWvw+VFe/wVmFw/i7oV2QYW9Y?=
 =?us-ascii?Q?9v8W4tbczXd8EcocCt8EJRZmvNO830uXVaCktCJihv9uzEIlH1W1j6ivmaKK?=
 =?us-ascii?Q?HlcPQOO17/lsBUPvv1WAk0dyfTx2JZOMYxNba3TWGzYVILfk7vZ53jLXsksw?=
 =?us-ascii?Q?zt693Xh4jRt+/5rieiXktZJnXDFHWR+ZJMWe0f+rMEGXrIyRHUTk0pIhq9ul?=
 =?us-ascii?Q?ch09AlQsn1QUwCnWZ/IUJaKDWGeo+TjfqaImUGeYuDEAsbkdCB7x08R5nKDB?=
 =?us-ascii?Q?ZFzW+1ES5+RmP+VVtngLjfwhLIpYkVXdxLB4jv/swIaKU/3GiYHZa2OmRMHB?=
 =?us-ascii?Q?OK+WP5BX7ePPlDWDL0grWn/q9/tqfbSV13RT4l7AINRkigb5qDuZWd3A9v4o?=
 =?us-ascii?Q?ol6U93A8NeZqYsE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xJ9C5LmxFTqKEN4wqBw1r3iY1dBipD8nmoMpuVZeOM0EIy5AZeJMxA1jFmXI?=
 =?us-ascii?Q?jtTgUUXBC33Qr2b0INewROe/4sfTZrghtcwKlimSjOSGNvbcdTz2pSFR7anl?=
 =?us-ascii?Q?Dm9zFZVLqKe6rze68noW+i+L++TEU5TQlIADSccEGyt6j11UIblqhrCIwuB+?=
 =?us-ascii?Q?wHktmSgooJauxyRCfvwLviNkAoR0i7A+tVz26jDiLaa1K1vyuRYhHvkYYNZy?=
 =?us-ascii?Q?OsaDg1ckFfaZ2kAMmJRQoUeLVRKVMSA7N+k20zTy8vVyadmElba2mv6et7FE?=
 =?us-ascii?Q?lpKPKpxtg8i8eikEeNleg0DvFX+YKW9wmM6LqdCgy9rfEjmjnibZVP7vlzjS?=
 =?us-ascii?Q?TAwyAJW0g/rjXiU9rs01pvD+uVEJjqKSjs/7Rd9ZXeq1q4HmALnHxJInwRyp?=
 =?us-ascii?Q?7risrbPnUttT4z3AGppfuQMD3AQ7C73yVPEtYpoFE6d9kK8RIKhXQZOgBFqm?=
 =?us-ascii?Q?9607ZVFfn/cSV8HYahLtrwQ8uLslCYdlBpLSEV7il3EBTCv8c2b8WDNyW5XY?=
 =?us-ascii?Q?ax9SeiliNSLRaLgfsm3EK595eUvfyrKUSjxJBxcO7sulaY+QkQF8GH08kP8U?=
 =?us-ascii?Q?MYf5Oxi5FDRPoGlKgU3eQCXcbgW2PP5/aPZrxb4kQmBQi0Hns3+DiQP8kyht?=
 =?us-ascii?Q?JMBjSCCFPwAuhHRa2e/k8XmcttF3HSBhI3bQBTyfLp58X4Lhp99NqRpLw/Pi?=
 =?us-ascii?Q?kDzjU/T/2gxSJqmnHrjro+YhN5ksgb2MsFtmyjOKFJb2Y3r41N4PO6k6eXNT?=
 =?us-ascii?Q?RZxQhapf554wQf4qDzBTIFPHmF46x5KSsrSGt8wF3xbsitQRDLhtqLm+NmhN?=
 =?us-ascii?Q?X08x1FcKPr1fyC1uZ/nc1DWRlKzeCdn9tgad4/eNE+BNFToCxpaEy8vNSGGq?=
 =?us-ascii?Q?z9hg9f3/wVWrnDf6Fl2IAR6Mps01UrM3inuUYSTEAkVFuTLCRZznFMwEPe5j?=
 =?us-ascii?Q?RhW1PRLdiZ3L2eu0nF9NaQ5pS3dCCOE3tdqBgvPQf29toGLSVhp/kLAXBxgP?=
 =?us-ascii?Q?LPmpdmNv48H9TDT4m/0VuCX/UtMU/iMZ64Mz5vwLCM/GhX5JT52ASQcBhGma?=
 =?us-ascii?Q?aXK7OtId61fRaOhqe4Pe5WHlW6OAthhb6Wp31HAJ++ooMBSMxRNdblxHWqAi?=
 =?us-ascii?Q?pkz2OGWhdyznA5o3Dr/ojaRYFYid2Uj9YtjYhM9z1dhX08U5NQdA2uIAECxy?=
 =?us-ascii?Q?MwwcVCSi6ndYhSxdvnRggxQPHC2k2hPLduYrOTaPtxGTJ3a/GkotiXY7AZlY?=
 =?us-ascii?Q?+wo+H4Asw7RrvEtgprl+H5yX/6OfDuwvwn9T5j0oGYB4UWK8Hs5JKVcYIebp?=
 =?us-ascii?Q?E0eiD/jokOw5rEd/BAu4vgkDhZjn5SgvgDfcyqdJIAIbXG4zFgCbOt7hr8jB?=
 =?us-ascii?Q?u/H5z6kSo7BMfsovlK+dgUR0kdTJXqdTBq1m23nQbBxob36s9GiZUrt5amnu?=
 =?us-ascii?Q?PV/7DAkcbNPOx8VlBIl8Qs8WToG6WXEGlsFoFzIcMDMWn42CG5v3MqIEqFgq?=
 =?us-ascii?Q?ssuAIEc9gfCLnNkc+IF8NEfcbmAxpa99QStiMk0jUwVihppQDlNwschvTAqn?=
 =?us-ascii?Q?jV+CRZISHGOCgodaP7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd07761-4403-4ba9-545c-08ddacc2432d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 10:40:50.6648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75Py+i7KjIKz76SFz1QZjTdus9fbpwjTy/KTZ3aO8NUHdeRhCGGBel2ee1m6oqk1bGEygkRX7J27NNGclaAfAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, June 16, 2025 12:24 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Deprecate xgmi_link_speed enum

xgmi doesn't have discrete max speeds defined. Speed numbers can be arbitra=
ry based on SOC. Deprecate the enum.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 ++++--  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_xgmi.h | 8 +-------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.c
index d9ad37711c3e..6f9997198518 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1771,13 +1771,15 @@ void amdgpu_xgmi_early_init(struct amdgpu_device *a=
dev)
        case IP_VERSION(9, 4, 0):
        case IP_VERSION(9, 4, 1):
        case IP_VERSION(9, 4, 2):
-               adev->gmc.xgmi.max_speed =3D XGMI_SPEED_25GT;
+               /* 25 GT/s */
+               adev->gmc.xgmi.max_speed =3D 25;
                adev->gmc.xgmi.max_width =3D 16;
                break;
        case IP_VERSION(9, 4, 3):
        case IP_VERSION(9, 4, 4):
        case IP_VERSION(9, 5, 0):
-               adev->gmc.xgmi.max_speed =3D XGMI_SPEED_32GT;
+               /* 32 GT/s */
+               adev->gmc.xgmi.max_speed =3D 32;
                adev->gmc.xgmi.max_width =3D 16;
                break;
        default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_xgmi.h
index f994be985f42..433d94f52ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -25,12 +25,6 @@
 #include <drm/task_barrier.h>
 #include "amdgpu_ras.h"

-enum amdgpu_xgmi_link_speed {
-       XGMI_SPEED_16GT =3D 16,
-       XGMI_SPEED_25GT =3D 25,
-       XGMI_SPEED_32GT =3D 32
-};
-
 struct amdgpu_hive_info {
        struct kobject kobj;
        uint64_t hive_id;
@@ -97,7 +91,7 @@ struct amdgpu_xgmi {
        struct ras_common_if *ras_if;
        bool connected_to_cpu;
        struct amdgpu_xgmi_ras *ras;
-       enum amdgpu_xgmi_link_speed max_speed;
+       uint16_t max_speed;
        uint8_t max_width;
 };

--
2.25.1

