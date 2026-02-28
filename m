Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37AD61048925
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 02:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFD9710E0BC;
	Sat, 28 Feb 2026 02:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0s0Jflx";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6FF210E0BC
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Feb 2026 02:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sX/n0Wb4HH0GrLJHpefTjYUmBqPKPjkJT9KsvDpxhvqnwajqFab1xQzkPk7P/mycDSfFfDysub5Tn4vZqjTHSTjHoE2MJeJUD/CLufZw5VHbPUiarm2gUwIPD8CpnCZdjXBL95rLUspEQOnOR/E6hs/I3rh9u4UhtevIM7DtA1hHSqLxAxZpkjjrK+oqANbzefyqGovhsGzl7qxNK1tIgkyyXkuomp0ExAVH/trh/RVipbupsa2D2v1K9lom32BGGLCs7hWbqNKmIwPV7mJv95AQdpCRMlq9w2qxB33yWBE7LxlWFjNRGqfqrKyxACdlotEW3rI+tQ+gMZf4H4Ayhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahFCwcXLvf0zjeWotZtFXbDzlXeO9Y8bgReZl4yuh3Y=;
 b=ySYWVjAiBoHPhJ6VUzDfY97+KZ4HdgurcJkEYKxNQ0w1aXn6Va8sBPiKlhtX55RiMFOXyIhiTOEVKGRfB6PKJRP9rb8+xrLJ5BOHIUWGZ+rwmNFj3V7ykBgPToWR6bSI33Vd8ZoRMDzcL3zWhK+XE0DgJcDlsgo+E4jQgPqt4shudfAyXlqvXlXOduHx0p+XjJC5zOVtAbtYXdZWf74VdXSryzdJuNWCJ3tHEbEjEtB1/du1B0G8AazP4hJ5Wu5X+zUFQ8fq4YtK+B3TFqw0BM5XUayiYzuGyEVD3aPgs0e+cjrlWvxmZ8I2mLJxMFq4yS9Wc50vm1/zu7n+ZYAN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahFCwcXLvf0zjeWotZtFXbDzlXeO9Y8bgReZl4yuh3Y=;
 b=x0s0Jflx/cB/aj6Djp3qSlF4Cd71OdGnBfHtEMcM04KuQQNM7IKkeLYs+0QkY1ASx8HYDFKA7V1cJwWtswYSQm2sQRncEuLStvvurskoyPUuD+lZKD61CrU/WneHPSoNz2pjFpXraAGa9kylz5zhlikgTPCwIOpJl7NhnaOnhuw=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sat, 28 Feb
 2026 02:27:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.20.9654.007; Sat, 28 Feb 2026
 02:27:23 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
Thread-Topic: [PATCH v2] drm/amdgpu: Fix null pointer access in
 amdgpu_userq_signal_ioctl
Thread-Index: AQHcp8ZDHnNBBJG3DEO7/TCQwaogerWWQDWAgAEhCEA=
Date: Sat, 28 Feb 2026 02:27:23 +0000
Message-ID: <DM4PR12MB5152522CE6602B85622BEEFEE370A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260227085110.2865415-1-Jesse.Zhang@amd.com>
 <52346e1b-0bbe-4381-8d84-b9f1c1da9593@amd.com>
In-Reply-To: <52346e1b-0bbe-4381-8d84-b9f1c1da9593@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-28T02:17:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|SJ0PR12MB6831:EE_
x-ms-office365-filtering-correlation-id: afb0dc29-3002-4da7-96b6-08de7670e804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: 3aR+26CCqc0Hmnsi9HwbHzti/h8da8tKZ2WspL2xmxKLIoC8xaMIqvn1B5Ja0Ztg6E9bUb/pCmtXJMPKgF+qkAfw9jGud8LaI393Ziny8ws/TVzGAQ/cYjvNI4KSTucIjnogJ0lIujD59K8I3v5sjQA+uA1eAbQETON0ujSHJMkF1VKuRgZHc3FUj5cQYw+KJ6fS7nqQvAcWXY/Xx8q/Lm4J3vjErfnkTJl6BPk/6t15U9z3dtkj+C46RzNAdAV075a0lL9Du5Ttao5pq4QnMH+G7XCIkzYKLdN4qqg6TUNf09aALHHcsDHAPkjqVCwHmkM1eEjjprwCMUdDSPymnUxJtEj6sxtqMPQXyYZu1TswQiDlwyDU+LXuR0ZkpTfemsSMZc2kBbimFl5sgqtGtv4xMOLPSrs1OrDhWV9J3f6CfPGWQ6PBnJPenLC9sR0YNNk9fjTrVtxI1Pe26Jo24KHEAp7HawLIVLhmixmV9da6UiI3ZudNRQ6Li2EVz1FDV3ILPD8r0h9der0oHff70X88V4JrXJJnfngkjHyeqgMPcVjYkEUGWz/nrZhdBOdeBdb98YBgANUfGpgw9pwJseMB2nkWmSvwyBUgoWw7R2P9EXmkSolbviMi50SQ8ywctNsirhQo+X7MCs/WaKv5GoTrrjMCtAkIK+Y/X1JibWTVsK46lIXhJXgvThuRN6KaJpAF1aUrbqaMCfuXbId0W3i3YTuLtpPihmIvnnAK359OJAn4avKVWASTeDP47NsURL9S35/YPPv+NJS2g4m95rV31XPzwNPhMgUS5hH0ln0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y3h7PzIyHN3+dmhbrwTV7uFHCHdXzE7fO3KULmyfjQ6VWXz35JF7ItAyXusz?=
 =?us-ascii?Q?IeHm/QEiQPGelXoqmQ5QC6sanpA0NyksSkkRTCemEhfb2hG8IqZZtMJ5ZV0/?=
 =?us-ascii?Q?NeKtoNDvFx7pyMeW1AruOFqnLaSSO0plDowZYp6VrKh0lPozNQUx4wA499ZO?=
 =?us-ascii?Q?KULzZp3Goj0UszyEe5RiIsulwvhLXohLrRatxsz7ikYc+VVqFsaGSIullIjc?=
 =?us-ascii?Q?v58ADLYyey++2Jfkc72q919Qfxb2bmNE0NC30H+mTc3lOYPxjGJ5pOEEGhYO?=
 =?us-ascii?Q?BvBS70BnAnjzCvbHyE4igul+QUJ2wXx9flj+faKoy4zkx7GWnCz8PF5v18iH?=
 =?us-ascii?Q?jHY2rmyOopTlH4Szmh/yXEfBY3GKMpbV1VRSyzbGSnug+e+b+ff2h3hArWST?=
 =?us-ascii?Q?ZjZQmPcLekWBneAz3QpW6VXB9Ur0M9hl7xHhsUCfnkoAsPt72JqsICnR0Flt?=
 =?us-ascii?Q?Ln+yD2A+DhtYpDYW/h72tKQEdrwJn/FNruNHhW2RvpXTLuOH9cOiAdobPjAp?=
 =?us-ascii?Q?dKzA0ZEFOnak4d5fsTuWkGy7VE5IMO9ZeutrWTbezHihM9pGwGJoR5PrOEUj?=
 =?us-ascii?Q?E3/CcZi+ot/AgqZFDiypHllJbVLGd7/a8Mcra4OiYN/LQMCs4xWZjVYnmHNE?=
 =?us-ascii?Q?5zN6AI0QDKkR+QbYcmILRwysyJY+BhFtF0Kuc9wZxWet4DUsRC89WESKKRfT?=
 =?us-ascii?Q?ENAG14O/ymH7izmunHaFm7YHZOFuv68CgB1pYkyjlr9B6ZcO+OFTOMEnn2wY?=
 =?us-ascii?Q?lFChZ6hDmUdUSaRQRdoIONfeIFgfhlPgqFrsJV4ubkeg/35Yan3LUdB5J5Lu?=
 =?us-ascii?Q?Z7bEVPYY9HRR4SG2AA9l6Y70mOZckpAdYTWnc4nLZ746GcvZ0V4RlTdrHGtj?=
 =?us-ascii?Q?aVgUmd7S5RumwE+tglMBhUo1xiCjEOyqtz5Jnu6n35vpIPfbQs3BbkihaZqU?=
 =?us-ascii?Q?E79ikKP31R70tWfESOUEt0GZkgQ1TpEsC4PgfLKTwQt4RUmsWT4PvWcDvptV?=
 =?us-ascii?Q?4E8LsCuHlJs5NjzNqjOWDPp7DZXqtm+8E6W2M1FXWezJeUZ9T1ElQZ9byIN+?=
 =?us-ascii?Q?cSpfmSvP5Frf+SQ9JfkAh4WqeaxXV4zZIqBB7eFRYwlN9XM/QavwwaqhhaF7?=
 =?us-ascii?Q?srx4tsEe5L19T9zajWa6pAZoNCosp1QDGtz2z7EQsbKJTcjURP5VZ5L+cT5P?=
 =?us-ascii?Q?zv2BiudgW7aduBAt/F8fFJqo3pWUfcTp4kN5lUDmZr74MaTAyNvmi+43g/+5?=
 =?us-ascii?Q?2dkagqM2ac1OHk7GO7UwaFAcBOjvc3KrLmfWxykHkXfy7VgyAMdZEhcPLnLS?=
 =?us-ascii?Q?0HNEM3dwBV0g4F54AGSUVoKCkTNjBJua53rJ2O2TZpd8zaoMoiT1DrjZNVOr?=
 =?us-ascii?Q?F73Yu+6ScKKAKnZ1EGLyi8n/hGvR1krjGey9EEkhiyfRRQIGVqXy2La5iChZ?=
 =?us-ascii?Q?ubj/SsA8Qnlm5BmCpv3GJCTQTlZnaK8KegIrv8va6bLRRB0uEgYMd4axG4qZ?=
 =?us-ascii?Q?RtprZpw7JTnTBrR3Uf04Qe2VSuyLzMdGckXNFiM6YjkfREIhBjLc1eln4yuf?=
 =?us-ascii?Q?S5UJ7OE3oiOuhUU+TCyMcpj1n/bRa9O/CUOhNdCWzPhLNIxqW27Ho7e53y+t?=
 =?us-ascii?Q?kHbCVZXDc+ZzPuoh/E2kMYVtl6EnYVpWvaRhQLyl90bcOxIEE9xihw0dDFTg?=
 =?us-ascii?Q?RYQ4ZjopZhKiJ/L0Wb8P7MrrJGpktrTEVS7Rxl3UGewXw+j0?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152522CE6602B85622BEEFEE370ADM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb0dc29-3002-4da7-96b6-08de7670e804
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 02:27:23.3735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUs6lc/Jop2j3rmIAmTMaPkrZQVfoq7zOLTMs2SHu72FOqG1q1R19/t9q1ECjZrTnnbeaLqb6iibMtfkQMCtaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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

--_000_DM4PR12MB5152522CE6602B85622BEEFEE370ADM4PR12MB5152namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]



From: Khatri, Sunil <Sunil.Khatri@amd.com>
Sent: Friday, February 27, 2026 5:03 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix null pointer access in amdgpu_userq=
_signal_ioctl



On 27-02-2026 02:20 pm, Jesse.Zhang wrote:

The amdgpu_userq_signal_ioctl function was triggering kernel page faults

due to missing null pointer checks when accessing gobj_read/gobj_write

arrays, and improper handling of memory allocation for these arrays.



The crash stack showed the failure originated from the ioctl path:

[   64.977695] Call Trace:

[   64.977696]  <TASK>

[   64.977700]  amdgpu_userq_signal_ioctl+0x8e4/0xda0 [amdgpu]

[   64.977830]  ? tty_ldisc_deref+0x1a/0x20

[   64.977834]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]

[   64.977934]  drm_ioctl_kernel+0xab/0x110 [drm]

[   64.977955]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]

[   64.978071]  drm_ioctl+0x2cb/0x5a0 [drm]

[   64.978088]  ? ttm_bo_vm_fault_reserved+0x1ef/0x410 [ttm]

[   64.978093]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]

[   64.978179]  __x64_sys_ioctl+0x9e/0xf0

[   64.978182]  x64_sys_call+0x1274/0x2190

[   64.978185]  do_syscall_64+0x74/0x950

[   64.978189]  ? ___pte_offset_map+0x20/0x170

[   64.978191]  ? __handle_mm_fault+0x986/0xfb0

[   64.978194]  ? count_memcg_events+0xe7/0x1e0

[   64.978197]  ? handle_mm_fault+0x1cc/0x2b0

[   64.978199]  ? do_user_addr_fault+0x394/0x8a0

[   64.978202]  ? irqentry_exit_to_user_mode+0x2a/0x1e0

[   64.978205]  ? irqentry_exit+0x3f/0x50

[   64.978206]  ? exc_page_fault+0x97/0x190

[   64.978208]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[   64.978210] RIP: 0033:0x7f3c08b24ded



Fixes: fd4fde1df18b ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgp=
u_userq_signal_ioctl")



V2: initialize gobj_write



Signed-off-by: Jesse Zhang <jesse.zhang@amd.com><mailto:jesse.zhang@amd.com=
>

---

 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 22 +++++++++++++------

 1 file changed, 15 insertions(+), 7 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userq_fence.c

index 3c30512a6266..af934374df94 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c

@@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, v=
oid *data,

        const unsigned int num_read_bo_handles =3D args->num_bo_read_handle=
s;

        struct amdgpu_fpriv *fpriv =3D filp->driver_priv;

        struct amdgpu_userq_mgr *userq_mgr =3D &fpriv->userq_mgr;

-       struct drm_gem_object **gobj_write, **gobj_read;

+       struct drm_gem_object **gobj_write =3D NULL, **gobj_read =3D NULL;

We don't need to set these to NULL anymore, drm_gem_objects_lookup already =
check and set it to NULL if num objects is 0. I Don't think this patch is n=
eeded anymore.

I have already dropped such patch few days back before i pulled in drm_gem_=
objects_lookup fix patch from drm-misc. I think u might have not pulled in =
recent code changes.

[Zhang, Jesse(Jie)]

I pulled the latest ASDN branch, along with the latest commit regarding drm=
_gem_objects_lookup, as shown below. Perhaps your fix hasn't been merged in=
to ASDN yet.

Thanks Sunil and I will drop this patch.

commit d5391f9191dd2f9ca47bff90957432aa2f4328ca

Author: Alex Deucher alexander.deucher@amd.com<mailto:alexander.deucher@amd=
.com>

    drm: fix the build with -Werror

    Fix unused variable when commit 8477a645d275 was cherry-picked.

Fixes: 8477a645d275 ("drm/gem: Make drm_gem_objects_lookup() self-cleaning =
on failure v6")



Thanks

Jesse



Regards
Sunil khatri





        u32 *syncobj_handles, num_syncobj_handles;

        struct amdgpu_userq_fence *userq_fence;

        struct amdgpu_usermode_queue *queue;

@@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,

 exec_fini:

        drm_exec_fini(&exec);

 put_gobj_write:

-       for (i =3D 0; i < num_write_bo_handles; i++)

-        drm_gem_object_put(gobj_write[i]);

-       kfree(gobj_write);

+       for (i =3D 0; i < num_write_bo_handles; i++) {

+               if (gobj_write)

+                drm_gem_object_put(gobj_write[i]);

+       }

+

+       if (gobj_write)

+               kfree(gobj_write);

 put_gobj_read:

-       for (i =3D 0; i < num_read_bo_handles; i++)

-        drm_gem_object_put(gobj_read[i]);

-       kfree(gobj_read);

+       for (i =3D 0; i < num_read_bo_handles; i++) {

+               if (gobj_read)

+                drm_gem_object_put(gobj_read[i]);

+       }

+

+       if (gobj_read)

+               kfree(gobj_read);

 free_syncobj:

        while (entry-- > 0)

                if (syncobj[entry])

--_000_DM4PR12MB5152522CE6602B85622BEEFEE370ADM4PR12MB5152namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Khatri, Sunil &lt;Sunil.Khatri=
@amd.com&gt;
<br>
<b>Sent:</b> Friday, February 27, 2026 5:03 PM<br>
<b>To:</b> Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amdgpu: Fix null pointer access in amdgp=
u_userq_signal_ioctl<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">On 27-02-2026 02:20 pm, Jesse.Zhang wrote:<o:p></o:p=
></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre>The amdgpu_userq_signal_ioctl function was triggering kernel page faul=
ts<o:p></o:p></pre>
<pre>due to missing null pointer checks when accessing gobj_read/gobj_write=
<o:p></o:p></pre>
<pre>arrays, and improper handling of memory allocation for these arrays.<o=
:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>The crash stack showed the failure originated from the ioctl path:<o:p=
></o:p></pre>
<pre>[&nbsp;&nbsp; 64.977695] Call Trace:<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.977696]&nbsp; &lt;TASK&gt;<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.977700]&nbsp; amdgpu_userq_signal_ioctl+0x8e4/0xda0 [=
amdgpu]<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.977830]&nbsp; ? tty_ldisc_deref+0x1a/0x20<o:p></o:p><=
/pre>
<pre>[&nbsp;&nbsp; 64.977834]&nbsp; ? __pfx_amdgpu_userq_signal_ioctl+0x10/=
0x10 [amdgpu]<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.977934]&nbsp; drm_ioctl_kernel+0xab/0x110 [drm]<o:p><=
/o:p></pre>
<pre>[&nbsp;&nbsp; 64.977955]&nbsp; ? __pfx_amdgpu_userq_signal_ioctl+0x10/=
0x10 [amdgpu]<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.978071]&nbsp; drm_ioctl+0x2cb/0x5a0 [drm]<o:p></o:p><=
/pre>
<pre>[&nbsp;&nbsp; 64.978088]&nbsp; ? ttm_bo_vm_fault_reserved+0x1ef/0x410 =
[ttm]<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.978093]&nbsp; amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]<o:p=
></o:p></pre>
<pre>[&nbsp;&nbsp; 64.978179]&nbsp; __x64_sys_ioctl+0x9e/0xf0<o:p></o:p></p=
re>
<pre>[&nbsp;&nbsp; 64.978182]&nbsp; x64_sys_call+0x1274/0x2190<o:p></o:p></=
pre>
<pre>[&nbsp;&nbsp; 64.978185]&nbsp; do_syscall_64+0x74/0x950<o:p></o:p></pr=
e>
<pre>[&nbsp;&nbsp; 64.978189]&nbsp; ? ___pte_offset_map+0x20/0x170<o:p></o:=
p></pre>
<pre>[&nbsp;&nbsp; 64.978191]&nbsp; ? __handle_mm_fault+0x986/0xfb0<o:p></o=
:p></pre>
<pre>[&nbsp;&nbsp; 64.978194]&nbsp; ? count_memcg_events+0xe7/0x1e0<o:p></o=
:p></pre>
<pre>[&nbsp;&nbsp; 64.978197]&nbsp; ? handle_mm_fault+0x1cc/0x2b0<o:p></o:p=
></pre>
<pre>[&nbsp;&nbsp; 64.978199]&nbsp; ? do_user_addr_fault+0x394/0x8a0<o:p></=
o:p></pre>
<pre>[&nbsp;&nbsp; 64.978202]&nbsp; ? irqentry_exit_to_user_mode+0x2a/0x1e0=
<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.978205]&nbsp; ? irqentry_exit+0x3f/0x50<o:p></o:p></p=
re>
<pre>[&nbsp;&nbsp; 64.978206]&nbsp; ? exc_page_fault+0x97/0x190<o:p></o:p><=
/pre>
<pre>[&nbsp;&nbsp; 64.978208]&nbsp; entry_SYSCALL_64_after_hwframe+0x76/0x7=
e<o:p></o:p></pre>
<pre>[&nbsp;&nbsp; 64.978210] RIP: 0033:0x7f3c08b24ded<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Fixes: fd4fde1df18b (&quot;drm/amdgpu/userq: Use drm_gem_objects_looku=
p in amdgpu_userq_signal_ioctl&quot;)<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>V2: initialize gobj_write<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>Signed-off-by: Jesse Zhang <a href=3D"mailto:jesse.zhang@amd.com">&lt;=
jesse.zhang@amd.com&gt;</a><o:p></o:p></pre>
<pre>---<o:p></o:p></pre>
<pre> .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c&nbsp;&nbsp; | 22 ++++++++=
+++++------<o:p></o:p></pre>
<pre> 1 file changed, 15 insertions(+), 7 deletions(-)<o:p></o:p></pre>
<pre><o:p>&nbsp;</o:p></pre>
<pre>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<o:p></o:p></pre>
<pre>index 3c30512a6266..af934374df94 100644<o:p></o:p></pre>
<pre>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<o:p></o:p></pre>
<pre>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c<o:p></o:p></pre>
<pre>@@ -467,7 +467,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *d=
ev, void *data,<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int num_read_bo_h=
andles =3D args-&gt;num_bo_read_handles;<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpriv *fpriv =3D f=
ilp-&gt;driver_priv;<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_mgr *userq_m=
gr =3D &amp;fpriv-&gt;userq_mgr;<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object **gobj_wri=
te, **gobj_read;<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object **gobj_wri=
te =3D NULL, **gobj_read =3D NULL;<o:p></o:p></pre>
</blockquote>
<p class=3D"MsoPlainText"><span style=3D"color:black">We don&#8217;t need t=
o set these to NULL anymore, drm_gem_objects_lookup already check and set i=
t to NULL if num objects is 0. I Don&#8217;t think this patch is needed any=
more.</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">I have already droppe=
d such patch few days back before i pulled in&nbsp;drm_gem_objects_lookup f=
ix patch from drm-misc. I think u might have not pulled in recent code chan=
ges.&nbsp;</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><b><i><span style=3D"font-size:11.0pt;font-family=
:&quot;Arial&quot;,sans-serif">[Zhang, Jesse(Jie)]&nbsp; &nbsp;<o:p></o:p><=
/span></i></b></p>
<p class=3D"MsoPlainText" style=3D"margin-left:5.25pt"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">I pulled the latest A=
SDN branch, along with the latest commit regarding drm_gem_objects_lookup, =
as shown below. Perhaps your fix hasn't been merged
 into ASDN yet.<o:p></o:p></span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:5.25pt"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Thanks Sunil and I wi=
ll drop this patch.<o:p></o:p></span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:5.25pt"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">commit d5391f9191dd2f=
9ca47bff90957432aa2f4328ca<o:p></o:p></span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:5.25pt"><span style=3D"font-=
size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Author: Alex Deucher
<a href=3D"mailto:alexander.deucher@amd.com">alexander.deucher@amd.com</a><=
o:p></o:p></span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:10.75pt"><span style=3D"font=
-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp; d=
rm: fix the build with -Werror<o:p></o:p></span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:10.75pt"><span style=3D"font=
-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">&nbsp;&nbsp;&nbsp; F=
ix unused variable when commit 8477a645d275 was cherry-picked.<o:p></o:p></=
span></p>
<p class=3D"MsoPlainText" style=3D"margin-left:5.25pt;text-indent:12.0pt"><=
span style=3D"font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Fi=
xes: 8477a645d275 (&quot;drm/gem: Make drm_gem_objects_lookup() self-cleani=
ng on failure v6&quot;)<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:11.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:11.0pt;font-family:&quot=
;Arial&quot;,sans-serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:11.0pt;font-family:&quot=
;Arial&quot;,sans-serif">Jesse&nbsp;
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:11.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black">Regards<br>
Sunil khatri</span><o:p></o:p></p>
<p class=3D"MsoNormal"><br>
<br>
<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre><o:p>&nbsp;</o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *syncobj_handles, num_syncob=
j_handles;<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_userq_fence *userq=
_fence;<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_usermode_queue *qu=
eue;<o:p></o:p></pre>
<pre>@@ -597,13 +597,21 @@ int amdgpu_userq_signal_ioctl(struct drm_device =
*dev, void *data,<o:p></o:p></pre>
<pre> exec_fini:<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_exec_fini(&amp;exec);<o:p></=
o:p></pre>
<pre> put_gobj_write:<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_write_b=
o_handles; i++)<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  drm_gem_object_put(gobj_write[i=
]);<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(gobj_write);<o:p></o:p></p=
re>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_write_b=
o_handles; i++) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gobj_write)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;  drm_gem_object_put(gobj_write[i]);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gobj_write)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(gobj_write);<o:p></o:p></pre>
<pre> put_gobj_read:<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_read_bo=
_handles; i++)<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  drm_gem_object_put(gobj_read[i]=
);<o:p></o:p></pre>
<pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(gobj_read);<o:p></o:p></pr=
e>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_read_bo=
_handles; i++) {<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (gobj_read)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;  drm_gem_object_put(gobj_read[i]);<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
<pre>+<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gobj_read)<o:p></o:p></pre>
<pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kfree(gobj_read);<o:p></o:p></pre>
<pre> free_syncobj:<o:p></o:p></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (entry-- &gt; 0)<o:p></o:p=
></pre>
<pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (syncobj[entry])<o:p></o:p></pre>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5152522CE6602B85622BEEFEE370ADM4PR12MB5152namp_--
