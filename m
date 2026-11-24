Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F5F606A31E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RRHHE/o3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE51B10E2C0;
	Tue, 24 Nov 2026 02:59:45 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013010.outbound.protection.outlook.com
 [40.93.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB0FE10E2C0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 02:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W52M8senkRW6+9vSp9Ih98rdjOk8MwvZ7VsKOHS+Ayt+qWxOIMpw4hl6YBR3cij+15FiYV6QFb9FT4TznJVpAMI7Kaj2O0p+5v6YuKphfytKLIKy9htLn+dMwkavmodj6a6qBvHrAE5XcgBJ/63ukwluZc7+RM1m48yyFqissECXrQNV2/Lr11sUlcAeuXdHM1V5aeDF6ZmgKO/Mju6lvzCrfB1hU/iOzJZAiGPsU9jZeDZgP6s84ns6+DrZ58J4QEODxXZ9vUQ3w/ymWQgDe/hvC/+i4cQZFsF7AzMC2DklWPwNgbp721XtBqLXyfrhsCfUQBtivWXaeQ7iji57oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLXPqZvVSHuvV1DXrFQN+7soSwqHOpMW05mEMA0lbQ8=;
 b=xyyPn1sWl7WsBDDSCjWE1z7Kx+WAUYH5SMdmpganIv1BSu+wc1QMLxgM2IbteHECBbMrZrA5PADL5mKA60R3rNjJ4V8YK5FxrKZVpAM15p4/cgk0Mb8TbXOZUaHzDpS6y85kCEg5JH47JmlsKDFNjOlviyMQZAFLApWIAJelEcJJcKmHxo9wsEAcRXcRbEp1x3d1KonmJAM/J/3mW34+uj3PWimIc72qOKP4i9LJOsszIBZboibJzNJaiImlBzn4xNRRlmdaVsm7CVliFNMKhs9to9kRQQ5lMPuAE4TfMn4qjXZCC+NmT6Aa09JjBppPBkXMbbXHqDSF04r6P5B/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLXPqZvVSHuvV1DXrFQN+7soSwqHOpMW05mEMA0lbQ8=;
 b=RRHHE/o3tgVB6dQatB7niadRlXPbaMYWQi5cS+bqero3mpoVJ9Qjd8WQl9hzi+GhsIJ2f2zk8vCN+cPwoE21SDEQ3nmF5LQ9X2i8a+jU1HZo6+h4j0Wg2Uvd2+KlVfirSVa3O+nsrmR7hK81KcmKD9eovSIglA/IVMFZd5D3Pjg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 02:59:36 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 02:59:35 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: add ptl_format module parameter
Thread-Topic: [PATCH 1/2] drm/amdgpu: add ptl_format module parameter
Thread-Index: AQHdext/bwGBnZJmIU6zBjpDdImxJLc8iUoA
Date: Tue, 24 Nov 2026 02:59:35 +0000
Message-ID: <CY5PR12MB6369FB220470EAD77B4E505CC1442@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261123072247.3612981-1-perry.yuan@amd.com>
In-Reply-To: <20261123072247.3612981-1-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-24T02:58:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB9066:EE_
x-ms-office365-filtering-correlation-id: 50f5bb45-2350-451d-13ca-08df49d6f8b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: /XMw9XuO/73WLFEX12nOpdJWO41TU/Lkc0ZRFKuhWYuAzLq5fJ5JNODO90dGCqCfcFQSVx8K82XUx8oXivNue16Eu5sUEt2akQAz/HhTNaMAWPY4yFTEwzSCIx6003nCJrh9SEHyQiWuLbSykyjlzcstSMHsnhUkI9NgtanN/2TRiY6rPa0j9xFf0DesEtNe5Ad74sPia8gZXhy7HF7Nrhbp/fI40/8DKoZ1o+8xQfpVST8IzGO8M2Phl0fuEpwmKk/LEuts7vcwM4wV+jMhzYD8rLKFiVdEZzSvYT5dX83SjwLcR2aEYoLQamXNommEAogAGV3oHU7HVF5pxcbYow+EGZtAL1GOm0yThOflZSKcaFhY9UBih02uIuekLkjL9PjSMKSu+bQLjBLyp1IREJgNAAXVaRKWMDH5Ye9z5Jz/tlKPWe8jrkNH+N/NUySkfg9KVxd9ORFBlnaQ96o8HghINtFPdJ6kHvBCqsWM2HO6n99IvbXv/o0wivvQYVmLl7rx7aBjAb0usr1UNij4BH2xSnCL41mKeTuqsiXZqJMN5puovNum6BiEX3+mEse5P6kC6FEVSBT2+Pu3qVlO6SV3kq0wlvnUXUlPcZ0BNumXu6XqO5CWTgoOUPghJkB2+AJX2jWgvKT+XGHZEeK77uP71nfzEcvAn9L9XMbOiNdC8WU5HOdQfdjx7haF/69fO3kNc5Si7I4nRq7Pd62ZC/xH0DGPkz47EzTZ485pobM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ntlqMd/NPbrg0fkW2TT6XL3pmqOz7oh8yCzcL/HmyHsrjMmWMeqYOK2w2RAx?=
 =?us-ascii?Q?bgrAgiZz+WqUZeXWSj7d45bYY4VRgCyDIJ5DwbeZ848Z6gfhvHSIDWMTz3js?=
 =?us-ascii?Q?4x/ZIjQ9F6smD3CHQUGWzkTt4kt3Wn7SjhaLP8Rk7vNqX/OsyvUWSc80kZxb?=
 =?us-ascii?Q?SCCVzTWxl32JjjtLZE0V0G7+zpixvHcSz0icOCjc/ASpsQXXrRKM1W+IBg0z?=
 =?us-ascii?Q?tTuFnsEYbjtLRttSjTcIpARlyNyi8AYLdCrdjmDHBc/MIJKbrsC9yGdPABtA?=
 =?us-ascii?Q?Y9UjEzf9yn5Mq80A2CyhoM8Jbz7mjEx2FgrvqbebEu3qSEHxPSqbUOJdJ6gH?=
 =?us-ascii?Q?jYT2rlcUs1JzbA3szUm6kBFNMQehODVEvPFz/jZhGERjfx5VxWXMlIWogTeb?=
 =?us-ascii?Q?HmKYYAsrbnd9+YKZnOMgdvCsMwczabXcL4S64gUCt8KVvdzlxYX99BgydM52?=
 =?us-ascii?Q?rghuN3xs2vFIaXKwYLHsSlUqUgRm6rzZykIGxtu98XXAlzy4iuJsB0tsahrZ?=
 =?us-ascii?Q?310FwRc8LDfVeVcBNoUq3JHON5WJuD7uC/MkAXcJXSNav6LafsJsaSgQo1Om?=
 =?us-ascii?Q?sTGjlSBpkOQSt9cqGL2UiZ9M7aCo0g1+XCQP4Q3Os1HNR+lNo4jALc43zcaR?=
 =?us-ascii?Q?wnhPxYCtOgb8w83VvzZhS9i3yjdvTx6Mycv5VSx2yhpFrA+2SBKX5XgkpFmq?=
 =?us-ascii?Q?n3Q0BMGFIdjbgCVKIJlqmdNV7ZxHLaAK+BqxgrrYRbvah9pGKzlMU3Vadfh5?=
 =?us-ascii?Q?DBjM2sOFAG02N6NlJawC6Z+I98kpJeA5eB5YShR0Jhl/35xEY3WbgxZ8Ys+E?=
 =?us-ascii?Q?jd1mcKlAtb38Wk2D5LgMpNs7d1tZXCnvvhqRo6p4+lPAttuEAiMGSO7W1M4y?=
 =?us-ascii?Q?xLlCQcRnxFfqHC1x2S96u8krLoIzV1jDltphgkCF0aJnVI8yhn8vd5NLQSg9?=
 =?us-ascii?Q?i8vF+fmolegI9vQx/8fBcudG/J4qDc0yaU5RGwag3/nsChOH0i3nkzeoGJKy?=
 =?us-ascii?Q?YTs4zhlUCNvknTtHeD5sxd670q3MwW/bzON5W4r0rpLGJPIXaYjisdmDQ17p?=
 =?us-ascii?Q?GJGKPGwfj1eaKgxiguNMEFI9w/iuk42mv3NQyOwsa3Vd+bhRqrb3OljhYtcB?=
 =?us-ascii?Q?LEWB67n/Bwi91mg0StNqGxQ4AFRjbHkYvAct7ZiHkI1/mbeSLsHtqUg9okdB?=
 =?us-ascii?Q?IxW+OIBy/hSL9z9r1LT4Cd2OcTkdoionGHuajFAdDDakFqnht1uCO4zdHT8l?=
 =?us-ascii?Q?9s5lwGTDPzcxxAWu9E6f/VguzqTRvVhwAplKKutMZljPtJXHmVh5ZBJwDXG0?=
 =?us-ascii?Q?c+CzIVEo3OpgNUK6n6uBizBHypfOjMnOWUNrqyZFcNNshFmlPkAr80pJHtuE?=
 =?us-ascii?Q?uU/HU6J7m5lwZiLo6gtwSyvKLJKeEQ/+4dcXTJngaisOqwBrvNxJR32ef9zE?=
 =?us-ascii?Q?3/ziwqMUz3ExxWUs2wCkk1OKaF5RBkSE4rUPSaOYkfEreqHCD4d7XC3CQoDG?=
 =?us-ascii?Q?Ue0DQIQQa0yHoBibgJv0vM6FW0t5eSThO2lNr9vwCaj8J6vrrRbcZp1uVJwM?=
 =?us-ascii?Q?Zw7+YMC597S4EudWbPQzqTDmnEbONDiKry7l8ipWzunyZyXWQt9qDnzTlmCc?=
 =?us-ascii?Q?VJ4lFlinxi2V7uayymeSnG3aB5ftzsAzIg9+bEMDIMTYbwZGNNkdxxcF13t5?=
 =?us-ascii?Q?DWQqiVhP1b1r0MGjzyN5knSonmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f5bb45-2350-451d-13ca-08df49d6f8b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 02:59:35.3949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sDsh7H/jAJWHs4WHTJGXyTDZ37NST5TgaindJy4e51cyjA1SrwRDOeLM83UD0puj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Yuan, Perry <Perry.Yuan@amd.com>
Sent: Monday, November 23, 2026 3:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Pe=
rry.Yuan@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add ptl_format module parameter

PTL always starts with VECTOR,F8 at driver load. Users who need other forma=
ts have to rewrite the ptl_format sysfs file after every boot, and that fil=
e only accepts writes once PTL is enabled.

Add an amdgpu.ptl_format module parameter that takes "FMT1,FMT2", for examp=
le ptl_format=3DF8,BF16. The formats are applied on the first PTL initializ=
ation; resume and reset keep using the cached formats as before. An invalid=
 value is reported and the VECTOR,F8 defaults are kept.

Move the format parsing out of ptl_format_store() into
amdgpu_ptl_parse_formats() so the sysfs file and the module parameter share=
 the same validation.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 10 +++++++  drivers/gpu/drm/amd=
/amdgpu/amdgpu_psp.c  | 34 +++++++++++++++---------  drivers/gpu/drm/amd/am=
dgpu/gfx_v9_4_3.c  | 14 +++++++++-  drivers/gpu/drm/amd/include/amdgpu_ptl.=
h |  3 +++
 5 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index a7a2b6b5a497..53eb4824f922 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,6 +270,7 @@ extern int amdgpu_rebar;  extern int amdgpu_wbrf;  exte=
rn int amdgpu_user_queue;  extern int amdgpu_ptl;
+extern char *amdgpu_ptl_format;

 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 6478506d8089..5b366fc910ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -254,6 +254,7 @@ int amdgpu_rebar =3D -1; /* auto */  int amdgpu_user_qu=
eue =3D -1;  uint amdgpu_hdmi_hpd_debounce_delay_ms;
 int amdgpu_ptl =3D -1; /* auto */
+char *amdgpu_ptl_format;

 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
                        "DRM_UT_CORE",
@@ -1183,6 +1184,15 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amdgp=
u_hdmi_hpd_debounce_delay_ms  MODULE_PARM_DESC(ptl, "Enable PTL (-1 =3D aut=
o, 0 =3D disable (default), 1 =3D enable, 2 =3D permanently disable)");  mo=
dule_param_named(ptl, amdgpu_ptl, int, 0444);

+/**
+ * DOC: ptl_format (charp)
+ * PTL preferred formats applied at driver load, as "FMT1,FMT2"
+ * (e.g. "F8,BF16"). Supported formats: I8, F16, BF16, F32, F64, F8,
+ * VECTOR. The two formats must differ. Default is VECTOR,F8.
+ */
+MODULE_PARM_DESC(ptl_format, "PTL formats at load, \"FMT1,FMT2\"
+(default VECTOR,F8)"); module_param_named(ptl_format,
+amdgpu_ptl_format, charp, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c19600f8b7f8..09648b68d066 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1880,6 +1880,26 @@ static enum amdgpu_ptl_fmt str_to_ptl_fmt(const char=
 *str)
        return AMDGPU_PTL_FMT_INVALID;
 }

+int amdgpu_ptl_parse_formats(const char *buf, enum amdgpu_ptl_fmt *fmt1,
+               enum amdgpu_ptl_fmt *fmt2)
+{
+       char fmt1_str[8], fmt2_str[8];
+       enum amdgpu_ptl_fmt f1, f2;
+
+       if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) !=3D 2)
+               return -EINVAL;
+
+       f1 =3D str_to_ptl_fmt(fmt1_str);
+       f2 =3D str_to_ptl_fmt(fmt2_str);
+       if (f1 >=3D AMDGPU_PTL_FMT_INVALID || f2 >=3D AMDGPU_PTL_FMT_INVALI=
D ||
+           f1 =3D=3D f2)
+               return -EINVAL;
+
+       *fmt1 =3D f1;
+       *fmt2 =3D f2;
+       return 0;
+}
+
 static ssize_t ptl_supported_formats_show(struct device *dev,
                struct device_attribute *attr, char *buf)  { @@ -1979,7 +19=
99,6 @@ static ssize_t ptl_format_store(struct device *dev,  {
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D drm_to_adev(ddev);
-       char fmt1_str[8], fmt2_str[8];
        enum amdgpu_ptl_fmt fmt1_enum, fmt2_enum;
        struct amdgpu_ptl *ptl =3D &adev->psp.ptl;
        uint32_t ptl_state, fmt1, fmt2;
@@ -1990,18 +2009,7 @@ static ssize_t ptl_format_store(struct device *dev,
                return -EPERM;

        mutex_lock(&ptl->mutex);
-       /* Parse input, expecting "FMT1,FMT2" */
-       if (sscanf(buf, "%7[^,],%7s", fmt1_str, fmt2_str) !=3D 2) {
-               mutex_unlock(&ptl->mutex);
-               return -EINVAL;
-       }
-
-       fmt1_enum =3D str_to_ptl_fmt(fmt1_str);
-       fmt2_enum =3D str_to_ptl_fmt(fmt2_str);
-
-       if (fmt1_enum >=3D AMDGPU_PTL_FMT_INVALID ||
-                       fmt2_enum >=3D AMDGPU_PTL_FMT_INVALID ||
-                       fmt1_enum =3D=3D fmt2_enum) {
+       if (amdgpu_ptl_parse_formats(buf, &fmt1_enum, &fmt2_enum)) {
                mutex_unlock(&ptl->mutex);
                return -EINVAL;
        }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index b789f528f3b0..0cf13e78b821 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -2454,14 +2454,26 @@ static int gfx_v9_4_3_perf_monitor_ptl_init(struct =
amdgpu_device *adev, bool ena
                return -EOPNOTSUPP;

        if (ptl->hw_supported_state =3D=3D AMDGPU_PTL_HW_UNINIT) {
+               enum amdgpu_ptl_fmt f1, f2;
+
                fmt1 =3D GFX_FTYPE_VECTOR;
                fmt2 =3D GFX_FTYPE_F8;
+               if (amdgpu_ptl_format) {
+                       if (!amdgpu_ptl_parse_formats(amdgpu_ptl_format, &f=
1, &f2)) {
+                               fmt1 =3D f1;
+                               fmt2 =3D f2;
+                       } else {
+                               dev_warn(adev->dev,
+                                        "Invalid amdgpu.ptl_format=3D%s, u=
sing VECTOR,F8\n",
+                                        amdgpu_ptl_format);
+                       }
+               }
        } else {
                fmt1 =3D ptl->fmt1;
                fmt2 =3D ptl->fmt2;
        }

-       /* initialize PTL with default formats: GFX_FTYPE_VECTOR & GFX_FTYP=
E_F8 */
+       /* Defaults or amdgpu.ptl_format on first init, cached formats afte=
r
+*/
        r =3D amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl=
_state,
                                                        &fmt1, &fmt2);
        if (r) {
diff --git a/drivers/gpu/drm/amd/include/amdgpu_ptl.h b/drivers/gpu/drm/amd=
/include/amdgpu_ptl.h
index eead62b4b327..c445525833a2 100644
--- a/drivers/gpu/drm/amd/include/amdgpu_ptl.h
+++ b/drivers/gpu/drm/amd/include/amdgpu_ptl.h
@@ -64,6 +64,9 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *ad=
ev, u32 req_code,
                enum amdgpu_ptl_fmt *fmt1,
                enum amdgpu_ptl_fmt *fmt2);

+int amdgpu_ptl_parse_formats(const char *buf, enum amdgpu_ptl_fmt *fmt1,
+               enum amdgpu_ptl_fmt *fmt2);
+
 int amdgpu_ptl_sysfs_init(struct amdgpu_device *adev);  void amdgpu_ptl_sy=
sfs_fini(struct amdgpu_device *adev);

--
2.34.1

