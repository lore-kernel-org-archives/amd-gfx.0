Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1495C61029
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1495C61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 895346E22B;
	Mon, 13 Sep 2021 19:25:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA576E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 19:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7/0QWFrXvlIIJUxAwJh48G//OYKA+Pxc0FSXG95nOcCqiDY52p1dEX1A2x4ro/1fQKR2GBP2PHmYnLfnT3t81MQrR2udDfIUW0fdkcrklbhP+M/F7GqtLq8pEIiWIKUu/RPEHmDU/BiSIelGtKwQh28enAi8yM51ujTUFzWVbJyT49M0v0hFOnYMEvuqZmPtZhkq5nbWLTYKdd3lTVSz43EUSRIFUiTt+ZNQeWq71m7XKAGscrUH8+Jtc2NymquQjiS49Q8jIU0xS7eMDnGM0xfLK7grtJ9gXJ3zPLOvjFP+I3XJ+fclKUGevdzHO0ii/gx1HS/TDd8vC/teEHNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=2px3sTTT5nSXbSuZgImJoy7BfbiAQX4CPXDTOukYjto=;
 b=Iewu+3dmozvpmcUqfVsCSt8n58ukB+U0zVqWqivALkv2Nii7oB01PXSBal8PDMENA3O9JDn5MKmGqq8DlYYOpCfgGqAaR9p7XUCrnTsRdC8vLMRNzq7UfA7is0qzPbEB9vj57lOtD/MKvburqfEC9z9O/EawB+LfR5AHq8p4xNILt6RrM9exQNZoi3gfUkHCB7xgSWynTq3sWeeFDzB9AE6mNGfNiH/RAS7AHm3/Zpm1CGq5S8qaMz0D3StswmIUvVrFJug9u1VXv5E1TAePgloMFUwD1OfvzzrVHB0Xl4tBr5uUFF08DDGDrQyXq3mRzC4NeMDImUIIuw0ga8Xjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2px3sTTT5nSXbSuZgImJoy7BfbiAQX4CPXDTOukYjto=;
 b=3DkiC9sqzbhwey/hW/mtRACJRyebO8tRfCU5jwMX3V+hWCKqJl7bYxriXA05XrSO4PY8caLWR0S4Mp0/lpwwWqvAfy2f3VcqOl8nLLhpYjGEH0AxAENCfu4bT18DGpSPXs1AWQoEAH9bRCN3rmd7/d1o/qv6WEVMRUIHV9xrksg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 19:25:56 +0000
Received: from BN9PR12MB5180.namprd12.prod.outlook.com
 ([fe80::3dc8:1475:7c64:6221]) by BN9PR12MB5180.namprd12.prod.outlook.com
 ([fe80::3dc8:1475:7c64:6221%9]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 19:25:56 +0000
Subject: Re: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Aaron Liu <aaron.liu@amd.com>
References: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
 <CADnq5_NRi4V-MPm-5JWVbPEtAJ0n7pVvL5K+Wonkvr3YXDoTwQ@mail.gmail.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <36e271a5-0cf4-39e3-401c-2621de431332@amd.com>
Date: Mon, 13 Sep 2021 15:25:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CADnq5_NRi4V-MPm-5JWVbPEtAJ0n7pVvL5K+Wonkvr3YXDoTwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To BN9PR12MB5180.namprd12.prod.outlook.com
 (2603:10b6:408:11d::22)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 19:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b222e048-3ef9-45b2-4b15-08d976ec4f35
X-MS-TrafficTypeDiagnostic: BN9PR12MB5212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB52129BBC1C3EFFCC89771330ECD99@BN9PR12MB5212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/t29mePMG4QI6cf2f+e1LlM0a33ndn20OOonGndUnbMpRRmzJBLaqSCxliUr8z096WPzpMWuGOo/kKAEipZ1h8nPiEqmRGbUSEbGKFCC0OYBmBEUzpLiyXIfaWDnPtjEh9w6f1emL4v88W3YGF1iEijduFq6jx+LI4cMm2fS2Jas9m2CblMn2tCGwpKFGQB0sRV3VA8lIt6cizP7I3S3fBs+0VyOXGXmCX93yZteAec7EKEj+gsmpPOjywuNEGkTzuT5Nz3RZrgjfVtEkkfhpdA2K9FoLZo1RHwLYMnODxtCf3hfeoOs/v2Enho814aJghAxUXRmVHaew1KwiKuN4TUthH/xqYzxPBaq7VqSCVTZr3+sIHSpaPqrtup0X6VTfi1zKP6C5FTxtrt87ranGI9SLbJnS7dA7GaF+db8fMpq2V6vu8+gj9qnjdqEtymPjSBglOxw6YmvcsgAhxoniptQDP9NyjGe6E7m5v2ZPVocInDzB3CLTs8yGHgnF10rFjHl3uixwLpJvHEE3ozLJLeJBSWP+uvntyCPVNmUvLwlTEnUqzFSIVGhKxEJX7jfJnizzRezu41lJ3E65fT5K+7jaoKfx1VS8bbDzlrBPaq6b8Lyc1I4PnqEqJr/et05dPh2azjLea2r8jODaQteroG7DSWwqZh9gaABmUzdNFvV8QCvI+gJxDyJ3eoCk25Okzby/Ibk/Ph1ckAjBhXOc9N3KyX9xE91LSowGIa5kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5180.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(66946007)(54906003)(6916009)(66476007)(38100700002)(66556008)(31696002)(8936002)(36756003)(478600001)(86362001)(83380400001)(8676002)(26005)(2906002)(16576012)(6486002)(956004)(316002)(2616005)(53546011)(186003)(4326008)(5660300002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RWb29RWEdDKzlYTVE0TVdPL3g2N3BSbmR3N3JwZ1E3MFVJSklBWlZrSzJ5?=
 =?utf-8?B?eDFBaHdxRndIWDNwTWdER2F1WnJzOGtzdmVMVkNnM3k2YXRiUnVDNFlwV1BH?=
 =?utf-8?B?QVJNTDZyK0dMdnpaMU5BWmdQTTlFR1BzWWRZVzZKZUdrQ05xbERjS0ZZZW56?=
 =?utf-8?B?WjlwSjV3eFNFN2JUQUhGMkk0UHJZbTR1ZlR3MEl0eVdoUStxR0pBUkM4NlIr?=
 =?utf-8?B?SXBVQ0t0UllQWXJ3ckRxVFlKTnV0MHpyNE83Nk1pbzBYalc0ODJiQi9PNGE4?=
 =?utf-8?B?ckRWMmxPT1FFMWpLd3hybDlmQThLSWZoRGwrL1F1eTF5bVZoMEFpVEZFb2Z6?=
 =?utf-8?B?TjkvZEZhWFRTa3VOeHZLanYyT21MNG9MdHV5UG9IU3k1cnVjaTdqdkN2Q1do?=
 =?utf-8?B?T29WTE45ay95UUtDY0FYYXBXb0pwUnJlbVRrcGpWTHo1a3gyajd4NzRYbzFG?=
 =?utf-8?B?K2RWN3BjNStNbTRSb3ZYck9ZQTRkSExmU24xMGZZRWQ1ejUzTzFVTW1oMm91?=
 =?utf-8?B?NzhqaXpOdU5ONUlzVmRSWVVsMjBrSUhxWWgvQndRUTVQNEtjc1BtOFdyR3Js?=
 =?utf-8?B?RzAzSFJmOXhQdmp3TXNDb0lITzhjRG1VY3hLYXI1SWlYYmE1VVRyOWRYUURD?=
 =?utf-8?B?aWlBZlpid1Uxa2xQZUJVV2ZFWDh3Y0dLV2VBSThjaHFvOStHR3g0MmxpR2Er?=
 =?utf-8?B?K21ENXNIbEFtb0gySWQrSWF3QU1iK2tSL2FBSkw2WVBPZlFCL281RGx3L3Nu?=
 =?utf-8?B?c3RVUWs2Q0dyVWRjTWFSQ0lNNFdnd3JhK1RyZU56MGg0SURjaU51MFNLZXpP?=
 =?utf-8?B?bWI1UlNtRUNoTkU1eDZZT3dGZ3FDT3l1VHZwSWwxeG9RTUlhbDg0VjRLV1VI?=
 =?utf-8?B?b1NyTjB3QkxnYXBLS0tiK1htQ09nOFhHQnBibjFrT1VOZDM2aFgzaTFQR1hw?=
 =?utf-8?B?U1NNN0hlbm52UENYZDRwR2g1TjNNU3p1ZnBrdlgxamNRb0pIelcxSXk5OVNh?=
 =?utf-8?B?RmJaQnJhUEpTV2wwMTZkNmlyd1o2WjRVM2xEMEFxK0JsblZXWUltTURLK3Yz?=
 =?utf-8?B?K1M0UHVETmtzZ2ZTVllLMGdqajd6TWtsWHNab21sOEl4WExEeDdrZmVRODdR?=
 =?utf-8?B?bTQxbjVjYWUxRi9sS3FxdWJVMzZaNTJlcjlVdjhyUEVaN2dYaXZ0dG9vbWhC?=
 =?utf-8?B?WWR0TmJuSFNvNUlJUkZBcmVGR0tNOGtBLzgrVGhUa25CZG5wbVlsNVdWV2hz?=
 =?utf-8?B?MGpsZ2xScElyNXdzTFNhb1c1ejY4SmJOS0dSRFRHTzUvd1FtcGRRT3J1ZU9l?=
 =?utf-8?B?bkQ0Vmp5UUY1Y1RJVFAxM0JyZ3JEOExsMGdLSTlCU3NlQnpSMy9lWGU3TWhU?=
 =?utf-8?B?WXBjcXR4WEZkZGsxbTBCTnpFV2lpMVdwanhkQ0NlOUVjMnN0aXIzek9FRWUy?=
 =?utf-8?B?QWlxMUR6Zmlzcm1wWTFUYWY1ZDNLMlcwVUlRTW9UNDNhQUVhcVFJUDdkM21u?=
 =?utf-8?B?TGNkTU1ma1pNN0duQ2lnYUJrcXFJMjN3bWIvcnpOMFc2NnpLMXNrb3h6K0Zx?=
 =?utf-8?B?OEZMUlN2bzZzOTRHNlU0MWZqdzFtcmJwY1dZWmxJdEtWaDJkU0RmOHd4Q0py?=
 =?utf-8?B?bHFWQUFLbXc5Ylh4NVphZHN2TWE3dWo0VURvYnV3bWliM1ZDYTVQblVNaUFa?=
 =?utf-8?B?V3VydlhIYmNETmVKdGxoMS9Lb3cwTjJZSUY1QnI3OG1uSzZPT0E2ODNWMVJx?=
 =?utf-8?Q?b4o4pNIUDtJiOfXLKUXmsho+ZvBa35rF8YnidBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b222e048-3ef9-45b2-4b15-08d976ec4f35
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5180.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 19:25:56.5556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRmkbe41SL92Y0ig0Sef/19m3n38zmqlNAfhOhe32BngJM0qokSoKLR3lIwjZfuJsDr1O9C4J+EhCpxgzDFkpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212
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

On 2021-09-13 3:13 p.m., Alex Deucher wrote:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Can you add a fixes: tag?
> 
> Alex

Sure, I think the relevant patch is:

Fixes: 64b1d0e8d50 ("drm/amd/display: Add DCN3.1 HWSEQ")

Regards,
Nicholas Kazlauskas

> 
> On Mon, Sep 13, 2021 at 3:11 PM Nicholas Kazlauskas
> <nicholas.kazlauskas@amd.com> wrote:
>>
>> [Why]
>> The "base_addr_is_mc_addr" field was added for dcn3.1 support but
>> pa_config was never updated to set it to false.
>>
>> Uninitialized memory causes it to be set to true which results in
>> address mistranslation and white screen.
>>
>> [How]
>> Use memset to ensure all fields are initialized to 0 by default.
>>
>> Cc: Aaron Liu <aaron.liu@amd.com>
>> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 53363728dbb..b0426bb3f2e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1125,6 +1125,8 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>>          uint32_t agp_base, agp_bot, agp_top;
>>          PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
>>
>> +       memset(pa_config, 0, sizeof(*pa_config));
>> +
>>          logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
>>          pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>>
>> --
>> 2.25.1
>>

