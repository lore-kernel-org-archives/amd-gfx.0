Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D66BEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 19:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0815610E334;
	Thu, 27 Jul 2023 19:51:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E7010E334
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 19:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnGX1v+4R43jbaWrj5z37ottyXYr2bdsudT8XKI0caFciH9oY2V/n4NXi8LpkZYnu91yXVQcnvUmU0ozJMT79ZrhcF0Tw6pEsL2v/nF1qMbDSPEG63AL3oDUBBr+yO/uFqls2f66H0FlSxfSeqKYinWHJioes5thT4yHv88mFCTtsmJremNsSnOABIDe2xTebA77RSndS5yMc8XFc7xwZ6aTDdnoO08ev2QKumRDMUP1PeSMuh0K9H44pKwZOsyqjQp/uD3rf2xHKs2V6q+lgv1pz+VfRP08RsMzXkwLW8Riacm1uEZYXuCFrOpDKF8QbyH51emEzoQswgaZsi7dEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pqir3Dl1mx0Vw47tDIODqtjy7kpsVO+zzGe22c5V0s=;
 b=TUwfmgBEAOoj6bPM+5NZxzBCwSDsM9x1C6D4nwZVHPxRHhxpUSdAIhQFy/tt5lF0e4HL2KLkBxIcEBQJd6hobnUN+NjPESgSqbd86gFZ0g69VO7cli/xUrfAS8Y1rlLsWKYlGV11lN0Gr5C1K1H+jahkaZz8H/eVsqoLYRWtXiIGKJydyybAnUZb8EyjA2IU9wHkEQTorOxz3mHxKg/87VGIfZeUvDgGCjxwI5APavq16yb8gjiLKsCxvi1iFk5F5ACNu51kIj6feoq43gUucHehLQB+yOos7MLL/TUmp0TvdbEzi21+ls5lbbhpTy4IDyNkzDPeRsTQ4t0ykdKfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pqir3Dl1mx0Vw47tDIODqtjy7kpsVO+zzGe22c5V0s=;
 b=YCZBSX6Londs3TC5z0RIj7/ITs/SqjtIyvg/RwUoWQD+FG6bVH/EMsoW1YAF8u1/Pluk3yuiyp3uDPn/T4kb12NoTpLmoeTD2XjHgtnyDbDDiyCQwYLQWkZD8vC4cdY3lnsrNp+fEg1Y/oee5E7isSu11smw2N9zoOIcjEGADYA=
Received: from CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 by SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 19:51:25 +0000
Received: from CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::a149:c231:49c7:aebe]) by CH0PR12MB5387.namprd12.prod.outlook.com
 ([fe80::a149:c231:49c7:aebe%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 19:51:25 +0000
From: "Powell, Darren" <Darren.Powell@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for
 arcturus,aldebaran
Thread-Topic: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for
 arcturus,aldebaran
Thread-Index: AQHZeNFn64KBxyRuwUWBiE3CbXGNra/OlWwP
Date: Thu, 27 Jul 2023 19:51:25 +0000
Message-ID: <CH0PR12MB5387598198E7CE8281D5F77AF001A@CH0PR12MB5387.namprd12.prod.outlook.com>
References: <20230427062718.1172269-1-darren.powell@amd.com>
In-Reply-To: <20230427062718.1172269-1-darren.powell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5387:EE_|SA3PR12MB7808:EE_
x-ms-office365-filtering-correlation-id: 6d467f95-0095-4933-6c53-08db8edadc70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYgPBMiH5xiiElrHShDWNq33Wdb+B8aKaByAj/gM1l63B9w2rgYqDHxHNKxQ25arAIrC+niH+q7yv+slsm2H3cZklDPo5AJ3hVuT/jcW1KhaAO3mXl4CGrfb8jeGlcak4mznb9q92h7nZPEOP07j/qS+C1RrXy/78QP/ygv/GLjnzRzsTbnCSU8hs0jQWPeSlmr2Q/Mf+UIMimRpXFF4lNulWtfa8xhJ3doTPmWwA7ZsW/gcNyLCccd1rmJiorAUig5kDiup6/l3qIbrqHEBlhjSXiAKbm3Hig/czuf/CqrPibmjm5pr0wl4IYEu3YcswEBX7/BdE24VSDXr3+fJ5AQkQKJ1t7TwKbbI1lriGxJmGSiSBU76d7gG2hYFAw1jcztjkXveUxnB7cz0AiowqIo4WZAOwtX2lPtgtpvn1O1OH7YYbAqVLA3e09QibqVOb3ZZWDV0vrzJ3nn86b5yD4TedCF/UiolRfCstX3IqUcN9OEZ+53Z0/gwWAPOpLOp6kKVni40u99seeW6Mmwr9vQaVNw4IUkQfSS8HjfORHQX4nT0GCHFj8lC1W3i4ya1wBtpDKNMCxe5/5EZ3hZyh8JaR8d5o4fh9ZQ01W/rpFWs18Thmz9i8H4mpEE0Dm07
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5387.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(316002)(8676002)(41300700001)(33656002)(8936002)(66476007)(6506007)(26005)(53546011)(55016003)(54906003)(122000001)(6916009)(4326008)(66446008)(478600001)(66946007)(64756008)(76116006)(9686003)(66556008)(91956017)(71200400001)(7696005)(38100700002)(2906002)(38070700005)(83380400001)(86362001)(19627405001)(186003)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99G+Kq9ubzTfIsONmoCty7O88U51pnDNxuOK5VrKsPZYkUBn3U4K0pO7Dag6?=
 =?us-ascii?Q?LOnnqzFhjvHlDyA4Hstv42CSyY3AxJ+DqPhq9pzJ/TvBV5nAz7YJfJo8hF90?=
 =?us-ascii?Q?sEsRodD0jED0YXNSr0qpCZpDVcXO9ozQpXReElfAtpX0Ht/i5O2cKztdZmkl?=
 =?us-ascii?Q?JPoYGI1rPqyZBAr/g+KgO7oaO9L9uUIjTsw87hqJHsSd7QCd2UIqcN7wfZnk?=
 =?us-ascii?Q?cg/apBRUGKnnXS41pJ0VKL70X4L/mxKcZg1G4C418p6bXbFHib99mkPyH0RM?=
 =?us-ascii?Q?t1yJmAkrt8FoSIeumqVuxDhz3eOd5+pNsFPGUrawnJkWd2ENlHKElHas4zHr?=
 =?us-ascii?Q?j/al8aBvexR6Ao6Ug2gT5/JZ+Q6iheiIhB7Gy4m0FGZyvf39ikN3xAeeB5jD?=
 =?us-ascii?Q?XGHE+B/EtVGwTlKvJKoVvpImw4OJNWn8ALcM60SWv9xq/Zq+Uoz4fZCW4kuc?=
 =?us-ascii?Q?N6DOmDG4NlAC/7lzWcZA7d6PjUyuevRhXWDFltriRmjOkHmxzghEKTF0Fg4O?=
 =?us-ascii?Q?5JW+vZQSR60v7LllU5cbIaiLbU+W91P+/jipH6yDnErSOO4NcKgHWWnX4fHT?=
 =?us-ascii?Q?81MaG6NOHH+3jFZ3pXk2/NOWaKm9Mo3TxaToBCFKsHte9Xh4RAipTYVSsmz0?=
 =?us-ascii?Q?StUkhI5hLlUW6K+O1x9f1MbiwSYpIhSFcmikAn1FwmFt6PmuI6ogG8DKTR7q?=
 =?us-ascii?Q?coEgMb9E2vZINwgnpvz8XcEdQPEZkT1jVPhkkxhuyq0BLmX9/KKDO1cRPZ2R?=
 =?us-ascii?Q?k3VZxFDo+cPrb5F14w405dA/MGKZCxmPjVI0Nw4Sek8k3uZgmetwv2qzr+u8?=
 =?us-ascii?Q?s3OXP8XECGg+dxT1UZsquPrtL4x7OsDIDuZYyXJzwkU2wkdOmE1AwuSXkYAv?=
 =?us-ascii?Q?uLrq1FIFwivsgIqzwKRJPj/AofQXTaEe1+zD+MQApEryReHSDe5TrOIt9B7e?=
 =?us-ascii?Q?jkug9GFqOj5mP4+PLhABNZKpv6gCJ9gdTjhQmvG3UTdagwEFG0HEEAsLycCR?=
 =?us-ascii?Q?3ADc1We8zMBhGCSm9OnK3v4oi/JDMuyvwc7BzoJpsoJo1ETrTIiYyCBlLlgl?=
 =?us-ascii?Q?WBwzeglEOZqO4px6ovYeTCj8kHMFtbB6f6hyvHaIxsJMBVrV90gYsT6Q+7s1?=
 =?us-ascii?Q?sfP/9Ng+ie3IrWFasMOPtcqWJWv3w5AvNFD6MqlBBWChccpAOHX6GFMQpPDQ?=
 =?us-ascii?Q?F8tnYgi5HlnXXTco/q3m/ipB4KOYpDkpk6TMFDoKeJP77QxYB4o6Ovd4aL+c?=
 =?us-ascii?Q?ZdbgihLytf5Di3S8PPi7CpJYrrITHf+qxwlT74Vvw6LFiI9yZEVVwxP0aGNL?=
 =?us-ascii?Q?Ilc4BeC0SB06HpU/DHD+UWknrX4v4kw5HqQc8/YaXAkk2IQhdb45pUEeufHr?=
 =?us-ascii?Q?/6Q0Z6Sn/VVHNbLnLiE3gg5TSNEVKSzVq2+7c5XKVXUQqbv+WbwgNCVT4qKr?=
 =?us-ascii?Q?VUEJS1EsMp4HD7JfbRc/KrbRb+j94LvnePA8aZyEHTLOgK82LIcm+xq6JUY5?=
 =?us-ascii?Q?LYAqmtWInDuU4/5LtWBszd2zE+PBu61hnrWx4PbNThQHD5NfVwIeAZmI3ESw?=
 =?us-ascii?Q?q1waYYMA1uh+SaadmU0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5387598198E7CE8281D5F77AF001ACH0PR12MB5387namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5387.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d467f95-0095-4933-6c53-08db8edadc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 19:51:25.5166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWFU6VR4G8UNzFN3bpuayO+phshOZ8Khu0OCsLzEZ1+YA8X6El2Zpz+a+o+gbsxqsp69AEivxX5cHYcP6jGGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yu, 
 Lang" <Lang.Yu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5387598198E7CE8281D5F77AF001ACH0PR12MB5387namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,
  Just looking for anyone who could RB or ACK this patch set so I can submi=
t it?
Thanks
Darren
________________________________
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Thursday, April 27, 2023 2:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Yu, L=
ang <Lang.Yu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; david.nieto@amd.com =
<david.nieto@amd.com>; Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for arcturus,al=
debaran


amdgpu/pm: Implement emit_clock_levels for arcturus,aldebaran

=3D=3D Description =3D=3D
Scnprintf use within the kernel is not recommended, but simple sysfs_emit r=
eplacement has
not been successful due to the page alignment requirement of the function. =
This patch
set implements a new api "emit_clock_levels" to facilitate passing both the=
 base and
offset to the device rather than just the write pointer.

This patch set replaces print_clock_levels for arcturus and aldebaran platf=
orms with
emit_clock_levels, and also optimizes the code to reduce the code duplicati=
on for each
different clock. This was spread into three parts to show more clearly the =
changes made
to the code, followed by combining the common code into a second switch sta=
tement.
It is similar to previous work on vega10 to implement emit_clk_levels
 commit a63e6b83 ("amdgpu/pm: Implement emit_clk_levels for vega10")
with the addition of the optimization to reduce code duplication.

=3D=3D Patch Summary =3D=3D
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ =
2d8c6b82e241
    + 9a269da4c047 amdgpu/pm: Replace print_clock_levels with emit_clock_le=
vels for arcturus
    + 51ce0fcc9599 amdgpu/pm: Optimize emit_clock_levels for arcturus - par=
t 1
    + dcaa5b7551dd amdgpu/pm: Optimize emit_clock_levels for arcturus - par=
t 2
    + 1d16d820e4ee amdgpu/pm: Optimize emit_clock_levels for arcturus - par=
t 3
    + b374fbf6013d amdgpu/pm: Replace print_clock_levels with emit_clock_le=
vels for aldebaran
    + 2ecf48d3e83c amdgpu/pm: Optimize emit_clock_levels for aldebaran - pa=
rt 1
    + fd8c21e1d1e4 amdgpu/pm: Optimize emit_clock_levels for aldebaran - pa=
rt 2
    + a67ce808f18c amdgpu/pm: Optimize emit_clock_levels for aldebaran - pa=
rt 3

=3D=3D System Summary =3D=3D
 * DESKTOP(AMD Ryzen9 7900 + NAVI10(731f/ca), BIOS: 1.11)
  + ISO(Ubuntu 22.04.2 LTS)
  + Kernel(6.1.11-20230412-fdoagd5f-g2d8c6b82e241)

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

Darren Powell (8):
  amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
    arcturus
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 1
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 2
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 3
  amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
    aldebaran
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 1
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 2
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 3

 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 ++++++----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 181 +++++++-----------
 2 files changed, 132 insertions(+), 215 deletions(-)


base-commit: 2d8c6b82e241f2d1a802ae6bbc24c127e689c724
--
2.34.1


--_000_CH0PR12MB5387598198E7CE8281D5F77AF001ACH0PR12MB5387namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi all,&nbsp;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
&nbsp; Just looking for anyone who could RB or ACK this patch set so I can =
submit it?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Darren</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Powell, Darren &lt;Da=
rren.Powell@amd.com&gt;<br>
<b>Sent:</b> Thursday, April 27, 2023 2:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan=
@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Huang, Ray &lt;Ray.Huang@am=
d.com&gt;; david.nieto@amd.com &lt;david.nieto@amd.com&gt;; Powell, Darren =
&lt;Darren.Powell@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for arct=
urus,aldebaran</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
amdgpu/pm: Implement emit_clock_levels for arcturus,aldebaran<br>
<br>
=3D=3D Description =3D=3D<br>
Scnprintf use within the kernel is not recommended, but simple sysfs_emit r=
eplacement has<br>
not been successful due to the page alignment requirement of the function. =
This patch<br>
set implements a new api &quot;emit_clock_levels&quot; to facilitate passin=
g both the base and<br>
offset to the device rather than just the write pointer.<br>
<br>
This patch set replaces print_clock_levels for arcturus and aldebaran platf=
orms with
<br>
emit_clock_levels, and also optimizes the code to reduce the code duplicati=
on for each
<br>
different clock. This was spread into three parts to show more clearly the =
changes made<br>
to the code, followed by combining the common code into a second switch sta=
tement.<br>
It is similar to previous work on vega10 to implement emit_clk_levels<br>
&nbsp;commit a63e6b83 (&quot;amdgpu/pm: Implement emit_clk_levels for vega1=
0&quot;)<br>
with the addition of the optimization to reduce code duplication.<br>
<br>
=3D=3D Patch Summary =3D=3D<br>
&nbsp;&nbsp; linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-d=
rm-next @ 2d8c6b82e241<br>
&nbsp;&nbsp;&nbsp; + 9a269da4c047 amdgpu/pm: Replace print_clock_levels wit=
h emit_clock_levels for arcturus<br>
&nbsp;&nbsp;&nbsp; + 51ce0fcc9599 amdgpu/pm: Optimize emit_clock_levels for=
 arcturus - part 1<br>
&nbsp;&nbsp;&nbsp; + dcaa5b7551dd amdgpu/pm: Optimize emit_clock_levels for=
 arcturus - part 2<br>
&nbsp;&nbsp;&nbsp; + 1d16d820e4ee amdgpu/pm: Optimize emit_clock_levels for=
 arcturus - part 3<br>
&nbsp;&nbsp;&nbsp; + b374fbf6013d amdgpu/pm: Replace print_clock_levels wit=
h emit_clock_levels for aldebaran<br>
&nbsp;&nbsp;&nbsp; + 2ecf48d3e83c amdgpu/pm: Optimize emit_clock_levels for=
 aldebaran - part 1<br>
&nbsp;&nbsp;&nbsp; + fd8c21e1d1e4 amdgpu/pm: Optimize emit_clock_levels for=
 aldebaran - part 2<br>
&nbsp;&nbsp;&nbsp; + a67ce808f18c amdgpu/pm: Optimize emit_clock_levels for=
 aldebaran - part 3<br>
<br>
=3D=3D System Summary =3D=3D<br>
&nbsp;* DESKTOP(AMD Ryzen9 7900 + NAVI10(731f/ca), BIOS: 1.11)<br>
&nbsp; + ISO(Ubuntu 22.04.2 LTS)<br>
&nbsp; + Kernel(6.1.11-20230412-fdoagd5f-g2d8c6b82e241)<br>
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
Darren Powell (8):<br>
&nbsp; amdgpu/pm: Replace print_clock_levels with emit_clock_levels for<br>
&nbsp;&nbsp;&nbsp; arcturus<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for arcturus - part 1<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for arcturus - part 2<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for arcturus - part 3<br>
&nbsp; amdgpu/pm: Replace print_clock_levels with emit_clock_levels for<br>
&nbsp;&nbsp;&nbsp; aldebaran<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 1<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 2<br>
&nbsp; amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 3<br>
<br>
&nbsp;.../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 ++++++----------<=
br>
&nbsp;.../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c&nbsp;&nbsp;&nbsp; | 181 ++=
+++++-----------<br>
&nbsp;2 files changed, 132 insertions(+), 215 deletions(-)<br>
<br>
<br>
base-commit: 2d8c6b82e241f2d1a802ae6bbc24c127e689c724<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CH0PR12MB5387598198E7CE8281D5F77AF001ACH0PR12MB5387namp_--
