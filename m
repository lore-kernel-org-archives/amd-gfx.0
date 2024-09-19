Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15B4CF3962
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E83210E741;
	Thu, 19 Sep 2024 18:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jCdfVBrH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92C9610E741
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ustGBmrwv90S3ThVUAzW2FzboA9JZxbhF2DLCXRqu3mA+YADROLZ4RJaaa0hXL5bHJ0tDz8/iw0bABVujLblWDPUGnt3XVmTsQu8oBt20G7OMiq2dypdD0FjnmfuS7kXxS47HsScKx0meIT0rvAzS4xL2bVfn8sOMBOZcIqEh0KpZe3hIWOLiq8xtbU685Vct4OJ6L2iUJHYSCRxvLLXt6jP1d8j0ubt7kPRSAZbJh5goDpIY3iubYLXUf2Pfqmu3tDbu2BCTiC0yyE5nV3ntLd6gv+pfiDtdYiiwArnG7R6c2u9Z/YfHUtaYxK4BtXehyyPx0aumywoc2jTf6EnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Yq6nr3P4FF7neWD3RBnwFAjdWvqlTw1d6j0ThigbKI=;
 b=NT6pYmZa9B9Ww33Xu2mcIFRBzbIxk5b9gKP9Dx7IsNn7wNGVj7f6vYS+fTuuN8s0k4iOBdXAeTchZJpxzY5Ta56XjGdUGE2uH+/k4G0p6yM0VBa5qnz4Cm0YPhv8XKUC6tjGHM2EbrbKEYRAQ3YW5FB8p2kzhP8u7oMiIdtY8+8mJ0m/vJT10Xi+vdMYwLK9KNCDNeNlmo5HTTDMDXcB/PPdbiMpLCeQCx5xKAp3hBCj+xLen0zOow8Ll4JwTjqNsSVhtEyTDiLfU0MhmQuKpyGuB/iZuNblNAy7tb7EWcqK+objKXUFyLcs8g4VwtVu0w/X7t5+gHZRdfwcvnmaaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Yq6nr3P4FF7neWD3RBnwFAjdWvqlTw1d6j0ThigbKI=;
 b=jCdfVBrH+7xsZkhSqVs/nDMBVgx7WhglBwBFLKZyV4tAKOPXrO5QBoDbWuJ1O8LuY4B0sdKbg3ihyUKHna5t2TZMXJ3bsa5Gmp+3IT4YD0BzAvQqQIXhU60mEw9pW5YvHkCSLxmBNHuv6gfSXRzVHgbDu4IrAyMW/TIioKw4CCQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Thu, 19 Sep
 2024 18:22:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 18:22:04 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chen, Jingwen" <Jingwen.Chen@amd.com>, "cao, lin" <lin.cao@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip coredump after job timeout in SRIOV
Thread-Topic: [PATCH] drm/amdgpu: skip coredump after job timeout in SRIOV
Thread-Index: AQHbClhVkHjNxOcBM06UYAupR42XQbJfbONg
Date: Thu, 19 Sep 2024 18:22:04 +0000
Message-ID: <BL1PR12MB5144D67F0712B20544D00E7DF7632@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240919055343.112601-1-zhenguo.yin@amd.com>
In-Reply-To: <20240919055343.112601-1-zhenguo.yin@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-19T18:22:04.252Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW6PR12MB8960:EE_
x-ms-office365-filtering-correlation-id: 274a1687-7b28-41c9-d3a8-08dcd8d7f6b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ncxGRL6CWoUlSOmRIOlTdvJ7YIgzYTQV+GemBCAK9xTEspl64tiuhuUpdpGh?=
 =?us-ascii?Q?JRW+pbS5ZpmMKY2UBnrzUNkiPrq1v/OyDVr00IARfYuiQhCSLlUFaXq5FjEY?=
 =?us-ascii?Q?CCycDSEuFyr/cX+M7o0m/nzngZxAm0l3ahLs2vEUxDx8O8/cCSl926+gaIFA?=
 =?us-ascii?Q?mjS8Yq/OSgaLdl3EYAm3PBd77GB24S/JWUHNMv6ldKT14T/Bjz6hWC10a/U0?=
 =?us-ascii?Q?1KRLq8umB6XaAwUNGPDQfMf12WYlHuEn2XPDpx3iRBlFvZ2Ed5KVE4JURfrH?=
 =?us-ascii?Q?jtGGp5g5xgHBnbdyqvjb5B+SAfOd58hGzjO97Z/2i3lkVxDrBxaiE/EDOuvQ?=
 =?us-ascii?Q?1kXc39X9L5LUkqQsROBHogFC03FF/9tElSpw1HpCJJeVA9tbGde4ZlzjuIh0?=
 =?us-ascii?Q?4b7soMRP91s9RMb+MWK4wqWE+vZc9MchViELQCGe2RNm45BkHvr0wahUXfjQ?=
 =?us-ascii?Q?p7ZjYUjDUWcMcMU63JpqNXfYYROFD+1fj4rt9RV9h0ZFvwMytfuv9igfdYcI?=
 =?us-ascii?Q?X84qO7qyzdwtJEBs20al0bMqHAUacsYNNCua4A3OmJDWb/kvcArJK4UgGy33?=
 =?us-ascii?Q?UhjIM5Mw2Is+RcUNDfsOxs0NnwdVvEtuub549cQ95tf2oKXsjWNLngfwje4Q?=
 =?us-ascii?Q?GyMGwtdu4ui7m9QIAPvTglhcDpwWE7fd0JX9nkSPVM6CCnJXha3oyUizx0T+?=
 =?us-ascii?Q?PxPeWCP9YNRbyy82tIDYD1A/QD9FK0D1E3HLWvstM28IBcHB0ThgMSrggF5Y?=
 =?us-ascii?Q?/p7T2AqnfOwwCo+/ygVhaNetJ8RTjZnVEQQLUtWhQylmmayLEJ7CkMNXOHRI?=
 =?us-ascii?Q?ZUMJSbllI1XPMGnP4//z6y+4x+Q+0znIFBiIeCZMKPHxVrh0xNIkuJPHu+XB?=
 =?us-ascii?Q?JWFMREfWE2M1azEizgTsoXSPwUzLmUpRJGxKqQ9foiIjwLT4oj3MfmtRRBad?=
 =?us-ascii?Q?+6jaOV6vVgTX2h9ZtKS9sZ7EptbBdUh98LV4ZUX/bjgnBffkXFYQloSJb+Cy?=
 =?us-ascii?Q?KARM9WsnIoG4PLx1tKPoiSsYdHLnDMZtk4jOLEZtP9wvgAGNc3X1mYuAPl9o?=
 =?us-ascii?Q?cEHZ9OvjYvce1v2lGDhHj/p5hTDIXS/+EhYm1II3rNnJlchNEcZhwXnxgDGv?=
 =?us-ascii?Q?d5GekAKRdBB2/qCr3ZpLfygU1gZKeZOy2KUyfWCR1A8J3RLyLcouPCRnzNs6?=
 =?us-ascii?Q?YEdcIT9Yrcw9HpSnrlvX6v6jPYQP6qVOTWLoV5YbPMkBsvUTbUgCn6ZYYymf?=
 =?us-ascii?Q?a7uMutGjecoHW9L+8zj9HtSVJZetAz/la4QNoQw77EdOJk+cuvKzN9JIWWRS?=
 =?us-ascii?Q?KOnEBGAHAK8onf/VK4hMwrRc+wwp/FjwlWTvAYFWJMjLfN8ds2rczjj7NJOu?=
 =?us-ascii?Q?EFBM3Q1xWPY8+5WMn2+eqxfXZufE7r5wZ5XVh8BlNPHxdVbvXg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z/RQgTvcW0ZaG2XiIhTfMGsq0rT/2cinvalEmSd7HhY8hpuFhFe5kQrQpzlX?=
 =?us-ascii?Q?/AOicppJIUppUpBtsit34gM+geLzCuThVUD3l598IgvW4DPxny7wDKuJNn9r?=
 =?us-ascii?Q?uCFLrF70meWSstSt/S3aQFY0U2a/mHcXZJzDTAY7HPrVEQ+O4IP4bDAHHbSf?=
 =?us-ascii?Q?aJT3ApwGJtfhhXYQyVinNkA0gOq30f9vZ4q5bzhcIOfVC4UhdK8nl3LdCwGg?=
 =?us-ascii?Q?om2sZ33dHf0TZ22itvh1mhRSUUiw8JLx1sJ9UpMfuAVYVGoYETK703SnShsc?=
 =?us-ascii?Q?74ifGF5C1dXtYLcNa6bJjfno3I5fvdb49zujfXSO+kyBJUeS3wzw3X0QiIqr?=
 =?us-ascii?Q?2Y2gkmJJ5aqWoSn3LxCUVaTsM2AkEFNAaAxL2ZIrpN3WU1KP8OJE+lrlJzp/?=
 =?us-ascii?Q?1ugFwYveCoYKNRioLaqa72ASC84aa0q1U94gJ6d5K4OHf/NvvgMcGwAoNumg?=
 =?us-ascii?Q?eT6Cx5BLaEd9RxqsFULdp4KATl+4kN1guamZ866loxfMdvAJH1d7+tN2wVTV?=
 =?us-ascii?Q?x/BR0991SV4+pEUpGc8+t7nzVr6b55BCqitToBhOOUblk5L22sJTr+/DrD9I?=
 =?us-ascii?Q?UlJQv2RyA+MdkjSo8z7qaKDOTN0NEP0+M7Zo/JcGwQybC3kFDfm509duSOpx?=
 =?us-ascii?Q?1eYc2tTwa4nMlndIrnwjSwTUXUPS+OGItt8MBW1DeErKYttlr0gGqYCn8Ew9?=
 =?us-ascii?Q?/o+ome+YRpNbMy3cOUIIFUQcYrDSooL65EJrz8YDchsc89UGjntA3GWCACWC?=
 =?us-ascii?Q?GXtksydxy3+FFoB0mbKUcdv7BvPMAbL7+9pFP6wsQ3W5zrA4wPsAOxjg6FWB?=
 =?us-ascii?Q?NvbPV5V4IEo9yofC0va1DJIF547PYgt+aA4L3kaBk2hWl9Yw3idArEh1lSKA?=
 =?us-ascii?Q?KiDfxfZ+I/Xy1tVTuvmS936SKyI9WJ+M1VMrSm2L0N8aSe3PHzEj8jydyY66?=
 =?us-ascii?Q?EiozTGUI+pnsuP4CO6zaCv2QnZTPmQOjAdpVHHhacRWpnCJSo/ptjE4URMCZ?=
 =?us-ascii?Q?XMS+Tb7HJU3NdL43g6HIhoibRb5z765ta+2NrZ24HYfziGc1v2FkdC6QpPzg?=
 =?us-ascii?Q?bw4ijaa/JGzJlas6iRanpnWI5Cwi/exVW3JAIlb6AYhUmVxjvRLOWLmjeHGR?=
 =?us-ascii?Q?JBRWTjSGvsIaiZMUHlN2ZezKc4cTy7+ihmSCpuSTWatjk1qmqNZwt021Nl0U?=
 =?us-ascii?Q?SEm8NuXxZq9gaVGVJDiXqxMr5VWHqXRpUbzDhbNNiijES78OVr30Votmpac4?=
 =?us-ascii?Q?yYV5sgMobzw5avs6W5WQfVD0xusdj8ptbXoK2oaBwJplvgwvQsImRq5O9VoQ?=
 =?us-ascii?Q?QQE3ndSGEX3+SpMY1FzeV4IMvT1MM+7fpCmphUNtd0Gsc5xOh1IhlW3MshKd?=
 =?us-ascii?Q?PPhkd0jMEb8s20+yiF0C7a1LvQo0I9nPtO/Tz63pXDRlD+knj2Hy1fMKaA1O?=
 =?us-ascii?Q?U1bJigETHZMuGGJz6d4MFMcOgHjnfBhWzxf+RPt7Ro+TmkAi6mFLgQ8e+4zu?=
 =?us-ascii?Q?oesyvoa7c3oZhkalum/49ZnjzrmzMDfiJc3CBZHR0bNNT9tzYE7XM2q10aF8?=
 =?us-ascii?Q?+aH/RUiEQran3WEfnuc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144D67F0712B20544D00E7DF7632BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a1687-7b28-41c9-d3a8-08dcd8d7f6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 18:22:04.7686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJycBC2UZNYsVJNycIWs1QeVz7l1ccaQ7pFgeWEARQdR+yMQp0fNa7bh/HnL2LSKramEly+StnTaONMz3NTlbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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

--_000_BL1PR12MB5144D67F0712B20544D00E7DF7632BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
Sent: Thursday, September 19, 2024 1:53 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Jingwen <Jingwen.=
Chen@amd.com>; cao, lin <lin.cao@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yi=
n@amd.com>
Subject: [PATCH] drm/amdgpu: skip coredump after job timeout in SRIOV

VF FLR will be triggered by host driver before job timeout,
hence the error status of GPU get cleared. Performing a
coredump here is unnecessary.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c
index 381c886298bf..13a3604cf107 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -107,8 +107,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(str=
uct drm_sched_job *s_job)
         /*
          * Do the coredump immediately after a job timeout to get a very
          * close dump/snapshot/representation of GPU's current error statu=
s
+        * Skip it for SRIOV, since VF FLR will be triggered by host driver
+        * before job timeout
          */
-       amdgpu_job_core_dump(adev, job);
+       if (!amdgpu_sriov_vf(adev))
+               amdgpu_job_core_dump(adev, job);

         if (amdgpu_gpu_recovery &&
             amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->par=
ent)) {
--
2.35.1


--_000_BL1PR12MB5144D67F0712B20544D00E7DF7632BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yin, ZhenGuo (Chris) =
&lt;ZhenGuo.Yin@amd.com&gt;<br>
<b>Sent:</b> Thursday, September 19, 2024 1:53 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Jing=
wen &lt;Jingwen.Chen@amd.com&gt;; cao, lin &lt;lin.cao@amd.com&gt;; Yin, Zh=
enGuo (Chris) &lt;ZhenGuo.Yin@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: skip coredump after job timeout in SRIO=
V</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">VF FLR will be triggered by host driver before job=
 timeout,<br>
hence the error status of GPU get cleared. Performing a<br>
coredump here is unnecessary.<br>
<br>
Signed-off-by: ZhenGuo Yin &lt;zhenguo.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 ++++-<br>
&nbsp;1 file changed, 4 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.c<br>
index 381c886298bf..13a3604cf107 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
@@ -107,8 +107,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(str=
uct drm_sched_job *s_job)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Do the coredump im=
mediately after a job timeout to get a very<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * close dump/snapsho=
t/representation of GPU's current error status<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Skip it for SRIOV, since VF F=
LR will be triggered by host driver<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * before job timeout<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_job_core_dump(adev, job);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_job_core_dump(adev, job);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gpu_recovery &a=
mp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; am=
dgpu_ring_soft_recovery(ring, job-&gt;vmid, s_job-&gt;s_fence-&gt;parent)) =
{<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144D67F0712B20544D00E7DF7632BL1PR12MB5144namp_--
