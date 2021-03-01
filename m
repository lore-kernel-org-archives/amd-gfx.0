Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A463C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:57:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D6164E54
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D6164E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79486E566;
	Mon,  1 Mar 2021 09:57:03 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760052.outbound.protection.outlook.com [40.107.76.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099446E566
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PP4ACfX85TjH0DfHltf4rfaYGF+cr5Z9nS/lGY6q2Ol0JvC6jruxayDrXkVoJeQbqTjTEenVDJWs0vA/DPMyVtEfU6M/jH1ZEqK2wiXbhSNDHJjiqIKBsWNqWOZpnl0/B6Iv0pYPOmaPGQyPdzGL2aJ5BBeTZhdByoRqVf5UMd0ga3SBkL31yv5Jjo9jS1R2fwz8UP3n+Gtw5IUnYg1ZwY+75PlTN5MieivosK9dkb2udaBq/CQu2Dq/IWLA0Tdg/lZLf0kg21eKqJMNCMfrOQcRjMXQQiAC/yEspbE4cKCy1Eog6U0u6P/sg5zDHRojJUzlKjAJAZ1zCpPkLdTFxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH3qVlUOzsU5tm7eXqavF2xCxLvZATf4UR7UFvrrppA=;
 b=ON/R3sPg0qAmNF2DEwZK/1tMiInh4QwaVACUeM7YLwrvyrcFEKWxHlp1wqTZ33pcVbII7VHj3IhvusowB23mPRoiQwe8nAYp9dHSxLHGEcPxMI8PYDXAODeXUcKNgKMP5R+IxVbpisgdIzd1FA07/2GzLAVcMmKPM82GyouvVsCxRfSFmB1QnPYMwNm9spuFIWcO872dxyLK2e6uAVMRHFfluMZ1KDcXifZKbqkH/AziWrGUdoidnNeJDCYf7YNJeNPhyeOLS97JMzWvDfjq0abYVr3lUY4gpIasNgQL7fqH+LEZSrjZNm/WZunNQdgRfaDd5KpDEOX564RHCrKIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mH3qVlUOzsU5tm7eXqavF2xCxLvZATf4UR7UFvrrppA=;
 b=Nb8REFMjzp5nTNx3aiXjnyFWh2HCg7Ogvx1eDhqVlHcOhilILxMciHmBVt2cZDzYTkqqWzfbNjGKHdlTioNttFSFk1x6ot7DR8YDTiZyCFuHxRR5w0JgxT/HGh5J3dwvDINCHsl/LK6nODhsYmdpU1A4MclLyt+6IoY0BkGc1NI=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 09:57:01 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 09:57:01 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in
 debugfs
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in
 debugfs
Thread-Index: AQHXDnqpANzJQErQMEaUr8Puv9Ti8apu3kIAgAAGuxU=
Date: Mon, 1 Mar 2021 09:57:01 +0000
Message-ID: <MN2PR12MB302244FD1F704692CE77660FA29A9@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210301090951.43956-1-kevin1.wang@amd.com>,
 <DM6PR12MB407548F416DADBEAB2ABDCFAFC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB407548F416DADBEAB2ABDCFAFC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T09:57:00.610Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb565f98-4b4d-4684-1e88-08d8dc985c25
x-ms-traffictypediagnostic: MN2PR12MB3232:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB323291C7FCD06E71D70A3AA3A29A9@MN2PR12MB3232.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: be3Xz1KpK3UOK0/nFOncA2CCE5NomuR6b5NTLGS1ewcvh+wgzD44vMbo3dEZA2G2fX2+W+jOatKwimD3vcvxQhy5+ecz7VW8vVf9LD5c48IXJiwhq39p0oqHU47aPIDYHJYd8j6ZbKXgCo70Vm5jmQb/MU8tRPQLH5AoOCRJlJWnrrxlDGMFEqB9V9YclHJoKkYw2PnLyUFChjD2gT5lQZnrg2tdDaQtrS+EZtXfahlogm9WfsZKd6go8PTcLM3TT6q4gTtYC+kp7e1n6WfWiqR39TPzi3UvfSpKqq8wRrCn+LwiIlekAXN8+CeRM3gtWDhEanzEkWgZ2bWrTlVW3xEjII0w0x0ZKzDckhmHK8DHnMuThdQLBLn/BWK+rUy3M0sdRZ9ut/yOJBaX/ooiuUS7OdlhsDSu2/+sEJxovqyCs1Hb0ukrraOO2Thm61xcm336ZiiUQysDax/MSlvoQUf2idBzjQKBskKS/I0MlzhBV+KwxXZX54d3c1jsCEHK9jTGi5F+wDszCUCfV/wwuw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(5660300002)(110136005)(64756008)(71200400001)(478600001)(2906002)(55016002)(86362001)(26005)(66946007)(91956017)(6506007)(186003)(52536014)(316002)(9686003)(8676002)(33656002)(76116006)(8936002)(83380400001)(66476007)(19627405001)(53546011)(66556008)(7696005)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Wuxgk73D/IwvjmvDUnY2d0hMAlgOMr948U3H02LGIMZr9H/+AKBYOoyYRs?=
 =?iso-8859-1?Q?tj4bOWkuLSnPE8kvbVOfy90zJCcrbpbu9lP0GN02VZJNEUmSplgPQZlyM8?=
 =?iso-8859-1?Q?euizv/7DS7EIOreeIS+kSO6+YjOy6yDX67a1moCs2sxtZIZBLGPYGi7kWx?=
 =?iso-8859-1?Q?XNEt3Mxbhu+4e2pzh6bYJe+xhon66K/78Kt+cLdzRniTYASzlL4UoWoxT1?=
 =?iso-8859-1?Q?haKY8ixtyfy2YD2TJYRHhZFdvdHLKu39Of047dr+6c4FPWApNiaT++sNh8?=
 =?iso-8859-1?Q?EQ2jA6iDXk2EmQjNXe5WDrPR6mGsZbhl+r6qvw9iSxTYc15wMq4pYRg69e?=
 =?iso-8859-1?Q?JdVSFKhuNTFKjJOUgosb3XfeXRMoV33eCeu7sSi6KkbBOU/bU/2xE52k+d?=
 =?iso-8859-1?Q?I7ZG4iBCn+MJffMu1c5hEf4krjxu6pz8OzLzfH4zpV8yDIHEr61XHezwXL?=
 =?iso-8859-1?Q?ph7aXU+WVxzV8d+FdS3ao4BzaLLvJoX9Muyl5xsTKX/pn/4D6TU3GYSr7/?=
 =?iso-8859-1?Q?yaFIibut8mPJV+Z2hPv4ralnKjxzgc8EiNmi7sRCwnC8qA7yfkT1CfwzUQ?=
 =?iso-8859-1?Q?LB1DHlS0enZxfNqLEhrO5LXqOKoTSnadTKE876an0p3YxjJ+QO9XnyhPCH?=
 =?iso-8859-1?Q?gCg/UBgwQvtsh4a2t0KP7eVDS6762LYKUtnuV8yoz+c+wqKMRzSlXFmqNt?=
 =?iso-8859-1?Q?EcSSZTnPOp5c3zrKLPiZkVmrTMYp6/WVkUjAQwhbswrWoIUBRcBqkPyb8N?=
 =?iso-8859-1?Q?ShzcL4VSDrIfRPIZl7+OwDiBO41hlIk3CwkwVZPR6lUjhKkIFFuPLPezNB?=
 =?iso-8859-1?Q?QmsO434MQKi9LtXnk5aKD4Cn0KtFnTcIQsIy1jyv9O6ms1FR2NoJ4L3qER?=
 =?iso-8859-1?Q?rmomN/Crq+ncAPZmBvf9KJ2111E0a9AmKasl2HmDxb/KJGe7hRkovFhyE9?=
 =?iso-8859-1?Q?EMWDGdA17EHxfIWorFFrc+IJIBMCzZfUPQ2KcFVJOkdXEArCzzEs8Sh0Dd?=
 =?iso-8859-1?Q?9Qm4CzNuP2/0gBCpjnRHF8B0pR9/3ZZpuvbFOTIGtoaC/HGtZ81/oEOCl9?=
 =?iso-8859-1?Q?hcrH3PQf2pPywfHzXQwimLqDE6C8XlywPoI8gzJYmju1+PjNNyDls5BJzQ?=
 =?iso-8859-1?Q?DGELClo71qHlRBAEocK+beDgG4QCwq0eZH2ytc30XeQhrfERQb+W5FYpjt?=
 =?iso-8859-1?Q?CBYMu4Cetg7/zdIjeYgiffbMkzsxIyfi0ZKsW+SfJyoB35/lsZxCPLGiQo?=
 =?iso-8859-1?Q?XCrf8u9E1RBCt896ujGG7GrbOwFOv9791eKKvMd1z5B9UBr4imm+B8nt0x?=
 =?iso-8859-1?Q?AZLIKhrmfYmHk8FQNMrbHgVMdbppGx/5s1IYebPCKZ7hGYM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb565f98-4b4d-4684-1e88-08d8dc985c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 09:57:01.0812 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2mbkHmE5avA7gf1wiCIZs8t6gfaH5mLQ6pxKlYKb9MPY6YMEZtzNIWHw2GBS6+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
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
Content-Type: multipart/mixed; boundary="===============0942418149=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0942418149==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB302244FD1F704692CE77660FA29A9MN2PR12MB3022namp_"

--_000_MN2PR12MB302244FD1F704692CE77660FA29A9MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]



________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Monday, March 1, 2021 5:31 PM
To: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; amd-gfx@lists.freedesktop.org =
<amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in d=
ebugfs

[AMD Public Use]

+       for (i =3D TA_FW_TYPE_PSP_ASD; i < TA_FW_TYPE_PSP_COUNT; i++) {

I think we still rely on AMDGPU_INFO_FW_ASD to query ASD firmware version. =
Therefore, we need to start from TA_FW_TYPE_PSP_XGMI.

[kevin]:
thanks, yes,  the ASD is different with other TAs, I will correct it before=
 submitting.

+       TA_FW_TYPE_PSP_COUNT,
+       static const char *ta_fw_name[TA_FW_TYPE_PSP_COUNT]

The enum is a little bit confusing, might rename to TA_FW_TYPE_MAX_INDEX,

Regards,
Hawking

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Sent: Monday, March 1, 2021 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@=
amd.com>
Subject: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in debug=
fs

refine PSP TA firmware info print in amdgpu_firmware_info().

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   | 50 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 2 files changed, 21 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c
index 6c8ea9d26320..1a27673271b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -289,23 +289,23 @@ static int amdgpu_firmware_info(struct drm_amdgpu_inf=
o_firmware *fw_info,
                 break;
         case AMDGPU_INFO_FW_TA:
                 switch (query_fw->index) {
-               case 0:
+               case TA_FW_TYPE_PSP_XGMI:
                         fw_info->ver =3D adev->psp.ta_fw_version;
                         fw_info->feature =3D adev->psp.ta_xgmi_ucode_versi=
on;
                         break;
-               case 1:
+               case TA_FW_TYPE_PSP_RAS:
                         fw_info->ver =3D adev->psp.ta_fw_version;
                         fw_info->feature =3D adev->psp.ta_ras_ucode_versio=
n;
                         break;
-               case 2:
+               case TA_FW_TYPE_PSP_HDCP:
                         fw_info->ver =3D adev->psp.ta_fw_version;
                         fw_info->feature =3D adev->psp.ta_hdcp_ucode_versi=
on;
                         break;
-               case 3:
+               case TA_FW_TYPE_PSP_DTM:
                         fw_info->ver =3D adev->psp.ta_fw_version;
                         fw_info->feature =3D adev->psp.ta_dtm_ucode_versio=
n;
                         break;
-               case 4:
+               case TA_FW_TYPE_PSP_RAP:
                         fw_info->ver =3D adev->psp.ta_fw_version;
                         fw_info->feature =3D adev->psp.ta_rap_ucode_versio=
n;
                         break;
@@ -1355,6 +1355,17 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)
         struct atom_context *ctx =3D adev->mode_info.atom_context;
         int ret, i;

+       static const char *ta_fw_name[TA_FW_TYPE_PSP_COUNT] =3D { #define
+TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] =3D #type
+               TA_FW_NAME(ASD),
+               TA_FW_NAME(XGMI),
+               TA_FW_NAME(RAS),
+               TA_FW_NAME(HDCP),
+               TA_FW_NAME(DTM),
+               TA_FW_NAME(RAP),
+#undef TA_FW_NAME
+       };
+
         /* VCE */
         query_fw.fw_type =3D AMDGPU_INFO_FW_VCE;
         ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev); @@ -1472,=
35 +1483,14 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file=
 *m, void *unused)
                    fw_info.feature, fw_info.ver);

         query_fw.fw_type =3D AMDGPU_INFO_FW_TA;
-       for (i =3D 0; i < 5; i++) {
+       for (i =3D TA_FW_TYPE_PSP_ASD; i < TA_FW_TYPE_PSP_COUNT; i++) {
                 query_fw.index =3D i;
                 ret =3D amdgpu_firmware_info(&fw_info, &query_fw, adev);
                 if (ret)
                         continue;
-               switch (query_fw.index) {
-               case 0:
-                       seq_printf(m, "TA %s feature version: 0x%08x, firmw=
are version: 0x%08x\n",
-                                       "RAS", fw_info.feature, fw_info.ver=
);
-                       break;
-               case 1:
-                       seq_printf(m, "TA %s feature version: 0x%08x, firmw=
are version: 0x%08x\n",
-                                       "XGMI", fw_info.feature, fw_info.ve=
r);
-                       break;
-               case 2:
-                       seq_printf(m, "TA %s feature version: 0x%08x, firmw=
are version: 0x%08x\n",
-                                       "HDCP", fw_info.feature, fw_info.ve=
r);
-                       break;
-               case 3:
-                       seq_printf(m, "TA %s feature version: 0x%08x, firmw=
are version: 0x%08x\n",
-                                       "DTM", fw_info.feature, fw_info.ver=
);
-                       break;
-               case 4:
-                       seq_printf(m, "TA %s feature version: 0x%08x, firmw=
are version: 0x%08x\n",
-                                       "RAP", fw_info.feature, fw_info.ver=
);
-                       break;
-               default:
-                       return -EINVAL;
-               }
+
+               seq_printf(m, "TA %s feature version: 0x%08x, firmware vers=
ion: 0x%08x\n",
+                          ta_fw_name[i], fw_info.feature, fw_info.ver);
         }

         /* SMC */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 46449e70348b..c03f32ec3ebc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -136,6 +136,7 @@ enum ta_fw_type {
         TA_FW_TYPE_PSP_DTM,
         TA_FW_TYPE_PSP_RAP,
         TA_FW_TYPE_PSP_SECUREDISPLAY,
+       TA_FW_TYPE_PSP_COUNT,
 };

 struct ta_fw_bin_desc {
--
2.17.1

--_000_MN2PR12MB302244FD1F704692CE77660FA29A9MN2PR12MB3022namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Monday, March 1, 2021 5:31 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt;; amd-gfx@lists.fre=
edesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info pri=
nt in debugfs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D TA_FW_TYPE_PSP_ASD; i &lt;=
 TA_FW_TYPE_PSP_COUNT; i++) {<br>
<br>
I think we still rely on AMDGPU_INFO_FW_ASD to query ASD firmware version. =
Therefore, we need to start from TA_FW_TYPE_PSP_XGMI.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">thanks, yes,&nbsp; the ASD is different with other=
 TAs, I will correct it before submitting.</div>
<div class=3D"PlainText"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_COUNT,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *ta_fw_name[TA_FW_T=
YPE_PSP_COUNT]</div>
<div class=3D"PlainText"><br>
The enum is a little bit confusing, might rename to TA_FW_TYPE_MAX_INDEX, <=
br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.com&gt; <br>
Sent: Monday, March 1, 2021 17:10<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Wang, Kevin(Yang) &lt;Kev=
in1.Wang@amd.com&gt;<br>
Subject: [PATCH 1/2] drm/amdgpu: refine PSP TA firmware info print in debug=
fs<br>
<br>
refine PSP TA firmware info print in amdgpu_firmware_info().<br>
<br>
Signed-off-by: Kevin Wang &lt;kevin1.wang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp; | 50 +++++++++---=
-----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |&nbsp; 1 +<br>
&nbsp;2 files changed, 21 insertions(+), 30 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_kms.c<br>
index 6c8ea9d26320..1a27673271b0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
@@ -289,23 +289,23 @@ static int amdgpu_firmware_info(struct drm_amdgpu_inf=
o_firmware *fw_info,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_INFO_FW_TA:<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; switch (query_fw-&gt;index) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 0:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case TA_FW_TYPE_PSP_XGMI:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;ver =3D adev-&gt;psp.ta_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;feature =3D adev-&gt;psp.ta_xgmi_ucode_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case TA_FW_TYPE_PSP_RAS:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;ver =3D adev-&gt;psp.ta_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;feature =3D adev-&gt;psp.ta_ras_ucode_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case TA_FW_TYPE_PSP_HDCP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;ver =3D adev-&gt;psp.ta_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;feature =3D adev-&gt;psp.ta_hdcp_ucode_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 3:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case TA_FW_TYPE_PSP_DTM:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;ver =3D adev-&gt;psp.ta_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;feature =3D adev-&gt;psp.ta_dtm_ucode_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 4:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case TA_FW_TYPE_PSP_RAP:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;ver =3D adev-&gt;psp.ta_fw_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_in=
fo-&gt;feature =3D adev-&gt;psp.ta_rap_ucode_version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
@@ -1355,6 +1355,17 @@ static int amdgpu_debugfs_firmware_info_show(struct =
seq_file *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_context *ctx =
=3D adev-&gt;mode_info.atom_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *ta_fw_name[TA_FW_T=
YPE_PSP_COUNT] =3D { #define <br>
+TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] =3D #type<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(ASD),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(XGMI),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(RAS),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(HDCP),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(DTM),<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; TA_FW_NAME(RAP),<br>
+#undef TA_FW_NAME<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* VCE */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query_fw.fw_type =3D AMDGP=
U_INFO_FW_VCE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_firmware_in=
fo(&amp;fw_info, &amp;query_fw, adev); @@ -1472,35 +1483,14 @@ static int a=
mdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_info.feature, fw_info.ver);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; query_fw.fw_type =3D AMDGP=
U_INFO_FW_TA;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 5; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D TA_FW_TYPE_PSP_ASD; i &lt;=
 TA_FW_TYPE_PSP_COUNT; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; query_fw.index =3D i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_firmware_info(&amp;fw_info, &amp;query=
_fw, adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; switch (query_fw.index) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;TA %s feature version: 0x%08x, firmware version: 0x%08x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;RAS&quot;, fw_info.feature, fw_info.ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;TA %s feature version: 0x%08x, firmware version: 0x%08x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;XGMI&quot;, fw_info.feature, fw_info.ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;TA %s feature version: 0x%08x, firmware version: 0x%08x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;HDCP&quot;, fw_info.feature, fw_info.ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;TA %s feature version: 0x%08x, firmware version: 0x%08x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;DTM&quot;, fw_info.feature, fw_info.ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; case 4:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_printf(m, &q=
uot;TA %s feature version: 0x%08x, firmware version: 0x%08x\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;RAP&quot;, fw_info.feature, fw_info.ver);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; seq_printf(m, &quot;TA %s feature version: 0x%08x, firmware vers=
ion: 0x%08x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ta_fw_name[i], fw_info.feature, fw_info.ver);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* SMC */<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h<br>
index 46449e70348b..c03f32ec3ebc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
@@ -136,6 +136,7 @@ enum ta_fw_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_DTM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_RAP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_SECUREDISPL=
AY,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_COUNT,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct ta_fw_bin_desc {<br>
--<br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB302244FD1F704692CE77660FA29A9MN2PR12MB3022namp_--

--===============0942418149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0942418149==--
