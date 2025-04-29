Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC8C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14A810E02F;
	Tue, 29 Apr 2025 19:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tCNj4RxD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC3B10E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2Wh30/sDnVirM9p14KSG0Dy+CX+zCrjUJEcXWZk90jdeVefTqDwkE6ApTij2/lw7DcQzNNIKCh0H9puyASHK+sJjpgdQDXtUqVTgCJUfTYX1QYUJJ3MvolISryGlwjj4uwobWEZ+7/uwu7awjHvi92Rq+Yf+IgNX/zKRGBZbZW6TMUIf8qz8avbRkjsTVl1xDsBsTGlwpc7FzrTLdn4niuKXIZ2aifkbUYPXhSGj50wOpNDu332dp7I65+m+uDRylsgaeoZIR0ipwRDH8/9P7eQyiJT56oR72Ze+nVc5ZHie/4TqMEUgdBawCubqqopuJqyvE8rjz0nGi5tNNcOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj865u8HCn9B6hUo62C120bvMsiyebkbkkm6cZqyXlg=;
 b=kR75Vd0CzYFJRLcZv0wOF8vUaDo7zRCPf3DQAZ+9KA5VV8Wfp85qrAmwdEvBmpS9hSeGvsCVInvuAxkAmoz2wTLcjYIZQVupqwfWYc8qMuSUhzSKK7tRFUgr/jgAPgM6Ckx65QIvzPE5TeEf+3atBftBx+SJjh5m9XMOLUfzpV7NgOG5mbNct1QCMKZnlK7/Chmqh3ukICkSBMxbGn6o8vwHeKNqRaFuHXWjmtjV+ktN0MSVCVYMU0Y0McUZnWmh0n8bXlnxNPEh3T6rlRdhykyEpFoXY90HbfTWfR+okLBj+oUYbik0JXd28ErqaaSDtO+tIItGVUzdbBkSft9E2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nj865u8HCn9B6hUo62C120bvMsiyebkbkkm6cZqyXlg=;
 b=tCNj4RxDgVzhjjsnKRoapPz5jjXMsy8EHGN33wXCzZM+D1o/x96hYdVISIrNalIwWcZxBgv9d4xEnDKfE8Vh3vP93mssPSZUfgiRs2lk1egmBpLXdL74PFrrKdsZxeQtSTFfTbqA0Ox2Z9AFJtCPSTUX6OQpUsUCtgv2b9SRbWA=
Received: from SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15)
 by PH8PR12MB8606.namprd12.prod.outlook.com (2603:10b6:510:1ce::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 19:42:55 +0000
Received: from SJ1PR12MB6268.namprd12.prod.outlook.com
 ([fe80::305b:71d7:26f4:3d93]) by SJ1PR12MB6268.namprd12.prod.outlook.com
 ([fe80::305b:71d7:26f4:3d93%5]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 19:42:55 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Subject: Re: [PATCH] drm/amdgpu/mes: use correct MES pipe for resets
Thread-Topic: [PATCH] drm/amdgpu/mes: use correct MES pipe for resets
Thread-Index: AQHbuT0n2xYwIDXb10eI0+RaUM2Bc7O7CsXS
Date: Tue, 29 Apr 2025 19:42:55 +0000
Message-ID: <SJ1PR12MB6268B58B4B39A5BDC4E6133494802@SJ1PR12MB6268.namprd12.prod.outlook.com>
References: <20250429193006.1931477-1-alexander.deucher@amd.com>
In-Reply-To: <20250429193006.1931477-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-29T19:42:54.671Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6268:EE_|PH8PR12MB8606:EE_
x-ms-office365-filtering-correlation-id: 74c70e23-88b4-4f86-38a6-08dd87560974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/yAhmSUJMDqvJBwATNxNRyE101Cm3r6Lg0qIx+WiQ1XMl2GeSq/PYgQtvcMJ?=
 =?us-ascii?Q?0gpfrECL345IVemeIEUHC0lcfHr5MkgAG9SWVzB1H3p7i0iUhY4PeqzVvErT?=
 =?us-ascii?Q?Q2HI0tLZDdZ5p0X07YPth26kqlGWazpzgX1WnbQLy9qnprLNiYU0HLAbMeC2?=
 =?us-ascii?Q?FjKoeX+wychy6ubkBhfn0wCoALycX6gJqJEqNMUCwiwiXMKYZeAvoWiXSFqk?=
 =?us-ascii?Q?wr+oXiO1k5piw9Uu8UhXlHlHVVR+NvWoB2inynpKxP8cpgLjCFs4sM1rMs+Y?=
 =?us-ascii?Q?aZkQAI8GZ7/129sfvfSCaI6GaokjzXQ6TBEemIULLJiqfXBNKPzX/+OnoAr0?=
 =?us-ascii?Q?Y6lMCNTOypvliGvUNHb7bT40wlUA6bquO1HvlbakMVtMPCOQuam0BFYrRAvK?=
 =?us-ascii?Q?hjKEAsm1RYUpCEpTtCVg16XEwwt4ruYIAjhs/oGK4AkvopBCm8T4qVwYVNVd?=
 =?us-ascii?Q?zPoHsoIpoGOXenXY7ezMSsHiYhqdkdhEzie6QFTzFs3APBD6VQPAa0PZZC9P?=
 =?us-ascii?Q?uITUYc6kuPBab6mTDapsWNy7KGmvSHFgpaYyeM1Xd48orLELk8QKfZuaIfOB?=
 =?us-ascii?Q?T4nIfmJhzOw9GtL7kAmpUmLOKr8pucefwsVtQqmRslOn5cxLrDsQqC6Mh7sC?=
 =?us-ascii?Q?ogQlSwvsaRvNC6S9NMduK3Che6UIU7FG6oZvIS5tmEXCco4JuZo/0v0dff37?=
 =?us-ascii?Q?Cd/oykHs31RJkU7AlhyXtQZ+0kJwZmQooxblcXL+T4REu34xF/boncM7wmV1?=
 =?us-ascii?Q?mucvgQXg9C+fwNZd0isQdv2Xv1iGaEdqRyorsYEUkrngeGVtxDNbYbo5aJav?=
 =?us-ascii?Q?/DN1ZF2J31afOjlWSB0njJW868EhU5YHXzIvdKxDhZ7edCzpCy9QKY3z46V4?=
 =?us-ascii?Q?Z/Bj2QOrMaNpALp6vEcVeaXKV7XLrvyaN96BpClQkYi04NtaZNxfRMqH46zk?=
 =?us-ascii?Q?eGoCwK3sgxE2KTH0x1WHbGKNDbgE9bQC8Ckip7o+EUAxQD4j/K7GuDAojt4d?=
 =?us-ascii?Q?6baGyiZMCsyEwprGZnnC+Jnadt7wB4FpvGrrwclFHbN6n0nxUvB36Myv6Ea+?=
 =?us-ascii?Q?AN5Qu5I3ll3L06ywe11qIm+KStdnXthn3vAUCqdVe7PbwyF53bgyiXs0Ov1+?=
 =?us-ascii?Q?+44VAKzFtLjqthmEpCI3UiMtMS/J+HZKYlPSvlf+PXP4oZjn+by5Anip937h?=
 =?us-ascii?Q?cPAcPScoOchbIvrgpr1Ia6R0tViSIfisy1/05/OC4+UtCW37rA3DQnje/+TE?=
 =?us-ascii?Q?nybqPoD/+6zFcVziQr0dRjoOUnGzOxNb8Boc3tK0+MlW+gomhWbRA36/pHKi?=
 =?us-ascii?Q?aG1TZlvkSG+IkYtrFuyv7y25cSz33Eu+oL6HRn1+4sCyLIBkGhMicxOD3m1m?=
 =?us-ascii?Q?De7/TmrmW3rs0GoKyClA4KNMN4vR20RYmWYD6Rw8QYQD7mJ3KtWDFzElPe+W?=
 =?us-ascii?Q?R/ACCVhQLBiiBf9SUooZR9eQXGAsolnV67swaAgCvX4O7JPUrmBJHXB7oYx8?=
 =?us-ascii?Q?TUbL1Lby9kOq5LY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6268.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L3E9LEm/d5w7WxWdBl/C4zheNOhpa1JYAK30LFTdeVWXQ0prWC62yQiCFiPB?=
 =?us-ascii?Q?hdlUVSZHLGMO1hBp154MR9wK8NOPhOPgL5JtlIMnr+Cch2elQ9wQ1z2JC8KI?=
 =?us-ascii?Q?bx9xMTjf5nLwpwWrQcBHDx2TmbYqMHb2fkHVpwzY07Ym1L0GDh6ncX37P+L0?=
 =?us-ascii?Q?CBGuJDeAiPoNzdagS9MI8AskKKRzdORmFznDQgJEQlsvywzf5UAmgCPXKEti?=
 =?us-ascii?Q?VZJ2nTU/QqfKeq19TG2GS8yFWu2BhL+OoBwnFR4G+37G1Y2mME/TGhIUoAXc?=
 =?us-ascii?Q?dA01wyCf+q4YnjylY8ePaSTsDPozW8AWedTzR+JnAiwgXQ9gKULYy125eEjn?=
 =?us-ascii?Q?MISc7UFeUgF+ydjNi43K/M7lAmarI/5FTs/51roVLHElahEU/a61r/R1hvq0?=
 =?us-ascii?Q?3WExZs/Grmw0PJ0EweIg0elDzpnkr25G5ieqqyW7WR3iDttbdU3eqcOplKxY?=
 =?us-ascii?Q?OeCoO4T1tivrK4d62aXOnS4Y6pvtxK2Cg9yE8zb66OELG/xlb7gW5nRvosum?=
 =?us-ascii?Q?OxL+O0ePaumPvbmwhPBZpU+ljgs41W3Jm6R1skNn7BPb+LT+78cTvtI6BLS2?=
 =?us-ascii?Q?VI2gsgav/VtrDIY//ge1BVP9wZynrveV4Kq4eRxz8cZIA8odWmy+9v5peX55?=
 =?us-ascii?Q?w/9lev+B3AZXr5sNVXUwOOwq3m/zxUTkLOrPuAP6VEFjdq87dbkQ+ZvtUu5B?=
 =?us-ascii?Q?xT/vO4CA7P2XWNdRmEB+Yrvkonk9mq0C6OC9PJ1cuxtHO1PIkWKQpsaJd3c5?=
 =?us-ascii?Q?3z8WGcyzUm2+Jx8lSRci90+MSZRe59AlgezBjkkir7g+dA1vDTbWRMa7cfeC?=
 =?us-ascii?Q?3BcIGh3k8/73fhQ/jrjXO3gSMC1zCnoDNldVVcxcm7MoLPVtXhDeJet0paLt?=
 =?us-ascii?Q?xIdsCUeJhVpbMkvscARVEgdA6/kUwIP7ZVgDs6/JxcddxdRneKIvwE6KWMVB?=
 =?us-ascii?Q?4k+tPndZxbhSdjiCpSK47WI6xaWdr3QcnS47VfCNRfJkUzgmW7Ki+OxmEq6C?=
 =?us-ascii?Q?2R50R4XpIQoiDODYFLgy+8zmMdACbqmkTaruvNZqgBaXrEr5qX6chmgqLQW/?=
 =?us-ascii?Q?PL1GePzHk/Nnrh2AHfRq+BuEyWD9pIcNwL63SB+g/MzMhoJ8tl/gXUo4KF0S?=
 =?us-ascii?Q?d51msCKz8eNr/U1WLkhSxqy1aIuqkjXyftRecUL3NmFc9/3GUhUBPICCaYEA?=
 =?us-ascii?Q?OAEkwaoZa/L4mESsUUoqltKng4QnNyuMKtbrXeIt3sNLGXuUYaxm/fW6CdhD?=
 =?us-ascii?Q?GajNJODxOAnW+9EAZUCF4OBAlg03FbYHNm9FXlHzrGWDzH2N98QJ4IO8bND0?=
 =?us-ascii?Q?NINA2zjtBxP+99/EzeI7WEtcVg1HsTayTWiOG/2zAgcpwhy34LCWcOGCjPu5?=
 =?us-ascii?Q?wHQdjYwX5wjGv+eP5BVshYE9jZIzMtu2Imu3tclZjY6NQ/kbMEJaqOjgcdd6?=
 =?us-ascii?Q?9nJrtC79Wd8WyeEY/s9I316SYkuRmziujBBVOuatO4FL6dxz1wM4DjQrzcTo?=
 =?us-ascii?Q?Y/v5StvYJjvXXewyiV2szknOZnSX9oTo2nmVI/VwNcjm7bmI7sK/fJeyJEag?=
 =?us-ascii?Q?9HM3NAPzEdwLXNEEzrg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ1PR12MB6268B58B4B39A5BDC4E6133494802SJ1PR12MB6268namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c70e23-88b4-4f86-38a6-08dd87560974
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 19:42:55.1892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdnFh/5aqeYZJ2tYzogLKwf3q/Uk2USic0ORx+QQt3lJSJPGySPQmuHsHPc8dXVPYHNBiCGuPqulTjYux903PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8606
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

--_000_SJ1PR12MB6268B58B4B39A5BDC4E6133494802SJ1PR12MB6268namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, April 29, 2025 3:30 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Michael <Michael.=
Chen@amd.com>; Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu/mes: use correct MES pipe for resets

Use the KIQ pipe for kernel queues and the SCHED pipe for
user queues.

Fixes: a82b069d9eae ("drm/amdgpu/mes: consolidate on a single mes reset cal=
lback")
Cc: Michael Chen <Michael.Chen@amd.com>
Cc: Shaoyun Liu <Shaoyun.Liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index 5de0d6c528f4e..2febb63ab2322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -349,6 +349,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,
         queue_input.wptr_addr =3D ring->wptr_gpu_addr;
         queue_input.vmid =3D vmid;
         queue_input.use_mmio =3D use_mmio;
+       queue_input.is_kq =3D true;
         if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX)
                 queue_input.legacy_gfx =3D true;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index e98b0d892a593..a41f65b4f733a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -277,6 +277,7 @@ struct mes_reset_queue_input {
         uint64_t                           wptr_addr;
         uint32_t                           vmid;
         bool                               legacy_gfx;
+       bool                               is_kq;
 };

 enum mes_misc_opcode {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c
index f9f2fbc0a7166..b4f17332d4664 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,
                 mes_reset_queue_pkt.doorbell_offset =3D input->doorbell_of=
fset;
         }

-       if (mes->adev->enable_uni_mes)
+       if (input->is_kq)
                 pipe =3D AMDGPU_MES_KIQ_PIPE;
         else
                 pipe =3D AMDGPU_MES_SCHED_PIPE;
--
2.49.0


--_000_SJ1PR12MB6268B58B4B39A5BDC4E6133494802SJ1PR12MB6268namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Tuesday, April 29, 2025 3:30 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chen, Mich=
ael &lt;Michael.Chen@amd.com&gt;; Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;<=
br>
<b>Subject:</b> [PATCH] drm/amdgpu/mes: use correct MES pipe for resets</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Use the KIQ pipe for kernel queues and the SCHED p=
ipe for<br>
user queues.<br>
<br>
Fixes: a82b069d9eae (&quot;drm/amdgpu/mes: consolidate on a single mes rese=
t callback&quot;)<br>
Cc: Michael Chen &lt;Michael.Chen@amd.com&gt;<br>
Cc: Shaoyun Liu &lt;Shaoyun.Liu@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_0.c&nbsp; | 2 +-<br>
&nbsp;3 files changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index 5de0d6c528f4e..2febb63ab2322 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -349,6 +349,7 @@ int amdgpu_mes_reset_legacy_queue(struct amdgpu_device =
*adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.wptr_addr =3D =
ring-&gt;wptr_gpu_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.vmid =3D vmid;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.use_mmio =3D u=
se_mmio;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; queue_input.is_kq =3D true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;typ=
e =3D=3D AMDGPU_RING_TYPE_GFX)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_input.legacy_gfx =3D true;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index e98b0d892a593..a41f65b4f733a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -277,6 +277,7 @@ struct mes_reset_queue_input {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_addr;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; legacy_gfx;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; is=
_kq;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum mes_misc_opcode {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_0.c<br>
index f9f2fbc0a7166..b4f17332d4664 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c<br>
@@ -869,7 +869,7 @@ static int mes_v12_0_reset_hw_queue(struct amdgpu_mes *=
mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mes_reset_queue_pkt.doorbell_offset =3D input-&gt;doo=
rbell_offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mes-&gt;adev-&gt;enable_uni_mes)<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (input-&gt;is_kq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_KIQ_PIPE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pipe =3D AMDGPU_MES_SCHED_PIPE;<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ1PR12MB6268B58B4B39A5BDC4E6133494802SJ1PR12MB6268namp_--
