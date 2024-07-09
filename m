Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B761C2BD09
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jul 2024 09:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 305B710E4D7;
	Tue,  9 Jul 2024 09:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GBBbwJ2z";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F7F10E4D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jul 2024 09:32:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghhxZ6AMNI/qQGwjJhTJJY0lRBqu0FKRJRo/NRT9UAEojUCLoIvJ34z4CAawGoOZcyxYjEUZ2OeGbd3RmC9s6UpXMm2Dq+4azPPSHi+uzjZQiwMwPV9bAiGZEbM7G6dnTabG0G6dbwge0TktTsl0DK6IiS62g6bd6DWfcC1saL5d41nonOclhJqAsm7Bxu15HlnzZyCb7/NO3SMgVkYq9SeHWYCgL6aEvXVuEVp3e3ZWaawFydbFv+l280fpyUDsp6YuCZ65Qpd9CRlhCmF3qqTb5/Bo/QENDI+HToVjg9ltcCmzvGqH5HeBAm//SwPVJIbRBT/bc31SCL6FmklPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YYr3cAKEvJ//QG3WaxBScgb7a0Y+Us6KyOnCtMpnp4A=;
 b=WAJ+R1CpbJfaPtDGjvAerMn/zZhy0KVk/1zHaA6XWZRBszdyRNuzUVfUuomte8uUjJ1T9azLt2upObNXVSv979oR8OX9BebjsEEa06Y/u+cMwwZrip4nXKQR+g6+fcF0oCTDp+9LxySGQbubbrKh/7ixtgFuuDDb0AqiDxzEA+MeT5EqR5NB5xR6FhGeeqJoG/EL93CM/F7ee0/RG4SkP+w5IpP2brXjYbZl4Mi5oHsUsFF/uwQgXMiJGyvry71Uw1HReW04qng0w1gxIVmMd8WVOGvbAbyaNwHq2qZiY9QabuaTMq8Od6YaCZl1zh2SvM+LB3ry3+uccUolqWB0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YYr3cAKEvJ//QG3WaxBScgb7a0Y+Us6KyOnCtMpnp4A=;
 b=GBBbwJ2zPkh3C2GTlseRuHI+pdmhKxBCzc3otKOLrA72wo6GELG2M1PCAXLuUr8HPu9anYlXq3TO/0TM2a2oeozTC77McGuL0W706qr+pA5WUojNcpsOTwcDtnPw9Bj5lNHFG/1CR4m3l/B8cx6TF0LzDk6JBVOy85Be1wxd3iM=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.19; Tue, 9 Jul 2024 09:32:48 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:32:47 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Slivka, Danijel" <Danijel.Slivka@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Ignore initial value in smu response
 register
Thread-Topic: [PATCH v2] drm/amd/pm: Ignore initial value in smu response
 register
Thread-Index: AQHa0TnL3ro52K88rEue2Kxk+9rthrHuI05g
Date: Tue, 9 Jul 2024 09:32:47 +0000
Message-ID: <DM4PR12MB516596646C9262E8642DB8038EDB2@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20240708133106.36933-1-danijel.slivka@amd.com>
In-Reply-To: <20240708133106.36933-1-danijel.slivka@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=24b1fbdb-a619-4da6-b75a-f1f0b5a80832;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-09T09:32:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB6157:EE_
x-ms-office365-filtering-correlation-id: 546b4049-bdb8-42f4-85e8-08dc9ffa182d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2TbZQBIlMTTdlYx1I7XPHfI+sOhYHCmgtJ+/qwDd5GhdkEr+kofEmmdSA31+?=
 =?us-ascii?Q?z8zaiqE0KtUKmruIVL6xA6bAtlZrf07JqJSMrfBdPebFS/yvfEKAQl4upsd+?=
 =?us-ascii?Q?/XRd8BZtOIUab6gvtXmDvRcEgwCTV86va/rt2A90RPKB/QkW5xM63xnehFDf?=
 =?us-ascii?Q?pv0aC9BgX2R9qHoqCk8DPAsO3zd83VmQ2OoaYSctCenDnEu4F8seI2MuUOBY?=
 =?us-ascii?Q?DuJmeCK59fh+Dd0WT/oYrJyVZD0A0Ka76g8IjCuaDPFE4Jti+YhhNpCGpyqG?=
 =?us-ascii?Q?pTcHD57UNNaJqc4X89QVkJrDBoy82OToHFgaFANrZyXeVVpeJdHtygSQw4IZ?=
 =?us-ascii?Q?5s/Y7fZWJwK+3MbeGZ3LvotgyM9u9OIJdwSXsDN4kB7AsUZHILYzVBhiboHx?=
 =?us-ascii?Q?Y3V+nlfAQT48sMcOtMzl71RTq46e6hzlZ3v3ldbg3P0v/AdMZDlSds7pPg3u?=
 =?us-ascii?Q?38eKryAloYGci+kxx77JX6tniEHy7rqZTEKqfzrs7b+FesvfR4GRF2vphWOY?=
 =?us-ascii?Q?fMyGR3NQCeQNat91pjuRYqd/ae+NjnZpxZMG3BYvHZ8Quqgan6hBcDOdkYL9?=
 =?us-ascii?Q?iE7bSfJTcaEHZPpZimw9ABl14SF5h5ko737ne2Hv37HNsh1pE3VGRTQoFwUV?=
 =?us-ascii?Q?qw+hmWmjoYboplMORilP8c2nnBtwXqFlhuw2MolFnqWVhkmmbSN2ZjA9YJ3C?=
 =?us-ascii?Q?fcqe6De/PMMslAPK9gtVoEyqgEx3VGF023lRKBcv2ayQlV4hGnK9cV44jSoX?=
 =?us-ascii?Q?ot+7e5Dd07gvJFQQoua+V2pSURG15cO85ohSq2dbdVEz/qxTxyN/Jnv0k8KX?=
 =?us-ascii?Q?Z47oUPYrJQ9r4+yesvG6QCse2qVSDutBgKpGxs9ynBulQC5ee96YZjuUtC2z?=
 =?us-ascii?Q?dxEXCmU4KfzqlmScQh5zP6ZBjzBHjqEb0PS62Rg51wzkHjOuU7Xw2irFNyLO?=
 =?us-ascii?Q?c3dWTW7BB3lSta/biDYVejHtVe+fk1hicmOpmQGYy2zRPoaNEOPwDz2vSTxe?=
 =?us-ascii?Q?HUoroo43l4sWQ1mvxhTVN9oKVeLJgMGEpwd1437D+ow7qfBjguWW1d0cQq+i?=
 =?us-ascii?Q?9AsJE9X/Mom83n0xjHM0GYH92WfwNILDaXMc358vAVxsIlmomRMwqEK+zkgO?=
 =?us-ascii?Q?paCdJPlUimg9cFYQUUBqU2H8a5ATBVA8eeGMtcDyItj7Sw1UP9JRr/Kpr58p?=
 =?us-ascii?Q?pmwDtPJTBB2knqC7xaTt7qKy3pN5tXv2OPjCZgCIGNqgOTjORBUSrxbP6yRK?=
 =?us-ascii?Q?QrkUUp2jO3Mk07qJbiCDS0qFsl/L3qxYHj0WSYT2e+bMqSknv53AaHWCdXiE?=
 =?us-ascii?Q?msLbxKFPouaXSU8739+IYlT+XfnLrfvd1OS3VgIh5nE1qYVO/5jb5Qm6b0Al?=
 =?us-ascii?Q?F+8be9JOQ8DvZe63ecZcjo4xkq6fTL1rSxXLgMueVYsAbUYwpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tFVG1NmOGQx4bLpV9Z5OA9NBfLqrj8LXTFjaWolbGv9x1WFixgNc/CY4pqUn?=
 =?us-ascii?Q?i81SVl9KGhSE0iw0u0v1iqdL2x/vzHgO0kehsOzivDP3CDiElR/S9V2yVt+O?=
 =?us-ascii?Q?bvAx5empN3xN8KIqf4Zof/+wGX9g/bhqeH9Zmu6+aRFt3aQ8mMjqHa5aPDxX?=
 =?us-ascii?Q?vfR7CI9WqmRufkJxSw53qf/njKBbxIm87bk+feFnDgfL9Yrm+CguoA1y/C26?=
 =?us-ascii?Q?4XuFD8UPeyKTF8jt6/yvUguGYFiFqubHDhy6za1TYapqaG637x2pFbtKKU85?=
 =?us-ascii?Q?bKcDZhS5TqJc7QPND5F5D0bDXr0OTvq9gvoNGrhmoy4Mj41UrPzYDmksf3Gl?=
 =?us-ascii?Q?IJ/bOETE9FC8HTe6DImBCT5bjPzvq5jGFbT2UF8zaWVyINkI6M0gYfFKVzS4?=
 =?us-ascii?Q?yc78oGAQbqLtH+Ybmzlj+qXN63sh5EFt/0+Ta+pkX8BICzM3rO0VxPbPZHoX?=
 =?us-ascii?Q?1XByCJNu3G95xdrP16fZ9Q84M3RN+GScf4wjv3XLOk3ERfFN20RMXFgNeYvv?=
 =?us-ascii?Q?Dw9q1O7XzQXLy3lzh3GWdo8XFmUx6CYLyxLYrDHY2E730rQuujiCAqEmbepz?=
 =?us-ascii?Q?FPSHjVF1IZeFgSfidKYwX5mov0yS3GjtpYc6HG180dTLRR6F9OhpODy6rfKG?=
 =?us-ascii?Q?hW+ulA/8KZmn+8eFMfdzW9oW3aJlAwce1W3CgHiHM+1KsIQXIy3PfZngLfzu?=
 =?us-ascii?Q?gtkFGdtmeDazgyQs5HYpfj6pSBu5TIFys/iHwF8v+DUAJKETUSYX9UGet/aQ?=
 =?us-ascii?Q?ltgKqEGCmCN3nR4wH0t3r0sE7rDOSJqk/1oByWyvDjYsEriqZDWtz+AAmJkv?=
 =?us-ascii?Q?bigXRRD3e1ZQB/kNeVcn2O1zmDqBtAv0Izhc4+c5206HdPI36H5ZMItRn4dK?=
 =?us-ascii?Q?h3ONbupGAr2mKnHB+2FK3wt+d3oHI5hqhqqpnTV9EmWfKSKAbKT40vCbBehw?=
 =?us-ascii?Q?Mo3XQiVVSSyxtQda1HYABIvg+g7CqXcUeQJokYGgXJlByUMdR0PNAqQFThHL?=
 =?us-ascii?Q?JN+uej9pZtwZSVez55TGn20uoc247TYQboIE6tIShCmlj6U91MEVtRUaU1Q+?=
 =?us-ascii?Q?48ID8WpMnHDXcWwNCsXTC+naGA1TVUcGzD6GKMmx4xJ14ky9zqxN+2wnj057?=
 =?us-ascii?Q?XvJq2YxTVJiIxISpVyp7vUDMW1nfPbBupgWaTc7lkpHcQc4ZV7/R8O8BUwhV?=
 =?us-ascii?Q?qFDIbyGbv7QGHcC3QeEetE0BrFts3SW+umhEyZLo+DeyV+J4cmUCqXtwBW4L?=
 =?us-ascii?Q?TVkbQAVtHI4KcyaF2kRdF74Tex7m19uSJOOuyrujc6J+C3wuS4wwWtZJLOmW?=
 =?us-ascii?Q?uDBvCFlr5feMg6Cw6tYCXKg1XHEHv/O/FkoDell0rrni5UjY0nhlTTplP/AK?=
 =?us-ascii?Q?CVJOsb0l480omiyRty+ZGIB5QUIzTAU73UV97w7Q/PNfHJ59I37f1IWzVafv?=
 =?us-ascii?Q?deAqNWubsQHtLvbtGUmEsFDKR/zWSCKXOjV1yznmnzi1raaZbVxYVMRdflFB?=
 =?us-ascii?Q?4b6y5wZvGe+yOxkTqmLzIS03CXt0Sq7MXhnzjdwAHXhpT+VPobBKgxLQyTRi?=
 =?us-ascii?Q?tmEUniasAh6Ad/Hbf20=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546b4049-bdb8-42f4-85e8-08dc9ffa182d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 09:32:47.5983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KbxMhso12m/sG+3mMraas6n0cncQ6UAJgdKjDdYejIEPG5UzZtZ+cKe6Ppx3Gyz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Danijel =
Slivka
Sent: Monday, July 8, 2024 9:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Slivka, Danijel <Danijel.Slivka@amd.com>
Subject: [PATCH v2] drm/amd/pm: Ignore initial value in smu response regist=
er

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Why:
If the reg mmMP1_SMN_C2PMSG_90 is being written to during amdgpu driver loa=
d or driver unload, subsequent amdgpu driver load will fail at smu_hw_init.=
 The default of mmMP1_SMN_C2PMSG_90 register at a clean environment is 0x1 =
and if value differs from expected, amdgpu driver load will fail.

How to fix:
Ignore the initial value in smu response register before the first smu mess=
age is sent,if smc in SMU_FW_INIT state, just proceed further to send the m=
essage. If register holds an unexpected value after smu message was sent se=
t, smc_state to SMU_FW_HANG state and no further smu messages will be sent.

v2:
Set SMU_FW_INIT state at the start of smu hw_init/resume.
Check smc_fw_state before sending smu message if in hang state skip sending=
 message.
Set SMU_FW_HANG only in case unexpected value is detected

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 34 ++++++++++++++++---
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index d79bdb1e8cdf..fb8643d25d1b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1755,6 +1755,8 @@ static int smu_start_smc_engine(struct smu_context *s=
mu)
        struct amdgpu_device *adev =3D smu->adev;
        int ret =3D 0;

+       smu->smc_fw_state =3D SMU_FW_INIT;
+
        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
                if (amdgpu_ip_version(adev, MP1_HWIP, 0) < IP_VERSION(11, 0=
, 0)) {
                        if (smu->ppt_funcs->load_microcode) { diff --git a/=
drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsm=
u/inc/amdgpu_smu.h
index a34c802f52be..b44a185d07e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -495,6 +495,12 @@ struct stb_context {
        spinlock_t lock;
 };

+enum smu_fw_status {
+       SMU_FW_INIT =3D 0,
+       SMU_FW_RUNTIME,
+       SMU_FW_HANG,
+};
+
 #define WORKLOAD_POLICY_MAX 7

 /*
@@ -562,6 +568,7 @@ struct smu_context {
        uint32_t smc_fw_if_version;
        uint32_t smc_fw_version;
        uint32_t smc_fw_caps;
+       uint8_t smc_fw_state;

        bool uploading_custom_pp_table;
        bool dc_controlled_by_gpio;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 5592fd825aa3..d7c983a1f3f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -315,11 +315,20 @@ int smu_cmn_send_msg_without_waiting(struct smu_conte=
xt *smu,
        if (adev->no_hw_access)
                return 0;

-       reg =3D __smu_cmn_poll_stat(smu);
-       res =3D __smu_cmn_reg2errno(smu, reg);
-       if (reg =3D=3D SMU_RESP_NONE ||
-           res =3D=3D -EREMOTEIO)
+       if (smu->smc_fw_state =3D=3D SMU_FW_HANG) {
+               dev_err(adev->dev, "SMU is in hanged state, failed to
+ send smu message!\n");
                goto Out;
+       }
+
+       if (smu->smc_fw_state =3D=3D SMU_FW_INIT) {
+               smu->smc_fw_state =3D SMU_FW_RUNTIME;
+       } else {
+               reg =3D __smu_cmn_poll_stat(smu);
+               res =3D __smu_cmn_reg2errno(smu, reg);
+               if (reg =3D=3D SMU_RESP_NONE || res =3D=3D -EREMOTEIO)
+                       goto Out;
+       }
+
        __smu_cmn_send_msg(smu, msg_index, param);
        res =3D 0;
 Out:
@@ -350,6 +359,9 @@ int smu_cmn_wait_for_response(struct smu_context *smu)
        reg =3D __smu_cmn_poll_stat(smu);
        res =3D __smu_cmn_reg2errno(smu, reg);

+       if (res =3D=3D -EREMOTEIO)
+               smu->smc_fw_state =3D SMU_FW_HANG;
+
        if (unlikely(smu->adev->pm.smu_debug_mask & SMU_DEBUG_HALT_ON_ERROR=
) &&
            res && (res !=3D -ETIME)) {
                amdgpu_device_halt(smu->adev); @@ -418,6 +430,15 @@ int smu=
_cmn_send_smc_msg_with_param(struct smu_context *smu,
                        goto Out;
        }

+       if (smu->smc_fw_state =3D=3D SMU_FW_HANG) {
+               dev_err(adev->dev, "SMU is in hanged state, failed to send =
smu message!\n");
+               goto Out;
+       } else if (smu->smc_fw_state =3D=3D SMU_FW_INIT) {
+               /* Ignore initial smu response register value */
+               poll =3D false;
+               smu->smc_fw_state =3D SMU_FW_RUNTIME;
+       }
+
        if (poll) {
                reg =3D __smu_cmn_poll_stat(smu);
                res =3D __smu_cmn_reg2errno(smu, reg); @@ -429,8 +450,11 @@=
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
        __smu_cmn_send_msg(smu, (uint16_t) index, param);
        reg =3D __smu_cmn_poll_stat(smu);
        res =3D __smu_cmn_reg2errno(smu, reg);
-       if (res !=3D 0)
+       if (res !=3D 0) {
+               if (res =3D=3D -EREMOTEIO)
+                       smu->smc_fw_state =3D SMU_FW_HANG;
                __smu_cmn_reg_print_error(smu, reg, index, param, msg);
+       }
        if (read_arg) {
                smu_cmn_read_arg(smu, read_arg);
                dev_dbg(adev->dev, "smu send message: %s(%d) param: 0x%08x,=
 resp: 0x%08x,\
--
2.34.1

