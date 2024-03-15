Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA29C54E67
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 19:09:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4B7112465;
	Fri, 15 Mar 2024 19:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eapM0Ekl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A58112465
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 19:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/QURuR5vTTyUTtS2Hcrboj4VukFSHVLMgok+QK53CDARIzh/kKJWBp3wjaRPzgH3UHILGluht9VvLf8YxRsP6Yx+H+E3WLR073+wGViXq0IbCoyor+RIHHsq0rGyVIue7vMcK++E8z9GlRc8UdPOjYRYOYCeqT+S2eD0Xy3U32JegJ1RabjdYuXpl2GhYu2BVUyN3cBi8rMoKsOQoDrh8MqCSxZr3rBcsIIFShXmt+2oBehdy/GA4yhSZdDCPvZ2oQ8VDQiW7h4rE+mNMvvDZus/gcF3whm9VRh5zVky6y0DtWYWdNGQYQeD0bg48FBDQZzcftBIv64jEG8+FyLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ0iMeY6TKZsbDTqgG90/PpX5kktxzvUCY9Warlmv6g=;
 b=SfO318Y6EY23CqlJ6N4jt2AjWryrIYx4MJC/T+X81to/gcblvs3PXGdKgh/fEnli80ZXZdPznPUGJYW6N/1GuiUN2qcZ+QZODE4PUA1WXcQEu89l/tyyJxT/echUKt9jRjlehfS1p0ygnvQavZvD/cnA8I6Nkpy+1Zv+ECQV4ebXX0rDoBbOgJQ3j2vn3DKdv16AWFCvAaJWz2DX9XdOnrQkVvd3qv3Gn9wuWcHMPxuCvN0cMkqT8Tf8eFMC9U20NsPH8ma67NhZtRMLRL1uhM3595i8bmmBgAoiLLKUbaQXkZKmVAvi+AizX73TwfCDdb/tPOU3mH4RECAbm6JOkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ0iMeY6TKZsbDTqgG90/PpX5kktxzvUCY9Warlmv6g=;
 b=eapM0EklQtAZdSHyjqDJO772gpSgexTv9iCaeFu5FvUarQHFW2UXXuesLsLGTHcooUBo9m0MNGddEbSOeMMHdAznbYDYuIVPscy6GirZ26nBKDo2fLkjtjVQ0rzspumg62IxmZVQZ+gP2EJt75dONxitEBAYo1xvSCI7OHGhRnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 19:09:06 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 19:09:06 +0000
Content-Type: multipart/alternative;
 boundary="------------ktLy49YUYV0piEMueIpd0AD5"
Message-ID: <72df7acd-4019-4159-b9c7-ffa8cda9e86a@amd.com>
Date: Sat, 16 Mar 2024 00:38:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] drm/amdgpu: add ring buffer information in
 devcoredump
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, sunil.khatri@amd.com,
 christian.koenig@amd.com, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain>
X-ClientProxiedBy: PN3PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::11) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: c72d3b16-38d7-4a95-acaa-08dc452362b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzu9Q8j+GOc3wj+mMHj+0y4G3DK7366ufnk2PMx690dvlh7DuLjMArOgtYtxzsPrE0x8FeMmb31l9BoBbdDzjhoNgN4H7Zql16oTy+DTPO7OrBaObOQ7vgIAb36o8jdipq5U6w4xf7IOUc5kbYENQSWdMbobdn1UBFITYsCKmF8P2TphQZI24Q0uOko4Fi9L5avpXB/+LngxI8BeqY6TnU6J+JlDTJzi4APLpS/ZZ/7L5+tLdDjJT6vxVEPW4/VCs9bMGWmDOaSCeVtNIxt0LyaeWqR4onmYe0m1YpvKZALElnkLZNZu/r4MZrqNRTmfsn5WrouDtBOM3uRW0Cy9UcLPuubJdt7XnPf1KBL0FXKbtdEDdk1T/aZbzoG5jBAlGYt5c14hyM5IQ1lzXsgn54/XST0HjR1xfZNeU17ErHaH92ncpF5PmNuu30HXf6RD38rDbna7LEZwDC2k7GIWLtomc9cDRiO7f8QoHaKhbBV70paM3k88iOSugYya8ZMyPw5zpWivit1CRB2MU05Ae5Nymo9E/iD28lzwpOCmshByJRPbjr+04nvN2Q/ez9h1lY33eCveGzoKFzWCFCaW+jgf4BlZOH/5v3WFr74x3sb8KVm0nllKK6b1JmUeB4MNNf6zYPCuS/dfp4eToksZrkSsu+WaMxUtIChQivWAXD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eit6KzQ4YytBNVd5UXZhMXFNRkdPVnE5b1FhWkF3THE2Tml5UFRLVkpmZ3JP?=
 =?utf-8?B?alNxMnhJUDhYQ0FDaVB3ajdtNHBpcFg2MzhPZTQraUw4K2RMaDdScW1ramdR?=
 =?utf-8?B?SFdubnJEbWtrYUFJVHhBTlE3YTQ0eVhIcjE4QlhXSmhPZWk2NjhrU2ZsK3BI?=
 =?utf-8?B?VHhwVGdxRnV4N0ZjM1h5MktOY3EybUQ1NUx3TEpaVTB5TllVVEt5NGJPZ3pk?=
 =?utf-8?B?dXZPVzlIcnl6TE41OEljNHFJdUxrNDU4VGJtY1QxSTl3bGwzYnJ0RXp5TUtG?=
 =?utf-8?B?dnhLeG1Bc1VYdlBNSDBhVDhFbkIxbW43N1NvQlhTK3FVSjVtM01GWmkzTnZv?=
 =?utf-8?B?RitSeUk2RmU0anVqS0orQlREQzhWaGdzZDdpNU1jRXVRbGR5aDYreExlRDJh?=
 =?utf-8?B?Nyt6alNwL3o4eEh1VnlmQlRqazJ4ZW5zS0pFc3JVSUpqT2VWUkpEZXlER3F1?=
 =?utf-8?B?dnhDTU5ScVdaeXFUSHFpdmZFaE9oaTZIbWRsaENTQ0ZwWUhrNWhZUDB1Zktk?=
 =?utf-8?B?cTArekdmZDYrUTFuRDBSZEtmMjU5Rmk2WlhGdldTeWRQdVJtNXpRcUcxSElP?=
 =?utf-8?B?enlvQXoxdjdWMXU0QXhMQUNWNmk0RjhWQWc4dVNZZjlUWlJ0ZjBwanY4dkc5?=
 =?utf-8?B?SnlMU2RLd3plTHV6QWpkdUxMOGxiY1MxUkhZWEJVR0Q2RFJxdlI3ZTY4MGNP?=
 =?utf-8?B?YXZBRG5ZNzl1a1prcW9pejEvdjRFTTlnalhtbW5uQVdJbGtQU2lDeFV1NUFU?=
 =?utf-8?B?bzZPb1JwaHRmc01wdE9PMWJESzJiQ1hHTXRPSERQd3YyMDRzM2p6TmJZbWFi?=
 =?utf-8?B?QU9DS0ZoOFBlYTEvL1JmMmxqdThkejdaMEVuMlRpYVYyUDlmdWVQQnM3bzJL?=
 =?utf-8?B?ZHFVWkduN2M3TktqK0M0akNuOWpIelVLdGRsTlRpRGRKQTJGM1ZUTHk2KzI3?=
 =?utf-8?B?K1oxSjFQS2VWejlKY2R5SDV4cGVyVGZuRmtwbERHNTBZeHgycUVRRHRQTHU1?=
 =?utf-8?B?N2J6enU1STZWUUsrZktEbldqbUl0KzZYak1iN3o5dWNXczFQRzBqYVlsUUFM?=
 =?utf-8?B?cExQK3k2dHlBYkJJVWVkdVlhai9mZFZ1NytMSzlPNHJwb1ZNWjQ0SWlTNkFs?=
 =?utf-8?B?R29neVowbFBnOFdpa2FlVGFWN2JpV0t1RmlOL3F5bU5ubEZOTWEzMWVMTHlT?=
 =?utf-8?B?M1UreW1KZ0Y3dU9nd1lHN2pKbXhaRHdZcnI4akMvMFk3RHNXR2dCa0hWZnVq?=
 =?utf-8?B?RmFGOGtkVnVwZ3dRU0hCY2krUHdocGpPaERlR3RQRFZyeW9GdjdGeWs4N1li?=
 =?utf-8?B?Vy9PalZweWNKZXNzY0ZRa1hJNk5oOUtGMWhGc1Z0b3Z6aWUxbEtPUjdxMFdF?=
 =?utf-8?B?V0YrV1hBTG1nUHd2UW5zWk1pMlAvb00wb2NLaW4wZi9SSjFEY1Rvd3BqcHFN?=
 =?utf-8?B?cHRESDhkQk5hd0dWUU9SZndHM3dkMHhOOHhNM0VzYlBWM0ljc0EvelNBSGpR?=
 =?utf-8?B?YURydG9CKytPSWI2UFNzVFphQmhQQzZTZjRCVDljNWw1Mk93NnZxSUo5TW9O?=
 =?utf-8?B?WlJNbDBQWEtPMnh5MW5uQzNqTlU1RnRaQ2Z0Y2k1UnUzVms4clFET25rQzcz?=
 =?utf-8?B?KzNROUJZM21HN1ZiVUpxWC81Mko3ekNLc2JkUVFRVnBuNHhnc0F5V1QvSWh1?=
 =?utf-8?B?MFY2YnVxMGJnejExOUNSNjAwZ1hpclJSVlNKY01Fem9lMy83aU4rTnRsMndO?=
 =?utf-8?B?UlBrdGRzaStzVWVnNTUxM0pGeEJIMDhkcGJja2FUTnIrVURONkJuUVA5c3lH?=
 =?utf-8?B?VWNYN2Q4Z0xjNDhhcWYyV29EVmhMMWwyVllZZkUyNmRUVVhVY3hhL1FCV3N6?=
 =?utf-8?B?elhYS3piV2pUQjZoUUlWVzZ6Skpqd2JUQ3MvVldMUE9XaWl4UUgxUmNsaHdp?=
 =?utf-8?B?MlZUSTN2U05FWmRrUjJOaXZwVWw3OXd1SVhCQUpqeCsyU3FLVVFUOUdNd3hE?=
 =?utf-8?B?S3pBcEdzcC9mS0Z4aTE0aVRic2pGcldoMkJRQUM0V25SeXpVVVlJR3VPTHFo?=
 =?utf-8?B?MWZhNWF2eGpEMHloVkFwWlVDQnAwMXQrSTlqN3dkMzVoekhTTjg2TE5MNTZI?=
 =?utf-8?Q?ibwDQ6nt71kGw2ZjklVTmjxnn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c72d3b16-38d7-4a95-acaa-08dc452362b4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 19:09:06.5612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31gwqwGiG6NgrvINIJUfbkKXo/yJkjnvs7qI1UJs+ULqFompQ/l9E2ktt//1YbeRFef06YoV0biqe5agFc2FXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
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

--------------ktLy49YUYV0piEMueIpd0AD5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks for pointing these. I do have some doubt and i raised inline.

On 3/15/2024 8:46 PM, Dan Carpenter wrote:
> Hello Sunil Khatri,
>
> Commit 42742cc541bb ("drm/amdgpu: add ring buffer information in
> devcoredump") from Mar 11, 2024 (linux-next), leads to the following
> Smatch static checker warning:
>
> 	drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:219 amdgpu_devcoredump_read()
> 	error: we previously assumed 'coredump->adev' could be null (see line 206)
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>      171 static ssize_t
>      172 amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>      173                         void *data, size_t datalen)
>      174 {
>      175         struct drm_printer p;
>      176         struct amdgpu_coredump_info *coredump = data;
>      177         struct drm_print_iterator iter;
>      178         int i;
>      179
>      180         iter.data = buffer;
>      181         iter.offset = 0;
>      182         iter.start = offset;
>      183         iter.remain = count;
>      184
>      185         p = drm_coredump_printer(&iter);
>      186
>      187         drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>      188         drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
>      189         drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>      190         drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>      191         drm_printf(&p, "time: %lld.%09ld\n", coredump->reset_time.tv_sec,
>      192                         coredump->reset_time.tv_nsec);
>      193
>      194         if (coredump->reset_task_info.pid)
>      195                 drm_printf(&p, "process_name: %s PID: %d\n",
>      196                            coredump->reset_task_info.process_name,
>      197                            coredump->reset_task_info.pid);
>      198
>      199         if (coredump->ring) {
>      200                 drm_printf(&p, "\nRing timed out details\n");
>      201                 drm_printf(&p, "IP Type: %d Ring Name: %s\n",
>      202                            coredump->ring->funcs->type,
>      203                            coredump->ring->name);
>      204         }
>      205
>      206         if (coredump->adev) {
>                      ^^^^^^^^^^^^^^
> Check for NULL
This is the check for NULL. Is there any issue here ?
>
>      207                 struct amdgpu_vm_fault_info *fault_info =
>      208                         &coredump->adev->vm_manager.fault_info;
>      209
>      210                 drm_printf(&p, "\n[%s] Page fault observed\n",
>      211                            fault_info->vmhub ? "mmhub" : "gfxhub");
>      212                 drm_printf(&p, "Faulty page starting at address: 0x%016llx\n",
>      213                            fault_info->addr);
>      214                 drm_printf(&p, "Protection fault status register: 0x%x\n\n",
>      215                            fault_info->status);
>      216         }
>      217
>      218         drm_printf(&p, "Ring buffer information\n");
> --> 219         for (int i = 0; i < coredump->adev->num_rings; i++) {
>                                      ^^^^^^^^^^^^^^
> Unchecked dereference
Agree
>
>      220                 int j = 0;
>      221                 struct amdgpu_ring *ring = coredump->adev->rings[i];
>      222
>      223                 drm_printf(&p, "ring name: %s\n", ring->name);
>      224                 drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
>      225                            amdgpu_ring_get_rptr(ring),
>      226                            amdgpu_ring_get_wptr(ring),
>      227                            ring->buf_mask);
>      228                 drm_printf(&p, "Ring size in dwords: %d\n",
>      229                            ring->ring_size / 4);
>      230                 drm_printf(&p, "Ring contents\n");
>      231                 drm_printf(&p, "Offset \t Value\n");
>      232
>      233                 while (j < ring->ring_size) {
>      234                         drm_printf(&p, "0x%x \t 0x%x\n", j, ring->ring[j/4]);
>      235                         j += 4;
>      236                 }
>      237         }
>      238
>      239         if (coredump->reset_vram_lost)
>      240                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>      241         if (coredump->adev->reset_info.num_regs) {
>                      ^^^^^^^^^^^^^^
> Here too
Agree.
>
>      242                 drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
>      243
>      244                 for (i = 0; i < coredump->adev->reset_info.num_regs; i++)
>      245                         drm_printf(&p, "0x%08x: 0x%08x\n",
>      246                                    coredump->adev->reset_info.reset_dump_reg_list[i],
>      247                                    coredump->adev->reset_info.reset_dump_reg_value[i]);
>      248         }
>      249
>      250         return count - iter.remain;
>      251 }


Although adev is a global structure and never in the code it is being 
checked for NULL as it wont be NULL until the driver is unloaded. I can 
add a check  for adev in the beginning of the function 
amdgpu_devcoredump_read for completeness of the tool but still not very 
sure of it.

Christian and Alex Do you agree with my understanding the adev does 
really need a validation for NULL. I dint see throughout the code adev 
to be validated for NULL. Do you recommend to add a check for NULL for 
adev in the above mentioned function/places.

Regards Sunil

>
> regards,
> dan carpenter
--------------ktLy49YUYV0piEMueIpd0AD5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Thanks for pointing these. I do have some doubt and i raised
      inline.<br>
    </p>
    <div class="moz-cite-prefix">On 3/15/2024 8:46 PM, Dan Carpenter
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
      <pre class="moz-quote-pre" wrap="">Hello Sunil Khatri,

Commit 42742cc541bb (&quot;drm/amdgpu: add ring buffer information in
devcoredump&quot;) from Mar 11, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c:219 amdgpu_devcoredump_read()
	error: we previously assumed 'coredump-&gt;adev' could be null (see line 206)

drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
    171 static ssize_t
    172 amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
    173                         void *data, size_t datalen)
    174 {
    175         struct drm_printer p;
    176         struct amdgpu_coredump_info *coredump = data;
    177         struct drm_print_iterator iter;
    178         int i;
    179 
    180         iter.data = buffer;
    181         iter.offset = 0;
    182         iter.start = offset;
    183         iter.remain = count;
    184 
    185         p = drm_coredump_printer(&amp;iter);
    186 
    187         drm_printf(&amp;p, &quot;**** AMDGPU Device Coredump ****\n&quot;);
    188         drm_printf(&amp;p, &quot;version: &quot; AMDGPU_COREDUMP_VERSION &quot;\n&quot;);
    189         drm_printf(&amp;p, &quot;kernel: &quot; UTS_RELEASE &quot;\n&quot;);
    190         drm_printf(&amp;p, &quot;module: &quot; KBUILD_MODNAME &quot;\n&quot;);
    191         drm_printf(&amp;p, &quot;time: %lld.%09ld\n&quot;, coredump-&gt;reset_time.tv_sec,
    192                         coredump-&gt;reset_time.tv_nsec);
    193 
    194         if (coredump-&gt;reset_task_info.pid)
    195                 drm_printf(&amp;p, &quot;process_name: %s PID: %d\n&quot;,
    196                            coredump-&gt;reset_task_info.process_name,
    197                            coredump-&gt;reset_task_info.pid);
    198 
    199         if (coredump-&gt;ring) {
    200                 drm_printf(&amp;p, &quot;\nRing timed out details\n&quot;);
    201                 drm_printf(&amp;p, &quot;IP Type: %d Ring Name: %s\n&quot;,
    202                            coredump-&gt;ring-&gt;funcs-&gt;type,
    203                            coredump-&gt;ring-&gt;name);
    204         }
    205 
    206         if (coredump-&gt;adev) {
                    ^^^^^^^^^^^^^^
Check for NULL</pre>
    </blockquote>
    This is the check for NULL. Is there any issue here ?<br>
    <blockquote type="cite" cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
      <pre class="moz-quote-pre" wrap="">

    207                 struct amdgpu_vm_fault_info *fault_info =
    208                         &amp;coredump-&gt;adev-&gt;vm_manager.fault_info;
    209 
    210                 drm_printf(&amp;p, &quot;\n[%s] Page fault observed\n&quot;,
    211                            fault_info-&gt;vmhub ? &quot;mmhub&quot; : &quot;gfxhub&quot;);
    212                 drm_printf(&amp;p, &quot;Faulty page starting at address: 0x%016llx\n&quot;,
    213                            fault_info-&gt;addr);
    214                 drm_printf(&amp;p, &quot;Protection fault status register: 0x%x\n\n&quot;,
    215                            fault_info-&gt;status);
    216         }
    217 
    218         drm_printf(&amp;p, &quot;Ring buffer information\n&quot;);
--&gt; 219         for (int i = 0; i &lt; coredump-&gt;adev-&gt;num_rings; i++) {
                                    ^^^^^^^^^^^^^^
Unchecked dereference</pre>
    </blockquote>
    Agree<br>
    <blockquote type="cite" cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
      <pre class="moz-quote-pre" wrap="">

    220                 int j = 0;
    221                 struct amdgpu_ring *ring = coredump-&gt;adev-&gt;rings[i];
    222 
    223                 drm_printf(&amp;p, &quot;ring name: %s\n&quot;, ring-&gt;name);
    224                 drm_printf(&amp;p, &quot;Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n&quot;,
    225                            amdgpu_ring_get_rptr(ring),
    226                            amdgpu_ring_get_wptr(ring),
    227                            ring-&gt;buf_mask);
    228                 drm_printf(&amp;p, &quot;Ring size in dwords: %d\n&quot;,
    229                            ring-&gt;ring_size / 4);
    230                 drm_printf(&amp;p, &quot;Ring contents\n&quot;);
    231                 drm_printf(&amp;p, &quot;Offset \t Value\n&quot;);
    232 
    233                 while (j &lt; ring-&gt;ring_size) {
    234                         drm_printf(&amp;p, &quot;0x%x \t 0x%x\n&quot;, j, ring-&gt;ring[j/4]);
    235                         j += 4;
    236                 }
    237         }
    238 
    239         if (coredump-&gt;reset_vram_lost)
    240                 drm_printf(&amp;p, &quot;VRAM is lost due to GPU reset!\n&quot;);
    241         if (coredump-&gt;adev-&gt;reset_info.num_regs) {
                    ^^^^^^^^^^^^^^
Here too</pre>
    </blockquote>
    Agree.<br>
    <blockquote type="cite" cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
      <pre class="moz-quote-pre" wrap="">

    242                 drm_printf(&amp;p, &quot;AMDGPU register dumps:\nOffset:     Value:\n&quot;);
    243 
    244                 for (i = 0; i &lt; coredump-&gt;adev-&gt;reset_info.num_regs; i++)
    245                         drm_printf(&amp;p, &quot;0x%08x: 0x%08x\n&quot;,
    246                                    coredump-&gt;adev-&gt;reset_info.reset_dump_reg_list[i],
    247                                    coredump-&gt;adev-&gt;reset_info.reset_dump_reg_value[i]);
    248         }
    249 
    250         return count - iter.remain;
    251 }</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Although adev is a global structure and never in the code it is
      being checked for NULL as it wont be NULL until the driver is
      unloaded. I can add a check&nbsp; for adev in the beginning of the
      function <span style="white-space: pre-wrap">amdgpu_devcoredump_read for completeness of the tool but still not very sure of it.</span></p>
    <p><span style="white-space: pre-wrap">Christian and Alex
Do you agree with my understanding the adev does really need a validation for NULL. I dint see throughout the code adev to be validated for NULL. Do you recommend to add a check for NULL for adev in the above mentioned function/places.</span></p>
    <p><span style="white-space: pre-wrap">Regards
Sunil
</span></p>
    <blockquote type="cite" cite="mid:9a7c7f33-dd72-4fe0-918b-00b920f7635d@moroto.mountain">
      <pre class="moz-quote-pre" wrap="">

regards,
dan carpenter
</pre>
    </blockquote>
  </body>
</html>

--------------ktLy49YUYV0piEMueIpd0AD5--
