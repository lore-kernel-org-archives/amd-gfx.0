Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4F0C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF216113D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 13:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF216113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00096E86B;
	Wed, 14 Apr 2021 13:58:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5692F6E86B
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 13:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLpqkZmDFdwI0e5X8c5ogH15Rj/XHumb58Te0reLufKxHJ1lZiWf4oUNZlbSGxXhRwf1zS3WED4k1H2wXWh8cYqPo3nT83gApAtCGkAcv5kSOBkombP8GaIGS2sF+fRVKXy8DsO9UUY7/n89RM7FJ+oa1t1xjXtKDClJaTWkMk9DsuZH3SJpC88YDcbjoqvW6ciKdZyl1sO87Yq+mndyd7yPaA6Uvkk5dmMtLsTBhVdp8d++vykJn3NOgYQBts/ivDgw4m9C5j7uyxQU4eq9UZcH+13qKEXcBz+Ct8ToMHSRxuO70UrNw0xmQUbP4RRMWnuSQE7ei9kD5toEeSQoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MA1bU/G/RaU/NezHykezcZ3W0f7Yc1qTljYz7sBgI=;
 b=QObH0zKUA06oL4Nm+t3D8rxpsndqiOgxo4FWXuc2IfivL+sAZz3ZGxaPZyOQ230IJsHWjN4sVIy8dHl6xo/z0TdBrZT/qf6ODJ9oqbe/vvDDd7l3ADWEjLL1yT8sK6GoDyTEO2tBRqP9MHp8OBqy55T9aNrr79UUqCbv76s4rqBV9GusZJy2sVB/a75Np8R1gIWY+EbV34mCg85Vkwq6YBE4dpyU8+94boNq41nFhSaFfvsZhh1Gb/brFGO6tAq1di9NJh/c9ateFG/QmLldQ5VH4/DF9mnERP4A7D6YK99DRamOvYlVAjeFK9/5egX2hUl2snOKQNBvq10Miz+eYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7MA1bU/G/RaU/NezHykezcZ3W0f7Yc1qTljYz7sBgI=;
 b=A9bB6RMvb9FAESA7/0M05lJv928Djf7jecuBIJxyokdVJt1ByvEiib301z1bwFO430ALyRT5r+gADslwoAAhBv4xCzphCxRbFKAB8D5hjdnLjb2jbPT/xyrX3vtDLYigggAzhKBOJZa2P9zo3iTS+VgRe/ua6rDUdpDkpxXIfsI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1354.namprd12.prod.outlook.com (2603:10b6:3:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 13:58:12 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 13:58:12 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix checking return result of retire page
To: "Clements, John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210412011508.35024-1-luben.tuikov@amd.com>
 <CY4PR1201MB007214EEE4658567FC2B1C18FB4E9@CY4PR1201MB0072.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <291d8e06-5d32-f3ce-2949-1125879bf1e8@amd.com>
Date: Wed, 14 Apr 2021 09:58:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
In-Reply-To: <CY4PR1201MB007214EEE4658567FC2B1C18FB4E9@CY4PR1201MB0072.namprd12.prod.outlook.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 13:58:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0be789fc-54c6-4357-bff3-08d8ff4d57d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135472AC58DBAFA1E6D62859994E9@DM5PR12MB1354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: veMTylyFyibGlWS1RsNIOmknlJiwmMg3FA6Bb9XvkM0ro5Wf9OCWBb+NQSKTjRg5KBXb+yz+XRWj3LqNstfGhN1hABoq7V7Ahgg2xfNzz7mGGAe4zvvECEj07GIHqgPnJLC1JkM05ITWv1F2m8tqn/fDcEh6RGazTV5tPiusmUHjcczV/lfjpZasFvnhYj1pfQi4J7lcSmMqWESHqOcO1/YQUMLg8vuGuRAFelCfFrTz5IJgvhgp8Ev8P0k3YLt3/HJl29WjPm1E6hs4YrO5Y58HIcC7+gQkCN/XGgCl8CiTx/lN+gIPBqRHmg/uIXyb5VCeTBZFevEB/biEcMi0dgu7gLHqZI1LPsIn/yip63LD68QCwGoN7WM4940jlCO7Vk9NNKQpG4hMIaMvbHsN56ysPZ9J+REwouHYjjBxBvD+ost0793UQWLAWoAA9lw5odEZW+dIxynjY4IcdTRvemO5JfrpyXvs1NmKbfSpWu7SY8CcIFCKfZiQQ3WICjL3VBPjL7Gm89zwazdncwVHeGpjOrAIvkHfA4eVCMkws2mI5X53fS1/yOPFMR7ytIeFiZXw2y+9yEG9DWkKqPEs/8fkqopkRe79M7zg1PUrQRrveD8bkghSZgzmqqAA++NKLAANtEeWKXmjLqK04IepGSdOl2eXPrDPV0bxtbi9BnO5MH/CT6nZSa1xdIXTKH1S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(55236004)(16526019)(6486002)(31696002)(316002)(53546011)(478600001)(110136005)(54906003)(6506007)(2906002)(4326008)(26005)(5660300002)(31686004)(44832011)(36756003)(38100700002)(6512007)(8936002)(186003)(66946007)(86362001)(2616005)(66556008)(956004)(8676002)(83380400001)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d08yRHRFTVVNaFlQZTBoOHVUc3lTMGpMZFVkVllvMXhuNWdPRnp4Y2RVTmNF?=
 =?utf-8?B?SkdqR2I0NGJqdnp4Q0wrMjE3YXRxZDZaZC9xY3FZd0NDcHpMRUd1cks0dGVi?=
 =?utf-8?B?azg3UEkwTlJEeElWNWo4a2tsRVIxY3FFV1lJdnpDTys2aUVXYU9xK3VzSFJZ?=
 =?utf-8?B?eExpeC9aeGJlNVFtWmFBMGIrYmU4QTJaZ3E2aXd2SFNybjE0MTZkR1BUS3li?=
 =?utf-8?B?RW9USDNManY5RkdnMWwwU25RUk5sdXBOTjMzb3dPUEk1NzhMUUsxci9oTkVL?=
 =?utf-8?B?T2VsdTZSbW4wWmF2RUZhUmdvVGN5QXRDM0dhdmRnWFNKUU14ZFZFU0JnN0t3?=
 =?utf-8?B?SXBwbHZzcXRJRTJQSWVqejhlQkxEa0MxTXgra0I0Q2xyVFZZS24zdXQrSjU5?=
 =?utf-8?B?SVM2VnZ3WkYwRmxZOFNLcVhzZFZYOGpTMUtIZHZvd3haRklPZGU5N1RaTmpY?=
 =?utf-8?B?dFEwaWpJNktEOXNpakJLcUVZdzdaRTNTa2g5bVhmK2xWd21sUU5NTWVlbXRQ?=
 =?utf-8?B?L2ZUYmNlTVVBZlFkand3b0tOUWVwdENZRG5yTVFRa3dSWkxabWFWSXFrQjFG?=
 =?utf-8?B?Zzl4QUZ4b1RwSlZjZ2tiUzVtTXFwRFhPK1BLOG9GR3FWUlRtZUxVYkJvM0ti?=
 =?utf-8?B?SFRnUW0yUVlQT09DZmZXN2lzSzFQTHNpOURZSStkM0tJOC85Q3p0TVlXYm5j?=
 =?utf-8?B?dEoydm52SUM4T2RtZUZyTEUwN25qR1NLbnN5MXBKVmE1VnMzeWIvOTFlMTNM?=
 =?utf-8?B?Sm5NYzRZL3g0WEoydm40ZExTN0EwdVVuSmlWcEI5d1hhL2JTcTlmT2s2ZDF5?=
 =?utf-8?B?b24yclUxUWtqdDRwOXFOenJIczc0UVJFTUVmTVAvVmF3OWwvUXl2QmZtMFdS?=
 =?utf-8?B?QStZc0Y1VnNreXdPSndLQ1ZZUGQ0SVo1d0tGTTVhS01OTDg5L05uS3ZzV2Zw?=
 =?utf-8?B?ckR5QUF2U3IyS2EvMGxpNXhteERLUytGb2xNTWtpQUhmS1hxTktMSnU3My9Y?=
 =?utf-8?B?MVF3YXlPQ0V2dnJ3NWMvdSsvM01zd1h0ZWxRVWhaT2JTVEhVR0FqMkFId2hn?=
 =?utf-8?B?dkZHWDlWTkJlYmxob2xZdDArU0tMVjhYSkg3N0VMZy8zSGNpaWR2ZVRtZ083?=
 =?utf-8?B?NDl6YjhiTHVoenFsMmRkeUNaSzJlTmoxR1NpcEIzYUYzRlh1R3Z3YnhEQUhn?=
 =?utf-8?B?WU1nVnZnditOeWVzTU1ad0dIWjlEWmsyZ1FzeXVLNVZDWVR3OTFJQjdQNG1W?=
 =?utf-8?B?aENDR0JySkhvRHhDUk1DeEJQRDA3MDV5cXBFaEduYzZCaGNMZ2xIWHR4Wi8y?=
 =?utf-8?B?RlNxU3RXdlFsdU1CODMzMFUrcEFRQ0dZZUYxOVNyM1AzcDc5Q29DZHhXR0Zs?=
 =?utf-8?B?S1RLS3ZtZGZGNjFRQmc3QVhreW9IM2YzeGpTOVR3cjVKZkdyS1l5Q2xJN1h0?=
 =?utf-8?B?WnhrUzk5MVM5eUpKM243QmdSMzYvcE9YWDJKV2pkRk5DRnR0am1VeVZwdnRO?=
 =?utf-8?B?aHBwdnkrNUY2MW12ckZXQzhPMytGWEFCNkgvY05BZkJwZFpSQXU2dWE2WEhO?=
 =?utf-8?B?ME9YTlNhblFkWFZDQTZuRzlKUi9HcStUL2RLakJ1NmVFYk1lTDgxZ3hFTDQx?=
 =?utf-8?B?NUtSOGk2QmxWdmpuQzl0cStWWHRZTGxBSU5OWU5GN0gvdGY4VDI1QWFhYkZR?=
 =?utf-8?B?TWhBMkp4ZWxvRkRxK2grNHIxdjg4OGxndHlsdi9YQ00wS05UR29vREpCeXA1?=
 =?utf-8?Q?oIu6vOZHVtS7w7kukLUIf0oaSr/NuADOM7qPdPz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be789fc-54c6-4357-bff3-08d8ff4d57d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 13:58:12.5437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77nHqZD3UeAX3neFSayX8bG7mztxl+bzuLa+haVEmtZvVJ/mxNagkSKvafV8EknC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1354
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I'll take a look.

For the time being, you don't need parenthesis around != conditional as && has lower
priority, i.e. the parenthesis are superfluous.

Regards,
Luben

On 2021-04-14 4:19 a.m., Clements, John wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Thank you Luben for re-organizing this source file and fixing those bugs.
> 
> Please add back support for decimal input parameter values, maybe something like this:
> +			if (sscanf(str, "%*s 0x%llx", &address) != 1) &&  (sscanf(str, "%*s %llu", &address) != 1))
> +				return -EINVAL; 
> 
> My concern is that there are tools out there that use that interface, so I wouldn't want any side effects there.
> 
> Reviewed-by: John Clements <John.Clements@amd.com>
> 
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com> 
> Sent: Monday, April 12, 2021 9:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix checking return result of retire page
> 
> * Remove double-sscanf to scan for %llu and
>   0x%llx, as that is not going to work--the %llu
>   will consume the "0" in "0x" of your input,
>   and a hex value can never be consumed. And just
>   entering a hex number without leading 0x will
>   either be scanned as a string and not match,
>   or the leading decimal portion is scanned
>   which is not correct. Thus remove the first
>   %llu scan and leave only the %llx scan,
>   removing the leading 0x since %llx can scan
>   either.
> 
> * Fix logic the check of the result of
>   amdgpu_reserve_page_direct()--it is 0
>   on success, and non-zero on error.
> 
> * Add bad_page_cnt_threshold to debugfs for
>   reporting purposes only--it usually matches the
>   size of EEPROM but may be different depending on
>   module option. Small other improvements.
> 
> * Improve kernel-doc for the sysfs interface.
> 
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 67 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0541196ae1ed..c4b94b444b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
>  
>  	if (amdgpu_ras_check_bad_page(adev, address)) {
>  		dev_warn(adev->dev,
> -			 "RAS WARN: 0x%llx has been marked as bad page!\n",
> +			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
>  			 address);
>  		return 0;
>  	}
> @@ -228,11 +228,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  		return -EINVAL;
>  
>  	if (op != -1) {
> -
>  		if (op == 3) {
> -			if (sscanf(str, "%*s %llu", &address) != 1)
> -				if (sscanf(str, "%*s 0x%llx", &address) != 1)
> -					return -EINVAL;
> +			if (sscanf(str, "%*s %llx", &address) != 1)
> +				return -EINVAL;
>  
>  			data->op = op;
>  			data->inject.address = address;
> @@ -255,11 +253,9 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  		data->op = op;
>  
>  		if (op == 2) {
> -			if (sscanf(str, "%*s %*s %*s %u %llu %llu",
> -						&sub_block, &address, &value) != 3)
> -				if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
> -							&sub_block, &address, &value) != 3)
> -					return -EINVAL;
> +			if (sscanf(str, "%*s %*s %*s %x %llx %llx",
> +				   &sub_block, &address, &value) != 3)
> +				return -EINVAL;
>  			data->head.sub_block_index = sub_block;
>  			data->inject.address = address;
>  			data->inject.value = value;
> @@ -278,7 +274,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>  /**
>   * DOC: AMDGPU RAS debugfs control interface
>   *
> - * It accepts struct ras_debug_if who has two members.
> + * The control interface accepts struct ras_debug_if which has two members.
>   *
>   * First member: ras_debug_if::head or ras_debug_if::inject.
>   *
> @@ -303,32 +299,33 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>   *
>   * How to use the interface?
>   *
> - * Programs
> + * Program
>   *
>   * Copy the struct ras_debug_if in your codes and initialize it.
>   * Write the struct to the control node.
>   *
> - * Shells
> + * Shell
>   *
>   * .. code-block:: bash
>   *
> - *	echo op block [error [sub_block address value]] > .../ras/ras_ctrl
> + *	echo "disable <block>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
> + *	echo "enable  <block> <error>" > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
> + *	echo "inject  <block> <error> <sub-block> <address> <value> > /sys/kernel/debug/dri/<N>/ras/ras_ctrl
>   *
> - * Parameters:
> + * Where N, is the card which you want to affect.
>   *
> - * op: disable, enable, inject
> - *	disable: only block is needed
> - *	enable: block and error are needed
> - *	inject: error, address, value are needed
> - * block: umc, sdma, gfx, .........
> + * "disable" requires only the block.
> + * "enable" requires the block and error type.
> + * "inject" requires the block, error type, address, and value.
> + * The block is one of: umc, sdma, gfx, etc.
>   *	see ras_block_string[] for details
> - * error: ue, ce
> - *	ue: multi_uncorrectable
> - *	ce: single_correctable
> - * sub_block:
> - *	sub block index, pass 0 if there is no sub block
> + * The error type is one of: ue, ce, where,
> + *	ue is multi-uncorrectable
> + *	ce is single-correctable
> + * The sub-block is a the sub-block index, pass 0 if there is no sub-block.
> + * The address and value are hexadecimal numbers, leading 0x is optional.
>   *
> - * here are some examples for bash commands:
> + * For instance,
>   *
>   * .. code-block:: bash
>   *
> @@ -336,17 +333,17 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
>   *	echo inject umc ce 0 0 0 > /sys/kernel/debug/dri/0/ras/ras_ctrl
>   *	echo disable umc > /sys/kernel/debug/dri/0/ras/ras_ctrl
>   *
> - * How to check the result?
> + * How to check the result of the operation?
>   *
> - * For disable/enable, please check ras features at
> + * To check disable/enable, see "ras" features at,
>   * /sys/class/drm/card[0/1/2...]/device/ras/features
>   *
> - * For inject, please check corresponding err count at
> - * /sys/class/drm/card[0/1/2...]/device/ras/[gfx/sdma/...]_err_count
> + * To check inject, see the corresponding error count at,
> + * /sys/class/drm/card[0/1/2...]/device/ras/[gfx|sdma|umc|...]_err_count
>   *
>   * .. note::
>   *	Operations are only allowed on blocks which are supported.
> - *	Please check ras mask at /sys/module/amdgpu/parameters/ras_mask
> + *	Check the "ras" mask at /sys/module/amdgpu/parameters/ras_mask
>   *	to see which blocks support RAS on a particular asic.
>   *
>   */
> @@ -367,11 +364,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
>  	if (ret)
>  		return -EINVAL;
>  
> -	if (data.op == 3)
> -	{
> +	if (data.op == 3) {
>  		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
> -
> -		if (ret)
> +		if (!ret)
>  			return size;
>  		else
>  			return ret;
> @@ -1269,6 +1264,8 @@ static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *
>  			    &amdgpu_ras_debugfs_ctrl_ops);
>  	debugfs_create_file("ras_eeprom_reset", S_IWUGO | S_IRUGO, dir, adev,
>  			    &amdgpu_ras_debugfs_eeprom_ops);
> +	debugfs_create_u32("bad_page_cnt_threshold", S_IRUGO, dir,
> +			   &con->bad_page_cnt_threshold);
>  
>  	/*
>  	 * After one uncorrectable error happens, usually GPU recovery will
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
