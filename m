Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CDFC61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 07:34:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1A010F296;
	Fri, 28 Aug 2026 07:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hViJ2WPk";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012067.outbound.protection.outlook.com
 [40.107.200.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308F510F296
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 07:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoLRhx8btcZhDuqLDv4t/v3ICj4QdVxTQRKczl0zLX7XJ73aJbnm7XvOHhet9HhDl+LlagYCXO+YatGXFAv9PCtaWFdiKp8nr0jDatpLoelgfRod1ePLLOyzmENV+XAqOw6M7Fo/ce/ZZ+77ZUxBPH18G+QQ7cnd1BG+YDJMJRskN521DhB6izCdwhtLZYD//5fjrvRzqOgGf3qP3EENAwv8NXXbQGaM5P3RBtPuZ1mFzo5M7k4joBsAhkiEixC6i4Wmk5qa7ME6US4caoq6st3iBOsua5XdBJpt5ALRj7JRf14n5kjHMaJQqizKL6CkyuXSW6658pF67WP/EnzLvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPp/IT1Jfx1o4N7iAwheFL941HbQAIc8ALRKzpRUYlY=;
 b=mtkxwhK9PQWUiMn+lFROoO4gIz6/ZB2Li2j/f8VeNhMP4kKstYSA+ImriUG8A/ubyuxWNzQVpYHt3qGYUwFzS2UY7knvtuLZM3Xin8fjSAEaFxiI8AxpPo+lZL5/Ss8l05sTYn9Grikm0TyrvZjN+NpRnk5UotDgOe1YEp/jqAKpKfRGOB7ZMkzTRcHgLJfJPHl1kO+qsBTr8MqcWeeZdDMSLX5umDuOQch27txIQ0fuD1+vGecWOlvlY9fkfgeWgBDlijs8Vwt2PY4a+cUb13L4TBWhYYxFznAyRwwwEsSfaqYTHqZj+PNf0rmDdtrsOnjwdSadTwlcfmRjggYbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPp/IT1Jfx1o4N7iAwheFL941HbQAIc8ALRKzpRUYlY=;
 b=hViJ2WPkKqCuj8p+zauX7W0OsXAm7a3q89Bwml1z+nWG1Yak7AxWLOv8bWW474xCo2KUEIpK501gqt+LWdTNyfaouBHK74zIqC+a6O518jgFskIDAFGfOM8uyUaZNKxgnKo1inhqVY7/nV3DEEHQUMzSvqalLHt9Ft9BisZNDRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8215.namprd12.prod.outlook.com (2603:10b6:930:77::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 07:34:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Fri, 28 Aug 2026
 07:34:12 +0000
Message-ID: <2c612066-94d4-4dcd-91fa-2f8923441468@amd.com>
Date: Fri, 28 Aug 2026 09:34:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] drm/amdgpu: fix Idle BOs list in VM debugfs status
 info
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
 <20260827154849.1021013-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260827154849.1021013-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9d2283-173e-45e9-81dc-08df04d6c13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|3023799007|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 7i1QfACWucvrFxAfoD7RnU2SVarfUThN1JSZc7gQ75ktcMKjrw1SSnfIl2F4C1vkYmZrppbgP65wQKHGVoVc5WcYGcoJMzXsOJRC63KiTN095b5fM+yqOgqzsl2WVp79IKqBUYAWiCprOdMSk40YekqiMHVkmeIMcJd358XkM6kFrGbcPRigIT2GdNZ4NziPVLua+ByyjJfCFEq3VIDptl2Ub+Okn/S50YXnreTezYE7biBIA9vXoNfXwf8cop4SMzQHMNefquZZGHqbFfQbEEqGfYM2etnjxrhqtGI94+u8LsdyXxTwGff8tt8r/HmOBW3r6BObuCkzxoh7di5OO4wZwVKOlfNw5Nimbom3FTFwGp1zdVPL8fKlpxPs23/b7u6t2PkPFoLQpbxDqxKM5DpdNsTju647zpGcAVqETmLu8HCExI2jxgvKciWGG25MsFoAGAGccqW/NkzzSN3gnjYAQHgALf3nl6dEROa4HrNXb1P//N/ATHakofIrDQx5ilYg3Fo23Ay+BN3FBd74ImMIiXKBNIoyYu3C3IuZ7cU9PscSZcf7Jfn52Ka9GdvqBQ8lXO2xwCHDFdCoZOpn04FsphZ4iK6LJpdtEW621B5B2kdPk4u+iEqETeBGBFUX2HKWwcystimSkSst51+QDcdnA53K+81/tmwkZkPMmqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkhDakRlVHFHMEZRYURRTE1RVWZpM1g4WUJ3YlNqUkREK1U3MGw4bEJEY29B?=
 =?utf-8?B?STNabFp0bHczcGx3eGlpUDdVem8yLy9hUlVUOGxGZGlaU0hBWm1VSEZWc0hW?=
 =?utf-8?B?RTNuTmJPSnJQY3BOQzVpeWZXRDlNK2NzOHZwbnhTTVpQSFdSVy9iUVFORmRO?=
 =?utf-8?B?VnZUUXhxMGtPZENQdVc1dXRIR0FRaXdvSkFQZkJFRUV2SGNoK2JMTjRTRWxz?=
 =?utf-8?B?emxtM0l6UEV6SExtMW1xSk0yV3lBZy9TU2dMRHVJUlpTZEVvTGxkVWJLbFZp?=
 =?utf-8?B?M1pONVBDWGZwOXFrNWYyZG52aml3aFBZMXJNcXVBV1BGQ3ozcHZMMkhyYXRr?=
 =?utf-8?B?NU1PajhYeVNRRURQUEFFcFI2dEtEMGQ5RVJiU2VBdWNTeW82LzdPUUI0eTFy?=
 =?utf-8?B?SHlVTEV0K08wUTB5ckNiL0NRUXVYMzZFczVYbEp6cnZOKzlOOWJBUjVUeUVI?=
 =?utf-8?B?NmRDN04veDlwZmgvTXRpalZoWFZiUXZCL291Y3RIMjVsM05DSEFjd29BZVB2?=
 =?utf-8?B?dVdzTi9uYW5GaFhQbWNSclk5U0lZRS8waGVOMHhMeTM5aU1YazRwdjNabkts?=
 =?utf-8?B?R0s1WmVqbktSNzZIUzlNUkdYNmdKRXFhK240Yy84MXFXV3lxNTl0eU5jVTdS?=
 =?utf-8?B?MDhCNkwzaHFJYndBbkdLRk1QVVlza0JLaXZNcmRqWUZVNFJUWUhuZzg3dUZm?=
 =?utf-8?B?Ykt0ZUxVSmlmSFVMR2NmMERQZU4vMnZmcE9qQk9OQlBsUkRGZ1RHM2c2dU95?=
 =?utf-8?B?ZkNQUk11SWJPMWg2M09pb1k4bGUyclJNdkxtU0hmZnNpenYvcTdxcFJrQ3Ix?=
 =?utf-8?B?WlVZWmJQa2toYkNKcVNhK2lqR3k1VnJscldnTFVVQUZkdEtMK0sxajU1Q3pF?=
 =?utf-8?B?VmMvbTJ2UmhGaDFTalM0WmZwNEJ2ZDBCbTdURDZxbng2WEtLUTJjdW1Vc040?=
 =?utf-8?B?YWFtcmswTW1aQW42RmJwRUNUUWlOcTkyUmNJaVpBMlNEKzBnU3NLUVMvQ1Nh?=
 =?utf-8?B?TGxUbmFmb01oOW10VExyOFZCSkY2VmwzejlXQUV4OXc2VHRxUU44TGxYb1Zq?=
 =?utf-8?B?OURpNGxyNGFSVFdCVmFHNi85Qk1lQ2R4Q09MNEJhUHF5K01xcVAyMklQMm9D?=
 =?utf-8?B?cnhwZEVMTVNJRGkrY243djFPN2RYUjJqV1BWR0VjYXVPajlIeERodjlPSGlv?=
 =?utf-8?B?TGliM3hnOE9FYS9jdXBFV241bmE3aTJDQjZTZzdaZGE2SzF2VnNMemtTZFU5?=
 =?utf-8?B?WDVLNlNQSGM1VEM3MWdBTkxKU29yQW1mTWxpbnV2cVpOU0RVZHpvUlR5UHNQ?=
 =?utf-8?B?VktISVdBc0FtNGFNY1hKZ0lMR3FXOWp6L29TUFZ6UHdhMVNLclFFSEJLNHhN?=
 =?utf-8?B?TGlmeFQwekt4eEVqUlFXamwvWGxaRk14WEY3RFRtbmQyVzZNbWJOa3FQUTZI?=
 =?utf-8?B?UDJTa2t6bVhnN3hYNW9VVnFEMmptVWFkUk96T3R6eXlaRlA0dHNEYnFNSkdV?=
 =?utf-8?B?TmUwTGxBSU12alVnS2Q3SGhDNFlzQ2I1WEFLMWRRK0lhYkxCTllQbWJYTXFs?=
 =?utf-8?B?NFBJOE80bTNWQmI4eks3eXl5SWtvL3RLZFNPdFlkd2dEd3RNRDRxNzNzRWRU?=
 =?utf-8?B?c2l3OUhiK0krM2V1SWRrUnEwUGg3K1BXU2hNVUFyMU9ETzJsMlVNd1N0dmhv?=
 =?utf-8?B?ZzY3cDNta0hMTytPMXBoWSs4UGFEVzdaWURKN2wrUTlzaXNoM21yMWsrME5a?=
 =?utf-8?B?ZjlzaXZUV3ZsUllQMWhPb29OUnBDZi81MUJnYngyZDl1elUxc0trYjdmSkJP?=
 =?utf-8?B?UUJ3aW8rMjZJUVh4UHZFdnVLWXZxOFo2ZkxPTSs2MnQ0VCtjTG9FTFZXUTR5?=
 =?utf-8?B?dUJteUpydElJSjMySDl3dlBXNk0vaGFpUVZwZnUvRFBsSGg2UFVLQ2xucmI0?=
 =?utf-8?B?YnA4WmNLTG5YbVdQbGVzTnRYeUgreEMyM05ieFVnZktKelc2Sy9IY2VkZjZl?=
 =?utf-8?B?bmNvZS9ZZVFxMnhTOTI1UU1zYkpYUGE3dFBvdC90Unp1UVlFVWlOOUdVay9M?=
 =?utf-8?B?U3hERW1lTThHUktQZlhvdjAwS0JxNmsvUDg4QnVBU3llcUgzQ1RPazdyczAx?=
 =?utf-8?B?VWZaS3BqVUJtcXhVUmNCSEoxRWxPa1hRNURZckpXNUVVV3c3ZUdpdExja3Bk?=
 =?utf-8?B?S2VsdkxiaHpRZ1Q1ci9ZaVh2d2IwSjhLRVN2V2wwZ3V2NWN1ejB6NnVnN2h3?=
 =?utf-8?B?M0RaSE1vQjNtTWo4QVFPV0tEK1VJVC83TWFMMnRBZ0lZNTM1bGdDK3ZERmRP?=
 =?utf-8?Q?z2kKKVfLTm7DhM0ECL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9d2283-173e-45e9-81dc-08df04d6c13c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 07:34:12.2544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ0nKwNQPMWzUR8pznlnRir4Pg6QMwLmjyZJfl7kTj2YPTUsH6uGUIWdw6NMMTeY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8215
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

On 8/27/26 17:48, Sunil Khatri wrote:
> amdgpu_debugfs_vm_bo_status_info() prints the "Idle BOs" section by
> iterating lists->needs_update, the same list already printed just
> above under "Moved BOs". struct amdgpu_vm_bo_status has a dedicated
> idle list, populated whenever a BO's state machine settles, but it
> was never read here, so genuinely idle BOs never show up in the
> debugfs output and the "Idle BOs" section duplicates "Moved BOs"
> instead.
> 
> Iterate lists->idle for the "Idle BOs" section.
> 
> Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dbdcd57e5b6b..24113bf4d276 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3121,7 +3121,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
>  
>  	id = 0;
>  	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry(base, &lists->needs_update, vm_status) {
> +	list_for_each_entry(base, &lists->idle, vm_status) {
>  		if (!base->bo)
>  			continue;
>  

