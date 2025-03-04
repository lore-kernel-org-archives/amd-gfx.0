Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D0C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 18:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E932C10E686;
	Tue,  4 Mar 2025 18:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IzPtO/zZ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93E8910E686
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 18:23:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEqOo4S0xfjb8ahMhBIIYDeAHSiNQVl7seGI883br0XwSQ1cmwPv39TrRc63bW+3U+MOB1xd4BKJe6orNoJVEUN5et3N3VP7DBu+x68uh/5r78x76lUWtVRZ/Dt0E1TbrCjJI4GxAQ/6tncfywhaBETAGZNS6LjsvxYx0zBYYBe7+U2I78c5D7GUtpDU0fsAAEY8AI0eK8MfHU40ScMbZJxBd97a618On0QZr23Sa7tDxyUH4eCHH9r1Ot9LEwKnvNposudFzZHfXRdiqWntSPA9k2ZDMbmH7Pdtm/EJicfkkbNp13zDq6bXFG7jF9IPMPJYMIy+y5ewWPV2xyEy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKbROx6ryJF4nh61ZnAivFxWWbhDf4UP/dXcGHsbDP4=;
 b=SOYAB53NA7oyxKM1Vz70UJDsqo7LbbnM7UVX8i2ih3o6N+MFvH9IcL2Fufg33N0I/7+Ejn4LiY9bedgCH73eDYape7VIz2EjwN8ZqhjuR3OJqUf5VIxWSoDgWAyxOClDuTJ+ai3E1+t1Yyr1Y4G0QTzgEvw9y5MXEunEjy7NGH4YTrBm9b+bHXGAkh8GfFGxSgnh6EOxWimuF5Xq/KnXZbM8YO2/sx3YjTu5eDO+0L4eSIwZvpiNDp0Zg5UVERsKm6tKBrFMTrEg6stygIWqaFY+iFizbrIKGavYh1doBPkItok2MZqNXoOI3pfTWBJw0d0pPcUbGOQ3ieDKA7KfOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKbROx6ryJF4nh61ZnAivFxWWbhDf4UP/dXcGHsbDP4=;
 b=IzPtO/zZ21hksp1yYhMyhXQ5BNxychtgx3Q6StScEVSH3I9QT/VJTf8w7Qzi8vPPhFFqH0TmM9si9fSim+7FTrLRSYUMr6Fl74JTWoHE5PRNAwTWQYvoemIlpIXQ4aFbrqF4Ct+WWW/iW6pmRMJrrx0kDbCRKD/tPGjf2a2YFEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SA3PR12MB7949.namprd12.prod.outlook.com (2603:10b6:806:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 18:23:13 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 18:23:13 +0000
Content-Type: multipart/alternative;
 boundary="------------CIhuvP5GXGneeJnuhUOWr5DJ"
Message-ID: <da6aa7ea-bf95-4e5d-8c37-5a2c43c4fc2f@amd.com>
Date: Tue, 4 Mar 2025 12:23:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Change error handling at prange update in
 svm_range_set_attr
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165839.8433-1-xiaogang.chen@amd.com>
 <af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com>
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SA3PR12MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: c6163b65-65bb-4e90-f7b0-08dd5b499fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEFSVTlHakFjRlF3Z2hVbFJUVktkclVSYmtPVWMyRDUrQ3R0Q2RranQ2SThj?=
 =?utf-8?B?c1dUYSthaVczSElvcEUrUUMrY1VtWmFXN0VnaDl0Rm8zK3YvYVJTeElEb2JP?=
 =?utf-8?B?V0lKNmRLUUFBZXZLdnlZeGZmVzlybElQS3p0NWZ0eTBISWlXcU9ZSEFVOFE4?=
 =?utf-8?B?ZnlzRU1TWVRycHNBSkhrbHNsTDdUL1Y2R1JxQkZidEtKbElPTVcwbW1IUTh0?=
 =?utf-8?B?T2dYZHEySXNnM3VlekxtL2w4azhzMTJjV1NrZnFheEVkRkRmclVFbVE4L3RJ?=
 =?utf-8?B?S3QzbWxNQUtxU3dwbVUyNjZOTmVScFhvd29qQURoUUlVWjJxZXhiYkNqcno3?=
 =?utf-8?B?RElNUWxzNEtGMzRPTkVFWGpmeDByOTFBeHlFQU0xMlk0bFVMZ1h2a2k1NkJ5?=
 =?utf-8?B?c1NMa2s4ZlMrdlJ6bzY5OWtkNFZqRit1ekNQWE1XT3hLVFAxSXFrc21mRkR1?=
 =?utf-8?B?S0VpbXdsbXRGNkxwTVNWUG96anVFalhNOTJTM2JZNVhQWHdoNW5UNVVjSzRP?=
 =?utf-8?B?OGcrT3Vja0trMjZiYUsxdVZUT3lGeFcrUVNqTElGc1c0bXF1RkRWdHJoNjdW?=
 =?utf-8?B?L1pqTVJiWlVHZDJoWnlvNWFpRGhrcURSdEJhQWw3ZUJ1TElPampXK3VkSjJ4?=
 =?utf-8?B?d1dlZk12eDg0VzgrSjVTdVdIZU5qSWVHeUtRQnZyZG9EbXZLYU1QVGpBdzBO?=
 =?utf-8?B?SksxKzAvcWthSnc0S2sxRWdiTmFzMHUvUzNDSGk2MXlVUkh6N2dMYkJMWjda?=
 =?utf-8?B?Qlp4YUlveENNRUdNMnlrTEFudGhSTk9GeHBaZ3NDSFJuVmFyZy9yY2liU1Y0?=
 =?utf-8?B?R2VqUzBqR1NqcS82YjhoQlNPaXMxVCtHc0FDUFBGQjZ6WWlLSnVWWWdJaFJh?=
 =?utf-8?B?dmxoTytJSjNMdHlTUXBWMjVXdTlLKzRuQjZkZU83OHYySzhTWE5RaFQrQXdG?=
 =?utf-8?B?Zyt5YzRNTzFnNWFrWXdYdkZIN2NZSTNma3U3MnVxTVdhbEQ2T2g5M2xVZC9s?=
 =?utf-8?B?Uyt3Q2NNNmI4TWx5cmd5aXJxM2gwdWMzd3FzQlR0U0h3QWxpcjE4SVduMXpG?=
 =?utf-8?B?RGZGaExMK3Vhc0Z2Sm5uZ2Y0UFFZMVBwaFhROC80d0xSUU5NaHBRalRTanhX?=
 =?utf-8?B?c2dqeDlSLzNLbHc2a1JZM2FoVE9XWFd6L1RIcUVCUEdRQy9UdXB4aStuVys3?=
 =?utf-8?B?VjJOV2ppdHhsQTJaS1hOTWl5RHE1RHlrY2t6RFIrbmRhbk5CREdYOExlaGVB?=
 =?utf-8?B?RzFaR2JOc2trMG13bHNmcnp4L3VCS3BHRzg5UHhGMFdkUDN4OThTYWM0UGNI?=
 =?utf-8?B?UUtkM0g2cDFQTDByS3VKUnJBZ1lLa3o0NFRHSDY5Z3hqZFc1YjdMV1ZrdmJx?=
 =?utf-8?B?OXU1dEVpY2Rjc2tJV3g5RGdNZ0NMdG9SRkZpaUJlMHB2MXRtaFp2ck1DRzJ1?=
 =?utf-8?B?bVF4UkIxdGNVR1lMT1hObGNUVlA1REdYcW5Tc2dHK2s1YmxNM2Y3aGFjMzlm?=
 =?utf-8?B?ZkZUbWkrWnZzOW1nWDU4MGpsSUxiNDYyTjI2VlJnMjVuU2dZdTFRT1pUdmRV?=
 =?utf-8?B?clNqZVNla1ZucUl4QTlxNkJ5ZG1pSlFiakFTZEZXM1ZOU20zWGIxN2pOZlV0?=
 =?utf-8?B?bVcrQWtjOWFZaVlUVXhybVNITkxmRDQwR0R2c0xJUm1VekJrTFNvVlRmMmpz?=
 =?utf-8?B?SFloSHRYK205REovQXEramRNNk1CaERlNERxTzdVS3BsTmFtV01JYjlxaFRy?=
 =?utf-8?B?aE15S1VJVUV2TjM2SmZjTlBmQTY0ZWxJWk12UnpUUHI0SU1JWnJJMjJHNkxB?=
 =?utf-8?B?LzBXQjZKaEJGUDdhTFVUUTdKaUxQUlRUdmFQNHNNK1lWWTlDdWxUZGtwemJL?=
 =?utf-8?Q?3mwb9irgxMcgb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRVa203Zk5nMHIxdTkvTmJVMG92ZWxscHNOUENtWk1ERnZOM0RKbGRjNHRz?=
 =?utf-8?B?NHJqUkV6RzUwRTNqeEV6aXYzd3Q5VFg5SDhwWkQ1TXdBMDhONEJxYXN6dHZF?=
 =?utf-8?B?OTZwS1NERC9rcjRJZHdJVHVnOGw3Uzdpb3cvem1KWCtrUEZ1LzZOM211bll5?=
 =?utf-8?B?MDd1Tk02V3ZscjNsWWtma09PUHBlc2xIeTZUZzNiWWExYUtCNW1TRk96N3ZM?=
 =?utf-8?B?SzhCNlEvRDRNRVkrNDdmMmdKUnNVM2RvNkhSUHlNTWREYmlsUjBlZFovcExk?=
 =?utf-8?B?blUzTjgway9vL1dxZE4xZWRpaVJyb1oyRTlxbDVhS1IySDFNMUpBaFJpQ1pz?=
 =?utf-8?B?ZzQ1dC8rYytlMW95NWFsSkFlanh5ODVQZ0hDRjJpZWppUU10cEVwVUFnSUJR?=
 =?utf-8?B?K1h1OHl4K1dpM29wZlQwN016MWlmUnlZcHQzYjI2eTcxYXIxRi9mMVlhanlk?=
 =?utf-8?B?bjQ0aDhzcEZrSHB2M2pTdjk2REFlTENHMkdEL1JPK0hva1AvRlFxT3p5OTBw?=
 =?utf-8?B?RlZ2QU5sQktDeTl3dlNMTEYyaHlwdjlpMG9pQmpWbVI1MFVtMEJ2SGNVa3BQ?=
 =?utf-8?B?Nlh5czUxeGliYXZFbDlLVVgrY3BpVmdZQ1F1ZGZRUlh2YnovTG93UDNydWZD?=
 =?utf-8?B?N0pDMFNqWExybW82bFRpdVVDMDZvTm9DWGQvejM1RTQ5c0c1SS9vNzJVODJB?=
 =?utf-8?B?K0VoaGVIVzc4WTlEYUJBNk5RNGNVcWtBeGNjelZPd2dQU3d0eWxDM2krZzdX?=
 =?utf-8?B?a0tVRXV6L2ptVmhScUwwaTg1T0FTTFIxb2JXVm9wMFh6SnY0dTl2NlpxSHpP?=
 =?utf-8?B?YXppWUJKYUZ5YWNNRFBMVmZLK1NWUlFzNThjM2paZm1vM3FHZVlERGJRbjlp?=
 =?utf-8?B?NUFkUDQ2SFRLb215NXZ3aHpRazhUMjdIMlVFZStoSm01SGMzYlAyME5DSTJz?=
 =?utf-8?B?ZEhuaE1qOFNFdFJoRndURDlqOUVlZlFvTUVqZVh0Y0VNbmNHZ0VTVlk4SjlS?=
 =?utf-8?B?SGVCenRwSEVqc1lGQVkwTWoyeWI0eU5wMnRkbmpkN0FWeHFsS3QzenZXdnpE?=
 =?utf-8?B?ejBTaE8rQkZEK2R4UlIyTFgyMFpkYkMwZklQM2lPd2NVTW5LMlExdVBmNWRw?=
 =?utf-8?B?VU41MEd4alVwTStyNkpHY0tySGtFMHlyUlhXaXozRWJReHdNd3hVOW1vcjFD?=
 =?utf-8?B?aERSekh5cnQ0SzNGclJGKzZ5WjNJeGRrRllsQUZVTE5iaGNnblVWV08rV3pT?=
 =?utf-8?B?TlI2eGhBZXAwM2p4cW5MS3krejBzTTlSTnN4c0IzVXhWOE5xa2M5MEh6T2la?=
 =?utf-8?B?Y09jejZ5N3l5a1YvN1d4MEpGUDFMb3ErZjVReUtoSjRnN2d3K0JQYXh2Rkxu?=
 =?utf-8?B?RVh6VnA5WWtBMnlpVEpHZzJXV3lKUkRnanFXVE9pMTZ2TGRqQnIvRTRCY3d2?=
 =?utf-8?B?ZkJ2YVhidzJEdjFJWHpEWExTVko1Y25KM0FiZDZlbVhYN21ad1M5QW9seHJK?=
 =?utf-8?B?aXk1L2lvVldVV3RjMllZR3ZobXpmVlhlMlhNVklYVCs3aXpNSWVyWnhwMDI3?=
 =?utf-8?B?OHlQcmY5cTJPVXdobkN2VUlRTyt3eFp1T1ZmZWxmcWlud1YwYUF2cEZ1aSta?=
 =?utf-8?B?K2kwWlNyUXZjUzBUYkJwVlpXWVUyY0YzeXF0MWtXRjVOV2F1M200QVJmNlgx?=
 =?utf-8?B?cTJtVDZhY3lCb2R0dXlmRXY4bVlBOG5PeUZQR2crNld0K241RHYwRUhwamsy?=
 =?utf-8?B?SUpHWGF3Sll6eDBGaHJEMmE4R3labXpqeTE2eVllcGFZWHBFTTI1TTZMMmlT?=
 =?utf-8?B?bHVOamdvMXgxQmluWThBcGNuSTNPSXhRYVVlNDg0VWpRVk04Q0dsVzdZdEhv?=
 =?utf-8?B?Y2h4RjF2aGlOTDIvS2t6ZHZQQzdhNnFVdVgxanMvejkzWkE4ZThBYUVnNDN6?=
 =?utf-8?B?Wkk2Y0ZNaHd3ZjNKQUhWQlhXQ0xSbnJyK3pUL0Y0SXhUZTVGRkE2Z3l0K3lM?=
 =?utf-8?B?YUE0c3hTeGpwNHpsZmJrNjQvV1VUMXVTQjgxdlVQTzJNekVhb0Zwd0tvSEFH?=
 =?utf-8?B?a1BXTERQM0FUVmJ2N2pmanQwM1JBSCt1akl4cVdLUTNXZFdUcmFuYmhtSzdX?=
 =?utf-8?Q?EzZQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6163b65-65bb-4e90-f7b0-08dd5b499fe6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 18:23:13.1489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2PmwHaNhcwXhihcEXPZY+lnxbwfEhKWy9xzigmK/YUnkrQij5VK01reZgsx77M1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7949
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

--------------CIhuvP5GXGneeJnuhUOWr5DJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/3/2025 11:21 PM, Felix Kuehling wrote:
> On 2025-01-31 11:58, Xiaogang.Chen wrote:
>> From: Xiaogang Chen<xiaogang.chen@amd.com>
>>
>> When register a vm range at svm the added vm range may be split into multiple
>> subranges and/or existing pranges got spitted. The new pranges need validated
>> and mapped. This patch changes error handling for pranges that fail updating:
> It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.
>
Current way is returning the last sub range error code if it got issue 
during migration, validation or map. If the last error is -EAGAIN, but 
there are other error codes at middle for other sub ranges we still 
return -EAGAIN. That causes same procedure repeated until the sub ranges 
that have other error code becomes the last one.

I noticed it when looked at large range(more than 100GB) registration 
which split into multiple sub ranges. There were multiple unnecessary 
repeats until hit return code that is no -EAGAIN.

As you said we may return immediately if hit no -EAGAIN, and hope app 
terminates. But if app does not terminate kfd drive will hold unused 
pranges until app stops.

>> 1: free prange resources and remove it from svms if its updating fails as it
>> will not be used.
>> 2: return -EAGAIN when all pranges at update_list need redo valid/map,
>> otherwise return no -EAGAIN error to user space to indicate failure. That
>> removes unnecessary retries.
>>
>> Signed-off-by: Xiaogang Chen<xiaogang.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index e32e19196f6b..455cb98bf16a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   
>>   out_unlock_range:
>>   		mutex_unlock(&prange->migrate_mutex);
>> -		if (r)
>> -			ret = r;
>> +		/* this prange cannot be migraed, valid or map */
>> +		if (r) {
>> +			/* free this prange resources, remove it from svms */
>> +			svm_range_unlink(prange);
>> +			svm_range_remove_notifier(prange);
>> +			svm_range_free(prange, false);
> Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.
When return -EAGAIN app will do whole range registration again including 
rebuild sub ranges. And at this stage we do not know if subsequent sub 
ranges will be success or fail. So I release current sub range resource 
if it got error(including -EAGAIN). After processing all sub ranges if 
decide to have app do it again, the redo procedure will rebuild the 
released sub ranges.
> I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?
I made a test app to check the behavior of registration of large range 
for debugging a real issue. I do not know if real app will continue to 
run when hit no -EAGAIN error code. The purpose here is making driver 
handle this case more general.
>
>> +
>> +			/* ret got update when any r != -EAGAIN;
>> +			 * return -EAGAIN when all pranges at update_list
>> +			 * need redo valid/map */
>> +			if (r != -EAGAIN || !ret)
>> +				ret = r;
> This is a good point. But the explanation is a bit misleading: "all pranges ... need redo" is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.
ok
> I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.
>
As said above it is a another way to return immediately if hit no 
-EAGAIN.  but should kfd driver release unused pragne resources any way?

Regards

Xiaogang

>> +		}
>>   	}
>>   
>>   	list_for_each_entry(prange, &remap_list, update_list) {
>> @@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>>   		if (r)
>>   			pr_debug("failed %d on remap svm range\n", r);
>>   		mutex_unlock(&prange->migrate_mutex);
>> -		if (r)
>> -			ret = r;
>> +
>> +		if (r) {
>> +			/* remove this prange */
>> +			svm_range_unlink(prange);
>> +			svm_range_remove_notifier(prange);
>> +			svm_range_free(prange, false);
> Same as above.
>
> Regards,
>    Felix
>
>
>> +
>> +			if (r != -EAGAIN || !ret)
>> +				ret = r;
>> +		}
>>   	}
>>   
>>   	dynamic_svm_range_dump(svms);
--------------CIhuvP5GXGneeJnuhUOWr5DJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/3/2025 11:21 PM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">
On 2025-01-31 11:58, Xiaogang.Chen wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When register a vm range at svm the added vm range may be split into multiple
subranges and/or existing pranges got spitted. The new pranges need validated
and mapped. This patch changes error handling for pranges that fail updating:
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
It may help if you clearly state the problem you're trying to solve to justify the changes in error handling. See more comments inline.

</pre>
    </blockquote>
    <p>Current way is returning the last sub range error code if it got
      issue during migration, validation or map. If the last error is <span style="white-space: pre-wrap">-EAGAIN, but there are other error </span>codes
      at middle for other sub ranges we still return <span style="white-space: pre-wrap">-EAGAIN. That causes same procedure repeated until the sub ranges that have other error code becomes the last one. </span></p>
    <p><span style="white-space: pre-wrap">I noticed it when looked at large range(more than 100GB) registration which split into multiple sub ranges. There were multiple </span><span style="white-space: pre-wrap">unnecessary </span><span style="white-space: pre-wrap"> repeats until hit return code that is no </span><span style="white-space: pre-wrap">-EAGAIN.</span></p>
    <p><span style="white-space: pre-wrap">As you said we may return immediately if hit no </span><span style="white-space: pre-wrap">-EAGAIN, and hope app terminates. But if app does not terminate kfd drive will hold unused pranges until app stops.</span></p>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
1: free prange resources and remove it from svms if its updating fails as it
will not be used.
2: return -EAGAIN when all pranges at update_list need redo valid/map,
otherwise return no -EAGAIN error to user space to indicate failure. That
removes unnecessary retries.

Signed-off-by: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index e32e19196f6b..455cb98bf16a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3716,8 +3716,19 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 out_unlock_range:
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
-		if (r)
-			ret = r;
+		/* this prange cannot be migraed, valid or map */
+		if (r) {
+			/* free this prange resources, remove it from svms */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Freeing the prange removes SVM mappings from the process. This will break the subsequent execution of the application. In case you were going to return -EAGAIN that's definitely wrong because the application would expect the SVM range to work after a successful retry.
</pre>
    </blockquote>
    When return <span style="white-space: pre-wrap">-EAGAIN</span> app
    will do whole range registration again including rebuild sub ranges.
    And at this stage we do not know if subsequent sub ranges will be
    success or fail. So I release current sub range resource if it got
    error(including <span style="white-space: pre-wrap">-EAGAIN)</span>.
    After processing all sub ranges if decide to have app do it again,
    the redo procedure will rebuild the released sub ranges.<br>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">
I'm not sure the resource waste is a valid argument in case of a fatal error. I would expect the application to terminate anyways in this case, which would result in freeing the resources. Do you see a scenario where an application wants to continue running after this function returned a fatal error?
</pre>
    </blockquote>
    I made a test app to check the behavior of registration of large
    range for debugging a real issue. I do not know if real app will
    continue to run when hit no <span style="white-space: pre-wrap">-EAGAIN</span>
    error code. The purpose here is making driver handle this case more
    general.<br>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+			/* ret got update when any r != -EAGAIN;
+			 * return -EAGAIN when all pranges at update_list
+			 * need redo valid/map */
+			if (r != -EAGAIN || !ret)
+				ret = r;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is a good point. But the explanation is a bit misleading: &quot;all pranges ... need redo&quot; is not really true. There may also be ranges that were validated successfully. I think the point you're trying to make is this: Don't return -EAGAIN if there was any previous fatal error found.
</pre>
    </blockquote>
    ok<br>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">
I could potentially see a different optimization. If you encounter a fatal error, you can skip the rest of the ranges and return the error immediately.

</pre>
    </blockquote>
    <p>As said above it is a another way to return immediately if hit no
      <span style="white-space: pre-wrap">-EAGAIN</span>.&nbsp; but should
      kfd driver release unused pragne resources any way?</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:af21821a-b22c-40e4-9f17-2a15d4813cd7@amd.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		}
 	}
 
 	list_for_each_entry(prange, &amp;remap_list, update_list) {
@@ -3729,8 +3740,16 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		if (r)
 			pr_debug(&quot;failed %d on remap svm range\n&quot;, r);
 		mutex_unlock(&amp;prange-&gt;migrate_mutex);
-		if (r)
-			ret = r;
+
+		if (r) {
+			/* remove this prange */
+			svm_range_unlink(prange);
+			svm_range_remove_notifier(prange);
+			svm_range_free(prange, false);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Same as above.

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+			if (r != -EAGAIN || !ret)
+				ret = r;
+		}
 	}
 
 	dynamic_svm_range_dump(svms);
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------CIhuvP5GXGneeJnuhUOWr5DJ--
