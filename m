Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0559EC25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 04:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBEE10F206;
	Wed, 22 May 2024 04:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FCb6iOyU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671A310F206
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 04:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPXeiN5Q9vfay6BBDiDbxq23kvCFIK37zpnVm5yLuUTEjcVBD/6wyuD9gdZt4TRfC3ZCXTd/tqcbjbUU8kjObeJGCv9nuVroYwG+/5Oo79SUjTrSfYnUb8QO8Pnfz0NT+s/g6+VP6Ktx7lKxdeU1j2uesEpA8JpWyk/5Cdlx0W34xaQTrR6EFHkQVha2KlHfpFBmYJmw9Q59QJIz+BZ0rRxe0CT2gsrPryPGEsVKFGSHrf1N1AYmUxwa/Zd6rm+EttVkZhu8j0fXzZMIIEWsILzX2QIE8fHPU6gCZ4hku+paFOMpN+abbdIkltTMs75YXUUTZYtPqj0Fd3kFX1AhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HcRA5V7EmxGkbx8MrQ+F03vs8mg10hBJMMGEPGIrTM=;
 b=ANwXrF9TuXOOgNQ2AvEYHr0MI4Ce+b2j7n8bgGAsON9AauIIpv14Liqremdff7JUNao0JAKgibiJ7S1AYvS6LiHiqdCFpcuBtv0Jg/vlhDVKDMC/DzlfyXMKgB34i/LYpyCXOP2i8LkrNiz//Wn8Ajm7T7FFgkehn9J6SbB6GWJOpFAAbsQkZGSgsImgC+cRuvbpLfoR48u3xtklbt8tRR3gd6DurSbk+cIPkOkO4wkGVMaZabXeHKbkyEm1hQAHTMWONd97naDwacyhiE5UlIaYVj3TnTT7FEBSgUMrAdrkL5GIo3qm2m89hPA0l7XO8invG0a4QihfD7NajQWULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HcRA5V7EmxGkbx8MrQ+F03vs8mg10hBJMMGEPGIrTM=;
 b=FCb6iOyUrvrDQ+CfI/SwCFIWK+DR1weHPKLr+r3xiVXNt0/M6rq7eXe5KJIvrQ7C3rAmc4IKWbzc+rFUfBndsC+ZqRlKTkHc7j8VTRDV7TVHhUyKGHrOXQV/mCdrG8ZMdYVii5/RBsIyQflyLE8vASNRVStFUzm506Fj390+gYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY5PR12MB6154.namprd12.prod.outlook.com (2603:10b6:930:26::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Wed, 22 May 2024 04:57:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 04:57:10 +0000
Message-ID: <6f5301a3-acf9-473a-b98f-8991a97af9ef@amd.com>
Date: Wed, 22 May 2024 10:27:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
References: <20240521071615.371277-1-jesse.zhang@amd.com>
 <1d4223d3-b4e5-4c02-8da7-ab87406d5cc3@amd.com>
 <DM4PR12MB515252901B1002704C2B56F5E3EB2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB515252901B1002704C2B56F5E3EB2@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY5PR12MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c63079-2d3f-4aff-819d-08dc7a1ba33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnNSeWJqRHdWTFRSRzNOb290ZG9ENTdrTzZHWGhZczdkY1ZrMk41eVNiRzdX?=
 =?utf-8?B?QzVoRHY5RTExWm9oWGMxUEVkWlJ2cTJDUXRuRnkyUHhWM1pZRGtXY0JVTWtR?=
 =?utf-8?B?dFVTRE8wdnE5RVhKeUprSlNZc1FRc090WXhCc3hpY1JVR2huYWg2NXF3UjE3?=
 =?utf-8?B?QUdWSjFUNlJUZzRGdWY2VzBDYzdJNS9MQ29IVzdiUVZ5RnBVTXBPUGloVFdH?=
 =?utf-8?B?a1hNalk2SWNNZ3prYlE4U3hXS2wxWkkwTWVXUEcvNlFnREdlSzRQWWNybUpn?=
 =?utf-8?B?R0JGR0p5SEJpMkUrME5QLzBUZnZhbTAxYVl6UmdKUnlXUDVJWGN1bC8yckFM?=
 =?utf-8?B?eHdZY1ZRbkpOMFRqQmpiTEFNZU5YMXJQLzNUaWt6WHQ3QVdhNStUZG5YYnIr?=
 =?utf-8?B?VTY1SktPYTZVS3NiaUl3NFZlM0FkaEhkRU1kWXFIeGd1azh2ZkNWSERpSHlQ?=
 =?utf-8?B?dllHVEw1b0lqcFVsY0NGWFhaSFZ1dHlxSFRsL1c5VDMwVWlac3g4UU5yYzR2?=
 =?utf-8?B?OGt6WVQrWitaOERzYS9kYXFRK1hrRTVFamZSbnpoVk54TmI4S0ZTREgvSGJu?=
 =?utf-8?B?Wk91VS95QnVOdUdmLzJwT1FpWU05ZFljbVE1NWs0VGdDME1iVnBad25FY3dV?=
 =?utf-8?B?Nm8weGllY1psWTNCN1VYQnZ3SC8yY3FuNGs1ZDNuUWZiZDNtZDl6L21kMVhW?=
 =?utf-8?B?OUZ1OENndFZ4VE53L3Z5US8zc1pTZVBpaWt6ZmppeWFVL2k0ckdpUkNTbENN?=
 =?utf-8?B?ckZwRVhOWXBTaEdiVSsvVEtxN0ZUeUxlajZwb294V0lvZ0QzVTlna3o3aWN2?=
 =?utf-8?B?a0tHck5RaXVkdy8vVjlvR2FkY0xXcDM0MEtpQnRTRTB6RStvZit3WnJjWGEv?=
 =?utf-8?B?MUtrV1hNQ2t0K3Z4VWR4dDRmYXRjeUxuN0c4dWQwVEZvR0pyOFNKSUptZ2lk?=
 =?utf-8?B?eG5QZUN1M3Rkc2NxTVFkRlRjL0ZjMlZaM2xjNXprU05hOXhTeXBkVkxUd0tL?=
 =?utf-8?B?Z3BWb1BVTDNvemo1NnROSTJ4TlUxZjU5Mldvc25uMVFOL3owU0p3SXh4U2Fj?=
 =?utf-8?B?dGZZKzBiN3I4ZFRyMFZyYTV5cGRJdXBHSHdJdW9QZVYxdEtnVTJ2UmtBUUlT?=
 =?utf-8?B?N3V1Y0ZFU29UaFowc3FrYzRsYlJvTDd2WFhhSXBTTUdIakh0cWhCWkUzVmhE?=
 =?utf-8?B?a1paaTBzeDh5ZmI4NzRVMEV6YloyWkZVWmx6TDE5TjJydXY0N1VNNjg4Wlcr?=
 =?utf-8?B?VFo3RkVHUUFhKzk5SWtPbWJlWW5sTktUZlZVMWtwWjlpREFLMFZsVFV2SEl4?=
 =?utf-8?B?U1Jmei9JWXk0VlVwNCtqTXZQMzJhVTBmWmJxK3orbTVvVjFVc0RQaXNSU213?=
 =?utf-8?B?Y2RYVWxqczVHUk5uYnpLc2kwd0IvTFNYR043NEhDbTZRWUhCWG1mWFVoNkZF?=
 =?utf-8?B?U25rVlFYaDl5Q3BKdDRWOG9VWGdkcjM1eCs5ZVpkVEhrQzJrSWlpQmd2MVY4?=
 =?utf-8?B?a2pKMVozUjBOdWJjRkJsWkppcHZVU2FUeEt4Zmd0cXdWMTJSQTlFeG4zek9m?=
 =?utf-8?B?NXd4ZDN6RU03QS9TMU54TzFxUGlmQ2JGemVZZmpYbGxFdXd4UEY3RmY4UUsy?=
 =?utf-8?B?T2xnT01tRVd2cDllK25FNXo1b2txUmZQVEk3RWpzV0p0RUxhM2ZBbXpYOFJD?=
 =?utf-8?B?Y1NQN0g3Qm5od3dGcWV5dk1STWpPYUhiQ25sY2JEMTdZV1dDV28xbU1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RWMmdjbnlkOVc2QlVCbk8zeG9BQmgvd3I5THRPeVA2TkZMdG8ydHZ6clRa?=
 =?utf-8?B?TWdtWk9PdXl2blU0Mmdvb292TnUvN0VZeXVDdk1wdUViMC82S0RCN1grb2M4?=
 =?utf-8?B?bnNtWTRXb2ovaERDUUNVVm04eFpRaWxuUWF6VDlEeW5sa1g3dEM4a2xTTkRG?=
 =?utf-8?B?bUI5UjZSK1c5Wk1KRHFNWXZwT0l3aGpZR0dwWHdRVG5PNmc3c1ExbWV5dHc0?=
 =?utf-8?B?VVhZZFlxVTZpUEg4dzJmL1pxOVE5dDRjSjhBSUJHMmFyaWpLckdGckFDNitt?=
 =?utf-8?B?NC9uaVlnQ0J4cVJWRnlKcEhWY3VRQmVUY0lTUnd1ZzBsYko3UlMrbHg3TmtP?=
 =?utf-8?B?M1lIRkJmOVFnb0V0anJLbldvTlVIOEJkUmZBeVQ0dHJxeUU4RTVUMDNlN1RU?=
 =?utf-8?B?US9pZDFtNWZRK3hSZHJPTnVYV3gvVE90NVZCeE05N1oyYjZlQnZyaHZzcnNu?=
 =?utf-8?B?UDdWRU1FR081SlhEWU9LNWlTdWd5OWFlM2VhdnlrQ29QT1V3QVplMFByNnMv?=
 =?utf-8?B?M2hsM3dDWXdtWm44NUlkcFp6eU1ocmpkRmp5ZHhjdnpDekdtbDZGdkRmZjRB?=
 =?utf-8?B?bW1vamhmMnZCTUR5Sk9laW16bkF2blIxeUpUbVdvdmdHQnFFTERLTWhMTkdu?=
 =?utf-8?B?WUVRdnVDb0lBTTY0cjNlTlF6Y0V2azFRUExjcG1za0s5T2hRdG40ZTE2bzVC?=
 =?utf-8?B?cWt4QXY5Vkk5YnRGTlZhYjlERC9NS0FidmhtT2UvVllDZTlacDdZakNoV0Jh?=
 =?utf-8?B?WXQwTXRzVEtxcWhkOHJjUXRPWHBnUmJmVHZkck81WVB3blpzbmdQRFZHTkVp?=
 =?utf-8?B?N2IwdDd2QWxDaHlFTC9HN2xFREVKcnhtY2JZOGNKellPdExUa3ZpRjZKcGNH?=
 =?utf-8?B?c3lzci83djFpS1dEc1llNVJZY0xKUXFwMWs0ajRQVjBPTnlSWjA2OVpGY3hN?=
 =?utf-8?B?cU8veE1qd0VPekE1M1YrMGRWakFXdU9yYWNqNDBlVG4rRWR1TC9oTzVJTzFN?=
 =?utf-8?B?bWp3c3FkK3c1TDFjTWZ6c05zZFh1QmJFaEZZVHY4QXIxMENWc1EvU2h0OVZG?=
 =?utf-8?B?M2J1TUprUCtQTVhzRDBzSHlGc3R4aTFZMnVZUWI3WmhlWGQxWjBRbEU4dVl2?=
 =?utf-8?B?ZXFjNUFCYTZLZE5td3VqcEwxS1IwSFVXcE1Fc1pKdGVsTGdrMytkWDJFMVdM?=
 =?utf-8?B?dWgxbzFlT2NFeG1udjhtdDFVa1lYcnVQM3FEUXpvV2NVSys4QUkvNyt3eFRK?=
 =?utf-8?B?SENwSVZnMjRiQmJjRTRkWTVrNnM1RWVrS0N5ZzIzVjNiMEE0SjU0RjZkaWJr?=
 =?utf-8?B?czV3Vmhvd2dmaFRqUEMyTjA0dHBGZDVsRm5KUWlpMmVOaVh0VmNrOE5hZlFl?=
 =?utf-8?B?UncyZkFZSzhFZEg1NDN4N0NNbitMdWNLSjB1akVKbi9iKzJ1Nmh0OW53S0tn?=
 =?utf-8?B?ajMwbFJmKzh0b0NzMWVZQ0RCNDBzcFNXMUQ5NFBnTDRRUnBhWExYZmdDNlVz?=
 =?utf-8?B?Q1BmaVhsVkhRVkpEbVpmSEFNSk80YTJ1bEFQZUpuV1hwdTZhWEJKTEFKY1Ir?=
 =?utf-8?B?TFN3L1I3OTRRVWF4Slk5ZFllWkNxRzlJL0trZTdMTnJ0V0ZkZUhYQVdCUkdB?=
 =?utf-8?B?SHhOTE4rcUYwMmF0M2tOaHJISVlKRS9leHFCblBFaHVuR01KcFp1VE4rK2dN?=
 =?utf-8?B?MzhLdW42SkRvZTduY2ozUGZxWTA4elp0L2d1YzlGSFlXVXNDcHBIT3I2L3B0?=
 =?utf-8?B?dVRYcjU1cGUrcDFXNDdOTGR4QlYxU0UyV3BWTlhYQVNtc3FoWm9PYU8rcEZx?=
 =?utf-8?B?Vy96dExnaWdzTDFpUWZiN0FoN0gwdWpIUGdUaGlqK3c2WXhwbVNaUTBZVkFX?=
 =?utf-8?B?TTkzTWJiQ1F1U2FlZDFXZEpNMTBZTzhrVzFCdzFiTjRpWE1tNzE4aC82dDZa?=
 =?utf-8?B?b2U1c04xSkF0RjN2dnhRSzRhcFZJcHU1cDFjcjJJbStDWVZaRURDbDdLNisx?=
 =?utf-8?B?b2pHUWMxNVRzZ1F3TnhvZERPVnFlb3hBR1dIWnEydFNUNkdZYUIrTGIyNjRZ?=
 =?utf-8?B?R0VzdExKdkFySFEwOXNrRnZPRDBJV1MzOWM3VXh6VG9VS0ZNcE5DdEtkS2JE?=
 =?utf-8?Q?4Ks5RYI0XVa8wknz+hRubavq2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c63079-2d3f-4aff-819d-08dc7a1ba33f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 04:57:10.5243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRtuCQVO66hV/4V98FgbvXP1a0KQEBONlwc+S1xQ22zAPzuuW+iYYF5cU0K2uksL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6154
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



On 5/22/2024 7:49 AM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, May 21, 2024 4:20 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: Re: [PATCH 1/4 V2] drm/amdgpu: fix invadate operation for umsch
> 
> 
> 
> On 5/21/2024 12:46 PM, Jesse Zhang wrote:
>> Since the type of data_size is uint32_t, adev->umsch_mm.data_size - 1
>>>> 16 >> 16 is 0 regardless of the values of its operands
>>
>> So removing the operations upper_32_bits and lower_32_bits.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> Suggested-by: Tim Huang <Tim.Huang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
>> b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
>> index 2c5e7b0a73f9..ce3bb12e3572 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c
>> @@ -116,9 +116,8 @@ static int umsch_mm_v4_0_load_microcode(struct amdgpu_umsch_mm *umsch)
>>               upper_32_bits(adev->umsch_mm.data_start_addr));
>>
>>       WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_LO,
>> -             lower_32_bits(adev->umsch_mm.data_size - 1));
>> -     WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI,
>> -             upper_32_bits(adev->umsch_mm.data_size - 1));
>> +             adev->umsch_mm.data_size - 1);
>> +     WREG32_SOC15_UMSCH(regVCN_MES_LOCAL_MASK0_HI, 0);
> 
> cc: Lang
> 
> The original programming and the new one doesn't look correct.
> 
> I see the below field definitions as per the header. As per this, both LO/HI are 16-bit fields.
> 
> vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI__SHIFT
>                                                              0x0 vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI_MASK
>                                                              0x0000FFFFL
> 
> vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO__SHIFT
>                                                              0x10 vcn/vcn_4_0_5_sh_mask.h:#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO_MASK
>                                                              0xFFFF0000L
> 
> [Zhang, Jesse(Jie)]
> 
> The code seem to aligin with Windows side that have same issue. Here is the windows umsch_4_0 write register regVCN_MES_LOCAL_MASK0_LO/regVCN_MES_LOCAL_MASK0_HI
> 
> enum umsch_mm_status umsch_mm_engine_init_unsecure_4_0(struct umsch_mm_context* umsch_mm_ip) {
>                 ...
>         temp_data = (uint32_t)umsch_mm_ip->umsch_mm_fw.ucode_info[fw]->data_system_size - 1;
>         data = temp_data;
>         umsch_mm_cgs_write_register(umsch_mm_ip, umsch_mm_reg_offset(hwip_info, regVCN_MES_LOCAL_MASK0_LO, regVCN_MES_LOCAL_MASK0_LO_BASE_IDX), data, HWBLOCK_VCN);
> 
>         data = temp_data >> 32;
>         umsch_mm_cgs_write_register(umsch_mm_ip, umsch_mm_reg_offset(hwip_info, regVCN_MES_LOCAL_MASK0_HI, regVCN_MES_LOCAL_MASK0_HI_BASE_IDX), data, HWBLOCK_VCN);
>                 ...
> }
> 
> struct umsch_mm_ucode_consts
> {
>      ...
>     uint32_t data_system_size;
>     ...
> }
> 

Thanks, checked the MES spec. Looks like the mask field definitions are
wrong. They look like copies of BASE_HI/LO fields which are used for
keeping a 64k aligned 48-bit address.

Anyway, the mask fields are for indicating size of the local heap/stack,
so most likely won't require usage of MASK0_HI.

Thanks,
Lijo

> Thanks
> Jesse
> 
> 
> Thanks,
> Lijo
> 
>>
>>       data = adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ?
>>              0 : adev->umsch_mm.data_fw_gpu_addr;
