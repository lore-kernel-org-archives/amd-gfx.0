Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE09BD3001B
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 16:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E6C10E35E;
	Fri, 18 Oct 2024 16:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MRNZ21jz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A61510E35E
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 16:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hmmn0s3eRYj7cpEmOxxYnKYKnj9cqbtV8jybpGRj3iIecGfK/LkzoQCeTHM6yRPwjUWMg60uXlJsqutGnQheCKPdwjTBhglECrfZEFCVt6VeM8LmCBhp0wXWvR5zyITtmOVhwYq223FV8t1Hm9LABDPWsgP3rcV6jWU50CjC8aQwS0v1ZhJZ88R1i4Ui5gEjRe5flJtvBdVIVSuZMESk5Cu7wnX3KXQ28qPm7XGYGKelU0PRNDKKjeJjbEER1mkUOIVD0yYKra5UdX8xbTr6O3ohY23NzQbUtM3NYNjJh9EX9rQ6K4OMIbft2PkVRSo71jig+y1z5YOw9RGN3b272A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pi9hy4buVne7xhbyxIh4Tru6lSC569HFzL/L3r5sBjY=;
 b=QyIQUY/KsVD9VCa6Axlesb0j9UGdoej5dDHwgWqzeL6eQpT6k4kwqn6dp2ZAAZ/vb4oX7BahaLb3xOj2jQ5z17TsreMTyH+WePgJzIJY5aF/It+2FonXXr0Ah0dCz96Vu/HAGwE0EcOR/uD5nozp1QiM5Jj60QXCDSM5I/CHPo8lwFlWsnx+sVswwk8EMEE8QZ79s7suHNx0erV+xj7ys/V+7Gf/OPUR3MZCGmqTedVbQdTWNIX+p2copAjm7iqTi54A3zydHidxBCudqAg1lJUIcy58A5P++2NzfISV8vRkCa8gg8Wy+lZlPH2N1cFWwTpzVvNEAilso1w0Jd4o6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pi9hy4buVne7xhbyxIh4Tru6lSC569HFzL/L3r5sBjY=;
 b=MRNZ21jzftOL18xQhxyhxtCxapA5dafKKWP1/LgnFNnMBQBN5W0/DiQf91k1yqi5HK0a9H3k9lpq6Ld3oypzIMZBz52ion/2wWExn15w3RGbfrRvPVyfDzNQeY0JjpQW4oIWlt0YgdeFF6WVVzETYQCS3WRkPDrVuMwKfGbR/bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 16:17:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 16:17:06 +0000
Message-ID: <8c9763a6-ecfa-d314-4bb3-094c949199f0@amd.com>
Date: Fri, 18 Oct 2024 12:17:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdkfd: add/remove kfd queues on start/stop KFD
 scheduling
Content-Language: en-US
To: Shaoyun Liu <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>
References: <20241018151005.743103-1-shaoyun.liu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20241018151005.743103-1-shaoyun.liu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0196.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::8) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5514b1-ec6f-4c4d-2115-08dcef904f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3pxQnAwaXFEekRwL3JHQklEWEpKTUc0OGUxQi9Jb2ZVcmZhMTBUUmxzb2pR?=
 =?utf-8?B?dEpDZ2kxeVloWGpqbVlLSXdIckVheHlQTWV5SDAxNy9EYlBod09BdzU2bDBV?=
 =?utf-8?B?QTBGUUVRRzZqaEVLcHpqMVo5ejE1cjhkeFdyK3MrMWNDQW44MGdqY2dGd3NM?=
 =?utf-8?B?SHgvRU5IWGhiZE9BcVRZd2JxYlkvdDlTbDdSQ0ZhbDZuRlBLcStKRkNBV3ha?=
 =?utf-8?B?WTI5WmIwTkFuOXpYSzQxMHllSmtrMS9XeDZORVU0VzJmWFdYT1l4WDZwK3Vr?=
 =?utf-8?B?cTBNNmdpYndzaG8yYXAxTnVUSUkxVzZOWm9lRUJHYkc3QWVTR0tLZm1saG9P?=
 =?utf-8?B?akhPTW1tSmVwUlJUcjd2Y0UvYWF1d2F4VnZHMDNTMGhMTkdDNlNTdGRaMlZG?=
 =?utf-8?B?MXZDcVJPK3lORUFUN2p6MXE4ZnJHLzJNNitObncvVm1HLzJLSWc4eC8rbjQz?=
 =?utf-8?B?NCtZWEJDT1pPYmhNbkcxQkZZMVVObnI4UDd4YkdUTlFaMWJLTi8zaUxIRjlF?=
 =?utf-8?B?RGRzbG1tU2NvNnhlT29wRE5obFZWWmFEN1JzdDJYMlZDKzBzOTNza1VHNGF2?=
 =?utf-8?B?d2hWWVF0K0lGcTZwQVhIMzBuS1dOSDR6ZTNxejN0ZXJLNXNCMEVPNTFuVVI4?=
 =?utf-8?B?SjJjcjFuR2NPanJpVlZzeElQYWd6Q3RwempjZ0hoazcwUU00ZjRCbnFPZjFV?=
 =?utf-8?B?Mm1VeldOaXYxS2UwRmtNWXNuQXQxZldQVTE4SFhxRWVsOC9XN3dJN0wwVG1j?=
 =?utf-8?B?VHF2NUE5Vld1eldCMmtZbStwUkgxNnRpUk9jY0lDd0NsakVTcm95L09VTlJo?=
 =?utf-8?B?MS9QbWpMNmNVRWlWejZwNUowNVE2cWtBMUV2TW9UTEVsMitFMHBkQjZxOEJn?=
 =?utf-8?B?Mmo4SHFZZW16cmVMVURGRi9uN0tER2ZQTENQMmY0TmI0TDRxbXpLaUlNYmU0?=
 =?utf-8?B?NW9BZEhwcGxmSFBuckQ5VXZ1cmRybjAvNVdGMTVsTW94ZUpVOUJHV3IwSjZV?=
 =?utf-8?B?b3ZDYmNuZ1Q5dmVIeXowNkRIUEw1WHdiTzlYNEwvY3FxRmJCL1E0Q0lOWlYr?=
 =?utf-8?B?RWNZZXE3OE02ZmVPdUxmWnRCcjUxZ2dsSW1LU25FTmczN1M3WVhuc2xSa3Na?=
 =?utf-8?B?OWQ3cnFIamJ0V3YvSjhaT2VVVVphZXgxVVpFL1pOR1l3VHZreHlVbmx0WE43?=
 =?utf-8?B?ZWQzbmZScGZKQVJ0cW9GMEprcy9kdEY3cDlSVHV2VTZNUGgvUkptZjB3RUho?=
 =?utf-8?B?VU1uTkxUVHc0NVZjNVJqRUZENEFVZW5nS0NMRjVvVWdYN25zSGNiYVJ3Wmxh?=
 =?utf-8?B?aUZuYlFaY1pLc0R4RmY4WlZHYTU3Sm9TZ0IxdWhjZGpOdml5NEc0OFo2U1VQ?=
 =?utf-8?B?Q3J4bGJUTUduVTFEL20xYkE4Qml0dWh0clBIbEZxeFFvK0ExTHNHZkVlcW1Z?=
 =?utf-8?B?THJxOGlPa0w1UDM2QmpPTmlPL29YNHMvV1dONlkxWjMrL2cyVDJ0c3BOeUN6?=
 =?utf-8?B?c2N5dXFNMHduaytmUlJTek41bi9FMDNicENYZVRDcFYvOFRpVmJzUEh6VVNh?=
 =?utf-8?B?dStsN2llc0poQVcwanFSUktpZmx0LzNoblpWbUZEOFNsTnlwMFVKamFGcGpj?=
 =?utf-8?B?MitRNGQ5d0ZMYkdMcHgyZjZQcnQrVVBEZ0IvNS9GK0ZaWm04aVdwUnFFczd1?=
 =?utf-8?B?c0hzelVKMGtIVnlNM0J4RUZ0SHBmSHBlajZ3NS9uUUs2Q2tsTmFYL0RMRE53?=
 =?utf-8?Q?GQQR1rmK0rH0zrQlFE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW9yYzVOY0h3Zzg4OENDTzNwT1ZWQXhFUkpxUlFueUVvWEVMb1pBM3UrVEJa?=
 =?utf-8?B?TEU3dS9hUDZiYzVrVk5vV1BnNUpML2FRWTRyalo2TDhUMFNRVW96bENSQWlE?=
 =?utf-8?B?U0pPZGlmaTV3LzZ1TWFabDRyUlBGMmxXQm0yWnJJTjJ3M2N2Y3ZDZmdoOCto?=
 =?utf-8?B?b2p5dnUxUXkwVVRHeXBFQjljNDlQWFlhelZJQUhKb2tKaHA3dGR1TWw1WEll?=
 =?utf-8?B?bWpzODF5cVNZRytSaUZURzNQeWhYMVRuSllGSVVHeUh3cjVpbEJsMGRyTXI4?=
 =?utf-8?B?c1dkcVozWjYwTXloeE9JVXFIc1VMbHdzNHl1NjAxcThvQkNqQkFQcDIxQ0JR?=
 =?utf-8?B?cXE0eTdOZTk2M2lkZExGU1lOWklNVlo5SlArQThjcEVUeXFCOEQ4UmxWN1Np?=
 =?utf-8?B?WFBhMmV2cGorblAzNG9Icmd1TkQvTEk2VU8zbWxaMUJWMFZFb0ZLZk41MHRn?=
 =?utf-8?B?cUcybE1ZbXZQK0tTSzhYajV1L3B5VXRPb3NjSXhtb05yRjA4QjVpMjIwTWNW?=
 =?utf-8?B?bFEwQmJHR0dLU1I3VFNGRm5GNXBHemZRemlmbFJlcUxMMm45OXJ4YkhKQXk4?=
 =?utf-8?B?SkVUQVk1MXJLTEpZYnVnd0ZONlpZQXdWbzZ2U2VlOTFRVEZORmg3Vm8vdVdB?=
 =?utf-8?B?cXFnTTI5MmRGTjl3WUM4STBXTEkwVm9XcnFxWllzWE5xbVM1d0d5a3p0Mlpt?=
 =?utf-8?B?RDRyV29DbnNPWHN0c3lHRlNDSklPTUt1K0dJOFlqK3Nkb2Q0ZWpaK0tjTWVP?=
 =?utf-8?B?WnRlR1A3ZnpQbWZiOWVOTzBnUmkxTHBIQkZGWGlFSVNIeU8vQktodjk1d0E3?=
 =?utf-8?B?WGpjcHVYZWZ0cDdlTzZDd1JjOFJUb2tibXQwSjJFTlpYOWY4ek9rZm5INUFP?=
 =?utf-8?B?Z0N6NlZzK090eFRxU3ZSUSs2MWRVN3RQdGhNTE4zUXltWDFkSG90OU9wanJM?=
 =?utf-8?B?M1hiYVAySVFJM202UmlQU2FGQS9KN0tsVDUzdk5iaFplamYwN0NubENDdjZW?=
 =?utf-8?B?WmRZQ1JucTR3U09ENE00V3VzdldzazNTNjdyRXVxdnNnZTFWQW9WeDliS2FH?=
 =?utf-8?B?aDFwbit0L1JUMUVhaDBRejFQbHBpMTdRbXZhek9UOEhuY2hiUlZmRW1iZTNu?=
 =?utf-8?B?b2preXBPSDIwTFBQazVmejZBVFh0c2o0ejhKMEt5Q0lQbmE5dDY5L0JZK2tt?=
 =?utf-8?B?aXY0Y1l5M1lON1NrYUs4Nkp1R1AzMDdKU2dTQ2lmejkzWnMwUTdNbFY5VzlS?=
 =?utf-8?B?QkhRQ0FuYUxvNHUwTkZaN2ZsTGlCM3VJY3NoTkN3VjA1V2JqSmQ5V2JIUEs3?=
 =?utf-8?B?RFZJUitaYTJhekc3MzN0TDhWRGxycDk3Zzc3YndqNWFTbnlLTytqWlo0RzhO?=
 =?utf-8?B?aGR4aVNualYzL3p1UWFEd2ZIY3RiS01QOTBGS1FNVkdXaGFZTk4rRkQ1NjJU?=
 =?utf-8?B?bE91NHVrcXU5VE4yQ3dRdytudjVIYnM3NWd1bEpRelhUbDQxcm4zZHlWYzE1?=
 =?utf-8?B?dzd1c0lhV0RFc1hJdjJNQjVLRmc1YU1PRlBHb0VlZzlTT2pOcjR2RFJuVFl2?=
 =?utf-8?B?SVRFUTE4aUEyaXNFZjRhcWJiVGtad1NkSHZlY2ZBVEdTZHJKYjgvY1VQWnlN?=
 =?utf-8?B?THFraHM0S09jRE1Sd2t3dGtyNVRiY0tCVHdXa0xyRE5wRkVnVTdrU0Y2YzlI?=
 =?utf-8?B?T205Zjh0b1ZIV3FxcFk2Y0ZMeTBKSTNZcE1iQjJJclhCTEdHYUdYZXAySEZo?=
 =?utf-8?B?N0wyWFlkcFlWWWxtVDAyUStqMEtHRzVRNWt4RjQ2NndvNGFqUUYveFhtUkNN?=
 =?utf-8?B?WGdUQm12dm5mc3hCUERNRjg3a0pldzIzeXB0aVBwcFJpYUdEdkdWOGpFYmhF?=
 =?utf-8?B?aFptWTVUaHZpckFmS2ZWREk3cWJWMjZIQUI3WXdsdXoza1MveTFNT3lkUWNU?=
 =?utf-8?B?Z1ZrNnM5T29oS1loY0diS05UVktKWDZvZnRKdXhITjdQZ3N6eEwzVjVHbHdz?=
 =?utf-8?B?ZFBVd0gxa0lGd28vRVlURlVWdHl0NGplWVVUdlc5TU5SM21BTHRwVnI5TXRh?=
 =?utf-8?B?UGNtU0xPNUtMdlhrVU9nRm1ORmhsWFY1dy9FbTNtV0ZERmFYdUN0UitMdVpR?=
 =?utf-8?Q?cgQwr6a8jnVK/nOw/SefFWgIX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5514b1-ec6f-4c4d-2115-08dcef904f0d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:17:06.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VF0jiilaN39jSvIbjUjFazQOtD4tDLMP1GY+Q+PParL8xc6C0Up0IGE34iRmWA5O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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
    <p>It is safe to access dqm-&gt;sched status inside dqm_lock, no
      race with gpu reset.</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
    </p>
    <div class="moz-cite-prefix">On 2024-10-18 11:10, Shaoyun Liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241018151005.743103-1-shaoyun.liu@amd.com">
      <pre class="moz-quote-pre" wrap="">From: shaoyunl <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>

Add back kfd queues in start scheduling that originally been
removed on stop scheduling.

Signed-off-by: Shaoyun Liu <a class="moz-txt-link-rfc2396E" href="mailto:shaoyun.liu@amd.com">&lt;shaoyun.liu@amd.com&gt;</a>
Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index b2b16a812e73..edfb9f98555f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -202,6 +202,8 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r, queue_type;
 	uint64_t wptr_addr_off;
 
+	if (!dqm-&gt;sched_running || dqm-&gt;sched_halt)
+		return 0;
 	if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
 		return -EIO;
 
@@ -270,6 +272,8 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	int r;
 	struct mes_remove_queue_input queue_input;
 
+	if (!dqm-&gt;sched_running || dqm-&gt;sched_halt)
+		return 0;
 	if (!down_read_trylock(&amp;adev-&gt;reset_domain-&gt;sem))
 		return -EIO;
 
@@ -292,7 +296,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	return r;
 }
 
-static int remove_all_queues_mes(struct device_queue_manager *dqm)
+static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
 {
 	struct device_process_node *cur;
 	struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
@@ -319,6 +323,33 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
+{
+	struct device_process_node *cur;
+	struct device *dev = dqm-&gt;dev-&gt;adev-&gt;dev;
+	struct qcm_process_device *qpd;
+	struct queue *q;
+	int retval = 0;
+
+	list_for_each_entry(cur, &amp;dqm-&gt;queues, list) {
+		qpd = cur-&gt;qpd;
+		list_for_each_entry(q, &amp;qpd-&gt;queues_list, list) {
+			if (!q-&gt;properties.is_active)
+				continue;
+			retval = add_queue_mes(dqm, q, qpd);
+			if (retval) {
+				dev_err(dev, &quot;%s: Failed to add queue %d for dev %d&quot;,
+					__func__,
+					q-&gt;properties.queue_id,
+					dqm-&gt;dev-&gt;id);
+				return retval;
+			}
+		}
+	}
+
+	return retval;
+}
+
 static int suspend_all_queues_mes(struct device_queue_manager *dqm)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)dqm-&gt;dev-&gt;adev;
@@ -1742,7 +1773,7 @@ static int halt_cpsch(struct device_queue_manager *dqm)
 						 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
 				USE_DEFAULT_GRACE_PERIOD, false);
 		else
-			ret = remove_all_queues_mes(dqm);
+			ret = remove_all_kfd_queues_mes(dqm);
 	}
 	dqm-&gt;sched_halt = true;
 	dqm_unlock(dqm);
@@ -1768,6 +1799,9 @@ static int unhalt_cpsch(struct device_queue_manager *dqm)
 		ret = execute_queues_cpsch(dqm,
 					   KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES,
 			0, USE_DEFAULT_GRACE_PERIOD);
+	else
+		ret = add_all_kfd_queues_mes(dqm);
+
 	dqm_unlock(dqm);
 
 	return ret;
@@ -1867,7 +1901,7 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	if (!dqm-&gt;dev-&gt;kfd-&gt;shared_resources.enable_mes)
 		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_queues_mes(dqm);
+		remove_all_kfd_queues_mes(dqm);
 
 	dqm-&gt;sched_running = false;
 
</pre>
    </blockquote>
  </body>
</html>
