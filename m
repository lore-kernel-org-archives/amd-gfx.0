Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938BAC64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 15:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070E810E420;
	Mon, 27 Feb 2023 15:14:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E604910E420
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 15:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnAQ/EhcVbfwWbrZLX+gtSZkZ2MgYr7mbUbUSFu072KxIaEZb9DbFGcPM3NfxSsEL9p2pgKwDkTocRGbqQH6kUAqBU+mm4TzY6mrFQTGUWLlGXtg/809LDRm/wDlSFSKIVn1k3y9cRIHtKOOZSZN6ksPUh2avaxhQGjAwWPkPEWrdJS87yD12r7ed2gNEenZcdHACIY9WIH7E8b5opyzHpQ/rr7m5n0gJhdjiEobVBvcwtVjnHr3e125fvBGrG2bXf+/gaszbWAfRveGj0ps7YjdMdS1/7XR/+qBm1LWrioYcuaWPtUVCh6p/YSDoo5Nxh7p0W9glH90lXjp29rIgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALd+Xgzvg7vx+5gtTjEaV/rdPwEOi23R/2CL20mDefo=;
 b=ithcs4VjKOzP4HwN9B2Mszk6NK+h2hqSsyph3pux+EeeZaG9aN2//18HwH0FHRTzlOVtdmNG5rEA7FLO6UA4tocqxiI/veXU0i0NFR9v3nIppBNpUy8aL8R/HnuKt/pDuiiNAcB7emxqUAu6jp28lSf0wonhHMfcOT64kpCYNBeLnNaR/pWHRADuvrbfx+NNYaWJVe/4ZT0CTO3wvaWQGk+MBTXw5Oo3YJOHQPTZsIYPqjLzR3AQM6bdNkfKIRNzEl6YnsmJ1CXuW95fWrj37IkDHcNQEif4iOcr6BQlRe9swy5TbO3Vo0KmgosjafFpkiuh2+r72ylZCzAole/hSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALd+Xgzvg7vx+5gtTjEaV/rdPwEOi23R/2CL20mDefo=;
 b=bpUQ3Q7j46r/5xmsuWWD9d69NRgz3w5MNrTzPl2I9L5aJzJbu2cbRRioDlIXJO6AhWfNYYOdcf46BxYDGDqxnsfbUWjtDIc7xjV3IQrZgSIQFfAxMixNi8a5OSV7xYe1yK/xbgYoCpN3VpdEx+6NGIqzQ5AFGSvK+om+gxkhkbA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Mon, 27 Feb
 2023 15:14:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::87f1:8402:36ef:18d2%9]) with mapi id 15.20.6134.025; Mon, 27 Feb 2023
 15:14:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/20] DC Patches Feb 27th, 2023
Thread-Topic: [PATCH 00/20] DC Patches Feb 27th, 2023
Thread-Index: AQHZRoikJs5BN7/95E+ISVvJEUQrKa7i72Cw
Date: Mon, 27 Feb 2023 15:14:54 +0000
Message-ID: <DS0PR12MB6534E07CE7FB3509BA638F0F9CAF9@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-27T15:14:52Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f506888d-09c2-4d2f-aaa4-d1e9b790d536;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-27T15:14:52Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3afd3857-74b5-47f0-aad7-3eb1965fa64b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB5925:EE_
x-ms-office365-filtering-correlation-id: b4f85656-a510-4a7f-4b7f-08db18d56146
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YziaXmSxoJGS1Xx1Vo6U7ZuJ2fE5f6Uyg2nIz0JTRv6K7qHKvT+uyXSjbz7aSDybCyZHF+EYdXMXjq3blPnyTj1YgEOlT8uw3f3nmR5Nvf//33CysN2qW7sFrcHTuP31VEYkDMditlvBn74hm2xVKnhKA8ok/RGjAAUJh16rhRD/jLq7az0KfSa9WhgFqcS0wSueEaEeP9ybUGkCt7eMOhs5oWwgT4Rg2F4M8Pdg2f+S3AIaIqY6Gxhk1jKcvKVijWldad/vXIX6Odab/iBj2rP82iUijC2RMGG5inkdTGGujv+ynxwAqk13KIdGaXdN+9cC7czZXlVMoWJsz7nm08NhfztrQL/ml51FBmwdt4rmMZZ1MtH1tZ0yZ9YTLXcK9HbrPcOai2nW8dtG5CuAa0QKdxqnteC1qE1hOaIkSyFOfxOzyJVijMQYz0LsaCyJ6jLBeLmMXBSHxUbmTZ21xdYbBysrrBsvliTlqI1HNJe53ZKR1KXuOF0wk3gPzOJydlS+8AC5TmIXGtDYl1RXUDdAokPr/Zdr7wSHI9IN4jvWZf/UX9dAY+L81EjLpm9cKc58PXFG0CRUvI/odgaNtn2fRFES8qUAzejq6BLSfBz27qE0eXhkrW03YLkGKi9imFdZy9Pz7FrD3IOumkMA8HGKHtAOrteLbQWjOEKODwZkR/61bPxF12JuN/9SRneK0l7JZb7G1H33iLgHP+7AA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199018)(83380400001)(186003)(55016003)(33656002)(122000001)(9686003)(38100700002)(86362001)(316002)(76116006)(38070700005)(53546011)(26005)(7696005)(71200400001)(6506007)(4326008)(8936002)(110136005)(478600001)(2906002)(54906003)(5660300002)(64756008)(41300700001)(66446008)(8676002)(66476007)(66556008)(66946007)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zRdSDQQL5gBYzBGTNSilIQW7lQ0IVUbqVJbPQXZtSAC2awXMnMYny+RASD3k?=
 =?us-ascii?Q?R428+E5lesYSKIM04NhhUkIvasUAirtXj6dq8IYJUNOxkWUExTzs5oOhAP1v?=
 =?us-ascii?Q?AEpUXttFn36lXLP7BRfS1SulQSY6hjrSlDpZPP9m8FYegIM54j/8lX08I8IR?=
 =?us-ascii?Q?s0q3lReUbdICP8bzaI5DqIUO33D4Z+oTgbpEg+Fc6kepWUhnkiIlM9mDzKVd?=
 =?us-ascii?Q?HUfaqlfBh7td/edJbnyznzIG/abXM75pOcfeVPu7f9+36MFcGDkKSZZNTO0c?=
 =?us-ascii?Q?Jw1JPkebC1sXFAy7+B4Y5e/Bi5zxI63P9IGUCJVulS3EvCfbM5SQE5p4Bc7U?=
 =?us-ascii?Q?HIjcQGKa3YgPcNj2zIA8Gvg93MViq4crOA7k6uxKv/HrH+VDXPRh5BHhXo3M?=
 =?us-ascii?Q?pfvSFcqvwOiSmQHR2IQ0UV6K+1qUcJtRnosPZFEHvpr9ybVi2HYKZe2NRTvl?=
 =?us-ascii?Q?ZfZEy36rsOhCqFNDlanDovJKDAYEpKb11cVQ9MWzNMp/0HBjKFEXQ1sJzOe7?=
 =?us-ascii?Q?0d8jrUaaLWs5mGU32UFh1UHJHE8uJDDLZ8yzdunfVwjTc5Gpn5BFvsT6y/Fo?=
 =?us-ascii?Q?zSNhW94FaodxEn0dj3VZQTqLpjazJejQlqY1Kw4foiiqhTTzvFIMT3bcmA51?=
 =?us-ascii?Q?Fi6b4iVF/p6iMm4FWGXlI/vETHXxhU2BQHlUruO/6uy67/Yg/PtV6XeX7R4s?=
 =?us-ascii?Q?O/fqA10AJm4owr+79MWLuoA2oj+6RKuFVIYTZwZPm6roY+Uw0BWgJftN/XKj?=
 =?us-ascii?Q?OSkTGXF8oK8zacX84dml0RHZstB1YJUglR+Y/gz3PAj6+ZvhPoq88yvGAx0V?=
 =?us-ascii?Q?HxZZGAvC0VENjXgTUP/yZATyekHe69hcSxEwpa4REzVtmd/i+QahR50w7WeD?=
 =?us-ascii?Q?aJpzelJDL34p/fy4DMmulETnauhGIddcyrDgOFMWUm69yLpmuHPwfK71teXN?=
 =?us-ascii?Q?ihMHF2eobl/8CHXAxM6Tbgo3ZY/+26pEscjgJD0wA8RirfroRZq7DN12/Q6c?=
 =?us-ascii?Q?R7PU/l+nrd2OaafgXC8tPJrjekpTB65kw59H8qJvpxblvts696CnjPsxiJAZ?=
 =?us-ascii?Q?ZAE9bkOmB9f3ZOh3M3ONWWUwz0pI/t1QwHT0lSNzNPlX6IzioVl4+3n62izW?=
 =?us-ascii?Q?Evohy2se87q8e3bOwLeohBqiECsetsRz8Bs9zkqsp5JUqP47EzGBO9dS6xRw?=
 =?us-ascii?Q?rT70CWWyaDJuTmJW36UORGZZc6nLqZIzcGMpaCTX9aDFvg8K9PVPLOrom6l4?=
 =?us-ascii?Q?KvN/mPlHKSkz+aj+2bFtUOKgCVp9ERSbhVSzvbQFe6lU9u6mKEmJuqzeO13W?=
 =?us-ascii?Q?ntw3oaVdxE2CqtEnMFfQ+xPQB9nrWByDkjsCV4lgpSCBlIc+60nZSrlSckrd?=
 =?us-ascii?Q?iYAPX8DFSSljEMo9SwNDn0/vN/mEYIOLWOnuDOQ9QIP6JZ7hcVjwSOwuPGgO?=
 =?us-ascii?Q?t+qh0UfO6YRIelcO2g2omKbKbuUHuTZIWPTcwDIVtc2oQA6DH9oa8jyYXXW4?=
 =?us-ascii?Q?uXtJowwoP2Igenk6euDatyOi7cTUcDQMgYWSNu66KbZ9x1aHCu/7yD2cPIqQ?=
 =?us-ascii?Q?pDaET6jG8ty86zipIP0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f85656-a510-4a7f-4b7f-08db18d56146
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 15:14:54.1842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mj6P7ipgk35QNBiCECLGq8xtyBZoX6a1UMXHOjJpTPUMhYKGk64znpwfjwpX3STTiQB4dSFU2hJr2i5PLMe5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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
Lenovo Thinkpad T14s Gen2, with AMD Ryzen 5 5650U=20
Lenovo Thinkpad T13s Gen4 with AMD Ryzen 5 6600U
Reference AMD RX6800
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120hz[6600U])
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
The patchset consists of the amd-staging-drm-next branch (Head commit aaac7=
7ad65330444aa506614529bb7883e024d9e -> Revert "drm: hide unregistered conne=
ctors from GETCONNECTOR IOCTL") with new patches added on top of it. This b=
ranch is used for both Ubuntu and Chrome OS testing (ChromeOS on a bi-weekl=
y basis).
=20
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
From: Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>=20
Sent: February 22, 2023 1:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/20] DC Patches Feb 27th, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
- Correct DML calculation
- Extend Freesync over Pcon support
- Fixes in pstate hang and more
- Code cleanup for dc_link.h and dc_link.c

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: fix shift-out-of-bounds in CalculateVMAndRowBytes

Alvin Lee (1):
  drm/amd/display: DAL to program DISPCLK WDIVIDER if PMFW doesn't

Aric Cyr (6):
  drm/amd/display: Reduce CPU busy-waiting for long delays
  Revert "drm/amd/display: Do not set DRR on pipe commit"
  Revert "drm/amd/display: Fix FreeSync active bit issue"
  drm/amd/display: Do not update DRR while BW optimizations pending
  drm/amd/display: Only wait for blank completion if OTG active
  drm/amd/display: Promote DAL to 3.2.224

Ayush Gupta (1):
  drm/amd/display: populate subvp cmd info only for the top pipe

Hersen Wu (1):
  drm/amd/display: dcn32/321 dsc_pg_control not executed properly

Jasdeep Dhillon (1):
  drm/amd/display: Updating Video Format Fall Back Policy.

Mustapha Ghaddar (2):
  drm/amd/display: Allocation at stream Enable
  drm/amd/display: Update BW ALLOCATION Function declaration

Paul Hsieh (1):
  drm/amd/display: Correct DML calculation as HW SpreadSheet

Ryan Lin (1):
  drm/amd/display: Ext displays with dock can't recognized after resume

Samson Tam (1):
  drm/amd/display: enable DPG when disabling plane for phantom pipe

Sung Joon Kim (1):
  drm/amd/display: Extend Freesync over PCon support for more devices

Wenjing Liu (2):
  drm/amd/display: merge dc_link.h into dc.h and dc_types.h
  drm/amd/display: remove empty dc_link.c

Yihan Zhu (1):
  drm/amd/display: update pixel format in DP hw sequence

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  41 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 253 +++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  27 -  .../drm/amd/display=
/dc/core/dc_link_exports.c |  87 +++
 drivers/gpu/drm/amd/display/dc/dc.h           | 556 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 107 ++++  drivers/gpu/drm/=
amd/display/dc/dc_hw_types.h  |  14 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 104 ++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  10 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   1 -
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   2 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   6 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.c      |   1 -
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  21 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   6 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        | 299 ++++++----
 .../dc/dml/dcn314/display_mode_vba_314.c      | 299 ++++++----
 .../dc/dml/dcn32/display_mode_vba_32.c        |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  14 -  .../drm/amd/display=
/dc/inc/hw/link_encoder.h  |  52 --
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 -
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 -
 .../display/dc/link/accessories/link_dp_cts.c |  17 -  .../drm/amd/display=
/dc/link/link_detection.c  |  99 ++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   1 +
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 -
 .../dc/link/protocols/link_dp_dpia_bw.c       |  38 +-
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +-
 .../dc/link/protocols/link_dp_training.c      |   7 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   3 +-
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../amd/display/include/link_service_types.h  |  26 -
 .../amd/display/modules/freesync/freesync.c   |  12 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 54 files changed, 1618 insertions(+), 606 deletions(-)  delete mode 100644=
 drivers/gpu/drm/amd/display/dc/core/dc_link.c

--
2.34.1
