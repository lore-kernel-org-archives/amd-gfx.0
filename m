Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9C1D1BDED
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2024 20:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34EB510E4B7;
	Mon,  4 Nov 2024 20:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OX4u0uAy";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A75810E4B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2024 20:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IlVrwZCurQNydBzokOb13MPQpaWbmY7Hub0+qD4xtRQaf5kcTIQqzzPLuLhz4l3VUr6vCcZ8hEuRvv2lc1aAAnhjoszSGG19eiDs6U+Lai83IvlcDpMFCzaKtKONKmd5BB8p6LipLiJIP1rnM9pxaLYC0WsxFnRGsocjvvnV9Wkpd2tlLqKq4DGIzpg9IOWZu2WHU/FuoikviABZMmybtA8mINKOGJDimEOg6iXqPTrCSedJRp1qF6e0zZO5O1cDk+uGw8hHugs0GIRoaxYzBuu/OVP95Xm6mQd1+183tc22epZ9XYmNcelh1LvLInwKjDHo4LZ2m+6Ff8QnL1MylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG0v1KSV1gtGzIQbGUFjQ19kCRagUEbMta7dixf1Y9I=;
 b=voM+H9MnyIsuY5/S3YOF4zm0RqhSFZquRgmcWpft4CjtZo3Ct8pWJ6u3BDqttuuSu/6p1mUyZmuFEh8+O9UnJS3GS5ubWyh98UKPFngFGUCSKnExTyyrK7REDG4HAOALnmigK1L561/dhKBPhJ6zZ0yJ8bhSIN/WE3fDXXJ5pfbgVX6+GKKyfAGgNrKY9pUvbBJ8asJZruPBg3btTW2eNshO53xu1kHfax0LNK2nB7JhAAnJn8gid9ux9oon5c7DoyqyWymIsaZAK6qA+XcaUnbYF5FPebEkkLROmmQcDQJMNe22Wt5HOQtg5rRUY/YPGaPXhzd3HGn3N0Iaxl/DDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG0v1KSV1gtGzIQbGUFjQ19kCRagUEbMta7dixf1Y9I=;
 b=OX4u0uAyiKvZGxNIs7jWVuenDep80u5J10QMRYBntkL89GWhMUtWupCQjP9jAEtYmS5o8rIh6cmMkNGVPINuraZxtnZyJnGAeF0v0WpQugcqF+nQngqMVo3VBiLQY9TLOPaWc5v4QoONHo+4rv45zVHNLGvzeff5/XOikKGEKTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 20:43:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8114.031; Mon, 4 Nov 2024
 20:43:27 +0000
Message-ID: <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
Date: Mon, 4 Nov 2024 15:43:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
 <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::34) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ecd1ff-da03-4986-3b89-08dcfd1155c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUp0Tm4xNmlXVitzZEF3aStBQkdMSkhsRmtWVjRvVjUrQWJGcUJsdzhPUFdG?=
 =?utf-8?B?RGY2TlNLKys2UXVwaFR0dklsNEFTUDZvUWo4WXM1eS91b2tJWHI0b092Wlk2?=
 =?utf-8?B?V3ZBSndUeTN4d2d4MWRkRG1waDlWYlV4OWZYcjNzQUJEeldHRy9IZFZ2TmtG?=
 =?utf-8?B?RnJOeTZwT2g2NE1EWDkrcGhIWEZjWTd0ZHhHTDJWOUh5QmVnMkNtVlJCbXN4?=
 =?utf-8?B?RWUxV0ZnSm1FeHlmV01TSFpSdVNQSjdLVkVJYmJZWmZ2RjBUbWVSa3RxRlNx?=
 =?utf-8?B?enNFV3ArQjBkV0NTYjJGcTF1bVdScnl1b1l6MXBUWUFSNDdXY3ZOMXZCOW1W?=
 =?utf-8?B?TENEd3FwN2xpdSszYnJZU1MzcFE3d1h5UFVUeTZXS05tSzloMUVJbElnNkll?=
 =?utf-8?B?ejBjaDdLZ1lsWlk1aWxsT0V4ajdPbVlRZmtXa3NhT1Zyei9MRkFNZ0VxbnRo?=
 =?utf-8?B?WHdGdUFmMU5LRTRSL1NYdkltU0RGc1lvSWttMDlPQWJOSElEQVAxMWdaRnNQ?=
 =?utf-8?B?c0ZYMUVMeXZkc0huYld5UnQ2VWlveGYwY0RFWG9hTEZTRTlVYUpUTlRMb2g1?=
 =?utf-8?B?YmFaNmFMTjJxaG8rOFZmNEhmNWswVkhncUE1M1Rpc2JYTkYxMDBtTzA5elVT?=
 =?utf-8?B?cHJkd1RlM2xmZ3F5M1pkWTM0am9IdlBhcGt3V1ZlT25MMlJycDRFeFJ2cHFS?=
 =?utf-8?B?ODBaWDlzdFkyT0pWU0JBM1MyNjZOaGFoQWR6VmdkWGRxWExoUFNCUGNqbVkw?=
 =?utf-8?B?cXdDUFNsR21DSzY5NGRxUWphSVdqS01yOWFzYkozZDBqRk94MkE4L1ZPSEhR?=
 =?utf-8?B?V0NsV1U0VkVwdE53ZVlHK1RuYmQ0MnFGa0lYRHJITWozbGxYTkpvcUxVUkpt?=
 =?utf-8?B?SFExb3kxeXFBeHJGSEttaDZmbnU1VnJCcnJ0SnhjQWgwT09weW1ieFVmVThs?=
 =?utf-8?B?U00rdmFzbFJUejBPeTQ5MUdzZnhrYUhHbkEveVl5YU1LRFBKU1cvSmZ2ZVRT?=
 =?utf-8?B?amgyWDkzbjNZUS9meWtYMnRjbS9NWnlOdC82TFl3WE14RGxjNGlIQlZOY3lI?=
 =?utf-8?B?QnFTeUVqSEJXTk00YnRFYy9XaitGelRKL0NZN2pCTnBrLzlwSHcrNHpCTndL?=
 =?utf-8?B?Y1RRc2NzY29kYXRiNmx1K3JOcXlmSlZGODlUcHlKb2RuZUlQMkZBTDJBdEts?=
 =?utf-8?B?Z3MrbFdOaWt4QmFDTkR2VHd2UnVMeWsxaGYxZDc0cUhmd1ZaM2s0M2RDSkMy?=
 =?utf-8?B?eVhJbE9FMVJoUUhCUGZBcS9SektYaGljbkx2cVIyRVdwbUxoSUZHRFBIb0dN?=
 =?utf-8?B?c0xaWS92ekVlRjh0QzdibmhnVloxb1RNQWxwUmpUUnRpb1ArcUp2RU0wSHk0?=
 =?utf-8?B?bTk5NlFmeGxmYzdySHlnRkc0OGwvUzdnUTZQMkkveC9QbDRaWWpIMEF1Y3Z0?=
 =?utf-8?B?ZGwwcDQvN1JvRDk1QmhVZkNSTDIycDJiUmhjbW54MCtTQjBOZ2ZaK21XQ2pL?=
 =?utf-8?B?VGd2S3JNZWVINE1tVEh1eXlUQThzYjI4b0RYVSsyOTh0S3I4SmJDUjV5NzRE?=
 =?utf-8?B?V05Qd2JRWUhXV0VHeVFqZ0dxZzN2VUtKaWlMSDRqc1hmWlkvUmxhb2FFcmFN?=
 =?utf-8?B?U0Y3czVTSVVZemdpdTl5REVxeW1WZ2RzZ2dISXcvNWlubzJaR0RHVVhBVjNY?=
 =?utf-8?Q?wtZe0yImgCvInjgqqI37?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVJCNCtHNm9ORnVPS0ZyTmtwU0MwODFKTlhJb1M0VU1USUljWThUQnBCT2lt?=
 =?utf-8?B?Z1MzbzZNM251dXZJZ1FNSkJZME9XOHNCd3dGdEIyeU1NS0RYSWdFdjhZZ21w?=
 =?utf-8?B?dTNzeTJ4bmYzT1plbHNnSkpkblplRDBQTnlyY0RTdmZmcHNlTFUxKzdYYmZk?=
 =?utf-8?B?emNJeFZncS9xVlFUOUlESExibUtoUkhhV1JzRW03enVJOEZhVzhZVldEMjZ3?=
 =?utf-8?B?SUVaRGtwWk5hcUxyd2JzYVhTQ0xpQUlLTDhKbFQ0RnJjQTZ0OEdIZ0lrcnl6?=
 =?utf-8?B?bHRtYWdUNnV1VVE5S1pHWENXSm1sakcyaGI1eGl0bWNtaW85ZXFFMVBvUnBO?=
 =?utf-8?B?NTdIeERIcmZ3a0drT3BPMzd5c0VZRVROOUpZWWU2cUNGMnBHT2ZZTXErc2Zu?=
 =?utf-8?B?bmE2cm9ISklCR1l1bWRleHg1TTc5Vkt5WWNBSC84WFVVUy9FWDF2MXlFc2lh?=
 =?utf-8?B?SEVYWDZkK1ZjYTVLMW94Q04vNHhONFdEYjYwSC80S1Vuakd1QUd3TUFBdlBS?=
 =?utf-8?B?MmNVajNreU1pN0tVSWdEajBkSkVYY0h4Y2dZNm9zdmxCeUgyUThwWjJkWkM1?=
 =?utf-8?B?NDVyMnlZMG43TzRKK0FvZ1lyR2xvUHVpN1BTVEIySFdVaEh2dm1GWnNPN2xq?=
 =?utf-8?B?cXJ6RjZac1dPUGdEL1pKTnM4SEl3QVNmSThZN01XcGNvWVZrMSthU0ZLR0o0?=
 =?utf-8?B?eElLZVYyZmo1NG8xYnphM20yMmNsZGYrK1Q2VHlDaEJJY0tlbXZJcm9tT3cx?=
 =?utf-8?B?M2RQNk9SbTd5VWcrUFA1OU5YZ2c0Vk1sdTFkM3dySmh0UGUwUE5Ma1p2eWNy?=
 =?utf-8?B?MGh3RHNJNWtUbkVhOVFsV0xMS01VcWpwWjd3dUpOdDRESDBURFFnQXI1MFkw?=
 =?utf-8?B?NjlIK2FJMnpKRVJlUmxnZE9FamdFZGE0TWV4THJMZG8ydytSWjdOVjByVm8z?=
 =?utf-8?B?UER3c3pVdG9JMzRxdTNuYkZHVW5yc2d3eUVBKzNoTzY2b2tvYVcvZmptZkEv?=
 =?utf-8?B?WUpYUm1VOTdSWHp2VlRjNnRPSkEyMnpDRm1CbDhlQ3lRVUVvY2wvYWFiS2tD?=
 =?utf-8?B?OS9ZdjRsVEl3MTROYzFSODNQaDVXeTMrd01ERW5DQ2VhbFZSb3NzcUFEM0lY?=
 =?utf-8?B?SGQvRTZHVXJGTXYzamc2ZmVLWjFEVDRaQjRGTEJQMlpqY0hiczlZV0d6cGxh?=
 =?utf-8?B?ek45aWdMNllRM1pQOWN1bHAyVm5nQUVNQWF4dHZ0dGNtZkJXZTgveklRTzlT?=
 =?utf-8?B?WHBJRVJwN3F5dnYrdkxoMmlFNjFUUUdWQVJ1ck5pUTlxRndhbkRXZlR1NWVP?=
 =?utf-8?B?VVZJQ2ROTHFoZCtFaTNtbjVuQ0kyVjhnV0xTMGpGN2tYS1F0amdTZEFFeC9x?=
 =?utf-8?B?ZW15TjNiVHlLYjZMMldRYmFKY0d3YUZJU3cxd3pTR3F0RDczdG1JQ3BFd24z?=
 =?utf-8?B?dTIwUi9USkxITE96TC8yNTMveUZhMGh5ZGhicUxTT1M1bHBzTEUwVkdTM3hw?=
 =?utf-8?B?ekxWZDYraUxhQUFYbS93Nlp6TmVCbExMZXhvYURneklqUGJIM2hHWjd3bVd4?=
 =?utf-8?B?THRwREQvQVMwZDNFT2NpZzNHRmtRMWhHSkdNQWk1ZkY1Z1N5YVJsSncxTVh0?=
 =?utf-8?B?cERFb3Y2N0tyMUxNYnZ1c3pKekNINUZBV0t5L1BjNTRHRVJCTmt6QWRlOC9X?=
 =?utf-8?B?Z2FrcjFRU0VvOE9iUDN3UU1IQ3hhRlNSaWlacllkdlJWOEVxMDVZVTdnOHl1?=
 =?utf-8?B?V3MvSkNpUkRxaG11OVYxSS90YXMyTVdHcmJQMm1XRlBSL3NOOFNhUE0vOU5N?=
 =?utf-8?B?T3MzdU10bVhMbStYczJPTFRjeG9kUy9wajRpbEZ3OEJiYnZia0hOT2REdUg3?=
 =?utf-8?B?dDBDaldpUHlEalBHbHhEaDhILzQyV0h3SHdSeVZiSDJkSVpzWGR0bmovOXVi?=
 =?utf-8?B?QnRJWDVRZ2lQRDNTQTg5ODZ5RTlRNThsYy9tZ2VHSitVeHM4YlFWTnFoZHc4?=
 =?utf-8?B?S0NzaHdrRXJXN3RTM1VZZVBOR05mWlo5V2FQQk9PTXgrQThpdzBlUW1qdHZ1?=
 =?utf-8?B?KzJZU3E2OU13dFdadTA2SXQvRWN1Um5WMnFYektnTWphTVdZRHQzWUFXOVhO?=
 =?utf-8?Q?/QqqlHhz+cBwly4Q7Ai+oSNFS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ecd1ff-da03-4986-3b89-08dcfd1155c1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 20:43:27.7105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j61V4Fkv0d/02XafhkRiQ+6Wp44oEXaLUMA5rfhf9HJ9ih9hohfHUGRxoza3XR5FVDnYYr18X/Tap0bPcdo+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373
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


On 2024-10-31 22:15, Zhu Lingshan wrote:
> On 10/31/2024 11:27 PM, Felix Kuehling wrote:
>> On 2024-10-31 6:47, Zhu Lingshan wrote:
>>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
>> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
> The mainline master branch:
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
> #include <linux/kfd_ioctl.h>
>>
>>> And it is actually not a file in the source code tree.
>> If it's a file that only there on your local working tree, maybe just clean up your working tree.
> Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
> The is even no folder usr/include/linux before building.
> 
> For a quick verify:
> 1) it is not a source code file from mainline:
> $git blame ./usr/include/linux/kfd_ioctl.h
> fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD
> 
> 2) it is generated when build:
> remove usr/include/linux/kfd_ioctl.h, then build.
> If we remove a required header, kfd would not
> build and there will be error messages.
> 
> but here we will see these lines:
> HDRINST usr/include/linux/kfd_ioctl.h
> HDRTEST usr/include/linux/kfd_ioctl.h,
> no build errors, and usr/include/linux/kfd_ioctl.h is
> generated by duplicating the uapi one.
> 
> 
> 2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
> add random characters in usr/include/linux/kfd_ioctl.h, then build
> we will see errors like this:
> 
> In file included from <command-line>:
> ./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
>    65 | abcd1234
>       |         ^
>       |         ;
>    66 |
>    67 | struct kfd_ioctl_create_queue_args {
>       | ~~~~~~
>>
>>> Ideally, the usr version should be updated whenever the source code is recompiled.
>> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
> the usr one would be installed to the system when run make install or install_headers,
> it is for user space, we should include the uapi one instead of usr one in our source code files

I did not see the folder in my tree because I build with O=... so usr/include/linux/kfd_ioctl.h shows up in my build output tree.

The extra copy of the user mode headers seems to be an artifact of the Linux kernel build system. The fact that the build picks up user mode headers from <OUT>/usr/include/... seems intentional. If your tree has an outdated version of kfd_ioctl.h there, it's probably something broken with your build tree. Maybe broken file timestamps. It should be easy to fix with a "make mrproper" to force it to update all the build artifacts.

I still don't think we need to change the code to fix a problem specific to your build system.

Regards,
  Felix

> 
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>> However, I have noticed a discrepancy between the two headers
>>> even after rebuilding the kernel.
>>>
>>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>>> the latest changes are reflected. We should always include the source
>>> code header other than the duplication.
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index 26e48fdc8728..78de7ac09e8a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -32,7 +32,7 @@
>>>  #include <linux/atomic.h>
>>>  #include <linux/workqueue.h>
>>>  #include <linux/spinlock.h>
>>> -#include <linux/kfd_ioctl.h>
>>> +#include <uapi/linux/kfd_ioctl.h>
>>>  #include <linux/idr.h>
>>>  #include <linux/kfifo.h>
>>>  #include <linux/seq_file.h>
> 
