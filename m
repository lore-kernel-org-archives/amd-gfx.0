Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B03C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB90611C4
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 20:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2CB90611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B836E456;
	Fri,  5 Nov 2021 20:14:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CD506E424
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 20:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPpuGG9RCervfux4cHlFalXvfoG6D/qibMqF33BS+TuRelePqJgsj9D67/xLjtaW6Mna2oDn3djUxhPlLNkYoj4KWpqOMMyfxF2Tft1wvjbHDtpWaZeXRFrCaPGn6nNFqYP4eSSWtEJ+3/ConAqueIM8ahf6eN2TG9vSF1JqjTUububsIC9to5nCo6u4FUNheJumbCnFYf9VqMtehdxDPDZ8nsws782yaDNXwzBw5BL3SE3nVXPv4nDEDDtKHtxy2psLxQCnafBz8y/9uwHXbK5086xkZAXX/6dE2J0zrGcehxYwB8NF+TcuN8X8OsyHcLE+4V4f+ruNQrcu896/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpB87HOmqlBG7pGnG6EzYhkCw8QnsWncjefLs8k1zBg=;
 b=M0wnlxExUChlZvT/G987XE3VOy2St/l5H6ihKj/wrO7JwNKQ7Hkj+7ZwPJ1r/Z6Jt0J7MedWUlqQpq4bfpjeHmIryN4lKR0XCsp6rjCywWywEXC/1wWkMIeMWaLbbsFuW05d9FziZxYSsAZ0E+LuQAnb2+SDwtX5SNgZQPKXJ8+BK5yrQOqhfgIgmM2jsI2Sn0ZAzbmlUJxRoUCj6lVtyjan9ETPCup8xQkXW3meOFwxdTLQW8+POpU3wAnpXgaJrF6qDGmlp8J8HjYwbhR61RW07lkppftyGY1/+8kFxmXBxGzBROW/20zEHFQy22y8/Jr5sZCYJgoYDsvR7G0KFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gpB87HOmqlBG7pGnG6EzYhkCw8QnsWncjefLs8k1zBg=;
 b=OaD7MjmFErNZuw+HWDO/bhFrgFcyPrSiktd6DViHM0qAy0iHw9mpIJotGGUc6PhImTVJK/SYGZNyGV7fHq9QJlzSCvYCiUNVEC9IoywCbENFWip3jcXmF1Y21Vk0gqpGZgf+OwZvMtYr2K+kt/XCoowvFOEUUoPcTdMMHfh8qag=
Received: from MN2PR12MB3535.namprd12.prod.outlook.com (2603:10b6:208:105::11)
 by MN2PR12MB2879.namprd12.prod.outlook.com (2603:10b6:208:a9::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 5 Nov
 2021 20:14:16 +0000
Received: from MN2PR12MB3535.namprd12.prod.outlook.com
 ([fe80::d443:10fe:7de5:c981]) by MN2PR12MB3535.namprd12.prod.outlook.com
 ([fe80::d443:10fe:7de5:c981%6]) with mapi id 15.20.4628.023; Fri, 5 Nov 2021
 20:14:16 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Jacob, Anson" <Anson.Jacob@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/22] DC Patches Nov 4, 2021
Thread-Topic: [PATCH 00/22] DC Patches Nov 4, 2021
Thread-Index: AQHX0b3lLfoiS9jKFk+BIrVqZXFwzqv1X8nw
Date: Fri, 5 Nov 2021 20:14:16 +0000
Message-ID: <MN2PR12MB353598E10CE94ACB8A66DB5A9C8E9@MN2PR12MB3535.namprd12.prod.outlook.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-05T20:14:13Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=715470ec-8f87-4e31-823c-53280d5e5efa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3186ff82-7dca-46cc-14e1-08d9a098d7ae
x-ms-traffictypediagnostic: MN2PR12MB2879:
x-microsoft-antispam-prvs: <MN2PR12MB287955E235E2EC560E5479819C8E9@MN2PR12MB2879.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4tBNEdvN6m+iQU0ChuNbMvY3p3ERukkzlo+OArw/BJpHoxFRlM2Fi1T6bwHp4egEvI+n+I9SGTeImmpG4CyQXcy9IgaOy32N6h2TQj0JTM9PCpFYTOS7O71W7JPqUPud6lsSgLi4vzO/JUrSudN9uWVJ4gFb3esATZ8RauPpOWHrhxoA1xa5muklqp7PL2yNA+ztX1sOurRnElZLDeYukb1jZfCSjFm8XBKDT75urBrd9bbUezBiLhHwCWsCJeoRpURk11yi6SanuYTRRj0Uegyw9v/vT38cN+I41R4odVj6HBq5xVmRlEq/qihpFHpMmNohCgIn9Lcjd/LU74lfrNgMwj5BVzAUnAu9p6VanGsF/jxFY+4IemrcaZvNGBNSxFtTdNSwLcMsgPXtHy4bk4DDOM1i5caporYtP3RuZtifpDbEWrNnIaSt/qDbJKLg+W/xPOpVKnPwvFYqjknP/iLzGFXt1jjO0XiNpkUO3keSDMaJXP8UWnXgsauH4vg7zR07v4x9UGdp0cpGzm2JLGsCSZiukkAOFQdbJAWT7IoNSK0o4QsXqXqyciYJ6oZEy9zC1InAjMRlmMMzO9jlq7VPyCWCI8QqqrMOEvAhB4ZbAG7te2PtxMHj97r611hTGVs93M5SRFQU3Rpycf/agYvo2FKE7jdZnoB9jeIELxaZzu89P36VcZUPEM269+Q2m9kqKhiX7coJZdoymAzMNQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3535.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7696005)(66946007)(508600001)(76116006)(316002)(53546011)(66556008)(38070700005)(9686003)(5660300002)(6506007)(8676002)(83380400001)(186003)(64756008)(54906003)(66476007)(66446008)(2906002)(55016002)(86362001)(8936002)(122000001)(71200400001)(4326008)(26005)(110136005)(38100700002)(33656002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yeIGAU+LPYimNsvjN7pBmCzI9K/XD9zjtYeSNTu8Z1MaXfoGPJKW6hqJPx?=
 =?iso-8859-1?Q?H0wDwTE1AG6DWh+fLEnQ9JFp3SO7je3gQNHdQAhhk9YN5uhpjfZbVVkN9f?=
 =?iso-8859-1?Q?zwz5hiyOx56Q0HZPq+ft8gBBIOiA9GpmlgV0aTBBqytMNNZlQMlVE9QfrB?=
 =?iso-8859-1?Q?OZ2ifvvV3zNrWG2sbY/PujrEVRWr6raDogtov+b3QQF2w7amnR48djx4RN?=
 =?iso-8859-1?Q?LAztEmrY2Q0f835TPeDef1bthIyH5+njEj/m75S+evUA8yK1/bheSdoU59?=
 =?iso-8859-1?Q?VFdIKFYDXCQFv+Sz1PPxmXWrLc2fGWH1OASU8jcPVVLSYZZFe2a87IADJo?=
 =?iso-8859-1?Q?IKIb/w7Z6UsXn7b2FQby3jGQVLh64ObnUY5fPozdflyUhICtoDvNtuFAge?=
 =?iso-8859-1?Q?wijwD1z+vQOIEa3VbC73xrvBRKNjlSA7FAyuFJ6Y3Wv2QdYYaYpnq+FiDI?=
 =?iso-8859-1?Q?cGpOv+qQwtTZ2sdqQClsqcmDP+oprV+Xnxh1DQDM0y9X5YUtCsgzryfkLN?=
 =?iso-8859-1?Q?g3fkok9HZskbabspw9OHqZ5o5ySZ25WZPnTVtOlTZ6pu/X7Og7nBM/tD1u?=
 =?iso-8859-1?Q?qmtxyiAVQTCz0LgI96iFYgNMxa0WJydNPJ5UREqutTrTzk3nCVvGYXB5OT?=
 =?iso-8859-1?Q?VbQ1Cebd8fXtNU5F1urN4ZR2lPQFWYEi57VB3qu11va6FjvuyTKVRwfjZD?=
 =?iso-8859-1?Q?hHGr/vUOH8ENnJ1OeehFC22zkSAfGxKFl4I4rrzz0jgLnNZVNOG0bKaO1l?=
 =?iso-8859-1?Q?CNvPjrZ4WgArbJ2bEb0GboILc2TkEkf0oPLtA8W/Fj6U/0/7yfixILha0H?=
 =?iso-8859-1?Q?zknRZ034KqeWelycTpoNCu/Yl+yW6kd1znGIrOlY9idlXMJXebio+tzdBm?=
 =?iso-8859-1?Q?s9BjmtKIHhXlmeuKcsR2EtvhYs49ybOPPWDac2LnyU6ydOtVACuY92sgPN?=
 =?iso-8859-1?Q?0TnH916/cb3bFj4Pnt321P3YhpFY17awzbkiH/0iory8fcituSI2MSAPN3?=
 =?iso-8859-1?Q?N+cfkktPRkm17sbKWlF5JsJ/z3PoNwt7gKAoKATtR/ET60lZQqTT+aIRtx?=
 =?iso-8859-1?Q?A3760RzJjZHVX3qO0cmuRCoSFeC6sJSRAVbTbQa+poC0lCKYUHZoU+8Bf1?=
 =?iso-8859-1?Q?1/jDgud+ibUaIAdx+42LbB9Lf5qs9yAnv8qbW6CpeeS44RYjULE0TqLLJ2?=
 =?iso-8859-1?Q?AM1EYeAOUjy1rP0PiXyd+qn7d44HaSBr8zuClzoMIAwRN51VGcg0Mqm2si?=
 =?iso-8859-1?Q?qU4nDqDtjC8jmV8Vcei+nfANkmAPVKLHJpdI81x341EuqAfVFFFBzXG/c0?=
 =?iso-8859-1?Q?QWCZVMQzjrZ4bV+6zjsqkrcjyOmjLVqmEA3CwExgWgc0eGzmp3qK23gfkS?=
 =?iso-8859-1?Q?N0ogmMGRAnTd4GsHl9WGYgTGV+posQU5hJaxi7Wi9iTNNV+AIBxnxPzfDP?=
 =?iso-8859-1?Q?C729d45vfA+69KFWnGIZwOSbCSKqvk6fOOAGvra4zvIVTvN1lDoOM7b/HV?=
 =?iso-8859-1?Q?QAxL0of4OaaMHeyPpDiYEdAExHnBHzH+odlSwCk23UxUujxTokRqRpov+K?=
 =?iso-8859-1?Q?xa0vcNbWt25hKHxSw/xljJacdNfAh52d3ye74pBdJjESZSsMExkBhBbSqg?=
 =?iso-8859-1?Q?xSD+2rULaUFw9x/KjnzXX03wxxdzr4vo33mUFT22yADFv9Sw9ZgqD6Fbsw?=
 =?iso-8859-1?Q?QXVBQe1nEwDcWy+MHzg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3186ff82-7dca-46cc-14e1-08d9a098d7ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2021 20:14:16.2709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/lSSyd8a3T0p/o5UHIAwrBAHUyVI5TfIckvcTEXNRGU0Hvu0RXsGYrbeM1DlPvM6Q0Wtd7f3m4cTU26iv+I1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2879
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
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Lipski, Mikita" <Mikita.Lipski@amd.com>, "Wentland,
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
Tested on Ubuntu 20.04.3 with Kernel Version 5.13
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
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Anson Ja=
cob
Sent: November 4, 2021 4:52 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Chiu, Solomon <Solomon.C=
hiu@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentland, Harry <Har=
ry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Siqueira, Rod=
rigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; Jacob, Anson=
 <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, =
Wayne <Wayne.Lin@amd.com>; Lipski, Mikita <Mikita.Lipski@amd.com>; Lakha, B=
hawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierr=
ez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 00/22] DC Patches Nov 4, 2021

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Improvements to INBOX0 HW Lock
* Add support for sending TPS3 pattern
* Fix Coverity Issues
* Fixes for DMUB
* Fix RGB MPO underflow with multiple displays
* WS fixes and code restructure

Alvin Lee (1):
  drm/amd/display: Wait for ACK for INBOX0 HW Lock

Angus Wang (1):
  drm/amd/display: Fix RGB MPO underflow with multiple displays

Anson Jacob (1):
  drm/amd/display: Add comment where CONFIG_DRM_AMD_DC_DCN macro ends

Aric Cyr (1):
  drm/amd/display: 3.2.161

Charlene Liu (3):
  drm/amd/display: remove dmcub_support cap dependency
  drm/amd/display: clean up some formats and log.
  drm/amd/display: Adjust code indentation

Chris Park (1):
  drm/amd/display: Fix Coverity Issues

Dmytro Laktyushkin (1):
  drm/amd/display: bring dcn31 clk mgr in line with other version style

Huang, ChiaWen (1):
  drm/amd/display: use link_rate_set above DPCD 1.3 (#1527)

Jimmy Kizito (3):
  drm/amd/display: Use link_enc_cfg API for queries.
  drm/amd/display: Query all entries in assignment table during updates.
  drm/amd/display: Initialise encoder assignment when initialising
    dc_state.

Leo (Hanghong) Ma (1):
  drm/amd/display: Add helper for blanking all dp displays

Meenakshikumar Somasundaram (1):
  drm/amd/display: Add hpd pending flag to indicate detection of new
    hpd.

Mikita Lipski (1):
  drm/amd/display: Pass panel inst to a PSR command

Nicholas Kazlauskas (3):
  drm/amd/display: Fix detection of aligned DMUB firmware meta info
  drm/amd/display: Don't lock connection_mutex for DMUB HPD
  drm/amd/display: Add callbacks for DMUB HPD IRQ notifications

Robin Chen (1):
  drm/amd/display: To support sending TPS3 pattern when restoring link

Roy Chan (1):
  drm/amd/display: fix stale info in link encoder assignment

Sung Joon Kim (1):
  drm/amd/display: retain/release stream pointer in link enc table

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++---  .../display/dc=
/clk_mgr/dcn31/dcn31_clk_mgr.c  |  8 +-  .../display/dc/clk_mgr/dcn31/dcn31=
_clk_mgr.h  |  7 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 17 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 78 ++++++++++++++-----  ..=
./gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 20 ++---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 51 ++++++------  .../gpu/d=
rm/amd/display/dc/core/dc_resource.c |  3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 37 ++++++++-  drivers/gpu/=
drm/amd/display/dc/dc_dmub_srv.h  |  2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  7 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  6 --
 .../gpu/drm/amd/display/dc/dce/dce_audio.h    |  2 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |  3 +  drivers/gpu/drm/amd/=
display/dc/dce/dmub_psr.c | 13 +++-  drivers/gpu/drm/amd/display/dc/dce/dmu=
b_psr.h |  2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 +-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 41 +---------  .../drm/amd=
/display/dc/dcn20/dcn20_resource.c |  2 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 39 +---------
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 -
 .../amd/display/dc/dcn302/dcn302_resource.c   |  2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 38 +--------
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  6 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 41 ++++++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 78 +++++++++++++++----
 .../amd/display/include/ddc_service_types.h   |  3 +
 33 files changed, 330 insertions(+), 244 deletions(-)

--
2.25.1
