Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0CDC432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE599610FD
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 17:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE599610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74FB26E077;
	Tue, 24 Aug 2021 17:17:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EAA6E077
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 17:17:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/adMKJpcYzX+RSKvWzL/XDSzt952SRjbz/Og9iWUxWisZo2HsoCkBzGqt2JkJZfkPIopGy4zA3mIeOBxOeW1q8+zTN00jSB/jjETZfc0TNlQL8ofAeDSnl5W5DDrmwOSh5k/tKns8edxcfWtIkKwOUfDCDWDoolhGj+piNB5wtJO7okHQWX95XSHsLIQ1KJqSK9u/8ird/FAe6cgFd5ypWzjrDWpmUzM/DePVtw1/kspjCXYsl1Rhp41Y//9v5EDCe4z2mCUn9sCXe4jLJYvDVH9qQCynnPuFvoxa9qG2vIeaRBSGHmjl4oSXePIasBlMWK/UzbOvMiLKbfeZjkGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5S2otXPzfqCdOaEZTuXdAE3SS2O7upM3CPL8+rGVOk=;
 b=PbZeZzeF33AHYPfRlNJ/1oAJZO1Xd00b1xjklphDmM9eJs29I0YIADXVYIXcqGy6RnnoF1bLWnuMFmxPPt0wm/puDrbtikEmJ2DuZePeGOMm9pUhGfXkMTUtqq5kBfW8U6RRd+oWY2Tl/tzyYG5d7On9CgJHr9w1lvldU8hzw4bCIvrJ1UsgyK1SNm507rz8MLAl//a4jbYFDVpG1R5ySOpn674MvZo2hudafWgvGdjz7KpRFpo4iRoF8/+dFVQ1JY6AMpn7ocCAMpvUYdT3h53E1F4cJAtDEDubYyWzzeZFoAPf84DjBy+QfUkLRRD77m6O+yvOBHViMUPXZeQLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5S2otXPzfqCdOaEZTuXdAE3SS2O7upM3CPL8+rGVOk=;
 b=PIku7L7i6+aAVqtQAImqN814NCHuNL/iJw7N19z93LneFVJ/DBTmU/T0nBUAVmVuYtD020fRBvGfLwHIhgGQWIl4U1QZ8ulmNw0wcdkZxFF411Ti4SIAEwJcMdZ7sRi92IZHvsRDmdN3qAmN32OqviPgGB4lJ5kaOIJRMf9hwOU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 17:17:49 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f%9]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 17:17:49 +0000
Subject: Re: [PATCH 8/8] drm/amdgpu/display: remove unused variable in
 dcn31_hpo_dp_stream_enc_mute_control
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210824165105.1913700-1-alexander.deucher@amd.com>
 <20210824165105.1913700-8-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <4c6a33d5-596e-a07d-e58a-2de08e21f82f@amd.com>
Date: Tue, 24 Aug 2021 13:17:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210824165105.1913700-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YQBPR0101CA0082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 17:17:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e251a762-3476-419f-fbc8-08d967231928
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475040CFFB9D4B28692A1418CC59@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuM3Vzmmgwca4IdOiiiUDZbV98EPsOx/NWSSPaZ/YSWZApLl6J5SkSAcvKNnlDhOpovEodWzHbVx46gvMwaC/5SkpqXxAulXCl9dmIi4Joxo7BU/MAUWnMdaFULS7cn+JDDbCuXC/tHIioqQP+YedoCnmNjCf0QxCV2Sv4BFfFlNkl7pFO29hBAaHDJ9QTmh0hoi8LQUG8rtjyLlNidSgkObfQmvHEY4jquS5FYrCTcCZMxCgGrtwdwVDKGYGsf3DsktP7gHTjT8pBk6VUmFPIm9WPPYBANeI2Wa1ij8igLruv0g7+8CLNxLFnU9IJrQROvQinCZK7o/oxcd9k+/oqKTI9warTYnEEUkINCdQrWfZgLT6mq/p+omj+XQr/OW7g8nBehhe0zOeMlt/LIeWvMkOIuF9wDRd3NwwZTuGqV43EzM9Nyy1FujV1y8k1q8Mpp1MZB1zbHc9ptXOq2Fg13nUtgcyaNnMrNqQlU9eOovriVXWm0qe5Wb846RbD1DvqnCjZ4N83VenHUyb8xFMvqOLVpJXSpdxt5qmnvxBxX8wZd8Qd75bDnPbXP/9tMVtSZ8z7O4sSq3ifJ1WbxR/45zWN7C1r6ol0qZE6GLAmjrBHTBqj+iSSit/G/W3G/uB9hLX1XGoFhE/v0lOXQgiaNDhiwwtI9L5EVDxDfPLGuheqhiZ0w/tK96e6n8P9Be9k+fDw6syGSzFhDkWPuDBVuHREjgT9dpD66PAhbAYUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(31696002)(66556008)(66476007)(53546011)(8936002)(8676002)(86362001)(38100700002)(26005)(316002)(66946007)(2906002)(186003)(5660300002)(83380400001)(6486002)(36756003)(44832011)(478600001)(16576012)(31686004)(956004)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpqTmhwdXBUcFNqTjNsWFNuSHNEa3RweXQ0SlBIbEV5Y0dvQTRlQlpSak5F?=
 =?utf-8?B?eURpOEcrbzRXajBXN1BYMkRKall0ODByMnhlMXdsRU5YVmZjMU9LQ1ZwTXRU?=
 =?utf-8?B?RTdjYUsrbnBNdEhNbUJNZmJWZjJCUDl6cjlwRnF1eGExUWNZRThweFhYUUVG?=
 =?utf-8?B?eG5NN25TNkp4V0dEMmJpTlZYL3NCeFR0R0JjTHRZMVVyaGRKdFEwQU5XQmhR?=
 =?utf-8?B?RDZ2Q2UwcGRsbHEyeHVMYUVIRVF0VERJbHY0ME8zZlByMHN2K0FpZzBuZHRL?=
 =?utf-8?B?QVpDQUl3MzhYdzBQSnI0WGdYVXRISy8rbm84Zi9ZRTVsVDNXQ3J4dk9VWkk2?=
 =?utf-8?B?czE3eTBBY0xFWk5TY1cydUdEN2RvYTdQZTZtV040dkJadVh6WGYzd2FpNmN3?=
 =?utf-8?B?RkQvdFRQZWZkd3IwNi9SdlFhUi81M2cxeVA5MnpXdHVwY0VyTHNoS0dsWUVT?=
 =?utf-8?B?T2lYdjlNcy9wNUI2V25LcVRwRE9LZlNQUTZONjJQODZ3dGRneE5ueTh3VG14?=
 =?utf-8?B?cDQ2dXNEd1NON25UWDlIMjBtcUdMbmo5NEIwcmVBd3E4ckU5WnRJbzVmQnVR?=
 =?utf-8?B?Q2k0Ym53ckswRElkaGxXTE9FTkRYTWNCK2RYL2lSa3lJeGNsczlUSlUzZXBt?=
 =?utf-8?B?YWZoNHFTT1dhWlZERGdHSlI3TlJrVWpsK2N3WDhYM2tSakh3akZadmU2MEpm?=
 =?utf-8?B?Ykc3WUFqV05KOFpaeDluNFk4R2Y2UHVYdXhiTERsY1ZJV3VtK3B6VzFsQlZs?=
 =?utf-8?B?WjBmOVVSOVJOZ2EwRktoT0lNYklOTUxyb3B0SE1aQ2JUcjFQRitONXFOYU0r?=
 =?utf-8?B?SVB4YmF6U0N5Q21WTEk2MXoxblI4Vm03QlMvcVQ2RlV6dGp3eXZKWDVVK2ti?=
 =?utf-8?B?alpNTDNTWWtjNFBUUW8vTG1ONGU3eG5zd29JdnRxclkxOFd1alVNZkpkQkQ4?=
 =?utf-8?B?WEJxWlZkbE4wZGFva0NFYUg3TWdrUnBON1RqSVFxVCtqN01EUGNVY1h6cjQy?=
 =?utf-8?B?Qm1NUlJsVXUvVXFKbHI0YVlBSUhSQnVlWUFLN2REZi9vZ29hQUpoMHRJalR5?=
 =?utf-8?B?Qm0rNzRaWTY2enplTWNCL2VxOGJHWWNNS3VuSjBxQ3dPT0E5RjFLRFhIVXd4?=
 =?utf-8?B?Nm81dDhaVEVmR0M3MVBUVE83clFDS215ZFZnSEJBenJmQTliNHk2OXJKSFFN?=
 =?utf-8?B?SVNZVytLSUhyMDV1TEJiVGxGamwwTUkxelYzaEUybkgrOWY2OEdOa01Yczc1?=
 =?utf-8?B?dGtubS9wTHFQbzJSdnpLRzIyMGxsQzd0cDdJSjk5M1Q2R0dKQXB5R1ZRQnAr?=
 =?utf-8?B?Y0tuSDFVTWZPb3IrdU1pSU9UQmdVUFVFeDZJdHNISDNCMndqSTFib2pvblZi?=
 =?utf-8?B?ZUtLeUJXOE9YOE0xNHBqd3FYSXBYUUs1aXlwVjZ3eDZYVVNha2t3VVZaQlIv?=
 =?utf-8?B?dHJCM2FxOW0ySnV4QXI2RUNldDhNcmtsbzZqN3J1WTRSQ1U1TVRsS1dpNGdz?=
 =?utf-8?B?c251U3RiM25wNEVGVjFMdy9UL3VoM3NWa29kNGZ2SlNUWWF0NkhSeGtHMFVh?=
 =?utf-8?B?VkxlcnZvcFk2enA0a0FMSzU4WnpQYnFaK0cyOTZRUjVRTlhnWmVwVDBscVdP?=
 =?utf-8?B?cmNhTGIydGJJUEI0bFFtbUhBcGJYR2p0REtHK0c1U28vU3EzR3NBR1d2YjBX?=
 =?utf-8?B?VTZ4NFRZNXNTdFI4ZHgvdGlicWVuWWNucVAwRlpVaEd2MjdKWWVXR3RzRkV6?=
 =?utf-8?Q?KM1O5LuyWMB02kYFe5hYIJkHAbBagxz3Pm9+GRA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e251a762-3476-419f-fbc8-08d967231928
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 17:17:49.4254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/cPtL9sUsI7DErPuDxFSmhJ4/nTAJFAK3KGn98nZYPfSdepHf4PZlk9b05q0b3ehGjdW7qvDVW5Z2uCWD1FEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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

Patches 1, 3, 5-8 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

For some reason I didn't seem to get patches 2 and 4.

Harry

On 2021-08-24 12:51 p.m., Alex Deucher wrote:
> Trivial.
> 
> Fixes: c0c9c87bcc5f ("drm/amd/display: Add DP 2.0 HPO Stream Encoder")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> index bc265ee06824..25e4794eb9ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> @@ -603,8 +603,6 @@ static void dcn31_hpo_dp_stream_enc_mute_control(
>  	struct hpo_dp_stream_encoder *enc,
>  	bool mute)
>  {
> -	struct dcn31_hpo_dp_stream_encoder *enc3 = DCN3_1_HPO_DP_STREAM_ENC_FROM_HPO_STREAM_ENC(enc);
> -
>  	ASSERT(enc->apg);
>  	enc->apg->funcs->audio_mute_control(enc->apg, mute);
>  }
> 

