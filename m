Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2DDC3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 20:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB3210E3DF;
	Mon, 16 Sep 2024 20:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTyMcxkp";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C70A10E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 20:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIStRCQk8gm9hnggVQm6smVGadnpSRcCLiZ6Bm4mBnA6efgY4Z0S/655+AoSTdCky3nHtgaPHR9eUct69JzOvx3KgMYP2i+BgyzKZXp/GOdlxOMWOkaOorhYKPTVzerSudFcau6gddKGQtp5O81Bnb7zR9rPvCfWc4TEZ21T9meZYNoErKmh0s/HH/7yYffVVp/6ZDczE6iJs+1I/fon6X6ev2lfzzyfEh4XWh9BJKr3Gj1Qnk6I7/MI6A36Ri/8AROIxmZMQ7Wy5BOZxSPy21HmNgD/30tOZyJioGtRgDfRgw4c7pVlusPdRkAtdh+CYHNi/Ro3vRk6rJlJ6vtU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTC/59D1+YVKJMJF7C7ZM0cqmEBN0IRlC8B9aEZp4p8=;
 b=ViYYnWK5+iKVcDCmeOyNtxqUbaYLXrP5qb07tEqWPScOD5Fds05FcWUbtLlFNzkbX+JLArhbdo/pFqhVE36QvmtpLyRfE3Sm2vzBXgmVlPKEb6dL2dkx6JLcBp01vf4/bsq+UZ3uegJYrCIgYCQE+5n/PJ/SjJPyml0qzhiUMy4lFZsd7PqFfeWrr4x3UvI+3cUJvo5IhnvGjQzGgC1WrzGhGuzkhFTKd1gkz/OYm7cvEDEedyJkLGKbnqL3yExf1p9kTER8a7GuFIDn9WOmreKGvQSZcf6Zdk4aw1IK0vTF9/eViLDT5PT+DWEDu17WewpLjPLnzUhMQE3fFx7MYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTC/59D1+YVKJMJF7C7ZM0cqmEBN0IRlC8B9aEZp4p8=;
 b=oTyMcxkp2/EEkhMtYJ53GmhYu9mvw2atPMWJuB9y9IkfAEOcuEHdg/lxg3g0iemvD02+g993W1vb2K6bCUaXhrmKHnnX9IcpPGVd+K83jw3n9CQ2UbhzGeOdB5NaVLxJbEXo+tkOtG4DZib9S8bdbwDoE8jqoTfsYvtOGecZWRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 20:09:51 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 20:09:51 +0000
Message-ID: <896c2ccd-fe5b-42ee-a70b-c0fa0e77a76b@amd.com>
Date: Mon, 16 Sep 2024 16:09:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Allow backlight to go below
 `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20240915192837.124745-1-superm1@kernel.org>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20240915192837.124745-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0378.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::6) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e2bd37-1146-47e7-24af-08dcd68b8585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTQvQWVBVHFNOG1pV1o2WGQzV2loRVBEWTRFd2grUkxOM3RjS3gwY0QwZlNU?=
 =?utf-8?B?KzRLSWNYNmpvQ2t5WGRXcnBqVS9acmNzMnBpM0YrU3BsblBIL3doekdkdEZG?=
 =?utf-8?B?M1lRbXZqdnJ5QlRiK05kS2svcXg3RzZQcDhzWjJLdnM0ZHpDczkxV1JWRG1K?=
 =?utf-8?B?TFBBTEt5eU1NTmlTNDVZTmFWL2gwWlhvTjBxSVhvbHFIYjJlMHdYQ2cxZ1BG?=
 =?utf-8?B?M0VmZUc2TDlXZnRkRFE2R3pJNWVZZkFiZndQdFdYQlI3dU43WHdsSG9EVzlF?=
 =?utf-8?B?UTRocXZOdkN0MzMrZ3lpbks5ayswV1psYjJwamhDd2tUZFg1TGpmUThtTEts?=
 =?utf-8?B?Z0lnZU94T3VZK0VmRjJxL01rMEVkTXBEaHI1YnQ5T0x2UkQ1emlpcFh5VkxG?=
 =?utf-8?B?TXF5dERodU84NS9mQ3l0SmpaNStYTTVqQWlkY1UyYlNWejJtMWxBVWJ3Ykg0?=
 =?utf-8?B?VFNKcW4vWFM5eStUNTBGSVdzRWFUWXQxaXJETFZqWTlTbGVXS2cyYVZqM2JK?=
 =?utf-8?B?N1gyME43dDdhUU96OTBvOFNNa2NnbmtzS3JjRFVDVVlMWUllbm43SGx1amF3?=
 =?utf-8?B?ckErQlpDUzJUQ2ozdFdOeDhjQXhhby9OZ1NEbW0yemJBV3NCRFRmajEzMjBX?=
 =?utf-8?B?bHR0aG0xejlqVXAyUGcrZzdRN2NWaTBkbnBWT05JV01tMlR5djBUc3pHUy9K?=
 =?utf-8?B?c3YvSDJIKy9wdmlwUitvdlRRMDBNeFpGR01iK3h1TG40MlpDQklIVlA3cHNV?=
 =?utf-8?B?ajJKdmJicjRWaU9WZTZBSDNEVEdSSVkzcVlvMk1ETnkxd01pWWo4UExKcVlo?=
 =?utf-8?B?bUJZZGEyRHkxcGNBek43NUI4U0d5Q3AyZDZlTXpqTDl0UElrVGVVQjFmNk1i?=
 =?utf-8?B?eWs0czYyWmgrYzgybGx3YlpSb1o0YUNyeGF3MWNXUU1qMnNXT0lYY245RlY1?=
 =?utf-8?B?VzdNWHVqQlUySmdHMmdRc3FGOGt4ZUNwT3BuNUtNeUhzRFBrTlh4a3IrVmsx?=
 =?utf-8?B?ZW90TlU5K2FOT0JFUlVjZHNDOHllQm0vZmV6SlZoOEljNk90NDFYcmE3R0tj?=
 =?utf-8?B?UWFSUkxaODVhMG9GS1dzQkUrRUpjelI4dGFOaXhXSWY3YUhXZ0xqUE1mdWlM?=
 =?utf-8?B?UkdMb0VNSHl2UHV2ajNUVmFHUjVuK2s0TUJaRUNoWWlXV2tGbEdmV3FJeE9Q?=
 =?utf-8?B?RGU5a2ZXRG5IVHIxNFhyaVVkY0plWUM3T1JuUXRxeXRNUEFtWDRKZUJTanJZ?=
 =?utf-8?B?KzdSU1hkdzZQN0FBdGNwV3N3NmlLSlpVL004bHpqQnhSZGNtNHVsbWp6RGI1?=
 =?utf-8?B?K0V5ditET3hKOG44TUtWRWxRSWhkZG55Q1I4REF1bHBsMnQ3QVJmYnhlR3cz?=
 =?utf-8?B?QzJ4SWNvUXkwTkZleDNjYmJMdnRkaHBpRy9QamNnemxPNk9WTjVHRXAzSHZn?=
 =?utf-8?B?T0plN3dWOVlYcXBDVjBERkFHOHRveEgrekc1N2NPN2UwYktqMjdMeWtWNFVh?=
 =?utf-8?B?a2pkZDBKVWVnQ2k1ZWVxeTlETG1ocjZYazYzWDdBbkw3TzBIUnYvMWFPSVRm?=
 =?utf-8?B?aGNVMDFTODB1OHFTOExzMUE2dmhmMDBOVVY5eGhCcENCSURiK3VMRGdYRlR5?=
 =?utf-8?B?SDBPTkpEeWF2c0JMWkdkc0w5Ylk4VUEyTys0Ry9FTGQ2RWdvSGtZZmJsdFhD?=
 =?utf-8?B?R3FyNjdSeGdwMmllTm93TkpNajEyL3dIMlQza2lVck1GOEdHM29HTTdwbThF?=
 =?utf-8?Q?bJhW4CDRS9iHRj0WGs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5CSU5QcUwwU1lQOCtOYTR3bnFYVFIrbGFZOTNHbno1KzRiRFlUaHlobkF4?=
 =?utf-8?B?eEQrQTB1WlN5SHVYeXZBVEkzTHhXZDBOcWhZc2lsSzJGWkJWNFVhK3FYQWtJ?=
 =?utf-8?B?MnBjcUFjODFVT3VTZkRqZXdEQTcyZGNUSmZIbjduL2NzcTZudk9TOTlnVldG?=
 =?utf-8?B?Wk1jWGx1VlpDeTA5a2ZHSWRLa2ZERlFOZWgxWVFjZXVjWHJPTE42NW5NVnVV?=
 =?utf-8?B?ZVRVTGM0UmpBdisvRUtjN1JURExLTEU5VjNUQXhnWURuSjF0aTVldngxd0lt?=
 =?utf-8?B?Z3JFSnhMcVZxTGZLQ3h6UTR3WlVKdU12Vm9JY0t0UEl1NlFtNHBtTCtBWGVS?=
 =?utf-8?B?ZVprclpqNjBrclNCSnpOSHFFSnE0ZC8zTW9zbmRqbVBtdURTTDRHcFVoV25S?=
 =?utf-8?B?WTU1T1laamhrSU1xODlxY004aW1sdXFWeVhGZ3I2RUdHTEhLQWFVU2FWS3VI?=
 =?utf-8?B?Y0Q3OTF2R2ZWa3N4VDJ0WnNDUmpuL1JWZHNqaEFXMjdIdjM4UlV5TXFOUHQ5?=
 =?utf-8?B?cVBpTURsNStPWHpYakJ3L1l5Q1FnWEJKTGJlK1hsUVVXclp1MTZiM2V5SWdD?=
 =?utf-8?B?alRzSThQRldvNUFpaWNENm5QY0ptbHh5VGxVYUMxaWJvOXNCcVRWdEJHRmtK?=
 =?utf-8?B?TFBqaXlpczBacGRqRmY5dU82WHR4ck9PZm9ONFg1aVNyczNUZ2dBUThJdWRH?=
 =?utf-8?B?ZEd3MWZHcHRnQ1lhM2VoSzAxakdqaUp0MG12YkdxQ085SW9IbW5pMGV3MWpK?=
 =?utf-8?B?YkFHekFnOFNDdmZ1dDBBcEVBaHFKMWRUd0V5K1V5eXVzWWVHdk1WS0IwZUpH?=
 =?utf-8?B?ZjR3OURTR0dqL0ZXN0x3WUhDdEhJc29ZeldjOUdOTXRyY1loU21rMk92LzBG?=
 =?utf-8?B?VVNPZzh1UjV4NTk1U24zTVc0MUV2OWxGc0k3UXQzSnhjMmlSblFFZWx3dDBr?=
 =?utf-8?B?aElBS1dhNTZWTVcxNTBVME9OZDBkRDl1bG95Wk13L213VCt4NW1QamdpN0tq?=
 =?utf-8?B?N1JnUXBZZmZyS24wejIxdXNiSnh1ZHFvNG5CTHJHV0ZWbk9BN2dnMFJJVTRI?=
 =?utf-8?B?UHpvLzhWTHJzaDZ4UWZQeU5ZcG92bW1pZUNJeU5sOGtGZFg1Y3NveGl6NXlD?=
 =?utf-8?B?M1ZXTHhYYUcwM2RTdDg1T24vSXkzSStveFFNVXJHSXl4UTBQYlZjeStlYUt5?=
 =?utf-8?B?WDlxUTdiYVY2eFdRNDJGRjBrUU05RXB6bzdNYlBiVUwydHoxN3dTOWRNVWJY?=
 =?utf-8?B?R1h4dkozTi8zQWo2WDJ4Vm9PcGsrbitCTXdnUThpS3U0aUxjci82VDJIVG5r?=
 =?utf-8?B?RVI3bnljckYwbGN0TldjU3JNVGF6Qy90OHp1VE9EN0l4VWhkOUQxR1FRVGsx?=
 =?utf-8?B?d1FlOWlEd2JwY042dlZFaXhEU01ZWFFvTWx2TUNnRFhlZE1yMnU0d3dNa0lL?=
 =?utf-8?B?dGV1SjMzZWJCeGhCUHFMTVlqK0RpenJpZjRuM3piRnNMd091NlpYZTJRTzNm?=
 =?utf-8?B?WmF3MUY0MTBvL295ZjR4RDNYekZnQ3k1VEdTQlVmc1IvQWdMMmYvRUJENTRh?=
 =?utf-8?B?OUhleHhjL2lMa0xOY0RmRndhbjdMT282ejQyT0h5YzRVMW9DbmhWbVB5ampp?=
 =?utf-8?B?ZzBJRUJOelpIZFhmWDdwMDBYUklRa2NJUWE3MGFxMTc0TTA0Nm80UkhWVFBo?=
 =?utf-8?B?U2VjenhCNVpzSWhQaDQvNGFxVXphZVc3c1JEUzdIVnJFN3BBYzdrdVRmcmVD?=
 =?utf-8?B?ZVlmZUl0U3preU1mNjgwRGxsVjN1K3FzN1VzcHMvRmgyQ0pqb1VObFhTS3ov?=
 =?utf-8?B?bEIyMEJkRDVRMmkrTFJtdExGWmprY1V5MGwyZjVCK0p6RXNXbFZqM2YweEMv?=
 =?utf-8?B?c1NzRmdadEhhQWsyaUpRUE9OSlBNeFI1WVJCdzRUYmthaDBWdGtOZXQrZzUr?=
 =?utf-8?B?ZlhwZUMwSzBBMk4rMVNaUHdqRXNvU3FzMnZyMmFESjJLWHVXekJ5R3FSVVk1?=
 =?utf-8?B?OHNwSHhKQmlUL2lQUFdYWStkd0FUaUVnSk5SWnc4blJQYnljblVRWDdNeEI5?=
 =?utf-8?B?dGxIdUR1ZlhKdzN6ek5rOTdmRTNGRjdqYk4xa0drSGdKQ3cvNkN4b1BISkE5?=
 =?utf-8?Q?8pckfZWqD5s5oJornvhMMLPmm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e2bd37-1146-47e7-24af-08dcd68b8585
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 20:09:51.0580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg/cR5ToHBu7K/+JcIHF+2xwGhWKaLMjDk5JL64ljHVlA8mM+J1mXeUF3f84P+NGT6YcVq7OBWtQHfJaBYUrDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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

On 2024-09-15 15:28, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> The issue with panel power savings compatibility below
> `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT` happens at
> `AMDGPU_DM_DEFAULT_MIN_BACKLIGHT` as well.
> 
> That issue will be fixed separately, so don't prevent the backlight
> brightness from going that low.
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/amd-gfx/be04226a-a9e3-4a45-a83b-6d263c6557d8@t-8ch.de/T/#m400dee4e2fc61fe9470334d20a7c8c89c9aef44f
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ad66f09cd0bb..80b8594fcc33 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4449,7 +4449,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>  		int spread = caps.max_input_signal - caps.min_input_signal;
>  
>  		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
> -		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
> +		    caps.min_input_signal < 0 ||
>  		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>  		    spread < AMDGPU_DM_MIN_SPREAD) {
>  			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",

