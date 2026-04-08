Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88481073CAB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D04D10E63C;
	Wed,  8 Apr 2026 13:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QHoYGmTg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C47F10E63C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLHksgfS90t0Dm4UDA/ra9AR28OUL5ZSScj+a2X43I43izpg4+8mvguHSqp3jLq8Kz3cejSMT/0vwxVcbtN6IPuecZQTzT07FG74uwstnpG0oHyYducf4wkM36f4SEmJnXukmbkD/iRLv3vI8J4/cwA7E59NQEH0MHNxXtPobhli9VeyHbireMYHvq76lioKb3gRWqWd1Lm5UbGeqjTwwywOKsS5jLM3HS1xCKDOE8RDjczyGVqhl1jxY+lpWaQjVGk0n+S8wqIXT6SicN38jekiyDPxg3WIAFcNgw3A6RvrUmvAygGzjP7CRYojQes1QA9xmo00tZ615kEw0puPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+pTlsvEWzpJ63xs6rdmGXSv4TB4n1FPFMZLPZFn6Wo=;
 b=WU+FXu5n4xrYReIsl+XCNZMELzbxCQqQa3C65mcmi1Y/xC/dpkmU7ayjhWVR6ZmTEIXefMbfmlyt2M/z9YZDJy036+kSrMgP84NiDewHrv5mCRw0z+ZACBxVel6VmEp9fWhd4Vd0eDdGjqwzjrouCL1p4fNZfmjJXu2BogYQRm5iDfaU+Ng8C1r993dF1BCywSXyBiMScahBm01d2OUSMrnUiERSJLgzmptcccl2ywsljwBs030UGggGhLYkaOpZwHFAI9YoVHW9qC4wFwnT1H8Vu9mzX6hdU6xeayYmqSpAWZIVpQvbIEH5hdF4eG2Q2P6FlP8E5OR3Q3Rf/VRcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+pTlsvEWzpJ63xs6rdmGXSv4TB4n1FPFMZLPZFn6Wo=;
 b=QHoYGmTgqot6CKbRuAmefhaWkuHUgJYAArfcEV62jgdKxqhC3ynmaP5306UuZs7fCzF4gdvLb4aYznAzn5vGVosa+Z8AZ2Js4PIyqDGtZLED9VuTfXm9/u7FWQHo4n2j3culjXqKt8CVrEMf8DHuZGEz/5J9MomeFQthK5APsXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 8 Apr
 2026 13:17:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 13:17:20 +0000
Message-ID: <f2a2a113-c321-4a83-91ec-cb4ef4205e4b@amd.com>
Date: Wed, 8 Apr 2026 15:17:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amdgpu/vcn4.0.5: Remove unused define
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: "David (Ming Qiang) Wu" <David.Wu3@amd.com>,
 Ruijing Dong <ruijing.dong@amd.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
 <20260408125426.2118644-2-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408125426.2118644-2-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: e71174b8-aaea-4c84-d30a-08de95712a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: D8g26xTP2R5uDbOv15ka5WsMk5Lkyho2AH/Ys4ANi8mx+BVCM8IMJ6x4Ms/2lQf5HihLtQJp0XQckq0lEZDNxDofbwg7KJFjHaPKQPLtN80dbDFdWeWG1NP1ZMMv1zo0LehhXW6eZzeERgHb9flmaROb9BSHck+fHpJDgiYGLFgph5uSZ8weSnb4A/m5wROjF7DzW1h9VD5wB4eLTG0UNcK0WDI5/eU5dIieh0TD1l9l2IhBfjQ1nlYaGe1Uwlar5HXp6zH6boldVPmcFiqEXLO3m+W1CezmPHlnzYAxQbW+iNGemLedUIk/8FtthY4H/C1hYUbe67nI1iZzAFMJEqBuqCW/rdptkHv5yvJADB8wDASuEbY2fBZX70GhLFrFrEbFpU4D/zVBwisjJvpVWD/5UeHbUHT+mjKmg3Q0GX1nKFDHTsIGcu50xidnbHhogpb3uwbJAlGQ0RjtObUi/11fE/OKvFiCTxOGvikUigdkyXRjtEBoovDSoLlzStSbWiFSsN2hoBsYhreqAyNcG0nhStIEfpL3itnUiVKpUNwl6Nfn3EpTDESv4/o1Juejrg749k7b7vmwcdTdPEV+UQOHa2+IUZ+tO9m7lSeIeY/44bUDav7Ihd7sK5pFvgyjzc5N5zI/XbdOLTGn3fiP5FnGWU8dANUOLsTXh64IZT/fagvRvJH+guHi0NqrRCoSnbgIRn2Elqij0byAoPGn8/xa5tnefcR0vn5+CpM020g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dQaWh5eDBYVVJ4SkpIenVGaUkyamwzc2UrMTJXZjdlUE9YY1lYcnVESUlO?=
 =?utf-8?B?dSt0OG92aVhyNys4Z2ExUS9tanI3MGJJSlVLRGg0RWVYTzFrVXloZDkxLzRh?=
 =?utf-8?B?VWFrTlZhb1Jkb2dwOU9xcm9neTVKaHYraTFKRktZWC9YYTJQT2JROUZnQm9M?=
 =?utf-8?B?UEtuSzYrdlhIaTJWY2E2ZFJkMlJkQ1RaZ09yRzMyWVRvTUJNcXNZc21oaHNj?=
 =?utf-8?B?ZTBTWFBGc0p2emVFTTRWRFNLb0hzVnVCQ29uaG15SFhwMDR3cnl4UEpKUWVh?=
 =?utf-8?B?SjdwQjFLTFJLQUk1RDdjV3ZXdUdseHExQ0hzU3NnaVpORWkwR0pqQURUOVZC?=
 =?utf-8?B?ejFBcVpZRitNWVk1OVBGYjdobUhpZkN0aHV2NGlPNUYxajBjN2QwWWx6VFBk?=
 =?utf-8?B?UTVoRFJTOFR5elBDZGNyS1UwWnFMQXFMQmNJbFdyN0NJUUEwcFVMd3BIOUp0?=
 =?utf-8?B?MVk2QmUvcDF5U1lhdWcyRnVQV2ZuV2hocnBpUERJbll1VFJheUJKSHRLM2pP?=
 =?utf-8?B?KzZhbHBscHZkaDVac1dQMmR5anNCSyt0VGpJZW1vam8yV1BibFNHYjdGYTdB?=
 =?utf-8?B?YnVnWVcrMGFISzRYY1Zld2pneG9ySm8rYlBHUUsvejdWNGpweVRvcjZkVjhM?=
 =?utf-8?B?ck8wSU5wMVZrRWE1OHFWNkdtb291TUY5dzBKT3pydUQ2YXVpdnFMR294OFpP?=
 =?utf-8?B?RE5ua3Y0RU5KNFlQaEN2WGdYdEZzd2RvMUphc2tlMlF5WWhQTXN1eUp0R3Fz?=
 =?utf-8?B?MTNDOXVac2MvOEl1T1Z6K2FiaWV3VnZKZFpZckFYS3ZFWERNemNBY1BUY2ds?=
 =?utf-8?B?Y3JVY1ZaZlVMOFBtWWdVcnV1b3FEekdMRE9oWjNSRnNKQVJIZEhDYXRRQ3dP?=
 =?utf-8?B?Ri9EMXFhTWs0MXh6UUN2aCtzOTMwREpXNVpIWUVsS1BXZ3h4OEd0M2w4NnJj?=
 =?utf-8?B?L09jNlJYNXZROGdhQS9lQ1VXOEozZUdSSVpidGJlUHl2bkE3SHlEcWZvTm1U?=
 =?utf-8?B?azB3cnZQMGp3dFZUYWZPd3NxQjRjMmh3Rjk4c1cvOUpQbDQzRFMrcWRRN1pv?=
 =?utf-8?B?UVhCdWFIVHdYQUdtNGp5SjV1T29FQTEwMDNNMTUzRnJGOHlqL1BaZmdFUzg1?=
 =?utf-8?B?Wk1OdHUwZ1h2NEh2OHlJckFJYkVpMnNCTHRxcWIrcFp1N3dLdnoxRlk2dUh6?=
 =?utf-8?B?c0dhSjFYdVBrTWE1VHVvZ2V5NHhuWDRxaW4rSXQyZkNIMTRIOURTd2x2bTVB?=
 =?utf-8?B?K2xwOUE3OGdCSXlOYk53UHFTdkhseEZrNWJyUHBPUEJhRGdZZXp5T2dHd21u?=
 =?utf-8?B?T0xLR0Rtd3N1NW9ZQndOcWgzOThLMGgvWmcrSkljem5ZNkRiZnBVcXBjcS8y?=
 =?utf-8?B?YjFMRjloamhKQklXb3h0YXpIR1JiTHc2NDJ6MEpDQVJ5Y1QrY1pBVnlBNDhl?=
 =?utf-8?B?Wkk5bTczSDJ4VFNjWFRLdDA3YWFMeGlWVE51djVsNm4xR1FhMER2L3pSNDM1?=
 =?utf-8?B?d0pRRVdFMUVGaGlNUHQ2bkhHeUJzZWJnRHZ4dTg2dTE1bTlJREp3T0xQTXNH?=
 =?utf-8?B?RjluSHFHMWY1MzdkVkZQVU0yY1BiZnVJejNUajdDb3ZqWk5yMVN4YktjdWpt?=
 =?utf-8?B?dy91UVRTOCt4aEpLa3RzdHB0VjNEV0txeERDd2gzNDB0RjVkUmFrSWRadWMv?=
 =?utf-8?B?blZPTkZzZWJCTmRLbWNCeThtZDU3am9rMXJaY0djeUpoWW05VTBEOEduNWYw?=
 =?utf-8?B?RnZKQjlOZzdnbHl1SHpaUTAvKzNmTXd2YWw5TXI0SWcxdDVSUFE4em9iT0Mw?=
 =?utf-8?B?R20rbjl2aDA3cmYzZisrMFcwdzhpakpyOHVISzVCNlIyWVVWVTlzVnp2VHFS?=
 =?utf-8?B?ekxoRjgwR3RYQk9JdHVhcnBid2lva1h6MEovaTNzd3BiU3F6YVZSMk1FUm5N?=
 =?utf-8?B?THdOZTVBcGVpd0lBV2FsZU5NU3ZuNy9ZRzN3bnIxeHc5MElsNDZUS3g2WEdB?=
 =?utf-8?B?eW1XYUV5MjY2WStMazlTVkxaRml3UmZoNDEyUGJvaDRlYlVvZ21hY1lmQXdm?=
 =?utf-8?B?VGxmODA4VThMZUxkZlNGK3MwZmhiQWRxUDlNL2QyVkdNUXJoNkRuYyt2TUZR?=
 =?utf-8?B?T1NYT29kR3pVazNzU0piWkhySDh0WUJGL210RkM4UW1qU3A5YVB6R0NlQ212?=
 =?utf-8?B?MERyVHF0U1hLQVI4c2xQY3RvanpTSWxRb0dvYnhRbWhjNDZNZWZJekZ2NjdI?=
 =?utf-8?B?Y2xBQXc5bitjMFMwTWd5VTZ6cjZ4aTcxc0hPMXppWjUyK1NmYXlzWFh6WFUy?=
 =?utf-8?Q?xZCE27jQfavbqMZO/W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71174b8-aaea-4c84-d30a-08de95712a30
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:17:20.7451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oo2XZk6rOiDFjrQVAr6sCmZxzXcJJhJEXGIw1FceHhaScDPx3xigoQi1ylLsQdKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6803
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

On 4/8/26 14:54, Benjamin Cheng wrote:
> As part of the previous cleanup, this was noticed to never be used.
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index cbbc02d68695..a204a0f5c44d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -48,8 +48,6 @@
>  #define VCN1_VID_SOC_ADDRESS_3_0					(0x48300 + 0x38000)
>  #define VCN1_AON_SOC_ADDRESS_3_0					(0x48000 + 0x38000)
>  
> -#define VCN_HARVEST_MMSCH							0
> -
>  static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_5[] = {
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
>  	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),

