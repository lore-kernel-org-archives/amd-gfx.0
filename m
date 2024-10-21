Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DB6D3E196
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 17:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9636210E52C;
	Mon, 21 Oct 2024 17:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wN9MLWQ";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BB2810E573
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 17:53:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGty1B/miMr/XlgQKDWqvO0/y36+z4KosM2D+wp3FB4N85ZVk3L7zclSZcAC72WlLnjAoOsNMBhWJs8Knhmn9W+8k1yccssjmAXhq+WKQ0TpKf6jTm9NAGSHuYX0gVRSQqzETMlNYOiXrvCxBVIaUegkTdbgyj1pc8xDLFCsuHWEWBak/+lsceSn/Md91KNZzawyrBzXJpkr0LvYpKP+PLL0cNJwFdABsmlc4sh0FciJh36nbh1+mZu1B0p8JBPq4mwICCu6W0q6wyUeYYKwALP1qDdunznEDZ+TQ8uBosJfzl1O/PczBAZkXHOAraM5C5fBNVrB5jjPv7hrwc1KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C9gJcRBN9ZPx1T/tmSK5OKiWQreT7el2jqWc760bWE=;
 b=RJgRU1NuAVtqCMv0bTf/gpYSrUnAb47Q8Eq51p2GEXJQ15Z1Umyn9q7ZVK0oZIt0Ek/3BCRHnu0WKzl7VVjJxuxsYCRC1F84aZP9YojyAF3BRkdV9ZxSVplaFlB0sEYfPbGGKvO+gqpupbvCyJtgQx5kCXFW/fkbO9MR0cT6T1Ogs2hJ3oPGWmpAKMG4NDneijiIr0Cnye2sN0o7uidb+ut/fNpqCZRMnLGe8Np1xsTvCHVWkZKM3ocBqBldUnA4JFS/n2lsjR/h82Z5GIWRf9EusYZN8/0LdPf1/dsjwe87bpprdBdSrftCzliJ4+TR6p5uRMBdvWK9QyTalVoqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C9gJcRBN9ZPx1T/tmSK5OKiWQreT7el2jqWc760bWE=;
 b=1wN9MLWQ+sFUDG9RdL3MVlynNMs6SKhKNJUGdsTzyNpITRg0cLdu0IHAxjOxqHIQBlqoNtcEomgufL41XBAVQfzPkoaWcBOAI1JhJED4iZk9EEtum9NyOo9YPOwTnL2uFyxb0zshgINMO3rDTR1Gaf1pk3IAs3u7wbdGi0moFEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 17:53:48 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 17:53:48 +0000
Message-ID: <dcb78a92-732c-1f5b-c110-32738ecc0dfa@amd.com>
Date: Mon, 21 Oct 2024 13:53:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "drm/amdkfd: SMI report dropped event count"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip Yang <Philip.Yang@amd.com>
References: <20241021174608.2093675-1-alexander.deucher@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20241021174608.2093675-1-alexander.deucher@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::9) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 2016ac00-b694-4c3c-0f7d-08dcf1f950e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHRTVUx0T0VXamtnY3pSbXk5ejR5cG5JWWJxV0RrMTVwUWtKRk9keFl4RVps?=
 =?utf-8?B?NTcrUG9UL2dVYm5VUGt5SEtjUEg0RUw1cWxPVWYraW0rdzZPWmhpdWRCamp6?=
 =?utf-8?B?WndHWm1ycXBJNVhzREY4NnB2TG8vUlg0S0QvZ0tOMXNJU0RRTzhjV09sbzlt?=
 =?utf-8?B?S0pCQXpCNkl4Ryt6dzM2SVg4YThUMHErUEorUTZET3NtRE9wbUg4dE0vUzdZ?=
 =?utf-8?B?a09Na0NsbitkczZjY1RwK200bThrWDNuSU5BdlNHdjN6TjRuOERnSURpOURn?=
 =?utf-8?B?VG9xVm44MmdTcHJXRXVkWVVobTMzUlhVUkpUWXc4OUoxL09ZNXNPcStGMU9Z?=
 =?utf-8?B?dEVxNDlnZjhmUVNrYU1rUE12VTh1aEY2dFNMM1IyUm5CbURhc1dabVFjQVV5?=
 =?utf-8?B?MFlDZ2IxTHJHYUJJWm11aDk0bkZtRjV2aVZpQjRXelRtTFc2L3ZydkFmblNR?=
 =?utf-8?B?Ukw2Y2dEMWdHTmREK083VXNyR3BRdGsyc3pwbkJselhKeGZoVU9pVUtjc3ow?=
 =?utf-8?B?SVlYMXIwN1dmY0tIOU5HNkNFRXdGQjhiL0VlZXE5RWdkRGIyZnhLZjFWVDVm?=
 =?utf-8?B?bWQyRVkxQnR4YXZURFZjN3QwMGYvNHNGWG9hTXFQTEVsbUNGSUlNWk9pYVVL?=
 =?utf-8?B?M2NYNU9NVjVrUTV5WHl0RWZWcEZGV3VoNkthSHY5Z0FUSnRCNlQ3dnhUdEY5?=
 =?utf-8?B?TUpqRk1BQk5tNmEvUSt4QVd4ZWdXRmZGTDZOWVlHMWw1Q1dDZEdGaC9rbkNP?=
 =?utf-8?B?U2FTWmpFbVpGQUFGTU02Qlo4MDltTUlIckVhY1pKTE0zUDF2VFNyeTBHZVNw?=
 =?utf-8?B?M2ZvWnRjU21GeS94SXMzL1IzUXd6M2w4T0oxQWlFSUVjQzAzVVN4RHc3eUVQ?=
 =?utf-8?B?TkdJa3dyOTR5Q2xwejNNN3VNSGFMY2g1ZmNxV3RaSGxObHpyR0ZPR3U4U3pn?=
 =?utf-8?B?WDFCVVZubDdaLzVIZW5YL2s1QWhXOTV6K3lLdjZEUG9kaktncTlNTTNkVk12?=
 =?utf-8?B?dFVtYjJIeVJicWdIblJXU1VaTlBaelVJczc0dXc4NFJjaHM1eXVLcEV4OTgw?=
 =?utf-8?B?ditjN1pkaHR5eVNnbHp1R1NnNHdMOFphRS9ReEcxM2s4OTZxR0E1U2VQazhp?=
 =?utf-8?B?cWpkc0dXMmF0c1Q5djdJU3IvNC9HRC9IdUFBMlJ0Q1JGOEg0Y1J4UnFhRFk4?=
 =?utf-8?B?NkNGdHdJaXlMaTRObWNRR0lRVElQSXhaT05NM3RZWkhkcXc1VWU4NmxtaTF6?=
 =?utf-8?B?YnNSY0wrR0tqM1RKQnB3ZEJCZkhRWWVEemNCcFRUbXdvL2FYaWZ4YUNnVnJt?=
 =?utf-8?B?dkV6TmJyVFdNZUlWNXlUOWJKNWZDRHZXQm5QbWhqbEV4ak12N2xiVTdWK1lr?=
 =?utf-8?B?NXE2L2J6K1piY1h0aDV0Yll4YnVNSHhacjd6SzlpdHFTVDdadjZoVDZGRkNj?=
 =?utf-8?B?ei9YZ1RYR0hoRUZKYWtrVXNETTJFQm9hNmZzcXFRWmo0N1gxTEx0QzFwZ2V1?=
 =?utf-8?B?blRmZEc1c1N6MGRxbXhWQUIralJubzNJelpzeHRKZVo4djM5anp4WHhWUkJn?=
 =?utf-8?B?dm9Xa0tNS1ZESFBDWE9ERGFqK3RkT3U5TXNiZ0wranNTcEZFcWRqSjZFblBP?=
 =?utf-8?B?TDFWc2FBSUJlK1JrcnUrOW5YTkFCZ3R2YnFETlJ3SkNYV3V4b0J4bytVcE1K?=
 =?utf-8?B?bnQ0R0xBeGxWeFE4YVV1VGIvN29HNFhXeUlncUQxaGlrQ3FKdlNZV0lsNWRj?=
 =?utf-8?Q?++RJpmVUuNQjj3yb3+M8CIlda6sTozVHKLy4eKW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3VrZnhiN0RRRFp5ZUhNRFVLVG9xdXNPWUU1aWtCZGdkNjVObjBaRllIM2Vn?=
 =?utf-8?B?NWNmZjJnbm9QbFNjNGVGQlcvQm00cjFSdjgyRW5BcmdkdVVnRm1QZkh5K1pt?=
 =?utf-8?B?T041MlQvYmZCQUd5cFY0NGt1aVhZd0NqUjJURHZWNmNLKzZTMFQvYkJjYW9v?=
 =?utf-8?B?VDd6SEFTVGNZN1B0UDNodTRMc0RnUzBsbjZMRFRJeGlHSWZnME5hUzlnaGM1?=
 =?utf-8?B?b0xUMEt0NXBMMnNtU2lpN1JLOEh1TmNqcHUzdnJwRm0vbit4VVdtd1FqM3d2?=
 =?utf-8?B?OXFMU1hzYStyWnc4aTN3Z2N5aG4vQmV5RE1sTlFjQllxL2ZFMjVRczkyL2VL?=
 =?utf-8?B?b0wwVVRscW5IcVM3SEkrSUpFeG9jaFgxUkNGbXFSQ0djc3c4NzVZSXdzRGJJ?=
 =?utf-8?B?NWhxVlVoMkkzMGUxTThTcVZQMVlaNk54TUNEUy9kcmM0QlhYODBrR1BST0l4?=
 =?utf-8?B?eFlYZ2lLeTlJd2MvUis0YlRwcnIrZ21Ld29rVThLc2dRTFRoS0Z4dWM3V0lK?=
 =?utf-8?B?TDV5MUlxQ1RiSEU4ejJiVlVaR1JIaVFJTjRYWU9NTTVsNVhiSjk5ZWxjdzRl?=
 =?utf-8?B?N2Y3UEpROGV2cTZ1ellKeStKMVgyNnBNRTc4Mlo2cm41R2lzNStyaVBoTE53?=
 =?utf-8?B?MTQzTXlQU2V1K1dEeWJZQi84eTBxL2c2K2dyRUdnQ1JVOFV5OFRqbXE2dkxn?=
 =?utf-8?B?QnBnbUpuQ2U1T250OW9EaC91b2hhVlZ4a1cyOGpuajY3S1ZidU1oR2tWdk14?=
 =?utf-8?B?S3haUkFpeUFodXBlbGFtMFlYYUMxbWE0R0VmYzlGb1M5VEtKWGdsYlFsRmU2?=
 =?utf-8?B?V3FxVFl3Q2txVGsxUW9BSlRGQTRuWG43SkJBaEJWOExTT3d6QUdzdEZuOS95?=
 =?utf-8?B?aFRhT2V0bHpienQrU3BOczc2akpDdzdRR1RiMnd3Q2VreXFqam8zK2lSYUsr?=
 =?utf-8?B?WnYyL3BmaG9MMGh6dm1PYWZuWnVEam1BM3EzZmtJRTRKRmdoUElzZFJiSnlP?=
 =?utf-8?B?SzZySjlvZ0NvME45THFrem0zbGhXNmVHd3ZiaitTbndNR290dy9SaEp2WUJ0?=
 =?utf-8?B?NVVmNFc4TElZSnN1TVdXaTRoRUxpc0ZzcndDcmdpZDBsK2dGdXcrTGJRazlB?=
 =?utf-8?B?MGxPdGFaTS9memxIeTZiUDczaGRjUnQ2NnNra1U0WnlwTWh4cUxzY1NOUE1r?=
 =?utf-8?B?L3o3VzZEbzRlV0RQbnd5Q3NVbkZ3bGdPTUlrL2Jnb2hGckNML1RjZXVmbkpp?=
 =?utf-8?B?TUxoa0Mvd1M0SzgxaXNQUm02MDlSV1dPcWM0TENvenh1d1hwNFBqMTM1dVh6?=
 =?utf-8?B?S21LNkhmbDVSUGRUYlFrQjlCbm5ZUFYwL0F5VlkyTFB2N1VvYWlzSWVzVTJN?=
 =?utf-8?B?TENYVVR2ZFlOUXN5OWFDVG1wWGdQNGpsUFRrY0lEUUNENGZwbFpyVHR3SFpr?=
 =?utf-8?B?MGpCSWlvZEVPZ0JXRDJ4T0tkejhHeGN2Szc3NlBqTWNGNjc2TEU5ZlBjYVd3?=
 =?utf-8?B?a3VLNERuc1haenluOGdwaVppQXA0SFFIMU42M0g2NU0wOTdDd1lmVU8zcktZ?=
 =?utf-8?B?ZThPS05Ga0pHTHRyUURoUXVvSXBuMHVlb3AvN0I4U1hYZVRwdHB2UjRNaTY4?=
 =?utf-8?B?TFZKY3h3YUdDbFdKWnM2T2lJVmtWL2taaENBS0VxMFgvWjU1UnVOUnpLMEhC?=
 =?utf-8?B?UnhCYlR0ZStwVEhPQmEvREFFYU1DcWk1UXAyNFFoeUN1elA5QWZXT3VRTFVN?=
 =?utf-8?B?S0FoQjNwQ1o3UWVXc2poZjBhN21JRjdYbytRQjF3U1VWTEkyZmc0TWN0U0lF?=
 =?utf-8?B?Tm1oK0VNVy9EK1BFbTh3YktJalMwN0ZHRXdMTDVUMWpjbDJYbERpZE5wZHhJ?=
 =?utf-8?B?MnM0L2tMT1pvbXdKZW1leHVaYW4zaFpIYXFDQytya2lBdEEyc0VHMXM3N0ta?=
 =?utf-8?B?Qmt0SXFQc3lJdEdJakxGTS9JcUlaMmVpL0lXWGF4cjBrZC9LVEhxb0QvVFpr?=
 =?utf-8?B?S1h2K1E4ak1OejJIQlJTbUhqNmhNZ0tWMEJZdWRKY0NyS3BNemhEWGVuYUMw?=
 =?utf-8?B?QnFLWHgrekNSTmdwRmRPTENKNHlzQzhaSko5T28zSEYrSXRoajJCM1hnd2h0?=
 =?utf-8?Q?pHR/ZmA3TTjHAiE4lpzdwFkZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2016ac00-b694-4c3c-0f7d-08dcf1f950e8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 17:53:48.7508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+53gD2Maj+ShDyDo+/INVe4g7A/wwCUClrBwSTA+QcOYIlwcKxDPfBsq13p03E6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-10-21 13:46, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241021174608.2093675-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">This reverts commit a3ab2d45b9887ee609cd3bea39f668236935774c.

The userspace side for this code is not ready yet so revert
for now.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang<a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20241021174608.2093675-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 27 +++------------------
 include/uapi/linux/kfd_ioctl.h              |  6 -----
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index c8d67d62ca3f..9b8169761ec5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -42,7 +42,6 @@ struct kfd_smi_client {
 	struct rcu_head rcu;
 	pid_t pid;
 	bool suser;
-	u32 drop_count;
 };
 
 #define KFD_MAX_KFIFO_SIZE	8192
@@ -104,28 +103,12 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
 	}
 	to_copy = min(size, to_copy);
 	ret = kfifo_out(&amp;client-&gt;fifo, buf, to_copy);
+	spin_unlock(&amp;client-&gt;lock);
 	if (ret &lt;= 0) {
-		spin_unlock(&amp;client-&gt;lock);
 		ret = -EAGAIN;
 		goto ret_err;
 	}
 
-	if (client-&gt;drop_count) {
-		char msg[KFD_SMI_EVENT_MSG_SIZE];
-		int len;
-
-		len = snprintf(msg, sizeof(msg), &quot;%x &quot;, KFD_SMI_EVENT_DROPPED_EVENT);
-		len += snprintf(msg + len, sizeof(msg) - len,
-				KFD_EVENT_FMT_DROPPED_EVENT(ktime_get_boottime_ns(),
-				client-&gt;pid, client-&gt;drop_count));
-		if (kfifo_avail(&amp;client-&gt;fifo) &gt;= len) {
-			kfifo_in(&amp;client-&gt;fifo, msg, len);
-			client-&gt;drop_count = 0;
-		}
-	}
-
-	spin_unlock(&amp;client-&gt;lock);
-
 	ret = copy_to_user(user, buf, to_copy);
 	if (ret) {
 		ret = -EFAULT;
@@ -199,15 +182,13 @@ static void add_event_to_kfifo(pid_t pid, struct kfd_node *dev,
 	list_for_each_entry_rcu(client, &amp;dev-&gt;smi_clients, list) {
 		if (!kfd_smi_ev_enabled(pid, client, smi_event))
 			continue;
-
 		spin_lock(&amp;client-&gt;lock);
-		if (!client-&gt;drop_count &amp;&amp; kfifo_avail(&amp;client-&gt;fifo) &gt;= len) {
+		if (kfifo_avail(&amp;client-&gt;fifo) &gt;= len) {
 			kfifo_in(&amp;client-&gt;fifo, event_msg, len);
 			wake_up_all(&amp;client-&gt;wait_queue);
 		} else {
-			client-&gt;drop_count++;
-			pr_debug(&quot;smi_event(EventID: %u): no space left drop_count %d\n&quot;,
-				 smi_event, client-&gt;drop_count);
+			pr_debug(&quot;smi_event(EventID: %u): no space left\n&quot;,
+					smi_event);
 		}
 		spin_unlock(&amp;client-&gt;lock);
 	}
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 7afd66d45313..fa9f9846b88e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -530,7 +530,6 @@ enum kfd_smi_event {
 	KFD_SMI_EVENT_QUEUE_EVICTION = 9,
 	KFD_SMI_EVENT_QUEUE_RESTORE = 10,
 	KFD_SMI_EVENT_UNMAP_FROM_GPU = 11,
-	KFD_SMI_EVENT_DROPPED_EVENT = 12,
 
 	/*
 	 * max event number, as a flag bit to get events from all processes,
@@ -611,7 +610,6 @@ struct kfd_ioctl_smi_events_args {
  *    rw: 'W' for write page fault, 'R' for read page fault
  *    rescheduled: 'R' if the queue restore failed and rescheduled to try again
  *    error_code: migrate failure error code, 0 if no error
- *    drop_count: how many events dropped when fifo is full
  */
 #define KFD_EVENT_FMT_UPDATE_GPU_RESET(reset_seq_num, reset_cause)\
 		&quot;%x %s\n&quot;, (reset_seq_num), (reset_cause)
@@ -647,10 +645,6 @@ struct kfd_ioctl_smi_events_args {
 		&quot;%lld -%d @%lx(%lx) %x %d\n&quot;, (ns), (pid), (addr), (size),\
 		(node), (unmap_trigger)
 
-#define KFD_EVENT_FMT_DROPPED_EVENT(ns, pid, drop_count)\
-		&quot;%lld -%d %d\n&quot;, (ns), (pid), (drop_count)
-
-
 /**************************************************************************************************
  * CRIU IOCTLs (Checkpoint Restore In Userspace)
  *
</pre>
    </blockquote>
  </body>
</html>
