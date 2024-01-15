Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD7DC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jan 2024 20:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4EB610E38C;
	Mon, 15 Jan 2024 20:21:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1580D10E38C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jan 2024 20:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWXgRuVlpIRAfmZic+eArEEt7x1yGhJqpbB5qhIdlAeaINEgYI1j/Xl28+DvPyrMo2zMl+0C4SA28aTPUV08VLBcE5kN8mTshm531TYo5QY+l6UxzPrBkUlOW46Zlc0FKHJgsHQnA5CvuuDqEL7Ca9UC/UalHRVpQueG+dyqf3OCHR5jABjcFtYLG6XRp8oEuWEfGSZaLW/4ZplcfjEAfe2rEaUMutbTSNS33bSlrX7WzHLzTV6MZ9GyBjR1/1K1V1Dv3gJ0b2hVdM+K7HyLZl1DcpHA0GdkL1Maezp1ZJfMabE23pUCMD+raWKzhxTDhupJkm1lfqeGlI3fFGyeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaZrDfjomXpMe1TTdduSPCmjDzoLWwuR7uTMl/ubZ2Y=;
 b=g45JRqZxlrYHAm9nwnxbaZq5bIVvsSzBiZ8bNK3PjYr7De6tWJS9PP+EvBPbXIg1BKoqQiCBdpeTcpB5u7UNoIzYefGeL4wxwYeSNvWz7KGOVCF9n+kjkvDrfE8gYUXSC3QqlJ7GZl+Z8KPDs/VnysoQ6YFPmYcixwUHUlVIW56O/8h1pulMvKBQU4jJueHL/iKu6TT1eKyANReKBmkp3z9ULC1pc3eOs+ANnOqwvlW2JUqA+pDmFhA+PAMQJsq9QpTGExiWsQg5hy5DQMoA9GxzDxja3d8sH1+QMEbbPUTfuPm56Vm4SermnyZApwQ1BPmdNZWF4FBrDJDYgYBeqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaZrDfjomXpMe1TTdduSPCmjDzoLWwuR7uTMl/ubZ2Y=;
 b=f1+l58D53yicIx1iHFI6d9khcYTw/RtXjPAGptYkyTPJwVDInDA7a9NG6FZV+vugXhltSiGHLelz2aSiWDoYCN3hinGOpX98kcPs0tVjnP4EiwHMQ33FGQQ55O11Q34KCQE/jkGSvJJgD7HagQ3jXrppiP0XakbqYujEdP9XSHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DS0PR12MB6533.namprd12.prod.outlook.com (2603:10b6:8:c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 20:21:08 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 20:21:08 +0000
Message-ID: <29326bb0-ab25-424c-86c1-799c6d630e28@amd.com>
Date: Mon, 15 Jan 2024 15:21:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation for RGB strip on RX 7900 XTX (Reference)
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alexander Koskovich <AKoskovich@protonmail.com>
References: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
 <BL1PR12MB514454D5E625F71BB0E6A8B6F76B2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <1b679a75-27ee-4682-8bf1-c0defcd9e949@gmail.com>
 <x5k4aAAKV_idHdVtHJSqsc8HjaGPyGe36A9cpXQl_tBbqgHrQ8TaVKm_zoQRodcwfFuGUj4GnnNASL5a7SKfL1H-NH5X4ma5G_vRkXSG35o=@protonmail.com>
 <43e7ff66-f6cf-4804-ab90-ee14546dc4b3@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <43e7ff66-f6cf-4804-ab90-ee14546dc4b3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::25) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DS0PR12MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 3381191b-a8ff-4019-9592-08dc1607820c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: olA64RXgGvWWDj7nUtLqy8kccma63awGmWayKGfbF28RwdSN9i4aI/cmYdAZbkYSXra4Zpm3z2MTOlCo/jpxSakt89Zyfl0rEJf0Ulv7qHxRFLKKMcl5CtV5xaLDO8GH598Kmemka8Or4pZuo2j7UYeiaScGoKsxnzwMbPiqidnbG40Kf7fGa7ZGIbKmWdUSTd6EPD5NtYrL8Cyds71R4Ap9TUZIpQQYmppuwolVCGvXzlqVtNA7QqIsVdWZ7vlvd1WUKI04qWlsIYVEXFmRrliT4xcErnUHZ53NlqCTR7iRHml3xUics/szYjIyVaTFfQbS4NnexvYt/OcTuhqw/X7fJLEfmHAUqcMwgqqbtOLx3F/BwUpp5ynVuB8bGkYAds4RuKWUVhJjkmbf0MgBvW02YcrgFTuAtEcn0a5HMUhdkFqMrXne5zslFCILv8T1wAZ/uggSqPQR52mj/J2wZQAK6ou13pPrBZJjUUfYZJqrwTxg8wG5iQmVq3Cyq7szQyBmFVukSjRpvb8UsXjfTai0MyyPvXESGzCpMSRcd71TEXHzVWjE/AAKSM9oRNmm6qP4TaULld5BmEw1icv4LVtydafge50qL2nWne4pmKLdxjZKfuPLO4jAJUIltHt92tEra/KACvuzmFjwHMTplA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(2906002)(478600001)(44832011)(8676002)(8936002)(4326008)(53546011)(6666004)(6506007)(6512007)(66946007)(54906003)(316002)(110136005)(66476007)(66556008)(966005)(6486002)(41300700001)(31696002)(31686004)(86362001)(2616005)(36756003)(26005)(66574015)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlMRkJ5Vm44RUxqYXQ5TnJ5dWVtWHRncGFNSDh4dEpMbit2RnBKbmFtcWYy?=
 =?utf-8?B?cUVBTjVLUHovUVdpbkdxdjdJaVBldm1reGhRSWpCdzJMNjM0WGtEZ3ZUNWFY?=
 =?utf-8?B?MUN1a2NHQ1FIeFpITDhmaFBMa09lYjNXQTgzdlNZd1BiUldIT2JkMnpZTEFK?=
 =?utf-8?B?Rlcxd25CalpYZDJEQkRVaC9OWm1FQ3VIQlA0bllObUxvbWYyems3eXdpdlI2?=
 =?utf-8?B?MGFYRUYzbDMzZEJnUDdab1JlTlRlZHVTOW1CVDBRdDF4NFZMOFJyUkxQMVgv?=
 =?utf-8?B?MW5HdFhHWW5UM3hxK3BjM0xoc2p1dEhZMUZVUEt2T1dadXpzaEhGdHhBL2FS?=
 =?utf-8?B?MHp6QWw5YzBKMHBwN1ZVWXhXN2kvODRLVm02MVhrditzd3ByaGdTV1kwOXJz?=
 =?utf-8?B?KzgxWE5oQWtQM2I5Rm5HaHhuSEVyQ2t6WGJsKytTZzg5MmtLZm55eVRDSXVB?=
 =?utf-8?B?bjhFK2V6UFloaktpdUFUako0VjNZZUh3bEQ1WW52emVKdFc5aStNUVJYTHN5?=
 =?utf-8?B?cDZRcEw5TldTNC80aEE1aGhxNmRaU0orTFRReGZ4NFBINW51Szh0WEkwKzZr?=
 =?utf-8?B?Uld1a0FsODllazdBb3pkMTBudm1YQnRVelVoTnBIREJqQnAvbENsZmpNTmp0?=
 =?utf-8?B?U2czUE5yK0JhbXlvMWhSZkJKZW40emQvdkN1V0s0Q0d4ejZWTG5sajkrclpJ?=
 =?utf-8?B?WGlqbUIxekczVldNZGZwMXliN1B1Ny8rQXV3Z29yT3M4b2UxWkNqelorUC9H?=
 =?utf-8?B?RnRKYjg5RXRjcWNETkdLUFVub25TbHF1aFZ4NFVCQlBnRG8rS3F5UWdzTFNL?=
 =?utf-8?B?S09HZzgzMWF3c1dTQjlqYk43dmQxeTBJY1FEaDNvb1pFMG1DQWRtZ0FtMTNW?=
 =?utf-8?B?VmpjWk9IWWxidzZ1TVFzQ0FxSitOcFlpb3pXNnFDK3ZJVDE4M3NTT0t4b3NJ?=
 =?utf-8?B?KzZINWovVG84ZmJJNUJOV3pUOW54ay9MODNmN3BvbTF2M0RaZjcvOUpuNm5j?=
 =?utf-8?B?MW54S3QrWFpsa3hEQmRVSDkrRzlBQnBZdEl6UHI2cWUxeDkvb2hzMUhxQmxY?=
 =?utf-8?B?MG1IS2lDZ05IbU5lL3FFTk8xdUJURGYxZ2pWS211WWJtSE95UmVBWE5PZWNH?=
 =?utf-8?B?MnN0WVA0QlZPUExwV1cwMWNmWXAxRmtiMEhKcjhUUHJ5MUlKMHNKVnpEcTZ2?=
 =?utf-8?B?YU9PUGJFZGpEM0xjREE3c045VEt3cktWdVNGR0hWMDBjTW9xM1VkWmU3bzFq?=
 =?utf-8?B?SUZTK0pqWHcyY01SaDRwOWF2SU5Lbytva05iY1JqcnAxNERxczBTSThSWUZv?=
 =?utf-8?B?OENPSnphS2F4UjVCSy82c3FOVjNmR1V6dUkzR1FrcUo2amlVd0FlUjEyenNW?=
 =?utf-8?B?cllqc3RJcUZIZWZ0QVM3YlJKSU5kYVdnT1orNGU1RURabTgyb3VOOWtJcGND?=
 =?utf-8?B?WHcveU5rM1hJZjh4ODZTd0lIQ1FMTjRMTW1zMlc2andScVMzT3Fwb0EwTWcw?=
 =?utf-8?B?WlZaamZlSjlKdkVORmhTdkhuRW9SSWt3NmNGZEU4MlZ3a2ZYUk1TejEzdjZ2?=
 =?utf-8?B?QkRjb1dVTVpOYVdiTHdHcHNQVGNSZ2lIZ3h1Znlib1F4eEtmQVkwQ2JKTVh1?=
 =?utf-8?B?akJZS1VPby9qeDNDcWNCNFovYmhFSWFQaFdKVjdFNnh0UGlpYzNvYVZ0K2NU?=
 =?utf-8?B?R0ZFY2hVdlNGNFZJVkt3eUJONDJLeGluR09sZ2prNVBubnBUTmcxODh3R0tl?=
 =?utf-8?B?RXQwSFdhOFUyTmgyU2xpR2VMTHF6SEdRMWdpdmswRzVtWDd1VEx3eTRzdCsv?=
 =?utf-8?B?ejkxMVd5dEREMnFSenhENExRbjJldFpXTFZSQWZMMnN3amlmOGVmL2F1SU0v?=
 =?utf-8?B?djBsTnRsalVzcStCUGlLQVUyTEZjUmplZ2lDbml5NTlLMGxqMnowdWpQM0NR?=
 =?utf-8?B?M1pGMGlMaHFlWUNRY2ZVVzhOUXVXcGJvWVZlVC91SldHWG5LaWxxNlZIOERw?=
 =?utf-8?B?dEFyQmFyYmVJZ3JVYS9XRHNSY3Y1dXFXeGFSTjFWN0N0SkZ6SXA0aXFxODBR?=
 =?utf-8?B?Q2U5dlZadVl2bEphanN3RnBIQjhjTkVDUi9vSmd3cTJYbDRUMGhLbDdBYXkr?=
 =?utf-8?Q?WBd5cGNhIl+Sxkc1klwm7lGMr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3381191b-a8ff-4019-9592-08dc1607820c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 20:21:08.4224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnBP6CvP2SRfWG1xenK9SfZd6jZbNda/CjGqQAi813x8VtkbHG67cbjk6le2/zObEmXejHdGhyPpoUXvbjOlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6533
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2024-01-09 03:31, Christian König wrote:
> Am 09.01.24 um 09:23 schrieb Alexander Koskovich:
>> Thanks for the info, will take a look.
>>
>> Also just to clarify, this is the first party AMD 7900 XTX, not a third party AIB (e.g. Sapphire, ASRock, etc).
> 
> Yeah, but that doesn't matter.
> 
> For the reference designs AMD basically just says how it should look like and then somebody else stitches it together. The handling of for example how connectors are detected is still the same.
> 
> AMD should somewhere have detailed documentation what's on that reference board, but to be honest I have absolutely no idea who to ask for that. It's simpler to just look into the tables used by all vendors.
> 
> Regards,
> Christian.
> 
>>
>>
>> On Tuesday, January 9th, 2024 at 3:02 AM, Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>
>>>
>>> Am 08.01.24 um 23:32 schrieb Deucher, Alexander:
>>>
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: amd-gfx amd-gfx-bounces@lists.freedesktop.org On Behalf Of
>>>>> Alexander Koskovich
>>>>> Sent: Sunday, January 7, 2024 11:19 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
>>>>>
>>>>> Hello,
>>>>>
>>>>> I was wondering if AMD would be able provide any documentation for the
>>>>> RGB strip on the reference cooler
>>>>> (https://www.amd.com/en/products/graphics/amd-radeon-rx-7900xtx)? It
>>>>> looks to be handled via I2C commands to the SMU, but having proper
>>>>> documentation would be extremely helpful.
>>>>> It depends on the AIB/OEM and how they designed the specific board. The RGB controller will either be attached to the DDCVGA i2c bus on the display hardware or the second SMU i2c bus. The former will require changes to the amdgpu display code to register display i2c buses that are not used by the display connectors on the board so they can be used by 3rd party applications. Currently we only register i2c buses used for display connectors. The latter buses are already registered with the i2c subsystem since they are used for other things like EEPROMs on server and workstation cards and should be available via standard Linux i2c APIs. I'm not sure what i2c LED controllers each AIB vendor uses off hand. https://openrgb.org/index.html would probably be a good resource for that information.
>>>
>>>
>>> It might also be a good idea to look some of the ATOMBIOS tables found
>>> on your device.
>>>
>>> Those tables are filled in by the AIB/OEM with the information which
>>> connectors (HDMI, DVI, DP etc...) are on the board and I bet that the
>>> information which RGB controller is used and where to find it is
>>> somewhere in there as well.
>>>
>>> Adding Harry from our display team, might be that he has some more hints
>>> as well.
>>>

I don't know how the RGB strips are connected and controlled.

Harry

>>> Christian.
>>>
>>>> Alex
> 

