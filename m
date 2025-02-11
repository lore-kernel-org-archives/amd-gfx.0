Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FDC0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93AAE10E27F;
	Tue, 11 Feb 2025 08:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XUSQ7Z6y";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC2F110E27F
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T360I0lX/IgI4G0DM81t/Boc4dcAFQ0TIoMb8UTzbn3WjaQwC+bwLlJFiPXRACLpusU8QiEUYv3rsbluh63iQ014x9/ORbhC0X+Z5ecywLw7cgtlBx8a6I0YwqIEOOQN5pnTufpa2GnYTWY+Xpkch3WxrHG4y3JRpuazUJowd5RMc34InuetrqJ+4fvcpo7mauIArL2L1Yd9bvfTbiKx3D/YjfEEikKY/6OQvkoTVijyMG8UmCabw1oOYpqmEB1e7UE2FRzyNeAr9jjp4eAihjd6hnJRGSA9OJY6MMTuw61iVYpb6lSFEZW7lAZ2BmvUKIgKG6fP5OFMINUJVqFZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzw/M8gU4hE3FV82b5wlnmz9iZltvAToq++3uaHwL6w=;
 b=YLuF7hAry1DFqCOzar7savRddwC5IIBUMzKAw8PBpuTZdg3dOqs4KcnW6jIx84iJ0T9mmQhDvnUZvi6LehncagCErVx9A0phKC7QXEuE7da74RfKsCKXzYF6whafWJ/42LQ27511WRwpbka4JaS5IlgUqg7+wAkjq1oqHc4iycZBoIm6hzJBps6QglAJaoe8PRP7XUFvAnJAQZYLZSjcRgUiVRVXdRwT4SDGA2k9uEJYGbdv+LBbtJz5cKauzNOq2SxQw2ZQIBd51Op/lVs5mDOgQ/0yrJk5LadS/M7FSTFNfAXMmSkriuuQchjqdQwX/lUwxEq/ZfU9FifXqaRtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzw/M8gU4hE3FV82b5wlnmz9iZltvAToq++3uaHwL6w=;
 b=XUSQ7Z6ysQdOBT0Erqz7QcqxyAeoulSW4Jv0p/lm75gNNSmR/iS+q9k1nCGF/Djh6mTGl/zAzLo6kq4ysr+OWA2lfidMlKc5D0nNI+Ch4OzpwCbo2BC9B2ns9Ym73KT3lIYDHJBma/kUEvdwbjkERs4vYU1NKy1lKtczSTAREwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5646.namprd12.prod.outlook.com (2603:10b6:510:143::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 08:14:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:14:04 +0000
Message-ID: <cdd99015-39e4-4a74-8449-69d513edfa18@amd.com>
Date: Tue, 11 Feb 2025 09:14:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Modify the seq64 VM cache policy
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250211061029.3505-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250211061029.3505-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c09d1e0-10fb-4bec-1ed7-08dd4a740c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWlkSGZUeXNIekZUaDFYLytWajJwc3ZQTWNHcGd3NzNpTFFDWW05T1BXK0cw?=
 =?utf-8?B?Lzhnbjl0SkpiRlNoY0JXVzFUZ0ZIZ0NWVGZ3VzJVd1pDWm1SK2hmSmV5RjNy?=
 =?utf-8?B?bjkyUmE5ZmdJbTM5b1pLSWJJWmIveGI5MncyZ1Jhdk1XTVlDK0hQcGxHUWhq?=
 =?utf-8?B?V3pQRWowT3lRNkZRSXV5L2wxU0dwWTlkRUpjMTBjY09pclpMdFBhaFhadlkv?=
 =?utf-8?B?RjJxZnZYT08rdGtpbjNacFRPeUFNMWNjZC9sRC9weU5aUS8xUWl2S3pPL3NB?=
 =?utf-8?B?cWk2b3NQell4VFk5MjA5UEZ5bHRuR05hNVo1OENpSFNaNDNpNzBDVU5ETkd3?=
 =?utf-8?B?bE1iZWg2WHJGL0owUmtvdkZHMm9aejlERmd1K3RLbWhWVTUwV2lwVmFMNmI2?=
 =?utf-8?B?QkRCMW4ydXNKUEk3QjJFVktJVnhVQ2hiUnY0SzB3RVVHZnkzNzVGUGt5Zlo4?=
 =?utf-8?B?NTJrdU9XTGVaRERUaDNIbnROelRiL2p5MVZDVFFHNlhUdERqaVd0ZkszVUdt?=
 =?utf-8?B?SFl1VjVOblBkLy9RcitQb2dwSURoY0l1OTFHN1BiNDlGNHhBZ2MvRy9DUW1L?=
 =?utf-8?B?Z3JhTVZnMG0xeVdMb1V2NTV1SXlqWDVFdjRsa0ZnblpXOGZNSjZqQTI0ZVln?=
 =?utf-8?B?akRrR3c3Z0FSSWV4ZUIyWXdDdTlQbkQxY0ptMWZTRTdXTDVqZXlPRmdnOURE?=
 =?utf-8?B?aXdPaTRjeE1udHM0SmpXcW5TMXkyamVUQk94ZTQwUS9hTEwza3dNMm1mNEhH?=
 =?utf-8?B?R0VtYTRDVkFlRmk0cm85TUV4Smh5ME1VblMwc0k0cUxGWHhvTVFZaTZxSjFS?=
 =?utf-8?B?ODhLL21iRFcwaVpZRWhXeXJ3SXA2dWJJUHFETEtnT2xnZTEwNlFZVzh4Nkxs?=
 =?utf-8?B?Q1ZtUEZTeW4xVVoyVXo0TkdZQTVHLzF5dmlkYTRQU2hZbEJSV2ttYkx6NXFh?=
 =?utf-8?B?WE1tYkh4MjFselYxbUVLS0hwL2YwRlVDWGpCbTlaNWNibkVaUzgrVU5ISWdL?=
 =?utf-8?B?QklIUkdFWngxb1hJS3FGdisrRDdEUkFNV0V3OENhdTU5MElWVUVPZFh2eVRm?=
 =?utf-8?B?bEhBRHJkM0tEa2lYaTRETXR3cmk5eTk1bXVLWjdWUkF4NzZNSXMvMS9tKzhk?=
 =?utf-8?B?M0lRdkhiY1hhTXA5WXhrcVBIeXdDZE1vTjZWNW9vZ2RBY2Zva1JySHhFaUw3?=
 =?utf-8?B?NmRzRUpnVXJhZmljOW92MUhCMHZoSFp2aTBkK2VvQnFGLzVCWG1RU3pwUks2?=
 =?utf-8?B?d1hSRVh5K0Nxc3lKMEtMTkd6UGVLMW40QjhmLzVxUkYyMDdTb2pNMy9KKzB2?=
 =?utf-8?B?UHBPRlJLVzc2aTlmSlNQcGpnM043OFU2ZWluN2ozT24rRmJwczdCOWtjWE1j?=
 =?utf-8?B?ZEQxYW9iL1p0M2RhaHFsSUJnekU4K3dBRmNPWkhDang5WWU5c0ROcDNGQTVR?=
 =?utf-8?B?Mng0d1JmNGxNRHk1eTAvMEFxbDhMZC9YY0Vtdmt0d0hRZUZoSVdHZW8zcGFP?=
 =?utf-8?B?OVBGVkFQb0l1aFRUa2tVM0padzJ1TWRuMVRuWFFzSXdQeFBQQ2lGeUpRWFdq?=
 =?utf-8?B?RFh1eGtDYm5zMjBYTG1LVktITWpsbnFEcm5BeThmODF4MEJwV2NSUGE1VEhu?=
 =?utf-8?B?SHIxM1R0eCtpZUhpWUVRaDh2aFNMajBGWFB2ZEJiV1dLckxYcFF2S1AvemMx?=
 =?utf-8?B?QVA3Rm0rdm50TmcvcXNucTAxY1R3ZUwrVlVKM1ZJTVluTWl3eG5mQWJycjR6?=
 =?utf-8?B?Sm5rTlZEdEpkNm9vMWVOY3hKTWdIc3FlbUpNTjFnck56QjArVkJ5VXRZemxI?=
 =?utf-8?B?VHJFKzY1NGt5M01JdlRtR0tLOU81d3lsT1Z2UHdHeVZRNm13ZUhVM1Z4UEh3?=
 =?utf-8?Q?7DOHjdB9nA3Ou?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGpZeDI4Wk1SbXY4ZFp4OWRnM3pXQWFpWnFrN2ViOWFmejl3cFZnUEg1L1hZ?=
 =?utf-8?B?RjZPSHBINzZ3V2NIK0hsNnlCeEIrVGRPNUtXMFZqRkZ4Uk9lME5MMGpnZjFS?=
 =?utf-8?B?M0ViWmhoN0QrWFRhc3Y3MjFITk1MaE41S1dkdWFCYmhlc015amIyeGU0a244?=
 =?utf-8?B?Z2pJc285YTlKNVd0ci9sUWsvZ0tmdVIraE1kcW9rZkk0TTgwV1VaSmV1RWFJ?=
 =?utf-8?B?ZTkvTE5xU0xMeEZMWldUbDNGRU40MGE2VkV4NHorOHBBUmg1djRtZG9SZ29W?=
 =?utf-8?B?MzNUM09uT1NWL1Z4eHpEVGdSS0d0dE02TXN1WFlRVVlueU5OaXRCZjhRR3B0?=
 =?utf-8?B?UThpdlpCVmNyM3g4anNhVlZQUE9EUHZjSXZBR2h6dDBVdDBBQnUxQlhHSStp?=
 =?utf-8?B?d3dySWk2WlgyMEtqZUtFRUpnZGZZWGwwRkpHSExZYXlMbHBkNXpHVnVoNFNS?=
 =?utf-8?B?cFFTTzFsY3BBMHVkN2hrSXZFSUVyTFVIemhJaENnNG4zRlRrMVhpYXpvdzd3?=
 =?utf-8?B?elRlSWRuZ0xkK0Z1OVJNR3o1czRodzZ4bGJ6S2J6UHl5aExTbDJoSGEvZ1lT?=
 =?utf-8?B?NjFpd29aSWdjbFgrZnZzSXR0aHdrdS82aHQzMkc2cUwrakp1UDFocmFyUjFo?=
 =?utf-8?B?MnlBcFZoS1pKK21haEtaVDVXMmJnN0t0MENuZFFMVUdIVDZrUXB0VlpLUWxk?=
 =?utf-8?B?eFBiREEwV1hNdXpNdHpsalVGRUlmZ3RQeTdsMHRkNnBscDJtOGZSRzNaQzZr?=
 =?utf-8?B?MXZNZVpiN1VqQXZPa215QVZaSGg1UDBNck9QdmdZVDZWTU1iYnJPdkVhUS8r?=
 =?utf-8?B?NXpyVm93Z09jTkVJUFQralBSdmQrNHhCTTRIQ1piNUd1Q0NQVW9lMTk0cGo5?=
 =?utf-8?B?V2E0eTJhTkVjeTZjSmprMkY1d09FVk5ZSVR5Q3IwZUtFeVBYKzdBcTdjSDRh?=
 =?utf-8?B?MjVnbW1sbVFSdndtVSsxd2dvSnZHaGhqaEYwR3NINUgyTGJWMC9GZzB0ZFlH?=
 =?utf-8?B?NWtRSERRTkd2NVA5R2IxY24wemh4ZG5tQ3MyekJIYThWaVc4WXVQT0lPeVI5?=
 =?utf-8?B?cmQ2SGVWOUEvZlR4UktRZW5SVjlGeVNiTGlWZTljSUtwQU1HNUw0TUt4ZWtR?=
 =?utf-8?B?TVVRT3pSVjQyaytmS3hOdXExNHEyc1VEV01yemhGTlkzbGt2cG1zVjRuWXJk?=
 =?utf-8?B?Y3RMMkdnRDJoQitCUXcrN05nWjduYi9XNjduVG9VTE8vNUU2dmxBa3UyclZU?=
 =?utf-8?B?RmdEdTJhWk42TkdkQlFtbkEvdytxVW13ZEtwTktKNEViWUV0Y2MwdVNCR0F0?=
 =?utf-8?B?WS9qL3pJTmFlSi9sRWJUNGwzZ2trK2hKNXRvaWVPcGtMNTdvWUFuSlkzVm1h?=
 =?utf-8?B?UXVDSWZ6aW5UdkNzcjZuL3hDbStqOUdaNVU2VTBuOW03TGRpOFZ3ci9oVjQx?=
 =?utf-8?B?blZ4MWRLbFZXVGt2am44L2YvcTZQOHpwZklUdG9NMXJFUVQ5YVdheTgyc09P?=
 =?utf-8?B?dGZwYWp0dXJSUzNhMmFBRG83K3NKQWZScXFPRWNLcVZpY29mcGVlLzh2eHZn?=
 =?utf-8?B?WU9TM09qSkxGUzVPbzdnYXdUcCsrSGYwa3c2VzBua2hBblhUeURpOG1iallj?=
 =?utf-8?B?WlBGczdFclZpWVh2elJ4NHJ0dGh2VStNT3JXMDkyS2dqL01CNktoa2FKdklF?=
 =?utf-8?B?UHBMRVc0VTdFK1IzYXQ5WU5sRVlLbXdqcjRjT3Z6dlVONGF4UUdUTkMrTmhE?=
 =?utf-8?B?WExOcWg5bURybkFCRk9tMmFJc3A0YlNweTI2NmJicDF0SWhXcWViRmtCOGV2?=
 =?utf-8?B?U1JMUGdKTXo5MzE1NFVvTkp2bXB4Qkl1cklOZEtQMFgrVVR4QklIb1piSU0z?=
 =?utf-8?B?SXI3dFNEUEloMHh2VGdQc2xyNkxRVVAxWUxlOEhsOW4ybGlPZWxOU0Z5S2lv?=
 =?utf-8?B?ZG9IZTdxTmxrck40cGRtOVJmdzZ5OE4yOTVvaDlZMi9mSFB0c2JUbjhvdkZW?=
 =?utf-8?B?ZTVWZGpYdjk0RkZZKzBPaDNveitDaVY1dWhOM3MvaXgwN2kzSXF1Z0ZZRWt6?=
 =?utf-8?B?bWhQRlVmUE5mNENrdDdZSDlxZ0dJV0FxTG1OYUx2UDBpOUp3YmkvdlJPTjBa?=
 =?utf-8?Q?Dp2JwLG13MbH9WIkv4HzVb6eu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c09d1e0-10fb-4bec-1ed7-08dd4a740c7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:14:04.5072 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZhWPNBlLMIOWhBCV3E4JHWLPRVz+tbHSsmFrx/cs7ss9kN1iuhbzZPwXUMEH7OG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5646
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

Am 11.02.25 um 07:10 schrieb Arunpravin Paneer Selvam:
> The seq64 VM cache policy should be set to UC (Uncached) to
> match with userqueue fence address kernel mapped memory's
> cache settings.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 2de1a844282e..3939761be31c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -67,9 +67,9 @@ static inline u64 amdgpu_seq64_get_va_base(struct amdgpu_device *adev)
>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		     struct amdgpu_bo_va **bo_va)
>   {
> +	u64 seq64_addr, va_flags;
>   	struct amdgpu_bo *bo;
>   	struct drm_exec exec;
> -	u64 seq64_addr;
>   	int r;
>   
>   	bo = adev->seq64.sbo;
> @@ -93,8 +93,10 @@ int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	seq64_addr = amdgpu_seq64_get_va_base(adev) & AMDGPU_GMC_HOLE_MASK;
> +
> +	va_flags = amdgpu_gem_va_map_flags(adev, AMDGPU_VM_PAGE_READABLE | AMDGPU_VM_MTYPE_UC);
>   	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, AMDGPU_VA_RESERVED_SEQ64_SIZE,
> -			     AMDGPU_PTE_READABLE);
> +			     va_flags);
>   	if (r) {
>   		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
>   		amdgpu_vm_bo_del(adev, *bo_va);

