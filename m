Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0AAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B7061260
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22B7061260
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB996E072;
	Tue, 19 Oct 2021 04:38:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2356E079
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 04:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdQ6NOUAbkLWCq5w7AUPxxscthhAtXAncMwn9CwjEhYNivAcCkeVbpNm+SdCbDCyIdMYj6HExN92rSuhUZJTo9HYnSKnYWcPRomipGOQWOVqXTFduf+qWAR1D115givsXQkmNLQjDTb4/25ipT6o3p5KY7d3YsiIWhfdWh3AUrrrEL9ev+k4G7ayXmpJch5pNg2pDARk6coWwscCti34fjWbHVTnQ58xozjj+gK2UE/HIgjy1H56Sl/N715tfTomHT78L3it6MMp5Q3zyLMXvqcDfMdzbPJCWipyJbqTYPkoaqmhsWKPEzZHPv5Oq0YxmjRi8D/yaAoqd6y7KLVl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxhOpK1rE8RJdxBuOstdEWOl2FUAZOmPs5eH3V+EbI4=;
 b=QnKOCMzLvrUIUWeqYg5slz/flE18bBbpn297cSocTEuZ7w3+XGOTfzw17SIJFJZM52WogPR3HC0/Y7PI0Ro3buPkiDD+XmzakTVsbIiB01Q9cbo4i/qW6tVPme3gNn2BQ6gjN68txaaIcy218vq2kvGMRDJtfL4OcR2I5JDoSB+Ri4q+wr/B/1EntxYZooLarh1ZtTTmdv7Fxl7i4GKgTK+jGbnrCsuLnXnKiEiBkea9WaLzNaQ1Im2Um880tokhCEuDg+rP0X31EcqQN6zjBBTemRnLQKAQSUZ7OWvfqMKG4G3HwNM/MpKfgl59cZPv4/W5SbR7CJENOvMgIpQb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxhOpK1rE8RJdxBuOstdEWOl2FUAZOmPs5eH3V+EbI4=;
 b=YB645p7TKdULtUrDTa9qQB2U7zcx1JNJL+V1HSd2L9+4cXPk2nRNLiqcutwXo9B51Se/03Nzve2jsJoPnPzUWya+E2MbGJOeOpKwBQJTXOq27kiAkc2jnoY0bQ3GZejTLki6wNtBXohAjhGhgCghvcy+eO+bVwPj9fQ9rKhKXKE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 04:38:25 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 04:38:25 +0000
Message-ID: <fbd8a354-4f09-ffd9-ae0f-fdaa16903bc8@amd.com>
Date: Tue, 19 Oct 2021 10:08:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3)
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
 <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
 <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:97::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 04:38:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557f2936-bd22-46de-b144-08d992ba4a10
X-MS-TrafficTypeDiagnostic: DM6PR12MB4780:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4780E84E5A647E04CA9DEAF397BD9@DM6PR12MB4780.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbV1/0ZhI7hH4pTiZrddfZe2kSNVXNdC5OqNxul6OYt48kwAncBDfOd2kCYVOEsJbKqEIQNDM48O18cGwLiOsAcJMMUXJx/ADqht8P5/egCAM4xW2dsfPVjjoP3tVzmqRTqAxJgKayjuwi9cjuPMJ7eBfwBWcI8xjI8kUpb2D8t8pz/Nd1wkclIutnDShOMMdSpqSdNfoWXfAhdaewWbkFNcV0nDwK1K+ZyfH5ixfOroFaYJ2x8vH8xQpAM2a2c30q0NyC6VwISb/nrUGu2Vn/J7E/yRaB97p9fdHRH2ZRRS/oCe13iJrg45Hkn3Em6T2QQ8EhQ8MtNl8pCtRnT2/OUtmL1qpMkjg6gWxCcFMcBC0mUq4ZoSACNFTksjdSn2Sgqj8kOZ1JRnQYOtwbczDdMy6PDRKQlGwM0FLr+SqK9C5bI+Qjm9VJYHyeatoSXIhM/eTLp6EOAyeilFY2N8Ha4JHyIgGHGSCI/gTvBMK6WWgnJE2zM1+Z4daV/QWahMRswQdnpYFFgxpiTg4nMLyDqSRLE8JyU3Y4x7/BrPPIPY9jHNrgmGBmAMPeG7tBQVngLv+6RYvxdJbabZBV4FSGXYpOafC/p/c2yCz2GJ/wdRSG9VQgvD9zG8w8AtsgiaymuBWiVY9NCNvq2mhTOfiweuivXQdaVRNHJy3vGqw4GbRpPZb18GpHZkj9tGoy5X+b4Z9NO2JCaJ9BlHQss9lhayHHCca48d5Gfe1nrp7r/o2F2b/36o0c6808tT9epT83uLMxGJ7bsnJ/6SHmJfB22NOdWj2JuLVAGka7WDon1EVfIMBWTq5fTlkf3C9/0Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(86362001)(956004)(2906002)(2616005)(31696002)(6486002)(36756003)(31686004)(508600001)(6666004)(66946007)(53546011)(66476007)(966005)(8676002)(38100700002)(186003)(8936002)(5660300002)(54906003)(316002)(16576012)(4326008)(83380400001)(26005)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0s3eHFMSHJaQ3NUNTdkK3BMZUdSYzY1U3Q4MXMzSXJ6d2Z2MjhrR3hXTDhu?=
 =?utf-8?B?YmFzSTBscUUrY2NzMHJ2NXAxSjBnOXBKOUVQdDNqNlZMU2lYWnJmZ1kreGp4?=
 =?utf-8?B?d2xJQjRieVJEOFZRekszSjBQSmVyeXBLbW4vbXZVVnhSNU9GM2svRDJZcUtQ?=
 =?utf-8?B?NFpvSUxVWDJ1S2htcTFCRjA0bUJvNXhLanlnRCs3YjVEY1BaK0Vtd2IzM2Y5?=
 =?utf-8?B?d2F1ZzBMS0UvVnRaOTRMUmhDT1o3b1RZSWN2dHM5blAxcE53QS9MV3N2STR3?=
 =?utf-8?B?cWIrTE9vQlR6SUFhbFlZc3R3bEJ4eFArV1ROVmVLbDJITWZoeHBTSkJnZFZT?=
 =?utf-8?B?NFlpeVp4b0pNbkliWE1RV1VXNGhwU084V0RQaEpsNTAxeGl2a1ljenF5djZk?=
 =?utf-8?B?cHZZWXR6eDg0b2VGS1FQSVUvN0lzSk03QkI5R2pPVE13ajVoWHJqSzR1ZXho?=
 =?utf-8?B?cE9JWnNSeWhLSnUycGVpUjJpcWliMnpvNTVPWjdSYzdORzNrMDdEb3JkV09p?=
 =?utf-8?B?bm1xUjlhNWZLTFJTYjZXcUUzTWQ2ZWJ1U3JHVG5NMnEzNUtFaGpXN21aWDJw?=
 =?utf-8?B?Sit6Y1orK0pZWGRBMGwzN0E2cEtWQS90QUpmNnpwN1BCUGdZejgrVFprZHk2?=
 =?utf-8?B?YWtxSGI4TmFYaS9qd3d1MkI0SWVhWXJKSll1VFFxM2RmOHIzWVF3MzRXSFVQ?=
 =?utf-8?B?Z2JvRlE0M1VSZHQ5bDhPVGtsZGYzMjY5YVhCN21zVEJLNE1Xc28ycUhmYmpD?=
 =?utf-8?B?bXhyRFJFUVFsWVRMQUQ1dThydFh3U1FpZnJMWi80Uys2a0NLd2p6Nk5KbllC?=
 =?utf-8?B?Nm1IcG12bFcySHVNL2FRanRybjh2aERXNUxuc21HYVBGcjBFRnFXdXh1NDVO?=
 =?utf-8?B?WlNNV1Z0Wld4Slp2bGtkU2RnM01IS3ltbkpESmFxNkR2WUdzSXZETjBJMVh5?=
 =?utf-8?B?SmFPc3ZaLzU2NGtQYURRR3NXbWV4RFMzOUxERXBFRUUxUytZc05JVUxVK3dS?=
 =?utf-8?B?VkFvQTh4NFJ4Vldxb2FOVEFrOFNqenNBOVJsL0dLakVqc0M4ZTlxVEJwUlVm?=
 =?utf-8?B?bkZCYTJoUVo5Y3ZuQnBOMmRuN2RaQkJGNmNPWmRPODk5S3J6OUJMVXR1clpV?=
 =?utf-8?B?b29POVVkT0g4N2VOcjliNVlmcGRlN29rcFl2Y1cyR29jMGtESTBTOVNGRHpN?=
 =?utf-8?B?VzVpWG5DTnhCeW5MUjlHb1hQK0Y3Vm5iOXR5STJOTy9RWmNNMmhtM2I4Nitq?=
 =?utf-8?B?dXNSRUJ1d1ZLNjVnTkpJS2JWM0NJYklqTGFweDNqVUpSWWhsVlpNdmJ4Z2ho?=
 =?utf-8?B?akp4bDlCSVBSQzYxNzlSMHJsUEhVNktFRWJHSlFzbHlyZFFqb1ZsODhEaWRz?=
 =?utf-8?B?VUJFUXFxek9iZVJyQldhMGhMd0UrdXVGcUZ5Ris4R0RWbHJxVmIrbUJRVmdv?=
 =?utf-8?B?SE5CWnA3VmRqa1krWklJYkVaNkRHc2Y3SUlIYkNGUml3VWZlTThBRzROOUxV?=
 =?utf-8?B?NktvamRLTnR3RGZDenkzU0djblZvMVRmYnNsOERrZjlXdG9FWWNDN3lwSytv?=
 =?utf-8?B?aTR0djVnMnM2SEFEZ0xpREg3QXc3aW4wLy9kbHNUYmE5ZjQrVGN6Uk9yVUlQ?=
 =?utf-8?B?RTY1eVRrM0xEelVOdHRUTUkwNmY4MS9xTHBCZEUrQngwakFHS2QrM3JkOEFM?=
 =?utf-8?B?RWtWS3FDSWE2VnpMUmd2YVlJN0tQK1JUWGd5TDIraGZnNnJWZTRsQ244UXAz?=
 =?utf-8?Q?FUBT1uq+Zwu7KPz1TibDLv6NsFvYEk3xVVLijwb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557f2936-bd22-46de-b144-08d992ba4a10
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 04:38:25.7913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vtm1bVfVynHN7cFYQr+Y6iGAiVN4gqU0yPxtFfVPt7SHHuTw1dUeFde54FA6dKPk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4780
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



On 10/19/2021 9:45 AM, Luben Tuikov wrote:
> On 2021-10-18 23:38, Lazar, Lijo wrote:
>> On 10/19/2021 5:19 AM, Luben Tuikov wrote:
>>> A current value of a clock frequency of 0, means
>>> that the IP block is in some kind of low power
>>> state. Ignore it and don't report it here. Here we
>>> only report the possible operating (non-zero)
>>> frequencies of the block requested. So, if the
>>> current clock value is 0, then print the DPM
>>> frequencies, but don't report a current value.
>>>
>>> v2: Don't report the minimum one as the current
>>> one when reported one is 0, i.e. don't add an
>>> asterisk (Lijo). LT: It is conceivable that this
>>> may confuse user-mode tools if they scan and look
>>> for a current one, i.e. look for an asterisk, but
>>> they'll have to adapt and use other methods for
>>> finding power states of the chip--we can't report
>>> 0 as current.
>>> v3: Start the subject title with a verb. (PaulM)
>>>
>>> Cc: Alex Deucher<Alexander.Deucher@amd.com>
>>> Cc: Lijo Lazar<Lijo.Lazar@amd.com>
>>> Cc: Paul Menzel<pmenzel@molgen.mpg.de>
>>> Signed-off-by: Luben Tuikov<luben.tuikov@amd.com>
>>> ---
>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 ++++++++++++-------
>>>    1 file changed, 40 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> index f630d5e928ccfe..6fe792be77dbbb 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>> @@ -1040,7 +1040,8 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
>>>    }
>>>    
>>>    static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>> -			enum smu_clk_type clk_type, char *buf)
>>> +					   enum smu_clk_type clk_type,
>>> +					   char *buf)
>>>    {
>>>    	struct amdgpu_device *adev = smu->adev;
>>>    	struct smu_table_context *table_context = &smu->smu_table;
>>> @@ -1052,12 +1053,12 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>    	OverDriveTable_t *od_table =
>>>    		(OverDriveTable_t *)table_context->overdrive_table;
>>>    	int i, size = 0, ret = 0;
>>> -	uint32_t curr_value = 0, value = 0, count = 0;
>>> +	uint32_t curr_value, value, count;
>>>    	uint32_t freq_value[3] = {0, 0, 0};
>>> -	uint32_t mark_index = 0;
>>>    	uint32_t gen_speed, lane_width;
>>>    	uint32_t min_value, max_value;
>>>    	uint32_t smu_version;
>>> +	bool     fine_grained;
>>>    
>>>    	smu_cmn_get_sysfs_buf(&buf, &size);
>>>    
>>> @@ -1077,6 +1078,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>    		if (ret)
>>>    			goto print_clk_out;
>>>    
>>> +		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
>>> +						      &freq_value[0]);
>>> +		if (ret)
>>> +			goto print_clk_out;
>>> +
>>> +		/* A current value of a clock frequency of 0, means
>>> +		 * that the IP block is in some kind of low power
>>> +		 * state. Ignore it and don't report it here. Here we
>>> +		 * only report the possible operating (non-zero)
>>> +		 * frequencies of the block requested. So, if the
>>> +		 * current clock value is 0, then we don't report a
>>> +		 * "current" value from the DPM states, i.e. we don't
>>> +		 * add an asterisk.
>>> +		 */
>>>    
>>>    		/* no need to disable gfxoff when retrieving the current gfxclk */
>>>    		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
>>> @@ -1086,38 +1101,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>    		if (ret)
>>>    			goto print_clk_out;
>>>    
>>> -		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>>> -			for (i = 0; i < count; i++) {
>>> +		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
>>> +		if (!fine_grained) {
>>> +			/* We already got the 0-th index--print it
>>> +			 * here and continue thereafter.
>>> +			 */
>>> +			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
>>> +					      curr_value == freq_value[0] ? "*" : "");
>>> +			for (i = 1; i < count; i++) {
>>>    				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>>>    				if (ret)
>>>    					goto print_clk_out;
>>> -
>>>    				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
>>>    						curr_value == value ? "*" : "");
>>>    			}
>>>    		} else {
>>> -			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
>>> -			if (ret)
>>> -				goto print_clk_out;
>>> +			freq_value[1] = curr_value ?: freq_value[0];
>> Omitting second expression is not standard C -
>> https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html
> 
> Lijo just clarified to me that:
> 
>> well, i had to look up as I haven't seen it before
> 
> I hope the following should make it clear about its usage:
> 
> $cd linux/
> $find . -name "*.[ch]" -exec grep -E "\?:" \{\} \+ | wc -l
> 1042
> $_
> 

Thanks Luben!

Thanks,
Lijo

> Regards,
> Luben
> 
>> Thanks,
>> Lijo
>>>    			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
>>>    			if (ret)
>>>    				goto print_clk_out;
>>>    
>>> -			freq_value[1] = curr_value;
>>> -			mark_index = curr_value == freq_value[0] ? 0 :
>>> -				     curr_value == freq_value[2] ? 2 : 1;
>>> -
>>> -			count = 3;
>>> -			if (mark_index != 1) {
>>> +			if (freq_value[1] == freq_value[0]) {
>>> +				i = 1;
>>> +				count = 3;
>>> +			} else if (freq_value[1] == freq_value[2]) {
>>> +				i = 0;
>>>    				count = 2;
>>> -				freq_value[1] = freq_value[2];
>>> +			} else {
>>> +				i = 0;
>>> +				count = 3;
>>>    			}
>>>    
>>> -			for (i = 0; i < count; i++) {
>>> -				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
>>> -						curr_value  == freq_value[i] ? "*" : "");
>>> +			for ( ; i < count; i++) {
>>> +				size += sysfs_emit_at(buf, size,
>>> +						      "%d: %uMhz %s\n",
>>> +						      i, freq_value[i],
>>> +						      curr_value == freq_value[i] ? "*" : "");
>>>    			}
>>> -
>>>    		}
>>>    		break;
>>>    	case SMU_PCIE:
>>>
> 
