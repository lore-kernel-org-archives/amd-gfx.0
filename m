Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7592CED240
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 03:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760B310E146;
	Tue, 18 Nov 2025 03:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qSNzoQBw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011003.outbound.protection.outlook.com
 [40.93.194.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5607210E146
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 03:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYb0Bduh0zF/0IHDrJFSAwVuIGrabXy/d/0HRyJfP4viT0K6rUu8w9xjEDGHl1K+dXIkwTP/s6z93Mw2pIHc2PtdTln2NGZeYzJRWdO1yJOyWFz/7eeNc2bWMY/8c/BTgqc4niZAIQbwu20Z29fCDnsMie9g8WA+c7aKoN/bhrFkFlpB7FpPszqrEiPaOW9AH80zWP7hIXUcv07rC4cf0ldCniUTsFEt7Vx8XIr8rDbbgVUqt1856x08MAcLM+Q0Ox9XkxmE0TNCL4pZQ99ubpGEKdpPM6/geSkw9lg04Kp7fYkDJ+Q9LmSxuVgV5Yu05k1oXpwp/DhMzlrbj9l42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ+t+oBBboBdGR+iznSJCv09970yEKBqjKhjyIDHGMQ=;
 b=vLtlXTFQ/3deGETYZm9liFh2/WkJm2TqQQAvcTAxdxHOrYFhMLLp2Db4Upc0Zc62ur7L4ada7h8A83+esqgdoc4cY9zIawb2HO4dvH13xKTsDlTs42pdim/JI4HydRSHh1CTotKZ8B5E7N5D/IqVbKtPQ0hyX7aWB72mBnhN4vvlzp0PruFxn28yrI3yvq8Fw6XZHr3iznFEw//gPa/pYcrxQ1RudyaAgtnJlt39MEtZju3pea1Q8xDOl0k390IWQiavYg9rW8SMGiW00A5IYse122F2kHRRsSrZ+C0utwDKIKGRXqCtkAv4Z//YY3jMHXkdeXeuqRQVLCx/9yIvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ+t+oBBboBdGR+iznSJCv09970yEKBqjKhjyIDHGMQ=;
 b=qSNzoQBwl/MSPpnt4VwxyrDc84Z2dHAJl2LRXswfTZH8Bi4TiUK6IjAvrFWoRzFB/fPH3Z7QkbhCJp5RatryLt7USVgFKLCBRWY4sCb1jG0asdYXgdVZrV1zqNvp9hAWXYejuahTHSCNFsmhRbbUeh343RYKHH0UsGKg7oa1Zx4=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by SJ5PPFDDE56F72B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 03:35:36 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::6015:2417:2e27:dd79]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::6015:2417:2e27:dd79%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 03:35:35 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Li, Chong(Alan)" <Chong.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Li, Chong(Alan)"
 <Chong.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Topic: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
Thread-Index: AQHcV47yTR1J22ok6ESL2JCYgoUh/rT3xxuQ
Date: Tue, 18 Nov 2025 03:35:34 +0000
Message-ID: <DM4PR12MB50722BB6C318A22FBCDB33BAE1D6A@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
In-Reply-To: <20251117065323.3435034-1-chongli2@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-18T03:26:22.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|SJ5PPFDDE56F72B:EE_
x-ms-office365-filtering-correlation-id: b60012eb-46a7-4b88-f537-08de265388fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eMmpttziSKrkSOVBE5N13EDqRuJtY5K3M0Rqac0A640nZl/kMDAG0Ue+yakN?=
 =?us-ascii?Q?xKbsGLv+ub1ZV2tzwPWjcCxhwc8mHyzBQZt/mvuMUQqyBk1tYEXyLi6IkxoJ?=
 =?us-ascii?Q?+XMvW2TRdfpXlzx3Y43n3JUkqI8bSQ0ox36Fn2QDEU77p29GrOEQqmPqqjw4?=
 =?us-ascii?Q?WwgPidBl9RDDATXlPyreV1b3n4i9VoKBqPTxvsU1orAK+pUWDCsr8BAK/pw4?=
 =?us-ascii?Q?30KkFjLqSySxltIhiQKTGf9/1j9B61pXCKcJtJ2kz787dBBtPI+93NtCYNYG?=
 =?us-ascii?Q?f7eE+DxoCY1LYGNoD4HZQLH+1V9n/7y1JQwccyB+EJX+fZGgv66oNbqXwYyv?=
 =?us-ascii?Q?Kh88C55HmNOQpM3Cqq0swLnZaFfXSW+OZGr/1L/FMF8stNqEWXM9Wz4utXPv?=
 =?us-ascii?Q?+IBZ+HZW50TkNUfrAqfMQgIiRC4J+WesuBTHYAp6PsPgE/nCgt0OkxEzhiYT?=
 =?us-ascii?Q?5ASwukshYpLVpY3sMwqeTI1RzasHZmqudo0iloLBru8STfgFCEvY/Zh4bm4/?=
 =?us-ascii?Q?W94hGOsCii+pR1LViyQZ+4pLqD6aVnPzZDV9U7JTwXEXn1kvO6YyQhg6ZzBL?=
 =?us-ascii?Q?rGo9PQJdUXMOiunKmsBfIiS+tqbmesMmYTiik/12JKF5WMr78rxwOPwwpUmF?=
 =?us-ascii?Q?Ftrxp6dzkroXZ45ChSl22kYOS+b3E/e3S++aLzdpuGScqXxtlbjGJrTDEcLF?=
 =?us-ascii?Q?OUZ9RpGbZqXDvFfxbGLkQISIrW+AdIcFovEMSB/JulVQU12c75cclFvfQbum?=
 =?us-ascii?Q?DRkcFVDg2cdSuIpzmb/QjMfTLCQ6naGRgX+HPZ982elQZQ1ggGSjWSXb/syE?=
 =?us-ascii?Q?0FKc/82FDyWXmtUm0huje72wgTQxlldlYuyF8zXryTSEOrLOKpEUML0jC4/q?=
 =?us-ascii?Q?lvfvN/XBqAHdSYUxdV5ttUZc8N1W7zG+pU9lwzoIbcfF9MfrygeSSGLZrMz7?=
 =?us-ascii?Q?NsJD9pqcFrvQyl8DNOHYNv3z9QWR+oq6Llf3kbGrxOv9WRjO2KPG8moo42iP?=
 =?us-ascii?Q?um5o28SytRXroKr9MJgIdlTR5JyqXpfEAoU5ehjjIyQck60worHbcyU+I5EC?=
 =?us-ascii?Q?VAM10/C9V3pBlrANXRnq0FXQmm6kQrT7Yy1giVxGGFvHR4jrfV2n6g3K4v2N?=
 =?us-ascii?Q?ReGQfe138uPOzir5AP/3OYTirZKYbd4/3nf7X0HTMA9qHpLXSb2wy9tfYbVF?=
 =?us-ascii?Q?jzeikdpk2HyNZD6m5swm9MkNUbnVXJrC51PdTOSyR7U7pokC3SdWMMrKLdNn?=
 =?us-ascii?Q?Dzu92N/AYWSZ254NtU0+IUFXYykLmLS4HEXLItHfzLsHGQeWq6M9blj46Xv/?=
 =?us-ascii?Q?5EIIRadb4goiY1kkRfZHukx8USzKJp8/0xtB7w/Yy6x0KYaY+Qhgw6fg908W?=
 =?us-ascii?Q?kJHYvExUAcAIIKPkWbqRH2PcRL6FbTAc0jmXCtzZoQLfoMw9oGLrvr5wyzrF?=
 =?us-ascii?Q?ScxHvswtJL5BVnxiQo6NOeobj8ssxVSUfgemg63JX9sksWy9ZwH2fRH7wk/i?=
 =?us-ascii?Q?kp8b6lXxXYXZiZcLpI0o4EUsV5BQs+hOrHNq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MyELbnXDT7zk0UJq1zVMfdNddQ9gbihEVDgCU/k2EIrcd3vMOjXZrHEN3Tbo?=
 =?us-ascii?Q?DFSqo1UT7oc3XZoktslE3FHPu2KgwwHq2lmQVUFvkl/JOTSTaiZWAP3WgaIj?=
 =?us-ascii?Q?O2tnJs2Y01JIlMfAMyplmneIUGgmsTO+tOwFHG+ow2nsWjDghdi5CchbpzKB?=
 =?us-ascii?Q?xKXgrBPpKNghTCPqivpq5pQvxXPUm6OPF0FArkhLvhAsXg8kdupqU6J9+2ly?=
 =?us-ascii?Q?6GVfI4D/00GvAcCMWYCjVQaMdXTanbdf5mi7UcWdVlPSRw53SCLzTdhFz04N?=
 =?us-ascii?Q?asPSuuo3EVUNCqBa3MdrKcU1KkjFRwEvBwPNQwcFLOk6lf3uGLtC8Lm9yxd/?=
 =?us-ascii?Q?Y4WS/69m6cTm6xyewB9Ta5fg/Uw0NLoo/Y1+29ayxY87s9OGcht22RV4NY1l?=
 =?us-ascii?Q?ZGaJBYLq7RZEhc6Q2knKtAGIhN766yxHrEGiFjIm2l5ak0YstzYtKeNkV+mU?=
 =?us-ascii?Q?WFcbt0C42jGpanh90U5kBKeQpYD9HuDUIH/vGhHPcN6raDaQLZRHyZplDF7D?=
 =?us-ascii?Q?MBiQBEiZyo1cRSX04MOAPgTDFU3bdHky+J7CA+mKGDMw+EXpjYEB6GkLjgaj?=
 =?us-ascii?Q?NODP1qB0ZSONxNVTVWUE/1pFdJDnNrg0MmPYhTsgg2a/PNa/ZeI+0jLPjsD8?=
 =?us-ascii?Q?s9lY9WCO6kmHUfNufzcjfJ/9dvq2l9kKWEuAGRlzqAI0O/U7W4MmleGLG/RG?=
 =?us-ascii?Q?s01PNbjkKruiyjem7siYU/HaHloadZ79QsrHlkF2EAvf0juMxenTUbCOxuwM?=
 =?us-ascii?Q?hfqhLyY3BS8dJbMh/FzAopFTTyOQzZihqkBKchBPKoyC00/lK4XS/ZQl+/8x?=
 =?us-ascii?Q?lMCS0PAOlGAlbaNubqyOerW07Y6tkfXhdoEOABfLYAEk7aHvLizkFX1p1z7Q?=
 =?us-ascii?Q?CbwFBzgK443pAWp4CD95uK7BwQna1dLUCciyt4ueqrn4oLKAGL3Yu/Pukv+r?=
 =?us-ascii?Q?uGkqC3xJAhfqzpanJVodxHc8DDWy6dyBs7uLYYMOEnXlwR3ZObiwxd7KKlOn?=
 =?us-ascii?Q?qNuIam0+v7UIcQdgA7kTYRdC/fcw+54bg5bvILsdGG9R/oPxcn+WAWyEIs9D?=
 =?us-ascii?Q?ssxQv+IsbR7vihqwWbHkDatzWRizoxeFLytQUTvpNyIduJn5GMZZfh0WQvRm?=
 =?us-ascii?Q?ucoKpc1OSPAkI4krmU4jCpsji/jULifQTyEjxmzYgGkHl9Nr/6y6HEXot4zq?=
 =?us-ascii?Q?lS+cR/L4a2cBcHT/uUScO71fefbRvqEz2wB6lboY6rS+nHGMwFH+BD/2X647?=
 =?us-ascii?Q?AzZ63w4PWAzIEHbucvy3/g8vV3J/Mmntdt/wyvcWxURjVfYCWQjV2V+CQrwP?=
 =?us-ascii?Q?SonlAglY2mOqzVnIw2AzK1WGXstqJIVMgwOStK+PR0noobZ1a3NMGinvc8Vo?=
 =?us-ascii?Q?G9AJ306r5GN1Xt4Toin0ZhOJAmTm6CZ/W0U3lWcwr2omNh8YxCH1bAwnklnH?=
 =?us-ascii?Q?gBWZ9vRrAcVZIJdjVaqS9+zg6VPJYCyGS2sFjrUZ394b29/68sUibezRDAuu?=
 =?us-ascii?Q?q7iKQxsU5/EaIU1Wa4eQWXKw1FBi9KlPZ4gQ+rX5a14yZ6/3gllEydA0LJ/e?=
 =?us-ascii?Q?opwvtb4Qwv1p4D113o4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60012eb-46a7-4b88-f537-08de265388fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 03:35:35.5002 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPhKHpUTVi1SRNNukMk0Z/CybzqoM6afdgis3vRowm3Dex+6uqD9kIxUSiWOgsJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDDE56F72B
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

Some gramma comments.

After that, it is Reviewed-by: Horace Chen <horace.chen@amd.com>

Thanks & Regards,
Horace.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of chong li
Sent: Monday, November 17, 2025 2:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Li, Chong(Alan) <Chong.Li=
@amd.com>
Subject: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout i=
s not enough for sdma job

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 69c29f47212d..4ab755eb5ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(s=
truct amdgpu_device *adev)
        int index =3D 0;
        long timeout;
        int ret =3D 0;
+       long timeout_default;

-       /* By default timeout for all queues is 2 sec */
+       if (amdgpu_sriov_vf(adev))
+               timeout_default =3D msecs_to_jiffies(10000);
+       else
+               timeout_default =3D msecs_to_jiffies(2000);
+       /* By default timeout for all queues is 10 sec in sriov, 2 sec not =
in sriov*/

HC: Better to use "2sec in non-sriov"

Regards,
Horace Chen

        adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_timeout =
=3D
-               adev->video_timeout =3D msecs_to_jiffies(2000);
+               adev->video_timeout =3D timeout_default;

        if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
                return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index f508c1a9fa2c..43bdd6c1bec2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_sv=
m_default_granularity, uint
  * [GFX,Compute,SDMA,Video] to set individual timeouts.
  * Negative values mean infinity.
  *
- * By default(with no lockup_timeout settings), the timeout for all queues=
 is 2000.
+ * By default(with no lockup_timeout settings), the timeout for all queues=
 is 10000 in sriov, 2000 not in sriov.

HC: Better to use "2000 in non-sriov"

Regards,
Horace Chen

  */
 MODULE_PARM_DESC(lockup_timeout,
-                "GPU lockup timeout in ms (default: 2000. 0: keep default =
value. negative: infinity timeout), format: [single value for all] or [GFX,=
Compute,SDMA,Video].");
+                "GPU lockup timeout in ms (default: 10000 in sriov, 2000 n=
ot in sriov. 0: keep default value. negative: infinity timeout), format: [s=
ingle value for all] or [GFX,Compute,SDMA,Video].");

HC: Better to use "2000 in non-sriov"

Regards,
Horace Chen

 module_param_string(lockup_timeout, amdgpu_lockup_timeout,
                    sizeof(amdgpu_lockup_timeout), 0444);

--
2.48.1

