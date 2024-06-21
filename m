Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97986C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 08:52:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E5810F0D0;
	Fri, 21 Jun 2024 08:52:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3I/mq1DY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D9010F0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 08:52:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsrbOTyiizVHbumKbNn2BI3BhWWMr7KzULw0+dPHzuf1C/6m/ufwPJkoov5QxwzyKTBCzNjeqfc4SvbRBuOsikUXY9c9Uvl/7Gyeg9LF3UvNVuC4VJVeVn/fovN+3lMdEdltXWzQgTEoKMHrxxYryfQV2PcIfHIkVt9rCa/0IoFcavHeGttj2jnrOrXoMLMpv2m+1opzctf4U1HVxu/aR/fH84a0TrtCYzZRT+EvV9fJQ200PHwT13MUUe6veKE9VEDRu36Q4o42uExqYCiw1Ssc086aG1YiybA1nOk8Ng5pUIaxUX1j8qgsjMLCwuQDnfvUJnRpV1SjPvqje/wKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0HfGYe08CV7N8XEvXUCTkyUg4nFvz+e0KmCNn9DLXU=;
 b=BWUlAaHoPRWoP4YZpS+oTgrIOU6WaAbKvjwnOxT3BzNiwpuzD9KKHHsoJoTk04/12/IQxT2Ow3m9G+ElELyiSaFCYVZkh+OI6MChPiXxzbsYo3ZMBo0DJA1a8lZlN6CqkOe/dN9F49oSOY4JlgtV2ZGCdUq2BOqMthmZW/u1CTBv5e5PbJNC3vgoDsigZwkszpP8Gwvh4klHG0A/90uRCwwjSMnHzXQMJVaXaHhYgklVJVK5xDiEL8rcFVkSBmufkmVJAXdkbEcKlFVi5XXcmSPCOeRC812469XIKxmNcfOLLP02x0fwr8EFTbICbFTpcI8qSvAuzqtXcvokTDuc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0HfGYe08CV7N8XEvXUCTkyUg4nFvz+e0KmCNn9DLXU=;
 b=3I/mq1DYIEawp5u2eJW+V3oBJmqAL6yQhygEI7zpLSLFkQD+zO4Pv0kKeP28sWBFGl/9hVdPRPMi5aU7RqHB+NvXvp6QWSqrNRsRJeNoQ50FFuLTrcj3xmte9hZKcYnxJpGOO28479VsROatZR0acvL7FNH9Nf6LrdNvAmIxXak=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 08:52:33 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7677.019; Fri, 21 Jun 2024
 08:52:33 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred
 error number read by driver
Thread-Topic: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred
 error number read by driver
Thread-Index: AQHawtR88AmkO50MU0mVf/23TN+s/bHRxU8AgAATBlA=
Date: Fri, 21 Jun 2024 08:52:33 +0000
Message-ID: <CH2PR12MB42159FF43142D3BF8C04DF60FCC92@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240620054020.434523-1-YiPeng.Chai@amd.com>
 <BN9PR12MB52576C871E3B6131A3B580ABFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52576C871E3B6131A3B580ABFCC92@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c6c4203b-9593-408c-8a2f-287a2051c6a5;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T06:36:44Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DS0PR12MB8453:EE_
x-ms-office365-filtering-correlation-id: 3726c9df-4abe-491d-5872-08dc91cf7ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?g5Qpbghys2AQky5m1if5e1JhyGsyNs29r3wyH6ZnRBtlPbZoavVX4hjnsBgz?=
 =?us-ascii?Q?G/zP0nYMVJqnkeI/tzPMMmjWRZFC0yRUxM0Hs2IqhlAMR8Q21eh14rMQKqfs?=
 =?us-ascii?Q?wrTXS7JTdS9Txu1f2e3X1MvL98/4K9QOWE6mUH1ujjU2ayqdDBw5SE1zcwY7?=
 =?us-ascii?Q?JUtvhp724zI++WUOMgPanEOsSbNYu1nVS5OqDO7grJCn0V7uhzIQoqpESpDf?=
 =?us-ascii?Q?O72K9aGvRsIRHYifFHCDUEaZkFEVxXJyF+6IKFoGfrbEHZrvofuHjtbLp1ui?=
 =?us-ascii?Q?+fDTJlEkH9S9DuvlEp3ggcVC7ce1vD9EpOwvgwJo10SQyHM1qaU0lfsB2Cen?=
 =?us-ascii?Q?o3ODgnWox87xzVMxwUL3NcDf6YMHJFcYalyeqetV47/nNyakZr8dA7JKhiww?=
 =?us-ascii?Q?TUfh52sglp/4gLLUyHq0x9ylYhYcP4wFftmIheb+EkgpJDuyNfMUGlPBh7Ln?=
 =?us-ascii?Q?qeeVJ2SXAOGZP9nS6LMqFZKnvAiFMGHhXbbKJXad21k1x807yxYr3WCpF8WM?=
 =?us-ascii?Q?2jzHxtkC6pMm9O98uqgHem3rsI+AHgZb/MdMemHqtvOB+8934kk9oxVr98Zb?=
 =?us-ascii?Q?lnw4SRLBqqyMWRVBeDbRnsQi/TZXRL4KSkocusC+IbRMhQ48Gw+cDYCXrYtY?=
 =?us-ascii?Q?b+a3incdqTJbOHBjAz+lwXaaK1z+0nAZZQjUQW0ExrmQ2wcG2296lhLO8Ts9?=
 =?us-ascii?Q?BxCjZ4RxnOc7MvJXE0hEDJNlBWqEsWCj+TXOaat6LNs1poxuDP4mPgnF7+SN?=
 =?us-ascii?Q?h4SeT0ySBUIDSlLdZ2217vKMQ79pOloJjx600viZGkEWDhCoY6zeDJq6zzYo?=
 =?us-ascii?Q?nOrhj+3DdZf5oUWDPr+RJi9wjEDy8dcbbAbJOlbHLv/IdIzjwuNZNgCOvQFI?=
 =?us-ascii?Q?T16oQejdA6bunHdn+L+AF82o/U84FTDWCsuy8Vo47AnJwadjk+91Y5GvAWq4?=
 =?us-ascii?Q?YHG9ZmMXkau8Gvg1FuGLtP/tFT5EfFEisbUK7zirRfi+DvuwJJCKjz6Wubja?=
 =?us-ascii?Q?3vXZtQ/HKjJjUe1WjAL5dOPdoYNJQgBHqjUoXNPRAwBcmxg8x3gSCJTLYi1W?=
 =?us-ascii?Q?Wp0jEB2x4UnSWH6cO3haXSY0Gy2y6SW6mMr2OsUXdabDSGA8TEvQ8Izwn15s?=
 =?us-ascii?Q?Zze/vDTcMDcBmP6ALia5jyA04lWMWABuW/BlHVMSuzreg8+R04djdTDH27XN?=
 =?us-ascii?Q?kSP3B1+/iO0xYU6ECEUOOM+cv70ilZtjb/fnvA/mP8mpUUDUAozHGZqrUdWa?=
 =?us-ascii?Q?+mRfIlKtcHxBAZ2Su8Ga+vD8c+Jkb4TVP5UjS3rtLh3dMdF9NT7xltZw4ZN5?=
 =?us-ascii?Q?/4ASB/ZthpM24HndWT3rPzIFkW46kFT+6zKHBbQMMrVD8pHOzIRHGjqgfgW0?=
 =?us-ascii?Q?CYdypEA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aOeyq/3NgV4H9HookLnTplIGrkA0vzTJrfpr99SDjDfNq7T5thf4LIT7ko/V?=
 =?us-ascii?Q?pjpGq3aaleDudoxcGuNzBTKXHjJHK7F9FuPPhaOvOxltAqABmNtxWXCm0hg+?=
 =?us-ascii?Q?a0Q6NaF5VIN4GTKcAA8p6i/yNS58jLfELNKkGp6Rb++26qCBaZV8nedtjvxC?=
 =?us-ascii?Q?S3LH+3H9Tfv926+Ocu2GCLjGzQKzploCOvvHOJ6O8CcqBOW4ZO92fI2F6P7Y?=
 =?us-ascii?Q?LtWZYUch1AXYDjnUgQGAjFsLcQ1aee8+H5By85s2ICLjhZtEYyxz/2/9xNmv?=
 =?us-ascii?Q?+sZcy2dhIpYzPkb5nVHcVi27vq/jd2nu3md01EgC2buzvG5/9t4FbdYJvJwo?=
 =?us-ascii?Q?iGFwkgEEHhSYNvTXShfdP3Ko/xpSv77yR5iMFTZnvQ/Y7Ueggp+1yI8rUlnZ?=
 =?us-ascii?Q?sytxZVrhnkJ8EjxAI7vWGZiGrnItPnjZJ6vjIJeHv/m7MG0IZU/iSOv73qeo?=
 =?us-ascii?Q?Y8zuuQfWWujXochQ1Q/scylsRf2mTM65gWEBQ7si4nJuxGKV7s9OJSqVHb65?=
 =?us-ascii?Q?j0/Xc0ecpvYHjdVEqAtuP63f3otTxYPzIkt8/Ad6Vx3nzDaIY6tjbQAwaLIT?=
 =?us-ascii?Q?qIVGyBJMDJ58A54Gu50MYWHttwHHDbZ09E/MuhE7ulxBPlxMni5XqTdyj9O9?=
 =?us-ascii?Q?YRt8UW2l8VdXafQId97Monyp8zW+cdSZKMTRZRAA88FOXFaAJFOS5rDY8amW?=
 =?us-ascii?Q?hVweS8w+AEGDE+UT58BrXQalm2e6YiJiQ7/qwySP6484VxTK3H2m1y1sZlhv?=
 =?us-ascii?Q?RfosKWtJe/B7lEOLd1TUIh/YBRL0cNQ6nI5/tnr8urQ2RFDfKK7lD/X9O+jV?=
 =?us-ascii?Q?xEPVa+56zz6i4o9ToowKHFilPL738nsg7I7V6Fg2nI3Ai+aa2uK8YjiPqbcS?=
 =?us-ascii?Q?mSB3/F+TPyV0H9IbLuqnPjXRdaqK7JLVlGbjyySJRr7gQJOnQmbm+g1AweGs?=
 =?us-ascii?Q?Oz0hUPGygBCBKJ1FCPK8yorfRFeALOZe1R3/6CLjzT2ATy2MDab1M06+g6RV?=
 =?us-ascii?Q?JE+fdTHfYY6EStL3lNmoio7zAW4JKHJvme9yTHgJM9MPJFU+OqOcye93ZJAI?=
 =?us-ascii?Q?E2k1zLcqOtqB97DQH22nyFVrnP3clhz02CzWYpe65WlVKJreKMZaCuT1QwEp?=
 =?us-ascii?Q?5D6AQg6LZmnuqhGXCUG5w95Rx0jjhLl7SCUu4r1F+f/iMTbdBCRUixMidEvD?=
 =?us-ascii?Q?pzIMUhO+Sri91gtZJr8wQdes4XXwrkoYgMCiusmkLRZoOCFCbYCOWE/2MHEf?=
 =?us-ascii?Q?4/gZkwwp5xZX7DbYsWoOgbOyzAf0NJxgRiBxWGtr3wtewZxdpTnupxp908Yx?=
 =?us-ascii?Q?tSmpiaKnF8Ct6kBvjdWwh/HT3Immc9bsEhNqomTeda3GQKbVR3GU6y0M2esd?=
 =?us-ascii?Q?rsyPiB1qoBnUNt8Mz7Qkd0H3FK6oz08oC/O4FtUhd+GHY+30Cnt73tRb0Ifb?=
 =?us-ascii?Q?c3g8vtGNvyNgzu9fL75vbdMUPzKQ45OdOl+YVIot+D1iXMqv43IyQqtIqIPW?=
 =?us-ascii?Q?V5XGcN27t5x7BR7RndD9iPEPKq9f1dR3deC1tKFNDd+JIX5fAUuKk7qZ17H9?=
 =?us-ascii?Q?j1YNa6iRuPU0B7mrC4M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3726c9df-4abe-491d-5872-08dc91cf7ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 08:52:33.5358 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uO9eNQeeXucXJjWpyi7pk8p3RmqmDqz5JRUDusgWJ4CQxzQ2WF+UlsO2RcWY+y6Sr3mW8q/DXarcboHR0t+bcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453
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

prevd_queried_count and de_queried_count are used to accurately count the n=
umber of DE lost after driver receives a large number of poison creation in=
terrupts.

Since amdgpu_ras_query_error_status can be called by page_retirment_thread,=
 xxx_err_count sysfs and gpu recovery,
using local variable to save the old de_queried_count before calling amdgpu=
_ras_query_error_status in page_retirment_thread will be inaccurate.


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Friday, June 21, 2024 2:37 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred=
 error number read by driver

[AMD Official Use Only - AMD Internal Distribution Only]

Shall we make pre_de_queried_count to be local variable? Others look good t=
o me

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Thursday, June 20, 2024 13:40
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH V2 1/4] drm/amdgpu: add variable to record the deferred err=
or number read by driver

Add variable to record the deferred error number read by driver.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++++++-------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  3 +-  drivers/gpu/drm/amd/amdgpu/u=
mc_v12_0.c  |  4 +-
 3 files changed, 48 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 86cb97d2155b..f674e34037b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -120,7 +120,7 @@ const char *get_ras_block_str(struct ras_common_if *ras=
_block)
 /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
 #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

-#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
+#define MAX_UMC_POISON_POLLING_TIME_ASYNC  300  //ms

 #define AMDGPU_RAS_RETIRE_PAGE_INTERVAL 100  //ms

@@ -2804,7 +2804,8 @@ static void amdgpu_ras_ecc_log_init(struct ras_ecc_lo=
g_info *ecc_log)
        memset(&ecc_log->ecc_key, 0xad, sizeof(ecc_log->ecc_key));

        INIT_RADIX_TREE(&ecc_log->de_page_tree, GFP_KERNEL);
-       ecc_log->de_updated =3D false;
+       ecc_log->de_queried_count =3D 0;
+       ecc_log->prev_de_queried_count =3D 0;
 }

 static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_info *ecc_log) @@ -=
2823,7 +2824,8 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_in=
fo *ecc_log)
        mutex_unlock(&ecc_log->lock);

        mutex_destroy(&ecc_log->lock);
-       ecc_log->de_updated =3D false;
+       ecc_log->de_queried_count =3D 0;
+       ecc_log->prev_de_queried_count =3D 0;
 }
 #endif

@@ -2856,40 +2858,64 @@ static void amdgpu_ras_do_page_retirement(struct wo=
rk_struct *work)
        mutex_unlock(&con->umc_ecc_log.lock);
 }

-static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
-                               uint32_t timeout_ms)
+static int amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                               uint32_t poison_creation_count)
 {
        int ret =3D 0;
        struct ras_ecc_log_info *ecc_log;
        struct ras_query_if info;
-       uint32_t timeout =3D timeout_ms;
+       uint32_t timeout =3D 0;
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+       uint64_t de_queried_count;
+       uint32_t new_detect_count, total_detect_count;
+       uint32_t need_query_count =3D poison_creation_count;
+       bool query_data_timeout =3D false;

        memset(&info, 0, sizeof(info));
        info.head.block =3D AMDGPU_RAS_BLOCK__UMC;

        ecc_log =3D &ras->umc_ecc_log;
-       ecc_log->de_updated =3D false;
+       total_detect_count =3D 0;
        do {
                ret =3D amdgpu_ras_query_error_status(adev, &info);
-               if (ret) {
-                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
-                       return;
+               if (ret)
+                       return ret;
+
+               de_queried_count =3D ecc_log->de_queried_count;
+               if (de_queried_count > ecc_log->prev_de_queried_count) {
+                       new_detect_count =3D de_queried_count - ecc_log->pr=
ev_de_queried_count;
+                       ecc_log->prev_de_queried_count =3D de_queried_count=
;
+                       timeout =3D 0;
+               } else {
+                       new_detect_count =3D 0;
                }

-               if (timeout && !ecc_log->de_updated) {
-                       msleep(1);
-                       timeout--;
+               if (new_detect_count) {
+                       total_detect_count +=3D new_detect_count;
+               } else {
+                       if (!timeout && need_query_count)
+                               timeout =3D MAX_UMC_POISON_POLLING_TIME_ASY=
NC;
+
+                       if (timeout) {
+                               if (!--timeout) {
+                                       query_data_timeout =3D true;
+                                       break;
+                               }
+                               msleep(1);
+                       }
                }
-       } while (timeout && !ecc_log->de_updated);
+       } while (total_detect_count < need_query_count);

-       if (timeout_ms && !timeout) {
-               dev_warn(adev->dev, "Can't find deferred error\n");
-               return;
+       if (query_data_timeout) {
+               dev_warn(adev->dev, "Can't find deferred error! count: %u\n=
",
+                       (need_query_count - total_detect_count));
+               return -ENOENT;
        }

-       if (!ret)
+       if (total_detect_count)
                schedule_delayed_work(&ras->page_retirement_dwork, 0);
+
+       return 0;
 }

 static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *ade=
v, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ras.h
index 83437fef9df5..748bbac666e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -469,7 +469,8 @@ struct ras_ecc_log_info {
        struct mutex lock;
        siphash_key_t ecc_key;
        struct radix_tree_root de_page_tree;
-       bool    de_updated;
+       uint64_t        de_queried_count;
+       uint64_t        prev_de_queried_count;
 };

 struct amdgpu_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6d6350f220b0..0faa21d8a7b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -557,7 +557,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
        ret =3D amdgpu_umc_logs_ecc_err(adev, &con->umc_ecc_log.de_page_tre=
e, ecc_err);
        if (ret) {
                if (ret =3D=3D -EEXIST)
-                       con->umc_ecc_log.de_updated =3D true;
+                       con->umc_ecc_log.de_queried_count++;
                else
                        dev_err(adev->dev, "Fail to log ecc error! ret:%d\n=
", ret);

@@ -566,7 +566,7 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_de=
vice *adev,
                return ret;
        }

-       con->umc_ecc_log.de_updated =3D true;
+       con->umc_ecc_log.de_queried_count++;

        return 0;
 }
--
2.34.1


