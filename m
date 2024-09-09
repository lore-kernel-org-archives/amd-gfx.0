Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE0CECE586
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 18:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF66410E641;
	Mon,  9 Sep 2024 18:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GNVHe5hJ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E3B10E63D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 18:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4MYdUDN1cvLT5jk9JOsTjp3ZbBA/hHYNHoCOhh2nuubFl8P9iGdJWrn4N/8SaTb/xq7bL4awLBQQRsKlHVl1fELTNxTSLxe4WrWabFvjKOX4AAN2FW2K/5e7zcTGfsFks73+QwyMOzGZp+qHm8cGrcc4R8N5PKFTkdPQ7zEud7BXd5hFicpwodgJaAU+pklLIdifTOtLNzxTf7RfcG8HqUP1Fj6J927aewlg2AIbXBCvVruStcdR5bMTls4MXY/L6zrtASIhYEG8H8KsUyXxp5oHVnW+ybo9eGE7gYcDTGJJO81EPHyXVKrWBWMiOiC2AkPHyD4pYn2wh/eVsv2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5Ob9UE4gIPF+2h7eZ3SHEa6ZU11ySjaI+QcsipEGfU=;
 b=nQf87YmrMgkK6xt9eBpfV29iWRDkK49prv6JBMF84wqh6LDLzp5h7d5Jjvw/QER1UGKDlm1lrBfD125cW1Ff36xzFFqvL8POf/st6q2Zupup9OOAKLhxrs6wSwzuytQKfUUZ6NfJaVw8n4DZ1Igxh5a/D+HWT3+SDeSmcRljoEBB8QoHU75sBK2V3qemG42XJS3sv/E9or5GUt5i5ptpTjJ9ZDCaolIfsSVtQj8Y4Sj3mY/oegU+jnJUUStF2mvRFWDFr56ln2VkhpeXWra/BMuN/HMNYYx7LlD8YAmvRBVZrPqZ1syZ6oHBIfOSEkEAuU1PvuL1+H5hCYAGiDnfNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5Ob9UE4gIPF+2h7eZ3SHEa6ZU11ySjaI+QcsipEGfU=;
 b=GNVHe5hJL51lVyDpgU9zaJztkoqo9XmcCMppK+5F0xeOIcsPv6wP3Lo4RqpW9zmmmwdyD3m2Q+sjzjhpnRet/xUSLh3MqSMmVhG/OVhT3wJYIkfA3GcsXl3SjSfxHZDcCRfDnA1tpCSF6fNvS00aQShm9SeGwKvwz0Ovl/EG8aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6443.namprd12.prod.outlook.com (2603:10b6:510:1f9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 9 Sep
 2024 18:47:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 18:46:59 +0000
Message-ID: <5c26a4aa-d18d-4e36-98a9-b915644cb853@amd.com>
Date: Mon, 9 Sep 2024 20:46:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20240819175935.4014241-1-Jonathan.Kim@amd.com>
 <0de27442-9271-44ad-9e99-0c719836bad8@gmail.com>
 <CY8PR12MB7435D74AA7571BCFF433369F85992@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CY8PR12MB7435D74AA7571BCFF433369F85992@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6443:EE_
X-MS-Office365-Filtering-Correlation-Id: b6328f02-8021-43b7-0c13-08dcd0ffc90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlB6S2t5SjRGYXB3eCtTMVRtenRBaHhkMGNrc0s2RjYwSVcxS1dBYkcyMXVi?=
 =?utf-8?B?SXM2aWhlM1ZhTExIeTZjSUVTZ0F3UmdUclhZU2JUbTRXREVyK2tpUmtmYlRN?=
 =?utf-8?B?dEVNYTg3TktWK09pWWVmSHVCd25mMmNNYyt4eGgwUEt0NjJKbjZQK1RjSmds?=
 =?utf-8?B?MW5SWG5iWWtQMnNkQUIyOXRhMXhid05yek9GdnZQWm9CN293MnZtbWZwSFBT?=
 =?utf-8?B?WEl0MFdwd1d1dnBXdUpqYVJ4OXJqV1RZbkhDR3BoWWFBY1B6M1pJczU0U1BE?=
 =?utf-8?B?OW9Bd013UUdzMVppT2xjTkhYUVhoMVdoOC9aQ0EvOVdwZGFrNTBqUjd0K3lo?=
 =?utf-8?B?SUZNM0p4S3EzMDVVbTh0NFhBL25Yd2hVQ05meVBUTjZ1UzBBeDJOMHNWR1BK?=
 =?utf-8?B?c0hHazEvRGl4ZkY2UiszNWZrZDZHYXhteWFUb2VxQmhhRjkxN0pibnVyUHJu?=
 =?utf-8?B?K1Y2M25kTmgzR3MxOTZQY0VmbWdyNGRXbHV3SUloUzFaQTVWbW5HUjZkbE1C?=
 =?utf-8?B?dWQyRW1KVzBYLzJSN2pZczBxY0F3c0RvVnZpMlRja1JON2hvV3ZVMm9YdHhv?=
 =?utf-8?B?ZkFIVTNMR0FJZmVJeWxLbzlqTmp5dHltamNEenpYMnlCOUI1eEt6QXdlZkor?=
 =?utf-8?B?czFxUWxJOEk2UjQvTytIV3ZNVFl6andLSkZBTE1aak4xdEFFSVhtVWFtK0dR?=
 =?utf-8?B?UmlMeWdVTU0wMHZMQ3FXcUFQc0RySFlPOTZWNjBYblJpR01SR2wwbm5OTHhO?=
 =?utf-8?B?TThOa1g0cnh3OUlvcUgyaS9Hci9aS2s1THBEUExPb2hHWlFVbDBBY2NSQWxv?=
 =?utf-8?B?NEtJOTB2a1FYUFhDNEpNRmVCcnR1ZWJKcXRwT2tTUGhxemxGT1E4RERlVWtq?=
 =?utf-8?B?NWhQdmNPakNOeXM2Tk92TnEzWUJFVWM4SkhkTVFVMDRGVGx6bXBuVUk4Zld4?=
 =?utf-8?B?bUdjYzgrU3pqditjQmoxTVdRWUJadVVER0JabXBNNXhObWl3UE9MOE5RNHN0?=
 =?utf-8?B?Zm5oL3pMV244MExMdG51SXhGVHl6VDZ0SHhTeFBIZU14Q1YyRkYxQ2ZiSlhw?=
 =?utf-8?B?MGxCdjhpV3JmV3RDc3B3Wm9MTkVYTVczaDBKVjhKSHowVkdBVTdpRG92clZh?=
 =?utf-8?B?MGFIaTZZcUptRklkYlRPbGV3Ykl2dUIzNVFlVHBhdCt1alhsSWdzNDRRWlB6?=
 =?utf-8?B?WXJCSjVPS0Ric2tOVVVqcGZuNGdyZ3I3MDdRSzZvK3M5NjR0Nnk0eFJyU1px?=
 =?utf-8?B?anpQeHZaRUhvOXBjSW90a2NYd2M4d202ZXoyTEt1dUdSSU50aGw1ZDdZbFZL?=
 =?utf-8?B?NVRjbHg3K0tQK1BuR3Vsa0pDMllMRE55ekx4Wi9UbElUQ1p5YzVJbzJ1d2Fu?=
 =?utf-8?B?WXJlOFZ0cE50UTdzMHZuMlhBVlB2QngwQ2hLTkdXVmRNSmw0ZlQ4WTV6dStD?=
 =?utf-8?B?U0pyQ3E4bWZtQktXN0c4dmZGYnVxQnNwajR5QWlQYm1pYWpnT09Lc3dDbWpv?=
 =?utf-8?B?SXdCQmwwQXRMM0hMZXRJYS9ZVUhCRmZPSzhQNzh0bGxUY0psRmdldGJwekpE?=
 =?utf-8?B?N1Zia1AxQUNFcjJYc0dLOEhRa0VBekk1elZoY0o2Qm1qVk1BODkrM1lYK3hQ?=
 =?utf-8?B?MkhtT0hvTk9IRThvUmYrY0x2ejJZWHpxemlwWGdsY3pwVUNGU2dPdE0yV3FQ?=
 =?utf-8?B?T1NUVDM5VGxOclBkQitZVUV5cE5wa2lMdG41aUhId2F4ekRvZnduOEdHTXBh?=
 =?utf-8?B?S0pZcDRETCtoa1VoZ0UrU1hxbEZzaTZrbGpWU2xDTkhvN0cwS1MrY3k5anhx?=
 =?utf-8?B?WUVYaDJOOENqcmJqcHprUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWcxM1VYdGgxUmZqbEx3MmlzVzlPY3BtaXZKWWQzWk1JbkNLOEFIRzhiK2tu?=
 =?utf-8?B?VzlBNzFSRTNRMWhCYmxlaDNWVXJsK3RKMXBGckd3WUwxL1VBMjBySURuT0o2?=
 =?utf-8?B?YjExbHNWeHFkZGFNcEFNWXVjMWFxNFNWSDZHUTk0aERrYWxBVkNub0JJS0tP?=
 =?utf-8?B?OXdCdDFJZUhRSmMyK2phQ3ltZ3JMYXdZWTlYbERoSUw2Q1RERmovRk80bGo0?=
 =?utf-8?B?UlhwWWNGL09zbDBYMjRMK251VHdiWms4aGo4L25ISHY2RDJ0WEZ6bnZVbE4w?=
 =?utf-8?B?c1hGL1I0aE1NK3dKQzJBWklZN3VVU0prejNpTW5lVys4MmlaVXBzQlpwaWlw?=
 =?utf-8?B?WHgxU01IYVRsYmo3R1pmUGhiWEF1enYvK251bUZyeFdFL0ViZ1JheHhqZUZB?=
 =?utf-8?B?eEF3bENRZXhPd1VpUzU2ZHhGNjI0SnJGckxUdUxtUmxhcmtLMkowSEtwNlB5?=
 =?utf-8?B?Q2crN2tkelJWL0NuSHhuenlabjBKUFFjcWsrYUZScENBcWZ5c0lIb1Q0L0hr?=
 =?utf-8?B?M1luVjNWNjAyY25melFLb0UyYmsxYi8zS0pycnJkb1RCZ2ZHTW9HRTh1ZGl3?=
 =?utf-8?B?dlFjaFphYWxtd3IyR1I5VEh5WXNUbUE0WHQzMkI3NGtyWjdvTDl3YmZiaHhF?=
 =?utf-8?B?TlczeXduR3dLRDk5bFVZZEVVYVZ3TnVWUWEzK0NKYUZTVGFpK2o1RE53b1Ev?=
 =?utf-8?B?cHdpemhubWFIQnNMUU0xSFJtaFh0Zm1wZkhhaU8rTSt2V0Vlb1RFb1Z5RFlr?=
 =?utf-8?B?VkZQMWxiSXZyQzgwN0ZMbVhlOWREbFE4UzhJRXBUbjJMcVJVYzB5Y3F1VkZW?=
 =?utf-8?B?Z2RnS01odHZmRFROVnprQVp1WTRrVWRHOVRaSjZhcVFYdklkT0V2TEZzY0xS?=
 =?utf-8?B?clc4dThDeUZiY0x5TWlBV01oanR0RWdFbHF2eGxaR1lVcWZuU05FVWk3VHdi?=
 =?utf-8?B?SG8vUG1uNTB5amN3ZDI4SHFKK2JhdFVLT09sbCthWW9rRFhSZkF4MzJjaVhQ?=
 =?utf-8?B?SUhCaEJITUxCbXNoK3FVeEhFaWZnVjEvbGY0YzZWMGlWM3ErNU4zS2Q1Z1Vu?=
 =?utf-8?B?YzN5dng2UU5CeEJiNG53bVdTemlzSm5CRFBXNnRHa1FqUlk0MmcrMitvamIz?=
 =?utf-8?B?RzhQY0g1ZDFKdWJya0V5ZEdxTFlITUxuSWlQZzRnbTBUYU9weElVUG9sNGMv?=
 =?utf-8?B?djhtVEFzZzNFUVN6QnFVMCtFNk9ISGVIMHhvZHNwZjVLRkc2ZHFwNnhibWxs?=
 =?utf-8?B?c1FISVZQU2RETkp1OVp3Y3l6Mk40VWFWWE1jMm8vczY2Yk1kZDdiNlFYMmN4?=
 =?utf-8?B?TUF5VWh1b3QyYTYzazIyOE1LcVlnRHBlbTdWcWhwR2VqYm9kOHNHU3ZIY2d1?=
 =?utf-8?B?Z1p4R1JJRmtOZ2src3Z6Vk1oSnVjVGwvc2JCRURmRitzZDN6dUh3czFINmkr?=
 =?utf-8?B?KzNCamJ1cXVRaU81aGg1U1pZVzVibDJ4dzN2eE5TM2RsOFdKaEhhQkVyVUhG?=
 =?utf-8?B?STRoUzM0RzRVWFFaeWNKZ1BQQlBLWU9SYVJuM3IvWU56TzZuUU1tMnNrSkVo?=
 =?utf-8?B?RzFkWUx2VTg0MUpSelBhUzJhNWF6NW11NzVVNEFlbTVWeDhZY2sxTU9xdnFw?=
 =?utf-8?B?TFFySzdiZWIvdUtLVTd4OUc4Vy9qa1NvZDBIMGJTejFPdVhyRU53ZDdERTN6?=
 =?utf-8?B?UWozSXV3anRHb3NFdk1raXVDdTJKMVhRSnpPckhJYjVBY05HYTQzK2NZazVZ?=
 =?utf-8?B?VHE2TWlIREd4Rm5vQTJCWGtMeW1RSGlZektpMU9lWjEyOFNJU3ZoYWdNVjB2?=
 =?utf-8?B?QTgvT1BtZklKSkFSbXUxelBabG1xdllFNnY2R0dTb01RM3U1bzZ2UjJPcnN0?=
 =?utf-8?B?Zy91Nm5aajdoT1lVNE5BRmllUCtmTXZib0xLZkVJRHB6TS9WamxjdHY4blly?=
 =?utf-8?B?dDRCVk5pRmZUQ3ZyOGN2WDhRQk9hVmY2S3drYVpUYmdOejlIcWVybGpLN1pR?=
 =?utf-8?B?TjNkQzhHdE5tQUdqZXFCUmplK1Fmbmo5UC94RUJ3U0JiRlpFSEJkQWNIYXd0?=
 =?utf-8?B?bkpkb3V3RWVRdThPOWd6bWJORDFCZjVVR1VUSlB2TUFsTGhOUC94R0cycTFN?=
 =?utf-8?Q?3oUI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6328f02-8021-43b7-0c13-08dcd0ffc90f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 18:46:59.5869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roR5MRjTioPWU5piU8F3Rai3iB+WMsDvQ8OTkvQKy67Nj50I+gTeqQ3MEr9Ip50U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6443
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

Am 09.09.24 um 18:02 schrieb Kim, Jonathan:
> [Public]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Thursday, September 5, 2024 10:24 AM
>> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: fix vm-pasid lookup for multiple partitions
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> Am 19.08.24 um 19:59 schrieb Jonathan Kim:
>>> Currently multiple partitions will incorrectly overwrite the VM lookup
>>> table since the table is indexed by PASID and multiple partitions can
>>> register different VM objects on the same PASID.
>> That's a rather bad idea. Why do we have the same PASID for different VM
>> objects in the first place?
> Alex can probably elaborate on the KGD side, but from what I can see, the KMS driver open call has always assigned a new VM object per PASID on an open call.
> The KFD acquires and replaces the KGD PASID-VMID registration on its own compute process open/creation call.
> If this is the bad_idea you're referring to, then someone else will have to chime in.  I don't have much history on this unfortunately.

Yeah, Felix and I designed that.

> That aside, the current problem is, is that all KFD device structures are logical partitions and register their PASID-VM binding using this concept of a device.

As far as I can see that is the fundamental problem. This needs to be 
fixed instead.

> On the KGD side however, the registration table is maintained in the adev struct, which is a physical socket.
> So there's a mismatch in understanding of what a device is between the KFD & KGD with regard to the look up table that results in bad bindings.
>
> Adding a per-partition dimension to the existing lookup table resolves issues where seeing, for example, with memory violation interception and XNACK i.e bad bindings result in wrong vm object found to set no-retry flags on memory violations.

Yeah that is pretty much a no-go.

The PASID and how it is used is defined by the PCIe specifications. If 
we now start to assign multiple VMs to the same PASID then we are 
violating the PCIe specification.

The problems you see are most likely just the tip of the iceberg here.

Regards,
Christian.

>
> Jon
>
>> Regards,
>> Christian.
>>
>>> This results in loading the wrong VM object on PASID query.
>>>
>>> To correct this, setup the lookup table to be per-partition-per-PASID
>>> instead.
>>>
>>> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 12 ++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  4 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  7 ++-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 55 +++++++++++------
>> --
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 11 +++-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  3 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  5 +-
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 16 ++----
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |  2 +-
>>>    drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  4 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  3 +-
>>>    .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  |  8 +--
>>>    .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  8 +--
>>>    drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c   |  3 +-
>>>    18 files changed, 92 insertions(+), 65 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index c272461d70a9..28db789610e1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -887,3 +887,15 @@ int amdgpu_amdkfd_unmap_hiq(struct
>> amdgpu_device *adev, u32 doorbell_off,
>>>        return r;
>>>    }
>>> +
>>> +int amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device *adev,
>> uint32_t node_id)
>>> +{
>>> +     if (adev->gfx.funcs->ih_node_to_logical_xcc) {
>>> +             int xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev, node_id);
>>> +
>>> +             if (xcc_id >= 0)
>>> +                     return xcc_id;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> index 4ed49265c764..bf8bb45d8ab6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>> @@ -356,6 +356,7 @@ void amdgpu_amdkfd_unreserve_mem_limit(struct
>> amdgpu_device *adev,
>>>                uint64_t size, u32 alloc_flag, int8_t xcp_id);
>>>
>>>    u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int
>> xcp_id);
>>> +int amdgpu_amdkfd_node_id_to_xcc_id(struct amdgpu_device *adev,
>> uint32_t node_id);
>>>    #define KFD_XCP_MEM_ID(adev, xcp_id) \
>>>                ((adev)->xcp_mgr && (xcp_id) >= 0 ?\
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index c6a1783fc9ef..bf9f8802e18d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -37,7 +37,7 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>        struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>        struct amdgpu_task_info *ti;
>>>        struct amdgpu_device *adev = ring->adev;
>>> -     int idx;
>>> +     int idx, xcp_id = !job->vm ? 0 : job->vm->xcp_id;
>>>        int r;
>>>
>>>        if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
>>> @@ -62,7 +62,7 @@ static enum drm_gpu_sched_stat
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>                job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
>>>                ring->fence_drv.sync_seq);
>>>
>>> -     ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>>> +     ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid, xcp_id);
>>>        if (ti) {
>>>                dev_err(adev->dev,
>>>                        "Process information: process %s pid %d thread %s pid %d\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index d9fde38f6ee2..e413bf4a3e84 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1275,17 +1275,20 @@ int amdgpu_info_ioctl(struct drm_device *dev,
>> void *data, struct drm_file *filp)
>>>                struct amdgpu_vm *vm = &fpriv->vm;
>>>                struct drm_amdgpu_info_gpuvm_fault gpuvm_fault;
>>>                unsigned long flags;
>>> +             int i;
>>>
>>>                if (!vm)
>>>                        return -EINVAL;
>>>
>>>                memset(&gpuvm_fault, 0, sizeof(gpuvm_fault));
>>>
>>> -             xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>> +             for (i = 0; i < adev->xcp_mgr->num_xcps; i++)
>>> +                     xa_lock_irqsave(&adev->vm_manager.pasids[i], flags);
>>>                gpuvm_fault.addr = vm->fault_info.addr;
>>>                gpuvm_fault.status = vm->fault_info.status;
>>>                gpuvm_fault.vmhub = vm->fault_info.vmhub;
>>> -             xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>> +             for (i = 0; i < adev->xcp_mgr->num_xcps; i++)
>>> +                     xa_unlock_irqrestore(&adev->vm_manager.pasids[i], flags);
>>>
>>>                return copy_to_user(out, &gpuvm_fault,
>>>                                    min((size_t)size, sizeof(gpuvm_fault))) ? -EFAULT : 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index bcb729094521..f43e1c15f423 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -146,7 +146,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>>                return 0;
>>>
>>>        if (vm->pasid) {
>>> -             r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
>>> +             r = xa_err(xa_erase_irq(&adev->vm_manager.pasids[vm->xcp_id],
>> vm->pasid));
>>>                if (r < 0)
>>>                        return r;
>>>
>>> @@ -154,7 +154,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>>        }
>>>
>>>        if (pasid) {
>>> -             r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
>>> +             r = xa_err(xa_store_irq(&adev->vm_manager.pasids[vm->xcp_id],
>> pasid, vm,
>>>                                        GFP_KERNEL));
>>>                if (r < 0)
>>>                        return r;
>>> @@ -2288,14 +2288,14 @@ static void
>> amdgpu_vm_destroy_task_info(struct kref *kref)
>>>    }
>>>
>>>    static inline struct amdgpu_vm *
>>> -amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
>>> +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid,
>> u32 xcp_id)
>>>    {
>>>        struct amdgpu_vm *vm;
>>>        unsigned long flags;
>>>
>>> -     xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>> -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> -     xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>> +     xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], flags);
>>> +     vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>> +     xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], flags);
>>>
>>>        return vm;
>>>    }
>>> @@ -2343,10 +2343,10 @@ amdgpu_vm_get_task_info_vm(struct
>> amdgpu_vm *vm)
>>>     * referenced down with amdgpu_vm_put_task_info.
>>>     */
>>>    struct amdgpu_task_info *
>>> -amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid,
>> u32 xcp_id)
>>>    {
>>>        return amdgpu_vm_get_task_info_vm(
>>> -                     amdgpu_vm_get_vm_from_pasid(adev, pasid));
>>> +                     amdgpu_vm_get_vm_from_pasid(adev, pasid, xcp_id));
>>>    }
>>>
>>>    static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
>>> @@ -2481,6 +2481,8 @@ int amdgpu_vm_init(struct amdgpu_device
>> *adev, struct amdgpu_vm *vm,
>>>        amdgpu_bo_unreserve(vm->root.bo);
>>>        amdgpu_bo_unref(&root_bo);
>>>
>>> +     vm->xcp_id = xcp_id < 0 ? 0 : xcp_id;
>>> +
>>>        return 0;
>>>
>>>    error_free_root:
>>> @@ -2695,8 +2697,8 @@ void amdgpu_vm_manager_init(struct
>> amdgpu_device *adev)
>>>    #else
>>>        adev->vm_manager.vm_update_mode = 0;
>>>    #endif
>>> -
>>> -     xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>>> +     for (i = 0; i < MAX_XCP; i++)
>>> +             xa_init_flags(&(adev->vm_manager.pasids[i]),
>> XA_FLAGS_LOCK_IRQ);
>>>    }
>>>
>>>    /**
>>> @@ -2708,10 +2710,15 @@ void amdgpu_vm_manager_init(struct
>> amdgpu_device *adev)
>>>     */
>>>    void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>>>    {
>>> -     WARN_ON(!xa_empty(&adev->vm_manager.pasids));
>>> -     xa_destroy(&adev->vm_manager.pasids);
>>> +     int i;
>>> +
>>> +     for (i = 0; i < MAX_XCP; i++) {
>>> +             WARN_ON(!xa_empty(&adev->vm_manager.pasids[i]));
>>> +             xa_destroy(&adev->vm_manager.pasids[i]);
>>> +     }
>>>
>>>        amdgpu_vmid_mgr_fini(adev);
>>> +
>>>    }
>>>
>>>    /**
>>> @@ -2778,17 +2785,18 @@ bool amdgpu_vm_handle_fault(struct
>> amdgpu_device *adev, u32 pasid,
>>>        unsigned long irqflags;
>>>        uint64_t value, flags;
>>>        struct amdgpu_vm *vm;
>>> -     int r;
>>> +     int r, xcp_id;
>>>
>>> -     xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
>>> -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> +     xcp_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id)/adev-
>>> gfx.num_xcc_per_xcp;
>>> +     xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], irqflags);
>>> +     vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>        if (vm) {
>>>                root = amdgpu_bo_ref(vm->root.bo);
>>>                is_compute_context = vm->is_compute_context;
>>>        } else {
>>>                root = NULL;
>>>        }
>>> -     xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>>> +     xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], irqflags);
>>>
>>>        if (!root)
>>>                return false;
>>> @@ -2806,11 +2814,11 @@ bool amdgpu_vm_handle_fault(struct
>> amdgpu_device *adev, u32 pasid,
>>>                goto error_unref;
>>>
>>>        /* Double check that the VM still exists */
>>> -     xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
>>> -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> +     xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], irqflags);
>>> +     vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>        if (vm && vm->root.bo != root)
>>>                vm = NULL;
>>> -     xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
>>> +     xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], irqflags);
>>>        if (!vm)
>>>                goto error_unlock;
>>>
>>> @@ -2968,14 +2976,15 @@ void amdgpu_vm_update_fault_cache(struct
>> amdgpu_device *adev,
>>>                                  unsigned int pasid,
>>>                                  uint64_t addr,
>>>                                  uint32_t status,
>>> -                               unsigned int vmhub)
>>> +                               unsigned int vmhub,
>>> +                               uint32_t xcp_id)
>>>    {
>>>        struct amdgpu_vm *vm;
>>>        unsigned long flags;
>>>
>>> -     xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>>> +     xa_lock_irqsave(&adev->vm_manager.pasids[xcp_id], flags);
>>>
>>> -     vm = xa_load(&adev->vm_manager.pasids, pasid);
>>> +     vm = xa_load(&adev->vm_manager.pasids[xcp_id], pasid);
>>>        /* Don't update the fault cache if status is 0.  In the multiple
>>>         * fault case, subsequent faults will return a 0 status which is
>>>         * useless for userspace and replaces the useful fault status, so
>>> @@ -3008,7 +3017,7 @@ void amdgpu_vm_update_fault_cache(struct
>> amdgpu_device *adev,
>>>                        WARN_ONCE(1, "Invalid vmhub %u\n", vmhub);
>>>                }
>>>        }
>>> -     xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>>> +     xa_unlock_irqrestore(&adev->vm_manager.pasids[xcp_id], flags);
>>>    }
>>>
>>>    /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index 046949c4b695..1499f5f731e9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -35,6 +35,7 @@
>>>    #include "amdgpu_sync.h"
>>>    #include "amdgpu_ring.h"
>>>    #include "amdgpu_ids.h"
>>> +#include "amdgpu_xcp.h"
>>>
>>>    struct drm_exec;
>>>
>>> @@ -418,6 +419,9 @@ struct amdgpu_vm {
>>>
>>>        /* cached fault info */
>>>        struct amdgpu_vm_fault_info fault_info;
>>> +
>>> +     /* XCP ID */
>>> +     int xcp_id;
>>>    };
>>>
>>>    struct amdgpu_vm_manager {
>>> @@ -456,7 +460,7 @@ struct amdgpu_vm_manager {
>>>        /* PASID to VM mapping, will be used in interrupt context to
>>>         * look up VM of a page fault
>>>         */
>>> -     struct xarray                           pasids;
>>> +     struct xarray                           pasids[MAX_XCP];
>>>        /* Global registration of recent page fault information */
>>>        struct amdgpu_vm_fault_info     fault_info;
>>>    };
>>> @@ -550,7 +554,7 @@ bool amdgpu_vm_need_pipeline_sync(struct
>> amdgpu_ring *ring,
>>>    void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>
>>>    struct amdgpu_task_info *
>>> -amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
>>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid,
>> u32 xcp_id);
>>>    struct amdgpu_task_info *
>>>    amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>>> @@ -649,7 +653,8 @@ void amdgpu_vm_update_fault_cache(struct
>> amdgpu_device *adev,
>>>                                  unsigned int pasid,
>>>                                  uint64_t addr,
>>>                                  uint32_t status,
>>> -                               unsigned int vmhub);
>>> +                               unsigned int vmhub,
>>> +                               uint32_t xcp_id);
>>>    void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>>>                                 struct amdgpu_vm *vm,
>>>                                 struct dma_fence **fence);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index f0ceab3ce5bf..24b042febf5c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -151,7 +151,8 @@ static int gmc_v10_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>
>>>                amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>>> -                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0));
>>> +                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0),
>>> +                                          0);
>>>        }
>>>
>>>        if (!printk_ratelimit())
>>> @@ -161,7 +162,7 @@ static int gmc_v10_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>                entry->vmid_src ? "mmhub" : "gfxhub",
>>>                entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>>> -     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>        if (task_info) {
>>>                dev_err(adev->dev,
>>>                        " in process %s pid %d thread %s pid %d\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 2797fd84432b..3507046d33e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -122,7 +122,8 @@ static int gmc_v11_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>
>>>                amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>>> -                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0));
>>> +                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0),
>>> +                                          0);
>>>        }
>>>
>>>        if (printk_ratelimit()) {
>>> @@ -132,7 +133,7 @@ static int gmc_v11_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>                        entry->vmid_src ? "mmhub" : "gfxhub",
>>>                        entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>>> -             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>                if (task_info) {
>>>                        dev_err(adev->dev,
>>>                                " in process %s pid %d thread %s pid %d)\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index 60acf676000b..9844564c6c74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -115,7 +115,8 @@ static int gmc_v12_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>
>>>                amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>>> -                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0));
>>> +                                          entry->vmid_src ? AMDGPU_MMHUB0(0) :
>> AMDGPU_GFXHUB(0),
>>> +                                          0);
>>>        }
>>>
>>>        if (printk_ratelimit()) {
>>> @@ -125,7 +126,7 @@ static int gmc_v12_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>>                        entry->vmid_src ? "mmhub" : "gfxhub",
>>>                        entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>>> -             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>                if (task_info) {
>>>                        dev_err(adev->dev,
>>>                                " in process %s pid %d thread %s pid %d)\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 994432fb57ea..2cdb0cbb7c4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -1268,7 +1268,8 @@ static int gmc_v7_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                return 0;
>>>
>>>        amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>> -                                  ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>> AMDGPU_GFXHUB(0));
>>> +                                  ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>> +                                  AMDGPU_GFXHUB(0), 0);
>>>
>>>        if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
>>>                gmc_v7_0_set_fault_enable_default(adev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index 86488c052f82..6855caeb7f74 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1437,7 +1437,8 @@ static int gmc_v8_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                return 0;
>>>
>>>        amdgpu_vm_update_fault_cache(adev, entry->pasid,
>>> -                                  ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>> AMDGPU_GFXHUB(0));
>>> +                                  ((u64)addr) << AMDGPU_GPU_PAGE_SHIFT, status,
>>> +                                  AMDGPU_GFXHUB(0), 0);
>>>
>>>        if (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_FIRST)
>>>                gmc_v8_0_set_fault_enable_default(adev, false);
>>> @@ -1448,7 +1449,7 @@ static int gmc_v8_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>>>                        entry->src_id, entry->src_data[0]);
>>>
>>> -             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +             task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>                if (task_info) {
>>>                        dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
>>>                                task_info->process_name, task_info->tgid,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index b73136d390cc..e183e08b2c02 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -556,10 +556,12 @@ static int gmc_v9_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>        unsigned int vmhub;
>>>        u64 addr;
>>>        uint32_t cam_index = 0;
>>> -     int ret, xcc_id = 0;
>>> -     uint32_t node_id;
>>> +     int ret;
>>> +     uint32_t node_id, xcc_id, xcp_id;
>>>
>>>        node_id = entry->node_id;
>>> +     xcc_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, node_id);
>>> +     xcp_id = xcc_id/adev->gfx.num_xcc_per_xcp;
>>>
>>>        addr = (u64)entry->src_data[0] << 12;
>>>        addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>> @@ -572,12 +574,6 @@ static int gmc_v9_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                vmhub = AMDGPU_MMHUB1(0);
>>>        } else {
>>>                hub_name = "gfxhub0";
>>> -             if (adev->gfx.funcs->ih_node_to_logical_xcc) {
>>> -                     xcc_id = adev->gfx.funcs->ih_node_to_logical_xcc(adev,
>>> -                             node_id);
>>> -                     if (xcc_id < 0)
>>> -                             xcc_id = 0;
>>> -             }
>>>                vmhub = xcc_id;
>>>        }
>>>        hub = &adev->vmhub[vmhub];
>>> @@ -631,7 +627,7 @@ static int gmc_v9_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>                retry_fault ? "retry" : "no-retry",
>>>                entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>>>
>>> -     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid,
>> xcp_id);
>>>        if (task_info) {
>>>                dev_err(adev->dev,
>>>                        " for process %s pid %d thread %s pid %d)\n",
>>> @@ -675,7 +671,7 @@ static int gmc_v9_0_process_interrupt(struct
>> amdgpu_device *adev,
>>>        if (!amdgpu_sriov_vf(adev))
>>>                WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>>>
>>> -     amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>> vmhub);
>>> +     amdgpu_vm_update_fault_cache(adev, entry->pasid, addr, status,
>> vmhub, xcp_id);
>>>        dev_err(adev->dev,
>>>                "VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index 23ef4eb36b40..1ac4224bbe5b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -2182,7 +2182,7 @@ static int sdma_v4_0_print_iv_entry(struct
>> amdgpu_device *adev,
>>>                           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>>                           entry->pasid);
>>>
>>> -     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid, 0);
>>>        if (task_info) {
>>>                dev_dbg_ratelimited(adev->dev,
>>>                                    " for process %s pid %d thread %s pid %d\n",
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 57f16c09abfc..c8b5c0302ca7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1683,6 +1683,8 @@ static int sdma_v4_4_2_print_iv_entry(struct
>> amdgpu_device *adev,
>>>        int instance;
>>>        struct amdgpu_task_info *task_info;
>>>        u64 addr;
>>> +     uint32_t xcc_id = amdgpu_amdkfd_node_id_to_xcc_id(adev, entry-
>>> node_id);
>>> +     uint32_t xcp_id = xcc_id/adev->gfx.num_xcc_per_xcp;
>>>
>>>        instance = sdma_v4_4_2_irq_id_to_seq(adev, entry->client_id);
>>>        if (instance < 0 || instance >= adev->sdma.num_instances) {
>>> @@ -1698,7 +1700,7 @@ static int sdma_v4_4_2_print_iv_entry(struct
>> amdgpu_device *adev,
>>>                            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>>                            entry->pasid);
>>>
>>> -     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +     task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid,
>> xcp_id);
>>>        if (task_info) {
>>>                dev_dbg_ratelimited(adev->dev, " for process %s pid %d thread %s
>> pid %d\n",
>>>                                    task_info->process_name, task_info->tgid,
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index ea3792249209..c098fbaf0e1c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -1262,8 +1262,9 @@ void kfd_signal_reset_event(struct kfd_node
>> *dev)
>>>                if (dev->dqm->detect_hang_count) {
>>>                        struct amdgpu_task_info *ti;
>>> +                     uint32_t xcp_id = dev->xcp ? dev->xcp->id : 0;
>>>
>>> -                     ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
>>> +                     ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid,
>> xcp_id);
>>>                        if (ti) {
>>>                                dev_err(dev->adev->dev,
>>>                                        "Queues reset on process %s tid %d thread %s pid %d\n",
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>> index 8e0d0356e810..d7cbf9525698 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
>>> @@ -377,12 +377,8 @@ static void event_interrupt_wq_v10(struct
>> kfd_node *dev,
>>>                struct kfd_hsa_memory_exception_data exception_data;
>>>
>>>                /* gfxhub */
>>> -             if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
>>> -                     hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev-
>>> adev,
>>> -                             node_id);
>>> -                     if (hub_inst < 0)
>>> -                             hub_inst = 0;
>>> -             }
>>> +             if (!vmid_type)
>>> +                     hub_inst = amdgpu_amdkfd_node_id_to_xcc_id(dev->adev,
>> node_id);
>>>                /* mmhub */
>>>                if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> index a9c3580be8c9..4708b8c811a5 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
>>> @@ -437,12 +437,8 @@ static void event_interrupt_wq_v9(struct
>> kfd_node *dev,
>>>                struct kfd_hsa_memory_exception_data exception_data;
>>>
>>>                /* gfxhub */
>>> -             if (!vmid_type && dev->adev->gfx.funcs->ih_node_to_logical_xcc) {
>>> -                     hub_inst = dev->adev->gfx.funcs->ih_node_to_logical_xcc(dev-
>>> adev,
>>> -                             node_id);
>>> -                     if (hub_inst < 0)
>>> -                             hub_inst = 0;
>>> -             }
>>> +             if (!vmid_type)
>>> +                     hub_inst = amdgpu_amdkfd_node_id_to_xcc_id(dev->adev,
>> node_id);
>>>                /* mmhub */
>>>                if (vmid_type && client_id == SOC15_IH_CLIENTID_VMC)
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> index ea6a8e43bd5b..b5f2f5b1069c 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> @@ -251,8 +251,9 @@ void
>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>>    void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>>>    {
>>>        struct amdgpu_task_info *task_info;
>>> +     uint32_t xcp_id = dev->xcp ? dev->xcp->id : 0;
>>>
>>> -     task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>>> +     task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid, xcp_id);
>>>        if (task_info) {
>>>                /* Report VM faults from user applications, not retry from kernel */
>>>                if (task_info->pid)

