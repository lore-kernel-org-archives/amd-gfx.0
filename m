Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021E1C5DF82
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 09:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861F710EF80;
	Thu, 20 Aug 2026 09:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="akJumXt1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012060.outbound.protection.outlook.com
 [40.107.200.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 593D310EF80
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 09:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mjux34J4YsuvTb2QdXcjqO9ItBUzCc+SXSh8RgP+QMlMljDKGXbBtCdOpbYTNDWrqJowFsrYbCjrPxWw+fYKZ8fWTpHamv+Vzc+WAdBLyYb3ShGqC3UOG3X/xddE+uPJd61JBLPXvNDk+3PmhTxgnEi25mGGPI495gpvyENjw4bueFR75lc+g9SMC6rfY1/q7wEWklOGgDM4gDkxvdN8IJXDjHOGGu1QTOh7+8HL4ki/KjQ9WLkkvyOjSX46B3yryw4eZD1p1HQ0pmLDmN5WVXeJmDSEE22CN1U1mIDp7mEf48xG7aPU20jog7yaePaHy9GJs5wp2j8UXe6oP8KkXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO/S+MVz19in/kR1JaggLXG/KrIylb91mZN5lTimWJQ=;
 b=PlMQ520aL/2nXAB1RIhDV8Exh6hL37moyBF0WZri1eYz2x3VSkncpyD5YHEScvQK3E8/r7SsOWFpkxEgQEUXA4jRUZJemPaCHSgFGnEoT0oPKeZ1wMCDCZi97Ai4N4xc3D+INtfCizldx/Xz+RMKE3YWbFlJw0v9kI/sn31MPsg1rO1YJ2z7oTy4HPBQomsjh2EeCECf9UE9gJmid0D1aucgaiOrpjjxSLlfSz7dyYDJb/bnd2tfSlrP8tja4kVyxSbhFWJg0wccnKFmhmuqgEmO2ZPIDpg/ECKsjjNos79uO5gzf5gU0h8PngtxO9XY8ZflfnMixYHOd90IE1NFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO/S+MVz19in/kR1JaggLXG/KrIylb91mZN5lTimWJQ=;
 b=akJumXt1l7PPPXNulLSgLECfxWYOUDaJw3tokxtlWWx/p0f2bSqpMvj+2nXilnMVg7Bh1N0b4+X5ZMxyQITfp6ihTdI8F9XUYYKZJYDVa8m7GQX9GASDvIQIR1gEu+TKloBe9v3Z+2Wq88BCrbzEN9m57ah2Xloknvspq68eggk=
Received: from CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:26:19 +0000
Received: from CY8PR12MB9035.namprd12.prod.outlook.com
 ([fe80::dd3f:35ac:ef0a:723f]) by CY8PR12MB9035.namprd12.prod.outlook.com
 ([fe80::dd3f:35ac:ef0a:723f%3]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 09:26:19 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: "Zhou, Bob" <Bob.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD
 rings
Thread-Topic: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD
 rings
Thread-Index: AQHdL6YJC3ZBGVMLdU6E9AWHveRBWbamrHfA
Date: Thu, 20 Aug 2026 09:26:19 +0000
Message-ID: <CY8PR12MB9035366BB0F12BFAC611A42AE9A42@CY8PR12MB9035.namprd12.prod.outlook.com>
References: <20260819064313.3609274-1-bobzhou2@amd.com>
In-Reply-To: <20260819064313.3609274-1-bobzhou2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-20T09:25:46.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB9035:EE_|SJ2PR12MB9114:EE_
x-ms-office365-filtering-correlation-id: 4e490159-726c-4efc-45cc-08defe9d17a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: v6OsVSX+Iy0dMFabGYSrkimMCfig21S2J2KGH1bhtvUkBvr1cpMTBkBKjMQztUw2tTDpRrRwYdNPa8mAfWW2viuePdcbbctXVrYhumrO2c7sYNYQ9Y9p6kujDMYdKMlkW+OHSKeDsO0fwVg6wo0Vk+iWtCsIzcE89kiluDQPhWI6ZgsjLyhpz5nCq8SFQfAOOxg723NJjbhvWppJMaG6tiO1hdxwB9QmygzxhabZm+zfOeKclSxfHlv2KEa3MU0uKDPZEW3CMREd9Je+c8lYjL3vmqVUJYJ79y1ae95BP66rpECLswwUKb3ONN96mDXpqqVi657Rmj+xorpHoRoKvajSwHwucZ0xXRv4y3X8P47nUcdA2k6IJv7N5pYyRflvNYtxOqX8M4o+G+srQ1YNPWdcqbv/Vub1geMFC2lbEIrug78jDAMg4hK5evnmixSUZkhSvrAI8M8jCObj471HRIhzBRp5NYVdITi7uuaLVyaL70k6PG2Kwmx869pyHkFsFwvhKj/cEAeK/IYLdtLowzbrsyWsrHK8pxvC38P+FOsPaYQ8IiMUczXUT+eMtcYIifgA/OJ1Gms3CB76UW5R4BJb/NrS4AXlNTqmfbQp7g4FIBJjJgJAB8kwarswHLe6H03nKCIMZg22jcoYjgWqyAXD6NpUUDQRQe3G7fAieIArwnahCh0AicshbIEErQcGUfGTUfX65o3NkB6vf1mLAtCj5KZ3hrh7rKIWBlLnyG0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB9035.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LPvVV3+5tQ6FZjwbXlHCytWDrjBf4BcK4UQgF468713Ya2buSNq/+E9yczRL?=
 =?us-ascii?Q?dVvBvTYlogFesooJ9uUIjmIWMs0/OGnNjEgrCLOHjakXPx7fJfv+/hkhJOqS?=
 =?us-ascii?Q?rFcHMRHjkE4NHnFYBxkEDs84aFN8lkYku6uZ7s2FNy3cpggUCi+/vdgwNJ2u?=
 =?us-ascii?Q?UfH3ee+Elmptoey9UiNhqcO0GJyV49ZpSxaqtKT8ZXdzrr25mj0kyfmBuiou?=
 =?us-ascii?Q?Jywwv1+joAChyXvSsYw71YKNJAwnCJ8KUJcW3vYUuTgr1+xQmq2ldkFGpY8Y?=
 =?us-ascii?Q?fKkk35sJlbesfK5gM3tok1a12rzjw0GUU23fTVlpEAcdobmLPaF4om4QfUGF?=
 =?us-ascii?Q?i+Wwf/pz3/YbRQgLnFkk8fMXlxoXADmSCQwgigJmwjH2HflYGtxzz5HMpewN?=
 =?us-ascii?Q?WfGZjLz8FAqv7L9dPdJ+nisH1WgLNNG9xhffCqNi3RadrkkjB1YiRbPQyNL7?=
 =?us-ascii?Q?wLiG7QLdId3AltQRkbFxBv+ZuceJRhAgbhVs9598u7rMU+uvLQzAdWI2VX0J?=
 =?us-ascii?Q?guntPayikb3ZKeVxQ9Q3qyO0CYAmbmHOCG0hN4VKAJjnQXKxiLSZoCW/YEKQ?=
 =?us-ascii?Q?RVhRwBhXrEvv1mgzwBLt3g1iAU0uzos7SGkviC65rhNZtxMSkrayX+JITkKO?=
 =?us-ascii?Q?8+V9zIiXYLyQgZoz2FSPndMvN9Cx6qF4cUYCfbhKMvPw/19pfaiDUr/kfbFG?=
 =?us-ascii?Q?xu+HquiGxT/pa4wlUzfNN8zs+ldTVEWK3dzjiqJciQTvnCamzxUGiuT8cjir?=
 =?us-ascii?Q?R4iYyPVveK6RXDljTuGblMPTvLrJQNta0cDOIsTLiznmjzpbFRBD9mH2Bbhg?=
 =?us-ascii?Q?2rZ5I/NXlKktoZcdF/5w5DVng6Ve64uc1kCUACiZyboCiDP7ZtVNU0SWyBEP?=
 =?us-ascii?Q?OOGa+PVBLMPsXhCsltWo1YTmnl4u9nzfjqTANM0otnUumxxLuKxGs86Tn/R9?=
 =?us-ascii?Q?OgPfph2Y/C8C3JfPcTTfruPTdxkWFoJgD33XbL2w2Vd4a+ii5sOon5aX6Dy0?=
 =?us-ascii?Q?6tgASIURrgWYqf9RqtzOJkHRpfkVZiXUun6Zvci7DvWxlH9G+mKVD+muQtd7?=
 =?us-ascii?Q?sqOKah5ZuGwvF4W0lQsGlRKm9sIozsANCf7fVMjtzAx/0VylDhgAKTWjpJT4?=
 =?us-ascii?Q?Pqqi7yX/05NXoK5BVsnVUn52mb+86Q9DbERgSewyN0wt9/Zpb6hq5oCfwh/G?=
 =?us-ascii?Q?TWcLHpmivev6YCxoxbZzFyK8iUXS4SgO7op4nKfZg+0fwXNPZ18dYJ7YCv18?=
 =?us-ascii?Q?Fz5SbXs2KaYxNWlnK9VEkMNS522KVBPfk2Zmwc76Lckez2F1BYsVSI4XuzZo?=
 =?us-ascii?Q?Rq6mFdkcbz/LLiI7TE2fkex3/0b53TGrS3KSwF+CIIje1OLwUqJRb9Qcniqj?=
 =?us-ascii?Q?I5TMJzbCaOA8h36n/ic4PUGZ46NHtG/jAW2LQq6rO3r3Y9FuXxBKyj2917VX?=
 =?us-ascii?Q?p7FPBUy0SoS0M3LuXQA3bWfSSC0NQDwKO3dRM5b0/9fLDIsO/uEt706F2qah?=
 =?us-ascii?Q?jVRqEHVZbA+kckXvt3mtsRBagd18IPAnhmmvJu4TdxWDb5yVf4IuWY7JvDRp?=
 =?us-ascii?Q?Rhl6HL/YOOx8VRokMxJcoAUMo5uOClOfLNkdxe3/CS6xv11NyI1QKrS4qPS3?=
 =?us-ascii?Q?FUN2R0/ihGv/oUXyanQr8bUAlXc60iqgNHmXyFCx+uVleF5zwzU4yQLtesh+?=
 =?us-ascii?Q?aIpMJA8+yLVez/sEmaVL72qCD1M6zkt4gJnhczR+weBnz/Bn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB9035.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e490159-726c-4efc-45cc-08defe9d17a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 09:26:19.2847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArxbpApayCM5Bu92lLwyVHplvW7IOsS5/PniHAcE6vBpLYkYVw38JzXgi7Hc6qj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

AMD General

Acked-By: Frank Min<Frank.Min@amd.com>

-----Original Message-----
From: Bob Zhou <bobzhou2@amd.com>
Sent: Wednesday, August 19, 2026 2:43 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Min, Frank <Frank.Min=
@amd.com>
Cc: Zhou, Bob <Bob.Zhou@amd.com>
Subject: [PATCH v3] drm/amdgpu: avoid force-completing uninitialized UVD ri=
ngs

uvd_v7_0_sw_init() does not initialize the UVD decode ring for an SR-IOV VF=
. However, amdgpu_uvd_resume() unconditionally force-completes the decode r=
ing when restoring its fence sequence.

Skip fence completion when the fence driver is not initialized.

Fixes: 043f2271e2d0 ("drm/amdgpu: mark force completed fences with -ECANCEL=
ED")
Signed-off-by: Bob Zhou <bobzhou2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c
index 228a405a94c4f..ecd7caa95d4b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -517,7 +517,8 @@ int amdgpu_uvd_resume(struct amdgpu_device *adev)
                        }
                        memset_io(ptr, 0, size);
                        /* to restore uvd fence seq */
-                       amdgpu_fence_driver_force_completion(&adev->uvd.ins=
t[i].ring, NULL);
+                       if (adev->uvd.inst[i].ring.fence_drv.initialized)
+                               amdgpu_fence_driver_force_completion(&adev-=
>uvd.inst[i].ring,
+NULL);
                }
        }
        return 0;
--
2.34.1

