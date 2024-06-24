Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DC6C2BD05
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 11:57:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243F910E17D;
	Mon, 24 Jun 2024 11:57:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zj35swdp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7088110E17D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 11:57:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wa2hV2g+Ev8eQ6Jtjx7iBM0qlTgiV5rBXGpycPFSeKeTZQKaNlqBLfDySOwUQ62IKClbaHOfnWzB+8VxyAk/mF665SM9Hp4w08G/ZOvfFtnEqbtaRlyikaHHNYq+Mexovx/mibxCtgV0w4NfMeu3ZA8+hHMsK8MaR7KWhpyzb1MVA8p9gm+Qqwv205b1szj47ltA+F+SEn39c2pUeBH9c4chgHQ4Jk4p3MjjIiZ+shof/dTkdN0ef1MLUq+VA1ABU9gl9zD/L775YkMNouu4t18YgHwIsqGKS6pviG5p2XetF5kFA7ze5WLha+2mCxrBxFBAs+rCpHAGWPb7C5PKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqHb5n8c6asaELxuwsFcHegF0Y2uBn1+yGxwuy2UGMw=;
 b=XVWhU+E2JCtwQn9SifAdBC4qeVluRMAmeaVJ238jamEQWEBOF55EIBetHffOCOzNXNv8/Etx3MKV8NlSHVl05vO5Sl4CwTWh61LYVt8rRaA+ujna+fnIjndPcOIdrdcf2W8llNGe8FHl59Z6VbSuYZg60Lvt9Q/JzJDHRu+QXmfbs31XJL5pqYjh/LNtdaJ1UxMsGExIzZkZM8AwTPSnOLvbqhSsXo1yA4DwvqmexDxxmZ0s3KNxpqWBB3oS5LuA2a5ED6el4Bm1Wa/6QhvUtubkkwsB11NFGIFn29UdzxVjKD2z/vjQ84aLC45uCta14cv5n0NwgDko77dz/VUPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqHb5n8c6asaELxuwsFcHegF0Y2uBn1+yGxwuy2UGMw=;
 b=zj35swdp3yBCPgHLDuZefsr8okWiTjFZE+epGo0jRwROXraAUQlr2E8gAql1IzwT0X4ii9HpNXFeuVVaLSOvuW82GdXzwOCUQqKPDXZJy+BfpSB6PJ5+lbmTQny25hmWezAaqOKpikFX46HjqSgyU0nsKcK6S3EHbBLxErnMCRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4417.namprd12.prod.outlook.com (2603:10b6:5:2a4::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.26; Mon, 24 Jun 2024 11:57:09 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 11:57:09 +0000
Message-ID: <fae5960b-b782-4f7f-b8b2-64a1af62f61f@amd.com>
Date: Mon, 24 Jun 2024 17:27:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
 <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
 <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
 <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: 17623d27-9214-46c2-36b3-08dc9444c6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnp4T01Ocm1sU0p0QmJkMWxncWE0QU5ydDVDWE1iWkFUNTFVWHo0Q3JpcE4v?=
 =?utf-8?B?bmVQaGZFNVNlZUtVSExXUURNems4RWpOeFpFY3BpU1BseDBOWjZjWS9kMXlm?=
 =?utf-8?B?N1R6emsrV21neDFTNE9oRitUUE1iNVdhVXUzTVlmZnBIVmZxWlg2aVIwZ3E0?=
 =?utf-8?B?cnpvRVlGYWhkNHpJcXNpMDRhdllvbzB6MkYrOTlDVXk3bUxiN0JoNzBEKzhL?=
 =?utf-8?B?cEw4U3IxYi81RDNjaEVHU3BVaUtHU2VlTnZCRDFoYzQ3Q0ZpUGtVLzZlbFZN?=
 =?utf-8?B?cDVrQXJoWkp0aDEzV3lqL3c1UlYvK0FVZTFUeGFTMTF3dkRYM2psMXoyMWJk?=
 =?utf-8?B?VnRZSFYrYVJzdytyNnB6eEFha3FGbG11N3RGRnlaS0l1YXNHUEdBT09rejBN?=
 =?utf-8?B?YTVORkFIVG9SVStvK1I2K3FEeXRpTjhCTGFqWC9qV1VzclF0NmRwY056aktN?=
 =?utf-8?B?cm1QR0o5TWJlR1dnLzM4QXZkLzVraXl2YlJEdHZhTWtXQlpLeDQ1ck5yWkh3?=
 =?utf-8?B?b0tLUi9vMzV2cVlsZWplSmkwM3BBNkozei9vRnhLR2dZTlZrUFNlUS91RDBy?=
 =?utf-8?B?VHRHSkNENzNON3k0enl5ZSswT0F1YzlMN2Fham9jMDFCb254ZHpNRktvVEFh?=
 =?utf-8?B?NHhKdEFQQVVsdnZWdmdlczdFWlVqdFJPenBGZWNOeFh4LzJ0RzZqcnBEMG5K?=
 =?utf-8?B?VTJzK2lMMWhHZHA1R1oxNURKV01yMVd5aFFVK2J2eC9pdmRUcjBNZFgwTGsz?=
 =?utf-8?B?c2RUNnIwRFlkQTNFb2M4OFFoM09DWTlJN0F2TWJQeDI4TkJsTS9VRGE0bGxy?=
 =?utf-8?B?UkRlMngwK3lhdUlFQUw5VVIzQkpKZDBvT1UrcHZDckJaMitJR0JWUGpBcnpS?=
 =?utf-8?B?dDN4cWUyZXdGTy9GWStxK1NHMU5EWU13YUF3SGR3OStSckR3a3lDeitKbzQw?=
 =?utf-8?B?eVFLV3FSUndiTnl4UUp4cjlPT0ZXMENUZzI1UUxVNjNhTTJkU2xqbmM2M0hq?=
 =?utf-8?B?TW4zSitkZG5TNXRlV1lIY2FwaEdIdjZiQmFWVCszbUVrNHpLb01LUk1wdkJP?=
 =?utf-8?B?WWdXdXhiMUJoNnhNSm9PU2dHdDBEbFdpRDUxZWkzYmRsTEZuT1RlV3pwSWFY?=
 =?utf-8?B?NUEwMEVHMzFBa0Q4NlR1cXlwS2k5SUx2YUthOXZWTFl2V01uMWR2cnZsOXNp?=
 =?utf-8?B?bXVRc3pvT3NJcjNnNVZSa2xCS0VSSWY4c2E5bVUwelF2ZE9GdkhJUXE1eHdD?=
 =?utf-8?B?b0F3Y0oybDRtN0FwM29wUzlRZjhYdzdFQ29Jem5mbnBJTzkzeURIVHBVSEpG?=
 =?utf-8?B?VTRXUHdtekk4QUNGYnUvcTRFTENRNi8zdzJGeFpoRTJNakpMbVFsUEN4ZXBp?=
 =?utf-8?B?Ujl0Zk5kOU14MGRVcDJWczcwZ2dycU0xWHJMQWJPeWVhRThvc2tiUjAybTYx?=
 =?utf-8?B?SWxISXNPRVhSU0p1SWpGV1VNZ2JjOFBBRVBFQ3FxRHArbk5TaWxwYnJJOVlY?=
 =?utf-8?B?dkY0WFdzbDNPNkRZRlg5NTFjUUx3QTNSZ3p1RldQUnkvejJXVnRJUVU3bXNk?=
 =?utf-8?B?M3BXOTZYR20vMmZRUjI2c1hmdnVzMXJBcFI1V1czN04yQjVMSWszTTFYV3Vr?=
 =?utf-8?B?RlBzRTRNaHVVMzU1MStwVFZXN2s4UkFtT3hBcEs3ZlJDTW5QQ0ZxdTZBN240?=
 =?utf-8?B?YmNNbjJHbUlIRGtheVgvRDh5eXVISkpKbzROVGJ2b2ZHUytsamFOaHlRR1RK?=
 =?utf-8?Q?g0iUbv7C7X67EnMb7ujai+bvatS/08I/q1TIsDM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNsVXFqdENNYnh0c0tYOFlXTDNrRHo1YUtseFJ2bkFpYnVBNVgzYXplUWdz?=
 =?utf-8?B?dFY3d3R5VllKdVU0dHlkK1AvVXprVmV2MlZkUWpWd0svcG5ZT0pHc1BKV3dU?=
 =?utf-8?B?V09sTTY1V3ZRc29ueFpkYUwvYUtvL0Z4TU9XeG1IT1ZSQm1PTHpJbEZVLzlD?=
 =?utf-8?B?Z0M4c1czMnNKTElZL0JIbkFwVnVyNjhNVVFnTHZJRndidjZHSFhKbDV1VC9Y?=
 =?utf-8?B?TGVld3luVmtwd3JaRUdiNktQMTgwaDNFWHBUQ0daNkpWUlFOdlVWL1VLekRj?=
 =?utf-8?B?NHMzRFFGYnFheWoxS1BXWW9wUGZIWjJya3JZZVBsamYrbFVEVUR3YXVaSmJE?=
 =?utf-8?B?RDc2a1hvNEM4Z2p3a3NpU0psd2pmbko0VTd5d0xjQTF0VDB2bWIvNmI0MWV4?=
 =?utf-8?B?aCtBRXJVQkFPSXhYMVJmZklaZVlPNlZjZG5PcHJqVTN2NGEyanRvTityVkd1?=
 =?utf-8?B?NGgvWDZ5eFdDMmRIMzU5bFdtUUJNTjZSQXQ2eUJ3TWdDUnllaUFubVJvQkpr?=
 =?utf-8?B?SmJaRW53UEhVbk1zMllaM1RIbWJYL2J2WG80N1Y3Qm8xYXZHa3hHUC9mN1dS?=
 =?utf-8?B?U2NNNy9FMTFDdXQxTXRoTisyemovNjhiOUp1VXVGazNKZ1dxWjVVOVUwc0hX?=
 =?utf-8?B?YUtJL3JjeUcwTTM0cU1nb0dPWTI1aTF3ek5CYkpmVTRNd3NtT1JlbmV0V0hE?=
 =?utf-8?B?dWZaeHpyNXNtZ0tiSTFIaFJUZ09Wa0ZZZGdJWWxSR3NnbHMrMzNPcGVmSW01?=
 =?utf-8?B?TW1WeWN6dEV3QUtid0xLOFhCdVpCdGpiVVg5QnJQZ25RSndVQXdoejB4c2lU?=
 =?utf-8?B?STd2eHh5a0UxalgvcnBTKzJ4NlpVcFNhbGxOWkg2SzRmVTNObk82SG5hUERE?=
 =?utf-8?B?T2VDbFFVUVA5VHIwaWlETThmMTJuTlFBQ01iMmFxU0ZqUVpoTUQ1KytRZHB2?=
 =?utf-8?B?djhmQWJBbXRKdisrSUdyOHRjVE5FMkFMaW1zeFB6ZUNLaEhLSW9JQmFENlFv?=
 =?utf-8?B?elN4S1A3N2dVS3Z4ZU9hVHF6Ym0zZVd5anR6ZkdrR0JMVXVsMWlvTHErM2Zr?=
 =?utf-8?B?eUJUYzJtT1dsaEtiZUgyVXhiN2Y0RTVpTFZOQlg3b0R5YWVaRHFCUXRiTGxD?=
 =?utf-8?B?MmZYeGR3SnA4NUVVdHozMUZqa3VSaDBnNUVGdTNMNk8xNzBXY1M4RWxKNVhE?=
 =?utf-8?B?UU9pbXVQTm1KRU5ySkw4c211ZWxaUStFVDlIMUEvZllxakxtVEs0cjM1M0R1?=
 =?utf-8?B?dlR5YXF5SkxidWM3eFFtZU9pNUVSRWZvUitTalFQWWJuSURsOFVYL0h4WFdF?=
 =?utf-8?B?b1M5YlpRaEkrT0NsY1dXRFRzaFRqbFphb2pxNnZsYjZuVzZhd2pTUVErUlBh?=
 =?utf-8?B?aEdjajJ4VDJVL0lYYU9aR0ExNG1UYkdnbE44N3FoMWF3cmYvQ3EzWnEwMjFK?=
 =?utf-8?B?RnhuajVRc1ZVMDQydytCNW9GdjdLZThSWnFSbFhPL2srOGd3cE5mTUFPRUVm?=
 =?utf-8?B?SU1aRzVwT1NTY0VNeFA3bGk3OGF5aVRvRWNzTHNqYlNOcHk4YXgwbUl2anNi?=
 =?utf-8?B?b0tSUk9pOVVEZWpobHN4RTJOM2hVQWx6Z21ERzdYM3dCT2ZiazlxRE54Y0l2?=
 =?utf-8?B?dFFrZUMwOFJ5MDl5M2NwNXpiaW9KQmhjbFBRS3pORHcxVHdLaGpOeUNWaWs3?=
 =?utf-8?B?Q1pPYm82ZVJ6NTFGenloTHlnUzA5Vmx5UWlKNmlCV3hjb2lCL1kwdjRINTVu?=
 =?utf-8?B?Y0xlMk1qdGd6ajJTWDJTaitDS2c1K0pYanZxRTZLZGdFZnE1MzFtd2FBV1dH?=
 =?utf-8?B?UWhhekpORmpRSjhRSkdIcTk3YXI1SmE2UkV3UUFaaFBidmpvdytPMlBtS0tz?=
 =?utf-8?B?aytSdTdsTFJWSmcrSE9Gcng0RXhJZGd5ZkwwRHpPalJETHpZR0xIZUxEM3VQ?=
 =?utf-8?B?cWU5T1l1VkRIY25NUFRtSFJYaC82NjlOdTZwZnhpTkVHQmhhUU1URDdNSDBX?=
 =?utf-8?B?RFNhcEM3Vk9YajlGZy8wdmtxSERKVTZ1UFVjblhSMHBXZStxaGFKZ2E3Y0M4?=
 =?utf-8?B?N2QyUWVvRlNpb0FVSjR4RThiaUJwVTJ1S2VuT05qZXpHTzh2NjF6dlNvYWRk?=
 =?utf-8?Q?YLzITUXsqdMWkDSUsbieQCsP+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17623d27-9214-46c2-36b3-08dc9444c6ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 11:57:09.5455 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U79s/upYgJzCzH0IE0uESVDOvJ3laR8Shz3Qxhjj4rGkQJFIFjnhDREl5Cuhltzu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4417
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



On 6/24/2024 5:19 PM, Christian König wrote:
> Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
>>
>> On 6/24/2024 3:08 PM, Christian König wrote:
>>> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>>>> correctly handle the case when trylock fails when gpu is
>>>>> about to be reset by dropping the request instead of using mmio
>>>>>
>>>>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> ---
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38
>>>>> ++++++++++++----------
>>>>>    1 file changed, 21 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>>>> amdgpu_device *adev,
>>>>>          if ((reg * 4) < adev->rmmio_size) {
>>>>>            if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>> -            up_read(&adev->reset_domain->sem);
>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>> +                up_read(&adev->reset_domain->sem);
>>>>> +            }
>>> What has actually changed here? As far as I can see that isn't
>>> functionally different to the existing code.
>>>
>> In earlier logic, if it fails to get the lock, it takes the 'else' path.
>> The 'else' path is not meant for sriov/vf.
> 
> Yeah, but the read or write is then just silently dropped.
> 
> That can't be correct either.
> 

These are void funcs. Moreover, the drops will happen if there is
concurrent access from another thread while a reset is going on. That is
expected and those accesses during a reset won't help anyway.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>>>            } else {
>>>>>                ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>            }
>>>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>>>> amdgpu_device *adev,
>>>>>                                 &rlcg_flag)) {
>>>>>                ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0, rlcg_flag,
>>>>> GET_INST(GC, xcc_id));
>>>>>            } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>> -            up_read(&adev->reset_domain->sem);
>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>> +                up_read(&adev->reset_domain->sem);
>>>>> +            }
>>>>>            } else {
>>>>>                ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>            }
>>>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>>>> *adev,
>>>>>          if ((reg * 4) < adev->rmmio_size) {
>>>>>            if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>> -            up_read(&adev->reset_domain->sem);
>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>> +                up_read(&adev->reset_domain->sem);
>>>>> +            }
>>>>>            } else {
>>>>>                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>            }
>>>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>>>> amdgpu_device *adev,
>>>>>                                 &rlcg_flag)) {
>>>>>                amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>>>> GET_INST(GC, xcc_id));
>>>>>            } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>> -            up_read(&adev->reset_domain->sem);
>>>>> -        } else {
>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>> +                up_read(&adev->reset_domain->sem);
>>>>> +            }
>>>>> +            } else {
>>>>>                writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
>>>>>            }
>>>>>        } else {
> 
