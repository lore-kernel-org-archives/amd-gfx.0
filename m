Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE35CED27B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 10:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB4F10E120;
	Tue, 18 Nov 2025 10:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vh7Th+9F";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C9610E120
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 10:41:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOqq3mVgJr2iGZW+AFptPaDOjww/gULQ2JLyXCdN6+JCLEvOzD5CnCYLvkyHMVM5m4/6sDJzoJBsjAI8DJiFoEiqnkAQCBeioVuWYRXoAHvEjhCXPYOaYaYufdL7Nagq3cI9OSTePiRtJEdKBZPqHB13vvUiu2ukB5K16GdUlkIFD6whVcdQjzTZLufIKY7mh46NCXtUe0/C8u8oDUcWYpELiivuIg/dq5LlwmYBYwycf/K/DauRTmZQk6mpRhrIluW+I0WfTxU/sq/j2Y6iwhzyjq3F0haX86HXj0A6g+NNNoFGMLIgZGwIt3vEPufDRnSBMfB2xQ6BG3Ps7kmDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mbsEZFF0CCdMBeB0UZ+gAq3jxfT1C5cmwtljNWX99A=;
 b=SScpHukmo7y2SLRmvUDOzmqFi8xvGdV1vmXHKrTeNvKYdsjyX28SfLqadlumozKP0a8Tbu5rvEZ8Nh5fA2H5zNLMImeAaaLjVvk+f2Q/f/rlHCSBfAUsII63nhj6T7rF9QKyjUdfSJd1zwOV/iJZ7BqMlrB78HCKGOn7j8YZ6d2jr5GCSi+5LCg7d1YYgfTtXmLVeQ8mjp3fyfc2Pn2uqbKHYaeTKgKSSY2nEKRcyoz++Nh357Y1cc4/S275CY4kuQDUJKCCHeSao3oiyu6uvjhNF2aAjVrEzGcAAHBTG8MJxOGJkuzJp64xoASgEXL35H6pv+vRMjcyDv00uzuDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mbsEZFF0CCdMBeB0UZ+gAq3jxfT1C5cmwtljNWX99A=;
 b=Vh7Th+9FQOqCTT+iMWa6ZtLuTIS/pi6sU7L3x0adDCgostnXE5vY6l2xMiZ0+CWYgWtOw1NuPyK3U27acBsMPCLnOUssITks74fIQ1lT32JdEseN8wEHGrt2UPQK9cZBgN2CZ59TDm6/bWqmBpKLS32r4Okb7YI/ex+KJEX5DsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Tue, 18 Nov 2025 10:41:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 10:41:19 +0000
Message-ID: <0d43d145-9845-46e5-a06a-29bfe9db5991@amd.com>
Date: Tue, 18 Nov 2025 11:41:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout
 is not enough for sdma job
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Chen, Horace" <Horace.Chen@amd.com>
References: <20251117065323.3435034-1-chongli2@amd.com>
 <cde95388-b48c-4310-b5e5-bcff56a31744@amd.com>
 <DS7PR12MB576863BD7C14E3671B31EC0E9BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
 <b6c09fdc-168c-4489-9a20-d20c472b16ff@amd.com>
 <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB57682BD7E22D58475BC395F19BD6A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:408:fb::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4779d2-967c-410c-5130-08de268f01d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y05mZFg1MCtyby80RnhKbnFWZkNNUm1GR3I4SlVrK0xhMlZOTUNWTUZnb2Zi?=
 =?utf-8?B?TElUNzFLaHU3bGhWTWlOUFVJY05TcWxRMU5CcWNBSXVYMU9acFlqZmdIM1o3?=
 =?utf-8?B?aktzek55NkxsK0U2azBQUFFHcFFPckhOeEZoSjVoaW9lR3V3bE1UbUZmVnNi?=
 =?utf-8?B?MXJDYkFNNXNmOUlJRWdDa1ZOTHM1Z2N5THhDbDJqNWxqQ0pNM0hvUlVlZkg4?=
 =?utf-8?B?T09nZEx4RE1DOXdrRGNKQ2lUSlNudW9wRzZVZkFsYTV2elFUWS9nbEE4OGkx?=
 =?utf-8?B?QlYwb1lVUnlNZjAyL3ZsVWRzZ0JDa01MVlJMV2tpcGp0bXdRcU5SV0VWcnRl?=
 =?utf-8?B?N1I4N05IRldDR1hjdlVXNnhDOUw0dTc2SU9oM05SNllzV0phK0xyeVRLdTVw?=
 =?utf-8?B?TlczQlI1Wlk0Nm96dFN3SUc1bzRxV01VYnhJVklEZGV3WG5MaVhseXlTWTZi?=
 =?utf-8?B?c1ByZUhBbDFEYVdtTlRMc0tzbTdnb3k4c1hxVTdkUHdOS2tod0JWR21vWklB?=
 =?utf-8?B?Qmh6UGJtdWxkMU1rK2hzYXNHWTAxb0tiTWNNU21pbzVxZXhSK2NoZGp2NThT?=
 =?utf-8?B?R1dxVVRLNUNMQ1VlMFN1QlZvMVkxYUQxNS9zV1ZnM0JtbGR5RTBYT1VJYWJ4?=
 =?utf-8?B?d21WWllRQUpkbzVrY3dSMXVVWUx3dGhNTTFlbXd1VkRoeWtSSlRGWFFFTmtp?=
 =?utf-8?B?dFI3NDJwRUoyemdiMDdabTlwVElMYkV0dVhCZ0tKVzNPL1BDM1FjY1YvT0xO?=
 =?utf-8?B?ZWluRFdrRUpHSWhodHFaSWp1b0lCZ3hDeGFEMy9saVBrK1FCNzV5WEx2ZXd2?=
 =?utf-8?B?eU1hbW5vQzkvT3dTWDBtcFd0YnJvdXN4TE5mcVVndXZJOHZlbjRmd1c1NDhF?=
 =?utf-8?B?dUFtelNKRE5zSGFpdmsvODZPL0QvbzZGTVJMYWg3Z1hqWWhEUGhXNVlhcVhX?=
 =?utf-8?B?TWZlNE9sQmFDdFlHRG5OV0ExYitCK0VELzFKczFpRzVxcnJ2Mndhd2ZUUzRM?=
 =?utf-8?B?cTBLcjNjbU8zZGwrWWJULzdDeW9hQ3NVc3pFQ1VCT3RVbWxWWlQ4SVJ1Zmd3?=
 =?utf-8?B?MWM5V2lGMm41TWR2RExoa05ib0JHNThubHJRNERhdnRKdEZzMFh5dEpNbEdu?=
 =?utf-8?B?cGc0UEZZcmZ3RUEwcDRNdUQ2VDR2eXZTQy95WGlxNG04ZlV0ZDFYaSt0OG12?=
 =?utf-8?B?aTErbmZFNnJmTFh1UFQ2MDNLa1RhVlV4MGhIWTFkaUsyUEQvQmc1dDIwNUs3?=
 =?utf-8?B?TlE2MHJLYlhnK04zaHBJeEFUZmtEK0d2M3ppRnZBZ1RXaERoZFpJcEtudHZV?=
 =?utf-8?B?VUxna2RSZXdPeEtiYmdNVDZ4SXoxNXVNcStLUFNxcVFCQTdpMXMzUG9wdWxl?=
 =?utf-8?B?ZjZBWDYzK2M1enI1eFVNOXZvVW1zTkdBVnVXcXZwNnhvaElyRG94Tjg5alB0?=
 =?utf-8?B?eVVHOTJIR3h1blFZRlpHeVBNelhZYVlhc1NJbFFqSjhicW10Q0xaRkpRbWVY?=
 =?utf-8?B?M1BXN2w5dDMxZUpTbWlvVkNkV2hNVFY0T3dqM3VDZmZZVk5ZUGFEMVVyTmtn?=
 =?utf-8?B?S2Y2OWpGeUxjaVpkaEMxMFo5Y0xQa3psUjZ2aVMzbm9GZjcyNnFxRjlIUkRn?=
 =?utf-8?B?SmNaMUMxamxWTG9zK0JKbGJxQm1aVkJ1cGVLZ2Y3MzlRalZ3Y0t4bE92cmpq?=
 =?utf-8?B?dk5GbkJVamRud1o1MnI4eklQZXVqTXF6bkJKbnpiK0NDbnFtekllTVdSR0l2?=
 =?utf-8?B?aXF0MVFXeXd2Z2FtVW4xRnJOb2Fxd1lRS3RYZGFPamRaVjZMSUIrUWxUOWhS?=
 =?utf-8?B?MXlXeFZRbG50U3pvVXZLMmRKdjhpbEx2amNMT0Z1a2tET2Zja0ZGazFvYkhF?=
 =?utf-8?B?MHBQTVhCUk0vQkdoSmZrK3ZkQ0toSGhaOVRjYzF6QmhqVU9VV0o3SmVzaUpp?=
 =?utf-8?Q?PPDXMgTTw1wJql96Z0uMG9t5md4eq7HZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHUwZjRER2w0UkR4SkprRSsvb2pYTVRYam1Gc2UvL0xjZm5uZllLTWYrZWwv?=
 =?utf-8?B?YlhuT3lWMnlOVWJad2YrcWpmQWdvRTZhZGJJQW9VVjJpM0YydjQ2RmttczVI?=
 =?utf-8?B?cytTYms2K25XenhBbmFDNmJ2NnZnaTFPSUJoLzNmeW45UlRpanVSaWNxZXcr?=
 =?utf-8?B?aEV6RGg3bUdpN05NWFh4MUdGZW8xeisyS3VBMlhJelhkdVUrUkQvdDZCODlH?=
 =?utf-8?B?cmhWTWJyYzdONmx2ZENPL2RhVmIzQUk3TEY0bi9HWWJOWSs4RHdTT09xZFk5?=
 =?utf-8?B?YlBYcStURW11Zmg4WGJQR1hNY1VBNFJTeUJvSUllLzF2UEliU0EwWXFhVlZw?=
 =?utf-8?B?MHgxSUFTZWsveXVjTkUxY2tYaFlKUkVWS0hia0c4RTNTNzV0QTZlWEFxeHhj?=
 =?utf-8?B?MTMxWHI4R1Q4STgvWWViYTNuVTRkVzdWWE1XS2J0Nlp3VVJacGdiY1l2R01R?=
 =?utf-8?B?NmpjZG9GQXB2NGRLbHhMbTJEL2ZtWEZtN1ZRTWVXOWFhdHdqeDFNNmt6L0J4?=
 =?utf-8?B?VG10TXJaczVkUm52YkJkUTVDcVNiZXNEVklxS3NSSTAwMmxlOFJuMS9JeUNn?=
 =?utf-8?B?T0dXSHE2NGdzbVcwRjVCUFNuaEpIb1haNDBXSU5kWis0OE1qaldneDNzTHlv?=
 =?utf-8?B?cmpkMUpuaCs3a3ZSQWxMSVRLUHFmSkhRU0FsYURUN3pGcWRLcTVXc01hNDha?=
 =?utf-8?B?ZFVRSERzeU9rak45citWNkhsYWp6RVAxWjNIdHBoaFVITEpRUDJXQVkzeWFM?=
 =?utf-8?B?NHo4dFlVZlJ6aHdaZXpqcThFR0ZBMW4vUk5NNzNqZlRPSUU2Q2VZU3VEVlo5?=
 =?utf-8?B?ckdwOTZ3Ujk5dTVlUHZ1d0FsOUhicWtFTjRkdHRBL2t1anN4bW5BQlI5ODZu?=
 =?utf-8?B?RGVKd2ZEMlI0V3Arc1lrRDQydTlvQ3RnMHFtVHh1SmxROVJZRDFvSHdXK3lW?=
 =?utf-8?B?MnNhZHRheGhiUCs2VmR6Q1R1Wlh3TW9mR2JHTXZGTEZ5NTRtTHMzVlEyTnZ5?=
 =?utf-8?B?aXljLzhTOXh0OURkTUVXSVJJV0p6Rml2OXQvNFdVTzUvUnBreHdnaVJZZFdP?=
 =?utf-8?B?K1FyOUVNOW42R25aVnhoZFhzaXdTVnhXcGpRdjlrSmdyMnQrTGJ3ekZRZHRE?=
 =?utf-8?B?Nlh4a3FsUGZudHM0bHR1MDFlb0pYaVlGZHdoMDRHdWp5RGZrVlVXRW1mTnhV?=
 =?utf-8?B?d29PZTN1cm52M1lCd1lkVVQ1Y0Y3ai84aVhDaFdGbGk4YTJyMkhPa0NlM2h6?=
 =?utf-8?B?azhIek1Jc2I5VDVOTUpMUnNCRWRUQzNDS2NFVUJVY290eU45SEZxZXF3Rlhx?=
 =?utf-8?B?SzZZR2FPNnNwSmljc1dPSjIxMktGc3UzWUUyc3RqWTQzUWFySHBrMVN2V0VO?=
 =?utf-8?B?RWhIL2ZzdVZucTA2SlZXa0Z3WHFQdElWY0lGZFk1cklJOGloY01zTWtYL2xC?=
 =?utf-8?B?ajEwTzM5SHZ5S0hOQXV2aHRpN21jTXBuWmlUTktkQ05odmdTejVuZ21OZTdG?=
 =?utf-8?B?ejFsU0dNTElFZ1FITFhFcGdycUF5M3JzR241aDVtSVJXODZYMFZHaUpJWHFW?=
 =?utf-8?B?VGRyeDZzNy9Cd1ZMVUdqQ0tUTEp0aVNEaEIza2U2YyttMWZpV1M0SXhqVmlC?=
 =?utf-8?B?cXpYcGpoMlRZMk5CRkJpWWlwQUlHMXlqMStzK0dIc3VBcGlWcmU4bEdyU2FK?=
 =?utf-8?B?QXBjcTNuSVNNZG1QbVp4NTM0WjNPdWZHT1hpL2ZJTzVEampBNFBaZktBVW5t?=
 =?utf-8?B?VVJEbzlaZEpROEhhVGZubWFhSlI2MXNDM2JJK3NYMlUvODA1NFdZcW9XUG9k?=
 =?utf-8?B?SmJ1YTNhd0UyQnBtL0lLc1M1emFsVEFISEFWT2I0VU05U3doTWlPTml0cko2?=
 =?utf-8?B?N3ZudEpZWVpZK0MvSmh4RTg1Uys0U1R0VmhacEg5SnJpVnpGUURBT1pNY1Vl?=
 =?utf-8?B?V1BDaEo3SWV0dHBmTm1WazR3R0xkdTU2L3NRVGdWdnpjU2loKzk4aTJoUWxV?=
 =?utf-8?B?NUg1ODlnVUlDa3JFdm8xaGlwWVh0bG10MWYxQURSb2Fhb21iZlhHOE9wbXBt?=
 =?utf-8?B?MVJKd1UwZ0JoekhBOW1GREl4L3FyZGhWZzR6V2VhS05oVFJhOVFqNEg4OXVD?=
 =?utf-8?Q?eLRRe3btyX9IqVxI6/Rah3ZKL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4779d2-967c-410c-5130-08de268f01d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:41:18.9765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agvCITzhetYL8LEeHRhie8YLN1KLszxKn3fQHsh0E09vFLNtuOt/5BEkspxnOawX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

Hi Chong,

yeah and exactly that argumentation is not correct.

We have to guarantee a min minimum response time and that is what the timeout is all about.

And it doesn't matter if the available HW time is split between 1,2,4 or 8 virtual functions. The minimum reponse time we need to guarantee is still the same, it's just that the available HW time is lowered.

So as long as we don't have an explicit customer request which asks for longer default timeouts this change is rejected.

Regards,
Christian.

On 11/18/25 11:08, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Christian.
> 
> what I mean is:
> in sriov mode, when customer need limit timeout value ,
> they should set the "lockup_timeout" according to the vf number they load.
> 
> 
> Why:
> 
> The real timeout value in sriov for each vf is " lockup_timeout / vf_number",
> 
> As you said they want to limit the timeout to 2s,
> when customer load 8vf, they should set the "lockup_timeout" to 16s,  4vf need set "lockup_timeout" to 8s.
> 
> 
> (After we test, when value "lockup_timeout" set to 2s, the 4vf mode can't work as each vf only get 0.5s)
> 
> 
> 
> 
> 
> Thanks,
> Chong.
> 
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Tuesday, November 18, 2025 5:31 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chen, Horace <Horace.Chen@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
> 
> Hi Chong,
> 
> that is not a valid justification.
> 
> What customer requirement is causing this SDMA timeout?
> 
> When it is just your CI system then change the CI system.
> 
> As long as you can't come up with a customer requirement this change is rejected.
> 
> Regards,
> Christian.
> 
> On 11/18/25 10:29, Li, Chong(Alan) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi, Christian.
>>
>> In multiple vf mode( in our CI environment the vf number is 4), the timeout value is shared across all vfs.
>> After timeout value change to 2s, each vf only get 0.5s, cause sdma ring timeout and trigger gpu reset.
>>
>>
>> Thanks,
>> Chong.
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Tuesday, November 18, 2025 4:34 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdgpu: in sriov multiple vf mode, 2 seconds timeout is not enough for sdma job
>>
>> Clear NAK to this patch.
>>
>> It is explicitely requested by customers that we only have a 2 second timeout.
>>
>> So you need a very good explanation to have that changed for SRIOV.
>>
>> Regards,
>> Christian.
>>
>> On 11/17/25 07:53, chong li wrote:
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
>>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 69c29f47212d..4ab755eb5ec1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
>>>       int index = 0;
>>>       long timeout;
>>>       int ret = 0;
>>> +     long timeout_default;
>>>
>>> -     /* By default timeout for all queues is 2 sec */
>>> +     if (amdgpu_sriov_vf(adev))
>>> +             timeout_default = msecs_to_jiffies(10000);
>>> +     else
>>> +             timeout_default = msecs_to_jiffies(2000);
>>> +     /* By default timeout for all queues is 10 sec in sriov, 2 sec not in sriov*/
>>>       adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
>>> -             adev->video_timeout = msecs_to_jiffies(2000);
>>> +             adev->video_timeout = timeout_default;
>>>
>>>       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
>>>               return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index f508c1a9fa2c..43bdd6c1bec2 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
>>>   * [GFX,Compute,SDMA,Video] to set individual timeouts.
>>>   * Negative values mean infinity.
>>>   *
>>> - * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
>>> + * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 not in sriov.
>>>   */
>>>  MODULE_PARM_DESC(lockup_timeout,
>>> -              "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>> +              "GPU lockup timeout in ms (default: 10000 in sriov, 2000 not in sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
>>>  module_param_string(lockup_timeout, amdgpu_lockup_timeout,
>>>                   sizeof(amdgpu_lockup_timeout), 0444);
>>>
>>
> 

