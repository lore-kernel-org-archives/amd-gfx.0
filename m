Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D36C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EAC613A2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49EAC613A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22626ECC6;
	Thu, 21 Oct 2021 16:21:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E8706ECC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWslYVHtPTwkdKy5KRzn3TEk/EssVOr0lHNVyaJ81UvJt49qunWT5QBs37UXG7IzPYuo2LHPe6NXcObv27BbtGZAY0dbQlRkSl59AxOA0OG9rWe0VjUn0OwCpL/JJBaKFULP8xjKXET0zUYPHqJ5eMrpYIRQKfA0T25gtB9Rmlp/Gt+D0yO3eHVqoU8pYr9qfkXOjElaEybgb3cmp9iWlEiUBIzzVuC3l4V/0Y7Re3UnHnrtY/VfiL5gjrPVPofzk8izaJaFmUptAKxKETySfOAQe98D5wxyMBw0w6pVX6T7Xz2HrGJwvYfiys5sGxLKSsDxZh3/EiWrzR1dRHktlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiLtheouYkMPE74jJgSqzczjBRffgCzJgrjwsjJMngs=;
 b=AoHbv+mdY0lRdTyNkYDgsp2sCUviWJHxOGUIilmzHrEeHgw/fsjVGoV6s2A3zjo96y/kqEWlU9EInSqjKjIDZ1JkPH7/BII+qLJuI4WGfIgiIyLE23CSnhpt5xnhqweXBifQU+OjhmqFi+E9XyUO8VbhARFdZiR/7ZOtJLgS0L2CSQsYBV2SyhnQAP+ZbJan6iNdqdPeUFCErKcjrn6KIs7ANkATU6AjPC63tbWtlbGKiBPjwv5dsAhGuUvFLbxq0nET5XJ/Mx7Op8ruHzOM1OPN9RuySQpKArmh26M024C+IJwwGxMN1C/hGjE0zNlMvBHMXRkZJUIsELXANlnjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiLtheouYkMPE74jJgSqzczjBRffgCzJgrjwsjJMngs=;
 b=18bpAsbDJMpeN9xS4wb1yD+Ja1dXm/A00Mwl7l57ZMr9LqZ/WMVh2B712OP4TtozYd0xPjmadCQDoO6DFlpl5KKtKVS6SeQCadesVvZXDQcN654wKbyCZpztymUeRXWKWgnq1RgK1ri0MwUmO0f9IsDhtY9cIACmbb9rNXjpUWk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 16:21:17 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:21:17 +0000
Message-ID: <b6e919fb-f4f6-299d-c0c9-de15b16b7b47@amd.com>
Date: Thu, 21 Oct 2021 12:21:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring
 bad page threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <20211021155711.1191830-2-kent.russell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211021155711.1191830-2-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.15 via Frontend Transport; Thu, 21 Oct 2021 16:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc98cce-ad07-46ef-dcbe-08d994aecf14
X-MS-TrafficTypeDiagnostic: CH2PR12MB4860:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4860FD4CE95A6086B4F7487F99BF9@CH2PR12MB4860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkitxeTEgms78u8gHysFXtXoHJt1gI2fs6BMyHsXv/sIzJzHnrgI9Q8k6BUhXJgVjbRMg2h9DEzK/0GLviodZFfHg0n2KYLYuEngkNcH9GcLYssaQpbGJmWXsqaHV12Fhum0pO+PpDYkYgEYOK/z+SRHWYUeb4GZE7xqoJYf/51/u3AYBuQ902ul4YBAgjNkVhNhjeg30NLkDl4HlvuTApgRqPgiKNkgA3qyvQEihvPX2cASD6xM5CY2hCmPe6sx1cRUiLX2MhBH87Tn26wlzb9aoM4ouv8yZ3GQDgrbuLljqLINFDShFawSSkzuysQ+6yuRH/6cpX734EAk9klaRXApqdehEXVH5cRS9av1qS68hK94AL2QoNFUyQrrlGOMrIUIq7X6KOWcC7xtmp4mr3t4Ryy2glMAbvR9cktrT71u7crj8YF+NL1/FpxMr4g29TI1ixkIx5scaq4+yMoMwMPjr5/NYsNErVvRCzapgM8KRfODO6cETrJfqpQe7AA9N5M1OXHweH63vZDZyrvpaJq6SRO7EuLBKhI4gMB0cxPtvrPcizUzKQoa8jsNGEvkFsEA6RVUnIDg4zr8HEed7kDN3u0YttdZ/51EWpi/nwpxiEVoULbktuitrhIN7imtwTzH5QTFUfLH2cxBJx0kjTYOmTxtIduVefV3FxCZTKIkTsCUQaEwPRY61mRfoPNei0ACKcIDoDmwcBvOG3yIZGihBAnVaoKgCJ3Pcuq/x0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(2616005)(36756003)(4326008)(66556008)(66476007)(5660300002)(2906002)(8936002)(83380400001)(86362001)(956004)(31686004)(4001150100001)(54906003)(53546011)(6486002)(38100700002)(8676002)(31696002)(44832011)(16576012)(508600001)(26005)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGNWWjFsYm5zZVVlWWxJQTdDVnhsa0djRGhGUm9DK2djNE9XbFFzT0M1OTRK?=
 =?utf-8?B?N2daeVUyYXhVb1psRnhKQTJIVnhOSlUxdG9XRWRxN0FuR1dvNlExSDh4OGNx?=
 =?utf-8?B?ajB5dmZ5bC9ReDNKK21HY3NIL1MxMU5FWmozWUFkM2tJRmoxUlFXbUo1TFNZ?=
 =?utf-8?B?QWRSRW1TZTVOVFE3R3N6ZURKdm1HVy9DdmVUZmxXWVJKZDV4Z3pzdGJBdEQ2?=
 =?utf-8?B?bjlVZ2ZPUUN6SWF3dTRqa3BLL3ZIQkdSZmphVXBiU09KR0dYak0zeG4ydkZK?=
 =?utf-8?B?aWZFOHpJd01URkV6Z2c3d3Y4R2tOSENsanN6azVQYjMxM3JmRmtqc0NyVTM2?=
 =?utf-8?B?RmVCTG9QcC9kTlpOelpCWDJ3bWtkQjVzcldlSE5oUzVJTEtUeUZZRmNsU2Yv?=
 =?utf-8?B?cjl5M0VzbGE2RHMzaEQxWGlEZUdWTDZZVDA1OXJUc0E3Wmo1YnZ3MTlFQVNF?=
 =?utf-8?B?SXFwZVNubXNzZk9YeStBV200Wjl1REg3M0N5V0NhalNuK0NmQzRkSitET0N3?=
 =?utf-8?B?NWI4RU4rR21RNndkRjBHTG9aWW9Sb2EwVU9JQ0s3MUVkbk1JNXlBdXJEZ3Ar?=
 =?utf-8?B?SFlFanhPZlJ6YWJtMnVCWFlKRTJKZlZuNEoyN05WSkNsaE5sbWJsRFJ1RkVh?=
 =?utf-8?B?SHc0YXFjQkl4WkJpbXZ1eUZHaHlUV3hveVdsMDZZa0N3MlE1cFBkR3lRQnFt?=
 =?utf-8?B?T3NhZlFXYUJMbEZScWNPMEVxWjROZmZpVkxtNDlOdmVGS1JJVVhhbDdUbVI1?=
 =?utf-8?B?ZllzSDV4Y3psSXhsVi8zRGlwSXJCM3dkSDdqSWVoL2V4WW80TWFsS1h0Rkhx?=
 =?utf-8?B?VWZCTE1FSDVsRHdjRUpDOFB2Tk5zQXNtQzQ3ODY2NGpvdnZUWEVtWWNFMW1J?=
 =?utf-8?B?R2dqclhiQXp1QkZFM0p1R0JEaHdGdkZXYzF6aURlZjhia3pRUDM2YlpXbVk2?=
 =?utf-8?B?YzZDQVkxdTQxM3RtY09OQ28reU5nTTFTdE5NMzZYWkQwMCsrWUNvb0xQTm1C?=
 =?utf-8?B?eGk4VEJGdDN0QUl4UVQ5YXM2UGdpV0h0d3laM2J2amI3MFcxTzc5S1BCT2tJ?=
 =?utf-8?B?VjV6Zm5kdkt1VTd0N3owLzUvYVZYQS9rcFhYcnU4Ylg2aEVBS0xKNzVhSUt6?=
 =?utf-8?B?R0tDL2Fxd0VTMElrZEdWbXQ4SGIvcGZjT2ZZaGpBWGFEU09OaHF2K01TT0tD?=
 =?utf-8?B?WVc2VW4zQ3lFb1VOSm1aU1lWdzhNK1JvbkhJRGhBblRUQkF5aXFjVk1jSFZJ?=
 =?utf-8?B?WEdlL2d5RTlBYlU0SURZbkRZUGdKY3l6eDc4Sk1GVkI4Yjk0dGtaclQwSzFz?=
 =?utf-8?B?OTkvSDllMEZZSDRwa3NUR1FhdVB5MER1MmF5VVgzU2ozd0ZxejM5Zm1EeWJ2?=
 =?utf-8?B?ME5odG9vU3NlRllSaXd4eGNmblJjM0hzLy9nZFYvSnBNaytoTUo5ZDZyN0tC?=
 =?utf-8?B?QU9BaDhxL2MrZENTeStQenMvc0YxUTNoZTZXd1UzV29US0FxK1hGTXgrTEJN?=
 =?utf-8?B?SE1NeTV4WWJhNElxQkxxUXhRR2hpNVoveHdZUTF6akhyZm5oc2w4ZDE5NnlS?=
 =?utf-8?B?dnMyQnVCU0NSV2FCY1g0ZHRLSTJXRUp4ZUdYZEp2MlRDdlNLYkpJOEIvRjhj?=
 =?utf-8?B?ZTNDbDJlcmhLSFlYR3BpZHhndjJuYSsxV1pBQjVLakpVVEZNSTE1OVBMcHh2?=
 =?utf-8?B?M0xKVThQbFoxYUt6VVoyQk1QNnpuQUkvcXgxdDBEamdqbU5QVjJtS3o0L2N6?=
 =?utf-8?B?YmFxSk9vQjJVTHhydW5QT1RJY2RkSTBvbTRhSEg5WEo4KzdoZitjbVEwR2Fy?=
 =?utf-8?B?cVdYcVBhWG0wM3dSK2N3OXFXL0pmRzAzbWJEb0Q1VTQrS2d0MDM4ZEtyUTJl?=
 =?utf-8?B?VVFRb2xlcU9OMm5uZDQxZnJLODN3WUc3T0NtcnVIMFd4YVBDM0ZTOVZZTWQw?=
 =?utf-8?Q?mUfG/XD7Wmk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc98cce-ad07-46ef-dcbe-08d994aecf14
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:21:17.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
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

On 2021-10-21 11:57, Kent Russell wrote:
> When a GPU hits the bad_page_threshold, it will not be initialized by
> the amdgpu driver. This means that the table cannot be cleared, nor can
> information gathering be performed (getting serial number, BDF, etc).
>
> If the bad_page_threshold kernel parameter is set to -2,
> continue to initialize the GPU, while printing a warning to dmesg that
> this action has been done
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 12 ++++++++----
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d58e37fd01f4..b85b67a88a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>  extern int amdgpu_ras_enable;
>  extern uint amdgpu_ras_mask;
>  extern int amdgpu_bad_page_threshold;
> +extern bool amdgpu_ignore_bad_page_threshold;
>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>  extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 96bd63aeeddd..eee3cf874e7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -877,7 +877,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
>   * result in the GPU entering bad status when the number of total
>   * faulty pages by ECC exceeds the threshold value.
>   */
> -MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
> +MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
>  module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>  
>  MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ce5089216474..bd6ed43b0df2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1104,11 +1104,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  			res = amdgpu_ras_eeprom_correct_header_tag(control,
>  								   RAS_TABLE_HDR_VAL);
>  		} else {
> -			*exceed_err_limit = true;
> -			dev_err(adev->dev,
> -				"RAS records:%d exceed threshold:%d, "
> -				"GPU will not be initialized. Replace this GPU or increase the threshold",
> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>  				control->ras_num_recs, ras->bad_page_cnt_threshold); 

I thought this would all go in a single set of patches. I wasn't aware a singleton patch went in already which changed just this line--this change was always a part of a patch set.

Regards,
Luben

> +			if (amdgpu_bad_page_threshold == -2) {
> +				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
> +				res = 0;
> +			} else {
> +				*exceed_err_limit = true;
> +				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
> +			}
>  		}
>  	} else {
>  		DRM_INFO("Creating a new EEPROM table");

