Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324BBFCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBA6610ED7F;
	Fri,  6 Mar 2026 15:52:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="boU5oQ0G";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0D5110ED6D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpqzWF1l3vvJ3AH/R8GmQHltV+mmShsxv2bBc+llLBI1MPuFNQ+dQYB19/zpikZNSWvx7SA4DNY+CXLlogcnEwqwkbQvL0e1V2Zqr4yvJWAnX67aRSz8N2IzXh9u9+B0Ym1eUT0ocDrr1vxkRM3qp6vOGNVf3wZBfgFsvkmZKgQaoAo8HEiZHLCPPb4g88O3lfRKWyKBn/+07mPvFSbTQqxVjSUKnqWrAdRtxC7CCge8U+A2eYOOtedaoQvn2osMbIKwCFnEi3DXHJJ5CpZ9ztpYnIJgc0z3cGm2rtNrQ3HS6V8oKLogQenGmsiTkK6oB/JCVZp65T2nzGkAknwQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKI00tIKQ7pcfuZEG8pM7kisjEkUVOzaGxIBXxyVfWE=;
 b=pmp9FenjMmfKMjbur3d2NKnH93tfB4gNjaYkVmHj/v8p2qItdGP8TDhKvW+RIwN+tfDPZkAxu1DUh7MWOYp2TSPVdxB68ag+UpuuahZIO7tHGqQvRAEKxAIq7Z+AvACowk5J5Q6ntrR1BTToW66nncD7zFUldtLUJj7OSRhO5sCQE16wInUMHlhsQrs1dPVYDknlD9LlXoYUQrXwKGnKykGTkOp5aDgMWtwQHhsbGFzoEcgk8pnrnvkKMHGFBi/MEY/is0O2YBCVwLiB4P2uFjcIwepBEADnLt6KGjQWokHj+Y54XFHxAATwRTLjGwA2ZGCsEvCFl3RGZ84cbhUORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKI00tIKQ7pcfuZEG8pM7kisjEkUVOzaGxIBXxyVfWE=;
 b=boU5oQ0G8+ICBYbQc7JS2cfnoqkdM+ntaNq4z8bupMtUkDCfoE79fn0BFNHmfsdAZx/Bg3h4XvZqdmxmOqKTz4nAgLtyCpStwj44AboPOXQkrIb774TZGgJ2UGG0Emll3aGT+7cDVoAtM4WrH9K9LQ9hcBpoMT3zl4V7CMZBOnA=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by DS0PR12MB9726.namprd12.prod.outlook.com (2603:10b6:8:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.6; Fri, 6 Mar
 2026 15:52:35 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9700.003; Fri, 6 Mar 2026
 15:52:35 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3 ping for review
Thread-Topic: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX
 v9.4.3 ping for review
Thread-Index: AQHcrYE/WbI2fAnnuUi/u4/T8oGQPg==
Date: Fri, 6 Mar 2026 15:52:34 +0000
Message-ID: <SJ1PR12MB6121D1F1563A52A5C88875AA807AA@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20260303161921.435188-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260303161921.435188-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-06T15:39:23.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|DS0PR12MB9726:EE_
x-ms-office365-filtering-correlation-id: 218b5014-7b71-4457-d535-08de7b986265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: i4xljSsqCiD5COVdz7bGraMNOr/+5us0y5rq1VdkS0RrUKZ7a/tsWEqc5xF/4VqG/xTNQOtg136iOYOmAdYPYeTKjmPTGX2Yi/Shp69chCmDUZlL0cvyuUNgU/Q+fjPLaB3ukVZeOcna7QQW/SdMIFIPdFsIagZT7pFUEIhGEiCuhq62kbMfljJTyqFILb1UTUjOx6X9gNcDFp0v3bQG9QaonE4pwr5I50gnjHNo6IU4CDkNxcFfG58/Htl38ocQ8pvgj9eCy5snuzuPX6ivWU4Icw6iy8XgtKtLkxJ5eDCeYvnAafElH06sqEuD/3LPfkp5IeZgMqZwOa4jbChp3RbPxSghLvuthgy9Vb2o/dfzoQbfyVUd43rxTEzwsWyvr7rfj4H5Ge4k+2gUQTCr4bEi1h84xLugLgwiYpctGYfo2w0bKuHMOM4pyqLYf30tlVvZCyXqYttjTvCHgMbquSC4fF+pLK7+kZ5lpluWrY/Is32OGDIn7JIdB8Wdl1mblS32Hml5mFjPJFbW54ASIKj1RWG+tnUmo32xWhNweFzAGL+tRIqOula4ku75Yz6gOa2BCJUg2TzgSiSrsFQccNUV6wGvW4Ny3brYZ4DhqrlqHES6x/J0uab4lQypH0UQXnsLMF5CZ75iEpo/GtUllKUI3ZDpPGfsvRv6+kqrgP5KoZNYFx46TZp87C8lutKFHM/wVqTkDV8OwEw/6U+cfcsFtri2Y5otYqOke2ED9S8QBffsGBykUHrQs5Jm/wpe7/1JJki+3RFD74PwUit1h2/aU4H7nR5tglNLFiTlOMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y8LchLCzeW97U9jFthJIYtfFrd+3pYw0imU2drF24unOGpdvsPFiZshTBiYw?=
 =?us-ascii?Q?NwZ1D3rKRNSCaSj/NREwrYNLjl8kPXxK9xvgsr1fARu/1xKpBkkMxQMLlDHz?=
 =?us-ascii?Q?GQZWCmpm9ppAv6EvPryiR4rBruDO03XXyYNSDjIpHkQs6aStuD2nvruiro4w?=
 =?us-ascii?Q?E9PDRuclVYtdIBXkala8RouhOTInborWHtiN6a+kydLlQihdSXZ7tCqVaiRG?=
 =?us-ascii?Q?d0D1gvYf1RLfRsoFxvAHFLi1nEy7/7axfjVBQMpPzzDEZwVMEwLi/yMjq1Wv?=
 =?us-ascii?Q?/kG9dImmx1UKepwOFP8kpJEWvRvXI59LA2bLYfx7rIfGNW6ICpLV9N3HgXOt?=
 =?us-ascii?Q?c4Bx3nG+XMDio41OKRf969ssb1/75pCLbs1CKmtuoaa76pp9YZAEmDqFnI0U?=
 =?us-ascii?Q?QcnNIXcorhuHsA0yRUsJuG1ReYZA8LOv3Z9ZuVUBcOAMPDok4RTvD6Lw+KGa?=
 =?us-ascii?Q?6SLh+aDUbDW+C03t2YxpU9DyeVxDCS9/G1/4KuTpVgc3P5p10a3iIywgDmi8?=
 =?us-ascii?Q?6qFC2yVkVMX/BCzap7PHcilYRme44WNcYXmB5r/7sn1ZnT4oIZ8WBMPTLaYn?=
 =?us-ascii?Q?xupdcyxfs4KLz8sgwelej2pCbCYG+GslN2Z5ere4bCoKKFzFSTrMlrQAYgEa?=
 =?us-ascii?Q?7meAfm8gKPOdodap19aiqTPithxpwr2i03ctyJviOWFiLHwGs8bMnJD6vNFa?=
 =?us-ascii?Q?QqVUnKTqj2KkChUynIU7bEgeWCacxUkhXrD9Y8GH0BRU3A78S7pqluCdYqsD?=
 =?us-ascii?Q?6FZPTt50Y2cDZpECHC4otCFfRviYzQdlBo92RxZ++D2ERuzR1VaSrlA6R6iU?=
 =?us-ascii?Q?59zekyZXQHD3zEMPd6fB4yWgJA10Takd+gvH3RoqjS9AEG24TDiLn+SkI0kV?=
 =?us-ascii?Q?8+Yl0PdKWzl0WbCtoOshRUYmvumabFGeui+zZ4jby+mibsVM6UhTc3uOp/l5?=
 =?us-ascii?Q?qosyQqOtQYkN9v6TYORWLtkn81nu7oCwq5W4W3cgnNwxI4JGcums4NGhWqRk?=
 =?us-ascii?Q?VnNflKGSZHsfqNZh0tJ14vwonB/O6Z9j/uzAh73mggQzKCFGumqiEB0m/TE9?=
 =?us-ascii?Q?2CZTvmCh8eJi2pzFNwRxQw2OncKCnlw2nVl1bwTGBLVPGo2uy2TI4EjixZZO?=
 =?us-ascii?Q?ZwGAG0FTDwtBNxaYHCbtbqHIm7dKoZRmC8Hb6eV0dOrhqfUk8XxIECFmPQOZ?=
 =?us-ascii?Q?MSO5O3iT5wPveuYyHSHHS7No2+YIkqEGhaGKc6bzGpqP+9G9ySKmJRQSaS59?=
 =?us-ascii?Q?CYaLuIBm117NHgkcQr3VcemWVzS3g6a5TNZsVC4rTel54i0H/g4p8PaM7oqr?=
 =?us-ascii?Q?r/Sa3znUeOte7upEcD+LEUGUaoT52Gj7CM3g+JhBdrKNGaRQJhNZstebN3ID?=
 =?us-ascii?Q?kZfzzmW6vM7SP3EDXVuCXyTI/tgWjfCCkRlXku0XCelH8yXYkijNuNAJDZYW?=
 =?us-ascii?Q?PN0Lh92gTtFtmtjXzCL/COQ6LWhRuFJZ/avrCKozzN9zE1tytAiS7XhT1wYY?=
 =?us-ascii?Q?4u2ssET+M8jTblL6SkH91zNiwombGLfWvgWVkV6Xd4Lsn2exQ8MkcI6/Rfrq?=
 =?us-ascii?Q?CP9BDlkDMDrp1L0j/DCh0KdD9BNFXIEgV34APEJLCMIyhvpzZ5NuzviJ9sKd?=
 =?us-ascii?Q?NAFF5l1OA1qdkZhTej5NVlOEzenSYm/JdMU+l254FMnIAySARjGuWfoJxfaJ?=
 =?us-ascii?Q?U8p+Nkb0/JJskkKjEdRNOD2znrVVwLe4RnAp3U/3gKN6Erit?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 218b5014-7b71-4457-d535-08de7b986265
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 15:52:34.9025 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXLHRiguyQP9gW1MEBIdX7hgBBQ+aXoGrTVY6pSzUz8tYvx6e90SMYkMx5yk8j9yNhXJFUaKZqyWEp6DEnu0Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9726
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

Hi all,

Just a friendly ping on this patch that fixes PLAT-192105 , I'd appreciate =
a review when you have a chance.

Best regards,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Tuesday, March 3, 2026 11:19 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Zhang, Hawking <Hawking.Zhang@amd.com>; Xie, Chenglei <Chenglei.Xie@am=
d.com>
Subject: [PATCH] drm/amdgpu: Fix KIQ fence timeout after GPU reset on GFX v=
9.4.3

After GPU reset, the hardware queue is cleared and all pending fences are l=
ost. However, the fence writeback memory remains stale from before reset, w=
hile software continues emitting fences and sync_seq keeps incrementing. Th=
is causes amdgpu_fence_emit_polling() to wait for fences that were lost dur=
ing reset, resulting in -ETIMEDOUT errors.

Fix this by updating the fence writeback memory to match sync_seq after GPU=
 reset in gfx_v9_4_3_xcc_kiq_init_queue(). This aligns the hardware's view =
of completed fences with software's view of emitted fences, preventing time=
outs when waiting for fences that no longer exist.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index ad4d442e7345e..6b5fcdd987693 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2135,6 +2135,15 @@ static int gfx_v9_4_3_xcc_kiq_init_queue(struct amdg=
pu_ring *ring, int xcc_id)
                gfx_v9_4_3_xcc_kiq_init_register(ring, xcc_id);
                soc15_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
                mutex_unlock(&adev->srbm_mutex);
+
+               /* Update fence writeback memory to align with software sta=
te after reset.
+                * After GPU reset, the hardware queue is cleared and all p=
ending fences
+                * are lost. The fence writeback memory may be stale from b=
efore reset. To prevent
+                * waiting for lost fences, update writeback memory to matc=
h sync_seq.
+                * This avoids waiting for lost fences and prevents timeout=
s.
+                */
+                if (ring->fence_drv.cpu_addr)
+                       *ring->fence_drv.cpu_addr =3D cpu_to_le32(ring->fen=
ce_drv.sync_seq);
        } else {
                memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
                ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask =3D 0xFF=
FFFFFF;
--
2.34.1

