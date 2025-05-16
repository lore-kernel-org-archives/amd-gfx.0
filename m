Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5F8C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 13:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E1E210EAAE;
	Fri, 16 May 2025 13:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="22zxn9aO";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E348F10EAAE
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 13:07:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqvQtIbWi97B6zxepCcV3ruUf9YUhYGWosbB6++AAUsXRr189rBQtiMelulSSmqr+bomPMQZOh1QNt2fSNekbqe1WAEh6Y4b842QHOCvvXxhOV/VDgOvDkmDPN5/egFJT+xys74nmMEvSHK5b168/XOXIBuf+ILT5fGS84ApqCMa70hpOtF9tBfM6cekliCt37TeydKTFNqrIJrtMuq/wNmMc6yv2kiTdoGlNJFeZhTMVDFqjRrrd5rU06DpAugSLaWLQw5zPOICjGp44BJE7zejJa3AMP7qP6KfLxpoXuCs6DrmeObA9KC5AGTOI+rkx5VhSCZKXSTemc7NXPlFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EpaToFn9u2MmsTvzSdJpYkcIZhQ/3snxXYNi1aIoi4=;
 b=Rby3oTnTmtrO8cE4Q+BlzAxzEhswwkgb7SWVX/iQdc21XHIzTTiDIEqLNWmJkqa7FaC96kI/IElqYE3meD12plo+98Yu/zTHG20hHcIlFgDRqfE4BDfC9iCG9fBgO2sAElKPiex42vHciBezFY78xDjazrMJMhJFhFroVM0ygRmL5hpO0v6TXbggMVTYv677nRGWHRmujtSByau+sGRY7uoWzIN8DLsL3HfSx5Gyk34t6vi3E3qo6h9MrSqE5DEEF7EDvgWZt+3OQnbrPcbWg66PsDijuIYCm18yFWCfbcCXSFK5GFGlrYZcuKrnqq1weInbYbe+y4eDlJduNQWGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EpaToFn9u2MmsTvzSdJpYkcIZhQ/3snxXYNi1aIoi4=;
 b=22zxn9aOWk5G8QoblmHrO4yvgA8gljb380cQ0eqXQaQNKNI3r8QhdkLUZcrM/ef9UeOP7mWh3oAcE+3ItbDkQEM+A/JHt8W4v7rJ1CAxcL1AHM5yAVaq7xaem556/JJKC8c7HSRnehPe3mgIU1FSezzH3MueE8UyBz0eujCgxVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 13:07:27 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:07:27 +0000
Message-ID: <162ba0d2-6b5d-5199-f560-b3eb4fc6fd29@amd.com>
Date: Fri, 16 May 2025 09:07:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: destroy_pdds release pdd->drm_file at end
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com
References: <20250514171004.4259-1-Philip.Yang@amd.com>
 <20250514171004.4259-4-Philip.Yang@amd.com>
 <4a02537f-1ea3-471f-ae10-c85471a65402@amd.com>
 <18f1dafd-4f0b-9dac-2994-3e826f17e335@amd.com>
 <8966fa75-4c46-45c0-b9c6-543f8d10f340@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <8966fa75-4c46-45c0-b9c6-543f8d10f340@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb0ccf0-9c49-4f43-c586-08dd947a9b2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFNKcEpIOFNRcitnTURBZEd1UkhGZE9pbGQ2d3liRGttd2dSQU16dldmNkdn?=
 =?utf-8?B?d2g3bmY5bEMzU2dic2xRMG1UYnNjQkVtbEloWVJJL1lmSklJRlBsUU1ubWxo?=
 =?utf-8?B?S2I3N1lLeHNKd0lUcDhvREhUdUlFZlMrQlVaQjZyOWlOWmxWbEZ2ajc3N1Rl?=
 =?utf-8?B?K2hBcHdncnZnYThyVG1nNzNtVGcyeHJyVW4vb2FreFZsVExLRnYrcFY0Z0pl?=
 =?utf-8?B?UTJsb2hidTlUeSt2Tk5HdmlFT1JVZFo4THNIdVNZUko0SVRqRkZjNE8wWk40?=
 =?utf-8?B?UlJWNEl2NlVBVE1VNmU5a1l1RUxHNHo3UWk0bGp4T3AxTS9NUnEyeTZNL1BG?=
 =?utf-8?B?VElTeEtUSDFYMWV2L25rUTN0aHpjQW9BM2pxU1p6ZnRYaWRUWlJtU2dLcEEx?=
 =?utf-8?B?ZGRUUlZjTllsMUpsSjFUbzNCOWwydE8vU2I3bjZqK2hqWjdUalEzdVROSE93?=
 =?utf-8?B?bThrTjA0ZE41NC9OVWppenpBV0Y2QWFjYWVFeUxpb281MExjS2MvZ2pUV2dl?=
 =?utf-8?B?czNxa1N4S3l5cCt0UHdCUG11ZkpvcEltU3NtbXZ4VzE1QzBqMHB5OTJzZmNx?=
 =?utf-8?B?YU00b1Zqb1hzaDhGN01HZWJJOVlSRmUxbzZFb3k0MEZMWVJlTHR4RVBXQlc4?=
 =?utf-8?B?OEk5WG9pZG9iWnhJZlM5Y3A2Q3FkdFNlUG16b1c3RTdHdzcwR2lYWnEycDQ1?=
 =?utf-8?B?OTZyanRIQ0FyanViL3lJUURFV0xRTXNYSmlUbkFHV1VDcGZhcXJIbmZGZlRR?=
 =?utf-8?B?QXI5eUJxZ21DY3Y0U0RmcVh1SjZqb3RDSWFLdFV3K2FLYlplbXMxQmxNVWpW?=
 =?utf-8?B?WTZUOXp4VFpQdDdZS254WUlTZ2JpangxNEp3NnJ6M2ordG5JNkZaYmQ2RXVC?=
 =?utf-8?B?dXl1Q2RzR085UkZIWTBhbXJZbzNKUEp6dWw0dGFZTkdaUlhsNmRTbWlTN0RT?=
 =?utf-8?B?Qm9MSmlOaVpwSWpFWVRUUmF6MUd0T285RUxuNzBXWmNwQ0Q5MlJFdEF0aGhk?=
 =?utf-8?B?V0tCVlhjK0JGREptTjRmM3k1U1dzVEVhVDdQY2NkeUJQVjIwZmRBaFBYNTA5?=
 =?utf-8?B?ZHZ4c3RCWWlQREJzeXZwS3k3QkRUeHQ3QkxaQUk1RVV4citlS2IvM1BqOFMv?=
 =?utf-8?B?RkxUQnZzTzdqWHBFT1FzRFhmRGVUd1dsNExZL01ydVBQQzVUbE8xSEI4UFZ3?=
 =?utf-8?B?NllhZlVGNDkvZmZiT203RTNqRVJFRk9hNXdqQlgzYW5DY1hHQmg1WWlxaEdZ?=
 =?utf-8?B?bVhxaFl1cDNLQ0k2UFJDQlREZUR6MXgvZURoS1pOWXFzdTg1ek5wdy9kNEc4?=
 =?utf-8?B?QXlqYUpmZXhwbHlQaDZGazIxWWpDa0tMcHhSbkdjYUpQaERTeXdqcDZoblNT?=
 =?utf-8?B?WjdSZlVvQW12d0F3Nk85QVJXc1FjbmxDcVp1ZWdQSHg5dXN3OGpiWUI0ajFB?=
 =?utf-8?B?aUkxR1IyN0NHQjREaTBjazdsMDVYOHpCaWYycHlWOGk3eGZoT0Y0ckk1MjNH?=
 =?utf-8?B?YWFtM1JWYTlIS2tCVUJKLzZud1lacndFYUdiY3RGQWp1Y1ZiTVdUNzhURkJo?=
 =?utf-8?B?REN6VFZJaWFwbzdHVi9nTFVzZ2pyb2tlUlR1ZWdXc25HcnRRSit4amRpcHox?=
 =?utf-8?B?TnpOQzZRTHZOTm9GQ1QrN0ZPZGMvcTZGdjVPajR5cytua2wzLzYyVnltNjdR?=
 =?utf-8?B?UldFTTJOWTZ5RnVQNThuWXN6N2c1WlZ1L3F1UUx2eTBwQkJiMjZGdVdaWWZX?=
 =?utf-8?B?VmtHUkVXb05RNFVzcFI4YTVUTzRZcWtNTWxaeWowaFFaMFhRZmtWenN1OXdD?=
 =?utf-8?B?VHpOTDVuMllsU3crd2pKQjl4dW9NSDkzMllxZk5TaU9HejJVUnVLdGZDNElS?=
 =?utf-8?B?NlQxNmF4UFFYTlBVeFZyU1Qvbjh1aEUwLzZqdGppL3JxR0JjN21ZNWZRNGpp?=
 =?utf-8?Q?0vOigtjlobg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlMzTWloY0xsd1JDbm51SzNMVHVMbi9hbWxCMUt4N2lUS2xJMnRaK0UvVGdm?=
 =?utf-8?B?bFF2OXFBaStuVk54NmVwZkV6cW9wY09aR2tKNTNTd2ROdEhOTzNNSDN2Nnc2?=
 =?utf-8?B?V3NQOGNuUVFjMENGRHV0Tk92bU05OVY4Q2oweDA5cmhpeEF0T1VyS2JpVGt1?=
 =?utf-8?B?elBEeUZyV016YWI3Q2FISERJYTlqRzNEcEZVNnkwaXoxcnpsYnhUY21rY2Zk?=
 =?utf-8?B?TVY5aEpMc2pGOTE1S3ZzODJURXovdjIvQk1yc3NyNzB0K3Z1UDFqZVRtSnJQ?=
 =?utf-8?B?MEowd2lYaEtpejFneTU1TlRsa2tCd0t1djZBYm9FRTc3Q0UreDFVajRsQmxQ?=
 =?utf-8?B?WkUvQ0t1a29qM200Y25HR1hXMW5kR2xYa1RUbVNMbUN3b3gweEt0S3hFck5a?=
 =?utf-8?B?WXJnaXJCclBwWW5Nb3RTSEhocXM5akc1VkIwWklIT2lhZnV4TkFlMjJkSkhi?=
 =?utf-8?B?blZXc1NsRGtiY1ZJNk5PZDRHOXluSSthLytjdk0yLzNiTnNaQ0FzZUdtdVpH?=
 =?utf-8?B?QnFCeWVwcmNZaTVJc1RvcE4yWC9NaENjdzkxZThrd3pkNzkxSkM4NEVIdnN5?=
 =?utf-8?B?dmhSUkJMUmhVWGs2U2g4RFpjSUdNZ0VQZUppK2NNaDYvZC9tUFFTWG9ncTZP?=
 =?utf-8?B?UzdvT0MyWjFoM05waE42bzFRaVhpYkprUTc5Z2M3U3AreXhOcTVGTThRRzUr?=
 =?utf-8?B?TW9Fait5aEZCWElJTjJEc1hBaFE4cjVNUXdZeFR0K0ZQL01kVUczMWpMV2NN?=
 =?utf-8?B?RmFrNUpkRHdPMXRjdFIzOEQ2Q01mT0JVcmE5RmU0SzRPeFphL1NLQmN2VC9D?=
 =?utf-8?B?UEwzUzNLQUFQSTFKRXRTZkxGbjVWejgzSi94TStzZHFSOG5oT3JvTTJVcDNJ?=
 =?utf-8?B?OW4ydnB0ajVZNjJtcS9FRlRuejVyeUJuQlhmcFFSZStOWDZMLzBieWlTc2lP?=
 =?utf-8?B?NkN3L1lJV3RtSmpjRVNscW9hM1h2L1FpNytUSW91bi9SSlV2OFZDQ0RMK2xL?=
 =?utf-8?B?TUhXLzRyN0M3QzZKeEptWFpsdE9oblJ1Q1U2Znpla3o3bS9RYjZucm0zQjkv?=
 =?utf-8?B?dktOM0JhNGorOG1NOHRGL2ozYVAraERRS3k1RmRNNDNPQnlqZWZxb2ZaOTZR?=
 =?utf-8?B?T1ZST09WS2xES0lmN0RnT2dUSjJMajhXZHBGcTdsRWpKaDJqdzZZMHlpejRH?=
 =?utf-8?B?VmpyVDVHSjNiMVRSOWpCZnZtVmdrL091SGxkRHRrMmxoKzRoZmNRa2lUSGRi?=
 =?utf-8?B?aG05TlFYcjJUd2hKQktXbUtaU2NSeHdEalgvK1ZZeldzckdETnlNMDVPdUkz?=
 =?utf-8?B?MnFlTGZxS2dGNDVPcnNDSXc3T0c5TmtFYjExemFZYUY1OUcxMzlKSHJTVFJS?=
 =?utf-8?B?TFZlK1Qxakp0VnBIeVdUQTIxUFIxaWFhUjBBbFlHbjh1N0pqMEZEM1hDeHJl?=
 =?utf-8?B?ZVNQZjBFT0JlV04zZkRWMVNyNXpKYWxsV2ZaZWNDdzY2WU1lb2JYcTcrN3Bx?=
 =?utf-8?B?d3JzVitwWTQvcFZJZktLdS8yUldyYllPY01jZDlCSkxKTVU0aXhUTEVQVzcz?=
 =?utf-8?B?VzFZQ01kT2Qxem5PZjdVQUQ0Vkk1UDNwL3lLN2VYNlpDNHZlUXg4VEx0cjl2?=
 =?utf-8?B?RHJWcGErSzhjMmFGcnpzbkxOZC9kK3lvZUkrRkNCNnpkYXIyNWJEMkZ2K21U?=
 =?utf-8?B?cUUvR3ZHSmtCWCt1dkwxM2tZWFAwUVRGQW5uWGZzMDJ5V0tYT1FnSllvYzdm?=
 =?utf-8?B?Qmo0aWFXTVBhWnBFdGNaZzJUeVlWdlRpTklWdHZuU2RZdGhQTi9YQ1N6NU9W?=
 =?utf-8?B?T29hZmlpdktxZXk0YzVNb2tzV1M4aWxxcG8vUXk4b2RBY2ZvQjZnWnRtRDhM?=
 =?utf-8?B?QXEzdlZBL28yN2QyL2hxaThaUFQzS1BuSGtZQm1mbU1YUWtOYXVlZDY1OTFI?=
 =?utf-8?B?V25nY2wrZ1pGdE5tV2JyV3FYTnpWNi9vRVdwTTZ1c2R1emZ5VFhvaG1iZGk1?=
 =?utf-8?B?enZEMlZMMk9OMlhuUWVibXVDQjFVU2N5Ukdab2xyd2R4TXBIMlNsZ0hJL21o?=
 =?utf-8?B?TE9PVy96MlJLcmFKZzVxQi9EaHg5Zm83YlBNRSs5YjdwcU13TWlrQXY1WUZH?=
 =?utf-8?Q?px+w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0ccf0-9c49-4f43-c586-08dd947a9b2d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:07:26.9773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRBbwe0mTMgMo9otqYTtqAR1rrs0Akbr3YF3bnHHPBBdLxz9MtXwwHuSWdCIuB/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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


On 2025-05-15 17:31, Chen, Xiaogang wrote:
>
> On 5/15/2025 3:45 PM, Philip Yang wrote:
>>
>> On 2025-05-15 10:29, Chen, Xiaogang wrote:
>>>
>>> Does this patch fix a bug or just make code look more reasonable? 
>>> kfd_process_destroy_pdds releases pdd related buffers, not related 
>>> to operations on vm. So vm tear down dose not affect this function.
>>>
>> This change doesn't fix anything currently, as fput(pdd->drm_file) to 
>> free vm is right between free vm mapping qpd->cwsr_mem, qpd->ib_mem 
>> and free kernel bo qpd->proc_doorbells, pdd->proc_ctx_bo, to make it 
>> clear for future change.
>
> Then the current place to do fput(pdd->drm_file) make more sense: 
> unmap vm mapping of qpd->cwsr_mem, qpd->ib_mem is the last place where 
> kfd process release procedure needs vm alive. After that the kfd 
> process release does not need vm alive. It then releases remaining 
> buffers. So release drm_file as soon as we do not need hold it.

The issue was  vm_fini shows error message "still active bo inside vm" 
(1/1000) chance, took a while to trace down the leaking vm mapping, the 
issue is seq64 memory mapping leaking and fixed by the first patch. KFD 
pdd cleanup path, free vm is in the middle of free pdd memory, this is 
one of the suspicious vm_fini race. We may add new pdd memory mapping to 
vm in future, to prevent the potential vm_fini race, this patch move 
free vm to after all pdd memory is freed and add comment.

Regards,

Philip

>
> Regards
>
> Xiaogang
>
>> Regards,
>>
>> Philip
>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>> On 5/14/2025 12:10 PM, Philip Yang wrote:
>>>> Release pdd->drm_file may free the vm if this is the last reference,
>>>> move it to the last step after memory is unmapped.
>>>>
>>>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 +++++++---
>>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index e868cc8da46f..b009c852180d 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1063,9 +1063,6 @@ static void kfd_process_destroy_pdds(struct 
>>>> kfd_process *p)
>>>>           kfd_process_device_destroy_cwsr_dgpu(pdd);
>>>>           kfd_process_device_destroy_ib_mem(pdd);
>>>>   -        if (pdd->drm_file)
>>>> -            fput(pdd->drm_file);
>>>> -
>>>>           if (pdd->qpd.cwsr_kaddr && !pdd->qpd.cwsr_base)
>>>>               free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>>>>                   get_order(KFD_CWSR_TBA_TMA_SIZE));
>>>> @@ -1088,6 +1085,13 @@ static void kfd_process_destroy_pdds(struct 
>>>> kfd_process *p)
>>>>               pdd->runtime_inuse = false;
>>>>           }
>>>>   +        /*
>>>> +         * This may release the vm if application already close 
>>>> the drm node,
>>>> +         * do it as last step after memory unmapped.
>>>> +         */
>>>> +        if (pdd->drm_file)
>>>> +            fput(pdd->drm_file);
>>>> +
>>>>           kfree(pdd);
>>>>           p->pdds[i] = NULL;
>>>>       }
