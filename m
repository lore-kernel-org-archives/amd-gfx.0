Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C851C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 15:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DA110E70E;
	Mon, 16 May 2022 15:13:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0591410E70E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 15:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw41ouO2Buk7ylqt6nqeSe55M1ZfczCg/KucS6kzBchTprtePNBDKgvNP0aLB+2eEzlspsn7QulXGAcPHZ6OmHL3IERk9f5QNoIr8Hc3uP0bLCV78j915Gnu+SVS4861/cEkmup8MucFiTxAqpvRUVTL5Qddg2SEBQL4c3yt6nRu90B8eDsVGPRwOM1QS/vr+cOzpwY1m/ngmwi5lae4MEjrdsq68vOIXIsKLQ4HjVgA2f49VXwoj90X/CycZkJDDHC6h6oqE7n+GCJOzuboG1p/1Oz+1hhh9gx0yIZ+al+809kvbiP7UnfLo4fhmuKylK9ocjKAkkNLGcdJduTTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMt9UwVxm2OA4zX0to4NTsgNgz7oed3mR02bJ1bcaOo=;
 b=AvPM2N9M4nNWoUfAFMwkD50xS0inPlDeZp11wyWfeKNur+dw1rfKUPCTnYM2JvDapK5Y1JaNb8Lk3Gwrqd9J56gnhpEw7iRFCgzKvEWxODSC20+h1QwzRyxbB6QJrHioIJki/UtNSDfNBURKCf8i20ZqJR6Zzw3KNE75xGfHkoJVl0RNhNps41gszdZfF/AG1B+qohBSw/UYDyNUx36FK0Ngnf3RXKWCbxTkn7GLrLh9uPfkwGpggqxJljKoufkRtb/sSXAG3O/iev9vIQg1MVEplbfFF6S6HBztyWWbSbiYnbAt9oO9X6aIjwZNp3QlXYIOtc9ZkJ47j4rurqzg6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMt9UwVxm2OA4zX0to4NTsgNgz7oed3mR02bJ1bcaOo=;
 b=SQH2/MUYep0ibiDCLut16UF6G9BXdgz1irycs6Ktv3gbizC9KKLkA/GB62eMMg/w9Bmhf5NE9mEi40+LyR4irHiVzQYEktGmR63aZE4jDwZcU6YoPIGFSDVMRM18vhN7PtDI1Uq4frOEtgUB3CwOBrThFZPRsfSVRLi7m0QuHqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CH2PR12MB5563.namprd12.prod.outlook.com (2603:10b6:610:6a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 15:13:45 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::9d18:7a38:7c5d:4a40%10]) with mapi id 15.20.5250.018; Mon, 16 May
 2022 15:13:45 +0000
Content-Type: multipart/alternative;
 boundary="------------ONMMCJihjgOenSWTxG0f0eRJ"
Message-ID: <cdcb0377-5c7b-5493-57bf-139b00d0b332@amd.com>
Date: Mon, 16 May 2022 11:13:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Fix multiple GPU resets in XGMI hive.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Lazar, Lijo" <lijo.lazar@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220504161841.24669-1-andrey.grodzovsky@amd.com>
 <ffad0f2b-b975-c099-a96d-98f82bc972ab@gmail.com>
 <3cefe63f-1f27-db1c-aeee-3731ca1e6d1d@amd.com>
 <df5deb8c-1a33-e177-ce26-eaccae179786@amd.com>
 <2b9b0047-6eb9-4117-9fa3-4396be39d39a@amd.com>
 <fb066a24-3737-ad5d-d098-ef0b5d4a54d4@amd.com>
 <2d366654-8df3-c6ae-d6fc-4fa94fc32fb1@amd.com>
 <3e0c3d24-2135-b02f-93a3-ab2a597c794f@gmail.com>
 <9cd38f76-13d0-7e99-9c8c-dff847c6cf2b@amd.com>
 <6699d9ec-501d-d2d5-2220-88fb754819a7@amd.com>
 <27535877-a13f-75fc-368f-68105dffc7f8@amd.com>
 <7330c50f-4623-c377-9486-c9a8fa884e15@amd.com>
 <4a52a938-f758-4b51-1f71-599a4af23e20@amd.com>
 <b9fd9cf5-1ae1-a599-576d-74f13b0351d5@amd.com>
 <4e88f5a0-11b7-ac14-ce77-7e69c2ce75c1@amd.com>
 <180c74b2-226f-fd36-b93b-f8b5140e410e@amd.com>
 <14483921-e454-1ad7-ff45-665366158504@amd.com>
 <0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com>
 <cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com>
 <6cf84065-6341-3f96-4e09-ab71796241ec@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <6cf84065-6341-3f96-4e09-ab71796241ec@amd.com>
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ffe2314-1832-4ec6-9ab3-08da374eab77
X-MS-TrafficTypeDiagnostic: CH2PR12MB5563:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55637B1E00BD4D8E24384C12EACF9@CH2PR12MB5563.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aI3I4WARD7HQv8kbEdMvT/t4IjqdDXEtnVAdegrreGbD4NPy7FxZRogH/GLnq3GZC4objkN7iTf8ZhIm0vGE5oFdR0o8pXF6yLnAxnbIoLlenCnnjxvBTOQSoDiAcjimG4VlcuwAypUI++Y8w/yMpDXqC1O8Sp0xQTu6HwXcYcFyCOx7cwhVJq+8j53h87602DJ0w0TygQPt/eZlG9WNkLBmxvMvbWd3MMqwKUMjRnWGpBv4EsS9KHn9tHWfWRENBdbPuPO4PpKF+XzTjOTQfCQ1Fwq6z6COrpTqusqiNdsvk6tVT4lNHK8ynwj+yKIuUgoan2z58plML13dfYpYR6yhRJ5K1vdLuZtEoOT3B2kaSuajbKu9EV1afePRYtDXuokxkh4XnRyn5PaiV/95RxRZRDgGc9etmjPs4HMEe6M09T3Dgxf6QycsstTw/koTtnTqypG/M8vD9T9y7b2lMibKO9T8mXSISPR6usht2ujZ1nmvhCa16pEMv9K7l4kB3ckkogboSbYWfVwJzV/CDC7XXH+ISn066PVLDNLFaqRbxmYXxbFkTbFil7RhN+a45DLYa4XtdJ5VL/GQPanOJmnQZlM6WLAWq5hnKpsKB/Ac+Ve4CgxA1tybYZNsLtryDEvQ8kJbAwvMC1PeIo+3A9cnyI59t6T+P9RNfaoWYBdaarM8N0+LnwbDie/UYrTfutLcFU5sJofiIi3fOVCg/gMJufTnTPppMo4VjBRu57c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31686004)(83380400001)(110136005)(2616005)(316002)(6666004)(6512007)(6506007)(66574015)(2906002)(6486002)(8936002)(508600001)(53546011)(66556008)(66946007)(86362001)(66476007)(8676002)(31696002)(4326008)(33964004)(44832011)(186003)(38100700002)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEJIcEhTTDBveGNJd3FvZ3N5SW9ZaFYwaVZQbFBxNXVFUW00NEFQem9Ud0NU?=
 =?utf-8?B?ZitZYnFVL2VVb05JUk1rTTI2aWJrcmUzZVhjWTVyUytwL1pXdEd0MU01UVd3?=
 =?utf-8?B?dDFKVXBWVDdhM3ZXano1OVkxOTZrMUNvS1l1Z3hleXZCd1RoUXoxc0dhU09u?=
 =?utf-8?B?UDBnbTdLZDlMSiszNGtpbXF2QkNHR2FDSzFVamRFYlRFRzhMZ0ZBekw5bUlJ?=
 =?utf-8?B?MnhjMWt0SVFPNUMzQ241cXVpaXdqMG9SQ0k4NDJXZTRRVjJ6WDRLMXd2Qlp6?=
 =?utf-8?B?djBiMjhDTVNUWUhUUFdDQ0F5ZGlGYkZtNmFnTGNsWFVDUURnK0NTV1dBNVo1?=
 =?utf-8?B?WHpWRXBhaUMvL0VVQ0kxTGV0Ty9PRWxTUkliMXdhRDlWQkRodStxalgrQVZr?=
 =?utf-8?B?a0lUZFAwZW1vWUpLUDhESjZqakRuaUhieHY4OFVRc3Y0dmhFRXBVUXNHeG1B?=
 =?utf-8?B?Sk5Ld28zaVNPamhKTk1MMFJIcU1pL2lGRnlFUlZUVGNZMEVOMmFXR1d5Wjd3?=
 =?utf-8?B?TUpGa1JXUVBkR1FNb3lZd1AyUElXZ09JTHRRbmkxbmFDMmszSk5pWXlicmps?=
 =?utf-8?B?NWNWeUllcytPaDI3NHZMa2Jpdm5tL21XdVo0amtteXVCV1VHenNYbjZhUlFo?=
 =?utf-8?B?RTVQbEdqWlg0VDFQMU1KdCtya3A4d2h0MGVqNCtrWGRYdUFISTZ6REROSWs0?=
 =?utf-8?B?OEhLcVcxazkwOUphOXAzQjBqK04ySnFmVkdrMjNLcGJrRDhWTkJmMEhMVEsr?=
 =?utf-8?B?NjhjSDd4ZEh5eFNHRlpOS1NRaWU5R1VkT1YvUEVYNGt4SXloS3RKTUpIUFda?=
 =?utf-8?B?bGF5a0pGQm5NYktTNGdjNWN0MEY4TEUvdHNXK3h5Skp5YW9LckhoUk5OaUow?=
 =?utf-8?B?QTEyOTlRcU5kRExqSk1QQnltYUZkcDJ2bWlRMUJRVnd1cG9GdFlxTVNIVkhD?=
 =?utf-8?B?TlJvSmJzVGdwUmlDWE4wVDNIcnpMenlIeU4zQWhGcS9xcUlzaFY0TWNLOS9B?=
 =?utf-8?B?QjgrSXMyaGE1LzIwaktpRWk2NzRCRVlWeVZIMGN3UDhpbU1TOVJ3bFBYRU9q?=
 =?utf-8?B?dVh2TUNSK1VCbTdQTURHWkpsUDE0WjlrbUdqb1dPTHNHZVdBcVhNWGVFaDJ2?=
 =?utf-8?B?a1gvMVJ5TmUwSG1aVGI4RVlrZWJ3ZWZwRE1SZUZJdWMvbGs4dFh3ZnROZkVE?=
 =?utf-8?B?QVN2QXp1Rk5WMnVKalVBMENJZnVMSm5wNXpyVHBtRmpoeGI2SHBDTTlKVHFz?=
 =?utf-8?B?Und6cnE5UkpjWUVTdElwTHdaK2JQSm5RL3dPUm55TzBXdW1QcU1MbiswdFpT?=
 =?utf-8?B?OFJvUzJuM1ZwRjVFeUJCcmlqQmx5dGR0cDl0Z01pWjEwTENyUFo2QU5od2My?=
 =?utf-8?B?UHh4NTFocGQ3MDgrU2cyQUc1ZVpTK2hUSTQvbisrUytOZm8zdDVNQ0RFRENi?=
 =?utf-8?B?b2pEaHo5MXBITlRsU0VSZ0g1WURjUFNzMUVRRVBLOXZwN25BQ3RpUjk4YXF6?=
 =?utf-8?B?K1VCclFzMkhoMjU0Q1FsaTRWS3dyLzlUMlZQcGxMeEdPNlZubjJ2aVJzbVor?=
 =?utf-8?B?YTE1SHR0OWtWelhVVTlYL2VGWmZ4UlpsN1FkOVQ5T1BmejJOSCtnRlh1U2xk?=
 =?utf-8?B?QSsyUjNOY0lhQ2VIK2lTbVdjbjlPOExuVTBvbjk2S2VmVStPczN6OHpTYXBL?=
 =?utf-8?B?SVlXNlhlVWVHLzl6RjRQb3dEYXJLWS9oMHJnTklObkZZWTVmWmZ5QUpWai9z?=
 =?utf-8?B?TE10Sm94SkRJRE04akd0MmNjTVVsNDY2ZVhhSFUrTGJ2R1N0emk3N3p3c2NW?=
 =?utf-8?B?RlRMVm9ZNXZvVFNVMDA0VUp3UmorVGhjRlBDQUhGZXpnMjF4citWR2s0NmpK?=
 =?utf-8?B?dlVCTTArVGdhSDRJOXk0MnF4ZVdjbUJXQjFuenpSRE1jWjYrdjNQazA1VW9n?=
 =?utf-8?B?YUQrVlJsT3p0YUtpZkdsUGlGNGoyTnpNb2Q0Y2wzejVDOGpTc3lWeE9SSndR?=
 =?utf-8?B?ZVZHQ01PemtIQ2F1cEJQSk0ycFBRNEZqNUUxZTFodHhxN1ZaSWVJQWtjUzMv?=
 =?utf-8?B?YXRZcU5OanFvQ2dIb3Uvbmg3dHpWdGdxaE1jckxWVCtSaUp0aTlobGNpQ1B6?=
 =?utf-8?B?VmsxYmp4Q1k0eS9XcVRoWmFiQmlOVXlWK2dma1BwenNUdDlRLzltYVNRd2kv?=
 =?utf-8?B?MVYzYk5YVXByYVREUFNkblY4WmlKbUtWMUVUMTFZZlYwSXBmVnRzWDlpdStx?=
 =?utf-8?B?TEM5UXpSaHAyVS8yanp6WmZZbHBvU2JWWGkzWXhYeTZZbTE4cFcvampPeXUw?=
 =?utf-8?B?TW5tbk1Cemk2L013MFZSM2w2YUVCY28zS2FZZm9KRzJ2Ylp3am1TY1h4dFIz?=
 =?utf-8?Q?oMtxek3C/ZY+6E0RHwX9XPXdnMut7ZgZyNnhWO0meAa/d?=
X-MS-Exchange-AntiSpam-MessageData-1: 5FrdCCr15L1V+g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffe2314-1832-4ec6-9ab3-08da374eab77
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 15:13:45.2409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZAJx+MdSPThqdMGYOEjcaJKXcaAC2ko5G5pWh/v0cKktflMZ5b3KXPxXuO7vax1ndAhyIO1oJkBMaa7l6xebg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5563
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
Cc: Bai Zoy <Zoy.Bai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------ONMMCJihjgOenSWTxG0f0eRJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-05-16 11:08, Christian König wrote:
> Am 16.05.22 um 16:12 schrieb Andrey Grodzovsky:
>>
>> Ping
>>
>
> Ah, yes sorry.
>
>> Andrey
>>
>> On 2022-05-13 11:41, Andrey Grodzovsky wrote:
>>>> Yes, exactly that's the idea.
>>>>
>>>> Basically the reset domain knowns which amdgpu devices it needs to 
>>>> reset together.
>>>>
>>>> If you then represent that so that you always have a hive even when 
>>>> you only have one device in it, or if you put an array of devices 
>>>> which needs to be reset together into the reset domain doesn't matter.
>>>>
>>>> Maybe go for the later approach, that is probably a bit cleaner and 
>>>> less code to change.
>>>>
>>>> Christian.
>>>
>>>
>>> Unfortunately this approach raises also a few  difficulties -
>>> First - if holding array of devices in reset_domain then when you 
>>> come to GPU reset function you don't really know which adev is the 
>>> one triggered the reset and this is actually essential to some 
>>> procedures like emergency restart.
>
> What is "emergency restart"? That's not some requirement I know about.


Emergency restart is something u can see at the beginning of 
amdgpu_gpu_recover function - it's a historical work around for some 
type of ASICs who weren't able to do full reset I think.  We should 
eventually remove it bu for now I thin it's still in use.


>
>>>
>>> Second - in XGMI case we must take into account that one of the hive 
>>> members might go away in runtime (i could do echo 1 > 
>>> /sysfs/pci_id/remove on it for example at any moment) - so now we 
>>> need to maintain this array and mark such entry with NULL probably 
>>> on XGMI node removal , and then there might be hot insertion and all 
>>> this adds more complications.
>>>
>>> I now tend to prefer your initial solution for it's simplicity and 
>>> the result will be what we need -
>>>
>>> "E.g. in the reset code (either before or after the reset, that's 
>>> debatable) you do something like this:
>>>
>>> for (i = 0; i < num_ring; ++i)
>>> cancel_delayed_work(ring[i]->scheduler....)
>>> cancel_work(adev->ras_work);
>>> cancel_work(adev->iofault_work);
>>> cancel_work(adev->debugfs_work);
>>> "
>
> Works for me. I already expected that switching over the reset to be 
> based on the reset context wouldn't be that easy.
>
> Regards,
> Christian.


Ok - i will resend a patch.

Andrey


>
>>>
>>> Let me know what you think.
>>>
>>> Andrey 
>
--------------ONMMCJihjgOenSWTxG0f0eRJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-16 11:08, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:6cf84065-6341-3f96-4e09-ab71796241ec@amd.com">
      
      Am 16.05.22 um 16:12 schrieb Andrey Grodzovsky:<br>
      <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
        <p>Ping <br>
        </p>
      </blockquote>
      <br>
      Ah, yes sorry.<br>
      <br>
      <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
        <p> </p>
        <p>Andrey<br>
        </p>
        <div class="moz-cite-prefix">On 2022-05-13 11:41, Andrey
          Grodzovsky wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com">
          <blockquote type="cite" style="color: #007cff;">Yes, exactly
            that's the idea. <br>
            <br>
            Basically the reset domain knowns which amdgpu devices it
            needs to reset together. <br>
            <br>
            If you then represent that so that you always have a hive
            even when you only have one device in it, or if you put an
            array of devices which needs to be reset together into the
            reset domain doesn't matter. <br>
            <br>
            Maybe go for the later approach, that is probably a bit
            cleaner and less code to change. <br>
            <br>
            Christian. <br>
          </blockquote>
          <br>
          <br>
          Unfortunately this approach raises also a few&nbsp; difficulties -
          <br>
          First - if holding array of devices in reset_domain then when
          you come to GPU reset function you don't really know which
          adev is the one triggered the reset and this is actually
          essential to some procedures like emergency restart. <br>
        </blockquote>
      </blockquote>
      <br>
      What is &quot;emergency restart&quot;? That's not some requirement I know
      about.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Emergency restart is something u can see at the beginning of
      amdgpu_gpu_recover function - it's a historical work around for
      some type of ASICs who weren't able to do full reset I think.&nbsp; We
      should eventually remove it bu for now I thin it's still in use. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:6cf84065-6341-3f96-4e09-ab71796241ec@amd.com"> <br>
      <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
        <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com"> <br>
          Second - in XGMI case we must take into account that one of
          the hive members might go away in runtime (i could do echo 1
          &gt; /sysfs/pci_id/remove on it for example at any moment) -
          so now we need to maintain this array and mark such entry with
          NULL probably on XGMI node removal , and then there might be
          hot insertion and all this adds more complications. <br>
          <br>
          I now tend to prefer your initial solution for it's simplicity
          and the result will be what we need - <br>
          <br>
          &quot;E.g. in the reset code (either before or after the reset,
          that's debatable) you do something like this: <br>
          <br>
          for (i = 0; i &lt; num_ring; ++i) <br>
          cancel_delayed_work(ring[i]-&gt;scheduler....) <br>
          cancel_work(adev-&gt;ras_work); <br>
          cancel_work(adev-&gt;iofault_work); <br>
          cancel_work(adev-&gt;debugfs_work); <br>
          &quot; <br>
        </blockquote>
      </blockquote>
      <br>
      Works for me. I already expected that switching over the reset to
      be based on the reset context wouldn't be that easy.<br>
      <br>
      Regards,<br>
      Christian.<br>
    </blockquote>
    <p><br>
    </p>
    <p>Ok - i will resend a patch.</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:6cf84065-6341-3f96-4e09-ab71796241ec@amd.com"> <br>
      <blockquote type="cite" cite="mid:cdce4608-9ade-ac23-b957-6d38a3e2b55a@amd.com">
        <blockquote type="cite" cite="mid:0b2657b0-41b6-53b1-f087-1fa0fb821839@amd.com"> <br>
          Let me know what you think. <br>
          <br>
          Andrey </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------ONMMCJihjgOenSWTxG0f0eRJ--
