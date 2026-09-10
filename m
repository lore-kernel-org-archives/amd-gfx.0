Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DD5C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 05:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5B710E042;
	Thu, 10 Sep 2026 05:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MugvZ+Um";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013036.outbound.protection.outlook.com
 [40.107.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E5E10E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 05:23:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+L91vH0FYZkZpKjekvh2SuyyaHhN9+BK3Emq7/qTO+8TNZSpizx9AWT11DREQn+G+W+DNu5k/jAa90yFB0BrhBNAXbjokC/Jaqx/4NbZgjp1KVospOJmMGVpKhqZ+tVxH8U8n4dT6SdOQt+mRZN5w9ZCH8HREth7l6UXBNOM3IEkAH7e2uGm4TNgQbi2zZSqPmK94IqLfos0zCwf1ycMlycGXAmtmcfpRZ0xB5tj1YbWAfoZ1pE1wAT3sFg/VQidAVuaDey6jK5e8pYENG5clyMayg4Q2a7cArThnXN0y7PL2P9vbXhzW/mKv20Fo0zo5ysIQH4A61Qnq8OcGiaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5QXVF+h1//vvB8A9a4W+oDuDIMZRXbG5ZmimPAR4Ns=;
 b=aYjqKpEH1d8UUEG5WHKGgyWVbgjWBa65fha2lUT4kH0KJJve+MLudecTp1lDVX/XL7iWefRM+vccHkicS8HCNEr7p5yhErl3P9ki+6lCMo1nnNWZlRj5WVwAsR8QwoFCTYpXvkrlzuoikiXBTXGYSd3W7mcfsyWguNMw7AkEXbcO4pYR+J5xyoI8uQOOhFOreSmKnWsGIODNIi2Njf12oXo37DiD8d+MVU30vAySOcngv1Trlu0a+bBz20erhYaJOR6wi1zcnkKbsuJbRSKkcWKEhOAjcTRDPXm89EcSBkeifqGNKNVpGbv8zVseVSMWUuCvJc4eHlWZ8JEcnKCNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5QXVF+h1//vvB8A9a4W+oDuDIMZRXbG5ZmimPAR4Ns=;
 b=MugvZ+UmzqPjSmW+4iU1a97UuHc1/5j1uu7vybZBWP268Tvb9Wosj5CJGjmCfI4fPkOzBM0I1UOdL2z2Rp4rXi16szb3EAktin9io4sjmYJGvYP7ierLPdY/F+gNOIaiBy6bEQJnDtjkUW5xpO7E3I+hKrf/6spWyqcjSpdzXLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by SA5PPF6CDAEAF48.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 05:23:31 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 05:23:29 +0000
Message-ID: <0d91c47d-086f-4fae-a92d-8b69f14410f0@amd.com>
Date: Thu, 10 Sep 2026 10:53:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap
 handler infrastructure
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>
References: <20260905081935.338775-1-srinivasan.shanmugam@amd.com>
 <20260905081935.338775-2-srinivasan.shanmugam@amd.com>
 <4f97a5e8-8bef-4353-9998-9e6daee499d2@amd.com>
 <b652b617-de17-4e11-9492-ffb003a9e51e@amd.com>
 <SA0PR12MB7091A430EEAB0FD042DF601597B02@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CADnq5_N38NE6Q8Bstcwx5aVh5Jfm8yCJO=ffD-vhBND9mZkisw@mail.gmail.com>
 <SA0PR12MB7091203029CC7166AB28355597BF2@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <SA0PR12MB7091203029CC7166AB28355597BF2@SA0PR12MB7091.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0206.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::7) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|SA5PPF6CDAEAF48:EE_
X-MS-Office365-Filtering-Correlation-Id: 669efdc8-97cb-474a-2415-08df0efba5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nenk1rhd3G6iTF0wwHoL9JoxDSDmVPxJbz4sneLYcSfxaTXa/yNPKfmQTanmGqu83EsnJHVyNzLFK2HCwfjTqWLeUHqq3csEc6GftmEhQhi2DCEOB1X9DjisOph+4Z6UmXLlVnV3/WHOlNm5uztbKT5aYflOfULL8ezGRFnj+ahgY7INo9EEWRrikjNyc2FgwV/hh80WwKw5XVxSRVxo1X636/nA7VZp6CLuT6l+DEqRviQ9UqmtPQNeA8JZPPrRsndPEHwW5x6jgTpCg+A9lEAXc2hZfGZO8CKXYGrZUtw+Sf/PSs/LjWCH8J3ysqve5LLulVUtVUSOM2q0hxzOxdSduibvjJP2WwLyHnBjgh8zf/P5auuDi71uZUSRPhbZe+O+K0O8qWXseCDXfRYUYYXDhlqIP9DOiaZR1Bt6dKvLwyaCA+w9hBuK6V7pNJj8vUhhkPXYk+ZcNUk3Jvlo9ax4T8+u2DPsClKyDEwamqZhMQscMPi/eXfAMJh+6vwC7Iu9O/N3YKJEBVL0lzen3uym5aiNrNHW6JFcLeJ0a6Rynh0QcKYFvBEQTTehbJJ+bql1XDPGwfiwg+Ui1ahis3Abm8cFBttSzjg97IULtFdVoupqLpOfqULVYdCQVzDCymnAnNs4yrcp1fxN8zR3yVDi9nXn2b2Mhv1/3oA1R/U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2xQYkZnemRZUjk0MFA5cjRxMVJSdkFmSUpMU1BxVGhydjFsZldDcVFNeU00?=
 =?utf-8?B?ZU92d2ZqV2xhVTJ4QTlFdHpUbCswVzRLcWw1MmdMY0l4OU50RzBGV1RmRmVV?=
 =?utf-8?B?QTJXbjN4RW9TOVYyU1VIRkdzc2lwTUp3bWpJdmtjY3NUNXZTZE5lQzUwUkNj?=
 =?utf-8?B?anZUalZjQnR6TFltOXNycWlkR0hib2pVQ2hJRlNUUHNmdEU2dlZDQVhXdTJx?=
 =?utf-8?B?SHFuQmhMTTV0OUdOYXNIaDV2NU0yQTk4NG9hWlExU2ZHMkVxSG1XK3FBZ2th?=
 =?utf-8?B?cnFTTEVHVS8zNVNNSjd0cWJ3QWVwL0plOGZURDI3VzYrQTRRZzFiVVBMMVdu?=
 =?utf-8?B?cnNWYjQrcUIxVXZBbU1GNURnbTNVemhzZHpVWVdtWFRvVm92WHZlUDBBd3Jq?=
 =?utf-8?B?cjU0ek8zSDl3VjJ0cEpaTHkrcVNCVjVnZHJtOXREZ0NHR0l1ZTFkYXIyRHZX?=
 =?utf-8?B?OVBUdnAvY2g4OVJMQkFacWoySWhWaUNOSUd1VlQzaEhzakVaUUFNR0ZaaDN0?=
 =?utf-8?B?cmRhU2h5TnIveFdqcnk3UE5rZkg3eWw2L3pTeHh6TkY2Q2lMaHoyNWlyamVh?=
 =?utf-8?B?cUVnM3RueEZob29GcTdqbmorK24yOG11M0lwQU85TEdoOW9Rd2lsQ3hqbWNQ?=
 =?utf-8?B?SGgvbUhtL2pMcjA5VEJVVVE3WUpSc2JTcDdCZ3lPSWVHanVldlhnMEVvMXZH?=
 =?utf-8?B?TFhqOXE2TDdyUFE0WEdVSGEvSFdvVnd3OWdqc2hvcTdINnhlWU44R1RLbnNZ?=
 =?utf-8?B?SmpQekIzVXNic2VnM0VRTUR2SE4rSGRDMlpkS1VaTTBEeStTZGdFRFNpRDdK?=
 =?utf-8?B?VWpLRVFORnQyY2NHbXU4VHBHblZ5SFIvUVBIUmg5Zy9xWDc5UkdPWHBFc1hI?=
 =?utf-8?B?eUQ5b0hEZ29wZG5QK2l1aG1pUFRrYi8zQnl3SlVaOUZUbjBoMVVnTzFWWURJ?=
 =?utf-8?B?SmpGc1dNQWVOaTkxbHFkUVlIVUlzQWxLdDUzbWZOSVViTzlnaDB0a3BKQ2Uz?=
 =?utf-8?B?MkF2QUpLUGVxV2ppZ28zQmdVc1FnK2VHb2QvMUVPNlovdlUyb091Y0k3Zi80?=
 =?utf-8?B?THg0aXNCUGdKRlBpTDFrTlZWb1Q0TGxXbTY1MWRvNk1PY0FmSEJMSE9PbmVJ?=
 =?utf-8?B?VDI3ai9rWXVNK2IzdGZQL1RqMTNDNUNUSVFORG1lbHVRVlBmUTlZeFloWHdL?=
 =?utf-8?B?QTNxdnRiQmJxY1I2Tmt2WG1obGJNbFFDTUZxM3ZEZUFSWXQyc3gwRmlvTGMy?=
 =?utf-8?B?cWFnU3gwaXd3WGMxTVhnbHphNWQ2VUJxK3g1eHN1Q0V6UmtHYnFTSFNrQjNm?=
 =?utf-8?B?blY5YzNJUzZsVDZ1ZjlOZ1JtbmlYWjR4ak43UnlyaVhKU044WjBwOTg2VVAv?=
 =?utf-8?B?REcxMjFFaFZZNDZERDVtSVMwVytLcEdDYTdVMmtYYTcxM0ZqSzNyRytqNUVJ?=
 =?utf-8?B?aVFyWVhTcDVZTkIxWjhQZDJZcmRjd1JqdGZnbVZSZW9SYU5lVDhPZGN1Qm0x?=
 =?utf-8?B?Z21xZGVvL2tiSHJmZTRYU1J3Sk8wenhtOHNONlFxa0cwR3FzdklWU2d5Zmc0?=
 =?utf-8?B?K0I4QU5zWDQrZGJVSGRLYm94R1lYekU5RDB4NWhKTU5MRjdOdEk1Ui9qYmxH?=
 =?utf-8?B?VTV2NVVUcWVpNjR5MmxvR0dWZVdST3VuUUR0VFVxSnNWWW9GSldGSDhrTThX?=
 =?utf-8?B?M0E1Z2tWWmJybjgxNnlxUkVHQWdlZVNyZzBNMU5jOXN3dWMzNTVYajRoTE1m?=
 =?utf-8?B?Y0dhYVA1S2VUYTdxdkg1L2ZJU2p4ODhqOFdPTm5Rc3grVGk0cDlQWTZGTE9K?=
 =?utf-8?B?WFRjcjl2SG53bllKU2JLMURLRit1NFlMTWkvZk0wQnU0UVdkOEdrY00xRDRa?=
 =?utf-8?B?Rkw0bjlFc3VtdW5FeWc5L3dMUnJOQ3N6THZyK3VkRXFJMDlIdERMT0NxVHJn?=
 =?utf-8?B?WmQ3Y0g0ZU8zbE45MFRYQ3pZNmRHSGVuUWtQcm8vWEYwczVkaEt1QVZTaHlu?=
 =?utf-8?B?V2NqWWNNRkxQZVJ3RCtnYjBmOVpQemlKNVlUYjd6VHVBNEdtNm85VEJoWTc5?=
 =?utf-8?B?YVpCd0N5R2kraUZxSitSWWxHcElVSFd2bnM3cTM1Sk0veHhRNjFNcFB5M3dO?=
 =?utf-8?B?bkRnZDZJc3c5Mm43REowMjZxUEtiVGhDSWRVbG4zZ1dMVEZiVWpEVEMzNU5a?=
 =?utf-8?B?OWFOUjJqR3d0Q3VmK2xoTFpGczdJZDBMY3A1U2IxTzlWNnBsak9JdU5VQnZs?=
 =?utf-8?B?RGFQWDQvQ3dxMkJnZUdtZUl6cmpCcXhBU2J6b3lta05XbmNvdmdIWDJIRnZj?=
 =?utf-8?B?dHY2d21oQkExYm5zVHpWNGQ3TjBkbklJQk1WNHd4aU0wQ0M1QUVPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669efdc8-97cb-474a-2415-08df0efba5f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 05:23:29.5732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npAHab1DBFK9B/QhQjUdM0Z6oUy8gixzbYvshtGdKsKk0Yg89D+RQCIdQyeIv30y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6CDAEAF48
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



On 10-Sep-26 7:36 AM, Lazar, Lijo wrote:
> AMD General
> 
> 
> My question was slightly different context - The first level TMA is 
> fetched based on VMID of execution context .
> 
> If user waves are executed in IB VMID context (even though submitted 
> through kernel queues), do we need to allow user to install handlers for 
> kernel VMIDs?
> 


To clarify -

For other non-zero VMIDs, is there a need to allocate separate BOs like
kq_tba_bo/kq_tma_bo?

Can't we keep just one set of tba/tma bo for first level? User handling 
may always be through second level as the ioctl allows user to install 
only second level ones. If separate handling is required based on queue 
type (kq vs uq), I think trap handler can identify the queue based on 
doorbell offset.

Thanks,
Lijo

> Thanks,
> Lijo
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher@gmail.com>
> *Sent:* Thursday, 10 September 2026 00:24:03
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Cc:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org <amd- 
> gfx@lists.freedesktop.org>; Timur Kristóf <timur.kristof@gmail.com>; 
> Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.de>
> *Subject:* Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first- 
> level trap handler infrastructure
> On Wed, Sep 9, 2026 at 2:05 PM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>
>> AMD General
>>
>>
>> One generic question - I am assuming the overall purpose is to debug a user job submitted to kernel queue. When user IBs are submitted to kernel queue, those IBs carry VMID assigned to user. When wave submitted through such a job encounters a trap, isn't it having the user VMID? If so, when is this kernel queue related TBA/ 
> TMA helpful or selected? If it's only for driver submitted jobs, then 
> this control to user is not required.
> 
> Each fpriv GPUVM will have a copy of the first level trap handler
> mapped at the same GPU virtual address.  If the user requests a second
> level trap handler, their copy of the first level trap handler will be
> updated to point to the provided second level trap handler.
> 
> Alex
> 
>>
>> Thanks,
>> Lijo
>> ________________________________
>> From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
>> Sent: Wednesday, 09 September 2026 18:32:03
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Timur Kristóf <timur.kristof@gmail.com>; Samuel Pitoiset <hakzsam@gmail.com>; Natalie Vock <natalie.vock@gmx.de>
>> Subject: Re: [PATCH 1/3] drm/amdgpu: Add per-VM kernel queue first-level trap handler infrastructure
>>
>>
>>
>> On 9/9/2026 1:15 PM, Lazar, Lijo wrote:
>>
>>
>>
>> On 05-Sep-26 1:49 PM, Srinivasan Shanmugam wrote:
>>
>> MES owns kernel queue VMIDs (1..first_kfd_vmid-1) but does not program
>> SQ_SHADER_TBA/TMA for them. On GFX11+ hardware MES maps kernel queues
>> via ADD_QUEUE with map_legacy_kq=1 but does not set trap handler state.
>> On GFX10 and earlier HWS-based hardware, the driver programs trap
>> registers via SRBM select for KFD queues but no equivalent exists for
>> driver-managed kernel queue VMIDs.
>>
>> Add a vmhub callback program_kernel_trap_vmids() so each gfxhub version
>> can write SQ_SHADER_TBA/TMA for kernel VMIDs. The TBA points to the
>> device-level CWSR ISA BO. The TMA is set to the fixed per-VM virtual
>> address AMDGPU_VA_RESERVED_TRAP_START — each VM maps its own kq_tma_bo
>> there, so per-VM isolation is handled entirely by page tables without
>> needing to reprogram the register per job or per submission.
>>
>> The per-VM kq_tma_bo is a small GTT BO allocated at VM creation time
>> (parallel to page table allocation) and mapped read-only into the GPU VM
>> at AMDGPU_VA_RESERVED_TRAP_START. The kernel CPU writes the second-level
>> handler address into it via kq_tma_map when userspace calls SET_L2_TRAP.
>> The first-level CWSR handler reads this address to chain to the
>> second-level handler when a shader exception fires.
>>
>> This design is:
>>    - Per-VM BO (not device-level) — same model as page tables
>>    - Fixed VA in each VM's address space — same VA, different physical BO
>>    - Read-only from GPU — kernel CPU updates it via CPU mapping
>>    - Treat allocation/free lifecycle identical to page tables
>>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Lijo Lazar <lijo.lazar@amd.com>
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Cc: Samuel Pitoiset <hakzsam@gmail.com>
>> Cc: Natalie Vock <natalie.vock@gmx.de>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> Change-Id: I9ce352157c4aa84099cef926cba61264781e8ad9
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c | 80 ++++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h |  7 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   |  9 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 13 ++++
>>   5 files changed, 110 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> index 3ca187f5ade8..5624a5ab5c62 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>> @@ -115,6 +115,7 @@ struct amdgpu_vmhub_funcs {
>>       void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
>>                            uint32_t status);
>>       uint32_t (*get_invalidate_req)(unsigned int vmid, uint32_t flush_type);
>> +    void (*program_kernel_trap_vmids)(struct amdgpu_device *adev);
>>   };
>>     struct amdgpu_vmhub {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> index 623cac6781be..e913488ca3fa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c
>> @@ -263,6 +263,7 @@ int amdgpu_trap_init(struct amdgpu_device *adev)
>>         amdgpu_trap_cwsr_init_save_area_info(adev, trap_info);
>>       adev->trap_info = no_free_ptr(trap_info);
>> +    amdgpu_trap_program_kernel_vmids(adev);
>>         return 0;
>>   }
>> @@ -277,6 +278,85 @@ void amdgpu_trap_fini(struct amdgpu_device *adev)
>>       adev->trap_info = NULL;
>>   }
>>   +void amdgpu_trap_program_kernel_vmids(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
>> +
>> +    if (!amdgpu_trap_is_enabled(adev))
>> +        return;
>> +    if (!hub->vmhub_funcs || !hub->vmhub_funcs->program_kernel_trap_vmids)
>> +        return;
>> +
>> +    hub->vmhub_funcs->program_kernel_trap_vmids(adev);
>> +}
>> +
>> +int amdgpu_trap_vm_kq_tma_alloc(struct amdgpu_device *adev,
>> +                struct amdgpu_vm *vm)
>> +{
>> +    void *cpu_addr;
>> +    uint64_t va;
>> +    int r;
>> +
>> +    dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
>> +                    AMDGPU_GEM_DOMAIN_GTT, &vm->kq_tma_bo,
>> +                    NULL, &cpu_addr);
>> +    if (r)
>> +        return r;
>> +
>> +    if (vm->kq_tma_bo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +        iosys_map_set_vaddr_iomem(&vm->kq_tma_map,
>> +                      (void __iomem *)cpu_addr);
>> +    else
>> +        iosys_map_set_vaddr(&vm->kq_tma_map, cpu_addr);
>> +
>> +    vm->kq_tma_va = amdgpu_vm_bo_add(adev, vm, vm->kq_tma_bo);
>> +    if (!vm->kq_tma_va) {
>> +        r = -ENOMEM;
>> +        goto err_free_bo;
>> +    }
>> +
>> +    va = AMDGPU_VA_RESERVED_TRAP_START(adev) & AMDGPU_GMC_HOLE_MASK;
>>
>>
>> Is this the same address used for mapping of TMA for user queues?
>>
>> No — these are different, non-overlapping addresses in the reserved VA region:
>>
>> AMDGPU_VA_RESERVED_TRAP_UQ_START = TRAP_START − 12 KiB
>> → used for UQ first-level TBA (8 KiB) + TMA (4 KiB)
>> AMDGPU_VA_RESERVED_TRAP_START = SEQ64_START − 64 KiB
>> → used for KQ per-VM TMA (this patch)
>>
>> The UQ region sits immediately below the KQ region in the reserved VA
>> space. No collision between the two mappings in the same VM.
>>
>> Regards, Srini

