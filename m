Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C084C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 05:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51F710E138;
	Mon, 24 Jan 2022 05:03:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D2110E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 05:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBZ8yjH3mluuYuHdfeot1ownAcbcBk414isWxBsmY9izDxGTI/45maDlTsvBj7lsrr92RXXiNuVry7t/TnJXatD/MlcuECZbvpWvQauIPfxR6zQVRPNxy4CjKMgN2Vf+jWaRAL0JyNQ5bfiNpeJ+1y5LwN7g1AhCnKJtmiEh7ixRIOIORS7CnKZsTpTpZb0CnNh2BGNdE+Y5cfKSOqoQDaXxDUposb9KQKncZ04kBa59cG7Y5LKEDBFAuew2sAHov3YZd1xSATU11fRu/M6bIBFj/PwQAEg2cNZjhGrz71J7EBUM4dwc/6Gfxq1Uwv4l+3VpfTlqy04OMZVWg5cOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSv5xtA28LGJn9bJWxlqmH6yASxhcimlV1xwdPghwU8=;
 b=Td8Rjb5+SLnzuwFD2gLAq3cGobrIsezhcHW0YEZm4YdYs2YN5K5CzzXif15weZPjbfeAeAaRhCPqgaEuLsrHvBc28x7ZOtazmNH41UZxgDl0D+XU7WkD9AoUJ4X+4ifSJkL9Mter9d0xkJVVo+cQDc5ocG4BHdTH68USHVV0VFrf3ynni6+4aawKFo8bob8Cv5MXSLIAWOFW6yk2uOcxb88rDpJbwowugEtoWWylmPBizL/knAPWxKxrmDK+nBmT4MeKrD7egRaeptcBa1XURWgB5fRI7DagjaKyTEjhNPwudqE2DlPySDEXf/qOgS2J/bzbxYYJOi4ucVmNMllLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSv5xtA28LGJn9bJWxlqmH6yASxhcimlV1xwdPghwU8=;
 b=foZBf2TzzKfRaW2KvrirnhQzE2+rB4SqtpxrgM30u0wNPT3drsAZReQd5Z8hbgKSakrYVLlTdAhAHepvnwciMThvnFDMyh0mK1hGi5/VFBQ4azQaYBD+Yg4PQvLDNFoSB/VmcLumoqnQHa70jWQ51WBzDfQpOHxGUkaEzSVfAHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MWHPR1201MB0144.namprd12.prod.outlook.com (2603:10b6:301:5a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 05:03:02 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 05:03:02 +0000
Message-ID: <4f471b71-5933-37dd-e783-6d69f31ed9df@amd.com>
Date: Mon, 24 Jan 2022 10:32:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported' member of
 smu_feature structure
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220121074443.639392-1-evan.quan@amd.com>
 <20220121074443.639392-3-evan.quan@amd.com>
 <76e60a91-c398-3bf7-0e4d-f3c346a3bcf0@amd.com>
 <DM6PR12MB2619F672AD15F38B7AD65696E45B9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <3fd44721-724c-be87-8e38-9b0da1a46f17@amd.com>
 <DM6PR12MB26198AF97949776EAE9EC2C0E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26198AF97949776EAE9EC2C0E45E9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::14) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4913cc51-3294-4574-5ef3-08d9def6cc24
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0144:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0144F19A6B4192FB268FAAB5975E9@MWHPR1201MB0144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sh7GWLM18+UfIvfZCeBnCg+MF5Dd6CLcj8Ehg7yC/Yt1D+dt2fMKPwVEyDb2OFx6RmCM1g8x6mD9jozQJOgkgV93RZkVghTqtjpc7YGETWTKRbEvL83ujcGKop9O083s3yHdxAmkN4NQqHV7CpNgWT0bXEg3j8HqBYEdOkC7VcnGDkbPpPNrqtnZYTf54FI/pD8UzxLjVAuzPoMeXRhZjTx/XYKqeqU2SBLte0DJjbFyeie4c1YLs4lHTbwNeUGRFLXwynyUu46/VdGlg00W+J7bQEGSQCHmCZfg4/0hvR8Rte0meVG6FBmldVqoOlauyBBfM/qhFSMEemqHKqVn77CqK551lcjONkbWySjxjn262Apb+bjN6Dwlk0qOt0toBBwhDsIpXq6hnNncH4SsKJPC3/B5nHmubXqihZ8J3ibSehDidhh8unL4Bau0chycTGypT2id/vXlAOjbTHx7ZhgOv/otWxjnfx1i2YxZAQsc3OI7AxocwTXtjIeDuzbTP/quwn7HkP2BuMuWfWQHbU807fix2ISqg7uH+fb9HvOF47f5/CkyMCyuYQvCWAJAvHIXB9wt27RG3B0LUlVobz0VFyvTGSkgAFAe2TLAPJIg/JvoPup5oZN0IUoRiBYny0IkPuqw+EMlkUOOQJixYUqUkNzEPYs5SpI5MaGeFktVmzzGd3G/oS7vQNuBPbp5CbMA1vFLOesg4UhAAjkdnSdQNdlnHWX5WhkRVqAyOUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(6486002)(8676002)(508600001)(83380400001)(38100700002)(186003)(30864003)(31686004)(26005)(86362001)(53546011)(2616005)(66476007)(4326008)(66946007)(36756003)(316002)(5660300002)(66556008)(31696002)(54906003)(110136005)(6512007)(6506007)(6666004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1hXOUZMZ0diUDlzcmVlc3hnNk82SitKbW14NVRtQVM2NkVLMGxHVUUwc1cv?=
 =?utf-8?B?bWl3bmFXd2xtYVBvQTZ2Yjk0L3BIMlluRlpza01vUzkvZVJwdG5ScVp3b25F?=
 =?utf-8?B?Y0JxTUxNeHkwNUpxMEZpY1J3TlIydXZHWVplOU9ZZjY5TG5CZVdkWUZoOXAx?=
 =?utf-8?B?WUprMEJ0QzN0OUJ2M0R2Y2pyUzFOaHBnQzhFZnZLK3FlbEhacEJJY2RBYUhr?=
 =?utf-8?B?M0hBaG9zNS8zU3Z1WXE3WDhndWJkcFl6dmVZMGN4aXdndmxzRVpvanhsQi9v?=
 =?utf-8?B?WEZMdk1NS1VoVjVhVGl6dTNFbVJuVm1KaXlMZ2xCN21JVDF0VERKeWRzd2pS?=
 =?utf-8?B?MlRTeXhmTEprckt3VnhQTlFJcmk5b3lzZkI0TTM0Y1c0UzczaFAxdWhBUzZ3?=
 =?utf-8?B?aGhQZVhzbG43QUt0UkkxU1FkZ3Yvbk9IUk1SZG0zU2hCamI4d0UwQUhxbXZP?=
 =?utf-8?B?NUpCc0pDSzA2N3RWK0hyVEtMT0xRU05QN1FQb2RRLzJTWTFRaHRRUEFHVE9U?=
 =?utf-8?B?KzNtZGJDdWxpM0htazdPaVZwR21laFlPRG0wZ2ZUL2oyTDdabisya3VFb0lq?=
 =?utf-8?B?djdVV3VxaVFiUTZSSk1mSUJCdHQ1VzE3RUswekp1bFpPcm5tcjNiVGxIMCtk?=
 =?utf-8?B?eTc1TllYQVU1ako4blZkaWJycmo4MWpadEFWMVlJOG5tZ0c1WnIydDlkalF5?=
 =?utf-8?B?NjNkTzg3a2ZWN21DQTZIckhLeklIcHg4SlFRWU9wYkIvK29ScHpZaFdxMlJ1?=
 =?utf-8?B?Z2hmOHJ2NGtsSndwVjNwMVNvZTROMDV6aURBc05qMkliY1N2c3FsOFo2clE0?=
 =?utf-8?B?R3JSSWo4ZThXeUlsb1ZVYnRKMnlXYWtTVGRBeFZoc0tlTnJVWS9Ba0VvRjdX?=
 =?utf-8?B?bDRXUDdzSUxTZDhWZ29neTJiVzdtNXV5bXlFNGZobFNKd0lxMGZCM2hSVngz?=
 =?utf-8?B?MEU0aDA5dVBvaTVXdnB4ODFQT2xDUEw2UGdDTDhWdVppS0d6NUtCRG9uZUxz?=
 =?utf-8?B?cXYxSk9HTnAyUU5GSm9QWjNlQ1pRN1dhRG1NRnNtM0dkQStXMkFjV0tScEI1?=
 =?utf-8?B?TmNPUUgzOUZaUDZNUE9hK1hRdCtNeDA0bEdYdkZIYmpHNnJGUnl2UTRGZmxv?=
 =?utf-8?B?cGpHdXM3TzRsSU0zM3hPUy9QbUJKU3ZBYlV0RFBONEtiZjdvL1ZYZ0RiU0tO?=
 =?utf-8?B?TVZhdTRQb0p3V1gydG13alV4eVBTWXNZVGVkUy92SEdXVWkzL1JPdm95TGVJ?=
 =?utf-8?B?Z3laalVScFJsK0pnaGlRL3Q4OHJlVlVNVDE0c3RZWkJSWmVYMlJoUThUZmtH?=
 =?utf-8?B?M2s3VUdnbGlaSmovQ3ZiU0JMbm1YaTkzVEV5cWlNK1R1ZXRuU2p0MkcwS0M4?=
 =?utf-8?B?RzFvOTMzZUdIUHZpaFZRRTZHdnkvTjBlKzRnUmJja3gwT1Brc1ZLdkNtUTlr?=
 =?utf-8?B?azNrSkE3dlVwNnowSlZvYUdiSUp0Vk5yY2FWc0JpMVplMnB0RUNQTXdRN0ZR?=
 =?utf-8?B?Y1N1OVZtcFRQaXJCZVV1aFhNNytlcUxJTFQ5NEdCQWNTRHJ0dDRYMFZzK3RB?=
 =?utf-8?B?akQ4YW83bzB5dFZtaXJQOG9Ma1NuRzI3VFdCdkE1c0g5TEQrcUJpelg5WHM5?=
 =?utf-8?B?REljaHVLanhpaGlSZGtpRE9vT2svQjV4UVZzcHBoOCs3OVdURFErTk40MkhV?=
 =?utf-8?B?U1pyNko1OXNsdjh6dTZTbW9Vdkd5dzFpR2lxckYvQzJzZnZlMzF6c3A1ckVi?=
 =?utf-8?B?bjFCU0ZWS2YwRGpOakQydU8wMWtzYk1xSDlGNG9nNU14R2JXTHZtWVpJa3FR?=
 =?utf-8?B?bkx0K2thRWJtSzJHc1cyczd5NEtzNWZ5aEw3azhxNjF2UitmMFhMOFJhNURR?=
 =?utf-8?B?L1dDVVhqUzFLUStsWHdKYno1RjEzaWFjMnp0WUtnbXhaYlFtdGttL0pVc2FF?=
 =?utf-8?B?QnMzaHpPNTljVkY2SUx3d1BzVXNNZjliKzBUWC9pZGZTN1NkMjkvK1NYMFZQ?=
 =?utf-8?B?ZzYzNUEwd1BPdk42VEJuRDhQZDJ5aTZVT2hVYmlKcDZyZjBIVTJKQUhtZUk5?=
 =?utf-8?B?NWVadVd0SmNPVVFLUzQ5NWVIWFd0aWtxMUlTUS9oVWt3MmFJSGhTbXVWWWJ5?=
 =?utf-8?Q?NSmw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4913cc51-3294-4574-5ef3-08d9def6cc24
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 05:03:02.2892 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1noeWS/sGiMOJ0xrMTfutrr8joqJrI5vrio4E3bmWm6ive+IVxO2LXxE4zvF5Zzt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0144
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 9:51 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, January 21, 2022 5:37 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>> <Guchun.Chen@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported'
>> member of smu_feature structure
>>
>>
>>
>> On 1/21/2022 2:56 PM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Friday, January 21, 2022 4:52 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Guchun
>>>> <Guchun.Chen@amd.com>; Huang, Ray <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH 3/7] drm/amd/pm: drop the redundant 'supported'
>>>> member of smu_feature structure
>>>>
>>>>
>>>>
>>>> On 1/21/2022 1:14 PM, Evan Quan wrote:
>>>>> As it has exactly the same value as the 'enabled' member and also do
>>>>> the same thing.
>>>>>
>>>>
>>>> I believe the original intention is different. We need to cache the
>>>> features which are really supported by PMFW on that device on init.
>>>> When a request comes through sysfs node for enable/disable of a
>>>> feature, we should check against this and disallow those which are not
>> supported.
>>> [Quan, Evan] Uh, I doubt it was designed with such intention. As if it was,
>> there should be checks in ->get_allowed_feature_mask(e.g.
>> navi10_get_allowed_feature_mask) whether driver tries to enable/disable
>> different features from PMFW.
>>> " When a request comes through sysfs node for enable/disable of a
>> feature" If the sysfs node mentioned is "pp_features", I might be able to
>> provide some insights why there is no such checks added when I made them.
>> Considering there may be some dependency between those dpm
>> features(e.g. gfx ulv depends on gfx dpm), we actually cannot guard user
>> whether their settings will succeed. E.g. If PMFW supports both GFX ULV and
>> DPM but user wants ULV only, the checks against pmfw supported features
>> seem fine. But actually that cannot work due to the dependency between
>> them. So, instead of applying some checks which actually cannot guard
>> anything, we just let user take the risks.
>>>
>>
>> Below is one example
>>
>>   > -	if (!smu_cmn_feature_is_supported(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>   > +	if (!smu_cmn_feature_is_enabled(smu,
>> SMU_FEATURE_FAN_CONTROL_BIT))
>>
>> Let's say user switched to manual mode, that time we disable fan control and
>> move to manual mode. Next time when user requests auto mode, we check
>> if fan control is originally supported on that platform and switch to auto.
>>
> [Quan, Evan] Logically yes. But in reality I assume this should not happen. As during our post-silicon bringup,
> we enable those features(and corresponding sysfs interfaces)support only after verified. It means if the feature(auto fan control)
> is not supported, the sysfs interface should be not visible to user.

Well, there are multiple examples -

                         amdgpu_asic_update_umd_stable_pstate(smu->adev, 
false);
                         smu_deep_sleep_control(smu, true);
                         smu_gfx_ulv_control(smu, true);
                         smu_gpo_control(smu, true);

This is yet another one. Some aspects are disabled while umd profiling 
and then they are enabled back when it's back to FW control. This is 
internal logic and it could be disastrous if we try to enable a feature 
without checking if it's really supported on production SKUs.

>> Either way, we should cache the features which are originally supported on
>> the platform (through a combination of PPTable features and allowed
>> feature masks on ASICs which are applicable) and disallow anything outside
>> of that.
> [Quan, Evan] Although I doubt the necessity of such cache. But I do keep a structure member "feature->allowed" which does the similar job.
> It may be more reasonable to expand its scope to handle the job described here.
> 

It would be needed for both internal and external interfaces, I strongly 
suggest to keep it. The name 'supported' is more intuitive and 'allowed 
feature' concept from PMFW is not there for all ASICs, though I don't 
mind the name anyway.

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> Change-Id: I07c9a5ac5290cd0d88a40ce1768d393156419b5a
>>>>> ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
>>>>>     drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  8 ++++----
>>>>>     .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 10 +++++-----
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++++++---
>> ----
>>>> ----
>>>>>     .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |  5 +----
>>>>>     .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +----
>>>>>     .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |  3 ---
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 17 -----------------
>>>>>     drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  3 ---
>>>>>     10 files changed, 19 insertions(+), 53 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> index 5ace30434e60..d3237b89f2c5 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>> @@ -949,7 +949,6 @@ static int smu_sw_init(void *handle)
>>>>>
>>>>>     	smu->pool_size = adev->pm.smu_prv_buffer_size;
>>>>>     	smu->smu_feature.feature_num = SMU_FEATURE_MAX;
>>>>> -	bitmap_zero(smu->smu_feature.supported, SMU_FEATURE_MAX);
>>>>>     	bitmap_zero(smu->smu_feature.enabled, SMU_FEATURE_MAX);
>>>>>     	bitmap_zero(smu->smu_feature.allowed, SMU_FEATURE_MAX);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> index 18f24db7d202..3c0360772822 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>>>> @@ -388,7 +388,6 @@ struct smu_power_context {
>>>>>     struct smu_feature
>>>>>     {
>>>>>     	uint32_t feature_num;
>>>>> -	DECLARE_BITMAP(supported, SMU_FEATURE_MAX);
>>>>>     	DECLARE_BITMAP(allowed, SMU_FEATURE_MAX);
>>>>>     	DECLARE_BITMAP(enabled, SMU_FEATURE_MAX);
>>>>>     };
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> index 84834c24a7e9..9fb290f9aaeb 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>>>>> @@ -1625,8 +1625,8 @@ static int
>>>>> navi10_display_config_changed(struct
>>>> smu_context *smu)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
>>>>> -	    smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>>>> -	    smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>>> +	    smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>>>> +	    smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>>>     		ret = smu_cmn_send_smc_msg_with_param(smu,
>>>> SMU_MSG_NumOfDisplays,
>>>>>     						  smu->display_config-
>>>>> num_display,
>>>>>     						  NULL);
>>>>> @@ -1864,13 +1864,13 @@ static int
>>>> navi10_notify_smc_display_config(struct smu_context *smu)
>>>>>     	min_clocks.dcef_clock_in_sr = smu->display_config-
>>>>> min_dcef_deep_sleep_set_clk;
>>>>>     	min_clocks.memory_clock = smu->display_config-
>>>>> min_mem_set_clock;
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>>>     		clock_req.clock_type = amd_pp_dcef_clock;
>>>>>     		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>>>>>
>>>>>     		ret = smu_v11_0_display_clock_voltage_request(smu,
>>>> &clock_req);
>>>>>     		if (!ret) {
>>>>> -			if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>>> +			if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>>>     				ret =
>>>> smu_cmn_send_smc_msg_with_param(smu,
>>>>>
>>>> SMU_MSG_SetMinDeepSleepDcefclk,
>>>>>
>>>> min_clocks.dcef_clock_in_sr/100, diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> index 651fe748e423..d568d6137a00 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> @@ -1281,8 +1281,8 @@ static int
>>>> sienna_cichlid_display_config_changed(struct smu_context *smu)
>>>>>     	int ret = 0;
>>>>>
>>>>>     	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
>>>>> -	    smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>>>> -	    smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>>> +	    smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT) &&
>>>>> +	    smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_SOCCLK_BIT)) {
>>>>>     #if 0
>>>>>     		ret = smu_cmn_send_smc_msg_with_param(smu,
>>>> SMU_MSG_NumOfDisplays,
>>>>>     						  smu->display_config-
>>>>> num_display, @@ -1521,13 +1521,13 @@ static int
>>>>> sienna_cichlid_notify_smc_display_config(struct smu_context
>>>> *smu)
>>>>>     	min_clocks.dcef_clock_in_sr = smu->display_config-
>>>>> min_dcef_deep_sleep_set_clk;
>>>>>     	min_clocks.memory_clock = smu->display_config-
>>>>> min_mem_set_clock;
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_DCEFCLK_BIT)) {
>>>>>     		clock_req.clock_type = amd_pp_dcef_clock;
>>>>>     		clock_req.clock_freq_in_khz = min_clocks.dcef_clock * 10;
>>>>>
>>>>>     		ret = smu_v11_0_display_clock_voltage_request(smu,
>>>> &clock_req);
>>>>>     		if (!ret) {
>>>>> -			if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>>> +			if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_DCEFCLK_BIT)) {
>>>>>     				ret =
>>>> smu_cmn_send_smc_msg_with_param(smu,
>>>>>
>>>> SMU_MSG_SetMinDeepSleepDcefclk,
>>>>>
>>>> min_clocks.dcef_clock_in_sr/100, @@ -3752,7 +3752,7 @@
>>>>> static int sienna_cichlid_gpo_control(struct smu_context *smu,
>>>>>     	int ret = 0;
>>>>>
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_GFX_GPO_BIT)) {
>>>>>     		ret = smu_cmn_get_smc_version(smu, NULL,
>>>> &smu_version);
>>>>>     		if (ret)
>>>>>     			return ret;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> index b58a4c2823c2..b69c2ecc8e25 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>>>> @@ -808,7 +808,6 @@ int smu_v11_0_system_features_control(struct
>>>> smu_context *smu,
>>>>>     		return ret;
>>>>>
>>>>>     	bitmap_zero(feature->enabled, feature->feature_num);
>>>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>>>
>>>>>     	if (en) {
>>>>>     		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>>>> @@ -817,8
>>>>> +816,6 @@ int smu_v11_0_system_features_control(struct
>> smu_context
>>>>> *smu,
>>>>>
>>>>>     		bitmap_copy(feature->enabled, (unsigned long
>>>> *)&feature_mask,
>>>>>     			    feature->feature_num);
>>>>> -		bitmap_copy(feature->supported, (unsigned long
>>>> *)&feature_mask,
>>>>> -			    feature->feature_num);
>>>>>     	}
>>>>>
>>>>>     	return ret;
>>>>> @@ -1186,7 +1183,7 @@ smu_v11_0_auto_fan_control(struct
>>>> smu_context *smu, bool auto_fan_control)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>
>>>>> -	if (!smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>>> +	if (!smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>>>     		return 0;
>>>>>
>>>>>     	ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT,
>>>>> auto_fan_control); @@ -1607,7 +1604,7 @@ bool
>>>> smu_v11_0_baco_is_support(struct smu_context *smu)
>>>>>     		return false;
>>>>>
>>>>>     	/* Arcturus does not support this bit mask */
>>>>> -	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT)
>>>> &&
>>>>> +	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT)
>>>> &&
>>>>>     	   !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
>>>>>     		return false;
>>>>>
>>>>> @@ -2150,7 +2147,7 @@ int smu_v11_0_gfx_ulv_control(struct
>>>> smu_context *smu,
>>>>>     {
>>>>>     	int ret = 0;
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_GFX_ULV_BIT))
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_GFX_ULV_BIT))
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_GFX_ULV_BIT,
>>>>> enablement);
>>>>>
>>>>>     	return ret;
>>>>> @@ -2162,7 +2159,7 @@ int smu_v11_0_deep_sleep_control(struct
>>>> smu_context *smu,
>>>>>     	struct amdgpu_device *adev = smu->adev;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_GFXCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_GFXCLK_BIT)) {
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_DS_GFXCLK_BIT, enablement);
>>>>>     		if (ret) {
>>>>>     			dev_err(adev->dev, "Failed to %s GFXCLK DS!\n",
>>>> enablement ?
>>>>> "enable" : "disable"); @@ -2170,7 +2167,7 @@ int
>>>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_UCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_UCLK_BIT)) {
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_DS_UCLK_BIT, enablement);
>>>>>     		if (ret) {
>>>>>     			dev_err(adev->dev, "Failed to %s UCLK DS!\n",
>>>> enablement ?
>>>>> "enable" : "disable"); @@ -2178,7 +2175,7 @@ int
>>>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_FCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_FCLK_BIT)) {
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_DS_FCLK_BIT, enablement);
>>>>>     		if (ret) {
>>>>>     			dev_err(adev->dev, "Failed to %s FCLK DS!\n",
>>>> enablement ?
>>>>> "enable" : "disable"); @@ -2186,7 +2183,7 @@ int
>>>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_SOCCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_SOCCLK_BIT)) {
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_DS_SOCCLK_BIT, enablement);
>>>>>     		if (ret) {
>>>>>     			dev_err(adev->dev, "Failed to %s SOCCLK DS!\n",
>>>> enablement ?
>>>>> "enable" : "disable"); @@ -2194,7 +2191,7 @@ int
>>>> smu_v11_0_deep_sleep_control(struct smu_context *smu,
>>>>>     		}
>>>>>     	}
>>>>>
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DS_LCLK_BIT)) {
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DS_LCLK_BIT)) {
>>>>>     		ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_DS_LCLK_BIT, enablement);
>>>>>     		if (ret) {
>>>>>     			dev_err(adev->dev, "Failed to %s LCLK DS!\n",
>>>> enablement ?
>>>>> "enable" : "disable"); diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> index b4a3c9b8b54e..e72831aa4859 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>>>>> @@ -1960,7 +1960,6 @@ static int
>>>> vangogh_system_features_control(struct smu_context *smu, bool en)
>>>>>     						      RLC_STATUS_OFF, NULL);
>>>>>
>>>>>     	bitmap_zero(feature->enabled, feature->feature_num);
>>>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>>>
>>>>>     	if (!en)
>>>>>     		return ret;
>>>>> @@ -1971,8 +1970,6 @@ static int
>>>>> vangogh_system_features_control(struct smu_context *smu, bool en)
>>>>>
>>>>>     	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>>>>>     		    feature->feature_num);
>>>>> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
>>>>> -		    feature->feature_num);
>>>>>
>>>>>     	return 0;
>>>>>     }
>>>>> @@ -1989,7 +1986,7 @@ static int vangogh_post_smu_init(struct
>>>> smu_context *smu)
>>>>>     		adev->gfx.config.max_sh_per_se *
>>>>> adev->gfx.config.max_shader_engines;
>>>>>
>>>>>     	/* allow message will be sent after enable message on Vangogh*/
>>>>> -	if (smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>>>> +	if (smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_DPM_GFXCLK_BIT) &&
>>>>>     			(adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
>>>>>     		ret = smu_cmn_send_smc_msg(smu,
>>>> SMU_MSG_EnableGfxOff, NULL);
>>>>>     		if (ret) {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> index 1754a3720179..c5d354175675 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>>>> @@ -774,7 +774,6 @@ int smu_v13_0_system_features_control(struct
>>>> smu_context *smu,
>>>>>     		return ret;
>>>>>
>>>>>     	bitmap_zero(feature->enabled, feature->feature_num);
>>>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>>>
>>>>>     	if (en) {
>>>>>     		ret = smu_cmn_get_enabled_mask(smu, feature_mask, 2);
>>>> @@ -783,8
>>>>> +782,6 @@ int smu_v13_0_system_features_control(struct
>> smu_context
>>>>> *smu,
>>>>>
>>>>>     		bitmap_copy(feature->enabled, (unsigned long
>>>> *)&feature_mask,
>>>>>     			    feature->feature_num);
>>>>> -		bitmap_copy(feature->supported, (unsigned long
>>>> *)&feature_mask,
>>>>> -			    feature->feature_num);
>>>>>     	}
>>>>>
>>>>>     	return ret;
>>>>> @@ -1071,7 +1068,7 @@ smu_v13_0_auto_fan_control(struct
>>>> smu_context *smu, bool auto_fan_control)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>
>>>>> -	if (!smu_cmn_feature_is_supported(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>>> +	if (!smu_cmn_feature_is_enabled(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT))
>>>>>     		return 0;
>>>>>
>>>>>     	ret = smu_cmn_feature_set_enabled(smu,
>>>> SMU_FEATURE_FAN_CONTROL_BIT,
>>>>> auto_fan_control); diff --git
>>>>> a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> index f425827e2361..e9172622c0c4 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>>>>> @@ -204,7 +204,6 @@ static int
>>>> yellow_carp_system_features_control(struct smu_context *smu, bool en)
>>>>>     		ret = smu_cmn_send_smc_msg(smu,
>>>> SMU_MSG_PrepareMp1ForUnload,
>>>>> NULL);
>>>>>
>>>>>     	bitmap_zero(feature->enabled, feature->feature_num);
>>>>> -	bitmap_zero(feature->supported, feature->feature_num);
>>>>>
>>>>>     	if (!en)
>>>>>     		return ret;
>>>>> @@ -215,8 +214,6 @@ static int
>>>>> yellow_carp_system_features_control(struct smu_context *smu, bool
>>>>> en)
>>>>>
>>>>>     	bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
>>>>>     		    feature->feature_num);
>>>>> -	bitmap_copy(feature->supported, (unsigned long *)&feature_mask,
>>>>> -		    feature->feature_num);
>>>>>
>>>>>     	return 0;
>>>>>     }
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 50164ebed1cd..49bcabe9d708 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -476,23 +476,6 @@ int smu_cmn_to_asic_specific_index(struct
>>>> smu_context *smu,
>>>>>     	}
>>>>>     }
>>>>>
>>>>> -int smu_cmn_feature_is_supported(struct smu_context *smu,
>>>>> -				 enum smu_feature_mask mask)
>>>>> -{
>>>>> -	struct smu_feature *feature = &smu->smu_feature;
>>>>> -	int feature_id;
>>>>> -
>>>>> -	feature_id = smu_cmn_to_asic_specific_index(smu,
>>>>> -
>>>> CMN2ASIC_MAPPING_FEATURE,
>>>>> -						    mask);
>>>>> -	if (feature_id < 0)
>>>>> -		return 0;
>>>>> -
>>>>> -	WARN_ON(feature_id > feature->feature_num);
>>>>> -
>>>>> -	return test_bit(feature_id, feature->supported);
>>>>> -}
>>>>> -
>>>>>     int smu_cmn_feature_is_enabled(struct smu_context *smu,
>>>>>     			       enum smu_feature_mask mask)
>>>>>     {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> index 4e34c18c6063..19919182260a 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
>>>>> @@ -48,9 +48,6 @@ int smu_cmn_to_asic_specific_index(struct
>>>> smu_context *smu,
>>>>>     				   enum smu_cmn2asic_mapping_type type,
>>>>>     				   uint32_t index);
>>>>>
>>>>> -int smu_cmn_feature_is_supported(struct smu_context *smu,
>>>>> -				 enum smu_feature_mask mask);
>>>>> -
>>>>>     int smu_cmn_feature_is_enabled(struct smu_context *smu,
>>>>>     			       enum smu_feature_mask mask);
>>>>>
>>>>>
