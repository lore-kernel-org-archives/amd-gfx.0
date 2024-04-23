Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC211C10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 03:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C12C112FF8;
	Tue, 23 Apr 2024 03:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J79X3Yd+";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1AA112FF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 03:22:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co2EDg3lJFCPeWImjmtpn8zY/Z519skMS04Fxtd83LC5se5kKaTP+97YQnxci47xpHA4FIlUzZE563Sv+x9/Vs+3YXeFbniwHVgmqNfqpITMP/7wPXl/nhoF0Sy++RWsBKK5guckt9BlNdeTuC65xk/CvSe/YdjiwwcNaI2agV6HMPOiFbsUGmcKDUwtCwrGELbEGQeZzNexpLRo/+3TO4SpGna+caK17juJ2KlShtU6vIEUPhTRjkIF0cLJfE5npm98tNS2DcQwhVI9ho6s78owOQqO3FSLoDo6wnOzTeNeZdtQ6Pg+4+i5eVJMUXsG+DPjB4dcOnErHLHnmSYZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zXmOA8zNHxdL7sZKHY9UKjXQ1HEoa1WEsS1NBiBih8=;
 b=iitfBOA3ZGo47o+aPb2ruBW/Za/0HkQEMf7emuU9f1md3tt1Vd0wxfr8pC7aD0haUqAWduZJrsNQks1C4FexoPFE2bOt2W37Vhr9ml2D/50gOXpL+QmHshX2y+Kt6tQLPMdLWtrJRwLdwh26DG3lbg+kj/Ki/In62LexMHRTug8ywKn2D5lskAzg5c5iqT04nbNAfbT96faXFIAMeCKrz4WzkmjbE60sVycnNQG0mLciWt1CIr28YpsCDxP+q/TMRIPsz8kX3sG6hGqHe7mjhm2VGUUlvCDvdc0UfDrSHdNG5R92UpLw9lEFlw7LWlnRkRaSpGY5MuxYmEbveNcZWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zXmOA8zNHxdL7sZKHY9UKjXQ1HEoa1WEsS1NBiBih8=;
 b=J79X3Yd+rum+16clQ9R10AzpTQJKDxlFhARs8HhduGGfv70Q1FoEq6syGLDkTrAyoz1zLPd5jo9S+Z3ClCTli/i2TgKY3ZjCIdv90SxR6bzssevdYmygm6fUA5/gCPEX64ULJSrrxoNZ/A6QDg3Jt0xh/7OFLmwlVMOYw9mVCpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 03:22:02 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 03:22:02 +0000
Message-ID: <4ec15568-dd29-45f3-882a-850531901364@amd.com>
Date: Tue, 23 Apr 2024 11:21:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Address kdoc for 'Enable CRTC' in
 optc401_enable_crtc
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>
References: <20240423015928.1622672-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240423015928.1622672-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 259d64c8-d600-4798-f52c-08dc63448ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXdUMjF4cE1XaHFWN1V3LzJ2UXZkZjVBUW5vYnZtVTRUb1djdDhIa1NNWFk0?=
 =?utf-8?B?dG5xVEsvQXk0N05sTnFFRDdsV3EyNkhkMk5CQ0h6VElDdUNDYko5VU5IYTAv?=
 =?utf-8?B?SEJ2YmFvNGRibW5McU1CYXJYRDJNdjVMNk1aUEtDZ0xNa1dzSGEyTWNneGRN?=
 =?utf-8?B?NUVnaGpDTlRmekRDMzdteFZjb20xWlFBYkZxUEQvOGIxbkxUT0tzOGZsSFVp?=
 =?utf-8?B?YzErSmVKN2pvOHNWM211YW13bHZQditJWjBjL1BnQVR4MlNDNzBZNDYrQ1JD?=
 =?utf-8?B?azBJVW9KNzZtNEdCeG5jdWtnVEdBS1VTallJWVlDeDJoTVNmeldWQVVINUpB?=
 =?utf-8?B?ZXhIa1A1ZG90SmZQN0ZZVzJXNUJNWndkNDhxQ3NXMlBneURyNU0zOUF3dktW?=
 =?utf-8?B?SGxuQkZiTGFGa0p0eGFDMEJUM2MxWG9nbmcrckJZUC8wajNScWczY1ZCQnUv?=
 =?utf-8?B?ZmJvVlVXWS8wWW1sL1VBSitEd2Z3aitSQnBtUGhDWTBEMTlkL1FQYlZ3TUZS?=
 =?utf-8?B?T0pnTlMvV0ZHVXFtNzlBZkNwNlpWN3c1NWtJYlFyR3Z0RExHVDlrV1pXb1FF?=
 =?utf-8?B?bGl5Q3pqT3EvdHRDeXVHamJlcEZndURaakt0b1Z0ZzlSQzgrUmJmRWlmcW5i?=
 =?utf-8?B?SWtiTTNTS1FwTCt6d1Vya3FvcnlhVUVyOXA0U25KNHgxWDYrOHhjbnZtZ0pn?=
 =?utf-8?B?UUthV2tYdXlqZmRSL1BpNENiWWQvUWtsQWdVMWpkemczVzVaRjlvcm5sV2pL?=
 =?utf-8?B?d09TcmI1R25ndldHb24xMWdZd3g2Ym0vN3dtek53ZmkyZnZiSFRhaWhkMGlq?=
 =?utf-8?B?d0d2azYvVEU2RVBCcG8vZmM2ckg3dmx4ZWR3OFh3d1grOHJiUEpKQXIzZFZy?=
 =?utf-8?B?MzJ6YW0vYjVScGxYcFowSUs4RWtmb2dDcUk3UnZsYTE3MmMzd0p1ZUVBWVJl?=
 =?utf-8?B?dlc0eVpkSDFMd0hOQnJzVWVGMVl4YlpXVUNoZmtmc0VpOWwwZ2pFaDMyMGFz?=
 =?utf-8?B?d08yU3d4ZjN6bzBNSEhxMVFCMW55WVpiM2pJbFg2aVJYUHRER1o4MGNoQ2ZJ?=
 =?utf-8?B?OHZERUVLWndjRHE2WW05RmlxTXBrRlluelcyODJFTzc1RkROL1BGQXpWb2lH?=
 =?utf-8?B?TjY1UzZTRVhFb3V5MHBDUzg3YzZ0Zmd3ODlsYWIzVFQ5UEcrN0JiSlowamJp?=
 =?utf-8?B?SDRmNndFdnpUQm5jQWpEV1JCb0xhWmQzdGhiMCszZjN2MkNITEdCWUN0c0NN?=
 =?utf-8?B?cEkyRFc1cllPV2V0VEUxV21qelNKUTdhaGlkVWc0SXNMK1BTbVhVa1ZpbzRO?=
 =?utf-8?B?czFEZ2phU2NTVkxuU3RGSG9QNEh2ZHpZUkNRZCtFTjU0WkdqRkNYbnlwQStr?=
 =?utf-8?B?a1NYdnFnNXc1T3RicFFQTU0yelFJSDJrand2VDdNcVB4dmpYOTg2VjlnUk5w?=
 =?utf-8?B?TW1ZaHRuQ0cwRllMS2JsSmI5NjRoRjdlZkFSQjI2THFKZVZWRXVBREhCODZo?=
 =?utf-8?B?VGk5eU8yZ3EwSlhlU1BsUXppSXJJdVlaZFc0WGNOYis2eDNkbzREK2lvWU5L?=
 =?utf-8?B?MllhK01HYU1nSXFvVXZiQnRMUDJRYTR5THVDb3lab3Zsci9mQW1MTW42QkRV?=
 =?utf-8?B?bkNadWdDMk1rbXpldGJlVi9VazB0MUl4bjJNVWpSQk1rdXI1YTdBRWM4eHlh?=
 =?utf-8?B?MFNJcVJUdGVwbTlJcEJIdnV4TC9UTFR6MkttT3pMd0RYUXp0SEdZYlB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VCtZT0RqYUpycVdWRm1FbUN2ZGo5Rm9pd3BVUEkrbi9WM2czb1BGZHphaW8x?=
 =?utf-8?B?UEhjUUt4aG5vVW5HNWdCR1BlSVRnOXBVZmFlb3dia3VyVU1hclpqbG5nMFcw?=
 =?utf-8?B?eitobU5oR3dJMG5uNkRZZlFpcG53UkFjWmhmNUVPcW8vNExvTm05SStnYnFY?=
 =?utf-8?B?ZEJLVFlSL2ZxZ0JHd3VwdGl2b3I4d0ZjTEtsOU5mTWNMa3drdXdQVTV6bWhX?=
 =?utf-8?B?a3NMTmVVaHIyeWlNcDJnYSt6UThwUjV2VWFyeXZmSHVDZHN4aDgxcHkvV3ll?=
 =?utf-8?B?aDgwbERYVG12Vyt3V0FiMkJ5SG4zcU1MT05LeVhFUEdqaTA3WEcyb2owUW5k?=
 =?utf-8?B?OXUwZGVOMWEycXZCZzNmSkdCUXl5cU9iYXMzTTRmNmU4VVo5WXliY0RmcWtr?=
 =?utf-8?B?N0EyTDNzM0E5eVRpUmRnVncrQTNRa0xKOGRIU3czTGkvZ3hkSzBNT1ZrZWQ0?=
 =?utf-8?B?ZExGVGdCN05NRW5wcGx3cmgyQ1ZxMStRbFBRc2o2a3FYamVpZGwyMFZPdlMw?=
 =?utf-8?B?eDQ2T2FVY1ZlK2pwaFZxNmdrMFpycWgwZVBXWFd4Sm9CVzVhMldpbmF2ZVYv?=
 =?utf-8?B?eWswODh2dUZLY3hwd2xYVEd5dXZPeEpEMEEvbDZmUUVVWENQYnAxbkdBVHFF?=
 =?utf-8?B?Um0yVC9oYmtVdTlyOWtlUVdLZ2Y1ZDROaUw4aWI1a09JN0VqNFRMYzhla2x0?=
 =?utf-8?B?WE1jWllXTml4cFJ1SXdLTy9HSDRwMW1CN0gxU3o4MzZYTmlBb2Z6VmRjcXNU?=
 =?utf-8?B?bmkxTFdxc3RBYkxQOEo3eitNNllZSktOU2hYcDNoUTdNTGJXYWRSVGo4RENw?=
 =?utf-8?B?Z2s2YzN3SlJhbGdJZWRjRTcyenk4UmRNVXVuMjY0K1I1WW9RZm56N01kd3pV?=
 =?utf-8?B?VG1nV3NwOXBZTHZzaCtJYkJ4eHNPT0pjNHpIVFMwV3V4RVIwc2daVUpvcm1F?=
 =?utf-8?B?RW92NndPbDlROGRQRTVVSUJpa3NOL096ektVRTRoNlpDdS8yTDBONjlyeHpV?=
 =?utf-8?B?NnY3TC9ORUpwL0JXMnIrNjJUZzRyengyNUUvdTRJZ1lzREtQQTN3bHEwNWRZ?=
 =?utf-8?B?N3lwQ0hSZkwxQmdaWHdxcElKUElpWHNKek0yM0QyTmprYlhaZGdJcWJSWDJq?=
 =?utf-8?B?MGVlRzhvelV4MnI5Ykl5bFhjSitkV0xsbEpSZ2pMUVhSOEFZNEx0dVZ4LzZp?=
 =?utf-8?B?RXBXdHlVaU5IWHo4bXRvZmVrcWN3M01RTXYxRWNSSUJNdDNWQWsyMGw3ZTNU?=
 =?utf-8?B?VkZtL2pqRkdmY3dwUTBRVEN0UmFkQ0IrUi9PQXozTGhWbSs2SzhGQ0FVQXA4?=
 =?utf-8?B?MysyL3NQLzNlRTVONFBjbXY3S3I2VzBBUWZtMlNDaE5LYVFiMmhJSnB1UWlo?=
 =?utf-8?B?ZjE5Z25rcmpaS0k4Y3UvT2lsN1p2NENxb0Y1NXNuc2hZN2piRm45Y0JybUdi?=
 =?utf-8?B?MEloaDd5L1JRWHJGbjFCMTE1Vys1N2VJZ0piS1lncFFOdFZwbUpUcVpKZUhW?=
 =?utf-8?B?aTRTcTlyVDVPWjlTd1oyTURpNkIrdjMwTnpLcHBOQjlHS3BIZTdFNTl2d01V?=
 =?utf-8?B?ZkpFNHRKeFVxWjR1djdpYi9WdDFOdzlvNWNQUVRVTWt2Z0FzM0p6cmFCN2pa?=
 =?utf-8?B?aGtBRDdvbUFXc1VXTDdEbXJxZlNKMlovMTIrWEFRbmRGcGZXOHBCMEl3T1V0?=
 =?utf-8?B?dXFQNG1lZ3R6ME1DdEVrVGx4dGJ4V3UzT0M3N2RBNzNRSHJYMFA2RTVONmRJ?=
 =?utf-8?B?ditzamZMUkJRZi85TTA2a3E5RmYzNWovZ1YxZ2V5NjBKQmFoZVpKSW9FdW9V?=
 =?utf-8?B?ejJTNnVYbjdUSEhVV0t0R29XQUhuSWg0T05VR3ZZb3RaVGpIRi9NS2FNbTQ3?=
 =?utf-8?B?a0F3Wkx6K0ZQcDVoUWllb01mM3JvOVBUU29YK1hVcWVoOW9MZjFoeXJxMlRG?=
 =?utf-8?B?LzZiTWFDVDZHa1FVNStSR1gwOXk3ckxEL0hySzdsS3VVSDlQWUxrOXlVMUtu?=
 =?utf-8?B?YTNFaDl0RGdCdi95azZiQlc0UXp4dWJQNTdQK0J1ZUx0d1VWSEdGSzduNVcx?=
 =?utf-8?B?Q0hCRWZWMElJalVkMmtZREEvbnVTcWFXZlRwQ2ptMlRYdmM4MjRCN2tJUU41?=
 =?utf-8?Q?iddF2gf0dXb1hrcIHR7J/KMyH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d64c8-d600-4798-f52c-08dc63448ad3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 03:22:01.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ff7SeePi5a87tJCXSglPCFSmVZyxKwfKDJwAPYyrxToGqQAGJLs+37tnqkqJZBahNpr1CR0d/2d6zy6CpoKYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 4/23/2024 9:59 AM, Srinivasan Shanmugam wrote:
> This commit fixes the kdoc for 'Enable CRTC' in `optc401_enable_crtc`
> function.
>
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/../display/dc/optc/dcn401/dcn401_optc.c:177: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   * Enable CRTC
>
> Fixes: 96c23c8cb3fb ("drm/amd/display: Add new DCN401 sources")
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> index 3c7b0624acea..5d65d8376f50 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
> @@ -174,8 +174,12 @@ static void optc401_set_h_timing_div_manual_mode(struct timing_generator *optc,
>   			OTG_H_TIMING_DIV_MODE_MANUAL, manual_mode ? 1 : 0);
>   }
>   /**
> - * Enable CRTC
> - * Enable CRTC - call ASIC Control Object to enable Timing generator.
> + * optc401_enable_crtc() - Enable CRTC
> + * @optc: Pointer to the timing generator structure
> + *
> + * This function calls ASIC Control Object to enable Timing generator.
> + *
> + * Return: Always returns true
>    */
>   static bool optc401_enable_crtc(struct timing_generator *optc)
>   {
