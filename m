Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1A1C54EBC
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 11:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49AD010E16E;
	Thu, 12 Jan 2023 11:46:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2CBD10E03E
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 11:46:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BinnBAUE02uo4pqe65MgbHuujxNgCETs5uNxM6vUTdLbA3gfBh/b3nN+wg8jrXuMIeGBTfXub5GLXWFAedp//TFYh6SRaZaoWJAjIRoFItGxXkRddX5pUYuov1yj+pBpjJnyHGtyaRsLosYqjsPTh98tIgdW2YcjVY+eZJO3sU0snoR8E/C3PJ2o9Hi7ag0qC4Bf1Y1jz78r8BzFj5n5RvLHDDP2P4tEAteLPQh+fWesYkJb4np7bfm6H7pKEKDe/5WSeE4JFazOmYWUxhrUjkJl/tnf9sKWt5JrBdDZr5G1t5dTm2gpdQFeqqLpkr7YvcevvDU/+TeodubBavW8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2alhDB2+jh43J7NP/VbtcjGdq8huKRg+5b18EbYHi58=;
 b=LT4okBYeMU89GLZiLtEnJK3kPlVoBI7l9/li9Gwo6WK/r1JpU59rKwKdDZRST1yfkQkfPF1tj2rODGIPWTtm2/qq5PknFq7T+maSEv2onKFEhcg4G+9smN37Ap5olHe/ULi3Xp57XLLDtueJiFluevQqDaQlZE1IYFNTno+qQF5IKbeqDafwEGvuk29V6bxsvwT6CKE0R724pNytKhBh5EvR1AeDtdEuC0D1Q/Nlhb1t9mAAcOZtSN4PzqD8msnzkIKdG1+qDiXumxvh2TPZc0tWrwL4N8L1Rf63lwAXq8AWHe14cVC60Wobg69R9z+6lT85hIQMJtjjfJx078ENgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2alhDB2+jh43J7NP/VbtcjGdq8huKRg+5b18EbYHi58=;
 b=nhz/YFD6chK23jmkzb75eIX2Bj/IKgFCSlHI8MSL4dWpqzzxfjJCERHYdvpJCxRnUxKPRUhHkFfn030emMxI2SnjodMka2Eo48IUqnuRNId60Dl6VOa5++PAKoQlWH7OsAgpwQZu0h2cp6QURwMhgyJmT9fR1I3BYi4E+AOR8ek=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 11:46:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 11:46:54 +0000
Message-ID: <d30389e9-2a2a-c3c8-3c3b-a8b43ccd3318@amd.com>
Date: Thu, 12 Jan 2023 12:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <maraeo@gmail.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <0931a762-c3a3-16c3-33a5-88e83fca4bcb@gmail.com>
 <CAAxE2A5pBqOkny15tSRCWn_UW8=TTE=zYPChBZofZCrHZoQbww@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
 <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
 <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
 <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
 <CADnq5_PPJanTuyNgL8eyxj-+HvPiPXN3e3hR3AHHivj0omcsXg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PPJanTuyNgL8eyxj-+HvPiPXN3e3hR3AHHivj0omcsXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: b99f51c3-22d9-4759-db53-08daf492b341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tXSKbqE3978ntA1Ip5DcsQz8pOcw20T6bYGuYLSy7631KBkWf8Ez/AnRSAPQ+VvavJf9Hxx5hEtkA9WLj1MxVshbu2/NwNncVzgvl3c0yvwD4+0FC/VRlfpquri1t3gWs+Brry4lQ9EiV4eL19n9w6rLZZngTHcfhWMdH0UvbOAwGhbm9k25P3nJ5kRJUdT7DWTgPtlRAg1lO2ck6yVUCbVoSl+DlZ3FnlAMX7mpUqMGhSNzi86URmALIRArG+VwhqSl2pwCRPPOpeDiit553HR7+jXmqdHQTKuaHdCk5YAJ2tO886c84poILpQbUFkvxHK1v7HDwIXr8AH+OOU2s8Tf20AT/DTLKfo6s//NR8PTjWrF0HB1rzqAnEly3w2vD89ILQDv/CiJIFHj4Ww8CKNEqu1E3RNRmWn2q2Oaoytk6LoWTz6YnMpVxjMKqKlu5D9Xb1kQyEqrKXfH9gzxcXOi0NKqN4cgF/6oLYswJScY9YPzRcbiU2PUP8zRT+IEQVtkDMde/5qARpZw9QCopJ58UEbcKYq9Xj6fEEM6r74nxETig8+RBI13znE/W2NlYkMYj5hR1OrP6c1O0ODXo/wMbn3K9rnx/sz2n3Ml6Pr2UI18w0k/N5UXbsAYt7rMaE0p+VS58RLFsC2KtykwmmQOU87S7HM6SGMm37hS3txGA8rLnRjus1r8pjmla7vQNP08w+0ettoxzNEEy3gcqg8Z8Dx/DtSH3fHha9PvYMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199015)(5660300002)(54906003)(6666004)(2616005)(6506007)(36756003)(2906002)(53546011)(31696002)(38100700002)(83380400001)(86362001)(6486002)(316002)(6512007)(110136005)(186003)(478600001)(26005)(31686004)(8936002)(66946007)(4326008)(8676002)(66476007)(41300700001)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VndzRTZ4NFp6anBRemNBOGdCK25HU1NMaEVYbGhaeWxVSFhKUTk1UUMrd0JG?=
 =?utf-8?B?UjM3bkt6V0tkRmNVSjlhQlBmbDh0V3lnWlFDOFdrQUFIdlFJa0hzbXBqT2RX?=
 =?utf-8?B?Z1RxRXZlU2xxWFhlc3N6cUg3OGdSTVVhelhOTk9hSUVONjFnZDNuSEYwRnFv?=
 =?utf-8?B?QmtqWlBSdzdJNmdiQjl3c2ZBL2J4K1BBL3J0VWVZRzJtNnJqbHpLMU5qeHhY?=
 =?utf-8?B?VGVoaW9IMSt0N2haMUdBNnR4Wk9qdlBwMlVENWpEOFVQcDdVSUsxWGpqcll5?=
 =?utf-8?B?dTZRQ2dlNksvTTg2QVhhdFF4UkhURXllZnQ1UENNSXFybUtyYllWTnQzcDBI?=
 =?utf-8?B?UkJMZVp5d3pyclU1aE9NSXl5MkJWWjRsWnBhQy9WeDNzVVpuZmRVZFFpZFZp?=
 =?utf-8?B?QnpuMWhqK1lwZ3ZzZzNhajV3cmJWZVczS0taQVR2ZlZQTVFzalFqZ0d0QmpO?=
 =?utf-8?B?TXNrU01rcXBTREhkUXdNejlBS0hpMG1VZzg4dTNNcTEweFYwRUI3VjA2d3J0?=
 =?utf-8?B?YnpaMG92M2kvR0JmamlLNm4yZjJ6dlVXd1YxdDBDM05BMGlKanlGVzFnU3B3?=
 =?utf-8?B?djcxNC80dUc2UHdoNmdaWXpYaDBoYlRvUDVVTENLRElZNDdhU1dqdnZhWFRT?=
 =?utf-8?B?eUQ1Ymd5N2pPb3JWZUdWMFRPZDgyTnl5VFpCbjBVYWtzYWxGWklOSGgvT0dG?=
 =?utf-8?B?N3BQMFNyOWhNejRLeFV4OTRiWUpoN2pmVFh0bUd6V29ZTWtNODQ5Mi8zUTdO?=
 =?utf-8?B?SHZaZFBaVFFBMUY3VldjakRZTEw3NFhsQ2dGdlBsMkxnN1Rtb3JQOHJVMjUx?=
 =?utf-8?B?YjJwQTRjVEM1cTFwT1YxdHN5c1VsZC9ubFBVRjQ1enlIU0NVUitoY2ZKZEJl?=
 =?utf-8?B?UUVWMG5ReWhwcEd5OXBEWWNiSWo0YU44VkxMRlpENTV3enJqaDdveHVCRkhD?=
 =?utf-8?B?MHFLWVJ3T2E2cEFCOVFUbHdlaitYOHBVK2JsdDlkQVBGMnRTVUdnNG02RWgx?=
 =?utf-8?B?aVNTdDFMUnljdnBiZ0pESU5icVU4NzZwcHNIbFJrUklWQmhBMjZFMXJadzRE?=
 =?utf-8?B?WEo0SjRza2JYNjhrZW11UHZGUjNuZmhvWmZwdHRETnA4OTd5eUdkRnFFemVR?=
 =?utf-8?B?RTFUclBLZlZpVkdoVHY2TTBnMVRxQ0E2MG9Ba1oxYzk4Wmc4bFNCaDF3YUtJ?=
 =?utf-8?B?Sy9FVTBOWGhNNUZ0OFNJSTBqTitsQnR6NjhnU083N0Fwa1d6cmtGMkhRMmF2?=
 =?utf-8?B?ODJoVEN3elpNTTJobndueHd0SzNzS2JCKzZGQitYQWdpSUJwL3Z3cUU0cWVk?=
 =?utf-8?B?Wm9mVUtkYzFWRWpER1c2RnVsR2liRXVmWE1YdzEwc1RPV1k1TlRIWkcrc2xJ?=
 =?utf-8?B?NEcvODhZK1B4WTZ4UjFvL0pFUFNXR2NxSmcyYTdWamkzM0JXQ3ovT3VZNEJP?=
 =?utf-8?B?a0pCakxGejBkS2doWnMzQWs2cTBpVmlvY2hKK0JKZG5WS0lwYVBuUU9DZVdn?=
 =?utf-8?B?M1VNT0N5akZnYkVKSEFwRm1aWnh2a1MxTEVZbG5IVnFQbHFYKzZET2tvaTMr?=
 =?utf-8?B?SzJNQUZrQUxjd3U3QVpMQXFKMlNWd1I4a1FFamhzK3NiSGpuSFo5ZjlxVHM3?=
 =?utf-8?B?NVhVSUJ6QnJ5c2VoY0l5d2g5UVlURmFuU1oxbHNjbmNlTGcxdzFCS0VDOG9m?=
 =?utf-8?B?NG9YNUd2aFpWTHQ2bUJaTnhocDlhbUhJb3J4bWxoR3A4UmMyN2ZPZVhlNm1j?=
 =?utf-8?B?QmZzdUhWT0krOXZpbmRJRmRjY3p0QndCSHN5UDJJTmk4N0w2QXlRZWtPZ25M?=
 =?utf-8?B?MVFGUGdKeFovL1oxWXA0Q3FUUU5pd2E0ckRjYmR5NjBCMGM3THA0UEE5SG9J?=
 =?utf-8?B?cWFxZGtocUdwRTdyVkt3V05pK3BPZUFUajl0RzU3Mm5YMEM2dmdFZC8yZGNx?=
 =?utf-8?B?eWZicmx3Tk0rYVYwY3Q4SGx1N2M0YTkyd2ordnRTbGwyQWd4b1JDMU16U1lr?=
 =?utf-8?B?MDYzbUpNbmNTVitXNkVPbms2bGVDQTF4SlFBbDRLWkUyNkJqQ1lwWExYeXJ0?=
 =?utf-8?B?KysweTRIOU43VVpXOE9HR0crSlBPc2F6d0ZCUXg1Z0lObEppY0ZzaHZlQmlL?=
 =?utf-8?Q?b22JxnAY93ZruVCzL43agfjuy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99f51c3-22d9-4759-db53-08daf492b341
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 11:46:54.0092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLJbtd17sW66EE2aDGUbL036/tE+OoEsCm7IFAkmmW25ScJu7zOVzXoH+HUJcAzg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.23 um 21:50 schrieb Alex Deucher:
> On Wed, Jan 11, 2023 at 3:48 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Wed, Jan 4, 2023 at 3:17 PM Marek Olšák <maraeo@gmail.com> wrote:
>>> Yes, it's meant to be like a spec sheet. We are not interested in the current bandwidth utilization.
>> After chatting with Marek on IRC and thinking about this more, I think
>> this patch is fine.  It's not really meant for bandwidth per se, but
>> rather as a limit to determine what the driver should do in certain
>> cases (i.e., when does it make sense to copy to vram vs not).  It's
>> not straightforward for userspace to parse the full topology to
>> determine what links may be slow.  I guess one potential pitfall would
>> be that if you pass the device into a VM, the driver may report the
>> wrong values.  Generally in a VM the VM doesn't get the full view up
>> to the root port.  I don't know if the hypervisors report properly for
>> pcie_bandwidth_available() in a VM or if it just shows the info about
>> the endpoint in the VM.
>>
>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Actually:
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index fe7f871e3080..f7fc7325f17f 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1053,7 +1053,7 @@ struct drm_amdgpu_info_device {
>       __u32 enabled_rb_pipes_mask;
>       __u32 num_rb_pipes;
>       __u32 num_hw_gfx_contexts;
> -    __u32 _pad;
> +    __u32 pcie_gen;
>       __u64 ids_flags;
>       /** Starting virtual address for UMDs. */
>       __u64 virtual_address_offset;
> @@ -1109,6 +1109,7 @@ struct drm_amdgpu_info_device {
>       __u64 high_va_max;
>       /* gfx10 pa_sc_tile_steering_override */
>       __u32 pa_sc_tile_steering_override;
> +    __u32 pcie_num_lanes;
>       /* disabled TCCs */
>       __u64 tcc_disabled_mask;
>       __u64 min_engine_clock;
>
> Doesn't that last one need to be added to the end of the structure?

I think the the structure has a padding here because the next member is 
u64 again.

But probably better to double check using pahole.

Christian.

>
> Alex
>
>> Alex
>>
>>> Marek
>>>
>>> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>> To clarify, with DPM in place, the current bandwidth will be changing based on the load.
>>>>
>>>> If apps/umd already has a way to know the current bandwidth utilisation, then possible maximum also could be part of the same API. Otherwise, this only looks like duplicate information. We have the same information in sysfs DPM nodes.
>>>>
>>>> BTW, I don't know to what extent app/umd really makes use of this. Take that memory frequency as an example (I'm reading it as 16GHz). It only looks like a spec sheet.
>>>>
>>>> Thanks,
>>>> Lijo
>>>> ________________________________
>>>> From: Marek Olšák <maraeo@gmail.com>
>>>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the INFO
>>>>
>>>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 1/4/2023 7:43 PM, Marek Olšák wrote:
>>>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo <lijo.lazar@amd.com
>>>>> <mailto:lijo.lazar@amd.com>> wrote:
>>>>>
>>>>>
>>>>>
>>>>>      On 1/4/2023 4:11 AM, Marek Olšák wrote:
>>>>>       > I see. Well, those sysfs files are not usable, and I don't think it
>>>>>       > would be important even if they were usable, but for completeness:
>>>>>       >
>>>>>       > The ioctl returns:
>>>>>       >      pcie_gen = 1
>>>>>       >      pcie_num_lanes = 16
>>>>>       >
>>>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>>>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>>>>>       > It matches the expectation.
>>>>>       >
>>>>>       > Let's see the devices (there is only 1 GPU Navi21 in the system):
>>>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>>>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>>>>>      10 XL
>>>>>       > Upstream Port of PCI Express Switch (rev c3)
>>>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi
>>>>>      10 XL
>>>>>       > Downstream Port of PCI Express Switch
>>>>>       > 0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>>>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)
>>>>>       >
>>>>>       > Let's read sysfs:
>>>>>       >
>>>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>>>>>       > 16
>>>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>>>>>       > 16
>>>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>>>>>       > 16
>>>>>       > $ cat /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>>>>>       > 2.5 GT/s PCIe
>>>>>       > $ cat /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>>>>>       > 16.0 GT/s PCIe
>>>>>       > $ cat /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>>>>>       > 16.0 GT/s PCIe
>>>>>       >
>>>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>>>>>
>>>>>      US bridge = 2.5GT/s means operating at PCIe Gen 1 speed. Total
>>>>>      theoretical bandwidth is then derived based on encoding and total
>>>>>      number
>>>>>      of lanes.
>>>>>
>>>>>       > Problem 2: Userspace doesn't know the bus index of the bridges,
>>>>>      and it's
>>>>>       > not clear which bridge should be used.
>>>>>
>>>>>      In general, modern ones have this arch= US->DS->EP. US is the one
>>>>>      connected to physical link.
>>>>>
>>>>>       > Problem 3: The PCIe gen number is missing.
>>>>>
>>>>>      Current link speed is based on whether it's Gen1/2/3/4/5.
>>>>>
>>>>>      BTW, your patch makes use of capabilities flags which gives the maximum
>>>>>      supported speed/width by the device. It may not necessarily reflect the
>>>>>      current speed/width negotiated. I guess in NV, this info is already
>>>>>      obtained from PMFW and made available through metrics table.
>>>>>
>>>>>
>>>>> It computes the minimum of the device PCIe gen and the motherboard/slot
>>>>> PCIe gen to get the final value. These 2 lines do that. The low 16 bits
>>>>> of the mask contain the device PCIe gen mask. The high 16 bits of the
>>>>> mask contain the slot PCIe gen mask.
>>>>> + pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
>>>>> + dev_info->pcie_gen = fls(pcie_gen_mask);
>>>>>
>>>> With DPM in place on some ASICs, how much does this static info help for
>>>> upper level apps?
>>>>
>>>>
>>>> It helps UMDs make better decisions if they know the maximum achievable bandwidth. UMDs also compute the maximum memory bandwidth and compute performance (FLOPS). Right now it's printed by Mesa to give users detailed information about their GPU. For example:
>>>>
>>>> $ AMD_DEBUG=info glxgears
>>>> Device info:
>>>>      name = NAVI21
>>>>      marketing_name = AMD Radeon RX 6800
>>>>      num_se = 3
>>>>      num_rb = 12
>>>>      num_cu = 60
>>>>      max_gpu_freq = 2475 MHz
>>>>      max_gflops = 19008 GFLOPS
>>>>      l0_cache_size = 16 KB
>>>>      l1_cache_size = 128 KB
>>>>      l2_cache_size = 4096 KB
>>>>      l3_cache_size = 128 MB
>>>>      memory_channels = 16 (TCC blocks)
>>>>      memory_size = 16 GB (16384 MB)
>>>>      memory_freq = 16 GHz
>>>>      memory_bus_width = 256 bits
>>>>      memory_bandwidth = 512 GB/s
>>>>      pcie_gen = 1
>>>>      pcie_num_lanes = 16
>>>>      pcie_bandwidth = 4.0 GB/s
>>>>
>>>> Marek

