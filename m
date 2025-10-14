Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BEECCD18E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F48410E236;
	Tue, 14 Oct 2025 19:46:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZLNw+plE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A71A10E236
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q40H/69Yh3EJOLQSboC8EBuDRhMaX1phEfK4EfgcYWkE/aZkbF7HJS+J1hz6wGoFsvVzpNqSQlnXQid82Izu/aZ+yJ55oD/Khf1CMrnu6FS+mrolZHuX9FJnYgGsr6c4AyIMFPFUFpSNPodKEps5Ycsb+TtqPX1vB2647hTHGkh2FOASdi+N+PQ0hwH+WgZBRb63fJw32nTwwgTnwp4Oj5RfnzScAQhJTmEny6GcnyCYS3XlGaaE4PxrKGgobc3Sf+Lv5rNqTRZ6Nk6kyZYQNDc9apQze2Skut/vFdYRBvzpUYc7U0z5Fp/5eb2xBxa3taMJvcEzDKqPgAcStH2iOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVlzCkriXwAINl3589R+PP2RjjftOLYM3+cswAw29g8=;
 b=ZDInPoWvRDRtu5zuGmZwGQosvP15ewsdxgu1bK7cyxT/bew9r1XYJo3Ug/b1u/q6DDK+sFo51KHpeOuu/9oXysgnINiUrRgyn0XQ+AWI90QnGOqn2CO0BjtwFNBSOqUYjakWpZO9idRzYwB8xQLx9CkV/KMtgRAMkwe10UillEQobWxB+rAwob1aUix5fbl6kay3EEMS3tcU3/MCSRPBr86cWIMIQMUQGJP055uJoodZJIQRaWvqTR65QizUYMg2NSMfB1vf15qVX406n4xls9jSA5fRR0irkTC2J2yWY8CmLbvnj4Ub9KNSodFXxsWteE7SG1KZKoZtgmqggJ96aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVlzCkriXwAINl3589R+PP2RjjftOLYM3+cswAw29g8=;
 b=ZLNw+plE6sDec9FCCPLaQG+Y+Gq0zBZj3yvZ6zQrT7FU+ZRSFqWwmEL06OXRZ7vWUt0cP2AkY7rdgginGR7blGqAYLWTlgQQHK2PPVfmMC9v1y0JOTiYQWPNqzyA901+66Q5i/clXIArS2NLfdr1x6bohDZR1lyc1ROx+PsnwYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 19:46:24 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 19:46:24 +0000
Message-ID: <d79b9ae7-f444-4d12-a494-f67feffdfca4@amd.com>
Date: Tue, 14 Oct 2025 15:46:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix false positive queue buffer free warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251010193348.23271-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20251010193348.23271-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: a34bd556-e0b0-4540-ec7a-08de0b5a5b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0xYSmc1WGRQOE5PMjhOa3ZjaktNNnRZQjlpaStiTE5IMlBoZ3Z6M1ZET2Jr?=
 =?utf-8?B?R3NiUkFBY2oxUk9ERXpVeTJ1V2hoM2hhR3dvNXhnTGEyVHBCbWc2S2FmRnY0?=
 =?utf-8?B?ckRVYytFRlVaK2l2SWY2eFN3Zm5yMTJkSFZQK2tNRk0vSXRQS1o1bXZaeitD?=
 =?utf-8?B?bTVEMEtES0pHOXdpV2FQbHFEdDE2MnJtQ0VyaUsvVHNwbmtrejR0eXYxMmxn?=
 =?utf-8?B?RmhUTnhiN2hhZm1UUmZ3aHpXU2pPWG5XYngvWm9CZUNMQU9uRU50ZjQyalRi?=
 =?utf-8?B?TXJiVnV6dmVhR3NBWTJ2cUhnbjB4UVh0a1ZZaVFzbTZBUGZjcWtRZXVQT29i?=
 =?utf-8?B?cFV3SFFGZGY1d0RicVNUWitMUG0ybVFSMFdiMkJWM0dSK0dwaDhESE5oL3lr?=
 =?utf-8?B?dmhVWlFoK0RGL0lLVjRrTVZXZlVRWnN0SFQ1MWFsRkRCU2RnNjBROFZhak1a?=
 =?utf-8?B?MDBnSzhBRnhtbmNscHkzTVd3SW1KUWwvZWdrZ2FSTGRzaU1nVHVKa2dnWk1C?=
 =?utf-8?B?ODhEQ3lualkwQTZoOTY4dWFKdUhxcTZ0SmxDa3NNbENSbnNQQWNEYTdKUFc4?=
 =?utf-8?B?QUFhUXZHY3d1STNTZHhaL0kvZEdmZVhCYlM1eERxdFFKQWp4akxHSTB2dG9h?=
 =?utf-8?B?NGFKelAyYTBIWXdGaDRDWFpGN3V1MnRDU0hORVhBTTdKWE1FNG1uaHdXNFUw?=
 =?utf-8?B?YmRvelhxbVVDR1l2MjdkM2VWQThvRHRxYnBVMVlrTWRhYU4wMWcveGNNWUUz?=
 =?utf-8?B?UXdQcVF4azFRNXpCbjhXY3FFT1dqWW0xaU9LVzZiNjVUdGU0VGZzQnhFU3Fj?=
 =?utf-8?B?aHpVbjBNU3h2enVxWjloZk9GVEZ2M0VZbFdhRGNCc2NpblFLeFpNaVkvMm4x?=
 =?utf-8?B?YmZ0UksrZmQ3T1U4MkZtWU5WSFhGTmVLbVE4bnp0dmVZVmVuaUxQYXkrcnhK?=
 =?utf-8?B?RGR1THRjRnBhSlVja0s4MTdPeDhtbnBVcDduTUhJNjlmTVRsTlpNaXdVNFlJ?=
 =?utf-8?B?clJ1bUNVUSt5ZUV2NnVZUlpoekNoZS9NWjZ4N2F6R3RQQU5oYkJuUi9QMk02?=
 =?utf-8?B?WS9KU2NNMjlrOHpOTCtVM0RkdWJrWEFidFJ5dmJqSW96SWJsSlJjWmRVVVhF?=
 =?utf-8?B?Z2tTS3hhUUFkTmlrekxaYlJ0aWJFYXdycllMR2tEb2RyZ2hhVm9rNmdFR1J3?=
 =?utf-8?B?dFNPYmtnRWVwYVd4b1Y5V2g0UENHMVJ4NHJva090eEFXMkJvRUQ1Y0oxRWEz?=
 =?utf-8?B?VllaVEhNbE1yZ091akIvVWF5VW1uNS84SDI1Um4yVDNnTVAxMmRpTEZPWHB5?=
 =?utf-8?B?cVBKZWxoSmY2NUwxV2VjdjhQSS9NVzFlUWFieFlFNkxvWWFkeVN4SEh3UUI3?=
 =?utf-8?B?emZ3QUVIRDZVMHh4T2hUUndkV3krcEdrR3RUdml6Tjd6UTRaNDhEWTI5bVdM?=
 =?utf-8?B?ekp6MnlsOVB3aWNOQ2RkaGtSbzZtSFkwdkRqUENPN2N3S09ub1cvUWc3cEdL?=
 =?utf-8?B?V2MzQUdsYUFpZnN2OVhLYjM4UTJ0b2lBSWp2VW5qUUx6V0pFUWhHRDU5dDkv?=
 =?utf-8?B?dlFINkx5UHl0NUcwRmxqVEJtdXVVQ2MwQmZGYmJRMlpuaUVLTEF6UHovczNB?=
 =?utf-8?B?aEZ5ZHdnelBCd3lHT2JBcWEvaTk0Z3k3blYvTHl3MGw5SzM3Vjc0RmtpWHQ0?=
 =?utf-8?B?RG05VGxKYlhSNWE3bjgzS25YZVB1ZHI3RjFvYXlYczg3VnhGVHg3SHZ0V3o2?=
 =?utf-8?B?dG8xUzJQMVFRcXhrdExibjNCVy9aU3lMejU0a1Q3cVBUOC9oUU5VM3U3RUox?=
 =?utf-8?B?bExmcVlPQSs3SVBBbkUrWGNhYVVsNTR4OG9aWlcxNzFheXRma0pUTE95SE1n?=
 =?utf-8?B?dlVyeEJORnkwbld6QVorYlVVQUxhVS9OYzFxY2JYTUxhdjBYTCthMUZ0V0ww?=
 =?utf-8?Q?BIM0xgdeexGKr7nM8u6pe+zn5p1J2dPh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2U2SFVLejRTNDIwck5ZOUFUbkVJZGYvb0EwQ2cyYjdsVXk2c0c2YWpBd0xM?=
 =?utf-8?B?blUvZ1phOGZUR0pmNnVveGZaR1VvZHVsbmw1NktJRUtTU1RTd25la2hmSGVC?=
 =?utf-8?B?OEx3K2VkK0s3Uy9Bck9nZ3lUVzNJU0pmaXJDQWtmbTU4Mm01TFJZVU1QRmRr?=
 =?utf-8?B?b1c5dDEwUHN2azRTUHNCV01xWU9KNUJXNnl4M0JiRnNPV2pvRUNhREF6L1Rm?=
 =?utf-8?B?Mm4rYUZTTUJHTUVYRWlBYmpyeTNjdlBJNXdCTmpGcUpSUXBMNkRXQnVwZnY4?=
 =?utf-8?B?ZU5WZE43L0lrbTFVR3Vzcy94ZDRKeEdrM0RNOGl5L29uR1Vac0FqRXdkcVA4?=
 =?utf-8?B?NFRpRDhjeTJwRTVvUTgya1huaytjblRvUFhaRjh6akViUU1DRTg3c0R3blZI?=
 =?utf-8?B?ZkREeXVDVmxwWFlBMnA1R2N3RTFkYnNWSlpjQlpLcE1XUmdDQjVJWUpXSGZ0?=
 =?utf-8?B?S2p2ZjZxOG0wQm9PUGQ3c0psR0c3VVE0a2JkYmxkRncvYmhJZmNpQ05CZnRJ?=
 =?utf-8?B?QTE0WjJrL0Q2emZnZTBwNXM5YzlKZnpTdUcwd1RvazdWc1ZGSUZUSVZtL1NI?=
 =?utf-8?B?aWlyWjRKWExQbDhYaEpDbFhwZ2dDUHBKK2c4NUVLUVM1M3g3TVJ0ZkVBRURz?=
 =?utf-8?B?WUcvNytISzNkVDBRbzdEZktEYStqUVJQQ1lkSnNvaFJNemt4aTFNYlFnZGVW?=
 =?utf-8?B?Q0VDY3JWZ243MTBCSzdjRVpkMU94dXlHTWo4bnpwUHB2T1B0TVRRTVQwTGVy?=
 =?utf-8?B?U2JLTkcyUFYySURyaEp4bEhLSnArVElDSVhKV1dIL2w1MmF6N2FUT3VLN3Fh?=
 =?utf-8?B?azdiZDVhNGlFSWlXcU1EdzdUdU14Skp5Rm8zSG9VWEQ0TWV0REZxSHRBajdU?=
 =?utf-8?B?T29maW9tNnQzNnRnNDdVQ0dFQWxaUE8xVzJtcXRQYk9WUGtWc1hUTUQybDZp?=
 =?utf-8?B?aHE2QmtQbDB3RUpsM2UvbFR3UFJobSsyTW1hRHFISE9kZkxnMmxQOC9wWlVm?=
 =?utf-8?B?RnlVWnVTUFhwN2c3MDk2eUJjbXg4VS91c1kwSU9PQjJGM2x5U0RPc2UvSnFF?=
 =?utf-8?B?VlZwc2VKV3NEbzEwVG11a3M3NXdZdG1wVHNSbjJJOEFwSFVITG9SUm5QYm9k?=
 =?utf-8?B?L0ljZlcwSFhqcGkxQURMSVp4d2tzZHQ1ZkpiMjh6VVFUa3RFVmxvdlRjYWND?=
 =?utf-8?B?bGxLVDZJTzV2YVFFSmVpVnlFTVRrN3dIaVh5cFFLSXdML0hPK3ovcmRYNmhI?=
 =?utf-8?B?SU5VTmdJVFNsZDdXNTFpTGRoQytoMGFPTDl1TDBpUkl1VVM1bU1BaEQzR1hr?=
 =?utf-8?B?MGRuQ2Z0MFg0aFU1ZUREM09maFpydkgrcXo4RjVQNU5hN3BJdThnSGZFMDU3?=
 =?utf-8?B?d1JXdkRBQkUreWZSVDZsYysxV3RPYXJuMmREZktMNkxOK3crMGhZNFN5czEr?=
 =?utf-8?B?VFFRVUR2SzNtVVJGTitXVVE0engzcjlIdGxNc3BDSHJHemdQUDZtaXUvZVB1?=
 =?utf-8?B?YllGSTl1L0xMZnFLNGJoQ0pKYjVadnVnaVRqWjVLd1RiaTcyRVR0MDJlSExn?=
 =?utf-8?B?OE8xYlhXTTZvdUkzWjRSem1taWtlVW1ZelcxVVF4WllJZG1mcXNMZUtxMzV3?=
 =?utf-8?B?cXE3M1BwMTFsN3lnQnJSRnpuMmQ5RG9hYzFaNExWREE5TUc1bC82Wk1ncXRx?=
 =?utf-8?B?b0VxaXFRSlFZdUdyRkZPSWZraU5VRU5Dc2N3c3kxVk1RV21iNVI2NklTeUJ1?=
 =?utf-8?B?eFJFZlBSYnd5NEgzbzlnbHBSQ2F5dWxQUVR5dTFFeFFVT1A2cnQ5TVR5eXAw?=
 =?utf-8?B?NG9abVN2ZktSUDk3RHlQa1hoNzJKWThUbjI5Vm5kUVZxMEgxaWdVendhUWNu?=
 =?utf-8?B?b2orZFl3YWhLL1N0cEcrWnNXSCtQQVlRS2RCelQyUmNqZUZBWTI2WVdXRGhn?=
 =?utf-8?B?MnF0NXhqYWpabThyRWtUOXMvZGdyZTU2UFBFb1lCazNETC8wZWlpUVZFSVh3?=
 =?utf-8?B?eTFZcWdTQzNkemtYdmRoOHZqc0o4em51dktWMkk3aGlhWEVmSXM2dmE3VVU0?=
 =?utf-8?B?RTE0T21ENllXdjV5U2NCemNjWFE0bWdaNVlPd3BxYWt2S1FEYzRVTXZBamdn?=
 =?utf-8?Q?wj5SCRp0odAUQbO2xOihIdOOD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34bd556-e0b0-4540-ec7a-08de0b5a5b2b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:46:23.9390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iRxKdwNjY9ZTesPSQN9dDJpJnBOPnruPCMFKWA1m100v8bOYvRW4KyvGf4Bt8ORO/fbteFIUR797aFOfxnhBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
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


On 2025-10-10 15:33, Philip Yang wrote:
> If active queue buffer is freed, kfd_lookup_process_by_mm return NULL,
> means process exited and mm is gone, it is fine to evict queue then
> free queue buffer CPU mapping and memory from do_exit.

In that case, kfd2kgd_quiesce_mm will also fail with -ESRCH. I'm 
surprised you're getting here at all. I would have expected the queues 
to be already stopped when the process is gone. But it seems that's only 
done in the kfd_process_wq_release worker. So is there a time window 
where the queues are still running, but the queue mappings are destroyed 
and the queues can't be stopped because we can't look up the process 
from mm any more?

Maybe we need to stop the queues in kfd_process_notifier_release to be 
safe. It should only need the DQM lock, which should be safe to take in 
an MMU notifiers context.

Regards,
   Felix


>
> Only show warning message if process mm is still alive when queue
> buffer is freed.
>
> Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 48c9a211e415..9174f718482a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2487,17 +2487,26 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>   	bool unmap_parent;
>   	uint32_t i;
>   
> +	p = kfd_lookup_process_by_mm(mm);
> +
>   	if (atomic_read(&prange->queue_refcount)) {
>   		int r;
>   
> -		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
> -			prange->start << PAGE_SHIFT);
> +		/*
> +		 * Evict queue if queue buffer freed with warning message.
> +		 * If process is not found, this is free CPU mapping from
> +		 * do_exit, then it is fine to free queue buffer.
> +		 */
> +		if (p) {
> +			pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
> +				prange->start << PAGE_SHIFT);
> +		}
> +
>   		r = kgd2kfd_quiesce_mm(mm, KFD_QUEUE_EVICTION_TRIGGER_SVM);
>   		if (r)
>   			pr_debug("failed %d to quiesce KFD queues\n", r);
>   	}
>   
> -	p = kfd_lookup_process_by_mm(mm);
>   	if (!p)
>   		return;
>   	svms = &p->svms;
