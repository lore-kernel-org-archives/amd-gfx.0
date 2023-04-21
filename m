Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D55AC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 09:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5138210EDD7;
	Fri, 21 Apr 2023 09:30:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12BF210EDD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 09:30:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEocTFy14V1zKhbghtPxwHCCIRlFYaGAlT4qvS6f6OiI13yzYahqwfJuFfXa8THFPuziKrTpKZaVhVjK6v2aEilPU0+yztU9wx6TWS2tVz5VuB4H1DfLsHtGcRKj3x/V5630s1ughv1cJYeMF57qgTmGS+RhRG9J3kdAYcL3TDx/nb8DVM60rHoUqCE8z+O6k9dJu9ivne6ZzHScePVRzA1AqzsA4JGTToRaVf3ukwFVhcrrld6K5mJap8kxKixNCrwtM8Yyy/qhjsdCGMggju1A5BEDVkoGYTu0bOk2cLaOO7mtyRs2/kuGPtDTD92iSnXQPmppGMYzAikPEDczLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTdYPtJPtwwYUfpa2rDzE1B3CZKUFoLKJXyijNXNcZI=;
 b=kjddWqcIC4cXm5x2RX1RTPgzzGG3MIWgz8eJee/sN2q7o/uFoSygu2BEPePgouKoUkLk4rFBCnNAsd5wHuF8I/bjvRV0E8j0X3IXG03QOyQxnwsYQkm5Rh1Udc/d0Bbp/X/NVZ4TTO9YjpKtw5qAuCX0LMHc1vBBqPXZpuNutdA++BlloEwbriROWfceyvzMvwZ0QjnRl57jmHUB5UYKx9onXREq6a88COQ5zqp1EMS1AGnfmta0ALWAozk6VaSPeg7WDngngZYfR/iSw6G6y0ohC+rvcefQM2qbRvXW4aIVaUwGVD+UkcrUx9yYFzPGZEmWqzZ4SNdYdfbIJQzlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTdYPtJPtwwYUfpa2rDzE1B3CZKUFoLKJXyijNXNcZI=;
 b=JK3msU0TKDRZx/aQuf38c0MLAf9d/5SBImBzUIcybMJ17ywrYtTrrv0VMK7L2hclOORRCi6olCpUUVvFZdcVl15gfMUK6LXr8TUpq3d5J30y+59x1GTQOrMWYSVigOM2ylt3p77ufTLZxdrzM1rwJz5gfhmYUmhmAEAANW1hHUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 09:30:37 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3a3f:6779:52bb:baf7]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::3a3f:6779:52bb:baf7%6]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 09:30:36 +0000
Message-ID: <c35227ed-d18c-6e49-986b-aa10fe2148ad@amd.com>
Date: Fri, 21 Apr 2023 15:00:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230421072835.842112-1-evan.quan@amd.com>
 <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::15) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5861ad-e5ec-4ddc-3d1c-08db424b0ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWlQyvhGPcWvDSxoPRQxZ6Dau/AXJx1i7PNKTIFJoOx1bhAl3QVKhzlBsruci+ZjILi3yUd0rKUvydsoCE63aXqL6yGRY7sA9CVocvkstHsFaGdervrfR1542yJMv2haoMCYM1D8RKCoVqTEjISTqxre9y4FT2S7YDixMz7DkW91uP7LX3kGzYpLwxok649M7yyz7kr2O4gig3DbmMeVpsxVtd2dTfuojQvOHtqXlfUf4ONeawBXKKxa7cRmpYNZAvAtUJm0EBN1itHjh5PsJNnYV8U4M6/2B/QDigfh4GBdQTmovIu6mmuyN96q3xkMzum8zZavA1vv+d5Nh3HHeqWCM3/tJWr2b1WVOwPljtr5qDhGRDDqkVDxkzcTsxCIuLwMSU0fsGKKYPzB1dqfkHe+72AINuasN5df651cE4ESlPkjf9gJ9GlcNIsSyCQ6YPAYUMAXdfvdvkDwvtUBY5SMWo1xTSIsHTL5htYcdXNpK2+A0x3g5uKkwO+ROfSGvXS5R4Y5GB1JQ/O8nOzdspDJefcdVIVqbaPESmWhGRjWMxHmXYd8/VvVHHDYMizvwEHDd02dIKreCJ1W4CIfxDYQcRO9euJuFs6wl6QhczK5FgHYAzW33PQTBq2qM0YsnUlQDA1Q8/71rr3u6MOWVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(186003)(2616005)(53546011)(6512007)(26005)(6506007)(8936002)(8676002)(36756003)(54906003)(5660300002)(110136005)(86362001)(31696002)(41300700001)(316002)(31686004)(38100700002)(4326008)(66946007)(66476007)(66556008)(6666004)(6486002)(478600001)(2906002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1lUU1waUlsSFBOTEdjTGJZNmEzL0xJbHk0OEthVkMxQTBTc0RJUE05czY3?=
 =?utf-8?B?M3lzeWZWUEJkZGgvNXR6dGxIVUsvQjFDeDVaa3ZZU1F5WTZsdld1OUpDUG5O?=
 =?utf-8?B?aFFuM1NYVjlwM2lZakZQODFFdENnTFN2S0RraFlYbEdVWTRYUSsyQzFBVE9h?=
 =?utf-8?B?Y0tGcTBOU3kwY3dvZG5uSmJML1NPR0QvMUhOY2ZNNnZhRm51WDFPbnI3T0I3?=
 =?utf-8?B?dmxOOXdYT0hGaGNra3Jac2dveUtkSlNZTTNwVkpxYjNhbDBHOWl0WW91enpK?=
 =?utf-8?B?YkFxanNtQ1FLWGNIbm94YzRHa3FGbEhGbXRTVWQ1aVM0azVPRTJOZS8vUmtN?=
 =?utf-8?B?QUg4d3VkR0syN1ZHM3B5eERzOEV1RUNFL0F4Qk96VWVua3F1MSt2RVpYMzZX?=
 =?utf-8?B?YkJPdjBTYy8vTjZySVlKMHJsUzdUVWIwcExheDZDNElDTkFCN2JNVEVEeS9P?=
 =?utf-8?B?dEhIQm9selJHanBoR2FpOEpsYWhHc25rdnR1bW4yRDQ1ZGxhOTIxSlo0cXlF?=
 =?utf-8?B?ZFNGcDRhbUoyZkFFYy9XcjRvYmRzaWZVOEZLMzdsSit2K1RWQ1FBd2ZpK3Az?=
 =?utf-8?B?bk1IN09weGR6VzNhYmY0Y0NiVjVPcHAxekRQMU1hSmtGYWlFT1VKTWFxV2l2?=
 =?utf-8?B?N2VMU0wzMnZXc1NFcUVUOHp4dVlRdFlucHZyMTRodzdxeWQ1dllMa2tONzVF?=
 =?utf-8?B?dmJyQkVTaVVxTUlHM2JEZ0NySURLRzdxY1JHZ3VYM2RGb1ladWRlaytKMEV6?=
 =?utf-8?B?eVdpRDRUck05Tm93cFVjQU9Ca3Ura3FkVk5XTFhEMFN1a1JwWEVGb0pyVGhi?=
 =?utf-8?B?Z0d3QUxLZ3VhNWdCNTEydzFWUndPVXNvYjJqbDlRSnE2TjdKNXY0NTFFL1Zw?=
 =?utf-8?B?dFI3VEI4dEJGR3JQSU8zeUl6MlQ5T2lSVUxqWENQZkZxcFB0aGd1ekhxbTNv?=
 =?utf-8?B?OVcxbm5kRnRQSHhoa3ZpSU9lUHN6RElNbzJqUzUrVUp3dlE3bVlONXU4Y3ZR?=
 =?utf-8?B?YUh4NEtidTg4WlpwQTYxdWQ2RmlmN2FLWGhwSUs3bjJnYVRFUVBRUWFKTTlz?=
 =?utf-8?B?OXpRQ2l2TUhDeDJ4TzRsSTNvLzhQUm9tcFFzdytJRk85b3F1Qjg3NDd5SHFI?=
 =?utf-8?B?Q1RqTTNKZGd6YkVyWGNjbHgzN1cwaTN4Zzc3NWo5MWxSWVU0ZnNPajdtVmFJ?=
 =?utf-8?B?ZmIvTVduQ0RtMHlEUDYyV2RxZHNNYVorVUZ6NW5wd1EyUFQxRWFBS3VwUUJX?=
 =?utf-8?B?Y25Ua3lKUHhUMU5OZ01IWDJTTmQwNTJKS1grTk5Hdi9oNmFzckZHcTBNOHNN?=
 =?utf-8?B?NnlkRDZaMnA0RmY5OWE2dHZqRUk3VzRkM1pkNWFmU2ZKZ25idWxJNlZYMGZp?=
 =?utf-8?B?djR2V1ZkKzgyT3hwYUU3NTBoY3Zla0ZLK0JUd3pnZWpHWTVGUGhRRXRYL1Mz?=
 =?utf-8?B?cGp3OG9wMlJTWWczOFNxWWp2ZzlzNWRWYjR5OTRNaGYrNHlUUzJCNDFmZjNv?=
 =?utf-8?B?WXhYSE92UU92MzZwRVFwajNnM0N0T2YzNG9uWjJmQVl2bGIvNFZpeitvMUUz?=
 =?utf-8?B?MEpBM2tSRXdXOUo2VHVTaUgrVDhUSlIxbWd6T0huT1VDOXJpR0JhUk8xTzBP?=
 =?utf-8?B?VmtpdGszSXZnblhCQ01HOVNGTTF5NTBNdGwwcGtxc1p2aFphcktxK2tOT0hC?=
 =?utf-8?B?ck1PbE9IMEhBRjJTNzkrbWp6WC9xMkFLMEZhbVFsT1pHVWdxOWJDbVdKd0t5?=
 =?utf-8?B?WnFXZmxQcVpXQ2VnZ0JUSE9hd2hXNDQ4SURZWlBPM3lRalhnL3RRWjhaNGFR?=
 =?utf-8?B?MXdOQyszMTMvREUySEpTaDNoQ1ZENFE5aXB1dklGVVRzeTJ1a1FpRlNxallk?=
 =?utf-8?B?eXhpMUM3cHhLb1RXaHBUcFJrY0luaDFkWWp4WGhTY1ZCM3V0M3daWjFYR1dV?=
 =?utf-8?B?TGdXSituMWM5aVlJUFo5b0gvdEIrMjVQdHUyczRvSjMwdGo5d25GWVBTTk1P?=
 =?utf-8?B?VzZ3NFc4WUt4U3BYU1BqazFXUUFSWUQyZkFMcHhJZ0JhaG42NHIweU43ditk?=
 =?utf-8?B?eE9XSzhuQmd0WmxEeFF0UUt5NUwybjZFRXQ5OFNpQi8wL2ZpU3ZIellvclR2?=
 =?utf-8?Q?YiAHbznKgeSQivoFmaZK3nsx5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5861ad-e5ec-4ddc-3d1c-08db424b0ff5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 09:30:36.7417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcZ1ObrpcqVgLBL9SjDc9Chp0fb660+b6wf3FRT5yZ920IAvJ7Bf9aSKWgtI7MiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 4/21/2023 1:02 PM, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> This seems able to address some audio noise issue observed per customer's feedback.
> 
> Evan
>> -----Original Message-----
>> From: Quan, Evan <Evan.Quan@amd.com>
>> Sent: Friday, April 21, 2023 3:29 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
>> <Mario.Limonciello@amd.com>; Quan, Evan <Evan.Quan@amd.com>
>> Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
>> some sienna_cichlid SKUs
>>
>> Disable the pcie lane switching for some sienna_cichlid SKUs since it
>> might not work well on some platforms.
>>
>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>> Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
>> ---
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++---
>> -
>>   1 file changed, 74 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index 4b91cdc3eaa0..e7223513e384 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -2067,33 +2067,94 @@ static int
>> sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>>   	return ret;
>>   }
>>
>> +static void sienna_cichlid_get_override_pcie_settings(struct smu_context
>> *smu,
>> +						      uint32_t
>> *gen_speed_override,
>> +						      uint32_t
>> *lane_width_override)
>> +{
>> +	struct amdgpu_device *adev = smu->adev;
>> +
>> +	*gen_speed_override = 0xff;
>> +	*lane_width_override = 0xff;
>> +
>> +	switch (adev->pdev->device) {
>> +	case 0x73A0:
>> +	case 0x73A1:
>> +	case 0x73A2:
>> +	case 0x73A3:
>> +	case 0x73AB:
>> +	case 0x73AE:
>> +		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
>> +		*lane_width_override = 6;
>> +		break;
>> +	case 0x73E0:
>> +	case 0x73E1:
>> +	case 0x73E3:
>> +		*lane_width_override = 4;
>> +		break;
>> +	case 0x7420:
>> +	case 0x7421:
>> +	case 0x7422:
>> +	case 0x7423:
>> +	case 0x7424:
>> +		*lane_width_override = 3;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +

Isn't this applicable only on Intel platforms? If so, better to do a 
processor check rather than maintaining max width based on DID.

Thanks,
Lijo

>> +#define MAX(a, b)	((a) > (b) ? (a) : (b))
>> +
>>   static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>>   					 uint32_t pcie_gen_cap,
>>   					 uint32_t pcie_width_cap)
>>   {
>>   	struct smu_11_0_dpm_context *dpm_context = smu-
>>> smu_dpm.dpm_context;
>> -
>> -	uint32_t smu_pcie_arg;
>> +	struct smu_11_0_pcie_table *pcie_table = &dpm_context-
>>> dpm_tables.pcie_table;
>> +	uint32_t gen_speed_override, lane_width_override;
>>   	uint8_t *table_member1, *table_member2;
>> +	uint32_t min_gen_speed, max_gen_speed;
>> +	uint32_t min_lane_width, max_lane_width;
>> +	uint32_t smu_pcie_arg;
>>   	int ret, i;
>>
>>   	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
>>   	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>>
>> -	/* lclk dpm table setup */
>> -	for (i = 0; i < MAX_PCIE_CONF; i++) {
>> -		dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
>> table_member1[i];
>> -		dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
>> table_member2[i];
>> +	sienna_cichlid_get_override_pcie_settings(smu,
>> +						  &gen_speed_override,
>> +						  &lane_width_override);
>> +
>> +	/* PCIE gen speed override */
>> +	if (gen_speed_override != 0xff) {
>> +		min_gen_speed = MIN(pcie_gen_cap, gen_speed_override);
>> +		max_gen_speed = MIN(pcie_gen_cap,
>> gen_speed_override);
>> +	} else {
>> +		min_gen_speed = MAX(0, table_member1[0]);
>> +		max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
>> +		min_gen_speed = min_gen_speed > max_gen_speed ?
>> +				max_gen_speed : min_gen_speed;
>>   	}
>> +	pcie_table->pcie_gen[0] = min_gen_speed;
>> +	pcie_table->pcie_gen[1] = max_gen_speed;
>> +
>> +	/* PCIE lane width override */
>> +	if (lane_width_override != 0xff) {
>> +		min_lane_width = MIN(pcie_width_cap,
>> lane_width_override);
>> +		max_lane_width = MIN(pcie_width_cap,
>> lane_width_override);
>> +	} else {
>> +		min_lane_width = MAX(1, table_member2[0]);
>> +		max_lane_width = MIN(pcie_width_cap, table_member2[1]);
>> +		min_lane_width = min_lane_width > max_lane_width ?
>> +				 max_lane_width : min_lane_width;
>> +	}
>> +	pcie_table->pcie_lane[0] = min_lane_width;
>> +	pcie_table->pcie_lane[1] = max_lane_width;
>>
>>   	for (i = 0; i < NUM_LINK_LEVELS; i++) {
>> -		smu_pcie_arg = (i << 16) |
>> -			((table_member1[i] <= pcie_gen_cap) ?
>> -			 (table_member1[i] << 8) :
>> -			 (pcie_gen_cap << 8)) |
>> -			((table_member2[i] <= pcie_width_cap) ?
>> -			 table_member2[i] :
>> -			 pcie_width_cap);
>> +		smu_pcie_arg = (i << 16 |
>> +				pcie_table->pcie_gen[i] << 8 |
>> +				pcie_table->pcie_lane[i]);
>>
>>   		ret = smu_cmn_send_smc_msg_with_param(smu,
>>   				SMU_MSG_OverridePcieParameters,
>> @@ -2101,11 +2162,6 @@ static int
>> sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>>   				NULL);
>>   		if (ret)
>>   			return ret;
>> -
>> -		if (table_member1[i] > pcie_gen_cap)
>> -			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =
>> pcie_gen_cap;
>> -		if (table_member2[i] > pcie_width_cap)
>> -			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =
>> pcie_width_cap;
>>   	}
>>
>>   	return 0;
>> --
>> 2.34.1
