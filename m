Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE91C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 07:09:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F3110E722;
	Thu, 10 Feb 2022 07:09:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD7610E722
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 07:09:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZdAhBbrMtYqsKxv6t31J6IcT9quuetA9o0d3ghTvjf7DAQLjbrx8v1MNolnxThttaMQ/enjn6yOaPGTFYJZfIG1evrjwJfxapUyKnCLSXuH4kflySCoEbgcIFQrZqRZh63oZNE8Pvs8obUdSm+iiekModaI/ilMgcH5nh6GsR57IMNgqsSi1VVGX8EbgnmSaZ27fQb5+AZk2gAU+1MJzZKka68VZW3+hFygKajjtPysUkSokk8WiUdIq4Tntm2YdQ+8KR9SfCj9iHY7E9ZQ2dCJCl8SE9eB4mi/M9D3wnpnhQNIhGDBXNIkgyR1twfA4qrG7hWbrGsqxQ4yk13XcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78mI611J7zCUAt1ojItFirEfZEcikaYSltYcwbPyPrU=;
 b=SHUn4+RZFuC2BmdkTbZt/hodSyJruwZfjEjdxxJIbaJ+h/HeQ88G2kZ0cbGxCC0VuaSJGx/gTW+yWpLphF1956H0eSBzLZADp+sD/iMO9UGeQp9aLRSmXSj3r93JWSvG+aYWgY42yE5CNFjKGIBfk2J2WhhvieOmn/FjBE+wF+meSGHRWbNhm1L6nXpscH2hv/3t1HLakaN+fXvQllDUzAb3qYaa9bOkmWBBhjpurF9KY5hdcdIda8Bab3KVg5l5rOCF8Mg2c/khiXb5yb5JNZc3pTesb+JFcAQ4cSMTsqphXlVaSW7oXe1athqqTTKO5/eg5m+uCokktYapeg+Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78mI611J7zCUAt1ojItFirEfZEcikaYSltYcwbPyPrU=;
 b=iNoaEPlfoZzxgVurfROLDwlk2I9CcwFZ/6eV6V+BDWEm+/j8b5c4eEAOcJSaAYlGZ5mg1IAykCEC/LFYDo4pCMqG1QVSU4dMkawBhTl1Zaq5KjLxXza8cgU5C+3kFXST/mQ8kHn+xfq2DKgWZO3TbPs4cGXMCIwrCS2EaJbiHJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR1201MB0075.namprd12.prod.outlook.com (2603:10b6:4:54::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 07:09:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.012; Thu, 10 Feb 2022
 07:09:16 +0000
Message-ID: <1b79efe6-20e9-5543-4b2e-fa09f97c8e9a@amd.com>
Date: Thu, 10 Feb 2022 08:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: add reset register trace function on GPU
 reset
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
References: <20220208081647.3025-1-Amaranath.Somalapuram@amd.com>
 <20220208081647.3025-2-Amaranath.Somalapuram@amd.com>
 <CADnq5_Pun3UPKJsTKEf4pu3R=UbbHAZDW5-=+pekTDx4TWsAEw@mail.gmail.com>
 <6a7ca5ae-6d78-b8fd-cba8-cd2dca4418f4@amd.com>
 <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <49e24f9f-4657-d3ce-e84e-abbaa56d3181@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR05CA0035.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::17) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd89660-03d5-420d-40e8-08d9ec643fb2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0075:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0075B5715981AA6BD6F6D583832F9@DM5PR1201MB0075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:294;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IlXJ0QHc115XY8X5hD3HDo6r63E1+l/C/m7tQICxfX2sNbz5RruUBn4JExW9eU3DH0bFQ1wUigv2PHdo4EOJPCs0sgJUJrma9qg5OEmmeWl3Wg2pVrC5fs4WrFK3IS9qhi4fwOBR9fZQsixaxKZpanfK1/d3pG1XJ8v9fchKydB8FucuANJrT3mqlmgxrPslyIB9eipyoiJW7nFv+A0XPNcDNXkGctH1YQH/EgUo8/iSN0tVKiJAtSkL/qpLQXXmfXGP9QqDiHSdqLzOCCI5zn4CrxTwct24GgBLjeo5cEXucslBWOR46TheWBIHXgtr/zuzrc/S7dha+enbaajFCJfKGj4lrPP941F50crgFKUkuRl3hpNZpC+3psdlnDmjdxwEy54tsoMaDA93Sez9FHPKexGhhm+MYtm55jdXSasHeNMVqvmI8iAVovPK4oc7voTSzlNmF78va4cVAY9laka+9niFNh2Lpxby2hRSG1rDWXN96DPFn1tYfWInhTk6vxlhzsnjweBuUElsUTCBx2KQjX8G/iMUsixx6WVufsSi/nKATA3O2L+ycepu0yvKA3iZj55TZCDHDSO2mkUZUHV2MjX2BbJoc+22IrXtLXNy5ZcupP/50mAbv9U2SH1w32iJ/PAWv8EeSa0c6Nnt2lUwEGAG0+v38wA3XSRWdbZR25CK/01YEtwPxtS7U/9msAryVmcvx+rk3y7bEWsmE5W23yazyU94nmr0yqnPQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(2906002)(31686004)(83380400001)(31696002)(53546011)(66556008)(110136005)(66476007)(6636002)(6506007)(6512007)(4326008)(6666004)(8676002)(54906003)(186003)(26005)(66946007)(8936002)(36756003)(508600001)(5660300002)(66574015)(86362001)(2616005)(38100700002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU9oeDNsV3NZVmpobG1sdXNySTZtSmtXL1daRjlzWUdlRkhubkQ3ZENXUzhW?=
 =?utf-8?B?SnZ3Skx1RHZYamdNR2ZFYVVMc1grdG9TajNob3hPR3RuVTF4TVFXRmJGOXFp?=
 =?utf-8?B?WmdLcy9wL3lhTGVXRXJ0aDEwajh1Z2xkbW5WNGJ0S2N3UkxYNkIrRGo3L2Fq?=
 =?utf-8?B?QmtUeWJiaVlJNHZzbExOR29JR3ZmN2hJYnBCTzRkbWIwdjB5ZVdMRGNuTjdI?=
 =?utf-8?B?RHJoVTNwUWIxR04va1NiZlRLOHN0eXdqOE02dzJxOHI5Y0pOK2lDcXlwQ0FR?=
 =?utf-8?B?QnZyVnJ5ZDBqTjBVbms2OFBUSDVlT3FSd0tvREJtU2ZLK0VWbElwZk1rdFJN?=
 =?utf-8?B?K0M5NWZFUllMbFRiZHhMaWdZRVVMb2VtcGx4NU83LzV3eHNHZ0UzQldUNWhX?=
 =?utf-8?B?c3h5V1hubmY4QVBLcS9TaXJ5RVJMOVh0enJIR0VmNUFuQVFVY0xpSjdsSWJx?=
 =?utf-8?B?cmNCQ0IyRXR4WHFYa0FhVFZQSTdNQ296MFpNemVRZm1xNDJzbGQwK2UwSGpt?=
 =?utf-8?B?MDdTRkdMd3BUbXQrRUdXcW42VEtleitpTUdFZjhSb2RVdFBiclVsNGFoREo3?=
 =?utf-8?B?Y2xwSncxWU5OYjg0d0pTRUxJeXVPcDZ3bjQ1aCtRalJpdlNUWWJZa1QwMXk1?=
 =?utf-8?B?YWxlVmtZRHV0b1F4TDU4MGcrdWlMTmkwY1B3WVhzL0JpSm5pWUpleVdIRFJP?=
 =?utf-8?B?WWNXYTQ0TExWOHBEYzhZcHJDMklUNGxXZDk0dGZEeFk1QjdydHByU2VFTWpF?=
 =?utf-8?B?aU12MVcwOEo0bzlob0x5d0tZTXF1d1dHb2ZZUHJoeHo0Q3Y3eTRyN1B4WXIv?=
 =?utf-8?B?clAveWUwSUpaWXBDK1NNTC9VY2tweDZCc2x6SUd2ekNuQVVqemcwN01IL0l0?=
 =?utf-8?B?NFNuL05tZS9aSVV4djFQVFdTNWRzclllLytYcUg0a0tBd0JZaWVVaTJWb2Ru?=
 =?utf-8?B?SUhMcDVIYitTOENYOTZUSTRBNk1wK0R1emhVbWpPZzlaZUtxK3hTU0hROUNR?=
 =?utf-8?B?VXhPNm5JN2IweEtWYVE5Q2xRY1crandEQXlyVC9xUmlkcGt2TlhVem1YNmlL?=
 =?utf-8?B?SUJPQ0loUDM2T212ajdKMGFzbjZSUm0wOG8wclNHYjhsazQvWk1ZWmRUTUcx?=
 =?utf-8?B?eDFZak5iZE9tOFJqTGVMb3hKRUVRRkRlckhLazYrUmJxSVJmcWdWdzJyM2w0?=
 =?utf-8?B?aVB1Q1FHQkl0QUtFTjlNaEhESTRxMFo3emE3VXhLK0sxa0RWWTJqeUluZ2Jk?=
 =?utf-8?B?M1FDU3lIbHFqV3VSNkdiOUdERzJXdnVFMmloT2Q1NTg2K3BvTUVpNGowUHgy?=
 =?utf-8?B?ZEJiU1h0d1lsQXI3VnRvdG1LU1o1MVNMN2sxKzlQUzkrS1hDZGRCdmxPdnM0?=
 =?utf-8?B?K2t1eWFaYzhqT0pOY2YzVEhoUldxcWpjSGhjOG92YWt6NE1vSGVkcmttdnMw?=
 =?utf-8?B?NnVSRXV2ZDZkK3NIbTU1SXV2K3F2YXA1TUZyZWpJU3owRHZNS2pxMHpoaWpo?=
 =?utf-8?B?eC9jNk9KV0E5SXdGWk1Dblo2bk9qbXIvQndUTkhJdTRwWVdKT0pQZmp2ODBO?=
 =?utf-8?B?R01TZEJiQTEyWGI0VFNEZFZZWTBLTkJSOUZJQTNOOWFxNEdrOTFSeklLMmx6?=
 =?utf-8?B?N2hyby9PNmlBbm5FcGJ1WEg3bW1DR1FzTFNJRVN4eFBrWDhGVlF6Q2UyOWlm?=
 =?utf-8?B?cUFGMnZuUy9mZjFUMGUxR09oUWUxK2FIMFovOU9GK0FQOFRsL1M5dG5JaUNE?=
 =?utf-8?B?eVhGRDl1NnJyZkl5Y3BRaUxsT1pPdWlXYTFkSXltbi91UlJYakNOYnBYZmpk?=
 =?utf-8?B?RENDbG1KUmhRbitYcWRDQ2taMk9hS2hLbzhWdlBGa3lPNFhNditEM2ZFUm1z?=
 =?utf-8?B?NE5xNkZKN1IzNnFRZHFHODE0UFpPMDN0UHBmMkZsNHpFSVJVeEMyVUdvOEpL?=
 =?utf-8?B?b2htaUt4cWhkUzk4S3REUE8wUXQvQ3RlcUhnZEFNaGJ0TWYxQlhnRnFnMGFH?=
 =?utf-8?B?TTQ5dnYwZ3kxY0pGb1dhRFNXcG80U1ZlVHk0WWU5RTR4aDVFU01PSUpmbjZF?=
 =?utf-8?B?RXlrNlVrQW5XK0djUUNuZysrN081UkNxT2hYUEJNM0JadlJTblJaKzdyWWxJ?=
 =?utf-8?Q?Wl7Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd89660-03d5-420d-40e8-08d9ec643fb2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 07:09:16.1042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxWKYmU3AStAKREgMXBNy14YRrwrPudOR+yoSy592TRBoMNJm7dRa+iCtRPTe6St
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0075
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Shashank Sharma <shashank.sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.02.22 um 06:29 schrieb Somalapuram, Amaranath:
>
> On 2/9/2022 1:17 PM, Christian König wrote:
>> Am 08.02.22 um 16:28 schrieb Alex Deucher:
>>> On Tue, Feb 8, 2022 at 3:17 AM Somalapuram Amaranath
>>> <Amaranath.Somalapuram@amd.com> wrote:
>>>> Dump the list of register values to trace event on GPU reset.
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 
>>>> ++++++++++++++++++++-
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 19 +++++++++++++++++++
>>>>   2 files changed, 39 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 1e651b959141..057922fb7e37 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4534,6 +4534,23 @@ int amdgpu_device_pre_asic_reset(struct 
>>>> amdgpu_device *adev,
>>>>          return r;
>>>>   }
>>>>
>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>> +{
>>>> +       int i;
>>>> +       uint32_t reg_value[128];
>>>> +
>>>> +       for (i = 0; adev->reset_dump_reg_list[i] != 0; i++) {
>>>> +               if (adev->asic_type >= CHIP_NAVI10)
>>> This check should be against CHIP_VEGA10.  Also, this only allows for
>>> GC registers.  If we wanted to dump other registers, we'd need a
>>> different macro.  Might be better to just use RREG32 here for
>>> everything and then encode the full offset using
>>> SOC15_REG_ENTRY_OFFSET() or a similar macro.  Also, we need to think
>>> about how to handle gfxoff in this case.  gfxoff needs to be disabled
>>> or we'll hang the chip if we try and read GC or SDMA registers via
>>> MMIO which will adversely affect the hang signature.
>>
>> Well this should execute right before a GPU reset, so I think it 
>> shouldn't matter if we hang the chip or not as long as the read comes 
>> back correctly (I remember a very long UVD debug session because of 
>> this).
>>
>> But in general I agree, we should just use RREG32() here and always 
>> encode the full register offset.
>>
>> Regards,
>> Christian.
>>
> Can I use something like this:
>
> +                       reg_value[i] = 
> RREG32((adev->reg_offset[adev->reset_dump_reg_list[i][0]]
> + [adev->reset_dump_reg_list[i][1]]
> + [adev->reset_dump_reg_list[i][2]])
> +                                 + adev->reset_dump_reg_list[i][3]);
>
> ip --> adev->reset_dump_reg_list[i][0]
>
> inst --> adev->reset_dump_reg_list[i][1]
>
> BASE_IDX--> adev->reset_dump_reg_list[i][2]
>
> reg --> adev->reset_dump_reg_list[i][3]

No, that won't work.

What you need to do is to use the full 32bit address of the register. 
Userspace can worry about figuring out which ip, instance, base and reg 
to resolve into that address.

Regards,
Christian.

>
> which requires 4 values in user space for each register.
>
> using any existing macro like RREG32_SOC15** will not be able to pass 
> proper argument from user space (like ip##_HWIP or reg##_BASE_IDX)
>
>>
>>>
>>> Alex
>>>
>>>> +                       reg_value[i] = RREG32_SOC15_IP(GC, 
>>>> adev->reset_dump_reg_list[i]);
>>>> +               else
>>>> +                       reg_value[i] = 
>>>> RREG32(adev->reset_dump_reg_list[i]);
>>>> +       }
>>>> +
>>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list, 
>>>> reg_value, i);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>                           struct amdgpu_reset_context *reset_context)
>>>>   {
>>>> @@ -4567,8 +4584,10 @@ int amdgpu_do_asic_reset(struct list_head 
>>>> *device_list_handle,
>>>> tmp_adev->gmc.xgmi.pending_reset = false;
>>>>                                  if (!queue_work(system_unbound_wq, 
>>>> &tmp_adev->xgmi_reset_work))
>>>>                                          r = -EALREADY;
>>>> -                       } else
>>>> +                       } else {
>>>> + amdgpu_reset_reg_dumps(tmp_adev);
>>>>                                  r = amdgpu_asic_reset(tmp_adev);
>>>> +                       }
>>>>
>>>>                          if (r) {
>>>>                                  dev_err(tmp_adev->dev, "ASIC reset 
>>>> failed with error, %d for drm dev, %s",
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> index d855cb53c7e0..3fe33de3564a 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
>>>> @@ -537,6 +537,25 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>>>>                        __entry->seqno)
>>>>   );
>>>>
>>>> +TRACE_EVENT(amdgpu_reset_reg_dumps,
>>>> +           TP_PROTO(long *address, uint32_t *value, int length),
>>>> +           TP_ARGS(address, value, length),
>>>> +           TP_STRUCT__entry(
>>>> +                            __array(long, address, 128)
>>>> +                            __array(uint32_t, value, 128)
>>>> +                            __field(int, len)
>>>> +                            ),
>>>> +           TP_fast_assign(
>>>> +                          memcpy(__entry->address, address, 128);
>>>> +                          memcpy(__entry->value,  value, 128);
>>>> +                          __entry->len = length;
>>>> +                          ),
>>>> +           TP_printk("amdgpu register dump offset: %s value: %s ",
>>>> +                     __print_array(__entry->address, __entry->len, 
>>>> 8),
>>>> +                     __print_array(__entry->value, __entry->len, 8)
>>>> +                    )
>>>> +);
>>>> +
>>>>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>>>>   #endif
>>>>
>>>> -- 
>>>> 2.25.1
>>>>
>>

