Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD9EC28B28
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Mar 2025 08:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A336810E342;
	Thu, 13 Mar 2025 08:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UhqVl0ex";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E937610E342
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 08:15:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=scQ7dQpbaIKOBDHysE81uQ2Al+gO+QqtX6tX7ueoaWWJLr0OgHCL0oAced7f81/5b04ElPNvx+aNNmtS7awPlOTPyZSnU70ImDrZTzJHLIJAtwbpYjDR//6KbicExCj9aVwk5qR+PI3ek0mLjxnF1tJIYmyw058WtXM6CofPjv1X0tV9AJpeRUUAo6mGW5wjlUeM1y4Lt4u8WJgjZhhkoOs3kImokOxCxs67yb9hlkxulWbMUtm4FgbT0a5EPFaC+agqhXzikV7giyT2JGrSn2SCSOg2IueIhJ9a3YDN964JTygkNnBNPweqbjpwcUkv5EHv3JN3GHoQeF63wI4dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBVPBCxNEggcmflaSzulxCBIUVrCK1WtY2MkhbaRAbU=;
 b=S2BYIevexWV3VfmdODyTdMU5fCffSU8InRaMvVcEevr5DNk18KDb95XPETJbidr14v1RFoaaXpjA7RtxePtmpTI0h05DpvffaJMIQhZv/n67A0FnCfzow4JGAeDBPCY7fmnbrSHrxMxFnW9/SvtvELU1I5vswq23aSbUtE04uhYduakGvf7K1vsFvf8KkhPmYavT9ufrluZXBpkAL5mA3+7erqzdEBcwHeB1okSaKeAiJhwWrEvr9CsIG5uruD3yjWrRpaRgCMiLnFaOkfg6MFDLnDZI3GeBUZry/eyHaMcgkIP49cW1/HEIQCwmesO80DzZaRDJ5ng/CxJK68eHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBVPBCxNEggcmflaSzulxCBIUVrCK1WtY2MkhbaRAbU=;
 b=UhqVl0exhjAdq+aAvCkDmszCvMwDdKwe29vY8JfvvyjDnxwussEl3j8j/iSJDYPUhPDrpRBG7EPtPcEy8vXH+pmSNlNTBjKITWWVQaOtMfRz8lYxC69eHsNpVkxFCvbNFyqcJvU+OhwKp1qamSR/nUnpUpiM1g2MR7Jz89DTfls=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 08:15:35 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 08:15:35 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Topic: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version
Thread-Index: AQHbkzZlnp9F/bvHWUKEkyl7BBFZM7Nwua2w
Date: Thu, 13 Mar 2025 08:15:35 +0000
Message-ID: <BN9PR12MB5257D422285FCD66FF2B4E65FCD32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250312100548.283389-1-tao.zhou1@amd.com>
In-Reply-To: <20250312100548.283389-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=b19c02dc-0c77-4904-8cff-b1901b8bed5a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-13T08:15:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH8PR12MB6772:EE_
x-ms-office365-filtering-correlation-id: 4bc71175-3446-4a7c-0e3a-08dd62073b18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?oXk5r9Rw3WW8l/d91/gDRYiYC2GcHzQaGx7MN8iTm8tKZ/KER7HzixxPeC3x?=
 =?us-ascii?Q?Nxlq8++JPC+oWonhnMnHyugCVmlrCzKTiWY+XCu+0UGpTKh1XU2Px+7BaPL+?=
 =?us-ascii?Q?oFRZbBr/aeyXwRJWEHlJyxh6SbKz4823yPJhqfkyDlb6EoP1CnC1e1CVDS44?=
 =?us-ascii?Q?dTqP1ylO+P8r+ysn5EIVNclnU879jf+mgK1DFKeAswCNimfGB4PDQg83X5Qn?=
 =?us-ascii?Q?dQ//NA22hEsNgKBnbWbU5dUCaDdy9Mlz/q6ZK6nEyaq1RWX511fEYiv4/J4w?=
 =?us-ascii?Q?SEqLyEJivmVBz5VLTYMvtAT1LQGI8gcn2MjASA5eHElT2VEuAlzTVy4Ih8cg?=
 =?us-ascii?Q?P1RPvrlpCHhAL3vTSRl1ap+ujv1wlo48N4OnSSx56MoJfcmwcorun2P0HkC2?=
 =?us-ascii?Q?yusHXFhb2AXAnBJGMzCS9LrK+nUZdNY1+qg2DpUkjFqYNCAueiXFOj3VsGjU?=
 =?us-ascii?Q?r9mssHtj/QLF6DadWnzcrF9HFf6FCS7K9uIpP6oxvCASypC0RwAAqygVQh5s?=
 =?us-ascii?Q?GzCNMywM4SdcSnzkAuXbxZNgWNA9tj3BgxYqAexmSMUN3epiClZajaWgLD/X?=
 =?us-ascii?Q?0vD6i3svPtWpFc0L1dp0b3TKukD6b8s8hUrLdrQkv2zpAEqSzvrXrCIKEceY?=
 =?us-ascii?Q?PhiYk0C0N97hu9LCeb6N+ptAjU0sB3XFfgrnX5JF4nBNCNaxr1LgBEvCTuUj?=
 =?us-ascii?Q?7CjRLRbuybHc/DCCrIOOVXmrssNXa1WymmtD7IC8gKFUcDEQS+VSjTwFbrNy?=
 =?us-ascii?Q?lIW7hxSuyxzyjpzFAlSF2zxsOQQBvxgoon0j1DNjvO6zhhwq+SxkwGCSvivw?=
 =?us-ascii?Q?Hr9cHdycgSU9faNvlJ4HmobVF5ToM2qFv9yDzBK0r1lsPy17zAEaQPWG8gCQ?=
 =?us-ascii?Q?5pMZKyKeLqwNCsqq4dNNkSMHukpvoLg8Bx1DD73x133f6aAVwpTZd+fEq6eu?=
 =?us-ascii?Q?xwC/KgDFJHmsNcYRaFz+N7kXDe/daDu7kZs9qq+bmDAgr75sdVyYJJSOKA9q?=
 =?us-ascii?Q?Hqzn7M6UoAuwRkqk1wI1XFUgYbHRveG8SDhyMyKiwpMETodT71ajszlsRKTe?=
 =?us-ascii?Q?YG10jOOIf+p5W6k2xzRwLTbEeVfkROnVUI/lyjJXhxipi0X261kCD0Sky4r3?=
 =?us-ascii?Q?1xG5TxxnrjoTw1wVwi3nmo7afgxeTLsgPYvoOnXGr5bs2vupxjSFinGFCGU4?=
 =?us-ascii?Q?xdY8xba1+Dj8Y0ZfgH1bF6kVfW7Z7LD5Ih0/PFfYolWP8nkm/CjRSWAE+D4n?=
 =?us-ascii?Q?jPaLDBCfstKJeckkRD6MVwPHoLqwXbOjUStnMMn+6ZHMnuPBiCKWV4UthZzD?=
 =?us-ascii?Q?hAkEnspUq8LzTHnZDKhDCUKT1sbbFnKAUiXOOjOqWrh/PDfXUUiMoADDz2d5?=
 =?us-ascii?Q?/kTkQFA0jG07C++hTNJQZ2Nm5xS4EVlmq1YhJv5P5GiWCEIYDAaNcTMWN/ra?=
 =?us-ascii?Q?yFOXv5QFMfhvb/vWGS55+hheehzy5JOU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dP0ALryutBXhOq1pLWbgd/bIyOHLQZUPJBvywg0fVaJrPT56OzWoBijMBCAx?=
 =?us-ascii?Q?61aBajTl8hvF0yaOsGqx1oQcxPh/DopIbggetdaMQtpwa7FQda0l9e+zPsXT?=
 =?us-ascii?Q?4quzd1qeitUAig2KXOUqV2Q7zN54RE4WMQEc6wDI/A0pDP8WStpwe6VpO1pm?=
 =?us-ascii?Q?J3Lw+SJ0djImBlMJtLzEx0vT+eH4GgDzkLRDyqspTAVpgPJfKTAoNxA5Z7iJ?=
 =?us-ascii?Q?3Um/X/14GazPkrsI7LXOxPQs4i/oMj3EF/WXQxOvkABzFSFg+F2Zi7i8Vas1?=
 =?us-ascii?Q?MV9EszHVuHBOQHAwGBObw5VBg3l0ex/cKZAf2a4yjac1BM4Y5mhKhaZsb67d?=
 =?us-ascii?Q?/E5m3T1fHp6nYhYqMSbHZCpcyWy1KDm9GUSz4StXouyoJvtQ1t8N7UnPbnjF?=
 =?us-ascii?Q?GQAJhkfVIkjDnN7o/LWzOaRJeKNAQMBo6tohiPmurX+e+cNi1aXtZiKAJR3R?=
 =?us-ascii?Q?qXERIh2GJAOcb2TzapN2iodNcVBYNMSW+w9bKZ20gtfGnQ23U2Hk3SPlDDDr?=
 =?us-ascii?Q?W8aGCFN4FcZdRXBl5OI1fLUIsA7CYU+F5UweaAm7iY3gKeAD+W5MpkWO5WoA?=
 =?us-ascii?Q?7t0s/vPPrYf1UyyMRKan49GVd25MIpL9Mk04QJllGTMMDYEChh/WwolJC/wP?=
 =?us-ascii?Q?ryiFEJ2fwtiiPFkq2sfy85JG/u19VxZiaO2234tx/sKtGIUufyTnqAd+a2qJ?=
 =?us-ascii?Q?W20QfyPCqps0gjslGFr8Br34kVXeM1ddJkLzV4OPB1YPVGHHLvJPu2QssyP9?=
 =?us-ascii?Q?c/mCUJXWFTlpNGDNQWV12XpvOqiEnRzus/XjotgwFnzD29Mp7HI6e/coh39M?=
 =?us-ascii?Q?VVfPouZ7LMZYpbAJQeGCvMcFuh54R/rliVnbWw9UMT3IgeBEtWR5PEmV2oXs?=
 =?us-ascii?Q?Pev1n0yAlRhxPiUqSZrQoFv7AnQZHqizruXDTKbS/z1xECyYwczjRCBRmuzJ?=
 =?us-ascii?Q?ScXcOnHSAKpivyAQcIZ71PMcDxH3A1cVRdbHOOr1qrtgfRaiL2UJGOwBa2qH?=
 =?us-ascii?Q?JNqTDmPCZy3TM00deyRf5ETZ5q3pXemQizEgt/IRG2E0tga2JnRf6Cqmuwva?=
 =?us-ascii?Q?mOFKQn+2PYRlqPumygLm9dX76LFVz0QxPN+ujUfgPwOuqqkPgQ+OKUlNhA+g?=
 =?us-ascii?Q?MyAHQ/L694VHP19sFrvYfpWFIQEB7TBJlrgwKjcdwdiedYzYqOOx/ScRGPu4?=
 =?us-ascii?Q?RJCSW0CgxyPFahoLJuiNPUakhhwREAGjvcSw7VgA3cqDM6OX391r8Fmb/NSS?=
 =?us-ascii?Q?AWfPkURWCR98eQ+3ptzG4he5F987Gfo7XSUfuaEBjCxsQeakZQaR3+jIQxjk?=
 =?us-ascii?Q?99nnBg4yKwblf6Ej6Bgk5djm32qzQa7JQhVGXWAK48jAPtuJPJ8wJM9NwyK3?=
 =?us-ascii?Q?i9iH0e1LWLj3+YlJ0W2ao0niobtou/P/hBiYaI87X3pN1NC6tuuwdyAsPu+6?=
 =?us-ascii?Q?9F2dZyPY8+2DDitLFBmZTNF7K7QWSD/wO+BTGoIz4wUt40HOPwIqH47VuoqH?=
 =?us-ascii?Q?17tzDiS4t8wyVjGxKo3pD5Ndv04QEvlg53Udp+wK93FkpZjHdtPi8vpSqMsq?=
 =?us-ascii?Q?A6D01Mvb0JCxqlWb/URNsZ7qHIA4WAQj/lkoIE24?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc71175-3446-4a7c-0e3a-08dd62073b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2025 08:15:35.1873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: luneLu+pHezA7Qh8ElhKXu1Ozwipkmpsg63B7w908QgOz/MsalQbS5+EqWxWmVPhhTrWdPFkH1+jRDuSVK4z1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, March 12, 2025 18:06
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: format old RAS eeprom data into V3 version

Clear old data and save it in V3 format.

v2: only format eeprom data for new ASICs.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++++---------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  1 +
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 837f33698b38..d3b9b4d9fb89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3465,6 +3465,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_devic=
e *adev)
                                adev, control->bad_channel_bitmap);
                        con->update_channel_flag =3D false;
                }
+
+               /* The format action is only applied to new ASICs */
+               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >=
=3D 12 &&
+                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
+                       if (!amdgpu_ras_eeprom_reset_table(control))
+                               if (amdgpu_ras_save_bad_pages(adev, NULL))
+                                       dev_warn(adev->dev, "Failed to form=
at RAS EEPROM data in V3
+version!\n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 09a6f8bc1a5a..71dddb8983ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -413,9 +413,11 @@ static void amdgpu_ras_set_eeprom_table_version(struct=
 amdgpu_ras_eeprom_control

        switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
        case IP_VERSION(8, 10, 0):
-       case IP_VERSION(12, 0, 0):
                hdr->version =3D RAS_TABLE_VER_V2_1;
                return;
+       case IP_VERSION(12, 0, 0):
+               hdr->version =3D RAS_TABLE_VER_V3;
+               return;
        default:
                hdr->version =3D RAS_TABLE_VER_V1;
                return;
@@ -443,7 +445,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)
        hdr->header =3D RAS_TABLE_HDR_VAL;
        amdgpu_ras_set_eeprom_table_version(control);

-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                hdr->first_rec_offset =3D RAS_RECORD_START_V2_1;
                hdr->tbl_size =3D RAS_TABLE_HEADER_SIZE +
                                RAS_TABLE_V2_1_INFO_SIZE;
@@ -461,7 +463,7 @@ int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eep=
rom_control *control)
        }

        csum =3D __calc_hdr_byte_sum(control);
-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1)
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1)
                csum +=3D __calc_ras_info_byte_sum(control);
        csum =3D -csum;
        hdr->checksum =3D csum;
@@ -752,7 +754,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
                        "Saved bad pages %d reaches threshold value %d\n",
                        control->ras_num_bad_pages, ras->bad_page_cnt_thres=
hold);
                control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
-               if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
                        control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
                        control->tbl_rai.health_percent =3D 0;
                }
@@ -765,7 +767,7 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eepro=
m_control *control)
                amdgpu_dpm_send_rma_reason(adev);
        }

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                control->tbl_hdr.tbl_size =3D RAS_TABLE_HEADER_SIZE +
                                            RAS_TABLE_V2_1_INFO_SIZE +
                                            control->ras_num_recs * RAS_TAB=
LE_RECORD_SIZE; @@ -805,7 +807,7 @@ amdgpu_ras_eeprom_update_header(struct =
amdgpu_ras_eeprom_control *control)
         * now calculate gpu health percent
         */
        if (amdgpu_bad_page_threshold !=3D 0 &&
-           control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1 &&
+           control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1 &&
            control->ras_num_bad_pages <=3D ras->bad_page_cnt_threshold)
                control->tbl_rai.health_percent =3D ((ras->bad_page_cnt_thr=
eshold -
                                                   control->ras_num_bad_pag=
es) * 100) / @@ -818,7 +820,7 @@ amdgpu_ras_eeprom_update_header(struct amd=
gpu_ras_eeprom_control *control)
                csum +=3D *pp;

        csum +=3D __calc_hdr_byte_sum(control);
-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                csum +=3D __calc_ras_info_byte_sum(control);
        /* avoid sign extension when assigning to "checksum" */
        csum =3D -csum;
@@ -1035,7 +1037,7 @@ uint32_t amdgpu_ras_eeprom_max_record_count(struct am=
dgpu_ras_eeprom_control *co
        /* get available eeprom table version first before eeprom table ini=
t */
        amdgpu_ras_set_eeprom_table_version(control);

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                return RAS_MAX_RECORD_COUNT_V2_1;
        else
                return RAS_MAX_RECORD_COUNT;
@@ -1280,7 +1282,7 @@ static int __verify_ras_table_checksum(struct amdgpu_=
ras_eeprom_control *control
        int buf_size, res;
        u8  csum, *buf, *pp;

-       if (control->tbl_hdr.version =3D=3D RAS_TABLE_VER_V2_1)
+       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
                buf_size =3D RAS_TABLE_HEADER_SIZE +
                           RAS_TABLE_V2_1_INFO_SIZE +
                           control->ras_num_recs * RAS_TABLE_RECORD_SIZE; @=
@ -1383,7 +1385,7 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_co=
ntrol *control)

        __decode_table_header_from_buf(hdr, buf);

-       if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+       if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
                control->ras_record_offset =3D RAS_RECORD_START_V2_1;
                control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT_V2_1=
; @@ -1423,7 +1425,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eepro=
m_control *control)
                DRM_DEBUG_DRIVER("Found existing EEPROM table with %d recor=
ds",
                                 control->ras_num_bad_pages);

-               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control);
                        if (res)
                                return res;
@@ -1443,7 +1445,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_=
control *control)
                                        ras->bad_page_cnt_threshold);
        } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
                   amdgpu_bad_page_threshold !=3D 0) {
-               if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
+               if (hdr->version >=3D RAS_TABLE_VER_V2_1) {
                        res =3D __read_table_ras_info(control);
                        if (res)
                                return res;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.h
index 13f7eda9a696..ec6d7ea37ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -28,6 +28,7 @@

 #define RAS_TABLE_VER_V1           0x00010000
 #define RAS_TABLE_VER_V2_1         0x00021000
+#define RAS_TABLE_VER_V3           0x00030000

 struct amdgpu_device;

--
2.34.1

