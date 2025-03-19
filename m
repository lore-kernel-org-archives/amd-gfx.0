Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F4EC35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6C4710E1B7;
	Wed, 19 Mar 2025 06:40:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RSqi7LUL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E4B10E1B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGEMoMsBOx0hKsp86Qv8BGN9tQlgtRnl6Gzcz2gc8l7xifaTa7UcMq4QqJca5F9ybnHeaGJIhYfqxCWQrl6a15G8Vx/6SMhJIxHy/dSYAZOY0gL2Ai5Jl0y+2EhsPtDvYn+VKnrBAnLs6rkV/n+WzWzTMBJgaa0WM08o5bMS/NT1vMX8QHFpNwoqWx5mRqMIpQtlTTAGf5BT+7LHTH61QQoqYPWDzzk61Y4Ay7+HtcgcEn+J0ldC/xyDH7dklaNNPx4QUAtCOWdM4ygklXoAaQZe4o2QVPnkUf6LFRuZ0IA4TORYDzR13KYiEaIQf2YRa6H/u7WGpEzROb1UhBm/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znMFIHwiKj2o9ymLqkYm3vFkXkwXqdTUXKs8+7GesRA=;
 b=JpQNj0OlZvO8EgVtfXeWbBvLNobuvKDmcBznShXmuiDWVz95MqFyl/wVosgAQ6y5sI/g3Zj/lFk70pW7j0ltxkUkshhbYKbeZnf3oYzEJwzfh/qdT1yIkF+2dIgnVGTs7MHpaiXFsqHaEnwKUBIhlhyEcOwAEvEmWpDGIpZH/ciV7hKZeKgCuYRU1GQIk/XCb6q69hSvXC3c6YJIAIuapXv7HS8Q3kt19jMz18jbzrucgtpip/mAmv3cMgbH38pm4buN3ESGBg36FO/9FaM6WGfn3WfvSzYD1ouPfnidF9WIU76kPsOw9ENzGQSrUmIjUXivfeH4F4wZZkgOyatvWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znMFIHwiKj2o9ymLqkYm3vFkXkwXqdTUXKs8+7GesRA=;
 b=RSqi7LULYsOc4ZiGcpqMah/U66ekVfBTU6h+8SDgZtAZsW4LQ9vpd4dWkisOmTT+lLOX8eapBXBHq+nZywACCFQEjP31zyiXSVkLR7BE3t5tK/4z4iUJZ1R72dzW9Yhd/+WCEtC5GqyueSIHlZqGApNMrfW5YKwFNGo5sWlH6RA=
Received: from DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) by
 PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:40:33 +0000
Received: from DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c]) by DM4PR12MB6012.namprd12.prod.outlook.com
 ([fe80::caee:6914:7597:725c%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:40:33 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx
 idle worker timeout"
Thread-Topic: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx
 idle worker timeout"
Thread-Index: AQHbmJmDapqGWF7vyEWhX7mK7VOe3LN6AlRw
Date: Wed, 19 Mar 2025 06:40:33 +0000
Message-ID: <DM4PR12MB60124388FBC6CAB57163EC0582D92@DM4PR12MB6012.namprd12.prod.outlook.com>
References: <20250319063811.680138-1-kenneth.feng@amd.com>
In-Reply-To: <20250319063811.680138-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=46000ad4-85ab-4cbc-a6a9-d882934c8227;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-19T06:40:11Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6012:EE_|PH7PR12MB7892:EE_
x-ms-office365-filtering-correlation-id: c1e14c54-8ea6-4372-a0c0-08dd66b0f313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?BpK4cRfXCbTTlIBFKWCS8U/zGvEOT6gMtlgPrZGA7EOckruehuVliToJhRLd?=
 =?us-ascii?Q?OTbJipfW+NaThkY8tjcR1bjUgAAaN/G9/z8DxFtfqWKZX32XSpObIySThEmp?=
 =?us-ascii?Q?0pMiXfpM7lMPmPeIIQMggr5ZNvqSnF+9eDWm6C40Ty/IbT4kLuwOsYX5SbzO?=
 =?us-ascii?Q?l/+LSf5uebfeiDJ25ogdtHQ1kIyLxhdn2H9yoUoM2gXUe1ONVakwK4/nPWPU?=
 =?us-ascii?Q?W8xfZaiZuwgUy7U6r2As0rEk6na4O1DT1XxL2VL4zqDsT79wLcyGTUKAGjku?=
 =?us-ascii?Q?Zmms+tjL4VW+h1Xrq5YswYSS5UN8MIXkkXyHqTs2praSoWh0b6v6XVpteHG6?=
 =?us-ascii?Q?8eBzY7w2d/DOwdIBKFBOcejH78pNgvlQv1baSN46+79CL+n0FVHDMBUZAK27?=
 =?us-ascii?Q?rh1Kg3nqXmtV4kosJnErwDTF5hWiCFsHLNb4arx+F/QbJ51CslgegcKEqY7D?=
 =?us-ascii?Q?XWa/FueAO7ISKLUIzbu/TO6hUiQmQtPmfZnb5Ot7Q+0xah0Ba3nR1Pf/O/oH?=
 =?us-ascii?Q?Xbv3ksWy9ZKXI6L/vx/ONvaMfB+dWwN/O1zOfQthBAnPQY8eyWWl3pkhbUx5?=
 =?us-ascii?Q?/gBrImLvco/0vzsq6Gbbg/OifszUDuiQF/FXBqt+HP8U1ORXJB45QQnutwy7?=
 =?us-ascii?Q?uCnmG2LoBTYlOLA3PlbFLgConYkQ9HrtWvzJZi9q3nl+f/tAiqWIHITUDCM5?=
 =?us-ascii?Q?TByAMsLJvaij35nDIQ95YczUNuhLt8koQZuel3ClI2bKYt5YQRl/l4lZOwhu?=
 =?us-ascii?Q?76sYL8ngoEoo/46NehWLbgYSnhYrq0K5zsyFypd9JdHwczCGcFGzcdDRVRij?=
 =?us-ascii?Q?rFN4lEKrh/l6g+lu68/51LOroskiIC7F/duJ6nkgOstIVtMDZKhMjncd+eZB?=
 =?us-ascii?Q?DLdTfHrOUmlDIgsaSx/h6uJwnokOXLDY8Kx7U48jdH66FvQvL7MDC3+zPB/h?=
 =?us-ascii?Q?P0NBVKvKXCk0/JqkxcEII2wAIwoCfCSTqbcoYw/oKLI88rtxMLX/NWkB+7k5?=
 =?us-ascii?Q?ue/eBjZ2eyiB/FEvMGWGLKxuKnf3hj3yDtgoQEz8PdySqS3casYK50Hjr+n1?=
 =?us-ascii?Q?/tNQ+12QUHB6ZobEhFjS6uA5rw/ud0RAqIDR39c/0OMm1vpMquMgSVNK00r8?=
 =?us-ascii?Q?rMQApYGMY+B0fkaEFO9oRSOuUwevpGBDF32IJgZ3pgvj0B2GEqChm40RTTZi?=
 =?us-ascii?Q?x6iZSmN0GB+J8E0fbLxprN+e3AvQXnthUgDVBVMO3ESpuZE0nFlJ8HqdUbH0?=
 =?us-ascii?Q?QyLJwxve8zbNBSf2eRHs+griSZxdjkRZYkJ+m6kKPghzzKrk/uAU4rdwbVnd?=
 =?us-ascii?Q?6llpqUsTSMp4S3rkNDgbAYhsuE97QqFU72XFN594cQ+H/+7TKDsbIpLaIOQ4?=
 =?us-ascii?Q?eo/VKST3GHCg7XRI6pnbOhTszIH5R6ajVpZzDacaqzSCdDZRlkLtGYdnpwgz?=
 =?us-ascii?Q?fBDR6090kWrx3zipNt7mAog7aXVCFCti?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6012.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xteUgdb0SiWBDFPDxzBakgWNihkJsvn0Qdz6Upg/gzV0NOlHRAAOyaajW7lY?=
 =?us-ascii?Q?to54wczPT3fCtxEOlB0MVek364aFeFq1j5txdKFjTKy1xEmhAZi9r43CE3Gt?=
 =?us-ascii?Q?k8a9a+lLeN5cufTYt3u3FRJIi5rMUIQqV6FCvc+Ch6MHy9ylDamWCiyVvd6/?=
 =?us-ascii?Q?egP4zwSjKiRbv9pGrsgvNWF6GuFvgLMNtnwH07hyNIG6NPVNSHNCVgT/CQ8G?=
 =?us-ascii?Q?Jx+XTWo1sUOP3FpSrZhaU1IOlG9nJqBHeiLwu6/CqgwJjCb/Bo2VYQ4zIEMU?=
 =?us-ascii?Q?uORlt0v/AK9eX66nCeuxlicOU0LpGhkQ3JlTYgX/A4CxnhEw8Y7Dme61nx0/?=
 =?us-ascii?Q?uU+rRyCC+dnv4bskKGWSgPpW1xN3QzYTcaDq8oipXKQmL6DyRbJoWLW1xMCU?=
 =?us-ascii?Q?pcOcRgBckgCFWh/a0Rrxsz/5c3nS9LBMGgpvIXQUFk8uL+T8fHlnJbtBpuJS?=
 =?us-ascii?Q?Za0LpbYMnLEeFZR0TjVb5+BFJowd2H8NmTasXGMd+h9zZ8mHeWJ1h4fAs6XP?=
 =?us-ascii?Q?xUhf1Po8nPwO1Ga0Oytr0AVF9kYrDVL2P2FWGoFeNOaQoXJaSanb/HJkDLdq?=
 =?us-ascii?Q?sGMF0Jx5zI4aSTrXKA6FFJXV60oImJpxAoyYSbqaDv8C1JNyZaUwj40XXkH3?=
 =?us-ascii?Q?8IXci2AAAVx3walwCadIdFFE3z1YI77y9q8ZpP5TyUVQJQUS+JA61zCMT4DZ?=
 =?us-ascii?Q?CxUDVcygywlE1iH4zaWh2ByxZLaa+RmAPjhIol3BcPqOCqifluyKpbxNgeui?=
 =?us-ascii?Q?8M0HA5X71gPlhZozyYVT2g7Lqzm3V2B6wMjaOZYLV+ENjin0XF0BRU1YOv3j?=
 =?us-ascii?Q?mW2EfYk0yO/EpVtuMX260YNT42xLfqbbAs6/wmLh/A9uSB81ywdVGpSZRhm/?=
 =?us-ascii?Q?wwFtc7XZLccz36tvR3tAq+pnrSCcI4o8LeGD/GwgUsTo7lgN0vNaisJB1Yjl?=
 =?us-ascii?Q?2xrWTIs1r1teTcfnS3+/WljN2soPOjykUdqxaPZzPMzLOJg2ypaPTGqFAI+s?=
 =?us-ascii?Q?gPwvYKilRCWc6aqWtQqd43z7SehgpNLT6jPRsfraKOrJfDwA1VY76yNsYGGe?=
 =?us-ascii?Q?bzQpIieL5by9axJfVRrecO82tjCfRMcgK5wqJRyLGlYKHhU/dsq9zRhQrl0n?=
 =?us-ascii?Q?ktytfb/S4DZoofnSdl4jPOqb+A3wlLG9k3mIBml9DqNjIohmvSPmYe7qEUPS?=
 =?us-ascii?Q?qqn7ZLdp383Lk0nWo0fZmt3V1EwRKxuFZ778TUQ5bkyEs5Wrqf19oNvDMejj?=
 =?us-ascii?Q?/O7d4bi/M7d/cCFiqXeAMRuQnQbKRiAstw9qy+0n5Was+XwIOX0YyKpu6dc/?=
 =?us-ascii?Q?j0sQCQzq30jk2Mmcvo9xbqVFHIJWN69+/fXmY+oFdu0psxOUjxnm4+9XoEtE?=
 =?us-ascii?Q?AM5dmu+OWB3H8WSK+M7q5zSGMP1sRM7LNsPDoJLESnTtDgUpvUPuCJc758jR?=
 =?us-ascii?Q?ZfnM1aEKCMk6g29cmnip24WsouN1tOR+iT1QPEGb/mCtXMj9gw5kzmSfCr87?=
 =?us-ascii?Q?JuLmC6SkhjOJ0nADBtVwFZaMB0Q6UKK+g3m/yUkFKNjbpqMBAWtyujdMurMs?=
 =?us-ascii?Q?300lwBuCE58lgILG6NM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e14c54-8ea6-4372-a0c0-08dd66b0f313
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:40:33.4721 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXYEyazL2phZuEw/am1PXIL4J90xSzRcbx4y6ZhVkKQ0RAJaAgLppmVLrzGwXu1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892
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

Acked-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Wednesday, March 19, 2025 14:38
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Revert "drm/amd/amdgpu: shorten the gfx id=
le worker timeout"

This reverts commit b00fb9765ea4b05198d67256118445c6f13f9ddf.

Reason for revert: this causes some tests fail with call trace.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index a6d3a4554caa..75af4f25a133 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -57,8 +57,8 @@ enum amdgpu_gfx_pipe_priority {  #define AMDGPU_GFX_QUEUE=
_PRIORITY_MINIMUM  0  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15

-/* 10 millisecond timeout */
-#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(10)
+/* 1 second timeout */
+#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)

 enum amdgpu_gfx_partition {
        AMDGPU_SPX_PARTITION_MODE =3D 0,
--
2.34.1

