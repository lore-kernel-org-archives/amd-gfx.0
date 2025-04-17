Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C59C369C2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 11:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C60010EAC4;
	Thu, 17 Apr 2025 11:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xNLJ1FUk";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3947410EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 11:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntT4ocBuzYF+sVHgePuiWhQA8WKu77D83+CSdKEY42IXFGVSM3C7H4t8e5EUPXNOscV9HkKn+Wyvj702vrpUerbg4n4IaZpjRKuAUUt4XwDN5V9k9pwaS3Qhspkit3AD1+R11hsuJrep1YS8DxQ2p53dpyYkYPNsDLd/7qn5Z9QCRU6HaYj25AYru8YhinTD1CdoV7ANMMYGkhUT8qL4vPbSMjHI9o5r3NaOsZnqCjcOs0V4XHOl5/RFbfnF/NINJbKhm5Q+9zlcW+KHHnE1GjioDbqftkq/797r1duOS+I0tVLogiY1Z6ShIvsTw1sJ3uWW2Gn6qH7R8kOnbjn6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXpCR0gQ2uvqY1jsfs0K1gv7o7hK/U657pIfrEXUPg0=;
 b=WnSSDkWSok4n6tIDGVRyJEvrfSITlTGwPo9QAvHhnJYXutTj9+7NluInnjPogVtoeF8N2FNCGtNZAmV3DzVAHZI99Dusu6i3N4LLpCt89Cl+1BJ002usfZgaTpvu4DdS5knwnLcBrK+p30xn7JY+9JDhJNxsrp4LFR63gRvAnDs5vgBDunBcQY1ed4VY5tNLUBPlDxW9LD5KUGJLLOmqS/dmMuCEZjRNj3Jq389plpx/prjOHXjZHfv3nywG5xn4BGH8BG5ARXFr7QYRP5iNIa2NiiRQ4h7qhQg8/HNftxKrEkNSJWHhhJys8eC40K6/QeIB6/mZ85dmyyv4daG3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXpCR0gQ2uvqY1jsfs0K1gv7o7hK/U657pIfrEXUPg0=;
 b=xNLJ1FUkqPVlj9soq/gy438+aHoknGAw+2siQwwOSCJhjLFTWSWLNas/hAX2pCIXK5MZcwjJqv7roy7yx5GYZ4P7OO9W63H0utZ3Jq08x7zyZITMq5wzvJMlYxLQe3YdZxIXq8sEWWFInDIZ5hqCnQ1hGmHDwZKv9Afh67Vwo6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Thu, 17 Apr
 2025 11:22:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 11:22:57 +0000
Message-ID: <1f65980d-70df-4ef8-b6a7-00ffc28bd0b3@amd.com>
Date: Thu, 17 Apr 2025 13:22:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] drm/amdgpu/userq: add context and seqno of the fence
To: Sunil Khatri <sunil.khatri@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20250417111534.2842464-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250417111534.2842464-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: df17b557-8645-4eba-2207-08dd7da23439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXRGUThJNkNSYTJSKzZiYnB3dW5uc3U0ZUpnSi8zNFdhZ1Jpd1h4dXM1MzQ5?=
 =?utf-8?B?YVQrVFpLMlgyL0lDNDJxU3VEZnlPM1FMb2t0NUJrT3ZOcnNPdHdwblVFMTJo?=
 =?utf-8?B?T3lOV0MxeGk2Q0tRUWQzOGRBMlA3S3RkVUJiT0p6czFCTFd1cWNidTI3KzdZ?=
 =?utf-8?B?cnMzWTBDVmlMcWtYTHkybUt0NkUraG1PUEVtazBRTVgzMStES0loOWt0aWto?=
 =?utf-8?B?NC94OXZ5T2xCekJKTWFkSDY0TnlSNUQwOVZYSy95WWZ6Z01BMUVEZDFNNUt0?=
 =?utf-8?B?dithMXhLNU5FWHl0V2hQSDJSbmtwSFFNZ1VlaUZ1clRvVFI2RDkvRVJGWnZp?=
 =?utf-8?B?SmlQNFgxTGw1bzhCTDJDeW5qSGFNdko5UVZhWFZxa0lmSG9XZHFlenpEcWtH?=
 =?utf-8?B?MFdtbnpXRTBxSml5VHdvOEhwdkNoVlN5dHlYWVVWaGo1bkRjMGtybnBwZGR4?=
 =?utf-8?B?dmZaSGdpZWNpVFA4bitlaTRHTWltVVdiZ2hkVUlXRFE3dVJheC9yT3ZGZlNw?=
 =?utf-8?B?NkFQcit6OGFJalZ5ZmJNTDZtWW01bG91N0hUK3NhWkNvWVk3Mmc0SVpQditl?=
 =?utf-8?B?YldROHZBaUZqUzN4c0M5blNXWWtiNVM5L0JFZXVzRTVHM0R0MlErR2NESUFW?=
 =?utf-8?B?SVJYZGlsbU9RMndKNktpVnpab1BYekhoTFVWVE1hYXJqWTZYVWw1VmxRQ29y?=
 =?utf-8?B?M0ErTFlHRVM1akNENUQwbE9SNThyU3BySmxZbG1MelB4cFVFUnIyQkl6YlY4?=
 =?utf-8?B?UEQwaldSRmE1cnp6aEdhN0MvYWJLbXlVM1Y4UnFGa2FlenVWTVlYUkR5a3Ri?=
 =?utf-8?B?cEFBeHlqMXh6Q1V1Vzl0TGVHY3IyQUk0bWhEMkIzYnVlTjlDaU9FZ3cxb3Ny?=
 =?utf-8?B?UnJ0YVd1WmZXL2JCN3pvTzJNb3VXTWhJTmFLdHhJUFFvVGZ2eHJjNm8ybUEz?=
 =?utf-8?B?c1pockZrMmcxNS9QdWVsS3ltbG91ZVJIZjZQVTlCMnZla1JTbTViWFFxZXFm?=
 =?utf-8?B?eTdYNG5haHJZMFY2dU9VMDNQazNhVldRQk9TVmJLQWtpaUdSQVlVa1dkLzdj?=
 =?utf-8?B?ZWpWdVB1Q3lIY2R5U0hYU0xhTkkwaXJ5aDFpd2hpbmw3K3dXeVFEZjVoSXI1?=
 =?utf-8?B?S0Jwa3JEem1jc2U0Q01DRGNVVDhrcFNKcFRnMmVzWjVZaFhmclFaNU96cjdP?=
 =?utf-8?B?b2E4bDIvM0ZhbmI2eEdXZGg5V0VIdE1VNjdIVnJoQ29ncGpYRERiMld4RDRv?=
 =?utf-8?B?cVg4MStuKzY5MlI5enVhTWM1VkJxUUtwcFUxUk1nY0VoNHRIc29BdjdFeDMz?=
 =?utf-8?B?MUd3RjNjdlpBZk93YmthK09Pa3ZNeTJIc0dHTUdoZlRJNytwRmtkZ2p3SVJy?=
 =?utf-8?B?VnRQc3FQcVNNVHlWZUlvTmd6MEYwakVmMytPcFVFbDlDTFkxZk42akFLUjdZ?=
 =?utf-8?B?TWdPUTBxQU9hcGlMaHJOU1ZIU3BRTmNBZmlCVW1udS8yaGlMelZGVmlTMnl4?=
 =?utf-8?B?empQZXB3ek83VGhyblJkMW9JWVNsQjBHamk2bDloN205NUd3V20rbDl0QnEy?=
 =?utf-8?B?SmxpbXJEZDQzRERxa0Qwb2ljZWdlejJMWnVuZVpXb3pkKzNMM01WUFJPeXBR?=
 =?utf-8?B?YUhPdlA1VXYwbndNcC8xek4wdnJyT2FMVEFLQzFEd3kvZDJIaTdXb2N6UVVn?=
 =?utf-8?B?eFUyczdXQkg4dVBVL0dndE4rdkNTc28zN1ZuZlhuVjJuS2hKUi9Hakx1QldN?=
 =?utf-8?B?d3Q1Um5Fck51cWNDdElXVXF6bGlhV1lWb0J3a3ZIV0lUNUtXc3htOEowOEJs?=
 =?utf-8?B?Q01SeUdXeDJ2Y2Q4WCsrK2VCTUdEaVRNeVB5SmhRbVNmM1hxUVJGdWt4ZnEy?=
 =?utf-8?B?WG91N1dzSDk5N09rVEFmUk9sTUN1aHZ5d0MzenF2K0hFRmEwcloxNUxkL1pt?=
 =?utf-8?Q?aOhwSimZKcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU5oUmdJOWVKcERTNFgvVG11bWxsUFhiUExWUHJDc2hWcWF2NTRnUzhjT1c4?=
 =?utf-8?B?R2ZSY0YrNkVlNGlVbmtWTlN6c2M4QkN0UDU3REdzZlZ5RzNqVjRYVzV5ZlBt?=
 =?utf-8?B?ekNLOWlWeFhJU0hVWkdrSTRuKzJDS2l1c2VtSHFkVXZ5VnAvcUVZSVNmeXhL?=
 =?utf-8?B?QXhoenRqVTZFWVdBajNZLys1RXZzcEtPaHJYRit5bk0yWGlxWTJqWVBJV3BW?=
 =?utf-8?B?bjJuUUxZeDhVL3Q2bkJ6N2ZQL2l1eHJTUjZxekZiOU9pTzJ6RUdjR3ZKTFdY?=
 =?utf-8?B?Z0txYUFPL0w3OGtiSmM4WCtMY2VpbWVZdWJPNVYvMnF3MW9BSXVoMHN3YTlB?=
 =?utf-8?B?cWZsOVpMRG12TVVQSW9FSkpscE1WL3NZRk41aC9EQ0s5M1JFVzJaSDZubXdB?=
 =?utf-8?B?eEVlQzg3QVdXZDVNVGVKQzg5RzRIb1pUeDl1SHBZd1F2eExiME9oZWk2bU1x?=
 =?utf-8?B?QlZEZnVOYWZxNWVoUFFLR1JrUHBnQmhybXVrTGZ5UWtnM2lteTd5aThRLzBB?=
 =?utf-8?B?dC96NlphWDhFV3JiZmhoRCsvUkEzOTllb0xONmdNT0V3TEpuT3FzTm9nbUt5?=
 =?utf-8?B?S0xQaGFDcS9rTDFYY2Y5Sk9ZWEsvYkFvamJYSThqZTREUmY3REZHbGRDZzUx?=
 =?utf-8?B?NG12VUt2dFpBQzBWQTJWSUJCTTkwTlhXQjB3ZTh1US9sNHBYQ1RONzRDTFBt?=
 =?utf-8?B?VWE2NVFzeFY4UDFaWUNwVUxCLzBPNVhhYnNBdStaOHRxYTJiM011L3VzS1Jv?=
 =?utf-8?B?ZEFOTCsxUFJGcGtnbVVTM3Z2T254Sm04THlTYmIzOUFHZWRRMEJUY1RaenRp?=
 =?utf-8?B?NjB4MVZ1TzVqeHRzc05TbG5aYWFyamg5QXBHa25CUmxOV2FDNHMwZUJ2b1A2?=
 =?utf-8?B?NkxDM3FRZGN4Tm9kRmFtYlc4cnpyL2loZWNGcHRnNnVJMlc0a3d5RHBSNUNh?=
 =?utf-8?B?THhyaGZQY0Z2TVIxS0tSangxNFpZZWpQQzg3Uy9sa3QweEpRNVg1THUvTDJF?=
 =?utf-8?B?T0lobkFrZlQ1a2d4WmY1TDFBbVFJd3dwbVkyRkJndmY2dEt5dlNKT1NKNDE4?=
 =?utf-8?B?S2lMaXFQN0ZIZVJESEVRZzdjRm5Hb2ptMDFlQUdVRTVLRWJ4czcyUUdoVWdn?=
 =?utf-8?B?bDMxMDBHWFJndzc4VGpsVGNSVVQxTjBqZnIvZXd0dmZQTm5lc3FhSUtzeEJ6?=
 =?utf-8?B?Tm9HdEs5K0EwaGNJTjdWcy9vYzh0QnBIOHcvZGwrQmQweXlKRkxuRlp3dXoy?=
 =?utf-8?B?Vm42OXJoMndDWEJxQ2xnNDVLQTdUYXh4NlBWVzBqUmZBK2pQWjV6cHpCZFVm?=
 =?utf-8?B?ZTZUZy9VNGkyYlRZTnRyNUNlOG1GT1RjdzZyQkdTZmpBeThrNURZNXFBSnNE?=
 =?utf-8?B?S2RYL0RveTZjYlUvcTFSZGtQaTl4T0lZRXFRRks1WDIyaEtHdEIreUlKZVFJ?=
 =?utf-8?B?cnpLZTJqblV4eC94MmpNM2YrVTFLdVlRS2tDcUQ4dVg4YklVelM5WXZtVXZS?=
 =?utf-8?B?d2RIR0plQ3FITkpSL1l6TVdYd1RGYVgrWTloT1JKaDZxNDcxNEVaWmcvS2Fv?=
 =?utf-8?B?SENZQ2oyK2lmTGhDTGtGclRSMjh3Sml5TE1iYjdHTHo0SlVyZjB5cjdQMlpF?=
 =?utf-8?B?NlF3cjBqeUNuT1VtNFQrTzNURXVMMk8xR1VTQTc1c0VDWjFjd3N2bEpqUFp4?=
 =?utf-8?B?Wld2a0srWFNORjBuM2IwSFFqQlpYOUd0VDBpei9nUEpaaFBkcm5QdWEzQkx6?=
 =?utf-8?B?WlRZS1ovdXBodXRvME1pODNvS0ducEllSHM0YmpCQXNSVFkrSlVWbDd4aUtI?=
 =?utf-8?B?QjdlOVJqaHNIZzYzWGJVTDFCZ0UxdFhpcmVjUkZVb1FLNmxsVy9DWEJXSGg4?=
 =?utf-8?B?ZlI3c2ZaREJ5alNoaHNtc280Q0xyM0tLTHBST054VkpCTzVmY1o5OEVTaGFB?=
 =?utf-8?B?ZHZ2U1NEQW9Tbk52Ung2QnYyVlBwekdMR2NreWU4bGQ2aHVpZ2h3bUdrN3VF?=
 =?utf-8?B?d2hUdVk5Ri9BaGJza0hHMGNuU1dseWZidk9rTUJIb1Y4YnlWSnhscUxpV01q?=
 =?utf-8?B?a2hDeEcxQnYzeHVseTBLQ0RQclRCbTFHN1pPM3VSOGpjeFZDWHYxc0NqdlZG?=
 =?utf-8?Q?9fanbFQ//ctQO4wbtFzq9xK+8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df17b557-8645-4eba-2207-08dd7da23439
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 11:22:57.3235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COt3v+23hzFqT9GshBiWPaEHlUUSL1oFWfejBmI/fXuZCSo9kK5vf3aOTgNUYoc8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

Am 17.04.25 um 13:15 schrieb Sunil Khatri:
> Add context and seqno of the fence in error logging
> rather than printing fence ptr.
>
> Suggested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index e944d05685dd..cd9dc0018ee6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -43,7 +43,8 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>  	if (f && !dma_fence_is_signaled(f)) {
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
> -			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
> +			DRM_ERROR("Timed out waiting for fence=%llu:%llu\n",
> +				  f->context, f->seqno);
>  			return;
>  		}
>  	}
> @@ -630,7 +631,8 @@ amdgpu_userqueue_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  			continue;
>  		ret = dma_fence_wait_timeout(f, true, msecs_to_jiffies(100));
>  		if (ret <= 0) {
> -			DRM_ERROR("Timed out waiting for fence f=%p\n", f);
> +			DRM_ERROR("Timed out waiting for fence=%llu:%llu\n",
> +				  f->context, f->seqno);
>  			return -ETIMEDOUT;
>  		}
>  	}

