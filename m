Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39700C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 21:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5B3210E86D;
	Wed, 23 Jul 2025 21:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyicx3Gz";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89DF10E86F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 21:08:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcsPQUYOjExqTAtiTvwhozp26GI6X/QjGfDFY7NzVyUSElL+V/pFQx+nFfFMcmYlKlIguUSlLPrNqXxII9Ckh7kmz10NB3oKFCNvzGDxUEXl5UpXWCSf7CB0vjQgiRYDkFARFMWXG9m14W3D5pbtBAxyYziuRMlfBE6f9ALP9BtWEyFtBYNY98SvTYalP03VuyNaVqv769n78VFaqzqQ0wU9hpXmwdTxQYyN7IGeMml+amqqAzNcrrDZBKi06Ewot9Y31G+Th2iY/bE5MxWQ0tk/PeLMYF4HbsD5oTYbfwWgBej/q+IfiqY0B64g0PUWc98o9ZHIIi9UmZdewSU6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G3qvkfdMoH9Q55fO/zl5D+wyYVSKVCzWJq+itTbC5U=;
 b=j9+x7J/iZr3HxfLHoHr4epKfmuZWQ0lIfyvpW8dWK0p430/x5rdup57VuBd+PLWpChCYORPA4UPFdEInCMc5vvELLDnMw5kIiVv/yhbhBsCFax8DEEOi2lH9NW8XbJ6WivWVqrlUQLxkTtdK7UWu+/QG5MdvWGun/uG/1SIRQ73HoqtqCgFXs5qGNHBBDB6cGjFTWSaXdSHN0R0C5zOpaBN28qWiZ/xZ9hw1XvIDwFtlaopktSFO/A7hwxWNrIQsed+7TGdTbm7mdVe3uP/Xv1uq+LpxX9rNSAVTPSg28+coyyqrNUelBn409HVRywNEpJ0so7dsXnTIXebIeyKhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G3qvkfdMoH9Q55fO/zl5D+wyYVSKVCzWJq+itTbC5U=;
 b=cyicx3Gzgv/sJR3bvqZUlA6wiMLLgAcmE/xbJe/F3x1lsDpvBavo+o1ILMJaJf5juP/H3geQovM6PdCbt3/g9VHKTjI+iO8hpCTlAhFZmBSNcbwYYe9I9XhVRi5nyYdlvQqLAjIlZRehPvzija6oMAo9NNXemp21l45aR4zuJZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS0PR12MB7851.namprd12.prod.outlook.com (2603:10b6:8:14a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Wed, 23 Jul 2025 21:08:15 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 21:08:15 +0000
Content-Type: multipart/alternative;
 boundary="------------WPuQlExohKwRqXIwuHNBfCcf"
Message-ID: <77662aa5-3f65-42ee-ac5e-e4996b3a4e99@amd.com>
Date: Wed, 23 Jul 2025 16:08:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in SVM mapping
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20250722162450.79502-1-kent.russell@amd.com>
 <f81030dd-198e-4d7b-8467-7e7b3f199f32@amd.com>
 <BL1PR12MB5898AFDD9DCC03E472E38368855FA@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <BL1PR12MB5898AFDD9DCC03E472E38368855FA@BL1PR12MB5898.namprd12.prod.outlook.com>
X-ClientProxiedBy: SA1P222CA0124.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::12) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS0PR12MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b260bb-f5ab-474c-19d7-08ddca2d0a3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUZ1RjFXQ0k3Y2VNTmN0VEdsRlh0Y2FHNUVla2d2dkwxYWhSTDJ1U0x1Rk9T?=
 =?utf-8?B?dFgyM0lmanl4N1daOHRob3F0QWFqRjBXa1JyOFE0clg5Y3hSdWxWaDNaaVNH?=
 =?utf-8?B?dWJmQm95VjhNd1R0WWV5eS9MWnIwSEkxYTZIRm16eS9iNXV2RE5USHJnWnlX?=
 =?utf-8?B?ZW9lQlR0c2w5MFE4M213WHIvbkduVmkrTFpnSzVwQmRyMkRNZ1RhZVNQZzJY?=
 =?utf-8?B?MTc2WEVpVWhlVXpaL0NacWRRNzJPdkFUaUlydkFSL2RHbFdTUWlndVZoR1dY?=
 =?utf-8?B?bFIwdjM4RWZNdlFsVndpekUrS21YWjh2djExK2RLcTJOcy9nOTJUS1V3amJP?=
 =?utf-8?B?eFVzRlRtV25rTGpZT2pGUjlyRnBzNGkvUnhjVThrekw3QXNXVjUvMDZWRDBT?=
 =?utf-8?B?aldNLzFnTDJxdEllYW0xNmpsZ1JiSitSbFROZmVuOGpBdWZzdTZDbWYrRU9M?=
 =?utf-8?B?NW1JZVdIenh6ZEc4NFk4eVpqTElobjlTNEdwczBKOGw2aHFNN0g5aDRFa1Yy?=
 =?utf-8?B?UzRiSGE4RmNTYmhWbG41d1hxZ01ZbXFDaVQ5VjdyemljakpGNDdHVG5VMnNX?=
 =?utf-8?B?TlhVWkJEc29VeHpxa0lJUzV5WUhyYi9WQUNpRUZhcWRxNnFFSVVvREkxdUJL?=
 =?utf-8?B?UVBXNndWQ3NvbnQ2Nm5GdldseEl5OTFndjN2Nm9aNWx3dkhDT1dvUTJpTmR6?=
 =?utf-8?B?TVZmeXdVS3RQd2hCUlJnQlBpczFYZkJsOGluREI4ekwxU09HaDM0M1Y0L2dV?=
 =?utf-8?B?WmZXb0NLUkl1em1jYmpDSTRJRTJFTnV6aGVYL2ZrUnVqSlBIS3N3RzVMT3Jt?=
 =?utf-8?B?blR6bTNtc0lGSEZDQU94UGVaaGgxQmdzbzVrWnZjOHlodDFGZzNFYWxzN0NK?=
 =?utf-8?B?Z08xMStNejlPdFB4VkwyQzhXNVRQYStnVDhWcGZTR0dVRUt6TkhCdTdUbnBT?=
 =?utf-8?B?UUdlTm9PbTNuUGZmdERaQjRUWUdLUDJrdXprYXpWNGoyR0o0K3Z2Qm15ODdT?=
 =?utf-8?B?TXZ2aExFaXhwOEsxanh0MG5DclVocml2MDVaa0cvMGZJRDZGNlZQeVo4bllG?=
 =?utf-8?B?UkNTLzBDRzBUcFppbWIvVVpDSkd3T2VPNWtPSysyc0Z4QjhVV3V0eUY0dFFL?=
 =?utf-8?B?T3Qxdjd1RExUN0M1QytPdTJoY1kyWlVnQXZRdzJ5bTJ5dmRwYjdvbzdXcDFF?=
 =?utf-8?B?bEZ1OGZPMjhqZEs2emV2Y0kzemFBTXJNSDB5TEc1U0lmSklER0VkaFRXVTMv?=
 =?utf-8?B?QmFpYzRieDhlb3Jmc2JmelcvckdEc1l1VC9GK3ROWm9odWFkeEZSVnZzMmhE?=
 =?utf-8?B?SEhnT014dXJnM2pjTVBnNDFTRUowZnRrZXhJSkdNZ0pyajdpVFJWOG1ta0dN?=
 =?utf-8?B?bWlueVh2K1VkR2Y2VDRlbHJLTXhKQlBITHY2dWRQZlQ0eXZHZVRLWEhEalAz?=
 =?utf-8?B?ck51Y0hrTEoyZUNHNDEwVG5TbkFURDl2cVFHN0wxRWM3MHQvdFAzRHkzYmoz?=
 =?utf-8?B?RzJvMkRQd0pENXNmb1kwcnVrbmpZdTk4d0grb0RUY1IrU1JEQXFOUVJaUkRB?=
 =?utf-8?B?eC93ZDE5RFdpRkNOQWpWMVVkSWk5OEdPNXlLeC9IYkdkL2l1czFVOGc4WjEr?=
 =?utf-8?B?eXBkQ2RxTVlmaXdiNEhJYUpGdG55M1pzM2FkL2o2bUxwVUtQckVkU0IrbkY3?=
 =?utf-8?B?bWNyK202dXI4TThMcGY1QzJWN3U1bjdZaDJKN2NsSmNXNGxkOGFXZG0yQSto?=
 =?utf-8?B?bEJydUliejlUdnRtNGN6VGpXU1ZQcFlneEdvUTdzUVh3eCt6bDlwV1hqbnlI?=
 =?utf-8?B?MUsyRk0yRXlOc1hjbEZUY1QyN0tSR0VPS3dZZC9hV2d0MWZMc2hyMkNyNXc1?=
 =?utf-8?B?RUdrb2JwUXh3VU51RldneHcvUUxkWEhQTXlCeHVVaTV1bHVMdjZaOXIrMGZv?=
 =?utf-8?Q?mEkI8jt4eYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpDVzUxdnN2S2w5UUJ3S3VBVmtCYUpzYm9wSVFscCt6VlorTUhqUmZkeGUw?=
 =?utf-8?B?RHdNRmZqU2w1ZW54U2hzUEJzU2F0czBvenN1d1d1cTNOVGVveGdWbEFJSmNv?=
 =?utf-8?B?L1ZwcEdGZ2xld29UdmdlZXlURFQydnNZOW9XYjVCbmZQU1JzVHZjNkVtYy85?=
 =?utf-8?B?Nlo3aFVBWDRLM1pZdUNHTmFKUlEvNUxSWXNxOFo0M1U1Z05HKytIZTV4ZjNX?=
 =?utf-8?B?RWhLRGFKUHJJa2UzTW5RL1dJZXIyWlZkdFYyMll3VERhT3lpd2E4TE5pTjMx?=
 =?utf-8?B?c0J2TUJiTk0vSUxSRHhMOWI2M0dKQUJIekJhdm5HTkN6bjdwQUU2NHg5bkNS?=
 =?utf-8?B?Y3VSQTB6V09NbkVRQWtsWnBkVndvN0xIcXBTTnJTbUxkWHhCQXFFYWhLZmd4?=
 =?utf-8?B?Rk1IRmhUbmpHZGZEaXoza29KNlV4WDJ5alNPNndUZkZrVnYveXJCdGJZdU01?=
 =?utf-8?B?UWgrMDFjUHgyekp4L21RUWlyR1cvbjhXS29KMUZMZEs1cW1ac25SdWpHLzMw?=
 =?utf-8?B?SUp4WVluMXREaUViem8vRUZPQnZHZTZpZFJnZWhKMUZzR3B3TnEvUG04MFpW?=
 =?utf-8?B?d3ZUQVFuNFA2NE51SDRWSlRmeldhWnlOQ3VHRUtWWVpPTG9YZytwNlY2bG55?=
 =?utf-8?B?anp2dThoK0lSa0hDREQwQUhhbFdnYUFpOW9tZ0NJNTlMYWRqTzFqRjFBMEpM?=
 =?utf-8?B?YU5zd1FyeVFiZGZJVFEvTzBKT3lhVS8wOXQ4cFpJV0hGUzF3YjJ1dVY2eDVs?=
 =?utf-8?B?KzN3QllNZmdhMkw2ejZ0S0JXOGxzclNURWNQUUhtUjZFamFzcC9TbWZ0c0Fa?=
 =?utf-8?B?VE5XeVlQQmtWSWR5d2toWHA4QlNpUS9ncU55cW5MMjVFVmpDMXZnTTFYOEVT?=
 =?utf-8?B?bTMvUnc3MVgrUWFLNFNTeUlGTzlvd2Zwa2kxZXc5WFFVbjl5RzJwaExUSFVt?=
 =?utf-8?B?VXE3VFFTdmVYSEN2UTdueGFFbWJDWU5HRjNiSitUZEQ3aEEybmhzS3lpSC95?=
 =?utf-8?B?dUpnYkpvemdGRHhiMytpcXd0Z3poZGkyamRIRVhyRmpkcXJBSlc1ZlhaS2Rq?=
 =?utf-8?B?cHVwTXdJMFRweGJ4ekJ2QjlySkcvekxlcW01MWdyZkd0R2tCTkNkaStCVS9U?=
 =?utf-8?B?dTR1cXY4UU5vZmwyVk9VV0owRlBwcEw3MTVUUWNpdS9TZ3dxdzVwY2tWQ0tK?=
 =?utf-8?B?QVZLWXkxelZSSFlweUYrV1JtWDZtSlZvY1BPUjdhR2FISktISXdTYXhwRzJv?=
 =?utf-8?B?ZXpaZVgzK1dMM1hzckM4cjZkK0FveW9VL0tRUTNrSkRHb1F5emhGQ1IzQkwx?=
 =?utf-8?B?bTlpVFdSdjlOeWViTGRRRVZZdlVWVjFleEwyOExRMysrK2dsRXhRY0tsNWpx?=
 =?utf-8?B?QkZ4TE94R0trVFoydWx3Um5NK0Y4ZW5wWXA3RGFZUnloTUFQK3FXM3hseGky?=
 =?utf-8?B?TjRJSTQ0UHJMRmZDL1Z6L0VoalpaRTFwcFhyUUUxdUpDMUFiL0FDZnlweTBM?=
 =?utf-8?B?UGowV2NYR3o5SWxqZlhrK2cxSWY0R0huMW1RT3lhN0pHaXppdWxxSHhIcy9m?=
 =?utf-8?B?dXc2T0hhYUFxY3dFT0YzQVY2YVlNcFMwcXA1WmRwRHRNTjZEQndYaW5mUE04?=
 =?utf-8?B?QmJxb2JyUUV0cnBMS09iM1JrVEV3OUVheFArdWNJQmdJamtvSFB6cVViY0Ev?=
 =?utf-8?B?R0NkVDFKQXZQLzZKK0FDdjZvYWREc01NcWxGS2tPK0E1OUNaRm5JNDd0bXhl?=
 =?utf-8?B?UmEzSXZ5R284QjBCeGVjU3BYYStMMXE3dUp6QjRCQ2xKVHVjLytxSGpDbXpC?=
 =?utf-8?B?b3gwZ0xkcTE3L1d3KzlqelN6dWlsSGo3UGZHNGNaQlI4L3NNdndMOFdMaGlx?=
 =?utf-8?B?d2VDR2VFeVZ5R0RRR2kwVEhnR3BrQ2djMEJpbXJlWHlKZ2NhM0tsVWlEUURW?=
 =?utf-8?B?RmFKa0dPd2ZGRUFHNCtYUlZkZmpEWUJIVzdGMGRkN1BFSnZvRDVzc2YzS1BC?=
 =?utf-8?B?a0MwbVoyVUZ0YzVvZTd6dHV0SEZEY2swU2piNWtFM1BQaUlDVmZ4WlNGMlJx?=
 =?utf-8?B?RTl6WkhmR0xsVldGZnVGVEFhNnhDRzJqVThJRjM2am45ZnYybUJHZWZxS01C?=
 =?utf-8?Q?chtM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b260bb-f5ab-474c-19d7-08ddca2d0a3f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:08:15.2515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOeqlQKmWB7ht5xW6EpdOzXyi4tAK/mDfblOtr3Ib1lZtPdPKlzHcdL7viIgcafj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7851
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

--------------WPuQlExohKwRqXIwuHNBfCcf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/23/2025 8:30 AM, Russell, Kent wrote:
>
> [Public]
>
>
> The big thing is that HMM doesn’t support a lack of read permissions. 
> So does it make sense to make any HMM calls or set any HMM flags if 
> it’s an unsupported configuration that it will fault on? That was why 
> I went down this path, since trying to remove the READ permissions 
> here while still using HMM calls could go sideways, if HMM will 
> automatically fail if READ permissions are missing.
>
I do not see HMM can only work if read permission is specified. From 
code comments "If the vma does not allow read access, then assume that 
it does not allow write access either".

hmm_range_fault uses cpu page fault to valid pages. If it cannot do that 
it return error code specified the reasons. Driver needs check the error 
code to decide what to do after. Current driver checks if read is 
allowed, if not, driver assumes it is write permission. That does not 
consider VM_NONE that specifies the vma is not accessible, then the vms 
is not fault-able.

This issue not only exists in svm code. For user buffer registration and 
validation current driver does not consider VM_NONE either. I think part 
of the changes is: before let hmm_range_fault do page validation check 
vma->flags to decide if can set hmm_range->default_flags to 
HMM_PFN_REQ_FAULT or not. Do not request hmm fault on area that is not 
faultable.

Regards

Xiaogang

> Kent
>
> *From:*Chen, Xiaogang <Xiaogang.Chen@amd.com>
> *Sent:* Tuesday, July 22, 2025 6:46 PM
> *To:* Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> *Cc:* Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH] drm/amdkfd: Handle lack of READ permissions in 
> SVM mapping
>
> On 7/22/2025 11:24 AM, Kent Russell wrote:
>
>     HMM assumes that pages have READ permissions by default. Inside
>
>     svm_range_validate_and_map, we add READ permissions then add WRITE
>
>     permissions if the VMA isn't read-only. This will conflict with
>     regions
>
>     that only have PROT_WRITE or have PROT_NONE. When that happens,
>
> Why read-only conflict with PROT_WRITE or have PROT_NONE? They are 
> vma->vm_flags that specifies the vma protection. User can change its 
> value at runtime. Is user not allowed to change it from read-only to 
> PROT_NONE?
>
>     svm_range_validate_and_map will continue to retry, silently,
>     giving the
>
>     impression of a hang.
>
>     If pages don't have READ permissions, simply unmap them and
>     continue. If
>
>     they weren't mapped in the first place, this would be a no-op.
>     Since x86
>
>     doesn't support write-only, and PROT_NONE doesn't allow reads or
>     writes
>
>     anyways, this will allow the svm range validation to continue without
>
>     getting stuck in a loop forever on mappings we can't use with HMM.
>
>     Signed-off-by: Kent Russell <kent.russell@amd.com>
>     <mailto:kent.russell@amd.com>
>
>     ---
>
>     drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++
>
>     1 file changed, 18 insertions(+)
>
>     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>     b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     index e23b5a0f31f2..10b70b941b11 100644
>
>     --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
>     @@ -1713,6 +1713,24 @@ static int
>     svm_range_validate_and_map(struct mm_struct *mm,
>
>                             next = min(vma->vm_end, end);
>
>                            npages = (next - addr) >> PAGE_SHIFT;
>
>     +                       /* HMM requires at least READ permissions.
>     If provided with PROT_NONE,
>
>     +                       * unmap the memory. If it's not already
>     mapped, this is a no-op
>
>     +                       * If PROT_WRITE is provided without READ,
>     warn first then unmap
>
>     +                       */
>
>     +                       if (!(vma->vm_flags & VM_READ)) {
>
>     +                              unsigned long e, s;
>
>     +
>
>     +                              if (vma->vm_flags & VM_WRITE)
>
>     +                                      pr_warn("VM_WRITE without
>     VM_READ is not supported");
>
>     +                              s = max(start, prange->start);
>
>     +                              e = min(end, prange->last);
>
>     +                              if (e >= s)
>
>     +                              svm_range_unmap_from_gpus(prange, s, e,
>
>     +                                                    
>     KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);
>
>     +                              addr = next;
>
>     +                              continue;
>
>     +                       }
>
>     +
>
>                            WRITE_ONCE(p->svms.faulting_task, current);
>
>                            r =
>     amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>
>                                                          readonly,
>     owner, NULL,
>
> It seems the real problem is at amdgpu_hmm_range_get_pages. It always 
> set HMM_PFN_REQ_FAULT to hmm_range->default_flags. HMM_PFN_REQ_FAULT 
> means the page is faultable and a future call with HMM_PFN_REQ_FAULT 
> could succeed. When vma->vm_flags is PROT_NONE the vma is not 
> faultable, so hmm_range->default_flags should be not set to 
> HMM_PFN_REQ_FAULT to avoid hmm_range_fault fault this vma.
>
> Regards
>
> Xiaogang
>
--------------WPuQlExohKwRqXIwuHNBfCcf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/23/2025 8:30 AM, Russell, Kent
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:BL1PR12MB5898AFDD9DCC03E472E38368855FA@BL1PR12MB5898.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><font size="2" face="Arial"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">The
                big thing is that HMM doesn’t support a lack of read
                permissions. So does it make sense to make any HMM calls
                or set any HMM flags if it’s an unsupported
                configuration that it will fault on? That was why I went
                down this path, since trying to remove the READ
                permissions here while still using HMM calls could go
                sideways, if HMM will automatically fail if READ
                permissions are missing.
                <o:p></o:p></span></font></p>
          <p class="MsoNormal"><font size="2" face="Arial"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></font></p>
        </div>
      </div>
    </blockquote>
    <p><font size="2" face="Arial">I do not see HMM can only work if
        read permission is specified. From code comments &quot;If the vma
        does not allow read access, then assume that it does not allow
        write access either&quot;.</font></p>
    <p><font size="3" face="Arial"><span style="font-size:12.0pt">hmm_range_fault
          uses cpu page fault to valid pages. If it cannot do that it
          return error code specified the reasons. Driver needs check
          the error code to decide what to do after. Current driver
          checks if read is allowed, if not, driver assumes it is write
          permission. That does not consider VM_NONE that specifies the
          vma is not accessible, then the vms is not fault-able.<br>
        </span></font></p>
    <p><font size="3" face="Arial"><span style="font-size:12.0pt">This
          issue not only exists in svm code. For user buffer
          registration and validation current driver does not consider
          VM_NONE either. I think part of the changes is: before let </span></font><font size="3" face="Arial"><span style="font-size:12.0pt">hmm_range_fault
          do page validation check vma-&gt;flags to decide if can set </span></font><font size="3" face="Arial"><span style="font-size:12.0pt">hmm_range-&gt;default_flags
          to HMM_PFN_REQ_FAULT or not. </span></font><font size="3" face="Arial"><span style="font-size:12.0pt">Do not request hmm
          fault on area that is not faultable.</span></font></p>
    <p><font size="3" face="Arial"><span style="font-size:12.0pt">Regards</span></font></p>
    <p><font size="3" face="Arial"><span style="font-size:12.0pt">Xiaogang<br>
        </span></font></p>
    <p><font size="3" face="Aptos"><span style="font-size:12.0pt"></span></font></p>
    <blockquote type="cite" cite="mid:BL1PR12MB5898AFDD9DCC03E472E38368855FA@BL1PR12MB5898.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><font size="2" face="Arial"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Kent<o:p></o:p></span></font></p>
          <p class="MsoNormal"><font size="2" face="Arial"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></font></p>
          <div style="border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b><font size="2" face="Calibri"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;font-weight:bold">From:</span></font></b><font size="2" face="Calibri"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                      Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a> <br>
                      <b><span style="font-weight:bold">Sent:</span></b>
                      Tuesday, July 22, 2025 6:46 PM<br>
                      <b><span style="font-weight:bold">To:</span></b>
                      Russell, Kent <a class="moz-txt-link-rfc2396E" href="mailto:Kent.Russell@amd.com">&lt;Kent.Russell@amd.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                      <b><span style="font-weight:bold">Cc:</span></b>
                      Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
                      <b><span style="font-weight:bold">Subject:</span></b>
                      Re: [PATCH] drm/amdkfd: Handle lack of READ
                      permissions in SVM mapping<o:p></o:p></span></font></p>
              </div>
            </div>
            <p class="MsoNormal"><font size="3" face="Aptos"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
            <div>
              <p class="MsoNormal"><font size="3" face="Aptos"><span style="font-size:12.0pt">On 7/22/2025 11:24 AM, Kent
                    Russell wrote:<o:p></o:p></span></font></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">HMM assumes that pages have READ permissions by default. Inside<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">svm_range_validate_and_map, we add READ permissions then add WRITE<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">permissions if the VMA isn't read-only. This will conflict with regions<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">that only have PROT_WRITE or have PROT_NONE. When that happens,<o:p></o:p></span></font></pre>
            </blockquote>
            <p class="MsoNormal"><font size="3" face="Aptos"><span style="font-size:12.0pt">Why read-only conflict with
                  PROT_WRITE or have PROT_NONE? They are
                  vma-&gt;vm_flags that specifies the vma protection.
                  User can change its value at runtime. Is user not
                  allowed to change it from read-only to PROT_NONE? <o:p></o:p></span></font></p>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">svm_range_validate_and_map will continue to retry, silently, giving the<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">impression of a hang.<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">If pages don't have READ permissions, simply unmap them and continue. If<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">they weren't mapped in the first place, this would be a no-op. Since x86<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">doesn't support write-only, and PROT_NONE doesn't allow reads or writes<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">anyways, this will allow the svm range validation to continue without<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">getting stuck in a loop forever on mappings we can't use with HMM.<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">Signed-off-by: Kent Russell <a href="mailto:kent.russell@amd.com" moz-do-not-send="true">&lt;kent.russell@amd.com&gt;</a><o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">---<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++++++++<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> 1 file changed, 18 insertions(+)<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"><o:p>&nbsp;</o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">index e23b5a0f31f2..10b70b941b11 100644<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">@@ -1713,6 +1713,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> <o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next = min(vma-&gt;vm_end, end);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages = (next - addr) &gt;&gt; PAGE_SHIFT;<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HMM requires at least READ permissions. If provided with PROT_NONE,<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  * unmap the memory. If it's not already mapped, this is a no-op<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  * If PROT_WRITE is provided without READ, warn first then unmap<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  */<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(vma-&gt;vm_flags &amp; VM_READ)) {<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long e, s;<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vma-&gt;vm_flags &amp; VM_WRITE)<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;VM_WRITE without VM_READ is not supported&quot;);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s = max(start, prange-&gt;start);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e = min(end, prange-&gt;last);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (e &gt;= s)<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_range_unmap_from_gpus(prange, s, e,<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = next;<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt">+<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE_ONCE(p-&gt;svms.faulting_task, current);<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_hmm_range_get_pages(&amp;prange-&gt;notifier, addr, npages,<o:p></o:p></span></font></pre>
              <pre><font size="2" face="Courier New"><span style="font-size:10.0pt"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;readonly, owner, NULL,<o:p></o:p></span></font></pre>
            </blockquote>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt">It seems the real problem is
                  at amdgpu_hmm_range_get_pages. It always set
                  HMM_PFN_REQ_FAULT to hmm_range-&gt;default_flags.
                  HMM_PFN_REQ_FAULT means the page is faultable and a
                  future call with HMM_PFN_REQ_FAULT could succeed. When
                  vma-&gt;vm_flags is PROT_NONE the vma is not
                  faultable, so hmm_range-&gt;default_flags should be
                  not set to HMM_PFN_REQ_FAULT to avoid hmm_range_fault
                  fault this vma.
                  <o:p></o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt">Regards<o:p></o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt">Xiaogang<o:p></o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
            <p><font size="3" face="Aptos"><span style="font-size:12.0pt"><o:p>&nbsp;</o:p></span></font></p>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------WPuQlExohKwRqXIwuHNBfCcf--
