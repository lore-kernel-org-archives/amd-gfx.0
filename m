Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD626C5AD49
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 21:06:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111E710E073;
	Wed, 28 May 2025 21:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VF02yYlL";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F7410E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 21:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQ4PKsAAHMbZb+/81w8UhOsUJeSXJaODYX1glGimUbDHUz0Pvg6QIdSGsI1w97tI5K53MfMbxi2PJ6yv4S3m2Thy4qb4hNpK1K+YhQS4T1lWuPsLH8OZxSmP/SxKcMZnbw4UJUA0sRCx4KDVwU+7n2lfI43HS4fULmtPl4W4XsUDjO1YGXsbXCyZqAV1RlDsFM15JTqjcfPDdG7Yc1rfOwtwP+Lvta63IWTQxoktGJpd6V/Uf7rs6i8+uyeL770WogFE0Q64DgKX/JShCxdx91bavNv2p95S7gOtT1ZEGKHQMrxpMlqdokUWd53OQYBtxsfaQaLQjQmjlBKBzw+XhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YU5M1PsagC8D0FpDlWXAlp85TOfhJ16FfAKqwwNcFxA=;
 b=MJXk5qXy2N8Cvh3u7BXoXUI5JvfLmBPGkbtjd31y2qDwmHRrxA8cCZL42d7Ivdv2/cgaRPMdv4/2tzAM6wtfbtVx2vZMroCFEn6Lto4p+0CD5kFDvnriRE7d/eAZeg4eWTKmEtfWkQBsexVUibi79759VmoGP4de5M2qh1PUkSt6JEjt12IF1PiGNy7Am/pW8B/rb9b2FSAfCiCyxe4/U4/mpASaAajQeekLCHRipvALFf9afa8sB5lRthjU2SqT0OS8uyeF7Z748TAxA4FnKULb5iBaFGzEgs92t4gwmqoZK+pZWsVcSlOY9ZsXhWZd4LyR+Gp6CVo2pLZOMjEY7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YU5M1PsagC8D0FpDlWXAlp85TOfhJ16FfAKqwwNcFxA=;
 b=VF02yYlLmaJwMORbQoAMTC32r65BDhy2xgSUPrV/5h2PHJGK85FE/XYP0fqZ+4PcBVN+95ZRQje2HrBCAbo34lUXhfDICRDIsN77RfRA9IwlkjOJl5SOXiadwKyB4CaCKBNVLD8y8/5Dj/az7a6LCRXbpS0jWAr8oCOqsRhtUbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4218.namprd12.prod.outlook.com (2603:10b6:5:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 21:06:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 21:06:40 +0000
Message-ID: <49993128-e74d-2c05-fca9-80b511b27537@amd.com>
Date: Wed, 28 May 2025 17:06:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] drm/amdkfd: add svm_migrate_successful_pages
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com
Cc: Felix.kuehling@amd.com, christian.koenig@amd.com, jamesz@amd.com
References: <20250528171908.82639-1-James.Zhu@amd.com>
 <20250528171908.82639-2-James.Zhu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250528171908.82639-2-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::30) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM6PR12MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3ccd53-9392-4c55-d376-08dd9e2b8aa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVN3REZDZ2FxM0pJOFBSZWx3bjFQdEJ6VDBJenVLcjE1dHg1NDFqVUZOSTJN?=
 =?utf-8?B?NE1FQmFpSnRXSUlTMzF6cVZRVG0zM1pic05ZQno2MG16SFJJSzUzc3E5UDMw?=
 =?utf-8?B?a0VzaUE3S1pINzg5WC9lN010SnB5eStBQkwvU29vR0hJOGN6alE4RXh5Vk9m?=
 =?utf-8?B?SHRvNk9zV0tBOU1seURmMkpaQkRzdXlNWjlUcEZDb0pOd1gwSW00cnNHYkN0?=
 =?utf-8?B?bStmVGtQcjh1aXJUV0lhTkRtYTJaWDRQSUtqRTZHZTM0ZHpEdzhWcGpIa2NI?=
 =?utf-8?B?RHlReEltNzlLZHdlL3FrV2xoYnRoUFhQRTY3UUpqcXFvQ2puL3NTWC9jbGhl?=
 =?utf-8?B?c3loM0N3bUliZkIzWm9WSk1Wa01raDJQQzlFWDM4S3puVDUzcFNBdVZqckY2?=
 =?utf-8?B?aG04RFJvVmZpVE4reGY0VGg5VUJRQ081UEF0NFBSZ25Ic0NXYTFWb2tqRjBY?=
 =?utf-8?B?Z0VnUk5hYWhOUGRUaklHMWFaV0F3M0pIamtrdks3Vy9sMzdudG5MVVFUeWl3?=
 =?utf-8?B?WlBoNjIrcHRtaHRFTUZjcmZtVUx0TzdpRkVNckdFSXllOTFXTStOLzN2Z3ll?=
 =?utf-8?B?bklDVENWc3FxeTFBekJITlNjQzhBaEZxZnRvZEZBWjI5Nk5JWVMya3JnM0hv?=
 =?utf-8?B?cllKL3FTTXdUT1dPdXVGMHBLK20wTVdjbkszRkxncWdDUm56NnV1UjFGT00v?=
 =?utf-8?B?SEZPR1FrVkNKbDd4WEVJRmIwQVFKZDdOdzI4cHBCaXAyVTErVW5HS3Y0WGox?=
 =?utf-8?B?NlJ3eDNyT2tsaTl0UVlFanNKa1BwWGVvbU5LeVNnTkRoRzdteUhEL2wwM0VY?=
 =?utf-8?B?WXY2QkRZMytxSWRJN3MzRGFBKzBSbThoRlBNL2ZDSVBJOFk2aHlUZ2dwaWR6?=
 =?utf-8?B?OWpoUkkwK3pFdnhrelJEempyUkVvZUE3dVBtZ1lpNXlxenhDVytZRUNQWDI0?=
 =?utf-8?B?Qmg4WE9meXdab000QVZRL1RER1JsNmN2YlByU245Q0M5amFDMkNwZFFBdGRF?=
 =?utf-8?B?ZlRnSUt2QWRXU0E0UzR4YTNUbnpmSkRqMHN4TDhzTlVVblFKSlczaGxkcGVz?=
 =?utf-8?B?eGNEcEQyNzdFNVdBV0ZqYUt6dEFOZXFCc0MzWXVJaFNqcGtVMlZFbmpJUmw1?=
 =?utf-8?B?bThRdytLQTlycEdpNlZGQkU1K3A4cG5UWHFmZnAzdlJmYTlDbkpLcGhiTlc2?=
 =?utf-8?B?cXdFNnpkQXhaSEdCWXVqdUkrMXE0dktJa25uTDNPNGprbkU4VkU0bDY5QlhE?=
 =?utf-8?B?aCtLOVJ1Q3dYLzhuWmZUb3pQOWpHeXh0UzNlYmU1VG05NGMvM2MxbHJkOFdm?=
 =?utf-8?B?RHFIMHhPc0c4L01oaCt4YTFzb0IwT2orTTZnY1NDOWZUMkZkRG1qOHVzNzlX?=
 =?utf-8?B?UHUxUWRDaGlDZ0NJd1U3S3ROT3IvZGc1OGlOdUdaZDY3eHdmUnhudm9lbUdV?=
 =?utf-8?B?bTFQVnJBMHJ2RGErQkYzMHdoNXgyeGV4eGJ0UmV1RVZWb3RyVU94cGlDOENo?=
 =?utf-8?B?YXNPTVdmWTZOOS9nckpPSDV6bUdsbHNvWWRYelNNcEJNVnUzcUZERlVMSkRN?=
 =?utf-8?B?cENnNFVMak4rSGJqZ2NMV2l4MmN6bHU0Y1lzNHJTSUNhY1NBUC9OZzZqdHlx?=
 =?utf-8?B?Z2YrWXZIWHRJNHVCY1F0T0I3TTRTRWhJSXhoU1BGdlQ3U0pSbGRiMkZJR1BQ?=
 =?utf-8?B?cnB2R3Rzbnp4Vm1hZDhmd0JDTFo4eE0xNHhBR0Z5dmVPMUVHa2tyV1lRbGU5?=
 =?utf-8?B?NHd4aWFYTkNlZkFVUmMzSVZ1ZEpiOEhqSHB6eGF2NUlkVUR4UWUvNWIzVE1Q?=
 =?utf-8?B?aG0vZzFXVDdteDZlYmRYNlNTT3dFdUpjSnF1UFpmN1Y1RWlXdmY2cEVSVjFu?=
 =?utf-8?B?b2FGTDU1T1RPVjQveW1FZnpBdHI0WVV2STdLbTN3SHlJcUNuMDhPN0k0VmVw?=
 =?utf-8?Q?yna88BH8/6o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djhOY21IZWZkcG03c280TWpEZ3VjS0lLdG5VZk81dklZV0FjUXJKbGlYL3pX?=
 =?utf-8?B?Z1lZMDk0VEJMRE55T2kxY0puVUZpRXhkc1F6dEVseUJZWHdIeGUxNW1wUGxw?=
 =?utf-8?B?cWZEZW03cytZSDdlNGZZTjQ0K1BKQi9NVUh5YUJUZ3U4TWJDeXBwVi9VcFBv?=
 =?utf-8?B?aHZWbXQ5SWJQU3Y5OG5ML3dKUDlBdGFNbU9sSE1kWmZQT3EwZlhISnJyeGpr?=
 =?utf-8?B?bkQwd09Jc010VXZpS2RGekFVRjBoeFF1WENaZy9UeVlLa2VHS3pvQ1hTZVhn?=
 =?utf-8?B?OEE1cWdBY2pZVkxFbmhrR1lWalJGSkwza1FnZEE1T1Z2cmc3NnhhamdJZE1z?=
 =?utf-8?B?MkVRQzNGM2tPbkQ1YUF2SW9MWFpJa3p3M1VKM0lzcm5nblNYTllSM3crMUU0?=
 =?utf-8?B?VHlPdEFUVzdZRHM0YlNzcGZnS3BTWUp6aisvd3d0ZHhIUGZvRi9JaGhSWEIv?=
 =?utf-8?B?YVJBSC9oU200YWNzOG9hcWJSOHdPL2VLbkFiT2ZSci9idXJQR3dLUlNFMXFQ?=
 =?utf-8?B?R21wV0kyMDZJYlVMUXNQcnlKaDNzK1NYR0w1bWQvM1lXcXg5ZzZ5Z2JnYWEy?=
 =?utf-8?B?N1NvRlBuM2dwNnJpS0pOcjZqcXh2aFhtWHU5eFBGOHcxVDUvZkVUU3dRVVhS?=
 =?utf-8?B?dkpsbkpLTURteW82b1lxWXNOSEJ2YVh4WkVJYVA2a3dOK3c4SUJPUXJpakgw?=
 =?utf-8?B?UER2b0hZYjJJTmVNeGJkVW5VWThpbmYrRldVSDczc3phZHJ0dk96eWo5aThp?=
 =?utf-8?B?SXoycGZqK1hpK1ozMFhIb2M5bHBCSHpIakFiZTh3NXVvdVJnTGF2K0MrS3dr?=
 =?utf-8?B?KythRjQyaHFDTWZZUUY1S0cxNWRsNWlnWDYrUVhNenhwd3pmZy9seXZkU0ZX?=
 =?utf-8?B?MEd0aXl3bkN3b1hBdGtVdTJzNDRKU0x5MEJpSjFiaFJsZm8xTE9MTFduUHBT?=
 =?utf-8?B?RkFWbDR0d0dOMWFvd3UvV2xmaDBNYTVHODB2eE9GbGMxYUhHUFhhb08yZkw2?=
 =?utf-8?B?dDl6QnNtcDBZNjZEUHQ2N3lLc2J5WHBDN0t2VTRhV3UwQ21uY1ZuZXZwWTZi?=
 =?utf-8?B?NTFyZ2RNcWxsZDAvdFlMYkNYNnY5eUlLM3JjRmdoYU9paEVmV2h5WnBlOEF4?=
 =?utf-8?B?QVF4YU13aDBBd2lsTG5DTzRKeUFoblBHZWgxRWlqUjczSjdodHZmR2V1WVVq?=
 =?utf-8?B?TXI5ZC9peTB5Z2xvMlJPNHpxTm04aUZHTm9BNk93SFMrT0NDN2xHOUpsdlpT?=
 =?utf-8?B?RXB1ajVham9GTzNXV3liS1UzQjhUa1hKSGYvL3NIbVl5bTRGeDRZcmxsR3U2?=
 =?utf-8?B?UjFQelI5dDJXZXFFQ3ZTMnIzWFo1K1BqK2NzSTQ2Y01TMmM1NTQvVVlHKzI5?=
 =?utf-8?B?R3lQd1FRakdTWGtuM3RVWWxzQm1aUVN3RlBwZlZhRE1iOXpQMVNraHk0MTN1?=
 =?utf-8?B?UW5qaFp2MktPUlpqYXQxdDdCR2VJRkdiR28raUNZUkc4dXE2R2JscUFtd1g2?=
 =?utf-8?B?bUdZS3Jwb2pNWk5Ra21ITFFIeTlBeWtmUzZ4WU5Oc05hQ3ZlOGhsK2gzc2s1?=
 =?utf-8?B?aFpUNFRFWDkrVEpYeEdqQXozTkxFdjdsbXFKSEtWWFNuY3djSUZ0MTc3cXIz?=
 =?utf-8?B?MmVqQjJhT3BFUEU0UGN3YURQZGRCMk1JNW14ZGkyNkZvZWtJMkJiOU80TlV5?=
 =?utf-8?B?UVZ6LzhxeUI2eC9KeXM5ZlBTQSt5ZkMwSHZjK3M1TzJmSVZrdnZZd0V4UUNQ?=
 =?utf-8?B?Ni9PZVBlMllVR1F2Z0pIOFhhNEdCM01naGt3bm0wL2N4U0lGMGUrWHpXem03?=
 =?utf-8?B?Miszdk1xTkZTSTBqZHU5RzNjOHd6WVI5UnQxb2dPZzV5eU9aT0V0N2dscUdF?=
 =?utf-8?B?dURRZmVXbDdxRWg3VmVUTnF3ek5hVDFwMHhDc2YwRk5wREZ3bFJmcW9nNHRO?=
 =?utf-8?B?NTNwUHdCb3V6NDJCTXJuVkgxYzZRejBrbGozZDZId2lDYjNUNGpHMnFRa2ZM?=
 =?utf-8?B?RGQxU1lOV1A1TjQwUi9waUo1clNpZmpETjZVSG8vYmZSZFRVSmlKM1I2RGlL?=
 =?utf-8?B?WWZPT1QyYi9tZmcvQ0FZSkdmTDhwTURSU0ZEYi9KWmtMNGVXZHhqUU5HNXk3?=
 =?utf-8?Q?y8a7oEhyGTfhyabQW5F1vySH+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3ccd53-9392-4c55-d376-08dd9e2b8aa9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 21:06:40.4968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8lOpW3vPuyGywPKyC07bMpQirua2L7jvVgla+Y285U3t2s///eUBhLZgyH1DlJGH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4218
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


On 2025-05-28 13:19, James Zhu wrote:
> to get migration pages. When migrating pages from system to vram,
> needn't check bit MIGRATE_PFN_VALID, since the system page could
> be allocated, but not be accessed.

I think the corner case is vram_pages becomes negative value when 
migrating prange from vram to system memory, if the src page is on 
system, src MIGRATE_PFN_MIGRATE set, MIGRATE_PFN_VALID not set, this 
count as successful migrate page by svm_migrate_unsuccessful_page.

As discussed offline, we could check dst MIGRATE_PFN_MIGRATE flag for 
both system to vram or vram to system cases.

Regards,

Philip

>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 25 ++++++++++++------------
>   1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f0b690d4bb46..131838bf8751 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -260,17 +260,20 @@ static void svm_migrate_put_sys_page(unsigned long addr)
>   	put_page(page);
>   }
>   
> -static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
> +static unsigned long svm_migrate_successful_pages(struct migrate_vma *migrate)
>   {
> -	unsigned long upages = 0;
> +	unsigned long mpages = 0;
>   	unsigned long i;
>   
>   	for (i = 0; i < migrate->npages; i++) {
> -		if (migrate->src[i] & MIGRATE_PFN_VALID &&
> -		    !(migrate->src[i] & MIGRATE_PFN_MIGRATE))
> -			upages++;
> +                if (migrate->flags == MIGRATE_VMA_SELECT_SYSTEM &&
> +			migrate->src[i] & MIGRATE_PFN_MIGRATE)
> +                        mpages++;
> +                 else if (migrate->src[i] & MIGRATE_PFN_VALID &&
> +				migrate->src[i] & MIGRATE_PFN_MIGRATE)
> +                        mpages++;
>   	}
> -	return upages;
> +	return mpages;
>   }
>   
>   static int
> @@ -447,7 +450,7 @@ svm_migrate_vma_to_vram(struct kfd_node *node, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> -	mpages = cpages - svm_migrate_unsuccessful_pages(&migrate);
> +	mpages = svm_migrate_successful_pages(&migrate);
>   	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
>   			 mpages, cpages, migrate.npages);
>   
> @@ -688,7 +691,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	unsigned long upages = npages;
>   	unsigned long cpages = 0;
>   	unsigned long mpages = 0;
>   	struct amdgpu_device *adev = node->adev;
> @@ -748,9 +750,9 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    scratch, npages);
>   	migrate_vma_pages(&migrate);
>   
> -	upages = svm_migrate_unsuccessful_pages(&migrate);
> -	pr_debug("unsuccessful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> -		 upages, cpages, migrate.npages);
> +	mpages = svm_migrate_successful_pages(&migrate);
> +	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> +		 mpages, cpages, migrate.npages);
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> @@ -764,7 +766,6 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struct svm_range *prange,
>   				    node->id, 0, trigger, r);
>   out:
>   	if (!r && cpages) {
> -		mpages = cpages - upages;
>   		pdd = svm_range_get_pdd_by_node(prange, node);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + mpages);
