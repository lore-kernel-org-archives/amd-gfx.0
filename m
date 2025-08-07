Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA69C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 20:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E2110E494;
	Thu,  7 Aug 2025 20:55:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M0kHXS5+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E8010E494
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 20:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8TcO6ldo+HoYego/rpaFlp1i3T8qTakWOB7B4mJFYNlAutGyuH266MqDJZ4cIl5dqA2hf0ximZCkmp+2CZPF0ctsBlgYwONdD0I/LbvtEV0YW7pEwQT/W5jmX1ndT6i6I3gg28vDnNTxZoIB4iV/aowQ7bEQUwbAtXLTSarnHtYm2rLR++VRTGc6xyO7ZxLusMfi02DI0cWNzeQtwPs2emCV6/nIFEbtF54YA2ZIxB/XqD9J1tXRU9USbSMVG8xw+YP5+6etnnrp//UrEO0IRccJmA+jJqb6HwSEQ4ZxCOufHdwUba/RuvJzuyzIIg6l7W0cmufLdURM/SJMvoKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC+exTUvvKT7bGjIH0dAjpuweyN9ooeFqDZvSnklOvI=;
 b=dod0oYaPa20xNR5Ive/hxwpMsp4bd8maAsqzOlFbn1e97605BZnQsHFNoLX7PmD+TOoBG9fKRbgPGnrqoRreAOeTxe28uXerRNsCwIg1jIYGAvHqJaFHr9ceQv8m89xKoq9uQltF13Ug8tM1PjpE+o5hWk1L9bAhKcaDcII2Pf7sj4HNSRbDQN51qJmf+fXI005FB66CjbDv7K5kacv2Ddz9w7eqWM7vb34JILKkFYu5JiOQvo2/IKD9Jlinc3y66VM0xV5mEfOh9QPevYzgrAg7fVMJ2kTHcLhDtiwg5ohjfspZu32DzOig0DEQIksNQkFrMK3GD8ukSS3ossdvJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cC+exTUvvKT7bGjIH0dAjpuweyN9ooeFqDZvSnklOvI=;
 b=M0kHXS5+JRopjTOkPGvCYDxproZ/MktmPnfbzeznj5txsN5u21q7/Nk7E1rtK4+dFZvzlXbkUek188ceTXW5iVUQ5pmB2vFjcqM4oksHImhlSGqG8kBa1Mq9jQ9kvPZX4Lq7lGxjJGo5tr8SxPZeNPTIRH0Hs3oX4rxc3lkh88g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 20:55:52 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8989.020; Thu, 7 Aug 2025
 20:55:52 +0000
Message-ID: <22d6f206-a3c0-47d8-86fb-8d6aefa775c0@amd.com>
Date: Thu, 7 Aug 2025 16:55:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/13] amdkfd: find kfd_process by filep->private_data
 in kfd_mmap
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250804110550.261311-1-lingshan.zhu@amd.com>
 <20250804110550.261311-10-lingshan.zhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250804110550.261311-10-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: eba413c8-2079-4b5c-bc78-08ddd5f4cb89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V09KZGZqVFBsTEY1d0EybVV3a3VqaVgwaFFwSitlWmFGVUpmenl1ZGUzNWMz?=
 =?utf-8?B?WEx2MktTdGM5YUJxVHZPSmdESGpZQzFZUjJyd1YzZzZTT2JNM0VjRE4zNE1V?=
 =?utf-8?B?MjdPK2kxNHRTU2V5YnBXZmJMTmRiWkYwOFFuRVFrZWdsNlRibUtWS2hIallz?=
 =?utf-8?B?aDFIZy9TWUNVNFJtNm5SczVWRVliWER2M3BZY01nU1lLYVV2SHl5QnU3cGV6?=
 =?utf-8?B?SDNaRFJCWlN0ODI1MC9yMjlRbGU4cVdxakJuNzJsZVhoOStScXRlSnhrQUZJ?=
 =?utf-8?B?SmtRTGtLN0ZDQlkwMnhzQ1lSTnhvQzUrWWpFRW1rN09HQzkyM29JeEczb2xG?=
 =?utf-8?B?SU1yOFFDM0ZjNS9MbTYxOHF4R1dEQTA1Y0pXQVdlZlFXanM1UFFlWDB4S3Rl?=
 =?utf-8?B?dWJEVWE5Ly9TcFo4MmxOeEN1ZzcreDFDNmxNREcrcUZicUVFVlVSS0lUZUp5?=
 =?utf-8?B?VHJaOTZmRzNoM3RVK2RLRENhTEpTVytSWEpUVWtrK3dYQzdYdWdOVGtTLzRr?=
 =?utf-8?B?ejVhZzBIMldZS0JFZFlveUFoTk5OcHFqbDFaWm1JSlVGZ00wYzFObEZvMlVK?=
 =?utf-8?B?WlVTUmhjT1ZYQitwWWpQNWx4QUdlaE44aGJzcDBxRUx6VlpjSHp6VHQ0N0hN?=
 =?utf-8?B?TGFuSGVPUnRBK1VWMTBlU0FJdlVnTWc3VXFVQk9yRm1GM3kraGFwTWt5aUV5?=
 =?utf-8?B?bDlFRGZielZFd1laK0pWdXB6Tmh0SFB1bGRLbFlhV1RQVHZTbmVGSzNVZVBt?=
 =?utf-8?B?Z1JTd0pBNTNtZFo4N2FVSXVSUXFQRnNGWHFlQklnaWJsTEpXZjJtRVhKcmc0?=
 =?utf-8?B?OTNyWmN3V0E0dzlJTUdjQWs1aVlFMzRJTG4yVHdXN0J0MW9jVHFNWU1hcjhY?=
 =?utf-8?B?OEVRcjhOUEFhNEpOOGNHSHBibDllZnJPbUZNaXViK0RvbEZHWmdRaGtSdEkr?=
 =?utf-8?B?QXlacjVLQTFteXdhd0UzWlozQlVXZjk4RTUrbk0xRjV0RTV0RjRmYWRGb2Zs?=
 =?utf-8?B?T1RRUUhsWVBZZUYrUFRaZTZFU2lpQUtRZDVwM0d4YkpMQWRocUg2QlJoeDBW?=
 =?utf-8?B?bEdaSnVqcUIvcURjVUFzVXB5ZTdITEpvT1NFWXhwa0RVbTQ5ekJqM2xGVUtF?=
 =?utf-8?B?MmxSYnhYbTNxbjlaR3VNTnVZaXAxQW9vUWwwQ2VBMW1FL2IxeDdPeFdNM1Qz?=
 =?utf-8?B?cWVaVm5ORlBjbHgyTG9OSnlvVlFjT1RlWkY0SDlEOStlN3JSa0t1YnRmUUVP?=
 =?utf-8?B?VitFUG54VWtNTXJPNEhLOHJHMy8vRkRSeE9mdXR2M08zN2dLSjg2Vy95a3lS?=
 =?utf-8?B?TE9HQ2RUaDhzOE9zWmNZczE2U3NrWlpUTmZuWnZTL2JjRUZTcG1HK2RJMHVs?=
 =?utf-8?B?MmFTVENaTThSTFIwMXhYL1ByRDcxLzY4QU5kTUpaWjNnT3NHeVBHalNzTkNW?=
 =?utf-8?B?RGtpM1FzTDFMSUdRQWRsdW85bmtIY0FNMHRMWU9XVjk5M2pJS2JYSzFsYlpS?=
 =?utf-8?B?MTRjVjc3MnhnLy82amZwY25CMU51dFNjdExheWZEVjM0bmlhN0VVVk1lWVlY?=
 =?utf-8?B?Nm1TcW83ODNNRlhpbyt5MXFXREczRm84VkR6WnJQQ213ZHI5dUk4NWltVHpV?=
 =?utf-8?B?cHZnVWxTc3B2TkhWUVdZWlRRMHIvTnhETzZuK2lGeUNERTR0bnJ3aEhzenE4?=
 =?utf-8?B?S1B6SlUwMVJNcjc0cG95U2NkSTFvcloxYmZrcU5MUWNpMmFXL1hOOUt2K1pD?=
 =?utf-8?B?TWc5V0xGZWlpY1hBUkJEUUhNY1ZLdlh1eUh5OTdNRFJZVXBJWXo3eXo0cXZo?=
 =?utf-8?B?dkRRb2pvajl1OEc3V0NhSzBYcVgvWWpZbHF5aTIwd1R5UGNvY0VtVWVVbVg4?=
 =?utf-8?B?QmhjRFFIWGc0a1A3SzlWYjBPeFhZOXdMenZ6QkYxYmdIRVVNMU5ST0FoUFpL?=
 =?utf-8?Q?EBSuDICgFdM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnJBUHBTWjdxSzdlZXVTbXVyVjhOSDdUZG5kdy8zRTRDdkFEN1JpMFpiSit6?=
 =?utf-8?B?cTBnNWdhSEVFUVJwUXdSa2IyYTRmWVpDTmJVVFMxVGVZaWs5LzEwZ1MyWmJq?=
 =?utf-8?B?Z2IwM2VxRGIzV0c1RldiSStsNUhKbFA4RTJWWmpOVzNZNFRobHRvMlYzOHpa?=
 =?utf-8?B?UWJVSWlMbkE1d25MSWlPYXMrYnhVR0tpNmlFSEUzVmE4anNlUHpUTDdLYmE0?=
 =?utf-8?B?Y2VoNVNmQ0Z3ZGVUUmZmQjhmL09nUjZ5TUg0Ujh4Y1d6STI2UlZlSVJ1QTND?=
 =?utf-8?B?ay9tYVRIMGNBakJ1SFV6M3ZrWkpaTnQ1Q2IzK1o1WHc5U1BmaWhCYlMvK2k4?=
 =?utf-8?B?K1gxTTVDbzhUNzhpcDhSejJQSnR4THNNTjJzSldDYlZSUDlzc2YzNUVXVWdU?=
 =?utf-8?B?dHgrbDZlaUhMbjYxbnc0bGFkMTJnOUU3SkFNMXh3Q25maEl0UjNnRTlVRHN0?=
 =?utf-8?B?WTZkSjhjSml1YkV5NUpDTXdGM1A2NVNvcStSdTN5T3N4NVBrVGpzb3JEWElF?=
 =?utf-8?B?ZnRnVjlnb1Y1MzRkaW5pc2hkSGgwY1hzOEdqbVBNVEtVbm5IT0pNU1M4ZHI5?=
 =?utf-8?B?SlVFSFAwSGJqQzNMM3lwcFlSMFJ3RTFOdHZUNXpzMStJY2ZLR0E2aCtDWjcy?=
 =?utf-8?B?Z3lkbEM2SUptMG1IbkNHc1B0QXM4ZTExQjNxZmtzTjVEOWpWTWxSem5MUXF5?=
 =?utf-8?B?SkZOY1BYM2VNelFweEtJanNIK2ZhZ1RncnJhVkM5ckdYVk0xRHVjSVJ0eHFt?=
 =?utf-8?B?VU5yT1FsSjhhM3ptOXFOcWxZWFZKRGpZdFU0UjFPb3VFblZxU3AvTzFFSlp2?=
 =?utf-8?B?RWs5T2tVZ21FRkhuSEZpU3RRb3VObVNwd1JoNUloZHFHaVRkc1NxdlpObEFs?=
 =?utf-8?B?MnN5WWVQKzBJbGQrc0s1UytXdHY3TnZOajRqSVhJRWtmSVcxNC9ITlBZOTJQ?=
 =?utf-8?B?RW16MzBrN3RXN0h1MkZXNmFFMjZibS9RTkh0eDlSc0tWUVJjOElsQk1aVC8r?=
 =?utf-8?B?V3lQMytiRkZscVVLdGZVL2tBakVwOGlMcXYwQi9FTkZ4RkRhSGZnK2pHZ2xj?=
 =?utf-8?B?MHpWcjJRS0prMXVWVGJoZlNLWGtWb2pxbmxHbDkzSDhxWjMrOVg4TUNmdXZJ?=
 =?utf-8?B?d1BlT20xV1F4SWQra2lCT1VUSFJkYUlhV1lhSzV4dWI1ajlDSXMxMkc1d1d1?=
 =?utf-8?B?VDBXR2dPMEJSRGdqZHR3bndJb2s3N3V5dG9qQnEvc0Myb20rNnFtamI0cVda?=
 =?utf-8?B?aTdtMlBpdE9qV3RGS3E2RGdQcTB0QlM0UU5zVVRRZklTcGpsTlB3MXMwd2Z2?=
 =?utf-8?B?a2hLTnhINXVRVlZkOVhHWG03c0IvaUlaV2xob2I3OFdMOWFMVGxnOW5MQTlZ?=
 =?utf-8?B?Ty9VWEZ3Wm9IODVmMlBiZGhOWnpObTIxemR2bnBEdjYzRWd4cGF6c0I1VHJ6?=
 =?utf-8?B?ZjdwT3Q3RUMzVkRVUUFzNm95YWZWaTdGZVU4MmgwaFo3WVdpR21sbmdKbGVN?=
 =?utf-8?B?dnpDL1hpRTl6YTVrTGFFc3lWWG90NmdhWVhHMTgxMG1oTWFSQVdVdWdZd3Fz?=
 =?utf-8?B?aGp2d1lzSXRIWmFCblVWMkVhOHpVdGRpdElvSXhYRDZtNTZDWDhqNTd3TjRM?=
 =?utf-8?B?UlNaYWhLNkRkbkZMQkFGb3dBQllxS1RCVU5pUldBM1R3bDFKNVVmMFNUdkRq?=
 =?utf-8?B?M04xOGF5ek11TndIa2NoZlNpdTRaN1JBMnVUOWYzd1pCR0FkTFRUSURWM0tG?=
 =?utf-8?B?WWZoTUZXTitGOSs0RFZNVksyTFVBNEQwUDBFcytJWkpWcW1JRHZjbnNkckQy?=
 =?utf-8?B?cWR5Q0sxTVkyMmQ0QWFUODBIaVpqSXozeStsSmlsZlFuUVlwNUdoNVdsSGY1?=
 =?utf-8?B?dVlwcWlkU3dqbWNQNmxZZ1FEU0xRZmdNZ2R0K3RXbmVDdy95dG11T0dyNjZB?=
 =?utf-8?B?M2V0dVdvelJ2T3krUTRpL3AyU1hKdkQ1aXpWT0ZObjdwamxycTVpUWFQUG4v?=
 =?utf-8?B?dXFvQmdzTC9zTkduZ0dLdlA3OC9oZ2dURVlmcFp4a3lqc21DSk5mMGxpdzQy?=
 =?utf-8?B?UEF4cndRQ0RaL2NvVGFDYUlDMVNkclVLRkdOQUdhZUs3RkZlSklJelVTMkdV?=
 =?utf-8?Q?39V86K7GOLHc0gLSM0gTiuVNW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba413c8-2079-4b5c-bc78-08ddd5f4cb89
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:55:52.1634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbpojPKk2xSvV3zB8DbRYWlYyZWy5pvyjIhIXRDyeIhL7yq9SlJXvzwTQ2KH92GGbhmqjxOF4eHFZCIctCSHNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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

On 2025-08-04 7:05, Zhu Lingshan wrote:
> This commit finds the proper kfd_process by
> filep->private_data in kfd_mmap,
> because the function kfd_get_process()
> can not locate a specific kfd process among
> multiple contexts.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 28df35a63c29..662b181f1fd2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3407,16 +3407,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>  }
>  
>  
> -static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
> +static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
>  {
>  	struct kfd_process *process;
>  	struct kfd_node *dev = NULL;
>  	unsigned long mmap_offset;
>  	unsigned int gpu_id;
>  
> -	process = kfd_get_process(current);
> -	if (IS_ERR(process))
> -		return PTR_ERR(process);
> +	process = filep->private_data;
> +	if (!process)
> +		return -ESRCH;
> +
> +	if (process->lead_thread != current->group_leader)
> +		return -EBADF;
>  
>  	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
>  	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
