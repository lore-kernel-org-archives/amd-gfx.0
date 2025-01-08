Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19275E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 10:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BDAC10E291;
	Wed,  8 Jan 2025 10:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="waIq7CLR";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB0210E299
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 10:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhYQGaHsyYvlJ1SAJpbRbeTbDCX2puplizxOBe1dAaeG0eSUdQQBRWUQHD/XixL5i0VXC1Fm08dFHceMPQPHCtVgcbPhG5VM8+uV4DxO9QhE59BVFwOXszQOfLkSC3Ly3Puxnlui2TafKs8aF10VwP3H0STDvyPSIFSPnV2ytxot9Kw+/vday1nCLMhMrlY0EeklKMaOY4pUZMas7Oy2BOUU1Zg3GttCNJ+KMPPt1kldeF+54usqTTYKBVBCWhr/JCjWY6MwTtQd3UuwByv0I6o5ZfKxxU/qibcdyPXDZiBeNpJ/0lxn4+6PVxAgDEW81gD3bCvZtSK6r54/OH/D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2jksBZKNYxTFegZh+cNJ/F2aua28sy2JjNd/lyluDcM=;
 b=Hm8bAmTFPkl/R/uDyqUBGtB9SQghXVWUabfYj2GSpyjkafxtaufjaC4eSJ3GkaVoYz3XwDCD2+SIQes5qEFyFmKzN6XV4ovWDpt/xAXSsds9kdWzxw0GEu8r+NbeqFo3wdqHe7gO7MdpTwyJnwqsbrl6gw8a3Y9CcwKi7SdkBDgWRiVUlZjV6jquEYOH0Ou+nTnc+A6sZMsQkQgxQ0vR7pnnbYzadRCsiZPYmFp8kCifwQ8/5c/a2KvVOJZDjIUISYbtInNlU8HgEvfwzjTfPZcQFwfO/ehTSRJ+bxzqUo6DES9qCmYsMqIFBCEmCRM67Hfk8QZlDKnX2dD8E0M5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jksBZKNYxTFegZh+cNJ/F2aua28sy2JjNd/lyluDcM=;
 b=waIq7CLRauySWZe9rp7pn2kibXSJrGxKwSjLWnks8ic7xliP6Q5QIXjMEDoqv/lrTU5dlHdac6cEWZuz2ZwYYKxUTOsXXT/L2YYPW9nLRx3m7JCP6OROp+bvLo+sWirAb+f+GsY9L98plBFb9zt8oRGLvMK4nrX9yplPeqnVqWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.10; Wed, 8 Jan 2025 09:54:12 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 09:54:12 +0000
Message-ID: <51b9f2ea-40ee-40f4-b3a8-33c06e0e866e@amd.com>
Date: Wed, 8 Jan 2025 15:24:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 3/6] drm/amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, Jun.Ma2@amd.com, xiaogang.chen@amd.com,
 Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
References: <cover.1736325561.git.gerry@linux.alibaba.com>
 <5c662d197e0d483b551365fcb98f55c33c66d281.1736325561.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5c662d197e0d483b551365fcb98f55c33c66d281.1736325561.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 7de7eb8c-b4c2-4481-b4b0-08dd2fca6726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWZOVWVwd2xaSWFYelNnNUJlTVlDY1crajZFRUNlT3pNOGNYUHFrWG0rc1Zo?=
 =?utf-8?B?dFRScW5TU3VJdW8vMTNmNDlvK3V4YUM0U2tpbk1mNWM1RnF1L3E1U2hVdXBr?=
 =?utf-8?B?cFdVSUVlRUtXTmM1eStzZVlFZWtjQThCRTdZdVVlM01ZVHZCcjE4b2w2S2xH?=
 =?utf-8?B?QktxcEV1UzQxb3dnU09ZdTFOYnRUbFgyR2ZzcU5lbzZhZzlyQm9NdW1xTElB?=
 =?utf-8?B?ZWdBVEdQcUhYcXRwdlJGblNmU1RJMTU4ZmZiSmlzdm4wRHVMUjdxMVRSL3Rl?=
 =?utf-8?B?RkpDYngrNmxjUk82Q2hzZWREd3lEZWRpeTczeHpiZUx2WjJRNXIxcnlPZThj?=
 =?utf-8?B?RFdNVXR4cEp5Sk5BWXppZnFGRjk4MTFreS9oRVpHdEZsU2xuVU9LWkhBQVFB?=
 =?utf-8?B?OFVmQ3p5NUdMUnk3YWlldU1HRmVKYTM3U0EzUFVodUZZZUYzb2g3aTMrOCtS?=
 =?utf-8?B?WURTUVNDVzBwbVRhQ2kxbDFPRTk0TFNUT3RlT0dGbmlGTWF1N2RYWkJRSzRL?=
 =?utf-8?B?T2pvV1ZkNkN0bzV4Skh0ZGVaUFBBSEZCaDFsTjRoekdadmdjVi9pUWhVOGUy?=
 =?utf-8?B?Y2FRU1FMdDF3NnUvYzVlS0ZWcXQ3aW1PcG0wdXJ1aTFEK2dBZ093TEFRMTg3?=
 =?utf-8?B?ZDJlcFNydmFHblJuZlBBZTQrNGJSaHp5R2dLRGVyUnhSOW9jSCtpYVlhd3p0?=
 =?utf-8?B?MUZqa3ZGWitxaHZ2Z0hZeFpSbWFTNFh5TUxrS3dJUlFqME4vMG0waU55dHgz?=
 =?utf-8?B?Um5aay8yVzdTMEQ5WTdnZHVWcVorTmxlQjlsUFY3K0E1V2lNOXIvMTZjc2lz?=
 =?utf-8?B?dGovRG5sUlVOTkRHQ2RGZ2pndk5VRTZQRUpVS01qWldaRGNrWlVQbXBmN05w?=
 =?utf-8?B?QmlaZHBQREhSbHN2SmpYczREUHpjMUtjUnFLbm0xMzZTZDBrNUlrM2pnUVNK?=
 =?utf-8?B?QVI3OUJYWGY0V1RybVBEYmpxV2pPbTFOV0dCRDJwM1hjUUtieHd6aEhKb2hq?=
 =?utf-8?B?SUxWUitxWDRVNXVxeGVKTzdCUGU1eFMza0xhZHFwSktrN1p6Y1NIMlJvc0VE?=
 =?utf-8?B?VXdNUjVscWRURTlzNDJYU2xteHBYTWtHYk4yWDVHUitkTklpeXEvNHQ1RzNv?=
 =?utf-8?B?eGRpR2JwNitvTENRRCtRYWd0eEQ5NEk1VzZ4cGFQWnN4Q211a3ZVeHAvYmhU?=
 =?utf-8?B?RUZSMitkcmZuZll3UFFLVnF4V1BBU0VuejZUa0ZVOTljallRSG9uRkhCQmEr?=
 =?utf-8?B?eUxJaDlZSnM5VWRsZmZOUGdYRXcwMDBnQmlDbHgvODlUc3NpSElZWWN2NHlO?=
 =?utf-8?B?ZFZvSnBaZmRSb2pjcEZpV3BzZHRQUHhpWlR6d0grS2htbndJeFVFQVY3QlFs?=
 =?utf-8?B?bmtrbG5NVWc1NzJXRWgxbnVFRmYzMkJFVkRXWWNYNUowUWdHVDRjVnV6bE91?=
 =?utf-8?B?SGFnRGtqcEhLM2tXYWxUc0xFcnZCNjdGYXF5dHhYQVljL3pmRnp2QjNLeGhu?=
 =?utf-8?B?ME1waUdJZnZjaFdodE96bzNadzFtMU4xcC9YOGxMdEhOazBSYUxSRWxKcHdu?=
 =?utf-8?B?Y2h5SVpYNFV2N0JIdERscE5WaFpnR3BZSGtJZHkwZXNuclVLUVNLNEdJTzB4?=
 =?utf-8?B?OGpKM3doSm1qS1JtcUVlQ1ArTWhuMGYxZmF2S0l1Y05OS2ViUU41NVBXNktj?=
 =?utf-8?B?VlBaUDVCVXljZmcwM2NTQ2F3eVJ5Z010enRzb0sxQnpvTjAwdXc0MGFPdkJI?=
 =?utf-8?B?blBDblNSbU1LOEJqWC9jaDdldHhsZVdWZ09CUU83Rkx3Qm9obzB0QWovY1NT?=
 =?utf-8?B?UXVzcTg0VEVWL0xqNC9kY0FZN0hBYndxZXl5WDNKU2RPblVpVXlYampMbUhn?=
 =?utf-8?B?UVQ3bE1vSFlrUitpQlJSYWRScGVEclY3b09jbWFrMWJCcHNJdUVCbmIrRDAv?=
 =?utf-8?Q?64K7961dKYo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(921020); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXk2VDFmbnJtVFFPUnYydkJxR2FxZkI1cWsxeEt5VDd0RkxjSlQxbGFTc0Rk?=
 =?utf-8?B?Q2V3a0drRVBwRDROWlYyQitVOEN4d3lHQ3h2cVQzc3Z3UDJRWERKTmVoSkly?=
 =?utf-8?B?M2pCN0tuZEJsekJqVjdTbG9USDdMME0wM0pGTVpUTDB0SEl5Ym1sdDQ0eFJx?=
 =?utf-8?B?Q0lrdDZNM0ZMenJBTnFTWnFRcnVURzR6RzUwZ3JyWHE3ck1JUjM3SXBJR2dQ?=
 =?utf-8?B?alNTanpOTllqcnd2Z2xZT3dVbHlSa1pQckUzZ0VBY0ZNNi9RYU5Iay9xSHFS?=
 =?utf-8?B?U3prcm5ESUtFeDF0SVV1SzYvVmtOZDVISEV3SjFZZDdGeGNHTTVXM2JXeW1H?=
 =?utf-8?B?czVKd3poSEF6RkhIRzRzWkp5cnA1S1hrOTdPNG5oeW9UcUw1T3dNeGFkMmZn?=
 =?utf-8?B?WVRVdmoyT29ic3JRNW9aRXkvS2E0dHZHYmFsd0dUcGZWYXVyM09NVEdvdjlv?=
 =?utf-8?B?Z1NBVG11QXpoSU9PSkhMVTJybzdiajN6ZEJPN21NeSszc0VnTVBDbFV0cyto?=
 =?utf-8?B?RW9RYXd0YnpmMGZGU3llY0pwamtKZm96SGpYMDlONk1idmlnZ1Z3RENZYzB1?=
 =?utf-8?B?a3FZSXBKYzBiekxPYy83Rjd2MHlNSHkrcmljaWFqbWVkbVEyUnUrd0xKVlVD?=
 =?utf-8?B?RkhyUkdrS1JzVlRtbG5oY256VUFmY3lmd1ZqWDdYazRRdWF2clNmZUhaZGZp?=
 =?utf-8?B?aE9YRTN2bjFOTWJyUzNWV2J2L0VrWHpYbTEra3RUZEJXdzBLU09vaGh5WnB3?=
 =?utf-8?B?bS91K0lLUFU1WmhyS1JQQ1h1NTg4RGpUdmpOcEVkN1pxMHlLQWlSNFFaYkpn?=
 =?utf-8?B?UlAyWDRjVzh5b01Mc0pUcW5xb0dsS2dyRTluQmtxdVRzcWU4Z1FZSDdYanh0?=
 =?utf-8?B?RUVORkxQU2VkTXVmTDhWYWdLdkRrZVdEeG84UlFpZTk1T2p1SDl5cjFPOFEz?=
 =?utf-8?B?STFrQk5ibkZIZlQrK3dBd203ems5a2pxcW5zeHUyZVlBaXVHbm9sM2p3ZXhK?=
 =?utf-8?B?SzZURjNVUDJLTjR6ejdzMW1YWVN5TUlLdHBqamdTUTE5Qk5RcWdhNjZKTmJN?=
 =?utf-8?B?dUF2NnlyM05pQzhGY3E2Y20rSFdocTA1UmdySUxWZ0VjcUpvZ0dpSVRsSnNX?=
 =?utf-8?B?VE1pWDZtYkF4WHNSREplZlRkR3YyazJkck5FSXdoeGVORm9VR0hUdXphMU1W?=
 =?utf-8?B?bkNabWMzNWpoTEg5eHo0Qk1vTCtteGtJQWc0aE1MOXVaRmt6N3BTRm95MFhq?=
 =?utf-8?B?a3NNQnN0cXUrUGs5MTYzdVBkS2dMZVFBTTN0UGVFa25aeXYxMy9nVk9YUzg3?=
 =?utf-8?B?N3NoUE40bi84eGFHNzEwZWpSd1Fzd1FRR2JYWGRZcmdQTjNwTTF6a2JadjlT?=
 =?utf-8?B?S1VoSlZ5UzVrL0JXVm9hcGZ3RWJFMCszQXhqdUlhcHZ2RU9iQ0c4MW02cHpR?=
 =?utf-8?B?YmxTSzhWV1FoRXJOZ3JLTlZHeHlTYXBhUWl2NWdPaWM3NFoyR0RFSkpjZUhp?=
 =?utf-8?B?TFdiWldxN3FqUGZlN3hxeWZXaWlLNDR3M05yQmxHVC9kcWVCTXVHa2xxcWJn?=
 =?utf-8?B?dzRKbitqdmViY0Z2VVJYZ2NnQWs3enUvZVZ0RUpyUzhiUGVFNlVrTmZrMEZ4?=
 =?utf-8?B?Q0pVQ1RDZkpJVG5QWmtleG5ua2RxTW9aRFhCS2YydTdST1NzY2xObVVmaTE3?=
 =?utf-8?B?TzAyTDN6UUdkNERtN0xXL01ReFhHTDE2aTVBdmFOY2dNbFRrbmk5VE5BZkJM?=
 =?utf-8?B?Y2RjTTRpNWg0d053WWJGMkVKM0l5am9CdHZyNjU0c3pYeEhGRkkwR2JYTldX?=
 =?utf-8?B?NXdjcG01ak9UYnVNSDQ3VFlJKzNpUGxnK2hNWTF3eTg0MzlEWFFBbUlQVUw3?=
 =?utf-8?B?NnJMYVJGK2ozOFFFWHB2ckNvZkJDZytOT3AzK2dPbkEyMHc3a3B2WTBGaFRI?=
 =?utf-8?B?QWpVV2FEYSsrQ1lta2RZTGpKVXhST0piUUZ2Z05NalBHZlllUGRWM3c2VUZM?=
 =?utf-8?B?MzNaWXZkUGtvcEwvblNYdDEwOEpnakNiWkpPRm1ocWpLUFRka3dTK01GZEZD?=
 =?utf-8?B?UnlVeGpyWjFlb0VOQWJiTWpUajVGMHlIYjJtVitRZzRJeDltN2VjYkZ2Qm5i?=
 =?utf-8?Q?bpXAEsinWv/Ocw5OgTwFatOab?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de7eb8c-b4c2-4481-b4b0-08dd2fca6726
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 09:54:12.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKx94nIuKqxIIr46YMrl7MMJAfXMYm1IRPb/rJ7DO7gq6yL5MVVU3BQXpLksEVvI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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



On 1/8/2025 2:26 PM, Jiang Liu wrote:
> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
> after free bug related to amdgpu_driver_release_kms() as:
> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> e024se+0x3c/0x90 [amdxcp]
> 2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
> 2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
> 
> Fix it by removing xcp drm devices when failed to probe GPU devices.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 47 +++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  4 +-
>  5 files changed, 47 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff53a3b9851..510074a9074e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6682,7 +6682,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>  	struct pci_dev *pdev = adev->pdev;
>  	struct drm_device *ddev = adev_to_drm(adev);
>  
> -	amdgpu_xcp_dev_unplug(adev);
> +	amdgpu_xcp_dev_deregister(adev);
>  	drm_dev_unplug(ddev);
>  
>  	amdgpu_irq_disable_all(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 62de668e9ff8..41d1b06be600 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2435,7 +2435,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> -	amdgpu_xcp_dev_unplug(adev);
> +	amdgpu_xcp_dev_deregister(adev);
>  	amdgpu_gmc_prepare_nps_mode_change(adev);
>  	drm_dev_unplug(dev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d2a046736edd..be9147eb8308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1508,6 +1508,7 @@ void amdgpu_driver_release_kms(struct drm_device *dev)
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
>  	amdgpu_device_fini_sw(adev);
> +	amdgpu_xcp_mgr_fini(adev);

Suggest to move this inside fini_sw()

>  	pci_set_drvdata(adev->pdev, NULL);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index e209b5e101df..62dd5287808b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -283,6 +283,33 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
>  	return 0;
>  }
>  
> +static void amdgpu_xcp_dev_free(struct amdgpu_device *adev)
> +{
> +	struct drm_device *p_ddev;
> +	int i;
> +
> +	if (!adev->xcp_mgr)
> +		return;
> +
> +	for (i = 1; i < MAX_XCP; i++) {
> +		if (!adev->xcp_mgr->xcp[i].ddev)
> +			break;
> +
> +		// Restore and free the original drm_device.
> +		p_ddev = adev->xcp_mgr->xcp[i].ddev;
> +		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> +		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
> +		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
> +		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;

Now that there are more calls, this doesn't make sense here. What about
moving the redirection along with register() (I guess it matters from
that point onwards) and undoing it (restore back saved values) along
with deregister()? With that, there won't be a need to have registered
flag. You may only need to check if xcp rdev/pdev is not NULL.

> +		amdgpu_xcp_drm_dev_free(p_ddev);
> +
> +		adev->xcp_mgr->xcp[i].ddev = NULL;
> +	}
> +
> +	adev->xcp_mgr->xcp->ddev = NULL;
> +}
> +
> +
>  int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>  			int init_num_xcps,
>  			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
> @@ -310,6 +337,13 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>  	return amdgpu_xcp_dev_alloc(adev);
>  }
>  
> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_xcp_dev_free(adev);
> +	kfree(adev->xcp_mgr);
> +	adev->xcp_mgr = NULL;

Thanks for adding this.

Thanks,
Lijo

> +}
> +
>  int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
>  			     enum AMDGPU_XCP_IP_BLOCK ip, int instance)
>  {
> @@ -359,12 +393,14 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>  		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
>  		if (ret)
>  			return ret;
> +
> +		adev->xcp_mgr->xcp[i].registered = true;
>  	}
>  
>  	return 0;
>  }
>  
> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev)
>  {
>  	struct drm_device *p_ddev;
>  	int i;
> @@ -377,11 +413,10 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  			break;
>  
>  		p_ddev = adev->xcp_mgr->xcp[i].ddev;
> -		drm_dev_unplug(p_ddev);
> -		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
> -		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
> -		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
> -		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		if (adev->xcp_mgr->xcp[i].registered) {
> +			drm_dev_unplug(p_ddev);
> +			adev->xcp_mgr->xcp[i].registered = false;
> +		}
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index b63f53242c57..be22d4398463 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -101,6 +101,7 @@ struct amdgpu_xcp {
>  	uint8_t id;
>  	uint8_t mem_id;
>  	bool valid;
> +	bool registered;
>  	atomic_t	ref_cnt;
>  	struct drm_device *ddev;
>  	struct drm_device *rdev;
> @@ -155,6 +156,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
>  
>  int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
>  			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
> +void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev);
>  int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode);
>  int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
>  int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
> @@ -168,7 +170,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
>  
>  int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>  				const struct pci_device_id *ent);
> -void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
> +void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev);
>  int amdgpu_xcp_open_device(struct amdgpu_device *adev,
>  			   struct amdgpu_fpriv *fpriv,
>  			   struct drm_file *file_priv);

