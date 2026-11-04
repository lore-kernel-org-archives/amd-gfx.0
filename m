Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611E606A326
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5OmG+KC5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E251810FCFB;
	Wed,  4 Nov 2026 15:31:35 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77D0210FCFB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:31:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALCSP59sqAJ3caggBnOdnpyeUmmC8jPeWRnoxaghVIs/XxiZJ6yAHnkVsN3rFEJN2To6Eggt02y/I3pqGNDWIWjwz2osyP/PfpceniWExlm40n706vMCiQ0KhsPZLUzxPB/e0oZ4HgtzEN7vjVTrkPXnJzET+8+eMnqhj02N+eOZId2pJcoBSCbp/eHtdDeJnXqPWtaJxU8rGfKj0zgHY7gZmONt8i3GkaPMrrazHN/5/NuQi9eGQUpMyIzkoObgR+qZlizgZcuYdCb3a2BvkbGOR+AOHyc3CtTN4rveDTio0U2aM+aoqrfGKS03Q6dbYM0OAASHDFVGEpuiGNPF/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjMjh8voEw7n1mxkzDGL8VNnPqCfGv2XkpQF/8TRGsc=;
 b=d37OD/tqL8SOQzzC5cB2/5BO3rY4mUxlqBuWsYyS3AkaGRgoVOVEQEjvU5qJ06LCG4ag8pl8nYaenLJs40+yL+9nIWjjqlESB84s5yZtDA3kyXavsXZNTdRI/VGlC74mHvgwvVz7Pm5mwJPIRhm2wmNxTYgW3/c4UmhDd1GzR1BMC/MN5YTTbtujuihYSY7lfGyttWHl7LTNDZ7gVPdLoBUA27KK8BMGPEy4e003/XSS1eZzWZqBCJRuDaq71PCTdqO9KEgopBBblsDQ8KUGQ0iHkmxKy/iM2loFiSuoKKXTmgxdxLeLCSjBeGpom7mTPbAY6Ys+/B5NcZ9YNrCp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjMjh8voEw7n1mxkzDGL8VNnPqCfGv2XkpQF/8TRGsc=;
 b=5OmG+KC5TKjkM3UdWnr7keSMtg2ba6yUHdMOhxl5y76oJ4rS2WHrBb6bqaz0Vsr8+DiM8kKb1daEglz195numEvT4YkbwFvDNaxdDP8k+Iu3usJpmrxXFWHi6lvo4SrGE5stjrwDHxGiL+3OF0W1u1hdNgSK+Y3p31GZ/hJ6bFw=
Received: from SA3PR12MB172791.namprd12.prod.outlook.com
 (2603:10b6:806:589::8) by PH8PR12MB7328.namprd12.prod.outlook.com
 (2603:10b6:510:214::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:31:22 +0000
Received: from SA3PR12MB172791.namprd12.prod.outlook.com
 ([fe80::8c42:dd95:4c6d:4f9d]) by SA3PR12MB172791.namprd12.prod.outlook.com
 ([fe80::8c42:dd95:4c6d:4f9d%5]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 15:31:22 +0000
From: "Chen, Michael" <Michael.Chen@amd.com>
To: "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: reinitialize MES KIQ after partition switch
Thread-Topic: [PATCH] drm/amdgpu: reinitialize MES KIQ after partition switch
Thread-Index: AQHdZ+TlwJZ499LvdE2/LddqPgmt6bceEwmr
Date: Wed, 4 Nov 2026 15:31:22 +0000
Message-ID: <SA3PR12MB172791CF92846E9AD5E2B16BC894682@SA3PR12MB172791.namprd12.prod.outlook.com>
References: <20261029203412.3224512-1-alex.sierra@amd.com>
In-Reply-To: <20261029203412.3224512-1-alex.sierra@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-04T15:31:21.774Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR12MB172791:EE_|PH8PR12MB7328:EE_
x-ms-office365-filtering-correlation-id: 5055e3d5-d94c-4082-deac-08df3a88ae63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|261009223027099003|11063799006|56012099006|261102123227099003|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261028144727099003|10067099003|18002099003|22082099003|8096899003;
x-microsoft-antispam-message-info: JzAIh4Fh1U2k8AsW3A32dBgeg0n38dXtMv/htIw+QaEGjZRYTFE9fywlHfIk2jcwoZIWRrUN1bpufXSy1Ie9biBDHLSL5gxqwaFspjNH5ZzHd+vEvnt+8fPczPI4gRGrJkU7q+wuywnvmHlDfV1vgznY1wsAkhcWlQ706XsLLfHViCpJ3/aDFWUyY6ISD5BEqLbNM5Z8mrBhtpUaCNQhIUGHuQVbQBA5ZD2iAssB1PyT2q1YMorLE79ROtl+D1I3jrRyhboyCwkD96Bv7WU4J/9/U3iDqyjrJrZNlcLElHT7+pvDYvQLQqAjErvHxAMYMfYAlg290W9DlqRZkOUTxOnrgib3HCceZJ6kKgtlFYl/hgHIqrYtLa5Bz7Psa5GoTb97p7xmZqrGrHlSbEhIhiGJ1ffzvm7yFBNvOR3mGeJKQwy+Ca3wbqpkTJxfDQn4fee30i76Xx+JVokXHJMBZ+pbx0v9Z/YYke0UzVoS//jQY68+8fhjrFo+O8eLleXJppTtlTvzLXPOrIvN/iYlRYVM7/Q90KjIJvyajcqUMuxcmch05CSXN/UK7CL//Eip0qNdCX+l6BCzO/WJ0GbtEw+dK/R6/B1GTfZtAlv7eMo34iUG7FVhjx+6ZvKn2ZQIZYnvv077F3ap3PyU29I3iuOpf/bgnKTTgfy+Jc5joYwM3jf5stgOQ7MhcOggtS8ViPZAixQk9wdH8laOnli6fs7d1iqtpvZMoS7XsOo7S5g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB172791.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bGymukp6Sj1Uc7AFQzzMBIcwHcjY70PdLj2+8VN/Zr3ZNLjqolSgi62dG6DY?=
 =?us-ascii?Q?seTgRa6CYHO8NCHgrhSWUBqRIVo0KrYsaOi35+uI77N0QlFc99k0/e8goOT8?=
 =?us-ascii?Q?ZP3HIOm0vR2T47/TKibgp0pjDS5BJ1ZKllaBGOStQRoIRCY/RTEKwcRV2ZMI?=
 =?us-ascii?Q?tQnn9AzsZnq3HUtIQn9A1yH7w6nIT4e+FpqrTf8z18c9FQp86WXKlxR5vA2M?=
 =?us-ascii?Q?GoxaY7TOke0yCltiMlYYancHNyd+5mpZzfMEYVDqh3IxWs37QAOeb2hK5e97?=
 =?us-ascii?Q?Wba5vdP9cHdi6cF1WFxUSv/Py2b6gbpKTJRA6jgqkwDAoF8LFEjLc5chcLC9?=
 =?us-ascii?Q?8AT2M9wKydCyR91tbRcztK0Yi9gXeegtSay3iJqhFMCxje8JKP3U40m8pBHL?=
 =?us-ascii?Q?4iw1bWRjyGD29NzzktKaDWJn3h48JzooW8VTM8HuYOmbUkD281uTinzoTvbo?=
 =?us-ascii?Q?Bvd6AGzwHeKgKlnh/6SZ/7x3hTPdZsTfla4dRfxH64o/TdIK/apjLnLEZwRG?=
 =?us-ascii?Q?2DgxIV6zfqNCUXpL4eyBDmkuMrUjdX0wEAU6NUWEkT3qPbN3M/TbDDRBM619?=
 =?us-ascii?Q?SW+YCeRQgSBdY5HU1WFxGjl7xOWyM1xnwS+4t6/TsAo5ZSemG3Ml1KjjHOy2?=
 =?us-ascii?Q?kZGbUCOTZyaNThnCJEn/SAr+WootnHQz0gyLHGl8YJScv7otd/fSjHvBmOSi?=
 =?us-ascii?Q?tJQQnQryq78oBRQrZtWqCzDeFo+rQ1hUOnHf8RsJCyZRkOw3wM8uEhev/55+?=
 =?us-ascii?Q?CopQZhVyrY3i0J2E8lO6yd8LoRygUfm8+5jYL+rC+HRDuk3UvK0sWqFXM3av?=
 =?us-ascii?Q?USVqqL7/iShipGzKX2x/j3tq41bt3Ai+ijjFjPqSDQzgzLTufDYFheaIYpeW?=
 =?us-ascii?Q?48JLeWj5tnuLLRSyTudpweGRgiZsQdkBeRrn+v4+8V1bLlmM+hOK0rA9ppt1?=
 =?us-ascii?Q?btWNAG0eMZvJ3M4NofweNCjUwxYev5VhLFJ5lqroGLY10EoqVw1vHnN+F7NH?=
 =?us-ascii?Q?th5pGefv+O272xPfLazwgMnGYuUiBPv86hrVIB5TJXwVqvxyD+FJAUDOfOvW?=
 =?us-ascii?Q?thGgx/A8LShZKAN/YhX2IfWNGmBuMtTRHbYNdbEoyPrxOShyu2IIsJozrZ/x?=
 =?us-ascii?Q?MLtlJRwi1R7umye3smZBoJiY4+kKPBF5n6+PrrA8GzRy7eB4/Qlq3V+Rtd9p?=
 =?us-ascii?Q?6q9tSzQzWCs8a7oHeDsZSnFYdAXGp3uRq73Nc+Pce35w10rXCEwE5wXuCB3w?=
 =?us-ascii?Q?sB2ZLF3vceln9RVM+bKe5d0yEHZsn8R7tedgXzHs/ZsC7Y/GtmOvWtZbgYaf?=
 =?us-ascii?Q?H1KE7xS9G/aRrjLhpN2QZxu0Co26zdQiIG+IC7ifNuyo/SNkmU3tZf9HSEi0?=
 =?us-ascii?Q?GzX64Qp4AzJhaj4TK3gO++LA92Lf4oEJXCK19+cNWIzD16iwMPMBDMHGhMFh?=
 =?us-ascii?Q?NW2pYC2SraXDeGWn7F6YwsN9Yap5B+rp1XTYvgi3/qq5FPMZFr2DocJLYxzV?=
 =?us-ascii?Q?l2edeksncZV56WuAidTFKfOjq1rQ+OzOrDbbsyPNSRpq/wEfmElj/4pZqBCe?=
 =?us-ascii?Q?R7V4oweXmbhAOyvGtqIT9XRFbwqMkY9Xe125nU/58YMyzcy596XHIXBo76x0?=
 =?us-ascii?Q?KRM6pXhq01qSI5hKNdglc5HX9FAkMbeuhuxZwevO4Pt9Dd1ohgdiKQ8VkyII?=
 =?us-ascii?Q?irKAdm3hNnSIhOOOUVdv/kiNXzfqKu+C5HgMWOakeR7va4rt?=
Content-Type: multipart/alternative;
 boundary="_000_SA3PR12MB172791CF92846E9AD5E2B16BC894682SA3PR12MB172791_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB172791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5055e3d5-d94c-4082-deac-08df3a88ae63
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 15:31:22.5145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPcR6uMGUGfReCpKTX+ceeVf5oV6Ey9EIxqzE2aIgY6ZhaR2pVqqCjQVs6jAijWcK3g8E+KualVLhrmqU4xH5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_SA3PR12MB172791CF92846E9AD5E2B16BC894682SA3PR12MB172791_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: Michael Chen <michael.chen@amd.com>
________________________________
From: Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
Sent: Thursday, October 29, 2026 4:34 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang=
@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.=
com>; Chen, Michael <Michael.Chen@amd.com>; Sierra Guiza, Alejandro (Alex) =
<Alex.Sierra@amd.com>
Subject: [PATCH] drm/amdgpu: reinitialize MES KIQ after partition switch

A runtime compute partition switch updates the XCP mode and IMU
partition without passing through MES hw init. The MES KIQ and
scheduler therefore remain programmed for the previous partition,
including its cooperative mode.

After committing the new mode, tear KIQ down on every XCC, clear the
KIQ and scheduler rings and their writeback pointers, and initialize
KIQ again. This remaps both queues and sends SET_HW_RSRC followed by
SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and
disabled for CPX.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  5 +++
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 54 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   |  9 +++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 0f368fbd2c80..5a14f4e7b64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -141,6 +141,8 @@ struct amdgpu_mes {
                                                    uint32_t xcc_id);
         int                             (*kiq_hw_fini)(struct amdgpu_devic=
e *adev,
                                                    uint32_t xcc_id);
+       /* Tear down KIQ, clear its rings, and run kiq_hw_init again. */
+       int                             (*kiq_hw_reinit)(struct amdgpu_devi=
ce *adev);

         /* MES doorbells */
         uint32_t                        db_start_dw_offset;
@@ -553,6 +555,9 @@ struct amdgpu_mqd {
         (adev)->mes.kiq_hw_init((adev), (xcc_id))
 #define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \
         (adev)->mes.kiq_hw_fini((adev), (xcc_id))
+#define amdgpu_mes_kiq_hw_reinit(adev) \
+       ((adev)->mes.kiq_hw_reinit ? \
+        (adev)->mes.kiq_hw_reinit(adev) : 0)

 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
 void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c
index 5573fe981a22..760c93740a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_b=
lock);
 static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_=
id);
 static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_=
id);
 static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int xcc_i=
d);
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev);

 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:7] hqd=
 info */
@@ -674,6 +675,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_=
mes *mes,
                         mes->shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_=
xcc_id, pipe)];
         }

+       dev_dbg(mes->adev->dev,
+               "MES(%d, %d) SET_HW_RSRC_1 coop=3D%u enable_coop=3D%u kiq_v=
er=3D0x%x mode=3D%s\n",
+               xcc_id, pipe, mes_set_hw_res_1_pkt.mes_coop_mode,
+               mes->enable_coop_mode,
+               mes->kiq_version & AMDGPU_MES_VERSION_MASK,
+               amdgpu_gfx_compute_mode_desc(mes->adev->xcp_mgr ?
+                                            mes->adev->xcp_mgr->mode : -1)=
);
+
         return mes_v12_1_submit_pkt_and_poll_completion(mes, xcc_id, pipe,
                         &mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt=
),
                         offsetof(union MESAPI_SET_HW_RESOURCES_1, api_stat=
us));
@@ -1530,6 +1539,7 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *=
ip_block)
         adev->mes.funcs =3D &mes_v12_1_funcs;
         adev->mes.kiq_hw_init =3D &mes_v12_1_kiq_hw_init;
         adev->mes.kiq_hw_fini =3D &mes_v12_1_kiq_hw_fini;
+       adev->mes.kiq_hw_reinit =3D &mes_v12_1_kiq_hw_reinit;
         adev->mes.enable_legacy_queue_map =3D true;

         adev->mes.event_log_size =3D AMDGPU_MAX_MES_PIPES *
@@ -1774,6 +1784,50 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_d=
evice *adev, int xcc_id)
         return r;
 }

+/*
+ * Runtime partition switches do not pass through MES IP hw_init. Tear KIQ
+ * down, clear both MES rings, and run kiq_hw_init again. That init maps
+ * the KIQ and scheduler queues and, through setup_coop_mode, programs
+ * mes_coop_mode for the new partition.
+ *
+ * If a scheduler ring is not ready, MES has not been initialized yet and
+ * the kiq_hw_init call from CP resume covers this mode.
+ */
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev)
+{
+       int xcc_id, pipe, num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       int r;
+
+       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
+               if (!adev->mes.ring[MES_PIPE_INST(xcc_id,
+                                                 AMDGPU_MES_SCHED_PIPE)].s=
ched.ready)
+                       return 0;
+       }
+
+       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
+               r =3D mes_v12_1_kiq_hw_fini(adev, xcc_id);
+               if (r)
+                       return r;
+
+               /*
+                * The firmware restarts with its read pointer at zero, so
+                * leaving the old contents and writeback pointers in place
+                * would make it replay stale packets.
+                */
+               for (pipe =3D 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++)
+                       amdgpu_ring_clear_ring_and_ptrs(
+                               &adev->mes.ring[MES_PIPE_INST(xcc_id, pipe)=
]);
+       }
+
+       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
+               r =3D mes_v12_1_kiq_hw_init(adev, xcc_id);
+               if (r)
+                       return r;
+       }
+
+       return 0;
+}
+
 static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, int xcc=
_id)
 {
         int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/soc_v1_0.c
index 506060fc5368..95ebbd4a7369 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -1100,6 +1100,15 @@ static int soc_v1_0_switch_partition_mode(struct amd=
gpu_xcp_mgr *xcp_mgr,
         *num_xcps =3D num_xcc / num_xcc_per_xcp;
         amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);

+       /*
+        * xcp_mgr->mode is the new partition now. MES KIQ was programmed f=
or
+        * the previous mode and is not reset by the IMU switch, so tear it
+        * down, clear the rings, and run kiq_hw_init again.
+        */
+       ret =3D amdgpu_mes_kiq_hw_reinit(adev);
+       if (ret)
+               goto out;
+
         ret =3D amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
         if (!ret)
                 __soc_v1_0_update_available_partition_mode(xcp_mgr);
--
2.34.1


--_000_SA3PR12MB172791CF92846E9AD5E2B16BC894682SA3PR12MB172791_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
Reviewed-by: Michael Chen &lt;michael.chen@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sierra Guiza, Alejand=
ro (Alex) &lt;Alex.Sierra@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 29, 2026 4:34 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Zhang, Hawking &=
lt;Hawking.Zhang@amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Joshi=
, Mukul &lt;Mukul.Joshi@amd.com&gt;; Chen, Michael &lt;Michael.Chen@amd.com=
&gt;; Sierra Guiza, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: reinitialize MES KIQ after partition sw=
itch</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A runtime compute partition switch updates the XCP=
 mode and IMU<br>
partition without passing through MES hw init. The MES KIQ and<br>
scheduler therefore remain programmed for the previous partition,<br>
including its cooperative mode.<br>
<br>
After committing the new mode, tear KIQ down on every XCC, clear the<br>
KIQ and scheduler rings and their writeback pointers, and initialize<br>
KIQ again. This remaps both queues and sends SET_HW_RSRC followed by<br>
SET_HW_RSRC_1 with cooperative mode enabled for SPX, DPX, and QPX and<br>
disabled for CPX.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 5 +++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v12_1.c&nbsp; | 54 +++++++++++++++++++=
++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc_v1_0.c&nbsp;&nbsp; |&nbsp; 9 +++++<br>
&nbsp;3 files changed, 68 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index 0f368fbd2c80..5a14f4e7b64d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -141,6 +141,8 @@ struct amdgpu_mes {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t xcc_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ki=
q_hw_fini)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; uint32_t xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tear down KIQ, clear its rings, an=
d run kiq_hw_init again. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*kiq_hw_reinit=
)(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* MES doorbells */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; db_start_dw_offset;<br>
@@ -553,6 +555,9 @@ struct amdgpu_mqd {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_init=
((adev), (xcc_id))<br>
&nbsp;#define amdgpu_mes_kiq_hw_fini(adev, xcc_id) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_fini=
((adev), (xcc_id))<br>
+#define amdgpu_mes_kiq_hw_reinit(adev) \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((adev)-&gt;mes.kiq_hw_reinit ? \<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_reinit(ad=
ev) : 0)<br>
&nbsp;<br>
&nbsp;int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);<=
br>
&nbsp;void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c<br>
index 5573fe981a22..760c93740a7e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c<br>
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_b=
lock);<br>
&nbsp;static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32_t=
 xcc_id);<br>
&nbsp;static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t=
 xcc_id);<br>
&nbsp;static int mes_v12_1_setup_coop_mode(struct amdgpu_device *adev, int =
xcc_id);<br>
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;#define MES_EOP_SIZE&nbsp;&nbsp; 2048<br>
&nbsp;#define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:7=
] hqd info */<br>
@@ -674,6 +675,14 @@ static int mes_v12_1_set_hw_resources_1(struct amdgpu_=
mes *mes,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes-&=
gt;shared_cmd_buf_gpu_addr[MES_PIPE_INST(master_xcc_id, pipe)];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(mes-&gt;adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &quot;MES(%d, %d) SET_HW_RSRC_1 coop=3D%u enable_coop=3D%u kiq_v=
er=3D0x%x mode=3D%s\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; xcc_id, pipe, mes_set_hw_res_1_pkt.mes_coop_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mes-&gt;enable_coop_mode,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mes-&gt;kiq_version &amp; AMDGPU_MES_VERSION_MASK,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_gfx_compute_mode_desc(mes-&gt;adev-&gt;xcp_mgr ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mes-&gt;adev-&gt;xcp_mgr-&gt;mode : -1))=
;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mes_v12_1_submit_pk=
t_and_poll_completion(mes, xcc_id, pipe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;=
mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offse=
tof(union MESAPI_SET_HW_RESOURCES_1, api_status));<br>
@@ -1530,6 +1539,7 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.funcs =3D &am=
p;mes_v12_1_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_init =
=3D &amp;mes_v12_1_kiq_hw_init;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_fini =
=3D &amp;mes_v12_1_kiq_hw_fini;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.kiq_hw_reinit =3D &amp;m=
es_v12_1_kiq_hw_reinit;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.enable_legacy=
_queue_map =3D true;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mes.event_log_siz=
e =3D AMDGPU_MAX_MES_PIPES *<br>
@@ -1774,6 +1784,50 @@ static int mes_v12_1_setup_coop_mode(struct amdgpu_d=
evice *adev, int xcc_id)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+/*<br>
+ * Runtime partition switches do not pass through MES IP hw_init. Tear KIQ=
<br>
+ * down, clear both MES rings, and run kiq_hw_init again. That init maps<b=
r>
+ * the KIQ and scheduler queues and, through setup_coop_mode, programs<br>
+ * mes_coop_mode for the new partition.<br>
+ *<br>
+ * If a scheduler ring is not ready, MES has not been initialized yet and<=
br>
+ * the kiq_hw_init call from CP resume covers this mode.<br>
+ */<br>
+static int mes_v12_1_kiq_hw_reinit(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int xcc_id, pipe, num_xcc =3D NUM_XCC=
(adev-&gt;gfx.xcc_mask);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (xcc_id =3D 0; xcc_id &lt; num_xc=
c; xcc_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!adev-&gt;mes.ring[MES_PIPE_INST(xcc_id,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_MES=
_SCHED_PIPE)].sched.ready)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (xcc_id =3D 0; xcc_id &lt; num_xc=
c; xcc_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v12_1_kiq_hw_fini(adev, xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * The firmware restarts with its read pointer at zero, so<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * leaving the old contents and writeback pointers in place=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * would make it replay stale packets.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (pipe =3D 0; pipe &lt; AMDGPU_MAX_MES_PIPES; pipe++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_clea=
r_ring_and_ptrs(<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;mes.ring[MES_PIPE_INST(xcc_id=
, pipe)]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (xcc_id =3D 0; xcc_id &lt; num_xc=
c; xcc_id++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D mes_v12_1_kiq_hw_init(adev, xcc_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
&nbsp;static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_block *ip_block, in=
t xcc_id)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/soc_v1_0.c<br>
index 506060fc5368..95ebbd4a7369 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c<br>
@@ -1100,6 +1100,15 @@ static int soc_v1_0_switch_partition_mode(struct amd=
gpu_xcp_mgr *xcp_mgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *num_xcps =3D num_xcc / nu=
m_xcc_per_xcp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xcp_init(xcp_mgr, *=
num_xcps, mode);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * xcp_mgr-&gt;mode is the new p=
artition now. MES KIQ was programmed for<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the previous mode and is not =
reset by the IMU switch, so tear it<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * down, clear the rings, and ru=
n kiq_hw_init again.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_mes_kiq_hw_reinit(adev=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_xcp_post_pa=
rtition_switch(xcp_mgr, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; __soc_v1_0_update_available_partition_mode(xcp_mgr);<=
br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SA3PR12MB172791CF92846E9AD5E2B16BC894682SA3PR12MB172791_--
