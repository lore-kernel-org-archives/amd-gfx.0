Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AB1C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 13:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3778510E03C;
	Mon, 28 Jul 2025 13:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ETQnJdF0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3CF010E03C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 13:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTFIUT2OM00q+SKcmo69sC2IROYHiSJTo373a54sj1ZmSVVNKyL3lec8enOyKFInTomm2ejug/SVTj/k/lz00mA+lQZpqFtTSMgDTuDal/QTyQyt3gSqIdtCgUJHPpOQWvhjyxiqPpedzFXm+6jDgmZqCGoxNw9vC8xrliexTxPgwQ2pUbzQGi6l8BDvfBqEtDAhv1MlmMTHuzfoAVTLEa6E3x3YPYN7AgrZF4T9EBmrCqZzN4B6X6xbdG+LnHCQ3YJIbrkBezLjvTCOlh6RnvSDE+8pbFjzv3Bf6M4zLOuWy6tyUes0zcfunZxnhZhM90fNAcbVVNm3VAAgUWZo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Add2UZylu4u7KVVsFlZN6wbgDPkzLx2rWIOg4p3SaY4=;
 b=fA8Vl1wkPUSTmYdbjumDTO56bA1UEPDlRECJsl8b56BEOhzThiqe5c25taHkquKpoDBGTuCSpcOGSs3kxTfAcJksMcYOQTZXbgj0O0CKgPP5iAN6JUp22jYsLodp1mGcfzDFzP84hz7uA7zorWW6rMKjrki4OjaSCEjVxP1Rz0BSL8kU2QTkN+zjVvW2CLD/kq0QUMQFMgkXCsXcZpnGG4Xe1yRzxHj++q0yU6K72T6SgmoCUZa+gHb65bg7RTA8MH7Pk1VnOyjZJm6jfWAJXu5QSg5tTqPZwPitSGQKTt95hMdo0lJinnUX+hwNBJfpQ6BQNrs4T6g2tg6C6LEjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Add2UZylu4u7KVVsFlZN6wbgDPkzLx2rWIOg4p3SaY4=;
 b=ETQnJdF0BB0dhGrFtttAncJRqyWwS9Vq5KsSU2ORlEZ3jCL97yNkUr7H5104HzbaNopvVSNh2TkO4A3S+9MLIQctl0eH5W1QJg65IcuDIAZa6FscnvPmO4g7h7vSFwSPlKPgOq/q4tGe05IJgbQIFwJSXSqJrEJlV3+UBJCEqjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:30:15 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%6]) with mapi id 15.20.8880.021; Mon, 28 Jul 2025
 13:30:15 +0000
Message-ID: <adfb335d-7f5a-419f-adad-3263fd4b346d@amd.com>
Date: Mon, 28 Jul 2025 09:30:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] drm/amdkfd: return migration pages from copy
 function
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com, christian.koenig@amd.com
References: <20250528171908.82639-2-James.Zhu@amd.com>
 <20250722125950.7574-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20250722125950.7574-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::37) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc39287-ce5b-4dac-cc3e-08ddcddae289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDBqWHVRSkI3WWFtWVlsZVpKMml0WGNXS0ZoZmt0OXhoREpNaUF2eUN1M1g3?=
 =?utf-8?B?TTJSVkR6QXVYZWR4aUlWanZrWStUY25SZnlLc1kzZzg3alorSGRId0xxVmF0?=
 =?utf-8?B?aE56aTQwYVlqd2pOcHRSSURwaUdLdkF5enNENEZjRm9vbk40NTNKdEhNNkxH?=
 =?utf-8?B?b3F0WURrVVVwYkI4akUwYlV2WFpGY0JQYmNCdWtGZTJUS3pIR3ZaVkJDLzN0?=
 =?utf-8?B?OGM1UmNWcFZ5SHVaNGZYUFF2ZFZXVEVmUkljKzFVdGlDWkhYRjBxaDViUFox?=
 =?utf-8?B?YWxKMEd3THNsNHdER1g4cjIvaUZ5NXFNVEZDVkduSGN4T3h4ZmZTVWN0cU40?=
 =?utf-8?B?R3BsdE5La1AzaWNlaXE2Q21vVTk3NTVsLzdPRFdvelkzakVrYnpWLzdRT05v?=
 =?utf-8?B?K3RWVmdmZklGbmJST1I2Y1ozMVVQWEp6NytkWXJEZjJqNEhuS3ZGTW9pV0ND?=
 =?utf-8?B?a0trcmU4R1U2TU1adDhhZmt5WmpsS2lTazVscjB0ekRrekIveko3dFhTOXNM?=
 =?utf-8?B?anl1Vkc4a0JzMXJ1N3hzcFVZelM1eVd4Lzk2R2JQL1JQUkxFQzI4emlkM2xW?=
 =?utf-8?B?dXhGYkpIT1ZLdHdOcVQ0MG1QRlZFL3BiaEpGQ3U2Q1FlWW5vTTFVZ2t0VG1y?=
 =?utf-8?B?Z0FNTEVRbWNkazJVSlk1M094NTlWcHJOUlZWZEVqeS85Y2VVc3pWdHpYK3VU?=
 =?utf-8?B?Sm5ESjFyclc1VVhTSWZSYnJYM0Q5b2RlczRJWldmQ0ZPZXJKM1ovMkxJUkkr?=
 =?utf-8?B?RU5LNFU5c09CakdsZXI2UHhyOXQwa0o4M0hHVWRnZ0lyeHJkaVV0bjZYRlJs?=
 =?utf-8?B?YWZlTm5xTW8rT3Rla1Q2ejAyMG81UEs5QTNGWHRCUDg1ZFJXZWlQS1dGVEhV?=
 =?utf-8?B?V0tzbXBPeE1sSUxXWkpoR3lsNUtjWE16OThUaFZQOXhZNjZ5ZUxwR2l3M0RD?=
 =?utf-8?B?WHcyejVpa1o3aVpRd0ZHWGQ4SGh3QW92OXp3OCtHeFlOVGtUd3liSjdvRmxO?=
 =?utf-8?B?QjJJUjVSemFsYTVyZm4ybjZwekluWmkwdFVrdVhaanBMVUU2Z0s0MkQ3YXAv?=
 =?utf-8?B?MU9QV2ZZc3EzaFFubmhFMWJHUkhKbTU5NWpZU3JqeWkyaUJzRThKR3Y1MzlX?=
 =?utf-8?B?dkhobXptRDRhMHVzaWJXV0RGY3BNSGRrQzAvdDBSN1h5Mkh1ajA0NFVqNm5i?=
 =?utf-8?B?TmM5b3RDU2lTVHluSEgyL0VQR0VQRk55MjgyL2xMMzFCck5sT2JhYnk4d29V?=
 =?utf-8?B?cjNpMG4vRzJlU25IRDM1TlRueHltTEM1WUZhTlpYaXRhYkZSWVRVSVZFN0F3?=
 =?utf-8?B?OGxKNnJlZnV0SzN1RnZuYU1hL3FMYWIwQjN3Wmp3TWxCN0g5eEpuNkpXOVJN?=
 =?utf-8?B?ME9ETCtjNEFSd0t6bjNLbEg1QlVsRTRmTVU1TGdhOThRTXNtWDJZaGNZOW5C?=
 =?utf-8?B?a0V4YVVkSVhqYmNBd1NQc1hHZDNldldkakxDNENBeXd6SXJ1SE12aUZmMW5M?=
 =?utf-8?B?R0V4NG93Y1NLWTFEYitobTY4NXMzL2tLbHFnem03aVFMVVhIU0dHbWNGRlBw?=
 =?utf-8?B?NXV3OEY5QU1laUpUN2g3Y01rVGhRUDZVS3g3V2pmR0xHTWIwT0RTOHhpam40?=
 =?utf-8?B?cUZ5NkdkSDQ5dVdGQlpnVXVoMjVRRU14dFQ5a2ZKSkowMlpUSWt2OVhnOVJa?=
 =?utf-8?B?cWQyOHl5Z28zL0NMallQQTlZUEJlTlpIMHZZbWtQWW5CNy9vWWRnazhaVVZv?=
 =?utf-8?B?cWhPejdKRm4wK3BUTEVZMTNEN1dJQkd6dkV2RkliY292SnY0WDAya0VMcnpT?=
 =?utf-8?B?NFBoM2VqU0YzNjBBT243RURuYVY5QmFSZ0t0SmZaOEhna0dWV3RLcWNKK3U0?=
 =?utf-8?B?VDUzck1PeTFUQktYZUl5OTdNZmF6aERyMFg2dmJTUXN1MW5QdGVJK2wvQ1ZF?=
 =?utf-8?Q?Y/cGTWSPYnY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE9XMDBsZDhhQ05wYml1VEp0aFIxVHVURTRzaFdqb3NhS3pQNEpSc1pFSGxK?=
 =?utf-8?B?MmZ3V1VGNUJFZ0hZdXZuTHlXUytwN1VDK3owSHdnUVAydlVCVjNiK3JJOVdt?=
 =?utf-8?B?UVBRdVNQeHQzeFJEYTducWZiTWZaM1NIUXdxUXZ1eUxVSWpTc3NEbHBSL1hQ?=
 =?utf-8?B?R05USFZBRHRUbUN3KzVuRTZaSjVLMmJJeElvSWlUS2RkcUtOejRvSlFOVVlG?=
 =?utf-8?B?VDRSS0laRnU1L0ppT2hkYmdsSHI5aVIwZ0wzOG1POExDZ3ZnU3RQRG00RUc2?=
 =?utf-8?B?cnZYWDBpeG1yNmdvT1hldklDMEUyeXp6TGRMbTk3MUhZeG1STWN4eHBpNjNr?=
 =?utf-8?B?NkEwRVh6NkxNQStaSkdMRGxJODRIY0dvSWFHczJuMEpSUTdwSkxXM05zSFpS?=
 =?utf-8?B?R0hqUkUxMTBkUWJMU29tRE9WNk5OQ0drVXpraDhNV3ZaVWt0R0Y5WFNxRHRR?=
 =?utf-8?B?aXFReGh2SXpucWtiem1UOUh1Z3RrU2M3Y3FMQTZjNVE0Zis2aHdzRGRsRWE4?=
 =?utf-8?B?aVRxeENnbnRacGQ2Z2pwRVliek5ZR2l4WnR3YldqRW9GNmUvaHJsUVZZamly?=
 =?utf-8?B?Y3VnUEVScXVRVXgzbFBxZHJ6YVBWWndBb2JIYVMyclMxRzlWeW9QYW1QZmJu?=
 =?utf-8?B?OUNpR1Rnb3J4dERNMXVoZE84eGpPUkhGM2lTVjBPNDlmT2FSVDUrZ3FUT2tp?=
 =?utf-8?B?eUE5cWRBa0Y1eXdBSkg2QUtkR0ZlYnJ0bFV2cUpzOFM5Y1RmUitSY2FocHQr?=
 =?utf-8?B?dDFoOU5oZlpRSFEvbjRmanBkeGl1anZnN2NLZUZoUG1yeUFqNDlMVVJ2cGtT?=
 =?utf-8?B?bWJQbmE5b1V3SDh3TURGcFZ1TGJsM3BPSHBnR1NJS000cFpDQVhuMUdXcC9h?=
 =?utf-8?B?Qk0xdEhxRWl2YzhLQzZ3ZVl4NXJWbXRMOTY1QmpqYnhiTTRkRUlwTGE5Tnhy?=
 =?utf-8?B?ZlBVVjErNTFETGE0dTVSMUFiSDFUeGhreXhqdjdFUGJkRlliREY4MG9vcmds?=
 =?utf-8?B?MjYwc084RGd5OUVINzBVQzZ5TDZwQUZIL0diT0pPZ0dGek1uNFB5T1NYQXF4?=
 =?utf-8?B?L1lzTGpKUGxoS1ZSeWU3eUh0dUNxZitHSmF0SCswVTQyNjhYaUw5dDcxSkJn?=
 =?utf-8?B?UWxSVlVaUzV0M002OHF4STE2ZWJUR3B4aG95dklrUU00aXBMM1VPeXpBN25C?=
 =?utf-8?B?cTM2M2h5S2dxRmQvOTVHakdpOXZTWHVxUi9PVFZoYkY2WVZhVVd3WVE1dDVI?=
 =?utf-8?B?N2FSRkx5UGtZMzhnczlYd2ZxWFJ3b2ZvNmNCYWxsdUpoOFZHeEFhWkl2bmcr?=
 =?utf-8?B?U1ZlVk1PY3dSeXZ6KzBtS1JHY25hMFJEZFd4WTFFUkU0cklLRmJoQ3ZkbVJy?=
 =?utf-8?B?T1N3eXQ0bWF0K25VRWc1NGlVcCtrY2RaL3ZuRlVKbEwyeW42TVY3cTlCZStP?=
 =?utf-8?B?OVQ5akZwcE1CbDIrQWQ2M0g3dEVXM3VMVG5LVVA4V3JtRHptem9PR21uVFZC?=
 =?utf-8?B?czVSTHJIYWJWRTJhKzNYT2dtOCtUZDBxT0NCS3ZLc2haTnpWMUlNMElyVzVZ?=
 =?utf-8?B?ZUJuaHUvSFhpMTRkYnE4bmxxLzdDSVE2NEFGckdRSE5XT1oyekxNUlk0VnVy?=
 =?utf-8?B?MXRJdERJL20vQXdkTTNQZXJWK3FGVDRST3Bsb3dGQm83VUZWN1lKN2c1a1Zx?=
 =?utf-8?B?MVd6NGxBdlplTlU3MmxxRkRzNUZBN0xyaENaOGphblNUdE96bVZPUFR0cWhm?=
 =?utf-8?B?QW1NL2E0VHhDMnBsbS9EQ0twcDkwV1RXNTNPeEVRb29ldGtIMHZUenQ4NEdS?=
 =?utf-8?B?bE1nSUc0Z3V4THBmWEx4Qzl0M2U1cW1XQmI4akFFbE1NbVF4ZzJFMWJNMHhj?=
 =?utf-8?B?WmRzaGczT01XMGgzUU1ocFZxSTM0a1hiUXVQNWZzUmVpVnFvL1RVMmRwdXpI?=
 =?utf-8?B?dTJvaTVGazg1eVlyay9TcE9hQW9GeFhHZGR6UmdmUTNOY3RoVmtPT3dSdzFY?=
 =?utf-8?B?TU4rd2U1ajY4WEQwemNHOFYzMTE0SmRRakdEUWt3UzdmZXczU1AwVy93OUt2?=
 =?utf-8?B?SlhuQy8yZ2ZkblZqMTdwdmFmN0NTUTR0N0IxcmhlRWNBTUVYRFZmcTN1UVll?=
 =?utf-8?Q?vupq/+Rq0nw6zMDx0eleXlY47?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc39287-ce5b-4dac-cc3e-08ddcddae289
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:30:14.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNeLQe/4RncKRCx5XZ4UiOTnyFsOvIY0QCk/Rl2uHiG5G0uY2HPUL/fJrEfsFKH8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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

Ping ...

On 2025-07-22 08:59, James Zhu wrote:
> dst MIGRATE_PFN_VALID bit and src MIGRATE_PFN_MIGRATE bit
> should always be set when migration success. cpage includes
> src MIGRATE_PFN_MIGRATE bit set and MIGRATE_PFN_VALID bit
> unset pages for both ram and vram when memory is only allocated
> without being populated before migration, those ram pages should
> be counted as migrate pages and those vram pages should not be
> counted as migrate pages. Here migration pages refer to how many
> vram pages invloved.
>
> -v2 use dst to check MIGRATE_PFN_VALID bit (suggested-by Philip)
> -v3 add warning when vram pages is less than migration pages
>      return migration pages directly from copy function
> -v4 correct comments and copy fucntion return mpage (suggested-by Felix)
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 72 ++++++++++++------------
>   1 file changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..5d7eb0234002 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,20 +260,7 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> -{
> -	unsigned long upages = 0;
> -	unsigned long i;
> -
> -	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> -	}
> -	return upages;
> -}
> -
> -static int
> +static long
>   svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
>   			 dma_addr_t *scratch, uint64_t ttm_res_offset)
> @@ -282,7 +269,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct amdgpu_device *adev = node->adev;
>   	struct device *dev = adev->dev;
>   	struct amdgpu_res_cursor cursor;
> -	uint64_t mpages = 0;
> +	long mpages;
>   	dma_addr_t *src;
>   	uint64_t *dst;
>   	uint64_t i, j;
> @@ -296,6 +283,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   
>   	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
> +	mpages = 0;
>   	for (i = j = 0; (i < npages) && (mpages < migrate->cpages); i++) {
>   		struct page *spage;
>   
> @@ -356,13 +344,14 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   out_free_vram_pages:
>   	if (r) {
>   		pr_debug("failed %d to copy memory to vram\n", r);
> -		for (i = 0; i < npages && mpages; i++) {
> +		while (i-- && mpages) {
>   			if (!dst[i])
>   				continue;
>   			svm_migrate_put_vram_page(adev, dst[i]);
>   			migrate->dst[i] = 0;
>   			mpages--;
>   		}
> +		mpages = r;
>   	}
>   
>   #ifdef DEBUG_FORCE_MIXED_DOMAINS
> @@ -380,7 +369,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	}
>   #endif
>   
> -	return r;
> +	return mpages;
>   }
>   
>   static long
> @@ -395,7 +384,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate = { 0 };
>   	unsigned long cpages = 0;
> -	unsigned long mpages = 0;
> +	long mpages = 0;
>   	dma_addr_t *scratch;
>   	void *buf;
>   	int r = -ENOMEM;
> @@ -441,15 +430,17 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	r = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
> +	mpages = svm_migrate_copy_to_vram(node, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +	if (mpages >= 0)
> +		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
> +	else
> +		r = mpages;
>   
>   	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>   
> @@ -459,14 +450,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    0, node->id, trigger, r);
>   out:
> -	if (!r && mpages) {
> +	if (!r && mpages > 0) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_in, pdd->page_in + mpages);
> -
> -		return mpages;
>   	}
> -	return r;
> +
> +	return r ? r : mpages;
>   }
>   
>   /**
> @@ -577,7 +567,7 @@ static void svm_migrate_page_free(struct page *page)
>   	}
>   }
>   
> -static int
> +static long
>   svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct migrate_vma *migrate, struct dma_fence **mfence,
>   			dma_addr_t *scratch, uint64_t npages)
> @@ -586,6 +576,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t *src;
>   	dma_addr_t *dst;
>   	struct page *dpage;
> +	long mpages;
>   	uint64_t i = 0, j;
>   	uint64_t addr;
>   	int r = 0;
> @@ -598,6 +589,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	src = (uint64_t *)(scratch + npages);
>   	dst = scratch;
>   
> +	mpages = 0;
>   	for (i = 0, j = 0; i < npages; i++, addr += PAGE_SIZE) {
>   		struct page *spage;
>   
> @@ -646,6 +638,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>   
>   		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
> +		mpages++;
>   		j++;
>   	}
>   
> @@ -655,13 +648,17 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_oom:
>   	if (r) {
>   		pr_debug("failed %d copy to ram\n", r);
> -		while (i--) {
> +		while (i-- && mpages) {
> +			if (!migrate->dst[i])
> +				continue;
>   			svm_migrate_put_sys_page(dst[i]);
>   			migrate->dst[i] = 0;
> +			mpages--;
>   		}
> +		mpages = r;
>   	}
>   
> -	return r;
> +	return mpages;
>   }
>   
>   /**
> @@ -688,9 +685,8 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> -	unsigned long mpages = 0;
> +	long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
> @@ -744,13 +740,15 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages collected\n", cpages);
>   
> -	r = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
> +	mpages = svm_migrate_copy_to_ram(adev, prange, &migrate, &mfence,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	if (mpages >= 0)
> +		pr_debug("migrated/collected/requested 0x%lx/0x%lx/0x%lx\n",
> +		 mpages, cpages, migrate.npages);
> +	else
> +		r = mpages;
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -763,8 +761,7 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
>   				    node->id, 0, trigger, r);
>   out:
> -	if (!r && cpages) {
> -		mpages = cpages - upages;
> +	if (!r && mpages > 0) {
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
> @@ -847,6 +844,9 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
>   	}
>   
>   	if (r >= 0) {
> +		WARN_ONCE(prange->vram_pages < mpages,
> +			"Recorded vram pages(0x%llx) should not be less than migration pages(0x%lx).",
> +			prange->vram_pages, mpages);
>   		prange->vram_pages -= mpages;
>   
>   		/* prange does not have vram page set its actual_loc to system
