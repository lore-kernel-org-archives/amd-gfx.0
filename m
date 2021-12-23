Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBE8C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 15:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B5810E28D;
	Thu, 23 Dec 2021 15:43:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD8F10E28D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 15:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWDcAxmmvDct/1HllnpUyh4yJvI1TJROI+MrKSDMCya+U4YjvzBBL+kmD5MGg6+4Q5miFyr179Igz4JomsE4E2+C3SqIYVlbcMgjx0wrQxYS362992FSCBpg7dSFlxfOz7OwIe6SAMwA4IiC8Y+Gh/gMUBnpyDfUSfqqNMTe+ytURPG9l6XU0dvVmvKTmEtIw9dsFojXCumEtV3xq5S9gy74gansuUrEFXiUgS/x076rK67UrnFusMM/4CokSJNpj041UVpPb5akS559FuVvszuHzc8s5ZKijpPTE2Ob5WO4uoeNIDQbRG/+M+b2Y8i3l9Nd7j0LzG/HY9kh1UFH7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/x/8KWomxpsd/9EtjBbbtYfnXKTfJLFWUfGKUCcL58=;
 b=DORaVdXwAOQ4DNjROKFqA+0wUAAoWUnCCFoKZWbVSDuRFtdRov0W5e6BmvCi4zPm0RGMTH176GOysjnlMUozwyQi/ikogrox8p5YiKxVR0cHEMwA3lq3wJMM3yujmxn2RR/Q5yr8mlSTsI6Pjqu7ELni3gS7XKDmlQ5sOesMa5P1XApE6ydM0DGwNBxo93cK5g0KGYPeSPsY+nVvaOutCTbTIFkgDbmKqZkO82GkrP9vPnhdhRFsFfIkh72noEaZ0W1oqKOmYkiRBiAuK+XwOZT3sKmCbYmHVMnM36u2ydryKv7dtPbUMWiA/TmUhtcBcYXs68rDrgNE8YdcJDuVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/x/8KWomxpsd/9EtjBbbtYfnXKTfJLFWUfGKUCcL58=;
 b=mP4MQTMfFwycDKHQpCl6d54MiLjFNw48qBNQbPWyx3uGatamSd531BPV1I7u9nOqrBcgdnupz4kUuXgv+edEu64gWNkthkEDDiW/2NOsARf2eWmuD4cn43WWwlu05lHRtHVuFXM4+WmvGxn+zNO0V/Q63yRvEa4iiFEr60Acp5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3097.namprd12.prod.outlook.com (2603:10b6:5:11d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Thu, 23 Dec
 2021 15:43:02 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4801.024; Thu, 23 Dec 2021
 15:43:01 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
 is unplugged to prevent crash in GPU initialization failure
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Shi, Leslie" <Yuliang.Shi@amd.com>
References: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
 <b5b1e8f6-c7c6-b465-6d4b-75e7a709f4dd@amd.com>
 <3ef0795e-34aa-8748-3ab0-bd9e936cb702@amd.com>
 <DM6PR12MB39302C239EB5DBBF5EF30F7B97789@DM6PR12MB3930.namprd12.prod.outlook.com>
 <be2b13c1-09fd-1cb9-4157-872ac49dc03b@amd.com>
 <DM6PR12MB39306C1F1EF550E0AB0872D6977E9@DM6PR12MB3930.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <009b0a76-d70c-788e-7ddf-d13bcc9cd338@amd.com>
Date: Thu, 23 Dec 2021 10:42:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB39306C1F1EF550E0AB0872D6977E9@DM6PR12MB3930.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d298ee-f1b7-4a09-f863-08d9c62ae6db
X-MS-TrafficTypeDiagnostic: DM6PR12MB3097:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3097FE6E144EAD940F5541C8EA7E9@DM6PR12MB3097.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4FD5Q3HLAF11HZ+pbuE2groJxnWYKy1fyqx7MAMu9RzxwGucUCKFB1+HoizMw6mjCGxHZY8a13M/hUrtj4al7lzJqA36C7yEIXOlBjn7kRfQKGfgqFfcQDm4dneBrYMgMm2Odth1YJb8klzXI1MV/lY0DXS3vmFNgG93YJ4srVlA6UqTNtzjZXUNrvG2VfMlVT0qXIlUsGofE0OQIjACcSFt6PBSJKN3fA0vngdUkXE8lLus/RNKViyIw6qE8QlOnHAVcNQNAa3VVQqQJ/uhRSinzWCqt4jh92OBp9cwMhn3UJynLmlAhKVa1LpdQyhYCUwc3EMfIwWBKd89YqIstvTiaIRHW1+atM5/+/ST7oWjkDSLz1tivzFkc7Nx9vpZLicXTYKEajdX47aBINfXoOPTF2iYxaJ9/ZNzqV1XY0foHphXMoZssaDwyvj5yaEK8NTQKIU+C/D0YNY0VokFnbCKtto6cHENlnJzWtoMBLYflCAEEpx2YjmJiGgjwYenioYCshkGiyvPWgo2cVSP/ArwAHk3bM27MY1Di2vbkaGR5SEhPysE2/tHR9nMz1yXntA3eLJZoSk8f5CY2HzY2JByz0gNKNTBOW2GtRa3fyL+EPASZK76NFHwa6PNH+eUDgcJCY27TnkRdSNFk0zf2Dc/7c06N8OQ1Pa2wfaxmpP//ijUmNEUlp7sDgn0x5MXD3kHjhChzf8x09RZBf/pJ+bW94LC0qDFqREjnQASCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(316002)(186003)(38100700002)(2906002)(31696002)(6506007)(8936002)(110136005)(5660300002)(53546011)(36756003)(508600001)(31686004)(6512007)(66556008)(8676002)(6636002)(83380400001)(4001150100001)(66946007)(66476007)(44832011)(2616005)(6486002)(6666004)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktTd3VuUmRBLzhjN0NIdEUzV2hnSVlHelVTb1lXV2w2WWlsaDRicCtwVzB5?=
 =?utf-8?B?TzJoV1JNZE50Qk55QXZxN3JNQUpWZWVvanpjcGJ0OGNqZk5qeUZlSE5aWmI3?=
 =?utf-8?B?dXVjcmVRbmszMHBTNTVUcXJXeUVoWW1LWUljUVNFY3NhVHl4cGdPN0FoMktO?=
 =?utf-8?B?bkR6QXU2Rm1PMWJFUDB0M0lZVmpQc2M0citOOFQvZXNuQVVVYks2YmRVZ2FB?=
 =?utf-8?B?a2lFMHhsWEhhbExaL21SWTExSHMrbXUreXRrdDl2cXVOMnVsdnBqT0hHV0F6?=
 =?utf-8?B?Sjc2ajRSeUJPVmFlTkNZbURNdnJDWnNaWnNpb3hHQTVmYUgxb1VkanFRclYx?=
 =?utf-8?B?aUM1ZWFmUGVEelY1alFjRFBta2NYTm1yS2FISFppcjJ0V1h2L0NFRTBPS045?=
 =?utf-8?B?V3EwT2FkUjhwYWhtckJrMXR1OFpZUGxjUDVWS1hWVUt0VnJlYzZpeU5yMFlG?=
 =?utf-8?B?QnhKRVBxa0thQjVHcG5PTXpDYllNdEV0a1RUbUNkdmpad25qd0kxQkZGY0VI?=
 =?utf-8?B?R2ZKcTJaNkRmYWJlLzlzSWVsNi8rN2d2YzBxUkIrNytlRklva2lDRE0zWEVM?=
 =?utf-8?B?SlZvWVJYVmRYWmN3TndzMTJiWHg0blpkQkRYTTJRU01hODFUanpRWENtZGd1?=
 =?utf-8?B?aGNzZmxvL0xVM0xLNTIwSU4zNTgxb0svblp1YlNydnpQZ1ZDUys5RWVQOEFM?=
 =?utf-8?B?eVljY05EdVR3RkdscHl2UmVjRktLNmlnR3ZYNEdycDRrNUpTUUNobzlEZWlO?=
 =?utf-8?B?T0R6dVp0Rlg3ZlFPUHV6SEZrYTNYMktBNnRQM05UVGNXT3JRcS9TQUUwVGNY?=
 =?utf-8?B?SEVsNWtaa25FcnNwT2tsc1Q3MkEvcnZUOG5XU0plZ1BqdHhMOEkvS1FlMklZ?=
 =?utf-8?B?akgzL0cxbFZPWVFCUExQQXVtL1IwOUgvSzQ4bTRYRU4vU0RvYXNkaUg3YjMx?=
 =?utf-8?B?MDlhSWxwUFpGY3ZKUmV3eWtRMlBtQ0ZMUGJBcHgxSlY3eW83cVp2c29aSlJ5?=
 =?utf-8?B?NngrcFdyWU1Ga013MjgyYzRLck53N0h2bTI2SDJUTHJmTnpqYjViNUF0NDB3?=
 =?utf-8?B?dW8rS09JMEhZOFNxWHVFVU9hOTNMaVJFdi94QlZpcDBFQUtnSFZKQ3lLbFFS?=
 =?utf-8?B?cUt2anM4NVhMNW1WeGovbGppL1J4VkFCUkVxQVp2d1MvTmpoWFlOMzFvRVVo?=
 =?utf-8?B?bUxNVlFNZXIxREZ0c2NzM2IraWViS2x1dmFtNlduYnpFbk5yd2xpSDRiSW9k?=
 =?utf-8?B?OEZVZEk1MjN6a0YwTkdPL1U0aC9sSUxhcHRMY0lYWW1XOE42c2NxZWVySGVX?=
 =?utf-8?B?WWhQUXkzV1g2cXo0Rkltd05oNEFzQ0FhTTJBQjJMY0l0ZXBiZVRGQ0lLUEMz?=
 =?utf-8?B?S3pCRWlkR1ViSmY5RzRZdWhqcStrL3RwcGprVFZ4cXhCdlJJUS9MNXk4VnZK?=
 =?utf-8?B?MkVxcGtiUlBkZTZaREh2UnJHMGZxUVRQbE9QUzZrOG1iYk43MmZrM0ROcURm?=
 =?utf-8?B?emhGSVlBc3FaUkpBdU1PL2tnUEh3MFZQMVo4QlZkQUc5SklsMFJlUnZ3bndp?=
 =?utf-8?B?SENod3RGSzgzY1d4OU93RTYyc0Y0SnVvamZCRFNEdEd1SHdmM21IU285dFRW?=
 =?utf-8?B?N2VsbFV4SG1YMktlOXVZQkVXbXhDVEVVcSt1cEVkbjVIME5Zd0thVXhZMTBY?=
 =?utf-8?B?YUtlVktlR3N6OHdEVExTcjFNd0NHMnpOQTRzMWo0eDF1RlNzRXZhb25GaDl3?=
 =?utf-8?B?aVB3T0c1WHI0eStzSWtVYUFYcDBPcEtYY3NRNVhOSndUSks5VE1KV0JkNlVE?=
 =?utf-8?B?ZjJ0TndmUHVHUXd4cTJMN1h5OU03VXM2dldPMzFZTVo2WmVxcG43SWV3VmlM?=
 =?utf-8?B?U3pDanBCb3VRd1g1RkRhcHpmRWRFZVlZbTJ3QTNtTHdMUnZVUmZRM3RGQ1Jx?=
 =?utf-8?B?dTBpNVU0eWhvTmRYVERFMnV6QWMyTElSdkJzcEhIV3NNWkFrQm81b1NoZlU3?=
 =?utf-8?B?K0xZaUE2VTY4ZysycVdQNko0blRZYlV2c3BmajB0V3dQbldqZWtEd3RnT0ZJ?=
 =?utf-8?B?SS9IZjIyUVlkd1JyR3dERXZoVytSSjBEdk1IZEtadm9iUFk5Y3YrY3loMWw2?=
 =?utf-8?B?bm9SaUF2ZHZyMWc5ekhBc1IxUktpbUN2QmNHSk1Nc29yamtRWkgzUXpIQ245?=
 =?utf-8?B?NDlNYkVqdEhqQ3NFVmNqYXlRQWd5MitMVGloZ3MzbXQwT3kzSVkyc0Q0djZm?=
 =?utf-8?Q?PIrhg4fj1Spz2QyfmrA2AaVkIEGPwqWLiyzVj51H4M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d298ee-f1b7-4a09-f863-08d9c62ae6db
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 15:43:01.5768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsB4lqeCfA/SjhLSH2jJTRp4XUNlo8AzIVC9h4B6v3tUgY3q9SoL7HpVsBZe8n4b3lUb3hv/eRJgQuAfcp3xvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3097
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

Adding back public list and Leslie specifically.

Lijo is right and it's not MTTR release only, also all the unmaps in 
amdgpu_device_unmap_mmio
since this patch makes call to amdgpu_device_unmap_mmio conditioned on 
device unplugged
we need then to still take care of unmapping even when device is NOT 
unplugged - for this i suggest
to look at 'drm/amdgpu: Unmap all MMIO mappings' and just conditionally 
call all the deleted unmaps
in the patch where the condition is 'if (drm_dev_enter(dev))'.

Andrey

On 2021-12-23 8:47 a.m., Lazar, Lijo wrote:
> [AMD Official Use Only]
>
> Actually, I was asking specifically about this -
>
> gmc_v9_0_sw_init -> amdgpu_bo_init->    adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
>                                  adev->gmc.aper_size);
>
>
> As per this patch, if the driver load failed due to some error which happens during hw_init(), this action is not undone. I was thinking why it's not considered important to skip this on driver failure to load. For ex: when some MTRR register is reserved for this mapping.
>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Friday, December 17, 2021 9:05 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device is unplugged to prevent crash in GPU initialization failure
>
> We do unmap on unload, this function is a collection of all MMIO unmapps we already do on unload, it's just does them early on in case of device hot removal. Before pci_driver.remove callback (amdgpu_pci_remove) finish execution.
>
> Andrey
>
> On 2021-12-17 10:23 a.m., Lazar, Lijo wrote:
>> [AMD Official Use Only]
>>
>> As a side note,  even if it's a failed driver load, why it is not important to undo the mappings created during driver load? I'm wondering what is the impact on a system like MI200 A+A.
>>
>> Thanks,
>> Lijo
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Andrey Grodzovsky
>> Sent: Friday, December 17, 2021 8:32 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Shi, Leslie
>> <Yuliang.Shi@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Chen, Guchun <Guchun.Chen@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if
>> device is unplugged to prevent crash in GPU initialization failure
>>
>> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>
>> Andrey
>>
>> On 2021-12-17 3:49 a.m., Christian König wrote:
>>> Am 17.12.21 um 03:26 schrieb Leslie Shi:
>>>> [Why]
>>>> In amdgpu_driver_load_kms, when amdgpu_device_init returns error
>>>> during driver modprobe, it will start the error handle path
>>>> immediately and call into amdgpu_device_unmap_mmio as well to
>>>> release mapped VRAM. However, in the following release callback,
>>>> driver stills visits the unmapped memory like
>>>> vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.
>>>>
>>>> [How]
>>>> call amdgpu_device_unmap_mmio() if device is unplugged to prevent
>>>> invalid memory address in
>>>> vcn_v3_0_sw_fini() when GPU initialization failure.
>>>>
>>>> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
>>> Looks sane to me, but Andrey should probably nood as well.
>>>
>>> Acked-by: Christian König <christian.koenig@amd.com>
>>>
>>>> ---
>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>>>>     1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index f31caec669e7..f6a47b927cfd 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -3899,7 +3899,9 @@ void amdgpu_device_fini_hw(struct
>>>> amdgpu_device
>>>> *adev)
>>>>           amdgpu_gart_dummy_page_fini(adev);
>>>>     -    amdgpu_device_unmap_mmio(adev);
>>>> +    if (drm_dev_is_unplugged(adev_to_drm(adev)))
>>>> +        amdgpu_device_unmap_mmio(adev);
>>>> +
>>>>     }
>>>>       void amdgpu_device_fini_sw(struct amdgpu_device *adev)
