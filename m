Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833C4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A8560EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 04:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45A8560EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE9C6E079;
	Tue, 19 Oct 2021 04:50:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCA86E079
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 04:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUmVTA2o35WwT4k4DsOlmx6zXtmBu999bcuce6x8ObGpjG48eqNRL7Za2wnmy52SeQzmMijm2Y6M7uPXRaBbLl+7/rGz6b+a5/MoleD01i3Yk9QPX+6nbKFbRlkNZV1uuZEPrrQudSnD+yZtxwimdNQDGnwk291dlcxN7p5hkLwTTo7QAdIqNN7ld7TeHRt2Zgjlg9Iw8xFO+bB1u8vw4AFV6HYtvizkB3CkmY4yZZ5R+5vb2rr4oSHUpHHmm5P3QXOsxjraXYIDvK5QIq95jQ77myN175w6PLu+pWyf85oQmui9dcsj56KYoz8+fyy8U4nD/PjdGQOsVtoXH4pANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwjf8Vo+XbptFx8ZFSy/Qt4f+y6KNElCORwWQrRK3+0=;
 b=ni1jAcw+8eIq8RQbH+rry+vkJ7wV+A/uEl3Q2Hi4D2fdqXpe4+Y5Lz8fZdXja7c6pxDXLeM4es7boz0r8N+LafWI9gM2STqnIpZkgwoakxfgGX8HcDkWbaSHa3WHTdYg3PyxKdzQ0NPAuqidlyreZuifaadOKgstJL284u064L4ou6uL9U9wpGTGvqnxDVueffoQo+5ZHW379qoGJgmQTiOF343SJRoN7Taub4IJMJZXxbq2AA/2a3tvByFGdAOeRrqK1F2eVCcWmAEOSi5vBGSKKWwA1wKaerWqg/o7GTBXQnQNrvQVlf8rGj8jzSPXVpDulq77oVnE1D6MTtHtfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwjf8Vo+XbptFx8ZFSy/Qt4f+y6KNElCORwWQrRK3+0=;
 b=0TCy2JAFZd+Kjf9w1PHmv3EYwrna2weODY5l8sz7BgTr5XgLybztQ3zmaw0JCfcRJeph3/7Usru6CekkloKnBQZC70F/L8q/r2AhJ9W0CPBqTmh/1JA8Oy3tSSuDzrrM2QT7MHYTZ61e6mVPWMPBqddyRBq9/K/u4E3YSuzZGzY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 04:50:23 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 04:50:23 +0000
Message-ID: <65580f09-1ad8-07ba-b392-dc4aad2464ee@amd.com>
Date: Tue, 19 Oct 2021 00:50:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 4/5] dpm/amd/pm: Sienna: Remove 0 MHz as a current clock
 frequency (v3)
Content-Language: en-CA
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20211018234913.42349-1-luben.tuikov@amd.com>
 <20211018234913.42349-5-luben.tuikov@amd.com>
 <20faabaf-36a2-5836-2ec4-2da534149c6c@amd.com>
 <131b2193-8718-4f3b-4862-94aa18d0c209@amd.com>
 <fbd8a354-4f09-ffd9-ae0f-fdaa16903bc8@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <fbd8a354-4f09-ffd9-ae0f-fdaa16903bc8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.32.201] (165.204.84.11) by
 YT3PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 04:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d95469-095c-4e15-439d-08d992bbf5e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB177176F9BCFDF5DB2BF0E62499BD9@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:350;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+MQI4vjP5jzHWpXkgOL1UBBzflsRZYdP/qCAJop1gJiTO932dYiFUKgtf+7Y9DUxlBoDhYNL4omoGosYEW+aUk9NbSVRQNCytV97dCEs8Hd3qtW0yxDDWFgN6vi6zSJlsiMg6vOnd6WJzLqySgQrQ60SVIOZi0S3+5iXibr4FRvtNEuOlBvdM/K5CP4PPjLE+YOqRYxJZTYTnSkBpCZ565okndnKK0CPygHykrJoU3sFjWZj51WcUwS0KezwoDic2FScrH8oyqeE4NAKcNfVM31NrwVnXy2/UJSd1es74R4fxb71ou5me2tIyWh7q+EoJyeRHbje0xcB9oz/AWjyO0piPl34ouJnWCShRS6/T9dcJ4IavmcXNc55vLjnFahyJMV2mRjLP7SDVletzGxLLmo4jgSL5NGEIlJT8FxiHdT7YFgMlYskdVCq2i+4G5QnFaoo3lv24doTQ68VAt7xqB5l3jFtt1hAd7AFykVfiP4JTxNUzjVBpxV3EUbrubSP+ikzwsdhAoduXaT6gUSyronUZGqQVkMVAaouORKpvlHEAWJUFhmPH3jI50AE8uFXZm8pINLcAwKczLL8FLnc7CBIutKnj1nUVUrc8jGqvdY3Tf0vEg3epOKgg1rMZjiLfoVuWINrKwdmOjuWAuzzgQg5hI3OgsmM3B1JpjbL5O9VJHkwvDAKaqBJCfUcNkWXgRkl3ev43SFwKbixtU0e0iUH4MOe4fcJis4ZLuai/mDj4RDjJkb+tfcFtsG3iRQgKvIwo/+PU6dkvU9XTq7/16Fg5U1y3oBZfnX38aWDoiMKjch5XkVKRSsrVIMDj29
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(26005)(186003)(66556008)(86362001)(508600001)(53546011)(66476007)(966005)(4326008)(316002)(66946007)(31696002)(6666004)(83380400001)(2906002)(2616005)(44832011)(5660300002)(36756003)(956004)(31686004)(8676002)(8936002)(16576012)(54906003)(38100700002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFkTGltSEVmWUxwUHZQcnhacXJ4Ujh1emFlVEZST3ZCdkYyYmxMZmZRZWcr?=
 =?utf-8?B?Ynl0VStaMUdKMjJRQmlDWHpGdzNHOGhyWGdxR25MU2duZGFHSFpUQXR0bEJD?=
 =?utf-8?B?eWtSM29tSGVjd05laUFCVVNKcHRqK2wyUlRpZWlxUUc0TFhselBldXV2bmQ0?=
 =?utf-8?B?NVMrV3NJM1BoaVVQSnB3Z3VKUFVJdUxzWXNPSWtPQW8xUzBlZ2NibFJNSlZy?=
 =?utf-8?B?TXFDT0d3MzUxcXEyaEhUaEhmSFhwRmlMbWFHZlV2SUoyZ0syOSs0Y1B6Q1BH?=
 =?utf-8?B?a0t1b3Z5K2NnSmpCaFA3TzJTa2xiL09rcDdxTVpFUVpDa0N0Vm5KdTUyZnpO?=
 =?utf-8?B?Z21CLzVBZlhZT0J1a2c4cHg2S1BtZm5QTjJWbjR6WHRiRW9URlRPUzRlMDZv?=
 =?utf-8?B?ZTdESXl2b2tBQ2ZIQlA4alFvOXoyUmxyVU92TmVHdzlITEs1akQ1bDhxcno2?=
 =?utf-8?B?SktlYnM4SmZLOTZWTjlNa3U3SnBmOGRmVzRRZlJtczlCV3VKWVFDUVVyR0py?=
 =?utf-8?B?SXU1Wi9ENDBHM1VHamNIajl5cEJieWd6a200K0RnYk9pUnBOTG5JZU43VXd6?=
 =?utf-8?B?Vm1xRkpweHo2dnZsSDErSVlnT091SGMxbU4xa0dkbnFKa3BSYnYzMHB1Y1Ev?=
 =?utf-8?B?ZGxkelZoblFBZzZaR09qRjJyODZNakVhWUNKZnc5Wmk2VytJQU5BKzEraFV4?=
 =?utf-8?B?bmpwVW94VEtIN055OWcvYWJJTThka3FuQUF3c3NRVUczMDlueTM2RS95azJo?=
 =?utf-8?B?THRRbnNHM1FlcXFtYlVSeWlPdVpXOFE3emltNGF0WnR6Y0tMVC8rSUdPUkRt?=
 =?utf-8?B?RVFUa1lQUjVFN0F6TXB1OStjUjRyVlBIQTlEQmtJTWhxMGtOMzVBSS84dW1Z?=
 =?utf-8?B?MDk5c0lTZEVyRGwrRVMyejFKN1lwaVhCR2Yyc21qSGorZVlLUUJhR0VKbzEv?=
 =?utf-8?B?VzJySWJFNi9WbXlPQlZOZzZRRC9yUFRpK1VtZWNSQkFuOU1GNFF5SnJnaGo0?=
 =?utf-8?B?RWY1QmRkYUR3RlRWN0JhNGcyRmVjcmVoQXRNK09ySU9LaDlXV1BqazFyWTZs?=
 =?utf-8?B?Qmg0MGRsNW5CVERaS1pqUnNpYVdWM2xzS01Rb1BySFdKQzRBV1p1L1Zzd05o?=
 =?utf-8?B?WVRuaFVhOENOci9rWVUwQ3R2SmxuSmY1cFB2ZlhjR0JVWE5BV0Y3Z0xiKytN?=
 =?utf-8?B?N1BXcjRVcS84Q1QxcUxQc2ZtMG1vVGVreDZ5TG9rY1l4TUtUNVpOMDFiL0Rk?=
 =?utf-8?B?S1dPU29sZGNpZ2ZWRUtTMFJleG9DTGtmRnYxQ2ExMEswOUExRVJ5TzgwSUIy?=
 =?utf-8?B?QWNSRVlGVXFsM0FzNElTTTBtU2c1MjBaVW5IQ1FLRXFMdnBLUElVZnpobzEy?=
 =?utf-8?B?eWdFa1QrK2pkL1JJM2pwblZFd2lyL1ZkWGlvUUdEQ2lOTmtLYVFOejhGWDRw?=
 =?utf-8?B?Mjh1a2tPS2JlZlMyQzM0SjRxL0trVzB5NmVCeVFFOFhDbUtNVHlYaEU0cDdp?=
 =?utf-8?B?NlZhVll1bGhXUGltblJDcmd3TlloSzIwT3lrSU5TRCtyYk4zKzkxT2hZL1Fw?=
 =?utf-8?B?ZnhuWndIS0Iwcm5MelZSN01KNzRtdUZyWmI0OVY2eHhZd2JQdlpxbFBYT0NK?=
 =?utf-8?B?d29hbFBwSDh3Wk9DdVBBbHR0aWJ1VTFtQmJlTDF0eHZpQWlEL2ljdi92b1NQ?=
 =?utf-8?B?ZkFWelR2MU1BbTRWcWNiNnVyaDQ0UUVwSUVvZ2kzbVd1eE00ckhDR2VzUTEw?=
 =?utf-8?Q?hGYDCBmY0Wi95O5Ecn+B2QO1H6Iiz+Q/UWHiPEm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d95469-095c-4e15-439d-08d992bbf5e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 04:50:23.2675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMUUwMhkdUoxo/BrxiDF4/hLmtcnlc7kyo+M9KXfdwSNttZkbUclM/u1YjBf1grU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
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

On 2021-10-19 00:38, Lazar, Lijo wrote:
>
> On 10/19/2021 9:45 AM, Luben Tuikov wrote:
>> On 2021-10-18 23:38, Lazar, Lijo wrote:
>>> On 10/19/2021 5:19 AM, Luben Tuikov wrote:
>>>> A current value of a clock frequency of 0, means
>>>> that the IP block is in some kind of low power
>>>> state. Ignore it and don't report it here. Here we
>>>> only report the possible operating (non-zero)
>>>> frequencies of the block requested. So, if the
>>>> current clock value is 0, then print the DPM
>>>> frequencies, but don't report a current value.
>>>>
>>>> v2: Don't report the minimum one as the current
>>>> one when reported one is 0, i.e. don't add an
>>>> asterisk (Lijo). LT: It is conceivable that this
>>>> may confuse user-mode tools if they scan and look
>>>> for a current one, i.e. look for an asterisk, but
>>>> they'll have to adapt and use other methods for
>>>> finding power states of the chip--we can't report
>>>> 0 as current.
>>>> v3: Start the subject title with a verb. (PaulM)
>>>>
>>>> Cc: Alex Deucher<Alexander.Deucher@amd.com>
>>>> Cc: Lijo Lazar<Lijo.Lazar@amd.com>
>>>> Cc: Paul Menzel<pmenzel@molgen.mpg.de>
>>>> Signed-off-by: Luben Tuikov<luben.tuikov@amd.com>
>>>> ---
>>>>    .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 60 ++++++++++++-------
>>>>    1 file changed, 40 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>> index f630d5e928ccfe..6fe792be77dbbb 100644
>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>> @@ -1040,7 +1040,8 @@ static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_tabl
>>>>    }
>>>>    
>>>>    static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>> -			enum smu_clk_type clk_type, char *buf)
>>>> +					   enum smu_clk_type clk_type,
>>>> +					   char *buf)
>>>>    {
>>>>    	struct amdgpu_device *adev = smu->adev;
>>>>    	struct smu_table_context *table_context = &smu->smu_table;
>>>> @@ -1052,12 +1053,12 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>>    	OverDriveTable_t *od_table =
>>>>    		(OverDriveTable_t *)table_context->overdrive_table;
>>>>    	int i, size = 0, ret = 0;
>>>> -	uint32_t curr_value = 0, value = 0, count = 0;
>>>> +	uint32_t curr_value, value, count;
>>>>    	uint32_t freq_value[3] = {0, 0, 0};
>>>> -	uint32_t mark_index = 0;
>>>>    	uint32_t gen_speed, lane_width;
>>>>    	uint32_t min_value, max_value;
>>>>    	uint32_t smu_version;
>>>> +	bool     fine_grained;
>>>>    
>>>>    	smu_cmn_get_sysfs_buf(&buf, &size);
>>>>    
>>>> @@ -1077,6 +1078,20 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>>    		if (ret)
>>>>    			goto print_clk_out;
>>>>    
>>>> +		ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0,
>>>> +						      &freq_value[0]);
>>>> +		if (ret)
>>>> +			goto print_clk_out;
>>>> +
>>>> +		/* A current value of a clock frequency of 0, means
>>>> +		 * that the IP block is in some kind of low power
>>>> +		 * state. Ignore it and don't report it here. Here we
>>>> +		 * only report the possible operating (non-zero)
>>>> +		 * frequencies of the block requested. So, if the
>>>> +		 * current clock value is 0, then we don't report a
>>>> +		 * "current" value from the DPM states, i.e. we don't
>>>> +		 * add an asterisk.
>>>> +		 */
>>>>    
>>>>    		/* no need to disable gfxoff when retrieving the current gfxclk */
>>>>    		if ((clk_type == SMU_GFXCLK) || (clk_type == SMU_SCLK))
>>>> @@ -1086,38 +1101,43 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
>>>>    		if (ret)
>>>>    			goto print_clk_out;
>>>>    
>>>> -		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>>>> -			for (i = 0; i < count; i++) {
>>>> +		fine_grained = sienna_cichlid_supports_fine_grained_dpm(smu, clk_type);
>>>> +		if (!fine_grained) {
>>>> +			/* We already got the 0-th index--print it
>>>> +			 * here and continue thereafter.
>>>> +			 */
>>>> +			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", 0, freq_value[0],
>>>> +					      curr_value == freq_value[0] ? "*" : "");
>>>> +			for (i = 1; i < count; i++) {
>>>>    				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
>>>>    				if (ret)
>>>>    					goto print_clk_out;
>>>> -
>>>>    				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
>>>>    						curr_value == value ? "*" : "");
>>>>    			}
>>>>    		} else {
>>>> -			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_value[0]);
>>>> -			if (ret)
>>>> -				goto print_clk_out;
>>>> +			freq_value[1] = curr_value ?: freq_value[0];
>>> Omitting second expression is not standard C -
>>> https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html
>> Lijo just clarified to me that:
>>
>>> well, i had to look up as I haven't seen it before
>> I hope the following should make it clear about its usage:
>>
>> $cd linux/
>> $find . -name "*.[ch]" -exec grep -E "\?:" \{\} \+ | wc -l
>> 1042
>> $_
>>
> Thanks Luben!

You're welcome. I'm glad you're learning new things from my patches. Would've been easier if you'd just said in your email that you've never seen this ternary conditional shortcut before and that you've just learned of it from my patch. (Or not post anything at all in this very case and get in touch with me privately via email or Teams--I would've gladly clarified it there.)

I hope the find+egrep above is also edifying, so you can use it in the future in your learning process.

Regards,
Luben

>
> Thanks,
> Lijo
>
>> Regards,
>> Luben
>>
>>> Thanks,
>>> Lijo
>>>>    			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_value[2]);
>>>>    			if (ret)
>>>>    				goto print_clk_out;
>>>>    
>>>> -			freq_value[1] = curr_value;
>>>> -			mark_index = curr_value == freq_value[0] ? 0 :
>>>> -				     curr_value == freq_value[2] ? 2 : 1;
>>>> -
>>>> -			count = 3;
>>>> -			if (mark_index != 1) {
>>>> +			if (freq_value[1] == freq_value[0]) {
>>>> +				i = 1;
>>>> +				count = 3;
>>>> +			} else if (freq_value[1] == freq_value[2]) {
>>>> +				i = 0;
>>>>    				count = 2;
>>>> -				freq_value[1] = freq_value[2];
>>>> +			} else {
>>>> +				i = 0;
>>>> +				count = 3;
>>>>    			}
>>>>    
>>>> -			for (i = 0; i < count; i++) {
>>>> -				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_value[i],
>>>> -						curr_value  == freq_value[i] ? "*" : "");
>>>> +			for ( ; i < count; i++) {
>>>> +				size += sysfs_emit_at(buf, size,
>>>> +						      "%d: %uMhz %s\n",
>>>> +						      i, freq_value[i],
>>>> +						      curr_value == freq_value[i] ? "*" : "");
>>>>    			}
>>>> -
>>>>    		}
>>>>    		break;
>>>>    	case SMU_PCIE:
>>>>

