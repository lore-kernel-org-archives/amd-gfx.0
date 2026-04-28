Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0789FF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 424AA10EA17;
	Tue, 28 Apr 2026 03:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iWrz4GJe";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9837B10EA17
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET73L/dHEwBFVe0tZOv8JmCxpG8lAC38T4/zd5gMOW5hn6qyDCM4Q1TmS/aieN8+sncWVUJSiRm0l7rQt5MQ+8ztqGo6WSEzxYFLfY9g6ieg9JzC1szmFmH6/tYH/UcFkc5T2VxCZtIEmlIYi7Ds1bjr8M+L+GAyEgHzlK7ixKnTWyyTzCF+pHziiPkhuB6CmNVOf4lwnZVk7O1pWShzkG/UxWln+RnkY+lm8DFrx7l8whB8EtKRZXzQHyGFN/Lt863fg97z3D12+ieNGbbuew0TV68Y7vdS+Xyf7ZA6hUBeZkAMUEIIJg2P31wryGifRD0PrEZui5NaRMpMltjhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SU+0O9fKSL0V54USDO2ADxSPKz8cmCDgYIEE82Lr6vY=;
 b=mLLciWn70SxMmVSVYIBvFXN7zEAOkcw/KJ83Vfl2ESuO8eQTBZ5z8AxKTHJFIIHq8FtCVIbOxZVC9kav2A6O9uijfgjQC+pDHKZnb1Z5Njvb/jdkr4szcAEdngpy3A3vZj7RX8B7bPzYzhxoB3Pbm9BXWYVTk6cxQm/hLVv7FqftY3ZrMIm4zzl8bC73DGYTCW6PRYFlk1zGUlqsxzGgemQJcaeQrFDs+y1WW32XIU0mlElr4TmEHpNcWYvaxVgMS/A9VZcqlN0TUCeuy4GyUyi5VyGAFmbZo7DgFDWPxaN5rwpwcCMr2rix5U9Pvk8re3FK/9YXSvsSn+GiW9NbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SU+0O9fKSL0V54USDO2ADxSPKz8cmCDgYIEE82Lr6vY=;
 b=iWrz4GJe59ILWr1KbcaYRK+2DzDKgCbK4gqGvMhoV0C5tTHKBuh9YgOh1tmPfYiB9XLclAB9lCw07SVoWphCtK7+YBBKk+weXrjSYMN+rfSLJmuWeir978OdU4ZwSu1Ycb3ooW+JwEPe1v+IFYpD1O9JcMZ8S4TPuVOlTKH8FC0=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by DS4PR12MB9682.namprd12.prod.outlook.com (2603:10b6:8:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Tue, 28 Apr
 2026 03:17:39 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:17:38 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 14/17] drm/amdgpu: workaround for spm ring buffer
 overflow
Thread-Topic: [PATCH v2 14/17] drm/amdgpu: workaround for spm ring buffer
 overflow
Thread-Index: AQHcu9QYwMmBoYT2pE2Bg4fNHTgD9LX0A3TQ
Date: Tue, 28 Apr 2026 03:17:38 +0000
Message-ID: <BY5PR12MB4179253F61F677BDB21B6C2AFD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-15-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-15-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:17:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|DS4PR12MB9682:EE_
x-ms-office365-filtering-correlation-id: d2169a23-5ef0-4154-9d2f-08dea4d4b3b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: WvfE2e4kGvAVrfhAWl7EN4FWmKcLwavk7wl+NvclzCKzfpJ+l8zCTCWLhWKkRgFNwJR4D8BvYsEntdzWccUt2W9WJSqzQSkJ+XqPXX2hVS5bd2cd8I34BYMpDGZnKkD4YrD15or8x6ci6iQbj2JshahMDj2HIE7ryw9RTZ3fd+D+GLkf4eEP7S9AidzIKhPj4CP/4oWgxFAOZfAzBOp64efs41wT4A21GQOVuVzsISC7wtrwYWgzWoMGmPmGot4NtuLy2iLyK5pNkbfuFXKXCsRe7tEuDyFTFOfmaNVzBnydj/iEH4fwenjCVMTYSnTxAdZGIbatRgshOz1FRFEiIjoc6rjqvTwaZYM71c4HjN/yaXJqGeMDYKvtppV1cL02GgGJdv+CDT1dXSUyHiWNGjr1SMm58qTGzgJYYNT/fqs8lsSSUPyAZsqPau6mISNqeHEIY2oRZiJs7NOSo8oxQFFLxx4Xhjsnp+9XbZ00PNPUrN+cIjXB1FRG921oH3UsAm8x6A+TVIj0NUn50Ey1uujDPO8Qz9Ny6dnS6T5MY2vDKPaTIWOWjoYsh6HomhgpvLd4cKOVFytTmAIKR2GXXr6iosOIul+sw6NcB+YSDAfb9M5mQgBcihIwhqkfHSfkDqhdiSTIF9Uaj6j8UIfBTWHPOv34LXtw5k7pPqcJUgAFT1RPss/UJecDl+oPuEVlZg4lcgZqmPj/gmXVQ9TCo9QDVvk3+2Ns+MO7ClQILNZVWuE98w3vLBQP/oLlEvwPNE5EbIx1pr74Ic46QQqHEvquHC4pM+oW0qQYBZvVsAQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AhKjrm5fEdBSM+yWQIkKnAnoBnq76ERoNNJ4yfCQ9rJbodI6JpzLWTyc5k7L?=
 =?us-ascii?Q?oCH/taDxhYvL6ZbDK1W9Iri+b2wIStVyOXKNHHRc9Za1QC4Z9o9o2XxvfYOi?=
 =?us-ascii?Q?rgHSvm69ngIAd+ac9BUahXsF1aMJ9QJ1Glkb6ZjG21+qgRxJKcvcQvz5HFt/?=
 =?us-ascii?Q?2/FdTiNAYyg9EEqeSK1+a7WOEOZVKZC06OHjrtDpqptXNAnM2Zm1I7eStzJN?=
 =?us-ascii?Q?GW8Tb3yXgzMvY0oK1kBIk7zGRxah4+2cdYcxpnpad+883DMjkAZaJpctCmAt?=
 =?us-ascii?Q?fDLiIqRD9lxgx/NlBEiizAngkcqgSFNXMKF9inrCTbs+eHBmTiC00D76i7t8?=
 =?us-ascii?Q?vY8GTKQqq34FoH9CanwgA/DSSZHI9wg1XVjYTK0AOQaBZFva7gvbh7AnoKvk?=
 =?us-ascii?Q?Gb/jqTraSja32PvlZ5g5Uu38QQVlUo6nsbPPZiGdBVKqXs7AZRCDBzdToSTY?=
 =?us-ascii?Q?kzhgmYGsawf9LIqMbmVdjaXgCOLJK27gr6qCp1fTASD47Flkp1d06Eav/LTe?=
 =?us-ascii?Q?Fa9/9KOUO3EJNMAIV9sCOz2WPhxc1O9VqtjeDuVP6b+afj4pqk2IARk3gUgs?=
 =?us-ascii?Q?IdCWHYAO4UqCJfXo8sCvc22tvE4hv4tOtj8cn6eah4kfM1U0hDVsS+0lyCQR?=
 =?us-ascii?Q?TwjwclFlmM5btX9ODdFIpoxhG7T6RawWc4EqS3CblFS4cqpEuODkHzqyMgsR?=
 =?us-ascii?Q?wMY8Q59ymj6CMvujLRxHllBCmdGr20CVAkZpBc8J7U89ImeOhI4cgvBLjlvY?=
 =?us-ascii?Q?syB0icYxv09o5EAoRnYIgpV63Y95ob/2ETeUlOg1pM4kO8eeKs0//TkDmLk+?=
 =?us-ascii?Q?K4IXzxh1yy5U8OKg2cgBVqhLcEp5s3KOCjBS01uURM5xnv5+Fce9JbkWjiZh?=
 =?us-ascii?Q?Zj4wIBlbdMyuAysGjf62F3uXKuwrDg9CxpRCKCR7cb5zODLcTjhhvP4HfvJ7?=
 =?us-ascii?Q?WimWd7fl2OPVcjO8D2dEmnKp5rFWVw0HaiU4120L10s0tRS8oFF3zUVx6uRO?=
 =?us-ascii?Q?nX6tFeY9lEhojfmQV4S+MdmvZkHeB8nMSPqMBHuM15eeGmCx7pE+f3ITSq8/?=
 =?us-ascii?Q?Lp/LgeAdsyut0V8f+ysg5RjOVmlKQTE+eH7eg8jivu2tpXmvI0NMkZlHfp3z?=
 =?us-ascii?Q?CS8o5FsfsY1hLfOnGNLqp5A8sYaSW0ZMYkDg2hrCfs5tp94s9edZAdjclqST?=
 =?us-ascii?Q?el1aKhDpQ+6NXo6ksfW3OVgilaAG4+cXRPP4M2ycYz4/e4QG1oDFp0wyQ9Q6?=
 =?us-ascii?Q?HSPDZpsJVG5SebzVjQODk7O5qrsS/I7PiBegP5Blir9UEbyWwVgHBDg6WGmA?=
 =?us-ascii?Q?WWDf5nMFHANsJ9GJmSK3EtQ1+TVZtxrDQKwUEir3AWh+iqZ52eTLv8c4Z2Fg?=
 =?us-ascii?Q?FnP9ajIu9w2S2amw/ySx8LkiG7r3IqnbwIMd7kaCH5YHVswU1fbaQZUcSRtm?=
 =?us-ascii?Q?78puhAhQTDIRPkY5FQyI8PTX3Y15ViF6f9zGdo1fJuU10dXwWTYLagE1N/RL?=
 =?us-ascii?Q?DI2rZiGrsUuy/0esmD0rObevbSGDoh6ll/qV2xNRWSlmF4vh9ULkWxDIgX/c?=
 =?us-ascii?Q?KWjaizP2OVXUlUmOBLXidwFQxnWgAHy6VuMeH/ac5osi7BFIpQaPQ9GvCEAw?=
 =?us-ascii?Q?MAb3Mhq/ZOIg8npGG/Lv8MTDQmJR3BKavvXOZzfU6BxVPw9omxgsjZXn4hXq?=
 =?us-ascii?Q?GCrORglNMI1KvNQlWAIRBmbSgB0zntKO7bfcNURcKDklNHGQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2169a23-5ef0-4154-9d2f-08dea4d4b3b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:17:38.7534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfGR5ubseMPAvC8mjMl/YBxGjj//O5n1v/8ZSVn0wN9zABJeqLREn0JDnqfbt7tGEP1MFMVyZ7lnuqNHHIHYQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9682
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
Subject: [PATCH v2 14/17] drm/amdgpu: workaround for spm ring buffer overfl=
ow

reserve space to avoid page fault and data loss.

A hardware bug on GFX IP versions earlier than 11.0.1 causes the RLC SPM ha=
rdware to write slightly beyond the end of the declared ring buffer when th=
e ring wraps around. This can corrupt adjacent memory and cause page faults=
 or silent data loss.

The workaround reserves an extra 0x400 bytes (1 KiB) of guard space immedia=
tely after the ring buffer's declared end, pads it with a known sentinel va=
lue (SPM_OVERFLOW_MAGIC =3D 0xBEEFABCDDEADABCDULL), and recovers any counte=
r data that spilled into this region before it is overwritten by the next w=
rap-around. The overflow size varies, the overflow data is valid data, and =
the wrap-around write starts from cpu_addr + overflow_size + 0x20 instead o=
f cpu_addr + 0x20.

Implementation:
amdgpu_spm_init_device():
  Detects affected hardware via ip_versions[GC_HWIP][0] <
  IP_VERSION(12, 0, 0) and sets spm_overflow_reserved =3D 0x400.
  This field is zero on unaffected hardware, making the entire
  workaround a no-op for GFX11+.

_amdgpu_spm_acquire():
  Before calling amdgpu_rlc_spm_acquire(), subtracts
  spm_overflow_reserved from ring_size so the hardware is told a
  smaller ring size, leaving the guard region beyond the hardware's
  declared ring end. After the 0x20-byte metadata subtraction, calls
  amdgpu_spm_preset() to fill the guard region with SPM_OVERFLOW_MAGIC.

amdgpu_spm_preset(spm, size):
  Writes SPM_OVERFLOW_MAGIC to the guard region starting at
  cpu_addr + ring_size + 0x20 for 'size' bytes. Writes are 0x20-byte
  (32-byte) stride aligned, matching the SPM hardware's fill granularity.

amdgpu_spm_read_ring_buffer() wrap-around path:
  When wptr < rptr (ring has wrapped), scans the guard region in 0x20-
  byte steps to measure how many bytes of overflow data were written by
  the hardware (overflow_size): stops at the first 64-bit word still
  containing SPM_OVERFLOW_MAGIC (unwritten). If overflow_size > 0, logs
  a debug message and copies the overflow data back to ring_start
  (cpu_addr + 0x20) via memcpy() to make it available for normal copy
  processing. After the ring drain completes, calls amdgpu_spm_preset()
  to re-arm the guard region with SPM_OVERFLOW_MAGIC for the next
  wrap-around.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c | 42 +++++++++++++++++++++++++  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_spm.h |  2 ++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.c
index 9f0d1f688d5e..9b7bb15a3785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.c
@@ -32,9 +32,24 @@
 #define AMDGPU_SPM_MAJOR_VERSION       0
 #define AMDGPU_SPM_MINOR_VERSION       1

+/* used to detect SPM overflow */
+#define SPM_OVERFLOW_MAGIC        0xBEEFABCDDEADABCDULL
+
 static int amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr, struct drm_f=
ile *filp);  static void _amdgpu_spm_release(struct amdgpu_spm_mgr *spm_mgr=
, int inst, struct drm_file *filp);

+static void amdgpu_spm_preset(struct amdgpu_spm_base *spm, u32 size) {
+       uint64_t *overflow_ptr, *overflow_end_ptr;
+
+       overflow_ptr =3D (uint64_t *)((uint64_t)spm->cpu_addr
+                               + spm->ring_size + 0x20);
+       overflow_end_ptr =3D overflow_ptr + (size >> 3);
+       /* SPM data filling is 0x20 alignment */
+       for ( ;  overflow_ptr < overflow_end_ptr; overflow_ptr +=3D 4)
+               *overflow_ptr =3D SPM_OVERFLOW_MAGIC;
+}
+
 static int amdgpu_spm_data_copy(struct amdgpu_spm_mgr *spm_mgr, u32 size_t=
o_copy, int inst)  {
        struct amdgpu_spm_base *spm =3D &(spm_mgr->spm_cntr->spm[inst]); @@=
 -79,6 +94,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_spm_mg=
r *spm_mgr, int inst)  {
        struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
        struct amdgpu_spm_base *spm =3D &(spm_mgr->spm_cntr->spm[inst]);
+       u32 overflow_size =3D 0;
        u32 size_to_copy;
        int ret =3D 0;
        u32 ring_wptr;
@@ -110,6 +126,22 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_s=
pm_mgr *spm_mgr, int inst)
                size_to_copy =3D ring_wptr - spm->ring_rptr;
                ret =3D amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);
        } else {
+               uint64_t *ring_start, *ring_end;
+
+               ring_start =3D (uint64_t *)((uint64_t)spm->cpu_addr + 0x20)=
;
+               ring_end =3D ring_start + (spm->ring_size >> 3);
+               for ( ; overflow_size < spm_mgr->spm_overflow_reserved; ove=
rflow_size +=3D 0x20) {
+                       uint64_t *overflow_ptr =3D ring_end + (overflow_siz=
e >> 3);
+
+                       if (*overflow_ptr =3D=3D SPM_OVERFLOW_MAGIC)
+                               break;
+               }
+               if (overflow_size)
+                       dev_dbg(adev->dev,
+                               "SPM ring buffer overflow size 0x%x", overf=
low_size);
+               /* move overflow counters into ring buffer to avoid data lo=
ss */
+               memcpy(ring_start, ring_end, overflow_size);
+
                size_to_copy =3D spm->ring_size - spm->ring_rptr;
                ret =3D amdgpu_spm_data_copy(spm_mgr, size_to_copy, inst);

@@ -128,6 +160,7 @@ static int amdgpu_spm_read_ring_buffer(struct amdgpu_sp=
m_mgr *spm_mgr, int inst)
        }

 exit:
+       amdgpu_spm_preset(spm, overflow_size);
        amdgpu_rlc_spm_set_rdptr(adev, inst, spm->ring_rptr);
        return ret;
 }
@@ -169,6 +202,12 @@ static void amdgpu_spm_work(struct work_struct *work)

 static void amdgpu_spm_init_device(struct amdgpu_spm_mgr *spm_mgr)  {
+       struct amdgpu_device *adev =3D mgr_to_adev(spm_mgr, spm_mgr);
+
+       /* pre-gfx11 spm has a hardware bug to cause overflow */
+       if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(12, 0, 0))
+               spm_mgr->spm_overflow_reserved =3D 0x400;
+
        spm_mgr->spm_cntr =3D NULL;
 }

@@ -194,6 +233,8 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *s=
pm_mgr, int inst, struct
        if (ret)
                goto out;

+       /* reserve space to fix spm overflow */
+       spm->ring_size -=3D spm_mgr->spm_overflow_reserved;
        ret =3D amdgpu_rlc_spm_acquire(adev, inst, drm_priv_to_vm(filp),
                        spm->gpu_addr, spm->ring_size);
        if (ret)
@@ -204,6 +245,7 @@ static int _amdgpu_spm_acquire(struct amdgpu_spm_mgr *s=
pm_mgr, int inst, struct
         *  and are instead part of the Meta data area.
         */
        spm->ring_size -=3D 0x20;
+       amdgpu_spm_preset(spm, spm_mgr->spm_overflow_reserved);

        goto out;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_spm.h
index 5eed6aa6482a..f00a4751643e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_spm.h
@@ -61,6 +61,8 @@ struct amdgpu_spm_mgr {
        struct amdgpu_spm_cntr *spm_cntr;
        struct work_struct spm_work;
        spinlock_t spm_irq_lock;
+       /* reserve space to fix spm overflow */
+       u32    spm_overflow_reserved;
 };

 int amdgpu_spm_ioctl(struct drm_device *dev, void *data,
--
2.34.1

