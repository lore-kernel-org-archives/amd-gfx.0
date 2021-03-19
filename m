Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA66EC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D99261979
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 19:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D99261979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7D26EA88;
	Fri, 19 Mar 2021 19:03:39 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC206EA88
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 19:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOjNaFmhM5HKuKSZGOmS86gWVQGOaSe8wJtCF5my9jdm/0XmAxPfsqb3lajk+DFC0bBUEEOhitD8IWVxdG2U4h4g0vKLuoZNfjpM0n8jym5lTiCMvL9UCb7rAjKm0Ubxnr0v6lxx+6DfapJc6TnAll6O1WjKPdG6alCT4NT8zJPoftf8sHQiafvinQr1TqF5G4HTc7x33+Dzh+dP7WlskDPL9JGN0l9mCHqt+ITPDtSQDnzZBVSU6ooGTxJh4A69QSscp0dwUg+vCY+DHbX1Gy5RN8R4LVWC9rKjKr0jXyYnY5o7KrpVz2xl2lFkQHMAQlCi0dLKYsPqZOR6kO3WWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6FzTcQYenBKyQ+jR3t4kk86IiR0/N0IfuxqbnsHsOs=;
 b=M0XsbaFTM/QlQl8zgtae2rZ4BveLG3IT7Jp+tweyAT6NENsT5WR2RqZMPxJ4vz/FKFBzZU7AQRHBCTp6GFNSBnja1oJp5jxHwdGMtzYmPDhhAc7ojZxns/fbjFo0US/e3XsPQ5gzu3QpiStDhp6kIVHv0xhNY2czTUtsQKsSPtN8ngo9eJ+YEMZ2kfTzB5sOo76CWLiNnL3FmLOXt8utzjfKfYVn9Kto1dCUnBw3bzq5dQdIydBnkH73ReSkNBVBhqUd6DGj9Jfeg14n22aYU//UQWiHoQt3fJ34AMoxf1PlrTdwzxAdwmaz5DxorgJEGl0A+8ciPAgQNmvQo6IFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6FzTcQYenBKyQ+jR3t4kk86IiR0/N0IfuxqbnsHsOs=;
 b=rrzhCYC1Z0iyH6D/G2VMY2m207YGWHaP8yurW32jYqWcI2OGHZcBEP0ZUfI/399C9nj0OjSWkgE/nxfz0F80Z95SPkIvgbdP9VoR+o7vmrVbwBO0lMfXzGxIwbCpRCbpxjnHjSsFXdk6zfhQJtW9jw6Q/CVV4nI2s3bp92Q/agc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MWHPR12MB1550.namprd12.prod.outlook.com (2603:10b6:301:8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 19:03:36 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::4987:8b2f:78ca:deb8%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 19:03:36 +0000
Subject: Re: [PATCH] drm/amdgpu/display: properly guard
 dc_dsc_stream_bandwidth_in_kbps
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20210319021743.493548-1-alexander.deucher@amd.com>
 <CADnq5_NyRkgZ0j8GHm6u02iByce8gb8jjNfqrdV3dtXM2eG+mg@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <122a2800-0b90-b6e2-fc12-25fdc5fa09ba@amd.com>
Date: Fri, 19 Mar 2021 15:03:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CADnq5_NyRkgZ0j8GHm6u02iByce8gb8jjNfqrdV3dtXM2eG+mg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Fri, 19 Mar 2021 19:03:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a086af7e-5a5a-4d80-0803-08d8eb09b2b2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB155064641AD32296934BF33A8C689@MWHPR12MB1550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFMLKfYl9NmFXceJTtLZXBnq5FBAl7jiDs+1m2Y6R/NtsO2U7zk/Jiwgc068sYARV/VWj9FUwXDPeW/QfIWD67Wy1z1KU6KVPW9nyALm74WiKiJFt8KxZU+zh+LuPx/jweKW2VfVblkh0sRDaOOc18mF1OOgp8ace2d78+aanzWg5OsEv9sFKNZJL8rMgOpEcqH2VC8Yp5fsWFOWtvdx89YJAGTrKnUTsCwg+jnJDF4jxzMLZWKEcK8C2uQmQmVOEvRSPNBvIxbDzoWVND/JjhxE7Y126RnrQkaop4fy6kc3zoFLm8Y5RqPAYaEYTo/5UgEvpVjkuLMCorC0gxZsrgudzcbulstUz/qLNCKNhxDhuzA9ZajcHjfYOCmHDJAGcTEYWPosKvlZ3k95SrwTa8tZPD/ZSRbssUPhgabmV/1POfehy9G6E8ZlY1bLnaxr1lYP2/0iAhtAscwa/DurLkVWzINKJYnWchmxl2bJo5yL2jiyfVZl6rDJieqUM2TNTgxEcuVK9ij0CVWvE+X5U4F4bVTQoiL8N2HcpmhixawNDd0DmqTC1WOZtbva6GKPeXVhwhtcUfYTsVaFA2j3juhLK6a+SOJNouBK4gzFcv+P/S9Gc+uJeQz3oRqRsNwzCVGZfvFaMJ0ZmpA8FUG1qt2R4xJ3dMxIhtkOuxbF8PFYobZNSKpOdGN4lYxHH23UsU0G+pjKsV5PcM7+xOkZOgPD9S/4KafVbLq5GNuIgoHLfUDY8pnoHrMC2gRMOLqjyVaWDIze4OIViywrsA5jvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(8676002)(83380400001)(66556008)(6486002)(2616005)(66476007)(31696002)(53546011)(38100700001)(966005)(956004)(44832011)(66946007)(5660300002)(478600001)(316002)(4326008)(26005)(8936002)(110136005)(86362001)(54906003)(6666004)(31686004)(36756003)(2906002)(16576012)(16526019)(186003)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cCtIYlEyV1BqdEJzTlBLL0pWSDQ4d0FPK3JRcnVyeVBkWGFJcUxRSkRHTzNx?=
 =?utf-8?B?NjZLWTB2cXN5MDd5a3UwYUUvNUZVQzN4MWtlZmVhcUthWk13aWhTRUk3a291?=
 =?utf-8?B?dWpZY3FJOGhlSk5CRDhsUVIzcFZqdDdldlVvSStJNWtpOEVPMFgrcHJsUlFx?=
 =?utf-8?B?U2dWS3p5OGxBaGpEQXBYOG9LYnQ2dkpKL0tGSFVBSytLWnBBdktoOGVpRUFF?=
 =?utf-8?B?OUNLbWdSdjVBZ25rUVU5aXc2MENyZXE1RFI2ZXRxL3pFWDRNcGphNlVZdUlL?=
 =?utf-8?B?KzYwWWpWd1pCRXpUNkc0R0V6Nk0wTTBwZHJqbTFCWlY2OGRCdmdGcEN6dGlF?=
 =?utf-8?B?VmFNZlJ4bTBZSjNLajFSUjh2NFdYL2NzNm4vYnpKSFBjemVIelcrRkNrTFNn?=
 =?utf-8?B?VTRlZTdYeFVpSEpXQ25iNHkxM0VCRGlCeVRxRENOaEhiVzB5NjZwdnFSLzhD?=
 =?utf-8?B?NVVNWnN6OFJGU0xtaEM4MnJzNnlPdnNRaktMK1VuUWc2ckRHR1ZkcEpIRmFk?=
 =?utf-8?B?Q21tekt5aTFwWHFYMDdSMjYwVmFsdE9Ha2ZvS2NRQ1RUV3hrR0UxV3ZuNWlC?=
 =?utf-8?B?VXoycGk4VmR2RHdwU1gzWWpVMXJSazM5Q1pZUDBHT0dGdndtQkh2TXludkpG?=
 =?utf-8?B?Rnp2QXY5VzZpbDlzYlN0dEtQN1pXVmQ1SlBNTDN3SWJveGpvYUhNalRiV0FD?=
 =?utf-8?B?UEpEMXZabG93VlM5WVhCRVAveUZkcXZ1SFlTb1NkV1ZWSmF1cUppY3pOejk5?=
 =?utf-8?B?S0FEMjVnRmx5TWwzVEsrMFErVHJlK0JBYU5XaVQxSmV2YkMwRGxGUVpqTDFs?=
 =?utf-8?B?YjRNNjNiYi9qdFdQcHlwMGVRRDI2T1VVbjQ0Z2JVMHZFYkVYVlZ2LzhReldl?=
 =?utf-8?B?UEdWbjV1VmFmTlo0K3BHSHJGajJXOWlnTzBSUCs5NUROU1I2ejV2R2xyNUFk?=
 =?utf-8?B?ZVRicGdnNXJQSGFhSFRuYnQrNlM1QndVZlVxS2ViMXRmSFV2dzhkRmxhdXNV?=
 =?utf-8?B?cUtBeEZKeTU0K2xQRy9FVHBsNEFjWW9ZakRzdDJEY3RWMUQ5ODJiblloNmlX?=
 =?utf-8?B?N1RDdHRjLzlnM1FNZjI3enk1K0wwR3lvSVQ5a3FBRVJXUjRsVFZzNUhieUp5?=
 =?utf-8?B?YkVOWERybDdzcU9kdWpuT3l2dnZ0WTFoR0xIVFA3ZlNTRDdVZklnNXpldnQx?=
 =?utf-8?B?bGU0NmxieVA3cG5ieUNLZkx6dWFRYzc2T1ZhK1BkOHY1d0ZjQ05QOFlHRjFv?=
 =?utf-8?B?SklMMThWc2QvNVFDMXhicXNPMzVEQzFwSkRidlZKU0s1UUhZR3Y5Nzc3cGNX?=
 =?utf-8?B?bFhUMGhxL3dOejB4RnhsZnBxaVZWR255bUNSUVc2Rkl5RmlaRGlXeVVyVDl1?=
 =?utf-8?B?Wng5NjdMdzlCanN1VENZSzR1QnloZDFuczY1YkhYdlJpNGxNY2lIemlVTnk1?=
 =?utf-8?B?OUl1ZkoyUFpuRVpwWHEvVjEzb0M5T09GZFJEZlV3SHFFSXRrUnl6dnJBNVZM?=
 =?utf-8?B?a2h0ZWtDbVhHSGY5L3V4V2l1VEw5S2NsZFFZemZSenQrVktFRzJZazliNThT?=
 =?utf-8?B?WURwVm1oNklqRVpEMWNMVFJEdTNOQkR1cjBZSHZXQUV4cnZHUVZMSlBuTkpU?=
 =?utf-8?B?STlCUTR6WjlFWUZYb2l1OUQ0a3BpQTNtOVhsMkhsc3VXd3hZTUhmR0JycGlh?=
 =?utf-8?B?azhnV1lEQU1sUTFhNnIraVkxaG1wMW0xekN2OS9uUXczb2dkaG9NZ3lJeEVq?=
 =?utf-8?Q?QGG5ZbuAF95hl+k3CgX7slgGp9sAHW4zvwCmAnB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a086af7e-5a5a-4d80-0803-08d8eb09b2b2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 19:03:36.0181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tFzq9yCBpGFwFodgpj87HEd9e9TlZPI6TCdVPFidINBXLOr5cpYHFBxNL2PDLK5ow0Y0NUwNhmwVWOM6tEyew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1550
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-03-19 2:18 p.m., Alex Deucher wrote:
> Ping?
> 
> On Thu, Mar 18, 2021 at 10:18 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> Move the function protoype to the right header and guard
>> the call with CONFIG_DRM_AMD_DC_DCN as DSC is only available
>> with DCN.
>>
>> Fixes: a03f6c0e26b2 ("drm/amd/display: Add changes for dsc bpp in 16ths and unify bw calculations")
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Dillon Varone <dillon.varone@amd.com>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

>> ---
>>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
>>   drivers/gpu/drm/amd/display/dc/dc_dsc.h       | 2 ++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> index 10e34e411e06..f9a33dc52c45 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> @@ -3498,17 +3498,17 @@ void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
>>          }
>>   }
>>
>> -uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
>> -
>>   uint32_t dc_bandwidth_in_kbps_from_timing(
>>          const struct dc_crtc_timing *timing)
>>   {
>>          uint32_t bits_per_channel = 0;
>>          uint32_t kbps;
>>
>> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          if (timing->flags.DSC) {
>>                  return dc_dsc_stream_bandwidth_in_kbps(timing->pix_clk_100hz, timing->dsc_cfg.bits_per_pixel);
>>          }
>> +#endif
>>
>>          switch (timing->display_color_depth) {
>>          case COLOR_DEPTH_666:
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc_dsc.h b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
>> index 0c5d98524536..c51d2d961b7a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc_dsc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc_dsc.h
>> @@ -88,4 +88,6 @@ void dc_dsc_policy_set_max_target_bpp_limit(uint32_t limit);
>>
>>   void dc_dsc_policy_set_enable_dsc_when_not_needed(bool enable);
>>
>> +uint32_t dc_dsc_stream_bandwidth_in_kbps(uint32_t pix_clk_100hz, uint32_t bpp_x16);
>> +
>>   #endif
>> --
>> 2.30.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx>> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx>> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
