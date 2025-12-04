Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95F6D2168E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 15:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5366310E8A8;
	Thu,  4 Dec 2025 15:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w66Eoowj";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013058.outbound.protection.outlook.com
 [40.93.196.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CA7A10E1FF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 15:10:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYd/FmuX1WUzigoGhe7LXU1ouKvLpe5gAEifaI9DWBDnPNYhEuAkkcie3LzfNOEMOxZMj4/pb+QKHy0iFmch9WgqQdX638SgtMQdZR/aQFqXo9X35HBwQbx68ztJr+gaNbw0H6K7JMk3e9mNIl8euu77neKJ16Utf/qvzm14PX6kI8H8QUpv2k74lO3H79GSn+ZpKak4Adox31mZXf4wHRVR6A1awFCvzORM3L51DZRIPEWFkStqS/YgKBj39B3aqVBnitsH0OaHo/0ekVD1yyW4Q2XwkgZCL+E7yvJw1FyUmV6nbsDThnEbeurJQgtdHrS5cipEYZQp4sKfyxhZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6ypSYwmDIYP2sPXEuSPwgJAST7MhnqFdHnB1ZIBAgU=;
 b=EAxVeODL1ST9x/9J0wtPki4owrew5UfuFbldRAjR7rn2nzIGDrCwA5JQnJEfnGtKeIi6KdJvKKq3VK6Ypbt3xU+92C93qc1ycu01+M2igPijm3GACzpdUDzFq5qfdpsuLkn3GazsUHtfTVvuPJlSCqLRhb2GPjtSKtFQMmUUKsvCa+OPPK0IIokfT+0QRSJsh+UrBVIgsTgnirTbOVtfJ+kneXUSAig+dJf46nyjvuvDQPESiNYrJybEwUBJAadl+j8rdWLO15/HSwXKYUCJQXfh7USQOm/Hz3nWEAsgGAS4LhxG0LtRBkztZVcdgsF31Eh4xpxJH36tuvoACh66lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6ypSYwmDIYP2sPXEuSPwgJAST7MhnqFdHnB1ZIBAgU=;
 b=w66EoowjjKRNgoz3BqmrrFLh/HCsQBDD96ZRYOunI48LUm8C5IP5KIlyV1Cdl6rkRheKnTiO6Eb/5ix2azg6ybAYfJB5D/NRBzob2mI6jlcko1fjVRjIRibo7uKPaIejM3H97JZNh/Xh3rYCa8UgUAx3JT94ka9QvXI35y80w5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 15:10:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 15:10:52 +0000
Message-ID: <148415b0-ce15-4d20-b375-8a30e4ce2396@amd.com>
Date: Thu, 4 Dec 2025 10:10:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] drm/amdkfd: Bind gfx9 MQD in GART with mtype RW
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-2-Philip.Yang@amd.com>
 <026f82e1-be99-4a16-bf3f-dd6950c15cc7@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <026f82e1-be99-4a16-bf3f-dd6950c15cc7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::29) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: b372dcdf-c458-4a98-000d-08de334750b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNJSUxuL0pGYWxqa2NoUWgxeXU2MDR3Ylh2cFR0VDRhbTl2ZkFlenl2Mlda?=
 =?utf-8?B?ZTM4OXpGUGc3bXhRb3g3SElWZWtYVTZDTE9CMnY4ZkJFYnBOK3JReEF5UjJL?=
 =?utf-8?B?dnF0T0ZrN1lFdmp2TU4yR1hQYndDWngyK0R4dTNWREU2SzlQTkpKZWNMOXMw?=
 =?utf-8?B?NS82eHpwRnZ1bkgvLzllT3RFZnhiWDIrckpVRGh3ck1tdUhWU0dhN3RhZTRV?=
 =?utf-8?B?N3RZK2xNbzMzYWF6Tjg0UFUvZmFseHdtTDlsU3JUSVJXWGxuZ1RlelJvNXk5?=
 =?utf-8?B?bGIrd25aQnJhYkk4WkdiRUVWbmdNK2JUSmtyM1NuTmhiSk9raHpvNW5ReENN?=
 =?utf-8?B?c1MrRWxlNVluTWhFalVDZ0FYelpJK0huUHRBL2NyaDhwamZrbGhIYXFIWlgz?=
 =?utf-8?B?M3U3TEFVRGVBS3JXSHcxM2xtTTYzWlRpbGhLSU95czRsMkx6UzJpYkxUeXp5?=
 =?utf-8?B?NEJxcW16OEplTkM5ZlBEdlZFay9xS0RDREZvVEkxcU1sQU1HaU93Um9TK2Nh?=
 =?utf-8?B?UWNoR2JjQ2dtUFVBSlJVcGwveVp5bkNtQVNWVzZRY2kzNzVDYzI5emZHa3hT?=
 =?utf-8?B?SDhwN1JNbVNJd0RHcnJydzNQTzJTU1ZyQVMxcTRRUVVqLzJ2T3BkOUlocnd3?=
 =?utf-8?B?cGt4eTVRbTVSQ3JDSkFadmwvRm1JdnJyY1BPSk5LT2xld0Nvdkd4UUJ1ZkRk?=
 =?utf-8?B?SWtHaWxFOXNERGNwdmpPWG4vNG11MnNQNXpMalBud2U0dkxUSVVSMUpIWVVX?=
 =?utf-8?B?NURHRHU4eFBnb0ZwS3hGQlRRb3NmRGU3NzdZNkdIM3JZY2ZNcjR0TmdrK2x5?=
 =?utf-8?B?bUJQdnlxY1FOOG1NeWp4OThyYlV5ZWdCaExPd3Fad1ZKaUZUazNMc1htVEhE?=
 =?utf-8?B?bGZVQ0VyNnJ3aVExMFJLQUdlUlVlZTJaTVk4MVJCakR0OGo0Q0lKbDNHaEV2?=
 =?utf-8?B?NmRJVWc0WHJJdW12dWtvSS9pRCt6N3pJVGRGdzdNdWRkR3BiSE8rVmY4WkUy?=
 =?utf-8?B?WDhBN2hMTy8vYjhQUWxNaWpnUU5vOVF4dHJWcXJkWjRnZytUZ2VnOHFlV1Ey?=
 =?utf-8?B?T1BIczIwMXdOYTJkUmYzTEhKT2wxT0RkTzV4Y0RPdzBNVkJKNkdNc1E3OXlH?=
 =?utf-8?B?T1dhbjh5eGljeUttK2pwU3JCZTVVWit1dml6ZHJQK2pIVStOUGRzRXZUYlVC?=
 =?utf-8?B?NzZOVEU4ektpS21DREV5bUtVN2JHeU5YRjd2dERtbmpUbmFYaVZiTEtIYm1G?=
 =?utf-8?B?RkczZWpKY3JtcDVpK29tMFIxaThuUmpNdHB1MWY0ODMzNmlSbU1UMjhXajY4?=
 =?utf-8?B?ajlSdkpMeXUwSUFsaFZLcWdnbFdTRzI0dHVNQzVTeEd1alB0OEpDMGdhTzBY?=
 =?utf-8?B?dndrL3hoNDV1bmp3R2RCeVBxOXVoK0QrYzFpTTkrdVJCYVJJU2UwL0lpUG9I?=
 =?utf-8?B?TjM4Ny9PbUlOQW5CY2ZsR1hkQzZOcHFtOE5JUGVFZ0tHQS9BdXdscVFFOXJi?=
 =?utf-8?B?a1oyNnhVM0g0RFJjeGliTVNQQ0xROGM0OWQ3V09zNnkwaDRRbjJ6TWxid2xt?=
 =?utf-8?B?ZE8vSXhpRzRHaFZ4QW5heVRRSkVoQy9rdHViQVpOWXJEUXR1bjlLeWNaRlhv?=
 =?utf-8?B?RDlhK2RNbGdmd0NuTitVNGl4dHd5R3RmMzZsNVE0cUtlUjV3M0JJWkhvaWxz?=
 =?utf-8?B?MThYSWZqUXljZHZzYkx5ZzFhY2dLNjN2eGJRWnphclRoNE01S25mRytXTWFP?=
 =?utf-8?B?Q25hUEk1YXd6OGV2MFVlMC9Ib0hULy9rSHk4cWJiRlFiYlh1ZDJTcVBKV0h3?=
 =?utf-8?B?WDNWOTVCejdUbjBTTkNOc2RxY2tnbnZOeVJML3M4ZHEvbGVtZFFyM2Z2bStU?=
 =?utf-8?B?ekNuYiszK1FKUC9qNFV2N2puS1JhRVM4ODc5RC96RkpuRnVFa05wekNnaG1r?=
 =?utf-8?Q?+9h76aSbT7J9EMG6qCb3v8ocL6bCvFsu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek1FMW0rYTBHOTNWUjFFZWJnSG1NTnlLOEdWNmlyN2ZQbTY5MHpZUlVuck9v?=
 =?utf-8?B?eXltaXJyYkxYenJwK3FpeCsza0pvMng4bHBmYWIrd1dyeWlqL3NzSGxlRW83?=
 =?utf-8?B?L1RBNDFHRnRWeUtDWWJ2Zk5ZL1dibW9YWE41QTQvVEVTdkNuMHVaR2hLcEt4?=
 =?utf-8?B?U0JncTZqVUwvNk9RQTFyYTV0ejdmblBWc3E1Mjk1ckR3WURPaTdUa2VsS3kz?=
 =?utf-8?B?aC9pOHhOQzM4L2JUYldxUG1QTEp0YUZuM0R1SDF4QUZUQmNOTTlMaEo5SXVS?=
 =?utf-8?B?RkhkaU13K3VveEd3OS9TUVJIZkx6VE56S1pDM1NVcjluVFAwSlF1RERHaGhB?=
 =?utf-8?B?N3drNG1ndWE0QlVCMlYwUzFOaTdmaCtHcmlXTTVWcnkrNWgyaTdML29MSDQ1?=
 =?utf-8?B?dlEreEs2Vkh2WndQbkdQMkdDd2ZQQ2YvM29PQXJOamNNKzhnWk55YVI0WG9M?=
 =?utf-8?B?Y3ZPb2IwTWRJZ29aVXFJMHBBNGRFbzBaVG1XUmpFMWt3N3AzeEg0aFhUOE5J?=
 =?utf-8?B?dFN2Qkc1Tm9EeXFjYllaWEhUd3NYUnFDK3R6MVpad3Bpa2Y4eEN6ZGl4Q2RG?=
 =?utf-8?B?TEVYcTRLQWFUZTRGS0pSdklUWGxlNnpuZHRRUWhnRlMxUjlQRFNBamMxNnRU?=
 =?utf-8?B?SjE1QVFLdUhKVkYrcWIxWWlZWFREQjE1V3hzOTF2ZitWQXJ3MTdNV1pWbDhM?=
 =?utf-8?B?RlMreTZxT0xzUlEyMkFKRG9XMG04VEpFL2w0RVRXamxTWjZmemJlZ2JWQklW?=
 =?utf-8?B?ZXA4eDBtLzQraUVOdUJXdzNQVkNERzFhMzkrZzhGS05xQkpUU3hudFZrOUVy?=
 =?utf-8?B?UlB4MXNyd1pGY0dLTEd1TnlKQzVzQTRSQjNGc3d3UVhDNUYvMm9UUnliUHB3?=
 =?utf-8?B?alFkZ3JablpweVZOU3pHcy9SMURWMlA4cDMxbW03cEZ2dUp4bkNWU2RpZ2o3?=
 =?utf-8?B?MnRhd0xSV1BmNGV5cjB2VmtLUGZQNkd4VWhNZXBBbE96WVZQYm9zQ0dBUVZX?=
 =?utf-8?B?OFNKMWtCaHF5bkM2bzZvaEk0TFVwZDQ3RS9UMUVkR0ZVVURvNWZSLzVqMUlq?=
 =?utf-8?B?cEFOWitDT25rUmFkQUNNcEorKzdnSlBZendhRHlOTk5JZXlWR2FuSk1Gb3lw?=
 =?utf-8?B?SXFua2UvMWE5UmNVejlHTGR6MS9hTU5BVXErVG83YXlwbUdrK29ybm1OT3M1?=
 =?utf-8?B?WUVRSlNVcm1FT3NiZUI1UDRtSXhPaFdiNjRoRXVyM004KzE2c3VtUFBFTkZl?=
 =?utf-8?B?aUZxakRCODNSVTdmSHBZUWVZOWNrU1ZncTA0TjNXckh1dFExcUNsOUxsbmpO?=
 =?utf-8?B?VTMvT3JMK290c1pMZjFVU3NkYVVJdmZKcWNiaUNMbCtWSlFnSjh1LzloU3I0?=
 =?utf-8?B?RmQyTnZRMzlyTlRJV1g3Q0ZoTTNkZXY3OFlINTVKS0NaZVVZbDZvSXgrZzZC?=
 =?utf-8?B?SjZUL0pOMjZzVjgzUkJnNXFVcFZtSXFHTVJCeFZrNlJ0WEtyYnJTUE1JQ3Z3?=
 =?utf-8?B?YldoOHJRdlc2MkRybkxLWmdLdlRzMFkzVUxBSXhLVzdyOFVuamlqbU56ZFFC?=
 =?utf-8?B?V0FvdVlWMis1eUhBUDNkTFV4ZEt0c2ZzcHRzL21OSWhQRmk1VUR6WWxBbVl0?=
 =?utf-8?B?VFR4MFgzNUNodTlXa3J4Nm5yTHU0Z1dYN095SkR5RndQV3ZpQVRsYjdJa1k3?=
 =?utf-8?B?dnJRNEwwaFF4c2hJL2VrL0tvQjllRkdnVUhWQlZDOWhqLzlXVUd6T3FmeUEz?=
 =?utf-8?B?YVQ3MHBzOWYvU3owdWFkdUs0djluaVM0Zlgwa3RBQWJ0L0pONmtQTVE2QVl0?=
 =?utf-8?B?MTBGK1YwMWRESEtxVjVrd0c1TmVsZTVBa1BHbEUwOFUrQTNFbFZYYWlBSHV2?=
 =?utf-8?B?RVk2UnBZZG1QbEx5OWlNRnI4dUJOZFVkZzF5OGkvdEJ6am5Cb3h6emxQc1My?=
 =?utf-8?B?cmJGSlB3RlNqM3Jta3h2ZXVBeFJYeDlPN1Uwa3YvdUdJR2xYY0Myelhtenl3?=
 =?utf-8?B?ZTJGUDhXeUVoaEF4YnpSc1BEUlZBMEVWVkZtdDlQWjdHLzFLNUdsSFV2ZGRw?=
 =?utf-8?B?WFA0SmovOHlRMWozL2U1bFhXczVTNkk1QnBVeFJFQnFBRm9ZZEk0RXIwbllj?=
 =?utf-8?Q?1FBP3Mp4XQWK7JpjWKiAIG8Zf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b372dcdf-c458-4a98-000d-08de334750b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:10:52.4733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D9lj405N8QH9l6hL2rnVgXF8k3/2MnsTsIH99iDBcDRd/CjnrkLoAi2hmPJgyiM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4198
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



On 2025-12-03 12:40, Kuehling, Felix wrote:
> On 2025-12-01 09:28, Philip Yang wrote:
>> For gfx9, bind MQD in GART with mtype RW to enable caching, to
>> reduce queue switch latency.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 1 +
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e553cf411191..5f58cff2c28b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -841,6 +841,8 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct 
>> amdgpu_device *adev,
>>       int i;
>>       uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, 
>> AMDGPU_MTYPE_NC);
>>   +    flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_RW);
>> +
>>       pages_per_xcc = total_pages;
>>       do_div(pages_per_xcc, num_xcc);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 139642eacdd0..4dd15767a722 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -101,6 +101,7 @@ struct amdgpu_bo_vm;
>>         AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
>>     #define AMDGPU_MTYPE_NC 0
>> +#define AMDGPU_MTYPE_RW 1
>
> This is probably not the right place to define this. MTYPE_RW is not 
> universally available on all our GPUs. Not even on all GFX9 GPUs. This 
> MTYPE definition needs to be in an ASIC-specific header file, and 
> probably already exists somewhere.
>
> Also, we can't use MTYPE_RW on GPUs that don't support it. I believe 
> it was added in MI300.
Thanks, this is available for gfxv >= 9.4.1, will drop this patch and 
setup mtype before calling amdgpu_ttm_gart_bind.

Philip
>
> Regards,
>   Felix
>
>
>>   #define AMDGPU_MTYPE_CC 2
>>     #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \

