Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B873D6CFB0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 02:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D527D10EB28;
	Fri, 23 Jan 2026 02:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V96/RADO";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C6410EB28
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 02:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOcPvqwnJ00yNyE/SmZLLvH/SPhXlO0HseAfarKFNXL8TUmn/L4qqS8yqrrVH/GsLEeTNwTlIU6SOtYW/lcNqsrUc0ttd9zlwA2WTbqSYxYZcR+1G09XapZChi5rdChF6MmeVDW/Qnf3ycMEDhKMvhhYL3W0WvHXbRrcaQ0BJWNhWdyo9sBtXsoaeARyrfOMu+dH3EKatYxL52uxR5eTimIML3OjzEwDSMV5+5K6ThswFg9XibBVsPyKdJX4LMiONE5D2+zIeTiL1aAyfdRycK5yphHn6auugsWQ/FNaqRD8xTSKbat8fvKzwPh62T2EPCELfUpjY4DnvlpI3hWYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oktrrb5OA1pb24VZcPMfNt+AbhLpPzAD/r0FLNSvQQU=;
 b=u1LTJrIupgUGefSSQhsPI5V381zqEb10k12RVmw8yFr4HVx5GCuz6lh3kz13Vp89SZsp9DhnDMUcrfSHLAT1hp7GnG5NMExyO9RSz8t6MWZabhtJlcCbb90FQ9JAvXzhKaWQ9joxOyWsuY7wxhO9HCL5TcjuyAwCICP263NIqYDdhFWKw/LFpzgR1+RgekOSZUV0i7LPodloVvxGusqLnv8NsZC6oW4/ocr/glbSUGoRWvjr5oWeh07sFeha1Ikqq6plibKDRCUr7uGdGJ9kI/atSEGPvIRQXOcK7imdcKOLjYyc4FJBSagyThFjQZS6ONawB+20490tGlTpoY4P2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oktrrb5OA1pb24VZcPMfNt+AbhLpPzAD/r0FLNSvQQU=;
 b=V96/RADOfNuKDAk+sqmt9ThJMtavrOcZGYbRJJQKYJY6mY+JfB1rEs2u0SxA0MGbHNC5NaMb/7rLpzcmv/uGQmKQpHfDZMYWpYOhyXB220arkxu4o0LFSoSZmfyxj6BJkLtq46VYbRRNzrVHCzrNF6zMkJ9Ocd/xrYuO8jO+QGI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 02:08:27 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 02:08:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
Thread-Topic: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
Thread-Index: AQHcioQcc0Ae5sGlPUenOAffS/Rte7VcI4IAgAJJOgCAAAWVgIAAkPzw
Date: Fri, 23 Jan 2026 02:08:26 +0000
Message-ID: <PH7PR12MB5997FDFC24129C9A068D9CDF8294A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
 <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
 <CADnq5_MxLO-9xyJr4jELJhiuXVVqAbpy58j0sw=BiMBHHG=a8A@mail.gmail.com>
 <df0d27d7-0230-4d61-92b7-3ab9d4ea68dd@amd.com>
In-Reply-To: <df0d27d7-0230-4d61-92b7-3ab9d4ea68dd@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T02:01:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ5PPF000ACABD1:EE_
x-ms-office365-filtering-correlation-id: cc8b5ba9-700f-426f-e25b-08de5a244bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?K2xTSjFIODQzaFZqYnpMeUxhTXFXR0Z6aUd1STZUNXE3NFJxOStyMWdnUDFk?=
 =?utf-8?B?S1BzUHlVTVdmaEliTWcxTmxVUTFzSHBYVFl5WjA1STY3eWliWi9LSkxoVG01?=
 =?utf-8?B?ZVAvemhyZmhEQ2M3RENzMXlIc05Xd2dQWGFJRGdoR2MvYWpNTE1sNHUxSmFm?=
 =?utf-8?B?dEt1Z1RmWVZMM2RNUVNWU0VHeFM5TXVJVitvT1dRRWFmcUdBS3BrTUhQOWdV?=
 =?utf-8?B?MnVtdXIvUjUwTm1CZUtDTlIzK2lleHB0d0RuclU4VE82dVQ4dWRYN0NIdDRZ?=
 =?utf-8?B?aDltS3kzbWZhUWhjTldJYmVjWmNTLzQzYWtKeWtlWjNLOG9wV2hncXdBS3pV?=
 =?utf-8?B?YStNM1E2Ry84Q0RTc1VNTzVsSDdkc2NodWwzcDJtM3g3RkdFMFJIWHpiQnFG?=
 =?utf-8?B?ei9BblBSOUl5dm54QTZaRXoweE9USWhPYXJDY1JmRDNObUFNKys5TFZJWGtv?=
 =?utf-8?B?clUxa0N3ejQveGtpaGFsRWRpSUtSVDBpZXp5dUt1Y1pvaHA3d1VwYkJjQXJ2?=
 =?utf-8?B?YnZhRGluT0lCYmlxa3V4U08yWkJOMlNEQU5PdE85dzREVm1tbjh6dWhBeWc1?=
 =?utf-8?B?eTV5c2wzZmNDTXNYOXB0UXZ6akhtL0N4dEt1ZVdTbkQ2RklmekFmUk5TRmV5?=
 =?utf-8?B?dmZidG81cllFUm9PWUVKQ1dQaWQyanJWRXJFSzdzOW5DNGJINGlsZ1hPYkNH?=
 =?utf-8?B?RFpPN3NpNG5hMlpINFZYRk9qcm5PcDQxY0FlRytucDZEQkNIazlVNS9NUUxQ?=
 =?utf-8?B?R09UWVU0a3RKTzI5WkZ6VGw2d21ydHRxNjNNZTN5S1pNWDZxanJUK2RFK2or?=
 =?utf-8?B?Sjl3S01jdE9hNWpXcTRRaE9ja3VGY2FMSmZGYTAvazBlS3k5YXVReGZ4d2Vr?=
 =?utf-8?B?NU42QUJMb0pqcGtoYkJKSXRmVS9PYWliS21aUEp4YytVdGtJd3ZqWHl6eDhS?=
 =?utf-8?B?OEI3RTdiMzNwVjM4R0tXbnVpTlgrb2RnbjhGMGtnZ1RBcDZ3SFBkQWs2Z2JT?=
 =?utf-8?B?b1FtMHFVVWtBSm5jSHZ6TzZtL25TTzlxRzdnMnYxMHRYWkwvM3VFOXV4WVQv?=
 =?utf-8?B?WW94NlF6VWRrUnpiNlNPMXNZZ3BSUG5jYmpsVTBaRjFaTkU3STJMU1lubjV3?=
 =?utf-8?B?WVIvMnZtWE52eEp2ajBMUWRUcFNyaXI0M3ltVFhlcWcwVG9hYWR6SUdLMTBQ?=
 =?utf-8?B?ME5laGNUWlQ2RU85MXlqZWN5Y21jVnZsdVo0N3NSZHNIbkl6OUVFb3hQOVI1?=
 =?utf-8?B?ZURBbEFrTXl5SVdxb2J2bVVQTTdpdk1ZQUdqM3UzU0tZRmJnM25hcHZpRkhi?=
 =?utf-8?B?LzdTSWpya2Q3YVJjSDZleE5TbGlVditlS05DdFlmQ1p5Qm1iNFB4MnpBcEoy?=
 =?utf-8?B?RktaMENCc25rb2tSNzZ2dWJhOU9nRnpGL3l6YmI5VXREZzRiRlp3L0QxUUph?=
 =?utf-8?B?bXN4aGhoMlMwL0lYdkZnVmdRRlEyV2drZWZpaHlNWHRzQXMxbDBDWFFQRjNV?=
 =?utf-8?B?ZVQxdkxnWnZVNC9BSVJuSHBkTFFxalZGSUQvZWsrdzhtV0xZczYvbXJXRlpV?=
 =?utf-8?B?WFNjUEZhQXd2SVRzS0xDZDBoUlZHMWI5dU9qK3hOK3Bhc2FWOGhUL3E2aFln?=
 =?utf-8?B?STB5VnM2VXJJdzIrMjQ5d1R4cWllY1JlaWx2ZHExUTBIaUdCRjhTSC8xVjNL?=
 =?utf-8?B?UlR1UE5uM1hxaE9oZlQ5dkZRZjM3d2gwcEJqRFNvWklhZ3ZWWnp2TXV0WWth?=
 =?utf-8?B?dFdHWlAzK0huZ01mMlp0Z2toSzdFQUI5VDVDZ1N3akpYTXZxVVlROFREeEdM?=
 =?utf-8?B?dGhoWnJKT0FTWDFQcHRRZ2V1NzNKdEhFUy9uUGdxdFZ6dnpDamdZN0p3Q1p4?=
 =?utf-8?B?UUJKaFZyUE5qYy9PcFAxWVVZSkwvU0Q5Smkwb3ZhMWZRNHhhSTMxSnQ2VUc3?=
 =?utf-8?B?N3doZ09DSUd3SHd6bjhNbkFORjJvb1hUeW9ZandrY1NPR2RzYk1mVWRiRTZK?=
 =?utf-8?B?eXJEZjdNQlZtU3hJK01Dak9CYjVjZW0rNzlxRGFpejZpVThPaU9kSmFwWjBG?=
 =?utf-8?B?ejdkckxjVGhTQWdwWVh0R0plQlBGemdjQjgyUEVaUmZSOUlLMGtnNURLa29D?=
 =?utf-8?B?UGNlcGtPd0VuU3B5VEx4ZjFzN250djllY01pblBuWWJTc0s2K0FEeVVUM1l2?=
 =?utf-8?Q?C3YYFhUWCjO+1AjwsXfaGEk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUliV29jNlhadHhja09VdzQ2dmpzMG15b2w0L29IRUpKQXB1QU5Cc2JRYWw1?=
 =?utf-8?B?NW9OWG10WXFHTkc3bkRVVDJMVWowMkluYVRBUWQxMG5OemFPZFZ5V1R3MmMw?=
 =?utf-8?B?U0hCbWtLT3lVVVI1QktvVysrN2k4SGVXZjVMY2MyZldrY01OQXliSnJpTDZT?=
 =?utf-8?B?QkswTDBKb291d0o5V1RTUG9HM1IrU2JWRzdEUXBQV3pPL01YWk5qdFhUQlBv?=
 =?utf-8?B?UllUTkl0TDFLTkpOV1QyLzVSZk9lRnVqUGxtUXp3OEtPakt0QUUxYm92UE5l?=
 =?utf-8?B?djBZaWRRWFF2OFRwVnAyN21xYjh3dERqSkhKTk5XZXZQUDhPa1llbkU0YXM0?=
 =?utf-8?B?MERZdlZpeFBjSGVCR1VNU1ZNTTRPamhLd1kwYXlXYzR1TVQ2cFVoaXloQmQy?=
 =?utf-8?B?OFRoK25iZm1BY3ZzcitQbVpXMC9Hc3hYMklSLzJLL2QyelFBenkxZzE4bnB2?=
 =?utf-8?B?NFRtWGQxbVlCQ2ZiaFJ1L24ycXZlR2o2WlIwQk44azYwZ0JzSEhYNjdiSjJR?=
 =?utf-8?B?UmtmczlVcHo2RnA4UGozRkltNHpFYWZHU1hQQXFhRUR0bGhkellHdWNBNk4v?=
 =?utf-8?B?YnBac2tnYUpjRFlGeW9lVFNEbDFiTGVtaWNjaUVyZkNJcWVZRklTMGJPdUxp?=
 =?utf-8?B?YVRoMGxHOXBOOHU4VnhQWXhGZXJSWHkwd0ZMckU0K1kwdlJJMGdMTmpaRVVv?=
 =?utf-8?B?amp6UzdZYmZDeUk5c3g0Sm01Vk5XZG9wVGppbEVOT1J4dnN4elZ2UWlSZVQy?=
 =?utf-8?B?QWVLSlZ3eVdQa0FRdDhwazNnM3BpVVJwckt4dlhtbHB4cS81Z2Y3b2VqM2gz?=
 =?utf-8?B?WG1zeStHRWdMaG1Pd2wyeFlFR1hiNUFnRnRBRGM0Z3VIZzFFSDVlYTBmSy9w?=
 =?utf-8?B?ZnBGM0FqRzhIV2xuT2ZLR2hyZnJqSU1jQ0JNeEdZVTc1Q0cxMEgzV0NsNTEr?=
 =?utf-8?B?MEQ1YWlBNVhRenlGOFdra2NvL1RYMVVtVlVocitjdnZSd0N4aStyM2loREtk?=
 =?utf-8?B?WnFoTE8zSnFNemRsVnFqalRpN29xSnQvVnVXS0c4Q0NFd1VSWE9WWWR6S09y?=
 =?utf-8?B?VmhueHBrNlBXVUhySWpZUHB5Ym1rQ0FMc2tjek9wVzhZc3M2VnNuMGhGVGFq?=
 =?utf-8?B?Rm45OVV3QmduZ3pVRzBmQ1NtS3QyN3IrZW9OZWxDN1luVE93eTJGZDczVmo4?=
 =?utf-8?B?N1VnNnJoMjhpVC92K3lmaDIzdVk0enYzNDQzN1JhOFgwdVBCcDNMdS9SWTZs?=
 =?utf-8?B?MkdnY2paOU1lYUFWelZ1WGpENCtFUHFTeDRBZHZEREdCdWRBdU51WFV4TFRS?=
 =?utf-8?B?TnhuV1Z3dk9tT25wNTlDdmNiaFRPelZnUHBNakMzMmxPdmw3Ujg4bnpScWxw?=
 =?utf-8?B?bFkzT3RjaUlFWDZwc0pieTZtTWlHc0E3TG9xYWtyUXU4ZG40WnE3WWhsQnBM?=
 =?utf-8?B?YnljVUNueEtJNGppTnBnaWdGZGRWaHhKMHk1Ris2OFQyN0JWVUNlczBnSTJS?=
 =?utf-8?B?Q0t6Zy96M0FqVWFRUUE2VERZRkZMRWp4b3dYWDA2YzF0QmllaS9kMWpaZCtO?=
 =?utf-8?B?NHppN1RzN3g3aXBrZUZZK292SEV3Vi9iMXdtZEN3dG9DK081S3E4UG1CQlpF?=
 =?utf-8?B?UllxOGFmS1JWQ3R4ZnNNUnJTTlhnV296eThvZ25XczVtNFdKTEVYR2w1SkRu?=
 =?utf-8?B?Z2FXWGc4UzdKVzdzNmxRT0ZidXVLWlZLN212SnNOUDBMbXlBUFdGZHdUZnhx?=
 =?utf-8?B?Mmc2L0hGRFRJU2NPWSt4K0NCQWNBdWMwRDQ0SFFyWWxYSjl2R0RFcHJUUWhr?=
 =?utf-8?B?T2VMR0N6MS9JREdLNjNndjIvRStGdGJFK1hlOXo0SkF5VWVCeHd5N0s5WUhj?=
 =?utf-8?B?cCsvZGxjZ0gxUDVMVnV2SDMyRlY1Uyt5cHdsTmE1LzJrc2liNExJM3RONlNT?=
 =?utf-8?B?R0tVVkU5WjRLUVZveXp5UkZsRENBVk9KMkp6S1puM2pxQUhzYUl4cEsyQTQ4?=
 =?utf-8?B?TkVlc2c1eWVFc1JVZEZkWUtaMHorV3p4RUc1c1MrNS9JMGZPRFpXUVhyNndl?=
 =?utf-8?B?NVZtRVR0bTNvNTNJeTJVVDJKSnZEWk1CRmZUY1h1WkVEc3dLZmRzTFlYRXUx?=
 =?utf-8?B?NUdZU3RNL2hEUndoeFhhM2pSM1E5dXNYTXRuQi90K2ZCdFdHK1Z0TnRXNnBI?=
 =?utf-8?B?bDc0clc3MzNORjhMRU9FRDRPaENMUGhMcXMxUDAxTWp4VWRGdjc5YXdQUTNX?=
 =?utf-8?B?N1Fpek5XTzVUSnJVT1Z4TXRoVUpIZEZnZzc5c3FwUlNEVHlLa0Rhc09Halk0?=
 =?utf-8?Q?JdzeOLqX6P1MA3S42L?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8b5ba9-700f-426f-e25b-08de5a244bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 02:08:27.0560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WV7w5WCZtlwhp3jweEt2qQc5RxvUVWplTRFCSrSocdkaYcCQVTBiZwEJ1eWBmOQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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
Cg0KPiBEb2VzIG1pbiBuZWVkIHRoaXMgdG9vIG9yIGp1c3QgbWF4PyAgU2FtZSBxdWVzdGlvbiBv
biBzbXUxNC4NCg0KWWVzLCBhZnRlciBjb25maXJtZWQgd2l0aCBQTUZXIHRlYW0gdGhhdCBvbmx5
ICdtYXgnIG5lZWRzIHRvIHBhdGNoIHRoaXMgY29udmVydCwNCnRoZSBQTUZXIHdpbGwgY2xhbXAg
dGhlIGlucHV0IHZhbHVlIHRvIGFsaWduIHRoZSBpbnRlcm5hbCBmbWluL2ZtYXggdmFsdWUuDQpB
bmQgdGhpcyBjaGFuZ2Ugd2lsbCBiZSBjb3JyZWN0ZWQgYmVmb3JlIHN1Ym1pdHRpbmcgdGhpcyBw
YXRjaC4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPg0KU2VudDogRnJpZGF5LCBK
YW51YXJ5IDIzLCAyMDI2IDAxOjIyDQpUbzogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFp
bC5jb20+DQpDYzogV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+OyBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IEZlbmcsIEtlbm5ldGggPEtlbm5ldGguRmVuZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIGRybS9hbWQvcG06IGZpeCBzbXUgdjEzIHNvZnQgY2xvY2sgZnJlcXVlbmN5IHNl
dHRpbmcgaXNzdWUNCg0KDQoNCk9uIDIyLUphbi0yNiAxMDozMiBQTSwgQWxleCBEZXVjaGVyIHdy
b3RlOg0KPiBPbiBXZWQsIEphbiAyMSwgMjAyNiBhdCAxOjI34oCvQU0gTGF6YXIsIExpam8gPGxp
am8ubGF6YXJAYW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiBPbiAyMS1KYW4tMjYgODo0
NCBBTSwgWWFuZyBXYW5nIHdyb3RlOg0KPj4+IHJlc29sdmUgdGhlIGlzc3VlIHdoZXJlIHNvbWUg
ZnJlcSBmcmVxdWVuY2llcyBjYW5ub3QgYmUgc2V0DQo+Pj4gY29ycmVjdGx5IGR1ZSB0byBpbnN1
ZmZpY2llbnQgZmxvYXRpbmctcG9pbnQgcHJlY2lzaW9uLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1i
eTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3NtdV92MTNfMC5oICAgfCAxICsNCj4+PiAg
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jIHwgMiArKw0K
Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3YxM18wLmgNCj4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3NtdV92MTNfMC5oDQo+Pj4gaW5kZXgg
ZWZlYWEzZDU3NzEyLi5iMGQ2YjdiMDk0NmQgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3YxM18wLmgNCj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3N3c211L2luYy9zbXVfdjEzXzAuaA0KPj4+IEBAIC01NSw2ICs1NSw3IEBADQo+
Pj4gICAgI2RlZmluZSBTTVVRMTBfVE9fVUlOVCh4KSAoKHgpID4+IDEwKQ0KPj4+ICAgICNkZWZp
bmUgU01VUTEwX0ZSQUMoeCkgKCh4KSAmIDB4M2ZmKQ0KPj4+ICAgICNkZWZpbmUgU01VUTEwX1JP
VU5EKHgpICgoU01VUTEwX1RPX1VJTlQoeCkpICsgKChTTVVRMTBfRlJBQyh4KSkNCj4+PiA+PSAw
eDIwMCkpDQo+Pj4gKyNkZWZpbmUgU01VX1YxM19TT0ZUX0ZSRVFfUk9VTkQoeCkgICAoKHgpICsg
MSkNCj4+Pg0KPj4+ICAgIGV4dGVybiBjb25zdCBpbnQgcG1md19kZWNvZGVkX2xpbmtfc3BlZWRb
NV07DQo+Pj4gICAgZXh0ZXJuIGNvbnN0IGludCBwbWZ3X2RlY29kZWRfbGlua193aWR0aFs3XTsg
ZGlmZiAtLWdpdA0KPj4+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVf
djEzXzAuYw0KPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMy9zbXVfdjEz
XzAuYw0KPj4+IGluZGV4IDUxZjk2ZmRjZWMyNC4uZTI3ZWEwODc5NDI5IDEwMDY0NA0KPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTMvc211X3YxM18wLmMNCj4+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTEzL3NtdV92MTNfMC5jDQo+Pj4g
QEAgLTE1NTQsNiArMTU1NCw3IEBAIGludCBzbXVfdjEzXzBfc2V0X3NvZnRfZnJlcV9saW1pdGVk
X3JhbmdlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPj4+ICAgICAgICAgICAgICAgIHJldHVy
biBjbGtfaWQ7DQo+Pj4NCj4+PiAgICAgICAgaWYgKG1heCA+IDApIHsNCj4+PiArICAgICAgICAg
ICAgIG1heCA9IFNNVV9WMTNfU09GVF9GUkVRX1JPVU5EKG1heCk7DQo+Pg0KPj4gTG9va3MgbW9y
ZSBsaWtlIGEgZmlybXdhcmUgaXNzdWUuIElzbid0IGZpcm13YXJlIHN1cHBvc2VkIHRvIHJvdW5k
IGl0DQo+PiB0byB0aGUgY2xvc2VzdCBEUE0gbGV2ZWwgZnJlcXVlbmN5Pw0KPg0KPiBBcmd1YWJs
eSB5ZXMsIGJ1dCBhdCB0aGlzIHBvaW50LCBpdCdzIGVhc2llciB0byBmaXggaW4gdGhlIGRyaXZl
ciBmb3INCj4gZXhpc3RpbmcgcHJvZ3JhbXMgY29uc2lkZXJpbmcgYWxsIG9mIHRoZSBmaXJtd2Fy
ZSBvdXQgaW4gdGhlIHdpbGQuDQo+DQoNClRoZSBxdWVzdGlvbiB0aGVuIGlzIHdpbGwganVzdCAo
eCArIDEpIGFsb25lIGdldCB0byB0aGUgcmlnaHQgZnJlcXVlbmN5Pw0KT3Igc2hvdWxkIHRoZSBs
b2dpYyBiZSBsaWtlIHdoYXQgZmlybXdhcmUgaXMgZXhwZWN0ZWQgdG8gZG8gdG8gZmluZCB0aGUg
bmVhcmVzdCBkcG0gZnJlcXVlbmN5Pw0KDQpUaGFua3MsDQpMaWpvDQoNCj4gQWxleA0KPg0KPj4N
Cj4+IFRoYW5rcywNCj4+IExpam8NCj4+DQo+Pj4gICAgICAgICAgICAgICAgaWYgKGF1dG9tYXRp
YykNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtID0gKHVpbnQzMl90KSgoY2xrX2lk
IDw8IDE2KSB8IDB4ZmZmZik7DQo+Pj4gICAgICAgICAgICAgICAgZWxzZQ0KPj4+IEBAIC0xNTY1
LDYgKzE1NjYsNyBAQCBpbnQgc211X3YxM18wX3NldF9zb2Z0X2ZyZXFfbGltaXRlZF9yYW5nZShz
dHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwNCj4+PiAgICAgICAgfQ0KPj4+DQo+Pj4gICAgICAgIGlm
IChtaW4gPiAwKSB7DQo+Pj4gKyAgICAgICAgICAgICBtaW4gPSBTTVVfVjEzX1NPRlRfRlJFUV9S
T1VORChtaW4pOw0KPg0KPiBEb2VzIG1pbiBuZWVkIHRoaXMgdG9vIG9yIGp1c3QgbWF4PyAgU2Ft
ZSBxdWVzdGlvbiBvbiBzbXUxNC4gIFdpdGgNCj4gdGhhdCBjbGFyaWZpZWQgdGhlIHBhdGNoIGlz
Og0KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
Pg0KPg0KPiBBbGV4DQo+DQo+DQo+Pj4gICAgICAgICAgICAgICAgaWYgKGF1dG9tYXRpYykNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFtID0gKHVpbnQzMl90KSgoY2xrX2lkIDw8IDE2
KSB8IDApOw0KPj4+ICAgICAgICAgICAgICAgIGVsc2UNCj4+DQoNCg==
