Return-Path: <SRS0=SWRn=ML=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1ECC07E95
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 20:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E70D1610F7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jul 2021 20:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70D1610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4ECC89A86;
	Mon, 19 Jul 2021 20:56:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70BCC89A86
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jul 2021 20:56:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmAl1qLIQbPUsWfyPGYcy5o1sUCdvicKBiOZKpKjVKns96+T2liT6J3pj7PaeR/E2SNHBvGkzJaD7/QuUKI/C1JYFS0uBKJEXGieXYZks1nuMEXdSVBBWWotvugJu8eHakISjgG/Yy8lM0UKnYn55qp9uiUCmPan0KSoSBCAxwiMhlvJ8ukoedWX9DZ5Y3gZmLJ8SZxy3+mgDyUxSjXF23EtqBaa2HovCa4wyW1aDpc3a0dRgA24UcO8ydfJUJYyfWYIX3Qki0solxKEFzNWk/xtDxENcFX2gfbwglWfu6p804scW3Vf1KaON8HBt+ft3Sff1NNpIAjTK1Iz5tXFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6HWbiBjI/yFdmTEuawKlX8RpQaeWMHRCVRGB0fp/Cs=;
 b=h4goYr+lX3oaYMkucdBiAoUwCTymiO1YefdlL/FRHAQRMHI3j3oXj6OSneEY743sXMQJ0jQLtkldpaFZF2EG/M5JCCA+IkZIw3pmWw/b5WEgJkhf9Gqbahh2c6YhumnB/HVJ0J4+Yw5fuDeZejXAjc3uLEkUJB+7f+fLLebzg4xtC7nDmw8drO8YRqiray1RoHD9SpHwcrfQQbm2gifOstlMofrdrKCxbAV5/9GA8abMZlI0TzdtXfGPaatTwcl6maMv9pAaX3fv1lpuZS0Xt3S7j476Ajuok8mGAWwf5oCoPkYRn1QYeQAQMYLpDRpUHZHX5L2Py7xSpb83yO5s1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6HWbiBjI/yFdmTEuawKlX8RpQaeWMHRCVRGB0fp/Cs=;
 b=3tniy3XPLChftdIMBrQrMxnQRySvHvcAT5MkHSzzDPN2GQRM8oZU8XFzD2ZDb9OobOO0cHqKunN7zG6y2FJFXunGDUvdh5JtNNx22q5H176lQOG5uOgK2IzntHtadBQp2r4UZqQtBU8QFrYIHtm4JjDx2NKG/j5n090APHpmwPE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5412.namprd12.prod.outlook.com (2603:10b6:5:35e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 20:56:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::39db:7a51:9e0d:9b19%5]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 20:56:42 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix documentaion for dm_dmub_outbox1_low_irq
To: Anson Jacob <Anson.Jacob@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210719174914.381575-1-Anson.Jacob@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <33549911-dfae-74a6-951d-2fcfb739b7a9@amd.com>
Date: Mon, 19 Jul 2021 16:56:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210719174914.381575-1-Anson.Jacob@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (198.200.67.154) by
 YQBPR0101CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 20:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 480428bb-82ff-4611-f395-08d94af7b5ff
X-MS-TrafficTypeDiagnostic: CO6PR12MB5412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB541207413BEF5A91027F5EE38CE19@CO6PR12MB5412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opaj8xBL22fOfE48pfMhPUvflmTjiBP9xHrYmtk1YEdHmo0Uh1HNhjm47pTO+wjIGP304m/D4WUV6t+0ujhNQNN7uFuCE29n2H8sl+TVvBJ8iHEaNgH/sZS5AUf/My5aGfimC2oVkaH38Ywi33XhWuY1L0+0giP2qOouSiCRMzrI+ekcs2En+lEzhdIhERR3wjcwdn82uxw17pHnlrSfVPvAGLIzTsX58tWHyJwdOblhf9LERk6ye5U4zSWTyzapm1Z0XKH/KIjLnZ3w6s5xlzdCr9JXRfbFuO5HPjrIz7EumgH7dLgOgt1kiFjtYeX0m4gvknYubrwfxu000nC/qkPMqHIeFBk1FWhF3pnuYXjjHhxQtqiltCZ7qQWqhll9B5VcxHnupkqJham7EERt8LC0epnWuqiOvl/+Q6sGiq2dl64H1iA6ETBjSlpwqN+M+hzPz49q6+S+Tk8HKl2ySp28bVZPBkmTaBVRNiP7msHRp8me83TiUGcEXdI/qAQ72WeF+AoEBNkwwvhFde0yFF0q4CqY5nO+LOjS4yn3CyKop1NEifXvY3VzvYmcNQ2x3PlPwAa91QK15RoKTXik+BELYbZVd5zReizA/bZzPTP2jHhQD0OU9uMeqNrcgNDBwQKaDcmU3yOk+X6u2kzO9m83aVkb2hkGphYVMDhgyru0EqT+OxAzdZeF2lSVi0DcdZEki4MO68S9tcujZfkOf9EDlrtKGZFxeYSaK7l9EgG1is8RFB/9eidM+Erew1RT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(66556008)(66946007)(66476007)(53546011)(186003)(83380400001)(86362001)(31696002)(8936002)(5660300002)(26005)(36756003)(16576012)(38100700002)(316002)(6486002)(31686004)(2616005)(44832011)(8676002)(956004)(478600001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVo2eFhCWTdDTE9PZXExMXJSdmJaY09MWmY2SlFnZmt2SG9KQzFzS1BQT0NE?=
 =?utf-8?B?V0NqQlpic3FsNmFxc3pIZFpOSWREYk1wWE40WjFrb0hnTHZNUlFQL1RSeTJB?=
 =?utf-8?B?d1V0dGt0RnljUlR3TkZHNGpldE0wNFc0Ui9DZmdNTEYrek5DeVJqT012Wkpq?=
 =?utf-8?B?YktTUURkRExkWUxCeWxONE5OcnF1L28zYWkwRVhja3kza0RNSHlacm0zc0hY?=
 =?utf-8?B?SlUySUZKMlRzVzVBWGtrNGt4OW41Ymc5SndxU09NaXZUQlNQU3UrSnQ2VjBm?=
 =?utf-8?B?WXVOR2pqQVNHd2lSQ1hsWVJJYjUyV0dhTTlCRWdqS2s2OVNnL0RGN0ZnUVRn?=
 =?utf-8?B?NkxEUWxXdGdFaDF6UldZcmUrd05keVBPVU1uRTUrNmpGL1RkSklaWnBkMjk4?=
 =?utf-8?B?b2gwL2lEZjNWd2ZpVFdlR3BFQ0RoVEtZV3V4aTlKQmN4K2ZwWDE2OC9GN1k5?=
 =?utf-8?B?Q25tMEh1a2c3a0VZZFc4c1ZibzdwL0Y0ZnRWdG9za1hlZzZFVXVFaFNUbkdt?=
 =?utf-8?B?U25IakhaUy9EZWpyQXp6US9ESmRKbG8vL3I1eUxKcHh6bkpLN2QySFNzNkJJ?=
 =?utf-8?B?amhkcElvRDNUc05RMkJVcjEwWEJzKzA4SlMwMmZWcjBuWDh5QU9YT1ZqM3RE?=
 =?utf-8?B?dXR0TlRLeDlDOEtKQ28zRHRranBtTS9Md3Q2UXFMakdZOUZ5TU4rMXE3M2Zi?=
 =?utf-8?B?VUpTdDF0TDN5ck96RWZvRno3OWc5MlVzcHBUWGxZUjFiTzdpL01xcUlyemJv?=
 =?utf-8?B?b3ZtUVpjNWx1Nnd1Rm9SMDNGVkFURVgwR3NhZGpPam9HeElUbmhFQytIaXdI?=
 =?utf-8?B?ZEgrUFg2Y1Q2V01ldzBCYytXRFhuUDNlVkpWV1FpSFA2c0ZSM1BFQTQxMDVw?=
 =?utf-8?B?NjRCbmpVQ3pORkQ1WGR0QkpjMnUveUtya1lXZjVoZGExTjRUYU0yMHNnTk5S?=
 =?utf-8?B?bExwK3JxNzFQbzhISEFydmlEVXUrMnJXeFY2RlA5N2ZHNjgydXhRZGtpSjRM?=
 =?utf-8?B?Q29HUlBhT0hYYjVsRC9ZTDd0UHE4N3RlN2pHZWwwcjJwMzJQUmt4UVZmeTdM?=
 =?utf-8?B?cGEzc2svc1M0aXU5UHluVlN4U0lMRFA5eXFmTjRkbEF0VVF0aTlYMVNoaTVB?=
 =?utf-8?B?MzBhMHR2cWhBQU9ZdlE3cHJBSVdqOHRLWGphMlEyVExFTm1veWdjMUlCTnpL?=
 =?utf-8?B?SkFpbFZKWi9nemV1TlQ3YWZreFRZcnc0UldIanVVSDR4N2h2VXYyakxDRldo?=
 =?utf-8?B?UTV6SXpHVlduNjFPb2ZkYUtTVTA2T0FKSzVrZnZ5eDdJcjZybVowdlIxRWU0?=
 =?utf-8?B?eGVtc3l6akViQk42c3J4N3VnNXAvMFRQbXFNd0NMa1RFSEsvaE5KVUtaTms4?=
 =?utf-8?B?TjcybjZKbW55MFAwcnNQc3oreTVqQmRLVGZhTXB3RDFPNlhvdEVjSk5ydDZF?=
 =?utf-8?B?NFBkMjlYM2NKd080ckhwM1VFdi9OaVBtdWRsczVqd3Q3dUJmZzVTUDVubXU0?=
 =?utf-8?B?WXlSTFIwdmpMYkJqNXNDdTJoYytBeFlIWnIxUlJ4OHFsb0xEQU9acjNISmNy?=
 =?utf-8?B?QzlQZ3ppMjRFbXU0WHEzT1Z5b2Z5TFZFaCt4cVRGTkFLK0tDdnZlbkhaWVl3?=
 =?utf-8?B?QW43QUNyR3NHMSs5SkxQRFNMZXBhZ1hYTUQzSjJ6dkl6TnZSMTNXbS9CQkZJ?=
 =?utf-8?B?L1ZuNjUyOXdHbE1LdlQ5UFVuTWZhMDgwSGxFWjF4NlQrVFd5TXVHR1NHVXEx?=
 =?utf-8?Q?TdM3GE51q1Mct59yS+Tv5VjihaHDmS0pvNZdZDU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480428bb-82ff-4611-f395-08d94af7b5ff
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 20:56:42.2195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILJMqmrPdgjvyED7Jpi3p4Lef01gbz0QD5i4h1GXX73UVMQiu/2GtfgPYDK9eX6C3aQ427FfenHDp78x/MIAWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5412
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-07-19 1:49 p.m., Anson Jacob wrote:
> Fix make htmldocs complaint:
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:628: warning: Excess function parameter 'interrupt_params' description in 'DMUB_TRACE_MAX_READ'
> 
> Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7ed104e3756b..02bba9a202a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -625,7 +625,6 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
>   * Handles the Outbox Interrupt
>   * event handler.
>   */
> -#define DMUB_TRACE_MAX_READ 64
>  static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  {
>  	struct dmub_notification notify;
> @@ -635,6 +634,8 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  	struct dmcub_trace_buf_entry entry = { 0 };
>  	uint32_t count = 0;
>  
> +#define DMUB_TRACE_MAX_READ 64
> +

I'd prefer to keep macro definitions separate from functions. A better
place for this would be right before the function comment.

Harry

>  	if (dc_enable_dmub_notifications(adev->dm.dc)) {
>  		if (irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
>  			do {
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
