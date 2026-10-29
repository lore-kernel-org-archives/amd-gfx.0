Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54C0606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=n1Z5ZZ25
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7190611201F;
	Thu, 29 Oct 2026 08:06:51 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD9611207C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 08:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzZo1d/90WkbiPVcxhx3Dlnk4/FA07HiauKWyo3w6Dd/se6scfqWN/DaX/l8/4ugujhsjsDn+v5zU8YmadJ929xhfjm4j8xDwqNyFv2m4RpjbmdqLFi4RT2F3tIqYv2TiVi27zFuCLSD4QIYhT4Mx9/yG7q3LXTgZi1oWVt/oEdMZGhE0Fh/1D1owbalLY0YDeu+hng5Om/OzrJc7t9G4LClkKJfGw6aqkQcYA+2+ogo/+vzE/Wvwi4DA6N5QdBSSOZcqa+Sy6lWA37DTCWsDe8DWjAGbHIINpba/QgDDRk1qxlzl56qDPj0ZsC3jZn7ULAsUQQarl4mj6ArlPrOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eUy4BeqmsBFBII2YBtSKQnsb618KuwE9mLpkPBTROk=;
 b=j/zc3VB3RAPRIDkYizD0Rpvq/YBAiHEfSVu7vvJo6WeQCDAWzq4qPOTD53Yi7NhUYnjSnk2kvPgNws/21A9HmmxnvZcBvZUqXto/NHOLdBU5Flcq8VeYs2HOl8rp2T+mZkYru08w+b5/DeI3MhYOrUuxI7Bs13UH2UmBZ56YM1IHjMGntdmQ0CTnt5NrN7U/xJs3JAqkdEwJM7AWqruWFJuhkS+FOpzzUYdzrYXlHluHgUDOicIdMhorZrYd0Q2UbiOaLT+1qoLKu3GQvznQUv6oBRULE6nvpgVnHHJsUQPYvDLwee4Uv9+oEkjiEsnSzyba7VBtvB69yL8W8WC+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eUy4BeqmsBFBII2YBtSKQnsb618KuwE9mLpkPBTROk=;
 b=n1Z5ZZ25aU3rxJscSspyzlgMjAk0mVfL114FE/AbFh9bcvJybIFVrqiI+wn6IqYKh7u7YWBMhfHHwzDrrglyGobEa3jgI++0rmFQ0+EkxdbVxlQ8sNad7Dr0cMpCH8F/NIVT0orrwknsXB+IlojdgR7CKnPukWFIqG+Ylurinq0=
Received: from DS5PR12MB093474.namprd12.prod.outlook.com (2603:10b6:8:47e::24)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 08:06:42 +0000
Received: from DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0]) by DS5PR12MB093474.namprd12.prod.outlook.com
 ([fe80::ac8a:80e9:b544:ddb0%6]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 08:06:42 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add missing firmware declarations
Thread-Topic: [PATCH] drm/amdgpu: Add missing firmware declarations
Thread-Index: AQHdZ3ZgKi+jK/I4nkqt8tklD85MBLcUKdYQ
Date: Thu, 29 Oct 2026 08:06:42 +0000
Message-ID: <DS5PR12MB09347496CB5F07C375C4EDD0FC8E6E2@DS5PR12MB093474.namprd12.prod.outlook.com>
References: <20261029072250.362965-1-lijo.lazar@amd.com>
In-Reply-To: <20261029072250.362965-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-29T08:06:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PR12MB093474:EE_|DS7PR12MB6335:EE_
x-ms-office365-filtering-correlation-id: 2f7bfdf5-5cba-4006-2da2-08df35939154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|38070700021|261021121427099003|56012099006|11063799006|261009223027099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: B9gEquPDdmnFQcxbvOQvatNhLVquk9fW8s4FxtpSh/DEmwQKkx4yhfcF9VjiUGKszx4ANJB4vqvt9+Gok4imMfgOAfW/fAg0fbrsTDxLk4sC8/SoRjOobb3tnz8arxJ2kyKlvuEf42aoitNn/FdVtXtd6bgc1XbGt105PI3LD9iLbjeOolYirkw6yWeEWITLUG9QgDFLA54qs72jQNCO9WA8v2hFzrCa1oK/vNIlQkxnQSaTfnoQ6IPgjoviC5ES3skOfALHvxFEzM4KYocp20qZnOSaO69Fhf0QkIVsI4qEfeGSZUQ84J6fp6Qzt9+geYj7JjdUs8q54YgJJ6nMhbyNUVlwnxDFw+mHASz0mb+3zWX7mLnTZ6UwuXaugVILLS175E8JxXw2u+zBQ4QvSAt/m79R5g76e3xwuBw0kn+3izHHvzAdSBZOOQ0zUTqaHJyN9nS237WRzhPUzVvY/PBdXgmlwdGnKCMxNs8igZZBEzagt7Y5Eb+QUN2JRU9rJd027fz34hw46ERlSRVB1O55FbVrE+SnqnC/5Dlq6ngSeTKCvbPzBrUItaPGlO+ZNd/RQerVqY2jFnvX+1DLRUTv+UPCZ9vpM+nVpfaT/lvpGIaFpxc5zVDWlooz7NBHSqWSxjy6G9SxiyuksLC/p9KUdS8vOCDRcl7GOUlAi4pUUCIO9YU38UB5j3DUevhI1npb1E1kgd0N//7PFwlu/jmm+JmvcrqoT0Bw7to0TC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB093474.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(38070700021)(261021121427099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?naITbo/1WbZsTzcqJZJqEyLNn4NhKhJ/tsPAShIUHqxIsJiPng698zrcMRm4?=
 =?us-ascii?Q?A5Se4RicbV8fUxi/Vx3b6kdgZsq2rtCrfwAdaXFeRqszzK4XPTsIqP5fnGxE?=
 =?us-ascii?Q?yoz5fbzPp/THkZ7A60ul5ncUIiaciSekp19+TYqLRmAvehb7Xaj5H2LfFT+t?=
 =?us-ascii?Q?6mD5qYEo7oa8+hk4jHGrHOMK3EshkEOK/fhVhghmCp1NPntjYcLK4FgHKmQw?=
 =?us-ascii?Q?P+hgRkmu1GCNsXXsZu7GAcFXtrMtUm1Rqnsb4O9jMwh+JnGPrftCvwPKvOE6?=
 =?us-ascii?Q?tM6RVK0rZxYNhUzQgVkTP6W0wTnaLzaLFYp9RhJK8zLsqJXDNVyUj42/VDrw?=
 =?us-ascii?Q?ro6/gJsNexI65UB1nRKjVg4/D097Phw+Z0JaZc+HEZcM7Z498GAFEUX0YGHz?=
 =?us-ascii?Q?nccudcwHXdWbC02Hrv+L3vgJilvrZFSHL+KLB5S17zKW5sqCjzxMjkHN7p8k?=
 =?us-ascii?Q?5VRO17+aJs1b1afnDGLMQ+/X1xCmvjAK5nI1etmyuHJZHajxZUBf+oghLFbB?=
 =?us-ascii?Q?YpCHXKylSnnEuePgE7soHOLqSj8DH8F8dVCTmdFTDTQ2C/J2igeioatswSws?=
 =?us-ascii?Q?zwu6Amz/QDxis0A0zqZLdOj9Bi9oDhoWGu5RsHBx+ewIlwSqJdWW+lKWb5LG?=
 =?us-ascii?Q?wIicTsPZKi0W4WPt+4nJ7aEFsHsm3z5FtJQq5yd9/3nWc0IA1+kfMuxGMmvT?=
 =?us-ascii?Q?q55fwgJI1EtKGwjGOa3d93hwPiJpDsNW8Ml2B2Ta3qcHM+jg+NVtrq6i9DPa?=
 =?us-ascii?Q?YiensdYkBkxeyNv2OnYKBY8ZzmVVtrAzlXSfptv6tEIYd3Fibftqzu+n496v?=
 =?us-ascii?Q?fKaWwwhuExyHNR6bEVlQv3DlSjRiGE3gCtOH3VP4tOZek+punx1D847CgomA?=
 =?us-ascii?Q?VcGtWfPrJFsoBwlnL1sgbPfTsXPnh4vyEAxFxC6pFES76nI+fU39twPidKUX?=
 =?us-ascii?Q?6O81+DKyF62junH2JsWbrWj1R22+SmNe3GwQ4Me+l4aV/6igjLPAXXrQdM0X?=
 =?us-ascii?Q?+FjQl6jLvdnfG6EO8DaJLEjPa3tSLda9WA+YG4P1myPxTIbAKAJXtUP/Ntpz?=
 =?us-ascii?Q?zKxk4oSstXgZHO5Unl4nuwCqU7RslUXj5MUhggRgubwfP8UhbRxKj0mX27Xf?=
 =?us-ascii?Q?1grAIREXRu42XoYrukzVc6RuUaI9dU5VKAox3GU4apuAlhIHgtqEb75OMVlm?=
 =?us-ascii?Q?FSR8WW10w/0GiVDJZbsbDBxprnmzfOJMx+RZOfCzA9i7DUNoDV7bUEVG4nH5?=
 =?us-ascii?Q?vpeFXoUkOj3www3czB5gS1j/l2ubXlI2FmlR8hrg7BxrPB+JSHEBLcGu+8ZS?=
 =?us-ascii?Q?tKCiEbfQYeEnzD+0RRWPKoXs6pLTVAiVRwG6Y4znVd1YpoEAovFBODyPT3Gj?=
 =?us-ascii?Q?G9NCXrVTM0hPEI5lvrCXJCHlAYwjmjhv7GSTmU+Lhus7GtPv5E7c/RanBVzT?=
 =?us-ascii?Q?EPSOD8oIHark+cwHNvCd5rTYDUo5DWMgKiirRBhfRLrVFr6WSGhTdN2HX7JK?=
 =?us-ascii?Q?IbHez3aw8FLI9YHkIUqr1OlP/nSbpZVxJluL7vr9h1j+DDjCkvZSOc7SN4VC?=
 =?us-ascii?Q?sQXuwx6I13iD5nvG0kPeG1dTRdZakKMwzOiDIV/hBiBT+cfIlbg4/ednlj+x?=
 =?us-ascii?Q?GiBgtKLqEE2m8dCgT3gfoqKNmhsNLnTe1OVQeCJ0FEL7ICPKBSJFaDvh+nyK?=
 =?us-ascii?Q?ECXnQWtOAVbSgeB9VtxnGvhBAy+wMTgJIiWmuZ/Q/yVK2Fl1IYt3WfkiTolL?=
 =?us-ascii?Q?ZxSZ2YfcZ2QkQ5ejc2F2tixLvDEIBkNjEDDvi20Bx866od/PhucR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB093474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7bfdf5-5cba-4006-2da2-08df35939154
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 08:06:42.4488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIxxdEWUr1PDu8Uubr1gZK2wnqLbNJd7dQIQfBY3nFl8Tyv7pU7mZ6KbBU6h7pM8QUHf1WasrR2olORxLW1bTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, October 29, 2026 12:53 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing firmware declarations

Add missing MODULE_FIRMWARE declarations for gc_9_5_0_sjt_mec.bin, psp_13_0=
_6_cap.bin and psp_13_0_10_cap.bin. It is required for including them in in=
itramfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +  drivers/gpu/drm/amd/amdgpu/=
psp_v13_0.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_3.c
index d66c7901783e..da031caa4e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -49,6 +49,7 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_5_0_rlc.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_3_sjt_mec.bin");
 MODULE_FIRMWARE("amdgpu/gc_9_4_4_sjt_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_9_5_0_sjt_mec.bin");

 #define GFX9_MEC_HPD_SIZE 4096
 #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L diff --git a/drivers/=
gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index f9a3fbfc0634..87057f511845 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -49,10 +49,12 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_10_cap.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_6_cap.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_12_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
--
2.49.0

