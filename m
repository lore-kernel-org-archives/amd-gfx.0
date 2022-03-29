Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614B3C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 15:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F3B10F0B4;
	Tue, 29 Mar 2022 15:12:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8DB10F0BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 15:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbbTxuieZFumq4xS8Kic7CX7Zjl59NbPo9+Yf1xTOEg3w7pFq/rPxfYwSTz3eLXb9NP/Jxfja8AO2V4CbrZkaqmMckYgRCr6051Eqog25+2G8Lk0eEFWiYMdp2fvDGg8zziv8GlOqXQwBQZelG4UApqw6FfWjmv8D1ZxeXrg9wtoFuIGp6CQ52sRyRJ+YqPUbvV+StKkxp1cvyAR9E+JMAx1HgLK2mhJfbe/SSkhglMBWT9dJhnqCvZ2pCxyi0D22ot/25jeNov+WhPcBX1skEUV+xeDJUH9pDVcQ9d1DBwUrU2DQvTCxKlBDYVL2hmWZj+taEzwp5yokOiCTcbYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHrFBf2qYXEQono5dDUxLafZVUQbirspszE+AMwg2Ic=;
 b=jO4hKk42U8tX/JB61I1lEGsynELCZuAAA7a16ABznlqgz/8tQr/WFfK+JhdPISLQz7uCIF/fTEN0iSSmouj0JNa8WQ7MpPTOAKu90A0rWLpyQRX8HT5qP5wEsQAjGFSrxhxE30C8jWujy72VyviL1qik3H3LzuODAmM2OXH1Ap2P5rIjcvE7B332VPlM0bTRpoQpTmgrvLZWiqc/0fW9rFY+AhG61hep/DCwlAbHiyJkKnfQEwbcjpnrdu/+jNVFcTEwdvmiCoKX8x4aMJhq4xNjhSh0NBgi4Pw4GIgjYuHunEXSNUiOp+SrIjEIsQBPKXWHeHt4m0rrt+zse6Rq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHrFBf2qYXEQono5dDUxLafZVUQbirspszE+AMwg2Ic=;
 b=E1j3mX/5jcEyvhYt2wdPOw85AGjiz9avTF9wtP2QTDKty9oK3dFy065owUK+/311viNcZ+DHHfQ8RHN8G1AvJfi1Kso4Mw+nn0BeUxr7OGZ6cmNC+S4EHJxq9rh0GoDedV7pOCqYVfa+RgXy4JUFbDOvsQo8HeSWvKhukiS0Yi8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Tue, 29 Mar
 2022 15:11:59 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::4566:560c:e193:d210%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 15:11:59 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "VURDIGERENATARAJ, CHANDAN" <CHANDAN.VURDIGERENATARAJ@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Thread-Topic: [PATCH] drm/amd/display: Fix by adding FPU protection for
 dcn30_internal_validate_bw
Thread-Index: AQHYQ0dHCcjlT4YPpEyh8WPA0XdQUKzWeAOX
Date: Tue, 29 Mar 2022 15:11:58 +0000
Message-ID: <BL1PR12MB51443CF3272C32EFFAC13087F71E9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
In-Reply-To: <20220329082957.1662655-1-chandan.vurdigerenataraj@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-29T15:11:58.441Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: dbf6950e-a0e8-297a-63ba-e8bbc02fb8b4
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac592900-abe2-4452-de27-08da11967882
x-ms-traffictypediagnostic: BY5PR12MB3713:EE_
x-microsoft-antispam-prvs: <BY5PR12MB371316735A6DABE78FF4BEF1F71E9@BY5PR12MB3713.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nyizEk+S98ZRxgWXBgIl7IbZgsFdZmymUm5zdyMbZvDtos+/wD/axoVH4cPopkGV4kuXGdBFYNfRh2s9hwUduzNfyy3Tl2q0/64PLKms1XbHm2Sw+WzCQZQi6hfUQUWyveKqWItnfTFAAOu0d1IXEeEIdIkhv5H+TRtQKmOgPgukuggQ2/sUu6tRH7y5srEclxnrso4DAm3y+3fcLPoVrilzU8F1r2RmueQAG3ubw98xjHPcIg88cMF70u7VhODqMqs4cotiXUklOZb4R7Rwo382H31/P5Vi9gP1LjlijdD4/WBwk6oVHqku5JXLqsxhrRlEw/SDEGZs3+PPYTLXeQLC2+dxpRt3xtWQMxY4qxD58ZFI+gVXH+taCRxd83H5JX9JWotN+c3W+1FdF3dOnteXLv9G7GASxN7ePggRIN6aeLSzgFba5AX+MX8xBHT1VHbZ8P4vjlMGLwf5/hgWv3sjmsn/NpPP/lrLO5JeX71mMir49pVAsVPvM8CxRYrtAyNwphtDn3WzAvA27j0Km3BjOTwbOl9699QJbt6QBzRuKSzWHI623fBF3nmCOfUgFjCNVqjM6OBuNm4TqI+bkmIPutGx/YfKmK/3mAxXsa18liFBdKRPELely7SihRCSkk5RiRzwG5rI91pxGnQyhO381d7PYdZFR0El1X4wmV4C2Glj30YyocE87EN2WZUtghhFPF9cIIT7zPD8boojJg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(186003)(9686003)(83380400001)(26005)(55016003)(19627405001)(508600001)(53546011)(7696005)(6506007)(2906002)(4326008)(64756008)(76116006)(52536014)(86362001)(66476007)(66556008)(71200400001)(66446008)(8936002)(122000001)(38070700005)(66946007)(33656002)(38100700002)(110136005)(8676002)(6636002)(5660300002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b0rv1R6kQ1dXiKGchMKglRHLXui4UqTz+82pDZP+TxbCofoRAQ+vviqql9ty?=
 =?us-ascii?Q?wcPKMJx1IfWaGYC6o9w9AzPBUPYWpOWr5maKziEr90q+b2qrHiw0/Wy9/ph2?=
 =?us-ascii?Q?39s+uUYR7emQS/PEC0T4S9PMKmEZlHgz+qjPSEshFFnTZ4BKiVk7qngtB6ul?=
 =?us-ascii?Q?++Itf3pyxdM11brjX26NjvTIveEsEGw4MOJ2AeKGgv2JIAwcy5wot6S3oaT5?=
 =?us-ascii?Q?CgCRceZ8dtqjPiJG80KAxJY49lWqI34fICmgFX0ngk3wmJ6D8eOb9+spZiMJ?=
 =?us-ascii?Q?PrTIQNWgQM3wdfZ/Z2YInYS/j5JDs5zZ1kq8Ii+xTx7HVOxAvrKe5lC5wkBo?=
 =?us-ascii?Q?FJMvg00lC8q7uoToLGduWk8JtApZ3BvXyKvR+f9UoJnB+ZyCAPfRWUxvfvl9?=
 =?us-ascii?Q?QPHBVxIFTYIhRNnrcQrEfFrp5cIWeHnWM1pcepUvuANStB7fOdzhIklXDqQW?=
 =?us-ascii?Q?pIl+gZFQDUoJxHrbjj0aQkNR2FmFD5U8n0ypG8wtO+lO8ZibkTpxK8k/VFZd?=
 =?us-ascii?Q?M57RieVWGs1d2VUuHDt0nWd2E4mNx7T10MvHHV8YVqSFR7FtQhAMaD88c5G/?=
 =?us-ascii?Q?s/9SNW7zorjpfnytGGn5uqU51Z4bKOPlju/6uiXxa+LoXX2500RhXYmjwifr?=
 =?us-ascii?Q?oDWxS1+U6Qujt3qEdy9Z/ooZ6Z9IgomMLD18HdPQ+4WxiFNkq7VOsZ5ZsQBF?=
 =?us-ascii?Q?KSCo7cJOzcRTj7yMjSp9dMQue85Mm6KbS3JVBlH0j4OhPjTAmwTygu1vn0Aj?=
 =?us-ascii?Q?etjF9EzJjvM6C3jN1PEYq3j9u7f4H7DlIVEH++ICmqmZZq6tpUnsPEuOr/Ek?=
 =?us-ascii?Q?wd8htgGwtMlIEdafFk6Xs3HzW+nrRuBgi66b4oSb4D1AUr4DxEX29kcHFzPr?=
 =?us-ascii?Q?ihyQv/sgrrTXCKaTOR+4Pz7dPzeeX9eILNysgkITBUskUiH9c4X6vaIefILm?=
 =?us-ascii?Q?V/oo+SKUqfd7uY9593UXkfQ9+Y6xjohTamB5Zfi7J3xa6rQ7X1LyaMVGJDdx?=
 =?us-ascii?Q?UZePRyjFLTPuWJ5q5cngaiDRQ0qfaD/mhKGoL//pjuIDcxgBGbsWCGAzS4+J?=
 =?us-ascii?Q?bczXY6H0aiyQ19bK4856BYQ28yYv7r0VKdCAJYrhOHUu97+/sTdu/qi7we/x?=
 =?us-ascii?Q?KYWIJlCmqqxIOLtAKffWvlYLsaQx3SqcYX2gocfh9VcwDz6aEvwxGWosMHBV?=
 =?us-ascii?Q?z0Xv6pVaYU0LnL2fXJK4jzrU//v+NtYyqkKxbJRInWWBoxgX3VOQNvFPx8vV?=
 =?us-ascii?Q?Cd/RGMRHVpe/P81gfJVYaU+w48eOayV7ZwkxgL9gZP+foK/RMENliyN2vW83?=
 =?us-ascii?Q?eaem1vVrrOo6GMzDj0ubvoLPy90zbZxLKQyvSL1IwvhJuIeP4VyTvyUEHk4h?=
 =?us-ascii?Q?SM5baJJvUqqDIhkAh7TPs0D23gEHX2eFlb+Dnv6fxDbMF2N/jiqKqBDzPDbq?=
 =?us-ascii?Q?N8Wp27LA4S3lXTHDUlkyIxrpkTzVJ6/4H9CTrrmA4FVxtI0ie7SPyNRwiT77?=
 =?us-ascii?Q?PrHOZbugmLjg35hJpsng4S+1CP5bLBRxl+zzavrPGRWeRlZehRzRiUiNzZWk?=
 =?us-ascii?Q?XUbksXtiZCKZV7/ZkhlsfpCVG9YpsdY553yYyt4rxamU4p85E8l0c770BucV?=
 =?us-ascii?Q?SJOCVCt/7mS5niisrnVPXobg/WMnmf6uSawTtZIjhwJOIShIcMGFfIGIKMSR?=
 =?us-ascii?Q?ZtRgGMXLGKYyq5ELq98mwqWrcNTjRWHDRwAStH41/bzdVUP9imoLRtYDcO5u?=
 =?us-ascii?Q?NgZSs/F6nw=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443CF3272C32EFFAC13087F71E9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac592900-abe2-4452-de27-08da11967882
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 15:11:59.0018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRgFdTemaGPufm9zPG8UUf8/ZJ+k8TPxgj65FRly0er3RGabc1bJtAL11Q2y1qiJuVwAFF32QBAtjTqYlAW83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51443CF3272C32EFFAC13087F71E9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of CHANDAN =
VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>
Sent: Tuesday, March 29, 2022 4:29 AM
To: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: VURDIGERENATARAJ, CHANDAN <CHANDAN.VURDIGERENATARAJ@amd.com>; amd-gfx@l=
ists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix by adding FPU protection for dcn30_in=
ternal_validate_bw

[WHY]
Below general protection fault observed when WebGL Aquarium is run for
longer duration. If drm debug logs are enabled and set to 0x1f then the
issue is observed within 10 minutes of run.

[  100.717056] general protection fault, probably for non-canonical address=
 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI
[  100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G        W        =
 5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b
[  100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f
[  100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00 f2 42 =
0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10 0f 57 c0 <f3=
> 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff 48 8b
[  100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246
[  100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX: 00000000000=
00000
[  100.819656] RDX: 0000000000000001 RSI: ffff99deb712c49c RDI: 00000000000=
00000
[  100.826781] RBP: ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99deb71=
2462c
[  100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12: ffff99deb71=
2ae44
[  100.841033] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa923007=
9f0a0
[  100.848159] FS:  00007af121212640(0000) GS:ffff99deba780000(0000) knlGS:=
0000000000000000
[  100.856240] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  100.861980] CR2: 0000209000fe1000 CR3: 000000011b18c000 CR4: 00000000003=
50ee0
[  100.869106] Call Trace:
[  100.871555]  <TASK>
[  100.873655]  ? asm_sysvec_reschedule_ipi+0x12/0x20
[  100.878449]  CalculateSwathAndDETConfiguration+0x1a3/0x6dd
[  100.883937]  dml31_ModeSupportAndSystemConfigurationFull+0x2ce4/0x76da
[  100.890467]  ? kallsyms_lookup_buildid+0xc8/0x163
[  100.895173]  ? kallsyms_lookup_buildid+0xc8/0x163
[  100.899874]  ? __sprint_symbol+0x80/0x135
[  100.903883]  ? dm_update_plane_state+0x3f9/0x4d2
[  100.908500]  ? symbol_string+0xb7/0xde
[  100.912250]  ? number+0x145/0x29b
[  100.915566]  ? vsnprintf+0x341/0x5ff
[  100.919141]  ? desc_read_finalized_seq+0x39/0x87
[  100.923755]  ? update_load_avg+0x1b9/0x607
[  100.927849]  ? compute_mst_dsc_configs_for_state+0x7d/0xd5b
[  100.933416]  ? fetch_pipe_params+0xa4d/0xd0c
[  100.937686]  ? dc_fpu_end+0x3d/0xa8
[  100.941175]  dml_get_voltage_level+0x16b/0x180
[  100.945619]  dcn30_internal_validate_bw+0x10e/0x89b
[  100.950495]  ? dcn31_validate_bandwidth+0x68/0x1fc
[  100.955285]  ? resource_build_scaling_params+0x98b/0xb8c
[  100.960595]  ? dcn31_validate_bandwidth+0x68/0x1fc
[  100.965384]  dcn31_validate_bandwidth+0x9a/0x1fc
[  100.970001]  dc_validate_global_state+0x238/0x295
[  100.974703]  amdgpu_dm_atomic_check+0x9c1/0xbce
[  100.979235]  ? _printk+0x59/0x73
[  100.982467]  drm_atomic_check_only+0x403/0x78b
[  100.986912]  drm_mode_atomic_ioctl+0x49b/0x546
[  100.991358]  ? drm_ioctl+0x1c1/0x3b3
[  100.994936]  ? drm_atomic_set_property+0x92a/0x92a
[  100.999725]  drm_ioctl_kernel+0xdc/0x149
[  101.003648]  drm_ioctl+0x27f/0x3b3
[  101.007051]  ? drm_atomic_set_property+0x92a/0x92a
[  101.011842]  amdgpu_drm_ioctl+0x49/0x7d
[  101.015679]  __se_sys_ioctl+0x7c/0xb8
[  101.015685]  do_syscall_64+0x5f/0xb8
[  101.015690]  ? __irq_exit_rcu+0x34/0x96

[HOW]
It calles populate_dml_pipes which uses doubles to initialize.
Adding FPU protection avoids context switch and probable loss of vba contex=
t
as there is potential contention while drm debug logs are enabled.

Signed-off-by: CHANDAN VURDIGERE NATARAJ <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 826970f2bd0a..f27262417abe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,

         BW_VAL_TRACE_COUNT();

+       DC_FP_START();
         out =3D dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, =
&vlevel, fast_validate);
+       DC_FP_END();

         // Disable fast_validate to set min dcfclk in alculate_wm_and_dlg
         if (pipe_cnt =3D=3D 0)
--
2.25.1


--_000_BL1PR12MB51443CF3272C32EFFAC13087F71E9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of CHANDAN VURDIGERE NATARAJ &lt=
;chandan.vurdigerenataraj@amd.com&gt;<br>
<b>Sent:</b> Tuesday, March 29, 2022 4:29 AM<br>
<b>To:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Le=
o) &lt;Sunpeng.Li@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd=
.com&gt;<br>
<b>Cc:</b> VURDIGERENATARAJ, CHANDAN &lt;CHANDAN.VURDIGERENATARAJ@amd.com&g=
t;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fix by adding FPU protection for d=
cn30_internal_validate_bw</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[WHY]<br>
Below general protection fault observed when WebGL Aquarium is run for<br>
longer duration. If drm debug logs are enabled and set to 0x1f then the<br>
issue is observed within 10 minutes of run.<br>
<br>
[&nbsp; 100.717056] general protection fault, probably for non-canonical ad=
dress 0x2d33302d32323032: 0000 [#1] PREEMPT SMP NOPTI<br>
[&nbsp; 100.727921] CPU: 3 PID: 1906 Comm: DrmThread Tainted: G&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 5.15.30 #12 d726c6a2d6ebe5cf9223931cbca6892f916fe18b<br>
[&nbsp; 100.754419] RIP: 0010:CalculateSwathWidth+0x1f7/0x44f<br>
[&nbsp; 100.767109] Code: 00 00 00 f2 42 0f 11 04 f0 48 8b 85 88 00 00 00 f=
2 42 0f 10 04 f0 48 8b 85 98 00 00 00 f2 42 0f 11 04 f0 48 8b 45 10 0f 57 c=
0 &lt;f3&gt; 42 0f 2a 04 b0 0f 57 c9 f3 43 0f 2a 0c b4 e8 8c e2 f3 ff 48 8b=
<br>
[&nbsp; 100.781269] RSP: 0018:ffffa9230079eeb0 EFLAGS: 00010246<br>
[&nbsp; 100.812528] RAX: 2d33302d32323032 RBX: 0000000000000500 RCX: 000000=
0000000000<br>
[&nbsp; 100.819656] RDX: 0000000000000001 RSI: ffff99deb712c49c RDI: 000000=
0000000000<br>
[&nbsp; 100.826781] RBP: ffffa9230079ef50 R08: ffff99deb712460c R09: ffff99=
deb712462c<br>
[&nbsp; 100.833907] R10: ffff99deb7124940 R11: ffff99deb7124d70 R12: ffff99=
deb712ae44<br>
[&nbsp; 100.841033] R13: 0000000000000001 R14: 0000000000000000 R15: ffffa9=
230079f0a0<br>
[&nbsp; 100.848159] FS:&nbsp; 00007af121212640(0000) GS:ffff99deba780000(00=
00) knlGS:0000000000000000<br>
[&nbsp; 100.856240] CS:&nbsp; 0010 DS: 0000 ES: 0000 CR0: 0000000080050033<=
br>
[&nbsp; 100.861980] CR2: 0000209000fe1000 CR3: 000000011b18c000 CR4: 000000=
0000350ee0<br>
[&nbsp; 100.869106] Call Trace:<br>
[&nbsp; 100.871555]&nbsp; &lt;TASK&gt;<br>
[&nbsp; 100.873655]&nbsp; ? asm_sysvec_reschedule_ipi+0x12/0x20<br>
[&nbsp; 100.878449]&nbsp; CalculateSwathAndDETConfiguration+0x1a3/0x6dd<br>
[&nbsp; 100.883937]&nbsp; dml31_ModeSupportAndSystemConfigurationFull+0x2ce=
4/0x76da<br>
[&nbsp; 100.890467]&nbsp; ? kallsyms_lookup_buildid+0xc8/0x163<br>
[&nbsp; 100.895173]&nbsp; ? kallsyms_lookup_buildid+0xc8/0x163<br>
[&nbsp; 100.899874]&nbsp; ? __sprint_symbol+0x80/0x135<br>
[&nbsp; 100.903883]&nbsp; ? dm_update_plane_state+0x3f9/0x4d2<br>
[&nbsp; 100.908500]&nbsp; ? symbol_string+0xb7/0xde<br>
[&nbsp; 100.912250]&nbsp; ? number+0x145/0x29b<br>
[&nbsp; 100.915566]&nbsp; ? vsnprintf+0x341/0x5ff<br>
[&nbsp; 100.919141]&nbsp; ? desc_read_finalized_seq+0x39/0x87<br>
[&nbsp; 100.923755]&nbsp; ? update_load_avg+0x1b9/0x607<br>
[&nbsp; 100.927849]&nbsp; ? compute_mst_dsc_configs_for_state+0x7d/0xd5b<br=
>
[&nbsp; 100.933416]&nbsp; ? fetch_pipe_params+0xa4d/0xd0c<br>
[&nbsp; 100.937686]&nbsp; ? dc_fpu_end+0x3d/0xa8<br>
[&nbsp; 100.941175]&nbsp; dml_get_voltage_level+0x16b/0x180<br>
[&nbsp; 100.945619]&nbsp; dcn30_internal_validate_bw+0x10e/0x89b<br>
[&nbsp; 100.950495]&nbsp; ? dcn31_validate_bandwidth+0x68/0x1fc<br>
[&nbsp; 100.955285]&nbsp; ? resource_build_scaling_params+0x98b/0xb8c<br>
[&nbsp; 100.960595]&nbsp; ? dcn31_validate_bandwidth+0x68/0x1fc<br>
[&nbsp; 100.965384]&nbsp; dcn31_validate_bandwidth+0x9a/0x1fc<br>
[&nbsp; 100.970001]&nbsp; dc_validate_global_state+0x238/0x295<br>
[&nbsp; 100.974703]&nbsp; amdgpu_dm_atomic_check+0x9c1/0xbce<br>
[&nbsp; 100.979235]&nbsp; ? _printk+0x59/0x73<br>
[&nbsp; 100.982467]&nbsp; drm_atomic_check_only+0x403/0x78b<br>
[&nbsp; 100.986912]&nbsp; drm_mode_atomic_ioctl+0x49b/0x546<br>
[&nbsp; 100.991358]&nbsp; ? drm_ioctl+0x1c1/0x3b3<br>
[&nbsp; 100.994936]&nbsp; ? drm_atomic_set_property+0x92a/0x92a<br>
[&nbsp; 100.999725]&nbsp; drm_ioctl_kernel+0xdc/0x149<br>
[&nbsp; 101.003648]&nbsp; drm_ioctl+0x27f/0x3b3<br>
[&nbsp; 101.007051]&nbsp; ? drm_atomic_set_property+0x92a/0x92a<br>
[&nbsp; 101.011842]&nbsp; amdgpu_drm_ioctl+0x49/0x7d<br>
[&nbsp; 101.015679]&nbsp; __se_sys_ioctl+0x7c/0xb8<br>
[&nbsp; 101.015685]&nbsp; do_syscall_64+0x5f/0xb8<br>
[&nbsp; 101.015690]&nbsp; ? __irq_exit_rcu+0x34/0x96<br>
<br>
[HOW]<br>
It calles populate_dml_pipes which uses doubles to initialize.<br>
Adding FPU protection avoids context switch and probable loss of vba contex=
t<br>
as there is potential contention while drm debug logs are enabled.<br>
<br>
Signed-off-by: CHANDAN VURDIGERE NATARAJ &lt;chandan.vurdigerenataraj@amd.c=
om&gt;<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
index 826970f2bd0a..f27262417abe 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c<br>
@@ -1750,7 +1750,9 @@ bool dcn31_validate_bandwidth(struct dc *dc,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BW_VAL_TRACE_COUNT();<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_START();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out =3D dcn30_internal_val=
idate_bw(dc, context, pipes, &amp;pipe_cnt, &amp;vlevel, fast_validate);<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_FP_END();<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Disable fast_validate t=
o set min dcfclk in alculate_wm_and_dlg<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pipe_cnt =3D=3D 0)<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51443CF3272C32EFFAC13087F71E9BL1PR12MB5144namp_--
