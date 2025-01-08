Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8089DE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 287DB10E0AA;
	Wed,  8 Jan 2025 09:06:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bGsQSkH0";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86B210E0AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 09:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8lDscoaMqDkGbpx1q1TOr1G0HLr39MRkqkT/8x45RV9ysTKuDyymg27t0CgN1WIiMym9YMAMAYGcsEncN28LVhXC1TcGcd82M+heHv9Fy71YYmfTCWcn58ozGPvzDCaN7+Safpho+HOD60MD6LdGTdVGUQYQKkl9ZrtFmaBk/nQUeVUSy9h45U/mD4bL7TxzBpTCJ7JNnmB1XxT3oWblk+iPJDDkfhXBlT8rirgm+dQHSUMD3rRHXl37alD1GH6bnkz6pWPPA/0gN/Qp+RC7r9/MhQ0EmvUx6egJYkztIX8rX6oxuZfF6AaFNTTadsDn/S/yYEL7bL2El2uJFUv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWECW42MtnzFLxsO25yw32YSBqFaCeSD1g5DUAPxdDo=;
 b=HyZATmYY1wsUCKmMA4kOPKJ+rBsSL6JOJWAlni72GWUkbhT4gsmNf/nxkf2lyzq3ykkpeizQo4E3Gwco9DNAVq0nQypYdNYpwAKownSLwYEp2nYSqIsT5phIhJO4CNgcNH/zV4U+TXfvhsMqMJJ3WYarJdLvKGPt2KNAW7uY2El5WxFQXAKgUnq5qiJrbFwqI60XEMlfXnzuIdWB4UL8o6VyLhVCALUUSMekNATt8wkl9wsNI64p6vDkM5JG1hXEj67/3k7TZCD5btmFcqMiUKal0N9aSO4beRKuY7j+G51og+dtcupzs1new3JSPTuErjhC2MLgCZyFOy9DGFVezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWECW42MtnzFLxsO25yw32YSBqFaCeSD1g5DUAPxdDo=;
 b=bGsQSkH0zIbx1inhcaXDHnWCM6hQoSQrJsa6TtHg7bvtgO4+30kww4VqbFoxNw94eGxHWzF968XXnl+YewXJMHPz3mLAEn0vL3tFvQoWVShPVPNgsi+5OopW3r+IhYfa3te1ObWuT4v3SkmREXDhsUplUlH3uDExiGTVCw+P9GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8098.namprd12.prod.outlook.com (2603:10b6:510:29a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 09:06:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:06:13 +0000
Message-ID: <41ad6823-3ec6-4b6a-9c5d-f85c368577a8@amd.com>
Date: Wed, 8 Jan 2025 10:05:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 6/6] drm/amdgpu: get rid of false warnings caused by
 amdgpu_irq_put()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, simona@ffwll.ch,
 sunil.khatri@amd.com, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <55f6e8e3d14c639d869a76adae932075b443685e.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7576d723-25e6-4a05-01c0-08dd2fc3b2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zzd5RU0wd2hZZzJ2M2pPN3JPbGNDVkg1WDVWMFRMeTJVbGF2VkpmRXNDZDdP?=
 =?utf-8?B?RzZWSmV4cms0UnpFN0hlUmxCT2UzYWRReWQxaitGNEVHaCtQZHAxNjhpQTlu?=
 =?utf-8?B?R0ZuZHRTMUV4RkFLYXZTRlJPUVBsQjUydHhwRnh0SDF3a0FKUmorVlpOa3k1?=
 =?utf-8?B?bjhqZ2RtU0RlZ2h3c2Z0VklYNzRhNCtrdzM2NnIyblQwZVg1UXh5T3Y0RjBG?=
 =?utf-8?B?NldiSXdtRmhIclgzL0xpNHpSckZmcWZlb05PZzVDOWNDbHN5Yll4YitQeWsy?=
 =?utf-8?B?T0FjRWkyWGNSOFdMdzZDNW94ejBHaEdCb2RtRVBBUTVDZDByc2Z0Zm5ZTUNO?=
 =?utf-8?B?VmQ5T2pZV1V4YmRVOTV5b3IrRDFOMElHM0tBUzRiK0lRWUdGcGRpS3ZNWTQ5?=
 =?utf-8?B?dXlQdnZuWENhM1R1L05GRFF0MWNpWElFVW9UT250UHpvUm1JamlPY285ZDdv?=
 =?utf-8?B?QlpzVDlOSmw0Qnc4SlFlMGdwTmZNbEduUCtidEpla2J5MUVNMWpJQXFIN21R?=
 =?utf-8?B?b3Z3MS9SWmNhR3J5RmJZS1NUUnhxamlJY0l4UnpMRi8yS2N5S1RueUpxcEJy?=
 =?utf-8?B?Yk9IK292L25nS1BGdlBoV3F0WTZ1anNDVmt3SXp1N3psTEtFVTM3d00vQXVa?=
 =?utf-8?B?ait5T05NN2o3VHNJZEVoUEZzenZ1TjV5ajhzcWJMTzlneisvYUlldlFqVmZh?=
 =?utf-8?B?cE0wZmc4dGUraDVZOUcvL3A5ZWV2N1dQRmsxZW0rTE50ZVpDQ0dHZnMyWTIw?=
 =?utf-8?B?VjVuWEtsUjVSc05rMGViNlRraytRR20xUFVlUDZaeFNvbjBkblBWY3lvQTJq?=
 =?utf-8?B?aW1Sb0E1RTVlUUY4cUE4YkdSUE5rS2x4NHdWcnRvMmlmOThDSE8wbzMrendW?=
 =?utf-8?B?Ty9UakhONjZ6Sm96QmdjdHVBaTlSTEVsSkRsWWN2akFLV3hCZ1dVZTEyRUMr?=
 =?utf-8?B?WXk0VzRlQ1UxSDVXd0hJYWVFZnRuc3I3b3haL1pOcm5NeXlrMEJQa3NiVzQv?=
 =?utf-8?B?QTVTK2NBbFhPN0NaVTd4ZWpsY3dBcCtWMkZxTldPbDV6ZjhOV05TWlNFYUYz?=
 =?utf-8?B?blZEN2k1Y3VxMy9uMHRZbHJoOHdMZGpqeGNLQVp4Vk54eUE3UzVqcUxaU1Jr?=
 =?utf-8?B?WnVjaUxJMFVyejhMdVdCL2d5eHIySE1nUFdxd2VIZ1JoR0puRzdlZVVhTC9K?=
 =?utf-8?B?cjQyb2RuV1UyUGxXc25QdFkzT3NwRzNncmgxaVNuOHdKREpOMnF3WktEZnBy?=
 =?utf-8?B?WnpzRFBUSERQaWNENlFBL3NqT1RZSzF6eGZ6Z3dQWHRBZnRvRVVlUGV6V3R4?=
 =?utf-8?B?V3Y4NlU0eHc5Rk0wYVlsTHF2cnFqcHArcjRxREViOGpJRHdXOTMwWlFwSVZG?=
 =?utf-8?B?VGkxN2VHZ0hySjFMZlpURVBNNFp3RlNnNDJpNUZVSGxONTRwalI0bDdSSXNm?=
 =?utf-8?B?aTBUb2JSS0g3UUhDY0lQejV6K1JrRVdRZ3V4cUVMOHFQK3JxVmk2akhvVEs4?=
 =?utf-8?B?RUhGbWNVcXZWaUpaU1ZBTERYVUY1VHNxc0lMSmUrSFdmekYzUWdBU2VlYU9J?=
 =?utf-8?B?VVFGMUl6VVFud0pyN1JPQ214bHhWeVFiWDNmcnRXb2tlcEpxM0VDNHRORWlo?=
 =?utf-8?B?dTNYeHhKLzMxWUdqdUZYajhYRitHWFoxUE9QRjlwT0xpV3lXR3dkZVNjL21O?=
 =?utf-8?B?Ynl2RzhLeG9USHlYdmVlYWtJM2NKZmZsa0RUbmVJRklpcmhjRGgvT0pyaXB2?=
 =?utf-8?B?V2ZTdnh1SmRyOG9Bc0NuWE16ZlFtZmQrT2Y1aHE4dXVoMHhRQmVWRDhJNDlH?=
 =?utf-8?B?ZzJQUE05OGsxT1BPWE05SVNvZDUrd3hDc2RYVVdtY24zRGJVMzRGdnNGWmFS?=
 =?utf-8?B?bU05dWVGVUpyWGhIWkVJNy9TN0ZFV2FiUXN2UU9ZMkZhT1ZuZzhIdUpiZjFx?=
 =?utf-8?Q?0DxIho3wbak=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFR0bE9GQ2ZWYTNyMm5WdTRTbUlUWGt1eXQ1WlRwdlVPanZiMmpuKzRyZmZU?=
 =?utf-8?B?K0lnUzBHMW1WK1FlbHZBaTN2VmNmTm9WN0dvbEtJWU53NG5QMHBFTWVEZU05?=
 =?utf-8?B?ejRsb1ZFNTdraWsxUXdZdWU1Y0xLc3FkTXRNREQyY3RRdTBVOG1mRzd6VEZq?=
 =?utf-8?B?TlJlMUtYS3JCejIwT0ZreEN4aGJCcFdpUDNwa1ltbWVkbWhVbVJMOUFRK3Rr?=
 =?utf-8?B?SkMxUjBkRURxNVlQdG9QL01KU2ZaVVBiUElTT0pQQitHb3hwQVNua1doclht?=
 =?utf-8?B?aXUxa0FsS2QxZWpwTWQzeEVoY3RTaUMwZU5HTnpHdlZwaVhMZnQ5VjhVUHdB?=
 =?utf-8?B?aTFuRVBmVjE0dTdIYjM0TkZMRWluNHBGY0RCNmpodGxKQ0p2VlNhRlVHQ0Jm?=
 =?utf-8?B?ZEdxbUM0NjFZcTBtdnU5SU4rUlpwbzRhcDR6Mis2Uk9qWW93Z3ZlNzQ1N1Mv?=
 =?utf-8?B?cEh5VGd0N3IvRGFiVHNPeUVveVFEZWpmc2hNQmdBN1h3L3NkaVhvS1MzOXVp?=
 =?utf-8?B?VEp4MUw1bC85S21VY0pMUm1xeUZPdzBjc0wrT3NBeXJlMFk2QUhXY3B1OUtO?=
 =?utf-8?B?a3dlRXR6UVg3WnhqbkZPYTJ4L3I2dmorNFoxK3VtbHhyUUorMWFZc0dKRmxo?=
 =?utf-8?B?WmcvQkNXdlgzOVpCck8vSXA0ZmxwbUM1OVlMV2E2b1d2WE1UTTJnQTY0TVN0?=
 =?utf-8?B?RXMrRnpYM2FGbFBPTWxBZGFCOTVudFlNeCt4SEY1SUwxbmFZY3crcjJGaFhH?=
 =?utf-8?B?S3ZoY3JRMVFJTkN1bmhVNmIzdTVXbW9NNnpGeUlML1lZRGpzajBBT1dhd0kx?=
 =?utf-8?B?MFRiQ0V5bzFROVA3TGI5VVNlTVNSK2tnUnNhZHd5TjNBNlBIaUJ6VDlkT1pR?=
 =?utf-8?B?NHpydEtlcDhhU0U5TTRMaWJ2UnppdUJWaFlneUVsSEtnY0t5aFJTejVYSkF5?=
 =?utf-8?B?d0wyeXlDWW5oNTBnUUFUL2Iydk4vQ0pOcFdNSDJ3OU1DVjZXaGtwUHpFWE9V?=
 =?utf-8?B?T3NvMmtESmdHaWFHemNNVFBuTmNjT2dUdSsxb0NNdG1mazczY1ZZTlZ2c1hk?=
 =?utf-8?B?b0d2N1c4MjVoS3NzRExVbnVJRFJqTkxwSWNGU0ZKaTlMenRJS2pHNnpSUjlW?=
 =?utf-8?B?bmExL2k0ZTRodTdkTVNSWFVRNkozaVoyZXljc2lFQlMxRm9MSGQyOWN2WWJT?=
 =?utf-8?B?djNwVVJ3ZVdMNWJnTW1vYWlBeGNmYzBPSC9oTXpOWFNDV3JoaGFRY1YraDBh?=
 =?utf-8?B?QTFmUnptVmlDaFR4cG5NTHlOUmxuU1dmeGt2NXVNay9uNEJsclZ0cWtkaTFD?=
 =?utf-8?B?VjlJZDVTTUt0NXV4WVZGM3dNQWxhZWNuSWM2dDVnRDlrVWxHNWYvK1JROWZr?=
 =?utf-8?B?L3lTb2ExTXVHOUFPYklIa0dYN0lHMzJYOHJuK2JrL0RkY041SjcwaVVMQlAw?=
 =?utf-8?B?eUJnMjZhNEtIT0krTFFyQy9MUmwvc3Z5S290WEF2OHYzeDh2SFNCWnlVeExH?=
 =?utf-8?B?aDEwaGlMNEFLL0xobXkxVGIrcVZmRldBdHhEYUY3bXB3VGRMT2ZvNThTeiti?=
 =?utf-8?B?dGZlbWFWeXU2Sk04SlJiK01OQ2dnS0RPQ1lTcUVzRzF0TnRCbUhZcFNnQUUv?=
 =?utf-8?B?SERkOVZ3U01UbUJ4ZFdYdC9JakpzSVZsSEU4Smw2UDk5ZUpOUytTTVA2UFFx?=
 =?utf-8?B?U1dsSWI4ejJsY2FGaHA0YWtYeXQyRlJ2NUhBbkFiYWtvRGlGTXB0cllHVzhz?=
 =?utf-8?B?VDBreElaQkE4cGp4algwTzhxMUxrVTNDNk1EODRqYmJiYWx0UHI4N2lTcElS?=
 =?utf-8?B?Y0w1bGNtN1k2RHlCUENKSGg4U1FUMFlRYjRQUSsyNHVDVVZDWXErNGppNjc3?=
 =?utf-8?B?R1lnUXRsUGxVZmdXVXJHL0h3Q1Z3SDNtNnBUTURnR2JvUit3TE40dkNNWkpv?=
 =?utf-8?B?ZHdDWHlJMmp0UHRWdXRtVnlocUtYd05sV3hkWjlpNEVYWkdMM0dFd0d5RTlO?=
 =?utf-8?B?eXZvdEdrVFNGRzdSVzNTUjk2S3VudFBGcG9hKzB6OFcvTlBHQStNR29GaWlw?=
 =?utf-8?B?R1g1ZnM3SkFndnVtWEM5QWgzM3RTYmtULzdPSnk3bGtKSXBoSVVSTmVTQjMy?=
 =?utf-8?Q?Sivlme9MO10hFbMz3ddY1KdLd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7576d723-25e6-4a05-01c0-08dd2fc3b2d7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:06:13.7614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfV9ts2OG8HoZ9pCRJnn1K5GAjdOg+1hy7wVyYE3AHknxKTfrcYT6VBRKUZxVc9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8098
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

Am 08.01.25 um 09:56 schrieb Jiang Liu:
> If error happens before amdgpu_fence_driver_hw_init() gets called during
> device probe, it will trigger a false warning in amdgpu_irq_put() as
> below:
> [ 1209.300996] ------------[ cut here ]------------
> [ 1209.301061] WARNING: CPU: 48 PID: 293 at /tmp/amd.Rc9jFrl7/amd/amdgpu/amdgpu_irq.c:633 amdgpu_irq_put+0x45/0x70 [amdgpu]
> [ 1209.301062] Modules linked in: ...
> [ 1209.301093] CPU: 48 PID: 293 Comm: kworker/48:1 Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
> [ 1209.301094] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> [ 1209.301095] Workqueue: events work_for_cpu_fn
> [ 1209.301159] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
> [ 1209.301160] Code: 48 8b 4e 10 48 83 39 00 74 2c 89 d1 48 8d 04 88 8b 08 85 c9 74 14 f0 ff 08 b8 00 00 00 00 74 05 c3 cc cc cc cc e9 8b fd ff ff <0f> 0b b8 ea ff ff ff c3 cc cc cc cc b8 ea ff ff ff c3 cc cc cc cc
> [ 1209.301162] RSP: 0018:ffffb08a99c8fd88 EFLAGS: 00010246
> [ 1209.301162] RAX: ffff9efe1bcbf500 RBX: ffff9efe1cc3e400 RCX: 0000000000000000
> [ 1209.301163] RDX: 0000000000000000 RSI: ffff9efe1cc3b108 RDI: ffff9efe1cc00000
> [ 1209.301163] RBP: ffff9efe1cc10818 R08: 0000000000000001 R09: 000000000000000d
> [ 1209.301164] R10: ffffb08a99c8fb48 R11: ffffffffa2068018 R12: ffff9efe1cc109d0
> [ 1209.301164] R13: ffff9efe1cc00010 R14: ffff9efe1cc00000 R15: ffff9efe1cc3b108
> [ 1209.301165] FS:  0000000000000000(0000) GS:ffff9ff9fce00000(0000) knlGS:0000000000000000
> [ 1209.301165] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1209.301165] CR2: 00007fd0f6e860d0 CR3: 0000010092baa003 CR4: 0000000002770ee0
> [ 1209.301166] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1209.301166] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1209.301167] PKRU: 55555554
> [ 1209.301167] Call Trace:
> [ 1209.301225]  amdgpu_fence_driver_hw_fini+0xda/0x110 [amdgpu]
> [ 1209.301284]  amdgpu_device_fini_hw+0xaf/0x200 [amdgpu]
> [ 1209.301342]  amdgpu_driver_load_kms+0x7f/0xc0 [amdgpu]
> [ 1209.301400]  amdgpu_pci_probe+0x1cd/0x4a0 [amdgpu]
> [ 1209.301401]  local_pci_probe+0x40/0xa0
> [ 1209.301402]  work_for_cpu_fn+0x13/0x20
> [ 1209.301403]  process_one_work+0x1ad/0x380
> [ 1209.301404]  worker_thread+0x1c8/0x310
> [ 1209.301405]  ? process_one_work+0x380/0x380
> [ 1209.301406]  kthread+0x118/0x140
> [ 1209.301407]  ? __kthread_bind_mask+0x60/0x60
> [ 1209.301408]  ret_from_fork+0x1f/0x30
> [ 1209.301410] ---[ end trace 733f120fe2ab13e5 ]---
> [ 1209.301418] ------------[ cut here ]------------
>
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 9 +++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 1 +
>   2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b5e87b515139..0e41a535e05f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -614,9 +614,11 @@ void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>   
>   		if (!drm_dev_is_unplugged(adev_to_drm(adev)) &&
>   		    ring->fence_drv.irq_src &&
> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
> +		    ring->fence_drv.irq_enabled) {
>   			amdgpu_irq_put(adev, ring->fence_drv.irq_src,
>   				       ring->fence_drv.irq_type);
> +		        ring->fence_drv.irq_enabled = false;
> +		}

Clearly a NAK, that is exactly what the warning is supposed to warn about.

Regards,
Christian.

>   
>   		del_timer_sync(&ring->fence_drv.fallback_timer);
>   	}
> @@ -693,9 +695,12 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev)
>   
>   		/* enable the interrupt */
>   		if (ring->fence_drv.irq_src &&
> -		    amdgpu_fence_need_ring_interrupt_restore(ring))
> +		    !ring->fence_drv.irq_enabled &&
> +		    amdgpu_fence_need_ring_interrupt_restore(ring)) {
>   			amdgpu_irq_get(adev, ring->fence_drv.irq_src,
>   				       ring->fence_drv.irq_type);
> +		        ring->fence_drv.irq_enabled = true;
> +		}
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index dee5a1b4e572..959d474a0516 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -118,6 +118,7 @@ struct amdgpu_fence_driver {
>   	uint32_t			sync_seq;
>   	atomic_t			last_seq;
>   	bool				initialized;
> +	bool				irq_enabled;
>   	struct amdgpu_irq_src		*irq_src;
>   	unsigned			irq_type;
>   	struct timer_list		fallback_timer;

