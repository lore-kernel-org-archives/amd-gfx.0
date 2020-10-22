Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6553C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 06:10:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 571312245D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 06:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JlWAvWNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 571312245D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82516F3AD;
	Thu, 22 Oct 2020 06:10:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E1F6F3AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 06:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq2wdlbNccHD3ztnkTpeT6OvECKIjq+KLcDKMc5skP86SZX72JBTm7YXJD7ByMe7C6trl19Yg9IobaNHXnKI6hvxN+d5VNmjwXjV/857DvEdgmckqbgB997hBovdLb6MeTdhfIuoN7sk9AJNM6mS72DWsnWtnOv+itfOLuCXOtRuKFh0Sr7vi7QUXphNp8zKXJPobiBAZy+g7VLSkOLADcQx1RIUiJBes7egv7brjNCalewql1A4fwEep+px5sUa9yfo1y7hDskKn5qYPphm2eAhNhxU1RoIssGGb8+SuQoLA+Obe0l7DD8lFuu39gZwZUxZNxF8QkGMh1Ei4ZjBzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnEz9MFHey88a2tUamBmE/M/7BZegOORh0croe8sBtc=;
 b=AyxIpfLGu2oqpEUEIr49+flNQ679f90T8whK0yJdaEZtUCYTKYeLjlWzJuoWyPQxib2RmjvX1KkLYQzGr2PJ6bcgDygp754BD/OFCwOVjTb9Hz9Pf2F4H5pf/yvnrUeoSdq+TgHl8m4YKmv3WB9ls/cQAbGrnvOXKNwUCn0C6tK9QGC2LqP+Ud5N0UtjUjKWmjd0+4/TtRN02k2lhZlckyMuPKz7s/YhjEDT7AmmJcvjNAKIUqvcPPtEZCFp/BKSeMbcTMQ5PRvV66X9B9ywtl/XJjw91HwKbH/EPhvjkR+bfAaIIRL2N5uo1OChCWq8MUbhDYvKIE8fQIVSVkZPmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnEz9MFHey88a2tUamBmE/M/7BZegOORh0croe8sBtc=;
 b=JlWAvWNUGMj0nfz4Z2V7R/rZ+Ywt2h+j2ueF97MXwifQCo4dvATxtjlfBpTLOf+XBj9oeqyFDF8PAq5CAEvFOSaGIBRP/TazZI5QqbW49MXs7oWeiKHv4nb8zpPySQgkcZlFMgYKcuRMLCAFz9GRaEFcWeAwHDDOFL0heSjwNyY=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (10.172.38.149) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 22 Oct 2020 06:10:21 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 06:10:21 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRggAALJOCAAA5hgIAAD3dwgAAEE4CAABf10IAAAziAgAAAUYCAAAOJAIAADOJw
Date: Thu, 22 Oct 2020 06:10:21 +0000
Message-ID: <DM5PR12MB165725B0FC52EA5F5BBD1BFB8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201021064455.14935-1-kenneth.feng@amd.com>
 <CADnq5_PdS8M3i9uQ3JTUE-idGJxVCk_k5N=Sgvsj4VJGFKn_vA@mail.gmail.com>
 <CADnq5_NLyQ2jOW0ZkYMXcAX-snqHvUzNRYtrDRZbhN7qe0_5Zg@mail.gmail.com>
 <CADnq5_M_ry9EHp2b1ycBzD4oTsfVJxFtSGoRvq2EfJiN6Qczmg@mail.gmail.com>
 <DM5PR12MB16579B5849FB6719ADFE7C2D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <DM5PR12MB1657C41033410DB1F57995F28E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_MR3O_T-jSziUMdJWU=eipX+55Km3WSLzP9+Eudygayvg@mail.gmail.com>
 <DM5PR12MB165756ABF941252F123C03BD8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_M6V=-YDX5QJp-HEA2k=5HPh57zyj8tr+oVXgOo_sQUcg@mail.gmail.com>
 <DM5PR12MB1657848807541F7E6214AC3D8E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
 <CADnq5_PhA1bJp-3Pctjn_L9=TFU=y_Kuw7Sz42Tcdv1VoiUz8Q@mail.gmail.com>
 <CADnq5_OjACqye7L_EdbYusTTmT5oTHmMctOr0ubyHm6PtuhT5g@mail.gmail.com>
 <CADnq5_Ms5GDsOiqMRWcimgTGJzZaBWjnVf2zcFLeX0xPRZbCww@mail.gmail.com>
In-Reply-To: <CADnq5_Ms5GDsOiqMRWcimgTGJzZaBWjnVf2zcFLeX0xPRZbCww@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T06:10:13Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dfd7a86c-7fba-4489-88c7-0000f003d26f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T06:10:13Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d80ce017-caa0-463b-bd21-0000c3830b9d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d12dffd-f539-4735-c05d-08d876512889
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2603E27AF9942A98A12061048E1D0@DM6PR12MB2603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rPiDULXASrlsPSNxzVCKl/kwnGq8iXC4yVGqSzXmGNHm1MomT40cwtbmF7CfEeJP6cQf89F750xgyZ3CkvneYC4EEL7S2J+ynHJQYocdXvdL9IVLZbcNRN5cUIjk+91izaMK3CQNrX8vTdPGna6YSWAXtpPupd1zVI7gKJEhLT+2KAyFlW08d+tU0lG0KLFJiZa76XPrhcnDCRqhJmCO9uhg9Hz5mOz2CYlcXfc3NRwJI2aguNWdt4jReL33pRNG33sthYOhDDPGWC3H8Xj6GmGbZFqoNvnIax7k6poOfIaYZpU0+dpuOu48Vb13NSLeQPnkq41HDXh1z9PvJF60bzWSkfEgrB3++mJs3M/Bo/CVt6ql6tP99W40vj/+D4yx1g5QWo51BBgDLAdmktD3Q5zb5RZsOrpXiM2kq/ZDWOJtINsTWL/R0obFHbiq8g5cP3Cyvroy+m5CCwAufOvw5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(54906003)(966005)(66476007)(66446008)(6916009)(66556008)(52536014)(66946007)(8936002)(76116006)(316002)(8676002)(55016002)(53546011)(6506007)(5660300002)(64756008)(86362001)(2906002)(4326008)(186003)(83380400001)(7696005)(9686003)(45080400002)(30864003)(71200400001)(33656002)(26005)(478600001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: U1wHIyrEMN/SOxE3mkHqXdpdGGA/dWoyMhuurz4Rq1Vh2DPne9OAoKjYcoC6yjfOAGDb3XexYzDMaLpnXpFMADGFoxamfXs3dJQsiVgnwaj1PlDC3S95uGsI4kZN9kj0pMwa77gXYYxg2nExku/tF7medGBqQGm/A6+q56Jn5gXbLytBlVOL/9vQSvi6cGag/z6lg4ecIV+exHEh4g7WsZ1kTRln1Tm3wycw2VxkYsf9h8hAZsRheobE8uhUrs+lt5aisdY9/Pg1XI1MdJ3fI4J1mz9nEpu5eAI0XJdNumJzT7AvpJp9LFmXoiA4vFZoqUdLAKG0WmM6tc9LT3g3Sr9qmto2sIEpfcKi1Ms/uJWyKAx88Jcnw+TW0PQ02AZUdQr/1poAUgZ39mzzh8gcTQBbaoPh1OkXTEHvNdbXW/hF43H4RosC73GkuY1Llc5DisLCOxd8/e94EnwyZpdu8U78wFRt6CCKB0zfIVH2douBfG/xZUN4fwdYPxjO9StWrl7iAW34AgvB82Wcg0PZWO2RD/w+5iUiI5XXTV935zQCizTx5qy56u0VsM3tgsjvqmR7TZKYexBfjUfFn+mE8D/IlhQUncvDoaTTwAv/dYff2oI4cMVAC6Sf3pYZfB0cSM/hgK0CREbOk3v95FOaCg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d12dffd-f539-4735-c05d-08d876512889
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 06:10:21.6680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPhtkvmziR6cOQabt9nCR/MK4WpdN6srZYeX1Qym5HfHhs+ik8vVkYm5haCZfaWS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
As I confirmed, this is Arcturus specific.
On Arcturus we don't have fan control feature and the fan speed is always 0 from the metrics table.
For navi series, I'm sure we don't need it. Looks like we can't just revert it.
Thanks.



-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, October 22, 2020 1:19 PM
To: Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun <Likun.Gao@amd.com>
Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input

[CAUTION: External Email]

On Thu, Oct 22, 2020 at 1:06 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Oct 22, 2020 at 1:05 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 1:01 AM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> > >
> > > [AMD Official Use Only - Internal Distribution Only]
> > >
> > > Hi Alex,
> > > The speed is not 0 in the below scenario if the rpm is got from the metrics table on navi10.
> > > The possibility is that you were using an old firmware. The 
> > > firmware on my system is 0x002a3e00 Can you remember the version when you saw the problem?
> >
> > SMC feature version: 0, firmware version: 0x002a3600
>
> Actually, I'm not sure.  It might have been updated since the last 
> time I tested this.

If you can confirm it's working on all the asics with the latest firmware, maybe it makes more sense to just revert this commit:

commit 3033e9f1c2de0eca89e9a98c7e307820f3fc953e
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Thu Aug 27 00:12:38 2020 -0400

    drm/amdgpu/swsmu: handle manual fan readback on SMU11

    Need to read back from registers for manual mode rather than
    using the metrics table.

    Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1164&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7C7b20871a843e41a5038408d8764a0d51%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389407704795887%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2jEFoU62zbGIwEACv3C6xAmyNgIQ4q1kbBfNQ3Ztm7E%3D&amp;reserved=0
    Reviewed-by: Evan Quan <evan.quan@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Alex
>
>
> >
> > Alex
> >
> > > Thanks.
> > > # echo 1 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm1_enable # echo 125 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm1 # cat 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm1
> > > 109
> > >
> > >
> > >
> > >
> > >
> > >
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Thursday, October 22, 2020 11:28 AM
> > > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > > <Likun.Gao@amd.com>
> > > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > > fan1_input
> > >
> > > [CAUTION: External Email]
> > >
> > > On Wed, Oct 21, 2020 at 11:16 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> > > >
> > > > [AMD Official Use Only - Internal Distribution Only]
> > > >
> > > > Hi Alex,
> > > > After reboot, It is also not read back correctly as below.
> > > > # echo 1 >
> > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:0
> > > > 4:00.0 /hwmon/hwmon3/fan1_enable s# cat
> > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:0
> > > > 4:00.0
> > > > /hwmon/hwmon3/fan1_input
> > > > 183105
> > > > # cat
> > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:0
> > > > 4:00.0
> > > > /hwmon/hwmon3/fan1_enable
> > > > 1
> > > >
> > >
> > > What about if you manually set the speed.  E.g., # echo 1 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/fan1_enable # echo 800 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/fan1_target # cat 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/fan1_input
> > >
> > > The problem I ran into on navi1x was setting the fan speed 
> > > manually resulted in 0 for the fan speed in the metrics table.  
> > > E.g.,
> > >
> > > # echo 1 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm1_enable # echo 125 > 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm1 # cat 
> > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000:04:
> > > 00.0/hwmon/hwmon3/pwm
> > >
> > > See:
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F
> > > gitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1164&amp;data=04
> > > %7C01%7CKenneth.Feng%40amd.com%7C7b20871a843e41a5038408d8764a0d51%
> > > 7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637389407704795887%7C
> > > Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6
> > > Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=2jEFoU62zbGIwEACv3C6xAmyNg
> > > IQ4q1kbBfNQ3Ztm7E%3D&amp;reserved=0
> > >
> > > Alex
> > >
> > >
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Thursday, October 22, 2020 10:18 AM
> > > > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > > > <Likun.Gao@amd.com>
> > > > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > > > fan1_input
> > > >
> > > > [CAUTION: External Email]
> > > >
> > > > On Wed, Oct 21, 2020 at 9:30 PM Feng, Kenneth <Kenneth.Feng@amd.com> wrote:
> > > > >
> > > > > [AMD Official Use Only - Internal Distribution Only]
> > > > >
> > > > > Hi Alex,
> > > > > Navi10 also has this problem as below.
> > > > > # cat
> > > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000
> > > > > :04:00
> > > > > .0
> > > > > /hwmon/hwmon3/fan1_input
> > > > > 1217
> > > > > # cat
> > > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000
> > > > > :04:00
> > > > > .0
> > > > > /hwmon/hwmon3/fan1_enable
> > > > > 0
> > > > > # echo 1 >
> > > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000
> > > > > :04:00
> > > > > .0
> > > > > /hwmon/hwmon3/fan1_enable # cat
> > > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000
> > > > > :04:00
> > > > > .0
> > > > > /hwmon/hwmon3/fan1_enable
> > > > > 1
> > > > > s# cat
> > > > > devices/pci0000:00/0000:00:01.1/0000:02:00.0/0000:03:00.0/0000
> > > > > :04:00
> > > > > .0
> > > > > /hwmon/hwmon3/fan1_input
> > > > > 183105
> > > > >
> > > > > In AGM, the rpm is 1800.
> > > >
> > > > Does it read back correctly if you manually set the fan rpm first before reading it back?
> > > >
> > > > Alex
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > > -----Original Message-----
> > > > > From: Feng, Kenneth
> > > > > Sent: Thursday, October 22, 2020 9:11 AM
> > > > > To: Alex Deucher <alexdeucher@gmail.com>
> > > > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > > > > <Likun.Gao@amd.com>
> > > > > Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > > > > fan1_input
> > > > >
> > > > > [AMD Official Use Only - Internal Distribution Only]
> > > > >
> > > > > Hi Alex,
> > > > > Right, smu_v11_0_get_fan_speed_rpm() is not correct for sienna cichlid when it's in manual mode.
> > > > > An example is that in my system, the rpm is about 1800 in manual mode, confirmed with AGM and the internal smu fw scoreboard.
> > > > > But the fan1_input shows about 180000, which is way more than the real value.
> > > > > If you see the value from the metrics table is 0 on navi10, maybe it's the real rpm since we still have 0 rpm feature.
> > > > > I can double check the navi10.
> > > > > Thanks.
> > > > >
> > > > >
> > > > > -----Original Message-----
> > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > Sent: Thursday, October 22, 2020 2:47 AM
> > > > > To: Feng, Kenneth <Kenneth.Feng@amd.com>
> > > > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Gao, Likun 
> > > > > <Likun.Gao@amd.com>
> > > > > Subject: Re: [PATCH] drm/amd/pm: fix the wrong fan speed in 
> > > > > fan1_input
> > > > >
> > > > > [CAUTION: External Email]
> > > > >
> > > > > On Wed, Oct 21, 2020 at 9:40 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 21, 2020 at 9:01 AM Alex Deucher <alexdeucher@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 21, 2020 at 2:45 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
> > > > > > > >
> > > > > > > > fix the wrong fan speed in fan1_input when the fan control mode is manual.
> > > > > > > > the fan speed value is not correct when we set manual mode to fan1_enalbe - 1.
> > > > > > > > since the fan speed in the metrics table always reflects 
> > > > > > > > the real fan speed,we can fetch the fan speed for both auto and manual mode.
> > > > > > > >
> > > > > > > > Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> > > > > > >
> > > > > > > NACK.  At least on the navi boards I have, the metrics 
> > > > > > > table fan speed reads back 0 when the fan is in manual 
> > > > > > > mode.  That's why I changed this in the first place.
> > > > > >
> > > > > > Nevermind, I was thinking about navi1x.  If this is working 
> > > > > > correctly on sienna cichlid, please ignore me.
> > > > >
> > > > > That said, I don't see why the current code should not work.  Maybe a bug elsewhere?  Is smu_v11_0_get_fan_speed_rpm() incorrect for sienna cichlid?
> > > > >
> > > > > Alex
> > > > >
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > >
> > > > > > >
> > > > > > > Alex
> > > > > > >
> > > > > > >
> > > > > > > > ---
> > > > > > > >  .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 11 +++--------
> > > > > > > >  1 file changed, 3 insertions(+), 8 deletions(-)
> > > > > > > >
> > > > > > > > diff --git
> > > > > > > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.
> > > > > > > > c 
> > > > > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.
> > > > > > > > c index 496abc31b07e..27b6cade9ade 100644
> > > > > > > > --- 
> > > > > > > > a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.
> > > > > > > > c
> > > > > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_
> > > > > > > > +++ ppt.c
> > > > > > > > @@ -1171,14 +1171,9 @@ static int sienna_cichlid_get_fan_speed_rpm(struct smu_context *smu,
> > > > > > > >         if (!speed)
> > > > > > > >                 return -EINVAL;
> > > > > > > >
> > > > > > > > -       switch (smu_v11_0_get_fan_control_mode(smu)) {
> > > > > > > > -       case AMD_FAN_CTRL_AUTO:
> > > > > > > > -               return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > > > > -                                                          METRICS_CURR_FANSPEED,
> > > > > > > > -                                                          speed);
> > > > > > > > -       default:
> > > > > > > > -               return smu_v11_0_get_fan_speed_rpm(smu, speed);
> > > > > > > > -       }
> > > > > > > > +       return sienna_cichlid_get_smu_metrics_data(smu,
> > > > > > > > +                                               METRICS_CURR_FANSPEED,
> > > > > > > > +                                               speed);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static int sienna_cichlid_get_fan_parameters(struct
> > > > > > > > smu_context
> > > > > > > > *smu)
> > > > > > > > --
> > > > > > > > 2.17.1
> > > > > > > >
> > > > > > > > _______________________________________________
> > > > > > > > amd-gfx mailing list
> > > > > > > > amd-gfx@lists.freedesktop.org
> > > > > > > > https://nam11.safelinks.protection.outlook.com/?url=http
> > > > > > > > s%3A%252
> > > > > > > > F%25
> > > > > > > > 2F
> > > > > > > > lists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp
> > > > > > > > ;data=
> > > > > > > > 04
> > > > > > > > %7
> > > > > > > > C01%7Ckenneth.feng%40amd.com%7Cd8e969f4b63e4897a3df08d87
> > > > > > > > 5f1b05
> > > > > > > > 0%
> > > > > > > > 7C
> > > > > > > > 3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6373890281906
> > > > > > > > 09906%
> > > > > > > > 7C
> > > > > > > > Un
> > > > > > > > known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > > > > > > > LCJBTi
> > > > > > > > I6
> > > > > > > > Ik
> > > > > > > > 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=KomP2H%2FadKJChDbN
> > > > > > > > vNPQlT
> > > > > > > > ot
> > > > > > > > mE
> > > > > > > > WrhutsQCHfiRIjNUY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
