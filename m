Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF2BEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 18:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9210310E0C6;
	Thu, 15 Jun 2023 18:37:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC3810E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 18:36:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVLazr8sgSO8PuvMOWap1h6lyKMEuOIYWHDkjOfKrpLm4UOQgOZqbKTHDZKWO3vSOgdEjiy2mxYry2xzWqqKhJGK5ccVtfKejiR3fQ6QvffWnBaZ3+7d9e/TwDZ7jTSK3kpccihX7E70ofYQpf77XAYNPodb5fNMBbddeKGju1HSgQMqtptgYbcYr8+AmXdhSmLA1+F9enaQB0TFg6H8jDa8ZOl4yBxrF0I7NAKd1UMdo2gpS+vhKp5fkrf5uoIktL6Aa+qVYrFlzk/dWwYzk+mtvY184UceA0T4qWRbssEkN5XcPERKSI7RZbXkP4cBnhAcBoHGtxWUZbfquE69dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHlqvPSyxz83bDpUqP1auG9YP2LJtWnal+UgKWp2SBw=;
 b=i85VGHeqF9pxtkyUFAmN8av1OKUoqGftMT+jsAufLc1ebq/0g1dibZXI8ydiBqKoxoQGZC+fVLbIJcTQbTRFd2ZxESx0JIA66T/pyGSC30tTEPvSr34ucXW49P7Wm7cyGiqsNIEBXbAexgJqil76LF98dBcD/N9k6KvJL5pQocLyvHS1e7X7XvcAjxr8c5Z9X44Y1cBdmEE4o+wCAZDBK4xYb5tSE2j8NHJ4mNdDlv7g2QJVhxs+MtVsnpPMSTmk08fkFmLtEhoT6PDm9oE6qlMCI+ochibCAi0g7YrX64Ok8vdCAQj4snleKmcih6ot9rUgfRNsTElaXwScjIWKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHlqvPSyxz83bDpUqP1auG9YP2LJtWnal+UgKWp2SBw=;
 b=jCfusdmu8kbMzM9slrNpGK1YUswXkjebVUzPFSQGs38+cKNvO+99swcMOWrJOSNEeffGHCowUBBBU5t5UMRMkf7E6nx14+m6II6iSHszCz7WLPJHydOCxtoaMxYllsxqKVk8NsxpQa7zPvSVEFUn3PaUNEtSqa/jjpVPxqfv+Rs=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 18:36:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::c549:4aeb:a02f:56b2%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 18:36:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Skip TMR for MP0_HWIP 13.0.6
Thread-Topic: [PATCH 1/2] drm/amdgpu: Skip TMR for MP0_HWIP 13.0.6
Thread-Index: AQHZn7HBejRbXOmzgkyrNB9Sg7D6Xq+MMTom
Date: Thu, 15 Jun 2023 18:36:56 +0000
Message-ID: <BL1PR12MB514433BD31DFC61973CF82B2F75BA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230615174920.25499-1-Zhigang.Luo@amd.com>
In-Reply-To: <20230615174920.25499-1-Zhigang.Luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-15T18:36:55.528Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CY8PR12MB7196:EE_
x-ms-office365-filtering-correlation-id: a5ce1637-925b-482e-ec12-08db6dcf7f46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwpcK4fkx1/udL05f9JDCmasLqp/mf/TvkppBxcez9jh7UZtCH3fPyZslbtOpqU7pBiSVcUBUOorRjQaGZ+mj1gaP4BqP+wLhwcHvpA5LTWTV5h1aBS1bBHQ2qz7XR8/h84uHn6IpO1nNLHVVobhXBrkRFgLqpr29hnXKYt/eqmDx6hNufze/+cfwZwq9thvI7AlCzkejb7c4zLGi4Uc7+opmYx7pqufwtkQZ4oNRhOb8J7Ui7V0TUVg5DeMXBAZ4VsHg2jCuVM94dlF0kT92//I/EO7+zqWia4RJWb9h3zHWMVbZMz4QK7QrppVLavjSi3/psuJEQObx2ss3oCYrXTIVZVPIOtyF8MQO/JUUxb5jwTewZu1SpZIE9ByNK1KGqU51jCEEXLrr2U1kzRq5a2txr9a4akorNJLHER/yJuQqCV1piX3HWmxe5Nz21LCygvdIRWJt1yRAamUH3p1Ax7n6BwojXxGxUssN38CpVTkfhFNnQkDEwlYHm4lbvsl1yAYlyL889eGwYbcnrY0lvRRIh7EGAi9ukRAzFpKL9GNtZ2ffUTtl1kk682nF07YJoIOJazYoDF4IDwzt5i4miBnQImY9LQyFnpxTKPkFRlsYwp5oIh6sOFLBzzvFnHz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(86362001)(7696005)(316002)(8676002)(41300700001)(26005)(55016003)(5660300002)(38100700002)(9686003)(53546011)(6506007)(52536014)(122000001)(33656002)(8936002)(38070700005)(71200400001)(64756008)(66556008)(76116006)(66946007)(478600001)(186003)(19627405001)(2906002)(66476007)(66446008)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x+LDBiOV4/r+myDXkIYmimma1yNf66ElZZqxRNrc7OPubYtZEUEg243kZ4hK?=
 =?us-ascii?Q?ZZoTSRxIMJLRmSXNvXjBimvrd2RwrnGqDfymAEL7rVcDj4zqKqg2jQk7x1w8?=
 =?us-ascii?Q?hrn2u7p1lKddVZneG5Bp9UTdr4ZzHcBzcdHZf6jvq82NZzTFgTvUmxLA/DOn?=
 =?us-ascii?Q?p9TIyt/bOMWS/o2iqXQ1mJWEx8H/zgb0hhMhp1kO6P8SA+hcxKKQTXwfDrCd?=
 =?us-ascii?Q?6DJ1lnmMIkpb0EJZWxVZM/Sw2nZjb4FLJeGZT//wjgQlq/BCJNpV7uLkXekE?=
 =?us-ascii?Q?yh+aw7FCaIEExUwVZLmZpFcghkN/V6aKKlVvZYxvk1KBnfa6rGsQ+x45/vJi?=
 =?us-ascii?Q?QVIIicmeRWUIzupTdnHQeayrIa7ue8ptMo3PwmzFLVvupSm+TCJj4nORxXJd?=
 =?us-ascii?Q?9TFlTPxF/ZJajKRdW8LPRVt+/6iXoVT4Z+/bYgbs1hpxLWChYf1bFQWxfuhL?=
 =?us-ascii?Q?MnWrXSbY0wEv8AB5viGtncnT3P2nIYhoLz/W3KIDswPVoMeCJVhWCJzz0raA?=
 =?us-ascii?Q?n3nlkPn6bbM7YCR6JGI5AF8RMiL34m9qKAbdNChpI5lPzCV1VRrfcQq/vgKg?=
 =?us-ascii?Q?wOUMNuYtZzHGEdz/mnljizo0emxWrsAqK6X0fRB+hE/1tV8O63JaIiCZnwJ9?=
 =?us-ascii?Q?j9T5UJP9MPSHoa1DDYJflcdCNv1G3N4RliIV/4Ao8p/zDSiD/A15Wsgtnndr?=
 =?us-ascii?Q?wZ0WgULJCL1XCx20aMx0a5GBUlk1tNciy5Wb8NuqLpdhunoZaGx1dbW/3wGR?=
 =?us-ascii?Q?av8b6gvfOY/iT84XRldw3XSMRjGzhQNRKsBkKse4XNtVwRF7Kve1OvMKsXHW?=
 =?us-ascii?Q?oUVQ5rAxI5yc97Kz7zR4HRXg/0sCHsuP1W+bqGQUXbudVDgWqd2rznuo7Z66?=
 =?us-ascii?Q?s719nAHWSHx4PtQr0RIRs85HKpWQ7fBTUn4QQAGBdioF2W1mSDVPj0fpSfa+?=
 =?us-ascii?Q?jDJMkoKh7aLQJ/Yz4d4N6ulHMZ4KDgDpGVc+SbphbidYFUY3E4YJ06X+Ceeg?=
 =?us-ascii?Q?5prclAZDLm+iboKZGujdImtdjZ4SkDrKfDBE7EQy4Efj4CsyMO2rQMCiPmhK?=
 =?us-ascii?Q?xJn1+Ex66YolDQrS3MfGtr7FlV197kfxEPHPJaoFSXUWsQ5tVL81u61L8Vc0?=
 =?us-ascii?Q?ytf8TbWwBamPZ7HLUMYSRyJ6oI/FDejTihalTUffftbGAeTWnZ2GZO0YgV0L?=
 =?us-ascii?Q?LgynOCGgI7YVtFAGpvMzvQiogGNM6WP56gCp5yrQFzC7BGO4E29+YkAiDLej?=
 =?us-ascii?Q?l/LyeiWtu7jSWytgAT50VLl38Szi+YTJNLLstTFN/8OLQ+byq/EKEVOaqll/?=
 =?us-ascii?Q?GszLSj4MT/+7lEDVoWzhV3tg/ATiIPA1qYubp6D3CEGs0gNngtOUfMT4ur91?=
 =?us-ascii?Q?VzlNUkctUPon3ICZmIpHut3jqUbwiyiolArx51kV6WiLrT4BO9abq5ohADx+?=
 =?us-ascii?Q?zojWU2AsQsfoANTlO80+1LFzNYHGk3rB/9ujJgBiLz3Dus7y5FbNa84ecmzh?=
 =?us-ascii?Q?vViXvdKrb31O9OvB6DTpq5VR6a+977Kjrd5FXHAvkVzxMfzNs5LUKU5uielW?=
 =?us-ascii?Q?7xtl2elswKH8TCjTyOI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514433BD31DFC61973CF82B2F75BABL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ce1637-925b-482e-ec12-08db6dcf7f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 18:36:56.4022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c76kWWBaoyLrW1npzHqG+c7FcLAfjKmTIeWmjRBGSqN2kLz622zhTTifsFhRdaZm04Nv8PsKdA0dBzXSwir58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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

--_000_BL1PR12MB514433BD31DFC61973CF82B2F75BABL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Luo, Zhigang <Zhigang.Luo@amd.com>
Sent: Thursday, June 15, 2023 1:49 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Luo, Zhigang <Zhigang.L=
uo@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Skip TMR for MP0_HWIP 13.0.6

For SRIOV VF, no TMR needed.

Signed-off-by: Zhigang Luo <Zhigang.Luo@amd.com>
Change-Id: If9556cf60dfcbd95e102b1387cf233e902d9490e
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index e15c27e05564..ac9b57231589 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -839,6 +839,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
         case IP_VERSION(11, 0, 9):
         case IP_VERSION(11, 0, 7):
         case IP_VERSION(13, 0, 2):
+       case IP_VERSION(13, 0, 6):
         case IP_VERSION(13, 0, 10):
                 return true;
         default:
--
2.25.1


--_000_BL1PR12MB514433BD31DFC61973CF82B2F75BABL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Luo, Zhigang &lt;Zhig=
ang.Luo@amd.com&gt;<br>
<b>Sent:</b> Thursday, June 15, 2023 1:49 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Luo, Zhiga=
ng &lt;Zhigang.Luo@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Skip TMR for MP0_HWIP 13.0.6</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For SRIOV VF, no TMR needed.<br>
<br>
Signed-off-by: Zhigang Luo &lt;Zhigang.Luo@amd.com&gt;<br>
Change-Id: If9556cf60dfcbd95e102b1387cf233e902d9490e<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index e15c27e05564..ac9b57231589 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -839,6 +839,7 @@ static bool psp_skip_tmr(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 9):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(11, 0, 7):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 6):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 10)=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return true;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514433BD31DFC61973CF82B2F75BABL1PR12MB5144namp_--
