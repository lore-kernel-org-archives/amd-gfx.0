Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042A2F31E39
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 15:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9495110E824;
	Thu,  9 Apr 2026 15:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wb2FZuS6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65B210E824
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 15:32:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6HSQ7t+H16bQalo4uuIYuEK1ApKKaDS3xwyq8r4FsjR65wVLS1Am5v3Q9mvZHopXxmbLuamjErdN+RPPUyC8ZRIdAYnWhHwDWTTHhAu/Gk8Yad4w2AaM34QAub65MsJeTk5x+FHjU31f3Myw1LYKTxrk+Vzv4PnxF4KlDfnA8jbAT4zn5trbQL4uiu60iQQOdGpoCV+aUDHb8xHDuhnyCw07ETeJZ6XjkYNX5ZE7m+o0VhVyEJyxxB5fOgj/rR5lRzyvbye1mnLFj9+KjjaBWCqKVyAjRANzgcQphvNI/8g0MmJKMUOwPI/yUqOzstjDMKW+1PmP5Idt6mNxLlBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFwbigKDdYbHZOU0pD75B/6Y3uPXZNSEMtGv4+qAmD0=;
 b=jvuBi75TnUm+0v2pFNcm8RZy7gounpt0M+SXisnimK2XLHsvVNoyPJLuleu4WAddzaEoIBgzRdMDPQU/L7yIEz56HdYzyK69E1LVTek8goKFsKBHeF2FweXOO9r93XjrDtu5i7mVP+ncxmK6gd7HF/v/cURjG9r6dxrtIdCE6gdnCCkOb9A0jx3YfJJDxL0zBtubFlOyUXWCKmjiMjSqDnojAB6IYX4WgKlifzRJrdQRf/7FMJphZOGxM3DWRle1ph9cpISSZ1sgMtNK6oN/RA3XZuq9hBN0MalL+8gu1/46UH5Q9Lbt0tMzB3JnkD5U4JmP8HSetZkx+wwjnI9fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFwbigKDdYbHZOU0pD75B/6Y3uPXZNSEMtGv4+qAmD0=;
 b=Wb2FZuS6rexFjibCxT/pxyJ7ZDl3mLRFQCapMJVfUkCE0Fa+QmWfG82kaMt4qIKQuRlJ8d4iziy5F4uPsHjd6+qNeR3sKilFlUAS5NxTl5OR0E+YhJmVGjBG6UpdpyP9/gTEn+yzb/sUt8Tz3wbK8L7hBVpgtUoVj1LmVtg4Fpg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB7952.namprd12.prod.outlook.com (2603:10b6:806:316::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 15:32:42 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 15:32:42 +0000
Content-Type: multipart/alternative;
 boundary="------------dR9pyUqgisXW5n0jsQnmxvRT"
Message-ID: <22741ffc-c355-49c4-9baf-a4940dd9cbcc@amd.com>
Date: Thu, 9 Apr 2026 11:32:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: check if vm ready in svm map and unmap to gpu
To: "Zhang, Tiantian (Celine)" <Tiantian.Zhang@amd.com>,
 "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Liu, JennyJing (Jenny Jing)" <JennyJing.Liu@amd.com>
References: <20260326103656.487304-1-YuanShang.Mao@amd.com>
 <20e41c6f-811e-459e-aa33-2e864f04ab87@amd.com>
 <CO6PR12MB540914C9DBA3511BFD2B7513E050A@CO6PR12MB5409.namprd12.prod.outlook.com>
 <LV5PR12MB97772581D2D90604F36F00EE895AA@LV5PR12MB9777.namprd12.prod.outlook.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <LV5PR12MB97772581D2D90604F36F00EE895AA@LV5PR12MB9777.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB7952:EE_
X-MS-Office365-Filtering-Correlation-Id: 434bae1a-e7b2-47c9-2a1e-08de964d3d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SPy/EIOfLOh1sITnY49p7s7LUL5TEOL2WwSZlibFUv3uSpAcZAHWv+W7u2UMAIva9qsoqnoZFtJDwf4NA6dg46s4n/dzNAxejO5OQ2pmZUlVsmppVkFJUSJd7cBYO6mWGe1jp3HwO0ZeIWk9JCUDoiPNqLLHx2dvFjyukNcm8TWutKYXIV+vqZnwledz/oSg27MviRfTo++DI3PVfV36CPw5+15GFx9RXWeo6CC7gRtO/1WhLmvp8gOiaBczJwst/my8oSyYUwZ6VeREhLquws3feFXZpwbNTKa1CJK6VWnNVqguvKBDDHZ13m4DoyHt+jqSxsg/hZ+vEbduaD997FqHpxbI7/NiReAJaELNaa+JbX6IVG4L9w5BESLCw/AQdSW8LpbqQhbDaT87PTBkeMXoeeWoXdYUWPZLy8bcO9XllV7Q4Zc1FeMOXehwD0KWtAj59F8kJg/vhulZoxII84Q9MEpcqiS+1zk4ehDvhlUHm1fRFE/f3967x9vmF/UwfiqtvUA3jQlz/P/5+usKIcvN0YX4jYGww1D5ThPFN6RpjM4kZwpcQYu/75qHOa0xbVkowXK69187Mgjkw03YhFzFlIu3D5NQzKkttX+n0wu1079ksrZi22V5hzaJvfRSTQNftvxDKeVKQ4pIyKPf6ywk5cnrIWFBuqgdJkgJTZixzWpUizELYZj5q6dlIBMhxOtn9ac4+SOfVHunHJAMmJqJndRVP3sU+WWSAq6vDqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGFmVnBueHdWL09JaW42WFVxYVllNEI1NmhyaU9lRktBZ0lKSlNqeU82ODRP?=
 =?utf-8?B?M09ncWdPNTF5SVhMRUh0Q01YeXhETmQ0UC9VcW9qRzc5M2hqMGltSXcrM1hD?=
 =?utf-8?B?VXlCaXY3LzlEanZ6cGZ1UzhLQ011MGFrYTlrNFJFdnhmdENaQ1d5TFUwTWtI?=
 =?utf-8?B?aUl4NTJJQnpkbmpVRkFDTTFTOFBxem5IYWhOcnFzMldlWWJRdXF4ZmpiZWRs?=
 =?utf-8?B?cTlHellOMnJzNCt2cFpHNEM1OTEwMW9xWmxWeTB2eGIrZFUwYmJiOXhESzZj?=
 =?utf-8?B?dHlkbFJIVVp2VnRzSzFYb2VEZWxpNTJMcG5CNE1DNkRvMCtKOWhXN1BoQnEx?=
 =?utf-8?B?YU9BZldDM1FoTDBBdWkrcFMzanA0R1JlYmFtTDVESXJmNE5LeHpIZHdpQ25X?=
 =?utf-8?B?ZVNlS2V6dGprbWJreTFhMU13WmVaQnFoSlpmTENqcGpMN3FXMnJ0bERWcTZI?=
 =?utf-8?B?bG9CS1c1LzdFWXdLYUU0MFcwTEpEdXRPM0tTcFFkYWF2WmlnK005ZnJ5S21j?=
 =?utf-8?B?VnpuSWZ2UkRCRFYzSWJNdWY1TzZ2VWtqZFBjaGdEdVNYelMxMTVLV2ZFUmg5?=
 =?utf-8?B?c3ErL3VRQ1VmcnFwaEllV25VelBVOGVYZi9LcmJLZUt1cVNsdzlDQ1dqN3kz?=
 =?utf-8?B?a0kyQ2c1MFllMHphRlBWMThJQWpSQlFLVlQvcndxbjczNDRva01OSUN5V0kz?=
 =?utf-8?B?QXp5VzVqWkxEZUxOc3BBcWVHRXJJRFBOQXFMc3liT3VEN2x3NVA5S2d0Mk5N?=
 =?utf-8?B?SVlJd0tJNit6REczakQyQStQUGtzUi9zeFZ1aDByMmRycU43Mkg1TW9lK3hO?=
 =?utf-8?B?S1J6K0RsL09nUmVRUjZURi9xazhqejlJOTNMQjZJTlh3b1NFSHhiRWg0UmJW?=
 =?utf-8?B?OUxBT0VjVHFmM21ZVWJWeThGOXNxdGkyVzVOc0dOS1JrNnhtQmpLMHppVkJq?=
 =?utf-8?B?enNtOUs1LzBRcnhiLzhiWDErQXF6UGF0QVlkY3ZvOGFRZEJqZkZyOXdJVlVO?=
 =?utf-8?B?Qk5VemxRaVhDdGRGZExWcTdlRkkyTlY2MDgvRExyakFySDl4cDV2Z2R3ZWRR?=
 =?utf-8?B?b2t6TTEwcG1oRDE5V09OZTVsOGMvRGRjRGhWbnNCNlk2OWtHZ2RmR2FIaGtL?=
 =?utf-8?B?bG5JRy85Y2wwTE4zUHNudkljWi9uQytqOUJLaUxlSkJwVXVCZDdobTZMN3JD?=
 =?utf-8?B?MzBHSkduUE16ajA1YXpQTzBNSWV0bUlzcHJEbXNRVCtoNDlZSGFVV1VsSXVI?=
 =?utf-8?B?S1p5YnlQV0YyUG5SNkpSeUh6akYwWlFqQUxDTThlajh0R2lLVzZKakJBNVRp?=
 =?utf-8?B?empBSDJTdnUzLzhEbHdpcGxBekMzRHgxdzNSWlVMVlJRbVNDeEhPN0M2REdq?=
 =?utf-8?B?djRxak1uTUFmRHduNWRKaXBlVkhoUzFHM2FjbnVId3dZMEhuWlhnbStCRm8v?=
 =?utf-8?B?ckFWMEptSTlzcUZCSEpoQ0VCQVRvaWllaVhlczZqdlRCYU1KRC9Hei8rSVR2?=
 =?utf-8?B?RlpzcmZHOGs3QmJ5TjllQzNFRXlqdmdQc3JsbU5hWUZYL1NobFBYdGM3OWNs?=
 =?utf-8?B?VmE2NFNpVWR5cHlVNFpQUTM1T1pNcnJDT2VINHNhZ3R4NE5WcTk1RVVxSTFU?=
 =?utf-8?B?TktHdE9qSnR1dnJoWmg3YlFOZmxGR1RDV1F4STFIa1hvVTZRVk5raFIxTnhQ?=
 =?utf-8?B?Q2JMd09zbFc5b1l2VE0rcDlVejdZb2o0d1JsN2dMZnhabklYMEYvRXNFNXpW?=
 =?utf-8?B?VmtzR29jZ3NVclIrcVlsSGhkUE4ybXpncTlZbmNCN2MvalkwRnRrbmxVNHk0?=
 =?utf-8?B?SS91ZVFnREVKdytoUTFwdEtUa0tDZU1LRmNFb3FHNjJSRFVzSU5KcEpzN2lI?=
 =?utf-8?B?TVZ6ZkpnT1QyeFlwVzhvZml5MjRWZlkrM2F4ekl5M0J1V0tyNHdFWDdzTW52?=
 =?utf-8?B?U2ljaXhnNWl1dCtrNnI5RW9kOUFJY0R4ZHF0b04vNlcxNDNacEJjcUg1V1Bp?=
 =?utf-8?B?UzQ2bkwvZm4xN3ZiQTZScnozclBoc2lmT2lvaFVnM0xxeG1lTnlDNHhkNlFR?=
 =?utf-8?B?eTNQaUY4WjFRUGg0STN2OEN5VEVSa0J4azRtUEowbHlBK1V3YlRXemFCUG93?=
 =?utf-8?B?VlYxalpoZW9Ickh2T0VlWVhSbUR2NmZIQ2xCTWMyd3BNQlpFZGMzWlc2WlFO?=
 =?utf-8?B?VjA3TnZpQklSN0pSOE1OTDZITGtHNmhScVdxbXpnRUNlQjIrRU01TFl0S3Mz?=
 =?utf-8?B?Q0FpaGZ1U2dCZUFlL1U4SmFVMDZMQTNkOE9TMmZjajh3T21rVWd0b0RFZ1Fq?=
 =?utf-8?Q?z/oqVv3c/sBCnhjOKo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434bae1a-e7b2-47c9-2a1e-08de964d3d70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:32:42.2082 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQqZwLoapJK9eGgVBI3WLkFYbLIBiPNvwf7CVRVScaH9TaxwLg+IiDZixo7sRfaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7952
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

--------------dR9pyUqgisXW5n0jsQnmxvRT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-07 03:45, Zhang, Tiantian (Celine) wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> Hi @Yang, Philip <mailto:Philip.Yang@amd.com>,
>
> Could you please help to review this patch, thanks a lot~
>
> Best Regards,
>
> Celine Zhang
>
> -----Original Message-----
> From: YuanShang Mao (River) <YuanShang.Mao@amd.com>
> Sent: Wednesday, April 1, 2026 5:56 PM
> To: Yang, Philip <Philip.Yang@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; 
> amd-gfx@lists.freedesktop.org; Zhang, Tiantian (Celine) 
> <Tiantian.Zhang@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: check if vm ready in svm map and 
> unmap to gpu
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi @Yang, Philip
>
> Could help review this patch?
>
> Thanks
>
> River
>
> -----Original Message-----
>
> From: Koenig, Christian <Christian.Koenig@amd.com 
> <mailto:Christian.Koenig@amd.com>>
>
> Sent: Tuesday, March 31, 2026 7:32 PM
>
> To: YuanShang Mao (River) <YuanShang.Mao@amd.com 
> <mailto:YuanShang.Mao@amd.com>>; amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>; Yang, Philip 
> <Philip.Yang@amd.com <mailto:Philip.Yang@amd.com>>
>
> Subject: Re: [PATCH] drm/amdkfd: check if vm ready in svm map and 
> unmap to gpu
>
> On 3/26/26 11:36, YuanShang wrote:
>
> > Don't map or unmap svm range to gpu if vm is not ready for updates.
>
> >
>
> > Why: DRM entity may already be killed when the svm worker try to
>
> > update gpu vm.
>
> >
>
> > Signed-off-by: YuanShang <YuanShang.Mao@amd.com 
> <mailto:YuanShang.Mao@amd.com>>
>
> Looks correct to me, but I think somebody else already added those checks.
>
> @Philip is that correct? If not please help reviewing the patch.
>
> Thanks,
>
> Christian.
>
> > ---
>
> > drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++
>
> >  1 file changed, 11 insertions(+)
>
> >
>
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
> > b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
> > index 8167fe642341..7f905a7805fa 100644
>
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>
> > @@ -1366,6 +1366,12 @@ svm_range_unmap_from_gpu(struct amdgpu_device
>
> > *adev, struct amdgpu_vm *vm,
>
> >
>
> >       pr_debug("CPU[0x%llx 0x%llx] -> GPU[0x%llx 0x%llx]\n", start, 
> last,
>
> >               gpu_start, gpu_end);
>
> > +
>
> > +     if (!amdgpu_vm_ready(vm)) {
>
> > +             pr_debug("VM not ready, canceling unmap\n");
>
> > +             return -EINVAL;
>
> > +     }
>
> > +
>
The change looks fine, but it is unnecessary after checking the details 
of amdgpu_vm_ready.

It is impossible the "DRM entity may already be killed when the svm 
worker try to update gpu vm",
guessing the svm worker is p->svms.restore_work, svm_range_list_fini 
cancel the work or wait for
it to finish. kfd_process_wq_release does svm_range_list_fini first, 
then fput(pdd->drm_file) to reduce
the vm refcount, then calls amdgpu_vm_fini, to destroy drm sched entity.

If you see the real issue, please post the dmesg log to help understand.

Regards,
Philip


> >       return amdgpu_vm_update_range(adev, vm, false, true, true, 
> false, NULL, gpu_start,
>
> > gpu_end, init_pte_value, 0, 0, NULL, NULL,
>
> > fence); @@ -1443,6 +1449,11 @@
>
> > svm_range_map_to_gpu(struct kfd_process_device *pdd, struct 
> svm_range *prange,
>
> >       pr_debug("svms 0x%p [0x%lx 0x%lx] readonly %d\n", prange->svms,
>
> >                last_start, last_start + npages - 1, readonly);
>
> >
>
> > +     if (!amdgpu_vm_ready(vm)) {
>
> > +             pr_debug("VM not ready, canceling map\n");
>
> > +             return -EINVAL;
>
> > +     }
>
> > +
>
> >       for (i = offset; i < offset + npages; i++) {
>
> >               uint64_t gpu_start;
>
> >               uint64_t gpu_end;
>

--------------dR9pyUqgisXW5n0jsQnmxvRT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-07 03:45, Zhang, Tiantian
      (Celine) wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:LV5PR12MB97772581D2D90604F36F00EE895AA@LV5PR12MB9777.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered medium)">
      <style>@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}.MsoChpDefault
	{mso-style-type:export-only;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoPlainText">Hi <a id="OWAAM29C89DAFD5E14DD4AF1FCC5361A59632" href="mailto:Philip.Yang@amd.com" moz-do-not-send="true">
              <span style="font-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Yang,
                Philip</span></a>,<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Could you please help to review this
            patch, thanks a lot~<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Best
              Regards,</span><span style="font-family:SimSun"><o:p></o:p></span></p>
          <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Celine
              Zhang</span><o:p></o:p></p>
          <p class="MsoPlainText">-----Original Message-----<br>
            From: YuanShang Mao (River) <a class="moz-txt-link-rfc2396E" href="mailto:YuanShang.Mao@amd.com">&lt;YuanShang.Mao@amd.com&gt;</a> <br>
            Sent: Wednesday, April 1, 2026 5:56 PM<br>
            To: Yang, Philip <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a><br>
            Cc: Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Zhang, Tiantian (Celine)
            <a class="moz-txt-link-rfc2396E" href="mailto:Tiantian.Zhang@amd.com">&lt;Tiantian.Zhang@amd.com&gt;</a><br>
            Subject: RE: [PATCH] drm/amdkfd: check if vm ready in svm
            map and unmap to gpu</p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">[AMD Official Use Only - AMD Internal
            Distribution Only]<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Hi @Yang, Philip<o:p></o:p></p>
          <p class="MsoPlainText">Could help review this patch?<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Thanks<o:p></o:p></p>
          <p class="MsoPlainText">River<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">-----Original Message-----<o:p></o:p></p>
          <p class="MsoPlainText">From: Koenig, Christian &lt;<a href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">Christian.Koenig@amd.com</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText">Sent: Tuesday, March 31, 2026 7:32 PM<o:p></o:p></p>
          <p class="MsoPlainText">To: YuanShang Mao (River) &lt;<a href="mailto:YuanShang.Mao@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">YuanShang.Mao@amd.com</span></a>&gt;;
            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">amd-gfx@lists.freedesktop.org</span></a>;
            Yang, Philip &lt;<a href="mailto:Philip.Yang@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">Philip.Yang@amd.com</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText">Subject: Re: [PATCH] drm/amdkfd: check
            if vm ready in svm map and unmap to gpu<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">On 3/26/26 11:36, YuanShang wrote:<o:p></o:p></p>
          <p class="MsoPlainText">&gt; Don't map or unmap svm range to
            gpu if vm is not ready for updates.<o:p></o:p></p>
          <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt; Why: DRM entity may already be
            killed when the svm worker try to
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; update gpu vm.<o:p></o:p></p>
          <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt; Signed-off-by: YuanShang &lt;<a href="mailto:YuanShang.Mao@amd.com" moz-do-not-send="true"><span style="color:windowtext;text-decoration:none">YuanShang.Mao@amd.com</span></a>&gt;<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Looks correct to me, but I think
            somebody else already added those checks.<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">@Philip is that correct? If not please
            help reviewing the patch.<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">Thanks,<o:p></o:p></p>
          <p class="MsoPlainText">Christian.<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt; ---<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;
            drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 11 +++++++++++<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp; 1 file changed, 11 insertions(+)<o:p></o:p></p>
          <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt; diff --git
            a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
          <p class="MsoPlainText">&gt;
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
          <p class="MsoPlainText">&gt; index 8167fe642341..7f905a7805fa
            100644<o:p></o:p></p>
          <p class="MsoPlainText">&gt; ---
            a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +++
            b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c<o:p></o:p></p>
          <p class="MsoPlainText">&gt; @@ -1366,6 +1366,12 @@
            svm_range_unmap_from_gpu(struct amdgpu_device
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; *adev, struct amdgpu_vm *vm,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;CPU[0x%llx
            0x%llx] -&gt; GPU[0x%llx 0x%llx]\n&quot;, start, last,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_start,
            gpu_end);<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_vm_ready(vm)) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VM not
            ready, canceling unmap\n&quot;);<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +</p>
        </div>
      </div>
    </blockquote>
    The change looks fine, but it is unnecessary after checking the
    details of amdgpu_vm_ready.<br>
    <br>
    It is impossible the &quot;DRM entity may already be killed when the svm
    worker try to update gpu vm&quot;,<br>
    guessing the svm worker is p-&gt;svms.restore_work,
    svm_range_list_fini cancel the work or wait for<br>
    it to finish. kfd_process_wq_release does svm_range_list_fini first,
    then fput(pdd-&gt;drm_file) to reduce<br>
    the vm refcount, then calls amdgpu_vm_fini, to destroy drm sched
    entity.<br>
    <br>
    If you see the real issue, please post the dmesg log to help
    understand.<br>
    <br>
    Regards,<br>
    Philip<br>
    <br>
    <br>
    <blockquote type="cite" cite="mid:LV5PR12MB97772581D2D90604F36F00EE895AA@LV5PR12MB9777.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoPlainText"><o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return
            amdgpu_vm_update_range(adev, vm, false, true, true, false,
            NULL, gpu_start,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            gpu_end, init_pte_value, 0, 0, NULL, NULL,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            fence); @@ -1443,6 +1449,11 @@
            <o:p></o:p></p>
          <p class="MsoPlainText">&gt; svm_range_map_to_gpu(struct
            kfd_process_device *pdd, struct svm_range *prange,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;svms 0x%p [0x%lx
            0x%lx] readonly %d\n&quot;, prange-&gt;svms,<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; last_start,
            last_start + npages - 1, readonly);<o:p></o:p></p>
          <p class="MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_vm_ready(vm)) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;VM not
            ready, canceling map\n&quot;);<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
          <p class="MsoPlainText">&gt; +<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = offset; i &lt;
            offset + npages; i++) {<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gpu_start;<o:p></o:p></p>
          <p class="MsoPlainText">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t gpu_end;<o:p></o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
          <p class="MsoPlainText"><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------dR9pyUqgisXW5n0jsQnmxvRT--
