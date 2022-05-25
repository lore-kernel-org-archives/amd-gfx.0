Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED136C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 14:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8885410FA7C;
	Wed, 25 May 2022 14:57:35 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1350710FA7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 14:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu1dNZO9HXnEv7x7eNsoOSSONgLY2kSCCccgiX8Tsea68oejo0XyFuiYhkE4nqvSGDvsrpQsmd6658Voq7PT01zzNrz77D8e3bplPjniC09G3DIQ0bMU/1qZz7IuaY4MZE6eDnxLdKGuu32gBUtLfT9i2nyPTR2X82NV0sSM+X0h1OFjuA7RwDM0RW66OD9EgmGDfsI+9htv2BARmyhRidvmm3QI7/IEQcNmSvVMnkdnrs44gFjf+aWn003XoFlFBnBXWWuSPbTCPNT4DYsHz/XiJMtcpOG2xKjN/PtiExJezgZhsef2W2vO8vCcwXPR5vzmhT9vAD8Xft8D3+igOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCaN+VtN4GYgsCk9s+GRjX5vLSDtoWM+F5MmjYsl4Q8=;
 b=KqUtn5ZfQarVl63WU7GrLhbSGtthKh7z3dRQofUi0NZ6aQCbWJyPqDcENMyIWdOdHL64uYWIe32/X7vPcQfNL/9Mvv/xXBvMDOGKHRnfu3LbHCqJJk2QpW+vsi9iS3TE2w0tkvYdWsX6c0pUhJF3JGS8ETZvXK5ZqI5h8dd7eW7J8mOppLT9uNQihZm+cfwqVTECq9Fc1YmqTvJ/P1+E6qGheBkuqjXqTexkQ2XC4wD7nNvzwljhnYm6JRV7hcNUmYDRjyELklE4ptzVFu9Z42JG3tMke+5zQkRs/cYV2P83GOBDFNfwEAynfRXLLEUT8Pkb5hT+ub+svRQOIQ+9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCaN+VtN4GYgsCk9s+GRjX5vLSDtoWM+F5MmjYsl4Q8=;
 b=Ez4/WxnJC/yWnVLgt55nWbYq/h1tVoi/uRUptb1cBPmt5zI1D6qvwkXgpmoFeBD0O8QrqCQLBD5Q/6MS1ba5GpnuDrPpADxzHDpupFp1Y1qOq67VdzZeCeZrpBL8C/XnAjPSFMb6xkK80VMIk8H4LwFKQH+PsRfVZ7MvG/gOd8Y=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 14:57:31 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f%6]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 14:57:31 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 0/8] May 24, 2022
Thread-Topic: [PATCH 0/8] May 24, 2022
Thread-Index: AQHYb5ZX23FZrISyP0CsG2qjn1bgTa0vr+SA
Date: Wed, 25 May 2022 14:57:31 +0000
Message-ID: <DM6PR12MB3529D86DFA8E65CE144C87E69CD69@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220524174704.124902-1-jdhillon@amd.com>
In-Reply-To: <20220524174704.124902-1-jdhillon@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-25T14:57:29Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=563fba14-33c7-449c-80f2-b94b270a51b7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-05-25T14:57:29Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 81a1738c-a837-41cd-b1d5-960aa71f04bf
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e0b9855-0aa4-4c53-3249-08da3e5ee4ae
x-ms-traffictypediagnostic: SN1PR12MB2352:EE_
x-microsoft-antispam-prvs: <SN1PR12MB235273D89E54B54AEE8947BC9CD69@SN1PR12MB2352.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A4feC4S3EuSdlW4utjl/Ejz0DOX1u4wQS0UZCQfVipDJdmLWHFoAAGRlzdg4KN9gWUfUjRFbCY1/0v6aIexb4L/wXEX6keS/eYN/HA48gLiZL6QF5Q/mDZwLJ6Y8VpFFd8NPHHcYBNeGjm3jFn5x6C+aYJ4zO5YlFVNLJhDIx2nKUjlz29l+hZ5445xzEaBdCppK0uQbPRJXjNE3nl38VP2l412dfBaQP/LERVqlhVP28/HFAdJ5bP/Q0TvJbNedEsamKR9qt6TSy9dHlwTTCiu5+7l9wqUWtuVb4q8IjiuXZf+gzYlM6LBnKYxZ7xRD7RMmbW4NUey80kk7bYO0kQ8TEMqCM95noKzne/uc4h7EM2PuyovztAHDnb3QTVxSUwTPw703U2UJOngtTtvEYMu8yjyFxoNcfxfeUnfYQyYonW9jyyhw1kYSOl4gJWcmr205xw0/bFDuAbALag6IJG/gCW7iBACBvNAbhqYov26dQiN0+4eYqyHzHB7bPRS4eKpW6/prrDnUB5sKG3K2XWbHgyLWkBsQfQUN45/nc4IYU0Vztw4Jchd/d/lcUvDfW3YKcy1oR6xzdoabuYihkVr4TiJ6hknf302ZvmWzfp5FpCt/n8x2/rJr+TjY6SETZCF/u74WFWoo8Zl4xP07I0THobrltVbCdAq6D97/nf5iHd5nUGmRzcLA1AjbhfnuhLFHIImQ8M4lrxRCRo5fcg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(66446008)(76116006)(66946007)(4326008)(122000001)(66476007)(110136005)(86362001)(66556008)(71200400001)(54906003)(64756008)(508600001)(316002)(38070700005)(186003)(83380400001)(38100700002)(26005)(9686003)(6506007)(7696005)(53546011)(33656002)(52536014)(55016003)(5660300002)(2906002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gguSns9Pxpg28D+pvSYoAxj5izGirO5bviMHxYz4mmtj2UaUOMG7Ge+0WoUz?=
 =?us-ascii?Q?JZK/eEAJDFP0cIPh2R/hJOtfPytwIUnXlrTmty9nkQlaACNL+mwb7YbdQtva?=
 =?us-ascii?Q?TjeMy766HbhHDPF9vfCaA5eED5ET0T3tajKX4mlWM3QrV+w/GpWv8u01jNn8?=
 =?us-ascii?Q?J+zLZXpPAWPZiwrmW4eAMFGoUBNoPvG/O+W/1QryfwVvM4RO9oj+JLm53KX9?=
 =?us-ascii?Q?M94Gk9lOY7mmPxTLRG6xee8BO01+eu/YUmgJfuw8/fXpNdThAaTAYyM5gV8A?=
 =?us-ascii?Q?5IG5zq2kJSqaK5U08jPKg3KLzcwxAtXU8dDXBK7+R2IVmjmZTYUA69J/xavU?=
 =?us-ascii?Q?RiZyKl+XsHL20BNt+CNBepZLTrKjO2XaQhYKjgcRYmFkB1YmApksTlPw11ug?=
 =?us-ascii?Q?pvccwbpz42+aFFje64SHmJRIKiOWDuN/cqgvPT7Vx3y685RiZ8s2FnaJcPll?=
 =?us-ascii?Q?mwlbVDkqHyXm8uPdyhukNoYHp7h3QO8iqZ6KyP4aSp6CQqvBCfve2Ow8nRUh?=
 =?us-ascii?Q?i/P5T8ugb7Nnc5Ego+LTg/8zvTADc7V8KsWgZb6dYTlXDfNQE+G+76zu5Ct/?=
 =?us-ascii?Q?rJHz94PtoCDIdzvtB09GJFXLifrBrIfTYBSrxavzHS7gxFVUOxJ2y51EPLIA?=
 =?us-ascii?Q?J3PP77cIFvCrm9rzHcF5D9Y9kKxX41YYYXWwTODq1QXEjpQM6+pjgxW/ZsLs?=
 =?us-ascii?Q?7DEc7x0RO0RRSI6WvosEd2pYrgs/NXA1jCN6UeUXHoGEPpfQeN2G1fmmEDZW?=
 =?us-ascii?Q?8Gn1ttvulDQ+Wkq0SRL24Arhm5aiwh+kddq4YgOvvNzGu1fTJ8XYrFzlWDUO?=
 =?us-ascii?Q?YfGh4Abek/0drdp55cusndvOYbAinDD4Uu1KHWncK+XIMYo6eIuPKgxJ6lOx?=
 =?us-ascii?Q?yzX1n+Ser/soTRhQmgIV27vMFNZexnx7XFulSXszVhcLszdTwnzt+iHj2SKW?=
 =?us-ascii?Q?yjhOALFLHvzZRKNRfuBN/oE71lE17uI0xAz32UVu//Lxz8saWp8grHEGRjdt?=
 =?us-ascii?Q?XbAtJvfmR8Z0bS9qHhQhz9L2lH6WH9nHW1uqCGdtKhCXWA/rrOpIG3PJrs9D?=
 =?us-ascii?Q?urE2ovK3GHYVP+RqbmqpoAOy0Zl1vj+eeisCOsEQGHfidxWLCiBH+ZroDT3Z?=
 =?us-ascii?Q?y6tACNiQY5TxwyU1woqzYdBz22XPMXx0XJH9xi//VpCNBSTuIGJxwUByKGhf?=
 =?us-ascii?Q?cFXno5ea8r0yShtQpjUJmc3TjDvpstQbgIfgQC2lrl81lYOo2jy4zweZKXlG?=
 =?us-ascii?Q?bUXORu7MyCEQKwkVQoryaBIC427Ym0Bd3tUbSdpAvgdWSRN/QdXRYMnIynYU?=
 =?us-ascii?Q?U3bcEK/DxYCShnz7kMa66MB/mrXcep7P4oYmEycqedpKIQNeonY/QRTRLJIW?=
 =?us-ascii?Q?ybifP0O/5a1W03EjRT22EPmvvsOCOeNOpzXo7nh/iDz6yHOHRcaxFztuBm7+?=
 =?us-ascii?Q?qiJbpd4b3RdrQ9cGX+VNloitGptXbzus4uHxVV4wuKLrKz/fChV4yZF39wUb?=
 =?us-ascii?Q?usRp2cjDVY3vtXjOdupNhx+elPw0aI6ybsDGRLRbqAOpjByQ9jjDCBaELUAZ?=
 =?us-ascii?Q?ns7VdeKYX3yyQYHbB5+/JVz3HuL9m0RH7BFXXvtVae2yucrwLB7ALhRYBZ0i?=
 =?us-ascii?Q?n7KiDIcPfHV0El1lFQJoCiRVBy6sv85kyadQNcbqKfuoaWah9BpDMksDZ4d6?=
 =?us-ascii?Q?/FeyvmUqH3P9LOrofmAT0rnpn5XzmS++UjBX8ryUgQfcAG3E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0b9855-0aa4-4c53-3249-08da3e5ee4ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 14:57:31.0503 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LF6jOk46BUhh/UKu8vT/kOlUSfxAHEcVWO/Fwco3xYEYBpX790tpRFsgz6A6fxm0VYWIOt+RhY5lC6pXwV9Gyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
HP Envy 360, with Ryzen 5 4500U
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U, 5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the most recent amd-staging-drm-next (Head commit =
- da38a66ac46e334f198afcd1b4d4554b4ddca0df - drm/amdgpu: Ensure the DMA eng=
ine is deactivated during set ups) branch with a selection of patches added=
 on top of it. This goes for both Ubuntu testing and Chrome OS testing.
=20
Tested on Ubuntu 22.04 and Chrome OS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jasdeep =
Dhillon
Sent: May 24, 2022 1:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com=
>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.co=
m>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pill=
ai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpree=
t.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, =
Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 0/8] May 24, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

*Changes to DP LT fallback behavior to more closely match the DP standard *=
Added new interfaces for lut pipeline *Restore ref_dtblck value when clk st=
ruct is cleared in init_clocks *Fixes DMUB outbox trace in S4 *Fixes linger=
ing DIO FIFO errors when DIO no longer enabled *Reads Golden Settings Table=
 from VBIOS

Alvin (1):
  drm/amd/display: Don't clear ref_dtbclk value

Aric Cyr (1):
  drm/amd/display: 3.2.187

Hung, Cruise (1):
  drm/amd/display: Fix DMUB outbox trace in S4 (#4465)

Ilya (1):
  drm/amd/display: Fix possible infinite loop in DP LT fallback

Leung, Martin (2):
  drm/amd/display: revert Blank eDP on disable/enable drv
  Prepare for new interfaces

Nicholas Kazlauskas (1):
  drm/amd/display: Pass the new context into disable OTG WA

hengzhou (1):
  drm/amd/display: Wait DMCUB to idle state before reset.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  19 ++-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  |   2 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  13 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 158 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  23 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |  79 ++++-----
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  20 ++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   5 +
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  19 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  11 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |   3 +-
 .../amd/display/include/ddc_service_types.h   |   2 +
 19 files changed, 233 insertions(+), 162 deletions(-)

--
2.25.1
