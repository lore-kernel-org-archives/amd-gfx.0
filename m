Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E451C433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2961C61414
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 14:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2961C61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C2BF6E1F8;
	Fri,  7 May 2021 14:45:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3756E1F8
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 May 2021 14:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+p5D8q3X1urpCaqLgodlI92RcwMo9SBkGUQvXkaNdPVjJGwsrMZwtJpEBduHzmKyl1czhva7eqaWXTfXZxCSy+tLfL5pe8w4BfCI9DmmosAdkklvl2aDkAUUQGAS8u4PrbY7xKWM5gsjARJvsT/k/LTGbFuDNFNg4apjNySJwSZWHnTDZOgDjEb+t+5HMMkcFk64MrxigtLV9PKCvftMUqmaH+9gte5o6/5B2qzHyb7S9hIy8K5C+x9+PQISMvrxWFbHsrF51b3DjIrAa+FfA103kx4RnKoVV7UzylzPEoGIboCsQWkykPCwhPKNaC4pvO+jknKdITnMPblmW9olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g4Iqfn1QJ4OsM6DlzYk3/YnFXJ+fL3y2BxhXsCAhu0=;
 b=XzkNfgIMLi8s6FJ0xkCCMgloJgcGWurZu9gYj290lgr8iZY/0PjemJFqEos9YZPPoCvxZHny/kTn6AKXxmqQHsjOI6G9T3eg+ctjEumEFvGJ5wRxr264tkEIWD1yGt+1zTZJVt83FsnRSQAqQIxl/VJpC9t8ZLpSaHCTPd6wnMioggUSbDxg5EDgqz7KH+d1ma6K0IBRMtXRnicGdYkxxOGhSiBqBtOwH/kQrXE/OJ/rcoKGiTAFju09PN6ZpfdpvOB5+qFOs3NbLbOeLoPAokSZRQwVWeDvCtWor3i4sSnEiOyC5biFcXWvqpVrnWwbuhI4Ek8MeTUj0OZHE0j6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g4Iqfn1QJ4OsM6DlzYk3/YnFXJ+fL3y2BxhXsCAhu0=;
 b=ODg5fePaNmsIHZ18XC0xvh7nrb5gmm9JIAoLt0RhQDKgzo5nP5akjHcVQN05YOMbahM2usig+4myXLasPtusH7U2931qv192X0ul/ovLrqcFowMroMmcZ24VtSYWXVZWJ27v2TJXAJ8KGMfNJ5Xl1I6CPFl8xo9y7vDtmtB5aVk=
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 (2603:10b6:910:1b::19) by CY4PR1201MB0263.namprd12.prod.outlook.com
 (2603:10b6:910:18::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 7 May
 2021 14:45:19 +0000
Received: from CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f]) by CY4PR1201MB0072.namprd12.prod.outlook.com
 ([fe80::8452:74ae:9106:ed4f%3]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 14:45:19 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/4] Normalize redundant variables
Thread-Topic: [PATCH 0/4] Normalize redundant variables
Thread-Index: AQHXQS8zVb/TamVYuUWL6WBv9JbeKKrYHLL1
Date: Fri, 7 May 2021 14:45:19 +0000
Message-ID: <CY4PR1201MB0072805C615B966DA2D1926FFB579@CY4PR1201MB0072.namprd12.prod.outlook.com>
References: <20210504214756.3816-1-luben.tuikov@amd.com>
In-Reply-To: <20210504214756.3816-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-07T14:45:18.140Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [114.88.229.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ead14d16-7ced-4b2d-e28f-08d91166bc5f
x-ms-traffictypediagnostic: CY4PR1201MB0263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0263F207B10C95285D2F71BBFB579@CY4PR1201MB0263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ykgGgwa2hdkL88XzzucB+Crn/w3V8dzLpMCZUb6pXrEwlpUWMeAZv+VqEFk+xzb7thCR85NcJmZujlyacjDJ2o3KKqYdb375TB8vK6Cp6D/Im2bMk3QLEsoJ9rt0tsIwLxDIw0lbdQy7e1idbT8ZMbB72v7yE9Pwb7qW3fpqc1TinCYrUC5WkjaqYfP9ZIbQPTVLDH4Y3pQkPK2y6OsgtiCKRTavRgZfgJwYHtFPfKAQ+rUEWvPY0qRldE26sMXeH75/RHXyyqg3nXmdWcO2cfnFRgG1x76GFhay33dFO52zS6juXXhei2uJ+4Fm3GgqyQ2eeeMo77YPKGf0lobk/4Gd2o6leDiEpX2mllTpgb7UKq3tudwTyVfJYH9ys588dgzkONHpLoTZ1xi/eiZiMJIJc1rSZgEEuOgvbwtEk0r4auA7eBtB7+FEX+RT71Innhcc6A5bHB1QYJyLyTM7q8v3FAmGX81BR42JjUMbj1l96lhOgzLvzMM+n0W6ubLhGjbQktlnM2ZnUD1ydAANwPoS8nQek7hpyHmYzAWpfwkOvCkR66yC7MbDANeadVm9YLg2bHuLqMmedfm50HOOkwlEv8xjVT4H3cha4arMjdw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(66556008)(66446008)(64756008)(66476007)(66946007)(110136005)(54906003)(38100700002)(122000001)(5660300002)(316002)(52536014)(55016002)(76116006)(91956017)(9686003)(83380400001)(478600001)(33656002)(2906002)(26005)(186003)(53546011)(7696005)(86362001)(19627405001)(71200400001)(6506007)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?L4eUXRL/XMT9p3VL+wEuL39cvTYtNNE6t7fBa/syM/L6d3BYYviu++aou6?=
 =?iso-8859-1?Q?WdbR2QAdCyxOFimt7XgyB3jq6pnIzQSpHIRtqKdYrssA6fa9udhimScrrz?=
 =?iso-8859-1?Q?PV93CLprgwN53kKBWjJeREFrIQbNvYwNfOpNE95Xq3qDnryXthV+9ihf/T?=
 =?iso-8859-1?Q?UeRVsFhr6Y2079AZJ7jP0xO0cKt74YPIE/3do8pcTQAkZ2kptDFiHziACQ?=
 =?iso-8859-1?Q?F5dqbtmb4vQy4WYVypq/PUQIoOgpHq1yJrwE8iuwkElRd3tYxrQ5xRwXHJ?=
 =?iso-8859-1?Q?VNlwUJIVS3ciP3YAeB8Rr6KfXikY3wuXwmz+l+WdgpvsHQHMWrl6X3KJwk?=
 =?iso-8859-1?Q?QM3yycKWa+Tl0z0ngNqf/jbfAGEw3n3+w78wcxsxNI5kQ83JZXzAQm8Rvi?=
 =?iso-8859-1?Q?pQm8x7el9e6AcnmQqDclvfXmMGmzVN3ISN9i4F9zqq8ad3dkrLAnV35INn?=
 =?iso-8859-1?Q?NmWRc2z1CYYIV8JYIpwL6m3EBi0yGD8JyJybIJ8FqBB37/XtSANcaIKJmp?=
 =?iso-8859-1?Q?x2SBR3UCCmJlXmD1ebXq/v/Co7aCYbUQIiMvLHk+XOV/V8rXS9QcRv5WmL?=
 =?iso-8859-1?Q?Hgln1CXiftDvn+1+Js4S6z39EHbuB+pZoftoXTgfJcVYzfOMiHqdDPH4WN?=
 =?iso-8859-1?Q?9X/E700TeinMFNUoVlO1bdu0GvqpL5ITtkWneXgCrqF7AyvFedA3u4k0SW?=
 =?iso-8859-1?Q?/qZ6xpmyi8ZNPVRgYvmrA/W6KfaVHp3JEct2i95yQCNCOw+8dErIGEOPKT?=
 =?iso-8859-1?Q?sL1kvSyJRQ8P9nBDrp2r8YloHMc02DAs55Sx7Rg6tdEWEvAmoISXjj0ojV?=
 =?iso-8859-1?Q?ShtmxzZzGhn6cRnDLZ88PPto85n5B4DGmNW1L0IDvN8BYOsIoERMY25XsP?=
 =?iso-8859-1?Q?HbnEHQZlMCMF+1nGCRREsTgVy4vZoQlt3VBvnW0STymPyiKTA4OJwv9H6h?=
 =?iso-8859-1?Q?CNSM44ijZkPiBdcQWQHMbxayiBz1hrpqeAuKEL65v7imZ7MgZ7bBa60/yD?=
 =?iso-8859-1?Q?EwIWhXUCxgv+2nwEhlEK3isjWP4LhWl+WTi1kV3FcnMRUTOLN1aj0/j1J2?=
 =?iso-8859-1?Q?w+SABTPA2TzEO7zP93wfrdhpzE3RpQOtq6oJ6DCTEY++72+W8xzfkVvxuW?=
 =?iso-8859-1?Q?M7cjeVqOeQF8W2AHhVenJ38+Z36l0n0oJUTU4bIX9ys+/rDPXnRnTxqrbr?=
 =?iso-8859-1?Q?uFtWFqbNXg/sR3+jU242efN4e//vub5g3yACSK9qrC6IcNla7eqvM4UU1k?=
 =?iso-8859-1?Q?LBpVJCD7os++O/Smv5KnFAe+mjcNvDdqMDt1Ppyzw8uc8MAWU0+5iMpksT?=
 =?iso-8859-1?Q?vuHqwDaw7ecgP1Df9rSvU72ZsOg4EtMcXhFUJ2fssQLebTA=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ead14d16-7ced-4b2d-e28f-08d91166bc5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 14:45:19.2693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DhnK+YlyqsUzxi2sS+1XZ8WJXuZb5q3CUzg6etucuu2qZFYKtqeMizHNNwJdvt4mG07WRfag69btrjB+dvFi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0263
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1009374693=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1009374693==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB0072805C615B966DA2D1926FFB579CY4PR1201MB0072_"

--_000_CY4PR1201MB0072805C615B966DA2D1926FFB579CY4PR1201MB0072_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: John Clements <John.Clements@amd.com>

________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, May 5, 2021 5:47 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deu=
cher@amd.com>; Clements, John <John.Clements@amd.com>; Zhang, Hawking <Hawk=
ing.Zhang@amd.com>
Subject: [PATCH 0/4] Normalize redundant variables

Classic normalization of a redundant variable.
There is no need to have two variables representing
the same quantity. Move up to the structure which
represents the object which determines their values.
Rename to a consistent name, and export to debugfs
for debugging.

Luben Tuikov (4):
  drm/amdgpu: Remove redundant ras->supported
  drm/amdgpu: Move up ras_hw_supported
  drm/amdgpu: Rename to ras_*_enabled
  drm/amdgpu: Export ras_*_enabled to debugfs

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 91 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  5 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  6 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_baco.c  |  2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  3 +-
 11 files changed, 63 insertions(+), 66 deletions(-)

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>

--
2.31.0.97.g1424303384


--_000_CY4PR1201MB0072805C615B966DA2D1926FFB579CY4PR1201MB0072_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<font size=3D"2"><span style=3D"font-size:11pt">Series is:<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: John Clements =
&lt;John.Clements@amd.com&gt;</span></font><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;L=
uben.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, May 5, 2021 5:47 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; Deucher, Alexander &=
lt;Alexander.Deucher@amd.com&gt;; Clements, John &lt;John.Clements@amd.com&=
gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/4] Normalize redundant variables</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Classic normalization of a redundant variable.<br>
There is no need to have two variables representing<br>
the same quantity. Move up to the structure which<br>
represents the object which determines their values.<br>
Rename to a consistent name, and export to debugfs<br>
for debugging.<br>
<br>
Luben Tuikov (4):<br>
&nbsp; drm/amdgpu: Remove redundant ras-&gt;supported<br>
&nbsp; drm/amdgpu: Move up ras_hw_supported<br>
&nbsp; drm/amdgpu: Rename to ras_*_enabled<br>
&nbsp; drm/amdgpu: Export ras_*_enabled to debugfs<br>
<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; |&nbsp; =
6 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 91 +++++++++----------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 5 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 7 +-<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 6 +-<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega20_baco.c&nbsp; |&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c&nbsp;&nbsp;&nbsp; |&nbsp; =
3 +-<br>
&nbsp;11 files changed, 63 insertions(+), 66 deletions(-)<br>
<br>
Cc: Alexander Deucher &lt;Alexander.Deucher@amd.com&gt;<br>
Cc: John Clements &lt;john.clements@amd.com&gt;<br>
Cc: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
<br>
-- <br>
2.31.0.97.g1424303384<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB0072805C615B966DA2D1926FFB579CY4PR1201MB0072_--

--===============1009374693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1009374693==--
