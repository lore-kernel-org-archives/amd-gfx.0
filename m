Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D892C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 12:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9614510E106;
	Fri, 10 Nov 2023 12:07:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E353810E99D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 12:07:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln9NZh7yuztvKiBnDYVf+o2/6DO3S9DNQUIo5gg061trFcnrPrRirwXWKhbSscEjDtrHLdcf+WCtsVmCJSxL2iU5jkkVdEkGN9khITgbFXa/esTDw2OMaaxLZ54HOSUCfPhFNvmWdv/IVsx8e4bpreguob22hoBsXk3GavyHCdJOX3UOzCRSTbEmXsC7Mz3cI3/tvYexCh0KUppHr7j5bgfWIybo88Skv0RhHMFOWAGDBKOnMLm9DzIpCkcgN4kMdqhAfitXK+UnFJenoVIOrbpwKVzeYU+/b6ReSUOwRcpLlAw9e+r++qZsIy3ain7H9M23diFmRmGdWJ8iEAt/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjDWg5C1CXBZWn8eJWX6sYMkNOxiDLgqTM9MAkSGG/4=;
 b=jkcfOW4elZ+VnZywkzRedk6yYs6hIiVJx+iZjbSP2CIvhAHgbtuS2T8zQIfaQhzw7nkq7mqK2g72cbST5i6IMRjZwZvRniNAsZsCrc/ptinRatGH/nD1suKbhdSR/JMf6PJzElnAsvMbHB6WPhk1zISh4bhrhT7hoYqzqWLz7lHyIeL6rlgJq9SOjPP0Wq4/l+SPPSXJ+c2PXDwNJ5mfhNAU7c4mEKJp3Vp1x8e52mp/0tAsWhB/iuzrCkgCtfNWLREnLkbdq8hKRy9UIYeCFYIC+bRbysiVT9V3gri/SMikyKwow4fF1XMQO0FhKuysEMhRJEVoifod72p4qZL4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjDWg5C1CXBZWn8eJWX6sYMkNOxiDLgqTM9MAkSGG/4=;
 b=jNorXwxCLva6JOTCHSCLVABrwH1hDUSsInHQbWvG6lxgInlPETDV2UOXu5LYKhSAtDv6757aPVD2wbjRDmuw6cCKNnDlF6wj8kOCs454shUXvigHDcI5Ipjnx8bjZW0aMtvm956/rKKykJ1YAkMur27iPoPYbszuE3sr59UWFxQ=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Fri, 10 Nov 2023 12:07:33 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::9168:17d3:24ef:6e9f%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 12:07:33 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Thread-Topic: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs
Thread-Index: AQHaEcaq4AaBrmWD4kuPT+8xZWcCKbBy/WWAgAB5ZHA=
Date: Fri, 10 Nov 2023 12:07:33 +0000
Message-ID: <DM4PR12MB5165B2A20C60872AD4AA1F0787AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20231107220540.3711990-1-Felix.Kuehling@amd.com>
 <DM4PR12MB5165AF7B85556C13497C405E87AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165AF7B85556C13497C405E87AEA@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9d9a3b04-35d9-422f-a542-9645e345ff10;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-10T04:43:39Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM6PR12MB4564:EE_
x-ms-office365-filtering-correlation-id: 813ea98d-a07d-4ee5-4906-08dbe1e59edc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JpcbmLVVhIW801XcglEYB4ygoJK39IV0Cg0GRVlWkotMvA3ohrCQcJaPVGwmdwlVSFIzrZC3CtT87PUIdBexa6OIbuswZ1wAB3GElZ6FsmlicqXaZgGIcD098qGYrsqNMoH/BK9uwTDlz7/kDRZgEjdt4GjNAyXPUdgsThe0MBVIn0J+zLlLDAPO3RvOHt9YOVbheFOxBIEGbnCwzgeojN3DQyuRy99bFD607veR9/YPwVvNkMhLMX4hqolQRDRUTTmsrdCTXURv4HyY139rUxsRwwus4sCizss387PhBTqpTDhXjMKQPZ6inZdJAMol0hBo1Ok+GOvej23jIbZ5oYR9wgz7aiZjBnqE0X9uB5BuviJ7EQhUBspJ6BGGekQlOwEKallyZcB4h/oxDF7zFEEIexkDTTTrk6FWFS5EOCkYBIRJ2kBoQKrVjklppANvqW8+zGz4PnfRaebh+wFxnjXJ5wzG3NFf7zHDWvX+AXf5Vtf1hRR4faFz7XX1GAkJTW8NcxcX8TWGIRNwAENpBGh/0VJZkHf+lho5UVSUduRmXYaERghxtJTqUK4ATy+sAchJUxkw/D/RicnMs6x/LPXaNUn6yCWS/azv4mu261f+mT79HDAzglTpUZf5hcWTgnaPEIujWYydlbv4cUhgGNS2x7FhBXPMbhSTVW6ep+s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230273577357003)(230922051799003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(30864003)(2906002)(66946007)(4326008)(41300700001)(54906003)(5660300002)(8936002)(8676002)(52536014)(86362001)(38100700002)(66476007)(66556008)(2940100002)(26005)(110136005)(76116006)(66446008)(64756008)(83380400001)(9686003)(316002)(122000001)(478600001)(33656002)(53546011)(55016003)(45080400002)(38070700009)(6506007)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EZNNzx9cYMFzeIxALQ/zSQ7yf/iydZlSrVKVvPvGNpkSWNaXXm9gmqD/21on?=
 =?us-ascii?Q?2tYt5K7ts4s45rZSYeaySrPHk2elns9awcTSv31or/bNsp7dEz3XAtP8uk3y?=
 =?us-ascii?Q?RxdQiuLlzqcXOicW1EgnF1he4abFcBjvWvQDkCH22M9aABStNWEpX2jEAN6W?=
 =?us-ascii?Q?lufaAaCXPHZpvBU21vSXoUAC147pTOoA3DdM23tywLaxz5Dklpp2xW9n+Rem?=
 =?us-ascii?Q?sepzZxKlijjXph84V0aj0GfIO3eXFvfw6kYruRC7cNb4dclEc/osWUD8FGmL?=
 =?us-ascii?Q?RHdejsNhhz8i0i7sFWCcLAtFIsF/WgcMGwxqRvAbvaSbulLTh5fBu4HFuC8n?=
 =?us-ascii?Q?0HXbp7fuVC91YVt1k06jJlXPjwxIjf2QPwiDXIP9ICOHSqM+x7cQV7c3PwbI?=
 =?us-ascii?Q?rTDUQ9/Nqb5Pn4eJPR5q6x14td/u2OwkjbWWE1r0YRENmsS/sxKnPjH1zLBj?=
 =?us-ascii?Q?on6iWXEt6tYGZMuqG66KaJvnFn6DEq1FJ72VQ2pPl4y/Fe9qwZqg1eha5N71?=
 =?us-ascii?Q?ZTWGJzkdfM689noX5dqS5zlVXQeHM8rMXXTMXq9sHuBBAbn4L9olXTx1/cQh?=
 =?us-ascii?Q?5YbO0bwSatz2g4alk5JD1tw7WgBONtCJJIYaBwKt9qzHaNsADDzu5gYfh5Kt?=
 =?us-ascii?Q?qMAtiq/o91VcmnVNMtVdqkcL92kEN7Ap8/l94y78+Jk/X3ZHZ2OAbh9QBnOH?=
 =?us-ascii?Q?6PJhJ2F5xJQZUq1+QjDu/MLHOfnRq1Rvf5bgCrDNVI5F8oXTAM3RrpdwroZ5?=
 =?us-ascii?Q?Mci8vAWotTMY6F7wb/JawGmQyBxdUrR8Hrijk7p3G1H2d7D2Tu2nVcec2TcQ?=
 =?us-ascii?Q?suUjnWZO7rSPykdqe/PmDPBT+qDTx0xiejeTMtLmC98CC2RYsFG7JZ/n2Nba?=
 =?us-ascii?Q?h9l3EdZ6c5rLlO27KlyEPFf1PFpR/nsMcRclEt7Hx30wIEla+tC7OxMFQjjI?=
 =?us-ascii?Q?hwiB371movFRbPt7Q6m+e8hfj3jLTAFhxdhMskbLroheCeIGViGp7NpiJLm+?=
 =?us-ascii?Q?OIIxjRSt8NJi/Hj7K8frcBH3BbnIGzBt91EMT68c8tAHvIkdZX8/IH5YeSo1?=
 =?us-ascii?Q?ExZpmS5qw+M5XWh5AiFEk4qhZl+K/7sAKTcPR+qnFuh//37lu6ApO/qWYStw?=
 =?us-ascii?Q?M7AkgEQNXvZWfNFRNk5z0y6ANIlwcpWSpYHz65t8D3UiRl7c034zKelG+4x6?=
 =?us-ascii?Q?l3o28MXrTIN7OjkTZmRNbjwbSNDOp/NdH93Ky3WLwN1rFLCbg5ATu9D/N379?=
 =?us-ascii?Q?3iZzJEbZSIAw4mkd+BN77enC7NgbcofTgP4jtLbFufKfvUOpdu/ZdOev6rCd?=
 =?us-ascii?Q?jPvIUJY4JSZ6f5p7A/5j5Er7TxCuqYwKhcbAD87y5EaxbCi5ucG5bXGFE+eR?=
 =?us-ascii?Q?yGoAbJVKsyKTR2Yn5qftWkHuriRvZl5xY01sApCX6yMnaqPHR2J5eGSHqpt+?=
 =?us-ascii?Q?5D9yyYgRN57ocRVPXL4FdvG2+HRuM1aaBX2VbEdnBxvOgA7a4cTjiGawIqwH?=
 =?us-ascii?Q?rO/pjZi4DR6e7xd4ymy6nhibIef4CNoZlMJp6nAI82nslSmDcduQlDif1/29?=
 =?us-ascii?Q?/HARFWCXwHrWSBVrjaI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813ea98d-a07d-4ee5-4906-08dbe1e59edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 12:07:33.1786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKpy1OEpQVdIEgU7m8EZzyEy5yqYxnj207ng59avG0P1vQX5VKOle86K4/sSGUyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Wait, I think we need a small fix below.

--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2036,6 +2036,7 @@ int kfd_resume_all_processes(void)
        int ret =3D 0, idx =3D srcu_read_lock(&kfd_processes_srcu);

        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+               cancel_delayed_work_sync(&p->restore_work);
                if (restore_process_helper(p)) {
                        pr_err("Restore process %d failed during resume\n",
                               p->pasid);

Felix,
  restore_process_helper is called both in resume and restore-work. Which c=
alls into amdgpu_amdkfd_gpuvm_restore_process_bos to create a new ef.
So there is one race below.
resume create a new ef and soon the restore-work which is freezed during su=
spend create another new ef.
Then there is one warning when you call replace_eviction_fence.

[   83.865870] Replacing unsignaled eviction fence
[   83.872452] WARNING: CPU: 5 PID: 9 at drivers/gpu/drm/amd/amdgpu/amdgpu_=
amdkfd_gpuvm.c:2838 amdgpu_amdkfd_gpuvm_restore_pro
cess_bos+0xa9e/0xfe0 [amdgpu]
[snip]
[   83.896776] Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
[   83.989171] e1000e 0000:00:1f.6 eno1: NIC Link is Up 1000 Mbps Full Dupl=
ex, Flow Control: Rx/Tx
[   84.004699]
[   84.004701] RIP: 0010:amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe=
0 [amdgpu]
[   84.046060] Code: 48 83 05 8c aa ea 00 01 44 89 8d 08 fe ff ff 48 89 95 =
18 fe ff ff c6 05 3a 82 d9 00 01 e8 ba 80 d1 d0 48
83 05 72 aa ea 00 01 <0f> 0b 48 83 05 70 aa ea 00 01 44 8b 8d 08 fe ff ff 4=
8 8b 95 18 fe
[   84.046062] RSP: 0018:ffffa1e2c00c7bf0 EFLAGS: 00010202
[   84.046064] RAX: 0000000000000000 RBX: ffff8c58558d9c00 RCX: 00000000000=
00000
[   84.046066] RDX: 0000000000000002 RSI: ffffffff9370d98a RDI: 00000000fff=
fffff
[   84.046067] RBP: ffffa1e2c00c7e00 R08: 0000000000000003 R09: 00000000000=
00001
[   84.046069] R10: 0000000000000001 R11: 0000000000000001 R12: ffff8c58555=
ad008
[   84.046070] R13: 0000000004000000 R14: ffff8c58542f9510 R15: ffff8c5854c=
beea8
[   84.046071] FS:  0000000000000000(0000) GS:ffff8c676dc80000(0000) knlGS:=
0000000000000000
[   84.046073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.046074] CR2: 00007ffd279bb0c8 CR3: 0000000fde856003 CR4: 00000000003=
706e0
[   84.046076] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   84.046077] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   84.046078] Call Trace:
[   84.046079]  <TASK>
[   84.046081]  ? show_regs+0x6a/0x80
[   84.046085]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdg=
pu]
[   84.156138]  ? __warn+0x8d/0x180
[   84.156142]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdg=
pu]
[   84.166431]  ? report_bug+0x1e8/0x240
[   84.166435]  ? __wake_up_klogd.part.0+0x64/0xa0
[   84.166440]  ? handle_bug+0x46/0x80
[   84.166444]  ? exc_invalid_op+0x19/0x70
[   84.166447]  ? asm_exc_invalid_op+0x1b/0x20
[   84.166457]  ? amdgpu_amdkfd_gpuvm_restore_process_bos+0xa9e/0xfe0 [amdg=
pu]
[   84.166917]  ? __lock_acquire+0x5f3/0x28c0
[   84.166921]  ? __this_cpu_preempt_check+0x13/0x20
[   84.166938]  restore_process_helper+0x33/0x110 [amdgpu]
[   84.167292]  restore_process_worker+0x40/0x130 [amdgpu]
[   84.167644]  process_one_work+0x26a/0x550
[   84.167654]  worker_thread+0x58/0x3c0
[   84.167659]  ? __pfx_worker_thread+0x10/0x10
[   84.167661]  kthread+0x105/0x130
[   84.167664]  ? __pfx_kthread+0x10/0x10
[   84.167669]  ret_from_fork+0x29/0x50
[   84.167681]  </TASK>
[   84.167683] irq event stamp: 1343665
[   84.167684] hardirqs last  enabled at (1343671): [<ffffffff91f9bd7b>] vp=
rintk_emit+0x37b/0x3a0
[   84.167687] hardirqs last disabled at (1343676): [<ffffffff91f9bd67>] vp=
rintk_emit+0x367/0x3a0
[   84.167689] softirqs last  enabled at (1342680): [<ffffffff91ee2c33>] __=
irq_exit_rcu+0xd3/0x140
[   84.167691] softirqs last disabled at (1342671): [<ffffffff91ee2c33>] __=
irq_exit_rcu+0xd3/0x140
[   84.167692] ---[ end trace 0000000000000000 ]---
[   84.189957] PM: suspe

Thanks
xinhui

-----Original Message-----
From: Pan, Xinhui
Sent: Friday, November 10, 2023 12:51 PM
To: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Koenig, Christian <Christian.Koenig@a=
md.com>
Subject: RE: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQ=
s

I once replaced the queue with the freezable one, but got hang in flush.
Looks like Felix has fixed it.

Acked-and-tested-by: xinhui pan <xinhui.pan@amd.com>


-----Original Message-----
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Wednesday, November 8, 2023 6:06 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Koe=
nig, Christian <Christian.Koenig@amd.com>
Subject: [RFC PATCH v2] drm/amdkfd: Run restore_workers on freezable WQs

Make restore workers freezable so we don't have to explicitly flush them in=
 suspend and GPU reset code paths, and we don't accidentally try to restore=
 BOs while the GPU is suspended. Not having to flush restore_work also help=
s avoid lock/fence dependencies in the GPU reset case where we're not allow=
ed to wait for fences.

A side effect of this is, that we can now have multiple concurrent threads =
trying to signal the same eviction fence. Rework eviction fence signaling a=
nd replacement to account for that.

The GPU reset path can no longer rely on restore_process_worker to resume q=
ueues because evict/restore workers can run independently of it. Instead ca=
ll a new restore_process_helper directly.

This is an RFC and request for testing.

v2:
- Reworked eviction fence signaling
- Introduced restore_process_helper

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 34 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 87 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 3 files changed, 81 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 54f31a420229..1b33ddc0512e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1405,7 +1405,6 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
                                  amdgpu_amdkfd_restore_userptr_worker);

                *process_info =3D info;
-               *ef =3D dma_fence_get(&info->eviction_fence->base);
        }

        vm->process_info =3D *process_info;
@@ -1436,6 +1435,8 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **p=
rocess_info,
        list_add_tail(&vm->vm_list_node,
                        &(vm->process_info->vm_list_head));
        vm->process_info->n_vms++;
+
+       *ef =3D dma_fence_get(&vm->process_info->eviction_fence->base);
        mutex_unlock(&vm->process_info->lock);

        return 0;
@@ -1447,10 +1448,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **=
process_info,
 reserve_pd_fail:
        vm->process_info =3D NULL;
        if (info) {
-               /* Two fence references: one in info and one in *ef */
                dma_fence_put(&info->eviction_fence->base);
-               dma_fence_put(*ef);
-               *ef =3D NULL;
                *process_info =3D NULL;
                put_pid(info->pid);
 create_evict_fence_fail:
@@ -1644,7 +1642,8 @@ int amdgpu_amdkfd_criu_resume(void *p)
                goto out_unlock;
        }
        WRITE_ONCE(pinfo->block_mmu_notifications, false);
-       schedule_delayed_work(&pinfo->restore_userptr_work, 0);
+       queue_delayed_work(system_freezable_wq,
+                          &pinfo->restore_userptr_work, 0);

 out_unlock:
        mutex_unlock(&pinfo->lock);
@@ -2458,7 +2457,8 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_n=
otifier *mni,
                                       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
                if (r)
                        pr_err("Failed to quiesce KFD\n");
-               schedule_delayed_work(&process_info->restore_userptr_work,
+               queue_delayed_work(system_freezable_wq,
+                       &process_info->restore_userptr_work,
                        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
        }
        mutex_unlock(&process_info->notifier_lock);
@@ -2793,7 +2793,8 @@ static void amdgpu_amdkfd_restore_userptr_worker(stru=
ct work_struct *work)

        /* If validation failed, reschedule another attempt */
        if (evicted_bos) {
-               schedule_delayed_work(&process_info->restore_userptr_work,
+               queue_delayed_work(system_freezable_wq,
+                       &process_info->restore_userptr_work,
                        msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));

                kfd_smi_event_queue_restore_rescheduled(mm);
@@ -2802,6 +2803,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(str=
uct work_struct *work)
        put_task_struct(usertask);
 }

+static void replace_eviction_fence(struct dma_fence **ef,
+                                  struct dma_fence *new_ef)
+{
+       struct dma_fence *old_ef =3D rcu_replace_pointer(*ef, new_ef, true
+               /* protected by process_info->lock */);
+
+       /* If we're replacing an unsignaled eviction fence, that fence will
+        * never be signaled, and if anyone is still waiting on that fence,
+        * they will hang forever. This should never happen. We should only
+        * replace the fence in restore_work that only gets scheduled after
+        * eviction work signaled the fence.
+        */
+       WARN_ONCE(!dma_fence_is_signaled(old_ef),
+                 "Replacing unsignaled eviction fence");
+       dma_fence_put(old_ef);
+}
+
 /** amdgpu_amdkfd_gpuvm_restore_process_bos - Restore all BOs for the give=
n
  *   KFD process identified by process_info
  *
@@ -2956,7 +2974,7 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *inf=
o, struct dma_fence **ef)
        }
        dma_fence_put(&process_info->eviction_fence->base);
        process_info->eviction_fence =3D new_fence;
-       *ef =3D dma_fence_get(&new_fence->base);
+       replace_eviction_fence(ef, dma_fence_get(&new_fence->base));

        /* Attach new eviction fence to all BOs except pinned ones */
        list_for_each_entry(mem, &process_info->kfd_bo_list, diff --git a/d=
rivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_pr=
ocess.c
index fbf053001af9..568c49f2f0ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -664,7 +664,8 @@ int kfd_process_create_wq(void)
        if (!kfd_process_wq)
                kfd_process_wq =3D alloc_workqueue("kfd_process_wq", 0, 0);
        if (!kfd_restore_wq)
-               kfd_restore_wq =3D alloc_ordered_workqueue("kfd_restore_wq"=
, 0);
+               kfd_restore_wq =3D alloc_ordered_workqueue("kfd_restore_wq"=
,
+                                                        WQ_FREEZABLE);

        if (!kfd_process_wq || !kfd_restore_wq) {
                kfd_process_destroy_wq();
@@ -1637,6 +1638,7 @@ int kfd_process_device_init_vm(struct kfd_process_dev=
ice *pdd,
        struct amdgpu_fpriv *drv_priv;
        struct amdgpu_vm *avm;
        struct kfd_process *p;
+       struct dma_fence *ef;
        struct kfd_node *dev;
        int ret;

@@ -1656,11 +1658,12 @@ int kfd_process_device_init_vm(struct kfd_process_d=
evice *pdd,

        ret =3D amdgpu_amdkfd_gpuvm_acquire_process_vm(dev->adev, avm,
                                                     &p->kgd_process_info,
-                                                    &p->ef);
+                                                    &ef);
        if (ret) {
                pr_err("Failed to create process VM object\n");
                return ret;
        }
+       RCU_INIT_POINTER(p->ef, ef);
        pdd->drm_priv =3D drm_file->private_data;
        atomic64_set(&pdd->tlb_seq, 0);

@@ -1904,6 +1907,21 @@ kfd_process_gpuid_from_node(struct kfd_process *p, s=
truct kfd_node *node,
        return -EINVAL;
 }

+static int signal_eviction_fence(struct kfd_process *p) {
+       struct dma_fence *ef;
+       int ret;
+
+       rcu_read_lock();
+       ef =3D dma_fence_get_rcu_safe(&p->ef);
+       rcu_read_unlock();
+
+       ret =3D dma_fence_signal(ef);
+       dma_fence_put(ef);
+
+       return ret;
+}
+
 static void evict_process_worker(struct work_struct *work)  {
        int ret;
@@ -1916,31 +1934,46 @@ static void evict_process_worker(struct work_struct=
 *work)
         * lifetime of this thread, kfd_process p will be valid
         */
        p =3D container_of(dwork, struct kfd_process, eviction_work);
-       WARN_ONCE(p->last_eviction_seqno !=3D p->ef->seqno,
-                 "Eviction fence mismatch\n");
-
-       /* Narrow window of overlap between restore and evict work
-        * item is possible. Once amdgpu_amdkfd_gpuvm_restore_process_bos
-        * unreserves KFD BOs, it is possible to evicted again. But
-        * restore has few more steps of finish. So lets wait for any
-        * previous restore work to complete
-        */
-       flush_delayed_work(&p->restore_work);

        pr_debug("Started evicting pasid 0x%x\n", p->pasid);
        ret =3D kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM)=
;
        if (!ret) {
-               dma_fence_signal(p->ef);
-               dma_fence_put(p->ef);
-               p->ef =3D NULL;
-               queue_delayed_work(kfd_restore_wq, &p->restore_work,
+               /* If another thread already signaled the eviction fence,
+                * they are responsible stopping the queues and scheduling
+                * the restore work.
+                */
+               if (!signal_eviction_fence(p))
+                       queue_delayed_work(kfd_restore_wq, &p->restore_work=
,
                                msecs_to_jiffies(PROCESS_RESTORE_TIME_MS));
+               else
+                       kfd_process_restore_queues(p);

                pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
        } else
                pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);=
  }

+static int restore_process_helper(struct kfd_process *p) {
+       int ret =3D 0;
+
+       /* VMs may not have been acquired yet during debugging. */
+       if (p->kgd_process_info) {
+               ret =3D amdgpu_amdkfd_gpuvm_restore_process_bos(
+                       p->kgd_process_info, &p->ef);
+               if (ret)
+                       return ret;
+       }
+
+       ret =3D kfd_process_restore_queues(p);
+       if (!ret)
+               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
+       else
+               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid=
);
+
+       return ret;
+}
+
 static void restore_process_worker(struct work_struct *work)  {
        struct delayed_work *dwork;
@@ -1966,24 +1999,15 @@ static void restore_process_worker(struct work_stru=
ct *work)
         */

        p->last_restore_timestamp =3D get_jiffies_64();
-       /* VMs may not have been acquired yet during debugging. */
-       if (p->kgd_process_info)
-               ret =3D amdgpu_amdkfd_gpuvm_restore_process_bos(p->kgd_proc=
ess_info,
-                                                            &p->ef);
+
+       ret =3D restore_process_helper(p);
        if (ret) {
                pr_debug("Failed to restore BOs of pasid 0x%x, retry after =
%d ms\n",
                         p->pasid, PROCESS_BACK_OFF_TIME_MS);
                ret =3D queue_delayed_work(kfd_restore_wq, &p->restore_work=
,
                                msecs_to_jiffies(PROCESS_BACK_OFF_TIME_MS))=
;
                WARN(!ret, "reschedule restore work failed\n");
-               return;
        }
-
-       ret =3D kfd_process_restore_queues(p);
-       if (!ret)
-               pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
-       else
-               pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid=
);
 }

 void kfd_suspend_all_processes(void)
@@ -1994,14 +2018,9 @@ void kfd_suspend_all_processes(void)

        WARN(debug_evictions, "Evicting all processes");
        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-               cancel_delayed_work_sync(&p->eviction_work);
-               flush_delayed_work(&p->restore_work);
-
                if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_=
SUSPEND))
                        pr_err("Failed to suspend process 0x%x\n", p->pasid=
);
-               dma_fence_signal(p->ef);
-               dma_fence_put(p->ef);
-               p->ef =3D NULL;
+               signal_eviction_fence(p);
        }
        srcu_read_unlock(&kfd_processes_srcu, idx);  } @@ -2013,7 +2032,7 @=
@ int kfd_resume_all_processes(void)
        int ret =3D 0, idx =3D srcu_read_lock(&kfd_processes_srcu);

        hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-               if (!queue_delayed_work(kfd_restore_wq, &p->restore_work, 0=
)) {
+               if (restore_process_helper(p)) {
                        pr_err("Restore process %d failed during resume\n",
                               p->pasid);
                        ret =3D -EFAULT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index fe937670c927..aa6c34127be9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1869,7 +1869,7 @@ static void svm_range_restore_work(struct work_struct=
 *work)
        /* If validation failed, reschedule another attempt */
        if (evicted_ranges) {
                pr_debug("reschedule to restore svm range\n");
-               schedule_delayed_work(&svms->restore_work,
+               queue_delayed_work(system_freezable_wq, &svms->restore_work=
,
                        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)=
);

                kfd_smi_event_queue_restore_rescheduled(mm);
@@ -1945,7 +1945,7 @@ svm_range_evict(struct svm_range *prange, struct mm_s=
truct *mm,
                        pr_debug("failed to quiesce KFD\n");

                pr_debug("schedule to restore svm %p ranges\n", svms);
-               schedule_delayed_work(&svms->restore_work,
+               queue_delayed_work(system_freezable_wq, &svms->restore_work=
,
                        msecs_to_jiffies(AMDGPU_SVM_RANGE_RESTORE_DELAY_MS)=
);
        } else {
                unsigned long s, l;
--
2.34.1

