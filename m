Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5ACC021A4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2025 15:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B870E10E3F6;
	Mon, 24 Feb 2025 15:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nXa5l6N8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4236310E408
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2025 15:40:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWh8AmEdDsVjFyagcI1RIhwmi/9//SW2I9j6IpDabogEsIPf27U4D+4P5pFA2AxPorq5GYIRWHFxpoalYqMWsW7pHFUzw03Xq3qMvYyjktBfBLLnTNgoOTRida9Lc6FdLGsoUhOHOVu/wopz29T22hLNd2GnrHnitm5ilVMDETarhpBSx1q0s0IBJTURvUegJA5l+hJ+IuHIAfPpkWPUEScedFoP/hjp6fDUdYLtUoeYRKvWP3G/9MDQYve/csyHgVYzkzwiiNG0Cs7b6Z7B2Ckqrt/pUw+KPMDqEb7HteY+OQ2ZCOhgV0AF5P6q5YjwdP2/UhfryT2gTxyRXS1N6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kd3/Y0uledkEtNs7CZi/gFskIjGnB8qhvzgUd9YQiY=;
 b=Yq5ASiONqdBSV/8uvzRcA2MG/vWXcwy/giiIEc9k3dbIYmdQQOrZOGL+jhiEdjIGav4X+VKipkVKaCFTDVOkXRhfKOrkJuXlz+LarL30EFvGovsfgkO3DDJRETQ+vBuhgYKPkDnhBl5dbrfSYBtIOa2r9HIxklid3kv7Ru/qNIcLmKM5YpFzMxaXz3PyBjoxfU4R4ZKaUEPGtsF/oY/EK4KKGUc31bzg9BKDWG1wsKyksRe358SS1wLyXw0TY3MyzMxKLHILywHqAcwaB29ItZkPof2qzFwsUKNHz2O7eFNQII3UEGk5Xl+TjQCYrY51g75vvGHKc475RyefojGO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kd3/Y0uledkEtNs7CZi/gFskIjGnB8qhvzgUd9YQiY=;
 b=nXa5l6N8kOsUmmx0ttF3CKP9ERRuy/O4JZaBtiNEiMDU+5F9TwJGUCf361uD9kaEZf2SVy8hOKpQInyhPlhlYpPvzF3qJDDciypVgSFwATFdUNEFeLB/Vx5QFJduRZu6Gmuzz8FSmjcgRTRf2/1fd/VY8IiHlKkTquLvu16rQJA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB6352.namprd12.prod.outlook.com (2603:10b6:8:a0::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 15:40:20 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 15:40:20 +0000
Message-ID: <b74f7a58-7f81-4123-a11d-5a8b2ec4376e@amd.com>
Date: Mon, 24 Feb 2025 09:40:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
To: amd-gfx@lists.freedesktop.org
References: <20250220115946.2051216-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250220115946.2051216-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::33) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 1777dc5c-797e-451d-ac29-08dd54e98b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHgwb0dTa0pUVEhBT1lHS3VCaks1WjRKN3Vtc0xJN05aa3NWMG11cTE3dC9w?=
 =?utf-8?B?YXp6SUFJVndCR01Pczc5NFJyaUZBK29aSEc0OUR1L21WNkRlNVE1dWE3YWhw?=
 =?utf-8?B?VzlHZ0VBcWpWVnY0T2k0ZnN6SkZBc3cwMmdpSzBDZTdjZUVJQlRJRkYzZUZv?=
 =?utf-8?B?dlpwZWVmVElsZWV3NEhoTjJMYnRBd284MHhhWkFFZHVXSUEwYzVnVVFnWk5N?=
 =?utf-8?B?ZTZOZVVHcDk1K0RsWThJczJIbUtYZ0ZyWit3eGx2endqZWRLNHp2djVNNnV0?=
 =?utf-8?B?ZHR3OVBvcnFZUnhtY3FPS3dodVNTSnBlY0Q2VDZDMFd3QXNTMHlaT1JZV3pn?=
 =?utf-8?B?S2tWTG1mTHczbWFOKzhkbm9CMi93MW5FVEFZY1FyS1dLdVpHRmhKY0lqNCtr?=
 =?utf-8?B?RnlUaWVxS2E3NGl4NEdTUVlZQThuUmgrZS8yaWJ4eStubStMVERiaUlub0Ni?=
 =?utf-8?B?Y0Z6clZEY2hzdmpxK3l6UlBDNGNBRkJ2Q3RRdzBOMXc5SjdVODFxSFJrN0FM?=
 =?utf-8?B?K3hxMzE3UjBJYzR0NnpLMzFWYnhpNENpb1dSREcreEVlTnlGTkhML1lWN0U0?=
 =?utf-8?B?Y3crWll1bXdGaFMvQmtjaTNHUzVqZEViWkpaSjlDdUVUMWtnaWZCeHdjRFVy?=
 =?utf-8?B?REVVdDJTaDNlYUxUQkVVdEZ1VDNFMHZzRE9xa01CSWtDQ3pORHVOOVJxUEx4?=
 =?utf-8?B?L1ZtVkNaeHpWMWl1U1UxWlB4OXZUdHYxYWoyMGM3TW5vVzZrdTVKa3pOWmpT?=
 =?utf-8?B?RVNYMmlKb0JNdnhaL1BCWGlFT0oxV0tUeWwvdVpUcDlRcWNmcVM2bFBtWUM0?=
 =?utf-8?B?akRGMmtaeHlmQ3Y2YzVSa0doVEVCWlQ0VG14SFdmMjhhcElYNWRhelkrcjNE?=
 =?utf-8?B?MlRIdUVmYkF6VXB1Q2ZSWCtZemcreC9NcWpYQWlWRFVNbitsd0U5M21tV01D?=
 =?utf-8?B?N2tSaFhWZVRJRWFSeDY0dzNKdDdzaHdwOVd0WUIvTjhJVzZUdEpiWVVsZjU4?=
 =?utf-8?B?c3J2V0FyMXYySWFqMzZia0ZLL0FRODhmTS9DMk96T1ZBVDJlUm9sV1REZ011?=
 =?utf-8?B?ZHY4NVd0M3ozSWF0Z0E4bGxsaHFlWHl4Q2IzZ1NwMjJCL1U1aDBUb1MybEJV?=
 =?utf-8?B?NFdocEFveWFvZVpEZkVGNW5QNExLMExxZkN1ZkRmRDd5d1pMS0JEb3N5elF6?=
 =?utf-8?B?MGlzZEpJdXdNZDAxWnR4ZEVNYzdUWlNCaExpREx1WGZ2QmFtWXVZNmgvNDR0?=
 =?utf-8?B?Nk5KRnNFd29raEV0RTVrY0NrVkxLWHg1d1JDWkNuWkd6TEtGVXlaMXR2OWxz?=
 =?utf-8?B?dGkvZXVpakxyczU3ZXNPMkVRWS80Y1dvakZwUkFjTng3Vnpzc0hrdnluOUM3?=
 =?utf-8?B?c2l6Y0NncHRzZkZZVXpYZXBUeTBhWjQ2U3F3eXRxeG13cVBkd0RhZk9YQVVk?=
 =?utf-8?B?ZmQrKzlHRCs1cEdYT2VPb0tSK1g3UEdZRS9xYWJJYmZvS1JpN1BBeUI0VGhi?=
 =?utf-8?B?bk5EQ1N3ZjRmamtpWnd4NVRlVzZXSGxEZVBodUNkbysxSEtTUDloM25Ub2N5?=
 =?utf-8?B?NWVBKy8vRThQYWxiTTZ0dzNQWVVjM0hUdmdNRjluVWR1S29jWStUTTZPNVNP?=
 =?utf-8?B?SHIxMHI1VllWKzhwSmFmYnRpQ0Vlc250SFlkeXVMa2pXeGdBRll5Z0JrRlNq?=
 =?utf-8?B?UzloTGVTZXN2QVoyb0dwV0JVSWlOU3ErM1kwU09UUWVGVndJUXAwNTNvRS9J?=
 =?utf-8?B?TzMxWmcwNjQ5cWdheUJQb01IdVh0SWxvUjNwa091VUJUY2ZLWkw0WkJJMWVU?=
 =?utf-8?B?MlA4cTR0cFRLbHZMUTJNSTFTOVV1aEMwTTF6RjJvMUpPd1VBeXFpWU1Kalhy?=
 =?utf-8?Q?djDDlA4RT81p2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhHRkhQSzRGZUUvSzRlZGxnUENDQUIrSDVlbXFnbUwrckFIczJMbytvTWwy?=
 =?utf-8?B?N3FZT01YTHI2YXhSL3BmcTk4azlVWEl0UGZtZHlIRituTGhMNlhJK2h3VElP?=
 =?utf-8?B?bnJpMkRzVFJEc0lUcVZya0NDTFIxTW1PU1dYWXNBWEYxTGs1WEJIYlpTV0tK?=
 =?utf-8?B?ZlBwV1dHK0JNNkFrUnU3LzJGRkx3L3hLMHE5b1RUSk9OMGpIOFNQb2tBMDdP?=
 =?utf-8?B?L3JoT1haMmpzQW82MG9GOEpJb1Rvd2ZJL1ZrVnNOa0dFTFNEZmVCUzZSOHAy?=
 =?utf-8?B?VlJ4Z0p1eW1CclVVdjlDOVBaOXFKcCt3aWovT1R2blQ3Z1kxSC9VOHVWZkV1?=
 =?utf-8?B?MXFtakRneWhleWtha1EvdnNYUFhUUWViYzhUVk1ZMnc3NXc4YTNscjNsdkha?=
 =?utf-8?B?S1h2OGlla3lYWXhtNjJhMjJMYi9DVitwSVRsbDFGTldzb3czUmJwamFkMjZY?=
 =?utf-8?B?T09CVGJvNUczK3JwK3hKTGF4ZE5NV3VjYkwzVUF1WTg1bERPdWYrQWZWZzBk?=
 =?utf-8?B?ZWxKNGZ5T29RdTliN3FWdjMrODZqZlROOWRMZmR4T3VObzh2cWtFenlKdWVJ?=
 =?utf-8?B?MkZIWmY2VUYxTFdrZmF0d1RmUHl3VW1mMzJ0SldMWXJ1RzJsYTNCdFZBVEdV?=
 =?utf-8?B?TjRyejVrbSs5L2JIdllQK3VrVk54eE92QkE2UVFiQld0VTBOak9teWNEcm5q?=
 =?utf-8?B?a0NQaG9wNUtxT05yamNxZHRiSGFodDZGb254NnN0NmpBQnNXaWhVYnViOGwy?=
 =?utf-8?B?WG90WXFQVmJ1R3FnUURrRFh1bFhkbDRPdis5c2hMN0o1My9KcHJCeFZheTA2?=
 =?utf-8?B?cmRWLzMrTnlaVE9neHZqaGtUcFRNV3ltN0QzUWoxU3V5V2QzbTI3SXdHYlJE?=
 =?utf-8?B?NU1IMElFaVBDYS9wR3JKQ0poOFdaeTZrMGd3VERPc2Q4NmhvSHBLa2VlYWhX?=
 =?utf-8?B?bzA5TnZuRldiRkdXQzFOa2E2NDgzQUR1TUJkZW83aGRXcUVMalhjTWcwcG1H?=
 =?utf-8?B?Q2ROcjR6SWhMN1o2VE1zNDZ0eFNNcCtZVWRla3ZtRjdwRjlSYWwwMldkZDJP?=
 =?utf-8?B?SXl3ZFhLdWkyNGU0ZjdCUi8wUUk0SUhRa3U4OVc2ZmNwTzZvQ2tWSk1hZERM?=
 =?utf-8?B?R0daNjdvcUlQQjAxLytTeFZhei82MEdTMk9qNjg3T2dhb2xrU1ZubldwSU4y?=
 =?utf-8?B?MUlBb0x5em9pNkRRajJlZmNybXNNOUF6Vk56SzgwSjIvUXdzT2F1ZU5ON0NK?=
 =?utf-8?B?Q3lHbWxadHJnR3VRSDJIZ2dndXYrQkpreG5GREZ2NlRuaWlzOTFSVWEvU0pt?=
 =?utf-8?B?QkZmbTRqU3FZK010dUN6OVkveEFOOXFGdTVUTjcxUTNXanNQbEFUeW04clBz?=
 =?utf-8?B?TnlEMTVDRDRDTDR3ZlcvZmEwUGsyS1ZpSTF5ZzRSREY3aGRrcjVsdDVSeGVy?=
 =?utf-8?B?V2FFMEY3WU9abUdVVHRUTmFSSk5ac05SeDUzWGRDY2xDd1RiUERJT2t3blN0?=
 =?utf-8?B?MWhQd1ZZWTdBSWNtUEc3VW5hSDk5WU9HbTBkcmVPZ3ZrZXhSYmdkblAzQ2pw?=
 =?utf-8?B?eFNmQUFSQlAvc3NseVpRRUZQYkNBVDl3bjJvQVNPR2c3aG5QWXkwZzRuYVVs?=
 =?utf-8?B?MUJPN3BTODR3UUZmR2dHOU00YTV4YWdBMDhaMnl0Q08vUkV1OXVWRkpBbWNx?=
 =?utf-8?B?Z3RnZWVtZ0lrZkxmZy8zZlc5MjJTakw1bE9OYy92VGlLMnFXSEVzQjZHUmEy?=
 =?utf-8?B?UXVFTVQrcXdKeG1OeWZnRGE5cVZiODRBY0N1ZThlQTcrdjhxSGw1ZkZyM1ZM?=
 =?utf-8?B?OWw5Q1lVU0Q4eVdhNXd0alRtaGRGYkN5WUppcVg5NmhubkNIQ1J5U1JmOVVG?=
 =?utf-8?B?WExhRWRSMDZZRnQ0MFVSWG91WWEweGVlUDJUNGpDWHpiNUNIeDNjYWM4NTJX?=
 =?utf-8?B?YVZPY3lCT2tpVHVZUEVlN2xpR0d1QWJaeitvTlhDMHI4emg3U0piYjBSSU0r?=
 =?utf-8?B?VCtreXpkZzRNZzRaa1hIWGRHN1E4SUVzZmlUQmFoNm4vOGJVOTJYK09JdE5G?=
 =?utf-8?B?NGpoQ3V3MlhGcGtzTkI4TDlIZlM1K3NxL1NaRTBYb0xEc3RibUJ2VDUxa2sv?=
 =?utf-8?Q?9LAw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1777dc5c-797e-451d-ac29-08dd54e98b8e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 15:40:20.3420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgF+/iMXhFhiSrtOHEqSQZltmMMLw/pdw9fTfNta1hWykNOz0pcTCWTM5+NHTbbM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6352
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


Is it for fixing the issue you mentioned previously " Fix the deadlock 
in svm_range_restore_work"?

Regards

Xiaogang

On 2/20/2025 5:59 AM, Emily Deng wrote:
> Call amdgpu_amdkfd_reserve_mem_limit in svm_range_vram_node_new when
> creating a new SVM BO. Call amdgpu_amdkfd_unreserve_mem_limit
> in svm_range_bo_release when the SVM BO is deleted.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 -------------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 79251f22b702..3bbc69751f7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -514,15 +514,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	start = start_mgr << PAGE_SHIFT;
>   	end = (last_mgr + 1) << PAGE_SHIFT;
>   
> -	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
> -	if (r) {
> -		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> -		return -ENOSPC;
> -	}
> -
>   	r = svm_range_vram_node_new(node, prange, true);
>   	if (r) {
>   		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
> @@ -560,10 +551,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	}
>   
>   out:
> -	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
>   	return r < 0 ? r : 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index db3034b00dac..c861d8c90419 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -430,6 +430,10 @@ static void svm_range_bo_release(struct kref *kref)
>   		/* We're not in the eviction worker. Signal the fence. */
>   		dma_fence_signal(&svm_bo->eviction_fence->base);
>   	dma_fence_put(&svm_bo->eviction_fence->base);
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		svm_bo->bo->tbo.base.size,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		svm_bo->node->xcp ? svm_bo->node->xcp->id : 0);
>   	amdgpu_bo_unref(&svm_bo->bo);
>   	kfree(svm_bo);
>   }
> @@ -581,6 +585,18 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   		kfree(svm_bo);
>   		return -ESRCH;
>   	}
> +
> +	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> +			prange->npages * PAGE_SIZE,
> +			KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +			node->xcp ? node->xcp->id : 0);
> +	if (r) {
> +		pr_debug("failed to reserve VRAM, r: %ld\n", r);
> +		mmput(mm);
> +		kfree(svm_bo);
> +		return -ENOSPC;
> +	}
> +
>   	svm_bo->node = node;
>   	svm_bo->eviction_fence =
>   		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
> @@ -655,6 +671,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   reserve_bo_failed:
>   	amdgpu_bo_unref(&bo);
>   create_bo_failed:
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		prange->npages * PAGE_SIZE,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		node->xcp ? node->xcp->id : 0);
>   	dma_fence_put(&svm_bo->eviction_fence->base);
>   	kfree(svm_bo);
>   	prange->ttm_res = NULL;
