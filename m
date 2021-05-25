Return-Path: <SRS0=WUpi=KU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E405C2B9F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 16:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7896140A
	for <amd-gfx@archiver.kernel.org>; Tue, 25 May 2021 16:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7896140A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3E26E0AD;
	Tue, 25 May 2021 16:09:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13FDA6E0AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 May 2021 16:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AR0n9o4rmggcEl92+KtInLONDduSmippkPM6KwYlgf6zZCCymvNt0SNQUr9hBCh3q8ZOu/DqJIYRvVUBUM6Nz34+HRAC62ETQLqiDIsfzMuwRlA3hX2QdhIjwFw136Pq/nObc1/C6Fp2QH7afeTVZr9lPu2CBJZOlqJV3KkrJvGQOtNx8QVxoX/iPxFO1u8fWQlAtR5jfk3TO5iousnkET5T4z4VnSU6YREJa9K7MNxmdL+h3j2VtT7mL32NRBDuRhGTICBDMcajoInz0/tpfAYbcxQNZeCVrHaKnrHXxchnvk36pR8/9syel+9hsFUUtV/O+0E/b7KwXy7SgqqpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMaPRBQB1Od60+JdHXtAIm3M0t8jSkp8DSPi7kkwvEU=;
 b=kimRWRhP0Q04s367CfzW+xxDtAn5cjs/mgb0FKh/N8wf80UUKlCt2XpYlTtQ1EyzwE+aWifomsdFNYr6mTUBRfipJnevMOCeCo5p4RxGcPi7TQBSWZCPq6oILObjwJgDqb/WM4Xbbk1OvSeELTfLcK1m0NfyO0A+GmHl8lYR0X/MKt/VPaw9Et+KPmCW4Qpyfk9jGX7MiYXQvdDAJgLhzhpcIVE0PNBi0r3kL/YqCRRavUkVvRpfVWUquo26gGbVwvjUUCTwIiX1WFTh8826tG4Kfquz+s2CtHWJaLwCv2nkYQpkxszoC9oif4pW5UOXKVAuwKstmx1Mwzg4UcmEtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMaPRBQB1Od60+JdHXtAIm3M0t8jSkp8DSPi7kkwvEU=;
 b=hWUFb+oypWeErdDFCkijGcyTE4Zs423qsRsv2K0DvSAuEBGHwY82Boe8Swzz3JBdDYAhdkdyrkkujvXl2J/JhVTU3URbZidYREm5SDHh+lt36+DuLf89/ISdlTbAaml6QUmSL4bctuqeEg6jpZ4UVvG9lQr45eYxQOvEMnfQKbA=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB2635.namprd12.prod.outlook.com (2603:10b6:5:45::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 16:09:30 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 16:09:30 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/6] drm/amd/pm: Add ASIC independent throttle bits
Thread-Topic: [PATCH 1/6] drm/amd/pm: Add ASIC independent throttle bits
Thread-Index: AQHXTYSpvX5+1JfMg0iULHbMPosl76ryOUkAgAIpdyA=
Date: Tue, 25 May 2021 16:09:29 +0000
Message-ID: <DM6PR12MB3067173B2A915A5F3A5839FF8A259@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <05960347-a7ee-20a4-a657-4e523a14aaa6@amd.com>
In-Reply-To: <05960347-a7ee-20a4-a657-4e523a14aaa6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b014058-25de-4f05-85c5-08d91f977a2f
x-ms-traffictypediagnostic: DM6PR12MB2635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB263541AAD10360111BD59AE98A259@DM6PR12MB2635.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fmdF34823H79uW962VkYoAVr6q0v99rtG3UTJ92DCMqt11XlPa1qKB4WnyraZ5mYi4NQXrIjEucoAzFYvaZPN2Tm6QSGxgr6g9PFg8RzpkILmBfszuRZd9XO+Bwi2czqpVecOHDvBlPLPD3xJQQkag4o5UePwm1ipbIlVhM2+aInCGe+sbuShbGFuM7BKmOgCWvJ995njLa7BIEFu4myH3MqVhRKGhPzAQsuOox1522CIwUtT+fjPRfOoIfSnwf0gB3ju9YYwzr95gpKdgf0icAaZPF2aHIVJdTOIkSu38tQ7CE2EfBSP+dl1FPsBRubPeTI5DCB9Z+bioD3hZf8xtVP2wUVFvC5EAJUjysUN/WT9T0mz46c83UyySFa5tXe+kZTOiutFPFlMUMLNyJmtIW8dbwo+cEIJzhszYpDxy9WLc23IFzYeVp2IFKTTjfVJAE3I/CfmkPVz36TIhhXZ7C0S1GmqRbopjW1dnjeTD1dOtOvjlB+r6NQiJE1/8hF4FdS8KLq7BsQgy+Xgq3gzfju9lB0xki/zb3GmCyqRiasoWSN+pryBlMxnwcV9NRbT1N1V7hgAjxnonWvjFcs8ODrw8sRh8KtDztrOtpaAzM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(9686003)(26005)(33656002)(66446008)(478600001)(52536014)(64756008)(66556008)(66476007)(7696005)(66946007)(53546011)(6506007)(86362001)(122000001)(83380400001)(110136005)(5660300002)(38100700002)(76116006)(8676002)(4326008)(8936002)(71200400001)(2906002)(316002)(55016002)(186003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?dzJ2U0ZBdVF1QTBudC9udkJyamN6WmIwMmZMUnlTRGxUODZnUUxJZG1hRHlz?=
 =?utf-8?B?elFTRjBNeXRtQndHQU1zZ0NhUStKVGFrUTA5SE50OHdPM0tOak0vUlhHQ2Fr?=
 =?utf-8?B?ak9ZQnlYVHp1WEhmbFhSUGdhVnJwVUlBdUdlWklCSXpiOWlrQTQ3Zkt0NEZW?=
 =?utf-8?B?UjBMblVkRmtUcEVTZEZ6Yy9GMFlyU2FQMzRXa2QzRk90WE5HWGI1QnZyNm9q?=
 =?utf-8?B?bHphWUxIZkp6enlvVTI4Nk5DU09mdHN5ZjRRVkFSK0JDM3NFelJvQ24xQmFr?=
 =?utf-8?B?TnBzOVZidEdrMzd3d0ZVY1JoMHd3aEFoYUwwWUFTU0l3MmJLMzErM25ob1ps?=
 =?utf-8?B?bFlxVWxlZG05WTBiVXJjRi9DdlhMTmJXcXdReGk5N1JpY0ZSWGR2NDMrelZl?=
 =?utf-8?B?UEwxeEdpY3VJN0xuSnIwOFR2eUxwRVRRdnBqcXAxdFVURDRkYlMvV1dSOUxU?=
 =?utf-8?B?dEJ3VDd4QXMxOWN3Q2ZLN0pBaDMraW14VlkyYjJJT0RzUURQMWprbG9HbXdE?=
 =?utf-8?B?MzQ5eWR5YnMzZEV0UkgvN2Jjc3AwaGxPZklNcVJaVW5ER1A5NlQvWjFPcFJN?=
 =?utf-8?B?Y1M4bVJJcGdjYS9GYXd3MTJSUi9ZV3Fnc1ZUNWFueHVXY0NjbTNGTUloVXNC?=
 =?utf-8?B?R29DV3djbzd0QU1vZkJTaWFnM3JBd0ZFRnVmRlBxR29NQ1pmeDkxeUJtQXpx?=
 =?utf-8?B?NVAwRTVwN003M3VPOXFOREsrNnRzaHNaMzhjaVN6MGk2b0MwRDlhNVhNNUlR?=
 =?utf-8?B?aHFTbXI2NitYK01UU25OVUpjZWQxakhXVnBjRVc1MWdvaXV3UFI0RUlNc2R2?=
 =?utf-8?B?emRBU3JtMHZoRW80N3Rhb2dPbjNvZFAvaUkrRkZXU1VVTExlZmJUb3BYYUR6?=
 =?utf-8?B?dHd0eFRJRjZEeWFOc1hGQ3pGRlQvd3FnSk1VbTMyNVdCOEhCUHJCUW5lZ0tn?=
 =?utf-8?B?dnFabitTbnQ5MU1CekhiYTN6YjFOM3N1bzNmZXV4NWUwR1NQNGpZSy9OLzd0?=
 =?utf-8?B?MmRmRTZ6elduamp5R1ZOV3JDd013OGppakI3OUs2SHh1T01FZVYzY2s3SjVn?=
 =?utf-8?B?M013Z29CVkY2aHFWdHlVVjViTm9heTZNSlh5UGkxM3I5d21vSGNiZzE3QXpR?=
 =?utf-8?B?N1BaWWdEMXR5MUxOdXQ4aWZKK0Y5WWNZSEhpeWozcG9jdHducVRGRVBwOWtE?=
 =?utf-8?B?dTMzWlh6dGVkblZVVW8wTmlMRmJVVWQ3ZDZSQnI2OVFpSjQ3YWkweHVWK1d1?=
 =?utf-8?B?N1NCbm5hWG5ua08vVTR5cmhsOXdheGtJRStwdk5Ld044R1lhN0NYVHhXL3A4?=
 =?utf-8?B?c0svVklsU2FOdUtCaHArUlBkNE8xOUtKSWovMkFKRm1UYzlMbUhWbTNQVmFk?=
 =?utf-8?B?MFF2bksrc2dsZVZlSTRxbVY2NzNQY2ZHMWhSdzVUZnlBSnM3UzRpK1hNK3Ru?=
 =?utf-8?B?WWN0R2s4dTh2R011TXYveHppNzF0cFE2bTNuS0s1ZHVMTXdaVlh4OVZISmZm?=
 =?utf-8?B?Mmh6UURiSkRXbUNsMk0rRUt1OWwyZEJPYUhQejVyaE5hSWVKc0EyNFZ6Wlpv?=
 =?utf-8?B?Wm4vaG1MNFlqbFlTbll4MEJkcjR0cFZtbnQ0YjdjMy9sbjZlbjZkRWZnVDAw?=
 =?utf-8?B?MVZLOXlhd1FUMU9Gc3JMazNYOUxrSFRUSFJ4cUFhQVpJZlZTODFwTS9RSy80?=
 =?utf-8?B?cEdkMkNpUGRpUnRaaUp4MmJySmRadVljVElVZllzVStmV3VSTzEzUHNZMDRS?=
 =?utf-8?Q?c2D0xOuuZ4wFG6YqT0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b014058-25de-4f05-85c5-08d91f977a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 16:09:29.8354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv8M0Fh/Fk6a62hbVV+kvT2C0tMfzEf05ECgpYuKk9V3aQqAB11WsXw/5ae3uw3bSjUb2qvm1MGU0svMuUGKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2635
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Most of these changes are due to Van Gogh having a different naming scheme than the rest. Just to confirm, let me know if this translation is what you're referring to with the below defines for Van Gogh:

THROTTLER_STATUS_BIT_SPL		->	SMU_THROTTLER_SPL_BIT
THROTTLER_STATUS_BIT_FPPT		->	SMU_THROTTLER_FPPT_BIT
THROTTER_STATUS_BIT_SPPT		->	SMU_THROTTLER_SPPT_BIT
THROTTLER_STATUS_BIT_SPPT_APU	->	SMU_THROTTLER_SPPT_APU_BIT
THROTTLER_STATUS_BIT_THM_CORE	->	SMU_THROTTLER_TEMP_CORE_BIT
THROTTLER_STATUS_BIT_THM_GFX	->	SMU_THROTTLER_TEMP_VR_GFX_BIT
THROTTLER_STATUS_BIT_THM_SOC	->	SMU_THROTTLER_TEMP_VR_SOC_BIT
THROTTLER_STATUS_BIT_TDC_VDD	->	SMU_THROTTLER_TDC_VDD_BIT
THROTTLER_STATUS_BIT_TDC_SOC	->	SMU_THROTTLER_TDC_SOC_BIT
THROTTLER_STATUS_BIT_TDC_GFX	->	SMU_THROTTLER_TDC_GFX_BIT
THROTTLER_STATUS_BIT_TDC_CVIP	->	SMU_THROTTLER_TDC_CVIP_BIT

Graham

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, May 24, 2021 2:58 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH 1/6] drm/amd/pm: Add ASIC independent throttle bits

There are duplicates in this list. It's better to classify as Power/Temperature/Current/Others and map; maybe, allocate 16 bit each in a 64-bit mask. Also, keep the naming consistent and start with "SMU_", that's what we do for others like SMU messages.

Power throttlers
-----------------

#define SMU_THROTTLER_PPT1_BIT		
#define SMU_THROTTLER_PPT0_BIT		
#define SMU_THROTTLER_PPT2_BIT		
#define SMU_THROTTLER_PPT3_BIT		
#define SMU_THROTTLER_SPL_BIT		
#define SMU_THROTTLER_FPPT_BIT		
#define SMU_THROTTLER_SPPT_BIT		
#define SMU_THROTTLER_SPPT_APU_BIT	

Current Throttlers
-------------------

#define SMU_THROTTLER_TDC_GFX_BIT	
#define SMU_THROTTLER_TDC_VDD_BIT	
#define SMU_THROTTLER_TDC_SOC_BIT		
#define SMU_THROTTLER_TDC_MEM_BIT => Should be the one used for HBM as well #define SMU_THROTTLER_TDC_CVIP_BIT
#define SMU_THROTTLER_APCC_BIT		

Temperature
------------
		
#define SMU_THROTTLER_TEMP_GPU_BIT
#define SMU_THROTTLER_TEMP_CORE_BIT	
#define SMU_THROTTLER_TEMP_MEM_BIT		
#define SMU_THROTTLER_TEMP_EDGE_BIT		
#define SMU_THROTTLER_TEMP_HOTSPOT_BIT

#define SMU_THROTTLER_TEMP_VR_GFX_BIT		
#define SMU_THROTTLER_TEMP_VR_SOC_BIT		
#define SMU_THROTTLER_TEMP_VR_MEM_BIT
#define SMU_THROTTLER_VRHOT0_BIT		
#define SMU_THROTTLER_VRHOT1_BIT

#define SMU_THROTTLER_TEMP_LIQUID_BIT

Others
-------
		
#define SMU_THROTTLER_PPM_BIT			
#define SMU_THROTTLER_FIT_BIT	

--
Thanks,
Lijo

On 5/20/2021 7:59 PM, Graham Sider wrote:
> Add new defines for thermal throttle status bits which are ASIC 
> independent. This bit field will be visible to userspace via 
> gpu_metrics, replacing the previous ASIC dependent bit fields.
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h 
> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 523f9d2982e9..fbbebb1da913 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -35,6 +35,38 @@
>   
>   #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
>   
> +#define INDEP_THROTTLER_PPT0_BIT		0
> +#define INDEP_THROTTLER_PPT1_BIT		1
> +#define INDEP_THROTTLER_PPT2_BIT		2
> +#define INDEP_THROTTLER_PPT3_BIT		3
> +#define INDEP_THROTTLER_TDC_GFX_BIT		4
> +#define INDEP_THROTTLER_TDC_SOC_BIT		5
> +#define INDEP_THROTTLER_TDC_HBM_BIT		6
> +#define INDEP_THROTTLER_TEMP_GPU_BIT		7
> +#define INDEP_THROTTLER_TEMP_MEM_BIT		8
> +#define INDEP_THROTTLER_TEMP_EDGE_BIT		9
> +#define INDEP_THROTTLER_TEMP_HOTSPOT_BIT	10
> +#define INDEP_THROTTLER_TEMP_VR_GFX_BIT		11
> +#define INDEP_THROTTLER_TEMP_VR_SOC_BIT		12
> +#define INDEP_THROTTLER_TEMP_VR_MEM_BIT		13
> +#define INDEP_THROTTLER_TEMP_LIQUID_BIT		14
> +#define INDEP_THROTTLER_APCC_BIT		15
> +#define INDEP_THROTTLER_PPM_BIT			16
> +#define INDEP_THROTTLER_FIT_BIT			17
> +#define INDEP_THROTTLER_VRHOT0_BIT		18
> +#define INDEP_THROTTLER_VRHOT1_BIT		19
> +#define INDEP_THROTTLER_STATUS_BIT_SPL		20
> +#define INDEP_THROTTLER_STATUS_BIT_FPPT		21
> +#define INDEP_THROTTLER_STATUS_BIT_SPPT		22
> +#define INDEP_THROTTLER_STATUS_BIT_SPPT_APU	23
> +#define INDEP_THROTTLER_STATUS_BIT_THM_CORE	24
> +#define INDEP_THROTTLER_STATUS_BIT_THM_GFX	25
> +#define INDEP_THROTTLER_STATUS_BIT_THM_SOC	26
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_VDD	27
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_SOC	28
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_GFX	29
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_CVIP	30
> +
>   struct smu_hw_power_state {
>   	unsigned int magic;
>   };
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
