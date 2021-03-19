Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B4CC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7953061961
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 18:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7953061961
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE7A6EA6E;
	Fri, 19 Mar 2021 18:19:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDA56EA6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 18:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXwVvXFjRuQ9oNyKzeezYpI7EMqBv6y5lvrcGLv/8KAEOgcCAMKhJulxP9f3TtsNYZ81qr48hXIekfdHRjs+qVjgZzK0ZsHyOiXEsCCcvndHejqFIYGpcMrizzFct943tUHtNOjbah7ANOn6PE2edDuD8UDyCae9QT8hw2tcb9n+tKNwy0l5GM+ESTl7Yt6Z+0OitglX+iUQV/0skST2ZJuR+wy5C0R5VL7B3NMzZyzRg0TmHmRV7QQC8Z/ISrivT3FgKvnlmYwlTasfdwEfr72/ewVz/6VpzifOjdCY47STGoYD4C/yWEqkmg/yRLiruG6stQXye6l+6WP1IfoSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjHXOLEBziuVIiFyAmN3HTHOFg5UwKMsvqWbh7+Cpxo=;
 b=Ak0P2XkT4fCgZ2LB5h1f8Jd5D6Q6dWPJnAz8/D6nLpqo3b5bLLo37QQf7OV7QNpuwgmeG0wGpKNq8Z3SlLPtL5EeBQ8pwTUMe35VDqTKTPv4tJqM9VRG4TFC/UKy22Mbha9GwTFf46YoUSZORtSEfWN40Sw4l/EAi6BvAeFIP2QPvf6g6I/wKQ4kZv/hBGtbBHQjKAsUW13ugqWj6Q/Z04zQcSHP5OHx8Vm7roASBTpuK+YaJ2EGkt7g+/RdvxB3JCoUTx8E/sfegiz+q27qK0SjKhkICN7H2t308F7Z8T4Y+SJzxzC4DgEZBZPWbwcsFIop/MM6dThrf+5+dDiVTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjHXOLEBziuVIiFyAmN3HTHOFg5UwKMsvqWbh7+Cpxo=;
 b=KN6O5wjoo9lGnn3lSuBb9VZcf5JTyvdqkaYcyLMr+huIANNLgbEmeRTqBK0PYVap50XAkZfOPbN0ZWKuV8k106wQl14+ebj5zYgVvHR84XXjH9OpR9/L3lkeO+IVBY8KLAd/RhOsaBiiuIvm02tDNRI7dUsROLjl1p0Qee8A2kQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1382.namprd12.prod.outlook.com (2603:10b6:903:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 18:19:45 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3955.023; Fri, 19 Mar 2021
 18:19:44 +0000
Subject: Re: [PATCH 1/1] drm/amd/display: use GFP_ATOMIC in
 dcn20_resource_construct
To: Nirmoy Das <nirmoy.das@amd.com>, harry.wentland@amd.com
References: <20210317105239.70617-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0872ee71-7315-469b-3de1-079256e5c4d7@amd.com>
Date: Fri, 19 Mar 2021 19:19:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210317105239.70617-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.58.99]
X-ClientProxiedBy: AM3PR07CA0124.eurprd07.prod.outlook.com
 (2603:10a6:207:7::34) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (93.229.58.99) by
 AM3PR07CA0124.eurprd07.prod.outlook.com (2603:10a6:207:7::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.9 via Frontend Transport; Fri, 19 Mar 2021 18:19:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 759c7765-b888-4093-0f35-08d8eb039254
X-MS-TrafficTypeDiagnostic: CY4PR12MB1382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1382D2C9A183B4E50C53B1408B689@CY4PR12MB1382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HV1dLTZ9HPyuHGo6/bhPHc3mI52hwm2NUTxp5/Mwmf739GCaVwtiD84BuipU7KVr2AAqYVX+b1ZvlulBkd+DJUcAcgAsNmWuYyKZNjIroMEGmiULsSTLqqpXa+cNAJ/clXCDjJlNe/FvqQlvrFuqdLzgWaIePyo/VZQhgXAN84imh44LR51EYFdBhpAkBL08CkjHgTWsle3KC13co3aRTsHHEAHlUH6d3Oo/KwV1kviotGvhhp93jRzddO6DVIgOkj1d+y9vZqq7siK30Bf/2D1RvvdLTD1NCVWYg0MOv9mCrEt32TbMGtBb3UKqGGDfhV2VbqRMmifBX3vAWXC1QRROZyoJUWbOPwq+C77CMzYFoVCQbED89Ym/2tv5Mf3rWmTLoTwoOcBoi0EmzAt6v02Mq6zT2xfoqGbSiHiYQaFAun6H4kykW/MC3DIBowL2sdHaRZB325bnBVd4ONmxT86mblzPQxI98qNE99eT/EWFG87t+k13wHwXtfzMCdc4vEaqnie0bNoWAQQy3b3tlLbabm/YY+4joDCMsQSOdTvGtGGMxU+iXqVOJXpllQXKUvSxwi7604sskJPw6iOy9lhZl0+JtxR/W7VuZS4T0NWrNFfWBR8RjKikZUAhUfMTrcRq78yWv2Atgl3qtNOjI47cAj+it4GDZi1/Nqlo6c+WKDddbq2jMmBNNFYibK5cC2DVmStTWskGatc+V4b3Nq6rL266/begCbbnEIRVyl0BhP2XKs7yzEsTnvPgHovhHGqjenPeFS9BD7pLZkA2jfQataI495ZJHRe645VK2Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(66476007)(66556008)(52116002)(8936002)(83380400001)(5660300002)(316002)(16576012)(31686004)(6666004)(31696002)(66946007)(8676002)(966005)(478600001)(956004)(186003)(26005)(16526019)(4326008)(6486002)(53546011)(6636002)(38100700001)(2906002)(2616005)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?LzVVbHhOaDlvRUJDWmdueXNSUVdzbzJoN2NUbnlocGFCaFAzUCtpK3M4ZXhH?=
 =?utf-8?B?S0d4MlNaZnlUOGNTSHpmTEpYSEtBYUtuL0lKcGUxWjJnL0Jtc2ZoTDFFUUx2?=
 =?utf-8?B?SGpadUhKTE9JMEJKN2lGK3hiSjJIc1RnNDh3cDYzeGtEM2RnN3FISDhpbWgv?=
 =?utf-8?B?NzNDQVg4R1pOdDdLemE5dWxxN3ZHUTdITjNpNWRUQXc5dU1DNlFSZWhRRzA0?=
 =?utf-8?B?Qm00OFdKaWUvVlpZT1BLSGNMSjZQamgvYkRIaS91UkhsMXI0ZU9WZENEZHB5?=
 =?utf-8?B?WmNDOTFJMGZXYjJvS2IxYmR6VlpJRGFQSHZ0bGFIeFVJeCtOeHpTWHJMUHU1?=
 =?utf-8?B?RFd6Zms4ZEp3aElKVVJESFNNWUpYUktpN0pHbGVjQ3FGQkZKVzhKR05XdXdL?=
 =?utf-8?B?QXlRVE5rUU5KN3VtcURsZVBxMnZzYmRaOXB6bGhMaEtHbkFsVTdCMDJYUkxq?=
 =?utf-8?B?VmRPQjNIU3ZERTJCbG1rVmlzOEhaNXJDWVUyU090ZkIwVUtabTlieUFhYXEy?=
 =?utf-8?B?YlZNR09RMEh5RzBGSExOaHdvTWViVnJkVUZOUkZnWjc4MVkvT216d0JJV3JI?=
 =?utf-8?B?eUtkSnFZczJ3b1FlcXNIYWNyc2ZLRS9iWXN3MlFmbE5SUXErY0dGcm9iUDVX?=
 =?utf-8?B?TS9FWXcxUjU5LzZFdytFMkVOOUdSa0lXOXdVNVkrUmlXUTI3dVM0M285VnZY?=
 =?utf-8?B?RHlYcU4vTkVmakxLbHRack10ci9IN3dnY0xYUHpGSnZ4MkZzQUJFVnIwNHFo?=
 =?utf-8?B?YlMyRFRkUEtZODFOUys2UW9Ec3FhTnNObk0vdGFxdzh4c294MEsvTXA5c2ZQ?=
 =?utf-8?B?aDJnQk9BNytOYmdtTFpKOW1YSW8vM1NURi9ER2JiaVluakhIdFd4a2x4S1Fo?=
 =?utf-8?B?S0IyOUIwQ0ZBZDBmd2FGa0V0NzB5djY3cTJrV2FOcjZMcTlSeXpsVXFjMVYy?=
 =?utf-8?B?dzltM2hhWUdKN1pJL3Y4UTEwbnFuQk1tRjBpZFhzWUJSRXN1dWFzVnV4bVpa?=
 =?utf-8?B?TEhSK2psb3I5UndPamNXUmV4SUlnZFlmRTRHTDhOTWs3VHBlZGZWLzdjY1M0?=
 =?utf-8?B?dmo5VmFHekd5WnJrcGlIOVRQQ1JHT3hySHFORzJwTTRwZWNYT2EraS9FeHl5?=
 =?utf-8?B?VUxFYmdvMWQ1NkJKUS9lajVUdzE5bHhITXZPa1kzaFZiVEVOZFcxK2tyQnVn?=
 =?utf-8?B?YUhHa01tVVZKeCtVRllDVDA3YzJNTEhoNnBRdG0rdU5Fa0VVNW9kcm12MUI5?=
 =?utf-8?B?dHhNQXBPY0JNZ3dFMWlWVjNHQUVSRjFmUDVVdmIzMCtDMm5Zb2YwTG41Mmph?=
 =?utf-8?B?N21CRXVoWnBTWlZMOU0zZTc0MndUTVJQWm5ybVVkQ21CTVpaaGVyQXM5WEhX?=
 =?utf-8?B?Y0dDeHpXZW51MFVXczRSYVIwL0Vla0wvTzE2OWpRRGZEcHhhY3VIZHMyYXdp?=
 =?utf-8?B?RDZsZkNYMGJNNldZZ1pZQ25TaS9MNkgzVGk1cHdQWGZvZG5rNDFUTVVHYmFN?=
 =?utf-8?B?eXVqZk5KMFFUZ3ArYUdKdEY0VWVBUVhxNGc1WGszVlVMbTUxaVJabTV2SWUw?=
 =?utf-8?B?N0c4ZzNuUzhlNERuY3BIeTliWnVCdjAwa1hBQkhGa2drRThHcXdHamE5Z3Zo?=
 =?utf-8?B?MzRmaStMekw1YWNBZjZ3Z0ZjVEF3UWJUT2ZRT3JiaUtobEJvRU1HVmRiTmE3?=
 =?utf-8?B?cjFYc3diTVdCM0lCeTYwTUNoUU1US1o5SUV3MGxFbm1rV0MxLzV6VDljNXR6?=
 =?utf-8?Q?DZsnwzcNIHF16ZVxSxFBJfZqEPFWUkqTRqAHKdU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759c7765-b888-4093-0f35-08d8eb039254
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 18:19:44.7995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ynlpz0EObV9W+exv7rJqL8O67ZNsfdleLu18cbRYV3+JU0v7PE+YwMhhX03eSoedT8iil+7Knj4arPmXfMSUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1382
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
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.

On 3/17/21 11:52 AM, Nirmoy Das wrote:
> Replace GFP_KERNEL with GFP_ATOMIC as dcn20_resource_construct()
> can't sleep.
>
> Partially fixes: https://bugzilla.kernel.org/show_bug.cgi?id=212311
> as dcn20_resource_construct() also calls into SMU functions which does
> mutex_lock().
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |  2 +-
>   drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  6 ++---
>   .../gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c |  2 +-
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c | 26 +++++++++----------
>   4 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> index 4e87e70237e3..874b132fe1d7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_abm.c
> @@ -283,7 +283,7 @@ struct abm *dce_abm_create(
>   	const struct dce_abm_shift *abm_shift,
>   	const struct dce_abm_mask *abm_mask)
>   {
> -	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_KERNEL);
> +	struct dce_abm *abm_dce = kzalloc(sizeof(*abm_dce), GFP_ATOMIC);
>   
>   	if (abm_dce == NULL) {
>   		BREAK_TO_DEBUGGER();
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> index 4f864501e046..8cd841320ded 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
> @@ -1133,7 +1133,7 @@ struct dmcu *dcn10_dmcu_create(
>   	const struct dce_dmcu_shift *dmcu_shift,
>   	const struct dce_dmcu_mask *dmcu_mask)
>   {
> -	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
> +	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
>   
>   	if (dmcu_dce == NULL) {
>   		BREAK_TO_DEBUGGER();
> @@ -1154,7 +1154,7 @@ struct dmcu *dcn20_dmcu_create(
>   	const struct dce_dmcu_shift *dmcu_shift,
>   	const struct dce_dmcu_mask *dmcu_mask)
>   {
> -	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
> +	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
>   
>   	if (dmcu_dce == NULL) {
>   		BREAK_TO_DEBUGGER();
> @@ -1175,7 +1175,7 @@ struct dmcu *dcn21_dmcu_create(
>   	const struct dce_dmcu_shift *dmcu_shift,
>   	const struct dce_dmcu_mask *dmcu_mask)
>   {
> -	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_KERNEL);
> +	struct dce_dmcu *dmcu_dce = kzalloc(sizeof(*dmcu_dce), GFP_ATOMIC);
>   
>   	if (dmcu_dce == NULL) {
>   		BREAK_TO_DEBUGGER();
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
> index 62cc2651e00c..8774406120fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c
> @@ -112,7 +112,7 @@ struct dccg *dccg2_create(
>   	const struct dccg_shift *dccg_shift,
>   	const struct dccg_mask *dccg_mask)
>   {
> -	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_KERNEL);
> +	struct dcn_dccg *dccg_dcn = kzalloc(sizeof(*dccg_dcn), GFP_ATOMIC);
>   	struct dccg *base;
>   
>   	if (dccg_dcn == NULL) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> index 2307b3517821..25f8dd5db080 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
> @@ -1106,7 +1106,7 @@ struct dpp *dcn20_dpp_create(
>   	uint32_t inst)
>   {
>   	struct dcn20_dpp *dpp =
> -		kzalloc(sizeof(struct dcn20_dpp), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn20_dpp), GFP_ATOMIC);
>   
>   	if (!dpp)
>   		return NULL;
> @@ -1124,7 +1124,7 @@ struct input_pixel_processor *dcn20_ipp_create(
>   	struct dc_context *ctx, uint32_t inst)
>   {
>   	struct dcn10_ipp *ipp =
> -		kzalloc(sizeof(struct dcn10_ipp), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn10_ipp), GFP_ATOMIC);
>   
>   	if (!ipp) {
>   		BREAK_TO_DEBUGGER();
> @@ -1141,7 +1141,7 @@ struct output_pixel_processor *dcn20_opp_create(
>   	struct dc_context *ctx, uint32_t inst)
>   {
>   	struct dcn20_opp *opp =
> -		kzalloc(sizeof(struct dcn20_opp), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn20_opp), GFP_ATOMIC);
>   
>   	if (!opp) {
>   		BREAK_TO_DEBUGGER();
> @@ -1158,7 +1158,7 @@ struct dce_aux *dcn20_aux_engine_create(
>   	uint32_t inst)
>   {
>   	struct aux_engine_dce110 *aux_engine =
> -		kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +		kzalloc(sizeof(struct aux_engine_dce110), GFP_ATOMIC);
>   
>   	if (!aux_engine)
>   		return NULL;
> @@ -1196,7 +1196,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
>   	uint32_t inst)
>   {
>   	struct dce_i2c_hw *dce_i2c_hw =
> -		kzalloc(sizeof(struct dce_i2c_hw), GFP_KERNEL);
> +		kzalloc(sizeof(struct dce_i2c_hw), GFP_ATOMIC);
>   
>   	if (!dce_i2c_hw)
>   		return NULL;
> @@ -1209,7 +1209,7 @@ struct dce_i2c_hw *dcn20_i2c_hw_create(
>   struct mpc *dcn20_mpc_create(struct dc_context *ctx)
>   {
>   	struct dcn20_mpc *mpc20 = kzalloc(sizeof(struct dcn20_mpc),
> -					  GFP_KERNEL);
> +					  GFP_ATOMIC);
>   
>   	if (!mpc20)
>   		return NULL;
> @@ -1227,7 +1227,7 @@ struct hubbub *dcn20_hubbub_create(struct dc_context *ctx)
>   {
>   	int i;
>   	struct dcn20_hubbub *hubbub = kzalloc(sizeof(struct dcn20_hubbub),
> -					  GFP_KERNEL);
> +					  GFP_ATOMIC);
>   
>   	if (!hubbub)
>   		return NULL;
> @@ -1255,7 +1255,7 @@ struct timing_generator *dcn20_timing_generator_create(
>   		uint32_t instance)
>   {
>   	struct optc *tgn10 =
> -		kzalloc(sizeof(struct optc), GFP_KERNEL);
> +		kzalloc(sizeof(struct optc), GFP_ATOMIC);
>   
>   	if (!tgn10)
>   		return NULL;
> @@ -1334,7 +1334,7 @@ static struct clock_source *dcn20_clock_source_create(
>   	bool dp_clk_src)
>   {
>   	struct dce110_clk_src *clk_src =
> -		kzalloc(sizeof(struct dce110_clk_src), GFP_KERNEL);
> +		kzalloc(sizeof(struct dce110_clk_src), GFP_ATOMIC);
>   
>   	if (!clk_src)
>   		return NULL;
> @@ -1440,7 +1440,7 @@ struct display_stream_compressor *dcn20_dsc_create(
>   	struct dc_context *ctx, uint32_t inst)
>   {
>   	struct dcn20_dsc *dsc =
> -		kzalloc(sizeof(struct dcn20_dsc), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn20_dsc), GFP_ATOMIC);
>   
>   	if (!dsc) {
>   		BREAK_TO_DEBUGGER();
> @@ -1574,7 +1574,7 @@ struct hubp *dcn20_hubp_create(
>   	uint32_t inst)
>   {
>   	struct dcn20_hubp *hubp2 =
> -		kzalloc(sizeof(struct dcn20_hubp), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn20_hubp), GFP_ATOMIC);
>   
>   	if (!hubp2)
>   		return NULL;
> @@ -3396,7 +3396,7 @@ bool dcn20_mmhubbub_create(struct dc_context *ctx, struct resource_pool *pool)
>   
>   static struct pp_smu_funcs *dcn20_pp_smu_create(struct dc_context *ctx)
>   {
> -	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_KERNEL);
> +	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_ATOMIC);
>   
>   	if (!pp_smu)
>   		return pp_smu;
> @@ -4042,7 +4042,7 @@ struct resource_pool *dcn20_create_resource_pool(
>   		struct dc *dc)
>   {
>   	struct dcn20_resource_pool *pool =
> -		kzalloc(sizeof(struct dcn20_resource_pool), GFP_KERNEL);
> +		kzalloc(sizeof(struct dcn20_resource_pool), GFP_ATOMIC);
>   
>   	if (!pool)
>   		return NULL;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
