Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA4BC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 17:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3466610E384;
	Wed, 30 Jul 2025 17:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qeHsJDvJ";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C50510E384
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 17:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/QQWNcL4KK9UMb+hSf2FDF3WdxM13a8qPfs/pxwKpKNLA9qJ+KVnY2WW3p4m5KfGjQeKFo24VYYPKAjf7j+qEByUD5FxSJXzqD2POiVnTjseu287BI7YPq4I3g1nqPSJ9GeCPWimeIsZxQ1cYUDbe4m7XWIcMnySyf0D71vZT5+l2Lf0wEm84Ydb+cM/mxhT/p2iQSnjM8MfkLaZLywTADWP128DEffGGEjoy1z8YKbKkH3Y8jMC7aFSTdpQfvqN/IKaDUQr6nDQ1qTQz0TKRmLDoALlRFYOXxVJm6Als5F6f4yaSDpTon4v/IBON75ZIAueyOuMQQOanWiPUlscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zyUo5HLDsvXt4Jg+nriu2e3FbVBHsyH9yB7H2NAbsE=;
 b=yu5sLZpCGVTBVj6VBU3WNQtwDMWZeyRymNTNmTQSxEBAmhUVD6xjNjEmKjYfhIrz30KdnL076pyg9quhKFyNcqMBoeOADs8KcXp99fEAw2po/DR4Y08AHKA1XjWdt2yoRGXj81U/wkyT4qz1J9Ct7WLy0u6RUzR6RJH4gy0pJgECWgQY2HGX0qPgXnLZpPd0I1ZIEEFfvs1sQtDlclqPAMnXJmH7vI4O9wepU01p2jIr5lU5qNK9DWt7YwmS9hFMFjSKRHxO0rGFA0hd8SpXRqtj41gIACTGO3txV/PUtNBu/TqlMpzXRIOlXx7JRRxB3YU9yaib94PqT488Ug2csQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zyUo5HLDsvXt4Jg+nriu2e3FbVBHsyH9yB7H2NAbsE=;
 b=qeHsJDvJX9ejhuly/utU1jVCHFgPYJDeLwHpPJgI0q9uHnefcVWQ7uDFOJYlETs6/jcfN+qF1KjhkAVrgXM02y8e4sdTAyJhPF0RRHw32o8eMp14O1eQzluBttEL0GiD1+461CeKFEY5eXoBabqHW0+3jI/HGdMWdEAs7K2Ovfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 17:29:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8964.026; Wed, 30 Jul 2025
 17:29:48 +0000
Message-ID: <f0e92c68-759e-42a4-8f5a-8c49a786985f@amd.com>
Date: Wed, 30 Jul 2025 13:29:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-2-timur.kristof@gmail.com>
 <68370e57-cb4e-4ebd-8d04-b198a7f2f02f@amd.com>
 <c88ac1d6cc039984f9dbb58f923fb62e505ffcec.camel@gmail.com>
 <a2c6a809-183e-443e-b10f-a271c0e89058@amd.com>
 <54dd7186188f0deaf07570c16f5b3c3b9b263cc9.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <54dd7186188f0deaf07570c16f5b3c3b9b263cc9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ1PR12MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 267464e7-b49d-45a8-1ca9-08ddcf8eaeba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG5Xb3dIdlpaeDJjZklYRU9QUVBDUVg3bGRKTDJjWTJ4TUZtQnRDZ0Q0d1VI?=
 =?utf-8?B?d0hzc2U4TVNCd3l4U2JVYUtGeG5KTUgvN1UvdGZoMlJiemlkZXJ5SWttMXM4?=
 =?utf-8?B?VlZYOUVTUnNhcU9NQzdWU1hIaTlKVm9QcjI1S29QSzVnYWZlTTRxbDNKVUJW?=
 =?utf-8?B?eEpwd3UzUG9EWUFmV1d5ZERtQS9RRllyRmdTdzI1MnA1L0hYaUhqVGFpOTZt?=
 =?utf-8?B?UzVSNGJCWVN5WW9ScnNmeGZRWjBJd29KWHkzb1ZOK3hUNDBFcGhmRDV6aVlt?=
 =?utf-8?B?TkljbDBoV0RxbHRKSEUxM0EzZVhvdDZleFdMNEFCRWFNSGExaWZDZE92R2VS?=
 =?utf-8?B?cUVvUDRpUHBsaVF0K3BGU0wwMEZGTFVNWmlGdlNJM0xEcXJSUG9mYlVOcFc2?=
 =?utf-8?B?YUpXYnpzRE5PcHN3OWthZTNtRVhoWHRuRGllTW5CSHpuQnFuNFFoSCtVcGZn?=
 =?utf-8?B?STNuWVRSbmQ4Zk1tSGFabjVqbFFOTmdQV2cvRDlHSFhKRTRyU08raDhxQXV6?=
 =?utf-8?B?T29pbi8zMk1LRlJGWjJmUHBFUVJKRUFWYWd4dlJOS1NrMHVya3ZWenJmTTFQ?=
 =?utf-8?B?NFpXT00yN3QwUG1NYXZSNkovTVNheGIySTZvNUpxY04yQTZiYXo0Q2l0SEJx?=
 =?utf-8?B?RXNNQnRvTDFtR0J2emVqL2VLWVpXenduSHB3Sk9hQXRHOVlQaUZHN2xKVmgr?=
 =?utf-8?B?bUtsOHgrM3Jua2sxTVZKTzN6dVhPMGhwQnMrRlFsOU40dnY4b3dsZUJocE1J?=
 =?utf-8?B?MTI0VE1Ld2wrdHpBb2ZKWTFMbkJGWUhKdTFvRngyQndjMHExTXgzNTZrd3Zi?=
 =?utf-8?B?VTZhWWZtbFFldjYwVGhHb2t0RHNDbkVNYW5CdnlucldOZ2RqY3ZGVkUzVzZk?=
 =?utf-8?B?Ylo3K01ZekVSZWsrMk11ckJ4RklpV1JKKzJhcjhUeHpNNG5TbEo5a3VzeDFo?=
 =?utf-8?B?djJXK0t3R01LTTlVazROTDdSakNPQy9xeFQ5czhpMU1LREpoWGZUdFZYaFV0?=
 =?utf-8?B?MWdtd1NpbTgycjYrdGFCMHl6WUYvSURJQWM3emFtNWsvSjY1dzM0blBxd3l0?=
 =?utf-8?B?ODcrcW8xV25aM1E2UUpiMTZOcFZiQmZ0V0lScndlTS9kTm5jRTFlalhVT3VT?=
 =?utf-8?B?Tmx5NUVJOGtUYUhnSVdyclpHc1RNdlNlaWVLMzBOTldBdjV2SnZNdXJvZTVO?=
 =?utf-8?B?dDY0UXFOejhZcldrVTlNcVZ6OWdyY1FtTHVqekF6dGROckgweFc0aCtwYTNX?=
 =?utf-8?B?VHJPTXpDWTBqbUt2RlMwbE9jcWZvWXZUN1QwTi9EdVRiR0hzN042d1ZicFJO?=
 =?utf-8?B?RzJKeTkzV0pVWUZnZmhMTTBXWDUzUktOQURzOTJNQnB2QU1BUVBMWExhZHBO?=
 =?utf-8?B?V3Q3OGVPOUQwQmhWRGdrNGZmSHdRbUlJbmEvQ1lxem85SnBCMHNrY3JsNy8y?=
 =?utf-8?B?aHEwQWhIcWxObDNRdzExa0ZwM1ZLWk50REVmT2RXQ2NlQllLeXFOdHRlVFQz?=
 =?utf-8?B?MDVqSW80WWtIQldrOXozSWNjRFl6REdVeVFQY3pEZ3FFc2ZsQTRKK1p0UURv?=
 =?utf-8?B?UXFNZmNpUlNCSzI0T2x0WjhwQVpWZmZQTGVOcmpYZHZKUG5Sb2V0OHpaall6?=
 =?utf-8?B?MmxMNG1DTTV2QVJNK0FUOHFNblU2OG9IL0JGSDVhUWppbHlRdlZEWDZ1L25L?=
 =?utf-8?B?STVzSUZ5Tis1cUU4K3BGdm80YzNBdlQxMkc4NktOUEVCVHpFMXI1MDErb2Fy?=
 =?utf-8?B?Q2JmZzVDVVZvYW0xTEd3dWdIaU5sb0xxdGxHOGpGQkNMd0kvNnpyZlBzN2F3?=
 =?utf-8?B?N2plbG5KYk45V0RmYWZJOWl1cWRPQkZ5R3FFYmg1QURuRjNVbVdTWUprdlRy?=
 =?utf-8?B?QndocUgrL3ByS25CTDhtUTNTNDFFSzJlZTZMRW5ocGJidXpqampnREYvdHlt?=
 =?utf-8?Q?Z/6DPYUix1A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFRLcDFGeVhmNnpocy9YdkgxOVRMVE93UGl1SkdRZGVxa0RjWFExNnJ5cXQ4?=
 =?utf-8?B?d2xPNlU5N3pObitXT1ZnNVdvdVRPTVcrTWU1RFBMK21ucTBYbFFiYWtncTYy?=
 =?utf-8?B?K2VsbTlCdFI2VzArbSt5ZzNWZHlxQWxUbGJ5S3BGMWNHelpJWFlEamFuU1N1?=
 =?utf-8?B?SFNoeGtQd1lFVnRGQTFTdE5mY0hqZHg1dW9kNFRNUkVuc1FaZmtjSVZwdktD?=
 =?utf-8?B?T2gyVTRJdlVyYzhrU2l3T05zRkhWTm1EbWtpNHVsRS9yYW5QU0gxanJGamJK?=
 =?utf-8?B?Ky9Kay8rS1pZNVU3U3JjemRHLzBtTmFGaFhZallRblZOUWtPeHdUaWJ3Lzg4?=
 =?utf-8?B?M2RwakQvWXJNZWExQUNsd01aVTdUWlUxUTdNb0ZwTWllbVZTZjZnRXdpdTdm?=
 =?utf-8?B?cVNUZ01MNzNsLzR4eVN6UCswM0tsR0g3L0ZlNm4rUTliTWczbGYxYzJlMnFU?=
 =?utf-8?B?dVBjT1F0MmFxL2wvNExWaEJoWWc3dkxha0lQQWowZmNnTVpZSzRyL0VMODVx?=
 =?utf-8?B?Ymg1U2VVTlFOUXdFeVI0SzZNb0N6R1phSk0wTkMvRzlSVUFFaTRkMis0NmVi?=
 =?utf-8?B?RUJTUW9GR095SkRtK0dCc2JZMHRRS2g1Vjd0ZDNMTTJEbm9Dc29YNjE5dkE0?=
 =?utf-8?B?bnB4TjlZdHppRk5JNHNRSUlrNzgxbEdFTm44aGhZeWZqUVVWOENERnVmUDI2?=
 =?utf-8?B?MUp3RUNURnlhNzRTL0laUi9yVkZheHpDRUFud0JESFdrQlVVWmNRQStvNTBx?=
 =?utf-8?B?K2VkM2IrUFY2R21GYzJwbEtQL21WZytXcERPbXJ1cHRMdlJOL1BOMnBaK0xE?=
 =?utf-8?B?ZTJUTTl2QVhkNnpQMTJJSWYvTWJGa2xuaDAra3dSdnZTNWl4ejNWSmc1YzlU?=
 =?utf-8?B?ZzZGVmN6bU9oejJhSWVpd2NSa3hmV1ZFYUxyTlNvd21LdjMzbDNQSlFnQmRF?=
 =?utf-8?B?S0tYTi85SFcvaWpnbFpzUXRyZlBPemcvR1MzRXhLbmtRZjFSenVsZWk2TW9V?=
 =?utf-8?B?Slo3UEZNcVcrTjc2S2xTeDlYMmxQRGVIOXRQczlUbzRFZVptZEZkMUo4bFEy?=
 =?utf-8?B?NnF4Y3ZkbG9PK3VFZGRrNDhSUjc4ejQ0Y2tVd3JuV2tKTVhoaFVWMDJUcnRT?=
 =?utf-8?B?RmRvV1NDOGlmK1I4NnIwYmJWTjZkdU1Md1IxQi9qWm9vUGRPNERkRnQrMzZC?=
 =?utf-8?B?ZWVqdk4rSUhFTUgzZms0cndZQUUxV0VZd2dWd1A5ZU9NUXFLN2M5MmtMUXZj?=
 =?utf-8?B?SVIzODREemZTcWhFK2xjcnIwMis1Q3Z1aHR6ZndMbWdZYjJqYnFwVTNkbEQv?=
 =?utf-8?B?cTd5cVJ1NVBURVhOMGlrSy9nYkU3Q1RYUm14YU1UamlucTJxU0R0Tk9UVkw5?=
 =?utf-8?B?N3ZzU2JMK2RzNDFkWnNUSFBXL1puNU52Yk02SmZGc1FaVjR5cU54R1RBYUlE?=
 =?utf-8?B?VDJqd210QkR6Z0JSOW4yTk5zeHhsSUY4S0QrVGs0ZUM3Qkp1Vy9GNlFmVmtR?=
 =?utf-8?B?ZTY1WXArSURuNzBuZnN6TERoUlBsT0phaUxCUTVycWM2MXc0ditKZjB0VWVs?=
 =?utf-8?B?VnFIRjNXRm9aZzRDUmpCYWFIb2FZVFJlZXVDVERkMVRCU3JmTkppRFZ2MmZ3?=
 =?utf-8?B?aHNhUDJvT3dISVV5YXgzMFpQTk1DRzNLdHhHQUhiRXpjNnBSVXdZR0NLQWNk?=
 =?utf-8?B?djZnMm0vZzEwek8rbTZ4S3pRMmlVUGhtN083UURtRUdqdjVDY2ZlblZYS0VZ?=
 =?utf-8?B?WExSaEEzVXhLdWc5bGVvODc3Z1JuT2dnRVo2K0tqTGRJUy9xdkVNL2xlUktz?=
 =?utf-8?B?d2hvcTNXbU9ZdkltQzhmaDFZL3lXK3hLcHgvNkxjZmd5NCtLWFNyVWxRNFcr?=
 =?utf-8?B?RHR0OUZvYWcyaWlQbmxSa2t1UE5VaTZVYUhiWUFCS3pQZnRhVUNRcWZsMW5t?=
 =?utf-8?B?L2x6Q0FHUWV5NnRKd2JJdDF3QmNYNFZ3RWFaQkUzMWVDYldpeGtwSnRNaDNx?=
 =?utf-8?B?cnlBYVhxSVkycy96SW5vNHFUc3VDQlVLd0l6SUkxN0p6SGtsQWRMdmtjOXpQ?=
 =?utf-8?B?cCtGcHhpYVI3TzFSUnloeTEycGgzK3F6NnhaTmRsN3hia0Y2NzhDNWxqL0Y4?=
 =?utf-8?Q?o7BL0NeFpyVSwW83reteCuHli?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267464e7-b49d-45a8-1ca9-08ddcf8eaeba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 17:29:48.1853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FdwDWqwweKUBJDwtbQdZMsDCPen4tLgAyydLQsard/K1DvgcfaDcrNxHu94llaWKc58sKMVxKMQi1T2+9/bXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
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



On 2025-07-30 13:03, Timur Kristóf wrote:
> On Wed, 2025-07-30 at 10:30 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-07-30 03:40, Timur Kristóf wrote:
>>> On Tue, 2025-07-29 at 14:03 -0400, Harry Wentland wrote:
>>>>
>>>>
>>>> On 2025-07-23 11:57, Timur Kristóf wrote:
>>>>> Previously, DC determined the DRM connector type based on the
>>>>> signal type, which becomes problematic when a connector may
>>>>> support different signal types, such as DVI-I.
>>>>>
>>>>> With this patch, it is now determined according to the actual
>>>>> connector type in DC, meaning it can now distinguish between
>>>>> DVI-D and DVI-I connectors.
>>>>>
>>>>> A subsequent commit will enable polling for these connectors.
>>>>>
>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> ---
>>>>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28
>>>>> +++++++++++----
>>>>> ----
>>>>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> index 096b23ad4845..c347b232ae06 100644
>>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>>> @@ -8038,24 +8038,26 @@ static int
>>>>> dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state
>>>>> *state,
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static int to_drm_connector_type(enum signal_type st)
>>>>> +static int to_drm_connector_type(uint32_t connector_id)
>>>>>  {
>>>>> -	switch (st) {
>>>>> -	case SIGNAL_TYPE_HDMI_TYPE_A:
>>>>> +	switch (connector_id) {
>>>>> +	case CONNECTOR_ID_HDMI_TYPE_A:
>>>>>  		return DRM_MODE_CONNECTOR_HDMIA;
>>>>> -	case SIGNAL_TYPE_EDP:
>>>>> +	case CONNECTOR_ID_EDP:
>>>>>  		return DRM_MODE_CONNECTOR_eDP;
>>>>> -	case SIGNAL_TYPE_LVDS:
>>>>> +	case CONNECTOR_ID_LVDS:
>>>>>  		return DRM_MODE_CONNECTOR_LVDS;
>>>>> -	case SIGNAL_TYPE_RGB:
>>>>> +	case CONNECTOR_ID_VGA:
>>>>>  		return DRM_MODE_CONNECTOR_VGA;
>>>>> -	case SIGNAL_TYPE_DISPLAY_PORT:
>>>>> -	case SIGNAL_TYPE_DISPLAY_PORT_MST:
>>>>> +	case CONNECTOR_ID_DISPLAY_PORT:
>>>>>  		return DRM_MODE_CONNECTOR_DisplayPort;
>>>>> -	case SIGNAL_TYPE_DVI_DUAL_LINK:
>>>>> -	case SIGNAL_TYPE_DVI_SINGLE_LINK:
>>>>> +	case CONNECTOR_ID_SINGLE_LINK_DVID:
>>>>> +	case CONNECTOR_ID_DUAL_LINK_DVID:
>>>>>  		return DRM_MODE_CONNECTOR_DVID;
>>>>> -	case SIGNAL_TYPE_VIRTUAL:
>>>>> +	case CONNECTOR_ID_SINGLE_LINK_DVII:
>>>>> +	case CONNECTOR_ID_DUAL_LINK_DVII:
>>>>> +		return DRM_MODE_CONNECTOR_DVII;
>>>>> +	case CONNECTOR_ID_VIRTUAL:
>>>>>  		return DRM_MODE_CONNECTOR_VIRTUAL;
>>>>>  
>>>>>  	default:
>>>>> @@ -8440,6 +8442,8 @@ void
>>>>> amdgpu_dm_connector_init_helper(struct
>>>>> amdgpu_display_manager *dm,
>>>>>  			link->link_enc-
>>>>>> features.dp_ycbcr420_supported ? true : false;
>>>>>  		break;
>>>>>  	case DRM_MODE_CONNECTOR_DVID:
>>>>> +	case DRM_MODE_CONNECTOR_DVII:
>>>>> +	case DRM_MODE_CONNECTOR_VGA:
>>>>
>>>> This seems unrelated and would do better in a separate patch.
>>>>
>>>> Harry
>>>
>>> Keep in mind that currently DC recognizes DVI-I as DVI-D, but after
>>> this patch they will be recognized correctly as DVI-I. So without
>>> this
>>> part, the patch will regress the hotplug capability of those ports.
>>>
>>
>> How will it regress when your patch series introduces analog support?
>> Without that there shouldn't be DVII or VGA connectors.
>>
>> Harry
> 
> DVI-I can carry either an analog or a digital signal.
> 
> Before this patch, the DVI-I ports were recognized by DRM as
> DRM_MODE_CONNECTOR_DVID and their digital part was already working.
> That means you can plug in a digital DVI cable in a DVI-I port and it
> will work today.
> 
> After this patch they will be recognized as DRM_MODE_CONNECTOR_DVII
> instead, so in order to keep the same behaviour as before and avoid
> regressing the digital part, we need to set DRM_CONNECTOR_POLL_HPD, and
> in order to do that we need to add DRM_MODE_CONNECTOR_DVII to this
> switch statement.
> 

Thanks for the explanation. In that case the changes are all related
and it's probably easier to keep them together.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> That being said, I can move this hunk to a separate patch before this
> one. That way there is going to be no regression and this patch stays
> simpler.
> 
> Does that sound ok to you?
> 
> Timur
> 
>>
>>> That said, sure, I can move this part to a separate commit before
>>> this
>>> one, if you prefer.
>>>
>>> Timur
>>>
>>>>
>>>>>  		aconnector->base.polled =
>>>>> DRM_CONNECTOR_POLL_HPD;
>>>>>  		break;
>>>>>  	default:
>>>>> @@ -8631,7 +8635,7 @@ static int
>>>>> amdgpu_dm_connector_init(struct
>>>>> amdgpu_display_manager *dm,
>>>>>  		goto out_free;
>>>>>  	}
>>>>>  
>>>>> -	connector_type = to_drm_connector_type(link-
>>>>>> connector_signal);
>>>>> +	connector_type = to_drm_connector_type(link-
>>>>>> link_id.id);
>>>>>  
>>>>>  	res = drm_connector_init_with_ddc(
>>>>>  			dm->ddev,

