Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74498C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 16:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136CF20829
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 16:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136CF20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DB36E835;
	Fri,  8 Jan 2021 16:43:45 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DC96E835
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 16:43:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHzd8lYFKjlhUg934HaOH+RgXCM1MZe0X8I3lIlnRWtPQ01z4GWkoTx4YFCtCMUwLeGY+gsXwgvpZqUJMPq677ZKCMEamylwwGD8Jyiu0FYA9JWo7GduA1KlmpzCHOFWzYOIgzm2TbTmC8li2vaInmmFETaxrUz89Wi68vxC3zJQ4WB0J6jbMn9tfRARjhOB/D1pefJXoM78g525XbC7fKSNkKpvg3j/LVUlE1pZJN0H+z4Zuz83tjSfmeu37L9optgPHiskN4hlQuq66CoMteM8uKmS4pUGYDv4+V/JA/vE5MgyPosKorpIJXFARRn8mSfuJ9WFySf97YZTYxIHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vthaTamOJcf229fcaU8WLjIDyuUUvrvaRde2ce1JnuI=;
 b=HnlecmyhXomFUqPGaDHIpyRUGPq01hJGmMitIr2JrNA2kBw6IJ6FhxXRERiMdx0RpzrO3swnNuUAADaT2+UdWPceI9mOHzXUgd5UVhiTD9D+S7nhYTIopC/rx6Y2iJqzZEQx2dtEZQ4R1mPjkTbPu7rjn8dkGlxWl5GJC3OkYEKRhtcTkn/ffLmpzEJHOFcG7EmVrn3qbgylT9OOKzWax5iICJen0bTC4QRR1l8sXsfV3tL/zD5OLs4xUASbLG0P8W6P1f2yT4/0GytE6SmK2yCS5yuOPwXck3h81hvTLyP5gCC2ZYGcV4t0+/rhpF2KzfZG5rqC+hvOZnfY9W14Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vthaTamOJcf229fcaU8WLjIDyuUUvrvaRde2ce1JnuI=;
 b=yZCvm2qvbEsjy8+Ef79T65dXLYPPyTdyIwdOKS3tGf0/aa2c934M4DtaiiGT39BN+UGg+LEtAZlWBUkXMMfPh0NdFdhOM64TU4R1HLlRky5/LTc6F2IjCGFV9esNkmne7aeXcInX7Kerp7ms+T1zGApZmCAKxrrOn8vSlvjPGA4=
Authentication-Results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4887.namprd12.prod.outlook.com (2603:10b6:a03:1c6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Fri, 8 Jan
 2021 16:43:42 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.006; Fri, 8 Jan 2021
 16:43:42 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix build with CONFIG_DRM_AMD_DC_DCN
 disabled
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210108163334.374220-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <b516c2bb-0790-46ae-7e87-a1db62eb3949@amd.com>
Date: Fri, 8 Jan 2021 11:43:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210108163334.374220-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 16:43:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b308fcd3-5d40-4d4f-d541-08d8b3f48eb2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB488795811A33ED2DC98F3B31ECAE0@BY5PR12MB4887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f4vT5AKH8bZOH+FOKl2IuWfzM34yCb2A1KJ7fXk4oDq+94i8OQDmnrJCMAwfrrDp3g+UbtM5yqrvKZL70EpynzhpbcgZn9UEBAE6KjkF1kQCzni379ag1Viho5ZvxNdlCCY8JADzOdIFve7FE/I7e0EGjeO6iq0GA2F7fde3YTtLDB5E56HtqDari60xxPcoc8sXm7GaD5rCRogC47sowmUi+BJdf4waD7CNn0FS32vkoaNMShP54JDCNb8AAJqoly/Q9FCzP88Hr2JrJMmbNC2vmO+8xaol84mPbXH7UBMR+/9JK2p9oSnBBKAURoS/7Hy+CWDSIawdOE3EJ992BQadBJadQgMmN7sg4y0HlwiafH3a4FkIcvbNslDZcqWoYzBiMG27VYJPxhdXUe8UQHRe1hbs8m0h9eZ8XOCnFbHo9ODeRhmV2MZuUIjnhq/DboIe1gsd2y+HVtv+yDbeeMNQe7htwT+zQ+y7hW78bPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(478600001)(2906002)(53546011)(2616005)(5660300002)(26005)(6666004)(86362001)(186003)(16526019)(4326008)(31696002)(956004)(36756003)(16576012)(316002)(31686004)(6486002)(83380400001)(8936002)(66476007)(66556008)(8676002)(54906003)(52116002)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ak9uUkV2dzljaTZkbTlvc3YwQVZyamtlbEkreDVCYzBSVGdnNDI5ZExsWkky?=
 =?utf-8?B?Z2RvaDNoNzJZTlB2dE5yWmpyVUowejJjL1A4Z2R5M2pFSWRGSG1WVGMwM0Ft?=
 =?utf-8?B?RUNESFJDa2dhV1Y2TU5VM0w5bmNDdzhSMHRTb1AxbFJSd1lhZVorcGg0SjJh?=
 =?utf-8?B?RTQzSU9QRkRkR003dzlGZVBHVVBpT0ZpU2YrU1Zxd09Mc0hQTEtUL2N6RVFQ?=
 =?utf-8?B?UitROGxHSVdtNmdVcTBWR0tvU2NOMm5ZOXZxTytKMm5XL3VZYVhTLzR5WnJ1?=
 =?utf-8?B?cU1KaU1EMm1xQldubStrblpNeE16STNYNE9Nd1hNOVZqNUZRN3llaXFWM09i?=
 =?utf-8?B?cXk1WE1TSzU1aEttUzRjQmhienU1ZWY1aGNKaFZJYkFWNGlrUlNZRlROOEoz?=
 =?utf-8?B?dElscXVxenhKSWhPR3pqV3ZlUDYxTDNOSitGbzhueVJIVitadVhLOEZQMm1r?=
 =?utf-8?B?NElBM1BhcUlrL1p5QUprS3FibS9uSDRNenJvZUFDNWc3WUVXRkYxd2tmNC9L?=
 =?utf-8?B?WEpIV0FLZ3BHa0NpNUtGTk1oRDZ1TFlmTWhLdXZ2V0lwNEFOenM1TTZTU005?=
 =?utf-8?B?NFJXTncvRk10QjFFSzJTeUJ1SDYxRXVjNmQ4SGtNMTR5dVNNam1iNGpKa1ZU?=
 =?utf-8?B?VVVoUFdSUlhCMlRxbTRjOHJjZEU4cWovY25KV3ppRVVWQ0gwUEJkYlR4ZUNk?=
 =?utf-8?B?UzNjeFBaWDl4ay9hVWM5QVdiWUdPV3BSU3NwN0VoRVhOaVZMNjBHZ3V2QTND?=
 =?utf-8?B?TkY5eWQ2U1RwZk5KMWZoa0Nhek9MMTBpaGpzZkE3NFdnOG9iRzlsWVlWNmY5?=
 =?utf-8?B?aUhMY20yYy9BMmg3Ni9mWG5tQ2RqZWpwZlJDMFVBNFd0ZlR4cGdzclBCa0dq?=
 =?utf-8?B?Mloza3d4RElmWVgxU2RTeWlMYnY4K0c0TEdlVG9SV04rR1dOOWduME9UYnk4?=
 =?utf-8?B?Umw0amF6dnUvZkh1QmJlVnpNSk1UWjhxRDFoSXJTam9IMFRUeGZueUNwN0xn?=
 =?utf-8?B?Znl4c0tvNWpNWmZQUk1qSWZrcThBMU9aRmtqbUQ3cHRrMnpZcy81UjFTVkM3?=
 =?utf-8?B?ZUxtSnRCTGNwNGtISmxXRVNwRC9DK3BVQm8vaWU5M0hjeDN2ZlB2YW94YkVB?=
 =?utf-8?B?SXU1cFgwSFBKejArekVHVU9qT1VmUUxVTmJRc1ZyQU40cFU0SjZmQWI2bVAv?=
 =?utf-8?B?WDB0dUM0RUVlMkdaVnJLTHhZeFhCSnR6MGl1cm81VHlRT1VPZXhsSWh5eE9z?=
 =?utf-8?B?YzNRaEhxbzJ5U0MybHlaN1BZZ1R2WmhxNEdrcW5sY1AxSUgxMmhvbi9UaFhj?=
 =?utf-8?Q?s3Vpv2HD6eRhMuhhWIhwGXLBSX7IPrfUkw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 16:43:41.9822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b308fcd3-5d40-4d4f-d541-08d8b3f48eb2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8p6uenilX92SrW5ETZyMQYuSOy/pa2hGY7psAPLmpFqmFQbqBluj8TDj50g/RcP2cDlgW+XXPapf1OeVHkPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4887
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-01-08 11:33 a.m., Alex Deucher wrote:
> dc_allow_idle_optimizations() needs to be protected by
> CONFIG_DRM_AMD_DC_DCN.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 318eb12f8de7..2dc8493793e0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5490,10 +5490,12 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	else
>   		dm->active_vblank_irq_count--;
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>   	dc_allow_idle_optimizations(
>   		adev->dm.dc, dm->active_vblank_irq_count == 0 ? true : false);
>   
>   	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
> +#endif
>   
>   	mutex_unlock(&dm->dc_lock);
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
