Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789CCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 17:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DFAA10E324;
	Tue,  8 Mar 2022 17:17:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B583710E324
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 17:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILcfm0AOqi0kZ17i9AVF8m9Ll9sxZU5kxeqD4i8zQIG+yLoHQmB6LieP3BDUznYxT0ZpaJrpHjv8/dkbp+wLXZtXeQmJHi61zHFOvp5qJ/mmtERjYFtRMREHeTOQvGtZy9zX/yMD5q4j4k5S9cd6ePtsazZ2/4l1VIsAoEOenIob3Qzqzzbov1xPRQBDUDDtuuFXjSSRgx9jhyNLnEIRUmheDP3lGXRZ/bsQK/mJu6L1p5bgEdlh6cHMg+ZS3YGUC+TyltfdQ0zNfrVme+hB1tUKSqvGeT5m3gDlxdmxxyYpS2hQ0EL5L/FSuB/9AIMMLYkHAAWwrRVGl3Aj4TRuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJSApVrr/2cn+sWXlQTCFJbwAb4q/Hl/P1FtYZxIg+0=;
 b=Y1t1NqMYl4QvpEP8GSTwTUmL2tLeN1WDtfiE4/+GOAM6aN3Fyebft0gng5nuPUQZFswLJOe3XwpmPTBNFDeqGjqBRwlw5VO9k3FbMg715vCyPC1TlfVTG7IWPEejwtKokYNNzxxajM4OLdWN+KlpyOYFmh8sA5mJZ4bq+xNjm8/7AKVtbOtHfPJoK20fNqnB7uxnE1zDJ0+nLX2f3auLq5NYWnai1cn5qaqROFthmtkMA2xItCAI2dNMCCbhpjv/+FydUE2DZ9a5Af+T0NQQgssiJ7iPpMEt4pK4d+8/pOsdKVgvLz/p42MMZx01ffL+i+l39uwvpOJUBKJCx99J3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJSApVrr/2cn+sWXlQTCFJbwAb4q/Hl/P1FtYZxIg+0=;
 b=xHqjf1JXqwtdi2YQtr/MbZYk15wHPhKI8j9ltgVI5dM7V2jNnggmlTrPROGPsYm1evkZitK6m4zY5K1Eo0sK3p5oixAWq6ZRPPBp6D1Ye2SakIQ6T8wTUY/xNozLtY4DOEPxs1Nv+DxZp552Ej4bWtN75Y1BvaAbWEOQN3iNeDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:17:11 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:17:11 +0000
Message-ID: <d6cea9e7-3c3c-6fef-8f32-1cf953751e02@amd.com>
Date: Tue, 8 Mar 2022 12:17:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
 <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
 <975f7416-2f32-3207-c118-cdb56d2bae7c@amd.com>
 <11183b53-bd53-7afc-2fdf-f46183044dd2@amd.com>
 <a39197a1-a680-113e-b852-f481fe1e9bb2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <a39197a1-a680-113e-b852-f481fe1e9bb2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8ba1105-0148-4d8d-ceb7-08da01277b2b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4815:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB48159E318637B1400D956DC2EA099@MN2PR12MB4815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3rFKBIGoPI29s25jYVhkHmo6Vs5uEGRneuWEAXA/MOQhuWVbRtc1wAajzEUpJPS7F8xzUGulNpWhH3dolEHq1vVOo/rYDkp+W/eUoPbYXTD0Y+thFXXIUmLF37qXqhPULK6jqaVgF3l8oCSOgDIO8Mf9iIap5kH1LNfXlsuPUoFzeU+GPqMf7eWkigGUCw7Hk4mbzM6LnERzpo2XNCtaVSSAt1gEk18R+l4DtLuchyPf2EEvCKkN5cSLauMbZzDS1Xvj4WpQMTsV02rRURse3yqBW+Ti2KDat7OrYB63l9bNSBzsQSLX9rm2DexAptUyQ+j7P5IoTPJTjvDk6CDGqB4aUZBqHpFdDH0WuggjPdM5IPJ0G6L5NQdV1cFp9/L69R4XI2h8dvT/BeFF1V/Xh2DGB4SvLiuFLtYYoCTVigbv8YKiN/tUgV2uw7zECbRC7aurQrwqodindiitRnKfBTncL94EO5eaig77lU/78w+I2aNiFTDkjp1JubPoR6JzM7Uv9onmkFcJnD3l65a7GUpppkdczrTYZtX5obGLE/JCy7GgExlR5I8JeOSHGFZvWu2w54SGhm96kaLp/qyv/X8bQZNlcAYA77/L1d1BIXMf3/w/HdB9sfBo8kJ9MOHON4Cv2YSb2CaHY28/e5k2wsVHni5uF8OAWjRqvQcve7/Xsm/DfPlCI0D91J9o+q3vmKdTABgsfhr+Lsxynsw6KuLAa6/+kX6pxTIPxm0nhpFv2rkeZwmMbgXY1RyCu73Cje99uyN5yc+eDRKVZvZhBPa0qZOmRJd6NeIR05BIeAOs2AMjgS7KxeODs4iA/iDdKe5oQ2L1yQJanwkP7WD3pbIXZjkg2rrfzit7l59TI0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(16799955002)(5660300002)(186003)(8936002)(2616005)(110136005)(316002)(54906003)(8676002)(4326008)(86362001)(66946007)(66476007)(66556008)(31696002)(6512007)(83380400001)(45080400002)(6666004)(31686004)(44832011)(966005)(6486002)(6506007)(508600001)(2906002)(53546011)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ppU0xnUkc1MmR1YkV2Z2FEOVVSdmNDSlVBVG8rbjNrb2djWHlsek92K01Z?=
 =?utf-8?B?Rzh6aWlNd3ZKRUhFQTJJWkFVSXptd053SWc1RFVndHVBVmRpN1hSTnlQTkRm?=
 =?utf-8?B?MElwOTRJQUpLNWNPeUZUQmJDdmV4WTNlcTRrNHJNWWM5NEl6STRGanB0UGg0?=
 =?utf-8?B?L3VqZmpIY3NaQUphaFpldG1kZjNvU1BBM1FzbFdhZCtPVWZDZXVBRlpiY1BH?=
 =?utf-8?B?cXZ1ckpNZkp2ZWQrcW01SkhXOFpEUUxSY2FaV3hrVVRXcHprSmRBdDMyS2x5?=
 =?utf-8?B?SHZ3eU1PZTZUMDQxWE9QT3JFOUFpSllKeGx5YW5aQnhaNEhPMjZzU2NtSGlM?=
 =?utf-8?B?V3pEUzErN3ljNFFZRzc5K3p6ZEpHV0V2cTBYMUlHRm11cVVwZjRYNS96OStB?=
 =?utf-8?B?TG9OMnBtZEVIbG1sS0xNR0lpVkNaMGZkZitJVFVSZW91UjRFRW5Vc0RjQlpL?=
 =?utf-8?B?YUZQWG03RnhmczBhQUdZSUFGMlptRXlGZVU1dzlqWVZ4azBucFEyV2w1S2Zu?=
 =?utf-8?B?UTU3RHkrbE9lRkFZWE5oOThlU2l6dkxmSkNEcE4yYXhJVHkxL2xSRGl2a2lD?=
 =?utf-8?B?R21NL1oxcUtqZy81dE9tZXpRK0FQeVp0cGhCMDVUditCNjhrYjNrbHYvUjVX?=
 =?utf-8?B?MjJqRmcxbjRSYk4vMVZXc1VydFZ1bEI2Z3ozRUhtbVJoWS80Qlc3SnVaNFdQ?=
 =?utf-8?B?QUZCdkx2TUc4VkFsVG5jN2NTM3ZwMTVMKzE5RUVlcGx3dFZlcTJCZVR3d3Jm?=
 =?utf-8?B?VjlWenMyRkFWV0tiNkJicWZuM283UHBNamV3TUNxRU9DZ2FkZTNmNVBWNnRG?=
 =?utf-8?B?RmtUcVhyMktHUUVMVEtzeFpnQnBYVldwTThPYnV0VzVqcEEzeEwzdFhuZ1Np?=
 =?utf-8?B?VWpUUUJhMWt6MThtQk5HN05haEtWRW50UjkweTB4ekl0ZmFZUEp4MVpsbmxp?=
 =?utf-8?B?UmdPNENXNWozMWpsUVgyOEcvQ0htdHl3dS9yeFA1TitBU0tGVklJc3Q1NzlQ?=
 =?utf-8?B?a21pMnVpeVF4aHM0ZEZwUFJQTnJGbVdCRTZjc1R4dXBaWFd2V29veVoxdW9H?=
 =?utf-8?B?cmtYVmgraCtmcHo4OFl2MWtPaFRyeVpYdEljTFhWNEJsdEZrY29qdnRSMUFx?=
 =?utf-8?B?RjJsbjlvbVQ3cTJ3aXE3elQ4aXVWZ0tNLzBsK1JyUzhFUGplZFBSTkdKQzNM?=
 =?utf-8?B?S3F2UVpBWTNNdDRRTFhEV3BiQnpmWGNOUE8zMDJNb3JGVTZGajJzUHpONktj?=
 =?utf-8?B?ZU5PUkdDWDBpdXcyNks2V0lJTmp2Q0VqU1NyaHI4SlAzd3NlWmI3UUl4VXRu?=
 =?utf-8?B?VU56RktVVHVRMTVsVU93ZldwSExURWtYQTVRRHdZTjl3ZTllaEY2alc2elRy?=
 =?utf-8?B?M2hFVHJwNFhNcitMbEdIeTdWSTRzbXdJS2lCS00yU2NtK05jaEJoRWtOUUo2?=
 =?utf-8?B?QmxURStNZ0QwWSsrbUhlVUhsamkwWjN3bWhiMEVISk5XM3FiNk4wOERVTHpV?=
 =?utf-8?B?YVRHVkJPdkdOcXFlVmEwR0QwZjVWS0VXUlMzMWpiVFRBQW9EZ25UY0EvZ096?=
 =?utf-8?B?MlRlU0sxa2U3T3lTcHZGd0Q5d25aaUVmMTBlL0RSTkR0K1hqbDJ4ZWNKMXFu?=
 =?utf-8?B?ZVlrbTdZWG9YK2h4dklsTjlsSnNhY0tyMklybStiUVFyZ0FwUWZwVnVnbFJq?=
 =?utf-8?B?UDRKYzlxcGpmU1I2S1dFRDY2Yno5VXNZT0g3a1JuTk5heEFVdUsrdVMzQ1hu?=
 =?utf-8?B?aWl3TlFBOHZWM2lESHVtWXdrbGZVNG1tcjg3T1pLUjRCSFFWS1lmRm5PMU5Z?=
 =?utf-8?B?VjJnRC9HcFRwb2l5M2NTR0ZVTlgvUWI3VTBxZmY1eHhsM095a1JSdVVyam1y?=
 =?utf-8?B?TE1uYlV2d3d3WXA4djRWVjFHTlhqa1ZydkZ3Qk4xUGpNSm0xeUlmd2wrc2Jy?=
 =?utf-8?B?MllZY3JKc1cyN25YMEF3a2RLYkEySzlLTUtZNTgvWHphYklyVWk1ZFZWV3E0?=
 =?utf-8?B?Rk9UQjdOWllMSE1wWkIxTkc5dVdCVWRTRWl3dzB2WW5QVjZHUjltMVlTbHhE?=
 =?utf-8?B?cUFRYUtEUExscy9PNXlkODRETnFVMXduTHpTWnJEZkVOcDVPV3JlelZYMFRR?=
 =?utf-8?B?dWNDR1FMRWtzcGNxL1JuWWc4Ym41YmZhOUtleCtKa1pNaFZBUGpydjZBazVW?=
 =?utf-8?B?OWhsQ3dKemVvZ05PaFY4a3BLM1haMTRaQzI4OEVqS2Q1TTNpTVg1WGdVT2pR?=
 =?utf-8?Q?lWOhD7Yeer6SNgtt5BE/Bmhda+1zIWAbtNxOMkr5VY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ba1105-0148-4d8d-ceb7-08da01277b2b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:17:10.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aWeuV00FHjYn202BdtgGUPiaZS5/wpVtub1c45yqJcnuH1FWI1Gkj6+SHUDdo8+AhlyOyGaXsF68JY+CFd3Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-08 12:04, Somalapuram, Amaranath wrote:
>
> On 3/8/2022 10:27 PM, Sharma, Shashank wrote:
>>
>>
>> On 3/8/2022 5:55 PM, Andrey Grodzovsky wrote:
>>> You can read on their side here - 
>>> https://www.phoronix.com/scan.php?page=news_item&px=AMD-STB-Linux-5.17 
>>> and see their patch. THey don't have as clean
>>> interface as we do to retrieve the buffer and currently it's 
>>> hard-coded for debugfs dump but it looks like pretty straight 
>>> forward to expose their buffer to external
>>> client like amdgpu.
>>
> Customer requirement is to get reset notification for there daemon 
> with other info (like PID process name vram status).


In general when a failure happens we want to have all debug info 
possible to have better ability to root cause the problem. Since this is 
an open forum I am not sure how
much i can disclose about the data in the buffer but i guarantee you it 
is very useful for debugging GPU hang causes.

Andrey


>
> Regards,
> S.Amarnath
>> Noted, thanks for the pointer.
>> - Shashank
>>>
>>> Andrey
>>>
>>> On 2022-03-08 11:46, Sharma, Shashank wrote:
>>>> I have a very limited understanding of PMC driver and its 
>>>> interfaces, so I would just go ahead and rely on Andrey's 
>>>> judgement/recommendation on this :)
>>>>
>>>> - Shashank
>>>>
>>>> On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
>>>>> As long as PMC driver provides clear interface to retrieve the 
>>>>> info there should be no issue to call either amdgpu interface or 
>>>>> PMC interface using IS_APU (or something alike in the code)
>>>>> We probably should add a wrapper function around this logic in 
>>>>> amdgpu.
>>>>>
>>>>> Andrey
>>>>>
>>>>> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>>>>>
>>>>>> [AMD Official Use Only]
>>>>>>
>>>>>>
>>>>>> +Mario
>>>>>>
>>>>>> I guess that means the functionality needs to be present in 
>>>>>> amdgpu for APUs also. Presently, this is taken care by PMC driver 
>>>>>> for APUs.
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>> ------------------------------------------------------------------------ 
>>>>>>
>>>>>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf 
>>>>>> of Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>>>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>>>>>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>>>>>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>>>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; 
>>>>>> Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, 
>>>>>> Christian <Christian.Koenig@amd.com>; Sharma, Shashank 
>>>>>> <Shashank.Sharma@amd.com>
>>>>>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>>>>>
>>>>>> On 2022-03-07 11:26, Shashank Sharma wrote:
>>>>>> > From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> >
>>>>>> > This patch adds a new sysfs event, which will indicate
>>>>>> > the userland about a GPU reset, and can also provide
>>>>>> > some information like:
>>>>>> > - which PID was involved in the GPU reset
>>>>>> > - what was the GPU status (using flags)
>>>>>> >
>>>>>> > This patch also introduces the first flag of the flags
>>>>>> > bitmap, which can be appended as and when required.
>>>>>>
>>>>>>
>>>>>> I am reminding again about another important piece of info which 
>>>>>> you can add
>>>>>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>>>>>> specific but
>>>>>> from what I see there is no problem to just amend it as part of 
>>>>>> envp[]
>>>>>> initialization.
>>>>>> bellow.
>>>>>>
>>>>>> The interface to get the buffer is smu_stb_collect_info and usage 
>>>>>> can be
>>>>>> seen from
>>>>>> frebugfs interface in smu_stb_debugfs_open
>>>>>>
>>>>>> [1] - 
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>>>>>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0> 
>>>>>>
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>>
>>>>>> >
>>>>>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>>> > Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> > ---
>>>>>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>> >   include/drm/drm_sysfs.h     |  3 +++
>>>>>> >   2 files changed, 27 insertions(+)
>>>>>> >
>>>>>> > diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>>> > index 430e00b16eec..52a015161431 100644
>>>>>> > --- a/drivers/gpu/drm/drm_sysfs.c
>>>>>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>>> drm_device *dev)
>>>>>> >   }
>>>>>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>>> >
>>>>>> > +/**
>>>>>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate 
>>>>>> GPU reset
>>>>>> > + * @dev: DRM device
>>>>>> > + * @pid: The process ID involve with the reset
>>>>>> > + * @flags: Any other information about the GPU status
>>>>>> > + *
>>>>>> > + * Send a uevent for the DRM device specified by @dev. This 
>>>>>> indicates
>>>>>> > + * user that a GPU reset has occurred, so that the interested 
>>>>>> client
>>>>>> > + * can take any recovery or profiling measure, when required.
>>>>>> > + */
>>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>>> pid, uint32_t flags)
>>>>>> > +{
>>>>>> > +     unsigned char pid_str[21], flags_str[15];
>>>>>> > +     unsigned char reset_str[] = "RESET=1";
>>>>>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>>> > +
>>>>>> > +     DRM_DEBUG("generating reset event\n");
>>>>>> > +
>>>>>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", 
>>>>>> flags);
>>>>>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, 
>>>>>> envp);
>>>>>> > +}
>>>>>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>>> > +
>>>>>> >   /**
>>>>>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent 
>>>>>> for any connector
>>>>>> >    * change
>>>>>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>>> > index 6273cac44e47..63f00fe8054c 100644
>>>>>> > --- a/include/drm/drm_sysfs.h
>>>>>> > +++ b/include/drm/drm_sysfs.h
>>>>>> > @@ -2,6 +2,8 @@
>>>>>> >   #ifndef _DRM_SYSFS_H_
>>>>>> >   #define _DRM_SYSFS_H_
>>>>>> >
>>>>>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>>> > +
>>>>>> >   struct drm_device;
>>>>>> >   struct device;
>>>>>> >   struct drm_connector;
>>>>>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device 
>>>>>> *dev);
>>>>>> >   void drm_class_device_unregister(struct device *dev);
>>>>>> >
>>>>>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t 
>>>>>> pid, uint32_t reset_flags);
>>>>>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>>> *connector);
>>>>>> >   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>>> *connector,
>>>>>> >                                      struct drm_property 
>>>>>> *property);
