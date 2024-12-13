Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE0E7717D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 10:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F9B10E8F6;
	Fri, 13 Dec 2024 10:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XD8Kelbz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDC310E8F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 10:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OzN9uMFDyoYliW0SDHzFYNF9oy52MqGLRpZjrRhTjc6X4eH8UTqT7eY32n3gEfj4RAr8u9VooBuUS9GDOAP9HqfWAwvcRj6a3b3+OLmsTWq/ymFldMKpq9x4Z6wxx88XrDrMPljYqxrDuncDxyWjf1uP/rkhlrgeL8gdd/nbwbHddVpk4Rj5GDGNli9dfuBGhVyQVYphpVmHaiuxdxFXr46nNTCAL8yfRWpsCpmRNNYQZwFuCpxL5LSsQ9Gj+JF0vT2PB1qCTR0WaEREH4bVqyPt3THCafuIxqZi8w0NdCwtMMrv8pZqne1RRmzUlHYy4OaiCgl6ONhT3cduCprA7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPbbuVh9Yki/HRGPiCCmNMkL+d9mTU1pLk/OCkzcPxc=;
 b=a9nyjqkpuczR8jLgt2E4HmDmwFaSSrfcqtS1O6qfu9OvnedHnLbcmNE2sZKpj7kicgSRWK+XniT0/ThWqjy9d3R2dg45KMhWkQOh7rK/n587HbkjPq4VAdle+7fKEGnIw6+cU+dlN8ZNCE8oNhi3+MsNlaVEe7iNxqqk09mWJVU18uDMoX0y2v6mLXacAzy0YYuiDZgfQDvVZlqqpA5oFjP8SEDmKP25KpArraUE1eCX+PMVkCE1v/aLnpOONKbnwSJUXanI99pu/jpg3+855SAIiF9X+fHyY29X+oNvgQzQ9mygJRgrlAE7G34EV+G23+0KKCfxyRfiafe9ojk/wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPbbuVh9Yki/HRGPiCCmNMkL+d9mTU1pLk/OCkzcPxc=;
 b=XD8KelbzW6FkdSHqiTr6F8Lq/IsrCydLKCsFSFhIMYK9FNyH+pUjGDzvbDty2KzG4K2+VpBd0sNLLE9yFH2fHJ9Hxe8Q7YBSG6Tcg1aGvxMXXFFXc1CoP59Q+gFWP2LS+hCxKdEdsI1hqjkbPhzUf4p50oHWbEIR5sksIxLxcx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:44:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:44:08 +0000
Message-ID: <432702ed-e952-4fe4-8b07-a85ed7b963e3@amd.com>
Date: Fri, 13 Dec 2024 11:44:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] drm/amdgpu: Modify the MES process va end limit
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
 <20241212142533.2164946-5-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241212142533.2164946-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cfc1efb-9a8d-479f-4d68-08dd1b631273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2JtNHRFcUp5US9OVENGNHJmWFgxd2MxTTR2QWtpRGphOWVvSFFVWGZMWVBu?=
 =?utf-8?B?WnlyL05neGNRcjY2dVJGbndOKyt6Mi9KVFVRaEp2L1ltcVZqUTBJL2pISkh0?=
 =?utf-8?B?VU4rQnpJR1JRMGljRVp0STA3M0RDZWZzMEVraHI3U0QwdUlrakhlQlFJYzNK?=
 =?utf-8?B?bzdjQjBKOEI5bzlZd3R0M3BhS1lkRzNKUGxSYnlPYkVKSFlvWVZFZVBSMDVW?=
 =?utf-8?B?b1NVaWc0Y2pkNFVjSkg4eUozNzVyV2hWMDhXT01haDVpc1dPM0FnTGFGNEcw?=
 =?utf-8?B?cERrZGQxbFVJb0tWdWdOb1JYekxFakVFTGRGU0NLN21TdE1NQkt0UWpqcWtj?=
 =?utf-8?B?MzRhMGVCUlkyVHJ1T2RRM0dmUjh2Y21RbVlSRTVPTkk1clBTUnk1R1dOL0Rk?=
 =?utf-8?B?ZEhNQk95ZjVvdkY4NzVCcUcrQ0g2MFBmQ3pKS1ROS3grVnY0b2R5ZXFscGhE?=
 =?utf-8?B?MVlLY1lkRWdCcUJicTV5MUxtQmxwKzFpLzlOT2ZqbXJZc2dVdFI2NjliU25Q?=
 =?utf-8?B?ZHV5TjR1TWNhK20wM0NPSVZ3bVljU2dpVU9lUXRjQmZQcytpZ0s4NTV2aEtI?=
 =?utf-8?B?ZGFERzBRTzVaREpVNFg5MklGeWR0SWFUMTNMS1lOQmZkekZFbEdWRE5zRWFj?=
 =?utf-8?B?ZjNlNUw5TlgxQklKbG1JdUdyZHF4SjhQa2h4M2VocUFEalQ0U3RFeVNLVjli?=
 =?utf-8?B?aTF6SllPL2l3ZXZFdktjMDdocjU4TnpLRnZUN01FSHBqL2JlYWxneXZHeEQ4?=
 =?utf-8?B?RUloS2hhckpYZXRPUUdyOTZqczRFUzl0dUNTTzhySDlqam5FZitIejFFV2hu?=
 =?utf-8?B?aWU3YTBwdDc4MTFYZXdtbUdIV1ZtVG9vRGhkZEVWTjlHajgxR2MveTFlQkpx?=
 =?utf-8?B?dHZFZkxQUzFsVG94ZUVJM1lQNytZMGt0RlBwbUR3bG5QMDlGUzRVOHMvNERh?=
 =?utf-8?B?bmFqTnd4WEl1SUlLRUFvUlRsS2ttcUVSckdqdUhrakNndmNTa2p0VHovY1NM?=
 =?utf-8?B?NldCZk5GNCtVU3grN2R4Y1gwN08zVGlXTktnbXBRaVpSSG9sci9HVlMwK1F5?=
 =?utf-8?B?ZnpBM08wZmxncWhOVGZSRTdzMTcwL0drcTNrTGFqMDhWQlc1bWtjclo0RDZa?=
 =?utf-8?B?Rkpva0lwMko1K1kvQnlGek9MWXI1SFh4VTluN3V0RVgrQXRXSVZlTVZobXkr?=
 =?utf-8?B?Nzc4TXFJYW9JajVjRzRNckJ6eFdsL0pvWCtnVnM3akNGbzBqOFRudlZXQVdz?=
 =?utf-8?B?WmRXdTJmcURtQlliM2F0TlM3TXJ1dGtPcDlzU255ekZpYXo3ZmZ3SitHU2JG?=
 =?utf-8?B?cVdwWFhSV0ZDL2trejVJaXZHNUlzMnV0TU9RTU9pa1BLUkNSZXV6OFVZcVhO?=
 =?utf-8?B?dVhCSUxJVW03bTlQMmFTYVNTenFhMjNrTWFYVXc4MFB4ZWNaRkp3MmE2cEdB?=
 =?utf-8?B?YnQrU0hsMU02UHVnb05RMEEzWEIzSHhrNVB3VjNqK2FHM0RBNEFlM3ZNZml1?=
 =?utf-8?B?ODFQMXdya1lESkh6N0RpNlhHcTlCU2lsK1V3d09JQ05aeFNmL3VxVGhIenZa?=
 =?utf-8?B?bmhyRER5NUtGRTczRmlCSTNFaGVaaGpvdXRNaHdpeUdacWJCT1UycUt6aG5y?=
 =?utf-8?B?NEllKzZxMDlzZjRoWklaZUVJTDViOFk5ckdXTHcyN2ZZMkY5NklwaWJ1cGdm?=
 =?utf-8?B?bnhJcEFEeUhBc0xvTWhVb3kxWUxHOXZha3l5S0FtSnR5dzdPVTlEa3Z4SVJH?=
 =?utf-8?B?cWUweGlJalVkbWtEY1VVbXNnTmcwRTJPQW95bmo4WGNOdnd0YWlSaWErcG5H?=
 =?utf-8?B?RnRuSE93N2hCOHdIclkreUxPbWdJbnk5VThyZ3o1cUNMUWUwYXFhV3BMTDN3?=
 =?utf-8?Q?t6metGtCVYqnL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3o1U29ubC90WTI1TlRrTHYwWUwzMFQ0R0UvUWczeUROcG1IQmZraXQ2NVRJ?=
 =?utf-8?B?MjJzQmg1bS9HeGhsSmI3SHYvaUxHNWd5M2doR3NocFN4Y3dtVUZUdU9aUHJR?=
 =?utf-8?B?Ry9uNDliSHB6N25sa084aHpyMXNFR1ZpaFhXbllpQVVYSU9zWFZpeU1KbFBO?=
 =?utf-8?B?M0sxVkd1UDB3WEVaWUxxMVp5N0QreHNDY0RBMCtLNnU2MTZ0emNOOUI4czV4?=
 =?utf-8?B?TXZHS3NFc3JCT3NLRlhMTGhacmp3TlVWaUl0bW5LdmF5NlpjRU9iajZZT0lQ?=
 =?utf-8?B?WlJublZoZ1VxR2dsTFU2QVA4VEJzaXJrUVBtMnpUcUF6dnVBaEZhbWdqTUFQ?=
 =?utf-8?B?YXNIKzZCTHFkQ3U1c1MrSWNWY0lMSGxqQzUrbFk1eGcrQUo5bWtBbTRvTW1o?=
 =?utf-8?B?Uk9JVm92bDVLQjVJOStYTWtXbzh5SFFicnlXbjJwaE12TVdWaHZVNVJMNXJp?=
 =?utf-8?B?OVdmaURzMHFyei95R1V3cS9YdmdEdEZDRjM4S2Q4NFZpTzJyNVhSR24wYmoz?=
 =?utf-8?B?UTh3MDM1c3VJT3BGWlA5ZG5EOGVVUDdTbWwwOUw3b21LU0MxNnhSQ3Nuc0dH?=
 =?utf-8?B?TWNtWWwyK1ovOFA1ektvR21pS1BBVXZMTjZPZUdjNHlJSUdRVDBHNmJzallm?=
 =?utf-8?B?end5SU1neUh1SW4wYWZzMDlPbXNaN3hFN2VSNmZIb2UxdEd6T1p6N2ZYSGF1?=
 =?utf-8?B?RXN2ZFN5V0dnWnB6WlZIUmJEMWZ6R2tZaEYzdFhnK0F6SFo2Vk5mbWhKMXNV?=
 =?utf-8?B?bFBxRGhjdjIzaTEzRGZrbjV6WUFXRXZ3ZElHV0lLYW9yR01YN203WFVoWTBK?=
 =?utf-8?B?WGpaWjZqY3JiUHVPd25mVkVpK0ZmbWYrRG54ZTJUTGVTTCtSWjNyMzRzZTYx?=
 =?utf-8?B?L3pBcmo4MjljQkdSTHV2ekt6ODN0U0ZyQzFuWkUyRWtIMTU4b2lLMUNyclcz?=
 =?utf-8?B?QklwZWp1cytidHoxRkpEYlRTdDRXa0ZNMlJydlVDVUdDRXZWMWhmM0ZCR2FJ?=
 =?utf-8?B?YWJkOE1GeXVPMmVwTlVRSDhWU096d05vM3F2VE1STGppNlhvZzN0bDRpb1Jw?=
 =?utf-8?B?aHNBSmtaL210S2QwTjZKeTZpUEU3UWZuWWliU0ZjeElWV212V24yakVISjN3?=
 =?utf-8?B?ZG5OeEJtc0xtU1ZBMnJ1QmdydzV3bG5ieWVrMVE3OTNsRTFGZDZMU3N2d0dm?=
 =?utf-8?B?Z0o1VWN5d2QrNEFGZ1ZGdEhJTXdTWU9kSFBMVkZkTVFGOWdpajNTQjlPRW12?=
 =?utf-8?B?Y2crMC9qZm84TWJ6NCt2ZnZOMVZURzRtWU1GS0ZMYnJJeUF0LzY2TndGMUNw?=
 =?utf-8?B?SldpS2o1THpqTWgvVVl2d3cweFQza2pVY1g3OTB2bUU2Zm1KaFFWcFBRTURh?=
 =?utf-8?B?K3Fyajc2ZmU4clZGc1ltdzF6K2diYkxiblIxUmJ4cldib0plVWhyNkYwQWQv?=
 =?utf-8?B?cGtGQ1BieWlaRlJCTnFBN1lOMjVoRnh1RlczS01xUHBlQ0prSStxVU9YaGxK?=
 =?utf-8?B?NWR0cXJOaEVQS05YWTZXd1BDbTZoeXFNalhxV2RwT2ZyOVZGT1E2VkYyWFNM?=
 =?utf-8?B?YWFqK1p1NTBnM3IvVzBxcGRQU05qMXlxWXVYbXRTTHd2emVrODE3bjVoNThn?=
 =?utf-8?B?Y0l2d3Erck95V0RrVlFtcVBTY09kVUJZK1hQQUVmRFhyc1JKSk5oVDVQeUVG?=
 =?utf-8?B?RHFXV2lobGw3QmttQndZdWhubjNpMmllMU5PZEZ5VEx1L1ArbU5TUXk2ZUp0?=
 =?utf-8?B?WEhiTHBiYlZPbXl5Y29kL0ZxbmRNSCtjUHFrdFJ0TGxlbXlEeXB0TVk0VXZk?=
 =?utf-8?B?V2lJTFgybjNLaGJCY01qemdVTUlpckhuU1dlNlhvMHBNcG4yNlVkdndHOFZI?=
 =?utf-8?B?NFNYa21xQTJwdFEzTWRyNlhzSm5VTmoyRlR0VTYydVdkUmtuWTZBVWZEN2tn?=
 =?utf-8?B?dVdEUEVqc0FiQjhQcTFBN1hrU2VueWlncGVrcnNNeWpZcm1xRzRRS0Z1bTF3?=
 =?utf-8?B?eG9zcVJpZjNMaVowTGtmWXlBc1l3ZG1Wa01mejNLSnF0QzV5Szlkeno0QzZ6?=
 =?utf-8?B?K3FFY3FMQlAycnlwdXlndVVBMjcwbW5JbGlSYVpXTElmaHZTZ3hCM3pOeER2?=
 =?utf-8?Q?IuQPOIF6GAlNgUJ7QyYDlTlMd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfc1efb-9a8d-479f-4d68-08dd1b631273
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:44:08.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQBN4zattpOVYwM+Xbjb4O467A2D3XnV4QDdKEk274xwEicEv3Vc2alK5Nrk4n/w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

Am 12.12.24 um 15:25 schrieb Arunpravin Paneer Selvam:
> From: Christian König <christian.koenig@amd.com>
>
> Modify the MES process va end limit to max pfn.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c   | 2 +-
>   3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index bb946fa1e912..cee38bb6cfaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -662,8 +662,7 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   		adev->gmc.vram_start;
>   
>   	queue_input.process_va_start = 0;
> -	queue_input.process_va_end =
> -		(adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
>   	queue_input.process_quantum = gang->process->process_quantum;
>   	queue_input.process_context_addr = gang->process->proc_ctx_gpu_addr;
>   	queue_input.gang_quantum = gang->gang_quantum;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> index dde15c6a96e1..ba550c7e2118 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
> @@ -219,7 +219,7 @@ static int add_test_queue(struct amdgpu_device *adev,
>   	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(test->vm->root.bo);
>   
>   	queue_input.process_va_start = 0;
> -	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
>   
>   	queue_input.process_quantum = 100000; /* 10ms */
>   	queue_input.process_csa_addr = test->ctx_data_gpu_addr +
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1dde099382ea..9a6a5553bbc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -109,7 +109,7 @@ static int mes_userq_map(struct amdgpu_userq_mgr *uq_mgr,
>   	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>   
>   	queue_input.process_va_start = 0;
> -	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
>   
>   	/* set process quantum to 10 ms and gang quantum to 1 ms as default */
>   	queue_input.process_quantum = 100000;

