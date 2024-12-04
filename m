Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7DFE7716D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 08:42:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088DB10E4A8;
	Wed,  4 Dec 2024 08:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C0wG68sX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669C210E4A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 08:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLdH6dcD8PQM8PE798gHBPZSceOFrrQoc2+3M1g0L2UxItvWqAiPxXHHWHREJsprkj+zZJC0WhIpMyuj6Tk6DZER1AdmV+B68pjuppE5aWG2RRomb9VlS02+ApZfECOKDHyb9K4+EB1CCloGDcKJVuk4BKgTTOwLxsRtCe4D/IKtgTHlcLBSTPKtsNQIbL/XxalGI8/7/CBudV9EaM1+6qeHzOQ5ZuKqK3NVx2ZZtVm84sJ+HqrVWwae4zmpFy9nMtezCqYc2H6GjvRQ/JuUQowf0L8h1fydCYwZY/UIpL6LwJ3K/x/xH4BnXr4Pjq76MkglzrzImqpRRObr8eiMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQIy9tM8qP9N1vhj+hUNN00SvRwizXOkg7sOpJdMcCo=;
 b=GJs8RjQZ3uWqi2jvMc9qWNLNzT97Zny+vjsbn1WVYimQkkeWfYNm1Gu09AFdMX2pX2vR+YlQsip7xkDTWycWo5hwviEdpDTeVcLMnqY6YChoeuPs22kO2hMBEAvV3KhceG9s7HxkdxrcZsrZv32g+1wTvK2TwqRLb8yz31RXZKim5PXIjeMYeJ4VRtOXrSC05rUjb0H3APOG2PYFUkkfttiM+w/iFE8Llj73IyI5lRK0l0PNcLfyItPZjzD8+1uvuCFNllPGXdcZDoLYWAdF0TzuYst4YYRgbjg/NjiOZIdLvEYcRu4JyJdAMXCqRVuj6t6WClssuljc5f72FqbQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQIy9tM8qP9N1vhj+hUNN00SvRwizXOkg7sOpJdMcCo=;
 b=C0wG68sXT6hmXsi2hrXLhMniJ00lmmMRuOz3wxqXoreKM3EBBHw8sEc/nU+R5fN5LhbLPHrOMDzFvACTaqJfEWaFOf4fu5pC/G3jGurJJD7HwW4BzxbWRiI1HZFdi/LJVoF2dDMXm4G7umvadW+Mh0Hp4XQDXaVb4DPSMs1YDfk=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by DM4PR12MB6327.namprd12.prod.outlook.com (2603:10b6:8:a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Wed, 4 Dec 2024 08:41:56 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%4]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 08:41:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Set SMU v13.0.7 default workload type
Thread-Topic: [PATCH v2] drm/amd/pm: Set SMU v13.0.7 default workload type
Thread-Index: AQHbRicBVFlojjVHLEuc3X5VxWzVt7LVxE7Q
Date: Wed, 4 Dec 2024 08:41:55 +0000
Message-ID: <PH7PR12MB5997257438AE681C7864617282372@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20241204083158.1312554-1-kenneth.feng@amd.com>
 <20241204083158.1312554-2-kenneth.feng@amd.com>
In-Reply-To: <20241204083158.1312554-2-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=af180ed3-c1bb-49ec-ac75-bcd2e19d2a98;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-04T08:41:26Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|DM4PR12MB6327:EE_
x-ms-office365-filtering-correlation-id: c5e6ca6c-28fd-4ec1-0af0-08dd143f8239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?uRkidFQDti1fpLcHtE/OHgc/ntjZxvi5MIK73Bkb86r/C+yGnHwoHFdY9too?=
 =?us-ascii?Q?Rzok0sDRr1vWZgrTUwrAYLx4G32mk8iz5I5zo0uY4V87GbDqdod+VAofM7oA?=
 =?us-ascii?Q?uhlWwYyXap2ospSmTkS/ipCfnCjFscSqt3RLSH09r8jCglrthVaojlB7dxpi?=
 =?us-ascii?Q?jfzswmC09e7USzvf2//YV3xtfQUX9ckGXJjgm8v0DEUjSGNqJ4LEtGCKMkQe?=
 =?us-ascii?Q?f5GmDROipZ1jL/qWb8/Oqg41AFQ6fhsirm+EwaFu1Hfj9mJzhngHqUceV8Z8?=
 =?us-ascii?Q?9YxeaFW1wnbHY6KlBQCLBI4OsOuD5cxsJ5h+5HNZvk9UXROrx+HVUkB1wtWi?=
 =?us-ascii?Q?GvDzyfVtOB3on3i7TPZ+nn28OOiQlCwHG4TaDfZcpitNvMOlklfK7NFJ31bs?=
 =?us-ascii?Q?ZSLuHEHXzDtGQR/mfhgP8++zOsObyPHQGtJrZnJDznVLX3U5FANwz1DYdn7m?=
 =?us-ascii?Q?5NHO4CULCxEDKCyD10BukASiyXy6oNxWAPQojum8X6OzFuGrNri6e646iRx+?=
 =?us-ascii?Q?TPUg8QqzrEjGJDVfhTEiawOQZWUoVnVm/4WPyumOQFvhrAOOxTsGvecfIFIF?=
 =?us-ascii?Q?ChNFMZn+U7BynqO4ykhVmDVWKTIXan2bBnRrAvtVqav4oYqnhXv/WuvJE91p?=
 =?us-ascii?Q?yNi3K06XFmTJW6zII5EPmCS8H/2yYOoOcDggqqIerNXL5yEN+FvgACwqfgNP?=
 =?us-ascii?Q?zOBOJiG4dGZRF931t/yxBkRtCETR8OUI/HqdZ4Ybc85Iu3KlW4WhP9j2UxSG?=
 =?us-ascii?Q?rhDgVD58mA2ImOcjNPiIqNt17NkgqOfye9/IzBCLFhhAdsmcMfR0tQMt3D57?=
 =?us-ascii?Q?Eh+JhqFHQ7ire3IO7HJxTsoPbJ9WxB4ZEnPAPyQrq7iptBnyCKFFvWk8/UvB?=
 =?us-ascii?Q?6cBuFLI54QgFKJX1i9y6Peq6/vwScIe8l7jDmRm6KmbsYRgty3dV6v0xfyls?=
 =?us-ascii?Q?Vpiz8hggP/Xm34WYn9i1Fz+YseCRrP0Z8yI3CGMChJbrRbAVDOKJU3CCxEOz?=
 =?us-ascii?Q?g62Agej1m3bkHBSKYLsn5UkhBpU3yhMiGaMBRbbHPAuiR6pQwwtYrb4YTjAI?=
 =?us-ascii?Q?sQ/jarj5uPa0/LEXw+SwrwvAF4ThmmPvrcxJS5qY4lVFHFOJSNwOoLXXoluL?=
 =?us-ascii?Q?BvTi3OCg0dkoh+HXMBvJAUqn7+KMaa5NzFIbk7gEk0WoxDQ/OpgjnmHuxRBn?=
 =?us-ascii?Q?dQNtO8nZijFd+DOrlCBCWof6s5EhwL3etWOqEoi70wZVTr63fcuGrZDBiYvc?=
 =?us-ascii?Q?tUvhoWQWcHKvGVB3UXDqVA879v6SDGFKjQbs/3A/ceCgpjrWpAdi98ARCSAw?=
 =?us-ascii?Q?2TRaJo1vQCHjg7EheBLJufXAyv8UmRHmTD1T8/U6ViN01Pb8Q3AjVmtgRZcv?=
 =?us-ascii?Q?jRYp+eU7tuGmWolQ1s3W1ziMRBhK+OfQF0F25yMgX/2B/oaeww=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SzBqr/yZJCY4dSNS/EsI3CQkrOFpN7SyaJ40UkITWlf5Y3ZtNSyAC9yS9Q5D?=
 =?us-ascii?Q?BsTZ2GLMjxCMcOROWM3w2sTVRWWGocHSz9Q7yjDSFrH6o8NMkk6/d3aHnDWk?=
 =?us-ascii?Q?2poCs1Vb5wlAsLu17OkdZdfgX9n5K5TytUK9DAJ4im3S5mDIgJ86J+LJDKHA?=
 =?us-ascii?Q?tM1CTPa+FM8bAp0rF2cVFQEb38VbGztzCPwZG7P5QzR5vsvXtnJhwXSQD/GQ?=
 =?us-ascii?Q?uSkKQ7kYzJEm53BlpwWxYRkCSpOyNP/zNCCzzQLgtdJ6UF6R9Cd/YGibCQAk?=
 =?us-ascii?Q?52COs65K4P2Wb8DjNd4wyYRHyQAbL4PDTuYD5uZJ6uNiR3xWOgK+jhqtmd6v?=
 =?us-ascii?Q?TzAMSm75F5AZHrONvQx2vPOXky2INHDvp+ltvdCAhO+iTRpEOuuapUn68fRE?=
 =?us-ascii?Q?831++OWRzZJ4J+Xi/PX+ETEraS1lDgUFHWSqYg++ZF8KKxekCFLHAkYKvXDh?=
 =?us-ascii?Q?xm9UwEoFZZI472LtBC3ZRrEMx42lG4ckJoxBjx44mD4j4dE87XbBrARpwoWl?=
 =?us-ascii?Q?QAOiy4v9CWiJSgD2Mj6l47xn+BJZx2SwpST/7YsBKekOgaNBoqIHzysd3L02?=
 =?us-ascii?Q?dU5oVqcDoV2EfGyJL4mFMGxNtRJIW5wQcF8hdbgj0JVX4tRtBFWcEaWFHPzA?=
 =?us-ascii?Q?d7eolziO6dAxQO0TlSTGPO6hA3oNkbhCvm18kSED4ittL0AmQpNB54iDC/gx?=
 =?us-ascii?Q?8huSWTPphPTy4nraNxaRYw/SK6mUD2vOTAD2EL+gUeEklUhgCzPUqXf1PkUh?=
 =?us-ascii?Q?Qe5kayx+scQAfSKrYNHD9e/FiksrVOPz6kMEuLx/hudeqMyw2HdziJl5EgvF?=
 =?us-ascii?Q?0AFehYPo05bGNTqD+COZ/PLuVdrQU6p/X+mCe/dx8kNSXnIAl7BS3mh+pelP?=
 =?us-ascii?Q?X39qZ6a4HfM/wWw+UwoHrHHLqGo6bsMmKAdU9YRxmJUvXIVcl30qveRaKlw1?=
 =?us-ascii?Q?HSxBuh/4u93dgZDJebM8Fjd8nyCfkGDb/q9NewQ+eFkCy40PDF+suoKvgoOW?=
 =?us-ascii?Q?H2IuhS4u40+Hfr8ju7auxS7QO5K1ymRhjdFOv838njCIrTbGFnR2v6DtZdUK?=
 =?us-ascii?Q?uqSv3unMmbTmy0S1Mf3TYOoWxdrqewAvYKGZuWRoPEmax4OAyJved2/uGEVj?=
 =?us-ascii?Q?iucpTFFx0C1SlYEgKGHjcgL/ePQykpCw1fBnd6oxQbokyXvqoINBXDiqPY6V?=
 =?us-ascii?Q?GftDZATaFSJ8STNpvPpiW9nzqmZXocG5zRlh+c+wNdc7Fdb8j5FhCB/GKnRq?=
 =?us-ascii?Q?umUs4YqMx1ICJugHJYb2cJjgUsCPbhw9r4OI0Gz9ocZ4L5ngEey0dfQIh/dz?=
 =?us-ascii?Q?4oP6GwvIS6uCyCzfiBE0Nr62xHamYaBOZtMR/J9FzEJwmGss511jRlDB7MqW?=
 =?us-ascii?Q?1/PrlblOacAWCHQGbaCLQsY1jcgsn081DqrwmBD+F201TSMZsfGtZh2myrbe?=
 =?us-ascii?Q?qdEE851Vjvob1HLzU07z5c3xBnSWNoqt55St7/FMyJrUJoCN/QEy/izUjzBs?=
 =?us-ascii?Q?RejAiF6c+2orKd5jyTRsdIocIEqyFZp3Jo43MHgjgHHrh1U8KB1PW83vQD+b?=
 =?us-ascii?Q?64l/m1U9+IfKuaCGfco=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e6ca6c-28fd-4ec1-0af0-08dd143f8239
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 08:41:55.6370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2MpCGK+4nMpWpHtGhcC0O/SmSPTHjTz4Yy/e9m3NLtRveGzGm0Zk4uh0RZjS+vb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6327
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

Series is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Wednesday, December 4, 2024 4:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: Set SMU v13.0.7 default workload type

Set the default workload type to bootup type on smu v13.0.7.
This is because of the constraint on smu v13.0.7.
Gfx activity has an even higher set point on 3D fullscreen mode than the on=
e on bootup mode. This causes the 3D fullscreen mode's performance is worse=
 than the bootup mode's performance for the lightweighted/medium workload. =
For the high workload, the performance is the same between 3D fullscreen mo=
de and bootup mode.

v2: set the default workload in ASIC specific file

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f4ac403b8b36..aabb94796005 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2810,4 +2810,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *sm=
u)
        smu->workload_map =3D smu_v13_0_7_workload_map;
        smu->smc_driver_if_version =3D SMU13_0_7_DRIVER_IF_VERSION;
        smu_v13_0_set_smu_mailbox_registers(smu);
+       smu->power_profile_mode =3D PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 }
--
2.34.1

