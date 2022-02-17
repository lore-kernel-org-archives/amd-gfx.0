Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE574C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 06:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4046610E942;
	Thu, 17 Feb 2022 06:47:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1920C10E942
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 06:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsDgkTQ7M+CES2j00fLph/1V5gE8eefNeczhFuu4tqFaynpeddq/ISpbsGtMrblfN3D2gQF56ApuBiEei0m35W0hwpHmltREe4GzLGy8hKG8yhg7pGhK+UXR68OZnv2fg8iyvjTYIU3wOILNxzG3GNbX3+uxtRpx6ZhhKNXLwa+6MdG+3Ov+QH28TA4/yLu+IMjb7IhwZs8nbv3y3kMIXct0ADeJeaWki5yAxVZuBlYl0VAxX2CpAcRTgiHTAkB41vzHT0g/0zhPssYv7r8BHCg36/LjorOEe0kZbhlwdM39JyQDNwhoC2rpDbqKfUS/ZVA7RXGW6PK7e1wgbeMG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qU/C/h6oQWCuVYeiPG37Q28TnskRlhnos3kHu16dBmQ=;
 b=LN0tcmVu9pGo11bIAyfOznykMK9OEFH5LDPkopMjZGLMtbTpAg+LGqVgwvISQHekTYe9QoZpceF0pdAdY2ozjw/+oA/HPQ2jDZLendx/CPCyGPrh9C4xDU+THhDl9i4nrhS8+kHOEPUi/uMOu+eysywwn0FPk+Dz+dP9cFFq58SOyDndRjLw7xRJ4NbAMjNXAX0iq4gAls9dupmH9O6KJTZ7n9OOndjA505TmFZuEkFQkjWqk+J9hNbRkdR03awasbPz5PqbbL1eqg4m0vFpYbXZvYnJvBbOTRZjIceuazhBFl02NmFZhAS5/FEb/bPrqu1lhXXpjBHCg5qQQxf69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qU/C/h6oQWCuVYeiPG37Q28TnskRlhnos3kHu16dBmQ=;
 b=yIHTCIXufzuPEbjAgCUp9OpF42eXOsYbcWviHaXRPjOgK0OOiSMr6lHkUwDoGtdwf8De/yOannL1OKP93aVtKAHAyneocEwCXoiL+nBrOZBsw160sCjKV9m62TThzYCIKKYA9wXZjxB5ILuMzBLdMQP6IW6Nt2/TA2Ax6UpIm60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 06:47:21 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.4995.015; Thu, 17 Feb 2022
 06:47:21 +0000
Message-ID: <25333c0b-d53b-c3e4-7fed-c88327ffafd9@amd.com>
Date: Thu, 17 Feb 2022 12:17:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amd: Use amdgpu_device_should_use_aspm on navi
 umd pstate switching
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220217054504.10535-1-mario.limonciello@amd.com>
 <20220217054504.10535-2-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220217054504.10535-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 521c9642-fcff-47fe-b2ff-08d9f1e158e9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5142EF3ED3403714112DCE0597369@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHc98wZhtVgxlN9/+uj7JAayHfHpLbMM8Wn0FKEeDCH0OCGNEfykCtpJt9izhZ1xsm5T+ndvFyIMdGLV6YkKDtcoNI/4BIIRoyRLQsco/tlcsKOdceihrbaLgUlZ4Ky9xlPxiOyxQZ5h9Xeco3kdCwRsOGRJDAsnsR5acIkFqDbdrghYFV8xyiWnjeLU5kf3Kr3cjNaBUS+2ueQfVhJZzVl26mwSrPEP3YnN/JXATpBgo/gn7rxegEOf9C0Ah1MIRaKb/YkibAH9tgEzakCgHqK/vXXsslKIfdFeIHSl6GFQCsgGD753OxBxU7JUPCHZIfEM/OUxAuqkPWH5ExQF2znh0DEvHQ9xwjGEzUE4QLcTThswWIRMSsTFE+2linpcw+ljhHOhz6JDjAKhcnLdELcZ+lbpQwHRDgPAeW5qO4/Y3Zr8npkizlvpoBkNzwF/zARiTN4/wUDioHOgsJ4JbVstLips3Imv6NxFuR3S+6ENEZ7bPnTB/9WfsJ5j2YwBj82qlFAGgbTb6J9gU9v4QT6sELCBN0XjBByUl97Bv/k/E1wkrADjvbYdw/NpXglSfKfc4iWX+42HIHs6amwBU2gpM/snRHZt0qHRWjzG8wTUqyH251HcVnD6RpQVUaK+XgJBasBu7A2YekM+v1c9IR1PUlo92NQ28I0PtPCzmDpHznK/cme75WNhfv3zrZ2vwrj5PYeUcvirl2Yd7W73CIu7qDvJY0XqdelhfBRrqqXSVwqW3QxWjR33kqt+oW3r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(6512007)(186003)(316002)(6506007)(6666004)(6486002)(53546011)(83380400001)(8936002)(508600001)(31686004)(86362001)(38100700002)(66556008)(66946007)(36756003)(66476007)(31696002)(2906002)(5660300002)(2616005)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm9tY3cxMDBRUTFqZUl1SDVCcVdURk9ZRDJRMUVTTHFBM0lpYWtSV1VFTDNa?=
 =?utf-8?B?S3lIQkNnRFk4Q0dtb3lLMHA1ZEZxMkJwYXA2QWFvYW9DYzJPRjF3YnZ3aGlC?=
 =?utf-8?B?R1U1ZHYrdC9HUThLNDc3VGNRbXg4ZmVTeGZVdjQyRm5zSW5oNHVkZHRYOE81?=
 =?utf-8?B?aE4rdnlOYkQ4MndTRFZ4dWRPWDZEYzJJZ3J0REZqTEsxVHFLSXp0WTlaYWhI?=
 =?utf-8?B?NzB4ck9jYkFMQWJHbWZVMC85YXJPeXlnMENiaHNRdk9jYzIwdVBJK0hBeVRn?=
 =?utf-8?B?ODdMMUw0dzdZbU05N1p4b0RHcldQbHI1dEUwdFhNcGpTUFJFV1Nwb3JCUXFl?=
 =?utf-8?B?ZzlCR3liY2VYODBIUnEyd3lMcHkwTndpVDNQWUljdUVrK0ZUb1lwRFRFR0p6?=
 =?utf-8?B?R3o4d2dVMjhJSGRwalNaYVpDVkV0M2M2MVFIV1g3M21LZFVNYStpeHQyMUhT?=
 =?utf-8?B?a3piVExTa0RxaVFTZU0ranA5aG4rQytkdzZWbE1CZEI0TmNVVEJoSU9nb3N3?=
 =?utf-8?B?ZDdkVWlqcWVpdm1KM3hQMXdwZFhDUzgyejZaSXYwTlFOdmtqbzhPaHRSVnQy?=
 =?utf-8?B?NjBSVk94RlB4ZlN5VStwNEU0ZkYrL0VYVmVJb1Y3V0hoYmhndk9EVWJwanlh?=
 =?utf-8?B?ZFBPa1owelFhdTkwazE0VjRKcXgwNS9xRzRJdk82NWh1cGJ1NElqd25rdG1w?=
 =?utf-8?B?dFcva3ZxNko1VE5vQWorUktRaU5FdWJpb2lGcUhQZEpvbkFVa3ZtbkhRWGFF?=
 =?utf-8?B?WWprektSVmtsNXJDVEkrUmZkcW0yeHdaUG1WNkpvYVV1d1MwWElLOUptYXAw?=
 =?utf-8?B?b3E3MlI2ZDFPa1BOQTVwcVFjdml0eEZyaFYwcUtWcHRnVjJSdlk5cUVYVjBk?=
 =?utf-8?B?VW1obS9IMjNxd2NhSkVDcGdRWXVPQkNnMVVYMXozSDRqSWlUSWJzczRQeXlS?=
 =?utf-8?B?SVNmenJQTFd0RExDQTcyblUxY29Ra2dBdGlyay9MVXBrYkxXMUh0Z2YzcGpB?=
 =?utf-8?B?WTJ1ZGFwRm12dTJjbjRYQ1JpMDFVTUZtQWR5ckJLc0Q4Q3VhSFpKdFg3S1Nk?=
 =?utf-8?B?R3RJOXh1VjJ3YVg4Uy9XMm5qME05K1BYQU9Dazl6dUxVZnp5NDVNMDdtMXFL?=
 =?utf-8?B?YUE4YWwvKzNCOW8wbFF3a0JPYitqcHlmZkVhYko2d0VXYWdIYW1Bek1NeWtM?=
 =?utf-8?B?TEozdUpxMk9CalczbVVZZWdtSkRMVHEyN0tMMWVhNktWdTVyRzB0THZCY0FV?=
 =?utf-8?B?dzdxN1VoYWt4OXA2dDZ3OTI1akVDNklwY3Q5dkNCOXlGc0hOY3crQ3Q5ejha?=
 =?utf-8?B?QUhVSW90b2JNeitxbXp6S2lQU2hiSkJuQXA4U3lad0VJcnZQcTliWnNETHJG?=
 =?utf-8?B?Q0ZWc0pQb3JKTGJSVzc3TVM2WGM0bjVJV0J4NGRUaVkveHlGQlZQZG9SbWJW?=
 =?utf-8?B?N3llWVpVMUczR0x5MTBHUFpkUXgyNkNHemVoMVREZHg2OHNaUk1PM1dva0Fy?=
 =?utf-8?B?S1NPR3NYbzFSZngwZzVFTDRMQUdFN2RmL3pWL01Yckxza2d2cm9RemZibTRO?=
 =?utf-8?B?VmtVUmhhUUdGYm9Kby85T3ZKblVZelF1MGpZcHJRWWpHQ3hQcDB5S3hzU0hN?=
 =?utf-8?B?dVl6NElsK1J0dWNPMlpyb2c4TUthM3hRNVZ0cHdMZm9sU0lKOFM0elFxNlFJ?=
 =?utf-8?B?Tk05Qzc1Y0V3K2lGa013WnMxVi9PSFU0YXB6VTNNVzAxSGhvUEo0eUZPRC81?=
 =?utf-8?B?UTgyaW1NZXlDaFV0c3ZQVUlmb2NMeVhmMGtQdUJlR3BYTFozK2JOMndiT2Fk?=
 =?utf-8?B?Y1dyZ2hlRkJBWHptQW5odndFN0hsemRQWTA2Wnl2S0pZTlRZTnl2aGtDQUdX?=
 =?utf-8?B?REZ2TG41MElmRzZOZnVTVFA0aSt1cVRtUkwyQ08xRXo2dUpaMjdranI1djM4?=
 =?utf-8?B?YnZsUkJKeW1JQUhQZ3laTXVoT3N1WHV5Vi9TUzBRQ3NUUG1vdkU3MGZJZmVI?=
 =?utf-8?B?SDcrcTZqZDBKS1Q2RUVkZFQwY0FZY25SL1FqVlhteS9pQkd3VE1lRHAwZG1l?=
 =?utf-8?B?cVAvV09pVEIzdVMzNXdZVlBvWkJFZUdjQ1hob1hkNEQzaEUvcHR4WjI0TVRz?=
 =?utf-8?Q?XzBs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521c9642-fcff-47fe-b2ff-08d9f1e158e9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:47:21.5188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqlKdWYBQZD6g8uC3/Eaeq7VKGaILl/wrbxth8WIb1zF9cK4Grsa3VZG8+QaNtJr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
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



On 2/17/2022 11:15 AM, Mario Limonciello wrote:
> The `program_aspm` callback is already guarded for aspm, but the
> `enable_aspm` callback doesn't follow the module parameter.
> 
> Update it to use the helper `amdgpu_device_should_use_aspm`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index ebed9c84db04..b246a37f4f39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -635,7 +635,8 @@ static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
>   		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
>   
>   	if (!(adev->flags & AMD_IS_APU) &&
> -	    (adev->nbio.funcs->enable_aspm))
> +	    (adev->nbio.funcs->enable_aspm) &&
> +	     amdgpu_device_should_use_aspm(adev))
>   		adev->nbio.funcs->enable_aspm(adev, !enter);
>   
>   	return 0;
> 
