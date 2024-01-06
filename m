Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BBAC3DA6E
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Jan 2024 00:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF1310E07A;
	Sat,  6 Jan 2024 00:43:43 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF6D10E07A
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Jan 2024 00:43:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu4Gd/qdGjKVT53QpeEZE9FPUedymuwSPJDrujLKEA4uKATfI6CSITdiaNCEUVTYTmhzoT45OBA1dGJva33f7i/Z/d/NN20DhGvLZnzMh2TQWJ0preEVumf95KpMssi9uO5Qzn+Sei0oqnwXgcHGbSwZLrXoe7rElDG+n07JVwfVNJSzTIw7ScmVC3gmqJjqeILcq3UAF99yOnwKbWEhBFNcPm6xUqEHagsUXBUFDGmpzKQMvfN1KGJvZGN2VWLsNiK9tzcm5A0B1y7IPLgZ5/2yF5Dq5WUfmf/VbD9rDSMWoKcYRD7uRdFzmBednaxkbujeonQfN1M0dL4GTK//gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdMuiQ3iKsHAMl4YLCSzc7LvHzPk3X1Np0tvXJPJLQ8=;
 b=MxQmcKnsBncGIauS+dAWP6Na6l7a45bpBnCtBarQBDu3OsNJ4UdOQOjYO+o+lhLoEToKxI3ubt1ZTonfR5DWnfeXdUMOTttmdyURA16+f4x5NqlFCZtzRMwvJjBXe0X+AA+lgWCfjePU2/2Sd5ewh//bJhE+9h9s8MJIMT5RqRHQUzhzXl7HQO3QJNsnBy7+W9LtNMxOrTCiIohPXd6fc1j2qJq0C/udEleUemHt2oGZycdT4OjFke8nSNq5O3PLoTrbb0DFBOaIG+NzEjrO7u33+7Dxe6/dSa9cCdUBeld8UHxkxr9AvEALAh4N0QygAcA2gtlP/VhJumcNg/0gng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdMuiQ3iKsHAMl4YLCSzc7LvHzPk3X1Np0tvXJPJLQ8=;
 b=MYbynR9amxnF4s8qo8cY4xyVViof2Q2CP2GBnZNtZyQeJoDuOwMEbs3JQF/WRGOGN6AMX6kNA0dusssZExQAx+kHUlnKB1PsaFOb4AAmbUAAX5FsEs4yAArFxpu1bWcWXNSJaF49CTO41FXZdOeV5FFgrpS230kDwzFp1smrIy0=
Received: from PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18)
 by PH7PR12MB5879.namprd12.prod.outlook.com (2603:10b6:510:1d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 00:43:36 +0000
Received: from PH7PR12MB7939.namprd12.prod.outlook.com
 ([fe80::f5ea:ce86:91e7:b987]) by PH7PR12MB7939.namprd12.prod.outlook.com
 ([fe80::f5ea:ce86:91e7:b987%3]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 00:43:35 +0000
From: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation
 failure on DCN 2.1"
Thread-Topic: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation
 failure on DCN 2.1"
Thread-Index: AQHaQDj+aQYc3FWOykeTJny5pe3RmbDL8h/P
Date: Sat, 6 Jan 2024 00:43:35 +0000
Message-ID: <PH7PR12MB793974E3D84089FD35D19E25E7652@PH7PR12MB7939.namprd12.prod.outlook.com>
References: <20240106004050.1506869-1-ivlipski@amd.com>
In-Reply-To: <20240106004050.1506869-1-ivlipski@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-Mentions: Rodrigo.Siqueira@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-06T00:43:35.417Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7939:EE_|PH7PR12MB5879:EE_
x-ms-office365-filtering-correlation-id: 5468f11c-63cc-4dab-2cce-08dc0e50843a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYyig3nVmhSaf0FhBGkhhiCMTWpdc3r5jfXAojvz33mymKLopLGeCjitnXuy741AXWLC0NT7BTNJIEgI95XY2PnVDIZ5OOo2oNOeFFx7ecJaKx3Ll3tYyBUxLpH5J//00Tj+Uqsu3zy2BAo3+pPgnQeCxP5b4gJXT6wX70AHh7UrZdefkVs8l+d8pUYIUucceq5k7+bMth5AjSht32M331u/KbKpW4sSLo+LEGCEghNVzZ6Zmp8Dm11iuzYruX8fDSVBe8G6IC2MwWPJS2f/gXp0BuMcIqXzUgvVFghYVFn96tImMjl3EPoJUa8m4SOTHjfY7Za/Qlkdcvt4rnJQFVtl7vtWk0lNvs3bKbZm5yeZT4iWDssAJUB3WaGm3S6UMql55g0J9IGJQEY9POFVpunHkdQvION35p7W+b4sovgJRr8/OUQ2j/1hITrc0rMt5JwL68VLQ0Ehh1NIOv6Wpoagy9As3t86TMh6jjrZCrgrBEsVbgO2FdLPTSRunVd/cmXgSiQZTkp6CHfLyoQU4j79YVH5yel5kz3TAqn8RnOuhlS2+9WTf9PVFUZ3Q4vL6I5aPn6BtzFKQmL4aEb8G2nDue+Fs/AXt31uMQ9oDfSbsO+BhzsOMe/qrsBs84ad
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(38100700002)(122000001)(5660300002)(38070700009)(86362001)(41300700001)(316002)(54906003)(8676002)(8936002)(9686003)(55016003)(76116006)(66946007)(66556008)(91956017)(66446008)(66476007)(64756008)(6916009)(26005)(478600001)(7696005)(83380400001)(6506007)(19627405001)(71200400001)(33656002)(53546011)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LP1CQQly0Gx6r21qw4oOH2J/mcVYxV+lx69NlE8KXKjfd+FSM90UJtqtFNB7?=
 =?us-ascii?Q?fRQxniJeXkUGSZh/iDf5IMuICQjrd4umS4wkEQnzXxdD+bgAQ01HSRYbNN2U?=
 =?us-ascii?Q?TQEY1tdCQG6KBVAxFNJlDtfLnTrk2QhkfvZNa9/tt8pbTEugAqsehuCa9I97?=
 =?us-ascii?Q?T+t+xPErqfdtl43NwLuLcinvaS3F8TnX1qoJRfv4EnIxuyc2KxMqTzihwyFT?=
 =?us-ascii?Q?9gCVcgeiORv60QH3MHqrlwpy8vDtN4pCrmNtozeUGzIycNS6hQ/c3Ku6jJ4+?=
 =?us-ascii?Q?E8uqdGgkYe2Z5zCON5YKToqimbkXZq+oX7m6zOPgqd87PFFZ76zHKWtblgge?=
 =?us-ascii?Q?ZVIvkzcWHsp2QhUyRE5Zl4GqQmUwCoQyeLNdGbp0yFkuLgXmj8sBJyMACO8w?=
 =?us-ascii?Q?/d1zFgr7LrsShYJtdnxJezDysRbFkKlBQazUQaP5Ze8MA+tVTnyS2PkmnUbe?=
 =?us-ascii?Q?BTdFgX/TqzAxD6oXyM3QNM7h8iX6aZ7Qj78QcbDljyTgCu3NoZbmbPCmOQzK?=
 =?us-ascii?Q?29saSpQVQwCzndg08zOvd8z0bLuOt+fbuv1LI8Myb0RrlwucN+dvB/GR1PrK?=
 =?us-ascii?Q?ZO0l1F3DL0cUnKYmh9xwaX4HZaZUh/lKW6pQHspenjET3lwMj71kFcHyVUqK?=
 =?us-ascii?Q?D+cvXHb165UmUwaaC1f3Zm40T/92Kv9ofQC+lcMtXdlTGdyYVUwkLYcdjPwy?=
 =?us-ascii?Q?UMYxMuPsPHeiWqVwzUET+0ETx1ADftSyInDCTs3/1fg6bCxIjUD4iNhTQD6U?=
 =?us-ascii?Q?FuqYEqfYADrmja03os+TxSTGSRjSBI6pytXXHqRBUZDrH+bu0+ReqgxjxDSg?=
 =?us-ascii?Q?FckVx+fW5xGb6obzWVlWLSx9ilup3BJ/dA+1Y8iPlSE53ik9mH6QEArGtVUn?=
 =?us-ascii?Q?S/xcLAiRsI4KloIq0lLdK2SIzipMsxmdAVpWbPI3HxeRZV/V/m6p0dZGgHsU?=
 =?us-ascii?Q?Tlf7/DOyKpGjrk82iATyRXGjFMt/KCIYP6xzo+ME4T3B/lU7m83S/RnMSzm3?=
 =?us-ascii?Q?8P5gyLJ98fmdPPoY8c00e3zu6u4fmo9l3BrCO/FMXNW9VTLXy/wpejodkFdt?=
 =?us-ascii?Q?M/+KcCNbJeL+NmSeTT7L529+hkExexvos62Do/CDavuPY+uukhgEYYEKk+tg?=
 =?us-ascii?Q?RbxsL5bt/uWznwo9kSvssMvndg6WFSyrgG/sFsIV599T1YM0evye4to0xl77?=
 =?us-ascii?Q?dzGoKdiul134KP7jIq5rEU6N/u7pLBvCnJN2NIS43GSBOKWjlpy0SqYM5tKC?=
 =?us-ascii?Q?p7druE3lNbdXOPuGlAFbD9xT56IDihK9YvfTD+KJacDzbQVx3cP9Pjd9zSxX?=
 =?us-ascii?Q?nq4s8cNTeOxL87j3AeWT3h2IbgH0Y6hCUbiBUNM6oAjVr3QkgJBL9sRj2Cu+?=
 =?us-ascii?Q?UnV93sNqE3XXMvWgMMIGXdJDjpy1WxWLlHeogbR8/9gtoIreIlIralHx+E2V?=
 =?us-ascii?Q?8XDGAsGDsqd9X/mJjqe1+sjOWfFE0Pmg1+OJWl0coloMG4kdQ95+nUgG/kFx?=
 =?us-ascii?Q?CgHcrNisfhLPCMAO4hei2mtuOqiKsxDp6D5uxqYvL0/wnfUFw6gaJDG5hvxC?=
 =?us-ascii?Q?p2NeQFXW4KEsRrJTpdU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB793974E3D84089FD35D19E25E7652PH7PR12MB7939namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5468f11c-63cc-4dab-2cce-08dc0e50843a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2024 00:43:35.7988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+yXrqgORpFtdMO6eYr9Ef4N+93jM4xIMFYZcmXeWTJhshT/pXNwsEYKgPdNcaIsO9qDKz/gKZw/VWyIf99K2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5879
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Melissa Wen <mwen@igalia.com>, "Choi, Nicholas" <Nicholas.Choi@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB793974E3D84089FD35D19E25E7652PH7PR12MB7939namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

@Siqueira, Rodrigo<mailto:Rodrigo.Siqueira@amd.com>
________________________________
From: LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Sent: January 5, 2024 7:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: rodrigo.siquiera@amd.com <rodrigo.siquiera@amd.com>; Choi, Nicholas <Ni=
cholas.Choi@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Koeni=
g, Christian <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@am=
d.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>; Melissa Wen <mwen@igalia.com>; =
Mahfooz, Hamza <Hamza.Mahfooz@amd.com>
Subject: [PATCH 1/1] Revert "drm/amd/display: fix bandwidth validation fail=
ure on DCN 2.1"

From: Ivan Lipski <ivlipski@amd.com>

This commit causes dmesg-warn on several IGT tests on DCN 3.1.6:
*ERROR* link_enc_cfg_validate: Invalid link encoder assignments - 0x1c

Affected IGT tests include:
amdgpu/[amd_assr|amd_plane|amd_hotplug]
kms_atomic
kms_color
kms_flip
kms_properties
kms_universal_plane

and some other tests

This reverts commit b7ebd39e2922f642c7ee63ade4a4a5a1ef675d84.

Cc: Melissa Wen <mwen@igalia.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>

Signed-off-by: Ivan Lipski <ivlipski@amd.com>

---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d77fc79f3542..111c6f51f0ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10752,7 +10752,7 @@ static int amdgpu_dm_atomic_check(struct drm_device=
 *dev,
                         DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed=
\n");
                         goto fail;
                 }
-               status =3D dc_validate_global_state(dc, dm_state->context, =
false);
+               status =3D dc_validate_global_state(dc, dm_state->context, =
true);
                 if (status !=3D DC_OK) {
                         DRM_DEBUG_DRIVER("DC global validation failure: %s=
 (%d)",
                                        dc_status_to_str(status), status);
--
2.34.1


--_000_PH7PR12MB793974E3D84089FD35D19E25E7652PH7PR12MB7939namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<a id=3D"OWAAM243567" class=3D"tWKOu mention ms-bgc-nlr ms-fcl-b" href=3D"m=
ailto:Rodrigo.Siqueira@amd.com">@Siqueira, Rodrigo</a></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> LIPSKI, IVAN &lt;IVAN=
.LIPSKI@amd.com&gt;<br>
<b>Sent:</b> January 5, 2024 7:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> rodrigo.siquiera@amd.com &lt;rodrigo.siquiera@amd.com&gt;; Choi,=
 Nicholas &lt;Nicholas.Choi@amd.com&gt;; Deucher, Alexander &lt;Alexander.D=
eucher@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.com&gt;; Wen=
tland, Harry &lt;Harry.Wentland@amd.com&gt;; LIPSKI, IVAN &lt;IVAN.LIPSKI@a=
md.com&gt;;
 Melissa Wen &lt;mwen@igalia.com&gt;; Mahfooz, Hamza &lt;Hamza.Mahfooz@amd.=
com&gt;<br>
<b>Subject:</b> [PATCH 1/1] Revert &quot;drm/amd/display: fix bandwidth val=
idation failure on DCN 2.1&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
<br>
This commit causes dmesg-warn on several IGT tests on DCN 3.1.6:<br>
*ERROR* link_enc_cfg_validate: Invalid link encoder assignments - 0x1c<br>
<br>
Affected IGT tests include:<br>
amdgpu/[amd_assr|amd_plane|amd_hotplug]<br>
kms_atomic<br>
kms_color<br>
kms_flip<br>
kms_properties<br>
kms_universal_plane<br>
<br>
and some other tests<br>
<br>
This reverts commit b7ebd39e2922f642c7ee63ade4a4a5a1ef675d84.<br>
<br>
Cc: Melissa Wen &lt;mwen@igalia.com&gt;<br>
Cc: Hamza Mahfooz &lt;hamza.mahfooz@amd.com&gt;<br>
<br>
Signed-off-by: Ivan Lipski &lt;ivlipski@amd.com&gt;<br>
<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index d77fc79f3542..111c6f51f0ae 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -10752,7 +10752,7 @@ static int amdgpu_dm_atomic_check(struct drm_device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_D=
EBUG_DRIVER(&quot;drm_dp_mst_atomic_check() failed\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D dc_validate_global_state(dc, dm_state-&gt;context, fa=
lse);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; status =3D dc_validate_global_state(dc, dm_state-&gt;context, tr=
ue);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (status !=3D DC_OK) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_D=
EBUG_DRIVER(&quot;DC global validation failure: %s (%d)&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dc_status_to_str(status), status);<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_PH7PR12MB793974E3D84089FD35D19E25E7652PH7PR12MB7939namp_--
