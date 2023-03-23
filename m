Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E6DC6FD1F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 02:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4313D10E429;
	Thu, 23 Mar 2023 02:53:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE8810E429
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 02:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XD1ytyanfKBuAJRBqXXtjdlZtSLZpHlSsubacW2d71YAN0lSbDrSfGt+UxmG9hNPuX8SUDXy3Jj1kkIw+fbRh/Ixzom/069gNuZkkbSMsb9r+tATDDHaFnnr2ewjMdJB0HFUV5tfNugs0D36gcWfud8UMRi8ysbmF+VLniMMaUSN+9kvfWjm8OtdYzsLvjhSXYb/C0ti3Dd9oUVMGqiOInfq8XnVpB2Dt3bRqyOkPn34iP6ZIS9o0QOghYwSZ8rwPCBaPat+kU6V776O3o1YHKyfxb3EQe9B5sCWXN5tVY0KX2HKimObsB4uvFwDakfZ8zSOs6KU28h696OWFBCzRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgNWPMZrd6TQTi/ytT4XaopFa8WiG4tcjs+/hI2UlOU=;
 b=CPwyRpiKDo+pfGSPEuWU7ACjq6dGflZ8SRzj48GUIh+C9rCcVrP0Viy963F42msxgQOGexxO5hNMJpaS3KY2QeCMpg30uwGBIZsltNd4YZQsP1IXwRbSrK1buROPugj3XOBdhkv9F8YScg1p9/NF0sUtsFiOClUbVaF3ktK0BKParhywUXLoB5suEbW/H2bpA5DJIDfEDMxQEUsUoJsPHwSINsVnGr5QaeyhR7SEL6iFtb+NVviX+xn1yUHp+IXFQItYzI8ZY2Ao7KjNdnKEJt0SJC+3gQs//Y6Ei1NM2HyXund3dtREk1fCXXJJ1Dq2Qr0I6oqxXHgWH+8HPbm+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgNWPMZrd6TQTi/ytT4XaopFa8WiG4tcjs+/hI2UlOU=;
 b=wrazR9v67JCLjfyia54BWUkmlg3UCOM+zdxkeM2J13wPoQ3bvuQvhaYb+WlV47FEPqLCX4mr8uMF9YQuLggEc842l0E6mrewGTfzDWe2B40dNAHzlu5ZCK5XrlEBhpc4VOBl30RJkQFWevQKmQhuZubcwYBRc20S2FPdeFDVlPY=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:212::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 02:53:12 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::54aa:5d2d:a4b3:eaec]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::54aa:5d2d:a4b3:eaec%7]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 02:53:12 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, 
 Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
Thread-Topic: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3
Thread-Index: AQHZXS6MaBbXBMsXr0+F/DnXGXrM/68HpfwQ
Date: Thu, 23 Mar 2023 02:53:11 +0000
Message-ID: <MW4PR12MB687544B37E9BF9F1A1B0B82991879@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20230323022344.7533-1-Hawking.Zhang@amd.com>
In-Reply-To: <20230323022344.7533-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-23T02:53:09Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=ea03fd29-aef0-4677-bc11-aa5025f9a394;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-23T02:53:09Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c94bbb5e-5c4e-4d69-b369-5c49c40d9130
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|PH7PR12MB6657:EE_
x-ms-office365-filtering-correlation-id: e30f0047-faee-4544-94d1-08db2b49bdc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MrH6rTT0R2YIiU0oHV65PBPkrxZWiUXrxmyQPRVURkeMV97L3zumhLHcrIlfYDVfEzPGsnriRKTyVgKI8GV8jObh/l4H2kp4eITevoWHxPEjFrtEMjosZfzqIRWbiKjy1cq6cWTjG8bTmhS1hzrXefnJo4ES8caAzrPmvucXwTMbkoMZUTDC5i5Hdqz+5aY1JCcSCDzTPtn8jd0QLqLhpBnquXFCxCuZ3g+X0HlXg99pJw2t8aYsJeTLLK9IORYvyF/M2l2Ms+CGHodpRe4Dv2oVUqJ5hJFWtIhcsSTmCcYUYpT4cJq7OzMswRu5D0K0w6xk9fasyktZcMZZJxIJ088bTsg6fZgtOvPAP7nhlxR1frrMHl7BXP0Vn3YK0JPlyxdEPpEc1zomw/gxSrytFnw9LgcdHlQ8/PnDylt08hiVuTTe0y5UQLilIjS6279cNLcyHtJOXZpNTtyI61ZoGjhpOmIymDgyvao7h2rkLGTjRlyx46nsUyADSaeLeKnJQ3Q1NBntC9gCemERi4NleKY51oSyUqT0RF+q0GTLmD/m7ER7WaBEMb9DhpaJunvaMv9UT5k0JZ/HBUXBjBzzc2PuVrR/ZuFxb7xmO5F9ud9tKkNX4wjIbSqeVxZvpueqlkOrTxDiOezCM/fxIbxwiUgFPK6cEm+ZxRrWbdWC65+yRq7RKrsis6OzZjb5jGDMN6hmkWQ4TE1euHolT4WTeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199018)(71200400001)(7696005)(55016003)(6636002)(478600001)(110136005)(66946007)(8676002)(41300700001)(66446008)(76116006)(6506007)(26005)(66476007)(66556008)(53546011)(64756008)(5660300002)(186003)(83380400001)(52536014)(9686003)(2906002)(8936002)(38100700002)(33656002)(316002)(86362001)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VXy9DJlGxce24GyNsuKS7qjp9K8MLZOT54O3T67RljfKLC+FhMmA1LvBIcTQ?=
 =?us-ascii?Q?8YDPStphvtQcOZxBWhQHZajOCd+Uq1WkkgjDXWOCoyLxc3AmRfIg5DMrxpQF?=
 =?us-ascii?Q?tBY78qj6CjfjDulGvwmpp42HtG9zQCvYLkwAiZRZRjTTut83y0FHlpqK86nw?=
 =?us-ascii?Q?bmgUU0B+txyJH/D+EjyKSxUSkinQfFrdCdphlw+pqqZ/6yQhsbYep/Nlo65x?=
 =?us-ascii?Q?Wd87VYEFbdTBcN08C8m3IYf5GfIBfrc/awGwM2ue2xMp+E/O2674NbdHsJn2?=
 =?us-ascii?Q?Y/PW9PCtY2VkqxF8mOBR6MH1a0OwtYAXwQ03MAj9hMFV016uWvj7WoIbya56?=
 =?us-ascii?Q?2mfp2UdpPeI+gasOB9+gaXdo8OUytqWZDWKvkgyw60EcyjwlMOo6k9S3FHgH?=
 =?us-ascii?Q?gRQ5QKWD4zZiWW8Ycay/yqkQp544huQDxQB6lq+/iyrjxgMFOYBB6LRaVKuv?=
 =?us-ascii?Q?+m8cwppcOumQtqO7INFLCnrWfobIiTWaWfHkiWOjmBNO20V2M98EVpqhsJGi?=
 =?us-ascii?Q?bk2VsBPw5RxWeHHoRaDfnBiIykHtZ34VqLpnWJAQGbcB9fMAhipQ+c6mI0EW?=
 =?us-ascii?Q?ic0GNkZrUeg0hRzgGgg5HXIlQGCu+ODsccEMb/ys5UnHK16qJ8e9ICIMpWMW?=
 =?us-ascii?Q?oPIdTqqIC6UITrYOc3auixZDCrqCOcIyIjbMMzecG4tOl2TFUlsbyxhN7XQQ?=
 =?us-ascii?Q?oIa9lLuzQGpZEO6rKgC3+PdE8IcBgP0WqjppdU0W2NRk3POjLD8sOrX006Sb?=
 =?us-ascii?Q?RJOMx9WtD+c9942otK5c+iK4DpjlxPkpbzqmjAemuDdZXqOeMwUhg5X7eZiG?=
 =?us-ascii?Q?sYAr8pROhQONg7KX4f6Dkw4VHtGHF4dtQMGgkrJ8jzzbPevYIlm+fTcTaUhy?=
 =?us-ascii?Q?UUU3Vp68eJ5SQs4vk0YDrE/JnqaNiqxa6aC45boWiJS6JkK90rt3a4v1eiXp?=
 =?us-ascii?Q?7UyvwpbteUJ+kHUdqtkXcyMr7N+fCG59W9ABqoummY99zrRdGalXW4AOXUxy?=
 =?us-ascii?Q?DuwnmCIH7vQAwFEA+6jhBwFCejHB1n185iXM66YIuTruMgjR+G+CniKa0sdf?=
 =?us-ascii?Q?luvnXR1fWEqQc79TH7g566/92y8ihp9klRtVmprXsbweYenZzKJmR0YE8dXs?=
 =?us-ascii?Q?gjhKUUufdpmHN9bEsu+59xccnPiqlYAT6lt1EKQnNif3mjnSSheHMltICB7G?=
 =?us-ascii?Q?B2TW+banPcfyOH78bD3nch14Gn7QkE47tqMyZO2jYJKVV4s7D+6KOjyF+TrH?=
 =?us-ascii?Q?14tNzq5UebYU6SIX4MRGjIRNfpLe5nyVHtpX3IPb7Mqnp+wTPxNHJ98BnLCG?=
 =?us-ascii?Q?cxYHmUUv/FhCArVVw0XjD3FEJZE3kE3WhbEwZAc5x+bXrcg6Z8gdNk1nyYea?=
 =?us-ascii?Q?HmJBl5nd1u2BiFQMKE9vDLFVg817hx0dng8szNYkmWbdVrxVzqScD1dnPm3r?=
 =?us-ascii?Q?2/7KOCc6JPGPtoCMfmYVjE+yN6QCum+ylNoI2cW/UAJ5IXr/Yr90iT5Vaa9n?=
 =?us-ascii?Q?0oq7vANQ3nNr2YeP8k/FFEkvuMhxn3K9yg3FhGTnG0CeaZk4KD3CD6KNnRrK?=
 =?us-ascii?Q?2c5qd8q+B8yooPGfuIA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30f0047-faee-4544-94d1-08db2b49bdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 02:53:11.9390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lb3h6W+UNp3KixYp6BPERqO5xuuzRL87Tk6HPolt5FiUfLoUeYZzWjdNjrgIfeBE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

[Public]

Reviewed-by: Candice Li <candice.li@amd.com>



Thanks,
Candice

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Thursday, March 23, 2023 10:24 AM
To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, St=
anley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>; Chai, Thoma=
s <YiPeng.Chai@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Add fatal error handling in nbio v4_3

GPU will stop working once fatal error is detected.
it will inform driver to do reset to recover from
the fatal error.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 11 ++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c  | 79 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 15 ++++-
 4 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c6dc3cd2a9de..5b1779021881 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -34,6 +34,7 @@
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
+#include "nbio_v4_3.h"
 #include "atom.h"
 #include "amdgpu_reset.h"
=20
@@ -2562,6 +2563,16 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		if (!adev->gmc.xgmi.connected_to_cpu)
 			adev->nbio.ras =3D &nbio_v7_4_ras;
 		break;
+	case IP_VERSION(4, 3, 0):
+		if (adev->ras_hw_enabled | AMDGPU_RAS_BLOCK__DF)
+			/* unlike other generation of nbio ras,
+			 * nbio v4_3 only support fatal error interrupt
+			 * to inform software that DF is freezed due to
+			 * system fatal error event. driver should not
+			 * enable nbio ras in such case. Instead,
+			 * check DF RAS */
+			adev->nbio.ras =3D &nbio_v4_3_ras;
+		break;
 	default:
 		/* nbio ras is not available */
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.c
index 09fdcd20cb91..d5ed9e0e1a5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -26,6 +26,7 @@
=20
 #include "nbio/nbio_4_3_0_offset.h"
 #include "nbio/nbio_4_3_0_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
=20
 static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
@@ -538,3 +539,81 @@ const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs =
=3D {
 	.remap_hdp_registers =3D nbio_v4_3_remap_hdp_registers,
 	.get_rom_offset =3D nbio_v4_3_get_rom_offset,
 };
+
+static int nbio_v4_3_set_ras_err_event_athub_irq_state(struct amdgpu_devic=
e *adev,
+						       struct amdgpu_irq_src *src,
+						       unsigned type,
+						       enum amdgpu_interrupt_state state)
+{
+	/* The ras_controller_irq enablement should be done in psp bl when it
+	 * tries to enable ras feature. Driver only need to set the correct inter=
rupt
+	 * vector for bare-metal and sriov use case respectively
+	 */
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_I=
NT_CNTL);
+	bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cntl,
+					      BIF_BX0_BIF_DOORBELL_INT_CNTL,
+					      RAS_ATHUB_ERR_EVENT_INTERRUPT_DISABLE,
+					      (state =3D=3D AMDGPU_IRQ_STATE_ENABLE) ? 0 : 1);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int_=
cntl);
+
+	return 0;
+}
+
+static int nbio_v4_3_process_err_event_athub_irq(struct amdgpu_device *ade=
v,
+						 struct amdgpu_irq_src *source,
+						 struct amdgpu_iv_entry *entry)
+{
+	/* By design, the ih cookie for err_event_athub_irq should be written
+	 * to bif ring. since bif ring is not enabled, just leave process callbac=
k
+	 * as a dummy one.
+	 */
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v4_3_ras_err_event_athub_irq=
_funcs =3D {
+	.set =3D nbio_v4_3_set_ras_err_event_athub_irq_state,
+	.process =3D nbio_v4_3_process_err_event_athub_irq,
+};
+
+static void nbio_v4_3_handle_ras_err_event_athub_intr_no_bifring(struct am=
dgpu_device *adev)
+{
+	uint32_t bif_doorbell_int_cntl;
+
+	bif_doorbell_int_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_I=
NT_CNTL);
+	if (REG_GET_FIELD(bif_doorbell_int_cntl,
+			  BIF_DOORBELL_INT_CNTL,
+			  RAS_ATHUB_ERR_EVENT_INTERRUPT_STATUS)) {
+		/* driver has to clear the interrupt status when bif ring is disabled */
+		bif_doorbell_int_cntl =3D REG_SET_FIELD(bif_doorbell_int_cntl,
+						BIF_DOORBELL_INT_CNTL,
+						RAS_ATHUB_ERR_EVENT_INTERRUPT_CLEAR, 1);
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_int=
_cntl);
+		amdgpu_ras_global_ras_isr(adev);
+	}
+}
+
+static int nbio_v4_3_init_ras_err_event_athub_interrupt(struct amdgpu_devi=
ce *adev)
+{
+
+	int r;
+
+	/* init the irq funcs */
+	adev->nbio.ras_err_event_athub_irq.funcs =3D
+		&nbio_v4_3_ras_err_event_athub_irq_funcs;
+	adev->nbio.ras_err_event_athub_irq.num_types =3D 1;
+
+	/* register ras err event athub interrupt
+	 * nbio v4_3 uses the same irq source as nbio v7_4 */
+	r =3D amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_BIF,
+			      NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+			      &adev->nbio.ras_err_event_athub_irq);
+
+	return r;
+}
+
+struct amdgpu_nbio_ras nbio_v4_3_ras =3D {
+	.handle_ras_err_event_athub_intr_no_bifring =3D nbio_v4_3_handle_ras_err_=
event_athub_intr_no_bifring,
+	.init_ras_err_event_athub_interrupt =3D nbio_v4_3_init_ras_err_event_athu=
b_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v4_3.h
index 711999ceedf4..399037cdf4fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
@@ -29,5 +29,6 @@
 extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;
 extern const struct amdgpu_nbio_funcs nbio_v4_3_funcs;
 extern const struct amdgpu_nbio_funcs nbio_v4_3_sriov_funcs;
+extern struct amdgpu_nbio_ras nbio_v4_3_ras;
=20
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 67580761b44d..514bfc705d5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -754,6 +754,14 @@ static int soc21_common_late_init(void *handle)
 							     sriov_vcn_4_0_0_video_codecs_decode_array_vcn0,
 							     ARRAY_SIZE(sriov_vcn_4_0_0_video_codecs_decode_array_vcn0));
 		}
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			/* don't need to fail gpu late init
+			 * if enabling athub_err_event interrupt failed
+			 * nbio v4_3 only support fatal error hanlding
+			 * just enable the interrupt directly */
+			amdgpu_irq_get(adev, &adev->nbio.ras_err_event_athub_irq, 0);
 	}
=20
 	return 0;
@@ -801,8 +809,13 @@ static int soc21_common_hw_fini(void *handle)
 	/* disable the doorbell aperture */
 	soc21_enable_doorbell_aperture(adev, false);
=20
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		xgpu_nv_mailbox_put_irq(adev);
+	} else {
+		if (adev->nbio.ras &&
+		    adev->nbio.ras_err_event_athub_irq.funcs)
+			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
+	}
=20
 	return 0;
 }
--=20
2.17.1
