Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40985C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 14:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B9810E1F8;
	Tue, 28 Jul 2026 14:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="szHAVNX/";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011034.outbound.protection.outlook.com
 [40.93.194.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967E810E1F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 14:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qk5COiI+ASUhrJPQpBJ0h0oI50fM/YU0q9GwifbmZ5yTIF9HeVBjeMtvmlvxjW5j8V6HBQ12MI6RMQfYLPG+koLUiUzkJdVSJJo6GdZOnziuqHP6ftJyhEhDKtluM6LRvaLsFtT3KW3g9yhbTLmOtAEHvc6b03/rdqXPuSlojnEzLDHoXNnJSvttBpxLIuB3LvH0fBR8YGdjC1TSXWuoUMuydDRVa3rEV+evy1Z0jAhhaQneqpfugIkaB4+Q6o/YhvOn59Iu05o6J6KRj0PAAF8xDp0Vgr4wL3uL3FEYooCrhVfSEFx/JeWScHVfxy4f+pH874rtkOfbqLZf4XsoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9usIh009PEkMlNuxJ7jCXrqNRzaRWR3J6yMOL3ANcYk=;
 b=qcUKLj5mnJD/qQRh7wm8cpNJvAISjqQh8rM/w7lXOCAtkWbSv3+Cha4bXVtUPjlaKj269fgZy8ZVSDiidZRU2TtUdy1D+HseO3Vchn+8T/9cA3TKU7JouTXuu8SxYYEC1YXRBdizxOqh0KHBOtvjaOP7LXtrSNDtFmrBXFVT7wY3caQIwmUXzIg/cigo5zi61oePmsly1BZG8LWBsRodNlZmGDe532LimWhCfNRtcVCWZ2OK10lc1H+LgIonULId9qBrQLT7LS1BcDLNVj2D8FzBdb39Mata5G1k59Y9EuluBagKnQpK93YkrA4kQmTkCH+7lo5DMo5Q4AZUHaW4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9usIh009PEkMlNuxJ7jCXrqNRzaRWR3J6yMOL3ANcYk=;
 b=szHAVNX/eV0uVrl9FuNyLCr+OcEiocgwebd8oozqHw2eTks8mtDK9nUNM+7khWYQyumQ+jQHQtHCf4ThbfdNpwumT61G8ifkETFr4031kLMjcobahZsX9V0VujUQsIKjH3n+FmiKLj3QqxkDxxB6RJBRPYxwC2/BmbwIgo30ues=
Received: from SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 14:19:39 +0000
Received: from SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec]) by SA1PR12MB8144.namprd12.prod.outlook.com
 ([fe80::56ac:f44f:8336:d7ec%4]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 14:19:38 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
Thread-Topic: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
Thread-Index: AQHdHlOf8JBnNVuroU6VPEICpsA3m7aC+rdX
Date: Tue, 28 Jul 2026 14:19:38 +0000
Message-ID: <SA1PR12MB8144177D04E0C78EE82BFEDDEFCB2@SA1PR12MB8144.namprd12.prod.outlook.com>
References: <20260728054000.443371-1-yifan1.zhang@amd.com>
In-Reply-To: <20260728054000.443371-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-28T14:19:38.463Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8144:EE_|PH7PR12MB7844:EE_
x-ms-office365-filtering-correlation-id: d1735fba-d5d3-402c-10e9-08deecb34253
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
x-microsoft-antispam-message-info: HSmyYlxXPmMRaOmyK8bdDHI9XFEFlsz3ui9BjR8jU2+rj99tMxqTb81UFnI9HgbqUdopNkdKHuwc/yl2YQ6nRzqvQD0fGyQNlV4UbmuFwXJOPRMkZ79psbxt217qP+SbwRPwXx8XotDcd93qHhDH/ZkDBpDFLqpLOde9m6syeyjVoJ+MMLvkrkkJ8uJnhKSUETjJmspKpDG3fMToyKGYI3Nr3aY7Iw5nKN8qmCpifMYS9tDBVpDnef0cwl3o9uJcFek5rSTvLtxQyeSjGpSwe1NopvXr/nFtarpsOV2eE5x0nUBqgWSrmWeev9eT9k/3CfcMmGQMOW7f/S2aKjh1M190lPJrxezUnhg90LfszGKjDvH38T2xCWqOAdZpty/1wDpC1AClIh3wKxgMJBPXorqBWaoQEs1a60REKf45+QFyvoakbPToYRMy6Gsv4D2ruwWcm/aRX/tYQsgRRrpVcBiz3K6J3+LXf+dQVS32XkFk6cUPXmex7SdJ4iZX3MSd5IyqKmwjD39jtr03F1/TPyYEZMTe8AcGfZS3iVaX/C6P8NML23kBlP6nLvMgpLJcTnlH0YcADKcLQozgcT5rJEONt9596DtQsgV80ZF86Ve2MdqWftJ4IRqHhcORwniKCpdxrai76oDaDi3mxdtWSkaQgeihXSsO7ZIKM/0LckEGENNSPVBYp8S3F2DNhnaIwvxwV1UmmNBDGLQJ+pZWa221LKz0pvVCeS8yXn77Gc8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LBhPGJkh5MOZMsj797Xo3bhGt9/wjKhqQLrkxEuWY6ch7BZi0GBA5j5Wcf/Z?=
 =?us-ascii?Q?c4Bdg1y+WX/CqG6HaNQ4xvCfwO4+RVZc7Vw3SDfITTF39J0z40cQR49I2KId?=
 =?us-ascii?Q?qhngdqMCHff9lTkGA/Dmkwixt1YBeEMcCxGK1dfP2LbV28DnJkqHFTTxomoc?=
 =?us-ascii?Q?oYmVj6FdS9rQkSYaCHJY57u16++cdyT7CjVLZAvYZDK0MoVjOzkcDZHPDx+D?=
 =?us-ascii?Q?4i2d8IzyvB8IHPVhNXDsihLvn0wp4QgnAGZRXWEJKTwcL9puh2Paji/VY6a3?=
 =?us-ascii?Q?mQ/lTmAyDM5BqbXzP5x0V0TWh4udSVMsmHX0LHEClK8E2r/B1Bc6MA3tfkfU?=
 =?us-ascii?Q?+kKuA3FonWDuzQWEWRsmp5nLXBUCSiSld83KnZsN+G+wq26qi9K03E0A4Kae?=
 =?us-ascii?Q?/+kXK6/pLxrUHO7X9VV4gkkrpXdKwLsr3+d8lweXwtsAXYIPZGr9ttfO7DaB?=
 =?us-ascii?Q?L7PH2rfAvoS0G1AjhBlQ1bOiMDYto+DErbB/tzUbfGWgnPunVwgUrFs88WKl?=
 =?us-ascii?Q?kLX9fnC0H9PzHDKFa+o4J+SoJIDMI7lQAU6BTOErbGxdmXAYICUtA0lDXL+n?=
 =?us-ascii?Q?7gXHGp+aaBRbB7b/A6uoYIG8MfNXwK3eOLqFqfg88pS2JYWCWdgIQXegK//C?=
 =?us-ascii?Q?t5omIFHv7KrxTArxQuqynUPgtxTsTkzMaMA9Y+hrHgmsebo2FcYVq+xeBhqK?=
 =?us-ascii?Q?LqNXM0/2T7VHApBBOxOf8JxRzx8facki9TodELsWPFhFDUF0qztntKNpPDG1?=
 =?us-ascii?Q?bH63Mqf8Rhx9PcuREyeFtjPt0+mcPfzFoQGggMNvj2Wps9JMSGa1p/lvMpzC?=
 =?us-ascii?Q?4GnjbIWmAyGAjGi4c2bldQa6COD1167WQ06BWBCJp/JindUc6xysN9egyv9l?=
 =?us-ascii?Q?Ifz3bWdZHFwGMFiuBrqFgt7SXOLIC20BXYggkk2QSQkbRfOhAsJPBe9YHZG1?=
 =?us-ascii?Q?tUyQNm5dVQXxctwQv7Junp+rHHzRgBhMZhStU3dfexKEwe2LugnyAjUvFKh8?=
 =?us-ascii?Q?hBCdRFqWTrKN3pAkbbu0g/5qPzqZ3lT/ec+C7R9QT5UAsfQEUV/LBfPsLhaz?=
 =?us-ascii?Q?sDvZXeyC9OBooG43gfCOVZytIyeIM8kkgB20xoXAFJG0kb+Ov2Dug7pPzJwm?=
 =?us-ascii?Q?ehhSxc8HXVTczueLI/wXOnc0NI9m5UJeCS8+nl5CHWl1UxrxgmuuFhwnHpOQ?=
 =?us-ascii?Q?luXD/E/of4/3p5gwrj2c3LZKfroLoAV+tF6qsj8H4Um79udO9Wgm8/rW3Y1n?=
 =?us-ascii?Q?UBITRt4s4IYJLyC7BQqk4oDOH3CPCC+C1jv6UfFBClIT2Ls0Nik23Efma9pw?=
 =?us-ascii?Q?djbphq/n6nSWLg9M/Xc2jTK7JCEkN/lCHdwa/4OrvjVZreTqT60T28Tmkwsl?=
 =?us-ascii?Q?6iXTQ7XeP+ueNIKjLWGHB7NtxJ8rUKQNfHc6ny/MkpW088soS0AgX86jNr7s?=
 =?us-ascii?Q?Vkstjv9TCXtQVh90TRH+bHvmXfSOP0G4eYXLcmtMsS5g5r7e+7D6zFvPSuaL?=
 =?us-ascii?Q?5027dhWCT6rJRgpOWqED0wVwGiED7zWUCYb05qo7nx/lr2uf+8Pz/qG8ArBi?=
 =?us-ascii?Q?n/IX//j8o695M81loBb4bQ2pVJoyYLJ0+NfNyVcKwt7s5kS+ipGa9EgoFibi?=
 =?us-ascii?Q?EGw1Asmleo+vNWAMJ67PW1xTgOAEQqyQo1ayY/tmBEqQhAh2q5PprNOlttbh?=
 =?us-ascii?Q?CH61CwiUvOm3NEWHZOGDkGF9k+oRQmsbiaLJRmxfUgL9KdoD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1735fba-d5d3-402c-10e9-08deecb34253
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 14:19:38.8931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WJaaXPlMrC7W6fdF7mm6F6P4TK8WjD8EIvbPGSFVtTHmTVmCHJMmAC4WHncPSd7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

Design seems reasonable, some minor comments:

> kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
> kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 62256dd067 P4D 0
Could this be summarized instead of having the entire kernel dump in the co=
mmit
message?

> +#define GART_ENTRY_BO_COLOR            0
> #define GART_ENTRY_WITHOUT_BO_COLOR     1
> +#define GART_ENTRY_BO_TEARDOWN_COLOR   2
These names are confusing - a GART entry can have three colors
- color, without color, and teardown color. Could these names
be made more descriptive - especially the first one?

________________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Yifan Zh=
ang <yifan1.zhang@amd.com>
Sent: Tuesday, July 28, 2026 1:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Koenig, Christian; Yuan, Perry; Zhang, Yifan
Subject: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery

A GPU reset can race with BO teardown after the BO's GTT resource has
been marked for deletion but before its drm_mm node is removed. In this
window, amdgpu_gtt_mgr_recover() can treat the node as a live BO and try
to restore its GART mapping while its TT backing is being destroyed.

Mark the GTT node with a dedicated teardown color from
amdgpu_bo_delete_mem_notify(). During recovery, process only nodes
colored as live BOs, leaving both teardown nodes and nodes without BOs
untouched.

This prevents reset recovery from accessing a BO whose backing storage
is no longer valid.

kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
kernel: #PF: supervisor read access in kernel mode
kernel: #PF: error_code(0x0000) - not-present page
kernel: PGD 62256dd067 P4D 0
kernel: Oops: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 378 UID: 0 PID: 3775143 Comm: kworker/u1536:4 Tainted: G      =
  W  OE       6.17.0-35-generic #35~24.04.1-Ubuntu PREEMPT(voluntary)
kernel: Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
kernel: Hardware name: Supermicro AS -4125GS-TNRT/H13DSG-O-CPU, BIOS 3.8a 1=
1/01/2025
kernel: Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
kernel: RIP: 0010:amdgpu_gart_map+0x60/0xc0 [amdgpu]
kernel: Code: 71 98 c3 48 89 45 d0 31 c0 c7 45 cc 00 00 00 00 e8 25 4b 9e c=
1 84 c0 74 39 48 89 d8 48 c1 e8 0c 89 c3 45 85 e4 74 23 41 01 c4 <49> 8b 0e=
 4c 8b 45 c0 89 da 4c 89 fe 4c 89 ef 83 c3 01 49 83 c6 08
kernel: RSP: 0018:ff4f7e3af8a1fb18 EFLAGS: 00010206
kernel: RAX: 00000000000002b6 RBX: 00000000000002b6 RCX: 0000000000000000
kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
kernel: RBP: ff4f7e3af8a1fb58 R08: 80c0000000000073 R09: ff4f7e4ad6b00000
kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000002b7
kernel: R13: ff2209225a000000 R14: 0000000000000000 R15: ff4f7e4ad6b00000
kernel: FS:  0000000000000000(0000) GS:ff22098108562000(0000) knlGS:0000000=
000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 00000064b7011002 CR4: 0000000000f71ef0
kernel: PKRU: 55555554
kernel: Call Trace:
kernel:  <TASK>
kernel:  amdgpu_gart_bind+0x1a/0x50 [amdgpu]
kernel:  amdgpu_ttm_gart_bind+0xd8/0xe0 [amdgpu]
kernel:  amdgpu_ttm_recover_gart+0x5f/0x80 [amdgpu]
kernel:  amdgpu_gtt_mgr_recover+0x43/0x70 [amdgpu]
kernel:  gmc_v12_0_hw_init+0x46/0x160 [amdgpu]
kernel:  gmc_v12_0_resume+0x14/0x40 [amdgpu]
kernel:  amdgpu_ip_block_resume+0x24/0x80 [amdgpu]
kernel:  amdgpu_device_ip_resume_phase1+0xce/0x180 [amdgpu]
kernel:  amdgpu_device_reinit_after_reset+0x13d/0x340 [amdgpu]
kernel:  amdgpu_do_asic_reset.part.0+0x56/0x1b0 [amdgpu]
kernel:  amdgpu_device_asic_reset+0x426/0x640 [amdgpu]
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  amdgpu_device_gpu_recover+0x260/0x410 [amdgpu]
kernel:  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
kernel:  process_one_work+0x18e/0x3e0
kernel:  worker_thread+0x2e3/0x420
kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
kernel:  ? __pfx_worker_thread+0x10/0x10
kernel:  kthread+0x10a/0x230
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork+0x121/0x140
kernel:  ? __pfx_kthread+0x10/0x10
kernel:  ret_from_fork_asm+0x1a/0x30
kernel:  </TASK>

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 36 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gtt_mgr.c
index 0ea32561c4bc..1f9063b30526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -26,7 +26,9 @@

 #include "amdgpu.h"

+#define GART_ENTRY_BO_COLOR            0
 #define GART_ENTRY_WITHOUT_BO_COLOR    1
+#define GART_ENTRY_BO_TEARDOWN_COLOR   2

 static inline struct amdgpu_gtt_mgr *
 to_gtt_mgr(struct ttm_resource_manager *man)
@@ -102,6 +104,35 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource =
*res)
        return drm_mm_node_allocated(&node->mm_nodes[0]);
 }

+/**
+ * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
+ *
+ * @tbo: TTM BO whose TT backing is about to be destroyed
+ *
+ * Keep the GART range allocated until the resource is freed, but prevent
+ * reset recovery from using the BO after TT teardown has started.
+ */
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)
+{
+       struct amdgpu_device *adev =3D amdgpu_ttm_adev(tbo->bdev);
+       struct ttm_resource *res =3D tbo->resource;
+       struct ttm_range_mgr_node *node;
+       struct amdgpu_gtt_mgr *mgr;
+
+       dma_resv_assert_held(tbo->base.resv);
+
+       if (!res || res->mem_type !=3D TTM_PL_TT)
+               return;
+
+       node =3D to_ttm_range_mgr_node(res);
+       mgr =3D &adev->mman.gtt_mgr;
+
+       spin_lock(&mgr->lock);
+       if (drm_mm_node_allocated(&node->mm_nodes[0]))
+               node->mm_nodes[0].color =3D GART_ENTRY_BO_TEARDOWN_COLOR;
+       spin_unlock(&mgr->lock);
+}
+
 /**
  * amdgpu_gtt_mgr_new - allocate a new node
  *
@@ -137,7 +168,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manag=
er *man,
                spin_lock(&mgr->lock);
                r =3D drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes=
[0],
                                                num_pages, tbo->page_alignm=
ent,
-                                               0, place->fpfn, place->lpfn=
,
+                                               GART_ENTRY_BO_COLOR,
+                                               place->fpfn, place->lpfn,
                                                DRM_MM_INSERT_BEST);
                spin_unlock(&mgr->lock);
                if (unlikely(r))
@@ -248,7 +280,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
        adev =3D container_of(mgr, typeof(*adev), mman.gtt_mgr);
        spin_lock(&mgr->lock);
        drm_mm_for_each_node(mm_node, &mgr->mm) {
-               if (mm_node->color =3D=3D GART_ENTRY_WITHOUT_BO_COLOR)
+               if (mm_node->color !=3D GART_ENTRY_BO_COLOR)
                        continue;

                node =3D container_of(mm_node, typeof(*node), mm_nodes[0]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 5fe29e4972d8..6fa8301b8ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1676,6 +1676,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer=
_object *bo,
 static void
 amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
 {
+       amdgpu_gtt_mgr_mark_bo_teardown(bo);
        amdgpu_bo_move_notify(bo, false, NULL);
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.h
index ff9e2e346609..af1e7fcc7175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
 void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);

 bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
+void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
 void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);

 int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
--
2.43.0

