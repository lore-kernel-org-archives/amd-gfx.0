Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB576C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 05:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D10E6124C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 05:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D10E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E55A89CA0;
	Wed, 30 Jun 2021 05:27:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E777B89CA0
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 05:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUl0nj6P4PF4x5QD0d08IHNxdpCxNSs3/d9Z7Ih5La56M60QTiUbZ7WvkA7Rk+FXrrX4CoxRifzoH+PkAQlb/7EL6AnavXN4Avq75CO34LeIjcmgvzSM3uemv24bK5Kr4dPRyl8SDSR/hdYVxBFgyLhdaJiV/SoUvxNrZ4dAVRPdzg68Rg2eP7Kf1LCYQADw67azfjIozDlTxHl6ZXi00684j1xhiKjnteNRDw1kVBAr4QR44td1UT3KLYbmnV8Xwn9g5SGaFztaDfd8Tqc3/jkxzXz9MkGKzrF3eFaWzl2CheXDO+P9qaMuhHvjN2ZtbTGwinZhse66Oxehp1WkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr7MS9BdBMasdepnHFJFYTfIkdLIwCs7LLlnD3qKQ10=;
 b=jGFCblkEthYnUQ3geeEU01HCHRMCF25wmpYLVaQt+rz9BstZgwOW2HePGOAVDU3KKswjGoXiL1zumtKgFP3qG8u+JQFh5W7YSOihNV1iBJBhJbghFhucHrXq/myk5n4FtSY5kbbsRctZDlJpZzYcj8Dh4Uyd9ENI6V1e0REg8VOsqWipnKcrMzhgdjq9cIYAUw59jWWkb5r0plx6MpmPH3Pe6uIK9NEcTJhaBhVd7yKEpssK/FXK9ZEmQOHkzRXz/R1wwYRDq2jsgfAqPRyfcleYmNg01LgkOG6mx9YiT6qgrWfSNT8v+lhAtVl9o3r0uRCGFdWnBki518H77Q6H4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zr7MS9BdBMasdepnHFJFYTfIkdLIwCs7LLlnD3qKQ10=;
 b=je5+tZdAb9HYZfrx5H3hqaMMIAL140sOpWlN3dYRo296VF8yam83OBYvjIXJKMczIu7Zca4T73p2roygPEE2JsBGlXA7KjmgO6FJWTqLVMbdQuqYJD7EJtakirAAk3rGSDQA9Vl0qKZqk8jaffh87RPO7v1fMIR0DYV64YNHWo8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 05:27:48 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::240c:be22:4f42:8068%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 05:27:48 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data retrieving
 for Sienna Cichlid
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210625081203.978006-1-evan.quan@amd.com>
 <bcef032d-507b-e04c-efa8-1f63e4a48707@amd.com>
 <DM6PR12MB2619CF378B8CDD0856459A29E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
 <e1548530-f4be-d58d-e107-15c39935b812@amd.com>
 <DM6PR12MB2619A0EA3FAE7FBB3EDF2957E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <fff46430-e1ee-cfc5-3915-dde0d0656381@amd.com>
Date: Wed, 30 Jun 2021 10:57:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <DM6PR12MB2619A0EA3FAE7FBB3EDF2957E4019@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36)
 To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 SGXP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 05:27:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e234c60-ed97-4794-2cad-08d93b87cbcd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5313:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB531358BCFA3B6B517D4E18D397019@CH0PR12MB5313.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdtGrVbBffjLImN7i/zfuwL2lcDgnphqnc+zNBJ5U4F8uqwOtEoixhYGJXxJq6XczlwpMFEbWzikNs30GUVzbTEmUlavQN93OWYYN/FNa8/5zvSywtB1fGFT0MOo8QfuktH19gGW2CPrbw7VL+dGp3w+MG5DR5Tp/bIMr+EDsFQAiOvmKe2vQM/zkh0omSBAzG1xx6DpGKsoQIhVvmKaK3uFG2xtKHxBueZyuNBAaHl/tXem/YIK6nz9Eey8x9WUXR7S7GvNFxm5RTYlP2x/OphYDwP3lN4XBNG/JMnovbQJh7eRz2fOSfPkG7nCROG/0t8R3g8oxAYdz5I6uaKf6JLOBqzWT81Y0QvgveLOcQKfn3kKgByX0vmQ7GjAb7OFJTZE9mtu3ORBmMED78U/YELx5Q04pNSJBbN+hYBu08l3IqJ+c09tee7RCBk7cVMbthXoQmDH/1nRpXab/XHonsJzgr4ZO6/4uta/UOGtHudxOmOLL8+WXYO9chHG1eSvIqVedkvBeBPizQVbaqeootvVgOdMhpagQ9m4B01MnTdmM8GzC24S28vgvqqIyiTDhpmSUusy2uE9K+560nLbDL9kN4YGma4m/WULFLaNhDEtTKtV+nK4/HJz6fwrKYBc6gSuZFYTSHpN72vUWYfDBrveN2jktuDb4npB7yn+cY11Js2w2h5Gz5OYmkpk+3Rs5YIWYq3tMLrNO3LhGecyecyy1EetaZ41spnfyj9dqLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(86362001)(30864003)(6486002)(4326008)(8936002)(66476007)(15650500001)(83380400001)(66556008)(66946007)(36756003)(8676002)(5660300002)(186003)(478600001)(16526019)(110136005)(16576012)(316002)(26005)(53546011)(2616005)(956004)(19627235002)(38100700002)(6666004)(31696002)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRwVVNHMVc4anB2TzVpV1lyZnpHcUcrMjl4TTN1ZXZnd1FndDZqWWZCVUNJ?=
 =?utf-8?B?UnI5cVZYVnB3ejlsdVIzL1FXVExVZ1AvcWZpcTByMnFZRXVCOHE1NzkyMVFM?=
 =?utf-8?B?WWR4dEhuanhSakE5QmlkZk5mbVlIVzF1d1pQTHI1QTlidjk1T3RDZmdId1pl?=
 =?utf-8?B?RUJ3d3d2VU1aUGtKL2k5Z1RQTzlNRjVzcjk2TW9xTXM0SGJ5S2NJaGpGTStV?=
 =?utf-8?B?bGtTcVZaTDdPTTdsNDNnV0ZIdHN6aUowV0FJZlpteUpuVUFyNUdRN1NHVmp2?=
 =?utf-8?B?YTNibXAzY09YMnFGMHNqQ2pTaUdDTEROR1pNUzRjQ0tpVXAzQzhqbDBBdVBs?=
 =?utf-8?B?L2ViWEhNVGpRSVFiQm0xWXM0ZXRpNndMVllvY2hsZ1F6U3F6TkpxY0dmeWMy?=
 =?utf-8?B?emZpTjc4akpMMllBYWRob0xodGVUa2J2NzB5eGhPWmJKTFBoZHh2cGFROHRH?=
 =?utf-8?B?UlNDRU5EY0NHcTFhOTZnM2NMVlVQL3pNa1RoOVdOUHp5NjloL0tHSG1zTmFI?=
 =?utf-8?B?UWJqYjdwcGVOZ3ZjWmR4VmVOaVloa1BFQ1dyenNuR25lVHRhMm1TYU93eXFT?=
 =?utf-8?B?SWtvK0F3MjBHaC9kbm8yeTVvQm1YeDNjRENvSDBoTWR0bFRrUVBZdkMrK00x?=
 =?utf-8?B?cEd4WDNqV05iV2I4ZGRKdkFiNUt3WkxsTlcweWhOV1pqYlV4ckc2MkNEbVNr?=
 =?utf-8?B?aUl0S1p3WCtlTjVNbWovVjh2eS9KTktBSy9WL3NaUGpzamJrcmhaOTdLb2g4?=
 =?utf-8?B?b3dFdG1mMHJhOU5wTTU0WHB1SFlMd0owM21RZmtNTmtjWks2TGZpT1VIR012?=
 =?utf-8?B?cDUyVFByWVhxditrWXNQTmdoc1l3d2VWbCt6bUEvbWdhVUlUSFJqOFlxR2d5?=
 =?utf-8?B?Z0ZNNEFoUkNQNnE1M01INmlCVC9ab3Y4SHN0QnB2OHRxdHBadmhWL01aaGVi?=
 =?utf-8?B?WERuWTNXRW93REwzbk1zWWdSVkJZV0dRa1A4RzVWcURuaWplLzZzcmZlMWo0?=
 =?utf-8?B?WVZTS1dpQVdDNWF4UUpMYTZPckd3Wm52VWwzSExhZG5RV1hIM2pCbnMrR0FF?=
 =?utf-8?B?eXZsbEkyNEZPRERCNTAyN051bzRDUmo3NEdUSmpYRHhlcmtwWlV6eVVEblJL?=
 =?utf-8?B?ZkdQUjZqK0JFSjViSDZzcm1qQ25MTEJJM2doVlR1QTBoMEtqeXFOT0p0Vmpj?=
 =?utf-8?B?N1VzdXhEUFcySkJHVVB4cVpJdVkxRndmdTBRT1MzWWhteGdqWWVKRDBFeGR6?=
 =?utf-8?B?OGdDK2EvTjhMaTNQemFXVjR0RHBya0xCajIwd1ZvT0JFZkM2YlFCRDF5Vkgz?=
 =?utf-8?B?dE1RUTlpTWdIN29VbmJLb2RYZFB5cXg2MDdTek5YUFAwc01QQkRCam9aSk1y?=
 =?utf-8?B?eS9KMHFtQ3MxMnl5anFUSjQzSW1Rc2xqQ3VEK3c0TFNjaVc1MXJ3Zjk2NEVo?=
 =?utf-8?B?S1VoYjlOaTJzb0RxZFFHMEx1a3pFSUkwYTlqbmxuUWt4MXY0VGxDOGZ3Z2Nk?=
 =?utf-8?B?TWVUSWt3eHNXN3YvVE81bnY0b2hZVlhUZ3lXTkxtbVJjL3hoZ2krclI5a1ky?=
 =?utf-8?B?cFlEUmhwenYveWRxQkhha3J1RTFQVHl4cUcrRy9tRHFaUXdxZUtUcFJaa3h3?=
 =?utf-8?B?ZmozdVNnbUF0aTZqTzdSeU5yaEUzQU9KTHJMSEFIR2t3Q3lRSXRtMjMxVDlK?=
 =?utf-8?B?U0VnaW85V0pOd0s4eVRMc01UaEV1Q014UUpGOGpqcy9kRHhPanZlSkl3aU5x?=
 =?utf-8?Q?hEaT3AA/b8Orkw/VoMFiduAZ9P1d3Ix3UoiToFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e234c60-ed97-4794-2cad-08d93b87cbcd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 05:27:47.8985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0FL4ucg3iFICuVeDvKvqKrqnPYueQlqO8l1SI6q/N+nTc7bl8Gyk4IjvLBfOUni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/30/2021 10:01 AM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, June 30, 2021 11:52 AM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
>> retrieving for Sienna Cichlid
>>
>>
>>
>> On 6/30/2021 8:56 AM, Quan, Evan wrote:
>>> [AMD Official Use Only]
>>>
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Tuesday, June 29, 2021 9:38 PM
>>>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Subject: Re: [PATCH 1/2] drm/amd/pm: update the gpu metrics data
>>>> retrieving for Sienna Cichlid
>>>>
>>>>
>>>>
>>>> On 6/25/2021 1:42 PM, Evan Quan wrote:
>>>>> Due to the structure layout change: "uint32_t ThrottlerStatus" -> "
>>>>> uint8_t  ThrottlingPercentage[THROTTLER_COUNT]".
>>>>>
>>>>> Change-Id: Id5c148b0584d972ae73fb9d7347a312944cec13d
>>>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>>>> ---
>>>>>     .../pm/inc/smu11_driver_if_sienna_cichlid.h   |  63 ++++-
>>>>>     .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 234
>> ++++++++++++---
>>>> ---
>>>>>     2 files changed, 222 insertions(+), 75 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>>>> b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>>>> index 61c87c39be80..0b916a1933df 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
>>>>> @@ -211,6 +211,7 @@ typedef enum {
>>>>>     #define THROTTLER_FIT_BIT          17
>>>>>     #define THROTTLER_PPM_BIT          18
>>>>>     #define THROTTLER_APCC_BIT         19
>>>>> +#define THROTTLER_COUNT            20
>>>>>
>>>>>     // FW DState Features Control Bits
>>>>>     // FW DState Features Control Bits
>>>>> @@ -1406,7 +1407,67 @@ typedef struct {
>>>>>     } SmuMetrics_t;
>>>>>
>>>>>     typedef struct {
>>>>> -  SmuMetrics_t SmuMetrics;
>>>>> +  uint32_t CurrClock[PPCLK_COUNT];
>>>>> +
>>>>> +  uint16_t AverageGfxclkFrequencyPreDs;  uint16_t
>>>>> + AverageGfxclkFrequencyPostDs;  uint16_t
>> AverageFclkFrequencyPreDs;
>>>>> + uint16_t AverageFclkFrequencyPostDs;  uint16_t
>>>>> + AverageUclkFrequencyPreDs  ;  uint16_t
>> AverageUclkFrequencyPostDs  ;
>>>>> +
>>>>> +
>>>>> +  uint16_t AverageGfxActivity    ;
>>>>> +  uint16_t AverageUclkActivity   ;
>>>>> +  uint8_t  CurrSocVoltageOffset  ;
>>>>> +  uint8_t  CurrGfxVoltageOffset  ;
>>>>> +  uint8_t  CurrMemVidOffset      ;
>>>>> +  uint8_t  Padding8        ;
>>>>> +  uint16_t AverageSocketPower    ;
>>>>> +  uint16_t TemperatureEdge       ;
>>>>> +  uint16_t TemperatureHotspot    ;
>>>>> +  uint16_t TemperatureMem        ;
>>>>> +  uint16_t TemperatureVrGfx      ;
>>>>> +  uint16_t TemperatureVrMem0     ;
>>>>> +  uint16_t TemperatureVrMem1     ;
>>>>> +  uint16_t TemperatureVrSoc      ;
>>>>> +  uint16_t TemperatureLiquid0    ;
>>>>> +  uint16_t TemperatureLiquid1    ;
>>>>> +  uint16_t TemperaturePlx        ;
>>>>> +  uint16_t Padding16             ;
>>>>> +  uint32_t AccCnt                ;
>>>>> +  uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
>>>>> +
>>>>> +
>>>>> +  uint8_t  LinkDpmLevel;
>>>>> +  uint8_t  CurrFanPwm;
>>>>> +  uint16_t CurrFanSpeed;
>>>>> +
>>>>> +  //BACO metrics, PMFW-1721
>>>>> +  //metrics for D3hot entry/exit and driver ARM msgs  uint8_t
>>>>> + D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
>>>>> +  uint8_t D3HotExitCountPerMode[D3HOT_SEQUENCE_COUNT];
>>>>> +  uint8_t ArmMsgReceivedCountPerMode[D3HOT_SEQUENCE_COUNT];
>>>>> +
>>>>> +  //PMFW-4362
>>>>> +  uint32_t EnergyAccumulator;
>>>>> +  uint16_t AverageVclk0Frequency  ;
>>>>> +  uint16_t AverageDclk0Frequency  ;
>>>>> +  uint16_t AverageVclk1Frequency  ;
>>>>> +  uint16_t AverageDclk1Frequency  ;
>>>>> +  uint16_t VcnActivityPercentage  ; //place holder, David N. to provide
>> full
>>>> sequence
>>>>> +  uint8_t  PcieRate               ;
>>>>> +  uint8_t  PcieWidth              ;
>>>>> +  uint16_t AverageGfxclkFrequencyTarget;  uint16_t Padding16_2;
>>>>> +
>>>>> +} SmuMetrics_V2_t;
>>>>> +
>>>>> +typedef struct {
>>>>> +  union {
>>>>> +    SmuMetrics_t SmuMetrics;
>>>>> +    SmuMetrics_V2_t SmuMetrics_V2;
>>>>> +  };
>>>>>       uint32_t Spare[1];
>>>>>
>>>>>       // Padding - ignore
>>>>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> index 0c3407025eb2..f882c6756bf0 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>>>>> @@ -80,6 +80,13 @@
>>>>>     		(*member) = (smu->smu_table.driver_pptable +
>>>> offsetof(PPTable_t, field));\
>>>>>     } while(0)
>>>>>
>>>>> +#define GET_METRICS_MEMBER(field, member) do { \
>>>>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && (smu-
>>>>> smc_fw_version >= 0x3A4300)) \
>>>>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t *)(smu-
>>>>> smu_table.metrics_table))->SmuMetrics_V2)) +
>> offsetof(SmuMetrics_V2_t,
>>>> field)); \
>>>>> +	else \
>>>>> +		(*member) = ((void *)(&(((SmuMetricsExternal_t
>>>>> +*)(smu->smu_table.metrics_table))->SmuMetrics)) +
>>>>> +offsetof(SmuMetrics_t, field)); \ } while(0)
>>>>> +
>>>>>     static int get_table_size(struct smu_context *smu)
>>>>>     {
>>>>>     	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) @@ -489,13
>>>> +496,33 @@
>>>>> static int sienna_cichlid_tables_init(struct smu_context *smu)
>>>>>     	return -ENOMEM;
>>>>>     }
>>>>>
>>>>> +static uint32_t sienna_cichlid_get_throttler_status_locked(struct
>>>>> +smu_context *smu) {
>>>>> +	struct smu_table_context *smu_table= &smu->smu_table;
>>>>> +	SmuMetricsExternal_t *metrics_ext =
>>>>> +		(SmuMetricsExternal_t *)(smu_table->metrics_table);
>>>>> +	uint32_t throttler_status = 0;
>>>>> +	int i;
>>>>> +
>>>>> +	if ((smu->adev->asic_type == CHIP_SIENNA_CICHLID) &&
>>>>> +	     (smu->smc_fw_version >= 0x3A4300)) {
>>>>> +		for (i = 0; i < THROTTLER_COUNT; i++) {
>>>>> +			if (metrics_ext-
>>>>> SmuMetrics_V2.ThrottlingPercentage[i])
>>>>> +				throttler_status |= 1U << i;
>>>>> +		}
>>>>> +	} else {
>>>>> +		throttler_status = metrics_ext->SmuMetrics.ThrottlerStatus;
>>>>> +	}
>>>>> +
>>>>> +	return throttler_status;
>>>>> +}
>>>>> +
>>>>>     static int sienna_cichlid_get_smu_metrics_data(struct smu_context
>> *smu,
>>>>>     					       MetricsMember_t member,
>>>>>     					       uint32_t *value)
>>>>>     {
>>>>> -	struct smu_table_context *smu_table= &smu->smu_table;
>>>>> -	SmuMetrics_t *metrics =
>>>>> -		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))-
>>>>> SmuMetrics);
>>>>> +	uint32_t *data_u32;
>>>>> +	uint16_t *data_u16;
>>>>>     	int ret = 0;
>>>>>
>>>>>     	mutex_lock(&smu->metrics_lock);
>>>>> @@ -510,78 +537,100 @@ static int
>>>>> sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
>>>>>
>>>>>     	switch (member) {
>>>>>     	case METRICS_CURR_GFXCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_GFXCLK];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>
>>>> One problem with this style is the need to track the datatype of each field.
>>>> Why not use the old style?
>>>>
>>>> metricsv1? metricsv1->field : metricsv2->field;
>>> [Quan, Evan] With that, there will be too many "if{}else{}".  Also I see there
>> seems coming some new changes for the metrics table. I'm afraid the
>> situation will be worse in the further.
>>> With this macro way, we can keep the code clean and tidy.
>>
>> I was talking about something like this, not with if..else. v1 or v2 is
>> assigned to be non-null based on FW version check.
>>
>> *value = metricsv1? metricsv1->CurrClock[PPCLK_GFXCLK]:
>> metricsv2->CurrClock[PPCLK_GFXCLK];
> [Quan, Evan] OK, i probably get your point.
>>
>> The number of condition checks are same with the macro as well (it only
>> hides it and probably this one also may be hidden using a macro). The
>> problem is if newer datastructure changes the datatype of a field, then
>> the current macro won't be reliable. Anyway, if there are more changes
>> expected in the metrics table, let's wait.
> [Quan, Evan] No, this is not an optimization which can be performed later. Instead it's a bug fix. As the new metrics table bundled with .68 and later PMFW is incompatible with previous version. That makes the fan speed retrieved through metrics table incorrect.
>>>> +  uint8_t  LinkDpmLevel;
>>>> +  uint8_t  CurrFanPwm;
>>>> +  uint16_t CurrFanSpeed;
> I can go with the way you suggested if you do see "newer datastructure changes the datatype of a field" as a concern here.

When I said "wait" - I thought your changes are already pushed, so wait 
till the next iteration of metrics table to decide on this kind of change.

The concern about datatype is only a "theoretical" possibility.

Ex: v1
	uint8_t f1;
	uint8_t f2;

	changing to something like below in newer table

     v2
	uint16_t f1;
	uint8_t f2;

If you think it is possibile, suggest to make the change.

Thanks,
Lijo

> 
> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>>
>>> BR
>>> Evan
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> +		*value = data_u32[PPCLK_GFXCLK];
>>>>>     		break;
>>>>>     	case METRICS_CURR_SOCCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_SOCCLK];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_SOCCLK];
>>>>>     		break;
>>>>>     	case METRICS_CURR_UCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_UCLK];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_UCLK];
>>>>>     		break;
>>>>>     	case METRICS_CURR_VCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_VCLK_0];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_VCLK_0];
>>>>>     		break;
>>>>>     	case METRICS_CURR_VCLK1:
>>>>> -		*value = metrics->CurrClock[PPCLK_VCLK_1];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_VCLK_1];
>>>>>     		break;
>>>>>     	case METRICS_CURR_DCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_DCLK_0];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_DCLK_0];
>>>>>     		break;
>>>>>     	case METRICS_CURR_DCLK1:
>>>>> -		*value = metrics->CurrClock[PPCLK_DCLK_1];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_DCLK_1];
>>>>>     		break;
>>>>>     	case METRICS_CURR_DCEFCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_DCEFCLK];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_DCEFCLK];
>>>>>     		break;
>>>>>     	case METRICS_CURR_FCLK:
>>>>> -		*value = metrics->CurrClock[PPCLK_FCLK];
>>>>> +		GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +		*value = data_u32[PPCLK_FCLK];
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_GFXCLK:
>>>>> -		if (metrics->AverageGfxActivity <=
>>>> SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>>>> -			*value = metrics->AverageGfxclkFrequencyPostDs;
>>>>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>>>> +		if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>>>> +
>>>> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
>>>> &data_u16);
>>>>>     		else
>>>>> -			*value = metrics->AverageGfxclkFrequencyPreDs;
>>>>> +
>>>> 	GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
>>>> &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_FCLK:
>>>>> -		*value = metrics->AverageFclkFrequencyPostDs;
>>>>> +		GET_METRICS_MEMBER(AverageFclkFrequencyPostDs,
>>>> &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_UCLK:
>>>>> -		*value = metrics->AverageUclkFrequencyPostDs;
>>>>> +		GET_METRICS_MEMBER(AverageUclkFrequencyPostDs,
>>>> &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_GFXACTIVITY:
>>>>> -		*value = metrics->AverageGfxActivity;
>>>>> +		GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_MEMACTIVITY:
>>>>> -		*value = metrics->AverageUclkActivity;
>>>>> +		GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	case METRICS_AVERAGE_SOCKETPOWER:
>>>>> -		*value = metrics->AverageSocketPower << 8;
>>>>> +		GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
>>>>> +		*value = *data_u16 << 8;
>>>>>     		break;
>>>>>     	case METRICS_TEMPERATURE_EDGE:
>>>>> -		*value = metrics->TemperatureEdge *
>>>>> +		GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
>>>>> +		*value = *data_u16 *
>>>>>     			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>>>     		break;
>>>>>     	case METRICS_TEMPERATURE_HOTSPOT:
>>>>> -		*value = metrics->TemperatureHotspot *
>>>>> +		GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
>>>>> +		*value = *data_u16 *
>>>>>     			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>>>     		break;
>>>>>     	case METRICS_TEMPERATURE_MEM:
>>>>> -		*value = metrics->TemperatureMem *
>>>>> +		GET_METRICS_MEMBER(TemperatureMem, &data_u16);
>>>>> +		*value = *data_u16 *
>>>>>     			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>>>     		break;
>>>>>     	case METRICS_TEMPERATURE_VRGFX:
>>>>> -		*value = metrics->TemperatureVrGfx *
>>>>> +		GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
>>>>> +		*value = *data_u16 *
>>>>>     			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>>>     		break;
>>>>>     	case METRICS_TEMPERATURE_VRSOC:
>>>>> -		*value = metrics->TemperatureVrSoc *
>>>>> +		GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
>>>>> +		*value = *data_u16 *
>>>>>     			SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>>>>>     		break;
>>>>>     	case METRICS_THROTTLER_STATUS:
>>>>> -		*value = metrics->ThrottlerStatus;
>>>>> +		*value = sienna_cichlid_get_throttler_status_locked(smu);
>>>>>     		break;
>>>>>     	case METRICS_CURR_FANSPEED:
>>>>> -		*value = metrics->CurrFanSpeed;
>>>>> +		GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
>>>>> +		*value = *data_u16;
>>>>>     		break;
>>>>>     	default:
>>>>>     		*value = UINT_MAX;
>>>>> @@ -3564,68 +3613,103 @@ static ssize_t
>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>     	struct smu_table_context *smu_table = &smu->smu_table;
>>>>>     	struct gpu_metrics_v1_3 *gpu_metrics =
>>>>>     		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>>>>> -	SmuMetricsExternal_t metrics_external;
>>>>> -	SmuMetrics_t *metrics =
>>>>> -		&(metrics_external.SmuMetrics);
>>>>> -	struct amdgpu_device *adev = smu->adev;
>>>>> -	uint32_t smu_version;
>>>>> +	uint32_t *data_u32;
>>>>> +	uint16_t *data_u16;
>>>>> +	uint8_t *data_u8;
>>>>>     	int ret = 0;
>>>>>
>>>>> -	ret = smu_cmn_get_metrics_table(smu,
>>>>> -					&metrics_external,
>>>>> -					true);
>>>>> -	if (ret)
>>>>> +	mutex_lock(&smu->metrics_lock);
>>>>> +
>>>>> +	ret = smu_cmn_get_metrics_table_locked(smu,
>>>>> +					       NULL,
>>>>> +					       true);
>>>>> +	if (ret) {
>>>>> +		mutex_unlock(&smu->metrics_lock);
>>>>>     		return ret;
>>>>> +	}
>>>>>
>>>>>     	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>>>>>
>>>>> -	gpu_metrics->temperature_edge = metrics->TemperatureEdge;
>>>>> -	gpu_metrics->temperature_hotspot = metrics-
>>>>> TemperatureHotspot;
>>>>> -	gpu_metrics->temperature_mem = metrics->TemperatureMem;
>>>>> -	gpu_metrics->temperature_vrgfx = metrics->TemperatureVrGfx;
>>>>> -	gpu_metrics->temperature_vrsoc = metrics->TemperatureVrSoc;
>>>>> -	gpu_metrics->temperature_vrmem = metrics-
>>>>> TemperatureVrMem0;
>>>>> +	GET_METRICS_MEMBER(TemperatureEdge, &data_u16);
>>>>> +	gpu_metrics->temperature_edge = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(TemperatureHotspot, &data_u16);
>>>>> +	gpu_metrics->temperature_hotspot = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(TemperatureMem, &data_u16);
>>>>> +	gpu_metrics->temperature_mem = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(TemperatureVrGfx, &data_u16);
>>>>> +	gpu_metrics->temperature_vrgfx = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(TemperatureVrSoc, &data_u16);
>>>>> +	gpu_metrics->temperature_vrsoc = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(TemperatureVrMem0, &data_u16);
>>>>> +	gpu_metrics->temperature_vrmem = *data_u16;
>>>>>
>>>>> -	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
>>>>> -	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
>>>>> -	gpu_metrics->average_mm_activity = metrics-
>>>>> VcnActivityPercentage;
>>>>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>>>> +	gpu_metrics->average_gfx_activity = *data_u16;
>>>>>
>>>>> -	gpu_metrics->average_socket_power = metrics-
>>>>> AverageSocketPower;
>>>>> -	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
>>>>> +	GET_METRICS_MEMBER(AverageUclkActivity, &data_u16);
>>>>> +	gpu_metrics->average_umc_activity = *data_u16;
>>>>>
>>>>> -	if (metrics->AverageGfxActivity <=
>>>> SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>>>> -		gpu_metrics->average_gfxclk_frequency = metrics-
>>>>> AverageGfxclkFrequencyPostDs;
>>>>> +	GET_METRICS_MEMBER(VcnActivityPercentage, &data_u16);
>>>>> +	gpu_metrics->average_mm_activity = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageSocketPower, &data_u16);
>>>>> +	gpu_metrics->average_socket_power = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(EnergyAccumulator, &data_u32);
>>>>> +	gpu_metrics->energy_accumulator = *data_u32;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageGfxActivity, &data_u16);
>>>>> +	if (*data_u16 <= SMU_11_0_7_GFX_BUSY_THRESHOLD)
>>>>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPostDs,
>>>> &data_u16);
>>>>>     	else
>>>>> -		gpu_metrics->average_gfxclk_frequency = metrics-
>>>>> AverageGfxclkFrequencyPreDs;
>>>>> -	gpu_metrics->average_uclk_frequency = metrics-
>>>>> AverageUclkFrequencyPostDs;
>>>>> -	gpu_metrics->average_vclk0_frequency = metrics-
>>>>> AverageVclk0Frequency;
>>>>> -	gpu_metrics->average_dclk0_frequency = metrics-
>>>>> AverageDclk0Frequency;
>>>>> -	gpu_metrics->average_vclk1_frequency = metrics-
>>>>> AverageVclk1Frequency;
>>>>> -	gpu_metrics->average_dclk1_frequency = metrics-
>>>>> AverageDclk1Frequency;
>>>>> -
>>>>> -	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
>>>>> -	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
>>>>> -	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
>>>>> -	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
>>>>> -	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
>>>>> -	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];
>>>>> -	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_1];
>>>>> -
>>>>> -	gpu_metrics->throttle_status = metrics->ThrottlerStatus;
>>>>> +		GET_METRICS_MEMBER(AverageGfxclkFrequencyPreDs,
>>>> &data_u16);
>>>>> +	gpu_metrics->average_gfxclk_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageUclkFrequencyPostDs, &data_u16);
>>>>> +	gpu_metrics->average_uclk_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageVclk0Frequency, &data_u16);
>>>>> +	gpu_metrics->average_vclk0_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageDclk0Frequency, &data_u16);
>>>>> +	gpu_metrics->average_dclk0_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageVclk1Frequency, &data_u16);
>>>>> +	gpu_metrics->average_vclk1_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(AverageDclk1Frequency, &data_u16);
>>>>> +	gpu_metrics->average_dclk1_frequency = *data_u16;
>>>>> +
>>>>> +	GET_METRICS_MEMBER(CurrClock, &data_u32);
>>>>> +	gpu_metrics->current_gfxclk = data_u32[PPCLK_GFXCLK];
>>>>> +	gpu_metrics->current_socclk = data_u32[PPCLK_SOCCLK];
>>>>> +	gpu_metrics->current_uclk = data_u32[PPCLK_UCLK];
>>>>> +	gpu_metrics->current_vclk0 = data_u32[PPCLK_VCLK_0];
>>>>> +	gpu_metrics->current_dclk0 = data_u32[PPCLK_DCLK_0];
>>>>> +	gpu_metrics->current_vclk1 = data_u32[PPCLK_VCLK_1];
>>>>> +	gpu_metrics->current_dclk1 = data_u32[PPCLK_DCLK_1];
>>>>> +
>>>>> +	gpu_metrics->throttle_status =
>>>>> +			sienna_cichlid_get_throttler_status_locked(smu);
>>>>>     	gpu_metrics->indep_throttle_status =
>>>>> -			smu_cmn_get_indep_throttler_status(metrics-
>>>>> ThrottlerStatus,
>>>>> +			smu_cmn_get_indep_throttler_status(gpu_metrics-
>>>>> throttle_status,
>>>>>
>>>> sienna_cichlid_throttler_map);
>>>>>
>>>>> -	gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
>>>>> +	GET_METRICS_MEMBER(CurrFanSpeed, &data_u16);
>>>>> +	gpu_metrics->current_fan_speed = *data_u16;
>>>>>
>>>>> -	ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
>>>>> -	if (ret)
>>>>> -		return ret;
>>>>> +	if (((smu->adev->asic_type == CHIP_SIENNA_CICHLID) && smu-
>>>>> smc_fw_version > 0x003A1E00) ||
>>>>> +	      ((smu->adev->asic_type == CHIP_NAVY_FLOUNDER) && smu-
>>>>> smc_fw_version > 0x00410400)) {
>>>>> +		GET_METRICS_MEMBER(PcieWidth, &data_u8);
>>>>> +		gpu_metrics->pcie_link_width = *data_u8;
>>>>>
>>>>> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version >
>>>> 0x003A1E00) ||
>>>>> -	      ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version >
>>>> 0x00410400)) {
>>>>> -		gpu_metrics->pcie_link_width = metrics->PcieWidth;
>>>>> -		gpu_metrics->pcie_link_speed = link_speed[metrics-
>>>>> PcieRate];
>>>>> +		GET_METRICS_MEMBER(PcieRate, &data_u8);
>>>>> +		gpu_metrics->pcie_link_speed = link_speed[*data_u8];
>>>>>     	} else {
>>>>>     		gpu_metrics->pcie_link_width =
>>>>>
>>>> 	smu_v11_0_get_current_pcie_link_width(smu);
>>>>> @@ -3633,6 +3717,8 @@ static ssize_t
>>>> sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>>>>>
>>>> 	smu_v11_0_get_current_pcie_link_speed(smu);
>>>>>     	}
>>>>>
>>>>> +	mutex_unlock(&smu->metrics_lock);
>>>>> +
>>>>>     	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>>>>>
>>>>>     	*table = (void *)gpu_metrics;
>>>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
