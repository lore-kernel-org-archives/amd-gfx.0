Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6871AC3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 03:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18A3810E13A;
	Wed,  7 Aug 2024 03:47:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pohIaFa3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC19B10E13A
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 03:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvqm9zLHHQ+Mn0GiYTQM5zgtEOhzGG+mqTgr+WG4fKP59owpnE/+qDacofK5GqZtaIqNFOmS6Ge/5sGVM4Op2cS/t8e5ECfjDiPlE9MyHqn4srkbPzUAjp0fW+tsDTAJMH3XIG8ji9Cboi81IAFT3X/WzW9txmZhwguHDJrHUIxP0sRAvzgRsgekdZiygHR0MG6uS0gao4EY5O4k3o/fyyhiO9k6+8NmVDcM6w0rAWBmV1/1v4W8vw51dsKcIVAOqOGIilfl8Yl0WksLAxVkD9uyWcUSlZtu0VoYlhuGF+yBiJXGoP7nhyoBhBbc1lzOJIFmpqMrmtFUiqR4FApeeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVJJo1/vqBhXAwurOn8MEyQ2e5Wj6ca5HRLNLVVQNTQ=;
 b=hb/MVe72JiB5usYMZITE9Et6bS5GIIM5Unm8+ssB7LPPcULsIzi3xD7D4Ti29ons+/VNEws9knfvng7ovb1Lat5vfWX+GklJcLlHS73tT/7SrkAeDarBHYYVQUCo//hsTEilEkdbbJPjD8O4UHsy9DFjF2PrX1oRPqaTIBDAbmrwmqIpZivvcOjsQtOXAGcDm+fQ6XTOvw2getxqVAoZPIZo/rOCvag2AiP6+x2i5aUA/j0t4fWTSYuhhIz2dD8jF2Wj3g8iTcXDKwp4/5ffuGC8YdEB/sQWG+fAqhzqa4ySzy1qziWaQtSddOO58ZRXfisAFWl9m4HVu3EfFRrHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVJJo1/vqBhXAwurOn8MEyQ2e5Wj6ca5HRLNLVVQNTQ=;
 b=pohIaFa3ZxS1tWVo9pB35Mz3Exlkr3HR8TqETtFZNBfXT1X8dh9/Wf+aiQ5wEQ44iew6ORpgXGXhQlv/whK569D+L1BW3Bv3RL99NNKzt7CAFodjMm67tYJvKOKLGzcnkkveu4MqQMoLxG7xirx2IVTJgurFxCr7eiZjgxGBAiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 03:47:47 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%7]) with mapi id 15.20.7828.024; Wed, 7 Aug 2024
 03:47:46 +0000
Content-Type: multipart/alternative;
 boundary="------------GD8Bdvg1hrc99cqZm53krRvj"
Message-ID: <94163e52-805f-4275-9fc1-992b581568e5@amd.com>
Date: Wed, 7 Aug 2024 09:17:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/15] drm/amdgpu: add vcn_v4_0_3 ip dump support
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240806081825.2422771-1-sunil.khatri@amd.com>
 <20240806081825.2422771-6-sunil.khatri@amd.com>
 <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com>
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f211c0-c455-4182-b0b9-08dcb693b343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWlHd0wwcEdJV2Q4MmZzSml3RW5VMmpKLzRWR204eEVTZ3JmWW1XZ0FVNXZt?=
 =?utf-8?B?aHRUYkRIYjJlZUk2QkNoeEFiUnc2T2k2T2d0TnUvMElUOUM5ZUdnRUp1NmJp?=
 =?utf-8?B?dEc3RDBNMXpvMDNiV2Y5SThGY0hieE5IcklmUU1MdFhhODBWNXZXaXJCbFp4?=
 =?utf-8?B?YUJtQkRKWWpoSkg2Zk16Ti9PMVFJOHVYMDlGYlVKd2FWOWRqYjE3MjMxUEhn?=
 =?utf-8?B?enVES3l6Y1hjWC92aXM2L2pRYnU3bmJKU3BESFRJUVFsbVp5Y0w2THZwN1dU?=
 =?utf-8?B?LytITERtYmtkUmlGSEdOZmdhZlBLRStqYm9mbFdvcmR2MkV2K0FHbmhXMWcv?=
 =?utf-8?B?S3MzUjhrUVR4WUhmSkVWaEpPQTZCeWNNNjZYcGo2WnV1N1gycHhPdlpleWpo?=
 =?utf-8?B?OXhlU1Y1VW9URkVBNjlwRU9FRGQ5MUcwUFE5MHFGNnJsd1BhNzFJU1REaUM5?=
 =?utf-8?B?SWVnajhhVEFHOVRVMmU2ZGE4U0EydmpoaDNZU2h6ajlLTllZcWs5TWxySzF2?=
 =?utf-8?B?bFhJcTc2NzJrQm41bXZCNkd1WHRZSUZUS1h4bE1wMVVqQTBuUGNQS3lQQXBD?=
 =?utf-8?B?UE9tUzVWR2FaeWc5NWVucW5oejFuR3pkMEdNYWovaDkyWFhtdUE4NkRRZ0Vz?=
 =?utf-8?B?cUtGN2MxdHNrVE5CeEdmb3FINEtlbklsQThhT0ovTWNpK1QvbHNPT25iQ3Z6?=
 =?utf-8?B?UkQ1L3RTSzJGQUs1TnlDdkJqZXlPbS9WUWE5ekdNZTllNkNzY1c4bWI3czlF?=
 =?utf-8?B?UWQ1WjRYRGhtNGlnTWVtQ25DbnlkbHVZTDZhS2MrblRUbXRTalVnK3dudEEy?=
 =?utf-8?B?MHpTWEdmWnZ4cmxTUjNGTlNQMGpqcGtpUWR6eFFTY1d3VVVybnpHbXJwMWRi?=
 =?utf-8?B?c2I5WU1rVVpQaWtueFNtUjFxTkR0MThRYUlmNUZJcEk5cXpnQVY4MlkreHAv?=
 =?utf-8?B?aHZnUHNGKytUc0FBYzZQeklKakdNRjF1c0VaN0dReitNdmRTak5OUjlsSjJD?=
 =?utf-8?B?VkxmRVQvaWZuanJDQ3VqZTF5OFAyM3dDczA3emxydEJrMWVMaXZKRzkrSTEz?=
 =?utf-8?B?djJsY2ZQb041bGJpRDdDcTBRZFJYMFJqWGxtcWVnL3RmVmVhdzBFdisyYU91?=
 =?utf-8?B?L0duVFdPWnZOWk1mV1pwaDA0SjFYdXlVSEhMUzdkVm5qblR5dTlIeDc5MjZz?=
 =?utf-8?B?ZlBteVJCdFJ2QlkxN2twQnNRY1dUQVNqM3ZYNHZnYjgzOXIyR05rZG4rL3JR?=
 =?utf-8?B?Y3dHRXlWeXZNc3NKVDNDVjJmZW9sTGw1eDZvWGRscHZEaTBVSkxmekFJSktP?=
 =?utf-8?B?dm1VeEhyS25ROGRnRWtDTGJDVjF6NExiVjNFZGlXT0NJUFhrQXBXQXhOMmJl?=
 =?utf-8?B?aURTRUdRbzBuMlE2TjA2bEVmd21XanA3SEFDYThZbDdQcHkrSUthNjdlNklT?=
 =?utf-8?B?aDdrM05VTVlmMGZWRFFoYlVIRmNOSlVyY2RVNjBIL3RPb1RoLzZmU0RUWjhX?=
 =?utf-8?B?VGZZbUV2SnFleFh1a1JBVkk5bStsRWN6dXc0WmdjL01CK2pIK0FtUVh5MjdS?=
 =?utf-8?B?OHN0WmwwRUJRMXU4RzRHWm1uRVFYRE1RYVMrRmh3YWxtbTBqZlUwNGR1U0Vh?=
 =?utf-8?B?ZDY2VmxXeEEvazR6T1BRbkRkSmxlQ24rLzFiU0ZpMGRwY3NXNE1XcE5NVzRB?=
 =?utf-8?B?bzBWTHVleVdhQXRRWTZYellyd0hYZGJxTXExTnZsWldtbmJIdkxZOWdOK01s?=
 =?utf-8?B?alJIMHArdm1SZzNvMjRlclVxb3h6d3lPOVc1S1ozMm12YStiYVI2UFo5d2pK?=
 =?utf-8?B?ZCsrTUljVlhyYUpiSk5TUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHd1czEzSm9NWkQ1ak9LbHl4aGNZVlhtNW1JNFM0U0N6OU5oUWl3T1lZOVhC?=
 =?utf-8?B?MlFUdTFMb2pLdVlLbVBEM3F2bXhQV05EL0N1ZWdDb2lYdlRyemZ1TXFRTU5Y?=
 =?utf-8?B?Q1M2T1FHUFpNSDJNS01yQ1licTYzRE0yZi9GalRFbXlRSDlpNnlEaTZsdmpE?=
 =?utf-8?B?WEZ2MGpvbUlsM0dWVjdjOXN4Sm5QV3ZhRUhCeTNzdzFYMThsenlMVnR0Qk5R?=
 =?utf-8?B?MGl4L3pUaW9WZ2c2Nk5kcWQ0UHcvak03MS8xTUkxL3B5L0JwMjAxZk5oUHEz?=
 =?utf-8?B?ZkM4OHBpRnE5N0hSc2w1VVZsY0VXdHVKOFVNTVFDclpXSmxmT2l5TVNlRVVm?=
 =?utf-8?B?bHlMN0dWTHRZRkZMZi9FdGd6eUhMRVJNd1AydTQ3czNEaml3bE5xSUVhZW1s?=
 =?utf-8?B?N1h3RFJicWpZL3l5RGE4cklxQ0lxeWkzQkQvL1ZYVlgvaTN2Z2ZaM0hydU5U?=
 =?utf-8?B?TkZVQ0U4enB0UmtTSzRBS1IzV1drSDh2TFpCS0xrOTg4czhHSEZFU21SamNN?=
 =?utf-8?B?ZVhGMFZ5ZDhCaGJ0V2dHN215N05BcDZkcUw2cnpSbnJOdE5RbjNOa3FYZ1hx?=
 =?utf-8?B?UkxGYy8rdUNCYWRaa2l5dksrdFdDbzM2WW1oQXBlQlE5T1pmeGlzcWhLWmpY?=
 =?utf-8?B?b1hUTlhzZVUyc2JnTCt3Rm9ycm94QXhMOFk5UWUxQ0lXdUh6OWlGdU5xQjFz?=
 =?utf-8?B?L2wrbC9NTzQvc05zYVE2VkNUQ05yRUVXWFp1Rm5LZTlWdGEwenNyMmpXNFVC?=
 =?utf-8?B?Nm1lL1AwQ3FHT0o2cnZVRnZmMGpjMmVLRHd5RlpuRXJTWjdHeS85Vi9rMm81?=
 =?utf-8?B?WnFLdys2djlnTXJ2YnhBMlRLSkErMnQreVJOeGRFUU8wMzQrZlBWaSsxWHhV?=
 =?utf-8?B?clpPQWVGcWpRQjB4VzJMNTVVNVY1U25vWFRWb0VLbkVwVXB1eG1zUytVaHhs?=
 =?utf-8?B?ZmM2clhZTHhTRnhjRDh1WHNVTGovbTlqQTJQMVZqOHJZU0l5QjYyQVVtVDJl?=
 =?utf-8?B?NVpNVFFocWUyWWVUZmlpbUxielBWZStnbXpLNHZsSEs3Ry83NUlsWW9GWS9T?=
 =?utf-8?B?aDVjWGFOZTd1WThndStDWVRzRDE3b2xtVDBDenRZT2JPbDZpS1AyU2hYTTdh?=
 =?utf-8?B?bDQ5N2ZxMmxSZGZyazlWcE5HSDRlbEFoRmFVYlo3RmRrTWdDOTIvQWc1dTgz?=
 =?utf-8?B?UVovYS9FMEN5UXpXVHJBVU1vczVFZ1Y2Qmg1RVY1eUZZenNQWFFzV2ZoaUNE?=
 =?utf-8?B?VHVpZmlwWnZXb1ptUHRDRU9CWVV0U3pFbkRQRUg0TDg5QjNTWTFydWNJQWpu?=
 =?utf-8?B?Q1hxU3F4Y3V2WkdtTERpRy9VcEp6eHdmS01KVDdScnc2RHNMdEw5RHVGeWlH?=
 =?utf-8?B?eFozdzJtVVZJNWEwa3VPWXppR2JKMTAzTXNyU0NNNzdPNmZKWEc3QURNZGpG?=
 =?utf-8?B?L0pNVWRZb1VMNjJiMGJMOXR1TGF0Wm52S2pvaVZHcDVNNXpWbE91eHA3M2M5?=
 =?utf-8?B?ejVSNERNQmVwQ1p2Wm0rY1FTRFViUmd2K0xvbVgxdHdlaWpJOHE0QS8yRFRK?=
 =?utf-8?B?VTZ6ZFRqc3VnRU5kQzdYeHJ4aXA4TVhFYnJmTUNvVUI4bGhTaktzVUFCYXZu?=
 =?utf-8?B?OW5NNDRiNlRVSnVEWXh4YzBUbzcyRUdmbC9mYUh4RytBWnQ4OXdIR0RNRThF?=
 =?utf-8?B?OFJCMks1bk8rRDVEYVdON0JkZmh1S1dScEYramI0YXV4TXFGNm1rTTBtOFJw?=
 =?utf-8?B?RlkvbDFwZDVMSXUwK3lacDk4MGhSM0NMVjJHMUFTSXRad2FIZnZaYzZpWXRo?=
 =?utf-8?B?aVFnaGRXRHRMdWRqNm1FVXVObVlhLzBIQWJ5UVFQSHF5eHluRGlxTGo2bzZl?=
 =?utf-8?B?M3IrK05HN3cxZVd5MXVEMitqdWJUYU0ya2tpbEtYdGFZNnBUY2FNYkcxY3JT?=
 =?utf-8?B?eTNJREk4czlzRllwU0FZUWxpb2Z1VEVCd1RFQzFkbk56YzE3eGZzZzVTRXd6?=
 =?utf-8?B?TXllRjJMTEV5K090eDg1S0trVTFxZURtZzIvb2xHdGdLaGgxcFZuQy9MOXJr?=
 =?utf-8?B?TFNJSkVIUTB4MGhoU2xjd3RJTzRqSFJnZjNkVmcwMnZ0b1VrYk9PUjU3dWhq?=
 =?utf-8?Q?RCIyan4kbrqvXyB420qAouUee?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f211c0-c455-4182-b0b9-08dcb693b343
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 03:47:46.6838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6rcLDANs2dDcLZjUS/bTlMTzYdjWB7sSwa8107x1su8TshfSir0L02FYR/8kboXpXcJovoW+9wsX1rSRoI8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310
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

--------------GD8Bdvg1hrc99cqZm53krRvj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/7/2024 2:58 AM, Alex Deucher wrote:
> On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri<sunil.khatri@amd.com>  wrote:
>> Add support of vcn ip dump in the devcoredump
>> for vcn_v4_0_3.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170 +++++++++++++++++++++++-
>>   1 file changed, 169 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> index 9bae95538b62..dd3baccb2904 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>> @@ -45,6 +45,132 @@
>>   #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
>>   #define VCN1_VID_SOC_ADDRESS_3_0       0x48300
>>
>> +static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
>> +       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
>> +};
>> +
>>   #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>                  (offset & 0x1FFFF)
>>
>> @@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>          struct amdgpu_ring *ring;
>>          int i, r, vcn_inst;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>> +       uint32_t *ptr;
>>
>>          r = amdgpu_vcn_sw_init(adev);
>>          if (r)
>> @@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
>>                  }
>>          }
>>
>> +       /* Allocate memory for VCN IP Dump buffer */
>> +       ptr = kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
>> +       if (ptr == NULL) {
>> +               DRM_ERROR("Failed to allocate memory for VCN IP Dump\n");
>> +               adev->vcn.ip_dump = NULL;
>> +       } else {
>> +               adev->vcn.ip_dump = ptr;
>> +       }
>> +
>>          return 0;
>>   }
>>
>> @@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)
>>
>>          r = amdgpu_vcn_sw_fini(adev);
>>
>> +       kfree(adev->vcn.ip_dump);
>> +
>>          return r;
>>   }
>>
>> @@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
>>          adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>   }
>>
>> +static void vcn_v4_0_3_dump_ip_state(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       int i, j;
>> +       bool is_powered;
>> +       uint32_t inst_off;
>> +       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
>> +
>> +       if (!adev->vcn.ip_dump)
>> +               return;
>> +
>> +       for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>> +               if (adev->vcn.harvest_config & (1 << i))
>> +                       continue;
>> +
>> +               inst_off = i * reg_count;
>> +               /* mmUVD_POWER_STATUS is always readable and is first element of the array */
>> +               adev->vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
> I think you need to use the GET_INST() macro to properly handle this.  E.g.,
> vcn_inst = GET_INST(VCN, i);
Thanks for that. In all other cases apart from 4.0.3 it use array index 
itself as the Instance id.
GET_INST is only used here in 4.0.3, Is there a special demand for 4.0.3 ?
Regards
Sunil khatri
>
> Alex
>
>> +               is_powered = (adev->vcn.ip_dump[inst_off] &
>> +                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
>> +
>> +               if (is_powered)
>> +                       for (j = 1; j < reg_count; j++)
>> +                               adev->vcn.ip_dump[inst_off + j] =
>> +                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
>> +                                               vcn_reg_list_4_0_3[j], i));
>> +       }
>> +}
>> +
>>   static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>          .name = "vcn_v4_0_3",
>>          .early_init = vcn_v4_0_3_early_init,
>> @@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
>>          .post_soft_reset = NULL,
>>          .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
>>          .set_powergating_state = vcn_v4_0_3_set_powergating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
>>          .print_ip_state = NULL,
>>   };
>>
>> --
>> 2.34.1
>>
--------------GD8Bdvg1hrc99cqZm53krRvj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/7/2024 2:58 AM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">On Tue, Aug 6, 2024 at 4:18 AM Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Add support of vcn ip dump in the devcoredump
for vcn_v4_0_3.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 170 +++++++++++++++++++++++-
 1 file changed, 169 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 9bae95538b62..dd3baccb2904 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -45,6 +45,132 @@
 #define VCN_VID_SOC_ADDRESS_2_0                0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0       0x48300

+static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET0),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET1),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CONTEXT_ID),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA0),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_DATA1),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_GPCOM_VCPU_CMD),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC1_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_VMIDS_MULTI),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_NC_VMIDS_MULTI),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_HI4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_BASE_LO4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_RPTR4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_WPTR4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SOFT_RESET2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_GATE),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_STATUS),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_CGC_CTRL3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_CTRL),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE3),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_RB_SIZE4),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_STATUS2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SUVD_CGC_GATE2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_VCPU_CACHE_OFFSET2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_GPGPU_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_LUMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CURR_CHROMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_DBW_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_CM_COLOC_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP0_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP1_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP2_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSP3_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD0_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD1_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD2_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD3_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_BSD4_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE3_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE4_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE5_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE6_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_VCPU_CACHE7_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_SCLR2_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_LUMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_IMAGEPASTE_CHROMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_LUMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_MIF_PRIVACY_CHROMA_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_LMI_STATUS),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_DATA),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_MASK),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_PAUSE),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_VCPU_CACHE_OFFSET0),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMI_VCPU_CACHE_VMID),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_CLK_EN_VCPU_REPORT),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_DPG_LMA_CTL2),
+       SOC15_REG_ENTRY_STR(VCN, 0, regUVD_SCRATCH1)
+};
+
 #define NORMALIZE_VCN_REG_OFFSET(offset) \
                (offset &amp; 0x1FFFF)

@@ -92,6 +218,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
        struct amdgpu_ring *ring;
        int i, r, vcn_inst;
+       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
+       uint32_t *ptr;

        r = amdgpu_vcn_sw_init(adev);
        if (r)
@@ -159,6 +287,15 @@ static int vcn_v4_0_3_sw_init(void *handle)
                }
        }

+       /* Allocate memory for VCN IP Dump buffer */
+       ptr = kcalloc(adev-&gt;vcn.num_vcn_inst * reg_count, sizeof(uint32_t), GFP_KERNEL);
+       if (ptr == NULL) {
+               DRM_ERROR(&quot;Failed to allocate memory for VCN IP Dump\n&quot;);
+               adev-&gt;vcn.ip_dump = NULL;
+       } else {
+               adev-&gt;vcn.ip_dump = ptr;
+       }
+
        return 0;
 }

@@ -194,6 +331,8 @@ static int vcn_v4_0_3_sw_fini(void *handle)

        r = amdgpu_vcn_sw_fini(adev);

+       kfree(adev-&gt;vcn.ip_dump);
+
        return r;
 }

@@ -1684,6 +1823,35 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
        adev-&gt;vcn.inst-&gt;irq.funcs = &amp;vcn_v4_0_3_irq_funcs;
 }

+static void vcn_v4_0_3_dump_ip_state(void *handle)
+{
+       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+       int i, j;
+       bool is_powered;
+       uint32_t inst_off;
+       uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_4_0_3);
+
+       if (!adev-&gt;vcn.ip_dump)
+               return;
+
+       for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+               if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+                       continue;
+
+               inst_off = i * reg_count;
+               /* mmUVD_POWER_STATUS is always readable and is first element of the array */
+               adev-&gt;vcn.ip_dump[inst_off] = RREG32_SOC15(VCN, i, regUVD_POWER_STATUS);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I think you need to use the GET_INST() macro to properly handle this.  E.g.,
vcn_inst = GET_INST(VCN, i);</pre>
    </blockquote>
    Thanks for that. In all other cases apart from 4.0.3 it use array
    index itself as the Instance id. <br>
    <div style="color: #cccccc;background-color: #1f1f1f;font-family: Consolas, 'Courier New', monospace;font-weight: normal;font-size: 14px;line-height: 19px;white-space: pre;"><div><span style="color: #569cd6;">GET_INST is only used here in 4.0.3, Is there a special demand for 4.0.3 ?</span></div><div><span style="color: #569cd6;">
</span></div><div><span style="color: #569cd6;">Regards</span></div><div><span style="color: #569cd6;">Sunil khatri
</span></div></div>
    <blockquote type="cite" cite="mid:CADnq5_NRfRJQn9a44BZw1jge81X+htXjCAGkQue9BNEQ-EqXXQ@mail.gmail.com">
      <pre class="moz-quote-pre" wrap="">

Alex

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+               is_powered = (adev-&gt;vcn.ip_dump[inst_off] &amp;
+                               UVD_POWER_STATUS__UVD_POWER_STATUS_MASK) != 1;
+
+               if (is_powered)
+                       for (j = 1; j &lt; reg_count; j++)
+                               adev-&gt;vcn.ip_dump[inst_off + j] =
+                                       RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+                                               vcn_reg_list_4_0_3[j], i));
+       }
+}
+
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
        .name = &quot;vcn_v4_0_3&quot;,
        .early_init = vcn_v4_0_3_early_init,
@@ -1702,7 +1870,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
        .post_soft_reset = NULL,
        .set_clockgating_state = vcn_v4_0_3_set_clockgating_state,
        .set_powergating_state = vcn_v4_0_3_set_powergating_state,
-       .dump_ip_state = NULL,
+       .dump_ip_state = vcn_v4_0_3_dump_ip_state,
        .print_ip_state = NULL,
 };

--
2.34.1

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------GD8Bdvg1hrc99cqZm53krRvj--
