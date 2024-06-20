Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559BAC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 14:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E6E10EA3B;
	Thu, 20 Jun 2024 14:38:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wnwnVbLP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B435B10EA3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 14:38:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYoM3NdDfYFRC+SriTIl2V5KMZFWzesMgfx9wcnkoVRpr7kn7n+MWmVdi1+E03SCpZgvPZ0BEH32SUW7w2EIYOaAMIcZyMWZjWyyf5p7aMbySs47BvDIQz9j4HH/qy2FMTLfmlONU6ADam3B1YtQ9aFQAQ9XytPHGNyFaE4sJlS3LP2YenG16yu0CU6XiU9AQQ0/j7Qkr7IdfumbyPOpH6KBmNcc0ge1Z8PsHduLJBDyv7VklGAbKyeChoqpsqpmw0GnCn8WplJwRL57DOUcrN+vHpHeQIwfchAKSoo2hYqEE0tGVf6cclIm6IczguLn4SyAV39GYdhjlbpgtRUbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3PJPGBo8noWGuPU5o/Py8IKKpJGue4LN1p88Q9l+Qs=;
 b=FctwuR1fwHlgmu7JbSDqS3ij+XZlugcbuw0la4mFjnIDhCv9iAbZnvUqRu75HHXqlVwdLeemUJrvXKpkNCoKvy1/XVeYJ7R3vt7uFRWMRPpdB2R0Xl0+WQZTmfxMmH3jk7nWhUGFhGKN+/hJLtX5LiwRxCUoXDgTExgSdIcEDOCSklZCVCkQ5tFYX1g+5dOwGUNNsuUOGuCHimikXL5Vbze0+rIuqp1rU3O8LVYnh3HZQc/iq9pKl1+odPn19tz+2huu2N/walmAf6Mxw9OZa4WdOKopZ2tubLnjYA5Bbw0Idg4dHQyyYTvseMkYLs8pNZaYWnAYUefXTUYyQUveEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3PJPGBo8noWGuPU5o/Py8IKKpJGue4LN1p88Q9l+Qs=;
 b=wnwnVbLPlsjthVahwbtiUHRuOr/74tv4G3qteN1AO5gKlT35XBeOWVXg9q1rJbJpdZtInSACEeniXjbFBsh3RHvXf/leOyrLBBrgwDobm8lBZtpDVgCJNPH2EheYo7BsARIjHrvXsDOxLPkE77HQmOpdUDagcMXq75tgBTr0u/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 14:38:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 14:38:21 +0000
Message-ID: <bb43f31b-f9ae-4742-9256-b7d6187b4ed1@amd.com>
Date: Thu, 20 Jun 2024 16:38:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: track bo memory stats at runtime
To: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240620003014.21453-1-Yunxiang.Li@amd.com>
 <f56fc803-dd1a-4dd3-a06e-d268fdd76e1e@amd.com>
 <SA1PR12MB85991FD8CED8F54570069464EDC82@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA1PR12MB85991FD8CED8F54570069464EDC82@SA1PR12MB8599.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4a4bc5-7e7a-4b5c-503c-08dc9136a225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDdpSytRODU2Mms1ZWZQbVpXcW9ZS2ZETTJVa3g4dUgwMDhUVGFENjlFcGd2?=
 =?utf-8?B?NVhLTCtSQUhzMXJ5R1kwbEJlWW9LMHdnUlRKSGNoTWZXY3p2cWwrZHBkWUw4?=
 =?utf-8?B?SVN3Ykh2SXQyTkVGY1UrRjgrUUpxL1kxUDBCdnFIem1TWVhoSVNuNjBVK21a?=
 =?utf-8?B?aDR5b1Zjb2NSdUIxYXRxWDlZWTRhRG9zR0h1Nmk0dGdCTk5yRGVJQ1YrVGVh?=
 =?utf-8?B?MS82bEFkZ1M4RFg0SmRadXY3STI3SjFNVGhybGpSaTZjcVhheWVpeE9Td1BD?=
 =?utf-8?B?UWxmN2gwMUdwV1JjQkhUWXZiak90TWlhRGplWU9CN2N2RDJvMFppNk55WG4y?=
 =?utf-8?B?KytJRDJzMTN0WDB0dEFVK081NzZjVkZodkdOaWUrandiaHlwd3dicTRqUEMr?=
 =?utf-8?B?YnZJUk9NRWllcXVlUlI3Q0wyTGlSZDVVTXJWdHFZQ3VxRWxnMGg0eElIVXlQ?=
 =?utf-8?B?YmFkeGFxYXRDZ1BOL1RRT0hWQWlhVVl2WnRRK0VvQmZFZFJCREhTU1VES1Ur?=
 =?utf-8?B?M0IwVUVvMExSb0VvcDdpTXRJd2RPLzlUS0MwbGJkRmhzeXI5RTRoWFFDT3Bx?=
 =?utf-8?B?dVlWRmkydFlDNWVUTGovWCtqbmQycDU5aFViZzBxQlk4QnloRWdUSm1GNXlz?=
 =?utf-8?B?YkFTN0tqa0QwL050czdnbktsN2w2M2xEYllHbXZtcS9ZSE1sSkgwL2R1Titx?=
 =?utf-8?B?Ym1wbDdvV2Zuam5KVW9WSzAvdTFtV2FKM052aTVKVEwvZEF6bElQNzlKRjR1?=
 =?utf-8?B?WGlKbmpwK1R4bXR1MUtEMVh6M3RZQnNEUUxvU2Z2eGZUam9WUGFqRFVVYWJE?=
 =?utf-8?B?VnpqcStKSkh5MWlzcytseXJnaDZnMGR5c3RRQ2FWWnM2dUlvN3BiOG84MCtG?=
 =?utf-8?B?aWtycGtENExjYnJFV1JrUmQzd3VtdEcvakF0Tldrck5uQ0gvdlg0Skg2WWxx?=
 =?utf-8?B?bGlERklINnRzUXBSTTYyK25EamM1UXk0ZHF4eGtrZmpyR0lZNnBNNkJYQ1Jj?=
 =?utf-8?B?SzhkZU96QjFXN0h6MGtvN0w4bnlGYU1UaUhNYmlpR3YxWVBtamVDUHQvRWlr?=
 =?utf-8?B?WkRCWkxkajA0OXIyZVRmamMvdFFGcC9TeUdOaHFHcWJ3RE5pZ2tjeTZKNFFy?=
 =?utf-8?B?Ty9JanNyKzBwN1hYaDNVM0dWWjlDSGlQZUY4OU0zYTBPb0tFV2ZGb0FvK0lP?=
 =?utf-8?B?NFM2dFJaWHRVVzgxdWErRVExTmFkM0xyWnZUMUdyem9KNnYrV1UwODhUeWlU?=
 =?utf-8?B?ZTZyWnEvdG43bjlHMzZNampvbFB5YWpPVG1JNTZxSzhQRy8rc2phRFJXRWhy?=
 =?utf-8?B?bTd0WDZFbmRzQmFUc3V6aWFObDRpYS9lZGJyRklRZTgxN3BFSzRNbHNIOEw4?=
 =?utf-8?B?M0ZQMFRtaUgrSk5WeWNFOUptaWliN2tKMUhoUUtZSGl3KzZSTHRWUCtuODVZ?=
 =?utf-8?B?ZEJ0eFdITzc0Qnk1ajVWNjA2b1QzaHZtaDNTb09CQlVzVkdXWFI0TCtqZUF2?=
 =?utf-8?B?d0JGblVJNTZ2Q3pnR1QwaUhSVDdJMXA4SkFoSW1Ha0NJSEZxZmJxQlJTcDFI?=
 =?utf-8?B?dXQvTWxQMHJaL3o1WThZbFAreGJ1NDM1OHMvQThOVmRsN1J3SWR0MjJ4QVls?=
 =?utf-8?B?a2R6dm16T3JrMkFuejdqUWRKUEFKSUFnSHhoSjVvYWZaVlpscmZibmZwbjNC?=
 =?utf-8?B?ZTMzRlJuQ0VSNkZTOUoyR1AzZzBvdHRhSFdVem01SW1XSmZFR1NUYU51dTA2?=
 =?utf-8?Q?PHFiX8W1Abf1tIKIJykRH+UVn3lRdePKuCO8nJl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(376011)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUl2ZGVwbzJsbGlSVEZOdzk0RkhwakhwR2tmK3ozWGZJQ1pNTzZvN0xUb20r?=
 =?utf-8?B?eWdtM1RCYnZTbitpa0dsajRHS0VsNVR4Mmh0WWNHcW0rSzJkWCtVYlFQWXRC?=
 =?utf-8?B?NmdPVERkOXU1Vmhua1BRV0lKblc0SzFJS05GTWl2ditaMFNLdWhSTVN0emF1?=
 =?utf-8?B?bURDZDQyeDlYWkwxSXFIdDN4WnB3a1R0TTRIdWdyQlRIbitLYWVCcEV0blpL?=
 =?utf-8?B?cXY5NktCWVM1anhkS3l1c1dZUGxyaVFSczFnR2RTbGZaN09PRGZja0dCcjd4?=
 =?utf-8?B?SEpnVFBoUDNlY2pRaVZQcHlXSGpqTm9SeEwxMFphb2UrYWIzUjlNdko3TlBI?=
 =?utf-8?B?S1ppYTVkcmNqUG50T2ZIa05FYiszNXB4Vmd2cTZQbk55d3Foblc2U1QycFhY?=
 =?utf-8?B?OWlCVVhlNHhXeWcyVGhSK1VFOWpLMjBtaGorVi9RbkJsRFJOV0VzRFN2SUtT?=
 =?utf-8?B?Ri9ONjk0bEFva2RxSXZiNXlQU2M4QkUrbExBbmxmRGxUejFiOE01bjVpbWFV?=
 =?utf-8?B?TjZjU3pOd0FFdWQxaFVxQllQc25xK1hnM21XVkx2b2kyRzBROEYyYjNpNHlF?=
 =?utf-8?B?OExCUWdyZmc1M2dNRFFrKzdXcnowejVEcWlBejhFK2hqUm14LzFEZVpKMzVE?=
 =?utf-8?B?blVRbG5TRUUzQmdTUWVGK1c3b0FiUExFRWxhODh4MXRUUUdFQVNjNjJ6Yk5q?=
 =?utf-8?B?MlAyMzdYdEZ2Q2hub1NNOSt0UUdDY01FUGdPWVBBYlUzUEZzSWVHYU54S1lK?=
 =?utf-8?B?SlJwVXIvd2tFa0ZGcXFpcndNNFhmMGQ4TjdUMHJkOFZLMUR2R0VjMEM0UUxV?=
 =?utf-8?B?MXJzaTlHZGZ2UGNkRit4c0pUVW80TVRLZ2lidkIzNjl1SC9DeEdIYjA3VEV1?=
 =?utf-8?B?V0s3eXFLMVVwYjg2c1ZlQXp5TXprWVB3Y0tGN2h1cEVtdXF2dzMyM0RaU3Nx?=
 =?utf-8?B?TDh2cWJDZllqR00vVmRUcW9uZmdKOTYzZ0xQTkpMY01TYkxUNTRnZXFnRjRa?=
 =?utf-8?B?ZklUMk5POEdUSUxXZm54L2xTSllMQUdwdkNPVHdYYURuQUZsTjVsTFUwT3Zi?=
 =?utf-8?B?N2lFSFJocXNKWWdtcUFRR2c1Y3JTWWR1RHBuMXFKVkcxNUpKak45a29nYjhN?=
 =?utf-8?B?WXREMHBxQzRDd2oxTW5jTlBBYUw2cEsxak5tQ3ZkWmNpUmJzcU9pUDNRUXAw?=
 =?utf-8?B?SEVXOC9PZHhuNGtXaWltYlp6L3d1TU96M3VMcnNmK3NXNlRMRUcxNC9wMHEv?=
 =?utf-8?B?THBTbDBiWGdZM2p4SHpKdjNENU8yc2k2NFFaK3ZJQXkrODUyYWkrODVoNzdQ?=
 =?utf-8?B?cUI2OEM0a0JFRUZCb21scGdNY1BLR3dHM2tFcjZUZVN3RnArYWdlV1h1Q2N4?=
 =?utf-8?B?Y214T1QwYXRNQW5kOEtIR2tDWmE4WWluTm9vM3VKWEM0L1hkaHhsbW15NGtG?=
 =?utf-8?B?T3FiQnhOWjNGaTNUbmliTmljRkVMYkI2RTFpNUgzUGVTSDVnUm1ib0hPRlBU?=
 =?utf-8?B?WjJGQTNiVHV5U1dKY1pQZ052TTJIUCt4ZVV4OWFpMkhSbm9EbEhTVXNsUTl2?=
 =?utf-8?B?eXFIWGNYYy9tdVZmL2FlOFBSMlhXODN5d3VyOXN3TWRHUXV2VERxNVBLQ21X?=
 =?utf-8?B?UHVib2JOYXQ2VldyazhqM1lDUDlxS0svMkttV2Nnbi9lTkJHQm5wWUd6bExE?=
 =?utf-8?B?SzdSdnJNK3FZSE8vL1F3eDJpbVR1UzcwcXlkZElIcEF5UHBXSmF2bnNpZE9y?=
 =?utf-8?B?N1ZzMW52VElzM214THRKb0tnUnA4M1dRRlVuUXpmalpPSW1KVTRrRkY1M3cw?=
 =?utf-8?B?eHNPVXZOekpoOVdmVmlrSTlVdm5uMXlQZmtYTDk3cnFxVEQrU09MOTU3Uzlw?=
 =?utf-8?B?OW5DU21DSFNBNlJqU1RBZGdkcUxQK0hPb0J0NTJwT0tvSnFqY250RjRmZTd1?=
 =?utf-8?B?cWhieFVGdElacGQ2VHkvWDRpbmhldGhseHBUbWRhajVWOVZHa0xidnhWdmp0?=
 =?utf-8?B?bEF4L1pIUXR1UEVCQW9yWDd2bmQxQXJwS1FRSU9YZnROZFB6RmRGajlsaktl?=
 =?utf-8?B?Tmh5cWRjbnJZc3owS2hCVVB2L0VOejlmSHMyMXFka05xOEMzWDRxUTRBeGo4?=
 =?utf-8?Q?LXCg90dylYrbdK8u+8Hw4v0cO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4a4bc5-7e7a-4b5c-503c-08dc9136a225
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:38:21.6933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5JL6nIUV4pKDkjxGhli73r0NjU8izKm0ktKW1WDssPaiCHyfBukfz9RQBGwKULz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

Am 20.06.24 um 16:30 schrieb Li, Yunxiang (Teddy):
> [Public]
>
>>> +   dma_resv_lock(bo->tbo.base.resv, NULL);
>> Why do you grab the BO lock to update the stats? That doesn't seem to make
>> any sense.
>>
>>> +   update_stats = !(bo->flags & AMDGPU_GEM_WAS_EXPORTED);
>>> +   if (update_stats)
>>> +           amdgpu_bo_add_memory(bo, &stats);
>>> +   else
>>> +           dma_resv_unlock(bo->tbo.base.resv);
>>> +
>>>      buf = drm_gem_prime_export(gobj, flags);
>>> -   if (!IS_ERR(buf))
>>> +   if (!IS_ERR(buf)) {
>>>              buf->ops = &amdgpu_dmabuf_ops;
>>> +           if (update_stats) {
>>> +                   for (base = bo->vm_bo; base; base = base->next) {
>>> +                           spin_lock(&base->vm->status_lock);
>>> +                           base->vm->stats.vram_shared += stats.vram;
>>> +                           base->vm->stats.gtt_shared += stats.gtt;
>>> +                           base->vm->stats.cpu_shared += stats.cpu;
>>> +                           spin_unlock(&base->vm->status_lock);
>>> +                   }
>>> +                   bo->flags |= AMDGPU_GEM_WAS_EXPORTED;
>>> +                   dma_resv_unlock(bo->tbo.base.resv);
> The thought here is that I don't want two exports of the same buffer to race here and increase the stats twice. But if BO can only be exported once then yes this is not needed.
>
>> Don't touch any VM internals from the BO code.
>> Don't touch any VM internals in TTM code.
> What would be the preferred approach? I can put a small helper in amdgpu_vm or amdgpu_bo I suppose.

In general the VM should already have most of the necessary functionality.

amdgpu_vm_bo_add() is called when a BO is initially added to the VM.
amdgpu_vm_bo_del() is called when a BO is removed from the VM.

amdgpu_vm_bo_invalidate() is called when a BO moves. This needs to be 
improved to take old_mem/new_mem as well.

Then you only need another function which signals that the BO is 
exported and you should be done.

Regards,
Christian.


>
>>>    #define AMDGPU_GEM_CREATE_GFX12_DCC               (1 << 16)
>>>
>>> +/* Flag that BO was exported at one point and counts torwards the
>> "shared"
>>> + * memory stats. Once set it does not get cleared until the BO is destroyed.
>>> + */
>>> +#define AMDGPU_GEM_WAS_EXPORTED            (1 << 17)
>>> +
>> Absolutely clear NAK to that approach. This is not even remotely an allocation
>> flag but some status.
>>
>> Additional to that completely unnecessary since BOs are usually only exported
>> once.
> If BOs can only be exported once then we don't need this kind of marker, but I think user space is free to export as many times as they wish right? I first tried to handle the unshare case as well, but I don't see any where in that path we can easily hook into. I can give it another try.
>
> Regards,
> Teddy

