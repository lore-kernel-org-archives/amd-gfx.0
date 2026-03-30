Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDF31061B1F
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 20:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACFA10E60E;
	Mon, 30 Mar 2026 20:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0ThbpmRK";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59CE10E60E
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 20:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqIHXlEiXoAmHE0NKeKe77BoCcRXxIJp+qY9VCiDOZysOITV2ueQoXiNcw+8TLnyMcX0JqYhmOkpJyJdSPglmcMq22ibr+iV48auZuPCsBkPccdq0zhiKvicvvSbNjWZTk47KMW+yIWUQFL0KHhunw0jDYdq/UdO/loFEpj4cTtP895Jzcn0OqJ9dWNimGlAk7oaeXWOS81EjVj6pjIzqqnWqpmCoI5ODIy4vrEk+8e+evQPDOhMSDYTV2946D0LkdSNXnvpSnZBV+Ob/nWOS+ApMgi/12jRPCSXlY6eSEk1vzDY05VCdKe86swYzJDI33IkU6vtOZ6ZE2CXvNxKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHg9SjzT8pQdcE/hpsACSndVsKS3o4vXv1jwJRNeShI=;
 b=JOzh4kadLJIWQtUFeuc3l+07JlHggIiqdtq71/qP53dPy1agFbfGxJR2jCLV7lUwi4bd9Jl+kxrkVrdqgh/pHFeW5RCA5S+WrmP5C5jBuEl2NIhe+B43jxfEgyr6hdzh2lWftMTpzpRP4GYEABretTPdBly5uGgN+YeFpMJmn/tWhzfBxlm+Wh0q76vABsILty4Df1LyXpaLVVhnKpJXEhx1IM7s77A/pcGMcENFoIG887kvcLKhiggBC7j2cH4bFCir8O5aKAv3hjc7WYg6bn3vGpSfEL7zzN9Z5X1TG1Fm9fgtVTAf+jvihrUDOBXYFay4cDAL50sFCV1MLl4TjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHg9SjzT8pQdcE/hpsACSndVsKS3o4vXv1jwJRNeShI=;
 b=0ThbpmRKC2K3S438+j3PrurOsnfbHF76Ci6NGE3B+hbafk2lKv1TObtzFRVQxAaVABpUDhkxyGrXmtQjUK9bYmzSLnHVW7BgnOMgnCIvDbQOSlXI/y21JnnsbtHDwGdrxctYKN+g1cokkQ+B9yL6ovkXRDy3W9BkdABHYFshejI=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by CYYPR12MB8992.namprd12.prod.outlook.com (2603:10b6:930:bc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Mon, 30 Mar
 2026 20:48:25 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9723.018; Mon, 30 Mar 2026
 20:48:25 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Topic: [PATCH v2] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Index: AQHcwHQneeeA70cvY0yrdaXCqAhkJrXHi1xC
Date: Mon, 30 Mar 2026 20:48:25 +0000
Message-ID: <SJ2PR12MB86505F7DE924916903BD8FA68C52A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260330183616.5280-1-Alysa.Liu@amd.com>
In-Reply-To: <20260330183616.5280-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-30T20:48:25.264Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|CYYPR12MB8992:EE_
x-ms-office365-filtering-correlation-id: a0c2cad3-7e01-4406-52c1-08de8e9db06e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: MKkds8Xc2zymyWyqeEN1E53B5tL2Zuk1sZj8cVY486KOFU9WvkNeUCDGrvpF/L8149tiSguKek1qeSILGxwUWaq7+E2gp0K05V5zPfnP/uT3Bw8NP5CCvY/4Nw9DDo0gEDDXfQh2vW5PyDyh/wMgtcwdTeZm0YcXBipfiUtSHwkkkFRAoJ4//4s0pzRo7cSnIWQaOLNLac357qM91h1/z57mSmyCi5+D9FsMFFdaWBjabC9fUrt/zV9PLmwnYqNMvqu+sEd1NTPTYUX/VweBhBLOmOjhPc2AzuD2WfUpkJ4IatxIpOrliwA3WtQZsCYF7/0RCh9xKxmdp8xneVqzdif42QrtrwY2pVeHOTC1wd/MU0KgYh0TgM/NHD1A8Xd59UWiKfAhuXVrE2aouO6QAGQ5LxgwxFjf/E36d7sKtl3ZnfkorfnunGs8jF0fcEdFijXQNiQEHns9eIFO729e5Cvvrc2aiT5aTsdOcc6cUAkXoreiBwSMnnZMJGUZd41xedaMdMGTGyShN3w0JD0/Y1tp8aDyWBJ6TR2QHcJuFU2w5zkquBATFzy0xZFHySgbRU3BomeV8B263erC6zTYpEbCdZd16865n+9LAwUkDvvVeklzrdIKE9iGw7WfPoqGOCKi/wEl7LbzuXHXCnwaGr/potoTvRs/tThrwJTyvALct9jIMvNfZjn4GFHJdRhjqmmbWnqHUmvAZRwgJruKZ948+Xtsz3WXDWMq9u+UlUD07+pO1lH/6YE7vzZEM0EeX/ELbK6FB/qqJrIrIkDdFKqYbwDlJ3quz/mt/jYktPY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S+sqhK+lpoGBBJxG7ZsaU1qTr5KSs2s5KFoNgvFD69R6ypT38nmpLPoTwj/X?=
 =?us-ascii?Q?3t3TCsvkTOAH3D0eRDnBN8PLBsiIjpNWl0Jzhqg2YT89UlZK3lUokNVTZnE3?=
 =?us-ascii?Q?flyrJT4y+19CwPIlvzClypo3dZw9pMviX1rvdYtfqxraUgdtR1W7Z3ewOfYX?=
 =?us-ascii?Q?MSuQ0IxUApOCSQHrHkMQXfuxWq4hZHI+dWXTGagYBk4lFQO1IBbZbDtnTy73?=
 =?us-ascii?Q?BtaBnenxJgPq0bM+67Z6naJKPmOAsbYnbbmrcHX1E4soUjQm30+vJlMRSOKg?=
 =?us-ascii?Q?XLYr8llCUNjkXuQ+PjCJNyd0lKxHlZdrG3rJHH8JRb0X1KKudevDo0Zv1KGv?=
 =?us-ascii?Q?l+T9HBsoeC+3oM02s7zxaRoUYqcE5WSiFuKlDwmdCENuiHcnZSIXB3j3riGs?=
 =?us-ascii?Q?RGtc+/1MJAYXUv4sQJBoTo+DWU9HKHj8WvY7AnU22rXUWcl6scr/U4g578lU?=
 =?us-ascii?Q?C4o0yWZ5ChRiYWgMRsdd0Gz+uMYIueaT7sq2vr3DGc00xqRGuTWp85OuCE+e?=
 =?us-ascii?Q?1VB9m4xZQg68xo9KvZMdEdhW3AfEMULsi8kN2+dDutVEyZcs9MGOsxEI8TYR?=
 =?us-ascii?Q?Iuft6PfJZhnNzLCoSSquay1wI46ReCdZ7+MiO9nSnJsluD5QgIyxDdSNPrKO?=
 =?us-ascii?Q?S3H98feRVZYlboMFeBUHEXrbP/Fog7O3EQxLbEF3bJG37AOJfZDQIYvaB4sv?=
 =?us-ascii?Q?WKiidra6Qnp0s3CKdbJsnRjdtb6jHxAGgG+kk/wBByYe2j21d7VyJ6/PVI4i?=
 =?us-ascii?Q?hN5PJOs1iktPhhunkEr90nto2CLZveITyhdJMaOLRq25TiBd7OZoRvQF+4aJ?=
 =?us-ascii?Q?djZxDbmOJsso+4hgNKpXQNQdHBdcQAniOmFl0Df08RRRtpT89ORcAoxrL3An?=
 =?us-ascii?Q?B7q0wbkThnnUB/9BcP/eP/lf4AbUgJpds8u82oZVyWtNebAT7Lr6NEsezDEx?=
 =?us-ascii?Q?LsRpd5rIWEWULxYbiHmeguQQbHAJ33f7mme+3fmNogLexYX8xN0BwBFKpcNY?=
 =?us-ascii?Q?KzrE5WP/hq99uWexKOMxtolwk0MeaoOFYjzkFegAve9jIgaPv7D/+133RLFy?=
 =?us-ascii?Q?YtPnCn8G82K51AEqHOyYx8GLbYRg2YPf+Q5CEMHFD9PXrRbx+p07y6URtXCR?=
 =?us-ascii?Q?uZPP73FkWV4FA0pgO0+k/uXpTj+WjUgnf/IaN/klqqYtq4KY+4mHceaV3FQ/?=
 =?us-ascii?Q?Ucssh3K9D+M0bJ1ya9U8E/jZ2oYOpEbz6tEPowvV710wwQuWx9sTCSQWaDCH?=
 =?us-ascii?Q?Dqa3Sha4ogXNlzqlrPnUkn+0vNelvMT96E4gi8/7hsib0QksF2lD85klKLkM?=
 =?us-ascii?Q?Fp946vuDBctZxTUWMomwLskmtu487USVuzrwYfXUQBsCD5/uInBwsJmVniSP?=
 =?us-ascii?Q?Q4zVkRrans0Mso1cnaaNiC873U8h+tppX6kf8RBjgcVAn6zg24S7+yqeLLye?=
 =?us-ascii?Q?AAgWPgNd7qmLnSLNukP0M821wSBKjmn10x9v0LNDTksM2iAUDQWaywwL4r3Z?=
 =?us-ascii?Q?H/lBJL4tgaM7vX28VWRQf7Uedse5lPjecuj0JHhh6pMvhJ0peYAWDDj2CEAI?=
 =?us-ascii?Q?lZKB9PpouAXzyZZiBaIMmdB6EarD1kk5C411jpCj4jnVkvDljSfkamvbHn/I?=
 =?us-ascii?Q?CfYUfVh+/AKy19hNPNOIPBEcO2sthsQOZmaVRSgksqz//Xqxd0Oea8nLIpta?=
 =?us-ascii?Q?Q+9Bzn11lIlkze9jIWRYA1QPgZvuXqoNT5YA79c+aWvgaHW4?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB86505F7DE924916903BD8FA68C52ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c2cad3-7e01-4406-52c1-08de8e9db06e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 20:48:25.4187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7w6RrPN0mo5MrzBSSgpoRg6T97jEi9JjtQ9N8GuxX5Y6V67Fb6R2G15BbMxQBVP610IW/GOnqFBo735STCmiuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8992
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

--_000_SJ2PR12MB86505F7DE924916903BD8FA68C52ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Looked into this bit more. We need support max_nodes which includes CPU and=
 GPU agents. P->n_pdds only include GPU agents. You need to add CPU agents =
also.

Best Regards,
Harish
________________________________
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Monday, March 30, 2026 2:36 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>
Subject: [PATCH v2] drm/amdkfd: Add upper bound check for num_of_nodes

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 1db565442c48..91f807c9e553 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,
                 goto out_unlock;
         }

+       if (args->num_of_nodes > p->n_pdds)
+               return -EINVAL;
+
         /* Fill in process-aperture information for all available
          * nodes, but not more than args->num_of_nodes as that is
          * the amount of memory allocated by user
--
2.34.1


--_000_SJ2PR12MB86505F7DE924916903BD8FA68C52ASJ2PR12MB8650namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Looked into this bit more. We need support max_nodes which includes CPU and=
 GPU agents. P-&gt;n_pdds only include GPU agents. You need to add CPU agen=
ts also.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Best Regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Harish</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Liu, Alysa &lt;Alysa.=
Liu@amd.com&gt;<br>
<b>Sent:</b> Monday, March 30, 2026 2:36 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&gt;; =
Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdkfd: Add upper bound check for num_of_nod=
es</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">drm/amdkfd: Add upper bound check for num_of_nodes=
<br>
in kfd_ioctl_get_process_apertures_new.<br>
<br>
Signed-off-by: Alysa Liu &lt;Alysa.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++<br>
&nbsp;1 file changed, 3 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 1db565442c48..91f807c9e553 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;num_of_nodes &gt; p-&gt;=
n_pdds)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in process-apertur=
e information for all available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * nodes, but not mor=
e than args-&gt;num_of_nodes as that is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the amount of memo=
ry allocated by user<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ2PR12MB86505F7DE924916903BD8FA68C52ASJ2PR12MB8650namp_--
