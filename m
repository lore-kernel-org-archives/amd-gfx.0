Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B71C35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 06:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1BE710E96B;
	Fri, 14 Mar 2025 06:14:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k6vQVpTu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C12F10E96B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqjdOgdc23Kl8sVpPOyCRf2/wKpzm4YFZhPU41MA5F0kV+EDKSwsgit4a+toYbNpijCR4lwcSVF/QFrQzS2wPREb2V/5YEMrr8dm18ziU6+DNnjIWL+aOTmzlMeMKOPVPuHXZ6IZ7lolua7TnMoi2TXwcblIB3D9zYbCtrqDYjb+PW+WxGl2JWOujSehuT2u4yqbuVhTXeVKG5llYw6peyBooBbuLKrFsQylBs8A6U2UM9N4pB2bPuABAsLiNtkgY9or4yfQhxnh95IVZasMICZXUxeylwWo2TC36osqkW+RjONtBtpqNCi/v2VlZaksOGOjxEHH/sAPnQjPYYt/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STqD5d7ZBjcEZnsDLdt23J8cJghutKMU0zM3iFbWyUg=;
 b=lFaXa25DfY4yNPTt5RJ2BlJ4wyZkXcYlqPfkCwhDZUpp1pnMLo7bicPGeIl3OCf2zeLTbepHwZ7i01UnTT59DGzdVJkNyMbTD/v2mAWgNQoxIdljrO6JUkDqWPKTFYdnYnv6iIHRf/Heb0bleeGizpu/85o5c3h7wEymRaa8zPI9lwWzbSdTx2XqDk5YBoAyo4swWqYZtljgU8YoEhZkY0IQsPQfUy6TtFMxOmcJpmgn0ijMIrOM9dh+XvTy9izX08+6Pg2Pp1cA3gALnODpyO9HFbFOQ3nwxhx8RHBRsclBpaHUxaRCxIxkVpSeiC+tHtF3xXSJiz5s7dMyZkVIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STqD5d7ZBjcEZnsDLdt23J8cJghutKMU0zM3iFbWyUg=;
 b=k6vQVpTuptUdBiRgZGHFiQtx+nhE8KNIRz0qU0yFv2tov+FsjwkYLqv1MTh4Z9bThB9nRjhhsPFRtSW4rDXYsO7M0u5P9vNq1R489DN9EPY09ke4/2aey+RtNNTCyprQNznSU5ONOWIF8QaF/tUj/1zZEJtUb9yNWyfda6dMiXo=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 06:14:05 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8511.031; Fri, 14 Mar 2025
 06:14:05 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
Thread-Topic: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
Thread-Index: AQHbk1nDeSZFJhwA+UaOaQ2y0Cci8bNyDqUQ
Date: Fri, 14 Mar 2025 06:14:05 +0000
Message-ID: <DM4PR12MB5165A3B28ED10480E2BF6A4D8ED22@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250312141912.10994-1-alexander.deucher@amd.com>
In-Reply-To: <20250312141912.10994-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=33a164d2-81f2-40fc-825a-c593ee4f183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T04:36:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MN2PR12MB4157:EE_
x-ms-office365-filtering-correlation-id: 5ad3d8e4-2433-4a47-e108-08dd62bf6c48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?FDeVdz3VWjdhWDIzJutZnLa58XzcnJzZ9CMuLgRGTJ/+GWWK+47yknvc39HK?=
 =?us-ascii?Q?lBuYSAoGLxBAkdi9UOpPu0Lfx0hi2Wtc+ZHfIUKb8FGzThs4FpA9JWlDKP/4?=
 =?us-ascii?Q?veON870Z+cw1K/t6A1dx+HUzyG9zGBbMJRqYm6HouxpI7zzRjuKVI7+/Xh54?=
 =?us-ascii?Q?CSiYo3C0ljUitTGlY9xjKDM/YaEvQwoAqbobUjdQxusIEw49f1smZl525Z2C?=
 =?us-ascii?Q?P4YJaBIo4e0yvBY2eLtopWArija79mJqCO04DWs3II++1hRnKXXo/fP9gHn4?=
 =?us-ascii?Q?9FU1cjLfWoOxPHObzWxAf+KilDrxslq9Xv8evaGNvQOo3FyRgQJ0Y2bLi9Ha?=
 =?us-ascii?Q?F3BwWHdMS78PtNUOoNtJ3Dwt59a/CSezrlNQuFGaYj8B12op9PPF5NpYBNd5?=
 =?us-ascii?Q?0ij5Rk7OG2cZcaKva2eDRTfKZ+jLC//TZDzlsQ8h4NNu6agnfu2IGB+Uj0/k?=
 =?us-ascii?Q?62kB5shB+n0Jzkpi2OKzZ88l5V+WLhdtecL9HfVe788SQfvGSRsrSXeNtaAJ?=
 =?us-ascii?Q?A1awbXu/iPz07OxiqEJfIGWhCdF5LM292i16g6Lpxnja1ICZOsfHhdYf1nqi?=
 =?us-ascii?Q?evq90uazoXGDWcEbQCk6HRkuHyth6fkcpa6YjffdqFdo7C9y2naMSj9E8oFe?=
 =?us-ascii?Q?GDfPwa4G2utKBXuZRWJRKQ6fBiK1SxoYMcXEVjDmpMhN3J80+Pp2AOcuiqig?=
 =?us-ascii?Q?dp6s14Z9aGcsygUBviI1PM5LRqP5w6bYhPbB0q6zIVKANzp/iTk/GM3FgPuL?=
 =?us-ascii?Q?xvrU7x3cMxWNVd/4UZs7AVQic0NeEdDY6kYqEaLXC9DB53mie8x8DsGNXD7r?=
 =?us-ascii?Q?Qjr79jK+HpLc0+ohQTq6rJveAC8wNPg9utQiC32u+apRn/KGM2SpjZ+SikuQ?=
 =?us-ascii?Q?2eHspwcAQmhQS4Qa0g+6EqGEZNyAAKe3juV8isffhDya8FyX/3EoTITYR52w?=
 =?us-ascii?Q?bKdZpK2cCJkoBs9yphmQnbsaZE+hn3KUtO53XTBp/apypBgpGW0nimtyxfvQ?=
 =?us-ascii?Q?Te+dg2s+fMpusX8AZzuxfv2CWqo9cA9a3JbRKv2NaUGqSrCGAUHoFrE2f9Ut?=
 =?us-ascii?Q?gkceI+5GKsdXJGdfE+B4KoqKdgMfA6UwZQJGnZ9giWmsC9A6g4/Vip/2liBd?=
 =?us-ascii?Q?gGMyRBvw1JMBwkvI6b9132o4N8wNGRJ9XT7jmqIUPpin8bFSwytniVHg/NRj?=
 =?us-ascii?Q?3vBFY7abQSj/JdNo1DK47tUxIpgZwz+nazLcFLLvfBTDNGXWFAidFHqA5RED?=
 =?us-ascii?Q?pgkJ0GwHgt+KD4MwEQfKOAFMR5CLz4BaeOMR1k5GXl8O3Nb+8kOzqw84Dpnf?=
 =?us-ascii?Q?Dbq3G6igROtGFKwgz6V+OPxqD73UkzQ0uxEuGUDaEyQzpYI7im6qymAgy5o5?=
 =?us-ascii?Q?0dd04l+ocDAawxfiGCF0Hp33dqSusL2vJRdcZbj7xaXxJ3vIaiU9yw5ZnKcQ?=
 =?us-ascii?Q?eBJAymZUZUY8WSSUwTOhk+6dAeAcJv+F?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NaEPAa2nCZPh+vBc+/kigR4QuEyjD6FBVA2fUxL3fjbzaEAffb4+a56BoTkL?=
 =?us-ascii?Q?4bcnqo6chQwTRKIg+1AGzb0fp8FKsNp9Yzwv4CtNEB5rel6hYRFfook27GHJ?=
 =?us-ascii?Q?Vfs9XxhGoiUfD/r1aiij1N4mcc1YBhKf0M2etmqOAOUpvxWLRWg4JIZ+1PCN?=
 =?us-ascii?Q?YX1j9CQBGGeU5PLJmlUA0eCxodtYjRt37eKOhcoc038cywtGt1UlWFrpzWOh?=
 =?us-ascii?Q?4kXopAeaR54mmcywfG1046PGR7UI8ZHp5QScVMMkh1B3n6bRC1bDCTwWgamG?=
 =?us-ascii?Q?m0QT951gDqKdp14G0a+IqFWLUzzuDxIj51vPja1yiD74COIAoN10sTw6zoZB?=
 =?us-ascii?Q?KN6p0lt1en3dTWfxKuPaeAh4dyw1pYZTGn+r19ItCQSCdMb5F3B4ErDEhpQS?=
 =?us-ascii?Q?BwKxyY+qwP7UWgfhvQPuph1sEfjJeLxSUpsbmlgGf+l0ac8u/N9v+yjzplUP?=
 =?us-ascii?Q?r3H6pcyWSgsPRAs1+XKzx7k3I5L40gyU1rh71ym8sRkQysEOd3UWtguKB1x7?=
 =?us-ascii?Q?2agAR9GB3Y1EqRj7aOT6WAfPctkVApmgZpVlBMwUNbwYDaM3qoz415NXqeje?=
 =?us-ascii?Q?Np/soli1wPJmrH9id3TqsnzdfqdHX8RbLGhmo9elP3yaT+vrYOfUbvzCWoL6?=
 =?us-ascii?Q?Tng2ZNYMM30FyC/5+GLXI96oj8GlOlNLTDaYFzNxH0Fa7ezHkd+BrUuICNUa?=
 =?us-ascii?Q?fi9dcI859yP+qv8ruO8kf/UKaWnwliJeh++SJ0cvvMZPIkt0hJYPHG5xXLOi?=
 =?us-ascii?Q?TPJA7CF1KkJD/B0iti95Q6DSu4tNGG2lCYbdOm6nY3Gz7wqZxZq3sUfEsMIV?=
 =?us-ascii?Q?nBZnwirJvmXl+A8ZXhOWRpZdglCt1nlERcV4D2m0Onh9meSw57OPzGFplHyc?=
 =?us-ascii?Q?JX6fctuSmoa+CC5BjjYakDz6sChNToPArmTa77WJ1+EI6gdeKDsiUsyPY7oF?=
 =?us-ascii?Q?pyfJT9XKuTPS4KWLQBvqvcybSZR/bRDw512MJf5P4mdWIc4W+VlAaGuwBHKb?=
 =?us-ascii?Q?6z5/0LlgKb2QMsj9liIDLlARyU5khzYmEFNSqQwW5DLyz6cc9kx9vw1PM4Mo?=
 =?us-ascii?Q?5ekXtb1fBtxffYe56lYwkl8G97mJe0BByySQ0lDrclBBdJUiXcvwtiuMj7o6?=
 =?us-ascii?Q?PVgT2H0gTtyICsJzYjCge+3NKzG1K0hoRJPj1j5uSe8bakyyoQfeMtGTyEGN?=
 =?us-ascii?Q?3teT/uCkI2VYJylRiXDqnhrMKZ1pl4gzSxjqcpRO5TO2D451fqXh0XSN1lu4?=
 =?us-ascii?Q?vj8eGTpPCXzINlmNi0YDvVfe7THWJr05aqUO+agDqXMaXBnn69Hg0FODzlcR?=
 =?us-ascii?Q?HEbh9+AVEPZHwHtirf268usTl2FAk0b3D4RI56lUOvIeLWsHXd+lqL1EYdFZ?=
 =?us-ascii?Q?p9SZeUUAfWkzVasfYWFNem6yZcoY6V6rD9EMTqlStrJ1Fq0xz9GPHED0tshj?=
 =?us-ascii?Q?26cRhKbU37sPLgKNZyWAAgjU14TkH7w0jnfTINsrOt14pQw6x+B30q4+54cq?=
 =?us-ascii?Q?Bjb7O0D0vsRUzfEBI1NwUISv3Vm3aPKp2+D3YjDMP6LmZzpGp0QN7ten19SP?=
 =?us-ascii?Q?moexMc5AUd2NznxMzm4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad3d8e4-2433-4a47-e108-08dd62bf6c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 06:14:05.1057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo9iVK+N10L0tkpyJWG7htTpkRGbhcDQ4jG0xLMBxbUxjMivdCvwL4iLHY64x6HY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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

Test-by: Kenneth Feng <kenneth.feng@amd.com>
Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, March 12, 2025 10:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Kevi=
nYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH V2 1/2] drm/amdgpu/gfx: fix ref counting for ring based pro=
file handling

We need to make sure the workload profile ref counts are balanced.  This is=
n't currently the case because we can increment the count on submissions, b=
ut the decrement may be delayed as work comes in.  Track when we enable the=
 workload profile so the references are balanced.

v2: switch to a mutex and active flag

Fixes: 8fdb3958e396 ("drm/amdgpu/gfx: add ring helpers for setting workload=
 profile")
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 30 ++++++++++++++++---------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 ++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 984e6ff6e4632..099329d15b9ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2160,11 +2160,16 @@ void amdgpu_gfx_profile_idle_work_handler(struct wo=
rk_struct *work)
        for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANC=
ES); ++i)
                fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute_r=
ing[i]);
        if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
-               r =3D amdgpu_dpm_switch_power_profile(adev, profile, false)=
;
-               if (r)
-                       dev_warn(adev->dev, "(%d) failed to disable %s powe=
r profile mode\n", r,
-                                profile =3D=3D PP_SMC_POWER_PROFILE_FULLSC=
REEN3D ?
-                                "fullscreen 3D" : "compute");
+               mutex_lock(&adev->gfx.workload_profile_mutex);
+               if (adev->gfx.workload_profile_active) {
+                       r =3D amdgpu_dpm_switch_power_profile(adev, profile=
, false);
+                       if (r)
+                               dev_warn(adev->dev, "(%d) failed to disable=
 %s power profile mode\n", r,
+                                        profile =3D=3D PP_SMC_POWER_PROFIL=
E_FULLSCREEN3D ?
+                                        "fullscreen 3D" : "compute");
+                       adev->gfx.workload_profile_active =3D false;
+               }
+               mutex_unlock(&adev->gfx.workload_profile_mutex);
        } else {
                schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDL=
E_TIMEOUT);
        }
@@ -2184,11 +2189,16 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgp=
u_ring *ring)
        atomic_inc(&adev->gfx.total_submission_cnt);

        if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
-               r =3D amdgpu_dpm_switch_power_profile(adev, profile, true);
-               if (r)
-                       dev_warn(adev->dev, "(%d) failed to disable %s powe=
r profile mode\n", r,
-                                profile =3D=3D PP_SMC_POWER_PROFILE_FULLSC=
REEN3D ?
-                                "fullscreen 3D" : "compute");
+               mutex_lock(&adev->gfx.workload_profile_mutex);
+               if (!adev->gfx.workload_profile_active) {
+                       r =3D amdgpu_dpm_switch_power_profile(adev, profile=
, true);
+                       if (r)
+                               dev_warn(adev->dev, "(%d) failed to disable=
 %s power profile mode\n", r,
+                                        profile =3D=3D PP_SMC_POWER_PROFIL=
E_FULLSCREEN3D ?
+                                        "fullscreen 3D" : "compute");
+                       adev->gfx.workload_profile_active =3D true;
+               }
+               mutex_unlock(&adev->gfx.workload_profile_mutex);
        }
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index ddf4533614bac..75af4f25a133b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -483,6 +483,8 @@ struct amdgpu_gfx {

        atomic_t                        total_submission_cnt;
        struct delayed_work             idle_work;
+       bool                            workload_profile_active;
+       struct mutex                    workload_profile_mutex;
 };

 struct amdgpu_gfx_ras_reg_entry {
--
2.48.1

