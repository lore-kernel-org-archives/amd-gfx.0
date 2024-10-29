Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0E2D5B16F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 08:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BE510E1FA;
	Tue, 29 Oct 2024 08:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qBIfkADQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDB110E1FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 08:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=InBuGlMM/TIDJdoOJCkJcSquTOiqTyejc/ax6qJSgTsotkZ81zypJ/eeePVJuVQMz4DZe0W5wbVmi2EGcio9zfwjbORxSDBlWFTzhvv/a8Wdy4L+q6bHguLuVl3uAXF46FVZzFY+O6D8/H8zd72XCZOU9cK6QujkgINsCaXTTtKWC8h9yC0XSC0vKifUNbhgUVvf+t67u5qRJ+CoiMnMMUrGCR6pTOx/7KGZqRroNNbhB6SdTGWdULKWzO5lecv+mAfo/6ogObPghpFxF1YF2nU7gKrf/pkuI0E9O6/PNR2Lz9xAKcyEysxbuW+8V5F5IJcVPkFYW2uyKMgfE7+m/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+gsLYwnY81STCBaTYuSZj/Gk+B64yd+YJwlaNaAnf4=;
 b=BH5Zdh0UqQ/LX6c4AlN6rPnRn9YHN8L291DUbZvXXhqNKX75NTEToVhvMGYTn7B+ia8TojrFZXoBUs2mI/VO6CgWphGZ7dG/wY6AIgI9Iz6k42K+379l22ecWIhoEoii5KaVmWSpGsf7CXPclxtONMVZ1Qondqofj3m0OGKNuMQA8uWqmCmyAbq3eR7KKSSiXhPj6VGqiZxomsVmtpL4aqSrI7dfq5FV/1FColoYMlAcw8D9yOBG73GSzzd7nAqP6ljJEkvw/oddonimUrr0DoQgwUxo17xfuWfJL/ADeCGCgP9UqcoSQZDrqRPw0yN3YlEs8nVf/skMNUK6dF8Xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+gsLYwnY81STCBaTYuSZj/Gk+B64yd+YJwlaNaAnf4=;
 b=qBIfkADQU2CDIc2M6Q8KtRRiP7Dvww3rxy1OCIXuGAS3zye+vvzHvQnVCvEubmb7DEKQItCvfLl310pwrMHXN78CtXWiCQ2Qim/rwO4Wtc3bO36KPP6uUqKCJMPJmCZeOkItzxpwQbiBfpMHQsJAsvzhrdxXEUeHogCClWi/uXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Tue, 29 Oct
 2024 08:47:29 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 08:47:29 +0000
Message-ID: <e8802a52-50c8-4f2a-85d4-89538ac69f5f@amd.com>
Date: Tue, 29 Oct 2024 14:17:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset
 mask
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
References: <20241029071447.3077959-1-jesse.zhang@amd.com>
 <fc99c891-b2e8-45b8-aeaa-a0d0bd023b05@amd.com>
 <DM4PR12MB5152343840E34CC281B3E4EAE34B2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB5152343840E34CC281B3E4EAE34B2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BL1PR12MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d853da-a00c-46b2-a61e-08dcf7f651fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajNDaGcwYkpUQmdBWUtzWEEzYmZTWW9ONXhiSE9MVVpTd2RmWE1QaWdWNDJ6?=
 =?utf-8?B?cmNtMjNPamE4aHFkQ1o4SkhyZE1PaFQ3bFJwK1VORjMzYUJRV0FneENoaHJQ?=
 =?utf-8?B?WGNEQm95bjNZTUNCYnhGUFQzNzQxSjdKdjFsSkxnRnd2MjhRd2kzUHozSXRx?=
 =?utf-8?B?NlVEYS9ETU5YUUUyWnpybVlyWU9yRjF0U3VTRW0zK2ZlbUZwZW5kTDdpRkla?=
 =?utf-8?B?L1psY0xET1dXdEYxS1ZtSnhXaXY4R3hENmFGNVJNb3dUYU5WT24ra0N2NWVi?=
 =?utf-8?B?eXJwdkZ0TjQ1SFMwVTErUkFFWWxObGxvSnFqWVByODJZRlhiNEFCWWhCam80?=
 =?utf-8?B?VGMwWkt3ajN2aDNIeXRxLy9UdTJVMkluVzlIbklkZEtmWnl1ekZqSFVmZmdT?=
 =?utf-8?B?cE9XZkVRR01lM0g0Z2h3TFZMSDBad3h4ejhLbWdPa0ZMK1Z4QklaVGcvcGRt?=
 =?utf-8?B?OTZ6Ly9WNHpRNis5U1ZTV3ZJcDhEblI5M1YvYUU3RjZyUitXR2J0dkFNYjNK?=
 =?utf-8?B?bVpoM0NKRjBPdndhSXFST3k4cmxLOElqOGhsUEcxZVE3aUppT0VQQ3FqdjBV?=
 =?utf-8?B?eXRhQjNTc1NyY3ljYmMycnUwNTRhWmZKZVVMbmhOVzB4LzNpY0g0cEE0WEpy?=
 =?utf-8?B?L1hkSis2Nk5RVGsySkZGbXoxbVV0cm9lemRTY3d4cWRMSjJEK1B6NVp3NzRt?=
 =?utf-8?B?bCtjSkxMTmk2ZFRXZlFYV0tjOWdmbjVuZnVZdXFESy96NVoySzNJUElNdWRP?=
 =?utf-8?B?USt1UUloUEdTRldxWUZydVpHRHZ1Qlp6WGtidjFJcXlOTDY4alp6TllPYy9Q?=
 =?utf-8?B?SDI3VTdsWndYd2V0TzJrTXFqaWFpOXNZVzNpZUJnRGtDa3V5Q0tEUVRjSjlZ?=
 =?utf-8?B?WVVSWktjei94OG1ETHR4cjVrbnVVWTRkU0ZBN0JtNiszaks5eGh0M0ZiMHpp?=
 =?utf-8?B?cWcwVEVheE1ZVGZYZTBENmlHcUR5cVIyWjdsREtsOGF0VDNGNjdMV1hxZnds?=
 =?utf-8?B?dUVsdUpVYXo2TWwzQ01TeG81MTExU0FWbzRFMkhzTVJCVDdFUUZaRGRrbU9Z?=
 =?utf-8?B?U20zTCs5WTB5eHMzZFd5eXh6M1dUNWtaRUU3QVBzNXV6Uko1OXlNbDk0UXhs?=
 =?utf-8?B?dWx3UUwyMjYrZjdaUGxVQ2xZN256eGh0Y0hMSU14TWhtR3ZvK2MyWVhQa0wv?=
 =?utf-8?B?bXphUWVRdDJoaXVxQXhhMnJrT3BEZ1BoQTJHQjhjdUM1VXVLNzdWRXduMTVl?=
 =?utf-8?B?YkNvNlVuL0EvdFBEQVR0SE5nTDJaOWZoczZwSXlZQ3IySWkxdGpZZTJhaUho?=
 =?utf-8?B?TXhsTi9HZE1xMDQ5NXBubERjb3lBUUJwYlJzaDFYQjV0LzZSZVNiMnZ5Zkpq?=
 =?utf-8?B?WE5PRXgyL0FJQ2QxZ0doSStHeHg3alI0ZnVVNjNmQnlic0ZHNXpQd0d1TWtN?=
 =?utf-8?B?anJub3dScUVGMElxODVRQTVSYm1PSGxxMDV1Znd1Y2pkVnZhUmJ4MmNsekRR?=
 =?utf-8?B?Uy9mSU9SNGRBSTVQVFUzNWZPV2dpakMvcE5LTHhzNmRMcnBwQzBiZC8rdlp0?=
 =?utf-8?B?d3pvTi9UL0tmRmpXSE9tVXpKY1AxSmlpSlQvalZlQXd4STE4U21vL2NFOUNw?=
 =?utf-8?B?d2Z5bW9mcXNNcHJ3UVBJdlUrVGI2czMvSmZtTTdyVmdvZVlxZ3NnRDVIV0hY?=
 =?utf-8?B?ZjNSUmZLVDVDWmxmTWlJSmZFQ1lPQnFEWXVqejVHMldpMlkrYXFxTHZLSTZL?=
 =?utf-8?Q?pmx9QQ1N5vQWjbbTwA0Ok/LWz7Ln7/haQz1qo7+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3NzSzlFclpqTkZQdUhsa2g1SnNDNGtnWktSTllaQ3d3NExtZ1NmR3hGSW05?=
 =?utf-8?B?T2NTUDZBYjBSUGhiVEZScXc5OVpTam1KM09zWnZhRDNsYVdzb2NOZEljclc0?=
 =?utf-8?B?UXlqd1lxK1Y5VTh3cmp2dXhXek9tbGg5d09xTW1oVnFvc2JNd0RuMXpTQlVN?=
 =?utf-8?B?a1JLNjF2NDRJNXlpY1NOb3krQVpYbUVwZUxMR05MMmV0MUFMcm5RRDRTalgr?=
 =?utf-8?B?VTFkTndFS09SbThGK09INFRTY2loazd0Q0tZYW4xMGZ1YThvSGtmMWN0SU52?=
 =?utf-8?B?QmRZY1JqTVdOTjRjcXdMSHpkL1dEZ1p2alh3TTRvemwvWWJTVmZIbFFNem85?=
 =?utf-8?B?WjRacEw3VUxRQnFRMmlNYWIzY2hFUDU1UTAyVkFEZjM4ak94TnVEMGFROUNp?=
 =?utf-8?B?TTdVeFBWWG5jQzJRVVVOMk5UMWtiTUtITGo4ellBRkJseGgvYy9vSVpWV2Y5?=
 =?utf-8?B?cExpbHVSTzhlS0t6cWR4QXp5elA1dG5LRERiWjgrdXRuN1FHWExISWM2dGpk?=
 =?utf-8?B?SWJXTFkyUGczekFvOFZ2SDRsam0vYi9qeVlyS0NIZ1NZRzVjaVZsOEFIQ1dn?=
 =?utf-8?B?R0Y3dFp2U1dPUDdvL1V2L1NqOW9zYUtyMkd1amw3ZVhpSkFHRW5qQ2tIZ2dh?=
 =?utf-8?B?UkdoWHhPaXBFVThBaE4zbFZVWlMzRFpvKzN3RitHVWk0cG9JbGE3SURINFlR?=
 =?utf-8?B?UTYzYmtxcjR1MkhMLzIrdU8yZnk3MkdlWEZybmlMY2kxdzZJVHppQlNxMkhG?=
 =?utf-8?B?WjNYbUk4VXdmdXViWHUrTE9McEw5NGp6VlBpMzJ5b3o3VzBmaGd2aU5TUXhP?=
 =?utf-8?B?NHdnWTJVdFcvbnI3VGpoTnBQNjNDRy9IL0dtNnlRVFVDcnJkcnphSlYrUWMw?=
 =?utf-8?B?Vmg4dmNvMDlOcXlQZWlCRmVCQ0JRQ2tieEoyN2RFZWpDNEtuUHMzTnVDVndN?=
 =?utf-8?B?cmtPVGV0MnovdEpWa0ZMMDZ4Y0hBWXloUVVxUHdSWm9va29iazh0OE8vd3pV?=
 =?utf-8?B?RC9wZjMvY0dZc3EvWVd6aGpnVHVsUVZmM3ZKYzNRU2swRjh4WDZFQ0lySDZY?=
 =?utf-8?B?b0dnMG8yU3lNTFppbUpEZmNTZG9WbzNueXF6UHpVcncxcWl0SStGOUFoT3pJ?=
 =?utf-8?B?ajhPQ3JlSmZUS1N2MXdLT2tMa3NXTFNhTWJqWkh2VEEzTm1SVGRzbzhLL3Fi?=
 =?utf-8?B?RTlkeThMUDBvSmtzM29DMEdKekk3aU4vb1hkem9yQ1NXOUFuNnZobkN4bjlQ?=
 =?utf-8?B?SW0wR1NOV3hxVU9JUVNRSmZmM2x1NFhGc24xa3c4NERXdDN0ZnZ2WHFwWlVP?=
 =?utf-8?B?ODJQMzc1WXZmRElaUjJWWlMydUhEV2hOSUdDTjVlVzJEZHVabm12aVFVSDFj?=
 =?utf-8?B?UjNjb0FmVjdhbDU4Rmw5YXBER3BVaDBySksyczhKdVVHaHFXcUN2b3pTSEgv?=
 =?utf-8?B?eUU1eVAzTkhXbklSblBjZU5ENVdiS2twbDVQNG05RzQ4WGZjSXZaV0R5NUFY?=
 =?utf-8?B?eXFWZ25lbnEvY3Jiemk2L0pERi9MNGdxU1JoQnZGQVZTNUJwSTNtM2h6Zjlj?=
 =?utf-8?B?bFFXQW95WEdMRWlLTjVJOGplUlFveDJIQUVtOWNrMytTYjV6S2p2Z2ZZdVRG?=
 =?utf-8?B?VE9TMjczdlNDY1ZYQ1lPQnIxQVJSWGZrTHd0TlRSQUgySTlSK1p3RmZkOCt5?=
 =?utf-8?B?bTA2YVVaUndLWXVNVDNhR2FZYXNNY2xYb01FY1J3RWxqRzNQMVBtWEhPWlFK?=
 =?utf-8?B?MmwwZzJGclFycHlwcWFhSEluU3ZORVdKQzE1TzNWMnR5WnJ2R1p0dDV2c09M?=
 =?utf-8?B?elZqQ092czhmWDV4ZkE2SmpsOCtaU2dzY3FBbklKS1pZeUJnNnJkQ3NhV01u?=
 =?utf-8?B?WkRJeERqOHFWb2huYmlXMjB0U3ArR1FJOHk5WXhMdUtITVRXZjYwSE5QMjV4?=
 =?utf-8?B?eVJ4NnprZzdqZTBnSjhsSktXZjZWT3NxZTRYaFYxMVgySitOMHdBVDhxMWhi?=
 =?utf-8?B?OVpQY1FpWHdGV2NmMExvd2xJMmlvdTRsVUptVGo5SkFLcmdsbnJ4Wm81Z2Z5?=
 =?utf-8?B?dFRZc29ia0d1ejBsSHRMWU1kUis1NEl2dmkwUmhCL3QycmlRWkNIR2wzbFBp?=
 =?utf-8?Q?IA9m6y6pc0TqONdskllUSABHf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d853da-a00c-46b2-a61e-08dcf7f651fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 08:47:29.1549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TJdluCRCpu9QDdmgJMfsLNB/hgsMTpC1/jRQcgi4eGb1PeZalgzO6R12sZYLL15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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



On 10/29/2024 1:55 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo,
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, October 29, 2024 3:58 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
> 
> 
> 
> On 10/29/2024 12:44 PM, Jesse.zhang@amd.com wrote:
>> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>>
>> Add two sysfs interfaces for gfx and compute:
>> gfx_reset_mask
>> compute_reset_mask
>>
>> These interfaces are read-only and show the resets supported by the IP.
>> For example, full adapter reset (mode1/mode2/BACO/etc), soft reset,
>> queue reset, and pipe reset.
>>
>> V2: the sysfs node returns a text string instead of some flags
>> (Christian)
>> v3: add a generic helper which takes the ring as parameter
>>     and print the strings in the order they are applied (Christian)
>>
>>     check amdgpu_gpu_recovery  before creating sysfs file itself,
>>     and initialize supported_reset_types in IP version files (Lijo)
>> v4: Fixing uninitialized variables (Tim)
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com> Suggested-by:Alex
>> Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  9 +++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 23 ++++++++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 10 ++++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++
>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 17 ++++++
>>  9 files changed, 184 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 48c9b9b06905..aea1031d7b84 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
>>  #define AMDGPU_RESET_VCE                     (1 << 13)
>>  #define AMDGPU_RESET_VCE1                    (1 << 14)
>>
>> +/* reset mask */
>> +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset,
>> +mode1/mode2/BACO/etc. */ #define AMDGPU_RESET_TYPE_SOFT_RESET (1 <<
>> +1) /* IP level soft reset */ #define AMDGPU_RESET_TYPE_PER_QUEUE (1
>> +<< 2) /* per queue */ #define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /*
>> +per pipe */
>> +
>>  /* max cursor sizes (in pixels) */
>>  #define CIK_CURSOR_WIDTH 128
>>  #define CIK_CURSOR_HEIGHT 128
>> @@ -1466,6 +1472,8 @@ struct dma_fence *amdgpu_device_get_gang(struct
>> amdgpu_device *adev);  struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>>                                           struct dma_fence *gang);
>>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
>> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
>> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>>
>>  /* atpx handler */
>>  #if defined(CONFIG_VGA_SWITCHEROO)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index ef715b2bbcdb..cd1e3f018893 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
>>       }
>>       return ret;
>>  }
>> +
>> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring) {
>> +     ssize_t size = 0;
>> +
>> +     if (!ring)
>> +             return size;
>> +
>> +     if (amdgpu_device_should_recover_gpu(ring->adev))
>> +             size |= AMDGPU_RESET_TYPE_FULL;
>> +
>> +     if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
>> +         !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
>> +             size |= AMDGPU_RESET_TYPE_SOFT_RESET;
>> +
>> +     return size;
>> +}
>> +
>> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset) {
>> +     ssize_t size = 0;
>> +
>> +     if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
>> +             size += sysfs_emit_at(buf, size, "soft ");
>> +
>> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
>> +             size += sysfs_emit_at(buf, size, "queue ");
>> +
>> +     if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
>> +             size += sysfs_emit_at(buf, size, "pipe ");
>> +
>> +     if (supported_reset & AMDGPU_RESET_TYPE_FULL)
>> +             size += sysfs_emit_at(buf, size, "full ");
>> +
>> +     size += sysfs_emit_at(buf, size, "\n");
> 
> Is there an expectation of having "Unsupported" when no reset is supported (supported_reset == 0)?
>   Yes, will add it .
> 

Asked that for clarification. Now I see the sysfs is not created when
recovery is not enabled. Then maybe you could avoid creating sysfs if
supported_reset = 0. Or, create anyway and show unsupported if
gpu_recovery or supported_reset = 0.

Thanks,
Lijo

> Thanks
> Jesse
> 
> Thanks,
> Lijo
> 
>> +     return size;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index e96984c53e72..6de1f3bf6863 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -1588,6 +1588,32 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>>       return count;
>>  }
>>
>> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
>> +                                             struct device_attribute *attr,
>> +                                             char *buf)
>> +{
>> +     struct drm_device *ddev = dev_get_drvdata(dev);
>> +     struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +     if (!adev)
>> +             return -ENODEV;
>> +
>> +     return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset); }
>> +
>> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
>> +                                             struct device_attribute *attr,
>> +                                             char *buf)
>> +{
>> +     struct drm_device *ddev = dev_get_drvdata(dev);
>> +     struct amdgpu_device *adev = drm_to_adev(ddev);
>> +
>> +     if (!adev)
>> +             return -ENODEV;
>> +
>> +     return amdgpu_show_reset_mask(buf,
>> +adev->gfx.compute_supported_reset);
>> +}
>> +
>>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>>                  NULL, amdgpu_gfx_set_run_cleaner_shader);
>>
>> @@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition,
>> 0644,  static DEVICE_ATTR(available_compute_partition, 0444,
>>                  amdgpu_gfx_get_available_compute_partition, NULL);
>>
>> +static DEVICE_ATTR(gfx_reset_mask, 0444,
>> +                amdgpu_gfx_get_gfx_reset_mask, NULL);
>> +
>> +static DEVICE_ATTR(compute_reset_mask, 0444,
>> +                amdgpu_gfx_get_compute_reset_mask, NULL);
>> +
>>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)  {
>>       struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr; @@ -1702,6 +1734,40
>> @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>>                           cleaner_shader_size);
>>  }
>>
>> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev) {
>> +     int r = 0;
>> +
>> +     if (!amdgpu_gpu_recovery)
>> +             return r;
>> +
>> +     if (adev->gfx.num_gfx_rings) {
>> +             r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
>> +             if (r)
>> +                     return r;
>> +     }
>> +
>> +     if (adev->gfx.num_compute_rings) {
>> +             r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
>> +             if (r)
>> +                     return r;
>> +     }
>> +
>> +     return r;
>> +}
>> +
>> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev) {
>> +     if (!amdgpu_gpu_recovery)
>> +             return;
>> +
>> +     if (adev->gfx.num_gfx_rings)
>> +             device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
>> +
>> +     if (adev->gfx.num_compute_rings)
>> +             device_remove_file(adev->dev, &dev_attr_compute_reset_mask); }
>> +
>>  /**
>>   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
>>   * @adev: amdgpu_device pointer
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index f710178a21bc..fb0e1adf6766 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -424,6 +424,8 @@ struct amdgpu_gfx {
>>       /* reset mask */
>>       uint32_t                        grbm_soft_reset;
>>       uint32_t                        srbm_soft_reset;
>> +     uint32_t                        gfx_supported_reset;
>> +     uint32_t                        compute_supported_reset;
>>
>>       /* gfx off */
>>       bool                            gfx_off_state;      /* true: enabled, false: disabled */
>> @@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct
>> amdgpu_device *adev);  void
>> amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);  void
>> amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>> void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring
>> *ring);
>> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
>> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>>
>>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)  {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 9da95b25e158..e2b2cdab423b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4825,6 +4825,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>                       }
>>               }
>>       }
>> +     /* TODO: Add queue reset mask when FW fully supports it */
>> +     adev->gfx.gfx_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>> +     adev->gfx.compute_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>>
>>       r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
>>       if (r) {
>> @@ -4854,6 +4859,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>>       gfx_v10_0_alloc_ip_dump(adev);
>>
>>       r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +     if (r)
>> +             return r;
>> +     r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>>       if (r)
>>               return r;
>>       return 0;
>> @@ -4896,6 +4904,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>       amdgpu_gfx_kiq_fini(adev, 0);
>>
>>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>>
>>       gfx_v10_0_pfp_fini(adev);
>>       gfx_v10_0_ce_fini(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index 5aff8f72de9c..ec24e8d019b3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1683,6 +1683,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>               }
>>       }
>>
>> +     adev->gfx.gfx_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>> +     adev->gfx.compute_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> +     case IP_VERSION(11, 0, 0):
>> +     case IP_VERSION(11, 0, 2):
>> +     case IP_VERSION(11, 0, 3):
>> +             if ((adev->gfx.me_fw_version >= 2280) &&
>> +                         (adev->gfx.mec_fw_version >= 2410)) {
>> +                             adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>> +                             adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>> +             }
>> +             break;
>> +     default:
>> +             break;
>> +     }
>> +
>>       if (!adev->enable_mes_kiq) {
>>               r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
>>               if (r) {
>> @@ -1721,6 +1739,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>>       if (r)
>>               return r;
>>
>> +     r = amdgpu_gfx_sysfs_reset_mask_init (adev);
>> +     if (r)
>> +             return r;
>> +
>>       return 0;
>>  }
>>
>> @@ -1783,6 +1805,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>       gfx_v11_0_free_microcode(adev);
>>
>>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>>
>>       kfree(adev->gfx.ip_dump_core);
>>       kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index 9fec28d8a5fc..f5ffa2d8b22a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -1437,6 +1437,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>               }
>>       }
>>
>> +     /* TODO: Add queue reset mask when FW fully supports it */
>> +     adev->gfx.gfx_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>> +     adev->gfx.compute_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>> +
>>       if (!adev->enable_mes_kiq) {
>>               r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
>>               if (r) {
>> @@ -1467,6 +1473,9 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>>       gfx_v12_0_alloc_ip_dump(adev);
>>
>>       r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +     if (r)
>> +             return r;
>> +     r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>>       if (r)
>>               return r;
>>
>> @@ -1530,6 +1539,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>       gfx_v12_0_free_microcode(adev);
>>
>>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>>
>>       kfree(adev->gfx.ip_dump_core);
>>       kfree(adev->gfx.ip_dump_compute_queues);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index b4c4b9916289..94007a9ed54b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -2362,6 +2362,12 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>               }
>>       }
>>
>> +     /* TODO: Add queue reset mask when FW fully supports it */
>> +     adev->gfx.gfx_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
>> +     adev->gfx.compute_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>> +
>>       r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>>       if (r) {
>>               DRM_ERROR("Failed to init KIQ BOs!\n"); @@ -2391,6 +2397,9 @@
>> static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>>       gfx_v9_0_alloc_ip_dump(adev);
>>
>>       r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
>> +     if (r)
>> +             return r;
>> +     r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>>       if (r)
>>               return r;
>>
>> @@ -2419,6 +2428,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>>       amdgpu_gfx_kiq_fini(adev, 0);
>>
>>       amdgpu_gfx_cleaner_shader_sw_fini(adev);
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>>
>>       gfx_v9_0_mec_fini(adev);
>>       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 016290f00592..028fda13ac50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -1157,6 +1157,19 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>>                       return r;
>>       }
>>
>> +     adev->gfx.compute_supported_reset =
>> +             amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>> +     switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>> +     case IP_VERSION(9, 4, 3):
>> +     case IP_VERSION(9, 4, 4):
>> +             if (adev->gfx.mec_fw_version >= 155) {
>> +                     adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
>> +                     adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
>> +             }
>> +             break;
>> +     default:
>> +             break;
>> +     }
>>       r = gfx_v9_4_3_gpu_early_init(adev);
>>       if (r)
>>               return r;
>> @@ -1175,6 +1188,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>>       if (r)
>>               return r;
>>
>> +     r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>> +     if (r)
>> +             return r;
>>       return 0;
>>  }
>>
>> @@ -1200,6 +1216,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>>       gfx_v9_4_3_free_microcode(adev);
>>       amdgpu_gfx_sysfs_fini(adev);
>>       amdgpu_gfx_sysfs_isolation_shader_fini(adev);
>> +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
>>
>>       kfree(adev->gfx.ip_dump_core);
>>       kfree(adev->gfx.ip_dump_compute_queues);
