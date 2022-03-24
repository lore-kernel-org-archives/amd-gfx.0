Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF21BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Mar 2022 20:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B27F10E301;
	Thu, 24 Mar 2022 20:24:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDCB10E301
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Mar 2022 20:23:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6EM9yNU1JQYPrl7gIjMI4J5nZu/cG+92mLZHhjrX4ZczPMCTW8Z7UYfuvGUV+TWIKnKeTXWL74KuKkIonpqcOkODFfKX3Vnl9vjMXXSLyNRd7AlveO1ZmqSk/Zf/GUqMHRlQgBWkjjViXi9ho1U977RWCFbyMZx+YVNwrZ0oyqbVn2QXD10Zuf+uT/wgThXzKfNgl2BEi3DSyOWl7IDbrPwHHACPo8wj4F2OB7Yn915//4IbiNJ4jHW/eA27dU3zCCGaYU/iHeEjtO08THBg1e0GPZd30H3eK8oUXzT35iZr4zm8Pn7I4A69bpv6uOaanMTDAoccAL2loZiZDcOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rz0bK8mbE6iJ7gE5aWhHw3uzIvxgdaks2ff8FTEpLY=;
 b=oGY8flYYdY+rSwsxzK03iZXor08EqXRmMr1MXhgWKUaANBz11trzVCkxJWDRdr+zK1rjUtotwB8x4hhnPlVPhONkQndvMOnVB4l+0vO1UcsmNLgkg1ME4wOtkigI59Dfg2VL1EwYpZxzOMZ8cQ8Zkv0tpZO78sKHemhttFFarcRCyFwkSJR8VZNyvEApoT1ZmtPefWaHjLOofla5sJrTXE8SW4R2OlQNJ1vR6EF6Otkhx1Ovzdcn5VBOa5+p2QH4RK/h9zvFeNPy8nR2YY6cNzC58JeD7VoTt5Qq4xlu6oU5Z9ViD5jBok3LRzkV5DoXDnTtC5eJgBTJq7ID8s7qbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rz0bK8mbE6iJ7gE5aWhHw3uzIvxgdaks2ff8FTEpLY=;
 b=KyDiTsex+4W4ATxeeX5J5gEnXOKMC5Bjt9sTGYCWZqmDdgXJ0LrESiRRFxXGvS8wdIoHAKEl87JRSVKrteT7jYL809Tpn5n8kQ++U6kxXUC8gc0RlnMuLxHjO04gNC5CYg9JurCodU+cUhlXCtkH+bC+Nf5BWZvDFlkxmymg0sw=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 20:23:56 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::2088:743b:1f62:140b]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::2088:743b:1f62:140b%3]) with mapi id 15.20.5081.022; Thu, 24 Mar 2022
 20:23:56 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution
 for vega10
Thread-Topic: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution
 for vega10
Thread-Index: AQHYNptaLMNnqfZCq02R5hstnbsBw6zPDLUK
Date: Thu, 24 Mar 2022 20:23:55 +0000
Message-ID: <CH0PR12MB5387ACB52F418D37B91EE6B8F0199@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20220313052839.5777-1-darren.powell@amd.com>
In-Reply-To: <20220313052839.5777-1-darren.powell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-24T20:23:55.593Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 04fa5bf8-3c94-5b23-31a7-c60c22328b3f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 957e71f8-7633-4319-35ff-08da0dd438a1
x-ms-traffictypediagnostic: BL0PR12MB5506:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5506AEDE77EB5A5E7195F2C6F0199@BL0PR12MB5506.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijBxYcsoem+CrFDl38ofGTpilIbBfCW0ehd9Q8GMI2bVqWWq9NdcKl1G/J9U91L3yiMeRnRYE4qqnJXMRlK99+4s0mQ3JyEAvzTm7AFEBmmGlU4fX+WRJvDiTBhsm8MoLWA+/J6WjjTwRCV9eRflyj64lhNdlx/Q2ELS8r868Mv98ho1m/J2w+0Dro8GZNFPiONc58/g/adpYQ/ilsKvx6GZw+1AwVl+0YGAta+RMtDoIz7xcowns/lz4kTn62IlR6Wk3RpIA5TS82Dia/6QKXQ3oH1zAPg3nD/UHmZIxyo8xibio+KECc0jPbuCLV1XRZi0JSlFx9tLXcjgRd6MhoiIcZTxNA3P3p2rnZOy1+mqqxJ3q3VaQWNJ/jZk53Dz2WwHjktvFKIY614X/EdGTayyFkTBbtT+1ro6z9g32wwpfShZqfxrT/A/8VeOR7S+XkBrBZ+JtE4NF22Du8rZPJmbYMdusQdGlqimgFP6shnP/Wh5vw6oacYUcHM2ttS2wCuLPK/K8UtMCDufUfE3ykorMBAYhTMyaIeCAOeaSWF66YSGEiWUDZvyJfiY49jAvF2KBehv8j0bCBAB8jIrlVkuqULQ8+StnvRqijvtzfzTRg3Bb6pS/jghgsAyV3UNKx7x5Y0OJtah/aPwqRu02zKs7UYIclfblKj1UjyzrbdDf/shb5TuEgCHX6omhUPMTFgFuu+1dM+E1jZEoPhT21qgiziQepXr9VqT+biZJ16iYWoSdcz2XCTB6efiSCOiTy1B33OY/619UDD63aLra826dTX/Ghpv/roCuWh8arw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(8676002)(52536014)(19627405001)(6916009)(8936002)(316002)(83380400001)(55016003)(66946007)(66476007)(66446008)(38070700005)(186003)(66556008)(64756008)(76116006)(4326008)(2906002)(122000001)(38100700002)(9686003)(508600001)(33656002)(966005)(5660300002)(86362001)(71200400001)(6506007)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?70LqHLaTjG1qlTw01w6aMXZS5qBcoXlth/WRDac393EyjOrwemkUBkXiO3pe?=
 =?us-ascii?Q?2A7eh2LmjI5EY0bUqzaf/Zql6slJhkGxFeMydSqagdwgrxvcXHji5b4HqXo8?=
 =?us-ascii?Q?9bDHKHCW/pHzJ+jDUsY8eNa3EwkqPMfIA8/CcMQobxr/DtVcsHF/+4MPWi0S?=
 =?us-ascii?Q?9Z0cs321x38hwyOeC4QkfYJ31yWxhi8c86C/e+ZNBxq0o71kpG0FCXgGmLHi?=
 =?us-ascii?Q?7NtdrUmMGcuenYQ83zSonXKB2o9lzl5sNYzyNvXrbLTyNAUi70EBLzGXHBim?=
 =?us-ascii?Q?hBxlyr/ODoUmHaaOnMc4NMOAU2YR1bEux5DyMWVwWSFgSo+moCOF/HSm6WX4?=
 =?us-ascii?Q?zOk2DfjbMaCZSpYHJo2QUXi0Wi0dhcCyQAApv4OH7G96c1ACfJYDxELiuffz?=
 =?us-ascii?Q?3CkFZ4HP7an66sIOzzWWySWadDFaoQAP5zO6ATgge7tD8e52PB3kEbxn4bRV?=
 =?us-ascii?Q?VhlipjyWeKzNv8XlHhu+bThSnr96ugAJENeib+PVkg/jatj3cht6Qhd1EF/c?=
 =?us-ascii?Q?K+EzTfAPD0dYxOSiUoxWwdTo+pWNTcBQAf/J3eoEa3AkPtx11+EJhz+L3VMj?=
 =?us-ascii?Q?iHnjN95+aAM+ljUOjeXenfMjaFQuWuM18rhoRpeHOdGezgJJx2uWGuBWmHYC?=
 =?us-ascii?Q?G8SwW0nxaWmqli2YT+/dmnBRhwBoq6ntXJrHp3X0iTnAW03VyhbI1hRSw8tq?=
 =?us-ascii?Q?8A5S5a/OEUXv51f5hS8oOt7c2ExPrAB8bvFJ6lyAvjCmHc5uhPIASxgPo18p?=
 =?us-ascii?Q?CuQ3nfTOYpo9gF9hoAUBsKHggGr+d46rZKGgcq6O1w7b8kF8qsM/r0ZNxhKf?=
 =?us-ascii?Q?D48m8UY80m/Uw+9VGyhq8MBK7C5Soe68W1z/yECmEIN8LL9airFeF05VzBNY?=
 =?us-ascii?Q?zfBFPkNwc4BYxo7svpbhZ93jIJZwS/WgMSunK7jdbLxNeSb7H7Mka+X1rPfa?=
 =?us-ascii?Q?6OkabdRX/DYUgmuCYX3e0ZLyHqkhc82aVx2rlgMS6VZBEJcrt625Sn0bR0zF?=
 =?us-ascii?Q?dGyPECYlLGTa1BNSQI0W3pYo8Opm+K0ST6JzsPgUl1E4MpO6t65r7/+ldUbF?=
 =?us-ascii?Q?LvkgA2l5S077Ywcn4rMCRn7IRMkv1cttzz3BUuPhwyEncdVWSHD4lt/3Auhs?=
 =?us-ascii?Q?mdnkVLnHW/9GzPyvJk+LWmCqm5aE5F9j4xplJlK5iu+bDd41iPFuw0tclU3e?=
 =?us-ascii?Q?AfPBKsbSTCX2kG/gaGmjC0uS8efyxjD7gWhcIq+OzxSsLRI2FDwylnFCzuh8?=
 =?us-ascii?Q?47ciO+UWJEFvD54pP4gnbQZUDLdcpE3Jey2/mvYqDmahuHhk3zN9hwtppqgl?=
 =?us-ascii?Q?oKnEfBJYr0vULlCzGvAyIz5hzOFJtykfUc/K1COjQJQWEGlv9J24pnvpSAIR?=
 =?us-ascii?Q?HGjYfiNXQBx6RmQVlnFtUtN1MoBAjJCTmSjmWhLLrz0S5nolwf1D2+1SnWtb?=
 =?us-ascii?Q?i6luM9weNVQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5387ACB52F418D37B91EE6B8F0199CH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957e71f8-7633-4319-35ff-08da0dd438a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 20:23:55.9413 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uZz6ZooQGMwshayzzV8kUlIBiEc3xQVjQKQ8DzniVmdbcaO1kQUUoaRZuhwAthidBjPwVv9TYj4Jl2rhYE0/gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5387ACB52F418D37B91EE6B8F0199CH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

 PING?
** https://lore.kernel.org/amd-gfx/20220313052839.5777-1-darren.powell@amd.=
com/T/#u
 [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution for vega1=
0
 2022-03-13  5:28 UTC  (3+ messages)
 ` [PATCH 1/2] amdgpu/pm: Add new hwmgr API function "emit_clock_levels"
 ` [PATCH 2/2] amdgpu/pm: Implement emit_clk_levels for vega10

 Thanks
 Darren
________________________________
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Sunday, March 13, 2022 12:28 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution f=
or vega10

=3D=3D Description =3D=3D
Scnprintf use within the kernel is not recommended, but simple sysfs_emit r=
eplacement has
not been successful due to the page alignment requirement of the function. =
This patch
set implements a new api "emit_clock_levels" to facilitate passing both the=
 base and
offset to the device rather than just the write pointer.

The emit_clock_levels API for amdgpu_dpm has been duplicated to pp_dpm, bas=
ed on the patch
 commit 7f36948c92b2 ("amdgpu/pm: Implement new API function "emit" that ac=
cepts buffer base and write offset")
and vega10_emit_clock_levels has been implemented with sysfs_emit based on =
vega10_print_clock_levels


=3D=3D Patch Summary =3D=3D
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ =
6b6b9c625004
    + e94021f6c08c amdgpu/pm: Add new hwmgr API function "emit_clock_levels=
"
    + d83131987718 amdgpu/pm: Implement emit_clk_levels for vega10

=3D=3D System Summary =3D=3D
* DESKTOP(AMD FX-8350 + VEGA10(687f/c3), BIOS: F2)
 + ISO(Ubuntu 20.04.4 LTS)
 + Kernel(5.16.0-20220307-fdoagd5f-g6b6b9c625004)
 + Overdrive Enabled(amdgpu.ppfeaturemask |=3D 0x4000)

=3D=3D Test =3D=3D
AMDGPU_PCI_ADDR=3D`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{pri=
nt $9}'`
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
printf 'OD enabled =3D %X\n' "$(( `cat /sys/module/amdgpu/parameters/ppfeat=
uremask` & 0x4000 ))" >> $LOGFILE
FILES=3D"pp_od_clk_voltage
pp_dpm_sclk
pp_dpm_mclk
pp_dpm_pcie
pp_dpm_socclk
pp_dpm_fclk
pp_dpm_dcefclk
pp_dpm_vclk
pp_dpm_dclk "

for f in $FILES
do
  echo =3D=3D=3D $f =3D=3D=3D >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Darren Powell (2):
  amdgpu/pm: Add new hwmgr API function "emit_clock_levels"
  amdgpu/pm: Implement emit_clk_levels for vega10

 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  17 ++
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 147 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   2 +
 3 files changed, 166 insertions(+)


base-commit: 6b6b9c625004e07e000ca1918cadcb64439eb498
--
2.35.1


--_000_CH0PR12MB5387ACB52F418D37B91EE6B8F0199CH0PR12MB5387namp_
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
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&nbsp;PING?
<div>** https://lore.kernel.org/amd-gfx/20220313052839.5777-1-darren.powell=
@amd.com/T/#u</div>
<div>&nbsp;[PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution=
 for vega10
</div>
<div>&nbsp;2022-03-13 &nbsp;5:28 UTC &nbsp;(3+ messages)</div>
<div>&nbsp;` [PATCH 1/2] amdgpu/pm: Add new hwmgr API function &quot;emit_c=
lock_levels&quot;</div>
<div>&nbsp;` [PATCH 2/2] amdgpu/pm: Implement emit_clk_levels for vega10</d=
iv>
<div><br>
</div>
<div>&nbsp;Thanks</div>
<span>&nbsp;Darren</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Powell, Darren &lt;Da=
rren.Powell@amd.com&gt;<br>
<b>Sent:</b> Sunday, March 13, 2022 12:28 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Powell, Darren &lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit sol=
ution for vega10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">=3D=3D Description =3D=3D<br>
Scnprintf use within the kernel is not recommended, but simple sysfs_emit r=
eplacement has<br>
not been successful due to the page alignment requirement of the function. =
This patch<br>
set implements a new api &quot;emit_clock_levels&quot; to facilitate passin=
g both the base and<br>
offset to the device rather than just the write pointer.<br>
<br>
The emit_clock_levels API for amdgpu_dpm has been duplicated to pp_dpm, bas=
ed on the patch
<br>
&nbsp;commit 7f36948c92b2 (&quot;amdgpu/pm: Implement new API function &quo=
t;emit&quot; that accepts buffer base and write offset&quot;)<br>
and vega10_emit_clock_levels has been implemented with sysfs_emit based on =
vega10_print_clock_levels<br>
<br>
<br>
=3D=3D Patch Summary =3D=3D<br>
&nbsp;&nbsp; linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-d=
rm-next @ 6b6b9c625004<br>
&nbsp;&nbsp;&nbsp; + e94021f6c08c amdgpu/pm: Add new hwmgr API function &qu=
ot;emit_clock_levels&quot;<br>
&nbsp;&nbsp;&nbsp; + d83131987718 amdgpu/pm: Implement emit_clk_levels for =
vega10<br>
<br>
=3D=3D System Summary =3D=3D<br>
* DESKTOP(AMD FX-8350 + VEGA10(687f/c3), BIOS: F2)<br>
&nbsp;+ ISO(Ubuntu 20.04.4 LTS)<br>
&nbsp;+ Kernel(5.16.0-20220307-fdoagd5f-g6b6b9c625004)<br>
&nbsp;+ Overdrive Enabled(amdgpu.ppfeaturemask |=3D 0x4000)<br>
<br>
=3D=3D Test =3D=3D<br>
AMDGPU_PCI_ADDR=3D`lspci -nn | grep &quot;VGA\|Display&quot; | cut -d &quot=
; &quot; -f 1`<br>
AMDGPU_HWMON=3D`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{pri=
nt $9}'`<br>
HWMON_DIR=3D/sys/class/hwmon/${AMDGPU_HWMON}<br>
<br>
lspci -nn | grep &quot;VGA\|Display&quot;&nbsp; &gt; $LOGFILE<br>
printf 'OD enabled =3D %X\n' &quot;$(( `cat /sys/module/amdgpu/parameters/p=
pfeaturemask` &amp; 0x4000 ))&quot; &gt;&gt; $LOGFILE<br>
FILES=3D&quot;pp_od_clk_voltage<br>
pp_dpm_sclk<br>
pp_dpm_mclk<br>
pp_dpm_pcie<br>
pp_dpm_socclk<br>
pp_dpm_fclk<br>
pp_dpm_dcefclk<br>
pp_dpm_vclk<br>
pp_dpm_dclk &quot;<br>
<br>
for f in $FILES<br>
do<br>
&nbsp; echo =3D=3D=3D $f =3D=3D=3D &gt;&gt; $LOGFILE<br>
&nbsp; cat $HWMON_DIR/device/$f &gt;&gt; $LOGFILE<br>
done<br>
cat $LOGFILE<br>
<br>
Darren Powell (2):<br>
&nbsp; amdgpu/pm: Add new hwmgr API function &quot;emit_clock_levels&quot;<=
br>
&nbsp; amdgpu/pm: Implement emit_clk_levels for vega10<br>
<br>
&nbsp;.../gpu/drm/amd/pm/powerplay/amd_powerplay.c&nbsp; |&nbsp; 17 ++<br>
&nbsp;.../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 147 +++++++++++++++++=
+<br>
&nbsp;drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h&nbsp; |&nbsp;&nbsp; 2 +<=
br>
&nbsp;3 files changed, 166 insertions(+)<br>
<br>
<br>
base-commit: 6b6b9c625004e07e000ca1918cadcb64439eb498<br>
-- <br>
2.35.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5387ACB52F418D37B91EE6B8F0199CH0PR12MB5387namp_--
