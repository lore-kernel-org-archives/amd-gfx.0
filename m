Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93A606A328
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EL83IBqV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0605E10E55B;
	Fri,  6 Nov 2026 06:52:45 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF8E10E55B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 06:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ/1dLhxVqzcwhArAHPyOaQqYdbj5GYoAscxmzLpDuY4sdT/C4MUtcsnMQLBQeB1RemwCRvrsXLacF0H/BhFc6ZBpd6nk5yYXRXiDowAOKJDPRetSVmXr52cNnpxj+TVHBoyDimnTXiAwmER/DXCsEmiWBHN0e12QqQhh07yw89QSVRne/8PZ7enpwI4MnqYKoN+P23FAiJBSEKdhMcNE1D3e8NXeWziyh81nAYp6PJEnbPzxu0abdJT0bduQpg2eYH789wIyRjKAd3gv3VvtKB+EV24a2eTErvKFFB2lgOFPL+ecx6MICCTOxFDTMx5srl+yBYhu+HhvvlHj5bfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ1NL5Hu97a51cE3dI5hORiAy6YYeQ36GK1KbqD1qRo=;
 b=PcX30f0hvKT3TdQcPoIhGoQfB9PYpX+Z4WBlY7Z2xC6KJ09d0Dt3PEWHxGH3etKCvYOdRUtCaNaISIdPYw085IceM3eoDo2lPIKcXBjm+usMxoifdCPm7PVgVa95FC/MYn5i7ciCekSbH52k8ojPv/EvbFFJgNbXXMw5MDAFLbam/gO7pRv3+1IkYKPpUOrryfeEouYrgtLtF7K+fnX72PrV3AhlfmeJp+zxHzkOS+Dh5D3vhVOHCZdET55uWusRXvt5/78adyIH6MZ1FU8FcwFjUc2RE8/fXEYYMePD8BqkE2GFMStXysCM8vn0/fjESPLB4EhwGJaz2LMy+Mql7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQ1NL5Hu97a51cE3dI5hORiAy6YYeQ36GK1KbqD1qRo=;
 b=EL83IBqVIhsKiaQSO7wvGJE5BeOPVgaSHBnJ7EbnGMgGfCAMIX0M4unu1fuFbtTDPECdUIN3M3GzqYoSJmrlrovK08ePG8ZHpnRzFRKcACk++k/k2hP1bz3oCU0IqHBKKipvPOwzCk8eInvKF3wTwFWoE/U6O12Smhw8pr/uTlw=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 06:52:35 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 06:52:35 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH v2 2/2] drm/amdkfd: test copy_from_user() directly in
 kfd_criu_restore_svm()
Thread-Topic: [PATCH v2 2/2] drm/amdkfd: test copy_from_user() directly in
 kfd_criu_restore_svm()
Thread-Index: AQHdbbfQCqyd4vbuU0KwHJ4zmcMpCbcgmz8w
Date: Fri, 6 Nov 2026 06:52:35 +0000
Message-ID: <CY5PR12MB6369240C914B1A1D70D84D8EC1762@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20261106062616.851993-1-perry.yuan@amd.com>
 <20261106062616.851993-2-perry.yuan@amd.com>
In-Reply-To: <20261106062616.851993-2-perry.yuan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-06T06:52:20.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB7916:EE_
x-ms-office365-filtering-correlation-id: a687803a-5f85-4aac-d20d-08df3bd289dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|10067099003|38070700021|56012099006|4143699003|11063799006|261021121427099003|261021123027099003|261102123227099003|261009223027099003;
x-microsoft-antispam-message-info: n9qxD3p9yMd3XLvcQ2CgA3EQkakopvUtkWyxWZa7uBxbE47kNt3t93Fkjus+VFqDpB0QYumJLtzEp5ozOVxX/rrscl1snP3KZsNd4XXA0kquSzptzxYK10eiIHSYjvO79A4f938bGc8CJkOQ62rqf/GASGLlblSMLbx4k5al5POJkzFFIUd9ESezI1LlHn8ZYq+lFkZvQJwjb6gc3GWcvZzMrZ+VdMpf8cmIDRzQ6c4oWK904tFKomcFRbj8UVJ7fd8CHWXZy48U95ZO8bL1caFWVuCw8wgodiH0rLEa1Q46pW3BnYxdpz3gQFiOW+8lQ8fLtAkPRdBTZLd019F2BGzq81zDrCS+iGkCQd4mrauGE0vDOv6nqW7rdz+NkjiXatnaxlsmz1OkHHxw+yIoXGpDTEdLtK00M4fNIrfyVNWfNj0dx49NEIGqdCiAxUyrBUx93+8EnDhuUhSlnz24ocNpyotepC/nZHT8FBuDL9+vhIIu34hyAj61hz35okaOT06MGaqe3/hjKOhGx7G7C5edImMFJYl4yGW/KmQRsrz4SgUXw7ENH3WrTaJnLnkvKTpvEeWI9q2i36vb26OqIAc1dVAFaqOzg5QsElMW42LaGMQ6UBgd6W/fLnGSvz+BEu1YrZ1MGEGRB9aY3jub48tvu+f/udG+aW3Mc+jkt2cyQwO6RIdTW9TMJGIl/AnC1Sm2iZVbaVd/9jNy7ljjQz+jVY2RdWZDxrZ9lBUZqaA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WRh+Twojc/QyQaCWJ6QcYr52gKHGJX12uuI+rxjz7kVbugfpLtjhBgtFQyuG?=
 =?us-ascii?Q?e49D5KnaBUv5jTtjcDtqpuBngtozrZsiXZugYhYCgB19risxEZhS+OPQxs5a?=
 =?us-ascii?Q?wG+df1TqKpN5qNn+GUAGsDbM6/AnQCf1vhLCOUfe3CMqVhJgm0fwk3WboE2b?=
 =?us-ascii?Q?aOp1RJMO7lFB4uW2Bvg9H4MwAb6M7eKnptqK/LBblqPxdaGZug0VYD8121yO?=
 =?us-ascii?Q?sCEb+ilwTlNWAU59jTmlyRzw2zL1dMPMcal0HTWxUplcYkJYuRPlgdoCR/kl?=
 =?us-ascii?Q?C8r6JHiBK3m7Q5vd12fJvzzBtyBv9Wx7ZizRENC85BFe6LemPnpGEV/iq4Gg?=
 =?us-ascii?Q?MfRnNDqszvpcNNmiLDmBaBo/tEBLz8parMg1FRPOAfc/qCzyU4jUrx8ZUQdV?=
 =?us-ascii?Q?e8NN7zdUpny9KKx8txqYPUfz0n9i0Y6ewkMg9N2sz+vVu6V0mlE96xNshsmA?=
 =?us-ascii?Q?Q2/WWHdwrXcH+mG6u2rGLRHnV14p8UdJYYJC9sTscqkVL68yPyPyCaH1hhfN?=
 =?us-ascii?Q?YElJiI1keweYVawD1FBnvpyDRbSigkdn5pq4d9uMMIB3PkAqsmXwfNckxkod?=
 =?us-ascii?Q?GmmkW/IjPDX95BCrg72IJwZob/RXbyX+y2340d3XvRv0e33aAaUXqxGAhj6H?=
 =?us-ascii?Q?WoVixNF5RVMKN4cdiVUwZxiv7Zt/UfkPP3aypVI5gnbb6RhwVdmx0TipAeL2?=
 =?us-ascii?Q?ELSs8Y+0cvxw+xCC1BnljftlRbejmYbl2XPhaYkD5e2CL8moqvu0MYzHodOw?=
 =?us-ascii?Q?SkGxnSVqki22+Sfc5pYQqonhCKk65qYC/G/XEV7mHeSlWwgiNmA9jmBNKbC8?=
 =?us-ascii?Q?pxg3pYZXh9Lt5z8QPBqJc1fKj5cHYilmTo8eFbNy0ouR5ZIU5P3rxEvfHArJ?=
 =?us-ascii?Q?hcv+sugH6QToNwgL07OvLCY/Zyr+CHPEeKmOiUS6VDH1iyxK6fH+42OBhRB3?=
 =?us-ascii?Q?1ckkR42b19hWnniBNBiPRs6ZnvNzFhcB/et/ohx82z6yzafFGQ2yUVgX0BGJ?=
 =?us-ascii?Q?3SilPA7caXPm5AJNPnS8q0UrIzXrZPxIl/0faaqPVSeFMJLG+FD4dHfO62dY?=
 =?us-ascii?Q?n3VYaOLDDizLplHiDWh44ePZnYnx3HPDtZ30p3M1ZsNHkZ6d6Km8UlaqmLwm?=
 =?us-ascii?Q?1kWXvg+bKbhWph6LoUa+5ljKQR7THfIkLZEjE/KnTab9n3uk1DhbopwS5Lx4?=
 =?us-ascii?Q?tzWBw3OWOyggu6MbSUkcClthdwSeyi+uwKfxOW5rLkTAMhD8TgZtcKBQTNs0?=
 =?us-ascii?Q?qBKF9hJfVVMdzEZ65CeHsWSUvKKNQGduZGOOTIV7BdNCUvsxg2dsEpgcI9bq?=
 =?us-ascii?Q?OPoZTtr5YY/cgp9LE4yW8kb0HCZkplCIlu9t9zDqkaFBDKP2b2iHdd2OSYyI?=
 =?us-ascii?Q?caRShrlosGcOvs0/KRnPLUaHqvw/KZlUcd95ZcnhIrzggLd6JJUiR23aiH90?=
 =?us-ascii?Q?H/stkK3crQdG9szCFhkOkzFavpfY/6UzIl7hVMo+6cX9Z7yV2w+WreI38fc/?=
 =?us-ascii?Q?KNjbERagbTeB1rzsIKjWz2OVt/cQePPWOKzgjqBF3yQHSKFJ37bKCf8NZmtP?=
 =?us-ascii?Q?uosSMgotMYczNS2CSVc+JPABdYN1JbR+bU/oDttrYcEqVGv/CdPuxED7YhGX?=
 =?us-ascii?Q?WGzF6Qs3cfsoblXHkNMwgfARiMhTV21KZqphWJXJ6ueo6N8Xt8HCXLh0Vmde?=
 =?us-ascii?Q?3s6lXcOf3vrpIxvMDlHKid7kcxl3jJOOJO+v8hViN+AM8MGr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a687803a-5f85-4aac-d20d-08df3bd289dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 06:52:35.1390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2NdDpxT/6re2LAjJvY+JMtiAkbEuzf0cX1r1J5enEBzKLQBK96k0EZ9H9BrU7VhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916
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

Public

This series is:

Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Perry Yu=
an
Sent: Friday, November 6, 2026 2:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: test copy_from_user() directly in kfd_c=
riu_restore_svm()

copy_from_user() returns the number of bytes not copied, not an errno.
kfd_criu_restore_svm() stored that count in ret before overwriting it with =
-EFAULT. Test the return value directly so ret only ever holds an error cod=
e.

v2:
- split the original patch into two, one change per patch (Yifan)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index a571fda5c713..ea1a2cca6a06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4257,9 +4257,8 @@ int kfd_criu_restore_svm(struct kfd_process *p,
                return -ENOMEM;
        }

-       ret =3D copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_da=
ta_offset,
-                            svm_priv_data_size);
-       if (ret) {
+       if (copy_from_user(&criu_svm_md->data, user_priv_ptr + *priv_data_o=
ffset,
+                          svm_priv_data_size)) {
                ret =3D -EFAULT;
                goto exit;
        }
--
2.34.1

