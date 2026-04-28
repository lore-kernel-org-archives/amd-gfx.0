Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B9FFF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D2A10EA0C;
	Tue, 28 Apr 2026 03:16:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hk/lmP84";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF9B10EA0A
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YH/BJK6v0VP/8DVnxsMlFAMmLQus2s2m17r0P4BOXPL0ZiJ8S9Eqe3Hj16KwJwaqqPsO8+70syXEJEN5GpeOJvoR5vNHHA1Od7CEXnbBvMcdP/cbmPPC2X9IgiLaD7TCHBG3lSGqNhTRFGLkeyCx0CDWzqjpGJae9KHHCvfZXiAZD2B9oNqFXM5+dg2/WrLhvW+JojKLdBT6O1BLbl7CDTyuviBZGaAwM6qwHJKvt5joeHAyuRR4mySX1mXOxiwyVjjDeyOrfLLjFguWF/wOtLmaunKFZJXejfiVnY0VqfP7u3sY3jXA28Opwij0llN+qska3FYJjvwghX2hjKj0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpcvm4ZnpdT2Z9DjUPqJx23nVvgsWo3AXSvFnkSlEpA=;
 b=dZImAqhg3f2Yng6Qba1H1V4fzh9Z21RXeQfqW6yRVFrUw0Zwi8loVP/lr89Y7HsbaOTJjuQE4i0BvxMaH8elNs3c6NNFpHbIqQIowE9Q1XKeqEm6/2x44G6FiLtSpOGIVUFZ4zskcShZbnbSLyl+CJHJrh/WoBi1Vq6dfuwVeHI75QdgQh/is5WTkwsyIQ/CQA021oUqbK4EdLdxeu90C/4fw9RTqw2XSUhq2awyKUXdmG5hPAzzjhIpTuIeJA4jQFY2BPhqQSBQmsnSex0CA8+aGixyLeiLljBZ8CdBl4TQedlTLlzO2hRVwKLHJS66436ltLqmcsvSLiFdxHm2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpcvm4ZnpdT2Z9DjUPqJx23nVvgsWo3AXSvFnkSlEpA=;
 b=Hk/lmP84PX+auOInakWUqYLu/7awz3Dd6pkC/q1j4ZKMQs1FDRD225Uxu90an56owDAcG54yYBdGpOMjcpmnZJ+Hk9SU4T7MPG3ZuhnY7sNAK6sQda8dCLkixGxmBpPnkzVqdzU/RZaer3UXTUNYBP/8QChFGxgorPGTrKuLG2s=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:16:06 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:16:06 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 07/17] drm/amdgpu: add profiler/spm manager
 initialization and release
Thread-Topic: [PATCH v2 07/17] drm/amdgpu: add profiler/spm manager
 initialization and release
Thread-Index: AQHcu9QVeLP3KJ9mG0+1+rKtR/T5CLX0AwVA
Date: Tue, 28 Apr 2026 03:16:05 +0000
Message-ID: <BY5PR12MB4179FE44B81F4815CFAA6B10FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-8-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-8-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:16:00.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 1bb9d762-8e13-49eb-f93a-08dea4d47c6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021|18096099003;
x-microsoft-antispam-message-info: nYvcVcJHWHLauul65oRIkPqcjLGUChD2roHVIikCpn5nLEp3LR3x84noEEtCVRc4dNibkvca7b0PaW61HrI2l/ycQtdde4su0XroOMnnayDgLmzkFD0TY6cJ+lpDOrtYrPCs2eYee3qsIJUU8tURryr8qF+Pj9hbIxFsIjGHAU7FGtZFe28JAsT5eS41+GpcXfm4l4QZHlEe507i5g4tYRiNOn9hDOUsqG1fiuuvE9nrFDEoCgHEXsHCEHFowOFnrjdbcONY7tpwijeJ5tH1VqBpcLKBVOwTR0wXaGzmwEz3wWCrPfZz6K1rcz8fRLsm1IRpp2Znt/gFmraN6JiITrrVb3ceqyNQZySAcuivxTqiol7F8QLfe/xqYLtaU1zda0bdhRKXNTkMwfCl8G5ffbWluov5hxY1FtnB6CaJwacx20raG5+6QTY5atPQIhOvQqiRAMxnwFGceMN7/zWA5o+l1YKTTKwUuexU590W80Lfmr6O1GSAaUrUi3PaDsvQD4XrRxNksVurPMtP/GXTpEn3KWo3PWbMqrnkyMNQSfwjYJeKBjUEH3pNk5U21CZske0nPaW6BjdwwtF08xhnzXLh5x80aJJ70wmTPHjtlNM7KfQ0FIK8IjyVUgsDKe8lakwfXKGfullp4O785QMjabTmSpLgEDNhgZVx57rr9xl8ek9VWcNq+NGDn+E6bQWz6m7OLfz2oJkujgZn3MK/hNE+OEFniBqCHezkl78ih5Egx5JS0RP5h0i3yDOCLC3IiEy+HHuRRfD2wrHOcnKA586oD33PwOzRD3SCr6dneeQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(18096099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gx33qNUiKeW0TvqTDuQ2puxBwbYaYq1468ITHeebrhd9FpoMwH+2NVNYaUX?=
 =?us-ascii?Q?5sh41IJCfYgdO89tx8XIcy74FYyIy8qKQiypcj4R6Ph4iP0K9/RTpWbJ7QDm?=
 =?us-ascii?Q?HG4NQiX4BrQBhIjM7YKuiPyJWG2anZOx6Tq4+OPnPu512L8yMgHbiV2WD3Hq?=
 =?us-ascii?Q?Sa8A8g4XY4jZKWrZ1SPmlh9PN2GQLTM+RbFFfBPOjs75sLym5cZfzr0mseJD?=
 =?us-ascii?Q?qbkDcgpGU3XFWQ2+E3mi/0mWouvI1Ylmjb6pNIli8Fe972fJmfYpZZSbnUf/?=
 =?us-ascii?Q?dT7lskZ7rLyIwSryP8cSrhOpT/bs9n1YiYrYUjF/uNiPmjLLmVNsLLcu91tH?=
 =?us-ascii?Q?D/oSgTDCFN3AfMWxGT+lTFXVR+CgUazt68Q5qRKXHvb2m1NlKySYhhP9nVVz?=
 =?us-ascii?Q?5hQxVL68rH17OtK9a0SJMmyPlKqeMy2adloW/aBApijE6kHg0bJActc5V8EM?=
 =?us-ascii?Q?MsKBBsjimoJKc1jKMrSgVX55r7BFuRF6DvlmBQ1JeLyrgybxGGhl0B5niq/n?=
 =?us-ascii?Q?LErm4Q8CmyDsWwglDe8GYLNGE/wItgKNWG5NUUiEPn6ex5VAAOp+gdhLK/DQ?=
 =?us-ascii?Q?lRDeV9uYGwBRUykY7Iag9BhOkvN4V0tOLJ+s/ynHnoVhlzsrx86nuujtQXIL?=
 =?us-ascii?Q?ywLEVQLTtY1bEMfHXMImvgNH0mOckVwn/gAll5ABGJILZyi2N3KhgsPsIcPz?=
 =?us-ascii?Q?Uf8WsR30x7PKpkC5sZk8toHDIebGr5psP5I26sttfOcpjVTO4EH1iR5M8Vtj?=
 =?us-ascii?Q?q60zOaieDK8g8/SzOn8vJTyNtQe97WRluN7PCg9pnX0WZa8M/OqDNWe9Bjdl?=
 =?us-ascii?Q?FvZl390RxhYt1+b1K6rYsVltlHzoVXWJ5IZysK+OqxnXVF/GJChCRDNxKZEy?=
 =?us-ascii?Q?7pedBWSlu6lzQNMMZakUg1KVJ1R8vczb74/8QhWWA5g5bBdng5tiD5GOuzxn?=
 =?us-ascii?Q?NEprOdZbHdkXpwA86R1EzMQHcj2BCLJe3ucRKCF1fzag5B68NIipamW4OeJd?=
 =?us-ascii?Q?ttQk85KgW7yz9SggUNtesN4cveEZiECKztU59WXdrEyGohHpnCSNQLV6wLg7?=
 =?us-ascii?Q?+dK2BWWUxME8sdlk0/ZPZod6uIPxRxyYTe3RL7zsiFqSypBflVWrwLtQFEPP?=
 =?us-ascii?Q?RcY2WUEiCHMYkafvbafXGv9owfWx/R/IO8IomI75OiZEyxhYRQQ41Ui964Dq?=
 =?us-ascii?Q?xrp8DWMxEz1MiHWMyjkWyFWCokPDw9J5c1Voc56tar6fPs1csHNsnOwPFksz?=
 =?us-ascii?Q?0eYWdHqGA4Gw3JGpTVt3pZMJdDSYanwc+mQyIMH3XDQDviBNEq5MI5728zW8?=
 =?us-ascii?Q?wj6iTmcuQfsxzjMYPh9HyGQDxiQQo8gBW7AmN6vHc7+Mfu2KH/x6YXAN4gmj?=
 =?us-ascii?Q?Qd8Iyj7c79haXk0BGB8QGJraAjo8oYFZezj5451yFZYB2i9I0wrrJaGbwilI?=
 =?us-ascii?Q?vxbM57KFPgegUfIM+YK7pZhOyGpEoEirnvRU3pnmQzLKGlETLF7rA6kODahO?=
 =?us-ascii?Q?Lct4lATqdwxeKuR0mcMVMbiAJIk/y8QiaHSNJzR3kmAC5kdeHpca5/ELO852?=
 =?us-ascii?Q?GwMLlppRimvZgDa50AluJO8Wjl5Ic6uEayQIA6pqleWBaH9s/JdiSnzFwwJz?=
 =?us-ascii?Q?dKjlIG/lF8jLAsYSqsWOCyrK/F2FpMih2HG1EVtqpNWAS3d33B6N9zn3wvPX?=
 =?us-ascii?Q?2UeyPFAUgSf3Vmm7oXuu+8sDXSwbcel8HC0YFcPbxkfN9ecu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb9d762-8e13-49eb-f93a-08dea4d47c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:16:06.0177 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0C3alXZKNISAuDEPPeIY6WNiJ/COnXAtNLrjK46copLFD1pqSpmGgBAhJzr3wbwjrI+04eUQ8OaMZdDaGgsgIA==
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
Subject: [PATCH v2 07/17] drm/amdgpu: add profiler/spm manager initializati=
on and release

to introduce the SPM (Stream Performance Monitor) manager subsystem as a ne=
w compilation unit (amdgpu_spm.c / amdgpu_spm.h) and integrate it into the =
per-XCP profiler manager lifecycle.

struct amdgpu_spm_mgr is defined in amdgpu_spm.h, currently holding only a =
drm_file pointer (the owning file handle). It is embedded as a member of a =
union inside struct amdgpu_profiler_xcp_mgr, alongside future profiler subs=
ystems (e.g. PCS).

The SPM manager lifecycle is tied to the profiler XCP manager:
- amdgpu_spm_mgr_init() is called from amdgpu_profiler_mgr_init() when
  a new XCP profiler context is first created (i.e. the first open on
  that XCP partition). It calls the internal amdgpu_spm_init_device()
  stub (TODO: device-level SPM hardware initialization).
- amdgpu_spm_mgr_fini() is called from amdgpu_profiler_mgr_release()
  (the kref release callback) when the last file handle referencing this
  XCP profiler context is closed. If an active file handle is recorded
  in spm_mgr->file, it triggers amdgpu_spm_release_device(), which
  calls the internal amdgpu_spm_release() stub (TODO: SPM hardware
  teardown and resource cleanup).

A helper macro prof_mgr_to_adev() is added to amdgpu_profiler.h to retrieve=
 the parent amdgpu_device from an amdgpu_profiler_mgr pointer via container=
_of().

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c |  3 +  drivers/gpu/drm/amd/a=
mdgpu/amdgpu_profiler.h |  9 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c      | 62 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h      | 34 +++++++++++
 5 files changed, 109 insertions(+), 1 deletion(-)  create mode 100644 driv=
ers/gpu/drm/amd/amdgpu/amdgpu_spm.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index 74abc061cd4d..e97a9a066308 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -68,7 +68,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_doorbell_mgr.o amdgp=
u_kms.o \
        amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
        amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_d=
ev_coredump.o \
        amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_i=
p.o  amdgpu_cwsr.o \
-       amdgpu_profiler.o
+       amdgpu_profiler.o amdgpu_spm.o

 amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.c
index bed43ea8bcc3..d462d99dc8bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -82,6 +82,7 @@ int amdgpu_profiler_mgr_init(
        mutex_init(&prof_xcp_mgr->mutex);
        prof_xcp_mgr->xcp_id =3D fpriv->xcp_id;

+       amdgpu_spm_mgr_init(&prof_xcp_mgr->spm_mgr);
        prof_xcp_mgr->is_init =3D true;

        mutex_unlock(&prof_mgr->mutex);
@@ -93,6 +94,8 @@ static void amdgpu_profiler_mgr_release(struct kref *ref)
        struct amdgpu_profiler_xcp_mgr *prof_xcp_mgr =3D
                container_of(ref, struct amdgpu_profiler_xcp_mgr, ref);

+       amdgpu_spm_mgr_fini(&prof_xcp_mgr->spm_mgr);
+
        mutex_destroy(&prof_xcp_mgr->mutex);
        prof_xcp_mgr->is_init =3D false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_profiler.h
index 779cfe19fda2..ea62a4dee364 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -25,15 +25,24 @@
 #ifndef AMDGPU_PROFILER_H_
 #define AMDGPU_PROFILER_H_

+#include "amdgpu_spm.h"
+
 #define AMDGPU_XCP_ID(x) (x =3D=3D AMDGPU_XCP_NO_PARTITION ? 0 : x)  #defi=
ne fpriv_to_prof_mgr(fpriv) (&(fpriv)->userq_mgr.adev->prof_mgr)
 #define fpriv_to_adev(fpriv) ((fpriv)->userq_mgr.adev)

+#define prof_mgr_to_adev(x) \
+       container_of(x, struct amdgpu_device, prof_mgr)
+
 struct amdgpu_profiler_xcp_mgr {
        struct mutex                   mutex;
        uint32_t                       xcp_id;
        bool                           is_init;
        struct kref                    ref;
+
+       union {
+               struct amdgpu_spm_mgr      spm_mgr;
+       };
 };

 struct amdgpu_profiler_mgr {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
new file mode 100644
index 000000000000..27f4ed1aa1e0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "amdgpu.h"
+
+/*
+ * SPM revision change log
+ *
+ * 0.1 - Initial revision
+ */
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct
+drm_file *filp);
+
+static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr) {
+       /* TODO */
+}
+
+static void amdgpu_spm_release_device(struct amdgpu_spm_mgr *spm_mgr,
+struct drm_file *filp) {
+       amdgpu_spm_release(spm_mgr, filp);
+}
+
+static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct
+drm_file *filp) {
+       /* TODO */
+       return 0;
+}
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr) {
+       amdgpu_spm_init_device(spm_mgr);
+       return 0;
+}
+
+void amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr) {
+       if (spm_mgr->file) {
+               amdgpu_spm_release_device(spm_mgr, spm_mgr->file);
+               spm_mgr->file =3D NULL;
+       }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
new file mode 100644
index 000000000000..06b4f6dba41b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person
+obtaining a
+ * copy of this software and associated documentation files (the
+"Software"),
+ * to deal in the Software without restriction, including without
+limitation
+ * the rights to use, copy, modify, merge, publish, distribute,
+sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom
+the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be
+included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
+SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
+DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef AMDGPU_SPM_H_
+#define AMDGPU_SPM_H_
+
+struct amdgpu_spm_mgr {
+       struct drm_file *file;
+};
+
+int amdgpu_spm_mgr_init(struct amdgpu_spm_mgr *spm_mgr); void
+amdgpu_spm_mgr_fini(struct amdgpu_spm_mgr *spm_mgr);
+
+#endif
--
2.34.1

