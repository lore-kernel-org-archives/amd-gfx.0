Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF99CCF9E0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 15:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB0D410E10A;
	Fri, 24 Oct 2025 15:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wM/HKQ75";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011045.outbound.protection.outlook.com
 [40.93.194.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BF810E10A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 15:11:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgbHKCmPlL+xyKoPSminZur4cJ+JLm1XlB3i2jVP4Zd6uAvWAcPs6IdMuHfXQ/TMGVMW+EizFtahhDCYjyCTbWRq10rdoLTFeeoS7Uu0s/a73dgm+LaRohMKZlpFK5Ar0AR9RKKiTGwb9ekEkNjps5lvAAKtnah2VsBPji8LzvP0qosyvkmz4V5Qn8fCLZTjRBsRrbrw9weo07DehRt9GxwxbAQRawePGg3OcehrhvKFJmthS4ey4LmyDJdSFc9YCU+wn/hFrLf74toXiaKDGqcEcMtqUkFhxnDQufyq7yCXqlWaFyuXw7XLLc8vGoUWRok9X/xB2P6IXOHQ2Fj3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NkakBzdFGnVd0jmpIkaVykuNnAHCocuDzv4Ul3PWEA=;
 b=MaWrzBWydABRUEH/lM6SsU2WC8V3l5VUoFcv0bHAaQsdg8C1gvhCpRcOR92O47pia4GE3rhtp7+muAxA+zdkalnBax8tsaYGThCw2pL8fbPD1VW7TJ5KFqnyjYiaZor5ANF/fo9hadBX0JfOFz0r2qOktRAd1V+OHlTh2spjV6idE2YvQx7NF2q7gc4lYhBLbkeoGLCf44RlZIks2X9pCKajUJwLiJLoe5nYlnnFgp8YEXFh+1qk5apNa/jOQ0xeVNnfIbtC4PNR3MV9DKujxE6qo4yRHUnOPiSq11/TSfyprFP74ckmKHxI7Qrzy3SLtlseQh3G8upnvdYUHAvUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NkakBzdFGnVd0jmpIkaVykuNnAHCocuDzv4Ul3PWEA=;
 b=wM/HKQ75DcBtFjLgtPnkwKWIrwiWMraWyQyJNwWwudV1/4yhl03+5VSy2O0hFFSeNlCpWhWenMryPK+PVE3K12ZKzyW+wm8yEOKDjcM6kjp9wKp2XQXdF19lNAdCKbo5T6OZyA1taTCxVqoZjwzck6aTiLyNN4xGc9XgLPz9m9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:11:39 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:11:39 +0000
Message-ID: <859ab89b-833d-fbf6-bc5e-1c4786b4a2c6@amd.com>
Date: Fri, 24 Oct 2025 11:11:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2] drm/amdkfd: add missing return value check for range
Content-Language: en-US
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Shirish.S@amd.com
References: <20251024111602.2128436-1-sunil.khatri@amd.com>
 <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <9e35463a-777e-4b6b-ad31-47cd7f07fe30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::13) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e316251-c641-40ad-2476-08de130fa1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3V5L0JJU1hDWkpYY3UrZW4vMlZKZENTUXFKbXhHV1hoL0NkenpSNmNINmRO?=
 =?utf-8?B?S2hNU2hLTkkybFE0UFhsVnZ0aVdneVFUNFo5cjNyNzYyNFY1ZjhjQlB4eFJk?=
 =?utf-8?B?QVBmcmEyTzBMMi8xYnREQ1pseUVQVUt2MWhaNWlBSGg0a3ZCK3J5REpqYjM2?=
 =?utf-8?B?N1N3ek9VdlV0MlVRUHlnamlNc3pnemg1d3lFL1IzN3dydUY4YXFGb3FBNUNn?=
 =?utf-8?B?Y1NRVU0vT2pjT1F6Q2xjdTdkc1JjNkxUQmhxaWhKTC9tQVNRaGNUbUxXUEl1?=
 =?utf-8?B?RGlOVEozR3hGNzZ5c08wWGNVMURhc1NHSzdVUUI3Um1QamxqMktYLzB6aEFK?=
 =?utf-8?B?NG1STmtUb3YxMm5XcnhpN0JPWGRreDZsYWFzWUlOMXZ4VlJVeG9BM201d0I4?=
 =?utf-8?B?ak41cUhENlc1OE1OTFYrZEN3L0tZWTR2M3h4TW9UVDBIRTZ2V0VOYnNrMHd1?=
 =?utf-8?B?QUtxK2F5L0QrWjB1bTVncE1TNGFBaTNIMUhsR3JtdCtocm1tRkNNd3RLNXdx?=
 =?utf-8?B?czFsWGZaZHpDM0lnK0pDNUlwYk5nVTlQdUFReHNUdHE1ZmpnVzdMZTRqRzUz?=
 =?utf-8?B?SmhjYnNFeEZ0QWNHZHRsbmlIVVdSc0FmbDVIZ2kxam5tNGtXeWU4ZGN4UGd2?=
 =?utf-8?B?NGpQK0VMM0tydnpYc0lPYitkM3J0M3ZJeVprQ2FHL1hqRnhnWTZiMFNpV1RD?=
 =?utf-8?B?R0ZxSFRpc1JLL0wrK2Z4SWZKbnpONFVZTEg2YjJTZ2wrVWNoRDNOZ0RmNFRk?=
 =?utf-8?B?SGZvV09ZNUhDa0hrUm9xb2p5TzRWeWNDTTVTbHV3YXgrcXM4NURWa0ZxN29a?=
 =?utf-8?B?YjJMOTZrREo2QTFVT2JwSEYxYnF1YVZYTDRLeFhORS81UlBVSHFqZ2pkdkQ1?=
 =?utf-8?B?dDJTZmFlRjV4bjkxYWpMd1p2ek0vZm5jTEF2TTNCWGh0NjF0MldoM3AySFVZ?=
 =?utf-8?B?Q1FDUDBpZTNuTmY3d3BOTXZlZkxrNDVYdUZVR2FjbGRkNXdoeTFrRzkvblBP?=
 =?utf-8?B?R2oyL3FKRGE2NVFBKzVoV3BURUdGNEh6Qk9PVTczYzlnK0R5bEhMUUtSQ2F0?=
 =?utf-8?B?TFIwa05GSEJ5UHdOd3M5aDVwT2srU25DMytZRjh5MDhNVzlsMEdIMzVQd2k4?=
 =?utf-8?B?amUzVDdMM1JQcUtDd1RxYjN3UFFvbEhSOVNPaDFqd0R4b25pY2pEYWs3QlZt?=
 =?utf-8?B?U0R4T1ZIMEIrdlI4VmJkeW9WVkN4OERYaFVMMzZkZzE0M0V1NWFmVUVNeC9B?=
 =?utf-8?B?akdDVHlvRlA5NUJnbFY0ODVZcGVRTU5WbXRZbU5CL2lsMGJ6QnNtZ0xEck5r?=
 =?utf-8?B?ZmNPYmcyci8yNElrby9paTN5eVBXVlF6UEdDWFhFOUwrdDl1ZEZZdHhxWmNN?=
 =?utf-8?B?N1dMV2tLU3ZUdXphSGlMenovUGVzNkNSUzExVlJqREZvNCt1MVQyNWpKTEhq?=
 =?utf-8?B?VzAzNG5IbVRnSVRGbXhkQ1BuQ1RkaTh2TEVJTG5LYkVFRzQ2MzZZeFRqWFVt?=
 =?utf-8?B?U2F6SzdzcHNaOVFFMTFjUC9BbmIzS0hnRm15RzZkZElDZmE2b1dtMnI4SG9I?=
 =?utf-8?B?cnFwV01WUy9WOUorOUQvREpObldjZ3BJb2xmT2VwYnEyV0dGRFdOY0NQMzZx?=
 =?utf-8?B?TTBoeUJrNmh3Vm1yaHAvMVZVMEZwdnRNZDlYYm53Y2RLNTdrMDA5Q3R6SjAx?=
 =?utf-8?B?TnpKSVRveDdoVU5YeWVZVDhpZ2NPdjNubTFWTjdpRFMwc0hzUHVPdThrRFlT?=
 =?utf-8?B?Y1lzWmcwZDlhZ0tUSVdGeWhIZlJiTXRnYnJtWitzaE5tZGRDUjU4bnp6Qlda?=
 =?utf-8?B?K2w2QVZsak1kMS9keml6VTJCQkNHNi9yZTlSQ01KRVN4dUtXNW1IVVEvWDdD?=
 =?utf-8?B?WUV1YWpWNG5xdEh2azJqQ0RDMURWb2NYMHg3a0tNTmpkMm1odkY3QldJTTQ4?=
 =?utf-8?B?T1ovMUkrQXAxRXVSYlpycldTbmhCTDJzdVhMaStWa0pMVEYyMW9oMnQvV2sr?=
 =?utf-8?B?QmRCM3dlcGYrZ0dNWDhaRE1SdnRtdkpqb3Q0WWprM25yVklWTnR1cnFZQWRR?=
 =?utf-8?Q?uJkBfP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVJ5Z040bkpUYXJDZUdnQnlKUElraFhzR0dlYllMMS9ZeWFXeVdJY0dzV0x5?=
 =?utf-8?B?T3JaRFVwREtoRjNQd0dpVGNEc2ZnSCthU0hyaS9xNHBHaG56WmdzWlVCemlN?=
 =?utf-8?B?cks0TXNFMjk1bnFFUUhGQ2huMjJndW80MktlUlR3WFFUUXA2dHJJeXgwcjBS?=
 =?utf-8?B?Mm01OERMUGFqNUphRytzRzQ1VEk4b0ZUcWxtR1BpUk1oZmpoTXk3eGtraHd1?=
 =?utf-8?B?S2JCOGt3OFcxTUFvTFlvL2F2QmVxSEhyOHFpYUZudi9XVjByOU5DeEVzUGtK?=
 =?utf-8?B?WWEvQk5MNkRxcE5FM0s5K3AvSmxubkJOMnF5aUs0UHp0bFptdjRHZVRYTkpm?=
 =?utf-8?B?NGY2VUxHbnBEeXpEWkdwWm44L21RWHl1SUtVL0FtU01DVjYyVUFjcS9HZFVl?=
 =?utf-8?B?WkJYc1h0c1dGYkJsTkZvclZqL1l4M1czMnQ4UnhBOElFdXl5c2dWMTMrbHBi?=
 =?utf-8?B?Y1E3ODJXaUJQNnA2R2cvY3J6SXNCRDNEMTZjNFc2WDFjalZoMXBNYzJXaFp1?=
 =?utf-8?B?TUZlTXlsSWNCRWs0OGkzT3FMMUxGb2I5NUwvRDJYN0hTSzhIUGVmcU1LRkdO?=
 =?utf-8?B?OC9CVlc1MU9UQWpuWUxPRndYTVNIbjlQckFiN0QvQ3JSTzBJZFN1Y3RJUUNj?=
 =?utf-8?B?YWVNMjJ1TS9OU3ZkM1ZOa08rTU5iczVuOWVnY1VLR3dTc09NVlBPcWQvVWYx?=
 =?utf-8?B?WGo5UzdBYjQzeTN0QXUvK3l1NUVrZlM2anExRWJ2WUlOaGRqd3pNRUlyMm1D?=
 =?utf-8?B?d0xQTFc1LzRaZ29jaEtTRWtkbnlzN3JNR0VpU2xTcVc3QXpNNzQ1emZJNkFT?=
 =?utf-8?B?YzJYTC85T3cxYzFpKzVqOVJHbW9QekhUdXhOMEp6ekZlQ1BjeWIydlBsa05u?=
 =?utf-8?B?dkQrR0lmUXpEMENNYU1rMmlBRnVyWW5JcG1RWUVDVXJMWkRZZTBCNXNhNi9v?=
 =?utf-8?B?WWV3SElHYnBuSDNXM3U1cnJncFo1NjVidlZwZWZaVkpuRytMYmZnOS9WR0VP?=
 =?utf-8?B?S3NWakZvdU1OdnZJOGU1VFQxNzhVUDluNWZzQnkvWTVUSVZ1Vnd2K0xHYzBF?=
 =?utf-8?B?am93Y2pVZWQ3ZGZmbmgvYW5DM0o1dWx2anZ6WEs0WGZSM1FiUUYyVDRNRE53?=
 =?utf-8?B?UGVBZmZpSWVVNi9lMm0veitoZzBWRHNsVXNHcFl5NnpFL1JRZ2RFWVdycG5t?=
 =?utf-8?B?bUxsMExOM2lBTEt6UjM3eVdEamhuN25rUkl5WENjK1VpUFNRNXVoSUNEK3NF?=
 =?utf-8?B?UmJZejdQQ2xGL0h2ZTBVN0YyWGh0ZTFnSzg3dGphVW5LeUl3QitLNzFhMEpw?=
 =?utf-8?B?YVdsZ1AwNEZKUEdHVHM5bnk1eGdmaktkT0FwVUh2VGo1M3ptTktCTnlXcldu?=
 =?utf-8?B?eDFxY3lkQUhHR3ZaZTRYdU9pMmdhUjZWK3VaaTF3cytwNDdZSHZLYUk4aGl2?=
 =?utf-8?B?UnRPUmxXTE1XbU5rdElCZ3ZJdWd4alJ3K0JtMzlqbW5qYXUrQzJGZWkxTWJ2?=
 =?utf-8?B?ZFlmMG91ZWp3R1pYSFI0d1MwblBVMStKNnMvWm5tRTlCWVVsdC9RaCtZVHVS?=
 =?utf-8?B?ajlKcW8vUlEyVnh1Tzk0MTVFajlCSjlXQ0tlK3ZtWTV4aWpGeEM2Q090enk5?=
 =?utf-8?B?LzlYSSthYXpRNmQ3Q3ovTUFCYnkrWE9maUgzRFNRREtSVVVKOGZnUUVER2tT?=
 =?utf-8?B?bnVKbWQrRlV2YUJqODkza0FIcFlaK3NCVWR5bXV1b3hXZ09qZUJHM2RJcnpv?=
 =?utf-8?B?SGlrNVk4eEdTL0Ixajl4NEdha3VTanZacVAzRnN4bkdXZWhxRXVEYVkrT1J2?=
 =?utf-8?B?L09aQTdUTW0wU2lONnp2WHpmQktvbUpjUFk2ZGp4SDNhV3pZZFM5SWRaaldj?=
 =?utf-8?B?NFdQbGZobWFJeU00TVNSdml4NzJRc1VVRUo2ZHlmaDNlMU0rdG9PSXlSQnZo?=
 =?utf-8?B?MkY4UkgrMi9yTDV3QWJyUjB3anQ1TFJOOEhMSm91ZmRpeDh1MWgwQXc3dmdF?=
 =?utf-8?B?RnI5UVVJM3YyQjRMWW4vdms2VmJ5WVowcjhuWjQwYmZ2QXhUMmhGNmtiZjdo?=
 =?utf-8?B?YmpIblo3VEZHOFhpWGwzNkdGOWlXVzhpTit4dUV5K2htb3VYSnBBTmg3Y2dp?=
 =?utf-8?Q?29OVJrhUMbd6ZHb9Cvfz6CnBP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e316251-c641-40ad-2476-08de130fa1cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:11:39.5943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tc6dAm0aCe/2mQNHBJy3ALkQNVL9FBOC6exKcwNRyMBvjYOiFJVC1DXBpDjX33Nu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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


On 2025-10-24 07:45, Khatri, Sunil wrote:
> +shirish
>
> On 24-10-2025 04:46 pm, Sunil Khatri wrote:
>> amdgpu_hmm_range_alloc could fails in case of low
>> memory condition and hence we should have a check
>> for the return value.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index f041643308ca..7f0ab73e2396 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1738,6 +1738,11 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                 WRITE_ONCE(p->svms.faulting_task, current);
>>               range = amdgpu_hmm_range_alloc(NULL);
>> +            if (unlikely(!range)) {
>> +                r = -ENOMEM;
>> +                goto free_ctx;

Can not goto end from here,  this skips the svm_range_unreserve_bos. 
Just set r = -ENOMEM, and the loop will exit and cleanup accordingly.

Regards,

Philip

>> +            }
>> +
>>               r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, 
>> npages,
>>                                  readonly, owner,
>>                                  range);
