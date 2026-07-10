Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B944BC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 12:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9E210E1B1;
	Fri, 10 Jul 2026 12:35:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ejEG7diW";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AB6910E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 12:35:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8BeIo+75mwnjecJyLPJM8z5XvROq5KJpMasggz4bRLgcExUeIpMCiwjm6BnCoNXGXaCLTlBPrtImKmqNhsfgobyXl+uyGePKVcqEHppZfIjG38rNVd8H75NUyNoQN5/SqxIR4DZcm7KLTECYKDchhUMGTH7MutLyEqx6OT+hMAcFWz8fB46v12k8FI9kX6PGYh58lIUiCgjiLhA+dYBvO49tjApRGUkoBvTcsP5/IUMrWd3JP5wC7i9JYk490d7r+LP/cm7gDxfcb5UtVogLWuWNb3xE5ir5r8fiCVZGJMNSL8tqp3FgPJJHLATjC5NN41wfnCoMqX9mR/+e7RiTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsGMPbvViP1kt2Y4bnOPcizj6nGabc2nyvYqmnGxYEk=;
 b=g1AhDo/lcIyP8lajJroK2CGVQpJ/HGzML8BL3aoBIrehpsI7XPRSGx40NQGUgeDvGj/2Gl1O1mnOdGkKZ7m0QFXuKp2fGi59EKJhwZMhJRXIdBN4TIknc/73QY4WpC0o5mb2hsMmb50wFiOBPCj/AckU6Aw88Lp5knUyVE1M494FAv9uu2+UybQ13HWXmJq5hIfMZXVWbVNNT+tQvFnFKXo2GPVXKziUqOC5J2PydES0YULL267dnTw2cIZJCcyAGZdqBnF2s2+SUhTPtqgwv19ZUdxPcKPsA+tDxqgh4IDhIrFcXcA1bPoNhIYujRYpBPoN1ddSLdd/POu8lucCrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsGMPbvViP1kt2Y4bnOPcizj6nGabc2nyvYqmnGxYEk=;
 b=ejEG7diWoHxnDg5PO5PsjNcwMwNGpDqfpyH5cNb8f3FF3CEZNzEcS+6b5Yf1NuaAeexxWqa/ZMob0OToFmh+lXHl2cy7hHVZqnU+cwAUMQ8kkVzbg9Kc5Rxl6rEVEHPWOScbExDFWhEYwhsHQz3xvwDvpBrNxZBlllgJAjWLWYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 12:34:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 12:34:53 +0000
Message-ID: <93943d4e-7a46-4bc9-b0b1-78ec0000e794@amd.com>
Date: Fri, 10 Jul 2026 14:34:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Zhu Lingshan <lingshan.zhu@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4663e9ee-bf14-4f67-fecf-08dede7fa483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: rtT9JkBaYaRfYfaSkWjkLCpm7iMf5QoZzIlNTG78miULTvwJ9MBwxt0PmNCr7IG4xqBoOzo1CYchyMTA5dICS/Kftj109UfPTITbdvXrZqZbB+Z+AGCwbkxIxO0Gc90EGtcYPiajzKP4CwY1A3mUdGlNVmFOLSBlrzUVdhSwIhSzelg00fC3ZGBsGUU6yGqRMutVP8tm6lMm2DJToyG6XheRp2U9RsbqH/7Mmkm0cMj4iUBUvmyU2g5F5dov3MT38m4kK0DbUWvyhU5+5H9Z25112Y3kwjmS+CtaoExCbPx0WKjs2F5/V/pfVAw/bRdg0D3q5Sxokqg9AMJEgPqYKafj+oQlhL3NXfFG1jcE7/NPCtBW4aHF+ptb1HrxWv6ZPlurHu1q+Lkfhsh3LY7hcK/JcxiySa/R6v3rVG3BosoLRBAwCNFn76vjWqQd2wwVF8wDOsVhx6n1p4MHDzs1qmN3uVzplgeO0FJ5hUrIbM1l3YvOMsW/EyF4hNh5VwTEv4oPuWNbfbEDKLw22ro+lEkHSoeiJt6HTkGLU85iYnC3yMoyAVikC2dRNX3FgQ68KLrjuDpYfi6Bkom9A7fEHxuhTNG/k5G9ml37dEz0Dmlw+K8rRwBuJiZ/HCTD+jmD9IuKnCnq/EX072H48un7+ZOHDzIU3Yah7YKFKy413Vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ArSzF0VTBCSHZIN1RYNmM0NSsvajloOWh2OUJPR2RpalNlR3J2dWhPSlc3?=
 =?utf-8?B?MXdPeGNaS0tsWEZLS0tUUUdUMkx0VFNTMGNZV2NRZVR2NCtGbndDdTkxS1pU?=
 =?utf-8?B?SEsxSFFzZjNnMUhmdTJqRG1yTThxYldMS1FFLzhVZFpvc2pXVVVqN3FUS3hy?=
 =?utf-8?B?RlNzZjNpeU1nczloUHpPZjJnY2UyTWh2YldWWk9OV1FkWEovS0MwSHRkODZE?=
 =?utf-8?B?cmV4Tmg1aXBsWTAzUmdaZWRuQTFHLzBTNVIvSGdNZEVhbEQ4MFlFZURNWERw?=
 =?utf-8?B?Q291OEJiQzRDWUFHdncxbGNrOVRlT3dTZVQxVzNZeEFZTTBFbWxJSThvM3A1?=
 =?utf-8?B?dmNUSjJQTGc5RjJjWFlyQ2VsNVljRFJvMnhJN1BHcW9rdUpGN1lIcWliUWNv?=
 =?utf-8?B?eE43NWhOL2d4ejk2aWVlTXZiaUpPeGpQOHZJdHlrbkl1MU1tY0tTVXg2d3lu?=
 =?utf-8?B?VFFsN0lWUi8wVmo0aFVQY09zZGpMYWU4d2NEajhWOEx1LzBaNnFzaTB2dGNG?=
 =?utf-8?B?SXZ4ckFvcU9sSU1DRENXbFRRMmhodyttYUE4bGtTVWNpQ1dKeTRnaWQzQnli?=
 =?utf-8?B?MU1HcVpTb0pnSXpoSHhYei81eGo3TkxlYytTdDlKeEU0ckRYRTA5RG9SS2tD?=
 =?utf-8?B?N3pLQ09TYTRmcVM3VVBkRThpbzZnS1lDSERKQ29ub2hZWU5IZEpxOU9qVVFV?=
 =?utf-8?B?TzZtZmRKc3IxNzExSWFINUhqNjdlcGxBTXY4QmNFMmhkYU8yZFFoRTJ6Uk9z?=
 =?utf-8?B?MlNQd3ZjYWNxaHJGWWh4aW43Q3E0OXJnYWd6SjZpRlNaYUNzNUtIczNZYi80?=
 =?utf-8?B?NlNEZmdzeDZpOS9FSEdRL0R0SVU2TzNTWFB5clhkTHh0aDF2bFFlMkF0K1Jo?=
 =?utf-8?B?NE11aTllbGt2N3hEWXljODRyaEgrRnljWXRLNWZsNWYxZ3J5eWxqMCt2SDhV?=
 =?utf-8?B?b3M5NXl3anJGbjU2ZENQeFcrK1JZNXFZajUvdnFjbVE0eXFpeFRaa3NaQnQ3?=
 =?utf-8?B?K0VmR2xsbWY5MzMyS3JmbEd6UStSM1N6OGRrMFFrZldTSzJtR3U1UTFYRzM0?=
 =?utf-8?B?WDZ4ZWdEdWQ0Y1BkaE5JVyt0OTVvalJuWkJLMExoZlVta3dTVXZ2VjZBZm0w?=
 =?utf-8?B?ZW1EbThNcldpU1loQjh2TklDS0Q1dEFpOTlMczkzMm1rdlc1azM0TnJMNWhL?=
 =?utf-8?B?bkdLSHUvcHNxMWxxazE0SzlONTQ2ZStuWiszVm8xa2Jhck11ZkRiT09BZG9T?=
 =?utf-8?B?SXlEYUNGSkJrNlhpV29FNFU4eENlRCtXazJqOEF3WXJMdkhvNXRBNWNhYmFR?=
 =?utf-8?B?cnBCeTJpS1NjZyt0ZmgzY042QjRVVWg4cWpZN3M2OFhGTy9mR2VJNjRTaGxR?=
 =?utf-8?B?dG1qUE02SWZseFZ0a0MxanJ5em05WDBlTkV3blVDNk03WkJMREpHeW0yUHlp?=
 =?utf-8?B?WDgvMEU4WHFoQlM5aUFsaGdKVUpIN24rNDRnN2o0WHBIV0swOTJHMFFUbWEz?=
 =?utf-8?B?RFBQaW5qalB6dTNGS3M3L2Q2ekx0UGdJVWVsR1B2eFQvMElNcHVFbWVaVzZS?=
 =?utf-8?B?WWtNWEk2SklvSlZPTWs3NVNUM2xaL2sybXBYSHNHNStTRGxzTDVJOGJYY3ZC?=
 =?utf-8?B?N3h3MVh6RVZkWWJyQVZKeG1sQ1ZvK1VlYmNOMFA5MW9SdDRIZHVhVyt3dmQw?=
 =?utf-8?B?N05PcGhtV3pjcGdrQ0ZEVmtJNDYrdHIxQzhLbCtKVlo3OFhUTzE4MXp1dHBC?=
 =?utf-8?B?bGxkaVJEclcrenJRbjRJNXQ5N1YyZ3NVR1J5cjRYYjN0dmlhREVmY0Z3c1pv?=
 =?utf-8?B?ZHVSL3hLYzVCcmIrWVIwaURZNkU2U3AvbzRiOXVoSnM2aEpxMXJTOGdSblZ6?=
 =?utf-8?B?ZDVMZ1hrVVBIVzY3MHVYcC9kWUw0SGtrL3ZxVk9XSS9yaHY5YmtPM0ZyTFJJ?=
 =?utf-8?B?T1JyRHI4VFlpRFZmT1VvdlhHRitSN2JuUy91NHUwWTJzaUEzemdMZXlBbzlV?=
 =?utf-8?B?ZDFFTDdmMlBuUDlCNGJtNnRzQnl2MTZ6NnB4NmdyMy9WUEk3Yi92U0JTN1NU?=
 =?utf-8?B?UlU3YmV1cjdIa0U5d2V6b1ZNL2NlMnQ3YXkrU3ZCZTVlQXk0UnlPUC91bHVN?=
 =?utf-8?B?ZFNlZXJmclBLYXJYOUJPWDVvNHJFY2NFMnlVZWFvTkpNcVliK3MzTzVkLysw?=
 =?utf-8?B?dnVWQlNMYzBOaFd5enQ5a3UrZytkMEdBMG9KZms5V2VGT1I1cWUxcjZHUHo3?=
 =?utf-8?B?aGdFTWhPK3VGNkR3NTV5T1NvUTEzUndUa2pkeDlDNG1Jd3lXajNmRkpla0Fi?=
 =?utf-8?Q?MRhqYDD1OUaY9NmrN5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4663e9ee-bf14-4f67-fecf-08dede7fa483
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 12:34:53.8321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBYJcwwAxeeDUOEUQ3xDMDL0M8PChTJkvDEV+HRA86nbm7AjsvXXcgOpgC5JKwCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

On 7/10/26 13:29, Srinivasan Shanmugam wrote:
> debugfs is intended for debugging only, and failures to create debugfs
> entries should not affect normal operation.
> 
> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
> If debugfs entries cannot be created, continue without them instead of
> reporting an unnecessary error.
> 
> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 02673f01b448..7c5bc9c4559a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
>  		entry->proc_dentry = debugfs_create_dir(name,
>  							primary_entry->proc_dentry);
>  	}
> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
> -		goto err_free_entry;
> -	}
>  
>  	list_add(&entry->list, &procs);
>  	kfd_debugfs_create_pasid_files(p, entry->proc_dentry);

