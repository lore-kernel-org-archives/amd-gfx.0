Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B162C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1985060EEA
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1985060EEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9303C6E2E6;
	Mon,  2 Aug 2021 07:41:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DA36E1B7
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 07:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRLY6NZTHg853QDK+j9YTCZIt6ttaiVmjx81XLJpIeUJcC7KJEQr8rM/OG/t706GDHr+8JnvBnCNvVu9JEeOaaP+LTYKwnmuIvnwd/90r9c0JbBTtDV6ZeAROYyNz/qgnqfv4VvawGaE6Cd6naTwd+shjPrnY46wQN+UnnxO0GwMOZc422qoPy3RPM5274bm4G5Ox4CzRdO6ZJK+byE6cNc34oadPe/02WeagjVpDZCua2qvUlud5t/+1Yeb6leIDOuy2ZnNuffhbXIwLse4bEhg2Dxp2grzkI48tIe/Jm/yUKRVRPBOn3MUQL/Vsz00O0x++hK0XAMjLSjoCAf7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqW6a5XvZlPPOUYLsWnaAtGcUa/V0p78W+DlxbWa6iY=;
 b=F4bj0hVlKGj2dNJQ8PwcWCMqvJjMHnjVomqh8Ygfk02mGwZ6rnpNEHKIcXUwL7YBnDyz5H9Fbu1ePvUNlCvgJd4pqjuhGP5NUswyNLupSsNk3qSX6//RPl5NCNc9PmkuLQRAMRQX9TFd8deBfJ4frUMyjJkpErbAazqdu5vjCeKVIimZnt1jsRpapz4OH1Gfn8/zQOeooGoXfPRJIcN+PgTzwEtBjqHGCClP3oVLITFQxkCGS9xz+IeLLnhx2PkDy/5lwFkMOorLG/6B2AHMItVHtTOpfi3wy1165O0u8AK0SMKVCU2vLYG/tidns2eirwM3zjbeP3gIP+ImQWi5Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqW6a5XvZlPPOUYLsWnaAtGcUa/V0p78W+DlxbWa6iY=;
 b=P5qMktx/J3W2kEn9aCgFeXfQEE1Sh2CB24bW6+okwky+12FCEuYSx1/QtwaWDtqZzOPUBwHir+XRZ43DIxeeC7U5oqf4r5oyHH2Mp6CHDZ08y00Waup8NozRPB/CtaYU79aNDvP7pVm1hQujrRKnBfMoCYNFaTQ8IZS1v0UPsfI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 07:41:13 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::9991:fa53:1b0a:372c%4]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 07:41:13 +0000
Subject: Re: [PATCH] drm/amd/pm: correct aldebaran smu feature mapping
 FEATURE_DATA_CALCULATIONS
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210802025331.727141-1-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <861a03c1-4ee9-4beb-03cb-d892e613e664@amd.com>
Date: Mon, 2 Aug 2021 13:11:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210802025331.727141-1-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::34) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0070.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 07:41:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a05b715-8224-4005-5f3e-08d95588e700
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB528746047AACFE56A11939CC97EF9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLEQmcPLkjoUeOOID4gLhqMlMRo3aKPk0z6ZELxUQKxs49Ngp+y0qrdpAPKD0B74alPHVPBN3VLik4jkTazoP/aiNcHpAYW0I9r8seg3Pfh6sRfBcVaCOMZuwJjM/Xwz07gdcKGUofh2WweskESzVb/CxSH7adiHVygJhIHtZKAvsCj4wI8oclfbclk8QVj/X9Tv5SPtliu+HOmtVyynOcHriyhv5A6hAw1cmQN2lBji5r6wnmchm2+Z/e72P3xBVjChTuwBdKjOr5citOfncQL35OTcwaPhvdtgQXYe1MShbj7ofweoa5+xLDXoBnKD7ehvNfQxOi7jFKhBqM9HpcF//Yi7PrrouV+L7qlQnxi7CpLzANXm78InE5rFu9d0n9IhoqI3YbUmbAqZXYNlaW4+iSknWWE9q2icPqKZf5urKK30EBciNzqDQHNJyM/XtnWjoG1tgEfy3JMppiFG1KahQlk/93j07qnMC90T3Gmxn3G0OAVCyaJEH+/MYKsIP/SWxCFYgbxgrKi9oU6eyvRJbT+Ek8/zGVfZFSrcNP1hYWdpEbqdYUa14ohh03UrbanawdbTkhCsT/bSNgvU5o9qbGBjt94c6Dz3L/+ifRHxMoQD8qXrF0F8BOqA+uh9U3PoY6GasVutvwnnKSdNKJ8BS3W+59y1Lk1njF4qDyQeiREAI2RTok6XkjVn8aoslAzgXoItQhhvJSgLlgNrlqzmplyeOOV0fobY0Gr4J10=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(2906002)(16576012)(316002)(5660300002)(31696002)(8936002)(478600001)(6666004)(38100700002)(6486002)(8676002)(36756003)(66946007)(31686004)(53546011)(66476007)(66556008)(83380400001)(186003)(86362001)(26005)(2616005)(956004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlRYWTRtMjhiN2FVV3puelRKbnV6NUt1RG13WXgwdFFHNDNxN1BSNHZNN2NW?=
 =?utf-8?B?L3d2NnczODMrQlFlQ0ticmYwSUhZSE9RSFdXV0NJMHhLWWRqSlIzcldDcllu?=
 =?utf-8?B?L2hpZ2N5Rjd0ZGZEdjFlQVZleVc1K014WkhiU2xTVTg1NkJuZ3FsbU9qN2cx?=
 =?utf-8?B?U1VxdnNONUVmbHN4dHBpNmVDSmUxVDMzTjF3d1cybDJtdjFCUVNubXVkZUV0?=
 =?utf-8?B?eEgxeS9xQ3ZiSXpXbEJLdDJxRmphYnNiRFBzU2NkSE9uOTlwbmlxd1RSTlhh?=
 =?utf-8?B?RnIwa2FHbnRhRHBiTFYyelhhVnlNQjF5Z1pQbU9hT2tEd0ptS0RuOCtxV1dP?=
 =?utf-8?B?a2hLVHFGUHV4SEJRZXlST0M5U1V2YXlVRHhXd2pxd3lkMk9BN01KT0NPRmh5?=
 =?utf-8?B?WFlJa3Y4azZMQk8xUW8vc2tJTkpiMDNFRXZvMGtkWTJlMnJ2NDBmdS9BMUFa?=
 =?utf-8?B?K2VzTkM2cGo4cDYxR3plMzJwOUlSVm1KdkJkZTBSWkl4WFpTSE4vZG5td3Rl?=
 =?utf-8?B?ODdONWZBSkdRdmhIUDgvSDROeVgwOUpOK0JYakM3RTE5VVdEOEs4bVdGcFFU?=
 =?utf-8?B?eXBKZW1LNlM3YURJMDFJZnpYYmQvVDNSQjNFTGdzbnA0TkJIa2NCVG4xaFNk?=
 =?utf-8?B?RFhCNlFLcTNjSjB3eXduaU1QYWM1RCt6c2YyNWlIWFpWQ01XeVdiKzZrcmpj?=
 =?utf-8?B?MWlWUUs1VVcvblR4V1V2ZHR6S2xhMlltcE9WR0RBbS85d0wybEZkNWtWZ2Jw?=
 =?utf-8?B?VzNsNmtMdksrb01KbzErQ041YktISmN1STY0QzJjNklwbVVYa09SMVZaVy9h?=
 =?utf-8?B?YzlyckxNb1A3UTZMWHJNbUtscW9SY0pkOGw3OXVwc25ZT2F5ZFB2UU5pc05t?=
 =?utf-8?B?RFV0Tk1PVWhUTTY1dDZMaGhzanBnMExiUFFhVlFHVm5RRkJ6QnZCZTcwMXVQ?=
 =?utf-8?B?b1QyT25hQVVkNFlVQ3IwUmdpYXI5STJ0NFdxU1B0Q05rSzIrMWhNcmdldDBw?=
 =?utf-8?B?SU9yUGY1TEc1L2cvelEvdndMMmZkQVkzck9iQVlrQ1BKbzlzRnowdVZjZnhS?=
 =?utf-8?B?V09ybkdFSFVhRm9VL01TTkFFNTFzalJRS1hOLzV4YXorR0NESEJSMThhMUtO?=
 =?utf-8?B?eGg0dFF1ZFFlS2prRlJuSzFLSFd4cm93SGgxQ2xvT0tBRHpNSUg4RVQ4MS9C?=
 =?utf-8?B?NEpMc056ekVXRGFyZVpaV1U4QTRrSldpOWR3d2NQbHNXWnhsN1VXYythTWxl?=
 =?utf-8?B?TXQ2MCtCZEViUkp0NCtjMXdlRFo4Qm5aTkRwY1NML2ZjWGRJZmYzcmwzMnpu?=
 =?utf-8?B?NXp2K2pLbnREWEJqeTE2M0N4T0tXaWdGUU5xYy9iaUNqaDM2ekMzYjRTaS9C?=
 =?utf-8?B?bERicm9Od3pKeWxqLzc2SGhTbmtZbk9zM05rSFllVngrNEo1aWZ3d2MvODZU?=
 =?utf-8?B?YXNWV3hhVEVJaGM5T0Z4YXhlZktaTTFzUjltRmxuWDNxV1lDT3QrdGYrRzVO?=
 =?utf-8?B?cFl5RDdRQW9BSjNhZStOQWtZQ3VsYm1vRzZjRWg5aW8zQmNOR1VWN04xaExh?=
 =?utf-8?B?TkQwZk5aWDFrMjZqV2FnUWhuYlJRRGZyTDNXeUFpSU9tNElMaFU4aDdrd0Ny?=
 =?utf-8?B?QU9YVkIxS0lvbG5ZaDlvYXcxY1ltdjdkZ0I1cUpNNHFLcm9TRmRqQXpydjN0?=
 =?utf-8?B?bXZaTE91a0ZqcERzUCtCQ2w1NXhJQmtwam4vVlZhTEgwYWJhWU8wOGJBTFd3?=
 =?utf-8?Q?bsy30A44HUKxHOpmZPTR+Qn1s6Tmij7aOdo3Vt0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a05b715-8224-4005-5f3e-08d95588e700
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 07:41:13.1898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzQKYTmWc2hZyvoBnHEXnWbO/RmRuRP8UuWyUiTMRuBnlU8cwBq0bYbHdhuiR1gd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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



On 8/2/2021 8:23 AM, Kevin Wang wrote:
> correct smu feature mapping: FEATURE_DATA_CALCULATIONS
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/inc/smu_types.h             | 1 +
>   drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> index 1d3765b873df..6239c30fcd5f 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
> @@ -282,6 +282,7 @@ enum smu_clk_type {
>          __SMU_DUMMY_MAP(TDC),                           	\
>          __SMU_DUMMY_MAP(THERMAL),                       	\
>          __SMU_DUMMY_MAP(GFX_PER_CU_CG),                 	\
> +       __SMU_DUMMY_MAP(DATA_CALCULATIONS),                 	\
>          __SMU_DUMMY_MAP(RM),                            	\
>          __SMU_DUMMY_MAP(DS_DCEFCLK),                    	\
>          __SMU_DUMMY_MAP(ACDC),                          	\
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 856eeaf293b8..4af602d6ee02 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -64,7 +64,6 @@
>   
>   #define FEATURE_MASK(feature) (1ULL << feature)
>   #define SMC_DPM_FEATURE ( \
> -			  FEATURE_MASK(FEATURE_DATA_CALCULATIONS) | \

Data calculations should be enabled for DPM. Undo this change before 
submitting.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>


>   			  FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)	| \
>   			  FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	| \
>   			  FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)	| \
> @@ -150,7 +149,7 @@ static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
>   };
>   
>   static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUNT] = {
> -	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_PREFETCHER_BIT, 		FEATURE_DATA_CALCULATIONS),
> +	ALDEBARAN_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATIONS),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 			FEATURE_DPM_GFXCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_UCLK_BIT, 			FEATURE_DPM_UCLK_BIT),
>   	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT, 			FEATURE_DPM_SOCCLK_BIT),
> 
