Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB0C04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 08:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D4310E2CC;
	Tue, 14 May 2024 08:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYK8mIH2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F80610E2CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 08:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROnWzIDQ5HhVapWIxm4lMKYqSOi1ud7JB+IMNIQAdCDwhF2d7yzq7Hlo1LOlg3cFuGy1eyqerU8rQG0Y3UoEbEyQYdPY58XGcAvdmuTQHNSng/C1cok2lLxRWMcCJgsSNrbE5hF2rZb7PPmIQEPWzxhzedbloIoRBG/l9EaOjX1SBKvEDddV+lEPyK4I1OIjDFEbfs+w+r2d+SjVTmJmkAtppALlKSqAN3vx/AGGFSu0qwuduHtTI1qVZfIcFR1piPCCcGaGyXcIFbRonbhhuGGo2Vbh/Emkez68QReQg+RhmyWp8/lZ3TMOkxA3anOquqvrT33bN6yDfdfcEP5+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFjThnWmtmNQrn0g2cyFb0PKEDUG4oGisNgjMCca7MY=;
 b=CELQsX+704BDqpGMg51hQkMQZtBNotuGTkB5FQr49ZFaBqhOKJN2toPcYoW342oqDQqX9TgUzdq6sqXmIlsRpFffgYm4uuI1X/vKl3zCurCTcoNNrQlWFVQul+XKi/ox6GS+IHzmbv+h1RpPsC372U4Yb+q5qlSzd76CaPcdEF89zWz4mYmdLxyDkCHuAYOtHyhbCyotqmIH6rdRT5w+dQIhN5EIdO9Ycyrla4qfqMUEogLv3lbHTvEOuaORtbZDvpRTWRRi6HacUsoEjM6/HLleha8Nlx+mj5CSR5vtPm0yBzHAaLKRrcgbsQFnY8lf944HFK72N0wvZEVfhb1oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFjThnWmtmNQrn0g2cyFb0PKEDUG4oGisNgjMCca7MY=;
 b=jYK8mIH2ZoZ8Yc4wORbQbXV0aZ9SK5ZVdfvje18bm8sSgPs/dGJpGN6VUqMvJiQU5IgVkDj9roeggYB59y2Y6+3jH6azRUnDCAV8lMHg74FtIBHv7m9ggsbYPzSTQu177ovWhKDEmva6XG8CR+yudmWrk9lpfepuXazIA7rSrK0=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 08:50:08 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%5]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 08:50:08 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: FW: [PATCH 2/8] drm/amdgpu/jpeg5: enable power gating
Thread-Topic: [PATCH 2/8] drm/amdgpu/jpeg5: enable power gating
Thread-Index: AQHapdt4K5g6xF8NEEOqHFnB3nQreLGWa5mQ
Date: Tue, 14 May 2024 08:50:08 +0000
Message-ID: <DM4PR12MB51814096F329F6472C618AB1EFE32@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240514084751.3438103-1-likun.gao@amd.com>
 <20240514084751.3438103-2-likun.gao@amd.com>
In-Reply-To: <20240514084751.3438103-2-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2f5371e6-1c35-4058-90d3-67479c9abdd1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-14T08:49:40Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY5PR12MB6154:EE_
x-ms-office365-filtering-correlation-id: cb1b9f3b-0ced-4923-1754-08dc73f2dbb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?HKT/ncoHzf97vQMamb/D/i32vpYshggwCkd+0qVi8Cg2mDlbGlKjpW79JZNs?=
 =?us-ascii?Q?4Ok+x3LibF7Np3BCgERc2Rp/YDejfAJo57DRFYvhS46pnVTCCAJHxj/wFvNt?=
 =?us-ascii?Q?TCOnClghB0EfVwuXNcuC737qAoHDtE2WSptpospyM9cR5LMAVYjPTP/1t+DK?=
 =?us-ascii?Q?CMR5XAWvy581xrw0BUQed04kxo9e8jh2EjCAp9tZlU/+AEBpVJmouWocIQSL?=
 =?us-ascii?Q?wlpSxSxWqbi1T3pzamHx6cxAyUmTumwQUI9cguup52el66WNX4Vg5K/xMvMI?=
 =?us-ascii?Q?LI/9046KkCAqeh5uw51pFow26LHjXYzrFBXhLWQ4OwHsP6Q+y4/ac6OTbvSq?=
 =?us-ascii?Q?/cPqJ5Q50O/czf+riUz3jVG1Z9wJeXEw2MBd/UXD/UMgIWExTAz/oWckG4Ri?=
 =?us-ascii?Q?W+Ynzz1zrgiG40PnXn60ksD8BlPRD8MFIx8mqtaL0UZQ/KaGDHWB9DsHx5+M?=
 =?us-ascii?Q?N/bUqqyfzbh0LJr3uJsrPx5S3xAm6NNLAiOrb6ZfK3gU99Ls3aJOOhfAhil4?=
 =?us-ascii?Q?W0ZSCROxSy0BBRLgr3f3//P8JJOWvvSdL7K4z05/kOP8ZvLwMm4tLEZ7mJCH?=
 =?us-ascii?Q?kmCW8TM9QiGPxzDxBvthSfHmmy8WUzJCfeMyx3UTZhJDGFRp4wo237HqTP7x?=
 =?us-ascii?Q?J2Ls6Sb3vW57gxo6LFSKvwOR8DBQLoZT2yNqHa/hQOf9XQdMd8B8W+xt5+2Z?=
 =?us-ascii?Q?K6HTc6hF0VYEfd8HI4kKIR7gq5HfjBNIErS1Rv85Tneikyd6YRS7lOXHAHfS?=
 =?us-ascii?Q?TwDoMuy1oawbjk03Qi81pLHHK5f/T9y2O945cK3mpY6Ab0uI6OX2kESUmC2l?=
 =?us-ascii?Q?H4l0xPpclyPHumwWQpGJGAu4nKF1f4q+A+yNrUI+KqA7MrfkCKUGwKviTOSG?=
 =?us-ascii?Q?TeKnPKyjrYk0s41VgRw2fuCq24SAg3EPMcEHAuwbqhU/vzSrU9iCfzo3CWHt?=
 =?us-ascii?Q?uhSpp47/rwFYugwRXpdBKApaWzh6f5ts5c+V6nz3WYQ/s1EnSAKlgH8w3wve?=
 =?us-ascii?Q?bxLeYNxjr5o5t+oqwHZ0mvWIbG3d3qofnUhgv4BWcf8Pw5z5VUtBfTvXVURb?=
 =?us-ascii?Q?vO24IQUZ9bDZDEryZzz9WSEdXY448Z4xIDdcjD9kfp2QLId+55f3Wjd0tR8Z?=
 =?us-ascii?Q?wqe5G7OD/cmgP7XAOHgsLYc8KTCMhxPxJGVk/mxUoOEr3NuWvUQmVBWx5QcV?=
 =?us-ascii?Q?qMCN3h/NbvHgvL/Z8grblJmUSM+ubC12Wruw45rAuu0Si2CNhZdsAX7EXQsV?=
 =?us-ascii?Q?LzMErOAs7AHvWj0/Wip0J5RFzA/t2oYoLFPjCHurHlC4SGo9X2a0MdNQ7gKY?=
 =?us-ascii?Q?OvbtkFr64f/n/ma1xbbml16qARni8Td6yGNrYaG9DP6Lsw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lrw4n/eUWEW7AZwTtyjAwKPKwY0nUNEQUDinxq7+DsCsOkxethACjqDD+tgU?=
 =?us-ascii?Q?LBic8M0bzgHgcG0ty9dSeeqRWEV2FAcjXFq7OcAdzFIs0Y8WqyOuoVXS5dxw?=
 =?us-ascii?Q?S2m7h0ghuhDAdi3R9rAGKy76udfqjn00lXndLOe+KxrSfcXawTt7uMcH6YRd?=
 =?us-ascii?Q?JbbxyWjrHSR9livlnwoz5EtsvL7nuA2uxMy8n1aq3HMjlbsF9n8EUhBIHhWC?=
 =?us-ascii?Q?/tezHZwhnxEgtcXZxSYvvW7Dgv6GLgQuixVLA8YCoNrSJbMo+05vfXKH+4xo?=
 =?us-ascii?Q?ml4hXfxzWVqKvTe/qBJ3Tw3LbVI0W9OFeBoiNYLUrs3vM4SutjVV7JuXl3PU?=
 =?us-ascii?Q?iFo9kcuf919PLE2RZ18XSsm8ueH6+PzlxSDNNmXv/BAAFN4kvnLtPvwV6J4U?=
 =?us-ascii?Q?e9Afa3nFIyMtTXSJVFb5xmNnJ5FiZuuf/qGE6kZlmzCDYSbcLrbtyBbzMpLu?=
 =?us-ascii?Q?65leqJycyRkOCjxOnyQycIGGnY7092oNu9zgIdjWZW7hjPIJJ9ui3mQs0zb/?=
 =?us-ascii?Q?YfCcW33HY1yG0Neatz0Ik56NdORt2FhnFDUL+aDzGmxL23TSq8If4JgT3+Y5?=
 =?us-ascii?Q?NqLS5GOxWWoMfD1mHHfWE4+4ujhFwxu6RNvyVRf1gmA+F1NW01rFjdAA2mSe?=
 =?us-ascii?Q?+dpZUCYTio4TRVRtUY2q5REZ6zc+Fb5/OB5MkNpbSSLA3AQwN3jGHBkjyJuG?=
 =?us-ascii?Q?FFVVd/VMtu1h+sjIL9f8NLzALpmd0eexIpIZEypGoR+pYH62Vpuh8a0U+QgQ?=
 =?us-ascii?Q?jWokd/OJVxnMahuURaAPcH8e+wIGXqz1+M+HvI3Eia2Ho7KKMCZlWP4LIo1A?=
 =?us-ascii?Q?k6sZpVAQNHJzvLtBQaluqkI9rJsBFcAmNWU8W5YZZ3VQ0n3eNMtgX897wL+3?=
 =?us-ascii?Q?56ZbKj2gPQsSqaW0zwRp5ypvWRzGLzteiz4TffTazKhiAqPpBfgIPI9qM/ea?=
 =?us-ascii?Q?wz69F3hpJlbMLVRKmRjp1UX4vm7Chh5tTWOy+62wtO8bNk40/90ILmxTBihK?=
 =?us-ascii?Q?4AcjBpWwiDY1UuFq2O71twrT2j+cXNkGXAHX1f2IogVhIr+tSnQmFRA89Z3x?=
 =?us-ascii?Q?d6K/ila8JWgeLz6G9+rrVLAEBLhiRmFFSVulbjoH75oon5UR6iRpSkwrTTlL?=
 =?us-ascii?Q?BAmQh4CCesetoOAOzxEFGoZTGId86edUX1gs7ddRCo25He3VfKhmAk0MogSa?=
 =?us-ascii?Q?rMU+712NwcUrDICmnAGB8jpuv0iLRYiigaPrkwC86jHn5bde7vYKDX5ZjOXu?=
 =?us-ascii?Q?uXY9CilyUqdy5ee7It5LX8L8LIKQNcuzzrg8ZyqA1+tf+vBrSkTfqjlZKV6G?=
 =?us-ascii?Q?nbERdtS9lFyWbbdxwA0hKXCnEQzShQ5grnvB8QwoaPktYaox/cTbOYpLqL34?=
 =?us-ascii?Q?B4qulUGZH0i0aWCMb5SsjlJlMqxc9QKrQAj+nvS8u1+oyDzmXT4d47fatnTl?=
 =?us-ascii?Q?0Ed0WNeh93HaoJznQqAzQzqn3v+FI13x4BWBmsZr+55Wjcb4wgGI7W+AwuVP?=
 =?us-ascii?Q?xmHIKvFoEvBYYaUqG1fYxXwIDiePbPogvbmTXd8lIAW0sdVcDIMTfn4cflKR?=
 =?us-ascii?Q?2Q6tOdJI9ZBfescsqnI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1b9f3b-0ced-4923-1754-08dc73f2dbb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:50:08.5141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFAeX/+kKIO9tlbfCRWjOc7Wqw/fMqK8RBjVJJTqpukDceYrc84qul9mRm0PwNWh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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

From: Sonny Jiang <sonny.jiang@amd.com>

Enable PG on JPEG5

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgp=
u/soc24.c
index 285d6af10f62..3eb6574b777a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -398,7 +398,8 @@ static int soc24_common_early_init(void *handle)
        switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
        case IP_VERSION(12, 0, 0):
                adev->cg_flags =3D 0;
-               adev->pg_flags =3D 0;
+               adev->pg_flags =3D AMD_PG_SUPPORT_VCN |
+                       AMD_PG_SUPPORT_JPEG;
                adev->external_rev_id =3D adev->rev_id + 0x40;
                break;
        case IP_VERSION(12, 0, 1):
--
2.34.1

