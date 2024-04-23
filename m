Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8F5C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 02:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22819112F67;
	Tue, 23 Apr 2024 02:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HbvvIhXj";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C49C112F67
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 02:02:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTry8usFM7IhygkwiDNOAtImnXhgUF3T5pTQvIi0x5EvxADCUqHgwqkXsGarQGv2gNvp8lNcLXyP52vcPWw3S8R6SalsE9HcShfx8YoL9UuGk4RwwxOX09ol+tnst5dZljs9chCX4sxzUr86/krecek6VxkTAIjpZ4ZGGWFRN6PK3YpqJzmTmvtCF2lzPT4zl/mjYUVN1VSXEmzahUDEm5x7tJM27+8owwm9aQ1/Kc3RXxXERtG6B+xZDBap6irtE0wk4ie9iDfRGqlxNWSzJGf39ELGNcuFW/id174tshk+f5Ypj0Y37gORm8suYSrG3GK6XMbsMpV8cOFPF69u4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD6zi9qtcAN+Y35Cm1oOUw/6HG1Bcup300d3884kVUE=;
 b=YSeNybPVEWC3Co2DiSiKn/CEA6+QmthvU0m9NJ+r/T4k4iLydHQ5DrfNjbfEzmsBiYoufK2Uk3Soatz47noFKNKuHhaVRas6ahMwD4ZlEqkuaQbMKYuzjKf2aKLsjmnjkszfELg5sCrssIDtEpizvrtC1rsaEiIuGbyCikqS+8eP3fYnGXln7Ui+vMDPtU+yhaCC9DNuR0br6+nv/CGBSRjw6WZjLL6ODgkq6TkAycu461nKhG7eB8x7u3ontZ2sh/9sIIPy0Z7lZRSLRfu7W3sI9D7XN+fmZo7bVLz/1gN5RtLxsVm6yKy+CrPSM6W5lET/RR3JEefuNacPFbVcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD6zi9qtcAN+Y35Cm1oOUw/6HG1Bcup300d3884kVUE=;
 b=HbvvIhXjEkCq5cGfW8YaKCLw3cAWSNsghyWUZAIpBoaJ2LKbwSTVCHb/+RlJ4O9iylO42gQwHvO3dnfLnAdbdBhlo7EYGe9cFKi/YN+4DvIw/CB5EgJDtZljVKIOm93OGUsAQZU1/w5QXn838Sb+XOTrh/zqTnY1R1/7IhJry1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:02:00 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:01:59 +0000
Message-ID: <41b891da-957e-4d2d-a98c-b7d6e95db138@amd.com>
Date: Mon, 22 Apr 2024 22:01:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: Alex Deucher <alexdeucher@gmail.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 christian.koenig@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <CADnq5_N=KG_8bZ4k-f-LOOazH2CtkQ0O4sQ9Ge3CpzxcGjMZLA@mail.gmail.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_N=KG_8bZ4k-f-LOOazH2CtkQ0O4sQ9Ge3CpzxcGjMZLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b3384ad-1b56-4db1-9b0e-08dc63395c89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGhHdmY4M1lHSmxYZTI1WW85VU1SLzY5VmttQk5CZDR0Q2ZtRGc2NCtzaFdm?=
 =?utf-8?B?VHEyZTQxRkViTk5lWFdqWXJpMnIwY3BSMWxXb0NTZ1l4OW1GcGYzc0N4YnQy?=
 =?utf-8?B?SFEzdE9jMGgwSHMzcFZTZTJiQ3pKcGVHL3lwTGd1aVV1VnB3Z2lac051Q1VW?=
 =?utf-8?B?VjRYdFRSdnByQXNOb2Q4VHJCRGxmZ0RqNExRbktpeEw1a28rckd1MGlucUhJ?=
 =?utf-8?B?Zlh1OVZzMFIxSWhrNEE4MWljT2ZUNWN1dDNkYlNHM1RlL1c2UlR3Z2M4amNM?=
 =?utf-8?B?Z3NXRjU0UmJxUXR1V2lKK21OUi83bHVJaFpUOUIyQUNiRklJSmxiTStyNjcr?=
 =?utf-8?B?bCtzdlpOYVNlUEQzYVUyeE5qM3lGMnN4R3BwaDF0Z09xU2g1aTEyR2kxYjhN?=
 =?utf-8?B?emVVajlnTzM0RmQwVi9qR1hkcjJCU1ZTSFZNTXJ6ajAwRTk2dmhJSG5uQXBE?=
 =?utf-8?B?Z2FsTHRhOFAwWGpHM1B2Z0NuSisyZzZ4dm9McE95Tk11eFJUTEV6NzNuMFRY?=
 =?utf-8?B?UnFyV0dDVkRHNmtraTVYZG9BWG0zc0dqVi9aVndCdjFlQ05QS09kdFNkcTRE?=
 =?utf-8?B?WkczeGgwOGN4RURZb2JKYzVrMCtIdFpsM2tDTVhzQXBKVFJBRmIyRkhsV0ds?=
 =?utf-8?B?cWJGRVZCUVowaVhqcjZvSGtSOFRONnptMFdXMHRLWE5ZSVpRRWhnRFUyWWc2?=
 =?utf-8?B?MWcyUUVpSEVvaVFHTmZCMDd4cEVneUF1YktNL2pITytHVWJVZ29mS1R6SEpC?=
 =?utf-8?B?RFJML1JCNC8vNWtoMHVQZ1VDbFpBV3lmVzVsRHpoMzlGSmZkUGw2amVjanBU?=
 =?utf-8?B?cnUyZDJqdjQ2YzY5aFdLa3pCTFgyOEJRU0ZoNzN2VEsxK1c2L2lBNXpOdlVY?=
 =?utf-8?B?S3FXaUMxMkFlM1VBMDc5MjhsSHNHNXBMRWN4WkozcnplVjZ1cnEyVWJINEZi?=
 =?utf-8?B?enJuQnlrTjR6SlFBMGEwcHd6WFpENnBYbE9hNEQ0TzFmQ3RXdHJNQ2wxdk1k?=
 =?utf-8?B?QXBkQzdzd0kxaWMrUkpYRnh0ZjYxOERycC9uSG4vaklLR0ViMTNlUWdvbXJ0?=
 =?utf-8?B?SjFLdUxPVi9tRWg1WVNCV0FId3NWZUZNREN1Y0lCbTcva3QxaVVvYWhuQUUy?=
 =?utf-8?B?dU1TS1AyZkJmajlHZ0U4M3JNU3pDL3p3bzFzYUhHOE5QSHl2c0hvWVRlUWxz?=
 =?utf-8?B?V0I5STRUOVd3N1lDS2hoaTBscW01aXo5YktUNHZKV3NrMGRWNkJ4NjY4eFhk?=
 =?utf-8?B?MHJJeHBLNHhYb2VNeFBsVEV1SVZibjgySkl3enlCWjk3Z1lCenBqenlBK3BH?=
 =?utf-8?B?U2lWRW5UK0V5eksyQ1B2Yk81U0V3d1JDR1VmcHZsak1qd3pRM0ZGUE45RVNJ?=
 =?utf-8?B?NjBhektQTnVqdHk5WFk5THhxYm5RZlVnSkdUdVFTNmorVTZkMVFjUXBqNFdD?=
 =?utf-8?B?b01Lb1FxcjVUWW9KRU5IS0hlQ0hpdGlmWUlNbkE5dGVlOVRSd1JRQS9JdUNJ?=
 =?utf-8?B?am5sT3hPNFkzelZiWXVramZ4aFZKK3ByNzZxTjhZbEtsdzZzRjBSNllBQk56?=
 =?utf-8?B?WDdiRXlRblJxVE5FaGYzbVlORTFRZ1BsRTZrQVJvMEptYUk3Z1ozcnYyaHFR?=
 =?utf-8?B?WkpkSmtjL09ZaEpyeWVQRzVZT2hKUWdtblJhR3dvc3ViMkhIdFBCa2FBQVV6?=
 =?utf-8?B?K0srZ054OTFyNnE0S2hVMlRySnpVODZjaXVRVXpxWDMrR2NzYjVmQnJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9YMVpvZis3bEdlV0FLSXJFejY5LzFIUWRKSnlnK1VkNGJBWjlJcGJCdDk0?=
 =?utf-8?B?dmUxSUlhZmozYjRhOUNqS2Y4Rks3RktGRkFoQWI3cXRwYUZReHdYcVM5QnF6?=
 =?utf-8?B?ZS9kdTcwaDBUaCtFQ1NLVm5ucVp6OGYrVWZjQVA2c3pjbE5sMnZWc1pUWTNU?=
 =?utf-8?B?NjZzV09KcmtGeUYwYjlrOEJsWDU0K3BvMEtSSUNTZ3Q1cGxPOHdnTnFTcW05?=
 =?utf-8?B?UnFyY3lWNGltUlhOY2g4MHNlR0NiZEZWbWl3d2g2NUpRMkZYNkZSSzMzNGhT?=
 =?utf-8?B?Nlh2a3hUVGI1SEN0aEVwUm5zTzYvUnJ3VURvSDFyVUpQSmV5OWp6Ykc5eHh0?=
 =?utf-8?B?ZFZrOHl3VjBUN2g3dDJLU1lDcE9ieHBIbTRac2FaR3NWWmlnZldYYjNCRkpN?=
 =?utf-8?B?enZoL0Q0NnRDKzNnRGhSdDI4MWpZMWtVbFBjZlVTNHE4b1RiSk1GaEVHTWhq?=
 =?utf-8?B?WVZMTk5OOW8xbmpaS21QOCs2YjgzQkQweUZPdjQzenFTNGIrRUpZNUJwOXRi?=
 =?utf-8?B?anhuRGVkN3RSU2s5ZTVUVk02c0JtbTFYZytuaVg2SEdLUjBNY2t3NFVjSGwy?=
 =?utf-8?B?aXRKaE5hREJ4d2EwYWNYVHhQejFkRVYxVThUNDhXQklwcG1sV0pjY25ndUJ6?=
 =?utf-8?B?T0NFYUxKR2FwNG1VV1NpaDlxWnFONThwL0orTllaSjAzTUtvTTY5OGRqZ1lU?=
 =?utf-8?B?M29iZFMyQUZYZVI1djdKU1N3NFZJbGtmSG1vMlhqa0UzM3lMd2ZTUERuSHFk?=
 =?utf-8?B?MHNVQmRmK2NCK041S2daT1NzclZNWWI3Zy9nVDU1QUJSZGwxRGpDYU9mTkdr?=
 =?utf-8?B?bkVFeE5qMUZPWXQ3NzBuMWhPY0xtdmJVRUJnaDBzUVpWQngrKy9BMzNWcWtr?=
 =?utf-8?B?WC9uZzY5VW8zd3FPVkM3UFRtbGFmZ21taVQyMUo2aFpXMUhPOHA1QTZodTJv?=
 =?utf-8?B?Qnh3dmtHbHRocVVVWWlVdDZ1RTVKSmxiamljRWxuZGdUdWN1KzJiNnNHbk1y?=
 =?utf-8?B?N0ZkeG9xUCtFMzlGSkxoSjA3c21vbVBuZEdEdmlZU1RhN0dJTExSOTNyclBp?=
 =?utf-8?B?MUtsVkZvUk9tOXN4ZHBQQzdMUlNtRTdGc2Z0NFJJTFJWQWpIcjBUbkpUdUgw?=
 =?utf-8?B?d2g1b1RQN25JV1pnTVhISkswV0s3dkhSNU80cXc1eHdPSi8xTW1jMS9oRU4y?=
 =?utf-8?B?bHBDdDZvN29sTkk3Nkw2eEN3Z3Q3THArcmlqUjhKUC80K1U5bTIyWjE3YmtM?=
 =?utf-8?B?ZDBCN2FrWG12RUN4SGJyYTVpNHBDL0t0UTR6WHlvWXVvY2JIMWpGamJLZ1F1?=
 =?utf-8?B?aDkwd0RXSzVjeXRmdURGVDZhNzFIYkZ3eFpWNjlJTEpVWkM5Q2NpM2F6SU5L?=
 =?utf-8?B?bk0rNXN4Y2FJRGhDUm8yejVhUUs3V01aR1ZGWklqd20wNkszcDVaeURkaGxI?=
 =?utf-8?B?NkxaU2lrQ2x0NWh6QUdsN2E5clIxUVFhNzFlYkhwakt0bjlEMFNrRGtMN1hr?=
 =?utf-8?B?RDI5REwyNGFrd1ZtaUhqMzFmejEyajVVVzBqYjNEaVIySThjTnEvU0RmZ1d0?=
 =?utf-8?B?ajZIZS9sTVhnbGtWQ0tsWTJuTWY0MXJsaWZWNktpV3F1WnlGTi9GeUpxdndW?=
 =?utf-8?B?cmo4Z1ZGdEVKQTROSzBWeTBiS2xWNVhEaG5DaFdBNE55UEpleXVCLzc4bmVh?=
 =?utf-8?B?aDRob1lITnBwcmphS0FHM1BkN3ZxS2NVUkFhZE5pUC9jSVc1cHhEVGxZbTJM?=
 =?utf-8?B?Slg1NFYvNUJia2dtQytjRWJpQUFPZFBHdWRaRGRhUFlaTzlzS2ZRRXlqWWtT?=
 =?utf-8?B?M3YzNnBwR1V2cVdjZFg0dnp2TWMvcjVRcjg1cG1qZXdTaHNLN2w3QjVJeGVU?=
 =?utf-8?B?WEkrSGZvdElnaGFOTFdKT011dzhKdVpMblRkN0NwTVJsVnRCV2tOb05FVi85?=
 =?utf-8?B?OFJzeUp3NHFtNXVLVmYxeXdnTDA3OXBqRFY2VTNLcUcvYVUxSnlpYW1qTHl5?=
 =?utf-8?B?K0dSdkVOQTZkOHV4SFhpalhLQXRac1Ivek9nOWlmMVk3Qkk0Yk9pWHRQU1l2?=
 =?utf-8?B?alY4cHp5N0hMMHFVRVdaTzQwUXFWaFZ5U1lrR0JyMUUvUGJlRDgyMEZidWo0?=
 =?utf-8?Q?HzR7Nx3Rhd4RmhmR+pooVsCIL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3384ad-1b56-4db1-9b0e-08dc63395c89
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:01:59.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCeUPc0uSPz6lKJUMVObPuBRUXRKqiz1WTlOgP2FiEL0DXtHeZ8EIYRR0wqCHuTFcyMbTDYPwExJ3hPYiDqtIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

On 2024-04-22 16:14, Alex Deucher wrote:
> On Mon, Apr 22, 2024 at 3:52 PM Yunxiang Li <Yunxiang.Li@amd.com> wrote:
>> Reset request from KFD is missing a check for if a reset is already in
>> progress, this causes a second reset to be triggered right after the
>> previous one finishes. Add the check to align with the other reset sources.
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3b4591f554f1..ce3dbb1cc2da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>>
>>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>   {
>> -       if (amdgpu_device_should_recover_gpu(adev))
>> +       if (amdgpu_device_should_recover_gpu(adev) && !amdgpu_in_reset(adev))
>>                  amdgpu_reset_domain_schedule(adev->reset_domain,
>>                                               &adev->kfd.reset_work);
>>   }
>> --
>> 2.34.1
>>
