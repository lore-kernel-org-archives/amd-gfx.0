Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D67C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 13:15:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D5F10E9B1;
	Fri, 10 May 2024 13:15:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Exn0uqIX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17D6E10E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 13:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmdKtiCXq5KJHH/6CO6/j5t9B9EcT1uKX4IxvRsovvFP8ovT7RIAOnuo3O4hQ3R+NNxFF1+VPYS1xIS7R+AtuU7I0cV3WrxMHJmA8gZre7nkbsvqmhFvOtyznNPVbjmwbQScpRVF4GHgqfE919dBpkLNQsCy9YYIv1Qh2JXIJ1aD8T2TlcKcnZAcwHIeFaOF0XgN41zhlPf6QNTgx1WSGBoTi5t0/u3YD5kib5Wd8OtQZXg9M18+AzvpzX2lmijZ8xx7xZS/VU7QJaJPnN2EeZO7tcZLsYaCwALGDfFhHekQbVUIGoD29qoLpoNJndeiKBa/dh7hnPhpX+0ZZsUhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvKTOJPWdB5i5fllgAMxctPNlx6GwEQuTpF54+EU8WE=;
 b=OLstMIPOy0EBv73wemE1dCH5FL5BVm9kFr4jCdfoxhuscyLtz12+5Q1yDKqQKVuvGRvkxfhCGCc1as8B0ctjTNiSY3M4rTZ+GD3zlmtwdnifNG1LdbWC9uzxpyjMnnrTyJOpV7WR0ovBoSCxUBlrp8HSIWdReHuJjzKapHWLdONU1pYBhpbDfXxVzJVnCfqT6txhDWPYzy28/r3TsWKWgeor8eutVZKGm+awjwCqH69n3FOF0dpaNrOkUAiuRVK8xY7K/50hNS5Nj17jU2gZt0E+hvWCmXj1/tlo0mMFAQpU97QZTSCjWkuicTrPLci76HOVwaVE0M2PTngSS+nviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvKTOJPWdB5i5fllgAMxctPNlx6GwEQuTpF54+EU8WE=;
 b=Exn0uqIXlOQtby9YokD5yMCjeaAuvuI/mTQj0WX0ZR1f4sE5bZDkCiS1vTqCZuu+P86u88iljHxO2oHLFq4iG1eFUqRFRp3vsX3h1BHrNmymFTbsB9djKxNjEECtSrrDTXnpY37vTIlu+lE+v5Ko5UASZ07Lq1qQ+wi2oldJzrM=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:15:05 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::fddf:5872:b8e2:9563%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 13:15:05 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: set VCN5 power gating state to GATE on
 suspend
Thread-Topic: [PATCH] drm/amdgpu/vcn: set VCN5 power gating state to GATE on
 suspend
Thread-Index: AQHaoktbRkNTviX2/EGyG4QIl+xD3rGQc2Mg
Date: Fri, 10 May 2024 13:15:04 +0000
Message-ID: <DM8PR12MB539909B185846EDBA36C305CE5E72@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240509195851.1481475-1-David.Wu3@amd.com>
In-Reply-To: <20240509195851.1481475-1-David.Wu3@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5abfbb5c-4119-4578-a5b5-ffaddec4e8f4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T13:14:28Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SA3PR12MB8438:EE_
x-ms-office365-filtering-correlation-id: 3bead9aa-66aa-4df1-9c57-08dc70f33514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Pov76eu7BDrF+bsU3AkdiCmAPy93sQ8Csf018RbP8xVPWKxfySaQk/AvvjH7?=
 =?us-ascii?Q?adUdfLw8xGY/oig/jRSVv53I14h/lhIU9v4IZSQYx6dWFWFm1guZzo7qqY8e?=
 =?us-ascii?Q?699+gCsI1phwihKU+g5Hy9VrmmN9TvkqPl6gevxUIXCla7Qbg7R4R4jc7idD?=
 =?us-ascii?Q?WUKY8eH5epgs1kCBIySlmAGiE8JpZdZQ708rnlPqN2d8+RN3cYqlOHYAtXyM?=
 =?us-ascii?Q?lM+NFXfDGulITVxcAro3EYvmHFivMK44mbCKqpKnGupCKU/dXhGxedlb8ezu?=
 =?us-ascii?Q?VDaZeqjuJPk7uhqxyTpINXLwNSyOPdEw58NFR11pLvt8cRZO2QhCUZzQZvdV?=
 =?us-ascii?Q?rrXGibhawi2M/m6XiV7rAwbB1LKHEgJvcKL+CjmFOuYnjnrNPRniNNH8pnvf?=
 =?us-ascii?Q?SXfER3V61xW5PL+I/P18yRvrVamtYEWz+Ad4LL9LDk223tgXMkpJ114ZsAtC?=
 =?us-ascii?Q?Y/ERTG+jRZM1SnXgRaFa/9bwg4YDMhk4TjCBfq9wpDHHJKq4KvmoO4oK4//P?=
 =?us-ascii?Q?frcWcBD2qHGuWZW4lc+/mh0v65SUYraDGFkWDm2sALxLBOvpHUpRokbeyk+j?=
 =?us-ascii?Q?C1mYqx7ei7FItgeXk3JP+t8Op/diZ3tswW6WKHGoHi2IifjbQzIA+AHnqNnH?=
 =?us-ascii?Q?TMi9TsuUD0/nsvA5JR9yOanP5dYiw52nLvgWsJxjvenwxihLZ2FozeI2rr0n?=
 =?us-ascii?Q?KKyQn6ivQXuNWhzMEPLgSiGdQB40bnLZNPi8AJzKvSGwTaXi13P1l06hjytf?=
 =?us-ascii?Q?0/+Z862O66nUIaPfeOdezcdRAkA83lKjoGDQnlV/+uQWOZ0CTTOOYaQh3DBg?=
 =?us-ascii?Q?ARJMUTr3W5neNLWuynepJ+ZQ/7FLHPee5646rDMbu27UQWQXCmc6Xz3HST5e?=
 =?us-ascii?Q?5GLHpRaAIatFqb6ou3xFzTGlj5Y3him920c6PpqW5zko3wRklA+eV4tagaJa?=
 =?us-ascii?Q?hfnw/+PlQ4o0bShUa0pzoEx+9LOU+N2IBwM6AxkrrZ3zg0QzHa1jhhSYQYr+?=
 =?us-ascii?Q?Z+RLM97bCDHMhymIxDlbo+B9UTo6oz4g0wnO4z93qgCLk6zbzf0B23oK744Y?=
 =?us-ascii?Q?XIUkezqNBm26I4TTYHbszWfKCotaZRua3c2DYJzcOsoXEjNYo9AGM76Pz2N9?=
 =?us-ascii?Q?og3YPnpTFjPdfHk1FOCodVBZBlvR3DCv5E/lWResCwlwXI11cS6MF1LQyIok?=
 =?us-ascii?Q?4h3IxAtmzCi0cAxiyHO+8QAe4n+X+fIGt+3wQ6cWYDMu28b1k+RpoKuZi7xw?=
 =?us-ascii?Q?Q0gGa0zU1Uc1z4qbngyXWVZF/Tm0cS0eAYfDEO3E1pRvcTFahlsViiwghvbT?=
 =?us-ascii?Q?J/vn7W7IpS2dDvznXxf99B3S7t31wVOIzFPnu4os8o1+Og=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uDaxXYBDCaziicmkw0kJPYpcRJyzQI+OwY8kneS6m3MPriqTzfzfxux7FxXH?=
 =?us-ascii?Q?QCx2du7b5EETcm6VTmk9TnD+41oeKoWGIDNXCT6vJaTFVPH1D2ZE6BX8MFSh?=
 =?us-ascii?Q?v343gR8GolG6XWK9BiOYpx6DDl3Z7Mgurbc7s9oqUz6bcBNU+bDcLpfzdyB/?=
 =?us-ascii?Q?gUtTQP9lD926GDc4oNxrKXeH9HOiZMwFRBPamNUmTssNVmzm7eLvfmUxbdNj?=
 =?us-ascii?Q?kN7TCcvVtU0/g9j3+29drfrMuYxER3iJARIpS9Dv1oQR3vZV+DhvkQ0KJDSe?=
 =?us-ascii?Q?uWMuLJQSlsWeP92HecbD0njgVt0yMWYZQIDoBOpxh2CuyofHLK8TZ8RwVtsF?=
 =?us-ascii?Q?iu9J3bOvWfseDupoaEe+MuvArZc9Q1V78vidwzB9kNHAjUGfj4FgONztiOI2?=
 =?us-ascii?Q?fZDG2YNKzBJrNU/wAB6mWzzogXmY3igDEwgGdi4fyDa4zsbEzE47mR8VvSGF?=
 =?us-ascii?Q?ccQcDijdf4AmcL9/dqFFg9YAUt982+M+JibDJb4K23n+5tMsg6tdslbCoBEi?=
 =?us-ascii?Q?kNivC6zj1IY/rD4VZUxUwkqDNW6cgsGprT3LlXbQgRyOqDDwWAVQvoETmbWi?=
 =?us-ascii?Q?DmFMMuWIhJLz/XOpCm+YIOahoy0VVGB8SIzLT3fpcpwkE+UPss07cNnsYGpb?=
 =?us-ascii?Q?W5PEnHWlFCrDE1dcM/iw+D/LJ6C+4QP/4hiFPhHHLBWeTP0NOEJ+rOXDKlGy?=
 =?us-ascii?Q?9DWzRJYbaclZqqf0ZTGUvsd00A/s1HlamKgtNSnWv9dybbgxdfPa8qGWPpUm?=
 =?us-ascii?Q?IcFRxjqE+JD2vxgWSAAwx7sfJcafwXKXet5I0QodFkSAUJlL8Z57ZSMwy5nK?=
 =?us-ascii?Q?P66LxAsdBGnMMZVjkNr10eWeHyOs64eshcK3XRJH55wcv5mht1mC/PAYM+Zr?=
 =?us-ascii?Q?1gYQFKyk2rg1NMvmRvZN4ZmEsWB3/ifmCi70AoGF9dJn14qZ9icNz4IE5H/a?=
 =?us-ascii?Q?KiJGUBN4Vj37huThtHHOY+dBlpeT0F7TReH7QlWF72mxtsxJWO9KmX7pjTjg?=
 =?us-ascii?Q?InKeLo1ah9DH3fqC8v/VTSN2kQmHC6Tp3iJM5LVyAjChTLLbABr91lU+PWH4?=
 =?us-ascii?Q?2BGpM//moPil+SUOWdRC5VpesW0Yii24s4eoDIsL6seOnjDnCduhELbn9H7j?=
 =?us-ascii?Q?v+JqFcJYqL6VxN+z1SEKWpSHtZdfQSbDMKefhLFwgLaR6PeHouWjXpeeVW+D?=
 =?us-ascii?Q?2+tlnhOSu2cDhdzvQieX/VWFmpjcsVOSRLfNV3Cr54b9zwI/LlEeZ7Zo6KQc?=
 =?us-ascii?Q?arplbp6sircXfeuVv+zBIqXXTj7NUs2I5Y7ZUegbqLvJMzOr9oxkhJNWaQhd?=
 =?us-ascii?Q?T20JvECpHYnC6nemjmF++U/j5qcymo7Q0LblJrtqnv0xleqyKZBcS3f0/7ug?=
 =?us-ascii?Q?byQZFz1WK6HlSz21ihbo/5lzS8vFhz57NjjkBiNek1cZb19Vmted4uObKn8T?=
 =?us-ascii?Q?7wQOZOWIrk+mwySHHdMsaWhzh32+Q9ytj4rQIhan5fAOcfRcVlX+CNfSJYDt?=
 =?us-ascii?Q?hN15aWxvyovfqnHZGBF4aNaJs6MWr44yE9c/B6UyKAS1LOkXCWHihWLGe/Z6?=
 =?us-ascii?Q?mu/aZmLz1RzD9S4/x1U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bead9aa-66aa-4df1-9c57-08dc70f33514
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 13:15:04.9460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQ6G8GfmZYUZ9GcwNmKm2GRXnI2RnBRYRFhBKwlgZgpDzRJuOyO2hKBZzOKdb+Hf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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

[AMD Official Use Only - General]

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 9, 2024 3:59 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>
> Subject: [PATCH] drm/amdgpu/vcn: set VCN5 power gating state to GATE on
> suspend
>
> On suspend, we need to set power gating state to GATE when
> VCN5 is busy, otherwise we will get following error on resume:
>
> [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_unified_0 test
> failed (-110)
> [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
> block <vcn_v5_0_0> failed -110
> amdgpu: amdgpu_device_ip_resume failed (-110).
> PM: dpm_run_callback(): pci_pm_resume+0x0/0x100 returns -110
> PM: failed to resume async: error -110
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 9b87d6a49b39..36d4ca645c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -229,6 +229,13 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
> +             if (!amdgpu_sriov_vf(adev)) {
> +                     if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> ||
> +                             (adev->vcn.cur_state !=3D
> AMD_PG_STATE_GATE &&
> +                             RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +                             vcn_v5_0_0_set_powergating_state(adev,
> AMD_PG_STATE_GATE);
> +                     }
> +             }
>       }
>
>       return 0;
> --
> 2.34.1

