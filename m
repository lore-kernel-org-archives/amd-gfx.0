Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E2FC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 13:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9579910E996;
	Fri, 26 Jul 2024 13:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2CfDgS5K";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790D010E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 13:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ntm6ZQOSdHg/hgN3MjIN5VNF3vNVJKMWLnHjKd2X05IBGyOtX3vhDzaKuEVWdctZ9lFYvsfTGNb0vGS5MztHG1tRoT4U0tZ1J+gAKkY0wPqMboVza3HiKHB6qaxMssEvFwL9pblqGncYf7MK6CGpxv9ffXZQoKmG3c9AMRTWMWYlY1R3IlX0jDbRkUrE35sMXjcbQCH9IGypSAiQFTl+uyW+yvx66OiAnBEI28e0JeKWc/0Z6xA2DqwK61DQqrbt0zb9X8vEHKBGXRs6dPgGcwEe3kUQNVttax1vX4qW8fjIaJA/VwZT5yafiXCTuXLGu6/FnDFG/ZM1zkas2IQhUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pfaaFJ5r//3z7Utw00DuQ5JvAnsv4YmMXLkkp9K4TM=;
 b=g5KMuhtADFDK2vvzgCnsGMtOEXij2Hzny7NkYZDOPTRQVHWe7qfWRw0jMsPcVCeHuKvDUzasp/P6QwnDSB16cs7LdmIENvuXqiM0tULGtMjUnc+95bnVySiL+DLILdIXRwMtH2Chyv3sFZRBePUgqjwYttFiBF2/ZflbI9y3N3RPFuL0xgJxqQAMAu+7ozOOQOIJ6+ByN0Ei4J1EKLq4re0U5ZMlkjouf0tLYfVwWieZFNY6anNyLrlcNXXCUmL59TyzrWu30hYNWUE4dCbHEX1GTKntVP9dlVxYgsY1KL9xDwuzIDA4zPGiFDb/PndiziZkWVhvfGsUkxMoNMyEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pfaaFJ5r//3z7Utw00DuQ5JvAnsv4YmMXLkkp9K4TM=;
 b=2CfDgS5KHH5OAjDlUOPfNDMMIEe73HQBtjfdIuEmTlL2TWf8Q6lBTLRjL70vYpl4sBqx/mTHIpj5p9ymt/AJF7dOnX59tTtbCb2mAgPUjZK77KXYcJAEgBVV2gm+kCQCI/7IVvjvO0wIh/73w+E/C0Z4/UerzElOZ4DVq7IgRa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Fri, 26 Jul
 2024 13:48:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 13:48:58 +0000
Message-ID: <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
Date: Fri, 26 Jul 2024 19:18:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::31) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 88a95c17-c4be-4715-bf23-08dcad79b2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtVdVJJdmNKdkhaYjNtUmVxY0h2emVWNVM3UmtocjIxZ005TVA2VXF3cWYv?=
 =?utf-8?B?UENKT0NZU0QrdC9kMGxVVGpjRENyVkxBVFVRbUJNQ0VQTElaWFQvQjc3c0VY?=
 =?utf-8?B?OExmUU1xYWhDdTlNa0djVzE0VSsvajBUOTYyTmsvb1RyNzdReGJ6UFVRVEwx?=
 =?utf-8?B?djhNYmM5dmZpMy9xS3Q0cHdLallRRXJ4L0U1V2JvT2M5TStpYTFpY2lYUnhG?=
 =?utf-8?B?a003aWdJbjdxUHBLdXZ4MjNTdG93RGlDdFJoVjN1bzZyWU5Gand1cTY2LzZI?=
 =?utf-8?B?dGdXRytLNldodVBWOExKem50V0VZTTd2QnNrOTRqMHRpSlJRWi84V2hpUVU3?=
 =?utf-8?B?Z0RhOUdML3FjYVF0RDUxZXkrcWVSY1VEYXgvMXJYcVVWT05XMkN1TzlSSG5S?=
 =?utf-8?B?TmsvMS9wTTUxZFFJMkJaR0ZXckN0NldVcmE3RDZzZ0xPTTJ5Wk15ckZwaTE3?=
 =?utf-8?B?dXkwdWFwY29RTkIvT0VoZi9zVGxpU3hQSXRjckYvbTh6eVNRSmhFbGxVelFy?=
 =?utf-8?B?d2pnbTFFc04xcm9xK25hWXB3QnZsRUpRTFlaeUFHcHM0cEgxaStxN3lMSkM4?=
 =?utf-8?B?cDRLSnFSbkpETzFseWw5d2c0bkdVNDcreTJBZmJkazEvWGZUMzBWVkptbkpG?=
 =?utf-8?B?Yk5ycE1qQlRVOENTSFJLU1NCeC9UTTFZWk05eFdCUXhnWUhkWjVDMEZ2aHll?=
 =?utf-8?B?N2NRUDlvbFBRazJMYU4zbUt6ZDNtTXFHVmRsZ29ibmRUTU1ITlNOWlh0RmFh?=
 =?utf-8?B?TEQyTlVrWlpWelBpaUl6L3VRMGRsOWxiSks0SmF5ZnQzMWMrSHV2SDZKajZY?=
 =?utf-8?B?RFJycFRwVnNqT0dZbi9PK0tOMWdUOUk1Y3JGK1JGRXdVZ1h0dWZ2SlhPQ1h2?=
 =?utf-8?B?b1FkaWphL09jMFVLTnlyUkRwckwwUTRGM0o3TnZSU21uYXJvOEl0VEtiaDZH?=
 =?utf-8?B?dVhwSWQzQlRNNkFremZzWjdEK1ExK1EvQ0E1b3RYcU1adGxLcGZ6elJpWGY3?=
 =?utf-8?B?ak13RmthNldrcVZ1RXlBSHFaSGY0Y2c0bytyUmYyRXJKRUl2V1VkaWVHZVNF?=
 =?utf-8?B?Y2p6SE83YWh4bnpwSVZPZmRMclpWNWt5N3haekZNenZ6N0xCaW5DdnN1T2FG?=
 =?utf-8?B?Y2ZmTmVoWlJLRUZrb093akQ2U0FrT0FrdHB4cGVGMTJmNEJRSXhuaGZMNWZG?=
 =?utf-8?B?ZWhROTg3TnRWbEdHTlpGbnorb0FwNGJPeFFNWVkxS3NqTmo4dis3UmUwUUov?=
 =?utf-8?B?TmVORDg3bFBIU1g1ZWYyZ2ZGR1hHZ01ueG14cERmQTVLa2hNTjJ3NzVCNFFE?=
 =?utf-8?B?NTVJTTlqcGY5aHVERjdQdThaeENTeWVIRmhwRCtzSjl2MjJwbXFaclZxK3l0?=
 =?utf-8?B?N21tR1lpRmJ6WUhJaXMxYTZ2NnFSQjNjckh6aGRBMHh3REQ3R0pOK0l4OEpI?=
 =?utf-8?B?U1ZNMjRaN205MnVTczhmTDkvc292WTlMQTdJUzE3T1BoWlA1NEhnZk5ZcEt3?=
 =?utf-8?B?SXpmaWV4TXhtb3lDRjVBTG1NL0p1MUwvMkk4RFRJcThpVjRpUG5BSVJwT1Ex?=
 =?utf-8?B?c1hVeXgxUDZjSldSNncvY1FJdG1tUmVqUEJFdWRyYUYyM29pZHp4UzBrUUpi?=
 =?utf-8?B?cHpseGxnU0VKWGN6VnR4OTJlc2g4VmdkYnI0TmdTWG5sUmdCWllRbkc4Mlhv?=
 =?utf-8?B?UkZ0aDlGT2hkRXBoL3p6ZGVuZS9XdlczTko3Q2xPaVFLU0JySlBqN3hFSDY3?=
 =?utf-8?B?MEJzL0JwcGJIbUV6aDJwWVVoS1VoOW1KVmdlTzczNFdtYlJhVUkwcDMycjlw?=
 =?utf-8?B?Y0xQUW1uOUxwc1pzeGZDUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJMYmwyY3RrNnVycFYrYis3TG9XbG1TRFZXVnhVMUI0YUpjN0xXREoyanNl?=
 =?utf-8?B?aks2MTRnTmwvdmM1ZGV4Skk4em00dS9zbjlWbERabjBDbXl1SXN1SW1XSW9y?=
 =?utf-8?B?TUZsODFQeHpkeFVZalVIMnVNWVBKcTEzTnBVTy91RnljN2dQaFRkdThYWkhU?=
 =?utf-8?B?VU5lcDB4RDlSdk5Wc0VXejNIbEtveXhPaENFUVV0UzhIYi9Cdmxtc09hT0RQ?=
 =?utf-8?B?Y25vVU81cVdxakdMbzczVEhSOHhTak5rS1JKeUpYUzdaaU4rM3VORWdXRUNZ?=
 =?utf-8?B?KzBUYnM4K1lEanVuYWt6MHBxTmlMZ0JXWVhNa3J0bkI1MmVRZTRoRXFudDUr?=
 =?utf-8?B?Uk9lNmJPRmFFblR5L2xhaGtZalZmMHdLRk4rS3o0VnJyL0x5b3p2L0pMQmhq?=
 =?utf-8?B?R0lCczVqdUEvZGVxN2VyYkc0OTRRcVpmQ1ExSjJDWGdGVUN6TXQ0WWhNVnB5?=
 =?utf-8?B?TGlTWXE5N0ZEVnZYT3JDZXh3eWgrZDVmd0t1Wk1PUEtCWkNxNkE5QXc5WElz?=
 =?utf-8?B?dU11TGowUDVmY3pZSWxyMGJIS3N1STFJUlhkeW04dGFBSDFRR3FQYlgzSW1s?=
 =?utf-8?B?dlA2QUszeGFWd0JCb0ZPQlBjalN5SkNaV1F1NXA4blZpQmRKTnYrRFgrNzZq?=
 =?utf-8?B?VEd1RElqK2g1aFNYVXNRRHJLU0ZYUWFtSXZneWErMFZ1RS9KQ1RRUXFoczJy?=
 =?utf-8?B?eGlTYXM5SC9nMlJDSkltMUlEUzNaakRlN2kyN0NObnJYWEh1b3dMQk1jSWh2?=
 =?utf-8?B?SG54TUg2bGJ3RlFjeHFUa1oza2JVeiswQ05FSmplUWdZQ3JGMlR1b2NycFM4?=
 =?utf-8?B?ZDJvSHZKSVo0eG0rN3RYaGRCdTFtREZLaGcyNmVmeE1ZdE1Gdk12Y2VnbGxE?=
 =?utf-8?B?cndkbHk4aHYzRVAvYUtDRWhpNnZjN1NNVUt3bHBhZk96QWpYYk96ckZ4TnhZ?=
 =?utf-8?B?WmlkMUFxSi9zN3JxazIrdXpNUFg1VDZUZ2VET2dGbWFJRzRDcS9KSCs0MUFM?=
 =?utf-8?B?ZDJVSTlsZWhkeER2VUs1N2pseTQzYXhGOG9jd1RJaC9Mc2xUSEZGQzVCeTdm?=
 =?utf-8?B?cFpERHlIbGdybmowUG9hQUdvcmhzMGVSUlFTZkhuRjAvQUN5WTVZTEpmNzVL?=
 =?utf-8?B?SS93Nm44WjZNMkN5cnN6KzNwcE9QMUpoSndzajJZeE1DZ1A3TGgyaXIrTFpW?=
 =?utf-8?B?dko4U1J4dnNwaW1neVFQbTNiWmtrQ3JkNzk1MlltUWpBc3JETjJCZjMwcHJm?=
 =?utf-8?B?RFVLRVY3WHYxZitPZ2xxRHViRklTeFZXa2VtK3V4N3lmd21Xa2x1OGZoSDdR?=
 =?utf-8?B?NlFkSDhIWVBJNFUxd3Q3ZVZ4VWNueENydWhOdHI0eE1CN1NrMmowSWZLM0Vj?=
 =?utf-8?B?c1B0c2pLN3BjcUFIM0g4Q0xTVkc2TEZoaVFlTE9hNEt0cGpTelZURjJkdmxP?=
 =?utf-8?B?QzR2U0RjL3hmeDlJNFE2VlNJZXdiQ3RxTS9LdDh0cDU5N2FkUXFCWGpyTzdF?=
 =?utf-8?B?aVFla3M1NUJNd3RHYjRsZjNVQ09oNG01NG9sMHNmdm1HK3l5K21CRzkvQVJy?=
 =?utf-8?B?RE4zWHFJNEYrd1VnUUtrc1RtYVdiMktLVnllRFhFbG9WeHNKWWsyWnIveEkr?=
 =?utf-8?B?SE9CVjAwV3BCTnZSbHA3N3crMHVUVyt2aXNPVnpSdTdEb1ZENytKS1h1ZGhp?=
 =?utf-8?B?akRvRmdraU5vZExTY1BaVFBWRDdRenVJQk5yS1dCN1pmTUpGdnB3Skl6OUJP?=
 =?utf-8?B?T0R5VytkK1B4SFVCMkhMUUZvTVpGODlSTHFIczFPckgyc2VQcHVSL1VCbVh0?=
 =?utf-8?B?RU9QVHpVQlRxbEo5U29zdzFVdDNRejBwVDNmNDhmQmg4dnBTY1YxTVJLVjc3?=
 =?utf-8?B?dHJEbGNqYWp3OUR0cHBqdnJWU1AySTZnUTF5RndESkh0WW9ac1F4TENEQXlJ?=
 =?utf-8?B?WDdORGcrQVNZR1dPakpLUWl2RkxrMXFCRGxMbEt6elVyU2tURVYrRUxUUlRJ?=
 =?utf-8?B?dHJmNlE1c1k4dkI0TjhrWlZGb1VIZHc3aHBuUHcxaWQ2V0hMT0pZcDByVi9Q?=
 =?utf-8?B?eFZjUzQ1a2FMNDUxUWJLNHppQjg3bHZEdWlURExlenliQlNYTHJMMk00dk84?=
 =?utf-8?Q?3cwk3uXCTQ/H9RsEntOw4OqO9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a95c17-c4be-4715-bf23-08dcad79b2bb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 13:48:58.4483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6syqBX7/TJBQiVU61dEjdqY5RPNbeiiXPGDqcRvcCKUBl/kbA9MBw+aCRutjpaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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



On 7/26/2024 6:42 PM, Alex Deucher wrote:
> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>>
>> Problem:
>> IP dump right now is done post suspend of
>> all IP's which for some IP's could change power
>> state and software state too which we do not want
>> to reflect in the dump as it might not be same at
>> the time of hang.
>>
>> Solution:
>> IP should be dumped as close to the HW state when
>> the GPU was in hung state without trying to reinitialize
>> any resource.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
>>  1 file changed, 30 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 730dae77570c..74f6f15e73b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>>         return ret;
>>  }
>>
>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>> +{
>> +       int i;
>> +
>> +       lockdep_assert_held(&adev->reset_domain->sem);
>> +
>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>> +               adev->reset_info.reset_dump_reg_value[i] =
>> +                       RREG32(adev->reset_info.reset_dump_reg_list[i]);

A suspend also involves power/clock ungate. When reg dump is moved
earlier, I'm not sure if this read works for all. If it's left to
individual IP call backs, they could just do the same or better to move
these up before a dump.

        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);

Thanks,
Lijo

>> +
>> +               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>> +                                            adev->reset_info.reset_dump_reg_value[i]);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>                                  struct amdgpu_reset_context *reset_context)
>>  {
>>         int i, r = 0;
>>         struct amdgpu_job *job = NULL;
>> +       struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
>>         bool need_full_reset =
>>                 test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
>>
>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>                         }
>>                 }
>>
>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>> +
>> +                       dev_info(tmp_adev->dev, "Dumping IP State\n");
>> +                       /* Trigger ip dump before we reset the asic */
>> +                       for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>> +                               if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>> +                                       tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>> +                                                       (void *)tmp_adev);
>> +                       dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>> +               }
>> +
>>                 if (need_full_reset)
>>                         r = amdgpu_device_ip_suspend(adev);
>>                 if (need_full_reset)
>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>         return r;
>>  }
>>
>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>> -{
>> -       int i;
>> -
>> -       lockdep_assert_held(&adev->reset_domain->sem);
>> -
>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>> -               adev->reset_info.reset_dump_reg_value[i] =
>> -                       RREG32(adev->reset_info.reset_dump_reg_list[i]);
>> -
>> -               trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>> -                                            adev->reset_info.reset_dump_reg_value[i]);
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>>  int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>                          struct amdgpu_reset_context *reset_context)
>>  {
>>         struct amdgpu_device *tmp_adev = NULL;
>>         bool need_full_reset, skip_hw_reset, vram_lost = false;
>>         int r = 0;
>> -       uint32_t i;
>>
>>         /* Try reset handler method first */
>>         tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>>                                     reset_list);
>>
>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>> -               amdgpu_reset_reg_dumps(tmp_adev);
>> -
>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>> -               /* Trigger ip dump before we reset the asic */
>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>> -                       if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>> -                               tmp_adev->ip_blocks[i].version->funcs
>> -                               ->dump_ip_state((void *)tmp_adev);
>> -               dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>> -       }
>> -
>>         reset_context->reset_device_list = device_list_handle;
>>         r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>>         /* If reset handler not implemented, continue; otherwise return */
>> --
>> 2.34.1
>>
