Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBCC44501
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 08:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB4B8905A;
	Fri, 10 Jul 2026 08:35:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XsGtY4yU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013013.outbound.protection.outlook.com
 [40.93.196.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF35C8905A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 08:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gay34Hbfs1Hl4R+v48/3EfGYiJym8AzdcaV5EYBsbCYnjc/dJP7KPUvkJox7sQV7eGx9vrxK+LOOui9RnUiJki4F2UaMOToObxg9AjLp6jOAFCEJaLvwi6uLmzBP9rAuI2ybyGkXc0HvZJIItiuPsJ2YzfzOOyD2e4H4nut46Wgg4qkUAVuDbX0jMxlI0lnutcAJdu1aeiZ+Y632DT9UBhNqJFBpU4cn5hzTofubcOMbB2eo4r3nTohIUbE7tnVEwHq8RfLpkZV3wLV90ra5tkND0P6AlP7nN9vdYKIX95PLfMi0eqHYjiK980VAXSjFDbLoTqWvT8zvzfXJzRwlcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTIx1nnpsJjTKZodyBxd8NT+FVhwfwPuGoX3S0aEaJA=;
 b=YtxyZKW5meXhAjxyfOIgFrfr3Cljm8r1ZJYodozx+zdaihoXnEN9xS9VZIvp2gOw+YtW4IBL7GHho6N5iMrHHmfRJ8vk52fxxUSalC9Cy3GznKSMMsPoKaYzgmpXXylpnDYxUPF5+FGPznB5bYqDAkttTvI2+VavoOJ1ojkOUoGh5bl4CGo23a03nte0esAalzedbmZPE9u52TYnK2QLN2C0+PIUGqyeX5P/6HXSrPLWAU4hlU48iJ8u9rEO3OT9FJUggZlwKSbm5HYLHR3o5RnrBDorG8/b0IpAdPC81N/63hT4caG1OkrgTCKPu0Teq9MLbG1xNi9nubO21sLrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTIx1nnpsJjTKZodyBxd8NT+FVhwfwPuGoX3S0aEaJA=;
 b=XsGtY4yU2Ttxmgg6Geze2IW6LFO8BaQzgh281I9RXQLDHlykW3ZOkM/FJgAPCdjLuUzOemEOYHjWFnjmrmnE4EQAjPZ0B7LceuY82RX11Fa/NN5FeLCYIci4DCBkAPdM1guaWal9KR4NYmM1EkXlHiekJr/blL+aerxKVK8hqTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:35:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Fri, 10 Jul 2026
 08:35:33 +0000
Message-ID: <a1777601-78b3-483c-b00e-e7be3f8baafb@amd.com>
Date: Fri, 10 Jul 2026 10:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
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
 <2d96166c-b192-41be-83d1-19eb64d7306f@amd.com>
 <DS7PR12MB57684EB76694DC4EB12791A09BFE2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <42ed9967-7eb3-41c6-9f7a-c43b93833589@amd.com>
 <DS7PR12MB57687E3E3FD2A16CE2AEDD089BFD2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <DS7PR12MB576883F6E54CFFE73818AD4D9BFD2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB576883F6E54CFFE73818AD4D9BFD2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4770a6-f24d-4f3c-8d47-08dede5e353e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|3023799007|11063799006|56012099006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dxBOto7f8lyKsecFXQJQOpCZ9Fk1XtuKLH8jefcznOW6GUpIZEktu1nSu+dHnz+XS8Nln2QWEaMAdCbYHfzkhvWdBbLUYYMgswvxRLv9YwIAQFglWtPp6kU647Z8dX2MKsPxfk76oJ8djkju62XphByiN7NLlm+T9nwp7lWEKPBYNk6vJGNZpuoyoVjfKDOV+nzenz9yDWx9RUT/4GPRPgbcbgXA417bngXDhYym2et4aPHAQbBa3DY+RXZuAlVep33frVFujcJkrkka6boQTFNnOHF49xDHfZzmzKlal3vNpdXnijybfRzdHOWuno0a9vrnIgKlkOHUCaiwjjXPHjHKXhn1DO/s1l/5ouAqMXjkQXfXkuQ9fELQMWcT/9icqGKJHo6n4CeJpdCEwGMCPB9shY28Y75iGCap3OCgejWxvOXmbW7bEBHu3SxkO4WuNuDiNqJxhdiYFnIopTKM5KUF8WWes81KOZpWh3wtOflbbhp7KARPMsNwl6pgvUraIydOsBNRmiCSiJ1Rg8mq63UWTKwfmSaETjwTx0m/jj003P3rssuEBktYPW/awTwoW8bLXm/01o4YmKqIFN1f/T1NW+DSyGywDTx4xinITyQn5CVlF2akqXi4I4RJgd+vV2Hxwk02XG5hBJzX7rJ3itZlcNdCP/DRJrGErlPC4h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(11063799006)(56012099006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNGaElJOHVzNXJTMDN0QmZRNHc5YU55NlVReUJzTFNCVlVOUmEvTEZTU2Fp?=
 =?utf-8?B?UHVJT0xxd0hDQkY2VmJGM1lOMlV5a2JkbzVCT2VDU2RrSGhhRFMrYkJkQ25z?=
 =?utf-8?B?Wi9na0hVM3hiSnBkY0syMHA5QVBmQUlhZGl2OUhBc0J3azV2VVJsMEVudXdS?=
 =?utf-8?B?dWo5VStyYUl6c1NtRGZ4SDNsRnl6Vk5rY0l6SEp2Smd5TE9HVGY3U041Qzh3?=
 =?utf-8?B?RVB3SzB6dENTTVMzRmZSOXVBK1krdW5DMkpwRE5qWm4rK0ZoWVpONTBaZ2VG?=
 =?utf-8?B?TC9mTHF3TXlqSHlubXVmdUMxMXVRVFd1UGRDdldrbzdOQ3VlS250clJBMnk1?=
 =?utf-8?B?U09PTnNIRStNdFBFV2FIREdFMGhiR0k1SVhqZVV6TTNQZHp3MDBFQnRROFFa?=
 =?utf-8?B?Tzg4STY0cXpWMjZoR3I4aEZtUEhDWWUvQjVDQ3pYalNicVFERlZONVdIN25j?=
 =?utf-8?B?emxDZzY1cXY5bURoUHF1UzdWd3dCakhkaTZXbDJnc0RUdldXU0UvNEhqd2lO?=
 =?utf-8?B?b1dGaTIvcmhRNTlmMjU0aC9NeUhYSGJhN2hSZ1ZhMHFVZDkxVDBuMHlwZ3dv?=
 =?utf-8?B?VXZmSytYOENwRlpPR2M3dGFxRm5lN1MzZFBjdkN0cmxFdDZmY1FZU1JURWlx?=
 =?utf-8?B?Y3FJK3hMQXhoN29CVGVDQW84anpIdWlGUTZjbUZuK0loZWZIZVBtN2hNbmFZ?=
 =?utf-8?B?dmM1ZGVVMUlXd29SMDMreGdVVTZheEdwbTVzc3pFRm9ta2ZYU2JsSDhQdTF0?=
 =?utf-8?B?RHovOVJoci9TMHoxTUFjQkpET3NyVDZXNys5UmxNeHRBV2xjd3pFTlRaOW5R?=
 =?utf-8?B?dHVQYW1GZk80NncyM3JLOElRd2xqeUtzYjVXK1F0MHFuZ0lSY0VaRE5hQmFi?=
 =?utf-8?B?V29ia3hWaUtuTFlrRHRjR2l4b3VrQTNnNFJza2h2USszR3dNZ1hPcjZ2Y2lq?=
 =?utf-8?B?T1NrTW1Sd1pMMmp1THM4SWxmOXNYaWhVWGJsWmVMd2lSRXh5d2RvSjc4MzlY?=
 =?utf-8?B?QUVUeTdiejNtckhJY202aHBwd21SMFJqSVFtdDdZZVpQUytHS1UvcjB3MmJJ?=
 =?utf-8?B?dEs2bU1jb0M1QzdqdDJrOGFQTWN2VTg2OTQzSzFiNE1sRWNkRndZdm5OT0kv?=
 =?utf-8?B?WHhZRGFqZ1lmMGtjT3NRKzdyQmoxZDdnZDFlUi9zN1cyUHhxLzFGaXMwS3Ez?=
 =?utf-8?B?eU0zdUlBQnZUL3Y5eTNSTzZ4NEl4NTdTVFlyYWNhdVpVYS9KV004b0FaY2ll?=
 =?utf-8?B?dkVRUGpoRTFwTmhXN0sxY3pXS2hqN1luZjQrSDNva1R2RzlKMUJNclJFN1Rm?=
 =?utf-8?B?NFhOaHV4MzQ4MHlKWWZLVW1paG4xZnFjTllUNFlGZndwa1piUENFM0c2YXdw?=
 =?utf-8?B?Y2R3VjZKQTZubk94eEJ0RXBhQmllUjM2eXo2TFhYZzh5YjUvdG5NWXFzdGVK?=
 =?utf-8?B?azdGUFBaU3dpVFByaG9VK3VSVE1hODNFR1BCMElTUVlyMEJtb2dPZlQzVWJT?=
 =?utf-8?B?M09MRXUrNkhsb21mbmNIR2xvNXJnTEVWWGhkMzdGbXc4RFVJOUorbldLbkZQ?=
 =?utf-8?B?YythajY3RGhmNzZOeiszaStCZEdWNHd5eDZ6VzZiZVBpYUpSZjJtYVdMV2VZ?=
 =?utf-8?B?eVVxaDh2QUNTcnVTRklTOXE3bThCQWc2OU41MncxSUtLTlJUTkdPR28yd3Vq?=
 =?utf-8?B?RS9SRnFZNHdNY0pYZXUyRVdlYkZCSWtYbnRHVDRCZThPcmRHYStNTUlmYVN4?=
 =?utf-8?B?Tk1FcXg1bWU3b05KS0hDTElTUzFYYjBzTk1HZUxXL2ZJV05ScnJsci8yby9Z?=
 =?utf-8?B?WGFrYks5elVpQnBJR2w2Q1lzeStXdXR0S05sc0RMdEI3cVM5NUt5akJRVW1S?=
 =?utf-8?B?MTd6UWplSHg4VVo0SlozWHNlSlpvTjlobTFHT2hsYXJRSlEvSjRuU0FlSHQ2?=
 =?utf-8?B?OFk4UlREelJqK0NIQ0tOQlFKVHIrekwrZ2tZODYvTUFoeG1TT3Q2a21PK3Ey?=
 =?utf-8?B?NUFGczdXcGVOdzEycGhlbkNCRDZ0QnZGRWJNTzVjSERwY2dCSTRIa05ZdExN?=
 =?utf-8?B?SEtWYmo2VjFRRDMzR3JmSHdXUG04RXZpazBHZzdBNWhYTk4ySC93ZnFuTkE1?=
 =?utf-8?B?MnpTTm90end4SHBadzhKdzhkVFJQUXd6eTdCc3lvV1JJMVk3YTVWb2pDeWZo?=
 =?utf-8?B?M3NvSGJEN0YxME1jaTlDbG9xeVJlMnFrL2Q3T3hLeUJRM0NTbEtiU3R0eXVu?=
 =?utf-8?B?RzNiWUhOelZSK3dHczhNSC9UTXpMc25sODBjMXhVODRZMXJTajFCdmppTjhy?=
 =?utf-8?Q?zqQpZ9SDj9f0zxSTx4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4770a6-f24d-4f3c-8d47-08dede5e353e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:35:33.6218 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtO0Kpj1QH/SMOwzBFdZPUSFHhcvtfYKZhIBn9Q5D/r5U7pTNAfmqyourLzShF2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
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

Hi Chong,

On 7/10/26 09:00, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian and Alex.
> 
> 
> "If the ESXi hypervisor has a problem with this then that needs to be handled on the hypervisor side."
> 
> 
> This patch is not intended to solve the issue in "ESXi hypervisor".
> 
> This patch aims to reduce the full GPU access time on newer ASICs and speed up the GPU initialization flow.
> 
> When multiple VFs are initialized, moving the full GPU access request later shortens the full-access window
> and reduces the time other VFs spend waiting for exclusive access.

Well that is at least finally a full explanation for the change.

But it makes it clear that this is basically just an optimization and not functional required.

> This is also the reason the REQUEST_INIT_DATA flow was introduced,
> allow the guest to obtain the early init data without relying on full GPU access.

Yeah and that change was never discussed with Alex or me on the design part.

I'm now systematically rejecting anything which hasn't been akwnoledged at least a couple of month pre-hand before the implementation.

So this patch here is rejected, end of discussion.

Regards,
Christian.

> 
> 
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Li, Chong(Alan)
> Sent: Friday, July 10, 2026 12:06 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: RE: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> Hi, Christian and Alex.
> 
> I do not think this patch conflicts with the original design.
> The design principle is the same: full GPU access should be limited to the phase where the guest actually needs exclusive access to hardware resources.
> 
> For the legacy ASIC(like VEGA20 or ALDEBARAN about 6 years ago), the guest does not send REQUEST_INIT_DATA.
> The host prepares the init data only as part of the REQUEST_GPU_INIT flow, so requesting full GPU access before ip discovery is necessary and should be preserved.
> 
> For newer ASICs that support REQUEST_INIT_DATA, the ordering is different.
> The guest first requests the early init data, and the host replies INIT_DATA_READY after discovery/VBIOS/PF2VF data has been copied to the VF-visible FB region.
> 
> In this flow, the guest copies the early init data from the VF-visible FB region and completes IP early init before accessing hardware resources.
> It then requests full GPU access only for the hardware initialization phase.
> 
> So this patch is not changing the legacy design.
> It keeps the old behavior when REQUEST_INIT_DATA is not supported, and only moves full GPU access later for the newer REQUEST_INIT_DATA flow.
> 
> 
> 
> 
> Thanks,
> Chong.
> 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Friday, July 10, 2026 1:32 AM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> Hi all,
> 
> I've discussed the issue with Alex today.
> 
> The current approach of keeping full GPU access while discovery has been intentionally added this way over 6 years ago after some back and forth discussion.
> 
> So that has been working reliable for quite a while and we don't see any justification to change that.
> 
> If the ESXi hypervisor has a problem with this then that needs to be handled on the hypervisor side.
> 
> This patch is rejected.
> 
> Regards,
> Christian.
> 
> On 7/9/26 12:35, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Lijo.
>>
>> Yes, the current GIM driver ensures the early init data is placed within the VF’s visible BAR0 aperture.
>>
>>
>> Thanks,
>> Chong.
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, July 9, 2026 3:56 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>> <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;
>> Cursor <cursoragent@cursor.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>> progress in sriov mode
>>
>>
>>
>> On 08-Jul-26 6:12 PM, Li, Chong(Alan) wrote:
>>> AMD General
>>>
>>> Hi, Lijo.
>>>
>>> " In this commit, the statement is different."
>>> " It says FB access is enabled if init_data request is sent."
>>>
>>> Yes, VF FB access is enabled if init_data request is sent.
>>>
>>> However, without full GPU access, the guest cannot access the MM_INDEX/MM_DATA registers.
>>>
>>> With the legacy/existing read path, VF_FB_EN must be enabled so the
>>> host can dump early init data into the VF FB, and full GPU access is required so the guest can copy that data through the MM_INDEX/MM_DATA registers.
>>>
>>> I submitted patch " [PATCH 1/2] drm/amdgpu: read FB through BAR0 when
>>> aperture is unavailable " , With the new
>>> amdgpu_device_read_fb_via_bar0() path, the guest can read the VF FB
>>> without full GPU access
>>>
>>
>> Yes, I saw that one. One other question - does host driver guarantee that discovery data will always be copied to visible BAR aperture of VF?
>> If not, it will still require mmindex/data regardless of FB access enablement.
>>
>> Thanks,
>> Lijo
>>
>>>
>>> Thanks,
>>> Chong.
>>>
>>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Wednesday, July 8, 2026 7:18 PM
>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Li, Chong(Alan)
>>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;
>>> Cursor <cursoragent@cursor.com>
>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>> progress in sriov mode
>>>
>>>
>>>
>>> On 08-Jul-26 4:18 PM, Christian König wrote:
>>>> Hi Chong,
>>>>
>>>> On 7/8/26 12:25, Li, Chong(Alan) wrote:
>>>>> AMD General
>>>>>
>>>>> Hi, Christian.
>>>>>
>>>>> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
>>>>>
>>>>>
>>>>> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
>>>>>
>>>>> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
>>>>>
>>>>> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
>>>>> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.
>>>>
>>>> No, exactly that is not the case as far as I can see. See the commit I mentioned below.
>>>>
>>>> According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.
>>>>
>>>
>>> It could also be because the legacy/existing way used mmindex/data, and that required full access including mmio register access.
>>>
>>> In this commit, the statement is different.
>>>
>>> "In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN and places early initialization data, such as IP discovery, VBIOS, and PF-VF exchange data, in the VF FB"
>>>
>>> It says FB access is enabled if init_data request is sent.
>>>
>>> Thanks
>>> Lijo
>>>
>>>> So I absolutely clearly have to reject your patch here.
>>>>
>>>> As far as I can see this is a hack for ESXi and that is not going to fly.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>>
>>>>>
>>>>>           static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>>>>>           {
>>>>>                   ...
>>>>>                   case CHIP_VEGA20:
>>>>>                   case CHIP_ARCTURUS:
>>>>>                   case CHIP_ALDEBARAN:
>>>>>                           soc15_set_virt_ops(adev);
>>>>>                           break;
>>>>>                   case CHIP_NAVI10:
>>>>>                   case CHIP_NAVI12:
>>>>>                   case CHIP_SIENNA_CICHLID:
>>>>>                   case CHIP_IP_DISCOVERY:
>>>>>                           nv_set_virt_ops(adev);
>>>>>                           /* try send GPU_INIT_DATA request to host */
>>>>>                           amdgpu_virt_request_init_data(adev);
>>>>>                           break;
>>>>>                   ...
>>>>>           }
>>>>>
>>>>> Thanks,
>>>>> Chong.
>>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Wednesday, July 8, 2026 6:24 PM
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan)
>>>>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>> <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>> progress in sriov mode
>>>>>
>>>>> On 7/8/26 12:03, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>>>>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>>>>>> AMD General
>>>>>>>>
>>>>>>>> Hi, Christian.
>>>>>>>>
>>>>>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>>>>>
>>>>>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>>>>>
>>>>>>>> Distinguishing the host platform was a mistake, and I have
>>>>>>>> explained the situation at the end of the patch email.
>>>>>>>>
>>>>>>>> I have pasted the content below:
>>>>>>>>
>>>>>>>>            Hi, Christian and Lijo.
>>>>>>>>
>>>>>>>>            Sorry, I made a mistake.
>>>>>>>>            Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>>>>>
>>>>>>>>            I borrowed an ESXi server and tested this patch there.
>>>>>>>>            The amdgpu driver works normally.
>>>>>>>>
>>>>>>>>            I rewrote the background. Is anything still unclear?
>>>>>>>
>>>>>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>>>>>
>>>>>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>>>>>
>>>>>>
>>>>>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
>>>>>
>>>>> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
>>>>>
>>>>> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
>>>>> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>>> Date:   Tue Jun 23 13:43:49 2020 +0800
>>>>>
>>>>>       drm/amdgpu: invoke req full access early enough
>>>>>
>>>>>       From SIENNA_CICHLID, HW introduce a new protection
>>>>>       feature which can control the FB, doorbell and MMIO
>>>>>       write access for VF, so guest driver should request
>>>>>       full access before ip discovery, or we couldn't access
>>>>>       ip discovery data in FB.
>>>>>
>>>>>       Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>>>       Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>>>>       Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>
>>>>> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Chong.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>>>>>>>> Cursor <cursoragent@cursor.com>
>>>>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>>>>> progress in sriov mode
>>>>>>>>
>>>>>>>> On 7/8/26 10:25, chong li wrote:
>>>>>>>>> v2:
>>>>>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>>>>>
>>>>>>>>> v1:
>>>>>>>>> Move the initialization of non-GPU resources out of the full
>>>>>>>>> GPU access region during AMDGPU device initialization.
>>>>>>>>>
>>>>>>>>> Background:
>>>>>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The
>>>>>>>>> guest should then be able to read this data before requesting full GPU access.
>>>>>>>>>
>>>>>>>>> Before this patch, the VF still requested full GPU access in
>>>>>>>>> amdgpu_device_ip_early_init(). At that point TTM is not
>>>>>>>>> initialized yet, so the normal VRAM aperture mapping is
>>>>>>>>> unavailable and the guest falls back to MM_INDEX/MM_DATA
>>>>>>>>> register access. That register path requires full GPU access.
>>>>>>>>>
>>>>>>>>> Use the BAR0 framebuffer read path,
>>>>>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the
>>>>>>>>> full GPU access request until after the early init data has been copied.
>>>>>>>>
>>>>>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>>>>>
>>>>>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>>>>>
>>>>>>>> Either this works on all hypervisors or I have to reject the change.
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>>>>>> ---
>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>>>>> +++++++++++++++++----
>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>>>>>     2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -38,6 +38,10 @@
>>>>>>>>>     #include <linux/apple-gmux.h>
>>>>>>>>>     #include <linux/nospec.h>
>>>>>>>>>
>>>>>>>>> +#ifdef CONFIG_X86
>>>>>>>>> +#include <asm/hypervisor.h>
>>>>>>>>> +#endif
>>>>>>>>> +
>>>>>>>>>     #include <drm/drm_atomic_helper.h>
>>>>>>>>>     #include <drm/drm_client_event.h>
>>>>>>>>>     #include <drm/drm_crtc_helper.h> @@ -1987,16 +1991,19 @@
>>>>>>>>> static int amdgpu_device_ip_early_init(struct
>>>>>>>>> amdgpu_device *adev)  {
>>>>>>>>>          struct amdgpu_ip_block *ip_block;
>>>>>>>>>          struct pci_dev *parent;
>>>>>>>>> -     bool total, skip_bios;
>>>>>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>>>>>          uint32_t bios_flags;
>>>>>>>>>          int i, r;
>>>>>>>>>
>>>>>>>>>          amdgpu_device_enable_virtual_display(adev);
>>>>>>>>>
>>>>>>>>>          if (amdgpu_sriov_vf(adev)) {
>>>>>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>>> -             if (r)
>>>>>>>>> -                     return r;
>>>>>>>>> +             early_full_gpu_access =
>>>>>>>>> +(adev->virt.req_init_data_ver == 0);
>>>>>>>>> +             if (early_full_gpu_access) {
>>>>>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>>> +                     if (r)
>>>>>>>>> +                             return r;
>>>>>>>>> +             }
>>>>>>>>>
>>>>>>>>>                  r = amdgpu_virt_init_critical_region(adev);
>>>>>>>>>                  if (r)
>>>>>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>>>>>          if (!total)
>>>>>>>>>                  return -ENODEV;
>>>>>>>>>
>>>>>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>>> +             if (r)
>>>>>>>>> +                     return r;
>>>>>>>>> +     }
>>>>>>>>> +
>>>>>>>>>          if (adev->gmc.xgmi.supported)
>>>>>>>>>                  amdgpu_xgmi_early_init(adev);
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>>> @@ -185,8 +185,8 @@ static int
>>>>>>>>> xgpu_ai_send_access_requests(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>          } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>>>>>                  /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>>>>>                  r = xgpu_ai_poll_msg(adev,
>>>>>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>>>>>> -             /* version set to 0 since dummy */
>>>>>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>>>>>> +             adev->virt.req_init_data_ver =
>>>>>>>>> + GPU_CRIT_REGION_V1;
>>>>>>>>>          }
>>>>>>>>>
>>>>>>>>>          return 0;
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

