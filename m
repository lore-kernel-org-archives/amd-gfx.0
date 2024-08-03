Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E41C3DA7F
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Aug 2024 00:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6084E10E00E;
	Sat,  3 Aug 2024 00:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeYILJqr";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDF910E00E
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Aug 2024 00:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpVGiEpQhYZ41aDLFSDjNn8HHC8pI263kk4sYeTGuFEVs6QQv1IzsLmQY4gEpkH2Le8iCc59Q7M9WjPboM0U3peqoqDOYULFVC6OD2FZntMe/ojzmtFgu2CJK6s+jnWeEw4ztJGsZFW1AfIAWfD+rdny8+IIQUBrvxPtNRaSrtDkp8wEgLseeKLm4NoZvvNuKrnCqEcgLKg1BjNUq1yp873E0k6l/RTUmeJABT/ZvY6pPT3rinhdUxsekm+mMGJeRP1WmjMeoQsJzrfrwy/Y7rEbnKJ2c7IrxTSgYjHOCX8mXbllJ6j0YGaiERp4SGUzUZE/z9HQSMaW3b6HW9FPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu36yIGNnxU7zw70jeFVZ60oxIOWz0fRQiw54HYz0oM=;
 b=q8Iy+BR4h4ujPLT7ZDVW0PaYWy92SQFky+FjXqvwY4Op9joG0rCw/MpdsDQxm6t8uzzru3GzHvHxoikRPi+yLbnB8LY9jHrVMPy4AY4DH4dg1XMa5YyX5nsLVR6PdkqU6c0w5JuVYOHisaQqFYd0ETkZdRSvZP6P1LNKs/1V7+jzKfsDVmw405tw9b2E/ES5bPfBFO7PzWHQ95mOZL1pe8l+QadF3nrkI8mUO5NFLGqpScFgiBk1x65B72nond4uB2dnSWlsjHPsPyQQmbNpOFqqbXD3pzFPUEkAoAlu1dFUYATOmemZAsDCAolV9kAHEeyBAYCq+nb0/yZlihPeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu36yIGNnxU7zw70jeFVZ60oxIOWz0fRQiw54HYz0oM=;
 b=XeYILJqrnBd/+SeNTYBSzXbzv35CJyf4W9YzCw8diO4pkm7t+CXP4FdBAQOm/Czmv8l17phUrM+p+cWZ2S42X9sN+lq5xynw+raRLQrzsTGp8/vaPNlPqwFRRO3N7rXL6XOHLSUOKbvD7jRZL99ffSdaL1WYsr94LvzbyKQ+EpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Sat, 3 Aug
 2024 00:59:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7828.023; Sat, 3 Aug 2024
 00:59:33 +0000
Message-ID: <c71b3b16-ec04-48de-b76e-58eb8bad7677@amd.com>
Date: Fri, 2 Aug 2024 20:59:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle queue destroy buffer access race
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240802152845.7978-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20240802152845.7978-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0468.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3dcfbf-df99-4017-abb5-08dcb3578975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3oramRhakxqWGRQbTRBaHBWT09RNG5aYUNFTjNsVFlTdEdTQWJsSmliY29J?=
 =?utf-8?B?ZnU1N0lpVUtjaFNwbzVYMFFqTzN4NEc0d3VNUWN4U1ZtVVJJVjcwQTVNd2ZJ?=
 =?utf-8?B?WjhvNldUUXNWM3FNb21uQWMwUGRJV0swMG1GYVdZQ3p3SnRoQktXZnJra2Fo?=
 =?utf-8?B?YjR0NGhlK0dPc0xJV0pSZmIrUVhrWS9aTWlXWG9SaWdpNFcxS3VaTGE4ZHRK?=
 =?utf-8?B?WjJiTnNrdHRsejVQRnloQ0F0RGZBdnpEdU96dFB5a1FVSSs0MFl0NFRKY1RX?=
 =?utf-8?B?VXNtM0hlT3F4cTZDelFyY3UvTnZOK1VlS2FmOXFYNmMxM1hjNHJ3TmxNUmJR?=
 =?utf-8?B?RGROc1M4N1oxamdub3lhZUxmM0RuaG5Ea0p6RWZFWjJXajN2NDg2d3R6UDVE?=
 =?utf-8?B?emorWHpoeTBLd3NCUWFGcU5na0k2eTBBa1lDVUlsWDlMdkxaTVZZbzkwNXQz?=
 =?utf-8?B?OHFacUZuTE5yYU1nRlJyTktPWFZXUi9uMkZ4clVsS3Q5aEtucUtIY1lqM2Nz?=
 =?utf-8?B?dDJmaUVhS0dleElnSlBzaFhqdk51bnl3NENTWkdBL2lZSmhLMk5OVXN0c25L?=
 =?utf-8?B?K3lVMDlWQ1NaL25oTm1RVEhTd0FvdUdPc01udDZmSTVuUDFFNlovN0tUc2dN?=
 =?utf-8?B?VE94NDVqMTdwR2VFeXNoOXRPQ2lnNVV6amxXa09Vd3hUMFNQeDFpdkhhS1ZD?=
 =?utf-8?B?UTVnOFJWaW5xTEQ3V1dUQWN5R3puL1JFd1BVOUlwSzdjS0VuTjRIQk1tWVc3?=
 =?utf-8?B?K2MvcGo1K3pHbVYzVm53dTRDWVF2Ui9CRWhXZ3JXYnFaVzZ2dWgreDNyamNF?=
 =?utf-8?B?enYxK1hRRHBvRWQ2WmR2cGtwQ0l1RU5HMmRxeERhZ1V2OUh6b2FkS3ZzdjZW?=
 =?utf-8?B?MVFEWkVqVVR0NU5JSGU5QlNlU0YwUkQ0a3ZaaUNUS3ptRWllbCs5TUVuZkJn?=
 =?utf-8?B?Qm4vVkxMNFdFem1rak5BRlArZElyMG9CVWZvbVpiL2k1N0kzS2RpeEVlcWJM?=
 =?utf-8?B?VUJXZVdwQmpqZEpWYXloL0hNTy9CM1YyRjZsRkczYmIzUW1rUzltTFNjVVp0?=
 =?utf-8?B?U0d6bERjMTFBVS9UOGJ2aWZIeFFVYkFrZFFvWnBJYkhNS0RvVHJSdFI5L1hF?=
 =?utf-8?B?RlJvcUZpUHZVa3dWZEl5b0I3NFJORFVYNTBpTjNzZ2tXbzZOUkdjT3Axangy?=
 =?utf-8?B?cGx0ZjZBSU5kei9iT1VmYlNRRUQyUHhpWDhRQTJrNFExOTZQK1Zuam5SMndQ?=
 =?utf-8?B?dmJ4ZFlVVG10TEhORnI3U3pNZldGU1BYQ0ovYzE1S2g4QTNmWHdkQ2NadTdS?=
 =?utf-8?B?QkxRaEdrUVhpYjZNN2YvVXM4bERvWnBMN1Rwc3laNzlJaU5MUEoyTlZxZnNz?=
 =?utf-8?B?RXpOQ1FLdE5hWUM4QTl5NWhISXpaSlEvK0V2RzNualpCc20zOE9oY3NKRFV0?=
 =?utf-8?B?eEp2eUNTOXFNTGJyM2VXRGpTWnVsQjVSR0ZPT2puUE05cjM2NWtSNDBFcXk5?=
 =?utf-8?B?eGYxWU9nSE1vdHRKSlNxUGtJSEhXb2tNeVRlU01xS2dsbnZwMVdwV3ZBL2c0?=
 =?utf-8?B?VkVlS24zbWd6cnhiQldFLzdMM2xzcFhscXg4QnAzb2lQOUp2WnZCbjNOUGhW?=
 =?utf-8?B?LzR2c3dLNmlia0cySnR5eVRjMUFYYVNzOWxHdWNqc2JCUTFoL2tSb2pUTFRR?=
 =?utf-8?B?TXkxRkJvbnNCWUh0ZEtvSU5uUmdRb1I2SmdPS01LUm9tdjlDclZwbjV6MEFV?=
 =?utf-8?B?UDdFS2UvMUp6MDRQK2huY292TWdxN0dHWXhVZXN2SnA5VEdha2VWanVWTC9j?=
 =?utf-8?B?d3ZnTDJ3MDc3d0M0Sm9qZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2NTOXIzZjdXUEFMQkZyZlNCcy9tT05mQUh2REdnNU9yS2psL3V5NVpESEdq?=
 =?utf-8?B?U1R1MWVxNnpuS2ZGbk1CcUZMQkp2SnZVb0htMW43Y0Vqc0FwUjgxTXJlczBv?=
 =?utf-8?B?bHhoMzgyd3loUy90UmNNQWtRT2dmZkdlaGhzbTcxWklVRldKeS8zVnBNU1Fm?=
 =?utf-8?B?YnA0SjhDT1ZHODB6aHN4U0ZHRGJhOW5ZV1VSQWJ3emJUamUyV2NZMHJ2cWxV?=
 =?utf-8?B?R09CaXZtMTJ5YWZ2dEkycDUvMWtwMFYvVlRLdjA4cjUwVkFkL2JkK3MrWFd2?=
 =?utf-8?B?d3ZBaHJkME1hV3VJOFllSlovcVFJVG43SmxEN3ZjL0RqWk1pQ0t2QU5KeTU3?=
 =?utf-8?B?N0FiNlAxZ3JMQzVBTTlXSXBVeHNRTDI3Y0w3TFVFTmQ5eC9lNGZscThUNWZL?=
 =?utf-8?B?eVpucmdCenB3aUhsVGtJbTJwQkxVSHlJNUNHMU8xME5ONXBscGtkVzROWFN1?=
 =?utf-8?B?dFdKWStOMStDR0VOR0FNdVBTUzNPZVlSN0RSaDkxNnduSUcwbHcyaE9mdVk4?=
 =?utf-8?B?S2pSVEV1L3RIcW53eDBwYWdGRWpVRFBZcldFTlNLejVmUFNTZnZaRGJGZGRm?=
 =?utf-8?B?ZkMwVzZxSENJd2VIc0RSUk9VSmlmdWRpem93QkdzTno4T3NIOVpSWWJBLzM3?=
 =?utf-8?B?OU1GODhHa084aDhQeWk1cmVnYjdYbkdaSkw2U1BuNEZaRzVTTkIyUC9SOUdJ?=
 =?utf-8?B?aWFwem1aZFVtTTNVeGpOeERJTzJkZVNoeUpValErR2VhK2lBV0hNcDNnQU90?=
 =?utf-8?B?a1BTQVNJYlE2eS9NSDRKcVJhemFhVzJtVUx6REF4YnlRUzYzelVNMm9uQmdF?=
 =?utf-8?B?R1NYTUhJOHJLUlVuKzFRNm9JZ29ZcUhvMENzdEpXNTlMclpKNWU4eWdZYUk0?=
 =?utf-8?B?VTBCNFl6ekhQZUIzYnE4WTBRUFNQM2JWYTk4RTluVjRpL3lRSUtLRkJvTmMy?=
 =?utf-8?B?OE16VjNPWHluTjJGcFl3bVRRaGd2V0FRN2wyWHRiMG5nczk5aDN0N1ViOWk1?=
 =?utf-8?B?UkFHNDFnV3hxTXZhNFkraHk2S2VyVUdWVnI3VHh0WDE2bVFYdTd0a2dRNzlU?=
 =?utf-8?B?WlFKbHBOKzZEVkxua3JJWGZuSGNseG9DOXFKRWRnTExmcVdhbFl2aXRleFhH?=
 =?utf-8?B?ckVFZGx2eER2bXltT1QrblpGa051T01KMzJ2RCtyc3JOTWNEdmFnYUNyRmRL?=
 =?utf-8?B?UmFXb00rTWNaeXdmWjM3YlAyeUs1OVZaeHVFZ3g5MGZNdmIvSzlqZlJGWHRv?=
 =?utf-8?B?ME42eGp0ZERDclBnSEtMOTB0NFRFU204eHc5QXBVdUFEYXNnSzNiampnbm1i?=
 =?utf-8?B?VWRCbzFKUGE5M2c0MmcxRllDMHRRR0ZINE5jd29ISldRTWFLSHpCandQUEdK?=
 =?utf-8?B?TmJ4YkJvNG5qNW9wQVRQanl0eURWN29yNmd6L2MyamVpM0dsWXk5c0laOW1D?=
 =?utf-8?B?QUllV216OWRVK2N5YmlESVpkc2xjSFpyUjVCTGdTVlNKYkRSQ3o5c1ZkT2N4?=
 =?utf-8?B?dHpiM1BteXNQZWwrNkxicXVpWWFiOVM4aFdIaWN3amwyZExEMWV0YWJ6RzAx?=
 =?utf-8?B?NmpjSUVqa2ZURVhKMWlxMi82VVcyRDZ1amlCWmtqOGhjcGdEMVFaejFMa2hm?=
 =?utf-8?B?V0s4MlF1djVIWXJoemp2QXJQcTlCUStEb1E3dEhmZFZOOGJGVmZhZ0VIeXMv?=
 =?utf-8?B?Z2E3RklxYXQvQVMzbEY0eFB3NVpRZDZIZU9aSWxEWitwWWxMdUx0S2Vna3Qy?=
 =?utf-8?B?cEQ2NDRjZm5GQWdUS1U5czR4OVVyQXAvSTBLQTY3QmljWERGMHhubUxMSGo3?=
 =?utf-8?B?Z1ROTFRqUVp0b2pNSzJseXhVU05FaFF1NUEyOE5jYmhRdmJDQXJXcXdkL25z?=
 =?utf-8?B?ZnhGanEzdlFLRXRlUi9QVFBqcmh5Q1UwajkvTXRidnBOakJnZWhtT2o2aU1Y?=
 =?utf-8?B?RmphTVFYU1hseGFDRlNQOWNwVjJEV0c4R2M3RTFySG1nWGRRVW5GUm0rc2NM?=
 =?utf-8?B?OFZEd3h4Z0h2STlPNVVoci81ajNXYzEzekNkSkltdlRRK3AwcW5KZkFITzkz?=
 =?utf-8?B?c1Y5MFRvVTJGLzNubk1yRlNLQXlUQytsVGVuWDkyREdkeHN3bWNDemVRN2FZ?=
 =?utf-8?Q?7zYpCTxruQC7JQG0KsiYKZIy7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3dcfbf-df99-4017-abb5-08dcb3578975
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2024 00:59:33.1209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /o/KniU9Ua3ACyR/VEjyfsL3KASwphzkOu6ll9hFpZrpfxH/HF6/rdPeteHhVSyOniPso646GQNLfQxqd8nRRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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


On 2024-08-02 11:28, Philip Yang wrote:
> Add helper function kfd_queue_unreference_buffers to reduce queue buffer
> refcount, separate it from release queue buffers.
>
> Because it is circular locking to hold dqm_lock to take vm lock,
> kfd_ioctl_destroy_queue should take vm lock, unreference queue buffers
> first, but not release queue buffers, to handle error in case failed to
> hold vm lock. Then hold dqm_lock to remove queue from queue list and
> then release queue buffers.
>
> Restore process worker restore queue hold dqm_lock, will always find
> the queue with valid queue buffers.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +-
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  8 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 62 ++++++++++++-------
>   4 files changed, 49 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 0622ebd7e8ef..10d6e29b23cb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -400,6 +400,7 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_create_queue:
> +	kfd_queue_unreference_buffers(pdd, &q_properties);
>   	kfd_queue_release_buffers(pdd, &q_properties);

The naming of these functions is a bit unfortunate because 
kfd_queue_release_buffers actually unreferences the buffers, and 
kfd_queue_unreference_buffers affects the virtual address mappings 
(technically amdgpu_bo_vas), not the buffers themselves. I would suggest 
the following rename:

kfd_queue_unreference_buffers -> kfd_queue_unref_bo_vas


>   err_acquire_queue_buf:
>   err_sdma_engine_id:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 057d20446c31..e38484b40467 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1298,9 +1298,12 @@ void print_queue_properties(struct queue_properties *q);
>   void print_queue(struct queue *q);
>   int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
>   			 u64 expected_size);
> -void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
> +void kfd_queue_buffer_put(struct amdgpu_bo **bo);
>   int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties);
> +void kfd_queue_unreference_buffer(struct amdgpu_vm *vm, struct amdgpu_bo **bo);
> +int kfd_queue_unreference_buffers(struct kfd_process_device *pdd,
> +				  struct queue_properties *properties);
>   void kfd_queue_ctx_save_restore_size(struct kfd_topology_device *dev);
>   
>   struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index f732ee35b531..ef76a9cbc7e2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -217,6 +217,7 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
>   		if (pqn->q) {
>   			pdd = kfd_get_process_device_data(pqn->q->device, pqm->process);
> +			kfd_queue_unreference_buffers(pdd, &pqn->q->properties);
>   			kfd_queue_release_buffers(pdd, &pqn->q->properties);
>   			pqm_clean_queue_resource(pqm, pqn);
>   		}
> @@ -512,7 +513,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   	}
>   
>   	if (pqn->q) {
> -		retval = kfd_queue_release_buffers(pdd, &pqn->q->properties);
> +		retval = kfd_queue_unreference_buffers(pdd, &pqn->q->properties);
>   		if (retval)
>   			goto err_destroy_queue;
>   
> @@ -526,7 +527,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   			if (retval != -ETIME)
>   				goto err_destroy_queue;
>   		}
> -
> +		kfd_queue_release_buffers(pdd, &pqn->q->properties);
>   		pqm_clean_queue_resource(pqm, pqn);
>   		uninit_queue(pqn->q);
>   	}
> @@ -579,7 +580,8 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
>   			return -EFAULT;
>   		}
>   
> -		kfd_queue_buffer_put(vm, &pqn->q->properties.ring_bo);
> +		kfd_queue_unreference_buffer(vm, &pqn->q->properties.ring_bo);
> +		kfd_queue_buffer_put(&pqn->q->properties.ring_bo);
>   		amdgpu_bo_unreserve(vm->root.bo);
>   
>   		pqn->q->properties.ring_bo = p->ring_bo;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> index e0a073ae4a49..9ac15dff527f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> @@ -224,16 +224,8 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
>   	return -EINVAL;
>   }
>   
> -void kfd_queue_buffer_put(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
> +void kfd_queue_buffer_put(struct amdgpu_bo **bo)
>   {
> -	if (*bo) {
> -		struct amdgpu_bo_va *bo_va;
> -
> -		bo_va = amdgpu_vm_bo_find(vm, *bo);
> -		if (bo_va)
> -			bo_va->queue_refcount--;
> -	}
> -
>   	amdgpu_bo_unref(bo);

You can remove this function and just call amdgpu_bo_unref directly.


>   }
>   
> @@ -327,6 +319,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   out_err_unreserve:
>   	amdgpu_bo_unreserve(vm->root.bo);
>   out_err_release:
> +	kfd_queue_unreference_buffers(pdd, properties);

While you're cleaning this up, I'd recommend you add a version 
kfd_queue_unref_bo_va_locked that assumes the caller is holding the VM 
reservation and call it before amdgpu_bo_unreserve. That removes one 
potential leak on the error handling code path.

Regards,
   Felix


>   	kfd_queue_release_buffers(pdd, properties);
>   	return err;
>   }
> @@ -334,22 +327,13 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
>   int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
>   {
>   	struct kfd_topology_device *topo_dev;
> -	struct amdgpu_vm *vm;
>   	u32 total_cwsr_size;
> -	int err;
> -
> -	vm = drm_priv_to_vm(pdd->drm_priv);
> -	err = amdgpu_bo_reserve(vm->root.bo, false);
> -	if (err)
> -		return err;
> -
> -	kfd_queue_buffer_put(vm, &properties->wptr_bo);
> -	kfd_queue_buffer_put(vm, &properties->rptr_bo);
> -	kfd_queue_buffer_put(vm, &properties->ring_bo);
> -	kfd_queue_buffer_put(vm, &properties->eop_buf_bo);
> -	kfd_queue_buffer_put(vm, &properties->cwsr_bo);
>   
> -	amdgpu_bo_unreserve(vm->root.bo);
> +	kfd_queue_buffer_put(&properties->wptr_bo);
> +	kfd_queue_buffer_put(&properties->rptr_bo);
> +	kfd_queue_buffer_put(&properties->ring_bo);
> +	kfd_queue_buffer_put(&properties->eop_buf_bo);
> +	kfd_queue_buffer_put(&properties->cwsr_bo);
>   
>   	topo_dev = kfd_topology_device_by_id(pdd->dev->id);
>   	if (!topo_dev)
> @@ -362,6 +346,38 @@ int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_prope
>   	return 0;
>   }
>   
> +void kfd_queue_unreference_buffer(struct amdgpu_vm *vm, struct amdgpu_bo **bo)
> +{
> +	if (*bo) {
> +		struct amdgpu_bo_va *bo_va;
> +
> +		bo_va = amdgpu_vm_bo_find(vm, *bo);
> +		if (bo_va && bo_va->queue_refcount)
> +			bo_va->queue_refcount--;
> +	}
> +}
> +
> +int kfd_queue_unreference_buffers(struct kfd_process_device *pdd,
> +				  struct queue_properties *properties)
> +{
> +	struct amdgpu_vm *vm;
> +	int err;
> +
> +	vm = drm_priv_to_vm(pdd->drm_priv);
> +	err = amdgpu_bo_reserve(vm->root.bo, false);
> +	if (err)
> +		return err;
> +
> +	kfd_queue_unreference_buffer(vm, &properties->wptr_bo);
> +	kfd_queue_unreference_buffer(vm, &properties->rptr_bo);
> +	kfd_queue_unreference_buffer(vm, &properties->ring_bo);
> +	kfd_queue_unreference_buffer(vm, &properties->eop_buf_bo);
> +	kfd_queue_unreference_buffer(vm, &properties->cwsr_bo);
> +
> +	amdgpu_bo_unreserve(vm->root.bo);
> +	return 0;
> +}
> +
>   #define SGPR_SIZE_PER_CU	0x4000
>   #define LDS_SIZE_PER_CU		0x10000
>   #define HWREG_SIZE_PER_CU	0x1000
