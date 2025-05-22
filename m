Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C339AC54E65
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 08:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB9210EBDA;
	Thu, 22 May 2025 08:24:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j4yK26vL";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDDD510E9D0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 08:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b09GszHllPLdVE3Mek2MxfIZBMIQeSC6HEAZbBvM2yIVeVc9gl1z1Avq7165nZc452hhlT8TZywZCiFGhNxLDxSSTdWYdvsq1deUClpmSfPguIyLhlBodhqKuMXK8zhYNYChiG63PsFwgNh/S9LGCTON7bQOOJSw4bK+LJFspG35dioelVIpGV0qUwzlj/1KuONbq40iDA/17sWsJm5Z1VOcy7hMblN8oria5/l0Elv4X7BjwEfyULoOQ/y/agXB16BP1S6BFYj4hmCiZBFsKO9rAQiUeB4nRX3pcr8H15JMeDPGCS94nILwkUpO2A7vC3qL974BInSc2do/QhcVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsyi4KGGlPqRlGCKdUoUHyYiJcwBofRUWkTO7TqB97k=;
 b=XLMpPBGowSK4pIdzBJs/zBwaH3qLgZg+Vvn5cooPmwXQ4KoBMoXSLOkAd8lPi+Uvgxslnsn9TsL4i/wIACFFvA9HpPNqkHJsv2urFQMR3VslTCGEVvplIbYL+ULZaR63nPVgVdhMsyet98NXHZ8hP4Mw8y2pnV4UU4wx9PamDR0e3pgDq6RG0JtICAuto8rpmu/SxVhqhQB+YPDNLKmMo4holXgpFMHGwCmmxKf8c+RTGgGKtXW9kjFtYSS0al78BWPjimryt7p1/iPailDTDYltT+2jbg8hh/B2MEOH88jiN0tk7hBJdNRIGVGDik4RzxKEmlS3XA3UoU8nZZhR9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsyi4KGGlPqRlGCKdUoUHyYiJcwBofRUWkTO7TqB97k=;
 b=j4yK26vLwt6c/HWH3PUmap0HvzwfIM5bh/yy0h5NfHKKZApHT8vtzwj+NzIjtTEe3QhK887UpSc1yp6Vs/YkoJ3ze0pf8CIYsPAxd5Na8Pq4O3kuzo0ohCK4fUHzmP9ree7zRDju5tabCqphp2XOD+LzD9MlB19gRezO9d28z7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 08:24:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 22 May 2025
 08:24:32 +0000
Message-ID: <2a462b3e-6256-4fdb-85db-710ea367d62c@amd.com>
Date: Thu, 22 May 2025 10:24:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
 <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
 <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
 <CADnq5_PrNiZmgUnBH_p9w70wyczK6RtQnNptKQS9FO7ERHhaPg@mail.gmail.com>
 <7d523eba-7706-409a-aeef-5dc6ef309e24@amd.com>
 <CADnq5_O30OX=HcoE3TjJXdbbpVNMgto1gt57kbGy+5j7gKnHgg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O30OX=HcoE3TjJXdbbpVNMgto1gt57kbGy+5j7gKnHgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4108:EE_
X-MS-Office365-Filtering-Correlation-Id: d26ec2a8-ed1d-4b70-3660-08dd990a140c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elBDbHlkaVljaVVtbmRWNlN2ZDZRTytJMEg3QzFod0dCOU9OZjJ1a0JGYkpE?=
 =?utf-8?B?ZkpnSVk2MmYrZkZyK28rbk1Vc0xKd2RTT1FsdGg0YWNFNFdCWkpvZTY2QnZo?=
 =?utf-8?B?U3JIUDl1ZzJKZWtQNGNzMWEvTGYvNXhNY2J0QlpaNHNia0xCNERNVHpzQm1X?=
 =?utf-8?B?RG5aWXNOUFM1RHpldm5UN050c1pjdnM3d1Fnbk5KZDArUFNka0t6aFdMTU8v?=
 =?utf-8?B?SFA3bjZZTmtTUHRud3RxZVE3cnBnVjZNMjBmKzhHZTZqUHc2c0E3QTVwN244?=
 =?utf-8?B?cnVqZllCbytYZWZzZ1RIeUk4ZXNjWVlUOGlRVzVsd0hFN3NLdlQ0V3Q0ZXQ2?=
 =?utf-8?B?UFN5SWdDSXlkSkw2NlZEN04vc0tyRTZ5UXZnMEduVHhDZUpMUm4zN3JDNllh?=
 =?utf-8?B?UVdtbkZ2N1BGbmx1TXV3S2h0bEtTa1VOZ05JMExoQlRQYVN5aGJrT2dIbk9X?=
 =?utf-8?B?Q1dobm4rcHRkZGVsd05oQ3FvTG5zdnA0V3Uya0dKZlJ1WUYxRldiVUtTSDNP?=
 =?utf-8?B?S3hQdE5qZDIvOHNFOE52L1JDR0REYk8ybFpsQ1kxTkFjVWJUTHh5MzNZM0NG?=
 =?utf-8?B?OGlQUHdNM1F0eEk5akZZUDdxWXpLQ1ZQYVhqQTdsV2YyZzg0dW5aeG5TRkhx?=
 =?utf-8?B?dkxWTGQ5TWVKbHBsWk9XMUxTUTQ4b29vZUlvOUMvT2VlWStiNnFMWjhXYVhM?=
 =?utf-8?B?YThpU09EUFZCNWJNNGNRL0J1WlE0UTk4QVhjelcxS2xxWnBnRkdhZkNyQjNm?=
 =?utf-8?B?a0oveXMxblNUVVBQdUdVM1I0RDJGakE4K2ZtbzNIT3RwM1JzM1FJODlwZktu?=
 =?utf-8?B?eVREZUJ2ZUV0RE1HUGdKN2EvS1F3YzNEYUxEL1BUS1JjRElTeVF1dzZDd0JS?=
 =?utf-8?B?T00ycUppczdyRVM5b1Ardi9heStzYjFiZTRzNU1OdUZzUXBlam9KSjZkZmhD?=
 =?utf-8?B?K2FtajZMRE02aWZmVmkwMXZNS1FqOEIyTHFYT0xrQ0JBVmxRSUcrZUZLb1Rp?=
 =?utf-8?B?ZjVVbzRpODY4Ukl1SCtlZUtVSVRGZzJNTFR3OUxyeDFEUEI3aG05b3JvODAr?=
 =?utf-8?B?b0tRb1JkZ0VvZDRjOENwUENZbWV2NVBWM3hVVjR3L0xHU1hNQ3FuMnEwbUZ3?=
 =?utf-8?B?ZzM5Zkh1c0NETE50Vjd0K1N0UUhtZWwwQUtuZ3ZsRHlNQ2VrNFlRVXIrTUJN?=
 =?utf-8?B?SjJEd1ZGVzY3MWRHZVpROG9tMDdzYThtZERnaVNKSHpsY1pRVFA2a293ZEVU?=
 =?utf-8?B?NERVZDdLRWg5d3NhREwzSWtXdkQ5NlNQVHJTYzZJMk9uVll6L3V3UE9yY2Nq?=
 =?utf-8?B?aUVNM3VGeG8vdEZXUDRpZXZ6UGhacVY3enAzS3M2MktRd2Q0YXZGdTBlbG5o?=
 =?utf-8?B?b25QbnlLZWM4TWVka2dTb3BrS29rMEdhNnVTalpKTDNYS2FhdjlzL2x4bEhT?=
 =?utf-8?B?RUJZOUUxbG11TlBXNldDSytVQVhrRlV1VGRXaS9KMTh1bFgrUkc0YVpYMEUw?=
 =?utf-8?B?N3pHL080U0l5Tm5tUEgrSUdLSjVDenFUZXB4M3d3b1VrWVNhWmZwRU9ONHFr?=
 =?utf-8?B?MmwyVzVNcFM0Sk1PQzVkSmlGSXNBZllyQXAyVUxZaWpaYi82c1BUQTJxeGtX?=
 =?utf-8?B?VzhERGlOcW1LSU13Zi96NXZWdVJoUWZtTTVVbmprNlZIeFVXT3hUOWN4Mnpo?=
 =?utf-8?B?QzFobEQxdzMxSDh5TGNJVDJEc2RnbUNGZEw4TElybDZ4R1EyVUpqQld6d2pF?=
 =?utf-8?B?VDNScVcxam9pOG1kUFBFME9qcTdNWWNzSDMvQWRYOGVnUnIxNWpkY0dMeGpQ?=
 =?utf-8?B?VDdqRkcvM2dINWpheW1qeTh2c2o4allXOTJnRjl5MEZxTXk4TWxjbE15RWFq?=
 =?utf-8?B?UVZUNDkvZTNpRkZxNzRLeXdwT0hNbGJ0ZFlGQ25QOWcxSTkvOGM0cGVhT0FJ?=
 =?utf-8?Q?nZ5BUz/Adss=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNuRGxoYkhEdWZrMTVjeE9HUGk3VW91VHV0ZGRCNVVTQnIyY01yNVdMcGcr?=
 =?utf-8?B?NlFCQjJJbzB6TU1BdUZNdFpGNGdvOXJ2aXhzcWNFMTJrZlRqUlV2UlhsNVRl?=
 =?utf-8?B?VW1BWjl4KzZnVVF2WXNuR1pUSEJlSkJXMWFPTXpJdTRXYnFlQUR0bStwYkcy?=
 =?utf-8?B?Qm5LYmd3WjF6cit6SWFSc3dWRm5sMTR6M0VTN3ZqenJxME5sME90OTR1OFds?=
 =?utf-8?B?bEtMNkxUbEF3TlBLMEZuTjVndmVySmdpMDBXNVcwNXA0TDNLS1RlZktBVXIw?=
 =?utf-8?B?aElrNVFuWTlBZXVvSjNmVzRGdWhBdHFvS1had0JSY29IeHh2MXhKcytYbUtL?=
 =?utf-8?B?SmdWUTVXY25IM0d3NE9yNGJDWGNQd3ZEYzY5Y3RNOGJSaXNtOHNZdkJnRGhZ?=
 =?utf-8?B?UlhjaTJnL1VQQ0psV0xoQ1N2QUUra3RueHJDZ1E4clZOTWpvOTFvZFFiNFFS?=
 =?utf-8?B?R2poNEpTK1Z5bUU2NUpwS1NLU1d0SjN1N091Z1BYZVZkTHNjQlhKUnZNbXdr?=
 =?utf-8?B?eUkybERuTkxNVUZsbDRjNGZwUWJRRjk5bS9aK2wxK0VycUVkNEpmT0xBalRN?=
 =?utf-8?B?RVJmRThkWXFlVU44UTNnVkwyb3RyVVduLytSWUdTaS82cFpqd0g3bGY4Mm4r?=
 =?utf-8?B?aGJRUlBpclArdUNpQkpiV01JTFJycU8wSk5HTDVyVWM0ZlRjYmZEY080bEJJ?=
 =?utf-8?B?ZlR3L1hZTG44bG5UUDdSZVFlMTN4bCtPT0VhNnVqYzFBNlc5NkRzcFBrUlRq?=
 =?utf-8?B?WmFFbThsUGdOdzZnc1p6YWUyK1BOM2M4c1dVRzlZSnA5bnlBZGhHU0EzRjQr?=
 =?utf-8?B?NWpIM1U4M3kvakdDSDFaZ3JPd3ZRbVlBYytRaWJlalluNTVGSVo5d0FyT202?=
 =?utf-8?B?cTBNNGZUL3FReFEyQ0dSeGVsL3FVNTdRV1dSQmJyUFdVenJUbFVXbTBQdkxF?=
 =?utf-8?B?c1ovWVJZYTNNNlNpd3dXQVpDakFXWUpuSlNhcnQvaUFuNWNUdjJzR3BtbEN4?=
 =?utf-8?B?aEd6Zm9MSWVxbjZseHhmK0c3ZGIvanhmcFRvMUVTNWNiMFpDSUp5dy9QWGdt?=
 =?utf-8?B?cFhHZkdJbXBVa2tYU2lpKy9rSEZ3TFRtZzBoWk1velBtVkcyMDJrTExFQkJ5?=
 =?utf-8?B?NHJhbzRuZnJHUGxXODNvemRLeUdjUUhvU0c2b05PMnRsbHpIa2MvSVR1ZmFl?=
 =?utf-8?B?bXhUejEwOTdZNnZrc1dvaGVTYnNrSitSSHRES3B1YUMwWUptck1GSWZFMGU0?=
 =?utf-8?B?dzdmN05HZ1VmcE91YlgrWHVjOGEzL2FWVS9HMmFkV0d5NVhUdDFRL1p0YmU2?=
 =?utf-8?B?T2c1ZkdQYStGdFRyWXZRRVFHUEFUTjM0RWFGMHZ2M2VTREE2RWpJWmFZTWlV?=
 =?utf-8?B?SGFnY2Z6YUxOUEZqNmk1WnhoQzdFUFVjTmVJOEc2aHo1Ym1IQU5FRm05OFBa?=
 =?utf-8?B?RjR4WjdjdSsrZVZTQVJVR3hHcW1DQVNZcHFkK3NxZlZIM09ndkx5SW5ISUhq?=
 =?utf-8?B?bU85QytLd3VrWXFwcEZuNnFGMTVRUURJenNLdlNHWmR3bk1oQllreFBXSnR6?=
 =?utf-8?B?Zk92b3dKbXdFTkVpYVRzTTNPTFZxR21HZjM3NnJaUFllVldTNmJISEQ0SWdt?=
 =?utf-8?B?MUYzeTVZM01IQzNjbVVMRSt0QTB2dHZYVkRkaDlLNFFDV1JvTWVPM2MweUIz?=
 =?utf-8?B?R2RIMy9nVzI0ODJITGJWUHZOdjg1RGRpaE5VNnRVTDdEdUd6WHZDZEx1L2po?=
 =?utf-8?B?eGJpRm0yclpmcE9ORVR3QkZFVmJSeXIzcmZJaHRBSUhsbngraFVnYXVVYklI?=
 =?utf-8?B?Y2R2TG5FV25oL1NVSlFZN08zZFlwK0tjbkFSdFlEY25GQnNQTm1qV0ZCU2NT?=
 =?utf-8?B?ZFlIQWNwTXNzNzBIOTdXZzN5b2RaWkFqQkhqQ25OMlRjTFdNdWF0OXk1MUFI?=
 =?utf-8?B?YnZtZGYyK1Q1d3VHeFZHSGZYYU53WkEwY0dmakxNQzE4SGFRMjdpYVRNcFdp?=
 =?utf-8?B?MGxwYW5jNVViMzJqa1B3WHhpVmtkSi9xWGxiREQ1ZXREZFpFY2srWmtPeElJ?=
 =?utf-8?B?SlQxa2pCWjE4R0p4aUlEdXBjcE9vak1UMFhYdjlWbERPcXRxWkFVSG1rdjBs?=
 =?utf-8?Q?moME=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26ec2a8-ed1d-4b70-3660-08dd990a140c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 08:24:32.4757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/+jOJaY6NykgxVIY+DQ8GT+kt2F3uIlV8o+gdo5KXQjgh8NlNlkLUA0xaNH48PO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
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

On 5/21/25 15:28, Alex Deucher wrote:
> On Wed, May 21, 2025 at 5:03 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 5/20/25 18:38, Alex Deucher wrote:
>>> On Tue, May 20, 2025 at 9:49 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 5/20/25 15:09, Alex Deucher wrote:
>>>>> On Mon, May 19, 2025 at 2:30 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>>>>>
>>>>>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>>>>>>
>>>>>> Stopping the scheduler for queue reset is generally a good idea because
>>>>>> it prevents any worker from touching the ring buffer.
>>>>>>
>>>>>> But using amdgpu_fence_driver_force_completion() before restarting it was
>>>>>> a really bad idea because it marked fences as failed while the work was
>>>>>> potentially still running.
>>>>>>
>>>>>> Stop doing that and cleanup the comment a bit.
>>>>>>
>>>>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++-------------
>>>>>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>> index acb21fc8b3ce5..a0fab947143b5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>>> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
>>>>>>                 bool is_guilty;
>>>>>>
>>>>>> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
>>>>>> -               /* stop the scheduler, but don't mess with the
>>>>>> -                * bad job yet because if ring reset fails
>>>>>> -                * we'll fall back to full GPU reset.
>>>>>> +               dev_err(adev->dev, "Starting %s ring reset\n",
>>>>>> +                       s_job->sched->name);
>>>>>> +
>>>>>> +               /*
>>>>>> +                * Stop the scheduler to prevent anybody else from touching the
>>>>>> +                * ring buffer.
>>>>>>                  */
>>>>>>                 drm_sched_wqueue_stop(&ring->sched);
>>>>>>
>>>>>> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>>
>>>>>>                 r = amdgpu_ring_reset(ring, job->vmid);
>>>>>>                 if (!r) {
>>>>>> -                       if (amdgpu_ring_sched_ready(ring))
>>>>>> -                               drm_sched_stop(&ring->sched, s_job);
>>>>>> -                       if (is_guilty) {
>>>>>> +                       if (is_guilty)
>>>>>>                                 atomic_inc(&ring->adev->gpu_reset_counter);
>>>>>> -                               amdgpu_fence_driver_force_completion(ring);
>>>>>
>>>>> Do we still need this in the case of rings where we reset the entire
>>>>> queue?  E.g., compute or VCN?  In which case we should move this to
>>>>> the ring->reset callback.
>>>>
>>>> No, it shouldn't be necessary in the first place as long as the rings still execute their fence packages.
>>>>
>>>> And that should be the case at least for both graphics and compute.
>>>>
>>>> Forcing completion only makes sense when the whole ASIC was resetted and nothing executed any more.
>>>
>>> This seems to result in a deadlock if you reset the entire queue
>>> rather than just the vmid.   I.e., if you test with just this patch
>>> and not any of the following patches.  In that case, the queue is
>>> reset so none of the fences are signaled.
>>
>> That is just because of a specific behavior of the GFX/Compute engine.
>>
>> When fences are issued while a reset is ongoing the CP writes the fence value not to the requested location, but rather to fence_addr + 4. See amdgpu_debugfs_fence_info_show for more details.
>>
>> That's why I cleared the reset before issuing the fence command in the follow up patches.
>>
>> Key point is that the stuff still executes and telling the core os that it can release the memory by force completing the fences is a really bad idea in that case.
> 
> But the current code (without this patch set), at least for gfx10 and
> newer and VCN, doesn't write the fence, it just resets the entire ring

Exactly that is *not* happening. See what the CP does is to kill/skip all submissions for the specified VMID. But submissions for other VMIDs seem to still be executed.

It's just that fence values written in VMID 0 don't end up at their specified location, but rather at addr + 4. I have only tested this on gfx9 and gfx10 (Navi 10), but I strongly expect that all CP generations work like this.

So the kernel doesn't recognize that those submissions have finished, but if we force finish them it can be that we end up using freed up memory because the submissions are still executing.

> so the fence never gets written.  So either we need to keep this code
> here, or we need to write the fence in the ring reset callbacks I
> think.

VCN is of course a different story, we could certainly add the force finish there if necessary.

Regards,
Christian.


> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>>
>>>>> Alex
>>>>>
>>>>>> -                       }
>>>>>> -                       if (amdgpu_ring_sched_ready(ring))
>>>>>> -                               drm_sched_start(&ring->sched, 0);
>>>>>> -                       dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
>>>>>> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>>>>>> +                       drm_sched_wqueue_start(&ring->sched);
>>>>>> +                       dev_err(adev->dev, "Ring %s reset succeeded\n",
>>>>>> +                               ring->sched.name);
>>>>>> +                       drm_dev_wedged_event(adev_to_drm(adev),
>>>>>> +                                            DRM_WEDGE_RECOVERY_NONE);
>>>>>>                         goto exit;
>>>>>>                 }
>>>>>> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->sched.name);
>>>>>> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.name);
>>>>>>         }
>>>>>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>>>
>>>>>> --
>>>>>> 2.49.0
>>>>>>
>>>>
>>

