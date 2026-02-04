Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29316E95360
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 09:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FF910E5A5;
	Wed,  4 Feb 2026 09:35:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcm/wUyp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49D310E5A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 09:35:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9JCYmueFbM9xcpHCx6nGef5vFb61DKqIWqNxbXFd0qU4187SJP3UtEF6Yqwd+pn9SVksTXZg0gFjVtcCoQ0FSutKYQmnSe22PZztjp8pFgco3RoRCeBqusIpXaXT4cGGDP+6auPR8jxfyjyIhD3fgDjGBQsaZiEvMOubkiPL0/35RXaQOHAm9ldMwRdJlSCchTATY4320KzimkmjrPhdR+u8kN+XR/7T2ZWSian/JyUsS1N7KlipncHa8v9rP0uUww27myJHK8/iRXbGpfbpZcxOl1+ikTdrAub9ZPRVPK94iKmpK39bsgHTdeMm7gQTZSZ/kZi2r1iJ4iFYSixcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J6e5E1BtnRWYmuHcyD+vb1cZxYlJWRsODiD69EBalk=;
 b=F+J5TBhYtlPET3j5qY5YVI7vhkTZAZrVtH3YBKDOLzMpbP8mHwHN6wKoGvdLrU8JfBUkZNnk9KmeiJNgUyLcIb6u25bakTWoDtwnDKvtxr024JlCatopH7L8Dd34X7WohqPZwtG52uSeZhr9ybkdanm0LJo6kVVB2bRcVmpFqapBScBySBwDI5GW0Ro3Q66Su0NTavM8WV87Aoa9NMSnsygRiTNjb1Wkf6Mpy6jDiIMV1GAcFuj2utZSwxvxRQUhbOUnUZ+pHzHIa3cdYa0Q9yjgwtUVGkbwQf+6kpwL7DbaOVTCHbERopA46+Axh7wRftWvOF1+Vzm+y9dFsv7J4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6J6e5E1BtnRWYmuHcyD+vb1cZxYlJWRsODiD69EBalk=;
 b=qcm/wUypSDQWM5bCP+SAZJ52NvKZ8/dnckQmdBzz8Sl/DkHK2MCq85Ag/XrSqYboRpoyGrRi/jPM0tcGgnkVW/rv9gSnwEIrS0w0NRWqTSq4kgTDJumpmrs9Vxdk9y0qG4iASvKGemNap3v20d7PJTSaMe8Jq9Zp6R1d2jM3zso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Wed, 4 Feb
 2026 09:35:41 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 09:35:41 +0000
Message-ID: <b9dd733c-2dc3-4e16-8404-6f730b3ee1c8@amd.com>
Date: Wed, 4 Feb 2026 15:05:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260203065529.1360282-1-sunil.khatri@amd.com>
 <9e08715e-d63e-4269-a130-c1722241d96f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <9e08715e-d63e-4269-a130-c1722241d96f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::29) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e210a0-334a-4e8a-382e-08de63d0c32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VS91K1lHTG9Od2xFV0djbkY2REZkR01JdjVIOGtJWHM2V0tNUEtRRVNVTjVi?=
 =?utf-8?B?a29OWUZtTzVpdXBPYnVTZklZdGVsVUs5VnlPYzFWRExvRTlsUXBsRlpjYWx1?=
 =?utf-8?B?NFZZOUYxNlRFMFk3QkV3dmVkaUV0ZC9YL2RqaFBlL0J1U1FzODAyQnVzQ0dT?=
 =?utf-8?B?UTl6Q0k4SmFnQnkxU3Npa1VuOVI3Nys4L3JZN0tjamtBdm9YU3BwZ1ZPS28v?=
 =?utf-8?B?Y3d3ZzZwWm5rYmJCVXh4S1llVUZpdlo3aHNqdTYxYUxFaGU0SUtDaW1tOG1X?=
 =?utf-8?B?WE00STQ0N2p3bG9IeWxBd0c5d2FCbldvVXllcCtIYkxGVDZweG5JbUF4c2tx?=
 =?utf-8?B?Rm5wYVA1My8xT3dVM0hBM1Jwajc5UmZZaTV2SEtWYVNsWEo5Qk5kNTdXaTN0?=
 =?utf-8?B?eU0xSkJDN012RDRoRllHamswTnBVL2kzaVZPZ3IvaHBpenhjdWoyNTdPZ1VH?=
 =?utf-8?B?akhwUlRKaEpXMHFOUlBkYnNWRTdnQlZQUCt6ZUNndXpwMldMcDJOcVFoZnIz?=
 =?utf-8?B?UGJTT3ZlTHNjbkJybW0rVUR1YnoxSEovS0hpU1V4OVkwU2xWbEl4djcxUG9K?=
 =?utf-8?B?T0t6eXhrZFVZSzNJVHplcG5icnZrU05FU3l0djNQVEhQTC8wRHQxZVRKRUJM?=
 =?utf-8?B?NmVKV2ZLeDRLb2lVZER2d1JWUmd0V0VNMDlXVUlTTXFkeGR6R3FmMmhVMHE2?=
 =?utf-8?B?WmoyVUFBSGc3aFc5RzJLL0tVOEdaZjQvR3ArU2JENFc4WUNITXoxTFpwRWta?=
 =?utf-8?B?VlliZ3BmVTNRc2FYOW9wN1hhR3V0ODdkaVZWR3dPRVEvb1ZUY2Y1RmhFYjkz?=
 =?utf-8?B?RzZXeitSUFRNYlBxdDR2OWltNzMrNUVhaHR3Tmwza2phblpOYWxtNHBpdnNP?=
 =?utf-8?B?SmVOa09SaU5RYWRJOHptNnNvdFdQODBxTkxiakJaQWE1QTJFR1lja0w4Nm9p?=
 =?utf-8?B?bVlVSjFxNFlUOTBuMC83U1ZpVnpKcDhVWDQrRmJZSjNQT1VCcis5TGh3aWd0?=
 =?utf-8?B?K2xjaFBTeGlmZGNDVnYwQ2RHUDlGenhtM2FXV2lCZmM2R0dua0wxcmlRcGQr?=
 =?utf-8?B?bzAwbkhINXIrSVlscFF0UVJJT1lJcFlGQzZxT1FsbE5iNndTWGs2S2VzZzl4?=
 =?utf-8?B?eEYrTGFpZ2FneUhLYU0zOVRZUU1yYUxualB0azJMVHh6UEtpY0QxbTBHYm1W?=
 =?utf-8?B?Q0UxTTF1Z29WSzdCbnFjQkVwNWtjQkU2bnVENWtiZGh3S2pUTlJxY1ppUU81?=
 =?utf-8?B?cnA0QlhuOCsvUnpWMWp6cUNFTnBwZWFQR2Uzd29uOWVPcHZRNVVQUVdpMnlH?=
 =?utf-8?B?dWdOYnpZVjdHZjRZblk5YWNUOU51eWVMSGhPUENBQUExc2wvakYvRVNHZE5Q?=
 =?utf-8?B?QmtXb0hmRm5mSlhFVnYzN3d5V094WDdFT2ErU0VRTWpEYTZjR1ptWTVDdjl3?=
 =?utf-8?B?dzM2SkoyLzNpNmwzY3ZCNjc1UGF0dndiYmlmTVVxTU1pa20vV3RGZWF3enpn?=
 =?utf-8?B?VFh6OW1TQmNnL2RQTi9SZFB0ZisvNW91MzNIdTV3b1JGVFdUQUxTT1ZHQUt4?=
 =?utf-8?B?Mm9uT252SlEvbkRZYkFGSEprVGorUEZrNWVUNkFkeXhMRkloTnAyNUg2N3Qr?=
 =?utf-8?B?LytsZ0NMSmZGYjNuRU1aR1ArWHdnY0Uvb1lLU3pHaHZpMjlkY1d3SUliblBn?=
 =?utf-8?B?VElpMXU0RUp4WFVUUnBqSnR1dUxjZENweGNncld4OVZncmxGa2RFS3VQbWdx?=
 =?utf-8?B?NlFJcFNPUWF3cU44Q1VLM1R2ckFIejJ5VVpONkg2NTFDRXVnbnlnSzBsRWhl?=
 =?utf-8?B?Q25QU08xOHdLa1BiQ1NkbDM3Z0pubWc3TnR3QVB0K3N2bE9hdnUzNmo3OGth?=
 =?utf-8?B?ZjFhWmJ5QnY1M2ZLOVU0WHZDd0xqa1V3YWkyUDlIVDB5c1d0NXpPSzJaa3hr?=
 =?utf-8?B?TFJTWURtUlE5M2dtNjFTakhGckN6dlhNUUFZSTZMcDFma3JHYUN0bnpPRHZI?=
 =?utf-8?B?M0ZoMHhmSnJxd3Y3aVVrUVBtYmdWZzY5RkgwNm1MY25XSFVvYlpDajN4OS9X?=
 =?utf-8?B?YzBDQ0JtVGFKWktvL2xMOEJFQmtaU1BZdXo3WGVlUEJGSzFvV2FUVWsreTBL?=
 =?utf-8?Q?EoyEZ8fELQDDOwoatNNKd1VgB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9zTE1xTUtySndMUEFZZ1orMHlwb2lrSGpLY0gxWGEvdkMyNGZwUy9OKzZQ?=
 =?utf-8?B?OWNsNndZRHpqQ2phQW9qUXk5em5lcDRwdVhyS2l6N2dVVHlaODlwQWdYaG5H?=
 =?utf-8?B?VGQ0WWt2elRoNSs5TnB6NnYyeFVnQXMvVysyK29rWTl2ejIvdTlyanpCb2dN?=
 =?utf-8?B?cWhhc1NPSTVVdzRTdWZFWVFybUV2eklpZW5GVm9iMlhGQjNTcmx6bkVNYVZF?=
 =?utf-8?B?d092KzJzZkxGdXJoanJFcmh4UEw5M0xkVmxNWjJldTVoVzE1RjIyWURlUUxB?=
 =?utf-8?B?WVd3U09zdG0zRVcwdDhGNnRWNzV3VWFxMVJpczFxYjNZMGNOUGRNdzhVYmN0?=
 =?utf-8?B?cU9HcTlocDRSWFR6SGVmRnBmOUJNWmdpNDh0V01pUTZzQUhyY2I5QkI0SndZ?=
 =?utf-8?B?OVU2cHJoSUNrb1I4WFlDcGRKM0kwQ0NwY0U3cU1HZU5LQkRFVVlwU0lEeTc0?=
 =?utf-8?B?cWh5UVlacFN1MzF5Yk9rbi9qcHpTd3A5OG5sRUdpdUhFQTZPL3NyREMzWm90?=
 =?utf-8?B?TTRtd2ZxYnpVMTRRS2N3U2h3MzVPS0VZYkU0UE4zMERTdmFnN21Rbko0Z0JY?=
 =?utf-8?B?ZVdjbVp4ay9NcmVLdzN5ZjAyNDZ4VjFvZE12QlNVVDBYT2tRYlVXUk5RR2ds?=
 =?utf-8?B?dG5TaTgxcVdFajBoYXVGdHJQNHB5RVo5WTZOOHRUa2ZkSWN0ZlJlcWpSWkpa?=
 =?utf-8?B?K1JlTThRWGJNYUR4VTQzWjVtRlAzU0czc2RpcDRjZmRiMXo4Zmg3RG90ekRY?=
 =?utf-8?B?NTBReHhib25MMUtadDBPOExNVDBnS0c5ekt6RkdSN2NneU4vTmx1ZVV2Q3NZ?=
 =?utf-8?B?WjV1cVM2VjBvYW9OZHhEeFRhbFJ6L0xvQVlhbjc3amIvYllHL3dsUDhaditL?=
 =?utf-8?B?OXhVWkFFb0x0QmNOSWtsdU9iNktvekZ1OGtPWEVoL2tGbXlWWHIyRG80UW05?=
 =?utf-8?B?TytJYXhHcDZqZFIyaGRVb3RBZ3pCZmllNnZUbW9vTmpqcnk1S0Jjc1BDV3VU?=
 =?utf-8?B?Nm16L0VnM3M1b3NuUXIzR3E3VktRaTdnMFJlUFF6cElSMWYwM1JmNUI4SGt2?=
 =?utf-8?B?RFVjd05ENkY3REJQSFhOWHdSOUsySmR4V3BIQUJwMkM5N2JneFVKTnlrbWsz?=
 =?utf-8?B?bnJWTHJ6am9mOHRpVFlmMFZJNUxQZUFsZm9jMFpzcUdSQmJXQ29XYklidFBi?=
 =?utf-8?B?aXlHMVRGMG10MXlURUhGVjJ4TTlQS1l6YmJRQ1FiaHdXUXRJbnZON3RWa3Aw?=
 =?utf-8?B?VlJ5SS9sdFhma2UvUGgyL0xRaVNBc1BjMlpPQ1MwbzFieXFzQnVLQ3BwUVV6?=
 =?utf-8?B?WFhIMzFSQ0ZBK1pMNFZqRlRDY0hHVEpyeW5EV01id1crM1NnSFRnSVJoWE13?=
 =?utf-8?B?Tno4enZzTFZabVAwcUFhUlhhZFhHYitrSjIyUFFPRG9lR3FONm5oRW40SzRv?=
 =?utf-8?B?WXJSa2JiTE9yV2MxUWtHaUhTOVBtU2RtK3JSNUFCemsrcXdiZUh5ZUQ0M3Jj?=
 =?utf-8?B?SE1ZT3pBWXF0cXVRdE13RDVrOGlpUkwrUUY2M08xSUlSRWpVdTM2dEJqOHA3?=
 =?utf-8?B?WnQ2YVhIVmtYc2NNMzU4MC80M2NxSDVjSUtuUGhkZkQ4RlFEa2ovS0NINmRC?=
 =?utf-8?B?YUxWN3BibkN4MVFib1BzdWJoT29nam9qblhjREhNbmg4UjNUYVdLU09xMWZO?=
 =?utf-8?B?VkJ6dEhmZnN1OENWRGMwZHhqV2hSQlovYm1wdTlGemdtV25SYVBZQllaN2xi?=
 =?utf-8?B?RHZyODJaekc3VjcxcWRwekw4TUFCUkxqaERSYzQzUVVlRndyT3Zld3FxL3Bs?=
 =?utf-8?B?U3k4L0RhaVJZS2cwcmc5eUN3bjJsVEZxcGQ3NXdTWWNuL1AySFM1bkk1TVpr?=
 =?utf-8?B?SWY3NXl5Y1FCNzhjVFNCSTRTMWRJYzZ5TmFMTGpMTURqU3ZaeUduQ2hLcEZy?=
 =?utf-8?B?Y0RCV1JUSUN5cUkyTXd4ek5ha0VMVWUrMmFqN1kyenMzL3dKeWM2SzFZQTJX?=
 =?utf-8?B?M0MxakhoZWJCTUVTaHNsbDArenBSTkMydjZORHlqcktINzMwdHp6czhsSnls?=
 =?utf-8?B?NHNWT3YrbnFra3FkSFVGSmJ6UXdoY3h6MVZKaytLMXpGQmg4R1d4czFRblpo?=
 =?utf-8?B?d044NlNaQS9pMi83a1A0UFpnYW9Nb1gwVG9KRkNFMUZHNUdGUGFiZUMxOStX?=
 =?utf-8?B?L2FNRHhXT3dTUFdULzV5L3dWQklTV3lOKzJaU0J2eDhSRllLdzhqbWx1Tk1W?=
 =?utf-8?B?ZFVQejdYcndJUHZuZEN5SzhXVDZRN3A5dFcycFEvSGdYcElZazZkb01oUmpN?=
 =?utf-8?B?QUlDN2RNdms0NlBrelhGUzNPOWdIUHJyUk9HRmk5cnFpS1JUUHllQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e210a0-334a-4e8a-382e-08de63d0c32a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:35:41.3294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfyHa7IquHWFsGydqcguJNTXIImr2yTwvdcirmt1BM4pPrE5LHqee4smRVHNjySnWnKiOOJwBn+cbVEMNBrr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
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


On 04-02-2026 02:32 pm, Christian König wrote:
> On 2/3/26 07:55, Sunil Khatri wrote:
>> In low memory conditions when kmalloc can fail and hence
>> we need to clean up the memory and unlock the mutex for
>> clean exit.
>>
>> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> index d591dce0f3b3..831063971f71 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> @@ -892,8 +892,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>>   		struct amdgpu_bo *bo = e->bo;
>>   
>>   		e->range = amdgpu_hmm_range_alloc(NULL);
>> -		if (unlikely(!e->range))
>> +		if (unlikely(!e->range)) {
>> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>> +			amdgpu_bo_list_put(p->bo_list)
> The call to amdgpu_bo_list_put() is always done by amdgpu_cs_parser_fini(), so that here would drop the reference twice.
Ah yes, i dint realise it is freed in the parent function. Pushed V5 
with final change as expected.
Thanks
Sunil
>
> Apart from that looks correct to me.
>
> Regards,
> Christian.
>
>>   			return -ENOMEM;
>> +		}
>>   
>>   		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>>   		if (r)
