Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE78FF8861
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 09:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB8E10E294;
	Mon, 27 Apr 2026 09:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWb67tyq";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010064.outbound.protection.outlook.com [52.101.61.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF8210E294
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 09:15:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIjLT/8kgFRXNHswQpd8Phi+F+fTLR0wnt2pcbx/Kf9G6i72rRLSQw/ii3WjtehPBAhV5LW+qMdzlKTKOzd9mBp+6cPZeVLaVeMn/GEgRzE98v7QKEL1EHWnxMlI+ZY8utU4QnUfad0jIekwXcV1ni3hPhjHDErXtmwKU68Tp9gA45LtIq+pHxA6710bgQgROuklkHYH57i3pP7WcjDaooxVK7hFvpDZO/4HG20LmrMPfFo0RUpA/tJKsNJyL5LW22C43X6sUxMZVNSQV/jgYv/UYjkC5s3PINFg167+w8O8afIBeVC3jWtvB129D7ra1HPaMLijRJL/lF0cM1E65Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfLL07eomGNc5gZ6fJip0/fFSPooxtyKNlgVRL4CjE4=;
 b=JPVlLWI6ny9U7k6ZOd26So21a2UDwbaF2SUj6ziwCx1LfQAXZ9geOOdtu4c98o3A49KHam4iwJJHeEP8by++iYsVL4Cw+Dij/Mj2T8feOmrKbExrXnsMUg/x1wHMnsuyIv66KJcY6d0s2cFCRygx8t5aTv0iSj1j0s3/2FnILSN2iXXZjLkXjev2P5RQbCSbLTLZ6gPG4MesZMrPqqrGPdTSRV6RyHWYMHukEY8dXWPrQY01FBzTWXD8uDfjjRD4zcHFMwtrEACkbv1E+iB/DlGATff9822S0c9KnGtzXgPNKhwovDsl9za/mQhKtypMhHbwer8xUgA260GJH5ZxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfLL07eomGNc5gZ6fJip0/fFSPooxtyKNlgVRL4CjE4=;
 b=gWb67tyqyVjG1Yc1s80hGs56ed1vNhvoTOr8wU+UeLkYoGQxsG4MQvUKSrbnBZuQnupKEnU46eMVr0QLvU2N3LAOZGaeSI9qzKY+R+UswaUJQEm6fwwlw1cx1kNCh4TUJbFXITktG1Rv7P1dKJYvitH2WPWDwIJ6QQXU1d/x32I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV2PR12MB999072.namprd12.prod.outlook.com (2603:10b6:408:354::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 09:15:16 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 09:15:16 +0000
Message-ID: <fe6ed465-47bb-41fa-9d3d-5e6c79b83bd7@amd.com>
Date: Mon, 27 Apr 2026 14:45:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kamal, Asad" <Asad.Kamal@amd.com>
References: <20260427073042.3547935-1-lijo.lazar@amd.com>
 <DM6PR12MB2972472A5F44139A4439029C82362@DM6PR12MB2972.namprd12.prod.outlook.com>
 <b462125b-0cf8-4fff-996c-26a58e48e438@amd.com>
 <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB2972F9AD29542173B6B9A9B882362@DM6PR12MB2972.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV2PR12MB999072:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef218b5-7b83-4241-bee2-08dea43d7e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: OduER87jXNtSJWlSWdkdJtGx0Y+sBXC6DRLw0iAyH+onLbNjjcgnlAwnrOfMtbHed08iFSlVbqibRpg+2PMmREItYzAB46a5GbnG4FSknACIcDoUzWIkVMNx85OUUl5GjruYfF0eGm+Qsq1+LZO1MU4SL+73StWzfsYmbENu6UYkKGFDshYXEZZWFe3DF/Ee4K4bM7uQacd+d50Gi/GmyhambsOmcaeODWqnLv19j0gIqWJ/IS/05qDDYV43N1js7lIEwyLL6CgEJsik1U2nIPPojhv/a1Kb7cmc1/OYGzyMZwOzxJSBPY877oXYkh3cz4vC4lwwUxYdMCefxWi7jeeRhPQXnJXLzlhLUsWuEvSbEdCsdEEwtbax4mYkJHxRlk4v5OdANsJBgSSyJz6JAoNogQll1ltZiF/KRu0aPC3ti8X6CJeK2W8FFCq+6u07QYbVN1q8c6bpT2Ms0aTGr1AYzp0krlptjXCDl1DQCbqcGVrbzjqXj0pdI2Qe/sbkKUfkdUPwPlvVqGcsm+LfglNPb3+Cb/LDI2MnfgqVIvlOHPS1d7gfTZiGWzl54EgbbV7z8FLQGBuuy5FW7erh8ien1JF6Ch7k0XaJoH02HFVaQoVpsT0BRjbYCHI+NtYGxRrHqm9cDwUErM4yDwwBuMcRqGU/ibqU//liMXUNgfy6zifWTkPise71njLCx4agCgEVXExyynlvKcwWLsxnB4nfLUgz/tbMWXOj9AME9vY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dldWVi9kUVJaYkZnbWYwVE9BbmQ5RWt3NW5FWnhHREM1cWlOOHF1L0x0WW84?=
 =?utf-8?B?aWNRQjRPQ1pTamVzbjZkWW1WRDNVb0UyanMycW9SZFNadXEvaExnMFRxMFdZ?=
 =?utf-8?B?WHNIOFRxaW5tZDZHeG1NbG9sa2dXK1hUazhTUjJJQ1VSUDNnbGc3eDZGYXdY?=
 =?utf-8?B?WVhCUFBEU2t0anZaZmtSai9mTW0zcFVrWDU5eFI5Um9WZG0wUUZZRCtTT3Ra?=
 =?utf-8?B?RXNVTjMyeEpJNzlWVFkySjlhT2hJOGlpbXNhLzlsaG5QTUVMajFYbWxLcWdx?=
 =?utf-8?B?TmMxQXl2RUdSZnlPTTY3TkYwOWFTYVZUZjZQYmZ1R0J6aWlHSVlvU0ZkR2tu?=
 =?utf-8?B?Z0lZdThlcjJjS2loVjhJUVhmS25YZkgvK0FIT1pPK3RIeTVNZTFVL1VabEVw?=
 =?utf-8?B?bHRTNFIwRk9IWTZsQk9USUJrQVZiM0dTUnNQM2tta0RRWncwRE9pNEVleEZK?=
 =?utf-8?B?Wk85S2JRa1RkaFRWUjJIWWZZYWFCaG1rN0Z6NUloazBuTysxK1dubmg4Nkhu?=
 =?utf-8?B?MFlxTUVSa1ZLSkEwbkpLSURkNCt1YUYxYTJ6YXdIRzRuUGwxNzJpc01DZm5x?=
 =?utf-8?B?U1NXTUczL1dwenRWVllnd21QRGhnZFZHWmpjVXVoU2ZnV1NBU2VJdVZUMTk0?=
 =?utf-8?B?MlYva0F6WC9kc2pVb2dEaDNuVlNuSThmUFVBcER2dUVlZWRHY28yU2pER0Yw?=
 =?utf-8?B?dzBFQTY1eXJCcFZWN2VyMTFsK2pqa0NYMUptODBDQWpNUmwrRUtHT2lUSjVQ?=
 =?utf-8?B?UjVheHdueU81ZGNyTHE3Vnd6dXkyM1NXODNRaFBON2NINksvcXJvOU1JY2cx?=
 =?utf-8?B?aDIvUXBkL1pPS0hIeHFUcDFYZENkcW9CSmI3QjZBc2dnVmZlRVJMdDRMa3dJ?=
 =?utf-8?B?T3pJdlJYVjlSbjdXSGQvYWlIYXR2bTFGRWE2bWpJVjZVTnN6NXl3aUpGTDVm?=
 =?utf-8?B?Q2ExeUM0NnNTSjNVZjJ3Ti9lMFhCL2tndDljUDA3NXRma2c2cWZCdk1oMjRs?=
 =?utf-8?B?MXJVem1zTDIvRGtBVjdtRy9RM3cyZ1lyNlp2SnlOL2Frcm9LQnJpd2lDS1di?=
 =?utf-8?B?SVpuNmlRNEREbEZNNjRaMW5IbzAyU0xNdHdVOHovY0dJY1k0a2JsSTFVY1kx?=
 =?utf-8?B?VTB1ZWMyRDRPVGo4cGdYSk9qamlkajJ4WHdSc1dBUkhrdjNlQ1FuVm1kSnk0?=
 =?utf-8?B?QldrSHgyU1Ayc3ZQeCt2WVNYdTluRnlaSTBROHZmYUNHeUxwWjR4U1ZxTmtO?=
 =?utf-8?B?SkErdE5sK1VOaUNCS0t5MmVCZ1RnemU2L2xVblFZMG5UYmkybjdpYnJmUjFk?=
 =?utf-8?B?dGoxSkh2VkplZlo3YlRuNENleU4zTmMvNWxpVU9xWk1OaFlyQmZ4MFJ0bEtK?=
 =?utf-8?B?VGhhTVpRU01nUTFmWWdTTUFDaUFjN0toS0NEcFlIb0dEZ2NScmQ4YnU1YXN3?=
 =?utf-8?B?eUhObVNrWEhacTJacnpnYlpLcEppOXdEcytMZTRVSEo0L2RCMFRUM2JNZVQ4?=
 =?utf-8?B?Q3U0bmE0QkIzNkMxZS9ncWVpOEJXbEl6R0haTVJ4TTUrOUpYa2JLaEphbDZm?=
 =?utf-8?B?b3MwL3Y3MTQwblA1eHpLakREUlFpSlJ6WkJRYjNUUDZDOHA2TlZsaEQrREdL?=
 =?utf-8?B?blBvdWthQ2ViSDh6REk1bTRpa044MjAvRlYxRGd1dUpiUzZINGtRRWswSUlZ?=
 =?utf-8?B?VjNtN0hoL2dJaC9vaXFZUUloc0RxTyt2SFJULzNHQUp4YXZ3Zk5PWkxwWGoz?=
 =?utf-8?B?NnYvZU82RlJzMG05dWZiYUpwcTV0S2d1dnBnMEwzR3lGWW1ZaEZId3hDditx?=
 =?utf-8?B?TUJXWXBFcG9CL1YvVUhPNU5pQXZyUG9RMzVwQjM2YWxtN2xtWEQyT2UzOXVl?=
 =?utf-8?B?RnNGMTVqVEV1K2puSWwxMk9ZUDkrbUtJNE1sdTRKaFdQQ01pSjZ3MFJ6RW9n?=
 =?utf-8?B?eFF4WlJJY1Bzbnk2ckpkUERmZVUxM0JUeWgvL0tLQ25zbmtmdlpDWU1MckpY?=
 =?utf-8?B?RFVzK1VIVThPSzRCVk1jZHFjYWVhanNSOXhNcERYNnJWaUxTSlVXOWp4RVFZ?=
 =?utf-8?B?bHMzcENrektaWnRNaTh1ZEhNNWl2K1FZcFl1SHFqcmdRaTVYdUo0WUwzdGw1?=
 =?utf-8?B?M0VkYTBSVGl3cGd4bUk2SCtVdmJNOENkaDRhU1NVdEQrMGlydldvcElHN0x0?=
 =?utf-8?B?R2JzY213cE41c0h5QjdZNXdLTllPdEdIU1FEQXFyWW5hNGJINWdEK3pxN3pW?=
 =?utf-8?B?R1NxUUtUWUJocTUyazZ3dVNDUkdtcVdNRmpEYllsbDNsTXNib2hNM2dRaTdh?=
 =?utf-8?B?REVtS2RoSGovUnJBYjRudFJ2Zmh1MVc3TFBBMXdMM2xWZ1RrN3VwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef218b5-7b83-4241-bee2-08dea43d7e5a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 09:15:16.5224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCcD/F5GZdXU5KFb6w8O1XsMpnhWqiwbG6xay9S9AQtR342hGbPCKSRmDqmea5vs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999072
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



On 27-Apr-26 1:39 PM, Wang, Yang(Kevin) wrote:
> AMD General
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Monday, April 27, 2026 15:56
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
> 
> 
> 
> On 27-Apr-26 1:16 PM, Wang, Yang(Kevin) wrote:
>> AMD General
>>
>> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
>>
>> You need to move this line of code under smu_feature_is_enabled() to prevent subsequent smu_cmn_print_dpm_clk_levels() errors.
> 
> I think it's better to fix the smu_cmn_print_dpm_clk_levels() logic for that - to keep a separate path for dpm_table->count == 1.
> 
> [kevin]:
> No, this should be an independent issue, and you need to maintain consistent code logic with other SMU functions.
> e.g: all locations where the smu_v13_0_set_single_dpm_table() function is invoked.
> 

The issue is because smu_cmn_print_dpm_clk_levels is hardcoding number 
of levels to 2 for fine grained regardless of dpm enablement status. I 
think the fix should be there rather than at other places. If the count 
is only 1, it shouldn't keep the hardcoded value as 2.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
> Thanks,
> Lijo
> 
>>
>> With that fixed, the patch is
>>
>> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>>
>> Best Regards,
>> Kevin
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Lijo Lazar
>> Sent: Monday, April 27, 2026 15:31
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
>> Subject: [PATCH] drm/amd/pm: Add fine grained flag to SMU v13.0.6
>>
>> Gfx clock is fine grained on SMU v13.0.6/12 SOCs. Add the flag to report clock frequencies correctly.
>>
>> Fixes: 7380228401c4 ("drm/amd/pm: Use generic dpm table for SMUv13
>> SOCs")
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>    drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> index 40f0d8a685bf..8d04f6e73fd7 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
>> @@ -1133,6 +1133,7 @@ static int smu_v13_0_6_set_default_dpm_table(struct smu_context *smu)
>>           /* gfxclk dpm table setup */
>>           dpm_table = &dpm_context->dpm_tables.gfx_table;
>>           dpm_table->clk_type = SMU_GFXCLK;
>> +       dpm_table->flags = SMU_DPM_TABLE_FINE_GRAINED;
>>           if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT)) {
>>                   /* In the case of gfxclk, only fine-grained dpm is honored.
>>                    * Get min/max values from FW.
>> --
>> 2.49.0
>>
> 

