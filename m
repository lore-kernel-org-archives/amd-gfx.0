Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D235E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0280610E117;
	Mon,  9 Oct 2023 14:29:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFB010E119
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htaivi+qZhEmFjUsuXT6RvsNSyHLtZpX10YEu6QuANHpULcUJmaXZfyr5Iq5uj1PahWcggQjekZ1zQrdLkg0y6yu7lt1U+orfYLLFshkroc7omknidKj2M+JiCitUlCMgg1OHUgl6HDHhYKSZ9GMvrtPSqihXzELPK/6XlZVQru5kJMdo81bUTggt7mq5PJWFD7sSgekhwgCyTANC9qq6vkQpy5vSIVv/CdeinW1VxxorJNi0ilHRicOpo9efEJRZw6t5H/I5VTqa1giASiXD0hvZXT2SVaucEVh+TJpwTHWtc7UXK4HwElFfJ03CW7x+c8QuiO+RSFypKhwwfjHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WSpoKR1Maa0Yn63AGCupgR3iN0K58mQPKcW4F21WeQ=;
 b=JKAFq05qaRlk5x1/z3iBd2C2p2gJuBL/loOQQvCoSO469fwRmE3BXFngyOyFyynpBPpCrXuDPEZJ65gqQUd0phPvg/8D34Ns+2Anp79TZQxfC5ijna2kTYlLWS/XCo4hTIf/ekBDB0ERXoynMNsAMV/+yx/tGPL633mftthbtEb/xmOYFl7WBhn/ZmVcfrDnYiem6CTsnDolYqGZ77VJmkosrogcJjaEL0dpsVbvwg64UGM439M9eRuDUNpYHO16h76p0N794C1Gws/Vr0VjNyBKcFMGkUiKhuZOG8RXfGLMZNKuzmHtcJp6lzMgd7CHAJnnDZ67Hx+w3+3nT5FwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WSpoKR1Maa0Yn63AGCupgR3iN0K58mQPKcW4F21WeQ=;
 b=ACnhfdq2prrvA2DYgLmvGQ+vgQmrkLHsz0G4JHKhLhakBjluozlXLh3jFH9TcYst4oIzMaoDokZkGJL2CuPsDEBLEVHZbbP+9kD7FA1lAEW0JvKtd10kdxtoHTu+5ZZQ8Zc+OtaWVN3ul/BdKHvHw/uRRDkl8jZAqxurQSDvZkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Mon, 9 Oct
 2023 14:29:18 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 14:29:18 +0000
Message-ID: <20329c6e-493a-3f4a-7593-cd0c3adbf119@amd.com>
Date: Mon, 9 Oct 2023 19:59:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 3/3] drm/amd/pm: Use gpu_metrics_v1_4 for SMUv13.0.6
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231006144140.566546-1-asad.kamal@amd.com>
 <20231006144140.566546-3-asad.kamal@amd.com>
 <04f987dd-bb68-48c6-7534-d9a40942c50f@amd.com>
In-Reply-To: <04f987dd-bb68-48c6-7534-d9a40942c50f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b9b352d-f768-4a3d-e41a-08dbc8d41eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2sb24j36+InO2DvjM0XMRIxfyNoq5cj1kReGenXwoaupa8EygHCJzZOdECOHOhn70jSAEP2KJ5vkbTZEfLayhhB4M5odhipTmctpbjwnSjkX+ZDJkhSm4ezSVBlDQvhl8OHnk0faqOh3tVHrB9MSYadD4PSiLsEbKyATgMXD53kxJ5mteLTxeZtHxfjSpLXZGzVx/l/eO8nCzOlEgg1/UOPZ/iHqySMghhtBpqLQKCDAfIn+NOTqGWfcuwNBnq85XnWA30F2rzqjwZPg02Ev8zK+wc6wx5ivNmlDA6GYuFI1E7K5H+buBotl+cZHfJthEogIHUBfBZ8EOgbSYTsmzVrW2MGEqoiScI+bLHHrhkVPTwIryAeTkRvUz+W0Eslhxfk+locn/3Oyr3TKKvYYJEqSeFCYYdYp44i7xA8+ek7vikeW5agnLEF+N5Fmh6ZyGcckO2Q+30yBDQBc/lWZcGSNsWqXSnPXcd3JtzAS/z4VQFkPlm/qfJGy081R1/ifZwN1V130+wRPrOLk/TVBEJCkupTFef/eaGvdUgPsifl2Xb+HCpEoIMIeMv8AWzk+jpbpFV7uiZ6Sod5AyFmHEH9EcnnYJrB+WrEK0E8ifSp3SMBRiuU4BHxNhrsSREppIjp2pRPkjaWVUCZkw+eGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(83380400001)(8676002)(2616005)(6666004)(66556008)(26005)(66946007)(316002)(66476007)(5660300002)(41300700001)(6506007)(53546011)(8936002)(2906002)(6512007)(6486002)(4326008)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhINHgrdlJ6RVViTVVUSG52V3NaWGFuaWhuOUYwVlphU2NyVithblAyRS9o?=
 =?utf-8?B?cHJOL0pkK043aExSOWcrRHZ2SEt6QlRaY3VsSnBRczRsUjRIb3lSdk12VTJx?=
 =?utf-8?B?N0drUHZUcVV2ZkhEYjNkbFVsTGJxdlNIaWhzbkpQcFhHVlQvcHg2OTNBelA0?=
 =?utf-8?B?dmJxWnN1WHZEU2tSYXhWUTJMdUJTR2g0Q05WSnM5czY1Yk9zSFg1UDlLdWRH?=
 =?utf-8?B?WWgxTXBIMi82bkcrbjlTQ0M3VzBzdFhvcTUrQ0hsRE5RU2lXbFhzZ0V6d0h5?=
 =?utf-8?B?ZHJqS3haS0FHQkxaVE9OUnFPR1FYZ1h3aE9aK3J0RmEraFN6L2R6WEZDbWNB?=
 =?utf-8?B?WXNrSnIzTkdWVDlkYVhsU1I0aGZONGoyK0RQN3krOHFHUjhOckxFWDc1Zk1X?=
 =?utf-8?B?SXpyK0t2UTlqNFZTbDJrSFZQa0lUQ210Y3lpMGdYVy9hdFhMd3Z5ZmZ2ekJR?=
 =?utf-8?B?Q1hXTnhLVGpVS2FrUmxQWk9HcGhqUk8rM1owanBWZ1F0VzBnYW9iaDhCdG9L?=
 =?utf-8?B?eFlvUFBvZEY1SHNyWkIrckhWNzR1UVhjajcyM2lyT1VYSkdBcGRhV1R5RXRj?=
 =?utf-8?B?cTJKTE5kcmhUY24zVzFFeUpFVzAxd0lseEpQdkxuSkJPZXNjd1BaM2pFS1FT?=
 =?utf-8?B?aVJvd3U0M2JzK1IyZXBlRzNFall2LzdTWEt2azVWNmZYMFpINTFmY2ZjQnhY?=
 =?utf-8?B?anEwTE8rVUZONVFxZE9SdkY1M2lhRzh3eDR3OEdCcHU3VVRiMDBPL0JMNXEv?=
 =?utf-8?B?Qk9hVndRakk5SEFnSVYxekdPMXJML09aajdYcHhnbkxyN0pjaUtnNU91RDFr?=
 =?utf-8?B?aGMzZFpYSTMraXBhTjczZ3ZpYStJWUJtNi9DMGQ0SUFHbDhJWGlxL0Z2ekM0?=
 =?utf-8?B?OXRDUTd4TUs2RlMva0ZKWXgrMGIvYUVGc21zaGE0em1iZmtoVURIU1Jlb0tz?=
 =?utf-8?B?UlUwczN2c24vc01QdXFVRGsrNi9LU0ZqRGthR2F0aWZYalplUWp6SHB2d3px?=
 =?utf-8?B?VlBTQWR3OFdXQnI5b2o3RWFmb3RQdUI1RVIvNWxySDdyL3RaMXFaNjNVMWZB?=
 =?utf-8?B?blM5RnZ2UHB0a3VqRkIvZWZ5cFRvamRiVmI3QS9MWDI1OGdwK0JrdE5oQWlE?=
 =?utf-8?B?bFZKc0QzVzYySGx0aU9VSTBEblZTRERMS0kramVuU3didW54VEovQzVpeVVt?=
 =?utf-8?B?Zk0zalk0SlY3b1RQalhEb2lSRTdXcTFmZXhaWTJWemRhejFnWThMbkgwbGcr?=
 =?utf-8?B?ejJJL2dVSzBaTkYycmJmUU1EZkJzN1cxOTk4NlVFS1oxT1Rhd2ZKbGtJYmph?=
 =?utf-8?B?M1pGcDZtM1NiZEhMaGVHKzQvLzF0cDNndmc5eTJLODIvZTNGbGFhUnhrUU43?=
 =?utf-8?B?NE8xZXVNVmV5VFVLcmhPREdjSUpyWFJsYkhGdFpuWVVBbkE1cGVrMjJ6b2pM?=
 =?utf-8?B?RVVQdEdyODVBVUk3UlNOMkhLQ3drQWY0MHE5bGhkTy83K1dIWGZJZnRxUGcy?=
 =?utf-8?B?Sjc2c2o1OXUvK2tGOExIeE8wUDh1SHVscTFRclQ5dnArL1N4amNrME5ZTit3?=
 =?utf-8?B?UlFaWUdUR2t5dE0zSjE3U1pqa1dYL3FacmE4R1dSWE9yNkl3Szk1bStPdG41?=
 =?utf-8?B?R0E4cXBRbDZHTEhQZmlOTW9rdWhKSDRaek0valZYdGQ2VWl2N3h2UyszSWxG?=
 =?utf-8?B?UFNTQVNtLzI5UGE1eThZYzlzay82NW5ub2lVeEVCTmpySFJUVUFqcFFHS1Ru?=
 =?utf-8?B?VTlidlo3QkNSTnpzQ0RtK0c0Q1V1Y0VrcGlrejNXQS9YVTJPcWFCblJKQXFy?=
 =?utf-8?B?NlBTNzVnMFZsamxaZ0JRSFVFZHdXR29UYlNXbGtkRG1jRElYc0lNU1Z1cFln?=
 =?utf-8?B?emxJclpQYlM1Z2paV2RTTHJTc1JtRUNZeXlTdHR3VytqOGVNRXpqUlhseE1F?=
 =?utf-8?B?VHE2UjQ4M0IyRGxXU2pTK3lpRTNTT3l4aVc4V2lhWDJFTHRVdFd4TkU4YlN4?=
 =?utf-8?B?ZFY2SWVXNm9sdEtsK0FnQ2g5ODNGRVlDZTBRd3RyU1lrNVY1RFBGbFQzL3ZF?=
 =?utf-8?B?bjJVY3ZZMVRYVEVrMU9VN3N3RXdETnliS3JNNHRiZkl0Um5TWVdMNDQwYjhK?=
 =?utf-8?Q?MM2axdUEzd4cl96zVLB3K+2V8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9b352d-f768-4a3d-e41a-08dbc8d41eb0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:29:18.0026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6JUMf+vVdv3hdapRM9aA17hDe/KuMWb+OBOb3HOXGejs6m8XY575DbwN+UudFR3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/9/2023 5:28 PM, Lazar, Lijo wrote:
> 
> 
> On 10/6/2023 8:11 PM, Asad Kamal wrote:
>> Use gpu_metrics_v1_4 for SMUv13.0.6 to fill
>> gpu metric info
>>
>> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> 
> Series is:
>      Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 

On a second thought, since there is no FW release yet with FW metrics 
table v9 support, suggest to drop patch 1 and pcie_bandwidth_inst  value 
assignment. Will keep the field as place holder till there is a FW update.

Thanks,
Lijo

> Thanks,
> Lijo
> 
>> ---
>>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 67 ++++++++++++-------
>>   1 file changed, 43 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index ce971a93d28b..3a07f1c95e45 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -279,7 +279,7 @@ static int smu_v13_0_6_tables_init(struct 
>> smu_context *smu)
>>           return -ENOMEM;
>>       smu_table->metrics_time = 0;
>> -    smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
>> +    smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_4);
>>       smu_table->gpu_metrics_table =
>>           kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>>       if (!smu_table->gpu_metrics_table) {
>> @@ -1969,22 +1969,19 @@ static int 
>> smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>>   static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, 
>> void **table)
>>   {
>>       struct smu_table_context *smu_table = &smu->smu_table;
>> -    struct gpu_metrics_v1_3 *gpu_metrics =
>> -        (struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>> +    struct gpu_metrics_v1_4 *gpu_metrics =
>> +        (struct gpu_metrics_v1_4 *)smu_table->gpu_metrics_table;
>>       struct amdgpu_device *adev = smu->adev;
>> -    int ret = 0, inst0, xcc0;
>> +    int ret = 0, xcc_id, inst, i;
>>       MetricsTable_t *metrics;
>>       u16 link_width_level;
>> -    inst0 = adev->sdma.instance[0].aid_id;
>> -    xcc0 = GET_INST(GC, 0);
>> -
>>       metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
>>       ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
>>       if (ret)
>>           return ret;
>> -    smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>> +    smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 4);
>>       gpu_metrics->temperature_hotspot =
>>           SMUQ10_ROUND(metrics->MaxSocketTemperature);
>> @@ -2000,30 +1997,38 @@ static ssize_t 
>> smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>>       gpu_metrics->average_umc_activity =
>>           SMUQ10_ROUND(metrics->DramBandwidthUtilization);
>> -    gpu_metrics->average_socket_power =
>> +    gpu_metrics->curr_socket_power =
>>           SMUQ10_ROUND(metrics->SocketPower);
>>       /* Energy counter reported in 15.259uJ (2^-16) units */
>>       gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
>> -    gpu_metrics->current_gfxclk =
>> -        SMUQ10_ROUND(metrics->GfxclkFrequency[xcc0]);
>> -    gpu_metrics->current_socclk =
>> -        SMUQ10_ROUND(metrics->SocclkFrequency[inst0]);
>> -    gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
>> -    gpu_metrics->current_vclk0 =
>> -        SMUQ10_ROUND(metrics->VclkFrequency[inst0]);
>> -    gpu_metrics->current_dclk0 =
>> -        SMUQ10_ROUND(metrics->DclkFrequency[inst0]);
>> +    for (i = 0; i < MAX_GFX_CLKS; i++) {
>> +        xcc_id = GET_INST(GC, i);
>> +        if (xcc_id >= 0)
>> +            gpu_metrics->current_gfxclk[i] =
>> +                SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
>> +
>> +        if (i < MAX_CLKS) {
>> +            gpu_metrics->current_socclk[i] =
>> +                SMUQ10_ROUND(metrics->SocclkFrequency[i]);
>> +            inst = GET_INST(VCN, i);
>> +            if (inst >= 0) {
>> +                gpu_metrics->current_vclk0[i] =
>> +                    SMUQ10_ROUND(metrics->VclkFrequency[inst]);
>> +                gpu_metrics->current_dclk0[i] =
>> +                    SMUQ10_ROUND(metrics->DclkFrequency[inst]);
>> +            }
>> +        }
>> +    }
>> -    gpu_metrics->average_gfxclk_frequency = gpu_metrics->current_gfxclk;
>> -    gpu_metrics->average_socclk_frequency = gpu_metrics->current_socclk;
>> -    gpu_metrics->average_uclk_frequency = gpu_metrics->current_uclk;
>> -    gpu_metrics->average_vclk0_frequency = gpu_metrics->current_vclk0;
>> -    gpu_metrics->average_dclk0_frequency = gpu_metrics->current_dclk0;
>> +    gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
>>       /* Throttle status is not reported through metrics now */
>>       gpu_metrics->throttle_status = 0;
>> +    /* Clock Lock Status. Each bit corresponds to each GFXCLK 
>> instance */
>> +    gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> 
>> GET_INST(GC, 0);
>> +
>>       if (!(adev->flags & AMD_IS_APU)) {
>>           link_width_level = 
>> smu_v13_0_6_get_current_pcie_link_width_level(smu);
>>           if (link_width_level > MAX_LINK_WIDTH)
>> @@ -2033,6 +2038,10 @@ static ssize_t 
>> smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>>               DECODE_LANE_WIDTH(link_width_level);
>>           gpu_metrics->pcie_link_speed =
>>               smu_v13_0_6_get_current_pcie_link_speed(smu);
>> +        gpu_metrics->pcie_bandwidth_acc =
>> +                SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
>> +        gpu_metrics->pcie_bandwidth_inst =
>> +                SMUQ10_ROUND(metrics->PcieBandwidth[0]);
>>       }
>>       gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>> @@ -2042,12 +2051,22 @@ static ssize_t 
>> smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>>       gpu_metrics->mem_activity_acc =
>>           SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
>> +    for (i = 0; i < NUM_XGMI_LINKS; i++) {
>> +        gpu_metrics->xgmi_read_data_acc[i] =
>> +            SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
>> +        gpu_metrics->xgmi_write_data_acc[i] =
>> +            SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
>> +    }
>> +
>> +    gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
>> +    gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
>> +
>>       gpu_metrics->firmware_timestamp = metrics->Timestamp;
>>       *table = (void *)gpu_metrics;
>>       kfree(metrics);
>> -    return sizeof(struct gpu_metrics_v1_3);
>> +    return sizeof(*gpu_metrics);
>>   }
>>   static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
