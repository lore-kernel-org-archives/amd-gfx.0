Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF0C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4F764E4B
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4F764E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85F56E9D5;
	Tue, 23 Feb 2021 15:24:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F8C26E9D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 15:24:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fib1livIecr5HsosOtHDCpIkXoMTDRkj2LbfEHlThzlPbBEjPCzq4L3lgVR21Om5MbcGbVX1qvtxnxkpjuFXiLKMBxLBThXFUiKnHHhwafyEfnQEsPyi3fRo9xjYOXfwFykIYB5Z5FkvPXhQRh6a2hiujjFaQyo0bWh5dZ04wsidoy2Ghuy4dEAMH3v8No+QIZf5j3+pi3YMb1ghpg1CcT7U70eDMeYRFN2nz3qOK4HJWkVDHDOrV/KKifNkPJcdIE8iJQukgWQK6q+OeHRGNupL7JaD9owBC/qDLKh0JclFW8FI59FL9hLtIZViME93Fuv1nkNHngQLWCqbSOt3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8d+fImj97pzLz0Rg4mBLs/UOduyNIn4v+EHxVzy7U=;
 b=kcC+Mvd7YK+zi0WM6C6MuFWG9ywkklGwGk5RJVqE2rTTFPVXytEVQ8bwHzFgO2/GwpEEyq/JwbfKtlkahLbVb+/lGzzPHKHmTytUC56W5W+8npdjKBMotpgpnBNuuOS6kVb5nqFo1QaHPejIheXxfAH1U5bw35Oke40OHy+N6O7KF2aofnfjwge3JzfbzSprkmX/cEi9Yj1EUfWZOawyrvOpv+oKrYc92z4KU9cvd8Fw4hNRZv/e9wAT6bvPmjiwAiZj1KvQAiE5aJyHnIumQiJA069HToeHsTRDyF3R3E3yTO45yOzcafwR/YeefdCrdOmaO9n+HFfyCAqANaTE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT8d+fImj97pzLz0Rg4mBLs/UOduyNIn4v+EHxVzy7U=;
 b=Cgq8EXNd09o/Z1dqe2Q5vla4pn21SVctNeacaipgIkMpWgdJRfs9KLFszzI/phX+VjT7oxqsofrWFpDzNjdaACp2khNqbNtEyoH2q8kYQEVARwPd8OAGDhoTxf2hYA8skGUsJcabiul0yPT8p2fJyucOxdRwgChpOZwNtBLn5XU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3510.namprd12.prod.outlook.com (2603:10b6:a03:13a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 15:24:50 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::f073:f3ea:6ce8:1956%4]) with mapi id 15.20.3825.040; Tue, 23 Feb 2021
 15:24:50 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix compilation when
 CONFIG_DRM_AMD_DC_DCN is not set
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210223152239.1323304-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <7ebfd547-5a44-bc4d-dd8a-9eb76599e96f@amd.com>
Date: Tue, 23 Feb 2021 10:24:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210223152239.1323304-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::13) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YT1PR01CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32 via Frontend Transport; Tue, 23 Feb 2021 15:24:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb1c4242-f7fb-4465-e180-08d8d80f292e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB351007491CCA53D9BB784BF4EC809@BYAPR12MB3510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/JnbiEoNJfOiU2nm7OcdpTsYzmT3PkMlV91O6CFzAFcz0Zn0W7UJ7Il2wYoLhguX3UmdbyPaQxZsIrN2W90Ygrqg7Vqnd4FLHgKcdKXH827ZAt6YxC5Yjd/Z5Ts92d1UKGfokME0PrAknd0fuvtkf4ygvf0YMY4UbvnY8Y9wtTpFXc8ZrUdYURO14VV8eqqMsT5hLRPvDy8X1YsIpYMzJbOMmh2wMs/Ve0dWuz4dBComIzIVtJgIiZn+o5gHO3sfN2AuF8tM/qm0WPOdGP6j8DOaPrjbZF9YEM/TX73pHGDA/Tt2y7m1QE9NweyTuxfgSafnG6j0mqaPlggaVp/Dmc4LfkDPtPVXUnTF7NqBKcz+OZ9Z6QEjX/Kym1VifNKtOcFf945yPB2SzhTIyEsEfanX61pcjwmVBJLqd0u/3WL0i6F5Txj/NVSgpJYfUhr5n7sPDXEgty3oGzHDVo6jgmrasTxrrIjQRP3UM6+U5VlX4jaa51HM7oj15gLDXPXViwzydaBGJvFi9b0Zyw+bcWYFUsKOfx60Z3Znm395DQZBcD8qjP5IAazF8xG9AJdXngrAHQT5xDf4QUwIp9fY1IavThJkICcsdC1hyEbhG0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(53546011)(478600001)(66476007)(4326008)(6666004)(31696002)(956004)(36756003)(2616005)(8676002)(6486002)(66556008)(16526019)(26005)(66946007)(83380400001)(186003)(16576012)(316002)(52116002)(2906002)(86362001)(54906003)(31686004)(8936002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWMwcmdYMjJZRnBPbGNTc1NGWHI0dmU1NEFzdEVyaUJMVy8rblZuWDhEZVpm?=
 =?utf-8?B?RzQ2NmxKSVBRaUxzOU1rN0ZyYWQrSVIvU3c3K0xKV0p4SEFwU1hRUHFKK25M?=
 =?utf-8?B?akFSaTFFQkhPaXpLS3l4ajFEaTA5UDVPTnhsaVhiNStxWGNWbWNmVVQyT2cx?=
 =?utf-8?B?STBDRzlheWU5MFhVK210dkYvMWxEUXlreCtiMGZkYjhiUGFQQk5sNlVXcTJj?=
 =?utf-8?B?Z1k3eHVlREVyY1g1N05CY3R4KzlNU05zalhGb3d5NHdTdkIzcGZ0dUV2VW1u?=
 =?utf-8?B?QVZDZFh6OUo1SzFQUU94SDRJQ0NYYnBqRFpUVm5yY1JHampBZ2NkRTdscTZi?=
 =?utf-8?B?ODhRbjFLaW42ZkFjNU1IbFRMdHdPb2FDZzZVYVRjWFRkNXN0eEw5ZGNHY0g5?=
 =?utf-8?B?QjErc2wwU0NoUE9pT251R0l0d2xHN1hpZ0tUNk83MkFnUmVsMnB1elZpdmUr?=
 =?utf-8?B?QytKVnlLZi9HNEZLZEt0aDdCanVOKzAwbktXSkp6eVU5ajZYS2h2MnFvKzJj?=
 =?utf-8?B?aEdxeExvTWZxazdEZ3JFUHJLK1hhNlNyczhIMGdrNEVVT2FvMnE2THJTdDVq?=
 =?utf-8?B?SFpMKzlKYjhhQjZ1cGNpTUZKbnZ4aWF5ejdmdTIvWW50TkhxNVVhb3hRNXJV?=
 =?utf-8?B?WHM4NGtGQ3Q4Q1VSaEpHU2p1b3JQcStBOFh3K0pqYVhqTXpHT2gxenBlZy9n?=
 =?utf-8?B?Y3YyVThXRndBd0ZLNndxcHZGRThyT2ZaWDE0RWkwNHFQbDdGdjY4STlsZ20z?=
 =?utf-8?B?Wlg1Q1ZxbzdiZlBmcXQ5YzU4TUxJc045cDJXK1c3eTc3VTBiNU4xRnQ4VmRs?=
 =?utf-8?B?UEd1MVFISTBDa2o1dVN6Tk5JNE05QU5DUWV2c1k3WWU4b2U5QXRsbXNvTjRE?=
 =?utf-8?B?L0FzOWRSVndrbHRnaGRjYUJxVkpmTm5vaUwvNUZrMGtxVHBwaDZoK0dEUDNw?=
 =?utf-8?B?L2R6d2x4cFp0RXIyMW9UN1ZNcWk0U0lUSnA5bmRicFRFYUxhdFladm1DR0ZO?=
 =?utf-8?B?bXBZS3hEWm5WVVVSVk9YTmUzMDBtNXVFRytVUkhnd1lsNXZMRVhhU0lPalYw?=
 =?utf-8?B?dUJoeVpKaHpubzZUMWtNUExROXI1VHZ1MzBDRTJjbnV2REpUUUd3djlLOFJ1?=
 =?utf-8?B?U2ZIV2VtTU52OHZJZ1E5Si9iUlNCbXdrRFpBenNhemtPTVNITVJ6cXpOT3c3?=
 =?utf-8?B?aHQrZzdWNEJrL2dsanUzS1VLYWZBSWd2M1NBMU82YUEvKzVsai95WWNXNTE5?=
 =?utf-8?B?Mi9oUjNLT0VuczBPOGw4WThJa1UrV1U1bUhSdHcyZFkxZU1DUUxsb05DTzBp?=
 =?utf-8?B?TXd0czVFSVltY2NhcUxHbDQrK1dqcUxxZmhidU5UbGFOVlA4WERsVzRZdEM2?=
 =?utf-8?B?c0xoSHAwTE1CRGlURGQxb3VZSzQ1SjVmdmNIRTZyTUwzV1NDNWtpcGdpM09E?=
 =?utf-8?B?clJPN0o0cU9MS2l3RXpmL0VoN1JvNm5uYjdRd0pLRVBoQmxFZnY5ai90M0Ru?=
 =?utf-8?B?YjNHa1lpeFpGdjkwb2hQcGVBTGdnTlNuWXd1bWlGeThZcmhoNG56RnZjVTZm?=
 =?utf-8?B?alY0dzdJOVVBamxLcnh6NFJ6ZTZNakNuY2JjN0paVjVEc01HZjczYjhSbjc1?=
 =?utf-8?B?cnpZRk05NndITHNOVXpjTHRmeklCWGh4aldRTFpra2lBVXBiSUoyNGdoVzM3?=
 =?utf-8?B?VDFGM1hwVXQvUlJTK0tJSHUzM1BhSlhWQ1lkOGR0MUFWWkpyOHpwVWlBSEQr?=
 =?utf-8?Q?xLl1Y3fzlfqtLYvZdyt7kiSCULm/C8DkiByorT2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1c4242-f7fb-4465-e180-08d8d80f292e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 15:24:50.3940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+vL3FfYjV7oCucJUBap874qUn1/+yX6HfPe404OUGERzS6OCeJlqt69EB+vV+hQAb52Gn7Mf2q451K3QyQT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3510
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
 Stephen Rothwell <sfr@canb.auug.org.au>, Qingqing Zhuo <qingqing.zhuo@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-02-23 10:22 a.m., Alex Deucher wrote:
> Missing some CONFIG_DRM_AMD_DC_DCN ifdefs.
> 
> Fixes: 9d99a805a9a0 ("drm/amd/display: Fix system hang after multiple hotplugs")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7a393eeae4b1..22443e696567 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5457,12 +5457,14 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (amdgpu_in_reset(adev))
>   		return 0;
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>   	spin_lock_irqsave(&dm->vblank_lock, flags);
>   	dm->vblank_workqueue->dm = dm;
>   	dm->vblank_workqueue->otg_inst = acrtc->otg_inst;
>   	dm->vblank_workqueue->enable = enable;
>   	spin_unlock_irqrestore(&dm->vblank_lock, flags);
>   	schedule_work(&dm->vblank_workqueue->mall_work);
> +#endif
>   
>   	return 0;
>   }
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
