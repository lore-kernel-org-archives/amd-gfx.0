Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570E5CCD195
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Oct 2025 14:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA6310E302;
	Thu, 16 Oct 2025 14:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HevxPta9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82CF010E302
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Oct 2025 14:32:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzyIbVLSMkBWHM5fmB2gIFCQwB5iTMEGh7iHnbaMnEK8CU3zhdp3AUKpgMlLtcmQ58xlAaEIBWH7/22qn7t2DECVY5tb6w3tMF6K91FD6vPdkCk5aOoVkYuB1nbW8B3mxJU1RfHP99lM6A3592Rbos5yq0y3CHWNjImm9jjthCkrc3kxgFtR8UUrQ1Zsq/JXmva9sAEhlUP+SflJpFc+099VT53nlhPw5Hnu7Ey7bsbGLTy/CLORTpU6qtEC+iTBzIogTDrALdk+qTwpDIDmxRAPav/TPoCsNgCKsJcyituOKThEyA1JlXucEDI1lwMHSkG4JG8SdpsC9J/DskwzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5+WXYwPGCmpXH5+Z/QGPpcfQAr+TuznKoK2/m0qqY8=;
 b=CsBWKvRF8k/3GJNtdc4YJ0Y548jY2mA32bLD0RJX9JzeqUB1Z8b3ioXSd+j8qyMGOsTJxjQNwiClTQ0JuWjVcy5fB4vbDIzFRoLjxaKRKUuIGmBOnLYQnRc1D+NCXkwkvozi193fSs7tUYLvAwdhl891bBepmdZ3lGkENi7A+IKx9qihxyw/6nvSnmJXfYJ9weDaIWp+lGvKdzShyNfpeZ3/5PacJVc7lEVxZ1d8PikGvLpqE1BTiyfL5+bjv1B+OhLFGaOTBcTyBjzGzcxa0gE//Ed1eoaKG0lBClwyvVvHeTTDKK4LsLaS9c8Uy9tQT7NAXRwlVJdvRyo4KJHnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5+WXYwPGCmpXH5+Z/QGPpcfQAr+TuznKoK2/m0qqY8=;
 b=HevxPta9mDKoED6huda5rbHGsg1Rrse+HIYrWJVg4jTyrk3YWBZ/tFwO636RgeCbd2CusiptRNtg4wkgxoepJSj+6BClyVN4z0vpaQhyxisUQZ3urLPfA5s2BZX8k2P4hbpe8vTJBaXD8oSl8nlC/MYPKZA+wA9DuilOdMdKLZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 14:32:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 14:32:36 +0000
Message-ID: <4adcd0a0-3685-48d8-81c4-4bf6a4327279@amd.com>
Date: Thu, 16 Oct 2025 09:32:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Resume the device on suspend failures
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251015204920.1305839-1-mario.limonciello@amd.com>
 <CADnq5_P57TV2thkomGSOuHfiNFFEuQOeP9L8O2R9YpDGCQH0gA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P57TV2thkomGSOuHfiNFFEuQOeP9L8O2R9YpDGCQH0gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0039.namprd11.prod.outlook.com
 (2603:10b6:806:d0::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: efed44fb-f39b-4ae3-579d-08de0cc0da1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDlYMlZ3TDdBbWdwektNbTBTVVZ6Y3NaNVJXVjB6Vk4vYTY1S1hNamVsMmtk?=
 =?utf-8?B?dXdwN09SZkNwNG9UNVdtdThDY3lyVGk0NUU1OVlEQ1MyN0t1aHFFN2JvQXdE?=
 =?utf-8?B?SGk5VlBEWDdFaXNTbzVOUzB0V25kbFR6RExwT1BGbWVVVWd0YUxiZ1RwWk1Q?=
 =?utf-8?B?MC9pY0U2NlhCRllBdzdFK3RiU1g0QXRPc3JLZG5Rb3BsQXBvZDNtL0dSRy9t?=
 =?utf-8?B?ZGRhNUd4dnI4RVUxSjd2cmg3bnJYc2dacHN2cUF3dENTMTk1c1RwSDkxQ3Yr?=
 =?utf-8?B?TWlSNFBwU0dxZEcralZyQmZnSFJVWVRJRkI3T3U5Z3lXcnFKQllURnI1U2lv?=
 =?utf-8?B?bEtIWDdCOWxmVWRtcG9wcnFuK3ZJYnB5eDVMV1lQK3Ztd3NuenZtTDJ6dXE2?=
 =?utf-8?B?MXdSK0NXTjlXM1Nkd0xyY3RCSGxlZk8wemFCSVBPVEVKNzRJZGdyWUxnTjBU?=
 =?utf-8?B?dDd2S2dKMlRjSVk2WHl5Y1ZXSGViRjY1ZUFTaXdEejU5alNYOUN5aXNTTlF3?=
 =?utf-8?B?d25iVFpzL1BaSGdwR3gwM090Z0d0VkZ5UUh1bHVvTTd2WmNGTEtzSGdveXJa?=
 =?utf-8?B?WW41dnM5dmRSbWJtQis0UEgvaXBrU21wYVJYK0s5dkl0clJ3aXhJdlgxNTRY?=
 =?utf-8?B?VWU3cERxek5RNnpYQUxleTZDcVE5M05MaWxYT3FMdExQbEFMYkpNdzcxL2tX?=
 =?utf-8?B?djcrYmd4ZjFFWno1WUFxQk95TGRMd0pNQWFoU2pvdHZMU0E5OU9PeE1sR0ds?=
 =?utf-8?B?ck5FK2F1Z2dXMENlbFVnemxZWXBmWXBoWFpaaXRveG13elhjTDc3M2RBZHVD?=
 =?utf-8?B?Q3g0TW5SVzQ3ZUp0VkRHSC8xN0ZPdlhwc0pLdzY3WFpQcVd3TUIxVDBmcVMv?=
 =?utf-8?B?Z1M4U1JMVGxDZjBQUDl4ZDAxdGJBcW1qWjhwbGtCOGphUDMwb2pNQXo0eElk?=
 =?utf-8?B?SHpBSk5JRFVob09weFRFTEJTL3ZjdDkyTzRVcFc4VVZnclZPSHhqNWVyT1Fp?=
 =?utf-8?B?a1RKaURMeEptNHdZUXFoU2F6NmRpY05uSmdOWitrVUp0dWppN2VoZE1xci9w?=
 =?utf-8?B?TDdLaHBjMFIrcWRsVi9ScklWL0pXaTVxdUJmZWtseHlDVUVwVjcyNWNNVnY0?=
 =?utf-8?B?UTVnYkFHZmg1R3lnSWl6UkFBdlpjMWhiQTlIMXpCb1NlRHpld1lDdkdoT3Rt?=
 =?utf-8?B?aEQ4dC9OVDd4TjAxcDFzS1hqaldnWEt3Q0Z5VWpaeTg0UWFKaEdLNU5vQVVT?=
 =?utf-8?B?NTN1UktpaEJXS3RmMVlUMHNueFVybUVZWk5rTWNTQkZqaVJRWGRoWlZiOEFm?=
 =?utf-8?B?T3FYWlNqQXpWZlhoTE4wamF0NVU2eEZuc2JwN1BiRE1aY2JUU1VXemJsbkp0?=
 =?utf-8?B?cjVRZWhMK3VEN2x5ZXZjbUtFclRRaXorQUNhMHIwcmJUWEJsa0llYndTUGZF?=
 =?utf-8?B?cEk3Sk5Ka2dUU0pLRHhKVDBDdnM4czd3OFdUSUgxRVl6WWhaMzk4djNud3Fw?=
 =?utf-8?B?cXhNTXhPSE1VUVVUMWxHZTZHdGpYV3hicVdlWUxQbDNXdVpoRnJmSGhncGlt?=
 =?utf-8?B?RlVvcjVzNWhxaUVxNFlPcFpPenFNeUxadmhoeCszRDhsRGwyQXlJMkQycEJl?=
 =?utf-8?B?QnZob1RtTDJhb0NnanlRYzdlMEMrVDV5dUtrZ1p0ckp2cW9xYWVDUWw5NzRJ?=
 =?utf-8?B?QmM0azJYK1RFSHRpU3QyZTNxV1ZsemV0QnZXbndMeURoNnp4QytxeUdTdzdZ?=
 =?utf-8?B?OVE0UjR4aTJKbjlsYTJyTEJ2OWhDOFlDSzNYa1ZhZ09BSWVBOUU2WXVzSlNm?=
 =?utf-8?B?WmpZR3VFVTBaRHFKekpxUjl5Qms1VEZzeU90emNINjJZK1VXMGRyamxNZkN3?=
 =?utf-8?B?bkt4eDhJZ0laTGMvcWRUL2ExZk4rM3JDY293TTB5YkJ5TFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FmMmU1WUFCYythaGU0U3prbWt4Y2ptMWlFMU1xRkdRQmdVYTZBdDFYR1RZ?=
 =?utf-8?B?UzZKRm5mOGl1VDhpMkwwM21vUEJlMFhpbURIOWpDVVlrMldjRXpBVUpZaFYx?=
 =?utf-8?B?QWpPUkZxNndsMWEyeXZ0cDJydHFRWnZmbFR4YnhJN3d2S0lsV3hVRlVLVEow?=
 =?utf-8?B?Y1BneU44RjI4d1dIZmdGb1g5N1pWdXJ5bFB2VjdUT3JZSnFLVHFxaHlKUGNi?=
 =?utf-8?B?VlRQRFRkZERmUkNoek5KcUNYSVFFaWZieUNVdEg0L2tFWU9EdTRYK09CSDg1?=
 =?utf-8?B?L3JRZmJUb1hDOExtMzBkUDFwclZUczdkYmFGemdEMFdJdHZ5UHZqZUVLeGx3?=
 =?utf-8?B?ekpNcWpWemFBUjJKTEhiKzYwQ1puQWlaRHBSVUJSalBJTFRZWUhoUERXZlFi?=
 =?utf-8?B?b2k1TmN0eUNRUUxrUkxIWUt5YWM2UTQzYkhoTFQ1eXVMbjFBY0dvTHBaS1Nx?=
 =?utf-8?B?OG1FMFAyTXFBV2NzaEhESHNWS1p0U241RS8yZG41SEV1Rk1ac2lnQjNiUmpX?=
 =?utf-8?B?WWExM1ZCaDdFdmhKbEdoM0xCbEVXa0pVTHFhaFAzbUorOStFUnhtTWNUbEE3?=
 =?utf-8?B?aENQczhiaVdWTmN2RXorSXAzN01kMmVPUnRXaTlkV05HalQrWk1lWGgzZFlR?=
 =?utf-8?B?M2lENlBPRlg2czBCVTgxclRZQnZHN3VUNE5Mb0M1dGVzbVBxYW9Va0NveGdt?=
 =?utf-8?B?TXBOa1d0UExzNVREakIrbGhXTFR6SDdYMlJGTkYrOHQ2WHU3K2pqMmtGTlU5?=
 =?utf-8?B?RkZDVHpraXZxTzluK0pqREJkZ3NhVk42QVhXZU4yZG0vV01renkwUUI1UDEz?=
 =?utf-8?B?ZUFwL0ZZZ1hNM0V0bjJMUWR2Y3lZS2orZ0UwMG82WG50U0xZNjZlZFNFOFhq?=
 =?utf-8?B?YTlzbGY3VDRQV0FUYWZ5b0h5OG01NXhISFBMN09tZUJyOFFXMVNLNjBzSlBZ?=
 =?utf-8?B?UHJ5d2VzbURqVGw1eWo1VUYwSDF5bWJTR0lRTXZLRWZBOHU0VFc2bjhEbllm?=
 =?utf-8?B?YmZqdUxTa0VLOVBOMnY4NmhnQmpOYVgxbUJ5UW43V2RUS2FycmU0MnBrOE05?=
 =?utf-8?B?YmFnUEVuUHJrVW13TnNiZU9kNnJXUTBZWmlmdnQ5SS9CZGxMQmNRYmdocmxz?=
 =?utf-8?B?c285RGVsY21jVHFZeldlT216b3Y5VzFmaWVlclY1Z09kOWJWTXZVRCsySGdE?=
 =?utf-8?B?UjhxTGJzS1VxanlhQlczQzZZTTQ5NnZTdml4TktXUkpiQ1lvNXFtRDJWbTFj?=
 =?utf-8?B?bWkzWlNFSUV0aWFOY0c2V2paY0lic3AyUEFKeVdzYitXOExQR0lDMmtyZnk3?=
 =?utf-8?B?UGpva0FsN1RxVjlHTlltTHBpcHJ0M09zNXJqZW12a2swakdLR0RsUVRPaU9Z?=
 =?utf-8?B?VUxGSGhsQlg4NHhDN0l4L2orY0MyekZPcFltTGdoMmF2T0lPWTEwTGtvTExP?=
 =?utf-8?B?WmczK051RjJiYTBxYmMxWWV5T2txN0ZSSWQ0M01vZmdNS2pYQ2lEQ1dZRDNB?=
 =?utf-8?B?RUdwR3FVaUJrcEhLSUNmWFZ5cW4yTjRZNHJoMEoyeHRWUnhyMjZOck9rZ1pp?=
 =?utf-8?B?R3piWDJpZHYrUTJTUmpGWGE2TWUyRjdhSFQveEJtZVpKc2o0azg1VzJlbmpF?=
 =?utf-8?B?MnpCQWMrNzBqRDZwQUVvRW13eVZQZGViMWQ3NWdRU2h6bkYyVmxzd296VFBF?=
 =?utf-8?B?czNzMTJlMkRuMS90ZFNjRlZYajR5M2pKcVlRYjZHQ09vY0RyZEt1R2tHWkFi?=
 =?utf-8?B?ODFRYnl3MTBNVEFNQkJrSVNDYThoWk9tQTRCWUdDUk9vMEdzdGFXNThpVjEz?=
 =?utf-8?B?bjl1YUFhWVExK09HRUZYZXdOKzZHTEp4Y2FOSHg1eWdWZVlqekJOMk5kS0tN?=
 =?utf-8?B?U3BwYmdFNlk5Y0xmSHJ6TXVYbUdFcDZsTGpCU3VkK01UVzJHdzZPdXA5N2or?=
 =?utf-8?B?UHhvY0JnMmJocGszZlErYllWWnpRcXF0Z0FUazNNa3UwL1VQTGJPSTAza0sr?=
 =?utf-8?B?YytlNnZuN1BqTFM5RERZZzlmUVkzT09rK0tqL3k0YjZzWEFIK3JRdUpQcXRz?=
 =?utf-8?B?TlpwSzVLNDRRZ0tDTzdyYThKMUV3WFpUQy9yemUySlJVN1lNeGI1SXdaVDJP?=
 =?utf-8?Q?VMclKpIYZ9smD1vf6WYp1ZDBc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efed44fb-f39b-4ae3-579d-08de0cc0da1c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 14:32:36.7338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QHX9cHaU9rabl/z5waR64UOdiPPCg2pPBf2q/5ghaIgHR6iPTLjexZh6Pmq5VlfmU2YNKlpHjwFTQk1KwXVCxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659
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

On 10/15/25 5:14 PM, Alex Deucher wrote:
> On Wed, Oct 15, 2025 at 5:06 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> If the GPU fails to suspend the return code is passed up to the caller
>> but it's left in an inconsistent state.  This could lead to hangs
>> if userspace tries to access it.
> 
> Hmm, so the caller doesn't call the resume, etc. to restore things?

Nope, those are only called if it succeeds.

> I
> wonder if it would be better to call amdgpu_device_resume() in the
> amdgpu internal callers rather than handling it in
> amdgpu_device_suspend().  For example, does it make sense to restore
> the working state in the shutdown() or poweroff() callbacks?  What
> about the other way around.  E.g., if resume() fails, should we call
> suspend again?
> 

complete() is called even during failures.  Another way we could do this 
is to add code in complete() that does the resume if the device is still 
in suspend and a failure occurred.  I actually like this better as it 
keeps things a lot cleaner.  I'll check if the PM core has a way to tell 
it's in the failure state; but even if it doesn't we can tell from 
adev->in_suspend still being set.
> Alex
> 
>>
>> Instead of leaving it in this state, attempt to resume using
>> amdgpu_device_resume().  IP resume functions check the HW status
>> and thus should only resume the IP that got suspended if a failure
>> happened part way through.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index a99185ed0642..59672b880d75 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5227,7 +5227,7 @@ void amdgpu_device_complete(struct drm_device *dev)
>>   int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>   {
>>          struct amdgpu_device *adev = drm_to_adev(dev);
>> -       int r = 0;
>> +       int r, rec;
>>
>>          if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>                  return 0;
>> @@ -5240,7 +5240,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>                  amdgpu_virt_fini_data_exchange(adev);
>>                  r = amdgpu_virt_request_full_gpu(adev, false);
>>                  if (r)
>> -                       return r;
>> +                       goto resume;
>>          }
>>
>>          if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
>> @@ -5255,16 +5255,16 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>
>>          r = amdgpu_device_ip_suspend_phase1(adev);
>>          if (r)
>> -               return r;
>> +               goto resume;
>>
>>          amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_runpm);
>>          r = amdgpu_userq_suspend(adev);
>>          if (r)
>> -               return r;
>> +               goto resume;
>>
>>          r = amdgpu_device_evict_resources(adev);
>>          if (r)
>> -               return r;
>> +               goto resume;
>>
>>          amdgpu_ttm_set_buffer_funcs_status(adev, false);
>>
>> @@ -5272,16 +5272,22 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>
>>          r = amdgpu_device_ip_suspend_phase2(adev);
>>          if (r)
>> -               return r;
>> +               goto resume;
>>
>>          if (amdgpu_sriov_vf(adev))
>>                  amdgpu_virt_release_full_gpu(adev, false);
>>
>>          r = amdgpu_dpm_notify_rlc_state(adev, false);
>>          if (r)
>> -               return r;
>> +               goto resume;
>>
>>          return 0;
>> +resume:
>> +       rec = amdgpu_device_resume(dev, notify_clients);
>> +       if (rec)
>> +               dev_err(adev->dev, "amdgpu_device_resume failed: %d\n", rec);
>> +
>> +       return r;
>>   }
>>
>>   static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>> --
>> 2.51.0
>>

