Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD686C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 13:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6301610E35C;
	Tue,  6 Aug 2024 13:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P1IsL1qx";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7978110E35C
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 13:10:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUGVvgt89bPjN0PZzoa93ptO68LP/KYaIEXznOI7Y2T5R1jYjrhJfUrFXBqO9mfm5MZ9qV/wbfwWWrgZy80eq9buBoAi2PC2jLO24wz1gkPJEcm1rD2TmdTqNK2gWn64o/oEpjUlnrI0Me1na4MY+NzyOf2XbGHGXDGl95LVmV7yO6ylx/MejFGdm4taed/jPI2eYYbdBUbCFY7LFlak4d7KguiCh7LXBZIxAU4SvWbNRs7nzuPaN37bJs0gtjqDGMMLYVjVyotlTtrkzUX1uArDVsjxXdZXpolkPoERqd9S2Cj1NBcVO/Gaj+kEP7Jmue43AUc3Y/vqpnTNOqpiZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do48x/OpUyHV/XdJOfNyLKtKwAWyCuWKdM90tGOiElg=;
 b=Lc3OK+4UatVJlutH+A8+i8JRj+YOb5DAcW192mf5NoumCVglZ2zYJXXH716ePcGBeeAaCfratC9HOH2junF6IzpZujJklOsHL6iOC6fwt2pMn/CEsS67XTgrXaRbcx50j5nk8cJ8276pp5gn1hw6NKnRRhgdvO+H5ErrdT1VybVEd1n/jXAUQmeYDk5wEUD9UY6vkwLVH6ZiXwLVuZh2hVVlhTea84X2WSQkvNysenOcE+5p7MQRU4za6ENRCeoWiMgu9Pkelq9nuyxPrcrWMZPJzWPIW/CDFxXMyR3gFW7enTErHiH8KPtMz0Hw8HY/C6JbpLJJgAZA9AM1pH5VkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do48x/OpUyHV/XdJOfNyLKtKwAWyCuWKdM90tGOiElg=;
 b=P1IsL1qxx0WuVCJkySKgMTXyw9ODQj16wkhKf2TvzcYcrztfe45i6sdCZ0LSBmGij4bVNMM+F3oXDH/xlLpAjBcpjy6gW/8VnHbwWFLBWCpVrdw3sZAHY+wh2paWYKPcp27eFQpjEJNndnvI9amY7uo0w1QrYyviIciWgl3U6pA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS0PR12MB8072.namprd12.prod.outlook.com (2603:10b6:8:dd::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.21; Tue, 6 Aug 2024 13:10:47 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:10:46 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem"
 <Zaeem.Mohamed@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/22] DC Patches July 29, 2024
Thread-Topic: [PATCH 00/22] DC Patches July 29, 2024
Thread-Index: AQHa4lDK4ZEer3CwnkKqyV3/uZRHZbIaPysw
Date: Tue, 6 Aug 2024 13:10:46 +0000
Message-ID: <DS0PR12MB6534E1567E855D76251330259CBF2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240730071843.880430-1-Wayne.Lin@amd.com>
In-Reply-To: <20240730071843.880430-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2c8aa806-caee-445f-878e-c44b95cefc6f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-06T13:10:00Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS0PR12MB8072:EE_
x-ms-office365-filtering-correlation-id: 2c723f5e-7a8d-4f02-0f4e-08dcb6192f92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?et8UECh7oC/xIAOHyte5hjeOLdXctei85Sin0HvlD3vKzDco4sGjUB/WeXYp?=
 =?us-ascii?Q?q0emQ2WT5lax12nOQv/qY6KIJ2G/VBB7hnt1ycujv6ubVKhwE9aKSW/T9mbx?=
 =?us-ascii?Q?7xfzeGhjlU8OfOaRcpWNeSMGr+XtUW7LuF+y8n5GKXp7EAVs9ENSoTMNoPmV?=
 =?us-ascii?Q?U1OnK2YbEC2dcs4LY/Ss32pg1e3WaTptRg5+v66GowMGupSOatviwDHJMaj6?=
 =?us-ascii?Q?6qgTSxgvv0B0/7PrtuhOMZOJuJuAyzrblPP1OIeSOsSXVV4vHCM8Ulg8QkeA?=
 =?us-ascii?Q?6Z/HR6FkZ2kMmFuXc069CvDmfgKFciQR1q8qilLAMpBXxZ3iuMEXay154Kmg?=
 =?us-ascii?Q?vgiwJdO5K/Mwev9jOF3M2iOLb+3/Up1zcKnmCut9zWNyKtefjLh2vLOby+ma?=
 =?us-ascii?Q?HsXx9qYp7qP9F685JK4CWIXMkbrLuEmzIje/uDmpV7ctgA1hI4A19wuwkmnu?=
 =?us-ascii?Q?hcsAgEsb/+dygtvxySe9Zm1fv3rU7wEn8jS+3DD76U99N57Q0DM/GteYmWZO?=
 =?us-ascii?Q?WQfoDYjqC86wIW8ufpUJrxLPYXEK87yaAlbUuTDS6NDXOfvw/WByA0be+lz6?=
 =?us-ascii?Q?gUja76AIHWrvzmVIKdifWB+AufVIL018WtHEBqBpPApiQUU9t7/ZMlmqo86C?=
 =?us-ascii?Q?sBDWwke6Tmt+8d3daYw4Mvg8jaR+klxZmZYA0IkO5Gr1RFIBzgErCZhLQcdI?=
 =?us-ascii?Q?5viCRbMI5hKPX2hG1Xxy0Z4sz22oQTOFZM5UqnspypANDcsll4ZHJOYPevRe?=
 =?us-ascii?Q?Sub1tBG7GJaLW6AHCv8Tpdb5ErATyqBFaDzKQLZl4AOYX9ALpoqPaVoEh7RJ?=
 =?us-ascii?Q?zMnguDRkW/RiGB9x5p7y9dJ54zzHZVLtUVP4vVupArugVD13dYKsy0vF2XL/?=
 =?us-ascii?Q?Rme8rSMrKkoWfXduZgdmDuWK+U49NgmXX3KiFLyMth/L4T/FrQOE91kKMQ/y?=
 =?us-ascii?Q?dkDkIHvqVOc1Gv9NKgHlRllZLUiKY6XCOgA5TZ7hV1EEmnGXgMbxXKG7LUe3?=
 =?us-ascii?Q?JGy/sa4shbxAlsEBon791RUR2oa0h37gszvAy6mk7aYiIt64nFTqyC1FF3DL?=
 =?us-ascii?Q?w0BlJHMnUYvtGvRC/2pg0rZQLM00cmsEwbC8S/tJzJwQebiJmIh2kQH7amqm?=
 =?us-ascii?Q?o0DtED57op1Cct9NlR6e44H4Iv/t0/+0W2zEit5QtsNB2ptnk91z/rsV+Z4m?=
 =?us-ascii?Q?APO9aQ8exzsmw6pFMqz7h1Or3dJ8VeS594et7PyYE2xQ4CprPwc8emeHiOyq?=
 =?us-ascii?Q?rjvvOEHdq473kP3e5Py99f0FtjYQZKiX8I2jjvGfIC7ZQPG8CrRfwMQzMo+C?=
 =?us-ascii?Q?2xz0GeapMGxILc+teWAYoaBWPFzdfO/8Mn/hPbWm03ZgkzKXhpObdTJDTpCL?=
 =?us-ascii?Q?wUpsi0Ob6IkyixwOFDbQEiHF9lKj9LG6g41Azi6nA31CR5bLxQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S/fnOb0DgG2b1oNwB5AX7ehNnr9ctu2ZiJBGejYUdJ+JJl8qlhW7SI9uNGGy?=
 =?us-ascii?Q?Ah4/BKOizZZ4l7PsWY2vHpowzm23OiYmQgyZCqicukFgVaPbgULVM2/hfa9d?=
 =?us-ascii?Q?FqQJZeYjgdHkvEYRZ5EesJDc5nNmDK41pvEf8jvyML1LBEzzPzcolK+1bo29?=
 =?us-ascii?Q?dxoxtkJyu0J8QWG6FKdX9iDlkvYaKd8SzfPuQz0PQBHHSoYCC1GRUpu4rWcW?=
 =?us-ascii?Q?dBKkLBIzq961Rm2LBg8KtJTTecwrKuFu17L4nJbJNeIXlttEcZNQKS8E+geH?=
 =?us-ascii?Q?HSZkH2Qf9N9z21XtILYMq1ix3jTWOh/lixF4V+zntxThVUhrhyxL19W8ozqk?=
 =?us-ascii?Q?10Wc5ojSdLYMq7mJnFR+VZoemFgWNhlEmH8+Ewhp2/G+uTBbHydC67+mLGpd?=
 =?us-ascii?Q?zDXyyjAzAm/Tg6AO6+UYl7stgTjRkaotgmJDeapN8XqIzYAJXg31sVmD6zUP?=
 =?us-ascii?Q?FXawlUT4q9k/KWCMVNHQNlPWM5IMGFC6wopXQcJM+zAsR5de1qGeSwOMUfzB?=
 =?us-ascii?Q?+e60C+W9j5HlpyFoX+4R9Ro1RBdwxZ1vXe77aovje0xUaCRmj+jZhscZLpEB?=
 =?us-ascii?Q?r4OWsQSoUdJAlvubC2AU77IcU5BYPaGq38aY3TGxKx8tVAJBllzxDpwXKrP2?=
 =?us-ascii?Q?xLbEgij7fYFY6tyaqt3CSr+UNTIkXnAvfMzOenhbK7NuZ+6eET1frs5OIe6l?=
 =?us-ascii?Q?9JoIxNe7USPI+BJleH5+SA1A+q9cxJJTkv/LA6fqyk3Rrg375NB9iG+Syrdg?=
 =?us-ascii?Q?MklkGD+Zmv4YP6iQ3oytNBTPnyrx9yYSYY/ye4Qt60c6B8NbVrEVod5RiXri?=
 =?us-ascii?Q?pT5GIRHSIixuCmLlxT0kVJXOlbG3aJ7EqGxrqbKMPDbdf5MXENgwWoLmPBNz?=
 =?us-ascii?Q?SYLvTZAK64xWzZBaWLx/9m1eDvrf+/KbiWI9eojKiZTcyN6vXE+vIWBTQkvI?=
 =?us-ascii?Q?asQ0RS0hbw+SvWUoqj0xh8bOfnTEnfDzcO52+VFuPw83FJBayCvJ8fmyGdpf?=
 =?us-ascii?Q?jt8+nxy1SFJ5tfVfHORr+dEDPRmhdJZlWR1wNkfJo5b2p76WkKNRoSEDYi+W?=
 =?us-ascii?Q?jp3D+jiDfxOhrutNFGaG6c17e1bZvoEHHya7Z1gD/YUP1H/oSqMJIsZIUXrO?=
 =?us-ascii?Q?yfdShxgwnejRLQYiFbJ8qES/CGvOOpmZfxl37EwrjEm5RTHlZfZrzsunIza1?=
 =?us-ascii?Q?Z9NOzve0hGkU8W+1rsESAMaIhzqBVzDdHsago0cHf1UmVczhnlMVKoYX5c2J?=
 =?us-ascii?Q?uIo37ZJSHrDorJeElmlFBary6K03q2//8yCTsMZBFGeZyhMrcp6JxwZADA7r?=
 =?us-ascii?Q?PdtkJM64LAeDNmcT5VOxis0M3tJ3vQMeJUPHykoZGX/7HJP6tUHV2ghlEHsB?=
 =?us-ascii?Q?k3LBGi6ELQIKZpZDJI+07MOiC/QLrCKZJ8on45wM2P60STss93gb8gyyNcAF?=
 =?us-ascii?Q?mpdjqrHLZPt+rrSYJ4KqlMMZPHVr6qGA+VVwVeX3Zsa4eAz8nhMYhmqw9KZX?=
 =?us-ascii?Q?xWQQvPtB/1nE8QCL28EAR0tyUC8KvGqZnr0k0giltDBOqPM0DKC6EoSPPzEV?=
 =?us-ascii?Q?7ydXMnE8HRJlFBT3BP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c723f5e-7a8d-4f02-0f4e-08dcb6192f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 13:10:46.7957 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijtCnsXgCZCFbMvy7uijmOxqSclE1Rr9fmhjO1QwKky45nfS1QQlub5DWzJ6IzJOXcfU6IX5NuEQYmiaE0BXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8072
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
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 2b6=
93c21335d67a2c9958db79fa15464b0d194ba -> drm/amd/display: 3.2.294) with new=
 patches added on top of it.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Tuesday, July 30, 2024 3:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wheeler=
, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/22] DC Patches July 29, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Clean up some files style problems
- Program the DET segment when initializing pipes in dcn10_hwseq
- Fix overlay with pre-blend color processing
- Disable SubVP if Hardware Rotation is Used
- Fix few things in DML
- Re-enable panel replay feature
- Fix null pointer dereference under mst+dsc

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.295

Aurabindo Pillai (1):
  drm/amd/display: fix a UBSAN warning in DML2.1

Austin Zheng (1):
  drm/amd/display: Disable SubVP if Hardware Rotation is Used

Chris Park (1):
  drm/amd/display: Address coverity change

Dillon Varone (2):
  drm/amd/display: Force enable 3DLUT DMA check for dcn401 in DML
  drm/amd/display: Add DML2.1 option to disable DRR clamped P-State
    Strategies

Fangzhi Zuo (2):
  drm/amd/display: Print Pcon FRL Link BW in Debug Message
  drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Fudong Wang (1):
  drm/amd/display: skip crtc power down when ips switch

Gabe Teeger (1):
  drm/amd/display: Revert Avoid overflow assignment

Hansen Dsouza (3):
  drm/amd/display: Add stream and char control callback
  drm/amd/display: Add clock control callbacks
  drm/amd/display: Add clock control callbacks

Joshua Aberback (1):
  drm/amd/display: Assume 32 bpp cursor in DML21

Michael Strauss (1):
  drm/amd/display: Fix overlay with pre-blend color processing

Rodrigo Siqueira (6):
  drm/amd/display: Add missing DCN314 to the DML Makefile
  drm/amd/display: Cleanup dml2 and dc/resource Makefile
  drm/amd/display: Remove useless defines
  drm/amd/display: Remove unused fields from
    dmub_cmd_update_dirty_rect_data
  drm/amd/display: Remove unused fields from dc_caps
  drm/amd/display: Add missing program DET segment call to pipe init

Tom Chung (1):
  drm/amd/display: Re-enable panel replay feature

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  20 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   2 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 528 +++++++++++++++---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   2 -
 .../dc/dml2/dml21/dml21_translation_helper.c  |  19 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   4 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |   1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  93 +--
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  10 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   1 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   9 +-
 .../display/dc/link/accessories/link_dp_cts.c |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |   2 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |   2 -
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.h   |   8 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   8 -
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 -
 22 files changed, 552 insertions(+), 181 deletions(-)

--
2.37.3

