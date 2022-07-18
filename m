Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25967C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 13:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B8110F7FD;
	Mon, 18 Jul 2022 13:15:53 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D47113C6C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 13:15:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFxda7o9y+bicgIFiBLm8UOCNst1nSp5W0VrC/q5ydbZnAPS9DywCRij2XqGZI9I012xE8SYjbteNN1VvUoVL66XsZrlVvebvTtL1rYg3/FX6IPHOWJrPd9Xk04jSrA/TRug1oCh+uMgHXaTCRzG/c/yZ5ZtlYiDV4lCFB5iCrIxyY94hvHVXKa3uAggmazBxn9geNLWaE94QxBP1s1WRiRkdFA6PY5Mlsdnb+gjHyobNgQoNHEqCpWK8xvP9RfAlgUNCQJGVBe9ahp6f70MADbXhpmnbAyL57T3Qdal9P5I63hMNQX3maHCJsCVYhilGwH7nBosdrk9gSH4wWlHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2H7bta0JD3/pkbI60ddO/bD36XMv5h905xE9L5giFY=;
 b=cr3zE6IvzdWZ/lID6SB/FitxR9Io169Eqxnk26eJofeh5Q1QIx+w9HY71+U8bQ4VJdW8tV4EA+unXryqqWz8DTbHa6B3/VcZhI3c/b6MfrLHjleNZDdSAvfmXTfLTTbUOWVP4u4Gj94bs+D6A+Fzs1jjgYRDnFZUFsjO32m0mTv18sWgXAuxwiQ+6ICdNM8FfsldfqcupuKhlHVFbXJSp1KS7AGmGElT9oXImqBNkYJuJs0RdrHRB+TFXrZgxdhmUKQmVR+Fy5OB9+yLR1+qkdcKmq20L9/VDYntiOma80CudwhYqFaJWykbt352d3Wp1HmOku06lwyCG6kPbWkAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2H7bta0JD3/pkbI60ddO/bD36XMv5h905xE9L5giFY=;
 b=fdywZdqKq/RS/gZvqQy7epvEWLT7Cfu4FMU1UFVsoGowdnREtF67DW+4FEGPwU5haJnzEps/Rb+tzGfDCPrNDy5JaNGntBMhOIffvnJxjqdYKCnzabxbaD2Ct/iiTf9/hTGLAXRhS3mEupjDFW4JHfflZmhYcQu3u4Z7NY56JzI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 MN2PR12MB3679.namprd12.prod.outlook.com (2603:10b6:208:159::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Mon, 18 Jul
 2022 13:15:46 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::cdf9:a98e:ade:43f7%8]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 13:15:44 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/31] DC Patches July 15, 2022
Thread-Topic: [PATCH 00/31] DC Patches July 15, 2022
Thread-Index: AQHYmHcW8nC1UnE1oE2kTkem1ma+oK2EH5rg
Date: Mon, 18 Jul 2022 13:15:43 +0000
Message-ID: <DS0PR12MB65342C771DA7237A1F69F85D9C8C9@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-18T13:14:11Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3032a663-aebd-40d4-88d9-c9f6049e246a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-18T13:15:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 1973e7fc-e2d3-4392-ab4f-fff6766afbf8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe26b73f-d897-441d-a5cd-08da68bf9eb2
x-ms-traffictypediagnostic: MN2PR12MB3679:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cvqqOqR6RHJBMrXFg3Hp3IpS9Z+DFp3TRuuFUYl2uhKVqE28SHf4Wz/y7I+w1YzTzmcudyZvL0hMJ8EIi01CtynTRMe8BPipmD5+ybBiymvFl9Bf175dIKiKXsyFwu2Qq565jAcctpQtMg5GliuKUQA2ItdPrvvyZn5AQfAfZf59iBev/g/0fDm0vGYzD+sEZdmuQa+JR5+A2sdM/WND22NY4sfUyomH2pg0XXNNwoTKlVW7K1xkT4catip/VyqyNnlMtU/KYlA/EgNT6tmQ0IuMwpP6bs9UZ1M/7Gf79yQ7PgUXbQsiRPuAIv+01ZrW0fH33Qb2olseL+DBQFxmW5X6c2Imuw0tLymzIKDBpvL5oFYQFLJk077GQ4zYpriXq+pfwoegqdj744s/644HVdHfAqxnyn+Uuimo/yAtZ3gc0XzyAVzsoUCegdfHKvuKxRpTBLX7SHEq+erz9whya9RWCvS2iW6mbFTYzM3Jc3ft/SB5QVa7W6unHtegCk96fYKKCDlx6enB+XfRBhbLzAlb9GPmf6HQL2LPZd4n2t1qB6g+bQeXT0YXUGsVl0oLhRtwtSw/SS3biLGDuUJeIuawmGJfM/D6y1W0gcs/OE1I0r6BwJVE00NfOnTGVzZZj+sOVYvijS9Q6AO2Yr8zclI3kZrp1dLqpL2ZQdIg/puiINz3+dDA4RamTJ6qyu4LZ9pTTawgyuxyvS5nmpf7lySxtC5aFZhhpvh2TUYfqQ+GOPx67a4ZuYkMJVBcPFw9IQrOUZTHq+FaYujp+vgclvTcBubFiPzpaNxO88k3lj+Pl4602bi1R7zrFFdg5ql
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(71200400001)(8676002)(76116006)(66446008)(64756008)(66556008)(66476007)(41300700001)(2906002)(478600001)(52536014)(66946007)(4326008)(5660300002)(33656002)(110136005)(8936002)(6506007)(7696005)(9686003)(86362001)(26005)(54906003)(53546011)(316002)(122000001)(55016003)(38100700002)(38070700005)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wM3L5Lm/sg/+j0R7IYsfUdMjzT5RIPGqvPnV59OHX+eZ4J8MaqDo/uVEOdbI?=
 =?us-ascii?Q?RvigM0b60/F43ayo/Fyw+U8LAf5BY0NnjCLW5sd0p7vHzakugJbutWlhh62G?=
 =?us-ascii?Q?2YzAQlnwb42oJDsoCdTD+xO/MlzTt1bOyftnp1k4ZPb58IzwDHqrcyOiZZb9?=
 =?us-ascii?Q?2IIAbbjzr6Yq/7XiyT5nLwYN61PX+uyzschR12kyU6bjZERfkI0klk6nd5en?=
 =?us-ascii?Q?s0TfXWAs7Q4mkm5YfyJSV5SQ1ZeIy8aOGVzBKMVhUKrpoDEmEFKKCR0on5pk?=
 =?us-ascii?Q?pwPiT+Uw/Q6iN2TV9XYcZWMQu5N7DBz92wbYjxVjrIN40Q1Z9WWJQyHKFsJD?=
 =?us-ascii?Q?jpnAjUjZkAwFpxiz4T1DqnkPJWMfrdvEAwgiSvhDgjbmccNTgYslnHwv0nWp?=
 =?us-ascii?Q?Y6NLIM6bRw/T1CpkL1hh2OylaXDA0F0EN7ByzDraSDPscoC5PsqtVZXDmijr?=
 =?us-ascii?Q?K0ZXqfMMtpA73EwmEYSqusEkKmGUt4QlRKkuSRykINqewQj0wpVyMLFHltyG?=
 =?us-ascii?Q?mIDHMvXXVTeTELcnAYFKT4Nzg8YLTV1hHkFW3G5LcEEPrujdqOdW6JlvSUG6?=
 =?us-ascii?Q?OtKS2wdwgCHVvknRor9E/Ji+47UsL8TaVwRzJGm0izA9Erugkny0ETPZsejg?=
 =?us-ascii?Q?nI+1TDsz0QJZewelEiyngyQumHLyQc4UzMu30Xk3MSDPiHFYOqTWv1HAX1ze?=
 =?us-ascii?Q?Gm7F4WwRs/EckbIfuJq64DpycquWEzAjC/Mvf5/SFY37SwAyeFmj0IgCBiBS?=
 =?us-ascii?Q?Hplzg4nilvLQNPEs5lsem77mBI82y+9lSiROub57q6XZ7zJ5/wSvhXpbw3i3?=
 =?us-ascii?Q?HNHm1ZeELVRULPAl4YYwaAFoopvX2LqfHU6Oys9aL5gCU02QPJm9fhLv7ee8?=
 =?us-ascii?Q?DLazJeNX8qP5GwAFJ9WUqYgl0cWNk39qX/tblv/hJb0xBEpBQddvwp9lVG2C?=
 =?us-ascii?Q?UvK5IioZitjIOyWqqTaA0Gzv3ytSkS/7tYyZdtwPYQzmCUDrLpEtlDh+2SIC?=
 =?us-ascii?Q?x3oEYEc9xEpWSiWqM1MOfAgNPnrTELzlav/C6yi5QkdpeU7R5RQfta1WxEXB?=
 =?us-ascii?Q?MQg5INhobHJBRp9xY9eLpRMr8Ov7DoTxUfhFHa5BTXyHNP+fKCphLoCPxo14?=
 =?us-ascii?Q?v/qChF01Ri355l2psUMb2/6EsdWWf2IxdYx86nQgqk6FmUocpuu6d8uO1nec?=
 =?us-ascii?Q?w3RSDwSS97WMNwoZRvSHt+UotrKaO9sjJWKpYETBu6TOpmK/xfCymuO2jcxZ?=
 =?us-ascii?Q?d5TfyXiLFlyUGgiWp7TJOKPdw9qCF00F13HgIx9C75fG+mquyxfbHQTY8ZOZ?=
 =?us-ascii?Q?p6d2+khNF3cKRi8uVM9BwH5KmDeDpNODejPpKfpYrcy4it+NXITodQAFF6Yp?=
 =?us-ascii?Q?CMoEExusKY18vbOP0+duQVKdtvk0Vaqp7drvRRdY0FoBn84+ayWeIpQZDfMO?=
 =?us-ascii?Q?9VAeJGzYz2htdcoXa5YESWXHVNG1/Sv1BW2PObnVn/VMCJ/HmMMrRvOVEO+I?=
 =?us-ascii?Q?07VaUdW4lL+jvULqTQmnIg1q3FUBAZJwhbYFuAvylBhiBLPIoxqKrDsI8AtO?=
 =?us-ascii?Q?oRc+60FWuqfQW8UCZG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe26b73f-d897-441d-a5cd-08da68bf9eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 13:15:43.6428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1FE2nHVtMTJYnnd4G37X2EUU8lzgpy7jgo1ONbZDB5VFxZAquMF/OHYUm925hzC2P4q/QDbseobx7vI40NDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3679
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
The patchset consists of the amd-staging-drm-next branch (Head commit - 01a=
992129a037dee0834eabfd92e15eb376d185f) with new patches added on top of it.=
 This branch is used for both Ubuntu and Chrome OS testing (ChromeOS on a b=
i-weekly basis).

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
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>=20
Sent: July 15, 2022 2:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/31] DC Patches July 15, 2022

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Isolate FPU operation for DCN32/321 under the DML folder
- Create a specific file for CRTC and plane based on amdgpu_dm
- Fix DSC issues
- Updates tp DML logic

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Update in dml
  drm/amd/display: Don't set dram clock change requirement for SubVP

Aric Cyr (1):
  drm/amd/display: 3.2.195

Chris Park (1):
  drm/amd/display: Update Cursor Attribute MALL cache

Jun Lei (2):
  drm/amd/display: Remove unused variable
  drm/amd/display: Update DML logic for unbounded req handling

Rodrigo Siqueira (16):
  drm/amd/display: Create a file dedicated to planes
  drm/amd/display: Create a file dedicated for CRTC
  drm/amd/display: Fix hard hang if DSC is disabled
  drm/amd/display: Drop FPU flags from dcn32_clk_mgr
  drm/amd/display: Move populate phaton function to dml
  drm/amd/display: Move predict pipe to dml fpu folder
  drm/amd/display: Move insert entry table to the FPU code
  drm/amd/display: Move phanton stream to FPU code
  drm/amd/display: Move SubVP functions to dcn32_fpu
  drm/amd/display: Move wm and dlg calculation to FPU code
  drm/amd/display: Move dlg params calculation
  drm/amd/display: Move ntuple to insert entry
  drm/amd/display: Move bounding box to FPU folder
  drm/amd/display: Drop FPU flags from dcn32 Makefile
  drm/amd/display: Create dcn321_fpu file
  drm/amd/display: Drop FPU code from dcn321 resource

Taimur Hassan (2):
  drm/amd/display: Update de-tile override to anticipate pipe splitting
  drm/amd/display: Loop through all pipes for DET allocation

Vladimir Stempen (1):
  drm/amd/display: Disable GPUVM in IP resource configuration

Wayne Lin (5):
  drm/amd/display: Support vertical interrupt 0 for all dcn ASIC
  drm/amd/display: Expose function reset_cur_dp_mst_topology
  drm/amd/display: fix trigger_hotplug to support mst case
  drm/amd/display: Add is_mst_connector debugfs entry
  drm/amd/display: Add tags for indicating mst progress status

Wenjing Liu (1):
  drm/amd/display: remove number of DSC slices override in DML

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2557 +++--------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   20 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  463 +++
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   51 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  114 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   13 +
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 1637 +++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |   73 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   25 -
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   81 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |    3 +
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   28 -
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |   40 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |    3 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 2039 +------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   15 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  130 +-
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |   25 -
 .../amd/display/dc/dcn321/dcn321_resource.c   |  649 +----
 .../amd/display/dc/dcn321/dcn321_resource.h   |    3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    4 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 2244 +++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   74 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   64 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   70 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   10 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  684 +++++
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |   38 +
 .../amd/display/dc/dml/display_mode_structs.h |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |    2 +
 .../display/dc/irq/dcn30/irq_service_dcn30.c  |   14 +-
 .../dc/irq/dcn303/irq_service_dcn303.c        |   19 +
 36 files changed, 6035 insertions(+), 5189 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h

--
2.37.0
