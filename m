Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C8EC67871
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 15:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B43C10E084;
	Mon, 16 Jan 2023 15:29:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ED610E084
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 15:29:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgGz06Be5NXDGrs5KIMAXoQbj4LyiSc/Z6QwYrgUJW8smX1iwWTHw9vNvagoyTgWLzzpvx5wQ72PmZ5k+ipqk3wjoe+KC/QptQckHbBBnxYdNT9MmvPMYxMek3mPUnD1sVKHgrZ1dxvqgEI+oZT/772yXjWjaORPK1F9qrVN+S9dLrBU0OE9AInXXIGD6c/5x6VKVGHkf9+lxYQCFzPA3VV0AECai8mhVN6cFAiLKX/EpztbFVqqThOmZaLsPQ8na9dqbwHq9f7yRQKUTkj9DVoMywdEAgZBojrQe8nYPMwJH+LJOWsyv9vBw2pavZYAwcRCDOZcOb4mSug9pnQCpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTDxJh5e3OytFP+8iif8S76hcY7bizKI6gjg8OnI3o0=;
 b=NC+scEaI0QxVaAt+WbeuFKzda/9qH213yjyn44VNJwQ3iOm/AKDohvWSJwQt9s9k9MJsbrgaeT8nYaExYXWWHhAfbfKEi7AQssg+beXw0kLqM4Lo+AKZKxEcKcfRIgNDQdt55TWle5Cex96GmjXv5vUb+4bmIjCRskOVVp7bKKfb4RLsZYqFBNYlHMHllSzUlGlIZZvfyqeVKHPxM+M2Q4BNOgtYhTnQWf+m8rihsTXhOA0+va6IzQmbkY+r/Ud3zoBcwYtGhrPABfPjLzOxs1bOJjQ25X99dpUdC/ew+kHrrNzrPKGcMi2tYB3hoWLt+AAOYnMq8oVeRPF2zRUxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTDxJh5e3OytFP+8iif8S76hcY7bizKI6gjg8OnI3o0=;
 b=bxnCc6Ju59YaJWPBs2vd1gSBSp5m7sDrK5FdlQeAqIRnN1ZzAlanTj1iBOS4khLzp3TuJXUj0/bD635Y/pfcXDjwP3bWw7j7IYoJHTtaEcqbkkA/oKqbe/4CXUyy5nS6FfFaQAkk3UmWnKI3FyzSqIm9ffxeqcPcUkUcmSJuXDM=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 16 Jan 2023 15:29:22 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::fbe2:dc44:4197:f457%5]) with mapi id 15.20.5986.021; Mon, 16 Jan 2023
 15:29:22 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/37] DC Patches Jan 10, 2023
Thread-Topic: [PATCH 00/37] DC Patches Jan 10, 2023
Thread-Index: AQHZJRSGfUtM1UaXxUyVJiyRSZufua6hM2XA
Date: Mon, 16 Jan 2023 15:29:22 +0000
Message-ID: <DS0PR12MB653492E9AA2221CB1260C2199CC19@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-16T15:29:17Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=c6b02da8-10e1-4f26-aa20-b5d7fe83d57a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-16T15:29:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1e57b4b8-8729-46b1-906c-91bdda6603f7
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ1PR12MB6123:EE_
x-ms-office365-filtering-correlation-id: 48dfb63f-53a6-4c2c-a347-08daf7d6713c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLLqr4qn/77+EC2usJ+uv1/TXV6+X7VA9hPdmSp50ifcXoDhscWlEjVlDCXncW+jMkjRPlQCgGNYXlOFC4Sb6itQSZNhCsIYZIZkPUkEcIVQld6F0UClt+q/v4fe8x7AXAsrs+qpYc/iPP+xsuZDoSvwAWXhdGamW6T8NV2kZ2Vs8inq07HvUa+xA/NxfbjQgKUfzO04He8mj61Ing3hWBWspJUxQryP181otQEDgiaI2O7esDoG3yM+vfjkgUb6q38xbc1fJ+jM8ib72i/leRBNP/AtVEplPAgCfVW9JxAiVOfZFAE2BtEsJ8T7nqnEmkIKaJttQpSZd9cN+rmUIsAFqTo8SrStG7chZdRPppWEN6dKACqQvrFuYZbElP7TnFJ3MYBQpV/1eoH/6j68NfbFPQ2jxwAUCitFsHgXiriJqkrwZJjXDed7ht7KIYnUNuvt3WONT93/0X5oIuA46XQXSdMqrzSxNBOj/VeqHafRHeZg0xvJE3t2y9yKRlnf1igRDlDgHDwE+8AT39opBbe/Tbs2gy+UtWRzVExK7iHd6OZSjsMTmRmd//2J7gnH7U895/IywCX/cGws8UdCJYg0xODJu6x6ZSZt2I9oQH9VuFJV2qHIk1wkqzXiDM6yGrmez1XnGCLg+6sjg9Six3pevY9/YFBIIbYC9rAXL7AUrBMv/VWgo100NBl+4IHgswKo/f6Eb8JcEyVMF3SZGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(64756008)(76116006)(478600001)(316002)(33656002)(66446008)(66476007)(4326008)(30864003)(66946007)(5660300002)(2906002)(8936002)(8676002)(122000001)(83380400001)(52536014)(38100700002)(71200400001)(54906003)(66556008)(38070700005)(86362001)(110136005)(41300700001)(186003)(53546011)(55016003)(9686003)(6506007)(7696005)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?75BGO9z4nKleMJLEXKy3GsR2+2DQhQ64H9czdnBOxB16ESOHKKtuPBPMcAE+?=
 =?us-ascii?Q?U2iDY1CTohTPlZ0pPcMhTXq+YVc0vkx1bHrBxhJmMsSTv2xm5BEGyJwtcouP?=
 =?us-ascii?Q?0DcdHEx7il61UeKo1LwHBLguW7AbhnwRGshrbkY6oYPzIoqtPno5pExmMR8z?=
 =?us-ascii?Q?SNBE5pjhKpZkCpsFy9AN9QizBMJfid45gnb5BnfqYOHv46N4LsjeOAqM6mjX?=
 =?us-ascii?Q?/Fm6mL07+QEnGQNOq7aytISSzHaGesfreqVGcdt9URoxDWl8gSo33nFnfKMZ?=
 =?us-ascii?Q?kApOz4dUuHjqeOlRHDzPr2GguvDCaUiHyGpc5ZHlTkln+3if+1qlNIRUHqH4?=
 =?us-ascii?Q?G3bmw3Vl13Wh2+6VrA7tM6OixTSJj0Rzlt2Qk0lsP0Q+Pjag+EgGw1L4fjFK?=
 =?us-ascii?Q?5w1iT3/vR+fnG721xIz93Xgcm6TCGxTlPGDyquplFt/eBrpT9WGkP7z2IfRr?=
 =?us-ascii?Q?4mGLoNRZaIP1L7BzH1RW0JLz9X7plQHCzhGEhpPJbAKaZgm7qVhkgnKKb0HS?=
 =?us-ascii?Q?HAtuDQz4Q5B8/jxWO1qmePnWGwMcgn72TF1cErHh3XY4cpgshW2HmL8ieO9x?=
 =?us-ascii?Q?LyROiNjrygMwmzxbICQsx8r46Z1pSV2TaBgc8x71ZeMx4x8e40EiadZBhnLW?=
 =?us-ascii?Q?mJp7f3bGpfRMx4dWKiUiKoOltcV96ag5K4ohGfaQ12og08QVDv/TOB/gGzgC?=
 =?us-ascii?Q?MGOoOUOBzK+DluGxDZ5jrEwGXXz6Mnn5sY4tu9vv1mHcmmWxe+ItN+ecbGH4?=
 =?us-ascii?Q?AUxYPyFK3TwKECIW3GAON0zopI4xuKlozMx/55UCXwJdmuIV6VzIfQd87svQ?=
 =?us-ascii?Q?RDFhnpfF6Khy2yB3kJC4/Jdx2Pg04b84ySbIC6T4ageU46JGHb0diPMl6jk4?=
 =?us-ascii?Q?7sYznsgq5qHjwja7z6znpNZIwPmjm1kX3of2AgAmg5mOUZD4EO+Acbin+crn?=
 =?us-ascii?Q?s6KtGSJKJ8T4CkpMrsExi/VRFbLxI4ZisYrPf/qCasrNQZd68sKIXgqLhHA4?=
 =?us-ascii?Q?Lj9cLZqeoU0U+2T7VjLk9uZ9Wjj1zYnvnlq12fE2TPJOyj5ofEo18fyJV927?=
 =?us-ascii?Q?ezBsZskfCfudhn0vn/zbIbu1bDQEH3ddV5UlDL9Sz1hSPJ9CPEzh8CMiz9Sj?=
 =?us-ascii?Q?KaFiHjVsi9+K0kvR/cI5WszIOkuTBivUU7KkQRB5LPxWB+7BONH44NFEXz3E?=
 =?us-ascii?Q?Q/HnMvJ7WGz2jXSEcEN6pMvYBzFA00Ee1g7+p5jUNxH5dthx+GOWkQN+kjs5?=
 =?us-ascii?Q?qLDsO3/HUw2X9Uq3EE8v/LY4hTW8KntmAj+94ohC3QS+IAQoqn72f+mt+XjM?=
 =?us-ascii?Q?riOe9cJoBTlSOV3sPBRO5m2hKfu8ahxhV0F9Z6d6n8HtNb/ApQs0smZfGrsf?=
 =?us-ascii?Q?umFwrFgPCVyL96rZjyKPnTR7AnbA2dJ/3+LptW5RUvMEI0Cap2KlFeWq9yMt?=
 =?us-ascii?Q?OSZUYB9cwJ0mqlCc7j0Tgd7c1AefN5akEYVAWGi2NcVcH6FrMvLxteiClvNo?=
 =?us-ascii?Q?NScouRUToVoGimBW0zu8MY5w7eWwvABD8emdtdyhTz9AgFiSFNS/UDbReX31?=
 =?us-ascii?Q?zTksAe94uFxq1vfbad4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dfb63f-53a6-4c2c-a347-08daf7d6713c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 15:29:22.0895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riLa0jPi1MezbbWRZ0V2+ISXvlWJFMrmUfCdJqh8TgxbrvND2mEs/Oyxp5P1a4TM4CFLWyGrtOugrnpIlP6TPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123
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
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Mahfooz,
 Hamza" <Hamza.Mahfooz@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [4500U, 5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[=
6600U])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
HP Hook G2 with 1 and 2 4k60 Displays
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 004=
cf26320ba drm/amd/display: 3.2.217) with new patches added on top of it. Th=
is branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-w=
eekly basis).

=20
Tested on Ubuntu 22.04.1 and Chrome OS
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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>=20
Sent: January 10, 2023 11:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Zuo, Jerry <J=
erry.Zuo@amd.com>; Mahfooz, Hamza <Hamza.Mahfooz@amd.com>; Wheeler, Daniel =
<Daniel.Wheeler@amd.com>
Subject: [PATCH 00/37] DC Patches Jan 10, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light the following areas:
   =20
- Revert patches that caused regressions associated with audio and an
  old change that checks the DCN version.
- Refactor DDC and HDP.
- Move DPIA and DPCD logic to new files.
- Updates to DMUB.
- Optimization and bug fixes for SUBVP/DRR.
- Drop legacy code.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Request min clocks after disabling pipes on init
  drm/amd/display: Allow subvp on vactive pipes that are 2560x1440@60

Aric Cyr (1):
  drm/amd/display: 3.2.218

Aurabindo Pillai (2):
  Revert "drm/amd/display: Demote Error Level When ODM Transition
    Supported"
  drm/amd/display: fix an error check condition for synced pipes

Bhawanpreet Lakha (1):
  drm/amd/display: Change i2c speed for hdcp

Brandon Syu (1):
  drm/amd/display: fix mapping to non-allocated address

Charlene Liu (2):
  drm/amd/display: add hubbub_init related
  drm/amd/display: contional remove disable dig_fifo when blank

Cruise Hung (1):
  drm/amd/display: Fix DPIA link encoder assignment issue

Dillon Varone (9):
  drm/amd/display: Implement FIFO enable sequence on DCN32
  drm/amd/display: Optimize subvp and drr validation
  drm/amd/display: Account for DCC Meta pitch in DML MALL surface
    calculations
  drm/amd/display: Account for Subvp Phantoms in DML MALL surface
    calculations
  drm/amd/display: Use DML for MALL SS and Subvp allocation calculations
  drm/amd/display: cleanup function args in dml
  drm/amd/display: set active bit for desktop with VSDBv3
  drm/amd/display: Remove DISPCLK dentist programming for dcn32
  drm/amd/display: Account for MPO planes in dcn32 mall alloc
    calculations

Dmytro Laktyushkin (1):
  drm/amd/display: fix multi edp panel instancing

Martin Leung (1):
  Revert "drm/amd/display: Speed up DML fast_validate path"

Mustapha Ghaddar (2):
  drm/amd/display: Update BW alloc after new DMUB logic
  drm/amd/display: Update dmub header to match DMUB

Rodrigo Siqueira (1):
  drm/amd/display: Remove unused code

Saaem Rizvi (2):
  drm/amd/display: Remove SubVp support if src/dst rect does not equal
    stream timing
  drm/amd/display: Add extra mblk for DCC

Tony Tascioglu (2):
  drm/amd/display: Optimize link power-down when link powered externally
  drm/amd/display: Skip backlight control delay on external powered
    links

Wenjing Liu (7):
  drm/amd/display: refactor hpd logic from dc_link to link_hpd
  drm/amd/display: refactor ddc logic from dc_link_ddc to link_ddc
  drm/amd/display: move dpcd logic from dc_link_dpcd to link_dpcd
  drm/amd/display: move dc_link_dpia logic to link_dp_dpia
  drm/amd/display: move dp link training logic to link_dp_training
  drm/amd/display: move dp phy related logic to link_dp_phy
  drm/amd/display: move dp capability related logic to
    link_dp_capability

hersen wu (2):
  drm/amd/display: phase2 enable mst hdcp multiple displays
  drm/amd/display: hdcp not enabled on connector 0

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  153 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |    5 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    2 -
 drivers/gpu/drm/amd/display/dc/Makefile       |    6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    1 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |    6 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   14 +-
 .../drm/amd/display/dc/bios/command_table2.h  |    3 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   97 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  542 +-  .../gpu/drm/amd/d=
isplay/dc/core/dc_link_dp.c  | 6682 ++---------------
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   60 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   35 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h |   28 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |    3 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  114 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   69 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |    2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |    1 -
 .../display/dc/dce110/dce110_hw_sequencer.c   |   41 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |    2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    4 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |    1 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |    2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   10 +-
 .../amd/display/dc/dcn20/dcn20_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |    6 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |    2 +-
 .../display/dc/dcn201/dcn201_link_encoder.c   |    1 -
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |    1 -
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |    1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    6 +-
 .../dc/dcn301/dcn301_dio_link_encoder.c       |    1 -
 .../amd/display/dc/dcn302/dcn302_resource.c   |   16 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |    6 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |    1 -
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   |   18 +
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   |   10 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    9 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |    5 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |    4 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |    2 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |    1 -
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   30 +-
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |   29 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |   17 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |    6 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  176 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |    6 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   15 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  183 +-
 .../dc/dcn321/dcn321_dio_link_encoder.c       |    1 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |    6 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  108 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   43 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   33 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |    5 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |    1 -
 .../drm/amd/display/dc/dml/display_mode_vba.c |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |    1 +
 .../display/dc/gpio/dcn20/hw_factory_dcn20.c  |    6 +-
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |    6 +-
 .../display/dc/gpio/dcn32/hw_factory_dcn32.c  |    6 +-
 .../gpu/drm/amd/display/dc/gpio/ddc_regs.h    |    7 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    5 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    6 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_ddc.h  |  133 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  160 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  105 -
 .../drm/amd/display/dc/inc/hw/aux_engine.h    |    8 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   92 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    6 +-
 .../{core/dc_link_ddc.c =3D> link/link_ddc.c}   |  409 +-
 .../i2caux_interface.h =3D> dc/link/link_ddc.h} |   70 +-
 .../amd/display/dc/link/link_dp_capability.c  | 2169 ++++++
 .../amd/display/dc/link/link_dp_capability.h  |   66 +
 .../drm/amd/display/dc/link/link_dp_dpia.c    |  107 +
 .../drm/amd/display/dc/link/link_dp_dpia.h    |   43 +
 .../drm/amd/display/dc/link/link_dp_dpia_bw.h |   47 +-
 .../gpu/drm/amd/display/dc/link/link_dp_phy.c |  145 +
 .../gpu/drm/amd/display/dc/link/link_dp_phy.h |   51 +
 .../amd/display/dc/link/link_dp_training.c    | 1700 +++++
 .../amd/display/dc/link/link_dp_training.h    |  179 +
 .../dc/link/link_dp_training_128b_132b.c      |  260 +
 .../dc/link/link_dp_training_128b_132b.h      |   42 +
 .../display/dc/link/link_dp_training_8b_10b.c |  415 +
 .../display/dc/link/link_dp_training_8b_10b.h |   61 +
 .../dc/link/link_dp_training_auxless.c        |   80 +
 .../dc/link/link_dp_training_auxless.h        |   35 +
 .../link_dp_training_dpia.c}                  |  308 +-
 .../display/dc/link/link_dp_training_dpia.h   |   41 +
 .../link_dp_training_fixed_vs_pe_retimer.c    |  580 ++
 .../link_dp_training_fixed_vs_pe_retimer.h    |   45 +
 .../{core/dc_link_dpcd.c =3D> link/link_dpcd.c} |   13 +-
 .../amd/display/dc/{inc =3D> link}/link_dpcd.h  |    5 +-
 .../gpu/drm/amd/display/dc/link/link_hpd.c    |  240 +
 .../gpu/drm/amd/display/dc/link/link_hpd.h    |   47 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   16 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  168 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   22 +-
 .../amd/display/include/ddc_service_types.h   |    5 +
 .../amd/display/modules/freesync/freesync.c   |   64 +-
 112 files changed, 8789 insertions(+), 7854 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/dc_hdmi_types.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_ddc.c =3D> link/link_d=
dc.c} (57%)  rename drivers/gpu/drm/amd/display/{include/i2caux_interface.h=
 =3D> dc/link/link_ddc.h} (52%)  create mode 100644 drivers/gpu/drm/amd/dis=
play/dc/link/link_dp_capability.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_capability.=
h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_phy.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_12=
8b_132b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_12=
8b_132b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b=
_10b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_8b=
_10b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_au=
xless.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_au=
xless.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpia.c =3D> link/link_=
dp_training_dpia.c} (83%)  create mode 100644 drivers/gpu/drm/amd/display/d=
c/link/link_dp_training_dpia.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_fi=
xed_vs_pe_retimer.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_training_fi=
xed_vs_pe_retimer.h
 rename drivers/gpu/drm/amd/display/dc/{core/dc_link_dpcd.c =3D> link/link_=
dpcd.c} (97%)  rename drivers/gpu/drm/amd/display/dc/{inc =3D> link}/link_d=
pcd.h (95%)  create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hp=
d.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_hpd.h

--
2.39.0
