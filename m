Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AABC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 07:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCDE10E008;
	Thu, 23 May 2024 07:18:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vmGsuM/i";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D2010E008
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 07:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMTUy6qpHJdFYp8SMwBV1CAZd200VATgoXoc6wfxs4Y5tvyWuvsIhalRWaiNuZkoK7xyUIxuZVbWkWf5aBlhhhC32kASwjyw2Fik2HL3Zsp7MH0zIqgxXYXWWjt9qkwtiXim0U9hKXEQ8pWgSoxCt7MCLLkOdjMdsNoSWE+eWsOEjmT0JRDG8hZpQvwLZu3NNlGWtwDDl0fbvp304wmRNveFijZnEdlwred3CUIkpV4+Ntf41s2T4iDF/SeJnv4rQCtWkpUhSUfsOXBCUyJuliREMoPZmIGCl8FDWIMFMsAmUL5YfQfg2WYMsmGc7ODdzq6C0pK2xbCy/QVTlYkDrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj1AHOdQexieb+pvbYp2IAaQPYcZ+lc/7O02Ccjvv+4=;
 b=ZH3gPyw82eoqU9sYLweY1QTwohxGDR0sj8cubTMbTCdgtLiuv+8THDN/7G4vcm5A8gWUu3vTsbwzKD5nnXv5l2WNZBt5LIHCt23VXIjSiXdPEb+BexgJIuPwsdH6k+zcxkelqsT06C3Z5OIofUGY06qTi1PFp2sk4kveuYxzZ6w0m+JUYNFPUzuBg5uleOJpNaMVr0OXp1MmiEYFZ51fEcy602B1DPcyhUNHochjSbzbWtM4qWPeV2+oYWX6997ItRdvEZaQlnmtoNEQslmJq3Y1Pv/9hdRUSRoI9rkjoJoyYG57ihVXyhXP0oK1Yjv80zOrKpB4BLzIhVAKHRzYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj1AHOdQexieb+pvbYp2IAaQPYcZ+lc/7O02Ccjvv+4=;
 b=vmGsuM/iklrzxNJ4YaUuxLfxDnEJmeddxdBKXn64u3szXbh01Q1TVeW6quhDCQX4Z9S8yc6fJx+WfMmeyonC1U3oKtIuXG5H8YCaaL7KGFO8VYbMdIAwQ1qfZi8RSSM/r1SCrVDXsgbNuq1RSjq5WjKPOs2YEbwn4UvL6fwh5Gk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 07:18:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.037; Thu, 23 May 2024
 07:18:27 +0000
Message-ID: <5025dc06-8471-4f74-affc-1070fc7e6dca@amd.com>
Date: Thu, 23 May 2024 09:16:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: prevent gpu access during reset recovery
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Likun.Gao@amd.com, Hawking.Zhang@amd.com
References: <20240522172721.14085-1-Yunxiang.Li@amd.com>
 <20240522172721.14085-4-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240522172721.14085-4-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 93244cf8-b0f4-45f7-6a47-08dc7af88ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTdsMFZ3Rk9wUUNMS3JwK2prL2dSVGFwZDRaNWRyRi9TcTNETUttZHRmUTlD?=
 =?utf-8?B?WEgwR3N6OHVDbXFyRnMxcEc3WUZ6TU14aHRCSmwyMjliTmdoMUVUWE5mQldl?=
 =?utf-8?B?c1IvTWZNTHhXN3BBR3k2cUZnVFRYaEgvbjVtbE5RMVhPWUxaNTdja3locTdu?=
 =?utf-8?B?SjlLZ3dJWS9rK3dWYXAxbjduOFBOY0xTcjVWZ3F4Z0hyc1dOMDlDVjNCa1J5?=
 =?utf-8?B?cWFXbnB2aWpkOTEwQUNBT1RVb0tzT2VSbTRXOTRuTkFBaXdJTHdOTkVBc2pF?=
 =?utf-8?B?UXMxQXVlMXRMcDNOSUdSU3Qya0VFa3JJeDcvbFVkdzU4Wk14ZXZnVlF3b1hZ?=
 =?utf-8?B?SUw1bzA3Nm9MUVNDbzh5UGk5dVZkQTNNNmtyeDV1blVORFJoZW5WZzBZc04x?=
 =?utf-8?B?cGl3djYwcXhsSDMyQ2dhWmdRRGd6VlF2YUt1V1Y5bHZiTlRPZUpJQW1kTmlU?=
 =?utf-8?B?alc1ZG4wUU1WVjdVdHZEWHp0QmhGY0tCdXllajRXNzAzVnF6WVBMUWY2Y2Yw?=
 =?utf-8?B?VW5ad2dXeUxkdU1XSnd4NTQvS2N5cy9CUVhqcGJrZUhjcHBSeVM3SE85L0NE?=
 =?utf-8?B?SUwzRE1hVnJIbG1OTjM1ZitQSjBPYnBTZEJTazdzczJDWU1scjZPNG84TFdk?=
 =?utf-8?B?UWpzU0oyQWFYem1mNml6R24wdWI5RnU0Nk9TVmh6bVFBUHBpYWJRcSt5MEVr?=
 =?utf-8?B?K0I5SFkyM0czK0NQU3E2dnRmVVBOMEV6c1pCRmhEVEdBSTBKNlMyWHBnai8r?=
 =?utf-8?B?Wndtem5XUUJzUEVSd3dPT2tIMjk5NjlRUmROQUJpNTU0Qnk5Qm9zcVlYak9n?=
 =?utf-8?B?TWlvRTFHNHc4ZkFjTjVuaU1wQ1BwV1ZTR1FZeEhXRlZSRWlnMTFhcWJNakIz?=
 =?utf-8?B?eVY3QUZuQmxTc3RVQWNENkkvQmFYU0pML2t4SWM3R21vRWJtc2ZwcWdlVDhN?=
 =?utf-8?B?cG84RlM3S0RMamJ3dTVMOXRyNkFlUkxMQnlFc3hhZyt4b0ZScVA2T3MvYVFn?=
 =?utf-8?B?UUhzNXNoaVhocmZ2UE5od1RWbXJmWDFOZFByN054TGxEdXl3N1JidDNjSWV1?=
 =?utf-8?B?UDVNc3h2V2kzRmNtb1ZWZEZzbG5DaVZnQms0R2hmSzFUdVZPdi9uUUR6VnhT?=
 =?utf-8?B?RElrZk1LanorbTZXTitKN0NKaU1Yckd3cFNMcStOQ2FWUGZ1SC9WUTg5UkxJ?=
 =?utf-8?B?NVJNSi9kU2RpL1lYWWhOWG04a2hzTUhmT2I2T2Z5dUNXYWJRSWVleVlnTk5O?=
 =?utf-8?B?bzlVK2JKcHFoNXRDRG5pT2haUXdZdkU4Q1RhcGwyNHJGVFA5bjhXSk5MVGlj?=
 =?utf-8?B?eEpWc3RRUW5qdG9hQUF3SEV0WWF2bmJiKyt3R2FmK3RxVEpSZ0F1SmRZR3dy?=
 =?utf-8?B?Z1JQVFQvaGJvM1dLOC8zWEgzRHdqZVI4TkJFaytsUXZWbzZXK1FGelRPUnNO?=
 =?utf-8?B?RnFWbFBsQkFMMkpYNUl0c2xMT21XZFdMbUJ4aXBuR0RDNlVRcFFRR1FHQjV1?=
 =?utf-8?B?d2tycjZXUGlhZkFpd2w3SGNVZEJ1bTRmZGR0WXNTNzJvdFl0Mnc4Q05BVVVJ?=
 =?utf-8?B?RmIwYTJYRlJzVkdHR05TOVU0djFCdjNuMHRsRm1yU2pBOUdBbExGOHRrYXJs?=
 =?utf-8?B?ck9KeHlFaUpQeXU3aUNISzdNRUp6WlVhWXNzUHg2NFFXb2lreHUra1lVNXcw?=
 =?utf-8?B?Y2toTlBWRFhQamNsNDlISW9SUjZrbVJKL0ZJbWV3aWRYaUFjMUlWdnhnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnQ2VUE2YWs5a2ZOalc5Z3ZRbVBPVXIxWGFJVWFCWDBwYmo5QXA2YTZVcmJa?=
 =?utf-8?B?Z0VZQVJQaUNIRkJ0Q21qSDdvVnRQd0xPWE4ydytQdUFpQllsamlBb1Vsdm5p?=
 =?utf-8?B?L2I1MlUvSHFnbmZPRC9lYUYxUHdhS25jSWpTbldEMWxPSXd0ZVJSamw4Kyto?=
 =?utf-8?B?K3AyMUN1SGt6empZdCtSQlQ5Qmpuek1QT3BqK0VLZTVRa2FOUThuMXp5WDNT?=
 =?utf-8?B?cHRGdXd3b1I0RmcrVWFNVlNBdjJGdk9tWVIrclZGWHN1U2p3Y09SMXZidGJF?=
 =?utf-8?B?MVBCQ3h4U0ZoV1VKRjh6cXZUaDF1WURvTlU3WDRleW9rMlhTU3RjZzlGc1g4?=
 =?utf-8?B?aEVGanZBdW1KMUxvMEFaeG9WMzduaWo5VDJIS3N1bmRnOHpBYlc5WHkzRUZS?=
 =?utf-8?B?ekd4QVJBREhKV3lPZzJ6amI3ZmlKWUVLRnR2TVBYWjRzK05zN1RXNlNPeW45?=
 =?utf-8?B?bUFCL1poYnp2djg5SGpsY1hHK2N4alJSRFJqMmkxODZDYUhzUTJqRzFLMUll?=
 =?utf-8?B?UUg5bjB6NmdHeWc3RjBLUTIxQms1cUNDd29hVFlxS1Q3d0VWbUZnWFJVV0Yz?=
 =?utf-8?B?OXoxSXcxd0RmVXJKK1pycSt3Z2RIVW5teXlMcHRSTUticTg1RWthVTBzZDZB?=
 =?utf-8?B?SEhPY3Z1N0ZxeGo4R2VseS9US2xNczA0NklVY0JuVzhObGZhTGdNQmkvNEsz?=
 =?utf-8?B?d2FVYUZIbEZRb3ZZMFkvUVgxU1V3WFlDdHpoc3krVGZvSnZrd3owbXlxRzJ5?=
 =?utf-8?B?MkVzUThreTZJcW04S09jcklZMXpyVEk1ejgvZjF5dVlYRzJoSnllTU1PUVA1?=
 =?utf-8?B?QjNEcllkVldqZFl6eTg5bVJaWFg1ZnVaTGVZUlJ2TlNSbUdiVDhDRyt3OHBj?=
 =?utf-8?B?VjdraDdqVDd1bEVhTSt1TGxQNm1RaXBpbVYycUZJZmNzbmVHNVFubjF2Z1E0?=
 =?utf-8?B?OEtzeUdBczhHanhLakhnMjV3NFZRTDZBNjFMQ1JDajRVL09LcmZqNUQ1MUQz?=
 =?utf-8?B?VndUMkdGMWNjUWI4dFhZRGc2K2FDblRMeHhFWlRUeFpzZlNmcHhBWlRzd1JM?=
 =?utf-8?B?SUlSOFYwdmVWQ0owcWNUaG9sVFhRSlhtRjh3UWFjQkNsZ3F4cmRwc1I0eFR6?=
 =?utf-8?B?NzFLZWdJRjVqTGdpOXhZM1dzNEJRN3IzdldEMEtHeFJSekw0K2lxRjh5U2Jy?=
 =?utf-8?B?VDFLN0JjMXBGcXAxL24xcU9VOFVrNHZnNmdVbEdydmZEMlJnNC9mdFZqcWYx?=
 =?utf-8?B?d0NFS0haNW5qVGhMT0tMWHE1NVFCS3FRR00vTTlHdnNVRDZkZjMzbGlsYXF6?=
 =?utf-8?B?R3oyYVZVVXV5MHZ2YjhxRVVaSHVNWWM5Y2RhOFQwMVlxdlI2Sk1ZcGJEdGx5?=
 =?utf-8?B?d2k5VWFWaWQ1YjVjYTJYait3aU42amJoN2doSVJVWENobnVmNEZ3dnIwM1Zm?=
 =?utf-8?B?ZTRWWXdXSDZ3ZUFmZFpGUEEydlN3d00rYUplWXJ5MThtUmU1dlp4NHliQ0Mz?=
 =?utf-8?B?THp3N0JZa1EvMStMUmpNU0Y4a25nM2dtTE53THowZFVQTGxJdzJ0NHVyYkI2?=
 =?utf-8?B?dWN5Yk91RGh3NzJiWFE0U2IxZDNkOGkvcU1lTnpTcEI2bEVsRWlxTDlmWVpn?=
 =?utf-8?B?WS8zTDh4TFpUM0ZZU2dUckhHSlFWcE1xamFReWxudUkxa1h0Nmsvd04zV0Fq?=
 =?utf-8?B?c1h4Z2NibWFBMUNlWXhSdGwzRHVJUHh5elJCM1NEVGptOFRwWTZidE44WmQ1?=
 =?utf-8?B?N3h5cHZoeUJuLzRxSmdhZHM3QUMvZjZrK2g5Ukxlcm01cDJ5SncxejdQdzRv?=
 =?utf-8?B?dVFzK2NQQVVYd0VlRzRuUlp2YzFzUGNPTXFEVlVIWDU0UkxKNjNNQXJxeWJz?=
 =?utf-8?B?S3RrcTVNa2gvODNJMTg4UGRQODFtREZINkFBNGdYOHZWU2xvVWFOSUpFbGJL?=
 =?utf-8?B?NFRIYVMydHlzVUZycU0vcm52SzBjOUZ1czJHNDJWOGpzT04yU1B3SHMyYmla?=
 =?utf-8?B?ZmowU3FVMkR2cTRrSWJSaDVmbmlRNE5ZWmhpNkhkQjhBa0dQbWJHRi91cnFF?=
 =?utf-8?B?M3F0dkVYeXQ1ekZzRHpzWlErVWtoOGd1V1pEdzQ0bERWVzhUUnpDQzF2b2tJ?=
 =?utf-8?Q?4UdevR3u9SW1lg82UClwFRFxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93244cf8-b0f4-45f7-6a47-08dc7af88ab0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 07:18:27.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcqPihR9vcQ9hJ1P/sz5LmxRm5k85ZHHNiymsboVIK/pPCaRLOCEHGgCpc5K4lpG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315
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

Am 22.05.24 um 19:27 schrieb Yunxiang Li:
> Random accesses to the GPU while it is not re-initialized can lead to a
> bad time. So add a rwsem to prevent such accesses. Normal accesses will
> now take the read lock for shared GPU access, reset takes the write lock
> for exclusive GPU access.
>
> Care need to be taken so that the recovery thread does not take the read
> lock and deadlock itself, and normal access should avoid waiting on the
> reset to finish and should instead treat the hardware access as failed.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 22 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 74 ++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  1 +
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |  7 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  7 +-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  8 +-
>   9 files changed, 79 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1f71c7b98d77..5a089e2dec2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1632,6 +1632,11 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
>   
>   int amdgpu_in_reset(struct amdgpu_device *adev);
>   
> +void amdgpu_lock_hw_access(struct amdgpu_device *adev);
> +void amdgpu_unlock_hw_access(struct amdgpu_device *adev);
> +int amdgpu_begin_hw_access(struct amdgpu_device *adev);
> +void amdgpu_end_hw_access(struct amdgpu_device *adev);
> +

Don't add anything to amdgpu.h. We are slowly decomposing that file.

>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>   extern const struct attribute_group amdgpu_flash_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e74789691070..057d735c7cae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5816,6 +5816,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		goto skip_hw_reset;
>   	}
>   
> +	amdgpu_lock_hw_access(adev);

That should already be locked here. So this will most likely deadlock.

>   retry:	/* Rest of adevs pre asic reset from XGMI hive. */
>   	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>   		r = amdgpu_device_pre_asic_reset(tmp_adev, reset_context);
> @@ -5852,6 +5853,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		 */
>   		amdgpu_device_stop_pending_resets(tmp_adev);
>   	}
> +	amdgpu_unlock_hw_access(adev);
>   
>   skip_hw_reset:
>   
> @@ -6449,6 +6451,26 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
>   	return atomic_read(&adev->reset_domain->in_gpu_reset);
>   }
>   
> +void amdgpu_lock_hw_access(struct amdgpu_device *adev)
> +{
> +	down_write(&adev->reset_domain->gpu_sem);
> +}
> +
> +void amdgpu_unlock_hw_access(struct amdgpu_device *adev)
> +{
> +	up_write(&adev->reset_domain->gpu_sem);
> +}
> +
> +int amdgpu_begin_hw_access(struct amdgpu_device *adev)
> +{
> +	return down_read_trylock(&adev->reset_domain->gpu_sem);
> +}
> +
> +void amdgpu_end_hw_access(struct amdgpu_device *adev)
> +{
> +	up_read(&adev->reset_domain->gpu_sem);
> +}
> +

Don't add helpers for that, especially not with that name.

We don't block HW access, but just prevent concurrent resets.

>   /**
>    * amdgpu_device_halt() - bring hardware to some kind of halt state
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 603c0738fd03..098755db9d20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -623,12 +623,11 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	    !adev->mman.buffer_funcs_enabled ||
>   	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
>   	    !ring->sched.ready) {
> -
>   		/*
>   		 * A GPU reset should flush all TLBs anyway, so no need to do
>   		 * this while one is ongoing.
>   		 */
> -		if (!down_read_trylock(&adev->reset_domain->sem))
> +		if (!amdgpu_begin_hw_access(adev))
>   			return;
>   
>   		if (adev->gmc.flush_tlb_needs_extra_type_2)
> @@ -641,7 +640,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>   						   flush_type);
> -		up_read(&adev->reset_domain->sem);
> +
> +		amdgpu_end_hw_access(adev);
>   		return;
>   	}
>   
> @@ -684,12 +684,18 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
>   	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
>   	unsigned int ndw;
> -	signed long r;
> +	signed long r = 0;

Please don't initialize local variables if it isn't necessary.

>   	uint32_t seq;
>   
> -	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> -	    !down_read_trylock(&adev->reset_domain->sem)) {
> +	/*
> +	* A GPU reset should flush all TLBs anyway, so no need to do
> +	* this while one is ongoing.
> +	*/
> +	if (!amdgpu_begin_hw_access(adev))
> +		return 0;
>   
> +	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
> +	    amdgpu_in_reset(adev)) {

That check doesn't makes sense now any more.

>   		if (adev->gmc.flush_tlb_needs_extra_type_2)
>   			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>   								 2, all_hub,
> @@ -703,46 +709,42 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
>   		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>   							 flush_type, all_hub,
>   							 inst);
> -		return 0;
> -	}
> +	} else {

That the locking is missing here should be a separate bug fix 
independent of other changes.

Regards,
Christian.

> +		/* 2 dwords flush + 8 dwords fence */
> +		ndw = kiq->pmf->invalidate_tlbs_size + 8;
>   
> -	/* 2 dwords flush + 8 dwords fence */
> -	ndw = kiq->pmf->invalidate_tlbs_size + 8;
> +		if (adev->gmc.flush_tlb_needs_extra_type_2)
> +			ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -	if (adev->gmc.flush_tlb_needs_extra_type_2)
> -		ndw += kiq->pmf->invalidate_tlbs_size;
> +		if (adev->gmc.flush_tlb_needs_extra_type_0)
> +			ndw += kiq->pmf->invalidate_tlbs_size;
>   
> -	if (adev->gmc.flush_tlb_needs_extra_type_0)
> -		ndw += kiq->pmf->invalidate_tlbs_size;
> +		spin_lock(&adev->gfx.kiq[inst].ring_lock);
> +		amdgpu_ring_alloc(ring, ndw);
> +		if (adev->gmc.flush_tlb_needs_extra_type_2)
> +			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
>   
> -	spin_lock(&adev->gfx.kiq[inst].ring_lock);
> -	amdgpu_ring_alloc(ring, ndw);
> -	if (adev->gmc.flush_tlb_needs_extra_type_2)
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 2, all_hub);
> +		if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> +			kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
>   
> -	if (flush_type == 2 && adev->gmc.flush_tlb_needs_extra_type_0)
> -		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, 0, all_hub);
> +		kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> +		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> +		if (r) {
> +			amdgpu_ring_undo(ring);
> +			spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> +			goto error_unlock_reset;
> +		}
>   
> -	kiq->pmf->kiq_invalidate_tlbs(ring, pasid, flush_type, all_hub);
> -	r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -	if (r) {
> -		amdgpu_ring_undo(ring);
> +		amdgpu_ring_commit(ring);
>   		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -		goto error_unlock_reset;
> -	}
> -
> -	amdgpu_ring_commit(ring);
> -	spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -	r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> -	if (r < 1) {
> -		dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> -		r = -ETIME;
> -		goto error_unlock_reset;
> +		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
> +			dev_err(adev->dev, "timeout waiting for kiq fence\n");
> +			r = -ETIME;
> +		}
>   	}
> -	r = 0;
>   
>   error_unlock_reset:
> -	up_read(&adev->reset_domain->sem);
> +	amdgpu_end_hw_access(adev);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index bfdde772b7ee..01b109ec705b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -144,6 +144,7 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>   	atomic_set(&reset_domain->in_gpu_reset, 0);
>   	atomic_set(&reset_domain->reset_res, 0);
>   	init_rwsem(&reset_domain->sem);
> +	init_rwsem(&reset_domain->gpu_sem);
>   
>   	return reset_domain;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 5a9cc043b858..a8ea493ef0e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -86,6 +86,7 @@ struct amdgpu_reset_domain {
>   	struct workqueue_struct *wq;
>   	enum amdgpu_reset_domain_type type;
>   	struct rw_semaphore sem;
> +	struct rw_semaphore gpu_sem;
>   	atomic_t in_gpu_reset;
>   	atomic_t reset_res;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index f4c47492e0cd..38bfd1bb1192 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -259,11 +259,9 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
>   	 */
> -	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
> +	if (!amdgpu_begin_hw_access(adev))
>   		return;
>   
> -	down_write(&adev->reset_domain->sem);
> -
>   	amdgpu_virt_fini_data_exchange(adev);
>   
>   	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> @@ -279,8 +277,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
>   
>   flr_done:
> -	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
> -	up_write(&adev->reset_domain->sem);
> +	amdgpu_end_hw_access(adev);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 37b49a5ed2a1..522198b511d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -292,11 +292,9 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	 * otherwise the mailbox msg will be ruined/reseted by
>   	 * the VF FLR.
>   	 */
> -	if (atomic_cmpxchg(&adev->reset_domain->in_gpu_reset, 0, 1) != 0)
> +	if (!amdgpu_begin_hw_access(adev))
>   		return;
>   
> -	down_write(&adev->reset_domain->sem);
> -
>   	amdgpu_virt_fini_data_exchange(adev);
>   
>   	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
> @@ -312,8 +310,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   	dev_warn(adev->dev, "waiting IDH_FLR_NOTIFICATION_CMPL timeout\n");
>   
>   flr_done:
> -	atomic_set(&adev->reset_domain->in_gpu_reset, 0);
> -	up_write(&adev->reset_domain->sem);
> +	amdgpu_end_hw_access(adev);
>   
>   	/* Trigger recovery for world switch failure if no TDR */
>   	if (amdgpu_device_should_recover_gpu(adev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 4721b2fccd06..ed96ed46d912 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -262,7 +262,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	int r;
>   	struct mes_remove_queue_input queue_input;
>   
> -	if (dqm->is_hws_hang)
> +	if (dqm->is_hws_hang || !amdgpu_begin_hw_access(adev))
>   		return -EIO;
>   
>   	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> @@ -272,6 +272,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
>   	amdgpu_mes_unlock(&adev->mes);
> +	amdgpu_end_hw_access(adev);
>   
>   	if (r) {
>   		dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 6bf79c435f2e..c2bccc78525c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -87,8 +87,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
>   		return;
>   
>   	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
> -	if (dev->kfd->shared_resources.enable_mes)
> -		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
> +	if (dev->kfd->shared_resources.enable_mes &&
> +	    amdgpu_begin_hw_access(dev->adev)) {
> +		amdgpu_mes_flush_shader_debugger(dev->adev,
> +						 pdd->proc_ctx_gpu_addr);
> +		amdgpu_end_hw_access(dev->adev);
> +	}
>   	pdd->already_dequeued = true;
>   }
>   

