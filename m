Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB61FC616E
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 18:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8544F10ED67;
	Fri, 13 Sep 2024 18:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vdt+QI3Z";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA6A10ED67
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 18:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQN6MrQ2CqiDnpNMZSc5RqnG+CTobCX5LFUN4dwssUJBdG3tEUYFPIKHZlp9NqzFqWSJFYEzhkPH66c7gbh/ePwUW/t2jbonRE+wkG6ig60olltbzk5O4Z3fQF/Iys14b4yqmghe3IlDu0C5/D6ZHY1eWofA8tDcYyHEsRM0nbE7WscyY4UTAik0e2RP9Eq7dgr2c55WrTi5PI18V1hlQGfE0+ieEessUJIz98GwTlR30akuGcBpoOXr2PMI9dI2U5dh7iZYqHlb7F4rQonnto441m0kA0duFivXQ3oRhVVNPqE/7t/GPcuYoLQ2m9OOK465Xinq/zBtilxfDxQwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ0gAVSL9n72Zs4k5sdloomiCv2Tz6UUL6wXFNLoOXA=;
 b=O/LamSNKf7VYuBCiSJTEfYa1IFZ8RNzh9EYGdHm3NVAQH3gJ5YFRjIrh1Hamxzqme4slR7YGwywwdqdv1Tvw9IFfH/ugL1VwMm7/iGoNmfPSH3owcwR6ootm+22W6TzHZwHvZDsYGRgab0999aMblZqoyju6C3lBTzkyZIi+CT0DJLwhZm2zuwg7Gom/YQE8ChkbhqXQjUTcrTjKRgLfq1VADScqqd3kzPIqIqWt4k37/A7St/AUYISlRKYzlH1zYd83QGEmd9XiGaRtQHMHh4/Zf8WQVNyZfToSd9Ea+BupNKRVwaeS0WQQWX9GZ7auBlfbECHuaiPuZznr2P3CEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ0gAVSL9n72Zs4k5sdloomiCv2Tz6UUL6wXFNLoOXA=;
 b=Vdt+QI3Zgt4t9YgyM9Ve/53m15fLNjx7kJ+fiLhcPuF93v8ehI8QqVBJio4yKmyV9E9t7FYNCJS0RFMS5KfS8TmGW4lCUoh9zMi2bzIoZDiY/KGhMPIw1H6jeRL90L04fPsaco/7IbpmtVgX5HRD719WXXASnyykUa8fFRIxD+g=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Fri, 13 Sep 2024 18:12:57 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 18:12:57 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/23] DC Patches Sept 11, 2024
Thread-Topic: [PATCH 00/23] DC Patches Sept 11, 2024
Thread-Index: AQHbBGavYpTiTJgr8EO2qUj/gLXEA7JWCBXg
Date: Fri, 13 Sep 2024 18:12:56 +0000
Message-ID: <DS0PR12MB65348CD9ABF1155FA008DAC79C652@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240911162105.3567133-1-alex.hung@amd.com>
In-Reply-To: <20240911162105.3567133-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=6bf91ce7-b3dc-43cf-9003-51c67275ba5d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-13T18:12:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: 3ac4c618-2010-4f28-6d66-08dcd41fb1a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eYdEXgjIORDoCqyAPHCyYcV1PtCceup0qjOFm/GlODCS8x4FBZ+S2LF40GK4?=
 =?us-ascii?Q?tqrkdAQ/Mjl2q8bXOckyyDrXUkBtypjNmrGtZyFPJov6d7+ASLkX5kj0K0GO?=
 =?us-ascii?Q?XigHBS59RnBuWP5JBP23pmCsl40vKuEHBWQAo229Py/i2xhijFBSgXmvBMXb?=
 =?us-ascii?Q?6U7hdD4E7ykoDDF7wZ5IUHlUq8twjYGZHDLgJT8ID83KM9veV96EwXaAeRpf?=
 =?us-ascii?Q?FAvM6Ml9Ve9f8G7mNclSDJDQDyfxATXmrc6pjfnGRuJSPYAGMuzP190ouSDn?=
 =?us-ascii?Q?TAmcsxu5SH0wiuUgMhtyzkkMIZCbWmVU/slq73fAtRfhpW39QzkYqoJu6Ims?=
 =?us-ascii?Q?6BaMN5IGqeNYpQr596bbcxj2ebn6IiUW/7Azyp7H4g971mi3SnQHHeuuZ4qj?=
 =?us-ascii?Q?fqBxA6GNbKmWZZnHadXcJOON0CvJwBKu8wPeTBvesWFf4jTSrU25YbPakCah?=
 =?us-ascii?Q?I5g1Be4is3ygdq1+cZmoKww3fWjryVMx5kTzxIZ5v3ExzlnHCieJer21thGf?=
 =?us-ascii?Q?cRR046XpCHtn0ZLPc6LuVtRyGb7McgunnYKOOcEvoKktvtPfvoFAfXtDG3gC?=
 =?us-ascii?Q?c4Zmql3XRAQfgO4q4shwdYGFWv9ubdblQJLbqsZ1aF7a9BuEwwRQsPXDi/MV?=
 =?us-ascii?Q?DNPlPX8g8V5w6Ek7eHsfh0aybzbpeH8M0ItpsuGJo+uMTExXwSdQluDD6tXr?=
 =?us-ascii?Q?1Fw6QSKeeiTcS9g+dh3t+JG0/LcOrcqDdwOuLPxlpbHO85a3CnCxNh36OvaG?=
 =?us-ascii?Q?T+j+ZOGVOxVCdtRoj8VXpqbf5te9T0FVaD4ySu2KMyYYtcFFEB/hJK1KChu7?=
 =?us-ascii?Q?FlTmrfMXpUWK6XRAEsMyCuj3TjmkCI0fbmHMpOT+sNErBMKcEmPw0+CSaHCp?=
 =?us-ascii?Q?jAkRCexsOikVLVAQ7WtSCI+6VQuMf0LSZzqaU4+3ux0rX2ToSrqRfynbOnO9?=
 =?us-ascii?Q?TOd8zhIOJwAqrv0+RIEvIa//IFpRn2N1wB8+cUkThVgOVz/9M3yetG4+8YcV?=
 =?us-ascii?Q?V21oydfRj5twAwnNfOcYdqZtFX4d4dPxgk6NxAPCGY54S+gYbhLFnx63jEEC?=
 =?us-ascii?Q?Fl2dwfaL2YHYpC5x9dT201v9S/aWFHrx5mc3Pp/IsPZJJzLUFLF/U8HANjYP?=
 =?us-ascii?Q?OIlkAk8kYa4FDga7LkqFvpsVwkedBv3wxUOWM8TDlWUIFheBNO010cCpaCMH?=
 =?us-ascii?Q?voehHfWyLYVO8mq9PHXIBKclx16FDoQtM1wJ52dLCzAYe9iuFyQAkVbuJGFF?=
 =?us-ascii?Q?ysIwuOEIPyZJgrE5PD/FGuPu4lAyBOiysZtnHTGsbvyy3apu2u+f90u+OhCg?=
 =?us-ascii?Q?FA4RXWAGKFAFhZZHa99X9OtzlivIOK80IcdxMC5VJDrOYvFy4fwPH/i62gQ4?=
 =?us-ascii?Q?eambEoNxQZC6SHSFsy3m985Gds/PfojQwemXsddTi1cPaRImfw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B9VLJBU/I5nSck8mwen34v4OGEKifP/50Aa7BphKrfPcZMFFuF8QqkbWZPrb?=
 =?us-ascii?Q?PqRKHAtBHamIEMA6//sFBO+IERxc9cR4SaX3MgESDe9qzd31i9Z3A+tmQnYc?=
 =?us-ascii?Q?6e6tl4kWprcGQ5FTEGIHcmzWdWkuGWjIZ/pr54J0bdGryD7kgt+IbyPCuX0T?=
 =?us-ascii?Q?uvgIqAaJ3qA5dn/jvB660LV8VLV+0drnQ50uSxqAA+tUROvo4Dl6Vr62gJ2A?=
 =?us-ascii?Q?772B2sbiQABkMb37JNEwhVn1oA+AD1lLDwq+wtdF+0DVP3LvoltXtsbzqiff?=
 =?us-ascii?Q?Js6wbZ7MMuxnvIgEMNAwC1Q+VSrRUzG6o/nLLtX3yH+wqVQUfqILtTDCisVi?=
 =?us-ascii?Q?wkWd+sPn7gwi/Qm8fHqd3ortsm2d1Ez1bGADdiEyJSYvOIlJ2ab2GwyObM/E?=
 =?us-ascii?Q?4DPN3XJgE2soO+1qzF51ULP393lDKhVufjzTkSdZDwW00KyVZQacep+PSE2u?=
 =?us-ascii?Q?pNihCIKICqTUIdSnHB6uH5KTu6643HTIK/X+2VrqIcoBSKRchkpRVZHRA3hH?=
 =?us-ascii?Q?n5R7iRajbnPQffqzGnUcYj/yz9k9y2j4LrwvTgnK06Pv1+SkYyoBdQQ8jttm?=
 =?us-ascii?Q?S42zdHZO8BNiRMgGc7Ck4X4HOVWfK6pfsElxgih5AT5YuyclssM7w0xSqJlV?=
 =?us-ascii?Q?GQBYH6tSasXniYUzds7Q04SHahZxQ7yM1KL5DeeyujaIN4gVb4AY8Yt9dgD/?=
 =?us-ascii?Q?mQK5wg83Or12Mfuz0lWfxv4yWhWXcjgBf5OPQ+PBCx3Uva+leKMPwvcT0KMg?=
 =?us-ascii?Q?ws5LUOJCZfujXJrPTimC1nvsQOZvzDY6RVI0N4EGQ1bCSFuoDXlwlMJOX7gp?=
 =?us-ascii?Q?SVWys8x0JFpj3yQ63lZHg8xP5kJ3TwvkmzfH7SxKnnGE8OyYW4XPRtl9FVeQ?=
 =?us-ascii?Q?r11XeQ8OrcKL6EnbRE79xjdJWWjLmzrjJ/5Ly8PuTLyspmaF7J2qAWIp3n1f?=
 =?us-ascii?Q?JuLabqjqN8gveCf5kM6jvGoTtueEOGP/zwxgx0hWP7Yg7KvOOjQS/iAQHWPf?=
 =?us-ascii?Q?d1Kz26/uJSjIi84ebXHekXGfx8bv7gsNElrRWYm4qUdFiFKAOvJt/IjQJ7OF?=
 =?us-ascii?Q?8Z68TQDg2dZHqUq0k/fc5PJGA4vxQVOVthRfDpIvv33nmGEFhvARfw21lrwz?=
 =?us-ascii?Q?YLg2EEIQ2lQryLUpV3NvJpnV+2qH2N8wPr8q0XZKYjolmlRnDG3gvBdKeHPC?=
 =?us-ascii?Q?N0OC7wG/LcvXO3WyrfenT6T6HFSYFy1O/k6DWZQXfCodcEszWeN+AAVY/odm?=
 =?us-ascii?Q?9XX+130jVi5DLj7tOy05Ucgfh7w/Hsb28eMldJFfLOLjLYNK3cDeMSqK8tr3?=
 =?us-ascii?Q?FvAljViM4M0Lh0zXOK9D5fbZmG9vkpTngmcElWKKh4hcpJc5dlKMS8/oZOaS?=
 =?us-ascii?Q?qMGVWEI2bwst6qwxeCNk3FvXWu5ZDmALHWHUb3Q8Ej8IomAH14wTfShNeoFd?=
 =?us-ascii?Q?qMzRBrPf+JIDNkw282q6gyFhWwdos4/6+xWFCaxAqGHKCPmIufLYc+DacuOG?=
 =?us-ascii?Q?nshOGoSLgUQ7YwD7M+s8XjSzgfIW+ZMLDXq8VRMtYEz6Xg4N1IpTwqJYsl0c?=
 =?us-ascii?Q?Zmju6/pl1ek2K5cY/b4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac4c618-2010-4f28-6d66-08dcd41fb1a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 18:12:56.8929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zful8vR5qcjXlAXcc3oGDq1NAJBU7x1UHtrPtwbR0jVUhEl+LJT1O0lqTDJaYeWJV1WSi2+oLnoKlhFpBuH25w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (HP Hook G4 and Lenovo Thunderbolt Dock, both with 1x 4k60 =
DP and 1x 4k60 HDMI displays)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 5dc=
bd744fdb998108275159acde7685387cec026 -> drm/amd/pm: fix the pp_dpm_pcie is=
sue on smu v14.0.2/3) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, September 11, 2024 12:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/23] DC Patches Sept 11, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fixes on DCN35, DCN401 and IPS
- Enhancements in DMUB and DSC
- Misc fixes for Coverity errors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Check null pointer before dereferencing se
  drm/amd/display: Remove always-false branches

Aric Cyr (2):
  drm/amd/display: 3.2.300
  drm/amd/display: 3.2.301

Aurabindo Pillai (1):
  drm/amd/display: Fix underflow when setting underscan on DCN401

Charlene Liu (2):
  drm/amd/display: Use full update for swizzle mode change
  drm/amd/display: Clear cached watermark after resume

Daniel Sa (1):
  drm/amd/display: Emulate Display Hotplug Hang

Dillon Varone (1):
  drm/amd/display: Block timing sync for different output formats in pmo

Leo Ma (1):
  drm/amd/display: Add HDMI DSC native YCbCr422 support

Martin Tsai (1):
  drm/amd/display: Clean up dsc blocks in accelerated mode

Nicholas Kazlauskas (1):
  drm/amd/display: Block dynamic IPS2 on DCN35 for incompatible FW
    versions

Peichen Huang (1):
  drm/amd/display: Restructure dpia link training

Relja Vojvodic (1):
  drm/amd/display: Add fullscreen only sharpening policy

Robin Chen (1):
  drm/amd/display: Round calculated vtotal

Roman Li (2):
  drm/amd/display: Add dmub hpd sense callback
  drm/amd/display: Update IPS default mode for DCN35/DCN351

Ryan Seto (1):
  drm/amd/display: Implement new DPCD register handling

Samson Tam (2):
  drm/amd/display: Use SDR white level to calculate matrix coefficients
  drm/amd/display: Add debug options to change sharpen policies

Sung Joon Kim (1):
  drm/amd/display: Disable SYMCLK32_LE root clock gating

Yihan Zhu (1):
  drm/amd/display: Enable DML2 override_det_buffer_size_kbytes

Zhikai Zhai (1):
  drm/amd/display: Skip to enable dsc if it has been off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 +++++++++++----  .../gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  9 +-  .../display/dc/clk_=
mgr/dcn35/dcn35_clk_mgr.c  |  6 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 41 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 14 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 12 +++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  4 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 14 ++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  3 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  3 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |  9 --
 .../dc/dml2/dml21/dml21_translation_helper.c  |  4 +-  .../dml21/src/dml2_=
pmo/dml2_pmo_dcn4_fams2.c  |  8 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 15 ++--
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 50 +++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 14 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 13 +++
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 31 ++++++-  .../drm/amd/di=
splay/dc/link/link_validation.c |  7 ++
 .../dc/link/protocols/link_dp_capability.c    |  5 ++
 .../dc/link/protocols/link_dp_training.c      | 80 +++++++++++++++--
 .../dc/link/protocols/link_dp_training.h      | 16 +++-
 .../link/protocols/link_dp_training_8b_10b.c  | 21 +++--  .../dc/link/prot=
ocols/link_dp_training_dpia.c | 64 ++++++++------  .../dc/link/protocols/li=
nk_dp_training_dpia.h | 19 +++++
 .../dc/resource/dcn35/dcn35_resource.c        |  1 +
 .../dc/resource/dcn351/dcn351_resource.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 54 ++++++++----
 .../display/dc/spl/dc_spl_isharp_filters.c    | 85 +++++++++++++++++--
 .../display/dc/spl/dc_spl_isharp_filters.h    |  9 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 15 +++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 25 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 .../amd/display/modules/freesync/freesync.c   |  2 +-
 38 files changed, 588 insertions(+), 147 deletions(-)

--
2.34.1

