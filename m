Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 18:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B292C10E734;
	Fri,  7 Jan 2022 18:51:43 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0CF310E960
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 18:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1CfxFKLj1snKotveGN0i+NnvUh8zss2V/cgFYsC5+z5RKHwTv/R/PVLwxBKb3ZU4bYkBrisngrEDxndd0r/ma1Iuv3iNmAN6dkOr9yIJtU2YpT4dyPO6ldkoDYqJ/FUq75KQZHgDGOi7RKuGXIB8fX8p+hzdzpQHwm82bWZXrzM/ccFc2bL+xHbWXRJCvTht1caGZmqI2uTswJ5QZyyNWlCQMSv+upX7J7Wm2A7K+Ijs6xQ6FVzFevfCbekk0vcjS2g0sBJ8IAo9WX7jxnHHWTKh+7GcmR4jlKxkMxlr/WZ86us+gYZf9J7SzkGps5A5uvplj/1q6VB7OyUIeupJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lnqyVesQkeVcdKec9CML/yloDTDdPlPVn/c1ZK2YSw=;
 b=CYw8EeKgsF4BJ3mgKpj/gR88419PTuD1ijMG2T3wgZeAja+wRVKlkP3XpuQ0K3AyVv9W2bSD4PS5jO7+BBOOK/SAzrGM+IfbCPPc47sXYS3RCI3fwpy+4I8JLiFhP2AX5gckonjHPoa9yQg7ZNb6qJ4Gw47prHRQyoF0aid6lHqjaHEa7sHDs/IYxl/0gzDeUEZr5PO+QLwyaUWADpM00AHXvGkOmlYh4Os20vgC0oMLfHWTURWCF5InniXwOjtvW/0RPlFM8WwKJpS95U9AcWTKfJIEUhomv4H21AgoLxGCzac23KqeGTMPH2LLStU+WoOriroXMtaEiqhOS49PzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lnqyVesQkeVcdKec9CML/yloDTDdPlPVn/c1ZK2YSw=;
 b=kDICB5kQAPju0zFnERSG6qjB2UZdgwmYbM54jqsglzIs+afloGQvwJDht4Kfe18P1IvoixZcM9lxuFza5BrkB0OS5YkuSCxXqa9hfy2ajJ9tv0CvkEs9i5S5Ehh1vehogGsdYsVbJ36IuxuDM5P/m8bH8nBnkhDhpEn2erB99fI=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 18:51:40 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 18:51:40 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Topic: [PATCH v5] drm/amd/display: Revert W/A for hard hangs on
 DCN20/DCN21
Thread-Index: AQHYA+aejevROlcgOU6dQwnYNuIzeaxXxwkAgAAeeiA=
Date: Fri, 7 Jan 2022 18:51:40 +0000
Message-ID: <BL1PR12MB5157D5DC6BE941A1C1294DFDE24D9@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220107164959.12511-1-mario.limonciello@amd.com>
 <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB51821C74C0F9C8254A8CE048EC4D9@DM4PR12MB5182.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-07T18:51:38Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=840ffa62-39d5-4d2a-820b-33ceb3ffcdbd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-07T18:51:38Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9d084583-f42c-44ca-bc24-715540e3f80d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1867e2d-67aa-4a09-dd22-08d9d20ebdb3
x-ms-traffictypediagnostic: BL1PR12MB5046:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5046BFDA2A5927BA3082574CE24D9@BL1PR12MB5046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kbCeEd5i6HXTsbY0662Qai8c+c+g/tdY8tE4Qmb7sBEqV6tMN+GSd237Pd5Us1YTKJFI8pnACYg4iPCsf4Wzdnmx6nQLH1zKMKUgzDVzWTtfWVZGwX0+TzvnC/G7TWK07kyDjzAuFGbW16dRfdRuwHDykbz3SxmuiRUmiI7ZLELboqKpQZnLgBK4j6THJn2MqXc+MEW66AlzPBHByf4DJaB6v0kCtU1COlIHdkmBOX9GkVakWBcKOoNhxKd/WntyiWmDzf2reZC7BnzgWHE12MveQlP2G0bRWJDpk7joPWL47h9+CPuPrxsy1dngdIcEhxzoJ7Dyl/ril+0F9TS6r5vRKjTogxfoaDip++SJTr13sMXqRpqKXtXfly8XmieIcvUFD60zv2RseMWBMg4GIxIhnlpK2W4pANaXtYUGhF0s69aMyZVSWzbIO3+O0nqRBIvuzAN3pAQJu0xdFSwRyKswcsC6ulFsevHgTS9iTfQSTiiUuDyIXdg0OXpX9JRYrYOfHKbyEdzqblDxIRu8yal2P63NwYC2WYlVcejSDswHm3CTaQbf2+Kkgs7K4JX3vVoMDs+OSLtR4DXVWhFaq+QqPpYoenO1mIjtx330vphRrCsYaTE8Kolk+G6kMglOyG/jr/rJMwITR8GydpdbdtdyRh4X0U2A0mXeX8GuUU0rvLj8/uo0HQbSZU0Wv1E3auyYlO784dR3aN+r+isknQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(9686003)(6506007)(508600001)(54906003)(4326008)(2906002)(71200400001)(52536014)(7696005)(316002)(76116006)(186003)(8936002)(66476007)(26005)(66556008)(38100700002)(64756008)(66946007)(122000001)(66446008)(38070700005)(5660300002)(33656002)(83380400001)(86362001)(55016003)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tGtuknR1M03mwl9KUs/7rwqAEN6RuPvM4HLiJs98HIDW/iPja/R7qlia/JB+?=
 =?us-ascii?Q?jewwiVVABosZkCDoBhXcW2GjqBdNvut1lH3mofueVp37AJYrCFnUaCcT7kMz?=
 =?us-ascii?Q?c+zvgG6AXng8rNUbdq5alW23TDNr9ndsequsyoZvu4723/LeznYk1pqJd27S?=
 =?us-ascii?Q?kYhIwuYhWC71qV34AMzV3yiMoV+fO4odElm4vesE9WmMDGaI5z4+Dwb5H1Ng?=
 =?us-ascii?Q?RJXyUhDAoxmdunNO0Mv63yvHv8KSG5JvBfuSZmF3deXRsik/ovq/EVMnAH5h?=
 =?us-ascii?Q?86zuzz0at094vuF7wavWkHjy2Wf5bzAUkOTe2+p8w19vNy3n+Yy9hXM6ZLjg?=
 =?us-ascii?Q?6mcjwCMJ6URTMOh2jtrlLrnDaLKekvgfQyYYlZnqhT3ND6/A8Lcitj3AGX2K?=
 =?us-ascii?Q?natOSvvEnlw04NE/02DZ8r94deGmdMXgLup2VsojkztJnuaG32zxcvOfP5CP?=
 =?us-ascii?Q?p328bJta20NgqRA0xP0jbFO12JrxTDE7jX6NRSp3kPRC9nEbIWB2ybqcgn/n?=
 =?us-ascii?Q?zDgK0ZryGl/HfgEsWyeKQZwfbh6TwY6Dcv+3MnvRMPivBVexthdrxz8WiHCl?=
 =?us-ascii?Q?7+jfzZVkWdza74W00ZYZkgz3W7Y7ZCr1rhvg4QF7459mHjfH/aiv2yJ7q4Mn?=
 =?us-ascii?Q?zJOl6hCeNSZSA8cDb7F2RjhYHxlCnWCFXXxEuXF7vwYcEAtDM9vECuLkwawR?=
 =?us-ascii?Q?eCG/IfLK/5TnqR33Zm7m/cR9A9z3WS8x6muOtijg48lPDRegOj/7g1Qee416?=
 =?us-ascii?Q?lAxt49e+pzto6kqoO3qK5ut9aGnVK0qdFtqOgbdPO6XCmLRKljuEIuhU3dDj?=
 =?us-ascii?Q?pL/wI2ewRY3CB0coRHwCHaN02DYb5aiMMA+91PeOIRmbCB7tr53LPBq0YV3a?=
 =?us-ascii?Q?pvl6ba6tgl5pYXX7f3WQb9tWnzw7GAYjqiIIJt2P46Dfn1yrinYNAYGkglVG?=
 =?us-ascii?Q?EMzTLczFPqU2eNkB9KP7SkNqjhp1078M92mLFjKADIs+uCFTJ2BVT4fJZlQq?=
 =?us-ascii?Q?PorbbZfsw8cWPJ5otYU0T3yfSKhB82yp3+b1l9pvqvS1jDdnCbdS8pnJ5pgS?=
 =?us-ascii?Q?wbXcE3h6nAcD6dC29fXWFWG4wxjxFZF+BWQMAt6gzjp+jzyRJaacA0HKmoIF?=
 =?us-ascii?Q?klgKTN2sJR88EPz2t0bG6hbG7xVmkOiBXgE/P0Yb46svfPSCoSeJWgq4lsCM?=
 =?us-ascii?Q?Om7L5rI2eqE8nqJ8meK8fIJBdhUGleA+UzIIEMUBzIeDsbroEk4diA5J+hqS?=
 =?us-ascii?Q?kkt+1ETYod7Wk+jH4XoJwiNVG11ox1JAWyry2NQi1ZljRG5G7Iz2TY1ZxYTC?=
 =?us-ascii?Q?XC8hRRYzpIYgR3PrqVO0Ffk+hsUM0rxKKxiryBxsULZYx9d2krjDvosN0ZvU?=
 =?us-ascii?Q?2rYevZbfJC8fyTPN8PthOUGNQiIE55vgxMtqoGAKsW26PwAhrFoB2E70MOmD?=
 =?us-ascii?Q?eDIYTyhdzdICEHLYCsFt2GqLdQOGKBR+0xvuTUyKtErYiDXA8ZClJV1KPqVU?=
 =?us-ascii?Q?mnqSiO70s54ZtLDH3WS+NmeEzrk41q6movCe61v4EgabV+22ucgK5HqgXa7h?=
 =?us-ascii?Q?Qwq4ZieTK4BnRU5vArHSX+RMlolyF6ro/n7UyNSmBkupHCJikXjjnksch45Z?=
 =?us-ascii?Q?DV5k15wmeqZtMKCIjNv8Fbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1867e2d-67aa-4a09-dd22-08d9d20ebdb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 18:51:40.2598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wiL+0y4qDkLAtjvcw1imVGxNZF8A8fyB154xzOS1UQ6yll+AvjurIP29P0sOMKqWjs8QF1uuw2uteEos4E9o6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
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
Cc: "Zhuo, Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>,
 Scott Bruce <smbruce@gmail.com>, "spasswolf@web.de" <spasswolf@web.de>,
 Chris Hixon <linux-kernel-bugs@hixontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]


> I think the revert is fine once we figure out where we're missing calls t=
o:
>=20
>         .optimize_pwr_state =3D dcn21_optimize_pwr_state,
>         .exit_optimized_pwr_state =3D dcn21_exit_optimized_pwr_state,
>=20
> These are already part of dc_link_detect, so I suspect there's another in=
terface
> in DC that should be using these.
>=20
> I think the best way to debug this is to revert the patch locally and add=
 a stack
> dump when DMCUB hangs our times out.

OK so I did this on top of amd-staging-drm-next with my v5 patch (this reve=
rt in place)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/=
drm/amd/display/dmub/src/dmub_srv.c
index 9280f2abd973..0bd32f82f3db 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -789,8 +789,10 @@ enum dmub_status dmub_srv_cmd_with_reply_data(struct d=
mub_srv *dmub,
        // Execute command
        status =3D dmub_srv_cmd_execute(dmub);

-       if (status !=3D DMUB_STATUS_OK)
+       if (status !=3D DMUB_STATUS_OK) {
+               ASSERT(0);
                return status;
+       }

        // Wait for DMUB to process command
        status =3D dmub_srv_wait_for_idle(dmub, 100000);

>=20
> That way you can know where the PHY was trying to be accessed without the
> refclk being on.
>=20
> We had a similar issue in DCN31 which didn't require a W/A like DCN21.
>=20
> I'd like to hold off on merging this until that hang is verified as gone.
>=20

Then I took a RN laptop running DMUB 0x01010019 and disabled eDP, and confi=
rmed
no CRTC was configured but plugged in an HDMI cable:

connector[78]: eDP-1
        crtc=3D(null)
        self_refresh_aware=3D0
connector[85]: HDMI-A-1
        crtc=3Dcrtc-1
        self_refresh_aware=3D0

I triggered 100 hotplugs like this:

#!/bin/bash
for i in {0..100..1}
do
    echo 1 | tee /sys/kernel/debug/dri/0/HDMI-A-1/trigger_hotplug
    sleep 3
done

Unfortunately, no hang or traceback to be seen (and HDMI continues to work)=
.
I also manually pulled the plug a handful of times I don't know the specifi=
cs that Lillian had the
failure though, so this might not be a good enough check.

I'll try to upgrade DMUB to 0x101001c (the latest version) and double check=
 that as well.
