Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F162D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 14:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A5110E5D5;
	Tue,  9 Dec 2025 14:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XpyI7Snt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65010E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 14:20:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlf2F5izAOQh3RW2lM0b4sPpPOW7M/2akbXb96fUe4YLPaprNAQEIfYQb4E5y0D1cmEh1zufFDLaxAlZChJP2OqHizPvOda4Ux5uauotDxOkw9zlwFdf12Xq2tUMU5umKHbXx6bFuKwxyAHAc2VFW8arDM95JVzRduI4103PgVPxgO9XjjQhokll7VXxinGM/njbBdiGjPWFAhNmYuxZRIh/BAA2XbIA9ue+55EVPoHwpAMKMWt2Iboj0afShqYAu34Xt53R3aHn0hJa1zsh5qJK8bf0Y7ADvZGX3qFPkoxWiC50w85myLbd6IJ9Qb2ocJyGQ1V31G8FAz1AbeB/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AlNlqV5hcLbrof9O3VRG1HYpSpuxPmOMAveNe3iMf8=;
 b=WbdXQttbpjgp6h059c2oenPjx/uZNoKFnFUAwMs/ZwR4X3LJGiJ0k+G9+AFiugzx99ruCwRHBqSQ6FCTON+FurKNZB+9wyB5q3kZcQ98GeaHrtXiCvLzWn7tq6AWEXL77w3MZ6j8PUzp8LweuspXsCwUX8RDpQVBMBAd+IJp5v8sYb4jln4xw1rPxmm4g7YJ+4by9Inr3KQzOLxmPG7vXuzlaVOFFAi6l+71AXG8/cJ6SwA8XSIOEAHd6/PF/mxkkZrmR00Lou64les2WbBYLpnLxEUwuJs47Ahkmx4W8TLYwzjBKeKSzQdxShNTlFWn44xcac6uOAE2iPZeTUV0XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AlNlqV5hcLbrof9O3VRG1HYpSpuxPmOMAveNe3iMf8=;
 b=XpyI7SntaooIcoke2a0AVRjkH0z4+CjMA5DVcs3xEk0Jalbr7llqEzn6QGETxnw4sxicrhMXMWZGCOjjrN5W50f/1rUQO1S0Dx2Z7VShzf9QFFMHU5HOb2PFBsB5ojqjFQo7PuiPmksjv2T8BHxbqdspfcNVXvvk1BXKSaNTVYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 14:20:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 14:20:52 +0000
Message-ID: <7d624117-f657-4467-8fc2-f7fcca3676f3@amd.com>
Date: Tue, 9 Dec 2025 09:20:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdkfd: Map VRAM MQD on GART
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
 <20251209012538.3882774-6-Philip.Yang@amd.com>
 <9e4ae737-55c8-4fa8-9425-0c88fd0e4726@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <9e4ae737-55c8-4fa8-9425-0c88fd0e4726@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d290a17-5382-43fa-46ed-08de372e2895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTBzN1pTYmdva0pJaDRoenhHVldrTjhISnNwRXkyQjVBUVN1d1ErL25BMTgx?=
 =?utf-8?B?L2kyY1BEVkJDbEQ5YVpIY1NkNitBeDdMd3JPWElubmIwUEZOWXRnUlg5TUkx?=
 =?utf-8?B?SHZPdENPVXd4MVBhc3RZcEFtSUJHdWl2Wkx5eE12RGZZMCs2NGJEb2Q3YlJw?=
 =?utf-8?B?TkV1VWo3SkU5MTd0WTNVcTBqdUpnRTBIRjJsWUhyNko1dkNXbUF6TkRqZW1K?=
 =?utf-8?B?Tk8ySS8yaUlMc0dLelNDUWNGZldWOStPYWd1c1FSendEcHVKUWd2UVN6TnFX?=
 =?utf-8?B?MEZsOXdua2tWbjliRjhNNDFIeFU2bGhyNHBOT1c5N0RadVJ5YVN1Mzd3WFpD?=
 =?utf-8?B?ME5OZzE4QngxcnFwcjBVMHZmZXlHUnFLREg4SGMrOThWdnBJSWVXeWh2dG9S?=
 =?utf-8?B?ZndHaEUwZHJWK09uMS9ZN3l5MzN1V0U0SUw5MTVrS0VUSERVd25VRGpwQUZ2?=
 =?utf-8?B?Q055d0tqTzduYXNubllObWc1aFFVZkpvVzc4R1BzS1RUUm9KYVN6Y3dzMVFT?=
 =?utf-8?B?eEE3L3hIVFBuSUYwakV3bWVBRXo0NjNhT3JGbHZFbk9rQ2NMemlXblZiVDhz?=
 =?utf-8?B?QkhaM2RoVHhzRGs4Nzh2YzdmMEFrbHhneFA1dG8zOW5ja2xaR3JjeXZkbTN1?=
 =?utf-8?B?K08rOUFnRUZWekg0SnBlek12S1hkUDVtVC8xRUphV0VzNlVjVWNZaTh2YnhF?=
 =?utf-8?B?aTlFNnoxcTcrY3U5ZGtpb1BDTHBTdjNWOXBtMUZXMGo4d2Q2MFNON29mbWwy?=
 =?utf-8?B?SXJmcHRGRnhGYmRMc1dGS1JYOWszQnhHRjhEK2xYMFg5TWdqaFBuUENvYVJ0?=
 =?utf-8?B?OTB1WjBNclI1dkVWUVUzSFJ4T1RQcDZHZnRnMXBzRWhSVVRsb29hV3kxUjFk?=
 =?utf-8?B?ZmFBN0pnU2dxSmxESzJrSGJmV2FtTEozTWtrUTJOUWNVL2hvRDhlbUJwdFdh?=
 =?utf-8?B?OFJHYVArb0FJUGJuQ0lET2lxaTdGaWNkQ0JOM2NzVnJXbSs4VkJzYzZBOHhX?=
 =?utf-8?B?bmxyWE5FSTFDbHhIMUtyQnMrbm94TEJlUmFIUlNpZ0xKTEMwVURSajdqNEQ5?=
 =?utf-8?B?RnRzYlVOME5QSlNFenFTV2NYYkdkc3N6NGlsRXc3cHFKNHVIOGVaa1lEcE9a?=
 =?utf-8?B?Qmo1VE5lUGM5Tm9WVDd2eC9HSlNOcytrMkxLU1NFV2xmL09jb3M2aTMzNkZy?=
 =?utf-8?B?Mm16YkJqcHlTeVZEbGVsZFZZQ3JuMkVXUUd5OGFpSHdMZkNmN0NWdkZwTTIv?=
 =?utf-8?B?VnhHeGtZUjJGMytJbXlzUm5IWE9uM2xNUlpjUmRSTTBOWmEyT2NWcmlkTThJ?=
 =?utf-8?B?UDJUUFFydFE3V2V3N3ZhdCtieldQSjFPMHVtS3crV3JkclNKUDUzczVXSXBB?=
 =?utf-8?B?Ymh6VnhDbmJCdU0yb3E5b0NJR1hYWjR1VnNhOFhaUXZId2JlYi82MXRIaW1q?=
 =?utf-8?B?amlsN0ZsZThtU2V1Z3h1N0dXb0NTZHRBK0wxeWYvN3FKSkhaa2F1emg2QUxX?=
 =?utf-8?B?clZjZHhnU3M0cXQ2L1JqNzJoSlpqV3llZ3hIczhBRkRKb0xkcWdrRlZaZ1VP?=
 =?utf-8?B?QS8vZjg2RkY0NCtOSDhjdVFLWWp0NWh5QmplOE1rakZQbHN2OS9tbnMzeGt6?=
 =?utf-8?B?N25YRUZXUGtUVlNybDVackZIYWtYYmdnZXdBTEJBWEJsSFdMVmQ4ZURIY2U5?=
 =?utf-8?B?dW14NVRjQ2xrUVJISHJCR3ZvUHNNeW9OZFRmaXB1ZVJVMnVENk05akRWcWNN?=
 =?utf-8?B?bUNXWDFiei9yQ0M1OEU2V2NWbUlzb0lMTzA4cnUyaERjZ2RrRGFiMThIeDBz?=
 =?utf-8?B?VmJYZ2JUVWFId0dtc3lOUkg5L3d4d2JGOVVuWEFFK09YZDFQUTd1d2RXVTkx?=
 =?utf-8?B?dEdyZGV6UEk2ckE0Syt3V3Rqbk1yUkMyenpsOWxlQVJTRFZ5SFdmc3RaYW9E?=
 =?utf-8?Q?UdDgABxtrGkPZfHNmWmerDYI1ZvbIyva?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25ZMUZkVk8vVy9hOFNUOWtyTEdZeFJvZGhiNGtoY0lqVlNhV0h4NXh1RWsx?=
 =?utf-8?B?TytlMk5TdTlZNlpreWNZY1FBbzRoa0t0ZjhidnNxUWcwMmJBRjdZbjlWc2w1?=
 =?utf-8?B?L21tZjM3M0NoUi9ETTVTMzBBZEVxNlJURmxNUS9IMldOaU9sV0o3MWp2YkpH?=
 =?utf-8?B?ZjJwOGRIUHJhaEQ0bmZWSjBFYVhad0NBNzRhaWROVm1VNFZhRlZuS0FPcHlB?=
 =?utf-8?B?TFlES3QyajBrVHc5KzdFOU1lUVEzcU1mbERVRVEzb2RTZ3VvYVd4RFUxMlY4?=
 =?utf-8?B?NHdLdGc3Mmp3S1gvbTk2RndseVJqcG5GblRDUXcwT1dYemMvOFlTUUU1dXhj?=
 =?utf-8?B?WmpVczRmcjlYMlpmUDliNEZFZkxXRHdDSkdBMEpVaW94V1Nhcitnc1VjemVT?=
 =?utf-8?B?Z3RGZVhDSU9ZVklVblp5UEQ2YjFvQWtlMGgzZHlkM0Z4ZUU4UGpqeXFDQWx4?=
 =?utf-8?B?RFBvSS9Oak16cjVBWU5FTGJjMDkvcGw4UjBjZndHRnc3dFZ1T01LRHpsVXdG?=
 =?utf-8?B?ZFFsbnZhQ3E1UVpjclNOOWVLL1hEMnJrUUFrY0RUY2s0NVJJV3A2UUJrcWM1?=
 =?utf-8?B?ZWJWK0J5eFVNRkxIYWxLNzczU0pIUFJiSDE3dFJYWnFibXUxSzRFSy9IY1Rh?=
 =?utf-8?B?QTV6Sk05ZkdpalJaMXR5N1Qra2ZlTzJGUmFVQ2tpNlc1NXE5VDh1ekhqZUpU?=
 =?utf-8?B?azVFWXBUZVRoWXJvL3JDZXVIMHBDTnlYSnZ2WTRlSWNmdlM3UFkxYS9BRCtt?=
 =?utf-8?B?UEVFeUl5QUVqUVNtaUR1S01lQ1JLbng5VStNamZRd0JRTlBFeThFM3g3VzJE?=
 =?utf-8?B?aEk4aGxQUEVEMmhTOFZFb3Era1E4UkhNSlpuNWNxVDk0ZXdRazV4Sys4SkhV?=
 =?utf-8?B?VWdRQUo5a1hqd1ZGaVlodURJWE1lam9VditkYk5ydUV5NTdrS1d3Y2tPUmdI?=
 =?utf-8?B?OU1nTStVU2d4YUNhZ2ozWXJHVlczNEMvdFloZlE0d2VqZGFUUnR5VExhQnZp?=
 =?utf-8?B?Zk5qQTJBN1dWM1NmU25OT2tpMXFUcy9yOUpZTys1UXZ3K2lORFNKdnZoQTVM?=
 =?utf-8?B?LytBazNMQXFubkpwRHllUHhFdkRVaHAxZHJvRVA1L3czMzdNcUdwS2VTLzlM?=
 =?utf-8?B?bmswYTJFWWg2YVJia0Jod0tpZXozdExDWGhLSzlnaU1oTmYyZnE3UXdVdEdo?=
 =?utf-8?B?V2cvNEE3dUpuRUhuZXd6MzFZQXQ3cGV2SnY5bldhY0ZmdCthTkFRQSsrMmt5?=
 =?utf-8?B?a0o2ekRtZVljZGhhclF5Zi9NR3ZDOVZaM2pwd3JxaHhqd0FJRkxKMGdDemdP?=
 =?utf-8?B?cEJscHl6Y2Qrend3MG1RbUFETnYxUHA5bU11d01sNHllZEpQc1htTFdmUE9x?=
 =?utf-8?B?UHNjZzlvbklLTUdtVVZwTHBlRVBrOHR6eXRaaHdsYUpWa2JrclBuSnNSWkdR?=
 =?utf-8?B?T095LzR6NGhRUDcwaDlqNjBZSlpEa2huK2FZbm96T1dqTnYvT3c3L0xmeHd4?=
 =?utf-8?B?Y29wbkZXaFppNit4Z1NjVUdtQ1pQRHl5eUVuUHNGRlpXaWhuU2UzTmF1K0pn?=
 =?utf-8?B?UnMya0VCQ0d3RlpXdmxlRmNkTE9GMTdyTVNnc2RZeThiYVBOdnYySE9zUWhv?=
 =?utf-8?B?eWRKVm5jTGJ3SkFTaldKTzQ2b0VHWFNJTDl0cXBscG80ejl5WVhONktzS01C?=
 =?utf-8?B?YUg1MkhDVG00dENlcUE2YVIxYTRxd01MR05MYUZJcWl6ZDRpSHdqVXNYTHBp?=
 =?utf-8?B?T0hXalQrbHRwQ055UGRwdXo0MUhZeEQxTW9aN213czFvMmtwZ3lwTGptRXJH?=
 =?utf-8?B?M1c5bjJRWDRFOGczV2U2Uk1oVGZCZ2lISXlNam1TWlRoUlVqTFdvOERwc0ls?=
 =?utf-8?B?aG8xK2s5QlZTanRsQmU1Q25sMVp1OG9TQnhSUnZBSkRndkRPb1hSRkgraUFD?=
 =?utf-8?B?SUJjbHd0K3lYSS9TVU5wcFhYZ1pmV1dPekVnYm9KMlZVUGJxakZ5MDV2TCtr?=
 =?utf-8?B?U3FoT2pLckNFV2lJR2pNejd0L1lwRzE1YmkvSTJ5b1ozREdwVEcxYS82MVVE?=
 =?utf-8?B?UEZubm9pVGw3eFBoSCtrZS9PY09kT29IbjZEWW5adjR3aFcwcmRKVGFmWGk0?=
 =?utf-8?Q?XZfE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d290a17-5382-43fa-46ed-08de372e2895
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:20:52.3905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va7Q87yqnuEkISFE+frTgNcVaV6V3ZnvfVLvbgNqhwTuISREhMqGJemhwcVAHtaQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186
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



On 2025-12-09 04:38, Christian König wrote:
>
> On 12/9/25 02:25, Philip Yang wrote:
>> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
>> to GART as mtype RW caching, to reduce queue switch latency.
>>
>> Add helper amdgpu_gtt_mgr_alloc/free_entries.
>> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
>> to GART entries.
>>
>> Add GART mm_node to kfd mem obj to free the GART entries after
>> MQD mem obj is freed.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 37 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 71 +++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 10 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  1 +
>>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>>   6 files changed, 129 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> index 895c1e4c6747..c83e1cf1f02d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>> @@ -321,3 +321,40 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>>   	ttm_resource_manager_cleanup(man);
>>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>>   }
>> +
>> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
>> +				 struct drm_mm_node *mm_node,
>> +				 u64 num_pages, u64 alignment,
>> +				 unsigned long color, u64 range_start,
>> +				 u64 range_end, enum drm_mm_insert_mode mode)
>> +{
>> +	struct ttm_resource_manager *man;
>> +	struct amdgpu_gtt_mgr *mgr;
>> +	int r;
>> +
>> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>> +
>> +	spin_lock(&mgr->lock);
>> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
>> +					alignment, color, range_start,
>> +					adev->gmc.gart_size >> PAGE_SHIFT,
>> +					mode);
>> +	spin_unlock(&mgr->lock);
>> +	return r;
>> +}
>> +
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
>> +				 struct drm_mm_node *mm_node)
>> +{
>> +	struct ttm_resource_manager *man;
>> +	struct amdgpu_gtt_mgr *mgr;
>> +
>> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
>> +
>> +	spin_lock(&mgr->lock);
>> +	if (drm_mm_node_allocated(mm_node))
>> +		drm_mm_remove_node(mm_node);
>> +	spin_unlock(&mgr->lock);
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 4f8bc7f35cdc..43009d3809b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>>   	}
>>   }
>>   
>> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
>> +				struct ttm_buffer_object *tbo,
>> +				struct drm_mm_node *mm_node,
>> +				uint64_t flags)
>> +{
>> +	uint64_t total_pages;
>> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
>> +	uint64_t page_idx, pages_per_xcc;
>> +	uint64_t ctrl_flags = flags;
>> +	int i;
>> +
>> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
>> +
>> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
>> +
>> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
>> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
>> +
>> +	pages_per_xcc = total_pages;
>> +	do_div(pages_per_xcc, num_xcc);
>> +
>> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
>> +		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
>> +		u64 start_page = mm_node->start + page_idx;
>
> Again, don't use tbo->resource->start nor mm_node->start.
This is fixed in the next new patch, it is easier to review separately, 
will squash 2 patches into one patch after review.

Regards,
Philip
>
> @Pierre-Eric: can you take a look as well? Philip is basically allocating GART space here as well.
>
> Regards,
> Christian.
>
>> +
>> +		pa += adev->vm_manager.vram_base_offset;
>> +		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
>> +					   flags, NULL);
>> +
>> +		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
>> +					   start_page + 1,
>> +					   pages_per_xcc - 1,
>> +					   ctrl_flags, NULL);
>> +	}
>> +}
>> +
>>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>>   				 struct ttm_buffer_object *tbo,
>>   				 uint64_t flags)
>> @@ -1017,6 +1053,41 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
>> + *
>> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
>> + */
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr)
>> +{
>> +	struct ttm_buffer_object *bo = &abo->tbo;
>> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>> +	uint64_t flags;
>> +	int r;
>> +
>> +	/* Only for valid VRAM bo resource */
>> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
>> +		return 0;
>> +
>> +	r = amdgpu_gtt_mgr_alloc_entries(adev, mm_node,
>> +					 amdgpu_bo_ngpu_pages(abo),
>> +					 0, 0, 0,
>> +					 adev->gmc.gart_size >> PAGE_SHIFT,
>> +					 0);
>> +	if (r)
>> +		return r;
>> +
>> +	/* compute PTE flags for this buffer object */
>> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
>> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
>> +	amdgpu_gart_invalidate_tlb(adev);
>> +
>> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
>> +	return 0;
>> +}
>> +
>>   /*
>>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>>    *
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 72488124aa59..eff536f12cb4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -140,6 +140,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>   
>>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
>> +				 struct drm_mm_node *mm_node,
>> +				 u64 num_pages, u64 alignment,
>> +				 unsigned long color, u64 range_start,
>> +				 u64 range_end, enum drm_mm_insert_mode mode);
>> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
>> +				 struct drm_mm_node *mm_node);
>>   
>>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>   
>> @@ -185,6 +192,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>>   		       u64 k_job_id);
>>   
>>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
>> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
>> +				  struct drm_mm_node *mm_node,
>> +				  u64 *gpu_addr);
>>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> index f78b249e1a41..0bf9c35112fc 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
>> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>>   	      struct kfd_mem_obj *mqd_mem_obj)
>>   {
>>   	if (mqd_mem_obj->mem) {
>> +		amdgpu_gtt_mgr_free_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>>   		kfree(mqd_mem_obj);
>>   	} else {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index 14123e1a9716..5828220056bd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>>   			kfree(mqd_mem_obj);
>>   			return NULL;
>>   		}
>> +
>> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
>> +						       &mqd_mem_obj->mm_node,
>> +						       &(mqd_mem_obj->gpu_addr));
>> +		if (retval) {
>> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
>> +			kfree(mqd_mem_obj);
>> +			return NULL;
>> +		}
>>   	} else {
>>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>>   				&mqd_mem_obj);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 29419b3249cf..fdde907836fb 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>>   	uint64_t gpu_addr;
>>   	uint32_t *cpu_ptr;
>>   	void *mem;
>> +	struct drm_mm_node mm_node;
>>   };
>>   
>>   struct kfd_vmid_info {

