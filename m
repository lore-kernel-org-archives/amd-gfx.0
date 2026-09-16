Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49750C982C9
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 18:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB19110ED38;
	Wed, 16 Sep 2026 18:22:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BFro73De";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010055.outbound.protection.outlook.com [52.101.85.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 673F910ED38
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 18:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsz9DKesFfSYK1BSWe9pGE3Dr3Wjeldn0qzzSl07fegUAr/gnsmk3HgvpK7UGyD8yh11uZduAkN7vSoHw60zH4BErt23c+r1fKNezQmzHzvOwFfkK7dNK//qlPB+Zq0WQegHX/xXYr/wWJ/K3Y1bS9ZFMGZPuAIivHB8AeAS7vv/Y50aks1jFUQO92aeLoFcYJyQjfdnth7izMoHGAWOEalcwB/M+nFKVCec5ib7r6R6j+QkDdm3CMHJy/jmuD69YmaK5OeQswxGiHMGrMsl3GJ+HBf6YeyLt1X/3AtRyy79KJ12fUNNyPxTtOsuMP52UCtNmskNEhpTHi8CgU1+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs74g2GR/RtVt3DNA8stXb7+SggBwO49+DX5xxUiI/Y=;
 b=FYD4pXBHyoP9BpNHTcF4AWRuxs6/1zKenTahCzTCFouop7Cd9ZrlkCDM5KzJjOAY5Mu9aDDZCd/DcPWyR2N8qi1n4GyMQzI80Os+A9cAumyYjZs6zNL1mmUQ+0jZhtI3lv/I+3ymID10dc9l8PWE9EhUWfZS4x0L9U3QXdAe+uWdT5qYV0Px391BO+G05ePADV+7AV/caWkkq7cTeWFz08vRc7UXTlaikAxTScba1YSwy35ngjTfPw2qEn2LVWCy7Yoe0AGZgFYD+t5CeA6B/pMi5WuyhOBA+r9zbw14tWXS3a29Mm4L9fsXIsNK/+gpO5INFMZ2zYFnfHN+YVoBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs74g2GR/RtVt3DNA8stXb7+SggBwO49+DX5xxUiI/Y=;
 b=BFro73De/GEeyYbWmucAFthkk9UtkZS8hKTeg9hm2qWNKUBc7YczzT3+U5Qhkggr0mcCebmUBFWkjluAbqybVFcTCdl7MVnYnZRaioKEVsKiKTLuXF+8IFDJp2J9p8H8aBsfLSlQz/dmuJGE3oGjwBbRSnSF9WA2JIxs4VUj+Bc=
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:22:01 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::5155:289a:c3ed:f959]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::5155:289a:c3ed:f959%4]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 18:22:01 +0000
From: "Pan, Ellen" <Yunru.Pan@amd.com>
To: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lu, Victor Cheng Chi
 (Victor)" <VictorChengChi.Lu@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check for PCIe atomic ops support when
 reading pf2vf data
Thread-Topic: [PATCH] drm/amdgpu: Check for PCIe atomic ops support when
 reading pf2vf data
Thread-Index: AQHdReb6vzUnJZRfZ0OHZvSNPYJiI7bRhHiw
Date: Wed, 16 Sep 2026 18:22:01 +0000
Message-ID: <BL1PR12MB5062C6BEA2EF6EB26A01FAC8E9B92@BL1PR12MB5062.namprd12.prod.outlook.com>
References: <20260916142307.94158-1-victorchengchi.lu@amd.com>
In-Reply-To: <20260916142307.94158-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T18:21:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5062:EE_|DS5PPF7671D5CC0:EE_
x-ms-office365-filtering-correlation-id: 90e76377-32fb-4c21-f906-08df141f6730
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: DjQaDTXvDRXqh5iFWqmk6xXbtgKGbjPcev+sKs8jKLNAHCSTpoqLk0CqnmmhbxB6UGVMOQ75RN91VxQRK77BcEIon5YSUhoH19tk/J8GpX+oK/vsO3OzpdQJ5RgjbSrvejBirj7CGUTMP4pDpfQlvddsApLUcCMdzzhWHs8/MogcW1D9bFdwieJ798UAjXTqVTwXXp9TK2wuFfC8NIujP+SedYW1Y6IYSbJaqoE/TopHp/JW45UhpwxMdKPdSLz4Qprn3hjO1wta3t3AEEhL83Ti4NdAuZvCC+rT0VvtAH/2FJ4mvEPnQ0YQii9IE7nb8TUWP10Cs8S7Btk5fR3UF5xDlmFC8/X+uwsoXy7ReW6Y4KjLaymWqzMoUwszWalwlzn7jZmi8emPOsBC+gCTsHIvQ2vA4YCKyw1Ec+L4PF+rS7uWxTS9fh5upEaBDxHGly+7A3acn9axTpqv6LSRFf8yMpM6e4nESUlpWAL7i6PTOUsNTuwMgdNl1UyjppD1gfwvF6/SYTBhWgDDU4aVr73by0frgmJT0qImAbp1Hcs3GFtgxwPZjupHzC1yp+qPbMWfNhbXc+2VcV/Dd6jgBbIDASw9+kc7fEt6ba3faXHkU8XIroSd9pfMN33zYMjOAFm/LOzDTkLBc5eHjrn7PQWmirvWdRkzkaMGkmci7bJv2xOZvpWreflGL7cHpc+QYPoyw9s54E0uvjp39wNlOsmRzkXHrEM01S9rEpnnYfQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5062.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RvebJ6luumTEv5TSuDIEUjlVFc+NJ8wg3S1iEyH0lFhZYTMoAKcpw3VuF8jG?=
 =?us-ascii?Q?5JL6E0REnbaxgaC3nyV1sG6X7uSk6zBuAWsMCK2o+cryei3cokFy0LsBetWp?=
 =?us-ascii?Q?uMMFfhqsQwmHzSVvMLwyTHwbHs1e5e+0QUZMoc+E7GCfTg+NV+xvKbOVPSBv?=
 =?us-ascii?Q?FiYQw3T/Du0HiuRMA7d/V975Xk3dQefzxLV+6oGOgRYPr8vPZ4SRL7/3joPD?=
 =?us-ascii?Q?v0KrSMWEK2U78Ssdw0huu3zOo4T1owKFul+35jz7fJU59eVpIkS9KjyGahay?=
 =?us-ascii?Q?s6mT+4wt6x68EGGw0tghZdxmP1wRrmMH+ulNg3LwJVHohgmmspgZ8wHilF5K?=
 =?us-ascii?Q?bIFZr6X5PVg/wwuE9FB41vSDUvxJO+zMhtorubqE+UGpAy0SAy1ADuKMMyh8?=
 =?us-ascii?Q?5yjkXUStODchFUcSx2sXKioJw+oMk3tX1KIOujJXzczKhSRF2px6FGq/ypv3?=
 =?us-ascii?Q?n5Pl0DTDbLuhkORpH6MUfo2zKnzD98ln4lqFdDxzvVd4O/6DbX1zFtv62eNM?=
 =?us-ascii?Q?hfV/QtzNGOR2T0cKO7ZtCZs8c3GgYfODYACZZ8tHuN+P6rb+uBiezsZlTc3F?=
 =?us-ascii?Q?oH1pDtdSWGe2bUc0DrzA/NK4rtIGU9+kAWXVmf7cjux9nBnsqgqFMRRIut+h?=
 =?us-ascii?Q?yJ1mAf3MoBJ83/vSUjQl1wX7edPOsPAx7EbLHlVqQZiANogx//Uu6H+ePcB/?=
 =?us-ascii?Q?yZFIZR3OszM3TeHK4gfT+/LVAMjtAoS6yzCldyywJLN9eenxceuOuttvwcqj?=
 =?us-ascii?Q?mYnIytish74LYVeK7Z9WoBkKO+ZzZm3g+rOC57tlpDXgS0U7XsE1cZyxbQFW?=
 =?us-ascii?Q?orZErOWKOXR+1SotjGJbX6pYVnXmkGaLB3oX0f1Xhtj8XPTapzr6o6f6/eJu?=
 =?us-ascii?Q?b0OWAVw3vo416E4eiwLRIjoHHU9d6bDbM1Q5p6NV2RXlBjZ9HH9t3Afcn9i/?=
 =?us-ascii?Q?pIrpDXpJtaUvjPUC9Xty0Q7zt2JgpLQqOXizbh2O0Pgqy4/Extj4owqLel5U?=
 =?us-ascii?Q?KkFWqNk2IyaZhqQA7K2AZj0dWYFI/6ZQJR10ruZzIwM0x4v6/aqX1ldZYhGr?=
 =?us-ascii?Q?J2+d20olMV5Jlicl3B8LQgI7fTYrfdCBujl32EUwNFDVoG4E6EHinJSjneZP?=
 =?us-ascii?Q?3FraoEJ8sakGM4iFsCrare/GXUK5ncOqaA5TaJUhLnLJ+dOeA6hDbgESxCzu?=
 =?us-ascii?Q?ZpUfdwZQaeVPKQ4YrFWUjUWkpEM06iomySvDdi3dz1BXUL0LGheS/dVaHwde?=
 =?us-ascii?Q?iR7+wqLUJepKfRrSCUedg301mUNFl+VpXsaSpdbqU8+25XlVrcT0QC5WUUkq?=
 =?us-ascii?Q?O2BchFkWLsorzTkfcfz3y+h6vjXXA6zdy2bVezSP2twVIPA6vy+ttYfgvytS?=
 =?us-ascii?Q?4TM95Q1XAjtkzb+5lEolNXyyuShSXLy/ocLJO4bHPbOdK267CVmGWVaqpk0E?=
 =?us-ascii?Q?Ha5Z9fdikUtv2ltsYNXnt64vqbbytZlFrqL55ovkjbqqR88hOmygb2X4oujL?=
 =?us-ascii?Q?AGKPtrxPZeDLcRgt98RM5y11XeyVv94vqCcdB5VK/y3E5r4PqmxfHW9nPkZl?=
 =?us-ascii?Q?Y5o4UFkBc6CtNFg1vR2qgw2uRVDWOpomuMK1Ktgiqokx/c08pudSY8lc0P5S?=
 =?us-ascii?Q?cuxhSVgqs2HeBx75gHCqJ1x68SNxUXy7uu/CNZBWfYIzMStt9VErUrNSC3RH?=
 =?us-ascii?Q?OYQjKjlGQEXHpU//pH6N9Zo/u/VPiUSSUzJpuzG8azzkUinj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e76377-32fb-4c21-f906-08df141f6730
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 18:22:01.7462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ET0PgeRHGOFP32PKtL4ipTDmRqRxJmWHPvtWjPd1Hvwmgyi8xIfCwCA7KohKV+Rx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7671D5CC0
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

Looks good to me.
Reviewed-by: Ellen Pan <yunru.pan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor L=
u
Sent: Wednesday, September 16, 2026 10:23 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Ellen <Yunru.Pan@a=
md.com>; Lu, Victor Cheng Chi (Victor) <VictorChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Check for PCIe atomic ops support when reading=
 pf2vf data

The critical region v2 patches clear the fw_reserve.p_pf2vf variable after =
pf2vf data is read the first time. have_atomics_support relies on that vari=
able to check for PCIe atomic ops support.

Move have_atomics_support check for SRIOV VFs to be when pf2vf data is read=
.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  3 ++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 44091ac12fa9..42704dd8d790 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4012,24 +4012,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        }

        /* enable PCIE atomic ops */
-       if (amdgpu_sriov_vf(adev)) {
-               if (adev->virt.fw_reserve.p_pf2vf)
-                       adev->have_atomics_support =3D ((struct amd_sriov_m=
sg_pf2vf_info *)
-                                                     adev->virt.fw_reserve=
.p_pf2vf)->pcie_atomic_ops_support_flags =3D=3D
-                               (PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DE=
VCAP2_ATOMIC_COMP64);
-       /* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is=
 a
-        * internal path natively support atomics, set have_atomics_support=
 to true.
-        */
-       } else if ((adev->flags & AMD_IS_APU &&
-                  amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION(9, 0, 0=
)) ||
-                  (adev->gmc.xgmi.connected_to_cpu &&
-                  amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(12, =
1, 0))) {
-               adev->have_atomics_support =3D true;
-       } else {
-               adev->have_atomics_support =3D
-                       !pci_enable_atomic_ops_to_root(adev->pdev,
-                                         PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
-                                         PCI_EXP_DEVCAP2_ATOMIC_COMP64);
+       if (!amdgpu_sriov_vf(adev)) {
+               /* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rath=
er it is a
+                * internal path natively support atomics, set have_atomics=
_support to true.
+                */
+               if ((adev->flags & AMD_IS_APU &&
+                          amdgpu_ip_version(adev, GC_HWIP, 0) > IP_VERSION=
(9, 0, 0)) ||
+                          (adev->gmc.xgmi.connected_to_cpu &&
+                          amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERS=
ION(12, 1, 0))) {
+                       adev->have_atomics_support =3D true;
+               } else {
+                       adev->have_atomics_support =3D
+                               !pci_enable_atomic_ops_to_root(adev->pdev,
+                                                 PCI_EXP_DEVCAP2_ATOMIC_CO=
MP32 |
+                                                 PCI_EXP_DEVCAP2_ATOMIC_CO=
MP64);
+               }
        }

        if (!adev->have_atomics_support)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 73169cb775f9..a454c6f12d38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -652,6 +652,9 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_de=
vice *adev)
                adev->virt.ras_en_caps.all =3D pf2vf->pf2vf_ras_caps.ras_en=
_caps.all;
                adev->virt.ras_telemetry_en_caps.all =3D
                        pf2vf->pf2vf_ras_caps.ras_telemetry_en_caps.all;
+
+               adev->have_atomics_support =3D pf2vf->pcie_atomic_ops_suppo=
rt_flags =3D=3D
+                       (PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_AT=
OMIC_COMP64);
                break;
        default:
                dev_err(adev->dev, "invalid pf2vf version: 0x%x\n", pf2vf_i=
nfo->version);
--
2.34.1

