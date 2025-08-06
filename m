Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182A6C87FD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 18:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADE3610E16A;
	Wed,  6 Aug 2025 18:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aM1mjFVY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0326D10E16A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 18:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QkfVjwEMe/P/pGu1PZ0COrXG/piIh0p8SS0YUUrLY9CxHi3uUluFXZLtHVH2zXGBY8urlYYl9SCbkw98hsg4BCBTnW5e3VpFO9+8qXBXrf3WTztES5gQ+WO7zWmpbgA89wx5wegjLONYFu8hPhgCcRMwU5kQbC3vtchTL3lgbSjpSvAQuV+fvslJfYvONPqJqpTM024Y9Azfi0TrnlCv4JGg93xkpbuGHLaj0G6eLCvh6gnnnN//GRJH1XDLCTOILeeFfDq/RU7lW+9fz2tNbpjGJg+I6CGVRbe8JmMJzjnJ6vdzpd+RWDrOIu23Ugpm0UO2CCLEnMedFbHgJyiOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I29en2zn7fELLakSX045zN/5CDtiNZN26n6YBhhUFk=;
 b=XHqNBp9h92rlrvAmHOtaBxQnrvVm0LlNr3GhfFGkLW1ozHFAKCu2IXAP0foVI7F8aTy07+XIRPSx7HFpQGB7h5VkM3C5Rjrermlbu2RpxGsn22g9oBIZhhWVtZ0ANAq2nH4rJyFlmEWZ92asrLlnm9V9HbHqcE432xHncL+Xfv+0AMiINjF0+TIfn5kBa9+Ts0/KGgkJBZHOyPlvZIrt07yHd/t1xDjCIgwkJxhVhf1Pp0A/qlJPL45l+ixdqhlINcJ7SjGf0YYvI5z4g7Tp7B5E027f/KgEzBXRgYmoh4egEcCRk/iWUhILe2hGKEsWFJAmfYup14N4jDYYfIzmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I29en2zn7fELLakSX045zN/5CDtiNZN26n6YBhhUFk=;
 b=aM1mjFVYWZaPJeOEjRfA2mkQd9SSgZ4y84LQaAyCte1A7CJk+otlCp4fbZ4ugMnaWJD8cl3pJq8xDOq+lRiUYN65vzfQ5Z/AV05R2iFjs2qcDF2bfqdtQKGuI6/XsYt7cce2/LS1TaZSTY9ypTlJs/Xd1jVbCh8zpfcG51Wy5yI=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by SN7PR12MB8601.namprd12.prod.outlook.com (2603:10b6:806:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 18:02:09 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::fec0:2b36:85c1:fc9b%2]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 18:02:09 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu : Use the MES INV_TLBS API for tlb
 invalidation on gfx12
Thread-Index: AQHcAV4X7894onj5qU2CRs0D7QaSIrRV8NUAgAAA0YA=
Date: Wed, 6 Aug 2025 18:02:08 +0000
Message-ID: <CH0PR12MB5372F959293B08C0EB9D25C0F42DA@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20250730142719.7184-1-shaoyun.liu@amd.com>
 <CADnq5_Ma7Ft1_DQ8aD9B_eGE3J1GPRhAx-U1MvVxbw12mrqM0A@mail.gmail.com>
In-Reply-To: <CADnq5_Ma7Ft1_DQ8aD9B_eGE3J1GPRhAx-U1MvVxbw12mrqM0A@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-06T17:47:35.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|SN7PR12MB8601:EE_
x-ms-office365-filtering-correlation-id: 951b5fa7-c314-4d46-7bdb-08ddd5135c5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|3613699012; 
x-microsoft-antispam-message-info: =?utf-8?B?aVduZVJyUXBWVTl4YmpvbStjcW1jWjhqdjFySitNQyt3RU1adHJKai85OHIy?=
 =?utf-8?B?WHBQcjU4S01SWktqUmFxbWlBSDdFVmZJdmxIenlmRHNzVUUrVERIZjM0aWhN?=
 =?utf-8?B?cnNmMlVJOStVU1M0UlBjTmJTU1lzR0J5SUJWTmo1d2xSSTdFclNyYUF0NEJL?=
 =?utf-8?B?ZmxwUjN4Yi85bkt3R1NHcUpzNmVORXhGNytWNjdBcUtBTTg1Yis5RVVhUHdk?=
 =?utf-8?B?YlBJSE5xR0lWb09ZR3hxbGU4MVdZTzVlR1BKUCsrL0tLZmMreGFpUm5HNXMz?=
 =?utf-8?B?Znc0RFd4MDNoYnJmNkpiVllKdWdBaWU5QTlXOUtoTzFDbkdhNHFGR0ZqSysz?=
 =?utf-8?B?RTQxU2g0QXRsbmdBTURaZ2RlVFpNdk1UNXdIKzMrckYremRFQmQwTUQxUUFR?=
 =?utf-8?B?ZUtYQUQ5ZTd6ZWV5bnQ4VGtOQTlPZ2V4ZmMrRDBxNlRRQ0RYY0ZUSXZoc1Uy?=
 =?utf-8?B?bEZoUkszSUR5MFR6R2FIUE1IN1JpR2ErQ0NJR0VxZmVwUDcvTXJrN1RwR0F0?=
 =?utf-8?B?eHIwamlPQzdDZHNZTzdvUnNlbDNLYmRjSnYyMTF5VG1uOHVkRGk2cjFDaUVx?=
 =?utf-8?B?bndXM09TUXIvaEo1YitFcjBFeEhWb2VuRHZyNldIU1FhV29YVGhwbGxFYzVk?=
 =?utf-8?B?TnRRYjBxUmZVU0JmQ2grb01kQVlmOWZQaUMwbWtZWHJiWmQ3ams1cUcvTGNZ?=
 =?utf-8?B?TzgyZzBqVGxLWHduWnBrakRYbDY3NlkrbjhMZm1jd29CZjFmb3czVG1MRkVD?=
 =?utf-8?B?UkVnZjROeDI1bWUxY1JJd1ZobHZleHZ0N2E4ajZmckYwTkp3ZDlUcjFDMFFm?=
 =?utf-8?B?cWtvdVIxVEtqS2RkK1cwcG12aXFRREJZaUVZRFJQbXM5clp3YURuQ2lRd0hH?=
 =?utf-8?B?WHpyVkVCaXUwbzhEeC84T2MvNVdLNEY4SXFDMEZKQ0UzcUh1ck9zbFRmM2hP?=
 =?utf-8?B?eTR1VmEwREFmMWxOaGJvdlQvZ3pkSzY2MndjK016WjcraHRVOEhTKy91K0Zs?=
 =?utf-8?B?ZFdqUDdWS3htOTJlTXVjVWF2QU5WU1JqNmJUWC9XVVpSakNqRk9scWVsWXRa?=
 =?utf-8?B?L016WXY5bFdkc1dEcGZTTXJaamxuVldwVHp1TU5WTHRTVFh3bVVwbkxQK2tT?=
 =?utf-8?B?dHFhazlkRFBFbkhjZ2tOckFBRm9aZ2xJNktLN0FQeURvYXhjemt5VUlrSXV5?=
 =?utf-8?B?d3JnLzRDUDZsQzZFTWwwZk5iUllhb3RhK2VJV3Q0ZmZQYVVReElQTzlQaktK?=
 =?utf-8?B?ejhlYlIvbkxadng5UGNzRmRyV2dTWjI2K2lOYlArQUtBZDZ6M09QVVZTek9I?=
 =?utf-8?B?eUhvUXErM1ROUmtzN2NsVVc0N0FDcFFlOXhBYXVNeS9oRHRnS0Qza1U1dUxJ?=
 =?utf-8?B?Q0pMN0UwRmczRTlEMTV3a3c3UnhJTGhTSUFLQ2w2UXg3QXJlSzFGSHFxNlg3?=
 =?utf-8?B?QnZ6UEtUQkQ5TDV0MzhOUnNnb2ZTNWY3cUx1Y292Nk0va01JZkphaW1XSVk0?=
 =?utf-8?B?UHJqcDJhS3dkMFpybGtiRy81bW5YckVET2lYeGRLcHpNbHVUQkpSamxvOFZs?=
 =?utf-8?B?WEdWb1Rvd2g5L3BmM25TUWU3ZXJFTlVjMWhlSDMrN1ovS0lONnMrMGU0c1Nj?=
 =?utf-8?B?dkxJTUlNV2pBTWZHSDVOVWZFakJ6ZnB1MDFyckhPU2tXUFEyTFJaMXdBOW02?=
 =?utf-8?B?WWhESzBsYzFwVmhmbS9qbnRtK0hqbHdaNmFCc0N1eTZteTREUms3cEZKdzV5?=
 =?utf-8?B?elVKR2U2azEvdmhGZ01EbEhmRmRwRjYycDZxb3pYZzA0TFV0d04zZktzaGdB?=
 =?utf-8?B?c1hEeitDOU5NdjdaMy9aYjM5czY1am9qS01WanZHdHlKZFh5bW9BMzdtSjR0?=
 =?utf-8?B?KzR4bGFrMGUxa0hiSFdrSVdBaHJpTGhHYjVLclkwa1hVYlFHMHNaWm5obkc3?=
 =?utf-8?B?S0VLcTgyeEF0aXI0M29UZU1Pdkt6U21aLzhoMjlvTWh1cnFqWllselBDUnln?=
 =?utf-8?B?QUpPQ0wrRnd1YjA2MjJSbktCR1Npdno2L1FSYkVaa3FscEVGSlZpUmxpUnRm?=
 =?utf-8?Q?1TkqmV?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(3613699012); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUVybHE4aUYvYTFYL0ZBTERFNHl1V0daK0JOc0NwSE96bVFFdDRYWHE4dWJO?=
 =?utf-8?B?UjgwRENaLzErM2pydTBkMTIweUM0ZDJUTUVXZkdoMkJNenR2MDgyLytwck1C?=
 =?utf-8?B?NVNETThnWUR5YUZtL3VmV0NieHNRcW1CbWtRRXlxTmlQNU8wS0ROZjZUU3hl?=
 =?utf-8?B?Nk1JQk5LeTN5ZTNQcks4ZDNCNjUrRS9rSGpvbjhtQzl2Mk9xN0RURWIzZUtn?=
 =?utf-8?B?OEJsSzVKOVpXS2pLTW01dTB1TnJUcUxrbkcxZ2ZyS3Z0WmFncktId2tEbkdr?=
 =?utf-8?B?YjF1dllRYVo4SzZidnlCMnFXSmJzd1JiY2U2WTNDK0NQSGhaanJkWjN0TVVt?=
 =?utf-8?B?V2pKSEFZODNqdmYzQjljRjRJVTFtNjBwV3E0R2JOcU5kS1g2Rm1abWtkM2ha?=
 =?utf-8?B?ZEo0NVY0MkFVeURDRHl1MVh4UlZsNlpXL1dERDVsOXNETHFkTXFXdUJyQm4x?=
 =?utf-8?B?VG04Um5STGVvU0xIdVZYdUVDWVgrWjZ2QnRoQUZEZ21IUEhtb0lrZU9jbjVZ?=
 =?utf-8?B?QStkbFZoSVk3Q0J6M2hiUHhKTjZZdmU2Szd1TVZYZEZjb0N6K2xpcEYzRXcv?=
 =?utf-8?B?RWExQnU2eFpNK3ZJYWVtbVFxSnk2ZkUvb2JWV0VPSVlTRzJVNkF4UlVKYTda?=
 =?utf-8?B?NURhODM0Q0tPRkNBUFhZdVIxNFhIZVl5K0pMSGpzVWxEaFFWZEpGaU8vdFlu?=
 =?utf-8?B?aVJCR2kxRHFOSFZEanJsMCs2MFlpM2NDNmRXSUtudTNvRHN6OWlPWFI3MjE3?=
 =?utf-8?B?ZFlCRm9UVWtjQzJUemZ5c3hUa3BXTjJPdko5eGtBK3NiZlBtR1dLcTBSMXY2?=
 =?utf-8?B?Z0w2S0RhaldwbXlpczFVWU5Idlk3Nm9LaDlXL1RET1RqR21wVVBBLy9Dcm5Q?=
 =?utf-8?B?NUttNm1YYVVIeXMzN3hRS1pYRUU0eVJDRmlMbXE0OTFIMVNWNE96enJEVDIr?=
 =?utf-8?B?d2l5MTF5a0ZadDhnZXNERXp6YW1jclRyY3E2MkR1Ri9oZUlyaDlEQis4YkQ5?=
 =?utf-8?B?elRwWnZMN2xaZHVkK09RNkw3eVRDMUZCTjVqMU9TQkt2cFNWSTByenhpU3c0?=
 =?utf-8?B?aXZzRlFOakpzK2F3c09oV1l0ZGltUmE3ZlIyZ1ltZXN6dElzZDErN1haUmN1?=
 =?utf-8?B?SXJVQVZlNGZiWTBLMC9uV0owOU1TYU1OT2t5YXAwMFZ0NDZ1VTZZWFhUYWVT?=
 =?utf-8?B?aHJ2S3VoU1JVMlpRLzdRMDMxVHAzMjdkTXZLN1kyZDhwM2tqQ0ROY2hKcE0v?=
 =?utf-8?B?djVCOHc5L2RkWHhqV2RJWXJObFlaZmtJczJkUHgxUzRHbWV0cmtzSHE1TTJL?=
 =?utf-8?B?Uy83MGhUc0xXeDNPd09WS0ZUUjhRZEF6Z2xJSWFERUtHSi8wMHVRV3NkalZD?=
 =?utf-8?B?UnJwSVhRNUZYMVZoT0ZGYkZuZVZBVXVXeHZVeGdSZCtxTU9EalFCQ2h2bGpj?=
 =?utf-8?B?bHo2QmJBUnJsNmxEOHkwelNpU1o5NjEzYUJ3TnU5RElCbTBPeHRKQ1k3ajlx?=
 =?utf-8?B?OTJJMzh3bjNpSENZbEJnVWpMdzZ3dTRDSDIwbW5ZdnVEcjZCOFlqMW5MTnIr?=
 =?utf-8?B?eGtIcDF3Si9jY0FuQmdHT1hsSW85ZnZBQWg5ZDJ0ZlRPbDhubGMzUThCOE9B?=
 =?utf-8?B?ZUQ4cHpnV1hvTzJrZE5NNEt2LzM1WWpqTEp3d1kxMlBzRmhWTEpRallIdUZD?=
 =?utf-8?B?dFFMc0FlY2xvVU1CaXlVRkVHUlVXNHI1THoxbWpjdTZkcmlzMWp4OFBaVnRv?=
 =?utf-8?B?NXdod2p0blorTnh2U0hFZWQxd0hWbEFJeDZwdGcvdEV2MmNxeTBOT1BZN3lq?=
 =?utf-8?B?ZzQ4cGdFQXFuR0lPdGhOVzR6bnVERzRYQ2s3SkRNemVQalUvRFcyWUpsTi9O?=
 =?utf-8?B?SHFtSThZVmlWdmZ2RjVGcGxqL2FITVBKSEM3SjFQTnVhZmdJaXZvR3diNWVE?=
 =?utf-8?B?dXU4aGNnYURtZnJmTWpSd2Z6OFljRm5zQlhUTkRYZWJSM3FKaWNUQk5jSDFN?=
 =?utf-8?B?aGMzbnRFV3IxTjFabXpjSFlDa04wOUs1ZWg1eXlKMVhURlEvWEZXUldnak5z?=
 =?utf-8?B?N0c2UVNGUnpld1gvNnhsY09ZRng0MjErZFZ4QWYzRlFSWkJhSWVzUFFHNUJo?=
 =?utf-8?Q?MxVM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b5fa7-c314-4d46-7bdb-08ddd5135c5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 18:02:08.6730 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcdAost8fvgnix0OI2fsoLC5NSKPIXMa2wlRyVC0a6R9S14V1Ta2PftyLdKr/vsYQUwE32h1PFTn/8kdKC8PLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8601
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNl
bnQ6IFdlZG5lc2RheSwgQXVndXN0IDYsIDIwMjUgMTo0NSBQTQ0KVG86IExpdSwgU2hhb3l1biA8
U2hhb3l1bi5MaXVAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWQvYW1kZ3B1IDogVXNlIHRoZSBNRVMgSU5W
X1RMQlMgQVBJIGZvciB0bGIgaW52YWxpZGF0aW9uIG9uIGdmeDEyDQoNCk9uIFdlZCwgSnVsIDMw
LCAyMDI1IGF0IDEwOjMz4oCvQU0gU2hhb3l1biBMaXUgPHNoYW95dW4ubGl1QGFtZC5jb20+IHdy
b3RlOg0KPg0KPiBGcm9tIE1FUyB2ZXJzaW9uIDB4ODEsIGl0IHByb3ZpZGUgdGhlIG5ldyBBUEkg
SU5WX1RMQlMgdGhhdCBzdXBwb3J0DQo+IGludmFsaWRhdGUgdGxicyB3aXRoIFBBU0lELg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGFveXVuIExpdSA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCj4gLS0t
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5oIHwgIDkgKysrKysrKysr
DQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYyAgfCAxNSArKysrKysr
KysrKysrKysNCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMl8wLmMgIHwgMjQg
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlv
bnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9tZXMuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPiBp
bmRleCBjMGQyYzE5NWZlMmUuLmY0YzQwZjFhZWNkMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21lcy5oDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9tZXMuaA0KPiBAQCAtMjgwLDYgKzI4MCwxMiBAQCBzdHJ1Y3QgbWVz
X3Jlc2V0X3F1ZXVlX2lucHV0IHsNCj4gICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlzX2txOw0KPiAgfTsNCj4NCj4gK3N0cnVjdCBtZXNfaW52X3RsYnNfcGFzaWRf
aW5wdXQgew0KPiArICAgICAgIHVpbnQxNl90ICAgICAgICBwYXNpZDsNCj4gKyAgICAgICB1aW50
OF90ICAgICAgICAgaHViX2lkOw0KPiArICAgICAgIHVpbnQ4X3QgICAgICAgICBmbHVzaF90eXBl
Ow0KPiArfTsNCj4gKw0KPiAgZW51bSBtZXNfbWlzY19vcGNvZGUgew0KPiAgICAgICAgIE1FU19N
SVNDX09QX1dSSVRFX1JFRywNCj4gICAgICAgICBNRVNfTUlTQ19PUF9SRUFEX1JFRywNCj4gQEAg
LTM2Nyw2ICszNzMsOSBAQCBzdHJ1Y3QgYW1kZ3B1X21lc19mdW5jcyB7DQo+DQo+ICAgICAgICAg
aW50ICgqcmVzZXRfaHdfcXVldWUpKHN0cnVjdCBhbWRncHVfbWVzICptZXMsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtZXNfcmVzZXRfcXVldWVfaW5wdXQgKmlucHV0
KTsNCj4gKw0KPiArICAgICAgIGludCAoKmludmFsaWRhdGVfdGxic19wYXNpZCkoc3RydWN0IGFt
ZGdwdV9tZXMgKm1lcywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1l
c19pbnZfdGxic19wYXNpZF9pbnB1dCAqaW5wdXQpOw0KPiAgfTsNCj4NCj4gICNkZWZpbmUgYW1k
Z3B1X21lc19raXFfaHdfaW5pdChhZGV2KSAoYWRldiktPm1lcy5raXFfaHdfaW5pdCgoYWRldikp
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEyXzAuYw0K
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTJfMC5jDQo+IGluZGV4IGZlYjky
ZTEwN2FmOC4uMzIzZWMwNDA5NGVkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjEyXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEyXzAuYw0KPiBAQCAtMzM5LDYgKzMzOSwyMSBAQCBzdGF0aWMgdm9pZCBnbWNfdjEyXzBf
Zmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAg
ICB1aW50MTZfdCBxdWVyaWVkOw0KPiAgICAgICAgIGludCB2bWlkLCBpOw0KPg0KPiArICAgICAg
IGlmIChhZGV2LT5lbmFibGVfdW5pX21lcyAmJiBhZGV2LT5tZXMucmluZ1swXS5zY2hlZC5yZWFk
eSAmJg0KDQoNCm1heWJlIHNwZWNpZnkgdGhlIHBpcGUgaW5kZXggZXhwbGljaXRseT8gIEUuZy4s
LA0KYWRldi0+bWVzLnJpbmdbQU1ER1BVX01FU19TQ0hFRF9QSVBFXS5zY2hlZC5yZWFkeQ0KSSBh
bHdheXMgZm9yZ2V0IHdoaWNoIGluZGV4IGlzIEtJUSBhbmQgd2hpY2ggaXMgU0NIRUQuDQoNCltz
aGFveXVubF0gb2sgLg0KDQo+ICsgICAgICAgICAgIChhZGV2LT5tZXMuc2NoZWRfdmVyc2lvbiAm
IEFNREdQVV9NRVNfVkVSU0lPTl9NQVNLKSA+PQ0KPiArIDB4ODEpIHsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgc3RydWN0IG1lc19pbnZfdGxic19wYXNpZF9pbnB1dCBpbnB1dCA9IHswfTsNCj4g
KyAgICAgICAgICAgICAgIGlucHV0LnBhc2lkID0gcGFzaWQ7DQo+ICsgICAgICAgICAgICAgICBp
bnB1dC5mbHVzaF90eXBlID0gZmx1c2hfdHlwZTsNCj4gKyAgICAgICAgICAgICAgIGFkZXYtPm1l
cy5mdW5jcy0+aW52YWxpZGF0ZV90bGJzX3Bhc2lkKCZhZGV2LT5tZXMsICZpbnB1dCk7DQo+ICsg
ICAgICAgICAgICAgICBpZiAoYWxsX2h1Yikgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAv
KiBodWJfaWQgPSAxIG1lYW5zICBmb3IgbW1faHViKi8NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgaW5wdXQuaHViX2lkID0gMTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRldi0+bWVz
LmZ1bmNzLT5pbnZhbGlkYXRlX3RsYnNfcGFzaWQoJmFkZXYtPm1lcywgJmlucHV0KTsNCj4gKyAg
ICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+
ICsNCj4gICAgICAgICBmb3IgKHZtaWQgPSAxOyB2bWlkIDwgMTY7IHZtaWQrKykgew0KPiAgICAg
ICAgICAgICAgICAgYm9vbCB2YWxpZDsNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bWVzX3YxMl8wLmMNCj4gaW5kZXggNmIyMjI2MzBmM2ZhLi4yZTkxOTFmZmZhZjEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTJfMC5jDQo+IEBAIC0xMDgsNiArMTA4LDcg
QEAgc3RhdGljIGNvbnN0IGNoYXIgKm1lc192MTJfMF9vcGNvZGVzW10gPSB7DQo+ICAgICAgICAg
IlNFVF9TRV9NT0RFIiwNCj4gICAgICAgICAiU0VUX0dBTkdfU1VCTUlUIiwNCj4gICAgICAgICAi
U0VUX0hXX1JTUkNfMSIsDQo+ICsgICAgICAgIklOVkFMSURBVEVfVExCUyIsDQo+ICB9Ow0KPg0K
PiAgc3RhdGljIGNvbnN0IGNoYXIgKm1lc192MTJfMF9taXNjX29wY29kZXNbXSA9IHsgQEAgLTg3
OSw2ICs4ODAsMjggQEANCj4gc3RhdGljIGludCBtZXNfdjEyXzBfcmVzZXRfaHdfcXVldWUoc3Ry
dWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yo
dW5pb24gTUVTQVBJX19SRVNFVCwgYXBpX3N0YXR1cykpOyAgfQ0KPg0KPiArc3RhdGljIGludCBt
ZXNfdjEyXzBfaW52X3RsYnNfcGFzaWQoc3RydWN0IGFtZGdwdV9tZXMgKm1lcywNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG1lc19pbnZfdGxic19wYXNpZF9p
bnB1dA0KPiArKmlucHV0KSB7DQo+ICsgICAgICAgdW5pb24gTUVTQVBJX19JTlZfVExCUyBtZXNf
aW52X3RsYnM7DQo+ICsNCj4gKyAgICAgICBtZW1zZXQoJm1lc19pbnZfdGxicywgMCwgc2l6ZW9m
KG1lc19pbnZfdGxicykpOw0KPiArDQo+ICsgICAgICAgbWVzX2ludl90bGJzLmhlYWRlci50eXBl
ID0gTUVTX0FQSV9UWVBFX1NDSEVEVUxFUjsNCj4gKyAgICAgICBtZXNfaW52X3RsYnMuaGVhZGVy
Lm9wY29kZSA9IE1FU19TQ0hfQVBJX0lOVl9UTEJTOw0KPiArICAgICAgIG1lc19pbnZfdGxicy5o
ZWFkZXIuZHdzaXplID0gQVBJX0ZSQU1FX1NJWkVfSU5fRFdPUkRTOw0KPiArDQo+ICsgICAgICAg
bWVzX2ludl90bGJzLmludmFsaWRhdGVfdGxicy5pbnZfc2VsID0gMDsNCj4gKyAgICAgICBtZXNf
aW52X3RsYnMuaW52YWxpZGF0ZV90bGJzLmZsdXNoX3R5cGUgPSBpbnB1dC0+Zmx1c2hfdHlwZTsN
Cj4gKyAgICAgICBtZXNfaW52X3RsYnMuaW52YWxpZGF0ZV90bGJzLmludl9zZWxfaWQgPSBpbnB1
dC0+cGFzaWQ7DQo+ICsgICAgICAgbWVzX2ludl90bGJzLmludmFsaWRhdGVfdGxicy5odWJfaWQg
PSAodWludDMyX3QpaW5wdXQtPmh1Yl9pZDsNCj4gKw0KPiArICAgICAgIHJldHVybiBtZXNfdjEy
XzBfc3VibWl0X3BrdF9hbmRfcG9sbF9jb21wbGV0aW9uKG1lcywNCj4gKyBBTURHUFVfTUVTX0tJ
UV9QSVBFLA0KDQpTaG91bGQgdGhpcyBiZSAgQU1ER1BVX01FU19LSVFfUElQRSBvciBBTURHUFVf
TUVTX1NDSEVEX1BJUEU/ICBUaGlzIHNlZW1zIHRvIGRpZmZlciBmcm9tIHRoZSBjaGVjayBhYm92
ZSBpbiBnbWNfdjEyXzBfZmx1c2hfZ3B1X3RsYl9wYXNpZCgpLg0KDQpBbGV4DQoNCltTaGFveXVu
LmxpdV0gV2hhdCBJIHdhbnQgaXMgc3VibWl0IHRvIHRoZSAga2lxIHBpcGUgd2hlbiB1bmlmaWVk
IE1FUyBpcyByZWFkeSAsIHRoZSBhYm92ZSAgY2hlY2sgaXMgZm9yIE1FUyBpcyByZWFkeSBvciBu
b3QuIFdlIHdvdWxkIGxpa2UgYWxsIG5vbmUgcnVubmluZy1saXN0IHJlbGF0ZWQgb3BlcmF0aW9u
ICBiZWVuIHN1Ym1pdHRlZCB0byBLSVEgc28gaXQgd29uJ3QgY3JlYXRlIGFueSB1bm5lY2Vzc2Fy
eSBkZWxheSBvciBpbXBhY3Qgb24gcHJvY2VzcyBzY2hlZHVsZSBkZWNpc2lvbiAuIEl0J3MgbGlr
ZSBvcmlnaW5hbCBkcml2ZXIgdXNhZ2UgZm9yIEtJUSAuIFRoZSAgc2NoZWQgcGlwZSAoSElRKSB3
aWxsIGJlICB1c2VkIGZvciBhbGwgdXNlciBxdWV1ZXMuDQoNCg0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAmbWVzX2ludl90bGJzLCBzaXplb2YobWVzX2ludl90bGJzKSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgb2Zmc2V0b2YodW5pb24gTUVTQVBJX19JTlZfVExCUywgYXBpX3N0YXR1
cykpOw0KPiArDQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X21lc19m
dW5jcyBtZXNfdjEyXzBfZnVuY3MgPSB7DQo+ICAgICAgICAgLmFkZF9od19xdWV1ZSA9IG1lc192
MTJfMF9hZGRfaHdfcXVldWUsDQo+ICAgICAgICAgLnJlbW92ZV9od19xdWV1ZSA9IG1lc192MTJf
MF9yZW1vdmVfaHdfcXVldWUsIEBAIC04ODgsNiArOTExLDcNCj4gQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBhbWRncHVfbWVzX2Z1bmNzIG1lc192MTJfMF9mdW5jcyA9IHsNCj4gICAgICAgICAucmVz
dW1lX2dhbmcgPSBtZXNfdjEyXzBfcmVzdW1lX2dhbmcsDQo+ICAgICAgICAgLm1pc2Nfb3AgPSBt
ZXNfdjEyXzBfbWlzY19vcCwNCj4gICAgICAgICAucmVzZXRfaHdfcXVldWUgPSBtZXNfdjEyXzBf
cmVzZXRfaHdfcXVldWUsDQo+ICsgICAgICAgLmludmFsaWRhdGVfdGxic19wYXNpZCA9IG1lc192
MTJfMF9pbnZfdGxic19wYXNpZCwNCj4gIH07DQo+DQo+ICBzdGF0aWMgaW50IG1lc192MTJfMF9h
bGxvY2F0ZV91Y29kZV9idWZmZXIoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsDQo+IC0t
DQo+IDIuMzQuMQ0KPg0K
