Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A309C25B77
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 03:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E9F10E089;
	Thu, 16 May 2024 03:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+cfeHjj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305CC10E089
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 03:38:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myj1ZL8YPs9i8jE6e9enW7ykVL8bscvsvpqs7SqvMpwRK0KO+UKpn5MOqglmux2bJc4rwTYd6nvysDj/6v1u3Vwto38xLgWU2qqH2riD6ZolDFN403XEefzenysPUThPu3nY3htMoLhxFAGwmOjKnfElLPiVwRDqzORmHsQn2tMfI5zeNTh4xZiceSVn1Ofzr2EPexpTip8DhhhvazkFyJzwBX9fzMK6ynVfkrqbC8wColQu1bTSjID6ViIhu8Ubz2BWud1b0PW5rG7l8vDSNOzWdJECzK+a4pKz/otuYiQx+jXBD7XLNKHFabBB6n/G5tNaWAYZcCGNtqGSfI6eFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPthqaos8vWRFn2lR8ExgoVrSq4zYVVfxCpBsMDS98U=;
 b=G1ukJgpFvLndADhPebnjsq+q4vCWmIo4EZldtZdESSJ3W+ZmNuE83F+uUS+cDiy8Z9Ewfx0bhvGIaihC7mO29Hmikx0zFuQNJzdv/xqbGX4Vip1VgPsKl3pl3daRQ87kZ0zn3Eq3mTW0+9HH9hAobGn+pehKmtuZt4Sz0bTmLgAZy/Kx+ofbDpQsKtaIgDv8MavqBQGwC1UartrLaxDnRcHVdIqUkPXLAx7W5mmqSSPRzRNTUxnzQzYFCmu1BVIlWhSur0n2/Z4hz+EzQUi2/qRr+mnz6GVWhtn46XlSffEGBIFsNnFvOvL3YTHmBw4bX2dVVEUA71SUeBcoRMy1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPthqaos8vWRFn2lR8ExgoVrSq4zYVVfxCpBsMDS98U=;
 b=V+cfeHjjKOrFk1+ybWv5DHsy8/kCg5tw55+zsRccfwUkeJ30JCpdPykq2QSLXEXcGHR0hEEvgtnoanT2ZpoQYRKaSietlQF/pLtbc93Zq7Y8aOoKy/dyv24nWfTCh7N01dFbetz6DTls5Pv+TjjdzQXMTiNgMG7b6uMwfa5LcC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 16 May
 2024 03:38:34 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 03:38:34 +0000
Message-ID: <8d6e52e7-bd48-4e80-bbde-eb536580a1a3@amd.com>
Date: Thu, 16 May 2024 09:08:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/amdgpu: update the ip_dump to ipdump_core
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
 <BL1PR12MB5144193323A251F3EB65E697F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <BL1PR12MB5144193323A251F3EB65E697F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::19) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: b68aedc8-501b-445f-cd1c-08dc7559a986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjFRQi8zb2ttdnlXRWg1dmt1QTJtdWRLb0oxZmhZSjVpR0h1MUkxTG13Z2xr?=
 =?utf-8?B?aVBKUW04Ny93V01iTkpud25XN2lub0xmQjhFcXNVMWc0YmFwMzNid3VrdDkr?=
 =?utf-8?B?dkpWTVBMSmhDamZ1aHRwZ3N3MTV0Q2VnMUZvNmIyVFBoMGV4QTNuZ1l5TFhE?=
 =?utf-8?B?RlpseHk3VHFLWURIQVBnd3lpUnArcndXMlg3aGpZbEVoS1NUeUtXK3FWbGdz?=
 =?utf-8?B?bW45UjQ2NFR4MVRIcHFmeHZuK2FCbUg5U21rb0xMc1lnTGt5aHlROUZuT1NR?=
 =?utf-8?B?bnlnOWIwYVhkdEM1d1FTdlNETEtUT1NpU25MbjJueWxqYVVSdUVCVjArcExK?=
 =?utf-8?B?QmJGUlVEc3IzbFhmNklLZnMyVVpsUldvWEdFcTFxTU9NN1ljRDRCRENzSXdY?=
 =?utf-8?B?Q0dndk1PcHowSi9PV1JaVEovWTVITFpTL3dqa1JzRXRRTmVIR2JzY3h5UkhQ?=
 =?utf-8?B?cklDb1ZVTktmRzlTMFlKbk03UjdyNkJ3LzdSVWRyVW9XWHFkVFE4VTd6Rnkr?=
 =?utf-8?B?Y2NMV29ZMVBLYkJWZXB2QWp4R0tCNUxwT1NCYUVubUxjZjAzaWZYUFdiUTFG?=
 =?utf-8?B?ZCtjZWhjbms0RFc5THlOblZPR1VrakpBZlBCaHZ3MksyNHVJUE9Hcjh6ZUl0?=
 =?utf-8?B?L3dob0hxT0VmVjkyMkp5U0VHM2M1WG9UdVBZZTJ5Qyt1ZnVvVUdzMU1waVd1?=
 =?utf-8?B?NjZ2OUROaldzODg0VmdUVVF4dzNSWEV4RURMTzBkL3NlMmRXUDVVYyt5WFk0?=
 =?utf-8?B?aWpsK0xDRjRqS0c2Zm1wemNESUpzL0JPNEhYU0pGb2FUWmlhVUJjeGtrc3do?=
 =?utf-8?B?bng0eHNFMnZ2aXBweHIyYUQrc055allUVVc3Y1QrN1U0OTNMWFFKNERXbHhT?=
 =?utf-8?B?NzlWQWg2aVNtRExsTytuUHdLRDExN2RCZ1VoQU52d3NWRHoyUTVDekRHTmRo?=
 =?utf-8?B?ZnlIeFYwUXo2Z29YYXg5WmJHdHU3WEJTN3VYTTZXbjlhYm15bk1Tb1FBaXBL?=
 =?utf-8?B?ZFJVaWRtY09CSXQ0ZGtRQld4eDY5d1FucWUrS040dG5qNWp2Tnd5VEhseUJh?=
 =?utf-8?B?WDd3NkdOdGFSeVEyOXJYOVBTbzBHUzdIWTVCandscUFPbkNzN0tIdGhYemcv?=
 =?utf-8?B?dk1rVHRMY05BMkM1SmhTM01YZGd5Q052eWttaUJZNFVhQVVhVjhONFk5bllz?=
 =?utf-8?B?blc4TFJUbnhGR1pjVjJKQmtJbVlxdVExeFMzVWp4UTdVbng5TUdyRUlzTEVL?=
 =?utf-8?B?d2lEYngwbGJwS3MvRFAxdzBLM2w2UHFpbHlYRllXdi9WTmQ5SjNMcFNEWjE3?=
 =?utf-8?B?OWs4TmxRTE1lVWdtQnR3SVZkaWxlSUVnclR4Ty8vaTlPYS9FNFRQWDFIVzlp?=
 =?utf-8?B?eWZhTDZQK0k4dEJaOGNqM2ZtQjRKQUh5MmdiN2hxcFQvQkFST0laY0plcjAy?=
 =?utf-8?B?OEREK0UvUjV5LzNMRnNJSEZNSCs2WDV6Vm5MNUJYb0NLeUJmSXkrWXFDdFlW?=
 =?utf-8?B?dEhFTzRMZHppWk00ckJvNmhXWk5zY1VXb0o1bkNOalVKeUpDbVZWeWhLUGhk?=
 =?utf-8?B?dGdUTW9HMWUwZHVPeS9LQTRFTUZScFZuUHQ2bEhDc04rVkF0R3RLSE40U2hB?=
 =?utf-8?B?MnhjbXp6VDNDdjQ2V29PbnBqVDBmaXRnUGZVd1FsdHE2RFlTTGVaaFQrMFlP?=
 =?utf-8?B?VWpMY05TSm1oaHN0K3NBS0l4MjVBeDRnWHNFRXh0K0szcUpwLzRzeStRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWJnQXFlMmJKOGNyUTlTLzZMNXptbm0zdGlaYnFkYzZadHVMSjEwS3VmZWNm?=
 =?utf-8?B?RGxIRVY5eXpIZm04VzdEeGppWmw2L0lvQURieVdZU1lMTVNnUGFhVG9VTnVH?=
 =?utf-8?B?c1VOWC93NklyKy9nY2ZVK2lmQ0RTeXRtOUZNOGw0MWNmN0ZIVHIzRzNySUtr?=
 =?utf-8?B?VFhHT1NxNzJ0UUVYM0FHUStzUXRhaGNOSlB4UGtwcUFYMU91WkVNbUlnb24w?=
 =?utf-8?B?VGNXYWg2NDBhcmpYMHJ5amEvZnhSNmlvUWE3VExvdWVwd2lua05HSDM5b1Ns?=
 =?utf-8?B?NndUTG5lbGxjOG5md1crbnZxRW13RWxWZzhsYUxrRDBVdlBUMWlYWGpBK3kr?=
 =?utf-8?B?cFdrUDdWRHE5OUFiRldRbEx4OTBqbkQwdWprQUliZXluNU9BaDlqY0JsYzgy?=
 =?utf-8?B?Y0dSc3lqcVZmcTQwcTdCY25MMGhoalNkS0Z1aXkvYkpuU1loQ2czczFkOFhW?=
 =?utf-8?B?Y25kcE13Snl4OWFxR1AyblZZeXJMZ0VtelRGaGE0YkhvalN5ckwwV1lNMlkv?=
 =?utf-8?B?RExIMXJFT3VCdFptK3hSd2htUW5tYnd5RHhKTXpkaDd3OG5tZjF0S3d2cTVi?=
 =?utf-8?B?SXBvM3k1WnR5WFRudWI0RFFPVTNYVGVBZDUrdEYvOVNDU3hkd2dOcmpBQVYy?=
 =?utf-8?B?VHVmUE1MWHhXZHd2ZHVLOTMxY1JWU1FhaTZtYy9xR3YxbzNGaHVqMHIvWjlt?=
 =?utf-8?B?K1pUMFVpdkdBa2QrUjgzU1U5UGtuV3ZVM3FPNFFWVEJhYW0zcmZSdmpkN0h3?=
 =?utf-8?B?M2JjL2RObDdvelFDakh4dnFtTDBIUnY4VU8vRnFhZWYzL1FTcUhEOVdYcWNJ?=
 =?utf-8?B?REo4VVRZMUVsNnp2cFNUMW9FTWY1TFRVemVJUlNwSlA0OW9icmNoWXJOeWc5?=
 =?utf-8?B?cGxOZGNxOWN5RmdSdUZEWUlLbWdnRndYendVc3ExS2piQUhkT3hlT1BJbzdu?=
 =?utf-8?B?Rlc3OHlpWUhPM0NIeXJvNWc1WVU4MkNuQzYwNFB5WjN6QitUMmRtd0hpeVV0?=
 =?utf-8?B?dHhEeFl4MnpNTi85c05STEdqVFlDamp5bTRoTzRKSFBZcDA4T2pPVU5yM0VS?=
 =?utf-8?B?Q2FWem15NHpSbWNyOFBIV2lYU2lHNnBIK0ZFTFl1ejkxcFNPYjlxYjBUK1RM?=
 =?utf-8?B?U2htajV3ZDVBbStZckhZbkF3RTIrYVdjL0dONjkvbHhWZG1LNHNZNWlBWm95?=
 =?utf-8?B?RmNDN2I1aDVvVjNobFBpTlZXK09RMWNWbTQrcGJseThUT3pweHovRVFWSkV3?=
 =?utf-8?B?YjNxNkhnQUlTQVBMa0lYVE80YXAxRGk2d1NRZFo1aXNKRFZXMDF3RmFUbzBC?=
 =?utf-8?B?TnA4bDhoQlYzZVNGM0lNNS94K1JpSk9JMUN2VkRSUTVNR1kxdy9Dekh3OEg4?=
 =?utf-8?B?UE5jZGJadk8yUVo4TmhtdzdWb2dNaXV5RGNVTU5xdHkwLy81NUxvQ1BzbE1j?=
 =?utf-8?B?NWtrVGFhSjNzVGo1YjJXSjhLMGRBaFZ3N3ZPRlExMzUwSEhBMjN4WTRTc1hi?=
 =?utf-8?B?ZTVyamxURFI3V2VCSE9BMkQzWWRKTEVibW1xdHpMTDAvbm1WeWF0ZGlnSEU5?=
 =?utf-8?B?Ulk1UVdma3pPQjR4RSs2N2lsRlkxY1YwQkxSMCtkZStmQmJaeWx0eFdncHY4?=
 =?utf-8?B?aEx6ZjZMWjhXVEhYL0NGOFhZdVMrTmlCNHhFYWI3bWtVTTBTLzl1ZDJnUmxF?=
 =?utf-8?B?OFNMRTNTWDE1V2NEblJ5aGY3elZMKzMwdFc1dUFjdU14dk1LNW12RUtsWDlq?=
 =?utf-8?B?WDdnZGM1cnM5VmVzOWlKVlZleDhUQ1RDeGNPMlB4ZzQxWitPRXJncFZJeVpN?=
 =?utf-8?B?S1kwejkyaEo1L2pQc3VZemRmNUkwZDltRGRGTDhuUHNWaTdUbmllNi94dEV1?=
 =?utf-8?B?emxLV3lDcE9LRmwvelhKeGpNY3RuY1VjZmlOcnRYeEppVHB6Qy9HNFNuakV6?=
 =?utf-8?B?YjA1bVhiOGVzbHMwRnlTcGRKdlRzSVJXSiswT3lxN3AzaEpia0swQUI0NDRD?=
 =?utf-8?B?L3E3V0hoZFJkajFPR2pscXM0OHErVUtKWUhCcitvRWtjdzEyM0NSdkZpRHRF?=
 =?utf-8?B?c2FsTFd0NWtFWDZzOFp6aENFbWRvNTdzbTUxNndYdG1Ma3NOODZtdWxqd2Z3?=
 =?utf-8?Q?V3wZ+XzWHyvjb7ARxMRGbtzId?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68aedc8-501b-445f-cd1c-08dc7559a986
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 03:38:34.0368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPAjKPzMj6MwhSgiB8oETxonUphg0I+OE/n8qhUYMjXENxCW2uNS9ijrNge1/onnlCqjA2WLux28Kuel08jZNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
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


On 5/16/2024 1:37 AM, Deucher, Alexander wrote:
> [Public]
>
>> -----Original Message-----
>> From: Sunil Khatri <sunil.khatri@amd.com>
>> Sent: Wednesday, May 15, 2024 8:18 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH v3 1/4] drm/amdgpu: update the ip_dump to ipdump_core
>>
>> Update the memory pointer from ip_dump to ipdump_core to make it specific
>> to core registers and rest other registers to be dumped in their respective
>> memories.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +-
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 14 +++++++-------
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 109f471ff315..30d7f9c29478 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -435,7 +435,7 @@ struct amdgpu_gfx {
>>        bool                            mcbp; /* mid command buffer
>> preemption */
>>
>>        /* IP reg dump */
>> -     uint32_t                        *ip_dump;
>> +     uint32_t                        *ipdump_core;
> I think this looks cleaner as ip_dump_core.

Noted


>
> Alex
>
>>   };
>>
>>   struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index 953df202953a..f6d6a4b9802d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4603,9 +4603,9 @@ static void gfx_v10_0_alloc_dump_mem(struct
>> amdgpu_device *adev)
>>        ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>>        if (ptr == NULL) {
>>                DRM_ERROR("Failed to allocate memory for IP Dump\n");
>> -             adev->gfx.ip_dump = NULL;
>> +             adev->gfx.ipdump_core = NULL;
>>        } else {
>> -             adev->gfx.ip_dump = ptr;
>> +             adev->gfx.ipdump_core = ptr;
>>        }
>>   }
>>
>> @@ -4815,7 +4815,7 @@ static int gfx_v10_0_sw_fini(void *handle)
>>
>>        gfx_v10_0_free_microcode(adev);
>>
>> -     kfree(adev->gfx.ip_dump);
>> +     kfree(adev->gfx.ipdump_core);
>>
>>        return 0;
>>   }
>> @@ -9283,13 +9283,13 @@ static void gfx_v10_ip_print(void *handle, struct
>> drm_printer *p)
>>        uint32_t i;
>>        uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>
>> -     if (!adev->gfx.ip_dump)
>> +     if (!adev->gfx.ipdump_core)
>>                return;
>>
>>        for (i = 0; i < reg_count; i++)
>>                drm_printf(p, "%-50s \t 0x%08x\n",
>>                           gc_reg_list_10_1[i].reg_name,
>> -                        adev->gfx.ip_dump[i]);
>> +                        adev->gfx.ipdump_core[i]);
>>   }
>>
>>   static void gfx_v10_ip_dump(void *handle) @@ -9298,12 +9298,12 @@
>> static void gfx_v10_ip_dump(void *handle)
>>        uint32_t i;
>>        uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>>
>> -     if (!adev->gfx.ip_dump)
>> +     if (!adev->gfx.ipdump_core)
>>                return;
>>
>>        amdgpu_gfx_off_ctrl(adev, false);
>>        for (i = 0; i < reg_count; i++)
>> -             adev->gfx.ip_dump[i] =
>> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>> +             adev->gfx.ipdump_core[i] =
>> +RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>>        amdgpu_gfx_off_ctrl(adev, true);
>>   }
>>
>> --
>> 2.34.1
