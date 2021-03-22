Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB63CC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C3661966
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 05:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C3661966
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24CF989FF6;
	Mon, 22 Mar 2021 05:57:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247D589FF6
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 05:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPCqSg9cb8fScVe/1RUCyDoHsB6/cBYhSzGxfNBiQx4h3UCgVJyoIFMcMzJ1atuQpiObQMjAzrOS03HEUA0eo6a6c0sZmxNeagQY+06Uia7cotfGQTEqtt7CBoPmObsX/bwt+dVRMwn72a0Di8G22PZHTGl/Q34WR4OsqzKQ/1s61//4QXutG4rmikFzMNpqMa+tjQSyJPthKJ605njsSOr6cW1V7I7bmC/cxseD7s6w2UcwgNoMLF+HEvzVtW8+g001AK35M+5HtTcXHaC6pT4Zma5vImMgxU/5qHHos4C5ruvvZ6y3rKsJ/2eFDL/zghGZx3poNDdKlxjNjBi8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMGhYmYMwxMAdbgqvyQcWXt9MdPIBS7TBeK3etNnkzU=;
 b=C+xxVJ3NBhoEt0R2hvspLaJfsbq2rL/QwAtEoypuwtrQ2HbaOWVc9vC0GYX5z27s1USOZnOb3+eZwSzpjU35fYhgTdR9yBNGfDP4rmalRjCug1pgkqFm7CeLnNgD0ziR1am4nA0ma1BQf6rkJvJGkWQfemsttMZ1LzNlEszcAgSB5CcN70IKd3psVUkkEOwCIXkpF+WatgXVZJTlEJhOQTuPhI0OogAb9fMG0x8Q7C80024N23UA+5X2NQ5uob2hP1BoLUu2A1J83OLraRxOpbfjqYkjmgConcgiZk+jLhYr+m9YRk4Fb8GE/nSSZlH4YfX3bUOVH/E1v3g/PDrZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMGhYmYMwxMAdbgqvyQcWXt9MdPIBS7TBeK3etNnkzU=;
 b=1YbPcdvxqEP5p1SAsm5XCFq4qoy8UPx6rNqViHmUfNjkBjJZDKgu3EiC4LOj9DYuzfGfPlYMckArEuD7ATiaJtoSkpd08WwVhfV+dxCLZRw3XULo4SuTuM3phQTCUCATh0v/JYdF2ur+iAL8cMU7FSo6LcQ4u5rEwJGfpyzc8UE=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 05:57:53 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.025; Mon, 22 Mar 2021
 05:57:53 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/8] drm/amdgpu: Add PSP public function to load a list of
 FWs
Thread-Topic: [PATCH v2 6/8] drm/amdgpu: Add PSP public function to load a
 list of FWs
Thread-Index: Adce3rTN2ni0CyHvTZeRfbtqewfwqw==
Date: Mon, 22 Mar 2021 05:57:53 +0000
Message-ID: <MN2PR12MB45495A262AE6E7B126FED5D097659@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-22T05:57:51Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=25bebb11-f19a-457a-8c73-fd9210d7cf02;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.224.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 05b39856-12a3-48db-d904-08d8ecf76f0c
x-ms-traffictypediagnostic: MN2PR12MB4254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4254D58A5F6D54E507E1AE3E97659@MN2PR12MB4254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ggC19zgtg7WHtcbRNKwRTtfIcTJVIJ7oxjGD6CQz/gNloeE8nTwjultMBFOy+XENyMx71i/BzVTAlJJJj4U1tVZZ4xRGAg7qc7PraW2LlVIPhsidorBPof+dWZmQ9HklfJFtUD18C2WiRJY29ieSiIRIY4Ed8IP2IQ2euDstih7itwXSOsMvrCyGzjF/byrU3yQOR/X6lYdeeV/CnWHYDe2KmEAdc2kMACEzQEfmAf6XWfvG/AGapANUNUhep6laFLBEfj4ShwF+qN4FlETqRJUXdGK733XrZUpKnSwPpUGqiUSgkKIY9R6a3IhvjxCcA8Z9c7/Ffx1G4IvajV5eihJLctOTC9DU684nsSVExq+VDkxRozB0I+CMb8La5OdlkhQBK9Q+nJNPeuk7ylXNzEREGsKnlxtByL54oDMXuyD08wCAA2QBdSjueW+kQLNiAx7IZsU9Gk3byOUvEpIfGQJAgQzux4Z06/KbmuaI/tTP0zOFIpuaEZWPN3p2vVlISZxUqhnL2Rq+asOINYjtLY/h6om2fgebkxoYMQBr5qXgAUf98b5McDmUBvbcqAuPWDuEtDm0qBZ+1nqg5QD1hKDSgxIkzCB0FNKZxaTINhYkcfFN4FntLwYPUjrU0cGNRQ9X0b6JCYz4cJs4umoevlvv5KssT6q+gIAahbBjJF0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(33656002)(76116006)(66556008)(86362001)(66946007)(478600001)(8936002)(66476007)(8676002)(64756008)(66446008)(55236004)(52536014)(71200400001)(6916009)(38100700001)(2906002)(26005)(316002)(186003)(5660300002)(55016002)(4326008)(7696005)(54906003)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hQQR+toL83lxFoqSRXXGymAkeUq4rQQozi1FqSw8OViQtRf+Uni0bmnzuiaV?=
 =?us-ascii?Q?5t53YYylL08kfUPxNTUVzb59yIw4aQvlcGAKYu7qGtBiaSNxGj5efphakoPV?=
 =?us-ascii?Q?HI18Ab1TbM+6Y/yMUl4BHNHc22kCf5ApcWrJMqpbWQwxanI1yV6Td03CwABC?=
 =?us-ascii?Q?1IGDuzEpqoOWTVjUX2BR/ObSRIyzm3rF88rEePuNwFAWG4hEv+2Ri94fyr8E?=
 =?us-ascii?Q?zaI3EpCFPNDCetSorX8dNqtHWJwNWb3vhcmrGZZG3aSQ8tdS+9pWhfC/5+6z?=
 =?us-ascii?Q?7Mnufc3DLlvKqTkYPImI4+1D12EuiZ3NSYUgCPnAOnzxkbYKgj5Sl4ru7MpX?=
 =?us-ascii?Q?AnP2K78heRcHwagpVAtYBV2KnqbhSpGKYxralUD6xpbvHnaHVjb5qqYQ4/Um?=
 =?us-ascii?Q?MPbqRxekq5Dt0e+1xcD1O0sgCS63VfJvX7sj9ZWU7nqv0y9X5NvjUaXiov6K?=
 =?us-ascii?Q?pQlC5V8VaVivd6oEKHVRU66rGh+U2fHdIstubE+cdxxp/Jd/vd0QAkQiuDt2?=
 =?us-ascii?Q?JefqZq0RXufJeaaYry6ZbpIOAZkIYnG/7kYR1JKTuaV/JdeMylRIOhdBJyo4?=
 =?us-ascii?Q?NiuTE7uvelPMoBMIK48od+wlHaZiodcMjaO/NcqpZNY6Z4jPlVgnuZCljv06?=
 =?us-ascii?Q?ZZgp7Xitc3ltIHzm8Y2LpNQbgiq0jw9COGF5srGa5XW7wX/D9ZZM1dZo5EUd?=
 =?us-ascii?Q?g64Cd0pA51K5ywjnzYqKq3pWNLaTW/BesO/ISz49OKAFN3c4rjfTmuR1JxLv?=
 =?us-ascii?Q?6tW7S8a+CJkXct0XeA5Tdjuxt7j+r/9VAN9cGw6pg7hQUuxMccIRiAGRDx+T?=
 =?us-ascii?Q?koCbmHRGTFnY8DALwhqs0l+AdtWoXF9YERo2h5hP9aaLwz71cbOqOFNST9oW?=
 =?us-ascii?Q?KJQUezBgHoFJ4iKPYxcgMzZokJqlbG3vJavtVQjJ8KTpu9to/8UzRKosAFDc?=
 =?us-ascii?Q?J2sPgOJsL5YkfnAirguzMU0FQES2d7dhSolTOer5u1geiCOkdH7rl120CBhx?=
 =?us-ascii?Q?JgfWnM4M3J4dtFBr6khLVFjWPw2KOVGqEORAZEji7LC7oc5bLNgRSb6d+wod?=
 =?us-ascii?Q?up85euko8KOwkIEbrJ2wSecj92JAVCAju3WhOK/a3OW1K0Odnl40BqfdvEk+?=
 =?us-ascii?Q?3nKIHLcSU9xYB6Q77va58UsuInR7N+XiVsSclJ0qCsB+MF40JQ87MXNy3ERb?=
 =?us-ascii?Q?Q8/kDeZJcZLW/khYi1reOOfsRwu0yOL/PGLRBEeHQsYsXM88irT4PCnDj1Sc?=
 =?us-ascii?Q?94Ak16EER5gjwOshbmNGsES/tySArKfaiXH4zMoF9+2s28mVIur+Ev0BkTgF?=
 =?us-ascii?Q?4iYH1idX2Dpqp2zRfx+3KLes?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b39856-12a3-48db-d904-08d8ecf76f0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 05:57:53.4845 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JwtXb3cIMjtSWUqCyLi/YMCzvCfS+KYGEUgeznTQRUlweivMDf1l2/Make7KMBUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0182897524=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0182897524==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB45495A262AE6E7B126FED5D097659MN2PR12MB4549namp_"

--_000_MN2PR12MB45495A262AE6E7B126FED5D097659MN2PR12MB4549namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

v1: Adds a function to load a list of FWs as passed by the caller. This is
needed as only a select need to loaded for some use cases.

v2: Omit unrelated change, remove info log, fix return value when count is =
0

Signed-off-by: Lijo Lazar lijo.lazar@amd.com<mailto:lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++++++++++
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  3 +++
2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c2b7ee693719..60dbb8c1e74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2204,6 +2204,22 @@ static bool fw_load_skip_check(struct psp_context *p=
sp,
               return false;
}
+int psp_load_fw_list(struct psp_context *psp,
+                                  struct amdgpu_firmware_info **ucode_list=
, int ucode_count)
+{
+             int ret =3D 0, i;
+             struct amdgpu_firmware_info *ucode;
+
+             for (i =3D 0; i < ucode_count; ++i) {
+                             ucode =3D ucode_list[i];
+                             psp_print_fw_hdr(psp, ucode);
+                             ret =3D psp_execute_np_fw_load(psp, ucode);
+                             if (ret)
+                                             return ret;
+             }
+             return ret;
+}
+
static int psp_np_fw_load(struct psp_context *psp)
{
               int i, ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index 64f143390835..46a5328e00e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -420,4 +420,7 @@ int psp_init_ta_microcode(struct psp_context *psp,
                                                 const char *chip_name);
int psp_get_fw_attestation_records_addr(struct psp_context *psp,
                                                                           =
    uint64_t *output_ptr);
+
+int psp_load_fw_list(struct psp_context *psp,
+                                  struct amdgpu_firmware_info **ucode_list=
, int ucode_count);
#endif
--
2.17.1


--_000_MN2PR12MB45495A262AE6E7B126FED5D097659MN2PR12MB4549namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheader251902e5" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#317100">[AMD Public Use]</s=
pan></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">v1: Adds a function to load a list of FWs as passed =
by the caller. This is<o:p></o:p></p>
<p class=3D"MsoNormal">needed as only a select need to loaded for some use =
cases.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">v2: Omit unrelated change, remove info log, fix retu=
rn value when count is 0<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar <a href=3D"mailto:lijo.laz=
ar@amd.com">
lijo.lazar@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++=
+++++++++<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |&nbsp; 3 ++=
+<o:p></o:p></p>
<p class=3D"MsoNormal">2 files changed, 19 insertions(+)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></o:p></p>
<p class=3D"MsoNormal">index c2b7ee693719..60dbb8c1e74d 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -2204,6 +2204,22 @@ static bool fw_load_skip_chec=
k(struct psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">+int psp_load_fw_list(struct psp_context *psp,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_firmware_info **ucode_list, int ucode_count)<o:p></o:p></p>
<p class=3D"MsoNormal">+{<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *ucode;<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ucode_count; ++i) {<o:p></o:p></=
p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode =3D ucode_list[i];<o:p></o=
:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_print_fw_hdr(psp, ucode);<o:=
p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_execute_np_fw_load(p=
sp, ucode);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<o:p></o:p></p>
<p class=3D"MsoNormal">+}<o:p></o:p></p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">static int psp_np_fw_load(struct psp_context *psp)<o=
:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret;<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 64f143390835..46a5328e00e0 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -420,4 +420,7 @@ int psp_init_ta_microcode(struct=
 psp_context *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;const char *chip_name);<o:p></o:p></p>
<p class=3D"MsoNormal">int psp_get_fw_attestation_records_addr(struct psp_c=
ontext *psp,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *output_ptr);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+<o:p></o:p></p>
<p class=3D"MsoNormal">+int psp_load_fw_list(struct psp_context *psp,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_firmware_info **ucode_list, int ucode_count);<o:p></o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB45495A262AE6E7B126FED5D097659MN2PR12MB4549namp_--

--===============0182897524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0182897524==--
