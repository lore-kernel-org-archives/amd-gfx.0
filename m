Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB0C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED19361882
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 14:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED19361882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AC26E48C;
	Mon, 15 Nov 2021 14:35:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0314A6E48C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 14:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngr17tRYMlfldJd1rXeIaJ904rJswQTGzhVUiYGFdlvYoaiZUGGkKxsBpnuRao4LBnPnRi7AbOenTnbrVuG8kggbk2mjWHANVHOYShgmtyT3PWPlm7o1lLDqruWFUpqp6ekV3hxrPEFafE6VLHItIqMi1sZ66oNk4dxwlzzAaUlWw0cwV6NyTHqwJOigFM0XNj1s+jWIWlwZHptFg4D3s2vMoVSPeCaeWE/a3l3cPusZWwuOtDSYTSpaT18CXaR7qKtFcUYFDV2mRXYRVq4C9MeC1exAYPFvq69KC+mHr2sLlso5785npRgxQbdWxNtItxXpEUhCi+N2v9NokZ9n6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9jGsDf4j4hZOfZtXLA6rPACEMXZ7awfQKIF8p5llyk=;
 b=cKhNkq1RnCiOXO1sqjjHlesV8W3Pbaje1vBsHc6/UMNvW/RulFcnwIGHFsjYtr9bMOcX6mWK/ae+Xso2dG3/ofqiN2i9YC3Qgwp5Pa6gJvB3JqfJH3wgd5a0JpDpB7l8KriXd7fQLtau+GhY6mZbeCPRIoN6noHuLlvxtWw+xCX8ioIC3YKbHTrIwZV5n4WVbOgLqSIF8VUYITioSzkMM4jUPo72RzQA1iMuU/GnJmqWqktjwmbuKmQOo/wILuQjVlGs2L1znyw7NTiPGvIx41xQ3Z5l8GPyP2JqTQXS7EBzdP4REHfQF63e1vDQleeAEu970lyYqIp+BhdiCzenzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9jGsDf4j4hZOfZtXLA6rPACEMXZ7awfQKIF8p5llyk=;
 b=nxVIVQLPEFynOSMDREN0Q8GegO5XJ0In6SXSCMNmemVh51M/3w42QKPIKHLBVeiMJjnCWlUAnvnE3oWXsXMw96l7rWbPMxmulB5JhOIyl1B0pIHNWwO9jOqJTTIw2oDo8kfmO0DG0FUpweu3RkOPZpto3mhPLJFvAkldmLs11j8=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 14:35:03 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ac45:5fcd:5b30:9bef%5]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 14:35:03 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/14] DC Patches November 12, 2021
Thread-Topic: [PATCH 00/14] DC Patches November 12, 2021
Thread-Index: AQHX11/s5zg1BSrfwU+GoaIVRJx3/qwErSPA
Date: Mon, 15 Nov 2021 14:35:02 +0000
Message-ID: <DM6PR12MB35290C97F952BA781B6B1BA89C989@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-15T14:34:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3c27d6ea-8880-452e-b649-9b9837f99354;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1670298-d007-4847-8f4c-08d9a8451c73
x-ms-traffictypediagnostic: DM5PR12MB1724:
x-microsoft-antispam-prvs: <DM5PR12MB1724FE47469582B6E5C2AD889C989@DM5PR12MB1724.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AhIsgFxO5edWLNtgglXApR9mAZbkmJ42IEmgqjAzFYnY2T+0nxLA5o4lTJFG85Tlj+VJx3kg8Q3haLoM4z3CHG4ePbB6bbd5VouF/8oRAlxzJ5Y5O4mFBFsjDnMM3WoV7Z5oVaZv4J8V73ZboXNsKcezpO6LYOJAy6I++mqRaVfM5tpLDjBJBSAoAyNHgELPpWjJfaXNPwuDv4KCGBVUTVVPFxPXqHgT18vJdO/ivKJyXJRTEtzg7v6L54Xq8ZVdYTvw73jNgM+5t6QS0+7Q5u0ga9nLRWNEZKLlqaqikfzIP4pH0vqSFCBr+K9xwmXF5tN+5oqjZNmheMtob0+g+3zY6bjVkXc2VCPYracqZTbFow6Bv+nNF/dy+p/Svp14ohTZMbj/ck5T3mn0Rf1ryFqaZlYKfcjN4PIel5iJmhlSPKoJAf6w4qiHZZ4NbdfpL3ttlV/nstcazByDp9GxOsiVjBN23JBQ/OpceFZDkGkv08E8yFvXZ8lfjtcNJXlwpZpQu9uFt7UVu91tBtXnFF4hkOoAaAYM0oX5J7c1SrWYNvdYggTKkrFreCWixWoi6FakOXLPIU6jNZtWu6h70r7ITKYtEHjPG/IeGECsWRD1h1mcCSOgXqHLG4Wa4li3vczml0nM6aNNPPX0iv8tc26vmstCiUsbJnE7t5suBXVg6kLdggIGj3sumOD+uzAzu9lNwcGiebyk/qwjsqsbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(66946007)(55016002)(52536014)(7696005)(76116006)(2906002)(83380400001)(71200400001)(38100700002)(38070700005)(6506007)(8676002)(64756008)(66446008)(66556008)(9686003)(66476007)(33656002)(122000001)(4326008)(186003)(316002)(5660300002)(26005)(86362001)(8936002)(54906003)(110136005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gpUSoD7vibNW/sViyioHFnJCV0G5MTbGjNoYcS6lAzDnDEd4X/yh5/KBlr?=
 =?iso-8859-1?Q?y5v3e+XXDQdNfnCQWBWABGMkxGGK3dvFDAHvaB14RqEeWEoqp8UpcrOuk4?=
 =?iso-8859-1?Q?TncWNZSEAzQTcHDEi2p3+Ig7fAM4Fes2qodusGTT3/iVK8Jd8q7yyMUcrK?=
 =?iso-8859-1?Q?0CuyULPQfSXITfVGzlx+rzOIJwChGLC80feWO7HiJV/K7OHQugateKjWa1?=
 =?iso-8859-1?Q?HR8T30XyH9VgU03j+KrY/gWJkgTrKxHsVkqseH41IkXNPLnomZ5+UMaIrF?=
 =?iso-8859-1?Q?d9HEBPgSayO8Q+CxsNy32aQ+nnRu9fxlB8Fc/tAMTfgLCbNQ+RMfSd6Ick?=
 =?iso-8859-1?Q?4iHH9POWJTIpwrGVPMAnH7iWcU89aylhhhDuavHa93T1h6topZGBCZSLlA?=
 =?iso-8859-1?Q?zRf6mEFhfIRFyK0DLdJC0AL2QKlVerOYn26nJOs+Q/40GSyQBeQlOiXTIs?=
 =?iso-8859-1?Q?itfOFksADO0GzaSlo8M7qflrGhqcUHoICt99vAKY2MdXNBKHro/GpzkJn2?=
 =?iso-8859-1?Q?raMFm8iFAVjM97Pd5n4JqaldBjDBEzi7hpd+H9LYYIb56eE22RgR0oQ4yz?=
 =?iso-8859-1?Q?yWJo6jplVpNRZKusYRP/oecAl7s9vgtzLewELICRSr+bOhurVVy/lDwDzT?=
 =?iso-8859-1?Q?H8GOdqpuz0emrrpm47guggRBNk5hlS+iIryz+Y/gVfowAAqdJnQwCjB4/1?=
 =?iso-8859-1?Q?fObQ+sKUd1ohLqhs7w5VUHt8Uvp5vilMWtMOYnXjjeICo7F1aqb4/YYN8R?=
 =?iso-8859-1?Q?dYRzbbVgGc1VubYyfw3XbFKpuujaZK340lVOrFH6SYgxGNKF02Pm5aZcG2?=
 =?iso-8859-1?Q?7rZb6fwZ5kXh1r5KRiViwW+qLMAZza7iKimRqFgKq+3xMB/1Za7zeI50/j?=
 =?iso-8859-1?Q?UkK9UIPLLyh+1EaiON2ktMczOULQFpsPAYAVh7Omop+Q91PcEKJNspjZcL?=
 =?iso-8859-1?Q?IoBX3ZOW5KQZGT/aobXhjnRnRoaidLTjACQI6ac0NTUaJc0AQxU/vtCvz6?=
 =?iso-8859-1?Q?QUprUccN1l6oqPzzRVcnHYOLQLu/6gfz807MFFgEC/WYLMLYsJun8x2LTs?=
 =?iso-8859-1?Q?ADHtBXPTgarWHYZeh2fCPiTgNGGFoxFdiMx1TJIHbkuA9r3ef2M0yXZMmH?=
 =?iso-8859-1?Q?S8o6336Dzy0HshJfUBCH2X8NOEAwFzzSrNKgelZCbgOoFQA6Y6EHMh4JC8?=
 =?iso-8859-1?Q?d2RtjqL3XzZQ3eGJa2ewqohzHDJnwWu/XW0z37G/ngtRIz2lcBN/bbSnF6?=
 =?iso-8859-1?Q?ceOFmMo14EWF5KM3ZCzAH2uiyP1sF1IDiBHW3Pth4hSF2Nk7PoHIDhz0uS?=
 =?iso-8859-1?Q?iu/O1SYGbHAoiYN/6OfsoZXI7aUJmgxQ+GnCFX0QhJQLYqdF8phLQUypLW?=
 =?iso-8859-1?Q?kWipemsMlardnRijf0PxtmnAZLcjdSToC0vHClaRIoa1P3hO4SNXJ5I1Hb?=
 =?iso-8859-1?Q?R9lEJkDoVBg8SRSK/MoJgbL3fmSEQ3iSAT2CoTL3pqCcsxeG1ocykAqYQ6?=
 =?iso-8859-1?Q?As0zHwovmThaYSkWYwHSR6SLI7apDA53ltrf8lXdpDfWFGuCYcpGsO5rVc?=
 =?iso-8859-1?Q?BCpeuJQF9P9gKockuKnP7okHzL8b+nF36DpmilGboKcymD8YCBHvlSnOU1?=
 =?iso-8859-1?Q?aDy74Tgw6wemDsOFwQ2K/lKx2/K8utSXbObcmAHa1haqMk5YIx8RAXJP16?=
 =?iso-8859-1?Q?dSpqtXFu1AnKjStIe54=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1670298-d007-4847-8f4c-08d9a8451c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 14:35:03.1611 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9D9pKyRKq1SHD5vCqrFcMsw/KotN7iLwfxGtkW3KSPMksKO3vfjTH5z9IXoAI+R/Jto44Q5RrwA7DydF1bzQoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=A0
This week this patchset was tested on the following systems:
=A0
HP Envy 360, with Ryzen 5 4500U, with the following display types: eDP 1080=
p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI)=
, 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
AMD Ryzen 9 5900H, with the following display types: eDP 1080p 60hz, 4k 60h=
z  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), 1680*1050 60=
hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=A0
Tested on Ubuntu 20.04.3 with Kernel Version 5.13 and ChromeOS
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=A0
=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Li=
n
Sent: November 11, 2021 7:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <=
Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, R=
oman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aura=
bindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, M=
ikita <Mikita.Lipski@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.co=
m>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.K=
otarac@amd.com>
Subject: [PATCH 00/14] DC Patches November 12, 2021

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fix issue that secondary display goes blank on Non DCN31.
- Adjust flushing data in DMCUB
- Revert patches which cause regression in hadnling MPO/Link encoder assign=
ment
- Correct the setting within MSA of DP2.0
- Adjustment for DML isolation
- Fix FIFO erro in fast boot sequence
- Enable DSC over eDP
- Adjust the DSC power off sequence

---

Ahmad Othman (1):
  drm/amd/display: Secondary display goes blank on Non DCN31

Angus Wang (1):
  drm/amd/display: Revert changes for MPO underflow

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.92
  drm/amd/display: [FW Promotion] Release 0.0.93

Aric Cyr (1):
  drm/amd/display: 3.2.162

Brandon Syu (1):
  drm/amd/display: Fix eDP will flash when boot to OS

Jun Lei (1):
  drm/amd/display: Code change for DML isolation

Mikita Lipski (1):
  drm/amd/display: Enable DSC over eDP

Nicholas Kazlauskas (1):
  drm/amd/display: Only flush delta from last command execution

Sung Joon Kim (1):
  drm/amd/display: Revert "retain/release stream pointer in link enc
    table"

Wenjing Liu (1):
  drm/amd/display: set MSA vsp/hsp to 0 for positive polarity for DP
    128b/132b

Xu, Jinze (1):
  drm/amd/display: Reset fifo after enable otg

Yi-Ling Chen (1):
  drm/amd/display: fixed the DSC power off sequence during Driver PnP

hvanzyll (1):
  drm/amd/display: Visual Confirm Bar Height Adjust

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   73 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    5 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  167 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    7 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |    7 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   14 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   37 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   15 +
 .../display/dc/dcn10/dcn10_stream_encoder.h   |    3 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |    2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   14 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.h |    3 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    2 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |    2 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |    2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |    1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    2 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |    2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |    2 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |    4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    5 -
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    1 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |    1 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |    1 +
 .../gpu/drm/amd/display/dc/dml/dml_wrapper.c  | 1889 +++++++++++++++++  ..=
./display/dc/dml/dml_wrapper_translation.c  |  284 +++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    8 +
 .../gpu/drm/amd/display/dc/inc/dml_wrapper.h  |   34 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |    3 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |    4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   18 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    9 +-
 .../amd/display/include/ddc_service_types.h   |    1 +
 38 files changed, 2599 insertions(+), 31 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dml/dml_wrapper.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translat=
ion.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dml_wrapper.h

--
2.25.1
