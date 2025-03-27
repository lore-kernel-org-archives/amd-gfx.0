Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02722C3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 09:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BA110E2C7;
	Thu, 27 Mar 2025 09:37:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="it9PpnFJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D097B10E2C7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 09:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pq5IZv9XslRqorX+2xX7WQAXDFkTrIdxpPlyBG2GSxQCTll9gqVn+VwYP9YbgiJfPEX5wcC8Pydd+VRYBB+xUCCiuhUcqdt903AqrXO5PNYGWtLZH7k16GGX4gTTKGhxtrdU8fXRi5416qfFxgso/ahWCTqIyMD7HzKDg6phnoHG3WLDgpF2XrOmkUJIQsRgwbYzobgKaaMPm16LkpFnCHCa4rhUx+aKCLgFCx9lglH0kSusxQIfSL+Wyt1O0FbPeQkfdKYtXjwLLJmhpxfBGzSOzv8mxk07rL9Jrs9pH+ejRRLSpbJByNATKxKpXdVpSEU9Kvr8if837+ssZix0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbjSpdFHB2hvykA77FewfWOMOL/yJm2nQKO9yZaEzWY=;
 b=qkOapycLudiyJ0eiOVm23QLCrMTW+TfJXY1/cP+MKKILtMM6eEbMvrEzTQCaNQXOTNMyWmYSNglTgfFoy1LsmiIx7a0Phq60kIoO4v5c1X5lxyYQMNVoW37ympc+DvDEBsRsRNjdviFDWVgHRzCbdF1bRR4mW7ft+WvRP8V9LK2q0UneUlLbm81Z0v9322ra1x5rY6bfwJst0VE4qkogYlAK858WbzTDWAZI0vjR5gj1rc2hahFyMan6F51ZNJwOr4WR0F52cYJ/pFLlamNt9skTVci/+Q14m1nJWAmP8T9iiQZOt1Fpfrl7HMt4AzfPys8YUEMOlBA1Yf92cdLfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbjSpdFHB2hvykA77FewfWOMOL/yJm2nQKO9yZaEzWY=;
 b=it9PpnFJ8pxlXgrJlSCTSNiWFQyaSWpjXmBAV6qPlMJLkmtP5EKLE1XG5u7sZlTBHmF1UWJ1/LahHiQjQBdp4MC2adLAt/cQNkgSvxFR7Fk0M0UoKKlz9uFZh3WlFlGwfWh0qjIg1ZWA2xX29Mra7owa10TOr5AaAxB6wxfQqpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:37:19 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%6]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 09:37:18 +0000
Content-Type: multipart/alternative;
 boundary="------------lMnMJCqm9CH2RM8OkIjEDBrc"
Message-ID: <5a04ac1b-6b83-40c4-b9f1-ca42bd53763c@amd.com>
Date: Thu, 27 Mar 2025 15:07:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix Manual Execution of Cleaner Shader in
 Gang Submissions
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250325152407.2543116-1-srinivasan.shanmugam@amd.com>
 <b30810ba-3e16-4f52-8b4a-070bda1bc129@amd.com>
 <CADnq5_PcPDULfTjtkWGXRVpuJ3Wc770Be3QjrxkRDsw1E-VUeQ@mail.gmail.com>
 <740940f4-055b-483b-88b7-072907539167@amd.com>
 <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com>
X-ClientProxiedBy: PN3PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::22) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa4c623-5cb6-4df4-b970-08dd6d12f76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTkxeHZUMVhtcDIzVE11YkFSZi9IMU5NdXFuaWRFT01reFIydThpMXFsK1hT?=
 =?utf-8?B?cEkvbWRhUndKcS9vaXU2S3ljcGUwTmo5clpBZzZlYkdjeWVBTlVGKzNSNkdn?=
 =?utf-8?B?Q2JUSWQ1eUtLR2xvcWRPWTZCYm04RU9SWlMyTlV2NVJYbm1BYmtqbHBTSDdN?=
 =?utf-8?B?VTR1ZWFrNU9HOTcxUnRocHJsOVRVSUg3R0RXVmVvR00vMVliM2VLOUtaSVFD?=
 =?utf-8?B?QzN2NldkUTMrazcyN2tNbWwvUnlVZzllS1VwYm9rM0pqNGxnZXU1Y0lHeDNH?=
 =?utf-8?B?NGpBc0hnZUZDSURhN2doaDIrbmpaSEEyWHozWDczM1p1UTdQeCtxY0JUOWxV?=
 =?utf-8?B?SzhZSXc4cUV4Qk5kZExVZm5nNjdWZ3ZSSDNRUFJVdU03SU10R3RJakM4YlNW?=
 =?utf-8?B?UE9Kb1Nkci9mVW1Pak4zYWxGS3Q0ZnY1YTlsMG5ReFo5ZUFuUkEzUUdBMzkr?=
 =?utf-8?B?SlR1elI4ZENyVUY0eEI2cjM4aS9UTzVMSDFaamdqRHFMWENJY2QweFNhS0NU?=
 =?utf-8?B?TFpzQnVMb1lXRExSeDdjOERyb2ZLcThxVUFBeUhNNk9wU2VsT2IvbHQ0dGR6?=
 =?utf-8?B?ZXMrZnl3SW44UGt0Rnp0bFp6V3lkVVJDeWNUUjd4dWNZZG53KzZUZGgzcHoy?=
 =?utf-8?B?UUxJY25IRzRwalpOUUNtS0c0NHcwQ3VpRmVvSHZRNGlDUXNvemRtczRqNldq?=
 =?utf-8?B?VVRJSFB5MHY2OFFDbW1KOEJ6TU9FM0JRN3ZSbzlSTmNBY1ZVUFQ5QXN3cVhU?=
 =?utf-8?B?bk8ybDVrSFRZNnloak9KYUoxZWZYcXF5bVFBRmNhQlpuMDg5bmxRY3plOEg0?=
 =?utf-8?B?V2FlZ3ZtYjFvbXVvQXJQczVMYWl2c3hLcFRQOXlVblk2Sm8vckFZamdkRWhW?=
 =?utf-8?B?ek42c255SVBuSVlyUnl5dnJWR0xSazB1MUd2TEwxS2N5cC9pVjh3YXRUMGM0?=
 =?utf-8?B?b0Q4M1pFKytLcjUxTnI4RUM3b1drYTJmV1ZxYVo5RVJoT2l6VVVLbndmK0li?=
 =?utf-8?B?cjdLRnRFZnA2UWhrMXF6M2pwenNNQUVrTkx3bWdpaVVTVURvNFRRR1k0bHdL?=
 =?utf-8?B?U0ZHZjlHOUF1N05UZy92dm1aVldwS3NyRkp2ZCtFRnA0RWRtZFM4NFZXWFUr?=
 =?utf-8?B?aTYyTk5RaUJZTUQ3VTZxNVRaeEZySTQ3bEw2djVlOVNEa3NidEZsOGZJaFVk?=
 =?utf-8?B?VERHTVNYbTFBSjJIREhUR0ZGRjRNSk5mcWVqSGlvdVBldHRNYmp0SG5lSnhW?=
 =?utf-8?B?Ni9VNVFqYlV2OUY1UC9PZGZLSjZsUjVVZzdVczFNYmFGS2ErSDJ1MFZReTJT?=
 =?utf-8?B?MGRKQWJxdXdqampnQldGZTNWTDhGSnlRcjZpbkVGOXFJVm83bU9wQTF3czV5?=
 =?utf-8?B?Ymc5TUZJTFhWdzNwVGlXaUxGemE3YlBmYklkVW5YRGxZek9rUEdvTTMydEU1?=
 =?utf-8?B?YllIdTdSM3lCTnJXRm1CZ3dNZUlHKzJmSHU1SGpEWHBKaG11cEZZRGlrbU9U?=
 =?utf-8?B?bHBmQStsL0w0ZEZnKzRIdWpDRWFMQUs4NnZieDFPSWhzVEJPMFhTR2poMDlE?=
 =?utf-8?B?TGYxcnNoaVFpTlJUKzZPdjRBSHp5dkZBVTcrQ29yaVp6cFo5N1pMSlJYYVVY?=
 =?utf-8?B?STdzRkwxR01UcFdhSVdrOFVLU05iS2RMVllFd1Z1Z05Fcy85Y0pnV2hXLzd0?=
 =?utf-8?B?NUM3T0FQUVBoR1Ywb01vMnNLRUoxVGdrRHErQURCTlJ5YkhoNEpGRmV0TlUy?=
 =?utf-8?B?ZXhVekJOa0hNdzZVUXhIVjdKM21kSjdXMnN4bjkyNjZxRU9YeWttMTZZVE9N?=
 =?utf-8?B?MVloa0E3bjIrcjY4ZzZKb0tYY24yYit5YURWWTFOdTBkdW42SUp4SGJwd2pF?=
 =?utf-8?Q?Lv0zjE7djKaod?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjNweU83M0ZKNkIzVHF3VCtaMHFLRmE5TnZVTTB6YTZnTWpCWUVHejc1Q1RI?=
 =?utf-8?B?S2N1Q1didnlaRjhvaXpjNEwrOWpRMy8yYzAvdldzUkpEVzVHNjlpSmY3VE5L?=
 =?utf-8?B?MkRpUEw0aVNvdE5BdjRXNFFMeXFCTHNyZURZS05Qa0xaYTNKQ0NNaVJWN2xa?=
 =?utf-8?B?UVY4cnFBU1JBZFdiSWorNnFNeDhNaStuWTZHQ09LaFl6ZzRhbWEwZXVyQkt4?=
 =?utf-8?B?NFBIa09ZVUJFSmYxK25LSGNFWnVMckg4QXlrWlc0d2Mrb2FZMXBERjdydXdL?=
 =?utf-8?B?WDNkMVdPWkZFekx1eXNMTkp0bkU2cXIzbGp3YjhOeGsxemhabmFJTFk1ZlBn?=
 =?utf-8?B?Y0kvUlpOcE4vZCs3ZDdIb0lEb2F6blBNUlkxNzNGOFdNdTAvSUtlVnZMaE5y?=
 =?utf-8?B?VnFvOTlZWDVHSWVlQW52S1FJMHdjQThKbUxLNGNtalNIdU5sZHc4NFZLWWEy?=
 =?utf-8?B?UmVzWjVaaHpDR2VGUFk5RmVOVVRwdDB5TlpUa1BUSkxKcGFkRmNKMHFsVUpI?=
 =?utf-8?B?MkszOW9LNVB3bXBGWmp4QlFHNklOaWZ1ZzQyRFhwbHg0NGNBU3RsMU9mSERE?=
 =?utf-8?B?VlBSMVlJYXZ4SlpHZnZObGdaQlU4ZmtDRy93bW1ldzFBdklmcndlcm8rVlBT?=
 =?utf-8?B?eFk0T2Y1VG1ycFRKYmJLdDcyVGV5Wkt3OXZzU0JFVHhOM1lybzZ6TzU0WWF4?=
 =?utf-8?B?b2loeUFWZmpXaDRFWmZIa3YvZVoxN2p5eW9GcDRjdStsdS9OdWw5QTVXY2VX?=
 =?utf-8?B?YnhKdlFDSWJkaTA1eVJ0NFdDUEhSTGMvWlJ3eWVpZ1d4a0pNSkUzOWhmUlVp?=
 =?utf-8?B?RWRGVWVON0FHV2J4WlNFdmdCV2s5clRwWmVjTEpxMlcwaFVYZG45N2tUNkc4?=
 =?utf-8?B?TEw5WC9uT1dzWjVHaTNPS3F6ZVlnOWs4aUtkZGdSVW9kaUxKQWdnKzYxQXd6?=
 =?utf-8?B?cDkxZ2xEK08zN2R6NUNkQVYzbksyOEhQWmRFNFU4bDQvNURxUFY2TStzQjZF?=
 =?utf-8?B?YjQzaGJkOHovY2NaeWxuS0xDTUlqU1QvcDNFbThJUEtmOWxYS3NCSjBuTmsw?=
 =?utf-8?B?MHhzbmczY25jdVFCVDcvSGMvbjZEUVI4YTVsT1FXMW5HZ3JvUVQ0Ym1HQUtx?=
 =?utf-8?B?YVludEl2NHJlVmI3S2xWaXllSmRiaEZRdVlFVUl4b3RZc3VyenUzVm0vUXBk?=
 =?utf-8?B?L25nVHB6ZjU4NEE0MzBKN01mUDUxQlRpT2tBMWo0SnBsYlQxSGt6M2xGUTZB?=
 =?utf-8?B?SXRTZWFkbUc0MUxKRE9HZk9pN1lURC82SC9taytHUlpUclliK0hNcUdWYTBm?=
 =?utf-8?B?dmY3QXhJUXpOdmVKbTlyRllWVVBoMlVwQ1dTMkJDaVBQWWdJV2IvU0RGTlZx?=
 =?utf-8?B?bFQvZnBoN3JtSkpJclJ1YVZHS2oyZ1FDRDhKKzJNL3cvT0FzN3M4VUsvMXND?=
 =?utf-8?B?K25yUjlxNnlsYm9vZXoyb0JWcGI5WElSeUF6eCtsczFvSk12OEZlVG1iNngy?=
 =?utf-8?B?ZmVKOXBLMTRyWjhmYTc4VHVkQktjVjE2S0ZVRGwvTjdRTG9USzdWaEYxaUtx?=
 =?utf-8?B?RldPZTFjdzVJUFdVV0FoL3laYTE4bWlwQlA3MHVycTlPWnRpc1piT0swTVI1?=
 =?utf-8?B?UHh3NDlzQVFWK3JCWmlNR2RkR3dzSTRIcHZPbFErZ1J0S0xrTVNicUtiNUMx?=
 =?utf-8?B?d3hYcEZxWlptU00vSmtCdVNFYS9TeU4zK0xYQTdWUnNocGtLczY4L1lIdTlp?=
 =?utf-8?B?NkVpcEJUaUM3LzM4bmsxYnVJbndXRzFsZk1uNnY3b3Q3NGZmaENETHIxbzVH?=
 =?utf-8?B?dWpUaFJEY21qMUtQdHZIVjAvU3dVazA1K2VJNTJiK3NLM3dXcTU4TU5lczBR?=
 =?utf-8?B?MVFQNUJHNGxNNy9CVExiYVFzcWVqNmk3YjBHMS8xdkZ4K24yYjVNUmJQVEZI?=
 =?utf-8?B?MEFDNG9WK0Q1L1FKdTRHaFR5ZnJYeG1nN2V0bmx5a3VTQ0diNHZmZTFwZVVw?=
 =?utf-8?B?WFFUSUZyams3Y1hWb09Nay81SUF0dXVqYTFpTTFOODRsSW1oNUFWeFpEQWJW?=
 =?utf-8?B?K1hGOXFxQ2tVbjJsSVRHdmlRRDZSWU94ZWtpNnFKd21IeHc4eExHbmZVVU84?=
 =?utf-8?Q?ahRthN/ONR17z8egYtYXxoat4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa4c623-5cb6-4df4-b970-08dd6d12f76b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:37:18.7415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIFiKtT+vDvb/Hg9WWIYS9fZRLWA17pntNmJQw9Nx0xUlJmao3LAvfSiEdCu9qmf8c39+EJ5P2F9kCblL66ABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

--------------lMnMJCqm9CH2RM8OkIjEDBrc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/27/2025 2:54 PM, Christian König wrote:
>
>>>> Over all this change doesn't seem to make much sense to me.
>>>> Why exactly is isolation->spearhead not pointing to the dummy kernel job we submit?
>>> Does the owner check or gang_submit check in
>>> amdgpu_device_enforce_isolation() fail to set up the spearhead?
>> I'm currently debugging exactly that.
>>
>> Good news is that I can reproduce the problem.
>
> I have to take that back. I've tested the cleaner shader functionality 
> a bit this morning and as far as I can see this works exactly as intended.
>
> Srini, what exactly is your use case which doesn't work?

Hi Christian, Good Morning!

The usecase is to trigger the cleaner shader, using sysfs 
"run_cleaner_shader" independent of  enabling "enforce_isolation", so 
that cleaner shader packet gets submitted to COMP_1.0.0 ring by default, 
without prior enabling any enforce_isolation via sysfs,

AFAIK, this "isolation->spearhead" initialization is not being takencare 
in this *path **"amdgpu_gfx_run_cleaner_shader -> 
amdgpu_gfx_run_cleaner_shader_job" (ie., when we trigger *cleaner 
shader, using sysfs "run_cleaner_shader"), and this check 
"*&job->base.s_fence->scheduled == isolation->spearhead;" * is having 
the problem ie., "*&job->base.s_fence->scheduled" address are is not 
matching with**"**isolation->spearhead" address, which results into zero 
& thus fails to emit cleaner shader, when running using 
"run_cleaner_shader" sysfs entry, **in "amdgpu_vm_flush()" function
*

Best regards,

Srini

>
> Regards,
> Christian.
>
>> Regards,
>> Christian.
--------------lMnMJCqm9CH2RM8OkIjEDBrc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/27/2025 2:54 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com">
      
      <br>
      <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
        <blockquote type="cite">
          <blockquote type="cite"> <span style="white-space: pre-wrap">Over all this change doesn't seem to make much sense to me.</span>
            <pre class="moz-quote-pre" wrap="">Why exactly is isolation-&gt;spearhead not pointing to the dummy kernel job we submit?
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">Does the owner check or gang_submit check in
amdgpu_device_enforce_isolation() fail to set up the spearhead?
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I'm currently debugging exactly that.

Good news is that I can reproduce the problem.</pre>
      </blockquote>
      <br>
      I have to take that back. I've tested the cleaner shader
      functionality a bit this morning and as far as I can see this
      works exactly as intended.<br>
      <br>
      Srini, what exactly is your use case which doesn't work?<br>
    </blockquote>
    <p>Hi Christian, Good Morning!</p>
    <p>The usecase is to trigger the cleaner shader, using sysfs
      &quot;run_cleaner_shader&quot; independent of&nbsp; enabling &quot;enforce_isolation&quot;,
      so that cleaner shader packet gets submitted to COMP_1.0.0 ring by
      default, without prior enabling any enforce_isolation via sysfs,&nbsp;</p>
    <p>AFAIK, this &quot;isolation-&gt;spearhead&quot; initialization is not being
      takencare in this <strong>path </strong><span data-teams="true"><strong>&quot;amdgpu_gfx_run_cleaner_shader
          -&gt; amdgpu_gfx_run_cleaner_shader_job&quot; (ie., when we trigger
        </strong></span>cleaner shader, using sysfs
      &quot;run_cleaner_shader&quot;), and this check &quot;<span data-teams="true"><strong>&amp;job-&gt;base.s_fence-&gt;scheduled
          == isolation-&gt;spearhead;&quot;&nbsp;</strong></span> is having the
      problem ie., &quot;<span data-teams="true"><strong>&amp;job-&gt;base.s_fence-&gt;scheduled&quot;
          address are is not matching with</strong></span><span data-teams="true"><strong> &quot;</strong></span><span data-teams="true"><strong>isolation-&gt;spearhead&quot; address,
          which results into zero &amp; thus fails to emit cleaner
          shader, when running using &quot;run_cleaner_shader&quot; sysfs entry, </strong></span><span data-teams="true"><strong>in &quot;amdgpu_vm_flush()&quot; function<br>
        </strong></span></p>
    <p>Best regards,</p>
    <p>Srini<br>
    </p>
    <blockquote type="cite" cite="mid:fc461f19-44b8-4699-b3e6-c37e1b7dc76f@amd.com"> <br>
      Regards,<br>
      Christian.<br>
      <br>
      <blockquote type="cite" cite="mid:740940f4-055b-483b-88b7-072907539167@amd.com">
        <pre class="moz-quote-pre" wrap="">Regards,
Christian.
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------lMnMJCqm9CH2RM8OkIjEDBrc--
