Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCB5FF8867
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 03:12:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE5AB10EA06;
	Tue, 28 Apr 2026 03:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIvDUo6O";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E170A10EA06
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:12:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTDILsYP+VTHIFZ/zxlZJeABBcYOiDMORZo0V+wV82HjAXOmgtesmDPTeOFYXNr4RzzhkPMSQMF7QSxylMEvHEAnrgjqCofbvDUEEm897ckcEkBqxU05q34P6Y+JeV7N5kti5UicE1sP/mKpDJ47atZ4QOnYCruQOFfgqzg/sw1Ya3dZxyWHAjLrXnXd20IPAYRxeD8U47ltFeSGjAUwbxIIdnZoa24FJM4ELNCtgVdIwNmQdIftpj261od4EtJYib5UYrD63/UR6XVeAFfB1ztfhtBJ76SLfiDLLndWLXw8StW3/HYz82tiir0U+c2FVS0mtEg2KLcQdDxdJ0Y80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMGG3eIqnZGxr8Jxo9nHtVOpAbMV079gsbJQRFNIFZI=;
 b=lvKGPgRZ6vsuqmTxueVL/LEXVirt4SDexIaGbHbBLkEwg7EuCMw54Tc2PlFcb5BUA9Ia2jkZg3RLIX8wF9vEXowF1P7xTMH+MW8UvfMAxkA10jSRvslFtdyseXnsRllEEuZ1aistg43Fdbz9i7jyOR27eHCUgrh4w73tGJJeSgLj3VtjCcSGHjVEtAXCBNichMKKODuSW8PPHSbYkFyVvaWWZo3GU8SwoS05NU+ISuEBZ/Be2bbQjYr8ssBshYYEi8w3zvzqrYA0Ik6Zx8nWdiorp08ar/dQjG9immSan+TgwOVzVcOlBo/1Buf+RjJRG5Mtkf14sfFd/I0nVasj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMGG3eIqnZGxr8Jxo9nHtVOpAbMV079gsbJQRFNIFZI=;
 b=XIvDUo6O+nPp84vuHEalwxjpkPhkb5Z3lI/GGXsRP8F/vDQNHdOeKrY+MW6VczXm5Qoeyx2aWXnlPHB/hAN+1NBaZBInDrDYQO3mhwfzorQEvnMo37Z6FUKpts3LQwfR0fxRlpgjadgHp7JQxfTm1ONv1xBcTYGvc59y6MBUaoM=
Received: from BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:12:35 +0000
Received: from BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325]) by BY5PR12MB4179.namprd12.prod.outlook.com
 ([fe80::2036:e8b:9b3:f325%6]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 03:12:35 +0000
From: "Ma, Bing" <Bing.Ma@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Francis, David" <David.Francis@amd.com>
CC: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Liu, Jenny (Jing)"
 <Jenny-Jing.Liu@amd.com>
Subject: RE: [PATCH v2 04/17] drm/amdgpu: add UAPI to support profiler/SPM
Thread-Topic: [PATCH v2 04/17] drm/amdgpu: add UAPI to support profiler/SPM
Thread-Index: AQHcu9QViIzR2hQOYkmjdvOMSf6T77X0AgnQ
Date: Tue, 28 Apr 2026 03:12:34 +0000
Message-ID: <BY5PR12MB4179C5BD50D86687675A6AE1FD372@BY5PR12MB4179.namprd12.prod.outlook.com>
References: <20260324212030.822932-1-James.Zhu@amd.com>
 <20260324212030.822932-5-James.Zhu@amd.com>
In-Reply-To: <20260324212030.822932-5-James.Zhu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-04-28T03:12:29.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4179:EE_|SN7PR12MB7201:EE_
x-ms-office365-filtering-correlation-id: 72afd091-318c-43ca-c42e-08dea4d3fe95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: II05loK/hSYiQ/aVZf5p55i/ugqN0OdxG1+NwiaTF7jX5roAEnXwDDQG69r2YVv3c1ffcdZFjOUqRlFMcNRBqSwC1tF1mKevguoRIIPTKkf20OzAmf4r/q99f8+wpzqOKsNci5T+JycgyV1BdHpalKthaS9q/nbpBj6bHO3aivuH5b2biTZhwSw0Kl6UxXA33BXxY3QmpYk7w2QdXaY2k2pHQobgCIDKPbg6jZB7Gi/NReg9+h1kAIvwTunD6tVOfEOzrUuXmrD3IUkPgwetjrEEIV6HyHH55qFAQYyNwsspc3pZCOtcOlUBmCCKvLawzTgASu0sKxkpj8gkOiyduglE4Zh5VWJ7el+WROE0aZBZMAH2wg9lQdkK2uGt8jaScg2G7rPG81m1ITL2xcVunOdqrmhPZMs6IA65McFu/e13XA7vCwojMgXeGsd/Nlm6sdIWi4nG76ZDP3CNTf14mJkUrzJy3GWvazNMM+mybKnnPxveZfUZvOrsqC3pz0sck0f8BqTrS4h5VyfzEXc0nIDEY4JMsWeGzG+fVq35VtrvYeL8Vn1Io4TXKbgUjdT3o3T9B3HP2E1/Q9B9jmoowhmlvtP+NAh3ZRUx5dVkPkWger0x0jifqyQWJWN8yJlXpvPvbCq99z8O4hcRrg76mf03P25EQSqXVayo21gmbDk6WzKQm7m6HIl+3BmfEUjEtqPaESK/sBUoz/lwcRnCnwXuwDVbLmtxEfW1QOcsTSVU/4BnDficFOgH1QsH9/jBCrRG3S7YfMNZHJsiKquEBxhX8aSSJz5jkl51yU0xDX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4179.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iBNH0LND0o/5aj4hEayw2+TAZupUmJCjZuI3h2Gou0xR8c7FTodLY6dbZNCk?=
 =?us-ascii?Q?iZ3kVoyOBrfuSrrpXxrmqfjr3+LO8DW4KsIUr3qKOVX3JbazXxGm1JwdRFdi?=
 =?us-ascii?Q?W6Z2wMH0Ylvea0Axblgc47z8stENowjFBZ47sOF+miGQ8KvzQBB+lGLWBjrA?=
 =?us-ascii?Q?lbNUxC51FS4IcHZg6FgEXlxhBBA+/WbL+vxikQKwfmkvrXWbJOpPQlmxBJQs?=
 =?us-ascii?Q?uGb8gBlAHThYpQ4NFBkxtoswrELfeAXLhQsUbShpZEaI6tgy8Oz0Ycunqow/?=
 =?us-ascii?Q?PQzVVd1VfA+hBN9ppcN2g+KXJKf487RTz3CE1UmAT3oQMp8fkyzLjfFHC+XO?=
 =?us-ascii?Q?EFc3Q+ux2YN3zhvkz8aStDKED/FtMUD1N7Ls2kgs5KE3jkxsOiN7i2ZX0apX?=
 =?us-ascii?Q?s5DcaeNdJ9U4DvMmi9NubD7PGJUzVbUB4LNdzrWR6xw7nB2xrBbmWggYK0iu?=
 =?us-ascii?Q?OwnPC9/yywIRHRV9f5Be0SCurWIO+ojoVwu6TYQ4YbJDv5Zve9I1lHXTi1Uh?=
 =?us-ascii?Q?lM5WzNK3IDrrRJIzeWDoz2OZ3fXmu1yiiUfXFFGcHprHDoZhMxLIOmIh7wZl?=
 =?us-ascii?Q?JE3KTwKge0BkGG6EMTG1lXt3ckIrNynrmOOSiPt8jtU92/NUIQ7zS5e5PMDm?=
 =?us-ascii?Q?xoP5RGsMGYjmgOkORLcHIpfFVK7MLtrZzys+Y7kAEcQgV8QziI3FMt6OJYqS?=
 =?us-ascii?Q?Cdtwz41Kux4i+LLS1MTlB/gyUtYcjhFguJ/3YID1EuF/CWGB0xgUd7Vxf9Ce?=
 =?us-ascii?Q?HdnXSrsjojF5tbqpjsRdVR8KnFTNw9b0oMu3pNqgwccAGi+X9l/KXYeXOSGb?=
 =?us-ascii?Q?+rjzVFlZF54M3Dg9ikm0nrDoYwVc0v9jGYQyUads0E+aRA09QIOaORlyL4Lr?=
 =?us-ascii?Q?jeY9zgH9doqlL78LixzlRHqBV0keL8/bDyh2tbxDYAA3B0Hau3w016xb1lTd?=
 =?us-ascii?Q?GE19Kl5oUY9tUx07/kZooAGnl7zGpJraTVzYp83jYZjLtgSVBHRirpAWZEzq?=
 =?us-ascii?Q?eZ5cFPRxyPZr3e5v2WG1PcEZx7W+SlP8vmsFfBwcZ088GwUpaEQCSMw/x2PM?=
 =?us-ascii?Q?5mgMRj6bG4/LwiF1Vk81A0SKy4/GO03B3rYPeyVMNlVTsx/jmGVpE7mIvZtL?=
 =?us-ascii?Q?gv80ETUDxgmJO2umiVE1zxIM41t96BX6Ep+Y1JwVFWxaQzI+JdKK0q+NSEph?=
 =?us-ascii?Q?HmVTxWfQDNZvCemXr0208ricWIKGYrxW7i33uhUpC4wstSeHVk8cv24I01lI?=
 =?us-ascii?Q?iHr3haEfvJH0hXAPL4J6DOv4i6z7vJIvNSRI3SADJgMjLjttqcbFXLLOtiW9?=
 =?us-ascii?Q?xV0vNLNV+x2012eHHBXkyWK9CXBn+oexlewjOvkdvZxDN6O+U4pIKIcDINqu?=
 =?us-ascii?Q?Hgoa1QG7FAzJ9/ynD7TU6HhKiBaiRj1Ad1/u54k6qyVEyKTYhSigjTVGohAg?=
 =?us-ascii?Q?wVDxNoUWDWlqXx52T97R6t1iw7/E8vN3y3pVmV8ZS9BlFPsSsmQP3eUz49+a?=
 =?us-ascii?Q?jffHdDe46F5Zl8TVjnXxo6oKUgx91EMqfFPEyYX3N3Rm/stzS/fE8EWlDfYR?=
 =?us-ascii?Q?bcAvZJToGAjdzRvXerx8fLNWXB7X/WkyY0fTFXxrf+iZvgYsOY2POMtTN5UC?=
 =?us-ascii?Q?BbvNJhiTQ2RLQi11dU+Ltge7C58h51ehpo2JRZa7kQ9xywH+jaMWZ5vJq7lB?=
 =?us-ascii?Q?kT5Xyov5naTAdmj0hanRwWnCUzcumHG2k+ciNzbdb+bejKNZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72afd091-318c-43ca-c42e-08dea4d3fe95
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 03:12:34.9137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCWV7lGK9lcaI7cVElk/n3zjO5O7if0OjPwhV8ThcwE0guhZOJJznMWvLXy6PwTee1R5Q3fw0r+BcsjaiqhysA==
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
Subject: [PATCH v2 04/17] drm/amdgpu: add UAPI to support profiler/SPM

to extend the DRM_AMDGPU_PROFILER ioctl to support Stream Performance Monit=
or (SPM) hardware, which streams GPU performance counter data continuously =
into a ring buffer for offline analysis.

A new operation AMDGPU_PROFILER_SPM is added to drm_amdgpu_profiler_ops, di=
spatching through the existing drm_amdgpu_profiler_args union via the new d=
rm_amdgpu_spm_args member.

Three SPM sub-operations are defined in drm_amdgpu_spm_op:
  AMDGPU_SPM_OP_ACQUIRE (0):
    Acquires exclusive access to SPM on the caller's XCP partition.
    Must be called before SET_DEST_BUF. Returns -EBUSY if another
    process already holds SPM.

  AMDGPU_SPM_OP_RELEASE (1):
    Releases exclusive SPM access, stopping the hardware and freeing
    the ring buffer, allowing another process to acquire SPM.

  AMDGPU_SPM_OP_SET_DEST_BUF (2):
    Controls the destination buffer for SPM counter streaming:
    - dest_buf=3DNULL: unsets the destination buffer and stops copying.
    - dest_buf!=3DNULL: sets a new user-space destination buffer of
      buf_size bytes. If timeout>0, the call blocks up to timeout ms
      waiting for the previous buffer to be filled; on return, timeout
      is updated with the remaining time. If timeout expires, any
      partial data is flushed and the call returns success. If timeout=3D0,
      the previous buffer is replaced immediately without waiting.
      bytes_copied reports how much data was written to the previous
      buffer. has_data_loss is non-zero if ring buffer overflow occurred.

A drm_amdgpu_spm_buffer_header structure is prepended to each dest_buf by t=
he kernel, containing the SPM version (major in bits 31:24, minor in bits 2=
3:0), bytes_copied, and has_data_loss for that buffer.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 93 +++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h =
index 2f9a5ddfe658..fc27938313d7 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1797,11 +1797,103 @@ struct drm_color_ctm_3x4 {
        __u64 matrix[12];
 };

+/*
+ * Supported SPM (Stream Performance Monitor) Operations  */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ *
+ * @AMDGPU_SPM_OP_ACQUIRE: acquire exclusive access to SPM
+ * @AMDGPU_SPM_OP_RELEASE: release exclusive access to SPM
+ * @AMDGPU_SPM_OP_SET_DEST_BUF: set or unset destination buffer for SPM
+streaming  */ enum drm_amdgpu_spm_op {
+       AMDGPU_SPM_OP_ACQUIRE,
+       AMDGPU_SPM_OP_RELEASE,
+       AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @op[in]:            specifies the operation to perform
+ * @dst_buf[in]:       used for the address of the destination buffer
+ *                      in @AMDGPU_SPM_OP_SET_DEST_BUF
+ * @buf_size[in]:      size of the destination buffer
+ * @timeout[in/out]:   [in]: timeout in milliseconds, [out]: amount of tim=
e left
+ *                      in the timeout window
+ * @bytes_copied[out]: total amount of data that was copied to the previou=
s dest_buf
+ * @has_data_loss:     non-zero if data was lost (e.g. due to ring buffer =
overflow),
+ *                      zero otherwise
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified XCP for the calling p=
rocess.
+ * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified XCP for the
+calling process,
+ * which allows another process to acquire it in the future.
+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dst_buf is NULL, the destination buffer address is unset and
+copying of counters
+ * is stopped.
+ *
+ * If @dst_buf is not NULL, it specifies the pointer to a new destination =
buffer.
+ * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for
+the previous
+ * buffer to be filled. If previous buffer to be filled before timeout,
+the @timeout
+ * will be updated value with the time remaining. If the timeout is
+exceeded, the function
+ * copies any partial data available into the previous user buffer and ret=
urns success.
+ * The amount of valid data in the previous user buffer is indicated by @b=
ytes_copied.
+ *
+ * If @timeout is 0, the function immediately replaces the previous
+destination buffer
+ * without waiting for the previous buffer to be filled. That means the
+previous buffer
+ * may only be partially filled, and @bytes_copied will indicate how
+much data has been
+ * copied to it.
+ *
+ * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss wi=
ll be non-0.
+ *
+ * Returns negative error code on failure, 0 on success.
+ */
+struct drm_amdgpu_spm_args {
+       __u64 dest_buf;
+       __u32 buf_size;
+       __u32 op;
+       __u32 timeout;
+       __u32 bytes_copied;
+       __u32 has_data_loss;
+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for
+drm_amdgpu_spm_args->dest_buf
+ *
+ * @version        [out]: spm version
+ * @bytes_copied   [out]: amount of data for each sub-block
+ * @has_data_loss: [out]: boolean indicating whether data was lost for eac=
h sub-block
+ *                        (e.g. due to a ring-buffer overflow)
+ */
+struct drm_amdgpu_spm_buffer_header {
+       __u32 version; /* 0-23: minor 24-31: major */
+       __u32 bytes_copied;
+       __u32 has_data_loss;
+       __u32 reserved[5];
+};
+
 /*
  * Supported Profiler Operations
  */
 enum drm_amdgpu_profiler_ops {
        AMDGPU_PROFILER_VERSION =3D 0,
+       AMDGPU_PROFILER_SPM,
 };

 struct drm_amdgpu_profiler_args {
@@ -1809,6 +1901,7 @@ struct drm_amdgpu_profiler_args {
        __u32 pad;
        union {
                __u32 version;          /* lower 16 bit: minor. higher 16 b=
it: major */
+               struct drm_amdgpu_spm_args spm;
        };
 };

--
2.34.1

