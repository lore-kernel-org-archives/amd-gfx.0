Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB8AC6FA82
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Sep 2022 02:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67B410E27E;
	Sat, 10 Sep 2022 02:27:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0E810E27E
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Sep 2022 02:27:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgeNtXfqJAlDrPkBw9FSsnBXky4yg4F/+lmUe/p3/88yHNeo2/Ew4Td90Ro/iav5Pz8LKB5J76pjfIPTvb6Ph/EUTd7e+JwKBlT9LADYurG9SX7soIskOa7726ZFJHI26BHJe9vpN0Ju+rwJ8qig/jFs8RJhojlNyvbaFkPuCg4CDvHv/MF79MZO8s/oJRMqll7Oqcu34CxoV5tQPjWBH17XOTW3tNEPru9nMMWT4P1bfZN3C0SKHiXNZNq4h7sctnzKEaQq99oOS9SLVmjfsMxBYlFxPZJ1Vqcm42HIY6X6bghvZ0ACltL+UKtkKh7o8fbg21/BQdpB29DDgzR4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4OKbzWZo7l+VwF6vsMAS4Swl3Za6nNh9n5/IXpE2rk=;
 b=lReZVDiRjny4NRDveHhwhDWsc/6qYYyD6uaXRBJK2g8Ki1Huqenl0h0rHvRFCQH1S39sJrOoBSJdK550VCEbKhBITFhxuln+WbXbwppnp037FXAIBpunHDBjyhNmd7C88H4Mb690J9WbKg1DnlXAGD1DzNeJyBCrmrdRtFasjcSKehKosRk2a5ZXEFUPUHITQfon91Z+gtPVOXI7RhWYxiI2FsuCTtmQ/GcbxSimIAB09foiKzRvcL3ofiAzDQzMgC80EEXcWUhTx4AQcKnk5F5eoLPZTUswm40Y4/hAdGeHyKSZ73fYFrvex0s6zEzYiml4W6i1SY57k+ZQCPIagQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4OKbzWZo7l+VwF6vsMAS4Swl3Za6nNh9n5/IXpE2rk=;
 b=flDulYVwfpQHx7bvNSFcv4IycNc9eUvBLclT2Btp80TYWmkcSZpO5G6pBc+GdriD6ZeZuhgDjILLtmNZ4CUsWCTfgmbCxl2OoL1tIC6H87Qh14anc30lVnT9pNHeW4JJDlwJkHIoT/48wtsgFjXVIuCXBnrmG9tnMxAkVegJAZw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5820.namprd12.prod.outlook.com (2603:10b6:8:64::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.15; Sat, 10 Sep 2022 02:27:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1192:d133:8667:ed28%5]) with mapi id 15.20.5612.021; Sat, 10 Sep 2022
 02:27:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix warning about missing imu prototype
Thread-Topic: [PATCH] drm/amdgpu: fix warning about missing imu prototype
Thread-Index: AQHYxJTH55dcBygYV02ZkkPr8BzM9K3X8H+g
Date: Sat, 10 Sep 2022 02:27:30 +0000
Message-ID: <BN9PR12MB5257E824AFE5765E03C54044FC429@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220909214005.1215345-1-alexander.deucher@amd.com>
In-Reply-To: <20220909214005.1215345-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-10T02:27:10.5885027Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5820:EE_
x-ms-office365-filtering-correlation-id: cc4ca60d-73ec-4065-72ae-08da92d402b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ezNPXBxyoPDkydkr5GFOLD9yyxXHCUdl98b/CTV72tditv+yQTJX/Gw6ERAualHhI3wXUVCwxAkfL6JUiAmpKhUocaqFa9WCuhgzDMkh5eFKtMk9Ir5dDQmTYsAqZGZVLAuIOkf5Nm1vUBmDJ5RK4IAeX79vP9p3T1AF59B347vKr2L3GpMI2udp3v6y5e86GB33NDcTzqChVV+EyJ1fb4rjuYapEuC5CY39NnYUfvV3jLoB3NeRRlnfAs4E71dpZLGJY3CWwl6fypaxeHYVzrcvL3PYnNOekzdS/4YgaTZohfnShztrnR8upZhJkGhWM2gtj1w6rN9MpJ+MrBRNN03BOqVTZlqADatgCyIjShoezNGMf/zZdUq9OhXSeyQlTVUSpf9VQJs1h106twte7pabNSn8n8Qc3KdpYU/NyZ8Oft8NO9+D7Da7GdNhT5SOWvmIYKtYNASpZ8pSjsj/bGH3fbEs8IotESt7tpKsK8r0b2cyV3rVtkU7L8wnlac7leX7QMcbudj76bqTrzCuojS8Ve4c1lqWhl+h8qUuoVSjmihrvnf/RMBIn59kJPnMZo1rAcTgA1KwD/dDCvxE0UO+uI4OEI/YdGIT22CvSBMSuHlhPB7yMdKLCI03dtKm1sAZyZHQAkTZpkz5TFjnvyMyO7FRI1gSX6XhB+37qIzKJbiziAS3KEMWuGWowIdOa2br5DTw0CQ77dT1ph+Mq/qO1o00K8G6xk3ODmFzg3NFg9Hs01LI+ZAd4nUvAfoPWRBgHOS8QA1OGnB1u2SgVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(316002)(122000001)(110136005)(38100700002)(83380400001)(33656002)(54906003)(53546011)(26005)(6506007)(7696005)(9686003)(4326008)(66446008)(186003)(8676002)(38070700005)(64756008)(66556008)(5660300002)(55016003)(8936002)(478600001)(2906002)(41300700001)(71200400001)(52536014)(76116006)(91956017)(86362001)(66476007)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3X7WBB4wEcdXDxXKA1mOS1l02EbGyg9X90tHKqshXZ77c3FeV40krbuFjaCF?=
 =?us-ascii?Q?X60TeEKF05Y37MSKl6ztIIHUH71B9tOUrRKeuflGjrhmPAUYTKOLFp+ThVnt?=
 =?us-ascii?Q?mY3tuAB5ZhvnUCJqTnBm1OzvYU3eUjBi4o/NA3NuPon1gXTXoDMw7gnkRzGy?=
 =?us-ascii?Q?yMdSfnmIJdrD4zrY4uD7cmr2ZgVG8xhaApZcaoqaQrVIBPCa7KtAmchpcS8o?=
 =?us-ascii?Q?Qk4ZfswK4XoWU5A86WjGCHUoLTXbDInTSwT0lGujmh00JW27uK4EgsBkfhZO?=
 =?us-ascii?Q?7523gYADkNx3iPgo3sxKkT8EzUFmz2sTWSSI27iG+tAOtrRHoO4sdqXBNC27?=
 =?us-ascii?Q?DduCc4ro1KtXo2tW26r2a1EAHekPvCsBajN3qSphG+st8IG7xbOWDln9778T?=
 =?us-ascii?Q?DIH3n79GK7g0SexLadi2lIuG/Ezet7g/vYCujVl+kDE9/6SCNYXpmhVbUaYZ?=
 =?us-ascii?Q?Ap2bwyvO23Y8HpzPlJ9nxwVIr/HHb02N916oYdvYpbFyziFhfwqwt2LV0Uyt?=
 =?us-ascii?Q?DUJK+FisMfJggvbbxGCxItNV1sS2uEUfji5Uto28CHaj9x8Hvms929U9/eF/?=
 =?us-ascii?Q?QxqZGxxxWfQvKwuOhkMGNJ5M59hwZGYl+teulJkwiAnsW1g6spqvGMJr1rDP?=
 =?us-ascii?Q?ZBgajm14EgftpIOpx26gTcgUPAyz0G1lPjftCRTmK8oytb3/R88Xse+u1VLy?=
 =?us-ascii?Q?nGnt2bb/wLDRAz5LZM4fJ6pGfnkHRPv1oHLbImskwDKul2aTbM2OKwj6RlIR?=
 =?us-ascii?Q?pBP9AU2HzAMVpY4ldJM4fWu0ZVvd3CYekPc0GCE50N2KhfT7Op7HFUeTy1uc?=
 =?us-ascii?Q?fgauF2ofIm7yGFtUOSJh7bHD1doZ8VWtNDqWHVhrEbhpWFn15snfrELm8fiK?=
 =?us-ascii?Q?pNM3vbSbL76RM2+ctBkR/xE6ixEE8nOYzYc5trmbPpcfAU4mG1UO28Ew16Cn?=
 =?us-ascii?Q?YWz/V9rhj0bLC1wSWuiPqw7f599JJpAryAuydYBemRTDgVwNWGKsdYZoqYlq?=
 =?us-ascii?Q?9KD0qvvNBRP9Hu5VEKgi/OlgdMvN3cKdjnHlSRKtVFwvHWY7VYHE0tWaY6cZ?=
 =?us-ascii?Q?/ETjr0qDdF54mZLrevvYKfp/EHC+jxAz169o/eKvqf1KJLVQyR+ODeZpdalD?=
 =?us-ascii?Q?NhJ8qBKWq2T5tKYbr3rTT4UV6yeui1++Fsg3w0XXOC5ariMfI8l/FRz3iIf/?=
 =?us-ascii?Q?Eww72zn+sv8EozpCls8UzqeR5uLzfBvOpi8BITBU8pz7qEqy7AqQ0QK+ownf?=
 =?us-ascii?Q?bB1iQidatemroqiTzvJqPH4cPUuzNBM8nfHGagNAtDpM4VA6NlgzvglrXRVs?=
 =?us-ascii?Q?Wo97sjVp4S4GrqxdA7WIgcY8oRx4ydy3gj+1rAjCmvrXBunKJyZnUbBRYNAK?=
 =?us-ascii?Q?JHAZ64NzeJ5Qf+5wQLaHZqlBgeVeKTVGmzW6JAfpKCGS377FqNFSNwd7Y78m?=
 =?us-ascii?Q?aLgwzJJBqIwMRMM9TZVYA/Zuvj1gWYJN/Q44hvN4kztgLagOayqBkU7dl5w5?=
 =?us-ascii?Q?wYp5EO30/QVC0JTHKFiAAaUbTuQT9kKHrn9BNJUeAkVp1es2Qlr+St2Ks0fA?=
 =?us-ascii?Q?1F6y5m184QxbB//NTea5Izh+8o/y1wtU3MaoquKcTbS4Ug7fUIGsTYhSW4T2?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257E824AFE5765E03C54044FC429BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4ca60d-73ec-4065-72ae-08da92d402b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 02:27:30.2398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuTluM7x9BY7pgGkg+tc+5y2ebVKhaYqG1xgeVjpOViQKE5kahBVRkVom+/E0nWUshI/Bo/aciKYMjJMrq988w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5820
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257E824AFE5765E03C54044FC429BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <Alexander.Deucher@amd.com>
Date: Saturday, September 10, 2022 at 05:40
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>, kernel test robot <lkp@=
intel.com>
Subject: [PATCH] drm/amdgpu: fix warning about missing imu prototype
for imu_v11_0_3_program_rlc_ram(). Include imu_v11_0_3.h
in imu_v11_0_3.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0_3.c
index 536dafb57ee0..fc69c1a29e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_imu.h"
+#include "imu_v11_0_3.h"

 #include "gc/gc_11_0_3_offset.h"
 #include "gc/gc_11_0_3_sh_mask.h"
--
2.37.2

--_000_BN9PR12MB5257E824AFE5765E03C54044FC429BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;Alexander.=
Deucher@amd.com&gt;<br>
<b>Date: </b>Saturday, September 10, 2022 at 05:40<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;, kernel tes=
t robot &lt;lkp@intel.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: fix warning about missing imu prototype=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">for imu_v11_0_3_program_rlc_ram(). Include imu_v11_0_3.h<br>
in imu_v11_0_3.c.<br>
<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0_3.c<br>
index 536dafb57ee0..fc69c1a29e23 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0_3.c<br>
@@ -22,6 +22,7 @@<br>
&nbsp; */<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_imu.h&quot;<br>
+#include &quot;imu_v11_0_3.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;gc/gc_11_0_3_offset.h&quot;<br>
&nbsp;#include &quot;gc/gc_11_0_3_sh_mask.h&quot;<br>
-- <br>
2.37.2<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257E824AFE5765E03C54044FC429BN9PR12MB5257namp_--
