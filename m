Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B09C6379F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 21:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7D710E266;
	Thu, 19 Jan 2023 21:31:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26CA910E266
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 21:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlhpePJ58yuFVHyzNfxdJp87lgeDVZ5EnHVfNmFQ9mOUyY4hfLE26jIfhLYGNqIcOIg5s3klf+mRJLhFw2eK5GxH8yFB5Q+3E5vjPJy4zc59WQx5Ou1oI7jadFEMMPJxWHDtkmgH2rddvGi4OnLMPawXmVp/9gGxT1J6h5Eu7eD5riRww2RKhnFPbhK0eHsGhCUnStmCXT9IJyCBPgH1cuRLjmDGZ1GUXwpE1d5W2hiJ/oivUK7cxhTWzL/pXL/ATFk3ESQ1Byol0w+9Pczg+y3FlfFT8jsMAXBpGQh7ox1lAYSCnr3L2ddW/XZt0izT0xwVtAjNtUpCMvcLE15S6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f5gxFD5PsyWgBVR7T40UEVdv9iFKWKLOF2Za+wKBMk=;
 b=YXoYQJZEEEJjkVWd9uDFjN+UXdm4oDnr0gu/gWrj8uGJOk+K2zVXyJPj9Dn1B5qJ/rYrbXMflX0wlqJW5maIOtji/hwgf4yVLuSvB36w0/eBTUmWOvW3U/r3tepdPUrRk/jUEASusJR4LHJ/P/OGHvfiApqpNZf4GrRbRzDNU9YQ+klBL3I6F5Ma36o8DNnhr2aCpymORfSPEB+SAO8mjYfbdOURLIrnxNRHsG4k8KffxgZaD5QMpDXkaxXfXv9bdP5um3Me14sPEMLTniP7pq7GRsuacWSjCYOTNH/0JPy8vA/Bv3a18nxM7yE+FFXV/U0gNFbRTSCSZ0H3Q0ckhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f5gxFD5PsyWgBVR7T40UEVdv9iFKWKLOF2Za+wKBMk=;
 b=fZc8tSgfNU8P0jFo/W1akVqgEpqwApYQBy5c2Yt/JP50pj+TscaaygEDsSKEh7BTLfZBoCcUU4uo24QuqI4HMdxIlNmZVH/FoGALZ1YMNPhlb/5DRHawE6Gx4yF4B0RLRtm5Si2fvP1eNSR+tyAa4PHyiwYg1tW/rGW9Y+1+CnU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Thu, 19 Jan
 2023 21:31:41 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::5cbd:2c52:1e96:dd41%6]) with mapi id 15.20.6002.024; Thu, 19 Jan 2023
 21:31:41 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] Documentation: gpu: Fix number of columns in APU IP
 versions table
Thread-Topic: [PATCH] Documentation: gpu: Fix number of columns in APU IP
 versions table
Thread-Index: AQHZLEtAhF1iTg9pCUKvNtZVp71f+K6mQdUr
Date: Thu, 19 Jan 2023 21:31:41 +0000
Message-ID: <BL1PR12MB5144BAC5BD8E25D820D1D0BDF7C49@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230119211554.13728-1-mario.limonciello@amd.com>
In-Reply-To: <20230119211554.13728-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-19T21:31:40.271Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4110:EE_
x-ms-office365-filtering-correlation-id: 9cdc73ad-e342-4b3b-387e-08dafa648e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eut/W2KLv0EbwaCuzg8UIJwMEkLou7Ky0c9XfcFWKf/ON8WLTKCY+GysshF6z2px3es3eWCabkPuwGpkeXe6S2llWp+JJBkFr0OGGPrz4WqaNpZPBE3jhyQMSAl+r9HDhM3xzkLnH3pjSyRkJJu08nSN2z3LbErP/UuALh2sPmJOUYREuzCUuXFkd3VMqoA/mTn86zR5Nnq8J0TwnZjpzy3QoYiHTeGKNjGhhXQlulRtGO2wRtmADCilh9KvwDg72Ei8d5Hv3LmFG80Z4lQuSCxXCYlKLDTw4xF9ERLFWXFWoNwd5B47orrOEgjTcqzli1vfpwvGXvy9YKmQ0AX3NlDSrM/r1YkuSohNrRavl6fi2nYADwmXuI26+vyOmuoYpbhLQk7i5y1GHwA1YaX44J5+rL/JaYDeghPOZCmWv1kFYpb3CG9AtR20v8sQMw7OMpfryw5PI6O1svxIlkotISgSwWPsxj5Wnqj14UMx+/Lyu1TfVjnBenDcxr/Tz5fFOSkVnMrzFnjej3glwmG5fxx4FiQArXon0O1a/AtIHXkM/dIh2T0E8AxHZVTLWDgPC0weFBUwLtdbtFKf1jlYNyp/grohCLXmkMFOOpmcU7Zjh/NtVXEkI6P5I13A645+efqMpeAVw7bwClR5+p1OXJBklsh1n/YJvilL48CCSIE6ON+YrIWDq4HRElZ0oLjtPj0MnnoeieEog7uC2cQ7WA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(55016003)(38070700005)(19627405001)(6506007)(53546011)(71200400001)(478600001)(7696005)(2906002)(86362001)(110136005)(316002)(5660300002)(122000001)(76116006)(66476007)(66946007)(64756008)(66446008)(83380400001)(33656002)(52536014)(41300700001)(38100700002)(8936002)(8676002)(66556008)(186003)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vr1KFVSbt+tNLLL9LnT5fi3VcBxaIljnxE6JcZFYmBABWwaC37YS9gScYkNh?=
 =?us-ascii?Q?lu4phM5JKpwk2skNPAkxJXtONFRDPMdAfKO++bpyOChbFO5qCdNPiMh2EcF3?=
 =?us-ascii?Q?tOiyIR79shBsonftBZhdODRtS/0duzQ+Jfd8KXBsvjvInnQ5isoVm3JZFJ76?=
 =?us-ascii?Q?T9xq8lioKMHQh97CT49tp8wSL29UU6YjpTLVHecAiPiBTSZL4CGChXCC3oI/?=
 =?us-ascii?Q?pJ5couLCjuxo9bRrHP8teXfM5V4Pfqz9bJwuLETI+buP2RR6c13Q90wADR5l?=
 =?us-ascii?Q?v60zhQt04FBgtMkw7atdsMr7N3RKsVwEd7ZrlVf3Pe075wUtiCCRTPx9XygE?=
 =?us-ascii?Q?xJOnBSiM9e3s00o6TpU0UpkZopsAS8X9RMChguQUyKH7h8y1kpOEn4d+WW7F?=
 =?us-ascii?Q?scFuPcZINb9JnPZ3r53qbd0qst6uH19+g2BwVQ6agK0Ake/Z7DE6bBtRcr74?=
 =?us-ascii?Q?J8lUt7OPekE15IzL+CxqPgVe59+I0G045+GsfieAkgCMjbe+/+khTCRkPDsE?=
 =?us-ascii?Q?1CbnWb+EdrtEzTueSRCUX0g2Ce//vgb5Ix4SB180DQtl2FotpLKEiorKW9k6?=
 =?us-ascii?Q?wSLeSubDSwunGtQicHhcahEmZ3T0xEP+ig4xisPwzxCfHDWJdUyO8grKB078?=
 =?us-ascii?Q?X6uoV/tSpxIndko0lPleQOGO9vkEj20m3olbaa0zQ6fm0bE++Ag6MPMRKVjy?=
 =?us-ascii?Q?42DDbBtHDJ42xOWFuUoG8/zQvBhva+b/0YdatcWgv/L+ro3smJFYNSpEQDHH?=
 =?us-ascii?Q?rA6fn9Fpp/jtkShrge53ZIlg7TK6KYGZsg3ZB5W4c68Vmphfnd4I/ScGKySd?=
 =?us-ascii?Q?wuuhC0D3YAXJfF2fVIc/aUx6QVJGVP9ebAogi6A1nNbV/CFPA0q0WMMlb0et?=
 =?us-ascii?Q?nJoDLVC+i0PSdFRttcHjNOosZQ0WkL2cWr+n8JKVfnjHJNFv+lGVdofQfmLb?=
 =?us-ascii?Q?6lAsE8zRdoP5Icob67uc3ysIwU/LJW1Te0x/qOK4U5MBzibpAVXRuhQgMxve?=
 =?us-ascii?Q?byhjefRl5vacJ2GWGVDq1w5My8/IfX0TVqzi2+hC1Nk1p0Xr1yxqKcprBvDj?=
 =?us-ascii?Q?TDYuhU1kN3d6jSv0zMJellDKH6ZGYnreTiKEvQ4QP1ou9HZ884H/rjlMDOGj?=
 =?us-ascii?Q?cnFj/pgAUDjIdldhkR3ZBupzrNBn1jXDcile0w+qab2Gu9dFi2wT2JTXt7aX?=
 =?us-ascii?Q?nuG5Ws0OUE7k+9IDuNrFRkXL6bY8NWklaUm7PqU+CzrXlLBwlk3p+zvQs/uk?=
 =?us-ascii?Q?yywVqZyoAl9fYWnWCO0aQOoJ1eO/Cbos3vUlcUjgqH3o4EwVlu/w36aOfWNF?=
 =?us-ascii?Q?r5TDnPH6GwlgVqiqkj1jtfD6SUHDCWdbpR656y/8M4zkK3Le86ZVq+BW6YFK?=
 =?us-ascii?Q?QzYy7+RzX2dmV3n/cNJFUpBE703lsy6hB5rgossNkhNM2a2LbyBxZzamoZKN?=
 =?us-ascii?Q?U8r5PBjcAGxboAwFeY2pbHZwZ6segjDLUwRbYx1yW4iHCxG0UToSU34ny3QA?=
 =?us-ascii?Q?KbmTYRha3dbR8VrFNpqQI24q2s5dHZXtgFV7bxgbiCMkHUydCfVL6GzokYM4?=
 =?us-ascii?Q?6eHx7m9su347cJo8q7g=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144BAC5BD8E25D820D1D0BDF7C49BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdc73ad-e342-4b3b-387e-08dafa648e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 21:31:41.2086 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tc6zBGKQGNt34EW+KzHtB1Gr7ZBdIYL0gEPFP9rmDYv8J01AaY2v3TcUN1jjaDkX7iTElyZ+tTRTEMcX5PoPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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

--_000_BL1PR12MB5144BAC5BD8E25D820D1D0BDF7C49BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Mario Li=
monciello <mario.limonciello@amd.com>
Sent: Thursday, January 19, 2023 4:15 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
Subject: [PATCH] Documentation: gpu: Fix number of columns in APU IP versio=
ns table

A new column was added for MP0 version, but the table is imported
into an RST file and that needs to be accounted for.

Fixes: 393c5b8fa8d85 ("Documentation/gpu: Add MP0 version to apu-asic-info-=
table")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/driver-misc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/a=
mdgpu/driver-misc.rst
index 1800543d45f74..be131e963d87c 100644
--- a/Documentation/gpu/amdgpu/driver-misc.rst
+++ b/Documentation/gpu/amdgpu/driver-misc.rst
@@ -37,7 +37,7 @@ Accelerated Processing Units (APU) Info

 .. csv-table::
    :header-rows: 1
-   :widths: 3, 2, 2, 1, 1, 1
+   :widths: 3, 2, 2, 1, 1, 1, 1
    :file: ./apu-asic-info-table.csv

 Discrete GPU Info
--
2.25.1


--_000_BL1PR12MB5144BAC5BD8E25D820D1D0BDF7C49BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof"><span style=3D"font-family: Calibri, Arial, H=
elvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); background-colo=
r: rgb(255, 255, 255);" class=3D"elementToProof">Reviewed-by Alex Deucher &=
lt;alexander.deucher@amd.com&gt;<br>
</span></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Mario Limonciello &lt;mario.l=
imonciello@amd.com&gt;<br>
<b>Sent:</b> Thursday, January 19, 2023 4:15 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;<br>
<b>Subject:</b> [PATCH] Documentation: gpu: Fix number of columns in APU IP=
 versions table</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">A new column was added for MP0 version, but the ta=
ble is imported<br>
into an RST file and that needs to be accounted for.<br>
<br>
Fixes: 393c5b8fa8d85 (&quot;Documentation/gpu: Add MP0 version to apu-asic-=
info-table&quot;)<br>
Signed-off-by: Mario Limonciello &lt;mario.limonciello@amd.com&gt;<br>
---<br>
&nbsp;Documentation/gpu/amdgpu/driver-misc.rst | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/a=
mdgpu/driver-misc.rst<br>
index 1800543d45f74..be131e963d87c 100644<br>
--- a/Documentation/gpu/amdgpu/driver-misc.rst<br>
+++ b/Documentation/gpu/amdgpu/driver-misc.rst<br>
@@ -37,7 +37,7 @@ Accelerated Processing Units (APU) Info<br>
&nbsp;<br>
&nbsp;.. csv-table::<br>
&nbsp;&nbsp;&nbsp; :header-rows: 1<br>
-&nbsp;&nbsp; :widths: 3, 2, 2, 1, 1, 1<br>
+&nbsp;&nbsp; :widths: 3, 2, 2, 1, 1, 1, 1<br>
&nbsp;&nbsp;&nbsp; :file: ./apu-asic-info-table.csv<br>
&nbsp;<br>
&nbsp;Discrete GPU Info<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144BAC5BD8E25D820D1D0BDF7C49BL1PR12MB5144namp_--
