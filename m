Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FDBC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 08:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA7610EBCF;
	Tue,  7 Jul 2026 08:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z8MczS5B";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E69010EBCF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 08:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEnhBjIT9RO8SRHdProrhjZqFC+8gCHt7xdaMPcWMMTF5yXljkMQTh4Ar9bk/ILLqkWcvElC3hIAAls9Js/8z+dRjJygIf0tLOhSxVFYqr/qy8RHDS5IWt7zuPyfXBswyqzF8Gmw5IX8juXSFq9EXkBV9zZ56UBf/3OeKJbLJylLw7yzusdeU+PZ2BYNRAm4apOvdIXXvAtUOlNltEpng2MFYyNFvyz0NmxAcHkCCL0zzWrpDsppigaEaGH6LbDdqi1jpMWCPz6Y/oIrY0BR0ToFZBs6qoizgOgiTHpOti/Fjv4Uaw71lb0mI488NGsV2tpVrvkhFn/4sLtNefT7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7iKvQe3FE/viOh4xBaCE1yxdwEOi1w5nHXvZMg9LcQ=;
 b=cH8b8qSn/CBbzhlKDUpA8tvtOTZAuKorSgeQI4/itCoGp6ni/49oUjoffwwm1kME0lBgsX6xaHXu97c2v6LSyFUIqmqTQLycnQKlr86E8bU4GCGe3/kaCnL+OAsxIIDuRiHjHDg0d1FI7DfRBjTyd6nE5HvclAP555mFZEdYpwL21VDI3Zk1F5TiouW1C9uhlYIQY6lHWQFyShh9xRsegkfyW0x2LlMw9IdC38uh9PYS2bh+iIKRGZoMWrSH4PfNe9Pf8xZqwsU4u1nw3gdf0/Szu8cnCCNnt6wwe2+Ycgo6K9+B6vjTzA8W0FqnG8OpRGNKLJwupg6Pv5GcP/XVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7iKvQe3FE/viOh4xBaCE1yxdwEOi1w5nHXvZMg9LcQ=;
 b=Z8MczS5ByKRcf+S2a63kxhYGKhZg5FG3b+unXjM7nf2/q1dMpNybqTeT995eohObm1QBQa3sumg4jydqiYnxXGGDXi/29Ey3AHOgdQzfAJLZ9SVVROSDCpwR0KbO8CBwp9ej9Y/w92M6O9RbfpIJZUCGdzrc+QkH9xpkyJ3Mn2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:25:18 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 08:25:18 +0000
Message-ID: <e934a6fc-473f-4a98-92c0-5cefdfc7e202@amd.com>
Date: Tue, 7 Jul 2026 13:55:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amdgpu/ih6.0: Use MMIO ACK for retry CAM on IH
 6.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, "Shetaia, Amir" <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "He, Siwei" <Siwei.He@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <4547ddd3-974a-4c9c-8fec-939dc132f7d0@amd.com>
 <BL3PR12MB6425A9D4631A637C778F6BACEEF42@BL3PR12MB6425.namprd12.prod.outlook.com>
 <3014087.Ex9A2HvPv6@timur-max>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <3014087.Ex9A2HvPv6@timur-max>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::26) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad5a8e3-5a62-4900-1ac5-08dedc014742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|921020|22082099003|18002099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: P7EyQb5ajd3tFRUkEpzxj8gvHeNTQ2XPp6SbsgNl/7Ph1uu1WZizOZn53VaDgF52+D4I4tTWbbMhaY+e3UXs0u7XN1bfkvN8QYenYagBUkuKxIh0uKfdxduNXdxVOpy2BkZKJussOH4qv+t84IhchCjR6SuV8JaCnOPVyx9B1t3t2o+8O4QRGfYaLdcRqI7SKGoPPR2R33B5dO6APcsLGUPGAuhwF+KBIgXExm4D95/g3IcrCZzOHXE1lKqayTMSkuLuhvHJm23meYRWxAkMQ6uyhkkgvZBMy6FmdbhP+c/Lm1bS2D5qAFFSEYwEuwPXR8M8P08wRLg6MlPJZMZjBcfrRH2Y7dCLtlT7T4dmfogws3Un3a4tK8AzOAgNQ79Pjf3vJK9EgFBMii+1ApGJp+UC2bdhiZjd0SDY2/+G6e1L8KAPHhgFFzEZAzbZoXfWriKzwWX/4LkUqaOmM1WlX5uRSb31FUnnIC8UPmFJd6BoEvsp5j2IogvXaj00eue/7Nwfl9nG0inopjFKgYw1j+r0cDzcCFh3p3DIr34SjWPWCV+eQf20aWJDXuuFbtf9VA2hRa9gmHoJWe/d04+AJm44vB93c9fmwfGLCKytVK+SDTA8WfEvZEIOMaFYtkqNcoVP5f+ZclRKugf1vWwie9RoJQn49gXM+MrjDDDszPzgUsq1I6EOKsHv9lWYHoMwkFTfiyVGASDH/EEXUX5wJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(921020)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUE1NExRRHVvZVI2SFF3anU1SHN4TDVWY1JVNGM5Z0RTL1Fyem45OUd3ZzRu?=
 =?utf-8?B?Tkc2U2ZRMFlzaWVycUIxdzBFcENSVGkwck5FL0c0TFRZcEJ6d25MdlVJMUlK?=
 =?utf-8?B?YUVTdTdraEdUVmNMbHprWXU0Ty9zUGFHWXBVa216ZFVZQzNXZlFiOEVoOHhG?=
 =?utf-8?B?UlV3bG1Qb1M0K3dsS0h0MUE4T28yRmgxS25PU0dGK3FBNnNqM0xSQjUxT0Vn?=
 =?utf-8?B?bUZJbk42Ym9INVZaY0FQVGZ4MUh5RGViUDBPNVFvUzNHLzVxRWtjbVVyRms0?=
 =?utf-8?B?dkJFU2phbTBaQWU2bzZ2OHQzZzRoMytranJQRnZzTUJMM0poWG5VWEpoT1NF?=
 =?utf-8?B?WFM0bUx1ZlRvUGRaMGJkdHpRZ1dFWWEyU2hkaHVNMDAxOTIvRGtDeDFUL1dL?=
 =?utf-8?B?V2hoK3k0OHF0S2dIMmIxR2ZIMHhxQjBNS0FTWWQwNTgwUXVtNUUvQ0ZTMHlK?=
 =?utf-8?B?a2xMOUhYSExyVnNTL1lrbkRVbnA2U2g3cHFtR2xKd21aTzJGeXQ1MXJlbDdK?=
 =?utf-8?B?RFI0NmV1blk3WU1GNXp3NUZtMGo3WmhnQ0RVRzk4dnJiMlh0MlgwcGZJWkdJ?=
 =?utf-8?B?MXkxZVVXRUt6aWtrTDVLVjhkcWI4T2YvVGN0NHM0eTB3Vk40dDZVSFZLMDNy?=
 =?utf-8?B?NXhjTncrc1VvbnRZZjFjUFl5R3ZHQkJaalQweFVEcTFoRDdZSmFWYlFLWWx3?=
 =?utf-8?B?T2pCRlE5WXJBYmVDcDZOT2hOZkdtSDRuUW1ITWhVUWRHNDdOVWlmK2tFcjFQ?=
 =?utf-8?B?MXRVT2hudzZrbmk2SjlDc05FbXEya2JveWh2dTB5S3FleG80ZzZEMmV2cU4v?=
 =?utf-8?B?aUFvVEt6Ny9HajN0VTE3RVpZSHhpSWJ5SWVQR25GMGd1RW54QW9MMlpsK1VH?=
 =?utf-8?B?bGp4NGxIQ2o2ZzVKSHBUWDBxODZuZEJhWlh6bGtoNjJaV01lNnZ5bmttMkJB?=
 =?utf-8?B?YnEvSVZZU1AxQWJBaGYwaG9sUjA1dGpTUEZ3WXA5dzZDRXVLZEhCVzM1NHpZ?=
 =?utf-8?B?ZlVVekx0UkY0bFlVTlNhRDhTeGpacHkyc25xcHBLUzJ1T2JvYTVSL3Nwc2po?=
 =?utf-8?B?WGpUd29PMnRCYkFPYlVYaWE2WDl6alhGeXIyTlgwaTFLQ0lhNzMzdGVHKyt0?=
 =?utf-8?B?QVBiT1NVU1lsTDdLY3I5aW5DWGxlSWMzK1V4alVEV05BeThqWWQ0UXJrdGov?=
 =?utf-8?B?ZzhXR3pQUDFjYmp0dS9IWTBTNnYrZGxUcVhkODhlczlkVDlzcUo0MUo0bUor?=
 =?utf-8?B?Q2NaSUtJQ3ltbWJHL2s0SkZoVC8rako4dXkzeEQ4eXdHakxjYzNRQXkzdkFJ?=
 =?utf-8?B?c1UvOUlkY1hBWWtUSTd1dWh6bHkvdXUxRWdLanJQUVBQcUtqdkhEcWdObHda?=
 =?utf-8?B?UUJVNzZRZE4xYXFqdDk4Q0FiTk5NYW9BNUQ2dDNDRFRqS3pBeHpySDhWeWlv?=
 =?utf-8?B?Mld2SmVPei9UZUFGNGllbG14UGFWdzhCNVIvYnZiZ1NTRVdIYUtoU29HYUhq?=
 =?utf-8?B?T1J0WTVSWnh3ZjBVMFpnNlcvTStFdGxaTy90bkZKSWxHeGRiWUQ2OGNiMHhR?=
 =?utf-8?B?NjRQK2FLL1RrU0tzZHJqcnJhSi9VQWIvZTIrNHgydHJVclFhSVZLdldBOFQ1?=
 =?utf-8?B?VGluM2lTSTJaYktxTUdheUlkZzRVMHVsc1RzblE0YldBVHRqRnBPU3p6VURR?=
 =?utf-8?B?RW9veEV1b2lHQTRJNnJsUk0xd1IveFVYRXNBRDBiZWNVZVFJSm9MVGNQbWpF?=
 =?utf-8?B?aFNFR25LWlNQaHZLUnQ5MDYrNFZKMFBJOUx3YURnTU5EeTVkRmk2RUF6TXF6?=
 =?utf-8?B?SDVnQ0lvVGN2QUFjalptZVdGaHoxN01KcUJTbWxvaEM5ZkJYeVBjS1F2ZXdU?=
 =?utf-8?B?aUNmQ2c0M09qK2ptWlBNVHRlYUNiNFhpWHlJcXRBSXJhaWVVU2pHRGc3dVVP?=
 =?utf-8?B?VUoreXBvUlp6Z2phY0cvNTVPSDFKQ29LSFMxOEFMeTNsVmMrNXJwNjdzaUdo?=
 =?utf-8?B?WGZHTnNFYjFlaDY0RWdselF3eFEzcHNSTFBRSkJCUUdzRW5CMHowekRBVFZy?=
 =?utf-8?B?TmVJTytpRXc0cWk3Z1JSVG1BV1pMUkQ2OWJNcU5lY1ZIOWRuSW9SYVZpU0h2?=
 =?utf-8?B?bzZ3Y0E4UVczQnY5Z3RGVGtDSksybjVtSTloSjc0L3pzbHJ3a2l2VXdJeUwy?=
 =?utf-8?B?TGtpOFFnb3d3bHFpeWlvekVnSzdEdklnY1RYRG5BYlY0VjAzVThzNnVEYWpO?=
 =?utf-8?B?U2VSMDkzVEpVTllCcGdZZEVJbzdRSkZ1eTlRR3kwZEtKQU9WeklsWWhaR3F3?=
 =?utf-8?B?SGxRa2FnUm1hVXVEZEU1VWpVLzA3Wlg4OW9Zd3FFc3J2YmNLWDN3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad5a8e3-5a62-4900-1ac5-08dedc014742
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:25:18.3512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAPpd/MRtgqcbk+Mf2a4CX110h2Kfk8hrHmGHjsncifxxdUTbOznq51tCOgPB4vW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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



On 04-Jul-26 12:20 AM, Timur Kristóf wrote:
> On 2026. július 3., péntek 20:11:59 közép-európai nyári idő Joshi, Mukul
> wrote:
>>> I still haven't found any explanation why we use a doorbell for the CAM in
>>> the first
>> place? Lijo, Alex, Felix does anybody know that?
>>>
>>
>> If I remember correctly, we weren't sure if the IH_RETRY_CAM_ACK register
>> would be available under
>> virtualization. And we were sure doorbells would
>> work for both bare-metal and virtualization.
> 
> Hi Mukul,
> 
> Can you clarify that please?
> 
> How are retry faults supposed to work under virtualization? Is the interrupt
> processed by the guest or the host? Why is the IH_RETRY_CAM_ACK register not
> available under virtualization?
> 

For clarification - CAM entries are separate for PF/VF. ACK register 
also has PF/VF copies. However, in general host driver imposes MMIO 
register access restrictions to VF, possibly that's the reason.

Please note that IH_RETRY_INT_CAM_CNTL is PF only. With new versions, 
please make sure to add a VF check for programming.

Thanks,
Lijo

> Thanks & best regards,
> Timur
> 
> 
> 

