Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C765FF8864
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0DD610EA0A;
	Tue, 28 Apr 2026 03:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NJ2Kz8uR";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D181310EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:17:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUE/5iKD9+uzAUCTE+ozgbc4+zmP9O+FF3wr/4rVoX84LwqiP75C6aqVyJBSdl40q8+7ELm9pcX0PGqVZwpZiFvBAkEP5S/Naq388Rrz0Vv+bCJi0P67QWuloYG5YL634uTjlPp5+Zc5Wa46v1krNB6QO3HbkMtHyVLT5gv/2j5u+TmkNSCtLc/gT7uvLIJepedTwkTLc0vZ7nlp5KdgsgaqJmLI752mapnfiZbOq8e68mgCELXiToQsWX5VpriyRaxrJbG9poR/QhBG8jOnitcyIKNHCbwBd84ayBD6tU6rchrmwV5vPiFd2j/EeSkZyfu/BXpgHWmRD70qYROiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ3V3OoQkJV+ihJYhULIq7MK3vFf8IppXU8PWUeKEHA=;
 b=XPMwNrqyXE7ibDSsODDm3wp3IIUkhNcFvQjizJBiEBcnNlGYIDiAxzWpZXwzmbjRENuhLOphu8Ak7ITOy6RYqjCQesIc1kvgGIQ3hQux6DP/44aqgPXrK2ZWwc0yzpL0im4NvRAMrZldKFdLUC9bDOlcMW7LUZq8aRWGjsVVaqpLx0qRxjjlh/y5nSaXixG+WQNDwZANmxmtiTjmPlDCv4zclW3ovivfAKeKdugCBKy9R8/nCfPtLVjKCgsRKuhWNsQhbFb8wDQiXn2lK0Yom6JZsd6HIPcyzDkOWfzHHZBNQ3UfLkOcv6GIp4e2JdtzIiCmksaQPth1UOB/RMwdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ3V3OoQkJV+ihJYhULIq7MK3vFf8IppXU8PWUeKEHA=;
 b=NJ2Kz8uRQV7SmmKSG8Xbgx3GCHSnf1N+MbHTAWZXjiEjZrKnseG/Hk5JFGWMQUIgP9OmwPqNUiw5sT4Spaiy6IEG0nL9E/WhCwq5sryzmdaWiGOttEAv3esivtpjerSrgq3eU+BqNdco7DKms1IE2GVYJ10lw/C2TFYwr6G0VlA=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:17:05 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:17:05 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Thread-Topic: [PATCH v2 11/17] drm/amdgpu: add profiler/spm operation
 AMDGPU_SPM_OP_SET_DEST_BUF
Thread-Index: AQHcu9Qaj7Gte1ieL0OwrERi5/okprX0A00w
Date: Tue, 28 Apr 2026 03:17:04 +0000
Message-ID: <BY5PR12MB4179A6EBC3AC2FE13BB8B4C3FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-12-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-12-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:17:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 55926b77-8b9d-43a8-6ff5-08dea4d49f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: rsInoAi2IluACwIkraMoD5+DcRVuCPsIM46EN774MqR1HFsMCug8Fg5g9uCaqloCLaJQbCwGjjyaLWdpvb6HVkBVfo9hndcMjdbPwD/wFSkAbboAzYYCu8Iij01zhJGz9aj0TUH0AD/AOi65dLPei4rZp3VYR0gi5OuaNDmw8ILojxcQCgUQigHKtNCYyYYbzHfuAgTOPFSiXyHKwlxt2CyELBuJiou4WOoVX6PqiO58NVCliWjsi0gZW39UbazqAbdttntGXjcCsBGZ6+TvIMBkPGHzBDSTq6RfcAZ43wrHVL+AZr2bOnGrR1uwullYe5wrxTsRENGhDXTGqFdDkzcjRymd6Bu/a7wBCLuIa9rB6d20jHuccatKMZu3IbuSyzF7D5ScNVOOliD38S5LyCELebL+eF2r880u4mOhoLrN7NzDQR6ZWjcvsrJx9SG5fsXehKW/CAfv1XgE7RsAlXkLz2Xb1ivMV6XW9CffyZbB4WC5VUy280Zbvx+ORMnxoTPDV41oHIx9Ck+O6jmrKDj53LXb+febzN9BUXBhSF+7FxaOuYRZIsE61jtf7/8TFoucjTkS10O2q0vfAYb7HVyPBF5tDFfMFFx/ZPdbI7YyzNQenR3WzJRGnI7NEMvio7iZsrERUAuodK+EmFK4oFWhbbNsJcAnPUoXYM75+9USvIpGu8vvWrxFd90PykGQhJfb56Qw4y7XhYYbfj8Jy7hHc7iNmCZvJ+P2ESVIVpsad2FcYsmAN1jLdgGP7yMtbWrm3unG36lu9orHE75ymOLWOF48PM0emFrdazpxe0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FB7yIqTeKnM6HLu6mOww1MCflHaCQEvuJ1NbIC/GCcT0FFdHeGGxqW9sS+5G?=
 =?us-ascii?Q?9ZAG98fvyuxJvKWHoa5VuUOf+lF9cieWxmTRXAnyrsqEm07BtrmrkxEnIxLc?=
 =?us-ascii?Q?1iPTGDBrPukk7hUsFPfn4zVWKYbas6M5tW1j7P5E06kthwhhCWYwROQIuJhu?=
 =?us-ascii?Q?CF6Hw7SOHnYUSVRRLOCvkHboZQ6XxMFsVkqZGwv6O87VvJRs/+KhJ9VOqEH6?=
 =?us-ascii?Q?0ijkw5Mm3t1WFh0cZ6MU+k0QrJhH3Wkfu1L1Fax0VhdxykKZFYoyZ9OPVsa1?=
 =?us-ascii?Q?VlY/fXA4ZJ3C1F9QEC45wCpIrZL4FGWdND856Ls0vM37F2oASyGdCjCuuuLs?=
 =?us-ascii?Q?NcQ+hOyIcr+6Q0fxs75uILw/9XJGeRBpKSlmk7GLA4Co6TZfmswuHwrMIkGH?=
 =?us-ascii?Q?L0aPnh4TY14QH8yj1cQ4jcZPxscdsFOqezeOO7pjoxOMi0DJ850zYcTrX7oK?=
 =?us-ascii?Q?8Y2eybc8AGWr38RkJkLLQMUhcwkSMh/64eXIszET3I82x2IQmeoTfchCbbFM?=
 =?us-ascii?Q?20gUSjD/J2J0pJgQFykI4hE8dYYhRzkqVRzSYXL+9X3WLqOe047Mhd077teE?=
 =?us-ascii?Q?lu0I8xqMfoWMTjLa6sy22yBaVbLzKUEnBCnsiiX1FvkI1Wk4NqF+mcvwXKBY?=
 =?us-ascii?Q?NfGI3zIsyprJyrKFpNJ2F3J4c8wy+rHkhDwD9iGPQ841AqIRjrgZ6qlw1OhZ?=
 =?us-ascii?Q?k1fdYnIIW8bEk9GYZQXZb2TYOJEcu26Zn4xYwWKSOx1hvEFsBjFTgiFLKZME?=
 =?us-ascii?Q?UDppRIs/hb1dedPf32T3NTnz8OGYw44ZxnH2OwHHLICVnFZsynvy7ZoNaHxN?=
 =?us-ascii?Q?G6BNuHJXd9EqBN1e1wPe/Are0ya21qnMEaX2VHMJXog3Kw9gXNvw7iEYUb7v?=
 =?us-ascii?Q?CvhfeInHW1c7U4sVL6Kp8Vw9t4IMn03HEwoG1gYOVmJn1Qbqd9wjEYlh1RyS?=
 =?us-ascii?Q?1apZ/3uosawPIkcSba+BIKeVAkY5d8sL2KAIbGUPtNliKGU03fvPn5sDvDHF?=
 =?us-ascii?Q?03jsyJ7BzYA+7HS3f8lhsfTY6OrJcbtxmg1cf2RqIvARqSpTrFcIhMAWi0Ha?=
 =?us-ascii?Q?croN8XVhfa7lqTK8PtqwA0dVRM2JEj7iwGW/Sl4CgfMeiqFGwItZB38u+zUU?=
 =?us-ascii?Q?e7+jXz3T5NqNqOFrtFTZlxhM681YPn5SOHax2HDAfMwUfVGqA7PWug+Vs3tG?=
 =?us-ascii?Q?8pyO1uiFpsyzw7SI1F1AtD0Ci4jcPFAaAX7gfXPrTIfT92OUYlf1/937Bkl3?=
 =?us-ascii?Q?qTATtnmHeFa8Ww6A0T1XMslc1NUcquX42BOw+2yvWcouXOwJQ7F4GVnl7ZWW?=
 =?us-ascii?Q?//buJa7JE9eWxEqyCNuTikup6ZhNNyi+gAID5wNjW7A+AaWdsicq2aiPC2vI?=
 =?us-ascii?Q?9K3PRqaKwBnuXqBJn3tm78ZSfNV+nkOEFcC1Pa0I+/5zBFQMOCAzG+gYy496?=
 =?us-ascii?Q?UfGuboL74228ZV1LMXdOXz6MDQhIngOiyDZ5KFE3y3agMt/gLpbiiTNkBySz?=
 =?us-ascii?Q?mHakXENWRUwjLWPLyuJwD6TMkRgfEmogGGaJ15BePvQFBdkkfBlFRMdvXypr?=
 =?us-ascii?Q?cAAi6FZBL5GbugWWrJwEG8FXGQrXsD+XU+89JJ7hvPPesykwzYJ6Y6A/cMC1?=
 =?us-ascii?Q?jvCfjTCS6x4p8J72cgB7xk6c3omwExy6pawq4tGtG4olSHUKUiGlt5xrTYI1?=
 =?us-ascii?Q?HwDyv6gxs9ODSrQHd+NNdVj/B+QC8Wz3o18ZZ//t8eK5Pz3y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55926b77-8b9d-43a8-6ff5-08dea4d49f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:17:04.9737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JA+ffMYpAZqDpoBy5VB9utihkW7h95WQcE9iqknFUHkZdU8fejde0pnsxGriXdylws2qhQki8q9uwVFxigyK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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

AMD General

Reviewed-by: Bing Ma <Bing.Ma@amd.com>

-----Original Message-----
From: Zhu, James <James.Zhu@amd.com>
Sent: Tuesday, March 24, 2026 2:20 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Ma, Bing <Bing.Ma@amd.com>; Francis, David <David.Francis@amd.com>
Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu, Jenny (Jing) <Jenny-Jing.=
Liu@amd.com>; Zhu, James <James.Zhu@amd.com>
Subject: [PATCH v2 11/17] drm/amdgpu: add profiler/spm operation AMDGPU_SPM=
_OP_SET_DEST_BUF

to implement AMDGPU_SPM_OP_SET_DEST_BUF, which registers a user-space desti=
nation buffer for SPM data streaming, optionally waits for the previous buf=
fer to be filled, and starts or stops the SPM hardware per XCC instance.

Data structure additions (amdgpu_spm.h):
  struct spm_user_buf:
    Tracks the current user-space destination buffer per XCC: the
    adjusted user_addr (offset past the drm_amdgpu_spm_buffer_header)
    and remaining ubufsize in bytes.

  amdgpu_spm_base extended with:
    ubuf (spm_user_buf), ring_rptr, size_copied, has_data_loss,
    has_user_buf (buffer registered), is_user_buf_filled (buffer full),
    is_spm_started (SPM HW running).

  amdgpu_spm_cntr extended with:
    spm_use_cnt (number of active XCC ring buffers), have_users_buf_cnt
    (number of XCCs with a registered user buffer), are_users_buf_filled
    (true when all registered buffers are full), spm_buf_wq (wait queue
    head for blocking on buffer fill).

  amdgpu_spm_mgr extended with:
    spm_irq_lock (spinlock protecting is_spm_started and ring_rptr
    against concurrent IRQ handler access).

SET_DEST_BUF flow (amdgpu_set_dest_buffer):
  1. Validates spm_cntr is allocated and spm_use_cnt > 0.
  2. Splits the caller-supplied buf_size evenly across all active XCCs
     (spm_use_cnt), rounded down to 32-byte alignment. Returns -EINVAL
     if the per-XCC slice cannot accommodate a drm_amdgpu_spm_buffer_header
  3. If timeout > 0 and a previous buffer is still being filled,
     blocks on spm_buf_wq via wait_event_interruptible_timeout().
     On -ERESTARTSYS the remaining timeout is computed and returned so
     the syscall can be transparently restarted by user space. On
     -ETIME (timeout expired), the work queue is flushed immediately
     to capture any partial data, and the call returns success.
     If timeout =3D=3D 0 and a previous buffer exists, the work queue is
     flushed immediately without waiting.
  4. For each XCC in AMDGPU_XCC_MASK(adev), calls spm_update_dest_info():
     - If a previous user buffer was registered (has_user_buf), writes
       the drm_amdgpu_spm_buffer_header (SPM version, bytes_copied,
       has_data_loss to the reserved header slot just before ubuf.user_addr
       via copy_to_user(), accumulates bytes_copied and has_data_loss into
       the ioctl output args, and decrements have_users_buf_cnt.
     - If a new dest_buf is provided, advances the internal user_addr
       past the header, records ubufsize, resets size_copied, has_data_loss
       and is_user_buf_filled, sets has_user_buf, and increments
       have_users_buf_cnt.
  5. If dest_buf !=3D NULL and the XCC's SPM is not yet started:
     calls amdgpu_rlc_spm_cntl(start), resets ring_rptr to 0 under
     spm_irq_lock (since amdgpu_rlc_spm_cntl() resets wptr to 0),
     and sets is_spm_started. If SPM was already running, sets
     need_schedule to drain existing ring data after the mutex is
     released.
  6. If dest_buf =3D=3D NULL: stops the SPM hardware via
     amdgpu_rlc_spm_cntl(stop), clears is_spm_started and ring_rptr
     under spm_irq_lock.
  7. After releasing the XCP mutex, schedules the work queue if
     need_schedule is set.

amdgpu_spm_interrupt() stub is implemented: resolves the xcp_id from xcc_id=
 using amdgpu_xcp_get_partition() (defaulting to 0 on non- partitioned devi=
ces), looks up the corresponding spm_mgr, and under spm_irq_lock schedules =
the work queue if SPM is active on that XCC.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 217 +++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  18 ++
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index e58b89ccd83f..896a0fef576c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -29,6 +29,9 @@
  * 0.1 - Initial revision
  */

+#define AMDGPU_SPM_MAJOR_VERSION       0
+#define AMDGPU_SPM_MINOR_VERSION       1
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_f=
ile *filp);  static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr=
, int inst, struct drm_file *filp);

@@ -120,12 +123,16 @@ static int amdgpu_spm_acquire(struct amdgpu_spm_mgr *=
spm_mgr, struct drm_file *f
                ret =3D _amdgpu_spm_acquire(spm_mgr, inst, filp);
                if (ret)
                        goto acquire_spm_failure;
+               spm_mgr->spm_cntr->spm_use_cnt++;
        }

+       spm_mgr->spm_cntr->have_users_buf_cnt =3D 0;
        mutex_init(&spm_mgr->spm_cntr->spm_worker_mutex);

+       init_waitqueue_head(&spm_mgr->spm_cntr->spm_buf_wq);
        INIT_WORK(&spm_mgr->spm_work, amdgpu_spm_work);

+       spin_lock_init(&spm_mgr->spm_irq_lock);
        spm_mgr->file =3D filp;

        goto out;
@@ -153,6 +160,197 @@ static int amdgpu_spm_release(struct amdgpu_spm_mgr *=
spm_mgr, struct drm_file *f
        return 0;
 }

+static int spm_update_dest_info(struct amdgpu_spm_mgr *spm_mgr,
+                               int inst, struct drm_amdgpu_spm_args *user_=
spm_data,
+                               struct drm_amdgpu_spm_args *user_spm_ptr) {
+       struct amdgpu_spm_base *spm =3D &(spm_mgr->spm_cntr->spm[inst]);
+       int ret =3D 0;
+
+       mutex_lock(&spm_mgr->spm_cntr->spm_worker_mutex);
+       if (spm->has_user_buf) {
+               struct drm_amdgpu_spm_buffer_header spm_header;
+               uint64_t __user *user_address;
+
+               user_spm_ptr->bytes_copied +=3D spm->size_copied;
+               user_spm_ptr->has_data_loss +=3D spm->has_data_loss;
+
+               memset(&spm_header, 0, sizeof(spm_header));
+               user_address =3D (uint64_t *)((uint64_t)spm->ubuf.user_addr=
 - sizeof(spm_header));
+               spm_header.version =3D AMDGPU_SPM_MAJOR_VERSION << 24 |
+                                       AMDGPU_SPM_MINOR_VERSION;
+               spm_header.bytes_copied =3D spm->size_copied;
+               spm_header.has_data_loss =3D spm->has_data_loss;
+               spm->has_user_buf =3D false;
+               spm_mgr->spm_cntr->have_users_buf_cnt--;
+
+               ret =3D copy_to_user(user_address, &spm_header, sizeof(spm_=
header));
+               if (ret) {
+                       ret =3D -EFAULT;
+                       goto out;
+               }
+       }
+       if (user_spm_data->dest_buf) {
+               spm->ubuf.user_addr =3D (uint64_t *)user_spm_data->dest_buf=
;
+               spm->ubuf.ubufsize =3D user_spm_data->buf_size;
+               /* reserve space for drm_amdgpu_spm_buffer_header */
+               spm->ubuf.user_addr =3D (uint64_t *)((uint64_t)spm->ubuf.us=
er_addr +
+                                       sizeof(struct drm_amdgpu_spm_buffer=
_header));
+               spm->ubuf.ubufsize -=3D sizeof(struct drm_amdgpu_spm_buffer=
_header);
+               spm->has_data_loss =3D 0;
+               spm->size_copied =3D 0;
+               spm->is_user_buf_filled =3D false;
+               spm->has_user_buf =3D true;
+               spm_mgr->spm_cntr->are_users_buf_filled =3D false;
+               spm_mgr->spm_cntr->have_users_buf_cnt++;
+       }
+out:
+       mutex_unlock(&spm_mgr->spm_cntr->spm_worker_mutex);
+       return ret;
+}
+
+static int spm_wait_for_fill_awake(struct amdgpu_spm_cntr *spm_cntr,
+                       struct drm_amdgpu_spm_args *user_spm_data) {
+       int ret =3D 0;
+
+       long timeout =3D msecs_to_jiffies(user_spm_data->timeout);
+       unsigned long start_jiffies =3D jiffies;
+
+       ret =3D wait_event_interruptible_timeout(spm_cntr->spm_buf_wq,
+                                (READ_ONCE(spm_cntr->are_users_buf_filled)=
 =3D=3D true),
+                                timeout);
+
+       switch (ret) {
+       case -ERESTARTSYS:
+               /* Subtract elapsed time from timeout so we wait that much
+                * less when the call gets restarted.
+                */
+               timeout -=3D (jiffies - start_jiffies);
+               if (timeout <=3D 0) {
+                       ret =3D -ETIME;
+                       timeout =3D 0;
+                       pr_debug("[%s] interrupted by signal\n", __func__);
+               }
+               break;
+
+       case 0:
+       default:
+               timeout =3D ret;
+               ret =3D 0;
+               break;
+       }
+       user_spm_data->timeout =3D jiffies_to_msecs(timeout);
+
+       return ret;
+}
+
+static int amdgpu_set_dest_buffer(struct amdgpu_spm_mgr *spm_mgr, void
+*data) {
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+       struct drm_amdgpu_spm_args user_spm_data, *user_spm_ptr;
+       struct amdgpu_spm_cntr *spm_cntr;
+       bool need_schedule =3D false;
+       unsigned long flags;
+       u32 ubufsize;
+       int ret =3D 0;
+       int inst;
+
+       dev_dbg(adev->dev, "SPM start to set new destination buffer.");
+       mutex_lock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+       spm_cntr =3D spm_mgr->spm_cntr;
+       if (spm_cntr =3D=3D NULL ||
+               !spm_cntr->spm_use_cnt) {
+               ret =3D -EINVAL;
+               goto out;
+       }
+
+       user_spm_ptr =3D (struct drm_amdgpu_spm_args *) data;
+       ubufsize =3D user_spm_ptr->buf_size / spm_cntr->spm_use_cnt;
+       ubufsize =3D rounddown(ubufsize, 32);
+
+       if (ubufsize  <=3D sizeof(struct drm_amdgpu_spm_buffer_header)) {
+               ret =3D -EINVAL;
+               goto out;
+       }
+
+       memcpy(&user_spm_data, user_spm_ptr, sizeof(user_spm_data));
+       user_spm_data.buf_size =3D ubufsize;
+
+       if (user_spm_data.timeout && spm_cntr->have_users_buf_cnt &&
+           !READ_ONCE(spm_cntr->are_users_buf_filled)) {
+               dev_dbg(adev->dev, "SPM waiting for fill awake, timeout =3D=
 %d ms.",
+                               user_spm_data.timeout);
+               ret =3D spm_wait_for_fill_awake(spm_cntr, &user_spm_data);
+               if (ret =3D=3D -ETIME) {
+                       /* Copy (partial) data to user buffer after a timeo=
ut */
+                       schedule_work(&spm_mgr->spm_work);
+                       flush_work(&spm_mgr->spm_work);
+                       /* This is not an error */
+                       ret =3D 0;
+               } else if (ret) {
+                       /* handle other errors normally, including -ERESTAR=
TSYS */
+                       goto out;
+               }
+       } else if (!user_spm_data.timeout && spm_cntr->have_users_buf_cnt) =
{
+               /* Copy (partial) data to user buffer */
+               schedule_work(&spm_mgr->spm_work);
+               flush_work(&spm_mgr->spm_work);
+       }
+
+       user_spm_ptr->bytes_copied =3D 0;
+       user_spm_ptr->has_data_loss =3D 0;
+       for_each_inst(inst, AMDGPU_XCC_MASK(adev)) {
+               struct amdgpu_spm_base *spm =3D &(spm_cntr->spm[inst]);
+
+               if (spm->has_user_buf || user_spm_data.dest_buf) {
+                       /* Get info about filled space in previous output b=
uffer.
+                        * Setup new dest buf if provided.
+                        */
+                       ret =3D spm_update_dest_info(spm_mgr, inst, &user_s=
pm_data, user_spm_ptr);
+                       if (ret)
+                               goto out;
+               }
+
+               if (user_spm_data.dest_buf) {
+                       /* Start SPM if necessary*/
+                       if (spm->is_spm_started =3D=3D false) {
+                               amdgpu_rlc_spm_cntl(adev, inst, 1);
+                               spin_lock_irqsave(&spm_mgr->spm_irq_lock, f=
lags);
+                               spm->is_spm_started =3D true;
+                               /* amdgpu_rlc_spm_cntl() will reset SPM and
+                                * wptr will become 0, adjust rptr accordin=
gly.
+                                */
+                               spm->ring_rptr =3D 0;
+                               spin_unlock_irqrestore(&spm_mgr->spm_irq_lo=
ck, flags);
+                       } else {
+                               /* If SPM was already started, there may al=
ready
+                                * be data in the ring-buffer that needs to=
 be read.
+                                */
+                               need_schedule =3D true;
+                       }
+                       user_spm_data.dest_buf +=3D ubufsize;
+               } else {
+                       amdgpu_rlc_spm_cntl(adev, inst, 0);
+                       spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+                       spm->is_spm_started =3D false;
+                       /* amdgpu_rlc_spm_cntl() will reset SPM and wptr wi=
ll become 0.
+                        * Adjust rptr accordingly
+                        */
+                       spm->ring_rptr =3D 0;
+                       spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flag=
s);
+               }
+       }
+
+out:
+       mutex_unlock(&(to_prof_xcp_mgr(spm_mgr, spm_mgr)->mutex));
+       if (need_schedule)
+               schedule_work(&spm_mgr->spm_work);
+
+       dev_dbg(adev->dev, "SPM finish to set new destination buffer, ret =
=3D %d.", ret);
+       return ret;
+}
+
 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
                       struct drm_file *filp)
 {
@@ -167,10 +365,13 @@ int amdgpu_spm_ioctl(struct drm_device *dev, void *da=
ta,
        case AMDGPU_SPM_OP_ACQUIRE:
                return amdgpu_spm_acquire(spm_mgr, filp);

+       case AMDGPU_SPM_OP_SET_DEST_BUF:
+               return amdgpu_set_dest_buffer(spm_mgr, data);
+
        default:
                dev_dbg(adev->dev, "Invalid option: %i\n", args->op);
-               return -EINVAL;
        }
+       return -EINVAL;
 }

 int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr) @@ -189,5 +390,17 =
@@ void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr)

 void amdgpu_spm_interrupt(struct amdgpu_device *adev, int xcc_id)  {
-       /* TODO */
+       uint8_t  xcp_id;
+       unsigned long flags;
+       struct amdgpu_spm_mgr *spm_mgr;
+
+       xcp_id =3D adev->xcp_mgr ?
+               fls(amdgpu_xcp_get_partition(adev->xcp_mgr, AMDGPU_XCP_GFX,=
 xcc_id))
+- 1 : 0;
+
+       spm_mgr =3D &(adev->prof_mgr.prof_xcp_mgr[xcp_id].spm_mgr);
+
+       spin_lock_irqsave(&spm_mgr->spm_irq_lock, flags);
+       if (spm_mgr->spm_cntr && spm_mgr->spm_cntr->spm[xcc_id].is_spm_star=
ted)
+               schedule_work(&spm_mgr->spm_work);
+       spin_unlock_irqrestore(&spm_mgr->spm_irq_lock, flags);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
index 9db89fd6154d..5eed6aa6482a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -24,15 +24,32 @@
 #ifndef AMDGPU_SPM_H_
 #define AMDGPU_SPM_H_

+struct spm_user_buf {
+       uint64_t __user *user_addr;
+       u32 ubufsize;
+};
+
 struct amdgpu_spm_base {
+       struct spm_user_buf ubuf;
        u64    gpu_addr;
        u32    ring_size;
+       u32    ring_rptr;
+       u32    size_copied;
+       u32    has_data_loss;
        u32    *cpu_addr;
        void   *spm_obj;
+       bool   has_user_buf;
+       bool   is_user_buf_filled;
+       bool   is_spm_started;
 };
+
 struct amdgpu_spm_cntr {
        struct amdgpu_spm_base spm[MAX_XCP];
+       int spm_use_cnt;
        struct mutex spm_worker_mutex;
+       wait_queue_head_t spm_buf_wq;
+       u32   have_users_buf_cnt;
+       bool  are_users_buf_filled;
 };

 struct amdgpu_spm_mgr {
@@ -43,6 +60,7 @@ struct amdgpu_spm_mgr {
        /* spm data */
        struct amdgpu_spm_cntr *spm_cntr;
        struct work_struct spm_work;
+       spinlock_t spm_irq_lock;
 };

 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
--
2.34.1

