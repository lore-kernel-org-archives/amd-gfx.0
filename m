Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743C4C3ABCB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 06:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E3210E1DC;
	Wed, 14 May 2025 06:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I8MqgP5E";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148C710E1B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 06:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCox4mjE5+o5cdvaD1gacpxdQfdwLhNqcQMqTEcjLYKEF37ZF8AzEEOi/Dbz/kM/KOsKm/iH6QADIrLfjG9j8vnNxIP9mZwbTX7uEvDphZIsvewaZ4klk7lXsPkUctuBflKvt60Apylk7E3tFM98UZUo0t3SocClxuTAECxWV5Gj3NOx4qyHfFdG5Bvsed5Rdy8hEqj1jop5+FfHHeKi6axBdskHjxlNHiaFgaRUmufs4Ev55UsffyeGtCue2Q9ThYEWbfvFErxvGjjJSLz823AS08oPYO2TGdmEpEmbghELT6ckay0pllVpd5d9mpVGmDAYjnKHJRwpcg6DijjM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJmMMeAYUyJIzc0WhZWRo23QnBE6cQEZwCaC5OOeCTs=;
 b=l8HXNQA2z2GUFsp+EluGn703Uw4GCudqLQSqc+SMAWhgUOlGawkDlGqatGwGafM9+xmfpV4fPU4agnTsLFzcpUfS3oTo+x7vO2eBVAGh54Snh6Nck4cT7/Y4X7WO6BQzICDSsW6RA5nGXYncScu3DsGUeEK/u7uTCtiyhN7p/iDMbaR+vMneg7aFAaG2x0CXE7sCZ011TGrWmzpmQMTqPSVABRioMbk0SRZ3rirYEULFDSFkKqlDo2GNa2qonv/kXHm4rrVecwPKAw+iePO4AQc55VDO+kO8CduqVaBsl7ujFNhJ4ZrOZJkNTq6Vu5+m/AbKuhwINaKVp0WNCGSnwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJmMMeAYUyJIzc0WhZWRo23QnBE6cQEZwCaC5OOeCTs=;
 b=I8MqgP5EIQ38jYga0OJ5EGAJJwk5bpkNp96rT8UUgxRP7Q/GXhRmMBSKmQMJ9VDJOFBnKo2dp3ACdHh9KwJrKo5AIG16qTnH/gvo6mCFlNjzvX5e3hT+Z2Hbv+iqEtRH4r3On/CqlsaODAH+IYCOGrD5LW82TesGvP6G7gxjyAk=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 06:51:44 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 06:51:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Topic: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump
Thread-Index: AQHbxJiCS8Pkw1XojUegatcyYQ2iHLPRsAbw
Date: Wed, 14 May 2025 06:51:43 +0000
Message-ID: <BN9PR12MB5257580F837627DDAF924933FC91A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250514062145.82529-1-shiwu.zhang@amd.com>
In-Reply-To: <20250514062145.82529-1-shiwu.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7caa2033-2511-4ac7-a4f5-343f25455a6e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-14T06:51:24Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7379:EE_
x-ms-office365-filtering-correlation-id: 32c02ee6-d514-4a1d-a2a8-08dd92b3c9d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?NfotbmcW6Oei00UbN+ksw+kpOgxTbiq8YSGCICbqGxuneSbIDG9NwfRRkvVe?=
 =?us-ascii?Q?vjGc6vkKHRNpFlGabKsVTX3wG1RR2LNG8C3i0OcWwvNsm+ALVQSLRIPFpkYq?=
 =?us-ascii?Q?nQHrZD2SY66GqUbS16u8EXebbTkZNW7GMfAppS2zgx5b4b00cAlqL5LKhL/G?=
 =?us-ascii?Q?UHBPKN1sA8wu0nvzRbyNDn3J7V8YktIMuOOy4E9Gqq23SkJYKTh0fYNmC20c?=
 =?us-ascii?Q?mOUQiMIMLu0iR23barj/GAyMuxc4WFvOGGPVnN1bcpYka1kgku9nWU5D3+dn?=
 =?us-ascii?Q?CFsDHd63BE+ebx1/wfAQ+tAYBNw+3OfgjgYYID+ryxW1L692r0C0izbzTSDW?=
 =?us-ascii?Q?UzyGEdfyCqprEAeW3DnGkumewz/WdncvZlI6PqqLdsGxNxq/2/P7bukD3NyM?=
 =?us-ascii?Q?IcAStyivmGGWwIr/LzzUmhFHtGparsf+d16qUg0gCkghW9rCl38cbz0mv7R6?=
 =?us-ascii?Q?PX4NCZSM9LVbYmm10OHoYbd1CcaS+GMEAQRbIY7J0kFNVEdEuOyKrDdsrRiC?=
 =?us-ascii?Q?0EY4fbl6u46CQIx1Xuv3aDJ6BAUZ5Mw9IUS+8o6kImLi1VCMfKZ5qKuzwFTG?=
 =?us-ascii?Q?sucw14PWrX3FL3eGQdnxb3YDDVcFUBV2TQyCv8ktCl7jdqGS8Yiss+6sV25B?=
 =?us-ascii?Q?xIHXaGNJ8jiCl7YSUwI9fAvVyRvfX+RUFHpUq/qu9TZv8rYm1A8CLoLTiEPy?=
 =?us-ascii?Q?lDUOhNifCIgERXjDgTO3jCq9v1yLUEmNp2sfDxc3acm8bgA/7BlzdDVsakoQ?=
 =?us-ascii?Q?AC4+9aqoMY5u3iBOYsHBJVU3YEX8h924Vlf//EyfYaEHNZubte4HW+MLpAoV?=
 =?us-ascii?Q?qWklKS/m0PomhH0Y3GGP1Jayunqopi468qeLd9goxD8KKLF5pOTGjwwbpLnY?=
 =?us-ascii?Q?XkEa1VP8Qul8V5ytHy2v99OlFTaya7wXeSdgbC4aBf2rHl64cHFx6mG4XdxP?=
 =?us-ascii?Q?mZpsmqUUuJ1MBCAGPv5M4az6PLyf/TPPE39EFGazgiKZYT1UFx4zZ0/N72mL?=
 =?us-ascii?Q?3NrbA6B+oxTX/OGvFmSoVvbLIA0Jf4WKKd4ofzdyMRGCfXu2n/JkyyB+oeML?=
 =?us-ascii?Q?H4iAWNO1MGw6pzePaz1pGLqvD41klZ0cOPvQj9CYFIAZ0eDIIWp8DgRDPGcJ?=
 =?us-ascii?Q?4FwH6B5lQpoosoXLrubXC30QRVCL2LsNH/MTJUU/Dd75O5JfVErpd0/uMqZh?=
 =?us-ascii?Q?H6uRLKZdqy6tLigshhmK3+BJSEfcCn7eBShWUjr8akhQUd7yaQtpkE/ysy24?=
 =?us-ascii?Q?pManAHwK5SiIPKIfdmyAMW1JT1SFHE1okMnY7dYUqmbpb8e4XYmqPDwLnhir?=
 =?us-ascii?Q?kbOqXvokPy3DQYzQY/6o8GWgGeSVC6RtQ8VX7KBkbHYAPGPwXj1wyf2hZowp?=
 =?us-ascii?Q?JUSU8hzve9tdQE/sy+KfleYkgXW6ml1N/0YcBZ0RLarRcNCq5Sx4UYl7/5AJ?=
 =?us-ascii?Q?kC1WEOvMwqTdB6xMRYg9rPbMwJfsn2QDCzXgBBYo8ri6RfSXwAsrHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PQ1tRR4c8NsyfXehGIYtShl0f4xD3PFfJVIp1kvbJX01OMUl7F3Q2BXai/ud?=
 =?us-ascii?Q?jf4MpZQ4Z5p7EA6KM3tCcEn7/NJ+o05O8VL6AoMizAtCvi9L+mDZCzOyzArS?=
 =?us-ascii?Q?yw0cOp8MQU/7Tfbt6PWuw7aVB/+jU6OJJj9D1LKQJRHMPnYrP76e13nqwtLI?=
 =?us-ascii?Q?JFlMAkYW1K5akVFUF2/TNBrkhZN8ZIwN3cDXTb+oOxM+JeGjl4z53lEkPqNt?=
 =?us-ascii?Q?oqJs7BF78wC4lkvTFFXbxGCTJbuMXkkVpRJr+xQMY/OwSrydPPjKqI/xckXI?=
 =?us-ascii?Q?zDkJVI+zk+tWL7Cx5CWwBHNWOCqQ6e+w4gBCRm2mSQgfnnq+D/yivkJTnLFK?=
 =?us-ascii?Q?IzJ514yDQyKAAjubLVHvQVrgXtZBiT3dUBJsa8wRsFBrZ30xNr2H5LCbeU1y?=
 =?us-ascii?Q?ChNr0MwFybjdPtLGqvEFV5RtzORV9wQEYGKfu3+OzqHEFoV2M7X+sZ0pKq4/?=
 =?us-ascii?Q?fZ8q7s14DJWBmPhkt93CQ4ZpEgRtyeRv5tEV0UJK9QoU3XBU9jzaV3etdegK?=
 =?us-ascii?Q?c0v9Hme9x+owHA94gARVSEm5FRSxLw4NArQgg6iKLC8S/RNlYxR8PfyqwHv6?=
 =?us-ascii?Q?klRwxrXwmXOvqbKFAMLLvPZh4Zd2qNgDYowo5in90EidnnlDERWdG6qxisf5?=
 =?us-ascii?Q?fKRCyIUVQAWsYQ4ih1eQTNmTU6PU75smPtswsRO1mMRp/zVwx6fzV7rwlTpw?=
 =?us-ascii?Q?/yxsPHsjEXXGnSw7v93hmyulP6cOEJd2KqZhMxCoQ2enkC5v2gkdFnXo4Lo7?=
 =?us-ascii?Q?aHaMLzaLybuMc1QvBUZjBnJ40WajEgVRxDEw2u9a/mnQM1nBk1byMkysNuK1?=
 =?us-ascii?Q?QI5RuP4QzpdRWSarJcJkK46GYQkhkSNvqnjQ0Au1Owgk4XmA3Dc1hmKp6qU7?=
 =?us-ascii?Q?FHnGnlM2AY7JVLTvfra7y+XAI0MP4/wf5IBxfYnUmM3U79F00QqMVGPANGys?=
 =?us-ascii?Q?cuByNL6pwBQWWtinvn2mVhjMXMKxMYVGfrC66eej+rmrNaWYMBgyEDWPGrBa?=
 =?us-ascii?Q?pEkLGYaftbM7M5eG/RqtTmtb3Ss3X8rl0LhMX6T1aTt+DislU5v+0UzcmB4P?=
 =?us-ascii?Q?lGCH8+OisJLLv67MRh811zNGvzo4nGASzyQQTR3THMkxegsl5zo9JbdMaRIy?=
 =?us-ascii?Q?R4rcmCmCOz0K+0rkBQLhq4/esQS8nVfzWCxP4GfUHwmRzmOgIAEvM+B+YTO3?=
 =?us-ascii?Q?E1y99eRR+rznebtZ2/yHgFuuNccBZiV8SfefoL9N7bVcLUA7KKyOmmLkAtOJ?=
 =?us-ascii?Q?sVrUJX7DYrVnFFQMDKjta4Ei/+WIsY3uc9ZAIoN4dyZ/YuypijWjgRItozx8?=
 =?us-ascii?Q?HzJnj6poKcFzPQCVvvR2isgWAzlCLMRKz8MMKRxOGFDSDZ2jzKQ1GIuGUhS7?=
 =?us-ascii?Q?kJHVYK+fC69OtQv48K70LeeBepiLiGWSGUp+Y1uhYan8RWhzlOcJ0cwOx3DW?=
 =?us-ascii?Q?Uuw90A6ZhvyKerhWZVTbNzujPHF1G24vQhP+oCi2s/XsFq4tMBdtzA3gFV+t?=
 =?us-ascii?Q?ctYthiEYE+D9OVIo052y2LnVK5EzXmXLizg1DZgshTcufmvPCpA8XxVrJ1uJ?=
 =?us-ascii?Q?v4dqSABkCIVgGAna2BQOiJ5WOFWoAU6h9OuvwxLl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c02ee6-d514-4a1d-a2a8-08dd92b3c9d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 06:51:43.8680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0nOPkj+muWQow3k4wNbXHeUDJgHBYl1AiNhHR3pM7ZiSVkb/nNHEui1ygFfFXLlBzzdbPzu33/n74Fw0gQT6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com>
Sent: Wednesday, May 14, 2025 14:22
To: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>;=
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: add debugfs for spirom IFWI dump

Expose the debugfs file node for user space to dump the IFWI image on spiro=
m.

For one transaction between PSP and host, it will read out the images on bo=
th active and inactive partitions so a buffer with two times the size of ma=
ximum IFWI image (currently 16MByte) is needed.

v2: move the vbios gfl macros to the common header and rename the
    bo triplet struct to spirom_bo for this specfic usage (Hawking)

v3: return directly the result of last command execution (Lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c     | 104 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h     |  29 ++++++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c      |  44 +++++++--
 4 files changed, 168 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 4835123c99f3..bfa3b1519d4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2113,6 +2113,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
        amdgpu_rap_debugfs_init(adev);
        amdgpu_securedisplay_debugfs_init(adev);
        amdgpu_fw_attestation_debugfs_init(adev);
+       amdgpu_psp_debugfs_init(adev);

        debugfs_create_file("amdgpu_evict_vram", 0400, root, adev,
                            &amdgpu_evict_vram_fops);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 6f9bcffda875..3a27ce75f80c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4185,6 +4185,110 @@ const struct attribute_group amdgpu_flash_attr_grou=
p =3D {
        .is_visible =3D amdgpu_flash_attr_is_visible,  };

+#if defined(CONFIG_DEBUG_FS)
+static int psp_read_spirom_debugfs_open(struct inode *inode, struct
+file *filp) {
+       struct amdgpu_device *adev =3D filp->f_inode->i_private;
+       struct spirom_bo *bo_triplet;
+       int ret;
+
+       /* serialize the open() file calling */
+       if (!mutex_trylock(&adev->psp.mutex))
+               return -EBUSY;
+
+       /*
+        * make sure only one userpace process is alive for dumping so that
+        * only one memory buffer of AMD_VBIOS_FILE_MAX_SIZE * 2 is consume=
d.
+        * let's say the case where one process try opening the file while
+        * another one has proceeded to read or release. In this way, elimi=
nate
+        * the use of mutex for read() or release() callback as well.
+        */
+       if (adev->psp.spirom_dump_trip) {
+               mutex_unlock(&adev->psp.mutex);
+               return -EBUSY;
+       }
+
+       bo_triplet =3D kzalloc(sizeof(struct spirom_bo), GFP_KERNEL);
+       if (!bo_triplet) {
+               mutex_unlock(&adev->psp.mutex);
+               return -ENOMEM;
+       }
+
+       ret =3D amdgpu_bo_create_kernel(adev, AMD_VBIOS_FILE_MAX_SIZE_B * 2=
,
+                                       AMDGPU_GPU_PAGE_SIZE,
+                                       AMDGPU_GEM_DOMAIN_GTT,
+                                       &bo_triplet->bo,
+                                       &bo_triplet->mc_addr,
+                                       &bo_triplet->cpu_addr);
+       if (ret)
+               goto rel_trip;
+
+       ret =3D psp_dump_spirom(&adev->psp, bo_triplet->mc_addr);
+       if (ret)
+               goto rel_bo;
+
+       adev->psp.spirom_dump_trip =3D bo_triplet;
+       mutex_unlock(&adev->psp.mutex);
+       return 0;
+rel_bo:
+       amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr,
+                             &bo_triplet->cpu_addr);
+rel_trip:
+       kfree(bo_triplet);
+       mutex_unlock(&adev->psp.mutex);
+       dev_err(adev->dev, "Trying IFWI dump fails, err =3D %d\n", ret);
+       return ret;
+}
+
+static ssize_t psp_read_spirom_debugfs_read(struct file *filp, char __user=
 *buf, size_t size,
+                               loff_t *pos)
+{
+       struct amdgpu_device *adev =3D filp->f_inode->i_private;
+       struct spirom_bo *bo_triplet =3D adev->psp.spirom_dump_trip;
+
+       if (!bo_triplet)
+               return -EINVAL;
+
+       return simple_read_from_buffer(buf,
+                                      size,
+                                      pos, bo_triplet->cpu_addr,
+                                      AMD_VBIOS_FILE_MAX_SIZE_B * 2); }
+
+static int psp_read_spirom_debugfs_release(struct inode *inode, struct
+file *filp) {
+       struct amdgpu_device *adev =3D filp->f_inode->i_private;
+       struct spirom_bo *bo_triplet =3D adev->psp.spirom_dump_trip;
+
+       if (bo_triplet) {
+               amdgpu_bo_free_kernel(&bo_triplet->bo, &bo_triplet->mc_addr=
,
+                                     &bo_triplet->cpu_addr);
+               kfree(bo_triplet);
+       }
+
+       adev->psp.spirom_dump_trip =3D NULL;
+       return 0;
+}
+
+static const struct file_operations psp_dump_spirom_debugfs_ops =3D {
+       .owner =3D THIS_MODULE,
+       .open =3D psp_read_spirom_debugfs_open,
+       .read =3D psp_read_spirom_debugfs_read,
+       .release =3D psp_read_spirom_debugfs_release,
+       .llseek =3D default_llseek,
+};
+#endif
+
+void amdgpu_psp_debugfs_init(struct amdgpu_device *adev) { #if
+defined(CONFIG_DEBUG_FS)
+       struct drm_minor *minor =3D adev_to_drm(adev)->primary;
+
+       debugfs_create_file_size("psp_spirom_dump", 0444, minor->debugfs_ro=
ot,
+                               adev, &psp_dump_spirom_debugfs_ops, AMD_VBI=
OS_FILE_MAX_SIZE_B * 2);
+#endif }
+
 const struct amd_ip_funcs psp_ip_funcs =3D {
        .name =3D "psp",
        .early_init =3D psp_early_init,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 3876ac57ce62..089b6ae48329 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -39,6 +39,18 @@
 #define PSP_TMR_ALIGNMENT      0x100000
 #define PSP_FW_NAME_LEN                0x24

+/* VBIOS gfl defines */
+#define MBOX_READY_MASK 0x80000000
+#define MBOX_STATUS_MASK 0x0000FFFF
+#define MBOX_COMMAND_MASK 0x00FF0000
+#define MBOX_READY_FLAG 0x80000000
+#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2 #define
+C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_HI 0x3 #define
+C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0x4 #define
+C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_LO 0xf #define
+C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10 #define
+C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
+
 extern const struct attribute_group amdgpu_flash_attr_group;

 enum psp_shared_mem_size {
@@ -138,6 +150,7 @@ struct psp_funcs {
        int (*load_usbc_pd_fw)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
        int (*read_usbc_pd_fw)(struct psp_context *psp, uint32_t *fw_ver);
        int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_ad=
dr);
+       int (*dump_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_addr=
);
        int (*vbflash_stat)(struct psp_context *psp);
        int (*fatal_error_recovery_quirk)(struct psp_context *psp);
        bool (*get_ras_capability)(struct psp_context *psp); @@ -322,6 +335=
,14 @@ struct psp_runtime_scpm_entry {
        enum psp_runtime_scpm_authentication scpm_status;  };

+#if defined(CONFIG_DEBUG_FS)
+struct spirom_bo {
+       struct amdgpu_bo *bo;
+       uint64_t mc_addr;
+       void *cpu_addr;
+};
+#endif
+
 struct psp_context {
        struct amdgpu_device            *adev;
        struct psp_ring                 km_ring;
@@ -409,6 +430,9 @@ struct psp_context {
        char                            *vbflash_tmp_buf;
        size_t                          vbflash_image_size;
        bool                            vbflash_done;
+#if defined(CONFIG_DEBUG_FS)
+       struct spirom_bo *spirom_dump_trip;
+#endif
 };

 struct amdgpu_psp_funcs {
@@ -467,6 +491,10 @@ struct amdgpu_psp_funcs {
        ((psp)->funcs->update_spirom ? \
        (psp)->funcs->update_spirom((psp), fw_pri_mc_addr) : -EINVAL)

+#define psp_dump_spirom(psp, fw_pri_mc_addr) \
+       ((psp)->funcs->dump_spirom ? \
+       (psp)->funcs->dump_spirom((psp), fw_pri_mc_addr) : -EINVAL)
+
 #define psp_vbflash_status(psp) \
        ((psp)->funcs->vbflash_stat ? \
        (psp)->funcs->vbflash_stat((psp)) : -EINVAL) @@ -578,6 +606,7 @@ in=
t psp_config_sq_perfmon(struct psp_context *psp, uint32_t xcc_id,  bool amd=
gpu_psp_tos_reload_needed(struct amdgpu_device *adev);  int amdgpu_psp_reg_=
program_no_ring(struct psp_context *psp, uint32_t val,
                                   enum psp_reg_prog_id id);
+void amdgpu_psp_debugfs_init(struct amdgpu_device *adev);


 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 17f1ccd8bd53..ec9462336bcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -71,15 +71,6 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");
 /* Retry times for vmbx ready wait */
 #define PSP_VMBX_POLLING_LIMIT 3000

-/* VBIOS gfl defines */
-#define MBOX_READY_MASK 0x80000000
-#define MBOX_STATUS_MASK 0x0000FFFF
-#define MBOX_COMMAND_MASK 0x00FF0000
-#define MBOX_READY_FLAG 0x80000000
-#define C2PMSG_CMD_SPI_UPDATE_ROM_IMAGE_ADDR_LO 0x2 -#define C2PMSG_CMD_SP=
I_UPDATE_ROM_IMAGE_ADDR_HI 0x3 -#define C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE 0=
x4
-
 /* memory training timeout define */
 #define MEM_TRAIN_SEND_MSG_TIMEOUT_US  3000000

@@ -710,7 +701,8 @@ static int psp_v13_0_exec_spi_cmd(struct psp_context *p=
sp, int cmd)
        /* Ring the doorbell */
        WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_73, 1);

-       if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE)
+       if (cmd =3D=3D C2PMSG_CMD_SPI_UPDATE_FLASH_IMAGE ||
+           cmd =3D=3D C2PMSG_CMD_SPI_GET_FLASH_IMAGE)
                ret =3D psp_wait_for_spirom_update(psp, SOC15_REG_OFFSET(MP=
0, 0, regMP0_SMN_C2PMSG_115),
                                                 MBOX_READY_FLAG, MBOX_READ=
Y_MASK, PSP_SPIROM_UPDATE_TIMEOUT);
        else
@@ -766,6 +758,37 @@ static int psp_v13_0_update_spirom(struct psp_context =
*psp,
        return 0;
 }

+static int psp_v13_0_dump_spirom(struct psp_context *psp,
+                                  uint64_t fw_pri_mc_addr)
+{
+       struct amdgpu_device *adev =3D psp->adev;
+       int ret;
+
+       /* Confirm PSP is ready to start */
+       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMS=
G_115),
+                          MBOX_READY_FLAG, MBOX_READY_MASK, false);
+       if (ret) {
+               dev_err(adev->dev, "PSP Not ready to start processing, ret =
=3D %d", ret);
+               return ret;
+       }
+
+       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
+lower_32_bits(fw_pri_mc_addr));
+
+       ret =3D psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_AD=
DR_LO);
+       if (ret)
+               return ret;
+
+       WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_116,
+upper_32_bits(fw_pri_mc_addr));
+
+       ret =3D psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_ROM_IMAGE_AD=
DR_HI);
+       if (ret)
+               return ret;
+
+       ret =3D psp_v13_0_exec_spi_cmd(psp, C2PMSG_CMD_SPI_GET_FLASH_IMAGE)=
;
+
+       return ret;
+}
+
 static int psp_v13_0_vbflash_status(struct psp_context *psp)  {
        struct amdgpu_device *adev =3D psp->adev; @@ -898,6 +921,7 @@ stati=
c const struct psp_funcs psp_v13_0_funcs =3D {
        .load_usbc_pd_fw =3D psp_v13_0_load_usbc_pd_fw,
        .read_usbc_pd_fw =3D psp_v13_0_read_usbc_pd_fw,
        .update_spirom =3D psp_v13_0_update_spirom,
+       .dump_spirom =3D psp_v13_0_dump_spirom,
        .vbflash_stat =3D psp_v13_0_vbflash_status,
        .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_quir=
k,
        .get_ras_capability =3D psp_v13_0_get_ras_capability,
--
2.34.1

