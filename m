Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D947DC55175
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 07:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C92E10E237;
	Mon,  3 Aug 2026 07:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=solid-run.com header.i=@solid-run.com header.b="Z3qX3QA4";
	dkim=pass (2048-bit key) header.d=solid-run.com header.i=@solid-run.com header.b="Z3qX3QA4";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022125.outbound.protection.outlook.com
 [52.101.66.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8CB610E4D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 06:59:14 +0000 (UTC)
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tY3nQmeZiuCyP2fOLZlwzeTRc1tdj5yei6JKv/7OobYAa/DNxxGdT9NyxGHm43JyfC/AKl4KbiuhS8Izhe+mmFqKeQqZP8ZOxq2RB9p/9SlcGuKVHgwSGYeOlRUS0o2IX4vfhJX9XEoGyGciC/aKtkjNmFuvd7T0rkaVZOFpSvI2/6Ku0hIF0ILnqHFWC2lXVFmVCm7/gauMPI3uvylZ4I+n32m22oiSm1pQY3mq8259KhbPN41Nu8SS7cKOXktc3lHAELlGp1EhyHZtk9M9sgT8spWuCe0cozhJJbntn4kyNr0YTSyNXwuDIhXPW2qVJTfe00FEYkc2x/IUf3VORQ==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soj13AAwwv/KkdDe9NwQvE4rt4i8WLATNPgUwiiPNe0=;
 b=twtXMvtbMDe9heKN4EW6+760f8+NuZK71I928vSzTWViEug9LVmQH7p08oJ1PRIDq4RLqMaApRSHBnW8S1ltef8xMqDoc3M3DiCOsisLyyF0bgkXHdiwja1q7erDEK2mSPc9njkjrU85pCiPbUJ5gL2yr2aSgMuejWJvbAmSPWb8ij1TYCS9GEiOIf2IyGlymp6RwMmayjHLobYS6PCI1m5rVIFO4J0+8eK5GWfEqdPRRK1TaEZ+XaLOsTWQBWUVg162701MC5Q3/HTWHSwgt9TcVQYvcx5cS0rFJLayAv6hmYUjQKYhOE9sV9YwfwjNqeoqsetvimdz+70h6eDRpQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=gmail.com smtp.mailfrom=solid-run.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=solid-run.com] dkim=[1,1,header.d=solid-run.com]
 dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Soj13AAwwv/KkdDe9NwQvE4rt4i8WLATNPgUwiiPNe0=;
 b=Z3qX3QA4nQPtgvmIpLA4jG81hnG9mJhRYO9Ey+CQGaW17lgxT1yJF0VPWSopJJXiD5ZFQ046ZnYKrQkxojOkB+ysWKsd7Ubu5H13/Pu+O1iVmG7jGKfWx3Y+5fCXaU3acg/+qi8ZI5zZs5pw/hdyUXZQ9slHQBBgvY8Co4xmvzlxgLrGXZhr09z13H1I1FQWbLVhvG5X/6dqMn7aCnR+hmoJ8nqYju3oUY/7InZHGBvbdE5+lwUkJ8wHWgTTL3m7bAVosyMG8BfI6vJpxuXVCEWudB2q9i2Qq1su2QIHeYDNpAsaflpV/oWjn3x5fzN6KT12Ziz0kYIuCZjfjyj8uQ==
Received: from DU2PR04CA0159.eurprd04.prod.outlook.com (2603:10a6:10:2b0::14)
 by PA1PR04MB10747.eurprd04.prod.outlook.com (2603:10a6:102:48a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:59:09 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:2b0:cafe::96) by DU2PR04CA0159.outlook.office365.com
 (2603:10a6:10:2b0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 06:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solid-run.com;dmarc=pass action=none header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 3 Aug 2026 06:59:08 +0000
Received: from emails-3423392-12-mt-prod-cp-eu-2.checkpointcloudsec.com
 (ip-10-20-6-106.eu-west-1.compute.internal [10.20.6.106])
 by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with
 ESMTPS id C605C80731; Mon,  3 Aug 2026 06:59:08 +0000 (UTC)
X-Mailbox-Line: From b'jon@solid-run.com' Mon Aug  3 06:58:59 2026
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1785740348;
 b=FhumG+4n4T7tkE9ajFeUdaFKGo1QS5ttNFmZN6qnM4niFRmzYdFhIoVtbSwx2VXiF3ESz
 tflNaFBQf37UiyPvc4KlQtYaJP0F26uYj8cFuJNu4m2Hlsy/k1o8dquXrgMfVUdQ0IIiLAN
 9h+sBKGSbsZN/cFczneBOjiQEbWpKJ0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1785740348; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=Soj13AAwwv/KkdDe9NwQvE4rt4i8WLATNPgUwiiPNe0=;
 b=SYNhNW5P1FsAYhq7ZVe0xo4sCWgnZ+E3aYG3Wx6262FwGmVHEMDX01AO7vdOBDAtKPyAZ
 xYrDW1AJZwtQlUgytWVEkHNFx6tWsu3ij2bJlatW8trU5NRbm1zZqay/mq3RSQ11w01ZBF8
 w5buVV5gGKkEe5ij9h4YCINWk+ReP5w=
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solid-run.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Soj13AAwwv/KkdDe9NwQvE4rt4i8WLATNPgUwiiPNe0=;
 b=Z3qX3QA4nQPtgvmIpLA4jG81hnG9mJhRYO9Ey+CQGaW17lgxT1yJF0VPWSopJJXiD5ZFQ046ZnYKrQkxojOkB+ysWKsd7Ubu5H13/Pu+O1iVmG7jGKfWx3Y+5fCXaU3acg/+qi8ZI5zZs5pw/hdyUXZQ9slHQBBgvY8Co4xmvzlxgLrGXZhr09z13H1I1FQWbLVhvG5X/6dqMn7aCnR+hmoJ8nqYju3oUY/7InZHGBvbdE5+lwUkJ8wHWgTTL3m7bAVosyMG8BfI6vJpxuXVCEWudB2q9i2Qq1su2QIHeYDNpAsaflpV/oWjn3x5fzN6KT12Ziz0kYIuCZjfjyj8uQ==
Received: from DB8PR04MB7082.eurprd04.prod.outlook.com (2603:10a6:10:129::21)
 by PA4PR04MB7886.eurprd04.prod.outlook.com (2603:10a6:102:c1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 06:58:57 +0000
Received: from DB8PR04MB7082.eurprd04.prod.outlook.com
 ([fe80::af44:86c5:f59b:4d39]) by DB8PR04MB7082.eurprd04.prod.outlook.com
 ([fe80::af44:86c5:f59b:4d39%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 06:58:57 +0000
From: Jon Nettleton <jon@solid-run.com>
To: Liz Fong-Jones <lizf@honeycomb.io>, Bjorn Helgaas <helgaas@kernel.org>
CC: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, Jon Nettleton <jon.nettleton@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Thread-Topic: [PATCH v2] PCI: Fix BAR resize for devices on a root bus
Thread-Index: AQHdEkhp/vWPxDCUu0GxdsyhCAICALaH+9SugAQI4Hk=
Date: Mon, 3 Aug 2026 06:58:57 +0000
Message-ID: <DB8PR04MB70829183F401E9A4E70F327FE7D52@DB8PR04MB7082.eurprd04.prod.outlook.com>
References: <20260712-pci-rebar-root-bus-v2-1-a1b9107a82dc@honeycomb.io>
 <20260731162424.GA1571989@bhelgaas>
 <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
In-Reply-To: <CAC0H+B-p5MT4M03MMkbxr_dLjsuThkxPv3--Ciant0i2MvvqDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic: DB8PR04MB7082:EE_|PA4PR04MB7886:EE_|DB1PEPF000509EB:EE_|PA1PR04MB10747:EE_
X-MS-Office365-Filtering-Correlation-Id: cba282dc-5d73-4949-7f72-08def12cb74c
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|38070700021|56012099006|4143699003|10067099003|8096899003|13003099007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: G7Uq2VvNl6ikOhsPJs1MCdCguZdYdReF2Oa4x0qWbabavHm6cAxG6aregA2VLuDCj7SRMSObY6LvGiKmVmqx4BTUKFJOeL6O2rcSpNveRPIdMCXlgpeQisJQChWi/JaHTD+Km5A55T/cC85Z+5nqc5iIX7WCnjehpipRyiRu6QO6k53UpL/OLa0xT7owNmZIqp3/7MpSiG6ZspmmKKNYrGG/+f2JyN8xWfTPSCgVCTbPX+w69HEp7G2ozzSxQ1FylTVFpnTf3nuQ3eLGmEzEBdEQ2Wh5mZu3tdlYNsjrl/tBFJw9u9iJPaTfQy475OThRJbv6l80qKMK53KK5KpVoq4aLhII+PQedplB7R/PmQw2ez07OLC2h9M/rla5twR+eyjJLtmmM2Bvw9yF7CO/ayzgRyEUlz7iKWJiRarBd9ZcbY5DnVOmUDluezc406kpmCU7hN9GKoFl6/69fxbf0m8sGwoaoWpS/HZTqNCWSYclpdD7PkID4IdgeFrNOWKgqMO1w3mcF/tE19W4BexwrYtrry86anpAgMYNU9yUSbM8tXfSh6kK7qCn9tPCbnIa/h/LYvdQzuHgVsVt8dSxboqqbtMaggbhEShl7QDG75GHaRH1oqiG1UcJmWdJmLpWCum8PnR65q1svl4a6hZVlikLF3LTVOXvQ4eWxhBdUEQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB8PR04MB7082.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(38070700021)(56012099006)(4143699003)(10067099003)(8096899003)(13003099007)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
Content-Type: multipart/alternative;
 boundary="_000_DB8PR04MB70829183F401E9A4E70F327FE7D52DB8PR04MB7082eurp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jrAEPK5fy96wipc+vgvcJYgKl7C2elZ8y1EB2C25G7Ay3Oc76xGuOCm61X8UBClTm1V5x5lPFyNwaWKk9agEbfBlBADGSePcvy0nBLTGPOCKg6+wL1CLauZFE1Z6XrkG+iKgeEsd+IGXS37gLxTlysfBf5etIi5EBA9ZOoIxcosTNmYLHmJAodnA2a529N+Pgo/aXbemyQLsKn83XDjsIERNI0xDg/N2N2FAfn8RYRsOj2ALMaPjPr9v4WyGULwWXEBANwgKjIrKZu66UbPGJjeWo+1lb1Yx9VU0i7rGsNok09iSm8hpiWkl4OQ5PdN197FupKlo2D3EtzQRAHXokA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7886
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 659852ddefa44d78a67277b4b7ddf74c:solidrun,
 office365_emails, sent, inline:9bffc8e0e174253a6da090854d8b1df4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMZGbvEsRHogkcQhhtg4t758wuEdUSQ7lT9AHt52jXuUtREVNWhWsaaqANQ9ZmxVVQIDDYjB56DbcXRK7knUMv8ANFBosYy4VlyQN0MhWC/JjubMD+Q3i6m8PO+jg0t3QH92vkf0ISRrtWANynyGPoRPW2JCHq9qSYqx/wnC6OY5bePCX+oc79mipLN757e+zEb9zWRlWrJL2WkC4+nwYrj+LKph4bJejPzUP+IcxsE62t7oCuZ7bpUmj8U0JUKdCQQV49QnjYPwArdD6FLhUyMaTgbMkwOgPzCSbz/yh2TCIR5/80iLxu96SZbk8rijv3DL53QVQiYB1QVBcY7aMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Soj13AAwwv/KkdDe9NwQvE4rt4i8WLATNPgUwiiPNe0=;
 b=TADyLSCCLBJGczpPJshlhn3DeVXTh/3qEbD3UB1zba6Hry5TkIHCAe4JkJkXW1Sh72EYTKVM1Ws3WJozfUV+dqscnXsZ97up04kUOP9zgRFJyoeXsSxYzaKj/UPmsfO1cJpsUzaefcvy1MaEbkceMRRt8dhtz7HWDMmR8Zw8M1GARd2ntFq8LPxe/vTrVyXVTzIibPPXR7UDPUJy+4ylrlSCvpqQHXitHbzlzUUeERbO7KMPIYKcrdR4zBElVUClrG3If3ceQQvLkwcs4lxJ3OLYhJ4CSItcJ6xFWhdrnYvt6PUbGCDmriSHtUZjHz8580C6B7ROn1bNSDMuoaq/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e1253c1c-9ace-406f-2d99-08def12cb050
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|35042699022|82310400026|1800799024|23010399003|36860700016|14060799003|22082099003|18002099003|13003099007|6133799003|8096899003|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: Up1W8TOpTqUjjpJ0pmJoZNpEMg+9W4HVKeYhOOyI+SzYLZ8wkzvZByRqJlGM3/MJsVENEIALwpF6+Bbn2k4PxsdsSeQrbP+rwTtiecjAWHT+JnPsbf9GsrsbVvOineVwbMsaHuCxYpKzRESz4v8kLnv3girCU1FRMNVxJ7IHumBxkZB0PObjSkHr374h3lCzjpY6GIFg8B2HyGynPQur6QpdqVNKXHmTnBw44YpvVrBTdsSaLQsJcDUk7819+da/uvPSlmSRsxwoagSasaeNESgCjtt5Gm4XvzREwGHqWPvFWLzGxFfvXFiDahUxWIPu/8XIUOoBO3xLgyGb1xtIGGOlt3UiFWONMU9QR0dGtjB4SQR4rVr5JK/WDc4BR0h77ElEJz5v7mIxsppf8yk7Ypmisrn4HmCl1Nj2Ga4E220oQjL5xGED/TPq5FqDo6bzAmH/IuuFF5QTfIeFwPzEmFz4o53X1ylQUU2AgH38hxPiiaGvqIFK3F2JHczLN/PnHCJ2bj+O29FyCjho4maPOV75poOTp+Qogl/WjONbVw9uUbx6Wll/1jMaBmXYkDyzINGAqgJc2wjJJmbQwLr4qjWg8zqIykWO/oVTlzR3lHhJOxP+tiJOW2sI4zX2IcYz8YidckldCTFcFqKRTWFFVw==
X-Forefront-Antispam-Report: CIP:52.17.62.50; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:eu-dlp.cloud-sec-av.com; PTR:eu-dlp.cloud-sec-av.com;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(35042699022)(82310400026)(1800799024)(23010399003)(36860700016)(14060799003)(22082099003)(18002099003)(13003099007)(6133799003)(8096899003)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: enxE2ULTp5qDTSRGnp4KEeY0RIeY94MqakmJEAcvOe8nErMut/DRsDrWT66UHhvBy/iKs1jCa2tBjLD2Oql9T8rGYcQB0bIK4oLdliZSnUhpWi7NCTxt8t4M0JRxcBGkGDg75Ys5jrJP/JRLbNLC47iyxB89A418k+yG6wopop9SqatqrhqOEnbBfUzugkniNMvv4PBPyELNMxX+/q4JECXc9Z1HzzO44nQICyUEf4+OMGrSmDn7gFnpUSzV4Pvsd7oRyZoo57fY/8fvFDOA0h7XQb2M8+OBwAoG3HIgC1YYZBgFZEc1bZykZZax3kIIGsifDQHxsKvUb8D5yTlg7LZHD4IfzZMpCG4Qqo78lx3TI1MGU4Was/v2MlTEHCoaR+u5Z7VC14XW+phNItygUg2b/6ax7g8tNcDBroQL0gltDviyX/wadrfj/gOhLW+V
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 06:59:08.8847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cba282dc-5d73-4949-7f72-08def12cb74c
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82; Ip=[52.17.62.50];
 Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10747
X-Mailman-Approved-At: Mon, 03 Aug 2026 07:33:25 +0000
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

--_000_DB8PR04MB70829183F401E9A4E70F327FE7D52DB8PR04MB7082eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpNYXliZSB0aGlzIGlzIGEgdGFuZ2VudCwgYnV0IEknbSBjdXJpb3VzIGFib3V0IHRoaXMgdG9w
b2xvZ3kuICBJcyB0aGlzDQpydW5uaW5nIGFzIGEgdmlydHVhbGl6ZWQgZ3Vlc3Q/ICBBdCB0aGUg
aGFyZHdhcmUgbGV2ZWwsIGEgUENJZQ0KZW5kcG9pbnQgbXVzdCBoYXZlIGEgUm9vdCBQb3J0IHNv
bWV3aGVyZSwgZXZlbiBpZiBpdCBpc24ndCB2aXNpYmxlIHRvDQp0aGUgT1MgKGFzIGlzIG9mdGVu
IHRoZSBjYXNlIGluIHZpcnR1YWxpemVkIGd1ZXN0cykuDQpEZWZlciB0byBKb24gb24gd2hhdCB0
aGUgYWN0dWFsIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24gaXMsIGJ1dCB0aGlzIGlzDQpwaHlzaWNh
bCBoYXJkd2FyZSwgbm8gdmlydHVhbGlzYXRpb24sIHJ1bm5pbmcgYXMgdGhlIFVFRkkgcmF0aGVy
IHRoYW4gVS1Cb290DQooZGV2aWNldHJlZSkgdmFyaWFudC4gU2VlOg0KaHR0cHM6Ly9kZXYuc29s
aWQtcnVuLmNvbS9ueHAvbHgyMTYwYS9jb20tc29tL2x4MjE2MGEtY29tLWhhcmR3YXJlLXVzZXIt
bWFudWFsI2Jsb2NrLWRpYWdyYW0NCg0KVGhlIG1haW4gcXVpcmsgd2l0aCB0aGUgaGFyZHdhcmUg
dG9wb2xvZ3kgaXMgdGhhdCB0aGUgcm9vdCBwb3J0J3MgYWRkcmVzcyBzcGFjZSBpcyBvdXRzaWRl
IG9mIHRoZSBFQ0FNIGFkZHJlc3Mgc3BhY2UgdXNlZCBmb3IgdGhlIGRldmljZXMgYmVsb3cgaXQu
IEZvciBBcm0gU3lzdGVtUmVhZHkgY29tcGxpYW5jZSwgYW5kIHRvIGFsbG93IGRpc3Ryb3MgdG8g
Ym9vdCBvdXQgb2YgdGhlIGJveCB0aGUgb25seSBvcHRpb24gd2FzIHRvIG9ubHkgZXhwb3NlIHRo
ZSBkZXZpY2VzIG9uIHRoZSBidXMgYW5kIGNvbmZpZ3VyZSB0aGUgcm9vdCBwb3J0IGluIHRoZSBm
aXJtd2FyZS4gVGhpcyB3YXMgbm90IG91ciBmaXJzdCBjaG9pY2UgYnV0IGF0IHRoZSB0aW1lIHF1
aXJrcyBmb3IgdGhlIFBDSWUgQUNQSSBzZXR1cCB3ZXJlIG5vIGxvbmdlciBiZWluZyBhY2NlcHRl
ZCBpbiBtYWlubGluZS4NCg0KSSB3b3VsZCBiZSBoYXBweSB0byByZXN1cnJlY3QgdGhlIEFDUEkg
cXVpcmsgcGF0Y2ggbmVlZGVkIHNvIHRoZSBidXMgd291bGQgbG9vayBtb3JlIG5vcm1hbCBpZiB0
aGF0IHdvdWxkIGJlIGFjY2VwdGVkIG5vdy4NCg0KLUpvbg0KDQoNCkxpeg0KLS0tDQrwn5Cd8J+N
r/CfkJ0gTGl6IEZvbmctSm9uZXMsIE1BQ1MgKFNucikgQ1AsIFRlY2huaWNhbCBGZWxsb3cg8J+N
r/CfkJ3wn42vDQpob25leWNvbWIuaW88aHR0cDovL2hvbmV5Y29tYi5pby8+IC0gVGhlIG9ic2Vy
dmFiaWxpdHkgcGxhdGZvcm0gZm9yIHRlYW1zIHdobyBtYW5hZ2Ugc29mdHdhcmUgdGhhdCBtYXR0
ZXJzLg0KbGl6dGhlZ3JleS5jb208aHR0cDovL2xpenRoZWdyZXkuY29tLz4gLy8gbGlua2VkaW4u
Y29tL2luL2Vmb25nPGh0dHA6Ly9saW5rZWRpbi5jb20vaW4vZWZvbmc+IC8vIGJza3kuYXBwL3By
b2ZpbGUvbGl6dGhlZ3JleS5jb208aHR0cDovL2Jza3kuYXBwL3Byb2ZpbGUvbGl6dGhlZ3JleS5j
b20+DQo=

--_000_DB8PR04MB70829183F401E9A4E70F327FE7D52DB8PR04MB7082eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiBB
cHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBI
ZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAw
KTsiPg0KPGJyPg0KPC9kaXY+DQo8YmxvY2txdW90ZSBzdHlsZT0ibWFyZ2luOiAwcHggMHB4IDBw
eCAwLjhleDsgcGFkZGluZy1sZWZ0OiAxZXg7IGJvcmRlci1sZWZ0OiAxcHggc29saWQgcmdiKDIw
NCwgMjA0LCAyMDQpOyI+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsiPk1heWJlIHRoaXMg
aXMgYSB0YW5nZW50LCBidXQgSSdtIGN1cmlvdXMgYWJvdXQgdGhpcyB0b3BvbG9neS4mbmJzcDsg
SXMgdGhpczxicj4NCnJ1bm5pbmcgYXMgYSB2aXJ0dWFsaXplZCBndWVzdD8mbmJzcDsgQXQgdGhl
IGhhcmR3YXJlIGxldmVsLCBhIFBDSWU8YnI+DQplbmRwb2ludCBtdXN0IGhhdmUgYSBSb290IFBv
cnQgc29tZXdoZXJlLCBldmVuIGlmIGl0IGlzbid0IHZpc2libGUgdG88YnI+DQp0aGUgT1MgKGFz
IGlzIG9mdGVuIHRoZSBjYXNlIGluIHZpcnR1YWxpemVkIGd1ZXN0cykuPC9kaXY+DQo8L2Jsb2Nr
cXVvdGU+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsiPkRlZmVyIHRvIEpvbiBvbiB3aGF0
IHRoZSBhY3R1YWwgaGFyZHdhcmUgY29uZmlndXJhdGlvbiBpcywgYnV0IHRoaXMgaXM8L2Rpdj4N
CjxkaXYgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyI+cGh5c2ljYWwgaGFyZHdhcmUsIG5vIHZpcnR1
YWxpc2F0aW9uLCBydW5uaW5nIGFzIHRoZSBVRUZJIHJhdGhlciB0aGFuIFUtQm9vdDwvZGl2Pg0K
PGRpdiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7Ij4oZGV2aWNldHJlZSkgdmFyaWFudC4gU2VlOjwv
ZGl2Pg0KPGRpdiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7Ij48YSBocmVmPSJodHRwczovL2Rldi5z
b2xpZC1ydW4uY29tL254cC9seDIxNjBhL2NvbS1zb20vbHgyMTYwYSIgaWQ9Ik9XQTQ0YzgxODc2
LTM5ODctZTU3Zi02NDdkLWU3YjU4NTYyMTU5YiIgY2xhc3M9Ik9XQUF1dG9MaW5rIiBkYXRhLWF1
dGg9Ik5vdEFwcGxpY2FibGUiPmh0dHBzOi8vZGV2LnNvbGlkLXJ1bi5jb20vbnhwL2x4MjE2MGEv
Y29tLXNvbS9seDIxNjBhPC9hPi1jb20taGFyZHdhcmUtdXNlci1tYW51YWwjYmxvY2stZGlhZ3Jh
bTwvZGl2Pg0KPGRpdiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7Ij48YnI+DQo8L2Rpdj4NCjxkaXYg
Y2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtZmFtaWx5
OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJp
LCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAw
LCAwKTsiPg0KVGhlIG1haW4gcXVpcmsgd2l0aCB0aGUgaGFyZHdhcmUgdG9wb2xvZ3kgaXMgdGhh
dCB0aGUgcm9vdCBwb3J0J3MgYWRkcmVzcyBzcGFjZSBpcyBvdXRzaWRlIG9mIHRoZSBFQ0FNIGFk
ZHJlc3Mgc3BhY2UgdXNlZCBmb3IgdGhlIGRldmljZXMgYmVsb3cgaXQuIEZvciBBcm0gU3lzdGVt
UmVhZHkgY29tcGxpYW5jZSwgYW5kIHRvIGFsbG93IGRpc3Ryb3MgdG8gYm9vdCBvdXQgb2YgdGhl
IGJveCB0aGUgb25seSBvcHRpb24gd2FzIHRvIG9ubHkgZXhwb3NlDQogdGhlIGRldmljZXMgb24g
dGhlIGJ1cyBhbmQgY29uZmlndXJlIHRoZSByb290IHBvcnQgaW4gdGhlIGZpcm13YXJlLiBUaGlz
IHdhcyBub3Qgb3VyIGZpcnN0IGNob2ljZSBidXQgYXQgdGhlIHRpbWUgcXVpcmtzIGZvciB0aGUg
UENJZSBBQ1BJIHNldHVwIHdlcmUgbm8gbG9uZ2VyIGJlaW5nIGFjY2VwdGVkIGluIG1haW5saW5l
LiZuYnNwOzwvZGl2Pg0KPGRpdiBjbGFzcz0iZWxlbWVudFRvUHJvb2YiIHN0eWxlPSJkaXJlY3Rp
b246IGx0cjsgZm9udC1mYW1pbHk6IEFwdG9zLCBBcHRvc19FbWJlZGRlZEZvbnQsIEFwdG9zX01T
Rm9udFNlcnZpY2UsIENhbGlicmksIEhlbHZldGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAx
MnB0OyBjb2xvcjogcmdiKDAsIDAsIDApOyI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYgY2xhc3M9ImVs
ZW1lbnRUb1Byb29mIiBzdHlsZT0iZGlyZWN0aW9uOiBsdHI7IGZvbnQtZmFtaWx5OiBBcHRvcywg
QXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19NU0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRp
Y2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0K
SSB3b3VsZCBiZSBoYXBweSB0byByZXN1cnJlY3QgdGhlIEFDUEkgcXVpcmsgcGF0Y2ggbmVlZGVk
IHNvIHRoZSBidXMgd291bGQgbG9vayBtb3JlIG5vcm1hbCBpZiB0aGF0IHdvdWxkIGJlIGFjY2Vw
dGVkIG5vdy48L2Rpdj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0iZGlyZWN0
aW9uOiBsdHI7IGZvbnQtZmFtaWx5OiBBcHRvcywgQXB0b3NfRW1iZWRkZWRGb250LCBBcHRvc19N
U0ZvbnRTZXJ2aWNlLCBDYWxpYnJpLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTog
MTJwdDsgY29sb3I6IHJnYigwLCAwLCAwKTsiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJl
bGVtZW50VG9Qcm9vZiIgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyBmb250LWZhbWlseTogQXB0b3Ms
IEFwdG9zX0VtYmVkZGVkRm9udCwgQXB0b3NfTVNGb250U2VydmljZSwgQ2FsaWJyaSwgSGVsdmV0
aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IGNvbG9yOiByZ2IoMCwgMCwgMCk7Ij4N
Ci1Kb248L2Rpdj4NCjxkaXYgc3R5bGU9ImRpcmVjdGlvbjogbHRyOyI+PGJyPg0KPC9kaXY+DQo8
ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsiPjxicj4NCjwvZGl2Pg0KPGRpdiBzdHlsZT0iZGly
ZWN0aW9uOiBsdHI7Ij5MaXo8YnI+DQotLS08L2Rpdj4NCjxkaXYgc3R5bGU9ImRpcmVjdGlvbjog
bHRyOyI+8J+QnfCfja/wn5CdJm5ic3A7TGl6IEZvbmctSm9uZXMsIE1BQ1MgKFNucikgQ1AsIFRl
Y2huaWNhbCBGZWxsb3cmbmJzcDvwn42v8J+QnfCfja88L2Rpdj4NCjxkaXYgc3R5bGU9ImRpcmVj
dGlvbjogbHRyOyI+PGEgaHJlZj0iaHR0cDovL2hvbmV5Y29tYi5pby8iIGlkPSJPV0FmNmI2YTcw
My1hZDFiLTYxYmUtOTg4ZS0wN2E5OTczZTFiNjUiIGNsYXNzPSJPV0FBdXRvTGluayIgZGF0YS1h
dXRoPSJOb3RBcHBsaWNhYmxlIj5ob25leWNvbWIuaW88L2E+Jm5ic3A7LSBUaGUgb2JzZXJ2YWJp
bGl0eSBwbGF0Zm9ybSBmb3IgdGVhbXMgd2hvIG1hbmFnZSBzb2Z0d2FyZSB0aGF0IG1hdHRlcnMu
PC9kaXY+DQo8ZGl2IHN0eWxlPSJkaXJlY3Rpb246IGx0cjsiPjxhIGhyZWY9Imh0dHA6Ly9saXp0
aGVncmV5LmNvbS8iIGlkPSJPV0FmZjZjMGY2Yi1jMzU1LWRhZGYtMDBjMi1kZWIzMTFiNGNlMzIi
IGNsYXNzPSJPV0FBdXRvTGluayIgZGF0YS1hdXRoPSJOb3RBcHBsaWNhYmxlIj5saXp0aGVncmV5
LmNvbTwvYT4mbmJzcDsvLw0KPGEgaHJlZj0iaHR0cDovL2xpbmtlZGluLmNvbS9pbi9lZm9uZyIg
aWQ9Ik9XQTkxYjlkMDliLTg3MGEtZGExNS1lYTIxLWFhNjcyYWFiMjRhMyIgY2xhc3M9Ik9XQUF1
dG9MaW5rIiBkYXRhLWF1dGg9Ik5vdEFwcGxpY2FibGUiPg0KbGlua2VkaW4uY29tL2luL2Vmb25n
PC9hPiZuYnNwOy8vIDxhIGhyZWY9Imh0dHA6Ly9ic2t5LmFwcC9wcm9maWxlL2xpenRoZWdyZXku
Y29tIiBpZD0iT1dBMjZkNWYzNzktOTJlNy01ZmQxLTA4NjMtYmE4NTFhYTkzY2U5IiBjbGFzcz0i
T1dBQXV0b0xpbmsiIGRhdGEtYXV0aD0iTm90QXBwbGljYWJsZSI+DQpic2t5LmFwcC9wcm9maWxl
L2xpenRoZWdyZXkuY29tPC9hPjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_DB8PR04MB70829183F401E9A4E70F327FE7D52DB8PR04MB7082eurp_--
