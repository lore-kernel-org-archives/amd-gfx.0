Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC78C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6154810E1DA;
	Fri, 10 Dec 2021 16:07:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98FA10E1DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:07:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f17wbHdxegZfQ9tqMtuX/jtlRkGXjlIxe/pMbGoixINiQzAzltiIybRHAZSWcCgr0WoOtjngHs4BTgdjUKyZIAOgwSd6zXNk80nFoAn1XgeJEQoaVDBwg3ZIs/XCQH/bn4QssVTU1X+29puYjIDdLU2wnPF6GA49sL520VouYXn/ilOp5WmR1NgNy0MXjTjocWauSQLtnliVxDrL8E8ONLJ/925J3ZO0UC4xid8v+p7dZxbyi7AFrGwbIgdbb8zkcVqv+A1CSzuJzWwpioyxQDiENCyOwmad7u1gwHW7kfc5du+NOvUvSC1Vd47JjDaA+hzfC1G7OCuLqVbfrQHCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arAhb8KKU/7Px/lbbDo14SaG/yUKHwGEQ08OlxpQgik=;
 b=DJtHN3aDZc7N/tAfoq/0wQAn6NMvsL7FPMuyi8AXmQOT9r3ITFQNDLC1vDYrTqfIXuS7K3cpP4eSxE8h/ysdNc53mqTyVQQvlz5qkxpxa9szItvVhtV+DSvv7BIWFTkP4Uvhfvn6SptKB8NO3jiptVAyRoulSZZRpnDLsKHXr/uupzETl0QgsaDzmB5dRgBHYieGAoRikB8029YRv6uNfHDF8GX+YUamSoSvkNt5SXUz20/ULzauv6g+9HF09WnE2dlHf4mLFfhXYspYZ76VOn2+nmBAh37UiD28bPq7IPDcVFJFJ1U4Q/LP+18+e6ZX2iVBrmoEpuIOa3niDBu2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arAhb8KKU/7Px/lbbDo14SaG/yUKHwGEQ08OlxpQgik=;
 b=Ab+SQgu2BVUaYr1NzUgcqdVnqwI5A8TFyuquW1UuvKaPt0sx9IXmP79kbosG9snmGzuYK46PKWzZ+sOgtsVOfvYGH7JQcOTSXpVV1P284NvK9OuIegMaQ/dymJ0H6mlclsfIMM9qdmbekh/oW7MMrnNY3OTMelSyMlTpe/HWiGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR1201MB0080.namprd12.prod.outlook.com
 (2603:10b6:301:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 16:07:24 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.027; Fri, 10 Dec
 2021 16:07:23 +0000
Subject: Re: [PATCH 2/2] drm/amd: move variable to local scope
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211210155415.11867-1-mario.limonciello@amd.com>
 <20211210155415.11867-2-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <05231ce9-0c8d-509c-f5dc-27a972739501@amd.com>
Date: Fri, 10 Dec 2021 17:07:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210155415.11867-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS9PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::35) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:9f71:eea0:f459:9080]
 (2a02:908:1252:fb60:9f71:eea0:f459:9080) by
 AS9PR06CA0108.eurprd06.prod.outlook.com (2603:10a6:20b:465::35) with
 Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 16:07:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dab1a9b-4ed6-49ce-38cf-08d9bbf726ea
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0080:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00803342F7903EFD66DECD2B83719@MWHPR1201MB0080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD/JL65/8wmmsd1ylSu0lfbyfyYOXBhaTUbnsPTBz1fix1hwAnpXRPNka5uOjlFs9Vn/Zmv42BI5ADWEYKSAd61Poq/shdmaXTFIXGT85UijomvTlX4SV9d0inv2U+qJiGbKz/kStuDrt2H0aOL8dNBxbqSdkhb6EU7BNgI70dZ1HiBxy/PJdwjzrABaZmUUYZBo2+TWaYb3lGxhKKZSOlISYNoZhY84J/MvUmMQM0WDAO08sRFnNvyTJ/vAVtC8nPxeoanVsN4k48LzLexxEJfUddbOwRcHjoT6GbBpBR/87MLHj3jBVx7Fz3oPoCITsN4DEq0C1SMWhm+uYRimha1Sf2QKrVSqdhY9DhXgK5J3YgYCgTPyhUSEaGP0AE5sJt3LoPzNftAdifbIGJ83PUFW31GB885PVpw7M7pRQrSna2tL1jAA+y0g7zl+cm3rm9lCn3pdObC8ZlJ+HCfrCNfQvHWPOUeh7VIf6hMAfvpRMYVbbGXmOJ1pK3368okDl/UCGAQRynjaT5toLGoSQhpU8TzfKA7MluZWL3JO14tLEVDIO5Yj0IiDFT2pDHsIbA54PWdNvgkpFg/ND1tgoA27FK/ihOAlkgL8MceE4WzXRcCEoEMO8r1Rp4wostel/jLCsRtAPY17qdnPTdsQjDhHJEVHQN7rySb6R3M3ZDkXKsV1r1GCnbOX9twXFrUs3LEpT8JQlzZpzaiELgwVSTEWQGmReL389OeDaOKMfXQqEJLqZbcr28xstAb7/lBU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(186003)(508600001)(8676002)(31696002)(36756003)(316002)(83380400001)(6666004)(2616005)(31686004)(5660300002)(2906002)(6486002)(86362001)(66476007)(66556008)(66946007)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hCZW5WeGFLZ1J0SHJScldnbFBxdmtseDN6QlJuZXYyYUpiUVphRDNkV2s2?=
 =?utf-8?B?TjU1TVhXL3owWU9oeWNvMHZuanNwMmJzMlRzdDd6YWFpVnBLVlU3bGJnMFVW?=
 =?utf-8?B?clY2em5sY29IdDZEOUc4czhCMDFoSk5CbGFXaUhZREhURUlwbDA4bC9YWGhD?=
 =?utf-8?B?NUVhZnRhdk9kMFFQYytpSXhhVDg4Ky9GVnNoTzcxZnFFMVZoSE9tY25tREYz?=
 =?utf-8?B?UndaL0tjRmFvSmxFNk1CWlVmaG1hOVgxRjNJSm9xWDF6alplR2NTNEJLY2VT?=
 =?utf-8?B?VUJ6anErOTBjS25JejFkZkJnY0E0U2pBZjlMdWRSNEpHNUFuU3N1c2d2SC80?=
 =?utf-8?B?T2xMSXMwVElQdVFwNHRDekN0YVRwbG9HbUVKQ1ZzRFN1MEpxMi9aTGYxLy9t?=
 =?utf-8?B?WWlNV1NpcWVBRnVNK1JsSXlReEpBTGUydlhJWGR2WXpDSlc0NjRIK1Y3Ky80?=
 =?utf-8?B?eUoza0ZUS2FWaGhWYTJxRER2OVkzSTc2ZmlqSDQwbXIwdkhBVzFUdHgxdmpJ?=
 =?utf-8?B?MmZMM1p5M3hIRnJoOStLZXhFN0I5RFZ4MXRicEpJcW9mMnNGdlVDdEZxcVow?=
 =?utf-8?B?bnNsWXFiV29VRWp2RzBseUtJSi9sMnVJMlErY0VZUWRTdThmTVIrVlVUNVFQ?=
 =?utf-8?B?Y2JJZG9iQytsTFdCL0RFTVNKaExFQ3NvSDRaOExCMmxaWDJ3ZWpoNFA0cjEz?=
 =?utf-8?B?bEl3RkJFMGQwS0dNV3Bzc2hVNTNzTEhBZXE1WmhGd2V2TEJzbzNsYnZNUmdR?=
 =?utf-8?B?d3BHVWk5Ni8zSGwzdThCamsvUVVSRnZDSlJFSGQxQ3lDeVZRS2k0cDA0WVFI?=
 =?utf-8?B?Si9IVUJ2R1NnWlBvY0FaYXV1Y251YzZERXlHSldXblhNTm0yNkNFY2REZGF4?=
 =?utf-8?B?V0hNSzc1MkdPeWt1MVBJLytoL1NRNS9Vc2w2N0dTOXk4QkNiY2EydkVMeWxG?=
 =?utf-8?B?Q0JmZEhXeTdoSVg1eXR5Wng3cmZINmVkSm5BMm5YOTNzT2pEOHBRUE50QndU?=
 =?utf-8?B?TXpmVnV4R2lBZUVDRDl6ZEhMTWVHYzBDR3lEck5oT092UmdEcXhYOXp4RXNY?=
 =?utf-8?B?SmgyUnNEVTVMdGVBanp2TFVnMkIxWnpJd2VzTTd5UG1BVVlTTnBmOGlXTjY1?=
 =?utf-8?B?dVBRN1VtNU5DRENhSnBBL2NtSkttWWdld1pTZldudnVvZTVWai9jeUs2Q3g0?=
 =?utf-8?B?QVZ6Wm5iQnJGcWl5Z3RKUTNLMFVhNHJ4TnpEUlFzNUFHbkRnY3NVMjNBRWIx?=
 =?utf-8?B?QjBZNUVaZ2FGV2Y4TDlBWVhoWUVUQ2d3VnQrdnZUa2ovOFVMb0RHYW1QRFo5?=
 =?utf-8?B?cS8vMlVQQzlEV2svWmU2R2xBTExLRGRCQ1Z0RmVjWi94WFp3cVFMM2xTTzRm?=
 =?utf-8?B?a1BzSk1YVzAwMGlpdXpwTVgrV1R1ay96dUM3aWZrbWc2bTZaL0hlaVhiQ1VH?=
 =?utf-8?B?WkJjNTRmejlZVDZlVVVia0c1c2lBMjB2a3RMYjJLMTByRGN1QmkrWDR0Qkx0?=
 =?utf-8?B?ZWliV3dvWE9sM0N4NDFKOFJVNnRmL0xIQkRhRWEzUCt5TTJIbEVuTXUwdE42?=
 =?utf-8?B?b2IzYUdSNlV4anpsZUxyNXh2cUpWVEl4QzBrMEdLenBDemdEMGRhaWozc1d1?=
 =?utf-8?B?WlJVc2szNHMvTGJwZCtqQm1oK3ZhRFdvRkVNNkJLK3pxODhxa1NSQzFXWnVD?=
 =?utf-8?B?cko1eHJLQjdSdHJOZEptdE5QTE9IZFFwQXQyOEdOSmxJelpSeXpLU3J3WFZQ?=
 =?utf-8?B?M1prdVplN2w2L01MSnU2VENFZEpBeE5GZytRamd6OTNMUkR1emlvdUJaZFlO?=
 =?utf-8?B?R1JKNGNsWTNCWDJTNHN0YkowSS9QMXBUeGlVYzJTOEFvdUNsMllOZWJiUzVl?=
 =?utf-8?B?NU45bGRXSUh2UG01NHAwRHJSK2hZZE0yN2FCTjUxMU1rOWF1NE1WR2Rrbk5Q?=
 =?utf-8?B?WmdtQ1Q5b2pka3hlMTIwcklSR3BndzFTRm1acThRL3F5QUlmaklXMVlxUklL?=
 =?utf-8?B?MkQ5YXMzdmNpUVdGOUVxZGtDZHJoak13a0FIY2M0UnlxQlBHbHNCbjZ6UHlu?=
 =?utf-8?B?QzJJZVhGd0dmVFlMMHVDTW5SNmVuL3pzWjJZY3FTNUZsZ0UxUmxtK3RGS1lU?=
 =?utf-8?B?Y3ZZSW9wclFaWVNzNHNRRFBZNjQyVlhvTGk2YXlSemgxNlhMdkxqaWFvdGhG?=
 =?utf-8?Q?EEAT/1+wyV4SVYH06CW+N7M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dab1a9b-4ed6-49ce-38cf-08d9bbf726ea
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:07:23.7464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSwMkY5oMU4H/cGpDmujuUEc5I+fc0s1X4ExQ+CxI0rwTP+6BwnkPeuFOGhpiQ/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0080
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



Am 10.12.21 um 16:54 schrieb Mario Limonciello:
> `edp_stream` is only used when backend is enabled on eDP, don't
> declare the variable outside that scope.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 0d6dc329dddb..fb578b311b98 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1798,7 +1798,6 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>   	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
>   	struct dc_link *edp_link_with_sink = NULL;
>   	struct dc_link *edp_link = NULL;
> -	struct dc_stream_state *edp_stream = NULL;
>   	struct dce_hwseq *hws = dc->hwseq;
>   	int edp_with_sink_num;
>   	int edp_num;
> @@ -1830,7 +1829,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>   			if (edp_link->link_enc->funcs->is_dig_enabled &&
>   			    edp_link->link_enc->funcs->is_dig_enabled(edp_link->link_enc) &&
>   			    edp_link->link_status.link_active) {
> -				edp_stream = edp_streams[0];
> +				struct dc_stream_state *edp_stream = edp_streams[0];
>   				can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);

While you are at it, there should always be an empty line between 
declaration and code.

Running your patches through checkpatch.pl helps spotting such stuff.

Christian.

>   				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
>   				if (can_apply_edp_fast_boot)

