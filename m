Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761C2D1359C
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 12:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD48310E101;
	Mon, 28 Oct 2024 12:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QTqCIIvh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6ACB10E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:12:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg9ikI+AX0OphC8tJhLkOW7z22/VYq3UduadK3GTJtqAakC2/MsHTdAI72D4a5kL7F/VuS/Q4w0pGu4rMeQEDPbxkTXke66x71vSSOEqH+PtjxMNmhHvk0RoY9Ii+gAODA1Tq9/m1wTPWF6/NU/V1EhHr5n+FiZuomvmssziuiEnVUD9UXn4umf8I9DRbtsxlawL6yIe3SWcH8eFcBZB6NwvhBQK3bJFtWdIgIljr6pUyr3viFFFUvRE6DuE+qTvWDrbepOXCc0rsOyX5pO7EwD7etoLwc/7A/B1gZUHgaY0CnecBtFnTqClfs0Qj1wjuCuPZulJa65VoEflsIDjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clm1OBcf3o7RKNJ5JlhcA2Vr2xf/q71L56+seLvlxtw=;
 b=GTRuNBVzXDVPaH4rdkkmO2GOVySbFRSOTg+Tq4GDhcLihYgC0O7njFUifBZEOp276ibwfeG1Tgo1eA5MnYF9QJJhLGHDhFQ5mgHjZOe8AWa8Fg1pajzSREGGecUHF3Wh9IASyrBqPJR9Y2BDbMuq0HT1r1tV7PaQgg87Js/H7OJZrt9avqPGNyxYlMpL5ytZbKW+l2dpnqplgBPVF1qebKphfYqOWt3Ob6I6jPws3EQztXl5ug1AvJW2mPmfAU35sJmH/eGuFSGKCgz370wGVRO6DuMGEm+6qFx4kEEj7+b4vMKMQdYyPwjyfonRJe5OkRAwpU4g0Q+Oe9e1sYxlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clm1OBcf3o7RKNJ5JlhcA2Vr2xf/q71L56+seLvlxtw=;
 b=QTqCIIvhThhs5Jp3kX6XGp/Vaz/KjbPKufqPNP98RwPZO8Wqc3pSN6j6Xz+bTZDLI1FNLHXBKjeOimyPC3MVXL7BYRNNlabEAeLHwLfLyAgUGm+sL6rhn4XqKN6jPaexNNsn9/X/ffsAYH6vX9wPr059hxQF3gteQXuezkDI3PY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB7964.namprd12.prod.outlook.com (2603:10b6:a03:4cf::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Mon, 28 Oct 2024 12:12:04 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 12:12:04 +0000
Message-ID: <7a3ea9a6-0741-455a-88ef-c58348ce6f50@amd.com>
Date: Mon, 28 Oct 2024 17:41:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip amdgpu_device_cache_pci_state under sriov
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241028040417.3204840-1-Victor.Zhao@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241028040417.3204840-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5b135b-3250-4c89-1e58-08dcf749bc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K01XbDNJcm9OMzlOaHRudmpzZlhNeXd2Q2J5TDczT1lzOHVFaGk4WHdMWlZz?=
 =?utf-8?B?WEc3RWJObkFCUW9BeG1GNkdoSG4zUHp5V1crZkdyWVVsL0hmMFZNYndHZklD?=
 =?utf-8?B?c2pWVnMrU3JhMkVkbTZzWWg4a0RWS1doV1E2cDVWU205VUIvNTUyVE9aOU9C?=
 =?utf-8?B?TCtpbW1NQU9SdEtYc01GNkZFR3NRakVTVG9kMlBHc1diNVM0c2tOUWhZREVQ?=
 =?utf-8?B?ZGVsTG5lTXJEUW5Sa1I0eHA1WndtSWJZOWZxREJNSnEzUDRzWS8vUHFwVUdR?=
 =?utf-8?B?VWdKQW5rMGVLc3hEZ1oyNDB5Z1R0cE1aeVU5K1ZFeGJtS3RiN3IrNmZBQmF5?=
 =?utf-8?B?OG9NeGZGK09EUzNmUFpiV2NobEhvOWRGM3pvTkFxelZtSFRuMVB1Z080dmdO?=
 =?utf-8?B?OXh3VzdsZ2ZGdjFlQ28zQ05tMVZBTnY4VWhwNmFXeVNkeGQ3UVF2TUtxZDQz?=
 =?utf-8?B?U2F3UDhQNGlwaE1qOWF0aHNHYzA1eWNmY0FMRDd2OUgvdzhMMnpEbGVBWVdW?=
 =?utf-8?B?WnRDeUFiUldjam5YSzdWM1RHVVJNQ09lenkrLzFPdWpCSWNGd1RFNDNyaEcy?=
 =?utf-8?B?VmRkZlNKM0cxZDVxZmtFMXdDSlkrK2g3RU05QWNZR2lCemVwdEk2c3E3Q0Mz?=
 =?utf-8?B?SVVsUUJHOUdRdzZqQkx4Y0wrMjkvSFlxbUF3aEcxS0JiQnBFcm1nQm1FZWVl?=
 =?utf-8?B?V0NwRHB0MDBuRkhieFZYN2NGZWJ4dWtXcWVJTklDQnRQcjZiSkc1MmdwRHFO?=
 =?utf-8?B?TytWZWkwN0FxblVNSnZycm1NcmdnL2c0ZWNXa21oRC9lUzVVZXpVdGJHRVlI?=
 =?utf-8?B?akZlOFVJOU9teVhqZFBMWXloZExaSVJCQ3ZUTHZPdUN3QUNsVmQvcmFTMzIx?=
 =?utf-8?B?MUEvbGNLQllGR09KY2oxUDR0Nkx3Q0ZVOVJmMkN5SU9BMExQQzhEeEhoeVEx?=
 =?utf-8?B?Y01SV3RSZzZGUTc2ZFRUb0V2cHRlSkVSMERtUzVDZ0NaYktpOWF2M0IyaDdP?=
 =?utf-8?B?Rm9rTGZYYk5wQTd1ODdsVVdSajg2SFFSUU5tQkIrVThrTmpIOUliVC8vMEZH?=
 =?utf-8?B?UndsODJpbnJyYmVsRHZ0NXhYMjA4bzhIWW5tc2JQaC9sVnNtZkJ3bHJVVkk3?=
 =?utf-8?B?VUllMldhVkJCOEREbTI2UjhscmFLOUVHZWNyYnVZTHBYVEtlUFZWZ1F2ZlA2?=
 =?utf-8?B?dTUxcVJmYWgxS251ckhKOW03ZGwyTFR4UnIvVXNuemJCbXl3Z2dEcWVqWmhR?=
 =?utf-8?B?SHFlUTZPWVQwNSswZ0N3bDJSQTVIQ0k4WVRTdnBIWkZSbWo5ZnZIMDRJaEUy?=
 =?utf-8?B?RnZzWElzdU1xUkhmUlZIWWprK2JEUnpISTFvN200c1NRc281QWZKK0I0NURu?=
 =?utf-8?B?ZGtiOVJ3b3VBZkNFNnhhd3JETWZPb1hoelRicGhxV0FCUUN1ZnlwK3lIbTY0?=
 =?utf-8?B?aFdrOXAyV2R1NmF3NFQzTkNqWlNacGxDVXZDcjl6WE8rTVAxOHlrVGtUSXFR?=
 =?utf-8?B?RWNPOHZkYi9DS2tuQ0FkRkdPeXcxdnp1dW5iSnpPU0lpa2JqT3VwNmFGLzZm?=
 =?utf-8?B?VEpKWnI4aVdobkd6L2VZWlpnVWNOOFJWaURTd3hRM1F0WlQ3NlhKcUE2cHN4?=
 =?utf-8?B?WlFXaVhCTmVsRlFFZGhMV3hJdFJJUnFpbHBxQW01ZDdiWmxMTmxxb1BPQ0Mz?=
 =?utf-8?B?enhzK1ZsVVpaNllRd2J2aDN1UkJSMWlWZ3RvNjBFdXUxZ0ZqdFRKNmlrdHQx?=
 =?utf-8?Q?6XH+byCsFYO3gUpvIqacl9kjLQU/DeJoqkJwhyZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZhOFA3c1E3ZUQzRHUzQjBwQW5SRkwybjkwVzVka3JwNWhSSmsvWWVLZzFG?=
 =?utf-8?B?dWs2WlJaN0ZnN1dmZllNZWEycFlGSkZiZVVkWno1MTN1Z25rMHBBR2E5NWQ1?=
 =?utf-8?B?QStheEhwRmljM3ZnN0VUU0ZBVGJGRjltdnlKUGt5Nyt3WGw2dTQ2ZlRJcy9D?=
 =?utf-8?B?bStUV1ZnRzJKQXp3SVpHUFdQRytzdjIwaDlKeUhENjhvRFF5b1JKVm5DUVJP?=
 =?utf-8?B?SnBDR2dxQ0Zxd2s5OWxBcUpaQmkyTVF4MmRmSUpXdlFzY1Q4R1IyYkhiR2ls?=
 =?utf-8?B?OEhwS2ttY3dyR3I0NXNKT3pGcVpBVSs4Tlp4UDBENERaN0tIdVdWZzFZU29C?=
 =?utf-8?B?TUZZTTZDZHpFL09yOVIxMW42Y1AwWXgzU1RmdjZHSDZPcnpoekJNc1hlQ3E5?=
 =?utf-8?B?NWdtZU9HTmVWYSsyeEY5aHk3YkpMVnNOZU1mdXdkMDJyc2ZnYnpncnRNOXJM?=
 =?utf-8?B?aWpqMXNRR1QvSk5EWXRzUWJaWGZCOW5OQ3hFcXhiOGlLNUZLTDROVktrSEVt?=
 =?utf-8?B?djFVNnR2ckMwT3ZHdlUvbTRONDluazk1NVVpV2Y2THI0cWVobExiZ2VEY29K?=
 =?utf-8?B?bWJXOVFOL1R1T3FzRlcvMytHaWRNeDdyMXJWVXhmcjJreDl6N2RnRGZpWUVt?=
 =?utf-8?B?UlBHQWxxbFl2U053T24zRng4eUtvOTZjT3k0WEFvZmUrUnRwQ2o5Mit1Ulgw?=
 =?utf-8?B?K3R0Q1ZDU3NJUVJBSGJUYXduTEhoaWdBVTh2cDJTVEN0MVhRYzAzYTRLdkQw?=
 =?utf-8?B?bUxyRlhaRll4UmRjTmRvTU4vN290d3c2VGJPdHRmSnhEMitYNkcxamk0eElj?=
 =?utf-8?B?NHZ0RjFWQ2xraGl1R2FiMExmRnRJckNLUzJqN080T3hBK29SblVDMU12RW5z?=
 =?utf-8?B?dytzbXdvQXU3YlpxdXI2RFgrcUVuamJaVERmYjBjYXVvajFrdGY4WE5wOXRi?=
 =?utf-8?B?bjFpdGJqNm92bXBTREFBOWtPeG1IclBkeWRyZXBPTi9JQks4Szk3bitkQjAw?=
 =?utf-8?B?Q2g2ME5RdDJrK0M4YVBJN3BGaittcEMxNkU0OW54cWkvTGtpa0pSVVZjUGtr?=
 =?utf-8?B?UWI2dXJEd2RwdUg2SG1BZXp0QUFGeTNhVGU1L3JReWZoVktwUlBESmQweHlG?=
 =?utf-8?B?aERHL1lMV1M4VHJVNXdGZ3AyRnlsZDZONmdkR1Z0OVd6ekltcTVhWlNFU0N1?=
 =?utf-8?B?OHZ6WlVzSmNid3JiVEhqSXIvYTUyOUxJUDJqOWRVMVV2YW1mTHJ2d3ZJQUZm?=
 =?utf-8?B?RExValhFK3lFY2hXVzhMQWdsVTFCcTkwV3VyTXk2V2k2TEtYTkl3TlkxbUla?=
 =?utf-8?B?dTFOYWNHS3h0MUtlVm9YZ3h3a1N4N1JYRTRncjN6OU8zdzVvTGJERzUxQllt?=
 =?utf-8?B?K3lJUTJzUDVzYnNMR2lCc2ExTzVkWWFjZ3RUMzhtT3JxNG4vdDIyZys5VGVR?=
 =?utf-8?B?YUhaYyt2amVNK2tNZ2Y0eUFlWUFreW1JNHhMb01LbVhLTnkvZ2VxQklBSWZ5?=
 =?utf-8?B?aEd2UExtNnd0U3hmVXZMR1YwbWYxbEt4bFJYWk5sTC9aaTlZZ1N1akU3bFY5?=
 =?utf-8?B?am10VEpwcU1VZk5RSzJPMmlPV0lUeEl1QlZ2SEhEUXZUWUhrTFVnZHRhVUR5?=
 =?utf-8?B?UGtwdm9taE5uSU4yc3ZXQmkrZ2ZTSnFZb0xhSU10VGdzUXl1UmxlVXozMk5H?=
 =?utf-8?B?bW1jV3ZpNVpFc08xTGo4bXE5OVNwN0FleDBsOHpnU1ZSSndSZUsxV1NTWUJV?=
 =?utf-8?B?K1N3bkdDaFliUGdIbks4SVpYcnF0KzdzNUsraFdMZFNhRXlpdG91aUNPUGw3?=
 =?utf-8?B?elpWUlB1bUNUdWV0ZFRVQkpMeHZOeDNPSEhpUzlYM1NCT2lwaitqNEo1amN5?=
 =?utf-8?B?SVprRU1ueENPeUJRbzduaHpBcWwva3hPb3NhRkU3eUpsM1J4QzJjckE0SkhV?=
 =?utf-8?B?YWZuZlZjUnpCUWZBbmZyT2xIOU5hanNXd2daNGt3WjQ4L0tlY0pPVXIrM3lz?=
 =?utf-8?B?clZqaGk3ZThzdVJkWUp6L2hnVTFpeGRMSFF3MWlKSTRvckZ6WG05OVRKNXBQ?=
 =?utf-8?B?ZjhPTFBDd3BlS3dURHN5VkFXbVF5WHJzOHBPTU5VWGZUZjNNbURHTHBtb2NE?=
 =?utf-8?Q?j75DB+aN6rQlTzuSCkBVXAD5I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5b135b-3250-4c89-1e58-08dcf749bc2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:12:04.5055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qppzlpxuuz/6Q3Mg+JS9ITR6VihXmtDkVtlhCtVwm5ndjpmgJOPjrPCUwnqQrqwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7964
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



On 10/28/2024 9:34 AM, Victor Zhao wrote:
> Under sriov, host driver will save and restore vf pci cfg space during
> reset. And during device init, under sriov, pci_restore_state happens after
> fullaccess released, and it can have race condition with mmio protection
> enable from host side leading to missing interrupts.
> 
> So skip amdgpu_device_cache_pci_state for sriov.
> 
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 383bbee87df5..64622dc57a6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6451,6 +6451,9 @@ bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  	int r;
>  
> +	if (amdgpu_sriov_vf(adev))
> +		return false;
> +
>  	r = pci_save_state(pdev);
>  	if (!r) {
>  		kfree(adev->pci_state);
