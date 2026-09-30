Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119C4CA5FB5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 06:40:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A47AB10E594;
	Wed, 30 Sep 2026 06:40:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tsjW+HPN";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA01010E594
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:40:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zI4cPTqi84+DzNwyhZ9S4+u9mnfGjL43puswJTIBBEsLYMyWio6dZLgsnuTEjVCeJrPjIdBoMpFqRPkE6ojxjr+R2tA1BKnosZZEmDCbBBNCCIfVpoKYkUcf7qBFfulsU4y7ggs3ozWSVDps1utO1EyfI/3pXzpv6chn7pBqFnhBSbF31oe/Qw0zvpQ+C355dYAhfswuPR9AHwxEijBW3WREaf/HN4PyjNYKHOLMfn65OjcVK9bcNGykBeHBH++0GsHqLZldwtGTlDlMD0mxU7tjN055RT+WmXy9zeXvVeIicP5orNFTjO+cJ1GbeMEyTb41m2M/10pqs6fZV+9REA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTpnUnI+nJ73M8C1MLgkpn2DUtfKbY0/h7e5O4T4Rcc=;
 b=te7SIoStmwwbYEEe5tScUa5q/Z05mI7qdwkQ5DS/xqribBlRlGjgoke94Rqb4bQp3jH0da7d46VG2hdVLPRcXZuZ2hJd1bxoCfbExz5gvu2dqyX5AtT2cvITaZIWAgokNh38NHQFwfZOtaSlmTXYCIlSU7U+QOAASFjqXlXvCcJ3Sx3Sa5Fm8RoSfryHxui6F2xnAW52BWCHoaYvUXc2Va87GtOrfpvij/6MF2iWqOWccj1YdaoMen4QY6ojftNwEfTFk3XF6AlbR0Zon3qkKQeWmnBSFv3meOz+VyRX+t7fNQ3f8XZAPFStTFsP+7PnrdFud1ZiflbBH0hHppzKPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTpnUnI+nJ73M8C1MLgkpn2DUtfKbY0/h7e5O4T4Rcc=;
 b=tsjW+HPN6c+L4cet/UXaKSgX/YRFbKKoUbxD4qDWcPp6689FNwJeVRFB0IwmyQLYN7vNVSRgV+6VpWXdZj32UhykNtcdiXN55gQi7BHun14qqzlDXci5pMMFmVqVkpt5dO05nLNifHJAfYqnuFcFTz5huD92RhEdxyz519M0Gs8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS6PR12MB349270.namprd12.prod.outlook.com (2603:10b6:8:52b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:40:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 06:40:22 +0000
Message-ID: <2a1fdbf2-e921-456c-9bf0-c0a0970a7532@amd.com>
Date: Wed, 30 Sep 2026 08:40:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: "Khatri, Sunil" <sukhatri@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-9-sunil.khatri@amd.com>
 <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
 <3233a346-d95f-49b4-9193-769e04493d8d@amd.com>
 <39db1027-cb18-498c-b93e-6d237263ecf2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <39db1027-cb18-498c-b93e-6d237263ecf2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS6PR12MB349270:EE_
X-MS-Office365-Filtering-Correlation-Id: 64939f5a-7638-4112-e4e8-08df1ebdb3aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PcIAF8VJTdlqHMrzxksb/ZPwlqaDZvdmIEMGC5IcM8X9G8jimZLPb9m4/B0+BMPfh9FYsneP0oKumkKpA2E9CN7xUXeQ0ga/y2vXC8sfbL+unoRxSI49A4f67pYpivm+UamULxwZmtaymvufnYLGnEc93iz23vniSlPYRnSTG5r31SpMIUnR/e/1LZFtiQvaz33uT7qS5Qu3udt+/fewHlROYjtACr9n0PrntE4L2cdm8tQlrFel/etvN17/105RXaTr5xM3iykjtk/PzpLtJiVXv/4L3P85aJrgLAZ4kxrt1e/Y+GVoEMmg6VfU3UpRhBjjbsVoSvC49qh9aXqAVT3iF4uSEyOn3N20/6ZBD437vHXFUZNJm+wlzCdP5X4YP8yu2Q0LPPhubTEEyNgcZQ+wwhmK0JbPSaf4ARHyVNSemWH5qRiQLqRJG+4MyC5qlqqyl6Gai0ggXi5zZN3u7ryzsQ17j9wiiIZslZzEq7VzI7Yu64lO5WPDm6GbHAIDof0XFm+JExftOsh8QDfYbxUY9fqKUjXhNhkP5a+I8dl+Bh3k8uuMQ7d5i8S9c1PQzT588Wqv+RT8gfuVivt4ruq/fwu9UVM3zSy2+SZyKUxJ8MNbBnKTBjR4PxqrVpjjJgzUQQGwdLP3zqPia92FcP/q6TXIFlN/ZOabxVJs9b8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG45bmFKclBRa09LWUdEVjlyMHhhNGpnUWZ1MWtNaVlqc3BiaGMySlk4dTdH?=
 =?utf-8?B?MmxlRGcrc2VWMXZRWlRSWkx0SlhHQzZBVmV5byt2dktjeDY4cWExdjl4YzQz?=
 =?utf-8?B?SldFRTRIOWQrRGtHdUpTekNWZkQ1N2FLQ1UxWVdZaHhVTi9ZWUh4ZXJxd3do?=
 =?utf-8?B?TnNQdk9LSndtU3lnbWFET2xUUDdmUy9YZ1ZKcTZES0NOb01WeG9vcU5vTUF5?=
 =?utf-8?B?MjB5L0poSDByV21jbksrcUdDNldPUWRGcThZanFqSUR1YVBSUWwyNXFMY2tX?=
 =?utf-8?B?MTBtY3dUckNCcnowMktObUJoUFhmUVhIV2s4djl3ZXVYRUpRdDh2bFo2RTdk?=
 =?utf-8?B?emYvM2RqbHhyekZzOS90bzR5WEc3djk2TkZ0blNGNVRTUUxNenc1UE5oNlpu?=
 =?utf-8?B?d3JTSE5EN3lseTlCNHptaG45RHZXckVkUlh4R2hHNTFrM004YXJwbDFDZFV5?=
 =?utf-8?B?YzY4UHNUbTZwdGxNUXlTcUFOL2hxN2FMWlF5KzI2TndUS0QvQXBYb01YOWl5?=
 =?utf-8?B?RjBxQThHdUZ6M2Qvak10OFFMcWFVNzJ2YzlmOGFJNFdsUUJkWVZGMlVNbVYr?=
 =?utf-8?B?d0xFK2FyK0J3ODZwY292RWJkc0twT1oyZWx4TUdiaENDM0dkY080RGJkSG13?=
 =?utf-8?B?OXdsUkowNit5OTV3UCtRV2trODl1NUZiSDRuNGE0dENhS0laRURSaERUVDRk?=
 =?utf-8?B?Y1dJQmhFVnIvZFZaYm1naHFSRUVmYmp4UDd0QUxhVDlWQmUvMnUyRE9sQ3pS?=
 =?utf-8?B?MDQ1MUlhc2k1WXFKYTN3Z1ZuT3BZK1ZzVDJxZHdqZE5YRldWWktuaXQ1K0hQ?=
 =?utf-8?B?NysyV0w0eG1Mb3NKQUtoSDJOR0FkMFJDN0taT0phS3ZSSFY2SjdHLzIvWEZN?=
 =?utf-8?B?R1I3akR4UVJoWkVubSt0RGlGeWZKeTBQaDM3ZktOSXVSaW8zMmhrL05ydWpF?=
 =?utf-8?B?bXIvdEV5UFpncFc2eHE3bCttdGZtYWRCWFhvY280QlE3b3dMcFVHTXNuOXBB?=
 =?utf-8?B?SldlRElVeGkxMWhacm12ZHZJMy9UeWhLSXZ5RzBzQnVEUEFaTG15YXY4OWpx?=
 =?utf-8?B?OWlJRTAzaVhwbWEvbUlGdjRxZkQ4SUJXVG1mSVRPWUtIVkx2L0ViN2pkVGdT?=
 =?utf-8?B?c2F3UHppdHp4dTR1SGFybEQyZEc1Zy8raEplS1ZFTStueC9GV1FSci8rV05R?=
 =?utf-8?B?QWdpei8wTi9OR1R0REdWY25yU2NCZkkwbDNnQ3JxMXp5VlFkQ212a1JMOWFl?=
 =?utf-8?B?RUVyZnpRWlNiTitIV0U3NWkvT09IWHd0ZU5BS1VkYzBSL01UVytOalE4SnZK?=
 =?utf-8?B?K3JkVTVyVXFHaFZsU2VyZ2E4MFJ2djl4cXZwY3B2T1RQZWRRdldBaUY5a2gy?=
 =?utf-8?B?eDRUeElZUHF0NGtQY0QzZUU1VW1CdXNyUFpkaE1POHVpTTM0aVlQaWJMaGZp?=
 =?utf-8?B?NDlhaVpkbnpOZHNWRG0wMS9YbW95dncvamJUak5DaHZOeWlsbldNYWpDb3hT?=
 =?utf-8?B?cVFSUGxrSWRnRy9mcTZjZ21TZE5VaUIvMWh2d0NHTWx1YkRCYm5BdCthVjVn?=
 =?utf-8?B?ZGtvbE9yWWY0eFRJWUtibGlxcTJ5ZjE2SmhxblE1YkNCdXZrbm5OQWFHSlk2?=
 =?utf-8?B?TkNoMVFVTFFReG1wbUYrOEx3SDB2NHovS2RpY1h0TmJkdFlDRE53M3R1Qkoy?=
 =?utf-8?B?MEVlenZsK1BPY0FZUExuRDlwYUFhZ0FtQkNnbk1WMWRWZUxCakwwdG1uNURi?=
 =?utf-8?B?Vk1CQk9DcE5CWEtCLzRBcHVBbndvSmJpRVIzMHdDeHlyUXJsWExXZ0djVlVU?=
 =?utf-8?B?RDhGamFVbGhQMFpuclhNaTY4ejFocHdZc1Jka091WFNzR3ZnZUhjYzZvVHVD?=
 =?utf-8?B?aGtJK1A5ZFZTdnJ2ODRIN2EwTUVzNVFzMTRWUlkveEpzdjdreUw2RlhtYWh5?=
 =?utf-8?B?cWpKZmNCc2NhNGJ6QUd2M0txY2k0aytBNG9PYm5rRVgrL0RRZ29mK1JUT2t3?=
 =?utf-8?B?dWdBNlFYSkprRk5WQ3FZVk81aC9ac2NTeXdTdEpmVEhtUXZ1bDlyMG9DdjNp?=
 =?utf-8?B?V2wrRG12MFlYYzlac1ZmRXd4UmJUUWtrTGRDSXF5dkpZcFpIeFlGSmtyK1hp?=
 =?utf-8?B?b2plUmxFNFEwVi95Q3VtL1NocjFUY1dmckhSOXZGQVF0WEFESjVETzVDWndB?=
 =?utf-8?B?K1pWQ1hKaVVjSklmTnZIdGRtWi9iNGRIVU9OWFZqbFRkeitzYW1wUEh6bVhP?=
 =?utf-8?B?QStBSWZESXFvS29saTN5ek9tZFF1ait4ZXByNDF1dkVlTVJMckdWcW9Yc01W?=
 =?utf-8?Q?1w8QQnHdxw5l4suECi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64939f5a-7638-4112-e4e8-08df1ebdb3aa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:40:22.4275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Fdbd7S3s7Kp5eGewMgv/wRzQDfyar3f8cvvb5jUko0G9Nix1uK3bhVQr0DwASg8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB349270
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

On 9/29/26 19:13, Khatri, Sunil wrote:
> 
> On 29-09-2026 08:26 pm, Mukul Joshi wrote:
>>
>>
>> On 9/29/2026 8:04 AM, Christian König wrote:
>>> On 9/28/26 20:57, Sunil Khatri wrote:
>>>> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
>>>> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
>>>> vm_manager.spm_vmid, use it directly so the idle default matches the
>>>> VMID the reservation path hands out.
>>>>
>>>> No functional change: spm_vmid is the top VMID (0xf) on all affected
>>>> generations (gfx7 through gfx12).
>>
>> I don't see the full series for some reason so pointing it out here.
>>
>> We are reserving and using VMID 15 for NPA VMs currently on GFX 12.1.
>>
>> Currently, we are using it only on MMHUB. But this may change in the future.
>>
>> So maybe refrain from using the same VMID 15.
>>
> @christian,
> Whats you suggestion here on using the vmid15 suggestion that Mukul has shared.

As Mukul wrote as well for now that is rather unproblematic since we only need VMID 15 for NPA on the MMHUB and for SPM on the GFXHUB.

But we should really note all special VMIDs usages in the vm_manager and abstract the reserved usages using proper functions in amdgpu_ids.c.

Something like funktions to return the VMIDs which should be used for kernel queues (CS IOCTL) and user queues (MES, old HWS/KFD).

That should give us enough flexibility to change things for future HW generations.

Regards,
Christian.

>>
>> Also, since I can't see the full series, please look at gmc_v12_0_sw_init() on how we are reserving the VMID.
>>
> I am not sure Mukul why you arent seeing the full series... I am aware of the NPA VMID 15 reservation in MMHUB and I will check have a look at  gmc_v12_0_sw_init.
> 
> Regards
> Sunil Khatri
> 
>>
>> Regards,
>>
>> Mukul
>>
>>
>>> You also need to remove all the calls to adev->gfx.rlc.funcs->update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>>>>   8 files changed, 9 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> index 33403e16df5ca..88f9f0b0bf524 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>>> @@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>>>             gfx_v10_0_init_csb(adev);
>>>>   -        gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>>>> +        gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>>             if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>>>>               gfx_v10_0_rlc_enable_srm(adev);
>>>> @@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>>>>             gfx_v10_0_init_csb(adev);
>>>>   -        gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
>>>> +        gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>>             adev->gfx.rlc.funcs->start(adev);
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index 7bfc8cbdcad85..036d1b7ade4e6 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>>>>         /* init spm vmid with 0xf */
>>>>       if (adev->gfx.rlc.funcs->update_spm_vmid)
>>>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>>> +        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>>         return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> index b75512e7b1db6..4caa43ff50a1b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>>> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>>>>         /* init spm vmid with 0xf */
>>>>       if (adev->gfx.rlc.funcs->update_spm_vmid)
>>>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>>> +        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>>         return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>>> index 91764f2e5ad01..a3d72cbaa6cf1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
>>>> @@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>>>>       int r;
>>>>         /* init spm vmid with 0xf */
>>>> -    gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
>>>> +    gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>>>>         if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>>>>           gfx_v12_1_xcc_init_csb(adev, xcc_id);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> index 549d1239e326b..04ee7e1725a94 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>>>>         /* init spm vmid with 0xf */
>>>>       if (adev->gfx.rlc.funcs->update_spm_vmid)
>>>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>>> +        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>>         return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> index ab4123ddbb942..61ba71b57b8e2 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>>>>         /* init spm vmid with 0xf */
>>>>       if (adev->gfx.rlc.funcs->update_spm_vmid)
>>>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>>> +        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>>         return 0;
>>>>   }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> index 1678015ce5a97..4862d17a58237 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>> @@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>>>>           break;
>>>>       }
>>>>   -    gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
>>>> +    gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>>>>         adev->gfx.rlc.funcs->start(adev);
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> index 01ed1701c781a..add8099cf8e05 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>>> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>>>>   {
>>>>       /* init spm vmid with 0xf */
>>>>       if (adev->gfx.rlc.funcs->update_spm_vmid)
>>>> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
>>>> +        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>>>>         return 0;
>>>>   }

