Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF00C388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7489C223C7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X0PgbRPH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7489C223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47976E195;
	Thu, 22 Oct 2020 05:01:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5FF6E195
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 05:01:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D91ToWcKqDRpcO1W+6gN6xtUe4HzC5c02ZVJ/IdfHqOQ9AeL2T48o4LK3FRNrEdO0OWH0Q7fye44cNUB+/lf8W560Hv+CwRciJuLA3eTGIYoz7oV/P3LJch+gq9iUZyvZnAw3/h/6MyNi5d4Q7zZ9WxRGK5mXX1KWZT+eJZpvdX4aPUJ3bAHrvOANG3lxzwBi3dGHybdAAwspAxzlFbarHcSdSX0lj0AnB5M+f0lxDnAx6Jlzkx2JqMfeE1beP6I6XS2MF+I7h/fukPL+pggp4Zlmfjk8UwtPuAz/gIvFnin+SjpM7z6pBmZNRIHRdItPJC+dM8uTO4mxVL7H6yJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHnTueZwpOzSN2zLTqWaoZp6LdZTdfxWVxEBldjhGEU=;
 b=Ih9M7WSBgyhPOvqoi8GwpjVdi9bbjv2Ugdt2aoeo4+OMj0n+XImeyUaXuLHMDLulIFoVJ0hBA5IOvNmsjAUu8T/iZLe+n/ZSCZFosBwfk8Zz3SxgZ8RCv1yYh6BI2sWt65xowatY3dg7TJaOi2/6X69bpCG56jWPsxHlqvFENpsrBramguwHMsLo/fMyfERod4+cbcmR8at9yA9ASZFxQF/DzwL2woHhx3ZVnZ1E1mDesek+wB9T3hrjjmt/gTiIls5lSnUYvyozpw44XRmnopDYgUcEYMsuYZzPTmGlWLh9k44tyoO3nwviCz4g2zDtOe0JmS09zhQnal18hLiQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHnTueZwpOzSN2zLTqWaoZp6LdZTdfxWVxEBldjhGEU=;
 b=X0PgbRPHYrGSTP409IG4CEJNUv8MKWwT3rd5r8MTHhL6cjWXBFwHvEHHVrGZ7jPYcftC5q3t+8K66q8MBRirM40jJftCvPA+y/0/5Un+3cXP4kwT1Kj59xGyrkNmLQIUPYV8paHmKQlxoa/ML90yG1sRkNW+optvU9PBv42kHB8=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 22 Oct 2020 05:01:44 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:01:44 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRggAALJOCAAA5hgIAAD3dwgAAEE4CAABf10A==
Date: Thu, 22 Oct 2020 05:01:44 +0000
Message-ID: <DM5PR12MB1657848807541F7E6214AC3D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
 <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <DM5PR12MB1657C41033410DB1F57995F28E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_MR3O_T-jSziUMdJWU=eipX+55Km3WSLzP9+Eudygayvg@mail.gmail.com>
 <DM5PR12MB165756ABF941252F123C03BD8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_M6V=-YDX5QJp-HEA2k=5HPh57zyj8tr+oVXgOo_sQUcg@mail.gmail.com>
In-Reply-To: <CADnq5_M6V=-YDX5QJp-HEA2k=5HPh57zyj8tr+oVXgOo_sQUcg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T05:01:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=68595d10-835f-471e-89a9-00005dc8e732;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T05:01:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b9139865-92cf-4585-beca-000095ebfe8f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54be36e7-0467-4110-dba7-08d876479241
x-ms-traffictypediagnostic: DM6PR12MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3739F02477C57DD2C7D837108E1D0@DM6PR12MB3739.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmc0+TO7P9073Ts6jNDjxbGcjZmE3KgWz/maY0nGeeGUERbvf4v+ALth2EVlxaJLFk8MZhbv/zLx6ZFK/vvKa1xS+GVSvIIhHxZ0zCKD1Si67ZAA2GXvAcYjz/HiGMsljm5CmElTc9pvqcrKHmLTCMI5l8BHz3gaeBXk26R+9PbPyaXWoqa5qnjtq6eamIYWTLvty2rUX2lp1Rhvrs5WAp5m3+NihHw/6rJPZIWYZDM0HYDJ1GiBqoA997sy4QUQFMwS4XKCwJkMARwaFrg4TElqTmiYsZVQdAd1g720OZxD21ucmKde4vvo1YMYXVLfHx3NOUDhyGl2tkTcIv36uS6EEXBFKgXTzHRrBJYlK/1Moq6RFvluH74SNyim8yDMs7XQm7ZmqFAijEeT/tfe+9CLp2Q7j61tYCT+HVucqkmFucf8ErDdOa6mUl+XFedA4eNZz1Ycp38RwIIiRuZKfg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(478600001)(8676002)(2906002)(45080400002)(8936002)(7696005)(71200400001)(86362001)(6506007)(53546011)(6916009)(4326008)(83380400001)(52536014)(5660300002)(33656002)(186003)(316002)(76116006)(26005)(64756008)(966005)(66946007)(66476007)(66556008)(54906003)(55016002)(9686003)(66446008)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: s6BYRHRylPjqYSKx7nAqGykbZnUxxBSpbCHpYQDqJyraFZM/0LAoNGKPm1Y4ASFtLWvHo8l6cNgThQoOV3+lDGdigZr9o+bl5TrmVjEbaTjH3ku3PTas7mlsIABp5Yvd9NQvnDbG+aCUBb2+tTSuiEN+QFDjFOgg8iysCg/vo3RDP2ehkMyJlqv9nYs/F6ods2dUu5MsGRhHKK9kZQmF8bf4cH+AaxEaQQU08RxPTuv/AEYi79FTwsT/dpeZc11oTRAgn49ClBg+Q6pigfKceXLV2T/UQIhIwhXl/oHRyvoalSED4EcXnap6MHCFOMbRdC+2eJ35bJGteGBkgL4a+bWFw6qsHASWuLQECF+5KQUtNwYuKqX4Kcw/XqBy/JNC5ASHYL7onXXmX5AvRB5mjR1S5Zw50nYq6aadSHg1PmWaKglUQNni3Uo9Ih0xGPmaTF9styN5rRxX5YaXZwEfEAeW3iciuNcx72gsrTSD36gXjMtY1g3lIMFx26GbyoRoprF+d9uN2J8fbxt01CBzkYAJ2yfoq2O5xgVHraOyWphkiJtPNeavOye3yrvQFGjOywC2rmb9VC6D02l6mw9Cy6rPJHXz8cVdv4j8NhMqNgk5r3XSdL/AN+QTa6Slgzh5h5DSAauxdU7xyKsYNC27Tg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54be36e7-0467-4110-dba7-08d876479241
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 05:01:44.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAI7IXc1RAgLgdXeMIcxTHCcAsn+v15pNIHX/KJWnHUPvbnPyNRBRozHBvW0nJSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3739
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
Cc: "Gao, Likun" <Likun.Gao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
The speed is not 0 in the below scenario if the rpm is got from the metrics table on navi10.
The possibility is that you were using an old firmware. The firmware on my system is 0x002a3e00
Can you remember the version when you saw the problem?
Thanks.
# echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1_enable
# echo 125 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
109






-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, October 22, 2020 11:28 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[CAUTION: External Email]

On Wed, Oct 21, 2020 at 11:16 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> After reboot, It is also not read back correctly as below.
> # echo 1 > 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_enable s# cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_input
> 183105
> # cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_enable
> 1
>

What about if you manually set the speed.  E.g., # echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
# echo 800 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_target
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_input

The problem I ran into on navi1x was setting the fan speed manually resulted in 0 for the fan speed in the metrics table.  E.g.,

# echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1_enable
# echo 125 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm1
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/pwm

See:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1164&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cfdef2561887a41322e2a08d8763a897b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389341097409110%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=M6EIZVH9vxUJw0d5eh%2B6VzYKQ0LEOwMRdAaEYzrU1d8%3D&amp;reserved=0

Alex


>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 22, 2020 10:18 AM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> <Likun.Gao@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
>
> [CAUTION: External Email]
>
> On Wed, Oct 21, 2020 at 9:30 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi Alex,
> > Navi10 also has this problem as below.
> > # cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > .0
> > /hwmon/hwmon3/fan1_input
> > 1217
> > # cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > .0
> > /hwmon/hwmon3/fan1_enable
> > 0
> > # echo 1 >
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > .0
> > /hwmon/hwmon3/fan1_enable # cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > .0
> > /hwmon/hwmon3/fan1_enable
> > 1
> > s# cat
> > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00
> > .0
> > /hwmon/hwmon3/fan1_input
> > 183105
> >
> > In AGM, the rpm is 1800.
>
> Does it read back correctly if you manually set the fan rpm first before reading it back?
>
> Alex
>
>
> >
> >
> >
> > -----Original Message-----
> > From: Feng, Kenneth
> > Sent: Thursday, October 22, 2020 9:11 AM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > <Likun.Gao@amd.com>
> > Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > fan1_input
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi Alex,
> > Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
> > An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
> > But the fan1_input shows about 180000, which is way more than the real value.
> > If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
> > I can double check the navi10.
> > Thanks.
> >
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, October 22, 2020 2:47 AM
> > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > <Likun.Gao@amd.com>
> > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > fan1_input
> >
> > [CAUTION: External Email]
> >
> > On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > >
> > > > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > > > >
> > > > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > > > since the fan speed in the metrics table always reflects the 
> > > > > real fan speed,we can fetch the fan speed for both auto and manual mode.
> > > > >
> > > > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > > >
> > > > NACK.  At least on the navi boards I have, the metrics table fan 
> > > > speed reads back 0 when the fan is in manual mode.  That's why I 
> > > > changed this in the first place.
> > >
> > > Nevermind, I was thinking about navi1x.  If this is working 
> > > correctly on sienna cichlid, please ignore me.
> >
> > That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?
> >
> > Alex
> >
> > >
> > > Alex
> > >
> > >
> > > >
> > > > Alex
> > > >
> > > >
> > > > > ---
> > > > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git
> > > > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > index 496abc31b07e..27b6cade9ade 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > > > >         if (!speed)
> > > > >                 return -EINVAL;
> > > > >
> > > > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > > > -       case AMD_FAN_CTRL_AUTO:
> > > > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > -                                                          METRICS_CURR_FANSPEED,
> > > > > -                                                          speed);
> > > > > -       default:
> > > > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > > > -       }
> > > > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > +                                               METRICS_CURR_FANSPEED,
> > > > > +                                               speed);
> > > > >  }
> > > > >
> > > > >  static int sienna_cichlid_get_fan_parameters(struct 
> > > > > smu_context
> > > > > *smu)
> > > > > --
> > > > > 2.17.1
> > > > >
> > > > > _______________________________________________
> > > > > amd-gfx mailing list
> > > > > amd-gfx@lists.freedesktop.org
> > > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2
> > > > > F%25
> > > > > 2F
> > > > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=
> > > > > 04
> > > > > %7
> > > > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d875f1b05
> > > > > 0%
> > > > > 7C
> > > > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389028190609906%
> > > > > 7C
> > > > > Un
> > > > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi
> > > > > I6
> > > > > Ik
> > > > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbNvNPQlT
> > > > > ot
> > > > > mE
> > > > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
