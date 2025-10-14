Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E173CCD184
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 19:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BBC010E67C;
	Tue, 14 Oct 2025 19:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pNUj2Z8e";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66A810E67C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 19:16:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAz3fLVzYKHZ33pqxiDO/4dQFCqsZr0ZzFSadGrdMzvFYOBo+XqxBy+fYZdOiNfe8D1he936DpLUVu+rXfgXtJhgXUZRNitEYZV5o98sA9pxyzBfodbwLPMv/tOtuggreBCcYLUo1Z9myx8YQ2jDFa/ecU4myecCOFgcsGlP8W65LPZPMfJZyYCHseqeyvPs5U2IOjcILNbpBkBvOoAZLAKKlwA07Bt4b+jUrsdBfXNahN2uIUZVhhFDHtSCbAuf96cozA6560NEMNqE+OGc3sgO7viWRz3cBb7KyY6SXOdwNs2PYGt1ZvM2dwU96L/v9Kfiv02gvpeVuvNEc+61/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlMAHalAbbiym0DccKMPBeZ/xv/1XzGLCWrP/LnYO+0=;
 b=WAiNDgw3V/2vx4Y28PLcUfTspzsk2Pkj3H+71PkgwEiUpYl9lIQUeNf5V6ejMaDuz0Z0aeK/OTvxxa653s0rJ6uYo7R453lJJ7xHCr5eR7N/jxPNC9i1MIRf72NqMvUCNROeKhQbuort9XBu4JGfrEzvYLbALDCs6xDf3Ak1NQLZbSVOnaCbpmImUtWgcM65MJbyJm0XJ1YmYxvtJfkjbiImWsupbelhuu+KusmrfrS4PGwkbks82WmyV2CHiuKQ+tjUtRRmSMV/g1oR+1JwumSiFwfbGffMFwkgTNXeO/oop0p73cDhAhViqhzxWjcUzeTRfDFLzVLOlkaePJNjbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlMAHalAbbiym0DccKMPBeZ/xv/1XzGLCWrP/LnYO+0=;
 b=pNUj2Z8eLJIr5ZjP1mqAYaskMP1LuUmdRhDOKu1n1S6FKXZXHMKucHqKAhRZHqodotDNb/XWyO2IySoc6NsRu+UgT8iE0F+JpfVXg7lyP7gzGxGYBwib69phQ/bAgkq5875eE+8y4sfCLjlQ9ObNy2TGJvN8YobqHJZu32pyDqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 19:16:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 19:16:21 +0000
Content-Type: multipart/alternative;
 boundary="------------OAXt9sqKp8EPmzH02TN00O6e"
Message-ID: <df3db4b0-7dbb-4800-80b5-5e09ddb9f73d@amd.com>
Date: Tue, 14 Oct 2025 15:16:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix vram_usage underflow
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "Liu, Alysa" <Alysa.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251014134317.5081-1-Alysa.Liu@amd.com>
 <CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: cc1e6bc9-d63b-4467-2235-08de0b5628b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?My9MMksrZGxwNGVQb3NKZEc0eFp5Z3BIczJmVkQ5ODhMbVRZcmxuR0pnbmFj?=
 =?utf-8?B?N3VSTGZhMDUxejQxRVZNQnhtdHdyc3piL1ovS21pR0w3eUFYNERNYWlGdkJr?=
 =?utf-8?B?djhmdWhMU253ZGluVTEyblhkcW1hNThyZFVLSUE2bDZqUXh1eW4rNEwxcDQy?=
 =?utf-8?B?OGpaa3RqVDhoem4yR2k4ajd6WkllNGUwZkhiZFlQamNyOGNobDdSMVE1aEJk?=
 =?utf-8?B?QUh3eDAyWkJaZ29tTXRWdXJVdExtYllGZldaQUZoWkM1VkVybk8zT0g5YzYw?=
 =?utf-8?B?THJPd1lMMVFCc3Z2ZENVU0VmcWFONGU2UGptbVB6U0ZzcHlWemNWd0txcmJS?=
 =?utf-8?B?UjJMZm11R0F0WVJBSVlpcE1jVm16T2U1V205M0xpUFFEOTl2T0h5S0I0SXFw?=
 =?utf-8?B?aW5ibzZKZ0ZnUVJ3MVpmSzA1c1YwV0c3b2MrZW4wUjdSbWJpMm0vcWVKYkhw?=
 =?utf-8?B?eXBGRVJhdWJTV1VWR3ZRSU5Sc25ZYVp5dW9ocWNtZ2RSSVQ3SElaUHZpSlVn?=
 =?utf-8?B?L1lQbHpZZTVhUnhFVGNTdVdiSjNpRVAxQ1duN2VtZVRPaTlqN2pHZUowVUxB?=
 =?utf-8?B?OElZelI1UThJYXZxVTdkN1R3TW9NZ3RpUVcyZHZ1aEd2U1NCZEhsRCtIcjFC?=
 =?utf-8?B?Zzl0N200OXF0M0tTcldpRHRER1NXZGM2SlV1SnRNSklHMXduVjVqOTcvWW1h?=
 =?utf-8?B?ZTFYa2JQK0RNNlNBZ1Z0OSsxUFdsWUlSUE0yQVVFL0pWSitvM1BZTHNRWWo3?=
 =?utf-8?B?ZC9XYmsrQUo4cmFoTDQxUGNBc2poNkh0WDhJMUlSZEtXN1RMUnVEYlNzeGVw?=
 =?utf-8?B?SkFqTWl0MXlaVTBFZFozQ2h2cDV3SC9uSHdZTU10SGI4dVRRdnBjZG9mNHdT?=
 =?utf-8?B?Z2pFOGp5YjZiRVlUMGZhbTcwclpDbFpGcGRYcUhBMERHbHRoS1VnWm9UNWNo?=
 =?utf-8?B?VlVQcEE0ckdsRVdaamJ1aGRaTWdZejZVVHd4SmpnVUdTUEg1Y3greWZ5ZjRJ?=
 =?utf-8?B?UTBNZVR3Risxa2Q0bThHalNsZ1czcUxqNFRIQi82ZWkyeHFTN3dhMnlqTXE4?=
 =?utf-8?B?RTNUSVpJZi9tMkR6TVcyMnRwbW5GeGI1ZTExOWV4Qlp0QmFNcEZkdFdBbkh4?=
 =?utf-8?B?ZSt2YWpWUmJNTE5OVTJkekhUUFRtczhGbXVWTWhzQmMwdTNXeFZpTmYzWG9O?=
 =?utf-8?B?SGFPS2RRTGRiekRPTHZ0Tmp3QitPKzFsdWtHNGNEcHRHSG1BTlBoakZURktU?=
 =?utf-8?B?L2pLcXVhY0c3eUlJYlJSb0o4VFoxc1hGam5SeVJwTXdSRGJXTG5iVk5uRmdK?=
 =?utf-8?B?eFJxcWQxVXVLVnArWWMzVGZSc2piR1IxaVR5cWhQY2RJeThzNWFnSFF1STF0?=
 =?utf-8?B?ZEdNaGFDaDQzdG1zOXQ2MnRLdkh2Uy82THhkNXNuMHdpMFpSUVBweXBFeHYw?=
 =?utf-8?B?TlJnMnlKb012UzVOVmRXTFNlL25RU0ZubzV0UnlNK2RHYlNEekZ3R01XOXVX?=
 =?utf-8?B?NG56Vm9oRCtwbzRONHp5ckowOEZjM1dCeDdkQllQbmg0ODh5S0tVeDlhNVFK?=
 =?utf-8?B?c1paTGFueFBCSzhGNERRb3FMRkJZOHgzd2lwTVJRSCtMd0V0aytHdDhmMkx0?=
 =?utf-8?B?cTlLUlVBbWk0OUJlaXNmNDZQWENIeGdGaGk5emRZVlVzMTByYkJtYkkwNjZM?=
 =?utf-8?B?dGNkY3pHc09wUitrZWhXaHdNRk81dTd4V3VzWG10RVljWUVZdndXcGxNcmR1?=
 =?utf-8?B?ekYwR2ZoWktxejVwU2hwM1VwTnA2alZSMmI3cEdNSit4dmplK0pjOVNWU055?=
 =?utf-8?B?Y3pudEJEZ1lxMVBuUjg2cFJxcXd5VDVxY2NBRmFCSmRORWZMUTFodlJnRW5D?=
 =?utf-8?B?WWZuVW1LcEo2ZXptdy9NTHdNWWFXTG5jY0hvMHNPTXEyNWhTbktPb29lMzdZ?=
 =?utf-8?Q?eHIYvbxp+9hZIieprKhvh9xZ1yfvlZSW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRaMHh2NmVDTFJMbE8zc1ZIV0xKc2U4WnpEdU5TNTQ4V1lJR0VxaGl3SDR6?=
 =?utf-8?B?M3RmRlllaW1jTWt1Q05ZOVlQemZ6UTJtTnAxVzhXTWcwcTA0MFY5amtOWS8r?=
 =?utf-8?B?R0dXSkhDd01pVk9GczhSaHJFZUdUWi8rUUNmQTMzd0lqUW5PcVpsYUxJdlh0?=
 =?utf-8?B?MlY1Zmd1Rlo3TmtjenJ0L2d2TXFHNWVTT1B0QU50QlAyejhlK3ZpS1B5K3do?=
 =?utf-8?B?aUxoWUplYmFJaWhpMHJ5L1FYVlpBZTM5OFZGeDFmWlNOSVVXazlBUUJ6bmx6?=
 =?utf-8?B?TURXZEQ1V3lzZDY3U0puWEU3UmlVRi85eVRyQWdrNUxRSkJUYzhid296anJs?=
 =?utf-8?B?M0xncWlmTTBBS2xvTS9naTNBRHNvWWtPdWFqSlBWT1JIRTJjN1Y1VFd1Qlhp?=
 =?utf-8?B?T2l1Q1d1bkE1MUxBY21FY3l3OWdnbzVPRGZvSnd3NVQwaTR3TVdlYm5YbHBk?=
 =?utf-8?B?V3BoaFBOUERJMS85dWlZaVNML2FrWENtNG55eXRxbDhVS3BOeFFTUXZneWc1?=
 =?utf-8?B?dXVXSndmVVRhQ0ZZNjNrUUxvRDdHMCtlOXE2OVVOTkFEMlhsNGFpT2FmUW13?=
 =?utf-8?B?Um1jNHdoTk0xUFFkdG1ubmQxMXhndVdsV3grQ3A5YkhnaGpQR3U5dkZaci8v?=
 =?utf-8?B?UmNFbGUydmYxdzZmSzhJb29BSTlDaVhJd2hETDM4VFRqTHJ6czlIVEVmc1ZI?=
 =?utf-8?B?YzlLNmFibHpxRkVYK282eGNjaHlJWlV6em9HcU5tSWY3S2RoMDNmSWZ1NFEz?=
 =?utf-8?B?bVBMUWNxTVVFT3lhRm8xSXJGeFJtZmE0b3M3V3dWN3FTNDU0MXlBNHJmV211?=
 =?utf-8?B?S1crVm53YnhEMk9PWFo0UUZYVDgzQmtvY3hrU1gxRHp6TGVHZHQ1ZXBzYTls?=
 =?utf-8?B?S1ZGRG5LU1UybFIraElEYlFPYmk1TjY4c29sZFBESjhESnVlYWZzVXRSRW9z?=
 =?utf-8?B?YXg1NzlaNy83azR5Vm45N3JRbUxic0grNXdqSjRibFVQeEV0cWVXazBxdXdZ?=
 =?utf-8?B?eTAyVFduaWduaFNVa1cxalI5WnhwNWhIRUJBWkdkUStkRVhwd215ZnhQNVVK?=
 =?utf-8?B?Z1BXUWFsa0VxdWJ4OThDWUEzazFBbWJXckd5blFwUzNudThPeVdEWXBFVUxW?=
 =?utf-8?B?L3MyenUrbGNhWDloNzRUV1dmS1dsVXlQM1A3M24vUWh0ZSt1eWNxczVxbFRZ?=
 =?utf-8?B?cWdYeTdkdzVHRlZ2MG1hWTJpbnM4ZlkwNXNYQjRqSERHRFQwdGxBaW5Wc2ZH?=
 =?utf-8?B?VEtEZUdCV3puY3o5U21LYTc3aUpwK0xJeFN6ZTB4VEFSQXFwS043SldNeFI1?=
 =?utf-8?B?ZmU2S20vZ0d3eG82WEd2eWQrNVBPMEhWUHIyQjl4Ujh0NTZVS2E3OWo0cVNK?=
 =?utf-8?B?aWtzK3U5S0NxZlRzbzlsSjVZV2JTZlpGUW0zRDlhVTh2ZmUxbjE2MXJiSjBI?=
 =?utf-8?B?VG12d3V5ckhONG9ESjdoZG8xWG4yVWRKTUdDVDl0STBiT1VKOWtsRWFtSXp2?=
 =?utf-8?B?d0JFem94VjNjZUJqb1lIT2IrQXJNUlI5dnRibFdpTkhWS3FCRjhPM29vZ2tI?=
 =?utf-8?B?WllYNzVLa0RWQi9mQWkycjYzeDVYRFY1b3RBZElPd0ptZEc1dGpSRTduTnE5?=
 =?utf-8?B?YmNxWGVqTmNGUmVqTzBGZ3VWTlpRRHIyN0NGY0ZDQTdYdkNXeEVGbXFCOEdB?=
 =?utf-8?B?Y3hmbVJYUFJmbnJSQXNDRlAwa0xFOEtwNG1IcFBna2R2QUl5WXBsbjJ2ZzZM?=
 =?utf-8?B?c3RybDFLdldkb0dlVW1QeVNvbjJBNFVNcXNyV3VteXM2QkhneGlHRXBERGVP?=
 =?utf-8?B?c2EvMStHd0tPbm5UTElrMm9FU2Q0aWx1L1pOZnYyeGdRZ3I0a1h3blVCdG1p?=
 =?utf-8?B?bXpZRVp0S3hTN2tXaUVFMGFPNndVTmZISzA0cmtRaHZGbkJ3Slgzc2hzTkU3?=
 =?utf-8?B?Z1lzTTlyTTJ1MDJlWWg2UytodTNlWWpDOS9sbkV0djZ4cE03M2RJRjg0VER1?=
 =?utf-8?B?Tkl6dFlmOEdXTFdacnNqbjZoKzdZcHNoeVQvV2JtQy9zUWU1dENEdE1YbTB5?=
 =?utf-8?B?UHZJckhueHg2SVB1RU1MSGMvdWV2bmpxY01SUDVNZXBWM0hlUHg4YlozcVJh?=
 =?utf-8?Q?qMmXeaKAuA0tNk2mYkANWY3Gh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1e6bc9-d63b-4467-2235-08de0b5628b5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:16:21.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QwWtMbhPr6o2FmOJYW/ZoWVioQB6/+FK4tJOWnNhGa0dYCLFtHMw17q9dH4MUFYErW38Xl4mzS3ayBZtxQd1jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200
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

--------------OAXt9sqKp8EPmzH02TN00O6e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-10-14 13:52, Kasiviswanathan, Harish wrote:
> [Public]
>
> Reviewed-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>

This patch seems to effectively revert your earlier patch

commit f915f3af9984464c308787102990d85d4e988d2c
Author: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
Date:   Fri Apr 28 14:20:00 2023 -0400

     drm/amdgpu: For GFX 9.4.3 APU fix vram_usage value
     
     For GFX 9.4.3 APP APU VRAM is allocated in GTT domain. While freeing
     memory check for GTT domain instead of VRAM if it is APP APU
     
     Signed-off-by: Harish Kasiviswanathan<Harish.Kasiviswanathan@amd.com>
     Reviewed-by: Felix Kuehling<Felix.Kuehling@amd.com>
     Signed-off-by: Alex Deucher<alexander.deucher@amd.com>

Are you sure that's the right thing to do? Are the original reasons for 
your patch no longer valid?

Regards,
   Felix


>
>
> -----Original Message-----
> From: Liu, Alysa<Alysa.Liu@amd.com>
> Sent: Tuesday, October 14, 2025 9:43 AM
> To:amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish<Harish.Kasiviswanathan@amd.com>; Liu, Alysa<Alysa.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow
>
> From: Alysa Liu<Alysa.Liu@amd.com>
>
> vram_usage was subtracting non-vram memory size,
> which caused it to become negative.
>
> Signed-off-by: Alysa Liu<Alysa.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 22c1bdc53d2e..c2fa330ff78b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>           */
>          if (size) {
>                  if (!is_imported &&
> -                  (mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
> -                  (adev->apu_prefer_gtt &&
> -                   mem->bo->preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
> +                  mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>                          *size = bo_size;
>                  else
>                          *size = 0;
> --
> 2.34.1
>
--------------OAXt9sqKp8EPmzH02TN00O6e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-10-14 13:52, Kasiviswanathan,
      Harish wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[Public]

Reviewed-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a></pre>
    </blockquote>
    <p>This patch seems to effectively revert your earlier patch <br>
    </p>
    <pre>commit f915f3af9984464c308787102990d85d4e988d2c
Author: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
Date:   Fri Apr 28 14:20:00 2023 -0400

    drm/amdgpu: For GFX 9.4.3 APU fix vram_usage value
    
    For GFX 9.4.3 APP APU VRAM is allocated in GTT domain. While freeing
    memory check for GTT domain instead of VRAM if it is APP APU
    
    Signed-off-by: Harish Kasiviswanathan <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>
    Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
    Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
</pre>
    <p>Are you sure that's the right thing to do? Are the original
      reasons for your patch no longer valid?</p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CY8PR12MB70997A8CD69749C0FCB2CACA8CEBA@CY8PR12MB7099.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">


-----Original Message-----
From: Liu, Alysa <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
Sent: Tuesday, October 14, 2025 9:43 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Kasiviswanathan, Harish <a class="moz-txt-link-rfc2396E" href="mailto:Harish.Kasiviswanathan@amd.com">&lt;Harish.Kasiviswanathan@amd.com&gt;</a>; Liu, Alysa <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
Subject: [PATCH] drm/amdgpu: Fix vram_usage underflow

From: Alysa Liu <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>

vram_usage was subtracting non-vram memory size,
which caused it to become negative.

Signed-off-by: Alysa Liu <a class="moz-txt-link-rfc2396E" href="mailto:Alysa.Liu@amd.com">&lt;Alysa.Liu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 22c1bdc53d2e..c2fa330ff78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1961,9 +1961,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
         */
        if (size) {
                if (!is_imported &amp;&amp;
-                  (mem-&gt;bo-&gt;preferred_domains == AMDGPU_GEM_DOMAIN_VRAM ||
-                  (adev-&gt;apu_prefer_gtt &amp;&amp;
-                   mem-&gt;bo-&gt;preferred_domains == AMDGPU_GEM_DOMAIN_GTT)))
+                  mem-&gt;alloc_flags &amp; KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
                        *size = bo_size;
                else
                        *size = 0;
--
2.34.1

</pre>
    </blockquote>
  </body>
</html>

--------------OAXt9sqKp8EPmzH02TN00O6e--
