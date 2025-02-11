Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05054C0219D
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 08:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653B010E434;
	Tue, 11 Feb 2025 08:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eIvSFGKT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE4110E434
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 08:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgzjqjhS87ryrlLTC3/Jw59onqb44BnAXRSHsiV/d1Tw66nvVOhicgs8Fe++9G2r61v2f0tI4KMNOHVHhqzESkYzrr+ItXATaeGWWjzbk3sTrzEDgJreDuc7T9UjgtCLGMRLtTFkHby0Kv3qwaNwOladkCcSjWADLlqadiwjCqmUIWBZ7jvX+NTiYifmtGjIIYb4tMn9Snt8Q7snQoP3g1L5EfTZCnOh+JjRL5q70mYpbKQuE4aT1tvl0KynWJu4FQr2JPwLhaHGdMoPHuD+d4DFwdfVE1dZDH3iTCNmN9SO4HHX+NSFFLecSyXoPbk5/1sgeNo5fvBoQr0wYqfQKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IspkXfaZ1iv4JlBw+4zCHy0fiY/0E3gubU1nko6ObdY=;
 b=yb3EeRn+EUSQbvBsDbrxgADiFQVJF1U6Tvlj2foOl4liPg25yL7wyyUxWcB41ZffyKjS8+4S3TJtwNALv4Z5gLKEWS8TEaSf8U7f6VHg/DLTUpaCwwORIW4nwMddYu14x1JQB7jP4H/MVDNT/v508lSKHRyrztYZGPVJ5h6KG1e9SMtFT+ZEBdbAUocHT7eBQcmuLNyIpZJXmm5dpkqNr0wv0ww5F72LK99tl1kPn7OLk9EkNH9kbnX57QE/nzpnto2G/+V0PByJF6i50f9LMY6E+s34fvK9HgMo9q/PHqaaXFzKdhKdrXmDK1mkbYph1ByYC/PlCr03zcIqlSLFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IspkXfaZ1iv4JlBw+4zCHy0fiY/0E3gubU1nko6ObdY=;
 b=eIvSFGKTDhA4q5zvmSje8LOXn9S5xuRqdR9lfLFz6TV5dzMaer/2t0cbQuzMZAp19o52rmyBWfmt9d2F5PcN5dXDUsjwFke1ig867GGesVy32Lt194SuUfISgSUbSvfQWl2AVilUW35FFbJgV31Scq+ETn0mo0FnC0Ay8XcAs/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 08:09:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 08:09:43 +0000
Message-ID: <ed56d4e6-f039-4226-b049-a686adc71135@amd.com>
Date: Tue, 11 Feb 2025 09:09:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] drm/amdgpu: Per-instance init func for JPEG4_0_3
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>,
 Sathishkumar S <sathishkumar.sundararaju@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
 <20250210142548.2321625-2-sathishkumar.sundararaju@amd.com>
 <2fd0d40a-db7b-409b-84b5-6cd47eec12e9@amd.com>
 <6f8f1c9c-d85d-4fac-973b-9d3ef6495dd0@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <6f8f1c9c-d85d-4fac-973b-9d3ef6495dd0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: dd01151f-10a6-4418-1501-08dd4a7370b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NG9YMzR6MGJrNGMySzIwZEpEb1JTY2JSc2MrK1ZUeldRSjRmQm9XVjlraGNj?=
 =?utf-8?B?VUs4UThwc3FWVnZ4UmJ0ZlZ2Vi9nNUhFanU0UllmMGQ0ODhnMVYrK1pRRkRh?=
 =?utf-8?B?eTFPalJ6K3B4emlhd3kvZlQ2dVhRbnMxMEtJNHV1bnBzSnFLS2ZzNkNRMG1O?=
 =?utf-8?B?b1JCMk5iYWpmYzhmYnlIaHZHbi9oUFNDcUltcng1bnVBZ2puRGNkbnVOdnJj?=
 =?utf-8?B?SG9RcnhOWkJWb1ZIcXRvckJmSm94VmNZcWo0SGxuK28rZ1B2MHcyaFdFWVdK?=
 =?utf-8?B?NnFTNUVpamJ6U3lJaFU1MElSTFdBMFB0MFFCYUJ3Q1R0SC93ZHUwcXFsWG9P?=
 =?utf-8?B?RHNKSTI3SGlJVE50MEk4U0dBdC9vNkxOUDJSZHl0WnczbC85N1Rua0RVZmxx?=
 =?utf-8?B?VndsQktQdWRzSzZxRGpFTFZVbVVLMkJCbzFuRlRxMTNLaTBjN05Bcm9uWEZr?=
 =?utf-8?B?ZW1QdW9vZjB4eGlUUVFlckhTWm9vb0Fvc2wxdVN3L3lRc0FsY28raDlUb0hp?=
 =?utf-8?B?MHdaZThoTVR4ZG1LTFJaTnRnZUIveDRDT1hIRW1tSGI1b2hkYVFTYlZxTllX?=
 =?utf-8?B?cThuNUVsUXFaNDVhUTRQVFZCeE5mbjdEdTB5UnR4Q2g3K0FBQ081bCtpNUh5?=
 =?utf-8?B?b2RpZG1xdi96bGFlTGo2OXR0ZHM2TXNkQ2hnWFZWNE15WmhFTjlOeW4zam5Y?=
 =?utf-8?B?bURiMGcyMW9sLzl1a3hhSFh1YnFuNmJ1THpxZ0w5SEF2cUVHNGVwVXYyWTA2?=
 =?utf-8?B?M0h2aGNVSCtCQ1NyekVna251TW9xOVFGenE5SXBwc21HTkJrKzl5ZlZMQVA3?=
 =?utf-8?B?WVlGT1JhclA1KzMvZkJtQTRPdzFNUDdybk5uQUJrUTJINGZoakpMSXpIUW9J?=
 =?utf-8?B?dWtiM0c1U01tNTBsb3R6VnZlQy9IcDl3dG9ZTzZVVHBOU0tvY3JuRG1FOTN3?=
 =?utf-8?B?MVBTNFhmcU5VNFQvUEhmRGoyYnhjd2tnS2VtME1XZGROdXhTS3BQcDJHM0F5?=
 =?utf-8?B?c28xWFpmenNHRGNlOFF3U2pGQ0pIZzJaS0dQOTdzRm51QTZ0cmwzZVhROEN0?=
 =?utf-8?B?dEU1d3VKSmlMYnhiQVZmME12bXI2NW1SL3hKSjhwVDdGS3M2WVp6cURYQWhR?=
 =?utf-8?B?ZGdMTko3RkpkVEYzMmQwY2hUNjhvd3kzNXlZNjZlTUtDT055ZGtmcVdYZy9M?=
 =?utf-8?B?UUtVQWFlK2IwZWtRQVdWY2thNkFPNTF1MHBsa3JFRXBDZit3QUVsL0lWZy9Y?=
 =?utf-8?B?S1lsWkpBTFJWTGdyaGxOVXI0RWRiL1RpVTlqODhEcFdHMmxWUG54TE91QUVl?=
 =?utf-8?B?NGRNUmhiNDVncFJabFA1Nm42NFNtU0pLZjVWaGducDRKVmhrWFhzL0pQQ1BP?=
 =?utf-8?B?MmxrQ3I3TFR0Yk0rdnpzQTFadjNqV1F3dXRxSklsQmllLytFallXcGVyT1da?=
 =?utf-8?B?SEI5ZHRmbzA2b0xrTDZYRVJJU1ViYjFrS0RWYkkxb0VlS2htandFVkRkOE5K?=
 =?utf-8?B?QUNEN3VoWVBER1VZdVhtM3BrV3lucDZYVXg1SWlpLzk0cWxEYUxUeWlCcWVL?=
 =?utf-8?B?bnUzbldVbGh4TVhEbjVya0E2S3pRYmxiN2xKTkRMWHNHbGVRMVlMeFFQRGli?=
 =?utf-8?B?ekZ3MS9nZ1V5TVJROXB0bTJtTk1zWHIyc082eGlUaXErNG5ZeE1yZ0dRR3dJ?=
 =?utf-8?B?NUJUSG5uWUN6MEVEOFNudlZjZGgrMzJWWGdKYll5a2xuNFZUeUIzUWxDckJJ?=
 =?utf-8?B?dmp3WHl0bzliK1ZDRk9ldWNwYjIvQnh4dmhoYzlVQm5rRXhtcmdIOENIRnFW?=
 =?utf-8?B?K2NxUS9PM0xLUDQxVTJZRUJpcHcyQ09VTGxXV3pYQUkxb1hHQUNIRkVsZUFj?=
 =?utf-8?Q?NtcdP6OGSDKEe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGdzY2JXVVRhWXlKSkYzVm5hU2ZrVTUxYUVLbDlvVzJYbmdleXUrK1BDbVZB?=
 =?utf-8?B?eHJxYTU1ZitoaDdXVlJ0TytOZmptS0szT3pMU00vQjk0dnBPTFVzSU54ZFdM?=
 =?utf-8?B?dzczcDhaRHN6bjU5Y1hNOWxJb0tKQU5zUWpFSW9YNEYwZUF4WVVJZ283MVh6?=
 =?utf-8?B?WnFNbmM5ZGZnTWdvaDcxM08wSWJDZmYzSU5NMFBxWmRiK0NPUGxpekE4K0pI?=
 =?utf-8?B?ZjIxSFhZVWtTMHJYS2pjU3dtYTBKb04vbDhxbEZCUXFjM0dFZEdxVjlmaEdq?=
 =?utf-8?B?bkh0dUNzQTdoYlNpRVFaWUNaNVRQZlF2MXJNTUMzWDNPQm04UzVrbFV2cWFY?=
 =?utf-8?B?UGJoMUZhMVU4Q2czdGozS1F2aWhNL21QT3I4SWF1d1ZPa1RBZGhWbzBNaDM3?=
 =?utf-8?B?Zlk0SStYN3RzbzdSalBMVG9RWGJKNTRLZm4rSGpoWlF3NTBUV01jNnQ2Vlls?=
 =?utf-8?B?Sjcvd1BZQWIzQnFvN1ArOGpzK1d2RllycGVXODFQSStIeFRUUVVVRzMzblVt?=
 =?utf-8?B?YU50ZE5IT1U2dzdWdTZWNmNUMG8vZWQ2WHgrWkhQK29wRUFXbjFZc2c0b2NC?=
 =?utf-8?B?ZGpKcC8zN1I0YWw1Q3Q4SGRVLy9VS21LeW55U3JUU3BHQnBzakR2MlBCSmhH?=
 =?utf-8?B?UXVwNjN4YWI5WTVYOSs3RFJzR2RoOUptT1RPQjFwMG41d0UyakI2K3pZNW1q?=
 =?utf-8?B?OG9KMGE5UCtqb3dwdkdJODU5L1ZLT2JiSnpaTzB6ZUxzcFV0bVhia0IxTkxR?=
 =?utf-8?B?anpVbG54YUxPY0dtSUl6bmFOUmNiUkI3dG4raFZVS2l2TjlseGlOS1dzRk1n?=
 =?utf-8?B?RVAzRzBXVHRNZ2M2dVFNVlJybmd5WFRRcUx6a09jbUlBYi85S240Umw4WS8x?=
 =?utf-8?B?SFg1Q240RGVIYVFTSm96eXJuNkNtQ0EvWFp5Wm9IS1ZEZXUwd0pQQi9RMVNP?=
 =?utf-8?B?N3ZPejhydTJDbENaQW9ZbldYK0J6Y0RhUUJ0VjMrUWkxYWJsUjJqRFQ4MXFU?=
 =?utf-8?B?eHdQbUYvYkdHMkJrbE1yNkhLOVZuZkN6Q3gzb1BNNjdZVFlkQW92aUV0Mk5H?=
 =?utf-8?B?US91TXVwdXRHaEJVYzN6RnpFU1YxR2plMzY3UXhlYmp1Nlh5MjlZYkpaaVd1?=
 =?utf-8?B?RVk1ZXhkWlpsOUJZT1dFTDI5MEZIVmR6RkFFTEIycncwUkJsTzlwaURSM2xY?=
 =?utf-8?B?aDIxVmlYWURZQlFRdmZzVk5QMFRxbnU0WUtXS0JjZXpuRk5Uem9nZDBVL0xM?=
 =?utf-8?B?L1FCZm83MTZmcHF1ZjQ0Z2tkYWE1UisyTmNDWXRNU1o5cnJMY015dVgxYi9y?=
 =?utf-8?B?ZmsrNHRmZDlyQmVqNEJkdm9kQkUyZllqLzF5d2h4ZC8xdVlFRzI4YUhYd0FL?=
 =?utf-8?B?aGlrMHhaRG1aaHp5R2ZpcXpFbmMwYmZSMzNHUVhqL1F4SXkrc3VmbTN5Z253?=
 =?utf-8?B?aFR6RW5sYm94dmNjYm56TEtoZXQ2MXFVeDA3dUM0UC9XYzlyUDFpbEZTNHRo?=
 =?utf-8?B?WFpYUUE3ZlhUMGMwQ3FXa0FJb2FuQTYrZzVmZVVvSURiTGE0YU9RcUVzcXgr?=
 =?utf-8?B?ZXlPRlE0L2lIQlRYeHJWRHpRaGRDczhiVGNsLytaM2JadjU5ZUNMenJDb2xB?=
 =?utf-8?B?OFJBNDhzVW1ENjBMYlpRYlIxSWZ2NlVPcW9KRlBjNEg2S0JwTFRPRTBWVUJZ?=
 =?utf-8?B?UnFtN3B3c1g0aUUyNTZ6Mi9jNzlBY213d2VkS3M4N01vSXBIWnUySVkzNkpE?=
 =?utf-8?B?QnZ4cGVoVGsxaVFleGxJL215S1ZuQ3BKU2Z6RVZRbThSTjVzRkhFcVZyYmxl?=
 =?utf-8?B?R2FmdEt5dWxNYU15RGZ6WjRmcWx3ZVpaeUpBRnNad0k1Vk44bUF1T1BTb1Br?=
 =?utf-8?B?azZsSm5xYTVmdlNoblljcmoyN0dBV1dlZWlWMkFjZCttSE9raTFDblluMWRW?=
 =?utf-8?B?dUE3bG1PQkpXZnB6Lzg0THNHSkJmMU5kSkltMldsZHBlRVZLUGtFNU0xcTRU?=
 =?utf-8?B?bTRJL0haeERyM3gxTXo4YzU4VjBTajNUbmNudDYrRDFQTmRmMG1lUFlIZW55?=
 =?utf-8?B?TUc2eG5MRk9iMDQ0cjFBYXRucXArY2FEckV6RVFGckpLeGJDNXpjMjBSVGI1?=
 =?utf-8?Q?nOQFlGP0Bg/MgxgbPCLY44ULx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd01151f-10a6-4418-1501-08dd4a7370b0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 08:09:42.9877 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK85e3MMzf4kDQl5lxPtrUKQVoDBZcrmcPh94+GL8cFumE0THytVjqOZ62yi9ZZA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

Am 11.02.25 um 05:09 schrieb Sundararaju, Sathishkumar:
> Hi Christian,
>
>
> On 2/11/2025 12:52 AM, Christian König wrote:
>> Am 10.02.25 um 15:25 schrieb Sathishkumar S:
>>> Add helper functions to handle per-instance and per-core
>>> initialization and deinitialization in JPEG4_0_3.
>>>
>>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 
>>> ++++++++++++-----------
>>>   1 file changed, 98 insertions(+), 92 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c 
>>> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> index 2a97302a22d3..be0b3b4c8690 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
>>> @@ -525,6 +525,75 @@ static void 
>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>       WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
>>>   }
>>>   +static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, 
>>> int inst)
>>> +{
>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>> +
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> +             1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> +    SOC15_WAIT_ON_RREG
>>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_ON << 
>>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>
>> Please double check the coding style with checkpatch.pl this here 
>> doesn't looks so well.
> I did check the series with checkpatch.pl for 0 errors and 0 warnings, 
> I can realign this to the usual way though, thank you.

Thanks, I was just wondering if the ( on the next line is ok or not 
since it looked so strange. I would try to use more of the line here.

Regards,
Christian.

>
> Regards,
> Sathish
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +    /* disable anti hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, 
>>> regUVD_JPEG_POWER_STATUS),
>>> +         0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +    /* JPEG disable CGC */
>>> +    jpeg_v4_0_3_disable_clock_gating(adev, inst);
>>> +
>>> +    /* MJPEG global tiling registers */
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>> +             adev->gfx.config.gb_addr_config);
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>> +             adev->gfx.config.gb_addr_config);
>>> +
>>> +    /* enable JMI channel */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +}
>>> +
>>> +static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
>>> +{
>>> +    struct amdgpu_device *adev = ring->adev;
>>> +    int jpeg_inst = GET_INST(JPEG, ring->me);
>>> +    int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
>>> +
>>> +    /* enable System Interrupt for JRBC */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
>>> +         JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
>>> +         ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
>>> +
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> +                reg_offset,
>>> +                (0x00000001L | 0x00000002L));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> +                reg_offset, lower_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> +                reg_offset, upper_32_bits(ring->gpu_addr));
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> +                reg_offset, 0);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> +                reg_offset, 0x00000002L);
>>> +    WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> +                regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>> +                reg_offset, ring->ring_size / 4);
>>> +    ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, 
>>> regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> +                     reg_offset);
>>> +}
>>> +
>>>   /**
>>>    * jpeg_v4_0_3_start - start JPEG block
>>>    *
>>> @@ -535,84 +604,42 @@ static void 
>>> jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
>>>   static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_ring *ring;
>>> -    int i, j, jpeg_inst;
>>> +    int i, j;
>>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>> -        jpeg_inst = GET_INST(JPEG, i);
>>> -
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> -                 1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> -        SOC15_WAIT_ON_RREG(
>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_ON
>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> -
>>> -        /* disable anti hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                      regUVD_JPEG_POWER_STATUS),
>>> -             0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> -
>>> -        /* JPEG disable CGC */
>>> -        jpeg_v4_0_3_disable_clock_gating(adev, i);
>>> -
>>> -        /* MJPEG global tiling registers */
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
>>> -                 adev->gfx.config.gb_addr_config);
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
>>> -                 adev->gfx.config.gb_addr_config);
>>> -
>>> -        /* enable JMI channel */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, 
>>> regUVD_JMI_CNTL), 0,
>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> -
>>> +        jpeg_v4_0_3_start_inst(adev, i);
>>>           for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>>> -            int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
>>> -
>>>               ring = &adev->jpeg.inst[i].ring_dec[j];
>>> -
>>> -            /* enable System Interrupt for JRBC */
>>> -            WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                          regJPEG_SYS_INT_EN),
>>> -                 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
>>> -                 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
>>> -
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> -                        reg_offset,
>>> -                        (0x00000001L | 0x00000002L));
>>> -            WREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst,
>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
>>> -                reg_offset, lower_32_bits(ring->gpu_addr));
>>> -            WREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst,
>>> -                regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
>>> -                reg_offset, upper_32_bits(ring->gpu_addr));
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_RPTR,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> -                        reg_offset, 0);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_CNTL,
>>> -                        reg_offset, 0x00000002L);
>>> -            WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
>>> -                        regUVD_JRBC0_UVD_JRBC_RB_SIZE,
>>> -                        reg_offset, ring->ring_size / 4);
>>> -            ring->wptr = RREG32_SOC15_OFFSET(
>>> -                JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
>>> -                reg_offset);
>>> +            jpeg_v4_0_3_start_jrbc(ring);
>>>           }
>>>       }
>>>         return 0;
>>>   }
>>>   +static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int 
>>> inst)
>>> +{
>>> +    int jpeg_inst = GET_INST(JPEG, inst);
>>> +    /* reset JMI */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>> +         UVD_JMI_CNTL__SOFT_RESET_MASK,
>>> +         ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> +
>>> +    jpeg_v4_0_3_enable_clock_gating(adev, inst);
>>> +
>>> +    /* enable anti hang mechanism */
>>> +    WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, 
>>> regUVD_JPEG_POWER_STATUS),
>>> +         UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>> +         ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> +
>>> +    WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> +             2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> +    SOC15_WAIT_ON_RREG
>>> +        (JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_OFF << 
>>> UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> +         UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> +}
>>> +
>>>   /**
>>>    * jpeg_v4_0_3_stop - stop JPEG block
>>>    *
>>> @@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct 
>>> amdgpu_device *adev)
>>>    */
>>>   static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
>>>   {
>>> -    int i, jpeg_inst;
>>> +    int i;
>>>   -    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>> -        jpeg_inst = GET_INST(JPEG, i);
>>> -        /* reset JMI */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
>>> -             UVD_JMI_CNTL__SOFT_RESET_MASK,
>>> -             ~UVD_JMI_CNTL__SOFT_RESET_MASK);
>>> -
>>> -        jpeg_v4_0_3_enable_clock_gating(adev, i);
>>> -
>>> -        /* enable anti hang mechanism */
>>> -        WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
>>> -                      regUVD_JPEG_POWER_STATUS),
>>> -             UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
>>> -             ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>>> -
>>> -        WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
>>> -                 2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
>>> -        SOC15_WAIT_ON_RREG(
>>> -            JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_OFF
>>> -                << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
>>> -            UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
>>> -    }
>>> +    for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
>>> +        jpeg_v4_0_3_stop_inst(adev, i);
>>>         return 0;
>>>   }
>>
>

