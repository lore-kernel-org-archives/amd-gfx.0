Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6EC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 16:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E7610E405;
	Tue, 11 Oct 2022 16:50:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7337010E405
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 16:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKcPmcnjviGSUZoqzLnDeDCmzdmdhN+41W+lmtOeyAcIA+OFyp2i1VcVjRA/tbl8B++9Asc8HKappZ4fZR8KOIKAwSHfWeqgGLcTVUz39IliK6eEVUyfIQaqZeSyVD3MmwXUX1AjAhzT/EquMp7mRWOjAMfR8cEhkV5IqBZtZUiL+7THGRMCROBMtZvA1TQHq/RSjIHe6PGEIuY+mDsdc1oxY5127cHgXVd18rkLde/43zlQ/Qc9gIf98CdNWvLkb9DF2ES25UAKVIjScz82xLPnEb5A2+5oi9XOjufK4vgLBQ2xFwC5itLEIbJpaXwc/f8rtJ2ClbU9bByA7fkEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSahQKa0MLe0VFWXjIFFs1W9v6so4GYGr7EaWaNpuWE=;
 b=R+qrp6BGJ2OcExIybnpsK0ioxGjEkk7QBrFiHE6b/jP5IoOVpCsxVGEzEillftRn+cE6aFiocUFFSNhrLSKTrlFpn23VwxjCY2n1OsIJhTri7c7/MSOJ20WBQ+2PF80eglhj59eXBlj1nhcOTpwJN3ctnFB8DXVMQIvhLZ69CeyphIk28CMiKdiEMgPQw3GtLGExA/4iIeFGkCaqeKByAkv33EuluB1YYYUq+58jtXip//qBHG/mzloiwbJNhSGc2PROQf/1+V2/wmlLwEcYBBMrD+C6vsLjNUb2OXULItnzjRjfivBCG1CLxZWIIrbt4GX/RghQUzmI1/4jIimAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSahQKa0MLe0VFWXjIFFs1W9v6so4GYGr7EaWaNpuWE=;
 b=rid9vr+E5MrPQKx/mmlNQLLT9nc9lOY4Y2eR/uPjMEl8VWzXZV5GqJ81E7FxzpYTGPMX34bBLQb5HYtEEhpFk7o914A3p8ZO1+88PpXP+a9KLXN7/pNtQ0UCoIi+AU8aeeDZt2YoySUwxC569SFHd9fTB0WisQJo3A4MK1I82SI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:50:34 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::17d5:b7b7:de4b:9c33]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::17d5:b7b7:de4b:9c33%8]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 16:50:34 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/23] DC Patches October 17th, 2022
Thread-Topic: [PATCH 00/23] DC Patches October 17th, 2022
Thread-Index: AQHY2cpwcZe/2tqwUEe93dDu9Uf/M64Jb2lg
Date: Tue, 11 Oct 2022 16:50:34 +0000
Message-ID: <DS0PR12MB65346909B6D1CFD3110912D09C239@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-11T16:50:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5113c6fa-ad2a-4d02-bb23-1c4dd916588e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-11T16:50:32Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 920a2277-f072-4438-84a6-f897cddc0c8f
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|MN0PR12MB5881:EE_
x-ms-office365-filtering-correlation-id: ff41fcb7-f3c3-491f-01c2-08daaba8b738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2LD4FTkRGKUsnTeT/oO7EH7fYmQ4hk8LBSSVwAqnM4/FFx3XN+FMUImHQs9CDsJGiaISXhSFKYI3yMkC1cafpGi6vX/F/qLISkdn8k7bZaufvwctZS6EKUZRFbUj+i31/gEg15DCFkoWnkY3tKOmInfPR17OdTFeK+prtLmaAIYYvqCba9XkMbOmBdDDdfVU0m5wwgh+QMO08ntOlfnKB0SRUpKJOx1iVV7PSnMRe9obJRBBTbPC058iz3c7VVDgRA/b/42bGx6MM+b5nrq0m0LQHLSv0/7H5u7+kGK78KeDWqf3WT2ekOtHA+2412Blv6nav/Ogy9FS91APrqwDAawBjj9xzaNJV1CgPWavyRBgp28PyrYJAb9+AmZ0XmBShSXbTdZEwNyPLDb6bWgFtgSi1gqju3CtbaUkRH715GvLUagqdO9vTKETOYp+GZ8YB2Akx0uz3LTXzFOGdQER445ivM2KL71qEXu5jlQ3GMpVGnsXyLSGVqW/Rc6xBMLtARfHUZXY7T11EEg377kPJSp0xGbgUy3POuVZtOBf0liE6SnNRdDRdrltN6M0rP5P9F7C8wzW4sj2ORYdywk5eG7X/UGooNhS/2Uw675NNI1NyxlToyGKVuVND76KL4H0VpYxkwyC5YHv1aAkKL4HVENwJGA+e7cNJVmU5W3J8PJJllXLa7pWV3R0tvwsmpu0+F+pqCjGtPndPDY6ZxNhNChCPRovT9/yhN8gXBO4QeGxXhEXtC0FrfgzQ7s7Fyjn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(55016003)(86362001)(38100700002)(316002)(5660300002)(186003)(2906002)(71200400001)(9686003)(76116006)(66556008)(64756008)(54906003)(4326008)(26005)(38070700005)(110136005)(66476007)(66946007)(83380400001)(8676002)(66446008)(8936002)(52536014)(33656002)(6506007)(122000001)(7696005)(41300700001)(478600001)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?625Hwz4yhBwlwzyiyDjWJxmnTs9P8P2B5Hg288Oxsx8Qlgq1kAOcBOJZF7VT?=
 =?us-ascii?Q?yHziLbJQU8f0sUsODfjhZglSNxLDo1UQFA0BGgXDQUvruJqfLcVcZ36p/ryc?=
 =?us-ascii?Q?oXZry9kee5+eFHwx1Sh30sU6wtVLXbdHfss/iuYr30LirlKi4COFuHBn8lOc?=
 =?us-ascii?Q?ig41Av1lb5Y4SHp0Tm4yIFACXFwmpTiew128Q6UKm35tbQUq55dbr2ltXsFB?=
 =?us-ascii?Q?1mmjMaoEUTH6nLADvYOsrFuMSP3xbx8s79Ex99HXw66988qBAuu5H87PaOPG?=
 =?us-ascii?Q?BkqyTHvj1Zz+crXwBu3G5D8yKxeA8XQ+7y3EjNJ2NHqnzuis5sP0x9UUv//b?=
 =?us-ascii?Q?Ioky3yswmUFin/3a7uRDyls4MTxn7es3ThoK10WEXCRz+PKhAfPIqGo/a3bj?=
 =?us-ascii?Q?hHo/93Jr/n0IYZ2bh8N4+LlOpZHKjlWAGfPfgsvX+VsQkBxtAE2jlI74YZfq?=
 =?us-ascii?Q?knzGIC1/oWeU3aYP8jbe7+OQ2S27p0AeT1Mu2T5cl6zVM/WCOAgve9+48CqR?=
 =?us-ascii?Q?gq3u+mjDtScdzzrT94GFoKvBS6JmJWdRDGC2FwijSfy/DeLIRMk19f2oyNHP?=
 =?us-ascii?Q?r+rIjM75dn9jwffX+84q644jvaisiIha+1ejPBM2fVr/PHU/Li+4Enyf1Arg?=
 =?us-ascii?Q?yjjWerr8CYF6Qumv8/SynEL4hRat8LHUm8fXfSOlDw6kfKxq1kciVe4brbNu?=
 =?us-ascii?Q?JOX0bJYno2Ah20XkwhmOiuXQ1SAdAefNRsxMeciYP2eyja81lSrdt2bO7DcN?=
 =?us-ascii?Q?7bmZcQRBISpjq7No1XOta/tW6MLLOto7JtQQrC30+UxTIuUYGJ5ti8d1AD+0?=
 =?us-ascii?Q?/RjWpBeZKlpFftQ2NEZIXs95myE1afK9v0Iy07FeJY9a7fQ1myuJC1EzhvOk?=
 =?us-ascii?Q?KJ29N1dELtX1RFFjHDuF3YAaYfqRAB5EhqPP3Ajy3Hq0tBSBhL8dddc1kVTN?=
 =?us-ascii?Q?0yhmujQczlRHKWg5mYjUF5rpTslm6TOGMBgonTBxwBgpdajuy9Vc/78F9gg/?=
 =?us-ascii?Q?zit5EmXpCCCDb5tiKBkIqYSrykkoX3SnZj0/2wWeW00Le+Gd89L8dDCJK/L0?=
 =?us-ascii?Q?8AuGQQQ2/ajuiiCI0EHMoZjMOXPTGRFdAoKymNnXMRqWfuGyiKElk6XpGVjf?=
 =?us-ascii?Q?v0VSeULVqWbnUPKe4xJb1o3upVpG2fiaUV1+1e5NNXUSrv5Ckwm4kTagDwGn?=
 =?us-ascii?Q?kdrWia+lQFnwLfcYSqfA2p8ruwoxEIYGpqXr1deTCbznBEM5IgLHmMJZ7VKT?=
 =?us-ascii?Q?Sri8ioAu/yRT+CM/l9YSIaWq68AsnLOLBsFFhQ94+SVLrX332VpEgNAuBlGh?=
 =?us-ascii?Q?g12HsOjgZEs9gclaNPEw3oXqZ6x324TSyEaiF8qy9CCXijPcDL6QGZXbL5+O?=
 =?us-ascii?Q?hrq7ig1DYxMNhW7e/qSrkArGDfJRt8KNLHHjZbOpThHYEo1y4SLo2HzPzPt6?=
 =?us-ascii?Q?9TMDPPH0fiktk7pvpyB94ttrl6L08HHTW1ibbv0ejdovBYUxMIMcMJeHp8Zc?=
 =?us-ascii?Q?5mGa0SZgT0J1jxS0przfn4namauU31npP8W0tWkXNhpkJbkeVSc5354Fj9EJ?=
 =?us-ascii?Q?LypScz6+cFAZ+/T8BOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff41fcb7-f3c3-491f-01c2-08daaba8b738
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 16:50:34.2946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpRSku8gGgqe3xhnWj32xjdKChc2FDFGV0L1NFWf4MNKtcm+2xUmsNKOpIBv1B7OV8m0M37W1Xt/Srs0oyCX1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881
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
 Harry" <Harry.Wentland@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

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
The patchset consists of the amd-staging-drm-next branch (Head commit - ) w=
ith new patches added on top of it. This branch is used for both Ubuntu and=
 Chrome OS testing (ChromeOS on a bi-weekly basis).

=20
Tested on Ubuntu 22.04 and Chrome OS
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=20
Sent: October 6, 2022 5:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/23] DC Patches October 17th, 2022

This DC patch-set brings improvements in multiple areas. In summary, we
highlight:

  - PMFW z-state interface update
  - Cursor update refactor
  - Fixes to DSC validation, DCFCLK during Freesync, etc.
  - Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>=20

---

Alvin Lee (2):
  drm/amd/display: Fix watermark calculation
  drm/amd/display: Don't return false if no stream

Aric Cyr (1):
  drm/amd/display: 3.2.207

Aurabindo Pillai (1):
  drm/amd/display: Do not trigger timing sync for phantom pipes

Dillon Varone (4):
  Revert "drm/amd/display: skip commit minimal transition state"
  drm/amd/display: Use correct pixel clock to program DTBCLK DTO's
  drm/amd/display: Acquire FCLK DPM levels on DCN32
  drm/amd/display: Fix bug preventing FCLK Pstate allow message being
    sent

Dmytro Laktyushkin (1):
  drm/amd/display: always allow pstate change when no dpps are active on
    dcn315

Fangzhi Zuo (1):
  drm/amd/display: Validate DSC After Enable All New CRTCs

Josip Pavic (1):
  drm/amd/display: do not compare integers of different widths

Jun Lei (1):
  drm/amd/display: Add a helper to map ODM/MPC/Multi-Plane resources

Martin Leung (1):
  drm/amd/display: zeromem mypipe heap struct before using it

Max Tseng (1):
  drm/amd/display: Use the same cursor info across features

Meenakshikumar Somasundaram (1):
  drm/amd/display: Display does not light up after S4 resume

Nicholas Kazlauskas (1):
  drm/amd/display: Update PMFW z-state interface for DCN314

Rodrigo Siqueira (5):
  drm/amd/display: Add a missing hook to DCN20
  drm/amd/display: Clean some DCN32 macros
  drm/amd/display: Use set_vtotal_min_max to configure OTG VTOTAL
  drm/amd/display: Drop uncessary OTG lock check
  drm/amd/display: Remove wrong pipe control lock

Vladimir Stempen (2):
  drm/amd/display: properly configure DCFCLK when enable/disable
    Freesync
  drm/amd/display: increase hardware status wait time

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn314/dcn314_smu.c    |  11 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  45 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  51 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  49 ++++-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   7 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 147 ++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c  |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 167 +++---------------  ..=
./gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  29 +--  .../gpu/drm/amd/disp=
lay/dc/dcn20/dcn20_hubp.c |  30 ++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  12 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |   1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |   4 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |   1 -
 .../amd/display/dc/dcn314/dcn314_resource.c   |   3 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  11 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   7 +
 .../display/dc/dcn32/dcn32_resource_helpers.c |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |   9 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   9 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  15 +-
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |  98 ++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   5 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   6 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 140 +++++++++++++--
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   1 +
 38 files changed, 635 insertions(+), 268 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/inc/hw/cursor_reg_cache.h

--
2.25.1
