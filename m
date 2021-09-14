Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9E7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:03:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3804C60F6C
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3804C60F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A8889CDD;
	Tue, 14 Sep 2021 15:03:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DBA89CDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 15:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzrwVPT8ZGuSLH37yPlWhKib7ezOYbBcofACNhalKz/o3eErkl19qm7u2Jevv0KrtLHC1JOTMlIHicV36k4umKyv3EZdmmgAH9j/wvpx+vFyPySVTqGNM9M7JnNKt66X6/bRNV6hNA+y9nGJdbwhNZ5x4gTKEXl1+M5ZyqPgoDbaAtaCLFqDk39vTl/g2PL5eedKa2+wS5rJWX1nyVZLgUEZ+24uHBXIds1T6uOkCvYVj64qDhRZyyvrPo2JHcwclX1Dd4fYuWB+NhILjfLICMei75cmhH9DwdbbuNf+kuex0XFbCehv3f943G0Df0e1PUDF/etbh8AAxr6sAHqxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=1ggZyhMmCTrryMT6vIx9zudvI/rXs9l54XR1hUGIeAM=;
 b=e+UEpiDZf5bVnZU4RiYqhkmDe0YG/celq+IOMmzmMPenyv/9s0XIrj4TatRJl5TNRHzp3tRFQwB3qF/6Nvbfg4iZVYuIkNduSVmAo9ZiP4WvP5vWPDeX15tXrN9iJ7oHtY7gqwjx7Mxw/BOumQO9yQxhpg/f4wsrxbjREH8vHp9fD+CVQ5eJDwBklata3uY+tjdJipKd1RrnyExcxgsMTPZoLGkWp4Pi7ta2QGzivJ3Q+6js+gMLMhk84MKIv4zPebhoxG9VssuWsB4/vqyrdlHOIjj9fmIXJi2v/ubrj0rpJCfunuom/2DjMwYpXeoEnyIz8dAt7gUMmZ6BpS4PRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ggZyhMmCTrryMT6vIx9zudvI/rXs9l54XR1hUGIeAM=;
 b=a9p991+C1wi5zkuWKJtTgPyq+QAHsyhePwGO59cCmjEK8fof/jANzoibLiIeIDw09QP1rzgHCWuSnMLdFp9hH23VRS8dHttyLJ1k0LpS+mZH0mle6dmqikg3ZWT0VIeZWwHdWkSf/eo+ADw1HjQzL5UTYEUEviZJZ3q05nRtxa0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by BY5PR12MB5557.namprd12.prod.outlook.com (2603:10b6:a03:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 15:03:21 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::384a:ae5d:717:8ba0%8]) with mapi id 15.20.4523.014; Tue, 14 Sep 2021
 15:03:21 +0000
Message-ID: <5b92fc78-2875-4780-1bfb-5ee1f12eae67@amd.com>
Date: Tue, 14 Sep 2021 11:03:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
Content-Language: en-US
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Aaron Liu <aaron.liu@amd.com>
References: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::26) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
Received: from [192.168.50.3] (198.200.67.104) by
 YQXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 14 Sep 2021 15:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d0d821d-ea25-4a5c-0ba8-08d97790cac9
X-MS-TrafficTypeDiagnostic: BY5PR12MB5557:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB55575186FD9400BF464A211E8CDA9@BY5PR12MB5557.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdTktUinMJF601Qc9/2H8paeMjZiOGa1yDuTXcy4cDEp+2mErWjIxXK2cr2DhsHpiSs+ueu8qEyK2OAVe+EukFZtCXxlvW1k2YGBlCat+tn3Hx1iIqDAzxOlcroDjY89mHWKnDr/FfWoQZOIsQEHvdQKn5AAm4fv4Gv8mcn+SOQoGPULe9gREcgqWnv8kr+p0fNatB5///tVIdMT5L3+ZDly9TEu/ama5Xex6BIt7X0uKDyJ8DaaUvs4JRh1gn0fS9dMK5Aotx+RW11sk4rpNaULlFUIFgyrUa8FtYeYxAPpvbQ7GH/QWjo8xLAVmBDTsx4NFiTVY3UbTHsSlblxCYR8+cpdeHyWPZWi7lg0m3Qosdxmuqs+Ila6dn4cziT8hl1qOZHlvCQHzQLa3nExyzfChxeGAP0yEd4AwjiP+a8u9BfL0Ve/LBfT4jUMpO/naf2+iHFQuoGSz5FwT7UVT1BJWLpjKmbgybGvmLgnOrejYGeV8xzQxlpqlN+MbP9toZmfkgMVZEhaRTCz2T+JumwDcC0jC7v+gzu8xI5sWHrhwiMXavt1XvC5ahc+6mn1a+0x27cfYAgFTxK5vbPAsxhU3aIiwUcnOMqtBHZEIiwOmdPoyCo/m96btsQVJF/pu8Ky7ucHhPd3uvr5EwtKlP8hRagSHlSYlOXvDv+GKaRgyAiNjZYFr7XWUW2tNP22jTO4VGEeEu46p/b556TSYYodU1w/eECrtkFw3zfLEoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(31686004)(38100700002)(4326008)(31696002)(86362001)(316002)(5660300002)(26005)(186003)(36756003)(6486002)(6666004)(8676002)(8936002)(2616005)(53546011)(956004)(66946007)(478600001)(2906002)(44832011)(66556008)(66476007)(16576012)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDVXNm5NeTc3d2ROWVozWjRLaW05Y0g0alYzZ05wQWpidnJ0L2F4WmFhdzJj?=
 =?utf-8?B?cVRPWHhUNHBWVEZncWxqRTZVTURaZ2hCMkFwY3M0TDZuanpJQUxQVWxldzRO?=
 =?utf-8?B?Unlic0pPSjBLeTlmY0IvVjdZSUMrV1N5akUzSE9mRTZncjJLbmZmc3dMTzhN?=
 =?utf-8?B?cldGaEtxUFhCTFZ5WDM4MUtkc3lWUm9TQVhWMXRIeDNqVXpDSFFNYVExbFhQ?=
 =?utf-8?B?OTBuT29KYzNoMVdYbmNXakdYSXVnMWd2Q3ZzM1E0VFpGRVJScDZsNEluV3Zz?=
 =?utf-8?B?TGJUUzNEcXFBWEkvamM0RGlzNWhLYU8zb3JrM29xZ1dNREo1TndyNmJLNlRj?=
 =?utf-8?B?UzVrMmhqeERzdXliQTdabWVlSldBN3g1a0l3QVdTWU1ydHV3N3dDVFM0RU1s?=
 =?utf-8?B?RTVQbnNKWmZBaFhmcVB3Z0YrcDhhSWdneVg3TE8rb1cyWG5KelJJUkZMcGRY?=
 =?utf-8?B?cDMrN2lZd3Z1WUEvZWIzUXdmSFNOQm13ZXV3eEh4SnVVZExucVZpUk9JM0pR?=
 =?utf-8?B?NlZLOGJ0cm1wZS9jYWpYZnZYenNPcDhLb1dMMUsxVVJsZEExaGd1WCtEOE02?=
 =?utf-8?B?N0dqVGhjV3JUaXh6dzNvNlNiOWNTSlBSamtlMmlwanlKWm1icEhKMHpBNTU2?=
 =?utf-8?B?MHYvUUR5cDZjbHJFeTJJd0Q2L3FaUDAraENnSVY4TVlUa056dUMzaXI0QTdG?=
 =?utf-8?B?dTZIaHd3ZjhCR2JYNCtqUFhobnB2UHJ0TlRXVFprUktoRnU0WmdValp5eWZn?=
 =?utf-8?B?VjVBQU4ybFJLSXhmbCtYREZMay8vNHhUWGFrNWpsVmJsQUFLTlYzcElObGlz?=
 =?utf-8?B?ejdyczRoaUtwS1lENGRReE0vSDlJSU1uV3BlOUV3UkNpOEVPVGxKY3RsaEFt?=
 =?utf-8?B?dFk2MFVKTmEwdG1GZmF4K1BqQlNWOTg4eVdXd3hYZ21oTklmeWNjaGtqUWQ2?=
 =?utf-8?B?aUZqVjMyQmN0bXhLTFl2WnNYZWlQQUdKYkpSN1dwY2laTGF6VmowTmNXa3JU?=
 =?utf-8?B?YXU1YUkrSC9sT2hVZHVldG5zNkRNbXlTb0U0TG12dnhraVdaTG9qRTFTYVcr?=
 =?utf-8?B?bXlKeHBjbDRwMzVLSmd1cWpnQ3o3TG1jRk1uL0NJUGlNWFlkQmRDRXRoK0NM?=
 =?utf-8?B?T3RIWGJxZjlZWTJQcTc2Q3h5RGM2WE0vU21lZjg1MEgzOEdSRG5lRnFJdEgr?=
 =?utf-8?B?Zks5SGY2SE1qcWZ0ZW9LSnRXcy9LbjJXWDVLaVF4MXNzbFpBa3M1d2FsNmhp?=
 =?utf-8?B?NFc3QlU5Q2VqRUpYSXBRa3p6TmF6azVKYUovRUY0a29KTEZGZUorMGwyMmh0?=
 =?utf-8?B?eXJROUk0eW55VzJXNG5Sa2Zud1pHU2RVQklOcmpRV3plUm42aFNsZ05FTjdD?=
 =?utf-8?B?N2N5citPV0FoWVBBOXZwVHJ2SFR6ek45TlNydWZxdUxIY3htekRtRTVCbWhM?=
 =?utf-8?B?YUhSVU5DSlA4UktCUEliWXJzRmhKaUpINjE5VGZPcTE1bFRmOWY3dEtiRm9F?=
 =?utf-8?B?WEFpUkl0OTF0bWxQYk5tTWJNSmFTTTY5NERoYUIrT3E4NjZnT0VsRVM3T21k?=
 =?utf-8?B?NnhHSml1SFVMdnRBZE9kNzV6SkRRVEoxaUpZSXVyT3dGZm5rMXpYeE13eUxM?=
 =?utf-8?B?b1h5L2gzOWVIMXBXWnZxR21WWDQyS1FhYUdOSTl2MTE3a2tNU1FwQWozT1dn?=
 =?utf-8?B?YUpXQVNlK1RDY3ZYY0lOL2FBbXh1M2VLSEpNVHdyaEl6UGh1ZU8veHNRbjlq?=
 =?utf-8?Q?0RLlyGVbPnVuUVqF48y7a0boEtKPasUq/ekjv/I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0d821d-ea25-4a5c-0ba8-08d97790cac9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 15:03:21.3582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gz5eu5Vj6W+2ajlqNY5gk4hvNOYBdRWet7seabc6Y3UFybbSej0WV17iGn58nWPnRuHafVaIP3d8Y5jP8Qjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5557
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

On 2021-09-13 15:11, Nicholas Kazlauskas wrote:
> [Why]
> The "base_addr_is_mc_addr" field was added for dcn3.1 support but
> pa_config was never updated to set it to false.
> 
> Uninitialized memory causes it to be set to true which results in
> address mistranslation and white screen.
> 
> [How]
> Use memset to ensure all fields are initialized to 0 by default.
> 
> Cc: Aaron Liu <aaron.liu@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 53363728dbb..b0426bb3f2e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1125,6 +1125,8 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>  	uint32_t agp_base, agp_bot, agp_top;
>  	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
>  
> +	memset(pa_config, 0, sizeof(*pa_config));
> +
>  	logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
>  	pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>  
> 

