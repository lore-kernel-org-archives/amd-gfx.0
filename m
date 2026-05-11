Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495C1CD37B5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 07:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88CC10E1A9;
	Mon, 11 May 2026 07:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMBBtJuX";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4AE110E1A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 07:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqQJBZqdKePyfslpb11iEi8Ut9DBlSIbgPX5pzlCfMaJeAya4gSfmn3Piw1aXFNURgNHWNY9yqmLM59K1YSeN60NhWpBv8C51DOw11CYsybwFlKWbVHdQbCRRoqzSnuAq1kGe2UG4edOpbppJAS1VbPpf20z+bd4EfNATEz/upJ192TVa57ha+4Zl9iiWJryyfCmYfnWQbPWJ9R4Il48cff4Cz42APVkAfzmtFSLJa5uSbDn9NYy+C2b6DZwt5FHUxAL8+YWQR+6jwT3nOCm6x/TrD16tAYzgvFz0XTM0aqWd2caxEa3xI6AYewTzZwmAc6GjUoacz2FtaNwywoEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6gQNTwKu9NX3+ORQrr/qeQlzbp/B/GTSv47omI6FXg=;
 b=pIZwIIbA9Xby3s1vxy7N97mMbdbtabmNt1n1XSmoRNie9bdU1QJOyYt4IShxkOC8iMrfone4M2M194do6sB5tP4XL9qxLmHhei0pRnMjZe8JLNAd64HOij/23ml91Z2m0hBudtdNzxsB1QPefEZWABtj0GyC6ZbV8jYKZPzIBBdsDLG8w2u042j3YZhOUuzj8Kz8A6CRRA/Zyp3+p0dklMmyf81uRfgwK8j5qGjhWnY6X+Aelefg0pjhqOmxuPhMr6Wdwa2b9hoV9IaziyahORO1tmFsrkJ1jcM6hDTqz1CliFGNxIbG44m4rs9xDxNubeclkTTqLluLkMjPUoiBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6gQNTwKu9NX3+ORQrr/qeQlzbp/B/GTSv47omI6FXg=;
 b=cMBBtJuXlbDyaDEv3L+cEocbDW6ZZ5eTO1bfUmudo+c0jkGWCYQjSHeYocBkS5ExrtE00OHAxuUoK5dWpL9xgCO4SaTx0+Fh/Y7QGUAwWdIsIPqOTGABzdkYomucoXfvnVVJ+SZwFUzVaNErg47g7yNV4UK2nu9F9febcWpjVms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 11 May
 2026 07:58:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.020; Mon, 11 May 2026
 07:58:46 +0000
Message-ID: <5a1f2308-c492-4575-b1d6-feb273bf9a99@amd.com>
Date: Mon, 11 May 2026 09:58:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add guest driver CUID support
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Chang, HaiJun" <HaiJun.Chang@amd.com>
References: <20260509101508.587490-1-chongli2@amd.com>
 <DS7PR12MB576885AC7F930CE22CAFBD019B3A2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB576885AC7F930CE22CAFBD019B3A2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0431.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: fb447321-3ab4-42d8-c967-08deaf3320b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: h/Ma3nRJqvmw7hm9qOl6pql+hi4NB6llN3rgL3lOnnkydWJivLwcTBLAg2rSmEJblfy4yvSVBeB/QdnR1i6gzmbFOW88zDrXVgmxKJb2/8XhGmx86uSltwsz4T3fvOK1pRTQoIe8zhqcVZPnO7D+HFvPaXZ9AyHy0ZcwPIruD/XoqYbzaVmpyS7+ihO7v0INDDABELypSsGOAvUUXVlNEO0Pcx473G2LPizhOEcOiXO5o1vKnTOBDzGvJ+VU/3GDOjOMNyrW3c9PVw9tHqgJgXKcseciazOFzWEvtQoShVT5LNFoZcuE4iPDTnmfTO6LIm9aKtDHNDCZ15uqb1Km3lJZfXSP1hGwP9ndk1bpL3bchRZvSTQO1QrBKoqLqW5JAzygoLAeTZdO7MW8z7o/EI4uJtpPncb7DnLu1HE5cE5wdf1ahvdc4xmr2Ot9wVXSoWfQsAQbxb8rnpNjKfrnb986AZHmnIX9aMd3x04nIlOsdhIwD13fN1R/WCHo1vcdEHQzKye/ldC1JMvqQymLeNRzGWhVNJkBgNYS2CPSheArCdIlutdlNtoOUIkOfBC3lWlOuF2G3en0NCTKIEBKIQ92R8bpHGO43HXWe/kDeg0eTXcATQnHI+BYmESqFWBFeIHiJcspmgMJCw/fJFiFi6F152tzmVN9BsrbjVscYjOkP30CHq4qjRrELkgHeDl+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEQyMzdmajlYbTlKbDlZZGNBMll2YnpmQUVtQTdNVWppNEVZUmVDZ3NtWFpa?=
 =?utf-8?B?bTRhWFg3anBSWVB2ZytndjNxWTJFYUpkVWFTZHFqWWEwYnpqc0ErbkFNdjhG?=
 =?utf-8?B?U3JJODVwVWVpdTlVSFU2S21ES2g0MnI5ZnQyeFBrYXNvek5QN01HY3FvajFn?=
 =?utf-8?B?WDRDaTdzd3JoMWhNa251Q09pNVRaRTBYaXNNc05oSlVUWE5LM2hRdEZydGVk?=
 =?utf-8?B?TWdhcVpNb1NyTjlPQzA3cTc4VUFLclZFbXpwaDdkcER5YlJ4ajJ5ZElHY2lk?=
 =?utf-8?B?RnhRT2VLS3UxbmFadHFZUERDRjNsRFp4VXNVVVlqQ3dDNTBSd2F5S2FNa2t2?=
 =?utf-8?B?VTMrYWJheGhkZlBTQlhOU3E2SzRGR0h2elJ3Z08rM0NMdG5FNDdBS3FvVTF6?=
 =?utf-8?B?bGNoRlBJeXpWOHE3ZWJuSEJ6c2p5bnpwM002a24yN0Z1WDFCbmw0S0NIbUda?=
 =?utf-8?B?YmZrQ2lQaWZKbnNDdEFPazJHNDIrb09LNXZJN0d0alY0QmdJNCs4ZjIraDZx?=
 =?utf-8?B?Y1pEVWVkUXdGOUZ3TjFBbzNzN2h4bm5KVDVLTW9iNEZIbUlEWDlpZHl0Qmtw?=
 =?utf-8?B?QnhnTGZ6ZkY0V0pCZU4rN1J3ZkpyaFg4VTZGZDNORU5WbnUxVnREdEY1V0cw?=
 =?utf-8?B?ZzFma1RsNjMrdlE3VE1vR29NUGlvVjkxNG4rOGN2UlhVck5PTytOSmo4ck0x?=
 =?utf-8?B?MUZweDlqcVNrODdocFlPMHVSN3k5YW1ReHYzdXNGK09rUkt0VDZ4ODBXaDI4?=
 =?utf-8?B?SFJhVTQ3amwrN1hzSWpXWXlkbWIwcmJaWkpnZDNoK1M0R2FrdXQrUUhFS3hh?=
 =?utf-8?B?RkxqUGYxNzJHNlBPcjJiR2pST0ZpTXdmVkVNMjRINVRia3FwdTROL0I5cGEy?=
 =?utf-8?B?TkxhelBCRTFpQ2ZBcDZqUXdYS3dDK1dMWTZ2SlhLVFYrNmRNU20yWGd4d3lx?=
 =?utf-8?B?NU1NWVVHczduUDNobGlmaDlqWXV1K0xwU0xNZTZzaTF3azZVdkVnTEtFamdV?=
 =?utf-8?B?NjR4eEluUDF6RFVjWDBhVkdGWTRyN2twQ1BRMFhsUVZybGpvbjRvYXM5MDdy?=
 =?utf-8?B?WVRmVVkxVHBJLzBGZSs3d3gxekNrd0hzVFpzQUV5dVduaEJFNTVkMHI5bDZj?=
 =?utf-8?B?enNJMklHQndtSWtPV3M0MGhNNzFqdEpPSVdUYjBaenRhS0drdTlVZVhKK1lh?=
 =?utf-8?B?TWZZcGVySnZ3NFh5Njk0eGpoYlBkUXdSNnRtalAyK2JDQ3V1TTdVZ1JKWFo4?=
 =?utf-8?B?ejMrSmxzeXg0akIza05rREFISE92Y3dzMmhZQ2ZCZXFQaVNHQ2NtUkZTZmxM?=
 =?utf-8?B?c21jcUVuNFFpSXp0dCtSYWkwdURBUHRjTFVCNllLc0huallSKzRtY2FGWEZL?=
 =?utf-8?B?OWwrTHM3eW9BMEc1Q0Z3aXczTlJzMm9IN3JYdHBoTVVPZERtcVREQkx2UXJK?=
 =?utf-8?B?bFpQVmJoaXpYb3lyMy9xWlZRbUFFMlFpQndJMDVMUTdaSEZGT1o1RmFjOWoy?=
 =?utf-8?B?WU83cGE2NU1MTEFNM3BxVDlGTksyakhZenYvMzBMVDM1MzFyTWJjK1FaL2Vu?=
 =?utf-8?B?WHlkcFVFRzBYR1BSK2diZVlyRHF0SUpkK2JySjNUR1NvL3k0ZFVjOHg5THFE?=
 =?utf-8?B?YjNBMVRKQ0YxUityblZPaCtXUG8xbnVEeHR5OHRURVd0SDFOYU95djBSUWxp?=
 =?utf-8?B?ZThPOHdqWUhiM3lDaTdSZTMxY04rUDI2MUZRMDRqLzUwT0J5N0dRMXc5eTNo?=
 =?utf-8?B?VnR4L3MvRFZSWFZtU2tCeVNobVdaS1VrdExBdEE4Z1RpbldtTWIwWkVUOE52?=
 =?utf-8?B?cEw5QWRaU1BNZzRQdTFLL0lsbkhZUlEyU0k5ejhFMlhYdlJRS1lGajZERmxn?=
 =?utf-8?B?d3JIOXF0dDJSRXlFZDNMem5uUWliNHlpYXgyWGE1akhxZmd6bW1jS1NnQU50?=
 =?utf-8?B?TTlYUEFwaGtMRmo0SEZVQkxYNVZCVm9YUzRYRUgrbWJmNmticFU4azYwWDQ4?=
 =?utf-8?B?UC92SGdEcjd0TXFwNUk3Wlo4VHFvZm9kZEpNY2Y0TytuTjV6QUhCb0FRRUU3?=
 =?utf-8?B?WnhHbjBRSDNKLzlWenF2ZEhsdVVSNzg2U0g1SlZDRlp2Mk1Ld28zTGc0aldD?=
 =?utf-8?B?UHptdEtvTUVrRUdObnpqUFRLS1FMbDBnZE9JZWdTL2F2VjloYXFoZVJqUXM0?=
 =?utf-8?B?TWttV2JuNUYwNnQ1OG1PejdmMTlyaEZxUHJEZ0VUUWVQakE0S2VleFBNTXZy?=
 =?utf-8?B?T3VrTFQyVDY4bFV6blBxMi9jYWh3SHhEWWFseFd1bFI3NXdMYXZuYlpGRGlx?=
 =?utf-8?Q?ZD6iwkkyklf/95tqse?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb447321-3ab4-42d8-c967-08deaf3320b5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:58:46.2334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1CaP2Qaj5TaKe8xm1KKY+trMSSJNka98YArLwO51s6hAGS2fi6WXzJ9rGuLYkvhm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108
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

On 5/9/26 12:25, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Koenig, Christian.
> 
> 
> The line " adev->unitid = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->unitid;"
> is 97 characters long, and checkpatch.pl enforces a 100-character line-length limit.

That is to long, checkpatch.pl enforces 80 character lines.

Since the cast to amd_sriov_msg_pf2vf_info is done multiple times I strongly suggest to use a local variable for that.

Apart from this the patch looks good to me, but I'm wondering if it shouldn't be split into multiple patches. The change of fcn_idx into pad looks unrelated of hand.

Regards,
Christian.

> 
> 
> checkpatch.pl passes my patch:
> 
>         root@chonglidebug:/work/kernel/linux# ./scripts/checkpatch.pl ./0001-drm-amdgpu-Add-guest-driver-CUID-support.patch
>         WARNING: patch prefix 'b' exists, appears to be a -p0 patch
> 
>         WARNING: patch prefix 'b' exists, appears to be a -p0 patch
> 
>         WARNING: patch prefix 'b' exists, appears to be a -p0 patch
> 
>         WARNING: patch prefix 'b' exists, appears to be a -p0 patch
> 
>         total: 0 errors, 4 warnings, 38 lines checked
> 
>         NOTE: For some of the reported defects, checkpatch may be able to
>               mechanically convert to the typical style using --fix or --fix-inplace.
> 
>         ./0001-drm-amdgpu-Add-guest-driver-CUID-support.patch has style problems, please review.
> 
>         NOTE: If any of the errors are false positives, please report
>               them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Li, Chong(Alan) <Chong.Li@amd.com>
> Sent: Saturday, May 9, 2026 6:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Add guest driver CUID support
> 
> v2:
> use debugfs_create_x64 and debugfs_create_x8 to create node.
> 
> v1:
> 1. Add guest driver CUID support
> 2. Do not expose vf index(variable "fcn_idx") to customers,
>    replace the fcn_idx with pad.
>    Only expose the unitid to customers.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c    | 8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 2 +-
>  4 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 80b18bbd7f3a..98549a148695 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1074,6 +1074,7 @@ struct amdgpu_device {
>         long                            psp_timeout;
> 
>         uint64_t                        unique_id;
> +       uint8_t                         unitid;
>         uint64_t        df_perfmon_config_assign_mask[AMDGPU_MAX_DF_PERFMONS];
> 
>         /* enable runtime pm on the device */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 979032ecaf79..129ff0851738 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2126,6 +2126,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>         debugfs_create_x32("amdgpu_smu_debug", 0600, root,
>                            &adev->pm.smu_debug_mask);
> 
> +       debugfs_create_x64("unique_id", 0444, root, &adev->unique_id);
> +       debugfs_create_x8("unitid",    0444, root, &adev->unitid);
> +
>         ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>                                   &fops_ib_preempt);
>         if (IS_ERR(ent)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 6974b1c5b56c..45e89e104b5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -534,8 +534,12 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
>                 if ((adev->virt.decode_max_dimension_pixels > 0) || (adev->virt.encode_max_dimension_pixels > 0))
>                         adev->virt.is_mm_bw_enabled = true;
> 
> -               adev->unique_id =
> -                       ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
> +               adev->unique_id = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->uuid;
> +
> +               adev->unitid = 0;
> +               if (amdgpu_sriov_is_unitid_support(adev))
> +                       adev->unitid = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->unitid;
> +
>                 adev->virt.ras_en_caps.all = ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_en_caps.all;
>                 adev->virt.ras_telemetry_en_caps.all =
>                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->ras_telemetry_en_caps.all;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 9dcf0b07d513..d80f01c0e754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -295,7 +295,7 @@ struct amd_sriov_msg_pf2vf_info {
>         uint32_t vf2pf_update_interval_ms;
>         /* identification in ROCm SMI */
>         uint64_t uuid;
> -       uint32_t fcn_idx;
> +       uint32_t pad;
>         /* flags to indicate which register access method VF should use */
>         union amd_sriov_reg_access_flags reg_access_flags;
>         /* MM BW management */
> --
> 2.48.1
> 

