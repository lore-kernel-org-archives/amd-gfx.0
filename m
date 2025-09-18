Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18009CA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 14:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B38BC10E0D8;
	Thu, 18 Sep 2025 14:18:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u2IhCFHF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013046.outbound.protection.outlook.com
 [40.93.201.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADFC10E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 14:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fu9VY40QAb35HG+XOuB2H/PQur50UuJvzUDcWUFOFazQlNptpuh+kZYCQe1FVRYlMwcuZRE4wjIYs9m+jljZ8rzgA3NU4XBM0LiUTomdRwC33MObkw1zYgtXBhFjrHsJlkAygY9Hm8xl5o4+FZp327/asJwEZG6AaN/ccHg02YYiwnlEqt10ahq8KSOkbSJpm/wea2Tgp0x9NG8dukwuWHiTyDkurjJt9hICTLDG2lNgcCIlMgVMwbHc0W3NL0+LB0xMVrZ7WYaE+IW66/3vgNYjaUxU/HS9IgAkXnxUYaqWWpZFs08yVH5ecH6TGTQt2Bk/Rj2wterR00K4ZMpYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SesN915hJsO3WRdVizmwY212VhC8spckCVtOEMY3cIs=;
 b=yHBE84Vc66OESGHabgPHKoXLRL5Xa5ojP7AfLi86FdyzHBJNiB5WyUcuhkE+0yMvb4HaojsyB6Yl130GbxLIi6/oW/AX5RgWgcEsZF7a/SfGKYbiaKX6T8pWCzIcTB1DvR9w+LjFU1VAajJ9d4GAQiY3loW2gKsiVkIg4fk1suOX3gGGOw9SF+L5AuU4a6RObDnYpmkgKl6ihlawLrRPgTYMMZ3gxABZ3o11EvsrOccEm6lNwgsGeHe84JXyjP7tXRpZpNyiiLgHHG5fDFWKGGC7IBtMjKeINJSczV1fptpAzZCgA8SfPM4CBNXPdzxwb0hNpqmDfWr6bP6laFuTkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SesN915hJsO3WRdVizmwY212VhC8spckCVtOEMY3cIs=;
 b=u2IhCFHF8sXw7OqIcWrXLWF5ZC9iJufqBvxsScCh9tijft2CNEydoRvjh0jm9ipbgendZ/cXKmURTl6/CRsOL9oqjlJcMxaKzyacO9hLAP7zMoGaXYi3zyGyx/IrVXJy6m4Gyvn+VjqZ9LXpCS/Z8mfQCOth3S8B247gmwVmYaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 14:18:43 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:18:43 +0000
Message-ID: <a70b33ff-6fb9-9db5-c935-26f64bcfbc26@amd.com>
Date: Thu, 18 Sep 2025 10:18:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix mmap write lock not release
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250916224125.29338-1-Philip.Yang@amd.com>
 <b22f9f1f-0427-432c-a472-23e1fd934d46@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b22f9f1f-0427-432c-a472-23e1fd934d46@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::41) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 787e9128-c2e4-4023-c8fb-08ddf6be4586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUpRUk1Ta3d4eXlzS3ZCRVVrS1RBSHlEeXdHT09HaDZ0RUpucHUwQzI2UCtt?=
 =?utf-8?B?Vno5WkNRdHg5YWVXT2N4SUR3eWZDWERyV3diWFROLzVuYWVPUkxVVnJSV003?=
 =?utf-8?B?Vk1lTmJVNkQ2bmowekU3alhmM3ozb3RMN2FNK25WVWMrVS9TbXZFNzJ4Q0VW?=
 =?utf-8?B?RS9FNzVKU3U2N3VOSlNvRnJGcmdXSldiN2pNTDhQdUtvNHZwRlpLdGs5TEZQ?=
 =?utf-8?B?TGJSRnB1aFlSL1l0dC9nY2tsRE5BUUwzY0VFd3R2djJWeVgrazhWNEJ4NTEr?=
 =?utf-8?B?dHczb3NxTlBmVVh3OGtTS1ZLZlFrSjhsS1lId2lPRFdNdXcybmhSZEVJd0FN?=
 =?utf-8?B?aHF4U052L2JzTXpZVStKMmZ2N1NKcW5ja2JZV3dzZ2kzbU1ZRjN1bjU4ZHdj?=
 =?utf-8?B?Yk9nKzRydmFZL0t2QXh0aGYrOGtzT1dlaThsbWw2MmdSMlZESTJ2WFJ2anZN?=
 =?utf-8?B?cURjV3hDbGRXRjZDcU01UDZ5bXpXU1M5NFhObXlWVU0yVDdIalYvSmdQKyti?=
 =?utf-8?B?amhXY1VRNVI5MC8wRHE1M1RMTVFTb3h2SmZCQXdzZVRmVlJCS2pyTDk4L1Zz?=
 =?utf-8?B?ZlV2cURxTGJPQWFWWGw2QzlXbWZFSitPWDRBS3NHZUp4T2ZJTFZSaDBLeTRP?=
 =?utf-8?B?RG82YWhXUlR5S2NXclZZVDQ4NXdkWnRvVytpcGlkZTlabmtlM3YyMmNQWHpn?=
 =?utf-8?B?a2gvemhubkFRdzlPclFxSFpobk1JY2huaHUrdVJjTEkwMkNGSGptRFVTUmNZ?=
 =?utf-8?B?cVJZVldzZjhtNDJLZ0lWSWMrOU05Y2hHZVJPbUxGWDRib1htbWluTjVxOHhC?=
 =?utf-8?B?amo4eXdmaEUyQVgyTE1kM1AxemtOQTJXeFN1ZmVTRG1lLzh0RlNPNnpTVWcw?=
 =?utf-8?B?Q2J3Wk5aUkZtWTZhVWRuU1UxOEo3b1pudEs4TFh4Z0lGVWtpNDlxY3c0YXM4?=
 =?utf-8?B?TlRsWHRlR2VDNERFb3hVQWVDS2pKSzJWcmticDUrZ3Y4b3hhWXErRHFzUzBM?=
 =?utf-8?B?NStrTXhTeFNXSGN2NVRGRkRiZXMwNkZlYklOOFNYUDg5dlpvYUMvWHNtUjZl?=
 =?utf-8?B?MXl4cDdTV0ViT3lkZnhWZTBlZjBXSG5vZnhJTXJsMy84SllMUmg3bTVYN2JV?=
 =?utf-8?B?TTRVMTlsVVFxcXQ4SkVmblkyTmJ2U09XSDY1NnNRNlFwOHRWbXNzblVoYm9p?=
 =?utf-8?B?RlZFVFk3bnFXY3ViS0hlRjF2bk96TDJNUFJPRXlZWWcvMHhHTWF1bHlndy9i?=
 =?utf-8?B?MHk4N25jZjV6Y0pjUG9rdWNmQzh1YkJudlpBdVdMbjc1TTF6aXFMb2tDNklq?=
 =?utf-8?B?a1RFeDZzQk94eHI1Qmg4V3NOazhHcDVsS0FZQW91VEZSZW5ScXhLWXhUdU1z?=
 =?utf-8?B?bkJrejhWTlozOHJWejZhamp5UWhXTXNCRW04TTNwMXVJNFY0MmRrV2djNzFs?=
 =?utf-8?B?NlJDMzRtQkQ4SjBwT1VqTncyWkxKQ0xib1VMeG9HYndLSGdQTERHQUJYdmZx?=
 =?utf-8?B?YkFoRk54ekZONk5KdUtYY3doeldna3RQS2M3S09WdjdPK0dzVXJLWWZZdFI0?=
 =?utf-8?B?RDZKVC80R0RQakNWYmF3dlRCTVQzRm5Db1JPTGpRNW0wMHpoRUcybjZaVkxP?=
 =?utf-8?B?QkdVZFFHK3poOXJXQ0JyaTJURng2ek9SUjNBbU91K3lYSzFPNkJiQUkvVS9J?=
 =?utf-8?B?Nm5aODBqTXBZWHlybmpnTTdpczlKS2xmZFJ2Z0tuYTNKMmFkVnNQdVF3OVA2?=
 =?utf-8?B?bU9xU2tYVk15MTV1dTl3anZ6TXcvZE00WFNiU1ZzQkQza0RXemNtU3BqVmJr?=
 =?utf-8?B?Z29zRDJkSlMrSEMxT1Z4TXdBTGp0NzV4Qlpmdzd0RGdCcXd2RTNkaGI1Zjk1?=
 =?utf-8?B?UE5JaDNRcFJnNFB3dyt4eXNXdzVnRTZEQ2FlMHM4YmdGOW0rSUFoekROWUc5?=
 =?utf-8?Q?1+Uapdes0do=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2kvUEJBOGZLN0R5UmdlYzR2ZG1nMnE3djFvYldHdzFOcklMV2lCT3IwamMw?=
 =?utf-8?B?QmdWZXljT1BndXN0Y1NnZjdZUFUvQUZpdU8vMkRYSSswZEJydWVwWEFSZC9l?=
 =?utf-8?B?ekRXbG1RRU8yNnU0NWZnd0h4NFk1RldCbDZ5ZXZWbkwyRXBVU2FEWENWSnVu?=
 =?utf-8?B?QVFyZHFsUVR4c3dWSGM1K3pJQ2kwSFhMd1NzaHNSUlFVazhlV0xIY2l2Yzd2?=
 =?utf-8?B?eWdJTHRnNjNkT0hjOWU5SXdxTU1jdXVsZnRYdGl1VkdvZHQzT2ZMbnZHZXlY?=
 =?utf-8?B?SUY4SEtNb2hjVmNGM1o1MWJMb25tQks3elZwVzRPRWk2Z1ArcEpxQXVCekh1?=
 =?utf-8?B?TlpjRWthMlJDTkpubC9adnhxeXZYRHQ0c2czdkhnZGhFMjFKVXlZcTMrbFIx?=
 =?utf-8?B?ZTU2UFNRV3lUUDd3OUhzaDIyRGN4dkFHZVdjcGZtK2FNT3BPeVpNb1YraWVy?=
 =?utf-8?B?RXE2Y0FxMnFTWDB4ZFVwNVArQzc3QjYySXUwVUpjZVZLUm1xaVdpLzBDRFdH?=
 =?utf-8?B?SzE2cFRsbkZKQlh5dThnQjFZbW93N21jak5rZGxNWmZMelhJYzZQTTRUV1NR?=
 =?utf-8?B?R09hQ1NPeVNZYjhGZmc3NUY4bmpFZS9qSU9vZ3d2VTNrSnBNbFZvMk4ySGph?=
 =?utf-8?B?dHNKeWQzUlZVYVlLczVRZFlkY0VVMytwSlNHd21meUhyeEIxcWZKVlMvL1Vs?=
 =?utf-8?B?YTNLUmRVQkd2ZmJ0N2FOQ0sxc2Urc1Y0TG1QWDVQQlhVTzh3YjE2Q1pkQmJB?=
 =?utf-8?B?UnpIVHZpbEFEamJHWnJtY2FZY0RTTnB5MzBDU2c3c0dtQTZHQTV3UWVMVlBM?=
 =?utf-8?B?SEU4dlU2K3FrU1MxZUVJMllYMUJ2eG9lb3N2Q1Y0VVVTaW1FNkxUQ3orTUZo?=
 =?utf-8?B?KytubkxNSk42UFpOSlJtYi92VHVzakF5LzNDcjI0ZXN5YTZldWlkYndUWk9W?=
 =?utf-8?B?emppUkpHbm9KdnZTV08wbzB4UldWaUE4eUxRcithS2R2cGYrQkszUWRCRGwx?=
 =?utf-8?B?TlZGR21OTmdwYzhOd0tJT09xVHNSR1VDK0ZqYUtwU3BqRUNBVmljTnY2Qno4?=
 =?utf-8?B?MjVqYTg0TTJiWUJYbE1mWnNGM0lpREJWZHArdWFFaUhYNDFOd3BlMUd5eHNn?=
 =?utf-8?B?Nk9aMktvek1tZ2xRRDhnNlBxWDJUelJidm5QQjRoNFlCZzk2emRNOXplZHFX?=
 =?utf-8?B?dUJaNUN5eDE0MFdJUUxnYU90UWxuMDhQbTIrNXIxZTBVekZNN3V4NGJ1eEFo?=
 =?utf-8?B?ckNkVTRFdGFSUXFjeStCdmhPdktQL3lYNkNIdmdEcmVlcHVncW1EbEtQMnRk?=
 =?utf-8?B?NUNJWE5jdzV0SFBXT1VIV0JzRmhkcTRXMkljTTc1RDd1Y0xNbmw2cnJLNW9u?=
 =?utf-8?B?bmtzYjRNT2o3MXpqTFRBeHNnNTlhWVliSVZueDBiWWZIaVhHbnc3dlI5OVpy?=
 =?utf-8?B?bUp3ZWhzY0Q3RWhtckpHc2p6djVGVFpzS0tVZ091Uk4yeXN2OUVkeHdnLy93?=
 =?utf-8?B?SnNBT2huclZROUdTRzVycmJlc1N2RmhadlNERXgyQkRISFovbEo2QnFzOWU1?=
 =?utf-8?B?Y3Vnb2gwWkg1MnhKd3JhTmljQmZwdlRDOFYvdmozaWJ6TFpDM3dhcU5ZeG82?=
 =?utf-8?B?eW9sbm5ubVRTVTIwc2hvalN1b3JNZW9sdlYyNXdlckYyT09pSFpPU3hNUFJG?=
 =?utf-8?B?TWpmeFJOelVFQnk3Z0tna1l3UlhhTFdMRVc3YTlSbHFUSTBxdlFpZFZzQ3ZG?=
 =?utf-8?B?M0J2cDc3MFVBMzFuUlhFWWVxTzJPa05FMWZKZ0dndWptSjNIMDFKU3czUERK?=
 =?utf-8?B?c2Z2QTJsa0lzNHY0a1hjNHBQb05PbWY3QytYOC8ydnQxcS9jY1dVME1BakYw?=
 =?utf-8?B?YkRDWUpLbmw1MGpVZ1hlUWhHN1k5bzZvYm83UzVuOXpDMjRCWXRvcThwSDNj?=
 =?utf-8?B?QmFBL1BjaFd0S0dZRFBuSHNmdXE0Rkk3WWZyTCtqTGI2SFlyWStGSjl4L0NM?=
 =?utf-8?B?eVlVM2dOVVc2L2pCQ0R6aTlMUWtkcGN4eWdibmxoTmZmWDEycXFIRXhKN1p4?=
 =?utf-8?B?c1lJZVo5d0FZbGhKaGdNU1dobzZyQUljS3U3TXJnVlRuYkVQZFNwZUR1YUtZ?=
 =?utf-8?Q?3DAcEE1FyyfCvlKIYzZs3dqys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787e9128-c2e4-4023-c8fb-08ddf6be4586
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:18:43.5563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuLb/ogt4jaL72G/Bhm9w1Ltnvnsys+S1LrOi6Yr0GEljA9z83tVlKuDAqVBLnNJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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


On 2025-09-17 19:12, Chen, Xiaogang wrote:
>
>
> On 9/16/2025 5:41 PM, Philip Yang wrote:
>> If mmap write lock is taken while draining retry fault, mmap write lock
>> is not released because svm_range_restore_pages calls mmap_read_unlock
>> then returns. This causes deadlock and systen hang later because mmap
>> read or write lock cannot be taken.
>>
>> Downgrade mmap write lock to read lock if draining retry fault fix this
>> bug.
>>
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 6604a37b304f..fb02ff9ae62a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3043,6 +3043,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>>   	if (svms->checkpoint_ts[gpuidx] != 0) {
>>   		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
>>   			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
>> +			if (write_locked)
>> +				mmap_write_downgrade(mm);
>
> Is there unlock order issue? Now it holds svms->lock first, then mmap 
> read lock after mmap_write_downgrade. The unlock should be 
> mmap_read_unlock(mm), then mutex_unlock(&svms->lock).  "goto 
> out_unlock_svms" does it in reverse order.
>
downgrading write lock doesn't change lock order (not in two steps like 
up_write, down_read), we downgrade mmap write lock in normal path as 
well, but missing it in this error handling path.

Regards,

Philip

> Regards
>
> Xiaogang
>
>>   			r = -EAGAIN;
>>   			goto out_unlock_svms;
>>   		} else {
