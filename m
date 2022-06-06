Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C36C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 16:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202CC11A8C4;
	Mon,  6 Jun 2022 16:17:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB3A11A8C4
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 16:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/IGyQg3WTryshvcnpPRycUaBSMjD1ZwfM8wZ1EAIZWpNZm6kYLTGEnVWabo1qUpVWXr74QyLml/wQ/deHa1iIPhFd0UlfEIBPqwHXnbVfFvPsQvXxcdzLhXZLAuELwwdFoiqWF5Gjy3zQ6K52qcFIbgv/20EKxAtxpy33ByKBatJTO2/SZKIVI8LdajY8JDlcuN0OJ4+IvUInGkBl2+weQBPJSi7/cFhYgh4pFMsuZAl7xv/tk2HwqtCEjEW5n+LnsNQ/RUGPhltErjktliWBRGYN6/gTnj++8+wraEBW6wAcT3eRs4xhL1O74rOAqJ9+9O+lFU/8UAXxzz45d5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD+uvg3Xx9VrWYAm3s0FfnuLj7AW1bZOsPpeBf++nqI=;
 b=br0HQJX+ItOwFPCgtMSbASkTiS9rn7nJKuhyEPLZ99C13XE1/ywC/Cuhx7ZWYDHtkREZOS7jjXKs/Oifi8sPxbO2oO6+vFz/L8z7LMITSxwzRsvW84WVRAUsa5KZzyImELW68nSMPAPuO38ok/UJ7ALRrJQHEuT15nv2WwVlBnrHUrZDoYfshJt4jt+ARFN27HEw9LrkcBAES20tKojbCqvNl982iA+Gg2yHlJu2YagT4BPHlML85f6iFZYDCbLezVuykvL545k+Ip/Pa6y/k2bPOY22NE/XW4bTBhUmPs3NHsZq8MKjSNHDeY+XI+J6rkJRUPrD0SkOqrmhXPWCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD+uvg3Xx9VrWYAm3s0FfnuLj7AW1bZOsPpeBf++nqI=;
 b=mnPrvVmt09ivgC/fASIyPP1ijT/GX3wKJhsiwAGps6K4n0z0EQ++UKlLg8TiW5FtU2nFg+UTuB9cBPzyO/LzUxT1JnxGYy2CErUibDHEWKAtzUzVy8f5knIv99Eu24/SpuXoxbXrR7XPZplLp4bbBhXrTASR6P60fMwOBZHSKGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH2PR12MB3655.namprd12.prod.outlook.com (2603:10b6:610:25::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Mon, 6 Jun
 2022 16:17:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 16:17:47 +0000
Message-ID: <5621261e-7c46-3dd8-4e80-cc2dc92dc847@amd.com>
Date: Mon, 6 Jun 2022 12:17:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] drm/amdgpu/display: fix DCN3.2 Makefiles for non-x86
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220606154228.839904-1-alexander.deucher@amd.com>
 <20220606154228.839904-2-alexander.deucher@amd.com>
 <8eed1f30-3703-fd64-626e-ab088bbde57c@amd.com>
 <CADnq5_PwiVGFHzPrrX6785Ln2e_GojuVpKwjjNPwxG95cihB4A@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PwiVGFHzPrrX6785Ln2e_GojuVpKwjjNPwxG95cihB4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:610:53::31) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13954151-580a-4cc6-d4a9-08da47d8188b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3655:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB36551D1AE42EDB896426C5FB8CA29@CH2PR12MB3655.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfEP4OWZpue3XTa0SE5Nm2BneOSR/2eidtEjKNsH1NQvs+tlZRk7u9CL3CS4uJD95oDTbvKQMJWf7un3uvZPypW2fss564T0hIzztbAbFmZQ9TcagD4rvLjQdSI7BtXh6itJVWtZa40Ro6/1sgpqwEbiN+l3H1XkJrp93Z16mXkQBqlTTKaB6+5n+DCyV3g+8i4XteW/J3BcblxQ8OwGWPcYgquX7cGhLozcJ7xOOlXvwphAsyNNKm+cV+2RWQc5PKhI4iVFgDpJJ/ipLc0D/ElTBIyFJdQW9d/oCfiMpM+SntjEP0cB52v4GnAvbKSVzQLE6s6n3npFgnl1GwKcomqdhU7xIIT3WjlJis72y37A/4ygdrB/2rmfAdOL4SEMJy33BKOaGn3HrH1FuCVcmTfH2vhr1d74MmB3qdLnMcJrddrs5pHJ2nffpaNbrMMUvAmzYvSTsRhdD9lOwVCs5174D4F1ThPXV4zuMNF/jqFRw4OQ5C3/WnUOwzSSEbbQR7mg2cg+Gn/0tRR6qo7Avzg60uU0WDYpqHHXKKEXEaII8w/uKZmRs0HeOJLUAkoO+tNr4WNpwUXHhN+AeGOVgO89pNXGhHSiHDMfm/G4xKybl8wlyXW24GMyMf2+2qFiXv3HTQNCPi3x6wHaTC6Eb22+lw2avjQr+SJgCY2ceKgsqJvhXCk4sbeddWj0EY6e7dtZ3s3QKyOEtURUcgc2UUYL9Fk6pu/T7GjTBEIse1EnE1reU64UEgNzyHoxKgTW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66476007)(186003)(54906003)(66946007)(66556008)(8676002)(31696002)(316002)(6916009)(2616005)(6506007)(6666004)(2906002)(6512007)(26005)(36756003)(53546011)(508600001)(8936002)(44832011)(5660300002)(6486002)(4326008)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm9xd3p1NGhRVVBnT0w4ZWZiQjFKUjBDMHRIcEI2Qm0xZU05YjhMbTdKLzlD?=
 =?utf-8?B?c1VQL29ZcWFScks2V0JBVDJkT05uWHBSOXowOHlVZmFzSSt0Ty9MYjZPT20x?=
 =?utf-8?B?dVQveEF0bDQwamhNTGNTVU85c3pMV0NHd0Z0cEpGN0Y5ZjNpcEZqaFhKMG93?=
 =?utf-8?B?WlpHMVlRVzIvMlZ2eThITEtDTjFHU0Q0RFp4aGhrN1RCTFBmQ2RHZ3JYcTNh?=
 =?utf-8?B?ZHZpY3Z2cDdWNEcrbzR4YlBrU2FKSmN5czdKeHdZZkM0VERya0hnVTFnOGVH?=
 =?utf-8?B?eW5hUkNPV0M4Q21VaDJTTk1aQ1NHZERPanNENEUyY0tpQldwVnZKYlpCcWhW?=
 =?utf-8?B?aVVETXZYMWNDVUt6ZzUwYnZEOVFXcnVjTmZlUk40Z2pwRGwzL2drczZOUHUy?=
 =?utf-8?B?OGtwdGFhaG5qM0oxZU1wYkk2WjlRaGVlSWU3TkRVd2theU9HRzIybFdlNyt0?=
 =?utf-8?B?T3hNbFgxUFZXUm41VTR5MVgzQ1VoTHZJTmdTM2VMN3BvSHFaeUsvWmN6dU4v?=
 =?utf-8?B?RlFkTEtnSkNwQWI3ZytiZTlvNXlHcDY5QkhTaUFOOUQ2M3RndHFCc295dHFC?=
 =?utf-8?B?b0xZNWJPa0dqelNNUkNiSHNVK1hZY0g5UzgvUVkwbDNqakFkYU1Hcno3aENl?=
 =?utf-8?B?QWJOV0JGTGhEdjJzc3MzOGtrVTZYelVzaHdZdlZ5cll1ck5pU2p2aXFIRFZF?=
 =?utf-8?B?elQ5d2FVb0NOZ3hwWlJ2c2NNbS9ybWFZZXIzWkR4b29rQ0hBYTd3RENtYk80?=
 =?utf-8?B?ZTkxc0ptSC9xMHpGa1ArQlBOc3FkOFp0aWNlTGx2cGFOT1p4ZDNUVVl3cW56?=
 =?utf-8?B?aGNDREFLa3NHR3huT3JQUUxxYVJ2cVhLSDVWNjFWSUhreVhFK1pMQTFMc3l5?=
 =?utf-8?B?OFNiakw4MkNYN1JnVzByMnBRZzhSWlEzdW1KSldsT2xDbDk2dC9wK295cTFP?=
 =?utf-8?B?M3ZqKzkxSVlYQVdCUTAvd0lOWCt2Z3hvQlhZK2JHa2ViYWZtNEtRY29HQzdY?=
 =?utf-8?B?NDNFamgzcUQ5Z3hOa1VMYlAvV25HR2dodkkyL1RvVmFXRlhjVmpvWWpCYzhT?=
 =?utf-8?B?akZ4ZkI2YlAyZDQvZzQyWGE0WGh6RUJ5VStidzFvSEliakpkMm9mdmd4MS9W?=
 =?utf-8?B?RS84OVNqU0t3UGtGd0hud0tGa2RYREljUEJNa09Nb3dsbGkyRWpoYlcvMjRQ?=
 =?utf-8?B?aFU3azRGeld0SE5GWUswZXdQLzBCb25JU1NMMGR2UmJBT2RBdE8zU1NTVUFX?=
 =?utf-8?B?ZlpxbC9hbTdPdXFnYTY5Uk56bnZDVzB3c1lXWUFWSmhTRlpJQ0VrNE55UHhC?=
 =?utf-8?B?TmREQ0NIS2NMQWY2dDFGT09oa0VGbkdST1cyU3FveS9IdUhTTktoSG9uRzBa?=
 =?utf-8?B?RThCOTJjbmcxajlpb0RWWTdtRHpYYUtnTTdKOHdrNXNSQ2xxVG1kSjNBRzFw?=
 =?utf-8?B?dk56Qlk1ZEpqRVhUT2JlVXF1ZWYvdGwwZ1lEcXovLy9hME5BWWlhcGZGNHRL?=
 =?utf-8?B?TEZKaEs1QW1ybG9aZFVIR3JoTDRlNE41RDE0WTd3OWV1eW4wUzRMRzVja0RV?=
 =?utf-8?B?RWpON3dRTXhhRmM3cWhQU2I5UWk4M0JPdWJKQWYwbzc0Y3dIMjRCbTJRT3B4?=
 =?utf-8?B?WDVGeXl3b2xkQXpSeHlONTNwQ2RLMUpwaklqYjJ2SWJxUENiMEJNNW1vVjlh?=
 =?utf-8?B?S0tac2hoVmNwd0ExaHdHZGxSZ2g4SGxxTU5vS1V1NTZOOWJyV01ESE1Ob2g4?=
 =?utf-8?B?dlpLSVZiWTJCbENiKy9EQVAwOG5TTFdlbm9iMFU3ZkZMazBZc0Nic3hwVEw3?=
 =?utf-8?B?WnZZbTk1UEhVREN6TExzOE9wbHE5bytiREx1bHdzczMvVTdXeG1EdVhTNDN5?=
 =?utf-8?B?TlZXS1lrdktBWFozYytZQmNNWEwwelBkcG5Dd3Job2hkTHpxODQ0cGRicjF2?=
 =?utf-8?B?MmlybzJZLzRDWVZzZE1VOTNuOWd5cERkaDBXNVpZK2RzeklVVGhTRkJPQVNz?=
 =?utf-8?B?TThTdEdCRGxZV2RvR21kNXl4YW94aG9VTlFXOVp0OGpCckZZQVlsSXp6UGtK?=
 =?utf-8?B?VG5sNnZSN1BwVjU0djcxMEY1d3YzdmdpT3F3dnc1SWVJb3dZQzJ0RjZVaU9F?=
 =?utf-8?B?THlBUmRtV29wM3JvdDdNbngwUy9kK1ZDSzEvOFVHODlPbE9lZU1YUWlrc1dC?=
 =?utf-8?B?WWpaZEpqRThaTEYzNEVNbHd5ZjJBUlA3WWZtbzhZOW0zb1d4MFF4ZzcxbEts?=
 =?utf-8?B?UXR6M3lGditqa0VEazhhRXVsdWdJa2R2RUFIRVpBZCswS2tBdnN1YU9JU2tl?=
 =?utf-8?B?MGhtSU9RbDUwVTZmMVByd1NYbC9GM1hwRk1SOFc4cVRDbkY4ejk0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13954151-580a-4cc6-d4a9-08da47d8188b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 16:17:47.8546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN6xJ92wLaz/37QV9EqewTuevbcU2Xv2td0Dvrd7Cs1oQNDL6PNF9cV64mjd1HmLlyL0iKc4epuleL3Vw6N4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3655
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-06 12:00, Alex Deucher wrote:
> On Mon, Jun 6, 2022 at 11:54 AM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> On 2022-06-06 11:42, Alex Deucher wrote:
>>> Add proper handling for PPC64.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/display/dc/dcn32/Makefile  | 9 ++++++++-
>>>  drivers/gpu/drm/amd/display/dc/dcn321/Makefile | 9 ++++++++-
>>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> index 6e0328060255..3d09db3070f4 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
>>> @@ -15,12 +15,19 @@ DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
>>>               dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
>>>               dcn32_mpc.o
>>>
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -msse
>>> +ifdef CONFIG_X86
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -msse
>>
>> Should this have an -mhard-float as well? I see that in the other
>> Makefiles.
>>
>> The entry below only adds it for gcc, not for clang.
> 
> A bunch of the other resource Makefiles don't seem to have it.  E.g.,
> drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> drivers/gpu/drm/amd/display/dc/dcn302/Makefile
> 

True, and things worked so far. In that case we probably don't
need it.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> drivers/gpu/drm/amd/display/dc/dcn201/Makefile and
> drivers/gpu/drm/amd/display/dc/dml/Makefile do include it however.
> 
> Alex
> 
>>
>> Harry
>>
>>> +endif
>>> +
>>> +ifdef CONFIG_PPC64
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o := -mhard-float -maltivec
>>> +endif
>>>
>>>  ifdef CONFIG_CC_IS_GCC
>>>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>  IS_OLD_GCC = 1
>>>  endif
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn32/dcn32_resource.o += -mhard-float
>>>  endif
>>>
>>>  ifdef IS_OLD_GCC
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> index 9b61d08700ca..5896ca303e39 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
>>> @@ -12,12 +12,19 @@
>>>
>>>  DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
>>>
>>> -CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
>>> +ifdef CONFIG_X86
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -msse
>>> +endif
>>> +
>>> +ifdef CONFIG_PPC64
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -maltivec
>>> +endif
>>>
>>>  ifdef CONFIG_CC_IS_GCC
>>>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>  IS_OLD_GCC = 1
>>>  endif
>>> +CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mhard-float
>>>  endif
>>>
>>>  ifdef IS_OLD_GCC
>>

