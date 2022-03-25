Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42362C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 01:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619FB10E17F;
	Fri, 25 Mar 2022 01:38:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC1F110E17F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 01:38:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ1kFXnIv8CxemBrAed5imWFUHHeZtK7QDXoXFVvHnPV3qJKzwBScOtE9tuQJET5MuNbXOrwRzzPOoBAE9ETSfXqJ/KhaKdZIxuntfrVLKZQjWj+zHCBtmIHZJ3tj0pfXbKTUK5GNd26mXFMVMWGt4IHU7L8M9QYj40/uNJ08HXdPLUyv61AbL7OOP7nl8G8X3j3UJlMZ5rZtF6zYsDnsH4EWxXSTnXRaVLuRKQiJo23kjTkgu7/bvMsbgkNQcTrDYaD8KElvVOSGEunzmANXxeXCpVpQMrIzmMXbp3cdTUhi34myyYn/mRl0WK+0OynT8/7MmOEARMSpUYwBpUjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98BjwwxGcp+eheqicCZX/v7FGkrUclJIExMMv0OApLI=;
 b=XQeA6FJ0vkvkyrViFAMPIOOg2k1dHg+FAfViDtyoet6bfN2PU6QZL0CS87tw0Zogcn22yLzQQKoE5yd5pZwP2omYWZprowC2bLdDr3EfWAPYr9V2T55uc2qdB8gB6yX2SlyUTl7XRL7Fj/Q0R+Rx3IEk1+NVwlMX9C5pniALuX/iMU+MpYKwdnic3oPx2PW7RT7sSJg2Vf922H+oztR4TQVZAKNCytYG9A7WVJGzoByq5grtDeNDtbcyDyrlc3yfxXkk4VOOPhPuw9nTcP2SbwqCTky5TOhcbC3qJ+aDpjsHCeO+k6wz2TZXPZJUC+MdRgClO6xoipVvm596FwvyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98BjwwxGcp+eheqicCZX/v7FGkrUclJIExMMv0OApLI=;
 b=Ox+E0DrpGfNsm6UvY8vsCIvmVCDcGd/wlMSg6a8D/PH3hfecP+fjx8HVgC3y8N30I0l4uKRz/SIHKwnvmx57cK5DmUth254j18A/mE/HccEHYqFkbHhMGaZTGP6W7sCOuKD74q/DYY2bwAmNlXFOH9VnT8Af0+8nucPi0HQZLro=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MN2PR12MB3455.namprd12.prod.outlook.com (2603:10b6:208:d0::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.16; Fri, 25 Mar 2022 01:38:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ac69:d13c:c740:947b%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 01:38:40 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution
 for vega10
Thread-Topic: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution
 for vega10
Thread-Index: AQHYNpth47rW0zVanU+hFgvy8D50vqzPDPSAgABXm+A=
Date: Fri, 25 Mar 2022 01:38:40 +0000
Message-ID: <DM6PR12MB2619AC9ECB0F270EE0772030E41A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220313052839.5777-1-darren.powell@amd.com>
 <CH0PR12MB5387ACB52F418D37B91EE6B8F0199@CH0PR12MB5387.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5387ACB52F418D37B91EE6B8F0199@CH0PR12MB5387.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-25T01:38:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=17f7572e-1cd3-4870-bbc8-420ab6eda263;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04451e68-63c2-42a4-a552-08da0e00309c
x-ms-traffictypediagnostic: MN2PR12MB3455:EE_
x-microsoft-antispam-prvs: <MN2PR12MB34559FACE5BF3891DDC13373E41A9@MN2PR12MB3455.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2kPFlUciUDi94xVUm396dL2wkJvV30qVfF2OEDImsGF9l3v1TG07d2jVyzG9pjhLJ+z2xg8bVKxZ3cR9Z9qaF/m6+/lZnTg89gzZ1+Ho6uiaWJCxObgIDczGIvl40KegHiLspuRbd+qxKofq8PQ+KFXWNSiLS5cGR39jk9lLmIk/tlr7UUQyQbz7batE0FHhL7+4vRNYSq1zJPKDmnXTReUbTfnj4zA1IFWQm2AdsIti24uQpqHsWbsGYbK6XjbdWb/+t5bsxnJC96l0hiDDaQGDENVH1bZ7zNHJuFD5Z4Nw3jnb2aZ8asTHAzneqtfSzoXfqdFkBL+33GtkN9faSsYNYCTn+aVdOQqT+Lq4k6I2l27xb6DtwynHem/+wODLlp9ZmdisxQVWjsdDElgNndBC9nSc/8Ox8/feOaefS7h3kTQKXaUAX7d7ovhct5YnDkGrmxpREaBoYinxTWqTV6D904bUXln8D8ZO6VTxHhvIJ7o9AUiz1FQYr0X32A0Imw6GYqxfb4XsoPMH2hrkWCLd09LBAdslePTbJRUS28C2ZICzkes69goKvGO7JfgOMFGBTNXhjpZIssY6sbVlXpUvFstz9jZ44JKcd741RskgsW+8UGSKwwKcTEoA+bIASMjGyqDKZlFK+/U1rkNX6VP5xR4QAKGajv2LlWLuSkVhlRQFLy90O267LTVly3bBFdj7UhcNJlPx/QkQRPfTSL8yQ1KlYMXqqUijEmrDl1T98rUieo+CSl5OM32dSzwUc0mtb+a9gSAAm1CDGDGDOZB6Aw0kD2XnXLESEGIkieA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38070700005)(966005)(38100700002)(71200400001)(508600001)(86362001)(8676002)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(110136005)(316002)(53546011)(7696005)(6506007)(186003)(122000001)(83380400001)(9686003)(8936002)(55016003)(166002)(2906002)(33656002)(26005)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RvybH+daI1qCz2weBywJQzo/zmziryiuedoeGTN2GHLJmmsA8milTOkDGe+u?=
 =?us-ascii?Q?xTPcXGbnWpLuvk74aAjYz3NBzltF5qoe7PzRlBcznvudeKpnjwwei/+f13MD?=
 =?us-ascii?Q?q9TPXIvEpxXsm4zJcxGg8ZLPdmFmT4uXrKnJ3iDLI15jBnxv96jy/c5xOjnQ?=
 =?us-ascii?Q?qHvOfbfhJJzD4DnF8d4ZTWq36O1YAoE6GXZ6y4xHujwkxUQ+ShwwR/awxWh6?=
 =?us-ascii?Q?1Yd1+Iop/q0KOsy1eyVceZpcnAAy0w34cSt+voF1zYdpWDuyFwkjGrrTbgW4?=
 =?us-ascii?Q?CXwLX8Z2+FIUjCmh613dIumFJNqWLCYSEUtIkx1upVXir+eXNYhNhI0a4N9v?=
 =?us-ascii?Q?2azSAE9rQGtSMyydO0ZKnY2H05uWIyZcyv/4GRpe7Yb0QGafsqP2C9/P6fUh?=
 =?us-ascii?Q?o7nPbbjCyMSg4sUxfkYIc/x3J6WDi/f/PiDSAv36m9lj8/9jdfIjWFiROnzL?=
 =?us-ascii?Q?R5FvM2MlLLugl5hwJv2HSwAZ3Ppt7Za4b3+9bxJDop++ZNvGH5B7khmQL2JE?=
 =?us-ascii?Q?rIB2dWSg4Ex3aNPhlBa5Y6wn4Q29xan07qxv/rswwTzrQps4S97JtnbJA96S?=
 =?us-ascii?Q?cB5P4oBlyYlfneWwbWniY59P5bHCQvN1mTBBaza27a1vs1oCH+EBLUN9kDDo?=
 =?us-ascii?Q?uqRteV/b1+afGHyEY6jXR+XMDvikiOy2PJ8X9YfJsimSekmXAwIyCNBau2bx?=
 =?us-ascii?Q?gCUyDxdT3uiRaVmfOS+AYpF75N4ZrBpzqiSUFvLSkzYgyORrrLs21anhf6bt?=
 =?us-ascii?Q?PtWZN8XnwyHqkQjNbJpDUMakUcW4GwyHti006r3doErH9+RaPHWszsf4e1AC?=
 =?us-ascii?Q?4saD/NQsQ3zdLqXWlTLIUpVlkvVKxiZig4l7gbeEAeEk8xs3TM+K3U9TF1+T?=
 =?us-ascii?Q?OD2X5YDvfEbknr6xZuobq+cCl1KG/G6aJXpRaCAcPj8T/Qb0n0hT3MOEC57m?=
 =?us-ascii?Q?A20k+zk/2grCkv1zxkpUZVIZ2NFdsSCPJeigMIqmJaTcCHRc6gUPN1nFBtaM?=
 =?us-ascii?Q?SiHvyX8m7CSNm8Qd4sID1ZpFo+7K68WsTAOPyCDeBLuXUcW55Y9HUybQJARz?=
 =?us-ascii?Q?ZGm9hbSJPWzjIN9k3tg8ZOSkwUtY+meIzrMo8nPyhYUXuLnaSyu3k/Q50kmy?=
 =?us-ascii?Q?ZkObQFsgfdo3LmKb4V4PbJMKIeehHLFOPNGGPKOOHmwg0+0efEuQsNv2jiiS?=
 =?us-ascii?Q?D6Ndb0QrgYOT1nm6SvhGNznWBDE94VWNHaHAsorweWHs9C5gtZ+ySr5ulRw+?=
 =?us-ascii?Q?uwgkslFH4l/OiGApoI+CpMAzVnOoLK4RkTsXP3+3+MX7ioTFHBWyCBP4ihFv?=
 =?us-ascii?Q?fxYMH5HupZV+Sryu3wG1mICIvc+YVwUCi9RkVjArRXo8IlmgPZCui+mtSo5C?=
 =?us-ascii?Q?oMlYFhRUSps18yamd/j9VSYEpG5Ds/K0YwhKx5Ptg7FkMRr9/Ee0K6HL+tUA?=
 =?us-ascii?Q?o/VHKifWaYzZpZuBKhleVUFjSXkieilDMVL/45Xbhn0yH+zDeufDVftuYGRb?=
 =?us-ascii?Q?QB7Fh83UKSW12ObCg/fZOcVN9yBQ/u2zNjNfeQoj41yZvIlmg9c39uS3lFnA?=
 =?us-ascii?Q?DdMitsqwBvrWWR0APeQnssSdVBtgKnF68qFq4iCLl/zNBbYi9VNMI6abCzEG?=
 =?us-ascii?Q?EFWGwD6q8WrEOXpcstLvXrM18dXfr1deLZ+8AY5ZM3qQ7w1LX4av0aqZMGKS?=
 =?us-ascii?Q?tzjIgCYbGPRRBAYhzhTUA6LadOGszmkeyPl/Cjcx5g7oQN3I?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619AC9ECB0F270EE0772030E41A9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04451e68-63c2-42a4-a552-08da0e00309c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 01:38:40.1895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dcaMBpOCUqNc98IX4yHJYj5Gjid3UYfKAwrPY6yAZiWC4RSKzzju+XtrDuSZ47cO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3455
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

--_000_DM6PR12MB2619AC9ECB0F270EE0772030E41A9DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Seems fine to me.
Series is reviewed-by: Evan Quan <evan.quan@amd.com>

Thanks,
Evan
From: Powell, Darren <Darren.Powell@amd.com>
Sent: Friday, March 25, 2022 4:24 AM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit soluti=
on for vega10


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
From: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
Sent: Sunday, March 13, 2022 12:28 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Powell, Darren <Darren.Powell@amd.com<mailto:Darren.Powell@amd.com>>
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
   linux: (git@gitlab.freedesktop.org:agd5f<mailto:git@gitlab.freedesktop.o=
rg:agd5f>) origin/amd-staging-drm-next @ 6b6b9c625004
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

--_000_DM6PR12MB2619AC9ECB0F270EE0772030E41A9DM6PR12MB2619namp_
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
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Seems fine to me.<o:p></o:p></p>
<p class=3D"MsoNormal">Series is reviewed-by: Evan Quan &lt;evan.quan@amd.c=
om&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Powell, Darren &lt;Darren.Powell@amd.co=
m&gt; <br>
<b>Sent:</b> Friday, March 25, 2022 4:24 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit=
 solution for vega10<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;P=
ING? <o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">** <a h=
ref=3D"https://lore.kernel.org/amd-gfx/20220313052839.5777-1-darren.powell@=
amd.com/T/#u">
https://lore.kernel.org/amd-gfx/20220313052839.5777-1-darren.powell@amd.com=
/T/#u</a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;[=
PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution for vega10
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;2=
022-03-13 &nbsp;5:28 UTC &nbsp;(3+ messages)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;`=
 [PATCH 1/2] amdgpu/pm: Add new hwmgr API function &quot;emit_clock_levels&=
quot;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;`=
 [PATCH 2/2] amdgpu/pm: Implement emit_clk_levels for vega10<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;T=
hanks<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;D=
arren<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@=
amd.com">Darren.Powell@amd.com</a>&gt;<br>
<b>Sent:</b> Sunday, March 13, 2022 12:28 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Powell, Darren &lt;<a href=3D"mailto:Darren.Powell@amd.com">Darr=
en.Powell@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit sol=
ution for vega10</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">=3D=3D Description =
=3D=3D<br>
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
&nbsp;&nbsp; linux: (<a href=3D"mailto:git@gitlab.freedesktop.org:agd5f">gi=
t@gitlab.freedesktop.org:agd5f</a>) origin/amd-staging-drm-next @ 6b6b9c625=
004<br>
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
2.35.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2619AC9ECB0F270EE0772030E41A9DM6PR12MB2619namp_--
