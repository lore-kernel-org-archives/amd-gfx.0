Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0784DC4452B
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 03:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50EEA10E334;
	Thu, 23 Jul 2026 03:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X9A34JF4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 824A310E334
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 03:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fywpG3nPoGipYjLMZlBRBNFd60O5oTRw27EouEbKwoWLrMTFF44lveXnBYmsvrd9OrURaqYm3NoYFCJPiq680Bia8VTFMHhds0dYqcaZyQw+ebF3C84sMzPxrYO9ZWx5Mx/68/vpZu0sE9HpySbmxyDSy3lagsW/PO5cBc2C+KA32eSmFmEG1Z+COn+5dtk6DRoYhFWvXkbgpvIrNM4LqE5helsux0/VzxvdiMYU9ZwZcYjGpjluLYjjMhv2ZgUvqAu2duUNrsSKS7ioR9efmBTY4ywqgMOYCTNzqOw2VbyoPfxaNfoJZZsJEdU1eiAAK2MKyONIUrTXhQpghzQAhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7Eq47BQHJ6VNGm5eesCKgv2FVl909LCwDq8TsWeMvo=;
 b=XhKu3aLODoL3+vkXd1JkA9916s43gDjdp2qX1E7qeR3tfLY7eguMxjbqGz+5OnPacGS+qtikxRxDkKxP9ZIoC4oQZ/0zUsnxp79NaLMXVfc8tX+zOyJg5ytfy2G9SMJ1WPaJ00tJb0wr9NsobJF4a1i4QOHeI0RSV65s4xdo0AHUO80prcEgdCNU/34B3S/fB2z2HvaRFyuG09WnpVyFU99ZNz8wxESI/0XyCxDucFOPyuiX4quDON3uN5VrVkfPGDQl0c73nvueZQfD78EtOkLk9wyQJ1GLhVVjxYdzZ0nX/HLf5dIVh/Ksq7IOzWGuepNKxcrGNC1zU3o3sYhQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7Eq47BQHJ6VNGm5eesCKgv2FVl909LCwDq8TsWeMvo=;
 b=X9A34JF45ARe2osFpBobZpAU2F6shRsacCizG4K34MXWnbEQiR451uop/9aYYO94RFPRuNbflCVTIk13dA4Ye3qH8TVfoT/VSPayLN7MVGmGcfO5uFLPKAN2cqwTz66CT9ecoEKU2VurpylCPCNqC1+UqkFkr2b8k+J9epiedsM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 03:58:05 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 03:58:05 +0000
Message-ID: <3dcc390a-716b-45bd-bd4c-6a7c90a5bd49@amd.com>
Date: Thu, 23 Jul 2026 11:57:58 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, Alex Hung <alex.hung@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
 <20260610094639.1965367-17-chen-yu.chen@amd.com>
 <nGLVvJOTS8eSI7IusBrUxw@collabora.com>
 <CY5PR12MB6132D29C644F51CD57A3B3B8D2C22@CY5PR12MB6132.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CY5PR12MB6132D29C644F51CD57A3B3B8D2C22@CY5PR12MB6132.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::13) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|CY8PR12MB8193:EE_
X-MS-Office365-Filtering-Correlation-Id: afdff78c-6d6c-40c8-eb42-08dee86e994a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iGqyDQyr8uoAmnZ76kcAaeskiOi3IvgpiRkooHChzMst/znRHRH7tIrm4ssm8G+akHhRPhC6dCgBVM/fWKHE8VRe29X767aL6QZI7tGpsXtpDrZNMU8IdEmqnmdQgmO0F0EoKJBaPDQ7b297Ch42TQV2hKF8AB7Wti2P0OSn8o3+HtOgIYZi+1KsR/gAk+H+j0MPJeH/cILlgb+dHJ7eIWgykKLlPVRETJXslsHQJenPjUklEwMDh4xV4Zo2BwIA/hrt2UTG1nvn5MR4c0cImLox+eS4NuCYW60P+9paD1U4IJV94t5zGi+ytqsBNUgJ7wsMMrYO59b16vCCkFDci3rcoH8qR63sP9R2SkSKh3MMfLi6fQAOG73mCswJlbGJX0lSr6Qx6IxcAyQUmITJUBdKUJI+RUwO8/6x+oji3XhI1aL7RF8UGz2sHieSGvHcUAsN3cckxfGM9pRi3QTPMBM+eq52S9tiemB3HFXDJAtOv1oNls7Y7wd72ig075zTdxTeRXNpjiIOP+nabng0+LojTh98uh99n8vvmblSGrZXDo/ltIzG3zU1A1HhJLfVbyJXreBCJmICCyaMv1XzI1dBTQUzz5j3zGcqoPMtniHCWPKv+TGHKcRh9IJBOMXeMWqBYxMT7XKl+sPkVV72kebownHaYe4FAWpQY2xZ+ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVgzRmpXWml2OE1FaVQ4OHEzUzlnbzl5SThpcDFPR0Z4b0hMOUhnWWkyRE9o?=
 =?utf-8?B?c3ptdVNlN241NDdraE5XbjREMkxyTnZkZVN4bnNBV1ZYQU5LMzBTNmsrbExs?=
 =?utf-8?B?VFd1SHlVQ2ZaNW9kRU1yQ1gwVldESnNPQmU5Tk1qRlduNmxJK2FBbVNFbnVP?=
 =?utf-8?B?dFpxNTM3bGRiMWQ1dDhIL2FPOWdqRyswSmZRaUY4aEZYYmkwRkRQRzhDZE1a?=
 =?utf-8?B?Vy9qcVBPUVAya2VxUGV1RXNqd1NDck9tTDAzRlBvRUtmSGRjdzI1RXZiSnJt?=
 =?utf-8?B?d1RETWV1UllUd2dYVDdHZXR6cFI5Y0xuOHY0bWEzRUluTE96dkFPaG9uVkc0?=
 =?utf-8?B?SHhJY1hiejd5U0RxU0ZYS1A2UWtuTk1FWG5zeW0zdkNySGlQam5RTVhSZVdJ?=
 =?utf-8?B?LzQ1UGRneS9aYUlKUGQxeGhpak5xNDdNcVVJc25sSHZHUVFEalZWcW8zVUU1?=
 =?utf-8?B?RVNJdXFzV05BcWg4Zy92ZEJGby9SbjVEMHMxRDhtSHZhN1B2UWgxYk1pWWoy?=
 =?utf-8?B?dlBVL3pKN01BMEZJcERBU2RqYm1SYVZ3MFNzMmpOL29kSHZsNzZPK1RKcHZY?=
 =?utf-8?B?b3dVRnpIZGxEazhLd3psYTZ4WFdBRjBhY3lCSVN4QjMydjdzL1dhbEZiT3VJ?=
 =?utf-8?B?M1lZeXNZNVRyUjRkMHk0bnRxKzk1aTFVUzZrTmtXOCt4a3ZUVy92ZkpYbXZV?=
 =?utf-8?B?dTd4WjZvMkZ4MkpIUEhuYnFhL1V4Z2F3d2x1STBUWFB2emVyRzkwWjllcldv?=
 =?utf-8?B?NjRRWnNYb2E5L1RFSVh1cVRSbU9lMFBXVXRlaHdKTWhHdWZrcDlsaWU0REo4?=
 =?utf-8?B?NXJLTTZ6ZkQrT0tXckIwc2FrOU9ZOG1xbThvb2VrMDVpZThWZ0ZTT2R1bDE3?=
 =?utf-8?B?aWZCZVpaUjhMY1U1WjJiRGgvK3pPL20wSVBHbzRzQnJpSEc0cUFLdXhBU2tD?=
 =?utf-8?B?RngrRDJLdjZFSUdjTHduSmZVT21udWJnSk83anJNMzFQL09malVrOGFQNzdK?=
 =?utf-8?B?NmFYWUlGdnZJTCtxSFg5L3VQVko0UGQ2b1NCS3AyTDZqOHoyeUtBNUs4bCtQ?=
 =?utf-8?B?ZzJVNHVjc2txRThJNi9vZCt3TzI3L0JNMWdCbXFJVE01aUVNS2tMMDU4MXN0?=
 =?utf-8?B?bVlxNS9ST1hiRFdMTHArVnBJQnJnK3ZXZ2gyYXlkbFJjTVJNaTZLbTlOTHgr?=
 =?utf-8?B?cEc3K0xKd0VlLzIwMUdNcVd4ZytnYU9hMHpwcThDS2xPamhaVVpTVTIyNzgx?=
 =?utf-8?B?YmIxSlZJdEF0OWN5SkN1YzkreWlpaXBLQVB2RWlhblJYcVdCRi9vMzU5a0tZ?=
 =?utf-8?B?b2JMRkk4WkRSOVBTQkIwUXlUdWpBRmFzdTYyWlRUUVYxczNrZ09IQlZQVVpV?=
 =?utf-8?B?a2lTZHRCZ0RtRGpEQ1gxQzl1ZGs2em12MU1uem14V3IxL3kyTllQTWVKalFU?=
 =?utf-8?B?T1ZoczNvcmZkcHhnNWFicnFTbGNMMHFTb3FqVjRIRmFNQzJhYTdiNUlPQjBk?=
 =?utf-8?B?YkJzTXN6QUlsQ2lCZjdJNW1nZHRnOU9pTXBva2ZmU3pFZi9LcnJTQzBNVGpo?=
 =?utf-8?B?YzgwaGFXNlM2MlgxVlFTaDJtb25hMFdLYnpDaDB6d05jTjEzR1ZiclBqL3lh?=
 =?utf-8?B?U3dwS3QrZG0zMEo4eW1FN1prSVhMbzQ2bHFXbkpVRlUyTkZTUDdDQXBWTWh4?=
 =?utf-8?B?MHFNc2IzVE13cnV0U2h3OWNySjdXZlNKcGxLeWw5OVB6NjNLT05lTGE1aDRx?=
 =?utf-8?B?SnprWnBGYXZJeTNubXlMRVlzSk9YUkFweUYwVjhwNTFCNFJNSjBRVUpPdXZK?=
 =?utf-8?B?ajBHZHZwaEJHdEJuOEtwQzBUUjVWU1RDZHlzUEtxMkVYY1JQcWdsUGM2RkdW?=
 =?utf-8?B?M2dGSXR1RVVPTDhxZXFXaWQwTWNJc0s3bnZ2YWZJUlBqQ0p3R203K0tCZmRq?=
 =?utf-8?B?WlA1aDNyMVAvWlRlZlFjSmFrNnhTSzBlVmFLQVhwMVdGRTErd2R6R0QwNEty?=
 =?utf-8?B?L3VVbzNETkRVNktWU2NkNHd2dnBnQ2xna0FxQ2dPZ2pTVXFRTllURk9NQWpS?=
 =?utf-8?B?aGJOenl1R0tNODlrVStoSmV4cWxhVklZNmF3UXN0YWZGRkdYeXBNSXZzdDlN?=
 =?utf-8?B?KzVTUWw2TVFYaXh1UmZkRmdXUGFMaURaMFkwVzlRdytCd3crU3MwOGpHaEov?=
 =?utf-8?B?M25lVFRtNjVVV2xyd2FJdk5XbEVxQmJkS2tlTVM5b3dxbHEyeGt1c09iK0dP?=
 =?utf-8?B?UXNHY3RVS0NSMU94K2Q0eHRYeDUrOHZiWjlDN2xKN2ljbWc5OFhucXVoTGQ5?=
 =?utf-8?B?bFVDa0l5QmQwKzJIU1hsZE10bUZqUHVIczl4MVdJWDFZVXJXOFQrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afdff78c-6d6c-40c8-eb42-08dee86e994a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 03:58:05.2032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EzihZJ+PNm+2pqxVbbwEJZV+UgFDvIuM0q/5965mA63W/vx9c8i5skVl6HuLGiyoe0RHj7GYqIvhHFvfncDsUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8193
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

Hi Nicolas,

Sorry for the very late reply.

I recently discovered that I missed this review comment when promoting the series upstream. That was my mistake, and I apologize for overlooking your feedback.

I have since reviewed the comment with the original author. After revisiting the implementation, we do not plan to make further changes to this patch.

Regarding the concern you raised about:

  link.dpcd_caps.dongle_type =
        (typeof(link.dpcd_caps.dongle_type))0x7f;

in "[PATCH 21/32] drm/amd/display: Add KUnit tests for amdgpu_dm_connector",

if you'd still like to discuss that issue, could you please follow up in the corresponding patch thread? It would be easier to keep the discussion attached to the relevant patch and context.

Apologies again for missing your review comment, and thank you for taking the time to review the series.

Regards,
Chenyu

On 7/21/2026 10:09 AM, Chen, Chen-Yu wrote:
> AMD General
> 
> Hi @Zuo, Jerry,
> 
> This is my mistake. I missed a review comment from when promoting the series, and the patches were applied before the feedback was addressed.
> 
> Could you please review the comment below and determine whether a follow-up patch is required?
> 
> Apologies for the oversight.
> 
> Regards,
> Chenyu
> 
> -----Original Message-----
> From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> Sent: Wednesday, June 10, 2026 10:44 PM
> To: amd-gfx@lists.freedesktop.org; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
> Subject: Re: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance Automation
> 
> On Wednesday, 10 June 2026 11:45:00 Central European Summer Time Chenyu Chen wrote:
>> From: Fangzhi Zuo <Jerry.Zuo@amd.com>
>>
>> Add support to get DUT trained at FRL link rate when working with
>> Teledyne M41h compliance automation.
>>
>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> ---
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
>>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |  5 ++
>>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 67
>> ++++++++++++++++++-  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |
>> 6 ++
>>  4 files changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index 2940dd5b7348..ba1e11e144f2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -877,6 +877,9 @@ struct amdgpu_dm_connector {
>>       unsigned int hdmi_hpd_debounce_delay_ms;
>>       struct delayed_work hdmi_hpd_debounce_work;
>>       struct dc_sink *hdmi_prev_sink;
>> +
>> +     /* HDMI compliance automation */
>> +     bool hdmi_comp_auto;
>>  };
>>
>>  static inline void amdgpu_dm_set_mst_status(uint8_t *status, diff
>> --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> index 6ef257622f1a..59091ee32099 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>> @@ -573,6 +573,11 @@ void amdgpu_dm_update_connector_after_detect(
>>               amdgpu_dm_update_freesync_caps(connector, aconnector->drm_edid, true);
>>               amdgpu_dm_update_connector_ext_caps(aconnector);
>>               dm_set_panel_type(aconnector);
>> +
>> +             if (aconnector->hdmi_comp_auto) {
>> +                     if (sink->sink_signal != SIGNAL_TYPE_HDMI_FRL)
>> +                             sink->sink_signal = SIGNAL_TYPE_HDMI_FRL;
>> +             }
>>       } else {
>>               hdmi_cec_unset_edid(aconnector);
>>               drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> index 096a855a7304..95a56e39f452 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
>> @@ -2982,6 +2982,64 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
>>       return size;
>>  }
>>
>> +/**
>> + * hdmi_automation_enable - Enable/Disable HDMI automation feature
>> + * @f: file structure.
>> + * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
>> + * @size: size of buffer from userpsace.
>> + * @pos: unused.
>> + *
>> + * Return size on success, error code on failure  */ static ssize_t
>> +hdmi_automation_enable(struct file *f, const char __user *buf,
>> +     size_t size, loff_t *pos)
>> +{
>> +     struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
>> +     char *wr_buf = NULL;
>> +     const uint32_t wr_buf_size = 40;
>> +     int max_param_num = 1;
>> +     uint8_t param_nums = 0;
>> +     long param[2];
>> +     bool hdmi_comp_auto;
>> +
>> +     if (size == 0)
>> +             return -EINVAL;
>> +
>> +     wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
>> +     if (!wr_buf)
>> +             return -ENOSPC;
>> +
>> +     if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
>> +                                        (long *)param, buf,
>> +                                        max_param_num,
>> +                                        &param_nums)) {
>> +             kfree(wr_buf);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (param_nums <= 0) {
>> +             kfree(wr_buf);
>> +             DRM_DEBUG_DRIVER("user data not be read\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     switch (param[0]) {
>> +     case 0:
>> +             hdmi_comp_auto = false;
>> +             break;
>> +     case 1:
>> +     default:
>> +             hdmi_comp_auto = true;
>> +             break;
>> +     }
>> +
>> +     /* Persist setting across sink re-detection/hotplug. */
>> +     aconnector->hdmi_comp_auto = hdmi_comp_auto;
>> +
>> +     kfree(wr_buf);
>> +     return size;
>> +}
>> +
>>  DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>>  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
>> @@ -3099,6 +3157,12 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
>>       .llseek = default_llseek
>>  };
>>
>> +static const struct file_operations hdmi_automation_debugfs_fops = {
>> +     .owner = THIS_MODULE,
>> +     .write = hdmi_automation_enable,
>> +     .llseek = default_llseek
>> +};
>> +
> 
> I really don't understand why this can't just be a DEFINE_DEBUGFS_ATTRIBUTE, and then you can replace the overcomplicated hdmi_automation_enable() with just simple setter and getter functions that already receive the parameter of the right type.
> 
>>  static const struct {
>>       char *name;
>>       const struct file_operations *fops;
>> @@ -3131,7 +3195,8 @@ static const struct {
>>       const struct file_operations *fops;
>>  } hdmi_debugfs_entries[] = {
>>               {"hdcp_sink_capability", &hdcp_sink_capability_fops},
>> -             {"hdmi_cec_state", &hdmi_cec_state_fops}
>> +             {"hdmi_cec_state", &hdmi_cec_state_fops},
>> +             {"hdmi_automation", &hdmi_automation_debugfs_fops}
>>  };
>>
>>  /*
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> index a2d0bb34e639..6350212b9a66 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
>> @@ -193,6 +193,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
>>                                       __func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
>>                                       edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
>>                                       edid_caps->frl_dsc_max_frl_rate,
>> edid_caps->frl_dsc_total_chunk_kbytes);
>> +             if (aconnector->hdmi_comp_auto) {
>> +                     edid_caps->panel_patch.hdmi_comp_auto = true;
>> +                     link->ctx->dc->debug.force_frl_max = true;
>> +                     link->ctx->dc->debug.force_frl_dsc = true;
>> +                     drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] hdmi_comp_auto --> enabled\n", __func__, connector->name);
>> +             }
>>       }
>>
>>       apply_edid_quirks(link, edid_buf, edid_caps);
>>
> 
> 
> 
> 

