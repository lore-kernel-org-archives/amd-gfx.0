Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0806D29DE4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 08:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530BF10E45A;
	Tue, 13 Jan 2026 08:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bMUdhkvU";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010049.outbound.protection.outlook.com
 [52.101.193.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E872D10E45A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 08:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwV8er/XVyWBm5Lojal9MncwZ+wfmvC/AhAixrXn63hnlqjCbTPmMOdC+dpNPbmRcD4aFg3oRTBdY8OKT7y9LHblb/pIo4gR4ZVZ+9gbzeDmZFYsZcJaMtbwnncjSz+Jf3q0GzRVBc5dfIFHg9UvRrcNTukSb8VE1L0rNvT23yDOEfg90m5aAh63Nk7dXYlLTRlUBToYnhQCBH4Dol20Czz6ZEtAvbzh/gtdkC2QB/A+pJnis5Jd3+Imqe+J51IuwBwPXzI3/2NeqL5x7DOqk+gkpeb9MhzhcfuXnoJtqeVHorq80W21VTpdfBcJLwwPBBDQWBWMoUhMMMnRFtu2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UYtI/GF2qIpCIcZacUwPwgvJZJgPn0QecdWMZ0Dlto=;
 b=Vmo7toyCf2SUDd8MmMAAteMa1hVRoi9H/fjDmMSi6gIgZadCgS8ZUakg2AxMMWI+dNxmztyyFGDZpfisaL8+VgYKLxFfIyKbNMKjnULXf03dBRODkr7GHpgP4oOocgV2Olj1yufKomNV7NuXPDeRJJgwISVSxo6MmaK88in3WzYwQB40h6va1DIy+igEIt6QUxQ8UCDmw2An5nyzacXDVG4jDVMopulFS/Fk+OIUfiZqxZJEDR8cJiNBg7WyCK3+hsSkqhBN6JP0UMYoBBshihOMsYz+nDe4t6Im7DXK3lMoYvOYtc+0RfemjS4ZHajP2/Vg8LhjrSA4QHAOLB7NrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UYtI/GF2qIpCIcZacUwPwgvJZJgPn0QecdWMZ0Dlto=;
 b=bMUdhkvU6GkJn4EXUGF6b18i3HXaGhcBNu4H7tYkTqZHd5CK7pRb4xR++TdckJ3mpQxadkC8DJnmWag/qhCQoqqRCSyIwJO4sdpEgbj/bAozELB9yQ6QKzEs5wOIqWqA7UZAskv79EdJT912JAe7N3dB4X5nml3YyaNTBNlkPkk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:11:02 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:11:02 +0000
Message-ID: <08181733-0e87-48ea-b797-941af39bdc8b@amd.com>
Date: Tue, 13 Jan 2026 09:10:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] drm/amdkfd: Add support for non-4K page size
 systems - part1
To: Alex Deucher <alexdeucher@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1768223974.git.donettom@linux.ibm.com>
 <c04c9770-fc06-4e75-bbe5-6e418f7491a4@amd.com>
 <CADnq5_MUwyYa4DSHk+9Aa80KGLTNAbir8Q11wStQSG1tK271Nw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MUwyYa4DSHk+9Aa80KGLTNAbir8Q11wStQSG1tK271Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e62ec8-7d6b-4501-fa26-08de527b4b01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFRtRXdzWGFrUmNZNmhJZGxqbFFCb0IrWTdmUTJRTGU5UXl5NjYydmRzR2hQ?=
 =?utf-8?B?NGhSRkRjSXArb2hXcVVSQ2lSMmJHbUNBL0dPNGQxL2UrMGtkd3dDRzFMZ2xQ?=
 =?utf-8?B?bS96WVU0M284NFFZdEhqRUJaSUM1b3RyRkRRNlZNWUlCR3VoUVhzYWFNUmMx?=
 =?utf-8?B?WnduRVZRamw4eFN1alFlLzJmdm1XZlF3eURySVFpRk0rR2kwUUhiaEkwalZP?=
 =?utf-8?B?UVo1NmRQR2E3aVJHSXZHYUNEOFo2WEtOMVBSZGYvVEdJeEhLQ3hVajZJZlhk?=
 =?utf-8?B?c3hiOVVzVk0vRnRjWWRlZElUSDZzYnk0MksyVjVGQ2hhZXlDTkhyeHYwaXVL?=
 =?utf-8?B?UlJFdVZUeDZMNVJadmprMXpqV3ZWMmVBcVk1dUJHckVjMTQ0blNielU3RUpj?=
 =?utf-8?B?V2luNEs1eHFrRE0rdUFEU0x5czd5bDVuckowOVhPSS9QREI2TW0zenBKc2NL?=
 =?utf-8?B?Y01lODA2WHp6Z3RKRVFmUk9vYW1GOUNUamRLS3JvTndvYVlnaUJnYkc1L2xM?=
 =?utf-8?B?YWwyTlhqRzU0ditteTNUTHNydVBZVFFYL1BJV3U1eUlnWURJTkJqMU9mTndQ?=
 =?utf-8?B?dmRZWWZ0WHNzeHF3Z3A5Y2ZMdFNRbUdQQUliYUY3WHAwSmhiMW5NSVhhb1JM?=
 =?utf-8?B?Yk53MytYSHNOcDRwcUhoWFowblJSWTdtK0R3WUJ2NHp1L1h3WTdhUkRsVHNn?=
 =?utf-8?B?SGwxNXVJaEJpaG9lZ3g0RzVuYzMvb3EvWVliem1HMWhXV2I1WDVYQ1ZCSGxQ?=
 =?utf-8?B?RXRtSVVwSGRKOEFSRUJzZDgyTkd3c0dLVFJFYlFrQ0RydUJZVlE3Rm1ldWJr?=
 =?utf-8?B?VHNTS3YvdDJOYnEycTlEOVB0ZXhseUtQMzRZQkliblp5UTBpRE1RcUhocXBl?=
 =?utf-8?B?UWpQSTdueGt4bkJtOEoxV3QvdjdnV05rekhPcmVkcFROTWZzeTJ6N21GbVpn?=
 =?utf-8?B?NmZLTTMreE90QUQzenJadDFHQndBL2puRU1rWVNzejVZZklvUmRtYkZWYUo2?=
 =?utf-8?B?ck9oK3RWTDlVOFBhSSthamMrSTNpb2xmcW11VUVQT0dzSnZwU2NmZ2F4Ty82?=
 =?utf-8?B?RllIWCtZcG1LRDdRNy9RNHd5ajloSlFWckkzdHg4UHlEMm9SU1FVcVpNWWJU?=
 =?utf-8?B?bE5uK3ZLeWVrSHQyZDlXRGRXcTJqckRzdGwwTTB0UUVqMk5SZkVBOTBIK1ZG?=
 =?utf-8?B?Z3BnVkN2UFJuM1FJYVZISzBla3JzSjNQNWkwblBVanNmTXhES3RzcVVISmF2?=
 =?utf-8?B?SlpDVEdIWm1SRTFVeSsrSENsUytCVXdoMUwrTlpFM2RiU2dmOXc1ZzlTb2NM?=
 =?utf-8?B?RCtYSGJ1dG9PYkYxS1pnYjI1TzhDZ1diQm1NejVudU9xcFdCc0pVUlNSMlFh?=
 =?utf-8?B?ZGNnYnlQa09UNUJ2TGwybHYzVkJYNXZwa3A5TThyRHFTUWl5UVZmRVhrK1Ux?=
 =?utf-8?B?YlBPVHlQNko5dVhrQng3YWVUcTl1ZDNwOGpSdml6SFkvd0toaG92MUtsVDNC?=
 =?utf-8?B?Ky9ZQi9ndmZ2bFhkWVRGQkRVbUdocTFiN0piNEx4TzQ5SVIzL054emc3eHFM?=
 =?utf-8?B?NERhRVgrbjBhRFZuREIxZzIyWUJIZXVHZDdlalhka05RVWVldGxuU3Q1UmNm?=
 =?utf-8?B?bzIxK1k4NGtrczRWc2NhVFlCWVV6em9XZitLK1B6WFVKNjFZK3VwVmx3L3FR?=
 =?utf-8?B?cmJCUTFwenRuc1Bwb3Q3bkFVdGs2NkdGSVdUMTIzRitiUTBLSXZhUWp1dnpI?=
 =?utf-8?B?MlU4VmtkWTRyZTFIU2VjSHRiTHhuNmpmZ2VOSnQzRXZyNjFjdXIvQUVPdWZC?=
 =?utf-8?B?WXBsNTFOMktubHptQkJ2VGFIMk1SUWR4NjRDelg1US9Mc0pnYmZLOHlJNTFi?=
 =?utf-8?B?UzZXby9sd3Rla1JJQ2VEd3U1OUNVL2wwV2JTcHdsRmxoNEl0MXFkTmllYnVr?=
 =?utf-8?B?Z0NlKzNLWFpBQkI0bnU3QVZ6WG81djJPb1J3Q3NDNUxJMmtmbE93TUxUS2ZU?=
 =?utf-8?B?OGR2cWM0VlV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBWT1I4OXlnWTZua1RSajhuLzFKQ0lHRFYzeWIyQWxLTlVHbkEvaS8xb3E2?=
 =?utf-8?B?MTdCVkErODZQNmlUYm9wQjFlTkxJSHNlUVdCT0xkcGkvdlhCOUhKcURXNHBx?=
 =?utf-8?B?Zk9BYnVFNTl5QVlEU0MzZkdOa0xLL1FJT296VTBqYlZMTkdMWGxIbEcrOFMv?=
 =?utf-8?B?L1RXbVlqdExFVEZxY255OVFVektvd3NJa2VIMS84VEhuRGtGZ0Y3TndyOFJp?=
 =?utf-8?B?SFl4UENpNVhxanNaU2kxNVcrUzMvaHFBbU5DVTh6R1d3YnNuRitRNXEyZmpz?=
 =?utf-8?B?SkZVSDlaNDFkL0FMVVF0clY2VEpkWndHY3h0WFVsbjU4OUpqbkFaU2lsWnY2?=
 =?utf-8?B?SUFqdmRrb3VuL3pEUDVOUkRHa3JQYzhBQ3JuaEJpNG9zeVB1Wk1ZenNIMThV?=
 =?utf-8?B?QXZIV2NucmZSU2Q3djdXSmNZaWRYdm9XRERWK1dQNzhpTlJpaEtqZzZTR0ll?=
 =?utf-8?B?bHVrcEg5am9zYnh5VDFyTlF0S2tDOFFyUlpGU1NMUG11MXpISmVQNWlHcDhH?=
 =?utf-8?B?RG9oUVZHVXp1ZnUySGc0cGZGNnFFRm0vNWxrQ01RS1ZjdjllMlJSTGZhS0ZY?=
 =?utf-8?B?U3c3OE5GTUpKbEprb3NHa09IZUFpTzFOOGRVODhSanRrRG5sU1ZyWUxVOEVn?=
 =?utf-8?B?TWFaZWM4NjFFZzN0M051b1NGOXZnSTE3UERZOG5MY2NONDl6aDVxZWVGYXo3?=
 =?utf-8?B?bHBWT056dDZ4Wm82eE1MMzQ3TFNWWk0rdlo1UEdFb0dWZWFiaS9jMEk5RS81?=
 =?utf-8?B?b1JKWllxV2dTWnQ0dDlRSlhDeG5qSHJ6bUF5NHpTV2JNcTdINEI2bHpFMHVn?=
 =?utf-8?B?eFJvR2R4NzErTGhaODNFS1B0QVZCSFBQOFkwUlNaUzkzeVZ6RXZuc2hSazBi?=
 =?utf-8?B?RENMQ1JSVEYvb0l5K2lEUjNhSXdZK3p6REVMNUNUOFBzbmxKeS81WlRocUJs?=
 =?utf-8?B?alN4VkRvQXl5cHNRRlF4NEppNktvZlFnQ2xLUXdCUnEyQzdWdkM3SS9tYzZa?=
 =?utf-8?B?UmFpZnY4RERuYjlSTFIrV2xOeG9GK2ZJb3QvWjFxQzdJN2NIR0pxVXRBU0VN?=
 =?utf-8?B?Zm9SUTdmUkY3bDVDNSszek51ME1rcWtFaXFWOUJBaW1KSk5MRTZCcVpVQVpP?=
 =?utf-8?B?dEpmamNuWWlJMHlKZk5tbjM1cGl6UUh1WkRGQm02RE1OU2g5SHl6ME0rejdP?=
 =?utf-8?B?VGZ2eld3SHlYYjN5MXBpZkF0SU56RlVYVy94aTZ1VlFKcmU2bERFcnRyTUR3?=
 =?utf-8?B?b2ZRL012dDJMNWR2WXJPYXBmaUZFang0NUcxTnBZeVBGTUcxOTZSck5GMjlX?=
 =?utf-8?B?RzZRYjJSOWF4MElqTjdWUGF0WDZrQWJhRExJbHMzS3YyUU94OUhGWlc1aGEz?=
 =?utf-8?B?OWNUUHBBMGlYMXMxVXUrQ3ZoZXV0dDREczB3dVlYRVlnVTVob2grL1ZlU1dq?=
 =?utf-8?B?ZUF2RW1EYXhtQzBHQTh2bUF5bms5ZUp2UTZ0ZFR3Q1AyVnlDZDFvL1poRUFU?=
 =?utf-8?B?NFM1MEJvWS9iUEtRbFJDQ2dKSXZ3TFJEbVpJK3djREpJUU9kTUsvOVZXRStL?=
 =?utf-8?B?V2FpNjFiV3g1Tmh0cE5uS0x1TlY0Rk94TThwbHBiWnRwMGo3ckk1ZUluc2FW?=
 =?utf-8?B?K0U4bHdSeGhCRnpuKzFaWkhvMzEzUVBhUmFXenR6Q0QxLzRrd3BUeHN6Nysx?=
 =?utf-8?B?eEdnempOR3lWbGt2OHJkQjhYSk1xSlhhQUd6R2NGTHM1SEJISG15VDJUNS9k?=
 =?utf-8?B?LzRsNCtXeEZ6ZVpVRXdWS09SRFJ3TGtpWnRHaHhVOVIwbWk0ektMQ2RCTzg1?=
 =?utf-8?B?YUtGa3FLUTNRbUpHM2VmdmIvQ2NrQiswQ3JuWWk4UVJJbUg3QzN3eTUydjgw?=
 =?utf-8?B?d2V6WXRzckF3N0NHcDMxUFNPYVRraElZSnEzUXhVMlQ0bkpsMjY0cGVDVkxy?=
 =?utf-8?B?THJxc2pqNFVuWS8rYldNR2ViZDg3blQ0emRvSEVSMDlwY1kvOFFReGhQZjJi?=
 =?utf-8?B?Nk16N2l4WnVwZ0tvQ2RQcTBDM0hPVnQybFR4dmRsMk9ReW1uZTZyVGZwZ2xZ?=
 =?utf-8?B?b1lSeVZMZ3JIdWFrMitzdzExWnJuUTdmQWpBOVBTVVl3QTlzTnI2RFE1Smlo?=
 =?utf-8?B?RWNjTVJySGNkWmZNYlZNUTNyNU5ZK3VhL3JVNVFrd0duVmFkUnVYSlQ0ejk1?=
 =?utf-8?B?Nk0vU0NCNGl6TWlJK2lmMnAvVWFGYzVCVWpTdEs3c3VKMWdmRGVJUWNpcVVr?=
 =?utf-8?B?cmUzTG05dkxvUVJWZGpnV056SEtrUnBrZGJQb0dOUDFIS202N1dnQi9pb05N?=
 =?utf-8?B?a1lINk15ZS9VNnNFUTkyNFlZMHFIL01lVW5FRjFDSG5uS3UwMzFXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e62ec8-7d6b-4501-fa26-08de527b4b01
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:11:02.7685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgU+MHA5kLRxtGeOuo45noLm/QrRBy6MrvGBftu2WjKhMHFoLTOlh93UbSFNIGYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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



On 1/12/26 21:39, Alex Deucher wrote:
> On Mon, Jan 12, 2026 at 3:28 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>>
>>
>> On 2026-01-12 09:06, Donet Tom wrote:
>>> RFC -> v2
>>> =========
>>>
>>> In RFC patch v1 [1], there were 8 patches. From that series, patches 1–3 are
>>> required to enable minimal support for 64K pages in AMDGPU. I have added those
>>> 3 pacthes in this series.
>>>
>>> With these three patches applied, all RCCL tests and the rocr-debug-agent tests
>>> pass on a ppc64le system with 64K page size on 2GPUs.  However, on systems with
>>> more than 2 GPUs and with XNACK enabled, we require  additional Patches [4-8]
>>> which were posted earlier as part of RFC [1]  Since that require a bit of additional
>>> work and discussion. We will post v2 of them later as Part-2.
>>>
>>> 1. Patch 1 was updated to only relax the EOP buffer size check, based on Philip Yang’s comment.
>>>
>>> 2. Philip’s review comments on Patch 2 were addressed, and Reviewed-by tags were added to
>>>     Patch 2 and Patch 3.
>>>
>>> [1] https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
>>>
>>> If this looks good, could we pull these changes into v6.20?
>>
>> The series looks good to me.
>>
>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>>
>> Alex, what does it take to get this into 6.20? I guess you'll want to
>> include this in a pull-request for drm-fixes ASAP?
> 
> Yes, if you can land it in amd-staging-drm-next ASAP, I'll include it
> in this week's PR.

If possible feel free to add an Acked-by: Christian König <christian.koenig@amd.com>.

I will try to work with Pierre-Eric to get the DMA window patches upstream so that it is possible to base the rest of the work on top of that.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>>    Felix
>>
>>
>>>
>>> This patch series addresses few issues which we encountered while running rocr
>>> debug agent and rccl unit tests with AMD GPU on Power10 (ppc64le), using 64k
>>> system pagesize.
>>>
>>> Note that we don't observe any of these issues while booting with 4k system
>>> pagesize on Power. So with the 64K system pagesize what we observed so far is,
>>> at few of the places, the conversion between gpu pfn to cpu pfn (or vice versa)
>>> may not be done correctly (due to different page size of AMD GPU (4K)
>>> v/s cpu pagesize (64K)) which causes issues like gpu page faults or gpu hang
>>> while running these tests.
>>>
>>> Changes so far in this series:
>>> =============================
>>> 1. For now, during kfd queue creation, this patch lifts the restriction on EOP
>>>     buffer size to be same buffer object mapping size.
>>>
>>> 2. Fix SVM range map/unmap operations to convert CPU page numbers to GPU page
>>>     numbers before calling amdgpu_vm_update_range(), which expects 4K GPU pages.
>>>     Without this the rocr-debug-agent tests and rccl unit  tests were failing.
>>>
>>> 3. Fix GART PTE allocation in migration code to account for multiple GPU pages
>>>     per CPU page. The current code only allocates PTEs based on number of CPU
>>>     pages, but GART may need one PTE per 4K GPU page.
>>>
>>> Setup details:
>>> ============
>>> System details: Power10 LPAR using 64K pagesize.
>>> AMD GPU:
>>>    Name:                    gfx90a
>>>    Marketing Name:          AMD Instinct MI210
>>>
>>> Donet Tom (3):
>>>    drm/amdkfd: Relax size checking during queue buffer get
>>>    drm/amdkfd: Fix SVM map/unmap address conversion for non-4k page sizes
>>>    drm/amdkfd: Fix GART PTE for non-4K pagesize in svm_migrate_gart_map()
>>>
>>>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  2 +-
>>>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  6 ++---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 29 +++++++++++++++++-------
>>>   3 files changed, 25 insertions(+), 12 deletions(-)
>>>

