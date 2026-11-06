Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EFF606A32C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v07Leoym
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE0710E1F4;
	Fri,  6 Nov 2026 09:08:50 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011041.outbound.protection.outlook.com [52.101.62.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC2F10E1F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 09:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7hHxWFTerMsDKlpZCy3eJUd5DTAj81yNfpm0QMBydx1Qx8fI9A1yE25fLkLcHuxn3Kpnw8mWoX/SMDqmb3QperetDS5HBcUfo0MLYrwmpAm0lZPz4Pik0MsyjPlt5x69XTVhfFKrHdSGkWZnkFWCcgK0PbPJG4NuBz0f5mCswZwKhaJeGkcM4BS7L2tqDDlT2vdt4yZf3b3aoWS5t+UZb5JnIivWm0kUZlNiEbu0QyqXcius9A1+epyaqeA7rBC6xUdG3oCTdU0hRV4OQFZCjTFqcc2jx1EfYBedZw/YEZCEr7PdjbBZcwMbpsEgKtYbTRhByDnYD5Vb2F3WBctkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdmupRrk2Epfsv46JYbcl758uqmh9/y7DmfuLZxp2h0=;
 b=I23n9jSlMqGaZ/Y5nqRqF9aK1Dvw++ma39FLNsn4g9gLuR7IKBijQK5n3NgpR8rhoAHt0lFwm6Xk6Zvwd9caAwOp7n+YXQa9kp36s9Ejg7INgmLfmhANTXqlKQOr4cKItBAf0+ONHC95430bD0Fv586qBo7iuAF8D3mgoHiexQ7uEYtN3ZEqO5B39EsmfdlIeBjfyS8ZOvBkqO7g2WC/1ZJeB2zNIJkXeoJfg51z5MsXTck6IGTZ7tmiaXg6lXKq6Vz8gES6jvV9K6NvxoO1wSRYCHsQTlslzIMGkvsAhpU1NHayat63wB+QlCSSYui0rhTib11fsxhP74kCgE77zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdmupRrk2Epfsv46JYbcl758uqmh9/y7DmfuLZxp2h0=;
 b=v07LeoymLplBl6PCt0T1CZDm3I77a0Bs+pO8Fi5SVJr6fRJG4lTVEwFfZ17Hgn/v2P18DcWTrTYM/8LH7SEQrqB+mYj4x0O9skql4a4UP7gRydvpW0dsK5teClj8S6kvxQUG6+KL7zZW6sHRKx/SeYXzc1Q0+W1Cw80Ybq1HL68=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 09:08:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:08:34 +0000
Message-ID: <213d3fff-d162-466b-ad5f-91feb3494489@amd.com>
Date: Fri, 6 Nov 2026 10:08:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep SPM VF VRAM at GPU address 0
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
References: <20261104200152.77286-1-Zhigang.Luo@amd.com>
 <7d1e794a-a8ec-42d7-81dc-47ed61870f64@amd.com>
 <SA6PR12MB9992027B0CED8C56FD29C4F0F1F1772@SA6PR12MB999202.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SA6PR12MB9992027B0CED8C56FD29C4F0F1F1772@SA6PR12MB999202.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff99919-d551-4f63-8938-08df3be588b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|56012099006|22082099003|10067099003|261009223027099003|5023799004|261102123227099003|11063799006|261021121427099003|261022105027099003|261021123027099003|4143699003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: z8tTQ1kfPOn479s00nZ5d7kX2DikK9S7YSK/2FDRxxUQQzzSwvIXLA9E7GA8s2fzM4bSCCwa+4Yixe8xlnVPfAMWJMXIFLyVz78b7ONh9X/HqbZsGB/RDyVGKmfX+XZWLvFdnNHZff5YI5o3uaX7OXQsg5a4i1eYOxTe1phWsXfddZPpfcGq+6ei9R2FPudw8NyWc5zBwEjk+KhEakS/kPE9yAEhG+e7b0J4YwIaIf2kYH6Ipeq4jVyASu6PrpqZuc7+y/xafl/gnclLqBGt8sZUli8F2t9haFOqPP0VZU6LQQ6zTIpk5MAhgjPWkwSiZLVUCtWzQ7pJhr19a7RJdk1UAx4fJMT1gus5L99pWB3V/1vMg5IC4HPEeq36WU0s2yLvFtRollNVU6LYxy/dTCwTP2nxRAmE4jpOPwokqY1G9QrXF7kUwB2M1No891yi9TceLduTxMYR0WkLjXSlRMRmZV5LA+XkOA2o2FBtChncw7NV/808scGuRgBNpLTuBsy/gdRU3EcCeFePhj3Wnz68k2QD3WX9505uwcZjQ7CjR6RdoI74rVu1TcMCxcbxG43BcvhF0jIyMy+3ZV1Q0GjsSHqWO4swRcuwdKctS563fAhIDht8w8dgQWVWBnsSPgbilYhVI6MD8MO8wDYLQktcD4kGDSexF+5u4IbYUWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(22082099003)(10067099003)(261009223027099003)(5023799004)(261102123227099003)(11063799006)(261021121427099003)(261022105027099003)(261021123027099003)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFhjek0zNVRubTNiNk53TWRvcFk2NDYxQW9mdkMrWThhZkFmQXZHMjh1VDN3?=
 =?utf-8?B?WW9iNU1vRjlYdm93bXUveGUrMS9oem9oQlE0QitjWERFSU42V0pGa0NURyt3?=
 =?utf-8?B?RTNSQ2pQeDFZTmkxT1FROGQyV1R6dmtXUlI5ODdGUXpTTUdEUm1tb0ZYTXN5?=
 =?utf-8?B?azY1aHorczE3Slc2N1YrN0Qvcm54K0ptQkFxeGVYMlRreVVBQVpGVE0xd0lO?=
 =?utf-8?B?ZS8yTnI1MDZDbC9SbmthVGJqMm1NWE1QcG90Ky9pa1BkQ2s3VXk3a3BwRjFK?=
 =?utf-8?B?dlNJZWhXRldESjZQVk1oQVB4SVlwaXM0U3gyUVpCQllDUVgvV3ZCOXNTOFpW?=
 =?utf-8?B?WDdrZWxKcC9TQ0NLenhPT001NEVwTVIzSURjMDdGVGtkN2xOdHFDTXZaUnc5?=
 =?utf-8?B?dTBnMWNyaHIvSlcxZVNTL1JmVmMySVpaa3BJUUhtZUp4YnE2cXYxRWtUTDVw?=
 =?utf-8?B?RGc4ZWpzellvNnM5WmpqRnlmZ1ZzZkQwMjdTV3haRmxXbUIyR2JwTlpQbktH?=
 =?utf-8?B?QlhiTzljWnpFelVMRGlwSlRRZTY5OXNQVFRIQkdhTWQ3Vzh2bHhDMFN0ZkVt?=
 =?utf-8?B?VzFqdm9aNVhmVEJwSHE0eGpFeUJLTkF5QWJScjIrT3NJUzRaeVhZMTF6cWdT?=
 =?utf-8?B?RktMbWt0bTZRZjZqdlNXM3V5MUFWZjEzY29JV0NCSy9YbmNBRzF1VURJMncx?=
 =?utf-8?B?ZE1GcUx1VDlpZkNmWDhvYVJKTWhLbWpKSURQalZKdnhRYk9NQ1lmR3I2dWZ0?=
 =?utf-8?B?RExsbDZJV3N2SDAzQlVoVGJ6QVhMMjhJM1dUY0c2SlNPam9uVHlZZi9VZDh2?=
 =?utf-8?B?UDZwL0YyaUpwbWFNT1BJMEpOcGNkWmJiTVBFZHl5MjZGb1dvUzNLMXQxVTh3?=
 =?utf-8?B?TmwrdEgwK0FEaXJIbUtMd1piWEtqRGFlU1V4NjBUUGlZT25qWTdteXc5cmY4?=
 =?utf-8?B?Vnl2YmJaZFpjY0NxR21aWFlOQWN2UzNNVVpUeFlEd2lwWnJ1ejFwN1FtL0Fp?=
 =?utf-8?B?K2puaVJDTVRuNHAvNmQ5NjdUR1Z1ejRkWmZzNjUwd0RiRlFJL2R6N283MnNv?=
 =?utf-8?B?WFJJUGljcDFJQTlGakZsSFV0Rko2cTNYU0tjLzJBa3ZsRFErUWdJczl0VlQ5?=
 =?utf-8?B?LzFvc0UrYzhWMVBGSC9iaHd0NFpFeHdETm9SZi9CQldITFFydWlYTUNJREF2?=
 =?utf-8?B?bkFXclljNGRMQkxzUnhHVWo1T2tXZW5CN0VzZDRwSzdqZmdBWkZ0QWZhcUtP?=
 =?utf-8?B?TENncmc0T29kTTFNcjQ3MmhxVDdPTElDajJ4NlBBLy8yV1dOYTFpYjB2WnF1?=
 =?utf-8?B?cjlvL0pFY1QrdGZwbXd2anhackJMK2M4b0RBNjU4dDNEM2FqSnU5bExmUkFT?=
 =?utf-8?B?WVVIQ3VWTkxVQ0JheDhBM1Q0OGhLM296Wnc5a1dhSDQreGxmOU10M250WGYw?=
 =?utf-8?B?UXJVZXVieGNoanN1eXR4UUFSZkh3YndleUp0bXBLS3VrVDllSk01MVVyT2tn?=
 =?utf-8?B?aHhlMlN6Ny9WdGEzTkdHNkt5S3YxaTZBYWphcE0rbUc4aTBPYThsamk0SGli?=
 =?utf-8?B?dFl5OEduNHRzRlBMNDJCQllJZUJrK2RmK0tEb3VrT3NOSXJ4T0E4WU11My9T?=
 =?utf-8?B?TFVicWJtK2ZrSmxQNk12NnBlTW0ySHBkWDVxUm1Vd2tDdHNOUmhpOWtuMVpq?=
 =?utf-8?B?UFVubmdNVzRULzVSWTg2aTBINFpsdnovaldVMm9RYXBPU0JaZFJYbE1mSWJL?=
 =?utf-8?B?czFOV2wxcUM2NWtBYVNHbFJza0hZT3ZWZlBESnMvcUM4dkVPYzhBWkgwbW9p?=
 =?utf-8?B?aGdZSis1YkxaT3VGSDkrTnNQZkU2QkFnTklRb0JaMGVQNjZtRnVQbmsxVUlz?=
 =?utf-8?B?MmtudUR0MnM5M21UVVAyMThDcm1tVXlUVXM5OUNzaTFiWWpOdGcxa0QzV3FI?=
 =?utf-8?B?Q3BqZHRPZG4wSlJ4VzN0ZkFRNU82d2NiMVhqZEM4SDZWdDlybFhsYUFIQnZN?=
 =?utf-8?B?K2pNRnR0SkZXaFJ3QXFlVmJOQTV5WWpCM3J5MUl0R0MzSk1qa0JhVWFYZXMz?=
 =?utf-8?B?alFzSDUrWWx0dStXbmRqei93alFHYmFVZldXUVJhUXBra2s4ay9FemZ5Rlpo?=
 =?utf-8?B?NWM4RHBNVXZ3d3k2RDBYakhyYmdXbmR6UzZ2Vkt1ekVJK2RWY0t6R3ZYRmFK?=
 =?utf-8?B?MFhBZ21yUEVoU1dvekdQQzhpVkhMVWh3ZkxweXF0YmE5ZVVmWWxzVUtRYmFH?=
 =?utf-8?B?dEtVcXlRdGtwYlZqbzh3QnNONm9OdWdpQndhNmkvNDBLNmZUK3JkWXVDR2U3?=
 =?utf-8?Q?fvtdrNVCvcUkSpw3TM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff99919-d551-4f63-8938-08df3be588b1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 09:08:33.8582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXTfO25Cdxj4YqfEVG6hdZ4JVmjhqy+xinOjB5g0D2HITkjuLPmSgtfnnzucZOLt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 22:31, Luo, Zhigang wrote:
> AMD General
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, November 5, 2026 6:30 AM
>> To: Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
>> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: keep SPM VF VRAM at GPU address 0
>>
>> On 11/4/26 21:01, Zhigang Luo wrote:
>>> - bug 'amdgpu_virt_resume': resume added the xGMI node segment on top
>>>   of the MMHUB FB offset for SPM VRAM; use aper_base and skip the node
>>>   offset
>>> - bug 'gmc_v12_0_vram_gtt_location': the initial load path added the
>>>   same node segment after aper_base; skip it when VRAM is SPM
>>> - bug 'amdgpu_gmc_sysvm_location': SPM used the hive window and a
>> 4GB
>>>   GART alignment; zero the VRAM GPU window and place GART after local
>>>   VRAM on an 8GB PDB0 boundary
>>> - bug 'amdgpu_gmc_pdb0_alloc': PDB0 covered the hive; size SPM
>> coverage
>>>   from mc_vram_size
>>> - bug 'amdgpu_gmc_init_pdb0': SPM subtracted the node segment from
>>>   aper_base; keep the system physical base
>>
>>
>> First of all please write a proper commit message. That here is clearly
>> inacceptable.
> 
> Will rewrite a commit message.
> 
>>
>>
>>>
>>> Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 22 ++++++++++++++++--
>> ----
>>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c     |  6 ++++--
>>>  3 files changed, 29 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 9326f811c500..7a664b7b1ba3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4677,9 +4677,15 @@ static inline int amdgpu_virt_resume(struct
>> amdgpu_device *adev)
>>>     dev_info(adev->dev, "xgmi node, old id %d, new id %d\n",
>>>             prev_physical_node_id, adev->gmc.xgmi.physical_node_id);
>>>
>>> -   adev->vm_manager.vram_base_offset = adev->gfxhub.funcs-
>>> get_mc_fb_offset(adev);
>>> -   adev->vm_manager.vram_base_offset +=
>>> -           adev->gmc.xgmi.physical_node_id * adev-
>>> gmc.xgmi.node_segment_size;
>>> +   if (amdgpu_virt_vram_is_spm(adev)) {
>>> +           adev->vm_manager.vram_base_offset = adev-
>>> gmc.aper_base;
>>
>> Well that is totally nonsense as far as I can see.
>>
>> The vram_base_offset and the PCI aperture are two completely different
>> things.
>>
>> Please explain what you try to do here?
> 
> For the AMDGPU_VIRT_VRAM_IS_SPM case, the VF has no framebuffer BAR and its VRAM is exposed as SPM.

Yeah that's what I already know about.
> Since there is no PCI BAR address to record, gmc.aper_base is reused to hold the VF VRAM system physical address obtained from the ACPI SRAT table.

Clear NAK to that approach, please come up with something clean.
> This is consistent with the existing bare-metal gmc.xgmi.connected_to_cpu case, where aper_base is also not a PCI BAR address;

No it isn't. Exposing VRAM through SPM/SRAT is something completely different.

> it is populated from get_mc_fb_offset(). In both cases, aper_base represents the system physical base of VRAM rather than a PCI framebuffer aperture.

No, that is completely nonsense! aper_base is configuring the CPU access path for the io remap.

It is true that on APUs and when we have an XGMI connection to the CPU it points directly to the local memory associated with the device, but abusing that for the vram_base_offset calculation is an absolutely clear NAK from my side.

>>
>>> +   } else {
>>> +           adev->vm_manager.vram_base_offset =
>>> +                   adev->gfxhub.funcs->get_mc_fb_offset(adev);
>>> +           adev->vm_manager.vram_base_offset +=
>>> +                   adev->gmc.xgmi.physical_node_id *
>>> +                   adev->gmc.xgmi.node_segment_size;
>>> +   }
>>>
>>>     return 0;
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index 4204c3c750a8..78fae3fbee11 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -42,6 +42,8 @@
>>>  #include <drm/ttm/ttm_tt.h>
>>>
>>>  static const u64 four_gb = 0x100000000ULL;
>>> +/* PDB0 block size 12 covers one 8GB entry. */ static const u64
>>> +eight_gb = 0x200000000ULL;
>>>
>>>  bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)  { @@
>>> -60,7 +62,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device
>> *adev)
>>> {
>>>     int r;
>>>     struct amdgpu_bo_param bp;
>>> -   u64 vram_size = adev->gmc.xgmi.node_segment_size * adev-
>>> gmc.xgmi.num_physical_nodes;
>>> +   u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev-
>>> gmc.mc_vram_size :
>>> +           adev->gmc.xgmi.node_segment_size *
>>> +adev->gmc.xgmi.num_physical_nodes;
>>
>> Clear NAK from my side for such hacks.
>>
>> Please describe the requirements and proper integarte that into the
>> handling.
>>
>> Regards,
>> Christian.
>>
> 
> On AMDGPU_VIRT_VRAM_IS_SPM case, the hypervisor reports each VF's VRAM address in the ACPI SRAT table. So, driver can use the address directly, there is no need to use xgmi.node_segment_size to calculate the VF's VRAM starting address(the xGMI node segment size is not valid for the VF).

Yeah but that looks completely stitched together without any knowledge about what variable is used for what.

Two possibilities here, either write something reasonable or give us the requirements and my is implementing this.

This code quality you came up with here is absolutely horrible.

Regards,
Christian.

> 
> Thanks,
> Zhigang
> 
>>>     uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size
>> + 21;
>>>     uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) - 1) >>
>>> pde0_page_shift;
>>>
>>> @@ -266,16 +269,21 @@ void amdgpu_gmc_sysvm_location(struct
>> amdgpu_device *adev, struct amdgpu_gmc *mc
>>>     u64 hive_vram_end = mc->xgmi.node_segment_size * mc-
>>> xgmi.num_physical_nodes - 1;
>>>     mc->vram_start = mc->xgmi.node_segment_size * mc-
>>> xgmi.physical_node_id;
>>>     mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size -
>> 1;
>>> -   /* node_segment_size may not 4GB aligned on SRIOV, align up is
>> needed. */
>>> -   mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>>> +   /* Round up to a PDB0 entry so GART starts on the page-table PDE. */
>>> +   mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);
>>>     mc->gart_end = mc->gart_start + mc->gart_size - 1;
>>> -   if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>>> +   if (amdgpu_virt_xgmi_migrate_enabled(adev) ||
>>> +       amdgpu_virt_vram_is_spm(adev)) {
>>>             /* set mc->vram_start to 0 to switch the returned GPU address
>> of
>>>              * amdgpu_bo_create_reserved() from FB aperture to GART
>> aperture.
>>>              */
>>>             mc->vram_start = 0;
>>>             mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
>>>             mc->visible_vram_size = min(mc->visible_vram_size,
>>> mc->real_vram_size);
>>> +           if (amdgpu_virt_vram_is_spm(adev)) {
>>> +                   mc->gart_start = ALIGN(mc->vram_end + 1, eight_gb);
>>> +                   mc->gart_end = mc->gart_start + mc->gart_size - 1;
>>> +           }
>>>     } else {
>>>             mc->fb_start = hive_vram_start;
>>>             mc->fb_end = hive_vram_end;
>>> @@ -1274,7 +1282,8 @@ void amdgpu_gmc_init_pdb0(struct
>> amdgpu_device *adev)
>>>     uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore
>> NC/RW?
>>>     /* Each PDE0 (used as PTE) covers
>> (2^vmid0_page_table_block_size)*2M
>>>      */
>>> -   u64 vram_size = adev->gmc.xgmi.node_segment_size * adev-
>>> gmc.xgmi.num_physical_nodes;
>>> +   u64 vram_size = amdgpu_virt_vram_is_spm(adev) ? adev-
>>> gmc.mc_vram_size :
>>> +           adev->gmc.xgmi.node_segment_size *
>>> +adev->gmc.xgmi.num_physical_nodes;
>>>     u64 pde0_page_size = (1ULL<<adev-
>>> gmc.vmid0_page_table_block_size)<<21;
>>>     u64 vram_addr, vram_end;
>>>     u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>> @@
>>> -1292,7 +1301,8 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device
>> *adev)
>>>     flags |= AMDGPU_PDE_PTE_FLAG(adev);
>>>
>>>     vram_addr = adev->vm_manager.vram_base_offset;
>>> -   if (!amdgpu_virt_xgmi_migrate_enabled(adev))
>>> +   if (!amdgpu_virt_xgmi_migrate_enabled(adev) &&
>>> +       !amdgpu_virt_vram_is_spm(adev))
>>>             vram_addr -= adev->gmc.xgmi.physical_node_id * adev-
>>> gmc.xgmi.node_segment_size;
>>>     vram_end = vram_addr + vram_size;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> index cd276a138e10..e37c84f10709 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
>>> @@ -734,8 +734,10 @@ static void gmc_v12_0_vram_gtt_location(struct
>> amdgpu_device *adev,
>>>             adev->vm_manager.vram_base_offset = adev->mmhub.funcs-
>>> get_mc_fb_offset(adev);
>>>     }
>>>
>>> -   adev->vm_manager.vram_base_offset +=
>>> -           adev->gmc.xgmi.physical_node_id * adev-
>>> gmc.xgmi.node_segment_size;
>>> +   if (!amdgpu_virt_vram_is_spm(adev))
>>> +           adev->vm_manager.vram_base_offset +=
>>> +                   adev->gmc.xgmi.physical_node_id *
>>> +                   adev->gmc.xgmi.node_segment_size;
>>>  }
>>>
>>>  /**
> 

