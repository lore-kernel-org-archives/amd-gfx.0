Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8071DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 14:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F32D57ACDA;
	Mon,  6 Dec 2021 14:11:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B82257ACDA
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 14:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfkK2AzfLPuMvlD88iozJ7m3mhvEsOP1FV9cyWdhM5TAQmMeBqu2KSC8dxrgm6ZiPugVwlTQIzrjuckY1y2sCvphN6NGIXaEHLQI4BRbKw/qqENSTGmd0OmCDBQqOMehFew6CvT1y2tIbjbEPfhXk8fH78W20Djm1uthCMgrLy3fGoSRoR3V6Gsa/eC42rvRIQa3pmvn9uE59znu+refBVrEzP4fPKms4D4Yg0sANOVf27KEyqswaCku/fVZ7Gv9Z6cq2mbL0po24dvL9xPDRM2kqYYN55DB8wfHgStBntkUYqUzseHvpRzcE2mqydiPIVdgDSosbklTaN5tvv5SgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MHewoz1UxdzE3Bi7eKQFBzTqdFPiu1Vrve7fLpVLT4=;
 b=ZuOD85YcjbsaCJTqT5t4v3Q6r0FrtM8Vy1dGvoLEXq+VxTY5/YdcurK9Cb1cxmIF8m/8RBWYvF6ehl6aD5A1vnWh+PaY82LlNMlorQZqURnSAYhqwViH6S6m93DFP2pFWxPcDHDg+7RV+lEs3jP+Tgq1V7kocC10yAdJFV7YGvLuiAjHgVHTIibJDmP8pTUsx6khv52LrNSB3JFyQi2cDIFaAxT9pHAuSnciDb4Qsmc2rynu8PKHxf7LzM+z5a/IaBPfRTY2ijmsUvsgBFjt7rqQefiiM1wAVmfoaL5OWPu+ni6M0n9nZg4ZR2oS+5tEUeC+RsbqZzASmvng0aeHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MHewoz1UxdzE3Bi7eKQFBzTqdFPiu1Vrve7fLpVLT4=;
 b=Q0KP38kGASvLzNnJdhvMZBRstdGOkZmh6dBcltb0y74+oTuLIkdeEDvdQ3KF0T07sC776ts0YZ/XERStROGMoyVRBoKEQyft+ByeLyDZljjneMugJ660cavDh8hS+7Vk5/NtthQOwX84zdUeBs11rqxwhyga8mPRKyQ057i0B70=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM5PR1201MB0090.namprd12.prod.outlook.com (2603:10b6:4:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 14:11:44 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::88c5:51dc:ed5a:6f5a%6]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 14:11:44 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Kotarac, Pavle" <Pavle.Kotarac@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: DC Patches January 10, 2020 3.2.165
Thread-Topic: DC Patches January 10, 2020 3.2.165
Thread-Index: AQHX6JlRhcWGLxBBwE61eu0bpluQMqwlhPdQ
Date: Mon, 6 Dec 2021 14:11:44 +0000
Message-ID: <DM6PR12MB3529C542CEA08FB1AAE64E1B9C6D9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-06T14:10:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=94442644-3b83-4ebe-a00d-0b5c2a45ef10;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-06T14:11:42Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 40cfc13d-a245-46b4-909e-53fffe20a708
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86bc360f-6756-4e85-b721-08d9b8c2556e
x-ms-traffictypediagnostic: DM5PR1201MB0090:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB00906131890139E149AC37549C6D9@DM5PR1201MB0090.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9DLXGrnI6g60ZiGF1OCncdmtQwpgLLP/Qgf550N4Tu7dW4rlcp3SY4epS6e1kr57EjfkiPxZmvZym/lKX4H6oS/Ve85CJvw83MKmH5Hz/Rf5uS3+DPIm/K8xnL+I3isD8fLxBJrHjfCQkkuVoTIivDjOC7VTQJvyX2VSgAZ1Wed+uSCs0JOxsjnw/aoWgxFL8GrU3X0yFqEMfNZH/IhGmxl9zqG4iY1uyXOMa72MtAIkoflEOdtuiXdVgxBg+8DQ7anyvX1U5cG1cEbVAhY3rGQ57XyAM92woNkmP7IsgkD6/HBUXSu/3iu/OoV57Enn0HLTCbsVbP09oF7W2iaet06gIN7NGaMpchrdOjcT053L3TcTXMILSNC1sIIpYLrg3FaYHnKwdSTAmqX5HdUZdVAVpj1WuEwKYkl3dfb/xAVLpEqxutOhJ4RkTup4X8QxvjMutD9zsHFu9gfijAvctfsmbjR025KJwBzk9JZuQM/B9uTG5D6iWCh80Ofa6j8ehOIP1ta7M2wNOLfe56c4qyrM/algI5TDoLx6yE3Y5M8MTIXRVf5LRzysqRmVgbQ/M8Yr5rZjX31iS5KNlTJm5FMyL/c5e51xqjodtL1/pKTq8StdfnmJTCFJQsgXberW0Fdmm9i8+8QTMGAW81DoqFKEfkX2H6+nZTqur8YvK0vluW9LSOyGBopekOQ6BCwOso/KChACtvmUrjzciHotw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(71200400001)(8936002)(83380400001)(4326008)(122000001)(26005)(55016003)(316002)(53546011)(9686003)(508600001)(66556008)(66476007)(66946007)(86362001)(66446008)(64756008)(38070700005)(2906002)(6506007)(38100700002)(5660300002)(52536014)(186003)(33656002)(8676002)(7696005)(110136005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3KGN/XUQAA3tEvdTE1E2bnlLv1uORuZihf8T0AlzGt/Iq2tIIDajTe8pebu?=
 =?us-ascii?Q?AV39wrC0dZ+XM7ZfS9ENUeBQuZxB86Tx473P5X+RhfBZMVJFVB2LOhv65uof?=
 =?us-ascii?Q?dt+BTO3/UkulkFJ7JnOHrqguNuhTICU8dg2bHuK8LGmVvrmmQ62opzgolTag?=
 =?us-ascii?Q?oCHVZfjjYYzZmNu3FiPiM3plJRaHDoE/JJDFshVLsNOlUNg9QnhVKvOMnswB?=
 =?us-ascii?Q?jWMlLahGCg7FhpYHVIjvi4j8YpuiicGnguZn6IJYwmDjOEBU+RLXgEdqaFyE?=
 =?us-ascii?Q?ZUv3NIp5fmsEVlX+JiLNojgfTK6ssxI6sFgWihrMNtF1MHrFARE56h0IKGUA?=
 =?us-ascii?Q?oLtRNa+Z9LZYh5kuampbcIUyc0xUMvK+HiUCeQ0aF0TwDCc5pRqPENc40bpZ?=
 =?us-ascii?Q?OBQL0E0iDcqzON6gOr8pgJN48Th82U5LdwaDhl+jbyDWdU/y6hyIIImsyuug?=
 =?us-ascii?Q?dKrQvDL7sQ9+82NkA4ZW9QtzklqO+R2h+SVbsmO/gv2LpsWRXyTie2JUzKMn?=
 =?us-ascii?Q?kK5CgdR6oQnzslFTyJpE+wwLp6d6lDIIA0gbvMDvP3yvzYycth9z7UG+x4be?=
 =?us-ascii?Q?OzYbaU7DfSOKptyf1eu1UglQ0g9vrROAVH0wlmCz1EQR7RiokghYZT/pimBk?=
 =?us-ascii?Q?uxvME3ZM3X+HqPI7ptLMiyUUusQu1ieDKzK9IbjuvfjWDAZjlwLALZDDUwAl?=
 =?us-ascii?Q?ZOoVGqLo38OycC+16bmuAcfm/XTCRXN5nXNOX6hfBSkbqPGPdaEXPK3F2vws?=
 =?us-ascii?Q?A6zIx9J+8uvT1krSGMa8Yop92JmFSUvZvrZB3gHaN7wjwZzbaSqNy86HDjmK?=
 =?us-ascii?Q?+VFCr1LuzxBGZYg18GwcxfJ+MAflDj7Wn+IEImHfAZMWFDiY7VrY0J1Q7a2x?=
 =?us-ascii?Q?OioXU7Q+hlz8NDhpKmc8PLNKrYDJKEfGsPdFTxmx7oBoK+Y9q25KRt8L7W6o?=
 =?us-ascii?Q?LVm66eVTUOUqfVVzfbNI2cdzrDa8Em0hQWMelO16j6CvDKWiS44sh9gBbafK?=
 =?us-ascii?Q?JQbHrl7NofbxY+iFB76I1vCGOAFm4fwil7eGF0JL5iYn/grcZgxtsu/D2+v6?=
 =?us-ascii?Q?PcabcftES6d23efMbg+y5h1H14Hf71tYULXHTGdT1/byCJyrTlHPdYO7LX3D?=
 =?us-ascii?Q?CFDuZYbW3V9wfL6aN4Ec7UUzEfShzq+/JpSrJ2z35+3tKEJD3oL5hrYKUhAh?=
 =?us-ascii?Q?Dhz/2MxQOxGkQXlQOGsnhjrJUU4OjoZyod8ApbnSIbXeNITAdbINrllq2L4o?=
 =?us-ascii?Q?nr8tZk+xEVpB4Fq9rZkvFICN8E6+kLTf9xisZzMzCfej+deXMfilPz9G8ARP?=
 =?us-ascii?Q?wL5qncq+YLGdN4ClaWhB592pqPD6nH50eC6ErRaUVZL2OQfvfzuUfb18oTrE?=
 =?us-ascii?Q?idMaaHXbcYzZdys6Ql/SERCxBhGbA2xFK+3RvwkOeblKxzEQyNjOBxpQHEZR?=
 =?us-ascii?Q?ygveBht96UoOXnArl6o7SJscIHIIZcY0F+cQFNMQZdNNFo6AdAVqNB0HwJyj?=
 =?us-ascii?Q?tN+UFLm8rJqJtfnAVa56s1VxDY8bhTFAKsVjJLPip50nOqZEF/4vGHbGZODm?=
 =?us-ascii?Q?KD0CBpBJ1pvZHMKUkHRiEhES+CjjkPZGDgDLs2I4rALIP0dDlAxchcOFtq6n?=
 =?us-ascii?Q?Kck3U+C/QX0JRoI4fGlCp1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bc360f-6756-4e85-b721-08d9b8c2556e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 14:11:44.3492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raW2CSK/Psq9G4Sd68z+jYBRrYxAhNyGKx7IX6mzLV7CGFKn9+uDqyV5l8P9VEOfGwgYs8piG4hTZt40KFRLsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0090
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Li, Sun peng \(Leo\)" <Sunpeng.Li@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, 
 Roman" <Roman.Li@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland, 
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2 with AMD Ryzen 5 5650U, with the following displa=
y types: eDP 1080p 60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via =
USB-C to DP/HDMI), 1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=20
Sapphire Pulse RX5700XT with the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=20
Reference AMD RX6800 with the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=20
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems. Also tested DSC via USB-C to DP DSC Hub with 3x 4k 6=
0hz on Ryzen 9 5900h and Ryzen 5 4500u.
=20
Tested on Ubuntu 20.04.3 with Kernel Version 5.13
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com =20

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Pavle Ko=
tarac
Sent: December 3, 2021 5:58 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Siq=
ueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Ja=
cob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.c=
om>; Lin, Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>=
; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agust=
in.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: DC Patches January 10, 2020 3.2.165

This new DC version brings improvements in the following areas:
    - Improvements for USB4;
    - Isolate FPU code for DCN20, DCN301, and DSC;
    - Fixes on Linking training;
    - Refactoring some parts of the code, such as PSR;








