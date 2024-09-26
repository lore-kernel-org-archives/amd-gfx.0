Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1745DCCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 08:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB6110EB09;
	Thu, 26 Sep 2024 08:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jYgsEAw5";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A9A10E0C4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 01:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beJiQxHkBPLWRTa/q39jV4wLG+tI4GMlcY07BAhxGTK2FkA0Y/lUMtSfK9Z5v508v6b1Hl8LBKEvgtkgcjlP9C/h6cUl/YeQDY8Rtr+89ANAp0RpYJ7ohi5lecU1HKNefzPi8aFSrZdwT54jM8kNisSyOLdFUFz7uuh1eidY5gGQHZ4gOXE3h5nKROhBYbvu/R3aSXQVASO5OaGu+w4lV9cCHiS+8PHPa75iVQaSGrwXratd/VhT5p9br/VSiHf3mLy0/XB+0rCd5ZtcAMW/HR/kmTbfRLs/OZqjKdF28RkA6bAKDnzA+kAax+kOwLmnJnJ6L9TPf8fkA27Pil20Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lCynZ42w7HTNYOswJ+W9HnEn4gvJuTc7+yxwOLb7k4=;
 b=M8gt16JloXeOyNOFyRR4xsOoOE+Wqs1JFaFRq1j+Z3/VkeApPmrnwB9Rw5MyIHS8M33edMMpCiyj3jjIqgLnTjKGGeOcbj6EQVeC1CQ7I8fhO9PbFbC8bWeYve2MDxGiyusJpYAofQID1FkOUZar1Gv+TDFKb2MO/DqoH7jH21XuAG63fbYBZVeCmkpHBYZB7jspt0UoJhmIK9kb4mMYkFwnURCbMWMUpsR9hUomzAenwpSbZCQEJFTn/9Gyxj/yRfTZPS8kgZzW3Mw7IHYmukCkEuR/PmTbFxU+1rXT6CsvNryGCmX3HV6b247DI9QGDEm+cXSUDiCI9utER6/T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lCynZ42w7HTNYOswJ+W9HnEn4gvJuTc7+yxwOLb7k4=;
 b=jYgsEAw5ofPMiwLjxKdIDsd7CcizhbzfK/hos27tDCbUGy4TrpK5r1vS6CoXZhm/LsdH/ogaXTjcMbtYqgwV/Zp6po0rVHTGIVkNKLvKAJiSBFcAeUgwOmCEcEYTRlr8lGfE8TlHHmugIWKRcctCIvyJBSCBI0YRsFiHRVW4Y/s=
Received: from SN7PR12MB6932.namprd12.prod.outlook.com (2603:10b6:806:260::14)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 01:33:47 +0000
Received: from SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783]) by SN7PR12MB6932.namprd12.prod.outlook.com
 ([fe80::ec4:314a:d766:9783%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 01:33:46 +0000
From: "Min, Frank" <Frank.Min@amd.com>
To: brahma_sw_dev <brahma_sw_dev@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Olsak, Marek" <Marek.Olsak@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix PTE copy corruption for sdma 7
Thread-Topic: [PATCH] drm/amdgpu: fix PTE copy corruption for sdma 7
Thread-Index: AQHbDyCvoxUa/60Rzk6YXzwWrJrK2rJoKpgggAEfG2A=
Date: Thu, 26 Sep 2024 01:33:46 +0000
Message-ID: <SN7PR12MB6932ED618E4FF7B1FBB6A5ECE96A2@SN7PR12MB6932.namprd12.prod.outlook.com>
References: <20240925075607.420409-1-Frank.Min@amd.com>
 <SN7PR12MB6932EB1636FC06F28B4E133BE9692@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB6932EB1636FC06F28B4E133BE9692@SN7PR12MB6932.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d1f7f3bb-874b-4711-ad51-c591739fa1df;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-25T08:25:06Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6932:EE_|MW4PR12MB6851:EE_
x-ms-office365-filtering-correlation-id: f63cfb5a-a8de-4060-7114-08dcddcb440c
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|921020; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nEQ5nSGNaZU7ZKc4XdfyT1AaUuqmG0gfPKJ3IcQcgEcUgiFfasA09XM+4duM?=
 =?us-ascii?Q?StcrOXEHTygx12f+oGTmy64NpQD9MuHOJp+XcbK7vdXD7MZmx2YCxyI02WtK?=
 =?us-ascii?Q?nU59AqiTH/1ctZ68/copzwfLhc0AYaFazurCn1J8Ts7S/ske9EP0M8Pue788?=
 =?us-ascii?Q?0EXObK3jS1tWKwGfVKmGjLFtJqSjMoik9SBEg+c9Tt8SIoM3bA2pGBilb2PJ?=
 =?us-ascii?Q?zujKyJpw6CL4bxVkJ+VxqHMEkAAcTnXcM/bCJLeFF02qZFM+d6Xqd7rPZjee?=
 =?us-ascii?Q?WjSKs3XDgRAqY0QHVknf/xEIKftHpi9gn4ky9GylfgZBIlgPechcz37ba2SO?=
 =?us-ascii?Q?I8n3sAXYGor/XvKfGr9yeg/obC+MPTKbAJzAR30eZZB6V3ch+ix2ZAwxzc6g?=
 =?us-ascii?Q?mfcdvxooEew9VJVvArRb6R/PKNcobprjMLq3gRH91blzrz3Kgtxf1a5BPzHt?=
 =?us-ascii?Q?XWtLitvrY3wfsKoxfkYqZ3t3L4W8DpuV5pLN45S2zeexoc5N75WM9MngwhTC?=
 =?us-ascii?Q?Is/LCL7Tr2N5wppZ5Y1Lgaeu1WiPInmBWlxZF+Sp/cRVeXEZOBu1XzfbZHiC?=
 =?us-ascii?Q?Hetggssf0s8Fl0hIDGzeSEPjGvhxD86UIuLlUIJo6zrLcpzgXEnynyS7bn8Y?=
 =?us-ascii?Q?XnYQmMPUmGDOdxnFCCSzMackF6Ju9SweuZ9z8oc8k5UNxdAIViVw1SQod1D/?=
 =?us-ascii?Q?GsDowp3SAd2cFaRX0IVbxtnkXu4qyzPKWUSMtVN+2P+9ncf5x7uBaO/rOL4u?=
 =?us-ascii?Q?kAmTD3C+QJOiw2jF87c32LJZf06/I92xgeb1FUnpLij5/6gMtH3ySsP315KR?=
 =?us-ascii?Q?7zpulqCgYo6tahQrcIVRldrJjfUJUn+LE5nxx6MMW9J/2qfeUiZDof4N3FOg?=
 =?us-ascii?Q?/7h8xcBM07gK2UVm3V49ky0j9HiwD9HCSYnw9BQMAiU3eQlwuwMndzLa9AYA?=
 =?us-ascii?Q?YyddbkeUuaUw90SERiVzUeyHCRSFmZNFYniOb9cUf+eHTMKIRmiQEaAFP/5D?=
 =?us-ascii?Q?UxDAOCckO+aqEGojc1QYyjw/TcsGqXg6k7HuxN9QddqwxP+kHn0Ia9a5lzEa?=
 =?us-ascii?Q?NCY0erXhQ0cUComAxKZ1OmC87PFZuQymgUFjpO8LEF1qykmy9AevRZ5y60Ew?=
 =?us-ascii?Q?c2Oi0INIxQjVCvq4yGYlU54KXgBRZENwdiYyyOUmgpkycA7dZbMSXMZqgA/W?=
 =?us-ascii?Q?Lvx9brgu7J+xPW9Jf7V4KSDIL1CP+Nkf8K6y46Y08QQQ5TI7kww/A5CKlRm3?=
 =?us-ascii?Q?bjVebx3tp9qqkoaZsBRE0D2icVqIIp9CMUXgKohj9BLr4XNzoUI6n3V3fKea?=
 =?us-ascii?Q?cehq9NbqWeAq0UyXYAaVgdL3GfR6ROx6G5idxBcxTNI/Bw3xvdquKPiBpOOn?=
 =?us-ascii?Q?LBzKPfI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6932.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b9QMtglfKZoRGwt0O2dpB1dkMyWP7eMJfO/rw7gZZoZZ0iZHTCwAR+q1yIz4?=
 =?us-ascii?Q?NIfiVO6tW3V3qazd3axrh6ZR4HtQKOecEJZtDUwe0YgK73MLJioKEybhr4GG?=
 =?us-ascii?Q?ASQ86T0AkbaiqP6MsJ+yNgdLJbHhQntV3eSsmqi2Ce0envA8GSQHzdmBfPnR?=
 =?us-ascii?Q?K5fdrhEcmt4h7tcFOEUMI67XeFtWv+OFmvEznIMFQAA3Boo42Cnkd/jfTQ4H?=
 =?us-ascii?Q?Imj4t1ywkG6dZ8rx515MxEbQzOovm+mbJRXYCylcV8vFTH+B6T1hkMUw0yix?=
 =?us-ascii?Q?UImGwmAJjpYUaBer65z2Qe5Sb+3W3M0imBtbQacCGaQLUcrN52hbRvkkjT/i?=
 =?us-ascii?Q?/xgianxeFumzHIK4QjzDVF4RPRLv0tkLbDfFH1cJxR9mfErm0slPYZZPgcR2?=
 =?us-ascii?Q?hohFk8zosu2F7HLaqib1UzLzx5LBMrMHdBruVN3YYkgplXzLXKgYDRFAR26C?=
 =?us-ascii?Q?HrJgfLApoGs8YkhsBB2tpr7+HlGd6sr77EPoSlCDZd6nefmDTzJ/o21qWWAH?=
 =?us-ascii?Q?mmfukFjFkMQdtd6hki82GemXC/iGHlna8CQTMiWYkXGaflVK0KD4AhZEeFcb?=
 =?us-ascii?Q?4cvDMAHi7q6772X6Xe5x58jskLjsdXEo8ut+QYO/56nhWm0Y1awX1nektOs8?=
 =?us-ascii?Q?ebNip7xBfaWOaTNwDpptZuKEEi44AtfjJyG6IU0v+OjLAAC02SJu/ccN1U+5?=
 =?us-ascii?Q?o/OcR/2rxVhtzYLwh3wyfxTYdXgnWbzSgPo09bAkQ1lKtlHjvVfGJ9ycIesD?=
 =?us-ascii?Q?ku7zv0xewCbGqpANpoGlra4svpoT0bM3UdSxJlmQkCBcpoBsZGcbwk+ZF+6q?=
 =?us-ascii?Q?azUpkxk0/HziCj8x6bn60Cn7+uNvru259coV9WSQH/TDc+z9i5qDJ28mhI/f?=
 =?us-ascii?Q?vJHGDNDUJ3KGhbTezJh2l29SX4gbfVRYoSF+3XQq5qjqkVexgcsvDVuEYtJj?=
 =?us-ascii?Q?OpUzL/JFAWud5TrOAB+w8CFHg5pcmNPYKJYtG8GWaerZtlYu7JSiS/KPeEsv?=
 =?us-ascii?Q?TYejVDmk6OD+RnkX0clKuzl3m/ILzt9iNFWLuGyG/o6gs1VEFgKzO9wJRM9r?=
 =?us-ascii?Q?m+Mm7pbkDtHJUmR0BTek7Cti/5JRAxhXTDgemDnGDul6vAtDOpbqZ2DYKade?=
 =?us-ascii?Q?TtVbM/FYhV8ePAF2oEEXNG4dV2zV2SZIQ2bjryRuKpXGUJ48AjS+ZJ6Lrto9?=
 =?us-ascii?Q?hZb4aXrpDrf3Vn7OJa6u++7wha6FoxhbKNswPfaCSPi0kuZLYeHRnE9GPaoC?=
 =?us-ascii?Q?9KnlrbhhOLbbk9oHvZdgRPAsUsXW2WnD+Ln9/CVNA23dgvd+imcVCQVBn1Dh?=
 =?us-ascii?Q?aumrtCXksbx4jSfusQQqeQowYuk7nAEorwG8LzB7rN3UspdUT7XMHallTGef?=
 =?us-ascii?Q?XHYAm2irr1KUaVd0ofS+53qopwdLOALYsYRs1WTUe1Da0v0wCPbgujRKY7y9?=
 =?us-ascii?Q?SpuQeA/OGZOIpm1wJ2cQVU5o6/ZfLk7Rax/6kO0AD7kCZXmfLLdMQRIcko2h?=
 =?us-ascii?Q?FVooRg24ciHE5Li36oBvMK6R3TeP3tBDWKVayATSHgr6/Uiw0EdN4OakrOKa?=
 =?us-ascii?Q?73JjsmmIYFBTgIjJmE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6932.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63cfb5a-a8de-4060-7114-08dcddcb440c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 01:33:46.8959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: seuVQqh8TJxwoD0kun1uuunbV4p87/CMbM1bn8uN1laynTkUm8kDJM3r49nxxpLp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
X-Mailman-Approved-At: Thu, 26 Sep 2024 08:31:22 +0000
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

From: Frank Min <Frank.Min@amd.com>

Without setting dcc bit, there is ramdon PTE copy corruption on sdma 7.

so add this bit and update the packet format accordingly.

Signed-off-by: Frank Min <Frank.Min@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v7_0.c
index cfd8e183ad50..a8763496aed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1080,13 +1080,16 @@ static void sdma_v7_0_vm_copy_pte(struct amdgpu_ib =
*ib,
        unsigned bytes =3D count * 8;

        ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP=
_COPY) |
-               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR);
+               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) =
|
+               SDMA_PKT_COPY_LINEAR_HEADER_CPV(1);
+
        ib->ptr[ib->length_dw++] =3D bytes - 1;
        ib->ptr[ib->length_dw++] =3D 0; /* src/dst endian swap */
        ib->ptr[ib->length_dw++] =3D lower_32_bits(src);
        ib->ptr[ib->length_dw++] =3D upper_32_bits(src);
        ib->ptr[ib->length_dw++] =3D lower_32_bits(pe);
        ib->ptr[ib->length_dw++] =3D upper_32_bits(pe);
+       ib->ptr[ib->length_dw++] =3D 0;

 }

@@ -1744,7 +1747,7 @@ static void sdma_v7_0_set_buffer_funcs(struct amdgpu_=
device *adev)  }

 static const struct amdgpu_vm_pte_funcs sdma_v7_0_vm_pte_funcs =3D {
-       .copy_pte_num_dw =3D 7,
+       .copy_pte_num_dw =3D 8,
        .copy_pte =3D sdma_v7_0_vm_copy_pte,
        .write_pte =3D sdma_v7_0_vm_write_pte,
        .set_pte_pde =3D sdma_v7_0_vm_set_pte_pde,
--
2.43.0


