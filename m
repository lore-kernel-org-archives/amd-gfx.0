Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549A3C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 07:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 981FD10E1B0;
	Tue, 12 Mar 2024 07:14:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="njyERGvD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0457410F0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 07:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk/pZovqrUiMRdslDYfXAilVIgGwvefPgbDdEI+b/pNOvDEWy3yZgX8jU5ktOjwNhtlLel6WaE/YKtTwCZpRsrUrnmUXwWmL8tRlmhX4y5fta2BvJdUbLKHvy2iJRA4PJ95mYih/1ezdJ55xBqTJd0+UMbMTFGfawxR2nCAgGDHgP8IeP+Nc9xmAEGNoDxBYNBjG62jzBBcgQfhkn5iKwoSFM9+xkdDSDowFZYIK/fXtu4sl5pvbC9D8Dwa6K5exNVFLq/pARHSMs9swNyvBOF1t8+lOmqq9vuCmgtG6eTmAfn/kPd6kceayBMU8HQuTG5FjlcdFbU2ZQ/OEUDM/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GDrAm/IpKmwH6dQi5jBZlO1QVkoWMvSXcou/Nv24sA=;
 b=YZxVjAIGu/uFWzj9WN2eMwEqn6XNHk6jnlxGfp5i9s2eqwfsJdvyrWOJo6B+dNWaKw19dQVUguhLfLL9jBay+DP1wU5zVRZJXMGUs8FVNxD7IDGPF9/pgsWTpW0MX1oGv1ItpWWWf8HnnY0FzG3bZ74rjgcewxYFWA8CWopZqORtUBYT5jECQKF9NRqM9oxrhVF2bAzMQFVDP/hdwgDy5jbwAoR8uT5eDLtEF+d/PrAByjAY3S2RuUUBh9l1u1IBiPfwFHE0E0O/XPvfzZjdkbWl+NY0IgGNmPklhDn0LrnSPupcWZepQeBybToS7Locp1WPQNL+mYq36D0xucyEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GDrAm/IpKmwH6dQi5jBZlO1QVkoWMvSXcou/Nv24sA=;
 b=njyERGvDK7uMp3wkco4BkVSrWmlOKxL+z3Mx9gOCE99tYYXPAKEHPZeJDL5L77bI9xvP4YobAAHSLIKr5yZyrpzWZFmFP/RT8GcIE7O3u2atBNwCNtoCxYUpmm6i+yTPwN58rpRBMXAUlb0xCsHUzUNUH0csWuFmRzWW+sy4haM=
Received: from CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16)
 by CYYPR12MB8653.namprd12.prod.outlook.com (2603:10b6:930:c5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 07:14:28 +0000
Received: from CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::f6f6:edf3:d629:5bb]) by CH3PR12MB7762.namprd12.prod.outlook.com
 ([fe80::f6f6:edf3:d629:5bb%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 07:14:28 +0000
From: "Gopalakrishnan, Veerabadhran (Veera)"
 <Veerabadhran.Gopalakrishnan@amd.com>
To: "Jamadar, Saleemkhan" <Saleemkhan.Jamadar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "Rao, Srinath" <Srinath.rao@amd.com>
Subject: RE: [PATCH] drm/amdgpu/vcn: enable vcn1 fw load for VCN 4_0_6
Thread-Topic: [PATCH] drm/amdgpu/vcn: enable vcn1 fw load for VCN 4_0_6
Thread-Index: AQHadEvGE1ir7lOrpkWcBTkZL227arEzsRAw
Date: Tue, 12 Mar 2024 07:14:28 +0000
Message-ID: <CH3PR12MB7762467E4DF5D2CABB26764DFA2B2@CH3PR12MB7762.namprd12.prod.outlook.com>
References: <20240312070550.2455243-1-saleemkhan.jamadar@amd.com>
In-Reply-To: <20240312070550.2455243-1-saleemkhan.jamadar@amd.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ce44c860-2e1c-4721-aec6-79abbd100483;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-12T07:13:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7762:EE_|CYYPR12MB8653:EE_
x-ms-office365-filtering-correlation-id: c63378ba-ba91-4ad0-05b9-08dc42640e77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhGm6i+HB5iBoV9qF+v8FVP++KZ0fNb0PD4cL6J1gk8LqqzCG6mIEk023dyXG8twH8uTNNS7ezqCpK2iROmtoM2lo83R3gblpf/FAG0+8KqieM6+cViHCdqidw/X8MgVzL4opd3za+e/s6qJkT1iGcv8YO9cb8EvtHEKOINFBnxJwHbbYRKlaDprVX2tQj0AmBlOFzYY/YhGrLcyhHqzOESs4EO9js/2AlgJOUrAiB7i704fANst8x4V8Kwu9vvl2xJtMjXJfKpuzCR3Of3DapM22U0yU1FqzEy4W9XV3At4Dp7ixE0Ix+9OtqQFYWfeNrzgM9cLLJ7icPl2cPFwCSMp9fGZJRJ0SSX1QZEZSrbRRkvrqCPWJ8ewbnQQ+OQ2aKzdFq3ZbUFDzKM/Bt4+fFIH7n+fM/eB1iPlIffnYooaQxpLxrNncwuLahYsyUKj6XFJOsGQmxH5nOs5FjZpTUM7Y3BGEojrtC15Ra+W2xkGI5MtO01hTWBvHr5DwLOWbkBwsspQLkQhJZOHw66qNwa25ME1D+joVr8OW7RRRlQJDW5Ls/W1z7LyXW4kX9f25puhPwmMP0uxgwzWU1rglIHuyvEoUIFQDgE1HKGpwfEIQvNN+1NHOpF7nWNTOi4TV0PmWUXk6mQIimQ4+7eug+lt6MCX6G7++YtaC3rEJv34SOZtGIK5iVAEyztneanALt7dvxy1ow65QdnhJaDpCdCEItLh+EZF2esFpcm4TqE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JCxd3ACBLXcgDqSDrzMHKQyIG9z/xu2FH/mXxIk2tUuR8rqqp1S2UzFuUhZp?=
 =?us-ascii?Q?0xR20CNW+PCXL5xqJjvvz+OxGM4Heac+Ccb8n787N4N7/KCoqz3192X53FFB?=
 =?us-ascii?Q?AHJSR22FVc8wf3u3YSG4kUbwPXmOxU8RMkAwkNR7HNlgkczwH10mlqd9TpdN?=
 =?us-ascii?Q?g7+qVQJKzJ0Ch1VK6PPv6Y6CYPEfK6c6ySOZYVOOd1CcGYOg9ZpLlabMJKi2?=
 =?us-ascii?Q?VJx6qcX1CyIFTTouqtaqQVO3zbOo7AttkO0g3O8ncekm1OC8ncujJdK28PLv?=
 =?us-ascii?Q?yGaZodrLhhkBH3o+MhgNBSXnbwAsWYkcSosgPTmJUrOxNxJyv6hvVnlvjKoM?=
 =?us-ascii?Q?MDwa4J2B8s7FbPgUMx7c+W5a1o5RzL6gWzUYSIuNM9YBjVZ0Rm2XZXqqDFX7?=
 =?us-ascii?Q?R/T4JLMV6hnMkXJuL9LJ+QRVdYzxfjMJzzMQYAP+q/cu7BJ6hTusue2IX0LH?=
 =?us-ascii?Q?PKKFw2mpabfqXPVISB/aHNSV6bB7kbaHB2Jqwf3P2KS4s7/LJHe6Dqazv1z1?=
 =?us-ascii?Q?1NcJBvmvzVbPZyE2+1o+9pnovbYA4oHOh6EeAzABRqm4afwitcyXg9CkFUsx?=
 =?us-ascii?Q?QOuCRZh8NJRIaUJrTY1ftqdvMZ0+gY3Sw2MzFBlaUrFrtp7fzrc7K1aakxrd?=
 =?us-ascii?Q?SHb+Ustq01gOD2oJAzJ4qfAofYchWHyyh37rGQgpXmH67eVQ8Jxz55Bn5ivS?=
 =?us-ascii?Q?pxM64axUiGbrldL0XdvI+geAqqrhj1TtW71neDC6HeEgaJ/E1ndf+JurNOvy?=
 =?us-ascii?Q?MvIBuABTy/GPihVk/kCaKOf5+g/XGUr7ubifcd0fiAtq8CPEhHoJruZ9NEA6?=
 =?us-ascii?Q?8585cQhz/bswt8pkVPW0k6ZpsrTR2n/PFnA6tXkIHKClW9WJELMpxyq5BUJw?=
 =?us-ascii?Q?QQVm+XPZdmk3p7SYQGEsVPn+3R+92ZRh6EBqPwc37qdg4omoHYZWrm+X0t++?=
 =?us-ascii?Q?RW1owdpgoRVkmiN2d+TTzmVfw74z0eWcwgbXBX+uDIMa7pCm2Y9YGnzch6fO?=
 =?us-ascii?Q?Ehumbxh5mBOE/6SUU2MTlMsRDMlRCyDLIap8NKtXxTXzP5JDBTQD+ETS1o3m?=
 =?us-ascii?Q?jVDp9zUlrLvpfbnQoymd/jcp2AMafgHpbo4ovRevkdApyhRsdNbKKHszrsVm?=
 =?us-ascii?Q?o1Lpmf6ptq0aHKb+5UYCFTXelhgW5z9gZJSR2oW2+/gLcyjItK/WUZrlIdQ3?=
 =?us-ascii?Q?hA+U3kLO2mc9llXe0Bw9Op6FQrzQR8B2tzJqhgB6DOAAFxSq3U9SjwG08e4F?=
 =?us-ascii?Q?bBxOPrvRmOr6Sv93JpPlikD/AePqs2CtG1pIoJBZWpT4qD+RrRi4AQkc0Uoj?=
 =?us-ascii?Q?R+rSfLRuNKrbc9eILLFwkRcJyP83jrrz3x+UXh1CHHTUavROFrUHkIYLIb7p?=
 =?us-ascii?Q?8CWI1YCKE+469mIbp+0nIOF2Y836wef46T6BHZRPilkkbz3rYiEKCnXBtVax?=
 =?us-ascii?Q?ASfXXj9UgDZvtu7hOFRHOJ89ofTLROCkmBkEpp4X8x05989uYLg1FX3CIxEo?=
 =?us-ascii?Q?+a0A9DmQ1wQn2GA3dP3MWjeCoK7IdXW7Lo5utFLPZ/Ih3SfwEZMnGAXJHEKB?=
 =?us-ascii?Q?LMop8imGyX3trjj5B0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63378ba-ba91-4ad0-05b9-08dc42640e77
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 07:14:28.6308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1up+J8iyPVvTVeu+yCnuqrLrX+41ccN8QFvpZ1i11WKhpXhZLjUDTUJwXPOjSmTkETpGFDWqXx/ds+f5zINFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8653
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

[AMD Official Use Only - General]

Looks good to me.

Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.c=
om>

Regards,
Veera

-----Original Message-----
From: Jamadar, Saleemkhan <Saleemkhan.Jamadar@amd.com>
Sent: Tuesday, March 12, 2024 12:36 PM
To: amd-gfx@lists.freedesktop.org; Jamadar, Saleemkhan <Saleemkhan.Jamadar@=
amd.com>; Liu, Leo <Leo.Liu@amd.com>; Sundararaju, Sathishkumar <Sathishkum=
ar.Sundararaju@amd.com>; Gopalakrishnan, Veerabadhran (Veera) <Veerabadhran=
.Gopalakrishnan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Rao, Srinath <Srinath.rao@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: enable vcn1 fw load for VCN 4_0_6

v1 - update the fw header for each vcn instance (Veera)

VCN1 has different FW binary in VCN v4_0_6.
Add changes to load the VCN1 fw binary

Signed-off-by: Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 38 ++++++++++++++++---------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  6 ++--  drivers/gpu/drm/amd/amd=
gpu/vcn_v4_0_5.c | 10 +++----  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  4=
 +--
 10 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index b2535023764f..9c514a606a2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -60,6 +60,7 @@
 #define FIRMWARE_VCN4_0_4              "amdgpu/vcn_4_0_4.bin"
 #define FIRMWARE_VCN4_0_5              "amdgpu/vcn_4_0_5.bin"
 #define FIRMWARE_VCN4_0_6              "amdgpu/vcn_4_0_6.bin"
+#define FIRMWARE_VCN4_0_6_1            "amdgpu/vcn_4_0_6_1.bin"
 #define FIRMWARE_VCN5_0_0              "amdgpu/vcn_5_0_0.bin"

 MODULE_FIRMWARE(FIRMWARE_RAVEN);
@@ -85,6 +86,7 @@ MODULE_FIRMWARE(FIRMWARE_VCN4_0_3);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_4);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_5);
 MODULE_FIRMWARE(FIRMWARE_VCN4_0_6);
+MODULE_FIRMWARE(FIRMWARE_VCN4_0_6_1);
 MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);

 static void amdgpu_vcn_idle_work_handler(struct work_struct *work); @@ -93=
,14 +95,22 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)  {
        char ucode_prefix[30];
        char fw_name[40];
-       int r;
+       int r, i;

-       amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof=
(ucode_prefix));
-       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
-       r =3D amdgpu_ucode_request(adev, &adev->vcn.fw, fw_name);
-       if (r)
-               amdgpu_ucode_release(&adev->vcn.fw);
+       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
+               amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix=
, sizeof(ucode_prefix));
+               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_p=
refix);
+               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D  IP_VERSION=
(4, 0, 6) &&
+                       i =3D=3D 1) {
+                       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bi=
n", ucode_prefix, i);
+               }

+               r =3D amdgpu_ucode_request(adev, &adev->vcn.fw[i], fw_name)=
;
+               if (r) {
+                       amdgpu_ucode_release(&adev->vcn.fw[i]);
+                       return r;
+               }
+       }
        return r;
 }

@@ -141,7 +151,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
                }
        }

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[0]->dat=
a;
        adev->vcn.fw_version =3D le32_to_cpu(hdr->ucode_version);

        /* Bit 20-23, it is encode major and non-zero for new naming conven=
tion.
@@ -256,9 +266,10 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)

                for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
                        amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
+
+               amdgpu_ucode_release(&adev->vcn.fw[j]);
        }

-       amdgpu_ucode_release(&adev->vcn.fw);
        mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
        mutex_destroy(&adev->vcn.vcn_pg_lock);

@@ -354,11 +365,12 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
                        const struct common_firmware_header *hdr;
                        unsigned int offset;

-                       hdr =3D (const struct common_firmware_header *)adev=
->vcn.fw->data;
+                       hdr =3D (const struct common_firmware_header *)adev=
->vcn.fw[i]->data;
                        if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PS=
P) {
                                offset =3D le32_to_cpu(hdr->ucode_array_off=
set_bytes);
                                if (drm_dev_enter(adev_to_drm(adev), &idx))=
 {
-                                       memcpy_toio(adev->vcn.inst[i].cpu_a=
ddr, adev->vcn.fw->data + offset,
+                                       memcpy_toio(adev->vcn.inst[i].cpu_a=
ddr,
+                                                   adev->vcn.fw[i]->data +=
 offset,
                                                    le32_to_cpu(hdr->ucode_=
size_bytes));
                                        drm_dev_exit(idx);
                                }
@@ -1043,11 +1055,11 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *a=
dev)
        if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                const struct common_firmware_header *hdr;

-               hdr =3D (const struct common_firmware_header *)adev->vcn.fw=
->data;
-
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
                        if (adev->vcn.harvest_config & (1 << i))
                                continue;
+
+                       hdr =3D (const struct common_firmware_header *)adev=
->vcn.fw[i]->data;
                        /* currently only support 2 FW instances */
                        if (i >=3D 2) {
                                dev_info(adev->dev, "More then 2 VCN FW ins=
tances!\n"); @@ -1055,7 +1067,7 @@ void amdgpu_vcn_setup_ucode(struct amdgp=
u_device *adev)
                        }
                        idx =3D AMDGPU_UCODE_ID_VCN + i;
                        adev->firmware.ucode[idx].ucode_id =3D idx;
-                       adev->firmware.ucode[idx].fw =3D adev->vcn.fw;
+                       adev->firmware.ucode[idx].fw =3D adev->vcn.fw[i];
                        adev->firmware.fw_size +=3D
                                ALIGN(le32_to_cpu(hdr->ucode_size_bytes), P=
AGE_SIZE);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 1985f71b4373..a418393d89ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -306,7 +306,7 @@ struct amdgpu_vcn_ras {  struct amdgpu_vcn {
        unsigned                fw_version;
        struct delayed_work     idle_work;
-       const struct firmware   *fw;    /* VCN firmware */
+       const struct firmware   *fw[AMDGPU_MAX_VCN_INSTANCES];  /* VCN firm=
ware */
        unsigned                num_enc_rings;
        enum amd_powergating_state cur_state;
        bool                    indirect_sram;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 25ba27151ac0..aaceecd558cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -304,7 +304,7 @@ static int vcn_v1_0_resume(void *handle)
  */
 static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
        uint32_t offset;

        /* cache window 0: fw */
@@ -371,7 +371,7 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_d=
evice *adev)

 static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
        uint32_t offset;

        /* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v2_0.c
index 18794394c5a0..e357d8cf0c01 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -330,7 +330,7 @@ static int vcn_v2_0_resume(void *handle)
  */
 static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
        uint32_t offset;

        if (amdgpu_sriov_vf(adev))
@@ -386,7 +386,7 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *ad=
ev)

 static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool i=
ndirect)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
        uint32_t offset;

        /* cache window 0: fw */
@@ -1878,7 +1878,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device =
*adev)

                init_table +=3D header->vcn_table_offset;

-               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);

                MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
                        SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS), diff --git =
a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2=
_5.c
index aba403d71806..1cd8a94b0fbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -414,13 +414,15 @@ static int vcn_v2_5_resume(void *handle)
  */
 static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size;
        uint32_t offset;
        int i;

        for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
                if (adev->vcn.harvest_config & (1 << i))
                        continue;
+
+               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
                /* cache window 0: fw */
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                        WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR=
_LOW,
@@ -469,7 +471,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *ad=
ev)

 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int in=
st_idx, bool indirect)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->siz=
e +
+4);
        uint32_t offset;

        /* cache window 0: fw */
@@ -1240,7 +1242,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device =
*adev)
                        SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
                        ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);

-               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+               size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
                /* mc resume*/
                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                        MMSCH_V1_0_INSERT_DIRECT_WT(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e02af4de521c..8f82fb887e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -449,7 +449,7 @@ static int vcn_v3_0_resume(void *handle)
  */
 static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst]->size + =
4);
        uint32_t offset;

        /* cache window 0: fw */
@@ -499,7 +499,7 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *ad=
ev, int inst)

 static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int in=
st_idx, bool indirect)  {
-       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+       uint32_t size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->siz=
e +
+4);
        uint32_t offset;

        /* cache window 0: fw */
@@ -1332,7 +1332,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device =
*adev)
                        mmUVD_STATUS),
                        ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);

-               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4=
);
+               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size =
+ 4);

                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                        MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i=
, diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
index 8ab01ae919d2..832d15f7b5f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -382,7 +382,7 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *ad=
ev, int inst)
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]->=
data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -442,7 +442,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_d=
evice *adev, int inst_idx  {
        uint32_t offset, size;
        const struct common_firmware_header *hdr;
-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header
+*)adev->vcn.fw[inst_idx]->data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -1289,7 +1289,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device =
*adev)
                        regUVD_STATUS),
                        ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);

-               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4=
);
+               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size =
+ 4);

                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                        MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i=
, diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
index 810bbfccd6f2..203fa988322b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -332,7 +332,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *=
adev, int inst_idx)
        uint32_t offset, size, vcn_inst;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header
+*)adev->vcn.fw[inst_idx]->data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        vcn_inst =3D GET_INST(VCN, inst_idx);
@@ -407,7 +407,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_i
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header
+*)adev->vcn.fw[inst_idx]->data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -894,7 +894,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device =
*adev)
                MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0,=
 regUVD_STATUS),
                        ~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);

-               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4=
);
+               cache_size =3D AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size =
+ 4);

                if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) {
                        MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0=
, diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
index 0468955338b7..501e53e69f2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -45,7 +45,7 @@
 #define mmUVD_DPG_LMA_DATA_BASE_IDX                                    reg=
UVD_DPG_LMA_DATA_BASE_IDX

 #define VCN_VID_SOC_ADDRESS_2_0                                           =
     0x1fb00
-#define VCN1_VID_SOC_ADDRESS_3_0                                       0x4=
8300
+#define VCN1_VID_SOC_ADDRESS_3_0                                       (0x=
48300 + 0x38000)

 #define VCN_HARVEST_MMSCH                                                 =
     0

@@ -329,7 +329,7 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *=
adev, int inst)
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]->=
data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -390,7 +390,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_i
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header
+*)adev->vcn.fw[inst_idx]->data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -486,7 +486,8 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_i

        /* VCN global tiling registers */
        WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
-               VCN, 0, regUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr=
_config, 0, indirect);
+               VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
+               adev->gfx.config.gb_addr_config, 0, indirect);
 }

 /**
@@ -911,7 +912,6 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_devi=
ce *adev, int inst_idx, b
                VCN, inst_idx, regUVD_MASTINT_EN),
                UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);

-
        if (indirect)
                amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v5_0_0.c
index d6ee9958ba5f..bc60c554eb32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -290,7 +290,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *=
adev, int inst)
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header *)adev->vcn.fw[inst]->=
data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
@@ -351,7 +351,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu=
_device *adev, int inst_i
        uint32_t offset, size;
        const struct common_firmware_header *hdr;

-       hdr =3D (const struct common_firmware_header *)adev->vcn.fw->data;
+       hdr =3D (const struct common_firmware_header
+*)adev->vcn.fw[inst_idx]->data;
        size =3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) +=
 8);

        /* cache window 0: fw */
--
2.25.1

