Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D639D10DCF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 09:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D376210E691;
	Mon,  2 Dec 2024 09:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QSxyAAds";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92C510E691
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 09:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC5IDjoe81SQlloyWa2nlHeck7yAgozDbmMNJp7aHwQ+SKnxY5yPuqlxusjgIbXsAZV6HEOBvSy6Xwl8Vngjywq/r9kA/BY5Tw5kegT5xpoPUuNoho0xjjsOcX0+efkN9TTurQl4f+khBoncRd8gzBFX037ZCXQjP5ehiwX69J/979gpkHb8I+lsDv+2KQCtktbrqVxywJIKjv6F8mzQOj5Ad09XU29K/ZHxcFUQh7NV+dNlIDH7OSqgijwzveYGebsLC9Pz9cm7ngpnDnuw/spBON8VbLbqdmFXu73VmORt29qW2pU6M7SPGPS1imu+fAXvkTf1bl9u+9FUtPlGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo2yBmtFrVOo8ku/VaPB1EZW+UG4OCLk0y//YJlOegA=;
 b=eq7uqdi8JEI5fgHTGmvnpA6RpNlNUQfR5o2OrEV7101FktzBaPqZg8X2rI82KQB606z85xaa6MvUKvEQlpdlc2tfuJWqC/LR4HOb3t3H1A9M69gbdZC9MOVtc0re1ikhxViQTPQsuNT6QAxMkRRkRavmE2+QTFPZ5z/uC/XpsLIw4BBuP7y/4SMo9k1q26WATovzhwZDTZE9GqxtYt+7r/ygyH2i9aPhhAgrTzceXNRxmi/V0RQFwZh0vF4ChOJsmlguQxT/8/vSMRhVaOxAiCi/xftBe2mixIwzw8RW8jB6LQ0fJj5DLM08mtNatR4Dq8BiyehfZ2saPqH/1111Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jo2yBmtFrVOo8ku/VaPB1EZW+UG4OCLk0y//YJlOegA=;
 b=QSxyAAdsxNYrJC/jTQzQfqTsci6ksKWWa8CDNMW9WLMBUG0MoppS4FF+MuHxJGKbNS+udJ+984yh5WEJH5teTtUJ+VXDK3/71lnGWBL+So6UgLGyRs0JbQku/NAptgp7242aav25RIL3A87OLegvkGJKOcTarkgoYhlRlgJbqP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Mon, 2 Dec
 2024 09:42:18 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 09:42:18 +0000
Message-ID: <e5f04914-1e73-43ea-bdd1-7cd7e6a61853@amd.com>
Date: Mon, 2 Dec 2024 15:12:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix UVD contiguous CS mapping problem
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20241129150855.2187-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <20241129150855.2187-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fca166f-5e1d-4ffd-d73b-08dd12b59c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXFNSTZDL09IbUNVVUpwTzZOcGVJYlJ1amJoeGNHdzFzMzNMSWN3M1RnaFd5?=
 =?utf-8?B?V0p5cXNwQXVkRjJXanU5UjhHR0swRDk1Z1NDZ2Y2OHA5eFFOMjNvUlhZb281?=
 =?utf-8?B?SXUyaTV4NXM2d3JoRjlPOHpleTRacUNBeVNWZVBBVE5hNlUxMWgxQ0gzOWdE?=
 =?utf-8?B?MTRndmZUM1R6V3JQczZFYnFqOXJQS09zNzRCRytPRWZmeFd2Sy8vNVNlcHZW?=
 =?utf-8?B?MEVLeERRQzRtdlUzQmNBRC9mVFI4NkpXUm1wSWZkNnhYV3pFaVoxUnlqYXpt?=
 =?utf-8?B?YlpOZUxGUlh6SmlQWXNsU00wbE9qUVlISG1VWEExZ01wYWVaenhpVUIraTZB?=
 =?utf-8?B?bWd3VmZ5aTFnUW15R2pQT3M0czdvU1llRktVa20vOWNXd0RHZHZ4VnJ2MkJt?=
 =?utf-8?B?aGk2TEplSSs4UWgrNUVJSEYzNUNObEgzRnlIaGpETTJMbTE4V1cvS1JndDhi?=
 =?utf-8?B?M29rZGFCNzExR1oySVhmTDlWNlVTNG5GNW5Ua3RoenhhRGI5MEQ4cnlBWXFK?=
 =?utf-8?B?dHZLOE1ZaXJJT3lGMi9TQ3hwUnJKSUVvNG5KTjRrOW5hUDZ1cTI2b3dKN1pP?=
 =?utf-8?B?SUR4WVlMMmFNT1p6RnJpT3loWWg2MS9UQndSa3dJQVYrRXhFNldjSEh3bGhK?=
 =?utf-8?B?S3BpanpwWHlOM1pjY1ptZEt4OE55MWFDekRCUFVzd2FOWEo0clR4RXp0REJM?=
 =?utf-8?B?YStOUVpZWk9hY2dweDdQZzlYTVljS0dYSUZ1UWlNaEtrRUlXOTg2NUhzSXFK?=
 =?utf-8?B?VTQvSVB5cXhtTlVVOXVnMm9DclZaYkJndG0zQ05adys0aFNDdk0wNm42bDdQ?=
 =?utf-8?B?cDV4STRGNWZDTDdKQWdxRlcvd1NzdUFGRVlvVGVMcCt4ampUc296OTZ4RGU0?=
 =?utf-8?B?M2ZIOHhwVnViMkliM0VJWHN0SmIxY2JHRlFKVjNaOXZhT05BOHJ4NHlybXBl?=
 =?utf-8?B?akRiYzJKNkdVcDA2TlZJaTJUOXh3bTdIaXVtVUc1Z0Nabmw3L3hJMU42bXF5?=
 =?utf-8?B?N3kvdm9VR0lQMXZha1VGcW44TTBBRXRJT0txdENGNWszM1ZaRkVUUjFjK1VP?=
 =?utf-8?B?bEd3MFZEaDBpVDhocEhwZTlOdjArQjdEWjdWMjlEYm1tWkxnUi9MRzF4RTIw?=
 =?utf-8?B?TTFVb3IzTmJHYmRzSE53NGZsZFV4U2JnQjRMZHlEa09nd0poTkVCOHFrNkJt?=
 =?utf-8?B?eFBsdWRqRFkxQ1lveTRKRUdlSmdQcVlMNXVTQWQ4THlRb0kvWkZDRysyMnY4?=
 =?utf-8?B?a1k2RnJlUUhsSHQwZk5YK0Yva2RxRmdYeGpvaU5ydjkzTGt0UzZFNWdEN3hB?=
 =?utf-8?B?dGVxcUROSzBZK25wRUlqSWN0eXJ0clZEZGxUbWUyNkU2OWx3YjFXK3VySGRR?=
 =?utf-8?B?cVJpUHNINFU0dVk2RE5aZG5icVBuOCt3MEQrSDQwYXk5M0k4Q3owRGttUThX?=
 =?utf-8?B?WERMS2RNYVZnUlFSeGJwbFE2dndmZ0l5N3d1TDdoN25Iay8wVGtOUUZQZmZQ?=
 =?utf-8?B?RTd5NE9BcXJCVm5nMkNVb2hrYlhHanZKbGJyanJrSDRMeVVDRE9hL1lGWUtP?=
 =?utf-8?B?RVpQMlptQmhDN3FUc0NhYzlZV3paUVcrRzF5R25FY0lFUXBNWkFQZWw5UTBi?=
 =?utf-8?B?M1dxZlFaNnJJVmYycWVwNmVLQU9nckNmVnhqRWVIV0w1WjFCa3lvZG0wTFQ0?=
 =?utf-8?B?SlNuR0lQRW1iS25ySjlzMG8zenhuVDhMQjcxM0FMdlRaNlVMZ1B0OTIwQXJ6?=
 =?utf-8?Q?1pOn9w4c3YCvcpDeUU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWI4bkVPRHhRdzdRRTNjVm5lejM0VmhYdHVwRlFtTDluK3p0Zk1qR3R5UCtK?=
 =?utf-8?B?R21LZWFkT1puVmlrUmFpVk9RNWY0aDk4VUFndFVQWFhhN0NsTWxhUFpLRVp5?=
 =?utf-8?B?cEtNeXNtOHU4SUNPL3R3V0NpSlBhQmpFUGJsU2lIaXhsa2tOWGxCUm9XM3Iz?=
 =?utf-8?B?d0M0aWppcnZqYi80ZkRaTFhlY0U3NVNNNDY3UjJBWlFOMWpXZVgzdmREcDZX?=
 =?utf-8?B?blcvYjZuem12amFRRm5wTzNsRFZud2w1VTBod3FFM3dZWVcyaEYxc0ViVGZT?=
 =?utf-8?B?NVdsNE5uZGJZaUJ1N3Ayb3lHK0x1RCtNQlMwenl6Nnhxd0lKUnM0bkFyTjBo?=
 =?utf-8?B?dmlLZkcrSHBveEdSdWw4V2xvbkx4amtBb1czZmR5UGtoQUxMWEFhK3lzR3pJ?=
 =?utf-8?B?SmJvRHhtbU5EY1VjUEw5cmVodW9wb0wvU0d6enpxMVlWaVNYeDFCcVdUNXo2?=
 =?utf-8?B?VXJkRTVld09Ya3FqSkg5cmpWSmFUbGx4TjFsU0N3UjBGdmt6VGFYNnliR2VW?=
 =?utf-8?B?S2JlZDhTWkJrblRRY3dlUGppY21YOThkSXZjOXoxZFdyMjRTQjNHTzJuWXZR?=
 =?utf-8?B?NzQwaWp4SEtRVVY4L2duMDczcTNDR2tEbU9Vam11dlNXUzZZSzVpbjQxd2N6?=
 =?utf-8?B?M3QvTUgrUnBDbTY2MTNZMmloME5SMWZIRVllUUxIYjhHMVNaQTZFNEhTdzJy?=
 =?utf-8?B?QXFZaWVPMHdSWkJ3Tkg1YndpNCtnelVYQ2g0Wk81SGp4ZkRJcjY2SFZ1eE9m?=
 =?utf-8?B?QWF4dHpZaVFoSkxIeU9BU1VpS01Eck5LZnYyM2dUbnF5cXBlSTViTEw5Nmo1?=
 =?utf-8?B?OUVMczdHL2NTTldIU3d4NGh0T1dpNjcwdVExbDMzajUzY2VETzBmSW0rSWtD?=
 =?utf-8?B?TWprK1ZuMlZWRkcvSjJESDRVUjZEN1F2UC92eFptMzZzTkNQRXB5Ump6Yldy?=
 =?utf-8?B?Z0ZVY1dFWklwTUkvNk1HVU10K1FXMzNvMzRYK3hnb0JXK1ZSTVFRRzl3bjN0?=
 =?utf-8?B?aFFXYlY4MGM5MGYyS3VScmJ5TTF1dVZtc1orWmtuVTlFUnl6Mmw2SFRwaCtZ?=
 =?utf-8?B?cThlczZtN1UrVUxuUGEwVkZpWVNXQnpRdEs4eFh3Y0s1UDl5NklrVmJWK0xa?=
 =?utf-8?B?LzRPcXFvU1A0UFhMMHY0STc2eFdvR2hzcmZLK3NnUzJ1T3dlVXFMNytoOHZK?=
 =?utf-8?B?SVNHdGNEKzBsZWZ0RXZGS1lBb3pRaldMZS9DaVFmemVlc0cxcTllL2RpTDdD?=
 =?utf-8?B?dmx6dUdyZzlscEh1bUU5aGxnR1A1b2xYcWo2cnQ5VEdSbmlVSDZLdEVSaVFG?=
 =?utf-8?B?U29FR2hJV09sN21KVk01WXJNTzMvMklxL2g2Q3ZtLzV3V0dZclVuNmQ4WHBl?=
 =?utf-8?B?dWRrVUU4clM4Zjk3Y3pIWjBoeXFnVjh1bXh5RmVwRmwrczliNXp4OGIvVHkr?=
 =?utf-8?B?ZkNzNkdlRVFadXozV0Z3Rk95WmFoL1E3ZGVLMnlyamZqU3lKQlRSN3llUlM1?=
 =?utf-8?B?cThudzg1K1I1QUVKekczeE5LL1l4WmxtVjIvMTNoaVdOaXZ2dXdSRDNWdkNm?=
 =?utf-8?B?VE5NOFZML2ttak9yVW9kcnFRL2NHRmE0V0ZGOUQxNlRqSzBPNk1OSXhQamJW?=
 =?utf-8?B?VFlUVGhzQW91VmFwTG5aT1VaeFdldXhiVlZYM21wcG1Kam82NUgwV0d0VXJy?=
 =?utf-8?B?MnJIamtlemlEK0dTanMxQUdVREZUT1dYMTN2bnhiWVgwSjd3c0xadHRoVEhq?=
 =?utf-8?B?NEhkWGNlcWRPUVp6RDdmbDZLNVZtd1daZ0F4UHUraldlelBjK005TUdpT0pw?=
 =?utf-8?B?MUxMNmh3ZU9LUHhUejFuNEl5V2NNNjB2cm1jdHEyQnFxVm5mUUZncWZ3M05L?=
 =?utf-8?B?YkovVTFSL3ZEek5iemE3NjNVdUNFcml1RlpqU0MxVytRN1lucTNaSndSeTc5?=
 =?utf-8?B?Z2VxSllxTG9va2VBSFNySHdYaHpzelBMeDJTWm9VU2xtc04vd0JuNHhpYm8y?=
 =?utf-8?B?UVlERGZaT2lvVWFRdVhMTmhtV0haOVZac3crUVE5blZaejVabk1lVGxxTk9N?=
 =?utf-8?B?dUVwd3BHdHJ6MXI5UkQzUlBnS2J0aXJTVzU0dDhHQ0NhdHY1RnQveFhBVmJ5?=
 =?utf-8?Q?H3z6nmqtw6Qfx13ad0/uBdBHY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca166f-5e1d-4ffd-d73b-08dd12b59c8b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 09:42:18.4611 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70Oj2w4TIcJ69wLccJ1UVqxuh28zz8TDuHe4X6YgNEEigKlzJUh6lw1podWgUCIJGOb4Neq+JNXGmJDIr14F8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
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

Hi Christian,

Thank you.
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Regards,
Arun.
On 11/29/2024 8:38 PM, Christian König wrote:
> When starting the mpv player, Radeon R9 users are observing
> the below error in dmesg.
>
> [drm:amdgpu_uvd_cs_pass2 [amdgpu]]
> *ERROR* msg/fb buffer ff00f7c000-ff00f7e000 out of 256MB segment!
>
> The patch tries to set the TTM_PL_FLAG_CONTIGUOUS for both user
> flag(AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) set and not set cases.
>
> v2: Make the TTM_PL_FLAG_CONTIGUOUS mandatory for user BO's.
> v3: revert back to v1, but fix the check instead (chk).
>
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3599
> Closes:https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  | 17 +++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |  2 ++
>   2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d891ab779ca7..5df21529b3b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1801,13 +1801,18 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>   	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
>   		return -EINVAL;
>   
> +	/* Make sure VRAM is allocated contigiously */
>   	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> -	for (i = 0; i < (*bo)->placement.num_placement; i++)
> -		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> -	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> -	if (r)
> -		return r;
> +	if ((*bo)->tbo.resource->mem_type == TTM_PL_VRAM &&
> +	    !((*bo)->tbo.resource->placement & TTM_PL_FLAG_CONTIGUOUS)) {
> +
> +		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
> +		for (i = 0; i < (*bo)->placement.num_placement; i++)
> +			(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
> +		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
> +		if (r)
> +			return r;
> +	}
>   
>   	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 31fd30dcd593..65bb26215e86 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -551,6 +551,8 @@ static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
>   	for (i = 0; i < abo->placement.num_placement; ++i) {
>   		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
>   		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
> +		if (abo->placements[i].mem_type == TTM_PL_VRAM)
> +			abo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
>   	}
>   }
>   

