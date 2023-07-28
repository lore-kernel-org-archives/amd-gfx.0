Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F0CC001DC
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 02:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF6B10E011;
	Fri, 28 Jul 2023 02:49:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F082410E011
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 02:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j58f4u4dtC7l1AOews6b+aAG+qTYBZxbULR5oVjgtp/qnxi4J7P3BxEHqt/OHt68WWaac6ynQh9sn1L8VScuSDRutRCp/LTMkDqEeVW4bFPECLoPJagkz2xikU1PhkvC5m97sPv3r9YwLq5aSDaQUyHrbtHSN+Uj5rwVi/lXeWDo3ZMhsOwb7nAHYL6Q2VP1o/TGhKSyDJpYfM660RvnibOgpe4zJqtbMn+KSFU3nW/Y9VlfwDCpAG2Ank1CrZniR/Ybfed1gn/0HVT0juirkGwGbgvGInFx0PkDbDLr4Ps5EQ/hLt7/JAhqNwDGZaQs+ApzPtdhFll7AmBglRAVDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y07E2Z6elokUA3O9efe70H1Akf+bWUh/thzh8MHDcw0=;
 b=WnMylPdd44XS7oWLKUcG2YtU0ffJd1BcD74EkCRkDVFjcNI/dJZ5Il/eF9JsoCfLsgR/BP4Wb4LGReRSyroLWCVx8nphcKVT3VQronjpyEfSIJp+QgGCOidhUanC77B4OWhxpyP0bt91vMTIfHLCcJ1+WFKaVuXpgHv5gbiOZcy1rjYygOb6lkSoeFSeO4ptxhj3UtUvgeWa2McMJZSVmAFVx9t6ZDk4uzAY36QSpyUmYZ1Ks0il5FhgJfw4tK7FvKRZm3MLejsdq5RruzidRexpc5dZArEaOVwLXtWr9c+gIDsPlrOrPYiBe72rNd2B4Vy3FKkPrUgUEsZ7Yta9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y07E2Z6elokUA3O9efe70H1Akf+bWUh/thzh8MHDcw0=;
 b=niJ+VUm6Bw8GUHuGOFLjoJvi+74eq1CK8JWgUVcrdp/jKu5zDOhdZBFVJmH+gqapKRgmy8l8ca85YGDumZR6DeGMfAayNRU03P2K7dc+MHuFzNo+VSvt991yMrifppJNbN91Ysz2Ks6x2pCkzTyCX6XFflmE2f2wPcIG1Yd5Jdg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 02:49:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f%5]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 02:49:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for
 arcturus,aldebaran
Thread-Topic: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for
 arcturus,aldebaran
Thread-Index: AQHZeNFnQBJu0qzp6kyRwcXnfWrTmq/OldCAgABzVPA=
Date: Fri, 28 Jul 2023 02:49:11 +0000
Message-ID: <DM6PR12MB2619FC59D7F573DC95D8D1D2E406A@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230427062718.1172269-1-darren.powell@amd.com>
 <CH0PR12MB5387598198E7CE8281D5F77AF001A@CH0PR12MB5387.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5387598198E7CE8281D5F77AF001A@CH0PR12MB5387.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e12c32a9-fed0-4ad5-a8d4-fd150497abab;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-28T02:44:11Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MN2PR12MB4406:EE_
x-ms-office365-filtering-correlation-id: cf75c65f-174f-4e9a-ede9-08db8f153930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gmi+3ZHW8QLpIof3oB+AeinlhEBjQ18rRqmnMAPUB8/pYcHVdf0mbjANqXozZ0jBeJPKlORsfRcE+y4FsDTYQ8HiNVTrifMnnHrddSNjeEPKSBJO4fWDrecvJMYvIgzMtRkE2vmoaw9fDmV/80/qV6wSIpBIhYITUPe6er8SdPT71qQC0pH47u9hcl8TqHqUlPCOPVhD/O2bkBmqO0xKYu6RU4DI7ubHGFNERUKxqmba+WWZVUGgy4evsvBAO/VD1amUuP2rQz9sSqxvBS8aLJ+UYGrWE+ThDnHTczA9LutgKDkJmvpAG0975z82dfPxg/2IpcexcVmjKza2DhKlrhH5zRE3S2zVeKfvikqOsoQWjKCeaVg7uR2WQD4K/m97cW88eEJdnJ/FnDWztpDIO5asFfMhn43ks3h5IUVpG4PqlZ/rTQ2JjadCVxc1P4fb6rVTLcD7Y9BZEV9hZgx6ow+C3sUClk2ITIwNwgbkOc87IoFBmG1uNkqmYTnN9pRikrguXKTE6cVYcj8glOvxCg3/PdElWMtDu3c5Z7u2BpLWwyOdElb3w8DgM9w0c6nB2mv8ejmbvb/GVjpUxYnANRPa8b42fduktubaTvIbvTza5CVk9UkoRGA5SeE5drZs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(110136005)(9686003)(478600001)(54906003)(7696005)(6506007)(71200400001)(53546011)(66476007)(26005)(2906002)(66556008)(66446008)(8936002)(316002)(52536014)(76116006)(8676002)(5660300002)(41300700001)(66946007)(64756008)(38100700002)(122000001)(55016003)(38070700005)(86362001)(83380400001)(33656002)(4326008)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jFBgGgB1PQRVuKhsMyRjJF6y8adMkFwwRXTbquk7VLojqS/N9dgIFNVg2at/?=
 =?us-ascii?Q?7fuADidvrw7sB7Jw5kNaTtMwEUlIO5j2IsqRceYBxjlpoEpix+vOvcqgBBM6?=
 =?us-ascii?Q?7mZirXuaeij3bsGVA3nRp2eTn4CRTxZfih/6TuTSkicTZ2PGx6Zd7e1FsNw3?=
 =?us-ascii?Q?CSUT3qcH0s6hyqO0bJVPxk1WLN0G9935FoVrNOl+M3W9WTRkjhy+C2p0cvTy?=
 =?us-ascii?Q?MYIvnwOaQKcTXm/LIQB5s+xXcetJqhOd7O2jozxlItQJox8TpRv+9vRHr63n?=
 =?us-ascii?Q?ya8dUSgMAdyy+ueOr4i3DYX34N7iNf7Tvm3OiEa45um0Rk4ihFV/T3Ag6OpO?=
 =?us-ascii?Q?fEP37o2EnVJ1sYW19tonGBcRvMmPEFuEBwUuz3aG+oyJc9kXcYJzoXh+lViW?=
 =?us-ascii?Q?z5eZ8FObkh1KqL/c+5Ycx3rX6iXdyRtirRcqm4S1R0LI0aczVUDv+K64QKPt?=
 =?us-ascii?Q?9SeZRn/Qj4wnMWO/5WDR854f0LV1/+J5ZT34CGYULXVEVGxrn/Z69WVD7U6E?=
 =?us-ascii?Q?W6MbKgciM9uwbIADZKqSt0cLHAXJjy7ch+NZxmOkilNfMMS1MDWWlvGuJSfX?=
 =?us-ascii?Q?8v7qn8Aa63Kv4Dpn3YZr9tf5WxtyDSmVmrZcKxCHmxFprtVL74vg9k+HfsEn?=
 =?us-ascii?Q?CZKcMspvs93V+sEMeb/GvnQtqpzIss/0eqMbxhPNw0+U7Lb6yQK4q4AjPxat?=
 =?us-ascii?Q?rChJVogl0vsPKMMH6lcQ4vPhYe8ZS9zij7XAxvnLfgID+nlqi+nVnIrw4kDj?=
 =?us-ascii?Q?2vTgqOkcFTqsJr+nx25NE8RdMcBx8SxUfe36hwrtpbapqnGxbrIwNftXsewR?=
 =?us-ascii?Q?jKUx+uoqIY3g5635FPwd597ODi8k4MfSBtGkI7P5ZI9zuQ2UXYlbt2Q/qPgJ?=
 =?us-ascii?Q?+SS9hdSuiVHsz2bAV3G2KMNnyqPT2q6Z5tJAxHLzM11bQd13fczxhVwZUbID?=
 =?us-ascii?Q?GViuCanDszZoPR0BXV4ll1au3uvIZybOG1AQVUAdk03uu9HEaJJZCnzqj/cz?=
 =?us-ascii?Q?U4O9lOaFcYf9yrIxOjBmv/jOLsBlYMBIOePx33Gflb9yuCJEw89xY4h5ENqD?=
 =?us-ascii?Q?EAV+0haz7Sn93IeTSrXuRKko7OOlE+zpLoUOx4/PhrdxEa+NlQiPu3e8laFs?=
 =?us-ascii?Q?ZDPAENq89IQRfUHh1RkQUhzPB1gxRnbs9KVAZMNmhW7quwS0eeyxF7Ls8cfK?=
 =?us-ascii?Q?ZLfud15NrhsUAVaHbkJXF7Z4yiNBD9PoadaYwuUKg+KBQ9q53CH1wiRYwpXf?=
 =?us-ascii?Q?kTPeWR2It1P5Gx3WSOCxmxLQ6DZDns9F90JUeBedp1SfxVjzTmTXTB9+8la9?=
 =?us-ascii?Q?28/w8cNcAOw1+Bw79YjzP7RsEfBfREejwkHlDMd8QohmNxEa4ws2QFGFEkIR?=
 =?us-ascii?Q?GOABJqJEtW/Wy/IXoqfHuSwbID7mlfTdTALMnEshGbr37lNeRP//gRCB4slS?=
 =?us-ascii?Q?lrOEqpu/z8b1FzWhHTDQuAikNTMkBuLF9JjP+/fPScL2aHs0Hh9AzsBE6/ce?=
 =?us-ascii?Q?pRcEY0aKKxkLFdvtCTmDlPW7pJ+SXmr2ST9nJd1cZcZ/JrJl/BuSctEKqjk/?=
 =?us-ascii?Q?ykd1WySTLcTrkKhP7Yk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619FC59D7F573DC95D8D1D2E406ADM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf75c65f-174f-4e9a-ede9-08db8f153930
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 02:49:11.9490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BG4wceh0gpye14RbPEht9gV7G7M8abd3vB7D0CnT7YmOs2xNEPI3+TTwxzupWMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
 Lang" <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB2619FC59D7F573DC95D8D1D2E406ADM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

The series looks good to me.
Reviewed-by: Evan Quan evan.quan@amd.com<mailto:evan.quan@amd.com>

However better to split the changes of patch1 into two separate patches on =
your submission.
Replace print_clock_levels with emit_clock_levels for arcturus
  * replace .print_clk_levels with .emit_clk_levels in arcturus_ppt_funcs
  * added extra parameter int *offset
  * removed var size, uses arg *offset instead
  * removed call to smu_cmn_get_sysfs_buf
  * errors are returned to caller
  * returns 0 on success
Those changes are included in one patch.
additional incidental changes
  * changed type of var i, now to remove comparing mismatch types
  * renamed var s/now/cur_value/
  * switch statement default now returns -EINVAL
  * RAS Recovery returns -EBUSY
While those are included in another patch.

Same applied to patch5.

BR,
Evan
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Friday, July 28, 2023 3:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Yu, L=
ang <Lang.Yu@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: Re: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for arcturu=
s,aldebaran

Hi all,
  Just looking for anyone who could RB or ACK this patch set so I can submi=
t it?
Thanks
Darren
________________________________
From: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Sent: Thursday, April 27, 2023 2:27 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; Quan, Evan=
 <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Yu, Lang <Lang.Yu@amd.com<m=
ailto:Lang.Yu@amd.com>>; Huang, Ray <Ray.Huang@amd.com<mailto:Ray.Huang@amd=
.com>>; david.nieto@amd.com<mailto:david.nieto@amd.com> <david.nieto@amd.co=
m<mailto:david.nieto@amd.com>>; Powell, Darren <Darren.Powell@amd.com<mailt=
o:Darren.Powell@amd.com>>
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
   linux: (git@gitlab.freedesktop.org:agd5f<mailto:git@gitlab.freedesktop.o=
rg:agd5f>) origin/amd-staging-drm-next @ 2d8c6b82e241
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

--_000_DM6PR12MB2619FC59D7F573DC95D8D1D2E406ADM6PR12MB2619namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">The series looks good to me. <o:p></o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Evan Quan <a href=3D"mailto:evan.quan@a=
md.com">evan.quan@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">However better to split the changes of patch1 into t=
wo separate patches on your submission.<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">Replace print_clock_levels with emit_clock_lev=
els for arcturus<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * replace .print_clk_levels with .emit_=
clk_levels in arcturus_ppt_funcs<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * added extra parameter int *offset<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * removed var size, uses arg *offset in=
stead<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * removed call to smu_cmn_get_sysfs_buf=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * errors are returned to caller<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * returns 0 on success<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><i><span style=3D"font-size:10.0pt;font-family:&quot=
;Courier New&quot;;color:red">Those changes are included in one patch.<o:p>=
</o:p></span></i></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">additional incidental changes<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * changed type of var i, now to remove =
comparing mismatch types<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * renamed var s/now/cur_value/<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * switch statement default now returns =
-EINVAL<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; * RAS Recovery returns -EBUSY<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><i><span style=3D"font-size:10.0pt;font-family:&quot=
;Courier New&quot;;color:red">While those are included in another patch.<o:=
p></o:p></span></i></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Same applied to patch5.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Powell, Darren &lt;Darren.Powell@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, July 28, 2023 3:51 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Quan, Evan &lt;Evan.Quan=
@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;; Huang, Ray &lt;Ray.Huang@am=
d.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for =
arcturus,aldebaran<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Hi all,=
&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
Just looking for anyone who could RB or ACK this patch set so I can submit =
it?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Darren<=
o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@=
amd.com">Darren.Powell@amd.com</a>&gt;<br>
<b>Sent:</b> Thursday, April 27, 2023 2:27 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.=
Quan@amd.com</a>&gt;; Yu, Lang &lt;<a href=3D"mailto:Lang.Yu@amd.com">Lang.=
Yu@amd.com</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang@amd.com">Ray=
.Huang@amd.com</a>&gt;;
<a href=3D"mailto:david.nieto@amd.com">david.nieto@amd.com</a> &lt;<a href=
=3D"mailto:david.nieto@amd.com">david.nieto@amd.com</a>&gt;; Powell, Darren=
 &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darren.Powell@amd.com</a>&gt;=
<br>
<b>Subject:</b> [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for arct=
urus,aldebaran</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
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
&nbsp;&nbsp; linux: (<a href=3D"mailto:git@gitlab.freedesktop.org:agd5f">gi=
t@gitlab.freedesktop.org:agd5f</a>) origin/amd-staging-drm-next @ 2d8c6b82e=
241<br>
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
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619FC59D7F573DC95D8D1D2E406ADM6PR12MB2619namp_--
