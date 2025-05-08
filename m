Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA24C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3621E10E0C6;
	Thu,  8 May 2025 09:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2w4FLOdC";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F9610E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:40:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzmnPUpds9ZFVYzyacwQ0IhAGX/5fpuWaE/JbOqdEdc7OAH2SKvkeC9/GzzSQcEsGDLWthNOHKtXW9irB2p7iO9mv0eG9hANIlYVjLYl77qcDdayV7vKGThRmPyVHSWaJqM7jnUSteBzwkDK93bihmdNKBlxjIlRwMmkIUL2JMUV5mHHcG024xKCq9JAq/ZRLN9Ip6jYzqfkNLDXBYZE02batPdqqDcqK3A78b7detp60mGRKdwaSXj05SN0K0Qvm0Gsvgup7hikaR7RciqvrfU5bjC3J8bC1KWYLx7CkEFimZtuowtNWjMXw0yKU7iGECOXiMGMZaiiYH1+Wxj3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mU8rtUCSqSolZ7HPUzM/6NFFzSN+cmoJ9K57HM+NybY=;
 b=YKMBz67nLR0xVe6P4epxs79BSBOcI3cowiw5qjN3/QNzp8Kbi4UJtnByKtxxRILE8VYNU/MuLFctsHOIctuLWXfOsb4T8MfqGd/hK2ThLG7Qox8f7gAphAMoz9kV70mAvhxIA8GYGoh8JU1ygdxV1GXVvLlexR3fyLH70Awk6WNMsib3v7c47XiqXYTsJ8udcG8L1cJ2uuhU1LmXH/saQK4d5SNCS8IrQPDGcMFoC3FeSzqddQIIFt5QpT5+0S8l6fi1o3aUYrE2Uqq9k6TDph7SLMsg3jWIaaMvJkL7liyltm6cSszqJuEu+wdIa/qZ3QuL0poVBWANbvT0Z4qcAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mU8rtUCSqSolZ7HPUzM/6NFFzSN+cmoJ9K57HM+NybY=;
 b=2w4FLOdCJV2wWa1223tfbwHk2K0oqIXCt7pHursZ+pzgQbYfvjUsH6fwJaF90ZzAVWCfkYg3nkEh/taODIjGINEF23PB1y8jXOANZWHzCwQt8dlmwRtJIi+n3eX50kgunazH8wdeuJva0DD0e6/jyIjj8UZvSdKk/ygBqbCq09A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4136.namprd12.prod.outlook.com (2603:10b6:610:a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.30; Thu, 8 May
 2025 09:40:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 09:40:07 +0000
Message-ID: <cbf48eb1-cd47-4851-b307-ee3cc65d4ed7@amd.com>
Date: Thu, 8 May 2025 11:40:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-4-Prike.Liang@amd.com>
 <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
 <DS7PR12MB6005615C194915A4C862CBF1FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
 <3747fa9a-032d-45fd-969f-d4744fa4b466@amd.com>
 <DS7PR12MB600529CF3069303E7F088C35FB8BA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB600529CF3069303E7F088C35FB8BA@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4136:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dcac52-6170-43f0-b943-08dd8e14519a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0U4blZEcjY1dHIrMDFHc3pLZFFOQzZ5Q1h3ZHg4cEZpN0IyQ0hIUlpWVXE2?=
 =?utf-8?B?ZUswaVZuT0Y2cHdzTFQyZ095VVgvYURnZnkvTUtiakUrM2FJMHdmRXJSUjRR?=
 =?utf-8?B?NGgrYUV1M1dMWktMeDNNQXM3R1UyTTUyMGxTM1M2NEdaT1lzUDFRZTBYaW85?=
 =?utf-8?B?WWtRQVc3VGNhbXJ4M25kdk43TWZqaXh3OFZPYWZDTnRpUVhaeGp1Rm5VdVRD?=
 =?utf-8?B?WHROcWJ0blJydEttY3NSS1Q4eUE1bG5NY1o5MjdidDRQZzFYSk1wNXVJQ2th?=
 =?utf-8?B?YWc0b28vOEdoQkRKeExjUWMveVlxYXk0bUlKM1F3MnVJWElKbVBxOTJzdFdN?=
 =?utf-8?B?R05NUTVYTmhWODVLcmNMYk16MHYwUVlKTmszQ2pYS0pMekhJaEp5YmZZVXZY?=
 =?utf-8?B?RDJkYXMxTk9ueVVvOFNQUTdFMGRXY0ovOCtXTmxsdGtLT3p5czFUbXFVd00r?=
 =?utf-8?B?cTQzQ0tFaXE1K0UxZy9xV3RYSmZPUzVUNkcyVFF3YmEvZU0zSkR5U201dmt4?=
 =?utf-8?B?VUl4WnZYcGU5bjdWRlJYWWRlTjlpOTFKckFQcE83VWVYY2dibHJGcU9NT29S?=
 =?utf-8?B?Q2txaUx5SFdLVVk1RmVNSnpNRkpzRXBuK2ZTYmF1OFJrc2lBb3plVFRsTnNX?=
 =?utf-8?B?WkkwQlRGQ3lqZkVsTVB1ZkNpcG91STdnZS9jWStzVWE5VVJUMWdZU2FLTUoy?=
 =?utf-8?B?Z0tZTnJxbG80UDBMWm96Mk5PZ2ZVWTVibzVkK1B0UGx4WWFxZU5LMWlWYkcy?=
 =?utf-8?B?SWs2UC92TmZFaGw3b1pnUVBTR3FjOUxpVUl1Z2ZhYnJtUmNpOGpPVnRkbExq?=
 =?utf-8?B?dUxxanNXQjl0SVpWYlhFVFo4d21SRXFzZVlYeFVVMVhMNkJvb3F1ZVRTUXB6?=
 =?utf-8?B?M2pTbnVKTWUzcWxTWnBCYmVtZWJmK1IyUFdnUXV2MkZOZCtsRjNrMTRsS1JE?=
 =?utf-8?B?WlZDM0FoWHZSb3ZCcTRDdUF0YkkrOWM0bzNuTm5nNDhuR2RmUUp6b0dkdFZK?=
 =?utf-8?B?TDBTUWMwemdidXVtN002RWhTT3pkZURlNDFuYXlSUTVMTmNFN0NWSmkrMVlt?=
 =?utf-8?B?TkI3S3o4SDEraTJYRzR5NXlLY2RObGk4Q1NkV1VPQVN6RkFvWW1BZ0pKb0k2?=
 =?utf-8?B?SERFcWpKNjh6d3ozQ1V3UW9XYnJiOVMwWGNPWGlMVjlZOGlVbm9pTUJWL29r?=
 =?utf-8?B?Nzhyc0NhcTlDNWJmWlJnYTA5M1lzN2hkc1lZMm9HR1QvTEJORW41RTE4VldS?=
 =?utf-8?B?NGc5eHJiL0VwNUduVlA4Y2Z4bW4vSG9PYkdMY2lINHpFNHd4K2Y4Qi9oK3FQ?=
 =?utf-8?B?bHNQbTc4UEJ1cXg2WUM0WDhKaXdtajJMVk1IaWRoS1lrRjYzZjFBS0lNM2h1?=
 =?utf-8?B?MFRRZ0dZRnc0cndwNm1zUlFwSFFqaENvQWtwSTYzbzVSeTBja0g2cjNoQU9Y?=
 =?utf-8?B?TDI2bktsY1JDNGdtOEMwblFCTFJmSU93WE5WL1hnOEdjOXZjT2ZTakVWWTdk?=
 =?utf-8?B?MkxzZ1RUZHFxNTh4VVdtbEtPNUN4bjNoczh2cU1pR0NKWnl4a21aYy93T254?=
 =?utf-8?B?VjIvQ2hvbWpoR0ZtRm8yVVhLV3JOU2ZJS0orNVBzcEk5TEt4Z2FIMm5ROHg1?=
 =?utf-8?B?UkhTS3BlRy80L0RvTzBVdGRjTWFrcFRqa0N0TEpleFVDTG83ejkvb0tQTDdF?=
 =?utf-8?B?a3RvTkhpYldhdFJyK1JDUVNQQ09GOUpQWFBZTzE0NFBiMnJOdHNTeXBpZEpN?=
 =?utf-8?B?bk1ndjNuR0xkejRraTVkUDN0ODZMQzBaUlo4bHhXMnh0MHZKcjZmSHRDaHBT?=
 =?utf-8?B?NjJZZzRGbHBON3Z4anE5eTBvRXFLWFErS3Awb01PaFVQZHdsZ1kzQnZ3Vk94?=
 =?utf-8?B?NnhEaFprUkZQWUpuaFczbkZ3RGl1dnBjdldsYnoyd1g4Q2FmSHg3MUdjTWRo?=
 =?utf-8?Q?Pc64jwW9TXw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0taYzBleGdNM1gxdXNodTU0aTk3bXFkbTVqcXZJRHBrQ0RBS1hOcCtpWmdT?=
 =?utf-8?B?N0FtZ09nUm1BeWdaRktYMGxZdFRobFcxbEhQQUw4eFVLNUdOaFhHWG1tQzhO?=
 =?utf-8?B?Q29NbUpqZUFwVlArZXVyaW1aN3M3TWtiSlFYSUlTUXdRNUNvMkh5bE9aaDVK?=
 =?utf-8?B?V05ZMUtNVkszRXBZTWZjb1doYStUWDVoZTJBS0VPcmFOWnhnaXp0bXY0T2dW?=
 =?utf-8?B?M2NtUzlMZ3diSTFXelpFRXd0eWZEeGsvZGVMV2RybXMxZkVwT2FRWVlmdVJF?=
 =?utf-8?B?ZGVJRGJRWUo1RjFWdTJkSXJkZ3g3T1FzbnpyaG1PeHlqSFMxcXZxeW9BQVJ6?=
 =?utf-8?B?ZGJuZUU2KzgyRDdNYy9ITGFMMWlhbGYydU1ybFcyM1ZpM3lEcHBVaHo4Uzdw?=
 =?utf-8?B?aFhkU2ErK3YyK1daQWNiOTR2UXZ3Y2RwSDZpbmt6UzlXdCtEOVlTZ2hua0c5?=
 =?utf-8?B?dng1eUxSemgxbC9manFIZEpYZjU0YVh0dnYzU2lZNTFPM2NKZWlIU05Gc1lS?=
 =?utf-8?B?d1VqZTBhQVpmVllyVmNjRW0yTHlOdTEydUFQclRML0w4aGNIYVRMN2EwNGxF?=
 =?utf-8?B?ZDc5MjJPK2JXYlhVR1hNS1NscU5BNWRuMWV4YnlOM0pZVThCUkdGeTN4ZkVx?=
 =?utf-8?B?bFNGSG9SRjhqaUxRTFVTVU1GdVI3ejdkRFZXZ0U3OXNLK1FMR0tsaDRCTmND?=
 =?utf-8?B?SW4rQjlDODh3Y3BObWE4S0NEK05KSHM4Q3UvWlF4YW1ENzd1bytvZDlGb21K?=
 =?utf-8?B?a1dHVTNUVXlPSmN4d0xlLy9pakpFUzV5RHdabDR1N09zdVhGRkh1cTgwRTFJ?=
 =?utf-8?B?R0JxODVsM3doRm9sS3BKcmpxcWR2eWxIOFBXSGp0ZUZSV2dtaGVHdzd5WFkv?=
 =?utf-8?B?UGtybHBWQmRyV2ticGNDNG5JeU1lSUlLdGo3aFdaK2tWQk5MRDk4TUl0KzdV?=
 =?utf-8?B?cmVPdCtFOXRZZVpleE9EL085MktIbEtCT2VaMUE4N2Z3aVVjK2ZlbFkzOWpi?=
 =?utf-8?B?eStVdWpPUGpGUlBjb2FrajNHTXBpL0RpQ1d5bjkyRVJvUFR2MFJSZU1OU1dM?=
 =?utf-8?B?LzhaOHdaRFBZWmFOVGN4S0hoaGpFYklDRlhXRlFYWm1wU1FDc0hkbXNSZGxW?=
 =?utf-8?B?RE5LaU9pcDdzSFUzUmxhZzlmcGdEd3FqTkdIYUgvUkF1aU1yczV6T0FKRVFv?=
 =?utf-8?B?Y2RwS3ZoYUEzOWk5bnNCYWN2N1BUL1RBaXQyWEw1RkF3T0gxZVloclFyYzRr?=
 =?utf-8?B?azQ1YTU2QjZVbi9tSVhTL0JEeTFvSUJQSWVzMU1rQWZiaGd0UFhXSkNZU2Fv?=
 =?utf-8?B?UUpYK3c5SzhIN2gwSlkvTGZpTDNVb3hHdWlpNUh4MVcxVWhtSXpUcWdjTDd4?=
 =?utf-8?B?Zk8xazdpakNKS052UytSWXh6bTEvdUpwSXFObmxpVyswVXRlc3c3MmNrQ0Vh?=
 =?utf-8?B?TnlrWkdFV2VtZ05pdEJTRXlObDNkZGZjUEFtKzhCMW9hbjhrN2JzM0F5UU5t?=
 =?utf-8?B?MVoyTS9MU0Y3UFdlcFUrODU2WExEQ1haK283R0lJcDl0S2crVlkrbU5jVjNH?=
 =?utf-8?B?clp6Wm1pS3ZzaS9wQ1daOEJaY0NzaStlM01FY1FIRVNHL1JGdHpnM0JscFhJ?=
 =?utf-8?B?QithaUxJN2hGQVgrMHpkRnhQa0szYmh4VkFPYUt2c0NIUkhGVGpPNGlqMnlX?=
 =?utf-8?B?Mi9vbWxIWVNFRUdEMm9PWHIrS1lBdlVuVTNiQjlsQ2hZRE9Oelhpb0RIOUdz?=
 =?utf-8?B?aHA1NklvK3RMQlJKTjlCZXRRNHlmeFhkZzg1cmFYdUtaWUVvRGR4cndzT2k2?=
 =?utf-8?B?RU5nNG1yUDJxVG42NW4wQWtDWTdHdVhHOUVZOExhazRnbDUzU2o1L2xnQ3BC?=
 =?utf-8?B?WGMzb0tvSEsxbSsxZ1o5RWJ1cFhFVDZueVhhTzd1djF6ZjFEcWUxY0pwWnpX?=
 =?utf-8?B?UnQwZUZWRk50M1Y3bC96Mlp0MkE0WTZaalN6ZnE2VDNsQnRlaXBYb3lyeWJH?=
 =?utf-8?B?bjJXb1JvMjZ2dGpYamlOclB1MjlQc2FBQ0tmNk9yTitmWHJHeThKMkdxcTB5?=
 =?utf-8?B?S0hHcjNTSHJrWkwySTE1TFNsMVd5NFU2WnNvNjVhdHBhMkUxQzU5dE1Jbit3?=
 =?utf-8?Q?N5LGt1lt9BfVbEij4j3cH4+3a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dcac52-6170-43f0-b943-08dd8e14519a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:40:07.7939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLu7YSFEgEQ13rUNnYZ2G8HA/3G64Cuh2e2h5JmRvTOMZ/geUzE1TiaDQ4H/d0XF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4136
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

On 5/8/25 09:08, Liang, Prike wrote:
> [Public]
> 
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, May 6, 2025 4:39 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
>> attaching/detaching
>>
>> On 5/6/25 10:22, Liang, Prike wrote:
>>>>> -   /* attach gfx eviction fence */
>>>>> +   /* attach gfx the validated eviction fence */
>>>>>     r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
>>>>>     if (r) {
>>>>>             DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
>>>>> +           amdgpu_bo_unreserve(abo);
>>>> Adding this here looks like the only valid fix in the patch.
>>> As the eviction fence will be invalidated until the user queue is created from the
>> user space, here it requires validating the eviction fence before trying to attach
>> and detach it to the reservation.
>>> I will try to draft a patch for validating the eviction fence at attach/detach
>> separately with this attach error handler change.
>>
>>
>> No, that is clearly incorrect.
>>
>> See the eviction fence works like this:
>>
>> Validating thread
>> * Create new eviction fence
>> * Publish eviction fence
>> * Lock all BOs
>> * Replace eviction fence
>>
>> Attaching:
>> * Lock BO
>> * Attach current eviction fence
>> * Unlock BO
>>
>> Detaching:
>> * Lock BO
>> * Unconditionally detach all possible eviction fences, no matter if new or old.
>> * Unlock BO
>>
>> This order is necessary or otherwise you break the logic here.
>>
>> Any additional check will completely mess that up because it makes the operation
>> racy.
> As the user queue eviction fence doesn't create until user queue submission, the eviction fence will be NULL without userq submission. So do we still try to attach/detach the null eviction fence for the kernel queue case?

Yes, the problem is that we can't check the eviction fence before we have taken the reservation lock.

Otherwise it can always be that there is an eviction fence created between the check and attaching it.

I also suggested before that the eviction fence is never NULL, we just start with a dummy stub fence (see function dma_fence_get_stub()). This way we can avoid all the NULL checks.

> It's ok without validating the eviction fence or userqueue work before attach/detach the eviction fence, but it will cost cycles for walking over the reservation fences array in the dma_resv_reserve_fences() and dma_resv_replace_fences().

That's completely irrelevant. Important is that we have the right sequence to not create a race condition.

Regards,
Christian.


> 
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Prike
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>             return r;
>>>>>     }
>>>>>
> 

