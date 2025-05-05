Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDD4C3ABAA
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE94D10E078;
	Mon,  5 May 2025 13:14:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AGhf2yNO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D15910E078
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:14:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxKGKsLOA44ERTOwjnBkP4j/Hv5DAIiVB1L+JTwTOkW5eZ+y90NufqFkmfYUT1+b5qJflg1aeWF46qp9VjGfu1D+OdSL0ZKwdBVyuqojebnFevShBsbdY30RAjbcqgYiam9zKqgISIM3MzM2hkjgFBAxdGFEWQ5OujpytSPKRWoc5t9Q0AV96qjqjvUfo9oRx4JLM2mRSt8Fsg/Wy07YRhvCom9XcS1fc+x20qRI9K3Inz4EHOd3AsF2h4YTaifxcuYwb5iJHd3upplNkyzDgUiyK87lBzH3XYhMg6uKSsmUTOyRPFs6HZURxWE9aaH8j81zEuj/YGvYXSFD6q7OXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhQcdrxOnRowPhAtfrJrT7/IlWT5HMYmtqJ49Lqok2M=;
 b=WceO4nON/4+WUtSVjMKVGMeFeKXbIMn0uqlAAwn+hVQa7ytreZMtPfqXt5Fvr5d/+Br4faOmzJ8LYcxvnNbiAtnF3HSdwXtKz2K96DsIv7YjsSrCvjO4xsfVzxvcV6YV/IU890vkifm3kvzRLOCaNT0agZeV3Gj8RKfuC9NwB/oIESpraiuRYy511Ndm2BWhaXri6Re2xuSWbYUlxsanvFiEq6WFCRb79DY3kMXEtjC8nicdqpHul5u7o6OPIy3wn0fMeCtnNU2S1N/qHsReeFHB2bytolfPMaqCs5U2WDIr88iEPGhLaAhTMAsf4BfQbMW0/KZQiQ7kmyU6hNW80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhQcdrxOnRowPhAtfrJrT7/IlWT5HMYmtqJ49Lqok2M=;
 b=AGhf2yNOUSnR4eu2quiJlTGptsDI9kZCzFaMPdrr8a9Vor+YWXrqVt79wA+CBKQNUWk6KXGdZM9YEK/oKDMhNSgeAQFkc/Wr6XP2UzsoeoFEMheAbzfsU2qlBQ8SRtVyyzNStB620YIXC8v7hkad4W95z5eFJ+WKej5nkvU6zCk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH1PPFD8936FA16.namprd12.prod.outlook.com (2603:10b6:61f:fc00::624)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 5 May
 2025 13:13:55 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.8699.026; Mon, 5 May 2025
 13:13:55 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/28] DC Patches May 05 2025
Thread-Topic: [PATCH 00/28] DC Patches May 05 2025
Thread-Index: AQHbuEU3y+hwBSI3TUGjcY9d78/2hLPEDj9A
Date: Mon, 5 May 2025 13:13:55 +0000
Message-ID: <DS0PR12MB6534D901085ED7AB26ED3DE49C8E2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=a6ba188f-0ab0-454c-8020-784c84bd70f9;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-05T13:13:47Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH1PPFD8936FA16:EE_
x-ms-office365-filtering-correlation-id: 79542908-5f11-4525-da21-08dd8bd6b072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sDniQOXciFw4WbksiLUGe+HoMoHZ9OLqSOSkyHaoPpT9vFQMfURiBJ5+FK?=
 =?iso-8859-1?Q?9DP1AimEhydpRmYfgndAKtRKd+WtDvXoJrCVww606sxhiZYnBvsGogcIte?=
 =?iso-8859-1?Q?0d0Tk0uWZZ6Pb9/cszBZ2Wk5kNi5xGNnn4MEvgDQ46GmnLlFY9FhylSZ0E?=
 =?iso-8859-1?Q?fPOCbFKkA3wNGvAw8621fIZWIpzQ1elkS5zZLCdM/+FUsLaakEvBb901Y1?=
 =?iso-8859-1?Q?XsqxF6mLQWHOH2BUFjtrkpQDi8kH0/twDavpOas9zioy//pZ88nrPkgi2O?=
 =?iso-8859-1?Q?eUOdu93PadHFq+oqxIXIzMSXtXkc2zaOu2kgDtafGRwGN4Oj+GdYcNOJuX?=
 =?iso-8859-1?Q?si8Km9H6xZOFQxFGWm5IEyL6kqe18YD3kzZ5sTYNXlTCT0770/uLn0RgDs?=
 =?iso-8859-1?Q?lSbOJzeOh1ttx21zv51CN5Ilj4/ty86uGzb15s9lwrGF+/zcIMGfCYKrmY?=
 =?iso-8859-1?Q?BD4wVmRW3bE6HkPbcIEAoKTIhZ2dTVTqVLmWfN+LMmXtIznzv6VW1SbqQP?=
 =?iso-8859-1?Q?1+61Z+p10xVgRyeMd4cssMA/B+GYuzm1q8TTzbWiVhoVe2H57icOb+Cr9q?=
 =?iso-8859-1?Q?0rgZ60g3L1o0AoMvOjy8Lg0v0tfDxMxbThg7rBOZ36Y6z+J/46Zkfro409?=
 =?iso-8859-1?Q?V/R2K52E7AUjdA4wltyaJrEBvY6s6AT0R1K8apXEMSV8bSWb6QDaGozY2x?=
 =?iso-8859-1?Q?j+E8FFwom89YFisEBVhNt2plgCvqHVqNsTIjGWw8LtGHi8ZwdgS8t9fRrI?=
 =?iso-8859-1?Q?4chjEuttcu+3dVRkfhtdiQFPuRXrEgbxMVyJweUAemLwsFbzG1+iHu+Sed?=
 =?iso-8859-1?Q?trqa96niCKzbgTJ9bf+6gckxhcpsImWZFejkqcuSoL9fzkV6+y4lk74H4m?=
 =?iso-8859-1?Q?J7ttTOVsOz3Angdhs+FTq+/2zoVtPCL9awBRSKF4B/6sWjHcl01HJ3+GSW?=
 =?iso-8859-1?Q?ag6F15Trwg5NtIqexnfKAAVCwfk1sOeDfY5rKgCWZy5YYRUCRFBm9kdWKs?=
 =?iso-8859-1?Q?YEGE9k3lmJmKqDDZPhMNc3mE/rvBcm/3NlUdSMT4QOJlzvn7w1If3Bd2AY?=
 =?iso-8859-1?Q?QXXEeaZKyenf6iaILBxfYB5ucuEz5LL0X2qvWamCpxRl+sgxFWu4UtBkrj?=
 =?iso-8859-1?Q?2yIcsG3TnyFncW3olKnsIE/cHuvAApC0UgKOZ4Vto1piJ80d3xvK9JlDiZ?=
 =?iso-8859-1?Q?9+L79fxNfWoW5O5Fn8rlG9jp0Fg6gtEt8W1yvPBZ4TOOdb7TPjqGHpJgpo?=
 =?iso-8859-1?Q?jkeSSsFBb8itn5Kheq0ISs9Dg85j6AseVK2NJnfzeUx8IOb9fRBRH3S6vy?=
 =?iso-8859-1?Q?EQCd6bSTvpYN+raoOZmQadu00gUMz6fZqsSSIjDn371kIHihyUOQ7utmid?=
 =?iso-8859-1?Q?mAOG0y+epaaqamb9S5fzlCqQ9AdRDrfczwa2SALqxarbVhYUmXOU99c+Zu?=
 =?iso-8859-1?Q?I5KH1GmdQdU/2V0MCWoQekyBOjn7j5NRmOTQ+0AKaEI8tnsR/kBJn+tvfZ?=
 =?iso-8859-1?Q?mRI7nhpVtAu/dLOWrqxl2BWrlAdBc9GeBGqArObuO7Rg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LCRpdl3MZ8wktwkGxRZqeMYkAlxMC6fqhcjW/0u8rwEn7dSZaQNTkSeigI?=
 =?iso-8859-1?Q?yH99G23cW6z4S1ehXi6bagPN2ZQSdcivFkLyKx5AuTkWs1cIv6d6bE7b7J?=
 =?iso-8859-1?Q?PEaLnAIF40h5jO+6dvKNtTliM0Q7TRP9q3flwil3hRrvwbUBaFxFqlP/OW?=
 =?iso-8859-1?Q?qMQ/oH94XpMFXk9BhYrGdHCtqsPoP5F/Pf4P+mIGxh3O5FdbkPGoaOBdPb?=
 =?iso-8859-1?Q?ptJaJYptCEvgHe6kkJZBm+lv/D2tWBLNuJo3+pVQ0JfoTqszr+4F9D8GQO?=
 =?iso-8859-1?Q?3D13rkV5oH3oZILEBsWlzprZnLKsZrIenJ/sAWeRKMcjw4q0bYPxoGDU3b?=
 =?iso-8859-1?Q?8tHL/zBbeJk6+3FwSSw2+dVcGraSLriljwmBVFg/TkRDcwuzkC59lYzVZX?=
 =?iso-8859-1?Q?wWHS4nYz1CTo8QK/n1/9PB+DStZsT+a2BKQaQnSaiYkHdT+9frq8Aj7B8x?=
 =?iso-8859-1?Q?fUju2RH6Xu4bfcKG1umjUHd4vaCL0Z3WowL7RTDE/7D62R4fG1RJbJBi6x?=
 =?iso-8859-1?Q?VynyYZjRzrSvIj4nL4Qae/n5Jy7ta+B+6O65GMxtNk4sp1MrBS7f9kEXr2?=
 =?iso-8859-1?Q?3OjAfmbQ4JDzllBcB1gAcXHH5vYJm5RVlN6JxfPQaPS5lOdGBJcVTfqolc?=
 =?iso-8859-1?Q?24O2/v88opNZ11Wk01k3ZkP9KFUYOa1Mm8adDSl5fFcOIVetIPJkiY8yix?=
 =?iso-8859-1?Q?MsmBTiYbRNrNEQDsUrPYJP5ToB4n8c0z+WbiscGrjBvHmgKdCdTAPbfdvy?=
 =?iso-8859-1?Q?WLh0WL1tCGFj0OBd8i1eDi4W/6OeOf4d9WdJtLgci/+ONxYdTuBlvf5MnF?=
 =?iso-8859-1?Q?b9gJREKpWQbZMTJvkucksEklNrYQDgZW1vxoH3NHFwc402w8GY/BgCRARz?=
 =?iso-8859-1?Q?//vn5RlVD/7lCJqyVPeFiPwYvz+k/x44+MBMZ/IRP9mxTR1M8iRQac0VI6?=
 =?iso-8859-1?Q?yY1j8BgvZEbD6H9vNeefr24JPfKEWw4F4L9x/Ou+gZFKOYVcqhlbAjA4D0?=
 =?iso-8859-1?Q?hDTUwXkCaHBDAWgHqHVFj+BVEY46lWMzOew6F+0pLSlj8hlsOb46lDxan8?=
 =?iso-8859-1?Q?MU9/B7Uwh5FLwQY9vx0qPgyN8LZKZLXYjXiupq8cmDquVozWhn58gM4d+L?=
 =?iso-8859-1?Q?cFcBJdLSB9F8OctiRi3ybI6EjHt2F+EkWWOmXCJ+8xHMBQWlLUEXJy5zp2?=
 =?iso-8859-1?Q?kWsOFtdxUMoPQtWQRL/piU2TlMIQvJXPNfuehhahcBwGrzc5h3CIYZbjvH?=
 =?iso-8859-1?Q?4CXQeMS5iBU8f2cNIr7jTX+e3lr6MJPr6V6hNDQUOzgz587+/FlA12O2S6?=
 =?iso-8859-1?Q?DbUaMvXjA34Cx0fTjmvJH1erjtx5SAoTy8uA4gxvYA27kl++LSc01whtEY?=
 =?iso-8859-1?Q?jWBvSgNi8zhI+4KYz4IWvUz7AshVRv4HAP+Rcd8CkMnHZOOzeKk67xI3PR?=
 =?iso-8859-1?Q?7MIH8fKLw0UWVQWaNOrLK/G/wh12a0CSOUlvleUypRhRw6Iilb5brqOboU?=
 =?iso-8859-1?Q?pQsb6LsDIZDlFbX5hTtgUDv83CQPu4jMmFrP4/dkqyMY098gcxj+syiJAu?=
 =?iso-8859-1?Q?wMu506XawxPvZEh9JjmDlaheUaoPCNHP5WzDsCSqRoXztixb4xolnpbUi1?=
 =?iso-8859-1?Q?b7HI7A/QdMv/M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79542908-5f11-4525-da21-08dd8bd6b072
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 13:13:55.5462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAUG3gZgBMPj6kj8YZqPN7S1rccMd0AtLwwtHaIwpM4NtcFST+NH0xma2Xqsau+RqWINZ+FB+jvrjkxjNPrq2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFD8936FA16
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
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - b53=
83f917c59e8a5e61f469bb41dc8c826258d92 -> drm/amdgpu/mes: remove more unused=
 functions) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

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
From: Ray Wu <ray.wu@amd.com>
Sent: Monday, April 28, 2025 9:51 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Hung, Alex <Alex=
.Hung@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/28] DC Patches May 05 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Update IPS checks to properly include all ASICs.
- Refactoring DSC enum dsc_bits_per_comp
- Remove redundant NULL check
- Revert "Refactor SubVP cursor limiting logic"
- Disable DPP RCG before DPP CLK enable
- Add skip rIOMMU dc config option
- Fix race condition in DPIA AUX transfer
- Refactor SubVP cursor limiting logic

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove redundant null check
  drm/amd/display: Remove unnecessary DC_FP_START/DC_FP_END

Aurabindo Pillai (1):
  drm/amd/display: more liberal vmin/vmax update for freesync

Austin Zheng (2):
  drm/amd/display: Call FP Protect Before Mode Programming/Mode Support
  drm/amd/display: DML21 Fixes

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactoring DSC enum dsc_bits_per_comp.

Charlene Liu (2):
  drm/amd/display: allow dscclk disable
  drm/amd/display: disable DPP RCG before DPP CLK enable

Dillon Varone (2):
  drm/amd/display: Refactor SubVP cursor limiting logic
  drm/amd/display: Only wait for required free space in DMUB mailbox

Dominik Kaszewski (1):
  drm/amd/display: Prepare for Fused I2C-over-AUX

Jesse Agate (1):
  drm/amd/display: Always Scale Flag

JinZe Xu (1):
  drm/amd/display: Send IPSExit unconditionally.

Kevin Gao (1):
  drm/amd/display: Add skip rIOMMU dc config option

Leo Li (1):
  drm/amd/display: Allow 0 dtbclk for DCN35 and above

Meenakshikumar Somasundaram (1):
  drm/amd/display: Assign preferred stream encoder instance to dpia

Nicholas Kazlauskas (1):
  Revert "drm/amd/display: turn off eDP lcdvdd and backlight if not
    required"

Ovidiu Bunea (1):
  drm/amd/display: Update IPS sequential_ono requirement checks

Roman Li (1):
  drm/amd/display: Fix invalid context error in dml helper

Ryan Seto (1):
  Revert "drm/amd/display: Refactor SubVP cursor limiting logic"

Taimur Hassan (3):
  drm/amd/display: Promote DAL to 3.2.330
  drm/amd/display: [FW Promotion] Release 0.1.8.0
  drm/amd/display: Promote DAL to 3.2.331

Wayne Lin (5):
  drm/amd/display: Shift DMUB AUX reply command if necessary
  drm/amd/display: Fix the checking condition in dmub aux handling
  drm/amd/display: Remove incorrect checking in dmub aux handler
  drm/amd/display: Copy AUX read reply data whenever length > 0
  drm/amd/display: Fix wrong handling for AUX_DEFER case

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 45 +++++-----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 28 ++++++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  9 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 15 +++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 17 ++--  drivers/gpu/drm/a=
md/display/dc/dc_fused_io.c  | 12 ++-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    | 62 ++++++++------
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  8 +-
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |  1 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../display/dc/dml2/dml21/inc/dml_top_types.h | 10 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  7 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 82 ++++++++++++++++++-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |  3 -
 .../src/inc/dml2_internal_shared_types.h      | 10 ++-
 .../display/dc/dml2/dml2_translation_helper.c | 14 ++--  .../drm/amd/displ=
ay/dc/dpp/dcn35/dcn35_dpp.c  |  2 +-  .../drm/amd/display/dc/dsc/dcn20/dcn2=
0_dsc.c  |  7 --  .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |  6 ++
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |  6 --
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |  6 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 21 +++--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 -
 .../link/protocols/link_edp_panel_control.c   |  2 -
 .../dc/resource/dcn10/dcn10_resource.c        |  4 +
 .../dc/resource/dcn32/dcn32_resource.c        |  7 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 25 +++---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 19 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 24 ++++--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 72 ++++++++++++----
 35 files changed, 372 insertions(+), 165 deletions(-)

--
2.43.0

