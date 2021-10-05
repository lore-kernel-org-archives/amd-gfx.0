Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C465C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FCE6113A
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04FCE6113A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981F06EB8A;
	Tue,  5 Oct 2021 14:15:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5381A6EB8A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 14:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMbGk7X/L8He49fiOxGeSc1YfbKJyF+gf+0IetFXyPa119QzIN/Py2QfUZIH2uuYGYNvtWA18iN3F/Zmw7/MJ+kSQO12FCcOuF0CaqVodKlidFnkLVjqV1UZSkw30svHdkA1k1hDAawTnXZ9O0piS6qvxpgcwBGvW+SZRsltKXgJYfxFptgKMXoO41KfRmx6MPJusEA4mg4sp4VqawNI1nuxusvyLXpmZOp4SKRM8/1LtehKQGqht8uhyJ0VLMpSpg+1k2ZchJv5xqOuxvcXH3oe/qFwDB9DO4faPWGxs4qfAlNNZM3vRTaepsYgammQC8KwQOd8k9wWpvQtqTruuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bXW06W2U4AjVAxODUzT7kfmcmmhFaukUSrjvz8F5AI=;
 b=H1+PpJFXMbnO2i8+DBVzJIjIyvas+BmsB6IgR/iHOOURA+OIzKhQbd/pOrQ4dDWudSllqz3K1yLJWMLTHTNoIpLfcuRemFS2PsUXklJgeZ6kCAiY6U210vGBBx6OL+muNk8fs0uILs/g8hk87RnDY7J4YjsY7nb4E4NtefEq1+aAGnJw+SxywXmEt7LjjwhdXvm4HF161PMrcMB0CNXwyHPN6vS2Hmenhw9n74KtKcrZcuX3UipL78VNuQ70wsOwGZ8gV08eQY8hp5YZOq1kLFOthsl/EtKR1eAanv72Q/4I72spXHe63PRNmY8zRaI+TqVVVi1Y2CCE5cs6pdJQhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bXW06W2U4AjVAxODUzT7kfmcmmhFaukUSrjvz8F5AI=;
 b=1gI0mcvvrT9fo/gl/eskMrkUJ8r/6U68w7yw2XjYSwFU2M6dshHkXKo4TIstyddk7umzLEs86Cw78xxiC1flMD26BflTsjGPPziqXn7x1tGhcf1GvE6g0jWM17qM1ENBmLXb3Gn2NNLD9ug1vOxqIldSkUCws9ij170bM29b1SM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 14:15:32 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%8]) with mapi id 15.20.4587.018; Tue, 5 Oct 2021
 14:15:32 +0000
Message-ID: <acfe099d-b13b-2975-8ac1-8f0d9e2ddd28@amd.com>
Date: Tue, 5 Oct 2021 10:15:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2 01/23] drm/amd/display: Update link encoder object
 creation.
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, nicholas.kazlauskas@amd.com,
 Rodrigo.Siqueira@amd.com, stylon.wang@amd.com, jude.shih@amd.com,
 jimmy.kizito@amd.com, meenakshikumar.somasundaram@amd.com,
 Jun Lei <Jun.Lei@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
 <20211005075205.3467938-2-Wayne.Lin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211005075205.3467938-2-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 14:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8574c0e1-5723-4266-77d5-08d9880a9752
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5427A248A2E464B5BE962EFB8CAF9@CO6PR12MB5427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJkfcvCdCwBLVPL4Z75dJp6Q1Xu0T935m/P4KMMx0FujRU3gRlBUZ6KQYdtByaKK3xJ3P8UV73ZGmEeOkLALgXfkLq2SmTTvHxixHje3LmLQmky/QIIT9fEGwRap6p6rXFHl4dOjj8Yf4Lxuug4GLinvWxBhETA63qdajxAq5XbGxXL9Nh2oZeMesbPW83s8CdmXSbhGhMrT74E+Ya5kOFffg9qRIc2mdB+2neiIBv+Nah2BkSAqb8p3rnZDRog3R8yXTVD1Eh+tos71ZAitgloLlP/1NVA9pMYTWa1yHOUfixe+bx2pP6FB9vUs/Ev05m9nyjMcBdHqyjlN3NyRBnZIMbfh+kKxtjXje0yKumXP3S2kMy7z7TDa7xjJjGjXpq/6ggOqfgOI6ONn6nJx7rjtE5oSDXAJ68tUJhgMfL4SeKU4GoBGFMBkIXjcp10V4kMC7z88iNax4pZOCnub/Wh+/V8iRDJ9vNW7OWrz34OxPqrQmdbmm8nemxZ5UsiDBJ3lguu8qo1gr9ljxyjUvHz9zGKJnjfqFe/npsrIhmlGq7SUcTzflPn+8ezADhT4PwgjVzuv13duZzgcFJknI+Y3bXVI/BAYeyDPMscttt/gvseK5Y5q3Eytp1QOVoZqYQthFpWlwUDE7vvhn19hRsQjBgcw7eYbwaeqRKWu/PCON9hxJwckW3XLZU9uE2dSbDjjssVGyftLOlRUDF37ult2utoo5MzTnbAChwK5NnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(508600001)(8676002)(86362001)(66946007)(66476007)(66556008)(44832011)(53546011)(83380400001)(5660300002)(2906002)(6666004)(15650500001)(956004)(2616005)(38100700002)(26005)(6486002)(31686004)(36756003)(8936002)(4326008)(16576012)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFVnV1RFRUNHMldCai9DWVFpR3dtVVQvOHhWSm14aVkyVW43ZXJQVFk5VlJs?=
 =?utf-8?B?U1ZYMmRJVFRXcWh6Zy9mMkdMR0lpL3F2TU41bFBEbmlIY3RJamttK2tRRUkr?=
 =?utf-8?B?alZYU2VxckkyaDRxWk9TcE1IeWZYWUt6bUc0cmJZbnZJalYwWWNqRWE5ejNx?=
 =?utf-8?B?ZTBBV3FMUDBaRmdXOGxjaXpVOWNBczdHY2tqWW5HdjRCemNuVUtka2xvS3A4?=
 =?utf-8?B?UzBNd2NYR2t3Wk9tV3RocHdJUXNHMDBsOGtqVW1TYnVqdk9IVzRVQThWR01P?=
 =?utf-8?B?U1pwVWVHekJrb2VQUFF3Mjl6SkczOFlsbnY1VzRNa1RONmpzV2VDc1JWUUdK?=
 =?utf-8?B?S2ppdXhJOWhSWnlZUXRiZmZZc0padXFrMVhxSEZmSkxjUFFMVk01M2FnNjVh?=
 =?utf-8?B?RW5NRnBWSHBlVmNnUmo4V0ZrSXVYTHpPNk5mWklQLys5U3FvYlJhc1NGTitq?=
 =?utf-8?B?SWFmcEwvTThGU1lJeXZCcGxsTXFRUUZha2JTZUpvTStKWktKUnBTTlVETFhK?=
 =?utf-8?B?MHMvMjhJSFRwcCtnQmloNTZZSmVrTUJkRFZqblIyRVcrVUlOdWhxV3gweFFC?=
 =?utf-8?B?bVhSUkhwU2lkOEVmc0hRdmNNMWRWYVo3THIzUDg0TERXUXdzL1pjQmNXQXBJ?=
 =?utf-8?B?V2U0VmF0MEJCMER0QVBIS2x3ZWxWWmVxdjZRZ3dYbVBKd0tUbURvaStLbXk3?=
 =?utf-8?B?VHJZU0ZlOUFaTEZKRXNtdUw0NlZxUTcwelNraGRwOFF5SW4rd3NrVGZFa1Rh?=
 =?utf-8?B?NXVWOGdaQ2RGVWQzMDJEQkRZdUVYVnNaSW11ckNUOXdEQkFjeVpHckQreXRw?=
 =?utf-8?B?M3QwdVFhLzJQWlZnbGxHWk9YaGlCWDRZQmJjbStPV2VIU1h5c3RqVjVFTWUr?=
 =?utf-8?B?QjNrZ055dllyOGk3M3VFQU96cFBiZUNEM05ZampzQmpoUm1LOTQrZU1WU09y?=
 =?utf-8?B?bFBmYnJ0a1pRZzE1czNjTlJieTV0bnhOVCtHTUxoN1NHVXcwR1RsZVV0bEhz?=
 =?utf-8?B?YzdsSW9jWXlPcDBrdHBudTFvWVBxd1BYZnZSbnlGQlIyYjBIYVgxQTA4djNa?=
 =?utf-8?B?SUQza3FmdVJRdnA3cFRyRXU4akJUZzJGVmR5bWZWUmpZUG1kYzFXVWRlcndM?=
 =?utf-8?B?WS9ESlNYV2hzUHplT1QrQjV2K1hMcDQxSWRCN01HZWsxc0JaSWs5Q0lFeVAw?=
 =?utf-8?B?bE5rbnZobkZPakVFYnpHR0V0aUhmSXJMa205aU04d2xRS3pFS3M5MVFTbXRO?=
 =?utf-8?B?M1Qza0xPMkVuZmt2MXZ1WGpsRDZzeU93SGw2QXQ1Slc4ZzY2TGtxeTlmaTBB?=
 =?utf-8?B?VnhNQnFlMjN2TU5UaVVBYmRWcnZKTEtXeXR5L3BNUG9Lb3JFYXBjT3NYZ3dz?=
 =?utf-8?B?Z3VWV3FrNWYvNEE5ZHJoMXpBRmF4OEZkNzdFSDYzd2R0VytRVlNxby9Kc1I0?=
 =?utf-8?B?eUMvMTMzcXpkWXpnUTJLdG9rR2tIbFVGb0NHY1JIcERJNGVpL0IxRFJVdHFx?=
 =?utf-8?B?L2RFNWgzWFhDZVM3OXEwbFhDeW9qSms2aFNQZDB1Nkg2R0VKZTdJRGhtd0R5?=
 =?utf-8?B?TGVzYXVlaVd5ektsQzNNaDZ6UkdDZ0p2NzRLK0RBdzFSb3hWTkpNWW51TTlL?=
 =?utf-8?B?WWo4S2NLNkdzbE1EdjlkZzRqZ3lnUmcyRnlOSEpiMVF6MXAzREtMb2ZYaUZM?=
 =?utf-8?B?Y1NRV09paUF4N3c1Qk9GSjkvN240U0FQaDc2OXlpT0Roc1d0RFk1V3lrOFB0?=
 =?utf-8?Q?MBWrdEcCfNyGglSONpK5Zib1dv9VdYV+O49gfAr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8574c0e1-5723-4266-77d5-08d9880a9752
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 14:15:32.4627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFr1etCGgi+DhEw8WWIxrRnk/S5mPwgoDjkUb0jdkjiAYoOhGRamV4qOpFG/cf8A7hChwNlHF+maILAcbwd3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427
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



On 2021-10-05 03:51, Wayne Lin wrote:
> From: Jimmy Kizito <Jimmy.Kizito@amd.com>
> 
> [Why & How]
> Add codes for commit "e1f4328f22c0 drm/amd/display: Update link
> encoder object creation" to support USB4 DP tunneling feature
> 

It looks like all of Jimmy's patches refer to porting code from some other
patches. Do those patches have a patch description?

Basically, above "Why & How" description doesn't describe why this
change is made and how it is done. Please provide that description.

Same with other patches in this set that talk about "Add codes..."
without providing an actual description.

Harry

> Reviewed-by: Jun Lei <Jun.Lei@amd.com>
> Acked-by: Wayne Lin <Wayne.Lin@amd.com>
> Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 77 +++++++++++++++++++
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
>  drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
>  3 files changed, 80 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 8e0bcd4fd000..673fb0ef7a89 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -296,6 +296,75 @@ static bool create_links(
>  	return false;
>  }
>  
> +/* Create additional DIG link encoder objects if fewer than the platform
> + * supports were created during link construction. This can happen if the
> + * number of physical connectors is less than the number of DIGs.
> + */
> +static bool create_link_encoders(struct dc *dc)
> +{
> +	bool res = true;
> +	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
> +	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
> +	int i;
> +
> +	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
> +	 * link encoders and physical display endpoints and does not require
> +	 * additional link encoder objects.
> +	 */
> +	if (num_usb4_dpia == 0)
> +		return res;
> +
> +	/* Create as many link encoder objects as the platform supports. DPIA
> +	 * endpoints can be programmably mapped to any DIG.
> +	 */
> +	if (num_dig_link_enc > dc->res_pool->dig_link_enc_count) {
> +		for (i = 0; i < num_dig_link_enc; i++) {
> +			struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
> +
> +			if (!link_enc && dc->res_pool->funcs->link_enc_create_minimal) {
> +				link_enc = dc->res_pool->funcs->link_enc_create_minimal(dc->ctx,
> +						(enum engine_id)(ENGINE_ID_DIGA + i));
> +				if (link_enc) {
> +					dc->res_pool->link_encoders[i] = link_enc;
> +					dc->res_pool->dig_link_enc_count++;
> +				} else {
> +					res = false;
> +				}
> +			}
> +		}
> +	}
> +
> +	return res;
> +}
> +
> +/* Destroy any additional DIG link encoder objects created by
> + * create_link_encoders().
> + * NB: Must only be called after destroy_links().
> + */
> +static void destroy_link_encoders(struct dc *dc)
> +{
> +	unsigned int num_usb4_dpia = dc->res_pool->res_cap->num_usb4_dpia;
> +	unsigned int num_dig_link_enc = dc->res_pool->res_cap->num_dig_link_enc;
> +	int i;
> +
> +	/* A platform without USB4 DPIA endpoints has a fixed mapping between DIG
> +	 * link encoders and physical display endpoints and does not require
> +	 * additional link encoder objects.
> +	 */
> +	if (num_usb4_dpia == 0)
> +		return;
> +
> +	for (i = 0; i < num_dig_link_enc; i++) {
> +		struct link_encoder *link_enc = dc->res_pool->link_encoders[i];
> +
> +		if (link_enc) {
> +			link_enc->funcs->destroy(&link_enc);
> +			dc->res_pool->link_encoders[i] = NULL;
> +			dc->res_pool->dig_link_enc_count--;
> +		}
> +	}
> +}
> +
>  static struct dc_perf_trace *dc_perf_trace_create(void)
>  {
>  	return kzalloc(sizeof(struct dc_perf_trace), GFP_KERNEL);
> @@ -729,6 +798,8 @@ static void dc_destruct(struct dc *dc)
>  
>  	destroy_links(dc);
>  
> +	destroy_link_encoders(dc);
> +
>  	if (dc->clk_mgr) {
>  		dc_destroy_clk_mgr(dc->clk_mgr);
>  		dc->clk_mgr = NULL;
> @@ -933,6 +1004,12 @@ static bool dc_construct(struct dc *dc,
>  	if (!create_links(dc, init_params->num_virtual_links))
>  		goto fail;
>  
> +	/* Create additional DIG link encoder objects if fewer than the platform
> +	 * supports were created during link construction.
> +	 */
> +	if (!create_link_encoders(dc))
> +		goto fail;
> +
>  	/* Initialise DIG link encoder resource tracking variables. */
>  	link_enc_cfg_init(dc, dc->current_state);
>  
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> index 0fea258c6db3..ed09af238911 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> @@ -245,6 +245,8 @@ struct resource_pool {
>  	 * entries in link_encoders array.
>  	 */
>  	unsigned int dig_link_enc_count;
> +	/* Number of USB4 DPIA (DisplayPort Input Adapter) link objects created.*/
> +	unsigned int usb4_dpia_count;
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	unsigned int hpo_dp_stream_enc_count;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> index 3fbda9d7e257..372c0898facd 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
> @@ -49,6 +49,7 @@ struct resource_caps {
>  	int num_vmid;
>  	int num_dsc;
>  	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
> +	unsigned int num_usb4_dpia; // Total number of USB4 DPIA (DisplayPort Input Adapters).
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  	int num_hpo_dp_stream_encoder;
>  	int num_hpo_dp_link_encoder;
> 

