Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF24CD11C2
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Apr 2024 15:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A52A4113C5D;
	Fri,  5 Apr 2024 15:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pye5UC+6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2107.outbound.protection.outlook.com [40.107.96.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97ED113C5D
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 15:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9IPsXSo8NDjuIQuZP5XMJjYPCDfZ1kt5EcGMnYruKDQNNSeJgr7wSad7s3k0RH4YGo7nzZFOdnAcpFCUi7M2s9PCtaEPOli7dNAzUHcXvvXbrJ0rSii5zNlKdagR3Y8TbpxOqtGpt9Kn5yO9B6QeSY1hKGcMBu71F9OAgGHosyKUbSmoV9uQwnl2Jc9zdd5V6HqV93RfcOviJ6qrcSTTKepEv48atzfRtGq2WQikL2461C2HktfoJQgmbsEqXsSVV7q9GaawDXHRTNk9hA+QhYj18GC8JVYXq9ybcHik+tIfNs2ZTq9vIOI9ii5MAFWKaqQ4qmWixjhaLkBGwIPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp+eEI550mRrYKZ1Teh3zvaET6k9sX8JRfF+cP+2Jsc=;
 b=Mfe/88X8Hw26GlFLtKEYaa4zLIUNmw3WEe2XMrAnEvbkDtQL+vMV7y/c6n1M6kVAviXmZn/2TwWs6S98jX17E8EVa+MRx00iq2zpDiOlB4JjXlz9L+j5BrI30ycLQ+JRszlT6wWBOdrHfHgjKSdDfy3v9FQtG103u2+KqoOSgjAR+huTPtq+0mXfjEy2fB/mTKVG/RS5hrTTjouZCcBMxosn/wB19SIWj0UPsuccA6BT5Ee/XfS1qo4NoZjS04t1TtkN4UOwP3Nv5Y/ujTtwxv0li0Df4149NaryFQT0A3LfKsabz8iBYcQL3Fy2I5UAYgnZxq5ymsdkcQeBhBd3wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp+eEI550mRrYKZ1Teh3zvaET6k9sX8JRfF+cP+2Jsc=;
 b=Pye5UC+6mRkuMS1BGlHYCrhDji758NR/8lYN0Uv2+SFiDiXON50ApXDRKVElicVzBmbOFEiRLMbBII9V+wmcYA5Jd6Fe2ivnAEnqP5D8lCbPDDUtohakghSumf9CB9keoaLhhyw6c+BBZrTZ3iwRG/CKh6Zb2Z6XqQDiKq2fzhI=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 15:37:18 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 15:37:18 +0000
Message-ID: <3e9098fc-ece7-20a3-a62f-62c972db1ebe@amd.com>
Date: Fri, 5 Apr 2024 17:37:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: fix MES HQD masks
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yadav, Arvind" <Arvind.Yadav@amd.com>
References: <20240405143616.704-1-shashank.sharma@amd.com>
 <BL3PR12MB6425A4F95DE5309A5C9FB6D3EE032@BL3PR12MB6425.namprd12.prod.outlook.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <BL3PR12MB6425A4F95DE5309A5C9FB6D3EE032@BL3PR12MB6425.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW3PR12MB4377:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGk4EXpq2bBBKFszz7sNUe1su4j4Uxd8G+MJpXTNtCKtE0x+j/uU35xbiIvJHz8JrvWqiXHPoxFtDbULDQUm6Xspyz7LQxp/RMziGZ+K/NG6d0RM6kLzqtNtofLHaUQP9XtAyc0dfjMsCmgI+J0PpRHmDBbeGPyOtAA/sAIlM+vP66WniqD9v2b0uRErjzRMJpG29+RNl7wpymR0w9DXJtzgTmSuYlvZQMU2uHGOsnFQ3TEgrHwUwOu5tI9lsOlyvq7IuDYIejfnErvC6GctefPfJ5kpSDFzOci7rQ+jUHJ6YGsQ5kWzOKkuO0bQ/nJ1CRfSa8YWqaxLfYz9jYV2+9YQuSIyqFBhPChuSZvXUWMnUNuA3+DTv/nKPNPMyQ2S4hOHvYNkmb4pv3aIToVG4ZpT7wC7qr6V8Wd7FqMNliB1yCmnz4ACC9fEaGMMlJluxVz68eTHm/eiPZbRsAsnLQ7cbbJyeJA/ooANLdIKtOIuOVhtOxeLWCiKBEWy5YqOlZi3w03vRaYvJq0qdYx9D89fAeXO9Y9esUpzFDR7r7wUjNHbyEXdNIj03rAAvLXgCQ4GRAJ2VKlmNw8/OS7CNFqwZntfHHf56EcOCn5E4mw3OgMzjXje4O2kvrMAaEg2yI6qS+lO2wiUDQ/524UUssQ7yq8gGmIYfMuvuaXggHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0V1TVFvMjUra3MyclUxd3JSN0xDMFVZWnpZOXFLWU9TTHVPVS9UZVUwdHRW?=
 =?utf-8?B?bWhMSWNVTG5YeVJUSWNzOFNhdE0xZVB1YlE1bm9YWUQ0VHJjemExVDJTQWY3?=
 =?utf-8?B?YW1DWFIrZmo5OFNCWWxDTTFOVFZlajlaNXl2QUVDYktBQVBrRGNzanlFaFIr?=
 =?utf-8?B?V3RBeFByTnZvT3BCb2JJYm9mVC9SWUYwUEFsNnJQd1RkTFJUWW94MGlhZlNu?=
 =?utf-8?B?eUppaE1NTXJnZHlSc1RFaGxKS0hDWWJTQXA5a1Y4THVTUUxKZEs3SjZiMDZp?=
 =?utf-8?B?Q0ZPTzE0VnZVSnBIL29NNmNMc0MxY3VmVXNDYndXaHFRampGQWZHYmsvR0R3?=
 =?utf-8?B?eTdSSmNoQis2VVN0cTlzSVNNbEEyZ3oyTFZreVo5VW1iNTA0VHBIbDdZcDh0?=
 =?utf-8?B?bFB6Q2hOeWNMT1Zoek5lMmNFcHE2RW9UWEZ3Wk1VVjJrM2pRRU5CVHlPM0ll?=
 =?utf-8?B?dFk1ZVRnc3lBMjFBM0U5Y2VMUVA1dTZqVy96czF0WVJiQVJ1K1h6TjRzWkVS?=
 =?utf-8?B?OEllcVdWNExodjhTUDRNUGM0ZjRHUGRsWkNGUWsrVXY1Y2hIenlQYzlpeHpB?=
 =?utf-8?B?NzFqK0NmMTU3MDlGQ1NNa0FOd1p5bHZOTVZjYUhMeEVLSDBhdm5vSFlNS0RO?=
 =?utf-8?B?emx5aWtZaFZUZ0dEOW5odVBJZS9QQUkzZTFYQjNHNk5sRjl4L2s5a1BHdTJz?=
 =?utf-8?B?USsrR2UzaFN1ZC9VaXhuNW1USDR2ZVlSaGlsM2lReDl4UC9JSG1MaEEzZVpp?=
 =?utf-8?B?cjYrbUJ5RWp4dXk3emQzYzAzVk0xdHhveFVmTFJVdC83cTRWZGhhUXEzdkVC?=
 =?utf-8?B?MzMxbGtBTnBpT0ZHZWVnTWducWNiT2tEamw2YU53dW9jcjgycHFHbjArZGJV?=
 =?utf-8?B?OEU4eG5lUTdQUWRBblRRekh3WGZUaVBiQTRnZWNReHIrRjBBRCtCUHdOdFMr?=
 =?utf-8?B?Qm9wb2RQNEtDNzg0dm9HOWEwdXRYK2JOK0FsZzhNTERZeDZ2UXNFZm8yb094?=
 =?utf-8?B?dkdQMW5FYTZrMTB5bk1kNmMwT1dXZWhsZVRYSUgrYzg3c3lyTjVBYjgzeWFN?=
 =?utf-8?B?VWs1bkRNSUx1elpMclp4dGd5MHNxaGhRd25yT3RPK2dCNGVHaU9LTDQyNkVu?=
 =?utf-8?B?MFUrODA1ZlZaZlY2V0x3a1pQY2xpSkxHL0xkU2xzTVhyRXkzVUV3dkhhaFB2?=
 =?utf-8?B?emJTRXgrTW40YnJHSklwYUFLb1V5QW9kR09XdkY2YitNVGhOejFIT0FJa29o?=
 =?utf-8?B?SzNlQTFta2VpVjhaUWFhNUFML05obmdZcE5oQnppYzBqQ2M2bjRIZ01vMEov?=
 =?utf-8?B?Skc1aGIyOWlmVlYwZUVRWVdOMFNwOW9Tb2puT054WEZESWpCOCsvS0RwTm14?=
 =?utf-8?B?MlVsa1h4SXlZTjNWWFUyOFdWcGJOd21JZnVkeFErTnpvZDN5eGZUZTBzcVEz?=
 =?utf-8?B?aG9wMmJqMFBpaC92TzYzcThDMjExZHNwUWFXYjJPdjJwbU1iWW5ETWV1dU8z?=
 =?utf-8?B?OVEvMzNMSCt3N2dYc2dnM2E2VVA0eURGSCtSTDdaTTRsSXQxR2M3WGk4d09h?=
 =?utf-8?B?dzB5U3grY2UycVE2dmVEbUhCc1Y2MVhTT2lFT2F6TDFkNUxwaTNtYkVsNVJ4?=
 =?utf-8?B?MElUZzR0c0IwS2tEcnBnZExlbnp3bHFxNGthRmtudzNOWFVuaXBjQmUzSVR4?=
 =?utf-8?B?bDg4a3dPYzN5dHRKRHlZa2c0eG5xSVZBSHVQMG9QUzdHZklUMnMrSHNvNXVy?=
 =?utf-8?B?S1dJRGZ0QkVVQ3ZhOUVFdndieXRhSkpTNVo0R0txelAxc3VsUzlHNThHM25v?=
 =?utf-8?B?dFAzeUFxYU9WWFRZdDdUa0lKZlh6VEM4YkN0amFGdXRKZmx3Yys2bFhvMGtt?=
 =?utf-8?B?SVdneU5rNFVnajdkdzNyaEVKN2RNQnZWckRuREZGdlFhRmhMVWRnanZqVURS?=
 =?utf-8?B?eHNMc21mZDlsNzNNKytvMXFud0o0bVB0ZWJQZkdvM0NTeFE0MmtFUzBnRGtx?=
 =?utf-8?B?UkVaYnE4emM2TWYwY1BZUEVYQXVUN3d6OVBYWjRMQ3pHSGdtTkJoNkhhMlo0?=
 =?utf-8?B?VkpkcVNjeUQzQ2pUaVppbFlQQm9zeVdLLytGZXgxalRWdkZkMUtrN1Y3a3BS?=
 =?utf-8?Q?y64rbRR/SbP9oOnrO/YopWFAi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc1244ae-3cf5-428a-089b-08dc558646e6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 15:37:18.6212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Tmze2DIYY+rnlH4T1iQGsBkOjbApllH6+mfLdq3UPQZJjxTLoGH1s2Tr8bp/+HyVgn0xLykx99JaPakY5xSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377
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


On 05/04/2024 17:26, Joshi, Mukul wrote:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Shashank Sharma
>> Sent: Friday, April 5, 2024 10:36 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Sharma, Shashank <Shashank.Sharma@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Yadav, Arvind <Arvind.Yadav@amd.com>
>> Subject: [PATCH] drm/amdgpu: fix MES HQD masks
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> This patch fixes the existing HQD masks prepared during the MES initialization.
>> These existing masks values were causing problems when we try to enable GFX
>> oversubscription.
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  3 ---
>> drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 15 ++++++++++++++-
>> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 15 ++++++++++++++-
>>   3 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index da48b6da0107..7db80ffda33f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -148,9 +148,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>>                  adev->mes.compute_hqd_mask[i] = 0xc;
>>          }
>>
>> -       for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
>> -               adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
>> -
>>          for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>>                  if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>>                      IP_VERSION(6, 0, 0)) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> index 1e5ad1e08d2a..9217914f824d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
>> @@ -266,6 +266,19 @@ static int mes_v10_1_query_sched_status(struct
>> amdgpu_mes *mes)
>>                          offsetof(union MESAPI__QUERY_MES_STATUS, api_status));  }
>>
>> +static inline uint32_t mes_v10_get_gfx_hqd_mask(int pipe_index) {
>> +       /* Pipe 1 can't be used for MES due to HW limitation */
>> +       if (pipe_index == 1)
>> +               return 0;
>> +
>> +       /*
>> +        * GFX V10 supports 2 queues, but we want to keep queue 0
>> +        * reserved for kernel, so enable only queue 1 (1<<1) for MES.
>> +        */
>> +       return 0x2;
>> +}
>> +
>>   static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)  {
>>          int i;
>> @@ -291,7 +304,7 @@ static int mes_v10_1_set_hw_resources(struct
>> amdgpu_mes *mes)
>>                          mes->compute_hqd_mask[i];
>>
>>          for (i = 0; i < MAX_GFX_PIPES; i++)
>> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>> +               mes_set_hw_res_pkt.gfx_hqd_mask[i] =
>> + mes_v10_get_gfx_hqd_mask(i);
>>
>>          for (i = 0; i < MAX_SDMA_PIPES; i++)
>>                  mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> index 26d71a22395d..b7dcd936afc8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
>> @@ -360,6 +360,19 @@ static int mes_v11_0_misc_op(struct amdgpu_mes
>> *mes,
>>                          offsetof(union MESAPI__MISC, api_status));  }
>>
>> +static inline uint32_t mes_v11_get_gfx_hqd_mask(int pipe_index) {
>> +       /* Pipe 1 can't be used for MES due to HW limitation */
>> +       if (pipe_index == 1)
>> +               return 0;
>> +
>> +       /*
>> +        * GFX V10 supports 2 queues, but we want to keep queue 0
>> +        * reserved for kernel, so enable only queue 1 (1<<1) for MES.
>> +        */
>> +       return 0x2;
>> +}
> There is no difference between this function and the corresponding function written for GFX10.
> Why not make this a common function instead?

This is deliberate, to indicate that the HQD mask can be different for 
each GFX IP version, so as the number of pipes and queue per pipe. Also 
the limitation on pipe 1 will not be there for future versions.

- Shashank

> Regards,
> Mukul
>
>> +
>>   static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)  {
>>          int i;
>> @@ -385,7 +398,7 @@ static int mes_v11_0_set_hw_resources(struct
>> amdgpu_mes *mes)
>>                          mes->compute_hqd_mask[i];
>>
>>          for (i = 0; i < MAX_GFX_PIPES; i++)
>> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
>> +               mes_set_hw_res_pkt.gfx_hqd_mask[i] =
>> + mes_v11_get_gfx_hqd_mask(i);
>>
>>          for (i = 0; i < MAX_SDMA_PIPES; i++)
>>                  mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
>> --
>> 2.43.2
