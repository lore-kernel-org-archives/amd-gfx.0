Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614C0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B554D7A546;
	Mon,  6 Dec 2021 10:20:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0C872E3D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 09:13:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUrVesPrU0whmXgkL7ySD1C6yo17XO4c+2jpFOwpQEIrtQpJNGfy5sM/jXk5OWXAR+g40d5A0hODC027bsSqkmMnNFY9v+ZR/lt3p3x0sEZGH3LTchNs3aDCkCQ4eRnC1C3tmbLdPCk5LVwZpc3d3eLxAfVSklwNabVVgsdZEGNW/uhyQJ0keLXmVxSXA4qdDL2+rDgcyNQkrBxOy1975/gfixGyrp2MfdvdPHjVbRtpOoh4MGWZfPPHLnfsHeauhEtka+x8fipXzrxRwRqtXhl5+Hj3BQJBAi7ckXfi2dDjYzukFE/sTUz2FXRGCmd5gbE5WGHop7ewX9Pn5Q2OEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1U3KGvwzTRrV2zmMafzUd/K3xW8RUGpOVDan67kuzY=;
 b=U0+vu2J8WgDq9LVMt3WNdA+7rGqjYRdqRbfcWCKBVIaGYMNLYEqM0t/uKUHvzJHbf12HmUeW4rSuM71iCb/cgKJxG6Rp47tfXuw6bGFmXVWTMssDDdsaH2Uh7L/Lykyo49gftbopUD+MtHtCycCtSZTl65dMpbiLmnB71xdaDt0NREAhImo3YndqWpjT+sWzThwF8Jy49GwkvqiR/ShfxgVcvpuR2BKNryDCyxT1oZ/dgFQck29RO57AftssGmxjOOIMa8kFT3jnH1Sd+3lH4CjqeFfK+i9YgvFXf4+c4bTwT4d/uzTe2Esg6Kre5j11Ne5HD5oMKNkhgPe0w6aixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1U3KGvwzTRrV2zmMafzUd/K3xW8RUGpOVDan67kuzY=;
 b=yaWQ0XUZgzacbVqM7C40Sf4T8Vafh26XXWQrau4o2xPMPdubTRe8Y4dbqV11WD8S/ZzWWxnEpJaKNsQd3zrfjhlHWmb7uwhMweZeJ4TaAr0jvYYojmmiSWG3hTDAAb2xQ0qjdjmxaXIQcF+EMDXohv6ytAHP1NYIFjPaXrz21k4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 09:13:10 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.030; Mon, 6 Dec 2021
 09:13:10 +0000
Message-ID: <0f781749-bdae-093b-5408-5512ad62719a@amd.com>
Date: Mon, 6 Dec 2021 14:42:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message when
 dpm is disabled
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20211203065407.3714697-1-lang.yu@amd.com>
 <20211203065407.3714697-2-lang.yu@amd.com>
 <52f4d894-b122-a831-8182-70bcc2e1ce94@amd.com>
 <DM6PR12MB4250A082C1B20249D79406E6FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <8f7f1c6f-2f01-00b0-ff52-e50864ab78a7@amd.com>
 <DM6PR12MB4250FF2A11037B18176DE1EFFB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <DM6PR12MB42500FDF83B2FF999385D5E3FB6D9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <ec924948-c76c-08b4-c788-5017a2a18692@amd.com>
 <Ya3NXykr61OqR9fS@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <Ya3NXykr61OqR9fS@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Mon, 6 Dec 2021 09:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c85e4a49-2a51-45a8-8a95-08d9b8989f36
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4483509341E20C8EFCD0A0C3976D9@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AFm1HAYBPyjmOUKCKWJWyhbng5bEgeDOEQkPaNJBNn1IjD/YoKWVTauh5H2IDy8UKjVgdmHBLpNZmhh1PfDv2JojlaWwE2FfZyoIZZhwCwGcvaXx7g9lgXxG+VdV7klo8UUR/GqEYPirUKkBGl4F5AsoQcNRBxx7rm89PEV0tNlqUJyXXD+Etuzfa3afn/NPWOL6tYpQOB2xgm5EmqON4Ovsy+Zg7EYWouAOt4fZxdGurVdfSslmodIUiyLUG6a0iefQ4fZm77rZBZqEPUEVk2mUMXqV6ZcegR1eFjqIwSsvmdPVENVxsZxfYvBsKCBpp3PCceHaGgBuuGagXt/zaSbSQEbHe6MU65KjOZh8bYKloNqWI4BtZ9kEz7zzkIhlRtQqeXVpjkpVBm4X3Kuc/462mo5hF6yWjgXjQ9iWOI67BT7EU1nC3eR/dRqhsQlDfhQSb91Wt+uBSp2332c72vVs1i66jpazBnjoYoO7DeZi6N+bqNt477JTUK97RlnBbAzu1/b63SlwJVFwmU7G7MSI1dzEZPvRnur/6To1K3yH/fP4ELQvM+IATGBzoiHZS7IFBaD/8yNoURcNx9mXKdeiHyXMOpHvaHopgj8Eghzz8lz6fkHaJmStcgz2tZM9/yE3X8GFIeS5W/WUstdq5eIjDGOusf4KFKg+2wey7UZEncOwtCf8VvHw9r9JhOGw5zbExEX6LGlmZDiOsR30Lb8+PKQ5NhsATWXb9SIHRI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(31696002)(26005)(508600001)(8936002)(6862004)(316002)(956004)(38100700002)(2906002)(2616005)(186003)(53546011)(6666004)(36756003)(6636002)(83380400001)(16576012)(54906003)(15650500001)(4326008)(6486002)(37006003)(5660300002)(8676002)(66556008)(31686004)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZoL05FaGZ0QUZUNEUwNkYrVE5rS3UyVXkzcjhhUENSSThoTTZ1T2YrSXlr?=
 =?utf-8?B?K0x3U1JJUkJyTytwUi9SdnNuekttOEdoemlra2ViK1FhOWUybWhXR3hoUkdj?=
 =?utf-8?B?blVhc0FjRE9pTm9SakExNHFaTUZic2Y3d0wvR1d2K1pybFFWdXUvNHFPWUF1?=
 =?utf-8?B?S2JRbEN4VU9TaGs5cDVvdk9sZENwK3ZhOG1GTGVDUXBJSCttSDlpL3Vwazhz?=
 =?utf-8?B?cUhjbWZVaW5mM3NieVJFVWNMNXg0OUU3dDlDb1M5V3NaV1oyUTZaL2FzNjI0?=
 =?utf-8?B?djJmTVR2RE5vRkVqYktCbGVqSzlSRUZ0TERMaHBrdTVGL3lCb0orcTFjTzdU?=
 =?utf-8?B?dGVTaitzRTd0Wlo0N1lBd2p6bitJb1MyQWJvSGQyVlRzcDUzbk00TzFJWWh4?=
 =?utf-8?B?UisxQWVtTUUwRVYrQWdnRk1IMUo5Q21TTzVjdTdVOGRUT0h6bURWTFlPRXN2?=
 =?utf-8?B?Tk9PQ1RmWmtjWkZlVnFoQVpRN2w4Vzc2d3NoTFcxaGl2M2NEUHdlS2NzY3pX?=
 =?utf-8?B?SXlabkJMVGN0NlI5a0FHaHF2ZHFtWElNazZSdDRkSXlKaFprU0ROSzA1cTh4?=
 =?utf-8?B?RTdZTndiR2RzWWprWkRXcU1pcjRTOWJzTHpmUnowS0JhY1NKeHl1NHplZFpQ?=
 =?utf-8?B?eE9XQXNlblMzQ09jWGNWVmxhaEVYWXJnYzBLa1JjeWh0VlZhRUl0T0hmWW1D?=
 =?utf-8?B?QytHeklSVnlRK1lKMVpMU1Z4OU9mN1FvVnF0SDJWUERPTVU0SVBZS2MwTjk0?=
 =?utf-8?B?WWc3YndzaGMxL0ZBbUg0S2EwcE9KWXJESy9JVkw1RTU0Z1czbm9iOEtLNWRB?=
 =?utf-8?B?c2JidTA1QnJWOUUyY1Irem1aNXhDNUdJZEV2Q1JqTGROT1NVNUJuYk1jNVJ0?=
 =?utf-8?B?dzJPcWR1UTRLbzJYaE9kVjVhekNvWWdJQW5rL0p3R3VCZXpjaEd4a2NtOFRX?=
 =?utf-8?B?eThOeno3Uk95Ry8xYzZSa1dIb2RadUxCQlpUWmJQSm5hUlRsUFJqR2NkeDRY?=
 =?utf-8?B?aTBjQ3BORFVaZzF3ZHF1Z2RhWUJrd2ZsUC9UYXJKZW9FbGpjeDNEMEFuc051?=
 =?utf-8?B?cHg5aHZVbmNRWXFVY2szOVZKUWZLUjUyc3M1Mm1kOW9GTWFUNDZwellkSE9W?=
 =?utf-8?B?WlYrbU1nVEw0UnJEZm1DaFZTSzJnOHZQdWdoaGYyK3pxYVU5dVVzUnRwL3Qz?=
 =?utf-8?B?ZTFjRDJId0pqWStvcnhHQ1U1UVY2aXpzZnBaNktINFI3WUxDYmN2d3JaV2NJ?=
 =?utf-8?B?MXVhUW9FNXpmQjlqUTBTOVNDMlZkcmNRQ2NQSTExWXlKdHpxTStMbzBzSkRH?=
 =?utf-8?B?ZjJIcWVsVG1DT1BYRlBON0ExME5lRnhSTnYweFVrM1Z0YVRaVUk4WnZodXYw?=
 =?utf-8?B?NlNGbVpwUnFuMmsxQzNTQTg1bnhjTnVpWWkwWGJ1TWo2dlBXcU5hb2tGREVx?=
 =?utf-8?B?NTliTW1VWStUM0c2K1RUbXVnejFvdG9wMmF5RWw2NUJLeEhIQlg4OWVTUElo?=
 =?utf-8?B?cDBJU1Y5Q2lFOXRFUzA1MmRmLzloUllZU2Fqa2xQMWNUTEdKSklCUDBnZGxt?=
 =?utf-8?B?NjBITHcwRjlUTlhmU0kyZXRWT0ZGSnNqaGtNRkllQkZteWg2OTJkNnY4ZXV6?=
 =?utf-8?B?MlJrUDU4dlcyL1pCVkRaSUpjYzFsRmRhSTlZYVdaS0FOdXNWbEdaQkpLeFFs?=
 =?utf-8?B?Vmw2WUJTakM1THhqZVFma0V6d1BvcjVkdlNzRVl5WGhRaXo3cWhDdXVnSzZM?=
 =?utf-8?B?dUZNV1h0VVFBRUVrWWhsTjU2T2VPRDM0WDBsYmVtbURydjF6bFVwTkZ6bkpN?=
 =?utf-8?B?L09CN200cWlvVUowR0hNa29iem5vcTRXZ001aUR5R0c2UHFiUmR0NXN6cmUx?=
 =?utf-8?B?a01RWWhnUUF2OUtEQXU0QTFRd1JOODRmOENWeDZsWFFtam1yMzE2Q2lBbHJu?=
 =?utf-8?B?RkZjdlJIME1FNGVXNlNNTlUwbXNEUTFadmx4OVhPdVBpQm1YZ21lK3AwSjVv?=
 =?utf-8?B?M0JZR3k3MDZtWGNSeHFwWEp1VU51NTBjcjdLd1ZqU0liSHlML3N0VERiR0d2?=
 =?utf-8?B?TjVyM3pWTVhNYnRkcjllTzVDYXhkZ3JOYUFndjlOZlB1MjcvdHJaZG1QcTJN?=
 =?utf-8?Q?3qk8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e4a49-2a51-45a8-8a95-08d9b8989f36
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 09:13:09.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be4o3Xvg7Z033ia1LjmTiBD96uobuyJomwA2dBCXCZQKT4lU4zgYDSl9EK6E/pxD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
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
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/6/2021 2:14 PM, Lang Yu wrote:
> On 12/06/ , Lazar, Lijo wrote:
>>
>>
>> On 12/6/2021 12:18 PM, Yu, Lang wrote:
>>> [Public]
>>>
>>> A typo.
>>>
>>>> -----Original Message-----
>>>> From: Yu, Lang
>>>> Sent: Monday, December 6, 2021 2:47 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>
>>>> Subject: RE: [PATCH 2/2] drm/amdgpu: allow APU to send power gate message
>>>> when dpm is disabled
>>>>
>>>> [Public]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>> Sent: Monday, December 6, 2021 11:41 AM
>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>> <Ray.Huang@amd.com>
>>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
>>>>> message when dpm is disabled
>>>>>
>>>>>
>>>>>
>>>>> On 12/6/2021 8:19 AM, Yu, Lang wrote:
>>>>>> [Public]
>>>>>>
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>>>>> Sent: Friday, December 3, 2021 5:52 PM
>>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>>> <Ray.Huang@amd.com>
>>>>>>> Subject: Re: [PATCH 2/2] drm/amdgpu: allow APU to send power gate
>>>>>>> message when dpm is disabled
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 12/3/2021 12:24 PM, Lang Yu wrote:
>>>>>>>> The general hw fini sequence is SMU-> ... ->SDMA-> ...
>>>>>>>> We need to send power gate message to power off SDMA(in SDMA
>>>>>>>> hw_fini()) afer dpm is disabled(in SMU hw_fini()). Allow that for APU.
>>>>>>>
>>>>>>> This message is not right. In APUs there is no message provided by
>>>>>>> FW to enable/disable DPM, it is done in BIOS. Rephrase to something
>>>>>>> like after smu hw_fini is completed.
>>>>>>
>>>>>> It is power on/off SDMA message. Not enable/disable DPM.
>>>>>>
>>>>> Bad choice of word :) I didn't mean FW message, it was about this line
>>>>> in "commit message" - "afer dpm is disabled".
>>>>
>>>> Ok. I got it.
>>>>
>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>>> index 2d718c30c8eb..285a237f3605 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>>>>>>> @@ -277,7 +277,7 @@ static int smu_dpm_set_power_gate(void *handle,
>>>>>>>>      	struct smu_context *smu = handle;
>>>>>>>>      	int ret = 0;
>>>>>>>>
>>>>>>>> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
>>>>>>>> +	if (!smu->pm_enabled || (!smu->is_apu &&
>>>>>>>> +!smu->adev->pm.dpm_enabled)) {
>>>>>>>
>>>>>>>
>>>>>>> This check was there before also, only the WARN is added. That means
>>>>>>> it was skipping sending messages in APUs also and so far this was
>>>>>>> working fine (until this gets noticed because of the warning).
>>>>>>>
>>>>>>> Now this would try to send the message to APU without any check.
>>>>>>> That doesn't look good. Ideal way should be to fix the sequence.
>>>>>>> Otherwise, suggest to do something like below as the last step of
>>>>>>> smu hw cleanup rather than sending the message blindly.
>>>>>>>
>>>>>>> 	if (smu->is_apu)
>>>>>>> 		smu->pm.dpm_enabled = smu_is_dpm_running(smu);
>>>>>>
>>>>>> smu_is_dpm_running(smu) will cause errors in suspend.
>>>>>>
>>>>> That is interesting. What is the error you get?
>>>>
>>>> [drm:amdgpu_dpm_enable_uvd [amdgpu]] *ERROR* Dpm enable uvd failed, ret =
>>>> -95 That means EOPNOTSUPP.
>>>>
>>>> Actually, in resume process, but adev->in_suspend  is still true.
>>>> For Renoir series APU, smu_is_dpm_running is hardcoded as following,
>>>>
>>>> static bool renoir_is_dpm_running(struct smu_context *smu) {
>>>> 	struct amdgpu_device *adev = smu->adev;
>>>>
>>>> 	/*
>>>> 	 * Until now, the pmfw hasn't exported the interface of SMU
>>>> 	 * feature mask to APU SKU so just force on all the feature
>>>> 	 * at early initial stage.
>>>> 	 */
>>>> 	if (adev->in_suspend)
>>>> 		return false;
>>>> 	else
>>
>> Renoir suspend shouldn't be a special case. FW should keep running with
>> features enabled after driver suspend. Could you try with a return true all
>> the time for this?
> 
> That worked.
> 
> But we just send an IP power on/off message here.
> 
> Do we really need dpm running?
> 

Yes, but it is a power management message. From a FW perspective, power 
management starts when DPM is enabled. Without that, it's not bothered 
about any power management features. Only a few non-PM related messages 
like i2c table transfer etc. work when it is not enabled. Usually for 
APUs, DPM gets enabled early through BIOS and driver doesn't have much 
control.

If dpm_enabled is not causing any SW logical errors, better to keep it 
coherent with FW DPM for swsmu based ASICs.

Thanks,
Lijo

> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>
>>>> 		return true;
>>>>
>>>> }
>>>>
>>>> So we got such an error.
>>>>
>>>> Regards,
>>>> Lang
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Here we just  send some IP power on/off messages.
>>>>>> Is it necessary to enable DPM to send such messages?
>>>>>>
>>>>>> Regards,
>>>>>> Lang
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>      		dev_WARN(smu->adev->dev,
>>>>>>>>      			 "SMU uninitialized but power %s requested for %u!\n",
>>>>>>>>      			 gate ? "gate" : "ungate", block_type);
>>>>>>>>
