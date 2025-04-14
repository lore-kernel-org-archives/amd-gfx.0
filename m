Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF719C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D10610E22A;
	Mon, 14 Apr 2025 17:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r1kr665b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AC010E22A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:36:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaLHA6tuzSjfi98+U5gQyycmd6iDOIRLw3tqlFcybsgr/gFrpNzGKNE3X5VMLuvsxSJiVz+NIF08a9NCpn1eDQqfuDW1wC4P+J651CJxeocfphjsZ659XoHrKc6grjdb1nbGD7AAvki2GVN81kKuX/sF3C/te+qPR9rnr6I2sK9oAZ1a/8oGGh+xu/EBj0fOIrRrBXaYTPW0XaiDbZ7uepar+5t9zSFQoeX/0u0nsEL+sMYVsrrsMv+56irsp5IaFrRzAuvzgMhtKL5WTlanSY9nVe702Qi00Zp3GbSAHIK+6COtHA1mKpy7mashlBB2IOu3wyp3kJGByE9PeaQg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhUx47togj6UOytMLLV/yGeqEJIY5NCQ2hyx0SKNBdI=;
 b=YqbQqkBYZ71xRKetQoTurnU5cvx44rrySw1EfjoyiROD1eFgbDHCFHZOkjic+mG17SC9XVvp6Q2q+jpyaGkDrHoXGkdNhrofrn0qgIE4lS6Rz/iq/1dBchnGzh4KRRuIyEYY8yhc+E3Lac1GJdVA3iRcXkN4Z2jG0beujNmtBxWk+EL3irMdh5RDi8NJOpNPQYjAQjpWudJKmzgjzmjpjwKOUlK9evohOXNInKk7ysY11Z0HDW/Juh12g+1u96HcacD4ZRvN6kAN3bs46OFmt9tbLMWyW7YKw1rKtNPMOVHRwus4isTUhZhDui9Ygt1l+jXO5GarHwcMhBDr64hPzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhUx47togj6UOytMLLV/yGeqEJIY5NCQ2hyx0SKNBdI=;
 b=r1kr665beNpoieZmN4SXx6g8vYxZwIXEGr9BDgnAaW6IoJ5oaQu6K1bCFtdR4QeC1zJzSNAnWgxZUzY5YWBlYSnXtJl0FFAJOU9vywbg2lP+CECWRc1cIHFkGC8f2BGZmFkExW1kGqqOJj0Y5v5IZ/Uly8Xuy0X8umO6umaVQik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 17:35:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:35:59 +0000
Message-ID: <35eb9c0f-da56-4e27-be10-dfd24582b9c8@amd.com>
Date: Mon, 14 Apr 2025 23:05:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/sdma7: properly reference trap interrupts for
 userqs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <20250413160608.2198429-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250413160608.2198429-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0037.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:271::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: b3289602-44bf-4a3c-2c2d-08dd7b7ad186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHBkUjMvMlpiMGtFaHRyRUJRcm45d2YreklGNUxMeXdPNWxSLzdZM2UwUkg4?=
 =?utf-8?B?bjF2aU52ZGJaWkNmZFRPNHBlZmRmenJWUElOUldJU1JYMjBRZUcxcXpKb2xu?=
 =?utf-8?B?dmhuY1FFNnlveUZYWm02ZEJGMFc2clN5VVVkSEI1d0Y4VkJ2aXVWa0lVQ0l6?=
 =?utf-8?B?OWs5MUZ5a1JSTzU4bTNnWFJFV0s0ajlQNjA0MFh5UjhTd1NXVmlScVhmQ0E0?=
 =?utf-8?B?anVWZExkVFdVcHljcjI5Y1BMYngwYXhRR0FvQ3pXalpLbFFIT1o3MnJCeVNB?=
 =?utf-8?B?Vzg0OWhTMWRYTnNHV01KcWQzZWZYVkY5MXRWb3NwU0lkRFdTaFlqQjlXTXRj?=
 =?utf-8?B?cnVucERCNEFDT3lqblRVd3E5SFJrR2g3ZE00bU5NbHkvazQ5WDJMdlZwMllO?=
 =?utf-8?B?cEJvcldpbk1JWkVZa0JwMzdFZFgwVlFadTRJVjgycTRDUHBSMGkvNnAvaFho?=
 =?utf-8?B?Qkgwck1wTWVjN2JJQlZmTnd1WTkrV2xoMTJ0MThja1NORnhDZmMrVTFkOFps?=
 =?utf-8?B?NlcrNGFIbDJ5MnU1cWFjUThZTUhiU0IxU1hPcmlpdFY3Y1NtZ0RnR2F6cjYz?=
 =?utf-8?B?RmI4dkN6OXo1VzR6cUQ0MkVUSjZjWStIaERkdUFpRlFXS1FxK1hBMmJYYzlJ?=
 =?utf-8?B?NXNIV1VaRlQ4SnpRaTRlS0UxK3ljZjVyUTB0YkVvY3RGUFJDdmJRd1Axa3dp?=
 =?utf-8?B?T1hhemRZYTh6R09zSktZZ0l3OU00R3laNUxBb3dBZjN0dGgvMnp5dm5iOEhZ?=
 =?utf-8?B?ZTcrY2RBYzhNb29XSGxMSGROdTRYSGlJbUo2M0wxRkludU5MbDdKMDVjMXJa?=
 =?utf-8?B?NmZ0bis2dmY3TUNTYnJWWlVyd1lyOWs3Smt3U3A0Rlh4eHVCYmw4MmZtbmc3?=
 =?utf-8?B?RmptQTdtZEJxdVJ3bGxra09VSEN4bFB3Rlhkdm1xajg4VG43bkFLNzh4RzVT?=
 =?utf-8?B?VmNCTzFUNzNZWk9ESGN5Y3pQYTdoSGlQMFYyV3g4ekdVRUdEd1o0U3JVUWdu?=
 =?utf-8?B?V3lWUlJkQzNkVGtaWnV6MWZibEVhZVNTandOR0F3TURZVUtRSXNyNW10TWh0?=
 =?utf-8?B?dmxPQ2RLNlU0QUdXbzI0RDRScVRvY2UySE9OTkdnVDZETEVqSDIyNWhKb095?=
 =?utf-8?B?QndUR2VybEtXdFlXU0FrcnQvc25TTmhQMEZkaWRXQTVZQVNTaHB1TFd1Zlgr?=
 =?utf-8?B?UGlDdTQ3R0IxVlhlSDN0M0Z4MUJ1RGNCMVUxa2RRRzU0ZHZuN1lMMVU1RmZp?=
 =?utf-8?B?Sk5zWWx6eWRmQlFVZUlUL2V6THZxK2hzQjB6U2ZhV0J6a0czcCtLVkpXVDdr?=
 =?utf-8?B?YVU4OThzNzhWV2s2SlBPeWdpZDRIcVJkNkdnaThIWkl0RWlXbHp4SS83Vmlh?=
 =?utf-8?B?OEtCSUExZXZ2UU8ybmNxQk1BZmEvS3hneUF1OEJzWTFyZ0xhYUJkd0s3eEtJ?=
 =?utf-8?B?VmM3NjN6Z2R0R3kwM2Y1Sm9yVVc0TFpxS05pYThpZDdLbHNUTkQ1bWh3eGd5?=
 =?utf-8?B?elgyN1hjbWpuUmF5WWVaUVl4NWM3VXN1aFdUT0UyWDh0RWdmR3NOWXZrSDd1?=
 =?utf-8?B?UU1VK1BTYzhia09IMXNMZ09XcUw3b2NxVFMvSnZMdDlBVWp5KzJOVVU5bGx4?=
 =?utf-8?B?ZnVuNmR5RitUZ1lHZ1RDMlVhMGREbGQ1YmU4elZXNE9WV1pJU1J4azhXcFlC?=
 =?utf-8?B?WG1rZ05tejliM2pxSVgydlFlUkpuOTJBZmNqWEhzKys5OXorSHVsd1dvQm5j?=
 =?utf-8?B?N0tmeG5HSFg4TmMxR05Fa0Q1c2lwTmVFVWlLdXZRSEVxQkhBRmdUOHY4Sk9a?=
 =?utf-8?B?WVNHVjZhN055WVZTdGhhcnAzK00yY2RVSjN4OXRMZG5UYUdnVXRxNUJkY0ky?=
 =?utf-8?B?bldxUk5IQ2hpTUtVbUpyRzZWbHErb1F5MDdneWJiQnRQeXNpRUE1SktCRUhx?=
 =?utf-8?Q?gzzkC7fF8Ns=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JCMW5nYTNaOUkxcTFMdVlYbFErWWtzTnlVamxHYURlUFd5bmZ0WmpUOEhZ?=
 =?utf-8?B?T2R3M21iZ2FpVTJDeDBpSldKbTIxUGlUMTF1MFo3YTdiV0VIaXlSQWY3ajc4?=
 =?utf-8?B?cGZJRzVRRDMxbzlJclZSOXNDZGVmYTJ0ZVpkaXZOeUxkTHd2T1VKbFNJRXZ3?=
 =?utf-8?B?U1lVNlhGWWp3TzBGb3NXSklJUXE3enZub2Y4YzIxWmlheUZSTmFQdjFGaDl0?=
 =?utf-8?B?NlFHWXB1MXRJYktRNjcvejRZak4vakdrcHk2dWR1ZzNWcGZua0ZIdlErWkM3?=
 =?utf-8?B?QVJrUUh4cC93R05oUE1qQUhpNUtuQXVvQ2RHOGM1MGdFYVBjZnNheEpnNVdS?=
 =?utf-8?B?WGk4dmI0TFkwYlJSRlpjajR3K2RYN2x1bmhUTXZJYzFCSEl3Q3pLY3lEc2xZ?=
 =?utf-8?B?VUZyZWtQT2kzVThld2REWUVTajlLREZ6NkVqQlVIWksrUnZPOGIwMnZaMmt3?=
 =?utf-8?B?MS9McHYvZEpURnMwUS9pWHJpbG5HekxTZ042d01NdDd1VFFoZTZuYW01b2Y3?=
 =?utf-8?B?Q1RpQ2o3MmNRcGFBdFJPa0h3bk43U1VIdnFqVzdweEtpYUZZQVJFVG5oZkV4?=
 =?utf-8?B?dFkzcDZwZVlnUEhHaHRFR2h4Qmp0OHZnZGtTVUlBTFNqSUJza1l1KzhIL3Nz?=
 =?utf-8?B?YzdCeE1oTjAyNk5vVWM4czR1SklEbFZJcGVwS0xmNXd2MWFmeldvTDVwdS9L?=
 =?utf-8?B?UG9Cb2V3WThucTFZd3c0NnVrQityT3l3KzRrWUNQOVpWNlBHS0k3Y1k3aGFX?=
 =?utf-8?B?YnovWFZuQndqUDBVbHJjUmZDKzh1dDlwVFRUTGs4REJieXhabGFteVBHa3pJ?=
 =?utf-8?B?dTdWdUJPaXVGOEt3L3ZwcTFydlB1WDhHQll2MzNnN2FhQTZlbDcwcUxwUlBa?=
 =?utf-8?B?NkdxWnlCQVdRMmQ3MWNtRXFPS3UyMkZFTXdQRUJiaEVVUzRvV25LbTdjZ2hK?=
 =?utf-8?B?NU15K3FKb1NmY1ZJa0xtSkR5Zkh3czhIYUluQmxuUDVEWE9VZ2lIMEgwR3N2?=
 =?utf-8?B?ZEt6NTc4SWlqK1RMR2FJWXR6WW9YMzRES3lxWmE2VXovYnoxcDRjSmdvUUpK?=
 =?utf-8?B?emliRE1BQUREbXg0bFRoSXVsWlcvUVdmQ3NBbDFBaHlmdXE4RjdDMTF5ZTVX?=
 =?utf-8?B?TkxKb0VMTHlNTldLWnhqNERBeEJ5WGJ3UURGY0phSThFWjU5MXh4dkRUckR0?=
 =?utf-8?B?anZ2dFJmbjQ5L0xDVTRnY2xJK1lRSjZCU2NYVnd3Z1hpNzBDd240L0E4Z2U4?=
 =?utf-8?B?SjNXL203cldwYTlla29CTWZFajNTU0t1elA2SHdmNitaNXhCeVVEVmxySCt6?=
 =?utf-8?B?OCtxV3pxYjBOUHJ4NEkwUCt6U0xTNkdHdVVIaXlTcHVWeStMMjNXZ29KbWlr?=
 =?utf-8?B?S3B6MjAvZlJCeFRia0VGS1llWFRHNEZOSDZSRzlUa3l6bjZmV1ZCTXhDM3hV?=
 =?utf-8?B?YXl2T0hNRDFUbHhpR0NHNk5pOE01QUhuUmxvcmpVYTkyMUh4cE9iK2FERGZ4?=
 =?utf-8?B?Z1lZdzZmUFBUaGNCdEhyMXowY3BtbXdHRUZHTjdoRWM3QVR0MmxtWWxGbEd0?=
 =?utf-8?B?S3RzZzFHQzhvemNYT3crRzI5YTNZNXlUekhRcHNaUk01MXVuNkw5amdNeXZk?=
 =?utf-8?B?TWYrNDRKMlIwbWJFSjdnMDcxRm1wUWhFRWJ0M2VGaTR0YWc1QWJ1bWZmUzhv?=
 =?utf-8?B?NXUrNG95eHRDY01nQWV5RENtUVlWVkgrOUNvSUpWRDdnZzh6Vm1pUTlBL3o4?=
 =?utf-8?B?bjU5VEIwS3E1NFNUM09Xd0R2QlRSaHJKRFluV0ZOd1g4V20yelpkR2lKQ0dR?=
 =?utf-8?B?Q2xCZ1lJbXFmN0kzNVgrNUE5NTRocXlCU3VVVHhMbm4ra3VYQXV1bko5T3ZV?=
 =?utf-8?B?cDRRMDE1cjZzaGlRN1lOVlFSQXd2S21tTU5LbkU3S1YyMkFFWmhPOE9ETUw1?=
 =?utf-8?B?bTJoRVIzRDhLZlR2NXZWWWdWTlp3NlVVbUZPTjYvditqY05yMzV2NisvUmdM?=
 =?utf-8?B?YlkyVDhyK0FCT255aEZoQktxaGRiVHhKajBmb3hUWTNyUGlpQWtGTERsTXhx?=
 =?utf-8?B?TUNTWncyTkFxNG43NFBmVkNmTFRxYlNQbklLVFIwNmQ5VUFZcmtGYUQwYVZV?=
 =?utf-8?Q?UlHlQlKAHJJIIV/oJXe1XwudW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3289602-44bf-4a3c-2c2d-08dd7b7ad186
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:35:59.1216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ1RkYtLSpKpvrsnQ7Pf7fd3WD6qNufbIhUlimDgvwqnGXCvTr547pblwxGn5DnTj2KD8HuiSGXmCAyt2cM5/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/13/2025 9:36 PM, Alex Deucher wrote:
> We need to take a reference to the interrupts to make
> sure they stay enabled even if the kernel queues have
> disabled them.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 31 +++++++++++++++++++++++++-
>   1 file changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index 1f3045323c929..669d1ef3fab22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1352,11 +1352,39 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	return 0;
>   }
>   
> +static int sdma_v7_0_set_userq_trap_interrupts(struct amdgpu_device *adev,
> +					       bool enable)
> +{
> +	unsigned int irq_type;
> +	int i, r;
> +
> +	if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
> +		for (i = 0; i < adev->sdma.num_instances; i++) {
> +			irq_type = AMDGPU_SDMA_IRQ_INSTANCE0 + i;
> +			if (enable)
> +				r = amdgpu_irq_get(adev, &adev->sdma.trap_irq,
> +						   irq_type);
> +			else
> +				r = amdgpu_irq_put(adev, &adev->sdma.trap_irq,
> +						   irq_type);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int sdma_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
>   
> -	return sdma_v7_0_start(adev);
> +	r = sdma_v7_0_start(adev);
> +	if (r)
> +		return r;
> +
> +	return sdma_v7_0_set_userq_trap_interrupts(adev, true);
>   }
>   
>   static int sdma_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
> @@ -1368,6 +1396,7 @@ static int sdma_v7_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	sdma_v7_0_ctx_switch_enable(adev, false);
>   	sdma_v7_0_enable(adev, false);
> +	sdma_v7_0_set_userq_trap_interrupts(adev, false);
>   
>   	return 0;
>   }
