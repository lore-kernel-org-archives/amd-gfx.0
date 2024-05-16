Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E8CC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 14:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B0A10ED53;
	Thu, 16 May 2024 14:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a1SX/74/";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9476610ED53
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 14:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTAWZ5xqG+Fb0wvBidg3hluRjc4q8vPXKVs5zuil1O1L9fIiKPvEGyZCdEFHqLAXI7WRN1M7j10jQEHldt85l6BNuJhxHwlyFNQ1ZnpN1akNEL3eIg4x/fcYLE/MX/PNRHv5zBXqgpJXZYeHM6f42CK0Rx1c9Q2qiX/DH7lMdLJ8MWw+aWuxPB9cA7/XxPNEzM4hRxPet3kLyJAzdMXiXNBZizA+xa2D840tXWySJuZiSTWr7TxH7h1Sh4g/+x/7bHLDCwKUFWpAKyaRoSOHYcr+65a3+qwnL7YDDGBnBBgUVE40hQ9ZkhJ4+EgWAFFBDHMprL5VFgjOfgTKthCEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJnNh5tzVxjDuKTTNhodfKyrg0lNdUW9c9BeRLElW18=;
 b=RYjpjEEA39Jb7/Zd/AJyo7qQinphqsbB39ZUSKDifS6PZNIVsLUqb/no+VgEg7oqUeP6HlJOyB/0uWVhjAPmu5it/YTLEl0XBKb78VKFxGjC+VvJsoyHnr+YenIx7cIWcTzrr9FKgo1zX5Dcxug+PTtTHB9N+8GTjzYQj2J8ip1wGjBvQsDInzRX63umgyyH1Z86ADFmdnoFtIM+iaGtLfP6qype/d1dhTgML86y7IOGh0d8Y1L4Zdjk8lqhXZK6gRF7Z9/DyM/ezUliWDP7PyxY8t55TUsuXUaLTmhGaJPJQE9EV/WOfLulo0IQ1BXr6UXQP+YAP+myv21ISAJH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJnNh5tzVxjDuKTTNhodfKyrg0lNdUW9c9BeRLElW18=;
 b=a1SX/74/qbvE2S0S9WVyXEr+Evig7AqVOMKn8gpPiiHNr7kYQf3VCLnRZwZt9P7yfwPHpmC02b1rcvMEQmFAjgg6tu0XOeTQF9ARxIavLQYDOuYONX3CZ+NRgfiEONSBnkLgAxMfFPq1G3mKhakhkkjrBzZORJF/bXgdWkqGeko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 14:53:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 14:53:08 +0000
Message-ID: <a881c5cc-1a95-44c8-afe1-2a2307bcc42f@amd.com>
Date: Thu, 16 May 2024 09:53:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix Kconfig for ISP v2
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>
References: <20240514212815.1259421-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20240514212815.1259421-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:610:119::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b200de-355e-4107-899a-08dc75b7e604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VldqaEl4d0FaMy9Qd1l2c0dOUmlRT01vRGpxUDl0dmNFZXBMSno0QzVnbnFR?=
 =?utf-8?B?L2RvYmZtK0NVZ1IrdUJYY2xWSUhFcDBQNHJHVWVLVWpsRXdaSlM2VE9tT2tP?=
 =?utf-8?B?bU5tZ296YlYrWE9NaGlBNUtEdVFHSHQweVJRZDNrSWpvdTZMdkRSL21ZVjNi?=
 =?utf-8?B?eDRwcG5DOUxoRkFEbnk0ditoaTJ2empucnZZSGRyK0JlVjIraHN4Q0FVSDlF?=
 =?utf-8?B?MGViTm1IQm52OHB4d050ZzRCS3hHMUhoZGU1YngrT1ZGUkhGdzJvMllYZjVN?=
 =?utf-8?B?dUkyQ05yTks0a2lzNTF1THJLS1p2YUw4ZXl3LzViUVRYVUN3akNPZFpmUkVZ?=
 =?utf-8?B?M0pjbEkvREU3YkJOSFczT0U1Q2U1NGxhRTFld1VRNENnc1ZmVTh0NVRyK1hE?=
 =?utf-8?B?bGMxbFNTMksxZm8ySTUxSDVXT2tHTXJzYmlxZlIvKzlTSmlYTmxic1RaS1JY?=
 =?utf-8?B?cFJtSjA5SkkwZzVHclV1M3dhb2NFR3RLeGhSelpCLzg1ZWJaNDg2Tm5vZDVa?=
 =?utf-8?B?ckJuSXJWUEs1SU9XdGlXUzEvMG9CQ2wzNGowV2Q5NG5oeGlub2trU1lmTDFV?=
 =?utf-8?B?d3hmSFpKVGpsSGozS2lWZVhDcGhwNVN4R2VFVUpGeWZpQjV6VnJHSkZjTm1O?=
 =?utf-8?B?OWxkNDFOYTh3RHY4ZGg1V0V5WGxpejRqUWNIR2ZZcVU0QzJjamt5ZjRiQzJX?=
 =?utf-8?B?T0ExV0RvOXI1d1dDVHdtWWZ2U0xhdnA5SkFnd3RXdkRqSWlFVVdmbHk5MUht?=
 =?utf-8?B?aEpzdGN4bjBQZkhvSUFzL2I3WFpubXFIRW1qaXRTeEYzQThCOWxXNEZDbmxE?=
 =?utf-8?B?VnVUMlcvVjdyYWdUYzhad0d5TWVwbXl3OHBHcTJLR1NpS1FHeWp2QzExeTA2?=
 =?utf-8?B?VVF3VXRhb0F0WkFvRVFBeGRLdkljU2F2aXQ0cWwrWjhjOFJ3WUtmdU9jeWpF?=
 =?utf-8?B?U3BJbGcyZHJNQ1FlalR6ZEV3MkhTVzkveC9IVW9NTjlMN0VpWkcrc2RVZExT?=
 =?utf-8?B?LzJnZzZ2L1ZBcnA5YXV4S2JJUjd0OW9VdFRFZU93R24xUlliZzFTYlB2SmZ0?=
 =?utf-8?B?aUUyRXRRblJTdzVnNmgxYmpWK2Z6VSsyUDIzdDFMTUFKL1RxNHNkbjA1NVhZ?=
 =?utf-8?B?M2ZQalEyNEVsUHZjSFh4WDdNeDFWYkRLcHNKZTJBN2VUQWg4Ujc1RDBQdDI3?=
 =?utf-8?B?elR2SFdXK2RuemJDbFBoWE5rVHpTRkJvVjFSNjVYRTFxOSsvYUxrMGVjUlM2?=
 =?utf-8?B?UjRXZGd2U1ZKN1pZQU1mT3NJV1RhYm0ycHN1MThlNlFaZUJjR1NyUDBHV1k0?=
 =?utf-8?B?U2hMbjdMQjVHZ1Y1OGVBZkY3THZ6aTNyNDRnem5LZHgrSEtuWGVCK1A4MTZD?=
 =?utf-8?B?WHB4MDBsOGZRcTlvcnNLVkh6YkVaeXNidVFiSEFiVWtBUDRwV0dhVUliMjJ0?=
 =?utf-8?B?dXFTTm9LRHJrTEpwbnhER3hxbGhrTm1FZC8rMXpnSktNMU5kM1ZTQ2pvb1Bk?=
 =?utf-8?B?TXZWcXFqNGtNcldITk1TN1EwMWpMQ2d0L05PcHRDU2crY05JUEVwQVJDS0Rj?=
 =?utf-8?B?c09SMG15c2NxVW5aVlMzMEtMV0lWc1ovSnZrb3ZLYnFleHZCS3lZak00ZWgr?=
 =?utf-8?B?Um5RSHoySE9VcGUrNDRGZzNZTEl2ZUI4ekxjL0hRcjZlVlNsaEpNd3lvbmNj?=
 =?utf-8?B?cFRXU3VHRzhqTllqU2FINW5sU1J3dEdISW1tSDJ3azRHd2Z3LzJCbE5RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTgxNUFQMnZYNEVETTIyT01aOWRVNzIzVXptTWZnRCtOVG95d2p3M3F1bmVC?=
 =?utf-8?B?OWwzOE10eUo2THhVMUU3Zm9TaTU3cjF3Q0pDN2UzY01TQUYxeE8wVGhHSlYr?=
 =?utf-8?B?bnFNTjdNb3JkTllPeXh5ZXZVWmIwNzBKa294QmRPVncwc3Y2c3hGSmUxSExp?=
 =?utf-8?B?NEY2MWQyQkZueFh2dHZ4blpzV3dMNWxtMHlHWm9CQWY1VlJuakpaYmRPaHRT?=
 =?utf-8?B?aXZqdHZkVDZqRCtrVC8vUUNXd01ldFozSFJnMWRnWVp6YTBkYVpsYVlWeXFj?=
 =?utf-8?B?UUZ1TGZBYjlnd2haZnVHNUJEc1dRY3RVV0xCZ2FjMFRlejJVZ2ExZ09hY0tF?=
 =?utf-8?B?NHlQUmdraDlRWXRaOGNaUkc4SlB0QlpEUDhPWmtBSmpES21pamI4OTRrRThT?=
 =?utf-8?B?TTZUS2h0UUcvWjY3L290eHIxQ0grL3hwK3F1WXYxMzhzYWZYQ1FHVThLNndp?=
 =?utf-8?B?NUw1LzcvZ2hGd0RINW5JMzdsRzhXNjhoQmFiV1dTa21iMjRUbUhLWExNYTJi?=
 =?utf-8?B?RW5XcXB5MjFyVGlPTTNBRUdhNjl0Vm5VQWtZNmdTQ2RjcThOTVgxanVSRVB3?=
 =?utf-8?B?dkZ2VDhGTVowSWNZQ0Y2eGkvaGdiWTZSWTFqL0RoS1hWblFSY3Qwc0liSWVq?=
 =?utf-8?B?QWVNUHNRNWcxRGVmejF2SllneVo1aHhWMEc0eVZlK2Rmdmp1T2FRMHhKL1N2?=
 =?utf-8?B?R3IvaFE1WUJ2UnJZUDdJTnZFR0NsckI2Z1ExNWZHdU5yRWVTby92L1ZnY2h5?=
 =?utf-8?B?dmt0OFh3Wk5WcHpxN0pJcVhNOXlqMElJcThTMEhZQTJyamRlRjM2NThMaE9J?=
 =?utf-8?B?RDNLSVVUQS9rZ3RwTDh6MDFJMWFhakE4NTMxZGpEbWQ1NG5YK0Qvakw2UXJy?=
 =?utf-8?B?OG9wT1BVSU5pSm40MjV4MEdiWVd0MlVxdzhCRStGSms1S09NZlN0VXIxaTQx?=
 =?utf-8?B?RWI2SUdyZTk5L05pTnQ5eGJUR1FtUGo3M0xsaHhvcm90RFdoellDODdBUEVL?=
 =?utf-8?B?UERoQm83MFUxWVk5SnErcXFROEFlSjBCUlB5VTFDSE1qVWszQlRHTW8yUldi?=
 =?utf-8?B?cUh0d3RORHZzZjFJYlpseWpIT3d5WHVSZ0Q0Y2l1RUIyQWhXK2FBcUxLVWJU?=
 =?utf-8?B?TGd3SVdHOEE3eUF6RHJUdmVLWmVsbk0zZll6NWYxaUZvODlsd1k2eCtsODIr?=
 =?utf-8?B?TlpKTGVZdUsxK2p3bmkrZ3pJQVlpVXE3WXY3UjBiOEw5Rk1DYU1yZ2JpTGJ6?=
 =?utf-8?B?ZUhNSDZhdVNaWDFXWlZHdFMyaCszRFN4MFEzamlSamhuUS9CY3JjUkIwWEhT?=
 =?utf-8?B?NUowcjIwV0ZWckFNaENtTDd3aTUwU00zc1lFSHNQRzl3OFF5WTRvTk9TSEU0?=
 =?utf-8?B?dzVqcE5sVENJUE1ScENybUtac2p4TFdNMjVNTXRIWGlHakwzZUtYbTQ2eUpE?=
 =?utf-8?B?ZWpmQ3JMNUZwNFI2cHI2cFd2dmpRSitzZGtUSFBFWDJlY3p4RkpUS012T2I2?=
 =?utf-8?B?R0FOM1dzZllUMHVFUXp3RjVkL2luUjlzUUh4M0x0alRxRkJQbTR1eEdOWjB1?=
 =?utf-8?B?SGkrWVY0cnFUcjVXQ29UV1B2bC9sa3VyS0NGT00vd2xaRHJIRy9WWEFSSEFQ?=
 =?utf-8?B?cDJHWk5FSHNtaFVaOGJPS3NIcjNUMjBQcDJkWm5YL1YwZmdkaEp1K2xtRXRr?=
 =?utf-8?B?YVVabWlFUkRveVp1OExDRnRnOFQ4T3poMklmalF5Vkl6UFVEeUg1V1JINVpV?=
 =?utf-8?B?cTQ4aDhvWHJRVjJ4cmFBejRCSHFCNk5JallHVUh6MVI1MU8vdTZLTmpHMGhi?=
 =?utf-8?B?R0dtd1kzYmplcU5hSytxM0w3aWpBV1ZIWEJ4K3pIWStWMUlRU2xBSHFvWVVS?=
 =?utf-8?B?aEdDNk9DZWdSK2tBRzFyZVNvbnExMk5qcENyM0J6QkpCZjNjT1llb0RGalFL?=
 =?utf-8?B?NVBCeVkwckVmbWpId0M0WkpiaFJWNlhSaTF0S3pGWEtlRGZxQjk0K2pBVEpn?=
 =?utf-8?B?bFU0T1poeGloODVlc1QzMFB6bzJUbFdsMWh4MEJGaXMycHlrS0I0QmZ2WGlM?=
 =?utf-8?B?Kzg3M3djMUNnZGxZMDA5NkRBeUd2MUMrc2pBTi9LUVdXbFN4WUt6ZWJkZXZI?=
 =?utf-8?Q?Yc1gvzH4KHHcQV/GcAZVqj5Wb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b200de-355e-4107-899a-08dc75b7e604
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 14:53:08.0246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wt03BKLlyjCU093x9tDpPymgoMkC1AmStkzhEjgmNyi6zpRJ/WdcTN9uE7qR3YEj3o5i63WXCNw1E/glCc3WUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
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



On 5/14/2024 4:28 PM, Alex Deucher wrote:
> Add new config option and set proper dependencies for ISP.
> 
> v2: add missed guards, drop separate Kconfig
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I have one optional remark regarding headers, but otherwise it looks 
fine by me.  Feel free to ignore it or squash it in while committing.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> Cc: Pratap Nirujogi <pratap.nirujogi@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig            | 11 +++++++++++
>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  4 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++++++
>   4 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 22d88f8ef5279..0cd9d29394072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -70,6 +70,17 @@ config DRM_AMDGPU_USERPTR
>   	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>   	  isn't already selected to enabled full userptr support.
>   
> +config DRM_AMD_ISP
> +	bool "Enable AMD Image Signal Processor IP support"
> +	depends on DRM_AMDGPU
> +	select MFD_CORE
> +	select PM_GENERIC_DOMAINS if PM
> +	help
> +	Choose this option to enable ISP IP support for AMD SOCs.
> +	This adds the ISP (Image Signal Processor) IP driver and wires
> +	it up into the amdgpu driver.  It is required for cameras
> +	on APUs which utilize mipi cameras.
> +
>   config DRM_AMDGPU_WERROR
>   	bool "Force the compiler to throw an error instead of a warning when compiling"
>   	depends on DRM_AMDGPU
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 12ba76025cb7c..c95ec19a38264 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -325,6 +325,8 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
>   endif
>   
>   # add isp block
> +ifneq ($(CONFIG_DRM_AMD_ISP),)
>   amdgpu-y += amdgpu_isp.o
> +endif
>   
>   obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 846c3550fbda8..936ed3c10c884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -113,7 +113,9 @@
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
>   #include "amdgpu_umsch_mm.h"
> +#if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
> +#endif
>   
>   #define MAX_GPU_INSTANCE		64
>   
> @@ -1049,8 +1051,10 @@ struct amdgpu_device {
>   	/* display related functionality */
>   	struct amdgpu_display_manager dm;
>   
> +#if defined(CONFIG_DRM_AMD_ISP)
>   	/* isp */
>   	struct amdgpu_isp		isp;
> +#endif
>   
>   	/* mes */
>   	bool                            enable_mes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 378d5a5cda917..1bab8dd37d621 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -107,7 +107,9 @@
>   #include "jpeg_v5_0_0.h"
>   
>   #include "amdgpu_vpe.h"
> +#if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
> +#endif

IMO including this header is probably relatively safe no matter if you 
have ISP enabled or not, no?

>   
>   #define FIRMWARE_IP_DISCOVERY "amdgpu/ip_discovery.bin"
>   MODULE_FIRMWARE(FIRMWARE_IP_DISCOVERY);
> @@ -712,10 +714,12 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
>   			adev->sdma.sdma_mask &=
>   				~(1U << harvest_info->list[i].number_instance);
>   			break;
> +#if defined(CONFIG_DRM_AMD_ISP)
>   		case ISP_HWID:
>   			adev->isp.harvest_config |=
>   				~(1U << harvest_info->list[i].number_instance);
>   			break;
> +#endif
>   		default:
>   			break;
>   		}
> @@ -2402,6 +2406,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
>   
>   static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
>   {
> +#if defined(CONFIG_DRM_AMD_ISP)
>   	switch (amdgpu_ip_version(adev, ISP_HWIP, 0)) {
>   	case IP_VERSION(4, 1, 0):
>   	case IP_VERSION(4, 1, 1):
> @@ -2410,6 +2415,7 @@ static int amdgpu_discovery_set_isp_ip_blocks(struct amdgpu_device *adev)
>   	default:
>   		break;
>   	}
> +#endif
>   
>   	return 0;
>   }
