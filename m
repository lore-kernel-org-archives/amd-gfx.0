Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B77C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 11:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41ED6613AC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 11:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41ED6613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C5E6F400;
	Thu, 20 May 2021 11:19:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F22E6F3F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 11:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLiyDQiLtGOKiY710VPjrRF2dPETwlotIZeSq7A8+LOTVNgJeJ17c0okAQyHbmh4K2Q5PZVs1oVkdg6nmqEGNWZ7D6dEw/eAD+E9jf6yvrulxgwW3xdND2ng8DgN/CrxbOIFH9B2mCsxsrx/+YSIZbkquWFPHZdUgf9gNTnbJZw4wFMqZaLzI58wqjVx7ys1jI4tUCDfknb/OGHpL9ULpZY9GEOZINVpa5EHt+cqQCuQo2ZUPDO2y8ZRFviIeqL++5NG3CZ9M3KxLfWUN7R5kQtPjNBHdvpLWFfn7uT+gHmKwSOJVSpxt9Tf3SNrPsNrTDcWRrceAk4L2hYPZXvKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB/uIdc/gPkS5pOiB7JTcrTdEy7K6KuRz658hobQGmA=;
 b=oB2u26P5cbdrX01A0BXZXOUoIyg/0ORiYOreOX3tjUHoljf2hskIToXvlGaZX47O2f2KVN6D9IiGghA8Okg85Mpj1f8fS34fDAEGCOYF2tJhfP+0sUkMgxNbb0OUynfGexD52MhT+DXkooYQO1u5+Q/iPSdjnlhcMxN/ht3RkuOC5U41bn/0G2+fd7c+ZF2HGrzLWkVMxPSCQ6H4Y2OjlLNSEQH4WbHWSIJjz17uICSqgqA/ayY4C61r2Iq7RAjs3uSETuogUoTPbUavBhk6xSRovjYNL25M9mUYj/4dAiw/o9OS7OGdvf2FaJOIwC0oaxJtTxGiGLdFfHgLUwevAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB/uIdc/gPkS5pOiB7JTcrTdEy7K6KuRz658hobQGmA=;
 b=MhluDkRnBoP44+pv3N97UItsdRpgYmdxBKo5HMzp7BJewt5Gi2QiyFbaiiuOxpCDP7RFPUsH18v0mUu/s31oap8TFBv65HsVHDV+BZN2e8yCjOP05Br1Z0cT7Bke4Y9UUoqkgSlbYdp/kE/Tz1DtlJSHkXgm9m4IaLzq7njUBtE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5251.namprd12.prod.outlook.com (2603:10b6:610:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 11:19:51 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 11:19:51 +0000
Subject: Re: [PATCH] drm/amd/pm: fix return value in aldebaran_set_mp1_state()
To: Feifei Xu <Feifei.Xu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210520095038.3684183-1-Feifei.Xu@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <376ccac0-1bad-717b-312a-14a7cfd1bb89@amd.com>
Date: Thu, 20 May 2021 16:49:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210520095038.3684183-1-Feifei.Xu@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 11:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6644743b-359a-439f-58b0-08d91b812f93
X-MS-TrafficTypeDiagnostic: CH0PR12MB5251:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB52516325659E0337EA609230972A9@CH0PR12MB5251.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+cxxOkR2VeijH06n/l5z/UZ08JLgUCKHCm1WQhWp6bDHLyS2DVTbwgEMVDcGCqYK5NTNmJeS4vGFmvhS47Pga9lqCDB8p5ckEcJDv/+WqRAmIn1FVqf4+NYRb7c7lB7HvYu7LoSqx9LB0m12aPqE9Qcy8JkYYR8z6WjqHcJO3z6bYMmO2HdNu4OuRTD/XyQwOSOsEn1k7CAlNZAcngSvFvnVTjrSlr1/lfFf5Fronv7VIGI7VDmTxt3UoB7TTvxojStjGA4tDGV66Yk60KXNPd0ttKCbn5ZH+grXi0xuNuf+aTS3XfPjWjbIpMN/oQ2m3dp3qxc2uydLb5JT+mF28SqspqQEDz4vg+xtD1zYJy2lxq9R3mEnbV5sK+9EOidZgQDafvofYOAqTK58y73CpfMkh7qZBZLP6GYyGA5CjVwjZXXHPsDbcZ+Pf8Fn/T3nZOMbQvupStbT2RLGYkm1lroJ94RH4Is1Owp54Umd9utqxYonNynjBzHw3RE0ZUJzkrhm33KsPf4wpaSoE3WnQUzhu8qXjplquz065reeapy5v+Fva6xuF734r8AnxnhI2Anz/XPeWyOtX8oKc3seXwopLJEq2EDe76hq1H26m0G/l94d97igU68ASpI4FlbRnTg7ElF9Pihi0UWVv/lSOrA1CwagzK2mIojxa9rs9qIrrN9cM3hpffHx2hmRs/6+hQ5NIfdlawmHlHmSQyrgK1ZUkzJvogG6e5LJeCCdao=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36756003)(31696002)(86362001)(66556008)(66476007)(83380400001)(6486002)(5660300002)(66946007)(31686004)(53546011)(956004)(2616005)(16526019)(186003)(478600001)(8676002)(16576012)(8936002)(44832011)(2906002)(6666004)(316002)(26005)(38100700002)(38350700002)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?akJkcjREa2NLcTdlR0huSlVWeXdWWlE1YkN0SHR2eTN4dktkOGl2WGlGQmM3?=
 =?utf-8?B?bStJcGR2clFURVJCYTdTT3RGenEzYkR6dGVVbnN5U1VsN0wrR1U5ZWFzSjRq?=
 =?utf-8?B?MnBET3Z0c1RuZG1vQ1YxOUQyM0ZpK2c4SXQ3S2pVdmdXa3BNbFJkYWhnOEpO?=
 =?utf-8?B?SStuRXdkdkZ3Um05WGFGbm1tYnN4eFhpMk5vZytkNHhrcmw2aUJTa1hLT1Ax?=
 =?utf-8?B?S2dLMDlxd0hvYlRTVjNadkVuTXRPbVFEODlEY3R6cHZNVkFEZXd1dmIxRGJl?=
 =?utf-8?B?YzcxYWpTT3AzZkVCYmc5ck1mdWdwcUNqb0Z4UGg4OUtDSXR0aGErM0djWU9w?=
 =?utf-8?B?WXA2akRuLzZxaXFuUHRTR2p0ZXp0M281NXF5YndmMmY2SVpKakZRSFdWZzJH?=
 =?utf-8?B?RnM3dWtTa3JNZEVESkRYRGNRVXVlN0d2UUpFbjA1djBLN2JhUGZaNmJzaW9V?=
 =?utf-8?B?ZWVuYnNMd3N3aDJuOFdTdVpBVHVRbDEyOUJkSjA2Mi93TlhUZSt5VnloYUp0?=
 =?utf-8?B?bEs0OHFtWDBCeW5pRUlyYmxrZHcrbEp3QlpSSlRFL2xWUXpEaGdxNm5PNDhB?=
 =?utf-8?B?bVFidTFSRk55TmJqRFdqM1JrNTJWTjJVNWwxQXlYUUJNdlppT2FTSk14ZWpU?=
 =?utf-8?B?Vm9CcjRpMFA1TzF2YlR6VWZvMElLNjhIdzZ6MnVwYjNRREJvbUJndmJOeHZE?=
 =?utf-8?B?Unp0M2YzNmlQb1htOVFmTDUwTXpvbUxHZExWZmFjdkRqT1JjZWE2VUtnZlRD?=
 =?utf-8?B?eGlKUk9sM1plYWFKN1hMQ1VLellseFZrYXBKVCsyL3VjcVJEbG04S2NoVTJG?=
 =?utf-8?B?SXM5WFNBRjBqZU9zb25KUTQ5dXRCbFgxQjhqS1UwbHFrR3A2dnp4ZzV3MHRM?=
 =?utf-8?B?b0RPTThVVUhRTTYzYnYxNUw3TjdUL2NjMlB2eDM5dWVlRTZqL1BCc1dtUll6?=
 =?utf-8?B?VVVkRkEvT0Zjd0ZQamxrRkUwV09rc2hFTlBLZXVMNitvVlZCSWIrZk56cXR2?=
 =?utf-8?B?ZFdBU0xCR0JZQU1HeitpV2hTdk5Fb3NZR3hHV0tPYnhoNHJTdVNvTVZPTklx?=
 =?utf-8?B?WktoanRUWGRIQnU4b2dZSU1aNml2MjFvOGZqQURVa1hqT1NNZTZ1RkNMRG9o?=
 =?utf-8?B?K01mdnBGK2swazF0eWV1MmttdDlvYXUwQ0dOY1AzWEN2R0lQcFRYeUQrYnNp?=
 =?utf-8?B?RkhBeGVyNVNLeUZHM2ZxdkZQTVkrNVN2cU5LOE4rTzM1MU1FSGxwUzFCY2ky?=
 =?utf-8?B?RFgyV09CM1JDeFRGbHloZ2Jxdk9sbDBVNmpWRzdCT24zQjFwcmdIL0ZxT1lW?=
 =?utf-8?B?ZDBZYnUrRG5kekxaa1dyNW52NnpXMm5nOTVwbDJMbFNsY3RhZlJ4aFdTWGMv?=
 =?utf-8?B?Z09tYUIxc1lwbkY5VzlFRldQR1FHb3ZGRWxFaUlkL2ljT25kNWR3aHBDTW5K?=
 =?utf-8?B?M1dZV2xVcnIyKzBQMms3aUsrZC94TloxSmNVaXhLdVFhb2dNOFd3ZlZ3d2F6?=
 =?utf-8?B?NE9rQUozcDdGQmVxaEdodlAxQm5rRXZsMmU1TkE5T05INXJpZk9IZXlwQ1VO?=
 =?utf-8?B?ejFFOFJ0MXlnOTFlVzVWbGpCcGlaTHdJbFBJbjNSdkppdGZGYzRUYnJUbVRJ?=
 =?utf-8?B?TnlXWTVLeHlaRTBQM0s2U1BGbmN2bjNlT0Zrd1huUzFPcFVDakpsVGo2ZXky?=
 =?utf-8?B?V0lMb01pNjJlR0U5c3VCNVpkTE10SzJMT1JUblFKQlA5WGhYMjllMy8xVy9Z?=
 =?utf-8?Q?AemRBW+Q2rji3atyxbjca1AfZRGqKQejSAxB5/Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6644743b-359a-439f-58b0-08d91b812f93
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 11:19:51.4364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alALTjYdH0YuJshi91x3oAi1Bq+dwqWALuIGhEui/fCFnCzMwINk5Do9sLaTZIsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5251
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This now handles all of the states. Those states are not valid (and 
therefore not handled) for Aldebaran. If the intent is to skip handling 
of any other state, may be just return 0 for default or skip default 
altogether so that it falls through to return 0 for any other state.

In any case,

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 5/20/2021 3:20 PM, Feifei Xu wrote:
> We should just return error in invalid case. For valid but not
> implemented one, do nothing and return 0. Otherwise resume will
> abort because of the wrong return value.
> 
> Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 5d04a1dfdfd8..5fcfd8e1a548 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1781,13 +1781,15 @@ static int aldebaran_set_mp1_state(struct smu_context *smu,
>   				   enum pp_mp1_state mp1_state)
>   {
>   	switch (mp1_state) {
> +	case PP_MP1_STATE_NONE:
> +	case PP_MP1_STATE_RESET:
> +	case PP_MP1_STATE_SHUTDOWN:
> +		return 0;
>   	case PP_MP1_STATE_UNLOAD:
>   		return smu_cmn_set_mp1_state(smu, mp1_state);
>   	default:
>   		return -EINVAL;
>   	}
> -
> -	return 0;
>   }
>   
>   static const struct pptable_funcs aldebaran_ppt_funcs = {
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
