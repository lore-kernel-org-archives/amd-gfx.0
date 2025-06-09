Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB38C5B552
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 13:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 007A410E378;
	Mon,  9 Jun 2025 13:37:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PUJBzW/R";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF4A10E378
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 13:37:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIXlJU6MGfnOTpFRsmsUuE+MQiBF+6MlEgLwbHZxoT5UHOt0/oycIxMgDjIb0boUVISvTy2es9/qTF8tzmj82tPuqGgKQ0qFcAixc9YR9n2dFxlM8+9jg9SJRct/ZU/sQgoKvcpgGLdk5f5qAtahx0NY76016ZnBGh+KdRYYjqoR0vMvCq7sxX0n17LsPQSucC+rwkbBdmx4iuWKdlmtQA2ao//jDUABZQv49a48O02SFICH457uqCMpqxnVBWpXXhSOUiDmHW4AZOUs5n8y4tt51A+Nk5noJFr2icIMt1BYBuQgoMq9z43sVO8gAJN68UQZefAmsXVLqiHcsaxWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZioVC0jr5Qa190iCKzXZfc5c1a4rPkASFJl+ixhpErk=;
 b=rjd1ZPn/FYmkZoOKdLRU51P2ZElxWUUugliboDFH9/h89EBv+/eWvDN50/tLJDRMS2kC8sM1XUm2+k01dmLZa21E5GH3cpa97P57SD+vl3kLyHXYESdbsGk1HdnYN/KE6i3BwqkjrsuGUzklKDobcJGpGqPU0EnSdvc9IT+tcSPs9I1Og44oUt21UYiZ5kXU8Af/q2EpsGVa+skRefzFtxPUoLcKkZoksPUNMEJWMRIAyWhhBNczmHNn2ZWg95Ndm9aGADukjsxEMIXYiXqm83+fD44b8xCBpCnh9el3DGio1wiGK5xzVI17jrA+4DOJuNsUUhWiQH1kGc1taJTaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZioVC0jr5Qa190iCKzXZfc5c1a4rPkASFJl+ixhpErk=;
 b=PUJBzW/Rzo65wjS0zoU9zcL0Vc08xLuvlLJ4T3AerLTLf7BLi5io6o1QiOKjgZBMhCjiCQEq3/+rIoS5qWNRBz3l/vYawUwyiL4B7wh99uRcbB+kfwOwSZNkSSkaWD8u42Rk+SowZJjhHCJFrnrGXJl47YCnzsqLLWRuxENlwVw=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.37; Mon, 9 Jun 2025 13:37:29 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8792.038; Mon, 9 Jun 2025
 13:37:29 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/23] DC Patches June 04, 2025
Thread-Topic: [PATCH 00/23] DC Patches June 04, 2025
Thread-Index: AQHb1YgZolVA/BqL7UmRWK3nu+4/CrP624sQ
Date: Mon, 9 Jun 2025 13:37:29 +0000
Message-ID: <DS0PR12MB6534319F1041EA47B05464A29C6BA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=e783d058-62b6-4d7a-97bc-05f0867a5182;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-09T13:37:22Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY8PR12MB7708:EE_
x-ms-office365-filtering-correlation-id: 30df5058-32e4-43e0-0566-08dda75ac7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Uv3yR+p07E3RgeZoprt7+waqTI8/MFIxeETouXo1IPwAqqRNNpPtTXPpc4?=
 =?iso-8859-1?Q?7LuRGzJgdGigmx9DLin3SygNpeKPKjVPA1FD8W0BusSMk3EkWWw0QmkL5L?=
 =?iso-8859-1?Q?nEsh8PRjc2+8zqUaPmSnUf0Xkm/ys8b1LdcvWMrN+sfcWklXhqNXr73TJn?=
 =?iso-8859-1?Q?T8u50psVYlj0Q5LXSA3Q7lhRBxYoqkI50OjDiCej390no75T/y49lF7kBC?=
 =?iso-8859-1?Q?IptZfFPXmtM+Fn17P4spj0eNziBib0SDabJxfBjJzRryCum4fKjRGKt30P?=
 =?iso-8859-1?Q?x6JkCq493uvh8ZcaC4TSyPaxHFZTcpoSVjNvN8zkO3+I/neILyUajkoBQI?=
 =?iso-8859-1?Q?1gOmvVS7HO+y3ijXSS6nL6ii8JmANCeFTyjGyqUsmWVIltT2lkCxIJJGWH?=
 =?iso-8859-1?Q?tE1dLTDX/73J8pimulPwRe/Y4//8y3eMUJwo+5m/wTMKPA8yYMB5yOVmiN?=
 =?iso-8859-1?Q?3ilF5XURhVV1IlZLT6yod4EfrdLcQmuXYuM048DAedjeFPxE+zV8GifVLI?=
 =?iso-8859-1?Q?hO72j6tmxwBpesfhizTfT95/M3N978OjxqsW45ge3xK+++fQHcdzOIbj7H?=
 =?iso-8859-1?Q?SaeBskHUNBOYT/lcZtY3PE15/ZoQw+hKIOkY00HaNAJuUzEhG2u4bNLSO+?=
 =?iso-8859-1?Q?oEB7ZFRRcxuiQnMnNiZ3h0tmAIaBeRtcc6y2P2MkETmudZHaXV0ShK7k0D?=
 =?iso-8859-1?Q?hWC/BSEtRkiu80nbMHl4IPJDyZ2SI2N7Jst5uI0uRMU0EbErsO8HG6bYag?=
 =?iso-8859-1?Q?T0NhYwM6iBrH5dwMeBPE+NZ3jwEuvtpJ18MC8cCg16RSEQJTWuLHgSkyf9?=
 =?iso-8859-1?Q?xFprF+R1Zz2PYrWFjpsqaIqV4hiImPwKms3RXrg+ZuYfAZVxEgPD89kl92?=
 =?iso-8859-1?Q?f0+Qaqor8dsBmsoWDcoLHqr4yQF2fzd63DEmoxYhkFllokjkhIWNY9D7oh?=
 =?iso-8859-1?Q?U8u1/CzbLED7YkecXHIkFMCrsSdeDcWTiOY1aHGeeEpZuZ8FXzmWGP4bYR?=
 =?iso-8859-1?Q?DfSuniWtKby01jj6fMUlN8XSvQWGqhp6OepCP7YK9zmObzOd8vE7GUbnxC?=
 =?iso-8859-1?Q?imz/tTUkQh0B8fISLNBc1mTavRwjOLDSQ2gNtOhlKL6w/ug8yWFrEV+Un5?=
 =?iso-8859-1?Q?xPIA2p1WnbrdTVuFCpKTnVM26AS7r4BryIkurrnnuYqfBMudFDTDIkS+Yn?=
 =?iso-8859-1?Q?rPdgA9GZ4SvMbm7bW/qTyPcuW3pJjZycGW5W5cAfA3wq2wswtvBQ2FC2Bu?=
 =?iso-8859-1?Q?nDwqayPIEur86KNJG/N9ToWCtOAiJOa8iWlCjDYDMjK2gxOq2EAiUhX3Kl?=
 =?iso-8859-1?Q?Rq+G5rqMVYArz4mdDkpExVHBnt9dC/YyYQGuoN3r1aBTnFGY9c8IaWnkqF?=
 =?iso-8859-1?Q?2i2eMXp1Kag5guw1425QARD3nsZuSVElN7dGyDnBJlb9q6wmEg7PgdBxb6?=
 =?iso-8859-1?Q?YSycyz9hvauIQPKxxgw0mfhWQlTVN4gDm/fhVBuR/0RWx/Tj/3wOdlm4Ll?=
 =?iso-8859-1?Q?Wyn5hMOHwpywA9zNWa6gdO51SzLMlh+JTh+MqI4nQp7A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4QrGZdD0P2r88LR7GMyv57bqxIju1rhgRPoG75kLfRwCTA6WwXT/eTaYBe?=
 =?iso-8859-1?Q?kNEhP22arg+c7Hlhi/Zdi9YXbpP46YmHrKiYMCJX+YBMsWMoXjzZqonA7q?=
 =?iso-8859-1?Q?yCX6j3GOSmCzkowudqHQ0wIZGMvrYab4Gr6Kdur4ySJtISPpcjZxbEVRzk?=
 =?iso-8859-1?Q?Vngl790eDvc/c7FhYTNy6Pcru9lqDhsiBYZqjtrE0ifKLHBjQ/1bBDXOqh?=
 =?iso-8859-1?Q?pA+Y9icOOQR0GcglFk8IBPdiOw4KKUFI2um/ubcXraDnWa5CcX+Sf1dnMe?=
 =?iso-8859-1?Q?Fl5LL2Ns2qE412aOh2AvGRu7t8RIrbgUTVY/TVM8felM42Rrf2KiAF6QgZ?=
 =?iso-8859-1?Q?aUPhlZNmjJUAsjw7JMvppVmfFQBaWsvCqG96KC5Mz+Spf93x7xG+QT/Miy?=
 =?iso-8859-1?Q?vYhZoObVqljhm99OEEZheHxicIyaw0fOuBtGLLvriHwxS/AtCZCVH8DigN?=
 =?iso-8859-1?Q?bMbPljL7y0Z0JRpSWjxcKE+Q2x49R1SRyZUR6utOhFH1EITJWhxt6MZcuG?=
 =?iso-8859-1?Q?o2D885e3/i+gRacIBe6eagHPqLbs5UA0Upv/FVkQrtdV8929G5DzvQbe2F?=
 =?iso-8859-1?Q?OXnJoNPFhe8FIwKeafr11rj/0/G8deD1ctKoGpFS2SACTmGIevMu3Du8jI?=
 =?iso-8859-1?Q?B4RJIZg53XdUDL47ye5cK7dpDOM6ycfS3nPo0/raHYv3W5dxPsFAUnMvI4?=
 =?iso-8859-1?Q?jqGhFc0foL+R2oDqvHptvVrfc6O/B/mPaG9qoEpnaBk454KMHVMGDArxFN?=
 =?iso-8859-1?Q?hXIZpg8Z3y1UyH8NQfjBDoADMnYSrcTExGxRb5ceqRQNMmUKwa9TcxrV6K?=
 =?iso-8859-1?Q?5w/D2+3z9oETM40oQtHJ9BWneXXBpNaDJ27C3RNA2y3939Rfz2TbJE52a2?=
 =?iso-8859-1?Q?0HQt4AM883Mp44iDAln3yolxas/TTiOCyse3IztzlQ0oWwyLL/r/aAKcWL?=
 =?iso-8859-1?Q?+1dMegyxQ+2bq8KLZtaYx/g5FeIBo1AzZAYs5LzcXCs9tP0s1xappy2v5e?=
 =?iso-8859-1?Q?lhtcnzObj8oQDDC4F+7t0kHm1qul0nd5ERh3LTAD/QDA0lK8+QRGvuVS2g?=
 =?iso-8859-1?Q?MjcJ9iCwgySGu1qSmK2WJreea9Zu5vxKP6Gw+c/z/vsXmXNUMLosK8YuL5?=
 =?iso-8859-1?Q?ryiaE6dLn6dg/IqQUTnKy7BUbZqjFcLqmNvXk+tUmZwq9HftigBB0Ob3vn?=
 =?iso-8859-1?Q?PL/X+vxPvwUOELapZxptM6Z2kMvn1Rpmpjk7AX9mwL5CsIBcMSOSUHAKRD?=
 =?iso-8859-1?Q?ns7eX/QjeWMxr/3A2GHrhVwl10WYV7PhX5VKk5gE9pBQBrw/vv9GPqnhs5?=
 =?iso-8859-1?Q?+tHc95OwEtwhiLetydcJktkaQMu1ziysg+pK1l5NuSKTonpo5NcET3k3Sn?=
 =?iso-8859-1?Q?J/kV/1t1MOz4aXRH6XwaP3n0jnvz2tV7PPQ9ieF70Z89Uw4DV/fxiiKnvY?=
 =?iso-8859-1?Q?uitZ/wO50oK2JH5iPa8rQJrNVWdecpng5ETTXI6WxC94USK9FeMtkCwbPa?=
 =?iso-8859-1?Q?Hx76fYvlA427Jg9CgvDVtGOmwNivQBmNcQyp8YpNA/uMR9XPRFzKEqm4Ak?=
 =?iso-8859-1?Q?2ZAiP1rRnlCEsxUsJu3J6rcstxlo577Uw50wlNd39HhmBURdaQtjHFAyuD?=
 =?iso-8859-1?Q?/gCO2YD3Svlps=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30df5058-32e4-43e0-0566-08dda75ac7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 13:37:29.5213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gdPBe2aCfVSwmGl++dXmMATSKNCTiH5VhCHfQxF2JXQxBCGIhb4a7sp4X0XLM3e8CLLfu4RUPgF0GUkjqsBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
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

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 962=
36ac46647f06a2b08ab15ced4b8211836f41b drm/amdgpu: Add userq fence support t=
o SDMAv7.0) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, June 4, 2025 2:43 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/23] DC Patches June 04, 2025

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Improvements on DCN4, MPC, DSC, DP and others
* Enhancements on backlight and brightness
* Fixes on mpv video playback and display flicking

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Fix mpv playback corruption on weston
  drm/amd/display: Fix kernel docs for new struct members

Aurabindo Pillai (1):
  drm/amd/display: DML2.1 changes

Ausef Yousof (2):
  drm/amd/display: Don't disable dtb as dto src during dpms off
  drm/amd/display: Adjust dto fix coverage

Austin Zheng (1):
  drm/amd/display: Deprecate Loading Bounding Box From DMUB On DCN4

Brendan Steve Leder (1):
  drm/amd/display: Add custom segmentation support

Charlene Liu (1):
  drm/amd/display: Add HW change required mpc gamut remap

Cruise Hung (1):
  drm/amd/display: Add DPIA debug option for zero allocation patch

Dillon Varone (2):
  drm/amd/display: Remove dml/dcn401 files and references
  drm/amd/display: Refactor DML2 DC power instance

Dmytro Laktyushkin (1):
  drm/amd/display: Update tmz_surface type to match register

Mario Limonciello (2):
  drm/amd/display: Only read ACPI backlight caps once
  drm/amd/display: Export full brightness range to userspace

Michael Strauss (1):
  drm/amd/display: Get LTTPR IEEE OUI/Device ID From Closest LTTPR To
    Host

Muhammad Ahmed (1):
  drm/amd/display: Add option to disable PHY SSC reduction on
    transmitter enable

Nicholas Kazlauskas (1):
  drm/amd/display: Add more checks for DSC / HUBP ONO guarantees

Peichen Huang (2):
  drm/amd/display: Remove dpia debug bits
  drm/amd/display: Add dc cap for dp tunneling

Ryan Seto (1):
  drm/amd/display: Clear DPP 3DLUT Cap

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.337

Yihan Zhu (2):
  drm/amd/display: Add RMCM debug logging
  drm/amd/display: Fix RMCM programming seq errors

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  63 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +-
 .../drm/amd/display/dc/bios/command_table2.c  |   1 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  87 ++++---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   5 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   4 -
 .../amd/display/dc/dml/dcn401/dcn401_fpu.c    | 239 ------------------
 .../amd/display/dc/dml/dcn401/dcn401_fpu.h    |  14 -
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |  13 +-  .../dc/dml2/dml21/=
dml21_translation_helper.c  |  18 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |   4 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   5 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |   2 +-
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   1 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  19 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   6 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  59 +++++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   9 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 ++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  12 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  47 ++++
 .../drm/amd/display/dc/link/link_detection.c  |   3 +-
 .../dc/link/protocols/link_dp_capability.c    |  38 ++-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  18 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |   2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  10 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  13 +
 .../dc/resource/dcn31/dcn31_resource.c        |   3 +
 .../dc/resource/dcn314/dcn314_resource.c      |   3 +
 .../dc/resource/dcn32/dcn32_resource.c        |  17 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  19 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   6 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   6 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   6 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  18 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  17 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  26 +-
 46 files changed, 500 insertions(+), 425 deletions(-)  delete mode 100644 =
drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn401/dcn401_fpu.h

--
2.43.0

