Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6210C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 16:26:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F57EBDE0;
	Tue,  7 Dec 2021 16:26:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0844EBDE2
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 16:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJbMFDY4OiED5SjivaRFYGYKBnFIxvofIs/gndQGY/5iUG1Wf88Ty9sMskrpNNQ+lhLvdsqylN97AZ0oLQA/seuJYv0oszdM8yCBmjsyHXg01fN7TSG8xYBCHa54rGkSNjm83lDZz7bGL4KCUWO8Aid3DfM2cFZ9hpd0HvzNHEp0ORpDD/qsLbBRBPRR0NX1/uzhWuyV0nGSiRqzFWn10tL8NBALflH2VKHZXHHzBNMGCaauqxSOGJCdql3+DbZMdIzKYUYzzLqS8CfkPojEvGQLHLIcBXGWxJZFf/EIjhw6p3CTSILjsZF0dMxPW5B9zsv0OGMOnOwTi0ZABMnUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYy1EFiPBNEWRC+RAqbWpFkyNQ8ZAZhKD0V238VvsHM=;
 b=ma2LCa5qNG7GeTW5F6BaSB2uW1+FLsho1wQHPjPQuXOHC7zA/NzNV9MAvneCaF+S54vffww7ZIv76P9P1WOY0fceGsmDP54/wpRWjoYodvfvnjeg7mNBVaTLaT6siM9K4CVh1a92b8kt29uByMP5U1c3CmOSaFHvquXXkmUpv5MJMxh8njcSEMZXVQn+L45Ml6luTfIsXpyi0JBS5ywVrRVQFFB1IIaOtWu0xJtAyGuxvBzEuX73vhFX2HPm/iJalORhc3KL40Vj6aH+KnplQjegIbbJpKZlTO2VUccGH/BRd7oKDoRRXCc8cFOS69ZgNlzz9uH0SpGPnWlr9ak9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYy1EFiPBNEWRC+RAqbWpFkyNQ8ZAZhKD0V238VvsHM=;
 b=jrWOwCdEovxZXnD2J1LviGFkFo5CX5A74KmZR1yy8T6KzM6XLo4WOEHqo660p6ewFPvp0PWe5OnxExvRj0LuTDhASRWXYuOdU7zK0e5iYgzGJGvJE2tLbtGP2Bh6fUZSMEB65Sn0kMAZUxSEku9c+7rjRonEpEOj5nbSPh3eJJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 16:26:37 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e492:c86b:9906:1b46%6]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 16:26:37 +0000
Message-ID: <4806221a-aff4-54c2-94fb-7bf30597b39b@amd.com>
Date: Tue, 7 Dec 2021 11:26:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/display: Fix out of bounds access on DNC31 stream
 encoder regs
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211207150709.164162-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211207150709.164162-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::17) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0081.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Tue, 7 Dec 2021 16:26:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e36da5-2476-4cf1-8330-08d9b99e5710
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54600D0160F8957291426F868C6E9@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YAEexR79x2bkr1JZCsNVjoqsjfKnB5qlwb4Oza9caFR5rz6G8aDN1l3Vp0ut8EvKDSk12z3CA32x+kuPTWnOZ5rN6NUrwg4PlNZu8mcTPuku5JJz7ow3VOqOahdWygYDZxC/KCDASNRPkvVUfPzWnEkIFyq6Dk32Q7OgkjQ5iOFdiXhBdcqTmCJhZON/f7Nb2475S4iHyMR0d88GUhlrA1tK3KMs3PfPR0pNrAVTVfvrs7iAQOhykQLrWvP5BONYFB97c8mDte9OgTGSgJhx2MF5pThluhJV3yHe5BXBLBxTX9FSiT7mK/6ZYgHoudqwVQ0B0Roz0/EpynSrN9Am00W3VLhL8Imttgnlz1abZ9BnKWVTWLT8piDvzD8HThucA8gGuu0fx/NCd6YwsvSuwr7bUyiborYzbpuKWDKfjwmOTzLEBHnQzDx8y+ODrpBE2W6/+SOfCyb9lBxILH8ZWdKko7nTTr4PLIYDuLN8FCjA/tdIOCqYwajLrU5YNiTXoFJAzhZO3/P4PXxtYUTryYBc890GZgK9VHsMT6wSldPz0KFfYNePu3SGIRlgGhaAbZagMy8xQ1bEoXwv4DoU3/BBSiUrJXueM8g00WFDr1aAM7ANODaGmLgbemowVePRW4kFGlLnoa9Bt5vfk4FqMgFHsy2VGMf0sEKafPbKHugNatu9uFEkCFU6PIlkBtfYEpW22jmKyGBaIqdgN8F7b08O/72WM7V4e2xIpZ3LmH/Ef6OWmocmxL4Vhbp1tIlO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(316002)(16576012)(36756003)(86362001)(6486002)(66946007)(53546011)(66556008)(38100700002)(956004)(4326008)(31686004)(2616005)(2906002)(26005)(186003)(31696002)(44832011)(8676002)(8936002)(66476007)(5660300002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVdvblNCWGVHVzhxRm5tV1p6NGFxL2VtL3hJSGQwN3NiWVF1ZEl2VjZodHlQ?=
 =?utf-8?B?Tm0rNmhuQnZ3d3I0bjBSK1hNNWpLTUVva2RvMTNzWG40cGppeVBQbzBLeEdt?=
 =?utf-8?B?bWl0dlJKZFRKR2hMakZHWGNoeVVsY1pJMGxOY1FRRi9hRU9tMXpzdWRLYlZD?=
 =?utf-8?B?cUFPakxRR3R4QXZBTmJhaU1TVEZlclB6M2E0dTc0T2hpdEpVYjFWdklvSVpt?=
 =?utf-8?B?dDdSMnJ2ZVFIT1JRN015WkJoUWt1SUw5MVY0Q3J6SU9yMTd1TnZOOHBPTmF0?=
 =?utf-8?B?Y21VZ252a3h4ZDliREw0YkwwaGt1dXk0Sk5CMXh1QXRqbkorN1hQRXhBQkZ6?=
 =?utf-8?B?V01zYXZ6NXhjaFV6TjdRWXdIUHBST2E2VnMyblhPQ0FqcDZsQS9HQ1h5dTZa?=
 =?utf-8?B?SXZIT2M4czdLU1pWNlkyMk1rSm5KNE11NHdKOWdJbVJaV0JGLzhLdGd5M2lu?=
 =?utf-8?B?SU1kVlh6TUgzdXlsOHFaUm1XeUVWR3BFeHdOQkNnV3RVenl4aHJqUCtxQkky?=
 =?utf-8?B?Q1UrcGFSSEpzYU55eUtSN0hhSCtTL0JXM2ROMi9BRjBMMk5scXN0OXJyNEdk?=
 =?utf-8?B?S09najQ3OWdxQ1JRSFd2QUV4aFkxL0U2eW1ob0ZnOEorcWNYRFBFTjJFMlF6?=
 =?utf-8?B?bkNJV0N1WStid0VTdVdpejdjZ0lja1hJdHVQMVVDajhkTUlhblVwWFowcnNR?=
 =?utf-8?B?QTNmaGV6QVlReG5FUzFEUlNFeTV0R2ZrZkpiaXlLdEIyenplN1htYlhJYWJV?=
 =?utf-8?B?WXBxV2I2RGlPSFFMN09QOHpCc3p3eTI2YnJrVXZZUkpQNTFSQkk0cUcyWmlr?=
 =?utf-8?B?T2x4cWpSQ3ZQYVF5L1pnVGd5OThESzRFYWF4RW1tUjdRa3FYc2p2VHB0SUk1?=
 =?utf-8?B?cDJteW9qdXhMc1RWNGo1VGk3eDJHN2xtcmM2UjBNQWFtdVZJcXZmT296dkQr?=
 =?utf-8?B?WEpRZnkybk1tV3hxZEVWRkw1SE1ycHpNb0RvdURTVktyQVFOb0dRSjRCVnlm?=
 =?utf-8?B?My9lejhyQk02bkdtMHZ0OFFsV1hQL1d1TTJnOTcvWUV5N1c4SVN0bXgyRWxN?=
 =?utf-8?B?VEYwSGV5TytLbTVrc1o1VjFrL3ByVWFIVEFwRVU1c1hUV1l2SXlBckV2YkRo?=
 =?utf-8?B?YkNaY3k5UlV5aVVtN0lUR1ZBYXF3WHpRZ0pFUS9KSm93Zm83bE5sMnk4Y29y?=
 =?utf-8?B?YW5mR0dNa2dDUWlZd1d5c1E5L0l2eWUwWUpwMnlBNC8yNS9pbXpHSUNBVURQ?=
 =?utf-8?B?MjFneEFJQXZTMzRRRHBmb1YyaGxJUUd5WVRqVVpDT0JabFJQTUhNOE5weGp2?=
 =?utf-8?B?ellibm8yQVJ2dUxsUWZqMm1FU2FaczA1NVVGUzZnQlArN1NIam5TbWFLelBx?=
 =?utf-8?B?TXp4ZnBwYlF0T25aZDA5TFdQdXZTRFFtSEROQWtHcEpvaTVXTnlFb1FLL0NK?=
 =?utf-8?B?TGJmcFRiaVg3TSs3ZHVrdnpMWnFNREllR3NoTlFSSlFtNllmYUFCalhoRkFt?=
 =?utf-8?B?VzB1NGdxdXA1eC9BL0hhdTduc3E4REVTUkdHT285MkhFaGtBVTlJQndmV3lo?=
 =?utf-8?B?OXBTWGptMkJHbm9lM1NKQVN0UHdKR0MvMHpvWXROZG5RdWhWMG80bjY1YzVt?=
 =?utf-8?B?M0s5blZrZmN0aWt4MytkaVlJY3FRNG9uTEt6OTRUem1zQ0RWR09GL09VR3FK?=
 =?utf-8?B?SHVubWhVbTBZaVFrWTUxWEkzRGEwNTZXMm5sVnJUcldocGgwUjdaWkJoeDJZ?=
 =?utf-8?B?T1JUdjVRcFIzV3VZdGRNajF1eXo2a0VibDB3cmdxcm9JYjNyd1pYRUhFcEF2?=
 =?utf-8?B?NWVWNDI5M0dHN3NlNFlxWkpSNVFQdHhTZ2pkYlFTLzZBOElHU2x1Rk8yemQz?=
 =?utf-8?B?dzJhUU1OSXgwTkJtOEE3cHFQY1ZIVDBWRG42V2phNTdSaG5LTmw3OW5kTHNk?=
 =?utf-8?B?VnorckdsVjV6MldyMWdld2pFL2E3NmU5ckJkaXpYMVBRRVhUd2FoVHo4Tkcy?=
 =?utf-8?B?R0RIR3dlS0VuK0tUckhBTlFkOHIyai9rcU1nRTNOUktOTHNsRm45WktVT1FV?=
 =?utf-8?B?L2RsdVVUMFhuTWVBSUdmLys4VFRzWnhTMzdkVllKbWFDSXJDRDl4SkZ0VjBZ?=
 =?utf-8?B?RmpEK2cwVlErREg2STFHa0E5MUJQMFhTWFVJNHVpM2NyenRFeUQ2cWo4cGtX?=
 =?utf-8?Q?tRw5iKAaLec+hIWjC3sTsGo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e36da5-2476-4cf1-8330-08d9b99e5710
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:26:37.1155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn8ybNfPwPr43YPN1QV0aMaSYQV3rGCWtSBh4hql1DiUCrgfPRUTzouuDV3wm2WnAK44s6isu4PnhRsEaCuzJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-12-07 10:07, Nicholas Kazlauskas wrote:
> [Why]
> During dcn31_stream_encoder_create, if PHYC/D get remapped to F/G on B0
> then we'll index 5 or 6 into a array of length 5 - leading to an
> access violation on some configs during device creation.
> 
> [How]
> Software won't be touching PHYF/PHYG directly, so just extend the
> array to cover all possible engine IDs.
> 
> Even if it does by try to access one of these registers by accident
> the offset will be 0 and we'll get a warning during the access.
> 
> Fixes: 2fe9a0e1173f ("drm/amd/display: Fix DCN3 B0 DP Alt Mapping")
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> index ec5b4cec0ef2..04b52c9d18da 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
> @@ -485,7 +485,8 @@ static const struct dcn31_apg_mask apg_mask = {
>  	SE_DCN3_REG_LIST(id)\
>  }
>  
> -static const struct dcn10_stream_enc_registers stream_enc_regs[] = {
> +/* Some encoders won't be initialized here - but they're logical, not physical. */
> +static const struct dcn10_stream_enc_registers stream_enc_regs[ENGINE_ID_COUNT] = {
>  	stream_enc_regs(0),
>  	stream_enc_regs(1),
>  	stream_enc_regs(2),
> 

