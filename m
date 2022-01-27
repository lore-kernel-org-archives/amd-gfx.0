Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8103AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 14:39:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D89110EBDA;
	Thu, 27 Jan 2022 14:39:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D5610EBDA
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 14:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1lCF4hRfTDMoapN5K7xWap5GWtUDPRsrFtadBXaQ1Pv2zIix0vRuIAvBa0BQ+mZKq3JRGrv9+Aj1KGjgMRrHY3P1/SrTFe6SOGvdblOmsJJC/IuiOjBrYXLh09Ile63rP+4CtBNYqgSa3bTWrwWfQIIhItwzxvMjJeoyjff4vWgIuDnLJeJBaF2eRmvudYB5gFLSCiXKSk/uHKwzGpfUTEzSau/OdgS2IjSR1ZiHANpfp80tuV5EVfD2Mx4zzGDU6JHfr3bKLMK8OScOJVRGPhaAhezjVYbcJg1//lS3YTyoUdQkgEuC9Pn0shMeKrLnaNNYbhml6+L7l6k0iPkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN5gTfrY0MKD5HEQxbAlBPWkLXSRQqnnXNV4Q2XURME=;
 b=ifM6hx8n8sYkUxqZYBJrr4hJtmqu272pcE4y+FwWSD/BIf/s1v511xlFtSLQ8TpGY8YKZmtVvOhD2zbw0Zfk0Kp+f1Rg4LrSWyBH3DXWLGqhYLrsf85NDjOgcZ10Khe6xmwg/IyiUUvlhD/eGjbeZCV2KtAdcNWJYvCkrkX0ydih+7SzsNxqG6clzAS7Nt4Eb0yQi4kw0BlhZaAjAndYaAGlPhISPpw2iCkBu9sbSvpbBiYX0BxAkRI/CUtnYT36TNiiLCieTRGkY7JXuZgXuxLrxD2J+ddogr/vg2UgAYUhJiJYvbPGXR0JVYeSH/b0EAy28MRHDkZrYMXZibdPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN5gTfrY0MKD5HEQxbAlBPWkLXSRQqnnXNV4Q2XURME=;
 b=i8EGTVeaWcW2haFElq4OwJ5o9CCZ6egYo1P7OepxAmH0HJ02HpPKuQKphJZrHiWDRhyLhL4UjuukifYSpnslN+smDQ4hsD8JpRgCl8+Vh3Arc3gtmgs3SLhj2aeSDPzygn6HasfH/24UREt1eC7eBLMg1hy6qA24rFpUGOq3ik0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 BN6PR12MB1123.namprd12.prod.outlook.com (2603:10b6:404:1b::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Thu, 27 Jan 2022 14:36:56 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 14:36:56 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, brahma_sw_dev <brahma_sw_dev@amd.com>
Subject: RE: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support list
Thread-Topic: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support
 list
Thread-Index: AQHYE3OzFnuywppRz0e/ePxZ4NPBYax27zig
Date: Thu, 27 Jan 2022 14:36:55 +0000
Message-ID: <DM5PR12MB2469CE0861450AA73623FA1DF1219@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220127114718.836592-1-majun@amd.com>
In-Reply-To: <20220127114718.836592-1-majun@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-27T14:35:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=c3f1ab8b-dfcc-44cf-8c74-248b3f6547dd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-27T14:36:52Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: b024a13b-5484-45f3-af22-1d77ab57e011
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cff4a56b-b3ed-463a-f485-08d9e1a277d6
x-ms-traffictypediagnostic: BN6PR12MB1123:EE_
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR12MB1123F480E75486D3E446234FF1219@BN6PR12MB1123.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +580kBabP3NVBE//gSMoMO8BplvWFWW9RQ83xzE7/UE2LEkjb/T5pHV/UK9oU4x5yboVcGQRNvlxbT8VS2AYW73othxTqCj3mZLe9Q3MVGz0gaAvZHRkCtQPUu9Ql5lxmz3cZPNlrQVzt0wVW88IzEXJFRugy1kfUkzKvw/6k4BSINrLhZX7Z6Ebss3p6Gc8sJtSaJXio/a7O2QIdW7UCLnag7luIgITI9oPIgKQnRPc7OZ9Rfmh61c1u0x4ooIUUOxMcVz/IA48UedyO9OZNNBKesiqFnlXNKJ3d9dwkkz/2wPuq1cyT3lY1cyxm8RM7PrYJMdmhhgeLccWy8IVzToZzbbXK8idxDl2C4LXKvj+TSybmE+5Tfn+RUUf7FlCUrxWyJmUsEMwbepDq+OTidct6x5wboPcd+CItbngvsTvd2CFUxGeTLfpVeSVbQKd8KLVGlvXSl/VfRZoPKvCuIyMe5Ak8NiO+hpCPKnB03J8VRwD2JBo79bytOqyTN3L8B8xhzhh70oApK2EybcTb23pDmdAAzOyUKVpipv24NAvCP4SZpLuCucMaA4sJAxIz73ZdHCnvJdkiO8d3qARUcFd7FhZBHptTUK38wtoK0FSyhTb/HIzCsTAVJdtjs5n3fYe4eSgXtVccreuncsocfIR+XK1PBNNGX9EW2H+/r+hf+kc/RibS/ylRBkSgisZRfZWIDPN/5JcczN189nUtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(33656002)(5660300002)(186003)(26005)(86362001)(316002)(66946007)(6636002)(110136005)(54906003)(4326008)(55016003)(83380400001)(64756008)(66476007)(66556008)(38070700005)(66446008)(71200400001)(76116006)(52536014)(8676002)(8936002)(6506007)(7696005)(508600001)(122000001)(53546011)(9686003)(38100700002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k7xzi9aBU/gj98mJNW+NK9rtYIo4DkT9Jal3QEIX+qIjV3xRZvJnklcGjg7M?=
 =?us-ascii?Q?XGa63gwxJbV3n8uHS/rvxezftYcZWIaT8zdPI+QuHjKDFu9Xxw7+w5uGogr/?=
 =?us-ascii?Q?arver7yfVQjWD+fxOJElF9ujRPq+7QtMzXp77HTFeImCPEUGgtON8b3vWbYX?=
 =?us-ascii?Q?0btjkRI1cHMw1n1X1mRh8c02uSuILcbvVOj51Gow6dBE1rnStA3g9iocn8KL?=
 =?us-ascii?Q?DRyu1qhLdcs2NclbnwoULIJtgoCkyHeKRB7pOuBj5f5Y8lJPXVQfAV+CagiH?=
 =?us-ascii?Q?R44lpMgrNGlG7JtYegQwPTk9SD+fiWE9jsGGWEvyrY6fNre8n1ogXLjDrOF0?=
 =?us-ascii?Q?LYlwBnHldN5Rc+VMyeqBIAusKZ1eH3RjA/9qcM8toR8SGUDxj9ffBLMQ5+6W?=
 =?us-ascii?Q?csqlyWl57VcgUOdv7W4fTkTL15oaFzpi1PDTY5zdLLZAmASJHs7ggmDVGRtW?=
 =?us-ascii?Q?ztLSXyAT5t1HoA0Yx/1g+Miebq1nckEgq8nM788d0cQKooojnC93eKqmuJLj?=
 =?us-ascii?Q?Pq7dPt8yZOUsTCXH4U9A3dZ2yB0MQkkFEMMZ6u9pHY1BfqTTEoLyePrH5ndQ?=
 =?us-ascii?Q?oK60/xPipxCflW1/5pB99WdYPzXDWL8GfetxtwckU5MYxp1plqimt38gomOU?=
 =?us-ascii?Q?NbZcDvU4Xi+pz82LWQu3LlYmlOZku73C30U1kKG6y/FcULBIddJKv4OVPRYm?=
 =?us-ascii?Q?sou+D8v2xo0CZ5c62YNVmk/B3vwo4LL4zpkArnezWW1hGQBzhxHqvMxVLCDv?=
 =?us-ascii?Q?zP5lQ1mdkMsFVvRR5FoNOE6zg4bymcLaGtiwR6y+K2p5FOoww54gEFzCL3o5?=
 =?us-ascii?Q?3tODq+CDWOouIwVIfDDTgHZskFORbbEMMsr5LhpA/J5O9Shrbtdvhi2pgtnI?=
 =?us-ascii?Q?ATIXEBxzIsF05ePdFqwScIap3hjS/y88kOw8rp4cV4+QqbPpmZ05RE12liCt?=
 =?us-ascii?Q?/zs+Ke+vh7qFqnH5LzIZXA/ncJNOj50C5/z8CFQkFBN5ecpRbszjIIJX1Iw0?=
 =?us-ascii?Q?gGgNT+mOW/IFxpAbsi7ZCLGLY/2a0nBQ6MSXKXEqpCdBqmqSAiLVn64m5eeM?=
 =?us-ascii?Q?9y+KK4XV7gYdO53XJbGPhKgdf8U8vn5LO0QkVOVV7xKI/kWMQl7G+KvWquDj?=
 =?us-ascii?Q?OYAAv1tupaGlQLovAL7TJuB4RhmwYBeN+XNRSapL/rx649z7qg6yjORGMrai?=
 =?us-ascii?Q?3w26KONpygVC3UcabAlgF/Cr7V2XCbq5iU5QcXPKkLXl4lq8YNDVf8VRcTkn?=
 =?us-ascii?Q?hLfIP9tLHKE2YPC/IvXKiYAs+uXhqhmx7oOOdUR/IHpD6xWchO5kQCAVaMj8?=
 =?us-ascii?Q?PfM3DhpfspNUFb3OeMfCIPdqIuBPJ5eH82FsY/4Bvjn0Y/o302hqidlbpJUi?=
 =?us-ascii?Q?5GOpa292TTmdULQ2UjMrGl/Kzy2TtKVNItbjqYRqQX224C90VYCJUc5R0RsE?=
 =?us-ascii?Q?IjexcNcohgBZZRmM/TfhmVS8SgHFS89oTQDuSQPeJoC3mvSABpopOGq7Ag1Z?=
 =?us-ascii?Q?uL3iSAoXZj954P4CrfrPY8DCGRJzIc28pamqHtXDrDN2N2BIuQ6JoLoae+2V?=
 =?us-ascii?Q?qz7yi+ccM4jj9Np070FrxbU+B4iibzVieXH+GoMDuwwrqOnCyX23bS9TARrR?=
 =?us-ascii?Q?MhfnNVEwAbHjHOrBnEwhtT8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff4a56b-b3ed-463a-f485-08d9e1a277d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 14:36:55.8976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W811XOcJRrSMAGsJjYtwmQyQrFQ7sCZlXJf/i0A78Biu7qafGx386Yoi4Th6lsW6lAdGCBRtw4cK1PfkFSZlDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1123
X-Mailman-Approved-At: Thu, 27 Jan 2022 14:39:08 +0000
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Jun,

In RAS code, we have this special handling for Vega10. Can you elaborate it=
 please? Any problem you have observed?

Regards,
Guchun

-----Original Message-----
From: Ma, Jun <Jun.Ma2@amd.com>=20
Sent: Thursday, January 27, 2022 7:47 PM
To: amd-gfx@lists.freedesktop.org; brahma_sw_dev <brahma_sw_dev@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH RESEND] drm/amdgpu: Remove the vega10 from ras support list

Remove vega10 from the ras support check function.
Base on this change, the ras initial function is optimized.

Signed-off-by: majun <majun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 +++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 37e9b7e82993..aa1de974e07e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2129,8 +2129,7 @@ static int amdgpu_ras_recovery_fini(struct amdgpu_dev=
ice *adev)
=20
 static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)  {
-	return adev->asic_type =3D=3D CHIP_VEGA10 ||
-		adev->asic_type =3D=3D CHIP_VEGA20 ||
+	return adev->asic_type =3D=3D CHIP_VEGA20 ||
 		adev->asic_type =3D=3D CHIP_ARCTURUS ||
 		adev->asic_type =3D=3D CHIP_ALDEBARAN ||
 		adev->asic_type =3D=3D CHIP_SIENNA_CICHLID; @@ -2164,13 +2163,13 @@ stat=
ic void amdgpu_ras_get_quirks(struct amdgpu_device *adev)
  * we have to initialize ras as normal. but need check if operation is
  * allowed or not in each function.
  */
-static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
+static bool amdgpu_ras_check_supported(struct amdgpu_device *adev)
 {
 	adev->ras_hw_enabled =3D adev->ras_enabled =3D 0;
=20
 	if (amdgpu_sriov_vf(adev) || !adev->is_atom_fw ||
 	    !amdgpu_ras_asic_supported(adev))
-		return;
+		return false;
=20
 	if (!adev->gmc.xgmi.connected_to_cpu) {
 		if (amdgpu_atomfirmware_mem_ecc_supported(adev)) { @@ -2203,6 +2202,8 @@=
 static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
=20
 	adev->ras_enabled =3D amdgpu_ras_enable =3D=3D 0 ? 0 :
 		adev->ras_hw_enabled & amdgpu_ras_mask;
+
+	return true;
 }
=20
 static void amdgpu_ras_counte_dw(struct work_struct *work) @@ -2236,6 +223=
7,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	int r;
 	bool df_poison, umc_poison;
=20
+	if (!amdgpu_ras_check_supported(adev))
+		return -EINVAL;
+
 	if (con)
 		return 0;
=20
@@ -2250,28 +2254,24 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
 	atomic_set(&con->ras_ce_count, 0);
 	atomic_set(&con->ras_ue_count, 0);
-
 	con->objs =3D (struct ras_manager *)(con + 1);
+	con->features =3D 0;
=20
 	amdgpu_ras_set_context(adev, con);
=20
-	amdgpu_ras_check_supported(adev);
-
-	if (!adev->ras_enabled || adev->asic_type =3D=3D CHIP_VEGA10) {
-		/* set gfx block ras context feature for VEGA20 Gaming
-		 * send ras disable cmd to ras ta during ras late init.
-		 */
-		if (!adev->ras_enabled && adev->asic_type =3D=3D CHIP_VEGA20) {
+	if (!adev->ras_enabled) {
+	/* set gfx block ras context feature for VEGA20 Gaming
+	 * send ras disable cmd to ras ta during ras late init.
+	 */
+		if (adev->asic_type =3D=3D CHIP_VEGA20) {
 			con->features |=3D BIT(AMDGPU_RAS_BLOCK__GFX);
-
 			return 0;
+		} else {
+			r =3D 0;
+			goto release_con;
 		}
-
-		r =3D 0;
-		goto release_con;
 	}
=20
-	con->features =3D 0;
 	INIT_LIST_HEAD(&con->head);
 	/* Might need get this flag from vbios. */
 	con->flags =3D RAS_DEFAULT_FLAGS;
@@ -2545,7 +2545,9 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
=20
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  {
-	amdgpu_ras_check_supported(adev);
+	if (!amdgpu_ras_check_supported(adev))
+		return;
+
 	if (!adev->ras_hw_enabled)
 		return;
=20
--
2.25.1
