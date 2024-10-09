Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260E9CEDD87
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 12:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B3D10E25E;
	Wed,  9 Oct 2024 12:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MEuiyu2U";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C6E10E25E
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 12:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lv0ksPZNoZwvJfPpOyMn7bLNdVfpHhtWv7m3ckhEzFXeICzVQYWZqpqfTOfHFfEA0z8QqvqgpBlRXClF0CnXvP0iw2HT7KcqWaN0M6a8LSqKRz9eKkSOKfs3UdxZ1sO95w1w3SWdQJcWKg4PHqvEwZFdgfBwWiiTcV73VNCNsd7ajX8F0a17tAzL9/YH35c0hgrjXZYXqCVS/OQjKJE3Gnum8+UhSl7gJqzMH43hM4GSBhY+ggCeXg5bU58uPkUVqlcvrqFc/4SXoqlCK7TKVcX/sNpI/MJbJvFr2QLYFmoQzgmc6MwH0UvkrXPjdjie0ieDgPJwJDnHApMrEE38qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23qwRYDU9Zu3ZxaI/XSoQmbz2rFxTVV1dO6+PG6v55c=;
 b=ylCgRNoLmSq4xIjRbppXpNkwjcveV4WlnNF4JXXCVUTW8IHb1idKl6hC2f8Nwy1v4y5pvWbDBxBAQQZapAi+VL/vXoHg9iV+alhSWAzMmu5JpBio0Qwu+HOAtMStWLTlOzYY+5xup1+f/QG+4W6w2aBiYptdp71zmmNdq9hONDn9ASzKkQtHgfF3JEbcw4S2iC4bryEtfK3OXW3sBn/U6jOq1x9ukaMkIGqsWHKpRWEWrz1w5kTgKaYDUAJp4ZnsmmVODw8U+2d2uA2YhiqUsW0H7uyDMDZi930Z1g8TxqbuoGHz7QFTy6J/s4jR3mIL+xJKraNkdp+2s8OPnpFR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23qwRYDU9Zu3ZxaI/XSoQmbz2rFxTVV1dO6+PG6v55c=;
 b=MEuiyu2U6EurIc+y4RS1DGanwyFZ6GvgcvDxbLhYulLdLfe9s6nZ2YvoLLO/1so+XqUOb40sZfRFr04U6kA7evo917G5yZ7drG8fwT+H2cd4KfoJfh2ZlK6ZBElEAT7A0gjvc6EeYs+SM76xkZBw1Kq5/n8vHZ/xEXAf/GJ+Mu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 12:00:25 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 12:00:25 +0000
Subject: Re: [PATCH 2/2] drm/admgpu: clean the dummy sw_init functions
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009084823.828235-1-sunil.khatri@amd.com>
 <20241009084823.828235-2-sunil.khatri@amd.com>
 <0b9ad760-6996-4178-a974-d0b391d00a62@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <50324f72-f39f-87da-2a2c-a731211a22f7@amd.com>
Date: Wed, 9 Oct 2024 17:30:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <0b9ad760-6996-4178-a974-d0b391d00a62@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::7) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edd9d1d-8eab-433a-07a4-08dce859f56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHI5czAzUFJuNXloRkdOaDFDNmVzdzk0Mk9UQlpQY2dQejBtVnV3L2Y3dWtP?=
 =?utf-8?B?S1NyclhZRW9hVlo5VE5jTmFSdElnRDd3Y1BzY0ovM2ZTMDBwVXVtYlZvS2du?=
 =?utf-8?B?d252WWlCZHlkaFErR0FxakRLZlZQdkRGanlzRTBaZXZyME9uUVE2NGNNN0VT?=
 =?utf-8?B?MW41a0NvNXkwNzgxOUdNUWxUZ2FVeDZnWk5ZNDVUMkhDYUFZcmcvT3ZxRTY3?=
 =?utf-8?B?ZVhVelg5UGN1c2dhSnAvL1FQcCtwWWlWY2pITWhaN3RKQkpjREtnMDJDTStZ?=
 =?utf-8?B?ZDRCZ3UwL2pjVjk1b2plYWZoWlZZNVRndEJFOVJVUnpVTm9iaTJyVy8vT3Fk?=
 =?utf-8?B?RGxySTJrazVob2FHOXE5R2dMUXl2ZkFUU21iaDUwWU9IUlk3NDdZQUtTRU1q?=
 =?utf-8?B?ZFpCL0F3dlJnWGJzZEVWR0pURGttVW85RnpibnlEVjRHMnhrbURQTnMva0I5?=
 =?utf-8?B?ZjdWK2ZQQnYwRVVwNHFLSC9ObDRFWkltcHlOQytBR0p2eXFkc1hNYVZma05p?=
 =?utf-8?B?VmtucmErZ1lVcTAvakFzR2VpKy9WcTlNQndiald0MnIwTWUrVHZYSHVWK2ll?=
 =?utf-8?B?YmltU0JuRFVYWE5vQjlvNzl5eWVQVkxQSEkyd0ozVEk3RC9oZGRMcGsxdEww?=
 =?utf-8?B?SFp4dlZhekJYcVRyL3pQUk5xNmNvejBKSHNJTHJEU0RYSkFkM3NidVhIRVgx?=
 =?utf-8?B?dHZzY2tuejNFczhZVk1qbG1lN2g0dEpKSS8wMTRGcGVpd1J3Y0lPYlEwRVlX?=
 =?utf-8?B?S1V2VFlNbjRyRTFkeDlqdDJBQTYxRkV6aWRUcGZMUVhOa25EdU9IQ21FdmFy?=
 =?utf-8?B?U1FRQkgyK2traWlaV0VFRUNTTWhOa2ZUZXljbEFnbEVvdUhWQXJncHZiNU5j?=
 =?utf-8?B?MGJYMjRpRllNLzlOOVZNc29tTzczd2NyTzFlN1lHUDNCbGVqTllEcWQwMXJa?=
 =?utf-8?B?TXRkK2JEazR6RUsvNmpYaUpPNDNHRGtHVEhPbmkyS1I2cHBtQ282K1hmdHlF?=
 =?utf-8?B?Zy8zSnJwOThRL0hMVEtNRGFlUHRpTDd2c1pjMVdBWWFoV2JmSGhqbkh1Umt5?=
 =?utf-8?B?OEZDSjR4S1pwOUdjSlFTOFFPbllGWlJlUnVtS3hYMUlnRWU5dWZ6RDJZSmMx?=
 =?utf-8?B?VTdQTDFJczV4b0xncEYzVUFnV09iM09qVDR3ZFJTRzBaaiswMWZONWFVODdI?=
 =?utf-8?B?dW4vaGZzNHZOeHY2Q3h6aDdRM3llQVA5ZnJuMDVxb3Uvc2FacmJtcEZVdXJa?=
 =?utf-8?B?d0hZQTUwTGhuZm53emxGcWhYb0FoejBxczAxMU5IL0FDaEtsMk9wYUtEZVl6?=
 =?utf-8?B?Nnh3RXEyR3RmZVlSTnRGVnVKdG45UWVsTENQNWoxeWtQeklvYW8xWlV2aG1x?=
 =?utf-8?B?RTBIMzc5aWRka3dqZjJ3TmJzdG9DUGVmVnpVMXZqdCtnaWE3cFB0OU1aSTgv?=
 =?utf-8?B?MUVjWUV5UHoxNEU2a253MURQdzZwenNyTzBuSWRwVVhMMHNCY1lUb0RydU53?=
 =?utf-8?B?Q3hxQ2lPQlAreEZ4a2l0VGxJQyt3c1dXdnB6ejFuQkc3cjRFMDZFZC9yMmFW?=
 =?utf-8?B?Y1JsYzd2WGJCT042OUxSMWdjd3NJdkx3bkZjYTJkdXQzVHlhS1ZCZGdOaHg0?=
 =?utf-8?B?aDJPRzJ6N1NMamsvWEtEWGh4SFA1MWFpNXM1aVFpVkk4OVlJRklBWVRCdVU0?=
 =?utf-8?B?bkU3RlFyZ0d0S29jNkJyR05iNUQzZHFwVjJYYnFyeFZyMFB5Z3JjaTNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVBibGY3NzBJamFWQVY3TEhHMmZqZTNvZDhRRExhMDY2dlg2a0ZLYlh6Q2c2?=
 =?utf-8?B?UFl2ZXpQNGxQYi80Q2d5WndIeUx5VVB6RmtVck5SRFJ1Y21zMFNpYXRpTlVF?=
 =?utf-8?B?VlhRdTVEejdpcUIrbGFEM0RJU3d5R2s5cHBoMDcvVU1pc1ZRcjJGQ3BkbHZq?=
 =?utf-8?B?ZmorUTE3b0pqRUJ0VFJyMkl1K1QzNzIrZWxBUUd4b0YxTHk4QVNVR2E3VzR6?=
 =?utf-8?B?cnY5V1dNdlVkSlFxbWVuZkg0YWVvV0lZZU45VHM3b0RUUGxyMm0vcUQwUktZ?=
 =?utf-8?B?aVVBLzZ1MzlUVGNMZTJLOG4yUXEyM0tyN3Z0WDRHZWtpUW5kWEQ0SThEZFVS?=
 =?utf-8?B?WlFIUlg0S2JVaDVFRm5mbWlpcmNDQ0FCVnk3aDEyNzlwUlhqRHdsbHpoRjI3?=
 =?utf-8?B?cTFxQXoxZ3oxclozRDBXeEpMc3dwZ0ZOTngyUXpkY2NaYk1nNU92TU0vMytk?=
 =?utf-8?B?Rmo3c2orVDVHTWtPaEE0TkI4TVY5Z0RBRkpHeTBTVTZpR1FwZER1enlodXE0?=
 =?utf-8?B?c1YvcGZDNkl2WVJCYjhqNEt1R3VMQWVUekN2SWtLNGhDS2FBSXlZQ2pqRE1v?=
 =?utf-8?B?WGczdEYzNW1tQzIvaWdyN2ZNK2lCR0x6WUFCRlEwcFlXR0lIYTNEQkRWek5L?=
 =?utf-8?B?b0plTXNiZ3czV3hLL0FYbFY0aW8yWkYxVG9oR0RLSUlQb0llbHFlenE3VHJt?=
 =?utf-8?B?VFUrZkZlaGxGSDZkQ2lJYXVoZkw5d2t4Y29QMlQ4YkJLd3Z2WXZ4aGFRYnFX?=
 =?utf-8?B?UTRJL3BhWXBKOVU5UHUxSVFhQnBLOUFXcTZyWVMrYmx0M2YwYWJ5eG5mUTUx?=
 =?utf-8?B?QUtKRmNKYzRFcGNLbDhYdFNEZ3I5b05RRW0xTDloL0QvbDJkeWVKQVZlSUdO?=
 =?utf-8?B?SDcxRGlQMlk5UXg3TkxqdlNaSHp0Uk5kWnNBUlV1S25adFE2dVNFejBlQ21k?=
 =?utf-8?B?OTd2bElzRHd6TzVnSFFINzE3cGRvbTVCUmpVR2xROHpOTi9kbm5TeWtIZFZq?=
 =?utf-8?B?bGkvSkdxMFFyWVNMRFA4T0phd3pJdFhrOUh5MjFNNFY1VnZrNTVoTkFsY0xQ?=
 =?utf-8?B?TFFuTjRyVi9idXcxRERTaG1PM2Z6d3VVR0Q0eEJLazM0REV1WlZvd0xhTytw?=
 =?utf-8?B?MWVySTNPTVBjK09leDJWdVhlSWpSNk1hUVhuZFRmemJrS0dFcTkzTHpZaGxI?=
 =?utf-8?B?Z0JKM0EzTXlldVRQSjhYL0FoL3pNUXVLbFJFaXlWMWNUNFJIb0ZRZytZVGJS?=
 =?utf-8?B?aGVBamMxZkxNN0l6dzYxMnJkclEzUGdhNVd0VkR4NTJxeWg1d0wwUFR2dk1Y?=
 =?utf-8?B?R0lud0FvVFZ5Q3lpV251QW1YWXhrRnBvNkRpMkxCLzJ6anBKRkFkcVZiNEdW?=
 =?utf-8?B?SW8yWStrUlJEbDVFcFJhMnV6TTVGUkN2T1I0VU8wQm0zaXo5S3JVMTNGd2E3?=
 =?utf-8?B?bVFlWm4weEU0a2dQbU01eTNWRFdCV1hoa0llZUtPSUVkb1dzZzEwQm0xU2tx?=
 =?utf-8?B?US9VM0drRkVUWXpwTEUwcG1tZmt0N3gxZjEzYlBLLzVWVmZzN1F2OStaNzVY?=
 =?utf-8?B?UkZsQ2hoaUVEak1nYVNyS3hmWkEwM1A2R0ExMWM5TWQvYTFzdVpVUUVEOG16?=
 =?utf-8?B?RjE0TUV5cUhqdmYvaldrVVhPdkY0b25OWlB2SlgvcTdrVTNtUlUvbVpxOHY5?=
 =?utf-8?B?enV2Y3JYWk9pWVlsZVdweENzY2V4Nk5wQzlRbFhoQk00Qmx5QWZkQys3bXVz?=
 =?utf-8?B?VVk1cUFKZlpXcExhbTE0T3pjdlM2NGRtbGFtNEtYdEtKRmtCMmoxajMyQ1Zl?=
 =?utf-8?B?cUx6eEFnem1wNUwzVmFyNzNaajU0Tk5sYUc3VnpmSFN5TWJlclYxRW5ibEZ2?=
 =?utf-8?B?dmFBNVdweG5vSjJSZHRRQURtL09PMXFLdkMraEhvMFNzdmxJSGROOWExNmIw?=
 =?utf-8?B?THdwMkluYU9hQloxRzMydEp5TVRHQmpHMFVxMGFSdVZFVGtjTFNaMFFaS3pM?=
 =?utf-8?B?LzM0SDhialluSTA5MlY3cUYybXRKQXFndjQ2U2xEQ3JrdHU0NzU5bDJUZHJP?=
 =?utf-8?B?eThFYzNBdzhBUlJCd2M2WWgvQWxIdFd0ZFBMRW96empRZWM1MXRpaFJsaTZ0?=
 =?utf-8?Q?jzWy5f6xgXy3brhIDfJDO8vZN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edd9d1d-8eab-433a-07a4-08dce859f56c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:00:24.9662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/Dvx++l1ewFeesjLKvgdyxesL0eBBpfElTNdqt4T9sq0OVLhekzNHxKomA0cDiV4QwKO1jzpUI0FJ8am9j3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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


On 10/9/2024 4:21 PM, Christian König wrote:
> Am 09.10.24 um 10:48 schrieb Sunil Khatri:
>> Remove the dummy sw_init functions and set the
>> corresponding functions to NULL.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 5 -----
>>   drivers/gpu/drm/amd/amdgpu/cik.c        | 7 +------
>>   drivers/gpu/drm/amd/amdgpu/si.c         | 7 +------
>>   3 files changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> index adc0b80ca5db..4add6c412779 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>> @@ -33,11 +33,6 @@
>>   #include "isp_v4_1_0.h"
>>   #include "isp_v4_1_1.h"
>>   -static int isp_sw_init(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int isp_sw_fini(struct amdgpu_ip_block *ip_block)
>>   {
>>       return 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c 
>> b/drivers/gpu/drm/amd/amdgpu/cik.c
>> index 6c18ab35cf69..bb961b274487 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
>> @@ -2124,11 +2124,6 @@ static int cik_common_early_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int cik_common_sw_init(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int cik_common_sw_fini(struct amdgpu_ip_block *ip_block)
>>   {
>>       return 0;
>> @@ -2195,7 +2190,7 @@ static const struct amd_ip_funcs 
>> cik_common_ip_funcs = {
>>       .name = "cik_common",
>>       .early_init = cik_common_early_init,
>>       .late_init = NULL,
>> -    .sw_init = cik_common_sw_init,
>> +    .sw_init = NULL,
>>       .sw_fini = cik_common_sw_fini,
>>       .hw_init = cik_common_hw_init,
>>       .hw_fini = cik_common_hw_fini,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c 
>> b/drivers/gpu/drm/amd/amdgpu/si.c
>> index b9934661a92e..0578c7ce4dc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
>> @@ -2148,11 +2148,6 @@ static int si_common_early_init(struct 
>> amdgpu_ip_block *ip_block)
>>       return 0;
>>   }
>>   -static int si_common_sw_init(struct amdgpu_ip_block *ip_block)
>> -{
>> -    return 0;
>> -}
>> -
>>   static int si_common_sw_fini(struct amdgpu_ip_block *ip_block)
>>   {
>>       return 0;
>> @@ -2691,7 +2686,7 @@ static const struct amd_ip_funcs 
>> si_common_ip_funcs = {
>>       .name = "si_common",
>>       .early_init = si_common_early_init,
>>       .late_init = NULL,
>> -    .sw_init = si_common_sw_init,
>> +    .sw_init = NULL,
>
> BTW don't do that, just don't initialize the field at all.
>
> Uninitialized fields in global variables are NULL or 0 in C by 
> standard definition and Greg usually complains if we do stuff like that.
Sure will remove the initialization completely for it in v3 patch set.
>
> Regards,
> Christian.
>
>>       .sw_fini = si_common_sw_fini,
>>       .hw_init = si_common_hw_init,
>>       .hw_fini = si_common_hw_fini,
>
