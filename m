Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69463C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED73610E5AE;
	Fri,  4 Feb 2022 18:56:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CD810E5AE
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKZnUv6HW3JSJvy3kFyoYmeYtUAZsgOZPBRo/QF64ns7S5F85CoGkU9VWN56LM/18MFYDHibqD++zhbtsQJvzDP652vP/xUBI5E68xO/VTnU89H3h47M+9C/bzn9EFOKwVK+IVcRbNWK4JI1pPXKZlmZFBra9JaS5HfY7QmjybB8h9M74OYml+q/jvEAkMuRVMR7iH2hBUsczerjV4kl2A8G3Ep3R4fyrhLZ2UeUng1k4Jmg4Jydr+VN0cV9yOeE4oi6jYCiUj2wNIfKXB6TZEoJ5Oyieeg4u0NkHkYH1kWZPemyjw7uMbcRvJv+Co0QVxy8VlO8V1Lv5W6kZpdceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpZVnTcRFjIUFbSskOLy8P703uKpc9EFo7Ru3CkIFGo=;
 b=C7RPsM3tWE+b8avRZSKR8DNK27iiW5xLK6Pdir0pTCO6Cf8d1wcJfhYfjV8doQurXebfGC+MZ9jIhe+nxlpXclUjn4SKPfFWW6jaRN1RuzNswGpZDQ4SQL6nOefrFWJaGs7AxNdHqw5+t+4MGRpOOJ7fFjdpC8H8yD5zOcbLeLPMb5LnuDyydNUI2P4ap57VoD90pPiBqP9qUfNPhbgBieLYqEgeFMLq96TM34rNBVs5QRUPEwfZOJddPAzzX5IRa+lxV7+qdkKMQwQtYr9uXneRn4YpwkYItS5sWwL8y6YWKRiJFuzHJnSN+pfvgCMR+NdprK4xnAfbXxAyVIO7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpZVnTcRFjIUFbSskOLy8P703uKpc9EFo7Ru3CkIFGo=;
 b=oN7wTHl8cXV+WJPKhxsvPN0XQKp333guZbI4Lmg81+i5OlYEmBA2Y60JQjomhfbx8ZQo1zZHC2WXX5ZfylAlCfnvXYQVBajXADN14+hYQrxv6FdUUQqYD5E3R9RlFP1/kj+YWztHDNsgRdl7ov+aErA9jk9Knwv7wUISNvgEl0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM5PR12MB1850.namprd12.prod.outlook.com (2603:10b6:3:108::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.14; Fri, 4 Feb 2022 18:56:33 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 18:56:32 +0000
Message-ID: <22d57dd6-8674-66be-84a2-45da4dab39d5@amd.com>
Date: Fri, 4 Feb 2022 13:56:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu: Set FRU bus for Aldebaran and Vega 20
Content-Language: en-CA
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220204184756.5387-1-luben.tuikov@amd.com>
 <CADnq5_OYjK2mgzzybgKTSM4XmizWjxBcG4a44NcDTqtMLY9y5w@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <CADnq5_OYjK2mgzzybgKTSM4XmizWjxBcG4a44NcDTqtMLY9y5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::29) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f16fe0a-95bd-4b41-6230-08d9e8100f4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1850:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB18500F6D39A62D41D9D3508499299@DM5PR12MB1850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIRKEY8QjNwiGhIz+54YLuPWGTUC2gTxcZEoD0a8twhaIr1O/+bxKpQuhfgJ8SCrHHTEFJW8Hta3fDnz6qcfWRJ94u1LNCrvs61gv9tCSGEmMhuH2HQI0Aua7QAaRtW1OJDCkErcBmj4Ms5N5fbZ5tg+ZClnYreCcC0pJ+tUV61knmjgQfFSsIHzDjrvIo/E3XlWFnDGiqdD9LlD7dF/FdXYwna0djGurTaCbhXhKWPBYX96qYcKFxaZsGckpDEwCze/YA4vlq8ZdHR8LXqqVvEjG3JS8Fjw3MBFBnn+/rk9p8LDM0PX/509nEBXltv25/2BlkFsH9NCDUE73Tra5+EDc02/HPk/9p9C5W16v04hZpea11uAB9cWi6PD2P/tYgUWcedN3fNDz7yyWCHNBieYN1ZOAa++c8KeyeARDOxgBthA1+AJXT2p9FspuQh1fM+3CEwNZ4cL5MXpqTIcDAG71iFzbsO3H7Ilrfi5GEhQw503gG+yfK/aBsjSs2AQDW/cG4LppHQ5zrWbqpjUZTEyI49+Ry6shwiRmq0Zx09EIqhkDVPYfiz+gAN9grtCIfzo/t+KF6AZniiIdihzZkzVgJXNAeK4ArfTMU6E2Zav1FY78kS4ljg9OtRgKh5FSLQQ7gqvWa6z+qnnNUAmI18j1CPt6XhImNGCMGK247SRYUkq/ebzn+PkDPRFP+t7svnsXRRopSbNa7Nk+F8D/RnrLZdylwdlW06PODcq+LQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6916009)(66476007)(38100700002)(44832011)(316002)(66556008)(6666004)(54906003)(36756003)(86362001)(4326008)(186003)(2616005)(8676002)(66946007)(508600001)(26005)(5660300002)(83380400001)(2906002)(6506007)(6512007)(53546011)(31696002)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNUWjI4MWl2TzdkTXpZTmRsd3M4ZjQ3VHNNeTJTdEVjM3dMWFJXekVJbmV3?=
 =?utf-8?B?Z0NXOEZtWEU0bi9pUkJqWkl6aGpuTnlCWjFNSHdPd0ZqV29yMG9VUnNESGUx?=
 =?utf-8?B?SDBoSGw0dFNQY1B0QTNMb240akxDNnZNdWNRSHBvdW85UGNIdlh0OUhNRkR3?=
 =?utf-8?B?TVAxSWFlTlk1bGNVUGZleEtRUW1GQmhUT1BIK0NpaGRRMGxqenhyNEV6NHcx?=
 =?utf-8?B?QzB1d3pWalNiVGFrOTRoMGRJVkVpcXNza3FCMC9VR1ZNMUdpQUhzL2xhRVc3?=
 =?utf-8?B?RUJDSURJNzRCQlU2aGh1OEc1SkZQckZnbVJKL0h5RmRlRWtBUTdONUx6cUwv?=
 =?utf-8?B?M3NxUU5idC9mSjY3L2tjNS9oTll3QzJVV2VDNzBhTjg3Vk5raWtrNkdhNmN4?=
 =?utf-8?B?TUd0T000NHdYZ2F0VVNMREVQSjgzUGRIQlZKNkwxWEwxaGVxS3dCSEs5SUFK?=
 =?utf-8?B?UmMwbnBuNzFvYk93NlFZOGxvWnZZZmVWdStENDlzS3U0MW9MOFpYeVJSbFVs?=
 =?utf-8?B?cE9jSUNrMFVRUndIb2krb2JYWmxkUlQ5c0NMMHoyZzlUOTBIRzI0SjVkd0JY?=
 =?utf-8?B?UFA2ajREbzUvZlhGS2xVZWJKRW9aRkUxanpYZ0hFS0V0OEZXU3V3SlJLNTJ1?=
 =?utf-8?B?WDB4dk0ycGZVckJuVG5lVmpXY2JoWG5BN240WWI2K1FsdGk5UnhkeXQyTkt3?=
 =?utf-8?B?Q1NjeEFlU2NtTHhxcU9BMFJxWmhoRGc0cGlsUXB4dFBqTzBKQzJVbnAzVUtl?=
 =?utf-8?B?VGR3SjZPRGEwcVFYMVJTWTIvMW9uR0hweEs5cHYydUdld3dVcDAzbGc5ODdU?=
 =?utf-8?B?RW1OMThoTVpicXdhbzJMR0VVMUY5ZnJFNDJYTTZHdEtZdUpKR1NGa3drckpl?=
 =?utf-8?B?TjJObzNKdUNMQ2RYVG1NQXhORXZJSGd2Zmd6eFNqbUcvNkROK3NwUjBvMStu?=
 =?utf-8?B?ZFFZNmV1NS9rNHp4Z0I0MlNSMzJ5NFZLeUE1dXNHTEhWM0VNaXNrQkdSRzdE?=
 =?utf-8?B?UG1sSWhRZENTV0czVzluZGE1Q2hqQTQvVmx6ZmlZaUN3QW0vVis2V1V0b1Vs?=
 =?utf-8?B?ZDVrU0FnV0JMWGtpY01IWTJuaFk3L29GL0E0Y1hmVExYaFMrVlhnODZVbmdR?=
 =?utf-8?B?dzBvcmkzRVkvR1NwaTF4eDRqeEUxMUkyT0RidFZDbit6K3ZuQXBFbSt3SHF2?=
 =?utf-8?B?UGVlUXF2T0MrdlYvRDNia2ZyRUN0c2QxWHYxMlhpWnorNG9HdmlFZzYzQ1Zw?=
 =?utf-8?B?V0d0eGNZeTkyaTROSmtPbHlGYWg0YnFqMUdhN0JNQXBZVFBrZ3R6czNWdWd6?=
 =?utf-8?B?bW1PRHdkYjQ5Nk9Na0RPS25NU2d0UEJJT2R4cTVDTDdrZmFOS0l6eG9zWUJr?=
 =?utf-8?B?cDBqTk1HUVJGc0huc2tMNkc0cWFwQlBVQm9BWlIvcXk0Y1I0L1p2ZmhwQWxx?=
 =?utf-8?B?Vlg0aEN6cVNmWllwMSs3bGUrQkptTGEwV0ZLdWVuV2M1Uml4NUw3R2YvMjFC?=
 =?utf-8?B?aEFzRjU1a0RJMDRoaWJMZ3F6dWx6VUxNQUtwK3hEY2FJM3FxNDhDc3VFTGpI?=
 =?utf-8?B?NkxtRVNacjRTcDFDa01qU1J3TVI5Nng5SUYvZ1V1QkZKWEF2Y2gySjQ5cmVx?=
 =?utf-8?B?MzlsajYvdjRFTWE5bnVpUElmRjh3VGdnUkNLNmdPejFwNUxBV29GUXE5RnV6?=
 =?utf-8?B?TVpMZUl3L25HZHNGK3U2YmsxR2NNSU1ObFFTUzBXMzFzY3paRDhZWjlxN2cw?=
 =?utf-8?B?OG5OSkVENXZGMWxPTGNHQXJXOEtyNWhUSFRpbUxzUEc0cVl4TTlSZTJiU00v?=
 =?utf-8?B?SFlLU1gxRDl6R2RxVSt3cWFoNDUrbmhBcVppSmw5cm5oZDZpNmVTWVZhYmp3?=
 =?utf-8?B?V25DclJYSnNlM3BRRVRXVW1tYzQ4MnhaeVg4akZhM2lQVWJsTEdsVFpFVndN?=
 =?utf-8?B?WEZXRDU1T0VYemlwVm9HODFGUXVhdzQ2WG1RRWZHcVVXQVBCVTlYd2dNSm5G?=
 =?utf-8?B?MFBDQVdNUXQvZGdmNFlBV2NNcms5VVgrQ2M0b0xEM294VFU2MDRKZTVDTXJn?=
 =?utf-8?B?NVZCQ1FXdy9WWnY2bElGNW9kSzNXQmMvYlhQQjNWMERTeXl1QllrbUVZNFRC?=
 =?utf-8?Q?3G3M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f16fe0a-95bd-4b41-6230-08d9e8100f4f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:56:32.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04vfGVxfDls3DQe13e6pWKWS7HK7+bTwLiq9GwwyDfV+7ftcG+IZ0PYv067Qyxu3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1850
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Roy Sun <Roy.Sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-04 13:53, Alex Deucher wrote:
> On Fri, Feb 4, 2022 at 1:48 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>
>> The FRU and RAS EEPROMs share the same I2C bus on Aldebaran and Vega 20
>> ASICs. Set the FRU bus "pointer" to this single bus, as access to the FRU
>> is sought through that bus "pointer" and not through the RAS bus "pointer".
>>
>> Cc: Roy Sun <Roy.Sun@amd.com>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Fixes: 9c6d2ba7057abb ("drm/amd: Expose the FRU SMU I2C bus")
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 3 ++-
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 1 +
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> index 87acb089cfccd5..dd2d66090d2374 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
>> @@ -741,7 +741,7 @@ int smu_v11_0_i2c_control_init(struct amdgpu_device *adev)
>>         i2c_set_adapdata(control, smu_i2c);
>>
>>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
>> -       adev->pm.fru_eeprom_i2c_bus = NULL;
>> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
>>
>>         res = i2c_add_adapter(control);
>>         if (res)
>> @@ -756,6 +756,7 @@ void smu_v11_0_i2c_control_fini(struct amdgpu_device *adev)
>>
>>         i2c_del_adapter(control);
>>         adev->pm.ras_eeprom_i2c_bus = NULL;
>> +       adev->pm.fru_eeprom_i2c_bus = NULL;
>>  }
>>
>>  /*
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> index ba4c9771ffc56b..3d96d4af92d97f 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> @@ -1583,6 +1583,7 @@ static int aldebaran_i2c_control_init(struct smu_context *smu)
>>         }
>>
>>         adev->pm.ras_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
>> +       adev->pm.fru_eeprom_i2c_bus = &adev->pm.smu_i2c[0].adapter;
> 
> Does this need to be set to NULL in control_fini() for consistency?
> Other than that, looks good to me.

It already is--I didn't need to add it as I did above for Vega20.

Regards,
Luben

> 
> Alex
> 
> 
>>
>>         return 0;
>>  Out_err:
>>
>> base-commit: 24b54e10043609a55194badff58bf91189c49793
>> prerequisite-patch-id: d694f05bfcdf100c1d6957afa209e304dad98404
>> prerequisite-patch-id: b106a5bd7e0d3a7c225a767ca4384162353cca9a
>> prerequisite-patch-id: 77d04393fc872e4f4dd158659bd44ba40b749883
>> --
>> 2.35.0.3.gb23dac905b
>>

Regards,
-- 
Luben
