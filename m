Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4387C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 15:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E69810E06D;
	Fri, 17 Jun 2022 15:11:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A17510E06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 15:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mo1/K07uA3vGm1cc4+gSLe2Usy0S4+lZhHCAMz3JdglsurEmrKfEfIMHPrHJnyZ/FdMq7CI/Yzhy74xJ+WrMTTCYwkpDkJWRB32+ByKQRaTz2gGcFSL1vzNbR6sPm/xRfXUqrJ76suVwGP31B6Vpczsz5Q7lDZ9Fqz7GFvsBDxZTQcSW+fElqzIcrJV1wZ52XsES29DXQM9FwoErvrI/j54HCk65IQAbAH5zbltBUHEm4dbjqNkhI0jOZUTwgwqjivOyHCWfv7Ry8CN5cN8Zx61YOPDSjUwIoGGbrt6LLVHWvKG7oMEyEmWHaS5ttui+pTDyjpxV332cb3pwdWO8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK5T9IW7nw2a4628gVPgzpzbapQSp3xEG1qCdPtVZ8E=;
 b=g4hUOkVQ98vvfrLJW6qw5wSGH1fdxh9bu/Uzon92Shs6cLxKhQlCJzC2huPneSkwavfDSKqN+F1uNuZFuEiz6X4HrRjGfKS3File8ts/8ESFt4OIZvcSElu+kQPxCoxAtgsddJzdZbxz4NT+3N5gznmS3c9nqPKL5nC3SFRhDKIV/5WrPC0ps9WPvGJRODlHkKyqYYAHq2mlD2i/qnVGyMGtj5r2cU2HQQwnMnbint/xNDD+UZXq65ji5SEoHzsDTwHyK/Pesm7K5EsNtVsZMVsctEGszCYY+ju4cyH2oBZ2DUN6EjSb0PXqfCnwQFVSOv6IOdbkh3WzFH2znJ5U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jK5T9IW7nw2a4628gVPgzpzbapQSp3xEG1qCdPtVZ8E=;
 b=4YLZiRsSBchlvZ6+lrzljJVGrlJ9cyPMALVu1BM1qXDkIRi4T6ryI5SZ3JyhTxhEzQiknUwmm2WAJoieFZaYQq8Lz0By5CBLQ66qba97fe5JvEj9GABK9Ihr7Vk/XyopowN6s9LlchZ0993zEmsMFkKmm1kijWvQNTuJhYmdAuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BN6PR12MB1747.namprd12.prod.outlook.com (2603:10b6:404:106::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Fri, 17 Jun
 2022 15:11:50 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5353.018; Fri, 17 Jun 2022
 15:11:50 +0000
Message-ID: <a8b05069-450d-f6c3-a3b5-e769478f12b2@amd.com>
Date: Fri, 17 Jun 2022 11:11:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/3] Documentation/gpu: Add an explanation about the DCN
 pipeline
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-3-Rodrigo.Siqueira@amd.com>
 <20220615141204.62ba64e1.pekka.paalanen@collabora.com>
 <d48aa87e-b5fa-0437-d637-d7306b115311@amd.com>
 <20220617103517.68b9503b.pekka.paalanen@collabora.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220617103517.68b9503b.pekka.paalanen@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0006.namprd18.prod.outlook.com
 (2603:10b6:610:4f::16) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ee7e45-72d9-4c19-36c8-08da5073b416
X-MS-TrafficTypeDiagnostic: BN6PR12MB1747:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB17474D9EDA3D6BA4AE99E6038CAF9@BN6PR12MB1747.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+4NE0HvZkgcFVLmbUlnQ+NR3mlH9X4VSa9GRdzspRujwa+V1dIcf873UDuBgOB16tKogD8nCxcdcylq69dXQ7KJiWIcWnWyS/bjrw9dNRDw/O1rdWLTCNVfF8ZI8TVzEsn0bK9PKjyutVwIY61lh6H/WxmD9kWxixBXWGm7/DOPln+12vQ0Qai45kI344xxfi6lbZnzbOwY0eurftDHIOEYpxNS3NkLbibbwJ13w0nfd8gFABKnQJw1x6YMF0sUXz3lFTtyUOW1Bj2bSllG52Ek88heaQ+7pq7mIOIBxe81/78pNttfZ0CbbLdjqeA8Zw/KG+AHfy00A2ttXxulIvJ29q0gQfvPj8oFBRGIzZOiAMi0io2x52xfm55CGt7YGnPfIgsDFjKhluRbGVC8lDDq6hTyYhD4YeqhqvlIh27TsgTHoLEbfJVP6kEKl2n4yVTzcdIFQ78548FWcsndtZHFBSrSTLd3Dyz/q9J7Ls6sa2VUpb4mNAsKqlQCGZ4K5snkERfikRgxAY15zbhY6WN2EOa5J2WP0kypdA0D7MJE349i/ddyRB4l77Ro52zLj1j7HV4CZBbXOE2Fo6cfMCkia8Bltp5s20GJNoDuVzboEv3DXcSYIAEVyfj6Pkqvl+Uu049KtnvI3M6uL0jICeFsCbPCBpS1HwlSWNPIdCieGirLHc4f4k5VOVMJk7KlaWfaIpnj6mmwdJlJyCYHnjWLLtGq2ar1Pv6lJWBaJ0OQRnYaGkzLe1UIliSTA2qVXRGQu6YqL7tvTmhfdeHTY06QOcbFl9gu7X/bSKDDL49441cu7MRW3RRZxM+aPdnQ0d64kgvIPD7MTv5va6HqIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(38100700002)(36756003)(31686004)(498600001)(66556008)(5660300002)(83380400001)(6506007)(53546011)(66574015)(2616005)(6512007)(186003)(26005)(7416002)(31696002)(66946007)(54906003)(6486002)(2906002)(8676002)(6636002)(110136005)(45080400002)(6666004)(966005)(8936002)(4326008)(316002)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S04vMlFYVk41SnJBVXh5WXVFUlgrLzkxVjQyWFdZaDg4bW5Hd2U0RU1BQzJK?=
 =?utf-8?B?UFFVTVZmQzFGRDgvR0U5aStYZ2s3b1liN2NSdTBuMUY5UTNHV2MrTGVoRGI2?=
 =?utf-8?B?Tng5dlJmc3R2VmtRemdDNUdSMlNScE5wMUJkbXRNODFwODdkd0VQS3Y2NGcr?=
 =?utf-8?B?MDZPKzFOc2RjdWczcnRLcTJKczVoNjhzYnlLcVpXMmU2T3pGS1pPanQ3dDdz?=
 =?utf-8?B?NG9RNklrcFAvQzduQ0RVMlA4S3cvSWFmMWFrVFZWNmFPS1ZIMEtCa09xdEw5?=
 =?utf-8?B?T3pnU2VGOXRoZ2o3ZktIa3VsRDdGa0gxMWJWYlBHSWhBTFVFSDA5dE5ncVFB?=
 =?utf-8?B?ZkptSFhzdlAyRllxR1lHUGk1SWlJd0R4cEpCU0tsSDhDSGZBS1FPVG9aQklR?=
 =?utf-8?B?OFQ3QjVaRWpQMHRvQThoU3ZmUGpWVHpQby8xYmJ2cG1UWWNqdnJoTWxtdDNv?=
 =?utf-8?B?MFBOVW95RjRDK21CUHkrK2ZidzE5ejBiZ1lycHFwVlUxdi9QL3F5WER6MkRU?=
 =?utf-8?B?bXRaUUx6Nys2UWdmY3lDRHdJZ2JhY1BKTjBCTkJ0VnArMnQvdUU4aUhvVnFo?=
 =?utf-8?B?ajlqWlp1R3phb1ZxT0tqZTlnY1ZDYjBCdGpPQzIrU0ZCTko4WlpZT2J6dnN3?=
 =?utf-8?B?MklrakNPYm5EMnpCcTVNTmZrREpzSVBnVWtEMWZ6U2pGaHRiN0R4VHB4VmZt?=
 =?utf-8?B?WGEvWGoyQjFnTmR1RnFJSytKeUpxWHVWRW1PRWJ5ZTU4Um01R2hZd2doMXF0?=
 =?utf-8?B?eWloTTY3KzNCeFBuM0ErMlJmcVgwYW9aNk1kV2FZRUZwNXdTNk1lMXFtSG51?=
 =?utf-8?B?eVZRZHl4S3o3MkFpY2ZkaTUyckhoRTZlcDZPeVExaCtsdXdqK1VZb3NNcU1z?=
 =?utf-8?B?U3VUcXZ6cDRHa21rUnFUUkJzWG96aDFzcDhwamhZV0dHUUhtTHlQMkp2L1ps?=
 =?utf-8?B?b054dEJCUXJUZjArTmNpcWNGNUk0TUJicG1DcHhjVzQvUGhUNjlQTFpheThJ?=
 =?utf-8?B?ZFlXeDI4TTdYQ3hyN0F0bWdYcnR5N2dQem9pVmpUMFJUUkRCakNrQXkxZVJh?=
 =?utf-8?B?bjVCRGVMRGs3UXI2eFhwcUNPYmYwczRrbElvZUNmMzI5MGcwY3RHZnBVRGJh?=
 =?utf-8?B?VWNrUEVkQVBGM0xCTU9GOXh5TUZYVnpCMERId0pSMVpqbjRRaUZMdXhqUjZX?=
 =?utf-8?B?N0ZESk1CNDlzdm9RZXNoWVhnV0p2WVdJdkM4cjVRcFV0RTlRWkdGYjZ3YW5v?=
 =?utf-8?B?amFkUTNLamFuSWlFY0FMNlFsdjBReThaWURqb2FsN042MTVaTkhxOEl0eVJB?=
 =?utf-8?B?VlE1TjcvM2hzMTVPVFZJcU50OFBsUmp6Skk1T1ljczl1UTczaWJZbGlwaklp?=
 =?utf-8?B?cW0xKzNURFQ2Tk82ZUVxUUZiQjFHV2wvaHJTQXBPWnBVRUV5KytBKzN5WkJL?=
 =?utf-8?B?RjNkeGIvcmR1d0NGZzB4bDZ0Z01jSlhJc0xsQ2E3ZHlyblFpN3hIRFI1SkV0?=
 =?utf-8?B?ZFQxNkl1K0VpR0hQcHdFN3hKZjRjakpDSWtlaGorUmJBajAzeDNVSERlck1S?=
 =?utf-8?B?eW1mTmRsSzRGaUtIL01uOGZteU8vMUpWNjhqUkxycFhZK1JvVE5UcUJaSmV3?=
 =?utf-8?B?cjFLcXljeGQ3ait0R1ZVZmMxTzJwSTIxZHNIekl2bStiL3JkYjNuNUZhdVg1?=
 =?utf-8?B?eDN6TndLWHlwWmhVZDFPcVd0VXRheEpJcDczVFZWNTlqMmprajNDVGx2NXRE?=
 =?utf-8?B?R1ZYTFlvTGx2ZHhMdGpZL1ZlRXhRcVlqUUtzdkh6VXJGbGtPKzJkdUJQNWl3?=
 =?utf-8?B?Z2hTdHgrUEJZQmpyTFRWTE1XRThCQThIQlRPNFcwa2V4d1Y1WDlMUi9pVVU0?=
 =?utf-8?B?YkpMNTZSeVZaRVA1OGtoajd4RWRVZWxjMmFhbHBNTytqTXJMcjI0eU5RNUV5?=
 =?utf-8?B?ZkxIT0hnNXVDem1EMXVHZEFpRjcySDFVdTAyWXMyZXl6S2Rvd3Z3aDZNeDlo?=
 =?utf-8?B?OUxrT2J3bU1KSi84U3V3NHZLaFo5RGdXVDhLb0RIMG1TYjc0OXR6bFh3elFU?=
 =?utf-8?B?NWVCbG9vMmRlY25TeW5uNFMzb3MwY1gvTEVqNXZFUnR0dDZkRjRaenVHcWJV?=
 =?utf-8?B?WHppMUphbTdtSGVWT1l3Q01FTkUwaXdlR0crRVRUMHo5Ymw0UWdDMTMvSmRU?=
 =?utf-8?B?a2JWSVhPcHgyODFQdXdUcktVSU1oNzliKzQ3NitXMFRJaE1TNllkZHJlZ1Za?=
 =?utf-8?B?TDZsMHMzL1d1K1MySEI2YnFwcnJDSVhFZkhkUkQ0NkpiT3A2K2hMRTlKK0lp?=
 =?utf-8?B?MVlRMEJ3dUorT3JjSWNQTzNBTVlmejUzQnR3OXZ6M05RVlNDVGRadz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ee7e45-72d9-4c19-36c8-08da5073b416
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 15:11:50.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 406VDmXw2z6zxCXHCfsErTwhj29vyT0uSTMAlciUwu80bRnp9c9cm7SFpDiX5J8UNW1UPZj9pBuHTEo/ZRdMkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Simon Ser <contact@emersion.fr>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, maira.canal@usp.br,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 tales.aparecida@gmail.com, Sean Paul <seanpaul@chromium.org>,
 isabbasso@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/17/22 03:35, Pekka Paalanen wrote:
> On Thu, 16 Jun 2022 17:59:21 -0400
> Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com> wrote:
> 
>> On 2022-06-15 07:12, Pekka Paalanen wrote:
>>> On Mon, 13 Jun 2022 16:01:11 -0400
>>> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
>>>   
>>>> In the DCN code, we constantly talk about hardware pipeline, pipeline,
>>>> or even just pipes, which is a concept that is not obvious to everyone.
>>>> For this reason, this commit expands the DCN overview explanation by
>>>> adding a new section that describes what a pipeline is from the DCN
>>>> perspective.
>>>>
>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>>>> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>>>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>>>> Cc: Alex Hung <alex.hung@amd.com>
>>>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>>> Cc: Leo Li <sunpeng.li@amd.com>
>>>> Cc: Simon Ser <contact@emersion.fr>
>>>> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
>>>> Cc: Sean Paul <seanpaul@chromium.org>
>>>> Cc: Mark Yacoub <markyacoub@chromium.org>
>>>> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
>>>> Cc: Michel Dänzer <michel.daenzer@mailbox.org>
>>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>>> ---
>>>>   .../gpu/amdgpu/display/dcn-overview.rst       |   58 +
>>>>   .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
>>>>   .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
>>>>   3 files changed, 2078 insertions(+)
>>>>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
>>>>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
>>>>
>>>> diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Documentation/gpu/amdgpu/display/dcn-overview.rst
>>>> index f98624d7828e..430e363fccae 100644
>>>> --- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
>>>> +++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
>>>> @@ -124,6 +124,64 @@ depth format), bit-depth reduction/dithering would kick in. In OPP, we would
>>>>   also apply a regamma function to introduce the gamma removed earlier back.
>>>>   Eventually, we output data in integer format at DIO.
>>>>     
>>>
>>> Hi,
>>>
>>> always nice to see more docs!  
>>
>> Hi Pekka,
>>
>> First of all, thanks for your review.
>>
>>>   
>>>> +AMD Hardware Pipeline
>>>> +---------------------
>>>> +
>>>> +When discussing graphics on Linux, the **pipeline** term is often overloaded
>>>> +with multiple meanings, and DCN adds another context to this word. In the DCN
>>>> +driver, we use the term **hardware pipeline** or  **pipeline** or just **pipe**
>>>> +to indicate how many DCN blocks we are instantiating to address some specific  
>>>
>>> This seems to say that a "pipeline" is a number, a count (how many).
>>>   
>>>> +configuration. DCN composes those pipelines together when the data reach the  
>>>
>>> This seems to imply that each "DCN block" is "a pipeline".
>>>
>>> Is either true? Is a pipeline not a sequence of selected DCN blocks
>>> instead?  
>>


I think the confusion stems from unfortunate phrasing.

Siqueira, you seem to be saying that a **pipeline** is indicating
how many DCN blocks we're instantiating. This is incorrect and
confusing. We have a number of pipelines for each SoC, e.g. 4 for
many APUs and 6 for many dGPUs.

A pipeline is a sequence of HW blocks:
HUBP > DPP > MPC > OPP > etc.

DC treats those as individual resources, so we build a pipeline
conceptually by taking resources for all individual HW blocks
to compose one pipeline but in actuality (in HW) these blocks are
not arbitrarily configurable. What we can do is combine pipes at
the MPC as such

HUBP > DPP > MPC > OPP > output
HUBP > DPP > MPC ^

In addition the DSC block can be assigned to pipelines as needed.

So, in short we have a number of pipelines per SoC. If we have 4 pipes
we have 4 HUBPs, 4 DPPs, 4 MPCc, etc. There are few exceptions to that,
like the DSC block.

On the output side we have a number of different encoders that are attached
to our output connectors. Each pipe is routed to the appropriate encoder
for the display output.

Harry

>> In the DCN we can have different pipeline configurations. For example, 
>> see the below picture:
>>
>>  
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Flatest%2Fgpu%2Famdgpu%2Fdisplay%2Fdcn-overview.html&amp;data=05%7C01%7Charry.wentland%40amd.com%7C5c60cfb7c2e5483e1b0d08da5033f013%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910481695853125%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=TX6JmSkn2ybJSqtOz7DRl4q745qzsCLYSkQ0RvAXsrk%3D&amp;reserved=0
>>
>> Let's say that our pipeline policy does not allow pipe split, in that 
>> case we will have just one instance of each component. However, if we 
>> decided to split our pipe, we will have more instance of the other 
>> components (e.g., 2 DPP). I added some examples about it a little bit 
>> below in this patch.
>>
>> Try to apply my series in your local kernel [1]. That way you will be 
>> able to open the svg files at Documentation/gpu/amdgpu/display/.
> 
> Sorry, that's too much to ask for patch review on a project I don't
> work on.
> 
>> Maybe I can rephrase it, do you have some suggestions?
> 
> I'm not sure what your definition of a pipeline is. If you have split
> blocks, does that mean you have one pipeline or multiple pipelines?
> Does block splitting allow to create multiple pipelines in the sense
> that they do not all contain the exact same blocks?
> 
> The only thing I could suggest is to not say that a pipeline is a
> count. That would be done by replacing "to indicate how many DCN
> blocks" by "to indicate which DCN blocks".
> 
> 
> Thanks,
> pq
> 
>> 1. https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fseries%2F105071%2F&amp;data=05%7C01%7Charry.wentland%40amd.com%7C5c60cfb7c2e5483e1b0d08da5033f013%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637910481695853125%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=MYx6R8tIvFu6f46Rj7GWH4MIfa7bjYjdYitFnc6wNZs%3D&amp;reserved=0
>>
>> Thanks
>> Siqueira
>>
>>>> +end of the OPTC block before sending it to the display. We have this pipeline
>>>> +concept for trying to save energy and optimize bandwidth utilization while
>>>> +providing the maximum performance per watt. It is easier to discuss it if we
>>>> +dive into this topic by taking the example of a 4k display in the below
>>>> +example:
>>>> +
>>>> +.. kernel-figure:: pipeline_4k_no_split.svg  
>>>
>>> A bit too hard for me to look at SVGs from email patches, sorry.
>>>
>>> You wouldn't happen to have a git branch available in Gitlab or Github
>>> or even cgit somewhere I could visit with my browser?
>>>
>>>
>>> Thanks,
>>> pq
