Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E9FD2C56C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 15:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F7810E6A1;
	Tue, 22 Oct 2024 15:21:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QioDXHGD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B3010E6A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 15:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLNpUi+SccRYwxgRiPtqaPAMBbssaA5hYYcgRppoF/bm1XqUcQMYCjgnjC3l3gzcA2ovRxj/m7bQvdEaKdzz8/0o87Xn2UoNyZjH/iLGnNsCquUVZ13K96PLQG9iWT4898wLEqz2I2/dQ2DB1/p71E0+pfYPrUPOxkT+KH+4OnqFbV2hrIEYvCR1FmM5wojs/b5HzxMDHbd84CTLrrpnhiZvYIciWzzaDFCD5sRwJ3ZRula8eVTGvVoC/l2EzGpwFvJclRJoTNA2u4enwRIMGqhaF18wJE9MLAmurn+ucl2zEo0nG8nyUlDOF24Xqc/FlSlLXEagL5o3FqIMFCXFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC1q+lC3y3fhxUfL8yUil7lmpcizeCQ618iROgWgJ+c=;
 b=AheqZHEgqTKcBsFplS9t1eXOKXkUWv+ZPTcwgFgsbR7XCIs6CIlrDtYg1iwfJo8n9h+TQvjT2ybdEp8adGf6oohCNpccDLFAmuM+1/42CK4ZLQ+fRP+3Am6vbj/aibYaiTyxa9OMYsZtHaJR+HMzgKtkxZ6Onm8GcnatOOLx3JIOz0VTRJdQuTG1JpqN+d744BeUjaxczt2KJYV7hw0947y7vWWqruuguDVCIwL3SkpRSbs4SadwaTwW8uF7k0GKotX36zOK22gbit/c88IBZdoRmJdK355J8otFA41HrobXo8qMDHPv+OL1KGJ31wDZJBzpYi+jzTMZ8HeE+UDR9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC1q+lC3y3fhxUfL8yUil7lmpcizeCQ618iROgWgJ+c=;
 b=QioDXHGDVTojHTKZk5tNcQsdFn/fFqcc6LIJKFCW9Dl3QwfA41mnivXJkrryhry0uTEgREN+cfy0iG1z6inBuF5SKWQYE8tSJQxTVgDcU3O/KBp9socrIe66ldOZtv/c4I+7bHkqf9z5t+xrgIxEuG8tPH/4Us1sBlD2cMTaBic=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:21:17 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:21:17 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Topic: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch
 data
Thread-Index: AQHbGy7vBz6yYsAPoUKecJDZCj28xLKBxp0ggBEvETA=
Date: Tue, 22 Oct 2024 15:21:17 +0000
Message-ID: <CH0PR12MB5372FDFD772CC7CE375A78E1F44C2@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20241010161015.624089-1-shaoyun.liu@amd.com>
 <CH0PR12MB537294897F02C7B52A8EAF6AF4792@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537294897F02C7B52A8EAF6AF4792@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1996c33b-d484-4ba0-96aa-068d3b890968;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-11T16:56:17Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|DS7PR12MB5792:EE_
x-ms-office365-filtering-correlation-id: 727272ec-0d7c-4f82-f10f-08dcf2ad2ce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iF4FyK6uB7WPqxkcJbvcRQr6NLyDkV8bK8vf77fK1QJSi5cNvxWRyn9jOfc6?=
 =?us-ascii?Q?FbnDa3ZQjZ/m9UAj5JfAJip1Ini+sgl7Ux2YQRxAIG99iHNX2v9b55aDwqwM?=
 =?us-ascii?Q?Q8KmWlleEwZnKgLiaeKlyZ0GY2SsmiPDoHU5A33QMx3iQMoNfqZokcMbQxw9?=
 =?us-ascii?Q?SNO58gk1e+elgsOb0zMBU4KbOsO7R50rL3NGCa1SmLcZ2JvS9nHVpwnmYNke?=
 =?us-ascii?Q?cpRC06IpCObSvFfVbHwdP4PFquSf90Zq9rG8z1WN9HnEOkewAmj6eSJZzqo7?=
 =?us-ascii?Q?f2wioeiAaRpzxcIrsDUqCPQXqcP0snia6hbT+bXoZXBvI68U+5+eJ+kJWcoL?=
 =?us-ascii?Q?Cdb0v3GzBsd48k9VSioGoI16hmZSwdrMmbacm2w+cdqW1gCcsLown9kKmLXo?=
 =?us-ascii?Q?4UxSc/va/NaSzT7Wgl4VIjszmPT/JC4TCtuhkJzBCENnkEiKjbTAwQKEOUgl?=
 =?us-ascii?Q?7F2jRMd8eyBcVDJVpaN2ngEY4aKkk0nU3rzNjuERKT9vpo9onfurbafr4tTA?=
 =?us-ascii?Q?JJf5lwaKvaukVPgqI43ZoAr5dp+FgQqBRvKHgQ5eUcD3vOCZKxOSIa7OFv61?=
 =?us-ascii?Q?+5PuQlxVNYB7FP9iRvtREGsVG3WTtA32xkO89yHxzs962gj38hfuPwIoL6Mw?=
 =?us-ascii?Q?IYvWuLbUAdZ5fJijBOa5EHodnX1Dr4tUGRtnG3+MII0zOAJj2+t6oNTWY1uJ?=
 =?us-ascii?Q?nkwSnRczT03Yq6OSS2E9r41AN2s8fDvELanacFDlV+0Q/B+/8ev080Bzw5jN?=
 =?us-ascii?Q?jrMJkzvbumvjoVEHEm3LFq6xYVdiyo/38bLku/9c0nd4Uer7LvPDtax0NQQF?=
 =?us-ascii?Q?aWMI7F5I9n//1dOdSjLrZvAAUvrX5tpifrpBQuKJjUzt7u5An2qQLGPpd8ai?=
 =?us-ascii?Q?jnknAE88cKFeBL+eofM5YzCwDTAT4FoDI9hLQpxUz7sJj8zcpiUwMmHaOMUt?=
 =?us-ascii?Q?porbNjWR40e2Q+n2dibItFQkXJDfxdlTxBqow1sviCzMwxgbysjS28s1YG/V?=
 =?us-ascii?Q?omBdZv/d7/da5XNXLiD2OgLxSfMNY6DocTbn+TljQ7wxbzrbUg2EN+i3Iw0H?=
 =?us-ascii?Q?FHF77Yep6BOSjiD3YJlvc2gls0AiR3CIfl6N5LzlFfvHu13TrEXsEy/wSh7k?=
 =?us-ascii?Q?Mq7S/vq4bLgbaDt0yEG+QZK1ZhyHTRa2jlzXElfbRZmZQGJQisqW0fSHNUAk?=
 =?us-ascii?Q?S99m8b+QowFv08/8z834M/vhyha7qjNyHFvIMJ6qGkrUXVtrErRJrkxnvVRD?=
 =?us-ascii?Q?JzG3EGfMU8pevXgM69kRnMeDImRVqdefbAL2VSajHxYvT7zxEHVy0JOgotxG?=
 =?us-ascii?Q?CVd9q284u+CzVV52G846/sxwbf1nlLp6vFudcNsYhcKQ7rgKjjGC9ffB8em2?=
 =?us-ascii?Q?OJpzSV8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+cepai5Wni1Yy7sMJBbnTvhkvMXUfZC7olhpWXpotAJTQx6l8NezwhGb2zMi?=
 =?us-ascii?Q?mJcRNwcTfElbk4n3g1JqEW1vQAGa93efZM15ghK9yGXhjKtnpI54I9E4QSAC?=
 =?us-ascii?Q?EyPx5a3zjFatshtm8Om9FSrfI5pebJWGkOUj4vsiOI1DEe/yluMJ+QvKrnzJ?=
 =?us-ascii?Q?fpkLwNV/BjLmYV+mbsnHvnIcxvYBEJBpQGWp7FS5rX6QRId5CMn9XYX27KqH?=
 =?us-ascii?Q?VeasjGHYzJmu+G0IxGLtXPELUqgNScfaO3NUjQws/DfY/UClAG1sPYhZpB7e?=
 =?us-ascii?Q?OsNuzJSaXOjMW3HppzYjwJ4wJqxrVY+R7JTRbMvKM1k4SlwKl4k0dNr4qAGg?=
 =?us-ascii?Q?TV4vxxK2hvNn7HR1QAQpyjiouNBv6pTRWC0aPEQVFADlg8Mi4gjORkR3jtQe?=
 =?us-ascii?Q?RivfyWVIyp7Yk5rMQ2EVv3EfyPTnOiC9yX+oRkgYSVsMJzzfT8X9ZANss7Um?=
 =?us-ascii?Q?53QRBTpalJArVUcazk6k5zxSQ3m5HOxFd6I9xnI8Q4SYv62YY1h+z3SNEEMm?=
 =?us-ascii?Q?7xkgAl/p43ol8cm2amhHmLBsKzTEZCIc06z/h9yFveQ+FPeBQ8Rd1dZvKxsO?=
 =?us-ascii?Q?HXR1Y9ymaqLfP0S6aXo9Kux/cN4k5b2jwNVzhDAybzfPvqbLTwmB8Jms2kM8?=
 =?us-ascii?Q?4mMm42Fvrd5eAkHVkmq02uduwsJtl5YefFntybaaCudmEiUiYGx7eK+YmdMd?=
 =?us-ascii?Q?Wkh9RRTmR+B1n0V96L0Ax2MeF9IVE2XxS0zM7hpKPcxO1Bhtfd5dhJU6gI5I?=
 =?us-ascii?Q?DheTbjhEzhnMbRJVpUuu76aEwwEtFfTaI5eJzL4QRkLp2ogNa+YSW9/qUbV4?=
 =?us-ascii?Q?gNlDCDrNeE9CHY4MTgE7HDU8jNeKprgjIvkKVN07z2JOMyUtzy4cPEvoORJy?=
 =?us-ascii?Q?H0SjMapbi8Kz2DgxaBrmTDMKf+acIap6JBsC50OtirOOi15ekCxKRR6aMYS2?=
 =?us-ascii?Q?2VqXLHySGF0vgufeTLNTb9qHrm9+atn3YqzReIArhz2utfj4iMSe5OlAh5rs?=
 =?us-ascii?Q?Egkal3K5iLPWGwYo0dX225QEAJWvhKOXwLLXXU1eJa3DSTh9I8NqdDuobnFq?=
 =?us-ascii?Q?7nCrBgdEUt0tU+mNfQG6gqvhvfwBX1Mr03vzjEUG8M/V6g+09YLLWVnrqvag?=
 =?us-ascii?Q?UIHXnOXSKPq33635uXbwj29/di3pg/WbJUYLTDd+4gi6zBnTQhNJFrIbsSuN?=
 =?us-ascii?Q?Lnxw7kL+G7i6LHOlFpztW7bWCDSShuh7Tpb1QD3e7fdjWB/yjKVhBkCUZnAe?=
 =?us-ascii?Q?slyN01T8WyOQJi187oGankKTPlJtJ+JsQCUB7iZP80oMzFbOmUyR8xxPizjK?=
 =?us-ascii?Q?L/qGtvMg60j7lCOU/vq4kbA/ubtcmQjS0MPlFb9NloC/Ld8Is5dq/bADd7Of?=
 =?us-ascii?Q?LAfjED30mpviqkd3m9rNT0/cAfzyWXVJ8zJNVpYVh+yi3mThJFKLw4iKT5GJ?=
 =?us-ascii?Q?wJMw9u2w/h6vTvRe1/Ax5InJq7c+hSr3KV9EdwXVW/ei50icB+hk9kIfeLMU?=
 =?us-ascii?Q?LsB/dCSgf+8k+GG3bqWjhmrhZzx+07ngKiN4Dd9xm11zrxigeY/gaD5Bogfz?=
 =?us-ascii?Q?g0s5nPYlzOyOugWyMIw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727272ec-0d7c-4f82-f10f-08dcf2ad2ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 15:21:17.5674 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjUgOmWY7Lu8cwF01EUOdxtTPTS88N99J6CIc77qulIdPsZGOTwhLlL+GFoSWHqCX8vwZ1ZDahuoxgIe79zdGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liu, Sha=
oyun
Sent: Friday, October 11, 2024 12:57 PM
To: amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratc=
h data

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Ping .

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Thursday, October 10, 2024 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: Increase MES log buffer to dump mes scratch da=
ta

MES internal scratch data is useful for mes debug, it can only located in V=
RAM, change the allocation type and increase size for mes 11

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_mes.h |  1 +  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 12 +++++++=
++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 83d0f731fb65..bf584e9bcce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -104,7 +104,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_devi=
ce *adev)
                return 0;

        r =3D amdgpu_bo_create_kernel(adev, adev->mes.event_log_size, PAGE_=
SIZE,
-                                   AMDGPU_GEM_DOMAIN_GTT,
+                                   AMDGPU_GEM_DOMAIN_VRAM,
                                    &adev->mes.event_log_gpu_obj,
                                    &adev->mes.event_log_gpu_addr,
                                    &adev->mes.event_log_cpu_addr); diff --=
git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/=
amdgpu_mes.h
index 45e3508f0f8e..79f13d7e5e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -40,6 +40,7 @@
 #define AMDGPU_MES_VERSION_MASK                0x00000fff
 #define AMDGPU_MES_API_VERSION_MASK    0x00fff000
 #define AMDGPU_MES_FEAT_VERSION_MASK   0xff000000
+#define AMDGPU_MES_MSCRATCH_SIZE       0x8000

 enum amdgpu_mes_priority_level {
        AMDGPU_MES_PRIORITY_LEVEL_LOW       =3D 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 03bf865fbdd4..aa2e9ef4ff12 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -913,6 +913,16 @@ static void mes_v11_0_enable(struct amdgpu_device *ade=
v, bool enable)
        uint32_t pipe, data =3D 0;

        if (enable) {
+               if (amdgpu_mes_log_enable) {
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+                               lower_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+                               upper_32_bits(adev->mes.event_log_gpu_addr =
+ AMDGPU_MES_LOG_BUFFER_SIZE));
+                       dev_info(adev->dev, "Setup CP MES MSCRATCH address =
: 0x%x. 0x%x\n",
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+                               RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO))=
;
+               }
+
                data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, =
1);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, @@ -1375,7 +1385,=
7 @@ static int mes_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
        adev->mes.kiq_hw_init =3D &mes_v11_0_kiq_hw_init;
        adev->mes.kiq_hw_fini =3D &mes_v11_0_kiq_hw_fini;

-       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE;
+       adev->mes.event_log_size =3D AMDGPU_MES_LOG_BUFFER_SIZE +
+AMDGPU_MES_MSCRATCH_SIZE;

        r =3D amdgpu_mes_init(adev);
        if (r)
--
2.34.1

