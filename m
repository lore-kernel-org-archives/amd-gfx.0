Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D052C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 01:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4FF223BF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 01:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BAX0kCfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4FF223BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 791C56E84B;
	Thu, 22 Oct 2020 01:30:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F356E84B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 01:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQsP9wJBdUGKeglfTpKIWWgPXdh6f/wq6JRBX2lVUbkM7a5iKp+5aV9XClfNROPdoVwEci3ZR1oLoF1ydIplR2yQhmB4e5vv1aDFoq7N2GqoloQOL7XneCWg/CKMSBRbdDig15VKuzBbloJODBIcQbKgK8eTxKgFeZvqIeDXp4Os/Vg77QEoHG3KZebrebWKEEDchNPgORI8AhFhWKoaH+lKSOSP+CdysXzMoknqQmqW5lSXrvFdiM9xMVyrTBiPZM8NME+hXyGeeH5aiuPFHmRxegbWhQQBIeBqjV1XPujU7ad90qvxNeVfjPiav0JK8ERjiWROXPXwNyFVZpjwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xspb/rWOjlof8AX57gHBnPzLvCzXlW3lnbMsRKFoEm0=;
 b=nP4pMN22DV+uI8LqmBr4K/BQ8s8/4vkk7zJYMKVx3TYtPvHtkI/6ow+VCKikLspHRuAagLT1PjRR1POBY0/T6HxFtlwb+MIoN5W78luvCgY7+Ri4sTUi3inUuJEgORsGN0XPpYqymq8f8nTknmHAE3WXcgk/z784j/V0hL0FMabdkQMkQeSU5Fs0iNhTM255wguqqecUn2A/3RNx7liu0x4YEUorDGC24v3qX2splKmHeP/HnuWqxaT1GKg8bTLTIXYmTjW1bhzQOaBhRUH8iT+n8ikwEkZHuEbV42jexkHzwXkfF/5LXh1HPAaYkfi59mNxmQ40sqlexqwTlZZ4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xspb/rWOjlof8AX57gHBnPzLvCzXlW3lnbMsRKFoEm0=;
 b=BAX0kCfPvfWrMYTZV/Zbx99UKekIK++MQdmd62gpv92miegyd0pPaEg2wUN+m1oI5RWHOUkmOtSDsPrN8r8zlHF9L/HTGFWpQldvSPUWD2RC50gW8ycZJuLOShGboog4M24KDfNV5gr16OFVDg9PyldUMyC2sIa4jvvtcMzXy8E=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Thu, 22 Oct 2020 01:30:25 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 01:30:25 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRggAALJOA=
Date: Thu, 22 Oct 2020 01:30:25 +0000
Message-ID: <DM5PR12MB1657C41033410DB1F57995F28E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
 <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T01:10:37Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fe1b1728-1b86-4958-9e26-00002e741fc6;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T01:30:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 3ee41ca2-c30d-4d8a-a1ee-000028761137
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79cf44b3-bb69-4257-4ee6-08d8762a0d2c
x-ms-traffictypediagnostic: DM5PR12MB1338:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1338CEEF06C97835DA8F02C48E1D0@DM5PR12MB1338.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PFn+L/KpixKhWBUnovYrePgdEBFL4/sn3P85Ng2CjWReYmGoq8grZl7fP5Me4D+6aY6DSxAgA7PlUQjQDDPVUtk8G7y8cBI9FF6/2n2UzgdSPhIWHivnfc1TVhTjNmjO3aCha9vPuVWQoAMVDQ8+L40AYupfuPE4iPc8Tw3tuoh5R7F2VVadJBZdRhDNzq9/T4JVdrEyCWe9IQqwnJoyDIIdHVDHckByjCgN6nwcayd2U3s9s3gFdhjAVyJ8yUN6dvXY6YD9euB2cyCluppoZ4RbY/c6FYbJFQZq1XruSN+pbjIEgS67v6QmZxVAcvWmaVOnFfISKgliHPB01K9BdsTwHtlSRgFuSDxrSZNAz7AE4Ha1OUc41DR+s1xZh0cbZR3yXMPIY3ZuSuqPAm+3mzTO+kKh+mb3GRv34ddV5EdZzG6IdvDRjxfgT+n6HxjvypIw65L6es69DJlGwCn06w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(71200400001)(186003)(83380400001)(9686003)(66476007)(64756008)(66946007)(7696005)(2906002)(55016002)(76116006)(66446008)(66556008)(2940100002)(8676002)(966005)(8936002)(26005)(5660300002)(6506007)(316002)(86362001)(52536014)(45080400002)(6916009)(4326008)(478600001)(54906003)(53546011)(33656002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: h6oj/bQKGMalzXCuZ2P8+KnnERMtlgyl1iyWKr732Jnno4edu5axp5A9ZYRwawFCxr4IaY+hK10aBBKkcs69w42FYoyIQVQNRWRfO0fXVg+QblAE/WDoRZC/SXrny/Vw7C9NzIhh0PnDuMIlFYrn34C7bvoc2EBig4nifwVHTMOHwq1A3va0HXQmIgNr+B9b0u3lVKK0C0LS3NL+1Ix1VoKbvw2aTdGKfzjmY4yHTYHnORdYJopZbwWJalwcOW6btwkVlaEEb39+QEn6Fu7kbM6YjYWQxbvzerd4Rx55bW2+8TTfgEFzNLUPm24zYcP+zDd0sBTEfqsnDltZARjzSJUmFazCVBRAtAUYDO4gamUA9deSQfxwgoDL3CPsrBGJKxb/GmKMkN2yMHtR5aECHvF46C8Z15tKJ0WuCoX4NAgEW29ZyKPdZAAhYXlbrYQkaiKXsqFMvloGuXtoBf+mbOeGsYQXtQRtbEYhKuTp2Ax06yoCfTSQZvrKi8/9tt+eon9dRU/CgcH0OLi/H8E+mRx6T466pdrGanRAwB/GBSGPmyFshpDVgcWiB3Nmt1fdo7gYuGxF9avpcOtsHFRk7k7On7TtAzp+/KU9+ReIxhF3YVSIIwQwYSiAUEAE+PN1HhlusTj+q/qTgAmyI3Ongg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79cf44b3-bb69-4257-4ee6-08d8762a0d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 01:30:25.4166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJeDLQUsqStrBsPDAa2e/N0jWSuHKoE1Q4++em7lW6zpg0kVq6+/bx8OpDDj+RwM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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
Navi10 also has this problem as below.
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_input
1217
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
0
# echo 1 > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_enable
1
s# cat devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:00.0/hwmon/hwmon3/fan1_input
183105

In AGM, the rpm is 1800.



-----Original Message-----
From: Feng, Kenneth 
Sent: Thursday, October 22, 2020 9:11 AM
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,
Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
But the fan1_input shows about 180000, which is way more than the real value.
If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
I can double check the navi10.
Thanks.


-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, October 22, 2020 2:47 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[CAUTION: External Email]

On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > >
> > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > since the fan speed in the metrics table always reflects the real 
> > > fan speed,we can fetch the fan speed for both auto and manual mode.
> > >
> > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> >
> > NACK.  At least on the navi boards I have, the metrics table fan 
> > speed reads back 0 when the fan is in manual mode.  That's why I 
> > changed this in the first place.
>
> Nevermind, I was thinking about navi1x.  If this is working correctly 
> on sienna cichlid, please ignore me.

That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?

Alex

>
> Alex
>
>
> >
> > Alex
> >
> >
> > > ---
> > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > >
> > > diff --git
> > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > index 496abc31b07e..27b6cade9ade 100644
> > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > >         if (!speed)
> > >                 return -EINVAL;
> > >
> > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > -       case AMD_FAN_CTRL_AUTO:
> > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > -                                                          METRICS_CURR_FANSPEED,
> > > -                                                          speed);
> > > -       default:
> > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > -       }
> > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > +                                               METRICS_CURR_FANSPEED,
> > > +                                               speed);
> > >  }
> > >
> > >  static int sienna_cichlid_get_fan_parameters(struct smu_context
> > > *smu)
> > > --
> > > 2.17.1
> > >
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7
> > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d875f1b050%7C
> > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389028190609906%7CUn
> > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbNvNPQlTotmE
> > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
