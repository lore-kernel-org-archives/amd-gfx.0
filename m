Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864C0C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Mar 2022 01:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D62610F507;
	Sat,  5 Mar 2022 01:43:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1354C10F507
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Mar 2022 01:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKBzHwuBvK+NoM45v3UTZnok70qcZhlwalOgpMJ1K0NFWHd6VlcwaYl7t64sTFp55/bc54E+1HHtf0PP5ft4eZfpYkgsxOZuc0B40tfe0svNF1gKlZH/WgGVdma2yh6hOCoGPNCH/EOlwcusEzWulAFBT07JOl21FP4Vs3DtLvETl/fDkN/L0onUb7KATtHJnrR0sae7IA+CfUGKtgg5elHeaIAKgDiRgFtPSeK1LUV92N5WK0Q8tCbrfgRGv9fnZzQ9hDK6EBK9XX9oC6C6OI95WVg5grTyB2ThHjbofUJe5Yi+MR775+U6x2zOdXtEg3g9lJL2FjsLtAtwnK0zIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfnFwZRoH0HKAKiQK5ob/aK6Brodyfq7BENV03o+1qk=;
 b=NZxnkGOO57qAhTcBnoyyEqg4RBg8Gn/vgKMVJJpXqEodzenAMvkbSkpghtwgjxvlwoREAzCcVE2r+iAmtuacNKKvv2EP5U3eEqpIfkxmnRzaSuw8stIzdvd0ycg8G+0ERgYHtZvP4hPIW7Fu1foCtj0v3WDqQfdsEvWcjKFe8gwuKnmkLgKstYLMlo5osgWnxyBFgaMrqT11U5Trr8HiAWeANCoBMKWOmfZ3RXaO1MxHiEFKczY6dXgoedgIJ2LpTklP41LIlbH5mUezfweZoYGbtd27c5l2Q/xH8Euij8Ll5Mo+ZecViUTVigopris87zqzo6nnEeHRpAYqyi6UAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfnFwZRoH0HKAKiQK5ob/aK6Brodyfq7BENV03o+1qk=;
 b=aWLm8cm20QzG5/jYbeZB8aDghqU4v0yMbb+fupp4dfyMZ78Qq0NKFAmIXuPfeOGophl1eiHlWx5cWHxa1NRIAeqj9OxB1A1upNjV1oBdnYXLnw2npSg0TPVqjdwEBYdm3E/4mDu38qINF1/aBYvDBzFSq9OB9Kf5ULghGVIOhng=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2651.namprd12.prod.outlook.com (2603:10b6:5:42::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Sat, 5 Mar
 2022 01:42:59 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bcfd:825e:23e7:698c%7]) with mapi id 15.20.5038.017; Sat, 5 Mar 2022
 01:42:59 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Disable baco dummy mode
Thread-Topic: [PATCH] drm/amdgpu: Disable baco dummy mode
Thread-Index: AQHYLrE6BstpVo7ugEWBP9bXKjRSCqywByVu
Date: Sat, 5 Mar 2022 01:42:59 +0000
Message-ID: <BYAPR12MB461485277BBFC9F7910FC54D97069@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220303034542.755479-1-lijo.lazar@amd.com>
In-Reply-To: <20220303034542.755479-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-05T01:42:44.9592161Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca91a20-f95d-4a7a-6f44-08d9fe497acd
x-ms-traffictypediagnostic: DM6PR12MB2651:EE_
x-microsoft-antispam-prvs: <DM6PR12MB26514C065CE5CC99D864377D97069@DM6PR12MB2651.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cw3TekbueTiBdH6syUvAzMD+z3HerSzudffQl5txyMQx2JSDz7Rs0EwPMPiu9uPpCnHz3rKVoXn8VdpEQL/zuZnAZ4cjIgijpZjwgzoHEWmx17Monh2oJeSqwW7VoWI2aDOz3UHdkIvvw+WeNMC/tz9/0WzpJiXSbVaUxugtT6pfJZO6w4WR+p2vx9rpLjL2+5aDvMFVUjpxjnCqQTDxxexQZAWWc/rjyK1YZiQqGfCayd0xcJ4bHdZWVb8wuUeZBRLYxB4MJa+cqZm8Btqwly4u8w187jCb4Sg4WXjDGRnEgtS1yBwLv+txZJCfSLnIT6+OB9Y4mH2U6rZA+ibEKSATW46Fm7J7UTYL766ten4a9uUI62VUZiiY0bKupbmEzGRiVh1fzvAIG45Y9hSvnp/sNF/NhpFA/TSnHCC0ddI/vN1q86lP9VQPMEodBWMgIypOcKN4YmyIJ+HWLvp+ezLX+SlhezJPfViRiAFrCBLN/tU3IUDVRuQMmOqbLM80yvVxaMyZZvx2KY0k7kPi4FUGnpKM2+vhgewZfBoJsG3wTeijK5X1XJk+LnJr+xyO62iOh1nxWvIkdjnEWuLDLhN2WiNc9jWZqQxVlJa7BDjah1HxoBHkTJ9Nu+guQ2x2LUtRt3+0zDkcbG6Sh2d5zvJjRe2ReN/aU0LEGEIre6XAOjIW3CSaz36cpxx8ImPubGWnadjK2BJ+yC8w8Jgviw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(122000001)(2906002)(508600001)(38100700002)(8936002)(558084003)(52536014)(5660300002)(55016003)(66476007)(8676002)(64756008)(66556008)(38070700005)(66946007)(66446008)(76116006)(6506007)(4326008)(33656002)(316002)(186003)(26005)(54906003)(6916009)(86362001)(9686003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QBSQLTe39gPwqZj20ETAED0fblIkFD3C/9kMAHgub/h58kR9c5tBtOHnSBom?=
 =?us-ascii?Q?Q91ONXctj9iFuWJOTF4Ghtn3JAgjyflfEYeWcpynBq93QvJeXAhJLu9JwLpk?=
 =?us-ascii?Q?2Gn0Y6OYMVIElLJ7tWoxRWyisQ27KJTVFPTm29eUi7/Q1AbK2eSphhaH7B9R?=
 =?us-ascii?Q?mjFGGz+zjauGi0dR5Dh1IQBeMAfvNLcI8yRxrkTp2wdnK9aRk/tfmqCk21NN?=
 =?us-ascii?Q?MlgLx2pYSo/an6hDDkjn7REQik37VKCu0wpJc1FWts7R5myfFztW2Ku1H3oq?=
 =?us-ascii?Q?3GMyYtzSylUes3I2l2DgLbP3NiEgV1iXtpCcgQ7Xz7cINCKA3S7WJ3ZG7tJU?=
 =?us-ascii?Q?9OlIQY1dayyTgciCPE7USQ9PcQWKxn5G4aWmGWIDowUf6Up5ptxTQQ7nSunD?=
 =?us-ascii?Q?C7hop+SN24OzfWD9gr6YPWq2Rg054Z/206qIMMH6OUouXmgyj8FdIQsqjt0O?=
 =?us-ascii?Q?B33fJZhhLuWDgf3AWgczHrZrhYAEwrZlvVxGThb51qk9M3Yt5omFSPACILiP?=
 =?us-ascii?Q?+aiOs5+mmZNV1EzWxWtMvp1cHhfhIQUiCMF9UlUbfAHRG49vsnIMPc4owH/A?=
 =?us-ascii?Q?du4jqwNlTbY3rKBQCQYZtgVbxWYLxysL28R/7wY/iof8gsEWGiKwWdxrSoJS?=
 =?us-ascii?Q?FfuhLwlRq5o94xmbG2kB5XG+fUmatb78BGjzEVDutNqzMCFNoo6f7k/Za8nc?=
 =?us-ascii?Q?Uu0EX1kYrU5OqpA6Y53ShdtlJuyobD3m8EV8+KklbcazR+VjNkkFIOi3adX4?=
 =?us-ascii?Q?ltB0xojtX/tRBgKv8JJ6AlQ1D8onoRs1m8C3cKQKYPep+OdheVj0ABHjNOG8?=
 =?us-ascii?Q?vvUw2nVTEVs9CGPMxH9wlxcZU75CA2nhNoy3GfLUdYf8k0y4KKbw/cWtrfUi?=
 =?us-ascii?Q?+LoX0oAwdLFOpP0qb9TAkbquiG/z2CmvBYhou6aXrlGXgO3jL+tHtndXs7Mo?=
 =?us-ascii?Q?NO54TWWiIHpI4EsLsQ5smcajbLOF14rJQ0b31ZjRiDRc8/deAyGsGn1fGN10?=
 =?us-ascii?Q?WaTga/WOYC4qZ++wIHzYAdBLK1I1Yfge0ZTuM1F5hs+oTFBLmgVLN5Vl5BHJ?=
 =?us-ascii?Q?PaNJLJaPKvAiwNQlPVIsrGdpMsPjNHLy0m5DjevXieWRP6Bk27XoszEB3whI?=
 =?us-ascii?Q?U39vAafbDfYfTiQ7NcN+MvscRLTRF083d7Jx3825wyT8D/L8lMV6idQdviVL?=
 =?us-ascii?Q?IGga+vQbr2wfnqmLP02dCk1eLsiHCe1w/YYjI7uOngw4KVlxY1Sf5S6xjfsh?=
 =?us-ascii?Q?CZSmsztOJy7eiH5ooFpsHd5cdsV2Kfo9GwC3fo11+CKRFIaFZ2kqKVtsFK/3?=
 =?us-ascii?Q?KrtBIdLskCfbKr5Uw2wNlnYC2X/S5qZSsEfsx4L3Qlolp75PXn8QuE+HeWNm?=
 =?us-ascii?Q?tB56+6qJXO4/ui8P4hANGXNRO6HREXTay/7K9uziHqv73tHk88+U7Ix/canQ?=
 =?us-ascii?Q?/9rCx483i9WPb2rnJTLyghCcir4A2zDPgAIA6i3kj9dgDvHtvQhBO3EOgbuK?=
 =?us-ascii?Q?yfxZvrpKxuHzc/0xq94WWRHK53w43gp//kFeH59TLx4XYQTwdPUKvfG/aJPq?=
 =?us-ascii?Q?SNh7ACRoQ94INC5dtt4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461485277BBFC9F7910FC54D97069BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca91a20-f95d-4a7a-6f44-08d9fe497acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2022 01:42:59.4268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2LqTYAXGupqJKfQHQPI4puXZfvlcOHqKmyN/0sHrOuZMTwQJ2y2SFXGnYpIQxur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2651
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461485277BBFC9F7910FC54D97069BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

<Ping>

Thanks,
Lijo

--_000_BYAPR12MB461485277BBFC9F7910FC54D97069BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
&lt;Ping&gt;</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_BYAPR12MB461485277BBFC9F7910FC54D97069BYAPR12MB4614namp_--
