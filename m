Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61AACD343F
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2026 03:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 116EE10E35B;
	Sat,  9 May 2026 03:52:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2tmAA+A";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCE410E35B
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2026 03:52:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0TfUkmhGqYV71PaYJvS5Yp+1DNq74WELls5HDYP4dqv6JlrFHaNF9c5XJ02YU2DcabOvCkJJ+q+5crVzrIlPR6SPc3PiAefVW3JqYXNPNQUVfyiBQ1Y+xn0iNMR9KNOTpjsHaiWdRhh4tvZWvvDXMWu4ciQTgaub8P1xPCtZc4W+jdSOQoV2PC7iCtADgeNm7LVVhS6GO2Z2TgH9G1wBVNr6OwEsYdORAKUYxal0YBTa293tRpS+/b7HmHzlebPNBH/ZbrqYGjuBKoR02WDDHyQ+wFdn4OcZPsbHayxdyMEG8CqkiQfrkllXu3CmPdG5KKG89snksgJ1f7Bhw2rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27e23ecW9AAJQNS1hOl//jtzftICJEV8TLf89uApN2g=;
 b=Eb59RSA/4uFzpTrog8lj+CvsH0wxTShx4vV7g+PnL+qpEHRSLx1OgnSV4nDOM26AJkmt5NVlDm67aTSRpG/WO939eC7R2V4JLpks191knLFav3msobS+aGs01uKlbOaIT6qrZC+B5d1vifhCapSjhnwQqq9/ApdmLXq9DNHOUWwFyVK+OiXmu0QrzGUf9NYW5W0J2XHH7hzd6WGQSStIfKpoUSIKKKwvr882wi6KySOdr3oaInQ3Tpv1tPFwiY7OZ/Y2i/PE3J0gcmSIrHr1607vvPmB7U0OIlmRKHZbM/PcKOjhhG1dc+NByqVPhb5FsLnJlAhSz9Jtv+B8ua9xgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27e23ecW9AAJQNS1hOl//jtzftICJEV8TLf89uApN2g=;
 b=R2tmAA+ARxEpuXbslhHT6adcizBSWBVUCYshEwSkyKxmvdmEBUYEYEXONz70DXxIpVXJHx/Tn0uECO5sRBjbqq6R/bcrfCglQfiF1RwceLPZ/4ErGejtHqYGsWaPPu/EvmRrmoNKaVM2n0RMCqXAHPd/jpfxzNwD1Khe8N/a3b4=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by DS5PPF7671D5CC0.namprd12.prod.outlook.com (2603:10b6:f:fc00::653)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sat, 9 May
 2026 03:52:26 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.20.9891.016; Sat, 9 May 2026
 03:52:26 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: update dpm clock pm attributes for
 aldebaran (gc 9.4.2)
Thread-Topic: [PATCH v2] drm/amd/pm: update dpm clock pm attributes for
 aldebaran (gc 9.4.2)
Thread-Index: AQHc3r7K4l7SSJ+tkk688hIwT83SO7YFEJ3g
Date: Sat, 9 May 2026 03:52:26 +0000
Message-ID: <MW4PR12MB680304F71A5091B92389A2D58E3A2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260508074615.1629636-1-kevinyang.wang@amd.com>
In-Reply-To: <20260508074615.1629636-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-09T03:51:01.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|DS5PPF7671D5CC0:EE_
x-ms-office365-filtering-correlation-id: c0470137-3e42-4763-ca6e-08dead7e629c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|3023799003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: xtp+ZGvIRq8cVMZjz/neY9BtvvNUmG3s3PS5rmgaFJCTHf+XyNS7rqxzGn08buhG/xVXPSJcCgmWrs0r/mLHf9g0a6Hz+lALT5kWvnWf6tJ7ENMElhfNqg8teI9+FUCkKmQwMfwKAgc3EOrmGquEwHQgillLM2YjbpF/dstsll4WDx+tj5aDNTwnFKfvZp9F6jtoly5YaQ5/GWTeZCeHl6rLWnYtsSClGSE3AyQhcFLgOB4VGPSYsK7Q+FANE3z2dmcTXtggzH1Ivh6YABTx7pe4gvWNXIqaFsA+N6mEbth+DEBT8uelEd/C6XHxpS+c/6QDKGuAVEPayqON+PbdEb2g9dwCQz4mnQ9ai7YBlT4cZpJev9PoKHHJ6TT3hUKcjABoRtXl9Tr5Qx8liQpJClBezIPEbFG4iR/lOXwZzetWqx3BHYPIaHtjZIjBoDn9GIS0UgZsYHPtynFezWLydTfJSOejH1y+E2mn7Mr1QxoMbT88Vjubh+lkT93BfBw6yyaCqKpmTLB8ykeW+yYTUE9jBEUPcfF/Z0lESrwEd78IWyIeAND7MMlAQpcJkQ811NcTUNhOZa10afpUPtMII+7H1h/ifSr2pZ70J5iFkPUuM+/sHOVxvFqBJXaTpy6Pfq9FQuqigEhfPDmcMZn32vRnBSEEw2anBw0Rd/oNA1FRriZ8ZHfGxYT7fKU6VlP+uTFXIJOQQFHVkc0ndGFRk6V8JVPn8/VwULqNNzt3X81iZBQyBu7S5YlWxNSndO9Z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(3023799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sh0fBFT8l+Gog01TODQ/Afr6cdNEv+tWWrQI2YoR2AfAE7lkQVfc3XQATQ7g?=
 =?us-ascii?Q?CXP6DMeGvxMOkK1Cd6Z/r5YkKYEpkfTK8WGbUtq3zpWckOnJ6iCt1DecTX86?=
 =?us-ascii?Q?jnQ8a3TiB38wBfUtVrbJ0XkPdNsa4xSjxx+Jw+Udcw0QIU7zHDM0tjL8kNSC?=
 =?us-ascii?Q?Z9MjbqhSWaSC81CV+2iIW+pAf4YyLkNn6mphJZXKj+zWXL4EHADtJ/skVSCR?=
 =?us-ascii?Q?y9BJP+k+TqDdgkvT+oDJDnF/PNlVsfM3rprrZKNv/cJHjkqhfKqHHR3kHjtZ?=
 =?us-ascii?Q?GCOn2J5FYj+STLle2vbKq/lxtFFm26MRSXDR93ZRCfduwpqcyzfTgs+GG+BZ?=
 =?us-ascii?Q?St3z/gHNnX1KIEyRMIyDnC7Mj00E7rvgMufBaZZrx0TSExvWBaidzirNDXzv?=
 =?us-ascii?Q?rWnSbxpt72JuQla6tmfvn84sB32q8J9sz/aRKxJl8TvrJ16ggRiduyav61jt?=
 =?us-ascii?Q?M7Ed0GvsVbT+9T8Tp9UAfAhyxmSVg7lqokpoyeCGeGgUSxjSCJ3920sTT6we?=
 =?us-ascii?Q?qXTZVu+OG2SjShYQnV7KKy6tisnkAi2w6Ky0coZk2palbNDTtQiU83xxOUeD?=
 =?us-ascii?Q?b5wuSUXGjat9JJypSJ6UClOrxIbM4ZErEUwXJ4i6j/0ooDMof3M8aNGWMlC6?=
 =?us-ascii?Q?moYZUEBrC9SrF6qg+kde/bJGXAqtm2vTX+CYXjNBP8hd40HKcFLszULNdBal?=
 =?us-ascii?Q?LqMOwYiPidsohAeDVyT5rhTaordzY5qvNhLld1y+nY2X6KLu75CjYCfHR4w7?=
 =?us-ascii?Q?iJ1DAn4Ckj+xX2NE88LHOJbaxDm4BzhKe4XXSYzm9mxsFYRDxyU1ixIMA42k?=
 =?us-ascii?Q?jw+AvEoHZIz5wUVtx7rl62rnw5eN57aQh/8Jqo/3MYn6l7HVwg9dOc2pqp9Q?=
 =?us-ascii?Q?l9pqhtRmXUq+mF8QdqF2yQQpTicxq10ENK9aTHttbdTMJu++2smLHH0t3PkS?=
 =?us-ascii?Q?ASTezzTRKi94L7wF/3fx6HFGmRtVUAYCIbzswXWj3hl4+mFDINfJ+e/3s6n8?=
 =?us-ascii?Q?MdLxCmOkIaQrfBX/gX7+NknQlFlyk8y8YswS5TuC7DDYtneeyHJmfGFCKR4N?=
 =?us-ascii?Q?+mg0KrTEH0geKsN1hiQ+Jp9gAiM3ZrpaBciK1W72KdU0Y36PaVAcMcGjswBf?=
 =?us-ascii?Q?V6iE0ptgZiHxnMAm87VAtzIv/nybYm+IbWTVKRsEMKdfKVN5Vf8N2MeD9ZCm?=
 =?us-ascii?Q?5OBH43VOwbbI8UQT5ufnO2hf7neV9N2vMBk/6VGH9tdQ2rKx8MtQ56sRD85F?=
 =?us-ascii?Q?7wmgWsbr1dhiyBeZFbMXcasoH7S3sk1hfjOc/HZzhzIK8ELDh9ikWKLdg4zR?=
 =?us-ascii?Q?oE1a+1uHSvpI93KRhUmWLmuIjklo78SbDmDo1mjV2ekNlybyX8qOAlulxZzn?=
 =?us-ascii?Q?upX1MSxj0T9niFIzT+ZNlh9JmB+9ItGGs3wEeDMXpn6cUiEQ4Tk2QSpBueyS?=
 =?us-ascii?Q?91w4J0Zark/IcwWTpPeDFRE0afneMmw/mfsDT0zKEj9OhYbMXfH5NmLjMkbi?=
 =?us-ascii?Q?hxOT6JPMDHyKAkD9knNwbYFV7XRXfhTuU8LZuN0uxSBSoO0MnnDUsRsyAgTr?=
 =?us-ascii?Q?oKJAhK/ifArdwpGRmawsZpCLHKEFm4CgJ4t3BRF5ioO/yQT71Xd2cZzxT3lh?=
 =?us-ascii?Q?ry+XXj3Uq1TNlY22SLRXiSlMz4Pu0Z15ai2/hojlaqGmtGkYLT0fWYCNfVNF?=
 =?us-ascii?Q?JF3ZzzQMYTd1ee9S0RTc6U3eRBMRVskYOfUXsty++z/R3/HM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0470137-3e42-4763-ca6e-08dead7e629c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2026 03:52:26.4282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+L/XBlRyVoCIrbsuR0MeGvpf4zDUoL71S5l7F5Rb2AwKWo7558GmxmF8uTwyTDy
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

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, May 8, 2026 3:46 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Kamal, Asad <Asad.Ka=
mal@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>
Subject: [PATCH v2] drm/amd/pm: update dpm clock pm attributes for aldebara=
n (gc 9.4.2)

v1:
Separate DPM clock attribute constraints for Arcturus (9.4.1) and Aldebaran=
 (9.4.2) ASICs.

- For Aldebaran:
  * mclk/socclk: Disable write, only voltage control supported
  * fclk/pcie: Mark as unsupported
- Remove 9.4.2 from global pcie check and handle it in ASIC specific case
- Update comments to reflect correct hardware names

v2:
fix some coding logic issue (by asad)

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index fd2e63530e8c..0c58d23013f4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2034,15 +2034,13 @@ static int pp_dpm_clk_default_attr_update(struct am=
dgpu_device *adev, struct amd
                       gc_ver =3D=3D IP_VERSION(11, 0, 3)) && adev->vcn.num=
_vcn_inst >=3D 2))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        } else if (DEVICE_ATTR_IS(pp_dpm_pcie)) {
-               if (gc_ver =3D=3D IP_VERSION(9, 4, 2) ||
-                   amdgpu_is_multi_aid(adev))
+               if (amdgpu_is_multi_aid(adev))
                        *states =3D ATTR_STATE_UNSUPPORTED;
        }

        switch (gc_ver) {
        case IP_VERSION(9, 4, 1):
-       case IP_VERSION(9, 4, 2):
-               /* the Mi series card does not support standalone mclk/socc=
lk/fclk level setting */
+               /* Arcturus does not support standalone mclk/socclk/fclk le=
vel
+setting */
                if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
                    DEVICE_ATTR_IS(pp_dpm_socclk) ||
                    DEVICE_ATTR_IS(pp_dpm_fclk)) {
@@ -2050,6 +2048,19 @@ static int pp_dpm_clk_default_attr_update(struct amd=
gpu_device *adev, struct amd
                        dev_attr->store =3D NULL;
                }
                break;
+       case IP_VERSION(9, 4, 2):
+               if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
+                   DEVICE_ATTR_IS(pp_dpm_socclk)) {
+                       /* Aldebaran mclk/socclk DPM only supports voltage =
control,
+                        * not allow to set dpm level directly */
+                       dev_attr->attr.mode &=3D ~S_IWUGO;
+                       dev_attr->store =3D NULL;
+               } else if (DEVICE_ATTR_IS(pp_dpm_fclk) ||
+                          DEVICE_ATTR_IS(pp_dpm_pcie)) {
+                       /* Aldebaran does not support fclk/pcie dpm */
+                       *states =3D ATTR_STATE_UNSUPPORTED;
+               }
+               break;
        default:
                break;
        }
--
2.47.3

