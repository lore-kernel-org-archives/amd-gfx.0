Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED45C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 11:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8840110E087;
	Thu,  9 Jul 2026 11:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f60aQLP9";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F3C10E087
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 11:06:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKzkYbrfitzwmaGgveS1+06wysIBbegYZQYXY81TOHVOzjfkVXZkqk/153Vow05wU3RfE7YbJoAroDqq2BtXkI0vii2gxDi/ugZlczZDwQzPxMrPtxhp7fJbLwzTSXiDydpLG/YTTJTrC6NSb57WLr58JxjZgfkmjyAWzdKnkvk4w3FMuvtktMmP6xk7gdoFQ06sLY1RfrfPT1YZenK0ATXnflusnCeQtdf/M884mQk0RZmIpSgcD4bGgf7bJfFQgMhrTFZQve+6xqgOx6XNkFTtML5uMEiaxf5B7jBJudMsszTEyeasMFPymcnH6cKCfp9UpEgrv4Rvr/JMamlL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsYcC6VPALp66CYbF2YvfCWZk4dDRgCn4h/o7NnQif0=;
 b=qDV6HwPnJ9eDY3B8Klyuhbix1tnRImGmzF3khjwn0Ot3/fqFJFooEoPyBBdwq4uTa5eylcgFVULDTWWjx9ATGmefg11Cozwv8afQ0oyiQRKUHvUWnFV3iByMSteS3vZDx7PLmLi7gn1mOAgLSY7SzgR1G9tmfm90KrD70Qp3raVjoGmqBj8Q+4+yPIsW62bKseh21z9eWCjRBfq7Q2+i+MKp3vEc5DjxwygiECp1OW812aJnEbsbS1py+OELd0Z5RwMD/u+g0w75wevZXPb5e3T8le65fXhhWjufodFa3rweN2ihb2yQTyb3vc5ONY3iJ7LVKuOBrYB86XJBdMTEMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsYcC6VPALp66CYbF2YvfCWZk4dDRgCn4h/o7NnQif0=;
 b=f60aQLP9C7DMe8nZLIIFK6A+AQdqDZCVxGh4hBsnvWg79cCusYiQSpkHEmL3qFB4RI2SYxNDzx1JDNDuN+9d3Tj+YwEI34S8zeEncNbV5Tgo5ye5/S8xSgC+1K0P1IE04nEpPo3E7+mxyT42hZzJQbIyqAxD4J5HcIbqlm8fjWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 11:06:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 11:06:36 +0000
Message-ID: <943aad96-a8a3-4a3b-a086-6a33365a0a92@amd.com>
Date: Thu, 9 Jul 2026 16:36:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
 <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <3ac3c6d5-8fad-4b0e-933d-42fa71a43657@amd.com>
 <49ba42a4-b661-4673-95a0-c218ec1482e3@amd.com>
 <de530731-21de-4470-9316-dccb767c87ac@amd.com>
 <DS7PR12MB5768E211043CC584F05A16569BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <989fc4ae-cbac-4f17-94cd-5be270845081@amd.com>
 <c963d1df-e1a3-4fa6-8514-3c4ab204088f@amd.com>
 <DS7PR12MB576870FE38FFB13002872F529BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
 <2d96166c-b192-41be-83d1-19eb64d7306f@amd.com>
 <DS7PR12MB57684EB76694DC4EB12791A09BFE2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB57684EB76694DC4EB12791A09BFE2@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e64c59-473e-497d-c3e8-08deddaa248a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: AQlPHEVYng1W3nQVPNhXXPakHHxHqxuAzugmqNQcGloj+lslg5rjnXNejKpNMq0bo0G26mUZcv75BL5AU5LFoCxJ3ScvReXJ8yRrsWglhsxeRu258i5JnX/C6LlwEwKEc+TywBqiWoZEegyduVpE82Nrd2WTcCv7zCrSVLX6A+HuxyFqHrKEQRawa0dNZ4Gdhux0gqexONujqciPFdzlXOn0dFUnrtyzNR3UtW8e6R0aqJlwPERdufhf6IIsVdNfVubrGCh2QOSOpsL+uhgwsiKpdq99YyQp9vx1cebECA95BGxWItTaEc1m0/JiCdayI7jBWrzjLAoysgiFNIOhKeLJkoL4aQnMhesbVqPB3kwbaWEn1xVANUliN7TiVjFUlCdbZat33ZLlteQn3oejJSef+pH0KX7aqubCu4uULpBbOuJ/0Rll5k8YikdeKZgEDmwlyP+91ikZLz6qPkIddufzDohfUxKBcgzKVtXGIFO9m6cuAdmrDxa1IvrXDIq7B3kaY/t/Y1ITnm2pg1NQ2zSpF5IMykSkvjvbkAsTu3TmHigysxX2sFA3TWMD4K1i4D+EZuR9UUZNyHTiMGsti5XPxKTDG0OE8+qo+aZIy+LLhJuUDLvcsX9hF05TSJvyHRrPBzUzJYJp7v6UapW167KOnORZOwZ9NGZswksKNiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGExbzMvRjFBVW0wYXAxOERKOUZoNTI0SnpnUkRYNVAxM2w2MkE2aXdua3Jt?=
 =?utf-8?B?Z1VuUlBYMGY0T0EyT0V4VVA5YW1xOTJIZ2FseVpaRWNSZGIvbnRXeUp6ZFVr?=
 =?utf-8?B?YUNXSlUzZzYxUjhuM1V5SThEWjROUWM1TUhyYTBRZFVIMGxkTUVXWUJNK1ho?=
 =?utf-8?B?U21kNjdVdHJGQ0R2M3l2WjRZSHlFckxjNDZsYnhHTEhFdFhZa3hEbzJ3c1FE?=
 =?utf-8?B?cFdXaDE2OFZEQ0VMWFRlN3Q0YVJRMllMcDluaXFLcHE1RWYxaXpTelNPaVVh?=
 =?utf-8?B?eWlTK0ZiWnZRa0NhMjd1MjFabEZYeVhUOVhWclUyekFXRVYrUTEwdWxQaGpW?=
 =?utf-8?B?cnpQK25uT3BVTzhKTGV3R3Zhd1M2NEZKR1N6VjRNZUlnd0h0bmxXV1VKTlRj?=
 =?utf-8?B?aWxiQ0RFNmsrWk9EMTRQaFlWU3g1QWF6em82cU1Ta2JST3haUVNYWTBIa1hW?=
 =?utf-8?B?OUdkRmVBT1c2dHVEK1l3SlY3NmtHSUs4bHgwMXFTOWlQK2VLYm5BaHBkcUNx?=
 =?utf-8?B?ZnZPMzlDc0ZibVFtQ0E5dVJ1TXFRMDNBMGtGdUlzMTdmTmI0WkpoWFZxUWNL?=
 =?utf-8?B?ZFZpMUtIQy9LT0x1aVRYeitJUnNqbzV4dVoxcXJnaXlJWC9xZFd1cUdkalQz?=
 =?utf-8?B?ZmhDRFNWdFVHZEM2ZjhWNVF1TnJQZzZxc1RLZW5yNTlIZ1R0UFBIWEcvLzV1?=
 =?utf-8?B?dWgyOUdRQlhlZWduSENvbFJHSlZLTlVPMHQzcHVLYUFyc0g4aFlEcFJNRGpo?=
 =?utf-8?B?Y3FXS0hEeThmSTRvWWZ2RENUV1crTmhocHFaQVk2VnoweGNiUTF2cisyYjdn?=
 =?utf-8?B?Y1YwQUhhaHU5bkpGLy9MQ3pTbTA0aC9zY0hIdlIxTzVaajByL012ME8wN0hR?=
 =?utf-8?B?WFBTLzFhUHlEUFhBOE4zajFUcnZNNHZ2c05jeWpoaFRzK3JTTmFscXlwSk1G?=
 =?utf-8?B?cmhhQVFJU3puZmJySENoMFdsRTVubTFRVXRxRi9yY05YWW5qenZHNTR4dGFV?=
 =?utf-8?B?cHlWV3dKQTZCTG5zMGpySWtRaFJJWE1wSWxIVWRaSUJicmNKK1VZdGFjUzlv?=
 =?utf-8?B?ejc2bllvdXU1bjU3QzdCd0NLa2dsZGFOa2ZOUm82b2ZXbkxPZXNTSUQ2Umk0?=
 =?utf-8?B?OExVMWZWSzBIbzVzZlp2MDlvWHZmUHYzbjkycE5iTVhlejlKVlJac1l3REli?=
 =?utf-8?B?NjR3angxakFOVlJqMlAyVVY5QTRFSUFjY1kzUjVhUzlmRGNJK0RQVzhBbkpp?=
 =?utf-8?B?ckNMZEpJcDRacm9jTzZ3TWlZbE9VNVZlc0xPbzZoTVBBTkdXVjNtMzF1QzQy?=
 =?utf-8?B?U2pJN29qV1htbkkrODVoWlJCMVJmVjFJdHdDQ3ZmTUxhKzdmdGNVZG1PU01k?=
 =?utf-8?B?dFBtNFI2V2I1OUJhSlY3NmlzUnRoUWhiWUJLejZvM0NXS3gwTksrd240RFZN?=
 =?utf-8?B?c2VTMjFVaTgwYXkwamtKUjI3OTNCVlZvOTlTRTdtNi9zSjkzSFpKTEVqQjlr?=
 =?utf-8?B?Ui9oR1U2YmRZQjI0VWtQOG1IL2dIb1JVcS8yZkdDdm5FM1lkUWFOZGZQdEZD?=
 =?utf-8?B?Q3ZSeWxYZXlzcUluSlNnTHNibGxMTDAreHZPbkRXeUhPeXlyMFBkWEdlNDJa?=
 =?utf-8?B?SUhPdTkrSjN1YThaWDgrR2JSL05TY2V1ancrbEUxVlJJNnhxbEJSa09aeSs1?=
 =?utf-8?B?cmlJVm1qb1RFZzZVMnFtMUw5U05KZzhZQmxJdmJyV3Q3ZDBGWmRraVVFbFg4?=
 =?utf-8?B?TGVNK2k0anozT0djbzQrYVdheSszY1p0OHpPbThpZVdqcGowbWZQcUpxdVhu?=
 =?utf-8?B?WXFmZDNaRWNMZWdkWUoxWjAxWXhFY1BNb2NOa2tGemZVTUJmazBlT3hmaXNJ?=
 =?utf-8?B?YWF1aUN6aGdNS2dhb0t4eWdiODltK0pBdGJaaVcyQUJSNktZcnJlZlU3eXpW?=
 =?utf-8?B?TmppbGJOWTFCd3ZteGR6aWMrdytYNmZTcHVGcmpYSFdRalVOV1hjcC9ZclVJ?=
 =?utf-8?B?a2c2NHhWenhOQTJYOFdINDdRMmxNYlV2NnNqU1FVWk9YS0dBSzR3QVpDdi9H?=
 =?utf-8?B?TFNuYXRkZmQ5V2ZQTU5pbmpDc1Vka3hrZytwajVtWEIrdU1jTkxmNCtPdWFZ?=
 =?utf-8?B?RU1NdXpsOWpXYnN5aHJpMGJjWEQ4ODVZSHI4SWNzc3FBNzN3ZVlzbHhGbFlx?=
 =?utf-8?B?STBaT2dIczE2QnN0c213MEQwbFlhOTZCWEhpcmdDVGZVWGg2dzdQMUp6N2Nt?=
 =?utf-8?B?SWdrWFJ1WG1LWHkrNVZ3VlgvT21TdkxmOWQzUGRNMThIUEZRU0p1Wlp6WTg2?=
 =?utf-8?Q?n6um2B8yUe/kic0U9D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e64c59-473e-497d-c3e8-08deddaa248a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 11:06:36.1736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q30j038w97Iefa3MGeWQgfmYt7q5nPlQGttgQtipo58GZaeRPAlX2fZGu6fvOBr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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



On 09-Jul-26 4:05 PM, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Lijo.
> 
> Yes, the current GIM driver ensures the early init data is placed within the VF’s visible BAR0 aperture.
> 
> 

Not just for current, is this also applicable for old host driver? 
Otherwise, this breaks on old host driver.

Thanks,
Lijo

> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, July 9, 2026 3:56 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in sriov mode
> 
> 
> 
> On 08-Jul-26 6:12 PM, Li, Chong(Alan) wrote:
>> AMD General
>>
>> Hi, Lijo.
>>
>> " In this commit, the statement is different."
>> " It says FB access is enabled if init_data request is sent."
>>
>> Yes, VF FB access is enabled if init_data request is sent.
>>
>> However, without full GPU access, the guest cannot access the MM_INDEX/MM_DATA registers.
>>
>> With the legacy/existing read path, VF_FB_EN must be enabled so the
>> host can dump early init data into the VF FB, and full GPU access is required so the guest can copy that data through the MM_INDEX/MM_DATA registers.
>>
>> I submitted patch " [PATCH 1/2] drm/amdgpu: read FB through BAR0 when
>> aperture is unavailable " , With the new
>> amdgpu_device_read_fb_via_bar0() path, the guest can read the VF FB
>> without full GPU access
>>
> 
> Yes, I saw that one. One other question - does host driver guarantee that discovery data will always be copied to visible BAR aperture of VF?
> If not, it will still require mmindex/data regardless of FB access enablement.
> 
> Thanks,
> Lijo
> 
>>
>> Thanks,
>> Chong.
>>
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, July 8, 2026 7:18 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Li, Chong(Alan)
>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>> <HaiJun.Chang@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;
>> Cursor <cursoragent@cursor.com>
>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>> progress in sriov mode
>>
>>
>>
>> On 08-Jul-26 4:18 PM, Christian König wrote:
>>> Hi Chong,
>>>
>>> On 7/8/26 12:25, Li, Chong(Alan) wrote:
>>>> AMD General
>>>>
>>>> Hi, Christian.
>>>>
>>>> The code " early_full_gpu_access = (adev->virt.req_init_data_ver == 0);" is related to the ASIC type, not the host platform:
>>>>
>>>>
>>>> adev->virt.req_init_data_ver is initialized by amdgpu_virt_request_init_data().
>>>>
>>>> Some legacy ASICs, such as CHIP_VEGA20 and CHIP_ALDEBARAN, do not send amdgpu_virt_request_init_data() to the host.
>>>>
>>>> For those ASICs, the host dumps the early init data only after the guest requests full GPU access.
>>>> Therefore, those ASICs still need to request full GPU access before the guest driver can read the early init data from the VF FB.
>>>
>>> No, exactly that is not the case as far as I can see. See the commit I mentioned below.
>>>
>>> According to that starting from SIENNA_CICHLID the full GPU access is mandatory for reading the discovery table.
>>>
>>
>> It could also be because the legacy/existing way used mmindex/data, and that required full access including mmio register access.
>>
>> In this commit, the statement is different.
>>
>> "In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN and places early initialization data, such as IP discovery, VBIOS, and PF-VF exchange data, in the VF FB"
>>
>> It says FB access is enabled if init_data request is sent.
>>
>> Thanks
>> Lijo
>>
>>> So I absolutely clearly have to reject your patch here.
>>>
>>> As far as I can see this is a hack for ESXi and that is not going to fly.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>>
>>>>
>>>>            static bool amdgpu_virt_init_req_data(struct amdgpu_device *adev, u32 reg)
>>>>            {
>>>>                    ...
>>>>                    case CHIP_VEGA20:
>>>>                    case CHIP_ARCTURUS:
>>>>                    case CHIP_ALDEBARAN:
>>>>                            soc15_set_virt_ops(adev);
>>>>                            break;
>>>>                    case CHIP_NAVI10:
>>>>                    case CHIP_NAVI12:
>>>>                    case CHIP_SIENNA_CICHLID:
>>>>                    case CHIP_IP_DISCOVERY:
>>>>                            nv_set_virt_ops(adev);
>>>>                            /* try send GPU_INIT_DATA request to host */
>>>>                            amdgpu_virt_request_init_data(adev);
>>>>                            break;
>>>>                    ...
>>>>            }
>>>>
>>>> Thanks,
>>>> Chong.
>>>>
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Wednesday, July 8, 2026 6:24 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Li, Chong(Alan)
>>>> <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>> <Victor.Skvortsov@amd.com>; Cursor <cursoragent@cursor.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>> progress in sriov mode
>>>>
>>>> On 7/8/26 12:03, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 08-Jul-26 3:23 PM, Christian König wrote:
>>>>>> On 7/8/26 11:35, Li, Chong(Alan) wrote:
>>>>>>> AMD General
>>>>>>>
>>>>>>> Hi, Christian.
>>>>>>>
>>>>>>> This version of the patch is not host-platform dependent; all host platforms follow the same path.
>>>>>>>
>>>>>>> I verified this patch with KVM in my local environment and with ESXi on a borrowed server.
>>>>>>>
>>>>>>> Distinguishing the host platform was a mistake, and I have
>>>>>>> explained the situation at the end of the patch email.
>>>>>>>
>>>>>>> I have pasted the content below:
>>>>>>>
>>>>>>>             Hi, Christian and Lijo.
>>>>>>>
>>>>>>>             Sorry, I made a mistake.
>>>>>>>             Host access to the VF FB is not platform-dependent. After the host driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the VF FB.
>>>>>>>
>>>>>>>             I borrowed an ESXi server and tested this patch there.
>>>>>>>             The amdgpu driver works normally.
>>>>>>>
>>>>>>>             I rewrote the background. Is anything still unclear?
>>>>>>
>>>>>> You still have this check here in the code: "early_full_gpu_access = (adev->virt.req_init_data_ver == 0);".
>>>>>>
>>>>>> As far as I can see that is Hypervisor specific and a NO-GO.
>>>>>>
>>>>>
>>>>> I think this should be seen as a policy set by host driver on when a guest operation is allowed. Host driver could do it based on other conditions also, not specific to hypervisor environment.
>>>>
>>>> No, this was intentionally changed in 2020 because of a new feature. See this commit here:
>>>>
>>>> commit 00a979f3d69e0c275e88c741b854dbe0d5238ae0
>>>> Author: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>> Date:   Tue Jun 23 13:43:49 2020 +0800
>>>>
>>>>        drm/amdgpu: invoke req full access early enough
>>>>
>>>>        From SIENNA_CICHLID, HW introduce a new protection
>>>>        feature which can control the FB, doorbell and MMIO
>>>>        write access for VF, so guest driver should request
>>>>        full access before ip discovery, or we couldn't access
>>>>        ip discovery data in FB.
>>>>
>>>>        Signed-off-by: Wenhui Sheng <Wenhui.Sheng@amd.com>
>>>>        Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>>>>        Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> So as far as I can see this change here will break older hypervisor versions and that is absolutely clear reason to NAK it.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Chong.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>> Sent: Wednesday, July 8, 2026 5:05 PM
>>>>>>> To: Li, Chong(Alan) <Chong.Li@amd.com>;
>>>>>>> amd-gfx@lists.freedesktop.org
>>>>>>> Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun
>>>>>>> <HaiJun.Chang@amd.com>; Skvortsov, Victor
>>>>>>> <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>;
>>>>>>> Cursor <cursoragent@cursor.com>
>>>>>>> Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init
>>>>>>> progress in sriov mode
>>>>>>>
>>>>>>> On 7/8/26 10:25, chong li wrote:
>>>>>>>> v2:
>>>>>>>> Some legacy ASICs do not send amdgpu_virt_request_init_data().
>>>>>>>> Only keep the full GPU access request early when request_init_data is not sent.
>>>>>>>>
>>>>>>>> v1:
>>>>>>>> Move the initialization of non-GPU resources out of the full GPU
>>>>>>>> access region during AMDGPU device initialization.
>>>>>>>>
>>>>>>>> Background:
>>>>>>>> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
>>>>>>>> VF_FB_EN and places early initialization data, such as IP
>>>>>>>> discovery, VBIOS, and PF-VF exchange data, in the VF FB. The
>>>>>>>> guest should then be able to read this data before requesting full GPU access.
>>>>>>>>
>>>>>>>> Before this patch, the VF still requested full GPU access in
>>>>>>>> amdgpu_device_ip_early_init(). At that point TTM is not
>>>>>>>> initialized yet, so the normal VRAM aperture mapping is
>>>>>>>> unavailable and the guest falls back to MM_INDEX/MM_DATA
>>>>>>>> register access. That register path requires full GPU access.
>>>>>>>>
>>>>>>>> Use the BAR0 framebuffer read path,
>>>>>>>> amdgpu_device_read_fb_via_bar0(), for the early init-data copy
>>>>>>>> instead of MM_INDEX/MM_DATA. This lets the driver delay the full
>>>>>>>> GPU access request until after the early init data has been copied.
>>>>>>>
>>>>>>> That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.
>>>>>>>
>>>>>>> So once more: We can't adjust the driver to the hypervisor!
>>>>>>>
>>>>>>> Either this works on all hypervisors or I have to reject the change.
>>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: chong li <chongli2@amd.com>
>>>>>>>> Co-authored-by: Cursor <cursoragent@cursor.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21
>>>>>>>> +++++++++++++++++----
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>>>>>>>>      2 files changed, 19 insertions(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> index 610d82b79de3..ac66796e8634 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>> @@ -38,6 +38,10 @@
>>>>>>>>      #include <linux/apple-gmux.h>
>>>>>>>>      #include <linux/nospec.h>
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_X86
>>>>>>>> +#include <asm/hypervisor.h>
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>      #include <drm/drm_atomic_helper.h>
>>>>>>>>      #include <drm/drm_client_event.h>
>>>>>>>>      #include <drm/drm_crtc_helper.h> @@ -1987,16 +1991,19 @@
>>>>>>>> static int amdgpu_device_ip_early_init(struct
>>>>>>>> amdgpu_device *adev)  {
>>>>>>>>           struct amdgpu_ip_block *ip_block;
>>>>>>>>           struct pci_dev *parent;
>>>>>>>> -     bool total, skip_bios;
>>>>>>>> +     bool total, skip_bios, early_full_gpu_access = false;
>>>>>>>>           uint32_t bios_flags;
>>>>>>>>           int i, r;
>>>>>>>>
>>>>>>>>           amdgpu_device_enable_virtual_display(adev);
>>>>>>>>
>>>>>>>>           if (amdgpu_sriov_vf(adev)) {
>>>>>>>> -             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> -             if (r)
>>>>>>>> -                     return r;
>>>>>>>> +             early_full_gpu_access =
>>>>>>>> +(adev->virt.req_init_data_ver == 0);
>>>>>>>> +             if (early_full_gpu_access) {
>>>>>>>> +                     r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> +                     if (r)
>>>>>>>> +                             return r;
>>>>>>>> +             }
>>>>>>>>
>>>>>>>>                   r = amdgpu_virt_init_critical_region(adev);
>>>>>>>>                   if (r)
>>>>>>>> @@ -2159,6 +2166,12 @@ static int
>>>>>>>> amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>>>>>>>>           if (!total)
>>>>>>>>                   return -ENODEV;
>>>>>>>>
>>>>>>>> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
>>>>>>>> +             r = amdgpu_virt_request_full_gpu(adev, true);
>>>>>>>> +             if (r)
>>>>>>>> +                     return r;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>>           if (adev->gmc.xgmi.supported)
>>>>>>>>                   amdgpu_xgmi_early_init(adev);
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> index 9a40107a0869..340703d89d6b 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
>>>>>>>> @@ -185,8 +185,8 @@ static int
>>>>>>>> xgpu_ai_send_access_requests(struct
>>>>>>>> amdgpu_device *adev,
>>>>>>>>           } else if (req == IDH_REQ_GPU_INIT_DATA){
>>>>>>>>                   /* Dummy REQ_GPU_INIT_DATA handling */
>>>>>>>>                   r = xgpu_ai_poll_msg(adev,
>>>>>>>> IDH_REQ_GPU_INIT_DATA_READY);
>>>>>>>> -             /* version set to 0 since dummy */
>>>>>>>> -             adev->virt.req_init_data_ver = 0;
>>>>>>>> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
>>>>>>>> +             adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>>>>>>>>           }
>>>>>>>>
>>>>>>>>           return 0;
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

