Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD746E83EF5
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 09:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FDF210E57C;
	Wed,  4 Feb 2026 09:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9SzcKtl";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53EA310E57C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 09:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6m4KbADTUTGgDaaNzPTBZolSlDHFMhvKJIuWqgVvdU19I+0hGN23WG7cvMrjnHbFbOHTP3TInuipRal8VTHGacYV7KkRb3VL3pdODrQngePzzzbtI9qrLCD+yreBbpFHW6AKvf7BSlKZ4Ly7AIqJt8QWB8NynAttDICvaayCh8J+iWutLPFTlv6W2S5+a14DWgleR6be1BwWETkCWNSGROAbXopDFfaiYQiaMLRzyn+efcan/nH34v6Z7WukPgYplQ5fDgZ9rtEJZLe80hqFy0x7jDWaQvlcdVV9J0o+eFErcR5rgIllOok60LwH6W4i5jbv3O/lgCZ0nPc1fWm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZ9QSbJ8AHFosw2yMwpNdzXvXvOCjwgzNpYVE3GGeiI=;
 b=PkEH8NECtcQ5i9ZHnwToIYYiZ0S/21EwdhEq+5qESWqr6zJQzXMnN55AEoSyTw1s8V+XwoRJdY3Kk0FbDyMvPOKbb1RrMW/ohuy45LqZg3PCXHeEl+iNElfc1JvllgUbHXum9ftNh07H5YQemnkMAS/+PdzxihdhXvBPVjrHvrvtloA+ZR/SBuXVTinLEGhj9RU/qdrJpkQyryMrqb8e5wqx00vTu4NLUg7xn2OTe48eoafAQplBe8ookQhs19+5cA9DHj1umYZWM4ZcYoz9ZYNrRZX1HKQQEVDIveatN0E/KGbGIdFFe8K1Ue3H6DDkEdV8WZNs4onHDzdjWXX6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ9QSbJ8AHFosw2yMwpNdzXvXvOCjwgzNpYVE3GGeiI=;
 b=N9SzcKtlNpvcs+orr0y/tHncEiF5Ih2W4hRSHB03VKROBcA0TZ/VyNOmRPFslk0we+v6X5yAom2/yW3vpJlPq06sGkyAiNh0+3jvz+bfyT++3etnMv0L5GaRk/m87F/K5hT4pfaxQ3uRVKluKkt79UR9tQjmeauJVTunrEBDRkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8714.namprd12.prod.outlook.com (2603:10b6:208:488::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:03:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 09:03:02 +0000
Message-ID: <9e08715e-d63e-4269-a130-c1722241d96f@amd.com>
Date: Wed, 4 Feb 2026 10:02:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260203065529.1360282-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260203065529.1360282-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:408:e6::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8714:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fe6a722-a6cf-40b0-b0ec-08de63cc3374
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmRJTEI0bzhCNGZ0S0pqT1dTOGMyZWJ3emNkTVFWaU90WFJjM2Ztbm81anRx?=
 =?utf-8?B?UFQ2OVI4MTNYYVFkMGprVUtqeWJuaEM0S3BoWDdkNVRSVjdmb3NySllKNS80?=
 =?utf-8?B?bXpwM09mMnE4QkhneHNCN0tPQlhRQnBlK3d0dVVraU5aR3luSisvc0cxcDNW?=
 =?utf-8?B?emx3Q05rQi9weldvOXBVWTVFSmZYR1pqMVBORU5xVy84UXl4eTNwd3AxbVlH?=
 =?utf-8?B?YUF1YkJWZEFFL2tWN1NweHNXWjIzYk9Va1hVWHdRYWtrcVBMakVSKzFlY2tS?=
 =?utf-8?B?ZkVSdmZHdGF3clVpU0xNMG4yT01tVEwyT2tIOGozWVpuNXRXRmp3S0J1UEVO?=
 =?utf-8?B?RzFzblM3c0tVVTRQRVExN0tIb0JiZ0N4WFRVTjJiR3JkSWVETTIyenczV0NM?=
 =?utf-8?B?SDRMbS83MFNyYWRUaWlHZXZqdUpoUnRTRGxxQW9tdUtQVktILzViVE8rSmZD?=
 =?utf-8?B?ZUpxdEdhRWJocEFkSkVwcnpRaTI2ejUrQk5JdWREWE1kUklvRDZDSzlRNERI?=
 =?utf-8?B?Q0lCcjJKSjk2TWZZYThtYlF2eFJaL0NhU21WcEI3SG5hUGN2YnlqeDRESkM2?=
 =?utf-8?B?bHBBdy81VnpJNU0yaHFhbzIzc1RjNVRxTzlZbnFuK00xRHBySlpNYURqWlpo?=
 =?utf-8?B?elcvaW1CdUVlRjFtYlNVUkN0bkxtOWNWMjV4ZFRIVEo1Z2dadk1FYXpKeVNG?=
 =?utf-8?B?UTlzakRKTFdFamNBOGpteEYwRnhtMnpjZ0dwNW03VjVneEEwaXhXUlVtZ0da?=
 =?utf-8?B?UjlvdzJJUlNYaTJLdHdwQmxWVk5ROE5CNmZ0QjVjWDQ1YlJJangvNU1scGc5?=
 =?utf-8?B?MlZHYi9DTDZYWGh5Nk1tN2lCMytzRWRDejB1U1pYTTUvME9IZGZUK1ZES0Y0?=
 =?utf-8?B?MExYMWJ0dWlVN3dIREtHd0hEQVhLQTJwTlVjQ2loWCtOa1lIclVxV28yTC96?=
 =?utf-8?B?Z3hkWHBWcnp5b3BPUVR1bHBIRFhLWFNoU0I1SXZET3FSY1lsOGw1MGZKcTRk?=
 =?utf-8?B?ckV0VkM3M1U1OXprWW96aUNLVW5wMHF6ek05UndCQUU5M244T2w3R3Fud3pF?=
 =?utf-8?B?bTZUS2JRSEd4elRiWTFSVHdnTXpjY0lJSTZ6RXlnWHFmcHl3amw1cUJMR3FE?=
 =?utf-8?B?V3FucE13T2NtVUMvZDYzMGdnck5uMENsS083NDB0UFlsdWltN0dWM0gxRk5V?=
 =?utf-8?B?QmlPV1FPWVBPV2FpaWszR0dDVFJnclNuWXVtR3BqNmxwUktxVmtXMzhLQXBW?=
 =?utf-8?B?WjdTcmtoa290dlc1Q2ZzZUtLUmFUSlluRDRrdzF2WHlJanFEZy9sNlVDYjZ0?=
 =?utf-8?B?YTBub0ZvNnk3Q2RJVjg3ald6Q0E1OG9LVGNWMlBhVitiaENzSEd2TTJzWjhr?=
 =?utf-8?B?MHVOZTRJY256OTZ0WGg0U1dxK0hkZFp1NytleGhtUUEwRzVsMWpPU01CRHZM?=
 =?utf-8?B?WnNuSlZZUmpCd0dJN3ZPSWhyNU5DQzV0Sys2STBVYlVzVUtnUDluK2ppRFF6?=
 =?utf-8?B?eklUdnErK3JjZ0xjVmRiMjFSc0hIZ2hwTFk1UzhsbjFQSFdXRmF2TVlLTm9R?=
 =?utf-8?B?d3lrZUZUdjI2QS9ZSy90TEIwSlBYUzFqTjZBakZLQS9OT05LT1lEU1poL2ZD?=
 =?utf-8?B?akxmL202dHNSdk90Y3p6T3hpQ3A0MUpXaityVWxzMm1COE1yQk9PQ0NDdUts?=
 =?utf-8?B?eksyakF5OWRsbjhPWkxXbjNVaW5qMEJ3NXAvUEkxN3grLy9XQ1ZucHJDUkZh?=
 =?utf-8?B?bHl3KzdFWWdZR1VoQkgvQmhDTmVqVUMwVzZob0ozVWl6R21HaUVNZjZyNVQ2?=
 =?utf-8?B?ajhjRlZmWHRVRU84ZUUxQVBaUklkbkhDU3NxKytmMS9kSCtiZk11OXBBSTAv?=
 =?utf-8?B?T1ZESFlWdFo0bkpVVXhMRU96bGh4ZThLRkhuaVB0Z3V4c1NkdU11dHB1bG5S?=
 =?utf-8?B?RDhYWHd3MGJtR29iZ3Q2b2F3cGo2OFdWSHdybVhCWlNrZGhZZTFIVkxnRk9h?=
 =?utf-8?B?c1VOZHpTalo4VkZ5V25YQmd1RUtoOXNhMHRQRmJQY1o3SXFkUFNLdllUKzg2?=
 =?utf-8?B?UnllVkZ2UVUvclJRYnhpZnhuaU9FWjRNc2R0d1lKT2xXYlVUd0p2L0d4c1NZ?=
 =?utf-8?Q?SHP9w8vZrWT1J+yYRqmdzuPgI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVtQ1pjV2JtL0tyY0duMGdaSjU2YmFpSmp3dm1oWEhQazJLNlgwYUhwa1pr?=
 =?utf-8?B?Ym9zNGxqYjl3TENLY2VScVZYb0N0ZFN2TzlKWStaUWFiWW1hQklRaWZQMTU5?=
 =?utf-8?B?OEZoR1FIMjZjOFYrNHAzZFRLOXdkd1RtWWZObmh4alp5dERnb0RlcUdHTGlv?=
 =?utf-8?B?R1FrVVlIMElGQktqL09sSkhuaUFsaWlBQmRqU1ZIYWxYMWxmN0hpN051QXVZ?=
 =?utf-8?B?RlJzdjJIZDFDb1ZtajRIU0NkNENsbnVrbjM1WkV4ZkVRbVJ0dFRVa0xQc3Bq?=
 =?utf-8?B?ZzJueWp6dUZvcjZjUUI1Z3pwOURBcWYvc01KSGlvR3g2MkhkdjJaOTVjdjNw?=
 =?utf-8?B?ZGpXQXdiYjJiUE1ZVTI0TkJCeW1sdkpDUGxaYUppUnp2YzlJdHVMNmxqV3RD?=
 =?utf-8?B?dXdWcVBJNFh2ZXkwanhXdElNbXNaOVc0NXFFNjBVaEVFME5Nd0dsblg5ZE42?=
 =?utf-8?B?VG1CVUd6YzNHTWFTc09XQ3I0dlV4c3FDVGZRakFGUGJ5bFp1d1JrM3Nyb1dK?=
 =?utf-8?B?a0FyQzBYMVpZWkNqQTlEZklLVFV1VkJaeC9WZld1MXdtVEd1YkxMaWZMNkE4?=
 =?utf-8?B?Yko4a2pOTUprMzgxSkNKTFVpcEpWcWFUWXhBLzBrRUVybVE5NG4zcjMyeTVs?=
 =?utf-8?B?U2RCZjdrd000YmNRMlZnalJWNElQSFZnN3BSa2xuckkxZzdaUWI2eHRnMHZC?=
 =?utf-8?B?a3h6alp3alNKTk1PL2dTUVFvTGh5TTdBMGMwZ092aUlFVEtCNXZFblR4SHp4?=
 =?utf-8?B?WFNJR2Q0L3hKcERWdldpK29BbXhiN1ZoTTRvR3Q1elZsWHloSk1GSENZUThB?=
 =?utf-8?B?OUw3a0QvZmF2bmFiRG84bjM2TUZxNEVHNFVsQ3RObGZPMzBPOWR1TnB1M0Jz?=
 =?utf-8?B?TkVGeEZtSHRYWjh2dzI0ZnJCTG9WbW1CbWY0WHhRMVl3b0xUSUljN3IzOWN4?=
 =?utf-8?B?ckF3S2krbk5aM0pDQXV0eDllSXY1MFp1ZXg5aEdmSGxvZVNxaEJxWVJjYldm?=
 =?utf-8?B?L3lwM2dnVnlnL2U5bWhmN0VKWEhqcndUaUlNQ3ZHeXpjUEZYNzUxRFlHUnQw?=
 =?utf-8?B?Z0UwbTVoWU5uUG1xU3UyeFBBWUFMUVRaaGdKR3pya1QreXdiNzNqM2VnOHk4?=
 =?utf-8?B?YnNaa3Y0M1FXQzJKR01PaFJIa3VzSlU5MGYvTnVDTEJiTERMd2lsaFVqbXkv?=
 =?utf-8?B?dDIvOThOQXFSSldqU293ZW9zZ2tKS0RucGJCSEpnNGVVdG0xdnFNYmJvRnBl?=
 =?utf-8?B?T1YzdkxlL0xCOSt5eWQ4cHFDcWNMcm41QTVyZzJESkFScTZlVjJsbW11QnRL?=
 =?utf-8?B?bUtJc0JmUFUyMjM2TWZxc0o4TTl2NnRtY2hrUk1sZGh4emk2TlowUlk4ZWJn?=
 =?utf-8?B?blM0YWVKYzhJNG1LY3BNay9KL1NxRnZTeXRUYjZDQi93TXViOHRUUDlFQ3Fi?=
 =?utf-8?B?clk2eDZRaXc5V3NaaXJLc0hpQmg1RVRLenpwYVQ5cjFxQWZGQVR0ME9DK1NS?=
 =?utf-8?B?KzU2M01GN3ZrOFBxT3BxY1Q1NWRyU3RGMVprQ3NvQ1BqZmpUejI4aVdLWE1F?=
 =?utf-8?B?bHE1MXU3Rkd2ZWZUU0l2MHRuTklVK1hPeUkrTlB5cWVZdy9xSmVEY2FDVXRh?=
 =?utf-8?B?UU5HY2pXUi9LNldIS0NjMlhpTUxaRTZtcDRNVzBndWs4KzFnTFMvdDdVYTNk?=
 =?utf-8?B?ZkNuNWR4RktjN2pMcjBZUm80Qko3dmZUUkxobzl0dnozWEhaWUcxbElDV0hZ?=
 =?utf-8?B?cjZGa2laeGVkZ3VubktoZXFRQ3dpcVN4cjV2d0VQMlgzNWpsdkFucWR1UmdN?=
 =?utf-8?B?aTViVUhxMFl6Q2tjcHFTa25nZk15Z1I1TFJudGZzN3VmOFV0QTZ0RmczQW9v?=
 =?utf-8?B?WWRBemlDbnBLRDZzaW05LzcxN20zbHdDZWFzVDJZY0xRSE9YaHQ0cWpvdmRa?=
 =?utf-8?B?SkJ4NWJ5RXhsd0RiSllGN0xKYlJmVFNrZGVta2FjTUdhMjlIOTg4MlJtR0Zm?=
 =?utf-8?B?QlZJNXNVemlVdnNrWThNcjRkdHV0Y1pQV1VLOXh0b0NzWnFEOWRXR0I1dDRW?=
 =?utf-8?B?K0VRWjIwR05XYnhGdjlxNWdETDBFMUlLU3FubE5PaWt4OWVhYURBVUgwUUov?=
 =?utf-8?B?a0tLRThJK3h4b1JnWE12L1JmSTVieStSVTB2RXY1SmlFeVh2d255Y1lZYmlh?=
 =?utf-8?B?SmF5dzZtSjBYOEw4Ui90aHZsaWw0SUd6TENHUEV0VkQ1OGw0d0NBUUFqRE9I?=
 =?utf-8?B?TDEzVE00eDBLYU5pRlBmTjF2VUdsdGYzK2lMQlJzV1F0MHFhakVsNVhGMjJ2?=
 =?utf-8?Q?6F6GbgPTtsTP8rL8xy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe6a722-a6cf-40b0-b0ec-08de63cc3374
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:03:02.3262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6dsGD7EUHsMErtOrORbVulsGTtvuSzFXtgLKgh6n2DwBf+znmUjJGaXb9F41VT5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8714
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

On 2/3/26 07:55, Sunil Khatri wrote:
> In low memory conditions when kmalloc can fail and hence
> we need to clean up the memory and unlock the mutex for
> clean exit.
> 
> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d591dce0f3b3..831063971f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -892,8 +892,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		struct amdgpu_bo *bo = e->bo;
>  
>  		e->range = amdgpu_hmm_range_alloc(NULL);
> -		if (unlikely(!e->range))
> +		if (unlikely(!e->range)) {
> +			mutex_unlock(&p->bo_list->bo_list_mutex);

> +			amdgpu_bo_list_put(p->bo_list)

The call to amdgpu_bo_list_put() is always done by amdgpu_cs_parser_fini(), so that here would drop the reference twice.

Apart from that looks correct to me.

Regards,
Christian.

>  			return -ENOMEM;
> +		}
>  
>  		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>  		if (r)

