Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66460C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF1CD10E03F;
	Fri, 11 Aug 2023 21:12:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A11D910E03F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:12:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkushwClPG3V5er/ckuJsBHmn/HJ5mu9PSo1X4odC9kOQQTrDxMvrAYy3wzwydq+/8L794f8IIkmcUnfozoHwHZgxdMSn4pLerQT5p6UxtcRW3M8HHDIptB4mC3Dg/1EECEnjLcNwvNlx0SZofW2Eb1RLzbiXC9ChK+QPzcBOEzgKrhQqMAzDt1EngvzUO3klCu1bY5Eu6Qxv6+8qJ0xsZhtr6Evd5X8Z5mEIwmtl3KmyCDvl614JjCSos+v60IX3pNJfF+0Ba6OqymuOMqzIPLv2N9UVNysMrw+8zNondjd4Vt2d17TCrMdXdRpNG1FuJ6ymfS0BZM/nbAN1wxv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0TrEZKQUIjuGxhxLYIHrpvTuZcv2/E5p6G3+KuPSD8=;
 b=VQBMvNC+V6fHQiESD7zcSOGjPrBe9CTxnw10MOWo7u82wNTGe7u3kop22mOscwv1tGxyAdwsn0CYxSTfhlJhT5Z6g009v0KivPb8jKh9jM88SAukDXosFTUEjgXmSP89D6Dr8X1hAKZYjAmvsW3TiaIvXY3H7uDh80Xg2QA+TaiKRzs6byC/qijRnnS/zwrU8UXAlffgyx+nbMxTDt0JzUVNlPfxvjFHgUmlrtfLSLf+zZ23vg5/MAF06c/bttfk84K5yxSgPET3gceBZxKaOnEw8Ny02HhcYMoaF/A3fevptp1YW+HaXCiOGz7fphPe0P5FXYZklezPBqZD3W5pFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0TrEZKQUIjuGxhxLYIHrpvTuZcv2/E5p6G3+KuPSD8=;
 b=hkembTQTWszZMXaDtP3Afx9yAZ1U9ZFBRkjcjJLOCnlr51wyBUaVUwK+LwCzDQXpXgRrSK9BToGihIiixYTnnu5iEuhv+gGYCZztlbNVBcL3fME4f0OPzbUy5ePZVTEuLkH0FdB0N3PpPKoNPFiF9pEZITmmQ3b0weOyGBdOu0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 21:12:41 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::8172:fab3:9de4:a004%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 21:12:41 +0000
Message-ID: <3268e31b-bfd8-7e40-d7df-068f51dc8ff6@amd.com>
Date: Fri, 11 Aug 2023 16:12:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230811191108.1808648-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0018.prod.exchangelabs.com (2603:10b6:805:b6::31)
 To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b5c90f0-aae2-49c6-d847-08db9aafb295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qf1vrXE3aP4XzeTm4Jd4wNhSCdtXC4FZ5IYdATDetvjOeeZes9aAI8tKi56UChNSoP0Cndo3kiopUnM0/G/0iucOkACGxRtY6D+G3AdoYAVS7V7bXE+w2GbvurFhdZLq3oU0wARBENlncqB81eRptDxeREEHXXBkAM6xLgWMACsJQ4IyQymwzJL1tIzi4oR8kgNj0tKzXYHlDgFV/EqMmz4fiLa5hwjA7s7zXLItjq96Igx94Nwduz3PIhLqIiXFyZeZFc277SqI4/eOTKwm9eW9C0OpSpp2QKT00erCixd2d92zbK0Yxuk1jq3gV7MI6JX9BusiVGNVds05FJZsnCqgrbq58sqrraCeYOyvy/SsywH5r6S10V52Cppp1/uFJbrF86KPDZnRa0mFjOhBQYgv6zA8pJ3LESmYN/XzQTvn0MnDUAq0EdnVK13wfYraVEKiHHjWMuNNHLrpSO9O9nhy1+IjVHQ4qLEDP8j0LCec1qoZOq1b3BR1XswpzXSmncFHdU5q7bZ+gCfSXdYDMq4+gLX8yNfvfzSnxPzasqVBWjEbW5DSj958iz6NbJr0Bhk6FmhTUFdRr18oC9F84O1Xm3rM9jndF1jWHqwxUUdrw3gaIFxS0YIZZjo/BNfxh0uwVaBVw8zkt9Lec26nWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(186006)(1800799006)(4326008)(66946007)(66556008)(66476007)(41300700001)(86362001)(31696002)(316002)(36756003)(6506007)(26005)(53546011)(6666004)(6512007)(6486002)(2616005)(83380400001)(478600001)(38100700002)(2906002)(5660300002)(31686004)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5nZjB6bXprRndJc2xFZ3lGT0I5S0c2bTJvcENSMWowbG9Jbk5teitwZnEz?=
 =?utf-8?B?YjZ4UkhuRHB2dmQrVkh5UFAwQU5WTVRVb2ZGRjlXTi9QQVhCbW5YdkNoMm9p?=
 =?utf-8?B?SEZGUjF6c0ZFTFA0QS80cEhLOGptc0dVSk5jYmVXbmJDVmp4RzdQdGs5MllT?=
 =?utf-8?B?Z0FXVFhNcUh4Ykx6VTh5eTFPSW43ZlhzTzJFWkJ2ckJITVVKV0hpaFRKdUVJ?=
 =?utf-8?B?eDAvdzBmbHpUWmo0bDU5NExyV1BuKzRYODJyOUV1RlZGVy9WczVqckhkQlhT?=
 =?utf-8?B?WmI3MGdKTm9IeUhCdFlrSEhIREN5THB0NXd0TktrU3lQdlpqL0srdmd3Y21V?=
 =?utf-8?B?aGRPSzJtZFoxajJyMFNXWE5Vd3ErdXlBVEI1enZkbmJaRnVjcjFjS29RZS9Q?=
 =?utf-8?B?dUhqaUdIWVRueTliL2s4bFVDQW92b3pwUCtrRFVoQlBBVkhpNEhyS1pOczZC?=
 =?utf-8?B?MGJjNlRtU2w5cGNKNmhWSXc3UUMvSnFUam8vWCtKQkpNUngwNGxNb2lSTmdl?=
 =?utf-8?B?ZCtrc0tva05EZENiRWRBOWVDMHdjR0ViY3Y4TTVFakVoV051eE43cXFzTHRZ?=
 =?utf-8?B?c1RKdTFlSFVrNVRvNkp2a2FIUDRJNDl6OWR6Y0xTa3cxS0pvVnIwa0JCcGFH?=
 =?utf-8?B?bjhwWXFHQUVhckFRUThxRDJmZ2ZmcVpHTWpUTHlHZDEyR202M1JjT08zU21Q?=
 =?utf-8?B?eHAxU3F2aDJzQkNmMlFGRGVEd24zSng2eWJ2dFEvRTV5Nmt6Nnd2N2lMbzNF?=
 =?utf-8?B?TzdoTXIrYUdFWUU5a1BTemlHQ0dFb2d4Y0tydUFOU3B1dHRNTFBDeTUrV1FB?=
 =?utf-8?B?SGFYKzVld25kcjhlMXd3WldDQmxqVjc1VkgvM3U1UC8xb1N6dzdCWnpiRGZm?=
 =?utf-8?B?RVpJNG5sOEF2VFJvaUNoVURWbVFSRzU4SUtkM0h0eXgweDIxVlNSajJVUkNi?=
 =?utf-8?B?c2kvQ3IvbGVPS3FnNzIya2lkeTlCVTFkbWd2ZTN4QTg3NjM2dTFrdHFYWktR?=
 =?utf-8?B?dTJxZFN0L1N1aUtXZkdBVEV5d0taK1RvV2VPOURVNzFLTGNaeVhjNVEwNGhD?=
 =?utf-8?B?czZtbkwyTWZ4Vld0NFFXbURTNmFIdExqYWtlUEhveFhBNGVhQUdrTUVsTlk5?=
 =?utf-8?B?Z0pnU2tISUtRVUdreTJZdTNYVjY0Z2ROQ0puZjl1Z0RXV0VrRHBtVVRUbGx6?=
 =?utf-8?B?OHE3dG8wRGpmcHBTTFZ4MjR4RlFwKzBjUnRjWFgxVjJMSmh2eEpQZlJCN2Z4?=
 =?utf-8?B?UnhyYkUyM3FTekJ0bGR4NTFZcFFhMjczb05tZnkrQUJ1U1RrZmFDWHdJU01M?=
 =?utf-8?B?M0hHZGQ2SnpjSHpicGcxOUIzK2dDdW1OV1hyQ2graXZKVkdBUDVYQ0VsYWxF?=
 =?utf-8?B?SnRiTmhTbVY5KzFNMnZCc0NmZ05iVWxwT0doYnM1NTBGbmpCRW4wTnpVaWFr?=
 =?utf-8?B?QjNXV3ljdHZWb3paUUc5KzVUcndGN2VNclhRTTlkUzFGdU1VOUJLb3VNOFgy?=
 =?utf-8?B?RG81eGYrYk5yWEdsUVhsRUFDbGhyTlpodWhiUlBnVVBITVN0R3lPeVlpS2t0?=
 =?utf-8?B?Qm5mblEweHpyMSszSjFFeGtRVnphcENDa1lJN01WSVVoRDFVd29hNnI2V0RZ?=
 =?utf-8?B?Uk1aeXVPZGhpLzU0QzN2VTZ6cHQ4QUpmNHRnMmpPVGN3TGU5cVBqRlMwTG5u?=
 =?utf-8?B?T09TM2x4RlQrcWo5U0hXbStXVG1IaEt1MUZwVE5iUHYwNWRTYktpZmFheStn?=
 =?utf-8?B?c2lqWSsxZ3VOUTkvRWlNalcvOXVPM0RiZXdRSklTbjVUanJpU2ZQME1PTVpZ?=
 =?utf-8?B?U0pNUElncGxaZHdHQkRVSTI5S0tLdUFJVFNaZml1OC8vSnBjREFKSEdLUkxG?=
 =?utf-8?B?dytNNmFrRHNENWFhdktuL2p6aTYwRjFRUFdnNENmWWZ5UjlhekExSzArdVFi?=
 =?utf-8?B?M1VJWVZ1ZXNHTEkzVFZIb0ZkcjdUMUp4cUZJTzVnVFo2MVpyUUNidWpKQnZY?=
 =?utf-8?B?ejVZT0d1VGpHQWEzc3YzaDFNdFFqVUZkUS9RK0JqMWg2ZnJvZ1o1Y1F0SHB2?=
 =?utf-8?B?WEp3T1c0U2hOQndzWjJQcjRYckJKa2NWdjB6d1hKTjhqeXVFR1UrWXAyWU55?=
 =?utf-8?Q?3rCA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5c90f0-aae2-49c6-d847-08db9aafb295
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:12:41.0502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJqm1UUXermV95IrDtl3qEaAhtRZ17KxZjx0X8tyD32wHdXyfj5U3uLh+ta23p5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com, Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


I know the original jira ticket. The system got RCU cpu stall, then 
kernel enter panic, then no response or ssh. This patch let prange list 
update task yield cpu after each range update. It can prevent task 
holding mm lock too long. mm lock is rw_semophore, not RCU mechanism. 
Can you explain how that can prevent RCU cpu stall in this case?

Regards

Xiaogang

On 8/11/2023 2:11 PM, James Zhu wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> update_list could be big in list_for_each_entry(prange, &update_list, update_list),
> mmap_read_lock(mm) is kept hold all the time, adding schedule() can remove
> RCU stall on CPU for this case.
>
> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
> __mmu_notifier_invalidate_range_start+0x132/0x1d0
> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
> migrate_vma_setup+0x6c7/0x8f0
> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
> kfd_ioctl+0x271/0x4e0 [amdgpu]
> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
> __x64_sys_ioctl+0x92/0xd0
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 113fd11aa96e..9f2d48ade7fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
>                  r = svm_range_trigger_migration(mm, prange, &migrated);
>                  if (r)
>                          goto out_unlock_range;
> +               schedule();
>
>                  if (migrated && (!p->xnack_enabled ||
>                      (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
> --
> 2.34.1
>
