Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6B1C5AE59
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 08:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BC710E596;
	Wed, 28 May 2025 08:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r6FWx16R";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF59610E595
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 08:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6cjFvFOObuRP+Jbop07gUJ9iAglJUyQbgMsloClEzRVFleVLkxsW+w4mLt3Qb0wQuy3U3oVaOqnWCso2n9QiKb89zcZH4lLSucIuDaXICgxBDRljjM+QSDZDD5FGHHmPG5PpVjpYJ8XCpJhsLhZ9HYnCBZS12Id1DuckMgnaHmDGBaTgeu5zwgd5MuQFSHjU1yOtsOHcQN3TSd0fjzuJVTaASDJsWw0TjXS3iOXmamjeV8tO9cYHK7URzOcNM8spdeq1cTGKUNbyXYidCneQeFio9c2uodhV9zEnTU2dMvQK1i44KLsQnSVHU9aEVaX5IKZVG3hPzr9J8obFJ3T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MvSgQLFafXWhUhiQK5+Royc5K4w7LWMnmuCN7gq4m0=;
 b=MC5lKPtodotDHdb/geguDogLSCDG0PBfbpu5adTkMMjYj8guVvRHvXPXmeU4H6FQB9HiFXXhJhDCqjrHClLtY5+wEDdqIMqwt3LtXFYhI7nRzch4D11suK18sJ8LvGaltto+yMe213kOB0g+4KuQiE5o5q8yiqiQTXlFLGBILzbaojn8KAMYeb9T1Qq3X+LkPkbKelD5ZMhR/GriUKQmjfj9GPRkqpVn87qE2nTQbdEhdf/am+ag5MK6VU4x+YkO1VGhLPFQn8khlAUWFhBwNqDImEHldCeg7ceuhqQHYHPtNLbZRRIQPNgGFxb8PxVCz1lLfFt/1f0NbiBaEPU+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MvSgQLFafXWhUhiQK5+Royc5K4w7LWMnmuCN7gq4m0=;
 b=r6FWx16ReycuKzMbKhGB69lTx6u1VxNFPujEZ/QRO+Cp9ElZFndWA0bH5v0sCc9cHQ9yyuVMRolohHXTBc69TrBHG/2pZxgQAP34fpbmCLBtaZfbumZ1RigyVjNeHPfbT7OLJfngxEptU/SKN25p858M1CvW7SXveoj6Ef8YelI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB6888.namprd12.prod.outlook.com (2603:10b6:806:260::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Wed, 28 May
 2025 08:13:15 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 08:13:14 +0000
Message-ID: <0844269b-520e-4a0b-b3be-2bfaba2aa666@amd.com>
Date: Wed, 28 May 2025 13:43:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] drm/amdgpu: fix fence fallback timer expired error
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
 <20250522104048.569456-5-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522104048.569456-5-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::21) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: c41228e1-b1a6-46e2-79f2-08dd9dbf7e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkJLMEtZdUJidjdvN3VOemJKNVduM3R1aEI5cGJVcWRORndKb0FsZ2NTcU9U?=
 =?utf-8?B?UG9OTVd1WmxJRWVoTTFiUDl6OVJSWDlxSkRBd01iSlN6c1h6T1NtS1IzUmJ0?=
 =?utf-8?B?aU1EWUdOTUhUdndwV3doWFA1RGFQTytobitVaWp2WFpNbFBiRXczUUNPZ0tp?=
 =?utf-8?B?aVNxdDEycXdRR1ZPaEVtVlhJSTFia0V1VXkwOHJpNnZnMW5VQXZpZ3lxV01k?=
 =?utf-8?B?Ky92TGgvNkNHMjRKVCtWakhXN0gyYzhXUFNkU0Q1Rmg2OGRLSy80MjZQTy85?=
 =?utf-8?B?TFJTNDBadlM4U2VQb2JSSGFUTDJXU0UvbVJMUW5UNjNQZkFSME52bmhUdVVq?=
 =?utf-8?B?cE5TU2tNMXYxbnZKYzdUdGs4UHRobnlTNG9wUXdJTkppNmtKSFU4QUdlV3hE?=
 =?utf-8?B?RzliNkJGcnBNVkpkWGVOcDMyTXdXUHlKV1B4aXVTU1pZWnZMTkMwbUxsZGgx?=
 =?utf-8?B?cXVQOWNXYVQ4NS9OZDc1NW5Ud0UvQ1ExZ0ZhY2diVmlCOGdGNEl3Ykp3N2NP?=
 =?utf-8?B?TnJFdE9SbjAwWmNsVnhGT0lKWlQ0RVExZTRKUDZEQlN5STMvSHI5c0szbVVy?=
 =?utf-8?B?UzhTREhvOWVGV0k1T3VRMlhDMmpaOTJYdHVTNFIxdmJDRDN2TWo0aWtOT3p3?=
 =?utf-8?B?N0lLRDBQWTVrV0dpYmI2SFRKQ2hLdWdya2JKSjJQYUdJMkhmNVRHaXpTRXNu?=
 =?utf-8?B?MFZKenR4eTZyOWpoeXhQNUNCbWNOYjVMdUxicUpCSmh5Q3lYaHhYcXgyckli?=
 =?utf-8?B?UUdyTEZSZ1ZERTREbUFoSmtqYjRlYWp0cHlub1VKcVBFdkVlWG5LcWhXTndz?=
 =?utf-8?B?Umwxc1JLZVZDSzl5VUQ2TU1wOXBxU3F0QWJYOGZmeVRnL3NPMmdhdkdVaURv?=
 =?utf-8?B?V1krRnRtNlVuUmFldFRVK1FTYnZjbHk1TFdHSW1FUllURDEvMktUWllKbHhG?=
 =?utf-8?B?a3V4Y3FwNG9jMmxRcUNvNEl5RUFwWkVlcjV6b1UrRjlRNElNRVlnaS8rM25M?=
 =?utf-8?B?UzJsUUs2bVBhZVZGaW5vVHZjYVRVRmVuT29zT0w4YXIwSzcyRUJYU3BoSlNE?=
 =?utf-8?B?ZkNrRElkWFUzcmFkcTQ1R0hmUGJOMW8yMk5rOVlTc04yYjU5bFUyRUN5bTk2?=
 =?utf-8?B?Z2d2ZS9FRDlNOU5HN04va2s4a1JDVFNaZzVmSC9FWTNKdXdSbkdCay9GTXZR?=
 =?utf-8?B?SEd0bDQvYjJoMmVJZVpNSFE3SE1CYzI1M1dmeEZRcmVkSHVFdHUrWmE1dHFR?=
 =?utf-8?B?UTRwRXhnWDRxSnNSMnpjZmV2NzJ6SXY2S283dlhzWERWQU5YcGpUemtXZXNS?=
 =?utf-8?B?K1l4b1NROEdCRzdWYlpVejNMaENWSW9teXpZaWR2U3RrNmxQY2tib2lGSVFq?=
 =?utf-8?B?dnFVSHFMWVRZU0JGbzBqVHFremtLdkdvUnYrYXYvdWxkY3VNMlptSUVld0FT?=
 =?utf-8?B?THkxanVJNDZVZ1hycmNaOWVMS3VDdDd6VDhZOW0xRnYwcGJkWjRPZWN4N0Fl?=
 =?utf-8?B?cUpWdUMwSkxUQzlnV2NKSngycTFHWDVXVHpmL3UxRzlSVWVYWnk5R2EwdTA5?=
 =?utf-8?B?QU5raFFnRmhUeXZTdEhnbUJacWlaSVZ3c2JkdWp3RzdEbTRMWGlkOWF2aitZ?=
 =?utf-8?B?bDVTdm40SE1wNDhkaCtwK3h2RHF6ZkEvUmZMcEZyVDhvNzJlQmMzWVJZTVdM?=
 =?utf-8?B?NHhrbThhd0V4akx5UG9iUktTUlBwN2NCK243OUlRc0J1clNaVnE2akZpYXVZ?=
 =?utf-8?B?cTdkY3NOMWRBdklCUXFjOU1yd29nSWxHdUx1bExrVyt1U01vRE5xNHVXTmQy?=
 =?utf-8?B?bk8yZGNmSVpkNG1sUlBLNU9HR2p2aDFLZG1nWUhTd0NjNDJPendKNSsyZWRk?=
 =?utf-8?B?a0lZdnhTSW5tc0RzbVppR0p5NVRITy9XekdsOTFNSnpmV3pNZVU2QmRKejFC?=
 =?utf-8?Q?EB3uwfjuH3I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDNxa0JDZ1h3Z2ZwQlhiR2NXOS9YR01GUUVhejdkS1JkL2xveG1XbWMwRzdV?=
 =?utf-8?B?MDl0WnExc3dGa2RhWjJjMGFjay8yMkFlcHA4ak9zRWhzNlEzZ25oUSt6Z2lI?=
 =?utf-8?B?c2w1aTFueGRtSUpZMmd1aDdFa3hXY3NKbTNxNXE3K2JrYWhVUUlzVFVBZjRn?=
 =?utf-8?B?OUY1ZXM5dytreHY3WE50RVNCcU5Ta2RXc1ZtZDVnMzNVT2JXZHNtME5DejFR?=
 =?utf-8?B?Vm8vQ2dReWRoNzAxMDAxT0lML1lPVDlvcWgvcGxmWFBKWEtPcTlERHNZWFJP?=
 =?utf-8?B?UCtDQUM5djVHK05VQWRMbThpU1I4a251TUQvMVMxWXQ3T1VRTTBWeVdZOUJU?=
 =?utf-8?B?cjBXTG9QWksvc1RSNUhocUQ0eTlOdm9oRGhFQjlTRlYrRWJXb21TSWVTU1ZF?=
 =?utf-8?B?NVFNTXRrNWU3M0owcHRGa2ZzT0gwbzI3MmVvYnpibnAzNnlDRkFPMDJUd0pE?=
 =?utf-8?B?R3pxVjJMTWdXUDZvTjUzRVFnK00xTDRUSERSdXRzZEpYNUZsY3ZWSXl4RXl0?=
 =?utf-8?B?STZnM2lxaW5DbENKLzZ4Q2J1cXZUSjZ6U2tseGlTSm5iYjM3VGVuMkp6ZEFo?=
 =?utf-8?B?eFh1bnJFb3FGK3RkRGVnK00ybkFya1BYdEdYU0UrdklYNXloNXZ1ZTlVYWZM?=
 =?utf-8?B?cHljcjVoZzYzeUcwdXdrWm1YRTE4YlhCd0YzdW1JWDM0bEJnQ0NrbTl2TzAz?=
 =?utf-8?B?SWFOTWtLUjRGS3dHOERlNXQzR1R3VEhSdEMrbk5RMngybFZqVVc1MnB0VGt5?=
 =?utf-8?B?WWNDQlJxL3BvTU0wOTArMlZRZFFmRnB2eXo4cnBXS2pqemZML0xoaDk3UEZY?=
 =?utf-8?B?b29lRy9IM1NPYnJydmNob0lxcW1vcGowdG54Y0FiUHBFcVhaQkFiSUtFTnFY?=
 =?utf-8?B?d1R3OWVWZW14dENtYlhCQlFRL3Vpd0R1cHJJaGVUQ3BRSnJmRHlqWlZrSi9o?=
 =?utf-8?B?MFpoOXBlb2Z2a2V3R1QwVmp6a3BZeDRNQ3hYMEZQQVkzSFNheW9Pdmx1ZTg1?=
 =?utf-8?B?T1M4bVRMckRxa1o3YWVwR3ZxekdSd0VKR25kV2t5bzMwYk1LeWJVT0d3alc0?=
 =?utf-8?B?cjA4anVmaFJVTTlCT00zd29VWmlpVjdna2pGa3h2aVc2cFNwR0Nkbko1VzdL?=
 =?utf-8?B?Znc5K0pXbFRRZEZEMmJLU3RQNWdwUUs1MmpHUnpjZWFQOFFTemRBYmptcUJE?=
 =?utf-8?B?YkdsMVlNcE1XcVpUb1FmMUh2b3dyT3gxcFBTYmpTa2p1QjJlOTdVTENWYlg3?=
 =?utf-8?B?cnVKeExlcHFVUitUOE0zaElQTTdsMmRJWUtQRCtGdkFKRmZ1YUlUc2x4VTVr?=
 =?utf-8?B?eFdaMWZVOG5RY0lrdTd0RkFHU3lPNHJJc2NTWTNUMVlyZ3hyaCtYRHpJZHpK?=
 =?utf-8?B?L0cxUXRTeUlIaEdnMjRsbi8rTUR3T25NYWVXZE5GMEx6dTh4ZzdOMXgzK3hQ?=
 =?utf-8?B?RUZVRGRQeldDeW9zMTRTT05jL3F3L2hhaHpzTXVoTkQwVjc1V1hob0htd0wv?=
 =?utf-8?B?SXZxMUdObkpNaVdvNjZ4UlpqeDZ4cnlka1U4d3VnVFpIVjEyS29tcngwci9I?=
 =?utf-8?B?Ym8wOXJuTmVTL0gwdThVeS9XbzZ1RkNFY3I1NVNvZVNOazRWVDZjTkNoSzMw?=
 =?utf-8?B?eGNVbzBLdjZRUldNeGYvYm0vR1V4WjdGaWEvMHg2SUhET0FVazZkbHFvYnVk?=
 =?utf-8?B?ay9IWGM4Y09JcmY1Y0VTdENMUUtQWVNrVldmVC9hS2JZVkI3N2dVOGdEK3Ft?=
 =?utf-8?B?Y0RqR0IySHpZWFY3TC9DbGJ2c3FzSlBxdXY5SkpYYmV1YlFqaUdmZkxlS1Fa?=
 =?utf-8?B?VkdIQ0lmYmxoS2QvYTV2aUJHRGg1UEw0NGFJS3pLVWpoc0Rta2ZweXhOWnBz?=
 =?utf-8?B?RXpnN0JuYU9UWWNxSjVnZXBwVEFXdzlKRmdxWk5USS9rSTVYQ1VDQlRxSjdh?=
 =?utf-8?B?cXBNRVBVczNCVGFyK0ZaRU1XK1BXMGF6YUh0MUQvVVQ0UEVnUmI4eFUybUFn?=
 =?utf-8?B?bmhGaVU4VFdNRzZ6bWQ5Z1VOcVNaTi9YMHJtN1ZOdTZ0cHVxU2p0RlFuank4?=
 =?utf-8?B?TUxiWEd1L0lUemVNUVVvaFVwYmVEanRrVjd5RUxzZ05HdzRFUmFPb2ttRVd1?=
 =?utf-8?Q?2Pc4fOZelF013nF7ke9BoNeN+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41228e1-b1a6-46e2-79f2-08dd9dbf7e46
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:13:14.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5bBM44KQKc04r+lifranEp9AlC4Gv8kWTtlV7pjF8UlsI3naxP7zKCvrS8gWjVg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6888
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



On 5/22/2025 4:10 PM, Samuel Zhang wrote:
> IH is not working after switching a new gpu index for the first time.
> 
> The msix table in virtual machine is faked. The real msix table will be
> programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> by nBIF protection if the VF isn't in exclusive access at that time.
> 
> call amdgpu_restore_msix on resume to restore msix table.
> 
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0246a33b90af..82dba152101b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5051,6 +5051,13 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
>  	int r;
>  	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
>  
> +	/* The msix table in VM is faked. The real msix table will be
> +	 * programmed by QEMU when guest enable/disable msix interrupt. But QEMU
> +	 * accessing VF msix table (register GFXMSIX_VECT0_ADDR_LO) is blocked
> +	 * by nBIF protection if the VF isn't in exclusive access at that time.
> +	 */
> +	amdgpu_restore_msix(adev);

To clarify - enabling/disabling msix here triggers QEMU to program VF
msix table again?

Thanks,
Lijo

> +
>  	r = adev->gfxhub.funcs->get_xgmi_info(adev);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 0e890f2785b1..f080354efec8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>  	return true;
>  }
>  
> -static void amdgpu_restore_msix(struct amdgpu_device *adev)
> +void amdgpu_restore_msix(struct amdgpu_device *adev)
>  {
>  	u16 ctrl;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index aef5c216b191..f52bd7e6d988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_irq_add_domain(struct amdgpu_device *adev);
>  void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
>  unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
> +void amdgpu_restore_msix(struct amdgpu_device *adev);
>  
>  #endif

