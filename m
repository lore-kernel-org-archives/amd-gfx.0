Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8E6C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 07:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59A4210F45E;
	Thu,  9 Jul 2026 07:55:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZ/zJP8q";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013064.outbound.protection.outlook.com
 [40.93.196.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A4210F45E
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 07:55:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKM2iT3qPDjoJ80ShBOWno284OQMcRgZqi7WRPBxTwVmesDUIxtnL4WKw9XT+mbMqtgwViaO39wDaIanu2Y5lXiuIm5sOiacQAPlQGuTw1+hrc5vUJiEfnlrl6HwlAoT831S/W9qK+VSFMhugo+hSLhF3Lx8Kcy1LI+db3d+T4zc6txCXK7SMpfKcrcgvLwDI4BEulEQZ2Ee/roPteZIhg58rgpW2NIvtdBc7cAxYiUozJbKyfRm4nPJeSJyPcZpo4OeiHNexSvTTV8xazX+nxI/4nBDp7mFx1cmo/SvfRHnu6KVaGDPSzYWAJ/i93cz8CGVfYVwbS1JUBGnk6zbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvATo4zXP34kFTdf0lmdUwx4UtoUJKjk3tNnyaDpDBY=;
 b=WfUvL77qHZAak+13G++hj6Jwelsx8jTda5Kj0ZTht1auoG/LXeohA1Q4VkeEhTX2kEr71lYaIckOQNt/GLrHua/DpFHR4Mf2CG01TJPVhFjl/l1Knro8xhQSkSb/OXHCWEfbKvcDKm+NkgMg0yZUWUJL7sveGVgyOeYBlp4WqarW96qBISXrDswJRWXkhD6+j5Qnb9/mkEPCFZkA7wZsVDkwFR5tHnBdKlGJLfmT+lgE4KpL9jIw3f8+m9Zd4mkjx3par6EMtJripG13kSrUmcUqzjiAtq3kq2rxk52/9WT6cCSPZc38hezlFzhnb0LHkOIl+dlzBtLNYJwwZ93YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvATo4zXP34kFTdf0lmdUwx4UtoUJKjk3tNnyaDpDBY=;
 b=hZ/zJP8qRJlRbJT3yeKn+NGKgoW2MoWCzxDkZGJ2CggTUzqpIiU/HDy+ZOdOUEBXn5jBA+v6OG8i5pe48KIecCmF+UoVp0sawHPbG1nvvekUU0wap2F01k+G4rozjAAiY0Pp85SXPgCI5VqvJnX0k7oHkoB2Xz5lOnaxrwSv3tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Thu, 9 Jul
 2026 07:55:44 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:55:43 +0000
Message-ID: <2d96166c-b192-41be-83d1-19eb64d7306f@amd.com>
Date: Thu, 9 Jul 2026 13:25:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
 <de530731-21de-4470-9316-dccb767c87ac@amd.com>
 <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
 <c963d1df-e1a3-4fa6-8514-3c4ab204088f@amd.com>
 <DS7PR12MB576870FE38FFB13002872F529BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB576870FE38FFB13002872F529BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::9) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c76acb-6694-47e3-65bb-08dedd8f79de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|3023799007|6133799003|56012099006|5023799004|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: U9ALsj+qR03N7Kjy3uY4a7jCJYQ/pu508Z9PLyf5dRbe4MUl5VeUMc8XRn+NtjVwbGMDaXBO+WvlMAOiyMKg/22WcDt/HLXwO79G8BRqrmj+Nof1/1TCZkjdTIUS073aEU43TXnDzD7L7CbgQK6Qs8isCIiH5CB1n43O2GvxfLaC64BD9yl8CK0xifb53iY78JBc5EBaKD4iEjZg3Ht9Bj1+7enX2rzH/ujeNylPhCeX31Awu0VHaCWdTf49WzjQbYXTxKNa9y6/FUvhnvPCR7dXfZKdWA3g9d8aHAIgQVY8aznnq3k2LGbVZ3PpAE88JDa87NV2ldA+/AFSyupAWSZ+tVI22mGDoA7Qj/4cMvUC8hB6gpKYnS34m1UawsxoOC7M7GBCP98kBnpQmxNP40TftQruQxxi2bSVg/aOi+ppgzH/TW7Rie/Uw40b9KI9GxDQN1dUQwcwp9hxzwJgnMJPR2lyj4g5f+YHZD2HuRvrXlDX8yBadEDGk+O0WwHLPtkpaNFumDOxSYNVKl/u7ig0vneGLDrScyvLgm4O6pioOBrrdjYZTtrncO0ucbMvuceu/CZw1oI6MSZoRRqZO/hqEebZluWgknTTc/I/V5CMMSJVAR7z+dELrEPmvBm8EMF1omyHYVH4xHmbznbIHxswhBFnlSpOotl2Z7CSFvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(5023799004)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFsWXBXR2dBYVpVa1JLT25sdlpRbC80OFVLMzU0SzZveHJSZVg0ZTZxNDF1?=
 =?utf-8?B?eGg0YkovRi9QVTFvUmNBUTdVTEc1VWVSQWU1cWtibkdhWVNScXpIMXMrdVBw?=
 =?utf-8?B?Z09Xd1FCN29pZS9nUkJrMG4wenRIL2YzNWxXeG1KMVNITSt6eGJoZ2VIdldP?=
 =?utf-8?B?UHFJTlBFS1pZMTRCYm0vMC9ibnNFL1QrV2lwRnpxK3hudnczR1lGN1h6a3Q4?=
 =?utf-8?B?MWhaYkgwTlFRTEg3cktCbFdlNm1qdnQvUC9NZ24xcUZYR3JscXc2UDV0UW04?=
 =?utf-8?B?dzZBU3RRancvWkZvZzJEQXlFQzFaZ0lDK1BjMjBJeWw3blRuTFJqSENkSkNP?=
 =?utf-8?B?TlJtV2gyaHNJSUhWSWZBNzQ1M21VTDBLempJSHFyKzc3ZnovbStKaE5KaUxu?=
 =?utf-8?B?MTcyWmlCd0FYQmQwU3AvbVQ2TWpWQkNPdEJPWWljRGRBTTNzaXFuNDJLdml6?=
 =?utf-8?B?ZWhBZkp6VlRXVHoraEdicmZYUmgwNjRCNk00b2hadnRMRGp4RUhNajJXQlV0?=
 =?utf-8?B?bGt0dFk1aUlYOU45cFN2bFoyaW9rYkc0UWVHQVcvQVU5ZU1VbXVvMWZwNWxw?=
 =?utf-8?B?YTU2YmNFTmVpTW5XREVLaE91TksrWGp3MlVXRmdyMllORnpCMGF4MTZwLzkr?=
 =?utf-8?B?OGFnR2tINEFza2hiV2NGVnNWcGVyWWhnSjNsUXVneGJYM3Z4M0tIcjY5UGxJ?=
 =?utf-8?B?VHFSSnQvT09LMlpva2wwU0N1SHNKOHZnRG1IOWN5UWFLdXNTWVo2dmc5K0p2?=
 =?utf-8?B?RW02NkFMODM5cW9jZ2dDRkRyUWFOUDVYc0w1RFc1Y2ZPSUtrS1k3R0hEMmdw?=
 =?utf-8?B?Z1Q2aUptbXV5bE9rbVZWVTNZY2lkNHNoa2R4Ykl6blVPM0lRNDhpRTE2ODlq?=
 =?utf-8?B?SFVIR2FhbitXdnMwTGZUZjBLWHo4SHFTWmRtTlp5SzRnTmZ4SUNBbHdJb2Uv?=
 =?utf-8?B?NStYZ1J3Kys1cnd2dXRvSU1PL2xSUXBSNVNuSjNRN3lUK3QxK3FhaDZvem5u?=
 =?utf-8?B?SC9sdmYvcjQ3K2wxa3pQdFFFYXpYckdmd0Zvd1FlSE53KzFId2ZTRVJ3K1RS?=
 =?utf-8?B?NHNOOWdtMVdsK0xsNjZQdHpGb2REVFBXZDcwV3FRQkdkN0JUV3dXdGVxNmJ6?=
 =?utf-8?B?ZHAvUnhSbENGcWtJWU1tYnhEMzNqV3BneFVKS0ttUzR6UHVyaGpJTmc5cTV1?=
 =?utf-8?B?T2swRE9UWkZFdUpnVW1LVHNIQ3RUZ2ZpOUFldmIzK2RFckpiK0xuNlFzV3Bv?=
 =?utf-8?B?UlFhRHpNeithMEtlRHMwdWgxWW9DOEtBeWlxSCttdWdPY2MwYjNmbnFTM2xJ?=
 =?utf-8?B?TURtTzlWMXRVTy96ckszWTJCVkZuR25QQWlyUGNrRFVFWmZRa2dMSWlrWlZ5?=
 =?utf-8?B?cDhlWGloamZ0aTBOZFN0ejdjRHh0WjJDV2hHVDhLY0tsNk9DdlJqTXgxSTBJ?=
 =?utf-8?B?K2ROeXpiWGY4a3lrMkZnNm1wOGhFQU1rRlJSUW1BcG1RRGEzeEJFbjgwaysw?=
 =?utf-8?B?SEMzYmdQWFhReU84bmZnSTY1ZFFLU0FZci9YUytTY3VpVDFYcDJpRG84ckRS?=
 =?utf-8?B?TjZuaDZ2WFpnM0FUbE44TlI1ZWNaQXZ2cnk2bHo4UlVBTWhWY3B2SHcxSUxu?=
 =?utf-8?B?UGU1RjZMMzVUNHNuRW5zRjVoaWFHVUdzUTNtZDdyRXUrVGFpbDdpb0tDdlRT?=
 =?utf-8?B?Z1NINGV6R0s3bUc2b1FqdzdQbGQxVE5aVW8xWjR1eHI4VUY4YmtHVUFTTGRB?=
 =?utf-8?B?ZlRCdUdMcmhkR2g3clc2NlJqVlNaRWNub3EweHYxN1lyaDBqa3ZJNWYzRU5B?=
 =?utf-8?B?NXNJb2lib0NXSW1yM25kVVB0Vy9DaHpGdUFWd1N0eXVUME5EamVwQW1sdmRN?=
 =?utf-8?B?SzZua3pQNEJUa3hHdmNERkZjOFZNaU9vcWI5STcrTW1acWNhS1RLYi81Zzdi?=
 =?utf-8?B?WDRhN2s5czZraXVxM09WMm10VkNaeE1aREZnRTZKa0dPM0ZuVXd1OGNnQlhh?=
 =?utf-8?B?MXZBbGExQldyUzg1dVp1bzl1QzB0UkJDQ292c0R2c3NjZ3BCeTh3VkJpL2No?=
 =?utf-8?B?TFdvWXpZYXhNNUpKVE12Q1RKSHJNUVVLb09sRy9FSVlpTXl4aGk4Q1U1WjBR?=
 =?utf-8?B?Yk9iamtLeGZtY0tPMUVPanQzWmJSd29wL010a3ZlMDZmaklBMTZTRFRLS3dS?=
 =?utf-8?B?cEdwUWFZWU53MlFabE5HRGhNSzZaYWNqYXRYVFhzTjNKcVhXbGVJUUtIbHE3?=
 =?utf-8?B?L3dTSFpkSWNGVHV1V2pDZitwTFNJcTdRbW03ekYzV3p4YlFyc3g4NWxNR1V5?=
 =?utf-8?B?T2djNUNzVjRGMjV0WEZ3MlRKR24raWFMR2VxMWdERW5Mcjh2c25pQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c76acb-6694-47e3-65bb-08dedd8f79de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 07:55:43.6742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UG+6khHt/MG890cMwbu3MOrLkp1iG17TJ2iBBcEyKj2vUZ1/sS/PhlfOFVroVYFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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



On 08-Jul-26 6:12 PM, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Lijo.
> 
> " In this commit, the statement is different."
> " It says FB access is enabled if init_data request is sent."
> 
> Yes, VF FB access is enabled if init_data request is sent.
> 
> However, without full GPU access, the guest cannot access the MM_INDEX/MM_DATA registers.
> 
> With the legacy/existing read path, VF_FB_EN must be enabled so the host can dump early init data into the VF FB,
> and full GPU access is required so the guest can copy that data through the MM_INDEX/MM_DATA registers.
> 
> I submitted patch " [PATCH 1/2] drm/amdgpu: read FB through BAR0 when aperture is unavailable " ,
> With the new amdgpu_device_read_fb_via_bar0() path, the guest can read the VF FB without full GPU access
> 

Yes, I saw that one. One other question - does host driver guarantee 
that discovery data will always be copied to visible BAR aperture of VF? 
If not, it will still require mmindex/data regardless of FB access 
enablement.

Thanks,
Lijo

> 
> Thanks,
> Chong.
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, July 8, 2026 7:18 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> 
> 
> On 08-Jul-26 4:18 PM, Christian König wrote:
>> Hi Chong,
>>
>> On 7/8/26 12:25, Li, Chong(Alan) wrote:
>>> AMD General
>>>
>>> Hi, Christian.
>>>
>>> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
>>>
>>>
>>> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
>>>
>>> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
>>>
>>> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
>>> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.
>>
>> No, exactly that is not the case as far as I can see. See the commit I mentioned below.
>>
>> According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.
>>
> 
> It could also be because the legacy/existing way used mmindex/data, and that required full access including mmio register access.
> 
> In this commit, the statement is different.
> 
> "In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN and places early initialization data, such as IP discovery, VBIOS, and PF-VF exchange data, in the VF FB"
> 
> It says FB access is enabled if init_data request is sent.
> 
> Thanks
> Lijo
> 
>> So I absolutely clearly have to reject your patch here.
>>
>> As far as I can see this is a hack for ESXi and that is not going to fly.
>>
>> Regards,
>> Christian.
>>
>>>
>>>
>>>
>>>           static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>>>           {
>>>                   ...
>>>                   case CHIP_VEGA20:
>>>                   case CHIP_ARCTURUS:
>>>                   case CHIP_ALDEBARAN:
>>>                           soc15_set_virt_ops(adev);
>>>                           break;
>>>                   case CHIP_NAVI10:
>>>                   case CHIP_NAVI12:
>>>                   case CHIP_SIENNA_CICHLID:
>>>                   case CHIP_IP_DISCOVERY:
>>>                           nv_set_virt_ops(adev);
>>>                           /* try send GPU_INIT_DATA request to host */
>>>                           amdgpu_virt_request_init_data(adev);
>>>                           break;
>>>                   ...
>>>           }
>>>
>>> Thanks,
>>> Chong.
>>>
>>> -----Original Message-----
>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>> Sent: Wednesday, July 8, 2026 6:24 PM
>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan)
>>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;
>>> Cursor <cursoragent@cursor.com>
>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>> progress in sriov mode
>>>
>>> On 7/8/26 12:03, Lazar, Lijo wrote:
>>>>
>>>>
>>>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>>>> AMD General
>>>>>>
>>>>>> Hi, Christian.
>>>>>>
>>>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>>>
>>>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>>>
>>>>>> Distinguishing the host platform was a mistake, and I have
>>>>>> explained the situation at the end of the patch email.
>>>>>>
>>>>>> I have pasted the content below:
>>>>>>
>>>>>>            Hi, Christian and Lijo.
>>>>>>
>>>>>>            Sorry, I made a mistake.
>>>>>>            Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>>>
>>>>>>            I borrowed an ESXi server and tested this patch there.
>>>>>>            The amdgpu driver works normally.
>>>>>>
>>>>>>            I rewrote the background. Is anything still unclear?
>>>>>
>>>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>>>
>>>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>>>
>>>>
>>>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
>>>
>>> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
>>>
>>> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
>>> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>> Date:   Tue Jun 23 13:43:49 2020 +0800
>>>
>>>       drm/amdgpu: invoke req full access early enough
>>>
>>>       From SIENNA_CICHLID, HW introduce a new protection
>>>       feature which can control the FB, doorbell and MMIO
>>>       write access for VF, so guest driver should request
>>>       full access before ip discovery, or we couldn't access
>>>       ip discovery data in FB.
>>>
>>>       Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>       Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Chong.
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>>>>>> Cursor <cursoragent@cursor.com>
>>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>>> progress in sriov mode
>>>>>>
>>>>>> On 7/8/26 10:25, chong li wrote:
>>>>>>> v2:
>>>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>>>
>>>>>>> v1:
>>>>>>> Move the initialization of non-GPU resources out of the full GPU
>>>>>>> access region during AMDGPU device initialization.
>>>>>>>
>>>>>>> Background:
>>>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The
>>>>>>> guest should then be able to read this data before requesting full GPU access.
>>>>>>>
>>>>>>> Before this patch, the VF still requested full GPU access in
>>>>>>> amdgpu_device_ip_early_init(). At that point TTM is not
>>>>>>> initialized yet, so the normal VRAM aperture mapping is
>>>>>>> unavailable and the guest falls back to MM_INDEX/MM_DATA register
>>>>>>> access. That register path requires full GPU access.
>>>>>>>
>>>>>>> Use the BAR0 framebuffer read path,
>>>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the full
>>>>>>> GPU access request until after the early init data has been copied.
>>>>>>
>>>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>>>
>>>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>>>
>>>>>> Either this works on all hypervisors or I have to reject the change.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>>> +++++++++++++++++----
>>>>>>>     drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>>>     2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -38,6 +38,10 @@
>>>>>>>     #include <linux/apple-gmux.h>
>>>>>>>     #include <linux/nospec.h>
>>>>>>>
>>>>>>> +#ifdef CONFIG_X86
>>>>>>> +#include <asm/hypervisor.h>
>>>>>>> +#endif
>>>>>>> +
>>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>>     #include <drm/drm_client_event.h>
>>>>>>>     #include <drm/drm_crtc_helper.h> @@ -1987,16 +1991,19 @@
>>>>>>> static int amdgpu_device_ip_early_init(struct
>>>>>>> amdgpu_device *adev)  {
>>>>>>>          struct amdgpu_ip_block *ip_block;
>>>>>>>          struct pci_dev *parent;
>>>>>>> -     bool total, skip_bios;
>>>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>>>          uint32_t bios_flags;
>>>>>>>          int i, r;
>>>>>>>
>>>>>>>          amdgpu_device_enable_virtual_display(adev);
>>>>>>>
>>>>>>>          if (amdgpu_sriov_vf(adev)) {
>>>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>> -             if (r)
>>>>>>> -                     return r;
>>>>>>> +             early_full_gpu_access =
>>>>>>> +(adev->virt.req_init_data_ver == 0);
>>>>>>> +             if (early_full_gpu_access) {
>>>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>> +                     if (r)
>>>>>>> +                             return r;
>>>>>>> +             }
>>>>>>>
>>>>>>>                  r = amdgpu_virt_init_critical_region(adev);
>>>>>>>                  if (r)
>>>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>>>          if (!total)
>>>>>>>                  return -ENODEV;
>>>>>>>
>>>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>> +             if (r)
>>>>>>> +                     return r;
>>>>>>> +     }
>>>>>>> +
>>>>>>>          if (adev->gmc.xgmi.supported)
>>>>>>>                  amdgpu_xgmi_early_init(adev);
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>> @@ -185,8 +185,8 @@ static int
>>>>>>> xgpu_ai_send_access_requests(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>          } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>>>                  /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>>>                  r = xgpu_ai_poll_msg(adev,
>>>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>>>> -             /* version set to 0 since dummy */
>>>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>>>>          }
>>>>>>>
>>>>>>>          return 0;
>>>>>>
>>>>>
>>>>
>>>
>>
> 

