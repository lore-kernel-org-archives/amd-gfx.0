Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21129C5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9E2510E7E6;
	Mon, 17 Aug 2026 14:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U/iC/x/v";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011017.outbound.protection.outlook.com
 [40.93.194.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DA510E7E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZljghFGq09i2++WIaONcMsYK8RnUT+Wkh+DwueUuOYgNKI9Qkn9QF8sbMZXmt+Uj4oBOhXkCi4PtSA0rtH7uQSPU/HLyHeO7mRkW2oTuVDx6FM/iSFGacOrK7xn4oLgQ6AFDuRI637bPUo4qYXq7hjnU3LqkFL7E3BsZb1uILIpFu55e3WRLKpYbqboRpY0wrP+sPhlJDaSVPcHSfKNQpZR+fz9FA+n20BY8pSdQAFDO6aysnB3WQQBtlwLLmTVssl+c/IaRpcXCroFvwhRWu4RZ6BTg66PhIprOdMHE0wCedmjULtkjBq6F8/TSRAly0WFWJe4IsTaLl1GtnoZkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcfqxDj51MPvn1GS+ie+EHFgnL9LzijWj3PL/VcRz2M=;
 b=ufegq5x6qQMkkrlGn37DMW+2PuuzrCkun1RKggEJsV8WbHJW5AWqCwJojmCDFnmySqHSnmruoUyrM6SpNLuGW/HywYqJJnbGDYI12DBKkioYb0JxuXOJi2BFQgrMOuhwkI5p4IBUFAzinaTbM4r1f50KmscSaVdH3X4l3xeOyj44rOjesgtS4wqAQRWJU2nHaEd4RgzOiBZ/oNHmSTYuKYBvCyl7xrHRpLrIJcQTmc1D4TfzATKx3oQyyHz0sUdemZw2j1/Ib9NsK6jKr0sxfbf9SyWWibEgHIKYy+Mq9sPY6BvPG1lI90gFbxjuhGnVY5HxMv0Wn9XnS47FeG6JLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcfqxDj51MPvn1GS+ie+EHFgnL9LzijWj3PL/VcRz2M=;
 b=U/iC/x/v/0+YbA8X6OOgT+oKocSN7rBESP1qS9Td8llUPkY2qKfKY1MS5OORaXGpVLvGi4Ib63Or0jsZOp3aM+pSz6YpQZTft97QS2blzd82JHljt6QMFyv5EbIJ8sxLs69xzfkEmMSgnmPZplY3d2/sLkHbvwmODLEegzrLaeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 14:25:48 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:25:48 +0000
Message-ID: <d3de23c7-8a10-45ff-900b-ad02c2a7218a@amd.com>
Date: Mon, 17 Aug 2026 19:55:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue
 unmap
To: Alex Deucher <alexdeucher@gmail.com>, "Hosur, Priya" <Priya.Hosur@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Vishwakarma, Pratik" <Pratik.Vishwakarma@amd.com>,
 "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20260814161841.5906-1-Priya.Hosur@amd.com>
 <20260814161841.5906-3-Priya.Hosur@amd.com>
 <SA0PR12MB7091D3AE34006DC6797EECD197DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <DS5PPF78FC67EBA848622BC6037F917872992DA2@DS5PPF78FC67EBA.namprd12.prod.outlook.com>
 <SA0PR12MB7091F549BC02FFD7312367AF97DA2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <IA0PR12MB8895E3ADC3692524015EDC2AF3D82@IA0PR12MB8895.namprd12.prod.outlook.com>
 <CADnq5_Pj0gOHMupA+X9x6F-71TQJDeDiJQ6kdFgrLdzLh-z70Q@mail.gmail.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_Pj0gOHMupA+X9x6F-71TQJDeDiJQ6kdFgrLdzLh-z70Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::9) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|IA1PR12MB8517:EE_
X-MS-Office365-Filtering-Correlation-Id: c56d753e-f461-41c0-52ef-08defc6b6ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hQrqBCJLtsTudD2M4Phmnmq3pyoLextpM3+znCGBAkOetLHYA/kWRl0w0Ts8w1w8o/dlHB2y+f93N1/SyPg4WzL2EXpONcZryN45i0Gvhcd9lNafpg2WZvyNv05wcjDINhbwkelSo/gdxetamys8N2jzIuIouLCrnYSGYO5MDTfJ6FZvASL76kVd4uy/CblLDNybG1q/j3rrt8wik438995vMvF3IsFfQmT3iC+G120SawRvzUuCBLqNpcUmM8uli4cO5kAsU8YWXUAM7o7Pq1qTiKL3meUibji+KcLIQH8h3Ctq/jQW+cooAeB4s+gMzonjQz37hFa6ERTpe85msxr8SqUq6MJIcSFaKi/FtTPS75LtggKcZ2KVxyH23VLtUjfByF36mxsQRQocO438y/ji6Rvd4b4No+m3VHWF1NV3W4gs8dHgKNLeQtH6xniSkmrcrNlbK6VwZowYUYECDB24y9LlqgkhLIUsrfNyJ5R9RKKN/rSwhruJek389UtasryarHvyV0Qd1nCJZbl8/Yj7cuC3NPtXBAgL98Em16kEb907eZdk+dc8GHFlOsCIXokhoGr2DsSPLr9rIiddDgEL3ywMo2ZNTF4tn5OuqlIcHnE1OpTrlYgtNiwPOiYHf0t7crLPGTnHthOi4YQduIiTchwJjo6hEb9fAEDnIAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENhZU5NQkFvazFON05DTXpnMy9SYndnNERFTE5PQzlXMVFoSWxsYTRQb3Ri?=
 =?utf-8?B?ZUlmNktpdWdCemVXeWpydG1Wd1BoWjZOTlROR2RDR3VmK2x0My9WSUxEK0pD?=
 =?utf-8?B?MDhZZnV3MWNhai9ieG1ES3haWGRkZjVvSW1ob2t2SDVxY20yRDFFWTVIUVlw?=
 =?utf-8?B?cWdNRGl3MzFFcktGY3liNHNrN2U2QXljN3UzeUF0NE1xcHFWSm1zUEVoQnRu?=
 =?utf-8?B?Z2RFUzRFdks0NmtGUEVBSnVxbjBFY24rT2l1bU5RU1FKRStyWEl4c2RsSStr?=
 =?utf-8?B?MC9yT2ZXQVNlNW80UkRreUNCVmFMdGgrV2NzTFJzNmw4OEhVWEREd1pBbHRM?=
 =?utf-8?B?bndsY3dobldBeWlzZGpRVHVJK3VTaHNGd01MQjNQczg5bUV0WEIrNjN5ZkFC?=
 =?utf-8?B?RmcrclFmaEhmQm53aHRkZklDa0FyQk1QZE5hZ0RFVjNxT05hRnF2eEN2cVdE?=
 =?utf-8?B?R3JsT2NQNGtUN1A5RFhsNXVmcXdQL3MxZHJtTzNNMGdpakJHblVwWG1hYzRC?=
 =?utf-8?B?TzZtME1QSVdab0lYTmM1OUpUb3I4RHM2L1dWVWpuOU0zdm1sbHdWeGdZNktm?=
 =?utf-8?B?WkFETnduRmZkd0ppeWt5VWNEMW41R0Vua0svMkRvbmZ5RVZtbmxDcUNTVlZW?=
 =?utf-8?B?ZStUSmlNbVJLM2ZmeUZlRGF4Tzc4cnd2aFBwNTlnNlJRZStnZ0phYjdTVkxD?=
 =?utf-8?B?bDZmN3NGd1plYS90d3gxMWtydlFjN1owVXdjQkF5dGNVM2p5bXg0RHFvZVBa?=
 =?utf-8?B?NDNiY1pyWU81Z2Y1aVJ0Y1FFZS93SU8velZzdlA4WHFXZHVTd2k0OWI0RGlp?=
 =?utf-8?B?Y1pzSVRYYzdORWhFaWZYSUcwajIrNFc3NzNyQVp5UDREZ2pPanJyRmQ2ZlVE?=
 =?utf-8?B?TWhSbUkvb2xYYlVKaGRQVEk3ZlpYbUczNW1Ca3ZOZE11d0t0WUx3bTBYa2g1?=
 =?utf-8?B?Ukt2anYySFliM0RXY2Y0UmtMdDZRVHhRZTUzR1h4eGZIRTBqSEsrU3VWL3JK?=
 =?utf-8?B?TVdSMzNaTmk5a1dad1llc0RsWmkrSkdHcEx6Q1NKVTFRQUtteGhFN2dlUStB?=
 =?utf-8?B?enN5MDBvbENMY21MeC84eXBPSHFHT0VVQVFsa3pSNWxIaElFQVdsZ2lrQktp?=
 =?utf-8?B?U1hVQnpiYWhDelMyaTl3Y1VWYlQvbytQVWpQckFsSDY2dXJWY2c3UG1nb1RH?=
 =?utf-8?B?em9JanpmTzZaR3Yzb3NISXB1bWFISS8vbUpBMllMeGhYWHNGTkg3bGxuamtF?=
 =?utf-8?B?Mis0UjdtSWZOSVIrOGMvMDkrSlgycVRQTVZpTWJKT0ZKc0VmTm1LWFdVdEsw?=
 =?utf-8?B?dnlVQTBNd3QzVVF4Tll4amJkNDhsZkN1eVdya2ZMZTBZRUlPYlFVRWd5dkFK?=
 =?utf-8?B?SWY1NFoyM1FNOS8wclhnZ0xsbkc2U3VqYW43Sk5MVTZGVzR4b25wcTBqSTB1?=
 =?utf-8?B?V1EzdXQrTUJ0cUVuRVFMM3owN2wzaEIrdzYvRkJYMy9nRENnYzFacXF2MGJK?=
 =?utf-8?B?WlhQYzAxQklrYWtSR3hwbzRyTkR1Ui9MbE5OdjdtMmR3dmwxRDMvWnBkWm40?=
 =?utf-8?B?Q3Voa1piWXRIUDR2OVZVc2xtR0xNWVczaUNEZTJNdWVhU3lieEN1TmZ3c240?=
 =?utf-8?B?SStsVFBBUmdSUDZENmVxMXZKWTMwOE11MlhURG16bFYzck1nOEpQaHBpYUNR?=
 =?utf-8?B?QlJaQWwzR0JmemdYRTRhYWQ2WXZ6U00xQUFlNU1DaWFQWUVjd3d4MkMzdHhK?=
 =?utf-8?B?a2dxRkk1VFNIK3VKa29BbWRTblR2c01lRnE2MCtSOWNBSHU0dW9lNnRWQmVU?=
 =?utf-8?B?cTRxcy9PQmdva1J3Y1Z2bENkOW5uTjJuVFNES2xsUmY3UllLOUVkczF4aklR?=
 =?utf-8?B?d0s2K3FycE1WQTBhZGRUL2JCcHMycXBwbnBCTkZIdnFRTGJSS0pZckI5cmNP?=
 =?utf-8?B?VUhlT1BON2lhS0w5ZGlDVFEzSldUR2lTcDFGTVZXY2lBQ3MvOVNBUXJ3eUZU?=
 =?utf-8?B?aXNLV1k4VGE4dGczTkQxS1JyczlVcGRBK0Q4MHltbjlhWHhONDdLK212S04x?=
 =?utf-8?B?MGJGZzNEQWtKN2lRWno1aml1V3VZU29yVERlcXIzMVQ5cEJOQkFtUHpIZFFR?=
 =?utf-8?B?YmxDWDl5dkRoMnRQeGYrcXBMdmtZR20zQmhkeGFxVjBXM1crRWNaVlZ1ZVo5?=
 =?utf-8?B?Y3dxclFnakZsSGUxcXNIb2VONzVnYUN4NG4yUG1TZEQ1WGduQy9PRHhKRjZm?=
 =?utf-8?B?b2hXaG44NjVJVE9aUmszMnNPU1FLU2dsRHdSTTZLOGRVK3ZZSlZkTEZVWGRl?=
 =?utf-8?B?Mk1Vd3FBeFFoajZjWHlPMVA3enpEeUtGa1RGNUlLT1V1S3BydUZhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56d753e-f461-41c0-52ef-08defc6b6ea9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 14:25:48.5322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CC9B65KXVPrjrzD1SRwkzSFDZ0zg4Oc6HEUdM30aeCVjhJVH6XDdAbPNt8W/RM3pDYa8d61Ej00fIoABoyU61g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
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


On 17-08-2026 07:49 pm, Alex Deucher wrote:
> On Sun, Aug 16, 2026 at 1:25 PM Hosur, Priya <Priya.Hosur@amd.com> wrote:
>> AMD General
>>
>>
>> Hi Felix, Lijo,
>>
>>
>>
>> Thanks for the clarification. I understand now - TLB flush is only needed after batch queue unmapping (eviction/suspension), not after each individual queue unmap.
>>
>>
>>
>> Alex - based on Felix's feedback, the userq unmap path doesn't need the same fix since it's per-queue unmap rather than batch unmap.
>>
> I think it's still needed when we evict all KGD userqs for a process
> (technically per GPU VM instance).  E.g., the eviction fence case.

@priya, i am looking into this in the KGD userqueues. It's ok if you 
drop that as it need some more insight to understand how well it fits 
the KGD queues..

Regards
Sunil Khatri

>
> Alex
>
>>
>> I'll drop patch 2/2 (userq fix) and send v4 with only the KFD fix.
>>
>>
>>
>> Thanks and Regards,
>> Priya Hosur
>>
>>
>>
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, August 14, 2026 10:56 PM
>> To: Kuehling, Felix <Felix.Kuehling@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
>> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unmap
>>
>>
>>
>> AMD General
>>
>>
>>
>> Thanks for the details. Didn't realise that it is one by one removal. I thought it was something like unmap-all for a PAS id.
>>
>>
>>
>> Thanks,
>>
>> Lijo
>>
>> ________________________________
>>
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, 14 August 2026 22:17:50
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>
>> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unmap
>>
>>
>>
>> AMD General
>>
>>
>>
>> We don't need to flush TLBs after every queue unmap. We only need to do it if there is an expectation that memory access is quiesced after unmapping. In the case of KFD, we are doing it when we're unmapping all queues, e.g. in MMU notifiers, evictions or when the debugger needs to stop the queues and look at memory contents. We only need one TLB flush after unmapping many queues.
>>
>>
>>
>> Therefore, MES should flush TLBs after every queue unmap. OTOH, MES must flush TLBs by itself when it switches VMIDs. This is not under driver control.
>>
>>
>>
>> I don't know what the requirements are for quiescing memory access after unmapping amdgpu user mode queues.
>>
>>
>>
>> Regards,
>>
>>    Felix
>>
>> ________________________________
>>
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, August 14, 2026 12:29
>> To: Hosur, Priya <Priya.Hosur@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>
>> Subject: Re: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unmap
>>
>>
>>
>> AMD General
>>
>>
>>
>> Hi,
>>
>>
>>
>> Shouldn't this be a FW fix?
>>
>>
>>
>> Thanks,
>>
>> Lijo
>>
>> ________________________________
>>
>> From: Priya Hosur <Priya.Hosur@amd.com>
>> Sent: Friday, 14 August 2026 21:48:40
>> To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Cc: Vishwakarma, Pratik <Pratik.Vishwakarma@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran.Gopalakrishnan@amd.com>; Hosur, Priya <Priya.Hosur@amd.com>
>> Subject: [PATCH v3 2/2] drm/amdgpu: Add TLB flush after MES user queue unmap
>>
>>
>>
>> Similar to the KFD fix, MES does not perform heavy-weight TLB
>> invalidation after unmapping user queues. Add
>> amdgpu_gmc_flush_gpu_tlb_pasid() after MES unmap succeeds in
>> amdgpu_userq_unmap_helper() to ensure in-flight memory accesses
>> complete before memory is freed or migrated.
>>
>> Change-Id: I94fe2c84547723b6b73816ce8d727a54bd773a6a
>> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 6d3ed55e9ab4..9fcf15d69b7b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -375,6 +375,12 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>>                   } else {
>>                           trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>>                           queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>> +                       /*
>> +                        * Heavy-weight TLB flush after MES unmaps queue to ensure
>> +                        * in-flight memory accesses complete before memory is freed/migrated.
>> +                        * MES does not do this automatically unlike HWS.
>> +                        */
>> +                       amdgpu_gmc_flush_gpu_tlb_pasid(adev, queue->vm->pasid, 2, true, 0);
>>                   }
>>           }
>>
>> --
>> 2.43.0
