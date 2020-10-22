Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224FC388F2
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D1AD2063A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 03:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MNacDDcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D1AD2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 472516E042;
	Thu, 22 Oct 2020 03:16:22 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 186D96E042
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 03:16:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJgtaQIhT4ohKPcgCuQ3XKoLwcaiQ+bJEpe7gJya0rgUkEjiEhkZxGbATn/ngmyV53Py1Y4OWlssMTZfYLo5SykFj4J+Aux58OmEpdQqvEcMUBErM1vK9J9l+hQh3uVkjLyimnSo3dbiRTM8g1fvyI03/K1V1isQsMQE4G/cRGS58YblcC5uPVfqRJXn8DUSKHPeaAPHgHcS9krcQJG9wFYwOBwCTMPfogOmr8T44GqpG8jEBa7Jvta5Se2jvqLGIg9IvGDRspaIUyc9a73Qt4vTzZoniHeSvoA3sUa+PB0QszPCi+jPQPKEN+p4tkUAXaj3OVqg2q8o9u032jGbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8k3Lkqh3k+dXvhRYV0LOAKXeIT0GInkAYCtl/I2vqw=;
 b=REtZPS3MpJvg0NA+jDbBI6DnllGtOgqROcMqZHNDYSepTOWlJcA5wLrJGjW3zQCHylYDlLl6tRfBD7DF+1F88Kzr0y61WhEJq8BMT5Dl1glJx1bAwNbgXdcLqk8a/PddlW9ll1jJA0kwhJ85ysA+OxfidvKht8Fs7VyqXOtbU+lTcfOc9c+2nxuPxfqSOAD3QNuMeg53mTKMPlzZ+SCrvSbJgmtpawOTwraEVgYDMGG7un5N3w30PGQbR7e73jz/ogGH/xShQvCdPBSrdnMvi792rX/+n9rrC2vbLVzD9+03a+NFFnM6Fwlxk74ql2XYMuTyl0B4mHUTla4NxCHPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8k3Lkqh3k+dXvhRYV0LOAKXeIT0GInkAYCtl/I2vqw=;
 b=MNacDDcdfaajRipU6yiQJz3FXrmtYjTdgk9y/8+5eup3CNWCt3c4EdBz3DZSq2WCKdEN/v66U+tXgqOq5XlpBx/HqFUGLwAMP1/WDHdjBrlVokOQX6hszhzCToK0/bHMdcy8DfgLeonfuJOcTIzKmjkY8gMsNrb08uqIwCdw0Wk=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 22 Oct 2020 03:16:19 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 03:16:19 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRggAALJOCAAA5hgIAAD3dw
Date: Thu, 22 Oct 2020 03:16:19 +0000
Message-ID: <DM5PR12MB165756ABF941252F123C03BD8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
 <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <DM5PR12MB1657C41033410DB1F57995F28E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_MR3O_T-jSziUMdJWU=eipX+55Km3WSLzP9+Eudygayvg@mail.gmail.com>
In-Reply-To: <CADnq5_MR3O_T-jSziUMdJWU=eipX+55Km3WSLzP9+Eudygayvg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T03:16:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d230d35b-9a7a-4e9d-8024-0000ed762e80;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T03:16:14Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3280d697-4c81-4877-b372-0000ed8606a5
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed8d152d-9ba2-41d8-9c7c-08d87638d867
x-ms-traffictypediagnostic: DM6PR12MB2809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2809855DD05346319787BD218E1D0@DM6PR12MB2809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGIu72Af/6atcQ+xfSNqPcfVGe5WI+saUuMC/wz1125X1bMjpM/vx/eBMkRG6gKV4oaVpuyDWkhPkrpEjToBLECh4ODihJbOBiutvXK9hQPFHP2GYlGWVt6kK+Hw2PfvwpFlw3flg5mTXMGv9xoOUCJefcQ6kflGABvM69o130N2L+gcE4JSCU0D6Ntzwdx0b64/SX8plCJS+ZkmRi4UYWHrVacv0Lf5l60ewRSnaDbHfNyrxpGg2GkNcV1rCkFVpUewRJ8O9hDsqPMFmZny/Msq4jaLW98mpcPbgXrDDhG0oMQny60cBnECxKuZ2gLDVZehRZJTCW8ozXOk4esdxEJp4Z9tj8beSHKUYSFhgPmUw4sAN5smKmRGXjR3g/AMIrDpx6aV/6jsIYiFvQ/INVDm4gde+3hupxrMTkV3BURKssCnGrs8VH8zDrVDoUsDuyT7a81vVyRhGKIXiZsqEw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(186003)(26005)(53546011)(4326008)(71200400001)(8936002)(45080400002)(9686003)(7696005)(54906003)(966005)(52536014)(478600001)(86362001)(5660300002)(66446008)(76116006)(66556008)(83380400001)(2906002)(316002)(66476007)(55016002)(33656002)(6506007)(8676002)(6916009)(64756008)(66946007)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: JEljfp/lun9cvdLqFdRKMq3ebeXoSWaw2OBOASciQhMnY6zNog3Yw94m0JWxlljJhAxBY+TGp+3BEFxDTYXFMH32V8qYV+hBrEelXB/7dfl45cB4nhr+qpi7oA4BjdbnrnXMW1vUqAIFa1sVPEhw6xPHb1OVH8qAetTWqp//kaVrdLaXF92IMdJRYhAaN7LeXwWzv3pgrCBapRg/7703fdei1O5+QG1Vt0R9OWU5YCDZ2Js377phPwe+rz8qJyIDUetQjAYAeZ9YhEQlvMPOrk3oDR+Ff/mbdj45bHtNcnfm5gjEziHGJmb0ypYH+lo+fpEvC5vfb/U97S9PJxEJSNVfps4KkoswqBmwLYbRuegLK7kHaX1zzKBQ8tNDKgWmUzi+Z4PYqyl+CN4M/C1cOg7VL1d844AjsStPFtEN/3xKZ9q0zSOe3GKj15+vpYc0bBpeUT556k1cWHnZTv2QVjWXJJyKdtNp2iXT9Qkkfuu+g60uFbAs1LIF8fV7t+P19uZ+gsoQ9y/dYongbbKJ0RxbpYHKacV8Jc8Ba/NL/YUM7PPgEy94HyKqOBwz1FRxjaGUow4mPRQSBXQ1CbHXUEYXLw4sCqZ8w36swCWQUl2X3srP3+oHU8j9WsLDX1EDg8Pgoz8KXkAH/o9T83B+WQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed8d152d-9ba2-41d8-9c7c-08d87638d867
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 03:16:19.2091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjBiDCVbc/CfCigVlmJOe7L+NP0FdxiHioskZQSjl8P4lOAVbSU02HZW0v/NiqKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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
After reboot, It is also not read back correctly as below.
# echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
s# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_input
183105
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
1



-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, October 22, 2020 10:18 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[CAUTION: External Email]

On Wed, Oct 21, 2020 at 9:30 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> Navi10 also has this problem as below.
> # cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_input
> 1217
> # cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_enable
> 0
> # echo 1 > 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_enable # cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_enable
> 1
> s# cat 
> devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0
> /hwmon/hwmon3/fan1_input
> 183105
>
> In AGM, the rpm is 1800.

Does it read back correctly if you manually set the fan rpm first before reading it back?

Alex


>
>
>
> -----Original Message-----
> From: Feng, Kenneth
> Sent: Thursday, October 22, 2020 9:11 AM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> <Likun.Gao@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
> Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
> An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
> But the fan1_input shows about 180000, which is way more than the real value.
> If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
> I can double check the navi10.
> Thanks.
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, October 22, 2020 2:47 AM
> To: Feng, Kenneth <Kenneth.Feng@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> <Likun.Gao@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
>
> [CAUTION: External Email]
>
> On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > > >
> > > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > > since the fan speed in the metrics table always reflects the 
> > > > real fan speed,we can fetch the fan speed for both auto and manual mode.
> > > >
> > > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > >
> > > NACK.  At least on the navi boards I have, the metrics table fan 
> > > speed reads back 0 when the fan is in manual mode.  That's why I 
> > > changed this in the first place.
> >
> > Nevermind, I was thinking about navi1x.  If this is working 
> > correctly on sienna cichlid, please ignore me.
>
> That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?
>
> Alex
>
> >
> > Alex
> >
> >
> > >
> > > Alex
> > >
> > >
> > > > ---
> > > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git
> > > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > index 496abc31b07e..27b6cade9ade 100644
> > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > > >         if (!speed)
> > > >                 return -EINVAL;
> > > >
> > > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > > -       case AMD_FAN_CTRL_AUTO:
> > > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > > -                                                          METRICS_CURR_FANSPEED,
> > > > -                                                          speed);
> > > > -       default:
> > > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > > -       }
> > > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > > +                                               METRICS_CURR_FANSPEED,
> > > > +                                               speed);
> > > >  }
> > > >
> > > >  static int sienna_cichlid_get_fan_parameters(struct smu_context
> > > > *smu)
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org
> > > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%
> > > > 2F
> > > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04
> > > > %7 
> > > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d875f1b050%
> > > > 7C 
> > > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389028190609906%7C
> > > > Un 
> > > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > > > Ik 
> > > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbNvNPQlTot
> > > > mE
> > > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
