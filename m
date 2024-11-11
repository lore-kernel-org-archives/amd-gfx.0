Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092F2D3ABF4
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 22:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A23E10E201;
	Mon, 11 Nov 2024 22:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZCfiMvL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C7A10E201
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 22:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB2C2o6VsqR74loqfXK5sYbJXB8Mjw0VZYvFjoa3PNTUvUBDz0WivddQZuc2raNOwV1Pbd8THbaQ6VjeerJ5RQ4KtWP0zj97X3tUpQEH+ATATqaZsGDuWlOAWCOuSg9r1tJwk2J7kEe6Qikl2+kjak1DGyiJPoKnCDTzIAyjrVkY6LYbm4JUUexFeqpPQNf5iAs/wvmewFrVvKAq9XSsroa5ya+2NQqbH8uP7jKzkwnxOFhFpgJ7JK5Z1MSrrWPaSU6emHFDGT0kWbrLHs4cn1Zsbg6iZDOYU9TPHWf/JXv7UiWkuPz1ozzOD/sXzlHgBpcW5sW4cUhIqYOdpoLzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyDc+bvYTc2VQ0pkzCKe9btJnEAoPng8kZvbccjy+N4=;
 b=tKiOKGjDT1RVjeoNsHSkjTJvmrAyldDM7IKezvPlrGm52+LqyWT3VRY8ph+mcuaPeY7H1xMrteUIP4kcS4/E3/gagN7FyxsRltGpXqQi2sVoIgQtvTLvFrWaHtI0elei7SpDCGwnFyq/aAXcyHiDmkGBHYFeHfnvq2lx/ql277idUndOz+uWYmcQSnrG61DLGBoCU7WFNn7n8Y3PZIDncHZZ3MXMtxxxUvCFVWEb+xoWqmH6LkSPa15v1M8fHJfIA9bTwBVtepFb3aJDXGYSCgO/3yrj72pWW8PLqzKEPahSh+VyIdziWxJNhSmE+jsnmmmbSlEiENd2rZH5lqOUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyDc+bvYTc2VQ0pkzCKe9btJnEAoPng8kZvbccjy+N4=;
 b=hZCfiMvLYRuQznSgc9NqPaKPT2cLRl2YJwUPycxUSo7tIQ0XL7/6g1TKk1GGs+kwNISrKl3i4eJ/M8Tjir3TE8eruSYZvtJa+oWx1W/Qc5t4LSRTeql+hJoNU6XptCYbQMHcgdkVVcU7ivc1KKSdB05Yp45+VGjhVIowT16OWlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 11 Nov
 2024 22:21:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 22:21:40 +0000
Message-ID: <d96c1117-7eb9-4c65-ab0a-1f4507d32674@amd.com>
Date: Mon, 11 Nov 2024 17:21:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
 <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
 <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 3179b1f4-bef2-4230-a59f-08dd029f36bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0JZeGNERWJRRHY0eDdYZmV0bXltR2VoRHNnZDU2UTYwb1l4SjdzNVJFV21m?=
 =?utf-8?B?ajBXUlU4MnJMMHkzck5MdnhPVWtXeGk0UzB5UUZQMjEvZm04OFlBQjlwSVN1?=
 =?utf-8?B?T2ZnWjZmZ2VRQ0p5ZHNtTWR6Sm1jVDB6M01DYVhhTG56eVVLZU9kdUJNUXRr?=
 =?utf-8?B?WENyRmZ4TXNOUWg5eHlXZnUvSDlOazN3UXpkc2M5MXNvdEdkTDcrZEptQWZX?=
 =?utf-8?B?Tzk2Vk4xdmhYYnBud2RuTFlpaFRpUWQrVVNVSkZtODAzN0hzMWxSQURJelhi?=
 =?utf-8?B?SDN6VTlkOE0vbElQYnN0bURmVFJjWjVmcW5BOFNKTUVLNFFINnBPUFBvZURa?=
 =?utf-8?B?dHdGV0ZpeDhtaS9hQ3R4NmY2ZXJzeitzdG1jMXJFcXJJbnl3Q013WFMzV0w2?=
 =?utf-8?B?UzhvWi94TWhiV1JkdDlzNmNxUDdrL3hZcjFVbUVCZFFublJXejBWU3Vvc0NL?=
 =?utf-8?B?bkFMaTFCTUpUWmcrN3RFRE1VZjRraUlIa2g4NzZ5NnNxSlUxZHdyMmFRQUww?=
 =?utf-8?B?UUNZMk1pZFpQZ1J1WGdkZDhkTDVGS0w4ckZPTUxXRXBXc0pjYUo3QTNqZTR6?=
 =?utf-8?B?bDRFL2FhVU56STVINTFOVEVxSEZXSTFEbHVjZmdkM3RLazZIVk5PdUlnay9O?=
 =?utf-8?B?VWZUK2FOV0RCTTgweVppbkgwMFo4WjNNUjJDM21lcVZTY1NZNGwvN3dyMHZO?=
 =?utf-8?B?dnBRVFJYWEdMeWNPYWg0VHNPcmdPNHYzSzFFOTZ6MkM1MTRETjZtR3p6ZjdY?=
 =?utf-8?B?ZGxtWWc4STdneUpjUkJjWTNwSnBjbjczdU1JcFQrWjRKbjRVb1JuMm5Jc0pL?=
 =?utf-8?B?UnNpd2ZDY0FnYzhlRUQ1dmExL0JuN3BkUDJ2WHFISEJZVXhnV2l4QU5TMFVy?=
 =?utf-8?B?SlF4ME9MT09PVGtJY1JSRXZZNGVnNU9UNEdmQ1R6akJxMEg0Z2o0N2NLaFVx?=
 =?utf-8?B?VU9vSUdRZmJFcjJVcDVCbEF3QlNZT09qR2hjMml2THBZbVN3ZWlMajB3TFBq?=
 =?utf-8?B?ZVhnMTc0V29iQkNlVStLeHNtNWZvejYvc1NrblJWaEp6ZmtwSHlxRzRkanhM?=
 =?utf-8?B?Ry9hNzgxY0V4SG9aUjd2alEzUDJNeENNcFU4SlJ3aGxYNjJMaEdQTXV4RGtp?=
 =?utf-8?B?TVN1ZGYyL3ZLaGFWejFvd2FCbG8waWFhc0VTNTBFTE92Y2VzMHJzZVBTcGdq?=
 =?utf-8?B?Qit0dHdMQ2dTY0FjV0E3U0xuTkhNU2dqc2UyZXdIdVFVRmxJNlZiQmVnamZR?=
 =?utf-8?B?L1F5OVRtV2Y5elJxVzhmN3dQenNVQ0xmaFhlQTRUWFN0TW4wQ3lqRjF3Vkpo?=
 =?utf-8?B?Mmx5eThwSnAyS3ZwWWZQYnNndVNCdTFmSzFTK0NURS9jZFZrQjNIdzJ5SW1l?=
 =?utf-8?B?bjlmZXdmZDdFeFJqWE9leGF2MG5nTUZPNENxbGNFSFZCdFA1eloxVUY0bHhm?=
 =?utf-8?B?bUdBTk55OXdlSEdScXhZdXhoT0hrN3BLYWNoWHYwVWRJMk1UREhqUWVVbTNC?=
 =?utf-8?B?Ylh5d2NqY2RlbjhPdytSVHRmeEZZKzNWRVRDbDF6VzNEbk5GUStXM0tOdWxY?=
 =?utf-8?B?Um1mdUlDS0pwTjFuREtMQUtNZ29iTDRiQUtZTzlrQUJ6MXUwZjAvNjBERHlL?=
 =?utf-8?B?aEVXeVhnT0FNSlBWcmZlVGFOYUJUTXMveWFQOGxuNkduOEhJRHNIOERGcDg4?=
 =?utf-8?B?MkZuQWVpbjNkTVp5eWJNek00ME41MU90OUNZZ0dKWWw3MDJHa1Y2RjdzQ2lH?=
 =?utf-8?Q?BZ+nOSY0hx+Ky2/t69CouNkKB/n9AsNrLF8HqY+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9wcGtxcVVmMnlaaW16eFpIOFRLc1R1ZGlOQSs0ak5SbHlYT3lkcHpwbGt2?=
 =?utf-8?B?NzJjZTg4RFY3MTZySkdQTXhscmx3b09vWEVHcWt3QUdVdkxGQSt3Smg2SGFX?=
 =?utf-8?B?SmhHamJjMDFDTHRncGoveERzaFdTZHd3K2ZWbUtER21TQ0tzZG9rbUhzUUg0?=
 =?utf-8?B?OHhSRXpVT2d0cTdabHFvcTZmR0JXVDdZTnpROGZ2SEM3TE5Dc05GWXBDcWpx?=
 =?utf-8?B?N1hRaGl1QXRlVHluMjVKaWhKV2FiTDNHZmV5Kzh5UkdxYzdSN3lEc2o2VVFE?=
 =?utf-8?B?d1ArTDJ5UnFndnhTUFhHSk1JbngvekpYaXpVSzAyZzVxbVQ4NnB1WVNGSW1O?=
 =?utf-8?B?ZXZPSzMyUkFBbHAxWEtwMlVRTFNNVlpwN0ptZ3N0a21nQk5Hc0RJbzY4ZndG?=
 =?utf-8?B?cytUS2tic253ZVFZb2dweUwwQnF5Uk5SR1Y2RU9XWFpRT3lucVMxR3RRWUtt?=
 =?utf-8?B?MTFaQmJ3dU1DdkpKUjV2WUw2ZU9ScytQTGdzaXNXbytRazNEU2w0djRCandm?=
 =?utf-8?B?aDBKUXRIeGJGWkJmdTUwRUQwSmZlZ3hldEhYa2pRTCsvdUxPbDdRSVV6TXFh?=
 =?utf-8?B?d1hXY0VZN3ptcFUranB4aUUvUHFXbjI1cUhIcUNRdy9wcWpoWjNTR2N3b05Y?=
 =?utf-8?B?LzRnNVQxUVNZSFViSm5GZ1N4d0ZvN2NoUlc4c0NSVmhZQ0EvNUVVQzlnQUJi?=
 =?utf-8?B?TzRvNjlBZzJmelRyNjUrdTJMU1IrNzZhQ3VISXY4V0had1M5SmV3L0hjaVp3?=
 =?utf-8?B?OGUxbG5FR1JNa2dJT2xFZ05WRDBlY1ZyakpQVk5QSDhkN1R6RWJJUjQ2Wno1?=
 =?utf-8?B?L2Z6Q2k3L1dkTkxad2FlN0FjZE1aKzhUaStoZmVnZzlWOTBiaXJyRUZCdDhT?=
 =?utf-8?B?MWMwbHVlcUFvdDF5dXFXSHRTMnRjRGRsL3VUVENoZWRrVlhZV2FnMUpSN0pP?=
 =?utf-8?B?dGc1ZEoxeGkxakw4NkNRbHdqaTRHY1YyWDRZVU9nNXBmVUlXNDdyL0NzbHp1?=
 =?utf-8?B?aFdMaWdoQThNMVBIL251aUw5RXVWM2EwaVF3OHZPV3lGZWl3SkJwR0ZPcEN5?=
 =?utf-8?B?WjNNNFp6NzNnMnRGSWtKSU1wM0JhRGJvZUd6bEE5YnVMZTJiK3Blb1NxVXo4?=
 =?utf-8?B?aitobi9TVHJzb3J5K29md2lCUm41QkpXU2g2MDhnMmVkdTVsb2FsUS95eVpJ?=
 =?utf-8?B?aXhGU1FqcHczSUNCc005LzBqZWIzQ050MzR1dmtsTng0bzRmU2l3NWwxNjNB?=
 =?utf-8?B?SGh0ZWt0dm9rZkhPZ1BxNlRUb0VodzN4c1Y1TnNSb1RMVVpzTGptRjFkZlVx?=
 =?utf-8?B?RzBVMVhnSkNxc3hvY3B2MGxGOGYraWUyOFl0QUU1a3JjcXVseDFhMFZFcllK?=
 =?utf-8?B?b2sxZnFNeG1VbHRGQWY5RGFaTWFsYTZPaUJ2Q3BOdGFYZEd3bEtBUXVsTk5q?=
 =?utf-8?B?YTBPNXU1cXNwc1cvMEhKYVUyMnZ6Ym5VZTdzbVUraUx3TWxyTlpoV3dobUQ3?=
 =?utf-8?B?QWNZRGpFY3hkTVhoYVNTTWJJbk1ZWnpoZ2NjKzJpRkdFbEc4ck9OVnBnQUt2?=
 =?utf-8?B?bUpVSzdoTnBLQ1pqWnExZm5ISS9iaEVIbkJIc1V0OEJnYkdseGlsZ0M0aUVv?=
 =?utf-8?B?SHlidjBUWXI0UEV5a3pXa2hLUFAzOWhnNW9ZZ01PL3NsYmc3eGo4cVU5eGlk?=
 =?utf-8?B?d3hUZXFQOUNmOEU2UllTclNXWWhBZC9KR2xzRXRLTnBLTk9RVG5VNE9UaERw?=
 =?utf-8?B?UVYzRnBVSHhER05YdTNGY3p3elJsKzJyWGlLZDdESVhMYU1OZ1VGeHRkaDhU?=
 =?utf-8?B?OFVaZG0xVTBOeUp5a2tyWEVVQjdXc0RnSmUvSExCb1Y1MnBncW5sQUNBb0lQ?=
 =?utf-8?B?UUQwRFhyQzlnWU9QNktPMTZ1R1ROeE9vbFppSWhTVHdZVXRiMEtYRCtCSXhT?=
 =?utf-8?B?RGF5c3AzQnJCdnpPL1JDQmlMajlndHN5YnRGbjFZdFBXVlJWeXNFd0VubVVl?=
 =?utf-8?B?Sk1CQ1Fua0RWSDFFTFNRY2dKakVxMFZvV1dJa0lidWFiTHYyNUJEM21yeGdN?=
 =?utf-8?B?b2JpWHppQkIxRG8vVEhtb3YzTVBkNWNZU2xXZSs4MXFWUU9CQkVwVmwxVHlo?=
 =?utf-8?Q?d/QbMxK96kvd1sr6CSohwgTNm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3179b1f4-bef2-4230-a59f-08dd029f36bd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 22:21:39.9780 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhSxbvBT9J9DekdIiE0AsvGgQNLijKjmhV3naNc2rXmcjqOIkuX3EUa7yi/GPLnmap5aDuhDVL0KeA9VUFyaPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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


On 2024-11-11 03:08, Zhu Lingshan wrote:
> On 11/5/2024 4:50 AM, Felix Kuehling wrote:
>> On 2024-10-31 22:35, Zhu Lingshan wrote:
>>> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>>>> The ioctl functions may fail, causing the args unreliable.
>>>>> Therefore, the args should not be copied to user space.
>>>>>
>>>>> The return code provides enough information for
>>>>> error handling in user space.
>>>>>
>>>>> This commit checks the return code of the ioctl functions
>>>>> and handles errors appropriately when they fail.
>>>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
>>> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
>>>
>>> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
>>>
>>> usually the return code provides enough information for the user space programs.
>> I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.
> Still the questions:
> 1) how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? 2) what if the user space program doing pulling mode, pull the args before error code returned. Memory changes are usually faster than error code.

There are no "bad default legacy parameters". Ioctls that were defined 
to return additional information in the parameter structure on errors 
have always done so. This should be documented in the kfd_ioctl.h 
header, though some ioctls have better documentation than others. For a 
good example, see kfd_ioctl_dbg_trap_get_queue_snapshot_args and 
kfd_ioctl_dbg_trap_get_device_snapshot_args, which do return the number 
of queues or devices in the parameter structure if user mode didn't 
allocate enough space.

Another example is kfd_ioctl_map_memory_to_gpu_args and 
kfd_ioctl_unmap_memory_from_gpu_args, which returns the number of 
successful mappings if the ioctl fails. This is necessary to restart the 
operation after -ERESTARTSYS and skip mappings that were already completed.


>> You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.
>>
>> Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.
> If a user space program needs to read arguments to do error recovery, then it is a buggy user space program that should be fixed.
> Usually the error code provides enough information for error handling. Why our KFD user space are exceptive?

See my examples above. User mode is not buggy if it uses documented API 
behaviour, like what I showed above. In the case of -ERESTARTSYS, saving 
information in the argument structure is also necessary for the kernel 
mode driver itself, not just user mode.

Regards,
   Felix


>
> Thanks
> Lingshan
>> Regards,
>>    Felix
>>
>>> Thanks
>>> Lingshan
>>>> Regards,
>>>>    Felix
>>>>
>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>>>   1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>   	}
>>>>>   
>>>>>   	retcode = func(filep, process, kdata);
>>>>> +	if (retcode)
>>>>> +		goto err_retcode;
>>>>>   
>>>>>   	if (cmd & IOC_OUT)
>>>>>   		if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>   	if (kdata != stack_kdata)
>>>>>   		kfree(kdata);
>>>>>   
>>>>> +err_retcode:
>>>>>   	if (retcode)
>>>>>   		dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>>>   				nr, arg, retcode);
