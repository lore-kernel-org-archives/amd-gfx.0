Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C935CC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 11:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E80310EBF2;
	Fri,  7 Jun 2024 11:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbdDrUK2";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281CC10EBF2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 11:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HL8e6YlIh+ZwXtOdqgrYqDCi0yxFseyBj5Hp31V44J9tUQ4CsRQdsWpUzLwMywUvn5BMOqG3ACc2NGoumWWM7vwtwTeTom/aFJjynnhBFrl674/xSmtQawLfCBWN+uiw2uwJouT904wQF1yLZipXixb9fDhMW1uKURhQ+qvo+aOsDi64Q7yoAHkbPIo5XyultD38Vv3vuNPa+pLh7hxMc83Rdvc7xZXvHBPdA3J6O4YdzlY4FmbFPEPIMmzo7jupAXOJOFYJdYvHTS+98eZ6cKC40Ry07ZK0Zy2Kc+4TLbh/1FuLwvM1aZsIDkY+eBhVcjAg47Q3cFQ3bhgyZTOlgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUyM+Dk091xY8hiEVoW+kMq7hhDZNP3awwFhk8IA+nE=;
 b=hZayPnbsLFy1kK34BL/1z4C6aEQUWe+iejNqRDCajFgUqvhWApXOCeOB3zu3Q4ACV18r1hdrtIzvCSyXPXsZWtSUDf+x277Nh5UCn/utdyFO/Wla0lLNZ3dAxwNTW/tl92noko6zAUn9H7bx/Y1X4sGABCzEjSyabui0FlVHMM9YmSBJ9R1zjE0OvMMs4ubTexWlo1tuEVBGVAK3LoTDYDGy+PhZJI/iyM5hh1w+nQBieuDwBfSB6MRXDTbQ+JdrbJQNGsyPmllYldMwWuWHv0anwEf/IGb7Kd39O1+diQkjppqwndNwIR5p2dVJIGNJmOKDABEAVqdPlThh0lkzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUyM+Dk091xY8hiEVoW+kMq7hhDZNP3awwFhk8IA+nE=;
 b=YbdDrUK2Tk+tCZ1K6pZIvMaFEkQ0d3UIerqulN0QHthFkS2fOraLNHCLkE+2Oey9TRTx+9Tc6gibRcuPVwy9XXRJrzIccy9aaeezvHORKrp7fPUINc4bQG+2EEKboFxp3lNxUeLew4dug5ri6mRFkoC3aOb2NB4EY2rW4PwRVK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 11:39:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 11:39:36 +0000
Message-ID: <6b45df71-1970-4ef4-ab08-73d75a24e490@amd.com>
Date: Fri, 7 Jun 2024 13:39:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix dereferencing null pointer warning in
 ring_test_ib()
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 Tim.Huang@amd.com, jesse.zhang@amd.com
Cc: alexander.deucher@amd.com
References: <20240607083336.65752-1-bob.zhou@amd.com>
 <20240607083336.65752-2-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240607083336.65752-2-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ba5d14-3a59-4861-bf12-08dc86e681fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SXBpcWR0Qk10bE8zeTBHcEJqMjB0R3NaNkM2b0NoY1M5ZGV4WmZnSTluRHY2?=
 =?utf-8?B?TWJXL0NzWHVXTXlSTWFTTDZhTkh1dy9vakpSZ250cHphQTZXV1RCQmIzY0xv?=
 =?utf-8?B?NE1CZkhQQ0VKMmhtaTltTkR0S2tHWnFtdmFuSFJDWmlJWnFoMEZuVmJtTWM4?=
 =?utf-8?B?eTJTeGoxUnhtdUliSFZzREQ5eEhSbEtVdnhzSS9pQlk4WXZxK1h5ajRTSWIy?=
 =?utf-8?B?WU8wWitkOEdKa253YXN2Y2NGT3p0ZkxCM2tLcFB5d3hkdWNiR0lIMVJLcmZT?=
 =?utf-8?B?OGRhV2Q3K01lVGlCQTNHS01ZTHpoUkp0L2ZubWdOcVJXVWpMQll0bjJsYXZr?=
 =?utf-8?B?QnBjT3BWVnJFUEF3WEJQekF2VXhWdUJyUnpWVE5LOTdSelg3K2U4bFR1T1B3?=
 =?utf-8?B?YkN5WmdFWjQ0Zyt0b0pvZHp0d0J0VXNGOHRXWWNBUEJQMUJ3S2U4L1ZaQzZq?=
 =?utf-8?B?ZS9xdHRUbFpYTFp1WktCOUR6NzBoanBhZjlzM0xQSTR1QkRVQ1JaU3VmK1Nt?=
 =?utf-8?B?TEt5YW5yTnZ3QUVBL2tHN1gvM285eFliWmhkR25UTkxSMGRQYWdmc1h0bnJY?=
 =?utf-8?B?bENnMXpnemlscmRDZzc0b1B6d2tnK052OXBoRXNmdXNOdVIxZUlwdW1mU1Nt?=
 =?utf-8?B?d25QazNZRlhtWUtONDRocEVPMW1WWGFmank4US8yNGt1Y3RYLzMxWStoREIx?=
 =?utf-8?B?TW5Nam4ybng4eE5XbUtvaENkcU9Vd3kyZGNwRnFEVHd2aFFHTHAzR2ROSUtR?=
 =?utf-8?B?U3RUY0dNNkRNRnppY2RtRkZIWDJjWTB0cGVsY2FqTWJ6U2s3d2NEaUluc3pS?=
 =?utf-8?B?UmE1eWxxbTdrUzNNNWNCemdBdHZQK05IVFZoblE5aWpTK1JOajVTTi95Mk4w?=
 =?utf-8?B?RUUrZlNiQ285UzNBL0NVQTNtSjJGa3VqR0tIMDVUK1llQVpUSmU0ZlNMWUlS?=
 =?utf-8?B?ZGJyc1RUQ3BkcEFyemoxenJwZ0dKTUlVbWV2TTQyTE80TG5NRFozemVZalUr?=
 =?utf-8?B?WFBkWW84SnBLK2hxenBONGRGc3VrSEZnZjhpb1ZqaFMvV1N5S2pKZC9oNlZp?=
 =?utf-8?B?NERJRVRwN1BKektwVDdHQVA0YlhkZUNTd2oxSVlqc29iQzJoT3JyZkphN1U5?=
 =?utf-8?B?aVpMNnV6MDhreHZ6NXJZY1BDd2xWeHBXNEpWSGtCTVFyOE5MMGd4VVJVcFFY?=
 =?utf-8?B?ODhHeFVmNnB4czNkYmJoWnRlRHdYUWx4ZlJMUll5T1MrTklqOEF3V0xHcnZX?=
 =?utf-8?B?VkNQMzRNQUJFU3J1MUlhd2hIeVdPb1F0VUFRS1dRVjlCbDlBNXpYVnBVUmNh?=
 =?utf-8?B?NXgxRlI5QXg3dS8xVHNId3A2UXl6QXdZVFo4Uk9DTUtRdUVoQzlYajlKMjhV?=
 =?utf-8?B?ZnA2b2J0VUY3aXFyLzRpTTdMK2ltaVAzaGNDTUtCZmp4SVhWTDR4aDI5aXFG?=
 =?utf-8?B?WFlaYUUyMHYwUGFvdFcyZ29vdmV2dEhtRUU3dEhRZ2lzREllb3lzS0RqaS96?=
 =?utf-8?B?aVAwY2ZxOTU5U2hsQkRNcTRqRGNjdG1tbzFzRmJuQVF5ekVBWnM1MXBzS3hY?=
 =?utf-8?B?eEE2YnhwRGxHbUY0dmQ3WGtLM0pnR081NjBkYTFKSGZ3bGQzMXczR3NjWWty?=
 =?utf-8?B?OGh2eU5hTlFXNjFlcWhEeENHRHBLZVZ5c2xWbEVKVHFGU0QyWXRCcW13RVBE?=
 =?utf-8?B?K0Fic1A2a0taYSs4RkNtdGRFMXZnb1Q2U1JkbkVmQjhtbE8xU0w2YWhKVGVO?=
 =?utf-8?Q?iV4lwHkmrLIwUCcJOo5Jh0JvmfeabKdYMC07m26?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hhMVpQZE9OS0VJSWRpVW1QQmVSUEdiRE9ycEJOM1dPR3oxRDR2cDhSR3Ux?=
 =?utf-8?B?Uzl3Q3kwaWJhcHk3UlZ0Sjl1VVFPUmhEc3dNelZ2TzZ6OEhGNDY1Z2t4akdn?=
 =?utf-8?B?Myt0ZVhiMFcrWVlUKy8yMGxxQ2hHWlhKNkRSSjNqd0tVRFdJN2lwWVBqZGlZ?=
 =?utf-8?B?TmFBeFpOb3lsVmhTQkNRMXNwa1JtZ3lSM3ZvcTVNSndzRmhUc01LSDZvOW5W?=
 =?utf-8?B?UVhYQkExN0QzbUpGdlRCZFVvR2RnTk5oeTZpVFpjbXBndElhUVZTRktjeWM3?=
 =?utf-8?B?cHZ3SHNla2Z5bzRhN0ZjdkNITDd2eDg1NnlhWW9MM29pMDlTL1FiVkMrR3cv?=
 =?utf-8?B?ZVk0UFNsUWxONXdYTGtVYVBrR0h2TUlUOU50ZGw0NS9EWjduRHQzVkR5Z0lE?=
 =?utf-8?B?NUhDQ0hxODRCQXlPVzdxTFFXRTY2U1dHVDc3bmpvaDNZS0pLeHlTUnJNb1ls?=
 =?utf-8?B?aUhXZ3NXUkt5YXp4ZDkySndhMWtZM0puRHlSUTdvelVKbHo4U2E5YkUrb1cx?=
 =?utf-8?B?SGJrMkdNZEorQXJLNVByTmZMcUN1NDVDalhqMkhlZk12ZDhCaEhvRWloTGww?=
 =?utf-8?B?Z3phRXdhSWhoMDRxQUY2cmsrVHN6NWtEU3VGTmlQbTdFL09VajJVOFNLVHB0?=
 =?utf-8?B?cFViekMwZFlvQkdDdG14QnVBcmt6b3ZNQmZIYTNHbUdMNEpmOFRhK0VqMjU0?=
 =?utf-8?B?ZklkTHlaOXRpZ3VVUTRMU29OU3hRcVIrVWllWlRGdWxaclFFbUlLbkQ3aEJU?=
 =?utf-8?B?MG10L2JlcnFXMWttaXdZRFhjTUYweERMUzRnR1VncllCTEh4VjQxOWU0VFZz?=
 =?utf-8?B?YnBDcjBYYXQvVHI5bnJGRU9aWkdyNVpGKzVPOWRCejFoQ014YllzOFhHNGxs?=
 =?utf-8?B?bWxJRVFDMnZ4bTRpOXJCYWtNN2trRG1rN0M1TllIcElQRTZVa1dKTDgyR1Na?=
 =?utf-8?B?c1FacWw3UTgwQ0RaMlpFR1lpbHRUQnJ0VjlpdkduMDBJVjBoRGZnRkwrNzJw?=
 =?utf-8?B?bjVQQ3dhOHBBWmpoM0l0OWJSR3RqVTRlbkYzdTBYK3Q4M2x4bEZWOHFlQXFp?=
 =?utf-8?B?VmZiLzJlbXJFaFlWbTBnVDRmVnRiK1F1bUlTemhSK1h0TSt2b0ZSQXo5Z0d2?=
 =?utf-8?B?WmI0VWZqTWZmVXlGQkRQell4U3dQZTJtSTZsYW1qVytTbFJPWlh6dXU5NTIy?=
 =?utf-8?B?R3NnNzdJMW03RTl2d0xKNTVpUG5HYVd0bmlLeHZpbkhpaXdFMkRTdUFsaE1x?=
 =?utf-8?B?Skpjcy9Oa2FIQTBZOFJwWHp0Q1JuUzBxV2d5QmVPdmluUE4yK3NIOHdPMUUv?=
 =?utf-8?B?Q0NVc1ZtY0I1czZ1R3lPMGErWTFIVHZXZDZPSXdvTXRhYnJzY3VJQlRMTlM3?=
 =?utf-8?B?L2F2dEphZndYTnVYV3hmNnRYWjlSaXZ4ZUxSMFU4RDFpZGtGaEtzcGpHcXdu?=
 =?utf-8?B?RzNmeW5uNnNTeGZETWVYYjRxN25rUTE0S1pzUStPRTNvL1dDNFZ0WDl5YVZ1?=
 =?utf-8?B?TlZEelFqR0pOWmFEcmpLTms0eW9sZURoNTh1bzdSOVhsMFFaTW1qMUZCaldw?=
 =?utf-8?B?eExEaVZra0FuZUljQ1JNcW5yK09ac0RnUzErMHpiZWhKTjhha25ndmlKTWxq?=
 =?utf-8?B?MjhlZzZSTXR0N1QrQ1FJRXNKTm1tYkxWZklKdEN3R0NSZ1RQaFFsZFpnRE5k?=
 =?utf-8?B?MUFXdFpFVXJsaVRqVlR4ZCtUZUtOQ3RBcVVsRGJhK3JMem80cDJ6YnNFS0NO?=
 =?utf-8?B?MVprT3RERDlxZkVGQWpvN3BhaFdCcDF5anplNDlWc1BxQTY3R3lQdW0yaFJa?=
 =?utf-8?B?MzRCK2ZIazBlUkZKQ2ZVQzJxNU82dnpGNk11VXkwQkpVZG9PYWhPSXdBRlRv?=
 =?utf-8?B?d0pBQ2hXdmh3VGhBL0pyTzhuTHg5ekg3S0tJb0pzRWZtamJhMGI4YzFoS3JW?=
 =?utf-8?B?dGZYVUxNbDRNaVBORlhST3BxdVRlbFdTUVVIQSthWGZVUVVDb3ZwNkEzQ3k4?=
 =?utf-8?B?Y0RCV3BWUDNnVExEZkJiakZOWFBuc29Lc21sdDNSQmI5NW85aTE4THczbE9I?=
 =?utf-8?B?elpyYjJ6Wm5GQWFublFnelJkZUhqdjUzREFMQ0VKQWt0dXBmZ2J5aHgxVkxo?=
 =?utf-8?Q?f+YN3hOVfUDzIGORQEryJ8qeL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ba5d14-3a59-4861-bf12-08dc86e681fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:39:36.4469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQxGSKhQ6DIAUREYMBzUd41VVaY/MokVPbon/ha+OHTenu56FkNIWe9mgswKH3tu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
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

Am 07.06.24 um 10:33 schrieb Bob Zhou:
> To avoid null pointer dereference, Check return value and
> conduct error handling.

That doesn't make much sense.

At this point the amdgpu_mes_ctx_get_offs_cpu_addr() shouldn't be able 
to return NULL in the first place.

Regards,
Christian.

>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++++
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 4 ++++
>   6 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2a510351dfce..f131f96a734c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -547,6 +547,8 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 460bf33a22b1..b5719760abe2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -322,6 +322,8 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, padding);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, padding);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = cpu_to_le32(0xCAFEDEAD);
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index b7d33d78bce0..56edac57d1e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -984,6 +984,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -1067,6 +1069,8 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index cc9e961f0078..3e5316a24c90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -824,6 +824,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -907,6 +909,8 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index c833b6b8373b..c1d6ece57bd4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -846,6 +846,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -929,6 +931,8 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 96514fd77e35..2ea988e7e242 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -859,6 +859,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);
> @@ -942,6 +944,8 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   					 AMDGPU_MES_CTX_PADDING_OFFS);
>   		gpu_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
>   		cpu_ptr = amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +		if (cpu_ptr == NULL)
> +			return -EINVAL;
>   		*cpu_ptr = tmp;
>   	} else {
>   		r = amdgpu_device_wb_get(adev, &index);

