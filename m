Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FCEC6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 15:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151CB10E5B2;
	Mon, 12 Sep 2022 15:34:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0632B10E5AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 15:34:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB/A1GhQlPJ8mfcJEQPTZM+i4gdenQQC7Mzy+DX/ky/oTryEbOTct60+AP7aTE1NeZNNf0Xqeb9Gs09wtVS0LWQvkDk36NNptfdeDoAnbIqfYs44s44kjzi/LOYiPKwTJV7SdQTzi4QeS7WM0Nm0Zm5hOG10UkyvOIZrsj0T9P69nxBwn28usi8PE1PqZv8/YbpRTIrhFzpEyjuVFiG+BNUjO6X1gu30ZLVNvas3by5L4n/QiKJq4tSjVZ6Cy47zkvCqVJiCEI4XUcHBlBnZioPrEPS7D0Qco/T2CRTLmD0C5ueRVHTw9xE924tjMNMKHNa8iClSMpef9f7DHA9NBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20jLU+bcFdg45/GhS9fbTE5caIYFfIONx0qOhpiG91s=;
 b=TbbFMtvUMWif36Y2T1zIllWBTJxivHTqkK5K5dl3K7s5Ql4r77k4b7l46Ve6JuJGlgU00kRF4Z95s1SxY+WCi5uAni7zzoMr5KoFEEk64ElPK0SoLMJ1I98+JcgUC+51S9cXuRw5HgQI8bjIbr/fbwefmFByNZEQiRloS/4Zg5BnUHnvaJrtepnehKb+5XvFXMvLcXEUmrjqRZt2shZsgYJyp1bjGMVgi2kfvxQwfM3iRrGXnInuMJ9y1nO+IuoDQpaKSM7JT+0N/cUu5hTOX92ed7m/aywcaEUlNV7ynBebvyqbDxU06t30Az25N85IKEPQrVhH1lxD1WQhQ0jbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20jLU+bcFdg45/GhS9fbTE5caIYFfIONx0qOhpiG91s=;
 b=sW8dq/wWVIfN1+eObPwxi/7QB5LJOMoIN7X08xGJinZ9bKfIwE2xEoFiKRpfEF4pA9DCqFSlUJO6GLAy8V6qxiP4OXud1juFFE3qFW0I/Xe5JFqOSf7XvhfSgaM5Bcg7cK/rWbOJyZItVyC/wX5cQqZhPaasFRfctbvV8+kdwMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Mon, 12 Sep
 2022 15:34:25 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 15:34:24 +0000
Message-ID: <42b819a4-f6aa-074a-1c81-134e00a60841@amd.com>
Date: Mon, 12 Sep 2022 11:34:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
 <a2482795-4be3-1055-e81b-aa0c8d985e4e@gmail.com>
 <88534536-4707-32da-5af7-04668b8cb4a8@amd.com>
 <7dbb161a-ab79-f694-9eb2-b932ff419fa7@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <7dbb161a-ab79-f694-9eb2-b932ff419fa7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::23) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: 11aa3526-3ffa-45fb-eafb-08da94d44589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJcSVcFGdDruy2U+0oXkbs4IKobwx8EKXkLyp0yjvxHOELyAVUojvB+NmaUlo93O1SE4MNybDga7beUT/Uffxq8Pr5lbga3KAkMLxCrr7diNEhOVCKDpEXdH+3FF0ZzfVza3Ghp5rWKOwmWiba1eG4n0/q07d1S+rEPHJNSOEqlvtSTg2Zuh8AqZRKQujMefiUlXBd0/+6j4aSBYabdm6NRjbljrBpVRzKleUEoJ+d9EmVtCVsW2nHeUzW05uDwVTWpk2HobnxqEVZPTYMMTtBZwZrvix6oyFjZ7hJCDKz9+ZjoBDdyDaTYgFaRX/cPRhFqFR55AOusdWnWbgI9H0WAapgrdfXLNyzpx5lPijVM59agk/+8J4Th4dvUD8siqFIVtW8p1hswZcn5h237m8DpQ7vvXJ9slxSejGjvmHoZIxBd2+clHIz3nG8uBGe91NkXz6yeXVlm1Vaq8nJ/gncIXBZsths+fiFGYe1LYlHitorBp8AvjUc1nGX0aCUX4pVssvPpPL3wEHGtxEVjICySwwdDIhZXVUM83rKYOCP2XX7DrOrnosGMuS17RIgJjC0bxcrUB7U8A3nBCm92VepBgG2pHlh2sCCgnW6oIZ3MADOgUfRK7Wb008HkpxGL9s4fdd9rboYPUiVcH7CzPaE20GsXPM2Yj7v3leAxQ8VC/sA62Kk7BJ1rmlmlbnVvauwGt/0f+ZQf1Wm4V9bm1UAcCmylgdXeGr3DAQvq2lNQudxRTWENbOeE/Ts1Rk4azwh9Uq/ttOh0wyQMzihyLxTL6ExrwtSHCMGX3Ddwey1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(53546011)(6506007)(6512007)(83380400001)(6486002)(31686004)(41300700001)(186003)(478600001)(2616005)(66574015)(8936002)(316002)(8676002)(4326008)(5660300002)(30864003)(66476007)(66946007)(44832011)(2906002)(38100700002)(66556008)(31696002)(86362001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRXaE5rRWlXbTF6ZHhxR3M0R2NxY2M4Z3kyK1JsSnhIMVVXeTRyNU1xRVVW?=
 =?utf-8?B?eERzR0ZycWNWSmI1MlovZ25PT0pWNmFjRmVHVUlrbFZkSnZlWENUMVc0cWoy?=
 =?utf-8?B?SlJCY2NDenhnbWo5KzA5VUlUMWFQQmhlSkl1bGx0Q2FtbUxMVVZ2T1UrSUhV?=
 =?utf-8?B?bTNjeGtqY0FhNkJLRDRIS3QwUTlITkZKaURyZ1YzZDlmMksvMVZkcnFCSG9i?=
 =?utf-8?B?K2tHTGJoZXlBMDRaZWhsNjJIR0xDWUJpeHdxM3NPZ0hTQ3JuS1pUeThPYzU4?=
 =?utf-8?B?RERjamhOZ2FvRWxURVFzTDNrQ21tUzdYMnU1RE5kU2lJUVhPZ1JpenljNFpI?=
 =?utf-8?B?WEh1NnVUUVZ5d3NMUWVpZWJtWU9yWWZYa2NYRVd0R1pCR2IwVS9HR3VzQkd4?=
 =?utf-8?B?OUtVL1NDb0VtUGJPSzY2N0pDWG12RkRXd1F2YkFBUVdPek1GZExsU2ROcmxM?=
 =?utf-8?B?c1lZYlRmejU5elpTU2JySzJWYXl4dldVeE43TEM4dDc1aVk4S25qc2FJZk15?=
 =?utf-8?B?WDRsQVZRbGVueXRkaFMva1cra2FyaWhPLzBLeldwWHpYTFdPaVZYYURhSUNN?=
 =?utf-8?B?Sy84NXVwelNEcEtHMnJBSHp4UlVoWk5Sb3BsMnBVSG0wUjlLR1I4R3VOSnFY?=
 =?utf-8?B?VmkvckllQXhSN3ZtVVBuVDFIR1FDZllwRUFxZjVGREx6OHhsN1J0WlNaV0ph?=
 =?utf-8?B?Zk1JS1Ayd3F3ZHZPaXZMVU1QWDJvZTllMC9vT25ZRHUwV0I1WG5SR0xsM2Uw?=
 =?utf-8?B?aDhtUyt5dCtHOE5FMzVQVUJTODdXNHNuWXVWOGpHWVFnWVN4L2JJdmd5ai9V?=
 =?utf-8?B?MW4yci80bW9tNnoxaWVKbXAwU2hvOEFyMFpXTFlHVUdYMm4xaitZSTdDU1lJ?=
 =?utf-8?B?ekZSMWlsV3hJc3RXRVNOVGc4OGxob0lyZWM1bmpoYnlYeXdRMkxCZ3BZMTZI?=
 =?utf-8?B?aWVlWkFkTzJ4RU02QUZXejdydDZIbDFJdmJlQXIvdFllemxlbWtwNVRiWndS?=
 =?utf-8?B?VkphNE5LTGlhMFZiM2V2MGhRK3RFOTdobEoraHdTRFByNUFTRXRsMFZsNDdN?=
 =?utf-8?B?T0dwNmsrRFp0TmRycXJveTB3UFJpcUR6Sk9udXE1T05qeGl4K0VpR1RvbFk5?=
 =?utf-8?B?cDk2U0RpNW0vei9pbE5QWDZNWmh3aFRRU3ZLWklPcys1dnpIZmZkRFJ5SFF4?=
 =?utf-8?B?V05QZjhvS0d4TGVjODI5ZTNlSWVDaWlSZ0RGS1NxWDRIcEN5d2tFaW8xVkww?=
 =?utf-8?B?NFBVTnlBcmRrZnZCUllVRVVYTUQ3bDZWUGpjYmNvZmhZMFNHYkVrenpCSWxi?=
 =?utf-8?B?WnliUTVRTjhocTJTaXc0Z1RORHhSVTJEak1adXUxZ2F0akV3R0hZYjRRRzR6?=
 =?utf-8?B?akUrWUFMQi9neml5VUZESHFKMWp4R1l4NWpZa0RCQkhmaVJFK2tjd0o0WU5p?=
 =?utf-8?B?TVdwOWh4WUxzVlhkNDA1Y0M4Z1dMOEYvK3hPc0RWaXcxQk1EWWd0MjdRdk96?=
 =?utf-8?B?cDhEOVNIQlJucjVvMVNIbjM2VXdnRXZXc1piblNjR0lDVTVGYjE0WHdlNXMz?=
 =?utf-8?B?YkdmRnM0Rm1yT2JPOVFZdEZNR3NGZitZUWMveUUzcFMrNUxmcjhmMlU0MlhQ?=
 =?utf-8?B?Tk0zS2g5a0RCY2R2bFJJQTArck9sYVdPT1pmN0FNSlJmVHpaS2tDSDl0Ui9N?=
 =?utf-8?B?NWVOV2RMdzMrdG5Cd1U1SHYybWQ4aWRFOW91SGo2dmRxMStTa0ppc29RMmZp?=
 =?utf-8?B?cCtFRlN3L3NhdFY0bitkREVUeFF4YzY4elR5UXJtbk5FcFNseGxHWlJVMktQ?=
 =?utf-8?B?TUgwS3NNeUhXOHNKWkxaSkxaK0JZQkxVaUhwY0JidnBFYmJjeDIzVEFqMGxO?=
 =?utf-8?B?Y2JNeDFtQTZGcjNJMFFUOEFTZnE1cUdGSXdtRWVVYUdjUTBJQ0Zuc1poKzRi?=
 =?utf-8?B?a1ZjUkwwMEZ4ZWd1T0lIdWd2Rll1aCs0YStpWFBoT3hlZFh3TVZERFZNZG90?=
 =?utf-8?B?VkhwY2NhcFZaczJoYTZtSjJPREFXeW9laE5NVElrTERPZE1uYTlWSTJ2VFFT?=
 =?utf-8?B?R1BVTkk4c3VlYWZmMVFFalJrMUNBNWNQdnVsaHpuVnJpQ013NGFRS2FYN0RL?=
 =?utf-8?B?ZFJ1YnBwc1lIdmxSd0dGNWdyUTNobTd0bm5DYkhTekJHSkQvZ2NLSnN2b2ln?=
 =?utf-8?Q?XHm6dyMZDhP/jjboUGVFosjsVdBOltZB+tHa6iiwxFkv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11aa3526-3ffa-45fb-eafb-08da94d44589
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 15:34:24.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0vYkYp95eFl+qU8m4pkm7jwhuTToGO22Zsyjuh6Yx70kbzk2ofNuNdJDDxn0ytKAIwkgHuIuViLXHh9bSjgsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-12 09:27, Christian König wrote:

> Am 12.09.22 um 15:22 schrieb Andrey Grodzovsky:
>>
>> On 2022-09-12 06:20, Christian König wrote:
>>> Am 09.09.22 um 18:45 schrieb Andrey Grodzovsky:
>>>>
>>>> On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
>>>>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>>>>
>>>>> The software ring is created to support priority
>>>>> context while there is only one hardware queue
>>>>> for gfx.
>>>>>
>>>>> Every software rings has its fence driver and could
>>>>> be used as an ordinary ring for the gpu_scheduler.
>>>>> Multiple software rings are binded to a real ring
>>>>> with the ring muxer. The packages committed on the
>>>>> software ring are copied to the real ring.
>>>>>
>>>>> v2: use array to store software ring entry.
>>>>> v3: remove unnecessary prints.
>>>>>
>>>>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 
>>>>> +++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 
>>>>> +++++++++++++++++++
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>>>>>   7 files changed, 509 insertions(+), 1 deletion(-)
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> index 3e0e2eb7e235..85224bc81ce5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o 
>>>>> amdgpu_nbio.o \
>>>>>       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>>>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>>>>> -    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>>>>> +    amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>>>>> +    amdgpu_sw_ring.o amdgpu_ring_mux.o
>>>>>     amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> index 53526ffb2ce1..0de8e3cd0f1c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>>>> @@ -33,6 +33,7 @@
>>>>>   #include "amdgpu_imu.h"
>>>>>   #include "soc15.h"
>>>>>   #include "amdgpu_ras.h"
>>>>> +#include "amdgpu_ring_mux.h"
>>>>>     /* GFX current status */
>>>>>   #define AMDGPU_GFX_NORMAL_MODE            0x00000000L
>>>>> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>>>>>       struct amdgpu_gfx_ras        *ras;
>>>>>         bool                is_poweron;
>>>>> +
>>>>> +    struct amdgpu_ring_mux            muxer;
>>>>>   };
>>>>>     #define amdgpu_gfx_get_gpu_clock_counter(adev) 
>>>>> (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index 7d89a52091c0..fe33a683bfba 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>>>>>       bool            is_mes_queue;
>>>>>       uint32_t        hw_queue_id;
>>>>>       struct amdgpu_mes_ctx_data *mes_ctx;
>>>>> +
>>>>> +    bool            is_sw_ring;
>>>>> +
>>>>>   };
>>>>>     #define amdgpu_ring_parse_cs(r, p, job, ib) 
>>>>> ((r)->funcs->parse_cs((p), (job), (ib)))
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>> new file mode 100644
>>>>> index 000000000000..ea4a3c66119a
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>>>> @@ -0,0 +1,182 @@
>>>>> +/*
>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the 
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without 
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following 
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be 
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>> KIND, EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <drm/drm_print.h>
>>>>> +
>>>>> +#include "amdgpu_ring_mux.h"
>>>>> +#include "amdgpu_ring.h"
>>>>> +
>>>>> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>>>>> +
>>>>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring,
>>>>> +    u64 s_begin, u64 s_end);
>>>>> +
>>>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct 
>>>>> amdgpu_ring *ring)
>>>>> +{
>>>>> +    mux->real_ring = ring;
>>>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>>>> +    mux->num_ring_entries = 0;
>>>>> +    spin_lock_init(&mux->lock);
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
>>>>> +{
>>>>> +    memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>>>>> +    mux->num_ring_entries = 0;
>>>>> +}
>>>>> +
>>>>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_mux_entry *e;
>>>>> +
>>>>> +    if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
>>>>> +        DRM_ERROR("adding sw ring exceeds max gfx num\n");
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    e = &mux->ring_entries[mux->num_ring_entries++];
>>>>> +
>>>>> +    e->ring = ring;
>>>>> +    e->start_ptr_in_hw_ring = 0;
>>>>> +    e->end_ptr_in_hw_ring = 0;
>>>>> +    e->sw_cptr = 0;
>>>>> +    e->sw_rptr = 0;
>>>>> +    e->sw_wptr = 0;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct 
>>>>> amdgpu_ring_mux *mux,
>>>>> +                struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_mux_entry *e;
>>>>> +    int i;
>>>>> +
>>>>> +    e = NULL;
>>>>> +    for (i = 0; i < mux->num_ring_entries; i++) {
>>>>> +        if (mux->ring_entries[i].ring == ring) {
>>>>> +            e = &mux->ring_entries[i];
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return e;
>>>>> +}
>>>>> +
>>>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring, u64 wptr)
>>>>> +{
>>>>> +    struct amdgpu_mux_entry *e;
>>>>> +
>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>> +    if (!e) {
>>>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    spin_lock(&mux->lock);
>>>>
>>>>
>>>> A bit more generic question, I assume the spinlock here protects 
>>>> from concurrent runs
>>>> of amdgpu_ib_schedule. For them to be even theoretically concurrent 
>>>> it must be from
>>>> direct submissions to HW (because any scheduler mediated submission 
>>>> is serialized though
>>>> the dedicated scheduler worker thread). But in such case why we 
>>>> protect only here ? If i am
>>>> not missing something there is no total per HW ring lock when 
>>>> calling amdgpu_ib_schedule today
>>>> and we do a lot of HW accesses there to ring  which should probably 
>>>> be protected from
>>>> concurrent accesses.
>>>>
>>>> So if any one can answer this question ?
>>>
>>> Well what we have is in general two schedulers which push their work 
>>> into one hardware ring.
>>>
>>> So we need a lock to make sure that only one is modifying the hw 
>>> ring at the same time.
>>>
>>> From the implementation I think we first write the commands into a 
>>> shadow ring buffer and then copy them over to the real hw ring here.
>>>
>>> So this is the only place where we actually touch the hw ring buffer 
>>> and to need to grab the lock.
>>>
>>> Did I get this right?
>>>
>>> Thanks,
>>> Christian.
>>
>>
>> For the case of the sw ring yes, but I was asking in general, 
>> accesses to real HW rings, amdgpu_ib_schedule writes to HW rings,
>> we may be accessing same HW ring from 2 different contexts when doing 
>> direct submissions (i.e. calling  amdgpu_ib_schedule
>> directly from 2 threads concurrently) this opens possibility to 
>> concurrent access to HW. Or am i missing something here ?
>
> No, that's pretty much correct.
>
> The general idea is that amdgpu_ib_schedule() first writes into a 
> separate software ring buffer for each scheduler. So no locking needed 
> for that.
>
> Then when the set_wptr callback is called we grab the lock and copy 
> the software ring content to the real hw ring and telling the hw to 
> execute it.
>
> The spin_lock is to protect from concurrent hw access.
>
> Regards,
> Christian.


Look at 
amdgpu_copy_buffer->amdgpu_job_submit_direct->amdgpu_ib_schedule->amdgpu_ring_commit->amdgpu_ring_set_wptr,
at no point there lock is taken. The only lock i see that resembles what 
you describe is for amdgpu_kiq.ring_lock. So this applies only
to some of the code but not to all cases.

Andrey


>
>
>>
>> Andrey
>>
>>
>>>
>>>>
>>>>
>>>>> +    e->sw_cptr = e->sw_wptr;
>>>>> +    e->sw_wptr = wptr;
>>>>> +    e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>>>>> +
>>>>> +    if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
>>>>> +        e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>>>>> +        amdgpu_ring_commit(mux->real_ring);
>>>>> +    }
>>>>> +
>>>>> +    spin_unlock(&mux->lock);
>>>>> +}
>>>>> +
>>>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_mux_entry *e;
>>>>> +
>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>> +    if (!e) {
>>>>> +        DRM_ERROR("cannot find entry for sw ring\n");
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    return e->sw_wptr;
>>>>> +}
>>>>> +
>>>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_mux_entry *e;
>>>>> +    u64 r_rptr, r_wptr, offset, start, end;
>>>>> +
>>>>> +    e = amdgpu_get_sw_entry(mux, ring);
>>>>> +    if (!e) {
>>>>> +        DRM_ERROR("no sw entry found!\n");
>>>>> +        return 0;
>>>>> +    }
>>>>> +
>>>>> +    r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>>>>> +    r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
>>>>> +
>>>>> +    if (r_wptr < r_rptr)
>>>>> +        r_wptr += mux->real_ring->ring_size >> 2;
>>>>> +
>>>>> +    start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>>>> +    end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
>>>>> +    if (start > end)
>>>>> +        end += mux->real_ring->ring_size >> 2;
>>>>> +    if (r_rptr <= end && r_rptr >= start) {
>>>>> +        offset = r_rptr - start;
>>>>> +        e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
>>>>> +    } else if (r_rptr < start) {
>>>>> +        e->sw_rptr = e->sw_cptr;
>>>>> +    } else {
>>>>> +        e->sw_rptr = e->sw_wptr;
>>>>> +    }
>>>>> +
>>>>> +    return e->sw_rptr;
>>>>> +}
>>>>> +
>>>>> +/*copy packages on sw ring range[begin, end) */
>>>>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring,
>>>>> +    u64 s_begin, u64 s_end)
>>>>> +{
>>>>> +    u64 begin, end, r_begin, r_end;
>>>>> +    struct amdgpu_ring *real_ring = mux->real_ring;
>>>>> +
>>>>> +    begin = s_begin & ring->buf_mask;
>>>>> +    end = s_end & ring->buf_mask;
>>>>> +
>>>>> +    r_begin = real_ring->wptr & real_ring->buf_mask;
>>>>> +    if (begin == end)
>>>>> +        return -ERANGE;
>>>>> +    if (begin > end) {
>>>>> +        amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end 
>>>>> - begin);
>>>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>>>> *)&ring->ring[begin],
>>>>> +            (ring->ring_size >> 2) - begin);
>>>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>>>> *)&ring->ring[0], end);
>>>>> +    } else {
>>>>> +        amdgpu_ring_alloc(real_ring, end - begin);
>>>>> +        amdgpu_ring_write_multiple(real_ring, (void 
>>>>> *)&ring->ring[begin], end - begin);
>>>>> +    }
>>>>> +
>>>>> +    r_end = real_ring->wptr & real_ring->buf_mask;
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>> new file mode 100644
>>>>> index 000000000000..d058c43bb063
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>>>> @@ -0,0 +1,67 @@
>>>>> +/*
>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the 
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without 
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following 
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be 
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>> KIND, EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#ifndef __AMDGPU_RING_MUX__
>>>>> +#define __AMDGPU_RING_MUX__
>>>>> +
>>>>> +#include <linux/timer.h>
>>>>> +#include <linux/spinlock.h>
>>>>> +#include "amdgpu_ring.h"
>>>>> +
>>>>> +struct amdgpu_ring;
>>>>> +/*
>>>>> + * start_ptr_in_hw_ring - last copied start loc on hw ring
>>>>> + * end_ptr_in_hw_ring - last copied end loc on hw ring
>>>>> + *sw_cptr -the begin of copy ptr in sw ring
>>>>> + *sw_rptr; the read ptr in sw ring
>>>>> + *sw_wptr; the write ptr in sw ring
>>>>> + */
>>>>> +struct amdgpu_mux_entry {
>>>>> +    struct amdgpu_ring    *ring;
>>>>> +    u64 start_ptr_in_hw_ring;
>>>>> +    u64 end_ptr_in_hw_ring;
>>>>> +
>>>>> +    u64 sw_cptr;
>>>>> +    u64 sw_rptr;
>>>>> +    u64 sw_wptr;
>>>>> +};
>>>>> +
>>>>> +struct amdgpu_ring_mux {
>>>>> +    struct amdgpu_ring *real_ring;
>>>>> +
>>>>> +    struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
>>>>> +
>>>>> +    unsigned num_ring_entries;
>>>>> +
>>>>> +    spinlock_t            lock;
>>>>> +
>>>>> +};
>>>>> +
>>>>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct 
>>>>> amdgpu_ring *ring);
>>>>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
>>>>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring);
>>>>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring, u64 wptr);
>>>>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring);
>>>>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, 
>>>>> struct amdgpu_ring *ring);
>>>>> +
>>>>> +#endif
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>> new file mode 100644
>>>>> index 000000000000..452d0ff37758
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>>>> @@ -0,0 +1,204 @@
>>>>> +/*
>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>> + * All Rights Reserved.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the
>>>>> + * "Software"), to deal in the Software without restriction, 
>>>>> including
>>>>> + * without limitation the rights to use, copy, modify, merge, 
>>>>> publish,
>>>>> + * distribute, sub license, and/or sell copies of the Software, 
>>>>> and to
>>>>> + * permit persons to whom the Software is furnished to do so, 
>>>>> subject to
>>>>> + * the following conditions:
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>> KIND, EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE 
>>>>> FOR ANY CLAIM,
>>>>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
>>>>> TORT OR
>>>>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
>>>>> SOFTWARE OR THE
>>>>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + * The above copyright notice and this permission notice 
>>>>> (including the
>>>>> + * next paragraph) shall be included in all copies or substantial 
>>>>> portions
>>>>> + * of the Software.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include "amdgpu_sw_ring.h"
>>>>> +#include "amdgpu_ring_mux.h"
>>>>> +
>>>>> +#define amdgpu_ring_get_gpu_addr(ring, offset) \
>>>>> +    (ring->is_mes_queue ?                        \
>>>>> +     (ring->mes_ctx->meta_data_gpu_addr + offset) :            \
>>>>> +     (ring->adev->wb.gpu_addr + offset * 4))
>>>>> +
>>>>> +#define amdgpu_ring_get_cpu_addr(ring, offset) \
>>>>> +    (ring->is_mes_queue ?                        \
>>>>> +     (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) 
>>>>> : \
>>>>> +     (&ring->adev->wb.wb[offset]))
>>>>> +
>>>>> +
>>>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct 
>>>>> amdgpu_ring *ring,
>>>>> +             unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>>>> +             unsigned int irq_type, unsigned int hw_prio,
>>>>> +             atomic_t *sched_score)
>>>>> +{
>>>>> +    int r;
>>>>> +    int sched_hw_submission = amdgpu_sched_hw_submission;
>>>>> +    u32 *num_sched;
>>>>> +    u32 hw_ip;
>>>>> +
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +
>>>>> +    if (ring->adev == NULL) {
>>>>> +        if (adev->num_rings >= AMDGPU_MAX_RINGS)
>>>>> +            return -EINVAL;
>>>>> +
>>>>> +        ring->adev = adev;
>>>>> +        ring->num_hw_submission = sched_hw_submission;
>>>>> +        ring->sched_score = sched_score;
>>>>> +        ring->vmid_wait = dma_fence_get_stub();
>>>>> +
>>>>> +        if (!ring->is_mes_queue) {
>>>>> +            ring->idx = adev->num_rings++;
>>>>> +            adev->rings[ring->idx] = ring;
>>>>> +        }
>>>>> +
>>>>> +        r = amdgpu_fence_driver_init_ring(ring);
>>>>> +        if (r)
>>>>> +            return r;
>>>>> +    }
>>>>> +
>>>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>>>> +    if (r) {
>>>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc 
>>>>> failed\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    r = amdgpu_device_wb_get(adev, &ring->fence_offs);
>>>>> +    if (r) {
>>>>> +        dev_err(adev->dev, "(%d) ring fence_offs wb alloc 
>>>>> failed\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>
>>>>
>>>> Looks like a typo copy pase duplicate of the above
>>>>
>>>>> +
>>>>> +    r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
>>>>> +    if (r) {
>>>>> +        dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc 
>>>>> failed\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
>>>>> +    if (r) {
>>>>> +        dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc 
>>>>> failed\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    ring->fence_gpu_addr =
>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
>>>>> +    ring->fence_cpu_addr =
>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
>>>>> +
>>>>> +    ring->trail_fence_gpu_addr =
>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
>>>>> +    ring->trail_fence_cpu_addr =
>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
>>>>> +
>>>>> +    ring->cond_exe_gpu_addr =
>>>>> +        amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
>>>>> +    ring->cond_exe_cpu_addr =
>>>>> +        amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
>>>>> +
>>>>> +    /* always set cond_exec_polling to CONTINUE */
>>>>> +    *ring->cond_exe_cpu_addr = 1;
>>>>> +
>>>>> +    r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
>>>>> +    if (r) {
>>>>> +        dev_err(adev->dev, "failed initializing fences (%d).\n", r);
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    ring->ring_size = roundup_pow_of_two(max_dw * 4 * 
>>>>> sched_hw_submission);
>>>>> +
>>>>> +    ring->buf_mask = (ring->ring_size / 4) - 1;
>>>>> +    ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
>>>>> +        0xffffffffffffffff : ring->buf_mask;
>>>>> +
>>>>> +    /* Allocate ring buffer */
>>>>> +    if (ring->ring == NULL) {
>>>>> +        ring->ring = kzalloc(ring->ring_size + 
>>>>> ring->funcs->extra_dw, GFP_KERNEL);
>>>>> +        if (!ring->ring) {
>>>>> +            dev_err(adev->dev, "(%d) swring create failed\n", r);
>>>>> +            return r;
>>>>> +        }
>>>>> +
>>>>> +        amdgpu_ring_clear_ring(ring);
>>>>> +    }
>>>>> +
>>>>> +    ring->max_dw = max_dw;
>>>>> +    ring->hw_prio = hw_prio;
>>>>> +
>>>>> +    if (!ring->no_scheduler) {
>>>>> +        hw_ip = ring->funcs->type;
>>>>> +        num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
>>>>> + adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
>>>>> +            &ring->sched;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>
>>>>
>>>> In general i see this function is a big one to one subset of 
>>>> amdgpu_ring_init.
>>>> Could you maybe see a way to refactor such that this function is 
>>>> the base
>>>> and for HW related code that different (like BO allocation for ring 
>>>> buffer) you
>>>> maybe can add if (!ring->sw_ring)... and add those code snippets ? 
>>>> To avoid
>>>> substantial code duplication.
>>>>
>>>> Andrey
>>>>
>>>>
>>>>> +
>>>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>> +
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +    return amdgpu_ring_get_rptr_from_mux(mux, ring);
>>>>> +}
>>>>> +
>>>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>> +
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +    return amdgpu_ring_get_wptr_from_mux(mux, ring);
>>>>> +}
>>>>> +
>>>>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +}
>>>>> +
>>>>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    struct amdgpu_device *adev = ring->adev;
>>>>> +    struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>>>>> +
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +    amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
>>>>> +}
>>>>> +
>>>>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +    BUG_ON(!ring->is_sw_ring);
>>>>> +
>>>>> +    /* Not to finish a ring which is not initialized */
>>>>> +    if (!(ring->adev) ||
>>>>> +        (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
>>>>> +        return;
>>>>> +
>>>>> +    ring->sched.ready = false;
>>>>> +
>>>>> +    amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
>>>>> +    amdgpu_device_wb_free(ring->adev, ring->fence_offs);
>>>>> +
>>>>> +    kfree((void *)ring->ring);
>>>>> +
>>>>> +    dma_fence_put(ring->vmid_wait);
>>>>> +    ring->vmid_wait = NULL;
>>>>> +    ring->me = 0;
>>>>> +
>>>>> +    ring->adev->rings[ring->idx] = NULL;
>>>>> +}
>>>>> +
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>> new file mode 100644
>>>>> index 000000000000..c05d8a94ad0c
>>>>> --- /dev/null
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>>>> @@ -0,0 +1,48 @@
>>>>> +/*
>>>>> + * Copyright 2012 Advanced Micro Devices, Inc.
>>>>> + *
>>>>> + * Permission is hereby granted, free of charge, to any person 
>>>>> obtaining a
>>>>> + * copy of this software and associated documentation files (the 
>>>>> "Software"),
>>>>> + * to deal in the Software without restriction, including without 
>>>>> limitation
>>>>> + * the rights to use, copy, modify, merge, publish, distribute, 
>>>>> sublicense,
>>>>> + * and/or sell copies of the Software, and to permit persons to 
>>>>> whom the
>>>>> + * Software is furnished to do so, subject to the following 
>>>>> conditions:
>>>>> + *
>>>>> + * The above copyright notice and this permission notice shall be 
>>>>> included in
>>>>> + * all copies or substantial portions of the Software.
>>>>> + *
>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>> KIND, EXPRESS OR
>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>> MERCHANTABILITY,
>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO 
>>>>> EVENT SHALL
>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>>>>> DAMAGES OR
>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>> OTHERWISE,
>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>>>>> USE OR
>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <drm/amdgpu_drm.h>
>>>>> +#include <drm/gpu_scheduler.h>
>>>>> +#include <drm/drm_print.h>
>>>>> +
>>>>> +#include "amdgpu_irq.h"
>>>>> +#include "amdgpu_ring.h"
>>>>> +#include "amdgpu.h"
>>>>> +
>>>>> +#ifndef __AMDGPU_SWRING_H__
>>>>> +#define __AMDGPU_SWRING_H__
>>>>> +
>>>>> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct 
>>>>> amdgpu_ring *sw_ring,
>>>>> +             unsigned int max_dw, struct amdgpu_irq_src *irq_src,
>>>>> +             unsigned int irq_type, unsigned int hw_prio,
>>>>> +             atomic_t *sched_score);
>>>>> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
>>>>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>>>>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
>>>>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
>>>>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
>>>>> +
>>>>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
>>>>> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>>>>> +
>>>>> +#endif
>>>
>
