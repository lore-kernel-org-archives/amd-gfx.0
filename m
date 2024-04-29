Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D594C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 09:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B1210E869;
	Mon, 29 Apr 2024 09:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z6/yvnNu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C7D10E869
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 09:30:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1vFDtb0QtNA7rLAn4Jr393vfpBcDewyBGAtGzHmUUEWbRv9FE6OMabSDW7MLYI6jCN8jGIi/ifDKDm2gBenP7ZzgwodwOlkOcLa8w26lkThE2n8C1wDJmlX3SBYQJO0UebKepXH7CKG9mA4Z3A/id7Ul1YXg6I5cAcEI9qqX/4DYiQ2wBxBedrX8DyPhnCCeoWGMFkfR7TM1YqxdH8d9dGfEuaEbCNaOwxiI9t/5VoBmyH06lZA3zcLANTDIgOq2o6oAwBT9WwMMDJfMb1fLcIiYJPYhbQfKr5ss95OtCnQGglR7ZDNuUk46ljQJBLlYFxqM1qlddKPTYNjJhZIig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnJRnKb/87qRraK17IzjbO39wJlIU3Gu2VeCOoUAAAg=;
 b=O9R0av1F2quPX4OvAMl1ylBpLYJUGaACZSea6cpgfhAgZgqqsphEL4j1xdeqzjdUh/3nG77qOlc0uYzCk9hFrtPHyhlYDpJEvYm0eXea2ZsJTzPNtLwjhZ+9hh9hz9G/bIckT7odyJdzB29UQEPui/0y8rhazexVBkOpVr62i4+cxGroTy9IgbY3Tw2sFtOGrfl9LXPYUtfZ/rphSbG2ryn61KPnv66fqwQLpJzoaPpLu4nBPXFgrl2OrlMoUxTxoFCem7xHMuM5RihI2TTZGvVOqdmYMjSTQDkK+CubaC65lkkp0DJve1o7msh/zJY7UGLMbXTpZJvIwcNd4gb8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnJRnKb/87qRraK17IzjbO39wJlIU3Gu2VeCOoUAAAg=;
 b=Z6/yvnNuZP4JIZ/ShNWaM8y+YBOTKILnDCEeXIL+pJYs9GdZ3egaqPiYpgWJXQOidDVSJUPAyYxYVlGtvVMRJ3p7hGFExGfOFJQXPKNC/0GVd4pUFwSAYjir71BNjVyJOMUCLGdL+6rrYfzkSYVacmYUMCpUZW+MEC8FGg+CJEI=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.31; Mon, 29 Apr 2024 09:30:48 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::f204:5c92:acd5:8516]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::f204:5c92:acd5:8516%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 09:30:48 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Xiao, Jack" <Jack.Xiao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/mes11: increase waiting time for engine ready
Thread-Topic: [PATCH] drm/amdgpu/mes11: increase waiting time for engine ready
Thread-Index: AQHamhUW9YamiR7wXUavKv4QA35ZFrF++1Fw
Date: Mon, 29 Apr 2024 09:30:48 +0000
Message-ID: <CY5PR12MB6369F5BEDDB54C047D0A21BAC11B2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240429091002.928932-1-Jack.Xiao@amd.com>
In-Reply-To: <20240429091002.928932-1-Jack.Xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=53c4ff0d-e223-44ad-b990-9a8e1e196ec7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-29T09:29:31Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|DM3PR12MB9416:EE_
x-ms-office365-filtering-correlation-id: 88410435-2d81-4c45-a476-08dc682f0dda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|366007|38070700009|921011; 
x-microsoft-antispam-message-info: =?us-ascii?Q?G8KB2ftKPnbcsh2bwakU5U0/l96Lhhj9OsAcDhTaiktXxveH0tUq3PYku8Ow?=
 =?us-ascii?Q?WYqAXttxIDWnvTlpT0xgV9iMqjmppxB86sRnH5lYeVTzd0xde52y6YjXEwno?=
 =?us-ascii?Q?H7z9tbnWarzlqWK0C/+r+bo5ZLTe7EcjpfB1lJmBKvbw0NOewfO9QzoKM32N?=
 =?us-ascii?Q?iPL7Enk5E5Mf9o5kZmyJrvQsFjlfxABwpZ7F2Of1bhx2Q+rTqKz2kOC8OOUY?=
 =?us-ascii?Q?rzl/Gh2WH2dYh8RlE8k/O20dHy85d6zKzKO4rpzIYaQ/UDhOJ0bFwWJI84mU?=
 =?us-ascii?Q?bpXMbi1XFE6XBvZLx9ZXP2HJurg/k3UbroxBpzysFc1yWFOBo4wgul1Nb/jR?=
 =?us-ascii?Q?w0dDdmAxNwy6kdfBWxgKy3OZDiZya3DEGWP+zFIKnv73b7CnskdFD/3pJNzo?=
 =?us-ascii?Q?96ERQ+fNHRy+FJWPXfQX6ODvSoxUSAjHn1h+5NG+LGqNl0LGM5woeckrXOy6?=
 =?us-ascii?Q?U7y46rtoqBgzuUateKqufsC8WBPKD5Z7MtQtt8Y8DXxea5ay+pBSSpgga4dU?=
 =?us-ascii?Q?AjIhBAfm9/viCl4rQClTwdUSfnYVootb+eGtWGl73d795OycczoSMShrMhGM?=
 =?us-ascii?Q?ZrmSCTSWe4EuuEzPf07X0tqA4Qsl0j8xNwBfyrX5VNAIo5dtTOkX54wAxGCj?=
 =?us-ascii?Q?3bhscn+AsHewgodlnpRFIMey7zXgSbLYH0Gaf+uj8qLhaL0SYb7KXzEq8ZEQ?=
 =?us-ascii?Q?cVdjuN7/wZ9AC6TW98B+IaxSkUeLP5IZ8QqD1OxlcVxtVpRzTlInM5bAtcwV?=
 =?us-ascii?Q?ZVlY+z3hBSEiTy/NCgx8bYaASXsoTiPGP3rdFOGrHNvpiFz4CQ3xQYDYcyaa?=
 =?us-ascii?Q?NIn5rjYwaLwAVTbvgQw3Mb4QHbC/F9qpoor47VVoopU25EPimK7uEhCFeNtU?=
 =?us-ascii?Q?KDqsXqBpHFzDJVhbduIGTYiGyHcju5QnUdSpg/56S5YgX/XgEVjalhFsWUPN?=
 =?us-ascii?Q?nO5/Mch14e55damniD0elhlVEEwMDkCHnqTkXbdXyAkfsfSoV4rtH3xn9RzG?=
 =?us-ascii?Q?h/h5hMjvjbMoJyYi9D4dtY6q49vcXdJffXDM7GrhcVEnbXFCSwg7FpfwajK6?=
 =?us-ascii?Q?baI0+m33+cmDQ7fTfkGJ1ygSLM17mDP6VIlVx8TmpoX4DTkfp8qbwW5W869f?=
 =?us-ascii?Q?tNljEdYlW41OngWfj9x8LKDCfrNSKpIrY+9ELJw2uDWPgohDCwFUAc//V3XR?=
 =?us-ascii?Q?bM3vtDrb8IrXgGaoZxuooh31CmC7Pleo+OczNtzbEEnthBnb0821M7/j84PU?=
 =?us-ascii?Q?gjTlwIEwL3yuNpYhoo9sv5zyctNSY7yPXcWQz8hUPsqw1zf4L8LqBdMsOwzr?=
 =?us-ascii?Q?xY4vLVRDXw1PQtvIow9rj3zLh4aPYeQMOCcPFYkxfoFYPlLew8GEXEkXmpLr?=
 =?us-ascii?Q?6wklCn8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009)(921011); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0wMPOmixuCfocSfHqPjvBOtrQHa0sbehXmZF6oapVJW6Q/u1k/Yo9qRpbJor?=
 =?us-ascii?Q?tIsIlKSoO839n9xvE7O+rcDIGiCAYC8XLeIzv8I7NVhA/9Fx39xaez+a4PLd?=
 =?us-ascii?Q?CUC0sVpK8Oc/OgFgK7lgsBYrkTcN/4PcjGjh8Jvas66zYUs7dhfJGezZXDkc?=
 =?us-ascii?Q?kQwdrXvLWnYTDteiaoprUcIOr1I0pvc+eaq6ckmiQAqC143088Y/SzJrhlZI?=
 =?us-ascii?Q?mQz+ctOb7d670k3AH/W5+69SdgUkE34BZB6QiQbP4YWsSgCT+GLdcsgkCTic?=
 =?us-ascii?Q?bwzPCXA+r4WwBQmLDScNykGIBWeQWrJQdhJsIu0mapRCYm0KEUb49FndzS7U?=
 =?us-ascii?Q?tQ8wyPJGxgGHI32dMgyrjc7xm6Shz05RMIYdbTE99SWvBFUBRyFHoWxonK9y?=
 =?us-ascii?Q?1nUo5V8Jyldt/SQGnKvwqovYq+8MmAUkjmSs/bmodS64dpAR3nTJLgQ9iyy6?=
 =?us-ascii?Q?sE4LgTjf824WP9lk57QmsNUaoLzOSVPpzAZsvv3e7zx73KbJTP5R+Jh6yVIm?=
 =?us-ascii?Q?jhej0nuafWDORpM+7N65tzo0NX0fXrcNwJPrIYUhntdoT1yMvnkj0drPNCeq?=
 =?us-ascii?Q?mVgpSX8aQknQC0OSAb92IXX3uNfYpjT90eclQ3nLIL8F+2bWD/EybPrxfmf9?=
 =?us-ascii?Q?QAQBAQJ8IisXD4Ap2sd0CgL7sCCvNeoW08VTvXdzGQN+h9MMozNfgJvnj+oX?=
 =?us-ascii?Q?uxu2RK3gvIbSeZBDJLrww+5MinEPLoDFn7I+Suzn8wZDwZw4zrAmDEgXYR+w?=
 =?us-ascii?Q?EmK6ELldtsoao9JABbdiBeiblZlu6Vh35RUs7tTmNUrYpvxuxlt7vGRRPv25?=
 =?us-ascii?Q?951eUvxPRQeY6N++OFaQtM+18szHW3DAy+gPQeE7zMPetHvUGY7LBGiNZieA?=
 =?us-ascii?Q?ZiDv8CF9r3GpSWLqh5T1cSPJBHSmSFlmeEpzF76U7OBWpjIFu/RSv9csW9Vu?=
 =?us-ascii?Q?0aFIOn8U2x3i555h7ZmHgpt4Ci79WWd6hjT3+EZQrc1w7GLszWDH5mfcmYHi?=
 =?us-ascii?Q?w9g4namrh0v36jCD50DdbkBRd/7dLwgdfbWd8CbYS6eR2bWGKqgfMNy+eNtq?=
 =?us-ascii?Q?Q4+i07pUcRP91M2o97F72LyMnv97gcuL2SGrbDoQ0NTCCQ3S7KMZc/XY+3aH?=
 =?us-ascii?Q?4i68RS8I02KcTVjAGea1+Ulx3oxIetoC/QoJcRfzIvu4aS2vFuZ+4B8YiXpL?=
 =?us-ascii?Q?NDVUmlkFSnFsHyblhVUpr2G45IkXmRvXIF13Onud0QsunimOs4JRfTAUyXjp?=
 =?us-ascii?Q?7SJ9yAdk47JJWrVJqISzPiR5ldpq+zIJb2Z80JZxAIO3sS/3SEunAV1D9bsz?=
 =?us-ascii?Q?omPNzikTJXCoZUn+zgXdC9k6LJzpJitb7yBPQWhvwNN3Wi/kj/Iuq1N3Z4Z8?=
 =?us-ascii?Q?IWKf5mU5wh3gPZSh52VChbM5zZLnBmRN2r8fe7HnXnk7NW+rMNtso/iaAULm?=
 =?us-ascii?Q?QHpBSkFo1r2oK6JFIyL9jJjO+lmzroSngmWrMqRY8TGpIz/HDODWQnbippmz?=
 =?us-ascii?Q?0zSOTZeHhN7lrsuf6pndDqz6HCwxA3Gjd/DFqCpATUUCbdkmTbi8NpgTxhqg?=
 =?us-ascii?Q?KHYp1IBsJBi1DH7V6QA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88410435-2d81-4c45-a476-08dc682f0dda
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 09:30:48.4366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYSkqXfGn7VOeBWZLLhEr+2t3I3IUG1HBKWJwiHX5tp1WcPfS1Viz4Y3aymMkAiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
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

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Best Regards,
Yifan

-----Original Message-----
From: Xiao, Jack <Jack.Xiao@amd.com>
Sent: Monday, April 29, 2024 5:10 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.c=
om>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Cc: Xiao, Jack <Jack.Xiao@amd.com>
Subject: [PATCH] drm/amdgpu/mes11: increase waiting time for engine ready

mes schq engine require more waiting time for engine ready before packet su=
bmission.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index 28a04f0f3541..d98f6d282ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -696,7 +696,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)
                if (amdgpu_emu_mode)
                        msleep(100);
                else
-                       udelay(50);
+                       udelay(500);
        } else {
                data =3D RREG32_SOC15(GC, 0, regCP_MES_CNTL);
                data =3D REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE,=
 0);
--
2.41.0

