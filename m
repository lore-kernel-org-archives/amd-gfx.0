Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D46AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662A6613D5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 662A6613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B97366ECC8;
	Thu, 21 Oct 2021 16:35:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78256ECC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMRZhnLGH5d06TxZI9ViMkucqLDmxM/j3TRolWEmbXakOAoYzgxUdxthNgul0GgWZjKbdW0ZxqT4a0neDPjrsM5HQqdk1Bm4MwIi2bSnhL7UuvoVrULGS19lC4oS/VSZYm4X5g9C8ghquH3b86kvpxrTeASkpazPcH7XLKUU/RNbryZyPSQht8XH5k4KGtUaLPh2SUj/HK3DuW/SNRIJGpMMw3Em5TUTwCh8oCAj6G6wJ94Z+5c+SA2FOR8TpnF7ylguHfhXjit3NHAexTTmuTQLpzsjZK8scw9/OmMutfD2VHBwvonJKnQu4OZGfHNjcrzHj0sR7k0dQ8POl0jU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUlbv80HwjGeaVgsP5VjG45R23hGs6emQFj38gV3xIQ=;
 b=UkVDyRiYVlJ5dQaDjZcXI1GAITmNC6h3QoGvugW09BcMGaQwc9M1Q/d3/u5ph27x1S9Soi9fZmA/oi6CWq2UY1mlTZbf10jJqSONBkR98jjWFCjYwvQTUDCwpz2obUl4uO+Dm++QliByNUQCkbmAjkm3s3mmSnG7A5fy3UghN1qzdjAnsaGNmWIUX6OJdLIysZUn13ZrXDyCX3/STqSQQUtuLXnH0TpazLnVFQCcOqScD0uUlwoLVx113pDUgbl+nFrI4f03W0tMK9CV8YXH6eb9Spmlr9n/eMw6rQzhfwt5cpo1l07YyvsctzvHBzzT3YIoB1XOiYErJQousiOruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUlbv80HwjGeaVgsP5VjG45R23hGs6emQFj38gV3xIQ=;
 b=UQLoB7cI2k/EygodpXEcs3SDoCPdV3MyFA7dIQ6JmZYlc4ZAvshy5UbqArQt6yb44RpJQee9kp1pOnxdVNY5g7CZVQR6IPjmXMQSq9XFHfmLi4DgDv52HIcyGD5n3avGj3M7Ri64eb9dnJiu0NtOvJmTxS2BEyF2TjJQrQCo/o8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB4647.namprd12.prod.outlook.com (2603:10b6:610:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 16:35:31 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:35:31 +0000
Message-ID: <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
Date: Thu, 21 Oct 2021 12:35:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Mukul Joshi <Mukul.Joshi@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211021155711.1191830-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::12) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT3PR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 16:35:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 889dff30-566c-4793-16a1-08d994b0cc4a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4647:
X-Microsoft-Antispam-PRVS: <CH2PR12MB46470FBC01ABE582C833C81699BF9@CH2PR12MB4647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3ahRWEx3qMKu+SmhFi4W5oxvfSC3A92Os60N/I9yhK8pt6JtgltIZCjXjfdwb7/WV3r20JNJbplfm4urY01fTFtJ6cFEKYMsaawCjRPnB8HqOHd6ZpncB48Z1IE1TJ8vQB7ch43w6q8DWxVA4erL3Uw4e4mOK1zeXWlRqmB2GrLQKt6/4rjBqaRFTeh60Ir4oWsYt6clvvXf7e+9ffsOTCjBEiiUlhQRQuLg4sMX7w7Z+xj9WfXMlycBLR6wqqdSaVk6nrp6JCamNyRRDsEzbPuTkkGVTIKS4ZSeR8Smsn4YZDP6t9zCp+wlNSHcWv/5A8WL5g/Po4Mt/kK21QroIsw0J+J7iIdJI0/HN/oI78V9ZGjiJpyhGr4RzGIsb+3F3ok/mLEn7b8EyuUaKerIrFWGtLDc9+zFje/xeqURnwYkgzhjw/BWumOg3hePkZNYy9WETcPd3D3NpyQCJYLgVeN2hjaH1IcSwBdNA2pM+soAKK1md1eFxM0+BBCUlIYZnneBuSRnxrgWB/gTcXjlTkiCUeoOK1D3p565kYrSqSGMGwy/HaICeHOj1Ygjqu3yIxB3aaO5MBJ5OCNKJZQHS7Pi45akQxNg0CgDaXma4bTCKxqcDo3oNjgH+RdUWqGbOdcKrNrOH3qS5+ezKilykKHC9wmGBWYr8DiMfdGPCyX72/12tU0YY1X0ogknq8xjjEAjQKMr1PlhYSiukVEMbx0NxzuiJpoNE2iucQgyx84RNP74Vkncs3cMjbDdaQCM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(316002)(16576012)(31696002)(4001150100001)(83380400001)(36756003)(8676002)(8936002)(31686004)(86362001)(26005)(66476007)(53546011)(66556008)(66946007)(38100700002)(54906003)(4326008)(6486002)(508600001)(186003)(2616005)(956004)(44832011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3p2alhlRHRBTkhkZGV4SGd4NFd6Z1RFSGxhRjB4ZHBVcDZsRDlKNHl0NFFP?=
 =?utf-8?B?eGU0bWxoS2lNYURtQ2RXN3JGam9KaFZ5V0hMT3EzNVpNVjMrbUFRVkxFSDc2?=
 =?utf-8?B?OGpNUGdnMm11UUl0NE8zS0Y4Y3ZtZmwrQUZ6VTlZalJpcTJwbTBJVUhJODBo?=
 =?utf-8?B?cHVOK3FhZmdTV1J3THI1Z0JiaEtNS05KVDhWYjJUeTJqUmJCR1d5ZStLMjNI?=
 =?utf-8?B?cGVoT0laRk5POFJRc1ZETnRLZmxGdjZQSWFZV2YyYmZsOEd1TWl3dlh4bkFh?=
 =?utf-8?B?R3VSaGlHdnRtcllhUGEyMWV2SnNsZlovNWJmd3RiZmtPLzlnSnhFNlIxNlhT?=
 =?utf-8?B?TFRsM013QnRURGtYQktGTVRCYnRWS2E5ekpUM05rSGRLWVNJbXZHYlRsZW1Y?=
 =?utf-8?B?aHM0ZDdIZVhMU00wQzRReGpwNVhZaURhWVFVUGNMamlPd1JHZ3pHM2c5K0dS?=
 =?utf-8?B?dTlBTFRsOXdFSURPaVB0U1Z3eTdQLzV6Q3pMWVliaVlWbUhrZWRTa2ROeEs0?=
 =?utf-8?B?SkExcHBXSFJZcFBzQ21mdW1BTmp2ZW5ZcGtqVk1jeGdTSDRxb2gxRjdmcHY4?=
 =?utf-8?B?cUs4NXBYNmpydUJCRFU0Q3NzMGxDSEZTZ2V6cFhJMm1mTFd6TkxGVUNVMlph?=
 =?utf-8?B?ZkE0TnJtcWs2bjd5MGVEenFDK3dCcU1FOVljVGEvakJQY3VqbDc0cHJpSkQ2?=
 =?utf-8?B?NFpjM1k3UlVmMUgySkZqV2g4UTNwOWd5NGw1YnFxbDcybmVnMVpMMnprRmhL?=
 =?utf-8?B?ZXRhSlVGMDJlKzk2ckU3N091NmxWY3YybnJONEZKWVFvbjYzdGlvUTBKY0Iz?=
 =?utf-8?B?bWJpNnB6YldRYnJYMVFIMTNxRTVMcTZWelcvQWI1RlA0ZFdHNkZ6c3RoWUtK?=
 =?utf-8?B?aFMrRVZpWUMwY000RXl4Qk94akZJNk8yNUFEQ25FSFkyNHphYjlQZGd1RWoz?=
 =?utf-8?B?VW9EYmhhcmRNcFRaU1plcXpWeEsyNmhvOTZRakhld0RSSWwyOHNaU05sNmUy?=
 =?utf-8?B?YlloLzlnSThHUXByeHRHeU9rRTI3em5lbERwVHpaZmkrMFVabTEyYlVKZ1Vy?=
 =?utf-8?B?WVk5T2hRZUNBZjJOZ2RCd1pWYkZnUVN2eVZNOG1vSWptK01pTHlrTnNnOUs3?=
 =?utf-8?B?b2ZVZEs2RzB6MlRTNUlqTnFuTXp0ZUJobzNGM0tScURuZTk1azZiTFJDdGJH?=
 =?utf-8?B?SmowNWhGQzZ4R0lGS3ZCbUdvaW5JQlVwN0xrTTl2c3NwTmE1SnhkK1dBb1FL?=
 =?utf-8?B?cHNoU3JVOEZpZ0FBMFRrYXk2KzYwMHVjVGVoalNhS2dQVTkrdGttUC9qNUZh?=
 =?utf-8?B?ekdUd1pLWllMdGlsanFKc1hoU0UxeHBMNnVMMnlnNmRFb1g4UHdEQXlnYkRj?=
 =?utf-8?B?Z3RhL3pScUVXb1ZiT1lhckEyNGxBS1V6Z0ZpV3g5TENXaDZkTmthZkVvdlhS?=
 =?utf-8?B?eTNycFVNV2hsMlgxd2hnZGZJQ1ZvL0Fpb0QvRHlxYU10NzJyYllCQ0w3Q1hU?=
 =?utf-8?B?Y1BUbkRteDRZdCttaWtNejlRSFFEWGcrV3o5ZmZWQUhYRzVnYTBLd25JZHpX?=
 =?utf-8?B?RlMxMytVT3JlLytxYkpUR0xDOFk5SlB2QUZFWU9kMW5Vaithc3F6emNTaWZK?=
 =?utf-8?B?WFAwQUZPYUl5dUxzSlg4OVFGWWtlVzhRSWRiaDdoVThqR1grRm9NZUR1OEpk?=
 =?utf-8?B?S29RQnltYU00QmpHdk5XYjBIYXphcWxEdy9Wa2c3bTMwSUJSY0pYQ09LeFk2?=
 =?utf-8?B?K0V1U09icjB0N0g3Y1N0TXdwTjFrMDBnS09PVW1sZWgySGlwcTVaaHNPbVVE?=
 =?utf-8?B?aUtDckNhRlp5OW5HN2VpWlo4VzcydElSNUtHZ3JDd05VcUV2Q0k2amhtS2x6?=
 =?utf-8?B?Z2wwa0tVNU1PV2lFYWlMMXZXQm1nNGl5bUkzMk5RZ0djSzlRVDhmUWYvZnhu?=
 =?utf-8?Q?qpbuf0P2hyU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889dff30-566c-4793-16a1-08d994b0cc4a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:35:31.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4647
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

On 2021-10-21 11:57, Kent Russell wrote:
> dmesg doesn't warn when the number of bad pages approaches the
> threshold for page retirement. WARN when the number of bad pages
> is at 90% or greater for easier checks and planning, instead of waiting
> until the GPU is full of bad pages.
>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index f4c05ff4b26c..ce5089216474 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>  		if (res)
>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>  				  res);
> +
> +		/* Warn if we are at 90% of the threshold or above */

The kernel uses a couple of styles, this is one of them:

/* Warn ...
 */
if (...)

Please use this style as it is used extensively in the amdgpu_ras_eeprom.c file.

> +		if ((10 * control->ras_num_recs) >= (ras->bad_page_cnt_threshold * 9))

You don't need the extra parenthesis around multiplication--it has higher precedence than relational operators--drop the extra parenthesis.

Regards,
Luben

> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
> +					control->ras_num_recs,
> +					ras->bad_page_cnt_threshold);
>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>  		   amdgpu_bad_page_threshold != 0) {
>  		res = __verify_ras_table_checksum(control);

