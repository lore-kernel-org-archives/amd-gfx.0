Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6131CC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1452665210
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1452665210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FEA46E0EB;
	Mon,  8 Mar 2021 16:10:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F9E6E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 16:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgxW+7fklJ/RUZmMpSSzftqBnqWWAB4Oo5axOW41svPP/1bcTuGXIU8S7wdfYw8Ar864ealLl6cIakHEkPgBxM6QM7fi7gJ9qum1JFzd+0NlvEzQdpTgpR3r5QmIC97/mS77KIMAlr1JH6AoQT/l4KdQ6iy/xjpHjwk3U9Vzjwy0Fun2/aflXtrpubgsjis2/zrRIZs/fA/bT4j4cNnq9XHH5pbZxAa8styuxC0b+AE34CMcnE1sE6GtdlcK2lTn6gPHJP+9cGI7DgSd0eDkAxaTVzZ372PA94+NMA06vQbcZzqzr38n+CwCdYdR3jgXYgJI3L/h/CAMqwC22cuZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPpUYld+ARNTpoevsOKkPpYW0iAPuTiWl3QnG2Cr5Lg=;
 b=Iw40UZ3UZ1FbuXNYC0dxleAn1gCakLJvrXdtbLCumzy60blMhkZBNzmgvNW6BPnVNyXF9sPdKSUWbQGNrNJTGp7iKFrBSUjy43DNYQ0aaLatWcqVw+dl2jfIKFg5etXpjPUxBH+Z2Xk8+Hk0zkv3pQWunoTSjF1kz8JOBMSStQtCIqTOncaNSfplCZF6IYlWIFfrmNZ8kvB5r/j7vh9fq0J7MFrydN/GVlH84Z4ym71nGX7sjaUGC07bFg3jIL88pd08vQTDMFNrntXzZOdgKzSiBYPp9G6VjxX6N3Vs/kReQ/n/FbhG8Gye8kpzOyCIbiqT5XAGudjRJ6hDZTD3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPpUYld+ARNTpoevsOKkPpYW0iAPuTiWl3QnG2Cr5Lg=;
 b=0gneW1daiOTAK+JPHJdkDUQzNReDbQqLPj7GYu28WHpxvHa3/PVN8EI2tcHce3K+EaLo1uIqgcYqRrwcmK/bJljfx5obXtLiSuY1P8c82S1R8REzqLeWN8fpEzqZv400GM1ND0+A00YQQxB1lWJ8ndiKFrsVcqTxH4CziAZIiZ0=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 16:10:01 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 16:10:01 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng
 probe
Thread-Topic: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive
 duirng probe
Thread-Index: AQHXEehnkJi0ZBdQLUmnTOEKi9nTFKp1xzgAgABa9PCAAFhyAIAA8H4ggAAJLuCAAjBVgIAAk2MggAAKgYCAAAQ9kA==
Date: Mon, 8 Mar 2021 16:10:01 +0000
Message-ID: <DM6PR12MB3835F620378BE1B8A8A35A6CF4939@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210305175257.32219-1-shaoyun.liu@amd.com>
 <34643514-c054-242a-336e-1ac9ab7ffcc7@amd.com>
 <DM6PR12MB3835CA23C6EA827DE36FC1A1F4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <69c471aa-3a68-6a54-608f-c03c73c0b248@amd.com>
 <DM6PR12MB3835E7CD4FAC9CFCE33549FCF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <DM6PR12MB3835340976F1AB36BA768D4FF4959@DM6PR12MB3835.namprd12.prod.outlook.com>
 <4726b422-1ec8-b9a4-dbf2-578280a76b01@amd.com>
 <DM6PR12MB3835DDDB171EA71175FA16F2F4939@DM6PR12MB3835.namprd12.prod.outlook.com>
 <e39944a2-1cbe-fb0f-557c-fe24222009b5@amd.com>
In-Reply-To: <e39944a2-1cbe-fb0f-557c-fe24222009b5@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-08T16:09:55Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f39af39f-5607-4ef5-a92d-74ed28d4248a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:3bc0:316:65ee:b0a0:8b9f:261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 026449aa-5058-4437-df1f-08d8e24ca0f5
x-ms-traffictypediagnostic: DM6PR12MB4340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4340E2959C91D3999A27CDE9F4939@DM6PR12MB4340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HarrlLWD/DgexjaxVl4iMh/EiNRbqWSANdNgClZhzqcRPeHtScsXonqycKl1YKKdOzAqgFz7uYh3SlQLWFril8ZD/p/WobUgym1PhX+LqEtTQ3WO2EQW3DMdgmliBDIyry+HHhNkCR7uQsDMU9aZz25PxJsk+vIQofMCm2kt/gDR6S3wzsg5Qo/xRtppXLg9nnmlRcOgYZcsgmW94tW3pwXqbk/qxpt4Jws6K/CZQDd0lBqIfb4do/GdOAN5i5vT36tlXuDCu9GuiZWHIlnZhuScYmgyVQljwklPM32YG5B2iYXFVmj+3PeHUbb8MRl9QKH5woMTCLR1hGwKPO29jtcB5BvF918UOK29xxWN/HazsReRMys207/mol51OABlThwnnneqdXsJRQNKPAGIpw1jeMQ0RJsRla+DQZ/YxEYWrGVwbmbEN0SkNhNRYd9e0kD+5QWq56e9wIyHCJ7ViUX/RZYFJeiooVB+OHvRk22KORG+EYrbgVK7PIbISqW2VYKib5lR9QDR0qCjZzCNHXmyrrYEhle1K/ty1P8bD0xyEPCHNtF4GZ78RuouqqSDQkA9VA+dkdl3tMZ9t/LzCxcBb20ihuIsmu+NlL/rmj70HqHeo+XkesKH79XUIoUxvUpfiGz+q8HkXlfKWnUn5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(66556008)(76116006)(83380400001)(5660300002)(6506007)(53546011)(66446008)(7696005)(2906002)(86362001)(33656002)(64756008)(30864003)(52536014)(84040400003)(55016002)(8936002)(45080400002)(8676002)(71200400001)(9686003)(66476007)(66946007)(966005)(478600001)(110136005)(186003)(316002)(21314003)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?elNQRno1elp4QWY2aGZhS21xVy9XM3VQblN4Vmh2ZktEUmNMb2ttQXd4MEY5?=
 =?utf-8?B?dDF3c1RkSHZRblUzMEVKdnFRUFVGRjRRZTZCQVM3TDROR0ZXd002Um9sUUk2?=
 =?utf-8?B?N1o3eGF5ZklidjJkcUd4S25XLzdyQlI4OEtuZi85Z0dpKzRVSmdTS2YrcDVr?=
 =?utf-8?B?V0dRUzd4ZG5hb2tUdXdOaENsaGtrblRhd3VXQjdJa08za0MyaUFWOEJvV0ZO?=
 =?utf-8?B?cU5PelhTNC9ucldqZm1Ua0txYlJQMWVnNFI2YXlNN3piZmlNK3dZR1B4dnFv?=
 =?utf-8?B?bzhFbE05bHpwUU9ZczN6OFZ6WVQ1Q1MxQ0N6VkZNejdCTHRkbEVMcUcwYk55?=
 =?utf-8?B?RFpHZVVEaVNZVUd4SWxaNit4c3dsQUFoSU0vTUkwRmRSbytIaU5XNWpiK0NS?=
 =?utf-8?B?ems5T0YxRHVnWkFXMmdpak85d2liZUJmVnRBejBVSXRzVnZKeVQvbDlHL1dn?=
 =?utf-8?B?VTJrVFllYlBqUndDOUpNZ2U2cUgvRXdVbVprT3dyUTlaakNoYUNPNWZlMFZO?=
 =?utf-8?B?Q2xBb0JleWJDUS95RjNJYXYzNDBWYmdzS09wa3IvZ2NvQzQ0VzE4VHFtYnBm?=
 =?utf-8?B?Q216NThkOUZhSzd4Nkl2bHc4ZGNmN0dlTzh1NU5NYTVmeUdWeEwvZ2VSY2gx?=
 =?utf-8?B?TnNETHphUGJqMVRXRlJ4dW01MVlsUUlLQjNPVUxrMWxzTTdXdGxBaHdkbmN3?=
 =?utf-8?B?VG91dy82WjIzUm5VK0Y0OE4zKzVrenhkbC9JdEdndEVrWWlIaEFOSmNLVW9E?=
 =?utf-8?B?UDV5VWVWTHZhSUlmT25zV2FRMVlhb21DZDUwNlROUUlmN1BKRTVhN3IvVFk2?=
 =?utf-8?B?eC9HUHFPT09XNk03ZUdSUW5jK2kyVUJWZHZCUzFUWVVCaEtMVW1LWnZrMlA4?=
 =?utf-8?B?M2pPL0dITnhYaHJtejFiS1pmQ29LR0R2ZW9lZDVRelRKcDlLaVVJYUV4Ym5F?=
 =?utf-8?B?cFJXcHpYNWE4d2RuZ2JiUitmNE9ZUWFRL1NjYUV0aG9UMmJ3bURJNkwrb2cx?=
 =?utf-8?B?dXZWT3hEV1VUZ3duS0ZYMVlMRlBIY2ZqbDA4VlFla0l3bVk1ZXFyUXA4NS8v?=
 =?utf-8?B?a3FkQnNBVEowUEpFMldJWTRqSVNmK0d6MnhDVFlqRnNyUk1ZS0s1Sjl4VG1V?=
 =?utf-8?B?M1lmOHVQcVFXMi9BNFY3bVJlbE0vQnZEOENlTzQ1MUY3aEtTNlVDekJpZzQw?=
 =?utf-8?B?N0FWVzljKy9yZzM0b3d1V1JJcVBBeEdvQ1NnYk4xTFo2S3JCSFhodkwwcko5?=
 =?utf-8?B?VUVCdzArcUJiaTJOV25pM2xNNkgxOGcyZldkN3Z0UUYyU0VUdmRjZ0wyMnBP?=
 =?utf-8?B?bkVUdk5za2g1N2tqZ091OEZQVWpQNXo4dmt0S3JEajJTR3ZrQTdCdDVlQUF0?=
 =?utf-8?B?aU9tYTBpaElyTGlwZHgwNVdlM3JSdkEwRUpLQ3J3VFJkY202SnJUVkhCTW1C?=
 =?utf-8?B?V1c3SEorcngwUjE4NUJwMVlpc213SnVVd1dOczJhWnVpVVBLZDJOY3dZcFJ3?=
 =?utf-8?B?d0pjNy8yNlRid1hrbTFTaEMwRDI2eDZQNmhvSFdrMFpnaDdLUXZWN0srbjdq?=
 =?utf-8?B?NVIxYUxVU29PYWtOcEU2SzJhZk9xNFkrUHhtcmpvS0xoeEtsVno0Z0JVM1NZ?=
 =?utf-8?B?ZkdzUlZOMTAvalFVeHBmQ21qVkNFNmpueitsZmY4Q05kM0l3dEszVXFURFpB?=
 =?utf-8?B?ZUxWaThVSElnTHBhTmlZUVo5ZGhCcUpacDMvbDVjZmx0eCtGYlJoei9zT1Qv?=
 =?utf-8?B?bmJtL3Q5THB5UkRkNUZMZ09ueGtvbUlHclpGZEFudDlrelkwSkdNemdzMEgx?=
 =?utf-8?B?WFo4OEJTU2RLMUsrOVAwdGliamRaa1JURlVSTTR0T09ZNEFvbEdzQmVkWDF4?=
 =?utf-8?Q?N9j6YlFM57tV4?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026449aa-5058-4437-df1f-08d8e24ca0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 16:10:01.7815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OKawfE9ytQlhKvvTMYJTGLDG0kMz8sGDpOSH+G7Ef1JlyD7fVZqfzsQIVihS8R8041LihfHg32dIJhCpH3ePAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi, Andrey. 
The first 3 patches in this serial already been acked by Alex. D, can you help review the rest two ? 

Thanks
Shaoyun.liu

-----Original Message-----
From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com> 
Sent: Monday, March 8, 2021 10:53 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI hive duirng probe

I see, thanks for explaning.

Andrey

On 2021-03-08 10:27 a.m., Liu, Shaoyun wrote:
> [AMD Official Use Only - Internal Distribution Only]
> 
> Check the function amdgpu_xgmi_add_device, when  psp XGMI TA is bot available ,  the driver will assign a faked hive ID 0x10 for all  GPUs, it means all GPU will belongs to one same hive .  So I can still use hive->tb to sync the reset on all GPUs.   The reason I can  not use the default amdgpu_do_asic_reset function  is because we  want to build correct hive and node topology for all GPUs after reset, so we need to call amdgpu_xgmi_add_device inside the amdgpu_do_asic_reset function . To make this works ,  we need to destroy the hive by remove  the device (call amdgpu_xgmi_remove_device) first , so when calling amdgpu_do_asic_reset ,  the  faked hive(0x10) already   been destroyed. And  the hive->tb will not work in this case .   That's the reason I need to call the reset explicitly with the faked hive and then destroy the hive ,  build the device_list for amdgpu_do_asic_reset without the hive .
> Hope I explain it clearly .
> 
> Thanks
> Shaoyun.liu
> 
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Monday, March 8, 2021 1:28 AM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
> hive duirng probe
> 
> But the hive->tb object is used regardless, inside amdgpu_device_xgmi_reset_func currently, it means then even when you explcicitly schdule xgmi_reset_work as you do now they code will try to sync using a not well iniitlized tb object. Maybe you can define a global static tb object, fill it in the loop where you send xgmi_reset_work for all devices in system and use it from within amdgpu_device_xgmi_reset_func instead of the regular per hive tb object (obviosly under your special use case).
> 
> Andrey
> 
> On 2021-03-06 4:11 p.m., Liu, Shaoyun wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> It  seems I can  not directly reuse the reset HW  function inside the  amdgpu_do_asic_reset,  the  synchronization is based on hive->tb,   but as explained , we actually don't know the GPU belongs to which hive and will rebuild the correct hive info inside the amdgpu_do_asic_reset function with amdgpu_xgmi_add_device .  so I need to remove  all GPUs from the hive first . This will lead to the sync don't work since the hive->tb will be removed as well when all GPUs are removed .
>>
>> Thanks
>> shaopyunliu
>>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
>> Liu, Shaoyun
>> Sent: Saturday, March 6, 2021 3:41 PM
>> To: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; 
>> amd-gfx@lists.freedesktop.org
>> Subject: RE: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
>> hive duirng probe
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> I call the amdgpu_do_asic_reset with the parameter skip_hw_reset = true  so the reset won't be execute twice .  but probably I can  set this parameter to true and remove the code schedule for reset since now I already build the device_list not based on hive. Let me try that .
>> For the  schedule delayed work thread with AMDGPU_RESUME_MS, It's actually not wait for SMU  to start. As I explained , I need to reset the all the GPUs in the system since I don't know which gpus belongs to which hive.  So this time is allow system to probe all the GPUs  in the system which means when this delayed thread starts ,  we can assume all the devices already been  populated in mgpu_info.
>>
>> Regards
>> Shaoyun.liu
>>
>> -----Original Message-----
>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>> Sent: Saturday, March 6, 2021 1:09 AM
>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
>> hive duirng probe
>>
>> Thanks for explaining this, one thing I still don't understand is why you schedule the reset work explicilty in the begining of amdgpu_drv_delayed_reset_work_handler and then also call amdgpu_do_asic_reset which will do the same thing too. It looks like the physical reset will execute twice for each device.
>> Another thing is, more like improvement suggestion  - currently you schedule delayed_reset_work using AMDGPU_RESUME_MS - so i guesss this should give enough time for SMU to start ? Is there maybe a way to instead poll for SMU start completion and then execute this - some SMU status registers maybe ? Just to avoid relying on this arbitrary value.
>>
>> Andrey
>>
>> On 2021-03-05 8:37 p.m., Liu, Shaoyun wrote:
>>> [AMD Official Use Only - Internal Distribution Only]
>>>
>>> Hi,  Andrey
>>> The existing reset function (amdgpu_device_gpu_recover or amd do_asic _reset) assumed driver already have  the correct hive info . But in my case, it's  not true . The gpus are in a bad state and the XGMI TA  might not functional properly , so driver can  not  get the hive and node info when probe the device .  It means driver even don't know  the device belongs to which hive on a system with multiple hive configuration (ex, 8 gpus in  two hive). The only solution I can think of is let driver trigger the reset on all gpus at the same time after driver do the minimum initialization on the HW ( bring up the  SMU IP)  no matter they belongs to the same hive or not and call amdgpu_xgmi_add_device for each device after re-init .
>>> The 100 ms delay added after the baco reset . I think they can be removed . let me verify it.
>>>
>>> Regards
>>> Shaoyun.liu
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
>>> Sent: Friday, March 5, 2021 2:27 PM
>>> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; 
>>> amd-gfx@lists.freedesktop.org
>>> Subject: Re: [PATCH 5/5] drm/amdgpu: Reset the devices in the XGMI 
>>> hive duirng probe
>>>
>>>
>>>
>>> On 2021-03-05 12:52 p.m., shaoyunl wrote:
>>>> In passthrough configuration, hypervisior will trigger the 
>>>> SBR(Secondary bus reset) to the devices without sync to each other.
>>>> This could cause device hang since for XGMI configuration, all the 
>>>> devices within the hive need to be reset at a limit time slot. This 
>>>> serial of patches try to solve this issue by co-operate with new 
>>>> SMU which will only do minimum house keeping to response the SBR 
>>>> request but don't do the real reset job and leave it to driver. 
>>>> Driver need to do the whole sw init and minimum HW init to bring up 
>>>> the SMU and trigger the reset(possibly BACO) on all the ASICs at 
>>>> the same time
>>>>
>>>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>>>> Change-Id: I34e838e611b7623c7ad824704c7ce350808014fc
>>>> ---
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  13 +++
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 102 +++++++++++++++------
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  71 ++++++++++++++
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |   1 +
>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |   8 +-
>>>>      5 files changed, 165 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index d46d3794699e..5602c6edee97 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -125,6 +125,10 @@ struct amdgpu_mgpu_info
>>>>      	uint32_t			num_gpu;
>>>>      	uint32_t			num_dgpu;
>>>>      	uint32_t			num_apu;
>>>> +
>>>> +	/* delayed reset_func for XGMI configuration if necessary */
>>>> +	struct delayed_work		delayed_reset_work;
>>>> +	bool				pending_reset;
>>>>      };
>>>>      
>>>>      #define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
>>>> @@ -1124,6 +1128,15 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>>>>      bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
>>>>      bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
>>>>      
>>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>> +				  struct amdgpu_job *job,
>>>> +				  bool *need_full_reset_arg);
>>>> +
>>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>> +			  struct list_head *device_list_handle,
>>>> +			  bool *need_full_reset_arg,
>>>> +			  bool skip_hw_reset);
>>>> +
>>>>      int emu_soc_asic_init(struct amdgpu_device *adev);
>>>>      
>>>>      /*
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 3c35b0c1e710..5b520f70e660 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -1220,6 +1220,10 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>>>>      		}
>>>>      	}
>>>>      
>>>> +	/* Don't post if we need to reset whole hive on init */
>>>> +	if (adev->gmc.xgmi.pending_reset)
>>>> +		return false;
>>>> +
>>>>      	if (adev->has_hw_reset) {
>>>>      		adev->has_hw_reset = false;
>>>>      		return true;
>>>> @@ -2149,6 +2153,9 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
>>>>      			if (adev->ip_blocks[i].version->type != AMD_IP_BLOCK_TYPE_PSP)
>>>>      				continue;
>>>>      
>>>> +			if (!adev->ip_blocks[i].status.sw)
>>>> +				continue;
>>>> +
>>>>      			/* no need to do the fw loading again if already done*/
>>>>      			if (adev->ip_blocks[i].status.hw == true)
>>>>      				break;
>>>> @@ -2289,7 +2296,10 @@ static int amdgpu_device_ip_init(struct 
>>>> amdgpu_device *adev)
>>>>      
>>>>      	if (adev->gmc.xgmi.num_physical_nodes > 1)
>>>>      		amdgpu_xgmi_add_device(adev);
>>>> -	amdgpu_amdkfd_device_init(adev);
>>>> +
>>>> +	/* Don't init kfd if whole hive need to be reset during init */
>>>> +	if (!adev->gmc.xgmi.pending_reset)
>>>> +		amdgpu_amdkfd_device_init(adev);
>>>>      
>>>>      	amdgpu_fru_get_product_info(adev);
>>>>      
>>>> @@ -2734,6 +2744,16 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>>      			adev->ip_blocks[i].status.hw = false;
>>>>      			continue;
>>>>      		}
>>>> +
>>>> +		/* skip unnecessary suspend if we do not initialize them yet */
>>>> +		if (adev->gmc.xgmi.pending_reset &&
>>>> +		    !(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC ||
>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>>> +		      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH)) {
>>>> +			adev->ip_blocks[i].status.hw = false;
>>>> +			continue;
>>>> +		}
>>>>      		/* XXX handle errors */
>>>>      		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>>>>      		/* XXX handle errors */
>>>> @@ -3407,10 +3427,28 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>      	 *  E.g., driver was not cleanly unloaded previously, etc.
>>>>      	 */
>>>>      	if (!amdgpu_sriov_vf(adev) && amdgpu_asic_need_reset_on_init(adev)) {
>>>> -		r = amdgpu_asic_reset(adev);
>>>> -		if (r) {
>>>> -			dev_err(adev->dev, "asic reset on init failed\n");
>>>> -			goto failed;
>>>> +		if (adev->gmc.xgmi.num_physical_nodes) {
>>>> +			dev_info(adev->dev, "Pending hive reset.\n");
>>>> +			adev->gmc.xgmi.pending_reset = true;
>>>> +			/* Only need to init necessary block for SMU to handle the reset */
>>>> +			for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +				if (!adev->ip_blocks[i].status.valid)
>>>> +					continue;
>>>> +				if (!(adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
>>>> +				      adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC)) {
>>>> +					DRM_DEBUG("IP %s disabed for hw_init.\n",
>>>> +						adev->ip_blocks[i].version->funcs->name);
>>>> +					adev->ip_blocks[i].status.hw = true;
>>>> +				}
>>>> +			}
>>>> +		} else {
>>>> +			r = amdgpu_asic_reset(adev);
>>>> +			if (r) {
>>>> +				dev_err(adev->dev, "asic reset on init failed\n");
>>>> +				goto failed;
>>>> +			}
>>>>      		}
>>>>      	}
>>>>      
>>>> @@ -3541,19 +3579,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>      	/* enable clockgating, etc. after ib tests, etc. since some blocks require
>>>>      	 * explicit gating rather than handling it automatically.
>>>>      	 */
>>>> -	r = amdgpu_device_ip_late_init(adev);
>>>> -	if (r) {
>>>> -		dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>>> -		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>>> -		goto failed;
>>>> +	if (!adev->gmc.xgmi.pending_reset) {
>>>> +		r = amdgpu_device_ip_late_init(adev);
>>>> +		if (r) {
>>>> +			dev_err(adev->dev, "amdgpu_device_ip_late_init failed\n");
>>>> +			amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_AMDGPU_LATE_INIT_FAIL, 0, r);
>>>> +			goto failed;
>>>> +		}
>>>> +		/* must succeed. */
>>>> +		amdgpu_ras_resume(adev);
>>>> +		queue_delayed_work(system_wq, &adev->delayed_init_work,
>>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>>      	}
>>>>      
>>>> -	/* must succeed. */
>>>> -	amdgpu_ras_resume(adev);
>>>> -
>>>> -	queue_delayed_work(system_wq, &adev->delayed_init_work,
>>>> -			   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>> -
>>>>      	if (amdgpu_sriov_vf(adev))
>>>>      		flush_delayed_work(&adev->delayed_init_work);
>>>>      
>>>> @@ -3570,6 +3608,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>>>      	if (amdgpu_device_cache_pci_state(adev->pdev))
>>>>      		pci_restore_state(pdev);
>>>>      
>>>> +	if (adev->gmc.xgmi.pending_reset)
>>>> +		queue_delayed_work(system_wq, &mgpu_info.delayed_reset_work,
>>>> +				   msecs_to_jiffies(AMDGPU_RESUME_MS));
>>>> +
>>>>      	return 0;
>>>>      
>>>>      failed:
>>>> @@ -4240,14 +4282,16 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>>>>      }
>>>>      
>>>>      
>>>> -static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>> -					struct amdgpu_job *job,
>>>> -					bool *need_full_reset_arg)
>>>> +int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>> +				  struct amdgpu_job *job,
>>>> +				  bool *need_full_reset_arg)
>>>>      {
>>>>      	int i, r = 0;
>>>>      	bool need_full_reset  = *need_full_reset_arg;
>>>>      
>>>> -	amdgpu_debugfs_wait_dump(adev);
>>>> +	/* no need to dump if device is not in good state during probe period */
>>>> +	if (!adev->gmc.xgmi.pending_reset)
>>>> +		amdgpu_debugfs_wait_dump(adev);
>>>>      
>>>>      	if (amdgpu_sriov_vf(adev)) {
>>>>      		/* stop the data exchange thread */ @@ -4293,10 +4337,10 @@ 
>>>> static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>      	return r;
>>>>      }
>>>>      
>>>> -static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>> -			       struct list_head *device_list_handle,
>>>> -			       bool *need_full_reset_arg,
>>>> -			       bool skip_hw_reset)
>>>> +int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>> +			  struct list_head *device_list_handle,
>>>> +			  bool *need_full_reset_arg,
>>>> +			  bool skip_hw_reset)
>>>>      {
>>>>      	struct amdgpu_device *tmp_adev = NULL;
>>>>      	bool need_full_reset = *need_full_reset_arg, vram_lost = 
>>>> false; @@
>>>> -4310,6 +4354,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>      		list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>>      			/* For XGMI run all resets in parallel to speed up the process */
>>>>      			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
>>>> +				tmp_adev->gmc.xgmi.pending_reset = false;
>>>>      				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>>>>      					r = -EALREADY;
>>>>      			} else
>>>> @@ -4348,10 +4393,10 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>      	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>>>>      		if (need_full_reset) {
>>>>      			/* post card */
>>>> -			if (amdgpu_device_asic_init(tmp_adev))
>>>> +			r = amdgpu_device_asic_init(tmp_adev);
>>>> +			if (r) {
>>>>      				dev_warn(tmp_adev->dev, "asic atom init failed!");
>>>> -
>>>> -			if (!r) {
>>>> +			} else {
>>>>      				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
>>>>      				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>>>>      				if (r)
>>>> @@ -4384,6 +4429,9 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>>>>      				 */
>>>>      				amdgpu_register_gpu_instance(tmp_adev);
>>>>      
>>>> +				if (!hive && tmp_adev->gmc.xgmi.num_physical_nodes > 1)
>>>> +					amdgpu_xgmi_add_device(tmp_adev);
>>>> +
>>>>      				r = amdgpu_device_ip_late_init(tmp_adev);
>>>>      				if (r)
>>>>      					goto out;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 253c59e0a100..aebe4bc561ee 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -44,6 +44,7 @@
>>>>      #include "amdgpu_amdkfd.h"
>>>>      
>>>>      #include "amdgpu_ras.h"
>>>> +#include "amdgpu_xgmi.h"
>>>>      
>>>>      /*
>>>>       * KMS wrapper.
>>>> @@ -167,8 +168,13 @@ uint amdgpu_freesync_vid_mode;
>>>>      int amdgpu_reset_method = -1; /* auto */
>>>>      int amdgpu_num_kcq = -1;
>>>>      
>>>> +static void amdgpu_drv_delayed_reset_work_handler(struct
>>>> +work_struct *work);
>>>> +
>>>>      struct amdgpu_mgpu_info mgpu_info = {
>>>>      	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
>>>> +	.delayed_reset_work = __DELAYED_WORK_INITIALIZER(
>>>> +			mgpu_info.delayed_reset_work,
>>>> +			amdgpu_drv_delayed_reset_work_handler, 0),
>>>>      };
>>>>      int amdgpu_ras_enable = -1;
>>>>      uint amdgpu_ras_mask = 0xffffffff; @@ -1297,6 +1303,71 @@ 
>>>> amdgpu_pci_shutdown(struct pci_dev *pdev)
>>>>      	adev->mp1_state = PP_MP1_STATE_NONE;
>>>>      }
>>>>      
>>>> +/**
>>>> + * amdgpu_drv_delayed_reset_work_handler - work handler for reset
>>>> + *
>>>> + * @work: work_struct.
>>>> + */
>>>> +static void amdgpu_drv_delayed_reset_work_handler(struct
>>>> +work_struct
>>>> +*work) {
>>>> +	struct list_head device_list;
>>>> +	struct amdgpu_device *adev;
>>>> +	int i, r;
>>>> +	bool need_full_reset = true;
>>>> +
>>>> +	mutex_lock(&mgpu_info.mutex);
>>>> +	if (mgpu_info.pending_reset == true) {
>>>> +		mutex_unlock(&mgpu_info.mutex);
>>>> +		return;
>>>> +	}
>>>> +	mgpu_info.pending_reset = true;
>>>> +	mutex_unlock(&mgpu_info.mutex);
>>>> +
>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>> +		r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
>>>
>>> Why amdgpu_device_pre_asic_reset is needed ?
>>>
>>>> +		if (r) {
>>>> +			dev_err(adev->dev, "GPU pre asic reset failed with err, %d for drm dev, %s ",
>>>> +				r, adev_to_drm(adev)->unique);
>>>> +		}
>>>> +		if (!queue_work(system_unbound_wq, &adev->xgmi_reset_work))
>>>> +			r = -EALREADY;
>>>
>>> amdgpu_do_asic_reset bellow will already schedule xgmi_reset_work for this device, what you could do instead is call amdgpu_do_asic_reset for each member of the hive and because there is a task barrier in amdgpu_device_xgmi_reset_func, it will synchronize all the resets to same point in time already.
>>>
>>>> +	}
>>>> +	msleep(100);
>>>
>>> What's the 100ms is wiating for ?
>>>
>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>> +		adev->gmc.xgmi.pending_reset = false;
>>>> +		flush_work(&adev->xgmi_reset_work);
>>>> +	}
>>>> +
>>>> +	msleep(100);
>>>
>>> Same as above
>>>
>>>> +	/* reset function will rebuild the xgmi hive info , clear it now */
>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>>> +		amdgpu_xgmi_remove_device(mgpu_info.gpu_ins[i].adev);
>>>> +
>>>> +	INIT_LIST_HEAD(&device_list);
>>>> +
>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++)
>>>> +		list_add_tail(&mgpu_info.gpu_ins[i].adev->reset_list,
>>>> +&device_list);
>>>> +
>>>> +	/* unregister the GPU first, reset function will add them back */
>>>> +	list_for_each_entry(adev, &device_list, reset_list)
>>>> +		amdgpu_unregister_gpu_instance(adev);
>>>> +
>>>> +	r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>>>> +	if (r) {
>>>> +		DRM_ERROR("reinit gpus failure");
>>>> +		return;
>>>> +	}
>>>> +	for (i = 0; i < mgpu_info.num_dgpu; i++) {
>>>> +		adev = mgpu_info.gpu_ins[i].adev;
>>>> +		if (!adev->kfd.init_complete)
>>>> +			amdgpu_amdkfd_device_init(adev);
>>>> +		amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>>> +	}
>>>> +	return;
>>>> +}
>>>> +
>>>>      static int amdgpu_pmops_suspend(struct device *dev)
>>>>      {
>>>>      	struct drm_device *drm_dev = dev_get_drvdata(dev); diff --git 
>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> index aa0c83776ce0..8c71d84a2fbe 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>>> @@ -149,6 +149,7 @@ struct amdgpu_xgmi {
>>>>      	struct list_head head;
>>>>      	bool supported;
>>>>      	struct ras_common_if *ras_if;
>>>> +	bool pending_reset;
>>>>      };
>>>>      
>>>>      struct amdgpu_gmc {
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> index 659b385b27b5..b459ef755ea9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
>>>> @@ -492,7 +492,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>>      	if (!adev->gmc.xgmi.supported)
>>>>      		return 0;
>>>>      
>>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>      		ret = psp_xgmi_initialize(&adev->psp);
>>>>      		if (ret) {
>>>>      			dev_err(adev->dev,
>>>> @@ -538,7 +539,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device
>>>> *adev)
>>>>      
>>>>      	task_barrier_add_task(&hive->tb);
>>>>      
>>>> -	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>> +	if (!adev->gmc.xgmi.pending_reset &&
>>>> +	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
>>>>      		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>>>>      			/* update node list for other device in the hive */
>>>>      			if (tmp_adev != adev) {
>>>> @@ -567,7 +569,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>>>>      		}
>>>>      	}
>>>>      
>>>> -	if (!ret)
>>>> +	if (!ret && !adev->gmc.xgmi.pending_reset)
>>>>      		ret = amdgpu_xgmi_sysfs_add_dev_info(adev, hive);
>>>>      
>>>>      exit_unlock:
>>>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
>> t 
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CS
>> h
>> aoyun.Liu%40amd.com%7C73608bda6abd48a3047608d8e0e02e4f%7C3dd8961fe488
>> 4 
>> e608e11a82d994e183d%7C0%7C0%7C637506600750277165%7CUnknown%7CTWFpbGZs
>> b 
>> 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
>> % 
>> 7C1000&amp;sdata=2qASlLYQ08twP0Ud5EcisCsVlJ9WG0QJv5idbuhDe4o%3D&amp;r
>> e
>> served=0
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
