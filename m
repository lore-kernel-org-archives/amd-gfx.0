Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35271EE01F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 05:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D13A10E95D;
	Wed, 11 Sep 2024 05:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IJTd8KHC";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1184910E179
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 05:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRkefzlriJycu/KWGS9+JMWBsFNOi/2bEHu/sVHWKMOyAlRdn0cIOocte72vrhI6j/U956MLFnrxDMuUZLs9LXSWL1f8O8OMOlmiT1TsEvHs5oyETfaB1ZmBuNMDbhVp3VRnyV/rVSlj5ypKdIQw6bmH5zCPZkK5kLKXMlqBQ9em5O3XIvz4/4mwOfBnpuqwybzsEZYVIKBtPzaEhFNpUU4eObFcqEf0AiChzvYSvvtIhufu4lX0v3k7BgwpI467so+HNF9GnANqpse255LMo1yl2op/QrOqdYFnYbBIptC0RqommAA5SUf/hTkAhrPRFLKnyfdAuvM/O3vKvdmPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X7P5549GvwULLi/fp0YigtZc3mAp8aYdRtyeoaDWv0=;
 b=GLsB0BlarpCK9GwUZW3+MeP0znot9YGbVZKWLDIwotGxjkTRX+2g+vsBI7wM1DcZKAf3SjB1qGsncnuB3VGAb42qtJ9kBEWVNVjI+CIM/1xXoI2KHqS+Xp9A92nPeqG9QWJD18tTOWb4USjohAnCrGtMcFQV6vLjsLRKJXiVFrRIVit4Sq4TepFWHok4mgMYRDB09xuVacEckT+Fs0hdTWKNeep3lTAb0Q1WtJx9U1wZg4jtpe/Bm+i81xMVOj2SFtZ9qdAIbpgpUVXfAQ4XpHTwbL1l1HNTIZ9XLtSd6ZUzeS45+ra5bGFUCqdUbbwlrvggAbMUQw5iHSD+Tcd1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X7P5549GvwULLi/fp0YigtZc3mAp8aYdRtyeoaDWv0=;
 b=IJTd8KHCW+W+2r/tXe34KAT/wnoU7kGTeof5stptLTF299uuml5ZaFefq7zoqApJ2HZNh/HX2uazbtiRdJ8XrkOsw0CpqvX4bhfo4zHFovtN+tU2ufiP7M+ohSiCmAiamSwisDg3lOIfgGOf1yYoJciPLKySnXIBNoG9SocPdzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 05:41:33 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 05:41:32 +0000
Content-Type: multipart/alternative;
 boundary="------------HPHHhsJPQTzguxqoGWmlYfAr"
Message-ID: <1c903ef5-88e8-42d1-a364-3343120285e4@amd.com>
Date: Wed, 11 Sep 2024 11:11:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <25712414-4308-46ed-8c3c-f108901b3c9a@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <25712414-4308-46ed-8c3c-f108901b3c9a@amd.com>
X-ClientProxiedBy: PN2PR01CA0201.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::13) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a89f85-5cf8-4fa7-8c42-08dcd2246467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OW5HcUFLWVNsVlI0Vnd0NW9DZkE2eWpZb2pBbXZ2VVdRZXNNTVljZU9POVlw?=
 =?utf-8?B?RGNIQSszcDk2dTByUGVGcHNFUnNrRmt4WEpFaUpUR0tTSHJ5cVlQOVd0SlRM?=
 =?utf-8?B?S2thalJhQlpIMlF1ZXczZ3VXMzJHdXNXQ1RBLzRvdWVsa3ZXUjNqdENJdWRl?=
 =?utf-8?B?U0hhN0RydG50dzdRbFo1VGhvcUdmVzBIRVRud05vQlF3VFlFZWtIR1NaNUJN?=
 =?utf-8?B?NzVJR1ZVNkpSWEhBdlB0N2p5R3dJMlUwODdCUm1MS0RIeUR4V2l5aGp2d21P?=
 =?utf-8?B?L0FXaEdaZVluMXgzR0o3eGNXaTkwYlJGb3RCVG5hZklRM3U0TzZYSEFhL1p6?=
 =?utf-8?B?WE1QT0VkREtONDY3eTlJTEptT0Z5VUlHSHhBZVdjakhVVHBJSTBIVGZDc29q?=
 =?utf-8?B?TmFkRy92WmlDSyt3S05sbkdNaHczbzkvQmNjMWo2QmppbjNTZG1tVUVOREJa?=
 =?utf-8?B?dE9pM3cvaHcvUDlHaGM2UEx6bFRqV2lFSjBoNnJ2M3FyMkFoQkVSZmlJYzQ0?=
 =?utf-8?B?ZTNtM3J4TWZtMjF0bWZ5bWl5RDRudTlRcjAwcXpOWDN5RktWOTdEVy83b1ZN?=
 =?utf-8?B?ZTlrUE5lMkJheEJkM2pkUXZ4dkducWJnZzByeGo1MVBMWEJYYWJCN2RjUGZX?=
 =?utf-8?B?akZQREVpR2JrcUpCY1BqZmo2MHloTEQvekRCOEpTWVlOdTFwMHRSQVJ4eWg5?=
 =?utf-8?B?bjhBbTcrNU1Gd2pOSTBxbXErMDMvWHNpb1pFK1JxcFRjQ0ROSXlZZXVIWWJz?=
 =?utf-8?B?eGFaaFZubkI3NmpvRkhTSG9wVHJETWxzQjRtMjVvc1BMY0JxUGF6cTcrbnhH?=
 =?utf-8?B?TVhiekg3Tk1mc1VkeURnZ01pM2JyWmNjU1RPL2dpQjBheGpHbWtmR3pKaHB3?=
 =?utf-8?B?NWFCZERLdlk2OG12MFM0RWR4UmV3Zld2ZXN2ME5NV3Q0b3EydmlRMnBVSW9y?=
 =?utf-8?B?aDkwVjhjcTF5bHd6QzROb2EvMEtvQzcycmVNU2R5RU5NNlFhbVphRmZvK2pO?=
 =?utf-8?B?SjVSQWNQdUh3bFJjajRjQTE0TVJ1cm0zYnZoaXhnMWVqd1dKWjI0VXBieFNy?=
 =?utf-8?B?N09qTmRKNzUvY0JwaTBzZXU0MlFDM1N1eDczMmwwL1Z2V3cweStVT1ZJT0tV?=
 =?utf-8?B?Wlp6YU5RRUdtQVgrYzRwUkJXaHMwMXI1Y0JFR0dMZWx4SStKZk1VM0ZJM01J?=
 =?utf-8?B?bzlKN0dzMWM0WlVDM3lCRCt6V1pheVRqanN5VHZHS3VTZWZ1WnZkbGtZTkk5?=
 =?utf-8?B?RFk3ZHhDU0xIcGFXcUVqVXF5SmU2RlJyQSt1Y2EzbzFRRXlXSnBLTmJuK0VR?=
 =?utf-8?B?S1ZBczlpVmVHV3hwYzJlZUNBakNEMkliQTd2TTFjRmZMa1A1UGp6YUJieUVE?=
 =?utf-8?B?aHJCc21qK1puYUVqeWIzNEJRanpJQTJzY1YzY3Mva2dyVHdwckZMVGlqNWpo?=
 =?utf-8?B?aHZsMnFJSnJpTEdPSnZVS0FzblB6TldzUnJzcjQra1dMQ2x4ZGpyeWNmVVVr?=
 =?utf-8?B?d2FONnEyWkg5T2lOd25tSWFmejRqMzhoaGdLbnRSRjh3R2JvZDNSYW1COUdm?=
 =?utf-8?B?YTIzM0FNYzJ4ZDNlb1RoSlhNaTBIVCtGOU5DZEkreHRJZDJtR3FQbWt0aXRh?=
 =?utf-8?B?cWh1TmNMZ2ZZRU5nUEFHS2NxTlhWK0Z2b1hSMG5uZ1FYNDhMdlhtMDg3YWNW?=
 =?utf-8?B?aHllUGdPUHF6ZktYU1RyWU50a2lVS1VLS1lLL1RlYWJpbGU1ZFpKazhFcWtH?=
 =?utf-8?B?YTY0UHJjdTZteTkrWEhHMitGNDRtTkFxbHVWMTFDV2lqd2dNVzFJdWhlLzdW?=
 =?utf-8?B?SUxaMTVQUXpyVGZheU1LUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1czblVmYlZESzROS2FNbFhXR0ZiYnc4aTVuamsyRWxEallDTFNicWRvanRs?=
 =?utf-8?B?Y1JQUE1MZDhhTWRaQlVoUkRmSzhyQXk3ZEQ3SFMvNFVFUDFUdGRxMmcrbStj?=
 =?utf-8?B?Mnp3NFRkdHpSdU9FaU96c1VrcTNSOHU4a1V2cHRyRTE3Y0pUZlZDVDIwZkIv?=
 =?utf-8?B?RFFqMnNuZCs4MjFuWE5lQkM0V2pCUWFvQnB1bDlyWGx4K2pmUHg2TUxxdnNy?=
 =?utf-8?B?NHY4T284Ym5BWHBmaXB0cEdDMEJ2dU1oK2EwczZNQWx6Rit4NTVQZmhOVkpC?=
 =?utf-8?B?c3VORy9pQll5NGp2ejlPZDZmZXorVjl4SkdRaU92YjlYaDBhRGdYL0NUU3px?=
 =?utf-8?B?SFZXS0Q3Ym9SK3ZXTVpwNlcyRGtpaGowUVNac2FnS0ZtdWNrdnNmSnh5MUta?=
 =?utf-8?B?eWh0MElKQlRra1d4MUZqYVYxc2k5OWk4djRMRGhya3BNall6bC9SazZHaE1I?=
 =?utf-8?B?VlVMRDVoOCt2UkIzV3ZYT1FGeG1PWk9CT0ZDQ1BwSkQvK3IrUUZMeUg3UHVr?=
 =?utf-8?B?NWZXUCsveTJiVmd2N3pDeFNLN05BWW90VmxVMkd0VXdlRnU0T0N3ZzhiRzdi?=
 =?utf-8?B?SC9vQnp1ODNEeXdubG95dnF2UHBnUjFuSS9xWW1NbnJBd3hIQkk0Z1Q2cXpM?=
 =?utf-8?B?UGxzbUduWDgxeHlrWlEyU1llTTFaWlRyS09haEkvUVFONmRyT3RaQ09OeEpJ?=
 =?utf-8?B?MFQyUm53dCtBa1lRZFQ5WEkvYW1zY0hPUUJwemxJSFhSRFRacmkzMGZOUDI0?=
 =?utf-8?B?VTU0UlcrZmFoRkdMWlFCQXhteWNGTE9sQTF6Q2pLbzV0dUMwSFlCN3dsL3VJ?=
 =?utf-8?B?c0xDV1dyZndib3h2Zkl1TFAyTjduU2JCMTV6NklzWWpFdkNEZVlkYkJaZ0FX?=
 =?utf-8?B?MUFkOW1HVnF1MTI1ZVg0VnJQZUpBb0tqUjM0NU9KOHNPa3FOY1RQZ0s4YlZD?=
 =?utf-8?B?UG16enlkMFNtblZQQzZvNk5ueEw5YXpDSFhibkpZbHZZYVp0dGN5S243Y1I5?=
 =?utf-8?B?Vm1BenMvejRmM0hjYk42enFndGFFRVh2RmxmNXlGbEdPODVhTWxlYldhd28z?=
 =?utf-8?B?dlZIN0FFaDlDRmUrS1JER1dTRCtXaDVsNkcyUGF6WGZ0QXZ3TTJQZWlCdTlO?=
 =?utf-8?B?TElSb2hidTFvNFhVVVp4SjNIT3Q4Ry9PdXlLVWxBSWJvRElDenBOZnc2eU5y?=
 =?utf-8?B?eTlaYVQ4TFBvTE0vREhNay9oWWRPb2txNkxaVFEvWG43RC96L01DMXBxektJ?=
 =?utf-8?B?VUV0WUduVUF2akc4NWJ6dlhSMkU5QlpXYXhnTEJLclFwZ2NPMDJxRXh2bk4z?=
 =?utf-8?B?YWk5b3g0TnFsYjdnSWZyUWhUMlg4WTVjcExQQVFDVktUSHhXaTA4ZGc1RVlG?=
 =?utf-8?B?dW9kK1J5Unh4VG1BUmRSZEtRc1pQMGZpUHkxMUFzZHh2ZU9UQk9DcnVna0U2?=
 =?utf-8?B?ckZBVlpTeVI2RmxEbHgzRTI3NFZ1eGhmSVpSRnpSZWh1T2NRa1NqclkvTFJ3?=
 =?utf-8?B?M2tHa2JROEFub2FIR3QzcmV4VENqYmhiaHJxem11dVB2aE5JNEg4azRCMkdH?=
 =?utf-8?B?MlJLajc1MEF5MEh2T0ZySnhDbTk5TWcvYUFrNXB5RDJ3ZWd5UWlaaDFHMHFC?=
 =?utf-8?B?aWNRYlFKMnVyNGpPOCswdStSV0R0b2R2RWNSb3IyMjQ0VXMrQXlZcDFCS3Nl?=
 =?utf-8?B?S3lRNUwzLy9kdFlleXZLNnBHMjIxU0NWZmMvRkhVdXc2RStGMEF1TVluNUlN?=
 =?utf-8?B?ZmZuYXpWc1AwVFNTRmRhT041QVpkS3lPekhKekE3am9OTDdEMkVxTERLMWQy?=
 =?utf-8?B?OVh1bmlKL3VmN0pDS0pvbHZxM0hXTmIwK2g4ZXNXb29OREVnd2tzL2ZxZHc5?=
 =?utf-8?B?ZFR2RUtIRmdiSm1RMU4vcVlRSXNpUVJQMDhlUld5Q0F0c3c2eDEyNDlQTHJv?=
 =?utf-8?B?dUtqRXB1VVdRbkU4VVZ6WHhML1hHd3VKS3NDWDZkZVZxalRKd0ZMKzd4YTNN?=
 =?utf-8?B?QVV5UGl3YmZpaVhqSGJnalNYYm1ob3BhQldUcGg2dDN1c2w1ZGtFOGhEYnpn?=
 =?utf-8?B?WWpiK082STdCNnZQMTNmRHFQcFJHbHFubGJXQW5Kb1VnVHI3OHlzZ0FjbG5S?=
 =?utf-8?Q?k0gAdviHlQXfrXvH3nKueyNAo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a89f85-5cf8-4fa7-8c42-08dcd2246467
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 05:41:32.8494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCAoeT3Uk6NXtH3iTKXSsuy1b6apelXRZBkCbqDpBOcMpgT24wGykwR5eRUQYQkRSwJIVv65JXfuQOhsYMlynQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

--------------HPHHhsJPQTzguxqoGWmlYfAr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

On 9/5/2024 2:10 PM, Christian König wrote:
> Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
>> This patch introduces new IOCTL for userqueue secure semaphore.
>>
>> The signal IOCTL called from userspace application creates a drm
>> syncobj and array of bo GEM handles and passed in as parameter to
>> the driver to install the fence into it.
>>
>> The wait IOCTL gets an array of drm syncobjs, finds the fences
>> attached to the drm syncobjs and obtain the array of
>> memory_address/fence_value combintion which are returned to
>> userspace.
>
> One more issue in the error handling, the rest are just nit picks 
> which could optionally be cleaned up.
Thanks for the review, I will make changes and send the next version.
>
>> v2: (Christian)
>>      - Install fence into GEM BO object.
>>      - Lock all BO's using the dma resv subsystem
>>      - Reorder the sequence in signal IOCTL function.
>>      - Get write pointer from the shadow wptr
>>      - use userq_fence to fetch the va/value in wait IOCTL.
>>
>> v3: (Christian)
>>      - Use drm_exec helper for the proper BO drm reserve and avoid BO
>>        lock/unlock issues.
>>      - fence/fence driver reference count logic for signal/wait IOCTLs.
>>
>> v4: (Christian)
>>      - Fixed the drm_exec calling sequence
>>      - use dma_resv_for_each_fence_unlock if BO's are not locked
>>      - Modified the fence_info array storing logic.
>>
>> v5: (Christian)
>>      - Keep fence_drv until wait queue execution.
>>      - Add dma_fence_wait for other fences.
>>      - Lock BO's using drm_exec as the number of fences in them could
>>        change.
>>      - Install signaled fences as well into BO/Syncobj.
>>      - Move Syncobj fence installation code after the drm_exec_prepare_array.
>>      - Directly add dma_resv_usage_rw(args->bo_flags....
>>      - remove unnecessary dma_fence_put.
>>
>> v6: (Christian)
>>      - Add xarray stuff to store the fence_drv
>>      - Implement a function to iterate over the xarray and drop
>>        the fence_drv references.
>>      - Add drm_exec_until_all_locked() wrapper
>>      - Add a check that if we haven't exceeded the user allocated num_fences
>>        before adding dma_fence to the fences array.
>>
>> v7: (Christian)
>>      - Use memdup_user() for kmalloc_array + copy_from_user
>>      - Move the fence_drv references from the xarray into the newly created fence
>>        and drop the fence_drv references when we signal this fence.
>>      - Move this locking of BOs before the "if (!wait_info->num_fences)",
>>        this way you need this code block only once.
>>      - Merge the error handling code and the cleanup + return 0 code.
>>      - Initializing the xa should probably be done in the userq code.
>>      - Remove the userq back pointer stored in fence_drv.
>>      - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()
>>
>> v8: (Christian)
>>      - Move fence_drv references must come before adding the fence to the list.
>>      - Use xa_lock_irqsave_nested for nested spinlock operations.
>>      - userq_mgr should be per fpriv and not one per device.
>>      - Restructure the interrupt process code for the early exit of the loop.
>>      - The reference acquired in the syncobj fence replace code needs to be
>>        kept around.
>>      - Modify the dma_fence acquire placement in wait IOCTL.
>>      - Move USERQ_BO_WRITE flag to UAPI header file.
>>      - drop the fence drv reference after telling the hw to stop accessing it.
>>      - Add multi sync object support to userq signal IOCTL.
>>
>> V9: (Christian)
>>      - Store all the fence_drv ref to other drivers and not ourself.
>>      - Remove the userq fence xa implementation and replace with
>>        kvmalloc_array.
>>
>> Signed-off-by: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
>> Suggested-by: Christian König<christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 437 +++++++++++++++++-
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   7 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>>   6 files changed, 471 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index a31f6c92a755..06021520a753 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1043,6 +1043,8 @@ struct amdgpu_device {
>>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>>   	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
>>   
>> +	struct xarray			userq_xa;
>> +
>
> A comment what that is used for might make sense here.
>
>>   	/* df */
>
> But please, *not* like this :)
>
>>   	struct amdgpu_df                df;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 6e51b27b833d..70cb3b794a8a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2878,6 +2878,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>   };
>>   
>>   static const struct drm_driver amdgpu_kms_driver = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index f7baea2c67ab..ea806cc2c1b0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -25,6 +25,7 @@
>>   #include <linux/kref.h>
>>   #include <linux/slab.h>
>>   
>> +#include <drm/drm_exec.h>
>>   #include <drm/drm_syncobj.h>
>>   
>>   #include "amdgpu.h"
>> @@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>>   	spin_lock_init(&fence_drv->fence_list_lock);
>>   
>>   	fence_drv->adev = adev;
>> +	fence_drv->uq_fence_drv_xa_ref = &userq->uq_fence_drv_xa;
>>   	fence_drv->context = dma_fence_context_alloc(1);
>>   	get_task_comm(fence_drv->timeline_name, current);
>>   
>> @@ -105,6 +107,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>   	struct amdgpu_userq_fence *userq_fence, *tmp;
>>   	struct dma_fence *fence;
>>   	u64 rptr;
>> +	int i;
>>   
>>   	if (!fence_drv)
>>   		return;
>> @@ -115,14 +118,18 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>>   	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>>   		fence = &userq_fence->base;
>>   
>> -		if (rptr >= fence->seqno) {
>> -			dma_fence_signal(fence);
>> -			list_del(&userq_fence->link);
>> -
>> -			dma_fence_put(fence);
>> -		} else {
>> +		if (rptr < fence->seqno)
>>   			break;
>> +
>> +		dma_fence_signal(fence);
>> +
>> +		if (userq_fence->fence_drv_array) {
>
> You can probably drop that if. Just make sure that 
> userq_fence->fence_drv_array_count is correct, e.g. zero when this 
> here is NULL.
>
>> +			for (i = 0; i < userq_fence->fence_drv_array_count; i++)
>> +				amdgpu_userq_fence_driver_put(userq_fence->fence_drv_array[i]);
>>   		}
>> +
>> +		list_del(&userq_fence->link);
>> +		dma_fence_put(fence);
>>   	}
>>   	spin_unlock(&fence_drv->fence_list_lock);
>>   }
>> @@ -132,8 +139,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>>   	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
>>   					 struct amdgpu_userq_fence_driver,
>>   					 refcount);
>> +	struct amdgpu_userq_fence_driver *xa_fence_drv;
>>   	struct amdgpu_device *adev = fence_drv->adev;
>>   	struct amdgpu_userq_fence *fence, *tmp;
>> +	struct xarray *xa = &adev->userq_xa;
>> +	unsigned long index;
>>   	struct dma_fence *f;
>>   
>>   	spin_lock(&fence_drv->fence_list_lock);
>> @@ -150,6 +160,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
>>   	}
>>   	spin_unlock(&fence_drv->fence_list_lock);
>>   
>> +	xa_lock(xa);
>> +	xa_for_each(xa, index, xa_fence_drv)
>> +		if (xa_fence_drv == fence_drv)
>> +			__xa_erase(xa, index);
>> +	xa_unlock(xa);
>> +
>
> What exactly is that good for? Removing the fence_drv from adev->userq_xa?
yes, we are just deleting the fence_drv from the adev->userq_xa as we 
are going to free
the fence_drv in this destroy function.

Thanks,
Arun.
>
>>   	/* Free seq64 memory */
>>   	amdgpu_seq64_free(adev, fence_drv->gpu_addr);
>>   	kfree(fence_drv);
>> @@ -191,6 +207,29 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>>   	amdgpu_userq_fence_driver_get(fence_drv);
>>   	dma_fence_get(fence);
>>   
>> +	if (!xa_empty(&userq->uq_fence_drv_xa)) {
>> +		struct amdgpu_userq_fence_driver *stored_fence_drv;
>> +		unsigned long index, count = 0;
>> +		int i = 0;
>> +
>> +		xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv)
>> +			count++;
>
> IIRC the xa had a special function for that.
>
>> +
>> +		userq_fence->fence_drv_array =
>> +			kvmalloc_array(count,
>> +				       sizeof(struct amdgpu_userq_fence_driver *),
>> +				       GFP_KERNEL);
>> +		userq_fence->fence_drv_array_count = count;
>> +
>> +		if (userq_fence->fence_drv_array) {
>> +			xa_for_each(&userq->uq_fence_drv_xa, index, stored_fence_drv) {
>> +				userq_fence->fence_drv_array[i] = stored_fence_drv;
>> +				xa_erase(&userq->uq_fence_drv_xa, index);
>> +				i++;
>> +			}
>> +		}
>
> You might want to use i to initialize 
> userq_fence->fence_drv_array_count here.
>
> It shouldn't make a different, but is usually more defensive.
>
>> +	}
>> +
>
> } else {
>     userq_fence->fence_drv_array = NULL;
>     userq_fence->fence_drv_array_count = 0;
> }
>
>
>
>>   	spin_lock(&fence_drv->fence_list_lock);
>>   	/* Check if hardware has already processed the job */
>>   	if (!dma_fence_is_signaled(fence))
>> @@ -240,6 +279,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
>>   
>>   	/* Release the fence driver reference */
>>   	amdgpu_userq_fence_driver_put(fence_drv);
>> +
>> +	kvfree(userq_fence->fence_drv_array);
>>   	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
>>   }
>>   
>> @@ -255,3 +296,387 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>>   	.signaled = amdgpu_userq_fence_signaled,
>>   	.release = amdgpu_userq_fence_release,
>>   };
>> +
>> +/**
>> + * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>> + *
>> + * @filp: drm file private data structure
>> + * @queue: user mode queue structure pointer
>> + * @wptr: write pointer value
>> + *
>> + * Read the wptr value from userq's MQD. The userq signal IOCTL
>> + * creates a dma_fence for the shared buffers that expects the
>> + * RPTR value written to seq64 memory >= WPTR.
>> + *
>> + * Returns wptr value on success, error on failure.
>> + */
>> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
>> +					struct amdgpu_usermode_queue *queue,
>> +					u64 *wptr)
>> +{
>> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +	struct amdgpu_bo_va_mapping *mapping;
>> +	struct amdgpu_vm *vm = &fpriv->vm;
>> +	struct amdgpu_bo *bo;
>> +	u64 addr, *ptr;
>> +	int r;
>> +
>> +	addr = queue->userq_prop->wptr_gpu_addr;
>> +	addr &= AMDGPU_GMC_HOLE_MASK;
>> +
>> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
>> +	if (!mapping)
>> +		return -EINVAL;
>> +
>> +	bo = mapping->bo_va->base.bo;
>> +	r = amdgpu_bo_reserve(bo, true);
>> +	if (r) {
>> +		DRM_ERROR("Failed to reserve userqueue wptr bo");
>> +		return r;
>> +	}
>> +
>> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);
>> +	if (r) {
>> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
>> +		goto map_error;
>> +	}
>> +
>> +	*wptr = le64_to_cpu(*ptr);
>> +
>> +	amdgpu_bo_kunmap(bo);
>> +	amdgpu_bo_unreserve(bo);
>> +
>> +	return 0;
>> +
>> +map_error:
>> +	amdgpu_bo_unreserve(bo);
>> +	return r;
>> +}
>> +
>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>> +			      struct drm_file *filp)
>> +{
>> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>> +	struct drm_amdgpu_userq_signal *args = data;
>> +	struct amdgpu_usermode_queue *queue;
>> +	struct drm_gem_object **gobj = NULL;
>> +	struct drm_syncobj **syncobj = NULL;
>> +	u32 *syncobj_handles, num_syncobj_handles;
>> +	u32 *bo_handles, num_bo_handles;
>> +	struct dma_fence *fence;
>> +	struct drm_exec exec;
>> +	int r, i, entry;
>> +	u64 wptr;
>> +
>> +	/* Array of syncobj handles */
>> +	num_syncobj_handles = args->num_syncobj_handles;
>> +	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles_array),
>> +				      sizeof(u32) * num_syncobj_handles);
>> +	if (IS_ERR(syncobj_handles))
>> +		return PTR_ERR(syncobj_handles);
>> +
>> +	/* Array of syncobj object handles */
>
> /* Array of pointers to the looked up synobjs */
>
>> +	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
>> +	if (!syncobj) {
>> +		r = -ENOMEM;
>> +		goto free_syncobj_handles;
>> +	}
>> +
>> +	for (entry = 0; entry < num_syncobj_handles; entry++) {
>> +		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
>> +		if (!syncobj[entry]) {
>> +			r = -ENOENT;
>> +			goto free_syncobj_handles;
>> +		}
>> +	}
>> +
>> +	/* Array of bo handles */
>> +	num_bo_handles = args->num_bo_handles;
>> +	bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
>> +				 sizeof(u32) * num_bo_handles);
>> +	if (IS_ERR(bo_handles))
>> +		goto free_syncobj_handles;
>> +
>> +	/* Array of GEM object handles */
>
> /* Array of pointers to the GEM objects */
>
>> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> +	if (!gobj) {
>> +		r = -ENOMEM;
>> +		goto free_bo_handles;
>> +	}
>> +
>> +	for (entry = 0; entry < num_bo_handles; entry++) {
>> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>> +		if (!gobj[entry]) {
>> +			r = -ENOENT;
>> +			goto put_gobj;
>> +		}
>> +	}
>> +
>> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +	drm_exec_until_all_locked(&exec) {
>> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (r)
>> +			goto exec_fini;
>> +	}
>> +
>> +	/*Retrieve the user queue */
>> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
>> +	if (!queue) {
>> +		r = -ENOENT;
>> +		goto exec_fini;
>> +	}
>> +
>> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
>> +	if (r)
>> +		goto exec_fini;
>> +
>> +	/* Create a new fence */
>> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
>> +	if (r)
>> +		goto exec_fini;
>> +
>> +	for (i = 0; i < num_bo_handles; i++)
>> +		dma_resv_add_fence(gobj[i]->resv, fence,
>> +				   dma_resv_usage_rw(args->bo_flags &
>> +				   AMDGPU_USERQ_BO_WRITE));
>> +
>> +	/* Add the created fence to syncobj/BO's */
>> +	for (i = 0; i < num_syncobj_handles; i++)
>> +		drm_syncobj_replace_fence(syncobj[i], fence);
>
> We should probably support timeline syncobjs here as well. But that 
> can come in a later patch.
>
>> +
>> +	/* drop the reference acquired in fence creation function */
>> +	dma_fence_put(fence);
>> +
>> +exec_fini:
>> +	drm_exec_fini(&exec);
>> +put_gobj:
>> +	while (entry-- > 0)
>> +		drm_gem_object_put(gobj[entry]);
>> +	kfree(gobj);
>> +free_bo_handles:
>> +	kfree(bo_handles);
>> +free_syncobj_handles:
>> +	while (i-- > 0)
>> +		drm_syncobj_put(syncobj[i]);
>> +	kfree(syncobj_handles);
>> +
>> +	return r;
>> +}
>> +
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +			    struct drm_file *filp)
>> +{
>> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>> +	struct drm_amdgpu_userq_wait *wait_info = data;
>> +	u32 *syncobj_handles, *bo_handles;
>> +	struct dma_fence **fences = NULL;
>> +	u32 num_syncobj, num_bo_handles;
>> +	struct drm_gem_object **gobj;
>> +	struct drm_exec exec;
>> +	int r, i, entry, cnt;
>> +	u64 num_fences = 0;
>> +
>> +	num_bo_handles = wait_info->num_bo_handles;
>> +	bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>> +				 sizeof(u32) * num_bo_handles);
>> +	if (IS_ERR(bo_handles))
>> +		return PTR_ERR(bo_handles);
>> +
>> +	num_syncobj = wait_info->num_syncobj_handles;
>> +	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>> +				      sizeof(u32) * num_syncobj);
>> +	if (IS_ERR(syncobj_handles)) {
>> +		r = PTR_ERR(syncobj_handles);
>> +		goto free_bo_handles;
>> +	}
>> +
>> +	/* Array of GEM object handles */
>> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> +	if (!gobj) {
>> +		r = -ENOMEM;
>> +		goto free_syncobj_handles;
>> +	}
>> +
>> +	for (entry = 0; entry < num_bo_handles; entry++) {
>> +		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>> +		if (!gobj[entry]) {
>> +			r = -ENOENT;
>> +			goto put_gobj;
>> +		}
>> +	}
>> +
>> +	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>> +	drm_exec_until_all_locked(&exec) {
>> +		r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (r) {
>> +			drm_exec_fini(&exec);
>> +			goto put_gobj;
>> +		}
>> +	}
>> +
>> +	if (!wait_info->num_fences) {
>> +		/* Count syncobj's fence */
>> +		for (i = 0; i < num_syncobj; i++) {
>> +			struct dma_fence *fence;
>> +
>> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>> +						   0, 0, &fence);
>> +			dma_fence_put(fence);
>> +
>> +			if (r || !fence)
>> +				continue;
>> +
>> +			num_fences++;
>> +		}
>> +
>> +		/* Count GEM objects fence */
>> +		for (i = 0; i < num_bo_handles; i++) {
>> +			struct dma_resv_iter resv_cursor;
>> +			struct dma_fence *fence;
>> +
>> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
>> +						AMDGPU_USERQ_BO_WRITE), fence)
>> +				num_fences++;
>> +		}
>> +
>> +		/*
>> +		 * Passing num_fences = 0 means that userspace doesn't want to
>> +		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
>> +		 * userq_fence_info and return the actual number of fences on
>> +		 * args->num_fences.
>> +		 */
>> +		wait_info->num_fences = num_fences;
>> +	} else {
>> +		/* Array of fence info */
>> +		fence_info = kmalloc_array(wait_info->num_fences, sizeof(*fence_info), GFP_KERNEL);
>> +		if (!fence_info) {
>> +			r = -ENOMEM;
>> +			goto exec_fini;
>> +		}
>> +
>> +		/* Array of fences */
>> +		fences = kmalloc_array(wait_info->num_fences, sizeof(*fences), GFP_KERNEL);
>> +		if (!fences) {
>> +			r = -ENOMEM;
>> +			goto free_fence_info;
>> +		}
>> +
>> +		/* Retrieve GEM objects fence */
>> +		for (i = 0; i < num_bo_handles; i++) {
>> +			struct dma_resv_iter resv_cursor;
>> +			struct dma_fence *fence;
>> +
>> +			dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>> +						dma_resv_usage_rw(wait_info->bo_wait_flags &
>> +						AMDGPU_USERQ_BO_WRITE), fence) {
>> +				if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>> +					r = -EINVAL;
>> +					goto free_fences;
>> +				}
>> +
>> +				fences[num_fences++] = fence;
>> +				dma_fence_get(fence);
>> +			}
>> +		}
>> +
>> +		/* Retrieve syncobj's fence */
>> +		for (i = 0; i < num_syncobj; i++) {
>> +			struct dma_fence *fence;
>> +
>> +			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>> +						   0, 0, &fence);
>> +			if (r || !fence)
>> +				continue;
>> +
>> +			if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>> +				r = -EINVAL;
>> +				goto free_fences;
>> +			}
>> +
>> +			fences[num_fences++] = fence;
>> +		}
>> +
>> +		for (i = 0, cnt = 0; i < wait_info->num_fences; i++) {
>> +			struct amdgpu_userq_fence_driver *fence_drv;
>> +			struct amdgpu_userq_fence *userq_fence;
>> +			u32 index;
>> +
>> +			userq_fence = to_amdgpu_userq_fence(fences[i]);
>> +			if (!userq_fence) {
>> +				/*
>> +				 * Just waiting on other driver fences should
>> +				 * be good for now
>> +				 */
>> +				dma_fence_wait(fences[i], false);
>> +				dma_fence_put(fences[i]);
>
> Probably better to drop that and do it at the end for the while array.
>
>> +
>> +				continue;
>> +			}
>> +
>> +			fence_drv = userq_fence->fence_drv;
>> +			/*
>> +			 * We need to make sure the user queue release their reference
>> +			 * to the fence drivers at some point before queue destruction.
>> +			 * Otherwise, we would gather those references until we don't
>> +			 * have any more space left and crash.
>> +			 */
>> +			if (fence_drv->uq_fence_drv_xa_ref) {
>> +				r = xa_alloc(fence_drv->uq_fence_drv_xa_ref, &index, fence_drv,
>> +					     xa_limit_32b, GFP_KERNEL);
>> +				if (r)
>> +					goto free_fences;
>> +
>> +				amdgpu_userq_fence_driver_get(fence_drv);
>> +			}
>> +
>> +			/* Store drm syncobj's gpu va address and value */
>> +			fence_info[cnt].va = fence_drv->gpu_addr;
>> +			fence_info[cnt].value = fences[i]->seqno;
>> +
>> +			dma_fence_put(fences[i]);
>
> Same here.
>
>> +			/* Increment the actual userq fence count */
>> +			cnt++;
>> +		}
>> +
>> +		wait_info->num_fences = cnt;
>> +		/* Copy userq fence info to user space */
>> +		if (copy_to_user(u64_to_user_ptr(wait_info->userq_fence_info),
>> +				 fence_info, wait_info->num_fences * sizeof(*fence_info))) {
>> +			r = -EFAULT;
>> +			goto free_fences;
>> +		}
>> +
>> +		kfree(fences);
>> +		kfree(fence_info);
>> +	}
>> +
>> +	drm_exec_fini(&exec);
>> +	for (i = 0; i < num_bo_handles; i++)
>> +		drm_gem_object_put(gobj[i]);
>> +
>> +	kfree(syncobj_handles);
>> +	kfree(bo_handles);
>> +
>> +	return 0;
>> +
>> +free_fences:
>
> You need to drop the fence reference here before you free the array, 
> otherwise it could be that some references leaked.
>
> Regards,
> Christian
>
>> +	kfree(fences);
>> +free_fence_info:
>> +	kfree(fence_info);
>> +exec_fini:
>> +	drm_exec_fini(&exec);
>> +put_gobj:
>> +	while (entry-- > 0)
>> +		drm_gem_object_put(gobj[entry]);
>> +	kfree(gobj);
>> +free_syncobj_handles:
>> +	kfree(syncobj_handles);
>> +free_bo_handles:
>> +	kfree(bo_handles);
>> +
>> +	return r;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> index c3e04cdbb9e7..f72424248cc5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>> @@ -37,7 +37,9 @@ struct amdgpu_userq_fence {
>>   	 */
>>   	spinlock_t lock;
>>   	struct list_head link;
>> +	unsigned long fence_drv_array_count;
>>   	struct amdgpu_userq_fence_driver *fence_drv;
>> +	struct amdgpu_userq_fence_driver **fence_drv_array;
>>   };
>>   
>>   struct amdgpu_userq_fence_driver {
>> @@ -52,6 +54,7 @@ struct amdgpu_userq_fence_driver {
>>   	spinlock_t fence_list_lock;
>>   	struct list_head fences;
>>   	struct amdgpu_device *adev;
>> +	struct xarray *uq_fence_drv_xa_ref;
>>   	char timeline_name[TASK_COMM_LEN];
>>   };
>>   
>> @@ -65,5 +68,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
>>   				    struct amdgpu_usermode_queue *userq);
>>   void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
>>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>> +			      struct drm_file *filp);
>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>> +			    struct drm_file *filp);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 7f6495466975..ba986d55ceeb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -27,6 +27,32 @@
>>   #include "amdgpu_userqueue.h"
>>   #include "amdgpu_userq_fence.h"
>>   
>> +static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
>> +{
>> +	struct amdgpu_userq_fence_driver *fence_drv;
>> +	unsigned long index;
>> +
>> +	if (xa_empty(xa))
>> +		return;
>> +
>> +	xa_lock(xa);
>> +	xa_for_each(xa, index, fence_drv) {
>> +		__xa_erase(xa, index);
>> +		amdgpu_userq_fence_driver_put(fence_drv);
>> +	}
>> +
>> +	xa_unlock(xa);
>> +}
>> +
>> +static void
>> +amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>> +{
>> +	amdgpu_userq_walk_and_drop_fence_drv(&userq->uq_fence_drv_xa);
>> +	xa_destroy(&userq->uq_fence_drv_xa);
>> +	/* Drop the fence_drv reference held by user queue */
>> +	amdgpu_userq_fence_driver_put(userq->fence_drv);
>> +}
>> +
>>   static void
>>   amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>>   			 struct amdgpu_usermode_queue *queue,
>> @@ -36,7 +62,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>>   	const struct amdgpu_userq_funcs *uq_funcs = adev->userq_funcs[queue->queue_type];
>>   
>>   	uq_funcs->mqd_destroy(uq_mgr, queue);
>> -	amdgpu_userq_fence_driver_put(queue->fence_drv);
>> +	amdgpu_userq_fence_driver_free(queue);
>>   	idr_remove(&uq_mgr->userq_idr, queue_id);
>>   	kfree(queue);
>>   }
>> @@ -320,6 +346,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   	}
>>   	queue->doorbell_index = index;
>>   
>> +	xa_init_flags(&queue->uq_fence_drv_xa, XA_FLAGS_ALLOC);
>>   	r = amdgpu_userq_fence_driver_alloc(adev, queue);
>>   	if (r) {
>>   		DRM_ERROR("Failed to alloc fence driver\n");
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 5fbffde48999..77a33f9e37f8 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -47,6 +47,7 @@ struct amdgpu_usermode_queue {
>>   	struct amdgpu_userq_obj	db_obj;
>>   	struct amdgpu_userq_obj fw_obj;
>>   	struct amdgpu_userq_obj wptr_obj;
>> +	struct xarray		uq_fence_drv_xa;
>>   	struct amdgpu_userq_fence_driver *fence_drv;
>>   };
>>   
>

--------------HPHHhsJPQTzguxqoGWmlYfAr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Christian,<br>
    <br>
    <div class="moz-cite-prefix">On 9/5/2024 2:10 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:25712414-4308-46ed-8c3c-f108901b3c9a@amd.com">
      
      Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:<br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">This patch introduces new IOCTL for userqueue secure semaphore.

The signal IOCTL called from userspace application creates a drm
syncobj and array of bo GEM handles and passed in as parameter to
the driver to install the fence into it.

The wait IOCTL gets an array of drm syncobjs, finds the fences
attached to the drm syncobjs and obtain the array of
memory_address/fence_value combintion which are returned to
userspace.</pre>
      </blockquote>
      <br>
      One more issue in the error handling, the rest are just nit picks
      which could optionally be cleaned up.<br>
    </blockquote>
    Thanks for the review, I will make changes and send the next
    version.<br>
    <blockquote type="cite" cite="mid:25712414-4308-46ed-8c3c-f108901b3c9a@amd.com"> <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">v2: (Christian)
    - Install fence into GEM BO object.
    - Lock all BO's using the dma resv subsystem
    - Reorder the sequence in signal IOCTL function.
    - Get write pointer from the shadow wptr
    - use userq_fence to fetch the va/value in wait IOCTL.

v3: (Christian)
    - Use drm_exec helper for the proper BO drm reserve and avoid BO
      lock/unlock issues.
    - fence/fence driver reference count logic for signal/wait IOCTLs.

v4: (Christian)
    - Fixed the drm_exec calling sequence
    - use dma_resv_for_each_fence_unlock if BO's are not locked
    - Modified the fence_info array storing logic.

v5: (Christian)
    - Keep fence_drv until wait queue execution.
    - Add dma_fence_wait for other fences.
    - Lock BO's using drm_exec as the number of fences in them could
      change.
    - Install signaled fences as well into BO/Syncobj.
    - Move Syncobj fence installation code after the drm_exec_prepare_array.
    - Directly add dma_resv_usage_rw(args-&gt;bo_flags....
    - remove unnecessary dma_fence_put.

v6: (Christian)
    - Add xarray stuff to store the fence_drv
    - Implement a function to iterate over the xarray and drop
      the fence_drv references.
    - Add drm_exec_until_all_locked() wrapper
    - Add a check that if we haven't exceeded the user allocated num_fences
      before adding dma_fence to the fences array.

v7: (Christian)
    - Use memdup_user() for kmalloc_array + copy_from_user
    - Move the fence_drv references from the xarray into the newly created fence
      and drop the fence_drv references when we signal this fence.
    - Move this locking of BOs before the &quot;if (!wait_info-&gt;num_fences)&quot;,
      this way you need this code block only once.
    - Merge the error handling code and the cleanup + return 0 code.
    - Initializing the xa should probably be done in the userq code.
    - Remove the userq back pointer stored in fence_drv.
    - Pass xarray as parameter in amdgpu_userq_walk_and_drop_fence_drv()

v8: (Christian)
    - Move fence_drv references must come before adding the fence to the list.
    - Use xa_lock_irqsave_nested for nested spinlock operations.
    - userq_mgr should be per fpriv and not one per device.
    - Restructure the interrupt process code for the early exit of the loop.
    - The reference acquired in the syncobj fence replace code needs to be
      kept around.
    - Modify the dma_fence acquire placement in wait IOCTL.
    - Move USERQ_BO_WRITE flag to UAPI header file.
    - drop the fence drv reference after telling the hw to stop accessing it.
    - Add multi sync object support to userq signal IOCTL.

V9: (Christian)
    - Store all the fence_drv ref to other drivers and not ourself.
    - Remove the userq fence xa implementation and replace with
      kvmalloc_array.

Signed-off-by: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com" moz-do-not-send="true">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 437 +++++++++++++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  29 +-
 .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
 6 files changed, 471 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a31f6c92a755..06021520a753 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1043,6 +1043,8 @@ struct amdgpu_device {
 	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
 	const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];
 
+	struct xarray			userq_xa;
+</pre>
      </blockquote>
      <br>
      A comment what that is used for might make sense here.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	/* df */</pre>
      </blockquote>
      <br>
      But please, *not* like this :)<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	struct amdgpu_df                df;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6e51b27b833d..70cb3b794a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2878,6 +2878,8 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index f7baea2c67ab..ea806cc2c1b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -25,6 +25,7 @@
 #include &lt;linux/kref.h&gt;
 #include &lt;linux/slab.h&gt;
 
+#include &lt;drm/drm_exec.h&gt;
 #include &lt;drm/drm_syncobj.h&gt;
 
 #include &quot;amdgpu.h&quot;
@@ -92,6 +93,7 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 	spin_lock_init(&amp;fence_drv-&gt;fence_list_lock);
 
 	fence_drv-&gt;adev = adev;
+	fence_drv-&gt;uq_fence_drv_xa_ref = &amp;userq-&gt;uq_fence_drv_xa;
 	fence_drv-&gt;context = dma_fence_context_alloc(1);
 	get_task_comm(fence_drv-&gt;timeline_name, current);
 
@@ -105,6 +107,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	struct dma_fence *fence;
 	u64 rptr;
+	int i;
 
 	if (!fence_drv)
 		return;
@@ -115,14 +118,18 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	list_for_each_entry_safe(userq_fence, tmp, &amp;fence_drv-&gt;fences, link) {
 		fence = &amp;userq_fence-&gt;base;
 
-		if (rptr &gt;= fence-&gt;seqno) {
-			dma_fence_signal(fence);
-			list_del(&amp;userq_fence-&gt;link);
-
-			dma_fence_put(fence);
-		} else {
+		if (rptr &lt; fence-&gt;seqno)
 			break;
+
+		dma_fence_signal(fence);
+
+		if (userq_fence-&gt;fence_drv_array) {</pre>
      </blockquote>
      <br>
      You can probably drop that if. Just make sure that
      userq_fence-&gt;fence_drv_array_count is correct, e.g. zero when
      this here is NULL.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+			for (i = 0; i &lt; userq_fence-&gt;fence_drv_array_count; i++)
+				amdgpu_userq_fence_driver_put(userq_fence-&gt;fence_drv_array[i]);
 		}
+
+		list_del(&amp;userq_fence-&gt;link);
+		dma_fence_put(fence);
 	}
 	spin_unlock(&amp;fence_drv-&gt;fence_list_lock);
 }
@@ -132,8 +139,11 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	struct amdgpu_userq_fence_driver *fence_drv = container_of(ref,
 					 struct amdgpu_userq_fence_driver,
 					 refcount);
+	struct amdgpu_userq_fence_driver *xa_fence_drv;
 	struct amdgpu_device *adev = fence_drv-&gt;adev;
 	struct amdgpu_userq_fence *fence, *tmp;
+	struct xarray *xa = &amp;adev-&gt;userq_xa;
+	unsigned long index;
 	struct dma_fence *f;
 
 	spin_lock(&amp;fence_drv-&gt;fence_list_lock);
@@ -150,6 +160,12 @@ void amdgpu_userq_fence_driver_destroy(struct kref *ref)
 	}
 	spin_unlock(&amp;fence_drv-&gt;fence_list_lock);
 
+	xa_lock(xa);
+	xa_for_each(xa, index, xa_fence_drv)
+		if (xa_fence_drv == fence_drv)
+			__xa_erase(xa, index);
+	xa_unlock(xa);
+</pre>
      </blockquote>
      <br>
      What exactly is that good for? Removing the fence_drv from
      adev-&gt;userq_xa?<br>
    </blockquote>
    yes, we are just deleting the fence_drv from the adev-&gt;userq_xa
    as we are going to free<br>
    the fence_drv in this destroy function.<br>
    <br>
    Thanks,<br>
    Arun.<br>
    <blockquote type="cite" cite="mid:25712414-4308-46ed-8c3c-f108901b3c9a@amd.com"> <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	/* Free seq64 memory */
 	amdgpu_seq64_free(adev, fence_drv-&gt;gpu_addr);
 	kfree(fence_drv);
@@ -191,6 +207,29 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	amdgpu_userq_fence_driver_get(fence_drv);
 	dma_fence_get(fence);
 
+	if (!xa_empty(&amp;userq-&gt;uq_fence_drv_xa)) {
+		struct amdgpu_userq_fence_driver *stored_fence_drv;
+		unsigned long index, count = 0;
+		int i = 0;
+
+		xa_for_each(&amp;userq-&gt;uq_fence_drv_xa, index, stored_fence_drv)
+			count++;</pre>
      </blockquote>
      <br>
      IIRC the xa had a special function for that.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+		userq_fence-&gt;fence_drv_array =
+			kvmalloc_array(count,
+				       sizeof(struct amdgpu_userq_fence_driver *),
+				       GFP_KERNEL);
+		userq_fence-&gt;fence_drv_array_count = count;
+
+		if (userq_fence-&gt;fence_drv_array) {
+			xa_for_each(&amp;userq-&gt;uq_fence_drv_xa, index, stored_fence_drv) {
+				userq_fence-&gt;fence_drv_array[i] = stored_fence_drv;
+				xa_erase(&amp;userq-&gt;uq_fence_drv_xa, index);
+				i++;
+			}
+		}</pre>
      </blockquote>
      <br>
      You might want to use i to initialize
      userq_fence-&gt;fence_drv_array_count here.<br>
      <br>
      It shouldn't make a different, but is usually more defensive.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+	}
+</pre>
      </blockquote>
      <br>
      } else {<br>
      &nbsp;&nbsp;&nbsp; userq_fence-&gt;fence_drv_array = NULL;<br>
      &nbsp;&nbsp;&nbsp; userq_fence-&gt;fence_drv_array_count = 0;<br>
      }<br>
      <br>
      <br>
      <br>
      <span style="white-space: pre-wrap">
</span>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap=""> 	spin_lock(&amp;fence_drv-&gt;fence_list_lock);
 	/* Check if hardware has already processed the job */
 	if (!dma_fence_is_signaled(fence))
@@ -240,6 +279,8 @@ static void amdgpu_userq_fence_free(struct rcu_head *rcu)
 
 	/* Release the fence driver reference */
 	amdgpu_userq_fence_driver_put(fence_drv);
+
+	kvfree(userq_fence-&gt;fence_drv_array);
 	kmem_cache_free(amdgpu_userq_fence_slab, userq_fence);
 }
 
@@ -255,3 +296,387 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.signaled = amdgpu_userq_fence_signaled,
 	.release = amdgpu_userq_fence_release,
 };
+
+/**
+ * amdgpu_userq_fence_read_wptr - Read the userq wptr value
+ *
+ * @filp: drm file private data structure
+ * @queue: user mode queue structure pointer
+ * @wptr: write pointer value
+ *
+ * Read the wptr value from userq's MQD. The userq signal IOCTL
+ * creates a dma_fence for the shared buffers that expects the
+ * RPTR value written to seq64 memory &gt;= WPTR.
+ *
+ * Returns wptr value on success, error on failure.
+ */
+static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
+					struct amdgpu_usermode_queue *queue,
+					u64 *wptr)
+{
+	struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
+	struct amdgpu_bo *bo;
+	u64 addr, *ptr;
+	int r;
+
+	addr = queue-&gt;userq_prop-&gt;wptr_gpu_addr;
+	addr &amp;= AMDGPU_GMC_HOLE_MASK;
+
+	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr &gt;&gt; PAGE_SHIFT);
+	if (!mapping)
+		return -EINVAL;
+
+	bo = mapping-&gt;bo_va-&gt;base.bo;
+	r = amdgpu_bo_reserve(bo, true);
+	if (r) {
+		DRM_ERROR(&quot;Failed to reserve userqueue wptr bo&quot;);
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, (void **)&amp;ptr);
+	if (r) {
+		DRM_ERROR(&quot;Failed mapping the userqueue wptr bo&quot;);
+		goto map_error;
+	}
+
+	*wptr = le64_to_cpu(*ptr);
+
+	amdgpu_bo_kunmap(bo);
+	amdgpu_bo_unreserve(bo);
+
+	return 0;
+
+map_error:
+	amdgpu_bo_unreserve(bo);
+	return r;
+}
+
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp-&gt;driver_priv;
+	struct amdgpu_userq_mgr *userq_mgr = &amp;fpriv-&gt;userq_mgr;
+	struct drm_amdgpu_userq_signal *args = data;
+	struct amdgpu_usermode_queue *queue;
+	struct drm_gem_object **gobj = NULL;
+	struct drm_syncobj **syncobj = NULL;
+	u32 *syncobj_handles, num_syncobj_handles;
+	u32 *bo_handles, num_bo_handles;
+	struct dma_fence *fence;
+	struct drm_exec exec;
+	int r, i, entry;
+	u64 wptr;
+
+	/* Array of syncobj handles */
+	num_syncobj_handles = args-&gt;num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(args-&gt;syncobj_handles_array),
+				      sizeof(u32) * num_syncobj_handles);
+	if (IS_ERR(syncobj_handles))
+		return PTR_ERR(syncobj_handles);
+
+	/* Array of syncobj object handles */</pre>
      </blockquote>
      <br>
      /* Array of pointers to the looked up synobjs */<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+	syncobj = kmalloc_array(num_syncobj_handles, sizeof(*syncobj), GFP_KERNEL);
+	if (!syncobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry &lt; num_syncobj_handles; entry++) {
+		syncobj[entry] = drm_syncobj_find(filp, syncobj_handles[entry]);
+		if (!syncobj[entry]) {
+			r = -ENOENT;
+			goto free_syncobj_handles;
+		}
+	}
+
+	/* Array of bo handles */
+	num_bo_handles = args-&gt;num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(args-&gt;bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		goto free_syncobj_handles;
+
+	/* Array of GEM object handles */</pre>
      </blockquote>
      <br>
      /* Array of pointers to the GEM objects */<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_bo_handles;
+	}
+
+	for (entry = 0; entry &lt; num_bo_handles; entry++) {
+		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
+		if (!gobj[entry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&amp;exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&amp;exec) {
+		r = drm_exec_prepare_array(&amp;exec, gobj, num_bo_handles, 1);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r)
+			goto exec_fini;
+	}
+
+	/*Retrieve the user queue */
+	queue = idr_find(&amp;userq_mgr-&gt;userq_idr, args-&gt;queue_id);
+	if (!queue) {
+		r = -ENOENT;
+		goto exec_fini;
+	}
+
+	r = amdgpu_userq_fence_read_wptr(filp, queue, &amp;wptr);
+	if (r)
+		goto exec_fini;
+
+	/* Create a new fence */
+	r = amdgpu_userq_fence_create(queue, wptr, &amp;fence);
+	if (r)
+		goto exec_fini;
+
+	for (i = 0; i &lt; num_bo_handles; i++)
+		dma_resv_add_fence(gobj[i]-&gt;resv, fence,
+				   dma_resv_usage_rw(args-&gt;bo_flags &amp;
+				   AMDGPU_USERQ_BO_WRITE));
+
+	/* Add the created fence to syncobj/BO's */
+	for (i = 0; i &lt; num_syncobj_handles; i++)
+		drm_syncobj_replace_fence(syncobj[i], fence);</pre>
      </blockquote>
      <br>
      We should probably support timeline syncobjs here as well. But
      that can come in a later patch.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+	/* drop the reference acquired in fence creation function */
+	dma_fence_put(fence);
+
+exec_fini:
+	drm_exec_fini(&amp;exec);
+put_gobj:
+	while (entry-- &gt; 0)
+		drm_gem_object_put(gobj[entry]);
+	kfree(gobj);
+free_bo_handles:
+	kfree(bo_handles);
+free_syncobj_handles:
+	while (i-- &gt; 0)
+		drm_syncobj_put(syncobj[i]);
+	kfree(syncobj_handles);
+
+	return r;
+}
+
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp)
+{
+	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
+	struct drm_amdgpu_userq_wait *wait_info = data;
+	u32 *syncobj_handles, *bo_handles;
+	struct dma_fence **fences = NULL;
+	u32 num_syncobj, num_bo_handles;
+	struct drm_gem_object **gobj;
+	struct drm_exec exec;
+	int r, i, entry, cnt;
+	u64 num_fences = 0;
+
+	num_bo_handles = wait_info-&gt;num_bo_handles;
+	bo_handles = memdup_user(u64_to_user_ptr(wait_info-&gt;bo_handles_array),
+				 sizeof(u32) * num_bo_handles);
+	if (IS_ERR(bo_handles))
+		return PTR_ERR(bo_handles);
+
+	num_syncobj = wait_info-&gt;num_syncobj_handles;
+	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info-&gt;syncobj_handles_array),
+				      sizeof(u32) * num_syncobj);
+	if (IS_ERR(syncobj_handles)) {
+		r = PTR_ERR(syncobj_handles);
+		goto free_bo_handles;
+	}
+
+	/* Array of GEM object handles */
+	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
+	if (!gobj) {
+		r = -ENOMEM;
+		goto free_syncobj_handles;
+	}
+
+	for (entry = 0; entry &lt; num_bo_handles; entry++) {
+		gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
+		if (!gobj[entry]) {
+			r = -ENOENT;
+			goto put_gobj;
+		}
+	}
+
+	drm_exec_init(&amp;exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_until_all_locked(&amp;exec) {
+		r = drm_exec_prepare_array(&amp;exec, gobj, num_bo_handles, 0);
+		drm_exec_retry_on_contention(&amp;exec);
+		if (r) {
+			drm_exec_fini(&amp;exec);
+			goto put_gobj;
+		}
+	}
+
+	if (!wait_info-&gt;num_fences) {
+		/* Count syncobj's fence */
+		for (i = 0; i &lt; num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &amp;fence);
+			dma_fence_put(fence);
+
+			if (r || !fence)
+				continue;
+
+			num_fences++;
+		}
+
+		/* Count GEM objects fence */
+		for (i = 0; i &lt; num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&amp;resv_cursor, gobj[i]-&gt;resv,
+						dma_resv_usage_rw(wait_info-&gt;bo_wait_flags &amp;
+						AMDGPU_USERQ_BO_WRITE), fence)
+				num_fences++;
+		}
+
+		/*
+		 * Passing num_fences = 0 means that userspace doesn't want to
+		 * retrieve userq_fence_info. If num_fences = 0 we skip filling
+		 * userq_fence_info and return the actual number of fences on
+		 * args-&gt;num_fences.
+		 */
+		wait_info-&gt;num_fences = num_fences;
+	} else {
+		/* Array of fence info */
+		fence_info = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fence_info), GFP_KERNEL);
+		if (!fence_info) {
+			r = -ENOMEM;
+			goto exec_fini;
+		}
+
+		/* Array of fences */
+		fences = kmalloc_array(wait_info-&gt;num_fences, sizeof(*fences), GFP_KERNEL);
+		if (!fences) {
+			r = -ENOMEM;
+			goto free_fence_info;
+		}
+
+		/* Retrieve GEM objects fence */
+		for (i = 0; i &lt; num_bo_handles; i++) {
+			struct dma_resv_iter resv_cursor;
+			struct dma_fence *fence;
+
+			dma_resv_for_each_fence(&amp;resv_cursor, gobj[i]-&gt;resv,
+						dma_resv_usage_rw(wait_info-&gt;bo_wait_flags &amp;
+						AMDGPU_USERQ_BO_WRITE), fence) {
+				if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
+					r = -EINVAL;
+					goto free_fences;
+				}
+
+				fences[num_fences++] = fence;
+				dma_fence_get(fence);
+			}
+		}
+
+		/* Retrieve syncobj's fence */
+		for (i = 0; i &lt; num_syncobj; i++) {
+			struct dma_fence *fence;
+
+			r = drm_syncobj_find_fence(filp, syncobj_handles[i],
+						   0, 0, &amp;fence);
+			if (r || !fence)
+				continue;
+
+			if (WARN_ON_ONCE(num_fences &gt;= wait_info-&gt;num_fences)) {
+				r = -EINVAL;
+				goto free_fences;
+			}
+
+			fences[num_fences++] = fence;
+		}
+
+		for (i = 0, cnt = 0; i &lt; wait_info-&gt;num_fences; i++) {
+			struct amdgpu_userq_fence_driver *fence_drv;
+			struct amdgpu_userq_fence *userq_fence;
+			u32 index;
+
+			userq_fence = to_amdgpu_userq_fence(fences[i]);
+			if (!userq_fence) {
+				/*
+				 * Just waiting on other driver fences should
+				 * be good for now
+				 */
+				dma_fence_wait(fences[i], false);
+				dma_fence_put(fences[i]);</pre>
      </blockquote>
      <br>
      Probably better to drop that and do it at the end for the while
      array.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+				continue;
+			}
+
+			fence_drv = userq_fence-&gt;fence_drv;
+			/*
+			 * We need to make sure the user queue release their reference
+			 * to the fence drivers at some point before queue destruction.
+			 * Otherwise, we would gather those references until we don't
+			 * have any more space left and crash.
+			 */
+			if (fence_drv-&gt;uq_fence_drv_xa_ref) {
+				r = xa_alloc(fence_drv-&gt;uq_fence_drv_xa_ref, &amp;index, fence_drv,
+					     xa_limit_32b, GFP_KERNEL);
+				if (r)
+					goto free_fences;
+
+				amdgpu_userq_fence_driver_get(fence_drv);
+			}
+
+			/* Store drm syncobj's gpu va address and value */
+			fence_info[cnt].va = fence_drv-&gt;gpu_addr;
+			fence_info[cnt].value = fences[i]-&gt;seqno;
+
+			dma_fence_put(fences[i]);</pre>
      </blockquote>
      <br>
      Same here.<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+			/* Increment the actual userq fence count */
+			cnt++;
+		}
+
+		wait_info-&gt;num_fences = cnt;
+		/* Copy userq fence info to user space */
+		if (copy_to_user(u64_to_user_ptr(wait_info-&gt;userq_fence_info),
+				 fence_info, wait_info-&gt;num_fences * sizeof(*fence_info))) {
+			r = -EFAULT;
+			goto free_fences;
+		}
+
+		kfree(fences);
+		kfree(fence_info);
+	}
+
+	drm_exec_fini(&amp;exec);
+	for (i = 0; i &lt; num_bo_handles; i++)
+		drm_gem_object_put(gobj[i]);
+
+	kfree(syncobj_handles);
+	kfree(bo_handles);
+
+	return 0;
+
+free_fences:</pre>
      </blockquote>
      <br>
      You need to drop the fence reference here before you free the
      array, otherwise it could be that some references leaked.<br>
      <br>
      Regards,<br>
      Christian<br>
      <br>
      <blockquote type="cite" cite="mid:20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com">
        <pre class="moz-quote-pre" wrap="">+	kfree(fences);
+free_fence_info:
+	kfree(fence_info);
+exec_fini:
+	drm_exec_fini(&amp;exec);
+put_gobj:
+	while (entry-- &gt; 0)
+		drm_gem_object_put(gobj[entry]);
+	kfree(gobj);
+free_syncobj_handles:
+	kfree(syncobj_handles);
+free_bo_handles:
+	kfree(bo_handles);
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index c3e04cdbb9e7..f72424248cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -37,7 +37,9 @@ struct amdgpu_userq_fence {
 	 */
 	spinlock_t lock;
 	struct list_head link;
+	unsigned long fence_drv_array_count;
 	struct amdgpu_userq_fence_driver *fence_drv;
+	struct amdgpu_userq_fence_driver **fence_drv_array;
 };
 
 struct amdgpu_userq_fence_driver {
@@ -52,6 +54,7 @@ struct amdgpu_userq_fence_driver {
 	spinlock_t fence_list_lock;
 	struct list_head fences;
 	struct amdgpu_device *adev;
+	struct xarray *uq_fence_drv_xa_ref;
 	char timeline_name[TASK_COMM_LEN];
 };
 
@@ -65,5 +68,9 @@ int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
+int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
+			      struct drm_file *filp);
+int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
+			    struct drm_file *filp);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index 7f6495466975..ba986d55ceeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -27,6 +27,32 @@
 #include &quot;amdgpu_userqueue.h&quot;
 #include &quot;amdgpu_userq_fence.h&quot;
 
+static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
+{
+	struct amdgpu_userq_fence_driver *fence_drv;
+	unsigned long index;
+
+	if (xa_empty(xa))
+		return;
+
+	xa_lock(xa);
+	xa_for_each(xa, index, fence_drv) {
+		__xa_erase(xa, index);
+		amdgpu_userq_fence_driver_put(fence_drv);
+	}
+
+	xa_unlock(xa);
+}
+
+static void
+amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
+{
+	amdgpu_userq_walk_and_drop_fence_drv(&amp;userq-&gt;uq_fence_drv_xa);
+	xa_destroy(&amp;userq-&gt;uq_fence_drv_xa);
+	/* Drop the fence_drv reference held by user queue */
+	amdgpu_userq_fence_driver_put(userq-&gt;fence_drv);
+}
+
 static void
 amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 			 struct amdgpu_usermode_queue *queue,
@@ -36,7 +62,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *uq_funcs = adev-&gt;userq_funcs[queue-&gt;queue_type];
 
 	uq_funcs-&gt;mqd_destroy(uq_mgr, queue);
-	amdgpu_userq_fence_driver_put(queue-&gt;fence_drv);
+	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&amp;uq_mgr-&gt;userq_idr, queue_id);
 	kfree(queue);
 }
@@ -320,6 +346,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	}
 	queue-&gt;doorbell_index = index;
 
+	xa_init_flags(&amp;queue-&gt;uq_fence_drv_xa, XA_FLAGS_ALLOC);
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		DRM_ERROR(&quot;Failed to alloc fence driver\n&quot;);
diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
index 5fbffde48999..77a33f9e37f8 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
@@ -47,6 +47,7 @@ struct amdgpu_usermode_queue {
 	struct amdgpu_userq_obj	db_obj;
 	struct amdgpu_userq_obj fw_obj;
 	struct amdgpu_userq_obj wptr_obj;
+	struct xarray		uq_fence_drv_xa;
 	struct amdgpu_userq_fence_driver *fence_drv;
 };
 
</pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------HPHHhsJPQTzguxqoGWmlYfAr--
