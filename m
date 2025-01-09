Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B52E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 02:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F37C10E297;
	Thu,  9 Jan 2025 02:35:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MLB1eyAk";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6782610E2B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 02:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjLg5MHZvtEFrjReydhVL3UvATfx8u8vps3ACV66gpnOs6VuNgre65k4A+ywmHPHNmFuain2lCa05N/gTmTxN97fC79lJjKtqi08pPgSKC9K9KSi9c3Lp0WcdUPTLtIyXBeKaz6AlAGWr2F/VtT9vGJ8a4oSw0jJ2/qAgXrmgT1iQvVzXaCmLTGuwrhfcV6mvOwjjiUAf9oJ/eWgmUI0CUkpfSCJCyuICUD0/6qHN+9mjXnYbPw6dDUmztuqBhBFknlZlZzAEeduCtC9FB2Qa9g+kKdHOVWBltOuTC+i6N/1tarW7F2wcK/rOqN9tewNX2DIVUK6ie3aTeRkCWpeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc24l8myr59fsUUUHgsi8tMEZLuK1WTYNnMuUwx6SDo=;
 b=KKPXEs1vU3ujwb6LDrrKtNzYTHaUIOkPBamSkLv1ZKAvgVK2xJZmnlgRnQ6rGyP3F+2XBaktDnyNqvOQLni8teZI4tfSHWRZ9lJpSM38PuTnVsbZpsMwavPEip91DZZSAhjzzdhss92WeDC0RVcpagX7TljMcvYy7emZL+30/0VSV6qo8QBaBUMYYjylgh605pN4Fz4wIA9iq3+EdmU8criTvmhNrHNXGiyzD1xdqVqasdCOBM1HPl/9znyiFoacC7Sm+UpjrTj2bLfjTnsNKrKruNNMtROOYxSA3g1ashuJOZzQX50QSQ/0MvVIS1d4Un2UeqsAUVAG3TiFWWld2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fc24l8myr59fsUUUHgsi8tMEZLuK1WTYNnMuUwx6SDo=;
 b=MLB1eyAkT7qfDkUxVJuFA6vzItBZkMj+whg7O88rNWEWpQ1uQYMUihI7BGh6euVPZmobmszWrrSnj5aEYuj/zBL4rA3vdTR2ckJgjhPYmIsKd8mkztYpCVp1aJXvjtT2xZlFdT9nNGn2VcmxhIAptDa0a0E6dAdVUzKZZb7lm/Q=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.11; Thu, 9 Jan 2025 02:35:51 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 02:35:50 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/smu13: update powersave optimizations
Thread-Topic: [PATCH] drm/amdgpu/smu13: update powersave optimizations
Thread-Index: AQHbYguKnZn2jv+CFUqDYRyhvabBy7MNuirw
Date: Thu, 9 Jan 2025 02:35:50 +0000
Message-ID: <DM4PR12MB5165ED30B12EA76868C09DF28E132@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250108202540.15009-1-alexander.deucher@amd.com>
In-Reply-To: <20250108202540.15009-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e21cbf2a-3b69-4be3-b523-bbabab7ce678;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-01-09T02:35:21Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|CH2PR12MB4199:EE_
x-ms-office365-filtering-correlation-id: c0f17b4e-6210-430a-067e-08dd30565511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?v1KeyIPncg+GwB3Ic+m9rG16gFUiuZE5YpkXKjxwiUVvcip2QA31ZK8zve/+?=
 =?us-ascii?Q?rsb73Gjy1940QrGiDyiLw48woBT/qNA9jFkSJ16I7/cMms8ZK7lIdvHj0HrH?=
 =?us-ascii?Q?5UpGWpudrCPEOxyrq25BaK+QlRzakVHi3sKNJemWcIOlSrk1aeDPuqhNDgEY?=
 =?us-ascii?Q?MM5ZC1+qf67YkiwviXdA7AzjaLsUSU6zGT52qymkNnv0XrVGgRloyZgIzxmM?=
 =?us-ascii?Q?b8d+gXxtKzwGTsxJC7uyP/Lqwq4lpQ+BhJMDMexFhPkUbvdK6sN+kx+TWt1b?=
 =?us-ascii?Q?IATQpVfNF2ZZEzs/zAFuWSFa98G1tWzSWd82HmuxBLPIfy0fC1WJs9riezhv?=
 =?us-ascii?Q?mriim9om1iIj9O+gXZ9jYmQhMoc+sGb4gzcCUxxpKrxoXqYfjg1ObgZDtcMD?=
 =?us-ascii?Q?0UqUP8Sjq0e4uv69hKMcDGYTYZgq3vm9SOmrl2KnnMRTF02C7osWXTRwPz0p?=
 =?us-ascii?Q?ODEL2uigbdd9Do4mcS0ncGOZNRfBsah0PeH/KtF+8q3EnVee5O+kgqXI31SA?=
 =?us-ascii?Q?bLU5aqy7vLgTXPaYHkLCEQSYr7kSZiTzIRyLxbyS9u2pKk9ivB+9Ygc9DjTK?=
 =?us-ascii?Q?c2myJAGSRdJruYdQ7KZGM0/B+HPmcO1dhxfv1TSK8jSPgKy/jqw4cZmahIpo?=
 =?us-ascii?Q?QAuhGIOD5i/RKY7caKFMG+OVOPPTmNZZqLoWU+32sIlCAlIc/W3wdvcSYJPt?=
 =?us-ascii?Q?7gDaQZa3Soj7u51FVmKusPaPtf6oNfiyQkmSFx+3/iftedshmTQnAeGl9ZH7?=
 =?us-ascii?Q?vbdNMFPJQScnETLk3UWmyB+d1Cwt5DfcB8tiOBn6enBPa3i8be4PqvaHHkk6?=
 =?us-ascii?Q?khgQ7FmwmCh4pXfZlCVh45b4ouloP9n42R4KpImuTm85PtH7UIAiPuJ7tSiM?=
 =?us-ascii?Q?4bls2vz6U2MGYnLtHy9oxPQQb+E/XIaAvDhql1RgAB0CP726JbHRxGH5sRn6?=
 =?us-ascii?Q?AIakefeEhohSbDxXJVJtj5wa7hA2sfEYdveCwDq1pwkWnFqNIiI0OhHncfbM?=
 =?us-ascii?Q?grn1EQdrWF9/Vm8IHrdWRpObmmuuPebKpTiWMLfCn89ZBOZed1X2AbbSrgpW?=
 =?us-ascii?Q?0UebziMVr+z0lOM7UnAA5D8Io7naL3eK813oeCHyLUsa0rBTydtlJBF0bzcH?=
 =?us-ascii?Q?nawca48f3p9sztjhID6Yl56KU78E9iJcoCQRStJzxZMBDvZqO2RrLpSGS04e?=
 =?us-ascii?Q?1csORrk63WmZTDItxE00KP5chqQ0SUuktjNjohQDpcKgaPcOUc/GK1xMTODN?=
 =?us-ascii?Q?rBdbZAisDr2f/gMp+fwdcb0Ul5f1rY+VmHSfDrcIaMc28uWwvXKLapnaWrzw?=
 =?us-ascii?Q?JTQjre2aix5pC8Qjc0VRdgGOdKJOac+YE5dvhYpttzm9skQMnNL7JCsfgP6y?=
 =?us-ascii?Q?EAKnI3Tt1Amac26lOrHabBCu7UQ7QsBno3PbgOidRa92JsKTXwk8OufPyvLk?=
 =?us-ascii?Q?qtfX2Ippw/OaE/62kSDs1QQ+Wsmc5UhM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5H/IpiAamMj8d5vVNdY/eZaOWXjl5rztDjCdAw8zogzdwNb6lPNFYBHUpCpd?=
 =?us-ascii?Q?k3bZpUvsQgGziAHe4LbdaaSvOVg8Lb6Aotc4A4IeNRWb+XLLKXfJ7shA3A1D?=
 =?us-ascii?Q?unIV4okhsaXwv7zZS/YcNpMAZY6SpN7eIutO9QDfSS15pl0XlVtNuUB72M/d?=
 =?us-ascii?Q?acZbupVL7CF4lw+KRcwPPxUJA+YDSU0O55vpGwx9Pd1QtLiQjTQ54qvq3cIv?=
 =?us-ascii?Q?Bn92jKEu+X2C22EACWv665T1fPQ/BE0YNMyzEDoHCb0nHmPdfiksX9yFwvhx?=
 =?us-ascii?Q?n+Z/BWhnmz4M8ARLFxLgpLFjNrfV7aUM985BlIk5oRGwE+AWfbQuikM6FzQu?=
 =?us-ascii?Q?pZZNqaOdAL3HM6qZ9Wva/dYcKaJ7tcku9tXFFCCX6mTHPqCHwyMwXZoTivJp?=
 =?us-ascii?Q?j+MsNbxyw8aRCL7/jEwnKR2Gtwfh1kKx1Ks8Xs7F0m24LtG31kthbIlafHok?=
 =?us-ascii?Q?PBHr8bd1IGlzJ3vaHyxpjBdWqvKGC7p5W1+SYGVAhe+XFZzAdpB8RJ2jiqF3?=
 =?us-ascii?Q?RQdX7Le77NVjJRAmD1Pk0tJqxELiM083VFSL8jLegdt+igqSxR9TS+OEOGNO?=
 =?us-ascii?Q?f+aT1OiMAyJfcoMAmPI6ODtK2QLi3n+EROiLeLcLRDZ06lNePWoV8E0DtIS/?=
 =?us-ascii?Q?2224lomiw4gcwvOnM9M10+Z4FNq+jp6V89ntqFvCafnLX9uEBEGZ+whlZwLg?=
 =?us-ascii?Q?Y8kV5NGRn8nwb5VKfcySJPeb9HAu4cGLWffCxB8XjFzWnzqSKAmz6fOzi/vo?=
 =?us-ascii?Q?waGrRv8Idq8m6I08xeRifoNwlnIJUxe/fAWHzxRZhhFoJ8nbGI9Q7jDTaUyQ?=
 =?us-ascii?Q?cyTsD3hhltOISLzFEsPr6/Rd5AqDVId4i7rrsqRddpIeKSOprSUJ+gGg/M2q?=
 =?us-ascii?Q?lhlurW9z/C5kFCq9fCLBtaHY3r/06NVdg0V0dDXEl2LB9SJKlGXJqCwQT7r+?=
 =?us-ascii?Q?2QGCmZR3YK3z4t1jduPHj1G9IWk6hq/0j/zF5hLB4EN0yyG1N3v19f/rPc4m?=
 =?us-ascii?Q?iFi99x7qJ0T1mS0fe1P5dgXkqWsd7VRtfGnylJrblGipLRLymKyLjh/zS7wv?=
 =?us-ascii?Q?WUabx8YpFo+albOrvaM6+WwXb5YrHlnxvHxU7W9ttWMKhmUcTRTNAaDhiOvF?=
 =?us-ascii?Q?vDmPzK6Lx0xiwsJZONd2D0ikYR6DblaEb7UpAxUrhnapZD8MRIG6qRD3lr2/?=
 =?us-ascii?Q?Hzq6Oyqlu8Sk5C7L1yy4TngqRbjK23peNLHspSv13cRcffJO9zM1GGHtn31f?=
 =?us-ascii?Q?KXOnijmqov7bxekhWkON4s9dOji+Xm9RFgJwaWvo6EZnMW8N+dkZ2DutSMnE?=
 =?us-ascii?Q?fKSrBQJqTssLOIgTQ0HSgnDvVYZ7mzZWfmWwPfwiXydy0WtbUpwYMIJLKUW9?=
 =?us-ascii?Q?grWaddc0H6vhFl+6yqka2qcyxOBRMPKJGw78hTEy6mYXRhMi6PtmQOBCRjw1?=
 =?us-ascii?Q?vTnL1idzSSwqnyhsChBb35eP54W+QLsOQ/JyP4q9tvHOm7KepS7L1xGZ73b6?=
 =?us-ascii?Q?PanvVEQeaNJe74sPANt21232/6eNFcy36o6B7sYx98vofjXwwIEdSOLyjMnu?=
 =?us-ascii?Q?iCO+v+xNMme06TxTYS4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f17b4e-6210-430a-067e-08dd30565511
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 02:35:50.8571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1UUyRWyQ0Jult240YKsdsKQj10bdW6kNQOgQwNdvtCnVtMVGzJ5s0NZrmFfTJBnh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199
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

Reviewed-by: Kenneth Feng kenneth.feng@amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, January 9, 2025 4:26 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/smu13: update powersave optimizations

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


Only apply when compute profile is selected.  This is the only supported co=
nfiguration.  Selecting other profiles can lead to performane degradations.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2a09b27788e83..0551a33112171 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2643,11 +2643,12 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,
                                          &backend_workload_mask);

        /* Add optimizations for SMU13.0.0/10.  Reuse the power saving prof=
ile */
-       if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0) &&
-            ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
-             (smu->adev->pm.fw_version >=3D 0x004e7300))) ||
-           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 10) &&
-            smu->adev->pm.fw_version >=3D 0x00504500)) {
+       if ((workload_mask & (1 << PP_SMC_POWER_PROFILE_COMPUTE)) &&
+           ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 0) &&
+             ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
+              (smu->adev->pm.fw_version >=3D 0x004e7300))) ||
+            (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(1=
3, 0, 10) &&
+             smu->adev->pm.fw_version >=3D 0x00504500))) {
                workload_type =3D smu_cmn_to_asic_specific_index(smu,
                                                               CMN2ASIC_MAP=
PING_WORKLOAD,
                                                               PP_SMC_POWER=
_PROFILE_POWERSAVING);
--
2.47.1

