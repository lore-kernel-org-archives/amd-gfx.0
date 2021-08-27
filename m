Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19487C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 17:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCF260C40
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 17:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFCF260C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4964A6E995;
	Fri, 27 Aug 2021 17:00:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B8D6E995
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 17:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws9U/0hq8wDfOsbvXPRgBYUypDkg2G6kEe8SSYbUregRqy3Nqy33k4hnZca9Alf6Y/XeeGQcKyoZY9M+xthhL5GpfRaJlV3Jw5QdK5mOw6SKDh3Pp5ZUQyRNCXferFZlITx/xfS/S3v7k611pVAsPtvlrvh3ooSx68W1UsqkTTF1BcE1kGcrWt3f4ojQ9vgKsBa59/XxkNlVsk5lsccXxwnYb9W21WzCQ1ghosnaDzMu7mpSiLgdekfgc/5CZYZUlyKLQMbjgFWp9fheZpaIwgc9asQsK8bYWBj4fdDGpTU9KHISm79V8lGJZN5h0E3EcAJY6s96bU7BeahS0IKaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZCfr/bcA1mvaY6qYguzrqkg+YZAfrmQDTTCKhokaxs=;
 b=dv5jUXZCzda5N7MwBF8Mq3OglnbVNz0YnuItuvc8kT2HaJ4u4bYubMo2Jsb3nYL/Faxc9Lm0p7gYyo53Oyo/Ox4RDf+qLVu0+Q6HmKFbFlNi0Dc01dNfe5gVscRX5yHWcJ6QSfHGI9X3RompdQU/E+4FyvedoX5LbcV2C/SZgfhzJXTFpXPswcLztnTS78LawGt/a6gmtm6ja/PcjwzFUrVbd0h4tkvkL+ZUj5CkFQqjSJrx0JOPZ+gfs4lX1D+Tkffmoq9ij37MIx0UrSEREy+UboHSjXndgMuUoDDMnEingEc151UpxuR4yzH/OnmGNOUF9OFSQxKeSmSA10t1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZCfr/bcA1mvaY6qYguzrqkg+YZAfrmQDTTCKhokaxs=;
 b=prLp1J40SJrmoM8/gdx0DZiOQ2vL8KYL8Lt4N2JGnLv1tbA9zybP5hSSLju84UNTFJ/7XepJeFPnooXNtDZmK9mTMWJCnEKceN9fOCy1f78E2cdQ0NDIUc01SkdnVQzxCgveNh3LLR4FZ0Qh5zW8rMXpEp/RbArQIZE1UFLOK1o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 17:00:25 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%7]) with mapi id 15.20.4457.021; Fri, 27 Aug 2021
 17:00:25 +0000
Subject: Re: [PATCH] drm/amd/display: add dcn register DP_MSA_VBID_MISC for
 dcn1.x and dcn2.x
To: "Wu, Hersen" <hersenxs.wu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
References: <CH2PR12MB41517A80B79301CC995E6977FDC79@CH2PR12MB4151.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <dd176f91-a686-2f0c-77d8-1142f5af9e5e@amd.com>
Date: Fri, 27 Aug 2021 13:00:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CH2PR12MB41517A80B79301CC995E6977FDC79@CH2PR12MB4151.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YQXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.21 via Frontend
 Transport; Fri, 27 Aug 2021 17:00:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0a9e543-1e22-42fe-899b-08d9697c29ab
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5425873C0D67DE8BA0A74DAA8CC89@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iMrO8uJ4+Hxc09kjdSTqa0YclMbTV1GPlh0KAUlOe2vEBjLiBiHJkQ6IkEQXH1RTEWMHJL9NCHhNR+QeZHOkxkfD1r2NxMpMWT8gJRFguZAh93Rsw7WVsaVtgx9qOIgqGG1In+gn6jmDhWhWIcWnccqXRkoAwWwB8uE+Q0FkcldFN9jjzYjd+rIgMocLMAvAWev/+1g3OTJWcU/vLBrAZHZR/IKjlJD8PrYg9+gbT5JxdOw/lqJkVFk/mrBfOEyEWsgPsem7ojXY83zOVM2/bsap+Kob8qNFF+yEXCvUliix6b008LGV2SCVRf8PWIdnrU1xl3BNhbegQ6ipDnQKmYqRGgWVsCIFLCovzWXQfKhCh9TwGvZ0+93jYmkRnoxmYF+a1CzqDSzfkfVXIKq4W30ZZrO8vjSoJ1IcXAzoLgmZXM4kaOPJMw2zZMi/y2E8E7WIA5xD38sIExhykvHjySuhoOwxdGR+L5//xt5aSDGqwPc+G/erZ9nMsDlPF8HLRWVVjNuKFQ6Wn89YEsPcLaMcHlvwJBX4bwZ8Bl3RIgBDAT1NpwVjT8bBXRqGVHQZ6ypBtRxrMUsebuk4TphLN1XIbzYqKWtAp2oG/d5dgyPp7sPQrAi5DfoMI8t6Sa5IDzi1yYB6KItGHlI3TICY9eGlr593rXcDor7QjURauFiPcXkERK4FqcT/fSIcQQSQ9hqEq7xhvkdShoVVDNQP1OI9iOwwZrB124DYIVT+IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2616005)(66476007)(86362001)(16576012)(956004)(6666004)(26005)(44832011)(2906002)(53546011)(31686004)(31696002)(36756003)(508600001)(54906003)(8676002)(6486002)(110136005)(8936002)(66556008)(5660300002)(316002)(186003)(38100700002)(4326008)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?4DuHxT4sIq0cJwKDsylyHnFs1I8XGJRaHNUZyIZctztCZRqtjCUsUGkw?=
 =?Windows-1252?Q?b32DQ/NaCo8mGl6E94FMM8xOLz1MbRTN+TdlCfANYxFl/o1rG3Z2nMyJ?=
 =?Windows-1252?Q?BwD+4v/AxnAylAvbIGw08ypDOG1mflmhLj/4+Cd859DQLrn/rrs4DGRO?=
 =?Windows-1252?Q?SjRoKiHBU04PttO92Q95bDWtu5IEGsZ1UvRuYgEXoPBH2scUPbQkL9LE?=
 =?Windows-1252?Q?9zUvTbbZIS5vaCl0Qy3NBv6Hmj1YscLXM1qgJ49yd+RR2tpyoJtX+Fy2?=
 =?Windows-1252?Q?bxcvyF2n7qdBkdy5KaIjc9J/yINnYoSfqRuXGU9TmW/VVZ/sf2pKafdp?=
 =?Windows-1252?Q?vffgT2v7PCbPkKrXLZbXilfw6uymHrUkvlWUqIEUIVWBeFaTgNQfRpfn?=
 =?Windows-1252?Q?/Jwy304VhFzn7cYIRvaWRcFIfVrObGpjTK3ulFu1or5zCcwV95LohwH1?=
 =?Windows-1252?Q?2Ap1s6M6zSbWDnHkuWTVLu9lT6VQFm3ZrncdiFhjmXhJe02SJbix5aBq?=
 =?Windows-1252?Q?VpzvxnMZL4oGSNhWq5mnS2M9MZZwnjv69mXaZGjw4udl7I2i6K6CUZW0?=
 =?Windows-1252?Q?a33ElZCnx7EnclMyXtPZgiPvpfe6El6afu9YsoKVSQD0fPhTYdDch2Ir?=
 =?Windows-1252?Q?MZQIpZ/QluSMdAXHs2n2gpUnGUdJehFjPnFB72TLwLtx4A1Brfwd4Mm6?=
 =?Windows-1252?Q?Doo/HiZY3tiBaOXFmGbTxDKdzt36WvOeSZ+cRyeMH+pDs6sMW0QYCWoS?=
 =?Windows-1252?Q?aTnBdKT6rRFUlUGUhJJI19qb+NGPz4+YO1UaqKJ2LkE7nqI0bVV9eahj?=
 =?Windows-1252?Q?E3xICfsJf7qn5yED5igFHRu7NO4hoet7mb4Yj9OUNahdb6iJ+Ggenxky?=
 =?Windows-1252?Q?MVshfeis4jNuinpe7opjGDxBQjgGJcZBg89g9nBgkhWIW2oqVsSt6GBG?=
 =?Windows-1252?Q?7crXEYN5z9s8AJMggl51Y2+R6oW+DAkemcD9Fzd+pEvBuHmTybAnPSx+?=
 =?Windows-1252?Q?auW0/1fUwDKz9pk6PqQjknWS9WFwOUpzncS9PaLWGY8rs964x/NYnSH6?=
 =?Windows-1252?Q?HYqFabkGsDOmZE19tEb1Dunt20Qr8KNh6gD7HlF4ehSNN7WqDOqAeeub?=
 =?Windows-1252?Q?bD5ZsFestX2mwjYFFpz17X1rn1Mk1V+2rW0qnzcCEws2yOtb6Xkqp2VK?=
 =?Windows-1252?Q?Gm71SuGrrw+g1lD5O1DltQlPH9M1OY86aZtZwer2nriYEsceaLC2k/Kj?=
 =?Windows-1252?Q?GF9i5vqcpABXWUzATDwR+mTI951XlpdjHNXy24RZWFmMpegl/+S8vs4n?=
 =?Windows-1252?Q?5uaJKE4B/uZfgzXvXEwOVaSWZPMXBWh70umLThZforMIk+vj1OE7b/Mo?=
 =?Windows-1252?Q?kXTBm7fQIlgl+GZ5OI4mJNcz0DhkB2nWT+6jgPcEZyV0YqRocXTM8BwD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a9e543-1e22-42fe-899b-08d9697c29ab
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 17:00:24.8910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWQ4MSAvJWn+rbR5usGWdjO57b1QacLrVRnwpDpsK6V6Ic9nUxJFbdfJj5KfjULLDGVqoJghPZdj/Bag0oft+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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



On 2021-08-26 12:59 p.m., Wu, Hersen wrote:
> [AMD Official Use Only]
> 
> 
> This patch add missing AMD ASIC register for DP programming in up stream.
> 
>  
> 
> From 05768b78865d9b41a1d35e9f8e34901321208f2a Mon Sep 17 00:00:00 2001
> 
> From: Hersen Wu hersenwu@amd.com <mailto:hersenwu@amd.com>
> 
> Date: Thu, 26 Aug 2021 12:49:08 -0400
> 
> Subject: [PATCH] drm/amd/display: add dcn register DP_MSA_VBID_MISC for dcn1.x
> 
> and dcn2.x
> 
>  
> 
> DP_MSA_VBID_MISC is missing in upstream. this register is needed
> 
> for DP programming.
> 
>  
> 
> Signed-off-by: Hersen Wu hersenwu@amd.com <mailto:hersenwu@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> ---
> 
> drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h | 1 +
> 
> 1 file changed, 1 insertion(+)
> 
>  
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
> 
> index 0d86df97878c..35acb3342e31 100644
> 
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
> 
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
> 
> @@ -73,6 +73,7 @@
> 
>                SRI(HDMI_ACR_48_1, DIG, id),\
> 
>                SRI(DP_DB_CNTL, DP, id), \
> 
>                SRI(DP_MSA_MISC, DP, id), \
> 
> +             SRI(DP_MSA_VBID_MISC, DP, id), \
> 
>                SRI(DP_MSA_COLORIMETRY, DP, id), \
> 
>                SRI(DP_MSA_TIMING_PARAM1, DP, id), \
> 
>                SRI(DP_MSA_TIMING_PARAM2, DP, id), \
> 
> -- 
> 
> 2.17.1
> 

