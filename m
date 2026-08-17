Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD08FC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A14610E86F;
	Mon, 17 Aug 2026 15:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hYY+6z7h";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010040.outbound.protection.outlook.com [52.101.46.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC5210E86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 15:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORYCt9aR+YqYbLwGEZ5EWHl0yXRHGfQshTA7EMO1wmusT/t/73KWTTuJy5M3lrLwix+1BoYQUhivE7YounHfwUActbzh3fQXfRU2M4QPBi/dcR3XedNaIWAhlUaIN1mb9hH55R3dfTGsNpeZUuCwwtD150ave/9yf2fmb/IEfyUeaCn8PWjDvrWFoSM5JHHOmcwQXKTkZC4D4OO0Atbuyga2lulQZjuPTmaCdEFnz0przYPvUx4Ix3aOi9sAgBnCLOZ5PuNnZZMXS/18AcOMdO4lGXpGFav/jHCYmBAwUZjDi/jvBSA5+v844L577W41CHdwgmdJO5abtWw9/Ws+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpLqx+YHh5EEOdduRbwKMTA79eQXUDxBdEpx4Vh3YJc=;
 b=cAYsZ4HEJ9p2i+OHxe1+NHm5Kf16s12bBQOKekADgnERF57/AGqavsUc3r67dWW4Jum7XBygPz3oEEYMeLXytRaCtMzp4oLBIGDnQFjHNcIaReKiytAZANLrJTk/elLvOp6VB0pr9ThWeb1CgdwnHy8dt+Rk7NRyGetNufBYboLCItHNOfYiTpkooOw0oNBOJWOrB+K56I08BZC5MQLcFXZweA1xxKpHHvasfztyUgLJwJCuXyLN3pluxFxqfyAe4Cx7hphNZfT4jVGk7LN/Zx9si89wl8a38TFyLTa0cQC0wlCuXmD5HEfi0v73d/iudK/ESmI16Oub5KauvWPehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpLqx+YHh5EEOdduRbwKMTA79eQXUDxBdEpx4Vh3YJc=;
 b=hYY+6z7hgY+zBFcGrY6Nf83KIZAkMeMlNHYo8xvtPhyW5QHGG8KJ3b+8bxsLUg9Dw3YJMvcR/H84MY7oSxLWar94xGzFLe4COmqKDZGFT+fCoCseFvOxPu/Woll0asOZ6X7OEMDzxkEvQg8glwQo1hDEe5CCGHy19PcWU2myTSI=
Received: from SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19)
 by IA0PPF0A63E7557.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bc6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:36:29 +0000
Received: from SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0]) by SA1PR12MB8600.namprd12.prod.outlook.com
 ([fe80::96bd:d94:4dac:b1d0%5]) with mapi id 15.21.0315.008; Mon, 17 Aug 2026
 15:36:28 +0000
From: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU
 queue restore
Thread-Topic: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU
 queue restore
Thread-Index: Ad0rRMKkZMtjCdRRQSmLmOSzrfpEcwDGWVhw
Date: Mon, 17 Aug 2026 15:36:28 +0000
Message-ID: <SA1PR12MB8600E176A0F4724E6AC639E49FA72@SA1PR12MB8600.namprd12.prod.outlook.com>
References: <SA1PR12MB8600A6C7595378BECA3E4A999FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600A6C7595378BECA3E4A999FDB2@SA1PR12MB8600.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T16:56:50.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8600:EE_|IA0PPF0A63E7557:EE_
x-ms-office365-filtering-correlation-id: 6eb09c1e-68c3-4c36-836f-08defc754e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|6133799003|8096899003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: 5jgLs+BWvPOSw7MV64c2wOi1bEyveLeybUT1MkigmpDjkz13gUC6zmRtggfFOjGVlUxU+3xvOYqOLadwoBzQjGrzL4kh0FrVbUAPK/zBALs/76r8w2AAB+gynIsGJbT3fthi1zLLVIPOZvQQbY0wBdpiu8/i4rpf25RuFS16DKE/SaGSR5SUeEf35+118n4oISPwo1ORurLmObSY1yrBWisX717QzIoRNTIvC5lmHJM7zjTqPBJI8k0CfWXOsc5ypqHtz4UCZ5+1MyHcVUCATRkm/+j8Wx2CQz9YvzGbwMOYo7585fu0PZ4OB3okFWI6tBVKwLvohbcC3shvyBKlDdaUcKY18CourcWlCxuGthdxTo3v1AS5G6VxWtf+2RbFqk2BlV4AqcVXXGs7smcZtJBBvd0GDbtZuYm9dE/Xv4CLfvvUoRNz9CGkPhD/HjteNAVoQAGKhA8pXwCVFze49dW3zfRwCfF9vZhrr7toIRCSfQATQ7CeJClh4+vRXLCHfSnlEn5x1DYy/ph+F4NACXL14qA5sg3PYzQVRGHtMqqt06bbW1svAiCn0nRJcWmp6XfjBk8dvPMOsNZFm8Q6w5PUhc1O0zOfKcK2qqM2LJZ3ZQZEHcQEiM2cWy1HsldCsfeC8Fh/KgtPf2AS+ghKMdxsMc5HO+qbmUDOeXVYvDSgfBbuat82wZdxm73Efb5XWGSQDolkTZvKo1YeWiQ3CeE9OWiIUfr2k2i2BU9ALvI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8600.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(6133799003)(8096899003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GwmtYoBTDbWffK6LxW4tVFu4XhAeEz8jNt/DH4dfL/MxsnKc/O0FdYMn47iB?=
 =?us-ascii?Q?DKARlTyEgAPspzwRCg65+fmlGF/kaX39ZOJ+wskS9TKGuULZbaYVZWklXMFl?=
 =?us-ascii?Q?zkzmCZukRiXgSoB7is5jJqNbt/aaLC4Uljhyemj8B0F5uCIy0J0165OILdmy?=
 =?us-ascii?Q?6UjFocYVg0D5HO3U5jllseRWLZl0TNbWkKRt6c8YyEcelUYT04o9Iws6oddE?=
 =?us-ascii?Q?HIp7HDFsdSwut43vrJEcSElWXZNMoT6A5ro0sR4fxdq0eLlUqHG4pfxRfp0a?=
 =?us-ascii?Q?sMasIBeFGPWEzdV19l1ldxjuiRJXlOVGQ4AwXF4R1yAUeEz1XsUhywHovR6X?=
 =?us-ascii?Q?vwV7itWEUHIYknkVvttrG9uK0MBHtVSn7WxN7tJGbwquZbwvpzV4tudFVblt?=
 =?us-ascii?Q?rmPLabmAhaMbtjxlgLyzoRRD6ZIGhUu1XdTF4TzFFTKNWRD22Hb5sCK1OWJm?=
 =?us-ascii?Q?6cbwlshWsHtdqryYlS89VIqC7oYru1jije8iwnhzpc4JsVzRSkzm307Y8pPf?=
 =?us-ascii?Q?GUZTqc3b1dVKeSaCvJCcJe6WZp60ELiiSHR0bAK9gUNOtrmf3rks8CGY6PZd?=
 =?us-ascii?Q?Pw81kNlQHPEScjETa7NjYw2zmTg299bSUQrPFVNkBBVdMKax0AV/l0Ty9c2L?=
 =?us-ascii?Q?zdrA4meE3u4s936aSC6QexnxfHegOt90mbdP4cz8MWOH791OodgQIuRpVplX?=
 =?us-ascii?Q?DiAc0qP90M7zbT37tpK3iagI1ZEM1AJ7VxU58bs1vJGRnITc7mpxU/ZyDcQn?=
 =?us-ascii?Q?ppMC3Mok7ELwWMoKZ74iTwMhRawbX/VcMMeV5YlRUyfrHxzYpz49Pue0JIhM?=
 =?us-ascii?Q?VAQX1+8CQWd/9up6lBOjd40E43UmRziIkr4vfnzQyTLh0Mkg/d+/dek/n7cl?=
 =?us-ascii?Q?PGO+ed2HQ6M7HGMAjoJForiCrWMK7l0O9vfAoH8+kekYTuNehs7OVrTfstQG?=
 =?us-ascii?Q?uB9IF+gCDkU4FJthcqgFAnd/sZ33EBUTW8ZSljM0g4l+1cdu8/84og0QywNr?=
 =?us-ascii?Q?SoiO9eBEcKDAJUIOgc53Y8TagLcrOXEuvJkGScEKviu5bpMCdNiHFEULX1t+?=
 =?us-ascii?Q?y87ICN8g7d0y5kmhfbIUqD3UIVThBV3NcZijSo2UiqQ3JPbwBSj5XueOntrn?=
 =?us-ascii?Q?098g98if7lTVy74tAMlXCS2GfiPtL5y9RXY9cuneGfJrNSFFpiuRPZS93hGT?=
 =?us-ascii?Q?J2IKTcOU50NXQvhS4/jh62e9b8ogpS7+tYLTGRGN7S3hwDJHMNGzBSasXo2b?=
 =?us-ascii?Q?Jj2WJrPhMIPRZxxrAhjLSoIdua6CjxZGUZPyW6Jeb45knjRZTXy87a5zSPBZ?=
 =?us-ascii?Q?mdwHnFkd682Vau5IJ2IhG8GxdBGWDBFGkdJCwNTF4iwDGNWLyzH2aqtn47ka?=
 =?us-ascii?Q?Vj2bxp6YLbTM3HpfwXJBFs4sXMW0UGoAJKqPL+uY+M6RhpOK6YKAxm0Zv1gY?=
 =?us-ascii?Q?+3siwLTB1qq7X6bkfk4A8XEN6NH9uxXXrAZcbUKqB3/DHY0ENvewA8x59Jfr?=
 =?us-ascii?Q?295fb1U3Q7tVmduJfgYq7UsmaVZDfghC/dO3ZaFm+59q/nROzIc1IJJXMA4G?=
 =?us-ascii?Q?U2PmLDQKnzFUHsY4z3AF+ya5ZDg3CQaPL7CmIMFILcArFr1cLH5V0A8CCfCG?=
 =?us-ascii?Q?noTYrUfGf9fuXtOJwNT1bOcguK01xhzuZhOB/yayrSZd9H7moptkmh7rXF1S?=
 =?us-ascii?Q?m0yg/wjf4xza/WlRaHodlbJCJaijkH4VNTSSiDUY9Z2pDvTu?=
Content-Type: multipart/alternative;
 boundary="_000_SA1PR12MB8600E176A0F4724E6AC639E49FA72SA1PR12MB8600namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8600.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb09c1e-68c3-4c36-836f-08defc754e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 15:36:28.8909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SXerx2yRGLZJn0K8wcmTPzTTM+sKkyKO5ZWm4y8yWfrSU23f7P+JzyMFsaYlpuQ+MUUjsLoHxa8QNiN8DdPGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0A63E7557
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

--_000_SA1PR12MB8600E176A0F4724E6AC639E49FA72SA1PR12MB8600namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General


Ping,



Can I get a review on this change please?



Kind regards,

Vladimir

From: Marioukhine, Vladimir
Sent: Thursday, August 13, 2026 12:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in CRIU que=
ue restore

Both create_queue_cpsch() and create_queue_nocpsch() unconditionally
call mqd_mgr->restore_mqd() when a CRIU restore is in progress
(qd !=3D NULL), with no NULL guard. On any system where restore_mqd is
not implemented, a user holding CAP_CHECKPOINT_RESTORE can trigger a
kernel NULL pointer dereference and panic the machine by issuing
KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore object.

Add a NULL guard for restore_mqd right after mqd_mgr is resolved,
before any resource allocations, returning -EOPNOTSUPP if the callback
is not implemented. This avoids complex error unwinding and is
consistent with the existing checkpoint_mqd guard.

Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
Cc: stable@vger.kernel.org<mailto:stable@vger.kernel.org>
Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com<mailto:Vl=
adimir.Marioukhine@amd.com>>
---
drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driver=
s/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index ea9d87450eae..25b738200e7e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -769,6 +769,11 @@ static int create_queue_nocpsch(struct device_queue_ma=
nager *dqm,

               mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                                            q->properties.type)];
+            if (qd && !mqd_mgr->restore_mqd) {
+                           pr_debug("restore_mqd not implemented for this =
GPU\n");
+                           retval =3D -EOPNOTSUPP;
+                           goto deallocate_vmid;
+            }
              if (q->properties.type =3D=3D KFD_QUEUE_TYPE_COMPUTE) {
                             retval =3D allocate_hqd(dqm, q);
                             if (retval)
@@ -2134,6 +2139,11 @@ static int create_queue_cpsch(struct device_queue_ma=
nager *dqm, struct queue *q,

               mqd_mgr =3D dqm->mqd_mgrs[get_mqd_type_from_queue_type(
                                            q->properties.type)];
+            if (qd && !mqd_mgr->restore_mqd) {
+                           pr_debug("restore_mqd not implemented for this =
GPU\n");
+                           retval =3D -EOPNOTSUPP;
+                           goto out_deallocate_sdma_queue;
+            }

               if (q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA ||
                             q->properties.type =3D=3D KFD_QUEUE_TYPE_SDMA_=
XGMI)


--_000_SA1PR12MB8600E176A0F4724E6AC639E49FA72SA1PR12MB8600namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if gte mso 9]><xml>
<w:WordDocument>
<w:DontUseAdvancedTypographyReadingMail/>
<w:DontUseJustificationAdvancedTypographyReadingMail/>
<w:DontUseHyphenationAdvancedTypographyReadingMail/>
</w:WordDocument>
</xml><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Ping,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Can I get a review on this change please?<o:p></o=
:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Kind regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Vladimir<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;mso-ligatures:none">From:</span></b><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-ligatur=
es:none"> Marioukhine, Vladimir
<br>
<b>Sent:</b> Thursday, August 13, 2026 12:58 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdkfd: guard against NULL restore_mqd in C=
RIU queue restore<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Both create_queue_cpsch() and create_queue_nocpsch()=
 unconditionally<o:p></o:p></p>
<p class=3D"MsoNormal">call mqd_mgr-&gt;restore_mqd() when a CRIU restore i=
s in progress<o:p></o:p></p>
<p class=3D"MsoNormal">(qd !=3D NULL), with no NULL guard. On any system wh=
ere restore_mqd is<o:p></o:p></p>
<p class=3D"MsoNormal">not implemented, a user holding CAP_CHECKPOINT_RESTO=
RE can trigger a<o:p></o:p></p>
<p class=3D"MsoNormal">kernel NULL pointer dereference and panic the machin=
e by issuing<o:p></o:p></p>
<p class=3D"MsoNormal">KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore=
 object.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add a NULL guard for restore_mqd right after mqd_mgr=
 is resolved,<o:p></o:p></p>
<p class=3D"MsoNormal">before any resource allocations, returning -EOPNOTSU=
PP if the callback<o:p></o:p></p>
<p class=3D"MsoNormal">is not implemented. This avoids complex error unwind=
ing and is<o:p></o:p></p>
<p class=3D"MsoNormal">consistent with the existing checkpoint_mqd guard.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Fixes: 48f0bdf4e38e (&quot;drm/amdkfd: Added MQD man=
ager files for GFX12.&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Fixes: 01bbc4a4b947 (&quot;drm/amdkfd: Add MQD manag=
er for GFX 12.1.0&quot;)<o:p></o:p></p>
<p class=3D"MsoNormal">Cc: <a href=3D"mailto:stable@vger.kernel.org">stable=
@vger.kernel.org</a><o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Vladimir Marioukhine &lt;<a href=3D"m=
ailto:Vladimir.Marioukhine@amd.com">Vladimir.Marioukhine@amd.com</a>&gt;<o:=
p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.=
c | 10 ++++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 10 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_q=
ueue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">index ea9d87450eae..25b738200e7e 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_ma=
nager.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -769,6 +769,11 @@ static int create_queue_nocpsch=
(struct device_queue_manager *dqm,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_=
from_queue_type(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.t=
ype)];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (qd &amp;&amp; !mqd_mgr-&gt;restore_mqd) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restore_mqd not implemented f=
or this GPU\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EOPNOTSUPP;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto deallocate_vmid;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE_TYPE_=
COMPUTE) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D allocate_hqd(dqm, q);<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2134,6 +2139,11 @@ static int create_queue_cpsch=
(struct device_queue_manager *dqm, struct queue *q,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd_mgr =3D dqm-&gt;mqd_mgrs[get_mqd_type_=
from_queue_type(<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.t=
ype)];<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (qd &amp;&amp; !mqd_mgr-&gt;restore_mqd) {<o:p></o:p></p=
>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;restore_mqd not implemented f=
or this GPU\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EOPNOTSUPP;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_deallocate_sdma_queue;<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (q-&gt;properties.type =3D=3D KFD_QUEUE=
_TYPE_SDMA ||<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; q-&gt;properties.type =3D=3D KFD_=
QUEUE_TYPE_SDMA_XGMI)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_SA1PR12MB8600E176A0F4724E6AC639E49FA72SA1PR12MB8600namp_--
