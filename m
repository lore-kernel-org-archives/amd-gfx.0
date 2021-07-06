Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E1C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0332461996
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 08:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0332461996
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B203C891FF;
	Tue,  6 Jul 2021 08:24:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74BC1891FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jul 2021 08:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9djrVi9BWbpNP6wsMpI2zafrFYhon4EY3YtOgZAaVZine/dNmIy28uKOlKfDOgkBPjg6HtWGAPico8NsGE091kI8EzjJzYA54Zm3wKfInHaGFFYCts2aATMZv0xM/qVP9dVcql+xK4coq7Zo+zOR0WZeK8/+4yff6qANwLoDjTNor7tNAeRopbTTnCEqHF+pRvTvFhYbIj60/motcJhGzI4iHW9EN0qwUDrgWob9ts2Oe1W7H9L+aIs4VpR/4xvFoF8PKjfytl7K1u5DZ150MAKF2/PpQwQf3hxoxg0kBILTO90aL4yy0TpKfQZ9PSTCgLEUoXAcncYCQCgVeWseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxsrVTpbduL9GoF4TyyXW7gO0SeywJu1BtzqseEdaA=;
 b=TZz3KdE8/kgWlzcgcMx5BAxLnB4OMqDMgJpWbG1N1t5TI7VYr0eC3VDswO/8sk8UUxljNbDevqLheoSUjNDBZe7KHoA1axwwWMuAFwireHJiVcBoCqKjgtc1dx2Kj3C5EfW3uE4qoP738/Nvsaqp6TfR0CFZJgrfv1rc6irFYN1GtpPgsMBSxnPzUhvEHDjKp1WEiwq6ULTcbxHY+xjtMRcEZm3xB1sOtyfb1ibIRGBgEeU8IXXCBe+/x2Zzm9BicQcuzMdVscGZwcmVCTj7UxFFoNMzSslX2Oq+Qpo+qsIeZZij1FrqUMm4F8cjt41IQRFeQZPqwmN4+rQtqBNCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlxsrVTpbduL9GoF4TyyXW7gO0SeywJu1BtzqseEdaA=;
 b=h0gdJnPLgXQ4YvBfbxZhHIFXeP65NH9y2zqez6OK40bLgNndNbjCrJeEDRZIVkOt1EzO3ryV/O0ZLqvVHSRSY2yqsH5Wj9+HwsyOy/W4VT+ayqi8D1FNmROpT+Vs1gazCvHYt74gH/PhN+ww7QtzCamlSYaCCHD+TdO+DJFMrTc=
Received: from PH0PR12MB5417.namprd12.prod.outlook.com (2603:10b6:510:e1::10)
 by PH0PR12MB5498.namprd12.prod.outlook.com (2603:10b6:510:d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 08:24:15 +0000
Received: from PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12]) by PH0PR12MB5417.namprd12.prod.outlook.com
 ([fe80::a856:11e5:c282:6b12%7]) with mapi id 15.20.4308.020; Tue, 6 Jul 2021
 08:24:15 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Topic: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
Thread-Index: AQHXbjLZ5C13fgJBlEWCatsv5QtXwqsvZakAgAY+XXA=
Date: Tue, 6 Jul 2021 08:24:15 +0000
Message-ID: <PH0PR12MB541762741282A0512FBAA1028F1B9@PH0PR12MB5417.namprd12.prod.outlook.com>
References: <20210701043743.10663-1-Emily.Deng@amd.com>
 <f5db6355-1894-a796-75a4-8b2c9e5780d1@amd.com>
In-Reply-To: <f5db6355-1894-a796-75a4-8b2c9e5780d1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c6fa77f2-a18d-4a68-bced-e48f3fb16891;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-06T08:23:33Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6c766a1-21ad-4a1a-dbac-08d940577101
x-ms-traffictypediagnostic: PH0PR12MB5498:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR12MB54980EEEEEE6AF89F29F80208F1B9@PH0PR12MB5498.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:248;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mk2Kj9vxZ0cEoysS6NhyyBF9oL3CXccs8sWeT/92zzBVI0IevknPYUHplEa1tl90ruq1t3DB6qyIzhgYSQsMD161I97OjWZmgb6JwAF5QCbpDYTAB3lPWtC2Eg5NUzkszAZJg2VEYwtZYV81d2v4RB9LjpdnMV3OLO0bPt6hBEml+nSY0iYh4ST3SFIrAO2uldk8dSampvJBZRJIJFXQ0Jdv8Oq0sZn/Gk93E6Sang9k9wZSHv/qXSHSq0t9psvzrtyflFpYI+GJwRH/X2JBKHDyEtd6wsypNA9ehVVhffIvI4JV03Y3zuWTxCdhv5PD7uAfg4qYofa8ND2Iy2arD3NmJhMF3QStfChdR1/QMPAiH4Pg+IR5VY1ePErezziI9VITOwZrUqHYutpnSmQj5/G9pFK0bLHpWYH6cMD4Isw20K+3dUn7uHUQR8B/YI9Bs/P0XedLPODWa9Ie/6N7Pvk+QZShRP6/APTCYobIQtjaJkIpQECQHOBfuggX//8pqBy2a2E95ZeW5eXT4URklA7kk+xSGB5TkxFlnDfD6hHFa4nHBdjEnmho09ogyCOpgJqtS8vBS4H9rBD0uMPdDf18OLoCeaLO+jLPO1PRh6UjxSHzZEJ0E7erqOPb43jCdCWbOKj6G3hOKR0qrA7qBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5417.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(316002)(71200400001)(76116006)(110136005)(5660300002)(33656002)(2906002)(64756008)(66556008)(66446008)(7696005)(66476007)(478600001)(52536014)(66946007)(4326008)(8676002)(6506007)(55016002)(38100700002)(83380400001)(186003)(8936002)(86362001)(9686003)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzkrdndNSGZiOFh3K2JFSGd5SVYxVURWb3FBM05mK2htSkVkcWgxYXJZOW81?=
 =?utf-8?B?UGh5OVBCOEFVRmFnZlNhbzZjWEJ6UU51QytLcFBRUWpMZ2JWNHhiamZBUE91?=
 =?utf-8?B?amszOFMxTFlJRURtZ3c4aFpoSnpmQTYycG9ZRzU3SkZpZ09qajVROHUvV0Y4?=
 =?utf-8?B?VmRSVmtGY3dLdmNwamtoTGk2TjRmUERQbW9mVXNMZzFxeHpGTDgvemJYN2Fz?=
 =?utf-8?B?RVR5TWJ3MFBXV1J0bFFKa3BBZ205QUxGdFZCSGxjckIwamhxSW53aHpnbWpm?=
 =?utf-8?B?eitrZjlDVjFNeGl4WUp0cS9zVkZyQmRWWE5OS2l2a1RPRnpINHozSGYxL1NV?=
 =?utf-8?B?dEdKVlE1ejAxZUVUN0l0eklRNkhockRxQWt6LzJyQkxUSGRWNktiVEFyYmhP?=
 =?utf-8?B?U0Z0Q3M1SGhIMXRuemRmM1Z6OGFqYU9OakRVYnFCZlNZTmVQdGJKbWpwblBO?=
 =?utf-8?B?cmdlZ0Yrci9NQjNYNi9HRXlHSWpiVjI4VU5GMmk0SlJPMkt1clV2Z0daMWhp?=
 =?utf-8?B?Um1rWTJ1bFZRU05ubzQvTEZ0d1A5SGVDK2ZGU3RBaXkwbzVkRnpCS1FYbDFh?=
 =?utf-8?B?QlBjaFJUZFNhTXNIV0UxQ29wYWp3eWQvbDRKem9GNTVCOWJmYzlZWkp3c0Vt?=
 =?utf-8?B?TXY3R3VKVVZxYklhODBQZThNN1Nsd2djOUU0ZE42VXA5Z1ZQWklHOXNRV1Bn?=
 =?utf-8?B?Z0EvUWlTRmtVOTZzbFhjU3RZenNTZHBML0xLaVVqRDN2R3B3c3IyUHB4Y3VW?=
 =?utf-8?B?ZjBKL2pyRll4eFl0aTMvVksyS1JSU2VIN1ArYjRkemJER05RSTI0VkNKNEox?=
 =?utf-8?B?N0dlemtQMXF5MWVieCtnSWgxaWNQeENzcWV0NUE3Nk0zc1NVMkVwVm9zT09u?=
 =?utf-8?B?enAvYUJGc3JQZWM1cHRQS3JvaVJPMndyWVk3dUYrQnIyUThGZ0ZsSU41bHZY?=
 =?utf-8?B?WEdIc1ViQWxKbHlFUmt1MEp1cm1nNW0zZ0oxcnQwNlpmVi9xdVZOOVhNQTZQ?=
 =?utf-8?B?YWc5a01taHNld0dGOVhCa2hmUnFCd1NYbXo0RXlkRTdId28vbzV6VHFTMHMx?=
 =?utf-8?B?UU03RlByU21HaFh5bVdxY1FzaGhQR29sdysvZitYK0RUc0dOdEZFbGNqSStU?=
 =?utf-8?B?LzlvSUozTmNSMjBtSWtiNTBMcnNNZGd6c2dISXVQb2c4dG5RMVcyUS9vTnJl?=
 =?utf-8?B?VW9obnVCM1FxQnlOM1AxMUVhWjNiaURJMVR6ZTdrOFljZjVtUEdCSnFYQmNW?=
 =?utf-8?B?alg3ZDhIaXVXbzZjUDM3aWFwMzRLZ1VrV3AzazBUOTRQRWtvaWlOY3hlTHEv?=
 =?utf-8?B?UmxrMEJnNEZMb2Yxd2t3R0FlUmpBZXF6b1VvMElJZElXL3hHZlAzNG1abjE0?=
 =?utf-8?B?ckI4M1NubHBXUmxxdzRYdldKSW0zMElhQWU4SkhTanZDS2pSVHZtWXJoZGxz?=
 =?utf-8?B?d0FZdDdpYUpSYXIzaEdFWmcrdkJQcFJqV2kxeEozNFhoeDlpVFdRRVVHckE1?=
 =?utf-8?B?T0RIbW1tTFJzRmltaXJ0UjVmQ0lqTmgwRy9pZmxSUEtZMWZKUVQraWZ3Nm80?=
 =?utf-8?B?QnlvQ1pwNWVNSVJ3eFF2VEFva2RkQkxDYlVTZTlmMlB0SExPWEN0QXVDSmky?=
 =?utf-8?B?MkJnNXZoeDk0MllmeEpxTGtIdDlEbjRQNEVZVHpOSU4xNDZrdUV5MkRtTExS?=
 =?utf-8?B?d28wMEcvTEpNY05WdDZQMEpHZXRVeUFMVXhPYzlKcndjdDBXYVB5UlVKWFFs?=
 =?utf-8?Q?PtqgVgfdgk3LDT8asn3afWjgND3Zde4Q/N5pTd8?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5417.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c766a1-21ad-4a1a-dbac-08d940577101
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 08:24:15.0342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZJghGYdhl0zV+eehUxl/s3xA6oI0FOtPJ0W+Vs7+vYiRiNqri3NL5Hc7WtITQbs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5498
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Nirmoy,
    Thanks, already send out another patch with updating the commit.

Best wishes
Emily Deng

>-----Original Message-----
>From: Das, Nirmoy <Nirmoy.Das@amd.com>
>Sent: Friday, July 2, 2021 5:03 PM
>To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>Cc: Zhao, Victor <Victor.Zhao@amd.com>
>Subject: Re: [PATCH] drm/amdgpu: Correct the irq numbers for virtual ctrc
>
>Please describe bit more with a commit message.
>
>On 7/1/2021 6:37 AM, Emily Deng wrote:
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> Signed-off-by: Victor <Victor.Zhao@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> index 33324427b555..7e0d8c092c7e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> @@ -766,7 +766,7 @@ static const struct amdgpu_irq_src_funcs
>dce_virtual_crtc_irq_funcs = {
>>
>>   static void dce_virtual_set_irq_funcs(struct amdgpu_device *adev)
>>   {
>> -    adev->crtc_irq.num_types = AMDGPU_CRTC_IRQ_VBLANK6 + 1;
>> +    adev->crtc_irq.num_types = adev->mode_info.num_crtc;
>>      adev->crtc_irq.funcs = &dce_virtual_crtc_irq_funcs;
>>   }
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
