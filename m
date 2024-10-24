Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA05D0BB66
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162F910E1B7;
	Thu, 24 Oct 2024 07:30:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/qoSrN8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8FE10E1B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:30:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7DLvJapss5I+VoGJBBKc13IxJ27fCllhL1PWN/UhUm6uAPpzVInNcOe44pziiKz32WPPzcbKdT/VVuO3D7y3ZY/n6cHPsxdmJDq5gv/ntWkWAIH30TauEkt23C9sS9Q87rin7PKaAzYL2QrRUSZHbqxukRP6GnG585gELeDZKcuYe80LLB5sTreVmYMOmz10I/SNiOEKNjkevp/ob/4IX/QAyhaycR2dfqxCa0giSpOutjKLdr/5gOBU4rNdvWXAHWaZFiSlh/44gglIzkPTo+Sh8k2481XZ3DEcCTderpelInmxr8ch2ykKj88hvbFtMVWgKqkrrn0EQzzmxobbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omRPxpFMzuEfgfqR4Kk2b+NtypyUGhyxuVRZgg0Z+u0=;
 b=DbjJ6IAprlVYcVvPlXTv3rylHFdoziLfOBgqFd8pU8UqzWGD6BgCU76ZCgpdB3Fgj72oV/RVI2GhDyr0Y6CwmpDAuh9WqOrYCXg2OPahuseYdidudt09H3GUTlP0OPbaKKmpb744qY4izCeha/3VlsoaHJjfqspNpjm+RoyFW9taJ4ca/rqvLH0IXg+3AxvkhRl0g41pL3S2M4Lkj/2KWbuIomvG3s8AZRI3BVHAS6oEZfES3+pyggGPATrOBT1XtoEij1m55LknoagHYc9tSrMs3kgm+7K8tfrzUDD9Pio0nDGiZDAMquJeVAaLRwYBXWK9nZT2oGYJsg4klPPI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omRPxpFMzuEfgfqR4Kk2b+NtypyUGhyxuVRZgg0Z+u0=;
 b=F/qoSrN8v73n0ckQ5vDHVm/3GPy6yNidU2umyPyn/YdisSmdwNV53P7KcN5b7lfhQOfUykqrqQm+s0qqewhfwn9F38n5w22IRBAUMf5gEw36QmNcBHtkRSGWsI/6OciCG89mjO/F50HVQ/ux3rmZn7IHpBpjCJ+lRGJyNGM5T7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Thu, 24 Oct
 2024 07:30:35 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:30:35 +0000
Message-ID: <2e7efc52-d6c0-4558-891e-0335ca97963a@amd.com>
Date: Thu, 24 Oct 2024 13:00:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
 <20241014074902.1837757-2-Prike.Liang@amd.com>
 <8ea96dd2-260c-4fd6-a78b-4d491cd0338c@amd.com>
 <DS7PR12MB6005B9EE7961C317C9639193FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <2acb9e4b-6750-4800-9841-cf2da94558f7@amd.com>
 <DS7PR12MB6005BE51A4AD1F10AA9C8756FB4E2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <27dc3317-bac1-4327-b939-8e6db5520ae4@amd.com>
Content-Language: en-US
In-Reply-To: <27dc3317-bac1-4327-b939-8e6db5520ae4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf82a0a-ec17-4d49-f87a-08dcf3fdbff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enZ4Mi9pV1lxT2Vyck1iQ21GWjRUdG1KazVWMk9peklJTFdGbmVWc0J5c3FT?=
 =?utf-8?B?ZXo4dERJa2l5UGhNVkFsMS9NR04vVnJSNUhrZkpkUHBzZUJRTVI5b0tSYTdu?=
 =?utf-8?B?YXAwK3lmK2xIemhUcWZnd2l6Rno1d3ZSWTJUV0prS0Y5L1BxajVBWHgyc0FL?=
 =?utf-8?B?VjBHRXhMVlZCT01EYmUxRUJUMi9MQmJzb1ZKSFQxaXR1dXkxWksrZUJQTVV2?=
 =?utf-8?B?MnhUVFFsTEVUbVNadVF5MUNwN09XOVF1cDhHeUN3V2VBZnFsVzRYOEQ5SW1H?=
 =?utf-8?B?VlRacnBIZXh4RVRFdTQxSmhCR3NZS2t6czUxWUQzRkg5WjRMQ016dEcyeDNU?=
 =?utf-8?B?ZUZmenQ0bE1hMGJqKzR1eVdRWFRqemVGZlVUcFJibE9mMXQ1QktJb0kwSnF6?=
 =?utf-8?B?TS9zNHF0cythejlTVmRhT1NkYXFEUWtZZUlEenJLQWxKWjJlV1Rla0hXMWtL?=
 =?utf-8?B?dWp5czZ3ZFZTdVRKZW4zcU55MjZ5ZmN3U0ozdlBRd2VNaW1iNGlnQVZWbnBO?=
 =?utf-8?B?ZEcwZTVWOXQ2ekpiRmE5VkFpaDFvQ013ek1rL1JUNW5aUlltbWtiaGx1WDZ3?=
 =?utf-8?B?cjhyK1I5TUdnc0ZDbFF1OGk1OGtnM0pudUxwL2xFWDBuOGpFQUpRcTZ3b3d4?=
 =?utf-8?B?TlI4WEFpZE84ckxrbEwzZzIxZ054cDd4NEg5K1k5dWN4UVFCOWhVc0hNai8r?=
 =?utf-8?B?djRjYWNHWS9Dd0Z0RllOV1ZJV3hobUhXVk9wT1ZxRGZXWHFBako4NmlIUVpl?=
 =?utf-8?B?RUh6S3VjK0N5dU9YckhBU3lOR2FoTGVvVGNUZThEbUZFS2ttR1NjdFdGd1Yv?=
 =?utf-8?B?Vlp4NkROUVM4a3FUcU5NNFNjWUV1QXFCcGJmbnJEM29uSjE0d0d4cUw4U2tM?=
 =?utf-8?B?QzlYMWVJbmkxb2hyOGd3Y2xIMVlCUFppelVzUlljTnhxcDVOTWMxUkxUc1JS?=
 =?utf-8?B?bXByMnE1dlpzT2tuQVZyQSttRU11ck9YR1BLSTRjK0l0MXRjL3VwUkN1YUxj?=
 =?utf-8?B?VU82UHFJTVE5bkZRWHdsR1ZzUnFHQUlSUUxOY3I0VTRYLzc4cmhHSGJQNGdM?=
 =?utf-8?B?ZjRGWkVNVVg4YU9lWVF1SEFzOEZaWHVUdlZjb3ZwQTRyUjd2UnhqOWVmS0Zw?=
 =?utf-8?B?elBlLzhEc0o2SnlWOVhkNytOTDg1MERvUEZwa3p2Q2p3R2I5eE5Xc1VQRm9m?=
 =?utf-8?B?OTVFMkNqWGMwSEpzQm5FRU9FWXFicWVPREZoVXNDVkZUcHdBNlVYNVkzRDdZ?=
 =?utf-8?B?dlNZUTZoNTI5STdPUDkveHB2dGxNZHVqVGYwSk1pMWpaYlZablBITU1SUjJt?=
 =?utf-8?B?aUc5TlEzTmlyUldBc2ZRZWNodzhtU05FZFJTNHU1Nnh3ZDJvYTdaM1EvbGdi?=
 =?utf-8?B?cHJSMVh3QThTaStEdE01ZjBGQnptSlY2VjlBajl2VEgzdzNIN2pRWWxESjRK?=
 =?utf-8?B?RlVMY0NjZk9iNWpRcUcxd1ZMeWNacWlMb0VHRTUyeGh6OVF6cjB3UG8wY1k3?=
 =?utf-8?B?ZmFOdDN6UkNTaHZhdTVKY0prbStiZ3QxZHZFK1JOZlZzMlpDMFFEeFJBNk5P?=
 =?utf-8?B?ZmVpdUJaZmtDMHNReXg3QTBnVUxQRVlzYWZ2cnIzc1poYVZTRVR5Z1pvTzlK?=
 =?utf-8?B?QVdqQ2l5NFJTU3VJN3d6RnhVa1pzeXZBdSsvWDZ4UDUwUHRPWFlsenFCaVBB?=
 =?utf-8?B?OWFkMG1PMjFreDRqTVBWWFR5UnVwMGtFS0VXMHJtVWxqaHlmMlVrekdKWFZP?=
 =?utf-8?Q?MTRyn/exY2uyPcdF/AgU9zyS5NDFtxIMSLqN3mJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdoSzBnK3BtL3Job3ZiWXlPczNzcVduVzdaeGRrazdWUVpRSG9aMUN4VXNu?=
 =?utf-8?B?VDhXT0tQbWlJZExFUVFIZUxHWHgvMHBIcUppcVlqcXJUblZZcndZMlJIQ3Nk?=
 =?utf-8?B?YXZDeW1hTXdXOXdTdlFjeTVrSnYzZzY5NjN3aW5KS1hPVjVKb09ZV09yRG5Z?=
 =?utf-8?B?UFB1NkM2a0xwaUVwZ0tJYkV6VXU4QXVxUGRwUEVqb2R1YzZzTVBLVWhaa3NL?=
 =?utf-8?B?d0gzcHd2RUVRSGFqcExVcE9zOUpMSGd6SEZwcHRGUEhVczlueFdiLzdaYjRY?=
 =?utf-8?B?dElvT29wVTE2Z1BpVlBTbTNWQ3p5dGNtYzMxd2pUQUEvem9BODNROXNPRk1x?=
 =?utf-8?B?UU9zUkRLNEtDMlhmcE5NUWFOak93UlZnRWlHNzgwVUNEa0tMQmE0NlZMWVY5?=
 =?utf-8?B?TGQ5VGxuaEpmem5HUFdkOXQreUF3MVdjQ01TbFlvRVJnVjl1K3MyNHhNZ2ZC?=
 =?utf-8?B?bUk2YlFUMU9MV1N5MllVT0czcTgxSEw4dUJqZ3huaWx0Z0RRSFp4WnMyNEVF?=
 =?utf-8?B?Q0pleHViNjlZdjZQNW9tVWJ1d0hVcEloRHdGb0dTWXkyVkZtb002OEdhYVVh?=
 =?utf-8?B?Z3FzSDY0aXFxeFVOWWs2RFIwNGlaTWlwU0JEWWJzb1RtcVFLOWdPajNlQ0ts?=
 =?utf-8?B?WFI1bjkrOTRJNllmVWRPQ0NsZ0ZCakZBVkJUVjVLS1RWYysydFBrZE5XS0NQ?=
 =?utf-8?B?QnFtditFTDVjdXpZbGtjUEJGS0hiNlQzN1BpbkQvR0FLc25tQzBZNFVmdUh0?=
 =?utf-8?B?WGJ4d3ZQUlhVYUlCRDFMZCtUZEZyalBhOFpjUElFYWtjb0kyR2ExRk5Id1d3?=
 =?utf-8?B?WHJWaEtsY09FbGdTRmlROHB5c3M0eXJENzlQZHNUQnNUem1UNWw2NU1iSWUy?=
 =?utf-8?B?Wm9Fb21DaTkrRk8xbUNJcHc3cGNlMllpR2pjbEhCWkZWWkxzNm1ERnBUMEFB?=
 =?utf-8?B?N2lGMWJ3ZkVqTG1WZmhpQnE0TXg0RnBoS1BUaG5ENTRqV2hDNzJMUG0rRS80?=
 =?utf-8?B?RW1DWVZNTkJvTVRLMWYydlB4UXZFUHcwUmtrSkJsbWZUNUFUcHlqR3Q3ZStH?=
 =?utf-8?B?R0t2U0kreHRlMlZ1UkFYUEtqN2w5L0tKQ0F1RlpoeDh3alhrQnhEeG5KTXJG?=
 =?utf-8?B?QlplclZxdmVLelZsZkc2d2xxcjR2ekFON2xGbXpCSE9VVjNvMm5NZ0NwTEJU?=
 =?utf-8?B?R1VBVzkzamlPUlFyYlNybDlESjJTYlhyaUlKc3cvUWhUM2lrVWZFa29RTnNv?=
 =?utf-8?B?bXkvd2NCV1d2Y0VXZHkxYjRMKzhRQkZDR0VhUkx6REdjdmJQZmRTRjZxbGI0?=
 =?utf-8?B?QWtpMlBKYnlpNEpzZ2QwbUNtaEIvNkhrK0FCN0JPcC81cGxYdDJUaCtoYW10?=
 =?utf-8?B?cFJxSVFobmlDUDhZek1TTSs5blNWNWtueHltZDVQdUdpc0FpN2lHZ2MrWVpJ?=
 =?utf-8?B?YVRtaE14V3RYVW1QMjU3ZkpXVlZaUlFXRUdqUHpyRCtpR3RyL1ZoZDlwaHk0?=
 =?utf-8?B?bzkzTjFNM0Y1MzcrUm5GT3RadWw1ZW12bmxtV21WRkhwSnBubDQ1MFNpcW1E?=
 =?utf-8?B?UUZWZWhpTUtOcW5VV3AzeVFPbTl6bzh1SkZzcDNTbHlSY0xmWHd5UFdjZC83?=
 =?utf-8?B?MVNZMjJsZzJleFNKZXppWnFXcGI2ekNLSmlOMkVwaWQ5a1JQK2luRTZDOTV0?=
 =?utf-8?B?SGZrM0VkMDNQa2xWaFpmendjaW1xQkppSlZIV0xaUGoyNWhRUVNlamtKSkdP?=
 =?utf-8?B?T3l6VFA4aWtyeTRxWjhCM0R6U3NFalQxdlQ0R1NXd1hJa1JQanJpS3RaQXNP?=
 =?utf-8?B?UFdjd1pPWVdEa1o1dnZYK1VUNjl0T2pIcmg2S2s5cnJiRCtQbHk3RmwwR3hv?=
 =?utf-8?B?L2tmNEk3S1pTWVFvTklSM0lhblpxSWpvK28wMndTRkFqcW51VnJzZmMyNDR3?=
 =?utf-8?B?M0RHL0c2Mm1QREg2eTFUSEVXandOUTNpcmt3OUhONzlrRDBuT0M4OVVaREEy?=
 =?utf-8?B?YmpvVzBkbC9GQlo2KzdaRWdpV3V2Zy9iYWJncDlsNm14V2VKbTk2Z0NFN3JQ?=
 =?utf-8?B?Wmx6L0lFcW8vSzhKQ0RORXo5OGhFaVVkYlpWa20rc2IvMU5POGhBTTYxOHVG?=
 =?utf-8?Q?9RNVRSckTuJKshMLZm+n9KA0x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf82a0a-ec17-4d49-f87a-08dcf3fdbff8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:30:35.6248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txz+bEkM+ECZGikeZOpbrtYxd2Oz8JUTA1oOu2kV2KAFsU/q/DPTUSEHBF63BkiD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356
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



On 10/24/2024 12:49 PM, Lazar, Lijo wrote:
> 
> 
> On 10/24/2024 12:23 PM, Liang, Prike wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Thursday, October 24, 2024 11:39 AM
>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>>>
>>>
>>>
>>> On 10/24/2024 8:24 AM, Liang, Prike wrote:
>>>> [Public]
>>>>
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Wednesday, October 23, 2024 6:55 PM
>>>>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>>> Subject: Re: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
>>>>>
>>>>>
>>>>>
>>>>> On 10/14/2024 1:19 PM, Prike Liang wrote:
>>>>>> To check the status of S3 suspend completion, use the PM core
>>>>>> pm_suspend_global_flags bit(1) to detect S3 abort events. Therefore,
>>>>>> clean up the AMDGPU driver's private flag suspend_complete.
>>>>>>
>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>> ---
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
>>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
>>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
>>>>>>  drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
>>>>>>  drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
>>>>>>  5 files changed, 5 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index 48c9b9b06905..9b35763ae0a7 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -1111,8 +1111,6 @@ struct amdgpu_device {
>>>>>>     bool                            in_s3;
>>>>>>     bool                            in_s4;
>>>>>>     bool                            in_s0ix;
>>>>>> -   /* indicate amdgpu suspension status */
>>>>>> -   bool                            suspend_complete;
>>>>>>
>>>>>>     enum pp_mp1_state               mp1_state;
>>>>>>     struct amdgpu_doorbell_index doorbell_index; diff --git
>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index 680e44fdee6e..78972151b970 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device
>>> *dev)
>>>>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>>
>>>>>> -   adev->suspend_complete = false;
>>>>>>     if (amdgpu_acpi_is_s0ix_active(adev))
>>>>>>             adev->in_s0ix = true;
>>>>>>     else if (amdgpu_acpi_is_s3_active(adev)) @@ -2516,7 +2515,6 @@
>>>>>> static int amdgpu_pmops_suspend_noirq(struct device *dev)
>>>>>>     struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>>>     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>>>
>>>>>> -   adev->suspend_complete = true;
>>>>>>     if (amdgpu_acpi_should_gpu_reset(adev))
>>>>>>             return amdgpu_asic_reset(adev);
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>>> index be320d753507..ba8e66744376 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>>> @@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct
>>>>>> amdgpu_device
>>>>> *adev)
>>>>>>      * confirmed that the APU gfx10/gfx11 needn't such update.
>>>>>>      */
>>>>>>     if (adev->flags & AMD_IS_APU &&
>>>>>> -                   adev->in_s3 && !adev->suspend_complete) {
>>>>>> -           DRM_INFO(" Will skip the CSB packet resubmit\n");
>>>>>> +                   adev->in_s3 && !pm_resume_via_firmware()) {
>>>>>> +           DRM_INFO("Will skip the CSB packet resubmit\n");
>>>>>>             return 0;
>>>>>>     }
>>>>>>     r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 +
>>>>>> 3); diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> index 12ff6cf568dc..d9d11131a744 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>>>>> @@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct
>>>>> amdgpu_device *adev)
>>>>>>      *    performing pm core test.
>>>>>>      */
>>>>>>     if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>>>>>> -                   !pm_resume_via_firmware()) {
>>>>>> -           adev->suspend_complete = false;
>>>>>> +                   !pm_resume_via_firmware())
>>>>>>             return true;
>>>>>> -   } else {
>>>>>> -           adev->suspend_complete = true;
>>>>>> +   else
>>>>>>             return false;
>>>>>> -   }
>>>>>>  }
>>>>>>
>>>>>>  static int soc15_asic_reset(struct amdgpu_device *adev) diff --git
>>>>>> a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> index c4b950e75133..7a47a21ef00f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
>>>>>> @@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct
>>>>> amdgpu_device *adev)
>>>>>>      * 2) S3 suspend got aborted and TOS is active.
>>>>>>      */
>>>>>>     if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
>>>>>> -       !adev->suspend_complete) {
>>>>>> +       !pm_resume_via_firmware()) {
>>>>>
>>>>> Looks like this will cover only ACPI based systems. Not sure if that
>>>>> assumption is valid for dGPU cases.
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>
>>>> Yes, the pm_set_resume_via_firmware() function is only called during the
>>> ACPI_STATE_S3 suspend process. However, ACPI-enabled systems are popular in
>>> the desktop world. If there are concerns about ACPI configuration, one option could
>>> be to check if the dGPU needs a reset by directly checking the SOL register. As far
>>> as I can see, when the dGPU completes its suspend process, the SOL value will
>>> remain zero until the dGPU is resumed. Conversely, in the case of a suspend abort,
>>> the SOL value will be non-zero.
>>>>
>>>
>>> in_s3 is set for dGPU in case of s0ix as well. Probably, that's the only case where
>>> need the flag to avoid unnecessary reset. Otherwise SOL check could be sufficient.
>>>
>>> Thanks,
>>> Lijo
>>>
>> Do you mean we need to include S0ix to reset the dGPU during an S0ix suspend abort? However, the in_s0ix state of the dGPU should always be false, and there is no specific suspension handler for the dGPU in S0ix. As a PCIe endpoint, the dGPU should be powered off during system-wide(S0ix and Sx) suspend, and the SOL will be reset to 0 during the suspend process. So, for the dGPU resume case, do you think it's enough to detect the suspend abort event by only checking SOL without any Sx filter?
>>
> For S0ix, I don't think there is a requirement to turn off all endpoints
> - for dGPUs that don't support D3 or runpm etc. 

To clarify, "don't support D3" => what I meant is when D3 entry is
prevented.

Thanks,
Lijo

Then even if S0ix entry
> got aborted, but GPU is suspended properly there is no need to reset the
> device.
> 
> Thanks,
> Lijo
> 
>>>> Thanks,
>>>> Prike
>>>>>
>>>>>>             sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
>>>>>>             msleep(100);
>>>>>>             sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
