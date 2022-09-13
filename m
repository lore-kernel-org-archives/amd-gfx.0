Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E50ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 02:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA86C10E391;
	Tue, 13 Sep 2022 02:01:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3682F10E391
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 02:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmCfJuhtZSa4kyDZG3uBiQwbquIcrRveEk0WYvGRTgyu0M1nCZWZazH79LiBpC9RX0p0ITPo4uMIeuksatsA1eYjvKC5Nky0KZS2FSK8ToxDW9uVn/yI6fogKguc7UiSsHln9p8GLggPcPhhfkmztd2FIzW+YfbX6Tv3uAldqRb5RWzyf0BblXaakHRqLpR7ULVXgafnj4fXMv+khej5AhC4eG2NZEgEPxzMD3TFprseCQ4W0s8YKZnuQ5G+EVkv9lmyfhTtd7grQtyczR9OnLi3PIP4Muv7kzd7E6YO6+Gvj37kOpLdefRWRwTNR8kz3EiSjkyB/vyfgrXK31yFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5brvwIlu4MtD0osKfqmJsJGcR6En5244KJRYtOp9tq4=;
 b=kc7IO20mZuXLafjGil2eK/AYRZ6Vy50ijeAt+5zpOEhUY+pF3HQ5LLY/D3wRpOqN/AgpU/aLFFcf9yxBHE5DxfTZAUI3EtmN0OpOaeeC0pFbI3T/RM12YJqCopO7RP2tBuBEfs4fDrfymlfIk9PbebkpZeeX/Y01tMPyUTEKyxs59Etdnxhxx1ykYdQnaV+FYYr9JfqXT9n4I3l1MrF/zclbmaktrvExFUFWDq3pZtsKjtPgzESyQWS7x7bjHL7PVBO/08A6EfTIfxNKZ9vyPUtTbC1THmn5sfxxnuWHvoLZrbxeCeG3WDg1PPOHeP0jabES1q/NKYmlAgAEGWIJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5brvwIlu4MtD0osKfqmJsJGcR6En5244KJRYtOp9tq4=;
 b=LkAyoeJeKnkmPevXitM7B0MpZKU5WfhFwzyDMaVuUY32o0kXz9SZcINoeH1XOET4U5cJG7NaM7lYBNoFjFkuyRnXh+/f/TQfw5eiHdknFQUiX+0K+mxBK7kVAgJ5swAzwz67ps1I0yrx+TecybLXjyPPs9goFDxF7ssYWeQ80Mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 02:00:56 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 02:00:55 +0000
Message-ID: <75d18161-e535-e35e-2fe5-693846e98b79@amd.com>
Date: Mon, 12 Sep 2022 22:00:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
 <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
 <88534536-4707-32da-5af7-04668b8cb4a8@amd.com>
 <7dbb161a-ab79-f694-9eb2-b932ff419fa7@gmail.com>
 <42b819a4-f6aa-074a-1c81-134e00a60841@amd.com>
 <7fdb53b5-cb21-358d-f582-756803d87aa1@gmail.com>
 <53807f46-1f71-8699-a4ea-3a65afe386ec@amd.com>
 <DS7PR12MB63330F119F240F3F62551174F4479@DS7PR12MB6333.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <DS7PR12MB63330F119F240F3F62551174F4479@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::8) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 9535ca3f-cbad-43b5-a7d1-08da952bcb72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t30k5lSGYgDdZqmF+sYNw1wd051RqVlvhpjy4LE6ly9rd/ETb4Fko/AZ+Uc5Lo40Xqd3dLQnLPn4tKlJcydbjIWyeKHQ5RZc/zXdRXe+CcrTuboO9pgC6fo7d/9kQIVFWUYhpB/RBaDYqnD4ELyWMUp7eoXDRCyZQhk9nnjMGefJ2W6COEY3H1E2+NScq4dFFaScRjZ/lAV9mn+nSIpOTibwBnakGU8YpgC3XdjsnU6kjhfLQdRxanrykI8QbLIYjZZrH7R0J+IFHfaglqAKRSy93yHX0iHUdjewLp3DmrhTSo/IVPPPB5kaz1Gf/hwuRalbTRMT5i6zmjjC6gOGPCVjz6hslm5HqiF9+6UDffEVbLgl9ZDSdpWFPv7ukoyq1iO3TDPlNFbhanRUvBVxHnDfGSFVJvKRaTcD+6PnNuRRbDJ/QmuWt+IFw4xDl/2zJRiqO3Cjo5kwgVXXUIy7wwTojqFim2QK9XfISK6yxRUDZI2aPe3IuS8s6nx23c9Tm8GvSd8DEyI5qOHX3FyHPTI4JXG+kT6k8NXIcVbw5Il4l00WNNwJXpnOhulGUu/aq0cN4g954vFa1FS2CpHkLz/vmYI1oW85+yuui3W3xaPuwq0d9d6gpPCnMxmIKFoX7wWUeOfKs2qNCvVuhcLSbZeftHuorVKTPqKTjXtCOCiD5tEdeCuuGF3mze/f9FSsCesUD1bPUfZTF+NE5NQJd+r0bB5VQr7WuGKQ/tK/PG4lPueTWoTWEwa0D1VglR5jj2Wmo4k1KhbC06JNDLh//ia6giGYUL9W3uAhi3dbBzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(53546011)(4326008)(6512007)(30864003)(110136005)(6666004)(8936002)(478600001)(31696002)(6486002)(2616005)(44832011)(186003)(38100700002)(8676002)(66574015)(83380400001)(31686004)(6506007)(2906002)(5660300002)(86362001)(66556008)(66476007)(36756003)(316002)(41300700001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdJanluZG9rbGdTVXZrcEJYOUVrUm1HdTQ2bGhvQU5wc3JUMlM2dlZhcVNy?=
 =?utf-8?B?WEZHNnZoUG9Za3EvcjAvK2ZPcnVITUhMYVdZQmV6MHp4TFo2YVJ3YkpNREFE?=
 =?utf-8?B?K0pMQlJJblNsaS9xdWJvcHBTMlpxK1FJOGk1RVJ5YWc3cXVBdmxJMlpFUnpC?=
 =?utf-8?B?N0ZieXZPczZUV2JCZmdpNmY2R0pZRDJFSXJNQ29rb3RiNWZmaWdiQkhidnBM?=
 =?utf-8?B?YTVESWdXb0xmaHpoTDJQTkwwMWlmR0VMdUNSVUNyUm56bjM2Y2sxOUlsVUZI?=
 =?utf-8?B?QjJuZFgyMS9sb0U2T0thL0QvNE44Y0swclhSVEtQTVJ5N3lnaGhrak5uUFQ1?=
 =?utf-8?B?cjhBUlN2UXBtcVcwejRjb243c2VySVQ2L0pGbnJyaUIvWXF4cWd2Z1BJTHZi?=
 =?utf-8?B?NmFKLzR0V0FyTXJoTFFmRTRYWXp4RlM0eFgxQlh1UWZ1NXQ4d0IrTmROQVVX?=
 =?utf-8?B?aGh4akc4Z0pPcjhiUkMyYnBKMXViOFlraUNzMU12N3UzVjZ2ZjlEZklaV0lO?=
 =?utf-8?B?WWJNVzRVYVdxMktlSjRENlhCd3lMTUkwU1BjNytTZGdPVExGa085dlJsL2R6?=
 =?utf-8?B?OFdZeEd2WDVSajJ3M3hhT2U3TlRJUjl2bjJya09oalRHZWhTUFhIaTFHRG93?=
 =?utf-8?B?ZlRWNTdqdUp6SWtLeDF4QlgwZUxLeWk0SUgvS0tGT2dwN1Y0SWl6OWZheWVB?=
 =?utf-8?B?cnN5czR3K0xNUjkxSk16Y3NJN1N3Ky9scThaY3JNSXVWcVpMcXBNZytUY1JF?=
 =?utf-8?B?UlBLZjZaekJrM0pyY0FsRmcwbWVtdWV3dWlrZWJsOSsvTGVwMGVZZlNlWUg1?=
 =?utf-8?B?SE4zOWhyRDU4RklINXYrUVJUdFphdWhiWGhoV0xZY2Uwb0M1Y2JFU2VqZ3Bi?=
 =?utf-8?B?QkRnU3ZFRFJkRGNxc0xjQzdJWlRTTU5vcEVsLzBGaHRFZHBOenY4b284Tm55?=
 =?utf-8?B?N0xiVDFwcG1rRkY4OXBNUzJNWmRkM1lvd1hjRW95UXhxUU92Q1pCRkpEbFpW?=
 =?utf-8?B?eTU2a1h5S0d0R1JUTWZ2MEw2T1pxak1ucllmOEtqc2tKZHlQZXZYMDY5Ym5t?=
 =?utf-8?B?VTVhTS9YNjJoOFhZRTJZSVQ4U2J1NEU3YjZtZSt1ZUMyb2paQzR0cExTRUUw?=
 =?utf-8?B?eTJtTlRuV2hIQVpISE1KdWwzckpIeTdRTGxBNlF5L21udjgveDJwWnlDaTNk?=
 =?utf-8?B?UU5aQXBmK2hINm1WTHU0WmpEQTg3aVZ3M3dMTUdxTW1wcHNvaFJxWWRQaWNt?=
 =?utf-8?B?b2hLQmJ2NjNKaSttcmJTTGIxME8xN1RFZ3VGSnh4c0QrVS85bDZBQ1Rxb0FZ?=
 =?utf-8?B?WVo3YytDUTRZV1dLK3dmRUQrZVBrLzlQdXNUZG1NK3ZKbHVmUktaYlJRSmxh?=
 =?utf-8?B?dHN1WUdDUnhPWlFZU3NzVkFvb1doK3ZETHphcFNpTVR4b1RtTmNrWlE1b2E3?=
 =?utf-8?B?alcyK3lSeCtrVUJrSSt5U2RTLzQwcVZxZDZxUVdKK0MzRkc2K3hkcUQxTUxt?=
 =?utf-8?B?TGFJdjkxYSs1RjVKVFBIMnIrVE0yVXlBV01uSWQwQzU1VFExc0h1d2R6OFc5?=
 =?utf-8?B?QTNOWGVUelNSY3JTUnBlaVRETm42bVlBT1cxeDVsbnNNYjJjbXhIYzFac0VB?=
 =?utf-8?B?U0VWb3RUNm5aWE9jM0p6Y2pzZGxBY2lvdFBoUWVvTytpeDU2ZFpWSFNYeWo1?=
 =?utf-8?B?THBGZEVOaDZMTzVVbnJFUzdtTG52RVRrZDVhR3dNWlJtQWZ0NEpVdlg3T05J?=
 =?utf-8?B?SytWODc4V3JqQjlmcmV6akZOMkN2Z3dHMTM0clB1USt5bDJtdkFPbUk5dU5C?=
 =?utf-8?B?dFRoSEdXUzN4T3M0Vi8ydWs0ZEprYURoTWc3czdxWDdnczFYSjNESlRUeTdl?=
 =?utf-8?B?Z0lqMlZ3N2pIZDJ6bFUrUzhMOXozY282OVdTbEdtNnpSMEhxc2FlZTdiZkhU?=
 =?utf-8?B?MTVHMHNETm92aG5GczRKVHpaVFhPQ09mTURaaGJmSWRBVHcreVJZd1VHK1ZZ?=
 =?utf-8?B?Slc2U2RhZGs5L3ZSV2sxMWY4UU1QOURXbHRTSGJMZDJmNFQzRW5KVDRJVXNX?=
 =?utf-8?B?aElINUEwb0htcTlSSnVSa0h4c1hwYitZOEVKZXhhN0VvVm11VTJjdk1WM0R2?=
 =?utf-8?B?dEVIV0FQTDJDZWZJdG4xMWN3VHZreGpSMXBmSmNQQk93YUVMaUdjV09CMTU3?=
 =?utf-8?Q?MZ2cVbWBL5x8otw9q+sSoy84yXNdAzzoQxdSiIybbObO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9535ca3f-cbad-43b5-a7d1-08da952bcb72
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 02:00:55.7642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IdxEFCceB6espnjDKl11waUH6gr7AUQyQcB5L/mTom0twiYMdqi3UDSzDvLCRtbcTGDynZCFO6KidawubTW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-09-12 21:44, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Tuesday, September 13, 2022 12:45 AM
> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
>
>
> On 2022-09-12 12:22, Christian König wrote:
>> Am 12.09.22 um 17:34 schrieb Andrey Grodzovsky:
>>> On 2022-09-12 09:27, Christian König wrote:
>>>
>>>> Am 12.09.22 um 15:22 schrieb Andrey Grodzovsky:
>>>>> On 2022-09-12 06:20, Christian König wrote:
>>>>>> Am 09.09.22 um 18:45 schrieb Andrey Grodzovsky:
>>>>>>> On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
>>>>>>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>>>>>>
>>>>>>>> The software ring is created to support priority context while
>>>>>>>> there is only one hardware queue for gfx.
>>>>>>>>
>>>>>>>> Every software rings has its fence driver and could be used as
>>>>>>>> an ordinary ring for the gpu_scheduler.
>>>>>>>> Multiple software rings are binded to a real ring with the ring
>>>>>>>> muxer. The packages committed on the software ring are copied to
>>>>>>>> the real ring.
>>>>>>>>
>>>>>>>> v2: use array to store software ring entry.
>>>>>>>> v3: remove unnecessary prints.
>>>>>>>>
>>>>>>>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182
>>>>>>>> +++++++++++++++++
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204
>>>>>>>> +++++++++++++++++++
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>>>>>>>>    7 files changed, 509 insertions(+), 1 deletion(-)
>>>>>>>>    create mode 100644
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>>>>>    create mode 100644
>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>>>>>    create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> index 3e0e2eb7e235..85224bc81ce5 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>        amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o
>>>>>>>> amdgpu_nbio.o \
>>>>>>>>        amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
>>>>>>>> amdgpu_rap.o \
>>>>>>>>        amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>>>>>>> -    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>>>>>>>> +    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>>>>>>>> +\
>>>>>>>> +    amdgpu_sw_ring.o amdgpu_ring_mux.o
>>>>>>>>      amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> index 53526ffb2ce1..0de8e3cd0f1c 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>>>>> @@ -33,6 +33,7 @@
>>>>>>>>    #include "amdgpu_imu.h"
>>>>>>>>    #include "soc15.h"
>>>>>>>>    #include "amdgpu_ras.h"
>>>>>>>> +#include "amdgpu_ring_mux.h"
>>>>>>>>      /* GFX current status */
>>>>>>>>    #define AMDGPU_GFX_NORMAL_MODE 0x00000000L @@ -346,6 +347,8 @@
>>>>>>>> struct amdgpu_gfx {
>>>>>>>>        struct amdgpu_gfx_ras        *ras;
>>>>>>>>          bool                is_poweron;
>>>>>>>> +
>>>>>>>> +    struct amdgpu_ring_mux            muxer;
>>>>>>>>    };
>>>>>>>>      #define amdgpu_gfx_get_gpu_clock_counter(adev)
>>>>>>>> (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> index 7d89a52091c0..fe33a683bfba 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>>>>> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>>>>>>>>        bool            is_mes_queue;
>>>>>>>>        uint32_t        hw_queue_id;
>>>>>>>>        struct amdgpu_mes_ctx_data *mes_ctx;
>>>>>>>> +
>>>>>>>> +    bool            is_sw_ring;
>>>>>>>> +
>>>>>>>>    };
>>>>>>>>      #define amdgpu_ring_parse_cs(r, p, job, ib)
>>>>>>>> ((r)->funcs->parse_cs((p), (job), (ib))) diff --git
>>>>>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..ea4a3c66119a
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>>>>> @@ -0,0 +1,182 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <drm/drm_print.h>
>>>>>>>> +
>>>>>>>> +#include "amdgpu_ring_mux.h"
>>>>>>>> +#include "amdgpu_ring.h"
>>>>>>>> +
>>>>>>>> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>>>>>>>> +
>>>>>>>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring,
>>>>>>>> +    u64 s_begin, u64 s_end);
>>>>>>>> +
>>>>>>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>>>>>>>> amdgpu_ring *ring)
>>>>>>>> +{
>>>>>>>> +    mux->real_ring = ring;
>>>>>>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>>>>>>> +    mux->num_ring_entries = 0;
>>>>>>>> +    spin_lock_init(&mux->lock);
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux) {
>>>>>>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>>>>>>> +    mux->num_ring_entries = 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_mux_entry *e;
>>>>>>>> +
>>>>>>>> +    if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
>>>>>>>> +        DRM_ERROR("adding sw ring exceeds max gfx num\n");
>>>>>>>> +        return -ENOMEM;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    e = &mux->ring_entries[mux->num_ring_entries++];
>>>>>>>> +
>>>>>>>> +    e->ring = ring;
>>>>>>>> +    e->start_ptr_in_hw_ring = 0;
>>>>>>>> +    e->end_ptr_in_hw_ring = 0;
>>>>>>>> +    e->sw_cptr = 0;
>>>>>>>> +    e->sw_rptr = 0;
>>>>>>>> +    e->sw_wptr = 0;
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct
>>>>>>>> amdgpu_ring_mux *mux,
>>>>>>>> +                struct amdgpu_ring *ring) {
>>>>>>>> +    struct amdgpu_mux_entry *e;
>>>>>>>> +    int i;
>>>>>>>> +
>>>>>>>> +    e = NULL;
>>>>>>>> +    for (i = 0; i < mux->num_ring_entries; i++) {
>>>>>>>> +        if (mux->ring_entries[i].ring == ring) {
>>>>>>>> +            e = &mux->ring_entries[i];
>>>>>>>> +            break;
>>>>>>>> +        }
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return e;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring, u64 wptr)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_mux_entry *e;
>>>>>>>> +
>>>>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>>>>> +    if (!e) {
>>>>>>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    spin_lock(&mux->lock);
>>>>>>>
>>>>>>> A bit more generic question, I assume the spinlock here protects
>>>>>>> from concurrent runs of amdgpu_ib_schedule. For them to be even
>>>>>>> theoretically concurrent it must be from direct submissions to HW
>>>>>>> (because any scheduler mediated submission is serialized though
>>>>>>> the dedicated scheduler worker thread). But in such case why we
>>>>>>> protect only here ? If i am not missing something there is no
>>>>>>> total per HW ring lock when calling amdgpu_ib_schedule today and
>>>>>>> we do a lot of HW accesses there to ring  which should probably
>>>>>>> be protected from concurrent accesses.
>>>>>>>
>>>>>>> So if any one can answer this question ?
>>>>>> Well what we have is in general two schedulers which push their
>>>>>> work into one hardware ring.
>>>>>>
>>>>>> So we need a lock to make sure that only one is modifying the hw
>>>>>> ring at the same time.
>>>>>>
>>>>>>  From the implementation I think we first write the commands into a
>>>>>> shadow ring buffer and then copy them over to the real hw ring here.
>>>>>>
>>>>>> So this is the only place where we actually touch the hw ring
>>>>>> buffer and to need to grab the lock.
>>>>>>
>>>>>> Did I get this right?
>>>>>>
>>>>>> Thanks,
>>>>>> Christian.
>>>>>
>>>>> For the case of the sw ring yes, but I was asking in general,
>>>>> accesses to real HW rings, amdgpu_ib_schedule writes to HW rings,
>>>>> we may be accessing same HW ring from 2 different contexts when
>>>>> doing direct submissions (i.e. calling amdgpu_ib_schedule directly
>>>>> from 2 threads concurrently) this opens possibility to concurrent
>>>>> access to HW. Or am i missing something here ?
>>>> No, that's pretty much correct.
>>>>
>>>> The general idea is that amdgpu_ib_schedule() first writes into a
>>>> separate software ring buffer for each scheduler. So no locking
>>>> needed for that.
>>>>
>>>> Then when the set_wptr callback is called we grab the lock and copy
>>>> the software ring content to the real hw ring and telling the hw to
>>>> execute it.
>>>>
>>>> The spin_lock is to protect from concurrent hw access.
>>>>
>>>> Regards,
>>>> Christian.
>>>
>>> Look at
>>> amdgpu_copy_buffer->amdgpu_job_submit_direct->amdgpu_ib_schedule->amd
>>> gpu_ring_commit->amdgpu_ring_set_wptr,
>>> at no point there lock is taken. The only lock i see that resembles
>>> what you describe is for amdgpu_kiq.ring_lock. So this applies only
>>> to some of the code but not to all cases.
>> Sounds like we have a misunderstanding here.
>>
>> The case we look at should be this:
>>
>> amdgpu_job_run()->amdgpu_ib_schedule()->amdgpu_ring_commit()->amdgpu_r
>> ing_set_wptr()...amdgpu_ring_set_wptr_to_mux()
>>
>>
>> Then amdgpu_ring_set_wptr_to_mux() we then grab the lock, copy over
>> the commands, commit them to the hw and then drop the lock.
>
>> Yes, misunderstanding - I am asking for the general case not related to this patch-set. When we work with HW rings directly from direct submissions.
>> Nothing prevents in that case from 2 concurrent accesses to HW the way i showed above, or is there something ?
>> Andrey
> drm_sched_init creates the thread of drm_sched_main once per ring, thus every amdgpu_ib_schedule on a certain ring should be executed in the same thread. Please correct me if I am wrong.


You are right for scheduler mediated submissions (executing through 
drm_sched_backend_ops.run_job hook) , I am talking about direct 
submissions without gpu scheduler (using amdgpu_job_submit_direct)

Andrey


>
> Thanks,
> Jiadong
>> Christian.
>>
>>> Andrey
>>>
>>>
>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>>
>>>>>>>> +    e->sw_cptr = e->sw_wptr;
>>>>>>>> +    e->sw_wptr = wptr;
>>>>>>>> +    e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>>>>>>> +
>>>>>>>> +    if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) ==
>>>>>>>> +0) {
>>>>>>>> +        e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>>>>>>> +        amdgpu_ring_commit(mux->real_ring);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    spin_unlock(&mux->lock);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_mux_entry *e;
>>>>>>>> +
>>>>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>>>>> +    if (!e) {
>>>>>>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return e->sw_wptr;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring)
>>>>>>>> +{
>>>>>>>> +    struct amdgpu_mux_entry *e;
>>>>>>>> +    u64 r_rptr, r_wptr, offset, start, end;
>>>>>>>> +
>>>>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>>>>> +    if (!e) {
>>>>>>>> +        DRM_ERROR("no sw entry found!\n");
>>>>>>>> +        return 0;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>>>>>>>> +    r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
>>>>>>>> +
>>>>>>>> +    if (r_wptr < r_rptr)
>>>>>>>> +        r_wptr += mux->real_ring->ring_size >> 2;
>>>>>>>> +
>>>>>>>> +    start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>>>>>>> +    end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>>>>>>> +    if (start > end)
>>>>>>>> +        end += mux->real_ring->ring_size >> 2;
>>>>>>>> +    if (r_rptr <= end && r_rptr >= start) {
>>>>>>>> +        offset = r_rptr - start;
>>>>>>>> +        e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
>>>>>>>> +    } else if (r_rptr < start) {
>>>>>>>> +        e->sw_rptr = e->sw_cptr;
>>>>>>>> +    } else {
>>>>>>>> +        e->sw_rptr = e->sw_wptr;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return e->sw_rptr;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/*copy packages on sw ring range[begin, end) */ static int
>>>>>>>> +copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring,
>>>>>>>> +    u64 s_begin, u64 s_end)
>>>>>>>> +{
>>>>>>>> +    u64 begin, end, r_begin, r_end;
>>>>>>>> +    struct amdgpu_ring *real_ring = mux->real_ring;
>>>>>>>> +
>>>>>>>> +    begin = s_begin & ring->buf_mask;
>>>>>>>> +    end = s_end & ring->buf_mask;
>>>>>>>> +
>>>>>>>> +    r_begin = real_ring->wptr & real_ring->buf_mask;
>>>>>>>> +    if (begin == end)
>>>>>>>> +        return -ERANGE;
>>>>>>>> +    if (begin > end) {
>>>>>>>> +        amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) +
>>>>>>>> end - begin);
>>>>>>>> +        amdgpu_ring_write_multiple(real_ring, (void
>>>>>>>> *)&ring->ring[begin],
>>>>>>>> +            (ring->ring_size >> 2) - begin);
>>>>>>>> +        amdgpu_ring_write_multiple(real_ring, (void
>>>>>>>> *)&ring->ring[0], end);
>>>>>>>> +    } else {
>>>>>>>> +        amdgpu_ring_alloc(real_ring, end - begin);
>>>>>>>> +        amdgpu_ring_write_multiple(real_ring, (void
>>>>>>>> *)&ring->ring[begin], end - begin);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    r_end = real_ring->wptr & real_ring->buf_mask;
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..d058c43bb063
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>>>>> @@ -0,0 +1,67 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#ifndef __AMDGPU_RING_MUX__
>>>>>>>> +#define __AMDGPU_RING_MUX__
>>>>>>>> +
>>>>>>>> +#include <linux/timer.h>
>>>>>>>> +#include <linux/spinlock.h>
>>>>>>>> +#include "amdgpu_ring.h"
>>>>>>>> +
>>>>>>>> +struct amdgpu_ring;
>>>>>>>> +/*
>>>>>>>> + * start_ptr_in_hw_ring - last copied start loc on hw ring
>>>>>>>> + * end_ptr_in_hw_ring - last copied end loc on hw ring
>>>>>>>> +*sw_cptr -the begin of copy ptr in sw ring  *sw_rptr; the read
>>>>>>>> +ptr in sw ring  *sw_wptr; the write ptr in sw ring  */ struct
>>>>>>>> +amdgpu_mux_entry {
>>>>>>>> +    struct amdgpu_ring    *ring;
>>>>>>>> +    u64 start_ptr_in_hw_ring;
>>>>>>>> +    u64 end_ptr_in_hw_ring;
>>>>>>>> +
>>>>>>>> +    u64 sw_cptr;
>>>>>>>> +    u64 sw_rptr;
>>>>>>>> +    u64 sw_wptr;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +struct amdgpu_ring_mux {
>>>>>>>> +    struct amdgpu_ring *real_ring;
>>>>>>>> +
>>>>>>>> +    struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
>>>>>>>> +
>>>>>>>> +    unsigned num_ring_entries;
>>>>>>>> +
>>>>>>>> +    spinlock_t            lock;
>>>>>>>> +
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>>>>>>>> amdgpu_ring *ring);
>>>>>>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux); int
>>>>>>>> +amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring);
>>>>>>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring, u64 wptr);
>>>>>>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring);
>>>>>>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux,
>>>>>>>> struct amdgpu_ring *ring);
>>>>>>>> +
>>>>>>>> +#endif
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..452d0ff37758
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>>>>> @@ -0,0 +1,204 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>> + * All Rights Reserved.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>> + (the
>>>>>>>> + * "Software"), to deal in the Software without restriction,
>>>>>>>> including
>>>>>>>> + * without limitation the rights to use, copy, modify, merge,
>>>>>>>> publish,
>>>>>>>> + * distribute, sub license, and/or sell copies of the Software,
>>>>>>>> and to
>>>>>>>> + * permit persons to whom the Software is furnished to do so,
>>>>>>>> subject to
>>>>>>>> + * the following conditions:
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE
>>>>>>>> LIABLE FOR ANY CLAIM,
>>>>>>>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
>>>>>>>> CONTRACT, TORT OR
>>>>>>>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
>>>>>>>> SOFTWARE OR THE
>>>>>>>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice
>>>>>>>> (including the
>>>>>>>> + * next paragraph) shall be included in all copies or
>>>>>>>> substantial portions
>>>>>>>> + * of the Software.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include "amdgpu_sw_ring.h"
>>>>>>>> +#include "amdgpu_ring_mux.h"
>>>>>>>> +
>>>>>>>> +#define amdgpu_ring_get_gpu_addr(ring, offset) \
>>>>>>>> +    (ring->is_mes_queue ?                        \
>>>>>>>> +     (ring->mes_ctx->meta_data_gpu_addr + offset) :
>>>>>>>> +\
>>>>>>>> +     (ring->adev->wb.gpu_addr + offset * 4))
>>>>>>>> +
>>>>>>>> +#define amdgpu_ring_get_cpu_addr(ring, offset) \
>>>>>>>> +    (ring->is_mes_queue ?                        \
>>>>>>>> +     (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) +
>>>>>>>> offset) : \
>>>>>>>> +     (&ring->adev->wb.wb[offset]))
>>>>>>>> +
>>>>>>>> +
>>>>>>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct
>>>>>>>> amdgpu_ring *ring,
>>>>>>>> +             unsigned int max_dw, struct amdgpu_irq_src
>>>>>>>> +*irq_src,
>>>>>>>> +             unsigned int irq_type, unsigned int hw_prio,
>>>>>>>> +             atomic_t *sched_score) {
>>>>>>>> +    int r;
>>>>>>>> +    int sched_hw_submission = amdgpu_sched_hw_submission;
>>>>>>>> +    u32 *num_sched;
>>>>>>>> +    u32 hw_ip;
>>>>>>>> +
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +
>>>>>>>> +    if (ring->adev == NULL) {
>>>>>>>> +        if (adev->num_rings >= AMDGPU_MAX_RINGS)
>>>>>>>> +            return -EINVAL;
>>>>>>>> +
>>>>>>>> +        ring->adev = adev;
>>>>>>>> +        ring->num_hw_submission = sched_hw_submission;
>>>>>>>> +        ring->sched_score = sched_score;
>>>>>>>> +        ring->vmid_wait = dma_fence_get_stub();
>>>>>>>> +
>>>>>>>> +        if (!ring->is_mes_queue) {
>>>>>>>> +            ring->idx = adev->num_rings++;
>>>>>>>> +            adev->rings[ring->idx] = ring;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        r = amdgpu_fence_driver_init_ring(ring);
>>>>>>>> +        if (r)
>>>>>>>> +            return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>>>>>>> +    if (r) {
>>>>>>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc
>>>>>>>> failed\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>>>>>>> +    if (r) {
>>>>>>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc
>>>>>>>> failed\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>
>>>>>>> Looks like a typo copy pase duplicate of the above
>>>>>>>
>>>>>>>> +
>>>>>>>> +    r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>>>>>>>> +    if (r) {
>>>>>>>> +        dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc
>>>>>>>> failed\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>>>>>>>> +    if (r) {
>>>>>>>> +        dev_err(adev->dev, "(%d) ring cond_exec_polling wb
>>>>>>>> alloc failed\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ring->fence_gpu_addr =
>>>>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
>>>>>>>> +    ring->fence_cpu_addr =
>>>>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
>>>>>>>> +
>>>>>>>> +    ring->trail_fence_gpu_addr =
>>>>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
>>>>>>>> +    ring->trail_fence_cpu_addr =
>>>>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
>>>>>>>> +
>>>>>>>> +    ring->cond_exe_gpu_addr =
>>>>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
>>>>>>>> +    ring->cond_exe_cpu_addr =
>>>>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
>>>>>>>> +
>>>>>>>> +    /* always set cond_exec_polling to CONTINUE */
>>>>>>>> +    *ring->cond_exe_cpu_addr = 1;
>>>>>>>> +
>>>>>>>> +    r = amdgpu_fence_driver_start_ring(ring, irq_src,
>>>>>>>> +irq_type);
>>>>>>>> +    if (r) {
>>>>>>>> +        dev_err(adev->dev, "failed initializing fences
>>>>>>>> (%d).\n", r);
>>>>>>>> +        return r;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ring->ring_size = roundup_pow_of_two(max_dw * 4 *
>>>>>>>> sched_hw_submission);
>>>>>>>> +
>>>>>>>> +    ring->buf_mask = (ring->ring_size / 4) - 1;
>>>>>>>> +    ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
>>>>>>>> +        0xffffffffffffffff : ring->buf_mask;
>>>>>>>> +
>>>>>>>> +    /* Allocate ring buffer */
>>>>>>>> +    if (ring->ring == NULL) {
>>>>>>>> +        ring->ring = kzalloc(ring->ring_size +
>>>>>>>> ring->funcs->extra_dw, GFP_KERNEL);
>>>>>>>> +        if (!ring->ring) {
>>>>>>>> +            dev_err(adev->dev, "(%d) swring create failed\n",
>>>>>>>> +r);
>>>>>>>> +            return r;
>>>>>>>> +        }
>>>>>>>> +
>>>>>>>> +        amdgpu_ring_clear_ring(ring);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    ring->max_dw = max_dw;
>>>>>>>> +    ring->hw_prio = hw_prio;
>>>>>>>> +
>>>>>>>> +    if (!ring->no_scheduler) {
>>>>>>>> +        hw_ip = ring->funcs->type;
>>>>>>>> +        num_sched =
>>>>>>>> +&adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>>>>>> + adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
>>>>>>>> +            &ring->sched;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>
>>>>>>> In general i see this function is a big one to one subset of
>>>>>>> amdgpu_ring_init.
>>>>>>> Could you maybe see a way to refactor such that this function is
>>>>>>> the base and for HW related code that different (like BO
>>>>>>> allocation for ring buffer) you maybe can add if
>>>>>>> (!ring->sw_ring)... and add those code snippets ? To avoid
>>>>>>> substantial code duplication.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>>
>>>>>>>> +
>>>>>>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring) {
>>>>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>>>>> +
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +    return amdgpu_ring_get_rptr_from_mux(mux, ring); }
>>>>>>>> +
>>>>>>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring) {
>>>>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>>>>> +
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +    return amdgpu_ring_get_wptr_from_mux(mux, ring); }
>>>>>>>> +
>>>>>>>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring) {
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring) {
>>>>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>>>>> +
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +    amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr); }
>>>>>>>> +
>>>>>>>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring) {
>>>>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>>>>> +
>>>>>>>> +    /* Not to finish a ring which is not initialized */
>>>>>>>> +    if (!(ring->adev) ||
>>>>>>>> +        (!ring->is_mes_queue &&
>>>>>>>> +!(ring->adev->rings[ring->idx])))
>>>>>>>> +        return;
>>>>>>>> +
>>>>>>>> +    ring->sched.ready = false;
>>>>>>>> +
>>>>>>>> +    amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>>>>>>>> +    amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>>>>>>>> +
>>>>>>>> +    kfree((void *)ring->ring);
>>>>>>>> +
>>>>>>>> +    dma_fence_put(ring->vmid_wait);
>>>>>>>> +    ring->vmid_wait = NULL;
>>>>>>>> +    ring->me = 0;
>>>>>>>> +
>>>>>>>> +    ring->adev->rings[ring->idx] = NULL; }
>>>>>>>> +
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..c05d8a94ad0c
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>>>>> @@ -0,0 +1,48 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright 2012 Advanced Micro Devices, Inc.
>>>>>>>> + *
>>>>>>>> + * Permission is hereby granted, free of charge, to any person
>>>>>>>> obtaining a
>>>>>>>> + * copy of this software and associated documentation files
>>>>>>>> (the "Software"),
>>>>>>>> + * to deal in the Software without restriction, including
>>>>>>>> without limitation
>>>>>>>> + * the rights to use, copy, modify, merge, publish, distribute,
>>>>>>>> sublicense,
>>>>>>>> + * and/or sell copies of the Software, and to permit persons to
>>>>>>>> whom the
>>>>>>>> + * Software is furnished to do so, subject to the following
>>>>>>>> conditions:
>>>>>>>> + *
>>>>>>>> + * The above copyright notice and this permission notice shall
>>>>>>>> be included in
>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>> + *
>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
>>>>>>>> KIND, EXPRESS OR
>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>>>>>>>> MERCHANTABILITY,
>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
>>>>>>>> EVENT SHALL
>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY
>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>>>>>>>> OTHERWISE,
>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
>>>>>>>> THE USE OR
>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>> +#include <drm/gpu_scheduler.h>
>>>>>>>> +#include <drm/drm_print.h>
>>>>>>>> +
>>>>>>>> +#include "amdgpu_irq.h"
>>>>>>>> +#include "amdgpu_ring.h"
>>>>>>>> +#include "amdgpu.h"
>>>>>>>> +
>>>>>>>> +#ifndef __AMDGPU_SWRING_H__
>>>>>>>> +#define __AMDGPU_SWRING_H__
>>>>>>>> +
>>>>>>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct
>>>>>>>> amdgpu_ring *sw_ring,
>>>>>>>> +             unsigned int max_dw, struct amdgpu_irq_src
>>>>>>>> +*irq_src,
>>>>>>>> +             unsigned int irq_type, unsigned int hw_prio,
>>>>>>>> +             atomic_t *sched_score); void
>>>>>>>> +amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
>>>>>>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>>>>>>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring); void
>>>>>>>> +amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring); void
>>>>>>>> +amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
>>>>>>>> +
>>>>>>>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring); void
>>>>>>>> +amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>>>>>>>> +
>>>>>>>> +#endif
