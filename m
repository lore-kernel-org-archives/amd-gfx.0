Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7A0C83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E92C210E16B;
	Tue,  8 Jul 2025 09:20:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jjaC/c+q";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709F610E16B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 09:20:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfaYE+1bEma5o4TCLPSkef5qdFm7gwU+zmQ7MD6faCjxByxx99V/T0daqFyFNVP76ZeUuW5U/4gGE9x6K7p8MCsf9lkgHzPXYLWoSCApnhcp/3cJr+WuPrz8jjABoNtbX59niEgpCrAxFYiVShQCQ8y9kMPLxGPArGhBNxo9X43q9dnbaoyH5coNclJoAFxKAdxj+3QdnsJi1BMxlONlbxQw1rYm2slsSkP5QDcJnSAdTSWoXWi+NgnFfujxJ0xHffImyiwTaVbKqhjXvCIHetXfQ+F3T7ueWkXHVjcl0004j2SjpIWHzlRvRxFG1t0K39LQWa01bNLHzkSeX3aj6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6X5Ty3WmLn4cFvbVS1TviGbB8wPyp/RcQ9q5QnlBfI=;
 b=mw0iutqqFACQ3yjQDysP4eLPQLotNFO29qL8CP0I+g7SIyQWJUSxt2gdgorU71oNtPxSPfC+gX9wtc6mfacV8UzNspddJwRtNYpG+HGqJabCwWrLGYlJqNXfwsnXkw8rTXEQbKWH7t/UMMOBNm7Pzu07dL6Vc4MvZjk+CKRBtPQC12nrekOu5q37R94hVivF4F825f1/kR2KHU8zXUSD3Xwh709U0+KHdsyJ0/NrIp6zz1TYp91oKTVzKz2CJJGdyQTVd9WgaBEVzn+2rb8lTlnGEly/xKLuJoEvw4druJ0CzsjP6YOLRNMycryoZuavxcTYpJMEk1DzpM9iWRVBcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6X5Ty3WmLn4cFvbVS1TviGbB8wPyp/RcQ9q5QnlBfI=;
 b=jjaC/c+qRayCA9pPxkiyMaI7jDxnx1IT8hlLAsF0MutdiGzgzvT879YBoxXwXoJmYZ5uF7QR06ZM/f0x8zg11jOXYqzvaM3SBMU4S0eGqvmfi531jmTZvKdIazqvVPqxkzo+1OVj48PmG2iaX6eAcj/w3MlwOVzPZqLNTrqmG0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 8 Jul
 2025 09:20:34 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 09:20:34 +0000
Message-ID: <6e319a37-4ed4-48a9-b56c-1ca504daac07@amd.com>
Date: Tue, 8 Jul 2025 11:20:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/36] drm/amdgpu/gfx9: fix kiq locking in KCQ reset
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 sasundar@amd.com
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
 <20250707190355.837891-2-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250707190355.837891-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba7765-5f33-4f6c-8b51-08ddbe00b153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWY5TkkyTzJJT3Nyai9uY3UwR0dCU0cwTzdDVkZHaXJoZTNpWmdqQk5CV2g1?=
 =?utf-8?B?WHpRL0d1ZWZ1NFNpNjhvMDdoUWJONEVCWlpxWjlZSmNyenNVRGxjOTg1ejRq?=
 =?utf-8?B?dUJMdDhqWElMbVNQR1pyNXhNQTF3Z2ozVkdLRmJBVWlhVWVBWjVrUWJkbjZy?=
 =?utf-8?B?aUlGa0hESC9PRTg2WkYwcjY4ci9HWllmNHc4VTMvV1hTU0FmUFJ0T0FUV3Iz?=
 =?utf-8?B?dlRqbjlwNWZyN0psTDRLYzFEWE1zZGp4WE5UNFU5N1VKMTdrc0JDVWJOUmJh?=
 =?utf-8?B?eXRNSGgzSzJxSThZMjQ1ejFVVTB5VzZpZGdpTzlQZDdWTFNMdVZwNkpxdUJn?=
 =?utf-8?B?cGJsZmZ5YXdiWmpIaUhuVGNYYitWNGp6VnpEcjM0WWdrZkhUVVJ2QW8rMHNP?=
 =?utf-8?B?WmRmUDZrME1MeU1EQXRFK0FWY21MdjMrVHRUekVIdndycElpVGdXcTg2RTlV?=
 =?utf-8?B?UXZUcmFtelhiazhiUnROcFV6Z3FXZmtaZE4wcDFOdjlKc1N1Z0VkLzZFdVp4?=
 =?utf-8?B?Y2Z4eHIxcWFaVjdjTkpMUitKdjRZMjlHNXNkMlJMZmFEd1dsaEdYS2xuNU11?=
 =?utf-8?B?bndWU1loalhlSTN6SXBrNCtsUXlmZ21kRnlvVmc4OSs0cUpMbFd6S2N4bmJC?=
 =?utf-8?B?bVlvQVBEaUowaVVwUjRUeFlHZ0laT0dwQTNiakpuYVZyb3J1N2FRdmYvcUU4?=
 =?utf-8?B?aGVnMGpjbWY2VGNKVjNaUlFKWmpEZVRPUWhCZmFDeGdVa2k2Qkd2V3owQ1d4?=
 =?utf-8?B?OXBnbExrV20waHJvZmxrTlNxem94SmNIY2N6Tld1T05nVkIyTXdERVVheTY5?=
 =?utf-8?B?cEpyVG0rYWpNa0lmZFVURXI1TkxacHkvODdMNUhjZlorNVBLdi9tOTZsQXBl?=
 =?utf-8?B?eXVxKzE1VEtzWHF6N3dqcUwrVFBQZVJrLzJaMFdKN0pKMEFBWllVUWZqdVJq?=
 =?utf-8?B?cHYzdERiZFUwMUdrWDhsVFRodjNhOUxLa1FXL3A3UnZvWWFIWGtOK0tuZlRZ?=
 =?utf-8?B?UzU3UTFPTUcxL0dDVmNmbFlJV3BmclBYUG56N2dqNVBQYW9hSzlMYTZtSFhY?=
 =?utf-8?B?S3FCaDNBRkNFZU9HT0R5Q2RtYlBMbjNxV0Nubnp0aXdZT1VGT0ZlVXFsanJC?=
 =?utf-8?B?eEFKWVhFK3NDL0pkQTZ2eDZKK2ZnQ0VpSkVldFhVWWNTV1BvUmp3Nlltc3RN?=
 =?utf-8?B?cVB0Mk1iR2d3ZmNrZXMya1EwK3RJTUpuZ3VYTHpKTytVUHg0bWJjbStLNXJz?=
 =?utf-8?B?OEU0YlVLZ1pJZjh3Ti9HeE1QTzl5WVlrQVQ4aW5XRFdjblhNWGQ4TGNZZFBi?=
 =?utf-8?B?RFlKMDRvanNyWTdMdHkvUUVGdHdZUkJ2Y291QUp4bytXNzZZaVB4OVlDTlZB?=
 =?utf-8?B?Z2dPU01idDFZYnVMVzZyMXNYSk5UYS9xNmRwUzA5ZEVhczl4VnJQOTFmd3Iv?=
 =?utf-8?B?WUp3ZFZMY2Z5WndCdVFUYm9SZnVKRk5oMHdCU3NZZHUxMWlMRDFCajhCTzFs?=
 =?utf-8?B?Qi96SWdpUWsyOHRlMXJaTldpRmVleVJ4a1k0TXNHaWJRbmcxeXQ3OGVCbnBC?=
 =?utf-8?B?RkRvTzR6WlkydHFIN0ZrYmNFTkZYT0hadlhMdzVHTUF4U0ZzTUc2aWJlaVpl?=
 =?utf-8?B?S0ZxQ1BBS2YwSVA0M3NGYTdJOWFqM0xTRW9sZWZTOWNXV2RiRlpXbnIvNmFy?=
 =?utf-8?B?L1pLTWZoRkNkZGtLUnZNQ0lIeS9YZGFpeW1sUG5ZMjRRZVZOR2RkcXdaYXpk?=
 =?utf-8?B?OStxdllKakh3dk5lM2o3WWZtMEdwMXR2KzN2em1Xbk1DTEdiUnlEbmlnV3N0?=
 =?utf-8?B?L2M4YStRMk5FdEQ2OUlWTE0vaFRWYWcyUEZiQkt4d2pKUFZ2K1BTTGREa1Rh?=
 =?utf-8?B?ZmpMUldRbnNFTHF3NXRGZXpWT3FXQTlYUGEzRHU4Ym54dTNoeG5hby9YcExy?=
 =?utf-8?Q?+JISglBsFjw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCszWXNOZFhyQVE1Wm1tVkF2MjNjb1BPanNvT0V3NjNySk9kc0sxaHh4UzlV?=
 =?utf-8?B?Tnd0cDhqZmp0OCt0Z3FMcHJXN0pVRlgzclVHdktDM0J4Qk9kb3lPeVRRYjhn?=
 =?utf-8?B?ajJGRGNnZE0zSjZSNytqZUNJdFhlZTI5SDM3STBKQUpEQTFnK3VabkJUUkFi?=
 =?utf-8?B?bTFBZmFQMlViUGtxR3drQkM5Ym02UWROdEZaZWwvc0EvT0FsZXJWaWVaUzZB?=
 =?utf-8?B?VXlCbEhHK2orcVB2cW1JempZL01uRkNXRFR1VVFZY1BhdkhpZytscFlQaGtn?=
 =?utf-8?B?dk41dk04bnB4bXZCMHpHcGs5QTZWMm1HOUpraXM5YmFFV244V2ozbHllT0o2?=
 =?utf-8?B?L0JBeUxIQ21ua1pwUGZ2UVAzcTJtKzZZNjFvRVJ1MVBFbVE1aVZ4ZTFrcVkz?=
 =?utf-8?B?bmlTckpDZ0IwYTFxVHR0djFHVzVkd2lJdDlhWVU0QU00Mlc2NVo3M1g1QzFD?=
 =?utf-8?B?R05QV052L1hDVysram40UXd3S0dBaVpSQWd6QTQxcS9nU0FkZklWa1BTWndh?=
 =?utf-8?B?dGN0bzR2dHRaaXYwYjN6Kyt5ejNEUXhUQUZuS3N3cVp3Q3ZlSHZ4V1NwaUxO?=
 =?utf-8?B?UFo4dHY1OWVMK2VUU29ld0xENFhQTGIxMFdkUVN2OHBxdmFrUVlIVWdtOS85?=
 =?utf-8?B?Q0tOaFVCOWlBUjB0VzU4K1BtSU1KczM0T20reFROR3dxcERQVmhjWjRrQmcw?=
 =?utf-8?B?NkdyZWVQN0UzOTRBcEhUM0xlWS9CYWlSMmUySk1sTk9zQzJIVk9HakY5eXlT?=
 =?utf-8?B?TXFaUUw5c05Oa042ZytTN2s5UTdRZHJsMkloY0hWN0E2aE1DTlV1UzhGSTFy?=
 =?utf-8?B?dXUyOXhEcXFSRm45QUphWi9SZFluTWx3OUI4eUxvOHdpZ3pPMEJvL01hMUhq?=
 =?utf-8?B?TS9QQ3hPeDVrK2J2TUlEMXVVT0JMNDhxMnh4YzFnZ1VSbXhuT1RFaVltQUVl?=
 =?utf-8?B?cml1WW11U2lObkdXSnliNmZ1Vkx3UGZNMXFybXZ2TVNGOUxBYnFGcTdPbkxi?=
 =?utf-8?B?N1ovazdhYnZ0SWdaMFRTTi9SdXgzbXB1ZGZzcmxuU1BTaDVKaTkvQ2dFU1I4?=
 =?utf-8?B?WE5oZmVvZENPaERXLzU2cS8vdE5SYWlOQ0cvZVM5eDR4TlRMQzBkR3BGSUFY?=
 =?utf-8?B?S3JsQ1g5YlByem4yendidjdaY3VrRkJxQTUweS9LMWQrOS9vWEFSZzVlMFRx?=
 =?utf-8?B?a2txbGtacmhlYVBNMEJoWFUxRkg0a0FNNG0rUHF2d3BxU3ZVUjg5NzBHNzNp?=
 =?utf-8?B?dlRqWVZrOUxlcmgrbXlnZ29HZ094YjJhRDNlUDNVMHNDL2tNcVJtVkFuZHpI?=
 =?utf-8?B?Q3lCa201cDBSNy9oTlJ2aTBNalZQMWNWMDJOUkt2OTRzMEJLUmEyRm5CY1dU?=
 =?utf-8?B?WTdZRTQ3YVc4VzZEYmowUDJqVy9TMWczU3NEYnE0S2kwblRWQk9POVRMbms3?=
 =?utf-8?B?bmRUcnJSczQ4dEtDRkxGV1ZmMGlqTUUxMFNiTWhZV2laVU1uMGNIVDNpMnJo?=
 =?utf-8?B?KzZLTHdTSTlZN29lQXZaNUN0Ynp4d3EzUkVlT3EvVnVYQVFHNDZSSEFOb0Q3?=
 =?utf-8?B?VGZ2Z3FGZ1lsVTVSaU5rNUs1YWFHTnp3Q0JXRkcyWXY5WG5EdWpyS09Eanp5?=
 =?utf-8?B?M3RkcXcxL0puQnF5bVh5VS9NaEZRbm1DUVkyVy9iQlMwTnpkRkpBQjB4OHBG?=
 =?utf-8?B?V1NDenZwbkk5VXhwbUFja3l0SU02WkEwbGtuMkl5NTBlS2FmWHVURkNDZGhn?=
 =?utf-8?B?a2dwdmxrWjh1am1tK3JKTmhZZzRnTUJDaW4zUlFjeWJKczI1RE9LeXhIRGIy?=
 =?utf-8?B?YVY1ZjFrbVlUNGJzY1NXUmd6VHBjUnRTZkZlTXZ6OTQrVllWVjhzNkdRT0tm?=
 =?utf-8?B?bnk5Nkk4aURYQkFXZ2hsc3hpK28wWUdoSjVTYzF1YndLWFZRTVFNRDRqOThy?=
 =?utf-8?B?cVpvVmgvcEJ3WU9TK05hLzBCV01YdldEa3Naa1hxSkFVbU1WeCt5L2ZWWVdV?=
 =?utf-8?B?SUZ0MUhLS3RSOFNpUThyNk1ncVZKK01JdWdRU21veXFrYit1QndMMEZzc0VO?=
 =?utf-8?B?ZTJscTdXbXNPb0d4Q3lSbXFzVUxTTzN0NnZEWUZqSVVnNHdqelhBNkRmLzBo?=
 =?utf-8?Q?9rXsascrSywqVzS4dzgMwcECD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba7765-5f33-4f6c-8b51-08ddbe00b153
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:20:34.3395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRLu3/X62Nyov97JBhfQsOZw39nwKZtBQXumORwCqR9xlqEAdSuGoFCaG82zJfb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
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

Patches #1-#3 are Reviewed-by: Christian König <christian.koenig@amd.com>

I need to wrap my head around the SDMA stuff, but at the moment won't have time for that. Would be really good if somebody else could take a look at that as well.

Regards,
Christian.

On 07.07.25 21:03, Alex Deucher wrote:
> The ring test needs to be inside the lock.
> 
> Fixes: fdbd69486b46 ("drm/amdgpu/gfx9: wait for reset done before remap")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 76ba664efecb3..4c61157405b07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7238,8 +7238,8 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
>  	}
>  	kiq->pmf->kiq_map_queues(kiq_ring, ring);
>  	amdgpu_ring_commit(kiq_ring);
> -	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	r = amdgpu_ring_test_ring(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
>  	if (r) {
>  		DRM_ERROR("fail to remap queue\n");
>  		return r;

