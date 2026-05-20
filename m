Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471B3CD5BA4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB3710E42B;
	Wed, 20 May 2026 17:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H/IitnKv";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C9010E42B
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 17:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISj/VgPjiEv9m6U+rrTRh53Gktyb65dDiw9iZjq7FRdQyAtqxhBXrD5LImjRKJ5nXBYJTNRO4gCyhVB0VwyTwsOehTW32mBl9hq8CuWVtDonPFkcoYPZfGAJ4/Sy2uIlWTt8s53rMm5ZbJNdkRBytWTG2n2NnL2n+j/+5OgkOdSIjRf2J4NJ2BeeasDT9uKiJkisTz/3zWnkwNcvqZazgSS5Vv6xmbaEdqTeFiVFz8QV5dqDAs9oM2RoHKJFpQrAW/uZiHAfSiSQsEIlCVP+DoGR0EKlOTmwF63FEVrA1xIFWG/dH1Dp56UlIsjMT6OXW7V/qOltk1Usc3OPBCfFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90qmbEsj8fNdyPBYRYstYq5tiLpst77A9njeOdcxOEs=;
 b=lJGV0mYMblRwwzTqCL0aaYR4ZCwlVCi1qUSePxtDuHKpQxw9y8urzCQEGHHf6OMwdLgD3cnQDVaEy65KQt8iFZ4uvCvkTxzIdj/mTQoCo5twmED8wAFvUSA3GedvMYOpzaJnGNe8xFSbz8FAYARlYLITrjpOOQWxPg6sjQ4IV4TNxAtmvzDCSiTsWliPkVqtS81KN2vuFDhf5ywJawZwe7rlcYh0knvCmvOfax61tIWvJwSkENyyk7wEB5eTzT28vFfH11ef9dVvk1hbVz3bsFM4BRiL3k+70J2ejgXQWWcKB9MOMLoCHS9jgiW5XDH1B1FBrt7C9zg9DDal5ljmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90qmbEsj8fNdyPBYRYstYq5tiLpst77A9njeOdcxOEs=;
 b=H/IitnKvZmdx784BKXm/ytzDKO4gMyH/yEmHJVx0jZVS4B5WpuIpCJw6Fomh9MxDBB0HS1Ezj4itFfQ4Ay76gDWHTnc0gX8Cqimlaf9TB7M2kxRFogoIAqH4YKzatINXtJMtEBRbZr7R+qmidyCTInPUgjRtS0GqQBk+vhmbNV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 17:10:40 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Wed, 20 May 2026
 17:10:40 +0000
Message-ID: <f1740ac9-932e-46ad-b659-602bcbde6088@amd.com>
Date: Wed, 20 May 2026 12:10:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] Revert "drm/amd/display: Restore 5s vbl offdelay
 for NV3x+ DGPUs"
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, michel.daenzer@mailbox.org,
 alexander.deucher@amd.com
References: <20260519220529.202096-1-sunpeng.li@amd.com>
 <20260519220529.202096-2-sunpeng.li@amd.com>
 <67b8b972-5b1f-4de5-871d-a9b65c2e5279@amd.com>
 <fbdfa69c-0c51-4f4a-ac4c-97b376e3cef0@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fbdfa69c-0c51-4f4a-ac4c-97b376e3cef0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:610:77::28) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dc6091-a752-4371-5910-08deb692b840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: ycsomdj8yl2/6uwpGeqDT8sRfsw0d/QpMADLui1U/ALBAxJTsnVgBj7NklQXPp8ejGj+/t7tCMkyXHLdTTGVEkDFrAan7O5jWi7Vyhmn2QGYB8XgQG1KdoVLj4AaSgORqlvaJteMNOpND49XWKHi+qVZcPGtrqehIW5L10Xy5KG9ECnrR+IcwVaBBlZ+ggHC5RnmOUYBs5r3TKoaImV5cRROaLKYswUr4kJLKZuoddkPKgcaRUcF1OcFTiAnhLLjTMNEOniBIW9SZT+zzCGdjw4Tc9KPRwwFJ2fPnI/svNpU9p0SvkzUNEzHTzVTpdCmAQKfVV9maZGjoaxr6tJlwsHogJgpOsjnGe9kh/1Kc+nmyyegPxuYYVza7jIOXAIa+CqFCyicCvNO+WsbIBCaTC6f8E4mVvI6WZOZU31FPtNTWL7uZ+LJOfVcqFYIZL9+qhrGUwcktOyPijBoymfq57lG0+GfE0uEWnunbk3CxqSBzkZCB5MuJ/IJU6+PH4fL9Ak/qFVoFcz+BEgx4bxOMPdLNEv8A18iRuhCx40ECtwBPqkDU2QYYcRKymI3j6REPf+Stkf/LoXMbSeRPItQcqD8V6Id4w3B4hxtN3s7hudK9xOyPRjzuP1ABVFZlmuMvqu7HAFZ5XWG/dYcnzahQRp1GHrIodeJOjJ7Ada0On1zdL4RFGIKH5V0vkjJmcrr8/tRnF6CmUsnCGrlmDw1/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB999147.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTZ0Z0tEcDJMWENKclNVNUxRV2VISTlnZlEydnBQaUlUQnZrRTNsNW0wVm5M?=
 =?utf-8?B?SGFCVGROdmhvdStWTzVueTUrSVNuKzFmY0V2amVTQkV1NVpKUDR6NjNSa0V3?=
 =?utf-8?B?azFDYVphYXZ6ZHJ4R0FvQlJ0eWlMRStGQXQyc3dhbUF5bVhJVmtJRXpzVlNT?=
 =?utf-8?B?Z1pVWWUydGtvcE1IK2o3ZnNZaFJKdWlpZEY4Vm5LVVN1T1NUT3FZdEZhdDhh?=
 =?utf-8?B?NW8yY3NnZExDWVRBV01XN2MwaGZma0ZTTjVsWkNBOG1hV0MvdnFiU1Y3dDV6?=
 =?utf-8?B?ZGhuTkVHbGxWZEtYdVVjQnJhNUN5cVpxbWlqZjBOLzU4TWt4VTQxTEg5aG5R?=
 =?utf-8?B?cU5nRGdOVmhjRlJXeXI5THU1QjNYWnhqeFFQRzVGR0lmVHgyOWFUZGJteU12?=
 =?utf-8?B?SlJnTW9tVFJpczNmSXJXV0xlSHorVkZBWmFXdDVUNXdibmFkRnhPYUp1NDds?=
 =?utf-8?B?dForVUtFcHJyNzNPRXNSemFuODF2Nkpxa2FIK3JLOU9xMUFJd3lKaU5WZ2ow?=
 =?utf-8?B?R0N1VENlMER6dzBUM09mVkxaZFZraFg1dlFtTXNWZTJxeWhlNWJ4dURrR0tX?=
 =?utf-8?B?Z1oxRnRIYTFLUFRKY0w3VnVZRHA5N2JNZjVxUld2emFVSzRqNW5meDdnalZP?=
 =?utf-8?B?UXRGU3BaVUI2czhXTnRGN2tsd3FxQjFFc2ppTjNhQlBId3NNakxtNkI4NmRt?=
 =?utf-8?B?S0YwM3Zub0xEKzVMenk0ekU0OUhVakhRd2oybTJRb2JYL0duSXYrSlpqdUoz?=
 =?utf-8?B?cVFXMUg5UXBFQjkxY2FIWndrNlJlNkFDdlBKVFZwQWdKdDM0UE1IbTR3Szc4?=
 =?utf-8?B?K2R3VSt4MkdSY2h4RXF1M1pBdVQwREYvTTNlTThwWWNuSnJuejlicUdRV3Vk?=
 =?utf-8?B?QWdqQTFWRk0wY2dGRllXWCs0YlJJYUpoaWFxTmtDTkZDR2VIZWxYaE0wTzZ1?=
 =?utf-8?B?NHdlQVFNRkpaOHlYUUNVQW5qOXBnTlVFNmV4WFkweksrbnFKT2hKaUlobXhI?=
 =?utf-8?B?TUdzRi91TjdQSGJSUjlzUGk0dklCUlB5b2Z6UEZBWmltZ0hGTmZiMUU3QlFT?=
 =?utf-8?B?cE1KTVZRTFNDZmJNZGw4OUlWbml2bC8za0lGTnVJNTlGUFVXRnYrdHNDNjBC?=
 =?utf-8?B?ekV2L3E4eUhnUUc0NXRMaUJualpFcm14WEFINmlxNEJpNThsdndZQ3k5N2wy?=
 =?utf-8?B?ZlhmUElsWHVoeDVLOGIzMGlPSm9GUW9oaEtGa3VNRUdYcjZxN3prbmhnVmdl?=
 =?utf-8?B?SHRWbnNaQ2ZIeDBZZXJ3WkNuZzdoTVE3SHNHdGNKNnNVK0RqVFN3RmxqNUsr?=
 =?utf-8?B?Ti8rQlhLajNHNTltTS9pSDJXWEFRVi9tWWFxVW1CeVhkL1pRalgwL1oxT1lF?=
 =?utf-8?B?S1dLMzRjNWo4ZXlzb1ZGR2JLcTVXSzh5MGMyODAyQ0w4ZWFXZE5IWmJmakht?=
 =?utf-8?B?SjVvMXROc0JvejVtYldPV2hLcjRiVlduWFVZVHNDUXAvSldFOW5yU1ZiNVY5?=
 =?utf-8?B?TzlOT3V1R1FGbC9aLzhzTGN2T0p1aUZPL0drQWpVRnRKRFJtRFNXRSt1VFBo?=
 =?utf-8?B?UDUxWFIzYm42U3Vqa1lCWjh1SDdsSFY2dHdtVWtsam5TTWIyNk44TjlMd2Er?=
 =?utf-8?B?N2hQc0hMS0Q3U21xb1dMRlpmTHFsK2IwemtaSHVkalppbFJRdXJNcTM4NDVY?=
 =?utf-8?B?Y2JzVk1lZ0g5QU8yQzl1ZE5sVHluTWVvV3JrOHNrTmVOQkYvdkRWNVFsL2R3?=
 =?utf-8?B?YmsvY1dLeWlPUWZRYld3RSsyMTNVNFBudDFZbzlyUFZ2SjAvL1RQK2pXV2Iz?=
 =?utf-8?B?ZStEaTRNbmZ1RUxxV3VzQ3FmbHFqVGpJdlg3TXdpQklIOEdhVFhSb2tFdjBJ?=
 =?utf-8?B?SXNkUlpsMnpLM0l3RzAxbUVPSjR0VW1HaDUrcHNtN05nZUQ2NkFpR2JxVlZN?=
 =?utf-8?B?RDFyczZ6NVdXN3lpQXRxa0YvY0dyRXdpVWpkZlRzeGNjekl6WUpFNlYzZ0c2?=
 =?utf-8?B?cmxTak1mSk9aaTZkbG5tSS93eU9ydTRXdGEwVGd1R1ZRYkpab001bnlOT05S?=
 =?utf-8?B?Y0dEMnRzNzRKT3c0OWxqeHpEaE84Ums4S1JpMThqaHZRRG1kM0ZIMTRRSzNO?=
 =?utf-8?B?MG5MUmd0SC9talpJcE9JOUF3aEdqQkFGUkdUd3RWa1doampkNlM3OUl5WjV2?=
 =?utf-8?B?bUZ5emV4ZVZxcTNCK2E4MVBFSkh3WmRVUmhqbVFMV1cvQXJDSWdwUStTZURR?=
 =?utf-8?B?dlhQdUtEVVNhaVg0by9tLzJwbGtBZVhJTzFJTE84STdFSG1TT2ZjdlJtem5P?=
 =?utf-8?B?bjRicThsdXdoZS9PZVFjOC9yWFRWbUdtQzRBZ2YyL08ycDY0Y0lqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dc6091-a752-4371-5910-08deb692b840
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 17:10:40.7812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BY3y5plWXnZ2/8fWMtqt39RUhh0gXULDIpC1WqeIAINluGgK6HePGG+ptCQSoVbjVgb/PT8EBUZ03j6PlX7xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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



On 5/20/26 12:02, Leo Li wrote:
> 
> 
> On 2026-05-19 18:18, Mario Limonciello wrote:
>>
>>
>> On 5/19/26 17:04, sunpeng.li@amd.com wrote:
>>> From: Leo Li <sunpeng.li@amd.com>
>>>
>>> Now that proper fixes have been found, let's revert this workaround.
>>>
>>> This reverts commit 751414c12388ff2b475e15c15d3c817dcf563635.
>>>
>>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
>>
>> Unless it "actively" makese the problem worse - could this be the last patch in the series instead of the first?  This will make things cleaner when it comes to backporting.  IE backport the fixes, "then" revert the W/A.
> 
> It doesn't make the problem worse, but we do want to revert it since it negatively impacts power.
> I'll reorder this to be the last patch when merging.
> 

Great, thanks.

> Thanks,
> Leo
> 
>>
>>> ---
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++---------------
>>>    1 file changed, 3 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 4670252ede244..be9c4e094d8ec 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -9518,21 +9518,9 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>>>        if (acrtc_state) {
>>>            timing = &acrtc_state->stream->timing;
>>>    -        if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
>>> -              IP_VERSION(3, 2, 0) &&
>>> -              !(adev->flags & AMD_IS_APU)) {
>>> -            /*
>>> -             * DGPUs NV3x and newer that support idle optimizations
>>> -             * experience intermittent flip-done timeouts on cursor
>>> -             * updates. Restore 5s offdelay behavior for now.
>>> -             *
>>> -             * Discussion on the issue:
>>> -             * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
>>> -             */
>>> -            config.offdelay_ms = 5000;
>>> -            config.disable_immediate = false;
>>> -        } else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>> -                 IP_VERSION(3, 5, 0)) {
>>> +        if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
>>> +               IP_VERSION(3, 5, 0) ||
>>> +               !(adev->flags & AMD_IS_APU)) {
>>>                /*
>>>                 * Older HW and DGPU have issues with instant off;
>>>                 * use a 2 frame offdelay.
>>
> 

