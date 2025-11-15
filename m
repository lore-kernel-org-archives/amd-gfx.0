Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D1CCE8D7A
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Nov 2025 01:51:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0E310E083;
	Sat, 15 Nov 2025 01:51:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RmyhbKpv";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833FC10E083
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 01:51:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqQs32gIY3lmSuogsdyHmLJk8Eov9kicFJUyn5RV4gqen6SGlbVIOqwx7K7aslOS7X2wQnId8UeXszT8BOUGzohmhNo+5dAuiwN43wf3wTPFH5aki3WPTeymZDmS6nX4q+2l9jN8Xr9+Q6Q/Hb3RRQKHlr6haKlZJAwE9sO2fUbFVtsGABLmjcXrQHF14ZEC97BvKBO/YJXaWrxLRdUgdXN70QJy1eaCMebEtGUEeN/JZtAMSW+14MUUK9hNG+leHf4wJHC4QzgDl+LSvTalhSebrg9MPIYuUnDqUNUzmeE/5guoWT0XoZ4KXM6IBVz4RBtEfg50cpTWQVpR37bkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gmLyhVyg1dZV34fRkrmrKP9M0pZtUXib0J+3S5k9X0=;
 b=gbCFWjTbG6vsrN0XvufH5F9KeNgmKgYKMWcn5Yp1WSaYZ4PMfRzrt6jmu4HcBMXR46fwXEf8oNfjMhkWB0hNuEaC1lom1gnPWmY7aYppWtPSzw98Q49qISSxWDGqCWEVuEZbul9+UMzsv+3sb66WInMfJPyGjdDtN2Eok8sQfF9f0oIQlQE//8Y1Bl1yBNJcoM5Y2OS59ivLIL4zDdeR2P9SS0dVNc+7ffiDvELOGCQH1Ny2ad1epvudsj8ug2Kq99OpmH+1O/pX5JnwXBlnNulmkoCcydP92zZpO25qrWmTpp6Arh8m5V5iuz7zWhVvL99zQqIlPH7mEpM/ksUc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gmLyhVyg1dZV34fRkrmrKP9M0pZtUXib0J+3S5k9X0=;
 b=RmyhbKpv4chZ6IkrUWV29bs34lo3JsktoOqP4Gdmkutp69O97KmrNxAWuAanOhREbawzz937fUkWkilA8W22J9Irb+XI5xVZzbASQs8vKTxrdk0ieVJDEc0WtjEu1ump4SZrQHZd//EhvtmO1yYYAUp1ecuf7xF5LwYm5njC+ME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Sat, 15 Nov
 2025 01:51:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9320.018; Sat, 15 Nov 2025
 01:51:27 +0000
Message-ID: <e6f1c5cd-2ce3-4686-99f8-e8cf0f165b66@amd.com>
Date: Fri, 14 Nov 2025 20:51:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: An adaptive data migration scheme for page
 fault recovery at svm
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251020212414.1890907-1-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251020212414.1890907-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::48) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 581bbfe9-36c5-4f19-fe1d-08de23e97d26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b01TMDZXT084TzRlaGMwek5ZZ21TOEVmVWNEUk82OUd1c2s1a2ZvTTIxRWpu?=
 =?utf-8?B?QkdjQmxqUmtoTFhWTXQyM25MVk9VVjhlZkVHc0szK3hRQ3Jsb1NvdzNoOGpy?=
 =?utf-8?B?cnhNSWg4dWVhaXFLdlZYaHl3NlJKZmdiTkx2OTErWURXcjM2dUZEdWNwMjMv?=
 =?utf-8?B?VWEwbDgrVDJuMWVBZnJHc2orVTBqeVlSY2FDYmhHZlFrZ0RKNW9wNDFiN1NV?=
 =?utf-8?B?U2JRWG5SSzFsWTZYWVhQcW1rN1I5R3ZLOEtweFdGNGhPSG16K2tvS3Rqdys4?=
 =?utf-8?B?cGd4TXJLU0s1YWk2dmxDaDVlQjdIMFltcDNkRnZqODBtYllUQVN1bE4zVUo1?=
 =?utf-8?B?dTR5emw3dEx5c0dJRk9ORVJZYy9WQStGZmRIdk9QQ25oMjAxY25KcVBHN1VI?=
 =?utf-8?B?Y0NNVU11OTQ1eklsM1hobHB6MzVibXUyTitMSmJxSHErQ3pLNFNLd3diQVk3?=
 =?utf-8?B?K3VESWdZYnBHMjkweWhqamZScFYwQW9TNmZBMTJNR1hDdm9OUDUxZU5yUDIr?=
 =?utf-8?B?cmNKRmtYV2JidmxqL0xGTHhyWkRZQU9LK1FpYi9UT0hEMkQ1TVdJTkJ1WHhQ?=
 =?utf-8?B?OUtmak1Nay9yNmhNU3Y5ZkNsMWh0YkhxRUIxcVBuSVM3Z0cwSFlvQmlZaTE3?=
 =?utf-8?B?VVVTb1NnTlkzM2NzTnNLZ0pWYkt4aVkwNzlPb0ljTnVldFE5T28xNXRQSTlw?=
 =?utf-8?B?YUFBcjlWMTcwMExnMEwyMVFFcGtkUjZlR0lFQUU1U2kzdk14em40V2h2TGd0?=
 =?utf-8?B?QVlKSlZ2NjlNNTBhcGkrREhaczdiYVZGcGthUDdPNXRoVnlkSXByVi81c1lS?=
 =?utf-8?B?UFgzc3hHbU5wTElNVjRFRnV0UDVQWWNUdnNNejJWYjUzNXBndG9ScWVuVFhL?=
 =?utf-8?B?dE5WS3VNelpTb3pwVjNIdzBza3BkSlV2TEtsUVFuOU5kdVNBcWVFM0VBN0I0?=
 =?utf-8?B?a1dOME9PL0V3ZnhLUkFuQVdaTEdlWGM4disxQnlXS1J2UnpWZk9RMkF4R1BJ?=
 =?utf-8?B?ak1Uc2NHekJMMEpmRnM1cUJQTTRna1NNMEQ2TWxNNFVFY2V4L2dYSit0dmR5?=
 =?utf-8?B?YXh4MG5wTk03T0VMV05uM3hBcmtBekpkME14QTJtR3FKOW1PUTFhRCttK3JZ?=
 =?utf-8?B?VGJRTFVERjBLbW5XOERKSmt3QTdwK1BZdGFveHZJZ0tPUlg0VVgzeWZEc2d5?=
 =?utf-8?B?Vmo0SkhZMUxQcjdCVVJQQlU4NHE3ZjV5anhIamRSelFEdTZWNTYyR0FNaGlP?=
 =?utf-8?B?TXZrRnRIcXg1ZFQ1d1VEWEd1Qm9Ocm5QaVhwNWFYeEQ2ay9xRXhyQ2lDSVZm?=
 =?utf-8?B?dnE3M2I2Q2NWMElZeWU5bTl5eUFpMGVtT1NndkxRUnhkM2FCaDVMMFYzNmVV?=
 =?utf-8?B?UlpHbFpKRVFiZDI4andnUWhCa2tpSHZPWkhtazUvTmgwV3V2ek42aFcyNFpC?=
 =?utf-8?B?eW0xZzJ2Y3k1cFNkVVFNMzVib3MwT3c5dmFnbllLYkxQay9VOGRncmVraHcy?=
 =?utf-8?B?dktjRG0zMW9wMklTb2hjT2FKa2JCN0ViL3UzeUVla1lTclFwVURCOU0xS2xO?=
 =?utf-8?B?Z2ROQUUxWEJ6VnJaamRyNFppbytCZUFPajVmclpSS2RRTTVaakgvY01FQ0tQ?=
 =?utf-8?B?SFNrcjU5L0FaYkRMYkpsb1Q4Rk0wODhPMit0bHhSQ3NibWd5KzNFZ1JqSTNn?=
 =?utf-8?B?bENrWDBGYU8wV0pkREpRK1RFOFVPK0dGYXF5TS9acXRRa0VibWhlNXRhNVMw?=
 =?utf-8?B?RmNjN25qMlphS3lxQklsSER0MFY5d0o2dytIa2s5ZWczVHdGTlhlTldRTG1E?=
 =?utf-8?B?ZGtMN1ZVZ2RGelkxck5zTU9Oc0k0NUI1MEhRbWNiRlhmakV6RmFQQi8xcnpo?=
 =?utf-8?B?cVNWN2lialZlSG9ZK0dKQUpRYVdHZ095VFBiNytYb2plMUFlWVM4N2lBaVZq?=
 =?utf-8?Q?Qv4QA/hHUXtb8CP4YUrWGqDtwLQonIGF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3pXN3dkMllYQ3hob2V4NkZZVVdJUWlvV3puWTc1TXBQWjRmTFFlYWliZzBn?=
 =?utf-8?B?aytHbHRNNzZ2OGZndTRlQk9EeU5CbzcrMHhsZnNZTnEvRSthaGpZREdiTXdV?=
 =?utf-8?B?TTA3NEZiWXBGTUttYVAya2tucUxpM29tQWxrU0FEcGQvUERIa20zRnh3K1A0?=
 =?utf-8?B?d3RaYmw3TDRleFRuY29ZSFlQRGVjL3BiaXRzWEl3Qkp1Tm40MnVMT0NwWTF3?=
 =?utf-8?B?UStKb1lURjRxdms1b3pXbDV3TmR3aGZocURkVzhBOWkxUDJLQkNyYzBLUFZS?=
 =?utf-8?B?eFd0bjRIMng4OGNRYkNYNEh2RWZ5VkdvNTRiTWVGWjBjZTF6aG1KM2w1NEpo?=
 =?utf-8?B?cFFOK3J4YUdVSE5YVDJrVklWdytMQThiWHdPVmVjVzJCVU1LVXZtSFZHTm81?=
 =?utf-8?B?MTFnV3RvU3FVOVNHbXUvNm5mWXhKTzVTd0tabUNoQ01NSnExMWZxMnZFK2hD?=
 =?utf-8?B?MUlNMXRzdm1YRDc1Y0tJTms0KzEybzR3RTYvZHF5RnFjSllhblN4VEVWaHd2?=
 =?utf-8?B?ZVp0OEMvcllod3FhN2F0UHVvSVlnY1U3RGlzN2I5Y0x1OEpRY0o2cWhOcW9Q?=
 =?utf-8?B?Mk5wRHZxMHVNeE1Mc0lCS2d1MUQ1Y1g0aCtRY3VQYmZKZ1FtSmcxcW1TTWRy?=
 =?utf-8?B?d3hJTmlNUVdwK1NGS2Rqb05qdEZTdVZDdWoya1VVK25UZi9CckRmKytwVWV6?=
 =?utf-8?B?SDRGY2E0c3VZZTVvcFlicFVLWEt2dTBwQlJTcVJ2T1dRendSdHIxR28ybmxy?=
 =?utf-8?B?eDlSUFYxbGRpYndjUlk0c0RNRExPWjVwOU9qeHRoeCt4UEd1NTB3RkxOajdZ?=
 =?utf-8?B?RTRSL0hVbzFQbDFJNjd6Vkc2S2pURVBHeVR4RXJFU0pXRlBMYVlPYnRGaSto?=
 =?utf-8?B?SXVFRnJEb1Avd2V3WFFnYjRQSDYxVUVVM0RjaFFCbUlVbnViSVFYdTVZdENm?=
 =?utf-8?B?MWduYmFQYm0yNUpjYnY0dnRsRkl4WWlVS0g0VHVlWlR5UTd0ZEY0OTZwTERY?=
 =?utf-8?B?SCsrLyt1Qng3d2M1TTZnOHpJYjB1UzlIUlR1cVI1OGoyc2pmdmQ0U3FuT3B6?=
 =?utf-8?B?R2lsc1RLZUpucUZEZzZ5bmZBaWx2cWFEUmtuaVhUT0xIMi9xNVBIVUdQUG5Q?=
 =?utf-8?B?MXpMa01qNmVHVnp5STgwS0dhMStrM0xCaXlsdXZUVytJV0ltajV1Nkk3aW9x?=
 =?utf-8?B?WmJyUXNheDlRUDQrbmszazV3dHlqTmd0ZFN2TjNmd09ybVQ3MzVVSC9YUEZ1?=
 =?utf-8?B?aXpYRURkeWcxR3FEWTFaSnB0N3lZUnVsUVpkWHFWdkpjN2FldzhvbGw2Y1NM?=
 =?utf-8?B?YlYvTDY1OEJad1NjTnh2bTA5U2lpTk1RWHhhcC93SzA1clhaZkV5Z2l6MGZL?=
 =?utf-8?B?RzZOcW51R3VQaWh4Q2FLSVRWWUJFZlduNG1odDUzdThzKzJoWVRwRklCVTV4?=
 =?utf-8?B?S2hsdXFXYkpocFlBbnV1ODkzd2dxbnRxU3RydXFzQ3E4eGVSeGxIdWV4YndC?=
 =?utf-8?B?ZUVkTGI5dzVoV25BeEluR28zVzMwdlZFMmtmUWg0V0sxU05yTVNUVXRZZlJl?=
 =?utf-8?B?RWRLenhlbzdVclZjUmVBUVpNcG1acVNVbWVNNHNGOHViM2ExMnFYYnlod1lo?=
 =?utf-8?B?MVFBWk9mU1VhREtmY1pFNEluNU9PYkdqS3ljd1pIVTJXY21aMDFjQWh5Z3ZF?=
 =?utf-8?B?SzVJVTliblhZdG5qRjJvTzhSMXhIRmdIQzdUbnVkK2Q3L1Vlai9ENFFrS3E5?=
 =?utf-8?B?UlNHNWFuZ1MwM0hkc0xNSGpIQm94TUdCV3I3bUZScDlZNE1pb0VpaTViK2Js?=
 =?utf-8?B?OGdqd0lzci9lRitsdXlPcXdkSituNVVBRlFlVVpoYjBmandGdnR4UlpVNWZI?=
 =?utf-8?B?Q1d2ODMvdEI0UGFWOGE3UXdYdnQ1QUtpejJNbTgvUE1EUmJZZ011QXYzcVpX?=
 =?utf-8?B?d1NMV01idDhCallwRW9CZTF5TGpvSzVBOHhtTjlnMGxyRGhUM2FkdTBWNEJ5?=
 =?utf-8?B?UGF4SXpkcExMOXh5MUMxajlTcHhzdkhQbm01dUlxZWl5Vm9aU2RBNG41dkFO?=
 =?utf-8?B?OGIyUFFSZlNjZ0J2cE85b1ZxMWgvZWZNbmsycnozV0ZjVW1naGY5QUUwZ0N0?=
 =?utf-8?Q?N9EUYKwKMk56dceCHQ2wV/4fi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581bbfe9-36c5-4f19-fe1d-08de23e97d26
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 01:51:26.9012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHzOxF73mm8Tnc34GXDUYnurebT+uBCJ3rYutUZNAygv/ow7Sifq29+1HX4snyqjYa1QWpcEPduL/CfvHV8t2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

I have lots of detailed comments inline, most of which were just made as 
I was reading through the patch. But I want to put my conclusions about 
the overall scheme up top:

I think with your logic, you're replacing thrashing with "sloshing". 
Maybe you could call that an improvement, but it's far from ideal.

I also think that your logic cannot reliably detect thrashing between 
two devices because one of those devices will always have slightly more 
than 1/2 of the page faults. So one of the devices will always be 
allowed to migrate data, although it would be better to leave it in one 
place that's good for both devices.

Your logic in svm_range_restore_pages is also not helping. If you had a 
case of true thrashing and detected it correctly by not designating a 
hot device, things would continue to migrate unchanged. So I'm really 
doubtful that this scheme, as is, would meaningfully improve the 
migration logic in the most problematic cases.

On the other hand, I could see regressions on real workloads. Imagine a 
range that's bigger than num_pf_samples*migration_granularity. The range 
is created on the GPU first by e.g. hipMallocManaged. Then the CPU is 
used to initialize it, that migrates it to the CPU and makes the CPU the 
hot device. Now the GPU starts the computation, but because the CPU is 
hot, the first few page faults won't migrate the data to the GPU. That 
will cause performance regressions.

Unless I see some data showing an improvement in some realistic or 
contrived scenarios, and negligible performance regressions in real 
workloads, I'm not going to approve this patch.

More comments inline ...


On 2025-10-20 17:24, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Data migration between cpu and gpu or between gpus is a common operation at
> kfd/svm during page fault recovery. Certainly, it adds overhead and consumes
> bus bandwidth. So, becomes crucial for compute performance.
>
> There are two objectives that are considered mostly during data accessing:
>
> 1: Locality:  move data to compute devices local memory which is fast.
> 2: Zero copy: not have data moved, compute devices access data remotely.
>
> They are usually conflict: local accessing would require data copy; avoiding
> data copy would have device access data remotely.
>
> The new scheme balances the two accessing patterns by using statistical samples
> that driver records from previous page fault data to predict what data accessing
> pattern would be for future page faults, then use the prediction to handle new
> page fault.
>
> The scheme behavior is also dynamically adjusted by following application data
> accessing pattern overtime. The new decision is based on most recent page fault
> handling data that are saved at a ring buffer.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 102 ++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 212 ++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h |  12 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 151 +++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  30 ++++
>   5 files changed, 473 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 9bde2c64540f..d495af31fa3c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -38,6 +38,9 @@ struct debugfs_proc_entry {
>   
>   #define MAX_DEBUGFS_FILENAME_LEN 32
>   
> +extern uint32_t num_pf_sample;
> +extern uint32_t data_migrate_rate_threshold;
> +
>   static int kfd_debugfs_open(struct inode *inode, struct file *file)
>   {
>   	int (*show)(struct seq_file *, void *) = inode->i_private;
> @@ -50,6 +53,80 @@ static int kfd_debugfs_hang_hws_read(struct seq_file *m, void *data)
>   	return 0;
>   }
>   
> +static int kfd_debugfs_num_pf_samples_read(struct seq_file *m, void *data)
> +{
> +	seq_printf(m, "number of page fault samples per svm range: %d\n",
> +			   num_pf_sample);
> +	seq_puts(m, "echo 'num' > num_pf_sample to change it\n");
> +	return 0;
> +}
> +
> +static int kfd_debugfs_data_migration_rate_threshold(struct seq_file *m,
> +						      void *data)
> +{
> +	seq_printf(m, "data migration rate threshold in 2MB unit: %d\n",
> +			   data_migrate_rate_threshold);
> +	seq_puts(m, "echo 'num' > data_migrate_rate_threshold to change it\n");
> +	return 0;
> +}
> +
> +static ssize_t kfd_debugfs_num_pf_samples_write(struct file *file,
> +	const char __user *user_buf, size_t size, loff_t *ppos)
> +{
> +	char tmp[16];
> +	int ret = -EINVAL;
> +
> +	memset(tmp, 0, 16);
> +	if (size >= 16) {
> +		pr_err("Invalid input for num of page fault samples\n");
> +		goto out;
> +	}
> +
> +	if (copy_from_user(tmp, user_buf, size)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (kstrtoint(tmp, 10, &num_pf_sample)) {
> +		pr_err("Invalid input for num of page fault samples.\n");
> +		goto out;
> +	}
> +
> +	ret = size;
> +
> +out:
> +	return ret;
> +}
> +
> +static ssize_t kfd_debugfs_dmrt_write(struct file *file,
> +	const char __user *user_buf, size_t size, loff_t *ppos)
> +{
> +	char tmp[16];
> +	int ret = -EINVAL;
> +
> +	memset(tmp, 0, 16);
> +	if (size >= 16) {
> +		pr_err("Invalid input for num of page fault samples\n");
> +		goto out;
> +	}
> +
> +	if (copy_from_user(tmp, user_buf, size)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	if (kstrtoint(tmp, 10, &data_migrate_rate_threshold)) {
> +		pr_err("Invalid input for num of page fault samples.\n");
> +		goto out;
> +	}
> +
> +	ret = size;
> +
> +out:
> +	return ret;
> +}
> +
> +
>   static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
>   	const char __user *user_buf, size_t size, loff_t *ppos)
>   {
> @@ -99,6 +176,24 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
>   	.release = single_release,
>   };
>   
> +static const struct file_operations kfd_debugfs_num_pf_samples_fops = {
> +	.owner = THIS_MODULE,
> +	.open = kfd_debugfs_open,
> +	.read = seq_read,
> +	.write = kfd_debugfs_num_pf_samples_write,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
> +static const struct file_operations kfd_debugfs_dmrt_fops = {
> +	.owner = THIS_MODULE,
> +	.open = kfd_debugfs_open,
> +	.read = seq_read,
> +	.write = kfd_debugfs_dmrt_write,
> +	.llseek = seq_lseek,
> +	.release = single_release,
> +};
> +
>   void kfd_debugfs_init(void)
>   {
>   	debugfs_root = debugfs_create_dir("kfd", NULL);
> @@ -111,10 +206,15 @@ void kfd_debugfs_init(void)
>   			    kfd_debugfs_hqds_by_device, &kfd_debugfs_fops);
>   	debugfs_create_file("rls", S_IFREG | 0444, debugfs_root,
>   			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
> -	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
> +	debugfs_create_file("hang_hws", S_IFREG | 0600, debugfs_root,
>   			    kfd_debugfs_hang_hws_read, &kfd_debugfs_hang_hws_fops);
>   	debugfs_create_file("mem_limit", S_IFREG | 0200, debugfs_root,
>   			    kfd_debugfs_kfd_mem_limits, &kfd_debugfs_fops);
> +	debugfs_create_file("num_pf_samples", S_IFREG | 0644, debugfs_root,
> +			 kfd_debugfs_num_pf_samples_read, &kfd_debugfs_num_pf_samples_fops);
> +	debugfs_create_file("data_migration_rate_threshold", S_IFREG | 0644,
> +			 debugfs_root, kfd_debugfs_data_migration_rate_threshold,
> +			 &kfd_debugfs_dmrt_fops);
>   }
>   
>   void kfd_debugfs_fini(void)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 5d7eb0234002..8c9ffb258062 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -39,6 +39,16 @@
>   #endif
>   #define dev_fmt(fmt) "kfd_migrate: " fmt
>   
> +/* threshold of data migration rate(per second, DMR) per svm range
> + * in 2MB unit, so 512 is 1GB */
> +uint32_t data_migrate_rate_threshold = 512;

These global variables should have a proper prefix. svm_... to match the 
conventions in this file.


> +
> +/* nubmer of most recent page fault related data driver keeps per svm range
> + * driver uses them to check how data got accessed after page fault recovery
> + * then decide migration scheme for new page fault recoveries.
> + */
> +uint32_t num_pf_sample = 20;
> +
>   static uint64_t
>   svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
>   {
> @@ -476,7 +486,8 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			unsigned long start_mgr, unsigned long last_mgr,
> -			struct mm_struct *mm, uint32_t trigger)
> +			struct mm_struct *mm, uint32_t trigger,
> +			unsigned long* migration_amount)
>   {
>   	unsigned long addr, start, end;
>   	struct vm_area_struct *vma;
> @@ -554,6 +565,10 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   					prange->npages * PAGE_SIZE,
>   					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
>   					node->xcp ? node->xcp->id : 0);
> +
> +	if (migration_amount)
> +		*migration_amount += mpages;
> +
>   	return r < 0 ? r : 0;
>   }
>   
> @@ -778,6 +793,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    * @last_mgr: last page need be migrated to sys ram
>    * @trigger: reason of migration
>    * @fault_page: is from vmf->page, svm_migrate_to_ram(), this is CPU page fault callback
> + * @migration_amount: return number of pages got migrated after call
> + *

Extra blank line.


>    *
>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
>    *
> @@ -786,7 +803,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>    */
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			    unsigned long start_mgr, unsigned long last_mgr,
> -			    uint32_t trigger, struct page *fault_page)
> +			    uint32_t trigger, struct page *fault_page,
> +			    unsigned long* migration_amount)
>   {
>   	struct kfd_node *node;
>   	struct vm_area_struct *vma;
> @@ -856,6 +874,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			prange->actual_loc = 0;
>   			svm_range_vram_node_free(prange);
>   		}
> +
> +		if (migration_amount)
> +			*migration_amount += mpages;
>   	}
>   
>   	return r < 0 ? r : 0;
> @@ -881,7 +902,8 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			unsigned long start, unsigned long last,
> -			struct mm_struct *mm, uint32_t trigger)
> +			struct mm_struct *mm, uint32_t trigger,
> +			unsigned long* migration_amount)
>   {
>   	int r, retries = 3;
>   
> @@ -893,8 +915,11 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> +		if (migration_amount)
> +			*migration_amount = 0;
> +
>   		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> -					    trigger, NULL);
> +					    trigger, NULL, migration_amount);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -902,22 +927,179 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (prange->actual_loc)
>   		return -EDEADLK;
>   
> -	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger);
> +	return svm_migrate_ram_to_vram(prange, best_loc, start, last, mm, trigger,
> +				       migration_amount);
>   }
>   
>   int
>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>   		    unsigned long start, unsigned long last,
> -		    struct mm_struct *mm, uint32_t trigger)
> +		    struct mm_struct *mm, uint32_t trigger,
> +		    unsigned long* migration_amount)
>   {
> +	if (migration_amount)
> +		*migration_amount = 0;
> +
>   	if  (!prange->actual_loc || prange->actual_loc == best_loc)
>   		return svm_migrate_ram_to_vram(prange, best_loc, start, last,
> -					       mm, trigger);
> +					       mm, trigger, migration_amount);
>   
>   	else
>   		return svm_migrate_vram_to_vram(prange, best_loc, start, last,
> -						mm, trigger);
> +						mm, trigger, migration_amount);
> +

Extra blank line.


> +}
> +
> +/**
> + * @prange: range structure
> + * @start: start addr in page of page fault triggred migration
> + * @migration_amount:  migration data amount in 2MB unit
> + * @src:   from which page fault happened
> + * @migration_or_remote: migrate data or remote access
> + *
> + * update svm_range->page_fault_data after some pages got
> + * migrated
> + *
> + * need be under svm_range->migrate_mutex protection
> + */
> +
> +void update_pf_migration_data(struct svm_range* prange, int32_t pf_src,
> +				bool migration_or_remote, unsigned long migration_amount)

Missing name prefix.


> +{
> +	uint8_t pf_data_index = prange->pf_data_index & 0x7f;
> +
> +	lockdep_assert_held(&prange->migrate_mutex);
> +
> +	prange->page_fault_data[pf_data_index].ktime = ktime_get();
> +	prange->page_fault_data[pf_data_index].migration_info =
> +			MIGRATIOM_INFO(migration_or_remote, pf_src, migration_amount);

MIGRATION_INFO can only store 16 bits of migration_amount (up to 64K * 
2MB = 128GB), but you're passing in an unsigned long that can be bigger 
than that. If that ever happens, you'll overwrite the "device" field. 
You need a range check here.


> +
> +	/* check if page_fault_data buf is full */
> +	if (!(prange->pf_data_index & 0x80) &&
> +		(prange->pf_data_index + 1 >= num_pf_sample))
> +			prange->pf_data_index |= 0x80;
> +
> +	prange->pf_data_index = (prange->pf_data_index & 0x80) |
> +				(((prange->pf_data_index & 0x7f) + 1) % num_pf_sample);

Num_pf_samples can be changed through debugfs after the page_fault_data 
of a range was allocated. That can lead to out-of-bounds accesses. You 
probably need to store the allocated page_fault_data size in the prange 
or some other place that can't be changed at runtime to be safe.


> +}
> +
> +/**
> + * @prange: range structure
> + * @hot_device: device who accesses data(by migration or remote)
> + *  		  mostly

This is an output parameter and should be documented as such.


> + *
> + * Return:
> + *
> + * false: data migration rate is not higher than
> + * DATA_MIGRATE_RATE_THRESHOLD
> + *
> + * true: data migration rate is higher than
> + * DATA_MIGRATE_RATE_THRESHOLD
> + *
> + * return value will be used to decide migration scheme in
> + * following operations.
> + */
> +bool processing_pf_migration_data(struct svm_range* prange,
> +				   uint32_t* hot_device)

Missing name prefix.


> +{
> +	uint8_t start_index, last_index, next_index, device_idx;
> +	bool ret = false;
> +	uint32_t i;
>   
> +	/* in nanosecond */
> +	ktime_t time_last, time_first;
> +	s64 time_interval;
> +
> +	/* in 2MB unit */
> +	/* data for cpu is saved at MAX_GPU_INSTANCE-th entry */
> +	uint32_t migration_amount_device[MAX_GPU_INSTANCE + 1] = {0};
> +	uint32_t remote_amount_device[MAX_GPU_INSTANCE + 1] = {0};
> +
> +	uint64_t total_migration_amount = 0;
> +	uint64_t total_remote_amount = 0;
> +
> +	/* page fault data buf is not full */
> +	if (!(prange->pf_data_index & 0x80))
> +		return false;

You probably don't need this check. If your buffer was not filled, the 
time_first will be 0 and your time interval will be very long. So you'll 
be below the migration rate threshold. Not treating the high-bit special 
could simplify your handling of the pf_data_index everywhere.


> +
> +	for (i = 0; i < num_pf_sample; i++) {
> +
> +		bool is_migrartion =
> +			MIGRATIOM_OR_MAP(prange->page_fault_data[i].migration_info);
> +
> +		uint16_t migration_or_map_amount =
> +			MIGRATIOM_AMOUNT(prange->page_fault_data[i].migration_info);
> +
> +		device_idx =
> +			PF_DEVICE(prange->page_fault_data[i].migration_info);
> +		/* convert to array index */
> +		device_idx = (device_idx != CPU_DEVICE) ? device_idx : MAX_GPU_INSTANCE;
> +
> +		if (is_migrartion) {
> +			migration_amount_device[device_idx] += migration_or_map_amount;
> +			total_migration_amount += migration_or_map_amount;
> +		} else {
> +			remote_amount_device[device_idx] += migration_or_map_amount;
> +			total_remote_amount += migration_or_map_amount;
> +		}
> +
> +	}
> +
> +	*hot_device = INVALID_COMPUTE_DEVICE;
> +
> +	/* prange->page_fault_data's next index is prange->pf_data_index
> +	 * it is cycular buff. get start and last entries to cal time(in nanosec)
> +	 * during which these page faults happened
> +	 */
> +	next_index = prange->pf_data_index & 0x7f;
> +	last_index  = (next_index == 0) ? (num_pf_sample - 1) : (next_index - 1);
> +	start_index = (next_index == 0) ? 0 : next_index;

This is just next_index.


> +
> +	time_last  = prange->page_fault_data[last_index].ktime;
> +	time_first = prange->page_fault_data[start_index].ktime;
> +
> +	time_interval = ktime_to_ns(ktime_sub(time_last, time_first));
> +
> +	/* should not happend as ktime_get is monotonically increasing */
> +	if (time_interval < 0) {
> +		pr_warn("Negative time difference detected\n");
> +		return  0;
> +	}
> +
> +	/* page fault is very intensive, had NUM_PF_SAMPLE page faults
> +	 * in less 1 nanosecond, treat that as 1 nanosecond
> +	 */
> +	if (time_interval == 0)
> +		time_interval = 1;
> +
> +	/* check migration data rate first*/
> +	if (total_migration_amount * NSEC_PER_SEC >
> +		data_migrate_rate_threshold * time_interval) {
> +
> +		/* check if there is a significant device */
> +		for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
> +			if (migration_amount_device[i] > total_migration_amount / 2) {
> +				*hot_device = i;
> +				break;
> +			}
> +		}
> +
> +		ret = true;
> +
> +	} else if (total_remote_amount * NSEC_PER_SEC >
> +		data_migrate_rate_threshold * time_interval) {
> +
> +		for (i = 0; i <= MAX_GPU_INSTANCE; i++) {
> +			if (migration_amount_device[i] > total_migration_amount / 2) {

Did you mean to check remote_amount_device and total_remote_amount here?

I'm not sure why you're treating those separately anyway. I'm trying to 
imagine what will happen. E.g. device 1 has a lot of page faults, 
migrates data and becomes the hot_device. Now device 2 has starts having 
lots of page faults. Because it's not hot and below the threshold at 
first, it is not migrating and is counted in remote_amount. As long as 
device 1 keeps faulting enough that it stays above the threshold, device 
2 will keep accessing data remotely, even if its rate of page faults is 
much higher than device 1. Eventually it becomes hot and starts 
migrating. Now device 1 experiences lots of page faults and so the cycle 
repeats.

I think with this logic, you're replacing thrashing with "sloshing". 
Maybe you could call that an improvement, but it's far from ideal.


> +				*hot_device = i;
> +				break;
> +			}
> +		}
> +
> +		ret = true;
> +	}
> +
> +	return ret;
>   }
>   
>   /**
> @@ -932,6 +1114,7 @@ svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
>    */
>   static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   {
> +	unsigned long migration_amount_pages = 0;
>   	unsigned long start, last, size;
>   	unsigned long addr = vmf->address;
>   	struct svm_range_bo *svm_bo;
> @@ -989,10 +1172,21 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	last = min(ALIGN(addr + 1, size) - 1, prange->last);
>   
>   	r = svm_migrate_vram_to_ram(prange, vmf->vma->vm_mm, start, last,
> -				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page);
> +				    KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU, vmf->page,
> +				    &migration_amount_pages);
> +
>   	if (r)
>   		pr_debug("failed %d migrate svms 0x%p range 0x%p [0x%lx 0x%lx]\n",
>   			r, prange->svms, prange, start, last);
> +	else {

The braces are not needed here.


> +		/* When cpu page fault happen always migrate data to sys ram
> +		 * cpu cannot access device ram remotely, record page fault data
> +		 * migration amount is in 2MB unit, migration_amount_pages is
> +		 * in page. If it is smaller than 2MB, choose 2MB
> +		 */
> +		update_pf_migration_data(prange, CPU_DEVICE, true,
> +					ALIGN(migration_amount_pages, 1UL << 9) >> 9);
> +	}
>   
>   out_unlock_prange:
>   	mutex_unlock(&prange->migrate_mutex);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 2eebf67f9c2c..160d4c1bd07f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -42,15 +42,23 @@ enum MIGRATION_COPY_DIR {
>   
>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
>   			unsigned long start, unsigned long last,
> -			struct mm_struct *mm, uint32_t trigger);
> +			struct mm_struct *mm, uint32_t trigger,
> +			unsigned long *migration_amount);
>   
>   int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   			    unsigned long start, unsigned long last,
> -			    uint32_t trigger, struct page *fault_page);
> +			    uint32_t trigger, struct page *fault_page,
> +			    unsigned long *migration_amount);
>   
>   unsigned long
>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>   
> +void update_pf_migration_data(struct svm_range *prange, int32_t pf_src,
> +			       bool migration_or_remote, unsigned long migration_amount);
> +
> +bool processing_pf_migration_data(struct svm_range *prange,
> +				   uint32_t *hot_device);
> +
>   #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
>   
>   #endif /* KFD_MIGRATE_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 521c14c7a789..c2843836661e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -63,6 +63,8 @@
>    */
>   static uint64_t max_svm_range_pages;
>   
> +extern uint32_t num_pf_sample;
> +
>   struct criu_svm_metadata {
>   	struct list_head list;
>   	struct kfd_criu_svm_range_priv_data data;
> @@ -303,6 +305,9 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
>   		}
>   	}
>   
> +	kvfree(prange->page_fault_data);
> +	prange->page_fault_data = NULL;
> +
>   	mutex_destroy(&prange->lock);
>   	mutex_destroy(&prange->migrate_mutex);
>   	kfree(prange);
> @@ -355,6 +360,14 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
>   	mutex_init(&prange->migrate_mutex);
>   	mutex_init(&prange->lock);
>   
> +	prange->pf_data_index = 0;
> +	prange->page_fault_data = kvmalloc_array(num_pf_sample,
> +						 sizeof(struct svm_pf_info), GFP_KERNEL);
> +	for (int i = 0; i < num_pf_sample; i++) {
> +		prange->page_fault_data[i].ktime = 0;
> +		prange->page_fault_data[i].migration_info = 0 | INVALID_COMPUTE_DEVICE;

This is just INVALID_COMPUTE_DEVICE.


> +	}
> +
>   	if (p->xnack_enabled)
>   		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>   			    MAX_GPU_INSTANCE);
> @@ -1068,9 +1081,27 @@ svm_range_split_adjust(struct svm_range *new, struct svm_range *old,
>   			return r;
>   	}
>   
> +	for (int i = 0; i < num_pf_sample; i++) {
> +		uint16_t old_amount =
> +			MIGRATIOM_AMOUNT(old->page_fault_data[i].migration_info);
> +		unsigned long temp = (new->last - new->start + 1) * old_amount;
> +		uint16_t new_amount = temp / (old->last - old->start + 1);
> +
> +		/* proportionally devide data amount betwee new and old pranges */
> +		new->page_fault_data[i].migration_info =
> +			(new->page_fault_data[i].migration_info & (~0xffff)) | new_amount;
> +
> +		old->page_fault_data[i].migration_info =
> +			(old->page_fault_data[i].migration_info & (~0xffff)) |
> +			(old_amount - new_amount);
> +
> +		new->page_fault_data[i].ktime = old->page_fault_data[i].ktime;
> +	}
> +
>   	old->npages = last - start + 1;
>   	old->start = start;
>   	old->last = last;
> +	new->pf_data_index = old->pf_data_index;
>   	new->flags = old->flags;
>   	new->preferred_loc = old->preferred_loc;
>   	new->prefetch_loc = old->prefetch_loc;
> @@ -2973,6 +3004,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint32_t vmid, uint32_t node_id,
>   			uint64_t addr, uint64_t ts, bool write_fault)
>   {
> +	unsigned long migration_amount_pages;
> +	bool migration_or_remote_high;
>   	unsigned long start, last, size;
>   	struct mm_struct *mm = NULL;
>   	struct svm_range_list *svms;
> @@ -2985,6 +3018,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
>   	bool migration = false;
> +	uint32_t hot_device;
>   	int r = 0;
>   
>   	if (!KFD_IS_SVM_API_SUPPORTED(adev)) {
> @@ -3135,33 +3169,103 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	size = 1UL << prange->granularity;
>   	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
>   	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
> -	if (prange->actual_loc != 0 || best_loc != 0) {
> -		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, start, last,
> -					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
> +
> +	/* check previous page fault data to decide how to migrate data */
> +	hot_device = INVALID_COMPUTE_DEVICE;
> +	migration_or_remote_high =
> +			processing_pf_migration_data(prange, &hot_device);
> +
> +	/* migrated or remote accessing data rate is not high
> +	 * use automatic migration scheme
> +	 */
> +	if (!migration_or_remote_high) {
> +		migration_amount_pages = 0;
> +
> +		if (prange->actual_loc != 0 || best_loc != 0) {
> +
> +			if (best_loc) {
> +				r = svm_migrate_to_vram(prange, best_loc, start, last,
> +						mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> +						&migration_amount_pages);
> +				if (r) {
> +					pr_debug("svm_migrate_to_vram failed (%d) at %llx,"
> +						" falling back to system memory\n",
> +						 r, addr);
> +					/* Fallback to system memory if migration to
> +					 * VRAM failed
> +					 */
> +					if (prange->actual_loc && prange->actual_loc != best_loc)
> +						r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +							KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
> +					else
> +						r = 0;
> +				}
> +
> +			} else {
> +				r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL,
> +						&migration_amount_pages);
> +			}
>   			if (r) {
> -				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
> -					 r, addr);
> -				/* Fallback to system memory if migration to
> -				 * VRAM failed
> +				pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> +					 r, svms, start, last);
> +				goto out_migrate_fail;
> +			} else {
> +				migration = true;
> +				/* migration amount is in 2MB unit.
> +				 * if it is smaller than 2MB, use 2MB.
>   				 */
> -				if (prange->actual_loc && prange->actual_loc != best_loc)
> -					r = svm_migrate_vram_to_ram(prange, mm, start, last,
> -						KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
> -				else
> -					r = 0;
> +				update_pf_migration_data(prange, gpuidx, true,
> +							ALIGN(migration_amount_pages, 1UL << 9) >> 9);
>   			}
> -		} else {
> -			r = svm_migrate_vram_to_ram(prange, mm, start, last,
> -					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL);
>   		}
> +	} else if (hot_device == INVALID_COMPUTE_DEVICE) {
> +		migration = false;
> +		/* there is no significant device, use AIP */
> +		/* no data migration for page recovery
> +		 * the gpu(gpuidx) will access data remotely after map
> +		 * count data amount that this gpu remotely access
> +		 */
> +		update_pf_migration_data(prange, gpuidx, false,
> +					 ALIGN((last - start + 1), 1UL << 9) >> 9);
> +
> +	} else if (gpuidx == hot_device) {
> +		/* gpuidx(where page fault happened) is same as hot_device
> +		 * move data to gpuidx gpu by svm_migrate_to_vram
> +		 * it either moves prange to system ram, then 2MB to gpuidx
> +		 * or move 2MB from sys ram to gpuidx vram
> +		 */
> +		r = svm_migrate_to_vram(prange, gpuid, start, last,
> +					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU,
> +					&migration_amount_pages);
> +		if (r) {
> +			pr_debug("svm_migrate_to_vram failed (%d) at %llx, "
> +				"falling back to system memory\n",
> +					r, addr);
> +			/* Fallback to system memory if migration to
> +			 * VRAM failed
> +			 */
> +			if (prange->actual_loc && prange->actual_loc != gpuidx)
> +				r = svm_migrate_vram_to_ram(prange, mm, start, last,
> +							   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU, NULL, NULL);
> +				else
> +					r = 0;
> +		} else
> +			update_pf_migration_data(prange, gpuidx, true,
> +				ALIGN(migration_amount_pages, 1UL << 9) >> 9);

This looks like you duplicated a lot of migration and error handling 
code for different cases. It would be cleaner if you took the hot_device 
into account in svm_range_best_restore_location. Then the code that does 
the actual migration wouldn't need to change at all (other than adding 
calls to update_pf_migration_data).

You're also currently not considering whether the faulting GPU can 
remotely access the memory in question. svm_range_best_restore_location 
does consider this in its choice of the best location. Therefore I 
believe svm_range_best_restore_location is the right place for your 
policy logic for changing migration decisions based on the migration rates.


> +
>   		if (r) {
>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> -				 r, svms, start, last);
> +						 r, svms, start, last);
>   			goto out_migrate_fail;
> -		} else {
> +		} else
>   			migration = true;
> -		}
> +
> +	} else {
> +		/* gpu gpuidx is not hot device, have it access data remotely */
> +		update_pf_migration_data(prange, gpuidx, false,
> +					 ALIGN((last - start + 1), 1UL << 9) >> 9);
> +		migration = false;
>   	}
>   
>   	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
> @@ -3535,14 +3639,16 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   		return 0;
>   
>   	if (!best_loc) {
> +		/* not count migration amount for prefetch */
>   		r = svm_migrate_vram_to_ram(prange, mm, prange->start, prange->last,
> -					KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
> +					KFD_MIGRATE_TRIGGER_PREFETCH, NULL, NULL);
>   		*migrated = !r;
>   		return r;
>   	}
>   
> +	/* not count migration amount for prefetch */
>   	r = svm_migrate_to_vram(prange, best_loc, prange->start, prange->last,
> -				mm, KFD_MIGRATE_TRIGGER_PREFETCH);
> +				mm, KFD_MIGRATE_TRIGGER_PREFETCH, NULL);
>   	*migrated = !r;
>   
>   	return 0;
> @@ -3599,9 +3705,10 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   			/* migrate all vram pages in this prange to sys ram
>   			 * after that prange->actual_loc should be zero
>   			 */
> +			/* not count migration amount for eviction now */
>   			r = svm_migrate_vram_to_ram(prange, mm,
>   					prange->start, prange->last,
> -					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL);
> +					KFD_MIGRATE_TRIGGER_TTM_EVICTION, NULL, NULL);
>   		} while (!r && prange->actual_loc && --retries);
>   
>   		if (!r && prange->actual_loc)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 01c7a4877904..5e6f07eba0c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -39,6 +39,31 @@
>   #define SVM_ADEV_PGMAP_OWNER(adev)\
>   			((adev)->hive ? (void *)(adev)->hive : (void *)(adev))
>   
> +/* indicator for cpu device */
> +#define CPU_DEVICE 0xFF
> +
> +/* indicator for invalid device */
> +#define INVALID_COMPUTE_DEVICE (1 << 30)
> +
> +#define GETMASK32(h, l) ((((uint32_t)(~0)) << (l)) & ((uint32_t)(~0) >> (32 - 1 - (h))))
> +
> +#define MIGRATIOM_OR_MAP(migration_info) (((migration_info) & GETMASK32(31, 31)) >> 31)
> +#define PF_DEVICE(migration_info) (((migration_info) & GETMASK32(23, 16)) >> 16)
> +#define MIGRATIOM_AMOUNT(migration_info) ((migration_info) & GETMASK32(15, 0))

This use of GET_MASK is not helping readability. It took me two minutes 
to figure out what this was doing. It's much more obvious and readable 
to just spell out your masks in hexadecimal. If you do the shift before 
the AND mask, it's even easier:

#define MIGRATION_OR_MAP(migration_info) (((migration_info) >> 31) & 0x1)
#define PF_DEVICE(migration_info) (((migration_info) >> 16) & 0xff)
#define MIGRATION_AMOUNT(migration_info) ((migration_info) & 0xffff)

Also, some typos: MIGRATIOM->MIGRATION.


> +
> +#define MIGRATIOM_INFO(flag, device, amount) (((flag) << 31) | ((device) << 16) | (amount))
> +
> +struct svm_pf_info {
> +	/* kernel time when page fault happen */
> +	ktime_t ktime;
> +	/* enclosing info:
> +	 * 1: data manipulation for page fault recovery: local or remote access
> +	 * 2: device where page fault happened, use 0xff for cpu
> +	 * 3: data amount involved
> +	 */
> +	uint32_t migration_info;

Since ktime is 64-bit, the structure size will get aligned to 64-bit 
anyway. So you may as well make the migration info 64-bit and give 
yourself more space. To simplify access to the fields, you could also 
define the elements as separate fields in the struct.


> +};
> +
>   struct svm_range_bo {
>   	struct amdgpu_bo		*bo;
>   	struct kref			kref;
> @@ -138,6 +163,11 @@ struct svm_range {
>   	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
>   	bool				mapped_to_gpu;
>   	atomic_t			queue_refcount;
> +	struct svm_pf_info *page_fault_data;
> +	/* most significant bit indicates if page_fault_data is full
> +	 * so the max size of page_fault_data is 127
> +	 */
> +	uint8_t pf_data_index;
>   };
>   
>   static inline void svm_range_lock(struct svm_range *prange)
