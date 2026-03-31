Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97AAFF60ED
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 08:33:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72D8310E2EA;
	Tue, 31 Mar 2026 08:33:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CpawcwON";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FABD10E2EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 08:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcerF0u5lZmzg3mad8TkxwqCu6NAf5dmx/7rRLb4Q+YEccdzbY4pW2lAsXQaw9yScEx707bckpi4UNOnURY3di2w9SB4LZZQu4UpnnBbxYbCKGPLQK7qbGURBZ4oGeCC4j7Cjc7PQpb8fWJpHmof9eoNTwW2HTkG4z+lE9koWnNwogPPq1O120BcDNif1k5qE0it677Zcx+a0fHfIgh6B/FQR5Yl09a4wIWSMXUJSsrFHWAveot8CTtr82wI7Uz0Azq3h6Q4Sk1BrBkkGJ82Bh0/o2iqIEixulc+CxI6e2WxC7aK5AaRDTdq3oGJjH2OitS868beB7gi4aH6aLO/DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRgOQmRlzV2qlmVClEDX1H5hHPXpnm4nleGTT+p0SRc=;
 b=s+4E2gH8CENBcHrJqsepo4DPqzH/cV0MJibHp13QomSlBMT0D8p2ou78n7s0+tgr++aOApBj0PZphnfqwg3wbFXoLE9to22PdqheJnUbliMiA/Ydjx8jvQk+n429Muf//0p4f9RDHhvsIDa5pW4JzZ8yQB8m0vCOQG992F6luPB7jMSDAVUWsRcXwKyjuiKsl8y0M9eQagyXhs+APS7xn9HaiPwBYyxyNhllgOvI8lKakNVuiIUUA4SnNOvTWaergQD0Di98kUWgvPsRvcMBp9C+TIdHo7LXeozSo+58fxUDPUKmgEIpBe5g/a6dgoghKAtOOntRYLyitV6yudYzPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRgOQmRlzV2qlmVClEDX1H5hHPXpnm4nleGTT+p0SRc=;
 b=CpawcwONhLlBtM75CAPblBKKcUBCOuR73Bg5CeK4i/ed4L89WR+djwiatckLCbI2GOBgQfgTtYxDtqqqs+MuLpdTfscsKubAlZ26yhU7cHFNKbK3sGSIyR+vQLhX9e/PRQSQ7N1eabmZ9AAXj706JoCTVFnD1vmfuxhcQwyPvHM=
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.12; Tue, 31 Mar 2026 08:33:38 +0000
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::d30d:22cc:7348:6649]) by SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::d30d:22cc:7348:6649%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 08:33:37 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Jin,
 Jason(Yong)" <JasonYong.Jin@amd.com>, "Alnasser, Mais"
 <Mais.Alnasser@amd.com>
Subject: =?iso-8859-1?Q?=A0[PATCH]_drm/amdgpu:_add_fast-path_for_userptr_BO_valida?=
 =?iso-8859-1?Q?tion?=
Thread-Topic: =?iso-8859-1?Q?=A0[PATCH]_drm/amdgpu:_add_fast-path_for_userptr_BO_valida?=
 =?iso-8859-1?Q?tion?=
Thread-Index: AQHcwNI98pMRwP0hFE6hfatC8g0XGw==
Date: Tue, 31 Mar 2026 08:33:37 +0000
Message-ID: <SJ0PR12MB69030113B9A8023E3132F8F7F753A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-31T08:33:39.398Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6903:EE_|DM4PR12MB5866:EE_
x-ms-office365-filtering-correlation-id: cb5ffa5c-a29e-4c00-e90e-08de8f003477
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|8096899003;
x-microsoft-antispam-message-info: OQsnpLRLNBTyzSIaWbhrO2vRLdX/qMMbuzD74RxSwsspAUlVDG0SsFf4271H+PNDYQ1SVBQvVlbzKeXenmjtoY/AHXM/HA16KUVfV866JQuybZaA8DsilIHa1hM5Ru6RHkvTQy0JiVuezkl2HlOVzI/uEQ1Wcq1yE6Y6Y9cX2iaHyTlkxibq5rv2Z7ilUNhDnW6kJVckTIzMaodXLguC/I8ifZy4Dd3JlaiGOR4p+i5dsAi0G23Kv3ZFxLDa8AzP1w9CbKz54vdin8SUhfl7TLJ8/A11UbPVTN4PdaPAJi9DhxkiZXihj+vA2swSvxdFRv0HRpWJLSnJz8aVBP9KwO2RqDakJDyGx/Hw0dzXonDwAscEEXlvf0dJLdz7dZVcHH+hm3l+wyQtYHNhevRn6YGMctSxZKpmqmoTtSSxdzNv+39qRcwY93h7t9fu2WCrw+fo0VpkSpJGHhy1op86bDnilVZziqlx+CPSvh6mdzPgqgCeXTYi8/944K+57nMC3aPzatejyqKcwuD1DTi5WfZ/XUbTrGWjWqsSG1b3/l1Thx/3ZedNhjg4cOKOi1sq6d1mhuakLSO+NDvCOynZjUwTm09m6YCnakEHTGEfAlMKpK3qfZY7NHZ+znnAmWove7H4XbdDhBinOWVvzK4UV3CRoQ0FTDrc8XwXpdaBsbhqrEmA/ALp7eR1dyLlktVJekj8TQbr7jXn/37oO1HVTwoPOZX+JG93Wx8MsOzCVqeWTvH0weyPSOkPYRPPDJbJg41lhdL36XV5SNuMsX5nwfFca9NDyMD3pKeCwWn8i4s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6903.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zm+/QbuTrspkzEXDBl5temzLCiWaOusOY3NX5AmSsiWYs1MYhkCkR6Tdw1?=
 =?iso-8859-1?Q?dq+axThXEgRKlDdBO39bKJGHxGtCghPUPwynIin/2Ucj+u/PDTBzWROquK?=
 =?iso-8859-1?Q?vT0XP8u5g6ZWkB+vn0zG29J84rQk+IauyFoAN/aFm0HhTJMLb6eGSlC+pG?=
 =?iso-8859-1?Q?KOlsyuXl3URgSN8/lxXIUMXe6CtsCUGKlg75KI9+BpAv8cAreqRKUXk6cM?=
 =?iso-8859-1?Q?diqJ75YUxqY6RWqzXKtMe9enGzPtT45aTo8Q1dADKsKuctdokhkXo1c1+C?=
 =?iso-8859-1?Q?ZAzM9+EEoc3w63Kn/bJT6VyNbBJTQfWgdog8gUVPAwL6S//5oAy3h5Hsul?=
 =?iso-8859-1?Q?w/GdsTSKwVNwreAhRX4cY5lk2lp+UMfEMWPgCcyD30rE+od6A3kttdT161?=
 =?iso-8859-1?Q?hHG7Gz3DN0Bz580WfbkKWgnMfUGFUxesPXtkptvEm74Xk5i9kvS1LHm/8i?=
 =?iso-8859-1?Q?e/wMqAnvPPxQkzEFeq8Q0uIP9Ra8hw9RPvypTpPnZRDRk67Fmsc8LapH04?=
 =?iso-8859-1?Q?wwb5cufNp3ZwKMvRt0WjfQbsek0/mekZJ7bN4ii97fy6JZbIQUyJgHfeWE?=
 =?iso-8859-1?Q?FdUqy4RmtwRM+ziGnmE9HAPRgLESoukwUYl933T3D3Z8/XwVITo3y4fl3B?=
 =?iso-8859-1?Q?cqr6JgzPOULAPgAOVU/hzD7kfgVIe+fgYKK4WEIzr3fVCwUMnpwdDV6TXG?=
 =?iso-8859-1?Q?ivvk+JrLkhlitaQw+L+Lt3tMayWYYSlUEXwgvxKeuE91m/5Rg8iP/xB+Wf?=
 =?iso-8859-1?Q?jCdg/GLIE/uvi6qGJr61UIQAkS7c05BtE4gbRjBnwLx5/D4XS4nmjXByM3?=
 =?iso-8859-1?Q?eqi9FbG47+Vt7sqU4ohbO7HtpXoCoSVKXhVfqph9PJTK2seJkGCPuY3gea?=
 =?iso-8859-1?Q?lwsb6nzfEWJrC2opGsORIzT3zXKS17L9z1NYwUJse30L3a/or/q91gbWmW?=
 =?iso-8859-1?Q?hRKrMupJaocaDJ+DRxJYJIl+hYH+pDgd5QYR04X9eoadwADWOCQKNEMVUB?=
 =?iso-8859-1?Q?DWePi9iS2KFx+Lv37HL2NrbQKczRy1ONDPGjwWfwlaAwVMcUXZZ2XSCzAI?=
 =?iso-8859-1?Q?ZhfQdGIShOD2LXSho1gULD2FM4kqrLHIsNVNcxz4vh8HZzUS37xRH1o1Y5?=
 =?iso-8859-1?Q?X1EmedJQbN1eqK3IDBqyrhqooihE5HmRbz4/MMayE+GL9aO58g+BREuqlJ?=
 =?iso-8859-1?Q?YukBNQebxWdwOoSBQUzdYMjqC77E26RhAJPj04p35/t8Lb7N7ie79ZRn88?=
 =?iso-8859-1?Q?tSSna+eKE1qymh7+KotFvcPFhLSPNwCibWQ/8VzsGkN7D368hxxFpkkiS3?=
 =?iso-8859-1?Q?RmGiquilTNvxG8tZlZp2Oloody/RQnyLV5XLKJRwFR7puUUeAQ+kZYCa/B?=
 =?iso-8859-1?Q?oNZI/cHivopQCX0me0/yl3G2PKs6CJthESZCMzG573WDK3WsNT1DnyOvvP?=
 =?iso-8859-1?Q?79I3klzbaueTB5gzTwsAWogQRoU6I93nmNJnIF9qWPiB7vOZDgARUVPh5E?=
 =?iso-8859-1?Q?aIGKB2YM5h1d2PktILlssDd7XhV6qvwqKdW9u2MXj3iHV35Nl43tYMH8wj?=
 =?iso-8859-1?Q?IBNcCTKas8WuD9xJuD+T90AS03mhrJxvn5UjE9TXvsDu51MgJUpGnrkGNJ?=
 =?iso-8859-1?Q?URlQuPdkGojjRLh8zQK/LUPcxovkQoFl+k9WvP8KOqN/B7Jw13fuN+Vvum?=
 =?iso-8859-1?Q?swmJHbcoHEQTpmUhqj2EgXBIf4UYx/sxoQwlwm/5CKeRfQNLpSN7WFaUHp?=
 =?iso-8859-1?Q?Eu4ld2t/F+6nfDcwDaC22shUOdKESCs+RlubdA7FFVDuDy?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69030113B9A8023E3132F8F7F753ASJ0PR12MB6903namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5ffa5c-a29e-4c00-e90e-08de8f003477
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 08:33:37.5969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBYRNUcCzFujqrdCE4Ix9V0DKh6tkl56qtdPAJsl50rzEaPlegrpF1ojH+5hlVys7f3CR7OWMO3ST3m/YoyeFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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

--_000_SJ0PR12MB69030113B9A8023E3132F8F7F753ASJ0PR12MB6903namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

This change is based on Linux 6.19-rc7


Skip the expensive per-BO hmm_range_fault page table walk if no MMU
invalidation occurred since last successful submit. Here it's a single
seq counter compare vs the full HMM walk

On first submit the slow path runs and caches notifier_seq into
bo->last_valid_notifier_seq. Subsequent submits check with the cached seq
for the fast-path. If an MMU notifier fires, the seq changes accordingly
and the slow path runs again on affected BOs.

Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 25 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  8 +++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c
index ecdfe6cb36cc..140346e9cb92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -891,6 +891,17 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,
                bool userpage_invalidated =3D false;
                struct amdgpu_bo *bo =3D e->bo;

+               /*
+                * Skip the expensive HMM page table walk if no MMU invalid=
ation occurred
+                * since last successful submit
+                */
+               if (bo->last_valid_notifier_seq &&
+                   !mmu_interval_read_retry(&bo->notifier, bo->last_valid_=
notifier_seq)) {
+                       e->range =3D NULL;
+                       e->user_invalidated =3D false;
+                       continue;
+               }
+
                e->range =3D amdgpu_hmm_range_alloc(NULL);
                if (unlikely(!e->range))
                        return -ENOMEM;
@@ -1326,7 +1337,19 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser =
*p,
         */
        r =3D 0;
        amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-               r |=3D !amdgpu_hmm_range_valid(e->range);
+               struct amdgpu_bo *bo =3D e->bo;
+
+               if (!e->range) {
+                       if (mmu_interval_read_retry(&bo->notifier, bo->last=
_valid_notifier_seq))
+                               r =3D 1;
+                       continue;
+               }
+
+               if (!amdgpu_hmm_range_valid(e->range))
+                       r =3D 1;
+               else
+                       bo->last_valid_notifier_seq =3D e->range->hmm_range=
.notifier_seq;
+
                amdgpu_hmm_range_free(e->range);
                e->range =3D NULL;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index 52c2d1731aab..89dc9ee1176e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -115,6 +115,14 @@ struct amdgpu_bo {

 #ifdef CONFIG_MMU_NOTIFIER
        struct mmu_interval_notifier    notifier;
+
+       /*
+        * Cached notifier_seq from last successful CS submit.
+        * Used to skip the expensive HMM page table walk when
+        * no MMU invalidation has occurred since last validation.
+        * Zero means never validated (always takes the slow path).
+        */
+       unsigned long                   last_valid_notifier_seq;
 #endif
        struct kgd_mem                  *kfd_bo;

--
2.43.0



Thanks,
Beyond

--_000_SJ0PR12MB69030113B9A8023E3132F8F7F753ASJ0PR12MB6903namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
This change is based on Linux 6.19-rc7</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Skip the expensive per-BO hmm_range_fault page table walk if no MMU</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
invalidation occurred since last successful submit. Here it's a single</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
seq counter compare vs the full HMM walk</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
On first submit the slow path runs and caches notifier_seq into</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
bo-&gt;last_valid_notifier_seq. Subsequent submits check with the cached se=
q</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
for the fast-path. If an MMU notifier fires, the seq changes accordingly</d=
iv>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
and the slow path runs again on affected BOs.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Signed-off-by: Wang, Beyond &lt;Wang.Beyond@amd.com&gt;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
---</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c &nbsp; &nbsp; | 25 +++++++++++=
++++++++++-</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | &nbsp;8 +++++++</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;2 files changed, 32 insertions(+), 1 deletion(-)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index ecdfe6cb36cc..140346e9cb92 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -891,6 +891,17 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parse=
r *p,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bool userpage_inval=
idated =3D false;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_bo *b=
o =3D e-&gt;bo;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Skip the expensi=
ve HMM page table walk if no MMU invalidation occurred</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* since last succe=
ssful submit</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (bo-&gt;last_valid_no=
tifier_seq &amp;&amp;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; !mmu_inter=
val_read_retry(&amp;bo-&gt;notifier, bo-&gt;last_valid_notifier_seq)) {</di=
v>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; e-&gt;range =3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; e-&gt;user_invalidated =3D false;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; continue;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e-&gt;range =3D amd=
gpu_hmm_range_alloc(NULL);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (unlikely(!e-&gt=
;range))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; return -ENOMEM;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -1326,7 +1337,19 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser =
*p,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; r =3D 0;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_bo_list_for_each_userptr_entry(e, p-&gt;=
bo_list) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; r |=3D !amdgpu_hmm_range=
_valid(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_bo *bo =3D=
 e-&gt;bo;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!e-&gt;range) {</div=
>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; if (mmu_interval_read_retry(&amp;bo-&gt;notifier, bo-&gt;last_valid_not=
ifier_seq))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; r =3D 1;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; continue;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!amdgpu_hmm_range_va=
lid(e-&gt;range))</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; r =3D 1;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; else</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; bo-&gt;last_valid_notifier_seq =3D e-&gt;range-&gt;hmm_range.notifier_s=
eq;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_hmm_range_fr=
ee(e-&gt;range);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; e-&gt;range =3D NUL=
L;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 52c2d1731aab..89dc9ee1176e 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -115,6 +115,14 @@ struct amdgpu_bo {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;#ifdef CONFIG_MMU_NOTIFIER</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; struct mmu_interval_notifier &nbsp; &nbsp;notif=
ier;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp;* Cached notifier_seq from last successful CS =
submit.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp;* Used to skip the expensive HMM page table wa=
lk when</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp;* no MMU invalidation has occurred since last =
validation.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp;* Zero means never validated (always takes the=
 slow path).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; last_valid_notifier_seq;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;#endif</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; struct kgd_mem &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;*kfd_bo;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
2.43.0</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Beyond</div>
</body>
</html>

--_000_SJ0PR12MB69030113B9A8023E3132F8F7F753ASJ0PR12MB6903namp_--
