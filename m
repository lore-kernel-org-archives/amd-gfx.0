Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A6AE67493
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 02:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA02C10E037;
	Fri,  1 Nov 2024 02:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vOTsPW7c";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A251C10E037
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 02:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHZj5NsW0yAsrJsGcFGPKcUialESsvl66iRWAPwe5mo2ftdE0s4gc6hr2Algxy1vEKjbO7kgZRPp0WocD6QmxyQ+9iswQkmkKcqO/UNcnTqA5UBDli2ygrxf544HJSbNgb71GhipAIUVhC1alnty/LE71d0FQrf9SnkrdJgOh2jzd9dJeIYin562+3QovJNGGW/SD+jd/lkTW/dAN8eBNftnr8fcfr64YXZ/R4/siuJX7nTJGKZeI62kewXwXL3b0iGYJN5fsNK7tjHdDqY4C4A8om906yTsKNhuH5AfMeO6myWDYk+KcZMfBbX91qtTWzjTXE7v8vDoOFmZVg0oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLP6ZhUg8MhkZrLpJEm21UjxjFWIA4PDjCzHvALd7Go=;
 b=hEYDWW8HWTu8SDnZBiPEV8zP0Wihkhq/y0CtPptz6+1oGdoMM8KRlDxvNTYdlxTtI+pyq7rW/DW7v+eK0vC1wEXxGjKjqfFftq1YKMKQ3tX6LFwln+jydWTkE88sW6oaIru0wpJvk2GCXLO6nBRhoG4rLMX7WuxNB2kV6tMC+K71Fte5+ddyV21Xo9wKdWsT/hwjBs6h6PiX2qHCjX52tKkuWlhFdVLn8LabOGYy0HsvUYsj/FKUzAWhWUs4MBtcNCzZ6JTu8nZ8d+tfPpDGdeH0dUQgWQflbUKDLmSlLZHg6LwtSiyqxbtEjeWsk3g+JUjlNKro0Z5ud7Okde2h9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLP6ZhUg8MhkZrLpJEm21UjxjFWIA4PDjCzHvALd7Go=;
 b=vOTsPW7cei2q8CoMFOdY45kndHS+VjkBQFQV1rWN91bDbHNdV9poF8waa2RinOU111BC2K4O37CzvxYTtVfTNzzv7g+vED03RfOftw7/cReZ69zjeVo4VmPC1+VrV/bzYvTeD14V60IiKpchO2avvYjwTVCz/fz73cJAIxW7C9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 02:15:11 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 02:15:09 +0000
Message-ID: <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
Date: Fri, 1 Nov 2024 10:15:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6cdf00-be25-44d7-b840-08dcfa1b0239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVJ1cUppdWFsUllidURYa0ZicGM0Vmk3VEtYcUNUcTV4Vk9McVBMOWh1N2pt?=
 =?utf-8?B?QjdYR1QvYUtMQVlzNnR0OHRsdnZGSVlZNHBkNnhIMVMwZUF4R1Y4ZmN1eXA3?=
 =?utf-8?B?R3hWSDBHMzZEd2k4ZTM5cDcxZ1k0UWpGTXVsUjFDMWRXcHI2bjVGWlNScnMv?=
 =?utf-8?B?bVk2bjE1RTNZY2xCWWJiK2ZOZlVSS1VXMmx2cnJpenhxUDlOa3RUZlBuVDBw?=
 =?utf-8?B?Vm8wQ0cveDdDUzdrejlDK0tSWVcxUlhzMTF3YmxrU1pKSXY3bkFrVFRXL2JR?=
 =?utf-8?B?dkdIM2tIWmp4eDdHc3ByMG10ZXZ5STB6TFU2ZVpsZmhtSTFEUmxvbGpXK3ZF?=
 =?utf-8?B?TEhhbllDNjFwOWF2R0dCbDIwTG95d2tObjAwR0hQVWNiNzd4RUxsUkVLcklw?=
 =?utf-8?B?dncxeDRrWGR4WWc5bDc2bFgwT1Q0VEZyanlwSUs2NmNDNHRQUjRkTE8rbVRk?=
 =?utf-8?B?aVZZcnVmNks1U1ZHU0hKVThsVjBibENHaGlhekVVR2RPdlNiOWIyN25iczVi?=
 =?utf-8?B?aWRXNzRhT2Ric2xORytMV3FXd0hDQW1hc2ZrK2tZU2liMi92L3VXeFV5ck04?=
 =?utf-8?B?VnR2TFlVUzA4U3JUWVBJSk05YnlBdnFlK3dvVGoreFlJa3E0MGtkeTI3Q0JC?=
 =?utf-8?B?NDU5ZTNYUjFoY0FsTVNabCtjM3NUYzE0eGJnTVMrYTJwdWN1TEVZM1JqaE83?=
 =?utf-8?B?Vzl1YUc0TTV4WEhzNWwrV3NHYmpJTXdaVGQzbGxXL3RhdGpYV0c5VGZ6K3pN?=
 =?utf-8?B?QS9tbmx5WmhWcGk2TkNqeW1hU21QdHIvR0pFODRCSERtVXBTWVdTSnp3Sms3?=
 =?utf-8?B?ZWdPcmJXaCsvNU5NWDNQSXFXeEhaYmJWclE1WFVKUWdLcFBuZ1krZ0VRbEhB?=
 =?utf-8?B?WnZoZEdhaWxjVHBJdDFoYVMxS2lRUGQyem80WmNad3BFQVB0L2hiTXpoNzBB?=
 =?utf-8?B?SnhtWGxrRVRaV3ZwdUdYWk92T1ljT1dFSzJmaWZQV0RzSjl2a0J6Y3k2K2ZX?=
 =?utf-8?B?NnhoVEtXUGcxR2ppSUQ5REllSjlEaGRSeFN5alFTTzV0YTRmTzN3SW1qTDdD?=
 =?utf-8?B?citUajR0TnFiRzFzRWE4T0RoL2dEQ3BUUmVRQTRDRkNYaHBnbjFHSmZzVUtl?=
 =?utf-8?B?aWQ5VWVYT3kvOUdQeXdxV0s4NzlYUTZSclNWNmtqRGlsTlZ0L1RRUWxPRWhv?=
 =?utf-8?B?UERvSU56NHFYNFhUSElMSG5lc2pGM2lHVXpBa0pBU0FEVW9HSW1PNVRUMEdz?=
 =?utf-8?B?TXIvNE15SjVwZm5Wdmt6TVFtMmpuQno5MCs4MytaY0QwME9WNTlSSFZSUElI?=
 =?utf-8?B?bTA5RXQzUE5Tbkcrb3NCb0tuODV4UWNDcVBqUUlOTEIwQzhaaktUVXdyQmp1?=
 =?utf-8?B?dkRNR3JTTlZiK3NBakd6dWVsN3VlbVhYdjdweitLSStnZTJnaEZYaURNbEow?=
 =?utf-8?B?NC9iamtoUDZ5K2xFQ2huVFd5SjJTRDhlTlE4K2dienFQTzhFSExHc0pieEJD?=
 =?utf-8?B?SUJyRnhEOHVBZnB2bVlycG5hUHZHaXYxdHFGblJOMThqY1R1cFk5LzhEQWxZ?=
 =?utf-8?B?R0puUEo4RVowbkcrNE5UM3ZJMFErWWs5am1JdDM0dFU5K25Sb2Zsay9WZEtw?=
 =?utf-8?B?YSsrTCtaanduMFRITDhzd0hBdGxOazExdm9kOHAwY0oxejlhZThYYytoU0Z6?=
 =?utf-8?Q?uhoCtzbRZuUFI1h7APlj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEtOeFhMWXZXMHM4QldWc1BpYXRveTF4bS94QUJGMExoTmFOcFI2b0FrYTNL?=
 =?utf-8?B?N3hOdjZ1cTc1Z0JpRHppaGxkb01mTXNadzFlVG1vd2lWWmZWUUJCRFRucUxy?=
 =?utf-8?B?NU9sdHppV2lRN3RnazduODltQXhXeGRuT1JQWmRRWlZUay9BSlRDdHRBTTJL?=
 =?utf-8?B?b3d1Ris5OFJRUlpKa25HLzVORnJkbnJZWFBQTXluTDdBUTNZSjhFM0l2L2Yr?=
 =?utf-8?B?M2hia0NIcDZPUzhFNlppNWFRaEMyRksza1NWQ1g2ODUySGNxWkExR1pRTHVJ?=
 =?utf-8?B?VGF6bXVRZC95YTdPN0w0VmlxeHBtUFRSY3Q0am1PRUhoK1N1N2g0WlZEYVFk?=
 =?utf-8?B?akRXM241a0N6cDU4ajZuWjVBR1RPWTMvVUFmUjFVcVc2bHhIVUdoYmw1dFNl?=
 =?utf-8?B?b0FrQ2dBbmJkVC9QUHM2bHFNNjhXWUxVckxOTEY0aVF0T2ovanBnZ3o3Y284?=
 =?utf-8?B?cnRlcU5sMU8yTWF3SGlEMlJUcnFOQlNSY05ndWRFVGdzbWtyZkRnazYrVU5W?=
 =?utf-8?B?SHZFQjRGTlZ2MkZJeS9tT3lUUXZTbzNhbWYrYVRNalcwVHFzcFYra1kvQ2dt?=
 =?utf-8?B?cEtWNzI2Q0FRNUdHV0t0TGw4QlB4WkVDa09tZzlhd09WUWdLUTNnYnJscmxN?=
 =?utf-8?B?V0duRVRadjU2RXRpYldZMnpNZU1PN2pFUkFjYk16TWZlSDUzN1RRL2diSHZT?=
 =?utf-8?B?WHEzWnhjSCs1UWtHZ3ZFSTdYVXI1S2laVENpNEVuUmo1QjFTMTFhRUcxbG5U?=
 =?utf-8?B?TDMrTVVhNkJkTm5mKzE0Q2ZtcVlhK2hsQ24zOW5Gd0pCTEhPL2hWZUNtTGJ2?=
 =?utf-8?B?RTFGNmxraXZrSmhkaEtMK1ZDUU1jeEZva1V4eTdHdmdwQ2ZFK0Q5ZEJySG1j?=
 =?utf-8?B?VGFYK2g5elNDVXNsNW5iakVkZVM2V3djbkxkOHQzMktLUDkwM1lsbU1Xb0FW?=
 =?utf-8?B?SGF2NTZXd05zSUlpVmdrSVNBU1RWcXg3eG1JQ2tnaUhUYUREWHJXNHo0Ung2?=
 =?utf-8?B?cnVmUkxMNnJYWmRaQ3gyc2dkSUJ1VjZUSEJubWU4NlNBcGFKZHl5MS9sQlhT?=
 =?utf-8?B?Y1pFbkJkcVRWTjhlM2FWMW15MGE3ckhMWGd4b0Qvc05LK0IwU1V4MXBXRC85?=
 =?utf-8?B?MFk0Tzh4eEhrNEQ5SFRNRlBOaE5LZUlCZTZlMVV1dW9wMEE4SWxOU2pSeXNQ?=
 =?utf-8?B?TEYrZzJJbFU2Mm05cU1oTFplNFVtS1VnLzJmZU9BaDFFbGVkSnpZN09KOUhm?=
 =?utf-8?B?a3JIVnJKYmtMbmwwVk0wSHdIUDc0R1l2MGVYOEZKNEFWUStWeS9PcE96alJL?=
 =?utf-8?B?K2RmcUk3TlYyRGtBQ2w2aEJKMWhDOEpaWW1CVmcwdy9ZdGRwYUZOTXFCMzNm?=
 =?utf-8?B?YnRhbTVZUy91WitxZEVDWjRicVR4NEtDZnlncEtzS0IvR0J4dHpkdnJXVmFK?=
 =?utf-8?B?ZTk4YlBuNlgwOWRoWDVpWE50VDdVUDZVYTR5SXVxK1ltbEoxV1Y3Z1hJbTRa?=
 =?utf-8?B?VUZBSFpaR3lmNkhkd3llTFQxN3AvM2tGaUN5RHB1OGcweEN0T1hnbHFWUngr?=
 =?utf-8?B?V0p5c1M2bTJKOXREMUl1WTJiTlZEdDB0bG0raVRITitMTXpyT0NSaFAvaW1a?=
 =?utf-8?B?dEpIYTlqaE1FL0JQSUdGbHpUN0tYN2dFMnpPd205YWlyTDRtM085K24yZ282?=
 =?utf-8?B?UnNLUkZuWUxZYXVhdStBRlZCMjU3ZUU4RElHRm5iTG9YZzYyWUVaRlVOa09s?=
 =?utf-8?B?ZXJHLytRbDNGdjFLUDV0ejRtZ1M0Q2xmZ245bkp3a0U1RU9zb0M4UnBQK3M5?=
 =?utf-8?B?S1pBSStTWm1QemRlZnlERyt2bmtFdmRUcXdiN0NkNGZMS1hGWDFIRmFHeFRm?=
 =?utf-8?B?U3lFa3Z2V3RDSkxKTzVtOE8vcDBpcWN0TzcxTCs5ZHljUXh1VHNsbUVwWi9y?=
 =?utf-8?B?S3VGUitJdHR2S2IwSExvbXE5MHQrUTM3WWQ0NGdURlg4a1oySmE5WmF4QUZB?=
 =?utf-8?B?ZjBXc25LSWNOblZzNDJQNFoxTFMvbkorUzVXQ252OEdiTDJaVzhmd2k0aDhr?=
 =?utf-8?B?b0VUVDVnL0VhZ0w3bFN6UHlwVUQwV0dSSmxPQUhvaGpTc25hbDBZQzFic3dY?=
 =?utf-8?Q?ZVhgQ1EqQmlpve/G6JXujH5Yp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6cdf00-be25-44d7-b840-08dcfa1b0239
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:15:09.0465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0RMtWiFO2JVQhw1LewoxOBu8rnbJ+CwePQwN350e5JZakUE5cxyYz2lyIRq3U6xNslLKinxFKLBA7RtrMHwWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734
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

On 10/31/2024 11:27 PM, Felix Kuehling wrote:
> On 2024-10-31 6:47, Zhu Lingshan wrote:
>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
The mainline master branch:
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
#include <linux/kfd_ioctl.h>
>
>> And it is actually not a file in the source code tree.
> If it's a file that only there on your local working tree, maybe just clean up your working tree.
Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
The is even no folder usr/include/linux before building.

For a quick verify:
1) it is not a source code file from mainline:
$git blame ./usr/include/linux/kfd_ioctl.h
fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD

2) it is generated when build:
remove usr/include/linux/kfd_ioctl.h, then build.
If we remove a required header, kfd would not
build and there will be error messages.

but here we will see these lines:
HDRINST usr/include/linux/kfd_ioctl.h
HDRTEST usr/include/linux/kfd_ioctl.h,
no build errors, and usr/include/linux/kfd_ioctl.h is
generated by duplicating the uapi one.


2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
add random characters in usr/include/linux/kfd_ioctl.h, then build
we will see errors like this:

In file included from <command-line>:
./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
   65 | abcd1234
      |         ^
      |         ;
   66 |
   67 | struct kfd_ioctl_create_queue_args {
      | ~~~~~~
>
>> Ideally, the usr version should be updated whenever the source code is recompiled.
> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
the usr one would be installed to the system when run make install or install_headers,
it is for user space, we should include the uapi one instead of usr one in our source code files

Thanks
Lingshan
>
> Regards,
>   Felix
>
>> However, I have noticed a discrepancy between the two headers
>> even after rebuilding the kernel.
>>
>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>> the latest changes are reflected. We should always include the source
>> code header other than the duplication.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 26e48fdc8728..78de7ac09e8a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -32,7 +32,7 @@
>>  #include <linux/atomic.h>
>>  #include <linux/workqueue.h>
>>  #include <linux/spinlock.h>
>> -#include <linux/kfd_ioctl.h>
>> +#include <uapi/linux/kfd_ioctl.h>
>>  #include <linux/idr.h>
>>  #include <linux/kfifo.h>
>>  #include <linux/seq_file.h>

