Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8C6C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 14:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3A110F791;
	Mon, 18 Mar 2024 14:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BqcrqIfY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98D010F791
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 14:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liJlAwI7OfEIYg/D23VoKbt1dVFElU9POO6asyhRU+ilwTNSspuuLVFFfU1KtwiMRDM7J71vn6v1RMUNSxElTj8a5Pqg+srKwflgl52D5XLlY44IQAiApbRd1LE8LaDFvyQXe3RNP8WUexldOku1OW1vMBJsBvZJuUianz6eJoQxc/1Xoz8FjliduoEYIEA0/hD3Zvl2PYdIpM7rWVS2pE7gQM5yu4Bww0Ho7gDslF6ZQQ4IiZU3NvzVhojmTNPm8TjJ89BmWo1TP9B8ZlEwIXovVmdyXZPhiODf9C48vA1x72BljlBm5xPYgEr7DVMDnxL31l6kedOBDQqYC7+e4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIHvl/shOONcbJLOvk5bIxMOgTBnEQo39KVFNEjPwUA=;
 b=PZKnfobaHjw+9G9jeNflpCaGz+fzafbqm1UP2HonsFb4mnYa6xMGMS23vuC2MwPkY9ciupPx/SIAZU6x1u1kDyV+E5jI2v1On5ts2UPoI7Rm2ukL6CyY2ndxKftQYhvMJUazn+EgCptmPTHUOGBXQlkZTAJzd0ujGOlqV6JLJB5HvHVoAyh2KMIKjCcXWLk68a/Cf/Wo22XXIQcTMCqlumE8O2PXfypbQwqutRaKGOunBjZCDPnVQPDlJryEAUmYvJIsOLn7NioHbNNr5upaGSI7gGgnbqPfXRHa8O/Lwp7tPYtIkpDPxdrCB5Ggb+/dkehjfkBVRIG8oUxPyNPSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIHvl/shOONcbJLOvk5bIxMOgTBnEQo39KVFNEjPwUA=;
 b=BqcrqIfY+1YLswc23mot2RHqTWN0LR+YdECU+mdGOedQfNx3wGXpna8lvPgVGC8vsXCrDTtRf2+p33GcWiC+I/N4saQI5CEdO9zS+TxVcWy8pwA9Ch8aewvY30iv0/WfD9m3lgEvFs8BB/Lwuz7Q9JZ3+bJlCxHHax6ExIT76n8=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 14:06:47 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:06:47 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: "Bhardwaj, Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb flush
Thread-Topic: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb flush
Thread-Index: AQHaeS0VIkOrZUuisU+DdHW4x8D7lLE9h/yAgAAAWnY=
Date: Mon, 18 Mar 2024 14:06:47 +0000
Message-ID: <MW4PR12MB56671969437D89CACEEF999EF22D2@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20240318120837.2011-1-shashank.sharma@amd.com>
 <20240318120837.2011-2-shashank.sharma@amd.com>
 <0e729b5c-818e-495f-a479-b48c3177094a@amd.com>
In-Reply-To: <0e729b5c-818e-495f-a479-b48c3177094a@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T14:06:46.719Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|CH2PR12MB4277:EE_
x-ms-office365-filtering-correlation-id: 7df22d22-1cdd-4fa1-7911-08dc4754a63b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tva8QbTJsNPgqCkpkl1fCarV+hUhW4BnXCuZ4Wv/iFbDDWSYCsSxL9bptgiyCKr7sHPDesIqnFW6GeOPD3y2ks0g5wDpPhEVjfzhnTgBX+DDPwfJY7ZLmldkxUQBTqsjkHxM2MPeH7jnjDtRFYU7svg4VzMsVgO0j043nGdNcQaY2ne97EYPuiwufictcoOEwWU5+aWQAMk1p64V5UI+wbz+q5H4RU/ntdczUL8xfLrgi4Pl8FB7Q5cOaTJjuCq9vVz6uZwjH5HQwQuGKDD+Ud8J8QTWvZ3DH4gs49yMrtTY+p04ca3yOoIbE2g56VkSlquEXikvbuNqJx1lY5pTNfLWdI6U+7WDGahyRfCo5ICJdUGRogHY8wu2lAfkCW8mTX8mbvYx/uPdWQfwufXCibyX1mbHQpazFbuxzdEJzLP8frEmfEfLjtT6lpciKI+jFsxvUBl9bQ2bagdKtt8xuaqQfWGIbGJoHhvhjfxc2LBmkS4lgApwwWshmJoloA6uYXdgBiWMt+HCvqnc3TZ1fLPwqBYrjH/hIbA48fZ/qNWwS9N8VKgH/ULxCNcyzZToOcLi/hEhaJfQKPuUks4mtWkgT/q6rR9061xRdW1Oz89HHJ08w8SDaCihxUT3U+p76OZ4cHoyewB8+w1fFKtiHH1OrXaC06GUsWWLSqkYGvWztWn+J13CBx1N0joXDMYJMtG0JmyopbKOu25LR+BovQp8rjgRs/ndEJr9aJUCzg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7m0aUHmgpvC9tDtvC2tcPUcAJTKexmdAQ1vmu2kdEmLXwSlAePGHzlfrfS?=
 =?iso-8859-1?Q?aF9xrpV02h7aT6Mjj2Pao4qttRQUae5oZ7yAUgKJXkcIvKH0AVcUtufsUk?=
 =?iso-8859-1?Q?aQMYiBZ4yoeDqBUFUegcjJ7tWgDj1UmxWKNlniKMa1d0DvMOssIqc4jB/3?=
 =?iso-8859-1?Q?V9uuALMQY7Ovc5XcycWpnYPRbh7+WCOT0/h9N53Jtq66OiBYv1XhwuiE2z?=
 =?iso-8859-1?Q?zoWuJN7QG3JVvEgTUuc+o8FPW0BT/CSqGBZUX7k/N4KGxcxwAn97W5IJIq?=
 =?iso-8859-1?Q?hi8Nzq6QLtHw1VzwTDTjXKo69bBFzpV22xSnGtCn0IuQ2eUhCVUaqSxjMc?=
 =?iso-8859-1?Q?rg4ICkxpvEKW3cmShxhs8UWpCeKz7iu39ghTnLuytHQ+Vr9L6H+OILbJha?=
 =?iso-8859-1?Q?w9KP+CTe5lZpD1f4AB77NvAyvM9BPqVtFifucqDyk1DD8vuGZBq1/4SE82?=
 =?iso-8859-1?Q?k1MfJGgcmiV53ycXeVREF+BgVSKwpcUUZHIaWgmw6sINQ5A8NwZwxgY/Rx?=
 =?iso-8859-1?Q?dsZ+NGe5Yb/Bs1slfd2XIVAee3KDvWR10ztNb9/zW34iCHgb0ezfBn3ruW?=
 =?iso-8859-1?Q?c/5qdWgkMbdeE1ru1U3Sw55tfDHKMxSV+ouSp2g04qb6iXT3sz6IUxAQAD?=
 =?iso-8859-1?Q?iqSkS+hkJSy3XzdYc1pDEsKUhJfWkLtTi3CVWiWabCshn5RHWlTnYKBXC6?=
 =?iso-8859-1?Q?R8iClq+Sl8KNRQ5W3sahZtHR0fpR0p0OfHhmnbTtXJdF42o5x2vprZYaIZ?=
 =?iso-8859-1?Q?12NGKZrxVjgtZM4NpD2p43ODH4onZYTyhP1kB6hvmwmsWlzx/1PdfiC5hc?=
 =?iso-8859-1?Q?eJB6rMabocDvLLrdofR0UVFQNsltS6//tU4qXEdx9nMLh0Fn75lUePe78g?=
 =?iso-8859-1?Q?gihuYgL2hh2WCl67Pe6pTI1i3oV+SN8qe7EacZ2NMhvDBTQWCjtItVEsqm?=
 =?iso-8859-1?Q?qK/kRUwNiYJFFanALynUiNTHVEa11E7o/IAHfaiLfraayxRQVZP6ir5xsD?=
 =?iso-8859-1?Q?ojTRjyjxYWLiFSB0FWmRxuwjiFWwFLD9FflHaF9Hf3zuCMLad/JfDQ0kKg?=
 =?iso-8859-1?Q?qqgrmuZIg3B/Q7ql+fNxbdczSabpfXtQurZNWfwrj+Sb8yTVzssJ4s8hvC?=
 =?iso-8859-1?Q?LaOuS5ssAmtd3Npq/fjAK6jnh3ej5YVF40GC9U0gctkPVlEhN6KDiS4zS9?=
 =?iso-8859-1?Q?ppbPvbBoJmR8Pg00RVlBun36PwDHkfyOM7r0oItFig9XT7kQEl5vFqlRXR?=
 =?iso-8859-1?Q?IpV81+RCVwUDGURvRhDzowZcE8zTFhGgYV3DW4wAt2rF8pbOilD9r4YDrg?=
 =?iso-8859-1?Q?xxyx/p8Lrh1QoF4en4rW2kGvh/S1VIcYIYR8BltYmIT002wsZQmNBH+7om?=
 =?iso-8859-1?Q?r0ZBB55oMSKEhlshEnhR0grVl0OQhHH5clgHqYbZ+Dh4rUdvO7OFa6DJ8k?=
 =?iso-8859-1?Q?xe1i22tD2Q1nrAar/bh6iU++pf6X5a05EmM2AqBb/LBgjIDnWX18WS9mfq?=
 =?iso-8859-1?Q?nvcmiUVModtI2NfJaRBkbUa7kd3mIH/0lNXGZuuLtP+dENA8rffCW59Bes?=
 =?iso-8859-1?Q?gLETqSZ0slyvKgJ5sOIqQvpkD9d+98dYj+7df+JSa7AE+W6wx/lT9wiBR2?=
 =?iso-8859-1?Q?5eQrii/yfAJLI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MW4PR12MB56671969437D89CACEEF999EF22D2MW4PR12MB5667namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df22d22-1cdd-4fa1-7911-08dc4754a63b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 14:06:47.1204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+TFWNrgEOV4/uydn+bAUWJP0wXHPxz3e2cF4PwKq+r8l1lsJPz2hMUwpY/AOogGlrpYM/W6mUpUpXts7OqE2g==
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

--_000_MW4PR12MB56671969437D89CACEEF999EF22D2MW4PR12MB5667namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Already sent a NULL check patch based on this backtrace, I am waiting for R=
ajneesh's feedback.

Regards
Shashank
________________________________
From: Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>
Sent: Monday, March 18, 2024 3:04 PM
To: Sharma, Shashank <Shashank.Sharma@amd.com>; amd-gfx@lists.freedesktop.o=
rg <amd-gfx@lists.freedesktop.org>
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing with tlb fl=
ush


HI Shashank

We'll probably need a v8 with the null pointer crash fixed i.e. before free=
ing the PT entries check for a valid entry before calling amdgpu_vm_pt_free=
. The crash is seen with device memory allocators but the system memory all=
ocators are looking fine.



[  127.255863] [drm] Using MTYPE_RW for local memory
[  333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock ulimits for =
SHM_HUGETLB is obsolete
[  415.351447] BUG: kernel NULL pointer dereference, address: 0000000000000=
008
[  415.359245] #PF: supervisor write access in kernel mode
[  415.365081] #PF: error_code(0x0002) - not-present page
[  415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0
[  415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI
[  415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: G          =
 OE     5.18.2-mi300-build-140423-ubuntu-22.04+ #24
[  415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS RMO1001AS 0=
2/21/2024
[  415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]
[  415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 42 48 =
39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 4c 89 ff <48
> 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63
[  415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287
[  415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 00000000000=
00000
[  415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: ffff888161f=
80000
[  415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: ffffc900040=
1fa00
[  415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: ffffc900040=
1fb20
[  415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: ffff888161f=
80000
[  415.476312] FS:  00007f132ff89840(0000) GS:ffff889f87c00000(0000) knlGS:=
0000000000000000
[  415.485350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 00000000007=
70ef0
[  415.499738] PKRU: 55555554
[  415.502750] Call Trace:
[  415.505482]  <TASK>
[  415.507825]  amdgpu_vm_update_range+0x32a/0x880 [amdgpu]
[  415.513869]  amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]
[  415.519814]  amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0x250 [amdg=
pu]
[  415.527729]  kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgpu]
[  415.534551]  kfd_ioctl+0x3b6/0x510 [amdgpu]
[  415.539324]  ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0 [amdgpu]
[  415.545844]  ? __fget_light+0xc5/0x100
[  415.550037]  __x64_sys_ioctl+0x91/0xc0
[  415.554227]  do_syscall_64+0x5c/0x80
[  415.558223]  ? debug_smp_processor_id+0x17/0x20
[  415.563285]  ? fpregs_assert_state_consistent+0x23/0x60
[  415.569124]  ? exit_to_user_mode_prepare+0x45/0x190
[  415.574572]  ? ksys_write+0xce/0xe0




On 3/18/2024 8:08 AM, Shashank Sharma wrote:

The idea behind this patch is to delay the freeing of PT entry objects
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
    - add all the PTE objects in params->tlb_flush_waitlist
    - let amdgpu_vm_pt_free_root handle the freeing of BOs independently
    - call amdgpu_vm_pt_free_list directly

V6: Rebase
V7: Rebase

Cc: Christian K=F6nig <Christian.Koenig@amd.com><mailto:Christian.Koenig@am=
d.com>
Cc: Alex Deucher <alexander.deucher@amd.com><mailto:alexander.deucher@amd.c=
om>
Cc: Felix Kuehling <felix.kuehling@amd.com><mailto:felix.kuehling@amd.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com><mailto:rajneesh.bhardwaj@=
amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com><mailto:felix.kuehling@amd=
.com>
Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com><mailto:rajneesh.bha=
rdwaj@amd.com>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com><mailto:rajneesh.bh=
ardwaj@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com><mailto:shashank.sh=
arma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 26f1c3359642..eaa402f99fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,
        params.unlocked =3D unlocked;
        params.needs_flush =3D flush_tlb;
        params.allow_override =3D allow_override;
+       INIT_LIST_HEAD(&params.tlb_flush_waitlist);

        /* Implicitly sync to command submissions in the same VM before
         * unmapping. Sync to moving fences before mapping.
@@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
        if (r)
                goto error_unlock;

-       if (params.needs_flush)
+       if (params.needs_flush) {
                r =3D amdgpu_vm_tlb_flush(&params, fence);
+               amdgpu_vm_pt_free_list(adev, &params);
+       }

 error_unlock:
        amdgpu_vm_eviction_unlock(vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.h
index b0a4fe683352..54d7da396de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {
         * to be overridden for NUMA local memory.
         */
        bool allow_override;
+
+       /**
+        * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+        */
+       struct list_head tlb_flush_waitlist;
 };

 struct amdgpu_vm_update_funcs {
@@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_param=
s *params,
                          uint64_t start, uint64_t end,
                          uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+                           struct amdgpu_vm_update_params *params);

 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c
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
-                                 struct amdgpu_vm *vm,
-                                 struct amdgpu_vm_pt_cursor *start,
-                                 bool unlocked)
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+                           struct amdgpu_vm_update_params *params)
 {
-       struct amdgpu_vm_pt_cursor cursor;
-       struct amdgpu_vm_bo_base *entry;
+       struct amdgpu_vm_bo_base *entry, *next;
+       struct amdgpu_vm *vm =3D params->vm;
+       bool unlocked =3D params->unlocked;

        if (unlocked) {
                spin_lock(&vm->status_lock);
-               for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, ent=
ry)
-                       list_move(&entry->vm_status, &vm->pt_freed);
-
-               if (start)
-                       list_move(&start->entry->vm_status, &vm->pt_freed);
+               list_splice_init(&vm->pt_freed, &params->tlb_flush_waitlist=
);
                spin_unlock(&vm->status_lock);
                schedule_work(&vm->pt_free_work);
                return;
        }

-       for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
+       list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, =
vm_status)
                amdgpu_vm_pt_free(entry);
-
-       if (start)
-               amdgpu_vm_pt_free(start->entry);
 }

 /**
@@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device=
 *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *=
vm)
 {
-       amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+       struct amdgpu_vm_pt_cursor cursor;
+       struct amdgpu_vm_bo_base *entry;
+
+       for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
+               amdgpu_vm_pt_free(entry);
 }

 /**
@@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams *params,
                        while (cursor.pfn < frag_start) {
                                /* Make sure previous mapping is freed */
                                if (cursor.entry->bo) {
+                                       struct amdgpu_vm_pt_cursor seek;
+                                       struct amdgpu_vm_bo_base *entry;
+
                                        params->needs_flush =3D true;
-                                       amdgpu_vm_pt_free_dfs(adev, params-=
>vm,
-                                                             &cursor,
-                                                             params->unloc=
ked);
+                                       spin_lock(&params->vm->status_lock)=
;
+                                       for_each_amdgpu_vm_pt_dfs_safe(adev=
, params->vm, &cursor,
+                                                                      seek=
, entry) {
+                                               list_move(&entry->vm_status=
,
+                                                         &params->tlb_flus=
h_waitlist);
+                                       }
+
+                                       /* enter start node now */
+                                       list_move(&cursor.entry->vm_status,
+                                                 &params->tlb_flush_waitli=
st);
+                                       spin_unlock(&params->vm->status_loc=
k);
                                }
                                amdgpu_vm_pt_next(adev, &cursor);
                        }


--_000_MW4PR12MB56671969437D89CACEEF999EF22D2MW4PR12MB5667namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Already sent a NULL check patch based on this backtrace, I am waiting for R=
ajneesh's feedback.&nbsp;&nbsp;</div>
<div id=3D"appendonsend" style=3D"color: inherit; background-color: inherit=
;"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Regards</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Shashank</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg" style=3D"color: inherit; background-c=
olor: inherit;">
<span style=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rg=
b(0, 0, 0);"><b>From:</b>&nbsp;Bhardwaj, Rajneesh &lt;Rajneesh.Bhardwaj@amd=
.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, March 18, 2024 3:04 PM<br>
<b>To:</b>&nbsp;Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;; amd-gfx@l=
ists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Deucher=
, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &lt;Felix.Ku=
ehling@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v7 2/2] drm/amdgpu: sync page table freeing=
 with tlb flush</span>
<div>&nbsp;</div>
</div>
<p>HI Shashank</p>
<p>We'll probably need a v8 with the null pointer crash fixed i.e. before f=
reeing the PT entries check for a valid entry before calling amdgpu_vm_pt_f=
ree. The crash is seen with device memory allocators but the system memory =
allocators are looking fine.</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>[&nbsp; 127.255863] [drm] Using MTYPE_RW for local memory<br>
[&nbsp; 333.606136] hugetlbfs: test_with_MPI.e (25268): Using mlock ulimits=
 for SHM_HUGETLB is obsolete<br>
[&nbsp; 415.351447] BUG: kernel NULL pointer dereference, address: 00000000=
00000008<br>
[&nbsp; 415.359245] #PF: supervisor write access in kernel mode<br>
[&nbsp; 415.365081] #PF: error_code(0x0002) - not-present page<br>
[&nbsp; 415.370817] PGD 101259067 P4D 101259067 PUD 10125a067 PMD 0<br>
[&nbsp; 415.377140] Oops: 0002 [#1] PREEMPT SMP NOPTI<br>
[&nbsp; 415.382004] CPU: 0 PID: 25481 Comm: test_with_MPI.e Tainted: G&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OE&nbsp;&nbsp;&nbsp=
;&nbsp; 5.18.2-mi300-build-140423-ubuntu-22.04+ #24<br>
[&nbsp; 415.394437] Hardware name: AMD Corporation Sh51p/Sh51p, BIOS RMO100=
1AS 02/21/2024<br>
[&nbsp; 415.402797] RIP: 0010:amdgpu_vm_ptes_update+0x6fd/0xa10 [amdgpu]<br=
>
[&nbsp; 415.409648] Code: 4c 89 ff 4d 8d 66 30 e8 f1 ed ff ff 48 85 db 74 4=
2 48 39 5d a0 74 40 48 8b 53 20 48 8b 4b 18 48 8d 43 18 48 8d 75 b0 4c 89 f=
f &lt;48<br>
&gt; 89 51 08 48 89 0a 49 8b 56 30 48 89 42 08 48 89 53 18 4c 89 63<br>
[&nbsp; 415.430621] RSP: 0018:ffffc9000401f990 EFLAGS: 00010287<br>
[&nbsp; 415.436456] RAX: ffff888147bb82f0 RBX: ffff888147bb82d8 RCX: 000000=
0000000000<br>
[&nbsp; 415.444426] RDX: 0000000000000000 RSI: ffffc9000401fa30 RDI: ffff88=
8161f80000<br>
[&nbsp; 415.452397] RBP: ffffc9000401fa80 R08: 0000000000000000 R09: ffffc9=
000401fa00<br>
[&nbsp; 415.460368] R10: 00000007f0cc0000 R11: 00000007f0c85000 R12: ffffc9=
000401fb20<br>
[&nbsp; 415.468340] R13: 00000007f0d00000 R14: ffffc9000401faf0 R15: ffff88=
8161f80000<br>
[&nbsp; 415.476312] FS:&nbsp; 00007f132ff89840(0000) GS:ffff889f87c00000(00=
00) knlGS:0000000000000000<br>
[&nbsp; 415.485350] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<=
br>
[&nbsp; 415.491767] CR2: 0000000000000008 CR3: 0000000161d46003 CR4: 000000=
0000770ef0<br>
[&nbsp; 415.499738] PKRU: 55555554<br>
[&nbsp; 415.502750] Call Trace:<br>
[&nbsp; 415.505482]&nbsp; &lt;TASK&gt;<br>
[&nbsp; 415.507825]&nbsp; amdgpu_vm_update_range+0x32a/0x880 [amdgpu]<br>
[&nbsp; 415.513869]&nbsp; amdgpu_vm_clear_freed+0x117/0x250 [amdgpu]<br>
[&nbsp; 415.519814]&nbsp; amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu+0x18c/0=
x250 [amdgpu]<br>
[&nbsp; 415.527729]&nbsp; kfd_ioctl_unmap_memory_from_gpu+0xed/0x340 [amdgp=
u]<br>
[&nbsp; 415.534551]&nbsp; kfd_ioctl+0x3b6/0x510 [amdgpu]<br>
[&nbsp; 415.539324]&nbsp; ? kfd_ioctl_get_dmabuf_info+0x1d0/0x1d0 [amdgpu]<=
br>
[&nbsp; 415.545844]&nbsp; ? __fget_light+0xc5/0x100<br>
[&nbsp; 415.550037]&nbsp; __x64_sys_ioctl+0x91/0xc0<br>
[&nbsp; 415.554227]&nbsp; do_syscall_64+0x5c/0x80<br>
[&nbsp; 415.558223]&nbsp; ? debug_smp_processor_id+0x17/0x20<br>
[&nbsp; 415.563285]&nbsp; ? fpregs_assert_state_consistent+0x23/0x60<br>
[&nbsp; 415.569124]&nbsp; ? exit_to_user_mode_prepare+0x45/0x190<br>
[&nbsp; 415.574572]&nbsp; ? ksys_write+0xce/0xe0&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
<p><br>
</p>
<p>On 3/18/2024 8:08 AM, Shashank Sharma wrote:</p>
<blockquote>
<pre><div>The idea behind this patch is to delay the freeing of PT entry ob=
jects=0A=
until the TLB flush is done.=0A=
=0A=
This patch:=0A=
- Adds a tlb_flush_waitlist in amdgpu_vm_update_params which will keep the=
=0A=
  objects that need to be freed after tlb_flush.=0A=
- Adds PT entries in this list in amdgpu_vm_ptes_update after finding=0A=
  the PT entry.=0A=
- Changes functionality of amdgpu_vm_pt_free_dfs from (df_search + free)=0A=
  to simply freeing of the BOs, also renames it to=0A=
  amdgpu_vm_pt_free_list to reflect this same.=0A=
- Exports function amdgpu_vm_pt_free_list to be called directly.=0A=
- Calls amdgpu_vm_pt_free_list directly from amdgpu_vm_update_range.=0A=
=0A=
V2: rebase=0A=
V4: Addressed review comments from Christian=0A=
    - add only locked PTEs entries in TLB flush waitlist.=0A=
    - do not create a separate function for list flush.=0A=
    - do not create a new lock for TLB flush.=0A=
    - there is no need to wait on tlb_flush_fence exclusively.=0A=
=0A=
V5: Addressed review comments from Christian=0A=
    - change the amdgpu_vm_pt_free_dfs's functionality to simple freeing=0A=
      of the objects and rename it.=0A=
    - add all the PTE objects in params-&gt;tlb_flush_waitlist=0A=
    - let amdgpu_vm_pt_free_root handle the freeing of BOs independently=0A=
    - call amdgpu_vm_pt_free_list directly=0A=
=0A=
V6: Rebase=0A=
V7: Rebase=0A=
=0A=
Cc: Christian K=F6nig <a href=3D"mailto:Christian.Koenig@amd.com" id=3D"OWA=
e2a11fb1-18e0-f319-d80d-c378e055063c" class=3D"x_moz-txt-link-rfc2396E OWAA=
utoLink" data-loopstyle=3D"linkonly">&lt;Christian.Koenig@amd.com&gt;</a>=
=0A=
Cc: Alex Deucher <a href=3D"mailto:alexander.deucher@amd.com" id=3D"OWA404c=
8d81-801b-477c-c7f4-9fa179311f59" class=3D"x_moz-txt-link-rfc2396E OWAAutoL=
ink" data-loopstyle=3D"linkonly">&lt;alexander.deucher@amd.com&gt;</a>=0A=
Cc: Felix Kuehling <a href=3D"mailto:felix.kuehling@amd.com" id=3D"OWA36173=
9eb-d8ca-3054-e928-7e278c2e99ef" class=3D"x_moz-txt-link-rfc2396E OWAAutoLi=
nk" data-loopstyle=3D"linkonly">&lt;felix.kuehling@amd.com&gt;</a>=0A=
Cc: Rajneesh Bhardwaj <a href=3D"mailto:rajneesh.bhardwaj@amd.com" id=3D"OW=
A9e2a4069-96f7-6ae6-91be-87c731cb149a" class=3D"x_moz-txt-link-rfc2396E OWA=
AutoLink" data-loopstyle=3D"linkonly">&lt;rajneesh.bhardwaj@amd.com&gt;</a>=
=0A=
Acked-by: Felix Kuehling <a href=3D"mailto:felix.kuehling@amd.com" id=3D"OW=
A99c70d11-0e88-66bc-5689-19da89d5454b" class=3D"x_moz-txt-link-rfc2396E OWA=
AutoLink" data-loopstyle=3D"linkonly">&lt;felix.kuehling@amd.com&gt;</a>=0A=
Acked-by: Rajneesh Bhardwaj <a href=3D"mailto:rajneesh.bhardwaj@amd.com" id=
=3D"OWAd8c39958-3757-1f7d-f6ad-a9e6e375fabf" class=3D"x_moz-txt-link-rfc239=
6E OWAAutoLink" data-loopstyle=3D"linkonly">&lt;rajneesh.bhardwaj@amd.com&g=
t;</a>=0A=
Tested-by: Rajneesh Bhardwaj <a href=3D"mailto:rajneesh.bhardwaj@amd.com" i=
d=3D"OWA89a6bcc1-c33d-1497-b152-191e1cb7404b" class=3D"x_moz-txt-link-rfc23=
96E OWAAutoLink" data-loopstyle=3D"linkonly">&lt;rajneesh.bhardwaj@amd.com&=
gt;</a>=0A=
Signed-off-by: Shashank Sharma <a href=3D"mailto:shashank.sharma@amd.com" i=
d=3D"OWAa8513ec2-5ff2-499b-f596-fae49d213265" class=3D"x_moz-txt-link-rfc23=
96E OWAAutoLink" data-loopstyle=3D"linkonly">&lt;shashank.sharma@amd.com&gt=
;</a>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++-=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  7 +++=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 53 +++++++++++++----------=0A=
 3 files changed, 40 insertions(+), 25 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c=0A=
index 26f1c3359642..eaa402f99fe0 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=0A=
@@ -977,6 +977,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, =
struct amdgpu_vm *vm,=0A=
 	params.unlocked =3D unlocked;=0A=
 	params.needs_flush =3D flush_tlb;=0A=
 	params.allow_override =3D allow_override;=0A=
+	INIT_LIST_HEAD(&amp;params.tlb_flush_waitlist);=0A=
 =0A=
 	/* Implicitly sync to command submissions in the same VM before=0A=
 	 * unmapping. Sync to moving fences before mapping.=0A=
@@ -1062,8 +1063,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,=0A=
 	if (r)=0A=
 		goto error_unlock;=0A=
 =0A=
-	if (params.needs_flush)=0A=
+	if (params.needs_flush) {=0A=
 		r =3D amdgpu_vm_tlb_flush(&amp;params, fence);=0A=
+		amdgpu_vm_pt_free_list(adev, &amp;params);=0A=
+	}=0A=
 =0A=
 error_unlock:=0A=
 	amdgpu_vm_eviction_unlock(vm);=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.h=0A=
index b0a4fe683352..54d7da396de0 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h=0A=
@@ -266,6 +266,11 @@ struct amdgpu_vm_update_params {=0A=
 	 * to be overridden for NUMA local memory.=0A=
 	 */=0A=
 	bool allow_override;=0A=
+=0A=
+	/**=0A=
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush=0A=
+	 */=0A=
+	struct list_head tlb_flush_waitlist;=0A=
 };=0A=
 =0A=
 struct amdgpu_vm_update_funcs {=0A=
@@ -547,6 +552,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_param=
s *params,=0A=
 			  uint64_t start, uint64_t end,=0A=
 			  uint64_t dst, uint64_t flags);=0A=
 void amdgpu_vm_pt_free_work(struct work_struct *work);=0A=
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,=0A=
+			    struct amdgpu_vm_update_params *params);=0A=
 =0A=
 #if defined(CONFIG_DEBUG_FS)=0A=
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vm_pt.c=0A=
index 601df0ce8290..440dc8c581fc 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c=0A=
@@ -622,40 +622,30 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)=
=0A=
 }=0A=
 =0A=
 /**=0A=
- * amdgpu_vm_pt_free_dfs - free PD/PT levels=0A=
+ * amdgpu_vm_pt_free_list - free PD/PT levels=0A=
  *=0A=
  * @adev: amdgpu device structure=0A=
- * @vm: amdgpu vm structure=0A=
- * @start: optional cursor where to start freeing PDs/PTs=0A=
- * @unlocked: vm resv unlock status=0A=
+ * @params: see amdgpu_vm_update_params definition=0A=
  *=0A=
- * Free the page directory or page table level and all sub levels.=0A=
+ * Free the page directory objects saved in the flush list=0A=
  */=0A=
-static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,=0A=
-				  struct amdgpu_vm *vm,=0A=
-				  struct amdgpu_vm_pt_cursor *start,=0A=
-				  bool unlocked)=0A=
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,=0A=
+			    struct amdgpu_vm_update_params *params)=0A=
 {=0A=
-	struct amdgpu_vm_pt_cursor cursor;=0A=
-	struct amdgpu_vm_bo_base *entry;=0A=
+	struct amdgpu_vm_bo_base *entry, *next;=0A=
+	struct amdgpu_vm *vm =3D params-&gt;vm;=0A=
+	bool unlocked =3D params-&gt;unlocked;=0A=
 =0A=
 	if (unlocked) {=0A=
 		spin_lock(&amp;vm-&gt;status_lock);=0A=
-		for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)=0A=
-			list_move(&amp;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);=0A=
-=0A=
-		if (start)=0A=
-			list_move(&amp;start-&gt;entry-&gt;vm_status, &amp;vm-&gt;pt_freed);=0A=
+		list_splice_init(&amp;vm-&gt;pt_freed, &amp;params-&gt;tlb_flush_waitlis=
t);=0A=
 		spin_unlock(&amp;vm-&gt;status_lock);=0A=
 		schedule_work(&amp;vm-&gt;pt_free_work);=0A=
 		return;=0A=
 	}=0A=
 =0A=
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)=0A=
+	list_for_each_entry_safe(entry, next, &amp;params-&gt;tlb_flush_waitlist,=
 vm_status)=0A=
 		amdgpu_vm_pt_free(entry);=0A=
-=0A=
-	if (start)=0A=
-		amdgpu_vm_pt_free(start-&gt;entry);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -667,7 +657,11 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device=
 *adev,=0A=
  */=0A=
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *=
vm)=0A=
 {=0A=
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);=0A=
+	struct amdgpu_vm_pt_cursor cursor;=0A=
+	struct amdgpu_vm_bo_base *entry;=0A=
+=0A=
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)=0A=
+		amdgpu_vm_pt_free(entry);=0A=
 }=0A=
 =0A=
 /**=0A=
@@ -972,10 +966,21 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams *params,=0A=
 			while (cursor.pfn &lt; frag_start) {=0A=
 				/* Make sure previous mapping is freed */=0A=
 				if (cursor.entry-&gt;bo) {=0A=
+					struct amdgpu_vm_pt_cursor seek;=0A=
+					struct amdgpu_vm_bo_base *entry;=0A=
+=0A=
 					params-&gt;needs_flush =3D true;=0A=
-					amdgpu_vm_pt_free_dfs(adev, params-&gt;vm,=0A=
-							      &amp;cursor,=0A=
-							      params-&gt;unlocked);=0A=
+					spin_lock(&amp;params-&gt;vm-&gt;status_lock);=0A=
+					for_each_amdgpu_vm_pt_dfs_safe(adev, params-&gt;vm, &amp;cursor,=0A=
+								       seek, entry) {=0A=
+						list_move(&amp;entry-&gt;vm_status,=0A=
+							  &amp;params-&gt;tlb_flush_waitlist);=0A=
+					}=0A=
+=0A=
+					/* enter start node now */=0A=
+					list_move(&amp;cursor.entry-&gt;vm_status,=0A=
+						  &amp;params-&gt;tlb_flush_waitlist);=0A=
+					spin_unlock(&amp;params-&gt;vm-&gt;status_lock);=0A=
 				}=0A=
 				amdgpu_vm_pt_next(adev, &amp;cursor);=0A=
 			}=0A=
</div></pre>
</blockquote>
</div>
</body>
</html>

--_000_MW4PR12MB56671969437D89CACEEF999EF22D2MW4PR12MB5667namp_--
