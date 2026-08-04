Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2356C55ABA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 19:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8D510E1D8;
	Tue,  4 Aug 2026 19:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EAWGhuDH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D635C10EB8D
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 19:14:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPILmOZNO/GKyjKQMLlDvXS540Ikqc7pU/w4LCOhOxbUOGLZYaWtwn5X+hSJMDeNhJPCFEBlUduM2fFDMr9jzo2vqTOhGA1T/gzjdE3iJTyRhDywpk5CAwlvt3Nevy/fie3XFKV2QuTS13fhAz4MYKXG7jqucBlKafttXAWQS17ijJbKEgjMwprFsgBE7R+EDlsiSTDVniWGfA/f+KlPoVQR9pi81BxrPLJ9slkA6rZEUiupMvpEVDCa2kUgIeOa2v745eecAWFIjP4ueckUQU9W3KEPAgab0jQRt0rWxnoY18YbGAlcJuzZwB5W0bg+nM8JpBtPgRzKG7kzyYcR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=709km8RWeCnpJNMFhJO4p9uvOdXJ9Joo3jsz/yEADhk=;
 b=G359GVzbuG1swfbvtvHRsqTBo5ppZsfI38ATq3V4cavEPBsgadBHhZRL9Bd6dgJ8L2k8vZcBCsk3m4AJriS9G2qyWZCpY0vONKggar9MzGWAUveMY/RNzfBKzT0FQpYKf2WzLJ0GAQa0NQz39u1a+KThuU2jASYOydYSqFq+Gvo0HJ9hf6+SGXgYuPvtr4dCQCKxLJPrP2JewXOy+it/imR3Ts9h+nc6wuoY/kOoH+nanzs8zm4BgXhjukEFQqhHK2wmrPlo6/ACXqdwRLYH1AtCr9Jm1BzRMAroj5RGGmdKW+19gwbFmoiTIgevIJZu1FpKMoJMOLDibsmGNgdFpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=709km8RWeCnpJNMFhJO4p9uvOdXJ9Joo3jsz/yEADhk=;
 b=EAWGhuDHMM6+r8+dj7IV9AGzPPJxOsNFuM37FRKxwbLXSoRD+IIlL6IpjWrRb2hSyRgzJwpmWaeV9BedV9gCDirx/qt7uber5XZjMMuUr3UquswggmNNhRqZiaWUiBmCX+xPU6GFy/6D5M8ZBn35NBb8yWsxcsCfQRdGwF9v/Mg=
Received: from DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) by
 SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 19:14:21 +0000
Received: from DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b]) by DM6PR12MB3611.namprd12.prod.outlook.com
 ([fe80::7861:6815:8b7d:bd0b%4]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 19:14:21 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini
Thread-Topic: [PATCH] drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini
Thread-Index: AQHdI+Xevx5wGf2WckWzpU7U0v61j7aOQwWq
Date: Tue, 4 Aug 2026 19:14:21 +0000
Message-ID: <DM6PR12MB361149752AE3CA5C022B41C194D42@DM6PR12MB3611.namprd12.prod.outlook.com>
References: <20260804074952.309764-1-Prike.Liang@amd.com>
In-Reply-To: <20260804074952.309764-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-04T19:14:16.456Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3611:EE_|SA3PR12MB8803:EE_
x-ms-office365-filtering-correlation-id: b8dc4a49-ceea-491a-4192-08def25c96dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003|8096899003|38070700021;
x-microsoft-antispam-message-info: 3qsshzrvDWKl06LZcNJqWY55pxI8s9iqcK1/PDdkWA2KC2cUV5jh/EoaTZpHBXFNVAQEjZNYGLUCvO9y4twhgdP533rvrbWAuxJ9af4VfDoQSLwRkeEABUV9FvHMPisBlyrEnFIidAxkQBMtsry6Xneh7Tb85Mu/iXQ6dB4Hluq4wdHPcsSJ7si2sJXmztTdgt1qny7LAytPBSP9GFFI152jHQjUxm9rhkHxO0JFaBQPynK2N1A+7J82e/fTp/oCLJbWs93AsIO4ec/n0kZ+0QwOJohHxuris7ZiPrjjNFgfOSNVPWOMY/ISaRyMa6gkCVGXfiamHN66jR9L7C1QJRre55fKoz1ypI3viOQMTOQW6SN93DYRnHXlI5+b1sLj44NCiJOxOF54R+9dIQt4o4BB5czZ4kT6EkTSkdN/cuGTc/btrX7OpUekxnvSmLVvwcYRZzMECdYpcRhaeq1XqDgPZKr04OfuOSjE4rvghN2CyPhW2pzodGVNGCu5IFnzD16Xhgh+rBsxGqButAnmGVBZULOnK0sdq4+FWdUnoWrvYEVK+D+ffwHNJlMEu8mnSGQzFNKvGPEd4jKFv6/64kV5GxI0v8R8/pu9++QJCXb70245puir0Umpda2zIQubOwODvAjc0q6YVdx4iX/8aIuLabjkk6q79qyCWwJooeKn5zYfT6n8dyLgWVTPn92T2MzUs2+IhSg1pisUFfBOO6tqTJhCQ70ad+8GMWVY9Ws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(8096899003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BtXZviX6lgRXMTUVqjiZ2G8Cb294UeYrbZUiIEFIdGpLigNTJ2mU9pir4Qvu?=
 =?us-ascii?Q?aFRGegjUvkVge87khOlBsVejPlTgPiccN6yi6QnqTZAxDJz5JMnw+9IVHb6A?=
 =?us-ascii?Q?OxxyLB1BUQRdgBzuQrEOECOwRjLOYpmMO0xQtrndI3gJKItX77dj57xZs5jY?=
 =?us-ascii?Q?fBgU1QQ0+xqoEfWAZcC0sCY5V85EAT5kXM99SqvkwVxuXAtZ+FgkTDfaPhTp?=
 =?us-ascii?Q?sZu8tuCvmqVbAYn+aOIIAzOrM+F4YREzJJ0BWjK67hFiL70jbfyXrBPpnplf?=
 =?us-ascii?Q?+ok17ktq0HFmfpI6XJ9kB5zM5tgOp1YvXzstMar9UqUiy6LZMSNGL3sb7zSL?=
 =?us-ascii?Q?GiUCDyGR8mtltdV3xUyum57EfwfwmF9dMXJZnUadKwmexFhVbYdri7w7QSfs?=
 =?us-ascii?Q?q3n1DP0JBMBHIv7ZyFc76l8FJzLfB5wYBHZnUePil7iGRGZ18WIRLp9ikwqU?=
 =?us-ascii?Q?v2+vvFukx/9lw8pS8hGB/OsFByyRV8MCiCXuj8w3p3bBo1Z6+QY9FnDUaH7U?=
 =?us-ascii?Q?glpP9tzI6YoMltf+Ha/j3KMSDtBA8Giv7fmVyjmRzD7WFW/ZJefoRbXVqE24?=
 =?us-ascii?Q?asE3UV3QShWu3blPpOSuP4TRko5ydx/BhiDYxBOC9JqRsSmuBNiKufNnQa7y?=
 =?us-ascii?Q?TVcCvyJa7n/WE+QU7Hti7NwHVute84zTmvh/07PvQF4xqvr9Xjf3qr5OGRXm?=
 =?us-ascii?Q?q2QBHl9hFb+W7kqmPRTIliFHEfGkLtAnQ1BQ8Zy+medUYhVe+KBr67/7eXx+?=
 =?us-ascii?Q?7bTGBvBNN3vqhnVjR1d3BSBs1RI7T5by372FPLX58o+3hqIBvzunYKtxiSDC?=
 =?us-ascii?Q?ynTijRU3HvmsSdzO9jTT+a7M3GjxpSqwxoqWCBLPpY6JEq1E6gbS/pPThPpg?=
 =?us-ascii?Q?IdUCn1oHq16AGn4xhYw2xLlfy6y2F1Chrzvre1CBM/YfiY2Ad0+sSKqWRHrA?=
 =?us-ascii?Q?0h7axOTlfl0ca2t4KAu8GtPwlpCz+TuFOF1drOQcx84lonxPpN6uR2RqpPw4?=
 =?us-ascii?Q?M9hDFCp0h9YGSBUAV0s8/8v0CcZ8SWfJw2q8sCG53ntbEWup83MJkA49r4Hy?=
 =?us-ascii?Q?BkxDno7+RG7wkq5a9sKWKPjwMIQInbgr4pJ2PRZvtPqH5orvw7jchUa40woo?=
 =?us-ascii?Q?0EEMHaOJf8nPcVxp5OfWYa4F2v2eB8QnfNSV8ustUAaL0ObU3X8jJ/TPqthw?=
 =?us-ascii?Q?Xck/FKVCTavVlamuFeBgg5zx49f7bowFAqDvAghrzKNJeORdte9pJWdEhdym?=
 =?us-ascii?Q?cdR5139ogyjLD9RmpXTjcfheTZsbiPVvLm3By72M/QsM5E6Hehvm4enqeHdk?=
 =?us-ascii?Q?rHJ/71AlCGvMiwC+lAk1u4n1TgN+8O+rRDw5CiBmjV2s5Mgx7gtPORoLdN5e?=
 =?us-ascii?Q?AdWO2QzKnH7gfvfmgyToYYtILQI1VXYJWE+guXHgtfzcat03UbjosfDXb1yj?=
 =?us-ascii?Q?gouPRrQcgWuIIPyp3bF+++ENFcRlryUGkRXFDaj8syopgm8qusso3nmilIzm?=
 =?us-ascii?Q?pdGT9mLfDhN8RARboyGk8tqE7HcDBCYC646UTTFGMSn0Ormn4jHEd5Ztjrbk?=
 =?us-ascii?Q?6mjoo2FmQepCvr4PADDkEJZwh59POSngaXf0r5T54RlgPNpOwX8+cXrCiTA4?=
 =?us-ascii?Q?oLhxQRmQ++/Wk0o0+ey2VQmsOgEqd4g5IKfbg6ULlt0jkj7p6TpBO3MklHxh?=
 =?us-ascii?Q?wPDHzaBtNLsjZIbDU3FAA0x9jXV4aLq6uA87w2uB9QOm02c6?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB361149752AE3CA5C022B41C194D42DM6PR12MB3611namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc4a49-ceea-491a-4192-08def25c96dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 19:14:21.5057 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1iYb3IlhX8KD4s7FaAvcahdJSBusgev55Dhu0hZ0KZKoI28wLATxPVhRFuwjz0Yje/mlhvHJxv8EsHgSFN8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803
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

--_000_DM6PR12MB361149752AE3CA5C022B41C194D42DM6PR12MB3611namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Tuesday, August 4, 2026 3:49 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Chen, Michael <Michael.Chen@amd.com>; Liang, Prike <=
Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: tear down the rs64mem bitmap in sw_fini

It's more reasonable to tear down the rs64mem bitmap software
context at MES sw_fini phase. This also can avoid the following
lock order issue.

[ 2529.150983] kworker/u64:1/3134 is trying to acquire lock:
[ 2529.151206] ffff8aebd9a3fa10 (reservation_ww_class_mutex){+.+.}-{4:4}, a=
t: amdgpu_bo_free_kernel+0x4e/0x130 [amdgpu]
[ 2529.151989]
               but task is already holding lock:
[ 2529.152227] ffff8aebd2411648 (&reset_domain->sem){++++}-{4:4}, at: amdgp=
u_device_lock_reset_domain+0x20/0x30 [amdgpu]
[ 2529.153008]
               which lock already depends on the new lock.

[ 2529.153342]
               the existing dependency chain (in reverse order) is:
[ 2529.153645]
               -> #2 (&reset_domain->sem){++++}-{4:4}:
[ 2529.153913]        down_read+0x4a/0x240
[ 2529.154081]        amdgpu_userq_destroy+0xd8/0x3a0 [amdgpu]
[ 2529.154635]        amdgpu_userq_ioctl+0x3e2/0xe30 [amdgpu]
[ 2529.155157]        drm_ioctl_kernel+0xaf/0x110 [drm]
[ 2529.155401]        drm_ioctl+0x290/0x510 [drm]
[ 2529.155612]        amdgpu_drm_ioctl+0x52/0x90 [amdgpu]
[ 2529.156068]        __x64_sys_ioctl+0xa0/0xf0
[ 2529.156249]        x64_sys_call+0x1278/0x21c0
[ 2529.156434]        do_syscall_64+0xbe/0x5f0
[ 2529.156611]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 2529.156842]
               -> #1 (&userq_mgr->userq_mutex){+.+.}-{4:4}:
[ 2529.157127]        __mutex_lock+0xb2/0x11a0
[ 2529.157304]        mutex_lock_nested+0x1f/0x30
[ 2529.157492]        amdgpu_userq_vm_validate_and_restore_queue+0x710/0x9b=
0 [amdgpu]
[ 2529.158098]        amdgpu_userq_restore_worker+0x39/0x290 [amdgpu]
[ 2529.158646]        process_one_work+0x23e/0x6f
               -> #0 (reservation_ww_class_mutex){+.+.}-{4:4}:
[ 2529.159832]        __lock_acquire+0x14c4/0x2210
[ 2529.160021]        lock_acquire+0xc6/0x310
[ 2529.160193]        __ww_mutex_lock.constprop.0+0xd9/0x1a30
[ 2529.160419]        ww_mutex_lock+0x40/0xb0
[ 2529.160590]        amdgpu_bo_free_kernel+0x4e/0x130 [amdgpu]
[ 2529.161077]        amdgpu_mes_rs64mem_fini+0x35/0x60 [amdgpu]
[ 2529.161601]        mes_v11_0_suspend+0x2d/0x40 [amdgpu]
[ 2529.162102]        amdgpu_ip_block_suspend+0x2b/0x70 [amdgpu]
[ 2529.162609]        amdgpu_device_ip_suspend_phase2+0xa4/0x270 [amdgpu]
[ 2529.163116]        amdgpu_device_pre_asic_reset+0x130/0x1f0 [amdgpu]
[ 2529.163617]        amdgpu_device_asic_reset+0x55/0x530 [amdgpu]
[ 2529.164101]        amdgpu_device_gpu_recover+0x1e5/0x410 [amdgpu]
[ 2529.164592]        amdgpu_userq_mgr_reset_work+0x80/0xa0 [amdgpu]
[ 2529.165140]        amdgpu_userq_hang_detect_work+0xbb/0x1c0 [amdgpu]
[ 2529.165693]        process_one_work+0x23e/0x6f0
[ 2529.165884]        worker_thread+0x1c4/0x380
[ 2529.166065]        kthread+0x10c/0x150
[ 2529.166226]        ret_from_fork+0x314/0x390
[ 2529.166408]        ret_from_fork_asm+0x1a/0x30
[ 2529.166595]
               other info that might help us debug this:

[ 2529.166917] Chain exists of:
                 reservation_ww_class_mutex --> &userq_mgr->userq_mutex -->=
 &reset_domain->sem

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 5998e05ecd79..b96f94e5169f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -308,8 +308,12 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)

         amdgpu_mes_doorbell_free(adev);

+       if (adev->mes.use_rs64mem)
+               amdgpu_mes_rs64mem_fini(&adev->mes);
+
         ida_destroy(&adev->mes.doorbell_ida);
         mutex_destroy(&adev->mes.mutex_hidden);
+
 }

 int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 37985c37be18..31722bb10038 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -2038,10 +2038,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block =
*ip_block)

 static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-       struct amdgpu_device *adev =3D ip_block->adev;
-
-       if (adev->mes.use_rs64mem)
-               amdgpu_mes_rs64mem_fini(&adev->mes);
         return 0;
 }

--
2.34.1


--_000_DM6PR12MB361149752AE3CA5C022B41C194D42DM6PR12MB3611namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: black;">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liang, Prike &lt;Prik=
e.Liang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, August 4, 2026 3:49 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Chen, Michael &lt;Michael.Chen@am=
d.com&gt;; Liang, Prike &lt;Prike.Liang@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: tear down the rs64mem bitmap in sw_=
fini</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">It's more reasonable to tear down the rs64mem bitm=
ap software<br>
context at MES sw_fini phase. This also can avoid the following<br>
lock order issue.<br>
<br>
[ 2529.150983] kworker/u64:1/3134 is trying to acquire lock:<br>
[ 2529.151206] ffff8aebd9a3fa10 (reservation_ww_class_mutex){+.+.}-{4:4}, a=
t: amdgpu_bo_free_kernel+0x4e/0x130 [amdgpu]<br>
[ 2529.151989]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; but task is already holding lock:<br>
[ 2529.152227] ffff8aebd2411648 (&amp;reset_domain-&gt;sem){++++}-{4:4}, at=
: amdgpu_device_lock_reset_domain+0x20/0x30 [amdgpu]<br>
[ 2529.153008]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; which lock already depends on the new lock.<br>
<br>
[ 2529.153342]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; the existing dependency chain (in reverse order) is:<br>
[ 2529.153645]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; -&gt; #2 (&amp;reset_domain-&gt;sem){++++}-{4:4}:<br>
[ 2529.153913]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; down_read+0x4a/0x2=
40<br>
[ 2529.154081]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_destr=
oy+0xd8/0x3a0 [amdgpu]<br>
[ 2529.154635]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_ioctl=
+0x3e2/0xe30 [amdgpu]<br>
[ 2529.155157]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_ioctl_kernel+0=
xaf/0x110 [drm]<br>
[ 2529.155401]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_ioctl+0x290/0x=
510 [drm]<br>
[ 2529.155612]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_drm_ioctl+0=
x52/0x90 [amdgpu]<br>
[ 2529.156068]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __x64_sys_ioctl+0x=
a0/0xf0<br>
[ 2529.156249]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x64_sys_call+0x127=
8/0x21c0<br>
[ 2529.156434]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do_syscall_64+0xbe=
/0x5f0<br>
[ 2529.156611]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_SYSCALL_64_a=
fter_hwframe+0x76/0x7e<br>
[ 2529.156842]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; -&gt; #1 (&amp;userq_mgr-&gt;userq_mutex){+.+.}-{4:4}:<br>
[ 2529.157127]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __mutex_lock+0xb2/=
0x11a0<br>
[ 2529.157304]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock_nested+=
0x1f/0x30<br>
[ 2529.157492]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_vm_va=
lidate_and_restore_queue+0x710/0x9b0 [amdgpu]<br>
[ 2529.158098]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_resto=
re_worker+0x39/0x290 [amdgpu]<br>
[ 2529.158646]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_one_work+0=
x23e/0x6f<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; -&gt; #0 (reservation_ww_class_mutex){+.+.}-{4:4}:<br>
[ 2529.159832]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __lock_acquire+0x1=
4c4/0x2210<br>
[ 2529.160021]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock_acquire+0xc6/=
0x310<br>
[ 2529.160193]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ww_mutex_lock.co=
nstprop.0+0xd9/0x1a30<br>
[ 2529.160419]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ww_mutex_lock+0x40=
/0xb0<br>
[ 2529.160590]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_ker=
nel+0x4e/0x130 [amdgpu]<br>
[ 2529.161077]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_rs64mem=
_fini+0x35/0x60 [amdgpu]<br>
[ 2529.161601]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes_v11_0_suspend+=
0x2d/0x40 [amdgpu]<br>
[ 2529.162102]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ip_block_su=
spend+0x2b/0x70 [amdgpu]<br>
[ 2529.162609]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_ip_s=
uspend_phase2+0xa4/0x270 [amdgpu]<br>
[ 2529.163116]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_pre_=
asic_reset+0x130/0x1f0 [amdgpu]<br>
[ 2529.163617]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_asic=
_reset+0x55/0x530 [amdgpu]<br>
[ 2529.164101]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_device_gpu_=
recover+0x1e5/0x410 [amdgpu]<br>
[ 2529.164592]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_mgr_r=
eset_work+0x80/0xa0 [amdgpu]<br>
[ 2529.165140]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_userq_hang_=
detect_work+0xbb/0x1c0 [amdgpu]<br>
[ 2529.165693]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process_one_work+0=
x23e/0x6f0<br>
[ 2529.165884]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; worker_thread+0x1c=
4/0x380<br>
[ 2529.166065]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kthread+0x10c/0x15=
0<br>
[ 2529.166226]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_fork+0x31=
4/0x390<br>
[ 2529.166408]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret_from_fork_asm+=
0x1a/0x30<br>
[ 2529.166595]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; other info that might help us debug this:<br>
<br>
[ 2529.166917] Chain exists of:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; reservation_ww_class_mutex --&gt; &amp;userq_mgr-&gt;=
userq_mutex --&gt; &amp;reset_domain-&gt;sem<br>
<br>
Signed-off-by: Prike Liang &lt;Prike.Liang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; | 4 ----<br>
&nbsp;2 files changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 5998e05ecd79..b96f94e5169f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -308,8 +308,12 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_doorbell_free(a=
dev);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.use_rs64mem)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_rs64mem_fini(&amp;adev-&gt;mes);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_destroy(&amp;adev-&gt;=
mes.doorbell_ida);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;adev-&g=
t;mes.mutex_hidden);<br>
+<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_mes_suspend(struct amdgpu_device *adev, u32 xcc_id)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index 37985c37be18..31722bb10038 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -2038,10 +2038,6 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block =
*ip_block)<br>
&nbsp;<br>
&nbsp;static int mes_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ip_blo=
ck-&gt;adev;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;mes.use_rs64mem)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_mes_rs64mem_fini(&amp;adev-&gt;mes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB361149752AE3CA5C022B41C194D42DM6PR12MB3611namp_--
