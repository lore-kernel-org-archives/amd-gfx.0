Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ADFCA5FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 17:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD0A10E22E;
	Thu,  1 Oct 2026 17:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yq00SIek";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013005.outbound.protection.outlook.com
 [40.93.201.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8705810E22E
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 17:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGqlHU2S3QItyNUyaVINmYuWmf4epM10vxL/dRlcKlSHFuwmxJ4/+KgRXVaFxidyY2l5zBNKZ5gTJxSQ7ahIeMAyP+lMF4NHcInyxZr11uE4ZgRrA+b4+gvPrDn8aQB60vTtyeCiUINewQWIAcOpi2lDJoYkQIM927pGtkMjDoiPIo6V2zEfCopaWsD/KaUyDHT7rfzcjU8g3PJoZZdP5rfHuYXpHE0p2EGICXQFkQDH0Sg74loubIGfThRpujKhp3QNym46SE2PNia/G0Xt9NllqHk0uZt05IlPmWbmRzr6w29xoIk1oMrkJWM6AF4YglkB2Xr1OGx0prwT6M5atQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA1lCuH1ncB53mB+ZF0iSpBrUEhXVG4vjlM+4hrw6Ss=;
 b=s8NSJZvtUlUOsBHAJJd8QXkpaHhrE3y3j1OlnLhb2/5kBYY3TSCas59lkd3JNon6e+Il5VpFR31RlXwxyDdScSy3NBPDoTw3fusaqAsbut8LALjg7o9UsAJTq3ZBiP1BE4jB/sJLsxIkq62UuP8kiaHOGm7scLOBg+0u5s5UieuIp6LhcpdiC87O8o+/FTUXgKzzyelgUjYEPYTiuELHQkIQrdP0WjFu/32p/qQY22FNRt0NclwEry0whgoQQwDBYyOfeZm+zhA3AIYAaxV/XHp4ctana9tU5deYUiandMN/Q6QRB2sGll1+zCVO3Z7rez4dr3f2hiWx0lHdRTXsCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA1lCuH1ncB53mB+ZF0iSpBrUEhXVG4vjlM+4hrw6Ss=;
 b=yq00SIek2oARYWRLh1YBjslo7PXRlWd/whIkrRqZpUieDo0q7kqvoa0AaAE44j2+29H1XYhABug9KL9jzyDfK4RLqW7m6lvVvApsTS52fJlLPQpX2N4hE8wrV9MrvFN665Ax/VYC8bLThYUVOYbN7v/6M/5GKlz2Q9ZkNFVNaLQ=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by FT1PR12MB222952.namprd12.prod.outlook.com (2603:10b6:170:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 17:27:39 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41%4]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 17:27:39 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Topic: [PATCH v2] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
Thread-Index: AQHdUb/GIyuZLbPnvESYeucsbTTvn7bo8L31
Date: Thu, 1 Oct 2026 17:27:39 +0000
Message-ID: <DS0PR12MB79937B71F0B37031B156B0B2F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <20261001161307.24649-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20261001161307.24649-1-mikhail.v.gavrilov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-01T17:27:39.167Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|FT1PR12MB222952:EE_
x-ms-office365-filtering-correlation-id: 279410c9-22b6-46f4-22ff-08df1fe14b08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: bTNUoPQBwvT5lOWJfhV5TD6SEWWStQiSDxr8UIk4wi6A2QVFDnauFeIHq3T/y3IIS38+aPNSUb7UwTPB1iHGW9wztv0mn4t5/aGsldA+srJEAMBoLUAPSY2+N8qCSN6rJSu8TmGoz1hZOk6VhUtz4bVeEDKzFjuvcsy3OIquiXOX3uHVgRvEyT6vl9yqn8JYGwWiQ1W5rVy7KCb3mA0agj3zfblDqA6lj7eXahGYez8qrCwTmrPa1eC0Jt76gLcZemiHykdPrsTrQlivGaOKKu9yLHAXlRAJHPHj+pr+5YVClm9DDMHftTRRpHKHThpEwxUKMgMaXrbA2391fBrDd2T7BKninv4yqKziTfsIM+kq/Ubiqh11O6iMG1dJS6xNaV+7kJGAJhuWaNbWUJKsDd5ny7SfvYStoqdUAfh3aVbSroFKQ6CACdql0IL0Om72Da2frzoCu8kT+mX5i/bAEIw90o5dUbEUTv3iSpqjhxvCIaVtHRUdkBXBxuJPuGkh/kFQerGvmZD+NBuNHmWatNtE6xiV2a+i76nSjI7fst2VgirC7hu6Ky8o88roSV2F4JZ1kYTPTi3JypPGM/A3vCnkZl4yfTxZqeqwosuRSMAi3dmW3N0MHRLPpJ7jv6qRa3vNMfb2I8Ebp2wTlEOrhhelpSM11B7cIZdjMekygcandS09MZVXb8AzagudgUnnPJ6DlDCZYrH//ecToyo+wH71QLWTKwkP4amZQD3Zrhc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q2N07ZkcfMffVOCz8+PNpHP9V8kr1MHQR+G1Bh9DC7yE+ZRh1QoBXYxAfz?=
 =?iso-8859-1?Q?zjvc5hDcw6+T7Cx8ikjxfhEM0048g902+olmCGon52lZCixmjEobnc4IQf?=
 =?iso-8859-1?Q?pcMh73f2XQ6nXjHEPL1WXkG13VfQPdNimHA3yZs9iRWl7xFlpDImYW64xi?=
 =?iso-8859-1?Q?H0vyegkSBekQ5h3hnG1zUwyXGBw7ggs7rRa8m/ll6oZ9I65ftrfdqcX3oc?=
 =?iso-8859-1?Q?74+QqP1STm0RhOcNf+dR6fBEmqhgdcLkpV1TQK/akaBn+KtP7AEMJo+n45?=
 =?iso-8859-1?Q?glQX/bnhXDwU9vo1zvDV/7rlbHyKe9yWn/1KXHyJ6SUnzMSum2+9WJjkSc?=
 =?iso-8859-1?Q?sRrWtQ8diyrgWm1OccVncJ1WoKFkMKzPqzJRChPq0aUGSVFBfLvJBZwVhS?=
 =?iso-8859-1?Q?ysz42hO5SIwC2LYWl1s7ttqPF+M1xUyzyavQbXrgTk7ZcMeO6oDRpQ++9p?=
 =?iso-8859-1?Q?SBtattb0LZXrHMydUJsgflck4DKCbrNfihFIGgVNHS1UU1jF/GIItrBY2y?=
 =?iso-8859-1?Q?jvNE4n0xCmJkr7orafJeiTkXenU9LDHc96blWveagkAQAVTL8adLp3s7LG?=
 =?iso-8859-1?Q?FHs5fb9eCAdXr0+ZytrsOwEeAuPTEnJFCgQVwGPMAfztOTjUJbpWY60Iu0?=
 =?iso-8859-1?Q?DhvOsgcKVb3n+FYOKqv2sq318ddFtsI7/8h4NTHQQ6LltAT63TReVH4HRo?=
 =?iso-8859-1?Q?I37qzFto+rudBG+X2rihIzOSHw5OVTbavrbp6LJpundxjSh8VEicgC5fha?=
 =?iso-8859-1?Q?g6+qlHCrWER7tg3H5PnjEEnft3bLhpeiUt0baXj/yQ0CjMQpVrLfo7zCKZ?=
 =?iso-8859-1?Q?c2BHXslRwkP8YBFfyVMgR437NdFhLwYmXR08EWTKEZcH33tLMfHb08fzD4?=
 =?iso-8859-1?Q?3gSMZ74v0/RPj4m5hjNBGeQwsHGIgzqdoshmKSY0BRaPDsriqywCZ1J/zj?=
 =?iso-8859-1?Q?YyGpVVhW8W3/Z7KYFq9QloiulS18sQZdCbvlwKvV07pnFQk7ScaJk6zyVw?=
 =?iso-8859-1?Q?qQoK13Y/7eLBr6k7uvAjeXqmVxVNxorLtKHYv5C9mqIvTAPGURKFYRJS4/?=
 =?iso-8859-1?Q?sY0vQMqq9JOoF94gplDSL7vNYMoaNiTBNXL724E/DLmPB25uZqYDVJxVUp?=
 =?iso-8859-1?Q?zBueYMk8ndr3Hvgfu5iRJb2r4+r4VOjB/n8amA/+dwudZjCAsIn1fuDrci?=
 =?iso-8859-1?Q?dkIsaSdnZJPoDtKdLaNT1miKdhGqNc/ATI73npvqTqGtuT9UX5EH2MZEoV?=
 =?iso-8859-1?Q?86/hFB0vREKRPLgOajQjP2+zEFnAlkUOmz6sA7nGjl9/E5Q6cyRS/+SQh7?=
 =?iso-8859-1?Q?dkfoojEJ1D7bab9mtXjd1Sryp8YBWQ/kS0kV9uZjfPuyYU4+vyUueASf5j?=
 =?iso-8859-1?Q?8MvXXo1Q5oqOhR6nUmyR3/UaIIEg100Ms5lH9RpeRIhEZ1czu/WFnlbe8F?=
 =?iso-8859-1?Q?xotWJ8lUeYvB9Mufss9eAkadxvaqfCO/pogUr5qC7Jrb8PP2PKLOIsb+8n?=
 =?iso-8859-1?Q?cr1xsxdp8IJaJgnQzG32SB0gVg8NrJMmzVcGWj1fOWIJIWmolcFTtKbr/z?=
 =?iso-8859-1?Q?/F38IR4tp7fHTmDmaaj+H9YM9CJyXUoo/vKlvlIA9T6FIStGK9cn5jEQF/?=
 =?iso-8859-1?Q?52I6UZApmMvkOwLqCuBKtKBKGVszmpdTIG9L+OCqY+9cmlq1MOYfNqRsLW?=
 =?iso-8859-1?Q?SmTS25MEfqPSS3BYsILl5aYjaVPcwkL3i6ybce5k1QrUvBNT8aTbPx34uJ?=
 =?iso-8859-1?Q?+0lqVwBTtkRJV819RnsApstAo8ocfpiJdJQhjoJPb/2b9e?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279410c9-22b6-46f4-22ff-08df1fe14b08
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 17:27:39.6493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RvGD1cKiodIK2s9nRqczGHpJKyBDM1HBH8S+pL2zMTl0GYuLEE0ZCbWKVIOimm/1SrVQCOEeGaDJk/MkT4jbZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB222952
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

Tested, works for me on my navi48.  You can add my Acked-by:=0A=
=0A=
Tom=0A=
=0A=
=0A=
________________________________________=0A=
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
Sent: Thursday, October 1, 2026 12:13=0A=
To: amd-gfx@lists.freedesktop.org=0A=
Cc: Deucher, Alexander; Koenig, Christian; Prosyak, Vitaly; StDenis, Tom; M=
ikhail Gavrilov=0A=
Subject: [PATCH v2] drm/amdgpu: copy debugfs register data outside the GRBM=
/SRBM locks=0A=
=0A=
Reading or writing a register through the amdgpu_regs2 debugfs file=0A=
with GRBM bank selection, which umr does for every banked access (a=0A=
single "umr -b x x x -r <reg>" is enough, as is the wave dump with=0A=
"-O halt_waves"), makes lockdep report a circular locking dependency,=0A=
after which lockdep stays off until reboot:=0A=
=0A=
  WARNING: possible circular locking dependency detected=0A=
  umr/63306 is trying to acquire lock:=0A=
  ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x1=
40=0A=
  but task is already holding lock:=0A=
  ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_=
regs2_op.isra.0+0x20d/0xd00 [amdgpu]=0A=
  ...=0A=
  Chain exists of:=0A=
    &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key=0A=
  ...=0A=
   __might_fault+0xc5/0x140=0A=
   amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]=0A=
   full_proxy_write+0x10e/0x1d0=0A=
   vfs_write+0x1d0/0xf50=0A=
   ksys_write+0x116/0x250=0A=
=0A=
amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call=0A=
get_user()/put_user() for every dword while holding grbm_idx_mutex or=0A=
srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock=0A=
inside those locks. The lock hierarchy in amdgpu_lockdep.c puts=0A=
srbm_mutex and grbm_idx_mutex below notifier_lock, which=0A=
amdgpu_cs_submit() takes with the BO reservations held, and=0A=
dma_resv_lockdep() orders the reservations inside mmap_lock. So=0A=
mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two=0A=
debugfs paths nest it the other way round. The copies under the locks=0A=
are as old as the bank selection in both files; commit 1d0f5838b126=0A=
("drm/amdgpu: Add lockdep annotations for lock ordering validation")=0A=
only made them visible to lockdep.=0A=
=0A=
Copy the user buffer in before any of the locks is taken and the result=0A=
out after all of them are dropped, as amdgpu_debugfs_wave_read(),=0A=
amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.=0A=
The buffer is sized by the count passed to read() or write(), so an=0A=
access larger than PAGE_SIZE is now rejected with -EINVAL; umr reads and=0A=
writes one register at a time. A fault on the user buffer of a write now=0A=
fails with -EFAULT before any register is written, instead of after a=0A=
partial write.=0A=
=0A=
Fixes: 566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (=
v3)")=0A=
Fixes: 37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO regist=
ers (v5)")=0A=
Acked-by: Christian K=F6nig <christian.koenig@amd.com>=0A=
Acked-by: Tom St Denis <tom.stdenis@amd.com>=0A=
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>=0A=
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
---=0A=
=0A=
Notes:=0A=
    v2:=0A=
    - Fixes: point at the commits that introduced the user copies under the=
=0A=
      locks, not at the lockdep annotation that made them visible=0A=
      (Christian).=0A=
    - Reject an access larger than PAGE_SIZE before allocating the buffer=
=0A=
      (Vitaly); umr only does 4-byte accesses (Tom).=0A=
    - Allocate the buffer with kmalloc() instead of kvmalloc() (Christian).=
=0A=
    - amdgpu_debugfs_gprwave_read() needs no change: it already calls=0A=
      put_user() after dropping grbm_idx_mutex.=0A=
    - Christian's and Tom's Acked-by were given on v1; the size check and=
=0A=
      kmalloc() are the only code changes since.=0A=
    - The test notes went out as a separate reply to v1; they are part of=
=0A=
      the patch mail now.=0A=
=0A=
    v1: https://lore.kernel.org/amd-gfx/20260930154934.27981-1-mikhail.v.ga=
vrilov@gmail.com/=0A=
=0A=
    Tested v2 on Navi 31 (gfx1100), 7.3.0-rc5 at 551c722f4080, with lockdep=
.=0A=
=0A=
    Without this patch the first GRBM-banked access through amdgpu_regs2=0A=
    produces the report above: from the write branch when umr halts=0A=
    waves, and from the read branch for a single=0A=
    "umr -b x x x -r '*.gfx1100.regGRBM_STATUS'" on a fresh boot.=0A=
=0A=
    With this patch, and with the chain from reservation_ww_class_mutex=0A=
    through &amdgpu_notifier_lock_key down to &amdgpu_grbm_lock_key present=
=0A=
    in /proc/lockdep, none of the following produced a report, and=0A=
    debug_locks stayed 1:=0A=
    - the banked read of GRBM_STATUS* above;=0A=
    - "umr -O halt_waves -wa gfx_0.0.0" (banked SQ_CMD writes);=0A=
    - writing SCRATCH_REG0 and reading it back through amdgpu_regs2 with=0A=
      GRBM broadcast, and through amdgpu_regs with the bank bits in the=0A=
      offset; both reads returned the value written.=0A=
    A 4100-byte read of amdgpu_regs and of amdgpu_regs2 fails with EINVAL.=
=0A=
=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 77 ++++++++++++---------=0A=
 1 file changed, 46 insertions(+), 31 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c=0A=
index aca1a8045a..ab7ccfaea2 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
@@ -121,6 +121,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, s=
truct file *f,=0A=
=0A=
        *pos &=3D (1UL << 22) - 1;=0A=
=0A=
+       if (size > PAGE_SIZE)=0A=
+               return -EINVAL;=0A=
+=0A=
+       /*=0A=
+        * Access the user buffer only while none of the locks below are he=
ld:=0A=
+        * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest=
=0A=
+        * inside it.=0A=
+        */=0A=
+       u32 *data __free(kfree) =3D kmalloc(size, GFP_KERNEL);=0A=
+       if (!data)=0A=
+               return -ENOMEM;=0A=
+       if (!read && copy_from_user(data, buf, size))=0A=
+               return -EFAULT;=0A=
+=0A=
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);=0A=
        if (r < 0) {=0A=
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
@@ -152,28 +166,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, =
struct file *f,=0A=
                mutex_lock(&adev->pm.mutex);=0A=
=0A=
        while (size) {=0A=
-               uint32_t value;=0A=
-=0A=
-               if (read) {=0A=
-                       value =3D RREG32(*pos >> 2);=0A=
-                       r =3D put_user(value, (uint32_t *)buf);=0A=
-               } else {=0A=
-                       r =3D get_user(value, (uint32_t *)buf);=0A=
-                       if (!r)=0A=
-                               amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, va=
lue, 0);=0A=
-               }=0A=
-               if (r) {=0A=
-                       result =3D r;=0A=
-                       goto end;=0A=
-               }=0A=
+               if (read)=0A=
+                       data[result >> 2] =3D RREG32(*pos >> 2);=0A=
+               else=0A=
+                       amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[resul=
t >> 2], 0);=0A=
=0A=
                result +=3D 4;=0A=
-               buf +=3D 4;=0A=
                *pos +=3D 4;=0A=
                size -=3D 4;=0A=
        }=0A=
=0A=
-end:=0A=
        if (use_bank) {=0A=
                amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff, 0);=0A=
                mutex_unlock(&adev->grbm_idx_mutex);=0A=
@@ -188,6 +190,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, s=
truct file *f,=0A=
        pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
=0A=
        amdgpu_virt_disable_access_debugfs(adev);=0A=
+=0A=
+       if (read && copy_to_user(buf, data, result))=0A=
+               return -EFAULT;=0A=
+=0A=
        return result;=0A=
 }=0A=
=0A=
@@ -238,11 +244,24 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f=
, char __user *buf, u32 off=0A=
        struct amdgpu_device *adev =3D rd->adev;=0A=
        ssize_t result =3D 0;=0A=
        int r;=0A=
-       uint32_t value;=0A=
=0A=
        if (size & 0x3 || offset & 0x3)=0A=
                return -EINVAL;=0A=
=0A=
+       if (size > PAGE_SIZE)=0A=
+               return -EINVAL;=0A=
+=0A=
+       /*=0A=
+        * Access the user buffer only while none of the locks below are he=
ld:=0A=
+        * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest=
=0A=
+        * inside it.=0A=
+        */=0A=
+       u32 *data __free(kfree) =3D kmalloc(size, GFP_KERNEL);=0A=
+       if (!data)=0A=
+               return -ENOMEM;=0A=
+       if (write_en && copy_from_user(data, buf, size))=0A=
+               return -EFAULT;=0A=
+=0A=
        r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);=0A=
        if (r < 0) {=0A=
                pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
@@ -281,24 +300,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f=
, char __user *buf, u32 off=0A=
                mutex_lock(&adev->pm.mutex);=0A=
=0A=
        while (size) {=0A=
-               if (!write_en) {=0A=
-                       value =3D RREG32(offset >> 2);=0A=
-                       r =3D put_user(value, (uint32_t *)buf);=0A=
-               } else {=0A=
-                       r =3D get_user(value, (uint32_t *)buf);=0A=
-                       if (!r)=0A=
-                               amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, =
value, rd->id.xcc_id);=0A=
-               }=0A=
-               if (r) {=0A=
-                       result =3D r;=0A=
-                       goto end;=0A=
-               }=0A=
+               if (!write_en)=0A=
+                       data[result >> 2] =3D RREG32(offset >> 2);=0A=
+               else=0A=
+                       amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[res=
ult >> 2],=0A=
+                                               rd->id.xcc_id);=0A=
                offset +=3D 4;=0A=
                size -=3D 4;=0A=
                result +=3D 4;=0A=
-               buf +=3D 4;=0A=
        }=0A=
-end:=0A=
+=0A=
        if (rd->id.use_grbm) {=0A=
                amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xfff=
fffff, rd->id.xcc_id);=0A=
                mutex_unlock(&adev->grbm_idx_mutex);=0A=
@@ -317,6 +328,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f,=
 char __user *buf, u32 off=0A=
        pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);=0A=
=0A=
        amdgpu_virt_disable_access_debugfs(adev);=0A=
+=0A=
+       if (!write_en && copy_to_user(buf, data, result))=0A=
+               return -EFAULT;=0A=
+=0A=
        return result;=0A=
 }=0A=
=0A=
=0A=
base-commit: 551c722f40809618230001baccf219193e22fc5a=0A=
--=0A=
2.43.0=0A=
=0A=
