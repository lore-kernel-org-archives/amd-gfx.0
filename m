Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED34FC7EE2A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 05:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D5C10E968;
	Fri, 27 Jun 2025 05:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bQLR2SBB";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA37510E968
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 05:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxW9Jo7qOciuwHpdl0To8maPFewZZLf6nvM1wuf/AnucHuiqru2ekr4YzDo6mB27BaeOqJZWwKnYwrToYOn0xUM+PcibDmeLXTburOOJYQNf9seqmugLCRViRGlBMmcaa5Kx9CjJUQHX0iyhZt+l3WgZitvYItbtqAJDoj44GI0jwTXQzye8ASzfRI2RebmJs5jrVXFpoDh7ukEp/sdH+0/pfmjESw7ocl1K8kVLczvFFORJllt2EmHfbc9YbPIduNT3EI0HeOu2ARfmzDrqLR/ZflXeyZdyQtzlk0F0dPD1/uOJt5/lOu58M26DfTNelOuOLH+R/qkGFAn9ziiQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2AJEOZIv96U8vDc+MW4lhH59FZhNsvNPmSgBUXIxkE=;
 b=q9n1Ebk4qJBHV8Oo/hjYQ+VyeL/XxodhaORpC637eqMwZJTuDRWdN398M8YfwRx2/N/67w4GBM1dWY+FtPLHxg6+oOtw/EkWKkcoosRujKqBQhlmnwhipm6KPRAUREC5gpRN5Mk6pe66Va/zNXb+h0JYEIzSlIDL0+ES3XJup7jFgoIWeXktzqizLw/CX4RQERTTF53hHBC6NtdBdZvNE99SSYp+W+cPf/A14AZj0v+JYID1lXIrvSZ48a+yBCdFvvqX0xKDbZg0PEtnhgPGDxFalV6PdLBkcfahRenwrAkpDjSZ5pK+hXsx2Dmfu2T7Dtf/i4zshmh1FZlM/qwASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2AJEOZIv96U8vDc+MW4lhH59FZhNsvNPmSgBUXIxkE=;
 b=bQLR2SBBRF/O0hyYtOk7Rak02HIw3HjwqNK4jRj2629gQpXUiG146nPpepOqRbosfCPRMUpk67efBT07gkQvtpU3Mwvw5/px0tXo6GP73sdYgfxiKNWTidFLUt9UK7m0Pe3JFiRXN52AYtQ2vs56Pl/1aC8RmvdmabzGXmSfHHY=
Received: from PH0PR12MB5420.namprd12.prod.outlook.com (2603:10b6:510:e8::18)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.32; Fri, 27 Jun
 2025 05:20:09 +0000
Received: from PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1]) by PH0PR12MB5420.namprd12.prod.outlook.com
 ([fe80::dd32:9eed:14e9:33f1%6]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 05:20:09 +0000
From: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>, "cao, lin"
 <lin.cao@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: delete function amdgpu_flush
Thread-Topic: [PATCH] drm/amdgpu: delete function amdgpu_flush
Thread-Index: AQHb5yIReczaTiaQSEqtOQ09HFaOBbQWdlww
Date: Fri, 27 Jun 2025 05:20:08 +0000
Message-ID: <PH0PR12MB54205C1B34B693720538A914E045A@PH0PR12MB5420.namprd12.prod.outlook.com>
References: <20250627051204.62029-1-YuanShang.Mao@amd.com>
In-Reply-To: <20250627051204.62029-1-YuanShang.Mao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-27T05:14:10.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5420:EE_|CH2PR12MB9493:EE_
x-ms-office365-filtering-correlation-id: ef25c778-895c-4002-e5e3-08ddb53a48d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?35PxLTOXnu9QNo/5gcyxQSPsq0Ddrx9gZhmC6xd6pWMec/JL/9TXPZ6NDmF7?=
 =?us-ascii?Q?BR/Nkj7m6Z1oc3GVhMt+LJVE77JK194X96RsxNtwpYpWFDTe/PZi+v5XWgmk?=
 =?us-ascii?Q?WTSp0iZ1cqPNo8mczp0+H0Uqt2MN/U5qhZWHle/eXdceUjOBy8P+r3Vjpr8w?=
 =?us-ascii?Q?piDjEYGholxa6aV1K/polV2SFhOxKhw2/Mhxhqotn3GMuGRKBnj6oG3lSBSs?=
 =?us-ascii?Q?i3QEHsPCIlSjy2HbVG6j86akr0c+Xrb6wvhFYyA38UrDR1nr2vC/hpL7AOfX?=
 =?us-ascii?Q?6y9iecjZb9zpXdr32NGM06yvenim12w6j6v+NenHQSMJyGlg03b3xT6kCXjO?=
 =?us-ascii?Q?88/40kojEeAGLi2kDh0aWLtkj5SS8z+nCd8MrcXUta63hf4uqIQLYjApiJT9?=
 =?us-ascii?Q?GYhE2n4sHnbaI/d4Zgk9zd/789zDGvFuJTRXcvt+KxL5lm6D7N83zTJSjw1I?=
 =?us-ascii?Q?HWXcSIT9+yUTyxoYVClPyOkrRDSfsJIZXKE4Rv231vw7G7X7KGDFlPskUUch?=
 =?us-ascii?Q?f2wsu8RJtMcggTtoKgg3iru/Uw80p6YlXpCTDBlAU1Gzz0DeOZ4/alhDmh+m?=
 =?us-ascii?Q?ATbnHbdABdZtiZqKhNSpjbR5w3b41ehAmojSAl2y9L+eVj45hEzGOQg6RVpj?=
 =?us-ascii?Q?sZC74V7s/j5xAdJ1Uw0/pNO7jxuNdgQYqTMUYM43TcinRjqblV4hrh+3QbRr?=
 =?us-ascii?Q?n98SPOjQnW9NONJRrn6M13+qWwFYvLRnTIAhn9X5hlqPWxGUeiOUsjmDqHXH?=
 =?us-ascii?Q?qn+tZs/4RmE0n86kBW5YcmOrckLvdNr68F8E1f8sJMJJlGs9/z+tO6M0Lsm/?=
 =?us-ascii?Q?K1J+uKgNt7PEaFKg8OcQFTmGcZotOPhSGEgwbYNu1K/TKUKM+PhIcNTccdin?=
 =?us-ascii?Q?hL95RBxG2Mqx0a8ULh8IVSVpP/Kyd0IJwaTZX95iEd3ooIXNH6cH9U8m9r/L?=
 =?us-ascii?Q?xqTy2OZIO1TaWtLtaXMMKJ534VJvwkmjzy4h1Z06nsHyt12lImj8wU/xT2/X?=
 =?us-ascii?Q?npeBquAw721GHp0JRziZxPqDFVgSAVTXshqpCbUq0lnhUM2Esbl8fhlxCj5L?=
 =?us-ascii?Q?ZTOoAD6dBc6ZR1Ghrlr7qEfnJcvyaSiBLmsl99vFP9gUdP8BIlLK+CJL4Fqu?=
 =?us-ascii?Q?RdaAkyKTwgLnnuvXOGH5p/TtrbABKhkjOKSX62GMuc+fPj0KQG19sTLNtIcm?=
 =?us-ascii?Q?nU01rZzCLCLwoMNFlCZmxHUv7/J6AJRKHsCu+SxVT3ptyzMhOZ3t4D4GPaGI?=
 =?us-ascii?Q?3wF60O8GAtKSorAWxvZS2YcxtNqEhlXIYKUos/5ZCHvEsiF6V69A4IAREEh6?=
 =?us-ascii?Q?+81ruNiYiFllTb8cCouANZYm1DWVv1F79YGwQYyfH958Fkgq4MjwzMjO6SK4?=
 =?us-ascii?Q?gpHWxo6xKzpFK+qcRtDfhrVzDrGbDRkQpCb0ubNKj6Xw0XI1ca6vdSMsjeU9?=
 =?us-ascii?Q?a88N4tBzrccvLZY5e1ihfnVb2gYw7sVwfX3FZl+nVISzCD3DCtPmnoi66QUT?=
 =?us-ascii?Q?c+nheZcD1qJrV5w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5420.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?amIliPwY88tajw8QU7iAWIEnTC3nNHCpzDcNOqGox3at4MG1RdzSlTMDQSz0?=
 =?us-ascii?Q?VKuabSHUiv2SfIJNf2jcMl1igY8X7uKGV2sszZ1iZ259PmiCNIgeBXTADDjF?=
 =?us-ascii?Q?VlfcZDZX+OEpBCC9f0qfQzdZDVjdDf+3y52vFzrLHq+4RSWUGW2cPR7l3U8d?=
 =?us-ascii?Q?ihV6M2eBE7dkZ/mO46JkQofoF8+XhA7+SY0QKRwbgDXX/MZL1ZpB1YdDXtVC?=
 =?us-ascii?Q?DEuEfK2o3a6di+n53qJXUX5xQwbr8UetB5EN77k11xPlz0WQQOCjGId9zb8P?=
 =?us-ascii?Q?oSBpZgo5aQGLyTfn9k02RxmxYj736XXKX51rfd7dQGgDpceXYLdXHUMa0EGW?=
 =?us-ascii?Q?1M9nPfx4VBDqHLlpsppKK8noLMsfpSAHl7YzB474p4KvkCkZoL0N+ZqY0D4I?=
 =?us-ascii?Q?UkRUptz/F3DckOTkrJrtVP33wTcO7oGBa8rKXt+YFlg8MsoUa0jHf9kkY6tX?=
 =?us-ascii?Q?jHtgHQqnfd4MEU1j3v1wfd2GGByN6XHTKbiZvSmMXni8dooNNeXTqPjEToja?=
 =?us-ascii?Q?eXYoOW+DY5D+xOpL92v1QXTb1pORBU3ijP0zE2fyJYurTR7kiEFdVJFtD+Kl?=
 =?us-ascii?Q?6c6AEYS1NT6xNNXHx04/1NReLYYrv2Xb3T056PWFMXG/xEOAac7jeRy9eITE?=
 =?us-ascii?Q?CaUvlbCXbTv0iEFlq+lHQE6zJn/M9mZrgIN39r8w6VOTW/KyO9aCR/Jp9M3u?=
 =?us-ascii?Q?bvlt48HTiUaS3VjJU0KNDr5Nzo2aRGv+LjI6TaA4bJTbNUTg27GqYaJQ75BK?=
 =?us-ascii?Q?gZc4jh5MLUX/Q3UMqgt0hgz3Y9nUz3f3LRPGkBGXKfhlL3Gl7q40Bj/27ywq?=
 =?us-ascii?Q?VFw/bJ5OEJsZ0+BE7yMPB3wW0B/BaKSDAxkRu5Cqf145pS7iB+WfxER3l5W8?=
 =?us-ascii?Q?1zUDpw2i2BqW8kseLveXeoqJ6bcQ90RHoNV8MtIIJOKsWPBQCnxB74jrgRgo?=
 =?us-ascii?Q?ZKaO7nAin9Xce2xw+5UvtM+90bHfawYAIxRjuexAnbR44oB3AGNwDnrrl8Xy?=
 =?us-ascii?Q?e95oVtUgzQ6pekOYJJiM2fbOFNQTPGD8kBnrKwYzA+xUblnDjyONrbx1Yls2?=
 =?us-ascii?Q?8XwZMBEpKWlxdriyko7WjB008SRKP/1WpAMDlFYSGeJFj2R90c2EwmJ+N9n2?=
 =?us-ascii?Q?+YuiMZEBFsDMbkZDhn8DmZCvLpC+RLvgJgAdrNTx8XXz7kDqWnDqsXPcw4to?=
 =?us-ascii?Q?509wCzeiGMzm0dkasb3MxLyi/LoH2c23jtO1kTXKJ72uZ6iExwRy5t7udfjU?=
 =?us-ascii?Q?Awj7y2+A++aD+d0pqQ0LB1Q2P6p0A7GZfTaPBp3ujfkn5ZdOc35zogD1keQZ?=
 =?us-ascii?Q?t8wrAdv6vgb22n+CNW7snHvOSmgssWWb9e32DYBNP3oocinbAYjs7RwXTJq5?=
 =?us-ascii?Q?CZgrhksFEEwXppDoojrgBsQV84yWlZ6+jF7Rh2h1RgbksIIJXzk+7886B1kj?=
 =?us-ascii?Q?3o4fGt0nEssHxt3ZQNrvzEjK6AP2OlMuJTFVtBx58Nj75dy6+P9RrPJ4ECxS?=
 =?us-ascii?Q?AtMcIoAS7VNoDeB6pxZxletCLtNO04RH2OReS4RN42Ognsw+2zR5L6cc5wk7?=
 =?us-ascii?Q?8cupLRuhnqvpDkHGOZ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5420.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef25c778-895c-4002-e5e3-08ddb53a48d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 05:20:09.0629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcD4Ld7bVGHJy1lhfFEgNt2bPkKQSY37oNyYUPtjlRTfmGukftNr3mJzYdva52Z0Lr7wRLXhLO7rTpOSyevQCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493
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

[AMD Official Use Only - AMD Internal Distribution Only]

Currently, amdgpu_flush is used to prevent new jobs from being submitted in=
 the same context when a file descriptor is closed and to wait for existing=
 jobs to complete. Additionally, if the current process is in an exit state=
 and the latest job of the entity was submitted by this process, the entity=
 is terminated.

There is an issue where, if drm scheduler is not woken up for some reason, =
the amdgpu_flush will remain hung, and another process holding this file ca=
nnot submit a job to wake up the drm scheduler.

The intended purpose of the flush operation in linux is to flush the conten=
t written by the current process to the hardware, rather than shutting down=
 related services upon the process's exit, which would prevent other proces=
ses from using them. Now, amdgpu_flush cannot execute concurrently with com=
mand submission ioctl, which also leads to performance degradation.

An example of a shared DRM file is when systemd stop the display manager; s=
ystemd will close the file descriptor of Xorg that it holds.

Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: amdgpu_ctx_get: locked by othe=
r task times 8811
Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: owner stack:
Jun 11 16:24:24 ubuntu2404-2 kernel: task:(sd-rmrf)       state:D stack:0  =
   pid:3407  tgid:3407  ppid:1      flags:0x00004002
Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
Jun 11 16:24:24 ubuntu2404-2 kernel:  __schedule+0x279/0x6b0
Jun 11 16:24:24 ubuntu2404-2 kernel:  schedule+0x29/0xd0
Jun 11 16:24:24 ubuntu2404-2 kernel:  amddrm_sched_entity_flush+0x13e/0x270=
 [amd_sched]
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_autoremove_wake_function+0x10=
/0x10
Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_mgr_entity_flush+0xd6/0x20=
0 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_flush+0x29/0x50 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_flush+0x38/0x90
Jun 11 16:24:24 ubuntu2404-2 kernel:  filp_close+0x14/0x30
Jun 11 16:24:24 ubuntu2404-2 kernel:  __close_range+0x1b0/0x230
Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_close_range+0x17/0x30
Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x1e0f/0x25f0
Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __count_memcg_events+0x86/0x160
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? count_memcg_events.constprop.0+0x2a=
/0x50
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? handle_mm_fault+0x1df/0x2d0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_user_addr_fault+0x5d5/0x870
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit_to_user_mode+0x43/0x2=
50
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? irqentry_exit+0x43/0x50
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? exc_page_fault+0x96/0x1c0
Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0=
x7e
Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x762b6df1677b
Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffdb20ad718 EFLAGS: 000=
00246 ORIG_RAX: 00000000000001b4
Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 00000000000=
00000 RCX: 0000762b6df1677b
Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 0000000000000000 RSI: 000000007ff=
fffff RDI: 0000000000000003
Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffdb20ad730 R08: 00000000000=
00000 R09: 0000000000000000
Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000000000000008 R11: 00000000000=
00246 R12: 0000000000000007
Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000000 R14: 00000000000=
00000 R15: 0000000000000000
Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>
Jun 11 16:24:24 ubuntu2404-2 kernel: amdgpu: current stack:
Jun 11 16:24:24 ubuntu2404-2 kernel: task:Xorg            state:R  running =
task     stack:0     pid:2343  tgid:2343  ppid:2341   flags:0x00000008
Jun 11 16:24:24 ubuntu2404-2 kernel: Call Trace:
Jun 11 16:24:24 ubuntu2404-2 kernel:  <TASK>
Jun 11 16:24:24 ubuntu2404-2 kernel:  sched_show_task+0x122/0x180
Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_ctx_get+0xf6/0x120 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_cs_ioctl+0xb6/0x2110 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? update_cfs_group+0x111/0x120
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? enqueue_entity+0x3a6/0x550
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [am=
dgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl_kernel+0xbc/0x120
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  drm_ioctl+0x2f6/0x5b0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_amdgpu_cs_ioctl+0x10/0x10 [am=
dgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  amdgpu_drm_ioctl+0x4e/0x90 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  __x64_sys_ioctl+0xa3/0xf0
Jun 11 16:24:24 ubuntu2404-2 kernel:  x64_sys_call+0x11ad/0x25f0
Jun 11 16:24:24 ubuntu2404-2 kernel:  do_syscall_64+0x7e/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? ksys_read+0xe6/0x100
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? idr_find+0xf/0x20
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_array_free+0x5a/0x80
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_syncobj_reset_ioctl+0xbd/0xd0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/=
0x10
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl_kernel+0xbc/0x120
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __check_object_size.part.0+0x3a/0x1=
50
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? _copy_to_user+0x41/0x60
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? drm_ioctl+0x326/0x5b0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pfx_drm_syncobj_reset_ioctl+0x10/=
0x10
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? kvm_clock_get_cycles+0x18/0x40
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __pm_runtime_suspend+0x7b/0xd0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? amdgpu_drm_ioctl+0x70/0x90 [amdgpu]
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? __x64_sys_ioctl+0xbb/0xf0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x25=
0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? syscall_exit_to_user_mode+0x4e/0x25=
0
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? srso_return_thunk+0x5/0x5f
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? do_syscall_64+0x8a/0x170
Jun 11 16:24:24 ubuntu2404-2 kernel:  ? sysvec_apic_timer_interrupt+0x57/0x=
c0
Jun 11 16:24:24 ubuntu2404-2 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0=
x7e
Jun 11 16:24:24 ubuntu2404-2 kernel: RIP: 0033:0x7156c3524ded
Jun 11 16:24:24 ubuntu2404-2 kernel: Code: 04 25 28 00 00 00 48 89 45 c8 31=
 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8=
 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 =
28 00 00 00
Jun 11 16:24:24 ubuntu2404-2 kernel: RSP: 002b:00007ffe4afcc410 EFLAGS: 000=
00246 ORIG_RAX: 0000000000000010
Jun 11 16:24:24 ubuntu2404-2 kernel: RAX: ffffffffffffffda RBX: 0000578954b=
74cf8 RCX: 00007156c3524ded
Jun 11 16:24:24 ubuntu2404-2 kernel: RDX: 00007ffe4afcc4f0 RSI: 00000000c01=
86444 RDI: 0000000000000012
Jun 11 16:24:24 ubuntu2404-2 kernel: RBP: 00007ffe4afcc460 R08: 00007ffe4af=
cc7a0 R09: 00007ffe4afcc4b0
Jun 11 16:24:24 ubuntu2404-2 kernel: R10: 0000578954b862f0 R11: 00000000000=
00246 R12: 00000000c0186444
Jun 11 16:24:24 ubuntu2404-2 kernel: R13: 0000000000000012 R14: 00000000000=
00060 R15: 0000578954b46380
Jun 11 16:24:24 ubuntu2404-2 kernel:  </TASK>

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 2bb02fe9c880..ee6b59bfd798 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2947,22 +2947,9 @@ static const struct dev_pm_ops amdgpu_pm_ops =3D {
        .runtime_idle =3D amdgpu_pmops_runtime_idle,  };

-static int amdgpu_flush(struct file *f, fl_owner_t id) -{
-       struct drm_file *file_priv =3D f->private_data;
-       struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
-       long timeout =3D MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
-
-       timeout =3D amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
-       timeout =3D amdgpu_vm_wait_idle(&fpriv->vm, timeout);
-
-       return timeout >=3D 0 ? 0 : timeout;
-}
-
 static const struct file_operations amdgpu_driver_kms_fops =3D {
        .owner =3D THIS_MODULE,
        .open =3D drm_open,
-       .flush =3D amdgpu_flush,
        .release =3D drm_release,
        .unlocked_ioctl =3D amdgpu_drm_ioctl,
        .mmap =3D drm_gem_mmap,
--
2.25.1

