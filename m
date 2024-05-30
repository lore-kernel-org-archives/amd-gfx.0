Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61ADC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 15:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 422D110E4D5;
	Thu, 30 May 2024 15:38:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GJRRPvzB";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F138D10E5EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 15:38:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCAld5sGL4mOxZsdRgfC30XK4yZ09dMH6NCu0OtG4nc4TMczezBKNvDft14HlHlLqU9FOImDuD/MGIKFxZEfd4Og7ssImT0Rs7QI8THxxiNovnm2lHX6GA88xe4N90EkNi86Nd+ncttXEJn9bHLcHgO3P47CFUe3YCOVhNnCetAqeqNO528pzDi21BVQhu5H6pReRjF8B6veXOWX094zTu6rVCPMV6VV3eAD9b/TYAx7y1/veoigyEeaQ6V8WAaR3tbXzhhs9X0IUmxwaUmkyWs8bDSmuGi3+0/6VNliCIDH5Si+ifv9hF0HYMd1cEnUzbPHYB50IydWG5whewlq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N+BPLm9/iG6K/PWjBQ2A75coH69bV4G2echlO8XKMg=;
 b=DRAWvthRP1F1E069ri0NCQJ5OQEnBOQTAfiXuhBEHpRPgRSani/V9C2QdssVKhf3ySngfcQ7o1HYkE1SsheRc8OPWvs2zdePBPnEv2Un7gIuq8S2HPFf8jpB9sPcA6H6tfSo79cF0DFLoSfhGDR78Yu1NUVHr6vd8dFYs3If+2kjfvPBlDa3Bj8V90Drp71P5Jgb4B1e3hh/Q4W/XKVdwEiKphq71C+HHp3GxTH6VRFQu2nvIm7nIGsuHLmi9jdZESQ5QCasZKCgogqVCIjodudw+GNiJ7XGlkM6Jmr1al5SvFkrMS3NBeMLF0hm9emMmVFLoK3bRq4aJkjKhJ1cRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N+BPLm9/iG6K/PWjBQ2A75coH69bV4G2echlO8XKMg=;
 b=GJRRPvzBHnbzAGiQ6APVPv2JRcv2bznHgmvlJVqz5tYJIm7zFKIiXdgjGib6mpc6JfR+Em7iTa8gFh3mVgmfGSfcd730TdagUepDb7VbuyW4ePEXzxP62+/mTlGBsEs7BGIKnNwoMeHNxWa7byEqxBJTIG+cCCsTo3RVmD7rjfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 30 May
 2024 15:38:14 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 15:38:14 +0000
Message-ID: <5f5a5d07-6242-48de-9d50-3160646dab88@amd.com>
Date: Thu, 30 May 2024 11:38:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add null checks for 'stream' and 'plane'
 before dereferencing
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tom Chung <chiahsuan.chung@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Roman Li <roman.li@amd.com>,
 Hersen Wu <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
References: <20240528061815.1854133-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20240528061815.1854133-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::33) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|DM6PR12MB4313:EE_
X-MS-Office365-Filtering-Correlation-Id: a70e7d3c-2cfc-44d3-dc15-08dc80be8514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXZ1bVpwdThxRDI3TjdUbi9oM1BScjNPaHowZkc2b1k0TXZ2aHhROWdadlI2?=
 =?utf-8?B?WGwyVU96bjVVSzVSWEQ1L3dIbEJ3OExKazJQRlVLbmRFMmNGR2lNVDZVZFZO?=
 =?utf-8?B?Y2ViWGVXVmtnc2tHR25BN1djNEVRNEpMQ3dYTGkyckd2UTJxU1pEOXpzODZ6?=
 =?utf-8?B?YkR2ZFp2R3lPQVJ2YnV2bnQ3S2JJM0FUYUEwNXFBZ0E2Q293MlBhTDRacHZp?=
 =?utf-8?B?TWxnQ3RKMm5oRmVBMFdHdjJRVVBmZmpNVEJROHlrOFo5bnJTVW9qaFd1TWwv?=
 =?utf-8?B?aWpucnA3Q3V6Z3RRVzQrVThrT1BqR3ZUSUtsTVM4RTh0MjZCV3NpSGVSUXQx?=
 =?utf-8?B?bVJzdU1sbllrNzYyVEdWczlVVUJOY3FXa1hNUHJRenFGSk1OaitoVnhSb0cx?=
 =?utf-8?B?Y01pNUVQSGlWbmVXcXRRaHpoQ24zQkl2aHRyRXBTNHRHYTdjb1FYZTJRR2NC?=
 =?utf-8?B?ZmlhMVNORjFuUVdzZ3R2YkwxSVJyWFdNS2VIOEkwRngxUU1RNmJuRENMclNz?=
 =?utf-8?B?eG5zbXdpOFlCanhnNG96aHhzTnFvdnp1Zmt2Sjh1TU5ha1lWRXJjQlQzaXFV?=
 =?utf-8?B?a0xuTkJTMmIxRjJHSzBpck9GQ241VFRoczF1RUE5azJQUjRzMExaRjBhMEdH?=
 =?utf-8?B?bTlrTE0zQmZvSVd0bi94aTh5WVVjOGgxNWxEWlJnMFc0UTZuT0o1N2J6UWxy?=
 =?utf-8?B?NURKejdFNlQ3QndXUnRZWVBoMzdXZlMvQlhtU2M2VVlCUTdXNWpXcDQ3N3dQ?=
 =?utf-8?B?YmtVUmw1V21zQkhrRGw2djZtdjhFRXF3Ymc4MEl3U0NjTXdaYkM3MTZoVzE0?=
 =?utf-8?B?N0p1U25XaXl6QWJFbk0vN2NxVjVmTmN4VEtUQkxDZ1lmRmpSU0EwQnBnWmFK?=
 =?utf-8?B?b05SblU0cS8wWitFQjRNZFVWMkVQUHREeExtbWIwUksyOHB6OWt0L0VaMStH?=
 =?utf-8?B?bGpWeDBZaXU0TTkxTk94WitTVTJtcHE3VkZUUGtUZXJBY2NhakttSmpLTVdp?=
 =?utf-8?B?OEZnWWRlZi9CT0VuVFJhTFl2K0RqeklZTXJ4VUZhYU8vOXJIdGVySHVQbGhZ?=
 =?utf-8?B?Nmh4enpLQzAvTThaYjYyTXFZSlVZL0t3YXUvaEpReUhsWnlNY1FxZVhUdXZV?=
 =?utf-8?B?YkdEaG5UZDByZ04vbit2RVhseFJNdGdEOWhpcnJNVXg1SzJxak95YkwrcFVU?=
 =?utf-8?B?UXV5T2J5SC85Y0NmOEFmYW16bFB2SzRvbmJqT1hzUTFCQ1hwRlJnKzFPNFlS?=
 =?utf-8?B?UC95c2lxQy9oQW9xcUtBN3M4eG1XMmQxZ1NKczRuYUhvU3ZrTnlSZlg4S3pS?=
 =?utf-8?B?QVl5d1d6VVhPZW1wSzRQbkVBYlpickVLLzc2eDRTVlFsRWJXclBKQTd6QU1q?=
 =?utf-8?B?VDhqZFN5b1FtWHg3anRFY3FMdSszVXpyS2hLOVIzMXJ3d0ZXbEVnQWl2Q2dH?=
 =?utf-8?B?RFZ4Y24wU3VTYVAvZE80UVphNmRhTVZQeXlocDNYb3l0NHEwZnBMVXd3Q1NB?=
 =?utf-8?B?MEtPNHpiZGFzYk5LMXVRZ0dPZEtxWlU0REI2S2diN3B4MDlNWjYxTWxHc1pZ?=
 =?utf-8?B?enY2ZWVNcGNJNmVBMys1azNGcGVxN28zQW5ZZW5KeVVadWpqRTFuRTZCTld3?=
 =?utf-8?B?dml1N1U4Wms3RDA0aURCTkRqditGR0l4MTkwSkJrcmxaVk5lN3VEcHpqaTh5?=
 =?utf-8?B?cHljcy9raTFEUkxQWWloODNhTnFTQU9IYVc5WUNPRlZhOTFRQ1YwZDNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJkS0wzRmluWldDUkRqWVpJY1Q3WHVXVVVqKzlhaEVLODluWTBjRFhtTDNR?=
 =?utf-8?B?eW95N3ovVXpiYWozVnJYcTgwNXNHN3lxekd6bTBxemt0WWtrdU9ML0M3Ty9Z?=
 =?utf-8?B?QXFheHhFQkNrWGMrRzRUMzF2WG5GMFNDOE9MdzZzZ3NBbkRXS0M0N0NUang2?=
 =?utf-8?B?V1BNb29wNTdHbGI0NDJpZzBVckhNTGZOUGZKeUFUeXdVQllNdUljOU41WkNv?=
 =?utf-8?B?VFdJTHJVTEJIRnY2M3hQR0dzYUJzREZ5UWVWdE1Ld3FaQzNTWWI3L0gyZUlX?=
 =?utf-8?B?aHJOYnVHWXlkZ2FpZEk2MnNLVzl1czVBTmJPd214bDlubDlLVW1aK0F0cmRq?=
 =?utf-8?B?VHRWeWFiaDJ5SS9DZ2hMakkvRjlMaTVBdWJHUmVEYzNaT29sL2k3eGgxbHRy?=
 =?utf-8?B?MFdoMldxSmNsOXdrUzlwcXZHV3pyUEVPY2wrYWJYNWZiazVPL2k4bW83aWFJ?=
 =?utf-8?B?ZzVRbmRIUVRZcVdnOEJXT2VIS1AzanFpd3h6anZmWFVzeWdRejlLejlkdjRk?=
 =?utf-8?B?UTd2dTNwOExGVWNjOUg5WjBHYkFuYzJ0RWQ0VTIyNnNPYTJnbG13YUJvQXBR?=
 =?utf-8?B?RjFqRWNLdnFvWDJXUWlaWS9qVlFSYkxaa2I3YjI3VGxHVzRkZXozQXZFVXdv?=
 =?utf-8?B?ckc0d2pnckh5MjBxVFc5N01pRk92eXEzajJBMnBrTmM4bm1GdVgzbTJHU2lu?=
 =?utf-8?B?UnppRlNiZzFWa2hYZGJQeHJvMThXM0dNazBGenZqN3ZhaVB1WmtRUGFseUNz?=
 =?utf-8?B?UnhsSjhZRVBHWnVZS3pYWEVtdUN6ZmVBbEh2M2tqeFFqQkV1aENaMU5kSFFQ?=
 =?utf-8?B?Z011VE1KNmhxQ1h4c0tBZncrMmtuTmNvQ2Y5NUlPZTVTbEsydTg0aU5uSnQx?=
 =?utf-8?B?aTRQdy9EWFVOb2hkTkUxS1FJNmh0MCtUU29rdGVKV1R6WlMzRTBJRzhxdmhK?=
 =?utf-8?B?STA5R3FyV25CMW13eWUvdng0YXR5NDdQMHd0aHhTcjc3RFpwTCtXb04wZGRj?=
 =?utf-8?B?UTV4bGJNTElXR3pnQ0dVS0RiSDJ4dDRvMFlWdE01ZUthRE9DR1ZEeWxyWHpL?=
 =?utf-8?B?aDhkNWgvQjZKN1hzQmRna2J3QUZCZmM0UjlmdUxUK2RqQ0trVkRnenVNOVVX?=
 =?utf-8?B?MDk0cmxPMlJMaTZGTHRlNlhJcUkrc2VHQWk3Zk52TGVCUUhablpHZDI0Qkh4?=
 =?utf-8?B?Z2lRczBia3VKMkVIeUF5NjY4RWhEWGZmUmVGNTRIcVQwQ1VPUFphVzVLQ3Np?=
 =?utf-8?B?cnN2Ym0vOTBqQksxWmhQY1lqbUpjT0t5c0gxZUdsTGg0WG1PajFjMExXV0NI?=
 =?utf-8?B?UGp1NExCTWwwbU9mOE1hRlZVM2xtZjhUWUlnZ2MvZURYbndrbG9qcUZ5Qk9q?=
 =?utf-8?B?VVhZZ1hVY2ZwbncxVDNoWEVYditIeFcrM1h2Rkt0RWhlcXFidHdxeGJwQmZy?=
 =?utf-8?B?NE5JVGM0RUNLVlljdnRuZXlLODVMVzZXU3NRZFE1d3A3QVVKQ3dnR2d0MzBJ?=
 =?utf-8?B?L2JMc2hESmp0Yit4VGE0cHVGdk5XVEpMb2NxS0dHbFY0VkhtejZDRlZoSmd2?=
 =?utf-8?B?NzgxTytIZWRnSVNqQVZBNWJrbmVJQlpFYlN0UHNFOXdRa1ZjcG1mNUJCc0xB?=
 =?utf-8?B?NlhhZTVXczAxS1pLOWFmMXk2Nk01VS91dld1Rmd4SDExNnZuMHZ5UFl2Y2k0?=
 =?utf-8?B?cnVvbnBwYlA4cm9CYTJTYUV1VnRoVkZ5NWp1S0d1R1h5NEE5S2VXdjZZNllY?=
 =?utf-8?B?a1ZWREhvWE91RlZEdWJGQ0FBZ1NBZ2JubHArMm1DVmxMTWl3aU81VEd4a0ZS?=
 =?utf-8?B?Y2dTR0E0ckMyWHJSNGpFOHVhZVdmRWFWYmFqcU1ENDhTdDZnYkN3a1BXcEpS?=
 =?utf-8?B?M2h5TjFSNmd5VXBLY3J4TFdJbk5tL2dGc3lONVMzSW9JcGxRbUszS1BUakhM?=
 =?utf-8?B?b3JOMnBwU1B5Mnp0dlhKMHQxOTRHSS9yQ1lFRUJYL2ZqT0tJT1NVOEt0NjlG?=
 =?utf-8?B?NHJTTHdhME5McnBFejZ0YU1OMHJ4eTZMUEJXS3FFOEswbFhrcFdVZGlncjNF?=
 =?utf-8?B?cHV4bGU4aFdzbVVLb2FHZk5jZUMyRi9tdVlHN2NKcEx2K1JNWlZnZHJJYXVs?=
 =?utf-8?Q?pfZvY+uyVmXv3GwOjMVud5vs3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70e7d3c-2cfc-44d3-dc15-08dc80be8514
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:38:14.6917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGWtsQx6SFHWwdHe+/w9i025vqmiWqVf7upGVn/I/9nZt/cSHLBIHX+K/lpjNqGHWYJB21WR1zKkgzkOhjFp2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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



On 5/28/24 2:18 AM, Srinivasan Shanmugam wrote:
> This commit adds null checks for the 'stream' and 'plane' variables in
> the dcn30_apply_idle_power_optimizations function. These variables were
> previously assumed to be null at line 922, but they were used later in
> the code without checking if they were null. This could potentially lead
> to a null pointer dereference, which would cause a crash.
> 
> The null checks ensure that 'stream' and 'plane' are not null before
> they are used, preventing potential crashes.
> 
> Fixes the below static smatch checker:
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:938 dcn30_apply_idle_power_optimizations() error: we previously assumed 'stream' could be null (see line 922)
> drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:940 dcn30_apply_idle_power_optimizations() error: we previously assumed 'plane' could be null (see line 922)
> 
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Hersen Wu <hersenxs.wu@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> index 29d1f150846a..4c4706153305 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
> @@ -919,6 +919,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>   			stream = dc->current_state->streams[0];
>   			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
>   
> +			if (!stream || !plane)
> +				return false;
> +
>   			if (stream && plane) {
>   				cursor_cache_enable = stream->cursor_position.enable &&
>   						plane->address.grph.cursor_cache_addr.quad_part;

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Thanks & Regards,
Aurabindo Pillai
