Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525AC001DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Aug 2023 07:06:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EA7A10E25F;
	Fri,  4 Aug 2023 07:06:17 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE00B10E25F
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Aug 2023 07:06:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayb9kcJTC7l3CNjoy7qSmNhXrAUF+YN/BOHpa4rZs4L2KgEvU9pQ0lBpyXgx3RMCNSx1THgPhkKqytcDsAEQ1n7cPlJudhEDqklhKphmhHFWeLZgMz0AYHbXihXAdAfxfGIwOcDt0QOm2i0rJ1oK9vbZDry4Nj3kZDGd2oU6AdxLjq7NH9t8Cx7DSW7LAr6r4Skal3NxhbOPY/nzhLRemCZK1IGX/61cARDEVNLkawdumJeinMpgYl2BU+jy8yL+Mcj0mN5RsfTnxPbOACB1nuTxPjahldURCQOS83skkox1R3gNSHEkrPfsUCpWyui42Kw0towV6Ym61kClIvd//A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at9vZmlbEHh7we9KS2vkVc6y9U6icM1uSmnKENZKD+c=;
 b=jAbVktDHdLdCjjy1vXNY2wSo6BDPPrBxUjP6W9v9GpYZkrSQ1FUSHgpCECV26e3HhHtNAsK6XeEB2Pa6RpxfxXoPJJOYYp2PXCvLViI7x1qBOTg+ODZLXBB+OfQUDldIbItWGiokFCq9GFKlVI/0ybWKVWDLeP+OqhozYV/ahxtqe4Ivc1edRpDvv9eWCdHwOdR/vzUSkossQVc11Oya2x5jShqIqE2HYf2GDMWo0eqE36dn4k1ypWlPnQOQCINwmlg34yx4vKt1xU3nulhXenFZ6CLVtVVJ0dAVrpet2r3Vn64XZATpcibZLwsB0sEMckajN2n9700cc+Smf0HfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at9vZmlbEHh7we9KS2vkVc6y9U6icM1uSmnKENZKD+c=;
 b=cOFQQPvE7dNQcOaIErba7cHUYv2Cfyr+UVMFHYIBhbS6F6XZNf3PytRHqS90aI4k6RcNUpsIheXb+Lx6tHEopQeBGgxv400N4S3RsTiv14L49QWGfgZLBJ9vKNaL32iu6ZcaEWl29faudHWelHQLbQt69WSBR8L2EsTCUAxL7Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 07:06:11 +0000
Received: from MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b]) by MN2PR12MB4128.namprd12.prod.outlook.com
 ([fe80::c725:d5a0:a4a8:772b%3]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 07:06:11 +0000
Content-Type: multipart/alternative;
 boundary="------------zYZgwzEesZaeouyLSyaC0HJI"
Message-ID: <e23989ab-53f8-476c-a2c8-055b1d75f09e@amd.com>
Date: Fri, 4 Aug 2023 12:35:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Remove volatile from 'wb' & from 'ptr' in
 amdgpu.h
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
References: <20230724155418.2179209-1-srinivasan.shanmugam@amd.com>
 <CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com>
 <f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com>
 <af0efe19-e78c-2a8c-96c3-ddec10a62cf4@amd.com>
From: "SHANMUGAM, SRINIVASAN" <srishanm@amd.com>
In-Reply-To: <af0efe19-e78c-2a8c-96c3-ddec10a62cf4@amd.com>
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To MN2PR12MB4128.namprd12.prod.outlook.com
 (2603:10b6:208:1dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a3a065-9e54-4090-0b6f-08db94b94887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwgLnT4gzwfN0DKy1prCB8A1gW8DZ6dSoRtnrJIaFWxzf29RuIxq9BHAxWky8uwuEby3IHsnQT6iT6yuvMjHRI39Oqlj3zM3kXdfSyo8moDugznUBaYTOnRcv/LFYOp2oDHCHjkqrGwaKtg2LMiXb9O0UJzhfEnrQ63STQtdLUYxkvOto8yG4pMAquTTNZdTs7nQEsbtIb0ZIsoIj1/DHvmbdvg0lyiT8OcAadXaRxR6rmN6Z7eFTCT9pce4zwBppzIwA2WLCBQhtA03YR7CsiYw0cBw86VPxduiLlCHYwZGO62m5Sr1IWWd+fDG+S52ZrWXvQy/CvEV2yQetVeUwtLxtew7eQLHYZzM1jOO9fHIlEMfEAyMFmfEKsrm2981jdjxXktQj+zwLiD3SDsdga5+eo4aRiW9zIQx3wT0LHRGHbDfjivkIpY7tA6hdVUbBQqSVXJBWo0UBoGrf4xumrl29BIMlqzBwz9fD3q0eZuL4qaq5dywF0jydDxD8oT2LIDzzTtzPqSn0QPgtIisjd31/0hyTWe9v/SPJAhq/Yi7chGvl9xVjpYRociK4GtBVjEt0JOKMGHUJj//MV24XgbOzGHIBJHRvrOkR2mVOL/qDRVi9ToUdpayLrxs1Dhl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4128.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(1800799003)(186006)(83380400001)(2616005)(66574015)(41300700001)(316002)(66476007)(66556008)(66946007)(4326008)(6636002)(53546011)(38100700002)(6506007)(26005)(8936002)(5660300002)(8676002)(6666004)(33964004)(6486002)(966005)(31696002)(478600001)(110136005)(166002)(2906002)(36756003)(6512007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTNpcE15YWVZMmdtSENmQTRjMlFTQVcyTjQ2NDZYSG1FaHZLZ1FoajY3RzF0?=
 =?utf-8?B?Uk1HaWtCKzhiVCsvNXd5cWVqYnJnMGQzUzE3YVRZaUZxZHc4R1dxeFdzNjh5?=
 =?utf-8?B?V3FDQXl2NG1ZZlRYSlJpQlp0TlczK1ArbGE4VnB0ZkgyeFJHekI3bkFqK283?=
 =?utf-8?B?b1RxdUJKcktLWGhXUlVZWXBHb1crdUtub1FQZENHMlFXRFlHeVhoTzhLaUZ4?=
 =?utf-8?B?T2Rhck8relI2MGt0UDJRK1p2b0VLcG11NEhFRU03U0NzemgrdDJlcnAxa3dB?=
 =?utf-8?B?NjlLckNldkZrVloxQWMwSGJXNmx2aUZXdit4YVV6L3pKNnNOcnJFVGRacDNI?=
 =?utf-8?B?dVJBMnNsWlN3V1FnTDJoRzZTV2ZvWG0yNE1mdjFOOUxzQjJvdVVRc3A5STVB?=
 =?utf-8?B?c3Fibkh0NUFQS2dlU1JBR3Q2TWV3cUpiL1lHcjVHaHFEd1daNTNBbkVFYndN?=
 =?utf-8?B?RGlUckN4Z1Y2ZmxUOXF1ditGd2lTRWRmcy9UcGxUMWF1TU0wNWE5cUxRUzRo?=
 =?utf-8?B?ODJwTFhiTmFxLzlsUGtNK0V3VlJTMitoVkQxUWxud2lvclpNUnR6YkxqWVB4?=
 =?utf-8?B?SURySUZuaG91V2R6THhOTWZFdTQyRU5OcVAvSnZyejQ4cGl4L0tjMkVWQ2l3?=
 =?utf-8?B?YlUrN2VQK3N1bHUwR1h4RHBLQmc1cktXd1pOMFpTZjM0ZzhNU2o4N3V2T3RQ?=
 =?utf-8?B?WFhQRVVBNk1EQzVUK2VwS0dDMmtCTkh3b3d2bnZwNHRtYkFuRWN2YVJlNUs3?=
 =?utf-8?B?ZTBUQ0s1cUFmM0t3UWtHTzIvU1VaSWc1djhsdTFkZmdUN3BtWE4wbENlaERO?=
 =?utf-8?B?OUxvWGtWRXdnSEFSTU5kbFdJbDNaelc4bmJ3M20rY2FBRG9wcmg1SmNWWnNq?=
 =?utf-8?B?aWcrcVZaSWN4TWFLa01IdDhRcmQ2OCtiWnFvSlhCR3AzYlFQMTVuU2tuQWph?=
 =?utf-8?B?djAxZ2hIdWRUNUZNSWFOU1IwUFNBSTF6QndhWTk3TlFiditydHQrS3J1N3Nx?=
 =?utf-8?B?b0RsZ05yUjRzM0ZPdU4waXlFb012NFBKK2FpOWRpMG1wQTFPQktpY2prMVhu?=
 =?utf-8?B?OXg0aXZCRFMzTExJZ2ZNaE45bHdBZFNmeFFWYUFpOWJsM1d1enh6V2FiakVn?=
 =?utf-8?B?Z1VpV1B0NFBzempmbk1xdW1TTW5rM0Q5YUZqOVBZN0xoNS9uNFc4c3NvRzFK?=
 =?utf-8?B?T2JHdWVsNkMzTUVybDN6WVRvZHJWemRPc25VTEg5ZU1ZbVkxLzAyQmp2UGk4?=
 =?utf-8?B?UzhNckNDUm5CclQrUHhsTU5VWWhJSktWZ3J2UGVBcnlzbXhoeU1JUHlVOW1O?=
 =?utf-8?B?anVHM1JGRW8xdndscFBQZ2lNMzNWaEdvWWNsVHpCZnd4THpSSlZZUHlYUGdG?=
 =?utf-8?B?TEVoZkltYkdTcEhxTTFpamRxdzJSaDBBMnFzcndocWZPM0JaU09sc0xiODVF?=
 =?utf-8?B?V1QrY21lU3VBUDY5Qjd1VmVZOW5ZNUpONFROczNid0R0b1czS2gyc2d5bVFG?=
 =?utf-8?B?dk52cGtGOGFONUw5czQzSGV2NitnQjNjWmdUMGdscmI3MCt2MjRKMERsaVNR?=
 =?utf-8?B?UXNNYWYzSWQ4WUNab0dtSHlSUTVjcHc5Zm9PRnJvUXlDRUhVN3pVT29kSm56?=
 =?utf-8?B?WWxDTVVqamptaTJ0bi94T1pJV3U3QWE2ekVpOUI1Z3NwMkI3VXNPMlhuekRj?=
 =?utf-8?B?N2g0anI4eDU3TUx2aDE4T0JLQ3JFNW1hSVpWS29uL3dvbW9peFFrNXN4OHBN?=
 =?utf-8?B?QVZPbmphbHRLNFlZOG5pNzRCTllUNEEzaUpKSkdYdVZ6RmtPbzA5TU1RU25p?=
 =?utf-8?B?VVR5Rzh4NmZkMHBmbmFtYWY4QXFlR1hDayt0RW02M1JZUlM4VVhHTjZzaUND?=
 =?utf-8?B?VmJCZktkNk1pREdPVklRUkxyOGpyKytHMHphTCtWU3VjQjZaSEZVeDBwakwz?=
 =?utf-8?B?bGpCbFBCMXdtbmFKV3VTcTJOSjB3cTJ5YUNTTStON1I2dHp1b0lkczBUQ2dN?=
 =?utf-8?B?SlRkWXBENTArN2dxM3QxTFBRNFdGVjZSZ1dCTkRsMyt1Ry9aakNzV2dndVBy?=
 =?utf-8?B?MGlQdVZLK2V5ekcyYUg2cVRSWjNYdFZvenlNRktuUzl6RFViWUdZUEVSUVhE?=
 =?utf-8?Q?xyq65+82tk2DHLaKKVXy1PTZm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a3a065-9e54-4090-0b6f-08db94b94887
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4128.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 07:06:11.3767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rwxTdumNVlhAE3rzJKs8ax+j85SEc91zaphX3OU7/bW6LxzZ4CB1wdRYOc3CTOmg4Q2PWwQ40PQXf1yAoe+Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------zYZgwzEesZaeouyLSyaC0HJI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/3/2023 2:12 PM, Christian König wrote:
> Am 03.08.23 um 07:23 schrieb SHANMUGAM, SRINIVASAN:
>>
>>
>> On 7/24/2023 10:43 PM, Alex Deucher wrote:
>>> On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
>>> <srinivasan.shanmugam@amd.com>  wrote:
>>>> Fixes the following from checkpatch.pl:
>>>>
>>>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>>>> +       volatile uint32_t       *wb;
>>>>
>>>> WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
>>>> +       volatile uint32_t               *ptr;
>>>>
>>>> 'wb' field from 'amdgpu_wb' struct & 'ptr' field from
>>>> 'amdgpu_mem_scratch', is not used to access h/w directly, neither they
>>>> are shared variables, so volatile is not necessary
>>> How did you come to that determination?  Both are GPU accessible
>>> memory allocations.  The writeback (wb) allocation happens to be in
>>> GTT so it's system memory, but the the mem_scratch allocation can be
>>> in device memory.
>>>
>>> Alex
>>
>> Hi Alex,
>>
>> Thanks for your feedbacks!
>>
>> Commit message is misleading, I presumed that this volatile modifiers 
>> are used for monitoring HW status registers due to external events & 
>> for some shared variables - may be volatile might be needed for *wb 
>> pointer variable - as they may be used for caches in between (on 
>> surface level info), can we split this patch into two, I felt 
>> volatile for *ptr is unnecessary as it is type casted with void type  
>> [(void **)&adev->mem_scratch.ptr); in amdgpu_device.c]- Any advises 
>> onto this please?
>>
>
> Instead of declaring pointers we should use READ_ONCE()/WRITE_ONCE() 
> when accessing those values to make sure that the compiler doesn't do 
> any nasty things.
>
> Regards,
> Christian.
>
Thanks a lot Christian!

So both the variables needs to be changed to plain variables - (ie., 
"u32 wb" & "u32 ptr" without any volatile keyword or pointer variable) & 
then protect this variables with "READ_ONCE()/WRITE_ONCE()", For ex: I 
have proposed - https://patchwork.freedesktop.org/patch/551273/ am I 
correct please? but may I know please is that volatile keyword, is that 
doing the same job as "READ_ONCE()/WRITE_ONCE()", where compiler 
optimizations is disabled? so that we can leave it as it is. & ignore 
the checkpatch warning onto this please?

-Srini

>> Best regards,
>>
>> Srini
>>
>>>> Cc: Christian König<christian.koenig@amd.com>
>>>> Cc: Alex Deucher<alexander.deucher@amd.com>
>>>> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index a046160b6a0e..06f79a84ff4b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>>>>
>>>>   struct amdgpu_wb {
>>>>          struct amdgpu_bo        *wb_obj;
>>>> -       volatile uint32_t       *wb;
>>>> +       u32                     *wb;
>>>>          uint64_t                gpu_addr;
>>>>          u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
>>>>          unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
>>>> @@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>>>>   /* VRAM scratch page for HDP bug, default vram page */
>>>>   struct amdgpu_mem_scratch {
>>>>          struct amdgpu_bo                *robj;
>>>> -       volatile uint32_t               *ptr;
>>>> +       u32                             *ptr;
>>>>          u64                             gpu_addr;
>>>>   };
>>>>
>>>> --
>>>> 2.25.1
>>>>
>
--------------zYZgwzEesZaeouyLSyaC0HJI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/3/2023 2:12 PM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:af0efe19-e78c-2a8c-96c3-ddec10a62cf4@amd.com">
      
      Am 03.08.23 um 07:23 schrieb SHANMUGAM, SRINIVASAN:<br>
      <blockquote type="cite" cite="mid:f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com">
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 7/24/2023 10:43 PM, Alex Deucher
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
          <pre class="moz-quote-pre" wrap="">On Mon, Jul 24, 2023 at 11:54 AM Srinivasan Shanmugam
<a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true">&lt;srinivasan.shanmugam@amd.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Fixes the following from checkpatch.pl:

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t       *wb;

WARNING: Use of volatile is usually wrong: see Documentation/process/volatile-considered-harmful.rst
+       volatile uint32_t               *ptr;

'wb' field from 'amdgpu_wb' struct &amp; 'ptr' field from
'amdgpu_mem_scratch', is not used to access h/w directly, neither they
are shared variables, so volatile is not necessary
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">How did you come to that determination?  Both are GPU accessible
memory allocations.  The writeback (wb) allocation happens to be in
GTT so it's system memory, but the the mem_scratch allocation can be
in device memory.

Alex
</pre>
        </blockquote>
        <p>Hi Alex,</p>
        <p>Thanks for your feedbacks!<br>
        </p>
        <p>Commit message is misleading, I presumed that this volatile
          modifiers are used for monitoring HW status registers due to
          external events &amp; for some shared variables -&nbsp;<span><span class="ui-provider fy b c d e f g h i j k l m n o p q r s t
            u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr"> may be
              volatile might be needed for *wb pointer variable - as
              they may be used for caches in between (on surface level
              info), can we split this patch into two, I felt volatile
              for *ptr is unnecessary as it is type casted with void
              type&nbsp; [(void **)&amp;adev-&gt;mem_scratch.ptr); in
              amdgpu_device.c]- Any advises onto this please?</span></span></p>
      </blockquote>
      <br>
      Instead of declaring pointers we should use
      READ_ONCE()/WRITE_ONCE() when accessing those values to make sure
      that the compiler doesn't do any nasty things.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
    </blockquote>
    <p>Thanks a lot Christian! <br>
    </p>
    <p>So both the variables needs to be changed to plain variables -
      (ie., &quot;u32 wb&quot; &amp; &quot;u32 ptr&quot; without any volatile keyword or&nbsp;
      pointer variable) &amp; then protect this variables with &quot;READ_ONCE()/WRITE_ONCE()&quot;,
      For ex: I have proposed -
      <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/patch/551273/">https://patchwork.freedesktop.org/patch/551273/</a> am I correct
      please? but may I know please is that volatile keyword, is that
      doing the same job as &quot;READ_ONCE()/WRITE_ONCE()&quot;, where compiler
      optimizations is disabled? so that we can leave it as it is. &amp;
      ignore the checkpatch warning onto this please?<br>
    </p>
    <p>-Srini<br>
    </p>
    <blockquote type="cite" cite="mid:af0efe19-e78c-2a8c-96c3-ddec10a62cf4@amd.com">
      <blockquote type="cite" cite="mid:f8c546b3-669b-41dc-bc35-c7fef96ad4e4@amd.com">
        <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p
            q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Best
              regards,</span></span></p>
        <p><span><span class="ui-provider fy b c d e f g h i j k l m n o p
            q r s t u v w x y z ab ac ae af ag ah ai aj ak" dir="ltr">Srini<br>
            </span></span></p>
        <blockquote type="cite" cite="mid:CADnq5_NcEr3=bDoSo5_YYYuNAMps655fcOuUDaAPmw3_QDwQNQ@mail.gmail.com">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com" moz-do-not-send="true">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a046160b6a0e..06f79a84ff4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -502,7 +502,7 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);

 struct amdgpu_wb {
        struct amdgpu_bo        *wb_obj;
-       volatile uint32_t       *wb;
+       u32                     *wb;
        uint64_t                gpu_addr;
        u32                     num_wb; /* Number of wb slots actually reserved for amdgpu. */
        unsigned long           used[DIV_ROUND_UP(AMDGPU_MAX_WB, BITS_PER_LONG)];
@@ -621,7 +621,7 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_mem_scratch {
        struct amdgpu_bo                *robj;
-       volatile uint32_t               *ptr;
+       u32                             *ptr;
        u64                             gpu_addr;
 };

--
2.25.1

</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------zYZgwzEesZaeouyLSyaC0HJI--
