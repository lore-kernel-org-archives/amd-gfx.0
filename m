Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663E4FF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ECFB10F037;
	Wed, 29 Apr 2026 13:53:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n6clISUO";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC00C10F037
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 13:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKsV7txVEB1LlYgEyOTavYPKNhVAol8tLV0liuip6Hxjo7PNHALe5bKNEXy+JSiJV4zyT3Jh3onOlSTvc3aZol4JC7CB7gBb9E9RoNaJR+4GqHvXB6WVUCBd0IsK2vnRj1l8bCm4PkI4aA44A36nNCKgbxDga9ZIK68AyGqjmkxTIjMylESWVBrhO8u3nEUhAu+60eElcxANkG7Zo2mBoDf/ulONHPmGF+1XdvmXFWlr/aKs7ICsHVnIeRuiHGEGnRb2xpX6o93cK0MRUpQZ0gpMXiG1Fbif2buZGe3+gR2GxFQSxM2UFVkMaiqwPXGMsNXq0bI/mpSWhP8CNU3lpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUmA05B8UaqWEKdzkm0WEf3mppc9yAGTaq4YYkM5fkA=;
 b=Rva9Goxx0hkpvIhFuZvcF5Jtw2Q95MhdZZA4DGdYiKhsjQEsfxyxieYhpPBtxgAqdM91pKshKMCqZqoBNgQK2RiTJNkRubezWZ4thxYQT8abCZ9NU10IHRtVvBdquHmzDQMnbRor1A0UkCH7nPcxVBV2JbYC+cPrWOt1Dprf3KKodl0j8hcVu3CEBovzyc/e0Ioslt5fjO6X4J7vPi+lM37iYM7IfdwSvsCl3SeQPIyfYao/njL4J5wmk5kml6Mtk18CvIVO9iKOjw0tlwSqXQibLJYfpdTeDQgLyOgual+cvUsA6KY9XP6x1p3sMy4sEG7V3+UHg2rQMCypk8/WzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUmA05B8UaqWEKdzkm0WEf3mppc9yAGTaq4YYkM5fkA=;
 b=n6clISUO0FW/uA3OmJp4HacczvrECDSFAb55WsiZjn/wJ5xxTiUk45eoki+Xxi2NkiH7uneZRc9rW14dNQy4mPSP05aFRMK4q+CbSkfBBGWD6KduM+LpUZ/VIfTTnTCF2a6kyT2ZqOF1w1n+7plLFFem4bcEz0ztQd8EehBMBwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 13:53:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 13:53:09 +0000
Message-ID: <89fbce96-8594-4847-8032-cdd6f17fdbec@amd.com>
Date: Wed, 29 Apr 2026 15:53:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Adjust GMCv10/11/12 gart size
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com,
 candice.li@amd.com
References: <20260429123745.3930780-1-lijo.lazar@amd.com>
 <25f247d0-8484-40f6-b751-1b5f259cfa71@amd.com>
 <055c7635-425f-443e-afc0-40c3e0eaee1f@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <055c7635-425f-443e-afc0-40c3e0eaee1f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: f13e5909-eede-4509-1108-08dea5f6a584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VO1J2QAKIYsvmxWVrn1FmAGFI1HR/1M3oe9ltzRNK3WS6lkfAuz8hLQsPa3WhwJSo4cCfCakGQxPq6PPDs9msfN5ZQZKZ0EjEancsbwA1c7HTm3I8J/x/2lPLN5k01OEh9IG0z+VDlkAPRrCtXFMoAacFV1OeDm5bQubzwXzBuhtMDQLOuhQBXWG2NDWfFNMODyqFXweOuVqZYFz5jXqi+E5dyFv5gZF8T9PNQAHJJJZfKGq3uXmiLYsOCRC3iOjn2OkBy7oxZofIBx/teoaxfG0TiFOv6+IBcPjR3YhuuN90nsaDP4Kp76e/IuqY3v/QDx6FL0hSEM+THyOoq9zc+mZos5aiR8x3X7NOEuUTpcjwnEEBEsmgBK8lMHPT8Opcaakvx69qtLXbaeS/QJnv0B+arLqzS8v2ifipMaBJft7DlQZztysi9WAqk3MRSHBQmFmWLDbaKcuRMJJ2tZ/wUHpek/1+EsKJsJKIc3EcdP77R4X5taC7bdI88t3RjR2achRgff9WLOwi6X+HazfKuZJDCT8nBa2QW2/i2tJsqwBmrY2B3FLAAuxrr80htWGGY8ffJQvkA4coB5HR7V7xnqNr17RXZTtQvC4aP5BLSFqsQ4x8e/2qT+2jazIP/wNx2a9ijT/L+RjyfWpYBfS+PN96/TZ8X310ZUivNzkgrkHgF+bjCFWFvQ/Esnpd8N8p48lf2BPgHTw/2OzrTNa5ISjw7pFsdKF2Ykw6SewbAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmR2ZnFXQzlveUtaZENuSUV3bU1tYzR2aEdDYkU3L2NDSmZTRkxjWHhtV3J2?=
 =?utf-8?B?OEF4a2k0cGlHOUVIWW9BNlF4NC9zVTgvVGswOWo3ajZQUVV0QzdUMG9ETmhs?=
 =?utf-8?B?MXlUL2RwRkFJSEUzQWVvUEtVUVlLVW90VWRpcTRZQzlQazI2bFlZZ2N4bk1t?=
 =?utf-8?B?R3hiK29DRDFwMTlIQnVaUGRLNlZGeVkzSkFMQnMyQkx6R0dkR1VGcHJ4Wmdq?=
 =?utf-8?B?czNoMlFncHNYaFZxMWlZR09DVXFxNnJYczhuU0UrL0FyRFZVbVpET2tkL1hk?=
 =?utf-8?B?OU5xSG04cGRIV1lleWZFRUdMdjh1M0M4NC90KzFNUm5Geis2QVU4bGNyR1U4?=
 =?utf-8?B?YUY4QktNRkYzS2hOczl6dThhbFpNY2FGZUsrUzB2czZ4MDFHdXA5R1B5eStX?=
 =?utf-8?B?Q2N2MWVGL0tMZ2ZtZ0NyYzlYQzZIOHRuZWZyM1diVE15UDBIN1NBMXZPK1RL?=
 =?utf-8?B?WVR4TzVwN3VJek4reHJQNXp4V0EzQzNDS09nTnIxdUEzMkpYZHN5Y1RDZ1Va?=
 =?utf-8?B?d082eTRDbXJmZFhmWXJzd3NhckFyOVROTDE2ZDJZSXFEaitmQVpIMVpaU3Jl?=
 =?utf-8?B?dVBldWhXakhqV2xGeUQ3eW9OaDQwb3QxQWxraURMS3M3K0ZSWUt4UWovcGJu?=
 =?utf-8?B?cWVvKzV6VGtvUEdoSWV3NTBkYURRT2xRVUttVnVwRFF4eTVoWUZCcS9wZ1Vt?=
 =?utf-8?B?dndDVmkrS1lVZ1pucEJCNEZ1blhKM3BqVGxsbDdlcmswSTJZUGVsQzZYc0Js?=
 =?utf-8?B?RXk1ZENQNU1acWFHYTVRNzZ2bUh1UlZQRmMzcTJaQnZ3cERTbldHQUdqNUx2?=
 =?utf-8?B?YytaYXF4T292T21KL3JmN1lHNFM2eXEzVXp5UTYrb01YeXV4NGZVQ3BGcFow?=
 =?utf-8?B?aDFiUnJDc3JQb3AzdVB3UTlDcFV5MEZET3M5YTBSUWE4bUhwRzlINkc1STZj?=
 =?utf-8?B?YVVNKzg4cWcvR2l0SGs3ZjhJc0k3cG4rdGRvSlhKYStJSGEwYWIwS2Z4eTdW?=
 =?utf-8?B?RGVoS1NWa29Dd3FTcXhmSlFNRDBoazlHREZkMDd6a3RnbFhFZW1ERldpMGdt?=
 =?utf-8?B?alREVUlXamY2d3RoMnlzdWZiYWlNU2VpQlVnMmZTZUQxNDlhbEd5NjdtWDFY?=
 =?utf-8?B?L0lPNUgwbWpCTEp3MTY5TUN0MUQzNlZuRUxoMmlscHFObEM3cVhFTjQvaUEv?=
 =?utf-8?B?VHNGWVRyc3Q0ejNrN0wxczVVQjlXSUthT0Q5U1VqN2srU1h2MmNkRis4ZVpx?=
 =?utf-8?B?WXFnNjhrM0llSGFSdHVXc1pqZ2pPL21xNWI1cU01bGlvQ0w5MXZUL01pUHVw?=
 =?utf-8?B?d3A2MTJPVE4vODFwdFpZTk5VRFB0MHp1bkI1RmNtN2pHbkVIbGorU21CaVFT?=
 =?utf-8?B?SjBIWG5NdlJ4dTBOL2hpaC9CaHhvNHNMM1c3VU9Ub1ZwTW5rQURyVTJsY1B6?=
 =?utf-8?B?MlRmMFpFREFWZlJ5cENpQTF5MVhlamVoNm9ldHh3QVNwcUVHOHlxSTlSa2Uv?=
 =?utf-8?B?bFpCRmxPamxDdTRVY2FwQmZRT3BRYmhra053alAvczJIVXIreFE2U0Q3RWVw?=
 =?utf-8?B?ZjNCUWtXSTBNNWxRWHRaVTFXQ2lka1h4Nm9Ubk5Jdlkva3hiaXRmVjdrRjE3?=
 =?utf-8?B?UFJ2M3FtUlQrRkUvdkFFZmwvTWNuZ3UreXdiQ0dLNFhzeWFjWVRCSDlWSWJ5?=
 =?utf-8?B?ZDcwOHRGalFXaGhnNHNJdVFBN3kzOVoyRllCOVB5WHNtMURiMzhtbW02Y1Z5?=
 =?utf-8?B?aVRKckFXZndnb1gvaGFhMVlLVGJCWmwzU1ZBUjdqakZZVkhjeG80QjlYbFha?=
 =?utf-8?B?dkNGcXZXekY5NFZSVk5Fa1dYRkMyWHdFWUduOFVmYVdnbmlxZWlKT0NMWHVY?=
 =?utf-8?B?R0lZTGFsMnVGYnlVczhCV3BCU3dVd0ZLK2tuN0NNNGxycVNoc2JIeE1VMG5a?=
 =?utf-8?B?TnFwQTBOVDk4KzdVeDFwUStxcEIvV3Bkd0ZvK0ExaTB6cThqS09DRytWdHhO?=
 =?utf-8?B?SFNPc09wOElXWGlVeCtnQXg1U2dKVGZzQmFyZVlKcmtQdW9xUlZ2bjlmSzhS?=
 =?utf-8?B?eTBwSjVoRFZSNFZrajlnVGxNZ0xlQ3FORWVWb3h5QlI1cVVTcFJiNGpPSVFz?=
 =?utf-8?B?ZC85ZkZiTHk1WFcxV2dqK2FBc2x4dlY1WThpVnlvbDBPR05lMG9GL25kMENa?=
 =?utf-8?B?Mmh0enpDRkRmeWZ5RjdsZktPYS9kVXFyd1lVYjY1K1JtbGdUOWNzRnlKWEVt?=
 =?utf-8?B?RGJPOC9VcDVZU09QU0trM0ZLMFl4NWFoaFduRldWYnFqdy8vZ0dsUDJDVG5j?=
 =?utf-8?Q?3tgo2F+ofY27u2FXaO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13e5909-eede-4509-1108-08dea5f6a584
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:53:09.5231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yqetxoKfhSc7XVNHG4UaaqNtI/ku/uC1Mn82OFOcr12GBTCRRInkyC0P5lDVX8o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
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

On 4/29/26 15:49, Lazar, Lijo wrote:
> 
> 
> On 29-Apr-26 6:17 PM, Christian König wrote:
>> On 4/29/26 14:37, Lijo Lazar wrote:
>>> Adjust gart size to account for space required for firmware private
>>> buffer allocation, if any.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 2 ++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 ++
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 2 ++
>>>   3 files changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index e1ace7d44ffd..1c32e653a9ad 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -723,6 +723,8 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>>>           adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>       }
>>>   +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>> +
>>
>> That is pretty much exactly what we don't want.
>>
>> The SMU prv buffer size should *NOT* override the amdgpu_gart_size parameter.
>>
>> Instead we should disable the SMU feature when the GART size isn't sufficient.
>>
> 
> This is not enabled by default. In normal cases, this size will be 0. This an extra allocation for additional logging from FW to system memory facilitated through a module parameter.

Yeah I know. But we have cases were the GART size is explicitely specified for testing.

Overriding that because the SMU logging feature is enabled is a pretty big no-go.

When the user specifies contradicting module parameter we should fail to load the driver or at least disable the feature which causes problems.

Regards,
Christian.

> 
> Thanks,
> Lijo
> 
>> Regards,
>> Christian.
>>
>>>       gmc_v10_0_vram_gtt_location(adev, &adev->gmc);
>>>         return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 94d6631ce0bc..2f6e338f2a35 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -714,6 +714,8 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>>>       else
>>>           adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>   +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>> +
>>>       gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
>>>         return 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index 5bdd4b9b7893..e5096b9cdf50 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -770,6 +770,8 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
>>>       } else
>>>           adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
>>>   +    adev->gmc.gart_size += adev->pm.smu_prv_buffer_size;
>>> +
>>>       gmc_v12_0_vram_gtt_location(adev, &adev->gmc);
>>>         return 0;
>>
> 

