Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5117C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 03:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF1E10E07C;
	Wed, 15 May 2024 03:58:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3SDMIfn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163F410E07C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 03:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jfu6El0KtNb4OGG7HAlBmd2c1JUch4pJH4yNk9MPhczgsV/q6R1LzTJX50W5+uWJcwe7jlOC4bSnYB55a0yqAC3Oc2LsJ5nHMT4M52+h6JtfQpR5hO3L5XIdrfF640v2b5CC3Es0qv6Z88uPXte/VJsm0Ql9jmbEYGnjW1SsAkGZJNgRVym+SmY0X3nOAMF5j+MmvV0IOHSTYRzoRbqQsA214fxg7Ng48gQumZIpXaUnG6ngE4MoKWV4Wn3F4ivrUN7+c7BMPowu9ZTNtDrqthVibufAT8Wbmw+wfzrPUsFSkhFCX3wdQ3+YqwhzevYiN//iG+Oc7PEzW2MYwn3JDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05ldyNq7HWgJURJtYbFZyIh5G5hvHaWrmwNU2SX/hNY=;
 b=oU0w6lCbiNRnu2cTk4A5DUdc4Q81QwV70r2VOj802Z9J1NOfSN0jxAr/CZOOwyx1Hy0FEO8Tm70uaKLtTLYzqvco/0JA4OFkTWw3hpjjAuL2jS/mjnq8bjFP0cAkMcLH6jEA66x7kF4lIeHEEGd3gqyztlH/b2OPB7MI4karBr1Z+GWAOtkBVCWMfVTVP+QttduTsr2VnaWeBZXNTtWJfpOZ84gAQAHOCDxAbWZtt6A+S9UAbpm2K8j/lTtAMIqq3JWTkP+8sR2KoyjW4aH4TbGe+Xy1iEWgKn8bgENo/1YGGXBqD3Pvp2+UbP+5zSgP31HHPw7o3LGT4N7u5ZIpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05ldyNq7HWgJURJtYbFZyIh5G5hvHaWrmwNU2SX/hNY=;
 b=V3SDMIfn3VIGjjOU1d7DjsNf71T74/TLePcoyDlbxCBbtUJ9KQg1tJYO+/eGZTtIcP7AMkWrH6ayu3Acj07wakDbKLHJuJoNhoHaRFu50lBXduPv61y5yOxeIbNf1zq/0DxEe1Sm+twR/mWTJvQHBwwnujGZDYvJtMEZl7oFjxA=
Received: from BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 03:58:12 +0000
Received: from BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::826b:fb00:2eb9:5b58]) by BL1PR12MB5254.namprd12.prod.outlook.com
 ([fe80::826b:fb00:2eb9:5b58%6]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 03:58:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kamal, Asad" <Asad.Kamal@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for
 RAS_EVENT_LOG()
Thread-Topic: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for
 RAS_EVENT_LOG()
Thread-Index: AQHapZJXu+a3LEKGHUe2Us6zoMEgeLGXrPDQ
Date: Wed, 15 May 2024 03:58:12 +0000
Message-ID: <BL1PR12MB5254055BDC4BD034E984CF2FFCEC2@BL1PR12MB5254.namprd12.prod.outlook.com>
References: <20240514000253.4028096-1-kevinyang.wang@amd.com>
In-Reply-To: <20240514000253.4028096-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ff970c1e-4333-4bec-9b50-1248cebc714b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-15T03:57:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5254:EE_|SA1PR12MB6919:EE_
x-ms-office365-filtering-correlation-id: 29dde70c-7685-408d-0fd5-08dc74933d93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YydCHogXTM9HjaQdBf3OyFFASFB8nq2gQKwX05YNlqjMNZ64EWML6gdIBPAq?=
 =?us-ascii?Q?hbxF3npUAeAb6wcO2Nx9l7yNY8w6a/zImZlPO9MMmBAwjFnAlenXwLisyd0o?=
 =?us-ascii?Q?pEk930YNfHYF99uAZGzO5oc25AkzVyHkksGqRiP+20Q4Mq7+XKyr25lNMlmH?=
 =?us-ascii?Q?KxFlqDDCv0YIEr4Avvj5JTvkhlSFoFanNwUhBbxb/0tR+ItmioPHHLbGLFRC?=
 =?us-ascii?Q?y9SZUoZsHQn34Nq+27fmqAY63JwKKwEmyX2LvixllLwLmivywbuA67dwVc8J?=
 =?us-ascii?Q?B4xBApPovSgXH3AWJ1SyQflEIlp2TB9lvGI1FFhotnzsF9v6chdGqDaaRBjm?=
 =?us-ascii?Q?WbxGxLKAZXhds3HlfeT+7R6lgYtwOXVSHHtS7s7x1t3L3aVH2sgZOuf1i01y?=
 =?us-ascii?Q?O7n6ifaLlT+PWDDLfzltNLa7SAxcuu3XHC2bkHLonzavP0otdNyOYhDl0hij?=
 =?us-ascii?Q?+Qxp+UY7/GgIX52PwE6/ZtTFuUZodNp1dXBCVzCAxhBHvWCMH7ryz56kYMvN?=
 =?us-ascii?Q?rHxe929sKO8/L5gzvjTCfkjrb5/k6npuirV5BeNarVFQEXZIsDajdh8+jS7F?=
 =?us-ascii?Q?yqUpM/pg80K7OuqUQdqnaoGxihek/Ak9zUv82NO6WNrRDhMQuadVPstXIb2B?=
 =?us-ascii?Q?dFtq2UTdbzywb2+A6xiGhlnBjO7BKTl5CnY45fZbDQX6OcD4uTd+a7JCsUW3?=
 =?us-ascii?Q?RxBsTVn37xE5TIvFQ43sXc2UkcF1suts1rqvFJ7N1WrFFLwes90actbiKEIE?=
 =?us-ascii?Q?Q99YJ+1e4Au4ZqB1trhXsDi2pG1BR+n4jY1dgde/OrkJ6WUjqr5BGtxJF+DR?=
 =?us-ascii?Q?PWL2D0LB3PRgIGOHO6WhXpsIKrZqXgkzfWGhSSADZSYjiGjE29p/eoTcraE7?=
 =?us-ascii?Q?MX/hXzyIJRUkrjF7xN5riiNCo1ckd9f/ns6mDhfdj0so1H9GILLAj3oDddl5?=
 =?us-ascii?Q?rk54OMKZpY2B81DeuJ+sBd4OR2uzNdUeGRIIHdoFrRfVNVtBN10jBrAjq0Hi?=
 =?us-ascii?Q?/7w6GOlVC04ThYia/uc1WSM1xHkqvjbtRxI4wQxltYnB2156sIBID3RLDXLt?=
 =?us-ascii?Q?P6wbJWD6TRGROfB7gN/V8CMSYdkKZfGv9yGwuUbe6wg1DXSk8w1VyMrINbNT?=
 =?us-ascii?Q?8VFmxTacKX/OWmqcEmWSDHYpDxcMh1UBoJCKBLxA6ZyOmGlzvIYgtnz1JjdU?=
 =?us-ascii?Q?mF8wIa158VW6UkCUvuVb+5/80IESmDK426Y/jX3OJEOLy0KADB447oj5c8DA?=
 =?us-ascii?Q?69Icr/PdJKpNSFT4L6eaIGYG6MAZ5yyF/25Spr1Dc1yopoytEuCc0sPuJ9E1?=
 =?us-ascii?Q?afpNNr6dgegeOjSoJBnur4f29QGC2S+SsL0W3gWqMq/VVQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5254.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8kB293NaD1mRibHh7h/cgdprA/BdfKQlxlSh39idcTZGktnk844pDo809Mnr?=
 =?us-ascii?Q?zKNvd4ux8f3S8itO0xYrb9ghl+Nke9X6r1O7PF6N/nhb78EDpVi6pfkF0sC1?=
 =?us-ascii?Q?Id/SnMhd4MGD8djzCyvdYCJ/86VFz+cNnf0P5Ios6OvSnQBALw4Z6h5m6BJo?=
 =?us-ascii?Q?Qf4u8h0j234858YPE0sG8kk0tB407CTq6F/2GQKrfzyhoH3wX+tK9W70PV6P?=
 =?us-ascii?Q?ou5jp8gc+ikriCSt9318Z17F/dDPaDlAuv3NP0O80VpYDTnOXeqdHlVNJkJx?=
 =?us-ascii?Q?O08j0h6vIyZdczWYC3L2swe7SMJ83JwlvgO5wo324sD20yaaSrSMIJbTx6Cb?=
 =?us-ascii?Q?YeYPlFhVafoIkwRpqufOsmgi92EZazGxRZD9l1AuugA5gUlLNjeUCYsqlS/D?=
 =?us-ascii?Q?7GiJg8kDvdVvjedsKKIdw0qvrRw3qRilcKWoEZp8AtZnPyq25fz8oxzPaSjs?=
 =?us-ascii?Q?wTdfpg6ExwrHvjTn/0GCMXDMGfV5VZzUKhwBy0pf3ykLkxA/z0TpK4TSnquK?=
 =?us-ascii?Q?5rgHu1DT08xkiIqcHW40K+/KP33Z5M9woS12ptLXD/I1ZatZ2G/abT5n+Kxg?=
 =?us-ascii?Q?WU5PNBbuihpVezO+7m0Uo29HQ4o1RLSpf/Y921QpJEL9NuSnCBXkGfey13o8?=
 =?us-ascii?Q?NYM8GWgwt7N+Qx4mqHl9tUzWbNtXa8tigfJzWavvTwSrpIFvEQWIl2BcJKpv?=
 =?us-ascii?Q?xYmlXcLRsDY3SerkAcSJkLKjHMFUNis956HxrsLFbG7ARJNM3v32w1uW/VzZ?=
 =?us-ascii?Q?8H4EeY6FcOrHAGBI2edl7hBeKg7pccHqMcNOfHg7b9KPM4GEiBG6ffyD3/hg?=
 =?us-ascii?Q?lpIrMI6smFB3Vbhw1PaAaAWMcuerubCq5Wp3LEDMHTTiV5mniOtt5KxFcxXc?=
 =?us-ascii?Q?A3GTeTj7VgiW1bpzDZijGL/dvfkJgjsxKWWi0RbvUG1QBCcGq8fKAMZ/GdVA?=
 =?us-ascii?Q?3s/6P2VdaIFXUqRcgyZ4awyCKI0qPQ3K3yfbZpMnf0/+mBtX8s2dKUqmq6al?=
 =?us-ascii?Q?QLWS16ixmQMf6LDmO12ouWo0oIGAHv3oi4NcWxFi9laFXUTCpdR/cI35L6JI?=
 =?us-ascii?Q?RHRYt+4qcJV8J7dAJ7fwtvq+ofKuG29HQQeSFjsbQuoDkoYIvytpNJZcIRxl?=
 =?us-ascii?Q?mgEi218y2pnNt7CcPhor1vdBwkPMdhUwLanDA9PPfY0SADLwKKIR8JxzWxAx?=
 =?us-ascii?Q?1ueljAYYXAQRz/4QQultaRS9Jh7W3o4oZJG6lQwVvrCqGvqTMQWzePO5yesx?=
 =?us-ascii?Q?Z51aCJOnHx18AdHLz5AtBzb1gaOvL0+pqq33cCxT/pNu2ikpvLMFRIEWNtcU?=
 =?us-ascii?Q?HIj0Q2d0cg3UzjfAQsy8cvT7mHQgAWqkyMOnm7yYhB6dl7ZvBZJUVdEYRkMe?=
 =?us-ascii?Q?4gF5o6hm4Ubq1uXElIWx8nTi/L9bF56aY5kvhVG4/CPWBed3H+nDbBYaA1sR?=
 =?us-ascii?Q?PuU/LhcqYXI9K8Nobk7bM861uYoqfyIqO5Sg2WmwZ5aC1Giz/Pyzirw1fiwA?=
 =?us-ascii?Q?xWU0d08dHNdZPdE8WAWMQU5s8SoTY2L7lKJwKXiaKQ0w2FIR0ONEivVkA8sL?=
 =?us-ascii?Q?LITJTcPeSMPfkB2Ix0fzrLafgdIZb3vr+Fa16AP/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dde70c-7685-408d-0fd5-08dc74933d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 03:58:12.1781 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkQ5OLRgTRkH17VjWYR/2Wxl7Xe+m6c2wOS2LP37Krpyx140Cmnx3yk1Egz6zUMkKec1Yl65sG1sAlqCGoPfPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Tuesday, May 14, 2024 08:03
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kamal, Asad <Asad.Kamal@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix compiler 'side-effect' check issue for RAS=
_EVENT_LOG()

create a new helper function to avoid compiler 'side-effect'
check about RAS_EVENT_LOG() macro.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 18 ++++++++++++++++++  drivers/g=
pu/drm/amd/amdgpu/amdgpu_ras.h | 13 ++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 1dd13ed3b7b5..c04e6ced1af3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4504,3 +4504,21 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *ad=
ev, uint64_t pfn)

        return ret;
 }
+
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+                               const char *fmt, ...)
+{
+       struct va_format vaf;
+       va_list args;
+
+       va_start(args, fmt);
+       vaf.fmt =3D fmt;
+       vaf.va =3D &args;
+
+       if (amdgpu_ras_event_id_is_valid(adev, event_id))
+               dev_printk(KERN_INFO, adev->dev, "{%llu}%pV", event_id, &va=
f);
+       else
+               dev_printk(KERN_INFO, adev->dev, "%pV", &vaf);
+
+       va_end(args);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index c8980d5f6540..6a8c7b1609df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -67,13 +67,8 @@ struct amdgpu_iv_entry;
 /* The high three bits indicates socketid */  #define AMDGPU_RAS_GET_FEATU=
RES(val)  ((val) & ~AMDGPU_RAS_FEATURES_SOCKETID_MASK)

-#define RAS_EVENT_LOG(_adev, _id, _fmt, ...)                           \
-do {                                                                   \
-       if (amdgpu_ras_event_id_is_valid((_adev), (_id)))                  =
     \
-           dev_info((_adev)->dev, "{%llu}" _fmt, (_id), ##__VA_ARGS__);   =
     \
-       else                                                            \
-           dev_info((_adev)->dev, _fmt, ##__VA_ARGS__);                   =
     \
-} while (0)
+#define RAS_EVENT_LOG(adev, id, fmt, ...)      \
+       amdgpu_ras_event_log_print((adev), (id), (fmt), ##__VA_ARGS__);

 enum amdgpu_ras_block {
        AMDGPU_RAS_BLOCK__UMC =3D 0,
@@ -956,4 +951,8 @@ int amdgpu_ras_put_poison_req(struct amdgpu_device *ade=
v,
                enum amdgpu_ras_block block, uint16_t pasid,
                pasid_notify pasid_fn, void *data, uint32_t reset);

+__printf(3, 4)
+void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
+                               const char *fmt, ...);
+
 #endif
--
2.34.1

