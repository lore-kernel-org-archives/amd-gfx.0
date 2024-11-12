Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90077D41D63
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 07:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D89110E58F;
	Tue, 12 Nov 2024 07:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1qZK1xSh";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FE710E57B
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 07:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCZW7/PwnPZbNyXOd7ObpHVUTf9iBi2Cm0LINplLghNZPBcneCEGGQYthTnN8Ce2sq9VXka6u04xdokTbPYqu5gCIlQ16N0k37K3m97c+8qGjy0PN9GzJhxpP15QF9NAYnJtMRLFQG9X/VjJK1HSN/31o+tijutlzWM979NB+O6IP6d47Fk2YVmVbcVaHCMCnePw/hTXsF9+NaDGYjcQICL3jmUteLv3EQS4KaX0eOMvyf8qqH//0Vdd0shPpPEs1yG5Yn1BGaKb0PTZU1mq7ddPvoO3AFSWqaQ9uvoDFmLvYoYvlsDsUhg0Krakv9vh/oLpuN2NqXdqSd3ZP9+Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5znFm7I/PkfiYGLrz07qP2F5CSOBam3Wg19O8XLLGM=;
 b=EoxeEM1z9lKGRo1F+5jhmUS7xFozN4BxwHSdrLB+6qQCOZtUHOI3v4flfHD9/zWe48aIp1wmN4O8msjDQMGlDQvuMkHMZcEC+DJi//U71OG8mnRZiRAkO8B8+otCv80QIp+Q142Vkqx3lSfQoB+JZpaTiHqrqTadId//rCwQWi88ZwrNRlxbyfu3mwLTDsyhg9TSTCrZm2GkyIAzbPw1aNsZGBb2iBSOs5mUuRZsbSAou4HEC4D5sJOrGdRJUG10a3wY0Uhec/C+HcwZ3fGHpPGRNWp4cxZz5QNHcD9/YzMVZxeQ7KPeRLFOhUlCycxaYfSghPGyPfzw5n12chtd/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5znFm7I/PkfiYGLrz07qP2F5CSOBam3Wg19O8XLLGM=;
 b=1qZK1xShsGpsK4DG8Feg8U3EvD6aPyoz5MjZteulATU4ClceZ48q+4qROsRv/FIE40+n0RFHiTjz54w79FxYyfIt8Y+pyasx9N+Ze7OwQPSz4y0XGoj1fXatJCY4lzqCrGWUXzvqU7zhS+pP8j/dwRor9hGq9NlNo/5/GNpEPSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 07:35:50 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 07:35:50 +0000
Message-ID: <87029c10-4fce-4a42-a04b-ed2633c69148@amd.com>
Date: Tue, 12 Nov 2024 15:35:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: check ret code for ioctls
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031105059.251085-1-lingshan.zhu@amd.com>
 <616bc79f-ad92-4b22-8df0-0a0ebe27fcf6@amd.com>
 <2ca21e92-6324-413f-9df9-0bfcf638c669@amd.com>
 <76ef68f6-dd23-41b3-8dec-d35e6874de01@amd.com>
 <cc6f4141-a085-41e7-b772-8c400788c1b9@amd.com>
 <d96c1117-7eb9-4c65-ab0a-1f4507d32674@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <d96c1117-7eb9-4c65-ab0a-1f4507d32674@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|PH7PR12MB5733:EE_
X-MS-Office365-Filtering-Correlation-Id: 0008f86b-37fd-4dd6-83b0-08dd02eca189
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aG9BMEYzKzFuUEtSRHhIZk5rNEx3S2NHQk1BWnhjSlpnS3prRk1sMVBkZFF3?=
 =?utf-8?B?bFNKY2FHRjRlTHNNK2dwNGsyQjRFRXJ5MVUyS1JOd2w2M0ZVTGVFMTFUUjZ1?=
 =?utf-8?B?M0xzSnp5Tlk3UnV2Y2xPR0h4ekNoYnkrY0YxdDdVb0M1YkxSN2QweWJ0Wlda?=
 =?utf-8?B?TkR0eUdIUmRrWEFadTRUZTRYbzd1QyttSDNjMU41UFQ1TjJyaUZKZFdTWTBy?=
 =?utf-8?B?ZGE5N1BOd1c2QlJqRVNMWmJYbE9kWDd0RnBncFBYT2F5d0QwWjNhVFc5SWYv?=
 =?utf-8?B?Q2pvV2NYSG1JNTVIMDFmNWlSaGNMNGVNSS9CbnB5OVpUQlVMakgyQ0hxTmJL?=
 =?utf-8?B?VmJzcERIZ0NET0N5b1FadTBjWGRhQ0xOYVBDczVFRDZKMERaYXh1ZTREWXhB?=
 =?utf-8?B?MkUrR1Ezd2pGL1I5czhsaDN2SVNTdUY3cmV6ZjdIZjZSSnBBcGtPTDUwcm9E?=
 =?utf-8?B?R0RZdU95WmN3dXdwQTdRVHluWlk0NjVzNkhKZHRSbEZBTUJnNkltbGZPaW5l?=
 =?utf-8?B?c3d6RDlDU0lESVoxeVkzVExFcXNad01pNlltb09ydytpUENSVEcyOTVuVkd1?=
 =?utf-8?B?MXd0RU9wcVNIVG9weE9YVXpxS2J5bFVKTStyYzRPRWVhOGl2NmdQRU13Qmdx?=
 =?utf-8?B?WUZVLzl6a0VRb0ErVHA1cjVTekZqbnJ0K3lodVFzL0tOL3RBaEhZTVZPQXZt?=
 =?utf-8?B?RlQ2VWN4VFA2MVpRY0RxZXZDUFgvUDZ4SHI5Y01uOVhGU3d0Y3NrQWJvWXF2?=
 =?utf-8?B?ek1MWGZYcDZPTTBBWEVsc25LWmkwVnROYWZVYWg2ZUJFMXNjaTFkUHhZRXl4?=
 =?utf-8?B?aGZ5VnNJZC9IRkdHRXgxNUZHaGtyRzc1S0FUb1pkVitTL1NEeXpXd0M5NVA4?=
 =?utf-8?B?alhzWCtsUTBxYmVQMGprR1RqWGtOd1dYaTBlUS9zTEZ4ZDd3K0doeTN5UE5z?=
 =?utf-8?B?bjZGOWg5Mll4azNCczlIcElDcEFHYThnQS9sRXpBZnBnTzB0a3FRanRRakdv?=
 =?utf-8?B?WUJ1Z3FoTWxMVjhyaWhmYW1zYkpJSkZkZnlCa1V4QWhmREJsVzJ3dHhHcUt0?=
 =?utf-8?B?SnFDVWNUNDM3aGhvQTkxd1pQOGtEaXcxdFk3SjlXZlA5aThtYnRZbzdMV0V5?=
 =?utf-8?B?NUR6UFhkUlMzOFhEZU5sNXQ5VzBPdU1xWXp6WjMrYjNFWFJabm54enNSWWRX?=
 =?utf-8?B?NWYydkh3N1AvOThlUmFHTkFQYWVieVpaOHBOQW1SUGZGUDRDdlkzZmFrbWxi?=
 =?utf-8?B?T0RWZ0o5OWZFWmU1cDBqVTd5Wm0rN2hlaFN5cENhZVA2YWtHNkFJNzRVRUE1?=
 =?utf-8?B?cm9rREw5VjBpcER5UFJWRFBydzB6VWl6VDRsNmxpYmZYQm9lakdHOGRnR0Uw?=
 =?utf-8?B?Uy9MbHQ1K3VqYTcxbk02Uk1RV3pmWFl6Qll5M3MySmVzYnRjakl0RWR5dUYz?=
 =?utf-8?B?bU1pNis4U3FFRlNxODZLUTV2anRoeTVkNUN5SW9mYXhKL0FZUnBGVW4wblV6?=
 =?utf-8?B?d2RHOCs1Qzc4YmlUMjR4aXh4cFZHM25PUHZ3eEMxa1JEWXR3WHBTQmkraTdB?=
 =?utf-8?B?UzU1TCtqeEx1OXhRUU50OEpOV1pSc0IzVm5LcXFYQlR0SFBlTi8vZi9tT3ZB?=
 =?utf-8?B?bTN0aHh1VXpkenhJWmkzNkdCRjFad2lOZE9LLzFzQ0xkYlFldWxWdkVNd0E1?=
 =?utf-8?B?Vi9jcWNlNVg3RFpDZktsdWhOSFBJcmFCRHBiTjFhNTVaYVBJUU15R0h5S0xw?=
 =?utf-8?Q?rn/QHgpcBX8l60EwKmv4/tT+PqpwcGflaJdX5S1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDc1ZXlzUjVJOW9HM3pUVnFjNUVTVnZpOGppWmRoaCtZNmkvbWZpSFkyVHNZ?=
 =?utf-8?B?WlVjSlhnSGIwd01adHpMaGtUUjVxL2l2a1pSNjJnWXZJMEMwakFHUFRDaXd3?=
 =?utf-8?B?WE5XZ1RVdm56UzN0ZnA3S0pwbG4wZGdSVTFSSjZ6cXQvRmc5M3JwSVpZdkNK?=
 =?utf-8?B?eko5ZjA0eHBiaXg4bTIzOEFrSkgyeWM0cFo1YVRiK1diVGR6SDhWNTFoYUZJ?=
 =?utf-8?B?d0s1SWlVTkdZc2FkSHJ1ZE5RTDVaVFBlNjFiV2RkODNZQWpTN3MvRkZDbXhI?=
 =?utf-8?B?aUloQzM4QUZ6eDRvMHdFb0VPUzNGZnpNTURHaWhzeTFDQkVXbmVLZmNtdjZ0?=
 =?utf-8?B?NldLSmc0QUNEWDVCNStPKzJJSkIybTFrMlhkUWJqaWNIT1ltTXNlU2N3RnRV?=
 =?utf-8?B?bUdTVnBERlhQN1NSK1FSOHF5UnpoT2VoVFM4c25VWW9pMDNuRTJjbnhXUVMx?=
 =?utf-8?B?b1hGeFhCMmc3VmtHcUtRVEJBMzUwNEdBb2FIekhYT2I1ZkVqVVlaNmcwWmxI?=
 =?utf-8?B?QkM4elQxakwrNm5nNjU4OXZyaFhVZ3FnT1R3NTVzYVFUYUREKzgrRWIwNW9C?=
 =?utf-8?B?c1JIY2RuM1VzMjZJMW1OQ0o3RHZDT3lBamJjUzlIQlV1ektUZ29rYVZ4aGpJ?=
 =?utf-8?B?WkVWTnRBbHNZd2JoclVZUmVvWGtXSmk0aVNabStzODc3M2wzcStuV0xtdW9S?=
 =?utf-8?B?My9rS0R1Sk9sVFZhQTZ4Nk1UeUxuRTFMVGhkUnZ5SjFsa1NWRHc4aUNvenY5?=
 =?utf-8?B?eGZYblFldzJ4ZTVUOTVRRDAzZnYxUHQyYVBHbjczT05yUk5BdjZxQlFYNmhk?=
 =?utf-8?B?TE9MR04yZmV4Z3N1STdWUFlGSnpMNXk5bVZDeFBJNGVZcVV3RXhLbWhqWVBD?=
 =?utf-8?B?OGh4YVVMQTZKb1NyUVRnRzdUc2pMaEEvQXZtRjhyTGRPVDBLV3JIeEVwNXJ3?=
 =?utf-8?B?aGZrYkt6cVJmWkIyeGw0TEZDRTBVdlJaWS9HRnlUNmNJUlgvRG11L0FDNEtW?=
 =?utf-8?B?L3VmdFlRZ09wdFd0eHpxTUlGNGFPNjBZazFCdmpSVHhqSWR3TkZNem5rUFFi?=
 =?utf-8?B?QklCb2Y5amhrWTJ4blpPTnYrM1paemVkWEZHOEV2R3RGeHZEeHd6ZDZHVXZv?=
 =?utf-8?B?T1pkZVlJaTN3Y2hCRll1aU5RQU5DdnJUY09tOE0yc29VaEtwVjZMZmcrbHh0?=
 =?utf-8?B?Yjlub0FnNVphdTZENE01RDdIVVdSNXN0L0VDL08xSFlDSjFncGdQWVFYd09V?=
 =?utf-8?B?Sm01U1MrSnFQTFpNVkZvR3J3QnlJcXQrQmJFd1g4Z292aEpzTDZGM2VyZnFx?=
 =?utf-8?B?WHFlMmpvSXB5UW1LVjQ0UXBDY0NWNUhlWnc2Y2QwR3FJcG56QzBscE5mUEJN?=
 =?utf-8?B?Q1ovVUozNEpIalNwejEwYlpNdzBHRWcrOHJ5UFpEY1JPblhyRkZHeXNrQitr?=
 =?utf-8?B?Z3VkSkNZM2ROMGhnMkNHREt1MFJTRUVab3g3empqN3huWDFWWGYyb05wYWlJ?=
 =?utf-8?B?dXhWWk8vdkYzZk4zamZoNW42NkNhNVdnNHVjK0hBdkNCRkdlZFkwbFZoamlM?=
 =?utf-8?B?STZJVHhiaWJtY1dKVFhiNmRwaGYraldZUW5IU0hjYkhmcE1lbWg2aExISFJG?=
 =?utf-8?B?TkJCYjBadllobTNEL3gxS05mYjNFMnM1YlBOQjZ2eWNYZzBxa2w1YTBSUjNz?=
 =?utf-8?B?Q0lZbUc2WC8vcDdsaWJMblQ2ZlJnT3ExZXA4allKa0pwUm0xTFBZMy9JTUkw?=
 =?utf-8?B?cU80Z3dzbkE4TVBZMVVlcWlVMWNCSnhxdkhmLzNVNFp3d0ZxVGRDOFFVclhB?=
 =?utf-8?B?QkZSbGlVcjdqZDFLeWpjSkdwUXdsdjA4M1pvckFRNXJLREpDMHc2VjVQYzRY?=
 =?utf-8?B?MnN4SklVdkp6Sysvc1FCSEcrcXlrbFI0Rm1KL0RxTGhlUDZicGJMRHJIblVG?=
 =?utf-8?B?RExOYk9FUjgzUHNZTm5kaVNwWEFlUmhzWDhMdmtVbEc0ZkxvUFFvLzMxRzFr?=
 =?utf-8?B?STdzeGgyb3h4eWdCVThFY3UrUm9ZY3B3N3oxMjNZcEgvMlNCZGlRL1cwdUZi?=
 =?utf-8?B?YWVRbE53bnFIRjBqM0FaRkNSdGZ6ejFaYkk1aS9uZUZYeDhMNXlXU2dCM2s5?=
 =?utf-8?Q?E50/jdoYu+s+boluiHhlXkSdL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0008f86b-37fd-4dd6-83b0-08dd02eca189
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 07:35:50.3275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ch70K4K/P4x6AOYgJM4E33ACTSidWBohC2jBxF+3+MvWMxynbSSFvE4ni869BjvsOLPBdY53bYyu9GowbOdng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
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

On 11/12/2024 6:21 AM, Felix Kuehling wrote:
>
> On 2024-11-11 03:08, Zhu Lingshan wrote:
>> On 11/5/2024 4:50 AM, Felix Kuehling wrote:
>>> On 2024-10-31 22:35, Zhu Lingshan wrote:
>>>> On 10/31/2024 11:30 PM, Felix Kuehling wrote:
>>>>> On 2024-10-31 6:50, Zhu Lingshan wrote:
>>>>>> The ioctl functions may fail, causing the args unreliable.
>>>>>> Therefore, the args should not be copied to user space.
>>>>>>
>>>>>> The return code provides enough information for
>>>>>> error handling in user space.
>>>>>>
>>>>>> This commit checks the return code of the ioctl functions
>>>>>> and handles errors appropriately when they fail.
>>>>> I have reviewed and rejected this patch before. My opinion has not changed. The existing code copies the ioctl arg structure back to user mode even in error cases because user mode needs additional information from that structure for some ioctls.
>>>> how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? There can be other user space programs other than thunk.
>>>>
>>>> what if the user space program doing pulling mode, it can pull the args changes because ioctl is usually slower, our code should be robust.
>>>>
>>>> usually the return code provides enough information for the user space programs.
>>> I don't understand your concern. Even without your patch, the failing ioctl still returns the error code to user mode. User mode can safely ignore additional information returned in the argument structure. You are raising concerns about performance or robustness. I don't see that either of those are negatively impacted by copying additional information in the argument struct to user mode.
>> Still the questions:
>> 1) how can the user space program distinguish the "good informational parameters" from the  "bad default legacy parameters"? 2) what if the user space program doing pulling mode, pull the args before error code returned. Memory changes are usually faster than error code.
>
> There are no "bad default legacy parameters". Ioctls that were defined to return additional information in the parameter structure on errors have always done so. This should be documented in the kfd_ioctl.h header, though some ioctls have better documentation than others. For a good example, see kfd_ioctl_dbg_trap_get_queue_snapshot_args and kfd_ioctl_dbg_trap_get_device_snapshot_args, which do return the number of queues or devices in the parameter structure if user mode didn't allocate enough space.
>
> Another example is kfd_ioctl_map_memory_to_gpu_args and kfd_ioctl_unmap_memory_from_gpu_args, which returns the number of successful mappings if the ioctl fails. This is necessary to restart the operation after -ERESTARTSYS and skip mappings that were already completed.
I believe these are bugs that should be fixed. If request N but only allocate M where M < N, the kernel space should return a proper error code and then user space should reduce the requesting number, like N/2.

We must keep do defensive programming to reduce potential risks & bugs, keep our system robust, we should not assume the other side work perfectly as expected.  
>
>
>>> You mention that there can be other user mode clients other than Thunk. That's true. E.g. rocm-gdb calls KFD ioctls directly. And it depends on some of the additional information about errors. If you know of other user mode clients that are broken by the current behaviour, please point them out.
>>>
>>> Before anything else, we do not break existing user mode. Your patch breaks that rule. There is really no room for discussion here. I'm not seeing any reasonable argument to even consider your proposal.
>> If a user space program needs to read arguments to do error recovery, then it is a buggy user space program that should be fixed.
>> Usually the error code provides enough information for error handling. Why our KFD user space are exceptive?
>
> See my examples above. User mode is not buggy if it uses documented API behaviour, like what I showed above. In the case of -ERESTARTSYS, saving information in the argument structure is also necessary for the kernel mode driver itself, not just user mode.
so we need a list to document what parameters are guaranteed to be safe to read in user space? And Kernel must always make sure the parameters are reasonable even when ioctls fail in the first place?
I am not sure this is a good practice, we don't see many drivers rely on this kind of design.

Here is an example explains why this is messy:

kfd_ioctl returns -EINVAL if the requesting ioctl number > AMDKFD_CORE_IOCTL_COUNT. Here no kfd ioctl functions are invoked, therefore the arguments are not touched, they are legacy values or random values, even all 0.

Other kfd ioctl functions, like kfd_ioctl_create_queue and kfd_ioctl_destroy_queue, they also may return -EINVAL, but the arguments may be modified. How can the user space tell whether the arguments are modified by kernel, containing useful information, or not touched at all?

And what if the user space pull memory changes of the arguments?

Thanks
Lingshan
>
> Regards,
>   Felix
>
>
>>
>> Thanks
>> Lingshan
>>> Regards,
>>>    Felix
>>>
>>>> Thanks
>>>> Lingshan
>>>>> Regards,
>>>>>    Felix
>>>>>
>>>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>>>>>   1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> index 3e6b4736a7fe..a184ca0023b5 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>> @@ -3327,6 +3327,8 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>       }
>>>>>>         retcode = func(filep, process, kdata);
>>>>>> +    if (retcode)
>>>>>> +        goto err_retcode;
>>>>>>         if (cmd & IOC_OUT)
>>>>>>           if (copy_to_user((void __user *)arg, kdata, usize) != 0)
>>>>>> @@ -3340,6 +3342,7 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>>>>>>       if (kdata != stack_kdata)
>>>>>>           kfree(kdata);
>>>>>>   +err_retcode:
>>>>>>       if (retcode)
>>>>>>           dev_dbg(kfd_device, "ioctl cmd (#0x%x), arg 0x%lx, ret = %d\n",
>>>>>>                   nr, arg, retcode);

