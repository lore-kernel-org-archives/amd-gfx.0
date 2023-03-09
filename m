Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26548C64EC4
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Mar 2023 11:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90A6A10E7F8;
	Thu,  9 Mar 2023 11:54:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A195210E7F8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Mar 2023 11:54:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmYmTtSrZwYJzTGmtEmWTlgRDrtXVhyOnykJ/pbbNFa1dBxrcwypda6lITcbJsasbc1N/MYmegtEdC210FYw6LqEc6eXcWdsvksVI5jf29svSELUOM6eE3fs/MPzv0Coavb0Or//Ft3Qm7xcncW8J2uxhlMW51p+KZ4PakiQnLLVMIHc3vw8I3YN5S0hX8axV9xbtoslsHxwY6UFhvCQmeRb1+E2VszPjVQ+7w9DN5n22PaZUb46lbjkzMpNSyFtqNMljEKIMau9UhZIbE28RtcDyXqz2sPToBPaHLDGyisFUv1LyoMbyWUYdKd9S4NiX3aSJ/NT3rycwVbvIWNyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2+FJFNPwIvaQJ39K+0yVhABIlTlzozlTD2dEAnudro=;
 b=IdoxuiFOu65k6TFHAOVU4eSe7WlFJ05BioVKc98db8E46pe2LyFbVf49QpQRrrAyPAgjNE/V3TrxqcY1/NVv2NLEaBoZwRtEPzH4Gg4/TkEqhjf4uKJDyO0woPhYN9/YFGypsOc+EEDz6HAntqTVfSLeA2/iu47vZHCTluPIFnUUGCruOTwTO2nA0BfHI/Ifyo7JdfeOhd5oY5yQOr80RdWI3b/zmztWbfQa5P1kOOmRbBNhhJZoMba2jiMVjal8JBqVV61ddSu4XJc3tgLtfO0a9+6AXVKODw638uGV7Oc3kDeolIcP10jIhIggXZAUFrvwokzXQMQlKRRanB82gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2+FJFNPwIvaQJ39K+0yVhABIlTlzozlTD2dEAnudro=;
 b=BD6/9e2uHrVZRgXldkAzs/klEkygF2EoweI4FtWUD0SzBsI3MYpYH4WtaCAKXjIgsiBYg/mAnZ4qVmQx0krUTZivU76qooxzDXBVVTdWA0yp6wZHy/MZlQ2avgmTxaDc5OKemTBpCMfTujZIz97//KZwKg/R0HMGXLoJ3Zn18NE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Thu, 9 Mar
 2023 11:54:53 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 11:54:53 +0000
Message-ID: <f37c9550-c9b8-3f3f-a819-cddd8b21fd9d@amd.com>
Date: Thu, 9 Mar 2023 17:24:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] drm/amd/pm: Fix navi10 incorrect OD volage after
 resume
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230308152014.3814372-1-alexander.deucher@amd.com>
 <20230308152014.3814372-2-alexander.deucher@amd.com>
 <DM6PR12MB2619B94DAFC8A9BF7504ED56E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2619B94DAFC8A9BF7504ED56E4B59@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 68cced45-5675-4439-cd44-08db209517f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wxnDl6r3WuDHqeflerQG1O/+2D4Jul5zfn6W6HAUuURmzWQc5+TZ++3rv611kLiqcL8qI6lycSNVdh4yRtdgCJV/e1BCNBaQXqOW4RUOiS2EoJxjgOTxobIvQ4dqHZxdYrGq8U5mFvW7uX7EescVXJrYeqZq1E8x97xonYh0t8Dhi6zJO6JOkcWzQOH30XyEg3ttSD9ncUMugcrVdDFX7YAgbNSI9h4mUaIhSZrw2QcZc47wBfQHLAowqd0dQfHyJHZp+xX1o7wZgBgauj/iii6LKYyk8yd9DJduNdlGPr31xlU+9wSCH2MqwPcJhTZBjruvcF/LCU8C4TZun2bpjo+EiUcO2o39YtdoLIx3AXFVtSYNOn6NUz7Ctl/EX0M77TOR2TTnStjf0lsY7KcE+cz0cBAX40gWEy9Zi/+jsUUj3C2LIT1pPaNiUbiVsToifbqcRY3ZNVpo0CDAW07124k8vWab90fyONOKamD+/xxnqRVGKIbdSjIZBoPE27Rwxd9q7dbHc4UmlW2clqIIz7KOz4kPsrPyKdbmXXc5GF+sWXkzFue8Y9jX51V6MEHzIlBpQHOrh4XpF+RKpzrFVYN753WDItMbAqQihNsYtvdNBJzUS5XR7OC2uMdNn8Bykb8tYUMlWbN8hS+GcO/+I8hmXjEJZNkT4BnTQ3gKQbPQy7IX1aPPt2Jt4bjA14lJ1ekk3b2Hbht4kV2VV5YiELXZvbo7qE87enHU3HWy7ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(6486002)(31686004)(4326008)(36756003)(66946007)(8676002)(66476007)(8936002)(2906002)(66556008)(41300700001)(5660300002)(86362001)(38100700002)(31696002)(6666004)(316002)(6512007)(6506007)(110136005)(478600001)(26005)(66574015)(83380400001)(2616005)(186003)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWFYUlJ4dkFJWmE2QTc4MjJVdmpDOFJXVy80WnFtVkp1Nmgvb05adEt4UFBk?=
 =?utf-8?B?OTkxZk1ZQlpuWVRYRThHQlRycjUxNWp2TkcvdG8ySWltZTF0cGNKSDg1TVhn?=
 =?utf-8?B?dEVSL3NINi9xRVB3Mk1MZUlHREVPdXhlMGxjSFdIODIvQU10OGdoWGIxcGJ4?=
 =?utf-8?B?cTFPZGdoY1BEZWJRelREWkJ1akdMVzhKb0U5L1pEOGRPN3F3cjZaTHJTQW5o?=
 =?utf-8?B?cnVndGpQU0dZU21TRDlpb3FqTWt5clVGaFRYU0pIS2h4ZjZLNG5uTTZkbEgr?=
 =?utf-8?B?N3VxdmwyaVJUWGx0cm9rY0NPbTloemFCRTg5YkhoUjFDenpIQ1lXWXVEaHZQ?=
 =?utf-8?B?ZC84R3l6aTIvV2xxczh1ZG9EeXRpak1nQWdjWkU4cC9SK0t4MGFPUnZ0emNN?=
 =?utf-8?B?Vk83MUViTTJ6eGg3TlFEZFdxRldhMEJiYWlzNmpFbFMvWm5EZk1leU0zbUxX?=
 =?utf-8?B?YVZpS2ZZY2FKNStWYWtkeUl6YWE0MzlOL2F4a1FlUktxTTdzb2VPUVRNNml5?=
 =?utf-8?B?ekwxZC9EVlpUVmd3amZUcmowMGdHV3VNdVUvYUZBbTJ0eS84TmpsLzVjL2lN?=
 =?utf-8?B?VDVINXB0cDhENWd6WUg1ZThSbkRkNmp6NWFCaEpTMDJudHBITkRBSWFYM01E?=
 =?utf-8?B?ZDJkWkFhY2JFR2lrN24zSWxrRzg2N0dsQUcwaHI1VjJ6NGtpT0VYdW9rc2Ns?=
 =?utf-8?B?UHhwNUlhNnlSbU1VcngyQWZyU0tPRzA1aXBIMWhpOVNNeDhBQTZEd2UwL1Qx?=
 =?utf-8?B?amE5cWFwd25Rd0xvejMxM1BaclFLVldtczRyQVltdjduZFA2dFhFVjBGcnVY?=
 =?utf-8?B?Z0JQS1Fpd01KTjI3N0VJY3JoQTFycmkyVXhJcmVUN1JlWnFjRWZnWGwxc2Yx?=
 =?utf-8?B?TkRNRkJybThwLzRoNC9BR3RPR2VxK2JFWUVSUWswWVNiUEhrSEZjd09zdG5O?=
 =?utf-8?B?VU44dFJSZ3lmMzlGK0ZjS2tQNkxEZFFIS2VGd2lPV09OenlLQy9OcHNtR2N5?=
 =?utf-8?B?NnNwdGZIbWlBYWVtUjdZb1BVT3oyT3F1TmUvNy82aFk1TDhiM2pqWnNMNnQ1?=
 =?utf-8?B?MGlRaE4zYWFaTE5nc0czaWJZVGtIQnQ0SG9xZkRFQmVDVWozdG44TzM1dHFV?=
 =?utf-8?B?SkdYcjFPWDlVVkVNM21HWnZad2tkUTFaUHUzUjM0bmErOEVQdjNYWTh0dmNs?=
 =?utf-8?B?eEtYZ3JNUU9hL1MzMFl4UTNGajNYdWxaamQxYmpibHF6YUVFUVFVdnV6YjhF?=
 =?utf-8?B?TmVsenl6dUZPeUo5QVJlMjVNZUsxS2dRMmt4clg0cWQ2N296ak5pUkpRUjBK?=
 =?utf-8?B?S05vYlRieEpBbjBRMmJuejZLbmtaTGhzdkUrdVNGYXpvMnh0NkE4K2FOSnpY?=
 =?utf-8?B?WjJ5bWRPdkU0M0dqZVRVbHJKc29kRFNnY0lRL2RNNjVFZEtDSUpUSmNyZ0dn?=
 =?utf-8?B?ZkxqM24xTTNjU25GbE1CanphUWl1b2l1WHNRdlhxcWhDNGlzeTJyempXN3ZT?=
 =?utf-8?B?cGh1aEkydHhmZmlIaXhVanZ0Y1VXYzg4K2E3L3pDZmFxR2Z4MHkrUGM3d1Bv?=
 =?utf-8?B?TjJhNzZuTXZ4ZWRXUld1bUxzZndGZWVWUExnSldOWU41YTdvUGo5cnhONC9y?=
 =?utf-8?B?MTNYdXpsSVp4cTFYUXhnZ2dQM0poMEJLaUlBOXg2d0pROVNaWDNJaldEK1Qw?=
 =?utf-8?B?T28rT01vMFNBOFBveTlub1ZMb0NZRW05czZxWWtuR01qdHNtTFNLWFBESmw3?=
 =?utf-8?B?MC9IQnlLTndJU2lHMXJCbFBMTDF4SThhdmhuOU1aS0t5VUFpbEM1MHdPWkwy?=
 =?utf-8?B?WXNMQzBZbDJpbnFPQ0tKNVJ1Um9HT3p4N1cxTWJzQjBBVDVueDdMZURhRVRI?=
 =?utf-8?B?dVQvZUVqdWNZczdXcSt4MFJKdTNnb2tXSFhQY0I5VlNIdUtrdG9UQ280VE5E?=
 =?utf-8?B?Tm9PZGwyUkF1QTlmdVFpb2JMaTJCUy9oZ1padnpPTkZHZ2lFTGpTb1BzUUwr?=
 =?utf-8?B?d0JYS0dPbmpxWW9oQTlpRnB3anNVWTRSWFZUTURta1BGWmJFT1VySWRiVE8v?=
 =?utf-8?B?cmpvSXRWY1djaXhaYU9BbWhrZzBHZkIyWm5pZXJsSm8rWi9lY2NaVERuU0hu?=
 =?utf-8?Q?5wz+QHhnz0GW4KCon/fK2GmNw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68cced45-5675-4439-cd44-08db209517f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 11:54:53.2060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lb/lswXptftr75oN9jxH5mOA8ycXTALE3iUPTfpImCbWO9aYLAGR9RIItuXBz/3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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
Cc: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/9/2023 8:11 AM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Sent: Wednesday, March 8, 2023 11:20 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Błażej Szczygieł
>> <mumei6102@gmail.com>; Quan, Evan <Evan.Quan@amd.com>
>> Subject: [PATCH 2/2] drm/amd/pm: Fix navi10 incorrect OD volage after
>> resume
>>
>> Always setup overdrive tables after resume. Preserve only some
>> user-defined settings in user_overdrive_table if they're set.
>>
>> Copy restored user_overdrive_table into od_table to get correct
>> values.
>>
>> On cold boot, BTC was triggered and GfxVfCurve was calibrated. We
>> got VfCurve settings (a). On resuming back, BTC will be triggered
>> again and GfxVfCurve will be recalibrated. VfCurve settings (b)
>> got may be different from those of cold boot.  So if we reuse
>> those VfCurve settings (a) got on cold boot on suspend, we can
>> run into discrepencies.
>>
>> Based on the sienna cichlid patch from Błażej Szczygieł
>> <mumei6102@gmail.com>
>>
>> Cc: Błażej Szczygieł <mumei6102@gmail.com>
>> Cc: Evan Quan <evan.quan@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 47
>> +++++++++++++++----
>>   1 file changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 95da6dd1cc65..68201d8e1c72 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2510,16 +2510,9 @@ static int navi10_set_default_od_settings(struct
>> smu_context *smu)
>>   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>>   	OverDriveTable_t *user_od_table =
>>   		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
>> +	OverDriveTable_t user_od_table_bak;
>>   	int ret = 0;
>>
>> -	/*
>> -	 * For S3/S4/Runpm resume, no need to setup those overdrive
>> tables again as
>> -	 *   - either they already have the default OD settings got during cold
>> bootup
>> -	 *   - or they have some user customized OD settings which cannot be
>> overwritten
>> -	 */
>> -	if (smu->adev->in_suspend)
>> -		return 0;
>> -
>>   	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
>> (void *)boot_od_table, false);
>>   	if (ret) {
>>   		dev_err(smu->adev->dev, "Failed to get overdrive table!\n");
>> @@ -2553,7 +2546,27 @@ static int navi10_set_default_od_settings(struct
>> smu_context *smu)
>>   	navi10_dump_od_table(smu, boot_od_table);
>>
>>   	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
>> -	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
>> +
>> +	/*
>> +	 * For S3/S4/Runpm resume, we need to setup those overdrive
>> tables again,
>> +	 * but we have to preserve user defined values in "user_od_table".
>> +	 */
>> +	if (!smu->adev->in_suspend) {
>> +		memcpy(user_od_table, boot_od_table,
>> sizeof(OverDriveTable_t));
>> +		smu->user_dpm_profile.user_od = false;
>> +	} else if (smu->user_dpm_profile.user_od) {
>> +		memcpy(&user_od_table_bak, user_od_table,
>> sizeof(OverDriveTable_t));
>> +		memcpy(user_od_table, boot_od_table,
>> sizeof(OverDriveTable_t));
>> +		user_od_table->GfxclkFmin =
>> user_od_table_bak.GfxclkFmin;
>> +		user_od_table->GfxclkFmax =
>> user_od_table_bak.GfxclkFmax;
>> +		user_od_table->UclkFmax = user_od_table_bak.UclkFmax;
>> +		user_od_table->GfxclkFreq1 =
>> user_od_table_bak.GfxclkFreq1;
>> +		user_od_table->GfxclkVolt1 =
>> user_od_table_bak.GfxclkVolt1;
>> +		user_od_table->GfxclkFreq2 =
>> user_od_table_bak.GfxclkFreq2;
>> +		user_od_table->GfxclkVolt2 =
>> user_od_table_bak.GfxclkVolt2;
>> +		user_od_table->GfxclkFreq3 =
>> user_od_table_bak.GfxclkFreq3;
>> +		user_od_table->GfxclkVolt3 =
>> user_od_table_bak.GfxclkVolt3;
>> +	}
> Thing is a little tricky for navi10...
> For navi2x, the vfcurve settings(GfxVfCurve.a, GfxVfCurve.b, GfxVfCurve.c) are not configurable by user. We do not expose them to user.
> So, we can just load the new vfcurve settings on resuming back without worry about overriding user's settings.
> 
> Unlike navi2x, user can customize the vfcurve settings(by setting GfxclkFreq/GfxVolt pairs) on navi10. More specifically:
> - On cold boot, btc was triggered and vfcurve line was calibrated
> - Driver calculated the target voltage(via navi10_overdrive_get_gfx_clk_base_voltage) for the point frequencies(GfxclkFreq1, GfxclkFreq2, GfxclkFreq3) and expose them to user
>     - e.g. point1 frequency/voltage:  500Mhz/ 0.75v
> - Then user customized the vfcurve line by setting a new target voltage for the point frequency.
>     - e.g. 500Mhz / 0.76v  --> 10mv added
> - On resuming back, the vfcurve line was recalibrated. The target voltage for the point1 frequency may be changed to for example 0.745v(for 500Mhz). Under such scenario, if we just restore user's settings(0.76v which will add 15mv),  that might not fit user's original intention.
> 
> So, for this case:
> 1. Either we add some new variables to record the voltage offset(10mv) from user's settings. And we restore the target voltage with new vfcurve line and voltage offset(that is 0.745v + 10mv = 0.755v for the case above). But still we cannot know whether it truely reflects user's original intention.
> 2. Or we just restore back to the new vfcurve line calibrated and remind user that original setting was dropped and they need to set new ones.
> 

As per the current driver logic, user may choose to override (voltage, 
frequency) points to define a new curve. Since the user is defining the 
curve, it's better to restore the same curve.

BTW, this patch doesn't seem to have any effect as the curve will be 
restored properly otherwise also.

Thanks,
Lijo

> BR
> Evan
>>
>>   	return 0;
>>   }
>> @@ -2733,6 +2746,20 @@ static int navi10_od_edit_dpm_table(struct
>> smu_context *smu, enum PP_OD_DPM_TABL
>>   	return ret;
>>   }
>>
>> +static int navi10_restore_user_od_settings(struct smu_context *smu)
>> +{
>> +	struct smu_table_context *table_context = &smu->smu_table;
>> +	OverDriveTable_t *od_table = table_context->overdrive_table;
>> +	OverDriveTable_t *user_od_table = table_context-
>>> user_overdrive_table;
>> +	int res;
>> +
>> +	res = smu_v11_0_restore_user_od_settings(smu);
>> +	if (res == 0)
>> +		memcpy(od_table, user_od_table,
>> sizeof(OverDriveTable_t));
>> +
>> +	return res;
>> +}
>> +
>>   static int navi10_run_btc(struct smu_context *smu)
>>   {
>>   	int ret = 0;
>> @@ -3560,7 +3587,7 @@ static const struct pptable_funcs navi10_ppt_funcs
>> = {
>>   	.set_soft_freq_limited_range =
>> smu_v11_0_set_soft_freq_limited_range,
>>   	.set_default_od_settings = navi10_set_default_od_settings,
>>   	.od_edit_dpm_table = navi10_od_edit_dpm_table,
>> -	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
>> +	.restore_user_od_settings = navi10_restore_user_od_settings,
>>   	.run_btc = navi10_run_btc,
>>   	.set_power_source = smu_v11_0_set_power_source,
>>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>> --
>> 2.39.2
