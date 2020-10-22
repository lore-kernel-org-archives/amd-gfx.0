Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81413C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D89872225F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 05:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="soUWAFCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89872225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DCD6F3A2;
	Thu, 22 Oct 2020 05:29:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8046E197
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 05:29:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZA7sZEZdVNUpSr8yOyYCSiTP8AHfFSJi9Fn3EhhCRRADYxzEvg5gVckRC7F+ZhrMKxNo5Q2p5kTCz91PU0ZcU/Zs7fok6QhpezV/fjmfOqy17ukI4BrTn9tg/lqHJitkjhWcnHmhbKRS/3vSnwoHiGYmPrnHORDUhmW4YEb00jWyD4l+rqdRR7pgC6bUoqqrK2RZnv/8RBDzfJeVXNZQisrjGktAltbadgeBRWTU67faSCH9XfpueaUZl/cE/pHtIgmLsC0yV1oOafe9dmbG6mU1v9b9U2F07dCv+/FVH8dmbOK9m5fw3aQ99D8N5LjoH5AG2hJoLWnpjFtvKkgFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La2smGhy6W++82ITlyeQGBvvRxdbU4Z7EIQc4L84Nmo=;
 b=mW5y7xlPmwiC1FxwyquDOpAMbUQYKWQsR6xFk7NxHXmUAcXq/IMOBYsV5Vneh4BF+qfLYh3UvE4hEgeHjtBIvrxxBCuhcYOq896zqLS6BivpV4Wh5ef+RGqOrIy5PDMthgh66X76+hOW4YkxlSnorW3+dkbbscoNjI+T1fZl1xf1H26oKYiU8gLsJ2henmq82CYoycOTHrga5Hb4K46whIWSl99flxD3sddS4PO/eJ0ESUW589YXs6QueOtpR6RFcNyK/sr0lCNmWUD+hVOMLTbEe3Kwz7vPkEpQWa6b+rkiLd9XWhN7vm6KW4o2jxwwzXcVIHcbbBHwR43He37rRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La2smGhy6W++82ITlyeQGBvvRxdbU4Z7EIQc4L84Nmo=;
 b=soUWAFCBJXPys9e/AE6w+Hvhn1R14zlEOck6ajSzJFQWgq2STuAg7qaTIIT7/JUaMh3BwLZbJCfvUtUvKpoLRKDEVwUPSgxT7XWad9QUAnC0EemqbBrnNq/0uVviwGeA6mtU52VHoNltg406LpJNNxEOydd+IWlCvNpq1OkALDQ=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Thu, 22 Oct 2020 05:29:49 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:29:49 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Topic: [PATCH] drm/amd/pm: fix the wrong fan speed in fan1_input
Thread-Index: AQHWp3W2tpMmU4s9tUCXALqpnAXt8qmiBbyAgAAKuICAAFWsgIAAZKRggAALJOCAAA5hgIAAD3dwgAAEE4CAABf10IAAAziAgAAAUYCAAAOJAIAAAfRA
Date: Thu, 22 Oct 2020 05:29:48 +0000
Message-ID: <DM5PR12MB16579AE6EC6065DA13ABDCD68E1D0@DM5PR12MB1657.namprd12.prod.outlook.com>
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
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-22T05:29:43Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=290d7406-5af4-4c7c-a852-00008ceb9921;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-22T05:29:43Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 457adb48-e5b6-4e8c-8b68-00003ab424de
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e850e83-a25d-4222-8241-08d8764b7e9d
x-ms-traffictypediagnostic: DM5PR12MB1881:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18819813284F1DFE31134B4C8E1D0@DM5PR12MB1881.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhPfA+QLiF48ajPo9/9VirZ2V9WTzmcsGbz+A/Si4BasgkihTujb1eC/pUiP3AUTncPjfH6K0PDxf2VCJX2B3QvTbgiYY/xFK4/Si4TtzZHduIobGzpuX3S/+HKL59uFU+E0pY9RLjJh6xk7Rr0R1D20Qn3DuuJGVIJtCA2TK2A6UFE8Y3v6SBvWnQRkEN8Xi+HENRJCNEE7hHMGsdWs8XWmZWw4cjd+2FLn+I+v/YftRauMlk0GOThpX8MDGa1E64WnK2GHwaftT06qxsLAVuFOY8AzqUjpod9h2D0BCNhx73/V9uMEMNE/W3HQwXlNz62ZGdm2bvpgGfS7HXFRoPyz5sZN6AmZAu7hogRW5lDKeoAKKX0woFGUFX35s5v8Oamw5gxyg5iCc1r9IeEQOkSH0RPWyGB+/fKHcRynJpyVlyxzAhvTvgjMhRSOHUluvlHkXA4hlPI+9YT8mBNzUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(5660300002)(2906002)(8936002)(966005)(7696005)(6506007)(53546011)(8676002)(186003)(6916009)(83380400001)(9686003)(86362001)(55016002)(54906003)(26005)(478600001)(45080400002)(33656002)(76116006)(316002)(66476007)(66556008)(64756008)(66446008)(66946007)(30864003)(71200400001)(4326008)(52536014)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: H5+o9hB76lVYeDXd1Wrc7yER9F3SaBbC87yGvUDj3U9RqNk1I7u2IwQ9yJY8ygAybxE73H9tfLvmI/BaYKu5uKh85mHS/szyYqx3km905ESUOzY2m65tSCh7eO5DcmSZ/yHQtBkGju1qAFWMCSDHCMK6sjw1gYVGX752CfF7AdAcRs7uLS+FKgetbQ0hBUeCB4PRnXyBFyEOGXkEKOdLCGz5qJmsjhtwMNrUfsIVy+mJMlGovupkbyI3RgfsBI95a+dqlknmuGgv15Nufg1chcpaW3/vlQqF8vcz0IdsgXd3BuM1F0e86FZx6a746kWNujsOv0c7v/sFMMCz6wZ77mQ2+MjrJ665PaKjf9oabTDsH2wv7vkSu9rGNDtVSJsBIBlypRCHGNJPciz1/fR14yOGPxsyS0Zj97bO/2Y1jdcGR5fA+G0vQSJrW6pCcLoqYlDP5/w53E+roMqxzcBJKFAjq0ZFVOlDkPlrilhzAh6FaDDu7nRD17+XSW3z5qjn2G4YKc1E/FlNzkNsWtzihVbmS/ZsK0ct5GHFT8qjpwktLm0WJ/KgUJWa3lfrvdvjCwJHCUKumFVXum/WNdKeXc9TkLP9AB7Xmdu4hJNmrL0RYTIwpDaWWvDUsSxtu8Qq7k+A76WiAzLIXCf93epQrA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e850e83-a25d-4222-8241-08d8764b7e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 05:29:48.9552 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3xMg5WEbD2kg99zpMca7JC7ayxYbPVBao94azaK4uqN7bWUkqummU5ze0ky9Ao9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
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

And smu_v11_0_get_fan_speed_rpm() also doesn't reflect the real value on navi10. 
I will confirm and if it's ok, will revert it.
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
