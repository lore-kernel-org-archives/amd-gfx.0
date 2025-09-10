Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D3CA101F
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 22:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982DF10E9E6;
	Wed, 10 Sep 2025 22:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B/CJrufw";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E528710E9E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 22:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTwXODZ2IRQTZ8pjxfC3RHHfYYCaUu7IVgxjzhfinUoDz3C3dJWq3JEsY2sbJNyzfXlITT1IH3vdPh7qqoUzhgVDx2RQ1O+Vkh1ZC0T4X8OyxORsDBsVIpN8hr5HWOeJZ+TG+iew2Ln7HetPATp4yTgI80kLcXAsi6TCwuLMCnhuxOre245xL67GQ+rf1yQgGlKTQph9/uUUhaYwCcquGmuhn29m8QPwlCv8y5IKuxlG0l18fgCZm8NVJCjmbm4iWBc3xyGH4LyA36JkA/e4+QeLNLNKFi7ibpKHt/2+X9jDPJfjGGFp0xhOPKRQJvdiA/ESPyFRuenGGAWvwhFIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTa+DAIb23wCqEJQMUHbNYBAgi8OOodSL53bPm503zE=;
 b=vHGJ/mfF9pqCNt6Pz1WPGY9N9pMAaiCBq5jsZpoirfoM65oF7EDomTUTuiatMC/uPUbjHRFYcyqvRJaT/Mk6W7xUlsqnVkwK75EwqfpT5RBvXjjh4aiqj5Vzo5jbEP22OJTEOT4oCaPQLuOZoMtpWHso4s4Qe43oXJHjmTt2zMWISLnFqMhomdR7GwTT3Vop+PKI5pG8eTYfpNZOSsRxTAcn/qDeTZi3t6Escafqc276sq250JFSaxNFl+rqRl3zmvTVTXaaE8ghijUs5YnGx46Y6+/pPJwFbSO0uGVhhb7xbkT/DOcXypOq9EXGuFr/i24rNKxMrCEf/8swJ1pzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTa+DAIb23wCqEJQMUHbNYBAgi8OOodSL53bPm503zE=;
 b=B/CJrufw/VnAImiNgUh6CRUOUhNFuF7TGvoUngcyk2bypHpt6ylQka/BOz6TQWfupPNAhLKuqQpa5A/n3UU335cgXx58nUJwmSIdfmIaQEfPASlRwFAh5ipNHE2CZjHk6moqrBKAISSnPYEZWAI72IdTIR2B3UUCdS7ksMk1bpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 22:01:23 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 22:01:23 +0000
Message-ID: <589ee8d9-091c-4afd-b4da-f091cc717336@amd.com>
Date: Wed, 10 Sep 2025 17:01:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20250908024021.1857440-1-Prike.Liang@amd.com>
 <DS7PR12MB600542F4CF8B3D69A06EB2C6FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <DS7PR12MB600542F4CF8B3D69A06EB2C6FB0EA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0208.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: bf1da0f4-146c-4f53-4818-08ddf0b59470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0JoWWdYWW1sRmE2QXMweDhpb05od3cvN0lsbHU5NEVVSUpHMXJvdmVLdWhB?=
 =?utf-8?B?cEFHYkgyQm9iT3hVUWd6N0ZJNlZLZXJzRzBuT0lZQ0tidDhLSGE3TUh2L2dq?=
 =?utf-8?B?ZVprOFZkSm1JWXZ5cVMrdHJLQjdqa0gvcjlkM1ByVUlxcDIrRktMVHFvMEN6?=
 =?utf-8?B?a2Z0N3BaU24yUGtrTGp6elNDNHlCdFVlQ2Y3ZVh3ZzA3b1JpNDAyS3FpU1RQ?=
 =?utf-8?B?aGljUUoyVDF3dkRONXg5THBVWXcrM24xRTZXcm03UXpKemkwRnlWK01oUWw2?=
 =?utf-8?B?bzhXUXd4cVl1MnV0Z0RoLy9iNGpSL2EreVEyMTJNa3IxQUxOdHNJZGdHMnhk?=
 =?utf-8?B?Y0JDRjFLbTBrbXBrT2FSZHJoTFpoUUxDTHBYZ1kzdG5XUzk0Zm56aWtFT0VJ?=
 =?utf-8?B?bE9kZ0hVcjdDZ2hBSmxncnIvQStGWjh0bGM1RGk0Y2Z4MlcwYzhteVdCTE1h?=
 =?utf-8?B?R3YwNHIwKzhtL3VxeVNMTEVVTGRZRXlML1Y1a0R1RUl2WmgvQXQ5ZVhMTUhi?=
 =?utf-8?B?UDE0QmEwM0Y2TFgrRy9GdUFDVC9JTGc0RlRIdjdvOGxyK0M0ZWNteXFoQm9S?=
 =?utf-8?B?Z3hPUytOU1VpU1NOM0xnUGFoS2t1cWNtVVJxdkp6d2EyRm1sM2F6RzY4bjRr?=
 =?utf-8?B?bkx0K0o3ZUt0Vjl1akcvUU5seFdSUEF5NGVLNHMyNlRFRU1UK0RmcDAxTHM2?=
 =?utf-8?B?M044TElZK0JjRy9MQWtydXczTlBUMVVZYlRXZ1VRQnI0cldqMU4xeXJPQ0hG?=
 =?utf-8?B?MURHTGxjNjErQ0w0aEhDU2ZlTThIME14c0pxTm1ELzlMcHNqNGg3T2Iyc2tK?=
 =?utf-8?B?MGpUZkVxbG4xcWEzVXBQSFNJLzFjbXhzOTh2c2tTS1pqZW40MStwU3hmTjB2?=
 =?utf-8?B?Y09IMU9kbnZwc2xQZDZoZ1hyd3NlNndVVGZqcTJ6OCtQY3oxZ1MwNzZNRHBV?=
 =?utf-8?B?R0IwUHFJdGFrbzR4c2R3RGJQUUtoS296b1p5Q1BlMUg1bTJFK1VHYjJEWStP?=
 =?utf-8?B?a1ozSWtZTTNCMUVhQ3ZUVHVCQ2dmWWRoVU8xM3I1OHlxUGlpS2tNMDhPVGRq?=
 =?utf-8?B?blJuS1JFK2V0cGw1NmJPUzlJenc2VmxmY2RiMm5iZmMzMWhaVVE4RldNTjYy?=
 =?utf-8?B?bjVBY240eGtXMitrVGYrb1BpSnlKUkZlZUdyUG9mLzZ0VXdYZlFiOThLWmJY?=
 =?utf-8?B?akdWcEhwRUZBelVVMDhxTkJGbTdjc1o1VDc5SFV4WXN0TXphOXZDUUFGdWZ3?=
 =?utf-8?B?UXFIMm5iYWZIZ1ozWEMzQ1l4dEdFV1NmRUZkcGpGd1Jxeis5MjAyaE9aVDg2?=
 =?utf-8?B?dU91R1ZmL2wvWmJXNC9ORFZ1SHlHS0YvcTRRQVl2Q05nbzIvd3djYXpEcWky?=
 =?utf-8?B?SUJ4bFNKRDhiTHlkVWZiKzVYQm0zSmRFci9LWTRFcUZFNGpPc1o5ekFhYjBG?=
 =?utf-8?B?ZGoxVklXbmo1UmkxSHdIMk9OTWFZZEwyaHFqcEVnbGoxcnM3THZONGNVMEJi?=
 =?utf-8?B?ekRCajdLS3hSdGRpUGZOTUo2WWxzWlpKeDhsNCtoanhxY1FwQWRlSHhOcXpH?=
 =?utf-8?B?Y0xsTFhQYVpEaGZFdjRrMzdvWGQzaWRvK3F0Q1RNVHlWS1FSR0xDamZrRkVu?=
 =?utf-8?B?T3JxelRZVVpkajQ3Z1YvTitWSUoxNFNXTEo2SVQyUkNqaDNqTFJ2Tk8wM0hI?=
 =?utf-8?B?NmpqaXVhbE43VUtBVXNaZEhmMkU3MU55SUxzaS8xYXk2THZBZ1Bxd2lJbExs?=
 =?utf-8?B?cVFQeU5Hc3ZCYjE5NGhHNUI4OGhpUVpxcUxubTByTUIzbDlId2d2NGR2TlA0?=
 =?utf-8?B?dnI3N2laRXNualN3YWNFd1JsSWJjekZaTFlMMmZnRXUrM2NKTWJzL1BDclJt?=
 =?utf-8?B?YnBvMUFFTm1PRDRKc0ltS0J5RmpNYThmcDZnZFV6aWEyYUJSZCtrcTMxMU9k?=
 =?utf-8?Q?WsZkh/MGDGM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZNZzJjNlc3MnM3ZlNObUlkWGQwSG0rd3A5MDE4NjdFcmluSUlUd3hyR2ZV?=
 =?utf-8?B?YUo1bUMxZE5QdEdiM0FXOU9kaXR1MTQ0d3BMS1NBeHJrVDNVZDhmc3NvNlRI?=
 =?utf-8?B?VnRSVkpIL0ZhSkJxT0F0YU9yM0tpb0lpdkMvV3A2SUZESS9yZ3h5TXEyMkYy?=
 =?utf-8?B?ZXRSMWZ2dG1YOC9qV1N2K0dlNHhhK3JmdGRvd0VOTXJRVkxDU09yMWZLNU9O?=
 =?utf-8?B?YjNlMWFtMU5UU0J5N0NqbFpOaDd5cTdKQVdTOWMyY0ZYMzZEWms1eTVxOWtG?=
 =?utf-8?B?bjVFSWRUcnFmWTN3RkhUc0JHZ3lJM2Q4cU9BdURSakdzc3RmdC83MW1zN2xU?=
 =?utf-8?B?SENvM3hNU3NRKzIvcnFDNEJkR3hhVllMKzRHSDNNcXlwZEl3OFZnSE5aUzFV?=
 =?utf-8?B?ZUJuMzVwYjJlaDRUdWRGdExFVnlrd3ZDM21LSTJSdXk2WVFJTDNNM2tCVXB5?=
 =?utf-8?B?NGNJdDg1bWRlSGhqbEx6c0N6b3FEZUhCby9GbHF3MDRiQU5TTlFnV3JMVnE5?=
 =?utf-8?B?aVh0YUZ5czFTblZ5dm1waTRWL29yYWpkOFJDRm5aSGFGbVNHamtMcmhjeEhY?=
 =?utf-8?B?VlpqTEZHRDYzb1lWMWg3KzBjeEFtazVZTzVPdEZaQlZLK3pqU0J3NVhDQmVz?=
 =?utf-8?B?bmxHeFl4MFhBTTlKS2pLV0RBamc2bTZmNVRkM0dtbFFWeURpa0FDblVPWUlx?=
 =?utf-8?B?RHhGSEtkdHFDbTN4Y3R1S2ZGRWlpdVAvditLZkZscGpxWlQ5ZmFaZEpZNU5z?=
 =?utf-8?B?TFVKU1lGL2pBTEVQcGtqN2k2YzdkdmZpVGlmL203TXZMSXBXbkVIbERBRVpL?=
 =?utf-8?B?VXFiOUVpQUJkZnpNUWZZWWhVUi9xdjVVT29FVXRyQUNpWlo5RnpFWUhXd3pD?=
 =?utf-8?B?WmpzOGExSllZaXA2RmVJUksvMDcwSXhpTFRDTzBhUS93SjFBT2o0aGRFaW4r?=
 =?utf-8?B?M2VTY1dxSHlBRjllZUdLUC9URTk3RldaZUZ5RnBNT3h1bDBGSTZTZjJRaGU5?=
 =?utf-8?B?U0wrMElOWXFITTVIWEZNYzRsWmJKcEpWblBxSERxVVE0RS84a25ZbUpNQzVj?=
 =?utf-8?B?bGhBc21vM081M1ZHdVBKKzRHRzlXNGZsYzIzeFdoZVJwd0JXRm4zaWlianpy?=
 =?utf-8?B?dGlSVjJNeXZxak9yVW1GZkZrMXR4N01rbkVvbTc2V1hVWVZkRUIrTGd5Z21v?=
 =?utf-8?B?aXZhVk1aQkIrWHpCMTRVRHhSdzNJdThDSTRXZE4zV3krSVc4bHpsOFRUZnZO?=
 =?utf-8?B?L1ZoQW9OZWVSdk9iUVZyOWFuNXI1VDNKemtJMTEyTnlneDdyVFBBZU00VXN1?=
 =?utf-8?B?MVFZcUxmUjgxQk5jODlnaTd2L1RsbWpCUjVuNmo4SGpJU1Z1aVYwdDdlVW10?=
 =?utf-8?B?YWpjTkVBdVlTVkUxZTBIVzJZbEc5THVld0FaSlF6akVzeFhEaEp5Y1J6eXgy?=
 =?utf-8?B?a3ZkREg3eEhuM3BoZ0tGRDhHVG4xUktJcHV4Z1lTb3BEbHNiajM4bXAzMHZQ?=
 =?utf-8?B?S2I2YldjK1Q2U2dDWmlnZWxYdWRjaDNhcWpMVUVCZndXOUxQeTFLaUtLTXNT?=
 =?utf-8?B?cGVCRVZ6VDNCeWZqUkViQkpkUlNkOUZUQUQ3eVhrRDFXOCs5R2h5QkJLQWZT?=
 =?utf-8?B?ckd2RW05TmJMREN6cXY1T2NOdzNBQ1ZuRGlHa3g2SStUeHZCaHJiZStRT3RI?=
 =?utf-8?B?N3Fna21xdUtRMXJIUzRlOTY2RUpsaFVmV1daRVRDK29KVEVDSXJ0TnZJalh3?=
 =?utf-8?B?Nzg0Q1dzMVBHRjJWL09Lb1lNQ1NuSERWM0VNUmMvTXd3WGdMTzVYKzhQd0lj?=
 =?utf-8?B?RXMxL1g4TlkxdG5taEJ5NXhtVzgvaFhRaWI3aWRra0pHU241WVdrR01wWjYz?=
 =?utf-8?B?YWpiY1NjSXErZVcwYi9iZ1Z5UjBNb2EwSkxyTkxDRGIyd29FWDhJQ1puMUds?=
 =?utf-8?B?YS80NkprT2lhakx4TmdGZDU1Vk8zNlZCOU5yRVJiQ01vUUJDVTZsUmJSOC80?=
 =?utf-8?B?Mnhra1dmdW9xNGJWOXZidkhDcThJWmRQMUQ4Qm4xc041bjdWNmJlajJPN2dP?=
 =?utf-8?B?Wktpc0g4bEd4MFBsak1DNGJNNFZDUHdxcDdybExKb20vYXl1TGE5eWIzN1pQ?=
 =?utf-8?Q?0oHY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1da0f4-146c-4f53-4818-08ddf0b59470
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 22:01:22.9063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+F7AaD/1A8JSdGO2xeVSOMH0xuXA7G1T0hO7x4tPM+DjT9lTGnFOqSrMOXQUkVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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


On 9/9/2025 8:45 PM, Liang, Prike wrote:
> [Public]
>
> Ping..
>
> Regards,
>        Prike
>
>> -----Original Message-----
>> From: Liang, Prike <Prike.Liang@amd.com>
>> Sent: Monday, September 8, 2025 10:40 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix
>> <Felix.Kuehling@amd.com>; Liang, Prike <Prike.Liang@amd.com>
>> Subject: [PATCH] drm/amdkfd: pass the PD BOs directly for PA
>>
>> Since the PD BOs are assigned at initialization, the placement stage can obtain the
>> PD physical address
>> (PA) directly from the PD BOs without additional lookups.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 260165bbe373..fd9cbbebbdf4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -476,7 +476,7 @@ static int vm_validate_pt_pd_bos(struct amdgpu_vm *vm,
>>                return ret;
>>        }
>>
>> -     vm->pd_phys_addr = amdgpu_gmc_pd_addr(vm->root.bo);
>> +     vm->pd_phys_addr = amdgpu_gmc_pd_addr(pd);

Does it fix bug or is just cosmetic change? pd and vm->root.bo should be 
same.

Regards

Xiaogang


>>
>>        return 0;
>>   }
>> --
>> 2.34.1
