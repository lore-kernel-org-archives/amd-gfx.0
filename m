Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D3BC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 18:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DB410E4B6;
	Mon, 24 Mar 2025 18:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xFmTUA2n";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A187510E4B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 18:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enPhU+RBU/El3kWwhFTNxymGSIEmg1OPfEAPJOa8jkYcaCVGthwNJ95DPpylrD1vbmyvpUNu8wv1bP/ChyILUVjZJEf7qh0e7siKwxRaRUEB6hjlucuZy979zYLI328aLgR4X5Db/32mXHRg5/tV6XexvEwsw2WlG6xdtt/4af5V5iDvXBx73NdZK4Z0MmhhFpdVPSjzheN+Dt/4j8n2fLfJc/D6leXa95yiEmppvLHVP/dQBUPdX4W9gkO8jszJlkGuJEICjdy9wENUuh8C/mrk0lUT5fWZflLjONz0IdjO7k0biPTfbzsHbyflp9/VTPj0yqMLdogSADYqT9j/aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfysL2h8xSWp8pkSPuIiu4xsR94p6GUBnp+aA/LQSX0=;
 b=ZoDqV8mx7WPu758v+PI8rusXX/i1xw1Bjki3ZNvPEEaMKOCLbBE3T1kPaujUZl95W/75MgZWwKWdd+S1EzsXnmGJhGX5rLmifafsgit117dmqyDZ9lb7509GGzrjP7RxmLpSsXA7EIVpIHjPogXowb8adBb0SoYqakCuuntWsG2SAhj+ERj/D9YKwZgNetZT93ao+pDYHy9aEDpuDkng1Ye/W8fHTfeN5ijPlVs//ujSHUly/ohS4A+Medk5YWK2FGbSpOhMRKgjttyQJiIL+1OUdYkR64TDgjISiXnrKatuYqXCh0yNtfr57DnyL9ckbI+yavwJ4ajuiJLBfH3/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfysL2h8xSWp8pkSPuIiu4xsR94p6GUBnp+aA/LQSX0=;
 b=xFmTUA2nAXzA2HLKutizTv2RU3MVJjnvEh+CKZpZWSjBEx3Bai2a3HjGje+aHFiKRSXjiwfHIVbkAwB+AC/yXJUB4KOuOwDFCeQMMSVID/Pj+xxGAnUIug9FouPoW2qm3k+nFsMSD5ff41peKZp9AUYQ0Bs4nOc9qq2izfZtihU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 18:50:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 18:50:55 +0000
Message-ID: <f8fe8e57-6766-4a91-9cb8-d8bbcfe528eb@amd.com>
Date: Mon, 24 Mar 2025 13:50:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: add proper error message for vblank
 init
To: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>,
 alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org, siqueira@igalia.com
Cc: aurabindo.pillai@amd.com, alex.hung@amd.com
References: <20250324184508.1217038-1-saleemkhan.jamadar@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250324184508.1217038-1-saleemkhan.jamadar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: e6556b3e-0968-445d-b8e7-08dd6b04cf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFFPZUhXbEF6YXQ4U2N6L05nWEVMNC9NK2w4YnUxOWNnaGhYQ3piQnpQNGZM?=
 =?utf-8?B?UzM1aGxxRG0xSGZ3WnA3OVpwSVFpcFBRcUJHMlFHbjlCOEVwcHhPMkNvb09h?=
 =?utf-8?B?Y2Q5NjQ1Tm1vTExWUEt6ZjVtQ29CbWovdGlIcndXeU1PcUpjdm5nVjlOdEgv?=
 =?utf-8?B?QjdoNHEwbU5WNG9EVjA3ZUNJbkxya2VqL2EwY2RMWXFmSUt5d2pHcXpPcU1h?=
 =?utf-8?B?YS81aDN3QVA1eUNRUlUvUzZVVjBvRC84U29QVXJrVGpRUW1IeVRhdkg2VVkr?=
 =?utf-8?B?M1Y5UElhbGZWQVNsN1N6Skh5Qkh1YnZRbUQwdnBVQ21JbVBNNDlqT21UcDFB?=
 =?utf-8?B?eWs0UC9kbC90OCtkOThMRDVtWnZsVzY3N3EwWVdWLzRXcG1pRGlaRzVlZnky?=
 =?utf-8?B?ZlNLa3BiY2hmR1dSWG9PdUdRS1I2cnRJUUpyeGdYdnlPa3Jxa1cvOGNybWtJ?=
 =?utf-8?B?MHJQM09JMnNnMHJiWlVtM2xwNzdrSWdWaGsrNDEzRVFhT1FLbnpzMDltL0w0?=
 =?utf-8?B?bEk1NkJ1VjF4WmJ1TUZrNURjeCt3YUJwLys4OXFjb2FlZnpwQ2Rod1gxeC85?=
 =?utf-8?B?TnF5MHVWSWdPZG8vbVlpdllEWFg1K0RYekU3UTI3MTF6WGp6bmNxaUsyMlZW?=
 =?utf-8?B?N0FPY01aQVFOS0pMY3JtYUZ3NUFJT2I3aVNoTGdPN3VxWEk0SStqSGErWFBp?=
 =?utf-8?B?NmpmVnZzYitJUEc5VFFoNktRTXJmQTJia2dPZVByVlBDb1dNY0RHR0pGY0pD?=
 =?utf-8?B?S2hvTERmSmxILzRlRGZFQmc0ZzRTRGhDejladEJtMlhYSHh4Y2lkVllmeklL?=
 =?utf-8?B?aHFoaWt0djBEaHBiK2YyYkRLWEZBNWsyYXQrdmRHYTFMTHVacnh4QnFnS1RX?=
 =?utf-8?B?TkFGdUxTQXg5bXQvYXVoSjRWYTh1NnUrejRWZWpQazU0OWo4ZEV5Zlh2NStG?=
 =?utf-8?B?NnpVZEpZdVJjN243dGFwMXNSVEhLc0pkL1pxcW4zV0lnUVorSzBoN3E3NUg3?=
 =?utf-8?B?ZTc3VkR3azd1Y3gxbGt3U3Z3REtoS2s4dXpDS3FOMUVzcHhUSXEycVkraUpN?=
 =?utf-8?B?cXkydFZoZHRLSDlsSmdxWTl4SlJTTXgxb0FtMnZNejIyamR1Ti8wK2lldW1t?=
 =?utf-8?B?YS9UcWQwNVFvZldjWVBmZEU5NkVUeDV1VXlCbUF1QS9iSFdUZ1BWYzZRb01t?=
 =?utf-8?B?Uy9mTERwRm83dklja3VqWm9FajZyRGlCWjE1NWFscjJPZFU0d2FDUHZ4NEls?=
 =?utf-8?B?cUxiS2g0RktKaTVCaWJrVjRFWGhyZ1J5dzRWK0xRa3Vhc3VLQUlYVXVJdmdD?=
 =?utf-8?B?cXJBTWhRb2ZqMWxKQ1FETWFTTDJEY2F3aVNEMll1b1lBTkhRMlVJMVVxYTRG?=
 =?utf-8?B?UjNVYVZUZ1pDWi9xQ2JDRzdTSTQrakZKMkQxSG5iV0NPYnB4aWkwNXh1WWRi?=
 =?utf-8?B?RW0zcS85TDVuM04vQW1WNzNQcVZYUkd5Vis0TUt2MXBUU011d0JTVWpqMVZr?=
 =?utf-8?B?ZHg0Smk2TlI3WnFHVll6ZjhjS0VBYXJNbXlmeHp0UWhKNmxlcEU3Q0NGaENi?=
 =?utf-8?B?ZGhYQnRCRFhXSG5vYUpydVpQNytDOTN5Rmc4Sy9EaHQxbXorTy9nTTlraXF0?=
 =?utf-8?B?OHdIczFseXExb2VNdGJtMldrUWNEeDhjOEg1d1V3UXI1NFpIdjhCMXpmZlZJ?=
 =?utf-8?B?ZVNZMXpBV1M3cnkvdVJJaHJpTEM5a2JDSUwvQUI5SFZSUU5VT0MxVnlMUzk0?=
 =?utf-8?B?OXZaN2lSb3V4SnRNM0xPKzd6SkJSSTBxZXQ2YzdPNGpzQy9MUFd0V2Jzejhy?=
 =?utf-8?B?bTU4MVVrbk9mTXF6ZkRuSTlqRWs0QUJVV1lIdHJ2bVQ3dlAwbDdVN2w2L2pz?=
 =?utf-8?Q?hWCQ9PkgO6hlW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnRVVzI1RGZkdVVDc1pBbytRaHh0N083dGNFaEJUZ0NRVmhBSldFZjJEOXdH?=
 =?utf-8?B?VXJOSjFaekV5Vitva0VKSGt0RnBGcU9kaER6YThmb3c2YnBxYllvd3ZMV01i?=
 =?utf-8?B?WnFUaHlzTUFwaWNQRHR0YnhERi9icHlDT0VxQ092b25OekM5RmlRQUtaWWlo?=
 =?utf-8?B?TzBtVmo3elhNeVFNTVdKdVNsY2Y1eGlueXRpbHdMUE9IQ3NEVkdqZG93aHlt?=
 =?utf-8?B?TmJ4bUpvWTlyYXdTNXdsSWlwOUlxUUtNV0k3TE1kVUx6RVA4Y254QzdsRGd3?=
 =?utf-8?B?cWhrVE9ZcHk3ZUxmeFpScmRwUXB5bS9uSTduWEsyNGJ6ZHV6ODVSQndMSWY4?=
 =?utf-8?B?RXRPZ2dkejY0dTU4QkFzSDZKOWc5UCtIYjU5Uk13Zml5V1VpZW9BWGlpR1l4?=
 =?utf-8?B?VXZkYWpJQ05iTGl3eEtBRTBDa0NJS1VLWmZkb0wvRG0za2lOaHUrOGVYZ1Ni?=
 =?utf-8?B?UUFkY1pXUGhXYWhBNnBrUTY5RStkZFpZR0pzLzNKWE5uUER6T2c0M2U2YTZx?=
 =?utf-8?B?N0laU0FsQkNFdm5neTRPdjMxTVlOdTRJNm9lblRGek93RlJGVGNoK0JWZjds?=
 =?utf-8?B?d3A2SVFOZ2llMGs2S1FXUnZYV2RQeEc1aTBHR2lFZWVmK2ZFdm9LZWRvZE9R?=
 =?utf-8?B?eDVLNUVHdE9KZlI5eE9GcTQxcDVNRXZNOWJaODNJd2RUeVVwOTg3T2VlNlVR?=
 =?utf-8?B?Mlo1dTZ4ZWtIU1ZVMzZmazVmbjhsQkg1S3kzczZmODhsY0U5U1kwUjJhdjNo?=
 =?utf-8?B?N1FwVzJHOG9XVzZoOXo5VVY1RHh1S1diQzFZcklFMXlRQ2YzY2hxcmRQazVv?=
 =?utf-8?B?YzMrS2xpS3NoMkRKVW1FSTVxY2QvVVF5ZUFXK2pqOUYvbDl6RzVGMCswYkxH?=
 =?utf-8?B?eU9qaWtTNllpOTVTMTRKU0MxRHZPcnNHbS94eHlnWTBPNE5NejNvTk94cWdE?=
 =?utf-8?B?cXpPa0pDSWorNnFqV0VyTWVJaDN1b085dTQ2R291TlE3MU5EQ0JNdElmNy92?=
 =?utf-8?B?bXVHNXJDZk92NXJXZFNaOTRxSXFSNUowM1h3eVRHYmFJT3A0ZmZYMDV5dnov?=
 =?utf-8?B?SjF4YVRoRW9LR3BPRXJnUy9uZ24wS0dVa2lKR0p5ck1Xd2tYcXZFeTM4NUdQ?=
 =?utf-8?B?ZWZZb1I0QlpoQUdCQVlPNUFGWDduYWJ0UklDc2I1MFozb1o0d0VZU2pBenU1?=
 =?utf-8?B?RUVaWk5kQ2xXcENMZlBKZDhKL0RvaTNOTzczSzBKMVdXU2pQTmFUbGsrZnFJ?=
 =?utf-8?B?V2lGSnhORnVydlFoU0JhR05zazNxSENlZm5MVXpzdFY5VmNvdzhNcE5TdUtz?=
 =?utf-8?B?cXFRWUh4UDZWNGpzVjRvK0Q3cGhIN3V3Qk0vdjJnVG1DZ3FiNTVqOTZJMldH?=
 =?utf-8?B?MEphMHJYMDI5MkpPT0FmaGg3NVBEbUpRSTl3RmtoWjVKNWoxN1lxVlI2d1Rn?=
 =?utf-8?B?MGQ2QnptUDRXUVFtSWJBWHE1SWMxbWdwM0Uva08welRQK3E3K3hSSmpGRUg1?=
 =?utf-8?B?ajZmVkE5TzI3Mk45cndSRWNvWVM1cGVuYU53aEltMDVYQVRIS2RsZ1lCL3Rp?=
 =?utf-8?B?OGhpbE1Fb2hiQ1hXOGNnNHJvMWc4a1dXRmpTNVRCQitIRmZvdUVZbTdBL0pN?=
 =?utf-8?B?azIwNmpza05RQi9zYStJb0tBREFhUGlCNWVhOGNZZkJUZ0Z6Wkc1blgyeHph?=
 =?utf-8?B?V0RSQXdNMFA2TFY3NHg0dElkbGFGN1pJL2IxM0ZCRTJaUzhneUZUN0orRDdw?=
 =?utf-8?B?Zk5Ta1lUTGF2eGhWUUx4MTNVQkNpMyswZDJhbk9hOHlmdzIzUkZHeEhVSGpJ?=
 =?utf-8?B?RkEva3EzUllKWmJKblljT1BvSDVHdFNiMTFMblIyeThtbURrM25xVkczdlJw?=
 =?utf-8?B?eDBEd2ZNM3RUYUhjczVJY3lqYXVJdWs0RTVUNnl1VXZ3K25jSzErQTBYbjN1?=
 =?utf-8?B?cGU2Z0hUUDIvdDFYS0dubElQMTE5by9DbjhKLytwb3ZKRnRFdHNidFlXR0xt?=
 =?utf-8?B?QjdxWEpUU1lLaTNwWWdqVWNGbGNGQUFrdmdMMjRLTHFmY1A0SG1UYU5laTV6?=
 =?utf-8?B?Rk1wZDZIa3Fob0hGbTVldjhyeUJOSXhjcjhYTmRyZi9yWUZGZ1ZReVg2N0xw?=
 =?utf-8?Q?/DKVvcvePyrAaDlfXdR3V3GoX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6556b3e-0968-445d-b8e7-08dd6b04cf45
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 18:50:55.9437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgFNNeZE9bCvjkLxbG8MSP2h4nuMlTJRAjbez55yTsipx3cqX/N2GErCPd2DoGOoKNjvWIlqHIRGg8cAQsjjIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887
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

On 3/24/2025 13:45, Saleemkhan Jamadar wrote:
> Hi Mario,
> 
> Made the suggested change.
> 
> Regards,
> Saleem

I'm not sure what happened to the below text (maybe email client failure?).

But in any case the change looks good to me now.  You can add:
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

When committing it.

Thanks,

> 
> --------------2.34.1
> Content-Type: text/plain; charset=UTF-8; format=fixed
> Content-Transfer-Encoding: 8bit
> 
> 
> v1 - DRM_ERROR to drm_err (Mario)
> 
> Update message to identifiy the vblank initialization fail case
> 
> Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> --------------2.34.1
> Content-Type: text/x-patch; name="v2-0001-drm-amd-display-add-proper-error-message-for-vbla.patch"
> Content-Transfer-Encoding: 8bit
> Content-Disposition: inline; filename="v2-0001-drm-amd-display-add-proper-error-message-for-vbla.patch"
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8dd9bf58eac5..1d3585149b0e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2217,8 +2217,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	adev_to_drm(adev)->mode_config.cursor_height = adev->dm.dc->caps.max_cursor_size;
>   
>   	if (drm_vblank_init(adev_to_drm(adev), adev->dm.display_indexes_num)) {
> -		DRM_ERROR(
> -		"amdgpu: failed to initialize sw for display support.\n");
> +		drm_err(adev_to_drm(adev),
> +		"amdgpu: failed to initialize vblank sw for display support.\n");
>   		goto error;
>   	}
>   
> 
> --------------2.34.1--
> 
> 

