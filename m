Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874C1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 15:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A82910E9D4;
	Fri,  3 May 2024 15:48:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wUb45k2h";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDFC10E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:48:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUyJzyymB5gLK+Tfzo7W1jfM8vy5TKg1tyZl4a5W1gv6xF1kLEAaATNVovl13Y0IvMx+NEoBjkCzEnV47ZymAv6DorD7y8JCHowTi93cu3OJfjU6dRsHZ2sDUpVKXIfhAcG06rlxiFAkaJ1u4Gf/zBxKqYzEGtqFCSwkKReyAmOjd/9lVQ32owsBjWTrGncTIRS672n/YLBbUL2R7cMNj/gVRIGAw+ssZqjQ+L3/BKr4ALqJ7G3xLNTA2BqPMcl8BPLIBENtwcaTzd6KtUpyY2KqnixWzG7NNUdlo04uqROOF/nmyhqDQVlAY6IyPPImvBPDlG63bhEVytH8J7wpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Bj26MB6u60oPRYn3YxcFVRUKyHoLPckGUXFxonyRis=;
 b=E0peWhK8dnFeowD5T9z22CI4fhH83LdUVE4Yf+q8OWOVnL2xC2aiKjYViqPV42IunnQk4RhAY0rmYiBAyXM/NFZSzC3BTgzUtDUMvAO9jvnbsF15/TYGQTI+AzOkDNTv8ZDc0xoZiB6xLqI9LwPE+xlHpnTeFT8aCEA0d8j7NSnVNJoqDH/S39+4hNv27kz/BD/3yEisvotl3t7OjMLgANhqyVHaUN05GPeAsbu/8vTzOha78/rBiq1apH+aydk8ELbQw1hDVqeUyhOFI9hrpvkYxAV3mMK/dc++Lab+IOOU0wy16HlN5mc633otjYpyUvnXMAkVPOhBxRG1Oc5Zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Bj26MB6u60oPRYn3YxcFVRUKyHoLPckGUXFxonyRis=;
 b=wUb45k2hXr7RidOwlhft6iBq40s4unck2QCsaGr6Y8rHpWsnV87FOnRYg2URUgBHQcjJdS3CFr2QvPEQH9vMKDtIEG3JeEuaYIVOe9lCgtV3k1CIWayRjk333lz2OW7ML1XEB0ky/zmMXx77XX7P5r4T68X/XTKdI3CrmRcNygM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.34; Fri, 3 May
 2024 15:48:52 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 15:48:52 +0000
Message-ID: <5681bd76-f01e-491d-982d-2448aaf4f9af@amd.com>
Date: Fri, 3 May 2024 21:18:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/amdgpu: add compute registers in ip dump for
 gfx10
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-4-sunil.khatri@amd.com>
 <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::33) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e7c7b-4e04-4996-1602-08dc6b888825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BrcFFYdVk0V2I4RFp0VjJWM051UlZES1ZsbW1lRld4SXllMGt6eWRCWjlt?=
 =?utf-8?B?bnBPUzNSVUx0OSswaHpRbVlHMkYrTUxtM2dHcjJkdTl5am02ZUVTUFlmVVp1?=
 =?utf-8?B?ZTdtWDFETXhNUkNXNVF1R2lGdTJDcUFUUGdmY0tOSFFXVVQwcEZLWTduRWpo?=
 =?utf-8?B?d3lVVmovYk1Lbkx3ZG1VWFlPRFNNNkc5a0wrMldyZXNwdGhpZjYvRi9WeEJs?=
 =?utf-8?B?WnpJNEpPYk5ya3hYMk1vRzl5NzA2SUU3REtaRWRBd1czYzUxZitzSDE5d0dr?=
 =?utf-8?B?UWp5QS8wNHBldWJ2NkJMME1YYlE4UW0rNm9Ka1JqY1M2dFZXQkEzajV2ays0?=
 =?utf-8?B?c1pNWGkvZE5sR2xSWUxwMzE2RG9MNEt3ZGRqUmRsVE9VeUVsMm12MkZNelR2?=
 =?utf-8?B?UlREaXhNbmNoTGducGgzdVZQVHlybEZKMmczenJHcHBlTDRHRGJPRHNCUDJS?=
 =?utf-8?B?Wk9TV0lSYWgyV2MweC9CcWY3c3NlTGJrdU9UVEpWYUdXMlhjendPUld3aU1s?=
 =?utf-8?B?K1phVDZnWXp6UStxdTMwWGN3dkx4ZytCOWsxaWtjcjFyeEZYQWxpbnFOcjBs?=
 =?utf-8?B?ZmdxMnQ3dlN6MGtJTVJjVStrTU1sTmRCdHdRY01iSzg1SkdEL2swYUU2Zldx?=
 =?utf-8?B?dGVlb3NvdmsvSTZqOUNnSWkxRUcwVDJPeVpqd21aR2dTaWxPeGE5SW1zdmV1?=
 =?utf-8?B?NitKMDBtZkhmTWtRbGVkUC85SERUenFJcys0ZDQ4bWwvT01jSUZYMWptRkF1?=
 =?utf-8?B?YlNQendRSWpYdEwrSDRLeXpEdUVEb1VhSWZGQzNZOWRTMTU5UzJwMllTWTgz?=
 =?utf-8?B?ZHFkUHkxTk1wd053aFJ5UGhobm1zaVNtN2kzTlM1Y1VSVHZPZlZmVlB5V0d5?=
 =?utf-8?B?clhhMCtFMnhjUkk3RHVOWWNMVkEwRzRwVXM4bnZnWVFpbDNPUi9FSVRCLzdm?=
 =?utf-8?B?SlI3NzdhU21hNXNIVFY3NCtiMDRncHpCTHIyR21mUDlMM3pVbTQ1cUdTaHVR?=
 =?utf-8?B?a25nd2RQZEwyUjI1ZzYxOG8zS09Xd1hOTUdVdlZHeWF2bHJvdXJBb2N3RGhM?=
 =?utf-8?B?eVFrUUpmVUZ1aTJ4WGVtcFI1Uk5lUHk4SFVoaldGZkZpcEhjUm5DUkV3TlFB?=
 =?utf-8?B?UDRPMDliTS9FN2lYY0g1T3pvKzdJQUNmY2lKejN6VHFURTkzbURScW01UWg3?=
 =?utf-8?B?UU5FWngvZGlHTlh4OHJiS09sa0FQNGlMSkhybWtEUlZISFVON3hld1cxNVIr?=
 =?utf-8?B?cFRoY0JHRCt4ZHhZT0JHbHo2RHIzdWJzY3AzbkZudC9oekZYYVQ4VGNhRnBv?=
 =?utf-8?B?ZmFYYVdQWE1LZFcrV0EvQVFHbDhkRXFsb2tGbHpQV01od3hPd1lNam9BVEY5?=
 =?utf-8?B?M2d1WUdYUDBsazRNSTBzekprcGF3d1FvZDVlUnhnd2p5clBpbkovazdQSFdI?=
 =?utf-8?B?d2NCSExFNXg5WVp5N0k2dldiSnBYeXY1K2p5V0dyTklYcld0VERhaFlqcUE5?=
 =?utf-8?B?TVFibEVGOUh4Rno3VVFTVDJUbkd1ZnowSEdFQnRxYytYakdTa3JBZkhkelJB?=
 =?utf-8?B?cmVhU2IrV0E0ejNYMU9rdkw1S1NZb3V3MnJOM2d0UUI1aXY4RU1ING0zd1Z3?=
 =?utf-8?B?aHM4OTVVeHVxeUw2OW5ZUjFESisrR09KbDR0aGtUWmV1Mzd5TGViVm5ER0M3?=
 =?utf-8?B?bDJuVjBubGJ3MTFRdk9MWUhDSUFzcTdHRHBtdDlnV0hiSGxVczd5N0FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dndacGlCMm0vSGsvaGlXN3kza2hDMVFlVTQrSDNQTFJHV2FhNXpka1cvRmQ3?=
 =?utf-8?B?N1orNjJFbjIzb1N6bWF5Q2hNVU1HU2dzTDJRMmViaTNQUGpIN2ZhazF5TjRM?=
 =?utf-8?B?WmsrK1NqT0lGQ2R3VmJyWUFxRmZrWnAwZUkxMUEzR0IrMEI1cTkya3dSVVJz?=
 =?utf-8?B?dVpQc3Uxby85VWJPQUg4YWVVUGJzdDJzVjRDaHlTMCtVR09xUG5tZkJ6aEtr?=
 =?utf-8?B?U2NIcnFUNmJ2L1JhbmtCV3c1N3N1TlArOXhRMGdwMGRzeUtIbTAzOFJQMDhO?=
 =?utf-8?B?MjdLSGhjRmZMWis2Y2VMc290SXlDalVxY3o0SzBKQlc4RzE5NnZYS2g0cENx?=
 =?utf-8?B?alhHcjg3cFpVOHJRbDFDckgxNldJMEJvMnNmaUVPbVV4RWNBb3dEL1BJOXJJ?=
 =?utf-8?B?aGF3YzEzWlZSUzVsdG85K3ZpckYvRENWd0RRNUZpS1hUcXI2NXZMOFdBcTVm?=
 =?utf-8?B?M05yOUE1cDFIbW5ZVDJQMkU1MDJGOHBodUZSVXVvdllkQWFyQjArL0VvRGlH?=
 =?utf-8?B?Y3Rydk1KSjdFdzk3ZTIrZzE3WWZjT0diZ0ZHSEhEcjJKMFFuVEVQQmRqLzlr?=
 =?utf-8?B?MFpxM0VvejJGeUV4U0NTallXN0ZRWlZVTS9kRHJsdWJhRDRxdy9XOFBnSGV4?=
 =?utf-8?B?YjlpRnI4ZUdBcHg2bjdvVjQ4aHJCUkNFUnpkNlFVZWtQQkZqT2xDWkF5aVVM?=
 =?utf-8?B?MVJKTW02QlpVVWtqNWVoa2x1QW50MEVBWTlSdTZWZ1FyY2RyWExCcmo1Q2NK?=
 =?utf-8?B?aUs5Q3Y5d0JlV3lZMmJVd21EWHZoRVFtUDEzcTNjNFJyZnRCc3gzQjcxdlI5?=
 =?utf-8?B?NVM1WGVLVldhbjh3ajVIZ3lsUlpjZlBXeU9TOGlCNlFFS0xkZTVTRWpTVUdN?=
 =?utf-8?B?RWdxMVFPSGl2WTlrZExHd1B6T0lTalJFc1hpbVBOMGNWQWp4UDRjMlJDZXlo?=
 =?utf-8?B?dXF6T0xzMitOY3l3WDBPRWxpK2tHYVlzNG5KOU43YnRVK0NoT1JiaHFrVkJY?=
 =?utf-8?B?bVNMR096S2hXSWgvUXZRaUdVYVd0cTlnbFBnQkFwWFErNGJuRmFXLzQyWWVp?=
 =?utf-8?B?OXMxU2I0VXRubDkzS1FUYk9HRHdxVkdTWUZnOXRrMXhmSXJ3MmRHQzl4YW1T?=
 =?utf-8?B?NitvdnVZdXJGOHZldUVEdTYyQzdFNTdNeEZmMGNYMk5RWmU1YjJaQzV5Zkdu?=
 =?utf-8?B?YlRJSCtzMlo4TGp0RzFYYmZMbSt4MmN5S3QvMjYxazNlRmJhYmRDRzBDWjNq?=
 =?utf-8?B?VHc1SlI5VDFvUkc5YnN1SmZPRGNXRjJjQy9XWHB0VVN1SFN0L09EMi91ZW5m?=
 =?utf-8?B?UFBOV09WYXVwUDdZd0lwdThPRjJzUzZlaXFHdm5taHpKZXZGRlA3c3AyTGxZ?=
 =?utf-8?B?MzBBdFJES09VT2R2NktWMXdrcW5uSjdpSWlJUmROaTU2YTgwVUNWZldsU0sv?=
 =?utf-8?B?YlVNM3VQSFZERmxmZTZnVnVsWmZ1MVVBNStObHh6aWJxYUMwNVNCZVV5VnpZ?=
 =?utf-8?B?VGVyWmxDMGI1OWpHbWNwVGNhS2JObG9pMjQxcUZsWUlBUUQwcGRRem9zRnlo?=
 =?utf-8?B?SkV0d2pNOU1LQ3Y0UG9MUy9VOG90cXk5VEdGUDRSYUtmUDF6QVRzSWVnaUZC?=
 =?utf-8?B?SGZIcEFORTkvbnA4a3hlQlZNZDlGUDV6Mk1YU0g1ai80ZldjUU0vQitQYWI2?=
 =?utf-8?B?dHNsNm9QSzZkUlI1Wi9qQjMzbVEwTWpSOWlvcVpXWm9hZHZKMmgxZFFqVWJs?=
 =?utf-8?B?US8wdkVTK2p3bk1JL2k5U1N1b0pzdVd1TEhVamZNbHRYNURVTFlDaVhVRGRT?=
 =?utf-8?B?MGtDZDcrQjBJRXZQbS9xa0RwcHQzOEtwZjJKWVg1Y3dCQk01U3ZSQ3NWczdx?=
 =?utf-8?B?THBRT1ludHExMmt4ZEdIK0QyeHd1ZUV2T01PSTREQ1hrRnBFNE9veEI4aVBa?=
 =?utf-8?B?cW1zOTBBRTlDajdmaStPYWUzUEYvTkRZc0ZGQUVwSlVtZmRQUTNSOGVOK2Rt?=
 =?utf-8?B?R0s2Y2gyNXlOZHJndllGY3VDMndBUU5EclgzOWdqTkpBYzdORE9tcHlEV0RV?=
 =?utf-8?B?cDNqN1RBeGZleFZYSlRrMTFSVGd4Tm5pUmhBLzh6WHRQa3NrMThWM1E3Rm9D?=
 =?utf-8?Q?GBsqFpKrcKJg2asuyCN3IOW1e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e7c7b-4e04-4996-1602-08dc6b888825
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 15:48:52.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHo7k3PbKUdJv7L7Jh0y4+OA+mNj8dclF5v3W7ZYON/+fs3icyKKjacT0vme6TDgocoWeUOWTR3DLpUPGDjL5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991
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


On 5/3/2024 8:52 PM, Alex Deucher wrote:
> On Fri, May 3, 2024 at 4:45 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> add compute registers in set of registers to dump
>> during ip dump for gfx10.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42 +++++++++++++++++++++++++-
>>   1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 953df202953a..00c7a842ea3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -378,7 +378,47 @@ static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] = {
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
>> +       /* compute registers */
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
> The registers in patches 3 and 4 are multi-instance, so we should
> ideally print every instance of them rather than just one.  Use
> nv_grbm_select() to select the pipes and queues.  Make sure to protect
> access using the adev->srbm_mutex mutex.
>
> E.g., for the compute registers (patch 3):
>      mutex_lock(&adev->srbm_mutex);
>          for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
>                  for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
>                         for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
>                   drm_printf("mec %d, pipe %d, queue %d\n", i, j, k);
>                  nv_grbm_select(adev, i, j, k, 0);
>                         for (reg = 0; reg < ARRAY_SIZE(compute_regs); reg++)
>                         drm_printf(...RREG(compute_regs[reg]));
>                      }
>                  }
>      }
>      nv_grbm_select(adev, 0, 0, 0, 0);
>      mutex_unlock(&adev->srbm_mutex);
>
> For gfx registers (patch 4):
>
>      mutex_lock(&adev->srbm_mutex);
>          for (i = 0; i < adev->gfx.me.num_me; ++i) {
>                  for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
>                      for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
>                                drm_printf("me %d, pipe %d, queue %d\n", i, j, k);
>                                  nv_grbm_select(adev, i, j, k, 0);
>                         for (reg = 0; reg < ARRAY_SIZE(gfx_regs); reg++)
>                         drm_printf(...RREG(gfx_regs[reg]));
>              }
>                  }
>          }
>      nv_grbm_select(adev, 0, 0, 0, 0);
>      mutex_unlock(&adev->srbm_mutex);

Thanks for pointing that out and suggesting the sample code of how it 
should be. Will take care of this in next patch set.

Regards

Sunil

>
> Alex
>
>>   };
>>
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>> --
>> 2.34.1
>>
