Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F94C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 14:41:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3325910F7DB;
	Mon, 18 Mar 2024 14:41:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4xE1OxT2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C3E110F7DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJ1FnxmEcbqNpFTkNZC1KpaZmAcz5FgEZKmNWfMdPvhIxiVMdn025W89megKFZsMy/8ivgspHzyvGHSmkhOVdttC7aZVe3Qmyjy0oIlmvJZGMxZ67gRPvpg3ZjEcjpGfuvzJmlh/n6+Bq/J5oPlKTGKAXYNKonl3Z2u0uERimnt83rbinZfbo7oD0R6fO63a87uVh5vO4ZvBa/P/1LeK4N95BVP8esceScnL6iFOYquRWOYmr5UV1nqbzIWorfbWPuVcPAJ43Au3jmuKn3Oakn3nyJcedSZ2lJJ5Yy8Keo0RbrGbCWCp9/2Wx7OCIEDTNigtEnBxcDhhDG7Jm2EkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8dm84IQZA71zJmjEQ1rFeGV5tgZmnSx9nYCIH57wDw=;
 b=BJcFKoN9FnmXkLcTDFNlAIOxvEqbvNnOWAqgWmR8VdzPZuVNKABYydD1dEeSEN8uLv/kdCLM1NwS/dBQxt5Gtf1EUawVwmYItE5Xi2Wivx+lNEsycjj0NyjgR6CoIUkYFaEJT3cwJR4bgOwx68IRF1ezeI6ZJkt3oIt7r1S8Sh/JgiKLfKnqEcy0P0amhVFFQ3AtHT8JnpcyB2MQg5Ker7HpuCDASwgDiBIqOM7VhQWHEEl5Hpp7mZnDMQfhDUXmUriZPVHPx7fptjP/oalgTXW/9lWSNdBbNrWJz8+btn+pGbuCfKABOd/n+2S65RPEb4OBFhGfFXJF7JEC7ZFkxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8dm84IQZA71zJmjEQ1rFeGV5tgZmnSx9nYCIH57wDw=;
 b=4xE1OxT22wuhmb9yoGKucVRlmH9M/rsxfAr6xqw418rsoy/DBhOvQYgIkglgXcJt1EQo0Br7fqnmvdeCa8FmRjQRwkbV+PRsaYUhJk+ZdfC0IqrMmNfgnffa0gkDyt08nhZakK9Ia6/pPO9VV8cAnFp5U3OZGhOnlt90fETnLkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 14:40:58 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::f405:814f:a551:4b85%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:40:55 +0000
Content-Type: multipart/alternative;
 boundary="------------Ukjh3TptaLVNfTPBALm74rrN"
Message-ID: <7caeb5ca-4164-4d4d-bfd9-147abcbf105d@amd.com>
Date: Mon, 18 Mar 2024 10:40:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb flush
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
 <20240318120837.2011-2-shashank.sharma@amd.com>
 <0e729b5c-818e-495f-a479-b48c3177094a@amd.com>
 <MW4PR12MB56671969437D89CACEEF999EF22D2@MW4PR12MB5667.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <MW4PR12MB56671969437D89CACEEF999EF22D2@MW4PR12MB5667.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::27) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb46401-3123-4ec1-87d8-08dc47596b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwSOwRbo2KheCYx3o8V/iit+ngApANdv0qMipKN75TOQuzASuVB4cNQJwJyjcxCrcBuDR5Ok7Cf5g6u76sKyE5ZGWuNb5MaH8yabSj1EZH8JZ+aKveTQv4VbPPdmOx0mpunymeKPxhdjsDlCwxcLYUTTURbCZh4DxUCxaHunyxKwS5txb8pz0jfUSJ/ap35Ax5fqrhH9xcK+kwMrtpr+haRJshRgJp/xat6dPvxLfWTZcOU0McRJl54+8LvhqkkBAvb6zjbn2cGlt0pvjuqfTnhtfnxWMnNRLuutCfccsAB8pD2t2AvOy8C31xytu8CPmoFMtVwS4aC67i8H8QuG7qjJ/tg/s+GKcXM/qe5yab28mR+oe7DLyxXqh1Xp/WxhfYfz6WjBiidp76a6i7OAi930OnY6xU5eAwGZzevQcvRjf4Ot4zS47xvW8i/QIaDYQCkXQTLHCBD/CN51ne85wrF768l4fxK9Sp29IEkYapXY8LM3uFEBLN7cjnzLMkTEAs0Pd+JHSdEYczXWuylaRxE6UbzStg2a9uEkHS5CArpnSyKrQEqwilbXRC0yeMBtbH454Na5ZSTKh41WEu7JZNCrnU4xR0ZLOE+8J/sLEFLRs17Y04YKjcAS9sHfDXez6sZCkkihMBjiJugwJEO+y8/4+XnLVPcN83v/9mvGqEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5933.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UC9IandMM2JKanY1TUIyUFc4UXdBU2JxanFjeEYxU2hXQ01uQzhic1FpQXhM?=
 =?utf-8?B?QWo3ZWxJZDF0WTJtcmEwY09MWjJZNkIxdVlra0xzdllXR2M2cGhNWWFzVXNt?=
 =?utf-8?B?ZEErUDVkZUh2OENSUkpDOXJSOWF0ejlLTHJNNXJTbWpDcXFXMlFDcyt2ZlJh?=
 =?utf-8?B?MEF0SjZTYUxuTnBHQ3VVdFFsSm5iNGk1L05OZExESnloTThjSFhjTmVNdWJO?=
 =?utf-8?B?QUxtQTRuMlZCVlhxRS9uMWNKSjNnNEpjcUZMRWRndjNjMEIveVJQa2NrMnZq?=
 =?utf-8?B?dkZzaGlqWC9maVlZengyYXoxSUNieWFHYTVTVUo2YzFwcTFyUEk5SXc5enBu?=
 =?utf-8?B?MFQ3VWRFdnZiQkNiVktXemhYdE9QRG13WkdjUU53MWs4S0dGanhpV09RZ2sz?=
 =?utf-8?B?RWVZTlFENlFtcXp5Nm9EVzJvb0hydTIvdERMNU91bHVlbUJTRWxpSjVlMW1F?=
 =?utf-8?B?Nkd0REJTR2V6MHlVcHBDQXllU1h3d0lPazF3MDlWZVB1WHVITS8yZ0cyaUtX?=
 =?utf-8?B?eC9YNVpRS1p2UnBJaGowU25PNXRURHBGRWN5STN4dm10NHZLSzFUdDB6RWU0?=
 =?utf-8?B?QzBuNHQxYXRHMUVZam5RMVdSYThwZ05CVnFyTnlsaWxqTm0vUFpTcmwveFhL?=
 =?utf-8?B?bWlMa3dDeXhud3ZHNGhUY01ma2JUeWx3ZFR6bnZUdmF5UFAxTnV1TWdNSUtO?=
 =?utf-8?B?bmJmTEMvam53VjJLSU1ncXl6QVRKM3ZMdFhPSHJQc0Q2YkViNGpDSGVnOWt2?=
 =?utf-8?B?UE82ckNGUEF3cTR4VTZ6SGdibVZIOFZRcklPVnZ6Y0FIaEY4amZmbytJVDJz?=
 =?utf-8?B?R0J0T2F2UWxaN1VwakhTeXVuSit1M3MzYkJibUhJNXZ6YnpmeTd0SXBOY1RY?=
 =?utf-8?B?MTBFZmJDRnJkV1ZmK09JNmpLeVBZUVhpZkNsSGFwN05Nalo3RFVzYnZWZE1P?=
 =?utf-8?B?cXZ4eUhaZWw2OS95ZjlpZ3hoamQ2WEFkOUhiWUtiZmhpeldwZnNabHEvRFNG?=
 =?utf-8?B?a0tOTnBGVUlrb29Fb01hd1FoNk1JUkZrOUVpMU9mK3ZzbmNuZXd0dGdOb0or?=
 =?utf-8?B?UkpzR0VOaUdldDdORi83WUhSLzVjV0h6c0hRVXhoZGdpQ0NqZ2lnNHBkWlFX?=
 =?utf-8?B?OHAwUUtlUkNmZG50SzRkalF6Mm01YXkzSzBOaXhjUGFYbklYT2w0cDl4NDJM?=
 =?utf-8?B?WUJHTDErbytmN1I1TWp3VHJVUmQ2ZXFZc3pXM3N1OU5zaDVwQ1l1VVZCanZX?=
 =?utf-8?B?UDFrM0tORGMwVkZ0R2RCTmgyaEMzVHFOanpKejBBaDFIVTdjSHRyaWRNbDJ1?=
 =?utf-8?B?NTh2M01ubENORS9IeFFOREZYS05BcFJKRVR1bzdtTnpqeGNLK21aSDZ5V2dL?=
 =?utf-8?B?VGFFSXFMM3BpbGNKeHJiaGwrNGdtY3UxQzhJaGhJektlK1Z4czlNRnV0ODQ5?=
 =?utf-8?B?b2VnWDE4QWNDYURJVitoSVZFNHJrZFJscEx5eWpqU01NbEdDVHROd3pKSjVS?=
 =?utf-8?B?YXRodTY4bUJYODZVa0pQSnhyK1I5YkVaTEtGVFkyMW1UQWNxSmNseEtacEtP?=
 =?utf-8?B?RXQ2ejZkcGlZNndsRkZra0pMWEVLWEV2bGRoMURYWHI3R0hUTzR1ZlVidTM2?=
 =?utf-8?B?Q05JQUJHU1c1ZXhqQlZlcHo2NkE2bGRPTFliTURjWUNVdUdWNlAxNVZIVWJE?=
 =?utf-8?B?emwwa2NNVjlrbDJnejByK1FHQk9makV5ekVFR3d3K3h3WjhNMGZkYS81b3dp?=
 =?utf-8?B?ZlkwMU9nK0l0cnkzUE9mUkQxWjlVazJDeDlGbHhGLzNoM3BkY3g2SXZNTUwx?=
 =?utf-8?B?aGhlZFEwWkpyVDM4MFVqdjdxNkh4NE9VNUtvUE9pUTgxbUllL21mOWFpelBr?=
 =?utf-8?B?Q01nT0xFQzcxUjRQY2JEN3JzVkpLMDYzL09ZeElmTzVxNWFRSnpSMVFnU2V3?=
 =?utf-8?B?VHdGdFJHUzFuNmEwSmV1YVhLZ2FuZFN6MHhUWkRkdTFaeHhuNGllZE5XWEgz?=
 =?utf-8?B?cGY3Yi8xZ3ZIZUozM0crY1ROVmsrRms0Y1dubG1HVnNGVFpJWDJobU82NVhm?=
 =?utf-8?B?eUZBbWRSNlVVSW1XZGNkNHluejk3TVF6eGhxSUFvREpJUG9sRGhPU2liRm9J?=
 =?utf-8?Q?qjPHijFgPdYC2fMLPzihA14XY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb46401-3123-4ec1-87d8-08dc47596b0f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:40:55.5469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImLf/ANjUy+mLMVRJd2lbG9FzUeV+PqW7j4aWIyVFMDcyuyZKxPQa41ify6yzCVg3HG5Ork4mEOy61X+v/adPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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

--------------Ukjh3TptaLVNfTPBALm74rrN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The change you shared with me fixes the crash. Pl include in v8.


On 3/18/2024 10:06 AM, Sharma, Shashank wrote:
>
> [AMD Official Use Only - General]
>
>
> Already sent a NULL check patch based on this backtrace, I am waiting 
> for Rajneesh's feedback.
>
> Regards
> Shashank
> ------------------------------------------------------------------------
> *From:* Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
> *Sent:* Monday, March 18, 2024 3:04 PM
> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> *Subject:* Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with 
> tlb flush
>
> HI Shashank
>
> We'll probably need a v8 with the null pointer crash fixed i.e. before 
> freeing the PT entries check for a valid entry before calling 
> amdgpu_vm_pt_free. The crash is seen with device memory allocators but 
> the system memory allocators are looking fine.
>
> [  127.255863] [drm] Using MTYPE_RW for local memory
> [  333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock ulimits 
> for SHM_HUGETLB is obsolete
> [  415.351447] BUG: kernel NULL pointer dereference, address: 
> 0000000000000008
> [  415.359245] #PF: supervisor write access in kernel mode
> [  415.365081] #PF: error_code(0x0002) - not-present page
> [  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
> [  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: 
> G           OE 5.18.2-mi300-build-140423-ubuntu-22.04+ #24
> [  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS 
> RMO1001AS 02/21/2024
> [  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
> [  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 
> 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 
> 4c 89 ff <48
> > 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
> [  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
> [  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 
> 0000000000000000
> [  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: 
> ffff888161f80000
> [  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: 
> ffffc9000401fa00
> [  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: 
> ffffc9000401fb20
> [  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: 
> ffff888161f80000
> [  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) 
> knlGS:0000000000000000
> [  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 
> 0000000000770ef0
> [  415.499738] PKRU: 55555554
> [  415.502750] Call Trace:
> [  415.505482]  <TASK>
> [  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
> [  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
> [  415.519814] amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 
> [amdgpu]
> [  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
> [  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
> [  415.539324]  ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0 [amdgpu]
> [  415.545844]  ? __fget_light+0xc5/0x100
> [  415.550037]  __x64_sys_ioctl+0x91/0xc0
> [  415.554227]  do_syscall_64+0x5c/0x80
> [  415.558223]  ? debug_smp_processor_id+0x17/0x20
> [  415.563285]  ? fpregs_assert_state_consistent+0x23/0x60
> [  415.569124]  ? exit_to_user_mode_prepare+0x45/0x190
> [  415.574572]  ? ksys_write+0xce/0xe0
>
>
> On 3/18/2024 8:08 AM, Shashank Sharma wrote:
>
>     The idea behind this patch is to delay the freeing of PT entry
>     objects until the TLB flush is done. This patch: - Adds a
>     tlb_flush_waitlist in amdgpu_vm_update_params which will keep the
>     objects that need to be freed after tlb_flush. - Adds PT entries
>     in this list in amdgpu_vm_ptes_update after finding the PT entry.
>     - Changes functionality of amdgpu_vm_pt_free_dfs from (df_search +
>     free) to simply freeing of the BOs, also renames it to
>     amdgpu_vm_pt_free_list to reflect this same. - Exports function
>     amdgpu_vm_pt_free_list to be called directly. - Calls
>     amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range. V2:
>     rebase V4: Addressed review comments from Christian - add only
>     locked PTEs entries in TLB flush waitlist. - do not create a
>     separate function for list flush. - do not create a new lock for
>     TLB flush. - there is no need to wait on tlb_flush_fence
>     exclusively. V5: Addressed review comments from Christian - change
>     the amdgpu_vm_pt_free_dfs's functionality to simple freeing of the
>     objects and rename it. - add all the PTE objects in
>     params->tlb_flush_waitlist - let amdgpu_vm_pt_free_root handle the
>     freeing of BOs independently - call amdgpu_vm_pt_free_list
>     directly V6: Rebase V7: Rebase Cc: Christian König
>     <Christian.Koenig@amd.com> <mailto:Christian.Koenig@amd.com> Cc:
>     Alex Deucher <alexander.deucher@amd.com>
>     <mailto:alexander.deucher@amd.com> Cc: Felix Kuehling
>     <felix.kuehling@amd.com> <mailto:felix.kuehling@amd.com> Cc:
>     Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>     <mailto:rajneesh.bhardwaj@amd.com> Acked-by: Felix Kuehling
>     <felix.kuehling@amd.com> <mailto:felix.kuehling@amd.com> Acked-by:
>     Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>     <mailto:rajneesh.bhardwaj@amd.com> Tested-by: Rajneesh Bhardwaj
>     <rajneesh.bhardwaj@amd.com> <mailto:rajneesh.bhardwaj@amd.com>
>     Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>     <mailto:shashank.sharma@amd.com> ---
>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++-
>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 7 +++
>     drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53
>     +++++++++++++---------- 3 files changed, 40 insertions(+), 25
>     deletions(-) diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index
>     26f1c3359642..eaa402f99fe0 100644 ---
>     a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c +++
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c @@ -977,6 +977,7 @@ int
>     amdgpu_vm_update_range(struct amdgpu_device *adev, struct
>     amdgpu_vm *vm, params.unlocked = unlocked; params.needs_flush =
>     flush_tlb; params.allow_override = allow_override; +
>     INIT_LIST_HEAD(&params.tlb_flush_waitlist); /* Implicitly sync to
>     command submissions in the same VM before * unmapping. Sync to
>     moving fences before mapping. @@ -1062,8 +1063,10 @@ int
>     amdgpu_vm_update_range(struct amdgpu_device *adev, struct
>     amdgpu_vm *vm, if (r) goto error_unlock; - if (params.needs_flush)
>     + if (params.needs_flush) { r = amdgpu_vm_tlb_flush(&params,
>     fence); + amdgpu_vm_pt_free_list(adev, &params); + } error_unlock:
>     amdgpu_vm_eviction_unlock(vm); diff --git
>     a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index
>     b0a4fe683352..54d7da396de0 100644 ---
>     a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h +++
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h @@ -266,6 +266,11 @@
>     struct amdgpu_vm_update_params { * to be overridden for NUMA local
>     memory. */ bool allow_override; + + /** + * @tlb_flush_waitlist:
>     temporary storage for BOs until tlb_flush + */ + struct list_head
>     tlb_flush_waitlist; }; struct amdgpu_vm_update_funcs { @@ -547,6
>     +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params
>     *params, uint64_t start, uint64_t end, uint64_t dst, uint64_t
>     flags); void amdgpu_vm_pt_free_work(struct work_struct *work);
>     +void amdgpu_vm_pt_free_list(struct amdgpu_device *adev, + struct
>     amdgpu_vm_update_params *params); #if defined(CONFIG_DEBUG_FS)
>     void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct
>     seq_file *m); diff --git
>     a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
>     601df0ce8290..440dc8c581fc 100644 ---
>     a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c +++
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c @@ -622,40 +622,30 @@
>     void amdgpu_vm_pt_free_work(struct work_struct *work) } /** - *
>     amdgpu_vm_pt_free_dfs - free PD/PT levels + *
>     amdgpu_vm_pt_free_list - free PD/PT levels * * @adev: amdgpu
>     device structure - * @vm: amdgpu vm structure - * @start: optional
>     cursor where to start freeing PDs/PTs - * @unlocked: vm resv
>     unlock status + * @params: see amdgpu_vm_update_params definition
>     * - * Free the page directory or page table level and all sub
>     levels. + * Free the page directory objects saved in the flush
>     list */ -static void amdgpu_vm_pt_free_dfs(struct amdgpu_device
>     *adev, - struct amdgpu_vm *vm, - struct amdgpu_vm_pt_cursor
>     *start, - bool unlocked) +void amdgpu_vm_pt_free_list(struct
>     amdgpu_device *adev, + struct amdgpu_vm_update_params *params) { -
>     struct amdgpu_vm_pt_cursor cursor; - struct amdgpu_vm_bo_base
>     *entry; + struct amdgpu_vm_bo_base *entry, *next; + struct
>     amdgpu_vm *vm = params->vm; + bool unlocked = params->unlocked; if
>     (unlocked) { spin_lock(&vm->status_lock); -
>     for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) -
>     list_move(&entry->vm_status, &vm->pt_freed); - - if (start) -
>     list_move(&start->entry->vm_status, &vm->pt_freed); +
>     list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist);
>     spin_unlock(&vm->status_lock); schedule_work(&vm->pt_free_work);
>     return; } - for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start,
>     cursor, entry) + list_for_each_entry_safe(entry, next,
>     &params->tlb_flush_waitlist, vm_status) amdgpu_vm_pt_free(entry);
>     - - if (start) - amdgpu_vm_pt_free(start->entry); } /** @@ -667,7
>     +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device
>     *adev, */ void amdgpu_vm_pt_free_root(struct amdgpu_device *adev,
>     struct amdgpu_vm *vm) { - amdgpu_vm_pt_free_dfs(adev, vm, NULL,
>     false); + struct amdgpu_vm_pt_cursor cursor; + struct
>     amdgpu_vm_bo_base *entry; + + for_each_amdgpu_vm_pt_dfs_safe(adev,
>     vm, NULL, cursor, entry) + amdgpu_vm_pt_free(entry); } /** @@
>     -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct
>     amdgpu_vm_update_params *params, while (cursor.pfn < frag_start) {
>     /* Make sure previous mapping is freed */ if (cursor.entry->bo) {
>     + struct amdgpu_vm_pt_cursor seek; + struct amdgpu_vm_bo_base
>     *entry; + params->needs_flush = true; -
>     amdgpu_vm_pt_free_dfs(adev, params->vm, - &cursor, -
>     params->unlocked); + spin_lock(&params->vm->status_lock); +
>     for_each_amdgpu_vm_pt_dfs_safe(adev, params->vm, &cursor, + seek,
>     entry) { + list_move(&entry->vm_status, +
>     &params->tlb_flush_waitlist); + } + + /* enter start node now */ +
>     list_move(&cursor.entry->vm_status, +
>     &params->tlb_flush_waitlist); +
>     spin_unlock(&params->vm->status_lock); } amdgpu_vm_pt_next(adev,
>     &cursor); }
>
--------------Ukjh3TptaLVNfTPBALm74rrN
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>The change you shared with me fixes the crash. Pl include in v8.<br>
    </p>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/18/2024 10:06 AM, Sharma, Shashank
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MW4PR12MB56671969437D89CACEEF999EF22D2@MW4PR12MB5667.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Already sent a NULL check patch based on this backtrace, I am
          waiting for Rajneesh's feedback.&nbsp;&nbsp;</div>
        <div style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Regards</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
          Shashank</div>
        <hr style="display: inline-block; width: 98%;">
        <div dir="ltr" id="divRplyFwdMsg" style="color: inherit; background-color: inherit;">
          <span style="font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Bhardwaj,
            Rajneesh <a class="moz-txt-link-rfc2396E" href="mailto:Rajneesh.Bhardwaj@amd.com">&lt;Rajneesh.Bhardwaj@amd.com&gt;</a><br>
            <b>Sent:</b>&nbsp;Monday, March 18, 2024 3:04 PM<br>
            <b>To:</b>&nbsp;Sharma, Shashank <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b>&nbsp;Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Kuehling, Felix
            <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a><br>
            <b>Subject:</b>&nbsp;Re: [PATCH v7 2/2] drm/amdgpu: sync page
            table freeing with tlb flush</span>
          <div>&nbsp;</div>
        </div>
        <p>HI Shashank</p>
        <p>We'll probably need a v8 with the null pointer crash fixed
          i.e. before freeing the PT entries check for a valid entry
          before calling amdgpu_vm_pt_free. The crash is seen with
          device memory allocators but the system memory allocators are
          looking fine.</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
        <p>[&nbsp; 127.255863] [drm] Using MTYPE_RW for local memory<br>
          [&nbsp; 333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock
          ulimits for SHM_HUGETLB is obsolete<br>
          [&nbsp; 415.351447] BUG: kernel NULL pointer dereference, address:
          0000000000000008<br>
          [&nbsp; 415.359245] #PF: supervisor write access in kernel mode<br>
          [&nbsp; 415.365081] #PF: error_code(0x0002) - not-present page<br>
          [&nbsp; 415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0<br>
          [&nbsp; 415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI<br>
          [&nbsp; 415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e
          Tainted: G&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp;&nbsp;
          5.18.2-mi300-build-140423-ubuntu-22.04+ #24<br>
          [&nbsp; 415.394437] Hardware name: AMD Corporation Sh51p/Sh51p,
          BIOS RMO1001AS 02/21/2024<br>
          [&nbsp; 415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10
          [amdgpu]<br>
          [&nbsp; 415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85
          db 74 42 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18
          48 8d 75 b0 4c 89 ff &lt;48<br>
          &gt; 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c
          89 63<br>
          [&nbsp; 415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287<br>
          [&nbsp; 415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8
          RCX: 0000000000000000<br>
          [&nbsp; 415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30
          RDI: ffff888161f80000<br>
          [&nbsp; 415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000
          R09: ffffc9000401fa00<br>
          [&nbsp; 415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000
          R12: ffffc9000401fb20<br>
          [&nbsp; 415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0
          R15: ffff888161f80000<br>
          [&nbsp; 415.476312] FS:&nbsp; 00007f132ff89840(0000)
          GS:ffff889f87c00000(0000) knlGS:0000000000000000<br>
          [&nbsp; 415.485350] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0:
          0000000080050033<br>
          [&nbsp; 415.491767] CR2: 0000000000000008 CR3: 0000000161d46003
          CR4: 0000000000770ef0<br>
          [&nbsp; 415.499738] PKRU: 55555554<br>
          [&nbsp; 415.502750] Call Trace:<br>
          [&nbsp; 415.505482]&nbsp; &lt;TASK&gt;<br>
          [&nbsp; 415.507825]&nbsp; amdgpu_vm_update_range+0x32a/0x880 [amdgpu]<br>
          [&nbsp; 415.513869]&nbsp; amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]<br>
          [&nbsp; 415.519814]&nbsp;
          amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdgpu]<br>
          [&nbsp; 415.527729]&nbsp; kfd_ioctl_unmap_memory_from_gpu+0xed/0x340
          [amdgpu]<br>
          [&nbsp; 415.534551]&nbsp; kfd_ioctl+0x3b6/0x510 [amdgpu]<br>
          [&nbsp; 415.539324]&nbsp; ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0
          [amdgpu]<br>
          [&nbsp; 415.545844]&nbsp; ? __fget_light+0xc5/0x100<br>
          [&nbsp; 415.550037]&nbsp; __x64_sys_ioctl+0x91/0xc0<br>
          [&nbsp; 415.554227]&nbsp; do_syscall_64+0x5c/0x80<br>
          [&nbsp; 415.558223]&nbsp; ? debug_smp_processor_id+0x17/0x20<br>
          [&nbsp; 415.563285]&nbsp; ? fpregs_assert_state_consistent+0x23/0x60<br>
          [&nbsp; 415.569124]&nbsp; ? exit_to_user_mode_prepare+0x45/0x190<br>
          [&nbsp; 415.574572]&nbsp; ?
          ksys_write+0xce/0xe0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
        <p><br>
        </p>
        <p>On 3/18/2024 8:08 AM, Shashank Sharma wrote:</p>
        <blockquote>
          <pre><div>The idea behind this patch is to delay the freeing of PT entry objects
until the TLB flush is done.

This patch:
- Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will keep the
  objects that need to be freed after tlb_flush.
- Adds PT entries in this list in amdgpu_vm_ptes_update after finding
  the PT entry.
- Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)
  to simply freeing of the BOs, also renames it to
  amdgpu_vm_pt_free_list to reflect this same.
- Exports function amdgpu_vm_pt_free_list to be called directly.
- Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.

V2: rebase
V4: Addressed review comments from Christian
    - add only locked PTEs entries in TLB flush waitlist.
    - do not create a separate function for list flush.
    - do not create a new lock for TLB flush.
    - there is no need to wait on tlb_flush_fence exclusively.

V5: Addressed review comments from Christian
    - change the amdgpu_vm_pt_free_dfs's functionality to simple freeing
      of the objects and rename it.
    - add all the PTE objects in params-&gt;tlb_flush_waitlist
    - let amdgpu_vm_pt_free_root handle the freeing of BOs independently
    - call amdgpu_vm_pt_free_list directly

V6: Rebase
V7: Rebase

Cc: Christian König <a href="mailto:Christian.Koenig@amd.com" id="OWAe2a11fb1-18e0-f319-d80d-c378e055063c" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>
Cc: Alex Deucher <a href="mailto:alexander.deucher@amd.com" id="OWA404c8d81-801b-477c-c7f4-9fa179311f59" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a href="mailto:felix.kuehling@amd.com" id="OWA361739eb-d8ca-3054-e928-7e278c2e99ef" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a href="mailto:rajneesh.bhardwaj@amd.com" id="OWA9e2a4069-96f7-6ae6-91be-87c731cb149a" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Acked-by: Felix Kuehling <a href="mailto:felix.kuehling@amd.com" id="OWA99c70d11-0e88-66bc-5689-19da89d5454b" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a>
Acked-by: Rajneesh Bhardwaj <a href="mailto:rajneesh.bhardwaj@amd.com" id="OWAd8c39958-3757-1f7d-f6ad-a9e6e375fabf" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Tested-by: Rajneesh Bhardwaj <a href="mailto:rajneesh.bhardwaj@amd.com" id="OWA89a6bcc1-c33d-1497-b152-191e1cb7404b" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a href="mailto:shashank.sharma@amd.com" id="OWAa8513ec2-5ff2-499b-f596-fae49d213265" class="x_moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle="linkonly" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 26f1c3359642..eaa402f99fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.allow_override = allow_override;
+	INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_unlock;
 
-	if (params.needs_flush)
+	if (params.needs_flush) {
 		r = amdgpu_vm_tlb_flush(&amp;params, fence);
+		amdgpu_vm_pt_free_list(adev, &amp;params);
+	}
 
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b0a4fe683352..54d7da396de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
 	 * to be overridden for NUMA local memory.
 	 */
 	bool allow_override;
+
+	/**
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+	 */
+	struct list_head tlb_flush_waitlist;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 601df0ce8290..440dc8c581fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
 }
 
 /**
- * amdgpu_vm_pt_free_dfs - free PD/PT levels
+ * amdgpu_vm_pt_free_list - free PD/PT levels
  *
  * @adev: amdgpu device structure
- * @vm: amdgpu vm structure
- * @start: optional cursor where to start freeing PDs/PTs
- * @unlocked: vm resv unlock status
+ * @params: see amdgpu_vm_update_params definition
  *
- * Free the page directory or page table level and all sub levels.
+ * Free the page directory objects saved in the flush list
  */
-static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
-				  struct amdgpu_vm *vm,
-				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params)
 {
-	struct amdgpu_vm_pt_cursor cursor;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_bo_base *entry, *next;
+	struct amdgpu_vm *vm = params-&gt;vm;
+	bool unlocked = params-&gt;unlocked;
 
 	if (unlocked) {
 		spin_lock(&amp;vm-&gt;status_lock);
-		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-			list_move(&amp;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);
-
-		if (start)
-			list_move(&amp;start-&gt;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);
+		list_splice_init(&amp;vm-&gt;pt_freed, &amp;params-&gt;tlb_flush_waitlist);
 		spin_unlock(&amp;vm-&gt;status_lock);
 		schedule_work(&amp;vm-&gt;pt_free_work);
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+	list_for_each_entry_safe(entry, next, &amp;params-&gt;tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
-
-	if (start)
-		amdgpu_vm_pt_free(start-&gt;entry);
 }
 
 /**
@@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	struct amdgpu_vm_pt_cursor cursor;
+	struct amdgpu_vm_bo_base *entry;
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
+		amdgpu_vm_pt_free(entry);
 }
 
 /**
@@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn &lt; frag_start) {
 				/* Make sure previous mapping is freed */
 				if (cursor.entry-&gt;bo) {
+					struct amdgpu_vm_pt_cursor seek;
+					struct amdgpu_vm_bo_base *entry;
+
 					params-&gt;needs_flush = true;
-					amdgpu_vm_pt_free_dfs(adev, params-&gt;vm,
-							      &amp;cursor,
-							      params-&gt;unlocked);
+					spin_lock(&amp;params-&gt;vm-&gt;status_lock);
+					for_each_amdgpu_vm_pt_dfs_safe(adev, params-&gt;vm, &amp;cursor,
+								       seek, entry) {
+						list_move(&amp;entry-&gt;vm_status,
+							  &amp;params-&gt;tlb_flush_waitlist);
+					}
+
+					/* enter start node now */
+					list_move(&amp;cursor.entry-&gt;vm_status,
+						  &amp;params-&gt;tlb_flush_waitlist);
+					spin_unlock(&amp;params-&gt;vm-&gt;status_lock);
 				}
 				amdgpu_vm_pt_next(adev, &amp;cursor);
 			}
</div></pre>
        </blockquote>
      </div>
    </blockquote>
  </body>
</html>

--------------Ukjh3TptaLVNfTPBALm74rrN--
