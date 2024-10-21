Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14BCD0E6D9
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 09:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6638310E473;
	Mon, 21 Oct 2024 09:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hsj9Etys";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B2810E2D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 09:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpYGZq/M7hzrQwcjn18duiJEuBMq/q5EFbR8tFNL9f5Zkdusz/ib6EmgSWFPhCH0g6wwHh10vrXLvYc/+pAScbLVkEn6NCD6FVWAlt/2bPyA8aBgK5vWmC9ozbiWwKYRloM1Hz9wJMdfN/TONzf0wgobbQPHQt8YS/bimO9djnRgBIuh85VRrvHCIfMw0J9KGGIecxbcZ6vlFM7rdaIlvsaftnK4h3+xTByp8egdXye5VZmg3Mp6J0oYVAynHHwCgAg5He+f29c6dIk0cZEB9/bI2J9vGswQQkbqTvUmHZm7c/frteNF2A29nIvx2vRSs2NbEZJwUbbOvPQmYWbVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M4/B50Fv8DnRKSmutdzgx8pqXYacRouu/WzRW2ESHg=;
 b=ynZFdTivNOw9ZZL/+18TjR8YAVNe6Bu56j/Ipx/JsGV5cQD8aMQl8nhwh5VqAHdpSAbLkt0HOEUpFWgmJWwfiJL0vNX/Ktbokhoq4hySp6XVpiDAsnzFGX+r/ZaaO4/ZE2Qzd2A32CmYH7eYhKCA8B1e/fvBVfLRp21OoDIcPLfgUV8okobL6W70vv2HknLSC1Tf7mY1H6vcLx+KBgb7AlC7aR/joUXpv3/3D7ZPkOjahNIJaphUQHC16dF5/SRnVYKaXttl0JsHgfTYtyiNDdFXFbhmBmUgmlV87tRspazbWPAhRj7XTQQ8xMrA8MHXLkvwYm3WYRTk5naMfPbygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M4/B50Fv8DnRKSmutdzgx8pqXYacRouu/WzRW2ESHg=;
 b=Hsj9EtysiPTW5mK9TbiEwOTUf4RBjVEXvDyy3CiBXXDNF1vjq69es54t7X+4TTEIFSaPI92RCugrLAnHzD5oafSlgCJCBaR28oX9vFS50n3UlHoaiwz6MqT5sx033m/0sTS2XNlmBo1KtE4vGeyGPDF31yGxeBHSt6exWDfJsBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 09:55:04 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:55:04 +0000
Message-ID: <9934a196-f36e-47f6-a39a-4760503591bf@amd.com>
Date: Mon, 21 Oct 2024 15:24:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add gpu_addr support to seq64 allocation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Cc: alexander.deucher@amd.com
References: <20241018132629.190295-1-Arunpravin.PaneerSelvam@amd.com>
 <c7f38b09-133f-444b-897b-ab628c6ba51a@gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <c7f38b09-133f-444b-897b-ab628c6ba51a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|MN2PR12MB4159:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b948b6c-ad8b-49cb-b736-08dcf1b66f78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUgyQVVGbmxKZmtQTWhtTWJuZW9EazFkcnVZNzlydDZjelg1ME1xTC9kK0Fm?=
 =?utf-8?B?QTlsR3htMzQ5VHFwcUd4dHBQTThpelVselQ0TjBIK1Q1Ymt1UkRxUjNLRHgx?=
 =?utf-8?B?TXdCUUM2SUN3bWd1TTY1NmlvcGVJUXRXY3ptWG9OaXlaN2Jqc0JOMTBhQ0NS?=
 =?utf-8?B?d3A0RXdVWWQxRUd3UEIvbjMxWUc1bkJ4L0VmUkI3NTFCZ2FpZXcyU2ZpOVlq?=
 =?utf-8?B?NzF2TVhWNld2NHIreXphbHZvSk9neDlSREhDak5RUExWTHFkaVNDWjJXZFRa?=
 =?utf-8?B?Q3o1K2tUMDlRZWVGTmw5VDZRUlZRTWJXZFZkU3dOY1UzRDlnN09FcFYzYUlB?=
 =?utf-8?B?R1BMa2RGQ2pBV2E2S05KQ0FrVmtWNEtRWEgrcytNRlQwMUQyTk5xNDdJdHc5?=
 =?utf-8?B?VkxrV3FobVNkanAwQlN5aERZQXNIejNYTlJUeDR6aTlsQlN4V1hGN2VkcUZk?=
 =?utf-8?B?TDRkdmI5YlBaNzM4YlExVllYa0VmMFBGakFnODU2NElRTUVUejRYM2ZsTk93?=
 =?utf-8?B?NzFYd3liL2F4WGd0Vk8vVlBDMG9TRys1QWhyRUtXblZkUk41cjN0YUc3aU9t?=
 =?utf-8?B?dGlyTG5MeFVDc09EOHNRRUtyYTRoUkkxQUFGNW1UVjY4OStINjgzbE5DdzVn?=
 =?utf-8?B?WVltcUd0RmJhbzR5a25uN0FURjE0ME5WM0lqd0dXZG82NmlNdnhRSGwxZFBO?=
 =?utf-8?B?em5aZGsvRDNpRlZ4ODNpSWhOWDkySU5jV1I2dVhXWUl5RmM5YzZQanpnSWw0?=
 =?utf-8?B?TXN1RXd5djRybUh2VGY0VnRESEhVK2JlQmk2S2xmbFd2S3BlWDRVbWN4UTBo?=
 =?utf-8?B?Uk0xQXl5RlZSb1lwTGs5WDliNHBZUXR6b01yNXgwM3JZd1dZVmFWYTRTOWtJ?=
 =?utf-8?B?V2JIZjdxRnRYMGlQTnlib1pjYjV3UHpHNXduZlg5M0doWEtMMU1wWms2cEt3?=
 =?utf-8?B?Y24yWDN0WmxZVkp0cXU1ZzJ1Mzh3b3ZRVkZHc0lOMVhmM0VVb1FDVTFGaksr?=
 =?utf-8?B?c1A2cXlDMDdRYkZGS0ZMdVAzaDBBcU00bGZ4TWhPT2VYYzhFMHI2cDVzeURN?=
 =?utf-8?B?Slh4ZlV5Sy9MZFJXNmN5ZDVZc3hmUVBXbDBRaFJIR0YveTJrVTZTK21DdGlO?=
 =?utf-8?B?QVZpbWNudmpTc3NpR1U5WWJJd1RGcTQvUlZGZVg1V2NFUlU4WGxTYTE0YXJz?=
 =?utf-8?B?WUdJVzR0bEJxS2d2UUxHZHI5T2NxT0o5MHJtTGZIU2ozd2dmVFlGVmlVKzZT?=
 =?utf-8?B?VkJtVHBoNFVoNnZ5Z09GU2hlZ2taVWJUU1pkeHB6MURKdkdHVEY0UlM2MTJN?=
 =?utf-8?B?Rm9GelhDTGNLc1E3a1dQQkRsd082Q2U5SlVIOFRyOVFBQnhWZ09zb3pSQ1U1?=
 =?utf-8?B?MUk3d2lWWHVFNUpTbElwTXJrNnJJbGo0dkcvU2RqS0hzVGdqWGIrY1VhRGZL?=
 =?utf-8?B?ejByY0EwNWFXNHJRZ2N4TmxZWk4vNUtzZVF4YlZuaWQ3N0FEcVJWbm5ubmh4?=
 =?utf-8?B?Z1g4Vk5yNGxlRVE1ZS9GMlpCUjEyZ0treHIwOHBlMXhyK2VveTBHVHovYkxX?=
 =?utf-8?B?bWFIOXdUc3hGb2lUQjNYb0hOWFM2SUhPVlhsN2V1aUhUR3U2ZlpRZ3F5Umkr?=
 =?utf-8?B?SkUybzV6eWt5UGY1TTFrT29PdG1uaS9KbmJPbDlFOFpwNWdzYUQ0YWh0VU1L?=
 =?utf-8?B?VU5MRjBTWkdlTzQyck5nMnJzdHpud2ZHTkYrTFZMeVlKdzNaZnZYeFNoY2Vy?=
 =?utf-8?Q?gGoiENNcsf9NO+bZgSPPyPXim2dsLpSJ7BwJLzs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG9Lc1ZwYXkzVHQ1MWg1bUNHTVB4V1RvVThuSEpTamxoREtaZEpITTUzYnJD?=
 =?utf-8?B?U2VIcnQzbWtUdnVNWUdKWkcyQndkajFyQUh5Z3hLSmVSeHAxUnJYRW9OZkhm?=
 =?utf-8?B?TFBTS3JFL3JET2ZQdFdHVjdHS2NrQk9NU1A2NEk3V2dwOWdLVWxzM3pxb0Rz?=
 =?utf-8?B?dVFpMWVDZXB6UnE3UURWNjI5MFhPMWdXQzFMR0ZBQVE0SW96VFEwT2VqUklD?=
 =?utf-8?B?REljL1BxajJDUXdGSHdXQXpzV2JCSGJVUGV3QmF4cFFqbktWT3lqeXJzNXJ0?=
 =?utf-8?B?WnVWVjJXRGhpSVZkajk1SjdGMDRiVkdldStuU01IOTdOWCt2b3hMbE5ndU11?=
 =?utf-8?B?Z3owSUFTMFBpZy9FclpSWDdZc3VvankyRFRlSnR1cUlmUnkyWnJTVlE0WXBJ?=
 =?utf-8?B?MVduR3lGRlYwaGZpWnZ4Ni9DVDRPWGMxckhoY2wzdnBBSWNtQzZScEZHbDZW?=
 =?utf-8?B?M2o4eDNVWU5hT3pueG9TRE5aKzZUNWRLcHVHRkdjdStSejhKVFNLaGpFRWw5?=
 =?utf-8?B?L0pCNzhCejAwbW4wNTRORm1VQ3RJd09TNjRLWmNITGZOeUxkOTZWZDlXekx6?=
 =?utf-8?B?anpsbGdWRnBSM1JRSUo5ODRubENvMlVNOEF2Y2Q5WCtaNmUxRXptbTc0cnFU?=
 =?utf-8?B?MDk3OFhwSHkzQWxHVTJ3dEZWWDkwK0g1bi9PbGhzYkxtWG5RMk1nSWZSL3lB?=
 =?utf-8?B?LzBiL3hxTFhDckpseDJZWFRoYTdncWxGUWZnZVVjWHFFQ3Vyb3F1cUI0cHoy?=
 =?utf-8?B?dkc2MTRqNWdwQUhYQjFFRW5HK2lmM3VFSGVsTGVMUThJc0hvTFZEMEZuWVFo?=
 =?utf-8?B?NTAxY3M1RHBSMUF3WUxyTUNlMkY1MWc0aWxCK0RVVk5OcGh3N0RMdFdreitm?=
 =?utf-8?B?dHAxZXo2VGdVT0I0bkhIL3RUaTRnaDc3ZWRITy9pbHZ6cVdwQzRQTURiTEEx?=
 =?utf-8?B?Z1VVTUdEUjQ5a1BXNzRkcWJtMzZqVDE3VUlDRFR2eVR0NnBBbFozS3J4c3F4?=
 =?utf-8?B?cXpYRDlhWTdkNEg0WldPMEMrNW1JRUdpZDk4azdJVXJ4SE5CWC9Vd0hGYzd5?=
 =?utf-8?B?M1BmeUU0UE8xVFVyZTVRVHV4VldyR1owMC83N1Y1QTdFTHpUbks2VXl5bmFi?=
 =?utf-8?B?R0RtMzVyWHlmVmdSRUY1N2xXamxyRmYzdDkyQkFwLzJuSjJyS2ZKSW4rbkRl?=
 =?utf-8?B?MWtRaVVEaGZCL3VUeVN2WDQzZEV0bEtYZExhQkVXTEhxSUlWcDkxQmE4VzhO?=
 =?utf-8?B?aVFrN0JhLzI4UDhaMWwrOE5OOGV5V0JuZlZ5S0tTc0pqZzg5T0Y3LzFUYkRD?=
 =?utf-8?B?TkVmZ29qUkxCcEFsWjVIbnpJb3dwUkgrZDdoTEt1TXlKeTlQM0NrMEQ5UWNw?=
 =?utf-8?B?WXpTMTdMdzdVbjA3OEFoRnRYaXAzR1hzbnJzalZHTzVKZU4zckM0bHhXQUp4?=
 =?utf-8?B?bVBRVkVMQnA4TmZSK1RKOE94aXJlcEg5dk1KNWIxZDJSMlM1Q212VkVNbnBq?=
 =?utf-8?B?Z2hsNEhVU1dTeCtiYzNnMm9rQzFBckh3VTB2MnIrQ3g1YUxlNC9CWWJZY3NW?=
 =?utf-8?B?Z3dCdCsrYTlQY2xVSXV3ZTZZR1ZkbkFuUWtCL2lib3lSblRPR3d6ekhtc3JQ?=
 =?utf-8?B?eGhWQWJ2N213S2xGaG14NmM0V1lBVTE2MHhMMFpkbGQxMWpnUWd5Z29QRmRG?=
 =?utf-8?B?aDZQRnJLNmNhZHZTaG0xRVVlRDVaRlB1NWlJb05pWHFwakNoRzB0bVoxMjB3?=
 =?utf-8?B?N3pnUHFrbWcrNGhScnlvNi9rY1lDSVpkdmc4aEdKYllobjBEbGIvT2c3Wm00?=
 =?utf-8?B?aVQ4V21yNDRVZjlZNHB0WW1RNlltMW1JYTR6bWpCZWovV0lFMmZ6SW93RHBO?=
 =?utf-8?B?K0w3aEpXSEJEVjZnV1hVaEZnc3RZNHEwcHBRWlFDUW42TW50b0g5cjdzbkxq?=
 =?utf-8?B?WTRPTlZsWVhTQmtmMmRGUGMzYklHV051TFRNbkN5dVp1WUdQT00wMmVqMXNI?=
 =?utf-8?B?c2Z1OWR1N3JXUHBwVTlRdWtMMmMvdHpVSTYvWEQwcUxVNytBeS8vdmRDd0xl?=
 =?utf-8?B?YzR0R3VIOXhGclA0VkdzNUp6TWtSREFIVTg3QSs4WXJWU2FCMmVwUGtSN0JK?=
 =?utf-8?Q?k+3u2iJ64IAl5SYiD0pD2Sj+M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b948b6c-ad8b-49cb-b736-08dcf1b66f78
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:55:03.9624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNBLOI/KBrpIbInraUpXciRcKVFwkDtzmvbsD200trowgvUn4iQ56TQMznOVgiIOLwZEk64xczCOfCeJqqxg1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4159
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

I couldn't find other users except userq fence driver which are not yet 
pushed into amd-staging-drm-next.
Should we wait and push along with userq fence patches or we can push 
this one separately.

Thanks,
Arun.

On 10/18/2024 7:09 PM, Christian König wrote:
> Am 18.10.24 um 15:26 schrieb Arunpravin Paneer Selvam:
>> Add gpu address support to seq64 alloc function.
>
> Looks good to me, but when adding interfaces you should probably have 
> the user of this in the same patch set.
>
> Regards,
> Christian.
>
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 10 ++++++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h |  3 ++-
>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> index e22cb2b5cd92..0defad71044c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>> @@ -163,7 +163,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device 
>> *adev, struct amdgpu_fpriv *fpriv)
>>    * Returns:
>>    * 0 on success or a negative error code on failure
>>    */
>> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 
>> **cpu_addr)
>> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
>> +               u64 *gpu_addr, u64 **cpu_addr)
>>   {
>>       unsigned long bit_pos;
>>   @@ -172,7 +173,12 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>> *adev, u64 *va, u64 **cpu_addr)
>>           return -ENOSPC;
>>         __set_bit(bit_pos, adev->seq64.used);
>> +
>>       *va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>> +
>> +    if (gpu_addr)
>> +        *gpu_addr = bit_pos * sizeof(u64) + adev->seq64.gpu_addr;
>> +
>>       *cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>         return 0;
>> @@ -233,7 +239,7 @@ int amdgpu_seq64_init(struct amdgpu_device *adev)
>>        */
>>       r = amdgpu_bo_create_kernel(adev, AMDGPU_VA_RESERVED_SEQ64_SIZE,
>>                       PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
>> -                    &adev->seq64.sbo, NULL,
>> +                    &adev->seq64.sbo, &adev->seq64.gpu_addr,
>>                       (void **)&adev->seq64.cpu_base_addr);
>>       if (r) {
>>           dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>> index 4203b2ab318d..26a249aaaee1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>> @@ -32,13 +32,14 @@
>>   struct amdgpu_seq64 {
>>       struct amdgpu_bo *sbo;
>>       u32 num_sem;
>> +    u64 gpu_addr;
>>       u64 *cpu_base_addr;
>>       DECLARE_BITMAP(used, AMDGPU_MAX_SEQ64_SLOTS);
>>   };
>>     void amdgpu_seq64_fini(struct amdgpu_device *adev);
>>   int amdgpu_seq64_init(struct amdgpu_device *adev);
>> -int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *gpu_addr, 
>> u64 **cpu_addr);
>> +int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va, u64 
>> *gpu_addr, u64 **cpu_addr);
>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
>>   int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>                struct amdgpu_bo_va **bo_va);
>

