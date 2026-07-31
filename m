Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE11EC54F54
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 07:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594E210F195;
	Fri, 31 Jul 2026 07:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AqQHU2t/";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F0610F197
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 07:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TR0jPYEgIC1VLOFDTwzKB4oAa7cxjd8pmNujyV67cd4IbOch2OgGSqNtJZ5aOBWjWnpFDvWuNTq5+fbWYAe7omuMgf9No9VaBaknf73gdIezVjm7WFfC3MX6mT1nQ68MDdyYQ8t/KkOA2M8oCdhwQ/8cf51oaIxnuuoD7H+WmkxAauuLmeZ9rImWaqnZcR9oG03/fQTeSSN30jiFTbkiHlYOMyoN7TCwFlLfSuVFgrGSZj9MrQcJRSX4rX+lh+p8qnT54QjmHrKUqlDKroDpQ5jQA9vH2UaJviwsPEYcSKrZulM2qybuR2h1dTkRm1kmxQKhrF1Eyhbb1zPjOzJhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5A0nWcwgylV1f4WBJi9+s2C80VHudrSpWkO84oJoKA=;
 b=eaENnrDdrq9qpi2HaPe8Pmv0GMwrE0aIsNmBKQZJ6XCIQ5pB9xcu5KtSJzjjvbOfKaxWglXw39XUkv7cpuZYIuyBQhVeiiqU/ALpnir6dXPpXJYNrtwoGkP2E9/yYRMnnGpHg+SbBBSwX8gqIHpkfSW3GcjnWCgNHJFt92gu5vbctXVB/1QQiWbywSjrkJc9uGmxRhnFaSSHMqnCoVvnS9jMcRl+EuYEq/HQlgdcFHCRMdwWK07D2e7k3HLVC7dbvv1vhDU7dd1dEp/An0Axf9NWAllUXWpOhQ4WL077hNKXXZhg8Yqw3OzuY+SSNzWOub1nTdhreT5uBPQC6bW30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5A0nWcwgylV1f4WBJi9+s2C80VHudrSpWkO84oJoKA=;
 b=AqQHU2t/rFLup6B0/UxEEDL/yCDHiQjQp3gXXBYvVvuXypwq/PClH1hj/2ubxPpv6UggZC18GCBqiK/+qArgo4sbyn35Y2xyeF9BMqHlC+K4COt8cizaQVCwWMM5esl8xUT+vl0VrwW0GEcmJ+TgeHUQD96AaiYZ3ijcx6r0tFU=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:12:01 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 07:12:01 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery
Thread-Topic: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery
Thread-Index: AQHdIK+0YtrpvUIyrU6r79c9vOTYsraHMvuA
Date: Fri, 31 Jul 2026 07:12:01 +0000
Message-ID: <BN9PR12MB530691A447278E095B2E7639FCC82@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260731054428.116651-1-xiang.liu@amd.com>
In-Reply-To: <20260731054428.116651-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-31T06:59:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|DM4PR12MB6325:EE_
x-ms-office365-filtering-correlation-id: dc7b163a-debc-4e29-5d4f-08deeed3045b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: eCWek9N3TMag1agWwRlUPhbQSlu/m80QXjKm98bTYGQoeIxJ/1nveZg4DInxatj8ZPlijNWMfV35h4h+gu4oD7HmLmGvCliYfAQeqd896ZMBW301sn+KvEAG4oHF3v8ipb1sQr10r/IBGQLGbJjaG2RYgUTkEb09Ao59UjHnCOiG6gJalnblTfl7Vy6r4OBLKmr/wRzqgZ8npdM2GaIPWP5qe+tSEiZ7S9QMg7TPuSHm7SMEiVELwVWCYuuB7pCl9VItCfAoSvYRjl5OBsmcM/q/z4V7zsK1H8w6O2KT9zLJGIFlX4aYcE6a42azVMYwhXQdGlg46rERk1nMCCQY1cYBhS9Udtc0nOy8eeNfLGnhjVouvavOvxokQzpSrZGZONce5ZcvdjgAzxxuyvjO97SswBhRrE4enyK5J1xHvZgZzsBLooo1JgwHl46WiS6BvfpGN7WJEaxWFSEIrlPz5A+/ZCHlIY/uVCHBhBSYNqGGZXqEBLutQzLMIqHbx4eUfQTNjQ2Ku0IHjy6ewW/8zOqflUGD36VGtcfxNkfyFPscVkk4lODkDjOMrCNANwM5m2JeR/EyX9f9OGH5ge8RPv6n/MOzBzWf+RdFXo7o9LF745qkb45XTqIgsk4/eZa7EO7AXbYu7S3Yqph4b1ZOs5xZU7S4y1vvCNqQ1caY99T7/kp00jKJ9HcH8y5WUc3SvVWXl+UF9d3KpjGYxuTGUL0H4tH94OZ8YjzF8PqwCxw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?il1HWcR2HCLLCEDcHwLo2vzU73+bPklHChrCUUXAn3EqVuVeAH6XanjTRtdE?=
 =?us-ascii?Q?r1mVApLKTGzZLBhtUZE2dr2HRZ/gQ2p68WKpgwGEirf9rQxL1bXVsm/ZXb57?=
 =?us-ascii?Q?x/7jbrFMhveLFO6FY36tOYspxZp7lDDwiumn2jwV+4W3xzya3OAr1p7J7wjG?=
 =?us-ascii?Q?K//T7b4Ub/mflZke10S53r+OnR6URvSat4aZcEHj1H2sIT3hXmFDviuNbibm?=
 =?us-ascii?Q?uqPSOrQjFhk9JyMI3I9DCsvYgdlfIO6TVMirmVacrvgmhY9ufQnsoyNv429D?=
 =?us-ascii?Q?ZgR/KW91Pz88/R1JtvwlfuAvqdn2n04UyPu6ic2nr9d5MKKK4HFoh5nhcjZ0?=
 =?us-ascii?Q?2zhQStIk0rdjI68VB+tY8Wg1UQYgmwZKi4z/ziIBTiV4QZpybxLJga+oM/yX?=
 =?us-ascii?Q?VHPfejY0yb8yHsI80hIq7lCaOSTFJL/qqBMpcJmv1jsM8P9HFJ1pw5Agy7fu?=
 =?us-ascii?Q?aCHdEF/bOy+fgs1QZ5S6KM7jxVfxkC9C+mg2gmRvVDLXAmfO4z7pdcPkmVkw?=
 =?us-ascii?Q?tBDoKEjQQ0ET9WLVjtYDaY0SIf2EqneTGDWgN04sohr7cllf0jvFVnhjNKYe?=
 =?us-ascii?Q?UiLwnXI45OwsdQxr/E/vhA8fttiHxjwXM8VgRcKoxXhB+975phDwgO9kJQ3k?=
 =?us-ascii?Q?dMbL3a3/ygrTIi6271UV5TUosn5mxU7P4dnuYCsCPlr2nGBrrNqeLPbCJAv3?=
 =?us-ascii?Q?gIJ3IstS0hPl9swG6HInHZwbOEXdtFB+EJ7MLRzbQtfMRpWx7Rj6wArs8lxj?=
 =?us-ascii?Q?W1Szwpqr9brfdtrrQMglGBYs0I7crAwdg7VS0Fm4hvH7WiuFIGPIwT1x3tKi?=
 =?us-ascii?Q?Urfm66wZpMuHOXyb2dzhDtFwStMv5iyIceYhNN6dWmh/AFeHaHPD4ocxQ5AB?=
 =?us-ascii?Q?cfAICo7w9CGakKyo+KPJlnUPfjkEwkeqe3N0msh70DO1AvIVLrAJgypK89yS?=
 =?us-ascii?Q?8feDhGaaaWCgAK7uGpcVdyb4e/5vq76xtYopL01ZZrL6x99xOgcgoOOxyL+/?=
 =?us-ascii?Q?KOpTKwmUoixAvLDVXg/PcM8PJVDfSJxG7sT3eeeaPQUVzmilvrtznfKSyQ08?=
 =?us-ascii?Q?9wPFGYoLVNgxH1oHl3EoORNNjaUfpNTRLmqSxolDkq2Dfic8H43b66Kj90Mi?=
 =?us-ascii?Q?bC/hUEzkM5NGeU+KfPhL41J8C+MgHq16/yHJFDLRYfsLJrAaA0BVRv2HOJ9V?=
 =?us-ascii?Q?AoF9fHFi75K0NqSsiMZisxUbN1cEnepQ3qJmW+oxzZVhKHs7YOzSJ1KpCPtH?=
 =?us-ascii?Q?fP1Qzbc+hfYWi9Rb1knGhCsROYnHngGiyWIXUaOjfVYyM3QYKZF6A0BWnpT2?=
 =?us-ascii?Q?6ZnHOoYtDbSLt99Kp7O/UX4wldz4nWf0s+7gxfh9lEKEumLKtLCMi5+57Qhy?=
 =?us-ascii?Q?eo4XBWTAUUFQyq1nE0As8EFJ/+uqXZVlU2JvslB5iGB2fXmSK4mu3EmDAW6t?=
 =?us-ascii?Q?ZH+zJzJTN5anH3TBxmL1DkokKz2hfk6qYfWmJBpkbn7hDsAbXr4cMk+Ljo26?=
 =?us-ascii?Q?HBX7COK/3SEM1e6c+bUAS3uZaapgGyJp+S4MA5Qexb52+o13foaLsYmyHuhV?=
 =?us-ascii?Q?L2CwPGRS9Olqp2h2UvfxcyM74TU9duXrdxrKX4FmlODbLLDLbLe4AmnPYjeU?=
 =?us-ascii?Q?Ai6ru2mb50ngxVfTWJAhQin6f6KOA8R+wK1cU6EU37DpmiB0MkTeoi3tX+HW?=
 =?us-ascii?Q?4GnQ+/HmuhqsQPb68yTT0K4jnlaXcX04dS2C9Gg1Wr9kVzVc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7b163a-debc-4e29-5d4f-08deeed3045b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 07:12:01.1386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4nkgvB0EFO7uBAnWCSiR4Pdbt/XuxxpAsJlD2PfRQsbbPLgf83PHR747F7UFjgY5R7MpwrCdsKHUzDrqmh1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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

If this delay is only intended for fatal recovery, should it also be condit=
ioned on gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET?
An unconditional msleep here would unnecessarily impact other reset paths (=
e.g., mode2 reset).

Best Regards,
Thomas
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, July 31, 2026 1:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/ras: wait for PMFW MCA polling in UniRAS recovery

UniRAS fatal recovery reads MCA-derived ECC data through PMFW, but direct q=
uery mode bypasses the existing firmware-query delay. The recovery worker c=
an therefore query before PMFW has finished polling the MCA banks, causing =
the first fatal injection to miss its UE count or time out.

Apply the same 500 ms settle delay whenever UniRAS is enabled before harves=
ting ECC data.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d247d0ad063f..ad9a9545b1d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2755,7 +2755,10 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                        device_list_handle =3D &device_list;
                }

-               if (amdgpu_ras_get_error_query_mode(adev, &error_query_mode=
)) {
+               if (amdgpu_uniras_enabled(adev)) {
+                       /* wait 500ms to ensure pmfw polling mca bank info =
done */
+                       msleep(500);
+               } else if (amdgpu_ras_get_error_query_mode(adev, &error_que=
ry_mode))
+{
                        if (error_query_mode =3D=3D AMDGPU_RAS_FIRMWARE_ERR=
OR_QUERY) {
                                /* wait 500ms to ensure pmfw polling mca ba=
nk info done */
                                msleep(500);
--
2.34.1

