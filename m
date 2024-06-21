Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24081C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jun 2024 08:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B8210F064;
	Fri, 21 Jun 2024 08:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3m9ur+Q5";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D0310F064
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jun 2024 08:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypnj3vjzxgR9WsUTX22PhDFxG5kFCG6+t2qbWMDYEWI+yRdP53EOGKl5p3QKPGpK0YXZKHvvJKF/DdpltMS15wQYSJx+Z0QkBEvQbXOo+UyUdowsaeVewnd+Jgb8HEnGE3pKmFVn9wZkngvlLyltG/yxSEVgrzOt7UL7xNBVGnSF54/hcb55MiKkuBKn7I3fOId5Qyf7uv5cLfXY2uFiFKe3hEYGzny9U4flBTFiRDNZhBTa4BXZ3YK7XVSFWB/IkC4ibGIGePjEpirqunIdUoqeVRPK6bOIaBr9LtmzUzf2wRgYqmP9UVH0HuZ6jijl5EFKRMI12wHB5ot+ln8cmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7wRz0mqQSAEHoiYjlARZg7UxpHcg8Xs4Q+Nmrorp3c=;
 b=G1+wmZ7nqupmNS3UxDVeU6cKGX/Ofd3PGB8fMeBqBfE62JsRNrX/tWmp1h46i7biMUKSKaQ2bG2EcJ/E1/Xchfuj2prRTr40aGnaza+bFyhp3WjQoV/8wdOI+0FrdAFROXXNtwyE0Xkkk5ObkmWAudXQDqCJWLLGX/BdTGYzTD0uWKKdBqDA0sEmIunXojK8m2fAWn0Etd9/pfh2cpy2K4yJQ9MZYUo6SlwEo0bFqQ2EkMbNhwWGIlXrYob5k0AQKofYggJx93dXp00tYjDiKXszZ4tq5qj3q2DAXfGoRKi3hiGo7TXocsKaHbM0pa3flb4FUhpTGKK7KhY6Ce3CNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7wRz0mqQSAEHoiYjlARZg7UxpHcg8Xs4Q+Nmrorp3c=;
 b=3m9ur+Q5zN+KOIsYVCcuBVOkltX/LQkARVoaumZcNo5Z+VUg/VkpyYDiw/jNE9NHBI1XL3xXjzflpb6Y0CVQJrEMVyOGdq0SjdrQLuajZbBCeY+BZlsG3yqhpvVwbYvSsS8lcYU6hsar68nRthHTUSUwQUsRz+wUBfMMi8Mehfs=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 08:34:50 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::b1fc:750e:c91c:6d7c%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 08:34:50 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Min, Frank" <Frank.Min@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Topic: [PATCH] drm/amdgpu: Fix smatch static checker warning
Thread-Index: AQHaw7CMSEwnMCZSPUy7qvcQ/2j76LHR4r+A
Date: Fri, 21 Jun 2024 08:34:50 +0000
Message-ID: <DM4PR12MB51811F4B16BD0D6A7F103604EFC92@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20240621075629.27060-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240621075629.27060-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9940a3ee-9d2b-4b25-a5bc-7eb47433b69c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-21T08:28:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|LV8PR12MB9153:EE_
x-ms-office365-filtering-correlation-id: 52ec2451-fe34-4f2b-b392-08dc91cd0442
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?63pgU/ozWhgGQv7mqZHRBEwvu/k5m4d/k0a9Mpv446SZ1a6N7WXiY46hjILh?=
 =?us-ascii?Q?Y3XO/ObxxdkH4qmTovQjbId9+JPQbsAXgU+mzYUKynTZQnlIIAwMOCu1WJvs?=
 =?us-ascii?Q?rK/dARXpP0n/Ol4hg6f0rK+Xe1byDqnMOp7+pXDEdaPQwqnAnLK9COZcE/FU?=
 =?us-ascii?Q?RfYwnwYfnFsqAFDQvM6GERR89Mfwdm84aogGzSYwNywblIDzWLbFou3KER0l?=
 =?us-ascii?Q?mDd5mSejf7ykomG8jAwGyOm6gAM6tV1yRdboMJtCmO46l3kYlfxRTJIN/TV3?=
 =?us-ascii?Q?PEjqtQsQZFUse9Akya3xtBmt9jSpczT8CLpSXzS2kKXAcdog+YDqQD3/Elv9?=
 =?us-ascii?Q?VidLuXLeyOKa209WrPIw9vvqW5Idg4RHJHISMokUaI98e7EidE0QVuXSC4ku?=
 =?us-ascii?Q?V3P+mKE3gMLwa0IomiWadPm1PPN/HCjT55X9auLs98mX40ZtbQLpHS5nMmAq?=
 =?us-ascii?Q?G79ViMAR3TyJZ7ouG9j87RVOn6aky2IS+PwHCx+VqavAZOYBxM0kg+ZrFCTz?=
 =?us-ascii?Q?75kjJwUnYUGOOwO/Z77+Fa+R6hZRI+mNV0fpWCYjMMiB8KlacwnUVOCdOFCj?=
 =?us-ascii?Q?ax4THrmwEWmkWPEYvg/C9jmyf9P3rd96bJpW2FjWT3FBwgkoVk4mngqsk20J?=
 =?us-ascii?Q?Y9iMf80x3V0klubg5GQYDmh4pgyU5ji4AMkDJdCVglEggTNU7KQUR1LCti/R?=
 =?us-ascii?Q?43nPEDs+axD5wzhj5CnnYndfO/VOpqq9kOaCxlNlRi1wa8CY0jZKxRbbCSo/?=
 =?us-ascii?Q?KcfSc6aYU7Ymh/Gq2jYk2kXdn4f0hww7OhD8vkr5oaZe6vE46P3Mq72cSg3S?=
 =?us-ascii?Q?MoxQMR0+6bLMrnieojk7jWfhvdm++GfpcKdwA8X8u8DbXTFC86XQ5H8iDuOu?=
 =?us-ascii?Q?CUE9Qy2cWd0bflDjzBqSQ5dnlwnJbsT/bGSg/2wNVWuksuQHq9ImW0FCOX6J?=
 =?us-ascii?Q?m3mKy2fCrnpF7BdtuFDTA25Ka0XGMsvL1YV95cHSYOIeGPRP8Mp6jUzFLwxg?=
 =?us-ascii?Q?/B24GyCPOWH/jitrT6qQtObGNgDJeYmJlAS/ZdjlkWfiwpDcDV14lYT/6CU7?=
 =?us-ascii?Q?3CDiCp3fWDO7r0riSVASj/MMF5yq6XRfa5GScLWX/KmPNmXRbEvrSp6oX3lq?=
 =?us-ascii?Q?YSfBvScTkbKKY9Xy67iPlMn06otGT0NyY9Ed0yEer1wGfPq5PnRgV+/Ij6rt?=
 =?us-ascii?Q?T+lXvFaqxahpht+i8aqaZ9k0m3cT/5OlPT9nTPDo+lMPF3IRYR4zHnt2mkRz?=
 =?us-ascii?Q?v7vCm9jMXUiKvj49X8HDxJz12fqB73wzmqrRtKxfnpnsroFIwjAr964W9EUh?=
 =?us-ascii?Q?zsatj/s8zVcdcYEtGPWXjrqxM6pTd3Rny3bcelXSu6YVkmhdYYCvu0PW/08Q?=
 =?us-ascii?Q?fGEtoQA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9gd+uAf5XnnkiPHRZRxU9TDLQctgHJE74AYVkdi+xfOXqjoYFjf+mdig1OeT?=
 =?us-ascii?Q?4vZ5Ns9oz52i0KTDMhWOAM1kctvHi7GQoXjWe+BjH7gZJgXa+qJopT0osEgf?=
 =?us-ascii?Q?9+LHg/kMaBKIs60Gz9o2Bnv4bYj5ZFC2PeNXg2Ee/Xp6MMmU3bnJ80fjLOsh?=
 =?us-ascii?Q?ZQc4G25wBunXZWPSrZW+NarWdDYaS+Xa5u0t5CGRLY9EhstfONGJh45V1D5K?=
 =?us-ascii?Q?syQmVTWGGTeaxq/H41NhpQYGuUbDmgsO89HQjB03OiXl3i01OD74om1B7Fv7?=
 =?us-ascii?Q?gU7lF70yR/JUp5sXISM//LT1LjJ9X4gNeVl34+lUDPwAQZqDgEBTnxMfsFLJ?=
 =?us-ascii?Q?GNDmDZrLj9enWeICjOHvXTZV/QnhlU34p4QPRYItq/Wk0kokVqYxzOh6yw1r?=
 =?us-ascii?Q?wy0WavvwCacEgjujC6Bmn6ErXGpJtUDDpCLFTxzrEaP3yOrudgMIVXhIPNBi?=
 =?us-ascii?Q?5ywkztPxaRKAb9JytCj9M1I8m+W3THT3DkE8sCbrQ0WJEpdwuVhbXH6GvdVz?=
 =?us-ascii?Q?Lvc11X+B/s/9OKJXJGea4i3Kmmm/viejv6X6hVQGlESjHksWsDGF6iCMpiWa?=
 =?us-ascii?Q?li8hqWhiw3hestjr8UrUF+r7vWPiOri+kgbEaBSo+N9sVzJWqyaIe7ncufc+?=
 =?us-ascii?Q?0Ys4P3p108WRIFCffnMR0kzXoat5pZ28qiNEZT1tXysdZ7L1fRN9Tou+FaT4?=
 =?us-ascii?Q?PK8B2YF1vho4FN+wX6FVsQaYoO03+RWAJMDuiQ1W3+X6hIy45D2qKz6Svme1?=
 =?us-ascii?Q?Skkbij2wk+ZJfNCRx03E1T5mATE/IPiFkJBD9vyLUTJ82+yChZGAekuoYWtm?=
 =?us-ascii?Q?QzyCsTpB5zL0ionKbyFAqML5Nv5bxSAxPSJcDaXjNIvlL+/8y05pu+oBFrGr?=
 =?us-ascii?Q?QRrP2f+9gE+ZCTra05x+Gir8c3HB0pMpSR++l8H/6F7YlH272yvqZ3MXc66A?=
 =?us-ascii?Q?hTVMYU9lBlyYKhk1LO/EDdwECs06590fc8jxPCZDmivsATSbZ8sGGLa2I6RV?=
 =?us-ascii?Q?uTQ86U8LsAtJ4OozBvCIieKuh0yWUvundMY6QLyjnfzCC8wHekiXYgkkoG/n?=
 =?us-ascii?Q?gtyNKERF4CmhKEEUBX4LV/W3XQDBBn0Z2i+TgjarVZlxcod2LTFhGKtDklIa?=
 =?us-ascii?Q?ing4rLYpVEfupY07YOYXKO4IdvkYKZ0wqkmmD5NkaWIn/8rrua8PTQPABT/+?=
 =?us-ascii?Q?5YnR6gEXRxUU08J2ckW6Ycn7z9xK0Xe6xFdQIxZGLhhRNWNv7BPCseMxPSdi?=
 =?us-ascii?Q?2euvJj5LriW4eOaO5jzgVBmmLQuxpt8J/0nT97go3C70ejg3a8s3ugISsxmx?=
 =?us-ascii?Q?VgRd2GSYxZRZhi2klhrJ6sp70OREkNW5CF94625Opucyvtp/V3LqL7b3Ey3y?=
 =?us-ascii?Q?L6/NT8Rb98+ngN66JLNcoye9oiaPSzyCtGpTS2fmAnzmkLNmGeD2FvsBU7xY?=
 =?us-ascii?Q?rBauMKJyl5bwO6KrWDtPnElF0BTz6Lea75/c8D9MUs4cEQjL/1jdeoVfjouh?=
 =?us-ascii?Q?KT60WswClTBvDN5v+7PmdQRHQmdukpMfEe7RepMEV68qnDytsEkpfnwd9JlS?=
 =?us-ascii?Q?voyHMPxWbwJWvhMANW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ec2451-fe34-4f2b-b392-08dc91cd0442
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 08:34:50.5320 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMfNDg7NrB5U9PUczQpoRaO6D/zpd6yt2aLLoD8HsckeDop0hfrIZu5iJtpB8WLe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

Seems only need to deal with this on gfx v11, for gfx v12, it will judgemen=
t whether (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) before use imu funcs on=
 gfx_v12_0_rlc_backdoor_autoload_enable.

Regards,
Likun

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com>
Sent: Friday, June 21, 2024 3:56 PM
To: amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Min, Fra=
nk <Frank.Min@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Fix smatch static checker warning

adev->gfx.imu.funcs could be NULL.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----  drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_0.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index b4575765d7a8..5c17409439f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4498,11 +4498,11 @@ static int gfx_v11_0_hw_init(void *handle)
                        /* RLC autoload sequence 1: Program rlc ram */
                        if (adev->gfx.imu.funcs->program_rlc_ram)
                                adev->gfx.imu.funcs->program_rlc_ram(adev);
+                       /* rlc autoload firmware */
+                       r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+                       if (r)
+                               return r;
                }
-               /* rlc autoload firmware */
-               r =3D gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-               if (r)
-                       return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
                        if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) { diff=
 --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgp=
u/gfx_v12_0.c
index 460bf33a22b1..16fc5c5b15f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3258,11 +3258,11 @@ static int gfx_v12_0_hw_init(void *handle)
                        /* RLC autoload sequence 1: Program rlc ram */
                        if (adev->gfx.imu.funcs->program_rlc_ram)
                                adev->gfx.imu.funcs->program_rlc_ram(adev);
+                       /* rlc autoload firmware */
+                       r =3D gfx_v12_0_rlc_backdoor_autoload_enable(adev);
+                       if (r)
+                               return r;
                }
-               /* rlc autoload firmware */
-               r =3D gfx_v12_0_rlc_backdoor_autoload_enable(adev);
-               if (r)
-                       return r;
        } else {
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) =
{
                        if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
--
2.17.1

