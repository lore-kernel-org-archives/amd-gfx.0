Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCD7CD98CF
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 15:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C6110EA6C;
	Fri, 12 Jun 2026 15:50:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s3D5tixJ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010043.outbound.protection.outlook.com
 [40.93.198.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BEAB10EA6C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 15:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2e5em8K85Y1rSEfYVdlXNo3bnQdLA0+kZ0wvDAcUT1nAl39WrEt+fxJmJldi+1pGdn35VT7uEHTgQlrn0SA8M+ytS3epjOUiuilrfudFryJa4xM05pq76ZfQfgZEq8axGg+BuahxyHSp80yXwQv4+srKhlkx6lbV56Raa9pm6/Bzp+veunQ8djvCKUZU7r2uGR6QaBODRgcYCn7JmQkxujaytYpaRb9hm0fdSLRzu9nieKQsFpA3oYzdu7Ysl/eV79uRPgJ7tYdee6vDnf+16K5bq1FHU0IJ+djTVwKmH/WKvrv1v0kj0TKF6Ynw8QAEegfWYsgfykxvuxJWPIKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkPxGnMtZVx82tZf9L2GNv3jKwDI/lG0eHi1Oz/a9DA=;
 b=XMlsqk2vpjjgD+rVnGm3/Nk6qYUzWybhZjhli2ucb0B2MuikF/1grwgnp9SYsFI8wLjxZCoeH3kemkY+5Sq7oNjIfA8RBegL2QhrAWESVNlnJDtbyRunoMbxnWGfzSGqxOvJm8x68PEPXllR4TsMwEA9MR/Vi8TtaxCYa9aWGcqrV22mUNcDdB0WQPirz8IT4g+ur2xb7HmQeAQZ6M/oX5Q3OxNCqFfhexLG6h2oYI7Bs01Umf9EPTHu5O7Wf/T+RIfmTUozxWY5o6KBTMfvnhitag21l3767gAEEpvaOmtqUqZJnS+CjEEuJCu9gf9h5fY9uV02apP1WMHqLNnc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkPxGnMtZVx82tZf9L2GNv3jKwDI/lG0eHi1Oz/a9DA=;
 b=s3D5tixJo5D9cGFXUOaHmB1x576lZo6PJY/MyPhK34GicOaLG+0BvuxF5n6+XykHCAcsFKpoHJvHEhJzpax/bps++lkxIB28BZypvKnuWggcrERqwYPJ+5+cfzjIFTBUhnl0SZXu7MhlIuqvMGO0Cy35H2lHiU4wLVMhtgA5pVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 15:50:06 +0000
Received: from PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16]) by PH8PR12MB8432.namprd12.prod.outlook.com
 ([fe80::fe06:fa76:b8a7:9b16%3]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 15:50:06 +0000
Message-ID: <17821ca1-ffcc-40b4-a355-38e364a84e52@amd.com>
Date: Fri, 12 Jun 2026 11:50:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/amdkfd: Fix NULL deref during sysfs teardown
To: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260611030150.3713054-1-geoffrey.mcrae@amd.com>
 <20260612000407.3734265-1-geoffrey.mcrae@amd.com>
 <20260612000407.3734265-2-geoffrey.mcrae@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260612000407.3734265-2-geoffrey.mcrae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::24) To PH8PR12MB8432.namprd12.prod.outlook.com
 (2603:10b6:510:25b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB8432:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d4de83-03e8-407d-56d7-08dec89a4604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C4mOqaokQiXXzgmmgCeZQfd48lVriCA1ncaZAudFo+cb+Kk9OIyTumoDgShlqSgOvspf+5FttjS/8mFkmNDAG/1sLKaNWHyEbonBEoRickflzuNnffbNJgwnm8bbFdRz0y3Y7tqqhvNZCwEAvrXD/agx2mVHRY0/UqVzF5CJfb7zR8F8T5LxZrWpk6VZVi/Xpt1lKZDS7szDtCGiKN6/6TZ5RejDwGnjYRe2/BYqBvWtwAp96HyFFRZmaNR82w9qutHE1zWBtEjQCANEDaNnZH7jNpRjgH8pFm0izDPUbzGTTqH5uLJajZdPsh/qGcG8yI0O2QTAoPvuDVEaInmlTTILY+9lSJfnEykCDyrEznkIy3v9IqegqJvHW6T7k6xxcWbLk/wDOoKl1mWcyTUKeK+isgUZnuG7j/efqF//cH0yxi9bxt2dVXt8VvfOZ4It1YLr8C8DlLEIs5RHquKMPguspd5GM2/QmXOxH4M/JscY4ykRqMhMncHyMghsQrgCFRIBpU29hKYQ92VsndD5KEnev1ui7rH6fiyY5lhe3ERN4zdoduPuPdIHXnfIy3iT+wTl34EbOBDlGe64IWk6S/2dotYV9V5csuH1gq+IslTV0EJWl6iTKtPe4mq3/QXGlJSfr4YhISwsz+ueFApOyxj5N/no9gvzQUOSiwTZVh+VHb6X2KBAVao6ximroK6p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB8432.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTAxSXg4RFdOVXBtaFB5M0tSUGlUM21mTVY1L3R4VURJV1ErV0g1eUxaZkU2?=
 =?utf-8?B?VGJNb2VuTTBrMk1yT0o5T2o2Vm0xZDJzV3RxOFE3QkV5QXVkY2hyS1grbWNs?=
 =?utf-8?B?dE41cDFCTTk4ZlM4amVYVWhzTk1qZzhwb3JDL3laMlBlYnlJeTFxdU9PNk1C?=
 =?utf-8?B?emdheDljWU14WHg4VjhyekpOTU5TT1d4US9hNGFZREdkT0IvSUk2RXhlMHpI?=
 =?utf-8?B?UjhYRUkrc1ZETGF6czBLbkZKQkxSV281OVcvbGR3UWgxeTRlTGxpNW9CN2Rx?=
 =?utf-8?B?aVlEZG4yVzUyUkRRN1cwUjVJTWNaaW1OVHJmMGdZK3lRbGk4NFE4UE9URTV3?=
 =?utf-8?B?U3dDaDJheExOTmtpa09nRCtSc3JKWTI4eXdIazRROU85UGFNNmd2R3BWeVlT?=
 =?utf-8?B?T3BmVWdYakc0OW1PWmNtMkY4SFVrbFpKZ1RRaFc4TXo1cVdpL04yOGtpc0pE?=
 =?utf-8?B?OENJS2VwWm5qNUFDRWFFVlBER3N6a0sremozK005R0FDdHRCZmJLM21sSnVv?=
 =?utf-8?B?enJPRmg0Z0hoeFRtQ0EzK0xteWorNTRrQXgwUi9ueVhZQXV3aTd3bVZPYU1M?=
 =?utf-8?B?Q1h4VDNPczY0bytxTFVHUkZzTWxyU0ZNaGxXUkVCS0dRSzJEZWxUR1ZmbzlN?=
 =?utf-8?B?aWZSU04vOWhlWHdUMm5IaFNHcExWT05sRkVIemlSa0E5UVh3dUhjNDRoYUFM?=
 =?utf-8?B?cEtQdVMvQnB5Ti9CSXBIUTIzcXEvL3AxemE1a2xTM3YwUG1DRXZHSFFsL013?=
 =?utf-8?B?S1dCWldiNFFvREVYTXpJRGlwZmFlajUrWThsUlJVRFhTMEw2ZlZPOXBxOXpZ?=
 =?utf-8?B?YzAvNWFRYWQxc2Q0ZkluYlZBcjJXUFQweWdMU2lBWWR1ZTd2K21iL3RlbWU4?=
 =?utf-8?B?eitTR2puVE1WOTdYVjZYa1doUE52M0pobTZnTEk2Y1orNVFqd1N3cEZEdmJr?=
 =?utf-8?B?NTRoSFZaOHJpeXIyWU1LMWVVSkF1dVlLQnBPMFZac01BS1VDanlyZDgwUUVS?=
 =?utf-8?B?ZEMrcFk4RlR3bXdZd3NMamdpYjlBTGVvSXgrS052WmF6SFRmNi9ORW9CMzV6?=
 =?utf-8?B?Y1JEa1lqR2Fyd0xlb2JPaWtDbXB0bE9TMDNWU0cyVUhJTTAvSXdpVDlXazZq?=
 =?utf-8?B?RGdQL3BwUU1BeSt0L293L1ZLSldMZHZMZXZ6YzQxaVA0R3JhNFRScTc4NDh2?=
 =?utf-8?B?bW4veEJDcE9NcjZYbjQwK0pncWw3YVV5eVA3Q1k3NFdNUDJWUHNYMTZ4dUJU?=
 =?utf-8?B?MEJHNE0ranJWYm5GUlZoM1N3dUhZWU9WMnlaZWcxaHg5OVBhQXc4S0FLSVps?=
 =?utf-8?B?M200RUwveWpEalBKYnF6SFowbjRyaDVONU5CKzBqOU41TTIwZW9vRDkxL3p1?=
 =?utf-8?B?d2FjZGs4SjZqazMyUW82TDAvdkw0RGJ6SXZVUjYrUzA2V051ZDFIaTZhNndy?=
 =?utf-8?B?M1JkTFB6czJVdnExK3A4dGdiR2EvMVJ0dWpmem5NUVRldFlDY1ZZNTlZczFi?=
 =?utf-8?B?MTM3cDFNa2hpSFRGK2JVeDdhUzBVNkV3Qk02STFJejJRS3RCRC9zYUtaSGQy?=
 =?utf-8?B?V09EbmdnQjFCeHA0T0FQWnBHWFYxazh4VjZscERhaHQxSmZDakphaFZmdllu?=
 =?utf-8?B?d1NTUXk1NDZjNnFqNUkyeTUweGpwMkhqTmFHeXR0K3drMkJ5aEh4b1V2U0c2?=
 =?utf-8?B?U2NmYStQczZZNXhvRy9nS0JNQUQ1R2I4b2g0cVY3UjFBbnFoNHFobkdrWWFY?=
 =?utf-8?B?T2VLdy9SWElXRFI2ZXdJellXQjdoOTZkdnhHQUR3eHpTK01QNWM2VHRGSnpn?=
 =?utf-8?B?NEpUR3RNYy9iSWpESE9renBFYVRIYk9pZzhCN0FLR0g1SXhVQmxId3pTRVlY?=
 =?utf-8?B?QjZvTWtNOG9YMjNCb2hKZm9qSkk1QVVpSmpXWG4wS3hMejRwQkVBL0c2SVhM?=
 =?utf-8?B?U0xRTEx0cWdkcWFab1hka0pnZEdFZkowdTJxOHUzZ3BLZm9Kd05zNXQydTgr?=
 =?utf-8?B?K1hyUy9rajdUbHlDRndCU0QvNTIxOE12em1MbDlBckI3bHNta1d1QjNQSEJQ?=
 =?utf-8?B?dTRUelBXb0ZCZ1ZiZk9JMUkvbDdDeUtudlJ2QW5wazdSbzE4eUV3TnhwTWxi?=
 =?utf-8?B?MVp0UmF3TGxtRHloN1FsOHJwWk5YWHM1Q1crOTdXNFNCM2NvWHo5SWJyTk5x?=
 =?utf-8?B?MHU0dFFsYjV3aTRtU3lxNXhBdGwvZ1hNS3QzTEIybDZXR1p2dDBzU1h0Q044?=
 =?utf-8?B?NS9DV2dwWnZvVkdUbDZ3M0ZPNGt0L0FEVDZXU05TZ1ZTeU9HbXZXRk5KZWtC?=
 =?utf-8?B?NnZGQ2ZXbGZ2dFZla0tjNUt0TktWWHRvNUV2TlRxaE9FaTZidmZOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d4de83-03e8-407d-56d7-08dec89a4604
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB8432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 15:50:06.0169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQO0iLCJ5K9RJ/iYlsBmwg6SzavGf1DPMIEgoVQoOYNMqW/29dAdcbCwkrYPafE5QIJUwAEgYXlwYxe/OMT7Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609
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


On 2026-06-11 20:04, Geoffrey McRae wrote:
> Move kfd_process_remove_sysfs() earlier in kfd_process_wq_release() so
> that all sysfs/procfs entries are removed before tearing down PDDs and
> dropping lead_thread. The per-process sysfs attributes are backed by
> struct kfd_process_device, and their show/store callbacks dereference
> PDD fields. Since sysfs removal waits for active callbacks to complete,
> removing these entries first closes a race where userspace reads sdma_*
> and stats_* files after PDD teardown.
>
> Previously this cleanup ran after kfd_process_destroy_pdds(), which
> resets p->n_pdds to 0. This ment kfd_process_remove_sysfs() could no
> longer walk the PDD array, so the per-PDD sysfs cleanup did not run as
> intended.
>
> This race caused NULL pointer dereferences observed in
> kfd_sdma_activity_worker and kfd_procfs_stats_show.
>
> Also harden kfd_process_remove_sysfs() against partially
> initialized or already-freed objects:
> - Check kobj_queues before removing PASID and deleting it
> - Guard kobj_stats and kobj_counters before use
>
> These checks prevent invalid dereferences during cleanup.
>
> Fixes: NULL pointer dereference in KFD sysfs/procfs stats paths
> Change-Id: I405b8fb95d3c5e163dfc45928da54f31546d92cc
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>

The v2 updates look good. Thank you!

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 40 ++++++++++++++----------
>   1 file changed, 24 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d28ca581cad0..63b80d34c112 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1160,10 +1160,12 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   	if (!p->kobj)
>   		return;
>
> -	sysfs_remove_file(p->kobj, &p->attr_pasid);
> -	kobject_del(p->kobj_queues);
> -	kobject_put(p->kobj_queues);
> -	p->kobj_queues = NULL;
> +	if (p->kobj_queues) {
> +		sysfs_remove_file(p->kobj, &p->attr_pasid);
> +		kobject_del(p->kobj_queues);
> +		kobject_put(p->kobj_queues);
> +		p->kobj_queues = NULL;
> +	}
>
>   	for (i = 0; i < p->n_pdds; i++) {
>   		pdd = p->pdds[i];
> @@ -1171,17 +1173,21 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>   		sysfs_remove_file(p->kobj, &pdd->attr_vram);
>   		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
>
> -		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
> -		if (pdd->dev->kfd2kgd->get_cu_occupancy)
> -			sysfs_remove_file(pdd->kobj_stats,
> -					  &pdd->attr_cu_occupancy);
> -		kobject_del(pdd->kobj_stats);
> -		kobject_put(pdd->kobj_stats);
> -		pdd->kobj_stats = NULL;
> +		if (pdd->kobj_stats) {
> +			sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
> +			if (pdd->dev->kfd2kgd->get_cu_occupancy)
> +				sysfs_remove_file(pdd->kobj_stats,
> +						  &pdd->attr_cu_occupancy);
> +			kobject_del(pdd->kobj_stats);
> +			kobject_put(pdd->kobj_stats);
> +			pdd->kobj_stats = NULL;
> +		}
>   	}
>
>   	for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
>   		pdd = p->pdds[i];
> +		if (!pdd->kobj_counters)
> +			continue;
>
>   		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
>   		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
> @@ -1239,6 +1245,13 @@ static void kfd_process_wq_release(struct work_struct *work)
>
>   	kfd_debugfs_remove_process(p);
>
> +       /*
> +	* Remove the proc/sysfs entries before destroying PDDs. The removal path
> +	* walks the PDD array and sysfs callbacks dereference PDD fields, so the
> +	* backing data must remain valid until sysfs removal has completed.
> +	*/
> +	kfd_process_remove_sysfs(p);
> +
>   	kfd_process_kunmap_signal_bo(p);
>   	kfd_process_free_outstanding_kfd_bos(p);
>   	svm_range_list_fini(p);
> @@ -1252,11 +1265,6 @@ static void kfd_process_wq_release(struct work_struct *work)
>
>   	put_task_struct(p->lead_thread);
>
> -	/* the last step is removing process entries under /sys
> -	 * to indicate the process has been terminated.
> -	 */
> -	kfd_process_remove_sysfs(p);
> -
>   	kfree(p);
>   }
>
> --
> 2.43.0
>
