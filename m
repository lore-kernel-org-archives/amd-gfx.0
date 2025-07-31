Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B2C87FCC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 15:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF5E110E289;
	Thu, 31 Jul 2025 15:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FcZ/2Bah";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A53510E289
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 15:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H966L1NL/Vjv8Xfk7S7Epemr0Tfj+2b2DzveJXgk6r+ebVCZqgEkrJpmQTMnhW3t52RU1QETduOfZLanppusIt/kPpHVdvrDxHjCkZkLPwZ9uAqJQzkAsZLAX+bQtg7+40hX9kkP4N+sPc1ol0Wss5TYBXxGkBGWKksGGhJogHscxLo7uogGwdX8Wl+Vs914N0qyJGg8hyVYXW72VVLXLc1Ohbbmg6WQ/OqQKJ7lPMP/Tmy6pa5a84Bn1A4d5oglxsZyQ87CvFwhVDfSkcU9PtghoWxPVDl0+3/bGRCOYMkIfX3JuxAJ7BlBFCAVHB9hfsYyBKglF8Dr6XX0NwKSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5HUMWZtb4N7Na4t506lYn4l7MKs6kcTgPQaq8pZ4LE=;
 b=MzfMBxo96/KrrbweO8o1Yu0Te76s4sML4geFrur0ypLqd1mG9RudjxK414OlvpSzaC6WyEdt4d9vPdz6PYZGfDlOSWZgGK9Zt2NCKO+MkHVBchB3rb5mAyPRC1xiZJsQbhQs9ZdqkBg7eTgKNUAlO7Mr6cIPTuelhmnJZvLNDDGg4tGoQlnmMjQEMJHy8duuoN356e15gi6RNPhybtE1E8jPbluIBPxZBmghwEU0PNseNgj3EvtNblhXlzNgy+upHWhW+4Ku7CajmxWc3iWk8oBleVCWhnM8LWRxpiB+x2nE7k3P12sNIb1kPGc77nutTELIjGC5aBFbd30SCmbC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5HUMWZtb4N7Na4t506lYn4l7MKs6kcTgPQaq8pZ4LE=;
 b=FcZ/2Bahc1arlrCFo6n0oufjbApH/NOihD06lnhmi4wrn9Ubrubx5JKGNj+nWs4e/icThRvYmgNboA4o8uUKtdbYHyw78sx/PiwPiuzakcFNbg82McBjTu2k8TwkAB4yxtrTIkZ1gstUGyCSFbBEEIB31/z7idFx2sT7Wz5gc+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 15:37:05 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 15:37:05 +0000
Message-ID: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
Date: Thu, 31 Jul 2025 11:37:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on
 RGB signals
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-8-timur.kristof@gmail.com>
 <1ef9ce5a-0b6d-4d0d-834d-d1f6b0dc12bd@amd.com>
 <7d1df06a6b19dc2d8e78059efb6e26f00bdb280a.camel@gmail.com>
 <714ca8d3-5da7-4266-b258-aba3fbed4a40@amd.com>
 <ada40fc10d06f8b4699ac128a56e59263d30c6d9.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <ada40fc10d06f8b4699ac128a56e59263d30c6d9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::6) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 821709e8-66b5-4e0f-0dda-08ddd0481a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnkvNTJpcEMzNGg4TFlBMnZDbGltTldzUHFURHJoTDJNNitYUGFJUEc3cFp0?=
 =?utf-8?B?U3JpUTRmR2VRZ0EzMzRrSU1qbWNGS0p4WExOc2NoNXlWVFdyYU9jQ3REUlBH?=
 =?utf-8?B?cm9CczMrUzBpZDFJTDRPUXFtUlc0eFBlelVJSVdHNlhmUTBNOVF5V1ZvWUR6?=
 =?utf-8?B?OEhkNG9acW5neUY4R0RPR056T0QrT1B0bGJwODlaTnkrVXlNRHo0Yis0MmNN?=
 =?utf-8?B?alptSDdNQ3Q5K2JxSS9QNzA5YkVRT1hkQ3ZRVGJHVDJTVlpNbkZ0a0VlR3JG?=
 =?utf-8?B?VzAyVUtMa0gwdENMTkpDU3I0Q29NYnhSa295elc5aFljdEdzdTRLYnJiM3oy?=
 =?utf-8?B?WVBORUYwMnlPeng3SG1wL2Rqd05RYndNSGxycDNpUnhydTQwZk85a0NoT2ty?=
 =?utf-8?B?cXRSdmpldzFSNEZxRTJNQjRZeXNVdmdjVnlWVW9GazB1YTFWQ21GdHhVVFZy?=
 =?utf-8?B?b3hPR2l1bDNZVUE4eTA2QUFDTUUzZ1RyTHZmM2VKTldsR29kTlBoOHZHb0xl?=
 =?utf-8?B?ZWxOWmZKZ2R3K2ZQRnhyVUw4Z1FDZW5IblYxZUNNTCtxYWlydmxnUkVlRWFp?=
 =?utf-8?B?b3FRZmdEVW8vS1NEcVJGR1NRSEx5b1pSdW42VFdzNlkyUFpKek5DRDBONU5C?=
 =?utf-8?B?SjJHT2JCZDhQeU9YWC9IcFBjS1hlUWpSSGxFb20yYUxCVndZaVlXZVd0Nm4x?=
 =?utf-8?B?ejdZMVFNODlrYWJ4MzZIMUZRdFFHbXRnc053S3JKb3NKWk1sVFpOaC82bW4y?=
 =?utf-8?B?dVpydm5XelZmTXVqa01DNllQK3hsY3F2MjZNbVBCeThQdkQzS0E1RUZOZkgw?=
 =?utf-8?B?SnJjL05DMjNjWXMwRU5UbnBvbmhXZEhhRHFRWk03d2Ezd1h2Qm5IQVRXMVhH?=
 =?utf-8?B?MlZsZ0VwTnRzUjAxTEhzNDVZbWZVcFdWeXRmZDZtakdWVVpkeUh5eVAzWVda?=
 =?utf-8?B?dXU4OEJBVTh5MFQ3cjZqTFpYVGJxUXMxMExGSkYrcEVNcmcrVG9DODJXdSs5?=
 =?utf-8?B?SEx1THo0R0gvRWxhUWVwd2F3a29YOFRyU0ljSGFXclB5WG5tZmJXd0VWKys1?=
 =?utf-8?B?NHp2RVdERm9TUDRsUkRHMTIwWHNhUWRUaGxjTnk1TjRPcEtVYk1MTGh3VlYy?=
 =?utf-8?B?dmNZV0szS29Gd2JscS9EVmJleU9DeGptR1FhK3FxRGNVelBQV0RuVHdadUVY?=
 =?utf-8?B?ZHFqc2cxZDBpZys5b1ZJcENkTS9CeDVnVlBjdGF4cENYTWFFMGUvdlUzOUhh?=
 =?utf-8?B?QVlleWNUa21QUk9PMmFHLzdoNmxYMTR2YS9ENXhhN3JBVnZ1SnVIaW90WTNK?=
 =?utf-8?B?ek9Cc0M1UXRyN2FUdXJNOW8wWWlSRXdTNWRhd2M4d2pab3VQWW11MEMrN0da?=
 =?utf-8?B?YkFHMW1ienlkMmFaVThIdlFqRlhyZWs5OUpqYng2L2FVNHh4RldCSGZnVXJm?=
 =?utf-8?B?a0NwOUNKR3JkYmJxbnkySVZJYkw4OG9qZVMzbnR2dXFFU00wekNXbE5WTHBi?=
 =?utf-8?B?N1FzS2pBeG1Zb2xQQVZ4TElqRm5BajdiYTJPOGV2MjRJUEN6cUh2THhHd2hW?=
 =?utf-8?B?UElyRVJOUURwREdTTGVzUjN0d2ZMRUw3N3pFc21nNC9WTkQ5VVJsN0hOcFZ0?=
 =?utf-8?B?TmdoTFZidUVvZjVhWEVOVTVHWldXTFJnS3UwR0NBSThDYmFWMy9DYWlJNEVS?=
 =?utf-8?B?NmZZUzRYbWZRc09MNjQ1UDBHREJSZUlEd3BRSUxEK3BiMmM0aEw3aUlldENL?=
 =?utf-8?B?WHNLdnluRjR4ek1CMDE3NUF0R3ZDUUppMU9YbXNlMkVsbmtCbytPOWwxK3o5?=
 =?utf-8?B?NEFnN2l6RkhyeXNzMmE1QzNIZ2xXZ2kyMlpBMHd2SWFMRExDcTdCL05KckFZ?=
 =?utf-8?B?dVo2Y1pPeWZMQjVwYU9mSnlkQTk5T3FIRUZ1cnBBWnlxTUNmbHIwWVBhSjFS?=
 =?utf-8?Q?v6BOJ7ASiYM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZYQlFrMjRUcWZFaGZzRjlBVm9Nazh6czE4c3l3QUY5alVRRjFiZlcxTHU0?=
 =?utf-8?B?SFpMU3NYVkNjOHJSZHZXZ21uSlhHYlZmYXIxWEhKSStrVkM3QURGT3VDc2lx?=
 =?utf-8?B?Q3RVd2lWcXphUHRCZEYxR09jQm5xT1htRWt5SE1acEFxMnRmM3NEOHlLSG9j?=
 =?utf-8?B?bmFaRzdOeDJEbVZxT0MwSjNQZ3hwQi9oUW1jb2N2S1JYWEpUSWtHM2VMbGp1?=
 =?utf-8?B?YVRkTk1PeVhZTGNLUkNEWUVuNEdLZWlnTjl0N1M5WlZna05weWszTEVONFhR?=
 =?utf-8?B?dXlWdGxVKzFzRU16SmdZRHdBSGVYcFd1YzdFWGdyWG11aGxiYWhNek0vOXRP?=
 =?utf-8?B?UDkrNGlBZUxxUllBY3laQmx0N3JMZEh0UHF0UEhRZ3duaFBwRWZWRi9PenFJ?=
 =?utf-8?B?Y0Q0VzluN0hFNlE5TWEwNThaOVZnZ3M3aW1jZmlsRHNqV3dNODA3alJsK1JM?=
 =?utf-8?B?Y01MVDlnWjdLMHJsQ21hdXFmbi9VWkZNdWl1cFU1YmxrZHpiWGJEd0VzTVFx?=
 =?utf-8?B?R1V2emU1NWF6UGFYTGlINksremgvUFI5L0poWE13aGZCWUxuQmxuK3pkd2g2?=
 =?utf-8?B?TUoxa1dHNGpZLzFQc1MrRmhORGErb0xqbWg4QTFIN1ZWZkJFR2llMkE2dm8z?=
 =?utf-8?B?S1R0bkJGd01odkQvR200cG5weWVqVDhKQjI3YXU4UUJiUnoyS0dORE9wd3pt?=
 =?utf-8?B?SWFVVHNHMDZvUklFc0Z2U1AwTFhOV0RvRS9jREptMkM3NWRSQUZtMXVlZUEw?=
 =?utf-8?B?dG5Dayt0aHI3VjN2SFFMQjNDVytCSXA4ZGxJVkd1S2xuUTVGdkMwajEzVXgr?=
 =?utf-8?B?NUNYcEpIZ21kWGtCZVpTL2Zpak9SZm1zaTJPTzNBZ1J0SzZwZFZ1QVF4Wnoy?=
 =?utf-8?B?dC94Qmd0QTFsbHd4T3FxNmNYeFRuZmlZNjhvVkFZTFNBTG0zNG1aVFdwRzQ0?=
 =?utf-8?B?eHVPZjVYam0zVjR3UGw4d1pINHVqV1ZSR1lpYk9JamJULzhnenM3T1pSSjcw?=
 =?utf-8?B?Y011YVVBWGEzcWlVakpPMG1WRllhNkg5RlBDRHl1azJSTEYrZGUyVFgrYjFG?=
 =?utf-8?B?U3craFhwNHM2NnV2MDdqMVhPVzlwSDBMK0xtNnZzMmVzdmlzdHNlMTYzNlRR?=
 =?utf-8?B?WVZRM2hibUtvRCtFKzlWYTd6KzFjOUZXdy85L1V5TFBuajliQWZkN0V6Zk94?=
 =?utf-8?B?L0tURzZ6eHpYc0k5UG41NmUvMDVTOFJiUGh4aXNZWkxWZitnWHNkcWZmMSt5?=
 =?utf-8?B?RmFWZXJUc2RHdjdXNGZTV2dmVTRSS2ZWb2FXSldWZkh0bTI2eUswK0RJVnll?=
 =?utf-8?B?UzNhM1A5Ny9Sdi94TzZQYXY5Rmk2NS9BWjRQQkk1Y0wwVXdoL2diV29yMEhN?=
 =?utf-8?B?M0dTVFgvMUtYcU1laHpXWllsWk1seGpUSnltZStaYVZjb0VZMWFZaEk0Y1Mv?=
 =?utf-8?B?N0h3cUxhd0V4OUhzb0xxazlMN00wZFhqd2tOeFJHT0RZeGVMUkFDOU55Z2xY?=
 =?utf-8?B?R0xycWU4UWo4bHUyRitNMUdkSUY2YnlYWHkvblYxa09vNHRDWVZLc0xFUEFT?=
 =?utf-8?B?NzZtbXhJZHpOWjU2R0k0YkVoc0hzN2VTN0k4WEdoVTA2SUhmSjJaUU10cGFU?=
 =?utf-8?B?eVNCSVIxMDNiWURQUDRHdTBqelFlQXBmR2hTUjZCZmVVVUhRUnBFK25sU0h5?=
 =?utf-8?B?NW4zc2xIN21jZExoU2Y4c0NOWnVkdlJvVVRKZXFEYnp0cUlVTkpqMHhXSzQy?=
 =?utf-8?B?OE9qTWRENWtPcGQvSGEwQXpxTUZCUkc5NGF3a1RsQ1dtaGZZUkJjK2M5VGlv?=
 =?utf-8?B?a3oyZkNUeCtpTVVMQUpqVjFmbDUyK0hJaXpucWxVdUFrcTNPNHlNUzFQK3Qx?=
 =?utf-8?B?R1d0dFR1clpSbElKTzhPSFRSUEVsb25Ha3o2SHpUbGRsL2FyRUpPWHNkTVNE?=
 =?utf-8?B?OVZNQ0MybVBRam9Pek1vczEzRHNCRWpPNml5MUNWcndGVWZNelV4NERWNWN2?=
 =?utf-8?B?UzV1ZUN0MEhiVmtOK1VPdnZKZDJCdHhtb3krTWJWSkhHMjg2K0Z6L0RlQ0tt?=
 =?utf-8?B?WGRDOUMxcFByRmozOFVEMUJENWV0cTZLUi9rbG0yeGRSSlExbWxSRy8vRU9v?=
 =?utf-8?Q?jwLVwS8R+m6RqHQ6kHPG2V/Tj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821709e8-66b5-4e0f-0dda-08ddd0481a2e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 15:37:05.3771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+IpLQhXfCumGVO9CJcRROBlGYvfIh9C4zLOrIxl8tkyJPLfZ+Ish3/yw0gbQQYqryJoiNL7qzYEKzkMHBc9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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



On 2025-07-30 13:08, Timur Kristóf wrote:
> On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-07-30 04:19, Timur Kristóf wrote:
>>> On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
>>>>
>>>>
>>>> On 2025-07-23 11:58, Timur Kristóf wrote:
>>>>> Features like stereo sync and audio are not supported by RGB
>>>>> signals, so don't try to use them.
>>>>>
>>>>
>>>> Where does it say that?
>>>>
>>>> Harry
>>>
>>> 1. Audio
>>>
>>> VGA ports (and the analog part of DVI-I ports) simply cannot carry
>>> audio. So there is no hardware to control any audio, therefore
>>> there is
>>> nothing for this code to enable, which is why I added those ifs to
>>> not
>>> even try to enable audio on analog video signals.
>>>
>>
>> My bad, I was thinking RGB as opposed to YCbCr. Forgot that we use
>> RGB signal to refer to VGA.
> 
> Sorry for the confusion.
> 
>>
>>> As a side note, DVI-D ports (and the digital part of DVI-I ports)
>>> may
>>> have a non-standard extension to carry digital audio signals, but
>>> that
>>> is not revelant to supporting analog displays.
>>>
>>> 2. Stereo sync
>>>
>>> With regards to stereo sync, I didn't find any reference to this in
>>> the
>>> legacy display code, so I assumed either it is unsupported or the
>>> VBIOS
>>> already sets it up correctly. At least, considering that the legacy
>>> code didn't bother setting it up, we don't lose any functionality
>>> if we
>>> leave it out of DC as well.
>>>
>>> That being said, upon some further digging in the DCE register
>>> files, I
>>> found a register called DAC_STEREOSYNC_SELECT so maybe I could
>>> investigate using that. Maybe it would be better to work with the
>>> registers directly instead of the VBIOS? Would it be okay to
>>> investigate that further in a future patch series once this one is
>>> merged?
>>>
>>
>> I don't think DC supports stereo sync currently. I'm not sure there
>> is
>> much value in pursuing that.
> 
> If stereo sync is not supported, what does setup_stereo_sync() do?
> 

My bad. Not sure then. But no objection if you want to explore it.

Harry

>>
>>>>> diff --git a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>> b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>> index a10d6b988aab..825a08fcb125 100644
>>>>> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>> @@ -118,6 +118,11 @@ static inline bool dc_is_dvi_signal(enum
>>>>> signal_type signal)
>>>>>  	}
>>>>>  }
>>>>>  
>>>>> +static inline bool dc_is_rgb_signal(enum signal_type signal)
>>
>> To avoid confusion with people that haven't worked on analog
>> signals in years (or ever) it might be better to name this
>> dc_is_analog_signal.
>>
>> Harry
> 
> Sounds good, I'll rename it in the next version of the series.
> To further ease the confusion, what do you think about renaming
> SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?
> 
> Thanks,
> Timur
> 
> 
>>
>>>>> +{
>>>>> +	return (signal == SIGNAL_TYPE_RGB);
>>>>> +}
>>>>> +
>>>>>  static inline bool dc_is_tmds_signal(enum signal_type signal)
>>>>>  {
>>>>>  	switch (signal) {

