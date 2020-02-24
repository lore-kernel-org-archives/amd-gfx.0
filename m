Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360CC35671
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6132072D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 11:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RJ/uN8hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6132072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB4626E43F;
	Mon, 24 Feb 2020 11:49:08 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750071.outbound.protection.outlook.com [40.107.75.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCD26E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 11:49:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4Myg0PBny2Qrj96fqsZeWOI0HLpJR4ZR0vXyrgm1QBnp8MmuBHjXeOyW8Bmtys4FY89yAae6YzOoAPBxY1sP4BZM6qVmwu2VR/5ZlvoaIgXhbDBb42c8U4nDIbVBPUEnLZ08Y+ZO17ixnotGVFBXwm0A4sDiSs38bU8ukxgc8KSPzNM31M09PRYccNboGTA8Yi/qjzJdf1FNtVpAiQJpjXNjqp9Kq4DHKYswwPOiSnERLpYpRPEbV11oef8Vu5v3H96x3U1OG+4t3Dlg+5XG4F708j8HpT1csOfTe+tbOq/0qWih3CoJoXbLFvm/9qbsiLdrFv5W67h3vwN6pdnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWXva0LYsoERQXKlMHr9zXf46zvSQRXMvAm84DKYj08=;
 b=KerfVOe1RjDWJRwDDhwVrYQWmXzfXImFcHQCNHkhFnnfANpEXieyCvfQ+kdEpxwS+4tROdg2p8+1+ekTNmFMe1pnYykRMtFVNsZsXaCYklMzJUSgTY8ZFxhvBujlC60KgZ3nox02caiQI89KL+rsbjogGWYrgIOtw4qz29FIr/jlzaqdS0C8Y41UE2xSOWAYhXoooScCREjN8HQ68E6xfSglZwJnexm9G7DnopYh7+fBZX5NfPVFT5aeBnSZZxthyLsJQNSKBJyCpGsub64vBBNRQ97wQouk6wYrYFjczaBQ6gc+LItSQnHO92goDzcpIU5jQuOC+UXQDvEqYIp/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWXva0LYsoERQXKlMHr9zXf46zvSQRXMvAm84DKYj08=;
 b=RJ/uN8hS9oxpWAj4dPMY1iHOlLc9wNWdsbUeej43h8fPsNwnWEqwMKdMukXuZNBwscbeIh0ltEFZwL/Dq0ts8+u/qzvR4w3Xk2aqnWrKHwEipEOBG7BXH3CbhB19xCgcasLfgFxnBDeUeGTKprcxJeglxGCaNmiUWwinCVVlyiY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (2603:10b6:208:168::31)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 11:49:06 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:49:06 +0000
Subject: Re: [PATCH 2/2] add DST_SEL=8 field name for WRITE_DATA packet
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200224105953.29906-1-xiaojie.yuan@amd.com>
 <20200224105953.29906-2-xiaojie.yuan@amd.com>
From: Tom St Denis <tom.stdenis@amd.com>
Message-ID: <c9f6f25b-ca3b-a363-b2c0-64dd784fcc66@amd.com>
Date: Mon, 24 Feb 2020 06:48:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200224105953.29906-2-xiaojie.yuan@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::39) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (64.231.93.139) by
 YQBPR01CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 11:49:06 +0000
X-Originating-IP: [64.231.93.139]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aaffcc23-7b68-4fc6-765f-08d7b91f8d69
X-MS-TrafficTypeDiagnostic: MN2PR12MB3871:|MN2PR12MB3871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3871A8305D1561E6F26203F5F7EC0@MN2PR12MB3871.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(16526019)(186003)(956004)(2616005)(26005)(8936002)(66476007)(66556008)(6506007)(66946007)(6512007)(6666004)(81166006)(81156014)(8676002)(52116002)(31686004)(6486002)(316002)(36756003)(5660300002)(53546011)(31696002)(86362001)(2906002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3871;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/91LaYBMteM2G1skUOz0Q6BvWJQPlKn2gLw3LaoQepv4J5Mf39L8ZgckCOWSF+Ta6ueDZR4vhx9qmjN0/Bu9wWILQ613tdKqkoVKKV94lBlIjajT+QwLt6zwx7nwxwdFhvXgb/ogCxMlRIpeZ/LZTL0cbcDJna1cb7UL+SmDYWYeJMpMlnvq9hmNW1g1EmnfELq4uWjzPYc1C6KpLRD72z/yh3ylqiC2OtHisBiZ5fDOzTqbthxz9nNZw939qamrF5hLV03+3aHNWAViDON0kf70FPgmTPLi44ro2JQBhERLHxNdAGvr5ZXf1ZdBCiE5Le5dS01nTWvX4p5ut5C3oaRjyyOHmxI6Ev6Xo7Sqcu20mdmhkiAIWCkjPZom2h+6WBZ3GJS9KU+n7n6U86RZvh3O7NS5ysiKC9ksZWdUgIfDRF7DEluAkK2ymzNUFUq
X-MS-Exchange-AntiSpam-MessageData: FPbZdHAw+WdjnY9wsAaWMe0w6YizxR1UtoIJxvKTYFfEnhzNkpORG0/C3+44K46P+s/yfYmM7co19S7ohNBuX9wLWd/xs6XI6SjxkJkMvJhKNtajoLgnS6NrFgEW1fy/k4dyaeY83nEHjri2vFg6Yg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaffcc23-7b68-4fc6-765f-08d7b91f8d69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 11:49:06.6536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rrKaBgC9tK441aO6elB8g/ep0aLzKePxmaKVoQZ6+FZsVhd1mcPk86pvcFwra5g74KIPS9zjd7/f/t8VoSBXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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

Thanks, both pushed out to the master branch.

Cheers,

Tom

On 2020-02-24 5:59 a.m., Xiaojie Yuan wrote:
> otherwise we'll out-of-bound when accessing op_37_dst_sel[8]
>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
> ---
>   src/lib/ring_decode.c            | 2 +-
>   src/lib/umr_pm4_decode_opcodes.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
> index c5582f5..f26cf0d 100644
> --- a/src/lib/ring_decode.c
> +++ b/src/lib/ring_decode.c
> @@ -465,7 +465,7 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
>   {
>   	static const char *op_3c_functions[] = { "true", "<", "<=", "==", "!=", ">=", ">", "reserved" };
>   	static const char *op_37_engines[] = { "ME", "PFP", "CE", "DE" };
> -	static const char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved" };
> +	static const char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved", "preemption meta memory" };
>   	static const char *op_40_mem_sel[] = { "mem-mapped reg", "memory" "tc_l2", "gds", "perfcounters", "immediate data", "atomic return data", "gds_atomic_return_data_0", "gds_atomic_return_data1", "gpu_clock_count", "system_clock_count" };
>   	static const char *op_84_cntr_sel[] = { "invalid", "ce", "cs", "ce and cs" };
>   	static const char *op_7a_index_str[] = { "default", "prim_type", "index_type", "num_instance", "multi_vgt_param", "reserved", "reserved", "reserved" };
> diff --git a/src/lib/umr_pm4_decode_opcodes.c b/src/lib/umr_pm4_decode_opcodes.c
> index a823ecf..c4ad5ce 100644
> --- a/src/lib/umr_pm4_decode_opcodes.c
> +++ b/src/lib/umr_pm4_decode_opcodes.c
> @@ -351,7 +351,7 @@ static void decode_pkt3(struct umr_asic *asic, struct umr_pm4_stream_decode_ui *
>   {
>   	static char *op_3c_functions[] = { "true", "<", "<=", "==", "!=", ">=", ">", "reserved" };
>   	static char *op_37_engines[] = { "ME", "PFP", "CE", "DE" };
> -	static char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved" };
> +	static char *op_37_dst_sel[] = { "mem-mapped reg", "memory sync", "TC/L2", "GDS", "reserved", "memory async", "reserved", "reserved", "preemption meta memory" };
>   	static char *op_40_mem_sel[] = { "mem-mapped reg", "memory" "tc_l2", "gds", "perfcounters", "immediate data", "atomic return data", "gds_atomic_return_data_0", "gds_atomic_return_data1", "gpu_clock_count", "system_clock_count" };
>   	static char *op_84_cntr_sel[] = { "invalid", "ce", "cs", "ce and cs" };
>   	static char *op_7a_index_str[] = { "default", "prim_type", "index_type", "num_instance", "multi_vgt_param", "reserved", "reserved", "reserved" };
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
