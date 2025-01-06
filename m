Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF7FE77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 06:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C14410E593;
	Mon,  6 Jan 2025 06:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbvYTGaJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E566A10E593
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 06:51:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FePPF5/mk927LBFlY9Wr29LOA4IoyS+f9HDY0ibvjYjknTsmGGje3YMCy6TfmjMMFOYY8lrvB8/OLTF4Gng1n6+wQ/Mi1gO5Onfn6KZAWEm98QhQ0/4WRRhdoF2c69Nw6aNCxSttSojgERabnNfx4iqyx/JrkfLpvNCXYVlh+MciVnSS4aZwuxzkWzGWXl5mFyrhNWNXUgIPHl/W48EEk4i7hbNQo7yfJ1el9v9xH9h4Ld8Q3AqFs8LKepUSEpkp69qv8Ih7KQwUiRfvfJfdGvOCJdo4qo3zrsOeie2lcqvbv/BXk7wlzvLiZVnTYCWLG6pIRVtQIjjkLHYIOGslww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlbLhJXRZqrlTQQY3qAV4IC0laUGU5R8dTq7um0tj4M=;
 b=CeKAp5GR4/sxVbHVeN+6kCrVbvAEA8bV2FMp4qSViIOgVqX3iTOdzdj+weVT6h3AnFOLmd6RLgx7usxJYJdzHOJpsMh/mpnHZEpICVeg1oOPuxvp4PQoefGdJoZOYxXoTEhyzMeGpO/vV8EfLbfoqXINcFvIxExA29ltKjb3gnS9T6HZLUEF/t141Gr2kJUMrkG/UnCE4IwYh/DZQDE+jZkA8bbKEHdWyleHn0c/sM7WtpArVq1phATuJM3T2kBz6/xfOLL29ckcX/NQ9InzIWYjuT6oz1oJ5RSgIgqEXLb97lVPVI6PMjvZWayS8KswpE0A0UqJculsfiLqZhprMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlbLhJXRZqrlTQQY3qAV4IC0laUGU5R8dTq7um0tj4M=;
 b=DbvYTGaJEjxBk/Wjb6I9enbzidgcmg1Act8XjNXrSGCdq3mDgo98iXIxSE8AwEyTGWfeFvqogzZ2sjMXMxgJzuSQzXlY6qMvTD6m8LTpZbA4YdmZqp3DXgVY3JW1j9EeYqLnmBqTXNFXA2WsMhkEqvf5t21e4aB2rboQfvus9ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.16; Mon, 6 Jan 2025 06:51:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 06:51:07 +0000
Message-ID: <cefb9a61-c6d6-4867-a9b7-4fb9f3659651@amd.com>
Date: Mon, 6 Jan 2025 12:21:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/amdxcp: introduce new API
 amdgpu_xcp_drm_dev_free()
To: Jiang Liu <gerry@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <0380e1585e7b29426e0c9ff49b84ea071d9c4610.1736044362.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <0380e1585e7b29426e0c9ff49b84ea071d9c4610.1736044362.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f18743-fcd0-4a51-d607-08dd2e1e7f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGlROVJvN3ZpVC90WEdKa3hNeFMrR04xV2dHYVd4QzlKeUZjcmdUeHFGM05S?=
 =?utf-8?B?SEFWd2FzNmNHOGgrWENuL2c5K2trMm5ZZXNubVBFUW9wV25PV2I5NjFTdUNE?=
 =?utf-8?B?TWlla2JuaG8xcGprSmlTZE8rSy9MSndvc0hMYWdCK3Q1SzF6NG5ZalY4dmFG?=
 =?utf-8?B?SWlxRUFCYUlLdFJzcGFaelRwSEo4OWRGdnVEWjlDRTlTTUQ4amdnNHpUQXlH?=
 =?utf-8?B?b2xSV0UyaDY2UlRxaDViY2ZFVGNNVUtlMm1XYjBMaVkyMUpkUTRCcXJsY1Zm?=
 =?utf-8?B?M3J6K25jY0NQaUVMUnFlbERER2pJWHlNdGUvQTV1Y1hDUHB6dTZtSlRtWW1G?=
 =?utf-8?B?YncxZWlJcFF4dGl1NE5IMFRxN3hwRVVjNGFnSmVtUjVMc3pnRWhqYTlMbHhx?=
 =?utf-8?B?bk01akcxQXZ0YnpROThBMkczbTVwN3k2Nkh4ck1EeU9hT2U1cHFzd0FCd3cy?=
 =?utf-8?B?bkE5cWNOVi8yek5IOEJGYkpDelJSQ2dZRWwwMmRzWGQwRzlXUGRFc045S3R6?=
 =?utf-8?B?M3lEbkxTVE5iUDFGZHprcDhITUNJdEhmM2h5b2hnVndOV2lCMkRjSCtSWXFv?=
 =?utf-8?B?VytLVUh4eUZhVUJod081Q1ZzMExpQzdhU25iT0dRRU82c25zcTBxNEwrdW1Z?=
 =?utf-8?B?V0trMkk0TXhCbFpKQmtIeGlFUit0WXlldWRMcTNzRXZHRUVpRUU5aHl2b2Fx?=
 =?utf-8?B?YXNGbVpnbGowaWlLcnRlZ1NmRGc5QXVFMVFLZW1XU0JUN0Mwa29KUUUrRzgr?=
 =?utf-8?B?SFFEZ2gvdjBOMC9XR1g1WjNNS3ZMWlJCY3BiSmxWVGlsY0gva3pDTisrYjI1?=
 =?utf-8?B?cWVjTFRGV0xlYk9BM00waCtOQkRnY1lwblQxMUdQdThZNTE4K0VCZHpwMGE5?=
 =?utf-8?B?T3BOS1NVMzJHV3RmS0hyTkF2c3Y3MlZSUUtyZ25rMWFJNHR2d1FZYU9vK2E4?=
 =?utf-8?B?MDd6eXZJS1JJU3V4b2piMjNndjcxOW9wdkRoM1NnbjJZUkhGVi9iSWgzMkRL?=
 =?utf-8?B?WFI3aTJiVy9XcEt6RisxbkVWWUlHZVF4VjhZdjVtRlpudE5aek12dmRJRTJj?=
 =?utf-8?B?QVE2dVJMTW1TYitvOEM2Q3ArUk1jMk5VVDZueTgwMGl4WnJ5M2JLSWhGM3d4?=
 =?utf-8?B?WUFBaCtOOUNpZzU0VkVJUHZqcTZIZ2Jnak9xdktIcWNKaGpqSXpVTDNNbzM5?=
 =?utf-8?B?Rjc4MVFGTCtackNCN1JHWmE2WXpNczVVVnVFUTZaTE5KbWVZRk5VSGlLYWJz?=
 =?utf-8?B?U04rNU9DVFRxdWtkenBubkQyMjJtbEFnMWU0ZFY2VXpUaENFUFdDWGJPM2pt?=
 =?utf-8?B?ZHVHL3pVNXdVRXJFV0FiMXAyU1VlRFJ4cm5sd2ZJaVFKNGtzdHZOVHlqRkxz?=
 =?utf-8?B?RVlmWndmOXNjRnlPMHo1UzFFMzZ3dVdDd0x5eDZKaEZhemRWMG44K212WXBX?=
 =?utf-8?B?alZQd0tYOUpvaDFHbDBaK2dZZ1VUODhneHpid1d2Q3hvWGdPSGdHeFhBK24v?=
 =?utf-8?B?VU5CSm5sNEZEQ0ZjWjREY2U5YXVFdjRxdzdKbjZnbzlsYmkyN0ZiTzlMbVVS?=
 =?utf-8?B?MW13UE9oRS9zSklBL2ZPK1VnZENpelljcTkzc040QmhabzV2MG5YZjI5WDM0?=
 =?utf-8?B?d2tUT0cxaGtkNG5idEM0ZmpDUVd0UTNlaTkza3F0VEY4QTRIVlh1VmJQTXM4?=
 =?utf-8?B?ZzFzUFFDU2UvWThOYko0YTFUTXFkRjRBTHJ6TTZnTU5NMzQ1TUhjTnlUZStt?=
 =?utf-8?B?MzdUVm9LMHNBR0tHQ09mY215Nktkb1VKd0hlRVRqZlB6SDFMK1FycDdScHlJ?=
 =?utf-8?B?V3BPb0ZhSWp5NVByQml1MTcwcWZnUElqdE1tWUpDMlJmRVNHODJpb054SmxB?=
 =?utf-8?Q?Q37zsS6Rhyyew?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS81dXBvT3VsUWdKWld1cW9RODhYdU9jek1GS3hmZ3hzaGZicTZYa2UreWpU?=
 =?utf-8?B?RDA4aGJoRHZDRUY1M0dRN29Cb0QwZ2pPU3FGajFKMnJIa0xhM2NEUlo2TXlZ?=
 =?utf-8?B?c1gvNFZOcVh1bHFINExXQmtadGwxMGlLaWFyTzdlVXdGWnR6OUkvd1hrQmVv?=
 =?utf-8?B?MHZVSzdrM3Q5ZU5vRWtmL2xGSkdIUG0wMWpRR1owdTlDMmVxSFVMa25VYWxM?=
 =?utf-8?B?d29VeFRXa0xCUUU0SGJRRkZNRXZZRDJSRFhJQWVybFVQRjNxWUhZT2NjTjB2?=
 =?utf-8?B?MXl1cHpQWThwcGVRbWNKSmNXZmVrVGZvVm91Y1JNSVhRY1Y3bGN6Rmg5MFZU?=
 =?utf-8?B?ZWpzdzFtWXdtOEFOcUw2N2tZQ3VzaVVKOVhESG81dTZ1bUdmUTNFZlUyS05m?=
 =?utf-8?B?QWd3eDg5aVdMUlBMdjQ0WEE2MSt5ZFVraXJNYytYMTNodXdCZkFOcTFkNERC?=
 =?utf-8?B?QlVSRWFwV2Y1RE5uTW1qZkZkKzIwUlgxVDlOV3B1TXljTWlySEFERERvSU16?=
 =?utf-8?B?bGtGcUxvSDBrUy9rcmUzNjBuUnh4R2dvcVBCa1NGVzN1U0l5N3FsZi9PTnJL?=
 =?utf-8?B?WGV1SnVJYVUrY052SlJsNVdSblFxM05pTVN1OXArSGt0bEN5OUh0RkNUUzN4?=
 =?utf-8?B?WG16Tk1ORWFIblc1MkJlRWRhU0swNXhiY1VIL295bHZacnhpZGk2TFdkWnNm?=
 =?utf-8?B?TUdRdGk2UnBsU1hYaUpqWERXcDNmRUJTclNDRTVtYUU2SjRVMEMvL0E3WEFP?=
 =?utf-8?B?dTRwU2NSQXVuTGpHclZoSHNFSFdheXZmQjRXYjA5SnpzeEQwcllOVUtWa0ZU?=
 =?utf-8?B?TnE5UjlyRUVyTWpvbVRacjExQUpOSnhGalVteS9Iem5oalVQU25kWjJDVnBq?=
 =?utf-8?B?cjUza0ZUUnhlMlJxb0lUaTl4RExyOTJwUmlQM3VWbjBqelMwcXJ3Wjhxb3Rt?=
 =?utf-8?B?TFMzbnU2SGlOYzlUa0pTOGhnZXNVZDlnNGJ5Wk5mc3QwREMrN3JaNWhxOUVw?=
 =?utf-8?B?ZjlyRkZNWVEwb2FCdXhxbm1SOFJPSmdFZkV6YXFlOXhaU3dTWHpnbFY5QUNK?=
 =?utf-8?B?VVhGZ0NzYll4bWFNYm5icG9uUzdJWitUZ0k0clB6OWpZem9WblV6eFFTUUdG?=
 =?utf-8?B?ODB6WFlGSFNJZ1VFaHh5bVRrNW9Sa0JPNGMrTjZDdG9OSjZtVURVUGJaMzVp?=
 =?utf-8?B?dXU4em5lWlN2Zmt6L2lzdDIxQzVwWEk0SlpESnFnWDNhMENoQmd4clNMdVZ6?=
 =?utf-8?B?L0dpZ0J6OHNiVnU4dUhOQmxHM2h2cnlWeUNnSDZzT1M5Z3JySjZ6UnBqVHor?=
 =?utf-8?B?UUR0ZnR0YTBGZ1VKTHhFMmJTTkc1cTErOHJxU2ZCV21CVHdYYmxBUjhkQWdB?=
 =?utf-8?B?ZDMxOTIyNksydE1mV1hiTVEyTDZsTDZuODVQTkpQZyt2SDdFcVRoVlJpbkF5?=
 =?utf-8?B?alJaL1NncEVVTTRZZW9CdVMyV3BZdUJYZ1lxWW1kQUVMNXh1NnRhd0J0UWlR?=
 =?utf-8?B?cXVBVUVFcXk2OW9YVjFOTTh4V3J4NzE0elhrTW9QZTlIOXJNbXB5VGV5V2hH?=
 =?utf-8?B?L3MrSGhlbGx6NDl3bExiM1picTBzOVpnaHovQ1gzNElyQ3ZXWjNweEFLWmx1?=
 =?utf-8?B?WU03elFUYjhqV1Y1Z2hPMm54ZGlJYXJLRGN1Z2FLMzlsUUNlbWlvaUY5RWta?=
 =?utf-8?B?OG5FNHptYTNWekd6K2FDUkcxTE8wMWJ5RDdpNFZ3TGt6WFMzQkRlcnpsWCtW?=
 =?utf-8?B?RUcvQWVOam9JblVLSHRIaVVvbEg1VkQ5NFNYcVBSQ05WUVlYMFQzdytXcUlG?=
 =?utf-8?B?YXlaZlZYWUZUWVcyRkhxbnYvdlVFR1ZCTXpvRkc5VWErV3QwUk8zU0RyZEw5?=
 =?utf-8?B?dHBxeVFaMjIxdFhSYjNqcVVuNzVHQWtrMVJzREFwVkpoZ2o1N2U0bk56VTlv?=
 =?utf-8?B?Y0hNdk5rbDdpc3NZejhXbFZ3ZU13T1QxOUJ1eCs4ZTBmTEJMUWV5dVIxVkpu?=
 =?utf-8?B?QmRxazNBdGNlaVZmdTYrM2x6LzlyVVhYbEFqaUxTUWZKUCtRTEFvUUluOHRM?=
 =?utf-8?B?TlV4SXVsN0ltQ1BIbzNmSGhPQk85RWRudnRjd0ErTXV5dmJmNFA1bGNMeElm?=
 =?utf-8?Q?tMIGcWi0uh8zPvNGgA+ZZYb/S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f18743-fcd0-4a51-d607-08dd2e1e7f3a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 06:51:07.8767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2eLcQcaZBZU6eamaOZdvgqqaoYWUdhSarV1c0wjzA5PKCNz+5wbec4ngvN18CNr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220
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



On 1/5/2025 8:15 AM, Jiang Liu wrote:
> Introduce new interface amdgpu_xcp_drm_dev_free() to free a specific
> drm_device crreated by amdgpu_xcp_drm_dev_alloc(), which will be used
> to do error recovery.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     | 11 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h     |  1 +
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 70 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  4 files changed, 70 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index e209b5e101df..401fbaa0b6b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -359,6 +359,8 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
>  		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
>  		if (ret)
>  			return ret;
> +
> +		adev->xcp_mgr->xcp[i].registered = true;
>  	}
>  
>  	return 0;
> @@ -376,12 +378,19 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  		if (!adev->xcp_mgr->xcp[i].ddev)
>  			break;
>  
> +		// Restore and free the original drm_device.
>  		p_ddev = adev->xcp_mgr->xcp[i].ddev;
> -		drm_dev_unplug(p_ddev);
> +		if (adev->xcp_mgr->xcp[i].registered) {
> +			drm_dev_unplug(p_ddev);
> +			adev->xcp_mgr->xcp[i].registered = false;
> +		}
>  		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		amdgpu_xcp_drm_dev_free(p_ddev);
> +
> +		adev->xcp_mgr->xcp[i].ddev = NULL;
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> index b63f53242c57..cd06a4a232be 100644
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
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..9058d71b4756 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,26 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static struct mutex xcp_mutex;

I think this needs to be static DEFINE_MUTEX(xcp_mutex).

>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, index;
>  
> +	mutex_lock(&xcp_mutex);
> +	ret = -ENODEV;

Preference would be do this inside the below if() to associate the error
with the condition.

>  	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
> -		return -ENODEV;
> +		goto out_unlock;
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (!xcp_dev[index])
> +			break;
> +	}
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", index);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);

Seems mutex is left locked here.

> @@ -72,10 +80,11 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[index] = pxcp_dev;
> +	xcp_dev[index]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
> +	mutex_unlock(&xcp_mutex);
>  
>  	return 0;
>  
> @@ -83,21 +92,58 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  	devres_release_group(&pdev->dev, NULL);
>  out_unregister:
>  	platform_device_unregister(pdev);
> +out_unlock:
> +	mutex_unlock(&xcp_mutex);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> -void amdgpu_xcp_drv_release(void)
> +static void amdgpu_xcp_drm_dev_destroy(int index)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = xcp_dev[index]->pdev;
> +	devres_release_group(&pdev->dev, NULL);
> +	platform_device_unregister(pdev);
> +	xcp_dev[index] = NULL;
> +	pdev_num--;
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	int index;
> +	struct xcp_device *pxcp_dev;
> +
> +	if (ddev == NULL)
> +		return;
>  
> -		devres_release_group(&pdev->dev, NULL);
> -		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +	pxcp_dev = container_of(ddev, struct xcp_device, drm);
> +
> +	mutex_lock(&xcp_mutex);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index] == pxcp_dev) {
> +			amdgpu_xcp_drm_dev_destroy(index);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&xcp_mutex);
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
> +void amdgpu_xcp_drv_release(void)
> +{
> +	int index;
> +
> +	mutex_lock(&xcp_mutex);
> +	for (index = 0; index < MAX_XCP_PLATFORM_DEVICE; index++) {
> +		if (xcp_dev[index]) {
> +			WARN_ON(xcp_dev[index]);

Why is this WARN check needed? There is already a if() check for valid
index.

Also, would suggest to separate out amdgpu_xcp.c from xcp_drv.c. xcp_drv
introducing a new interface may be kept in a separate patch.

Thanks,
Lijo

> +			amdgpu_xcp_drm_dev_destroy(index);
> +		}
>  	}
> -	pdev_num = 0;
> +	WARN_ON(pdev_num != 0);
> +	mutex_unlock(&xcp_mutex);
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

