Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF32CE77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 04:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1FC310ECD7;
	Thu,  9 Jan 2025 04:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DyabrU6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81D010ECD5
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 04:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loirweOegghdrXXbaiSUiqeHAQUArUvwGM5+AGk0dDMQMHUH4kNjB6fm7dZJqeL4b58AQcOTrdIq5m9T5/isMPKstEvCbmq6e4BemYf/d0+RPEwLdm2e5qpMPGpmXdah6cHV/DdEe2HkvwW8wBTeF3HcBHCqQeCA3Y2Yyx6f0tSkTxufiaPO8w0sZH4fZyPXb8V/UDpAl7n+iFYdWJQ9jgxCjOmLdvhXGXIHyG9RYpuRzTziGXehaFRHvXeTZF7GbQCsjqaKp3wn/zqaJG+chePoc3IHbbCNBqjZJrmZwVILbrG9k0Xfdy0kwOf2goTKZJv439D+FjZjK+u3jut55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT0cizqv+yiPtd7F+rDhpqrwpQU3M9Ub6kGLDXp44eg=;
 b=kwEzqeW8U3R0Juw1S2pXgfK7Xyeofb1WbOEGqDmEYVaC+Lxhl1QJnz4dzXIXYNUve12UtIyvt7rHuR98/rV2fE2geiJrLTCyhwXiHL4y+J8yl0iIs466vMB0w5CqP+EeFNPF7dLbiwcGCvD6PHnFLRcxsLiDVWG5j5+OAeZ2es+fqO6dcSLnQqeb3Muq5a2Jn9x6PceIt3cV0jBVwcyhHnRcmykwBh4X2dhfi9kYwVcV4GZjgDFJLk95prjxti40yHVNdx9QYNbaTfkjaBgL1boRHhGIJJqsazLlv59YWCCToWYyBf/G5zYjWrLcvk7Wvmos9IDfGmdl2t4QiwkDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT0cizqv+yiPtd7F+rDhpqrwpQU3M9Ub6kGLDXp44eg=;
 b=4DyabrU6nuGk/UnZwsCLH+rFN94/5641oG5rL0bLusT51QIRlnBw/OFLVmu8RZzbTIUYzHZga19fejPKOuferFLdD5hrvd94kuftfTjdfsQqPvNn4C6Aa5u21P1QKl+1XUG0Sog/0+E18HlWhki1AnrLjVlX/7WrkJBUPCxduc0=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Thu, 9 Jan 2025 04:09:06 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 04:09:05 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
Thread-Topic: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting
 workload profile
Thread-Index: AQHbYiCb15DVMUuM/kyxjUnu8fmgZLMN02CA
Date: Thu, 9 Jan 2025 04:09:05 +0000
Message-ID: <DM4PR12MB5165AC72A93B485D3B07F7958E132@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250108225627.14063-1-alexander.deucher@amd.com>
In-Reply-To: <20250108225627.14063-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6eb59651-f7a1-4695-92f0-15bc7c8882de;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-09T04:06:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|LV2PR12MB6016:EE_
x-ms-office365-filtering-correlation-id: 88d9a93a-d9dc-4f69-1289-08dd30635bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QspbDAi29ZUW9+UaODF/5D8N7/BCdDWCmRFfwkXZEm2pMlwjNg/gpj7N7U2K?=
 =?us-ascii?Q?iEXi83vWcgpdScapWtX8rcwdQgc7y3OoktdT2UBhlDw0rDnmCudEHrpnIfsb?=
 =?us-ascii?Q?O3x9sydCYzE//Uy5RZtc+GhgBsmQYE2QHGOpsX/yx791d0TvmwxWX3STvU2S?=
 =?us-ascii?Q?Qv4tzqaMVossxIZPS01tqnK0tLHVAxBVOL4K4wyGESYZT1KjnMGmgDhK8+V6?=
 =?us-ascii?Q?CS7KTIA5ceieJdWsyQnwh+6tqTXgnc1OyMvYqNzlRNN+tpRS6bjBAmdr4R5T?=
 =?us-ascii?Q?aotJzqJ7k1QcdDWQPd7juya5PBBbg8p6L1mMIbA/KwmBlGUA/7G7KIID43KB?=
 =?us-ascii?Q?3YPLe5Hr1FOsDtFBYKxoLfpXJJkQ41FwhUPtvGiLRc3A/GkKUL5k7iDKpkUi?=
 =?us-ascii?Q?zbu/avw10xRwhTdkW53D48Bqvtl+RPVU9nXKlDzZ8H1kYcmPePuLXKoJ7oRr?=
 =?us-ascii?Q?UAlUvoD+5g2ThJsZTjnSPlC/psPty8K2C8rtG3LLMGptfo8fR/r5QiVgTfrX?=
 =?us-ascii?Q?Bgo6cqBrZEDmryprTQxqlmqZ1vH6iZ7VD1Nu2IWxJjtueMMbuZ0STi0fb2HI?=
 =?us-ascii?Q?57BJP3XdB2WEKpoWlL4ZIsXYPob24kyQvus9ZA7MCgDYLtYWUfjkkmySo0fJ?=
 =?us-ascii?Q?WSv1RGqjd653vpxLd8LgoTgMm8SJozyT7OBsK8/UB9rPOys9uq8jhnHq5mED?=
 =?us-ascii?Q?triw4Ixmw23ZYNgibl6uNfblmD6aQeQ8ltDzjDLp6ieEksWtcUv+tV+NUtuL?=
 =?us-ascii?Q?Mpdl9N6cuR8k8QcuJN+c4tzXXLD48MyVsXQ4dc1uxzKrwCz/R9tMniLcFMQ1?=
 =?us-ascii?Q?8i1m5CncG17+SODW9SFCdSuuUGNeJWuRr0eNtw/KLInEM1lhNviLbK1mihQS?=
 =?us-ascii?Q?AsPsl0LU0xsiJHpOMu4g6Ybeqc3oNIlKCCrEssit8P7wsNs9dR4QYPKYP+OP?=
 =?us-ascii?Q?FTckcR2iHplTvnzo338/uoeqKiXjpwmpyz6eRy5BOLbI+C/NaaACAS0tUpuO?=
 =?us-ascii?Q?OL2n5fiUTf4HJArqTKC8XpvDTpebJXWYIdh+yqOGU1BBLU8FTxqMPYzdqxlL?=
 =?us-ascii?Q?1AVuRUTaYXPTcsneVbWZ6GDTC/IjQpmLlVL11mU4y1Cqe6J67W/YgI3yiIW1?=
 =?us-ascii?Q?k3pN5snG7dneAb9L6epXUmXSEn85M8KbvchFrX8JMAqKX5rlNtMyy2WuHhVI?=
 =?us-ascii?Q?P1flwL/Mx2HfAphjyk1PVOOhv3mVcSPCQMzuRq1rTt6amljmPifAPRBkfyYP?=
 =?us-ascii?Q?aBnJJfW2sOy6McCahbUkLY6/dHJmhZiFenFTxnlLBD+IkE+zANGUktt8JDCq?=
 =?us-ascii?Q?bgNjBvoi9uoCSxq3NAbnUlbJYcbbrPvmVkJYde99yNycDy6BIB0NeVzR/BWC?=
 =?us-ascii?Q?k4nf8w/IFwCGGB8saOhztpGGxW3b5rPXNSPBettOBSWQ56aYLxA0JOfcv7RI?=
 =?us-ascii?Q?w29AUHSutYVpxismzSHB0/X+B8soTYPm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qd7s21dfJ7lSgf8hTBLyufbblTIibSRcK047taQT55WmRNX9PYEfwBr9sWyQ?=
 =?us-ascii?Q?3rLFJmRloIdETvVFzps7IU44TqyNy1cLXjvZ2eJn+8UK38Rvx+Ssbz5vvRCl?=
 =?us-ascii?Q?G/VvIiqaHEsC/CHt+8dRrCIFdkHNHJm3zNV7iaDEsynBfdwsqz7DB4tZt2aS?=
 =?us-ascii?Q?P5/KAkuok5UgIikqYHYpVpp0Yum17d1/QZ+/h/MwqK3FMeceijyKuC374ypO?=
 =?us-ascii?Q?E9Pl9/jb5NKdsTpLH7XDbg1Cvbf7j3B91eX+iQnfz/Hfsv9cuPzCsqG71oLU?=
 =?us-ascii?Q?/uPICGLtes5kBD7FFOe5C2raCAeAsqISUhDzOQmLqKszxaUVREraCaD8noiB?=
 =?us-ascii?Q?0Q7ohQFe83xpHFb2oZQYGX5h22kx67RMnnUDfQx6kjM/6EeYVPznQHkWpITp?=
 =?us-ascii?Q?tPu1T34sDDyyaNtzXqFfLYV5nEWwQSQkFmg37uW06HmN3Jn8P6/bw/NSmUWj?=
 =?us-ascii?Q?oD2uu3maaIQJEEmQnu7mADFgo07EFArBu1oCHITFsrp2ob7v2TKU6HFHmRpf?=
 =?us-ascii?Q?zPdrTJI99BlcNw3TtEyD/Gy0+SJ7lmlECNDX5FQniugpL+EIN2iT+arFMTIy?=
 =?us-ascii?Q?dcrm3r8EmXgWN5Y0CKyYWvFlMXzA7jdxzLZJ7tIYR4nFV7aE0NQfnyXyFZg4?=
 =?us-ascii?Q?NSNdOmyfEnNHK36ri6YJPM757SXlNc+J9UkZbAVu5ts7TTK+jQ5vos64qneW?=
 =?us-ascii?Q?QxqtlKa3/17/9j1Jbxk3HfqXFQrdLbwtmq7J24m8MjkGr9ihvey2/GZ4X4PU?=
 =?us-ascii?Q?XhlJO+JF97dIiiQSIQjSAQ/CV8YYGIbnx7rzrBKlt+ZMCQBvodyiMoWNUT/V?=
 =?us-ascii?Q?s8xOFdJ/G5iH1oyk5tJdVaFAEiJRgr+YFu03oVxxNKdDFsE6AIopCsLAkBNM?=
 =?us-ascii?Q?+Z+apQLAI/yxbda2z/DR5J6MYP7djjMai1T+tmS5Myqr4GfO7z4quBIZWVri?=
 =?us-ascii?Q?Pw+GwmPwDlxmDGUMagjehRvw4k5424D0RQDs7shhsJinqtrAp0kG/w52WTzx?=
 =?us-ascii?Q?oxciTPC3c+J2sD+KOmWS+qipisCjHnqpBuJCMgPymHCJ/V+kpSR9Z/9y15AD?=
 =?us-ascii?Q?0FvkXPpw5coge5w7qg1Ob75kW0LxHds1gHhDBNPNSgWePxxPdl7X7160Ssg0?=
 =?us-ascii?Q?0e4tH+wz1doFSqnIdpGfCGTCNJ/o62Q0+TR7r3LFYVVgC25Aa5K0S2SCD2GU?=
 =?us-ascii?Q?14vXUXqcS8mcs7MmVmSimFPqd5JmTG28NvC90NyL6/rFmRWr3TQTJWBUTAM0?=
 =?us-ascii?Q?eBdnVnw/tWN8jGekRAivnGk+G0ympYF/w+MxdXp8MOmim+Z6bmb2d9Kfjcv2?=
 =?us-ascii?Q?j/E7hVc8sR4SmUbOaP8Y3mJBMADZozocWZH9YvSTalmlQyIIjqSlIA7XUWla?=
 =?us-ascii?Q?hjT2x0OAeeKgDND7lorlnkDpJi3Ix7xHMAhri6Eu3Ow57hen+SailHhA4HEF?=
 =?us-ascii?Q?aDhWWU4CVvHgm53adJAqUbTB+23imqdxoQEODdjQc1ONGY4V2uu90q9SROi/?=
 =?us-ascii?Q?r1wBvSa6uuD47AfdfLIR2EIocHEH4F7GJaSzXxuLdJQa3J3g5xNHgpypohxp?=
 =?us-ascii?Q?HjIiYlIV7QQjs62QaeU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d9a93a-d9dc-4f69-1289-08dd30635bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 04:09:05.7396 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKyv+nrFnc/18WYzuLmcmaPz5q4ZfXDkNhZo+Ib6CiAQcQYbozb5YXVjtc4WF7p6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016
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

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Thursday, January 9, 2025 6:56 AM
To: amd-gfx@lists.freedesktop.org
Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Feng, Kenneth <Kenneth.Fe=
ng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload =
profile

Add helpers to switch the workload profile dynamically when commands are su=
bmitted.  This allows us to switch to the FULLSCREEN3D or COMPUTE profile w=
hen work is submitted.
Add a delayed work handler to delay switching out of the selected profile i=
f additional work comes in.  This works the same as the VIDEO profile for V=
CN.  This lets dynamically enable workload profiles on the fly and then mov=
e back to the default when there is no work.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e7..c542617121393 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(struc=
t amdgpu_ring *ring)
        mutex_unlock(&adev->enforce_isolation_mutex);
 }

+void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work) {
+       struct amdgpu_device *adev =3D
+               container_of(work, struct amdgpu_device, gfx.idle_work.work=
);
+       enum PP_SMC_POWER_PROFILE profile;
+       u32 i, fences =3D 0;
+       int r;
+
+       if (adev->gfx.num_gfx_rings)
+               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+       else
+               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;


[Kenneth] - there is KFD code amdgpu_amdkfd_set_compute_idle() to manage th=
e compute workload, is it necessary to control compute workload here?

+
+       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
+               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_ring[=
i]);
+       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTANC=
ES); ++i)
+               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute_r=
ing[i]);
+       if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
+               r =3D amdgpu_dpm_switch_power_profile(adev, profile, false)=
;
+               if (r)
+                       dev_warn(adev->dev, "(%d) failed to disable %s powe=
r profile mode\n", r,
+                                profile =3D=3D PP_SMC_POWER_PROFILE_FULLSC=
REEN3D ?
+                                "fullscreen 3D" : "compute");
+       } else {
+               schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_IDL=
E_TIMEOUT);
+       }
+}
+
+void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring) {
+       struct amdgpu_device *adev =3D ring->adev;
+       enum PP_SMC_POWER_PROFILE profile;
+       int r;
+
+       if (adev->gfx.num_gfx_rings)
+               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
+       else
+               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
+
+       atomic_inc(&adev->gfx.total_submission_cnt);
+
+       if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
+               r =3D amdgpu_dpm_switch_power_profile(adev, profile, true);
+               if (r)
+                       dev_warn(adev->dev, "(%d) failed to disable %s powe=
r profile mode\n", r,
+                                profile =3D=3D PP_SMC_POWER_PROFILE_FULLSC=
REEN3D ?
+                                "fullscreen 3D" : "compute");
+       }
+}
+
+void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring) {
+       atomic_dec(&ring->adev->gfx.total_submission_cnt);
+
+       schedule_delayed_work(&ring->adev->gfx.idle_work,
+GFX_PROFILE_IDLE_TIMEOUT); }
+
 /*
  * debugfs for to enable/disable gfx job submission to specific core.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.h
index 7f9e261f47f11..6c84598caec21 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {  #define AMDGPU_GFX_QUEUE=
_PRIORITY_MINIMUM  0  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15

+/* 1 second timeout */
+#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
+
 enum amdgpu_gfx_partition {
        AMDGPU_SPX_PARTITION_MODE =3D 0,
        AMDGPU_DPX_PARTITION_MODE =3D 1,
@@ -477,6 +480,9 @@ struct amdgpu_gfx {
        bool                            kfd_sch_inactive[MAX_XCP];
        unsigned long                   enforce_isolation_jiffies[MAX_XCP];
        unsigned long                   enforce_isolation_time[MAX_XCP];
+
+       atomic_t                        total_submission_cnt;
+       struct delayed_work             idle_work;
 };

 struct amdgpu_gfx_ras_reg_entry {
@@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_devi=
ce *adev,  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *wo=
rk);  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *=
ring);  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *=
ring);
+
+void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
+void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring); void
+amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
+
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);  void=
 amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);

--
2.47.1

