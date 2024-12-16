Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D14E7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 20:20:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026E010E2D2;
	Mon, 16 Dec 2024 20:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Y2WsviG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65A5810E2D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 20:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0WClc/25OHUd/Mx7tgUK0XOWrxVsfEgkp7dHKKwN3tKMAHbjJAVDH+yIeh5swLjvr5MkliKUfzxM69e73+gcbI5R1JglYw/cwE77kZR4gyN3DFvtBc+2irYJTrtan9PSvXyZYlYiex/PO+Y14CAT/Wh0HxFLNdu9d4jOYN5jXr58NIR7lRh4e6RKEA3UYJK6t+jiO0nNRwEnfksyrAH0s4HCdomSeFDDFRgRTGBQawWYZOztu4r+REwyLWU+uFtnE3Xvr11ELPjaliuJ5n+UuD69E8QhS9s0AL/qpdCIM6fYTpnmA6xtGohJMy5+iRJhQdqRqePZfBJgTSeUs9UHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usdc9DyUTtRmFZs912NWVvZvo/POEoce765Vjr+y5qA=;
 b=jKXuhuHuzdeaLHuxBaZNmFPbV+4W5XjiP3u5nF21Hae5hs6oK1KbzNG4WadWYyPQBEzyujq1/GqaCKErG759J1n9OlR7JN8AoZTwq6ZnXZxgpLdBCFxk9N7lISTgYTp73MjtZuLQQ3CNNtMbKzuQI2oTWD0aBUTqvzC9JmYz159f6mhI2wGumEBJwJU1gi85Tn+ZTf4UMHI+XcRNwxQgSgvmRWIqGuqhy+rJsHmDWP1m79IkJsGKWChaVNSwzNYtiuslozepxUP4O7uc7hxIoX0NJU0x3VRPdQgxwJvXaN7eFoE9kxOwQCdm24muFxJSZ4DpdsXim98+SAU9KG6VOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usdc9DyUTtRmFZs912NWVvZvo/POEoce765Vjr+y5qA=;
 b=0Y2WsviGUmTU43Fzq0zf+aB75BNOgjT+VvJ/AY1wpKlnYffKD9DgTCK8T2WiAd12Q4h7DxXonN6p+JnCoa09DT7fjz1PwNhMwG+Z5z43EFl7C/1S3TTxYXkS7dQ3QcI4Voit6YPlkUkl8wohp913NwjOX3FXPoNFtziJUsyjBuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5834.namprd12.prod.outlook.com (2603:10b6:208:379::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 20:20:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 20:20:05 +0000
Message-ID: <a3d33784-24fb-41ca-b86b-26c43056ef48@amd.com>
Date: Mon, 16 Dec 2024 14:20:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] Revert "drm/amd/display: Fix green screen issue
 after suspend"
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
 <20241213155405.393252-13-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241213155405.393252-13-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: a57786e9-0e57-4742-4bc2-08dd1e0f0792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bndGWmk3dGJ6TjF0dU1pUU9KaTU3blo0TVJqanV1T0FFd3J1RXJRNTR2WVhk?=
 =?utf-8?B?TGlKNEs0elpyeUVTbThFTnpOcnd3Y1FxRXdjZWhTL1kwb3pBVDNyVmd6VXVz?=
 =?utf-8?B?TjJPZDl3MHpOR0VzYm5xT0hGaGR5clBPUnROWW91RC9QZTdad3ZHYi9ZZFBu?=
 =?utf-8?B?aDhMc2gzTmhkY2RBeldGQ3JzMzZHeHRLWEUrZ2FlVTAxSnRGWTZTTWVHeVdO?=
 =?utf-8?B?TU1Ia2ZWQ2JscUU4Q1NrTTBLWXhQSkF3ZlBKR3JUVlA3RUN6dm4veHRoek9s?=
 =?utf-8?B?Z0xSSTRvME9zVm5ON3lLTHJ1WDZsUm5uYmRGcWRmVzN6bWpzSXFhS0N1M3VX?=
 =?utf-8?B?Q1FtdUYyYnhCSVE1YW1BM3lMTlIycW9WTUo1aldkaEt2dTRHMlo2S3ZXRWxX?=
 =?utf-8?B?UXQxb1JvM1BsVnhmR2xHb3dPbzhTdWlTWmNTZ2RQQWxTQjNhOC92dXg1ZFlx?=
 =?utf-8?B?ZHhVd1VFR1hsRjBUMy9HQTRSMTVBam4vanJwOWkrTVo5MnFJWGd0N1kwL0xL?=
 =?utf-8?B?MjNoT3ArbFdEanpadm9xbkJYZU1qTnBsMnBaUkh2TitQaTRnakpFbElwekha?=
 =?utf-8?B?dzRldHVZR3NvRmdiRWZWay9UMjJCZWFXTHdvcFhSejdrRzJ2Q2Nnek9RME95?=
 =?utf-8?B?V0dDWFFhcmNUOXdVYjkyQ3plTlNyZ0h3emxsSHExYUttZ3hGWGJTTDRja3Vy?=
 =?utf-8?B?T2s2THRZbk9QMGR5N0pGWXNjakE4VmJaWS9tVmZIME94c3c1eEd2U3NZWFZv?=
 =?utf-8?B?eWdDSkRCekszK0tONkdNSkMydmVMbEpMa1NncWx6WC9nOHNFN1N4UHBpaHBG?=
 =?utf-8?B?QkhjSnpRWXp5c2ZwOGFkaVJQK3B6a0RSN3NYWHpObkJYZk9aTzZWTFpzZFFp?=
 =?utf-8?B?b040QnpPRkxLVkZXbStqdnlYWEQ1MzF0OG5yeXMrSnR3cGZKK1krcXlnV0Nm?=
 =?utf-8?B?d1NQdGVEdHgxd1JRSG5ITVdyUGxUN0d2NVM3MFVaZXd6R2dENVBzWExDMC9L?=
 =?utf-8?B?QWluZWtjTkpkL2tRVTAxNVdIUEMrZDBadWh1eGlVOXNrOGUzU2ZuMEs4ZmtW?=
 =?utf-8?B?ZFpnbXhtMXRXVlFwQys5Nkh1ZTdMc2NWNVBaSGN3cmlnbFJiamV5bUtjMGhU?=
 =?utf-8?B?cWJmWVdvQml5NXlYV3p6R3RSSytwZlRzeEltSWoxZ1EzTHFDUWpJQUNkc0xm?=
 =?utf-8?B?R3lyUnBUNGdHUHNkUDg3aUdmWmdPdWd6NVhmdi9xVklramlkenNMKzI0dC9D?=
 =?utf-8?B?UmxjQ0J2MTE4N2RYQ3RqcmdwUm04YTNqUENvdENjcmZkNFhIajF2eEhwc0VB?=
 =?utf-8?B?aWtvbWx2eU1NVzJUZjRxVVRQODEyQzRscW9XZndJejJ1M1hieUFMMHhmeVZl?=
 =?utf-8?B?RGRneG93QWxkdFppY01QdnJNRDlWS1dqK2x3aGhvTXFwOFV4dnNuMzJESzl3?=
 =?utf-8?B?MnF4YVh3b2Vxd2ZyOGk0SzFIQVBFNHJGOG83WSt1dzMvN21xeUZEZmFXcXRL?=
 =?utf-8?B?bWQvd0JYc3UrVkRUaEViOTZJeVN6SHVDMjVHSmFxR0FXa3RvMGo5Zit2KzJ1?=
 =?utf-8?B?TE1mOGdrejNXRG5GUld3Q0pBWnA1ODRvYkQzay83RUJUUTl3Uy82OS9jQVh0?=
 =?utf-8?B?VmhSRTA1MlI4ajNiRlNrUmJxYmh3T3BpRFgrZFZRZ1JacUx0ODQraW9KVExQ?=
 =?utf-8?B?aTROU3BSYWdiZ013cVRRMHBxaks2SGRQUjViNnA0Q09RbER6YTFZemd3Z1Vo?=
 =?utf-8?B?MWVzUG51NlBUUzQyZ1BreDkzbkFGSXc5NWpSVFFwYjZnU1JqU1hiOWpaZlFD?=
 =?utf-8?B?UVZBUVg5SVVJaW1DRU80QURwdXZpMXVJT09oOGF4aTRSZWRTeWdhV001di9i?=
 =?utf-8?Q?4FsaGze6z/nbU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTZJY3ZrQVRGZzZOUmtBbU5pN0hNc0YwQVB3bjQwck92eDJLc2lsWnhsV0RH?=
 =?utf-8?B?WjhreG5NUkxaeDJOVVRVLzVRSU82clhKTkwrQjZoRFdCNDJLbFMxUmgwWnBk?=
 =?utf-8?B?MjlXNGNtRFgxTHZqOHAzTldVUVV4elQrc1N2OXE3YU9URFl2dDVlNzdWQy9P?=
 =?utf-8?B?S3dHQ0FlQ0t2TkN5VDVZSU1wUVZjcDViUjJNTXYraGVXWERtVzJvVG8rb1F2?=
 =?utf-8?B?OUUydGwrbWFiV0dHWEh1YmJCMXNmckJPYlJIV3g0a3ljYXVSTTBzK1l0UlJL?=
 =?utf-8?B?eVJXQlcwUjllOC9Rcm9EZmZEZUo3K25TbXMvbUdqajIyT1VKMUdNaUJwZkJy?=
 =?utf-8?B?aW5QSDljUkF5aGtwSmt6UjM5ajhweVlNVExCRVE5anZSZkFjS2dRR2V2cTBh?=
 =?utf-8?B?NktwMlE0ajJTWkF0VHB3Q3F2bmZ2TWx1eHM0S0o3UVBkUStOQmVSRHVZQ1p0?=
 =?utf-8?B?MjM2N0ZiejBmNDBUbjhhQmlRajRQUHJDOWxWRDBXc3QyOS9iTzBOcHE4ZkRo?=
 =?utf-8?B?NHlKWFBHWFFWS2ZUTUZyNjR6YUJjTUpOZlRnL3pBbFMxditFejhFYnJKa3hN?=
 =?utf-8?B?MEF6T2huUFJ3TS9Jb3ZPdTVqS0NuNXRIb2VibzYrblJDNytSdER1U3hKRFJ3?=
 =?utf-8?B?bWFXNWxJZmlEQ2R4MG9KWmQ5Mlh1WTJGdGE5Mk1PUGg5V29sbnIyRWtCMStl?=
 =?utf-8?B?YkdrWUFIVGRRakdkOStlQ2RzM3EzcEJVaGl5clBialJ2ZFRrWWtFekp1d2p6?=
 =?utf-8?B?cU40SXlqT3Z1V1gweldhSXdTb0ZSam5yT3grUzljTDA5eTJiRldSKzh1aVlr?=
 =?utf-8?B?Vng5Y3pseGJLeWZrZElmTzQzM3gzNjhNRjBrNW5ucnIveHBSL2RJQTY4ZUVV?=
 =?utf-8?B?MWFnSDRDWXVEL3ByS1F0WEh0UzNod3U0bnd5TWJmS056UTZEUm5abFlpaGgw?=
 =?utf-8?B?VXM3bzl6dXNQUzRGWmRLekc1dFdmUFBWc2ZOeGpjOGdCZkZjMHZJZzRNOFlW?=
 =?utf-8?B?L0Q5NWVCNGNOR2UwcmNUOWZrN1dNS0VNQnFJVVdOa3BhLzVHOUlFWFJTWm1K?=
 =?utf-8?B?MnBaRlgrSjBTV09vbGNkZWMyL0F1WXd6TnNsNHFDZjFhdjJJaURVM3NGTnYw?=
 =?utf-8?B?R3hpRytKcUx5YWJnREJQY0tsczFYU0JSaGozVlpRRTFMSmdVL25ISVplSlA0?=
 =?utf-8?B?K0dpVHVpR2cyalUzcldJd090YVVVaGl0L0xSZ3p0eWJKOUxMVXV5NGI4dUNC?=
 =?utf-8?B?QzVHb1hkV21reVFtVDhaNmVUVWtNcUo4SFNYRHNVT05KcDZEZ3htQk9IYkNj?=
 =?utf-8?B?b2ZnaVg4aThlUWpNN0M2ZFloR0ppNkgzOEZZdHkrOTFLWHMzNmwybWZtSFN0?=
 =?utf-8?B?RWdUUXJOcWtjK1ZaSnpGVFNmQ2gxbkxMV1ExdjRtaUk2dVFEa29HVE85Yksx?=
 =?utf-8?B?aGwrclNnY2hOQ3VJdDdJbnA3bVpzSDhKR2l4blljY1hrUFVpcDh5QTlzM2tC?=
 =?utf-8?B?V1dnYlE1MGszd2NaMVVjc0ZwTWV4SzdnQlFHQ1MvMkxvWmtkVGl3eWxhMC9o?=
 =?utf-8?B?Z3k3d2JCSXI3T0ZhTUlnY2pLckVRSTNiaG1GSE02R1BwL3RHbTdibE9RK3BW?=
 =?utf-8?B?YXdvd0pxVnV0NE1WQTNuUUFZV094Z2ZpM1JIR0U0WHlyeVNoU0tpZFNma3dH?=
 =?utf-8?B?QkdTSlRBVFF6UmpZcmp3eG5ldWJodGVLRVZMMCtITlNQUmk2QiswblQ3c3lD?=
 =?utf-8?B?c1hjTGxSNlVObW5EZDBOUHp6bGwxT2N0dGo4RlNQa1BubThZUjhYMDVsZ1ZG?=
 =?utf-8?B?clBVL3A0RTc0MGhoaUhqOEd4bmdZUFZ1MkZpUnIvZVExMi9RMWx4WnZMUVJK?=
 =?utf-8?B?dUpSeWpHaEpBUUNTbXUxME1WejZSd2lWazA1WFFXNGxxTWV3ZTRjRmUybHY2?=
 =?utf-8?B?R2JicC8zSCt4QXNURnBWKy9KR1Vud1FYSHJ2L0QyeEs0Q1lYS2NwdFVlUnFl?=
 =?utf-8?B?MndNTi84RDdEZE1lMGhSZWJyOVJUTUN3VURGVXVXWUNKN2p0eHQ3Z3J2dTR0?=
 =?utf-8?B?bDBCZHRlQmtaODR3dWVEYlZNb0YwSHo4TkFHd1VUWVRwSGRLUC9tMkJPWWdw?=
 =?utf-8?Q?5NHrAWYWbc58muGABwDUb5yz2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57786e9-0e57-4742-4bc2-08dd1e0f0792
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 20:20:05.8703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAGq8KwWKrnt8hJiC7tUxo3NjUlpVplrXPcPEcKiszWRKRftjlQZtb5PdYj0CWxHtX8ieRePRMuLWG1gQtxLGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5834
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

On 12/13/2024 09:52, Rodrigo Siqueira wrote:
> This reverts commit 87b7ebc2e16c14d32a912f18206a4d6cc9abc3e8.

Blast from the past, that's from 5.7!
Nice tech debt removal.

> 
> A long time ago, we had an issue with the Raven system when it was
> connected to two displays: one with DP and another with HDMI. After the
> system woke up from suspension, we saw a solid green screen caused by an
> underflow generated by bad DCC metadata. To workaround this issue, the
> 'commit 87b7ebc2e16c ("drm/amd/display: Fix green screen issue after
> suspend")' was introduced to disable the DCC for a few frames after in
> the resume phase. However, in hindsight, this solution was probably a
> workaround at the kernel level for some issues from another part
> (probably other driver components or user space). After applying this
> patch and trying to reproduce the green issue in a similar hardware
> system but using the latest kernel and userspace, we cannot see the
> issue, which makes this workaround obsolete and creates extra
> unnecessary complexity to the code; for all of this reason, this commit
> reverts the original change.
> 
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++------
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 22 +++++++------------
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  3 +--
>   3 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3407741152f7..4f0267b2d5ad 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5524,8 +5524,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   			    const u64 tiling_flags,
>   			    struct dc_plane_info *plane_info,
>   			    struct dc_plane_address *address,
> -			    bool tmz_surface,
> -			    bool force_disable_dcc)
> +			    bool tmz_surface)
>   {
>   	const struct drm_framebuffer *fb = plane_state->fb;
>   	const struct amdgpu_framebuffer *afb =
> @@ -5624,7 +5623,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   					   &plane_info->tiling_info,
>   					   &plane_info->plane_size,
>   					   &plane_info->dcc, address,
> -					   tmz_surface, force_disable_dcc);
> +					   tmz_surface);
>   	if (ret)
>   		return ret;
>   
> @@ -5645,7 +5644,6 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	struct dc_scaling_info scaling_info;
>   	struct dc_plane_info plane_info;
>   	int ret;
> -	bool force_disable_dcc = false;
>   
>   	ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, plane_state, &scaling_info);
>   	if (ret)
> @@ -5656,13 +5654,11 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	dc_plane_state->clip_rect = scaling_info.clip_rect;
>   	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
>   
> -	force_disable_dcc = adev->asic_type == CHIP_RAVEN && adev->in_suspend;
>   	ret = fill_dc_plane_info_and_addr(adev, plane_state,
>   					  afb->tiling_flags,
>   					  &plane_info,
>   					  &dc_plane_state->address,
> -					  afb->tmz_surface,
> -					  force_disable_dcc);
> +					  afb->tmz_surface);
>   	if (ret)
>   		return ret;
>   
> @@ -9099,7 +9095,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			afb->tiling_flags,
>   			&bundle->plane_infos[planes_count],
>   			&bundle->flip_addrs[planes_count].address,
> -			afb->tmz_surface, false);
> +			afb->tmz_surface);
>   
>   		drm_dbg_state(state->dev, "plane: id=%d dcc_en=%d\n",
>   				 new_plane_state->plane->index,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index c10cabb8b42b..1ec4e4b9ea94 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -310,8 +310,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
>   								     const struct plane_size *plane_size,
>   								     union dc_tiling_info *tiling_info,
>   								     struct dc_plane_dcc_param *dcc,
> -								     struct dc_plane_address *address,
> -								     const bool force_disable_dcc)
> +								     struct dc_plane_address *address)
>   {
>   	const uint64_t modifier = afb->base.modifier;
>   	int ret = 0;
> @@ -319,7 +318,7 @@ static int amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(struct amdg
>   	amdgpu_dm_plane_fill_gfx9_tiling_info_from_modifier(adev, tiling_info, modifier);
>   	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
>   
> -	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
> +	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
>   		uint64_t dcc_address = afb->address + afb->base.offsets[1];
>   		bool independent_64b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_64B, modifier);
>   		bool independent_128b_blks = AMD_FMT_MOD_GET(DCC_INDEPENDENT_128B, modifier);
> @@ -361,8 +360,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
>   								      const struct plane_size *plane_size,
>   								      union dc_tiling_info *tiling_info,
>   								      struct dc_plane_dcc_param *dcc,
> -								      struct dc_plane_address *address,
> -								      const bool force_disable_dcc)
> +								      struct dc_plane_address *address)
>   {
>   	const uint64_t modifier = afb->base.modifier;
>   	int ret = 0;
> @@ -372,7 +370,7 @@ static int amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(struct amd
>   
>   	tiling_info->gfx9.swizzle = amdgpu_dm_plane_modifier_gfx9_swizzle_mode(modifier);
>   
> -	if (amdgpu_dm_plane_modifier_has_dcc(modifier) && !force_disable_dcc) {
> +	if (amdgpu_dm_plane_modifier_has_dcc(modifier)) {
>   		int max_compressed_block = AMD_FMT_MOD_GET(DCC_MAX_COMPRESSED_BLOCK, modifier);
>   
>   		dcc->enable = 1;
> @@ -840,8 +838,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   			     struct plane_size *plane_size,
>   			     struct dc_plane_dcc_param *dcc,
>   			     struct dc_plane_address *address,
> -			     bool tmz_surface,
> -			     bool force_disable_dcc)
> +			     bool tmz_surface)
>   {
>   	const struct drm_framebuffer *fb = &afb->base;
>   	int ret;
> @@ -901,16 +898,14 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   		ret = amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers(adev, afb, format,
>   										 rotation, plane_size,
>   										 tiling_info, dcc,
> -										 address,
> -										 force_disable_dcc);
> +										 address);
>   		if (ret)
>   			return ret;
>   	} else if (adev->family >= AMDGPU_FAMILY_AI) {
>   		ret = amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers(adev, afb, format,
>   										rotation, plane_size,
>   										tiling_info, dcc,
> -										address,
> -										force_disable_dcc);
> +										address);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -1001,14 +996,13 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
>   	    dm_plane_state_old->dc_state != dm_plane_state_new->dc_state) {
>   		struct dc_plane_state *plane_state =
>   			dm_plane_state_new->dc_state;
> -		bool force_disable_dcc = !plane_state->dcc.enable;
>   
>   		amdgpu_dm_plane_fill_plane_buffer_attributes(
>   			adev, afb, plane_state->format, plane_state->rotation,
>   			afb->tiling_flags,
>   			&plane_state->tiling_info, &plane_state->plane_size,
>   			&plane_state->dcc, &plane_state->address,
> -			afb->tmz_surface, force_disable_dcc);
> +			afb->tmz_surface);
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 6498359bff6f..2eef13b1c05a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -51,8 +51,7 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
>   				 struct plane_size *plane_size,
>   				 struct dc_plane_dcc_param *dcc,
>   				 struct dc_plane_address *address,
> -				 bool tmz_surface,
> -				 bool force_disable_dcc);
> +				 bool tmz_surface);
>   
>   int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   			 struct drm_plane *plane,

