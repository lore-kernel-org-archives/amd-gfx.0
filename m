Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D47CF2568
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 01:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841A10E216;
	Wed, 19 Nov 2025 01:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ScZ9ekQ4";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E343710E216
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 01:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKZuGpzCgoOnFvvIH8QxheI++HGO3+ZC0gbUHPsgny9rigQK+WEYhrr0frQaInxSKnDrczlUfPrXprf1eZu740DnRn1qeoUIMqRcRR/24EhPSI7wOkRVl2Ie0bu00d0rVNQHZrKxV68chNWPFrmE+LZ1d6U+Z9sVRaA6iu8wpQIm5YjqzuAr4IBzEqxnIgYND2MLGouBKd+wZpcZxQP9z6Ne6n0EkrLshvbU0TNIJQb1ZxxV8g3xGQLnRX07tleL9ienQAs0pWxhqLIqMjQWNLyduCo5hTw0mJwUrR5D+miyuPtVbEztUBPpi+JM+BZicahSQNOdnV0JUBp+9s/Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjeV2pPvyK/AolpQ0AW1LR2GTTacV68PlLfFgSRH0Yc=;
 b=SzG0qzdkMVMmEbrgZjslXj1jrztAla1Xq58qmEuy7Sm3a/k/mgA0unl/6xSxvwulrPbcgdg8YE8PqDw2ufZ2Vmfxxj/uDFFkygGvGcNC6uUxaKlqBJ5+1j85VGRuHKRj8JrNE3tvIAT+ZtQM4dSqeAJKhZKq0arJP6KYC9EUdWPuhSTaxg3BS0QRA8NwhL/GQfGpbpVRHmCzF+fWkQgDA+2mH1Ya4+3Ig4XWaJlz4HQ8jnY7xJNWTl3GmQq0CC4I1/mLNwhlEZjK8azfh1h8DtoVwWwSdv6cB4guZx3l8FUvi247KjEQTPrEL/L/atEkJZtn7R+ta9dIcTtW3A+F1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjeV2pPvyK/AolpQ0AW1LR2GTTacV68PlLfFgSRH0Yc=;
 b=ScZ9ekQ4WFk0c+WZ0qxAcqnf6C25ur2Dlo/AwLjYdKJAuL27kxPLFXk9R5vxNKsTI79yhQ0YviU03WIFFe52lFyvMCVVmECfX1EX3wvkQL324unvE/r2Ud6Hi9W5eBJP7+MHbUlQ3jS9/uIL+9ynef9TG+ee36GwwUfaRX1+O3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 01:48:57 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 01:48:57 +0000
Message-ID: <6d1e9dda-2209-4cbc-87d1-cdb38b382b7a@amd.com>
Date: Tue, 18 Nov 2025 18:48:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amd/display: Fix warning for analog stream
 encoders
To: Kees Cook <kees@kernel.org>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Ray.Wu@amd.com, Harry.Wentland@amd.com,
 Wenjing.Liu@amd.com, Chris.Park@amd.com, Yu.Wang4@amd.com
References: <20251113163348.137315-1-timur.kristof@gmail.com>
 <20251113163348.137315-2-timur.kristof@gmail.com>
 <202511171214.FAFD75DD0@keescook>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <202511171214.FAFD75DD0@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0330.namprd03.prod.outlook.com
 (2603:10b6:303:dd::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ff3b75-453a-4b7b-8f87-08de270dcdae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0psOTJyQ2YxTERNbHZlQjZhNys0MUZ4SkFuL0dYM0ZTa0YwUVZjV2xNUHkz?=
 =?utf-8?B?TDZGQkZZT1ZRdGpTSVlOdnhXMHd6UHZFNjA0Z2ZTWnQvMnJkZlNIemVEUC9t?=
 =?utf-8?B?MGt6NjhCR2ZFUU5zOUMzREU2OFdUUzJ2NFFUekxocHlvT2ZLYTFnSGlTYWdj?=
 =?utf-8?B?WVRHNGhSd213Y0JpQUk5N2xEZnNneFdETGsvdWdHN05CcUUvalVQdVMvZXk5?=
 =?utf-8?B?YUdZL2x5VDQ2SGJFUC9YN1JIckhSQnF0N0Jrdkc2U1Z3UWZ4TXVOK0JmMFB0?=
 =?utf-8?B?cklVWlluTSs1aGdVVEdpSXRzbXV5V2FSYzNzc0dYbDJDSGcwSXllNndBb3JU?=
 =?utf-8?B?VERWNzNPSDNxTXdDYzRKSDRnVVdNUURMQ05vclZ1aWc1aHFMd1RjTWZsVitL?=
 =?utf-8?B?SWF0bE1aSHd6UjF4UWtuaEZaSm1xbExxOFBuWVFrVkxUUWpzSE5zYmxnMlB5?=
 =?utf-8?B?YUZJUkZDV2ZjVFVQNzExblhiNlU0bEpMZkdNcEFsZUlHcXBmaUJGWUxUVkg5?=
 =?utf-8?B?Nk1nZEVrZVJFaFpJY0pIYitmclJFSzlPajNBOVBZMFYycWQ4WUFaZ1YyeUlj?=
 =?utf-8?B?eHpMbWRGNlIyOEthU0VxNVoxLzZJNmV5RTRjWXFkRGR2RTUvQTc3bG9BMWZQ?=
 =?utf-8?B?MDJGbVZZSEl3Nk90VzFmdE9lZDVUc1kzRFU2QmZkTWJGYnJhTlFuUmUzcklp?=
 =?utf-8?B?Q3FLM3VSaWJzWlpkeDdjNVMrZUpkL3cvTUVaamdYa0pvUW1xRlM0dGhxRExL?=
 =?utf-8?B?RXNYMEZrV3hKdk9wWW1LVlN5SnJzQkZ3NCtBTXQrM3E4N1YxRVdrVHVNUU9M?=
 =?utf-8?B?VUNvWDNYT0l2Snd4MUVJZ0pnKzdaZzBMTndpMUMySTZhOWF2d2ZuaGY1bzRN?=
 =?utf-8?B?ek9jS1I5eTNWQzREbkRhTHV6a1BpVFd2L2lEZDJmTUIrNTEzQ1Y0TTFibDl2?=
 =?utf-8?B?dkVMZThmMUthdHR6dWdWbnBVcVBBbE9YNGdVS2htVjAxVEJFRTJHRDBBL3JL?=
 =?utf-8?B?azFpbUZCZDMzSC9WbjFJNTI3QkJ2R2NySUF2OW80TmVPZHdWcDBUVXdNZzJZ?=
 =?utf-8?B?YUkvWWZpdmNCT3pLNnhZTDVzVUo3TEcwYWFKYnYvdk84K3FhVlFpUUdNVnBq?=
 =?utf-8?B?ZzJ3ZXcrK3VDRFdUb2JjU1Fialg5eXJ3YnU4ZVVPMGJQWGJsQWptVDhtRHBI?=
 =?utf-8?B?T0NCaFpqL0dINmx5NXEzRCt5SlYvQ2lRNjFQQTVjRS85ckc4K2U0RHIxb2ht?=
 =?utf-8?B?ZUVBaFJFVXp1VnpqWmlnbW1ib1YyT3Z0R3hKTXVmSVdKZ1JpUG5MeXdrTk0w?=
 =?utf-8?B?ekRYZXh2NjhFZ1gyZFh3WVhLa0FxRnljdlN4UHNSRkxjTUQwVGw1aGd1ZGc3?=
 =?utf-8?B?S3pDWkxNMkQwOGlNYlgxbHBnSDNNVGFpSWozNjFpSTJhTEM5OWY3dFpOWWtv?=
 =?utf-8?B?OEhxSERGUzY2YTY2cldUUUdyYVU0bXloY0hkeVpTOUNwRkZmbFJZNG1COUdu?=
 =?utf-8?B?QTB0WkhYL3BMc1hYUVNKUDE1eXhWVElwQi9CWm1yelZNN0hGM3ppTHhxQW5W?=
 =?utf-8?B?RlhENkl1ZDNXOTNXckFQUU1EcnphNzVKZjVudDV2Yk8yVnVmbG5ENGNtUzFq?=
 =?utf-8?B?b0FKSVFoaWE4dzhjZEFHVVRjcXA0QnFkcHEyRDF6L1RBWFJXem5ucUVsclpE?=
 =?utf-8?B?d2V4V3JYdVA0VUlJYUUzWURVL29OZTZQSThiSis1bTlOWUQvOEZRTHVOTmgx?=
 =?utf-8?B?b1pKNm9IcmMrcTFwT1ZQSjRWOHhmS0dncy81LzZkaEY5STM1L1MrR2VrK092?=
 =?utf-8?B?cy9zbXVWUWVnK0ZyUzNlQ2tvR3IxSlUzNHNYcEZNOVdkNUVTekNvNUNtdzdz?=
 =?utf-8?B?d3BMaldWK0g4YjBrYWtsZVhvQmpjSGF2dDVDeXF4dzA3YU9GNVRKVG05cDdN?=
 =?utf-8?Q?IUV0zFblAGTNJLMeCDv9CpRS3groIDJe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dStjUGdoMm5zSkJYVWpWS2VwdHdSRWwwVzBJMStLUmJzYXpxYlVBM0M0VWxq?=
 =?utf-8?B?a3B3MWZpck85eEZBQTBDelZiWkQ3RlFFZThvOGtlNmRjQW4xYUk4S0c5VGkw?=
 =?utf-8?B?RzdKUUsvZ0UrRVVOWnNXNE82Zmh5eCtxYnVDbS9NUnQ2cUNqd0JzRkwveXhr?=
 =?utf-8?B?ZTNsZnRRaFRmV3UwUmZPSmYxVzgvcDgxZ3B5L2tDZmFzRXh4V09BVmZJMCt2?=
 =?utf-8?B?MTh5OWZjdFI1ZGJGUk1oSWFRS0JhM2Nrb1Y0d0Y5OFdsc0drQzZQNHpMNjlD?=
 =?utf-8?B?YytXZVViclpMYTBlVHkyTk5nVDBUYVFrbCtnam52Qy9heTg2VWZkdzB3UG8r?=
 =?utf-8?B?c2dOQ2tMVFpEa29CZGJ3bGhWb3B3dE42a1pFblhGcnVBOXJxeEx4ZHZkS1Jh?=
 =?utf-8?B?UUExNFpuR2FWMkpHNHBERmdGMUE1K3BUL1JDKzk3UnB0MmlrK0pSYjRRUnhs?=
 =?utf-8?B?NUdRMitXR2NFL2FvL25IOUsrLzJhTVkwWDVTT0kydmtGdTMyVlV2SHUweGdC?=
 =?utf-8?B?d3BpSFEvSGY1UnhEbHRzaGs0dnh0ei9pZzRxSVJpU1N1cm9zTzlQSXphN1gv?=
 =?utf-8?B?bGtSRDg4OHduTFBSekJjZmRjZmczNkU3THhISUsxaHVQNFVHMUQ5UVNTalpV?=
 =?utf-8?B?bm5EMlk5OVk4K2pYRGVtSzZVK0g5SFNWTG05eVowVEV1M2wwMW4xRE9qS1Vo?=
 =?utf-8?B?aHpSSGNGQkJxYzRPd0p3OVdncjQ4YWZXZ2xodFZvTGorQ0k4MzZYcFVmODNN?=
 =?utf-8?B?NG0zaWtJL2hOazZYY3lOWWFpOG0wYVdJVFNmMDVZbXI3OWgzYmhoNFNTUHNz?=
 =?utf-8?B?RWtoNVhMam5Ndm9MK3plQmhJY3VpQWVWMlB1V2ZCY1daSlozVmZSb1I5RmNt?=
 =?utf-8?B?aTNNVllTVHZTcmpRZitVaGdweThURVU0Yzd3SjNxM2hxTnlKNWs2MjVjbVJn?=
 =?utf-8?B?UlFCaEQ0ZDFMc0lyelVjVjA3ZklwZUZMYVNoNzhWNVZ0dlM1TUR1THM0ZWVq?=
 =?utf-8?B?UldEd0Rvd1dSTUk4TENNYlZXTTQ0ekdTSjlXNktyK1JkRncyVUp2bjVNZzY4?=
 =?utf-8?B?SVZlVW13Wk1iUDJCbmQzdWdPWWgxUU9vODBtUlEzdDE4cEpPS0RjSUxDdk82?=
 =?utf-8?B?L3lZeUtkSEMraFpET2cvWSt2UHVlbnJjZ0ErSEpRVmMrSmZhL2Q3S0JHYzNP?=
 =?utf-8?B?bUtWZkxFQWIwcmJiVTJQaWZYNld0ckIrcjErenEyVnBjVVNwMXJkb21XcGRX?=
 =?utf-8?B?YTJHYmo4SzFDdE4xdkduWTJQOVZkSUpqYjVKdGMwSnU5V3p3eTdyb09vRDlR?=
 =?utf-8?B?SSs0b2RpMWNNZ1orNEw2c1hIODVhTVR2S3NJb2c1TDEzQldtQ1loNDVOeWRx?=
 =?utf-8?B?SEhQZHVxK1JWVEpkY25PWDVqdk9GL29hWS9ZWnQ5WlFBa3N1L3YrMmErdnk2?=
 =?utf-8?B?cWRLYm9CRC8wZlFDUzlwTmk1dFZCK2pSMGhINHd2SWYwWVB0YWFRYS9KVHlK?=
 =?utf-8?B?ZXozelp3YmgzZkNwZnF6b21mUWFsVnV2YU5vTytEK09VcnJyU2srNGNXUGNw?=
 =?utf-8?B?V0ttRFI5U1JhMVpyMXltWHJSMHNFdDg2VTJTR1hOSlE3ZmJIcjduRzFRdngz?=
 =?utf-8?B?aU05MlFuUW45WTcvZC9Fd2F5WGtFUUZ4V2w4ck1taXdhOW1ocVhYcmE4TUpP?=
 =?utf-8?B?RWpYczFPTUlPdk0wWmZVOE51a3ErWHpJZXBFNCtTbHo4YUwwUnRzWjhsQ1Yr?=
 =?utf-8?B?MmJTSHNlVFJUdENYSlp4c2ExQ01xTzhqdk0xWkpiZjFSWUQvYUR3MnFDb3lr?=
 =?utf-8?B?MmhnU3N0N3RlSS9PZ1VONXUxNCtCTUVqRTRPK01MbFgyRnI0RjhWd3pIaEZL?=
 =?utf-8?B?dDdvMFR1ZTB3RTl5WDdzajUzelRLdmw1TTZQQld6T3MwdVk0ZFU1OE9YK0hX?=
 =?utf-8?B?bmY4ZUVKM0IwZmFuMUdDZWpmYmd4a0R2Kys4ZG9wWmdWdXZhc2tWTmdqUGll?=
 =?utf-8?B?MlNEQ0Z2MDhWVGJsS3pCa1NIMzd2Rjk1TDVZLzM1MG16OUFDWC9yMVVobWtB?=
 =?utf-8?B?eVI1ZTRMKzZPekF3ZGdYT3RzUDQ3U01sa3pnZVRocXVZa3pValBJZDI1cGVp?=
 =?utf-8?Q?DAFtwM+IbV3MyBBnM+UXtU0RE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ff3b75-453a-4b7b-8f87-08de270dcdae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 01:48:57.3954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB8Epg0YTsw7MxNZMGPuuxdwO3a7sfDhpIZhWHMQSPkXeLhM5zM2pgP2MJmmbWd3Fq6jM9NosqH1PEkrp1iUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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



On 11/17/25 13:16, Kees Cook wrote:
> On Thu, Nov 13, 2025 at 05:33:45PM +0100, Timur Kristóf wrote:
>> Fixes the following warning that some users are reporting
>> with some kernel configurations:
>>
>> "positional initialization of field in 'struct' declared
>> with 'designated_init' attribute"
> 
> Yes, seen with CONFIG_RANDSTRUCT=y
> 
> Thanks for the fix!
> 
>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> 
> Acked-by: Kees Cook <kees@kernel.org>
> 

Thanks and this patch is now merged to amd-staging-drm-next, but I found 
it causes *some* compiler to fail.

I'd like to test whether the below change is able to fix both issues.

-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {
+       .dp_set_stream_attribute = NULL,
+};

However, I could not reproduce ""positional initialization of field in 
'struct' declared 'designated_init' attribute" in my local setup, with 
either gcc or clang and "CONFIG_RANDSTRUCT=y"

Can someone try the above changes for me? really appreciate it. I will 
create a patch if it works.

Alex Hung
